// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advlistv.pas' rev: 21.00

#ifndef AdvlistvHPP
#define AdvlistvHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advlistv
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

#pragma option push -b-
enum TVAlignment { vtaCenter, vtaTop, vtaBottom };
#pragma option pop

struct THDItemExA;
typedef THDItemExA *PHDItemExA;

struct THDItemExW;
typedef THDItemExW *PHDItemExW;

typedef PHDItemExA PHDItemEx;

#pragma pack(push,1)
struct THDItemExA
{
	
public:
	unsigned Mask;
	int cxy;
	char *pszText;
	HBITMAP hbm;
	int cchTextMax;
	int fmt;
	int lParam;
	int iImage;
	int iOrder;
	int hdtype;
	void *pvFilter;
};
#pragma pack(pop)


#pragma pack(push,1)
struct THDItemExW
{
	
public:
	unsigned Mask;
	int cxy;
	System::WideChar *pszText;
	HBITMAP hbm;
	int cchTextMax;
	int fmt;
	int lParam;
	int iImage;
	int iOrder;
	int hdtype;
	void *pvFilter;
};
#pragma pack(pop)


typedef THDItemExA THDItemEx;

struct THDTextFilter;
typedef THDTextFilter *PHDTextFilter;

struct THDTextFilter
{
	
public:
	System::WideChar *pszText;
	int cchTextMax;
};


class DELPHICLASS EAdvListViewError;
class PASCALIMPLEMENTATION EAdvListViewError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EAdvListViewError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EAdvListViewError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EAdvListViewError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EAdvListViewError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EAdvListViewError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EAdvListViewError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EAdvListViewError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EAdvListViewError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EAdvListViewError(void) { }
	
};


#pragma option push -b-
enum TSortDirection { sdAscending, sdDescending };
#pragma option pop

#pragma option push -b-
enum TSortIndicator { siLeft, siRight };
#pragma option pop

#pragma option push -b-
enum TSortStyle { ssAutomatic, ssAlphabetic, ssNumeric, ssDate, ssAlphaNoCase, ssAlphaCase, ssShortDateEU, ssShortDateUS, ssCustom, ssFinancial, ssRaw };
#pragma option pop

#pragma option push -b-
enum TLVExtendedStyle { lvxGridLines, lvxSubItemImages, lvxCheckboxes, lvxTrackSelect, lvxHeaderDragDrop, lvxFullRowSelect, lvxOneClickActivate, lvxTwoClickActivate };
#pragma option pop

typedef Set<TLVExtendedStyle, lvxGridLines, lvxTwoClickActivate>  TLVExtendedStyles;

typedef void __fastcall (__closure *TLVAnchorClick)(System::TObject* Sender, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TDrawItemProp)(System::TObject* Sender, int ItemIndex, int SubitemIndex, Windows::TOwnerDrawState AState, Graphics::TBrush* ABrush, Graphics::TFont* AFont, System::UnicodeString ItemText);

typedef void __fastcall (__closure *TDrawDetailProp)(System::TObject* Sender, int ItemIndex, Windows::TOwnerDrawState AState, Graphics::TBrush* ABrush, Graphics::TFont* AFont, System::UnicodeString ItemText);

typedef void __fastcall (__closure *TDrawItemEvent)(System::TObject* Sender, Graphics::TCanvas* aCanvas, int itemindex, const Types::TRect &Rect, Windows::TOwnerDrawState State);

typedef void __fastcall (__closure *TPrintPageEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, int pagenr, int pagexsize, int pageysize);

typedef void __fastcall (__closure *TSortStartEvent)(System::TObject* Sender, int Column, bool &Enable);

typedef void __fastcall (__closure *TSortDoneEvent)(System::TObject* Sender, int Column);

typedef void __fastcall (__closure *TColumnSizeEvent)(System::TObject* Sender, int Column);

typedef void __fastcall (__closure *TFormatEvent)(System::TObject* Sender, int ACol, TSortStyle &AStyle, System::UnicodeString &aPrefix, System::UnicodeString &aSuffix);

typedef void __fastcall (__closure *TCustomCompareEvent)(System::TObject* Sender, int ACol, const System::UnicodeString str1, const System::UnicodeString str2, int &res);

typedef void __fastcall (__closure *TRawCompareEvent)(System::TObject* Sender, int Col, int Row1, int Row2, int &res);

typedef void __fastcall (__closure *TOnResizeEvent)(System::TObject* Sender);

typedef void __fastcall (__closure *TDoFitToPageEvent)(System::TObject* Sender, double &ScaleFactor, bool &Allow);

typedef void __fastcall (__closure *TPrintColumnWidthEvent)(System::TObject* Sender, int ACol, int &width);

typedef void __fastcall (__closure *TPrintNewPageEvent)(System::TObject* Sender, int ARow, bool &NewPage);

typedef void __fastcall (__closure *TStartColumnTrackEvent)(System::TObject* Sender, int Column, bool &Allow);

typedef void __fastcall (__closure *TEndColumnTrackEvent)(System::TObject* Sender, int Column);

typedef void __fastcall (__closure *TClickCellEvent)(System::TObject* Sender, int iItem, int iSubItem);

typedef void __fastcall (__closure *TEditCellEvent)(System::TObject* Sender, int iItem, int iSubItem, bool &Allow);

typedef void __fastcall (__closure *TFilterChange)(System::TObject* Sender, int iItem);

typedef void __fastcall (__closure *TFilterBtnClick)(System::TObject* Sender, int iItem);

typedef void __fastcall (__closure *TCheckboxClickEvent)(System::TObject* Sender, int iItem, bool State);

typedef void __fastcall (__closure *TURLClickEvent)(System::TObject* Sender, int iItem, System::UnicodeString URL, bool &Handled);

typedef void __fastcall (__closure *TRearrangeEvent)(System::TObject* Sender, const int SwapFrom, const int SwapTo);

struct TLVItemEx;
typedef TLVItemEx *PLVItemEx;

#pragma pack(push,1)
struct TLVItemEx
{
	
public:
	unsigned mask;
	int iItem;
	int iSubItem;
	unsigned state;
	unsigned stateMask;
	char *pszText;
	int cchTextMax;
	int iImage;
	int lParam;
	int iIndent;
};
#pragma pack(pop)


struct TLVHitTestInfoEx;
typedef TLVHitTestInfoEx *PLVHitTestInfoEx;

#pragma pack(push,1)
struct TLVHitTestInfoEx
{
	
public:
	#pragma pack(push,8)
	Types::TPoint pt;
	#pragma pack(pop)
	unsigned flags;
	int iItem;
	int iSubItem;
};
#pragma pack(pop)


#pragma pack(push,1)
struct TLVColumnEx
{
	
public:
	unsigned mask;
	int fmt;
	int cx;
	char *pszText;
	int cchTextMax;
	int iSubItem;
	int iImage;
	int iOrder;
};
#pragma pack(pop)


class DELPHICLASS THTMLSettings;
class PASCALIMPLEMENTATION THTMLSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FSaveColor;
	bool FSaveFonts;
	System::UnicodeString FFooterFile;
	System::UnicodeString FHeaderFile;
	int FBorderSize;
	int FCellSpacing;
	System::UnicodeString FTableStyle;
	System::UnicodeString FPrefixTag;
	System::UnicodeString FSuffixTag;
	int FWidth;
	
public:
	__fastcall THTMLSettings(void);
	
__published:
	__property int BorderSize = {read=FBorderSize, write=FBorderSize, default=1};
	__property int CellSpacing = {read=FCellSpacing, write=FCellSpacing, default=0};
	__property bool SaveColor = {read=FSaveColor, write=FSaveColor, default=1};
	__property bool SaveFonts = {read=FSaveFonts, write=FSaveFonts, default=1};
	__property System::UnicodeString FooterFile = {read=FFooterFile, write=FFooterFile};
	__property System::UnicodeString HeaderFile = {read=FHeaderFile, write=FHeaderFile};
	__property System::UnicodeString TableStyle = {read=FTableStyle, write=FTableStyle};
	__property System::UnicodeString PrefixTag = {read=FPrefixTag, write=FPrefixTag};
	__property System::UnicodeString SuffixTag = {read=FSuffixTag, write=FSuffixTag};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~THTMLSettings(void) { }
	
};


#pragma option push -b-
enum TPrintPosition { ppNone, ppTopLeft, ppTopRight, ppTopCenter, ppBottomLeft, ppBottomRight, ppBottomCenter };
#pragma option pop

#pragma option push -b-
enum TFitToPage { fpNever, fpGrow, fpShrink, fpAlways, fpCustom };
#pragma option pop

#pragma option push -b-
enum TPrintBorders { pbNoborder, pbSingle, pbDouble, pbVertical, pbHorizontal };
#pragma option pop

class DELPHICLASS TPrintsettings;
class PASCALIMPLEMENTATION TPrintsettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TPrintPosition FTime;
	TPrintPosition FDate;
	TPrintPosition FPageNr;
	System::UnicodeString FPageNumSep;
	System::UnicodeString FDateFormat;
	TPrintPosition FTitle;
	Graphics::TFont* FFont;
	Graphics::TFont* FHeaderFont;
	Graphics::TFont* FFooterFont;
	TPrintBorders FBorders;
	Graphics::TPenStyle FBorderStyle;
	System::UnicodeString FTitleText;
	bool FCentered;
	bool FRepeatHeaders;
	int FFooterSize;
	int FHeaderSize;
	int FLeftSize;
	int FRightSize;
	int FColumnSpacing;
	int FRowSpacing;
	Printers::TPrinterOrientation FOrientation;
	System::UnicodeString FPagePrefix;
	System::UnicodeString FPageSuffix;
	int FFixedHeight;
	bool FUseFixedHeight;
	int FFixedWidth;
	bool FUseFixedWidth;
	TFitToPage FFitToPage;
	System::UnicodeString FJobName;
	void __fastcall SetPrintFont(Graphics::TFont* value);
	void __fastcall SetPrintHeaderFont(Graphics::TFont* value);
	void __fastcall SetPrintFooterFont(Graphics::TFont* value);
	
public:
	__fastcall TPrintsettings(void);
	__fastcall virtual ~TPrintsettings(void);
	
__published:
	__property int FooterSize = {read=FFooterSize, write=FFooterSize, nodefault};
	__property int HeaderSize = {read=FHeaderSize, write=FHeaderSize, nodefault};
	__property TPrintPosition Time = {read=FTime, write=FTime, nodefault};
	__property TPrintPosition Date = {read=FDate, write=FDate, nodefault};
	__property System::UnicodeString DateFormat = {read=FDateFormat, write=FDateFormat};
	__property TPrintPosition PageNr = {read=FPageNr, write=FPageNr, nodefault};
	__property TPrintPosition Title = {read=FTitle, write=FTitle, nodefault};
	__property System::UnicodeString TitleText = {read=FTitleText, write=FTitleText};
	__property Graphics::TFont* Font = {read=FFont, write=SetPrintFont};
	__property Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetPrintHeaderFont};
	__property Graphics::TFont* FooterFont = {read=FFooterFont, write=SetPrintFooterFont};
	__property TPrintBorders Borders = {read=FBorders, write=FBorders, nodefault};
	__property Graphics::TPenStyle BorderStyle = {read=FBorderStyle, write=FBorderStyle, nodefault};
	__property bool Centered = {read=FCentered, write=FCentered, nodefault};
	__property bool RepeatHeaders = {read=FRepeatHeaders, write=FRepeatHeaders, nodefault};
	__property int LeftSize = {read=FLeftSize, write=FLeftSize, nodefault};
	__property int RightSize = {read=FRightSize, write=FRightSize, nodefault};
	__property int ColumnSpacing = {read=FColumnSpacing, write=FColumnSpacing, nodefault};
	__property int RowSpacing = {read=FRowSpacing, write=FRowSpacing, nodefault};
	__property Printers::TPrinterOrientation Orientation = {read=FOrientation, write=FOrientation, nodefault};
	__property System::UnicodeString PagePrefix = {read=FPagePrefix, write=FPagePrefix};
	__property System::UnicodeString PageSuffix = {read=FPageSuffix, write=FPageSuffix};
	__property int FixedWidth = {read=FFixedWidth, write=FFixedWidth, nodefault};
	__property int FixedHeight = {read=FFixedHeight, write=FFixedHeight, nodefault};
	__property bool UseFixedHeight = {read=FUseFixedHeight, write=FUseFixedHeight, nodefault};
	__property bool UseFixedWidth = {read=FUseFixedWidth, write=FUseFixedWidth, nodefault};
	__property TFitToPage FitToPage = {read=FFitToPage, write=FFitToPage, nodefault};
	__property System::UnicodeString JobName = {read=FJobName, write=FJobName};
	__property System::UnicodeString PageNumSep = {read=FPageNumSep, write=FPageNumSep};
};


#pragma option push -b-
enum TSizeStorage { stInifile, stRegistry };
#pragma option pop

class DELPHICLASS TColumnSize;
class PASCALIMPLEMENTATION TColumnSize : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FSave;
	System::UnicodeString FKey;
	System::UnicodeString FSection;
	bool FStretch;
	TSizeStorage FStorage;
	Classes::TComponent* Owner;
	void __fastcall SetStretch(bool value);
	void __fastcall SetSave(bool value);
	
public:
	__fastcall TColumnSize(Classes::TComponent* AOwner);
	__fastcall virtual ~TColumnSize(void);
	
__published:
	__property bool Save = {read=FSave, write=SetSave, nodefault};
	__property System::UnicodeString Key = {read=FKey, write=FKey};
	__property System::UnicodeString Section = {read=FSection, write=FSection};
	__property bool Stretch = {read=FStretch, write=SetStretch, nodefault};
	__property TSizeStorage Storage = {read=FStorage, write=FStorage, nodefault};
};


class DELPHICLASS TAdvRichEdit;
class PASCALIMPLEMENTATION TAdvRichEdit : public Comctrls::TRichEdit
{
	typedef Comctrls::TRichEdit inherited;
	
private:
	void __fastcall SelFormat(int offset);
	
public:
	void __fastcall SelSubscript(void);
	void __fastcall SelSuperscript(void);
	void __fastcall SelNormal(void);
public:
	/* TCustomRichEdit.Create */ inline __fastcall virtual TAdvRichEdit(Classes::TComponent* AOwner) : Comctrls::TRichEdit(AOwner) { }
	/* TCustomRichEdit.Destroy */ inline __fastcall virtual ~TAdvRichEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvRichEdit(HWND ParentWindow) : Comctrls::TRichEdit(ParentWindow) { }
	
};


class DELPHICLASS TDetails;
class DELPHICLASS TAdvListView;
class PASCALIMPLEMENTATION TDetails : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvListView* FOwner;
	bool FVisible;
	int FColumn;
	int FHeight;
	Graphics::TFont* FFont;
	bool FSplitLine;
	int FIndent;
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SetVisible(bool AValue);
	void __fastcall SetHeight(int AValue);
	void __fastcall SetColumn(int AValue);
	void __fastcall SetFont(Graphics::TFont* AValue);
	void __fastcall SetIndent(const int Value);
	void __fastcall SetSplitLine(const bool Value);
	
public:
	__fastcall TDetails(Classes::TComponent* AOwner);
	__fastcall virtual ~TDetails(void);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property int Column = {read=FColumn, write=SetColumn, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property int Indent = {read=FIndent, write=SetIndent, nodefault};
	__property bool SplitLine = {read=FSplitLine, write=SetSplitLine, nodefault};
};


class DELPHICLASS TProgressSettings;
class PASCALIMPLEMENTATION TProgressSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FColorTo;
	Graphics::TColor FFontColorTo;
	Graphics::TColor FColorFrom;
	Graphics::TColor FFontColorFrom;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetColorFrom(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetFontColorFrom(const Graphics::TColor Value);
	void __fastcall SetFontColorTo(const Graphics::TColor Value);
	
public:
	__fastcall TProgressSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Changed(void);
	
__published:
	__property Graphics::TColor ColorFrom = {read=FColorFrom, write=SetColorFrom, nodefault};
	__property Graphics::TColor FontColorFrom = {read=FFontColorFrom, write=SetFontColorFrom, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor FontColorTo = {read=FFontColorTo, write=SetFontColorTo, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TProgressSettings(void) { }
	
};


class PASCALIMPLEMENTATION TAdvListView : public Comctrls::TListView
{
	typedef Comctrls::TListView inherited;
	
private:
	TRearrangeEvent FOnReArrange;
	System::UnicodeString FLastAnchor;
	bool FInAnchor;
	bool FHeaderUpdating;
	bool FHeaderTracking;
	Controls::TImageList* FHeaderImages;
	Graphics::TFont* FHeaderFont;
	Graphics::TFont* FDummyFont;
	int FHeaderSize;
	Graphics::TCanvas* FCanvas;
	TDrawItemProp FOnDrawItemProp;
	TDrawDetailProp FOnDrawDetailProp;
	TDrawItemEvent FOnDrawItem;
	TFormatEvent FOnGetFormat;
	TCustomCompareEvent FCustomCompare;
	TRawCompareEvent FRawCompare;
	TSortStartEvent FSortStartEvent;
	TSortDoneEvent FSortDoneEvent;
	TColumnSizeEvent FColumnSizeEvent;
	TColumnSizeEvent FColumnRClickEvent;
	TEndColumnTrackEvent FEndColumnTrack;
	TStartColumnTrackEvent FStartColumnTrack;
	TClickCellEvent FRightClickCell;
	TClickCellEvent FLeftClickCell;
	TCheckboxClickEvent FCheckboxClick;
	TEditCellEvent FCanEditCell;
	TLVAnchorClick FAnchorClick;
	TLVAnchorClick FAnchorEnter;
	TLVAnchorClick FAnchorExit;
	TFilterChange FFilterChange;
	TFilterBtnClick FFilterBtnClick;
	Graphics::TFont* FOldfont;
	Graphics::TBrush* FOldbrush;
	bool FHeaderHotTrack;
	bool FHeaderDragDrop;
	bool FHeaderFlatStyle;
	bool FHeaderOwnerDraw;
	Graphics::TColor FHeaderColor;
	int FHeaderHeight;
	System::WideChar FDelimiter;
	TPrintsettings* FPrintSettings;
	THTMLSettings* FHTMLSettings;
	bool FHTMLHint;
	bool FSubImages;
	Graphics::TBitmap* FWallpaper;
	TAdvRichEdit* FRichEdit;
	int FColumnIndex;
	int FItemIndex;
	System::UnicodeString FItemCaption;
	bool FSubItemEdit;
	bool FSubItemSelect;
	bool FEditBusy;
	bool FFilterBar;
	bool FClipboardEnable;
	TSortDirection FSortDirection;
	bool FSortShow;
	int FSortColumn;
	TSortIndicator FSortIndicator;
	Graphics::TBitmap* FSortUpGlyph;
	Graphics::TBitmap* FSortDownGlyph;
	Graphics::TBitmap* FCheckTrueGlyph;
	Graphics::TBitmap* FCheckFalseGlyph;
	int FItemHeight;
	int FOldSortCol;
	bool FSaveHeader;
	bool FLoadHeader;
	int FHoverTime;
	int FFilterTimeOut;
	bool FWordWrap;
	bool FURLShow;
	bool FURLFull;
	Graphics::TColor FURLColor;
	TColumnSize* FColumnSize;
	int FOldCursor;
	Controls::THintWindow* FScrollHintWnd;
	bool FScrollHint;
	TPrintPageEvent FOnPrintPage;
	TPrintNewPageEvent FOnPrintNewPage;
	TDoFitToPageEvent FDoFitToPage;
	TPrintColumnWidthEvent FOnPrintSetColumnWidth;
	TURLClickEvent FOnURLClick;
	Types::TPoint FLastHintPos;
	bool FSizeWithForm;
	TVAlignment FVAlignment;
	int FVAlign;
	bool FAutoHint;
	Graphics::TColor FSelectionColor;
	bool FSelectionRTFKeep;
	Graphics::TColor FSelectionTextColor;
	int FPrintpagewidth;
	int FPrintcolstart;
	int FPrintcolend;
	int FReArrangeIndex;
	bool FReArrangeItems;
	int FListTimerID;
	TDetails* FDetailView;
	Types::TRect PrevRect;
	double Fontscalefactor;
	StaticArray<int, 257> MaxWidths;
	StaticArray<int, 257> Indents;
	int FComctrlVersion;
	Picturecontainer::TPictureContainer* FContainer;
	Picturecontainer::THTMLPictureCache* FImageCache;
	int FOldSelIdx;
	bool FStretchColumn;
	int FUpdateCount;
	TProgressSettings* FProgressSettings;
	bool FBlockSelection;
	void __fastcall RTFPaint(int itemindex, int subitemindex, Graphics::TCanvas* Canvas, const Types::TRect &arect);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &Message);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	MESSAGE void __fastcall CNMeasureItem(Messages::TWMMeasureItem &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMTimer(Messages::TWMTimer &Msg);
	HIDESBASE MESSAGE void __fastcall WMNotify(Messages::TWMNotify &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &WMScroll);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TMessage &Msg);
	void __fastcall ShowHintProc(System::UnicodeString &HintStr, bool &CanShow, Controls::THintInfo &HintInfo);
	int __fastcall SetValueToAPIValue(TLVExtendedStyles Styles);
	TLVExtendedStyles __fastcall SetValueFromAPIValue(unsigned Styles);
	void __fastcall SetSubItemImage(int ItemIndex, int SubItemindex, int AValue);
	HIDESBASE int __fastcall GetSubItemImage(int ItemIndex, int SubItemindex);
	void __fastcall SetProgress(int ItemIndex, int SubItemindex, int AValue);
	int __fastcall GetProgress(int ItemIndex, int SubItemindex);
	void __fastcall SetSortImage(int AColumn);
	void __fastcall ClearSortImage(int AColumn);
	void __fastcall SetColumnImage(int AColumn, int AValue);
	int __fastcall GetColumnImage(int AColumn);
	void __fastcall SetItemIndent(int itemindex, int subitemindex, int AValue);
	int __fastcall GetItemIndent(int itemindex, int subitemindex);
	Graphics::TBitmap* __fastcall GetUpGlyph(void);
	void __fastcall SetUpGlyph(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetDownGlyph(void);
	void __fastcall SetDownGlyph(Graphics::TBitmap* Value);
	void __fastcall SetCheckTrueGlyph(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetCheckTrueGlyph(void);
	void __fastcall SetCheckFalseGlyph(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetCheckFalseGlyph(void);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	void __fastcall WallPaperChanged(void);
	void __fastcall WallPaperBitmapChange(System::TObject* Sender);
	void __fastcall SetHeaderHotTrack(bool AValue);
	void __fastcall SetHeaderDragDrop(bool AValue);
	void __fastcall SetHeaderFlatStyle(bool AValue);
	void __fastcall SetHeaderOwnerDraw(bool AValue);
	void __fastcall SetHeaderColor(Graphics::TColor AValue);
	void __fastcall SetHeaderHeight(int AValue);
	void __fastcall SetSubImages(bool AValue);
	void __fastcall SetURLColor(Graphics::TColor AColor);
	void __fastcall SetURLShow(bool AValue);
	void __fastcall SetURLFull(bool AValue);
	void __fastcall SetItemHeight(int AValue);
	void __fastcall SetSortDirection(TSortDirection AValue);
	void __fastcall SetSortColumn(int AValue);
	void __fastcall SetSortShow(bool AValue);
	void __fastcall SetHeaderImages(Controls::TImageList* AValue);
	void __fastcall SetHeaderList(unsigned Value, int Flags);
	void __fastcall SetHeaderFont(Graphics::TFont* value);
	void __fastcall HeaderFontChange(System::TObject* Sender);
	HIDESBASE void __fastcall SetHoverTime(int AValue);
	void __fastcall SetFilterTimeOut(int AValue);
	void __fastcall SetExtendedViewStyle(int astyle, bool AValue);
	void __fastcall DoSort(int i);
	void __fastcall SetVAlignment(TVAlignment aVAlignment);
	int __fastcall GetPrintColOffset(int Acol);
	int __fastcall GetPrintColWidth(int Acol);
	void __fastcall InputFromCSV(System::UnicodeString filename, bool insertmode);
	void __fastcall UpdateAlignment(int iItem);
	void __fastcall UpdateHeaderOD(int iItem);
	int __fastcall FocusRepaint(void);
	void __fastcall CopyFunc(bool select);
	void __fastcall PasteFunc(void);
	void __fastcall CutFunc(void);
	int __fastcall GetVisibleItems(void);
	void __fastcall SetContainer(Picturecontainer::TPictureContainer* AContainer);
	void __fastcall SetColumnIndex(const int Value);
	void __fastcall SetFilterBar(const bool Value);
	void __fastcall SetStretchColumn(const bool Value);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall LVDrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetExtendedStyles(TLVExtendedStyles Val);
	TLVExtendedStyles __fastcall GetExtendedStyles(void);
	void __fastcall BuildPage(Graphics::TCanvas* Canvas, bool preview);
	int __fastcall MapFontHeight(int pointsize);
	int __fastcall MapFontSize(int height);
	DYNAMIC void __fastcall ColClick(Comctrls::TListColumn* Column);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall SelectionChanged(int iItem);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall LeftClickCell(int item, int subitem);
	virtual void __fastcall RightClickCell(int item, int subitem);
	virtual void __fastcall QueryDrawProp(int item, int subitem, Windows::TOwnerDrawState aState, Graphics::TBrush* ABrush, Graphics::TFont* AFont, System::UnicodeString itemtext);
	unsigned __fastcall HeaderHandle(void);
	TAdvRichEdit* __fastcall GetRichEdit(void);
	DYNAMIC void __fastcall DoStartDrag(Controls::TDragObject* &DragObject);
	
public:
	__property System::WideChar Delimiter = {read=FDelimiter, write=FDelimiter, nodefault};
	__fastcall virtual TAdvListView(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvListView(void);
	virtual int __fastcall GetVersionNr(void);
	virtual System::UnicodeString __fastcall GetVersionString(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SaveToFile(System::UnicodeString filename, bool SaveWithHTML = true, bool Unicode = true);
	void __fastcall SaveToCSV(System::UnicodeString filename, bool SaveWithHTML = true, bool Unicode = true);
	void __fastcall LoadFromFile(System::UnicodeString filename);
	void __fastcall LoadFromCSV(System::UnicodeString filename);
	void __fastcall InsertFromCSV(System::UnicodeString FileName);
	void __fastcall SaveToDOC(System::UnicodeString Filename, bool SaveWithHTML = true);
	void __fastcall SaveToXLS(System::UnicodeString Filename, bool SaveWithHTML = true);
	void __fastcall LoadFromXLS(System::UnicodeString Filename);
	void __fastcall SaveToStream(Classes::TStream* stream, bool SaveWithHTML = true);
	void __fastcall LoadFromStream(Classes::TStream* stream);
	void __fastcall SaveToHTML(System::UnicodeString filename, bool SaveWithHTML = true);
	void __fastcall SaveToXML(System::UnicodeString FileName, System::UnicodeString ListDescr, System::UnicodeString RecordDescr, Classes::TStringList* FieldDescr, bool SaveWithHTML = true);
	void __fastcall SaveToAscii(System::UnicodeString filename, bool SaveWithHTML = true);
	void __fastcall Print(void);
	void __fastcall Preview(Graphics::TCanvas* Canvas, const Types::TRect &DisplayRect);
	virtual void __fastcall Clear(void);
	void __fastcall ClearInit(int r, int c);
	void __fastcall Sort(void);
	void __fastcall StretchRightColumn(void);
	void __fastcall AutoSizeColumn(int i);
	void __fastcall AutoSizeColumns(void);
	void __fastcall LoadColumnSizes(void);
	void __fastcall SaveColumnSizes(void);
	void __fastcall SelectItem(int aIdx);
	void __fastcall SwapItems(int aIdx1, int aIdx2);
	void __fastcall MoveItem(int aIdx1, int aIdx2);
	void __fastcall MoveColumn(int aIdx1, int aIdx2);
	void __fastcall SwapColumns(int aIdx1, int aIdx2);
	void __fastcall RichToItem(int itemindex, int subitemindex, Comctrls::TRichEdit* RichEditor);
	void __fastcall ItemToRich(int itemindex, int subitemindex, Comctrls::TRichEdit* RichEditor);
	int __fastcall IndexOfColumn(int DisplIndex);
	System::UnicodeString __fastcall GetTextAtPoint(int x, int y);
	bool __fastcall GetIndexAtPoint(int x, int y, int &iItem, int &iSubItem);
	System::UnicodeString __fastcall GetTextAtColRow(int c, int r);
	void __fastcall SetTextAtColRow(int c, int r, const System::UnicodeString s);
	Types::TRect __fastcall GetItemRect(int iItem, int iSubItem);
	void __fastcall GetFormat(int ACol, TSortStyle &AStyle, System::UnicodeString &aPrefix, System::UnicodeString &aSuffix);
	void __fastcall CustCompare(int ACol, const System::UnicodeString str1, const System::UnicodeString str2, int &res);
	void __fastcall RawCompare(int ACol, int ARow1, int ARow2, int &res);
	__property int SubItemImages[int ItemIndex][int SubItemIndex] = {read=GetSubItemImage, write=SetSubItemImage};
	__property int Progress[int ItemIndex][int SubItemIndex] = {read=GetProgress, write=SetProgress};
	__property int ColumnImages[int AColumn] = {read=GetColumnImage, write=SetColumnImage};
	__property int ItemIndents[int ItemIndex][int SubItemIndex] = {read=GetItemIndent, write=SetItemIndent};
	__property int SortColumn = {read=FSortColumn, write=SetSortColumn, nodefault};
	__property int PrintPageWidth = {read=FPrintpagewidth, nodefault};
	__property int PrintColWidth[int aCol] = {read=GetPrintColWidth};
	__property int PrintColOffset[int aCol] = {read=GetPrintColOffset};
	__property int PrintColStart = {read=FPrintcolstart, nodefault};
	__property int PrintColEnd = {read=FPrintcolend, nodefault};
	__property TAdvRichEdit* RichEdit = {read=GetRichEdit};
	__property int ComCtrlVersion = {read=FComctrlVersion, nodefault};
	void __fastcall CutToClipboard(void);
	void __fastcall CopyToClipBoard(void);
	void __fastcall CopySelectionToClipboard(void);
	void __fastcall PasteFromClipboard(void);
	void __fastcall ShowFilter(bool onoff);
	System::UnicodeString __fastcall GetFilter(int index, int filtertype);
	void __fastcall SetFilter(int index, int filtertype, int ivalue, System::UnicodeString sValue);
	void __fastcall EditFilter(int index);
	__property int VersionNr = {read=GetVersionNr, nodefault};
	__property System::UnicodeString VersionString = {read=GetVersionString};
	__property int VisibleItems = {read=GetVisibleItems, nodefault};
	void __fastcall ReOrganize(void);
	void __fastcall SetHeaderSize(int AValue);
	void __fastcall DrawHeaderItem(const tagDRAWITEMSTRUCT &DrawItemStruct);
	void __fastcall StartEdit(int Item, int SubItem);
	void __fastcall SetEditText(const System::UnicodeString AValue);
	void __fastcall HilightInList(System::UnicodeString HiText, bool DoCase);
	void __fastcall UnHilightInList(void);
	void __fastcall HilightInItem(int ItemIndex, System::UnicodeString HiText, bool DoCase);
	void __fastcall UnHilightInItem(int ItemIndex);
	void __fastcall MarkInList(System::UnicodeString HiText, bool DoCase);
	void __fastcall UnMarkInList(void);
	void __fastcall MarkInItem(int ItemIndex, System::UnicodeString HiText, bool DoCase);
	void __fastcall UnMarkInItem(int ItemIndex);
	__property int ColumnIndex = {read=FColumnIndex, write=SetColumnIndex, nodefault};
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	
__published:
	__property bool AutoHint = {read=FAutoHint, write=FAutoHint, nodefault};
	__property Graphics::TBitmap* CheckTrueGlyph = {read=GetCheckTrueGlyph, write=SetCheckTrueGlyph};
	__property Graphics::TBitmap* CheckFalseGlyph = {read=GetCheckFalseGlyph, write=SetCheckFalseGlyph};
	__property Columns;
	__property bool ClipboardEnable = {read=FClipboardEnable, write=FClipboardEnable, nodefault};
	__property TColumnSize* ColumnSize = {read=FColumnSize, write=FColumnSize};
	__property bool FilterBar = {read=FFilterBar, write=SetFilterBar, default=0};
	__property int FilterTimeOut = {read=FFilterTimeOut, write=SetFilterTimeOut, nodefault};
	__property TPrintsettings* PrintSettings = {read=FPrintSettings, write=FPrintSettings};
	__property bool HTMLHint = {read=FHTMLHint, write=FHTMLHint, nodefault};
	__property THTMLSettings* HTMLSettings = {read=FHTMLSettings, write=FHTMLSettings};
	__property Graphics::TColor HeaderColor = {read=FHeaderColor, write=SetHeaderColor, default=536870911};
	__property bool HeaderHotTrack = {read=FHeaderHotTrack, write=SetHeaderHotTrack, nodefault};
	__property bool HeaderDragDrop = {read=FHeaderDragDrop, write=SetHeaderDragDrop, nodefault};
	__property bool HeaderFlatStyle = {read=FHeaderFlatStyle, write=SetHeaderFlatStyle, nodefault};
	__property bool HeaderOwnerDraw = {read=FHeaderOwnerDraw, write=SetHeaderOwnerDraw, nodefault};
	__property int HeaderHeight = {read=FHeaderHeight, write=SetHeaderHeight, nodefault};
	__property Controls::TImageList* HeaderImages = {read=FHeaderImages, write=SetHeaderImages};
	__property Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetHeaderFont};
	__property int HoverTime = {read=FHoverTime, write=SetHoverTime, nodefault};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=SetContainer};
	__property TProgressSettings* ProgressSettings = {read=FProgressSettings, write=FProgressSettings};
	__property bool SelectionRTFKeep = {read=FSelectionRTFKeep, write=FSelectionRTFKeep, nodefault};
	__property bool ScrollHint = {read=FScrollHint, write=FScrollHint, nodefault};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=FSelectionColor, nodefault};
	__property Graphics::TColor SelectionTextColor = {read=FSelectionTextColor, write=FSelectionTextColor, nodefault};
	__property bool SizeWithForm = {read=FSizeWithForm, write=FSizeWithForm, nodefault};
	__property TSortDirection SortDirection = {read=FSortDirection, write=SetSortDirection, nodefault};
	__property bool SortShow = {read=FSortShow, write=SetSortShow, nodefault};
	__property TSortIndicator SortIndicator = {read=FSortIndicator, write=FSortIndicator, nodefault};
	__property Graphics::TBitmap* SortUpGlyph = {read=GetUpGlyph, write=SetUpGlyph};
	__property Graphics::TBitmap* SortDownGlyph = {read=GetDownGlyph, write=SetDownGlyph};
	__property bool StretchColumn = {read=FStretchColumn, write=SetStretchColumn, nodefault};
	__property bool SubImages = {read=FSubImages, write=SetSubImages, nodefault};
	__property bool SubItemEdit = {read=FSubItemEdit, write=FSubItemEdit, nodefault};
	__property bool SubItemSelect = {read=FSubItemSelect, write=FSubItemSelect, nodefault};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property bool URLShow = {read=FURLShow, write=SetURLShow, default=0};
	__property bool URLFull = {read=FURLFull, write=SetURLFull, default=0};
	__property TVAlignment VAlignment = {read=FVAlignment, write=SetVAlignment, nodefault};
	__property Graphics::TBitmap* Wallpaper = {read=FWallpaper, write=SetWallpaper};
	__property bool WordWrap = {read=FWordWrap, write=FWordWrap, default=0};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, nodefault};
	__property bool SaveHeader = {read=FSaveHeader, write=FSaveHeader, nodefault};
	__property bool LoadHeader = {read=FLoadHeader, write=FLoadHeader, nodefault};
	__property bool ReArrangeItems = {read=FReArrangeItems, write=FReArrangeItems, nodefault};
	__property TDetails* DetailView = {read=FDetailView, write=FDetailView};
	__property TDrawDetailProp OnDrawDetailProp = {read=FOnDrawDetailProp, write=FOnDrawDetailProp};
	__property TDrawItemProp OnDrawItemProp = {read=FOnDrawItemProp, write=FOnDrawItemProp};
	__property TDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
	__property TFormatEvent OnGetFormat = {read=FOnGetFormat, write=FOnGetFormat};
	__property TCustomCompareEvent OnCustomCompare = {read=FCustomCompare, write=FCustomCompare};
	__property TRawCompareEvent OnRawCompare = {read=FRawCompare, write=FRawCompare};
	__property TSortStartEvent OnSortStart = {read=FSortStartEvent, write=FSortStartEvent};
	__property TSortDoneEvent OnSortDone = {read=FSortDoneEvent, write=FSortDoneEvent};
	__property TColumnSizeEvent OnColumnSized = {read=FColumnSizeEvent, write=FColumnSizeEvent};
	__property TColumnSizeEvent OnColumnRClick = {read=FColumnRClickEvent, write=FColumnRClickEvent};
	__property TPrintPageEvent OnPrintPage = {read=FOnPrintPage, write=FOnPrintPage};
	__property TDoFitToPageEvent OnFitToPage = {read=FDoFitToPage, write=FDoFitToPage};
	__property TPrintColumnWidthEvent OnPrintSetColumnWidth = {read=FOnPrintSetColumnWidth, write=FOnPrintSetColumnWidth};
	__property TPrintNewPageEvent OnPrintNewPage = {read=FOnPrintNewPage, write=FOnPrintNewPage};
	__property TStartColumnTrackEvent OnStartColumnTrack = {read=FStartColumnTrack, write=FStartColumnTrack};
	__property TEndColumnTrackEvent OnEndColumnTrack = {read=FEndColumnTrack, write=FEndColumnTrack};
	__property TClickCellEvent OnRightClickCell = {read=FRightClickCell, write=FRightClickCell};
	__property TClickCellEvent OnLeftClickCell = {read=FLeftClickCell, write=FLeftClickCell};
	__property TEditCellEvent OnCanEditCell = {read=FCanEditCell, write=FCanEditCell};
	__property TFilterChange OnFilterChange = {read=FFilterChange, write=FFilterChange};
	__property TFilterBtnClick OnFilterBtnClick = {read=FFilterBtnClick, write=FFilterBtnClick};
	__property TLVAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TLVAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TLVAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property TCheckboxClickEvent OnCheckboxClick = {read=FCheckboxClick, write=FCheckboxClick};
	__property TURLClickEvent OnURLClick = {read=FOnURLClick, write=FOnURLClick};
	__property TRearrangeEvent OnRearrange = {read=FOnReArrange, write=FOnReArrange};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvListView(HWND ParentWindow) : Comctrls::TListView(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x6;
static const ShortInt REL_VER = 0x5;
static const ShortInt BLD_VER = 0x0;
#define DATE_VER L"Jul, 2010"
static const Word alvHDS_FILTERBAR = 0x100;
static const Word alvHDI_FILTER = 0x100;
static const ShortInt alvHDFT_ISSTRING = 0x0;
static const ShortInt alvHDFT_ISNUMBER = 0x1;
static const short alvHDN_FILTERCHANGING = -312;
static const short alvHDN_FILTERBTNCLICK = -313;
static const Word alvHDM_SETFILTERCHANGETIMEOUT = 0x1216;
static const Word alvHDM_EDITFILTER = 0x1217;
static const Word MAX_COLUMNS = 0x100;
static const Word MAX_TEXTSIZE = 0x400;
static const ShortInt CHECKBOX_SIZE = 0xe;
static const ShortInt COLUMN_SPACING = 0x2;
static const Word crURLcursor = 0x1f53;
extern PACKAGE StaticArray<System::Word, 3> Alignments;
extern PACKAGE StaticArray<System::Word, 2> WordWraps;
extern PACKAGE StaticArray<System::Word, 2> EndEllips;
extern PACKAGE StaticArray<int, 8> API_STYLES;

}	/* namespace Advlistv */
using namespace Advlistv;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvlistvHPP
