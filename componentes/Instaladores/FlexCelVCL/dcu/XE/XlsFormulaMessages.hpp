// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'XlsFormulaMessages.pas' rev: 22.00

#ifndef XlsformulamessagesHPP
#define XlsformulamessagesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Xlsformulamessages
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TFmReturnType { fmValue, fmRef, fmArray };
#pragma option pop

struct DECLSPEC_DRECORD TCellFunctionData
{
	
public:
	int Index;
	System::UnicodeString Name;
	int MinArgCount;
	int MaxArgCount;
	bool Volatile;
	TFmReturnType ReturnType;
	System::UnicodeString ParamType;
};


typedef System::StaticArray<TCellFunctionData, 368> Xlsformulamessages__1;

//-- var, const, procedure ---------------------------------------------------
static const System::ShortInt fmiErrNull = 0x0;
static const System::ShortInt fmiErrDiv0 = 0x7;
static const System::ShortInt fmiErrValue = 0xf;
static const System::ShortInt fmiErrRef = 0x17;
static const System::ShortInt fmiErrName = 0x1d;
static const System::ShortInt fmiErrNum = 0x24;
static const System::ShortInt fmiErrNA = 0x2a;
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
static const System::ShortInt attr_bitFSpace = 0x0;
static const System::ShortInt attr_bitFEnter = 0x1;
static const System::ShortInt attr_bitFPreSpace = 0x2;
static const System::ShortInt attr_bitFPreEnter = 0x3;
static const System::ShortInt attr_bitFPostSpace = 0x4;
static const System::ShortInt attr_bitFPostEnter = 0x5;
static const System::ShortInt attr_bitFPreFmlaSpace = 0x6;
extern PACKAGE Xlsformulamessages__1 FuncNameArray;
static const System::ShortInt ptgExp = 0x1;
static const System::ShortInt ptgTbl = 0x2;
static const System::ShortInt ptgAdd = 0x3;
static const System::ShortInt ptgSub = 0x4;
static const System::ShortInt ptgMul = 0x5;
static const System::ShortInt ptgDiv = 0x6;
static const System::ShortInt ptgPower = 0x7;
static const System::ShortInt ptgConcat = 0x8;
static const System::ShortInt ptgLT = 0x9;
static const System::ShortInt ptgLE = 0xa;
static const System::ShortInt ptgEQ = 0xb;
static const System::ShortInt ptgGE = 0xc;
static const System::ShortInt ptgGT = 0xd;
static const System::ShortInt ptgNE = 0xe;
static const System::ShortInt ptgIsect = 0xf;
static const System::ShortInt ptgUnion = 0x10;
static const System::ShortInt ptgRange = 0x11;
static const System::ShortInt ptgUplus = 0x12;
static const System::ShortInt ptgUminus = 0x13;
static const System::ShortInt ptgPercent = 0x14;
static const System::ShortInt ptgParen = 0x15;
static const System::ShortInt ptgMissArg = 0x16;
static const System::ShortInt ptgStr = 0x17;
static const System::ShortInt ptgAttr = 0x19;
static const System::ShortInt ptgSheet = 0x1a;
static const System::ShortInt ptgEndSheet = 0x1b;
static const System::ShortInt ptgErr = 0x1c;
static const System::ShortInt ptgBool = 0x1d;
static const System::ShortInt ptgInt = 0x1e;
static const System::ShortInt ptgNum = 0x1f;
static const System::ShortInt ptgArray = 0x20;
static const System::ShortInt ptgFunc = 0x21;
static const System::ShortInt ptgFuncVar = 0x22;
static const System::ShortInt ptgName = 0x23;
static const System::ShortInt ptgRef = 0x24;
static const System::ShortInt ptgArea = 0x25;
static const System::ShortInt ptgMemArea = 0x26;
static const System::ShortInt ptgMemErr = 0x27;
static const System::ShortInt ptgMemNoMem = 0x28;
static const System::ShortInt ptgMemFunc = 0x29;
static const System::ShortInt ptgRefErr = 0x2a;
static const System::ShortInt ptgAreaErr = 0x2b;
static const System::ShortInt ptgRefN = 0x2c;
static const System::ShortInt ptgAreaN = 0x2d;
static const System::ShortInt ptgMemAreaN = 0x2e;
static const System::ShortInt ptgMemNoMemN = 0x2f;
static const System::ShortInt ptgNameX = 0x39;
static const System::ShortInt ptgRef3d = 0x3a;
static const System::ShortInt ptgArea3d = 0x3b;
static const System::ShortInt ptgRefErr3d = 0x3c;
static const System::ShortInt ptgAreaErr3d = 0x3d;
extern PACKAGE System::UnicodeString __fastcall FmFloatToStr(const System::Extended Value);
extern PACKAGE System::Extended __fastcall FmStrToFloat(const System::UnicodeString Value);

}	/* namespace Xlsformulamessages */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Xlsformulamessages;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// XlsformulamessagesHPP