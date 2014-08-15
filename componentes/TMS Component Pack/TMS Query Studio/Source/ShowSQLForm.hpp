// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ShowSQLForm.pas' rev: 22.00

#ifndef ShowsqlformHPP
#define ShowsqlformHPP

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

//-- user supplied -----------------------------------------------------------

namespace Showsqlform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmShowSQL;
class PASCALIMPLEMENTATION TfmShowSQL : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* Panel1;
	Extctrls::TPanel* Panel2;
	Extctrls::TPanel* Panel3;
	Stdctrls::TButton* Button1;
	Stdctrls::TMemo* Memo1;
	void __fastcall Button1Click(System::TObject* Sender);
	
private:
	void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmShowSQL(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmShowSQL(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmShowSQL(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmShowSQL(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall ShowSQL(const System::UnicodeString ASQL);

}	/* namespace Showsqlform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Showsqlform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ShowsqlformHPP
