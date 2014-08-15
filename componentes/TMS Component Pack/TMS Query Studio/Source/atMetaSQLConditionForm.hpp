// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atMetaSQLConditionForm.pas' rev: 22.00

#ifndef AtmetasqlconditionformHPP
#define AtmetasqlconditionformHPP

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
#include <atMetaSQL.hpp>	// Pascal unit
#include <atMetaSQLConditionEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atmetasqlconditionform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmMetaSQLConditionForm;
class PASCALIMPLEMENTATION TfmMetaSQLConditionForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	void __fastcall FormActivate(System::TObject* Sender);
	
private:
	Atmetasqlconditioneditor::TfmMetaSQLConditionEditor* FConditionEditor;
	void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmMetaSQLConditionForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmMetaSQLConditionForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmMetaSQLConditionForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmMetaSQLConditionForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall EditSQLConditions(Atmetasql::TatMetaSQL* AMetaSQL, Atmetasql::TatSQLConditions* AConds, System::UnicodeString DBName);

}	/* namespace Atmetasqlconditionform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atmetasqlconditionform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtmetasqlconditionformHPP
