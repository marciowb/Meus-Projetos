// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtrtfeng.pas' rev: 10.00

#ifndef GtrtfengHPP
#define GtrtfengHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtcstplneng.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtdocutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtrtfeng
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TgtRTFEncodingType { etPositionalAccuracy, etEaseOfEditing };
#pragma option pop

class DELPHICLASS TgtRTFPreferences;
class PASCALIMPLEMENTATION TgtRTFPreferences : public Gtcstplneng::TgtPlainSheetPreferences 
{
	typedef Gtcstplneng::TgtPlainSheetPreferences inherited;
	
private:
	bool FGraphicDataInBinary;
	bool FMetafileAsImage;
	void __fastcall SetGraphicDataInBinary(const bool Value);
	void __fastcall SetMetafileAsImage(const bool Value);
	
__published:
	__property bool GraphicDataInBinary = {read=FGraphicDataInBinary, write=SetGraphicDataInBinary, nodefault};
	__property bool MetafileAsImage = {read=FMetafileAsImage, write=SetMetafileAsImage, default=0};
public:
	#pragma option push -w-inl
	/* TgtPlainSheetPreferences.Create */ inline __fastcall virtual TgtRTFPreferences(void)/* overload */ : Gtcstplneng::TgtPlainSheetPreferences() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TgtPreferences.Destroy */ inline __fastcall virtual ~TgtRTFPreferences(void) { }
	#pragma option pop
	
};


class DELPHICLASS TgtTabItem;
class PASCALIMPLEMENTATION TgtTabItem : public Gtcstdoceng::TgtDocumentItem 
{
	typedef Gtcstdoceng::TgtDocumentItem inherited;
	
private:
	double FBeforeSpace;
	double FLineSpacing;
	double FDefaultTabStop;
	Classes::TStringList* FTextList;
	Classes::TList* FTabStopList;
	Graphics::TFont* FFont;
	
public:
	__fastcall TgtTabItem(void);
	__fastcall virtual ~TgtTabItem(void);
};


class DELPHICLASS TgtBookmarkItem;
class PASCALIMPLEMENTATION TgtBookmarkItem : public Gtcstdoceng::TgtDocumentItem 
{
	typedef Gtcstdoceng::TgtDocumentItem inherited;
	
private:
	AnsiString FName;
	double FX;
	double FY;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TgtBookmarkItem(void) : Gtcstdoceng::TgtDocumentItem() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TgtBookmarkItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TgtRTFEngine;
class PASCALIMPLEMENTATION TgtRTFEngine : public Gtcstplneng::TgtCustomPlainsheetEngine 
{
	typedef Gtcstplneng::TgtCustomPlainsheetEngine inherited;
	
private:
	Classes::TMemoryStream* FRTFStream;
	Classes::TMemoryStream* FHeaderStream;
	Classes::TMemoryStream* FFooterStream;
	Classes::TStream* FOutputStream;
	Classes::TStrings* FColorTable;
	Classes::TStrings* FFontTable;
	double FRTFFactor;
	TgtTabItem* FTabItem;
	bool FIsTabStarted;
	double FDefaultTabStop;
	TgtRTFEncodingType FDocumentEncodingType;
	AnsiString FCheckRepeatText;
	double FRepeatTextX;
	double FRepeatTextY;
	bool FRemoveDuplicates;
	int FCountTextItem;
	Classes::TList* FRepeatedText;
	int __fastcall AddFontInfoToFontTable(Graphics::TFont* AFont);
	int __fastcall AddColorInfoToColorTable(Graphics::TColor AColor);
	AnsiString __fastcall NativeText(const AnsiString Text);
	AnsiString __fastcall GetLineAttrib(Graphics::TPen* APen);
	AnsiString __fastcall GetShapeFillAttrib(Graphics::TBrush* ABrush);
	AnsiString __fastcall GetCharacterShade(Graphics::TBrush* ABrush);
	AnsiString __fastcall GetShadeAttrib(Graphics::TBrush* ABrush);
	AnsiString __fastcall GetFrameAttrib(Graphics::TPen* APen, Gtcstdoceng::TgtFrame* AFrame);
	AnsiString __fastcall GetParaBrdrInfo(int AWidth, Graphics::TColor AColor, Graphics::TPenStyle AStyle);
	AnsiString __fastcall GetFontAttrib(Graphics::TFont* AFont);
	AnsiString __fastcall GetAlignment(Gtcstdoceng::TgtHAlignment HAlign);
	AnsiString __fastcall GetLinkTextAttrib(AnsiString Text);
	AnsiString __fastcall GetBmpHeader(Classes::TMemoryStream* AStream, Graphics::TBitmap* ABitmap);
	AnsiString __fastcall EncodeGraphic(Gtcstdoceng::TgtImageItem* AObject);
	void __fastcall WriteToRTFStream(AnsiString Text);
	HIDESBASE void __fastcall SetBackgroundDisplayType(const Gtcstdoceng::TgtBackgroundDisplayType Value);
	void __fastcall SetTabStop(const double Value);
	void __fastcall SetDocumentEncodingType(const TgtRTFEncodingType Value);
	HIDESBASE TgtRTFPreferences* __fastcall GetPreferences(void);
	HIDESBASE void __fastcall SetPreferences(const TgtRTFPreferences* Value);
	AnsiString __fastcall WriteBackgroundImage();
	AnsiString __fastcall ConvertToMultibyte(WideChar * pw, Graphics::TFontCharset CharSet);
	bool __fastcall GetRemoveDuplicates(void);
	void __fastcall SetRemoveDuplicates(const bool Value);
	
protected:
	virtual void __fastcall Start(void);
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall AdjustTextItemList(Classes::TList* AList);
	virtual void __fastcall PutTrialNote(void);
	virtual void __fastcall EncodeText(Gtcstdoceng::TgtTextItem* AObject);
	virtual void __fastcall EncodeTextBox(Gtcstdoceng::TgtTextBoxItem* AObject);
	virtual void __fastcall EncodeImage(Gtcstdoceng::TgtImageItem* AObject);
	virtual void __fastcall EncodeParagraph(Gtcstdoceng::TgtParagraphItem* AObject);
	virtual void __fastcall EncodeTable(Gtcstdoceng::TgtTableItem* AObject);
	virtual void __fastcall EncodeLine(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen);
	virtual void __fastcall EncodeRect(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeRoundRect(double X1, double Y1, double X2, double Y2, double X3, double Y3, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeEllipse(double X1, double Y1, double X2, double Y2, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodePolyLine(Gtcstdoceng::TgtPoints Points, int NoPoints, bool IsClosed, Graphics::TPen* Pen, Graphics::TBrush* Brush);
	virtual void __fastcall EncodeShapeBitmap(double X, double Y, Graphics::TBitmap* Bitmap);
	virtual void __fastcall EncodeCustomItem(Gtcstdoceng::TgtDocumentItem* AObject);
	virtual void __fastcall EncodePageBorder(void);
	virtual void __fastcall ProcessTextList(Classes::TList* AList);
	virtual bool __fastcall CheckOutputImageFormat(Gtcstdoceng::TgtOutputImageFormat Value, AnsiString &S);
	virtual Word __fastcall ShowSetupModal(void);
	virtual TMetaClass* __fastcall GetPreferencesClassName(void);
	virtual void __fastcall ProcessMetafile(double AX, double AY, Graphics::TMetafile* AMetafile);
	virtual WideString __fastcall ReplacePageInfo(WideString AText);
	
public:
	__fastcall virtual TgtRTFEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtRTFEngine(void);
	virtual void __fastcall BeginPara(void);
	void __fastcall BeginTab(void);
	virtual double __fastcall TextOut(WideString Text)/* overload */;
	void __fastcall EndTab(void);
	void __fastcall InsertTabStop(double * Value, const int Value_Size);
	void __fastcall SetDefaultTabStop(double Value);
	void __fastcall InsertBookmark(AnsiString BookmarkName, double X, double Y);
	__property double DefaultTabStop = {read=FDefaultTabStop, write=SetTabStop};
	
__published:
	__property FileExtension ;
	__property FileDescription ;
	__property BackgroundImage ;
	__property BackgroundImageDisplayType  = {write=SetBackgroundDisplayType, default=5};
	__property TgtRTFEncodingType DocumentEncodingType = {read=FDocumentEncodingType, write=SetDocumentEncodingType, nodefault};
	__property TgtRTFPreferences* Preferences = {read=GetPreferences, write=SetPreferences};
	__property bool RemoveDuplicates = {read=GetRemoveDuplicates, write=SetRemoveDuplicates, default=0};
	
/* Hoisted overloads: */
	
public:
	inline void __fastcall  TextOut(double X, double Y, WideString Text){ TgtCustomPlainsheetEngine::TextOut(X, Y, Text); }
	inline void __fastcall  TextOut(int ColumnNo, WideString Text){ TgtCustomPlainsheetEngine::TextOut(ColumnNo, Text); }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtrtfeng */
using namespace Gtrtfeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtrtfeng
