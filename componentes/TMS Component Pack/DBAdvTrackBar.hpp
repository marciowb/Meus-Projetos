// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvtrackbar.pas' rev: 21.00

#ifndef DbadvtrackbarHPP
#define DbadvtrackbarHPP

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
#include <Dialogs.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Advtrackbar.hpp>	// Pascal unit
#include <Gdipicture.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvtrackbar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TTrackFieldDataLink;
class PASCALIMPLEMENTATION TTrackFieldDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	Db::TField* FField;
	System::UnicodeString FFieldName;
	Classes::TComponent* FControl;
	bool FEditing;
	bool FModified;
	Classes::TNotifyEvent FOnDataChange;
	Classes::TNotifyEvent FOnEditingChange;
	Classes::TNotifyEvent FOnUpdateData;
	Classes::TNotifyEvent FOnActiveChange;
	bool __fastcall GetCanModify(void);
	HIDESBASE void __fastcall SetEditing(bool Value);
	void __fastcall SetField(Db::TField* Value);
	void __fastcall SetFieldName(const System::UnicodeString Value);
	void __fastcall UpdateField(void);
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataEvent(Db::TDataEvent Event, int Info);
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall FocusControl(Db::TFieldRef Field);
	virtual void __fastcall LayoutChanged(void);
	virtual void __fastcall RecordChanged(Db::TField* Field);
	virtual void __fastcall UpdateData(void);
	
public:
	__fastcall TTrackFieldDataLink(void);
	HIDESBASE bool __fastcall Edit(void);
	void __fastcall Modified(void);
	void __fastcall Reset(void);
	__property bool CanModify = {read=GetCanModify, nodefault};
	__property Classes::TComponent* Control = {read=FControl, write=FControl};
	__property bool Editing = {read=FEditing, nodefault};
	__property Db::TField* Field = {read=FField};
	__property System::UnicodeString FieldName = {read=FFieldName, write=SetFieldName};
	__property Classes::TNotifyEvent OnDataChange = {read=FOnDataChange, write=FOnDataChange};
	__property Classes::TNotifyEvent OnEditingChange = {read=FOnEditingChange, write=FOnEditingChange};
	__property Classes::TNotifyEvent OnUpdateData = {read=FOnUpdateData, write=FOnUpdateData};
	__property Classes::TNotifyEvent OnActiveChange = {read=FOnActiveChange, write=FOnActiveChange};
public:
	/* TDataLink.Destroy */ inline __fastcall virtual ~TTrackFieldDataLink(void) { }
	
};


class DELPHICLASS TDBAdvTrackBar;
class PASCALIMPLEMENTATION TDBAdvTrackBar : public Advtrackbar::TCustomTrackBar
{
	typedef Advtrackbar::TCustomTrackBar inherited;
	
private:
	TTrackFieldDataLink* FDataLink;
	bool FFocused;
	bool FInternalChange;
	void __fastcall ActiveChange(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetFocused(bool Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	
protected:
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetPosition(int Value);
	bool __fastcall ValidField(void);
	
public:
	__fastcall virtual TDBAdvTrackBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvTrackBar(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	__property Db::TField* Field = {read=GetField};
	__property Position = {default=0};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BackGroundStretched = {default=0};
	__property BackGround;
	__property BackGroundDisabled;
	__property BorderColor;
	__property BorderColorDisabled;
	__property Buttons;
	__property ColorTo;
	__property ColorDisabled;
	__property ColorDisabledTo;
	__property Ctl3D;
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Direction;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Constraints;
	__property Color = {default=-16777211};
	__property HelpContext = {default=0};
	__property Hint;
	__property Max = {default=10};
	__property Min = {default=0};
	__property Orientation = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentShowHint = {default=1};
	__property PageSize = {default=1};
	__property PopupMenu;
	__property RateActive;
	__property RateInActive;
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property ShowHint;
	__property Slider;
	__property ShowFocus = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Thumb;
	__property TickMark;
	__property TickImages;
	__property TrackHint;
	__property TrackLabel;
	__property Transparent = {default=1};
	__property Visible = {default=1};
	__property OnContextPopup;
	__property OnChange;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnDrawTick;
	__property OnGetTrackHint;
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvTrackBar(HWND ParentWindow) : Advtrackbar::TCustomTrackBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbadvtrackbar */
using namespace Dbadvtrackbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvtrackbarHPP
