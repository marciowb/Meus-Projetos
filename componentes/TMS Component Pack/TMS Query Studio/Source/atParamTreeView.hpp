// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atParamTreeView.pas' rev: 22.00

#ifndef AtparamtreeviewHPP
#define AtparamtreeviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <atParHTML.hpp>	// Pascal unit
#include <atPictureContainer.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atparamtreeview
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TatParamTreeViewClickEvent)(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, System::UnicodeString &value);

typedef void __fastcall (__closure *TatParamTreeViewPopupEvent)(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, Classes::TStringList* values, bool &DoPopup);

typedef void __fastcall (__closure *TatParamTreeViewSelectEvent)(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, System::UnicodeString value);

typedef void __fastcall (__closure *TatParamTreeViewChangedEvent)(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, System::UnicodeString oldvalue, System::UnicodeString newvalue);

typedef void __fastcall (__closure *TatParamTreeViewHintEvent)(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, System::UnicodeString &hintvalue, bool &showhint);

typedef void __fastcall (__closure *TParamCustomEditEvent)(System::TObject* Sender, Comctrls::TTreeNode* Node, System::UnicodeString href, System::UnicodeString value, System::UnicodeString props, const Types::TRect &EditRect);

typedef void __fastcall (__closure *TatParamTreeViewCustomShowEvent)(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, System::UnicodeString &value, const Types::TRect &ARect);

typedef void __fastcall (__closure *TatParamTreeViewEditEvent)(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, System::UnicodeString &value);

class DELPHICLASS TatParamTreeView;
class PASCALIMPLEMENTATION TatParamTreeView : public Comctrls::TCustomTreeView
{
	typedef Comctrls::TCustomTreeView inherited;
	
private:
	System::UnicodeString FVersion;
	int FIndent;
	int FOldCursor;
	int FOldScrollPos;
	Graphics::TColor FParamColor;
	Graphics::TColor FSelectionColor;
	Graphics::TColor FSelectionFontColor;
	int FItemHeight;
	Controls::TImageList* FImages;
	Menus::TPopupMenu* FParamPopup;
	Atparhtml::TPopupListBox* FParamList;
	Atparhtml::TPopupDatePicker* FParamDatePicker;
	Atparhtml::TPopupSpinEdit* FParamSpinEdit;
	Atparhtml::TPopupEdit* FParamEdit;
	Atparhtml::TPopupMaskEdit* FParamMaskEdit;
	System::UnicodeString FOldParam;
	TatParamTreeViewChangedEvent FOnParamChanged;
	TatParamTreeViewClickEvent FOnParamClick;
	TatParamTreeViewHintEvent FOnParamHint;
	TatParamTreeViewPopupEvent FOnParamPopup;
	TatParamTreeViewPopupEvent FOnParamList;
	TatParamTreeViewSelectEvent FOnParamSelect;
	TatParamTreeViewSelectEvent FOnParamEnter;
	TatParamTreeViewSelectEvent FOnParamExit;
	bool FParamListSorted;
	bool FShowSelection;
	TatParamTreeViewClickEvent FOnParamPrepare;
	bool FParamHint;
	Graphics::TColor FShadowColor;
	int FShadowOffset;
	int FUpdateCount;
	bool FWordWrap;
	bool FMouseDown;
	Atpicturecontainer::TatPictureContainer* FContainer;
	System::UnicodeString FCurrCtrlID;
	Types::TRect FCurrCtrlRect;
	Types::TRect FCurrCtrlDown;
	Comctrls::TTreeNode* FHoverNode;
	int FHoverHyperLink;
	Types::TRect FCurrHoverRect;
	Atpicturecontainer::THTMLPictureCache* FImageCache;
	bool FHover;
	Graphics::TColor FHoverColor;
	Graphics::TColor FHoverFontColor;
	bool FEditAutoSize;
	int FLineSpacing;
	TatParamTreeViewEditEvent FOnParamEditStart;
	TatParamTreeViewEditEvent FOnParamEditDone;
	System::UnicodeString FEmptyParam;
	System::UnicodeString FOldAnchor;
	int FOldIndex;
	int FFocusLink;
	int FNumHyperLinks;
	System::UnicodeString FEditValue;
	Types::TPoint FEditPos;
	bool FIsEditing;
	TatParamTreeViewEditEvent FOnParamQuery;
	TParamCustomEditEvent FOnParamCustomEdit;
	bool FAdvanceOnReturn;
	bool FStopMouseProcessing;
	bool FShowFocusBorder;
	System::UnicodeString FSubMenuStr;
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &message);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TWMMouse &message);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TMessage &message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TMessage &message);
	int __fastcall GetItemHeight(void);
	void __fastcall SetItemHeight(const int Value);
	void __fastcall SetSelectionColor(const Graphics::TColor Value);
	void __fastcall SetSelectionFontColor(const Graphics::TColor Value);
	void __fastcall SetParamColor(const Graphics::TColor Value);
	HIDESBASE void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetShowSelection(const bool Value);
	System::UnicodeString __fastcall GetNodeParameter(Comctrls::TTreeNode* Node, System::UnicodeString HRef);
	void __fastcall SetNodeParameter(Comctrls::TTreeNode* Node, System::UnicodeString HRef, const System::UnicodeString Value);
	System::UnicodeString __fastcall IsParam(int x, int y, bool GetFocusRect, Comctrls::TTreeNode* &Node, Types::TRect &hr, Types::TRect &cr, System::UnicodeString &CID, System::UnicodeString &CT, System::UnicodeString &CV);
	System::UnicodeString __fastcall HTMLPrep(System::UnicodeString s);
	System::UnicodeString __fastcall InvHTMLPrep(System::UnicodeString s);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetWordWrap(const bool Value);
	void __fastcall SetLineSpacing(const int Value);
	int __fastcall GetParamItemRefCount(int Item);
	int __fastcall GetParamNodeRefCount(Comctrls::TTreeNode* Node);
	System::UnicodeString __fastcall GetParamItemRefs(int Item, int Index);
	int __fastcall GetParamRefCount(void);
	System::UnicodeString __fastcall GetParamRefs(int Index);
	void __fastcall StartParamEdit(System::UnicodeString param, Comctrls::TTreeNode* Node, const Types::TRect &hr);
	void __fastcall StartParamDir(System::UnicodeString param, System::UnicodeString curdir, const Types::TRect &hr);
	Types::TRect __fastcall GetParamRect(System::UnicodeString href);
	int __fastcall GetParamNodeIndex(Comctrls::TTreeNode* Node, System::UnicodeString href);
	Comctrls::TTreeNode* __fastcall GetParamRefNode(System::UnicodeString href);
	System::UnicodeString __fastcall GetParameter(System::UnicodeString href);
	void __fastcall SetParameter(System::UnicodeString href, const System::UnicodeString Value);
	void __fastcall SetHover(const bool Value);
	int __fastcall GetParamIndex(System::UnicodeString href);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall HandlePopup(System::TObject* Sender);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall UpdateParam(System::UnicodeString Param, System::UnicodeString Value);
	void __fastcall PrepareParam(System::UnicodeString Param, System::UnicodeString &Value);
	void __fastcall ControlUpdate(System::TObject* Sender, System::UnicodeString Param, System::UnicodeString Text);
	void __fastcall AdvanceEdit(System::TObject* Sender);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall Change(Comctrls::TTreeNode* Node);
	
public:
	__fastcall virtual TatParamTreeView(Classes::TComponent* AOwner);
	__fastcall virtual ~TatParamTreeView(void);
	virtual void __fastcall BeginUpdate(void);
	virtual void __fastcall EndUpdate(void);
	__property System::UnicodeString NodeParameter[Comctrls::TTreeNode* Node][System::UnicodeString HRef] = {read=GetNodeParameter, write=SetNodeParameter};
	__property int ParamRefCount = {read=GetParamRefCount, nodefault};
	__property System::UnicodeString ParamRefs[int Index] = {read=GetParamRefs};
	__property Comctrls::TTreeNode* ParamRefNode[System::UnicodeString href] = {read=GetParamRefNode};
	__property int ParamNodeRefCount[int Item] = {read=GetParamItemRefCount};
	__property System::UnicodeString ParamNodeRefs[int Item][int Index] = {read=GetParamItemRefs};
	__property int ParamNodeIndex[Comctrls::TTreeNode* Node][System::UnicodeString href] = {read=GetParamNodeIndex};
	__property int ParamIndex[System::UnicodeString href] = {read=GetParamIndex};
	__property System::UnicodeString Parameter[System::UnicodeString href] = {read=GetParameter, write=SetParameter};
	void __fastcall EditParam(System::UnicodeString href);
	bool __fastcall GetParamInfo(Comctrls::TTreeNode* Node, System::UnicodeString HRef, System::UnicodeString &AValue, System::UnicodeString &AClass, System::UnicodeString &AProp, System::UnicodeString &AHint);
	__property Atparhtml::TPopupDatePicker* DateTimePicker = {read=FParamDatePicker};
	__property Atparhtml::TPopupSpinEdit* SpinEdit = {read=FParamSpinEdit};
	__property Atparhtml::TPopupEdit* Editor = {read=FParamEdit};
	__property Atparhtml::TPopupMaskEdit* MaskEditor = {read=FParamMaskEdit};
	__property Atparhtml::TPopupListBox* ListBox = {read=FParamList};
	__property bool StopMouseProcessing = {read=FStopMouseProcessing, write=FStopMouseProcessing, nodefault};
	
__published:
	__property bool AdvanceOnReturn = {read=FAdvanceOnReturn, write=FAdvanceOnReturn, nodefault};
	__property bool EditAutoSize = {read=FEditAutoSize, write=FEditAutoSize, nodefault};
	__property System::UnicodeString EmptyParam = {read=FEmptyParam, write=FEmptyParam};
	__property Controls::TImageList* HTMLImages = {read=FImages, write=SetImages};
	__property bool Hover = {read=FHover, write=SetHover, default=1};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=FHoverColor, default=32768};
	__property Graphics::TColor HoverFontColor = {read=FHoverFontColor, write=FHoverFontColor, default=16777215};
	__property int ItemHeight = {read=GetItemHeight, write=SetItemHeight, nodefault};
	__property int LineSpacing = {read=FLineSpacing, write=SetLineSpacing, default=0};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=SetSelectionColor, nodefault};
	__property Graphics::TColor SelectionFontColor = {read=FSelectionFontColor, write=SetSelectionFontColor, nodefault};
	__property bool ShowSelection = {read=FShowSelection, write=SetShowSelection, default=0};
	__property Graphics::TColor ParamColor = {read=FParamColor, write=SetParamColor, default=32768};
	__property bool ParamHint = {read=FParamHint, write=FParamHint, nodefault};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, nodefault};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, nodefault};
	__property bool ShowFocusBorder = {read=FShowFocusBorder, write=FShowFocusBorder, default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, nodefault};
	__property TatParamTreeViewClickEvent OnParamPrepare = {read=FOnParamPrepare, write=FOnParamPrepare};
	__property TatParamTreeViewClickEvent OnParamClick = {read=FOnParamClick, write=FOnParamClick};
	__property TatParamTreeViewPopupEvent OnParamPopup = {read=FOnParamPopup, write=FOnParamPopup};
	__property TatParamTreeViewPopupEvent OnParamList = {read=FOnParamList, write=FOnParamList};
	__property TatParamTreeViewSelectEvent OnParamSelect = {read=FOnParamSelect, write=FOnParamSelect};
	__property TatParamTreeViewChangedEvent OnParamChanged = {read=FOnParamChanged, write=FOnParamChanged};
	__property TatParamTreeViewHintEvent OnParamHint = {read=FOnParamHint, write=FOnParamHint};
	__property TatParamTreeViewSelectEvent OnParamEnter = {read=FOnParamEnter, write=FOnParamEnter};
	__property TatParamTreeViewSelectEvent OnParamExit = {read=FOnParamExit, write=FOnParamExit};
	__property TatParamTreeViewEditEvent OnParamEditStart = {read=FOnParamEditStart, write=FOnParamEditStart};
	__property TatParamTreeViewEditEvent OnParamEditDone = {read=FOnParamEditDone, write=FOnParamEditDone};
	__property TParamCustomEditEvent OnParamCustomEdit = {read=FOnParamCustomEdit, write=FOnParamCustomEdit};
	__property TatParamTreeViewEditEvent OnParamQuery = {read=FOnParamQuery, write=FOnParamQuery};
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
	__property bool ParamListSorted = {read=FParamListSorted, write=FParamListSorted, nodefault};
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
	__property ToolTips = {default=1};
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
public:
	/* TWinControl.CreateParented */ inline __fastcall TatParamTreeView(HWND ParentWindow) : Comctrls::TCustomTreeView(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::ShortInt MAJ_VER = 0x1;
static const System::ShortInt MIN_VER = 0x3;
static const System::ShortInt REL_VER = 0x0;
static const System::ShortInt BLD_VER = 0x0;

}	/* namespace Atparamtreeview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atparamtreeview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtparamtreeviewHPP
