// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'uDBUtil.pas' rev: 22.00

#ifndef UdbutilHPP
#define UdbutilHPP

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
#include <ExtCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <CheckLst.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <DBGrids.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Udbutil
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool DisablePrettyText;
extern PACKAGE System::UnicodeString __fastcall RemoveNameExt(System::UnicodeString ATableName);
extern PACKAGE System::UnicodeString __fastcall ExtractName(System::UnicodeString AName);
extern PACKAGE System::UnicodeString __fastcall PrettyText(System::UnicodeString s);
extern PACKAGE void __fastcall LoadTableNameList(System::UnicodeString ADBName, Classes::TStrings* lst);
extern PACKAGE void __fastcall PrettyTextList(Classes::TStringList* lst, bool ASort = true);
extern PACKAGE void __fastcall LoadFieldNameList(System::UnicodeString ADBName, System::UnicodeString ATableName, Classes::TStrings* lst);

}	/* namespace Udbutil */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Udbutil;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UdbutilHPP
