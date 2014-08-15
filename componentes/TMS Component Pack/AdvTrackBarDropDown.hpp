// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advtrackbardropdown.pas' rev: 21.00

#ifndef AdvtrackbardropdownHPP
#define AdvtrackbardropdownHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advtrackbardropdown
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvTrackBarDropDown;
class PASCALIMPLEMENTATION TAdvTrackBarDropDown : public Advdropdown::TAdvCustomDropDown
{
	typedef Advdropdown::TAdvCustomDropDown inherited;
	
private:
	Comctrls::TTrackBar* FTrackBar;
	int FMin;
	int FFrequency;
	int FPageSize;
	int FMax;
	int FPosition;
	bool FMouseDraging;
	int FMouseX;
	Classes::TNotifyEvent FOnTrackChange;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	void __fastcall SetFrequency(const int Value);
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetPageSize(const int Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall OnTrackBarChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall CreateDropDownForm(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall OnHideDropDown(void);
	virtual void __fastcall UpdateDropDownSize(void);
	virtual void __fastcall DoHideDropDown(bool Canceled);
	virtual void __fastcall SetCenterControl(void);
	virtual void __fastcall SetText(System::UnicodeString Value);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall SetSelectionColorStyle(const Advdropdown::TSelectionColorStyle Value);
	
public:
	__fastcall virtual TAdvTrackBarDropDown(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvTrackBarDropDown(void);
	
__published:
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
	__property DropDownButtonGlyph;
	__property DropDownSizeable = {default=1};
	__property Images;
	__property Version;
	__property ButtonAppearance;
	__property DropDownHeader;
	__property DropDownFooter;
	__property EditorEnabled = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ReadOnly = {default=0};
	__property DropDownEnabled = {default=0};
	__property int Max = {read=FMax, write=SetMax, default=10};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int Frequency = {read=FFrequency, write=SetFrequency, default=1};
	__property int Position = {read=FPosition, write=SetPosition, default=0};
	__property int PageSize = {read=FPageSize, write=SetPageSize, default=2};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property Classes::TNotifyEvent OnTrackChange = {read=FOnTrackChange, write=FOnTrackChange};
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
	/* TWinControl.CreateParented */ inline __fastcall TAdvTrackBarDropDown(HWND ParentWindow) : Advdropdown::TAdvCustomDropDown(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advtrackbardropdown */
using namespace Advtrackbardropdown;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvtrackbardropdownHPP
