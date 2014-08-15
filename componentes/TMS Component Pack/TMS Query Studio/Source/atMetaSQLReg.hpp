// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atMetaSQLReg.pas' rev: 22.00

#ifndef AtmetasqlregHPP
#define AtmetasqlregHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atmetasqlreg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatDBStringProperty;
class PASCALIMPLEMENTATION TatDBStringProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValueList(Classes::TStrings* List) = 0 ;
	virtual void __fastcall GetValues(Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TatDBStringProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TatDBStringProperty(void) { }
	
};


class DELPHICLASS TatDatabaseNameProperty;
class PASCALIMPLEMENTATION TatDatabaseNameProperty : public TatDBStringProperty
{
	typedef TatDBStringProperty inherited;
	
public:
	virtual void __fastcall GetValueList(Classes::TStrings* List);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TatDatabaseNameProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TatDBStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TatDatabaseNameProperty(void) { }
	
};


class DELPHICLASS TatSessionNameProperty;
class PASCALIMPLEMENTATION TatSessionNameProperty : public TatDBStringProperty
{
	typedef TatDBStringProperty inherited;
	
public:
	virtual void __fastcall GetValueList(Classes::TStrings* List);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TatSessionNameProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TatDBStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TatSessionNameProperty(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define SMetaSQLPaletteName L"TMS Query Studio"
extern PACKAGE void __fastcall Register(void);

}	/* namespace Atmetasqlreg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atmetasqlreg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtmetasqlregHPP
