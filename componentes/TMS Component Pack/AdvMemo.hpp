// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advmemo.pas' rev: 21.00

#ifndef AdvmemoHPP
#define AdvmemoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Rtfengine.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advmemo
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TBorderType { btRaised, btLowered, btFlatRaised, btFlatLowered };
#pragma option pop

#pragma option push -b-
enum TStyleType { stKeyword, stBracket, stSymbol };
#pragma option pop

#pragma option push -b-
enum TAdvMemoStyle { msOffice2003Blue, msOffice2003Olive, msOffice2003Silver, msOffice2003Classic, msOffice2007Luna, msOffice2007Obsidian, msWindowsXP, msWhidbey, msCustom, msOffice2007Silver, msWindowsVista, msWindows7, msTerminal, msOffice2010Blue, msOffice2010Silver, msOffice2010Black };
#pragma option pop

#pragma option push -b-
enum TTokenType { ttNone, ttVar, ttProp, ttEvent, ttMethod, ttFunc, ttProc };
#pragma option pop

#pragma option push -b-
enum TAutoHintParameters { hpAuto, hpManual, hpNone };
#pragma option pop

#pragma option push -b-
enum TAutoHintParameterPosition { hpBelowCode, hpAboveCode };
#pragma option pop

#pragma option push -b-
enum TRegionType { rtOpen, rtClosed, rtFile, rtIgnore };
#pragma option pop

typedef void __fastcall (__closure *TAllowEvent)(System::TObject* Sender, bool &Allow);

typedef void __fastcall (__closure *TAdvMemoFileDropEvent)(System::TObject* Sender, System::UnicodeString FileName, bool &DefaultHandler);

typedef void __fastcall (__closure *TAdvMemoScrollHintEvent)(System::TObject* Sender, int ARow, System::UnicodeString &hintstr);

typedef int TCommand;

struct TCellSize
{
	
public:
	int W;
	int H;
};


struct TCellPos
{
	
public:
	int X;
	int Y;
};


struct TFullPos
{
	
public:
	int LineNo;
	int Pos;
};


struct TStyle
{
	
public:
	bool isComment;
	bool isBracket;
	bool isnumber;
	bool iskeyWord;
	bool isdelimiter;
	bool isURL;
	System::WideChar EndBracket;
	System::WideChar StartBracket;
	int index;
};


class DELPHICLASS TAdvAutoform;
class PASCALIMPLEMENTATION TAdvAutoform : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	bool FShadow;
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__property bool Shadow = {read=FShadow, write=FShadow, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvAutoform(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAdvAutoform(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvAutoform(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvAutoform(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TAdvHintForm;
class PASCALIMPLEMENTATION TAdvHintForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC void __fastcall Paint(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	System::UnicodeString part1;
	System::UnicodeString part2;
	System::UnicodeString part3;
	System::Byte Active;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvHintForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAdvHintForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvHintForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvHintForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TIntList;
class PASCALIMPLEMENTATION TIntList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	int operator[](int index) { return Items[index]; }
	
private:
	void __fastcall SetInteger(int Index, int Value);
	int __fastcall GetInteger(int Index);
	
public:
	__fastcall TIntList(void);
	HIDESBASE int __fastcall IndexOf(int Value);
	__property int Items[int index] = {read=GetInteger, write=SetInteger/*, default*/};
	HIDESBASE void __fastcall Add(int Value);
	HIDESBASE void __fastcall Insert(int Index, int Value);
	HIDESBASE void __fastcall Delete(int Index);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TIntList(void) { }
	
};


class DELPHICLASS TAutoCompletionListBox;
class PASCALIMPLEMENTATION TAutoCompletionListBox : public Stdctrls::TListBox
{
	typedef Stdctrls::TListBox inherited;
	
private:
	Graphics::TBitmap* FBmpVar;
	Graphics::TBitmap* FBmpProp;
	Graphics::TBitmap* FBmpEvent;
	Graphics::TBitmap* FBmpProc;
	Graphics::TBitmap* FBmpMethod;
	bool FShowImages;
	Controls::TImageList* FImages;
	Graphics::TColor FColorVar;
	Graphics::TColor FColorProp;
	Graphics::TColor FColorIdentifier;
	Graphics::TColor FColorFunc;
	Graphics::TColor FColorEvent;
	Graphics::TColor FColorProc;
	Graphics::TColor FColorMethod;
	int FIdentifierWidth;
	void __fastcall SetImages(Controls::TImageList* IL);
	
protected:
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	__property int IdentifierWidth = {read=FIdentifierWidth, nodefault};
	
public:
	int __fastcall AutoAdaptWidth(void);
	__fastcall virtual TAutoCompletionListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TAutoCompletionListBox(void);
	__property Controls::TImageList* ImageList = {read=FImages, write=SetImages};
	
__published:
	__property bool ShowImages = {read=FShowImages, write=FShowImages, default=0};
	__property Graphics::TColor ColorVar = {read=FColorVar, write=FColorVar, nodefault};
	__property Graphics::TColor ColorProp = {read=FColorProp, write=FColorProp, nodefault};
	__property Graphics::TColor ColorEvent = {read=FColorEvent, write=FColorEvent, nodefault};
	__property Graphics::TColor ColorMethod = {read=FColorMethod, write=FColorMethod, nodefault};
	__property Graphics::TColor ColorFunc = {read=FColorFunc, write=FColorFunc, nodefault};
	__property Graphics::TColor ColorProc = {read=FColorProc, write=FColorProc, nodefault};
	__property Graphics::TColor ColorIdentifier = {read=FColorIdentifier, write=FColorIdentifier, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAutoCompletionListBox(HWND ParentWindow) : Stdctrls::TListBox(ParentWindow) { }
	
};


class DELPHICLASS TLineProp;
class PASCALIMPLEMENTATION TLineProp : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::TObject* FObject;
	TIntList* FErrStart;
	TIntList* FErrLen;
	bool FExpanded;
	int FLastChildOfParents;
	bool FHasParent;
	bool FHasChildren;
	void __fastcall SetExpanded(const bool Value);
	bool __fastcall GetLastChild(void);
	void __fastcall SetLastChildOfParents(int Value);
	
public:
	bool BreakPoint;
	bool Executable;
	bool Modified;
	int ImageIndex;
	bool Bookmark;
	TStyle Style;
	bool CachedStyle;
	bool Wrapped;
	__fastcall TLineProp(void);
	__fastcall virtual ~TLineProp(void);
	__property bool HasParent = {read=FHasParent, write=FHasParent, nodefault};
	__property bool HasChildren = {read=FHasChildren, write=FHasChildren, nodefault};
	__property bool Expanded = {read=FExpanded, write=SetExpanded, nodefault};
	__property bool LastChild = {read=GetLastChild, nodefault};
	__property int LastChildOfParents = {read=FLastChildOfParents, write=SetLastChildOfParents, nodefault};
};


typedef void __fastcall (__closure *TOnChangeEvent)(System::TObject* Sender, int ChangeMsg);

class DELPHICLASS TCodeFolding;
class PASCALIMPLEMENTATION TCodeFolding : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FEnabled;
	Graphics::TBitmap* FExpandGlyph;
	Graphics::TBitmap* FCollapsedGlyph;
	Graphics::TColor FLineColor;
	TOnChangeEvent FOnChange;
	void __fastcall SetCollapsedGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetExpandGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetLineColor(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(int ChangeMsg);
	__property TOnChangeEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TCodeFolding(void);
	__fastcall virtual ~TCodeFolding(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, nodefault};
	__property Graphics::TBitmap* ExpandGlyph = {read=FExpandGlyph, write=SetExpandGlyph};
	__property Graphics::TBitmap* CollapsedGlyph = {read=FCollapsedGlyph, write=SetCollapsedGlyph};
};


class DELPHICLASS THintParameter;
class PASCALIMPLEMENTATION THintParameter : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FTextColor;
	Graphics::TColor FBkColor;
	System::WideChar FStartchar;
	System::WideChar FEndchar;
	System::WideChar FDelimiterchar;
	Classes::TStringList* FParameters;
	System::WideChar FWritedelimiterchar;
	void __fastcall SetParameters(const Classes::TStringList* Value);
	
public:
	__fastcall THintParameter(void);
	__fastcall virtual ~THintParameter(void);
	
__published:
	__property Graphics::TColor TextColor = {read=FTextColor, write=FTextColor, nodefault};
	__property Graphics::TColor BkColor = {read=FBkColor, write=FBkColor, nodefault};
	__property System::WideChar HintCharStart = {read=FStartchar, write=FStartchar, nodefault};
	__property System::WideChar HintCharEnd = {read=FEndchar, write=FEndchar, nodefault};
	__property System::WideChar HintCharDelimiter = {read=FDelimiterchar, write=FDelimiterchar, nodefault};
	__property System::WideChar HintCharWriteDelimiter = {read=FWritedelimiterchar, write=FWritedelimiterchar, nodefault};
	__property Classes::TStringList* Parameters = {read=FParameters, write=SetParameters};
};


class DELPHICLASS TCharStyle;
class PASCALIMPLEMENTATION TCharStyle : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FTextColor;
	Graphics::TColor FBkColor;
	Graphics::TFontStyles FStyle;
	
__published:
	__property Graphics::TColor TextColor = {read=FTextColor, write=FTextColor, nodefault};
	__property Graphics::TColor BkColor = {read=FBkColor, write=FBkColor, nodefault};
	__property Graphics::TFontStyles Style = {read=FStyle, write=FStyle, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TCharStyle(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TCharStyle(void) : Classes::TPersistent() { }
	
};


class DELPHICLASS TPrintOptions;
class PASCALIMPLEMENTATION TPrintOptions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FJobName;
	System::UnicodeString FTitle;
	bool FPageNr;
	bool FPrintLineNumbers;
	int FMarginLeft;
	int FMarginRight;
	int FMarginTop;
	int FMarginBottom;
	System::UnicodeString FPagePrefix;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString JobName = {read=FJobName, write=FJobName};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property int MarginLeft = {read=FMarginLeft, write=FMarginLeft, nodefault};
	__property int MarginRight = {read=FMarginRight, write=FMarginRight, nodefault};
	__property int MarginTop = {read=FMarginTop, write=FMarginTop, nodefault};
	__property int MarginBottom = {read=FMarginBottom, write=FMarginBottom, nodefault};
	__property bool PageNr = {read=FPageNr, write=FPageNr, nodefault};
	__property System::UnicodeString PagePrefix = {read=FPagePrefix, write=FPagePrefix};
	__property bool PrintLineNumbers = {read=FPrintLineNumbers, write=FPrintLineNumbers, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPrintOptions(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TPrintOptions(void) : Classes::TPersistent() { }
	
};


class DELPHICLASS TAdvMarker;
class PASCALIMPLEMENTATION TAdvMarker : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FText;
	int FImageIndex;
	int FLineNumber;
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetLineNumber(const int Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TAdvMarker(Classes::TCollection* Collection);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property int LineNumber = {read=FLineNumber, write=SetLineNumber, nodefault};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TAdvMarker(void) { }
	
};


class DELPHICLASS TAdvMarkers;
class PASCALIMPLEMENTATION TAdvMarkers : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvMarker* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FComponent;
	HIDESBASE TAdvMarker* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TAdvMarker* Value);
	int __fastcall GetMarkerCount(void);
	HIDESBASE TAdvMarker* __fastcall Add(void);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvMarkers(Classes::TPersistent* Component);
	__fastcall virtual ~TAdvMarkers(void);
	bool __fastcall HasMarkers(void);
	bool __fastcall HigherMarkerThanLine(int LineNo);
	int __fastcall GetMarkerImageIndex(int LineNo);
	bool __fastcall GetMarkers(TAdvMarkers* Markers);
	TAdvMarker* __fastcall GetMarkerAtLine(int LineNo);
	bool __fastcall MarkerAtLine(int LineNo);
	void __fastcall AddMarker(int LineIndex, int ImageIndex)/* overload */;
	void __fastcall AddMarker(int LineIndex, int ImageIndex, System::UnicodeString MarkerText)/* overload */;
	void __fastcall RemoveMarker(int LineNo);
	void __fastcall AdjustMarkerLineMinus(int StartIndex);
	void __fastcall AdjustMarkerLinePlus(int StartIndex);
	__property int MarkerCount = {read=GetMarkerCount, nodefault};
	__property TAdvMarker* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};


class DELPHICLASS TAdvMarkerList;
class PASCALIMPLEMENTATION TAdvMarkerList : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TComponent* FOwner;
	TAdvMarkers* FMarkers;
	Graphics::TBitmap* FMarkerImage;
	Controls::TImageList* FMarkerImageList;
	int FDefaultMarkerImageIndex;
	bool FUseDefaultMarkerImageIndex;
	void __fastcall SetItems(TAdvMarkers* Value);
	void __fastcall SetMarkerImageList(Controls::TImageList* Il);
	void __fastcall SetDefaultMarkerImageIndex(int MarkerIndex);
	void __fastcall SetUseDefaultMarkerImageIndex(bool Value);
	void __fastcall SetMarkerTransparentColor(Graphics::TColor MarkerTransColor);
	Graphics::TColor __fastcall GetMarkerTransparentColor(void);
	
public:
	__fastcall TAdvMarkerList(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvMarkerList(void);
	void __fastcall FastDeleteAll(void);
	__property TAdvMarkers* Markers = {read=FMarkers, write=SetItems};
	
__published:
	__property Controls::TImageList* MarkerImageList = {read=FMarkerImageList, write=SetMarkerImageList};
	__property bool UseDefaultMarkerImageIndex = {read=FUseDefaultMarkerImageIndex, write=SetUseDefaultMarkerImageIndex, nodefault};
	__property int DefaultMarkerImageIndex = {read=FDefaultMarkerImageIndex, write=SetDefaultMarkerImageIndex, nodefault};
	__property Graphics::TColor ImageTransparentColor = {read=GetMarkerTransparentColor, write=SetMarkerTransparentColor, nodefault};
};


class DELPHICLASS TAdvStylerList;
class PASCALIMPLEMENTATION TAdvStylerList : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TList* FStylerList;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* comp, Classes::TOperation Operation);
	
public:
	__fastcall virtual TAdvStylerList(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvStylerList(void);
	__property Classes::TList* StylerList = {read=FStylerList};
};


class DELPHICLASS TAdvMemoStrings;
class DELPHICLASS TAdvCustomMemo;
class PASCALIMPLEMENTATION TAdvMemoStrings : public Classes::TStringList
{
	typedef Classes::TStringList inherited;
	
private:
	TAdvCustomMemo* Memo;
	int FLockCount;
	bool FDeleting;
	Classes::TList* FLinesProp;
	TIntList* FListLengths;
	bool FNoObjCreate;
	int __fastcall GetRealCount(void);
	System::UnicodeString __fastcall GetTextEx(void);
	void __fastcall SetTextEx(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall SetUpdateState(bool Updating);
	virtual System::UnicodeString __fastcall Get(int Index);
	virtual void __fastcall Put(int Index, const System::UnicodeString S);
	virtual System::TObject* __fastcall GetObject(int Index);
	virtual void __fastcall PutObject(int Index, System::TObject* AObject);
	void __fastcall RestoreObject(int Index, System::TObject* AObject);
	TLineProp* __fastcall CreateProp(int Index);
	void __fastcall ClearLinesProp(void);
	void __fastcall AddLineProp(System::TObject* p);
	TLineProp* __fastcall GetLineProp(int Index);
	void __fastcall SetLineProp(int Index, const TLineProp* Value);
	void __fastcall AssignEx(Classes::TPersistent* Source);
	
public:
	__fastcall TAdvMemoStrings(void);
	__fastcall virtual ~TAdvMemoStrings(void);
	int __fastcall DoAdd(const System::UnicodeString S);
	virtual int __fastcall Add(const System::UnicodeString S);
	virtual int __fastcall AddObject(const System::UnicodeString S, System::TObject* AObject);
	virtual void __fastcall Clear(void);
	void __fastcall ClearStrings(void);
	virtual void __fastcall AddStrings(Classes::TStrings* strings);
	void __fastcall DoInsert(int Index, const System::UnicodeString S);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Insert(int Index, const System::UnicodeString S);
	virtual void __fastcall LoadFromFile(const System::UnicodeString FileName)/* overload */;
	virtual void __fastcall LoadFromStream(Classes::TStream* Stream)/* overload */;
	virtual void __fastcall SaveToFile(const System::UnicodeString FileName)/* overload */;
	__property int RealCount = {read=GetRealCount, nodefault};
	__property System::UnicodeString Text = {read=GetTextEx, write=SetTextEx};
	
__published:
	__property OnChange;
	__property OnChanging;
	
/* Hoisted overloads: */
	
public:
	inline void __fastcall  LoadFromFile(const System::UnicodeString FileName, Sysutils::TEncoding* Encoding){ Classes::TStrings::LoadFromFile(FileName, Encoding); }
	inline void __fastcall  LoadFromStream(Classes::TStream* Stream, Sysutils::TEncoding* Encoding){ Classes::TStrings::LoadFromStream(Stream, Encoding); }
	inline void __fastcall  SaveToFile(const System::UnicodeString FileName, Sysutils::TEncoding* Encoding){ Classes::TStrings::SaveToFile(FileName, Encoding); }
	
};


class DELPHICLASS TAdvActiveLineSettings;
class PASCALIMPLEMENTATION TAdvActiveLineSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvCustomMemo* Memo;
	Graphics::TColor FActiveLineColor;
	Graphics::TColor FActiveLineTextColor;
	bool FActiveLineAtCursor;
	bool FShowActiveLine;
	bool FShowActiveLineIndicator;
	void __fastcall SetShowActiveLine(const bool Value);
	void __fastcall SetShowActiveLineIndicator(const bool Value);
	void __fastcall SetActiveLineColor(const Graphics::TColor Value);
	void __fastcall SetActiveLineTextColor(const Graphics::TColor Value);
	void __fastcall SetActiveLineAtCursor(const bool Value);
	
public:
	__fastcall TAdvActiveLineSettings(TAdvCustomMemo* AOwner);
	
__published:
	__property bool ShowActiveLine = {read=FShowActiveLine, write=SetShowActiveLine, nodefault};
	__property bool ShowActiveLineIndicator = {read=FShowActiveLineIndicator, write=SetShowActiveLineIndicator, nodefault};
	__property Graphics::TColor ActiveLineColor = {read=FActiveLineColor, write=SetActiveLineColor, default=8388608};
	__property bool ActiveLineAtCursor = {read=FActiveLineAtCursor, write=SetActiveLineAtCursor, default=0};
	__property Graphics::TColor ActiveLineTextColor = {read=FActiveLineTextColor, write=SetActiveLineTextColor, default=65535};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TAdvActiveLineSettings(void) { }
	
};


class DELPHICLASS TAdvGutter;
class PASCALIMPLEMENTATION TAdvGutter : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvCustomMemo* Memo;
	int FLeft;
	int FTop;
	int FWidth;
	int FHeight;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	bool FShowLeadingZeros;
	bool FShowGutter;
	int FDigitCount;
	int FGutterWidth;
	int FGutterMargin;
	Graphics::TFont* FFont;
	System::UnicodeString FNumberSuffix;
	Graphics::TColor FLineNumberTextColor;
	bool FShowLineNumbers;
	bool FShowModified;
	int FLineNumberStart;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FModifiedColor;
	Graphics::TColor FModifiedColorBkg;
	Graphics::TColor FBorderColor;
	void __fastcall SetLineNumberTextColor(const Graphics::TColor Value);
	void __fastcall SetGutterWidth(int Value);
	void __fastcall SetGutterMargin(int Value);
	void __fastcall SetGutterColor(Graphics::TColor Value);
	Graphics::TColor __fastcall GetGutterColor(void);
	void __fastcall SetShowLeadingZeros(const bool Value);
	void __fastcall SetDigitCount(const int Value);
	void __fastcall SetFont(Graphics::TFont* Value);
	void __fastcall OnFontChange(System::TObject* Sender);
	void __fastcall SetGutterColorTo(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetGutterColorTo(void);
	void __fastcall SetShowLineNumbers(const bool Value);
	void __fastcall SetLineNumberStart(const int Value);
	void __fastcall SetShowGutter(const bool Value);
	void __fastcall SetShowModified(const bool Value);
	void __fastcall SetNumberSuffix(const System::UnicodeString Value);
	void __fastcall SetParams(int Index, int Value);
	void __fastcall SetModifiedColor(const Graphics::TColor Value);
	void __fastcall SetModifiedColorBkg(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	Types::TRect __fastcall GetRect(void);
	
protected:
	void __fastcall PaintTo(Graphics::TCanvas* ACanvas);
	void __fastcall Invalidate(void);
	
public:
	__fastcall TAdvGutter(TAdvCustomMemo* AOwner);
	__fastcall virtual ~TAdvGutter(void);
	__property int Left = {read=FLeft, write=SetParams, index=0, nodefault};
	__property int Top = {read=FTop, write=SetParams, index=1, nodefault};
	__property int Width = {read=FWidth, write=SetParams, index=2, default=45};
	__property int Height = {read=FHeight, write=SetParams, index=3, nodefault};
	__property Types::TRect FullRect = {read=GetRect};
	
__published:
	__property int DigitCount = {read=FDigitCount, write=SetDigitCount, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=8421504};
	__property int GutterWidth = {read=FGutterWidth, write=SetGutterWidth, default=45};
	__property int GutterMargin = {read=FGutterMargin, write=SetGutterMargin, default=45};
	__property Graphics::TColor GutterColor = {read=GetGutterColor, write=SetGutterColor, default=-16777201};
	__property Graphics::TColor GutterColorTo = {read=GetGutterColorTo, write=SetGutterColorTo, default=16777215};
	__property int LineNumberStart = {read=FLineNumberStart, write=SetLineNumberStart, default=1};
	__property Graphics::TColor LineNumberTextColor = {read=FLineNumberTextColor, write=SetLineNumberTextColor, default=0};
	__property Graphics::TColor ModifiedColorBkg = {read=FModifiedColorBkg, write=SetModifiedColorBkg, default=65280};
	__property Graphics::TColor ModifiedColor = {read=FModifiedColor, write=SetModifiedColor, default=65535};
	__property System::UnicodeString NumberSuffix = {read=FNumberSuffix, write=SetNumberSuffix};
	__property bool ShowLineNumbers = {read=FShowLineNumbers, write=SetShowLineNumbers, default=1};
	__property bool ShowModified = {read=FShowModified, write=SetShowModified, default=0};
	__property bool Visible = {read=FShowGutter, write=SetShowGutter, default=1};
	__property bool ShowLeadingZeros = {read=FShowLeadingZeros, write=SetShowLeadingZeros, default=0};
};


class DELPHICLASS TUndo;
class PASCALIMPLEMENTATION TUndo : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TAdvCustomMemo* Memo;
	int FUndoCurX0;
	int FUndoCurY0;
	int FUndoCurX;
	int FUndoCurY;
	System::UnicodeString FUndoText;
	bool FLinkedUndo;
	
public:
	__fastcall TUndo(int ACurX0, int ACurY0, int ACurX, int ACurY, System::UnicodeString AText);
	virtual bool __fastcall Append(TUndo* NewUndo);
	void __fastcall Undo(void);
	void __fastcall Redo(void);
	virtual void __fastcall PerformUndo(void) = 0 ;
	virtual void __fastcall PerformRedo(void) = 0 ;
	__property bool LinkedUndo = {read=FLinkedUndo, write=FLinkedUndo, nodefault};
	__property int UndoCurX0 = {read=FUndoCurX0, write=FUndoCurX0, nodefault};
	__property int UndoCurY0 = {read=FUndoCurY0, write=FUndoCurY0, nodefault};
	__property int UndoCurX = {read=FUndoCurX, write=FUndoCurX, nodefault};
	__property int UndoCurY = {read=FUndoCurY, write=FUndoCurY, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TUndo(void) { }
	
};


class DELPHICLASS TInsertCharUndo;
class PASCALIMPLEMENTATION TInsertCharUndo : public TUndo
{
	typedef TUndo inherited;
	
public:
	virtual bool __fastcall Append(TUndo* NewUndo);
	virtual void __fastcall PerformUndo(void);
	virtual void __fastcall PerformRedo(void);
public:
	/* TUndo.Create */ inline __fastcall TInsertCharUndo(int ACurX0, int ACurY0, int ACurX, int ACurY, System::UnicodeString AText) : TUndo(ACurX0, ACurY0, ACurX, ACurY, AText) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TInsertCharUndo(void) { }
	
};


class DELPHICLASS TOverwriteCharUndo;
class PASCALIMPLEMENTATION TOverwriteCharUndo : public TUndo
{
	typedef TUndo inherited;
	
public:
	virtual void __fastcall PerformUndo(void);
	virtual void __fastcall PerformRedo(void);
public:
	/* TUndo.Create */ inline __fastcall TOverwriteCharUndo(int ACurX0, int ACurY0, int ACurX, int ACurY, System::UnicodeString AText) : TUndo(ACurX0, ACurY0, ACurX, ACurY, AText) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TOverwriteCharUndo(void) { }
	
};


class DELPHICLASS TDeleteCharUndo;
class PASCALIMPLEMENTATION TDeleteCharUndo : public TUndo
{
	typedef TUndo inherited;
	
private:
	bool FIsBackspace;
	
public:
	virtual bool __fastcall Append(TUndo* NewUndo);
	virtual void __fastcall PerformUndo(void);
	virtual void __fastcall PerformRedo(void);
	__property bool IsBackspace = {read=FIsBackspace, write=FIsBackspace, nodefault};
public:
	/* TUndo.Create */ inline __fastcall TDeleteCharUndo(int ACurX0, int ACurY0, int ACurX, int ACurY, System::UnicodeString AText) : TUndo(ACurX0, ACurY0, ACurX, ACurY, AText) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TDeleteCharUndo(void) { }
	
};


class DELPHICLASS TDeleteLineUndo;
class PASCALIMPLEMENTATION TDeleteLineUndo : public TUndo
{
	typedef TUndo inherited;
	
public:
	virtual void __fastcall PerformUndo(void);
	virtual void __fastcall PerformRedo(void);
public:
	/* TUndo.Create */ inline __fastcall TDeleteLineUndo(int ACurX0, int ACurY0, int ACurX, int ACurY, System::UnicodeString AText) : TUndo(ACurX0, ACurY0, ACurX, ACurY, AText) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TDeleteLineUndo(void) { }
	
};


class DELPHICLASS TSelUndo;
class PASCALIMPLEMENTATION TSelUndo : public TUndo
{
	typedef TUndo inherited;
	
private:
	int FUndoSelStartX;
	int FUndoSelStartY;
	int FUndoSelEndX;
	int FUndoSelEndY;
	
public:
	__property int UndoSelStartX = {read=FUndoSelStartX, write=FUndoSelStartX, nodefault};
	__property int UndoSelStartY = {read=FUndoSelStartY, write=FUndoSelStartY, nodefault};
	__property int UndoSelEndX = {read=FUndoSelEndX, write=FUndoSelEndX, nodefault};
	__property int UndoSelEndY = {read=FUndoSelEndY, write=FUndoSelEndY, nodefault};
public:
	/* TUndo.Create */ inline __fastcall TSelUndo(int ACurX0, int ACurY0, int ACurX, int ACurY, System::UnicodeString AText) : TUndo(ACurX0, ACurY0, ACurX, ACurY, AText) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TSelUndo(void) { }
	
};


class DELPHICLASS TDeleteBufUndo;
class PASCALIMPLEMENTATION TDeleteBufUndo : public TSelUndo
{
	typedef TSelUndo inherited;
	
public:
	virtual void __fastcall PerformUndo(void);
	virtual void __fastcall PerformRedo(void);
public:
	/* TUndo.Create */ inline __fastcall TDeleteBufUndo(int ACurX0, int ACurY0, int ACurX, int ACurY, System::UnicodeString AText) : TSelUndo(ACurX0, ACurY0, ACurX, ACurY, AText) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TDeleteBufUndo(void) { }
	
};


class DELPHICLASS TPasteUndo;
class PASCALIMPLEMENTATION TPasteUndo : public TUndo
{
	typedef TUndo inherited;
	
public:
	__fastcall TPasteUndo(int ACurX0, int ACurY0, int ACurX, int ACurY, System::UnicodeString AText, bool IsLinked);
	virtual void __fastcall PerformUndo(void);
	virtual void __fastcall PerformRedo(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPasteUndo(void) { }
	
};


class DELPHICLASS TInsertOverwriteUndo;
class PASCALIMPLEMENTATION TInsertOverwriteUndo : public TUndo
{
	typedef TUndo inherited;
	
private:
	bool FInsertMode;
	
public:
	__fastcall TInsertOverwriteUndo(bool AInsertMode);
	virtual void __fastcall PerformUndo(void);
	virtual void __fastcall PerformRedo(void);
	__property bool InsertMode = {read=FInsertMode, write=FInsertMode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TInsertOverwriteUndo(void) { }
	
};


class DELPHICLASS TIndentUndo;
class PASCALIMPLEMENTATION TIndentUndo : public TUndo
{
	typedef TUndo inherited;
	
private:
	int FIndent;
	int FSelRowFrom;
	int FSelRowTo;
	
public:
	__fastcall TIndentUndo(int SelFrom, int SelTo, int Indent);
	virtual void __fastcall PerformUndo(void);
	virtual void __fastcall PerformRedo(void);
	__property int Indent = {read=FIndent, write=FIndent, nodefault};
	__property int SelRowFrom = {read=FSelRowFrom, write=FSelRowFrom, nodefault};
	__property int SelRowTo = {read=FSelRowTo, write=FSelRowTo, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TIndentUndo(void) { }
	
};


class DELPHICLASS TCorrectUndo;
class PASCALIMPLEMENTATION TCorrectUndo : public TUndo
{
	typedef TUndo inherited;
	
public:
	__fastcall TCorrectUndo(int LineNo, System::UnicodeString UndoLine);
	virtual void __fastcall PerformUndo(void);
	virtual void __fastcall PerformRedo(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCorrectUndo(void) { }
	
};


class DELPHICLASS TAdvUndoList;
class PASCALIMPLEMENTATION TAdvUndoList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	TUndo* operator[](int Index) { return Items[Index]; }
	
private:
	int FPos;
	TAdvCustomMemo* FMemo;
	bool FIsPerforming;
	int FLimit;
	
protected:
	HIDESBASE TUndo* __fastcall Get(int Index);
	void __fastcall SetLimit(int Value);
	
public:
	__fastcall TAdvUndoList(void);
	__fastcall virtual ~TAdvUndoList(void);
	HIDESBASE int __fastcall Add(void * Item);
	virtual void __fastcall Clear(void);
	HIDESBASE void __fastcall Delete(int Index);
	void __fastcall Undo(void);
	void __fastcall Redo(void);
	__property TUndo* Items[int Index] = {read=Get/*, default*/};
	__property bool IsPerforming = {read=FIsPerforming, write=FIsPerforming, nodefault};
	__property TAdvCustomMemo* Memo = {read=FMemo, write=FMemo};
	__property int Pos = {read=FPos, write=FPos, nodefault};
	__property int Limit = {read=FLimit, write=SetLimit, nodefault};
};


typedef void __fastcall (__closure *TGutterClickEvent)(System::TObject* Sender, int LineNo);

typedef void __fastcall (__closure *TGutterDrawEvent)(System::TObject* Sender, Graphics::TCanvas* ACanvas, int LineNo, const Types::TRect &rct);

typedef void __fastcall (__closure *TUndoChangeEvent)(System::TObject* Sender, bool CanUndo, bool CanRedo);

typedef void __fastcall (__closure *TURLClick)(System::TObject* Sender, System::UnicodeString URL);

#pragma option push -b-
enum TScrollMode { smAuto, smStrict };
#pragma option pop

typedef void __fastcall (__closure *TMemoHintEvent)(System::TObject* Sender, int X, int Y, System::UnicodeString AValue, System::UnicodeString &AHint, bool &Show);

typedef void __fastcall (__closure *TMemoWordEvent)(System::TObject* Sender, System::UnicodeString CurrentWord, System::UnicodeString &NewWord);

typedef void __fastcall (__closure *TMemoBeforeCompleteEvent)(System::TObject* Sender, System::UnicodeString AToken, bool &Show);

typedef void __fastcall (__closure *TMemoGetCompletionListEvent)(System::TObject* Sender, System::UnicodeString AToken, Classes::TStringList* AList);

typedef void __fastcall (__closure *TMemoInsertCompletionEntryEvent)(System::TObject* Sender, System::UnicodeString &AEntry);

typedef int __fastcall (__closure *TMemoSortCompletionListEvent)(System::TObject* Sender, Classes::TStringList* List, int Index1, int Index2);

typedef void __fastcall (__closure *TMemoGetParameterHintEvent)(System::TObject* Sender, System::UnicodeString AToken, System::UnicodeString &AParameterHint, bool &Handled);

#pragma option push -b-
enum TDrawMode { dmScreen, dmHTML, dmPrinter, dmPrintPreview, dmRTF };
#pragma option pop

typedef void __fastcall (__closure *TMemoActiveLineChangeEvent)(int CurYPos);

typedef void __fastcall (__closure *TMemoColumnChangeEvent)(int CurXPos);

typedef void __fastcall (__closure *TMemoMarkerAddedEvent)(int LnNo, System::UnicodeString MarkerText);

typedef void __fastcall (__closure *TMemoMarkerRemovedEvent)(int LnNo);

class DELPHICLASS TAutoCorrect;
class PASCALIMPLEMENTATION TAutoCorrect : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TStringList* FOldValue;
	Classes::TStringList* FNewValue;
	bool FDoAutoCorrect;
	void __fastcall SetDoAutoCorrect(const bool Value);
	void __fastcall SetNewValue(const Classes::TStringList* Value);
	void __fastcall SetOldValue(const Classes::TStringList* Value);
	
public:
	__fastcall TAutoCorrect(void);
	__fastcall virtual ~TAutoCorrect(void);
	
__published:
	__property bool Active = {read=FDoAutoCorrect, write=SetDoAutoCorrect, nodefault};
	__property Classes::TStringList* OldValue = {read=FOldValue, write=SetOldValue};
	__property Classes::TStringList* NewValue = {read=FNewValue, write=SetNewValue};
};


class DELPHICLASS TAutoCompletion;
class PASCALIMPLEMENTATION TAutoCompletion : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvCustomMemo* FOwner;
	bool FShowImages;
	bool FActive;
	int FHeight;
	int FWidth;
	int FDelay;
	Graphics::TColor FColor;
	Graphics::TFont* FFont;
	Graphics::TColor FColorVar;
	Graphics::TColor FColorProp;
	Graphics::TColor FColorIdentifier;
	Graphics::TColor FColorFunc;
	Graphics::TColor FColorEvent;
	Graphics::TColor FColorProc;
	Graphics::TColor FColorMethod;
	bool FSizeDropDown;
	bool FAutoDisplay;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetShowImages(const bool Value);
	void __fastcall SetDelay(const int Value);
	
public:
	__fastcall TAutoCompletion(TAdvCustomMemo* AOwner);
	__fastcall virtual ~TAutoCompletion(void);
	
__published:
	__property bool Active = {read=FActive, write=FActive, default=1};
	__property bool AutoDisplay = {read=FAutoDisplay, write=FAutoDisplay, default=1};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777211};
	__property int Delay = {read=FDelay, write=SetDelay, default=500};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor ColorVar = {read=FColorVar, write=FColorVar, default=16711680};
	__property Graphics::TColor ColorProp = {read=FColorProp, write=FColorProp, default=8421376};
	__property Graphics::TColor ColorMethod = {read=FColorMethod, write=FColorMethod, default=8388608};
	__property Graphics::TColor ColorFunc = {read=FColorFunc, write=FColorFunc, default=8388608};
	__property Graphics::TColor ColorProc = {read=FColorProc, write=FColorProc, default=8388608};
	__property Graphics::TColor ColorEvent = {read=FColorEvent, write=FColorEvent, default=255};
	__property Graphics::TColor ColorIdentifier = {read=FColorIdentifier, write=FColorIdentifier, default=8421376};
	__property int Height = {read=FHeight, write=FHeight, default=100};
	__property bool ShowImages = {read=FShowImages, write=SetShowImages, default=0};
	__property bool SizeDropDown = {read=FSizeDropDown, write=FSizeDropDown, default=1};
	__property int Width = {read=FWidth, write=FWidth, default=200};
};


struct TAdvMemoSavePos
{
	
public:
	int CurX;
	int CurY;
	int LeftCol;
	int TopLine;
	int SelStartX;
	int SelStartY;
	int SelEndX;
	int SelEndY;
};


#pragma option push -b-
enum TAutoCorrectType { acNone, acLineCorrect, acLineCheck, acWordCorrect, acWordCheck };
#pragma option pop

class DELPHICLASS TAdvMemoChecker;
class PASCALIMPLEMENTATION TAdvMemoChecker : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TAdvCustomMemo* FMemo;
	TAutoCorrectType FAutoCorrectType;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	System::UnicodeString __fastcall ReplaceOnce(const System::UnicodeString S, const System::UnicodeString OldPattern, const System::UnicodeString NewPattern);
	void __fastcall AddUndo(int LineNo, System::UnicodeString UndoLine);
	
public:
	__property TAdvCustomMemo* Memo = {read=FMemo, write=FMemo};
	virtual void __fastcall CheckLine(int LineNo);
	virtual void __fastcall CheckWord(int LineNo, int LinePos, System::UnicodeString s);
	virtual void __fastcall CorrectLine(int LineNo);
	virtual void __fastcall CorrectWord(int LineNo, int LinePos, System::UnicodeString &s);
	virtual void __fastcall CheckAllLines(void);
	virtual void __fastcall CorrectAllLines(void);
	__property TAutoCorrectType AutoCorrectType = {read=FAutoCorrectType, write=FAutoCorrectType, default=0};
public:
	/* TComponent.Create */ inline __fastcall virtual TAdvMemoChecker(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TAdvMemoChecker(void) { }
	
};


class DELPHICLASS TAdvMemoCapitalChecker;
class PASCALIMPLEMENTATION TAdvMemoCapitalChecker : public TAdvMemoChecker
{
	typedef TAdvMemoChecker inherited;
	
public:
	__fastcall virtual TAdvMemoCapitalChecker(Classes::TComponent* AOwner);
	virtual void __fastcall CorrectLine(int LineNo);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TAdvMemoCapitalChecker(void) { }
	
};


class DELPHICLASS TAdvMemoSource;
class DELPHICLASS TAdvCustomMemoStyler;
class PASCALIMPLEMENTATION TAdvMemoSource : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TAdvCustomMemoStyler* FSyntaxStyler;
	TAdvMemoStrings* FLines;
	TAdvUndoList* FUndoList;
	int FUndoLimit;
	TAdvCustomMemo* FMemo;
	bool FModified;
	bool FReadOnly;
	TAdvMemoSavePos FCaretInfo;
	TIntList* FBookmarkList;
	bool __fastcall GetReadOnly(void);
	void __fastcall SetReadOnly(const bool Value);
	
protected:
	void __fastcall SetSyntaxStyler(const TAdvCustomMemoStyler* Value);
	void __fastcall SetLines(const TAdvMemoStrings* Value);
	void __fastcall SetMemo(const TAdvCustomMemo* Value);
	bool __fastcall GetModified(void);
	void __fastcall SetModified(const bool Value);
	TAdvUndoList* __fastcall GetUndoList(void);
	void __fastcall SetUndoList(const TAdvUndoList* Value);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TAdvMemoSource(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvMemoSource(void);
	__property bool Modified = {read=GetModified, write=SetModified, nodefault};
	__property TAdvUndoList* UndoList = {read=GetUndoList, write=SetUndoList};
	
__published:
	__property TAdvCustomMemoStyler* SyntaxStyler = {read=FSyntaxStyler, write=SetSyntaxStyler};
	__property TAdvMemoStrings* Lines = {read=FLines, write=SetLines};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, nodefault};
};


#pragma option push -b-
enum TWordWrapStyle { wwNone, wwClientWidth, wwRightMargin };
#pragma option pop

class PASCALIMPLEMENTATION TAdvCustomMemo : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Classes::TComponent* FOwner;
	System::UnicodeString FVersion;
	bool FUseStyler;
	TAdvCustomMemoStyler* FInternalStyles;
	bool FCaseSensitive;
	Forms::TFormBorderStyle FBorderStyle;
	bool FAutoIndent;
	int FMargin;
	bool FHiddenCaret;
	bool FCaretVisible;
	TCellSize FCellSize;
	int FCurX;
	int FCurY;
	int FbackupTopLine;
	int FLeftCol;
	int FTopLine;
	int FTabSize;
	Graphics::TFont* FFont;
	Graphics::TColor FBkColor;
	Graphics::TColor FSelColor;
	Graphics::TColor FSelBkColor;
	bool FReadOnly;
	bool FDelErase;
	bool FShowRightMargin;
	bool FSmartTabs;
	bool FEnhancedHomeKey;
	TAdvMemoStrings* FLines;
	int FSelStartX;
	int FSelStartY;
	int FSelEndX;
	int FSelEndY;
	int FPrevSelX;
	int FPrevSelY;
	Stdctrls::TScrollStyle FScrollBars;
	TAdvActiveLineSettings* FActiveLineSettings;
	TAdvGutter* FGutter;
	Stdctrls::TScrollBar* sbVert;
	Stdctrls::TScrollBar* sbHorz;
	Graphics::TBitmap* FLineBitmap;
	TFullPos FSelCharPos;
	bool FLeftButtonDown;
	bool FSelButtonDown;
	bool FSelClick;
	bool FSelDrag;
	TScrollMode FScrollMode;
	TAdvUndoList* FUndoList;
	int FUndoLimit;
	TStyle FBackupTopStyle;
	System::UnicodeString FTempdelimiters;
	System::UnicodeString FUrlDelimiters;
	Extctrls::TTimer* Timer;
	TAdvHintForm* FHintForm;
	TAutoHintParameters FAutoHintParameters;
	TCharStyle* FUrlStyle;
	bool FUrlAware;
	int FActiveLine;
	bool FCtl3D;
	Controls::TCursor FOldCursor;
	Classes::TStringList* Html;
	System::UnicodeString Htmlfont;
	int FMaxLength;
	bool FLetShowAutoCompletion;
	bool FSearching;
	bool FHintShowing;
	TAutoCompletionListBox* FListCompletion;
	TAdvAutoform* FormAutoCompletion;
	TAutoCompletion* FAutoCompletion;
	TAdvMarkerList* FMarkerList;
	TAdvStylerList* FStylerList;
	Controls::TImageList* FAutoCompletionListImages;
	bool FAutoThemeAdapt;
	Classes::TNotifyEvent FOnChange;
	Classes::TNotifyEvent FOnStatusChange;
	Classes::TNotifyEvent FOnSelectionChange;
	TGutterDrawEvent FOnGutterDraw;
	TGutterClickEvent FOnGutterClick;
	TGutterClickEvent FOnGutterRightClick;
	TUndoChangeEvent FOnUndoChange;
	TURLClick FOnURLClick;
	Classes::TNotifyEvent FOnReplace;
	Classes::TNotifyEvent FOnFind;
	Classes::TNotifyEvent FOnAutoCompletion;
	Classes::TNotifyEvent FOnCancelAutoCompletion;
	Classes::TNotifyEvent FOnStartAutoCompletion;
	TMemoActiveLineChangeEvent FOnActiveLineChange;
	TMemoColumnChangeEvent FOnColumnChange;
	TMemoMarkerAddedEvent FOnMarkerAdded;
	TMemoMarkerRemovedEvent FOnMarkerRemoved;
	TPrintOptions* FPrintOptions;
	TAutoHintParameterPosition FAutoHintParameterPos;
	System::UnicodeString FtmpNoStart;
	System::UnicodeString FtmpNo;
	System::UnicodeString FtmpNoHex;
	unsigned FCaretTime;
	bool FletgetCaretTime;
	bool FTrimTrailingSpaces;
	unsigned FCaretX;
	unsigned FCaretY;
	int BSSelLine;
	int BSSelStart;
	int BSSelLen;
	int BSOldSelLine;
	int BESelLine;
	int BESelStart;
	int BESelLen;
	int BEOldSelLine;
	Classes::TNotifyEvent FOnCursorChange;
	bool FBlockShow;
	Graphics::TColor FBlockColor;
	Graphics::TColor FBlockLineColor;
	bool FOverwrite;
	TAllowEvent FOnOverwriteToggle;
	TMemoHintEvent FOnHintForWord;
	TMemoHintEvent FOnHintForToken;
	Types::TPoint FLastHintPos;
	TMemoWordEvent FonWordComplete;
	bool FWantTab;
	bool FHideSelection;
	TAutoCorrect* FAutoCorrect;
	TMemoBeforeCompleteEvent FOnBeforeAutoComplete;
	TMemoGetCompletionListEvent FOnGetAutoCompletionList;
	int FAutoHintParameterDelay;
	Graphics::TBitmap* FBookmarkBmp;
	TIntList* FBookmarkList;
	TMemoInsertCompletionEntryEvent FOnInsertAutoCompletionEntry;
	TMemoSortCompletionListEvent FOnSortAutoCompletionList;
	TMemoGetParameterHintEvent FOnGetParameterHint;
	bool FAutoExpand;
	bool FAutoCompleteDot;
	Extctrls::TTimer* FAutoCompleteTimer;
	Classes::TStringList* FAutoCompleteList;
	Types::TPoint FDotPoint;
	bool FAllowAutoHint;
	TIntList* FWWList;
	System::UnicodeString FCachedDelimiters;
	TAdvMemoSource* FMemoSource;
	int FRightMargin;
	Graphics::TColor FRightMarginColor;
	Graphics::TColor FBreakpointColor;
	Graphics::TColor FBreakpointTextColor;
	bool FAcceptFiles;
	TWordWrapStyle FWordWrap;
	bool FScrollHint;
	Controls::THintWindow* FScrollHintWindow;
	Classes::TNotifyEvent FOnTopLeftChanged;
	TAdvMemoFileDropEvent FOnFileDrop;
	TAdvMemoScrollHintEvent FOnScrollHint;
	TAdvMemoChecker* FMemoChecker;
	Rtfengine::TRTFEngine* FRTFEngine;
	TCodeFolding* FCodeFolding;
	TGutterClickEvent FOnGutterDblClick;
	bool FCursorChangedTrigered;
	bool FShouldCheckCodeFolding;
	int FCodeFoldingNodeCount;
	Graphics::TColor FBorderColor;
	bool FClearType;
	System::UnicodeString FFixedBlockStart;
	System::UnicodeString FFixedBlockEnd;
	bool FDisableChange;
	void __fastcall OnCodeFoldingChange(System::TObject* Sender, int ChangeMsg);
	TAdvUndoList* __fastcall InternalUndoList(void);
	void __fastcall SetMemoSource(const TAdvMemoSource* Value);
	bool __fastcall GetModified(void);
	void __fastcall SetModified(const bool Value);
	void __fastcall AutoCompleteTimer(System::TObject* Sender);
	void __fastcall UpdateCompletionList(System::UnicodeString token);
	bool __fastcall IsDelimiter(System::WideChar value);
	void __fastcall ShowForm(bool ShowAlways);
	void __fastcall HideForm(void);
	void __fastcall PrepareShowHint(void);
	bool __fastcall SearchParameter(void);
	void __fastcall FormHintMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall Hideauto(System::TObject* Sender);
	void __fastcall ListKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall ListMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormHintClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall TimerHint(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall SetHiddenCaret(bool Value);
	void __fastcall SetScrollBars(Stdctrls::TScrollStyle Value);
	void __fastcall SetUseStyler(const bool Value);
	void __fastcall SetCaseSensitive(bool Value);
	void __fastcall SetCurX(int Value);
	void __fastcall SetCurY(int Value);
	HIDESBASE void __fastcall SetFont(Graphics::TFont* Value);
	HIDESBASE void __fastcall SetColor(int Index, Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetLines(TAdvMemoStrings* ALines);
	void __fastcall ExpandSelection(void);
	System::UnicodeString __fastcall GetSelText(void);
	void __fastcall SetSelText(const System::UnicodeString AValue);
	int __fastcall GetSelLength(void);
	void __fastcall MovePage(int dP, Classes::TShiftState Shift);
	void __fastcall ShowCaret(bool State);
	void __fastcall MakeVisible(void);
	int __fastcall GetVisible(int Index);
	void __fastcall SetMaxLength(void);
	System::UnicodeString __fastcall TrimRightWW(int LineNo);
	MESSAGE void __fastcall WMSysChar(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Messages::TWMContextMenu &Message);
	HIDESBASE MESSAGE void __fastcall WMCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	MESSAGE void __fastcall WMDropFiles(Messages::TMessage &Message);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	void __fastcall SetSmartTabs(const bool Value);
	void __fastcall SetAcceptFiles(const bool Value);
	void __fastcall SetEnhancedHomeKey(const bool Value);
	void __fastcall SetShowRightMargin(const bool Value);
	void __fastcall SetTrimTrailingSpaces(const bool Value);
	System::UnicodeString __fastcall FormatLineNumber(int &Position, int Line);
	void __fastcall MoveCursor(int dX, int dY, Classes::TShiftState Shift);
	void __fastcall ResizeEditor(void);
	void __fastcall ResizeScrollBars(bool DoRepaint);
	void __fastcall ResizeGutter(void);
	void __fastcall DoCommand(int cmd, const Classes::TShiftState AShift);
	void __fastcall DrawLine(Graphics::TCanvas* ACanvas, int LineNo, TStyle &Style, TDrawMode DM, const Types::TRect &PR, int VisLineNo = 0xffffffff);
	void __fastcall DrawHTML(System::UnicodeString Part, TStyle &Drawstyle, int lineno);
	void __fastcall DrawRTF(System::UnicodeString Part, TStyle &Drawstyle, int lineno);
	void __fastcall ExtractURL(System::UnicodeString s, Classes::TStringList* &urls);
	void __fastcall FreshLineBitmap(void);
	void __fastcall SetUndoLimit(int Value);
	int __fastcall GetSelStart(void);
	void __fastcall SetSelStart(const int Value);
	void __fastcall SetSelLength(const int Value);
	void __fastcall SetActiveLine(const int Value);
	void __fastcall SetBorderStyle(const Forms::TBorderStyle Value);
	HIDESBASE void __fastcall SetCtl3D(const bool Value);
	void __fastcall UpdateGutter(void);
	void __fastcall SetLeftCol(const int Value);
	void __fastcall SetWordWrap(const TWordWrapStyle Value);
	void __fastcall SetTopLine(const int Value);
	void __fastcall SetMemoStyler(TAdvCustomMemoStyler* Value);
	TStyle __fastcall GetUpStyle(int stopat);
	void __fastcall SetUrlAware(const bool Value);
	void __fastcall SetUrlStyle(const TCharStyle* Value);
	void __fastcall ScrollVChange(System::TObject* Sender);
	void __fastcall ScrollHChange(System::TObject* Sender);
	bool __fastcall GetBreakPoint(int Index);
	void __fastcall SetBreakPoint(int Index, const bool Value);
	bool __fastcall GetModifiedState(int Index);
	void __fastcall SetModifiedState(int Index, const bool Value);
	bool __fastcall GetWrapped(int Index);
	void __fastcall SetWrapped(int Index, const bool Value);
	bool __fastcall GetBookmark(int Index);
	void __fastcall SetBookmark(int Index, const bool Value);
	bool __fastcall GetExecutable(int Index);
	void __fastcall SetExecutable(int Index, const bool Value);
	void __fastcall SetLineStyle(int Index, const TStyle &LineStyle);
	void __fastcall ClearLineStyles(void);
	void __fastcall ClearLineStylesFromTo(int FromLine, int ToLine);
	bool __fastcall GetLineStyle(int Index, TStyle &LineStyle);
	void __fastcall SwapColors(void);
	void __fastcall SetEventAutoCompletion(void);
	void __fastcall KilleventAutoCompletion(void);
	void __fastcall SetAutoHintParameters(const TAutoHintParameters Value);
	void __fastcall SetPrintOptions(const TPrintOptions* Value);
	void __fastcall SetAutoHintParameterDelay(const int Value);
	int __fastcall GetBookmarks(int Index);
	void __fastcall SetBookmarks(int Index, const int Value);
	TAdvCustomMemoStyler* __fastcall GetInternalStyles(void);
	TAdvMemoStrings* __fastcall GetInternalLines(void);
	void __fastcall SetInternalLines(const TAdvMemoStrings* Value);
	void __fastcall SetRightMargin(const int Value);
	void __fastcall SetRightMarginColor(const Graphics::TColor Value);
	void __fastcall SetBreakpointColor(const Graphics::TColor Value);
	void __fastcall SetBreakpointTextColor(const Graphics::TColor Value);
	void __fastcall SetHideSelection(const bool Value);
	void __fastcall DoActiveLineChange(int LnNo);
	void __fastcall DoColumnChange(int ColNo);
	void __fastcall DoMarkerAdded(int LnNo, System::UnicodeString MarkerText);
	void __fastcall DoMarkerRemoved(int LnNo);
	void __fastcall SearchForStylers(void);
	int __fastcall GetMarkerCount(void);
	void __fastcall SetAutoCompletionListImages(Controls::TImageList* IL);
	void __fastcall SetMemoChecker(const TAdvMemoChecker* AMemoChecker);
	void __fastcall SetVersion(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetCodeFolding(TCodeFolding* Value);
	bool __fastcall GetExpandNode(int Index);
	void __fastcall SetExpandNode(int Index, const bool Value);
	void __fastcall SetAutoThemeAdapt(const bool value);
	System::UnicodeString __fastcall GetWrappedText(void);
	System::UnicodeString __fastcall GetWrappedLine(int index);
	
protected:
	bool FLetRefresh;
	int __fastcall VisIndexToLineIndex(int Index);
	int __fastcall LineIndexToVisIndex(int Index);
	int __fastcall LastChildOfParent(int ParentIndex);
	void __fastcall ExpandParents(int ChildIndex);
	void __fastcall RemoveCodeFoldingFromChild(int EndLineIndex);
	bool __fastcall IsCommentedNode(int LineIndex);
	bool __fastcall GetNodeComments(int LineIndex, int &RgnIndex, System::UnicodeString &Coments);
	void __fastcall ResetMemoState(const TAdvMemoSavePos &value);
	void __fastcall GetMemoState(TAdvMemoSavePos &value);
	__property TAdvCustomMemoStyler* InternalStyles = {read=GetInternalStyles};
	__property TAdvMemoStrings* InternalLines = {read=GetInternalLines, write=SetInternalLines};
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall SelClickUpdate(int X, int Y, bool Down, Classes::TShiftState Shift, Controls::TMouseButton Button);
	Types::TRect __fastcall EditorRect(void);
	Types::TRect __fastcall CodeFoldingRect(void);
	TCellPos __fastcall CellFromPos(int X, int Y);
	Types::TRect __fastcall CellRect(int ACol, int ARow);
	Types::TRect __fastcall LineRect(int ARow);
	Types::TRect __fastcall LineRangeRect(int FromLine, int ToLine);
	Types::TRect __fastcall ColRect(int ACol);
	Types::TRect __fastcall ColRangeRect(int FromCol, int ToCol);
	int __fastcall AddString(System::UnicodeString S);
	void __fastcall InsertString(int Index, System::UnicodeString S);
	void __fastcall GoHome(Classes::TShiftState Shift);
	void __fastcall GoEnd(Classes::TShiftState Shift);
	void __fastcall InsertChar(System::WideChar C);
	void __fastcall DeleteChar(int OldX, int OldY);
	void __fastcall BackSpace(void);
	void __fastcall BackWord(void);
	System::UnicodeString __fastcall IndentCurrLine(void);
	void __fastcall TestforURLClick(System::UnicodeString s);
	bool __fastcall TestforURLMove(System::UnicodeString s, int locx);
	void __fastcall SetBlockMatchStart(int LineNo, int BlockStart, int BlockLen);
	void __fastcall SetBlockMatchEnd(int LineNo, int BlockStart, int BlockLen);
	void __fastcall NewLine(void);
	void __fastcall TabLine(Classes::TShiftState AShift);
	void __fastcall DoEscape(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall DrawMargin(void);
	void __fastcall DrawGutter(void);
	void __fastcall ThemeAdapt(void);
	void __fastcall ScrollBarScroll(System::TObject* Sender, Stdctrls::TScrollCode ScrollCode, int &ScrollPos);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoScroll(Stdctrls::TScrollBar* Sender, int ByValue);
	void __fastcall DoScrollPage(Stdctrls::TScrollBar* Sender, int ByValue);
	__property int MaxLength = {read=FMaxLength, nodefault};
	__property int VisiblePosCount = {read=GetVisible, index=0, nodefault};
	__property int VisibleLineCount = {read=GetVisible, index=1, nodefault};
	__property int LastVisiblePos = {read=GetVisible, index=2, nodefault};
	__property int LastVisibleLine = {read=GetVisible, index=3, nodefault};
	__property bool UseStyler = {read=FUseStyler, write=SetUseStyler, nodefault};
	bool __fastcall DeleteSelectionInt(bool bRepaint);
	void __fastcall LinesChanged(System::TObject* Sender);
	void __fastcall LineRefresh(void);
	void __fastcall CreateAutoCompleteForm(void);
	virtual void __fastcall SelectionChanged(void);
	virtual void __fastcall StatusChanged(void);
	void __fastcall FontChangedProc(System::TObject* Sender);
	virtual bool __fastcall IsWordBoundary(System::WideChar ch);
	virtual bool __fastcall IsTokenBoundary(System::WideChar ch);
	void __fastcall ClearUndoList(void);
	void __fastcall UndoChange(void);
	Controls::TCursor __fastcall GetCursorEx(void);
	virtual void __fastcall CursorChanged(void);
	void __fastcall SetCursorEx(const Controls::TCursor Value);
	virtual bool __fastcall EditCanModify(void);
	void __fastcall InsertTemplate(System::UnicodeString AText);
	void __fastcall OutputHTML(bool FixedFonts);
	void __fastcall OutputRTF(bool FixedFonts);
	void __fastcall DoFind(void);
	void __fastcall DoReplace(void);
	void __fastcall DoWrap(void);
	void __fastcall UndoWrap(void);
	virtual void __fastcall Change(void);
	virtual void __fastcall DoGutterClick(int LineNo);
	virtual void __fastcall DoGetAutoCompletionList(System::UnicodeString AToken, Classes::TStringList* AList);
	__property bool ShowRightMargin = {read=FShowRightMargin, write=SetShowRightMargin, nodefault};
	__property TAutoCorrect* AutoCorrect = {read=FAutoCorrect, write=FAutoCorrect};
	__property bool AutoIndent = {read=FAutoIndent, write=FAutoIndent, default=1};
	__property bool AutoExpand = {read=FAutoExpand, write=FAutoExpand, default=1};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=SetAutoThemeAdapt, default=0};
	__property bool BlockShow = {read=FBlockShow, write=FBlockShow, default=1};
	__property Graphics::TColor BlockColor = {read=FBlockColor, write=FBlockColor, default=16776960};
	__property Graphics::TColor BlockLineColor = {read=FBlockLineColor, write=FBlockLineColor, default=536870911};
	__property TAdvGutter* Gutter = {read=FGutter, write=FGutter};
	__property TAdvActiveLineSettings* ActiveLineSettings = {read=FActiveLineSettings, write=FActiveLineSettings};
	__property int RightMargin = {read=FRightMargin, write=SetRightMargin, default=80};
	__property Graphics::TColor RightMarginColor = {read=FRightMarginColor, write=SetRightMarginColor, nodefault};
	__property Stdctrls::TScrollStyle ScrollBars = {read=FScrollBars, write=SetScrollBars, default=3};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, nodefault};
	__property Graphics::TColor BkColor = {read=FBkColor, write=SetColor, index=0, nodefault};
	__property Graphics::TColor SelColor = {read=FSelColor, write=SetColor, index=1, nodefault};
	__property Graphics::TColor SelBkColor = {read=FSelBkColor, write=SetColor, index=2, nodefault};
	__property bool HiddenCaret = {read=FHiddenCaret, write=SetHiddenCaret, nodefault};
	__property int TabSize = {read=FTabSize, write=FTabSize, nodefault};
	__property bool Searching = {read=FSearching, write=FSearching, nodefault};
	__property TScrollMode ScrollMode = {read=FScrollMode, write=FScrollMode, default=0};
	__property int UndoLimit = {read=FUndoLimit, write=SetUndoLimit, nodefault};
	__property TCharStyle* UrlStyle = {read=FUrlStyle, write=SetUrlStyle};
	__property TAutoCompletion* AutoCompletion = {read=FAutoCompletion, write=FAutoCompletion};
	__property TAutoHintParameters AutoHintParameters = {read=FAutoHintParameters, write=SetAutoHintParameters, default=0};
	__property TAutoHintParameterPosition AutoHintParameterPosition = {read=FAutoHintParameterPos, write=FAutoHintParameterPos, nodefault};
	__property int AutoHintParameterDelay = {read=FAutoHintParameterDelay, write=SetAutoHintParameterDelay, default=2500};
	__property TAdvMemoSource* MemoSource = {read=FMemoSource, write=SetMemoSource};
	__property TAdvMarkerList* MarkerList = {read=FMarkerList, write=FMarkerList};
	__property int MarkerCount = {read=GetMarkerCount, nodefault};
	__property Controls::TImageList* AutoCompletionListImages = {read=FAutoCompletionListImages, write=SetAutoCompletionListImages};
	__property bool TrimTrailingSpaces = {read=FTrimTrailingSpaces, write=SetTrimTrailingSpaces, nodefault};
	__property bool ScrollHint = {read=FScrollHint, write=FScrollHint, nodefault};
	__property bool SmartTabs = {read=FSmartTabs, write=SetSmartTabs, nodefault};
	__property bool EnhancedHomeKey = {read=FEnhancedHomeKey, write=SetEnhancedHomeKey, nodefault};
	__property TAdvMemoChecker* MemoChecker = {read=FMemoChecker, write=SetMemoChecker};
	__property TCodeFolding* CodeFolding = {read=FCodeFolding, write=SetCodeFolding};
	__property TMemoBeforeCompleteEvent OnBeforeAutoCompletion = {read=FOnBeforeAutoComplete, write=FOnBeforeAutoComplete};
	__property Classes::TNotifyEvent OnStartAutoCompletion = {read=FOnStartAutoCompletion, write=FOnStartAutoCompletion};
	__property TMemoGetCompletionListEvent OnGetAutoCompletionList = {read=FOnGetAutoCompletionList, write=FOnGetAutoCompletionList};
	__property Classes::TNotifyEvent OnAutoCompletion = {read=FOnAutoCompletion, write=FOnAutoCompletion};
	__property Classes::TNotifyEvent OnCancelAutoCompletion = {read=FOnCancelAutoCompletion, write=FOnCancelAutoCompletion};
	__property TGutterClickEvent OnGutterClick = {read=FOnGutterClick, write=FOnGutterClick};
	__property TGutterClickEvent OnGutterRightClick = {read=FOnGutterRightClick, write=FOnGutterRightClick};
	__property TGutterClickEvent OnGutterDblClick = {read=FOnGutterDblClick, write=FOnGutterDblClick};
	__property TGutterDrawEvent OnGutterDraw = {read=FOnGutterDraw, write=FOnGutterDraw};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnSelectionChange = {read=FOnSelectionChange, write=FOnSelectionChange};
	__property Classes::TNotifyEvent OnStatusChange = {read=FOnStatusChange, write=FOnStatusChange};
	__property TUndoChangeEvent OnUndoChange = {read=FOnUndoChange, write=FOnUndoChange};
	__property Classes::TNotifyEvent OnFind = {read=FOnFind, write=FOnFind};
	__property Classes::TNotifyEvent OnReplace = {read=FOnReplace, write=FOnReplace};
	__property Classes::TNotifyEvent OnCursorChange = {read=FOnCursorChange, write=FOnCursorChange};
	__property TAllowEvent OnOverwriteToggle = {read=FOnOverwriteToggle, write=FOnOverwriteToggle};
	__property TURLClick OnURLClick = {read=FOnURLClick, write=FOnURLClick};
	__property TMemoHintEvent OnHintForWord = {read=FOnHintForWord, write=FOnHintForWord};
	__property TMemoHintEvent OnHintForToken = {read=FOnHintForToken, write=FOnHintForToken};
	__property TMemoWordEvent OnWordComplete = {read=FonWordComplete, write=FonWordComplete};
	__property TMemoInsertCompletionEntryEvent OnInsertAutoCompletionEntry = {read=FOnInsertAutoCompletionEntry, write=FOnInsertAutoCompletionEntry};
	__property TMemoSortCompletionListEvent OnSortAutoCompletionList = {read=FOnSortAutoCompletionList, write=FOnSortAutoCompletionList};
	__property Classes::TNotifyEvent OnTopLeftChanged = {read=FOnTopLeftChanged, write=FOnTopLeftChanged};
	__property TMemoGetParameterHintEvent OnGetParameterHint = {read=FOnGetParameterHint, write=FOnGetParameterHint};
	__property TAutoCompletionListBox* CompletionList = {read=FListCompletion};
	__property TMemoActiveLineChangeEvent OnActiveLineChange = {read=FOnActiveLineChange, write=FOnActiveLineChange};
	__property TMemoColumnChangeEvent OnColumnChange = {read=FOnColumnChange, write=FOnColumnChange};
	__property TMemoMarkerAddedEvent OnMarkerAdded = {read=FOnMarkerAdded, write=FOnMarkerAdded};
	__property TMemoMarkerRemovedEvent OnMarkerRemoved = {read=FOnMarkerRemoved, write=FOnMarkerRemoved};
	__property TAdvMemoFileDropEvent OnFileDrop = {read=FOnFileDrop, write=FOnFileDrop};
	__property TAdvMemoScrollHintEvent OnScrollHint = {read=FOnScrollHint, write=FOnScrollHint};
	
public:
	__fastcall virtual TAdvCustomMemo(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomMemo(void);
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	void __fastcall DropText(int X, int Y, System::UnicodeString s);
	void __fastcall MouseToCursor(int X, int Y, int &CursorX, int &CursorY);
	void __fastcall UpdateWrap(void);
	int __fastcall GetWrappedLineIndex(int Index);
	void __fastcall CopyToClipBoard(void);
	void __fastcall PasteFromClipBoard(void);
	void __fastcall CutToClipBoard(void);
	void __fastcall SelectAll(void);
	void __fastcall DeleteLine(void);
	void __fastcall ClearBreakpoints(void);
	void __fastcall ClearModified(void);
	void __fastcall ClearExecutableLines(void);
	void __fastcall SetError(int LineNo, int ErrPos, int ErrLen);
	void __fastcall ClearErrors(void);
	void __fastcall ClearLineErrors(int LineNo);
	void __fastcall ClearWordError(int LineNo, int LinePos);
	TFullPos __fastcall CharFromPos(int X, int Y);
	void __fastcall PosFromText(int TextPos, int &X, int &Y);
	void __fastcall TextFromPos(int X, int Y, int &TextPos);
	void __fastcall DeleteSelection(void);
	void __fastcall InsertText(System::UnicodeString AValue);
	void __fastcall InsertTextAtXY(System::UnicodeString AValue, int X, int Y);
	void __fastcall DeleteTextAtXY(int X, int Y, int NumChar);
	void __fastcall BlockIndent(int FromLine, int ToLine, int Indent);
	bool __fastcall GetMarkers(TAdvMarkers* Markers);
	bool __fastcall MarkerAtLine(int LineNo);
	void __fastcall SaveMemoSettingsToFile(System::UnicodeString FileName);
	void __fastcall LoadMemoSettingsFromFile(System::UnicodeString FileName);
	__property TAdvMemoStrings* Lines = {read=FLines, write=SetLines};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, nodefault};
	__property bool Ctl3D = {read=FCtl3D, write=SetCtl3D, nodefault};
	__property bool ClearType = {read=FClearType, write=FClearType, nodefault};
	__property TAdvCustomMemoStyler* SyntaxStyles = {read=FInternalStyles, write=SetMemoStyler};
	__property System::UnicodeString Selection = {read=GetSelText, write=SetSelText};
	__property int SelStart = {read=GetSelStart, write=SetSelStart, nodefault};
	__property int SelLength = {read=GetSelLength, write=SetSelLength, nodefault};
	__property int SelStartX = {read=FSelStartX, nodefault};
	__property int SelStartY = {read=FSelStartY, nodefault};
	__property int SelEndX = {read=FSelEndX, nodefault};
	__property int SelEndY = {read=FSelEndY, nodefault};
	System::UnicodeString __fastcall WordAtCursor(void);
	System::UnicodeString __fastcall WordTillCursor(void);
	System::UnicodeString __fastcall WordAtCursorPos(int &Pos);
	System::UnicodeString __fastcall WordAtXY(int X, int Y);
	System::UnicodeString __fastcall TokenAtXY(int X, int Y);
	System::UnicodeString __fastcall FullWordAtXY(int X, int Y);
	System::UnicodeString __fastcall FullWordAtCursor(void);
	__property bool CaseSensitive = {read=FCaseSensitive, write=SetCaseSensitive, default=0};
	void __fastcall ClearSelection(void);
	void __fastcall ClearBookmarks(void);
	void __fastcall ClearUndoRedo(void);
	void __fastcall GotoBookmark(int Index);
	bool __fastcall HasBookmarks(void);
	bool __fastcall HasMarkers(void);
	int __fastcall FindText(System::UnicodeString SearchStr, Dialogs::TFindOptions Options);
	int __fastcall FindTextInMemo(System::UnicodeString SearchStr, Dialogs::TFindOptions Options);
	int __fastcall FindTextPos(System::UnicodeString SearchStr, Dialogs::TFindOptions Options);
	int __fastcall FindAndReplace(System::UnicodeString SearchStr, System::UnicodeString NewStr, Dialogs::TFindOptions Options);
	void __fastcall Clear(void);
	HIDESBASE void __fastcall SetCursor(int ACurX, int ACurY);
	void __fastcall Undo(void);
	void __fastcall Redo(void);
	void __fastcall AddUndoStep(TUndo* AUndoStep);
	void __fastcall HideHint(void);
	bool __fastcall CanUndo(void);
	bool __fastcall CanRedo(void);
	bool __fastcall CanCopy(void);
	bool __fastcall CanPaste(void);
	void __fastcall GoToMarker(int Marker);
	void __fastcall GoToMarkerName(System::UnicodeString MarkerText);
	void __fastcall AddMarker(int LineIndex, int ImageIndex)/* overload */;
	void __fastcall AddMarker(int LineIndex, int ImageIndex, System::UnicodeString MarkerText)/* overload */;
	void __fastcall RemoveMarker(int LineIndex);
	void __fastcall ClearAllMarkers(void);
	virtual bool __fastcall WordIsURL(System::UnicodeString s);
	bool __fastcall AddCodeFolding(int StartLineIndex, int EndLineIndex);
	void __fastcall RemoveCodeFolding(int StartLineIndex);
	void __fastcall RemoveAllCodeFolding(void);
	bool __fastcall IsNode(int LineIndex);
	void __fastcall ExpandAllNodes(void);
	void __fastcall CollapseAllNodes(void);
	void __fastcall ToggleNode(int LineIndex);
	void __fastcall AutoCodeFold(void);
	__property bool ExpandNode[int Index] = {read=GetExpandNode, write=SetExpandNode};
	__property System::UnicodeString FixedBlockStart = {read=FFixedBlockStart, write=FFixedBlockStart};
	__property System::UnicodeString FixedBlockEnd = {read=FFixedBlockEnd, write=FFixedBlockEnd};
	__property bool AcceptFiles = {read=FAcceptFiles, write=SetAcceptFiles, default=0};
	__property int ActiveLine = {read=FActiveLine, write=SetActiveLine, nodefault};
	__property bool Bookmark[int Index] = {read=GetBookmark, write=SetBookmark};
	__property int Bookmarks[int Index] = {read=GetBookmarks, write=SetBookmarks};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=8421504};
	__property bool BreakPoint[int Index] = {read=GetBreakPoint, write=SetBreakPoint};
	__property bool LineModified[int Index] = {read=GetModifiedState, write=SetModifiedState};
	__property Graphics::TColor BreakpointColor = {read=FBreakpointColor, write=SetBreakpointColor, default=255};
	__property Graphics::TColor BreakpointTextColor = {read=FBreakpointTextColor, write=SetBreakpointTextColor, default=16777215};
	__property bool Executable[int Index] = {read=GetExecutable, write=SetExecutable};
	__property bool HideSelection = {read=FHideSelection, write=SetHideSelection, default=1};
	__property bool Overwrite = {read=FOverwrite, write=FOverwrite, nodefault};
	__property int CurX = {read=FCurX, write=SetCurX, nodefault};
	__property int CurY = {read=FCurY, write=SetCurY, nodefault};
	__property bool DelErase = {read=FDelErase, write=FDelErase, nodefault};
	__property int TopLine = {read=FTopLine, write=SetTopLine, nodefault};
	__property int LeftCol = {read=FLeftCol, write=SetLeftCol, nodefault};
	__property bool UrlAware = {read=FUrlAware, write=SetUrlAware, default=1};
	__property bool WantTab = {read=FWantTab, write=FWantTab, default=1};
	__property TPrintOptions* PrintOptions = {read=FPrintOptions, write=SetPrintOptions};
	__property bool Modified = {read=GetModified, write=SetModified, nodefault};
	__property TWordWrapStyle WordWrap = {read=FWordWrap, write=SetWordWrap, nodefault};
	__property System::UnicodeString WrappedText = {read=GetWrappedText};
	__property System::UnicodeString WrappedLine[int index] = {read=GetWrappedLine};
	bool __fastcall SaveToHTML(System::UnicodeString FileName, bool Fixedfonts = true);
	bool __fastcall SaveToRTF(System::UnicodeString FileName, bool Fixedfonts = true);
	bool __fastcall SaveToRTFStream(Classes::TMemoryStream* AStream, bool Fixedfonts = true);
	void __fastcall CopyHTMLToClipboard(void);
	int __fastcall NumberOfPages(Graphics::TCanvas* ACanvas, int PageWidth, int PageHeight);
	void __fastcall PrintToCanvas(Graphics::TCanvas* ACanvas, int PageWidth, int PageHeight, int PageNr);
	void __fastcall PrintPages(int FromPage, int ToPage);
	void __fastcall Print(void);
	void __fastcall PrintSelection(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	virtual int __fastcall GetVersionNr(void);
	virtual System::UnicodeString __fastcall GetVersionString(void);
	__property TAdvUndoList* UndoList = {read=InternalUndoList};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	void __fastcall SetStyle(TAdvMemoStyle AStyle);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property Controls::TCursor Cursor = {read=GetCursorEx, write=SetCursorEx, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomMemo(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
private:
	void *__ITMSStyle;	/* Advstyleif::ITMSStyle */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Advstyleif::_di_ITMSStyle()
	{
		Advstyleif::_di_ITMSStyle intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator ITMSStyle*(void) { return (ITMSStyle*)&__ITMSStyle; }
	#endif
	
};


class DELPHICLASS TAdvStringList;
class PASCALIMPLEMENTATION TAdvStringList : public Classes::TStringList
{
	typedef Classes::TStringList inherited;
	
private:
	void __fastcall ReadStrings(Classes::TReader* Reader);
	void __fastcall WriteStrings(Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
public:
	/* TStringList.Create */ inline __fastcall TAdvStringList(void)/* overload */ : Classes::TStringList() { }
	/* TStringList.Destroy */ inline __fastcall virtual ~TAdvStringList(void) { }
	
};


class DELPHICLASS TRegionDefinition;
class PASCALIMPLEMENTATION TRegionDefinition : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TRegionType FRegionType;
	System::UnicodeString FRegionEnd;
	System::UnicodeString FIdentifier;
	System::UnicodeString FRegionStart;
	bool FShowComments;
	void __fastcall SetIdentifier(const System::UnicodeString Value);
	void __fastcall SetRegionEnd(const System::UnicodeString Value);
	void __fastcall SetRegionStart(const System::UnicodeString Value);
	void __fastcall SetRegionType(const TRegionType Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TRegionDefinition(Classes::TCollection* Collection);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Identifier = {read=FIdentifier, write=SetIdentifier};
	__property System::UnicodeString RegionStart = {read=FRegionStart, write=SetRegionStart};
	__property System::UnicodeString RegionEnd = {read=FRegionEnd, write=SetRegionEnd};
	__property TRegionType RegionType = {read=FRegionType, write=SetRegionType, nodefault};
	__property bool ShowComments = {read=FShowComments, write=FShowComments, nodefault};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TRegionDefinition(void) { }
	
};


class DELPHICLASS TRegionDefinitions;
class PASCALIMPLEMENTATION TRegionDefinitions : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TRegionDefinition* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FComponent;
	HIDESBASE TRegionDefinition* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TRegionDefinition* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TRegionDefinitions(Classes::TPersistent* Component);
	__fastcall virtual ~TRegionDefinitions(void);
	__property TRegionDefinition* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TRegionDefinition* __fastcall Add(void);
	HIDESBASE TRegionDefinition* __fastcall Insert(int Index);
};


class DELPHICLASS TElementStyles;
class PASCALIMPLEMENTATION TAdvCustomMemoStyler : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TElementStyles* FAllStyles;
	System::UnicodeString FLineComment;
	System::UnicodeString FMultiCommentLeft;
	System::UnicodeString FMultiCommentRight;
	TCharStyle* FCommentStyle;
	TCharStyle* FNumberStyle;
	Classes::TStringList* FlistAuto;
	THintParameter* FHintParameter;
	System::UnicodeString FNumericChars;
	System::UnicodeString FHexIdentifier;
	System::UnicodeString FBlockEnd;
	System::UnicodeString FBlockStart;
	System::UnicodeString FLiteral;
	bool FCustomDraw;
	System::UnicodeString FFilter;
	System::UnicodeString FDefaultExtension;
	System::UnicodeString FExtensions;
	System::UnicodeString FDescription;
	System::UnicodeString FStylerName;
	TRegionDefinitions* FRegionDefinitions;
	virtual void __fastcall SetStyle(const int Index, const TCharStyle* Value);
	void __fastcall SetStyles(const TElementStyles* Value);
	void __fastcall Update(void);
	void __fastcall SetlistAuto(const Classes::TStringList* Value);
	void __fastcall SetRegionDefinitions(TRegionDefinitions* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TAdvCustomMemoStyler(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomMemoStyler(void);
	__property System::UnicodeString Description = {read=FDescription, write=FDescription};
	__property System::UnicodeString Filter = {read=FFilter, write=FFilter};
	__property System::UnicodeString DefaultExtension = {read=FDefaultExtension, write=FDefaultExtension};
	__property System::UnicodeString Extensions = {read=FExtensions, write=FExtensions};
	__property System::UnicodeString StylerName = {read=FStylerName, write=FStylerName};
	__property System::UnicodeString BlockStart = {read=FBlockStart, write=FBlockStart};
	__property System::UnicodeString BlockEnd = {read=FBlockEnd, write=FBlockEnd};
	__property System::UnicodeString LineComment = {read=FLineComment, write=FLineComment};
	__property System::UnicodeString Literal = {read=FLiteral, write=FLiteral};
	__property System::UnicodeString MultiCommentLeft = {read=FMultiCommentLeft, write=FMultiCommentLeft};
	__property System::UnicodeString MultiCommentRight = {read=FMultiCommentRight, write=FMultiCommentRight};
	__property TElementStyles* AllStyles = {read=FAllStyles, write=SetStyles};
	__property TCharStyle* CommentStyle = {read=FCommentStyle, write=SetStyle, index=1};
	__property TCharStyle* NumberStyle = {read=FNumberStyle, write=SetStyle, index=2};
	__property Classes::TStringList* AutoCompletion = {read=FlistAuto, write=SetlistAuto};
	__property THintParameter* HintParameter = {read=FHintParameter, write=FHintParameter};
	__property System::UnicodeString NumericChars = {read=FNumericChars, write=FNumericChars};
	__property System::UnicodeString HexIdentifier = {read=FHexIdentifier, write=FHexIdentifier};
	__property bool CustomDraw = {read=FCustomDraw, write=FCustomDraw, nodefault};
	virtual void __fastcall DrawKeyword(Graphics::TCanvas* Canvas, System::UnicodeString AKeyword, Types::TRect &ARect);
	__property TRegionDefinitions* RegionDefinitions = {read=FRegionDefinitions, write=SetRegionDefinitions};
};


class DELPHICLASS TAdvMemo;
class PASCALIMPLEMENTATION TAdvMemo : public TAdvCustomMemo
{
	typedef TAdvCustomMemo inherited;
	
private:
	bool FInComment;
	int FInBrackets;
	void __fastcall AdvSyntaxMemoChange(System::TObject* Sender);
	void __fastcall AdvSyntaxMemoGutterDraw(System::TObject* Sender, Graphics::TCanvas* ACanvas, int LineNo, const Types::TRect &rct);
	void __fastcall AdvSyntaxMemoGutterClick(System::TObject* Sender, int LineNo);
	void __fastcall LoadStyle(void);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual bool __fastcall IsWordBoundary(System::WideChar ch);
	
public:
	__fastcall virtual TAdvMemo(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvMemo(void);
	void __fastcall RefreshMemo(void);
	__property VisiblePosCount;
	__property VisibleLineCount;
	__property ActiveLine;
	__property MarkerCount;
	
__published:
	__property PopupMenu;
	__property AcceptFiles = {default=0};
	__property ActiveLineSettings;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoCompletion;
	__property AutoCompletionListImages;
	__property AutoCorrect;
	__property AutoHintParameterDelay = {default=2500};
	__property AutoHintParameters = {default=0};
	__property AutoHintParameterPosition;
	__property AutoIndent = {default=1};
	__property AutoExpand = {default=1};
	__property AutoThemeAdapt = {default=0};
	__property BlockShow = {default=1};
	__property BlockColor = {default=16776960};
	__property BlockLineColor = {default=536870911};
	__property BkColor = {index=0, default=16777215};
	__property BorderColor = {default=8421504};
	__property BorderStyle;
	__property BreakpointColor = {default=255};
	__property BreakpointTextColor = {default=16777215};
	__property CaseSensitive = {default=0};
	__property CodeFolding;
	__property Ctl3D;
	__property Cursor;
	__property DelErase;
	__property Enabled = {default=1};
	__property EnhancedHomeKey;
	__property Gutter;
	__property Font;
	__property HiddenCaret;
	__property HideSelection = {default=1};
	__property Lines;
	__property MarkerList;
	__property MemoChecker;
	__property MemoSource;
	__property PrintOptions;
	__property ReadOnly = {default=0};
	__property RightMargin = {default=80};
	__property RightMarginColor;
	__property ScrollBars = {default=3};
	__property ScrollHint;
	__property ScrollMode = {default=0};
	__property SelColor;
	__property SelBkColor;
	__property ShowHint;
	__property ShowRightMargin;
	__property SmartTabs;
	__property SyntaxStyles;
	__property TabOrder = {default=-1};
	__property TabSize;
	__property TabStop = {default=0};
	__property TrimTrailingSpaces;
	__property UndoLimit;
	__property UrlAware = {default=1};
	__property UrlStyle;
	__property UseStyler;
	__property Version;
	__property Visible = {default=1};
	__property WantTab = {default=1};
	__property WordWrap;
	__property OnAutoCompletion;
	__property OnBeforeAutoCompletion;
	__property OnCancelAutoCompletion;
	__property OnCursorChange;
	__property OnEnter;
	__property OnExit;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnDragOver;
	__property OnDragDrop;
	__property OnEndDock;
	__property OnStartDock;
	__property OnEndDrag;
	__property OnGetAutoCompletionList;
	__property OnHintForWord;
	__property OnHintForToken;
	__property OnStartDrag;
	__property OnGutterClick;
	__property OnGutterRightClick;
	__property OnGutterDblClick;
	__property OnGutterDraw;
	__property OnChange;
	__property OnOverwriteToggle;
	__property OnSelectionChange;
	__property OnStartAutoCompletion;
	__property OnStatusChange;
	__property OnUndoChange;
	__property OnURLClick;
	__property OnFind;
	__property OnFileDrop;
	__property OnReplace;
	__property OnWordComplete;
	__property OnInsertAutoCompletionEntry;
	__property OnScrollHint;
	__property OnSortAutoCompletionList;
	__property OnGetParameterHint;
	__property OnTopLeftChanged;
	__property OnActiveLineChange;
	__property OnColumnChange;
	__property OnMarkerAdded;
	__property OnMarkerRemoved;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvMemo(HWND ParentWindow) : TAdvCustomMemo(ParentWindow) { }
	
};


class DELPHICLASS TElementStyle;
class PASCALIMPLEMENTATION TElementStyle : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Classes::TStringList* FKeyWords;
	Graphics::TFont* FFont;
	Graphics::TColor FBGColor;
	System::UnicodeString FInfo;
	TStyleType FStyleType;
	int StyleNo;
	System::WideChar FBracketStart;
	System::WideChar FBracketEnd;
	System::UnicodeString FSymbols;
	void __fastcall SetColorbg(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetKeyWords(const Classes::TStringList* Value);
	void __fastcall SetStyleType(const TStyleType Value);
	void __fastcall SetBracketStart(const System::WideChar Value);
	void __fastcall SetBracketEnd(const System::WideChar Value);
	System::WideChar __fastcall GetBracketStart(void);
	System::WideChar __fastcall GetBracketEnd(void);
	void __fastcall SetSymbols(const System::UnicodeString Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	HIDESBASE void __fastcall Changed(void);
	__fastcall virtual TElementStyle(Classes::TCollection* Collection);
	__fastcall virtual ~TElementStyle(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Classes::TStringList* KeyWords = {read=FKeyWords, write=SetKeyWords};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor BGColor = {read=FBGColor, write=SetColorbg, nodefault};
	__property TStyleType StyleType = {read=FStyleType, write=SetStyleType, nodefault};
	__property System::WideChar BracketStart = {read=GetBracketStart, write=SetBracketStart, nodefault};
	__property System::WideChar BracketEnd = {read=GetBracketEnd, write=SetBracketEnd, nodefault};
	__property System::UnicodeString Symbols = {read=FSymbols, write=SetSymbols};
	__property System::UnicodeString Info = {read=FInfo, write=FInfo};
};


class PASCALIMPLEMENTATION TElementStyles : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TElementStyle* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvMemo* FOwner;
	bool FModified;
	HIDESBASE TElementStyle* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TElementStyle* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	virtual Classes::TCollectionItemClass __fastcall CreateItemClass(void);
	__fastcall TElementStyles(Classes::TComponent* AOwner);
	void __fastcall Init(void);
	HIDESBASE TElementStyle* __fastcall Add(void);
	HIDESBASE TElementStyle* __fastcall Insert(int Index);
	__property TElementStyle* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	bool __fastcall IsWordBoundary(System::WideChar ch);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TElementStyles(void) { }
	
};


class DELPHICLASS TAdvMemoFindDialog;
class PASCALIMPLEMENTATION TAdvMemoFindDialog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FDisplayMessage;
	System::UnicodeString FNotFoundMessage;
	System::UnicodeString FFindText;
	TAdvCustomMemo* FAdvMemo;
	Dialogs::TFindDialog* FindDialog;
	Classes::TNotifyEvent FOnFindDone;
	Classes::TNotifyEvent FOnFindText;
	bool FFocusMemo;
	Dialogs::TFindOptions __fastcall GetFindOptions(void);
	void __fastcall SetFindOptions(const Dialogs::TFindOptions Value);
	System::UnicodeString __fastcall GetFindText(void);
	
protected:
	void __fastcall Find(System::TObject* Sender);
	void __fastcall Close(System::TObject* Sender);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual ~TAdvMemoFindDialog(void);
	__fastcall virtual TAdvMemoFindDialog(Classes::TComponent* AOwner);
	void __fastcall Execute(void);
	void __fastcall CloseDialog(void);
	__property Dialogs::TFindOptions Options = {read=GetFindOptions, write=SetFindOptions, nodefault};
	
__published:
	__property System::UnicodeString NotFoundMessage = {read=FNotFoundMessage, write=FNotFoundMessage};
	__property bool DisplayMessage = {read=FDisplayMessage, write=FDisplayMessage, default=1};
	__property System::UnicodeString FindText = {read=GetFindText, write=FFindText};
	__property bool FocusMemo = {read=FFocusMemo, write=FFocusMemo, default=1};
	__property TAdvCustomMemo* AdvMemo = {read=FAdvMemo, write=FAdvMemo};
	__property Classes::TNotifyEvent OnFindDone = {read=FOnFindDone, write=FOnFindDone};
	__property Classes::TNotifyEvent OnFindText = {read=FOnFindText, write=FOnFindText};
};


class DELPHICLASS TAdvMemoFindReplaceDialog;
class PASCALIMPLEMENTATION TAdvMemoFindReplaceDialog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FDisplayMessage;
	System::UnicodeString FNotFoundMessage;
	System::UnicodeString FFindText;
	TAdvCustomMemo* FAdvMemo;
	Dialogs::TReplaceDialog* ReplaceDialog;
	System::UnicodeString FReplaceText;
	Classes::TNotifyEvent FOnReplaceDone;
	bool FFocusMemo;
	System::UnicodeString __fastcall GetReplaceText(void);
	System::UnicodeString __fastcall GetFindText(void);
	Dialogs::TFindOptions __fastcall GetFindOptions(void);
	void __fastcall SetFindOptions(const Dialogs::TFindOptions Value);
	
protected:
	void __fastcall Find(System::TObject* Sender);
	void __fastcall Close(System::TObject* Sender);
	void __fastcall Replace(System::TObject* Sender);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual ~TAdvMemoFindReplaceDialog(void);
	__fastcall virtual TAdvMemoFindReplaceDialog(Classes::TComponent* AOwner);
	void __fastcall Execute(void);
	void __fastcall CloseDialog(void);
	__property Dialogs::TFindOptions Options = {read=GetFindOptions, write=SetFindOptions, nodefault};
	
__published:
	__property System::UnicodeString NotFoundMessage = {read=FNotFoundMessage, write=FNotFoundMessage};
	__property bool DisplayMessage = {read=FDisplayMessage, write=FDisplayMessage, default=1};
	__property System::UnicodeString FindText = {read=GetFindText, write=FFindText};
	__property System::UnicodeString ReplaceText = {read=GetReplaceText, write=FReplaceText};
	__property TAdvCustomMemo* AdvMemo = {read=FAdvMemo, write=FAdvMemo};
	__property bool FocusMemo = {read=FFocusMemo, write=FFocusMemo, default=1};
	__property Classes::TNotifyEvent OnReplaceDone = {read=FOnReplaceDone, write=FOnReplaceDone};
};


class DELPHICLASS TAdvMemoAction;
class PASCALIMPLEMENTATION TAdvMemoAction : public Actnlist::TAction
{
	typedef Actnlist::TAction inherited;
	
private:
	TAdvCustomMemo* FControl;
	void __fastcall SetControl(TAdvCustomMemo* Value);
	
protected:
	virtual TAdvCustomMemo* __fastcall GetControl(System::TObject* Target);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual ~TAdvMemoAction(void);
	virtual bool __fastcall HandlesTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	__property TAdvCustomMemo* Control = {read=FControl, write=SetControl};
public:
	/* TAction.Create */ inline __fastcall virtual TAdvMemoAction(Classes::TComponent* AOwner) : Actnlist::TAction(AOwner) { }
	
};


class DELPHICLASS TAdvMemoCut;
class PASCALIMPLEMENTATION TAdvMemoCut : public TAdvMemoAction
{
	typedef TAdvMemoAction inherited;
	
public:
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TAdvMemoAction.Destroy */ inline __fastcall virtual ~TAdvMemoCut(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TAdvMemoCut(Classes::TComponent* AOwner) : TAdvMemoAction(AOwner) { }
	
};


class DELPHICLASS TAdvMemoCopy;
class PASCALIMPLEMENTATION TAdvMemoCopy : public TAdvMemoAction
{
	typedef TAdvMemoAction inherited;
	
public:
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TAdvMemoAction.Destroy */ inline __fastcall virtual ~TAdvMemoCopy(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TAdvMemoCopy(Classes::TComponent* AOwner) : TAdvMemoAction(AOwner) { }
	
};


class DELPHICLASS TAdvMemoPaste;
class PASCALIMPLEMENTATION TAdvMemoPaste : public TAdvMemoAction
{
	typedef TAdvMemoAction inherited;
	
public:
	virtual void __fastcall UpdateTarget(System::TObject* Target);
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
public:
	/* TAdvMemoAction.Destroy */ inline __fastcall virtual ~TAdvMemoPaste(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TAdvMemoPaste(Classes::TComponent* AOwner) : TAdvMemoAction(AOwner) { }
	
};


class DELPHICLASS TAdvMemoSelectAll;
class PASCALIMPLEMENTATION TAdvMemoSelectAll : public TAdvMemoAction
{
	typedef TAdvMemoAction inherited;
	
public:
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TAdvMemoAction.Destroy */ inline __fastcall virtual ~TAdvMemoSelectAll(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TAdvMemoSelectAll(Classes::TComponent* AOwner) : TAdvMemoAction(AOwner) { }
	
};


class DELPHICLASS TAdvMemoUndo;
class PASCALIMPLEMENTATION TAdvMemoUndo : public TAdvMemoAction
{
	typedef TAdvMemoAction inherited;
	
public:
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TAdvMemoAction.Destroy */ inline __fastcall virtual ~TAdvMemoUndo(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TAdvMemoUndo(Classes::TComponent* AOwner) : TAdvMemoAction(AOwner) { }
	
};


class DELPHICLASS TAdvMemoRedo;
class PASCALIMPLEMENTATION TAdvMemoRedo : public TAdvMemoAction
{
	typedef TAdvMemoAction inherited;
	
public:
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TAdvMemoAction.Destroy */ inline __fastcall virtual ~TAdvMemoRedo(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TAdvMemoRedo(Classes::TComponent* AOwner) : TAdvMemoAction(AOwner) { }
	
};


class DELPHICLASS TAdvMemoDelete;
class PASCALIMPLEMENTATION TAdvMemoDelete : public TAdvMemoAction
{
	typedef TAdvMemoAction inherited;
	
public:
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	/* TAdvMemoAction.Destroy */ inline __fastcall virtual ~TAdvMemoDelete(void) { }
	
public:
	/* TAction.Create */ inline __fastcall virtual TAdvMemoDelete(Classes::TComponent* AOwner) : TAdvMemoAction(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x5;
static const ShortInt BLD_VER = 0x0;
#define DATE_VER L"Jul, 2010"

}	/* namespace Advmemo */
using namespace Advmemo;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvmemoHPP
