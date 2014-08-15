// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atDatabase.pas' rev: 22.00

#ifndef AtdatabaseHPP
#define AtdatabaseHPP

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
#include <DB.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atdatabase
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TatRetrieveTablenameListEvent)(const Classes::TStrings* AList);

typedef void __fastcall (__closure *TatRetrieveFieldNameListEvent)(const System::UnicodeString ATableName, const Classes::TStrings* AList);

class DELPHICLASS TatDatabase;
class PASCALIMPLEMENTATION TatDatabase : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TatRetrieveFieldNameListEvent FOnRetrieveFieldNameListEvent;
	TatRetrieveTablenameListEvent FOnRetrieveTablenameListEvent;
	
public:
	void __fastcall RetrieveTables(Classes::TStrings* ATables);
	void __fastcall RetrieveFields(System::UnicodeString ATableName, Classes::TStrings* AFields);
	virtual Db::TDataSet* __fastcall OpenQuery(System::UnicodeString ASql);
	virtual void __fastcall LoadTableNameList(Classes::TStrings* AList);
	virtual void __fastcall LoadFieldNameList(System::UnicodeString ATableName, Classes::TStrings* AList);
	virtual System::UnicodeString __fastcall ReadSqlProperty(Db::TDataSet* ADataset);
	virtual void __fastcall WriteSqlProperty(Db::TDataSet* ADataset, System::UnicodeString ASql);
	void __fastcall LoadLookupQuery(System::UnicodeString ASql, Classes::TStrings* AList);
	
__published:
	__property TatRetrieveTablenameListEvent OnRetrieveTablenameListEvent = {read=FOnRetrieveTablenameListEvent, write=FOnRetrieveTablenameListEvent};
	__property TatRetrieveFieldNameListEvent OnRetrieveFieldNameListEvent = {read=FOnRetrieveFieldNameListEvent, write=FOnRetrieveFieldNameListEvent};
public:
	/* TComponent.Create */ inline __fastcall virtual TatDatabase(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TatDatabase(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall WriteSqlProperty(Db::TDataSet* ADataset, Classes::TComponent* ADatabase, System::UnicodeString ASql);
extern PACKAGE System::UnicodeString __fastcall ReadSqlProperty(Db::TDataSet* ADataset, Classes::TComponent* ADatabase);

}	/* namespace Atdatabase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atdatabase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtdatabaseHPP
