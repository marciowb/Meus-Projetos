// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advtreecombobox.pas' rev: 21.00

#ifndef AdvtreecomboboxHPP
#define AdvtreecomboboxHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Atxpvs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advtreecombobox
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSelectMode { smSingleClick, smDblClick };
#pragma option pop

#pragma option push -b-
enum TDropPosition { dpAuto, dpDown, dpUp };
#pragma option pop

typedef void __fastcall (__closure *TDropDown)(System::TObject* Sender, bool &acceptdrop);

typedef void __fastcall (__closure *TDropUp)(System::TObject* Sender, bool canceled);

class DELPHICLASS TDropTreeForm;
class PASCALIMPLEMENTATION TDropTreeForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	unsigned FDeActivate;
	HIDESBASE MESSAGE void __fastcall WMClose(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HWND __fastcall GetParentWnd(void);
	
__published:
	__property unsigned DeActivateTime = {read=FDeActivate, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDropTreeForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDropTreeForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDropTreeForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDropTreeForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TDropTreeButton;
class PASCALIMPLEMENTATION TDropTreeButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	Controls::TWinControl* FFocusControl;
	Classes::TNotifyEvent FMouseUp;
	Classes::TNotifyEvent FMouseDown;
	Graphics::TColor FColor;
	bool FIsWinXP;
	bool FHover;
	bool FDown;
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Paint(void);
	__property bool Hover = {read=FHover, write=FHover, nodefault};
	__property bool Down = {read=FDown, write=FDown, nodefault};
	
public:
	DYNAMIC void __fastcall Click(void);
	__fastcall virtual TDropTreeButton(Classes::TComponent* AOwner);
	__property bool IsWinXP = {read=FIsWinXP, nodefault};
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=FColor, nodefault};
	__property Controls::TWinControl* FocusControl = {read=FFocusControl, write=FFocusControl};
	__property Classes::TNotifyEvent MouseButtonDown = {read=FMouseDown, write=FMouseDown};
	__property Classes::TNotifyEvent MouseButtonUp = {read=FMouseUp, write=FMouseUp};
public:
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TDropTreeButton(void) { }
	
};


class DELPHICLASS TAdvTreeComboBox;
class PASCALIMPLEMENTATION TAdvTreeComboBox : public Stdctrls::TCustomEdit
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	Comctrls::TTreeView* FTreeView;
	TDropTreeForm* FDropTreeForm;
	TDropTreeButton* FButton;
	int FDropWidth;
	int FDropHeight;
	bool FEditorEnabled;
	bool FExpandOnDrop;
	bool FCollapseOnDrop;
	TDropPosition FDropPosition;
	System::UnicodeString FOldCaption;
	TDropDown FOndropDown;
	TDropUp FOndropUP;
	bool FAutoOpen;
	TSelectMode FSelectMode;
	bool FFlat;
	bool FIsWinXP;
	int __fastcall GetMinHeight(void);
	void __fastcall SetEditRect(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	Comctrls::TTreeNodes* __fastcall GetTreeNodes(void);
	void __fastcall SetTreeNodes(const Comctrls::TTreeNodes* Value);
	void __fastcall SetEditorEnabled(const bool Value);
	void __fastcall SetCollapseOnDrop(const bool Value);
	void __fastcall SetExpandOnDrop(const bool Value);
	void __fastcall SetShowButtons(const bool Value);
	bool __fastcall GetShowButtons(void);
	bool __fastcall GetShowLines(void);
	void __fastcall SetShowLines(const bool Value);
	bool __fastcall GetShowRoot(void);
	void __fastcall SetShowRoot(const bool Value);
	Comctrls::TSortType __fastcall GetSortType(void);
	void __fastcall SetSortType(const Comctrls::TSortType Value);
	bool __fastcall GetRightClickSelect(void);
	void __fastcall SetRightClickSelect(const bool Value);
	bool __fastcall GetRowSelect(void);
	void __fastcall SetRowSelect(const bool Value);
	int __fastcall GetIndent(void);
	void __fastcall SetIndent(const int Value);
	Imglist::TCustomImageList* __fastcall GetImages(void);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	bool __fastcall GetReadOnlyTree(void);
	void __fastcall SetReadOnlyTree(const bool Value);
	void __fastcall SetStateImages(const Imglist::TCustomImageList* Value);
	Imglist::TCustomImageList* __fastcall GetStateImages(void);
	Graphics::TFont* __fastcall GetTreeFont(void);
	void __fastcall SetTreeFont(const Graphics::TFont* Value);
	Graphics::TColor __fastcall GetTreeColor(void);
	void __fastcall SetTreeColor(const Graphics::TColor Value);
	Forms::TBorderStyle __fastcall GetTreeBorder(void);
	void __fastcall SetTreeBorder(const Forms::TBorderStyle Value);
	Menus::TPopupMenu* __fastcall GetTreepopupmenu(void);
	void __fastcall SetTreepopupmenu(const Menus::TPopupMenu* Value);
	int __fastcall GetSelection(void);
	void __fastcall SetSelection(const int Value);
	void __fastcall SetFlat(const bool Value);
	int __fastcall GetAbsoluteIndex(void);
	System::UnicodeString __fastcall GetVersionEx(void);
	int __fastcall GetVersionNr(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall MouseButtonDown(System::TObject* Sender);
	void __fastcall FindTextInNode(void);
	void __fastcall HideTree(bool canceled);
	void __fastcall TreeViewKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall TreeViewChange(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall TreeViewKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall TreeViewDblClick(System::TObject* Sender);
	void __fastcall TreeViewMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall TreeViewBlockChanging(System::TObject* Sender, Comctrls::TTreeNode* Node, bool &AllowChange);
	void __fastcall TreeViewExit(System::TObject* Sender);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual Comctrls::TTreeView* __fastcall CreateTreeview(Classes::TComponent* AOwner);
	
public:
	__fastcall virtual TAdvTreeComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvTreeComboBox(void);
	void __fastcall ShowTree(void);
	__property TDropTreeButton* Button = {read=FButton};
	__property int AbsoluteIndex = {read=GetAbsoluteIndex, nodefault};
	__property Comctrls::TTreeView* Treeview = {read=FTreeView};
	
__published:
	__property TSelectMode SelectMode = {read=FSelectMode, write=FSelectMode, default=1};
	__property int DropWidth = {read=FDropWidth, write=FDropWidth, nodefault};
	__property int DropHeight = {read=FDropHeight, write=FDropHeight, nodefault};
	__property Comctrls::TTreeNodes* Items = {read=GetTreeNodes, write=SetTreeNodes};
	__property bool EditorEnabled = {read=FEditorEnabled, write=SetEditorEnabled, default=1};
	__property bool CollapseOnDrop = {read=FCollapseOnDrop, write=SetCollapseOnDrop, default=0};
	__property bool ExpandOnDrop = {read=FExpandOnDrop, write=SetExpandOnDrop, default=0};
	__property TDropPosition DropPosition = {read=FDropPosition, write=FDropPosition, default=0};
	__property bool AutoOpen = {read=FAutoOpen, write=FAutoOpen, default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property bool ReadOnlyTree = {read=GetReadOnlyTree, write=SetReadOnlyTree, default=1};
	__property bool ShowButtons = {read=GetShowButtons, write=SetShowButtons, default=1};
	__property bool ShowLines = {read=GetShowLines, write=SetShowLines, default=1};
	__property bool ShowRoot = {read=GetShowRoot, write=SetShowRoot, default=1};
	__property Comctrls::TSortType SortType = {read=GetSortType, write=SetSortType, default=0};
	__property bool RightClickSelect = {read=GetRightClickSelect, write=SetRightClickSelect, default=0};
	__property bool RowSelect = {read=GetRowSelect, write=SetRowSelect, default=0};
	__property int Indent = {read=GetIndent, write=SetIndent, nodefault};
	__property Imglist::TCustomImageList* Images = {read=GetImages, write=SetImages};
	__property Imglist::TCustomImageList* StateImages = {read=GetStateImages, write=SetStateImages};
	__property Graphics::TFont* TreeFont = {read=GetTreeFont, write=SetTreeFont};
	__property Graphics::TColor TreeColor = {read=GetTreeColor, write=SetTreeColor, nodefault};
	__property Forms::TBorderStyle TreeBorder = {read=GetTreeBorder, write=SetTreeBorder, nodefault};
	__property Menus::TPopupMenu* TreePopupMenu = {read=GetTreepopupmenu, write=SetTreepopupmenu};
	__property int Selection = {read=GetSelection, write=SetSelection, nodefault};
	__property System::UnicodeString Version = {read=GetVersionEx, write=SetVersion};
	__property TDropDown OnDropDown = {read=FOndropDown, write=FOndropDown};
	__property TDropUp OnDropUp = {read=FOndropUP, write=FOndropUP};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property AutoSelect = {default=1};
	__property AutoSize = {default=1};
	__property BorderStyle = {default=1};
	__property BevelKind = {default=0};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelEdges = {default=15};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property Height;
	__property Width;
	__property Text;
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
	/* TWinControl.CreateParented */ inline __fastcall TAdvTreeComboBox(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x2;

}	/* namespace Advtreecombobox */
using namespace Advtreecombobox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvtreecomboboxHPP
