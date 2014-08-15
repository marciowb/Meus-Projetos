// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advmws.pas' rev: 21.00

#ifndef AdvmwsHPP
#define AdvmwsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Advmemo.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advmws
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvHTMLMemoStyler;
class PASCALIMPLEMENTATION TAdvHTMLMemoStyler : public Advmemo::TAdvCustomMemoStyler
{
	typedef Advmemo::TAdvCustomMemoStyler inherited;
	
private:
	System::UnicodeString FVersion;
	
public:
	__fastcall virtual TAdvHTMLMemoStyler(Classes::TComponent* AOwner);
	
__published:
	__property LineComment;
	__property MultiCommentLeft;
	__property MultiCommentRight;
	__property CommentStyle;
	__property NumberStyle;
	__property AllStyles;
	__property System::UnicodeString Version = {read=FVersion};
	__property Description;
	__property Filter;
	__property DefaultExtension;
	__property StylerName;
	__property Extensions;
public:
	/* TAdvCustomMemoStyler.Destroy */ inline __fastcall virtual ~TAdvHTMLMemoStyler(void) { }
	
};


class DELPHICLASS TAdvJSMemoStyler;
class PASCALIMPLEMENTATION TAdvJSMemoStyler : public Advmemo::TAdvCustomMemoStyler
{
	typedef Advmemo::TAdvCustomMemoStyler inherited;
	
private:
	System::UnicodeString FVersion;
	
public:
	__fastcall virtual TAdvJSMemoStyler(Classes::TComponent* AOwner);
	
__published:
	__property BlockStart;
	__property BlockEnd;
	__property LineComment;
	__property MultiCommentLeft;
	__property MultiCommentRight;
	__property CommentStyle;
	__property NumberStyle;
	__property AllStyles;
	__property System::UnicodeString Version = {read=FVersion};
	__property Description;
	__property Filter;
	__property DefaultExtension;
	__property StylerName;
	__property Extensions;
public:
	/* TAdvCustomMemoStyler.Destroy */ inline __fastcall virtual ~TAdvJSMemoStyler(void) { }
	
};


class DELPHICLASS TAdvWebMemoStyler;
class PASCALIMPLEMENTATION TAdvWebMemoStyler : public Advmemo::TAdvCustomMemoStyler
{
	typedef Advmemo::TAdvCustomMemoStyler inherited;
	
private:
	System::UnicodeString FVersion;
	
public:
	__fastcall virtual TAdvWebMemoStyler(Classes::TComponent* AOwner);
	
__published:
	__property LineComment;
	__property MultiCommentLeft;
	__property MultiCommentRight;
	__property CommentStyle;
	__property NumberStyle;
	__property AllStyles;
	__property System::UnicodeString Version = {read=FVersion};
	__property Description;
	__property Filter;
	__property DefaultExtension;
	__property StylerName;
	__property Extensions;
public:
	/* TAdvCustomMemoStyler.Destroy */ inline __fastcall virtual ~TAdvWebMemoStyler(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define AllDelimiters L" ,;:.()[]=-*/^%<>#"
#define AllHTMLKeyWordsDefaults L"\"HEAD\",\"META\",\"BODY\",\"HTML\",\"TITLE\",\"COMMENT\""
#define AllHTMLKeyWordsStandard L"\"A\",\"B\",\"I\",\"U\",\"P\",\"BASE\",\"BLINK\",\"LINK\","\
	L"\"FONT\",\"STRONG\",\"IMG\",\"BASEFONT\",\"BGSOUND\",\"DD\""\
	L",\"DEL\",\"DFN\",\"DIR\",\"DIV\",\"DL\",\"DT\",\"COL\",\"B"\
	L"R\",\"HR\",\"COLGROUP\",\"TABLE\",\"MULTICOL\",\"TBODY\",\""\
	L"TD\",\"TEXTAREA\",\"TFOOT\",\"TH\",\"THEAD\",\"TR\",\"TT\""\
	L",\"CAPTION\",\"CENTER\",\"CITE\",\"CODE\",\"BLOCKQUOTE\",\""\
	L"FORM\",\"FRAME\",\"IFRAME\",\"ILAYER\",\"FRAMESET\",\"BUTT"\
	L"ON\",\"LABEL\",\"LAYER\",\"OPTION\""
#define AllJSKeyWords L"\"SCRIPT\",\"OBJECT\",\"FOR\",\"IF\",\"THEN\",\"THIS\",\"D"\
	L"O\",\"WHILE\",\"BREAK\",\"{\",\"}\",\"(\",\")\",\"SWITCH\""\
	L",\"ELSE\",\"FUNCTION\",\"WINDOW\",\"DOCUMENT\",\";\",\"RET"\
	L"URN\",\"STYLE\",\"VAR\",\"WINDOW\",\"LOCATION\""
#define AllJSFunctions L"\"alert\",\"confirm\",\"prompt\",\"indexOf\",\"select\",\""\
	L"write\",\"focus\""

}	/* namespace Advmws */
using namespace Advmws;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvmwsHPP
