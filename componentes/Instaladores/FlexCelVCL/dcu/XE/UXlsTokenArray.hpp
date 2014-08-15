// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UXlsTokenArray.pas' rev: 22.00

#ifndef UxlstokenarrayHPP
#define UxlstokenarrayHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <XlsMessages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlstokenarray
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS ETokenException;
class PASCALIMPLEMENTATION ETokenException : public Xlsmessages::EExcelException
{
	typedef Xlsmessages::EExcelException inherited;
	
public:
	int Token;
	__fastcall ETokenException(const int aToken, const int aDummy1, const int ADummy2);
public:
	/* Exception.CreateFmt */ inline __fastcall ETokenException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Xlsmessages::EExcelException(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ETokenException(int Ident)/* overload */ : Xlsmessages::EExcelException(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall ETokenException(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Xlsmessages::EExcelException(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ETokenException(const System::UnicodeString Msg, int AHelpContext) : Xlsmessages::EExcelException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ETokenException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Xlsmessages::EExcelException(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ETokenException(int Ident, int AHelpContext)/* overload */ : Xlsmessages::EExcelException(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ETokenException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Xlsmessages::EExcelException(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ETokenException(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall UXlsTokenArray_ArrangeInsertRowsAndCols(const Xlsmessages::PArrayOfByte Data, const int atPos, const int afPos, const int InsRowPos, const int InsRowOffset, const int CopyRowOffset, const int InsColPos, const int InsColOffset, const int CopyColOffset, const Xlsmessages::TSheetInfo &SheetInfo, const bool AllowedAbsolute);
extern PACKAGE void __fastcall UXlsTokenArray_ArrangeInsertSheets(const Xlsmessages::PArrayOfByte Data, const int atPos, const int afPos, const Xlsmessages::TSheetInfo &SheetInfo);
extern PACKAGE void __fastcall UXlsTokenArray_ArrangeSharedFormulas(const Xlsmessages::PArrayOfByte Data, const int atPos, const int afPos, const int SharedRow, const int SharedCol);

}	/* namespace Uxlstokenarray */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uxlstokenarray;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlstokenarrayHPP
