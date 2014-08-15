// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvsmoothcombobox.pas' rev: 21.00

#ifndef DbadvsmoothcomboboxHPP
#define DbadvsmoothcomboboxHPP

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
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advsmoothlistbox.hpp>	// Pascal unit
#include <Advsmoothcombobox.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvsmoothcombobox
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TComboBoxDataBinding;
class DELPHICLASS TDBAdvSmoothComboBox;
class PASCALIMPLEMENTATION TComboBoxDataBinding : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TDBAdvSmoothComboBox* FOwner;
	Classes::TNotifyEvent FOnChange;
	System::UnicodeString FCaptionField;
	System::UnicodeString FGraphicRightField;
	System::UnicodeString FInfoField;
	System::UnicodeString FCheckedField;
	System::UnicodeString FHintField;
	System::UnicodeString FNotesField;
	System::UnicodeString FProgressValueField;
	System::UnicodeString FGraphicLeftField;
	System::UnicodeString FNotesTemplate;
	System::UnicodeString FCaptionTemplate;
	void __fastcall SetCaptionField(const System::UnicodeString Value);
	void __fastcall SetCheckedField(const System::UnicodeString Value);
	void __fastcall SetGraphicLeftField(const System::UnicodeString Value);
	void __fastcall SetGraphicRightField(const System::UnicodeString Value);
	void __fastcall SetHintField(const System::UnicodeString Value);
	void __fastcall SetInfoField(const System::UnicodeString Value);
	void __fastcall SetNotesField(const System::UnicodeString Value);
	void __fastcall SetProgressValueField(const System::UnicodeString Value);
	TDBAdvSmoothComboBox* __fastcall GetDBComboBox(void);
	void __fastcall SetCaptionTemplate(const System::UnicodeString Value);
	void __fastcall SetNotesTemplate(const System::UnicodeString Value);
	
protected:
	void __fastcall Changed(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TComboBoxDataBinding(TDBAdvSmoothComboBox* AOwner);
	__fastcall virtual ~TComboBoxDataBinding(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TDBAdvSmoothComboBox* DBAdvSmoothComboBox = {read=GetDBComboBox};
	
__published:
	__property System::UnicodeString CaptionField = {read=FCaptionField, write=SetCaptionField};
	__property System::UnicodeString CaptionTemplate = {read=FCaptionTemplate, write=SetCaptionTemplate};
	__property System::UnicodeString CheckedField = {read=FCheckedField, write=SetCheckedField};
	__property System::UnicodeString NotesField = {read=FNotesField, write=SetNotesField};
	__property System::UnicodeString NotesTemplate = {read=FNotesTemplate, write=SetNotesTemplate};
	__property System::UnicodeString InfoField = {read=FInfoField, write=SetInfoField};
	__property System::UnicodeString HintField = {read=FHintField, write=SetHintField};
	__property System::UnicodeString GraphicLeftField = {read=FGraphicLeftField, write=SetGraphicLeftField};
	__property System::UnicodeString GraphicRightField = {read=FGraphicRightField, write=SetGraphicRightField};
	__property System::UnicodeString ProgressValueField = {read=FProgressValueField, write=SetProgressValueField};
};


class DELPHICLASS TAdvComboBoxDataLink;
class PASCALIMPLEMENTATION TAdvComboBoxDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	TDBAdvSmoothComboBox* FComboBox;
	bool FModified;
	bool FInUpdateData;
	bool FLockEffects;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall DataSetScrolled(int Distance);
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall LayoutChanged(void);
	virtual void __fastcall RecordChanged(Db::TField* Field);
	virtual void __fastcall UpdateData(void);
	
public:
	__fastcall TAdvComboBoxDataLink(TDBAdvSmoothComboBox* AComboBox);
	__fastcall virtual ~TAdvComboBoxDataLink(void);
	void __fastcall Modified(void);
	void __fastcall Reset(void);
	__property TDBAdvSmoothComboBox* ComboBox = {read=FComboBox};
};


typedef void __fastcall (__closure *TDataBindEvent)(System::TObject* Sender, Advsmoothlistbox::TAdvSmoothListBoxItem* Item, Db::TFields* DBFields);

typedef void __fastcall (__closure *THTMLTemplateDataEvent)(System::TObject* Sender, int ItemIndex, System::UnicodeString FieldName, System::UnicodeString &Data);

class PASCALIMPLEMENTATION TDBAdvSmoothComboBox : public Advsmoothcombobox::TAdvSmoothComboBox
{
	typedef Advsmoothcombobox::TAdvSmoothComboBox inherited;
	
private:
	TAdvComboBoxDataLink* FDataLink;
	TComboBoxDataBinding* FDataBinding;
	bool FPageMode;
	int FOldTopIndex;
	bool FInternalChange;
	bool FInternalSelectItem;
	TDataBindEvent FOnDataBind;
	THTMLTemplateDataEvent FOnGetNotesTemplateData;
	THTMLTemplateDataEvent FOnGetCaptionTemplateData;
	void __fastcall ActiveChange(bool Value);
	void __fastcall EditingChanged(void);
	void __fastcall DataScroll(int Distance);
	void __fastcall RecordChanged(Db::TField* Field);
	void __fastcall DataChange(void);
	void __fastcall UpdateData(void);
	void __fastcall UpdateActiveItem(void);
	void __fastcall UpdateTopIndex(void);
	void __fastcall OnDataBindingChanged(System::TObject* Sender);
	Db::TDataSource* __fastcall GetDataSource(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	void __fastcall SetDataBinding(const TComboBoxDataBinding* Value);
	void __fastcall SetPageMode(const bool Value);
	int __fastcall GetSelectedIndex(void);
	System::UnicodeString __fastcall HTMLDBReplace(System::UnicodeString s, Db::TDataSet* Dataset, int ItemIndex, THTMLTemplateDataEvent DataEvent);
	
protected:
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall InitPreview(void);
	virtual void __fastcall DoItemText(System::TObject* Sender, int itemindex, System::UnicodeString &itemcaption, System::UnicodeString &iteminfo, System::UnicodeString &itemnotes);
	virtual void __fastcall DoItemGraphics(System::TObject* Sender, int itemindex);
	virtual void __fastcall DoScroll(System::TObject* Sender, double CurrentPosition, double EndPosition);
	virtual void __fastcall DoSmoothScroll(double CurrentPosition, double EndPosition);
	virtual void __fastcall DoLookup(Advsmoothlistbox::TAdvSmoothListBoxDisplayListItem* DispItem);
	virtual void __fastcall DoBoolPropertyChange(Advsmoothlistbox::TAdvSmoothListBoxItem* Item, int PropID, bool &Value);
	virtual void __fastcall SetSelectionMode(const Advsmoothlistbox::TAdvSmoothListBoxSelectionMode Value);
	virtual bool __fastcall DoItemCheckToggle(Advsmoothlistbox::TAdvSmoothListBoxItem* Item, bool GraphicLeft, bool &Checked);
	virtual void __fastcall DoInternalScroll(void);
	virtual bool __fastcall LookupBarVisible(void);
	virtual void __fastcall DoItemClick(System::TObject* Sender, int itemindex);
	virtual void __fastcall SetInternalSelectedItemIndex(int Value);
	virtual void __fastcall DoSelectItem(int NewItemIndex);
	bool __fastcall CheckDataSet(void);
	int __fastcall GetRecordCount(void);
	void __fastcall UpdateItemCount(void);
	virtual Advsmoothlistbox::TAdvSmoothListBox* __fastcall CreateListBox(void);
	
public:
	__fastcall virtual TDBAdvSmoothComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvSmoothComboBox(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall LoadFromDataSet(void);
	void __fastcall Reload(void);
	virtual void __fastcall DropDown(void);
	
__published:
	__property TComboBoxDataBinding* DataBinding = {read=FDataBinding, write=SetDataBinding};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool PageMode = {read=FPageMode, write=SetPageMode, default=1};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=1};
	__property TDataBindEvent OnDataBind = {read=FOnDataBind, write=FOnDataBind};
	__property THTMLTemplateDataEvent OnGetCaptionTemplateData = {read=FOnGetCaptionTemplateData, write=FOnGetCaptionTemplateData};
	__property THTMLTemplateDataEvent OnGetNotesTemplateData = {read=FOnGetNotesTemplateData, write=FOnGetNotesTemplateData};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvSmoothComboBox(HWND ParentWindow) : Advsmoothcombobox::TAdvSmoothComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbadvsmoothcombobox */
using namespace Dbadvsmoothcombobox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvsmoothcomboboxHPP
