// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'DFEAddFields.pas' rev: 22.00

#ifndef DfeaddfieldsHPP
#define DfeaddfieldsHPP

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
#include <DB.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dfeaddfields
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmDFEAddFields;
class PASCALIMPLEMENTATION TfmDFEAddFields : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TGroupBox* gbFields;
	Stdctrls::TButton* btOk;
	Stdctrls::TButton* btCancel;
	Stdctrls::TListBox* lsFieldDefs;
	void __fastcall lsFieldDefsClick(System::TObject* Sender);
	
private:
	Db::TDataSet* FDataset;
	void __fastcall ListFields(void);
	void __fastcall SetDataset(const Db::TDataSet* Value);
	Db::TFieldDef* __fastcall GetSelectedField(int AIndex);
	int __fastcall GetSelectedFieldCount(void);
	void __fastcall SelectAllFields(void);
	
public:
	__property Db::TDataSet* Dataset = {read=FDataset, write=SetDataset};
	__property int SelectedFieldCount = {read=GetSelectedFieldCount, nodefault};
	__property Db::TFieldDef* SelectedFields[int i] = {read=GetSelectedField};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmDFEAddFields(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmDFEAddFields(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmDFEAddFields(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmDFEAddFields(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dfeaddfields */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Dfeaddfields;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DfeaddfieldsHPP
