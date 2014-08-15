// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlstokenarray.pas' rev: 10.00

#ifndef UxlstokenarrayHPP
#define UxlstokenarrayHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
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
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ETokenException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Xlsmessages::EExcelException(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ETokenException(int Ident)/* overload */ : Xlsmessages::EExcelException(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ETokenException(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Xlsmessages::EExcelException(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ETokenException(const AnsiString Msg, int AHelpContext) : Xlsmessages::EExcelException(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ETokenException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Xlsmessages::EExcelException(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ETokenException(int Ident, int AHelpContext)/* overload */ : Xlsmessages::EExcelException(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ETokenException(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Xlsmessages::EExcelException(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ETokenException(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall UXlsTokenArray_ArrangeInsertRowsAndCols(const Xlsmessages::PArrayOfByte Data, const int atPos, const int afPos, const int InsRowPos, const int InsRowOffset, const int CopyRowOffset, const int InsColPos, const int InsColOffset, const int CopyColOffset, const Xlsmessages::TSheetInfo &SheetInfo, const bool AllowedAbsolute);
extern PACKAGE void __fastcall UXlsTokenArray_ArrangeInsertSheets(const Xlsmessages::PArrayOfByte Data, const int atPos, const int afPos, const Xlsmessages::TSheetInfo &SheetInfo);
extern PACKAGE void __fastcall UXlsTokenArray_ArrangeSharedFormulas(const Xlsmessages::PArrayOfByte Data, const int atPos, const int afPos, const int SharedRow, const int SharedCol);

}	/* namespace Uxlstokenarray */
using namespace Uxlstokenarray;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlstokenarray
