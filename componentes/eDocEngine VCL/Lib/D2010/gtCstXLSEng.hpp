// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtcstxlseng.pas' rev: 21.00

#ifndef GtcstxlsengHPP
#define GtcstxlsengHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtcstspdeng.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdocutils.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtcstxlseng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtCustomExcelEngine;
typedef void __fastcall (__closure *TgtOnNeedSheetName)(TgtCustomExcelEngine* Sender, System::UnicodeString &SheetName, int SheetNo);

struct TgtSheetItem;
typedef TgtSheetItem *PgtSheetItem;

struct TgtSheetItem
{
	
public:
	System::UnicodeString FSheetName;
	__int64 FSheetOffset;
};


class DELPHICLASS TgtExcelOLEStream;
class PASCALIMPLEMENTATION TgtExcelOLEStream : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FBATCount;
	int FBATBlockCount;
	int FFirstBlockIndex;
	int FXBatCount;
	int FFirstXBatIndex;
	int FExcelStreamSize;
	void __fastcall CalculateBATBlocks(void);
	void __fastcall WriteHeader(void);
	void __fastcall WriteBlocks(void);
	void __fastcall WritePropertyBlock(void);
	
public:
	Classes::TMemoryStream* FStream;
	Classes::TStream* FExcelStream;
	__fastcall TgtExcelOLEStream(void);
	__fastcall virtual ~TgtExcelOLEStream(void);
	void __fastcall MakeExcelStream(void);
};


#pragma option push -b-
enum TgtCellBorderStyle { cbsNone, cbsThin, cbsMedium, cbsDashed, cbsDotted, cbsThick, cbsDouble, cbsHair };
#pragma option pop

class DELPHICLASS TgtCellBorder;
class PASCALIMPLEMENTATION TgtCellBorder : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FEnabled;
	TgtCellBorderStyle FStyle;
	Graphics::TColor FColor;
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetStyle(const TgtCellBorderStyle Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	
public:
	__fastcall TgtCellBorder(void);
	__fastcall virtual ~TgtCellBorder(void);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property TgtCellBorderStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=0};
};


typedef int TgtWorksheetPagesType;

class DELPHICLASS TgtExcelPreferences;
class PASCALIMPLEMENTATION TgtExcelPreferences : public Gtcstspdeng::TgtSpreadSheetPreferences
{
	typedef Gtcstspdeng::TgtSpreadSheetPreferences inherited;
	
private:
	bool FPrintGridLines;
	TgtWorksheetPagesType FPagesPerWorksheet;
	bool FPageMargins;
	bool FMetafileAsImage;
	void __fastcall SetPagesPerWorksheet(const TgtWorksheetPagesType Value);
	void __fastcall SetPageMargins(const bool Value);
	void __fastcall SetPrintGridLines(const bool Value);
	void __fastcall SetMetafileAsImage(const bool Value);
	
public:
	__fastcall virtual TgtExcelPreferences(void)/* overload */;
	
__published:
	__property TgtWorksheetPagesType PagesPerWorksheet = {read=FPagesPerWorksheet, write=SetPagesPerWorksheet, default=0};
	__property bool PrintGridLines = {read=FPrintGridLines, write=SetPrintGridLines, default=0};
	__property bool PageMargins = {read=FPageMargins, write=SetPageMargins, default=0};
	__property bool MetafileAsImage = {read=FMetafileAsImage, write=SetMetafileAsImage, default=0};
public:
	/* TgtPreferences.Destroy */ inline __fastcall virtual ~TgtExcelPreferences(void) { }
	
};


class PASCALIMPLEMENTATION TgtCustomExcelEngine : public Gtcstspdeng::TgtCustomSpreadSheetEngine
{
	typedef Gtcstspdeng::TgtCustomSpreadSheetEngine inherited;
	
private:
	Classes::TMemoryStream* FExcelStream;
	Classes::TStream* FOutputStream;
	__int64 FSheetNamesSize;
	int FSheetCount;
	Classes::TList* FSpreadSheetItemList;
	TgtOnNeedSheetName FOnNeedSheetName;
	TgtCellBorder* FCellBorder;
	void __fastcall WriteWorkBookHeader(Classes::TStream* AStream);
	HIDESBASE TgtExcelPreferences* __fastcall GetPreferences(void);
	HIDESBASE void __fastcall SetPreferences(const TgtExcelPreferences* Value);
	void __fastcall SetCellBorder(const TgtCellBorder* Value);
	
protected:
	virtual void __fastcall Start(void);
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall Finish(void);
	void __fastcall EndSheet(int SheetNo);
	virtual void __fastcall EncodeText(Gtcstdoceng::TgtTextItem* AObject);
	System::Byte __fastcall GetFillStyle(System::Byte AValue);
	virtual void __fastcall WriteBackgroundImage(void);
	__property Classes::TMemoryStream* ExcelStream = {read=FExcelStream, write=FExcelStream};
	virtual Gtcstdoceng::TgtPreferencesClass __fastcall GetPreferencesClassName(void);
	virtual System::Word __fastcall ShowSetupModal(void);
	
public:
	__fastcall virtual TgtCustomExcelEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtCustomExcelEngine(void);
	virtual void __fastcall BeginDoc(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall TextBox(const Gtutils::TgtRect &TextRect, System::WideString Text, Gtcstdoceng::TgtHAlignment HAlignment, Gtcstdoceng::TgtVAlignment VAlignment);
	virtual void __fastcall SetColumnWidth(int ColumnNumber, double Width);
	virtual void __fastcall NewSheet(bool AAddNewPage = true);
	__property TableSettings;
	__property Frame;
	
__published:
	__property BackgroundImage;
	__property BackgroundColor = {default=16777215};
	__property Pen;
	__property Brush;
	__property TgtExcelPreferences* Preferences = {read=GetPreferences, write=SetPreferences};
	__property TgtOnNeedSheetName OnNeedSheetName = {read=FOnNeedSheetName, write=FOnNeedSheetName};
	__property TgtCellBorder* CellBorder = {read=FCellBorder, write=SetCellBorder};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtcstxlseng */
using namespace Gtcstxlseng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtcstxlsengHPP
