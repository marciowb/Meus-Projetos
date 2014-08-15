// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipbase.pas' rev: 21.00

#ifndef GdipbaseHPP
#define GdipbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipbase
{
//-- type declarations -------------------------------------------------------
typedef DynamicArray<Gdipcustomitem::TCustomItem*> TArrayOfCustomItems;

typedef DynamicArray<Gdipcustomitem::TCustomItem*> TCustomItems;

class DELPHICLASS TCustomListObjects;
class DELPHICLASS TCustomBaseList;
class PASCALIMPLEMENTATION TCustomListObjects : public Contnrs::TObjectList
{
	typedef Contnrs::TObjectList inherited;
	
private:
	TCustomBaseList* FOwner;
	
protected:
	void __fastcall QuickSort(Classes::PPointerList SortList, int L, int R);
	virtual void __fastcall Notify(void * Ptr, Classes::TListNotification Action);
	
public:
	void __fastcall UpdateIndexes(void);
	void __fastcall SortListItems(void);
public:
	/* TObjectList.Create */ inline __fastcall TCustomListObjects(void)/* overload */ : Contnrs::TObjectList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TCustomListObjects(void) { }
	
};


class DELPHICLASS TCustomBaseListAppearance;
class PASCALIMPLEMENTATION TCustomBaseListAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Gdipfill::TGDIPFill* FHovered;
	Gdipfill::TGDIPFill* FDown;
	Gdipfill::TGDIPFill* FNormal;
	Gdipfill::TGDIPFill* FDisabled;
	Gdipfill::TGDIPFill* FSelected;
	Classes::TNotifyEvent FOnChange;
	Graphics::TFont* FNormalFont;
	Graphics::TFont* FDisabledFont;
	Graphics::TFont* FSelectedFont;
	Graphics::TFont* FHoveredFont;
	Graphics::TFont* FDownFont;
	Gdipfill::TGDIPFill* FButtonHovered;
	Gdipfill::TGDIPFill* FButtonDown;
	Gdipfill::TGDIPFill* FButtonNormal;
	Gdipfill::TGDIPFill* FButtonDisabled;
	Gdipfill::TGDIPFill* FButtonSelected;
	Gdippicturecontainer::TGDIPPictureContainer* FPictureContainer;
	Imglist::TCustomImageList* FImageList;
	void __fastcall SetDisabled(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetDown(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHovered(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetNormal(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSelected(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetDisabledFont(const Graphics::TFont* Value);
	void __fastcall SetDownFont(const Graphics::TFont* Value);
	void __fastcall SetHoveredFont(const Graphics::TFont* Value);
	void __fastcall SetNormalFont(const Graphics::TFont* Value);
	void __fastcall SetSelectedFont(const Graphics::TFont* Value);
	void __fastcall SetButtonDisabled(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetButtonDown(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetButtonHovered(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetButtonNormal(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetButtonSelected(const Gdipfill::TGDIPFill* Value);
	
public:
	__fastcall TCustomBaseListAppearance(void);
	__fastcall virtual ~TCustomBaseListAppearance(void);
	void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall FontChanged(System::TObject* Sender);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Gdipfill::TGDIPFill* Normal = {read=FNormal, write=SetNormal};
	__property Gdipfill::TGDIPFill* ButtonNormal = {read=FButtonNormal, write=SetButtonNormal};
	__property Gdipfill::TGDIPFill* Down = {read=FDown, write=SetDown};
	__property Gdipfill::TGDIPFill* ButtonDown = {read=FButtonDown, write=SetButtonDown};
	__property Gdipfill::TGDIPFill* Disabled = {read=FDisabled, write=SetDisabled};
	__property Gdipfill::TGDIPFill* ButtonDisabled = {read=FButtonDisabled, write=SetButtonDisabled};
	__property Gdipfill::TGDIPFill* Hovered = {read=FHovered, write=SetHovered};
	__property Gdipfill::TGDIPFill* ButtonHovered = {read=FButtonHovered, write=SetButtonHovered};
	__property Gdipfill::TGDIPFill* Selected = {read=FSelected, write=SetSelected};
	__property Gdipfill::TGDIPFill* ButtonSelected = {read=FButtonSelected, write=SetButtonSelected};
	__property Graphics::TFont* NormalFont = {read=FNormalFont, write=SetNormalFont};
	__property Graphics::TFont* DownFont = {read=FDownFont, write=SetDownFont};
	__property Graphics::TFont* DisabledFont = {read=FDisabledFont, write=SetDisabledFont};
	__property Graphics::TFont* HoveredFont = {read=FHoveredFont, write=SetHoveredFont};
	__property Graphics::TFont* SelectedFont = {read=FSelectedFont, write=SetSelectedFont};
	__property Gdippicturecontainer::TGDIPPictureContainer* PictureContainer = {read=FPictureContainer, write=FPictureContainer};
	__property Imglist::TCustomImageList* ImageList = {read=FImageList, write=FImageList};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


typedef void __fastcall (__closure *TItemCompareEvent)(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item1, Gdipcustomitem::TCustomItem* Item2, int &Result);

typedef void __fastcall (__closure *TItemDesignTimeSelect)(System::TObject* Sender, int Index);

class DELPHICLASS TWinControlAccess;
class PASCALIMPLEMENTATION TWinControlAccess : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	/* TWinControl.Create */ inline __fastcall virtual TWinControlAccess(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TWinControlAccess(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TWinControlAccess(void) { }
	
};


class PASCALIMPLEMENTATION TCustomBaseList : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FFocusedItemIndex;
	int FFirstVisibleIndex;
	int FLastVisibleIndex;
	bool GlobalCheck;
	Classes::TComponent* FOwnerComponent;
	int FUpdateCount;
	TCustomListObjects* FItems;
	TCustomBaseListAppearance* FAppearance;
	Classes::TNotifyEvent FOnChange;
	bool FMultiSelect;
	Classes::TNotifyEvent FOnInternalChange;
	Classes::TNotifyEvent FOnNotifyItemChange;
	Classes::TNotifyEvent FOnNotifyItemDestroy;
	Classes::TNotifyEvent FOnNotifyListDestroy;
	Classes::TNotifyEvent FOnInternalRefresh;
	Classes::TNotifyEvent FOnRefresh;
	int FWidth;
	int FHeight;
	TItemCompareEvent FOnItemCompare;
	Gdipcustomitem::TItemSelectEvent FOnItemSelect;
	TItemDesignTimeSelect FOnNotifyItemDesignTimeSelect;
	Gdipcustomitem::TItemSelectEvent FOnItemDeSelect;
	Gdipcustomitem::TItemEvent FOnItemDestroy;
	void __fastcall SetAppearance(const TCustomBaseListAppearance* Value);
	void __fastcall SetItems(const TCustomListObjects* Value);
	void __fastcall SetMultiSelect(const bool Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	
protected:
	Gdipcustomitem::TItemInteractionType __fastcall ItemInteraction(int pX, int pY, Gdipcustomitem::TCustomItem* it);
	int __fastcall Compare(void * Item1, void * Item2);
	Controls::TWinControl* __fastcall GetTopParent(Controls::TWinControl* AControl);
	
public:
	__fastcall TCustomBaseList(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomBaseList(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AssignList(TCustomBaseList* Source);
	void __fastcall Changed(void);
	void __fastcall RefreshObjects(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall UpdateVisibleIndexes(void);
	void __fastcall DoGlobalCheckChanged(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, bool Checked);
	void __fastcall DoItemIndexChange(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, int OldIndex, int NewIndex);
	void __fastcall DoItemRefresh(System::TObject* Sender);
	void __fastcall DoItemSelect(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, bool &Allow);
	void __fastcall DoItemDeSelect(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, bool &Allow);
	void __fastcall DoItemChanged(System::TObject* Sender);
	void __fastcall DoItemFocus(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item);
	void __fastcall DoItemDestroy(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	void __fastcall DoExit(void);
	void __fastcall DoEnter(void);
	void __fastcall DoCMMouseLeave(Messages::TMessage &Message);
	void __fastcall DoWMKeyDown(Messages::TWMKey &Message);
	void __fastcall DoCMHintShow(Messages::TMessage &Message);
	void __fastcall DoMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int pX, int pY);
	void __fastcall DoDblClick(System::TObject* Sender, const Types::TPoint &Pos);
	void __fastcall DoMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int pX, int pY);
	void __fastcall DoMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int pX, int pY);
	void __fastcall DoKeyDownGrid(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall DoKeyDownBox(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall DoKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall DoKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall ProcessKeyGrid(System::Word Key, int &SelRow, int &SelCol);
	void __fastcall ProcessKeyBox(System::Word Key, int &ItemIndex);
	void __fastcall DrawItems(Advgdip::TGPGraphics* g, bool Focused);
	void __fastcall ConvertItem(Gdipcustomitem::TCustomItem* it, Gdipcustomitem::TCustomItemClass AItemClass);
	void __fastcall RemoveItem(int AIndex);
	void __fastcall SelectItem(int AIndex);
	void __fastcall UnSelectItem(int AIndex);
	void __fastcall ResetItemStatus(void);
	void __fastcall ClearItemState(void);
	void __fastcall Sort(void);
	void __fastcall ShowShortCutHints(void);
	void __fastcall HideShortCutHints(void);
	int __fastcall FirstVisibleIdx(void);
	int __fastcall LastVisibleIdx(void);
	void __fastcall HideItemsByLevel(int StartIndex, int ALevel, Gdipcustomitem::TItemLevelStatus ALevelStatus);
	void __fastcall ShowItemsByLevel(int StartIndex, int ALevel, Gdipcustomitem::TItemLevelStatus ALevelStatus);
	void __fastcall AssignEvents(Gdipcustomitem::TCustomItem* it);
	void __fastcall SetOwnerComponent(Classes::TComponent* AOwner);
	Gdipcustomitem::TCustomItem* __fastcall AddItem(Gdipcustomitem::TCustomItem* it);
	Gdipcustomitem::TCustomItem* __fastcall InsertItem(int Index, Gdipcustomitem::TCustomItem* it);
	Classes::TComponentClass __fastcall GetItemClassByCustomName(System::UnicodeString ACustomName);
	Gdipcustomitem::TItemInteraction __fastcall ItemInteractionAtXY(int pX, int pY);
	Gdipcustomitem::TCustomItem* __fastcall ItemAtXY(int pX, int pY);
	Gdipcustomitem::TCustomItem* __fastcall SelectedItem(void);
	void __fastcall FocusNextItem(bool backwards);
	bool __fastcall ItemInRectangle(Gdipcustomitem::TCustomItem* It, const Types::TRect &DisplayRect);
	int __fastcall GetFirstVisibleIndex(void);
	int __fastcall GetLastVisibleIndex(void);
	bool __fastcall IsItemSelectable(Gdipcustomitem::TCustomItem* it);
	bool __fastcall IsItemFocusable(Gdipcustomitem::TCustomItem* it);
	int __fastcall GetCountSelectableItems(void);
	int __fastcall GetCountFocusableItems(void);
	Gdipcustomitem::TCustomItem* __fastcall ItemAtRowCol(int Row, int Col);
	TCustomItems __fastcall GetItemsByTag(int ATag);
	Classes::TComponent* __fastcall GetOwnerComponent(void);
	int __fastcall MaxSelectableRowIndex(void);
	int __fastcall MaxSelectableColIndex(void);
	int __fastcall MinSelectableRowIndex(void);
	int __fastcall MinSelectableColIndex(void);
	int __fastcall MaxRowIndex(void);
	int __fastcall MaxColIndex(void);
	Gdipcustomitem::TCustomItem* __fastcall MaxRowItem(void);
	Gdipcustomitem::TCustomItem* __fastcall MaxColumnItem(void);
	Gdipcustomitem::TCustomItem* __fastcall MaxBoxRowItem(void);
	Gdipcustomitem::TCustomItem* __fastcall MaxBoxColumnItem(void);
	int __fastcall MinSelectableItemIndex(void);
	int __fastcall MaxSelectableItemIndex(void);
	int __fastcall MinFocusableItemIndex(void);
	int __fastcall MaxFocusableItemIndex(void);
	int __fastcall RowCount(void);
	int __fastcall ColumnCount(void);
	Gdipcustomitem::TItemAppearance __fastcall GetItemAppearance(void);
	__property int Width = {read=FWidth, write=SetWidth, default=150};
	__property int Height = {read=FHeight, write=SetHeight, default=200};
	__property Classes::TNotifyEvent OnInternalRefresh = {read=FOnInternalRefresh, write=FOnInternalRefresh};
	__property Classes::TNotifyEvent OnInternalChange = {read=FOnInternalChange, write=FOnInternalChange};
	__property Classes::TNotifyEvent OnNotifyItemDestroy = {read=FOnNotifyItemDestroy, write=FOnNotifyItemDestroy};
	__property Classes::TNotifyEvent OnNotifyListDestroy = {read=FOnNotifyListDestroy, write=FOnNotifyListDestroy};
	__property Classes::TNotifyEvent OnNotifyItemChange = {read=FOnNotifyItemChange, write=FOnNotifyItemChange};
	__property TItemDesignTimeSelect OnNotifyItemDesignTimeSelect = {read=FOnNotifyItemDesignTimeSelect, write=FOnNotifyItemDesignTimeSelect};
	__property TItemCompareEvent OnItemCompare = {read=FOnItemCompare, write=FOnItemCompare};
	__property Gdipcustomitem::TItemSelectEvent OnItemSelect = {read=FOnItemSelect, write=FOnItemSelect};
	__property Gdipcustomitem::TItemSelectEvent OnItemDeSelect = {read=FOnItemDeSelect, write=FOnItemDeSelect};
	__property Gdipcustomitem::TItemEvent OnItemDestroy = {read=FOnItemDestroy, write=FOnItemDestroy};
	__property int FocusedItemIndex = {read=FFocusedItemIndex, write=FFocusedItemIndex, nodefault};
	
__published:
	__property TCustomListObjects* Items = {read=FItems, write=SetItems};
	__property TCustomBaseListAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property bool MultiSelect = {read=FMultiSelect, write=SetMultiSelect, default=0};
	__property Classes::TNotifyEvent OnRefresh = {read=FOnRefresh, write=FOnRefresh};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TSubClassList;
class PASCALIMPLEMENTATION TSubClassList : public Contnrs::TClassList
{
	typedef Contnrs::TClassList inherited;
	
private:
	Classes::TPersistentClass FParentClass;
	void __fastcall CallbackClass(Classes::TPersistentClass AClass);
	
public:
	void __fastcall Execute(const Classes::TPersistentClass aClass);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TSubClassList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TSubClassList(void) : Contnrs::TClassList() { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gdipbase */
using namespace Gdipbase;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipbaseHPP
