// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'DFENewField.pas' rev: 22.00

#ifndef DfenewfieldHPP
#define DfenewfieldHPP

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
#include <ExtCtrls.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <DBClient.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dfenewfield
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmDFENewField;
class PASCALIMPLEMENTATION TfmDFENewField : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TGroupBox* gbProperties;
	Extctrls::TRadioGroup* rgKind;
	Stdctrls::TGroupBox* gbLookup;
	Stdctrls::TLabel* Label1;
	Stdctrls::TLabel* Label2;
	Stdctrls::TLabel* Label3;
	Stdctrls::TLabel* Label4;
	Stdctrls::TLabel* lbKeyField;
	Stdctrls::TLabel* lbLookupDataset;
	Stdctrls::TLabel* lbLookupKey;
	Stdctrls::TLabel* lbResultField;
	Stdctrls::TEdit* edName;
	Stdctrls::TEdit* edComponent;
	Stdctrls::TComboBox* cbType;
	Stdctrls::TEdit* edSize;
	Stdctrls::TComboBox* cbKeyField;
	Stdctrls::TComboBox* cbLookupDataset;
	Stdctrls::TComboBox* cbLookupKey;
	Stdctrls::TComboBox* cbResultField;
	Stdctrls::TButton* btOk;
	Stdctrls::TButton* btCancel;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall rgKindClick(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall edNameChange(System::TObject* Sender);
	void __fastcall cbTypeChange(System::TObject* Sender);
	void __fastcall cbLookupDatasetChange(System::TObject* Sender);
	
private:
	Classes::TComponent* FFieldOwner;
	Db::TDataSet* FFieldDataset;
	bool __fastcall CheckFieldProperties(void);
	void __fastcall EnableLookupGroup(void);
	void __fastcall LoadFieldKindList(void);
	void __fastcall LoadFieldTypeList(void);
	void __fastcall LoadKeyFieldList(void);
	void __fastcall LoadLookupDatasetList(void);
	void __fastcall LoadLookupFieldLists(void);
	Db::TFieldKind __fastcall GetFieldKind(void);
	void __fastcall SetFieldKind(const Db::TFieldKind Value);
	Db::TFieldClass __fastcall GetFieldClass(void);
	Db::TFieldType __fastcall GetFieldType(void);
	Db::TDataSet* __fastcall GetLookupDataset(void);
	
public:
	Db::TField* __fastcall CreateNewField(void);
	__property Db::TFieldClass FieldClass = {read=GetFieldClass};
	__property Db::TDataSet* FieldDataset = {read=FFieldDataset, write=FFieldDataset};
	__property Db::TFieldKind FieldKind = {read=GetFieldKind, write=SetFieldKind, nodefault};
	__property Classes::TComponent* FieldOwner = {read=FFieldOwner, write=FFieldOwner};
	__property Db::TFieldType FieldType = {read=GetFieldType, nodefault};
	__property Db::TDataSet* LookupDataset = {read=GetLookupDataset};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmDFENewField(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmDFENewField(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmDFENewField(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmDFENewField(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::UnicodeString __fastcall DFEMakeFieldComponentName(Classes::TComponent* AOwner, Db::TDataSet* ADataset, System::UnicodeString AFieldName);

}	/* namespace Dfenewfield */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Dfenewfield;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DfenewfieldHPP
