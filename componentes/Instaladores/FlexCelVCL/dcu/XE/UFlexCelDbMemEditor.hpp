// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UFlexCelDbMemEditor.pas' rev: 22.00

#ifndef UflexceldbmemeditorHPP
#define UflexceldbmemeditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <UFlxMemTable.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflexceldbmemeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFlexCelDbMemEditor;
class PASCALIMPLEMENTATION TFlexCelDbMemEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty PropertyEditor, bool &Continue);
	
public:
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TFlexCelDbMemEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFlexCelDbMemEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflexceldbmemeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uflexceldbmemeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UflexceldbmemeditorHPP
