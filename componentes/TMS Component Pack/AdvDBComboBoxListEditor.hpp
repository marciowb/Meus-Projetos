// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advdbcomboboxlisteditor.pas' rev: 21.00

#ifndef AdvdbcomboboxlisteditorHPP
#define AdvdbcomboboxlisteditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Advdbcombobox.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advdbcomboboxlisteditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TComboListEditor;
class PASCALIMPLEMENTATION TComboListEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Grids::TStringGrid* sg_ComboList;
	Stdctrls::TButton* btn_Ok;
	Stdctrls::TButton* btn_Cancel;
	Stdctrls::TButton* bt_ClearList;
	Stdctrls::TButton* btn_GetStoredVal;
	Stdctrls::TButton* btn_Add;
	Stdctrls::TListBox* lb_ImageList;
	Stdctrls::TButton* btn_Del;
	Stdctrls::TLabel* lbl_Images;
	Stdctrls::TLabel* Label1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall bt_ClearListClick(System::TObject* Sender);
	void __fastcall btn_OkClick(System::TObject* Sender);
	void __fastcall btn_AddClick(System::TObject* Sender);
	void __fastcall lb_ImageListDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall sg_ComboListKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall btn_DelClick(System::TObject* Sender);
	void __fastcall btn_GetStoredValClick(System::TObject* Sender);
	void __fastcall sg_ComboListDrawCell(System::TObject* Sender, int ACol, int ARow, const Types::TRect &Rect, Grids::TGridDrawState State);
	void __fastcall sg_ComboListDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall sg_ComboListDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	
private:
	Advdbcombobox::TAdvDBComboBox* FDBCombo;
	void __fastcall SetDBCombo(const Advdbcombobox::TAdvDBComboBox* Value);
	void __fastcall InitForm(void);
	void __fastcall RemoveRows(int RowIndex, int RCount);
	void __fastcall LoadImageListBox(void);
	
public:
	__property Advdbcombobox::TAdvDBComboBox* DBCombo = {read=FDBCombo, write=SetDBCombo};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TComboListEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TComboListEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TComboListEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TComboListEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TComboListEditor* ComboListEditor;

}	/* namespace Advdbcomboboxlisteditor */
using namespace Advdbcomboboxlisteditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvdbcomboboxlisteditorHPP
