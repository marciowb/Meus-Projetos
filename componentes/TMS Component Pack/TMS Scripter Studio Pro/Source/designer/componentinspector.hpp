// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Componentinspector.pas' rev: 21.00

#ifndef ComponentinspectorHPP
#define ComponentinspectorHPP

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
#include <Sysutils.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Inspectorcontrols.hpp>	// Pascal unit
#include <Propertylist.hpp>	// Pascal unit
#include <Propertyinspeditors.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Componentinspector
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TCompInspMode { imProperties, imEvents };
#pragma option pop

typedef void __fastcall (__closure *TNotifyComponentEvent)(System::TObject* Sender, Classes::TComponent* TheComponent);

typedef void __fastcall (__closure *TIndexComponentEvent)(System::TObject* Sender, Classes::TComponent* TheComponent, int &Index);

typedef void __fastcall (__closure *TSetStringEnableEvent)(System::TObject* Sender, int TheIndex, System::UnicodeString &Value, bool &EnableDefault);

typedef void __fastcall (__closure *TEditorClassEvent)(System::TObject* Sender, int TheIndex, Propertyinspeditors::TPropertyEditorClass &Value);

typedef void __fastcall (__closure *TPropFilterEvent)(System::TObject* Sender, Propertylist::TProperty* Prop, bool &Result);

typedef void __fastcall (__closure *TPropCompareEvent)(System::TObject* Sender, Propertylist::TProperty* Prop1, Propertylist::TProperty* Prop2, int &Result);

typedef void __fastcall (__closure *TFillEventListEvent)(System::TObject* Sender, Typinfo::PTypeInfo EventType, Classes::TStrings* Strings);

class DELPHICLASS TAdvComponentInspector;
typedef void __fastcall (__closure *TCustomizeInspectorEvent)(System::TObject* Sender, TAdvComponentInspector* Inspector);

typedef void __fastcall (__closure *TFilterComponentEvent)(System::TObject* Sender, Classes::TComponent* AComponent, bool &EnableAdd);

typedef void __fastcall (__closure *TGetComponentTextEvent)(System::TObject* Sender, Classes::TComponent* AComponent, System::UnicodeString &Text);

class DELPHICLASS TCustomComponentTree;
class DELPHICLASS TAdvCustomComponentInspector;
class PASCALIMPLEMENTATION TCustomComponentTree : public Comctrls::TCustomTreeView
{
	typedef Comctrls::TCustomTreeView inherited;
	
private:
	bool FFilled;
	bool FIgnoreUpdate;
	Classes::TComponent* FRoot;
	Classes::TComponent* FInstance;
	TAdvCustomComponentInspector* FComponentInspector;
	bool FShowNonVisual;
	TNotifyComponentEvent FOnSelect;
	TFilterComponentEvent FOnFilter;
	TGetComponentTextEvent FOnGetText;
	TGetComponentTextEvent FOnEditText;
	TIndexComponentEvent FOnComponentImage;
	void __fastcall SetRoot(const Classes::TComponent* Value);
	void __fastcall SetInstance(const Classes::TComponent* Value);
	void __fastcall SetComponentInspector(const TAdvCustomComponentInspector* Value);
	void __fastcall SetShowNonVisual(const bool Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall Change(Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Edit(const tagTVITEMW &Item);
	virtual bool __fastcall Filter(Classes::TComponent* AComponent);
	HIDESBASE virtual System::UnicodeString __fastcall GetText(Classes::TComponent* AComponent);
	virtual void __fastcall EditText(Classes::TComponent* AComponent, System::UnicodeString &AText);
	virtual void __fastcall SelectInstance(Classes::TComponent* AComponent);
	virtual int __fastcall GetComponentImage(Classes::TComponent* AComponent);
	MESSAGE void __fastcall CMOIUpdated(Messages::TMessage &Message);
	__property Classes::TComponent* Root = {read=FRoot, write=SetRoot};
	__property Classes::TComponent* Instance = {read=FInstance, write=SetInstance};
	__property TAdvCustomComponentInspector* ComponentInspector = {read=FComponentInspector, write=SetComponentInspector};
	__property bool ShowNonVisual = {read=FShowNonVisual, write=SetShowNonVisual, default=0};
	__property TNotifyComponentEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property TFilterComponentEvent OnFilter = {read=FOnFilter, write=FOnFilter};
	__property TGetComponentTextEvent OnGetText = {read=FOnGetText, write=FOnGetText};
	__property TGetComponentTextEvent OnEditText = {read=FOnEditText, write=FOnEditText};
	__property TIndexComponentEvent OnComponentImage = {read=FOnComponentImage, write=FOnComponentImage};
	
public:
	Comctrls::TTreeNode* __fastcall GetComponentNode(Classes::TComponent* AComponent);
	void __fastcall AddComponent(Classes::TComponent* AComponent);
	void __fastcall DeleteComponent(Classes::TComponent* AComponent);
	void __fastcall RefreshTree(void);
public:
	/* TCustomTreeView.Create */ inline __fastcall virtual TCustomComponentTree(Classes::TComponent* AOwner) : Comctrls::TCustomTreeView(AOwner) { }
	/* TCustomTreeView.Destroy */ inline __fastcall virtual ~TCustomComponentTree(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomComponentTree(HWND ParentWindow) : Comctrls::TCustomTreeView(ParentWindow) { }
	
};


class DELPHICLASS TComponentTree;
class PASCALIMPLEMENTATION TComponentTree : public TCustomComponentTree
{
	typedef TCustomComponentTree inherited;
	
__published:
	__property Anchors = {default=3};
	__property BiDiMode;
	__property BorderWidth = {default=0};
	__property Constraints;
	__property AutoExpand = {default=0};
	__property ChangeDelay = {default=0};
	__property HotTrack = {default=0};
	__property RightClickSelect = {default=0};
	__property RowSelect = {default=0};
	__property ToolTips = {default=1};
	__property OnCustomDraw;
	__property OnCustomDrawItem;
	__property OnEndDock;
	__property OnStartDock;
	__property Align = {default=0};
	__property BorderStyle = {default=1};
	__property Ctl3D;
	__property Color = {default=-16777211};
	__property HelpContext = {default=0};
	__property ParentCtl3D = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property DragMode = {default=0};
	__property HideSelection = {default=1};
	__property Images;
	__property Indent;
	__property Items;
	__property ReadOnly = {default=0};
	__property ShowButtons = {default=1};
	__property ShowLines = {default=1};
	__property ShowRoot = {default=1};
	__property SortType = {default=0};
	__property StateImages;
	__property Root;
	__property Instance;
	__property ComponentInspector;
	__property ShowNonVisual = {default=0};
	__property OnSelect;
	__property OnFilter;
	__property OnGetText;
	__property OnEditText;
	__property OnComponentImage;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
public:
	/* TCustomTreeView.Create */ inline __fastcall virtual TComponentTree(Classes::TComponent* AOwner) : TCustomComponentTree(AOwner) { }
	/* TCustomTreeView.Destroy */ inline __fastcall virtual ~TComponentTree(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TComponentTree(HWND ParentWindow) : TCustomComponentTree(ParentWindow) { }
	
};


class DELPHICLASS TAdvCustomComponentComboBox;
class PASCALIMPLEMENTATION TAdvCustomComponentComboBox : public Stdctrls::TCustomComboBox
{
	typedef Stdctrls::TCustomComboBox inherited;
	
private:
	Classes::TComponent* FRoot;
	TAdvCustomComponentInspector* FComponentInspector;
	TFilterComponentEvent FOnFilter;
	TGetComponentTextEvent FOnGetComponentText;
	int FSynchroLockCount;
	void __fastcall SetRoot(const Classes::TComponent* Value);
	Classes::TComponent* __fastcall GetInstance(void);
	void __fastcall SetInstance(const Classes::TComponent* Value);
	void __fastcall SetComponentInspector(const TAdvCustomComponentInspector* Value);
	void __fastcall ComboChange(void);
	
protected:
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual Classes::TComponent* __fastcall TranslateComponent(Classes::TComponent* AComponent);
	virtual bool __fastcall Filter(Classes::TComponent* AComponent);
	virtual System::UnicodeString __fastcall GetComponentText(Classes::TComponent* AComponent);
	MESSAGE void __fastcall CMOIUpdated(Messages::TMessage &Message);
	
public:
	__fastcall virtual TAdvCustomComponentComboBox(Classes::TComponent* AOwner);
	void __fastcall RefreshList(void);
	void __fastcall SynchroLock(void);
	void __fastcall SynchroUnlock(void);
	__property Classes::TComponent* Root = {read=FRoot, write=SetRoot};
	__property Classes::TComponent* Instance = {read=GetInstance, write=SetInstance};
	__property TAdvCustomComponentInspector* ComponentInspector = {read=FComponentInspector, write=SetComponentInspector};
	__property TFilterComponentEvent OnFilter = {read=FOnFilter, write=FOnFilter};
	__property TGetComponentTextEvent OnGetComponentText = {read=FOnGetComponentText, write=FOnGetComponentText};
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TAdvCustomComponentComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomComponentComboBox(HWND ParentWindow) : Stdctrls::TCustomComboBox(ParentWindow) { }
	
};


class DELPHICLASS TAdvComponentComboBox;
class PASCALIMPLEMENTATION TAdvComponentComboBox : public TAdvCustomComponentComboBox
{
	typedef TAdvCustomComponentComboBox inherited;
	
__published:
	__property Anchors = {default=3};
	__property Constraints;
	__property Root;
	__property Instance;
	__property ComponentInspector;
	__property OnFilter;
	__property OnGetComponentText;
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property DropDownCount = {default=8};
	__property Enabled = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Sorted = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
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
public:
	/* TAdvCustomComponentComboBox.Create */ inline __fastcall virtual TAdvComponentComboBox(Classes::TComponent* AOwner) : TAdvCustomComponentComboBox(AOwner) { }
	
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TAdvComponentComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvComponentComboBox(HWND ParentWindow) : TAdvCustomComponentComboBox(ParentWindow) { }
	
};


class DELPHICLASS TCompInspProperty;
class DELPHICLASS TCompInspList;
class PASCALIMPLEMENTATION TCompInspProperty : public Propertylist::TProperty
{
	typedef Propertylist::TProperty inherited;
	
private:
	TCompInspList* FCompInspList;
	
public:
	__fastcall TCompInspProperty(Propertylist::TPropertyList* AOwner, Classes::TComponent* ARoot, Classes::TComponent* AInstance, Typinfo::PPropInfo APropInfo, Propertylist::TCustomPropData* APropData, TCompInspList* ACompInspList);
	virtual Propertylist::TPropertyList* __fastcall CreatePropertyList(void);
public:
	/* TProperty.Create */ inline __fastcall virtual TCompInspProperty(Propertylist::TPropertyList* AOwner, Classes::TComponent* ARoot, Classes::TComponent* AInstance, Typinfo::PPropInfo APropInfo, Propertylist::TCustomPropData* APropData) : Propertylist::TProperty(AOwner, ARoot, AInstance, APropInfo, APropData) { }
	/* TProperty.Destroy */ inline __fastcall virtual ~TCompInspProperty(void) { }
	
};


class DELPHICLASS TCompInspPropertyList;
class PASCALIMPLEMENTATION TCompInspPropertyList : public Propertylist::TPropertyList
{
	typedef Propertylist::TPropertyList inherited;
	
private:
	TCompInspList* FCompInspList;
	TCompInspMode FMode;
	void __fastcall SetMode(const TCompInspMode Value);
	
public:
	__fastcall TCompInspPropertyList(Propertylist::TProperty* AOwner, TCompInspList* ACompInspList);
	virtual Propertylist::TProperty* __fastcall CreateProperty(Typinfo::PPropInfo APropInfo, Propertylist::TCustomPropData* APropData);
	virtual int __fastcall Compare(Propertylist::TProperty* P1, Propertylist::TProperty* P2);
	virtual bool __fastcall Filter(Propertylist::TProperty* P);
	__property TCompInspList* CompInspList = {read=FCompInspList};
	__property TCompInspMode Mode = {read=FMode, write=SetMode, nodefault};
public:
	/* TPropertyList.Create */ inline __fastcall virtual TCompInspPropertyList(Propertylist::TProperty* AOwner) : Propertylist::TPropertyList(AOwner) { }
	/* TPropertyList.Destroy */ inline __fastcall virtual ~TCompInspPropertyList(void) { }
	
};


class PASCALIMPLEMENTATION TCompInspList : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TAdvCustomComponentInspector* FOwner;
	Classes::TComponent* FRoot;
	TCompInspMode FMode;
	Classes::TList* FPropertyLists;
	Classes::TList* FProperties;
	Classes::TStrings* FExpanded;
	void __fastcall SetRoot(const Classes::TComponent* Value);
	Classes::TComponent* __fastcall GetInstance(void);
	void __fastcall SetInstance(const Classes::TComponent* Value);
	int __fastcall GetInstanceCount(void);
	Classes::TComponent* __fastcall GetArrayInstance(int Index);
	void __fastcall SetMode(const TCompInspMode Value);
	int __fastcall GetPropertyCount(void);
	Propertylist::TProperty* __fastcall GetProperty(int Index);
	int __fastcall GetPropertyListCount(void);
	TCompInspPropertyList* __fastcall GetPropertyList(int Index);
	void __fastcall Clear(void);
	
public:
	__fastcall TCompInspList(TAdvCustomComponentInspector* AOwner);
	__fastcall virtual ~TCompInspList(void);
	virtual void __fastcall Update(void);
	virtual void __fastcall AddInstance(Classes::TComponent* AInstance);
	virtual void __fastcall DeleteInstance(Classes::TComponent* AInstance);
	int __fastcall IndexOfInstance(Classes::TComponent* AInstance);
	bool __fastcall ValidPropIndex(int Index);
	bool __fastcall ValidListIndex(int Index);
	__property TAdvCustomComponentInspector* Owner = {read=FOwner};
	__property Classes::TComponent* Root = {read=FRoot, write=SetRoot};
	__property Classes::TComponent* Instance = {read=GetInstance, write=SetInstance};
	__property TCompInspMode Mode = {read=FMode, write=SetMode, nodefault};
	__property int InstanceCount = {read=GetInstanceCount, nodefault};
	__property Classes::TComponent* Instances[int Index] = {read=GetArrayInstance};
	__property int PropertyCount = {read=GetPropertyCount, nodefault};
	__property Propertylist::TProperty* Properties[int Index] = {read=GetProperty};
	__property int PropertyListCount = {read=GetPropertyListCount, nodefault};
	__property TCompInspPropertyList* PropertyLists[int Index] = {read=GetPropertyList};
public:
	/* TObject.Create */ inline __fastcall TCompInspList(void) : System::TObject() { }
	
};


class PASCALIMPLEMENTATION TAdvCustomComponentInspector : public Inspectorcontrols::TAdvCustomInspector
{
	typedef Inspectorcontrols::TAdvCustomInspector inherited;
	
private:
	Classes::TStrings* FDictionary;
	TCompInspList* FPropertyList;
	Classes::TList* FNotificationControls;
	System::UnicodeString FSelectedProperty;
	bool FMultiSelect;
	System::UnicodeString FDictionaryFile;
	TSetStringEnableEvent FOnSetValue;
	Inspectorcontrols::TCallEditorEnableEvent FOnCallEditor;
	Inspectorcontrols::TIndexEnableEvent FOnBeforeExpand;
	Inspectorcontrols::TIndexNotifyEvent FOnAfterExpand;
	Inspectorcontrols::TIndexEnableEvent FOnBeforeCollapse;
	Inspectorcontrols::TIndexNotifyEvent FOnAfterCollapse;
	TEditorClassEvent FOnGetEditorClass;
	TPropFilterEvent FOnFilter;
	TPropCompareEvent FOnCompare;
	TFillEventListEvent FOnFillEventList;
	Inspectorcontrols::TIndexNotifyEvent FOnChange;
	TCustomizeInspectorEvent FOnCustomizeInspector;
	void __fastcall SetMultiSelectProperty(const bool Value);
	void __fastcall SetDictionary(const Classes::TStrings* Value);
	void __fastcall SetDictionaryFile(const System::UnicodeString Value);
	void __fastcall SetRoot(const Classes::TComponent* Value);
	Classes::TComponent* __fastcall GetRoot(void);
	void __fastcall SetInstance(const Classes::TComponent* Value);
	Classes::TComponent* __fastcall GetInstance(void);
	int __fastcall GetInstanceCount(void);
	Classes::TComponent* __fastcall GetArrayInstance(int Index);
	TCompInspMode __fastcall GetMode(void);
	int __fastcall GetPropertyCount(void);
	Propertylist::TProperty* __fastcall GetProperty(int TheIndex);
	void __fastcall SetMode(const TCompInspMode Value);
	void __fastcall UpdateList(void);
	void __fastcall UpdateDictionary(void);
	System::UnicodeString __fastcall Translate(const System::UnicodeString Value, bool Direction);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual int __fastcall GetDefaultIndex(void);
	virtual int __fastcall GetPopupItemWidth(Stdctrls::TListBox* ListBox, int TheIndex);
	virtual void __fastcall DrawPopupItem(Stdctrls::TListBox* ListBox, int ListItemIndex, const Types::TRect &R, int TheIndex);
	virtual void __fastcall DrawPropertyValue(Graphics::TCanvas* TheCanvas, int TheIndex, const Types::TRect &R);
	virtual System::UnicodeString __fastcall GetName(int TheIndex);
	virtual System::UnicodeString __fastcall GetValue(int TheIndex);
	virtual System::UnicodeString __fastcall GetNextValue(int TheIndex);
	virtual void __fastcall SetValue(int TheIndex, const System::UnicodeString Value);
	virtual void __fastcall DragValue(int TheIndex, int Offset);
	virtual Inspectorcontrols::TButtonType __fastcall GetButtonType(int TheIndex);
	virtual Inspectorcontrols::TInplaceEditorType __fastcall GetInplaceEditorType(int TheIndex);
	virtual bool __fastcall GetEnableExternalEditor(int TheIndex);
	virtual bool __fastcall GetReadOnly(int TheIndex);
	virtual Inspectorcontrols::TExpandState __fastcall GetExpandState(int TheIndex);
	virtual int __fastcall GetLevel(int TheIndex);
	virtual void __fastcall GetValuesList(int TheIndex, const Classes::TStrings* Strings);
	virtual bool __fastcall GetSortValuesList(int TheIndex);
	virtual System::UnicodeString __fastcall GetSelectedValue(int TheIndex);
	virtual bool __fastcall GetAutoApply(int TheIndex);
	virtual bool __fastcall CallEditor(int TheIndex);
	virtual void __fastcall Expand(int TheIndex);
	virtual void __fastcall Collapse(int TheIndex);
	virtual void __fastcall SelectItem(int TheIndex);
	virtual Propertyinspeditors::TPropertyEditorClass __fastcall GetEditorClass(int TheIndex);
	virtual void __fastcall Compare(Propertylist::TProperty* Prop1, Propertylist::TProperty* Prop2, int &Result);
	virtual void __fastcall Filter(Propertylist::TProperty* Prop, bool &Result);
	virtual void __fastcall Change(int TheIndex);
	virtual System::UnicodeString __fastcall GetPropertyValue(Propertylist::TProperty* P);
	virtual void __fastcall SetPropertyValue(Propertylist::TProperty* P, System::UnicodeString Value);
	__property bool MultiSelect = {read=FMultiSelect, write=SetMultiSelectProperty, default=1};
	__property System::UnicodeString DictionaryFile = {read=FDictionaryFile, write=SetDictionaryFile};
	__property Classes::TStrings* Dictionary = {read=FDictionary, write=SetDictionary};
	__property Classes::TComponent* Root = {read=GetRoot, write=SetRoot};
	__property Classes::TComponent* Instance = {read=GetInstance, write=SetInstance};
	__property TCompInspMode Mode = {read=GetMode, write=SetMode, default=0};
	__property TSetStringEnableEvent OnSetValue = {read=FOnSetValue, write=FOnSetValue};
	__property Inspectorcontrols::TCallEditorEnableEvent OnCallEditor = {read=FOnCallEditor, write=FOnCallEditor};
	__property Inspectorcontrols::TIndexEnableEvent OnBeforeExpand = {read=FOnBeforeExpand, write=FOnBeforeExpand};
	__property Inspectorcontrols::TIndexNotifyEvent OnAfterExpand = {read=FOnAfterExpand, write=FOnAfterExpand};
	__property Inspectorcontrols::TIndexEnableEvent OnBeforeCollapse = {read=FOnBeforeCollapse, write=FOnBeforeCollapse};
	__property Inspectorcontrols::TIndexNotifyEvent OnAfterCollapse = {read=FOnAfterCollapse, write=FOnAfterCollapse};
	__property TEditorClassEvent OnGetEditorClass = {read=FOnGetEditorClass, write=FOnGetEditorClass};
	__property TPropFilterEvent OnFilter = {read=FOnFilter, write=FOnFilter};
	__property TPropCompareEvent OnCompare = {read=FOnCompare, write=FOnCompare};
	__property TFillEventListEvent OnFillEventList = {read=FOnFillEventList, write=FOnFillEventList};
	__property Inspectorcontrols::TIndexNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TCustomizeInspectorEvent OnCustomizeInspector = {read=FOnCustomizeInspector, write=FOnCustomizeInspector};
	
public:
	__fastcall virtual TAdvCustomComponentInspector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomComponentInspector(void);
	virtual void __fastcall Update(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall RefreshList(void);
	void __fastcall ClearExpanded(void);
	virtual void __fastcall AddInstance(Classes::TComponent* AInstance);
	virtual void __fastcall DeleteInstance(Classes::TComponent* AInstance);
	int __fastcall IndexOfInstance(Classes::TComponent* AInstance);
	void __fastcall AddNotification(Controls::TControl* TheControl);
	void __fastcall DeleteNotification(Controls::TControl* TheControl);
	virtual void __fastcall FillEventList(Typinfo::PTypeInfo EventType, Classes::TStrings* Strings);
	virtual void __fastcall CustomizeInspector(TAdvComponentInspector* Inspector);
	void __fastcall FullExpand(void);
	int __fastcall IndexOfPropertyName(System::UnicodeString AFullname);
	void __fastcall SelectProperty(System::UnicodeString AFullName);
	int __fastcall IndexOfProperty(Propertylist::TProperty* P);
	__property int PropertyCount = {read=GetPropertyCount, nodefault};
	__property Propertylist::TProperty* Properties[int Index] = {read=GetProperty};
	__property int InstanceCount = {read=GetInstanceCount, nodefault};
	__property Classes::TComponent* Instances[int Index] = {read=GetArrayInstance};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomComponentInspector(HWND ParentWindow) : Inspectorcontrols::TAdvCustomInspector(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TAdvComponentInspector : public TAdvCustomComponentInspector
{
	typedef TAdvCustomComponentInspector inherited;
	
__published:
	__property Anchors = {default=3};
	__property Constraints;
	__property Align = {default=0};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName;
	__property IntegralHeight = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnStartDrag;
	__property CheckBoxes = {default=0};
	__property PaintStyle = {default=0};
	__property Splitter = {default=100};
	__property OnSelect;
	__property OnUpdate;
	__property OnValidateChar;
	__property OnChangeValue;
	__property OnDrawName;
	__property OnDrawValue;
	__property MultiSelect = {default=1};
	__property DictionaryFile;
	__property Dictionary;
	__property Root;
	__property Instance;
	__property Mode = {default=0};
	__property OnGetName;
	__property OnGetValue;
	__property OnGetNextValue;
	__property OnSetValue;
	__property OnGetButtonType;
	__property OnGetInplaceEditorType;
	__property OnGetMaxLength;
	__property OnGetEditMask;
	__property OnGetEnableExternalEditor;
	__property OnGetReadOnly;
	__property OnGetExpandState;
	__property OnGetLevel;
	__property OnGetValuesList;
	__property OnGetSortValuesList;
	__property OnGetSelectedValue;
	__property OnGetAutoApply;
	__property OnGetNameFont;
	__property OnGetNameColor;
	__property OnGetValueFont;
	__property OnGetValueColor;
	__property OnCallEditor;
	__property OnBeforeExpand;
	__property OnAfterExpand;
	__property OnBeforeCollapse;
	__property OnAfterCollapse;
	__property OnGetEditorClass;
	__property OnFilter;
	__property OnCompare;
	__property OnSelectItem;
	__property OnDeselectItem;
	__property OnValueDoubleClick;
	__property OnFillEventList;
	__property OnChange;
	__property OnCustomizeInspector;
public:
	/* TAdvCustomComponentInspector.Create */ inline __fastcall virtual TAdvComponentInspector(Classes::TComponent* AOwner) : TAdvCustomComponentInspector(AOwner) { }
	/* TAdvCustomComponentInspector.Destroy */ inline __fastcall virtual ~TAdvComponentInspector(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvComponentInspector(HWND ParentWindow) : TAdvCustomComponentInspector(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word CM_OIUPDATED = 0xbd0;

}	/* namespace Componentinspector */
using namespace Componentinspector;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ComponentinspectorHPP
