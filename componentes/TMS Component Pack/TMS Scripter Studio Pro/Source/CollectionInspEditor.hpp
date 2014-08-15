// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CollectionInspEditor.pas' rev: 22.00

#ifndef CollectioninspeditorHPP
#define CollectioninspeditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <InspectorControls.hpp>	// Pascal unit
#include <ComponentInspector.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <PropertyList.hpp>	// Pascal unit
#include <PropertyInspEditors.hpp>	// Pascal unit
#include <IDEMain.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Collectioninspeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCollectionPropertyEditor;
class PASCALIMPLEMENTATION TCollectionPropertyEditor : public Propertyinspeditors::TPropertyEditor
{
	typedef Propertyinspeditors::TPropertyEditor inherited;
	
private:
	Classes::TCollection* __fastcall GetCollection(void);
	
public:
	virtual bool __fastcall Execute(void);
	__property Classes::TCollection* Collection = {read=GetCollection};
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TCollectionPropertyEditor(Propertylist::TProperty* AProp) : Propertyinspeditors::TPropertyEditor(AProp) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCollectionPropertyEditor(void) { }
	
};


#pragma option push -b-
enum TTargetPosition { tpNone, tpTop, tpItem, tpBottom };
#pragma option pop

class DELPHICLASS TfrmCollectionEditor;
class PASCALIMPLEMENTATION TfrmCollectionEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TSplitter* splMain;
	Extctrls::TPanel* pnlButtons;
	Stdctrls::TButton* btnAdd;
	Stdctrls::TButton* btnDelete;
	Extctrls::TPanel* pnlSysButtons;
	Stdctrls::TButton* btnClose;
	Stdctrls::TListBox* lsbItems;
	Stdctrls::TButton* btnUp;
	Stdctrls::TButton* btnDown;
	Idemain::TIDEInspector* cinItemProperties;
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall lsbItemsClick(System::TObject* Sender);
	void __fastcall lsbItemsDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall lsbItemsDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall lsbItemsMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall btnUpClick(System::TObject* Sender);
	void __fastcall btnDownClick(System::TObject* Sender);
	void __fastcall btnAddClick(System::TObject* Sender);
	void __fastcall btnDeleteClick(System::TObject* Sender);
	void __fastcall cinItemPropertiesChange(System::TObject* Sender, int TheIndex);
	void __fastcall cinItemPropertiesExit(System::TObject* Sender);
	
private:
	TCollectionPropertyEditor* FEditor;
	int FDragIndex;
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TMessage &Msg);
	System::UnicodeString __fastcall ItemText(Classes::TCollectionItem* CI);
	void __fastcall UpdateSelection(void);
	void __fastcall MoveUp(int Target);
	void __fastcall MoveDown(int Target);
	void __fastcall Reorder(void);
	void __fastcall FillList(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmCollectionEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmCollectionEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmCollectionEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmCollectionEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Collectioninspeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Collectioninspeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CollectioninspeditorHPP
