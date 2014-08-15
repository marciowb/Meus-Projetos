// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlstokenarray.pas' rev: 21.00

#ifndef TmsuxlstokenarrayHPP
#define TmsuxlstokenarrayHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlstokenarray
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS ETokenException;
class PASCALIMPLEMENTATION ETokenException : public Tmsxlsmessages::EExcelException
{
	typedef Tmsxlsmessages::EExcelException inherited;
	
public:
	int Token;
	__fastcall ETokenException(const int aToken, const int aDummy1, const int ADummy2);
public:
	/* Exception.CreateFmt */ inline __fastcall ETokenException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Tmsxlsmessages::EExcelException(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ETokenException(int Ident)/* overload */ : Tmsxlsmessages::EExcelException(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall ETokenException(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Tmsxlsmessages::EExcelException(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ETokenException(const System::UnicodeString Msg, int AHelpContext) : Tmsxlsmessages::EExcelException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ETokenException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Tmsxlsmessages::EExcelException(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ETokenException(int Ident, int AHelpContext)/* overload */ : Tmsxlsmessages::EExcelException(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ETokenException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Tmsxlsmessages::EExcelException(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ETokenException(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall UXlsTokenArray_ArrangeInsertRowsAndCols(const Tmsxlsmessages::PArrayOfByte Data, const int atPos, const int afPos, const int InsRowPos, const int InsRowOffset, const int CopyRowOffset, const int InsColPos, const int InsColOffset, const int CopyColOffset, const Tmsxlsmessages::TSheetInfo &SheetInfo, const bool AllowedAbsolute);
extern PACKAGE void __fastcall UXlsTokenArray_ArrangeInsertSheets(const Tmsxlsmessages::PArrayOfByte Data, const int atPos, const int afPos, const Tmsxlsmessages::TSheetInfo &SheetInfo);
extern PACKAGE void __fastcall UXlsTokenArray_ArrangeSharedFormulas(const Tmsxlsmessages::PArrayOfByte Data, const int atPos, const int afPos, const int SharedRow, const int SharedCol);

}	/* namespace Tmsuxlstokenarray */
using namespace Tmsuxlstokenarray;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlstokenarrayHPP
