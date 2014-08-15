// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtcstplneng.pas' rev: 10.00

#ifndef GtcstplnengHPP
#define GtcstplnengHPP

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
#include <Gtutils.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtcstplneng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtTOCItem;
class PASCALIMPLEMENTATION TgtTOCItem : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	WideString FTitle;
	int FPageNumber;
	int FParentNode;
	double FX;
	double FY;
	AnsiString FURL;
	
public:
	__fastcall TgtTOCItem(void);
	__fastcall virtual ~TgtTOCItem(void);
	__property WideString Title = {read=FTitle, write=FTitle};
	__property int PageNumber = {read=FPageNumber, write=FPageNumber, nodefault};
	__property int ParentNode = {read=FParentNode, write=FParentNode, nodefault};
	__property double X = {read=FX, write=FX};
	__property double Y = {read=FY, write=FY};
	__property AnsiString URL = {read=FURL, write=FURL};
};


class DELPHICLASS TgtPlainSheetPreferences;
class PASCALIMPLEMENTATION TgtPlainSheetPreferences : public Gtcstdoceng::TgtPreferences 
{
	typedef Gtcstdoceng::TgtPreferences inherited;
	
private:
	bool FActiveHyperLinks;
	void __fastcall SetActiveHyperLinks(const bool Value);
	
public:
	__fastcall virtual TgtPlainSheetPreferences(void)/* overload */;
	
__published:
	__property bool ActiveHyperLinks = {read=FActiveHyperLinks, write=SetActiveHyperLinks, default=1};
public:
	#pragma option push -w-inl
	/* TgtPreferences.Destroy */ inline __fastcall virtual ~TgtPlainSheetPreferences(void) { }
	#pragma option pop
	
};


class DELPHICLASS TgtCustomPlainsheetEngine;
class PASCALIMPLEMENTATION TgtCustomPlainsheetEngine : public Gtcstdoceng::TgtCustomDocumentEngine 
{
	typedef Gtcstdoceng::TgtCustomDocumentEngine inherited;
	
private:
	HIDESBASE TgtPlainSheetPreferences* __fastcall GetPreferences(void);
	HIDESBASE void __fastcall SetPreferences(const TgtPlainSheetPreferences* Value);
	
protected:
	Classes::TList* FTOCItemList;
	virtual void __fastcall EndPage(void);
	virtual int __fastcall AddTOCItem(WideString Caption, int ParentNode, int PageNumber, double Top)/* overload */;
	virtual int __fastcall AddTOCItem(WideString Caption, int ParentNode, AnsiString URL)/* overload */;
	virtual TMetaClass* __fastcall GetPreferencesClassName(void);
	
public:
	__fastcall virtual TgtCustomPlainsheetEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtCustomPlainsheetEngine(void);
	virtual void __fastcall BeginDoc(void);
	virtual void __fastcall EndDoc(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall HTMLTextOut(double X, double Y, WideString HTMLText);
	virtual void __fastcall TextOut(double X, double Y, WideString Text)/* overload */;
	virtual void __fastcall TextOut(int ColumnNo, WideString Text)/* overload */;
	virtual double __fastcall TextOut(WideString Text)/* overload */;
	virtual void __fastcall TextRect(const Gtutils::TgtRect &Rect, double X, double Y, WideString Text);
	virtual void __fastcall TextBox(const Gtutils::TgtRect &TextRect, WideString Text, Gtcstdoceng::TgtHAlignment HAlignment, Gtcstdoceng::TgtVAlignment VAlignment);
	virtual void __fastcall SetTextRotation(int Angle);
	virtual void __fastcall DrawImage(double X, double Y, Graphics::TGraphic* AGraphic)/* overload */;
	virtual void __fastcall DrawImage(const Gtutils::TgtRect &ImageRect, Graphics::TGraphic* AGraphic)/* overload */;
	virtual void __fastcall DrawImage(const Gtutils::TgtRect &ImageRect, int Index)/* overload */;
	virtual void __fastcall DrawImage(int ColumnNo, double Width, double Height, Graphics::TGraphic* AGraphic)/* overload */;
	virtual int __fastcall AddImageAsResource(Graphics::TGraphic* AGraphic)/* overload */;
	virtual void __fastcall Line(double X1, double Y1, double X2, double Y2);
	virtual void __fastcall Rectangle(double X1, double Y1, double X2, double Y2, bool IsFill);
	virtual void __fastcall RoundRect(double X1, double Y1, double X2, double y2, double X3, double Y3, bool IsFill);
	virtual void __fastcall Ellipse(double X1, double Y1, double X2, double Y2, bool IsFill);
	virtual void __fastcall Polygon(Gtcstdoceng::TgtPoint * Points, const int Points_Size, bool IsFill);
	virtual void __fastcall PolyLine(Gtcstdoceng::TgtPoint * Points, const int Points_Size);
	virtual void __fastcall Arc(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4);
	virtual void __fastcall Pie(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4, bool IsFill);
	virtual void __fastcall Chord(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4, bool IsFill);
	virtual void __fastcall PolyBezier(Gtcstdoceng::TgtPoint * Points, const int Points_Size);
	virtual void __fastcall BeginPara(void);
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
	virtual void __fastcall SetWorkingPage(int PageNo);
	__property TextFormatting ;
	__property TableSettings ;
	__property Frame ;
	
__published:
	__property FileName ;
	__property Font ;
	__property Pen ;
	__property Brush ;
	__property ImageSettings ;
	__property Page ;
	__property PageBorder ;
	__property DocInfo ;
	__property TgtPlainSheetPreferences* Preferences = {read=GetPreferences, write=SetPreferences};
	__property OnCellDraw ;
	
/* Hoisted overloads: */
	
protected:
	inline int __fastcall  AddImageAsResource(Graphics::TGraphic* AGraphic, bool AResource){ return TgtCustomDocumentEngine::AddImageAsResource(AGraphic, AResource); }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtcstplneng */
using namespace Gtcstplneng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtcstplneng
