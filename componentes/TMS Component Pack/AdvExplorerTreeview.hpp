// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advexplorertreeview.pas' rev: 21.00

#ifndef AdvexplorertreeviewHPP
#define AdvexplorertreeviewHPP

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
#include <Variants.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Rtlconsts.hpp>	// Pascal unit
#include <Comstrs.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advexplorertreeview
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS ETreeViewError;
class PASCALIMPLEMENTATION ETreeViewError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ETreeViewError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ETreeViewError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ETreeViewError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall ETreeViewError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ETreeViewError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ETreeViewError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ETreeViewError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ETreeViewError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ETreeViewError(void) { }
	
};


class DELPHICLASS TDropForm;
class DELPHICLASS TCustomExplorerTreeview;
class PASCALIMPLEMENTATION TDropForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	bool FSizeable;
	bool FDroppedDown;
	TCustomExplorerTreeview* FExplorerTreeview;
	HIDESBASE MESSAGE void __fastcall WMClose(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	HWND __fastcall GetParentWnd(void);
	DYNAMIC void __fastcall DoClose(Forms::TCloseAction &Action);
	
public:
	__fastcall virtual TDropForm(Classes::TComponent* AOwner);
	__fastcall virtual TDropForm(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TDropForm(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property TCustomExplorerTreeview* ExplorerTreeview = {read=FExplorerTreeview, write=FExplorerTreeview};
	__property bool Sizeable = {read=FSizeable, write=FSizeable, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDropForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TExplorerTreeviewListBox;
class PASCALIMPLEMENTATION TExplorerTreeviewListBox : public Stdctrls::TCustomListBox
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	TCustomExplorerTreeview* FExplorerTreeview;
	Classes::TNotifyEvent FOnSelect;
	bool FShowImages;
	bool FMouseInControl;
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	void __fastcall SetShowImages(const bool Value);
	
protected:
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetItemIndex(const int Value)/* overload */;
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall MoveSelect(int Offset);
	
public:
	__fastcall virtual TExplorerTreeviewListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TExplorerTreeviewListBox(void);
	DYNAMIC void __fastcall Click(void);
	__property TCustomExplorerTreeview* ExplorerTreeview = {read=FExplorerTreeview, write=FExplorerTreeview};
	__property bool ShowImages = {read=FShowImages, write=SetShowImages, default=1};
	__property Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
public:
	/* TWinControl.CreateParented */ inline __fastcall TExplorerTreeviewListBox(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	
};


class DELPHICLASS TDropDownButton;
class PASCALIMPLEMENTATION TDropDownButton : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	bool FHot;
	bool FDown;
	TCustomExplorerTreeview* FExplorerTreeview;
	Graphics::TBitmap* FGlyph;
	int FImageIndex;
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	void __fastcall OnGlyphChanged(System::TObject* Sender);
	void __fastcall SetGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetDown(const bool Value);
	void __fastcall setImageIndex(const int Value);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	void __fastcall DrawButton(void);
	bool __fastcall IsActive(void);
	__property bool Down = {read=FDown, write=SetDown, nodefault};
	
public:
	__fastcall virtual TDropDownButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TDropDownButton(void);
	DYNAMIC void __fastcall Click(void);
	__property TCustomExplorerTreeview* ExplorerTreeview = {read=FExplorerTreeview};
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property int ImageIndex = {read=FImageIndex, write=setImageIndex, default=-1};
};


class DELPHICLASS TLeftIcon;
class PASCALIMPLEMENTATION TLeftIcon : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	TCustomExplorerTreeview* FExplorerTreeview;
	Graphics::TBitmap* FGlyph;
	void __fastcall OnGlyphChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	void __fastcall SetGlyph(const Graphics::TBitmap* Value);
	
protected:
	virtual void __fastcall Paint(void);
	void __fastcall DrawIcon(void);
	
public:
	__fastcall virtual TLeftIcon(Classes::TComponent* AOwner);
	__fastcall virtual ~TLeftIcon(void);
	__property TCustomExplorerTreeview* ExplorerTreeview = {read=FExplorerTreeview};
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
};


class DELPHICLASS TNodeButton;
class DELPHICLASS TAdvTreeNode;
class PASCALIMPLEMENTATION TNodeButton : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	bool FHot;
	bool FDown;
	bool FDwBtnHot;
	TCustomExplorerTreeview* FExplorerTreeview;
	Graphics::TBitmap* FGlyph;
	TAdvTreeNode* FNode;
	bool FScrollButton;
	int FOffsetX;
	bool FShowText;
	bool FInternalClick;
	void __fastcall OnMenuItemClick(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	void __fastcall SetGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetNode(const TAdvTreeNode* Value);
	void __fastcall SetDown(const bool Value);
	void __fastcall SetScrollButton(const bool Value);
	void __fastcall SetShowText(const bool Value);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	void __fastcall DrawButton(void);
	void __fastcall UpdateSize(void);
	void __fastcall ButtonClick(void);
	void __fastcall DropDownPress(void);
	bool __fastcall IsSplitButton(void);
	bool __fastcall IsActive(void);
	int __fastcall GetIndex(void);
	
public:
	__fastcall virtual TNodeButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TNodeButton(void);
	DYNAMIC void __fastcall Click(void);
	__property TCustomExplorerTreeview* ExplorerTreeview = {read=FExplorerTreeview};
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property TAdvTreeNode* Node = {read=FNode, write=SetNode};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property bool ScrollButton = {read=FScrollButton, write=SetScrollButton, default=0};
	__property bool ShowText = {read=FShowText, write=SetShowText, default=1};
};


class DELPHICLASS TDbgList;
class PASCALIMPLEMENTATION TDbgList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	TAdvTreeNode* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvTreeNode* __fastcall GetItemsEx(int Index);
	void __fastcall SetItemsEx(int Index, const TAdvTreeNode* Value);
	
public:
	void __fastcall AssignList(Classes::TList* ListA);
	__property TAdvTreeNode* Items[int Index] = {read=GetItemsEx, write=SetItemsEx/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TDbgList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TDbgList(void) : Classes::TList() { }
	
};


#pragma option push -b-
enum TAdvExplorerTreeviewMode { aeCustom, aeSystem, aeFolder };
#pragma option pop

#pragma option push -b-
enum TBaseNode { bnDesktop, bnFolder };
#pragma option pop

struct TNodeInfo;
typedef TNodeInfo *PNodeInfo;

#pragma pack(push,1)
struct TNodeInfo
{
	
public:
	int ImageIndex;
	int SelectedIndex;
	int StateIndex;
	int OverlayIndex;
	void *Data;
	int Count;
	SmallString<255>  Text;
};
#pragma pack(pop)


#pragma pack(push,1)
struct TNodeDataInfo
{
	
public:
	int ImageIndex;
	int SelectedIndex;
	int StateIndex;
	int OverlayIndex;
	void *Data;
	int Count;
	System::Byte TextLen;
};
#pragma pack(pop)


typedef TMetaClass* TAdvTreeNodeClass;

class DELPHICLASS TAdvTreeNodes;
class PASCALIMPLEMENTATION TAdvTreeNode : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
public:
	TAdvTreeNode* operator[](int Index) { return Item[Index]; }
	
private:
	TAdvTreeNodes* FOwner;
	System::UnicodeString FText;
	System::TObject* FData;
	Imglist::TImageIndex FImageIndex;
	bool FDeleting;
	TAdvTreeNode* FFirstChild;
	TAdvTreeNode* FNextSibling;
	TAdvTreeNode* FPrevSibling;
	TAdvTreeNode* FParentNode;
	TNodeButton* FNodeButton;
	bool FShowText;
	bool FVirtualParent;
	int __fastcall GetLevel(void);
	TAdvTreeNode* __fastcall GetParent(void);
	int __fastcall GetIndex(void);
	TAdvTreeNode* __fastcall GetItem(int Index);
	int __fastcall GetCount(void);
	TCustomExplorerTreeview* __fastcall GetTreeView(void);
	bool __fastcall IsEqual(TAdvTreeNode* Node);
	void __fastcall SetData(System::TObject* Value);
	void __fastcall SetItem(int Index, TAdvTreeNode* Value);
	void __fastcall SetImageIndex(Imglist::TImageIndex Value);
	void __fastcall SetText(const System::UnicodeString S);
	bool __fastcall GetHasChildren(void);
	void __fastcall SetNodeButton(const TNodeButton* Value);
	void __fastcall SetShowText(const bool Value);
	void __fastcall SetVirtualParent(const bool Value);
	void __fastcall ReadData(Classes::TStream* Stream, PNodeInfo Info);
	void __fastcall WriteData(Classes::TStream* Stream, PNodeInfo Info);
	
protected:
	bool __fastcall CompareCount(int CompareMe);
	int __fastcall IndexOf(TAdvTreeNode* Value);
	__property int Count = {read=GetCount, nodefault};
	__property int Index = {read=GetIndex, nodefault};
	__property TAdvTreeNode* Item[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TNodeButton* Button = {read=FNodeButton, write=SetNodeButton};
	__property TCustomExplorerTreeview* TreeView = {read=GetTreeView};
	__property TAdvTreeNodes* Owner = {read=FOwner};
	
public:
	__fastcall TAdvTreeNode(TAdvTreeNodes* AOwner);
	__fastcall virtual ~TAdvTreeNode(void);
	TAdvTreeNode* __fastcall AddFirstChild(const System::UnicodeString S)/* overload */;
	TAdvTreeNode* __fastcall AddFirstChild(System::TObject* Data, const System::UnicodeString S)/* overload */;
	TAdvTreeNode* __fastcall AddChild(const System::UnicodeString S)/* overload */;
	TAdvTreeNode* __fastcall AddChild(System::TObject* Data, const System::UnicodeString S)/* overload */;
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Delete(void);
	void __fastcall DeleteChildren(void);
	TAdvTreeNode* __fastcall getFirstChild(void);
	TAdvTreeNode* __fastcall GetLastChild(void);
	TAdvTreeNode* __fastcall GetNextChild(TAdvTreeNode* Value);
	TAdvTreeNode* __fastcall getNextSibling(void);
	TAdvTreeNode* __fastcall GetPrevChild(TAdvTreeNode* Value);
	TAdvTreeNode* __fastcall getPrevSibling(void);
	bool __fastcall HasAsParent(TAdvTreeNode* Value);
	bool __fastcall IsFirstNode(void);
	bool __fastcall IsFirstChild(void);
	__property bool Deleting = {read=FDeleting, nodefault};
	__property bool HasChildren = {read=GetHasChildren, nodefault};
	__property int Level = {read=GetLevel, nodefault};
	__property TAdvTreeNode* Parent = {read=GetParent};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property System::TObject* Data = {read=FData, write=SetData};
	__property Imglist::TImageIndex ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property bool ShowText = {read=FShowText, write=SetShowText, default=1};
	__property bool VirtualParent = {read=FVirtualParent, write=SetVirtualParent, default=0};
};


class PASCALIMPLEMENTATION TAdvTreeNodes : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
public:
	TAdvTreeNode* operator[](int Index) { return Item[Index]; }
	
private:
	TCustomExplorerTreeview* FOwner;
	TAdvTreeNode* FFirstNode;
	TDbgList* FNodeList;
	bool FDeleting;
	bool FReading;
	TAdvTreeNode* __fastcall GetNodeFromIndex(int Index);
	void __fastcall ReadData(Classes::TStream* Stream);
	void __fastcall WriteData(Classes::TStream* Stream);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall SetItem(int Index, TAdvTreeNode* Value);
	int __fastcall GetCount(void);
	TAdvTreeNode* __fastcall InsertNode(TAdvTreeNode* ParentNode, TAdvTreeNode* DesNode, bool InsertBefore);
	bool __fastcall IsVeryFirstNode(TAdvTreeNode* Node);
	__property bool Reading = {read=FReading, nodefault};
	
public:
	__fastcall TAdvTreeNodes(TCustomExplorerTreeview* AOwner);
	__fastcall virtual ~TAdvTreeNodes(void);
	TAdvTreeNode* __fastcall AddFirst(const System::UnicodeString S)/* overload */;
	TAdvTreeNode* __fastcall AddFirst(System::TObject* Data, const System::UnicodeString S)/* overload */;
	TAdvTreeNode* __fastcall Add(const System::UnicodeString S)/* overload */;
	TAdvTreeNode* __fastcall Add(System::TObject* Data, const System::UnicodeString S)/* overload */;
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Clear(void);
	void __fastcall Delete(TAdvTreeNode* Node);
	TAdvTreeNode* __fastcall GetFirstNode(void);
	TAdvTreeNode* __fastcall GetLastNode(void);
	TAdvTreeNode* __fastcall Insert(TAdvTreeNode* Sibling, const System::UnicodeString S);
	TAdvTreeNode* __fastcall InsertObject(TAdvTreeNode* Sibling, const System::UnicodeString S, System::TObject* Data);
	__property int Count = {read=GetCount, nodefault};
	__property TAdvTreeNode* Item[int Index] = {read=GetNodeFromIndex/*, default*/};
	__property TCustomExplorerTreeview* Owner = {read=FOwner};
};


class DELPHICLASS TButtonAppearance;
class PASCALIMPLEMENTATION TButtonAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FBorderColorHot;
	Graphics::TColor FColorHot;
	Graphics::TColor FArrowColorHot;
	Graphics::TColor FColorMirrorHot;
	Graphics::TColor FColorMirrorHotTo;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FArrowColorDown;
	Graphics::TColor FColorDownTo;
	Graphics::TColor FColorDown;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FColorMirrorDownTo;
	Graphics::TColor FColorMirrorDown;
	Graphics::TColor FBorderColorDown;
	Graphics::TFont* FFont;
	Graphics::TColor FColorMirrorNodeHotTo;
	Graphics::TColor FBorderColorNodeHot;
	Graphics::TColor FColorNodeHot;
	Graphics::TColor FColorMirrorNodeHot;
	Graphics::TColor FColorNodeHotTo;
	void __fastcall OnFontChanged(System::TObject* Sender);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetColorDownTo(const Graphics::TColor Value);
	void __fastcall SetColorMirrorDown(const Graphics::TColor Value);
	void __fastcall SetColorMirrorDownTo(const Graphics::TColor Value);
	void __fastcall SetArrowColorDown(const Graphics::TColor Value);
	void __fastcall SetArrowColorHot(const Graphics::TColor Value);
	void __fastcall SetBorderColorDown(const Graphics::TColor Value);
	void __fastcall SetBorderColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHotTo(const Graphics::TColor Value);
	void __fastcall SetColorMirrorHot(const Graphics::TColor Value);
	void __fastcall SetColorMirrorHotTo(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetBorderColorNodeHot(const Graphics::TColor Value);
	void __fastcall SetColorMirrorNodeHot(const Graphics::TColor Value);
	void __fastcall SetColorMirrorNodeHotTo(const Graphics::TColor Value);
	void __fastcall SetColorNodeHot(const Graphics::TColor Value);
	void __fastcall SetColorNodeHotTo(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TButtonAppearance(void);
	__fastcall virtual ~TButtonAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor ArrowColorDown = {read=FArrowColorDown, write=SetArrowColorDown, default=0};
	__property Graphics::TColor ArrowColorHot = {read=FArrowColorHot, write=SetArrowColorHot, default=0};
	__property Graphics::TColor BorderColorDown = {read=FBorderColorDown, write=SetBorderColorDown, default=9134636};
	__property Graphics::TColor BorderColorHot = {read=FBorderColorHot, write=SetBorderColorHot, default=9132054};
	__property Graphics::TColor BorderColorNodeHot = {read=FBorderColorNodeHot, write=SetBorderColorNodeHot, default=9408398};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, default=16576996};
	__property Graphics::TColor ColorDownTo = {read=FColorDownTo, write=SetColorDownTo, default=16246729};
	__property Graphics::TColor ColorMirrorDown = {read=FColorMirrorDown, write=SetColorMirrorDown, default=15584915};
	__property Graphics::TColor ColorMirrorDownTo = {read=FColorMirrorDownTo, write=SetColorMirrorDownTo, default=14530157};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=SetColorHot, default=16510419};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=SetColorHotTo, default=16443847};
	__property Graphics::TColor ColorMirrorHot = {read=FColorMirrorHot, write=SetColorMirrorHot, default=16242844};
	__property Graphics::TColor ColorMirrorHotTo = {read=FColorMirrorHotTo, write=SetColorMirrorHotTo, default=16109705};
	__property Graphics::TColor ColorNodeHot = {read=FColorNodeHot, write=SetColorNodeHot, default=15921906};
	__property Graphics::TColor ColorNodeHotTo = {read=FColorNodeHotTo, write=SetColorNodeHotTo, default=15658734};
	__property Graphics::TColor ColorMirrorNodeHot = {read=FColorMirrorNodeHot, write=SetColorMirrorNodeHot, default=14277081};
	__property Graphics::TColor ColorMirrorNodeHotTo = {read=FColorMirrorNodeHotTo, write=SetColorMirrorNodeHotTo, default=13816530};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
};


class DELPHICLASS TExpTreeviewAppearance;
class PASCALIMPLEMENTATION TExpTreeviewAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FColor;
	Graphics::TColor FFocusColor;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FFocusOuterBorderColor;
	Graphics::TColor FInnerBorderColor;
	Graphics::TColor FOuterBorderColor;
	Graphics::TColor FFocusInnerBorderColor;
	TButtonAppearance* FButtonAppearance;
	Graphics::TColor FHotColor;
	Graphics::TColor FInnerMostBorderColor;
	void __fastcall OnButtonAppearanceChanged(System::TObject* Sender);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFocusColor(const Graphics::TColor Value);
	void __fastcall Changed(void);
	void __fastcall SetFocusInnerBorderColor(const Graphics::TColor Value);
	void __fastcall SetFocusOuterBorderColor(const Graphics::TColor Value);
	void __fastcall SetInnerBorderColor(const Graphics::TColor Value);
	void __fastcall SetOuterBorderColor(const Graphics::TColor Value);
	void __fastcall SetButtonAppearance(const TButtonAppearance* Value);
	void __fastcall SetHotColor(const Graphics::TColor Value);
	void __fastcall SetInnerMostBorderColor(const Graphics::TColor Value);
	
protected:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TExpTreeviewAppearance(void);
	__fastcall virtual ~TExpTreeviewAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TButtonAppearance* ButtonAppearance = {read=FButtonAppearance, write=SetButtonAppearance};
	__property Graphics::TColor OuterBorderColor = {read=FOuterBorderColor, write=SetOuterBorderColor, default=536870911};
	__property Graphics::TColor InnerBorderColor = {read=FInnerBorderColor, write=SetInnerBorderColor, default=12164479};
	__property Graphics::TColor InnerMostBorderColor = {read=FInnerMostBorderColor, write=SetInnerMostBorderColor, default=536870911};
	__property Graphics::TColor FocusOuterBorderColor = {read=FFocusOuterBorderColor, write=SetFocusOuterBorderColor, default=536870911};
	__property Graphics::TColor FocusInnerBorderColor = {read=FFocusInnerBorderColor, write=SetFocusInnerBorderColor, default=12164479};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=16445670};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, default=16777215};
	__property Graphics::TColor HotColor = {read=FHotColor, write=SetHotColor, default=16775668};
};


#pragma option push -b-
enum TEditStyle { esList, esEdit };
#pragma option pop

typedef void __fastcall (__closure *TNodeEvent)(System::TObject* Sender, TAdvTreeNode* Node);

typedef void __fastcall (__closure *TPopulateChildEvent)(System::TObject* Sender, TAdvTreeNode* ParentNode, System::UnicodeString Path, bool &PopulateAllowed);

class PASCALIMPLEMENTATION TCustomExplorerTreeview : public Stdctrls::TCustomEdit
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	TNodeEvent FOnAddition;
	TNodeEvent FOnDeletion;
	TAdvTreeNodes* FTreeNodes;
	Controls::TImageList* FImages;
	TAdvTreeNode* FSelectedNode;
	TAdvTreeNode* FOldSelected;
	bool FRefreshButton;
	TExpTreeviewAppearance* FAppearance;
	TDropDownButton* FDropDownButton;
	TDropDownButton* FRefreshBtn;
	bool FMouseInControl;
	bool FShowImage;
	TLeftIcon* FLeftIcon;
	TDropForm* FDropForm;
	TExplorerTreeviewListBox* FListBox;
	int FMaxDropHeight;
	TDropForm* FAutoComForm;
	TExplorerTreeviewListBox* FAutoComListBox;
	Classes::TList* FNodeButtons;
	Graphics::TBitmap* FRefreshGlyph;
	TDbgList* FDropDownList;
	System::UnicodeString FText;
	Extctrls::TTimer* FTimer;
	Classes::TNotifyEvent FOnRefreshClick;
	bool FCloseClick;
	bool FAutoComplete;
	Classes::TStringList* FAutoCompleteList;
	bool FEditorEnabled;
	Classes::TNotifyEvent FOnBeforeDropDown;
	TAdvExplorerTreeviewMode FMode;
	Classes::TNotifyEvent FOnShowEdit;
	Classes::TNotifyEvent FOnHideEdit;
	int FRefreshImageIndex;
	Controls::TImageList* FInternalImages;
	System::UnicodeString FFolderPath;
	TPopulateChildEvent FOnPopulateChildNode;
	TNodeEvent FOnSelect;
	bool FAutoDropDownFill;
	TAdvTreeNode* FMyComputerNode;
	int FUpdateCount;
	System::UnicodeString FNewSelectedFolderPath;
	bool FShowHiddenFolders;
	bool FEditMode;
	bool FIsInternal;
	bool FBufferedDraw;
	TEditStyle FEditStyle;
	bool FUpdateInternalText;
	bool FShowAutoCL;
	bool FAllowHook;
	bool FCaptureChangeCancels;
	void __fastcall OnLeftIconDblClick(System::TObject* Sender);
	void __fastcall OnLeftIconClick(System::TObject* Sender);
	void __fastcall OnRefreshBtnClick(System::TObject* Sender);
	void __fastcall OnDropDownBtnClick(System::TObject* Sender);
	void __fastcall OnDropDownBtnMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall OnAppearanceChanged(System::TObject* Sender);
	void __fastcall OnDropFormDeactivate(System::TObject* Sender);
	void __fastcall OnListBoxClick(System::TObject* Sender);
	void __fastcall OnListBoxSelect(System::TObject* Sender);
	void __fastcall OnListBoxKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall OnListBoxKeyKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall OnRefreshGlyphChanged(System::TObject* Sender);
	void __fastcall OnTimerTime(System::TObject* Sender);
	void __fastcall OnAutoCompFormDeactivate(System::TObject* Sender);
	void __fastcall OnAutoCompListBoxClick(System::TObject* Sender);
	void __fastcall OnAutoCompListBoxSelect(System::TObject* Sender);
	void __fastcall OnAutoCompListBoxKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall OnAutoCompListBoxKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMPaste(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMCut(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSysKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SeTAdvTreeNodes(const TAdvTreeNodes* Value);
	TAdvTreeNode* __fastcall GetSelectedNode(void);
	void __fastcall SetSelectedNode(const TAdvTreeNode* Value);
	void __fastcall SetRefreshButton(const bool Value);
	void __fastcall SetAppearance(const TExpTreeviewAppearance* Value);
	void __fastcall SetShowImage(const bool Value);
	int __fastcall GetDropDownCount(void);
	TAdvTreeNode* __fastcall GetDropDownList(int index);
	void __fastcall SetMaxDropHeight(const int Value);
	void __fastcall SetRefreshGlyph(const Graphics::TBitmap* Value);
	System::UnicodeString __fastcall GetTextEx(void);
	void __fastcall SetTextEx(const System::UnicodeString Value);
	void __fastcall SetAutoComplete(const bool Value);
	void __fastcall SetMode(const TAdvExplorerTreeviewMode Value);
	void __fastcall SetRefreshImageIndex(const int Value);
	Controls::TImageList* __fastcall GetCurrentImages(void);
	void __fastcall SetFolderPath(const System::UnicodeString Value);
	tagSIZE __fastcall GetIconSize(void);
	void __fastcall UpdateImage(void);
	void __fastcall SetAutoDropDownFill(const bool Value);
	void __fastcall SetEditorEnabled(const bool Value);
	void __fastcall SetEditMode(const bool Value);
	void __fastcall SetDirectText(System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall SetEditRect(void);
	virtual TAdvTreeNode* __fastcall CreateNode(void);
	virtual TAdvTreeNodes* __fastcall CreateNodes(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual Forms::TCustomForm* __fastcall GetParentForm(Controls::TControl* Control);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	void __fastcall InvalidateDropDownButton(void);
	DYNAMIC void __fastcall DoDelete(TAdvTreeNode* Node);
	DYNAMIC void __fastcall DoAdded(TAdvTreeNode* Node);
	void __fastcall UpdateNodeInAutoComList(TAdvTreeNode* Node);
	void __fastcall AddInAutoComList(TAdvTreeNode* Node);
	void __fastcall DeleteFromAutoComList(TAdvTreeNode* Node);
	void __fastcall ClickButton(TNodeButton* Button, bool RealClick = false);
	void __fastcall CancelMenu(void);
	bool __fastcall IsUpdating(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	int __fastcall GetMinHeight(void);
	void __fastcall AddWithChildrenToAutoCompleteList(TAdvTreeNode* Node);
	void __fastcall PopulateAutoCompListBox(void);
	void __fastcall ShowAutoCompList(void);
	void __fastcall HideAutoCompList(void);
	bool __fastcall IsDroppedDown(void);
	bool __fastcall IsMyNode(TAdvTreeNode* Node);
	void __fastcall UpdateNodeButtonsPositions(void);
	void __fastcall RemoveNodeButtons(void);
	void __fastcall GenerateNodeButtons(void);
	bool __fastcall IsFocused(void);
	void __fastcall PopulateListBox(void);
	void __fastcall ShowDropDownList(void);
	void __fastcall HideDropDownList(void);
	void __fastcall UpdateButtonsPosition(void);
	void __fastcall UpdateDropDownRefreshBtnsPos(void);
	void __fastcall UpdateLeftIconPos(void);
	int __fastcall GetBorderWidth(void);
	Types::TRect __fastcall GetNodeButtonsRect(void);
	Types::TRect __fastcall GetRefreshButtonRect(void);
	Types::TRect __fastcall GetDropDownButtonRect(void);
	Types::TRect __fastcall GetLeftIconRect(void);
	System::UnicodeString __fastcall GetHierarchicalNodeText(TAdvTreeNode* N, bool IncludeFolderPath = true);
	void __fastcall DrawBackGround(void);
	__property bool IsInternal = {read=FIsInternal, write=FIsInternal, nodefault};
	__property Controls::TImageList* CurrentImages = {read=GetCurrentImages};
	__property TExpTreeviewAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property Controls::TImageList* Images = {read=FImages, write=FImages};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TAdvTreeNodes* Items = {read=FTreeNodes, write=SeTAdvTreeNodes};
	__property bool RefreshButton = {read=FRefreshButton, write=SetRefreshButton, default=1};
	__property bool ShowImage = {read=FShowImage, write=SetShowImage, default=1};
	__property int MaxDropHeight = {read=FMaxDropHeight, write=SetMaxDropHeight, default=150};
	__property TAdvTreeNode* SelectedNode = {read=GetSelectedNode, write=SetSelectedNode};
	__property Graphics::TBitmap* RefreshGlyph = {read=FRefreshGlyph, write=SetRefreshGlyph};
	__property System::UnicodeString Text = {read=GetTextEx, write=SetTextEx};
	__property bool AutoComplete = {read=FAutoComplete, write=SetAutoComplete, default=1};
	__property bool EditorEnabled = {read=FEditorEnabled, write=SetEditorEnabled, default=0};
	__property TAdvExplorerTreeviewMode Mode = {read=FMode, write=SetMode, default=1};
	__property System::UnicodeString FolderPath = {read=FFolderPath, write=SetFolderPath};
	__property int RefreshImageIndex = {read=FRefreshImageIndex, write=SetRefreshImageIndex, default=-1};
	__property bool AutoDropDownFill = {read=FAutoDropDownFill, write=SetAutoDropDownFill, default=1};
	__property bool ShowHiddenFolders = {read=FShowHiddenFolders, write=FShowHiddenFolders, default=0};
	__property bool EditMode = {read=FEditMode, write=SetEditMode, nodefault};
	__property TEditStyle EditStyle = {read=FEditStyle, write=FEditStyle, default=0};
	__property bool AllowHook = {read=FAllowHook, write=FAllowHook, default=1};
	__property Classes::TNotifyEvent OnRefreshClick = {read=FOnRefreshClick, write=FOnRefreshClick};
	__property Classes::TNotifyEvent OnBeforeDropDown = {read=FOnBeforeDropDown, write=FOnBeforeDropDown};
	__property Classes::TNotifyEvent OnShowEdit = {read=FOnShowEdit, write=FOnShowEdit};
	__property Classes::TNotifyEvent OnHideEdit = {read=FOnHideEdit, write=FOnHideEdit};
	__property TPopulateChildEvent OnPopulateChildNode = {read=FOnPopulateChildNode, write=FOnPopulateChildNode};
	__property TNodeEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property TNodeEvent OnAddition = {read=FOnAddition, write=FOnAddition};
	__property TNodeEvent OnDeletion = {read=FOnDeletion, write=FOnDeletion};
	
public:
	__fastcall virtual TCustomExplorerTreeview(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomExplorerTreeview(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall LoadDirectoryStructure(TBaseNode BaseNode, System::UnicodeString path, bool ClearOldNodes);
	void __fastcall AddSubFolders(System::UnicodeString path, TAdvTreeNode* ParentNode);
	System::UnicodeString __fastcall GetNodePath(TAdvTreeNode* Node);
	void __fastcall RefreshSubFolders(TAdvTreeNode* ParentNode);
	virtual void __fastcall Clear(void);
	System::UnicodeString __fastcall GetSelectedFolder(void);
	void __fastcall SetSelectedFolder(System::UnicodeString Path, bool Immediately = true);
	void __fastcall PopulateAutoCompleteList(void);
	void __fastcall AddToDropDownList(TAdvTreeNode* Node);
	void __fastcall RemoveFromDropDownList(TAdvTreeNode* Node)/* overload */;
	void __fastcall RemoveFromDropDownList(int Index)/* overload */;
	void __fastcall ClearDropDownList(void);
	__property int DropDownListCount = {read=GetDropDownCount, nodefault};
	__property TAdvTreeNode* DropDownList[int index] = {read=GetDropDownList};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	__property bool BufferedDraw = {read=FBufferedDraw, write=FBufferedDraw, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomExplorerTreeview(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	
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


class DELPHICLASS TAdvExplorerTreeview;
class PASCALIMPLEMENTATION TAdvExplorerTreeview : public TCustomExplorerTreeview
{
	typedef TCustomExplorerTreeview inherited;
	
public:
	__property SelectedNode;
	__property Text;
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property Appearance;
	__property AutoComplete = {default=1};
	__property AutoDropDownFill = {default=1};
	__property EditorEnabled = {default=0};
	__property EditStyle = {default=0};
	__property Font;
	__property Height;
	__property Images;
	__property Items;
	__property MaxDropHeight = {default=150};
	__property MaxLength = {default=0};
	__property Mode = {default=1};
	__property FolderPath;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property RefreshButton = {default=1};
	__property RefreshGlyph;
	__property RefreshImageIndex = {default=-1};
	__property ShowImage = {default=1};
	__property ShowHiddenFolders = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property Version;
	__property Width;
	__property OnRefreshClick;
	__property OnBeforeDropDown;
	__property OnShowEdit;
	__property OnHideEdit;
	__property OnPopulateChildNode;
	__property OnSelect;
	__property OnChange;
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
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TCustomExplorerTreeview.Create */ inline __fastcall virtual TAdvExplorerTreeview(Classes::TComponent* AOwner) : TCustomExplorerTreeview(AOwner) { }
	/* TCustomExplorerTreeview.Destroy */ inline __fastcall virtual ~TAdvExplorerTreeview(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvExplorerTreeview(HWND ParentWindow) : TCustomExplorerTreeview(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
static const WideChar NODE_SEP = (WideChar)(0x5c);
static const ShortInt DROPDOWNBTN_WIDTH = 0xf;
static const ShortInt REFRESHBTN_WIDTH = 0x18;
static const ShortInt LEFTICON_WIDTH = 0x16;
static const ShortInt DwBUTTON_WIDTH = 0xe;
extern PACKAGE System::Word WM_ET_HIDEDROPDOWN;
extern PACKAGE System::Word WM_ET_SETFOLDERPATH;
extern PACKAGE System::Word WM_ET_TRACKKEYPRESS;

}	/* namespace Advexplorertreeview */
using namespace Advexplorertreeview;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvexplorertreeviewHPP
