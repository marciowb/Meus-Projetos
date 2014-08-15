// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'DFlexCelReportEditor.pas' rev: 22.00

#ifndef DflexcelreporteditorHPP
#define DflexcelreporteditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <ShellAPI.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <UCustomFlexCelReport.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit
#include <UExcelEdit.hpp>	// Pascal unit
#include <UFlxDesignHelp.hpp>	// Pascal unit
#include <UCheckTemplate.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dflexcelreporteditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFlexCelReportEditor;
class PASCALIMPLEMENTATION TFlexCelReportEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TFlexCelReportEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFlexCelReportEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dflexcelreporteditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Dflexcelreporteditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DflexcelreporteditorHPP
