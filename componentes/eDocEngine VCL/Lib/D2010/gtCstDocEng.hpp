// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtcstdoceng.pas' rev: 21.00

#ifndef GtcstdocengHPP
#define GtcstdocengHPP

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
#include <Math.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit
#include <Gtclasses.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit
#include <Gtfilters.hpp>	// Pascal unit
#include <Gtdzlib.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Richedit.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtcstdoceng
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TgtUnitType { muPixels, muInches, muMM, muPoints, muTwips };
#pragma option pop

#pragma option push -b-
enum TgtBandType { btContent, btHeader, btFooter, btWatermark, btStamp };
#pragma option pop

#pragma option push -b-
enum TgtShapeType { stLine, stRectangle, stRoundRect, stEllipse, stPolygon, stPolyLine, stArc, stChord, stPie, stPolyBezier };
#pragma option pop

#pragma option push -b-
enum TgtPenJoinStyle { pjsNone, pjsBevel, pjsMiter, pjsRound };
#pragma option pop

#pragma option push -b-
enum TgtPenCapStyle { pcsNone, pcsRound, pcsSquare, pcsFlat };
#pragma option pop

#pragma option push -b-
enum TgtPathOperation { poBeginPath, poEndPath, poCloseFigure, poAbortPath, poFillPath, poStrokeAndFillPath, poStrokePath, poSelectClipPath };
#pragma option pop

#pragma option push -b-
enum TgtHAlignment { haLeft, haRight, haCenter, haJustify, haGeneral };
#pragma option pop

#pragma option push -b-
enum TgtVAlignment { vaTop, vaCenter, vaBottom };
#pragma option pop

#pragma option push -b-
enum TgtOutputImageFormat { ifBMP, ifJPEG, ifGIF, ifPNG, ifMetafile, ifCCITT3, ifCCITT4 };
#pragma option pop

#pragma option push -b-
enum TgtItemsToRenderKind { irText, irImage, irShape };
#pragma option pop

typedef Set<TgtItemsToRenderKind, irText, irShape>  TgtItemsToRender;

#pragma option push -b-
enum TgtCapabilityKind { ckText, ckImage, ckShape, ckHeader, ckFooter, ckWatermark, ckStamp, ckImageStretch, ckImageFrame, ckInputRes };
#pragma option pop

typedef Set<TgtCapabilityKind, ckText, ckInputRes>  TgtCapabilities;

#pragma option push -b-
enum TgtBackgroundDisplayType { dtTile, dtTopLeft, dtTopCenter, dtTopRight, dtCenterLeft, dtCenter, dtCenterRight, dtBottomLeft, dtBottomCenter, dtBottomRight };
#pragma option pop

#pragma option push -b-
enum TgtPaperSize { Letter, LetterSmall, Tabloid, Ledger, Legal, Statement, Executive, A3, A4, A4Small, A5, B4, B5, Folio, Quarto, ps10X14, ps11X17, Note, Env10, Env11, Env12, Env14, CSheet, DSheet, ESheet, EnvDL, EnvC5, EnvC3, EnvC4, EnvC6, EnvC65, EnvB4, EnvB5, EnvB6, EnvItaly, EnvMonarch, EnvPersonal, FanfoldUS, FanfoldStdGerman, ISOB4, Custom };
#pragma option pop

#pragma option push -b-
enum TgtEngineStatus { esNone, esStarted, esFinished, esCancelled, esError };
#pragma option pop

#pragma option push -b-
enum TgtReferencePoint { rpPage, rpMargin, rpBand };
#pragma option pop

#pragma option push -b-
enum TgtTextRenderMode { trmFill, trmStroke, trmFillStroke };
#pragma option pop

#pragma option push -b-
enum TgtTextRise { trNormal, trSuperscript, trSubscript };
#pragma option pop

struct TgtPoint
{
	
public:
	double X;
	double Y;
};


typedef DynamicArray<TgtPoint> TgtPoints;

class DELPHICLASS TgtCustomDocumentEngine;
typedef void __fastcall (__closure *TgtNotifyEvent)(TgtCustomDocumentEngine* Sender);

typedef void __fastcall (__closure *TgtOnNeedFileNameEvent)(TgtCustomDocumentEngine* Sender, System::UnicodeString &FileName, int PageNo);

class DELPHICLASS TgtEMailSettings;
typedef void __fastcall (__closure *TgtEMailEvent)(TgtCustomDocumentEngine* Sender, TgtEMailSettings* EMailSettings, bool &Continue, bool &CancelEmail);

typedef void __fastcall (__closure *TgtEMailErrorEvent)(TgtCustomDocumentEngine* Sender, const System::UnicodeString ErrMsg);

typedef void __fastcall (__closure *TgtErrorMessageEvent)(TgtCustomDocumentEngine* Sender, const Sysutils::Exception* AException);

class DELPHICLASS TgtFrame;
typedef void __fastcall (__closure *TgtOnCellDrawEvent)(TgtCustomDocumentEngine* Sender, int Row, int Column, Graphics::TPen* Pen, Graphics::TBrush* Brush, Graphics::TFont* Font, TgtFrame* Frame, TgtHAlignment &Align);

typedef void __fastcall (__closure *TgtOnCalcVariablesEvent)(TgtCustomDocumentEngine* Sender, System::UnicodeString Variable, System::UnicodeString &Value);

typedef void __fastcall (__closure *TgtOnChangeValue)(double &Value);

class DELPHICLASS TgtTextEffects;
class PASCALIMPLEMENTATION TgtTextEffects : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TgtTextRenderMode FTextRenderMode;
	TgtTextRise FTextRise;
	void __fastcall SetTextRenderMode(const TgtTextRenderMode Value);
	void __fastcall SetTextRise(const TgtTextRise Value);
	
public:
	__fastcall TgtTextEffects(void);
	__fastcall virtual ~TgtTextEffects(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TgtTextRenderMode TextRenderMode = {read=FTextRenderMode, write=SetTextRenderMode, default=0};
	__property TgtTextRise TextRise = {read=FTextRise, write=SetTextRise, default=0};
};


class DELPHICLASS TgtDocumentItem;
class PASCALIMPLEMENTATION TgtDocumentItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	/* TObject.Create */ inline __fastcall TgtDocumentItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TgtDocumentItem(void) { }
	
};


class DELPHICLASS TgtTextItem;
class PASCALIMPLEMENTATION TgtTextItem : public TgtDocumentItem
{
	typedef TgtDocumentItem inherited;
	
private:
	typedef DynamicArray<double> _TgtTextItem__1;
	
	
private:
	double FX;
	double FY;
	Gtclasses::TWideStrings* FLines;
	int FRotationAngle;
	Graphics::TFont* FFont;
	Graphics::TBrush* FBrush;
	TgtTextEffects* FTextEffects;
	bool FIsClipRect;
	Gtutils::TgtRect FClipRect;
	TgtHAlignment FAlignment;
	bool FIsFromMetafile;
	bool FIsWideString;
	void __fastcall SetRotationAngle(int Value);
	void __fastcall SetFont(Graphics::TFont* Value);
	void __fastcall SetBrush(Graphics::TBrush* Value);
	void __fastcall SetTextEffects(const TgtTextEffects* Value);
	void __fastcall SetClipRect(const Gtutils::TgtRect &Value);
	void __fastcall SetIsClipRect(const bool Value);
	void __fastcall SetAlignment(const TgtHAlignment Value);
	
public:
	_TgtTextItem__1 FCharSpaceArray;
	__fastcall virtual TgtTextItem(void);
	__fastcall virtual ~TgtTextItem(void);
	__property double X = {read=FX, write=FX};
	__property double Y = {read=FY, write=FY};
	__property Gtclasses::TWideStrings* Lines = {read=FLines, write=FLines};
	__property int RotationAngle = {read=FRotationAngle, write=SetRotationAngle, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property TgtTextEffects* TextEffects = {read=FTextEffects, write=SetTextEffects};
	__property bool IsClipRect = {read=FIsClipRect, write=SetIsClipRect, default=0};
	__property Gtutils::TgtRect ClipRect = {read=FClipRect, write=SetClipRect};
	__property TgtHAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property bool IsFromMetafile = {read=FIsFromMetafile, write=FIsFromMetafile, default=0};
	__property bool IsWideString = {read=FIsWideString, write=FIsWideString, default=0};
};


class DELPHICLASS TgtTextBoxItem;
class PASCALIMPLEMENTATION TgtTextBoxItem : public TgtTextItem
{
	typedef TgtTextItem inherited;
	
private:
	double FBoxWidth;
	double FBoxHeight;
	TgtFrame* FFrame;
	TgtHAlignment FHAlign;
	TgtVAlignment FVAlign;
	Graphics::TPen* FPen;
	void __fastcall SetPen(Graphics::TPen* Value);
	void __fastcall SetFrame(const TgtFrame* Value);
	
public:
	__fastcall virtual TgtTextBoxItem(void);
	__fastcall virtual ~TgtTextBoxItem(void);
	__property double BoxWidth = {read=FBoxWidth, write=FBoxWidth};
	__property double Boxheight = {read=FBoxHeight, write=FBoxHeight};
	__property Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property TgtFrame* Frame = {read=FFrame, write=SetFrame};
	__property TgtHAlignment HAlign = {read=FHAlign, write=FHAlign, nodefault};
	__property TgtVAlignment VAlign = {read=FVAlign, write=FVAlign, nodefault};
};


class DELPHICLASS TgtImageSettings;
class PASCALIMPLEMENTATION TgtImageSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::TObject* FParent;
	bool FCenter;
	bool FAutosize;
	bool FStretch;
	bool FTransparent;
	bool FKeepAspectRatio;
	int FInclination;
	bool FIsFrame;
	TgtOutputImageFormat FOutputImageFormat;
	Graphics::TPixelFormat FImagePixelFormat;
	Jpeg::TJPEGQualityRange FJPEGQuality;
	int FSourceDPI;
	void __fastcall SetOutputImageFormat(const TgtOutputImageFormat Value);
	void __fastcall SetSourceDPI(const int Value);
	
public:
	__fastcall TgtImageSettings(System::TObject* AParent)/* overload */;
	__fastcall virtual TgtImageSettings(void)/* overload */;
	__fastcall virtual ~TgtImageSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property bool Center = {read=FCenter, write=FCenter, nodefault};
	__property bool Stretch = {read=FStretch, write=FStretch, nodefault};
	__property bool AutoSize = {read=FAutosize, write=FAutosize, nodefault};
	__property bool Transparent = {read=FTransparent, write=FTransparent, nodefault};
	__property bool KeepAspectRatio = {read=FKeepAspectRatio, write=FKeepAspectRatio, nodefault};
	__property int Inclination = {read=FInclination, write=FInclination, nodefault};
	__property bool IsFrame = {read=FIsFrame, write=FIsFrame, nodefault};
	
__published:
	__property int SourceDPI = {read=FSourceDPI, write=SetSourceDPI, nodefault};
	__property TgtOutputImageFormat OutputImageFormat = {read=FOutputImageFormat, write=SetOutputImageFormat, nodefault};
	__property Graphics::TPixelFormat ImagePixelFormat = {read=FImagePixelFormat, write=FImagePixelFormat, default=6};
	__property Jpeg::TJPEGQualityRange JPEGQuality = {read=FJPEGQuality, write=FJPEGQuality, default=100};
};


class DELPHICLASS TgtImageItem;
class PASCALIMPLEMENTATION TgtImageItem : public TgtDocumentItem
{
	typedef TgtDocumentItem inherited;
	
private:
	double FX;
	double FY;
	double FWidth;
	double FHeight;
	int FIndexNo;
	TgtFrame* FFrame;
	Graphics::TPen* FPen;
	Graphics::TBrush* FBrush;
	TgtImageSettings* FSettings;
	Gtutils::TgtRect FDisplayRect;
	void __fastcall SetPen(Graphics::TPen* Value);
	void __fastcall SetSettings(TgtImageSettings* Value);
	void __fastcall SetFrame(const TgtFrame* Value);
	void __fastcall SetBrush(const Graphics::TBrush* Value);
	
public:
	__fastcall TgtImageItem(void)/* overload */;
	__fastcall TgtImageItem(const Gtutils::TgtRect &AImageRect)/* overload */;
	__fastcall virtual ~TgtImageItem(void);
	__property double X = {read=FX, write=FX};
	__property double Y = {read=FY, write=FY};
	__property double Width = {read=FWidth, write=FWidth};
	__property double Height = {read=FHeight, write=FHeight};
	__property Gtutils::TgtRect DisplayRect = {read=FDisplayRect, write=FDisplayRect};
	__property int IndexNo = {read=FIndexNo, write=FIndexNo, nodefault};
	__property TgtFrame* Frame = {read=FFrame, write=SetFrame};
	__property Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property TgtImageSettings* Settings = {read=FSettings, write=SetSettings};
};


class DELPHICLASS TgtImageStream;
class PASCALIMPLEMENTATION TgtImageStream : public TgtImageItem
{
	typedef TgtImageItem inherited;
	
private:
	Classes::TStream* FStream;
	int FImageWidth;
	int FImageHeight;
	
public:
	__fastcall TgtImageStream(void)/* overload */;
	__fastcall TgtImageStream(const Gtutils::TgtRect &AImageRect)/* overload */;
	__fastcall virtual ~TgtImageStream(void);
	__property Classes::TStream* Stream = {read=FStream, write=FStream};
	__property int ImageHeight = {read=FImageHeight, write=FImageHeight, nodefault};
	__property int ImageWidth = {read=FImageWidth, write=FImageWidth, nodefault};
};


class DELPHICLASS TgtShapeItem;
class PASCALIMPLEMENTATION TgtShapeItem : public TgtDocumentItem
{
	typedef TgtDocumentItem inherited;
	
private:
	Graphics::TBrush* FBrush;
	Graphics::TPen* FPen;
	TgtShapeType FShapeType;
	TgtPoints FPoints;
	int FNoPoints;
	TgtPenJoinStyle FPenJoinStyle;
	TgtPenCapStyle FPenCapStyle;
	void __fastcall SetPen(Graphics::TPen* Value);
	void __fastcall SetBrush(Graphics::TBrush* Value);
	
public:
	__fastcall TgtShapeItem(bool IsFill, TgtShapeType ShapeType);
	__fastcall virtual ~TgtShapeItem(void);
	TgtPoints __fastcall GetPoints(void);
	void __fastcall SetPoints(TgtPoint *Points, const int Points_Size);
	__property int NoPoints = {read=FNoPoints, write=FNoPoints, nodefault};
	__property TgtShapeType ShapeType = {read=FShapeType, write=FShapeType, nodefault};
	__property Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property TgtPenJoinStyle PenJoinStyle = {read=FPenJoinStyle, write=FPenJoinStyle, default=0};
	__property TgtPenCapStyle PenCapStyle = {read=FPenCapStyle, write=FPenCapStyle, default=0};
};


class DELPHICLASS TgtClipItem;
class PASCALIMPLEMENTATION TgtClipItem : public TgtDocumentItem
{
	typedef TgtDocumentItem inherited;
	
private:
	typedef DynamicArray<Types::TRect> _TgtClipItem__1;
	
	
private:
	Graphics::TBrush* FBrush;
	Graphics::TPen* FPen;
	bool FRestore;
	int FNoRects;
	unsigned FMode;
	void __fastcall SetPen(Graphics::TPen* Value);
	void __fastcall SetBrush(Graphics::TBrush* Value);
	
public:
	_TgtClipItem__1 FClipRects;
	__fastcall TgtClipItem(void);
	__fastcall virtual ~TgtClipItem(void);
	Types::TRect __fastcall GetRects(int Position);
	void __fastcall SetRects(int FRectNo);
	__property int NoRects = {read=FNoRects, write=FNoRects, nodefault};
	__property bool Restore = {read=FRestore, write=FRestore, nodefault};
	__property unsigned Mode = {read=FMode, write=FMode, nodefault};
	__property Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
};


class DELPHICLASS TgtEOFItem;
class PASCALIMPLEMENTATION TgtEOFItem : public TgtDocumentItem
{
	typedef TgtDocumentItem inherited;
	
private:
	bool FStatus;
	
public:
	__fastcall TgtEOFItem(void);
	__fastcall virtual ~TgtEOFItem(void);
	__property bool Status = {read=FStatus, write=FStatus, nodefault};
};


class DELPHICLASS TgtPathItem;
class PASCALIMPLEMENTATION TgtPathItem : public TgtDocumentItem
{
	typedef TgtDocumentItem inherited;
	
private:
	Graphics::TBrush* FBrush;
	Graphics::TPen* FPen;
	TgtPathOperation FPathOperation;
	unsigned FMode;
	bool FFillAlternate;
	void __fastcall SetPen(Graphics::TPen* Value);
	void __fastcall SetBrush(Graphics::TBrush* Value);
	void __fastcall SetFillAlternate(const bool Value);
	
public:
	__fastcall TgtPathItem(void);
	__fastcall virtual ~TgtPathItem(void);
	__property TgtPathOperation PathOperation = {read=FPathOperation, write=FPathOperation, nodefault};
	__property unsigned Mode = {read=FMode, write=FMode, nodefault};
	__property Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property bool FillAlternate = {read=FFillAlternate, write=SetFillAlternate, default=0};
};


class DELPHICLASS TgtPolyShapeItem;
class PASCALIMPLEMENTATION TgtPolyShapeItem : public TgtDocumentItem
{
	typedef TgtDocumentItem inherited;
	
private:
	Classes::TList* FShapes;
	bool FFillAlternate;
	void __fastcall SetFillAlternate(const bool Value);
	
public:
	__fastcall TgtPolyShapeItem(void);
	__fastcall virtual ~TgtPolyShapeItem(void);
	__property Classes::TList* Shapes = {read=FShapes};
	__property bool FillAlternate = {read=FFillAlternate, write=SetFillAlternate, default=0};
};


class DELPHICLASS TgtPolyPolygonItem;
class PASCALIMPLEMENTATION TgtPolyPolygonItem : public TgtDocumentItem
{
	typedef TgtDocumentItem inherited;
	
private:
	typedef DynamicArray<int> _TgtPolyPolygonItem__1;
	
	typedef DynamicArray<TgtPoint> _TgtPolyPolygonItem__2;
	
	
private:
	Graphics::TBrush* FBrush;
	Graphics::TPen* FPen;
	int FNoPoly;
	bool FFillAlternate;
	void __fastcall SetPen(Graphics::TPen* Value);
	void __fastcall SetBrush(Graphics::TBrush* Value);
	void __fastcall SetFillAlternate(const bool Value);
	
public:
	_TgtPolyPolygonItem__1 FNoPoints;
	_TgtPolyPolygonItem__2 FPoints;
	__fastcall TgtPolyPolygonItem(void);
	__fastcall virtual ~TgtPolyPolygonItem(void);
	TgtPoint __fastcall GetPoints(int Position);
	void __fastcall SetPoints(void);
	void __fastcall SetNoPoints(void);
	__property int NoPoly = {read=FNoPoly, write=FNoPoly, nodefault};
	__property Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property bool FillAlternate = {read=FFillAlternate, write=SetFillAlternate, default=0};
};


class DELPHICLASS TgtPolyDrawItem;
class PASCALIMPLEMENTATION TgtPolyDrawItem : public TgtDocumentItem
{
	typedef TgtDocumentItem inherited;
	
private:
	typedef DynamicArray<System::Byte> _TgtPolyDrawItem__1;
	
	typedef DynamicArray<TgtPoint> _TgtPolyDrawItem__2;
	
	
private:
	Graphics::TBrush* FBrush;
	Graphics::TPen* FPen;
	void __fastcall SetPen(Graphics::TPen* Value);
	void __fastcall SetBrush(Graphics::TBrush* Value);
	
public:
	int FNoPoints;
	_TgtPolyDrawItem__1 FOperations;
	_TgtPolyDrawItem__2 FPoints;
	__fastcall TgtPolyDrawItem(void);
	__fastcall virtual ~TgtPolyDrawItem(void);
	void __fastcall SetPoints(void);
	__property Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
};


class DELPHICLASS TgtBorder;
class PASCALIMPLEMENTATION TgtBorder : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FDrawBottom;
	bool FDrawLeft;
	bool FDrawTop;
	bool FDrawRight;
	int FWidth;
	Graphics::TColor FColor;
	Graphics::TPenStyle FStyle;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetDrawBottom(const bool Value);
	void __fastcall SetDrawLeft(const bool Value);
	void __fastcall SetDrawRight(const bool Value);
	void __fastcall SetDrawTop(const bool Value);
	void __fastcall SetStyle(const Graphics::TPenStyle Value);
	void __fastcall SetWidth(const int Value);
	
public:
	__fastcall TgtBorder(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool DrawLeft = {read=FDrawLeft, write=SetDrawLeft, default=0};
	__property bool DrawRight = {read=FDrawRight, write=SetDrawRight, default=0};
	__property bool DrawTop = {read=FDrawTop, write=SetDrawTop, default=0};
	__property bool DrawBottom = {read=FDrawBottom, write=SetDrawBottom, default=0};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=0};
	__property Graphics::TPenStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property int Width = {read=FWidth, write=SetWidth, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TgtBorder(void) { }
	
};


class DELPHICLASS TgtParaBorder;
class PASCALIMPLEMENTATION TgtParaBorder : public TgtBorder
{
	typedef TgtBorder inherited;
	
private:
	int FSpaceFromText;
	void __fastcall SetSpaceFromText(const int Value);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property int SpaceFromText = {read=FSpaceFromText, write=SetSpaceFromText, nodefault};
public:
	/* TgtBorder.Create */ inline __fastcall TgtParaBorder(void) : TgtBorder() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TgtParaBorder(void) { }
	
};


class DELPHICLASS TgtTextFormatting;
class PASCALIMPLEMENTATION TgtTextFormatting : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	double FBeforeSpace;
	double FLeftIndent;
	double FRightIndent;
	double FFirstLineIndent;
	double FLineSpacing;
	TgtHAlignment FAlignment;
	double FNativeFactor;
	TgtParaBorder* FBorder;
	void __fastcall SetBeforeSpace(const double Value);
	void __fastcall SetFirstLineIndent(const double Value);
	void __fastcall SetLeftIndent(const double Value);
	void __fastcall SetRightIndent(const double Value);
	double __fastcall GetBeforeSpace(void);
	double __fastcall GetFirstLineIndent(void);
	double __fastcall GetLeftIndent(void);
	double __fastcall GetRightIndent(void);
	void __fastcall SetBorder(const TgtParaBorder* Value);
	
public:
	__fastcall TgtTextFormatting(void);
	__fastcall virtual ~TgtTextFormatting(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property double BeforeSpace = {read=GetBeforeSpace, write=SetBeforeSpace};
	__property double LeftIndent = {read=GetLeftIndent, write=SetLeftIndent};
	__property double RightIndent = {read=GetRightIndent, write=SetRightIndent};
	__property double FirstLineIndent = {read=GetFirstLineIndent, write=SetFirstLineIndent};
	__property double LineSpacing = {read=FLineSpacing, write=FLineSpacing};
	__property TgtHAlignment Alignment = {read=FAlignment, write=FAlignment, nodefault};
	__property TgtParaBorder* Border = {read=FBorder, write=SetBorder};
};


class DELPHICLASS TgtParagraphItem;
class PASCALIMPLEMENTATION TgtParagraphItem : public TgtDocumentItem
{
	typedef TgtDocumentItem inherited;
	
private:
	double FX;
	double FY;
	double FWidth;
	double FHeight;
	Graphics::TFont* FFont;
	Graphics::TBrush* FBrush;
	Gtclasses::TWideStrings* FLines;
	TgtTextFormatting* FSettings;
	TgtTextEffects* FTextEffects;
	void __fastcall SetFont(Graphics::TFont* Value);
	void __fastcall SetBrush(Graphics::TBrush* Value);
	void __fastcall SetSettings(TgtTextFormatting* Value);
	void __fastcall SetTextEffects(const TgtTextEffects* Value);
	
public:
	__fastcall TgtParagraphItem(void);
	__fastcall virtual ~TgtParagraphItem(void);
	__property double X = {read=FX, write=FX};
	__property double Y = {read=FY, write=FY};
	__property double Width = {read=FWidth, write=FWidth};
	__property double Height = {read=FHeight, write=FHeight};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property TgtTextEffects* TextEffects = {read=FTextEffects, write=SetTextEffects};
	__property Gtclasses::TWideStrings* Lines = {read=FLines, write=FLines};
	__property TgtTextFormatting* Settings = {read=FSettings, write=SetSettings};
};


class DELPHICLASS TgtTableSettings;
class PASCALIMPLEMENTATION TgtTableSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	double FColumnWidth;
	double FRowHeight;
	Gtutils::TgtRect FInternalMargin;
	bool FAutoAdjustColumnWidth;
	bool FEnableTitle;
	double FTitleHeight;
	double FNativeFactor;
	void __fastcall SetColumnWidth(const double Value);
	void __fastcall SetInternalMargin(const Gtutils::TgtRect &Value);
	void __fastcall SetRowHeight(const double Value);
	void __fastcall SetTitleHeight(const double Value);
	double __fastcall GetColumnWidth(void);
	Gtutils::TgtRect __fastcall GetInternalMargin(void);
	double __fastcall GetRowHeight(void);
	double __fastcall GetTitleHeight(void);
	
public:
	__fastcall TgtTableSettings(void);
	__fastcall virtual ~TgtTableSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property double ColumnWidth = {read=GetColumnWidth, write=SetColumnWidth};
	__property double RowHeight = {read=GetRowHeight, write=SetRowHeight};
	__property Gtutils::TgtRect InternalMargin = {read=GetInternalMargin, write=SetInternalMargin};
	__property bool AutoAdjustColumnWidth = {read=FAutoAdjustColumnWidth, write=FAutoAdjustColumnWidth, default=0};
	__property bool EnableTitle = {read=FEnableTitle, write=FEnableTitle, default=1};
	__property double TitleHeight = {read=GetTitleHeight, write=SetTitleHeight};
};


class DELPHICLASS TgtColumn;
class PASCALIMPLEMENTATION TgtColumn : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	double FWidth;
	TgtHAlignment FAlignment;
	System::WideString FTitle;
	TgtOnChangeValue FOnchange;
	void __fastcall SetWidth(const double Value);
	
public:
	__fastcall TgtColumn(void);
	__property double Width = {read=FWidth, write=SetWidth};
	__property TgtHAlignment Alignment = {read=FAlignment, write=FAlignment, nodefault};
	__property System::WideString Title = {read=FTitle, write=FTitle};
	__property TgtOnChangeValue Onchange = {read=FOnchange, write=FOnchange};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TgtColumn(void) { }
	
};


class DELPHICLASS TgtTableItem;
class PASCALIMPLEMENTATION TgtTableItem : public TgtDocumentItem
{
	typedef TgtDocumentItem inherited;
	
private:
	TgtCustomDocumentEngine* FParent;
	double FX;
	double FY;
	int FRowCount;
	int FColCount;
	Graphics::TFont* FFont;
	Graphics::TBrush* FBrush;
	Graphics::TPen* FPen;
	Classes::TList* FRowHeights;
	Classes::TList* FColumns;
	Classes::TList* FRowItemsList;
	TgtTableSettings* FSettings;
	double FMaxWidth;
	double FMaxHeight;
	TgtTextEffects* FTextEffects;
	void __fastcall ChangeValue(double &AValue);
	void __fastcall SetBrush(Graphics::TBrush* Value);
	void __fastcall SetPen(Graphics::TPen* Value);
	void __fastcall SetFont(Graphics::TFont* Value);
	void __fastcall SetColumns(int Index, TgtColumn* Value);
	void __fastcall SetSettings(TgtTableSettings* Value);
	void __fastcall SetRowItemsList(int Index, const Classes::TList* Value);
	TgtColumn* __fastcall GetColumns(int Index);
	Classes::TList* __fastcall GetRowItemsList(int Index);
	void __fastcall SetTextEffects(const TgtTextEffects* Value);
	
public:
	__fastcall TgtTableItem(int NoColumns, TgtCustomDocumentEngine* AParent);
	__fastcall virtual ~TgtTableItem(void);
	Classes::TList* __fastcall GetColumnsList(void);
	double __fastcall CalculateRowHeight(void);
	__property double X = {read=FX, write=FX};
	__property double Y = {read=FY, write=FY};
	__property double MaxWidth = {read=FMaxWidth, write=FMaxWidth};
	__property double MaxHeight = {read=FMaxHeight, write=FMaxHeight};
	__property int RowCount = {read=FRowCount, write=FRowCount, nodefault};
	__property int ColCount = {read=FColCount, nodefault};
	__property Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property Graphics::TPen* Pen = {read=FPen, write=SetPen};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TgtTextEffects* TextEffects = {read=FTextEffects, write=SetTextEffects};
	__property Classes::TList* RowHeights = {read=FRowHeights, write=FRowHeights};
	__property TgtColumn* Columns[int Index] = {read=GetColumns, write=SetColumns};
	__property Classes::TList* RowItemsList[int Index] = {read=GetRowItemsList, write=SetRowItemsList};
	__property TgtTableSettings* Settings = {read=FSettings, write=SetSettings};
};


class PASCALIMPLEMENTATION TgtFrame : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::TObject* FParent;
	bool FIsLeft;
	bool FIsRight;
	bool FIsTop;
	bool FIsBottom;
	Gtutils::TgtRect FInternalMargin;
	void __fastcall SetInternalMargin(const Gtutils::TgtRect &Value);
	Gtutils::TgtRect __fastcall GetInternalMargin(void);
	
public:
	__fastcall TgtFrame(System::TObject* AParent);
	__fastcall virtual ~TgtFrame(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property bool IsLeft = {read=FIsLeft, write=FIsLeft, default=1};
	__property bool IsTop = {read=FIsTop, write=FIsTop, default=1};
	__property bool IsRight = {read=FIsRight, write=FIsRight, default=1};
	__property bool IsBottom = {read=FIsBottom, write=FIsBottom, default=1};
	__property Gtutils::TgtRect InternalMargin = {read=GetInternalMargin, write=SetInternalMargin};
};


class DELPHICLASS TgtPageSettings;
class PASCALIMPLEMENTATION TgtPageSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	double FFooterHeight;
	double FWidth;
	double FBottomMargin;
	double FTopMargin;
	double FHeight;
	double FRightMargin;
	double FLeftMargin;
	double FHeaderHeight;
	TgtPaperSize FPaperSize;
	Printers::TPrinterOrientation FOrientation;
	int FBinNumber;
	System::TObject* FParent;
	double FNativeFactor;
	void __fastcall SetBottomMargin(const double Value);
	void __fastcall SetFooterHeight(const double Value);
	void __fastcall SetHeaderHeight(const double Value);
	void __fastcall SetHeight(const double Value);
	void __fastcall SetLeftMargin(const double Value);
	void __fastcall SetOrientation(const Printers::TPrinterOrientation Value);
	void __fastcall SetPaperSize(const TgtPaperSize Value);
	void __fastcall SetRightMargin(const double Value);
	void __fastcall SetTopMargin(const double Value);
	void __fastcall SetWidth(const double Value);
	int __fastcall GetBinNumber(void);
	void __fastcall SetBinNumber(int Value);
	double __fastcall GetBottomMargin(void);
	double __fastcall GetFooterHeight(void);
	double __fastcall GetHeaderHeight(void);
	double __fastcall GetHeight(void);
	double __fastcall GetLeftMargin(void);
	double __fastcall GetRightMargin(void);
	double __fastcall GetTopMargin(void);
	double __fastcall GetWidth(void);
	
public:
	__fastcall TgtPageSettings(System::TObject* AParent);
	__fastcall virtual ~TgtPageSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TgtPaperSize PaperSize = {read=FPaperSize, write=SetPaperSize, default=8};
	__property double Width = {read=GetWidth, write=SetWidth};
	__property double Height = {read=GetHeight, write=SetHeight};
	__property Printers::TPrinterOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property double LeftMargin = {read=GetLeftMargin, write=SetLeftMargin};
	__property double RightMargin = {read=GetRightMargin, write=SetRightMargin};
	__property double TopMargin = {read=GetTopMargin, write=SetTopMargin};
	__property double BottomMargin = {read=GetBottomMargin, write=SetBottomMargin};
	__property int BinNumber = {read=GetBinNumber, write=SetBinNumber, nodefault};
	__property double HeaderHeight = {read=GetHeaderHeight, write=SetHeaderHeight};
	__property double FooterHeight = {read=GetFooterHeight, write=SetFooterHeight};
};


class PASCALIMPLEMENTATION TgtEMailSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FHost;
	System::UnicodeString FUserID;
	System::UnicodeString FPassword;
	Classes::TStringList* FAttachments;
	Classes::TStringList* FBody;
	System::TDateTime FDate;
	System::UnicodeString FFromAddress;
	System::UnicodeString FFromName;
	System::UnicodeString FReplyTo;
	System::UnicodeString FSubject;
	Classes::TStringList* FRecipientList;
	System::UnicodeString FReceiptRecipient;
	Classes::TStringList* FCCList;
	Classes::TStringList* FBCCList;
	bool FAuthenticationRequired;
	int FPort;
	void __fastcall SetRecipientList(const Classes::TStringList* Value);
	void __fastcall SetAttachments(const Classes::TStringList* Value);
	void __fastcall SetBCCList(const Classes::TStringList* Value);
	void __fastcall SetBody(const Classes::TStringList* Value);
	void __fastcall SetCCList(const Classes::TStringList* Value);
	
public:
	__fastcall TgtEMailSettings(void);
	__fastcall virtual ~TgtEMailSettings(void);
	TgtEMailSettings* __fastcall Clone(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Classes::TStringList* Attachments = {read=FAttachments, write=SetAttachments};
	__property Classes::TStringList* Body = {read=FBody, write=SetBody};
	__property Classes::TStringList* RecipientList = {read=FRecipientList, write=SetRecipientList};
	__property System::UnicodeString ReceiptRecipient = {read=FReceiptRecipient, write=FReceiptRecipient};
	__property Classes::TStringList* CCList = {read=FCCList, write=SetCCList};
	__property Classes::TStringList* BCCList = {read=FBCCList, write=SetBCCList};
	__property System::UnicodeString ReplyTo = {read=FReplyTo, write=FReplyTo};
	__property System::UnicodeString Host = {read=FHost, write=FHost};
	__property System::UnicodeString UserID = {read=FUserID, write=FUserID};
	__property System::UnicodeString Password = {read=FPassword, write=FPassword};
	__property bool AuthenticationRequired = {read=FAuthenticationRequired, write=FAuthenticationRequired, nodefault};
	__property System::TDateTime Date = {read=FDate, write=FDate};
	__property System::UnicodeString FromAddress = {read=FFromAddress, write=FFromAddress};
	__property System::UnicodeString FromName = {read=FFromName, write=FFromName};
	__property System::UnicodeString Subject = {read=FSubject, write=FSubject};
	__property int Port = {read=FPort, write=FPort, default=25};
};


typedef TMetaClass* TgtPreferencesClass;

class DELPHICLASS TgtPreferences;
class DELPHICLASS TgtDocSettings;
class PASCALIMPLEMENTATION TgtPreferences : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TgtDocSettings* FParent;
	bool FProcessAfterEachPage;
	bool FOutputToUserStream;
	bool FOpenAfterCreate;
	bool FEmailAfterCreate;
	bool FShowSetupDialog;
	bool FCalculateVariables;
	bool FUseImagesAsResources;
	void __fastcall SetEmailAfterCreate(const bool Value);
	void __fastcall SetOpenAfterCreate(const bool Value);
	void __fastcall SetOutputToUserStream(const bool Value);
	void __fastcall SetProcessAfterEachPage(const bool Value);
	void __fastcall SetShowSetupDialog(const bool Value);
	void __fastcall SetCalculateVariables(const bool Value);
	void __fastcall SetUseImagesAsResources(const bool Value);
	
public:
	__fastcall virtual TgtPreferences(void)/* overload */;
	__fastcall TgtPreferences(TgtDocSettings* AParent)/* overload */;
	__fastcall virtual ~TgtPreferences(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool OpenAfterCreate = {read=FOpenAfterCreate, write=SetOpenAfterCreate, default=1};
	__property bool EmailAfterCreate = {read=FEmailAfterCreate, write=SetEmailAfterCreate, default=0};
	__property bool OutputToUserStream = {read=FOutputToUserStream, write=SetOutputToUserStream, default=0};
	__property bool ProcessAfterEachPage = {read=FProcessAfterEachPage, write=SetProcessAfterEachPage, default=0};
	__property bool ShowSetupDialog = {read=FShowSetupDialog, write=SetShowSetupDialog, default=1};
	__property bool CalculateVariables = {read=FCalculateVariables, write=SetCalculateVariables, default=1};
	__property bool UseImagesAsResources = {read=FUseImagesAsResources, write=SetUseImagesAsResources, default=1};
};


class DELPHICLASS TgtDocInfo;
class PASCALIMPLEMENTATION TgtDocInfo : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TgtDocSettings* FParent;
	System::WideString FCreator;
	System::WideString FTitle;
	System::WideString FKeywords;
	System::WideString FAuthor;
	System::WideString FSubject;
	void __fastcall SetAuthor(const System::WideString Value);
	void __fastcall SetCreator(const System::WideString Value);
	void __fastcall SetKeywords(const System::WideString Value);
	void __fastcall SetSubject(const System::WideString Value);
	void __fastcall SetTitle(const System::WideString Value);
	
public:
	__fastcall TgtDocInfo(TgtDocSettings* AParent);
	__fastcall virtual ~TgtDocInfo(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::WideString Author = {read=FAuthor, write=SetAuthor};
	__property System::WideString Subject = {read=FSubject, write=SetSubject};
	__property System::WideString Creator = {read=FCreator, write=SetCreator};
	__property System::WideString Title = {read=FTitle, write=SetTitle};
	__property System::WideString Keywords = {read=FKeywords, write=SetKeywords};
};


class DELPHICLASS TgtBandItem;
class PASCALIMPLEMENTATION TgtBandItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Classes::TList* FDocumentItems;
	Classes::TList* FTextItems;
	double FOffsetY;
	
public:
	__fastcall TgtBandItem(void);
	__fastcall virtual ~TgtBandItem(void);
};


class DELPHICLASS TgtPageItem;
class PASCALIMPLEMENTATION TgtPageItem : public TgtBandItem
{
	typedef TgtBandItem inherited;
	
private:
	TgtCustomDocumentEngine* FParent;
	TgtPageSettings* FSettings;
	void __fastcall SetSettings(TgtPageSettings* Value);
	
public:
	__fastcall TgtPageItem(TgtCustomDocumentEngine* AParent);
	__fastcall virtual ~TgtPageItem(void);
	__property TgtPageSettings* Settings = {read=FSettings, write=SetSettings};
};


class DELPHICLASS TgtEngineState;
class PASCALIMPLEMENTATION TgtEngineState : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Graphics::TFont* FFont;
	Graphics::TPen* FPen;
	Graphics::TBrush* FBrush;
	TgtImageSettings* FImageSettings;
	TgtTextFormatting* FTextFormatting;
	TgtTableSettings* FTableSettings;
	TgtPageSettings* FPage;
	TgtTextEffects* FTextEffects;
	
public:
	__fastcall TgtEngineState(void);
	__fastcall virtual ~TgtEngineState(void);
};


__interface IgtDocumentSettings;
typedef System::DelphiInterface<IgtDocumentSettings> _di_IgtDocumentSettings;
__interface IgtDocumentSettings  : public System::IInterface 
{
	
public:
	virtual Graphics::TColor __fastcall GetBackgroundColor(void) = 0 ;
	virtual Graphics::TPicture* __fastcall GetBackgroundImage(void) = 0 ;
	virtual TgtBackgroundDisplayType __fastcall GetBackgroundDisplayType(void) = 0 ;
	virtual Graphics::TBrush* __fastcall GetBrush(void) = 0 ;
	virtual Graphics::TFont* __fastcall GetDefaultFont(void) = 0 ;
	virtual System::UnicodeString __fastcall GetFileDescription(void) = 0 ;
	virtual TgtDocInfo* __fastcall GetDocInfo(void) = 0 ;
	virtual System::UnicodeString __fastcall GetFileExtension(void) = 0 ;
	virtual System::UnicodeString __fastcall GetFileName(void) = 0 ;
	virtual Graphics::TFont* __fastcall GetFont(void) = 0 ;
	virtual TgtFrame* __fastcall GetFrame(void) = 0 ;
	virtual TgtImageSettings* __fastcall GetImageSettings(void) = 0 ;
	virtual TgtPageSettings* __fastcall GetPage(void) = 0 ;
	virtual TgtBorder* __fastcall GetPageBorder(void) = 0 ;
	virtual Graphics::TPen* __fastcall GetPen(void) = 0 ;
	virtual TgtPreferences* __fastcall GetPreferences(void) = 0 ;
	virtual TgtTableSettings* __fastcall GetTableSettings(void) = 0 ;
	virtual TgtTextFormatting* __fastcall GetTextFormatting(void) = 0 ;
	virtual void __fastcall SetBackgroundColor(const Graphics::TColor Value) = 0 ;
	virtual void __fastcall SetBackgroundImage(const Graphics::TPicture* Value) = 0 ;
	virtual void __fastcall SetBackgroundDisplayType(const TgtBackgroundDisplayType Value) = 0 ;
	virtual void __fastcall SetBrush(const Graphics::TBrush* Value) = 0 ;
	virtual void __fastcall SetDefaultFont(const Graphics::TFont* Value) = 0 ;
	virtual void __fastcall SetFileDescription(const System::UnicodeString Value) = 0 ;
	virtual void __fastcall SetDocInfo(const TgtDocInfo* Value) = 0 ;
	virtual void __fastcall SetFileExtension(const System::UnicodeString Value) = 0 ;
	virtual void __fastcall SetFileName(const System::UnicodeString Value) = 0 ;
	virtual void __fastcall SetFont(const Graphics::TFont* Value) = 0 ;
	virtual void __fastcall SetFrame(const TgtFrame* Value) = 0 ;
	virtual void __fastcall SetImageSettings(const TgtImageSettings* Value) = 0 ;
	virtual void __fastcall SetPage(const TgtPageSettings* Value) = 0 ;
	virtual void __fastcall SetPageBorder(const TgtBorder* Value) = 0 ;
	virtual void __fastcall SetPen(const Graphics::TPen* Value) = 0 ;
	virtual void __fastcall SetPreferences(const TgtPreferences* Value) = 0 ;
	virtual void __fastcall SetTableSettings(const TgtTableSettings* Value) = 0 ;
	virtual void __fastcall SetTextFormatting(const TgtTextFormatting* Value) = 0 ;
	__property System::UnicodeString FileName = {read=GetFileName, write=SetFileName};
	__property Graphics::TFont* Font = {read=GetFont, write=SetFont};
	__property Graphics::TPen* Pen = {read=GetPen, write=SetPen};
	__property Graphics::TBrush* Brush = {read=GetBrush, write=SetBrush};
	__property TgtFrame* Frame = {read=GetFrame, write=SetFrame};
	__property Graphics::TFont* DefaultFont = {read=GetDefaultFont, write=SetDefaultFont};
	__property Graphics::TColor BackgroundColor = {read=GetBackgroundColor, write=SetBackgroundColor};
	__property Graphics::TPicture* BackgroundImage = {read=GetBackgroundImage, write=SetBackgroundImage};
	__property TgtBackgroundDisplayType BackgroundImageDisplayType = {read=GetBackgroundDisplayType, write=SetBackgroundDisplayType};
	__property TgtTextFormatting* TextFormatting = {read=GetTextFormatting, write=SetTextFormatting};
	__property TgtImageSettings* ImageSettings = {read=GetImageSettings, write=SetImageSettings};
	__property TgtTableSettings* TableSettings = {read=GetTableSettings, write=SetTableSettings};
	__property TgtPreferences* Preferences = {read=GetPreferences, write=SetPreferences};
	__property TgtPageSettings* Page = {read=GetPage, write=SetPage};
	__property TgtBorder* PageBorder = {read=GetPageBorder, write=SetPageBorder};
	__property System::UnicodeString FileExtension = {read=GetFileExtension, write=SetFileExtension};
	__property System::UnicodeString FileDescription = {read=GetFileDescription, write=SetFileDescription};
	__property TgtDocInfo* DocInfo = {read=GetDocInfo, write=SetDocInfo};
};

__interface IgtDocumentEngine;
typedef System::DelphiInterface<IgtDocumentEngine> _di_IgtDocumentEngine;
__interface IgtDocumentEngine  : public IgtDocumentSettings 
{
	
public:
	virtual void __fastcall BeginDoc(void) = 0 ;
	virtual void __fastcall EndDoc(void) = 0 ;
	virtual void __fastcall NewPage(void) = 0 ;
	virtual void __fastcall HTMLTextOut(double X, double Y, System::WideString HTMLStr) = 0 ;
	virtual void __fastcall TextOutV(double X, double Y, System::WideString Text, bool TopDown = true) = 0 ;
	virtual void __fastcall TextOut(double X, double Y, System::WideString Text) = 0 /* overload */;
	virtual void __fastcall TextOut(int ColumnNo, System::WideString Text) = 0 /* overload */;
	virtual double __fastcall TextOut(System::WideString Text) = 0 /* overload */;
	virtual void __fastcall TextRect(const Gtutils::TgtRect &Rect, double X, double Y, System::WideString Text) = 0 ;
	virtual void __fastcall DrawRichText(Comctrls::TRichEdit* RichEdit, double ALeft, double ATop, double ARight, double ABottom, int StartPos, int EndPos, Graphics::TColor BackgroundColor) = 0 /* overload */;
	virtual void __fastcall ExportRichText(System::UnicodeString FilePath, double ALeft, double ATop, double ARight, double ABottom, int StartPos, int EndPos, Graphics::TColor BackgroundColor) = 0 /* overload */;
	virtual void __fastcall ExportRichText(Classes::TStream* FileStream, double ALeft, double ATop, double ARight, double ABottom, int StartPos, int EndPos, Graphics::TColor BackgroundColor) = 0 /* overload */;
	virtual void __fastcall TextBox(const Gtutils::TgtRect &TextRect, System::WideString Text, TgtHAlignment HAlignment, TgtVAlignment VAlignment) = 0 ;
	virtual void __fastcall SetTextRotation(int Angle) = 0 ;
	virtual void __fastcall SetTextAlignment(TgtHAlignment Alignment) = 0 ;
	virtual void __fastcall DrawJPEGDirect(const Gtutils::TgtRect &ARect, int AImagePixelWidth, int AImagePixelHeight, Classes::TStream* AStream) = 0 /* overload */;
	virtual void __fastcall DrawJPEGDirect(const Gtutils::TgtRect &ImageRect, Graphics::TGraphic* AGraphic) = 0 /* overload */;
	virtual void __fastcall DrawImage(double X, double Y, Graphics::TGraphic* AGraphic) = 0 /* overload */;
	virtual void __fastcall DrawImage(const Gtutils::TgtRect &ImageRect, Graphics::TGraphic* AGraphic) = 0 /* overload */;
	virtual void __fastcall DrawImage(const Gtutils::TgtRect &ImageRect, int Index) = 0 /* overload */;
	virtual void __fastcall DrawImage(int ColumnNo, double Width, double Height, Graphics::TGraphic* AGraphic) = 0 /* overload */;
	virtual int __fastcall AddImageAsResource(Graphics::TGraphic* AGraphic) = 0 ;
	virtual void __fastcall Line(double X1, double Y1, double X2, double Y2) = 0 ;
	virtual void __fastcall Rectangle(double X1, double Y1, double X2, double Y2, bool IsFill) = 0 ;
	virtual void __fastcall RoundRect(double X1, double Y1, double X2, double Y2, double X3, double Y3, bool IsFill) = 0 ;
	virtual void __fastcall Ellipse(double X1, double Y1, double X2, double Y2, bool IsFill) = 0 ;
	virtual void __fastcall Polygon(TgtPoint *Points, const int Points_Size, bool IsFill) = 0 ;
	virtual void __fastcall PolyLine(TgtPoint *Points, const int Points_Size) = 0 ;
	virtual void __fastcall Arc(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4) = 0 ;
	virtual void __fastcall Pie(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4, bool IsFill) = 0 ;
	virtual void __fastcall Chord(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4, bool IsFill) = 0 ;
	virtual void __fastcall PolyBezier(TgtPoint *Points, const int Points_Size) = 0 ;
	virtual void __fastcall BeginPara(void) = 0 ;
	virtual void __fastcall EndPara(void) = 0 ;
	virtual Classes::TList* __fastcall BeginTable(double X, double Y, int NoColumns) = 0 ;
	virtual double __fastcall NewRow(double Height) = 0 /* overload */;
	virtual double __fastcall NewRow(void) = 0 /* overload */;
	virtual void __fastcall EndTable(void) = 0 ;
	virtual void __fastcall PlayMetafile(Graphics::TMetafile* Metafile) = 0 /* overload */;
	virtual void __fastcall PlayMetafile(const Gtutils::TgtRect &DestRect, Graphics::TMetafile* Metafile) = 0 /* overload */;
	virtual void __fastcall PlayMetafile(double X, double Y, Graphics::TMetafile* Metafile) = 0 /* overload */;
	virtual void __fastcall BeginHeader(void) = 0 ;
	virtual void __fastcall EndHeader(void) = 0 ;
	virtual void __fastcall ClearHeader(void) = 0 ;
	virtual void __fastcall BeginFooter(void) = 0 ;
	virtual void __fastcall EndFooter(void) = 0 ;
	virtual void __fastcall ClearFooter(void) = 0 ;
	virtual void __fastcall BeginWaterMark(void) = 0 ;
	virtual void __fastcall EndWaterMark(void) = 0 ;
	virtual void __fastcall ClearWaterMark(void) = 0 ;
	virtual void __fastcall BeginStamp(void) = 0 ;
	virtual void __fastcall EndStamp(void) = 0 ;
	virtual void __fastcall ClearStamp(void) = 0 ;
	virtual int __fastcall SaveEngineState(void) = 0 ;
	virtual void __fastcall RestoreEngineState(int Index) = 0 ;
	virtual void __fastcall ClearEngineStates(void) = 0 ;
	virtual void __fastcall SetWorkingPage(int PageNo) = 0 ;
	virtual tagSIZE __fastcall TextSize(const System::WideString Text, Graphics::TFont* AFont) = 0 /* overload */;
	virtual tagSIZE __fastcall TextSize(const System::AnsiString Text, Graphics::TFont* AFont) = 0 /* overload */;
};

class DELPHICLASS TgtBaseDlg;
class PASCALIMPLEMENTATION TgtCustomDocumentEngine : public Gtclasses::TgtComponent
{
	typedef Gtclasses::TgtComponent inherited;
	
private:
	typedef DynamicArray<TgtParagraphItem*> _TgtCustomDocumentEngine__1;
	
	typedef DynamicArray<bool> _TgtCustomDocumentEngine__2;
	
	typedef DynamicArray<bool> _TgtCustomDocumentEngine__3;
	
	typedef DynamicArray<int> _TgtCustomDocumentEngine__4;
	
	typedef DynamicArray<DynamicArray<int> > _TgtCustomDocumentEngine__5;
	
	
private:
	Classes::TList* FPages;
	int FTextRotationAngle;
	TgtHAlignment FTextAlignment;
	Gtutils::TgtRect FBandRect;
	int FCurrentPage;
	int FPageCount;
	int FDefaultState;
	double FNativeConversionFactor;
	TgtBandItem* FHeaderItem;
	TgtBandItem* FFooterItem;
	TgtBandItem* FWatermarkItem;
	TgtBandItem* FStampItem;
	Classes::TList* FEngineStateList;
	Classes::TList* FCurrentDocumentItemList;
	Classes::TList* FCurrentTextItemList;
	double FCurrentOffsetY;
	Graphics::TFont* FFont;
	Graphics::TBrush* FBrush;
	TgtTextEffects* FTextEffects;
	Graphics::TPen* FPen;
	TgtFrame* FFrame;
	Graphics::TMetafileCanvas* FCanvas;
	Graphics::TMetafile* FMetafile;
	TgtTextItem* FTextItem;
	TgtImageItem* FImageItem;
	TgtImageStream* FImageStream;
	TgtShapeItem* FShapeItem;
	TgtParagraphItem* FParagraphItem;
	_TgtCustomDocumentEngine__1 FParaItem;
	TgtImageSettings* FImageSettings;
	TgtTextFormatting* FTextFormatting;
	TgtTableSettings* FTableSettings;
	TgtPreferences* FPreferences;
	System::UnicodeString FFileName;
	TgtUnitType FMeasurementUnit;
	Classes::TStream* FUserStream;
	System::UnicodeString FDescription;
	System::UnicodeString FFileExtension;
	TgtDocInfo* FDocInfo;
	TgtPageSettings* FPage;
	TgtBorder* FPageBorder;
	TgtCapabilities FCapabilities;
	Graphics::TFont* FDefaultFont;
	Graphics::TColor FBackgroundColor;
	TgtBackgroundDisplayType FBackgroundDisplayType;
	Graphics::TPicture* FBackgroundImage;
	TgtItemsToRender FItemsToRender;
	System::UnicodeString FPagesToRender;
	TgtDocSettings* FSettings;
	Classes::TStringList* FEngineFileNames;
	TgtEngineStatus FEngineStatus;
	TgtBaseDlg* FSetupDialog;
	TgtReferencePoint FReferencePoint;
	int FInputXRes;
	int FInputYRes;
	bool FAbortCreation;
	TgtOnNeedFileNameEvent FOnNeedFileName;
	TgtOnCellDrawEvent FOnCellDraw;
	TgtNotifyEvent FOnBeforeEndDoc;
	TgtNotifyEvent FOnAfterEndDoc;
	TgtNotifyEvent FOnBeforeBeginDoc;
	TgtNotifyEvent FOnAfterBeginDoc;
	TgtNotifyEvent FOnBeforeEndPage;
	TgtNotifyEvent FOnAfterEndPage;
	TgtNotifyEvent FOnBeforeBeginPage;
	TgtNotifyEvent FOnAfterBeginPage;
	TgtErrorMessageEvent FOnErrorMessage;
	TgtOnCalcVariablesEvent FOnCalcVariables;
	System::UnicodeString __fastcall GetFileName(void);
	TgtPageItem* __fastcall GetPages(int Index);
	Graphics::TColor __fastcall GetBackgroundColor(void);
	TgtBackgroundDisplayType __fastcall GetBackgroundDisplayType(void);
	Graphics::TPicture* __fastcall GetBackgroundImage(void);
	Graphics::TBrush* __fastcall GetBrush(void);
	Graphics::TMetafileCanvas* __fastcall GetCanvas(void);
	int __fastcall GetCurrentPage(void);
	Graphics::TFont* __fastcall GetDefaultFont(void);
	System::UnicodeString __fastcall GetFileDescription(void);
	TgtDocInfo* __fastcall GetDocInfo(void);
	System::UnicodeString __fastcall GetFileExtension(void);
	Graphics::TFont* __fastcall GetFont(void);
	TgtFrame* __fastcall GetFrame(void);
	TgtImageSettings* __fastcall GetImageSettings(void);
	TgtUnitType __fastcall GetMeasurementUnit(void);
	TgtPageSettings* __fastcall GetPage(void);
	TgtBorder* __fastcall GetPageBorder(void);
	TgtTextFormatting* __fastcall GetTextFormatting(void);
	Graphics::TPen* __fastcall GetPen(void);
	TgtPreferences* __fastcall GetPreferences(void);
	TgtTableSettings* __fastcall GetTableSettings(void);
	Classes::TStream* __fastcall GetUserStream(void);
	void __fastcall SetBackgroundColor(const Graphics::TColor Value);
	void __fastcall SetBackgroundDisplayType(const TgtBackgroundDisplayType Value);
	void __fastcall SetBackgroundImage(const Graphics::TPicture* Value);
	void __fastcall SetBrush(const Graphics::TBrush* Value);
	void __fastcall SetCanvas(const Graphics::TMetafileCanvas* Value);
	void __fastcall SetDefaultFont(const Graphics::TFont* Value);
	void __fastcall SetFileDescription(const System::UnicodeString Value);
	void __fastcall SetDocInfo(const TgtDocInfo* Value);
	void __fastcall SetEngineFileNames(const Classes::TStringList* Value);
	void __fastcall SetFileName(const System::UnicodeString Value);
	void __fastcall SetFrame(const TgtFrame* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetFileExtension(const System::UnicodeString Value);
	void __fastcall SetImageSettings(const TgtImageSettings* Value);
	void __fastcall SetItemsToRender(const TgtItemsToRender Value);
	void __fastcall SetMeasurementUnit(const TgtUnitType Value);
	void __fastcall SetPen(const Graphics::TPen* Value);
	void __fastcall SetPreferences(const TgtPreferences* Value);
	void __fastcall SetPage(const TgtPageSettings* Value);
	void __fastcall SetPagesToRender(const System::UnicodeString Value);
	void __fastcall SetSettings(const TgtDocSettings* Value);
	void __fastcall SetSetupDialog(const TgtBaseDlg* Value);
	void __fastcall SetTextFormatting(const TgtTextFormatting* Value);
	void __fastcall SetTableSettings(const TgtTableSettings* Value);
	void __fastcall SetUserStream(const Classes::TStream* Value);
	void __fastcall SetOnCellDraw(const TgtOnCellDrawEvent Value);
	void __fastcall SetOnCalcVariables(const TgtOnCalcVariablesEvent Value);
	void __fastcall SetBandType(const TgtBandType Value);
	void __fastcall SetReferencePoint(const TgtReferencePoint Value);
	void __fastcall SetInputXRes(const int Value);
	void __fastcall SetInputYRes(const int Value);
	void __fastcall SetAbortCreation(const bool Value);
	void __fastcall SetPageBorder(const TgtBorder* Value);
	void __fastcall SetTextEffects(const TgtTextEffects* Value);
	void __fastcall ClipShapeCoordinates(TgtPoints Points, int NoPoints);
	void __fastcall CalculateBandRect(void);
	void __fastcall CreateImageItem(const Gtutils::TgtRect &ImageRect, int Index);
	void __fastcall FreeItemsList(Classes::TList* AList);
	void __fastcall FreeJpegImageResource(void);
	void __fastcall FreeImageResourceList(void);
	bool __fastcall IsDocumentItemInRange(double X, double Y);
	bool __fastcall IsPageInRange(int APageNo);
	void __fastcall ProcessItemsList(Classes::TList* AList);
	void __fastcall ProcessPage(void);
	void __fastcall ProcessTextRect(TgtTextItem* ATextItem, TgtHAlignment HAlign, TgtVAlignment VAlign, double MaxWidth, double MaxHeight, const Gtutils::TgtRect &Margin);
	void __fastcall InitializeEngine(void);
	void __fastcall FinalizeEngine(void);
	
protected:
	bool FNoSorting;
	TgtTableItem* FTableItem;
	bool FIsDocumentStarted;
	bool FIsTableStarted;
	bool FIsParagraphStarted;
	_TgtCustomDocumentEngine__2 FIsParaStarted;
	_TgtCustomDocumentEngine__3 TableOnLastpage;
	_TgtCustomDocumentEngine__5 RowsOnPage;
	int FTablenumber;
	bool FSortTextItems;
	Classes::TList* FImageResourceList;
	TgtBandType FBandType;
	double FYFactor;
	bool FIsAutoPaginate;
	TgtPenJoinStyle FPenJoin;
	TgtPenCapStyle FPenCap;
	virtual void __fastcall BeginDoc(void);
	virtual void __fastcall EndDoc(void);
	virtual void __fastcall NewPage(void);
	void __fastcall SetAutoPaginate(const bool Value);
	virtual void __fastcall HTMLTextOut(double X, double Y, System::WideString HTMLStr);
	virtual void __fastcall TextOutV(double X, double Y, System::WideString Text, bool TopDown = true);
	virtual void __fastcall TextOut(double X, double Y, System::WideString Text)/* overload */;
	virtual void __fastcall TextOut(int ColumnNo, System::WideString Text)/* overload */;
	virtual double __fastcall TextOut(System::WideString Text)/* overload */;
	virtual void __fastcall TextRect(const Gtutils::TgtRect &Rect, double X, double Y, System::WideString Text);
	virtual void __fastcall TextBox(const Gtutils::TgtRect &TextRect, System::WideString Text, TgtHAlignment HAlignment, TgtVAlignment VAlignment);
	virtual void __fastcall SetTextRotation(int Angle);
	virtual void __fastcall SetTextAlignment(TgtHAlignment Alignment);
	virtual void __fastcall DrawJPEGDirect(const Gtutils::TgtRect &ARect, int AImagePixelWidth, int AImagePixelHeight, Classes::TStream* AStream)/* overload */;
	virtual void __fastcall DrawJPEGDirect(const Gtutils::TgtRect &ImageRect, Graphics::TGraphic* AGraphic)/* overload */;
	virtual void __fastcall DrawImage(double X, double Y, Graphics::TGraphic* AGraphic)/* overload */;
	virtual void __fastcall DrawImage(const Gtutils::TgtRect &ImageRect, Graphics::TGraphic* AGraphic)/* overload */;
	virtual void __fastcall DrawImage(const Gtutils::TgtRect &ImageRect, int Index)/* overload */;
	virtual void __fastcall DrawImage(int ColumnNo, double Width, double Height, Graphics::TGraphic* AGraphic)/* overload */;
	virtual int __fastcall AddImageAsResource(Graphics::TGraphic* AGraphic)/* overload */;
	virtual int __fastcall AddImageAsResource(Graphics::TGraphic* AGraphic, bool AResource)/* overload */;
	virtual void __fastcall Line(double X1, double Y1, double X2, double Y2);
	virtual void __fastcall Rectangle(double X1, double Y1, double X2, double Y2, bool IsFill);
	virtual void __fastcall RoundRect(double X1, double Y1, double X2, double Y2, double X3, double Y3, bool IsFill);
	virtual void __fastcall Ellipse(double X1, double Y1, double X2, double Y2, bool IsFill);
	virtual void __fastcall Polygon(TgtPoint *Points, const int Points_Size, bool IsFill);
	virtual void __fastcall PolyLine(TgtPoint *Points, const int Points_Size);
	virtual void __fastcall Arc(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4);
	virtual void __fastcall Pie(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4, bool IsFill);
	virtual void __fastcall Chord(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4, bool IsFill);
	virtual void __fastcall PolyBezier(TgtPoint *Points, const int Points_Size);
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
	tagSIZE __fastcall TextSize(const System::WideString Text, Graphics::TFont* AFont)/* overload */;
	tagSIZE __fastcall TextSize(const System::AnsiString Text, Graphics::TFont* AFont)/* overload */;
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall EncodeText(TgtTextItem* AObject);
	virtual void __fastcall EncodeTextBox(TgtTextBoxItem* AObject);
	virtual void __fastcall EncodeParagraph(TgtParagraphItem* AObject);
	virtual void __fastcall EncodeImage(TgtImageItem* AObject);
	virtual void __fastcall EncodeImageStream(TgtImageStream* ImgStream);
	virtual void __fastcall EncodeTable(TgtTableItem* AObject);
	virtual void __fastcall EncodeCustomItem(TgtDocumentItem* AObject);
	void __fastcall EncodeShape(TgtShapeItem* AObject);
	virtual void __fastcall EncodeClipRect(TgtClipItem* AObject);
	virtual void __fastcall EncodePathItem(TgtPathItem* AObject);
	void __fastcall EncodePolyShape(TgtPolyShapeItem* AObject);
	virtual void __fastcall EncodePolyPolygon(TgtPolyPolygonItem* AObject);
	virtual void __fastcall EncodeEOF(TgtEOFItem* AObject);
	virtual void __fastcall EncodePolyDraw(TgtPolyDrawItem* AObject);
	virtual void __fastcall EncodeLine(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen);
	virtual void __fastcall EncodeRect(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeRoundRect(double X1, double Y1, double X2, double Y2, double X3, double Y3, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeEllipse(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodePolyLine(TgtPoints Points, int NoPoints, bool IsClosed, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodePolyPolyline(TgtPolyShapeItem* AObject, bool IsClosed);
	virtual void __fastcall EncodeArc(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4, Graphics::TPen* Pen);
	virtual void __fastcall EncodePie(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeChord(double X1, double Y1, double X2, double Y2, double X3, double Y3, double X4, double Y4, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodePolyBezier(TgtPoints Points, int NoPoints, Graphics::TPen* Pen);
	virtual void __fastcall EncodeShapeBitmap(double X, double Y, Graphics::TBitmap* Bitmap);
	virtual void __fastcall EncodePageBorder(void);
	Graphics::TBitmap* __fastcall GetImageAsBitmap(TgtImageItem* AImageObject);
	Graphics::TMetafile* __fastcall GetImageAsMetafile(TgtImageItem* AImageObject, bool SupportsStretch = false, bool AutoFormat = true);
	Classes::TStream* __fastcall GetBitmapAsJPGGIFStream(Graphics::TBitmap* ABitmap, bool IsJPEG, int JPEGQuality);
	Classes::TStream* __fastcall GetBitmapAsPNGStream(Graphics::TBitmap* ABitmap, Graphics::TColor ATransColor);
	Graphics::TBitmap* __fastcall GetRotatedTextBitmap(TgtTextItem* ATextObject);
	int __fastcall WrapTextIntoLines(System::UnicodeString Text, double Width, double FirstLineWidth, Classes::TStringList* Lines, bool AutoResize, Graphics::TFont* AFont)/* overload */;
	int __fastcall WrapTextIntoLines(System::WideString Text, double Width, double FirstLineWidth, Gtclasses::TWideStrings* Lines, bool AutoResize, Graphics::TFont* AFont)/* overload */;
	virtual System::WideString __fastcall ReplacePlaceHolders(System::WideString AText, bool AReplacePageInfo);
	virtual System::WideString __fastcall ReplacePageInfo(System::WideString AText);
	System::UnicodeString __fastcall GetHyperLinkText(System::UnicodeString AText, int &AStartPos);
	void __fastcall BreakParagraphIntoText(void);
	Graphics::TGraphic* __fastcall GetGraphicResource(int Index);
	Gtutils::TgtRect __fastcall NativeRect(const Gtutils::TgtRect &ARect);
	double __fastcall NativeXPos(double AX);
	double __fastcall NativeYPos(double AY);
	virtual void __fastcall ProcessTextList(Classes::TList* AList);
	virtual void __fastcall ProcessMetafile(double AX, double AY, Graphics::TMetafile* AMetafile);
	virtual void __fastcall AdjustTextItemList(Classes::TList* AList);
	void __fastcall AddDocumentItem(TgtDocumentItem* AItem);
	Classes::TStream* __fastcall CreateFile(System::UnicodeString AFileName);
	void __fastcall CancelCreate(void);
	virtual bool __fastcall CheckOutputImageFormat(TgtOutputImageFormat Value, System::UnicodeString &S);
	virtual System::Word __fastcall ShowSetupModal(void);
	virtual TgtPreferencesClass __fastcall GetPreferencesClassName(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual System::WideString __fastcall R2LString(System::WideString OriginalStr);
	__property TgtPageItem* Pages[int Index] = {read=GetPages};
	__property TgtCapabilities Capabilities = {read=FCapabilities, write=FCapabilities, nodefault};
	__property Classes::TList* CurrentTextItemList = {read=FCurrentTextItemList, write=FCurrentTextItemList};
	__property Classes::TList* CurrentDocumentItemList = {read=FCurrentDocumentItemList, write=FCurrentDocumentItemList};
	__property Classes::TStringList* EngineFileNames = {read=FEngineFileNames, write=SetEngineFileNames};
	__property TgtBandType BandType = {read=FBandType, write=SetBandType, nodefault};
	__property Gtutils::TgtRect BandRect = {read=FBandRect};
	__property double NativeConversionFactor = {read=FNativeConversionFactor};
	__property System::UnicodeString FileName = {read=GetFileName, write=SetFileName};
	__property Graphics::TFont* DefaultFont = {read=GetDefaultFont, write=SetDefaultFont};
	__property Graphics::TFont* Font = {read=GetFont, write=SetFont};
	__property Graphics::TPen* Pen = {read=GetPen, write=SetPen};
	__property Graphics::TBrush* Brush = {read=GetBrush, write=SetBrush};
	__property TgtTextEffects* TextEffects = {read=FTextEffects, write=SetTextEffects};
	__property TgtFrame* Frame = {read=GetFrame, write=SetFrame};
	__property TgtPageSettings* Page = {read=GetPage, write=SetPage};
	__property TgtBorder* PageBorder = {read=GetPageBorder, write=SetPageBorder};
	__property TgtDocInfo* DocInfo = {read=GetDocInfo, write=SetDocInfo};
	__property TgtTextFormatting* TextFormatting = {read=GetTextFormatting, write=SetTextFormatting};
	__property TgtImageSettings* ImageSettings = {read=GetImageSettings, write=SetImageSettings};
	__property TgtTableSettings* TableSettings = {read=GetTableSettings, write=SetTableSettings};
	__property TgtPreferences* Preferences = {read=GetPreferences, write=SetPreferences};
	__property Graphics::TColor BackgroundColor = {read=GetBackgroundColor, write=SetBackgroundColor, default=16777215};
	__property Graphics::TPicture* BackgroundImage = {read=GetBackgroundImage, write=SetBackgroundImage};
	__property TgtBackgroundDisplayType BackgroundImageDisplayType = {read=GetBackgroundDisplayType, write=SetBackgroundDisplayType, default=5};
	__property TgtOnNeedFileNameEvent OnNeedFileName = {read=FOnNeedFileName, write=FOnNeedFileName};
	
public:
	__fastcall virtual TgtCustomDocumentEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtCustomDocumentEngine(void);
	void __fastcall DrawRichText(Comctrls::TRichEdit* RichEdit, double ALeft, double ATop, double ARight, double ABottom, int StartPos, int EndPos, Graphics::TColor BackgroundColor)/* overload */;
	void __fastcall ExportRichText(System::UnicodeString FilePath, double ALeft, double ATop, double ARight, double ABottom, int StartPos, int EndPos, Graphics::TColor BackgroundColor)/* overload */;
	void __fastcall ExportRichText(Classes::TStream* FileStream, double ALeft, double ATop, double ARight, double ABottom, int StartPos, int EndPos, Graphics::TColor BackgroundColor)/* overload */;
	double __fastcall TextWidth(System::WideString Text)/* overload */;
	double __fastcall TextHeight(System::WideString Text)/* overload */;
	__property Graphics::TMetafileCanvas* Canvas = {read=GetCanvas, write=SetCanvas};
	__property Classes::TStream* UserStream = {read=GetUserStream, write=SetUserStream};
	__property int CurrentPage = {read=GetCurrentPage, nodefault};
	__property int PageCount = {read=FPageCount, nodefault};
	__property bool AbortCreation = {read=FAbortCreation, write=SetAbortCreation, default=0};
	__property TgtEngineStatus EngineStatus = {read=FEngineStatus, nodefault};
	
__published:
	__property System::UnicodeString FileExtension = {read=GetFileExtension, write=SetFileExtension};
	__property System::UnicodeString FileDescription = {read=GetFileDescription, write=SetFileDescription};
	__property int InputXRes = {read=FInputXRes, write=SetInputXRes, nodefault};
	__property int InputYRes = {read=FInputYRes, write=SetInputYRes, nodefault};
	__property TgtItemsToRender ItemsToRender = {read=FItemsToRender, write=SetItemsToRender, default=7};
	__property System::UnicodeString PagesToRender = {read=FPagesToRender, write=SetPagesToRender};
	__property TgtUnitType MeasurementUnit = {read=GetMeasurementUnit, write=SetMeasurementUnit, default=1};
	__property TgtReferencePoint ReferencePoint = {read=FReferencePoint, write=SetReferencePoint, nodefault};
	__property TgtBaseDlg* SetupDialog = {read=FSetupDialog, write=SetSetupDialog};
	__property TgtDocSettings* Settings = {read=FSettings, write=SetSettings};
	__property bool AutoPaginate = {read=FIsAutoPaginate, write=SetAutoPaginate, default=1};
	__property TgtNotifyEvent OnBeforeBeginDoc = {read=FOnBeforeBeginDoc, write=FOnBeforeBeginDoc};
	__property TgtNotifyEvent OnAfterBeginDoc = {read=FOnAfterBeginDoc, write=FOnAfterBeginDoc};
	__property TgtNotifyEvent OnBeforeEndDoc = {read=FOnBeforeEndDoc, write=FOnBeforeEndDoc};
	__property TgtNotifyEvent OnAfterEndDoc = {read=FOnAfterEndDoc, write=FOnAfterEndDoc};
	__property TgtNotifyEvent OnBeforeBeginPage = {read=FOnBeforeBeginPage, write=FOnBeforeBeginPage};
	__property TgtNotifyEvent OnAfterBeginPage = {read=FOnAfterBeginPage, write=FOnAfterBeginPage};
	__property TgtNotifyEvent OnBeforeEndPage = {read=FOnBeforeEndPage, write=FOnBeforeEndPage};
	__property TgtNotifyEvent OnAfterEndPage = {read=FOnAfterEndPage, write=FOnAfterEndPage};
	__property TgtErrorMessageEvent OnErrorMessage = {read=FOnErrorMessage, write=FOnErrorMessage};
	__property TgtOnCellDrawEvent OnCellDraw = {read=FOnCellDraw, write=SetOnCellDraw};
	__property TgtOnCalcVariablesEvent OnCalcVariables = {read=FOnCalcVariables, write=SetOnCalcVariables};
private:
	void *__IgtDocumentEngine;	/* IgtDocumentEngine */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator _di_IgtDocumentEngine()
	{
		_di_IgtDocumentEngine intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IgtDocumentEngine*(void) { return (IgtDocumentEngine*)&__IgtDocumentEngine; }
	#endif
	
};


class PASCALIMPLEMENTATION TgtBaseDlg : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	TgtCustomDocumentEngine* FEngine;
	void __fastcall SetEngine(const TgtCustomDocumentEngine* Value);
	
public:
	__fastcall virtual TgtBaseDlg(Classes::TComponent* AOwner);
	__property TgtCustomDocumentEngine* Engine = {read=FEngine, write=SetEngine};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtBaseDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtBaseDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TgtBaseDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TgtDocSettings : public Gtclasses::TgtComponent
{
	typedef Gtclasses::TgtComponent inherited;
	
private:
	Classes::TList* FEngineList;
	Graphics::TColor FBackgroundColor;
	TgtBackgroundDisplayType FBackgroundDisplayType;
	TgtDocInfo* FDocInfo;
	TgtPreferences* FPreferences;
	Graphics::TPicture* FBackgroundImage;
	TgtPageSettings* FPage;
	TgtUnitType FMeasurementUnit;
	double FNativeConversionFactor;
	void __fastcall SetBackgroundColor(const Graphics::TColor Value);
	void __fastcall SetBackgroundDisplayType(const TgtBackgroundDisplayType Value);
	void __fastcall SetBackgroundImage(const Graphics::TPicture* Value);
	void __fastcall SetMeasurementUnit(const TgtUnitType Value);
	void __fastcall AddEngineToList(TgtCustomDocumentEngine* AEngine);
	void __fastcall RemoveEngineFromList(TgtCustomDocumentEngine* AEngine);
	
public:
	__fastcall virtual TgtDocSettings(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtDocSettings(void);
	
__published:
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=SetBackgroundColor, default=16777215};
	__property Graphics::TPicture* BackgroundImage = {read=FBackgroundImage, write=SetBackgroundImage};
	__property TgtBackgroundDisplayType BackgroundImageDisplayType = {read=FBackgroundDisplayType, write=SetBackgroundDisplayType, nodefault};
	__property TgtUnitType MeasurementUnit = {read=FMeasurementUnit, write=SetMeasurementUnit, nodefault};
	__property TgtDocInfo* DocInfo = {read=FDocInfo, write=FDocInfo};
	__property TgtPageSettings* Page = {read=FPage, write=FPage};
	__property TgtPreferences* Preferences = {read=FPreferences, write=FPreferences};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE StaticArray<StaticArray<double, 2>, 41> CPaperDimensions;
#define CphPageNo L"<%Pg#%>"
#define CphTotalPages L"<%PgCnt%>"
#define CphShortDate L"<%ShortDate%>"
#define CphShortTime L"<%ShortTime%>"
#define CphLongDate L"<%LongDate%>"
#define CphLongTime L"<%LongTime%>"
#define CphAuthor L"<%Author%>"
#define CphCreator L"<%Creator%>"
#define CphSubject L"<%Subject%>"
#define CphTitle L"<%Title%>"
extern PACKAGE TgtPoint __fastcall gtPoint(double X, double Y);

}	/* namespace Gtcstdoceng */
using namespace Gtcstdoceng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtcstdocengHPP
