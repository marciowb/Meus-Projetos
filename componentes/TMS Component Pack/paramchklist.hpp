// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Paramchklist.pas' rev: 21.00

#ifndef ParamchklistHPP
#define ParamchklistHPP

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
#include <Spin.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Parhtml.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Parxpvs.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Paramchklist
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

typedef void __fastcall (__closure *TParamClickEvent)(System::TObject* Sender, int idx, System::UnicodeString href, System::UnicodeString &value);

typedef void __fastcall (__closure *TParamPopupEvent)(System::TObject* Sender, int idx, System::UnicodeString href, Classes::TStringList* values, bool &DoPopup);

typedef void __fastcall (__closure *TParamSelectEvent)(System::TObject* Sender, int idx, System::UnicodeString href, System::UnicodeString value);

typedef void __fastcall (__closure *TParamChangedEvent)(System::TObject* Sender, int idx, System::UnicodeString href, System::UnicodeString oldvalue, System::UnicodeString newvalue);

typedef void __fastcall (__closure *TParamHintEvent)(System::TObject* Sender, System::UnicodeString href, System::UnicodeString &hintvalue, bool &showhint);

typedef void __fastcall (__closure *TParamCustomEditEvent)(System::TObject* Sender, int idx, System::UnicodeString href, System::UnicodeString value, System::UnicodeString props, const Types::TRect &EditRect);

typedef void __fastcall (__closure *TParamListBoxEditEvent)(System::TObject* Sender, int idx, System::UnicodeString href, System::UnicodeString &value);

typedef void __fastcall (__closure *TParamItemControlEvent)(System::TObject* Sender, int X, int Y, int Item, System::UnicodeString ControlID, System::UnicodeString ControlType, System::UnicodeString ControlValue);

typedef void __fastcall (__closure *TParamControlHintEvent)(System::TObject* Sender, System::UnicodeString ControlID, System::UnicodeString &Hint, bool &CanShow);

class DELPHICLASS TParamCheckList;
class PASCALIMPLEMENTATION TParamCheckList : public Stdctrls::TCustomListBox
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	System::UnicodeString FOldParam;
	Controls::TCursor FOldCursor;
	Graphics::TColor FParamColor;
	bool FAllowGrayed;
	bool FDuplicates;
	bool FFlat;
	int FFocusLink;
	int FFocusItem;
	int FNumHyperLinks;
	int FStandardItemHeight;
	Classes::TNotifyEvent FOnCheckClick;
	TParamClickEvent FOnParamClick;
	TParamPopupEvent FOnParamPopup;
	TParamPopupEvent FOnParamList;
	TParamSelectEvent FOnParamSelect;
	TParamChangedEvent FOnParamChanged;
	TParamSelectEvent FOnParamExit;
	TParamSelectEvent FOnParamEnter;
	TParamHintEvent FOnParamHint;
	Classes::TList* FSaveStates;
	bool FShowSelection;
	Classes::TStringList* FDuplicateList;
	bool FHover;
	int FHoverIdx;
	int FHoverHyperLink;
	Graphics::TColor FHoverColor;
	Graphics::TColor FHoverFontColor;
	Types::TRect FCurrHoverRect;
	Menus::TPopupMenu* FParamPopup;
	Controls::TImageList* FImages;
	Parhtml::TPopupListBox* FParamList;
	Parhtml::TPopupDatePicker* FParamDatePicker;
	Parhtml::TPopupSpinEdit* FParamSpinEdit;
	Parhtml::TPopupEdit* FParamEdit;
	Parhtml::TPopupMaskEdit* FParamMaskEdit;
	Graphics::TColor FShadowColor;
	int FShadowOffset;
	int FUpdateCount;
	int FUpdateIndex;
	bool FParamHint;
	TParamClickEvent FOnParamPrepare;
	bool FParamListSorted;
	Picturecontainer::TPictureContainer* FContainer;
	Picturecontainer::THTMLPictureCache* FImageCache;
	bool FMouseDown;
	System::UnicodeString FCurrCtrlID;
	Types::TRect FCurrCtrlRect;
	Types::TRect FCurrCtrlDown;
	TParamItemControlEvent FOnControlClick;
	TParamControlHintEvent FOnControlHint;
	bool FEditAutoSize;
	int FLineSpacing;
	TParamListBoxEditEvent FOnParamEditStart;
	TParamListBoxEditEvent FOnParamEditDone;
	System::UnicodeString FEmptyParam;
	System::UnicodeString FOldAnchor;
	TParamListBoxEditEvent FOnParamQuery;
	Graphics::TColor FSelectionColor;
	Graphics::TColor FSelectionFontColor;
	System::UnicodeString FEditValue;
	Types::TPoint FEditPos;
	bool FIsEditing;
	TParamCustomEditEvent FOnParamCustomEdit;
	bool FAdvanceOnReturn;
	bool FWordWrap;
	Contnrs::TObjectList* WrapperList;
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
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
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
	System::UnicodeString __fastcall IsParam(int x, int y, bool GetFocusRect, int &idx, Types::TRect &hoverrect, Types::TRect &ctrlrect, System::UnicodeString &CID, System::UnicodeString &CT, System::UnicodeString &CV);
	void __fastcall SetParamColor(const Graphics::TColor Value);
	System::UnicodeString __fastcall GetParam(System::UnicodeString href);
	void __fastcall SetParam(System::UnicodeString href, const System::UnicodeString Value);
	System::UnicodeString __fastcall GetItemParam(int idx, System::UnicodeString href);
	void __fastcall SetItemParam(int idx, System::UnicodeString href, const System::UnicodeString Value);
	void __fastcall HandlePopup(System::TObject* Sender);
	void __fastcall SetHover(const bool Value);
	void __fastcall SetImageList(const Controls::TImageList* Value);
	int __fastcall GetItemIndent(const int Index);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	int __fastcall GetCheckWidth(void);
	void __fastcall SetParamHint(const bool Value);
	void __fastcall UpdateParam(System::UnicodeString href, System::UnicodeString value);
	void __fastcall PrepareParam(System::UnicodeString Param, System::UnicodeString &Value);
	System::UnicodeString __fastcall HTMLPrep(System::UnicodeString s);
	System::UnicodeString __fastcall InvHTMLPrep(System::UnicodeString s);
	int __fastcall GetParamRefCount(void);
	System::UnicodeString __fastcall GetParamRefs(int Index);
	int __fastcall GetParamRefIndex(System::UnicodeString href);
	void __fastcall ControlUpdate(System::TObject* Sender, System::UnicodeString Param, System::UnicodeString Text);
	void __fastcall AdvanceEdit(System::TObject* Sender);
	void __fastcall FreeWrapper(System::TObject* Wrapper);
	void __fastcall SetLineSpacing(const int Value);
	void __fastcall SetSelectionColor(const Graphics::TColor Value);
	void __fastcall SetSelectionFontColor(const Graphics::TColor Value);
	int __fastcall GetParamIndex(System::UnicodeString href);
	Types::TRect __fastcall GetParamRect(System::UnicodeString href);
	void __fastcall StartParamEdit(System::UnicodeString param, int Index, const Types::TRect &hr);
	void __fastcall StartParamDir(System::UnicodeString param, System::UnicodeString curdir, const Types::TRect &hr);
	int __fastcall GetParamItemIndex(int Index, System::UnicodeString href);
	System::UnicodeString __fastcall GetParamItemRefs(int Item, int Index);
	int __fastcall GetParamItemRefCount(int Item);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	DYNAMIC int __fastcall InternalGetItemData(int Index);
	DYNAMIC void __fastcall InternalSetItemData(int Index, int AData);
	DYNAMIC void __fastcall SetItemData(int Index, int AData);
	DYNAMIC int __fastcall GetItemData(int Index);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall ResetContent(void);
	DYNAMIC void __fastcall DeleteString(int Index);
	DYNAMIC void __fastcall ClickCheck(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	
public:
	__fastcall virtual TParamCheckList(Classes::TComponent* AOwner);
	__fastcall virtual ~TParamCheckList(void);
	__property bool Checked[int Index] = {read=GetChecked, write=SetChecked};
	__property bool ItemEnabled[int Index] = {read=GetItemEnabled, write=SetItemEnabled};
	__property Stdctrls::TCheckBoxState State[int Index] = {read=GetState, write=SetState};
	__property int Indent[int Index] = {read=GetIndent, write=SetIndent};
	__property bool Comment[int Index] = {read=GetComment, write=SetComment};
	__property System::UnicodeString Selected[int Index] = {read=GetSelected};
	__property int SelectCount = {read=GetSelectCount, nodefault};
	void __fastcall SortAllComments(void);
	void __fastcall SortComment(int Index);
	void __fastcall EditParam(System::UnicodeString href);
	__property Parhtml::TPopupListBox* ParamListBox = {read=FParamList};
	__property System::UnicodeString Parameter[System::UnicodeString href] = {read=GetParam, write=SetParam};
	__property System::UnicodeString ItemParameter[int idx][System::UnicodeString href] = {read=GetItemParam, write=SetItemParam};
	__property int ParamRefCount = {read=GetParamRefCount, nodefault};
	__property System::UnicodeString ParamRefs[int Index] = {read=GetParamRefs};
	__property int ParamItemRefCount[int Item] = {read=GetParamItemRefCount};
	__property System::UnicodeString ParamItemRefs[int Item][int Index] = {read=GetParamItemRefs};
	__property int ParamRefIndex[System::UnicodeString href] = {read=GetParamRefIndex};
	__property int ParamItemIndex[int Index][System::UnicodeString href] = {read=GetParamItemIndex};
	__property int ParamIndex[System::UnicodeString href] = {read=GetParamIndex};
	bool __fastcall GetParamInfo(int Index, System::UnicodeString HRef, System::UnicodeString &AValue, System::UnicodeString &AClass, System::UnicodeString &AProp, System::UnicodeString &AHint);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property Parhtml::TPopupDatePicker* DateTimePicker = {read=FParamDatePicker};
	__property Parhtml::TPopupSpinEdit* SpinEdit = {read=FParamSpinEdit};
	__property Parhtml::TPopupEdit* Editor = {read=FParamEdit};
	__property Parhtml::TPopupListBox* ListBox = {read=FParamList};
	
__published:
	__property bool AdvanceOnReturn = {read=FAdvanceOnReturn, write=FAdvanceOnReturn, nodefault};
	__property Align = {default=0};
	__property bool AllowGrayed = {read=FAllowGrayed, write=FAllowGrayed, default=0};
	__property bool EditAutoSize = {read=FEditAutoSize, write=FEditAutoSize, default=0};
	__property System::UnicodeString EmptyParam = {read=FEmptyParam, write=FEmptyParam};
	__property bool Hover = {read=FHover, write=SetHover, default=1};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=FHoverColor, default=32768};
	__property Graphics::TColor HoverFontColor = {read=FHoverFontColor, write=FHoverFontColor, default=16777215};
	__property int LineSpacing = {read=FLineSpacing, write=SetLineSpacing, default=0};
	__property Graphics::TColor ParamColor = {read=FParamColor, write=SetParamColor, default=32768};
	__property bool ParamHint = {read=FParamHint, write=SetParamHint, nodefault};
	__property bool ParamListSorted = {read=FParamListSorted, write=FParamListSorted, nodefault};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=SetSelectionColor, nodefault};
	__property Graphics::TColor SelectionFontColor = {read=FSelectionFontColor, write=SetSelectionFontColor, nodefault};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, nodefault};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, nodefault};
	__property bool ShowSelection = {read=FShowSelection, write=FShowSelection, nodefault};
	__property Controls::TImageList* Images = {read=FImages, write=SetImageList};
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
	__property bool Duplicates = {read=FDuplicates, write=SetDuplicates, nodefault};
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
	__property Classes::TNotifyEvent OnCheckClick = {read=FOnCheckClick, write=FOnCheckClick};
	__property TParamItemControlEvent OnControlClick = {read=FOnControlClick, write=FOnControlClick};
	__property TParamControlHintEvent OnControlHint = {read=FOnControlHint, write=FOnControlHint};
	__property TParamClickEvent OnParamClick = {read=FOnParamClick, write=FOnParamClick};
	__property TParamClickEvent OnParamPrepare = {read=FOnParamPrepare, write=FOnParamPrepare};
	__property TParamPopupEvent OnParamPopup = {read=FOnParamPopup, write=FOnParamPopup};
	__property TParamPopupEvent OnParamList = {read=FOnParamList, write=FOnParamList};
	__property TParamSelectEvent OnParamSelect = {read=FOnParamSelect, write=FOnParamSelect};
	__property TParamChangedEvent OnParamChanged = {read=FOnParamChanged, write=FOnParamChanged};
	__property TParamHintEvent OnParamHint = {read=FOnParamHint, write=FOnParamHint};
	__property TParamSelectEvent OnParamEnter = {read=FOnParamEnter, write=FOnParamEnter};
	__property TParamSelectEvent OnParamExit = {read=FOnParamExit, write=FOnParamExit};
	__property TParamListBoxEditEvent OnParamEditStart = {read=FOnParamEditStart, write=FOnParamEditStart};
	__property TParamListBoxEditEvent OnParamEditDone = {read=FOnParamEditDone, write=FOnParamEditDone};
	__property TParamCustomEditEvent OnParamCustomEdit = {read=FOnParamCustomEdit, write=FOnParamCustomEdit};
	__property TParamListBoxEditEvent OnParamQuery = {read=FOnParamQuery, write=FOnParamQuery};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property bool WordWrap = {read=FWordWrap, write=FWordWrap, default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TParamCheckList(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x3;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Paramchklist */
using namespace Paramchklist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ParamchklistHPP
