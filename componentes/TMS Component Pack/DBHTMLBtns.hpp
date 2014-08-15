// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbhtmlbtns.pas' rev: 21.00

#ifndef DbhtmlbtnsHPP
#define DbhtmlbtnsHPP

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
#include <Htmlbtns.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Dbconsts.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbhtmlbtns
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBHTMLCheckBox;
class PASCALIMPLEMENTATION TDBHTMLCheckBox : public Htmlbtns::TCustomHTMLCheckBox
{
	typedef Htmlbtns::TCustomHTMLCheckBox inherited;
	
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
	
public:
	__fastcall virtual TDBHTMLCheckBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBHTMLCheckBox(void);
	virtual void __fastcall Toggle(void);
	__property bool Checked = {read=GetCheckedEx, nodefault};
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property System::UnicodeString ValueChecked = {read=FValueCheck, write=SetValueCheck};
	__property System::UnicodeString ValueUnchecked = {read=FValueUncheck, write=SetValueUncheck};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBHTMLCheckBox(HWND ParentWindow) : Htmlbtns::TCustomHTMLCheckBox(ParentWindow) { }
	
};


class DELPHICLASS TDBHTMLRadioGroup;
class PASCALIMPLEMENTATION TDBHTMLRadioGroup : public Htmlbtns::TCustomHTMLRadioGroup
{
	typedef Htmlbtns::TCustomHTMLRadioGroup inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	System::UnicodeString FValue;
	Classes::TStrings* FValues;
	bool FInSetValue;
	Classes::TNotifyEvent FOnChange;
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
	__fastcall virtual TDBHTMLRadioGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBHTMLRadioGroup(void);
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
	__property ButtonType = {default=0};
	__property Caption;
	__property Color = {default=-16777211};
	__property Columns = {default=1};
	__property Ctl3D;
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Items;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
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
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBHTMLRadioGroup(HWND ParentWindow) : Htmlbtns::TCustomHTMLRadioGroup(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Dbhtmlbtns */
using namespace Dbhtmlbtns;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbhtmlbtnsHPP
