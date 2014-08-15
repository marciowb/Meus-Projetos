// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipfulldropdownitem.pas' rev: 21.00

#ifndef GdipfulldropdownitemHPP
#define GdipfulldropdownitemHPP

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
#include <Graphics.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Gdiptextitem.hpp>	// Pascal unit
#include <Gdipbase.hpp>	// Pascal unit
#include <Advpolylist.hpp>	// Pascal unit
#include <Customitemscontainer.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipfulldropdownitem
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TFormPosition { fpLeft, fpTop, fpRight, fpBottom };
#pragma option pop

typedef Set<TFormPosition, fpLeft, fpBottom>  TFormPositionSet;

class DELPHICLASS TDropDownForm;
class PASCALIMPLEMENTATION TDropDownForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	Advpolylist::TAdvPolyList* FContainer;
	TFormPositionSet FPosition;
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TMessage &Message);
	
public:
	void __fastcall Init(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	__property Advpolylist::TAdvPolyList* Container = {read=FContainer, write=FContainer};
	__property TFormPositionSet Position = {read=FPosition, write=FPosition, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDropDownForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDropDownForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDropDownForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDropDownForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TDropDownAppearance;
class PASCALIMPLEMENTATION TDropDownAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Advpolylist::TAdvPolyList* FOwner;
	Gdipfill::TGDIPFill* __fastcall GetFill(void);
	Controls::TMargins* __fastcall GetListMargins(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetListMargins(const Controls::TMargins* Value);
	void __fastcall SetReadOnly(const bool Value);
	int __fastcall GetHorizontalSpacing(void);
	int __fastcall GetVerticalSpacing(void);
	void __fastcall SetHorizontalSpacing(const int Value);
	void __fastcall SetVerticalSpacing(const int Value);
	Customitemscontainer::TAutoSizeMode __fastcall GetAutoSizeMode(void);
	Customitemscontainer::TAutoSizeType __fastcall GetAutoSizeType(void);
	Customitemscontainer::TListBorderMode __fastcall GetBorderMode(void);
	Customitemscontainer::TListBorderTypes __fastcall GetBorderTypes(void);
	int __fastcall GetColumns(void);
	int __fastcall GetRows(void);
	bool __fastcall GetShowFocus(void);
	void __fastcall SetAutoSizeMode(const Customitemscontainer::TAutoSizeMode Value);
	void __fastcall SetAutoSizeType(const Customitemscontainer::TAutoSizeType Value);
	void __fastcall SetBorderMode(const Customitemscontainer::TListBorderMode Value);
	void __fastcall SetBorderTypes(const Customitemscontainer::TListBorderTypes Value);
	void __fastcall SetColumns(const int Value);
	void __fastcall SetRows(const int Value);
	void __fastcall SetShowFocus(const bool Value);
	
public:
	__fastcall TDropDownAppearance(Advpolylist::TAdvPolyList* AOwner);
	__fastcall virtual ~TDropDownAppearance(void);
	
__published:
	__property Customitemscontainer::TAutoSizeMode AutoSizeMode = {read=GetAutoSizeMode, write=SetAutoSizeMode, default=1};
	__property Customitemscontainer::TAutoSizeType AutoSizeType = {read=GetAutoSizeType, write=SetAutoSizeType, default=0};
	__property Gdipfill::TGDIPFill* Fill = {read=GetFill, write=SetFill};
	__property int HorizontalSpacing = {read=GetHorizontalSpacing, write=SetHorizontalSpacing, default=5};
	__property int VerticalSpacing = {read=GetVerticalSpacing, write=SetVerticalSpacing, default=5};
	__property Controls::TMargins* ListMargins = {read=GetListMargins, write=SetListMargins};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property int Columns = {read=GetColumns, write=SetColumns, default=1};
	__property int Rows = {read=GetRows, write=SetRows, default=0};
	__property bool ShowFocus = {read=GetShowFocus, write=SetShowFocus, default=1};
	__property Customitemscontainer::TListBorderMode BorderMode = {read=GetBorderMode, write=SetBorderMode, default=0};
	__property Customitemscontainer::TListBorderTypes BorderTypes = {read=GetBorderTypes, write=SetBorderTypes, default=15};
};


class DELPHICLASS TFullDropDownItem;
class PASCALIMPLEMENTATION TFullDropDownItem : public Gdiptextitem::TTextItem
{
	typedef Gdiptextitem::TTextItem inherited;
	
private:
	bool FAllowSelect;
	unsigned time;
	Advpolylist::TAdvPolyList* FContainer;
	bool FDeactivating;
	TDropDownForm* ContainerParent;
	Gdipcustomitem::TItemSelectEvent FOnContainerItemSelect;
	TDropDownAppearance* FDropDownAppearance;
	int FItemIndex;
	Gdipcustomitem::TCustomItem* FItem;
	void __fastcall HideParent(void);
	void __fastcall SetItems(const Gdipbase::TCustomBaseList* Value);
	Gdipbase::TCustomBaseList* __fastcall GetItems(void);
	void __fastcall SetDropDownAppearance(const TDropDownAppearance* Value);
	void __fastcall SetItemIndex(const int Value);
	
protected:
	void __fastcall ContainerParentDeactivate(System::TObject* Sender);
	virtual void __fastcall DoInternalItemClick(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item);
	void __fastcall ListItemSelect(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, bool &Allow);
	void __fastcall ContainerChanged(System::TObject* Sender);
	void __fastcall ContainerKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall ContainerMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	__property Advpolylist::TAdvPolyList* Container = {read=FContainer, write=FContainer};
	void __fastcall ReadItemState(Classes::TReader* Reader, Gdipcustomitem::TCustomItem* Item);
	void __fastcall SetItemParentComponent(Classes::TComponent* AParent, Gdipcustomitem::TCustomItem* Item);
	Controls::TWinControl* __fastcall GetFormOwner(Classes::TComponent* AOwner, Forms::TCustomForm* &frm, bool &ControlFlag);
	Types::TPoint __fastcall GetItemPos(Gdipcustomitem::TCustomItem* AOwner);
	void __fastcall HideAllBelow(void);
	bool __fastcall IsContainerVisible(void);
	virtual int __fastcall GetVersionNr(void);
	void __fastcall SelectNewItem(Gdipcustomitem::TCustomItem* Item);
	void __fastcall RefreshItem(System::TObject* Sender);
	void __fastcall DrawArrow(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &R);
	HIDESBASE void __fastcall FillPictureNames(Classes::TGetStrProc Proc);
	HIDESBASE void __fastcall GetPictures(Gdipcustomitem::TPictureContainerList* APictureList);
	
public:
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	__fastcall virtual TFullDropDownItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TFullDropDownItem(void);
	virtual void __fastcall DropDown(void);
	virtual void __fastcall DrawInRect(Advgdip::TGPGraphics* g, const Gdipcustomitem::TItemAppearance &ItemAppearance, const Advgdip::TGPRectF &R);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	Gdipcustomitem::TCustomItem* __fastcall AddItem(Gdipcustomitem::TCustomItemClass AClass);
	void __fastcall RemoveItem(int Index);
	void __fastcall ClearItems(void);
	void __fastcall SelectItem(int Index);
	void __fastcall VisualizeItem(int Index, bool AllowScrollItem = true, bool AllowSelectItem = true);
	void __fastcall ScrollToItem(int Index);
	Gdipcustomitem::TCustomItem* __fastcall InsertItem(int Index, Gdipcustomitem::TCustomItemClass AClass);
	virtual void __fastcall DoCMMouseLeave(Messages::TMessage &Message);
	virtual void __fastcall DoMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int pX, int pY, const Gdipcustomitem::TItemInteraction &Interaction, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall DoMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int pX, int pY, const Gdipcustomitem::TItemInteraction &Interaction, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall DoMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int pX, int pY, const Gdipcustomitem::TItemInteraction &Interaction, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall DoCMHintShow(Messages::TMessage &Message, const Gdipcustomitem::TItemInteraction &Interaction);
	virtual void __fastcall DoKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	
__published:
	__property Gdipcustomitem::TItemSelectEvent OnContainerItemSelect = {read=FOnContainerItemSelect, write=FOnContainerItemSelect};
	__property Gdipbase::TCustomBaseList* Items = {read=GetItems, write=SetItems};
	__property TDropDownAppearance* DropDownAppearance = {read=FDropDownAppearance, write=SetDropDownAppearance};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
private:
	void *__IPictureContainerSupport;	/* Gdipcustomitem::IPictureContainerSupport */
	void *__ITMSStyle;	/* Advstyleif::ITMSStyle */
	void *__IGDIPBase;	/* Gdipcustomitem::IGDIPBase */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Gdipcustomitem::_di_IPictureContainerSupport()
	{
		Gdipcustomitem::_di_IPictureContainerSupport intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IPictureContainerSupport*(void) { return (IPictureContainerSupport*)&__IPictureContainerSupport; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Advstyleif::_di_ITMSStyle()
	{
		Advstyleif::_di_ITMSStyle intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator ITMSStyle*(void) { return (ITMSStyle*)&__ITMSStyle; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Gdipcustomitem::_di_IGDIPBase()
	{
		Gdipcustomitem::_di_IGDIPBase intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IGDIPBase*(void) { return (IGDIPBase*)&__IGDIPBase; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdipfulldropdownitem */
using namespace Gdipfulldropdownitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipfulldropdownitemHPP
