// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rttiinspectorbar.pas' rev: 21.00

#ifndef RttiinspectorbarHPP
#define RttiinspectorbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Inspectorbar.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rttiinspectorbar
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TItemInsertEvent)(System::TObject* Sender, System::UnicodeString &PropertyName, Typinfo::TTypeKind PropertyType, bool &Allow);

class DELPHICLASS TRTTIInspectorItem;
class PASCALIMPLEMENTATION TRTTIInspectorItem : public Inspectorbar::TInspectorItem
{
	typedef Inspectorbar::TInspectorItem inherited;
	
private:
	System::TObject* FObjectRef;
	bool FSetProp;
	int FSetVal;
	Typinfo::TPropInfo *FPropInfo;
	System::UnicodeString FPropName;
	
protected:
	virtual void __fastcall EditStart(void);
	virtual void __fastcall EditStop(void);
	virtual void __fastcall EditChange(void);
	
public:
	__fastcall virtual TRTTIInspectorItem(Classes::TCollection* Collection);
	__fastcall virtual ~TRTTIInspectorItem(void);
	__property System::TObject* ObjectRef = {read=FObjectRef, write=FObjectRef};
	__property bool SetProp = {read=FSetProp, write=FSetProp, nodefault};
	__property int SetVal = {read=FSetVal, write=FSetVal, nodefault};
	__property Typinfo::PPropInfo PropInfo = {read=FPropInfo, write=FPropInfo};
	__property System::UnicodeString PropName = {read=FPropName, write=FPropName};
};


class DELPHICLASS TRTTIInspectorItems;
class PASCALIMPLEMENTATION TRTTIInspectorItems : public Inspectorbar::TInspectorItems
{
	typedef Inspectorbar::TInspectorItems inherited;
	
public:
	TRTTIInspectorItem* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TRTTIInspectorItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TRTTIInspectorItem* Value);
	
public:
	virtual Classes::TCollectionItemClass __fastcall CreateItemClass(void);
	HIDESBASE TRTTIInspectorItem* __fastcall Add(void);
	HIDESBASE TRTTIInspectorItem* __fastcall Insert(int index);
	__property TRTTIInspectorItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TInspectorItems.Create */ inline __fastcall TRTTIInspectorItems(Inspectorbar::TInspectorPanel* AOwner) : Inspectorbar::TInspectorItems(AOwner) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TRTTIInspectorItems(void) { }
	
};


class DELPHICLASS TRTTIInspectorPanel;
class PASCALIMPLEMENTATION TRTTIInspectorPanel : public Inspectorbar::TInspectorPanel
{
	typedef Inspectorbar::TInspectorPanel inherited;
	
private:
	Classes::TPersistent* FRTTIComponent;
	void __fastcall SetRTTIComponent(const Classes::TPersistent* Value);
	
public:
	__fastcall virtual TRTTIInspectorPanel(Classes::TCollection* Collection);
	virtual Inspectorbar::TInspectorItems* __fastcall CreateItems(void);
	void __fastcall Refresh(void);
	void __fastcall RefreshItem(Inspectorbar::TInspectorItem* InspectorItem);
	
__published:
	__property Classes::TPersistent* RTTIComponent = {read=FRTTIComponent, write=SetRTTIComponent};
public:
	/* TInspectorPanel.Destroy */ inline __fastcall virtual ~TRTTIInspectorPanel(void) { }
	
};


class DELPHICLASS TRTTIInspectorPanels;
class PASCALIMPLEMENTATION TRTTIInspectorPanels : public Inspectorbar::TInspectorPanels
{
	typedef Inspectorbar::TInspectorPanels inherited;
	
public:
	TRTTIInspectorPanel* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TRTTIInspectorPanel* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TRTTIInspectorPanel* Value);
	
public:
	virtual Classes::TCollectionItemClass __fastcall CreateItemClass(void);
	HIDESBASE TRTTIInspectorPanel* __fastcall Add(void);
	HIDESBASE TRTTIInspectorPanel* __fastcall Insert(int index);
	__property TRTTIInspectorPanel* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TInspectorPanels.Create */ inline __fastcall TRTTIInspectorPanels(Inspectorbar::TInspectorBar* AOwner) : Inspectorbar::TInspectorPanels(AOwner) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TRTTIInspectorPanels(void) { }
	
};


class DELPHICLASS TRTTIInspectorBar;
class PASCALIMPLEMENTATION TRTTIInspectorBar : public Inspectorbar::TInspectorBar
{
	typedef Inspectorbar::TInspectorBar inherited;
	
private:
	bool FEdited;
	TItemInsertEvent FOnItemInsert;
	TRTTIInspectorPanels* __fastcall GetPanels(void);
	void __fastcall SetPanels(const TRTTIInspectorPanels* Value);
	
public:
	virtual Inspectorbar::TInspectorPanels* __fastcall CreatePanels(void);
	virtual void __fastcall StartEdit(Inspectorbar::TInspectorItem* InspectorItem);
	virtual void __fastcall StopEdit(Inspectorbar::TInspectorItem* InspectorItem);
	virtual void __fastcall GetValueList(Inspectorbar::TInspectorItem* InspectorItem, Classes::TStringList* Values);
	
__published:
	__property TRTTIInspectorPanels* Panels = {read=GetPanels, write=SetPanels};
	__property TItemInsertEvent OnItemInsert = {read=FOnItemInsert, write=FOnItemInsert};
public:
	/* TInspectorBar.Create */ inline __fastcall virtual TRTTIInspectorBar(Classes::TComponent* AOwner) : Inspectorbar::TInspectorBar(AOwner) { }
	/* TInspectorBar.Destroy */ inline __fastcall virtual ~TRTTIInspectorBar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRTTIInspectorBar(HWND ParentWindow) : Inspectorbar::TInspectorBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rttiinspectorbar */
using namespace Rttiinspectorbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// RttiinspectorbarHPP
