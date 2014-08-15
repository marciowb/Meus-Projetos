// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advmemodropdown.pas' rev: 21.00

#ifndef AdvmemodropdownHPP
#define AdvmemodropdownHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Advdropdown.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advmemodropdown
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvMemoDropDown;
class PASCALIMPLEMENTATION TAdvMemoDropDown : public Advdropdown::TAdvCustomDropDown
{
	typedef Advdropdown::TAdvCustomDropDown inherited;
	
private:
	Classes::TNotifyEvent FOnMemoChange;
	Menus::TPopupMenu* FMemoPopup;
	Classes::TStringList* FMemoText;
	Stdctrls::TMemo* FMemo;
	Stdctrls::TScrollStyle FMemoScrollBars;
	bool FMemoReadOnly;
	bool FInternalUpdate;
	void __fastcall SetMemoPopup(const Menus::TPopupMenu* Value);
	void __fastcall SetMemoText(const Classes::TStringList* Value);
	void __fastcall SetMemoScrollBars(const Stdctrls::TScrollStyle Value);
	void __fastcall MemoChanged(System::TObject* Sender);
	void __fastcall OnMemoTextChanged(System::TObject* Sender);
	void __fastcall OnMemoKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	System::UnicodeString __fastcall GetTextEx(void);
	void __fastcall SetMemoReadOnly(const bool Value);
	
protected:
	virtual void __fastcall CreateDropDownForm(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall OnHideDropDown(void);
	virtual void __fastcall DoHideDropDown(bool Canceled);
	virtual void __fastcall OnDropDownControlKeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall OnDropDownControlKeyUp(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall OnDropDownControlKeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall virtual TAdvMemoDropDown(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvMemoDropDown(void);
	__property System::UnicodeString Text = {read=GetTextEx};
	
__published:
	__property Classes::TStringList* MemoText = {read=FMemoText, write=SetMemoText};
	__property Menus::TPopupMenu* MemoPopup = {read=FMemoPopup, write=SetMemoPopup};
	__property Stdctrls::TScrollStyle MemoScrollBars = {read=FMemoScrollBars, write=SetMemoScrollBars, nodefault};
	__property bool MemoReadOnly = {read=FMemoReadOnly, write=SetMemoReadOnly, default=0};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property ImeMode = {default=3};
	__property ImeName;
	__property MaxLength = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property DropDownBorderColor = {default=0};
	__property DropDownBorderWidth = {default=1};
	__property DropDownShadow = {default=1};
	__property DropDownWidth = {default=0};
	__property DropDownHeight = {default=0};
	__property DropPosition = {default=0};
	__property DropDownButtonWidth = {default=17};
	__property DropDownButtonHint;
	__property DropDownSizeable = {default=1};
	__property Enabled = {default=1};
	__property EditorEnabled = {default=1};
	__property Font;
	__property DropDownButtonGlyph;
	__property Images;
	__property Version;
	__property ReadOnly = {default=0};
	__property ButtonAppearance;
	__property DropDownHeader;
	__property DropDownFooter;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property Classes::TNotifyEvent OnMemoChange = {read=FOnMemoChange, write=FOnMemoChange};
	__property OnEnter;
	__property OnExit;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnBeforeDropDown;
	__property OnDropDown;
	__property OnDropUp;
	__property OnDropDownHeaderButtonClick;
	__property OnDropDownFooterButtonClick;
	__property OnDrawHeader;
	__property OnDrawFooter;
	__property OnGetHeaderText;
	__property OnGetFooterText;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvMemoDropDown(HWND ParentWindow) : Advdropdown::TAdvCustomDropDown(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advmemodropdown */
using namespace Advmemodropdown;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvmemodropdownHPP
