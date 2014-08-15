// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fCustomEditor.pas' rev: 22.00

#ifndef FcustomeditorHPP
#define FcustomeditorHPP

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
#include <StdCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <atMetaSQL.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <atVisualQuery.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fcustomeditor
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TEditPopupMode { epNone, epInsertFieldAlias, epInsertField, epInsertTableAlias };
#pragma option pop

#pragma option push -b-
enum TEditorFormStyle { esToolWindow, esFixedFrame };
#pragma option pop

typedef TMetaClass* TEditorClass;

class DELPHICLASS HackWinControl;
class PASCALIMPLEMENTATION HackWinControl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	/* TWinControl.Create */ inline __fastcall virtual HackWinControl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall HackWinControl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~HackWinControl(void) { }
	
};


class DELPHICLASS TfmCustomEditor;
class PASCALIMPLEMENTATION TfmCustomEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Menus::TPopupMenu* PopupMenu1;
	Extctrls::TPanel* pnBottom;
	Extctrls::TPanel* pnButton;
	Buttons::TBitBtn* btOk;
	Buttons::TBitBtn* btCancel;
	Extctrls::TPanel* pnTitle;
	Extctrls::TPanel* pnInfo;
	Stdctrls::TLabel* lbInfo;
	void __fastcall FormKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormPaint(System::TObject* Sender);
	void __fastcall btOkClick(System::TObject* Sender);
	
private:
	Atvisualquery::TatVisualQuery* FVisualQuery;
	Atvisualquery::TatMetaSqlDef* FMetaSqlDef;
	TEditPopupMode FEditPopupMode;
	System::TObject* FEditedObject;
	void __fastcall SetVisualQuery(const Atvisualquery::TatVisualQuery* Value);
	void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
	int __fastcall ComboFindObject(Stdctrls::TComboBox* combo, int i);
	bool __fastcall ComboMatchItem(Stdctrls::TComboBox* combo, System::UnicodeString txt);
	void __fastcall ProcessLookupComboKey(System::TObject* Sender, System::WideChar &key);
	void __fastcall LoadParamNameCombo(Stdctrls::TComboBox* combo);
	void __fastcall AdjustDefaultItems(void);
	virtual void __fastcall SetEditedObject(const System::TObject* Value);
	void __fastcall ValidationError(bool ARaise, System::UnicodeString msg, System::TVarRec *args, const int args_Size, Controls::TWinControl* ctrl);
	Atmetasql::TatMetaSQL* __fastcall ParseMetaSql(const System::UnicodeString sql);
	Atmetasql::TatMetaSQL* __fastcall MetaSql(void);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	void __fastcall LoadTableNameList(Classes::TStrings* lst);
	void __fastcall LoadFieldNameList(System::UnicodeString ATableName, Classes::TStrings* lst);
	
public:
	__property Atvisualquery::TatMetaSqlDef* MetaSqlDef = {read=FMetaSqlDef, write=FMetaSqlDef};
	__property TEditPopupMode EditPopupMode = {read=FEditPopupMode, write=FEditPopupMode, nodefault};
	__property System::TObject* EditedObject = {read=FEditedObject, write=SetEditedObject};
	__property Atvisualquery::TatVisualQuery* VisualQuery = {read=FVisualQuery, write=SetVisualQuery};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmCustomEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmCustomEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmCustomEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmCustomEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmCustomEditor* fmCustomEditor;
extern PACKAGE TEditorFormStyle EditorFormStyle;
extern PACKAGE Atmetasql::TatSQLJoin* __fastcall JoinConditions(Atmetasql::TatSqlTable* ASqlTable);
extern PACKAGE void __fastcall OpenItemEditor(TEditorClass AEditorClass, int X, int Y, Atvisualquery::TatVisualQuery* AVisualQuery, Atvisualquery::TatMetaSqlDef* AMetaSqlDef, System::TObject* &AEditedObj);

}	/* namespace Fcustomeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fcustomeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FcustomeditorHPP
