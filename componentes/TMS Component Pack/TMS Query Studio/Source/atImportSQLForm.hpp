// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atImportSQLForm.pas' rev: 22.00

#ifndef AtimportsqlformHPP
#define AtimportsqlformHPP

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
#include <atMetaSQL.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atimportsqlform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmImportSQL;
class PASCALIMPLEMENTATION TfmImportSQL : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TMemo* Memo1;
	Extctrls::TPanel* Panel1;
	Stdctrls::TButton* btCheck;
	Stdctrls::TButton* btOk;
	Stdctrls::TButton* btcancel;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall btOkClick(System::TObject* Sender);
	void __fastcall btCheckClick(System::TObject* Sender);
	
private:
	Atmetasql::TatMetaSQL* FInternalMetaSQL;
	Atmetasql::TatMetaSQL* FMetaSQL;
	void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmImportSQL(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmImportSQL(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmImportSQL(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmImportSQL(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall ImportSQLDialog(const System::UnicodeString ASQL, Atmetasql::TatMetaSQL* AMetaSQL);

}	/* namespace Atimportsqlform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atimportsqlform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtimportsqlformHPP
