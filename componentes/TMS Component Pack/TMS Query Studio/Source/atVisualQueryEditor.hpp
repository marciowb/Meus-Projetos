// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atVisualQueryEditor.pas' rev: 22.00

#ifndef AtvisualqueryeditorHPP
#define AtvisualqueryeditorHPP

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
#include <Variants.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <atVisualQuery.hpp>	// Pascal unit
#include <atMetaSQL.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atvisualqueryeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmVisualQueryEditor;
class PASCALIMPLEMENTATION TfmVisualQueryEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TPageControl* PageControl1;
	Comctrls::TTabSheet* TabSheet1;
	Extctrls::TPanel* Panel1;
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button2;
	Atvisualquery::TatVisualQuery* atVisualQuery1;
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmVisualQueryEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmVisualQueryEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmVisualQueryEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmVisualQueryEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TatVisualQueryEditor;
class PASCALIMPLEMENTATION TatVisualQueryEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
	virtual void __fastcall Edit(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TatVisualQueryEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatVisualQueryEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmVisualQueryEditor* fmVisualQueryEditor;
extern PACKAGE bool __fastcall EditVisualQuery(Atvisualquery::TatVisualQuery* AVisualQuery);

}	/* namespace Atvisualqueryeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atvisualqueryeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtvisualqueryeditorHPP
