// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Alvutil.pas' rev: 21.00

#ifndef AlvutilHPP
#define AlvutilHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Alvutil
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFileStringList;
class PASCALIMPLEMENTATION TFileStringList : public Classes::TStringList
{
	typedef Classes::TStringList inherited;
	
private:
	int fp;
	System::UnicodeString cache;
	bool __fastcall GetEOF(void);
	
public:
	void __fastcall Reset(void);
	void __fastcall ReadLn(System::UnicodeString &s);
	void __fastcall Write(System::UnicodeString s);
	void __fastcall WriteLn(System::UnicodeString s);
	__property bool Eof = {read=GetEOF, nodefault};
public:
	/* TStringList.Create */ inline __fastcall TFileStringList(void)/* overload */ : Classes::TStringList() { }
	/* TStringList.Destroy */ inline __fastcall virtual ~TFileStringList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall StringToOem(System::UnicodeString &s);
extern PACKAGE void __fastcall OemToString(System::UnicodeString &s);
extern PACKAGE System::UnicodeString __fastcall DoubleToSingleChar(System::WideChar ch, const System::UnicodeString s);
extern PACKAGE void __fastcall LineFeedsToCSV(System::UnicodeString &s);
extern PACKAGE void __fastcall CSVToLineFeeds(System::UnicodeString &s);
extern PACKAGE System::UnicodeString __fastcall UpStr(System::UnicodeString s);
extern PACKAGE bool __fastcall Matchstr(System::UnicodeString s1, System::UnicodeString s2);
extern PACKAGE bool __fastcall Matches(System::WideChar * s0a, System::WideChar * s1a);
extern PACKAGE System::UnicodeString __fastcall LfToFile(System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall FileToLf(System::UnicodeString s, bool multiline);
extern PACKAGE System::UnicodeString __fastcall GetNextLine(System::UnicodeString &s, bool multiline);
extern PACKAGE int __fastcall LinesInText(System::UnicodeString s, bool multiline);
extern PACKAGE System::UnicodeString __fastcall RectString(const Types::TRect &r);
extern PACKAGE System::UnicodeString __fastcall FixDecimalSeparator(System::UnicodeString s);
extern PACKAGE System::TDateTime __fastcall GetNextDate(System::TDateTime d, System::Word dye, System::Word dmo, System::Word dda, System::TDateTime dtv);
extern PACKAGE int __fastcall SinglePos(System::WideChar p, System::UnicodeString s);
extern PACKAGE int __fastcall NumSingleChar(System::WideChar p, System::UnicodeString s);
extern PACKAGE void __fastcall DrawProgress(Graphics::TCanvas* Canvas, const Types::TRect &r, Graphics::TColor Color1, Graphics::TColor FontColor1, Graphics::TColor Color2, Graphics::TColor FontColor2, int Pos);

}	/* namespace Alvutil */
using namespace Alvutil;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AlvutilHPP
