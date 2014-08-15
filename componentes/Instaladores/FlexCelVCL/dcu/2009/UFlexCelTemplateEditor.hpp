// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflexceltemplateeditor.pas' rev: 20.00

#ifndef UflexceltemplateeditorHPP
#define UflexceltemplateeditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Templatestore.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uflxdesignhelp.hpp>	// Pascal unit
#include <Utemplateedit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflexceltemplateeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFlexCelTemplateEditor;
class PASCALIMPLEMENTATION TFlexCelTemplateEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TFlexCelTemplateEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFlexCelTemplateEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflexceltemplateeditor */
using namespace Uflexceltemplateeditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UflexceltemplateeditorHPP
