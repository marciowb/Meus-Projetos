// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atSqlParser.pas' rev: 22.00

#ifndef AtsqlparserHPP
#define AtsqlparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <atBaseParser.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atsqlparser
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSqlNoTerminal { ntSql, ntSelect, ntFldlst_slc, ntallfieldsexp, ntFielddef, ntDistinct, ntWhere, ntGroupby, ntUnion, ntOrderby, ntInsert, ntValues, ntUpdate, ntSettings, ntSetting, ntDelete, ntFldlst_grp, ntFldlst_ord, ntFldlst_ins, ntDescending, ntSource, ntListed_src, ntJoined_src, ntLeft_join, ntRight_join, ntInner_join, ntTable, ntTablename, ntTablealias, ntField, ntFieldname, ntFieldalias, ntLogic_expr, ntLogic_expr1, ntNot, ntExists, ntIn, ntRelational, ntRelat_oper, ntExpression, ntArit_oper, ntConcat_oper, ntParam, ntNumber, ntString, ntLogic, ntNull, ntMacro, ntFunction, ntUpper, ntLower, ntYear, ntMonth, ntDay, ntSum, ntMax, ntMin, ntAvg, ntCount, ntCountAllExpr, ntANY, ntUnknownFunc };
#pragma option pop

class DELPHICLASS TatSqlParser;
typedef void __fastcall (__closure *TConvertSqlProc)(TatSqlParser* AMetaSql);

class PASCALIMPLEMENTATION TatSqlParser : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Classes::TPersistent* FOwner;
	Atbaseparser::TatBaseParser* FParser;
	System::UnicodeString FMetaSql;
	int FErrorRow;
	int FErrorCol;
	bool FCorrect;
	System::UnicodeString FResultSql;
	System::UnicodeString FErrorMsg;
	TConvertSqlProc FOnConvertSql;
	void __fastcall SeTatSqlParser(const System::UnicodeString Value);
	bool __fastcall AcceptAliasNode(Atbaseparser::TNoTerminalNode* Node);
	Atbaseparser::TNoTerminalNodes* __fastcall GetNoTerminalNodes(void);
	Atbaseparser::TNoTerminals* __fastcall GetNoTerminals(void);
	void __fastcall SetOnConvertSql(const TConvertSqlProc Value);
	
public:
	__fastcall TatSqlParser(Classes::TPersistent* AOwner);
	__fastcall virtual ~TatSqlParser(void);
	void __fastcall ClearScanProcs(void);
	void __fastcall SetBeforeNoTerminalScanProc(TSqlNoTerminal NoTerm, Atbaseparser::TNodeScanProc AProc);
	void __fastcall SetAfterNoTerminalScanProc(TSqlNoTerminal NoTerm, Atbaseparser::TNodeScanProc AProc);
	void __fastcall ScanNodes(void);
	void __fastcall ParseMetaSQL(void);
	__property bool Correct = {read=FCorrect, write=FCorrect, nodefault};
	__property int ErrorCol = {read=FErrorCol, write=FErrorCol, nodefault};
	__property int ErrorRow = {read=FErrorRow, write=FErrorRow, nodefault};
	__property System::UnicodeString ErrorMsg = {read=FErrorMsg, write=FErrorMsg};
	__property System::UnicodeString MetaSql = {read=FMetaSql, write=SeTatSqlParser};
	__property Atbaseparser::TNoTerminals* NoTerminals = {read=GetNoTerminals};
	__property Atbaseparser::TNoTerminalNodes* Nodes = {read=GetNoTerminalNodes};
	__property System::UnicodeString ResultSql = {read=FResultSql, write=FResultSql};
	__property Atbaseparser::TatBaseParser* Parser = {read=FParser};
	__property TConvertSqlProc OnConvertSql = {read=FOnConvertSql, write=SetOnConvertSql};
};


//-- var, const, procedure ---------------------------------------------------
#define ntOuter_join (System::Set<TSqlNoTerminal, TSqlNoTerminal::ntSql, TSqlNoTerminal::ntUnknownFunc> () << TSqlNoTerminal::ntLeft_join << TSqlNoTerminal::ntRight_join << TSqlNoTerminal::ntInner_join )
#define ValidFieldChars L"0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstu"\
	L"vwxyz?\ueddc\u8b1d\u85e5\u9f6a\uf775\u5734\u4f6e\u8fd3\u73bf"\
	L"\u65c2\u8872\u6b36\u5d37\u7a99\u55f2\u7767\u98ac\u777c\u9ea7"\
	L"\u7dd7\u9d07\u81b9\u64e8\u95c0\u8c98\u89b7\u93f7\u7a71\ue099"\
	L"\ue1d5?"
#define FieldDelimOpenChars L"\"["
#define FieldDelimCloseChars L"\"]"
extern PACKAGE Atbaseparser::TNoTerminalNode* __fastcall NodeCast(Atbaseparser::TNoTerminalNode* ANode, int *i, const int i_Size, TSqlNoTerminal *nt, const int nt_Size);
extern PACKAGE bool __fastcall NodeMatch(Atbaseparser::TNoTerminalNode* ANode, int *i, const int i_Size, TSqlNoTerminal *nt, const int nt_Size);
extern PACKAGE TSqlNoTerminal __fastcall NodeType(Atbaseparser::TNoTerminalNode* ANode);
extern PACKAGE void __fastcall BuildSqlList(System::UnicodeString &list, System::UnicodeString element);
extern PACKAGE void __fastcall BuildSqlExpr(System::UnicodeString &expr, System::UnicodeString cond);
extern PACKAGE Classes::TStringList* __fastcall ExtractInvolvedTables(const System::UnicodeString ASql);

}	/* namespace Atsqlparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atsqlparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtsqlparserHPP
