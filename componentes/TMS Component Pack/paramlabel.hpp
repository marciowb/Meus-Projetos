// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Paramlabel.pas' rev: 21.00

#ifndef ParamlabelHPP
#define ParamlabelHPP

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
#include <Shellapi.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Parhtml.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Paramlabel
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

typedef void __fastcall (__closure *TParamLabelClickEvent)(System::TObject* Sender, System::UnicodeString href, System::UnicodeString &value);

typedef void __fastcall (__closure *TParamLabelPopupEvent)(System::TObject* Sender, System::UnicodeString href, Classes::TStringList* values, bool &DoPopup);

typedef void __fastcall (__closure *TParamLabelSelectEvent)(System::TObject* Sender, System::UnicodeString href, System::UnicodeString value);

typedef void __fastcall (__closure *TParamLabelChangedEvent)(System::TObject* Sender, System::UnicodeString href, System::UnicodeString oldvalue, System::UnicodeString newvalue);

typedef void __fastcall (__closure *TParamLabelHintEvent)(System::TObject* Sender, System::UnicodeString href, System::UnicodeString &hintvalue, bool &showhint);

typedef void __fastcall (__closure *TParamCustomEditEvent)(System::TObject* Sender, System::UnicodeString href, System::UnicodeString value, System::UnicodeString props, const Types::TRect &EditRect);

typedef void __fastcall (__closure *TParamLabelEditEvent)(System::TObject* Sender, System::UnicodeString href, System::UnicodeString &value);

typedef void __fastcall (__closure *TParamItemControlEvent)(System::TObject* Sender, int X, int Y, System::UnicodeString ControlID, System::UnicodeString ControlType, System::UnicodeString ControlValue);

typedef void __fastcall (__closure *TParamControlHintEvent)(System::TObject* Sender, System::UnicodeString ControlID, System::UnicodeString &Hint, bool &CanShow);

class DELPHICLASS TParamLabel;
class PASCALIMPLEMENTATION TParamLabel : public Stdctrls::TStaticText
{
	typedef Stdctrls::TStaticText inherited;
	
private:
	System::UnicodeString FAnchor;
	bool FAutoSizing;
	Classes::TStringList* FHTMLText;
	TParamLabelClickEvent FOnParamClick;
	TParamLabelPopupEvent FOnParamPopup;
	TParamLabelPopupEvent FOnParamList;
	TParamLabelSelectEvent FOnParamSelect;
	TParamLabelChangedEvent FOnParamChanged;
	TParamLabelHintEvent FOnParamHint;
	bool FParamHint;
	Controls::TImageList* FImages;
	int Fupdatecount;
	Graphics::TColor FParamColor;
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	Controls::TBevelWidth FBevelWidth;
	Controls::TBorderWidth FBorderWidth;
	Forms::TFormBorderStyle FBorderStyle;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	bool FHover;
	int FHoverHyperLink;
	int FHyperLink;
	Graphics::TColor FHoverColor;
	Graphics::TColor FHoverFontColor;
	Types::TRect FCurrHoverRect;
	Menus::TPopupMenu* FParamPopup;
	Parhtml::TPopupListBox* FParamList;
	Parhtml::TPopupDatePicker* FParamDatePicker;
	Parhtml::TPopupSpinEdit* FParamSpinEdit;
	Parhtml::TPopupEdit* FParamEdit;
	Parhtml::TPopupMaskEdit* FParamMaskEdit;
	System::UnicodeString FOldParam;
	System::UnicodeString FEditValue;
	Types::TPoint FEditPos;
	bool FIsEditing;
	bool FMouseDown;
	System::UnicodeString FCurrCtrlID;
	Types::TRect FCurrCtrlRect;
	Types::TRect FCurrCtrlDown;
	Picturecontainer::TPictureContainer* FContainer;
	Picturecontainer::THTMLPictureCache* FImageCache;
	TParamLabelSelectEvent FOnParamExit;
	TParamLabelSelectEvent FOnParamEnter;
	TParamItemControlEvent FOnControlClick;
	TParamControlHintEvent FOnControlHint;
	bool FParamListSorted;
	bool FEditAutoSize;
	int FLineSpacing;
	int FFocusLink;
	int FNumLinks;
	TParamLabelEditEvent FOnParamEditStart;
	TParamLabelEditEvent FOnParamEditDone;
	System::UnicodeString FEmptyParam;
	System::UnicodeString FOldAnchor;
	TParamLabelEditEvent FOnParamQuery;
	TParamCustomEditEvent FOnParamCustomEdit;
	bool FAdvanceOnReturn;
	void __fastcall SetHTMLText(Classes::TStringList* value);
	void __fastcall SetImages(Controls::TImageList* value);
	void __fastcall SetParamColor(Graphics::TColor value);
	void __fastcall SetAutoSizing(bool value);
	void __fastcall HTMLChanged(System::TObject* sender);
	void __fastcall SetBevelInner(Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(Controls::TBevelCut Value);
	HIDESBASE void __fastcall SetBevelWidth(Controls::TBevelWidth Value);
	HIDESBASE void __fastcall SetBorderWidth(Controls::TBorderWidth Value);
	HIDESBASE void __fastcall SetBorderStyle(Forms::TBorderStyle Value);
	System::UnicodeString __fastcall IsParam(int x, int y, int l, bool GetFocusRect, Types::TRect &hoverrect, Types::TRect &cr, System::UnicodeString &CID, System::UnicodeString &CT, System::UnicodeString &CV);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetHover(const bool Value);
	void __fastcall SetHoverColor(const Graphics::TColor Value);
	void __fastcall SetHoverFontColor(const Graphics::TColor Value);
	void __fastcall HoverInvalidate(const Types::TRect &r);
	System::UnicodeString __fastcall GetParam(System::UnicodeString href);
	void __fastcall SetParam(System::UnicodeString href, const System::UnicodeString Value);
	void __fastcall HandlePopup(System::TObject* Sender);
	void __fastcall SetParamHint(const bool Value);
	void __fastcall DoPaint(bool bkg);
	int __fastcall GetParamRefCount(void);
	System::UnicodeString __fastcall GetParamRefs(int Index);
	void __fastcall SetLineSpacing(const int Value);
	void __fastcall PrepareParam(System::UnicodeString Param, System::UnicodeString &Value);
	void __fastcall SetFocusParam(const int Value);
	int __fastcall GetParamIndex(System::UnicodeString href);
	Types::TRect __fastcall GetParamRect(System::UnicodeString href);
	void __fastcall StartParamEdit(System::UnicodeString param, const Types::TRect &hr);
	void __fastcall StartParamDir(System::UnicodeString param, System::UnicodeString curdir, const Types::TRect &hr);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual System::UnicodeString __fastcall GetDisplText(void);
	virtual void __fastcall UpdateDisplText(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	void __fastcall ControlUpdate(System::TObject* Sender, System::UnicodeString Param, System::UnicodeString Text);
	void __fastcall AdvanceEdit(System::TObject* Sender);
	
public:
	__fastcall virtual TParamLabel(Classes::TComponent* AOwner);
	__fastcall virtual ~TParamLabel(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall EditParam(System::UnicodeString href);
	__property System::UnicodeString Parameter[System::UnicodeString href] = {read=GetParam, write=SetParam};
	__property int ParamRefCount = {read=GetParamRefCount, nodefault};
	__property System::UnicodeString ParamRefs[int Index] = {read=GetParamRefs};
	__property int FocusParam = {read=FFocusLink, write=SetFocusParam, nodefault};
	__property int ParamIndex[System::UnicodeString href] = {read=GetParamIndex};
	__property Types::TRect ParamRect[System::UnicodeString href] = {read=GetParamRect};
	bool __fastcall GetParamInfo(System::UnicodeString HRef, System::UnicodeString &AValue, System::UnicodeString &AClass, System::UnicodeString &AProp, System::UnicodeString &AHint);
	__property Parhtml::TPopupListBox* ParamListBox = {read=FParamList};
	__property Parhtml::TPopupEdit* ParamEdit = {read=FParamEdit};
	__property Parhtml::TPopupSpinEdit* ParamSpinEdit = {read=FParamSpinEdit};
	__property Parhtml::TPopupMaskEdit* ParamMaskEdit = {read=FParamMaskEdit};
	__property Menus::TPopupMenu* ParamPopup = {read=FParamPopup};
	__property Parhtml::TPopupDatePicker* ParamDatePicker = {read=FParamDatePicker};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FocusControl;
	__property Font;
	__property ParentShowHint = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Color;
	__property Transparent = {default=1};
	__property Hint;
	__property Visible = {default=1};
	__property bool AdvanceOnReturn = {read=FAdvanceOnReturn, write=FAdvanceOnReturn, nodefault};
	__property bool AutoSizing = {read=FAutoSizing, write=SetAutoSizing, nodefault};
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=0};
	__property Controls::TBevelWidth BevelWidth = {read=FBevelWidth, write=SetBevelWidth, default=1};
	__property Controls::TBorderWidth BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property bool EditAutoSize = {read=FEditAutoSize, write=FEditAutoSize, default=0};
	__property System::UnicodeString EmptyParam = {read=FEmptyParam, write=FEmptyParam};
	__property bool Hover = {read=FHover, write=SetHover, default=1};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=SetHoverColor, default=32768};
	__property Graphics::TColor HoverFontColor = {read=FHoverFontColor, write=SetHoverFontColor, default=16777215};
	__property Classes::TStringList* HTMLText = {read=FHTMLText, write=SetHTMLText};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property int LineSpacing = {read=FLineSpacing, write=SetLineSpacing, default=0};
	__property Graphics::TColor ParamColor = {read=FParamColor, write=SetParamColor, default=32768};
	__property bool ParamListSorted = {read=FParamListSorted, write=FParamListSorted, default=0};
	__property bool ParamHint = {read=FParamHint, write=SetParamHint, nodefault};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, nodefault};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property TParamLabelClickEvent OnParamClick = {read=FOnParamClick, write=FOnParamClick};
	__property TParamLabelPopupEvent OnParamPopup = {read=FOnParamPopup, write=FOnParamPopup};
	__property TParamLabelPopupEvent OnParamList = {read=FOnParamList, write=FOnParamList};
	__property TParamLabelSelectEvent OnParamSelect = {read=FOnParamSelect, write=FOnParamSelect};
	__property TParamLabelChangedEvent OnParamChanged = {read=FOnParamChanged, write=FOnParamChanged};
	__property TParamLabelHintEvent OnParamHint = {read=FOnParamHint, write=FOnParamHint};
	__property TParamLabelSelectEvent OnParamEnter = {read=FOnParamEnter, write=FOnParamEnter};
	__property TParamLabelSelectEvent OnParamExit = {read=FOnParamExit, write=FOnParamExit};
	__property TParamLabelEditEvent OnParamEditStart = {read=FOnParamEditStart, write=FOnParamEditStart};
	__property TParamLabelEditEvent OnParamEditDone = {read=FOnParamEditDone, write=FOnParamEditDone};
	__property TParamLabelEditEvent OnParamQuery = {read=FOnParamQuery, write=FOnParamQuery};
	__property TParamCustomEditEvent OnParamCustomEdit = {read=FOnParamCustomEdit, write=FOnParamCustomEdit};
	__property TParamItemControlEvent OnControlClick = {read=FOnControlClick, write=FOnControlClick};
	__property TParamControlHintEvent OnControlHint = {read=FOnControlHint, write=FOnControlHint};
public:
	/* TWinControl.CreateParented */ inline __fastcall TParamLabel(HWND ParentWindow) : Stdctrls::TStaticText(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x3;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Paramlabel */
using namespace Paramlabel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ParamlabelHPP
