// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atBdeDatabase.pas' rev: 22.00

#ifndef AtbdedatabaseHPP
#define AtbdedatabaseHPP

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
#include <atDatabase.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atbdedatabase
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatBdeDatabase;
class PASCALIMPLEMENTATION TatBdeDatabase : public Atdatabase::TatDatabase
{
	typedef Atdatabase::TatDatabase inherited;
	
private:
	System::UnicodeString FDatabaseName;
	System::UnicodeString FSessionName;
	Dbtables::TSession* __fastcall CurrentSession(void);
	
public:
	__fastcall virtual TatBdeDatabase(Classes::TComponent* AOwner);
	virtual Db::TDataSet* __fastcall OpenQuery(System::UnicodeString ASql);
	virtual void __fastcall LoadTableNameList(Classes::TStrings* AList);
	virtual void __fastcall LoadFieldNameList(System::UnicodeString ATableName, Classes::TStrings* AList);
	virtual System::UnicodeString __fastcall ReadSqlProperty(Db::TDataSet* ADataset);
	virtual void __fastcall WriteSqlProperty(Db::TDataSet* ADataset, System::UnicodeString ASql);
	
__published:
	__property System::UnicodeString DatabaseName = {read=FDatabaseName, write=FDatabaseName};
	__property System::UnicodeString SessionName = {read=FSessionName, write=FSessionName};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TatBdeDatabase(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atbdedatabase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atbdedatabase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtbdedatabaseHPP
