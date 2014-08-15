// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'uAboutUILSecurity.pas' rev: 22.00

#ifndef UaboutuilsecurityHPP
#define UaboutuilsecurityHPP

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
#include <ShellAPI.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <usmGlobals.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uaboutuilsecurity
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmAboutUilUtilities;
class PASCALIMPLEMENTATION TfrmAboutUilUtilities : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* btnOK;
	Stdctrls::TLabel* labTitle;
	Extctrls::TBevel* Bevel1;
	Stdctrls::TLabel* Label4;
	Stdctrls::TLabel* Label1;
	Stdctrls::TLabel* Label3;
	Stdctrls::TLabel* Label5;
	Stdctrls::TLabel* Label6;
	Stdctrls::TLabel* Label7;
	Stdctrls::TLabel* Label8;
	Extctrls::TImage* Image1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Label1Click(System::TObject* Sender);
	void __fastcall Label5Click(System::TObject* Sender);
	void __fastcall Label7Click(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmAboutUilUtilities(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmAboutUilUtilities(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmAboutUilUtilities(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmAboutUilUtilities(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TVersionEditor;
class PASCALIMPLEMENTATION TVersionEditor : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual bool __fastcall AllEqual(void);
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value)/* overload */;
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TVersionEditor(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TVersionEditor(void) { }
	
/* Hoisted overloads: */
	
public:
	inline void __fastcall  SetValue(const System::WideString Value){ Designeditors::TPropertyEditor::SetValue(Value); }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uaboutuilsecurity */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uaboutuilsecurity;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UaboutuilsecurityHPP
