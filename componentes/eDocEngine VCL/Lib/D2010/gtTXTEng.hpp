// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gttxteng.pas' rev: 21.00

#ifndef GttxtengHPP
#define GttxtengHPP

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
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdocutils.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gttxteng
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TgtTextLineSpacing { lsActual, lsOneBlank, lsTwoBlank, lsThreeBlank, lsFourBlank, lsFiveBlank };
#pragma option pop

class DELPHICLASS TgtTextEngine;
class PASCALIMPLEMENTATION TgtTextEngine : public Gtcstdoceng::TgtCustomDocumentEngine
{
	typedef Gtcstdoceng::TgtCustomDocumentEngine inherited;
	
private:
	double FXFactor;
	Classes::TStream* FTextStream;
	Classes::TStringList* FTextLines;
	Classes::TStringList* FTextTemp;
	System::WideChar FSeparator;
	int FPrevY;
	bool FPageEndLines;
	bool FSingleFile;
	TgtTextLineSpacing FLineSpacing;
	int FColumnSpacing;
	int FPageLineCount;
	bool FInsertPageBreaks;
	bool FUseSeparator;
	bool FContinuousMode;
	void __fastcall InitText(void);
	void __fastcall EndText(void);
	void __fastcall SetLineSpacing(const TgtTextLineSpacing Value);
	void __fastcall SetPageEndLines(const bool Value);
	void __fastcall SetSeparator(const System::WideChar Value);
	void __fastcall SetSingleFile(const bool Value);
	void __fastcall SetInsertPageBreaks(const bool Value);
	void __fastcall SetColumnSpacing(const int Value);
	void __fastcall SetUseSeparator(const bool Value);
	void __fastcall SetContinuousMode(const bool Value);
	
protected:
	virtual System::Word __fastcall ShowSetupModal(void);
	virtual void __fastcall EncodeText(Gtcstdoceng::TgtTextItem* AObject);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall Start(void);
	virtual void __fastcall Finish(void);
	
public:
	__fastcall virtual TgtTextEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtTextEngine(void);
	virtual void __fastcall BeginDoc(void);
	virtual void __fastcall EndDoc(void);
	virtual void __fastcall BeginPara(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall EndPara(void);
	virtual Classes::TList* __fastcall BeginTable(double X, double Y, int NoColumns);
	virtual double __fastcall NewRow(double Height)/* overload */;
	virtual double __fastcall NewRow(void)/* overload */;
	virtual void __fastcall EndTable(void);
	virtual void __fastcall PlayMetafile(Graphics::TMetafile* Metafile)/* overload */;
	virtual void __fastcall PlayMetafile(const Gtutils::TgtRect &DestRect, Graphics::TMetafile* Metafile)/* overload */;
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
	virtual void __fastcall TextOut(double X, double Y, System::WideString Text)/* overload */;
	virtual void __fastcall TextRect(const Gtutils::TgtRect &Rect, double X, double Y, System::WideString Text);
	virtual double __fastcall TextOut(System::WideString Text)/* overload */;
	virtual void __fastcall TextOut(int ColumnNo, System::WideString Text)/* overload */;
	virtual void __fastcall TextBox(const Gtutils::TgtRect &TextRect, System::WideString Text, Gtcstdoceng::TgtHAlignment HAlignment, Gtcstdoceng::TgtVAlignment VAlignment);
	virtual void __fastcall SetWorkingPage(int PageNo);
	__property TextFormatting;
	__property TableSettings;
	
__published:
	__property DefaultFont;
	__property Page;
	__property Preferences;
	__property FileName;
	__property System::WideChar Separator = {read=FSeparator, write=SetSeparator, default=44};
	__property bool UseSeparator = {read=FUseSeparator, write=SetUseSeparator, default=0};
	__property bool PageEndLines = {read=FPageEndLines, write=SetPageEndLines, default=0};
	__property bool SingleFile = {read=FSingleFile, write=SetSingleFile, default=1};
	__property bool InsertPageBreaks = {read=FInsertPageBreaks, write=SetInsertPageBreaks, default=1};
	__property int ColumnSpacing = {read=FColumnSpacing, write=SetColumnSpacing, nodefault};
	__property TgtTextLineSpacing LineSpacing = {read=FLineSpacing, write=SetLineSpacing, default=0};
	__property bool ContinuousMode = {read=FContinuousMode, write=SetContinuousMode, default=0};
	__property OnNeedFileName;
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gttxteng */
using namespace Gttxteng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GttxtengHPP
