// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Paramlistbox.pas' rev: 21.00

#ifndef ParamlistboxHPP
#define ParamlistboxHPP

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
#include <Menus.hpp>	// Pascal unit
#include <Spin.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Parhtml.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Paramlistbox
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

class DELPHICLASS EHTMListBoxError;
class PASCALIMPLEMENTATION EHTMListBoxError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EHTMListBoxError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EHTMListBoxError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EHTMListBoxError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EHTMListBoxError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EHTMListBoxError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EHTMListBoxError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EHTMListBoxError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EHTMListBoxError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EHTMListBoxError(void) { }
	
};


typedef void __fastcall (__closure *TAnchorClick)(System::TObject* Sender, int index, System::UnicodeString anchor);

typedef void __fastcall (__closure *TParamListBoxClickEvent)(System::TObject* Sender, int idx, System::UnicodeString href, System::UnicodeString &value);

typedef void __fastcall (__closure *TParamListBoxPopupEvent)(System::TObject* Sender, int idx, System::UnicodeString href, Classes::TStringList* values, bool &DoPopup);

typedef void __fastcall (__closure *TParamListBoxSelectEvent)(System::TObject* Sender, int idx, System::UnicodeString href, System::UnicodeString value);

typedef void __fastcall (__closure *TParamListBoxChangedEvent)(System::TObject* Sender, int idx, System::UnicodeString href, System::UnicodeString oldvalue, System::UnicodeString &newvalue);

typedef void __fastcall (__closure *TParamListBoxHintEvent)(System::TObject* Sender, int idx, System::UnicodeString href, System::UnicodeString &hintvalue, bool &showhint);

typedef void __fastcall (__closure *TParamCustomEditEvent)(System::TObject* Sender, int idx, System::UnicodeString href, System::UnicodeString value, System::UnicodeString props, const Types::TRect &EditRect);

typedef void __fastcall (__closure *TParamListBoxEditEvent)(System::TObject* Sender, int idx, System::UnicodeString href, System::UnicodeString &value);

typedef void __fastcall (__closure *TParamItemControlEvent)(System::TObject* Sender, int X, int Y, int Item, System::UnicodeString ControlID, System::UnicodeString ControlType, System::UnicodeString ControlValue);

typedef void __fastcall (__closure *TParamControlHintEvent)(System::TObject* Sender, System::UnicodeString ControlID, System::UnicodeString &Hint, bool &CanShow);

class DELPHICLASS TParamListBox;
class PASCALIMPLEMENTATION TParamListBox : public Stdctrls::TCustomListBox
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	bool FBlinking;
	int FOldCursor;
	System::UnicodeString FOldAnchor;
	TParamListBoxClickEvent FOnParamClick;
	TParamListBoxPopupEvent FOnParamPopup;
	TParamListBoxPopupEvent FOnParamList;
	TParamListBoxSelectEvent FOnParamSelect;
	TParamListBoxChangedEvent FOnParamChanged;
	TParamListBoxHintEvent FOnParamHint;
	Controls::TImageList* FImages;
	bool FMultiLine;
	Graphics::TColor FParamColor;
	Graphics::TColor FSelectionColor;
	Graphics::TColor FSelectionFonTColor;
	bool FIsMeasuring;
	int FTimerID;
	bool FEnableBlink;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	bool FParamHint;
	Menus::TPopupMenu* FParamPopup;
	Parhtml::TPopupListBox* FParamList;
	Parhtml::TPopupDatePicker* FParamDatePicker;
	Parhtml::TPopupSpinEdit* FParamSpinEdit;
	Parhtml::TPopupEdit* FParamEdit;
	Parhtml::TPopupMaskEdit* FParamMaskEdit;
	bool FParamListSorted;
	System::UnicodeString FOldParam;
	bool FHover;
	int FHoverIdx;
	int FHoverHyperLink;
	Graphics::TColor FHoverColor;
	Graphics::TColor FHoverFontColor;
	Types::TRect FCurrHoverRect;
	bool FShowSelection;
	int FFocusLink;
	int FFocusItem;
	int FNumHyperLinks;
	bool Redraw;
	int FUpdateCount;
	bool FMouseDown;
	System::UnicodeString FCurrCtrlID;
	Types::TRect FCurrCtrlRect;
	Types::TRect FCurrCtrlDown;
	Picturecontainer::TPictureContainer* FContainer;
	Picturecontainer::THTMLPictureCache* FImageCache;
	TParamListBoxSelectEvent FOnParamExit;
	TParamListBoxSelectEvent FOnParamEnter;
	TParamListBoxClickEvent FOnParamPrepare;
	TParamItemControlEvent FOnControlClick;
	TParamControlHintEvent FOnControlHint;
	bool FEditAutoSize;
	int FLineSpacing;
	TParamListBoxEditEvent FOnParamEditStart;
	TParamListBoxEditEvent FOnParamEditDone;
	System::UnicodeString FEmptyParam;
	System::UnicodeString FEditValue;
	Types::TPoint FEditPos;
	bool FIsEditing;
	TParamListBoxEditEvent FOnParamQuery;
	TParamCustomEditEvent FOnParamCustomEdit;
	bool FAdvanceOnReturn;
	void __fastcall ReMeasure(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	MESSAGE void __fastcall WMTimer(Messages::TWMTimer &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	void __fastcall SetImages(Controls::TImageList* value);
	void __fastcall SetMultiLine(bool value);
	void __fastcall SetParamColor(const Graphics::TColor Value);
	void __fastcall SetSelectionColor(const Graphics::TColor Value);
	void __fastcall SetSelectionFonTColor(const Graphics::TColor Value);
	System::UnicodeString __fastcall GetTextItem(int index);
	void __fastcall SetEnableBlink(const bool Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	System::UnicodeString __fastcall IsParam(int x, int y, bool GetFocusRect, int &Idx, Types::TRect &hoverrect, Types::TRect &ctrlrect, System::UnicodeString &CID, System::UnicodeString &CT, System::UnicodeString &CV);
	System::UnicodeString __fastcall GetParam(System::UnicodeString href);
	void __fastcall SetParam(System::UnicodeString href, const System::UnicodeString Value);
	void __fastcall HandlePopup(System::TObject* Sender);
	void __fastcall SetHoverColor(const Graphics::TColor Value);
	void __fastcall SetHoverFonTColor(const Graphics::TColor Value);
	void __fastcall SetParamHint(const bool Value);
	System::UnicodeString __fastcall GetItemParam(int idx, System::UnicodeString href);
	void __fastcall SetItemParam(int idx, System::UnicodeString href, const System::UnicodeString Value);
	void __fastcall UpdateParam(System::UnicodeString href, System::UnicodeString value);
	void __fastcall PrepareParam(System::UnicodeString Param, System::UnicodeString &Value);
	int __fastcall GetParamRefCount(void);
	System::UnicodeString __fastcall GetParamRefs(int Index);
	System::UnicodeString __fastcall GetParamItemRefs(int Item, int Index);
	int __fastcall GetParamRefIndex(System::UnicodeString href);
	void __fastcall ControlUpdate(System::TObject* Sender, System::UnicodeString Param, System::UnicodeString Text);
	void __fastcall AdvanceEdit(System::TObject* Sender);
	void __fastcall SetLineSpacing(const int Value);
	int __fastcall GetParamIndex(System::UnicodeString href);
	Types::TRect __fastcall GetParamRect(System::UnicodeString href);
	void __fastcall StartParamEdit(System::UnicodeString param, int Index, const Types::TRect &hr);
	void __fastcall StartParamDir(System::UnicodeString param, System::UnicodeString curdir, const Types::TRect &hr);
	int __fastcall GetParamItemIndex(int Index, System::UnicodeString href);
	int __fastcall GetParamItemRefCount(int Item);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TParamListBox(Classes::TComponent* aOwner);
	__fastcall virtual ~TParamListBox(void);
	virtual void __fastcall SelectAll(void);
	void __fastcall EditParam(int idx, System::UnicodeString href);
	__property System::UnicodeString TextItems[int index] = {read=GetTextItem};
	__property System::UnicodeString Parameter[System::UnicodeString href] = {read=GetParam, write=SetParam};
	__property int ParamRefCount = {read=GetParamRefCount, nodefault};
	__property System::UnicodeString ParamRefs[int Index] = {read=GetParamRefs};
	__property int ParamItemRefCount[int Item] = {read=GetParamItemRefCount};
	__property System::UnicodeString ParamItemRefs[int Item][int Index] = {read=GetParamItemRefs};
	__property int ParamRefIndex[System::UnicodeString href] = {read=GetParamRefIndex};
	__property int ParamIndex[System::UnicodeString href] = {read=GetParamIndex};
	__property int ParamItemIndex[int Index][System::UnicodeString href] = {read=GetParamItemIndex};
	__property Types::TRect ParamRect[System::UnicodeString href] = {read=GetParamRect};
	bool __fastcall GetParamInfo(int Index, System::UnicodeString HRef, System::UnicodeString &AValue, System::UnicodeString &AClass, System::UnicodeString &AProp, System::UnicodeString &AHint);
	__property System::UnicodeString ItemParameter[int idx][System::UnicodeString href] = {read=GetItemParam, write=SetItemParam};
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property Parhtml::TPopupDatePicker* DateTimePicker = {read=FParamDatePicker};
	__property Parhtml::TPopupSpinEdit* SpinEdit = {read=FParamSpinEdit};
	__property Parhtml::TPopupEdit* Editor = {read=FParamEdit};
	__property Parhtml::TPopupMaskEdit* MaskEditor = {read=FParamMaskEdit};
	__property Parhtml::TPopupListBox* ListBox = {read=FParamList};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Columns = {default=0};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ExtendedSelect = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName;
	__property Items;
	__property ItemHeight = {default=16};
	__property MultiSelect = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentColor = {default=0};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Sorted = {default=0};
	__property TabOrder = {default=-1};
	__property bool AdvanceOnReturn = {read=FAdvanceOnReturn, write=FAdvanceOnReturn, nodefault};
	__property bool EditAutoSize = {read=FEditAutoSize, write=FEditAutoSize, default=0};
	__property System::UnicodeString EmptyParam = {read=FEmptyParam, write=FEmptyParam};
	__property bool EnableBlink = {read=FEnableBlink, write=SetEnableBlink, default=0};
	__property bool Hover = {read=FHover, write=FHover, default=1};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=SetHoverColor, default=32768};
	__property Graphics::TColor HoverFontColor = {read=FHoverFontColor, write=SetHoverFonTColor, default=16777215};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property int LineSpacing = {read=FLineSpacing, write=SetLineSpacing, default=0};
	__property bool Multiline = {read=FMultiLine, write=SetMultiLine, nodefault};
	__property bool ParamHint = {read=FParamHint, write=SetParamHint, nodefault};
	__property Graphics::TColor ParamColor = {read=FParamColor, write=SetParamColor, default=32768};
	__property bool ParamListSorted = {read=FParamListSorted, write=FParamListSorted, default=0};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=SetSelectionColor, default=-16777203};
	__property Graphics::TColor SelectionFontColor = {read=FSelectionFonTColor, write=SetSelectionFonTColor, default=-16777202};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, nodefault};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, nodefault};
	__property bool ShowSelection = {read=FShowSelection, write=FShowSelection, nodefault};
	__property Visible = {default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
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
	__property TParamListBoxClickEvent OnParamClick = {read=FOnParamClick, write=FOnParamClick};
	__property TParamListBoxClickEvent OnParamPrepare = {read=FOnParamPrepare, write=FOnParamPrepare};
	__property TParamListBoxEditEvent OnParamEditStart = {read=FOnParamEditStart, write=FOnParamEditStart};
	__property TParamListBoxEditEvent OnParamEditDone = {read=FOnParamEditDone, write=FOnParamEditDone};
	__property TParamListBoxEditEvent OnParamQuery = {read=FOnParamQuery, write=FOnParamQuery};
	__property TParamListBoxPopupEvent OnParamPopup = {read=FOnParamPopup, write=FOnParamPopup};
	__property TParamListBoxPopupEvent OnParamList = {read=FOnParamList, write=FOnParamList};
	__property TParamListBoxSelectEvent OnParamSelect = {read=FOnParamSelect, write=FOnParamSelect};
	__property TParamListBoxChangedEvent OnParamChanged = {read=FOnParamChanged, write=FOnParamChanged};
	__property TParamListBoxHintEvent OnParamHint = {read=FOnParamHint, write=FOnParamHint};
	__property TParamListBoxSelectEvent OnParamEnter = {read=FOnParamEnter, write=FOnParamEnter};
	__property TParamListBoxSelectEvent OnParamExit = {read=FOnParamExit, write=FOnParamExit};
	__property TParamCustomEditEvent OnParamCustomEdit = {read=FOnParamCustomEdit, write=FOnParamCustomEdit};
	__property TParamItemControlEvent OnControlClick = {read=FOnControlClick, write=FOnControlClick};
	__property TParamControlHintEvent OnControlHint = {read=FOnControlHint, write=FOnControlHint};
public:
	/* TWinControl.CreateParented */ inline __fastcall TParamListBox(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x3;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Paramlistbox */
using namespace Paramlistbox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ParamlistboxHPP
