// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Stringsinspeditor.pas' rev: 21.00

#ifndef StringsinspeditorHPP
#define StringsinspeditorHPP

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
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Propertyinspeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Stringsinspeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmStrings;
class PASCALIMPLEMENTATION TfrmStrings : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TLabel* lblCount;
	Comctrls::TRichEdit* redStrings;
	Stdctrls::TButton* btnOK;
	Stdctrls::TButton* btnCancel;
	Stdctrls::TButton* btnClear;
	Classes::TStrings* __fastcall GetStrings(void);
	void __fastcall redStringsChange(System::TObject* Sender);
	void __fastcall btnClearClick(System::TObject* Sender);
	
public:
	__property Classes::TStrings* Strings = {read=GetStrings};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmStrings(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmStrings(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmStrings(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmStrings(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TStringsPropertyEditor;
class PASCALIMPLEMENTATION TStringsPropertyEditor : public Propertyinspeditors::TPropertyEditor
{
	typedef Propertyinspeditors::TPropertyEditor inherited;
	
public:
	virtual bool __fastcall Execute(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TStringsPropertyEditor(Propertylist::TProperty* AProp) : Propertyinspeditors::TPropertyEditor(AProp) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TStringsPropertyEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Stringsinspeditor */
using namespace Stringsinspeditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// StringsinspeditorHPP
