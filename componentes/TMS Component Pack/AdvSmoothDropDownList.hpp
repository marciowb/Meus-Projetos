// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothdropdownlist.pas' rev: 21.00

#ifndef AdvsmoothdropdownlistHPP
#define AdvsmoothdropdownlistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Advsmoothlistbox.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothdropdownlist
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvSmoothCrackedListBox;
class PASCALIMPLEMENTATION TAdvSmoothCrackedListBox : public Advsmoothlistbox::TAdvSmoothListBox
{
	typedef Advsmoothlistbox::TAdvSmoothListBox inherited;
	
public:
	/* TAdvSmoothListBox.Create */ inline __fastcall virtual TAdvSmoothCrackedListBox(Classes::TComponent* AOwner) : Advsmoothlistbox::TAdvSmoothListBox(AOwner) { }
	/* TAdvSmoothListBox.Destroy */ inline __fastcall virtual ~TAdvSmoothCrackedListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothCrackedListBox(HWND ParentWindow) : Advsmoothlistbox::TAdvSmoothListBox(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TAdvSmoothDropDownListItemSelect)(System::TObject* Sender, System::UnicodeString Value);

class DELPHICLASS TAdvSmoothDropDownList;
class PASCALIMPLEMENTATION TAdvSmoothDropDownList : public Extctrls::TPanel
{
	typedef Extctrls::TPanel inherited;
	
private:
	Advsmoothlistbox::TAdvSmoothListBoxItem* FSearchItem;
	bool DoSelect;
	bool SearchList;
	Advsmoothlistbox::TAdvSmoothListBox* FOwnerListBox;
	Advsmoothlistbox::TAdvSmoothListBoxItem* FOwnerListBoxItem;
	Advsmoothlistbox::TAdvSmoothListBox* FLst;
	Stdctrls::TEdit* FEdt;
	Classes::TStringList* FItems;
	TAdvSmoothDropDownListItemSelect FOnItemSelect;
	void __fastcall SetItems(const Classes::TStringList* Value);
	
public:
	__fastcall virtual TAdvSmoothDropDownList(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothDropDownList(void);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall DoEnter(void);
	
protected:
	void __fastcall KeyDownEdit(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall ItemSelected(System::TObject* Sender, int ItemIndex);
	void __fastcall DoItemSelect(System::TObject* Sender, System::UnicodeString Value);
	void __fastcall StringListChanged(System::TObject* Sender);
	void __fastcall UpdateListBox(void);
	void __fastcall SetOwner(Advsmoothlistbox::TAdvSmoothListBox* Owner, Advsmoothlistbox::TAdvSmoothListBoxItem* Item);
	HIDESBASE void __fastcall Show(Advsmoothlistbox::TAdvSmoothListBoxItem* Item);
	
public:
	__property Classes::TStringList* Items = {read=FItems, write=SetItems};
	__property TAdvSmoothDropDownListItemSelect OnItemSelect = {read=FOnItemSelect, write=FOnItemSelect};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothDropDownList(HWND ParentWindow) : Extctrls::TPanel(ParentWindow) { }
	
private:
	void *__ISmoothListBox;	/* Advsmoothlistbox::ISmoothListBox */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Advsmoothlistbox::_di_ISmoothListBox()
	{
		Advsmoothlistbox::_di_ISmoothListBox intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator ISmoothListBox*(void) { return (ISmoothListBox*)&__ISmoothListBox; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advsmoothdropdownlist */
using namespace Advsmoothdropdownlist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothdropdownlistHPP
