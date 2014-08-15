// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtcsthtmleng.pas' rev: 10.00

#ifndef GtcsthtmlengHPP
#define GtcsthtmlengHPP

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
#include <Gtcstplneng.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtdocutils.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtcsthtmleng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtHTMLImageSettings;
class PASCALIMPLEMENTATION TgtHTMLImageSettings : public Gtcstdoceng::TgtImageSettings 
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
	__fastcall virtual TgtHTMLImageSettings(void)/* overload */;
	__fastcall virtual ~TgtHTMLImageSettings(void);
	bool __fastcall IsEqual(Gtcstdoceng::TgtImageItem* AObject, double AOriginalWidth, double AOriginalHeight);
	
__published:
	__property AnsiString FileName = {read=FFileName, write=SetFileName};
	__property double DispWidth = {read=FDispWidth, write=SetDispWidth};
	__property double DispHeight = {read=FDispHeight, write=SetDispHeight};
	__property double ImageWidth = {read=FImageWidth, write=SetImageWidth};
	__property double ImageHeight = {read=FImageHeight, write=SetImageHeight};
};


class DELPHICLASS TgtHTMLPreferences;
class PASCALIMPLEMENTATION TgtHTMLPreferences : public Gtcstplneng::TgtPlainSheetPreferences 
{
	typedef Gtcstplneng::TgtPlainSheetPreferences inherited;
	
private:
	bool FOptimizeForIE;
	bool FSingleFile;
	bool FAutoScroll;
	bool FPageEndLines;
	void __fastcall SetAutoScroll(const bool Value);
	void __fastcall SetOptimizeForIE(const bool Value);
	void __fastcall SetSingleFile(const bool Value);
	void __fastcall SetPageEndLines(const bool Value);
	
__published:
	__property bool SingleFile = {read=FSingleFile, write=SetSingleFile, default=1};
	__property bool AutoScroll = {read=FAutoScroll, write=SetAutoScroll, default=1};
	__property bool OptimizeForIE = {read=FOptimizeForIE, write=SetOptimizeForIE, default=1};
	__property bool PageEndLines = {read=FPageEndLines, write=SetPageEndLines, default=1};
public:
	#pragma option push -w-inl
	/* TgtPlainSheetPreferences.Create */ inline __fastcall virtual TgtHTMLPreferences(void)/* overload */ : Gtcstplneng::TgtPlainSheetPreferences() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TgtPreferences.Destroy */ inline __fastcall virtual ~TgtHTMLPreferences(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TgtHTMLNavigatorOrientation { noHorizontal, noVertical };
#pragma option pop

#pragma option push -b-
enum TgtHTMLNavigatorPosition { npTopLeft, npTopCenter, npTopRight, npCenterLeft, npCenter, npCenterRight, npBottomLeft, npBottomCenter, npBottomRight };
#pragma option pop

#pragma option push -b-
enum TgtHTMLNavigatorType { ntFixedToScreen, ntFixedToPage };
#pragma option pop

#pragma option push -b-
enum TgtHTMLNavBtn { hnbTOC, hnbFirst, hnbPrev, hnbNext, hnbLast };
#pragma option pop

typedef Set<TgtHTMLNavBtn, hnbTOC, hnbLast>  TgtHTMLNavBtns;

class DELPHICLASS TgtHTMLNavigator;
class PASCALIMPLEMENTATION TgtHTMLNavigator : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FLinkBackColor;
	Graphics::TColor FLinkHoverBackColor;
	Graphics::TColor FLinkHoverForeColor;
	AnsiString FLinkImageTOC;
	AnsiString FLinkImageFirst;
	AnsiString FLinkImageLast;
	AnsiString FLinkImageNext;
	AnsiString FLinkImagePrev;
	Graphics::TFont* FLinkFont;
	AnsiString FLinkTextTOC;
	AnsiString FLinkTextFirst;
	AnsiString FLinkTextLast;
	AnsiString FLinkTextNext;
	AnsiString FLinkTextPrev;
	TgtHTMLNavigatorOrientation FNavigatorOrientation;
	TgtHTMLNavigatorPosition FNavigatorPosition;
	TgtHTMLNavigatorType FNavigatorType;
	bool FUseTextLinks;
	bool FEnabled;
	bool __fastcall IsLinkTextTOCStored(void);
	bool __fastcall IsLinkTextFirstStored(void);
	bool __fastcall IsLinkTextNextStored(void);
	bool __fastcall IsLinkTextPrevStored(void);
	bool __fastcall IsLinkTextLastStored(void);
	void __fastcall SetLinkFont(Graphics::TFont* Value);
	void __fastcall SetLinkBackColor(const Graphics::TColor Value);
	void __fastcall SetLinkHoverBackColor(const Graphics::TColor Value);
	void __fastcall SetLinkHoverForeColor(const Graphics::TColor Value);
	void __fastcall SetLinkTextTOC(const AnsiString Value);
	void __fastcall SetLinkTextFirst(const AnsiString Value);
	void __fastcall SetLinkTextLast(const AnsiString Value);
	void __fastcall SetLinkTextNext(const AnsiString Value);
	void __fastcall SetLinkTextPrev(const AnsiString Value);
	TgtHTMLNavigatorOrientation __fastcall SetNavigatorOrientation(void);
	void __fastcall SetNavigatorPosition(const TgtHTMLNavigatorPosition Value);
	void __fastcall SetNavigatorType(const TgtHTMLNavigatorType Value);
	void __fastcall SetUseTextLinks(const bool Value);
	void __fastcall SetLinkImageFirst(const AnsiString Value);
	void __fastcall SetLinkImageLast(const AnsiString Value);
	void __fastcall SetLinkImageNext(const AnsiString Value);
	void __fastcall SetLinkImagePrev(const AnsiString Value);
	void __fastcall SetLinkImageTOC(const AnsiString Value);
	void __fastcall SetEnabled(const bool Value);
	
public:
	__fastcall TgtHTMLNavigator(void);
	__fastcall virtual ~TgtHTMLNavigator(void);
	
__published:
	__property Graphics::TColor LinkBackColor = {read=FLinkBackColor, write=SetLinkBackColor, default=16777215};
	__property Graphics::TColor LinkHoverForeColor = {read=FLinkHoverForeColor, write=SetLinkHoverForeColor, default=16777215};
	__property Graphics::TColor LinkHoverBackColor = {read=FLinkHoverBackColor, write=SetLinkHoverBackColor, default=16711680};
	__property AnsiString LinkImageTOC = {read=FLinkImageTOC, write=SetLinkImageTOC};
	__property AnsiString LinkImageFirst = {read=FLinkImageFirst, write=SetLinkImageFirst};
	__property AnsiString LinkImageNext = {read=FLinkImageNext, write=SetLinkImageNext};
	__property AnsiString LinkImagePrev = {read=FLinkImagePrev, write=SetLinkImagePrev};
	__property AnsiString LinkImageLast = {read=FLinkImageLast, write=SetLinkImageLast};
	__property Graphics::TFont* LinkFont = {read=FLinkFont, write=SetLinkFont};
	__property AnsiString LinkTextTOC = {read=FLinkTextTOC, write=SetLinkTextTOC, stored=IsLinkTextTOCStored};
	__property AnsiString LinkTextFirst = {read=FLinkTextFirst, write=SetLinkTextFirst, stored=IsLinkTextFirstStored};
	__property AnsiString LinkTextNext = {read=FLinkTextNext, write=SetLinkTextNext, stored=IsLinkTextNextStored};
	__property AnsiString LinkTextPrev = {read=FLinkTextPrev, write=SetLinkTextPrev, stored=IsLinkTextPrevStored};
	__property AnsiString LinkTextLast = {read=FLinkTextLast, write=SetLinkTextLast, stored=IsLinkTextLastStored};
	__property TgtHTMLNavigatorOrientation NavigatorOrientation = {read=SetNavigatorOrientation, write=FNavigatorOrientation, default=0};
	__property TgtHTMLNavigatorPosition NavigatorPosition = {read=FNavigatorPosition, write=SetNavigatorPosition, default=8};
	__property TgtHTMLNavigatorType NavigatorType = {read=FNavigatorType, write=SetNavigatorType, default=0};
	__property bool UseTextLinks = {read=FUseTextLinks, write=SetUseTextLinks, default=1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
};


class DELPHICLASS TgtHTMLCustomMetaInfo;
class PASCALIMPLEMENTATION TgtHTMLCustomMetaInfo : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TStringList* FNames;
	Classes::TStringList* FValues;
	void __fastcall SetNames(const Classes::TStringList* Value);
	void __fastcall SetValues(const Classes::TStringList* Value);
	
public:
	__fastcall TgtHTMLCustomMetaInfo(void);
	__fastcall virtual ~TgtHTMLCustomMetaInfo(void);
	
__published:
	__property Classes::TStringList* Names = {read=FNames, write=SetNames};
	__property Classes::TStringList* Values = {read=FValues, write=SetValues};
};


typedef void __fastcall (__closure *TgtOnNeedImageFileNameEvent)(Gtcstdoceng::TgtCustomDocumentEngine* Sender, int ImageWidthPixels, int ImageHeightPixels, Gtcstdoceng::TgtOutputImageFormat ImageFormat, AnsiString &FileName, bool &CreateNewImage);

typedef AnsiString gtCstHTMLEng__6[5];

typedef DynamicArray<Classes::TList* >  gtCstHTMLEng__7;

class DELPHICLASS TgtCustomHTMLEngine;
class PASCALIMPLEMENTATION TgtCustomHTMLEngine : public Gtcstplneng::TgtCustomPlainsheetEngine 
{
	typedef Gtcstplneng::TgtCustomPlainsheetEngine inherited;
	
private:
	AnsiString FPositionAbsolute;
	AnsiString FNavBtnChars[5];
	AnsiString FNavFontName;
	double FNavigatorWidth;
	double FNavigatorHeight;
	int FImageCount;
	Classes::TStringList* FCSSClasses;
	DynamicArray<Classes::TList* >  FImgSettingList;
	Classes::TStream* FHTMLStream;
	Classes::TStream* FBodyStream;
	Classes::TStream* FFooterStream;
	Classes::TStream* FHeaderStream;
	bool FOutputStylesToCSSFile;
	bool FOutputScriptsToJSFile;
	AnsiString FCSSFileName;
	AnsiString FJSFileName;
	TgtHTMLNavigator* FNavigator;
	TgtHTMLCustomMetaInfo* FCustomMetaInfo;
	bool FTransparentBackground;
	TgtOnNeedImageFileNameEvent FOnNeedImageFileName;
	void __fastcall WriteHeader(void);
	void __fastcall WriteFooter(void);
	AnsiString __fastcall ConstructStyleStrings();
	void __fastcall CalculateNavigatorDimensions(void);
	AnsiString __fastcall GetNavigatorStyle();
	AnsiString __fastcall GetBackground();
	AnsiString __fastcall GetNavigatorJS();
	AnsiString __fastcall SpacesToNBSP(AnsiString AString);
	AnsiString __fastcall GetFontInfo(Graphics::TFont* AFont);
	AnsiString __fastcall GetHTMLImage(Gtcstdoceng::TgtImageItem* AObject, bool AIsTableItem);
	AnsiString __fastcall ConvertHyperLinks(AnsiString AString, Graphics::TFont* AFont);
	void __fastcall SetNavigator(const TgtHTMLNavigator* Value);
	void __fastcall SetOutputStylesToCSSFile(const bool Value);
	void __fastcall SetOutputScriptsToJSFile(const bool Value);
	void __fastcall SetCSSFileName(const AnsiString Value);
	void __fastcall SetJSFileName(const AnsiString Value);
	HIDESBASE TgtHTMLPreferences* __fastcall GetPreferences(void);
	HIDESBASE void __fastcall SetPreferences(const TgtHTMLPreferences* Value);
	void __fastcall SetCustomMetaInfo(const TgtHTMLCustomMetaInfo* Value);
	Classes::TStringList* __fastcall GetHTMLFileNames(void);
	void __fastcall SetTransparentBackground(const bool Value);
	void __fastcall SetOnNeedImageFileName(const TgtOnNeedImageFileNameEvent Value);
	
protected:
	Classes::TStringList* FAttachmentList;
	virtual void __fastcall InsertAnchors(Classes::TStream* AStream);
	virtual void __fastcall EncodeTOC(void);
	AnsiString __fastcall GetFontCSS(Graphics::TFont* AFont);
	AnsiString __fastcall GetISOCharSet(int WinCP);
	int __fastcall GetOffsetFromTop(void);
	virtual AnsiString __fastcall AddXHTMLHeader();
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall EndPage(void);
	virtual bool __fastcall CheckOutputImageFormat(Gtcstdoceng::TgtOutputImageFormat Value, AnsiString &S);
	virtual Word __fastcall ShowSetupModal(void);
	virtual TMetaClass* __fastcall GetPreferencesClassName(void);
	virtual void __fastcall PutTrialNote(void);
	virtual void __fastcall EncodeText(Gtcstdoceng::TgtTextItem* AObject);
	virtual void __fastcall EncodeParagraph(Gtcstdoceng::TgtParagraphItem* AObject);
	virtual void __fastcall EncodeLine(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen);
	virtual void __fastcall EncodeRect(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeImage(Gtcstdoceng::TgtImageItem* AObject);
	virtual void __fastcall EncodeShapeBitmap(double X, double Y, Graphics::TBitmap* Bitmap);
	virtual void __fastcall EncodeTable(Gtcstdoceng::TgtTableItem* AObject);
	virtual void __fastcall Start(void);
	virtual void __fastcall Finish(void);
	
public:
	__fastcall virtual TgtCustomHTMLEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtCustomHTMLEngine(void);
	virtual void __fastcall NewPage(void);
	__property Classes::TStringList* RelatedFileNames = {read=FAttachmentList};
	__property Classes::TStringList* HTMLFileNames = {read=GetHTMLFileNames};
	
__published:
	__property bool OutputStylesToCSSFile = {read=FOutputStylesToCSSFile, write=SetOutputStylesToCSSFile, default=0};
	__property bool OutputScriptsToJSFile = {read=FOutputScriptsToJSFile, write=SetOutputScriptsToJSFile, default=0};
	__property TgtHTMLNavigator* Navigator = {read=FNavigator, write=SetNavigator};
	__property AnsiString CSSFileName = {read=FCSSFileName, write=SetCSSFileName};
	__property AnsiString JSFileName = {read=FJSFileName, write=SetJSFileName};
	__property bool TransparentBackground = {read=FTransparentBackground, write=SetTransparentBackground, nodefault};
	__property BackgroundImage ;
	__property BackgroundImageDisplayType  = {default=5};
	__property BackgroundColor  = {default=16777215};
	__property TgtHTMLPreferences* Preferences = {read=GetPreferences, write=SetPreferences};
	__property TgtHTMLCustomMetaInfo* CustomMetaInfo = {read=FCustomMetaInfo, write=SetCustomMetaInfo};
	__property TgtOnNeedImageFileNameEvent OnNeedImageFileName = {read=FOnNeedImageFileName, write=SetOnNeedImageFileName};
	__property OnNeedFileName ;
};


typedef AnsiString gtCstHTMLEng__8[5];

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE AnsiString CNavWingdingsChars[5];

}	/* namespace Gtcsthtmleng */
using namespace Gtcsthtmleng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtcsthtmleng
