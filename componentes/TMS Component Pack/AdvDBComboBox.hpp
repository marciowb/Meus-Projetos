// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advdbcombobox.pas' rev: 21.00

#ifndef AdvdbcomboboxHPP
#define AdvdbcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Advcombo.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advdbcombobox
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvDBComboBoxStrings;
class PASCALIMPLEMENTATION TAdvDBComboBoxStrings : public Stdctrls::TCustomComboBoxStrings
{
	typedef Stdctrls::TCustomComboBoxStrings inherited;
	
private:
	System::UnicodeString __fastcall GetStoredStrings(int Index);
	void __fastcall PutStoredStrings(int Index, const System::UnicodeString Value);
	void __fastcall ReadStoredData(Classes::TReader* Reader);
	void __fastcall WriteStoredData(Classes::TWriter* Writer);
	
protected:
	Classes::TStringList* FStoredStrings;
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall CheckStoredStrings(void);
	virtual System::UnicodeString __fastcall Get(int Index);
	int __fastcall AddStored(System::UnicodeString StoredS)/* overload */;
	
public:
	__fastcall virtual TAdvDBComboBoxStrings(void);
	__fastcall virtual ~TAdvDBComboBoxStrings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual int __fastcall Add(const System::UnicodeString S);
	int __fastcall AddStored(const System::UnicodeString S, System::UnicodeString StoredS)/* overload */;
	int __fastcall AddStoredObject(const System::UnicodeString S, System::UnicodeString StoredS, System::TObject* AObject);
	virtual void __fastcall Insert(int Index, const System::UnicodeString S);
	void __fastcall InsertStored(int Index, const System::UnicodeString S, System::UnicodeString StoredS);
	virtual void __fastcall Clear(void);
	void __fastcall ClearAll(void);
	virtual void __fastcall Delete(int Index);
	int __fastcall IndexOfStored(System::UnicodeString s);
	__property System::UnicodeString StoredStrings[int Index] = {read=GetStoredStrings, write=PutStoredStrings};
};


class DELPHICLASS TAdvDBComboBox;
class PASCALIMPLEMENTATION TAdvDBComboBox : public Advcombo::TAdvCustomCombo
{
	typedef Advcombo::TAdvCustomCombo inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	Imglist::TCustomImageList* FImages;
	bool FShowImages;
	System::UnicodeString FLabelField;
	void __fastcall ActiveChange(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetComboText(void);
	System::UnicodeString __fastcall GetDataField(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetComboText(const System::UnicodeString Value);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetEditReadOnly(void);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	System::UnicodeString __fastcall GetStoredStrings(int Index);
	void __fastcall PutStoredStrings(int Index, const System::UnicodeString Value);
	TAdvDBComboBoxStrings* __fastcall GetAdvItems(void);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetShowImages(const bool Value);
	void __fastcall SetLabelField(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetLabelField(void);
	
protected:
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall ComboWndProc(Messages::TMessage &Message, HWND ComboWnd, void * ComboProc);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall DropDown(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetItems(const Classes::TStrings* Value);
	virtual void __fastcall SetStyle(Stdctrls::TComboBoxStyle Value);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual Stdctrls::TCustomComboBoxStringsClass __fastcall GetItemsClass(void);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall UpdateDBLabel(void);
	bool __fastcall CheckDataSet(void);
	virtual int __fastcall GetVersionNr(void);
	__property TAdvDBComboBoxStrings* AdvItems = {read=GetAdvItems};
	
public:
	__fastcall virtual TAdvDBComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvDBComboBox(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	HIDESBASE void __fastcall AddItem(System::UnicodeString Item, System::UnicodeString StoredValue, System::TObject* AObject);
	virtual void __fastcall Clear(void);
	void __fastcall AddDisplayAndStoredValue(System::UnicodeString Displayed, System::UnicodeString Stored);
	System::UnicodeString __fastcall StoredToDispText(System::UnicodeString StoredText);
	System::UnicodeString __fastcall GetDisplayValue(int Index);
	System::UnicodeString __fastcall GetStoredValue(int Index);
	__property System::UnicodeString StoredStrings[int Index] = {read=GetStoredStrings, write=PutStoredStrings};
	__property Db::TField* Field = {read=GetField};
	__property Text;
	
__published:
	__property Style = {default=0};
	__property Align = {default=0};
	__property AutoComplete = {default=1};
	__property AutoFocus = {default=0};
	__property AutoDropDown = {default=0};
	__property BevelWidth = {default=1};
	__property ButtonWidth = {default=19};
	__property CharCase = {default=0};
	__property Color;
	__property Ctl3D;
	__property DisabledBorder = {default=1};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property DropDownCount = {default=8};
	__property DropWidth;
	__property Flat = {default=0};
	__property FlatLineColor = {default=0};
	__property FlatParentColor = {default=1};
	__property Etched = {default=0};
	__property FocusBorder = {default=0};
	__property FocusBorderColor = {default=536870911};
	__property FocusColor = {default=536870911};
	__property Enabled;
	__property Font;
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property ImeMode = {default=3};
	__property ImeName;
	__property ItemIndex;
	__property ItemHeight;
	__property Items = {write=SetItems};
	__property LabelCaption;
	__property System::UnicodeString LabelField = {read=GetLabelField, write=SetLabelField};
	__property LabelPosition = {default=0};
	__property LabelMargin = {default=4};
	__property LabelTransparent = {default=0};
	__property LabelAlwaysEnabled = {default=0};
	__property LabelFont;
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property ShowHint;
	__property bool ShowImages = {read=FShowImages, write=SetShowImages, default=0};
	__property Sorted = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible;
	__property OnChange;
	__property OnClick;
	__property OnContextPopup;
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
	__property OnDropUp;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property BevelKind = {default=0};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelEdges = {default=15};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvDBComboBox(HWND ParentWindow) : Advcombo::TAdvCustomCombo(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advdbcombobox */
using namespace Advdbcombobox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvdbcomboboxHPP
