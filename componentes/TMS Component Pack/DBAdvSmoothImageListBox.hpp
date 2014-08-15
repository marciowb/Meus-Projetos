// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvsmoothimagelistbox.pas' rev: 21.00

#ifndef DbadvsmoothimagelistboxHPP
#define DbadvsmoothimagelistboxHPP

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
#include <Advsmoothimagelistbox.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvsmoothimagelistbox
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TImageListBoxDataBinding;
class DELPHICLASS TDBAdvSmoothImageListBox;
class PASCALIMPLEMENTATION TImageListBoxDataBinding : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TDBAdvSmoothImageListBox* FOwner;
	Classes::TNotifyEvent FOnChange;
	System::UnicodeString FCaptionField;
	System::UnicodeString FHintField;
	System::UnicodeString FImageField;
	System::UnicodeString FCaptionTemplate;
	void __fastcall SetCaptionField(const System::UnicodeString Value);
	void __fastcall SetImageField(const System::UnicodeString Value);
	void __fastcall SetHintField(const System::UnicodeString Value);
	TDBAdvSmoothImageListBox* __fastcall GetDBImageListBox(void);
	void __fastcall SetCaptionTemplate(const System::UnicodeString Value);
	
protected:
	void __fastcall Changed(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TImageListBoxDataBinding(TDBAdvSmoothImageListBox* AOwner);
	__fastcall virtual ~TImageListBoxDataBinding(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TDBAdvSmoothImageListBox* DBAdvSmoothImageListBox = {read=GetDBImageListBox};
	
__published:
	__property System::UnicodeString CaptionField = {read=FCaptionField, write=SetCaptionField};
	__property System::UnicodeString CaptionTemplate = {read=FCaptionTemplate, write=SetCaptionTemplate};
	__property System::UnicodeString ImageField = {read=FImageField, write=SetImageField};
	__property System::UnicodeString HintField = {read=FHintField, write=SetHintField};
};


class DELPHICLASS TAdvListBoxDataLink;
class PASCALIMPLEMENTATION TAdvListBoxDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	TDBAdvSmoothImageListBox* FListBox;
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
	__fastcall TAdvListBoxDataLink(TDBAdvSmoothImageListBox* AListBox);
	__fastcall virtual ~TAdvListBoxDataLink(void);
	void __fastcall Modified(void);
	void __fastcall Reset(void);
	__property TDBAdvSmoothImageListBox* ListBox = {read=FListBox};
};


typedef void __fastcall (__closure *TDataBindEvent)(System::TObject* Sender, Advsmoothimagelistbox::TAdvSmoothImageListBoxItem* Item, Db::TFields* DBFields);

typedef void __fastcall (__closure *THTMLTemplateDataEvent)(System::TObject* Sender, int ItemIndex, System::UnicodeString FieldName, System::UnicodeString &Data);

class PASCALIMPLEMENTATION TDBAdvSmoothImageListBox : public Advsmoothimagelistbox::TAdvSmoothImageListBox
{
	typedef Advsmoothimagelistbox::TAdvSmoothImageListBox inherited;
	
private:
	TAdvListBoxDataLink* FDataLink;
	TImageListBoxDataBinding* FDataBinding;
	bool FPageMode;
	bool FInternalChange;
	bool FInternalSelectItem;
	TDataBindEvent FOnDataBind;
	THTMLTemplateDataEvent FOnGetCaptionTemplateData;
	void __fastcall ActiveChange(bool Value);
	void __fastcall EditingChanged(void);
	void __fastcall DataScroll(int Distance);
	void __fastcall RecordChanged(Db::TField* Field);
	void __fastcall DataChange(void);
	void __fastcall UpdateData(void);
	void __fastcall OnDataBindingChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	void __fastcall UpdateActiveItem(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall SetDataBinding(const TImageListBoxDataBinding* Value);
	void __fastcall SetPageMode(const bool Value);
	int __fastcall GetSelectedIndex(void);
	bool __fastcall IsCachedNormalEmpty(Advsmoothimagelistbox::TAdvSmoothImageListBoxItem* Item);
	void __fastcall UpdateDataBuffer(void);
	
protected:
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall LoadItemData(Advsmoothimagelistbox::TAdvSmoothImageListBoxItem* Item);
	virtual void __fastcall DoItemText(Advsmoothimagelistbox::TAdvSmoothImageListBoxItem* Item);
	virtual void __fastcall DoItemImage(Advsmoothimagelistbox::TAdvSmoothImageListBoxItem* Item);
	virtual void __fastcall DoSelectItem(int NewItemIndex);
	virtual void __fastcall SelectImage(System::Word Key, int &itemindex, bool itemselect);
	virtual void __fastcall SetMultiSelect(bool Value);
	virtual void __fastcall DoItemPropertyChange(Advsmoothimagelistbox::TAdvSmoothImageListBoxItem* Item, int PropID, bool &Value);
	virtual void __fastcall DoSmoothScroll(double CurrentPosition, double EndPosition);
	virtual void __fastcall DoLookup(int ItemIndex);
	void __fastcall ClearImageCache(int FromIndex);
	bool __fastcall CheckDataSet(void);
	int __fastcall GetRecordCount(void);
	void __fastcall UpdateItemCount(void);
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=1};
	System::UnicodeString __fastcall HTMLDBReplace(System::UnicodeString s, Db::TDataSet* Dataset, int ItemIndex, THTMLTemplateDataEvent DataEvent);
	
public:
	__fastcall virtual TDBAdvSmoothImageListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvSmoothImageListBox(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	DYNAMIC void __fastcall MouseWheelHandler(Messages::TMessage &Message);
	void __fastcall LoadFromDataSet(void);
	void __fastcall Reload(void);
	
__published:
	__property TImageListBoxDataBinding* DataBinding = {read=FDataBinding, write=SetDataBinding};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool PageMode = {read=FPageMode, write=SetPageMode, default=1};
	__property TDataBindEvent OnDataBind = {read=FOnDataBind, write=FOnDataBind};
	__property THTMLTemplateDataEvent OnGetCaptionTemplateData = {read=FOnGetCaptionTemplateData, write=FOnGetCaptionTemplateData};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvSmoothImageListBox(HWND ParentWindow) : Advsmoothimagelistbox::TAdvSmoothImageListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbadvsmoothimagelistbox */
using namespace Dbadvsmoothimagelistbox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvsmoothimagelistboxHPP
