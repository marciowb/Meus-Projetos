// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dflexcelreporteditor.pas' rev: 11.00

#ifndef DflexcelreporteditorHPP
#define DflexcelreporteditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Ucustomflexcelreport.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uexceledit.hpp>	// Pascal unit
#include <Uflxdesignhelp.hpp>	// Pascal unit
#include <Uchecktemplate.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dflexcelreporteditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFlexCelReportEditor;
class PASCALIMPLEMENTATION TFlexCelReportEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TFlexCelReportEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TFlexCelReportEditor(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dflexcelreporteditor */
using namespace Dflexcelreporteditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Dflexcelreporteditor
