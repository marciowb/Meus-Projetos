// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atCustomDatabase.pas' rev: 22.00

#ifndef AtcustomdatabaseHPP
#define AtcustomdatabaseHPP

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

//-- user supplied -----------------------------------------------------------

namespace Atcustomdatabase
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TatOpenQueryEvent)(System::UnicodeString ASql, Db::TDataSet* &ADataset);

typedef void __fastcall (__closure *TatReadSqlPropertyEvent)(Db::TDataSet* ADataset, System::UnicodeString &ASQL);

typedef void __fastcall (__closure *TatWriteSqlPropertyEvent)(Db::TDataSet* ADataset, System::UnicodeString ASql);

class DELPHICLASS TatCustomDatabase;
class PASCALIMPLEMENTATION TatCustomDatabase : public Atdatabase::TatDatabase
{
	typedef Atdatabase::TatDatabase inherited;
	
private:
	TatOpenQueryEvent FOnOpenQueryEvent;
	TatReadSqlPropertyEvent FOnReadSqlPropertyEvent;
	TatWriteSqlPropertyEvent FOnWriteSqlPropertyEvent;
	void __fastcall SetOnOpenQueryEvent(const TatOpenQueryEvent Value);
	void __fastcall SetOnReadSqlPropertyEvent(const TatReadSqlPropertyEvent Value);
	void __fastcall SetOnWriteSqlPropertyEvent(const TatWriteSqlPropertyEvent Value);
	
public:
	virtual Db::TDataSet* __fastcall OpenQuery(System::UnicodeString ASql);
	virtual System::UnicodeString __fastcall ReadSqlProperty(Db::TDataSet* ADataset);
	virtual void __fastcall WriteSqlProperty(Db::TDataSet* ADataset, System::UnicodeString ASql);
	
__published:
	__property TatOpenQueryEvent OnOpenQueryEvent = {read=FOnOpenQueryEvent, write=SetOnOpenQueryEvent};
	__property TatReadSqlPropertyEvent OnReadSqlPropertyEvent = {read=FOnReadSqlPropertyEvent, write=SetOnReadSqlPropertyEvent};
	__property TatWriteSqlPropertyEvent OnWriteSqlPropertyEvent = {read=FOnWriteSqlPropertyEvent, write=SetOnWriteSqlPropertyEvent};
public:
	/* TComponent.Create */ inline __fastcall virtual TatCustomDatabase(Classes::TComponent* AOwner) : Atdatabase::TatDatabase(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TatCustomDatabase(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atcustomdatabase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atcustomdatabase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtcustomdatabaseHPP
