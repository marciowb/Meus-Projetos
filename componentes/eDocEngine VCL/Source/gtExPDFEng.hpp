// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtexpdfeng.pas' rev: 10.00

#ifndef GtexpdfengHPP
#define GtexpdfengHPP

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
#include <Gtutils.hpp>	// Pascal unit
#include <Gtdocutils.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtcstplneng.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtcstpdfeng.hpp>	// Pascal unit
#include <Gtclasses.hpp>	// Pascal unit
#include <Gtpdffont.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtexpdfeng
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TgtAnnotationType { atText, atLink, atLine, atSquare, atCircle, atTextMarkup, atFreeText, atCaret };
#pragma option pop

#pragma option push -b-
enum TgtAnnotationPreferenceType { apInvisible, apHidden, apPrint, apNoZoom, apNoRotate, apNoView, apReadOnly };
#pragma option pop

typedef Set<TgtAnnotationPreferenceType, apInvisible, apReadOnly>  TgtAnnotationPreference;

#pragma option push -b-
enum TgtAnnotHighlightMode { hmNone, hmInvertContent, hmInvertBorder, hmPushed };
#pragma option pop

class DELPHICLASS TgtAnnotBrush;
class PASCALIMPLEMENTATION TgtAnnotBrush : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	int FWidth;
	Gtcstpdfeng::TgtAnnotBrushStyle FStyle;
	void __fastcall SetStyle(const Gtcstpdfeng::TgtAnnotBrushStyle Value);
	void __fastcall SetWidth(const int Value);
	
public:
	__fastcall TgtAnnotBrush(void);
	__fastcall virtual ~TgtAnnotBrush(void);
	__property Gtcstpdfeng::TgtAnnotBrushStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property int Width = {read=FWidth, write=SetWidth, default=1};
};


#pragma option push -b-
enum TgtAnnotActionType { aaGoTo, aaURI, aaNamed, aaGoToR, aaLaunch, aaJavaScript };
#pragma option pop

class DELPHICLASS TgtAnnotAction;
class PASCALIMPLEMENTATION TgtAnnotAction : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TgtAnnotActionType FSubType;
	
protected:
	__property TgtAnnotActionType SubType = {read=FSubType, nodefault};
	
public:
	__fastcall TgtAnnotAction(void);
	__fastcall virtual ~TgtAnnotAction(void);
};


#pragma option push -b-
enum TgtGoToOptions { goDefault, goFit, goFitWidth, goFitHeight, goFitRect };
#pragma option pop

typedef Shortint TgtZoom;

class DELPHICLASS TgtAnnotGoToAction;
class PASCALIMPLEMENTATION TgtAnnotGoToAction : public TgtAnnotAction 
{
	typedef TgtAnnotAction inherited;
	
private:
	int FPage;
	TgtZoom FZoom;
	TgtGoToOptions FOptions;
	Gtutils::TgtRect FRect;
	void __fastcall SetOptions(const TgtGoToOptions Value);
	void __fastcall SetPage(const int Value);
	void __fastcall SetRect(const Gtutils::TgtRect &Value);
	void __fastcall SetZoom(const TgtZoom Value);
	
public:
	__fastcall TgtAnnotGoToAction(void);
	__fastcall virtual ~TgtAnnotGoToAction(void);
	__property int Page = {read=FPage, write=SetPage, default=1};
	__property Gtutils::TgtRect Rect = {read=FRect, write=SetRect};
	__property TgtZoom Zoom = {read=FZoom, write=SetZoom, default=1};
	__property TgtGoToOptions Options = {read=FOptions, write=SetOptions, default=0};
};


class DELPHICLASS TgtAnnotLinkAction;
class PASCALIMPLEMENTATION TgtAnnotLinkAction : public TgtAnnotAction 
{
	typedef TgtAnnotAction inherited;
	
private:
	AnsiString FURI;
	void __fastcall SetURI(const AnsiString Value);
	
public:
	__fastcall TgtAnnotLinkAction(void);
	__fastcall virtual ~TgtAnnotLinkAction(void);
	__property AnsiString URI = {read=FURI, write=SetURI};
};


#pragma option push -b-
enum TgtActionName { anNextPage, anPrevPage, anFirstPage, anLastPage };
#pragma option pop

class DELPHICLASS TgtAnnotNamedAction;
class PASCALIMPLEMENTATION TgtAnnotNamedAction : public TgtAnnotAction 
{
	typedef TgtAnnotAction inherited;
	
private:
	TgtActionName FActionName;
	void __fastcall SetActionName(const TgtActionName Value);
	
public:
	__fastcall TgtAnnotNamedAction(void);
	__fastcall virtual ~TgtAnnotNamedAction(void);
	__property TgtActionName ActionName = {read=FActionName, write=SetActionName, nodefault};
};


class DELPHICLASS TgtAnnotRemoteGotoAction;
class PASCALIMPLEMENTATION TgtAnnotRemoteGotoAction : public TgtAnnotAction 
{
	typedef TgtAnnotAction inherited;
	
private:
	AnsiString FFilePath;
	int FPage;
	TgtGoToOptions FOptions;
	Gtutils::TgtRect FRect;
	TgtZoom FZoom;
	bool FNewWindow;
	void __fastcall SetFilePath(const AnsiString Value);
	void __fastcall SetOptions(const TgtGoToOptions Value);
	void __fastcall SetPage(const int Value);
	void __fastcall SetRect(const Gtutils::TgtRect &Value);
	void __fastcall SetZoom(const TgtZoom Value);
	
public:
	__fastcall TgtAnnotRemoteGotoAction(void);
	__fastcall virtual ~TgtAnnotRemoteGotoAction(void);
	__property AnsiString FilePath = {read=FFilePath, write=SetFilePath};
	__property int Page = {read=FPage, write=SetPage, default=1};
	__property Gtutils::TgtRect Rect = {read=FRect, write=SetRect};
	__property TgtZoom Zoom = {read=FZoom, write=SetZoom, default=1};
	__property TgtGoToOptions Options = {read=FOptions, write=SetOptions, default=0};
	__property bool NewWindow = {read=FNewWindow, write=FNewWindow, default=1};
};


class DELPHICLASS TgtAnnotLaunchAction;
class PASCALIMPLEMENTATION TgtAnnotLaunchAction : public TgtAnnotAction 
{
	typedef TgtAnnotAction inherited;
	
private:
	AnsiString FFilePath;
	bool FNewWindow;
	void __fastcall SetFilePath(const AnsiString Value);
	
public:
	__fastcall TgtAnnotLaunchAction(void);
	__fastcall virtual ~TgtAnnotLaunchAction(void);
	__property AnsiString FilePath = {read=FFilePath, write=SetFilePath};
	__property bool NewWindow = {read=FNewWindow, write=FNewWindow, default=1};
};


class DELPHICLASS TgtAnnotJSAction;
class PASCALIMPLEMENTATION TgtAnnotJSAction : public TgtAnnotAction 
{
	typedef TgtAnnotAction inherited;
	
private:
	AnsiString FJavaScript;
	void __fastcall SetJavaScript(const AnsiString Value);
	
public:
	__fastcall TgtAnnotJSAction(void);
	__fastcall virtual ~TgtAnnotJSAction(void);
	__property AnsiString JavaScript = {read=FJavaScript, write=SetJavaScript};
};


class DELPHICLASS TgtPDFAnnot;
class PASCALIMPLEMENTATION TgtPDFAnnot : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Gtutils::TgtRect FRect;
	TgtAnnotBrush* FBrush;
	TgtAnnotAction* FAction;
	Graphics::TColor FBackgroundColor;
	Graphics::TColor FBorderColor;
	WideString FContents;
	WideString FTitle;
	WideString FSubject;
	void __fastcall SetRect(const Gtutils::TgtRect &Value);
	void __fastcall SetBrush(const TgtAnnotBrush* Value);
	void __fastcall SetAction(const TgtAnnotAction* Value);
	void __fastcall SetBackgroundColor(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetContents(const WideString Value);
	
protected:
	int FPageNo;
	__property TgtAnnotAction* Action = {read=FAction, write=SetAction};
	__property TgtAnnotBrush* Brush = {read=FBrush, write=SetBrush};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=SetBackgroundColor, default=16777215};
	__property Gtutils::TgtRect Rect = {read=FRect, write=SetRect};
	__property WideString Contents = {read=FContents, write=SetContents};
	__property WideString Title = {read=FTitle, write=FTitle};
	__property WideString Subject = {read=FSubject, write=FSubject};
	
public:
	__fastcall TgtPDFAnnot(void);
	__fastcall virtual ~TgtPDFAnnot(void);
};


#pragma option push -b-
enum TgtTextNote { tnComment, tnKey, tnNote, tnHelp, tnNewParagraph, tnParagraph, tnInsert };
#pragma option pop

class DELPHICLASS TgtPDFTextAnnot;
class PASCALIMPLEMENTATION TgtPDFTextAnnot : public TgtPDFAnnot 
{
	typedef TgtPDFAnnot inherited;
	
private:
	TgtTextNote FName;
	bool FOpen;
	void __fastcall SetName(const TgtTextNote Value);
	void __fastcall SetOpen(const bool Value);
	
public:
	__fastcall TgtPDFTextAnnot(void);
	__fastcall virtual ~TgtPDFTextAnnot(void);
	__property TgtTextNote Name = {read=FName, write=SetName, default=2};
	__property bool Open = {read=FOpen, write=SetOpen, default=0};
	__property Rect ;
	__property BorderColor  = {default=0};
	__property Contents ;
	__property Title ;
	__property Subject ;
};


#pragma option push -b-
enum TgtAlign { taLeft, taRight, taCenter };
#pragma option pop

class DELPHICLASS TgtPDFFreeTextAnnot;
class PASCALIMPLEMENTATION TgtPDFFreeTextAnnot : public TgtPDFAnnot 
{
	typedef TgtPDFAnnot inherited;
	
private:
	Graphics::TFont* FTextFont;
	TgtAlign FTextAlign;
	Graphics::TColor FTextColor;
	void __fastcall SetTextAlign(const TgtAlign Value);
	void __fastcall SetTextFont(const Graphics::TFont* Value);
	void __fastcall SetTextColor(const Graphics::TColor Value);
	
public:
	__fastcall TgtPDFFreeTextAnnot(void);
	__fastcall virtual ~TgtPDFFreeTextAnnot(void);
	__property Graphics::TFont* TextFont = {read=FTextFont, write=SetTextFont};
	__property TgtAlign TextAlign = {read=FTextAlign, write=SetTextAlign, nodefault};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, nodefault};
	__property Rect ;
	__property Contents ;
	__property BorderColor  = {default=0};
};


class DELPHICLASS TgtPDFLinkAnnot;
class PASCALIMPLEMENTATION TgtPDFLinkAnnot : public TgtPDFAnnot 
{
	typedef TgtPDFAnnot inherited;
	
private:
	TgtAnnotHighlightMode FHighlightMode;
	Byte FBorderWidth;
	void __fastcall SetHighlightMode(const TgtAnnotHighlightMode Value);
	void __fastcall SetBorderWidth(const Byte Value);
	
public:
	__fastcall TgtPDFLinkAnnot(void);
	__fastcall virtual ~TgtPDFLinkAnnot(void);
	__property BorderColor  = {default=0};
	__property Byte BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property Action ;
	__property TgtAnnotHighlightMode HighlightMode = {read=FHighlightMode, write=SetHighlightMode, default=0};
	__property Rect ;
};


struct TgtLine
{
	
public:
	double Left;
	double Top;
	double Right;
	double Bottom;
} ;

#pragma option push -b-
enum TgtLineStyle { lsNone, lsButt, lsSquare, lsCircle, lsDiamond, lsOpenArrow, lsClosedArrow, lsROpenArrow, lsRClosedArrow };
#pragma option pop

#pragma option push -b-
enum TgtBorderStyle { brSolid, brDashed, brBeveled, brInset, brUnderline };
#pragma option pop

class DELPHICLASS TgtPDFLineAnnot;
class PASCALIMPLEMENTATION TgtPDFLineAnnot : public TgtPDFAnnot 
{
	typedef TgtPDFAnnot inherited;
	
private:
	TgtLine FLine;
	TgtLineStyle FStartStyle;
	TgtLineStyle FEndStyle;
	TgtBorderStyle FBorderStyle;
	Byte FBorderWidth;
	AnsiString FBorderPattern;
	Graphics::TColor FInteriorColor;
	void __fastcall SetBorderStyle(const TgtBorderStyle Value);
	void __fastcall SetStartStyle(const TgtLineStyle Value);
	void __fastcall SetEndStyle(const TgtLineStyle Value);
	void __fastcall SetBorderWidth(const Byte Value);
	void __fastcall SetBorderPattern(const AnsiString Value);
	void __fastcall SetLine(const TgtLine &Value);
	void __fastcall SetInteriorColor(const Graphics::TColor Value);
	
public:
	__fastcall TgtPDFLineAnnot(void);
	__fastcall virtual ~TgtPDFLineAnnot(void);
	TgtLine __fastcall gtLine(double Left, double Top, double Right, double Bottom);
	__property TgtBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property Byte BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property TgtLineStyle StartStyle = {read=FStartStyle, write=SetStartStyle, default=0};
	__property TgtLineStyle EndStyle = {read=FEndStyle, write=SetEndStyle, default=0};
	__property AnsiString BorderPattern = {read=FBorderPattern, write=SetBorderPattern};
	__property TgtLine Line = {read=FLine, write=SetLine};
	__property Graphics::TColor InteriorColor = {read=FInteriorColor, write=SetInteriorColor, default=16777215};
	__property Contents ;
	__property BorderColor  = {default=0};
	__property Title ;
	__property Subject ;
};


typedef Shortint TgtIntensity;

class DELPHICLASS TgtPDFSquareAnnot;
class PASCALIMPLEMENTATION TgtPDFSquareAnnot : public TgtPDFAnnot 
{
	typedef TgtPDFAnnot inherited;
	
private:
	Byte FBorderWidth;
	TgtBorderStyle FBorderStyle;
	AnsiString FBorderPattern;
	Graphics::TColor FInteriorColor;
	bool FCloudy;
	TgtIntensity FCloudIntensity;
	Gtutils::TgtRect FDifferRect;
	void __fastcall SetBorderStyle(const TgtBorderStyle Value);
	void __fastcall SetBorderWidth(const Byte Value);
	void __fastcall SetBorderPattern(const AnsiString Value);
	void __fastcall SetInteriorColor(const Graphics::TColor Value);
	void __fastcall SetCloudy(const bool Value);
	void __fastcall SetCloudIntensity(const TgtIntensity Value);
	void __fastcall SetDifferRect(const Gtutils::TgtRect &Value);
	
public:
	__fastcall TgtPDFSquareAnnot(void);
	__fastcall virtual ~TgtPDFSquareAnnot(void);
	__property TgtBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property Byte BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property AnsiString BorderPattern = {read=FBorderPattern, write=SetBorderPattern};
	__property Graphics::TColor InteriorColor = {read=FInteriorColor, write=SetInteriorColor, default=16777215};
	__property bool Cloudy = {read=FCloudy, write=SetCloudy, default=0};
	__property TgtIntensity CloudIntensity = {read=FCloudIntensity, write=SetCloudIntensity, default=0};
	__property Gtutils::TgtRect DifferRect = {read=FDifferRect, write=SetDifferRect};
	__property Rect ;
	__property BorderColor  = {default=0};
	__property Contents ;
	__property Title ;
	__property Subject ;
};


class DELPHICLASS TgtPDFCircleAnnot;
class PASCALIMPLEMENTATION TgtPDFCircleAnnot : public TgtPDFAnnot 
{
	typedef TgtPDFAnnot inherited;
	
private:
	Byte FBorderWidth;
	TgtBorderStyle FBorderStyle;
	AnsiString FBorderPattern;
	Graphics::TColor FInteriorColor;
	bool FCloudy;
	TgtIntensity FCloudIntensity;
	Gtutils::TgtRect FDifferRect;
	void __fastcall SetBorderStyle(const TgtBorderStyle Value);
	void __fastcall SetBorderWidth(const Byte Value);
	void __fastcall SetBorderPattern(const AnsiString Value);
	void __fastcall SetInteriorColor(const Graphics::TColor Value);
	void __fastcall SetCloudy(const bool Value);
	void __fastcall SetCloudIntensity(const TgtIntensity Value);
	void __fastcall SetDifferRect(const Gtutils::TgtRect &Value);
	
public:
	__fastcall TgtPDFCircleAnnot(void);
	__fastcall virtual ~TgtPDFCircleAnnot(void);
	__property TgtBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property Byte BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property AnsiString BorderPattern = {read=FBorderPattern, write=SetBorderPattern};
	__property Graphics::TColor InteriorColor = {read=FInteriorColor, write=SetInteriorColor, default=16777215};
	__property bool Cloudy = {read=FCloudy, write=SetCloudy, default=0};
	__property Gtutils::TgtRect DifferRect = {read=FDifferRect, write=SetDifferRect};
	__property TgtIntensity CloudIntensity = {read=FCloudIntensity, write=SetCloudIntensity, default=0};
	__property Rect ;
	__property BorderColor  = {default=0};
	__property Contents ;
	__property Title ;
	__property Subject ;
};


class DELPHICLASS TgtPDFPolygonAnnot;
class PASCALIMPLEMENTATION TgtPDFPolygonAnnot : public TgtPDFAnnot 
{
	typedef TgtPDFAnnot inherited;
	
private:
	bool FCloudy;
	Byte FBorderWidth;
	AnsiString FBorderPattern;
	Graphics::TColor FInteriorColor;
	TgtBorderStyle FBorderStyle;
	TgtIntensity FCloudIntensity;
	DynamicArray<Gtcstdoceng::TgtPoint >  FVertices;
	void __fastcall SetBorderPattern(const AnsiString Value);
	void __fastcall SetBorderStyle(const TgtBorderStyle Value);
	void __fastcall SetBorderWidth(const Byte Value);
	void __fastcall SetCloudIntensity(const TgtIntensity Value);
	void __fastcall SetCloudy(const bool Value);
	void __fastcall SetInteriorColor(const Graphics::TColor Value);
	
public:
	__fastcall TgtPDFPolygonAnnot(void);
	__fastcall virtual ~TgtPDFPolygonAnnot(void);
	void __fastcall SetVertices(Gtcstdoceng::TgtPoint const * Vertices, const int Vertices_Size);
	Gtcstdoceng::TgtPoints __fastcall GetVertices();
	__property TgtBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property Byte BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property AnsiString BorderPattern = {read=FBorderPattern, write=SetBorderPattern};
	__property Graphics::TColor InteriorColor = {read=FInteriorColor, write=SetInteriorColor, default=16777215};
	__property bool Cloudy = {read=FCloudy, write=SetCloudy, default=0};
	__property TgtIntensity CloudIntensity = {read=FCloudIntensity, write=SetCloudIntensity, default=0};
	__property Rect ;
	__property Contents ;
	__property BorderColor  = {default=0};
	__property Title ;
	__property Subject ;
};


class DELPHICLASS TgtPDFPolylineAnnot;
class PASCALIMPLEMENTATION TgtPDFPolylineAnnot : public TgtPDFAnnot 
{
	typedef TgtPDFAnnot inherited;
	
private:
	bool FCloudy;
	Byte FBorderWidth;
	AnsiString FBorderPattern;
	Graphics::TColor FInteriorColor;
	TgtBorderStyle FBorderStyle;
	TgtIntensity FCloudIntensity;
	DynamicArray<Gtcstdoceng::TgtPoint >  FVertices;
	TgtLineStyle FEndStyle;
	TgtLineStyle FStartStyle;
	void __fastcall SetBorderPattern(const AnsiString Value);
	void __fastcall SetBorderStyle(const TgtBorderStyle Value);
	void __fastcall SetBorderWidth(const Byte Value);
	void __fastcall SetCloudIntensity(const TgtIntensity Value);
	void __fastcall SetCloudy(const bool Value);
	void __fastcall SetInteriorColor(const Graphics::TColor Value);
	void __fastcall SetEndStyle(const TgtLineStyle Value);
	void __fastcall SetStartStyle(const TgtLineStyle Value);
	
public:
	__fastcall TgtPDFPolylineAnnot(void);
	__fastcall virtual ~TgtPDFPolylineAnnot(void);
	void __fastcall SetVertices(Gtcstdoceng::TgtPoint const * Vertices, const int Vertices_Size);
	__property TgtBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property Byte BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property AnsiString BorderPattern = {read=FBorderPattern, write=SetBorderPattern};
	__property Graphics::TColor InteriorColor = {read=FInteriorColor, write=SetInteriorColor, default=16777215};
	__property bool Cloudy = {read=FCloudy, write=SetCloudy, default=0};
	__property TgtIntensity CloudIntensity = {read=FCloudIntensity, write=SetCloudIntensity, default=0};
	__property TgtLineStyle StartStyle = {read=FStartStyle, write=SetStartStyle, default=0};
	__property TgtLineStyle EndStyle = {read=FEndStyle, write=SetEndStyle, default=0};
	__property Rect ;
	__property Contents ;
	__property BorderColor  = {default=0};
	__property Title ;
	__property Subject ;
};


#pragma option push -b-
enum TgtTextStyle { tsHighlight, tsUnderline, tsSquiggly, tsStrikeOut };
#pragma option pop

class DELPHICLASS TgtPDFTextMarkupAnnot;
class PASCALIMPLEMENTATION TgtPDFTextMarkupAnnot : public TgtPDFAnnot 
{
	typedef TgtPDFAnnot inherited;
	
private:
	TgtTextStyle FTextStyle;
	DynamicArray<Gtcstdoceng::TgtPoint >  FQuadPoints;
	void __fastcall SetTextStyle(const TgtTextStyle Value);
	
public:
	__fastcall TgtPDFTextMarkupAnnot(void);
	__fastcall virtual ~TgtPDFTextMarkupAnnot(void);
	void __fastcall SetQuadPoints(Gtcstdoceng::TgtPoint const * QuadPoints, const int QuadPoints_Size);
	__property TgtTextStyle TextStyle = {read=FTextStyle, write=SetTextStyle, default=0};
	__property BorderColor  = {default=0};
	__property Contents ;
	__property Title ;
	__property Subject ;
};


class DELPHICLASS TgtPDFCaretAnnot;
class PASCALIMPLEMENTATION TgtPDFCaretAnnot : public TgtPDFAnnot 
{
	typedef TgtPDFAnnot inherited;
	
private:
	bool FSymbol;
	Gtutils::TgtRect FDifferRect;
	void __fastcall SetDifferRect(const Gtutils::TgtRect &Value);
	
public:
	__fastcall TgtPDFCaretAnnot(void);
	__fastcall virtual ~TgtPDFCaretAnnot(void);
	__property Gtutils::TgtRect DifferRect = {read=FDifferRect, write=SetDifferRect};
	__property Rect ;
	__property Contents ;
	__property BorderColor  = {default=0};
	__property Title ;
	__property Subject ;
};


typedef DynamicArray<Gtcstdoceng::TgtPoint >  TgtInkPoints;

class DELPHICLASS TgtPDFInkAnnot;
class PASCALIMPLEMENTATION TgtPDFInkAnnot : public TgtPDFAnnot 
{
	typedef TgtPDFAnnot inherited;
	
private:
	DynamicArray<Gtcstdoceng::TgtPoint >  FInkPoints;
	
public:
	__fastcall TgtPDFInkAnnot(void);
	__fastcall virtual ~TgtPDFInkAnnot(void);
	void __fastcall SetInkPoints(Gtcstdoceng::TgtPoint const * InkPoints, const int InkPoints_Size);
	__property BorderColor  = {default=0};
	__property Contents ;
	__property Title ;
	__property Subject ;
};


#pragma option push -b-
enum TgtStampType { stApproved, stExperimental, stNotApproved, stAsIs, stExpired, stNotForPublicRelease, stConfidential, stFinal, stSold, stDepartmental, stForComment, stTopSecret, stDraft, stForPublicRelease };
#pragma option pop

class DELPHICLASS TgtPDFStampAnnot;
class PASCALIMPLEMENTATION TgtPDFStampAnnot : public TgtPDFAnnot 
{
	typedef TgtPDFAnnot inherited;
	
private:
	TgtStampType FStampType;
	void __fastcall SetStampType(const TgtStampType Value);
	
public:
	__fastcall TgtPDFStampAnnot(void);
	__fastcall virtual ~TgtPDFStampAnnot(void);
	__property TgtStampType StampType = {read=FStampType, write=SetStampType, default=12};
	__property BorderColor  = {default=0};
	__property Rect ;
	__property Contents ;
	__property Title ;
	__property Subject ;
};


#pragma option push -b-
enum TgtFileAttachmentIcon { faGraph, faPaperclip, faPushPin, faTag };
#pragma option pop

class DELPHICLASS TgtPDFFileAttachmentAnnot;
class PASCALIMPLEMENTATION TgtPDFFileAttachmentAnnot : public TgtPDFAnnot 
{
	typedef TgtPDFAnnot inherited;
	
private:
	TgtFileAttachmentIcon FFileAttachmentIcon;
	AnsiString FAttachedFileName;
	void __fastcall SetAttachedFileName(const AnsiString Value);
	
public:
	__fastcall TgtPDFFileAttachmentAnnot(void);
	__fastcall virtual ~TgtPDFFileAttachmentAnnot(void);
	__property AnsiString AttachedFileName = {read=FAttachedFileName, write=SetAttachedFileName};
	__property TgtFileAttachmentIcon FileAttachmentIcon = {read=FFileAttachmentIcon, write=FFileAttachmentIcon, default=2};
	__property BorderColor  = {default=0};
	__property Title ;
	__property Contents ;
	__property Rect ;
	__property Subject ;
};


#pragma option push -b-
enum TgtCustomDocInfoSchema { schAdobePDF, schBasic, schDublinCore, schJobTicket, schRightsManagement, schPagedText };
#pragma option pop

class DELPHICLASS TgtPDFCustomDocInfo;
class PASCALIMPLEMENTATION TgtPDFCustomDocInfo : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TgtCustomDocInfoSchema FSchema;
	AnsiString FURI;
	AnsiString FName;
	AnsiString FValue;
	
public:
	__fastcall TgtPDFCustomDocInfo(void);
	__fastcall virtual ~TgtPDFCustomDocInfo(void);
	__property TgtCustomDocInfoSchema Schema = {read=FSchema, write=FSchema, default=0};
	__property AnsiString URI = {read=FURI, write=FURI};
	__property AnsiString Name = {read=FName, write=FName};
	__property AnsiString Value = {read=FValue, write=FValue};
};


#pragma option push -b-
enum TgtAcroFieldPreferencesType { afpReadOnly, afpRequired, afpNoExport };
#pragma option pop

typedef Set<TgtAcroFieldPreferencesType, afpReadOnly, afpNoExport>  TgtAcroFieldPreferences;

#pragma option push -b-
enum TgtAcroFieldRotationAngle { afra0, afra90, afra180, afra270 };
#pragma option pop

class DELPHICLASS TgtPDFFormField;
class PASCALIMPLEMENTATION TgtPDFFormField : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	AnsiString FFieldName;
	AnsiString FDefaultValue;
	TgtAcroFieldPreferences FPreferences;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBackgroundColor;
	Gtutils::TgtRect FRect;
	AnsiString FValue;
	Graphics::TFont* FFont;
	AnsiString FAltFeildName;
	bool FVisible;
	void __fastcall SetFieldName(const AnsiString Value);
	void __fastcall SetBackgroundColor(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetDefaultValue(const AnsiString Value);
	void __fastcall SetPreferences(const TgtAcroFieldPreferences Value);
	void __fastcall SetRect(const Gtutils::TgtRect &Value);
	void __fastcall SetValue(const AnsiString Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetAltFeildName(const AnsiString Value);
	void __fastcall SetVisible(const bool Value);
	
protected:
	int FPageNo;
	int FFontIndex;
	__property AnsiString Value = {read=FValue, write=SetValue};
	__property AnsiString DefaultValue = {read=FDefaultValue, write=SetDefaultValue};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property AnsiString FieldName = {read=FFieldName, write=SetFieldName};
	__property TgtAcroFieldPreferences Preferences = {read=FPreferences, write=SetPreferences, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=SetBackgroundColor, default=16777215};
	__property Gtutils::TgtRect Rect = {read=FRect, write=SetRect};
	__property AnsiString AltFieldName = {read=FAltFeildName, write=SetAltFeildName};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	
public:
	__fastcall TgtPDFFormField(void);
	__fastcall virtual ~TgtPDFFormField(void);
};


#pragma option push -b-
enum TgtAcroPushButtonPosition { apbpCaption, apbpIcon, apbpCaptionBelowIcon, apbpCaptionAboveIcon, apbpCaptionRightOfIcon, apbpCaptionLeftOfIcon, apbpCaptionOnIcon };
#pragma option pop

#pragma option push -b-
enum TgtAcroIconScale { aisAlways, aisIconBigger, aisIconSmaller, aisNever };
#pragma option pop

#pragma option push -b-
enum TgtAcroIconScaleType { aistFit, aistAspectRatio };
#pragma option pop

class DELPHICLASS TgtAcroIconAttribute;
class PASCALIMPLEMENTATION TgtAcroIconAttribute : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TgtAcroIconScale FScale;
	TgtAcroIconScaleType FScaleType;
	double FLeftSpace;
	double FBottomSpace;
	void __fastcall SetScale(const TgtAcroIconScale Value);
	void __fastcall SetScaleType(const TgtAcroIconScaleType Value);
	void __fastcall SetBottomSpace(const double Value);
	void __fastcall SetLeftSpace(const double Value);
	
public:
	__property TgtAcroIconScale Scale = {read=FScale, write=SetScale, default=0};
	__property TgtAcroIconScaleType ScaleType = {read=FScaleType, write=SetScaleType, default=1};
	__property double LeftSpace = {read=FLeftSpace, write=SetLeftSpace};
	__property double BottomSpace = {read=FBottomSpace, write=SetBottomSpace};
	__fastcall TgtAcroIconAttribute(void);
	__fastcall virtual ~TgtAcroIconAttribute(void);
};


#pragma option push -b-
enum TgtPushButtonAction { pbaNone, pbaSubmit, pbaReset, pbaJavaScript };
#pragma option pop

#pragma option push -b-
enum TgtFormSubmitFormat { fsfHTML, fsfFDF, fsfXML };
#pragma option pop

class DELPHICLASS TgtPDFFormPushButton;
class PASCALIMPLEMENTATION TgtPDFFormPushButton : public TgtPDFFormField 
{
	typedef TgtPDFFormField inherited;
	
private:
	AnsiString FNormalCaption;
	AnsiString FRolloverCaption;
	AnsiString FDownCaption;
	AnsiString FJavaScript;
	AnsiString FSubmitURL;
	TgtPushButtonAction FAction;
	TgtFormSubmitFormat FFormSubmitFormat;
	void __fastcall SetDownCaption(const AnsiString Value);
	void __fastcall SetNormalCaption(const AnsiString Value);
	void __fastcall SetRolloverCaption(const AnsiString Value);
	void __fastcall SetAction(const TgtPushButtonAction Value);
	void __fastcall SetJavaScript(const AnsiString Value);
	void __fastcall SetSubmitURL(const AnsiString Value);
	void __fastcall SetFormSubmitFormat(const TgtFormSubmitFormat Value);
	
public:
	__property Font ;
	__property FieldName ;
	__property Preferences ;
	__property BorderColor  = {default=0};
	__property BackgroundColor  = {default=16777215};
	__property Rect ;
	__property AltFieldName ;
	__property Visible  = {default=1};
	__property AnsiString NormalCaption = {read=FNormalCaption, write=SetNormalCaption};
	__property AnsiString RolloverCaption = {read=FRolloverCaption, write=SetRolloverCaption};
	__property AnsiString DownCaption = {read=FDownCaption, write=SetDownCaption};
	__property TgtPushButtonAction Action = {read=FAction, write=SetAction, default=0};
	__property AnsiString JavaScript = {read=FJavaScript, write=SetJavaScript};
	__property AnsiString SubmitURL = {read=FSubmitURL, write=SetSubmitURL};
	__property TgtFormSubmitFormat FormSubmitFormat = {read=FFormSubmitFormat, write=SetFormSubmitFormat, default=0};
	__fastcall TgtPDFFormPushButton(void);
	__fastcall virtual ~TgtPDFFormPushButton(void);
};


#pragma option push -b-
enum TgtPDFFormCheckboxSymbol { pfcsCheck, pfcsCircle, pfcsCross, pfcsDiamond, pfcsSquare, pfcsStar };
#pragma option pop

class DELPHICLASS TgtPDFFormCheckBox;
class PASCALIMPLEMENTATION TgtPDFFormCheckBox : public TgtPDFFormField 
{
	typedef TgtPDFFormField inherited;
	
private:
	TgtPDFFormCheckboxSymbol FSymbol;
	bool FChecked;
	void __fastcall SetSymbol(const TgtPDFFormCheckboxSymbol Value);
	void __fastcall SetChecked(const bool Value);
	
public:
	__property Font ;
	__property FieldName ;
	__property Preferences ;
	__property BorderColor  = {default=0};
	__property BackgroundColor  = {default=16777215};
	__property Rect ;
	__property TgtPDFFormCheckboxSymbol Symbol = {read=FSymbol, write=SetSymbol, default=0};
	__property bool Checked = {read=FChecked, write=SetChecked, default=0};
	__fastcall TgtPDFFormCheckBox(void);
	__fastcall virtual ~TgtPDFFormCheckBox(void);
};


class DELPHICLASS TgtPDFFormRadioItem;
class PASCALIMPLEMENTATION TgtPDFFormRadioItem : public TgtPDFFormField 
{
	typedef TgtPDFFormField inherited;
	
public:
	__fastcall TgtPDFFormRadioItem(void);
	__fastcall virtual ~TgtPDFFormRadioItem(void);
	__property Value ;
	__property BorderColor  = {default=0};
	__property BackgroundColor  = {default=16777215};
	__property Rect ;
};


class DELPHICLASS TgtPDFFormRadioButton;
class PASCALIMPLEMENTATION TgtPDFFormRadioButton : public TgtPDFFormField 
{
	typedef TgtPDFFormField inherited;
	
private:
	Classes::TStringList* FItems;
	int FSelectedItemIndex;
	bool FAtleastOneSelectedItem;
	TgtPDFFormCheckboxSymbol FSymbol;
	void __fastcall SetSelectedItemIndex(const int Value);
	void __fastcall SetAtleastOneSelectedItem(const bool Value);
	void __fastcall SetSymbol(const TgtPDFFormCheckboxSymbol Value);
	
public:
	__property Font ;
	__property FieldName ;
	__property Preferences ;
	__property int SelectedItemIndex = {read=FSelectedItemIndex, write=SetSelectedItemIndex, default=-1};
	__property TgtPDFFormCheckboxSymbol Symbol = {read=FSymbol, write=SetSymbol, default=0};
	__property bool AtleastOneSelectedItem = {read=FAtleastOneSelectedItem, write=SetAtleastOneSelectedItem, default=0};
	__fastcall TgtPDFFormRadioButton(void);
	__fastcall virtual ~TgtPDFFormRadioButton(void);
	int __fastcall AddItem(TgtPDFFormRadioItem* RadioItem);
};


class DELPHICLASS TgtPDFFormTextField;
class PASCALIMPLEMENTATION TgtPDFFormTextField : public TgtPDFFormField 
{
	typedef TgtPDFFormField inherited;
	
private:
	bool FIsMultiline;
	bool FIsPassword;
	bool FIsFileSelect;
	bool FIsDoNotSpellCheck;
	bool FIsDoNotScroll;
	int FMaxLength;
	bool FIsBorder;
	TgtAlign FHAlignment;
	void __fastcall SetIsDoNotScroll(const bool Value);
	void __fastcall SetIsDoNotSpellCheck(const bool Value);
	void __fastcall SetIsFileSelect(const bool Value);
	void __fastcall SetIsMultiline(const bool Value);
	void __fastcall SetIsPassword(const bool Value);
	void __fastcall SetMaxLength(const int Value);
	void __fastcall SetIsBorder(const bool Value);
	void __fastcall SetHAlignment(const TgtAlign Value);
	
public:
	__fastcall TgtPDFFormTextField(void);
	__fastcall virtual ~TgtPDFFormTextField(void);
	__property Value ;
	__property Font ;
	__property FieldName ;
	__property Preferences ;
	__property BorderColor  = {default=0};
	__property BackgroundColor  = {default=16777215};
	__property Rect ;
	__property bool IsMultiline = {read=FIsMultiline, write=SetIsMultiline, default=0};
	__property bool IsPassword = {read=FIsPassword, write=SetIsPassword, default=0};
	__property bool IsFileSelect = {read=FIsFileSelect, write=SetIsFileSelect, default=0};
	__property bool IsDoNotSpellCheck = {read=FIsDoNotSpellCheck, write=SetIsDoNotSpellCheck, default=0};
	__property bool IsDoNotScroll = {read=FIsDoNotScroll, write=SetIsDoNotScroll, default=0};
	__property int MaxLength = {read=FMaxLength, write=SetMaxLength, default=-1};
	__property bool IsBorder = {read=FIsBorder, write=SetIsBorder, default=1};
	__property TgtAlign HAlignment = {read=FHAlignment, write=SetHAlignment, default=0};
};


class DELPHICLASS TgtPDFFormSignatureField;
class PASCALIMPLEMENTATION TgtPDFFormSignatureField : public TgtPDFFormField 
{
	typedef TgtPDFFormField inherited;
	
public:
	__fastcall TgtPDFFormSignatureField(void);
	__fastcall virtual ~TgtPDFFormSignatureField(void);
	__property FieldName ;
	__property Rect ;
};


typedef DynamicArray<AnsiString >  gtExPDFEng__33;

class DELPHICLASS TgtPDFFormComboBox;
class PASCALIMPLEMENTATION TgtPDFFormComboBox : public TgtPDFFormField 
{
	typedef TgtPDFFormField inherited;
	
private:
	bool FIsEditable;
	bool FIsSortList;
	int FSelectedItemIndex;
	void __fastcall SetIsEditable(const bool Value);
	void __fastcall SetIsSortList(const bool Value);
	void __fastcall SetSelectedItemIndex(const int Value);
	
protected:
	DynamicArray<AnsiString >  FItems;
	
public:
	__property Font ;
	__property FieldName ;
	__property Preferences ;
	__property BorderColor  = {default=0};
	__property BackgroundColor  = {default=16777215};
	__property Rect ;
	__property bool IsEditable = {read=FIsEditable, write=SetIsEditable, default=0};
	__property bool IsSortList = {read=FIsSortList, write=SetIsSortList, default=0};
	__property int SelectedItemIndex = {read=FSelectedItemIndex, write=SetSelectedItemIndex, default=-1};
	int __fastcall AddItem(AnsiString Item);
	__fastcall TgtPDFFormComboBox(void);
	__fastcall virtual ~TgtPDFFormComboBox(void);
};


typedef DynamicArray<AnsiString >  gtExPDFEng__53;

class DELPHICLASS TgtPDFFormListBox;
class PASCALIMPLEMENTATION TgtPDFFormListBox : public TgtPDFFormField 
{
	typedef TgtPDFFormField inherited;
	
private:
	bool FIsSortList;
	bool FIsMultiSelect;
	void __fastcall SetIsMultiSelect(const bool Value);
	void __fastcall SetIsSortList(const bool Value);
	
protected:
	DynamicArray<AnsiString >  FItems;
	
public:
	__property Font ;
	__property FieldName ;
	__property Preferences ;
	__property BorderColor  = {default=0};
	__property BackgroundColor  = {default=16777215};
	__property Rect ;
	__property bool IsSortList = {read=FIsSortList, write=SetIsSortList, default=0};
	__property bool IsMultiSelect = {read=FIsMultiSelect, write=SetIsMultiSelect, default=0};
	int __fastcall AddItem(AnsiString Item);
	__fastcall TgtPDFFormListBox(void);
	__fastcall virtual ~TgtPDFFormListBox(void);
};


class DELPHICLASS TgtDocEventJSAction;
class PASCALIMPLEMENTATION TgtDocEventJSAction : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FBeforeClose;
	AnsiString FBeforePrint;
	AnsiString FBeforeSave;
	AnsiString FAfterSave;
	AnsiString FAfterPrint;
	void __fastcall SetAfterPrint(const AnsiString Value);
	void __fastcall SetAfterSave(const AnsiString Value);
	void __fastcall SetBeforePrint(const AnsiString Value);
	void __fastcall SetBeforeSave(const AnsiString Value);
	void __fastcall SetBeforeClose(const AnsiString Value);
	
__published:
	__property AnsiString BeforeClose = {read=FBeforeClose, write=SetBeforeClose};
	__property AnsiString BeforeSave = {read=FBeforeSave, write=SetBeforeSave};
	__property AnsiString AfterSave = {read=FAfterSave, write=SetAfterSave};
	__property AnsiString BeforePrint = {read=FBeforePrint, write=SetBeforePrint};
	__property AnsiString AfterPrint = {read=FAfterPrint, write=SetAfterPrint};
	
public:
	__fastcall TgtDocEventJSAction(void);
	__fastcall virtual ~TgtDocEventJSAction(void);
};


class DELPHICLASS TgtPageEventAction;
class PASCALIMPLEMENTATION TgtPageEventAction : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	int FPageNo;
	TgtAnnotAction* FOpenAction;
	TgtAnnotAction* FCloseAction;
	void __fastcall SetCloseAction(const TgtAnnotAction* Value);
	void __fastcall SetOpenAction(const TgtAnnotAction* Value);
	void __fastcall SetPageNo(const int Value);
	
public:
	__fastcall TgtPageEventAction(void);
	__fastcall virtual ~TgtPageEventAction(void);
	__property TgtAnnotAction* OpenAction = {read=FOpenAction, write=SetOpenAction};
	__property TgtAnnotAction* CloseAction = {read=FCloseAction, write=SetCloseAction};
	__property int PageNo = {read=FPageNo, write=SetPageNo, nodefault};
};


class DELPHICLASS TgtExPDFEngine;
class PASCALIMPLEMENTATION TgtExPDFEngine : public Gtcstpdfeng::TgtCustomPDFEngine 
{
	typedef Gtcstpdfeng::TgtCustomPDFEngine inherited;
	
private:
	int FAcroForms;
	int FCstDocInfo;
	int FDocEventJS;
	Classes::TStringList* FAnnotList;
	Classes::TStringList* FPDFFormFields;
	Classes::TList* FCstDocInfoList;
	Classes::TStringList* FPageEventActionList;
	TgtDocEventJSAction* FDocEventJSAction;
	void __fastcall WriteAnnots(void);
	void __fastcall WriteFormFields(void);
	void __fastcall WriteCustomDocInfo(void);
	void __fastcall WriteDocEventJSAction(void);
	void __fastcall SetDocEventJSAction(const TgtDocEventJSAction* Value);
	
protected:
	virtual void __fastcall EndPage(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall Start(void);
	AnsiString __fastcall GetAnnotActionDictionary(TgtAnnotAction* Action, int ObjNo);
	virtual AnsiString __fastcall GetCatalogDictionary();
	virtual AnsiString __fastcall GetPageDictionary(int AObjNo);
	virtual Classes::TMemoryStream* __fastcall GetBitmapAsCCITTStream(Graphics::TBitmap* ABitmap, Gtcstdoceng::TgtOutputImageFormat AFormat);
	
public:
	__fastcall virtual TgtExPDFEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtExPDFEngine(void);
	void __fastcall AddAnnotItem(TgtPDFAnnot* AAnnot);
	void __fastcall AddFormItem(TgtPDFFormField* AField);
	void __fastcall AddCustomDocInfo(TgtPDFCustomDocInfo* ACustomDocInfo);
	void __fastcall AddPageEventAction(TgtPageEventAction* APageEventAction);
	__property TgtDocEventJSAction* DocEventJSAction = {read=FDocEventJSAction, write=SetDocEventJSAction};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtexpdfeng */
using namespace Gtexpdfeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtexpdfeng
