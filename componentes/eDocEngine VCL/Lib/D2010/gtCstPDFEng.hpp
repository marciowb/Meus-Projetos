// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtcstpdfeng.pas' rev: 21.00

#ifndef GtcstpdfengHPP
#define GtcstpdfengHPP

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
#include <Sysutils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtcstplneng.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtdocutils.hpp>	// Pascal unit
#include <Gtdzlib.hpp>	// Pascal unit
#include <Gtclasses.hpp>	// Pascal unit
#include <Gtpdffont.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtpdfcrypt.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtcstpdfeng
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TgtPDFPattern { pHorizontal, pVertical, pFDiagonal, pBDiagonal, pCross, pDCross };
#pragma option pop

#pragma option push -b-
enum TgtAnnotBrushStyle { absSolid, absDashed, absBeveled, absInset, absUnderline };
#pragma option pop

#pragma option push -b-
enum TgtPathStatus { psPathBegins, psPathEnds, psNoPath };
#pragma option pop

#pragma option push -b-
enum TgtCompressionLevel { clFastest, clNormal, clMaxCompress };
#pragma option pop

struct TgtEllipseCtrlPoints
{
	
public:
	double X1;
	double X2;
	double X3;
	double X4;
	double X5;
	double Y1;
	double Y2;
	double Y3;
	double Y4;
	double Y5;
};


#pragma option push -b-
enum TgtLineType { ltUnderline, ltStrikeOut };
#pragma option pop

#pragma option push -b-
enum TgtPDFFontEncoding { feWinAnsiEncoding, feMacRomanEncoding, feMacExpertEncoding, feStandardEncoding, fePDFDocEncoding };
#pragma option pop

#pragma option push -b-
enum TgtTransitionEffect { teNone, teSplitHorizontalInward, teSplitHorizontalOutward, teSplitVerticalInward, teSplitVerticalOutward, teBlindsHorizontal, teBlindsVertical, teBoxInward, teBoxOutward, teWipeLeftToRight, teWipeBottomToTop, teWipeRightToLeft, teWipeTopToBottom, teDissolve, teGlitterLeftToRight, teGlitterTopToBottom, teGlitterTopLeftToBottomRight };
#pragma option pop

class DELPHICLASS TgtPresentationMode;
class PASCALIMPLEMENTATION TgtPresentationMode : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FDuration;
	TgtTransitionEffect FTransitionEffect;
	
public:
	__fastcall TgtPresentationMode(void);
	__fastcall virtual ~TgtPresentationMode(void);
	
__published:
	__property int Duration = {read=FDuration, write=FDuration, default=1};
	__property TgtTransitionEffect TransitionEffect = {read=FTransitionEffect, write=FTransitionEffect, default=0};
};


#pragma option push -b-
enum TgtPageLayout { plSinglePage, plOneColumn, plTwoColumnLeft, plTwoColumnRight };
#pragma option pop

#pragma option push -b-
enum TgtPageMode { pmUseNone, pmUseOutlines, pmUseThumbs, pmFullScreen };
#pragma option pop

#pragma option push -b-
enum TgtNonFullScreenPageMode { nfspmUseNone, nfspmUseOutlines, nfspmUseThumbs };
#pragma option pop

class DELPHICLASS TgtViewerPreferences;
class PASCALIMPLEMENTATION TgtViewerPreferences : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TgtPageLayout FPageLayout;
	TgtPageMode FPageMode;
	bool FHideToolBar;
	bool FHideMenuBar;
	bool FHideWindowUI;
	bool FFitWindow;
	bool FCenterWindow;
	TgtNonFullScreenPageMode FNonFullScreenPageMode;
	TgtPresentationMode* FPresentationMode;
	void __fastcall SetPresentationMode(TgtPresentationMode* AValue);
	void __fastcall SetCenterWindow(const bool Value);
	void __fastcall SetFitWindow(const bool Value);
	void __fastcall SetHideMenuBar(const bool Value);
	void __fastcall SetHideToolBar(const bool Value);
	void __fastcall SetHideWindowUI(const bool Value);
	void __fastcall SetNonFullScreenPageMode(const TgtNonFullScreenPageMode Value);
	void __fastcall SetPageLayout(const TgtPageLayout Value);
	void __fastcall SetPageMode(const TgtPageMode Value);
	
public:
	__fastcall TgtViewerPreferences(void);
	__fastcall virtual ~TgtViewerPreferences(void);
	System::UnicodeString __fastcall GetViewerPreferences(TgtPageMode APageMode, TgtPageLayout APageLayout, bool ACenterWindow, bool AFitWindow, bool AHideWindowUI, bool AHideMenuBar, bool AHideToolBar, TgtNonFullScreenPageMode ANonFullScreenPageMode);
	System::UnicodeString __fastcall GetTransitionEffectAndDuration(int ADuration, TgtTransitionEffect ATransitionEffect);
	
__published:
	__property TgtPageLayout PageLayout = {read=FPageLayout, write=SetPageLayout, default=1};
	__property TgtPageMode PageMode = {read=FPageMode, write=SetPageMode, default=0};
	__property bool HideToolBar = {read=FHideToolBar, write=SetHideToolBar, default=0};
	__property bool HideMenuBar = {read=FHideMenuBar, write=SetHideMenuBar, default=0};
	__property bool HideWindowUI = {read=FHideWindowUI, write=SetHideWindowUI, default=0};
	__property bool FitWindow = {read=FFitWindow, write=SetFitWindow, default=0};
	__property bool CenterWindow = {read=FCenterWindow, write=SetCenterWindow, default=0};
	__property TgtNonFullScreenPageMode NonFullScreenPageMode = {read=FNonFullScreenPageMode, write=SetNonFullScreenPageMode, default=0};
	__property TgtPresentationMode* PresentationMode = {read=FPresentationMode, write=SetPresentationMode};
};


class DELPHICLASS TgtPDFThumbnailItem;
class PASCALIMPLEMENTATION TgtPDFThumbnailItem : public Gtcstdoceng::TgtDocumentItem
{
	typedef Gtcstdoceng::TgtDocumentItem inherited;
	
private:
	Gtcstdoceng::TgtOutputImageFormat FOutputImageFormat;
	Graphics::TPixelFormat FImagePixelFormat;
	int FJPEGQuality;
	int FIndexNo;
	int FObjNo;
	void __fastcall SetImagePixelFormat(const Graphics::TPixelFormat Value);
	void __fastcall SetIndexNo(const int Value);
	void __fastcall SetJPEGQuality(const int Value);
	void __fastcall SetOutputImageFormat(const Gtcstdoceng::TgtOutputImageFormat Value);
	void __fastcall SetObjNo(const int Value);
	
public:
	__fastcall TgtPDFThumbnailItem(void);
	__fastcall virtual ~TgtPDFThumbnailItem(void);
	__property Gtcstdoceng::TgtOutputImageFormat OutputImageFormat = {read=FOutputImageFormat, write=SetOutputImageFormat, nodefault};
	__property Graphics::TPixelFormat ImagePixelFormat = {read=FImagePixelFormat, write=SetImagePixelFormat, nodefault};
	__property int JPEGQuality = {read=FJPEGQuality, write=SetJPEGQuality, nodefault};
	__property int IndexNo = {read=FIndexNo, write=SetIndexNo, nodefault};
	__property int ObjNo = {read=FObjNo, write=SetObjNo, nodefault};
	bool __fastcall IsEqual(TgtPDFThumbnailItem* AThumbnail);
};


class DELPHICLASS TgtPDFImageSettings;
class PASCALIMPLEMENTATION TgtPDFImageSettings : public Gtcstdoceng::TgtImageSettings
{
	typedef Gtcstdoceng::TgtImageSettings inherited;
	
private:
	int FObjNo;
	double FImageWidth;
	double FImageHeight;
	double FDisplayWidth;
	double FDisplayHeight;
	void __fastcall SetObjNo(const int Value);
	void __fastcall SetDisplayHeight(const double Value);
	void __fastcall SetDisplayWidth(const double Value);
	void __fastcall SetImageHeight(const double Value);
	void __fastcall SetImageWidth(const double Value);
	
public:
	__fastcall virtual TgtPDFImageSettings(void)/* overload */;
	__fastcall virtual ~TgtPDFImageSettings(void);
	bool __fastcall IsEqual(Gtcstdoceng::TgtImageItem* AObject, int AOriginalWidth, int AOriginalHeight);
	__property int ObjNo = {read=FObjNo, write=SetObjNo, nodefault};
	__property double ImageWidth = {read=FImageWidth, write=SetImageWidth};
	__property double ImageHeight = {read=FImageHeight, write=SetImageHeight};
	__property double DisplayWidth = {read=FDisplayWidth, write=SetDisplayWidth};
	__property double DisplayHeight = {read=FDisplayHeight, write=SetDisplayHeight};
};


#pragma option push -b-
enum TgtTTFontEmbedding { etfNone, etfFull, etfSubset };
#pragma option pop

class DELPHICLASS TgtPDFPreferences;
class PASCALIMPLEMENTATION TgtPDFPreferences : public Gtcstplneng::TgtPlainSheetPreferences
{
	typedef Gtcstplneng::TgtPlainSheetPreferences inherited;
	
private:
	TgtTTFontEmbedding FEmbedTrueTypeFonts;
	void __fastcall SetEmbedTrueTypeFonts(const TgtTTFontEmbedding Value);
	
public:
	__fastcall virtual TgtPDFPreferences(void)/* overload */;
	__fastcall virtual ~TgtPDFPreferences(void);
	
__published:
	__property TgtTTFontEmbedding EmbedTrueTypeFonts = {read=FEmbedTrueTypeFonts, write=SetEmbedTrueTypeFonts, default=0};
};


class DELPHICLASS TgtPageInfo;
class PASCALIMPLEMENTATION TgtPageInfo : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FObjNo;
	double FWidth;
	double FHeight;
	void __fastcall SetHeight(const double Value);
	void __fastcall SetObjNo(const int Value);
	void __fastcall SetWidth(const double Value);
	
public:
	__property int ObjNo = {read=FObjNo, write=SetObjNo, nodefault};
	__property double Width = {read=FWidth, write=SetWidth};
	__property double Height = {read=FHeight, write=SetHeight};
public:
	/* TObject.Create */ inline __fastcall TgtPageInfo(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TgtPageInfo(void) { }
	
};


class DELPHICLASS TgtCompression;
class PASCALIMPLEMENTATION TgtCompression : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FEnabled;
	TgtCompressionLevel FLevel;
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetLevel(const TgtCompressionLevel Value);
	
public:
	__fastcall TgtCompression(void);
	__fastcall virtual ~TgtCompression(void);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property TgtCompressionLevel Level = {read=FLevel, write=SetLevel, default=2};
};


class DELPHICLASS TgtCustomPDFEngine;
class PASCALIMPLEMENTATION TgtCustomPDFEngine : public Gtcstplneng::TgtCustomPlainsheetEngine
{
	typedef Gtcstplneng::TgtCustomPlainsheetEngine inherited;
	
private:
	typedef DynamicArray<Classes::TStringList*> _TgtCustomPDFEngine__1;
	
	typedef DynamicArray<Classes::TList*> _TgtCustomPDFEngine__2;
	
	
private:
	Gtpdfcrypt::TgtPDFEncryption* FPDFEncrypt;
	int FEncryptionObjNo;
	int FOutlines;
	Classes::TStringList* FThumbnailList;
	_TgtCustomPDFEngine__1 FThumbnailReuseList;
	Classes::TMemoryStream* FContentStream;
	Classes::TStringList* FXRefTable;
	int FBGImageObj;
	System::Extended FBackgroundImageWidth;
	System::Extended FBackgroundImageHeight;
	System::Extended FBackgroundImageLeft;
	System::Extended FBackgroundImageTop;
	int FContentsObjNo;
	int FLengthObjNo;
	int FLastObjNo;
	Classes::TStringList* FImageXRefList;
	_TgtCustomPDFEngine__2 FImageSettings;
	Classes::TStream* FImageStream;
	Classes::TStringList* FPattern;
	TgtPDFFontEncoding FFontEncoding;
	Classes::TStringList* FFontEmbedExcludeList;
	TgtCompression* FCompression;
	TgtViewerPreferences* FViewerPreferences;
	Gtpdfcrypt::TgtPDFEncryptionSettings* FEncryption;
	bool FIsClipState;
	TgtPathStatus FPathStatus;
	bool FIsPathClosed;
	bool FFirstPoint;
	Gtcstdoceng::TgtPoint FInitialPos;
	System::UnicodeString FPath;
	bool FIsClipPath;
	bool FBiDi;
	void __fastcall SetFontEncoding(const TgtPDFFontEncoding Value);
	void __fastcall AppendXRef(int APos, int AObjNo);
	System::UnicodeString __fastcall CompletePDFPath(Graphics::TPen* APen, Graphics::TBrush* ABrush, bool CloseAndStroke = false);
	System::UnicodeString __fastcall DrawBorder(Gtcstdoceng::TgtImageItem* AObject);
	System::UnicodeString __fastcall EncodeImageObjectRef(System::UnicodeString AIndex, Gtcstdoceng::TgtImageItem* AObject);
	System::UnicodeString __fastcall EncodePDFArc(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4, Graphics::TPen* Pen);
	TgtEllipseCtrlPoints __fastcall GetEllipseCtrlPts(double PosX1, double PosY1, double PosX2, double PosY2);
	System::UnicodeString __fastcall GetLineStyle(Graphics::TPenStyle AStyle);
	System::UnicodeString __fastcall PDFCurveto(double X1, double Y1, double X2, double Y2, double X3, double Y3);
	System::UnicodeString __fastcall PDFShortArc(double X, double Y, double RX, double RY, double Alpha, double Beta);
	void __fastcall WriteBackground(void);
	void __fastcall WritePattern(void);
	void __fastcall WriteOutlines(void);
	void __fastcall WriteThumbnails(void);
	int __fastcall SaveImageContents(Graphics::TBitmap* ABitmap);
	void __fastcall SetFontEmbedExcludeList(const Classes::TStringList* Value);
	void __fastcall SetCompression(const TgtCompression* Value);
	HIDESBASE TgtPDFPreferences* __fastcall GetPreferences(void);
	HIDESBASE void __fastcall SetPreferences(const TgtPDFPreferences* Value);
	void __fastcall SetVeiwerPreferences(const TgtViewerPreferences* Value);
	void __fastcall SetEncryption(const Gtpdfcrypt::TgtPDFEncryptionSettings* Value);
	void __fastcall SetBiDi(const bool Value);
	System::UnicodeString __fastcall ConvertDelimiters(System::UnicodeString AString);
	
protected:
	System::UnicodeString FAnnots;
	Classes::TList* FFontTable;
	Classes::TList* FPageList;
	double FPixelToPointMultiplier;
	Classes::TStream* FOutputStream;
	System::UnicodeString FCreationTime;
	System::UnicodeString __fastcall ToUnicodeHex(System::WideString AStr, int AObjNo, int AGenNo);
	virtual void __fastcall EncodeEOF(Gtcstdoceng::TgtEOFItem* AObject);
	virtual void __fastcall EncodeText(Gtcstdoceng::TgtTextItem* AObject);
	virtual void __fastcall EncodeImage(Gtcstdoceng::TgtImageItem* AObject);
	virtual void __fastcall EncodeClipRect(Gtcstdoceng::TgtClipItem* AObject);
	virtual void __fastcall EncodePathItem(Gtcstdoceng::TgtPathItem* AObject);
	virtual void __fastcall EncodePolyDraw(Gtcstdoceng::TgtPolyDrawItem* AObject);
	virtual void __fastcall EncodeImageStream(Gtcstdoceng::TgtImageStream* ImgStream);
	virtual void __fastcall EncodeLine(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen);
	virtual void __fastcall EncodeRect(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeRoundRect(double X1, double Y1, double X2, double Y2, double X3, double Y3, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeEllipse(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodePolyLine(Gtcstdoceng::TgtPoints Points, int NoPoints, bool IsClosed, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodePolyPolyline(Gtcstdoceng::TgtPolyShapeItem* AObject, bool IsClosed);
	virtual void __fastcall EncodePolyPolygon(Gtcstdoceng::TgtPolyPolygonItem* AObject);
	virtual void __fastcall EncodeArc(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4, Graphics::TPen* Pen);
	virtual void __fastcall EncodePie(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeChord(double X1, double Y1, double X2, double y2, double X3, double Y3, double X4, double Y4, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodePolyBezier(Gtcstdoceng::TgtPoints Points, int NoPoints, Graphics::TPen* Pen);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual bool __fastcall CheckOutputImageFormat(Gtcstdoceng::TgtOutputImageFormat Value, System::UnicodeString &S);
	virtual System::Word __fastcall ShowSetupModal(void);
	virtual Gtcstdoceng::TgtPreferencesClass __fastcall GetPreferencesClassName(void);
	System::UnicodeString __fastcall GetPattern(Graphics::TBrushStyle AStyle);
	int __fastcall CompressStream(Classes::TStream* InputStream, Classes::TStream* OutputStream, bool ACompressed = true, TgtCompressionLevel ACompressionLevel = (TgtCompressionLevel)(0x2));
	System::UnicodeString __fastcall GetAnnotBrushStyle(int Width = 0x1, TgtAnnotBrushStyle Style = (TgtAnnotBrushStyle)(0x0));
	System::UnicodeString __fastcall GetImageFilter(Gtcstdoceng::TgtOutputImageFormat OutputImageFormat);
	System::UnicodeString __fastcall GetNativeText(System::UnicodeString AStr);
	System::Extended __fastcall GetNativeXPos(System::Extended X);
	System::Extended __fastcall GetNativeYPos(System::Extended Y, int PageNo);
	int __fastcall GetNewObjNo(void);
	Classes::TMemoryStream* __fastcall GetPDFBitmapStream(Graphics::TBitmap* ABitmap);
	System::UnicodeString __fastcall MakeObjHead(int AObjNo);
	System::UnicodeString __fastcall MakeObjRef(int AObjNo);
	System::UnicodeString __fastcall NumToStr(System::Extended AN);
	void __fastcall WriteObj(const System::UnicodeString AStr, int AObjNo, bool AIsObjectComplete);
	virtual System::UnicodeString __fastcall GetCatalogDictionary(void);
	virtual System::UnicodeString __fastcall GetPageDictionary(int AObjNo);
	virtual void __fastcall WriteEncryptionDictionary(void);
	virtual System::UnicodeString __fastcall GetTrailer(void);
	virtual void __fastcall WritePDFStream(Classes::TMemoryStream* &InputStream, int StreamSize, int ObjNo, int GenNo);
	virtual System::UnicodeString __fastcall WritePDFString(System::UnicodeString InputString, int ObjNo, int GenNo);
	virtual Classes::TMemoryStream* __fastcall GetBitmapAsCCITTStream(Graphics::TBitmap* ABitmap, Gtcstdoceng::TgtOutputImageFormat AFormat);
	
__published:
	__property bool BiDi = {read=FBiDi, write=SetBiDi, default=0};
	__property FileExtension;
	__property FileDescription;
	__property BackgroundColor = {default=16777215};
	__property BackgroundImage;
	__property BackgroundImageDisplayType = {default=5};
	__property TextEffects;
	__property Classes::TStringList* FontEmbedExcludeList = {read=FFontEmbedExcludeList, write=SetFontEmbedExcludeList};
	__property TgtCompression* Compression = {read=FCompression, write=SetCompression};
	__property TgtPDFPreferences* Preferences = {read=GetPreferences, write=SetPreferences};
	__property TgtViewerPreferences* ViewerPreferences = {read=FViewerPreferences, write=SetVeiwerPreferences};
	__property TgtPDFFontEncoding FontEncoding = {read=FFontEncoding, write=SetFontEncoding, nodefault};
	__property Gtpdfcrypt::TgtPDFEncryptionSettings* Encryption = {read=FEncryption, write=SetEncryption};
	
public:
	__fastcall virtual TgtCustomPDFEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtCustomPDFEngine(void);
	virtual void __fastcall BeginDoc(void);
	virtual void __fastcall EndDoc(void);
	virtual void __fastcall TextOutV(double X, double Y, System::WideString Text, bool TopDown = true);
	virtual void __fastcall DrawJPEGDirect(const Gtutils::TgtRect &ARect, int AImagePixelWidth, int AImagePixelHeight, Classes::TStream* AStream)/* overload */;
	virtual void __fastcall DrawJPEGDirect(const Gtutils::TgtRect &ImageRect, Graphics::TGraphic* AGraphic)/* overload */;
	virtual int __fastcall AddTOCItem(System::WideString Title, int ParentNode, int PageNumber, double Top)/* overload */;
	virtual int __fastcall AddTOCItem(System::WideString Title, int ParentNode, System::UnicodeString URL)/* overload */;
	void __fastcall AddThumbnailImage(Graphics::TGraphic* AGraphic, int PageNo)/* overload */;
	void __fastcall AddThumbnailImage(int Index, int PageNo)/* overload */;
};


typedef StaticArray<System::UnicodeString, 5> Gtcstpdfeng__9;

typedef StaticArray<System::UnicodeString, 7> Gtcstpdfeng__01;

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Gtcstpdfeng__9 PDFFontEncodeStrings;
extern PACKAGE Gtcstpdfeng__01 ImageFilter;

}	/* namespace Gtcstpdfeng */
using namespace Gtcstpdfeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtcstpdfengHPP
