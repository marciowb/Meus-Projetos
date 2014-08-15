// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Xlsformulamessages.pas' rev: 11.00

#ifndef XlsformulamessagesHPP
#define XlsformulamessagesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Xlsformulamessages
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TFmReturnType { fmValue, fmRef, fmArray };
#pragma option pop

#pragma pack(push,4)
struct TCellFunctionData
{
	
public:
	int Index;
	WideString Name;
	int MinArgCount;
	int MaxArgCount;
	bool Volatile;
	TFmReturnType ReturnType;
	WideString ParamType;
} ;
#pragma pack(pop)

typedef TCellFunctionData XlsFormulaMessages__1[368];

//-- var, const, procedure ---------------------------------------------------
static const Shortint fmiErrNull = 0x0;
static const Shortint fmiErrDiv0 = 0x7;
static const Shortint fmiErrValue = 0xf;
static const Shortint fmiErrRef = 0x17;
static const Shortint fmiErrName = 0x1d;
static const Shortint fmiErrNum = 0x24;
static const Shortint fmiErrNA = 0x2a;
extern PACKAGE System::ResourceString _fmErrNull;
#define Xlsformulamessages_fmErrNull System::LoadResourceString(&Xlsformulamessages::_fmErrNull)
extern PACKAGE System::ResourceString _fmErrDiv0;
#define Xlsformulamessages_fmErrDiv0 System::LoadResourceString(&Xlsformulamessages::_fmErrDiv0)
extern PACKAGE System::ResourceString _fmErrValue;
#define Xlsformulamessages_fmErrValue System::LoadResourceString(&Xlsformulamessages::_fmErrValue)
extern PACKAGE System::ResourceString _fmErrRef;
#define Xlsformulamessages_fmErrRef System::LoadResourceString(&Xlsformulamessages::_fmErrRef)
extern PACKAGE System::ResourceString _fmErrName;
#define Xlsformulamessages_fmErrName System::LoadResourceString(&Xlsformulamessages::_fmErrName)
extern PACKAGE System::ResourceString _fmErrNum;
#define Xlsformulamessages_fmErrNum System::LoadResourceString(&Xlsformulamessages::_fmErrNum)
extern PACKAGE System::ResourceString _fmErrNA;
#define Xlsformulamessages_fmErrNA System::LoadResourceString(&Xlsformulamessages::_fmErrNA)
extern PACKAGE System::ResourceString _fmErrUnknown;
#define Xlsformulamessages_fmErrUnknown System::LoadResourceString(&Xlsformulamessages::_fmErrUnknown)
extern PACKAGE System::ResourceString _fmErrStart;
#define Xlsformulamessages_fmErrStart System::LoadResourceString(&Xlsformulamessages::_fmErrStart)
extern PACKAGE System::ResourceString _fmTrue;
#define Xlsformulamessages_fmTrue System::LoadResourceString(&Xlsformulamessages::_fmTrue)
extern PACKAGE System::ResourceString _fmFalse;
#define Xlsformulamessages_fmFalse System::LoadResourceString(&Xlsformulamessages::_fmFalse)
extern PACKAGE System::ResourceString _fmStartFormula;
#define Xlsformulamessages_fmStartFormula System::LoadResourceString(&Xlsformulamessages::_fmStartFormula)
extern PACKAGE System::ResourceString _fmFormulaDecimal;
#define Xlsformulamessages_fmFormulaDecimal System::LoadResourceString(&Xlsformulamessages::_fmFormulaDecimal)
extern PACKAGE System::ResourceString _fmFormulaThousands;
#define Xlsformulamessages_fmFormulaThousands System::LoadResourceString(&Xlsformulamessages::_fmFormulaThousands)
extern PACKAGE System::ResourceString _fmFunctionSep;
#define Xlsformulamessages_fmFunctionSep System::LoadResourceString(&Xlsformulamessages::_fmFunctionSep)
extern PACKAGE System::ResourceString _fmUnion;
#define Xlsformulamessages_fmUnion System::LoadResourceString(&Xlsformulamessages::_fmUnion)
extern PACKAGE System::ResourceString _fmIntersect;
#define Xlsformulamessages_fmIntersect System::LoadResourceString(&Xlsformulamessages::_fmIntersect)
extern PACKAGE System::ResourceString _fmSingleQuote;
#define Xlsformulamessages_fmSingleQuote System::LoadResourceString(&Xlsformulamessages::_fmSingleQuote)
extern PACKAGE System::ResourceString _fmOpenArray;
#define Xlsformulamessages_fmOpenArray System::LoadResourceString(&Xlsformulamessages::_fmOpenArray)
extern PACKAGE System::ResourceString _fmCloseArray;
#define Xlsformulamessages_fmCloseArray System::LoadResourceString(&Xlsformulamessages::_fmCloseArray)
extern PACKAGE System::ResourceString _fmOpenParen;
#define Xlsformulamessages_fmOpenParen System::LoadResourceString(&Xlsformulamessages::_fmOpenParen)
extern PACKAGE System::ResourceString _fmCloseParen;
#define Xlsformulamessages_fmCloseParen System::LoadResourceString(&Xlsformulamessages::_fmCloseParen)
extern PACKAGE System::ResourceString _fmArrayRowSep;
#define Xlsformulamessages_fmArrayRowSep System::LoadResourceString(&Xlsformulamessages::_fmArrayRowSep)
extern PACKAGE System::ResourceString _fmArrayColSep;
#define Xlsformulamessages_fmArrayColSep System::LoadResourceString(&Xlsformulamessages::_fmArrayColSep)
extern PACKAGE System::ResourceString _fmAbsoluteRef;
#define Xlsformulamessages_fmAbsoluteRef System::LoadResourceString(&Xlsformulamessages::_fmAbsoluteRef)
extern PACKAGE System::ResourceString _fmRangeSep;
#define Xlsformulamessages_fmRangeSep System::LoadResourceString(&Xlsformulamessages::_fmRangeSep)
extern PACKAGE System::ResourceString _fmExternalRef;
#define Xlsformulamessages_fmExternalRef System::LoadResourceString(&Xlsformulamessages::_fmExternalRef)
extern PACKAGE System::ResourceString _fmWorkbookOpen;
#define Xlsformulamessages_fmWorkbookOpen System::LoadResourceString(&Xlsformulamessages::_fmWorkbookOpen)
extern PACKAGE System::ResourceString _fmWorkbookClose;
#define Xlsformulamessages_fmWorkbookClose System::LoadResourceString(&Xlsformulamessages::_fmWorkbookClose)
extern PACKAGE System::ResourceString _fmTableText;
#define Xlsformulamessages_fmTableText System::LoadResourceString(&Xlsformulamessages::_fmTableText)
extern PACKAGE System::ResourceString _fmPlus;
#define Xlsformulamessages_fmPlus System::LoadResourceString(&Xlsformulamessages::_fmPlus)
extern PACKAGE System::ResourceString _fmMinus;
#define Xlsformulamessages_fmMinus System::LoadResourceString(&Xlsformulamessages::_fmMinus)
extern PACKAGE System::ResourceString _fmMul;
#define Xlsformulamessages_fmMul System::LoadResourceString(&Xlsformulamessages::_fmMul)
extern PACKAGE System::ResourceString _fmDiv;
#define Xlsformulamessages_fmDiv System::LoadResourceString(&Xlsformulamessages::_fmDiv)
extern PACKAGE System::ResourceString _fmPower;
#define Xlsformulamessages_fmPower System::LoadResourceString(&Xlsformulamessages::_fmPower)
extern PACKAGE System::ResourceString _fmPercent;
#define Xlsformulamessages_fmPercent System::LoadResourceString(&Xlsformulamessages::_fmPercent)
extern PACKAGE System::ResourceString _fmStr;
#define Xlsformulamessages_fmStr System::LoadResourceString(&Xlsformulamessages::_fmStr)
extern PACKAGE System::ResourceString _fmAnd;
#define Xlsformulamessages_fmAnd System::LoadResourceString(&Xlsformulamessages::_fmAnd)
extern PACKAGE System::ResourceString _fmLT;
#define Xlsformulamessages_fmLT System::LoadResourceString(&Xlsformulamessages::_fmLT)
extern PACKAGE System::ResourceString _fmLE;
#define Xlsformulamessages_fmLE System::LoadResourceString(&Xlsformulamessages::_fmLE)
extern PACKAGE System::ResourceString _fmEQ;
#define Xlsformulamessages_fmEQ System::LoadResourceString(&Xlsformulamessages::_fmEQ)
extern PACKAGE System::ResourceString _fmGE;
#define Xlsformulamessages_fmGE System::LoadResourceString(&Xlsformulamessages::_fmGE)
extern PACKAGE System::ResourceString _fmGT;
#define Xlsformulamessages_fmGT System::LoadResourceString(&Xlsformulamessages::_fmGT)
extern PACKAGE System::ResourceString _fmNE;
#define Xlsformulamessages_fmNE System::LoadResourceString(&Xlsformulamessages::_fmNE)
static const Shortint attr_bitFSpace = 0x0;
static const Shortint attr_bitFEnter = 0x1;
static const Shortint attr_bitFPreSpace = 0x2;
static const Shortint attr_bitFPreEnter = 0x3;
static const Shortint attr_bitFPostSpace = 0x4;
static const Shortint attr_bitFPostEnter = 0x5;
static const Shortint attr_bitFPreFmlaSpace = 0x6;
extern PACKAGE TCellFunctionData FuncNameArray[368];
static const Shortint ptgExp = 0x1;
static const Shortint ptgTbl = 0x2;
static const Shortint ptgAdd = 0x3;
static const Shortint ptgSub = 0x4;
static const Shortint ptgMul = 0x5;
static const Shortint ptgDiv = 0x6;
static const Shortint ptgPower = 0x7;
static const Shortint ptgConcat = 0x8;
static const Shortint ptgLT = 0x9;
static const Shortint ptgLE = 0xa;
static const Shortint ptgEQ = 0xb;
static const Shortint ptgGE = 0xc;
static const Shortint ptgGT = 0xd;
static const Shortint ptgNE = 0xe;
static const Shortint ptgIsect = 0xf;
static const Shortint ptgUnion = 0x10;
static const Shortint ptgRange = 0x11;
static const Shortint ptgUplus = 0x12;
static const Shortint ptgUminus = 0x13;
static const Shortint ptgPercent = 0x14;
static const Shortint ptgParen = 0x15;
static const Shortint ptgMissArg = 0x16;
static const Shortint ptgStr = 0x17;
static const Shortint ptgAttr = 0x19;
static const Shortint ptgSheet = 0x1a;
static const Shortint ptgEndSheet = 0x1b;
static const Shortint ptgErr = 0x1c;
static const Shortint ptgBool = 0x1d;
static const Shortint ptgInt = 0x1e;
static const Shortint ptgNum = 0x1f;
static const Shortint ptgArray = 0x20;
static const Shortint ptgFunc = 0x21;
static const Shortint ptgFuncVar = 0x22;
static const Shortint ptgName = 0x23;
static const Shortint ptgRef = 0x24;
static const Shortint ptgArea = 0x25;
static const Shortint ptgMemArea = 0x26;
static const Shortint ptgMemErr = 0x27;
static const Shortint ptgMemNoMem = 0x28;
static const Shortint ptgMemFunc = 0x29;
static const Shortint ptgRefErr = 0x2a;
static const Shortint ptgAreaErr = 0x2b;
static const Shortint ptgRefN = 0x2c;
static const Shortint ptgAreaN = 0x2d;
static const Shortint ptgMemAreaN = 0x2e;
static const Shortint ptgMemNoMemN = 0x2f;
static const Shortint ptgNameX = 0x39;
static const Shortint ptgRef3d = 0x3a;
static const Shortint ptgArea3d = 0x3b;
static const Shortint ptgRefErr3d = 0x3c;
static const Shortint ptgAreaErr3d = 0x3d;
extern PACKAGE AnsiString __fastcall FmFloatToStr(const Extended Value);
extern PACKAGE Extended __fastcall FmStrToFloat(const AnsiString Value);

}	/* namespace Xlsformulamessages */
using namespace Xlsformulamessages;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Xlsformulamessages
