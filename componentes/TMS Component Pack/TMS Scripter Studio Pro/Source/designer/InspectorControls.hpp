// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Inspectorcontrols.pas' rev: 21.00

#ifndef InspectorcontrolsHPP
#define InspectorcontrolsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Inspectorcontrols
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TButtonType { btNone, btDropDown, btUpDown, btDialog };
#pragma option pop

#pragma option push -b-
enum TInplaceEditorType { ieNone, ieEdit, ieCheckBox };
#pragma option pop

#pragma option push -b-
enum TExpandState { esNone, esExpand, esCollapse };
#pragma option pop

class DELPHICLASS TInspectorPopup;
class DELPHICLASS TAdvCustomInspector;
class PASCALIMPLEMENTATION TInspectorPopup : public Stdctrls::TListBox
{
	typedef Stdctrls::TListBox inherited;
	
private:
	TAdvCustomInspector* __fastcall Inspector(void);
	
protected:
	virtual void __fastcall DrawItem(int TheIndex, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TInspectorPopup(Classes::TComponent* AOwner);
public:
	/* TCustomListBox.Destroy */ inline __fastcall virtual ~TInspectorPopup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspectorPopup(HWND ParentWindow) : Stdctrls::TListBox(ParentWindow) { }
	
};


class DELPHICLASS TInspectorEdit;
class PASCALIMPLEMENTATION TInspectorEdit : public Mask::TMaskEdit
{
	typedef Mask::TMaskEdit inherited;
	
private:
	bool FEditing;
	TAdvCustomInspector* __fastcall Inspector(void);
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall Change(void);
public:
	/* TCustomMaskEdit.Create */ inline __fastcall virtual TInspectorEdit(Classes::TComponent* AOwner) : Mask::TMaskEdit(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspectorEdit(HWND ParentWindow) : Mask::TMaskEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TInspectorEdit(void) { }
	
};


class DELPHICLASS TInspectorCheckBox;
class PASCALIMPLEMENTATION TInspectorCheckBox : public Stdctrls::TCheckBox
{
	typedef Stdctrls::TCheckBox inherited;
	
private:
	TAdvCustomInspector* __fastcall Inspector(void);
	
protected:
	DYNAMIC void __fastcall Click(void);
public:
	/* TCustomCheckBox.Create */ inline __fastcall virtual TInspectorCheckBox(Classes::TComponent* AOwner) : Stdctrls::TCheckBox(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspectorCheckBox(HWND ParentWindow) : Stdctrls::TCheckBox(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TInspectorCheckBox(void) { }
	
};


class DELPHICLASS TInspectorButton;
class PASCALIMPLEMENTATION TInspectorButton : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FDown;
	TButtonType FButtonType;
	Graphics::TBitmap* FDropDown;
	Graphics::TBitmap* FUpDown;
	Graphics::TBitmap* FDialog;
	void __fastcall SetDown(const bool Value);
	void __fastcall SetButtonType(const TButtonType Value);
	TAdvCustomInspector* __fastcall Inspector(void);
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	
public:
	__fastcall virtual TInspectorButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TInspectorButton(void);
	__property bool Down = {read=FDown, write=SetDown, nodefault};
	__property TButtonType ButtonType = {read=FButtonType, write=SetButtonType, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspectorButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


#pragma option push -b-
enum TDragKind { dkNone, dkItem, dkSplitter };
#pragma option pop

#pragma option push -b-
enum TItemAction { iaDoubleClick, iaButtonClick };
#pragma option pop

#pragma option push -b-
enum TPaintStyle { psClassic, psTree, psTMS };
#pragma option pop

typedef bool __fastcall (__closure *TValidateCharEvent)(System::TObject* Sender, int TheIndex, System::WideChar &Key);

typedef void __fastcall (__closure *TGetStringEvent)(System::TObject* Sender, int TheIndex, System::UnicodeString &Value);

typedef void __fastcall (__closure *TSetStringEvent)(System::TObject* Sender, int TheIndex, const System::UnicodeString Value);

typedef void __fastcall (__closure *TButtonTypeEvent)(System::TObject* Sender, int TheIndex, TButtonType &Value);

typedef void __fastcall (__closure *TInplaceEditorTypeEvent)(System::TObject* Sender, int TheIndex, TInplaceEditorType &Value);

typedef void __fastcall (__closure *TBooleanEvent)(System::TObject* Sender, int TheIndex, bool &Value);

typedef void __fastcall (__closure *TExpandStateEvent)(System::TObject* Sender, int TheIndex, TExpandState &Value);

typedef void __fastcall (__closure *TIntegerEvent)(System::TObject* Sender, int TheIndex, int &Value);

typedef void __fastcall (__closure *TPointerEvent)(System::TObject* Sender, int TheIndex, void * &Value);

typedef void __fastcall (__closure *TColorEvent)(System::TObject* Sender, int TheIndex, Graphics::TColor &Value);

typedef void __fastcall (__closure *TFontEvent)(System::TObject* Sender, int TheIndex, const Graphics::TFont* TheFont);

typedef void __fastcall (__closure *TStringsEvent)(System::TObject* Sender, int TheIndex, const Classes::TStrings* Strings);

typedef bool __fastcall (__closure *TCallEditorEvent)(System::TObject* Sender, int TheIndex);

typedef bool __fastcall (__closure *TCallEditorEnableEvent)(System::TObject* Sender, int TheIndex, bool &EnableDefault);

typedef void __fastcall (__closure *TIndexNotifyEvent)(System::TObject* Sender, int TheIndex);

typedef void __fastcall (__closure *TIndexDrawEvent)(System::TObject* Sender, int TheIndex, Graphics::TCanvas* TheCanvas, const Types::TRect &TheRect);

typedef void __fastcall (__closure *TIndexEnableEvent)(System::TObject* Sender, int TheIndex, bool &EnableDefault);

typedef void __fastcall (__closure *TChangeValueEvent)(System::TObject* Sender, int TheIndex, bool Editing, const System::UnicodeString Value);

class PASCALIMPLEMENTATION TAdvCustomInspector : public Stdctrls::TCustomListBox
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	TInspectorCheckBox* FCheckBox;
	TInspectorEdit* FEdit;
	TInspectorButton* FButton;
	int FIndex;
	bool FFullUpdate;
	int FOldScrollPos;
	bool FClicked;
	int FOldWidth;
	int FOldHeight;
	int FOldSplitter;
	int FLockCounter;
	int FSplitter;
	bool FCheckBoxes;
	TPaintStyle FPaintStyle;
	int FDragSplitter;
	TDragKind FDragKind;
	TInspectorPopup* FPopup;
	Graphics::TBitmap* FExpand;
	Graphics::TBitmap* FCollapse;
	int FItemCount;
	TIndexNotifyEvent FOnSelect;
	Classes::TNotifyEvent FOnUpdate;
	TValidateCharEvent FOnValidateChar;
	TChangeValueEvent FOnChangeValue;
	TIndexDrawEvent FOnDrawName;
	TIndexDrawEvent FOnDrawValue;
	TGetStringEvent FOnGetName;
	TGetStringEvent FOnGetValue;
	TGetStringEvent FOnGetNextValue;
	TSetStringEvent FOnSetValue;
	TButtonTypeEvent FOnGetButtonType;
	TInplaceEditorTypeEvent FOnGetInplaceEditorType;
	TIntegerEvent FOnGetMaxLength;
	TGetStringEvent FOnGetEditMask;
	TBooleanEvent FOnGetEnableExternalEditor;
	TBooleanEvent FOnGetReadOnly;
	TExpandStateEvent FOnGetExpandState;
	TIntegerEvent FOnGetLevel;
	TPointerEvent FOnGetData;
	TStringsEvent FOnGetValuesList;
	TBooleanEvent FOnGetSortValuesList;
	TGetStringEvent FOnGetSelectedValue;
	TBooleanEvent FOnGetAutoApply;
	TFontEvent FOnGetNameFont;
	TColorEvent FOnGetNameColor;
	TFontEvent FOnGetValueFont;
	TColorEvent FOnGetValueColor;
	TCallEditorEvent FOnCallEditor;
	TIndexNotifyEvent FOnExpand;
	TIndexNotifyEvent FOnCollapse;
	TIndexNotifyEvent FOnSelectItem;
	TIndexNotifyEvent FOnDeselectItem;
	TIndexEnableEvent FOnValueDoubleClick;
	TIntegerEvent FOnDragValue;
	bool __fastcall GetLocked(void);
	int __fastcall GetItemCount(void);
	void __fastcall SetItemCount(const int Value);
	void __fastcall SetSplitter(const int Value);
	void __fastcall SetCheckBoxes(const bool Value);
	void __fastcall SetPaintStyle(const TPaintStyle Value);
	void __fastcall DrawDragSplitter(void);
	void __fastcall SetMouseItem(int Pos);
	HIDESBASE bool __fastcall Action(TItemAction A);
	void __fastcall HidePopup(void);
	bool __fastcall IsFocused(void);
	bool __fastcall SpecialClick(int L);
	void __fastcall UpdateControls(void);
	void __fastcall SetIndex(const int Value);
	void __fastcall FocusControl(void);
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual int __fastcall GetDefaultIndex(void);
	void __fastcall FullUpdateNeeded(void);
	virtual int __fastcall GetPopupItemWidth(Stdctrls::TListBox* ListBox, int TheIndex);
	virtual void __fastcall DrawPopupItem(Stdctrls::TListBox* ListBox, int ListItemIndex, const Types::TRect &R, int TheIndex);
	virtual void __fastcall SetEditedText(const System::UnicodeString AText);
	virtual bool __fastcall ValidateChar(int TheIndex, System::WideChar &Key);
	virtual void __fastcall ChangeValue(int TheIndex, bool Editing, const System::UnicodeString AText);
	void __fastcall SetSelectionPos(int TheIndex, bool NeedUpdate);
	virtual void __fastcall DrawPropertyName(Graphics::TCanvas* TheCanvas, int TheIndex, const Types::TRect &R);
	virtual void __fastcall DrawPropertyValue(Graphics::TCanvas* TheCanvas, int TheIndex, const Types::TRect &R);
	virtual void __fastcall DrawVerticalSeparator(Graphics::TCanvas* TheCanvas, int TheIndex, const Types::TRect &R);
	virtual void __fastcall DrawHorizontalSeparator(Graphics::TCanvas* TheCanvas, int TheIndex, const Types::TRect &R);
	virtual void __fastcall DrawBorders(Graphics::TCanvas* TheCanvas, int TheIndex, const Types::TRect &R);
	virtual System::UnicodeString __fastcall GetName(int TheIndex);
	virtual System::UnicodeString __fastcall GetValue(int TheIndex);
	virtual System::UnicodeString __fastcall GetNextValue(int TheIndex);
	virtual void __fastcall SetValue(int TheIndex, const System::UnicodeString Value);
	virtual void __fastcall DragValue(int TheIndex, int Offset);
	virtual TButtonType __fastcall GetButtonType(int TheIndex);
	virtual TInplaceEditorType __fastcall GetInplaceEditorType(int TheIndex);
	virtual int __fastcall GetMaxLength(int TheIndex);
	virtual System::UnicodeString __fastcall GetEditMask(int TheIndex);
	virtual bool __fastcall GetEnableExternalEditor(int TheIndex);
	virtual bool __fastcall GetReadOnly(int TheIndex);
	virtual TExpandState __fastcall GetExpandState(int TheIndex);
	virtual int __fastcall GetLevel(int TheIndex);
	virtual void * __fastcall GetData(int TheIndex);
	virtual void __fastcall GetValuesList(int TheIndex, const Classes::TStrings* Strings);
	virtual bool __fastcall GetSortValuesList(int TheIndex);
	virtual System::UnicodeString __fastcall GetSelectedValue(int TheIndex);
	virtual bool __fastcall GetAutoApply(int TheIndex);
	virtual void __fastcall GetNameFont(int TheIndex, Graphics::TFont* TheFont);
	virtual Graphics::TColor __fastcall GetNameColor(int TheIndex);
	virtual void __fastcall GetValueFont(int TheIndex, Graphics::TFont* TheFont);
	virtual Graphics::TColor __fastcall GetValueColor(int TheIndex);
	virtual int __fastcall GetIndent(void);
	virtual bool __fastcall CallEditor(int TheIndex);
	virtual void __fastcall Expand(int TheIndex);
	virtual void __fastcall Collapse(int TheIndex);
	virtual void __fastcall SelectItem(int TheIndex);
	virtual void __fastcall DeselectItem(int TheIndex);
	__property int ItemCount = {read=GetItemCount, write=SetItemCount, default=0};
	__property int Splitter = {read=FSplitter, write=SetSplitter, default=100};
	__property bool CheckBoxes = {read=FCheckBoxes, write=SetCheckBoxes, default=0};
	__property TIndexNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property Classes::TNotifyEvent OnUpdate = {read=FOnUpdate, write=FOnUpdate};
	__property TValidateCharEvent OnValidateChar = {read=FOnValidateChar, write=FOnValidateChar};
	__property TChangeValueEvent OnChangeValue = {read=FOnChangeValue, write=FOnChangeValue};
	__property TIndexDrawEvent OnDrawName = {read=FOnDrawName, write=FOnDrawName};
	__property TIndexDrawEvent OnDrawValue = {read=FOnDrawValue, write=FOnDrawValue};
	__property TGetStringEvent OnGetName = {read=FOnGetName, write=FOnGetName};
	__property TGetStringEvent OnGetValue = {read=FOnGetValue, write=FOnGetValue};
	__property TGetStringEvent OnGetNextValue = {read=FOnGetNextValue, write=FOnGetNextValue};
	__property TSetStringEvent OnSetValue = {read=FOnSetValue, write=FOnSetValue};
	__property TButtonTypeEvent OnGetButtonType = {read=FOnGetButtonType, write=FOnGetButtonType};
	__property TInplaceEditorTypeEvent OnGetInplaceEditorType = {read=FOnGetInplaceEditorType, write=FOnGetInplaceEditorType};
	__property TIntegerEvent OnGetMaxLength = {read=FOnGetMaxLength, write=FOnGetMaxLength};
	__property TGetStringEvent OnGetEditMask = {read=FOnGetEditMask, write=FOnGetEditMask};
	__property TBooleanEvent OnGetEnableExternalEditor = {read=FOnGetEnableExternalEditor, write=FOnGetEnableExternalEditor};
	__property TBooleanEvent OnGetReadOnly = {read=FOnGetReadOnly, write=FOnGetReadOnly};
	__property TExpandStateEvent OnGetExpandState = {read=FOnGetExpandState, write=FOnGetExpandState};
	__property TIntegerEvent OnGetLevel = {read=FOnGetLevel, write=FOnGetLevel};
	__property TPointerEvent OnGetData = {read=FOnGetData, write=FOnGetData};
	__property TStringsEvent OnGetValuesList = {read=FOnGetValuesList, write=FOnGetValuesList};
	__property TBooleanEvent OnGetSortValuesList = {read=FOnGetSortValuesList, write=FOnGetSortValuesList};
	__property TGetStringEvent OnGetSelectedValue = {read=FOnGetSelectedValue, write=FOnGetSelectedValue};
	__property TBooleanEvent OnGetAutoApply = {read=FOnGetAutoApply, write=FOnGetAutoApply};
	__property TFontEvent OnGetNameFont = {read=FOnGetNameFont, write=FOnGetNameFont};
	__property TColorEvent OnGetNameColor = {read=FOnGetNameColor, write=FOnGetNameColor};
	__property TFontEvent OnGetValueFont = {read=FOnGetValueFont, write=FOnGetValueFont};
	__property TColorEvent OnGetValueColor = {read=FOnGetValueColor, write=FOnGetValueColor};
	__property TCallEditorEvent OnCallEditor = {read=FOnCallEditor, write=FOnCallEditor};
	__property TIndexNotifyEvent OnExpand = {read=FOnExpand, write=FOnExpand};
	__property TIndexNotifyEvent OnCollapse = {read=FOnCollapse, write=FOnCollapse};
	__property TIndexNotifyEvent OnSelectItem = {read=FOnSelectItem, write=FOnSelectItem};
	__property TIndexNotifyEvent OnDeselectItem = {read=FOnDeselectItem, write=FOnDeselectItem};
	__property TIndexEnableEvent OnValueDoubleClick = {read=FOnValueDoubleClick, write=FOnValueDoubleClick};
	__property TIntegerEvent OnDragValue = {read=FOnDragValue, write=FOnDragValue};
	
public:
	__fastcall virtual TAdvCustomInspector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomInspector(void);
	virtual void __fastcall Update(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Lock(void);
	virtual void __fastcall Unlock(void);
	void __fastcall DrawPropertyNameDefault(Graphics::TCanvas* TheCanvas, int TheIndex, const Types::TRect &R);
	void __fastcall DrawPropertyValueDefault(Graphics::TCanvas* TheCanvas, int TheIndex, const Types::TRect &R);
	void __fastcall ApplyChanges(void);
	void __fastcall IgnoreChanges(void);
	__property TInspectorEdit* InplaceEdit = {read=FEdit};
	__property TInspectorCheckBox* InplaceCheckBox = {read=FCheckBox};
	__property bool Locked = {read=GetLocked, nodefault};
	__property System::UnicodeString Names[int Index] = {read=GetName};
	__property System::UnicodeString Values[int Index] = {read=GetValue};
	__property TButtonType ButtonType[int Index] = {read=GetButtonType};
	__property TInplaceEditorType InplaceEditorType[int Index] = {read=GetInplaceEditorType};
	__property bool EnableExternalEditor[int Index] = {read=GetEnableExternalEditor};
	__property bool ReadOnly[int Index] = {read=GetReadOnly};
	__property TExpandState ExpandState[int Index] = {read=GetExpandState};
	__property int Index = {read=FIndex, write=SetIndex, nodefault};
	__property bool Clicked = {read=FClicked, write=FClicked, nodefault};
	__property TPaintStyle PaintStyle = {read=FPaintStyle, write=SetPaintStyle, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomInspector(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	
};


class DELPHICLASS TCommonInspector;
class PASCALIMPLEMENTATION TCommonInspector : public TAdvCustomInspector
{
	typedef TAdvCustomInspector inherited;
	
__published:
	__property Anchors = {default=3};
	__property Constraints;
	__property Align = {default=0};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName;
	__property IntegralHeight = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property ItemCount = {default=0};
	__property CheckBoxes = {default=0};
	__property PaintStyle = {default=0};
	__property Splitter = {default=100};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnStartDrag;
	__property OnUpdate;
	__property OnValidateChar;
	__property OnChangeValue;
	__property OnDrawName;
	__property OnDrawValue;
	__property OnGetName;
	__property OnGetValue;
	__property OnGetNextValue;
	__property OnSetValue;
	__property OnGetButtonType;
	__property OnGetMaxLength;
	__property OnGetEditMask;
	__property OnGetInplaceEditorType;
	__property OnGetEnableExternalEditor;
	__property OnGetReadOnly;
	__property OnGetExpandState;
	__property OnGetLevel;
	__property OnGetData;
	__property OnGetValuesList;
	__property OnGetSortValuesList;
	__property OnGetSelectedValue;
	__property OnGetAutoApply;
	__property OnGetNameFont;
	__property OnGetNameColor;
	__property OnGetValueFont;
	__property OnGetValueColor;
	__property OnCallEditor;
	__property OnExpand;
	__property OnCollapse;
	__property OnSelectItem;
	__property OnDeselectItem;
	__property OnValueDoubleClick;
	__property OnDragValue;
public:
	/* TAdvCustomInspector.Create */ inline __fastcall virtual TCommonInspector(Classes::TComponent* AOwner) : TAdvCustomInspector(AOwner) { }
	/* TAdvCustomInspector.Destroy */ inline __fastcall virtual ~TCommonInspector(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCommonInspector(HWND ParentWindow) : TAdvCustomInspector(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Inspectorcontrols */
using namespace Inspectorcontrols;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// InspectorcontrolsHPP
