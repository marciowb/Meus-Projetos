// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtcstspdeng.pas' rev: 10.00

#ifndef GtcstspdengHPP
#define GtcstspdengHPP

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
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtcstspdeng
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TgtCellType { ctString, ctInteger, ctDouble, ctCurrency, ctTime, ctDate, ctDateTime, ctInteger_TS, ctDouble_TS, ctPercentage_FP, ctPercentage };
#pragma option pop

struct TgtColumnWidth;
typedef TgtColumnWidth *PgtColumnWidth;

struct TgtColumnWidth
{
	
public:
	int FCoumnNumber;
	double FWidth;
} ;

class DELPHICLASS TgtFmTextItem;
class PASCALIMPLEMENTATION TgtFmTextItem : public Gtcstdoceng::TgtTextItem 
{
	typedef Gtcstdoceng::TgtTextItem inherited;
	
private:
	int FRowNo;
	int FColumnNo;
	
public:
	__property int RowNo = {read=FRowNo, write=FRowNo, nodefault};
	__property int ColumnNo = {read=FColumnNo, write=FColumnNo, nodefault};
public:
	#pragma option push -w-inl
	/* TgtTextItem.Create */ inline __fastcall virtual TgtFmTextItem(void) : Gtcstdoceng::TgtTextItem() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TgtTextItem.Destroy */ inline __fastcall virtual ~TgtFmTextItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TgtSheetTextItem;
class PASCALIMPLEMENTATION TgtSheetTextItem : public TgtFmTextItem 
{
	typedef TgtFmTextItem inherited;
	
private:
	Gtcstdoceng::TgtHAlignment FAlignment;
	TgtCellType FCellType;
	bool FWordWrap;
	
public:
	__property Gtcstdoceng::TgtHAlignment Alignment = {read=FAlignment, write=FAlignment, nodefault};
	__property TgtCellType CellType = {read=FCellType, write=FCellType, nodefault};
	__property bool WordWrap = {read=FWordWrap, write=FWordWrap, nodefault};
public:
	#pragma option push -w-inl
	/* TgtTextItem.Create */ inline __fastcall virtual TgtSheetTextItem(void) : TgtFmTextItem() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TgtTextItem.Destroy */ inline __fastcall virtual ~TgtSheetTextItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TgtCellAttrib;
class PASCALIMPLEMENTATION TgtCellAttrib : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	int FFontIndex;
	Word FFormatIndex;
	Gtcstdoceng::TgtHAlignment FAlignment;
	Graphics::TBrush* FBrush;
	bool FWordWrap;
	
public:
	__fastcall TgtCellAttrib(void);
	__fastcall virtual ~TgtCellAttrib(void);
	__property int FontIndex = {read=FFontIndex, write=FFontIndex, nodefault};
	__property Word FormatIndex = {read=FFormatIndex, write=FFormatIndex, nodefault};
	__property Gtcstdoceng::TgtHAlignment Alignment = {read=FAlignment, write=FAlignment, nodefault};
	__property Graphics::TBrush* Brush = {read=FBrush, write=FBrush};
	__property bool WordWrap = {read=FWordWrap, write=FWordWrap, nodefault};
};


typedef int TgtRowSpacingRange;

typedef short TgtColumnSpacingRange;

class DELPHICLASS TgtSheetFormatting;
class PASCALIMPLEMENTATION TgtSheetFormatting : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TgtRowSpacingRange FRowSpacing;
	TgtColumnSpacingRange FColumnSpacing;
	float FScaleY;
	float FScaleX;
	void __fastcall SetRowSpacing(const TgtRowSpacingRange Value);
	void __fastcall SetColumnSpacing(const TgtColumnSpacingRange Value);
	void __fastcall SetScaleX(const float Value);
	void __fastcall SetScaleY(const float Value);
	
public:
	__fastcall TgtSheetFormatting(void);
	__fastcall virtual ~TgtSheetFormatting(void);
	
__published:
	__property TgtColumnSpacingRange ColumnSpacing = {read=FColumnSpacing, write=SetColumnSpacing, nodefault};
	__property TgtRowSpacingRange RowSpacing = {read=FRowSpacing, write=SetRowSpacing, nodefault};
	__property float ScaleX = {read=FScaleX, write=SetScaleX};
	__property float ScaleY = {read=FScaleY, write=SetScaleY};
};


class DELPHICLASS TgtSpreadSheetPreferences;
class PASCALIMPLEMENTATION TgtSpreadSheetPreferences : public Gtcstdoceng::TgtPreferences 
{
	typedef Gtcstdoceng::TgtPreferences inherited;
	
private:
	bool FAutoFormatCells;
	bool FMultiPass;
	bool FApplyAlignment;
	bool FWordWrap;
	bool FUseDefaultPalette;
	bool FContinuousMode;
	void __fastcall SetAutoFormatCells(const bool Value);
	void __fastcall SetApplyAlignment(const bool Value);
	void __fastcall SetMultiPass(const bool Value);
	void __fastcall SetWordWrap(const bool Value);
	void __fastcall SetUseDefaultPalette(const bool Value);
	void __fastcall SetContinuousMode(const bool Value);
	
__published:
	__property bool AutoFormatCells = {read=FAutoFormatCells, write=SetAutoFormatCells, nodefault};
	__property bool ApplyAlignment = {read=FApplyAlignment, write=SetApplyAlignment, default=0};
	__property bool MultiPass = {read=FMultiPass, write=SetMultiPass, default=0};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
	__property bool UseDefaultPalette = {read=FUseDefaultPalette, write=SetUseDefaultPalette, default=0};
	__property bool ContinuousMode = {read=FContinuousMode, write=SetContinuousMode, default=0};
public:
	#pragma option push -w-inl
	/* TgtPreferences.Create */ inline __fastcall virtual TgtSpreadSheetPreferences(void)/* overload */ : Gtcstdoceng::TgtPreferences() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TgtPreferences.Destroy */ inline __fastcall virtual ~TgtSpreadSheetPreferences(void) { }
	#pragma option pop
	
};


class DELPHICLASS TgtCustomSpreadSheetEngine;
class PASCALIMPLEMENTATION TgtCustomSpreadSheetEngine : public Gtcstdoceng::TgtCustomDocumentEngine 
{
	typedef Gtcstdoceng::TgtCustomDocumentEngine inherited;
	
private:
	TgtSheetFormatting* FFormatting;
	bool FColorFlag;
	void __fastcall SetFormatting(const TgtSheetFormatting* Value);
	HIDESBASE TgtSpreadSheetPreferences* __fastcall GetPreferences(void);
	HIDESBASE void __fastcall SetPreferences(const TgtSpreadSheetPreferences* Value);
	
protected:
	double FXFactor;
	int FDefaultCellHeight;
	int FLastPageHeight;
	int FPrevRowNo;
	Classes::TStringList* FCellXFTable;
	Classes::TStringList* FFontTable;
	Classes::TStringList* FColorTable;
	int FColorArray[101];
	int FColorArraySize;
	int FColorValues;
	Classes::TList* FColWidths;
	virtual void __fastcall SetColumnWidth(int ColumnNumber, double Width);
	virtual void __fastcall Start(void);
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall PutTrialNote(void);
	virtual void __fastcall EncodeText(Gtcstdoceng::TgtTextItem* AObject);
	virtual void __fastcall EncodeTextBox(Gtcstdoceng::TgtTextBoxItem* AObject);
	virtual void __fastcall EncodeParagraph(Gtcstdoceng::TgtParagraphItem* AObject);
	virtual void __fastcall EncodeTable(Gtcstdoceng::TgtTableItem* AObject);
	void __fastcall WriteRecord(int ARecType, int ARecSize, Word * ABuf, const int ABuf_Size, int ADataSize, Classes::TStream* AStream);
	void __fastcall WriteRecordByte(int ARecType, int ARecSize, Byte * ABuf, const int ABuf_Size, int ADataSize, Classes::TStream* AStream);
	int __fastcall AddFontInfoToFontTable(Graphics::TFont* AFont);
	virtual int __fastcall AddColorToColorTable(Graphics::TColor AColor);
	TgtCellType __fastcall GetCellType(AnsiString AText);
	int __fastcall AddCellInfoToCellXFTable(int AFontIndex, Gtcstdoceng::TgtHAlignment ATextAlign, int AFormatIndex, Graphics::TBrush* ABrush, bool AWordWrap = false);
	AnsiString __fastcall GetNumberString(AnsiString AText);
	void __fastcall CreateResourceItems(void);
	void __fastcall FreeResourceItems(void);
	virtual void __fastcall AdjustTextItemList(Classes::TList* AList);
	bool __fastcall IsInRange(double LLeftX, double LRightX, double LCurLeftX, double LCurRightX, double LMaxTextSize, double LMinTextSize);
	virtual TMetaClass* __fastcall GetPreferencesClassName(void);
	virtual void __fastcall NewSheet(bool AAddNewPage = true);
	
public:
	__fastcall virtual TgtCustomSpreadSheetEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtCustomSpreadSheetEngine(void);
	virtual void __fastcall BeginDoc(void);
	virtual void __fastcall EndDoc(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall TextOut(double X, double Y, WideString Text)/* overload */;
	virtual void __fastcall TextRect(const Gtutils::TgtRect &Rect, double X, double Y, WideString Text);
	virtual void __fastcall TextOut(int ColumnNo, WideString Text)/* overload */;
	HIDESBASE virtual void __fastcall TextOut(int Row, int Column, WideString Text, Gtcstdoceng::TgtHAlignment Alignment, TgtCellType CellType)/* overload */;
	HIDESBASE virtual void __fastcall TextOut(int Row, int Column, WideString Text, Gtcstdoceng::TgtHAlignment Alignment, TgtCellType CellType, bool WordWrap)/* overload */;
	virtual double __fastcall TextOut(WideString Text)/* overload */;
	virtual void __fastcall SetTextRotation(int Angle);
	virtual void __fastcall BeginPara(void);
	virtual void __fastcall EndPara(void);
	virtual Classes::TList* __fastcall BeginTable(double X, double Y, int NoColumns);
	virtual double __fastcall NewRow(double Height)/* overload */;
	virtual double __fastcall NewRow(void)/* overload */;
	virtual void __fastcall EndTable(void);
	virtual void __fastcall PlayMetafile(Graphics::TMetafile* Metafile)/* overload */;
	virtual void __fastcall PlayMetafile(double X, double Y, Graphics::TMetafile* Metafile)/* overload */;
	virtual void __fastcall BeginHeader(void);
	virtual void __fastcall EndHeader(void);
	virtual void __fastcall ClearHeader(void);
	virtual void __fastcall BeginFooter(void);
	virtual void __fastcall EndFooter(void);
	virtual void __fastcall ClearFooter(void);
	virtual void __fastcall BeginWaterMark(void);
	virtual void __fastcall EndWaterMark(void);
	virtual void __fastcall ClearWaterMark(void);
	virtual void __fastcall BeginStamp(void);
	virtual void __fastcall EndStamp(void);
	virtual void __fastcall ClearStamp(void);
	virtual int __fastcall SaveEngineState(void);
	virtual void __fastcall RestoreEngineState(int Index);
	virtual void __fastcall ClearEngineStates(void);
	virtual void __fastcall SetWorkingPage(int PageNo);
	__property TextFormatting ;
	
__published:
	__property FileName ;
	__property Font ;
	__property Page ;
	__property TgtSpreadSheetPreferences* Preferences = {read=GetPreferences, write=SetPreferences};
	__property TgtSheetFormatting* Formatting = {read=FFormatting, write=SetFormatting};
	
/* Hoisted overloads: */
	
protected:
	inline void __fastcall  PlayMetafile(const Gtutils::TgtRect &DestRect, Graphics::TMetafile* Metafile){ TgtCustomDocumentEngine::PlayMetafile(DestRect, Metafile); }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtcstspdeng */
using namespace Gtcstspdeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtcstspdeng
