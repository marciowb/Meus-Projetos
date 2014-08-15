// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvofficebuttons.pas' rev: 21.00

#ifndef DbadvofficebuttonsHPP
#define DbadvofficebuttonsHPP

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
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Dbconsts.hpp>	// Pascal unit
#include <Advofficebuttons.hpp>	// Pascal unit
#include <Advgroupbox.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvofficebuttons
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBAdvOfficeCheckBox;
class PASCALIMPLEMENTATION TDBAdvOfficeCheckBox : public Advofficebuttons::TCustomAdvOfficeCheckBox
{
	typedef Advofficebuttons::TCustomAdvOfficeCheckBox inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	System::UnicodeString FValueUncheck;
	System::UnicodeString FValueCheck;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	Stdctrls::TCheckBoxState __fastcall GetFieldState(void);
	System::UnicodeString __fastcall GetDataField(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	void __fastcall SetValueCheck(const System::UnicodeString Value);
	void __fastcall SetValueUncheck(const System::UnicodeString Value);
	bool __fastcall ValueMatch(const System::UnicodeString ValueList, const System::UnicodeString Value);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetReadOnly(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	bool __fastcall GetCheckedEx(void);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TDBAdvOfficeCheckBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvOfficeCheckBox(void);
	virtual void __fastcall Toggle(void);
	__property bool Checked = {read=GetCheckedEx, nodefault};
	
__published:
	__property Action;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentColor = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnClick;
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
	__property Alignment;
	__property ButtonVertAlign = {default=0};
	__property Caption;
	__property DisabledFontColor = {default=8421504};
	__property Down = {default=0};
	__property Ellipsis = {default=0};
	__property Images;
	__property PictureContainer;
	__property ReturnIsTab;
	__property ShadowColor = {default=8421504};
	__property ShadowOffset = {default=1};
	__property ShowFocus = {default=1};
	__property State = {default=0};
	__property Themed = {default=0};
	__property URLColor = {default=16711680};
	__property OnAnchorClick;
	__property OnAnchorEnter;
	__property OnAnchorExit;
	__property Version;
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property System::UnicodeString ValueChecked = {read=FValueCheck, write=SetValueCheck};
	__property System::UnicodeString ValueUnchecked = {read=FValueUncheck, write=SetValueUncheck};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvOfficeCheckBox(HWND ParentWindow) : Advofficebuttons::TCustomAdvOfficeCheckBox(ParentWindow) { }
	
};


class DELPHICLASS TDBAdvOfficeRadioGroup;
class PASCALIMPLEMENTATION TDBAdvOfficeRadioGroup : public Advofficebuttons::TCustomAdvOfficeRadioGroup
{
	typedef Advofficebuttons::TCustomAdvOfficeRadioGroup inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	System::UnicodeString FValue;
	Classes::TStrings* FValues;
	bool FInSetValue;
	Classes::TNotifyEvent FOnChange;
	bool FIgnoreChange;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	bool __fastcall GetReadOnly(void);
	System::UnicodeString __fastcall GetButtonValue(int Index);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall SetValue(const System::UnicodeString Value);
	void __fastcall SetValues(Classes::TStrings* Value);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual bool __fastcall CanModify(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	__property Dbctrls::TFieldDataLink* DataLink = {read=FDataLink};
	
public:
	__fastcall virtual TDBAdvOfficeRadioGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvOfficeRadioGroup(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Db::TField* Field = {read=GetField};
	__property ItemIndex = {default=-1};
	__property System::UnicodeString Value = {read=FValue, write=SetValue};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property Caption;
	__property Color = {default=-16777211};
	__property Columns = {default=1};
	__property Ctl3D = {default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Items;
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Classes::TStrings* Values = {read=FValues, write=SetValues};
	__property Visible = {default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnClick;
	__property OnContextPopup;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnEndDock;
	__property OnStartDock;
	__property OnStartDrag;
	__property Alignment = {default=0};
	__property ButtonVertAlign = {default=0};
	__property DisabledFontColor = {default=8421504};
	__property Ellipsis;
	__property Images;
	__property PictureContainer;
	__property ShadowColor = {default=12632256};
	__property ShadowOffset = {default=1};
	__property ShowFocus = {default=1};
	__property OnIsEnabled;
	__property Version;
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvOfficeRadioGroup(HWND ParentWindow) : Advofficebuttons::TCustomAdvOfficeRadioGroup(ParentWindow) { }
	
};


class DELPHICLASS TDBAdvofficeCheckGroup;
class PASCALIMPLEMENTATION TDBAdvofficeCheckGroup : public Advofficebuttons::TCustomAdvOfficeCheckGroup
{
	typedef Advofficebuttons::TCustomAdvOfficeCheckGroup inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	bool FIgnoreChange;
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	HIDESBASE bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	HIDESBASE void __fastcall SetReadOnly(const bool Value);
	
protected:
	virtual bool __fastcall CanModify(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	__property Dbctrls::TFieldDataLink* DataLink = {read=FDataLink};
	
public:
	__fastcall virtual TDBAdvofficeCheckGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvofficeCheckGroup(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	__property Value;
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property Caption;
	__property Color = {default=-16777211};
	__property Columns = {default=1};
	__property Ctl3D = {default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Items;
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnEndDock;
	__property OnStartDock;
	__property OnStartDrag;
	__property Alignment = {default=0};
	__property ButtonVertAlign = {default=0};
	__property Ellipsis;
	__property DisabledFontColor = {default=8421504};
	__property Images;
	__property PictureContainer;
	__property ShadowColor = {default=12632256};
	__property ShadowOffset = {default=1};
	__property ShowFocus = {default=1};
	__property Version;
	__property OnIsEnabled;
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvofficeCheckGroup(HWND ParentWindow) : Advofficebuttons::TCustomAdvOfficeCheckGroup(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x3;

}	/* namespace Dbadvofficebuttons */
using namespace Dbadvofficebuttons;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvofficebuttonsHPP
