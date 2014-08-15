// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Btnlistb.pas' rev: 21.00

#ifndef BtnlistbHPP
#define BtnlistbHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Asgdd.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Btnlistb
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TOleDragStartEvent)(System::TObject* Sender, int DropIndex);

typedef void __fastcall (__closure *TOleDragStopEvent)(System::TObject* Sender, int OLEEffect);

typedef void __fastcall (__closure *TOleDragOverEvent)(System::TObject* Sender, bool &Allow);

typedef void __fastcall (__closure *TOleDropEvent)(System::TObject* Sender, int DropIndex);

class DELPHICLASS TPopupButton;
class PASCALIMPLEMENTATION TPopupButton : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	System::UnicodeString fCaption;
	bool fFlat;
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	virtual void __fastcall Paint(void);
	
__published:
	__property System::UnicodeString Caption = {read=fCaption, write=fCaption};
	__property bool Flat = {read=fFlat, write=fFlat, nodefault};
public:
	/* TCustomControl.Create */ inline __fastcall virtual TPopupButton(Classes::TComponent* AOwner) : Controls::TCustomControl(AOwner) { }
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TPopupButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPopupButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TButtonListbox;
class PASCALIMPLEMENTATION TButtonListbox : public Stdctrls::TCustomListBox
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	int FItemIndex;
	TPopupButton* FMoveButton;
	Types::TPoint FClickPos;
	bool FMouseDown;
	bool FOleDropTargetAssigned;
	TOleDropEvent FOnOleDrop;
	TOleDragStartEvent FOnOleDragStart;
	TOleDragStopEvent FOnOleDragStop;
	TOleDragOverEvent FOnOleDragOver;
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	void __fastcall SetItemIndexEx(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
protected:
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TButtonListbox(Classes::TComponent* aOwner);
	__fastcall virtual ~TButtonListbox(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall AddItemInt(System::UnicodeString s, int idx);
	
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
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName;
	__property ItemHeight = {default=16};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndexEx, nodefault};
	__property Items;
	__property ParentCtl3D = {default=1};
	__property ParentColor = {default=0};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
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
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property TOleDropEvent OnOleDrop = {read=FOnOleDrop, write=FOnOleDrop};
	__property TOleDragStartEvent OnOleDragStart = {read=FOnOleDragStart, write=FOnOleDragStart};
	__property TOleDragStopEvent OnOleDragStop = {read=FOnOleDragStop, write=FOnOleDragStop};
	__property TOleDragOverEvent OnOleDragOver = {read=FOnOleDragOver, write=FOnOleDragOver};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TButtonListbox(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	
};


class DELPHICLASS TListDropTarget;
class PASCALIMPLEMENTATION TListDropTarget : public Asgdd::TASGDropTarget
{
	typedef Asgdd::TASGDropTarget inherited;
	
private:
	TButtonListbox* FList;
	
public:
	__fastcall TListDropTarget(TButtonListbox* aList);
	virtual void __fastcall DropText(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DropCol(const Types::TPoint &pt, int col);
	virtual void __fastcall DragMouseMove(const Types::TPoint &pt, bool &Allow, Asgdd::TDropFormats DropFormats);
	virtual void __fastcall DragMouseLeave(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TListDropTarget(void) { }
	
};


class DELPHICLASS TListDropSource;
class PASCALIMPLEMENTATION TListDropSource : public Asgdd::TASGDropSource
{
	typedef Asgdd::TASGDropSource inherited;
	
private:
	TButtonListbox* FList;
	int FLastEffect;
	
public:
	__fastcall TListDropSource(TButtonListbox* aList);
	virtual void __fastcall CurrentEffect(int dwEffect);
	virtual void __fastcall QueryDrag(void);
	__property int LastEffect = {read=FLastEffect, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TListDropSource(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Btnlistb */
using namespace Btnlistb;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// BtnlistbHPP
