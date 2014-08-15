// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtexxlseng.pas' rev: 10.00

#ifndef GtexxlsengHPP
#define GtexxlsengHPP

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
#include <Gtcstxlseng.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtdocutils.hpp>	// Pascal unit
#include <Gtcstspdeng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtexxlseng
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TgtExcelFormulaType { ftExpression, ftFunction };
#pragma option pop

class DELPHICLASS TgtFormulaItem;
class PASCALIMPLEMENTATION TgtFormulaItem : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	int FColNo;
	int FRowNo;
	AnsiString FLines;
	Graphics::TFont* FFont;
	Gtcstdoceng::TgtHAlignment FAlignment;
	Graphics::TBrush* FBrush;
	TgtExcelFormulaType FFormulaType;
	void __fastcall SetAlignment(const Gtcstdoceng::TgtHAlignment Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetBrush(const Graphics::TBrush* Value);
	void __fastcall SetFormulaType(const TgtExcelFormulaType Value);
	
public:
	__fastcall virtual TgtFormulaItem(void);
	__fastcall virtual ~TgtFormulaItem(void);
	__property int RowNo = {read=FRowNo, write=FRowNo, nodefault};
	__property int ColNo = {read=FColNo, write=FColNo, nodefault};
	__property AnsiString Lines = {read=FLines, write=FLines};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Gtcstdoceng::TgtHAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property TgtExcelFormulaType FormulaType = {read=FFormulaType, write=SetFormulaType, nodefault};
};


class DELPHICLASS TgtExExcelEngine;
class PASCALIMPLEMENTATION TgtExExcelEngine : public Gtcstxlseng::TgtCustomExcelEngine 
{
	typedef Gtcstxlseng::TgtCustomExcelEngine inherited;
	
private:
	int FObjectCount;
	Classes::TList* FRowHeights;
	int FLastRowNo;
	Graphics::TFont* FMaxFont;
	int FMaxCellSize;
	void __fastcall EncodeGraphic(const Gtutils::TgtRect &ARect, Graphics::TBitmap* ABitmap, Graphics::TMetafile* AMetafile, bool IsBackground);
	void __fastcall AbsHorPosn(double AX, double AWidth, int &ALeft, int &ALeftOffset, int &ARight, int &ARightOffset);
	void __fastcall AbsVertPosn(double AY, double AHeight, int &ATop, int &ATopOffset, int &ABottom, int &ABottomOffset);
	void __fastcall GetCommonAttribute(Byte * AObjectAttrib, const int AObjectAttrib_Size, const Gtutils::TgtRect &ARect, Byte AObjectType);
	
protected:
	virtual void __fastcall Start(void);
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall EncodeText(Gtcstdoceng::TgtTextItem* AObject);
	void __fastcall EncodeFormula(TgtFormulaItem* AObject);
	virtual void __fastcall EncodeTextBox(Gtcstdoceng::TgtTextBoxItem* AObject);
	virtual void __fastcall EncodeImage(Gtcstdoceng::TgtImageItem* AObject);
	virtual void __fastcall EncodeLine(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen);
	virtual void __fastcall EncodeRect(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeRoundRect(double X1, double Y1, double X2, double Y2, double X3, double Y3, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeEllipse(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodePolyLine(Gtcstdoceng::TgtPoints Points, int NoPoints, bool IsClosed, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeShapeBitmap(double X, double Y, Graphics::TBitmap* Bitmap);
	virtual bool __fastcall CheckOutputImageFormat(Gtcstdoceng::TgtOutputImageFormat Value, AnsiString &S);
	virtual void __fastcall WriteBackgroundImage(void);
	virtual void __fastcall ProcessMetafile(double AX, double AY, Graphics::TMetafile* AMetafile);
	
public:
	void __fastcall FormulaOut(int Row, int Column, AnsiString Text, Gtcstdoceng::TgtHAlignment Alignment, TgtExcelFormulaType FormulaType);
	virtual void __fastcall DrawImage(double X, double Y, Graphics::TGraphic* AGraphic)/* overload */;
	virtual void __fastcall DrawImage(const Gtutils::TgtRect &ImageRect, Graphics::TGraphic* AGraphic)/* overload */;
	virtual void __fastcall DrawImage(const Gtutils::TgtRect &ImageRect, int Index)/* overload */;
	virtual void __fastcall DrawImage(int ColumnNo, double Width, double Height, Graphics::TGraphic* AGraphic)/* overload */;
	virtual int __fastcall AddImageAsResource(Graphics::TGraphic* AGraphic)/* overload */;
	virtual void __fastcall Line(double X1, double Y1, double X2, double Y2);
	virtual void __fastcall Rectangle(double X1, double Y1, double X2, double Y2, bool IsFill);
	virtual void __fastcall RoundRect(double X1, double Y1, double X2, double Y2, double X3, double Y3, bool IsFill);
	virtual void __fastcall Ellipse(double X1, double Y1, double X2, double Y2, bool IsFill);
	virtual void __fastcall Polygon(Gtcstdoceng::TgtPoint * Points, const int Points_Size, bool IsFill);
	virtual void __fastcall PolyLine(Gtcstdoceng::TgtPoint * Points, const int Points_Size);
	virtual void __fastcall Arc(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4);
	virtual void __fastcall Pie(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4, bool IsFill);
	virtual void __fastcall Chord(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4, bool IsFill);
	virtual void __fastcall PolyBezier(Gtcstdoceng::TgtPoint * Points, const int Points_Size);
	
__published:
	__property ImageSettings ;
public:
	#pragma option push -w-inl
	/* TgtCustomExcelEngine.Create */ inline __fastcall virtual TgtExExcelEngine(Classes::TComponent* AOwner) : Gtcstxlseng::TgtCustomExcelEngine(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TgtCustomExcelEngine.Destroy */ inline __fastcall virtual ~TgtExExcelEngine(void) { }
	#pragma option pop
	
	
/* Hoisted overloads: */
	
protected:
	inline int __fastcall  AddImageAsResource(Graphics::TGraphic* AGraphic, bool AResource){ return TgtCustomDocumentEngine::AddImageAsResource(AGraphic, AResource); }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtexxlseng */
using namespace Gtexxlseng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtexxlseng
