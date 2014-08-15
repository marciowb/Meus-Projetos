// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsencodeformula.pas' rev: 10.00

#ifndef UxlsencodeformulaHPP
#define UxlsencodeformulaHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Xlsformulamessages.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uxlsformulaparser.hpp>	// Pascal unit
#include <Uflxstack.hpp>	// Pascal unit
#include <Uxlsstrings.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Uxlsbaserecordlists.hpp>	// Pascal unit
#include <Uxlsrowcolentries.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsencodeformula
{
//-- type declarations -------------------------------------------------------
typedef DynamicArray<Byte >  UXlsEncodeFormula__2;

typedef DynamicArray<Byte >  UXlsEncodeFormula__3;

class DELPHICLASS TParseString;
class PASCALIMPLEMENTATION TParseString : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	int ParsePos;
	WideString Fw;
	DynamicArray<Byte >  FParsedData;
	DynamicArray<Byte >  FParsedArrayData;
	int MaxErrorLen;
	WideString DirectlyInFormula;
	int LastRefOp;
	Uxlsrowcolentries::TCellList* FCellList;
	Uflxstack::TWhiteSpaceStack* StackWs;
	WideString Default3DExternSheet;
	bool Force3d;
	Xlsformulamessages::TFmReturnType InitialRefMode;
	bool __fastcall IsNumber(const WideChar c);
	bool __fastcall IsAlpha(const WideChar c);
	bool __fastcall IsAZ(const WideChar c);
	int __fastcall ATo1(const WideChar c);
	bool __fastcall NextChar(void);
	bool __fastcall PeekChar(/* out */ WideChar &c);
	bool __fastcall Peek2Char(/* out */ WideChar &c);
	bool __fastcall PeekCharWs(/* out */ WideChar &c);
	void __fastcall GetNumber(void);
	void __fastcall GetString(void);
	void __fastcall GetAlpha(void);
	void __fastcall GetArray(void);
	void __fastcall GetFormulaArgs(const int Index, /* out */ int &ArgCount);
	void __fastcall GetFormula(const WideString s);
	bool __fastcall GetBool(const WideString s);
	bool __fastcall IsErrorCode(const WideString s, /* out */ Byte &b);
	void __fastcall GetError(void);
	void __fastcall GetOneReference(/* out */ bool &RowAbs, /* out */ bool &ColAbs, /* out */ int &Row, /* out */ int &Col, /* out */ bool &IsFullRowRange, /* out */ bool &IsFullColRange);
	bool __fastcall GetReference(const bool OnlyPeek);
	void __fastcall Factor(void);
	void __fastcall RefTerm(void);
	void __fastcall NegTerm(void);
	void __fastcall PerTerm(void);
	void __fastcall ExpTerm(void);
	void __fastcall MulTerm(void);
	void __fastcall AddTerm(void);
	void __fastcall AndTerm(void);
	void __fastcall ComTerm(void);
	void __fastcall Expression(void);
	void __fastcall SkipWhiteSpace(void);
	void __fastcall UndoSkipWhiteSpace(const int SaveParsePos);
	void __fastcall PopWhiteSpace(void);
	void __fastcall AddParsed(Byte const * s, const int s_Size, const bool PopWs = true);
	void __fastcall AddParsedArray(Byte const * s, const int s_Size);
	bool __fastcall FindComTerm(Byte &Ptg);
	void __fastcall GetGeneric3dRef(const WideString ExternSheet);
	void __fastcall GetQuotedRef3d(void);
	void __fastcall GetRef3d(const WideString s);
	Word __fastcall GetExternSheet(const WideString ExternSheet);
	void __fastcall ConvertLastRefValueType(const Xlsformulamessages::TFmReturnType RefMode);
	Byte __fastcall GetLastRefOp(void);
	/*         class method */ static Xlsformulamessages::TFmReturnType __fastcall GetPtgMode(TMetaClass* vmt, const Byte aptg);
	void __fastcall SetLastRefOp(const Byte aptg, const Xlsformulamessages::TFmReturnType RefMode);
	void __fastcall ConvertLastRefValueTypeOnce(const Xlsformulamessages::TFmReturnType RefMode, bool &First);
	bool __fastcall IsDirectlyInFormula(void);
	void __fastcall DiscardNormalWhiteSpace(void);
	void __fastcall MakeLastWhitespaceNormal(void);
	bool __fastcall GetSecondAreaPart(const WideString ExternSheet, const bool OnlyPeek, int Row1, int Col1, const bool RowAbs1, const bool ColAbs1, const bool IsFullRowRange1, const bool IsFullColRange1);
	void __fastcall DoExternNamedRange(const WideString ExternSheet);
	void __fastcall AddParsedArea(const int Rw1, const int Rw2, const int grBit1, const int grBit2);
	void __fastcall AddParsed3dArea(const WideString ExternSheet, const int Rw1, const int Rw2, const int grBit1, const int grBit2);
	void __fastcall AddParsed3dRef(const WideString ExternSheet, const int Rw1, const int grBit1);
	void __fastcall AddParsedRef(const int Rw1, const int grBit1);
	void __fastcall AddParsedExternName(const WideString ExternSheet, const WideString ExternName);
	
public:
	__fastcall TParseString(const WideString aw, const Uxlsrowcolentries::TCellList* aCellList, const Xlsformulamessages::TFmReturnType ReturnType);
	__fastcall TParseString(const WideString aw, const Uxlsrowcolentries::TCellList* aCellList, const bool aForce3D, const WideString aDefault3DExternSheet, const Xlsformulamessages::TFmReturnType ReturnType);
	__fastcall virtual ~TParseString(void);
	void __fastcall Parse(void);
	int __fastcall TotalSize(void);
	void __fastcall CopyToPtr(const Xlsmessages::PArrayOfByte Ptr, const int aPos);
	void __fastcall CopyToPtrNoLen(const Xlsmessages::PArrayOfByte Ptr, const int destIndex);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsencodeformula */
using namespace Uxlsencodeformula;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlsencodeformula
