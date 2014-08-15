// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtsvgeng.pas' rev: 10.00

#ifndef GtsvgengHPP
#define GtsvgengHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtcstplneng.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdocutils.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtsvgeng
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TgtCurveType { ctArc, ctChord, ctPie };
#pragma option pop

class DELPHICLASS TgtSVGImageSettings;
class PASCALIMPLEMENTATION TgtSVGImageSettings : public Gtcstdoceng::TgtImageSettings 
{
	typedef Gtcstdoceng::TgtImageSettings inherited;
	
private:
	AnsiString FFileName;
	double FDispWidth;
	double FDispHeight;
	double FImageWidth;
	double FImageHeight;
	void __fastcall SetFileName(const AnsiString Value);
	void __fastcall SetDispHeight(const double Value);
	void __fastcall SetDispWidth(const double Value);
	void __fastcall SetImageHeight(const double Value);
	void __fastcall SetImageWidth(const double Value);
	
public:
	__fastcall virtual TgtSVGImageSettings(void)/* overload */;
	__fastcall virtual ~TgtSVGImageSettings(void);
	bool __fastcall IsEqual(Gtcstdoceng::TgtImageItem* AObject, double AOriginalWidth, double AOriginalHeight);
	
__published:
	__property AnsiString FileName = {read=FFileName, write=SetFileName};
	__property double DispWidth = {read=FDispWidth, write=SetDispWidth};
	__property double DispHeight = {read=FDispHeight, write=SetDispHeight};
	__property double ImageWidth = {read=FImageWidth, write=SetImageWidth};
	__property double ImageHeight = {read=FImageHeight, write=SetImageHeight};
};


typedef DynamicArray<Classes::TList* >  gtSVGEng__3;

class DELPHICLASS TgtSVGEngine;
class PASCALIMPLEMENTATION TgtSVGEngine : public Gtcstplneng::TgtCustomPlainsheetEngine 
{
	typedef Gtcstplneng::TgtCustomPlainsheetEngine inherited;
	
private:
	Classes::TStream* FSVGStream;
	int FImageCount;
	AnsiString FPattern;
	Classes::TStringList* FPatternPathList;
	int FCurInclination;
	Gtcstdoceng::TgtPoint FRotationPoint;
	DynamicArray<Classes::TList* >  FImgSettingList;
	Classes::TStringList* FAttachmentList;
	AnsiString __fastcall GetRGBString(Graphics::TColor AColor);
	AnsiString __fastcall GetSVGImage(Gtcstdoceng::TgtImageItem* AObject);
	AnsiString __fastcall GetShapeStyle(Graphics::TPen* APen, Graphics::TBrush* ABrush);
	void __fastcall EncodeCurve(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4, Graphics::TPen* APen, Graphics::TBrush* ABrush, TgtCurveType AType);
	AnsiString __fastcall NumToStr(Extended AN);
	AnsiString __fastcall SVGChars(AnsiString AString, bool AToSVG);
	
protected:
	virtual void __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall BeginPage(void);
	virtual Word __fastcall ShowSetupModal(void);
	virtual bool __fastcall CheckOutputImageFormat(Gtcstdoceng::TgtOutputImageFormat Value, AnsiString &S);
	virtual void __fastcall EncodeText(Gtcstdoceng::TgtTextItem* AObject);
	virtual void __fastcall EncodeImage(Gtcstdoceng::TgtImageItem* AObject);
	virtual void __fastcall EncodeLine(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen);
	virtual void __fastcall EncodeRect(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeRoundRect(double X1, double Y1, double X2, double Y2, double X3, double Y3, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeEllipse(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodePolyLine(Gtcstdoceng::TgtPoints Points, int NoPoints, bool IsClosed, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeArc(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4, Graphics::TPen* Pen);
	virtual void __fastcall EncodePie(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeChord(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodePolyBezier(Gtcstdoceng::TgtPoints Points, int NoPoints, Graphics::TPen* Pen);
	virtual void __fastcall EncodeShapeBitmap(double X, double Y, Graphics::TBitmap* Bitmap);
	
public:
	__fastcall virtual TgtSVGEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtSVGEngine(void);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtsvgeng */
using namespace Gtsvgeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtsvgeng
