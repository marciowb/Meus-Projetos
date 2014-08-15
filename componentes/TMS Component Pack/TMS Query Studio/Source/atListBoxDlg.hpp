// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atListBoxDlg.pas' rev: 22.00

#ifndef AtlistboxdlgHPP
#define AtlistboxdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <ListForm.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atlistboxdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatListBoxDlg;
class PASCALIMPLEMENTATION TatListBoxDlg : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Graphics::TColor FColor;
	bool FDragAndDrop;
	bool FExtendedSelect;
	int FItemIndex;
	Classes::TStrings* FItems;
	bool FMultiSelect;
	Classes::TStrings* FSelectedItems;
	bool FSorted;
	System::UnicodeString FTitle;
	int FWindowHeight;
	int FWindowWidth;
	Graphics::TFont* FFont;
	System::UnicodeString FOk;
	System::UnicodeString FCancel;
	void __fastcall SetWindowWidth(int value);
	void __fastcall SetWindowHeight(int value);
	void __fastcall SetItems(Classes::TStrings* value);
	void __fastcall SetSelectedItems(Classes::TStrings* value);
	bool __fastcall GetItemSelected(int i);
	void __fastcall SetItemSelected(int i, bool valor);
	void __fastcall SetFont(Graphics::TFont* Value);
	int __fastcall GetItemIndex(void);
	void __fastcall SetItemIndex(int Value);
	void __fastcall SetDragAndDrop(bool Value);
	void __fastcall SetMultiSelect(bool Value);
	bool __fastcall GetDragDropMultiSelect(void);
	void __fastcall SetDragDropMultiSelect(const bool Value);
	
public:
	__fastcall virtual TatListBoxDlg(Classes::TComponent* AOwner);
	__fastcall virtual ~TatListBoxDlg(void);
	bool __fastcall Execute(void);
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	__property bool ItemSelected[int i] = {read=GetItemSelected, write=SetItemSelected};
	__property bool DragDropMultiSelect = {read=GetDragDropMultiSelect, write=SetDragDropMultiSelect, nodefault};
	
__published:
	__property System::UnicodeString CancelCaption = {read=FCancel, write=FCancel};
	__property System::UnicodeString OkCaption = {read=FOk, write=FOk};
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=-16777211};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool DragAndDrop = {read=FDragAndDrop, write=SetDragAndDrop, nodefault};
	__property bool ExtendedSelect = {read=FExtendedSelect, write=FExtendedSelect, nodefault};
	__property Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property bool MultiSelect = {read=FMultiSelect, write=SetMultiSelect, nodefault};
	__property Classes::TStrings* SelectedItems = {read=FSelectedItems, write=SetSelectedItems};
	__property bool Sorted = {read=FSorted, write=FSorted, nodefault};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property int WindowHeight = {read=FWindowHeight, write=SetWindowHeight, nodefault};
	__property int WindowWidth = {read=FWindowWidth, write=SetWindowWidth, nodefault};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atlistboxdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atlistboxdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtlistboxdlgHPP
