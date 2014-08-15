// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atParser.pas' rev: 22.00

#ifndef AtparserHPP
#define AtparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atparser
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSyntaxResult { srNotDefined, srCorrect, srIncomplete, srOverFlow, srIncorrect };
#pragma option pop

class DELPHICLASS EParserError;
class PASCALIMPLEMENTATION EParserError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EParserError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EParserError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EParserError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EParserError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EParserError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EParserError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EParserError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EParserError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EParserError(void) { }
	
};


struct DECLSPEC_DRECORD TParsingResults
{
	
public:
	TSyntaxResult Result;
	System::WideChar Suggestion;
	int InputPos;
	int SyntaxPos;
	int NoTerminalIndex;
	int MaxInputPos;
	TSyntaxResult LastResult;
};


class DELPHICLASS TNoTerminalNode;
typedef void __fastcall (__closure *TNodeScanProc)(TNoTerminalNode* Node);

typedef System::UnicodeString __fastcall (__closure *TNodeStringChangeProc)(TNoTerminalNode* Node);

typedef bool __fastcall (__closure *TAcceptNodeProc)(TNoTerminalNode* Node);

typedef bool __fastcall (__closure *TAcceptCharProc)(TNoTerminalNode* Node, int ACurrentPos);

class DELPHICLASS TatSyntaxParser;
typedef void __fastcall (__closure *TExtractRemarkEvent)(TatSyntaxParser* AParser, int AStartPos, int AFinalPos);

typedef void __fastcall (__closure *TNodeNotifyEvent)(TNoTerminalNode* Node);

class DELPHICLASS TInclude;
typedef void __fastcall (__closure *TRefuseInputEvent)(TInclude* AInclude, int AInputPos);

typedef void __fastcall (__closure *TIncludeInputEvent)(const TatSyntaxParser* AParser, const System::UnicodeString AName, System::UnicodeString &AInputBuffer, System::TObject* &AInfoObject);

class DELPHICLASS TNoTerminal;
class DELPHICLASS TNoTerminals;
class PASCALIMPLEMENTATION TNoTerminal : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FIdS;
	System::UnicodeString FSyntax;
	System::UnicodeString FSyntaxText;
	TNodeScanProc FOnBeforeNodeScan;
	TNodeScanProc FOnAfterNodeScan;
	TAcceptNodeProc FOnAcceptNode;
	TAcceptCharProc FOnAcceptCharacter;
	TNodeStringChangeProc FOnNodeStringChange;
	bool FReverseScanning;
	TNoTerminals* __fastcall GetNoTerminals(void);
	
public:
	void __fastcall AssignNodeScanningEvents(TNodeScanProc AOnBeforeNodeScan, TNodeScanProc AOnAfterNodeScan);
	__property System::UnicodeString IdS = {read=FIdS, write=FIdS};
	__property System::UnicodeString Syntax = {read=FSyntax, write=FSyntax};
	__property System::UnicodeString SyntaxText = {read=FSyntaxText, write=FSyntaxText};
	__property TNodeScanProc OnBeforeNodeScan = {read=FOnBeforeNodeScan, write=FOnBeforeNodeScan};
	__property TNodeScanProc OnAfterNodeScan = {read=FOnAfterNodeScan, write=FOnAfterNodeScan};
	__property bool ReverseScanning = {read=FReverseScanning, write=FReverseScanning, nodefault};
	__property TAcceptNodeProc OnAcceptNode = {read=FOnAcceptNode, write=FOnAcceptNode};
	__property TAcceptCharProc OnAcceptCharacter = {read=FOnAcceptCharacter, write=FOnAcceptCharacter};
	__property TNodeStringChangeProc OnNodeStringChange = {read=FOnNodeStringChange, write=FOnNodeStringChange};
	__property TNoTerminals* NoTerminals = {read=GetNoTerminals};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TNoTerminal(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TNoTerminal(void) { }
	
};


class PASCALIMPLEMENTATION TNoTerminals : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TNoTerminal* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TNoTerminal* __fastcall GetItem(int Index);
	
public:
	__fastcall TNoTerminals(void);
	HIDESBASE TNoTerminal* __fastcall Add(System::UnicodeString AIdS, System::UnicodeString ASyntax);
	HIDESBASE void __fastcall Delete(int i);
	int __fastcall IndexOf(System::UnicodeString IdS);
	void __fastcall LoadFromStrings(Classes::TStrings* List);
	__property TNoTerminal* Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TNoTerminals(void) { }
	
};


class DELPHICLASS TNoTerminalNodes;
class PASCALIMPLEMENTATION TNoTerminalNode : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
public:
	TNoTerminalNode* operator[](int i) { return Items[i]; }
	
private:
	int FNoTerminalIndex;
	int FInputInitialPos;
	int FInputFinalPos;
	TNoTerminalNodes* FNodes;
	TatSyntaxParser* FatSyntaxParser;
	TInclude* FInclude;
	System::UnicodeString __fastcall GetInputToken(void);
	TNoTerminalNodes* __fastcall GetOwnerNodes(void);
	TNoTerminal* __fastcall GetNoTerminal(void);
	TNoTerminalNode* __fastcall GetParentNode(void);
	System::WideChar __fastcall GetInputChar(int i);
	int __fastcall GetFinalPos(void);
	int __fastcall GetInitialPos(void);
	int __fastcall GetTokenLength(void);
	void __fastcall SetFinalPos(const int Value);
	void __fastcall SetInitialPos(const int Value);
	void __fastcall SetTokenLength(const int Value);
	TNoTerminalNode* __fastcall GetItem(int i);
	void __fastcall MoveByOffset(int delta);
	void __fastcall SetInputFinalPos(const int Value);
	void __fastcall SetInputInitialPos(const int Value);
	System::UnicodeString __fastcall GetStrToken(void);
	
public:
	__fastcall virtual TNoTerminalNode(Classes::TCollection* ACollection);
	__fastcall virtual ~TNoTerminalNode(void);
	void __fastcall ChangeNodeString(System::UnicodeString s);
	__property TNoTerminalNodes* OwnerNodes = {read=GetOwnerNodes};
	__property TNoTerminalNode* ParentNode = {read=GetParentNode};
	__property int NoTerminalIndex = {read=FNoTerminalIndex, write=FNoTerminalIndex, nodefault};
	__property int InputInitialPos = {read=FInputInitialPos, write=SetInputInitialPos, nodefault};
	__property int InputFinalPos = {read=FInputFinalPos, write=SetInputFinalPos, nodefault};
	__property TNoTerminalNodes* Nodes = {read=FNodes, write=FNodes};
	__property System::UnicodeString InputToken = {read=GetInputToken};
	__property System::UnicodeString StrToken = {read=GetStrToken};
	__property TatSyntaxParser* atSyntaxParser = {read=FatSyntaxParser};
	__property TNoTerminal* NoTerminal = {read=GetNoTerminal};
	__property System::WideChar InputChar[int i] = {read=GetInputChar};
	__property int InitialPos = {read=GetInitialPos, write=SetInitialPos, nodefault};
	__property int FinalPos = {read=GetFinalPos, write=SetFinalPos, nodefault};
	__property int TokenLenght = {read=GetTokenLength, write=SetTokenLength, nodefault};
	__property TNoTerminalNode* Items[int i] = {read=GetItem/*, default*/};
	__property TInclude* Include = {read=FInclude};
};


class PASCALIMPLEMENTATION TNoTerminalNodes : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TNoTerminalNode* operator[](int i) { return Items[i]; }
	
private:
	TNoTerminalNode* FNode;
	HIDESBASE TNoTerminalNode* __fastcall GetItem(int i);
	
public:
	__fastcall TNoTerminalNodes(TNoTerminalNode* Owner);
	HIDESBASE TNoTerminalNode* __fastcall Add(int NoTermIndex);
	HIDESBASE void __fastcall Delete(int i);
	int __fastcall IndexOf(int NoTerminalIndex);
	TNoTerminalNode* __fastcall FindByNoTerminalName(const System::UnicodeString AName);
	__property TNoTerminalNode* Node = {read=FNode, write=FNode};
	__property TNoTerminalNode* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TNoTerminalNodes(void) { }
	
};


class DELPHICLASS TSyntaxComment;
class PASCALIMPLEMENTATION TSyntaxComment : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FOpenString;
	System::UnicodeString FCloseString;
	System::UnicodeString FPriorDelims;
	
public:
	__property System::UnicodeString OpenString = {read=FOpenString, write=FOpenString};
	__property System::UnicodeString CloseString = {read=FCloseString, write=FCloseString};
	__property System::UnicodeString PriorDelims = {read=FPriorDelims, write=FPriorDelims};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TSyntaxComment(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TSyntaxComment(void) { }
	
};


class DELPHICLASS TSyntaxComments;
class PASCALIMPLEMENTATION TSyntaxComments : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TSyntaxComment* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TSyntaxComment* __fastcall GetItem(int Index);
	
public:
	HIDESBASE TSyntaxComment* __fastcall Add(System::UnicodeString AOpenString, System::UnicodeString ACloseString);
	__property TSyntaxComment* Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Create */ inline __fastcall TSyntaxComments(Classes::TCollectionItemClass ItemClass) : Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TSyntaxComments(void) { }
	
};


class DELPHICLASS TSavedInputs;
class DELPHICLASS TIncludes;
class PASCALIMPLEMENTATION TatSyntaxParser : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	typedef System::StaticArray<System::UnicodeString, 10> _TatSyntaxParser__1;
	
	
private:
	bool FParsing;
	int FBranchCount;
	TNoTerminalNode* FNode;
	TNoTerminals* FNoTerminals;
	System::UnicodeString FSyntax;
	Classes::TStrings* FGrammar;
	System::UnicodeString FInput;
	Classes::TStrings* FStrings;
	int FScanningInputPos;
	bool FDisableBranching;
	System::WideChar FStringDelimitter;
	_TatSyntaxParser__1 FCustomLexemes;
	int FCurrentInputPos;
	int FCurrentMaxInputPos;
	TSyntaxComments* FComments;
	TExtractRemarkEvent FOnExtractRemark;
	TNodeNotifyEvent FOnRefuseNode;
	TRefuseInputEvent FOnRefuseRemarks;
	bool FContinueOnRemarks;
	TIncludeInputEvent FOnIncludeInput;
	TSavedInputs* FSavedInputs;
	TInclude* FCurrentInclude;
	bool FProcessingRemarks;
	TIncludes* FIncludes;
	int FLastRemarkFound;
	TNodeNotifyEvent FOnNewNode;
	Contnrs::TObjectList* FTempNodes;
	void __fastcall SetGrammar(Classes::TStrings* Value);
	void __fastcall SetStrings(Classes::TStrings* Value);
	bool __fastcall ParseInput(TNoTerminalNodes* Nodes, System::UnicodeString Syntax, int InputPosition, bool literal, int CurrentNoTerm, TParsingResults &results);
	void __fastcall GrammarChange(System::TObject* Sender);
	void __fastcall StringsChange(System::TObject* Sender);
	void __fastcall SetDisableBranching(const bool Value);
	void __fastcall SetContinueOnRemarks(const bool Value);
	void __fastcall SetCurrentInputPos(const int Value);
	void __fastcall SetCurrentMaxInputPos(const int Value);
	void __fastcall SetInput(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetCustomLexeme(int i);
	void __fastcall SetCustomLexeme(int i, const System::UnicodeString Value);
	void __fastcall SetOnNewNode(const TNodeNotifyEvent Value);
	
protected:
	void __fastcall ChangePositions(TNoTerminalNode* refnode, int delta, bool ignoresubnodes);
	__property System::UnicodeString Syntax = {read=FSyntax};
	
public:
	__fastcall virtual TatSyntaxParser(Classes::TComponent* AOwner);
	__fastcall virtual ~TatSyntaxParser(void);
	void __fastcall Clear(void);
	TParsingResults __fastcall CheckLanguage(void);
	TParsingResults __fastcall CheckExpression(void);
	void __fastcall BuildSyntaxTreeView(Comctrls::TTreeView* TreeView);
	void __fastcall ScanNode(TNoTerminalNode* ANode);
	bool __fastcall ScanSyntaxTree(void);
	System::UnicodeString __fastcall RebuildFromNodes(void);
	TNoTerminalNode* __fastcall FindNodeByPosition(int p);
	bool __fastcall TestInputString(int APos, System::UnicodeString s, bool ACaseSensitive = false);
	__property int Effort = {read=FBranchCount, nodefault};
	__property TNoTerminals* NoTerminals = {read=FNoTerminals};
	__property TNoTerminalNode* Node = {read=FNode};
	__property Classes::TStrings* Grammar = {read=FGrammar, write=SetGrammar};
	__property Classes::TStrings* Strings = {read=FStrings, write=SetStrings};
	__property int ScanningInputPos = {read=FScanningInputPos, nodefault};
	__property System::UnicodeString Input = {read=FInput, write=SetInput};
	__property bool DisableBranching = {read=FDisableBranching, write=SetDisableBranching, nodefault};
	__property bool Parsing = {read=FParsing, nodefault};
	__property System::UnicodeString CustomLexemes[int i] = {read=GetCustomLexeme, write=SetCustomLexeme};
	void __fastcall IncludeInput(System::UnicodeString AName);
	__property bool ProcessingRemarks = {read=FProcessingRemarks, nodefault};
	__property TSyntaxComments* Comments = {read=FComments};
	__property System::WideChar StringDelimitter = {read=FStringDelimitter, write=FStringDelimitter, nodefault};
	__property bool ContinueOnRemarks = {read=FContinueOnRemarks, write=SetContinueOnRemarks, nodefault};
	__property TExtractRemarkEvent OnExtractRemark = {read=FOnExtractRemark, write=FOnExtractRemark};
	__property TNodeNotifyEvent OnRefuseNode = {read=FOnRefuseNode, write=FOnRefuseNode};
	__property TRefuseInputEvent OnRefuseRemarks = {read=FOnRefuseRemarks, write=FOnRefuseRemarks};
	__property TIncludeInputEvent OnIncludeInput = {read=FOnIncludeInput, write=FOnIncludeInput};
	__property int CurrentInputPos = {read=FCurrentInputPos, write=SetCurrentInputPos, nodefault};
	__property int CurrentMaxInputPos = {read=FCurrentMaxInputPos, write=SetCurrentMaxInputPos, nodefault};
	__property TInclude* CurrentInclude = {read=FCurrentInclude};
	
__published:
	__property TNodeNotifyEvent OnNewNode = {read=FOnNewNode, write=SetOnNewNode};
};


class DELPHICLASS TSavedInput;
class PASCALIMPLEMENTATION TSavedInputs : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TSavedInput* operator[](int i) { return Items[i]; }
	
private:
	TSavedInput* __fastcall GetItems(int i);
	
public:
	HIDESBASE TSavedInput* __fastcall Add(void);
	__property TSavedInput* Items[int i] = {read=GetItems/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TSavedInputs(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TSavedInputs(void) { }
	
};


class PASCALIMPLEMENTATION TSavedInput : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TInclude* FSavedInclude;
	int FSavedInputPosition;
	int FSavedMaxInputPosition;
	System::UnicodeString FSavedInputBuffer;
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TSavedInput(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TSavedInput(void) { }
	
};


class PASCALIMPLEMENTATION TIncludes : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TInclude* operator[](int i) { return Items[i]; }
	
private:
	TInclude* __fastcall GetItems(int i);
	
public:
	HIDESBASE TInclude* __fastcall Add(void);
	__property TInclude* Items[int i] = {read=GetItems/*, default*/};
	int __fastcall IndexOf(System::UnicodeString AName);
	TInclude* __fastcall FindByName(System::UnicodeString AName);
public:
	/* TOwnedCollection.Create */ inline __fastcall TIncludes(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TIncludes(void) { }
	
};


class PASCALIMPLEMENTATION TInclude : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	System::TObject* FInfoObject;
	System::UnicodeString FInputBuffer;
	
public:
	__property System::UnicodeString Name = {read=FName};
	__property System::TObject* InfoObject = {read=FInfoObject};
	__property System::UnicodeString InputBuffer = {read=FInputBuffer};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TInclude(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TInclude(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define AllChars L"\u0000\u0001\u0002\u0003\u0004\u0005\u0006\a\b\t\n\v\f\r\u000e"\
	L"\u000f\u0010\u0011\u0012\u0013\u0014\u0015\u0016\u0017\u0018"\
	L"\u0019\u001a\u001b\u001c\u001d\u001e\u001f !\"#$%&'()*+,-."\
	L"/0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefg"\
	L"hijklmnopqrstuvwxyz{|}~\u007f\u0080????????????????\uee5a\u256f"\
	L"\u4e30\u620d\u8c9d\u7269\u6d0e\u6096\u505c\u773e\u65af\u9808"\
	L"\u865f\u7344\u64ad\u5676\u64f1\u85cf\u9730?\uf775\u5734\u4f6e"\
	L"\u8fd3\u73bf\u65c2\u8872\u6b36\u8db9\u6b39\u8a58\u68f0\u846e"\
	L"\u6475\u8720\u6a09\u8ce5\u6fcb\u930e\u81bc\u7014\u56a6\u9ec0"\
	L"\u861c\u8832\u256d\ue137\ue273\uf8f8"
#define SpecialChars L"\u0000\u0001\u0002\u0003\u0004\u0005\u0006\a\b\t\n\v\f\r\u000e"\
	L"\u000f\u0010\u0011\u0012\u0013\u0014\u0015\u0016\u0017\u0018"\
	L"\u0019\u001a\u001b\u001c\u001d\u001e\u001f"
extern PACKAGE System::UnicodeString __fastcall SubtractChars(System::UnicodeString s, System::UnicodeString chars);
extern PACKAGE void __fastcall GetRowColFromStrings(Classes::TStrings* lines, int position, int &row, int &col);

}	/* namespace Atparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtparserHPP
