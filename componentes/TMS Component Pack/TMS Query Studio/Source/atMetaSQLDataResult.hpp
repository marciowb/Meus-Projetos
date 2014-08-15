// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atMetaSQLDataResult.pas' rev: 22.00

#ifndef AtmetasqldataresultHPP
#define AtmetasqldataresultHPP

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
#include <atMetaSQLAbstractEditor.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <DBGrids.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atmetasqldataresult
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmMetaSQLDataResult;
class PASCALIMPLEMENTATION TfmMetaSQLDataResult : public Atmetasqlabstracteditor::TfmMetaSQLAbstractEditor
{
	typedef Atmetasqlabstracteditor::TfmMetaSQLAbstractEditor inherited;
	
__published:
	Dbtables::TQuery* Query1;
	Db::TDataSource* DataSource1;
	Dbgrids::TDBGrid* DBGrid1;
	
public:
	virtual void __fastcall ActivateEditor(void);
public:
	/* TCustomFrame.Create */ inline __fastcall virtual TfmMetaSQLDataResult(Classes::TComponent* AOwner) : Atmetasqlabstracteditor::TfmMetaSQLAbstractEditor(AOwner) { }
	
public:
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TfmMetaSQLDataResult(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmMetaSQLDataResult(HWND ParentWindow) : Atmetasqlabstracteditor::TfmMetaSQLAbstractEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atmetasqldataresult */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atmetasqldataresult;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtmetasqldataresultHPP
