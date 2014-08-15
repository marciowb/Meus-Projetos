// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Asgcombo.pas' rev: 21.00

#ifndef AsgcomboHPP
#define AsgcomboHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advxpvs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Asgcombo
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TASGCustomCombo;
class PASCALIMPLEMENTATION TASGCustomCombo : public Stdctrls::TCustomComboBox
{
	typedef Stdctrls::TCustomComboBox inherited;
	
private:
	bool FAutoFocus;
	bool FFlat;
	bool FEtched;
	Graphics::TColor FOldColor;
	bool FOldParentColor;
	int FButtonWidth;
	bool FFocusBorder;
	bool FMouseInControl;
	int FDropWidth;
	bool FIsWinXP;
	bool FIsVista;
	void __fastcall SetEtched(const bool Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetButtonWidth(const int Value);
	void __fastcall DrawButtonBorder(HDC DC);
	void __fastcall DrawControlBorder(HDC DC);
	void __fastcall DrawBorders(void);
	bool __fastcall Is3DBorderControl(void);
	bool __fastcall Is3DBorderButton(void);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	void __fastcall SetDropWidth(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, nodefault};
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property bool Etched = {read=FEtched, write=SetEtched, nodefault};
	__property bool FocusBorder = {read=FFocusBorder, write=FFocusBorder, nodefault};
	__property bool AutoFocus = {read=FAutoFocus, write=FAutoFocus, nodefault};
	__property int DropWidth = {read=FDropWidth, write=SetDropWidth, nodefault};
	
public:
	__property bool IsWinXP = {read=FIsWinXP, write=FIsWinXP, nodefault};
	__property bool IsVista = {read=FIsVista, write=FIsVista, nodefault};
	__fastcall virtual TASGCustomCombo(Classes::TComponent* AOwner);
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TASGCustomCombo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TASGCustomCombo(HWND ParentWindow) : Stdctrls::TCustomComboBox(ParentWindow) { }
	
};


class DELPHICLASS TASGComboBox;
class PASCALIMPLEMENTATION TASGComboBox : public TASGCustomCombo
{
	typedef TASGCustomCombo inherited;
	
__published:
	__property Align = {default=0};
	__property AutoFocus;
	__property ButtonWidth;
	__property Style = {default=0};
	__property Flat;
	__property Etched;
	__property FocusBorder;
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property DropDownCount = {default=8};
	__property DropWidth;
	__property Enabled = {default=1};
	__property Font;
	__property ItemHeight;
	__property Items;
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Sorted = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text;
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnDropDown;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property Version;
public:
	/* TASGCustomCombo.Create */ inline __fastcall virtual TASGComboBox(Classes::TComponent* AOwner) : TASGCustomCombo(AOwner) { }
	
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TASGComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TASGComboBox(HWND ParentWindow) : TASGCustomCombo(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Asgcombo */
using namespace Asgcombo;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AsgcomboHPP
