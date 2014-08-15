// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtmetafileprocessor.pas' rev: 10.00

#ifndef GtmetafileprocessorHPP
#define GtmetafileprocessorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtdocutils.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtmetafileprocessor
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TgtEMFAlignments { TA_NOUPDATECP, TA_UPDATECP, TA_LEFT, TA_RIGHT, TA_CENTER, TA_TOP, TA_BOTTOM, TA_BASELINE, TA_RTLREADING, TA_MASK };
#pragma option pop

typedef Set<TgtEMFAlignments, TA_NOUPDATECP, TA_MASK>  TgtEMFAlignment;

#pragma option push -b-
enum TgtAlignments { taLeftJustify, taRightJustify, taCenter, taJustify, taBaseLine, taBottom, taTop };
#pragma option pop

#pragma option push -b-
enum TgtGDIOBJType { goPen, goBrush, goFont, goPalette, goNone };
#pragma option pop

typedef Set<TgtAlignments, taLeftJustify, taTop>  TgtAlignment;

typedef Classes::TList* *PTList;

class DELPHICLASS TgtFontInfo;
class PASCALIMPLEMENTATION TgtFontInfo : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	int FfiFlags;
	double FfiAscent;
	double FfiDescent;
	double FfiCapHeight;
	double FfiStrikeoutSize;
	double FfiStrikeoutPosition;
	double FfiUnderscoreSize;
	double FfiUnderscorePosition;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TgtFontInfo(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TgtFontInfo(void) { }
	#pragma option pop
	
};


class DELPHICLASS TgtFont;
class PASCALIMPLEMENTATION TgtFont : public Graphics::TFont 
{
	typedef Graphics::TFont inherited;
	
public:
	int FRotateFont;
	__fastcall TgtFont(void);
	__fastcall virtual ~TgtFont(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
};


class DELPHICLASS TgtPalette;
class PASCALIMPLEMENTATION TgtPalette : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	#pragma pack(push,1)
	tagLOGPALETTE FLogPalette;
	#pragma pack(pop)
	
public:
	__fastcall TgtPalette(void);
	__fastcall virtual ~TgtPalette(void);
};


class DELPHICLASS TgtGDIOBJ;
class PASCALIMPLEMENTATION TgtGDIOBJ : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	TgtGDIOBJType FGDIOBJType;
	Graphics::TPen* FPen;
	Graphics::TBrush* FBrush;
	TgtFont* FFont;
	TgtPalette* FPalette;
	Gtcstdoceng::TgtPenJoinStyle FPenJoinStyle;
	Gtcstdoceng::TgtPenCapStyle FPenCapStyle;
	__fastcall TgtGDIOBJ(TgtGDIOBJType AGDIOBJType);
	__fastcall virtual ~TgtGDIOBJ(void);
};


class DELPHICLASS TgtHackDocumentEngine;
class PASCALIMPLEMENTATION TgtHackDocumentEngine : public Gtcstdoceng::TgtCustomDocumentEngine 
{
	typedef Gtcstdoceng::TgtCustomDocumentEngine inherited;
	
public:
	#pragma option push -w-inl
	/* TgtCustomDocumentEngine.Create */ inline __fastcall virtual TgtHackDocumentEngine(Classes::TComponent* AOwner) : Gtcstdoceng::TgtCustomDocumentEngine(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TgtCustomDocumentEngine.Destroy */ inline __fastcall virtual ~TgtHackDocumentEngine(void) { }
	#pragma option pop
	
};


class DELPHICLASS TgtMetaState;
class PASCALIMPLEMENTATION TgtMetaState : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TgtFont* FFont;
	Graphics::TBrush* FBrush;
	Graphics::TPen* FPen;
	int FBKMode;
	unsigned FMapMode;
	#pragma pack(push,1)
	tagXFORM FXForm;
	#pragma pack(pop)
	#pragma pack(push,1)
	tagSIZE FWinExtent;
	#pragma pack(pop)
	#pragma pack(push,1)
	tagSIZE FViewExtent;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint FWinOrg;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint FViewOrg;
	#pragma pack(pop)
	TgtEMFAlignment FTextAlign;
	
public:
	__fastcall TgtMetaState(void);
	__fastcall virtual ~TgtMetaState(void);
};


class DELPHICLASS TgtMetafileProcessor;
class PASCALIMPLEMENTATION TgtMetafileProcessor : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TgtHackDocumentEngine* FEngine;
	double FStartX;
	double FStartY;
	unsigned FROP2;
	unsigned FStretchMode;
	unsigned FICMMode;
	unsigned FPolyFillMode;
	Graphics::TColor FBKColor;
	unsigned FMapMode;
	float FMiterLimit;
	TgtFont* FCurrentFont;
	Graphics::TBrush* FCurrentBrush;
	Graphics::TPen* FCurrentPen;
	TgtPalette* FCurrentPalette;
	TgtEMFAlignment FTextAlignment;
	Graphics::TColor FTextColor;
	#pragma pack(push,1)
	Types::TPoint FCurrentPathPoint;
	#pragma pack(pop)
	double FUpdatePathX;
	Byte FBKMode;
	Gtutils::TgtRect FStretchBltRect;
	int FJustProcessedTextItem;
	bool FFontStyleChanged;
	Gtutils::TgtRect FClipRect;
	Byte FJustCompletedPath;
	bool FInPath;
	bool FJustProcessedStretchBltShape;
	int FSymbolCharsetFontIdx;
	int FCurrentRecord;
	Classes::TList* FGDIOBJList;
	TgtGDIOBJ* FGDIOBJ;
	bool FProcessText;
	bool FProcessImage;
	bool FProcessShape;
	bool FIsClipRect;
	bool FIsIntersectClipRect;
	Classes::TList* *FPTextList;
	Gtcstdoceng::TgtEOFItem* FEOFItem;
	Gtcstdoceng::TgtTextItem* FTextItem;
	Gtcstdoceng::TgtImageItem* FImageItem;
	Gtcstdoceng::TgtPolyShapeItem* FPolyShapeItem;
	Gtcstdoceng::TgtShapeItem* FShapeItem;
	Gtcstdoceng::TgtClipItem* FClipItem;
	Gtcstdoceng::TgtPolyPolygonItem* FPolyPolygonItem;
	Gtcstdoceng::TgtPathItem* FPathItem;
	Gtcstdoceng::TgtPolyDrawItem* FPolyDrawItem;
	int FWidth;
	int FHeight;
	#pragma pack(push,1)
	tagXFORM FXForm;
	#pragma pack(pop)
	Classes::TStringList* FMetaState;
	#pragma pack(push,1)
	Types::TPoint FViewPortOrigin;
	#pragma pack(pop)
	#pragma pack(push,1)
	tagSIZE FViewPortExtent;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint FWindowOrigin;
	#pragma pack(pop)
	#pragma pack(push,1)
	tagSIZE FWindowExtent;
	#pragma pack(pop)
	double FMapMXmul;
	double FMapMYmul;
	unsigned __fastcall GetColorValue(unsigned AColor);
	double __fastcall ApplyMMToPenWidth(double AX);
	Gtcstdoceng::TgtPoint __fastcall ApplyMMWithOrigin(double AX, double AY);
	Gtcstdoceng::TgtPoint __fastcall ApplyMM(double AX, double AY);
	Gtutils::TgtRect __fastcall ApplyMMToRect(const Gtutils::TgtRect &ARect);
	void __fastcall SetMapModeMultiplier(void);
	Gtcstdoceng::TgtPoint __fastcall GetTopLeftPosition(double ReferenceX, double ReferenceY, AnsiString Text, Graphics::TFont* Font, int Rotation);
	Gtcstdoceng::TgtPoint __fastcall WorldTransform(double AX, double AY);
	void __fastcall SaveMetaState(void);
	void __fastcall RestoreMetaState(int N);
	void __fastcall SelectStockObject(unsigned AihObject);
	void __fastcall IsFirstRasterOpImage(const Gtutils::TgtRect &ARect, /* out */ int &ImageIndex);
	void __fastcall AddScanLineToBitmap(const tagBITMAPFILEHEADER &ABitmapFileHeader, const tagBITMAPINFOHEADER &ABitmapInfoHeader, void * APBmiSrc, void * APBitSrc, unsigned ABmiBufCount, unsigned ABitBufCount);
	void __fastcall BitmapRasterOp(unsigned ARop, int AImageIndex, const tagBITMAPFILEHEADER &ABitmapFileHeader, const tagBITMAPINFOHEADER &ABitmapInfoHeader, void * APBmiSrc, void * APBitSrc, unsigned ABmiBufCount, unsigned ABitBufCount);
	bool __fastcall CheckAndSetUnderlineStrikeOut(void);
	void __fastcall CreateBitmap(Classes::TMemoryStream* &ABitmapStream, const tagBITMAPFILEHEADER &ABitmapFileHeader, const tagBITMAPINFOHEADER &ABitmapInfoHeader, void * APBmiSrc, void * APBitSrc, unsigned ABmiBufCount, unsigned ABitBufCount);
	void __fastcall CreateShapeItem(Gtcstdoceng::TgtShapeItem* &AShapeItem, Gtcstdoceng::TgtShapeType AShapeType = (Gtcstdoceng::TgtShapeType)(0x0));
	void __fastcall CreatePolyShapeItem(Gtcstdoceng::TgtPolyShapeItem* &APolyShapeItem);
	void __fastcall CreatePolyPolygonItem(Gtcstdoceng::TgtPolyPolygonItem* &APolyPolygonItem);
	void __fastcall CreateImageItem(Gtcstdoceng::TgtImageItem* &AImageItem);
	void __fastcall CreateTextItem(Gtcstdoceng::TgtTextItem* &ATextItem);
	void __fastcall CreateClipItem(Gtcstdoceng::TgtClipItem* &AClipItem);
	void __fastcall CreatePathItem(Gtcstdoceng::TgtPathItem* &APathItem);
	void __fastcall CreateEOFItem(Gtcstdoceng::TgtEOFItem* &AEOFItem);
	void __fastcall CreatePolyDrawItem(Gtcstdoceng::TgtPolyDrawItem* &APolyDrawItem);
	void __fastcall CreateGDIRec(TgtGDIOBJ* &AGDIOBJ, TgtGDIOBJType AGDIOBJType);
	void __fastcall FillFontMetrics(Graphics::TFont* AFont, TgtFontInfo* AFontInfo);
	Extended __fastcall GetSizeFromHeight(Extended AHeight);
	Graphics::TFontStyles __fastcall IsTextUnderlinedStrikedout(Graphics::TFont* AFont, unsigned AMapMode, const Gtutils::TgtRect &AStretchBlt, Extended ATextReferenceY);
	void __fastcall SetAlignment(TgtEMFAlignment AgtEMFAlignment, Gtcstdoceng::TgtHAlignment &AHorizontalAlignment, Gtcstdoceng::TgtVAlignment &AVerticalAlignment)/* overload */;
	void __fastcall SetAlignment(int AMode, TgtEMFAlignment &AgtAlignment)/* overload */;
	Word __fastcall DoCharMapping(Word AChar);
	
public:
	bool FCombineCharsToSentence;
	__fastcall TgtMetafileProcessor(Gtcstdoceng::TgtCustomDocumentEngine* ADocumentEngine);
	__fastcall virtual ~TgtMetafileProcessor(void);
	void __fastcall Execute(Graphics::TMetafile* AMetafile, double AStartX, double AStartY)/* overload */;
	void __fastcall Execute(unsigned AMetafileHandle, double AStartX, double AStartY)/* overload */;
};


typedef TgtMetafileProcessor* *PTgtMetafileProcessor;

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE int __stdcall EnhMetaFileProc(HDC AHDC, Windows::PHandleTable AHandleTable, const void * AEnhMetaRecord, int AObjectCount, void * AOptionalData);

}	/* namespace Gtmetafileprocessor */
using namespace Gtmetafileprocessor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtmetafileprocessor
