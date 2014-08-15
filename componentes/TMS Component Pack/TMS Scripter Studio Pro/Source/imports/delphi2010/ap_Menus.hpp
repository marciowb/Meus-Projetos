// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ap_menus.pas' rev: 21.00

#ifndef Ap_menusHPP
#define Ap_menusHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Ap_messages.hpp>	// Pascal unit
#include <Ap_types.hpp>	// Pascal unit
#include <Atscript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_menus
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatMenusLibrary;
class PASCALIMPLEMENTATION TatMenusLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __TMenuItemEnumeratorCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemEnumeratorGetCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemEnumeratorMoveNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuItemEnumeratorCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemInitiateAction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemInsert(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemDelete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemClick(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemFind(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemIndexOf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemIsLine(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemGetEnumerator(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemGetImageList(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemGetParentComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemGetParentMenu(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemHasParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemNewTopLine(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemNewBottomLine(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemInsertNewLineBefore(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemInsertNewLineAfter(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemRemove(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemRethinkHotkeys(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemRethinkLines(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemSetParentComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuItemCommand(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuItemHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuItemCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuItemItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuItemMenuIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMenuItemMenuIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuItemParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuCreateMenuItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuDispatchCommand(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuDispatchPopup(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuFindItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuGetHelpContext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuIsRightToLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuIsShortCut(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuParentBiDiModeChanged(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuProcessMenuChar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuImages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMenuImages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuAutoHotkeys(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMenuAutoHotkeys(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuAutoLineReduction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMenuAutoLineReduction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuBiDiMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMenuBiDiMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuOwnerDraw(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMenuOwnerDraw(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuParentBiDiMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMenuParentBiDiMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMenuWindowHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMenuWindowHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMainMenuMerge(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMainMenuUnmerge(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMainMenuSetOle2MenuHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPopupMenuCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPopupMenuDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPopupMenuPopup(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPopupMenuPopupComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTPopupMenuPopupComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPopupMenuPopupPoint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPopupListAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPopupListRemove(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPopupListWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMenuItemStackClearItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ShortCut(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ShortCutToKey(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ShortCutToText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TextToShortCut(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ShortCutFromMessage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __NewLine(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DrawMenuItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __StripHotkey(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetHotkey(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SameCaption(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetPopupList(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetPopupList(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetShortCutItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetShortCutItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetValidMenuHotkeys(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetValidMenuHotkeys(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatMenusLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatMenusLibrary(void) { }
	
};


typedef TMetaClass* EMenuErrorClass;

typedef TMetaClass* TMenuActionLinkClass;

typedef TMetaClass* TMenuItemEnumeratorClass;

typedef TMetaClass* TMenuItemClass;

typedef TMetaClass* TMenuClass;

typedef TMetaClass* TMainMenuClass;

typedef TMetaClass* TPopupMenuClass;

typedef TMetaClass* TPopupListClass;

typedef TMetaClass* TMenuItemStackClass;

class DELPHICLASS TatMenusDispatcher;
class PASCALIMPLEMENTATION TatMenusDispatcher : public Atscript::TatEventDispatcher
{
	typedef Atscript::TatEventDispatcher inherited;
	
private:
	void __fastcall __TMenuChangeEvent(System::TObject* Sender, Menus::TMenuItem* Source, bool Rebuild);
	void __fastcall __TMenuMeasureItemEvent(System::TObject* Sender, Graphics::TCanvas* ACanvas, int &Width, int &Height);
public:
	/* TatEventDispatcher.Create */ inline __fastcall virtual TatMenusDispatcher(Classes::TCollection* ACollection) : Atscript::TatEventDispatcher(ACollection) { }
	/* TatEventDispatcher.Destroy */ inline __fastcall virtual ~TatMenusDispatcher(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_menus */
using namespace Ap_menus;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_menusHPP
