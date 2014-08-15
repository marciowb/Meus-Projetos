// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtcstgfxeng.pas' rev: 21.00

#ifndef GtcstgfxengHPP
#define GtcstgfxengHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gtdocutils.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtcstgfxeng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtGfxMetafileItem;
class PASCALIMPLEMENTATION TgtGfxMetafileItem : public Gtcstdoceng::TgtDocumentItem
{
	typedef Gtcstdoceng::TgtDocumentItem inherited;
	
private:
	double FX;
	double FY;
	int FIndexNo;
public:
	/* TObject.Create */ inline __fastcall TgtGfxMetafileItem(void) : Gtcstdoceng::TgtDocumentItem() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TgtGfxMetafileItem(void) { }
	
};


class DELPHICLASS TgtCustomGraphicsEngine;
class PASCALIMPLEMENTATION TgtCustomGraphicsEngine : public Gtcstdoceng::TgtCustomDocumentEngine
{
	typedef Gtcstdoceng::TgtCustomDocumentEngine inherited;
	
private:
	Graphics::TMetafileCanvas* FMetafileCanvas;
	bool FMonochrome;
	Graphics::TPixelFormat FPixelFormat;
	double FScaleY;
	double FScaleX;
	void __fastcall GetDefaultBrush(Graphics::TBrush* ABrush);
	void __fastcall SetCanvasTextRotation(int Angle);
	void __fastcall SetMonochrome(const bool Value);
	void __fastcall SetPixelFormat(const Graphics::TPixelFormat Value);
	void __fastcall SetScaleX(const double Value);
	void __fastcall SetScaleY(const double Value);
	
protected:
	Graphics::TMetafile* FMetafile;
	virtual void __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall EncodeText(Gtcstdoceng::TgtTextItem* AObject);
	virtual void __fastcall EncodeImage(Gtcstdoceng::TgtImageItem* AObject);
	virtual void __fastcall EncodeLine(double AX1, double AY1, double AX2, double AY2, Graphics::TPen* APen);
	virtual void __fastcall EncodeRect(double AX1, double AY1, double AX2, double AY2, Graphics::TPen* APen, Graphics::TBrush* ABrush);
	virtual void __fastcall EncodeRoundRect(double AX1, double AY1, double AX2, double AY2, double AX3, double AY3, Graphics::TPen* APen, Graphics::TBrush* ABrush);
	virtual void __fastcall EncodeEllipse(double AX1, double AY1, double AX2, double AY2, Graphics::TPen* APen, Graphics::TBrush* ABrush);
	virtual void __fastcall EncodePolyLine(Gtcstdoceng::TgtPoints APoints, int NoPoints, bool IsClosed, Graphics::TPen* APen, Graphics::TBrush* ABrush);
	virtual void __fastcall EncodeArc(double AX1, double AY1, double AX2, double AY2, double AX3, double AY3, double AX4, double AY4, Graphics::TPen* APen);
	virtual void __fastcall EncodePie(double AX1, double AY1, double AX2, double AY2, double AX3, double AY3, double AX4, double AY4, Graphics::TPen* APen, Graphics::TBrush* ABrush);
	virtual void __fastcall EncodeChord(double AX1, double AY1, double AX2, double AY2, double AX3, double AY3, double AX4, double AY4, Graphics::TPen* APen, Graphics::TBrush* ABrush);
	virtual void __fastcall EncodePolyBezier(Gtcstdoceng::TgtPoints APoints, int NoPoints, Graphics::TPen* APen);
	virtual void __fastcall EncodeCustomItem(Gtcstdoceng::TgtDocumentItem* AObject);
	__property bool Monochrome = {read=FMonochrome, write=SetMonochrome, default=0};
	__property Graphics::TPixelFormat PixelFormat = {read=FPixelFormat, write=SetPixelFormat, default=6};
	
public:
	__fastcall virtual TgtCustomGraphicsEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtCustomGraphicsEngine(void);
	virtual void __fastcall BeginDoc(void);
	virtual void __fastcall EndDoc(void);
	virtual void __fastcall NewPage(void);
	virtual void __fastcall TextOut(double X, double Y, System::WideString Text)/* overload */;
	virtual void __fastcall TextRect(const Gtutils::TgtRect &Rect, double X, double Y, System::WideString Text);
	virtual void __fastcall TextOut(int ColumnNo, System::WideString Text)/* overload */;
	virtual double __fastcall TextOut(System::WideString Text)/* overload */;
	virtual void __fastcall TextBox(const Gtutils::TgtRect &TextRect, System::WideString Text, Gtcstdoceng::TgtHAlignment HAlignment, Gtcstdoceng::TgtVAlignment VAlignment);
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
	virtual void __fastcall Polygon(Gtcstdoceng::TgtPoint *Points, const int Points_Size, bool IsFill);
	virtual void __fastcall PolyLine(Gtcstdoceng::TgtPoint *Points, const int Points_Size);
	virtual void __fastcall Arc(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4);
	virtual void __fastcall Pie(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4, bool IsFill);
	virtual void __fastcall Chord(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4, bool IsFill);
	virtual void __fastcall PolyBezier(Gtcstdoceng::TgtPoint *Points, const int Points_Size);
	virtual void __fastcall BeginPara(void);
	virtual void __fastcall EndPara(void);
	virtual Classes::TList* __fastcall BeginTable(double X, double Y, int NoColumns);
	virtual double __fastcall NewRow(double Height)/* overload */;
	virtual double __fastcall NewRow(void)/* overload */;
	virtual void __fastcall EndTable(void);
	virtual void __fastcall PlayMetafile(Graphics::TMetafile* Metafile)/* overload */;
	virtual void __fastcall PlayMetafile(double X, double Y, Graphics::TMetafile* Metafile)/* overload */;
	virtual void __fastcall PlayMetafile(const Gtutils::TgtRect &DestRect, Graphics::TMetafile* Metafile)/* overload */;
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
	__property TextFormatting;
	__property TableSettings;
	__property Frame;
	
__published:
	__property FileName;
	__property Font;
	__property Pen;
	__property Brush;
	__property ImageSettings;
	__property Page;
	__property PageBorder;
	__property Preferences;
	__property BackgroundColor = {default=16777215};
	__property BackgroundImage;
	__property BackgroundImageDisplayType = {default=5};
	__property double ScaleX = {read=FScaleX, write=SetScaleX};
	__property double ScaleY = {read=FScaleY, write=SetScaleY};
	__property OnCellDraw;
	__property OnNeedFileName;
	
/* Hoisted overloads: */
	
protected:
	inline int __fastcall  AddImageAsResource(Graphics::TGraphic* AGraphic, bool AResource){ return Gtcstdoceng::TgtCustomDocumentEngine::AddImageAsResource(AGraphic, AResource); }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtcstgfxeng */
using namespace Gtcstgfxeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtcstgfxengHPP
