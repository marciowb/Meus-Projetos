// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advgrid.pas' rev: 21.00

#ifndef AdvgridHPP
#define AdvgridHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Advutil.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Asgspin.hpp>	// Pascal unit
#include <Asgedit.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Asgcombo.hpp>	// Pascal unit
#include <Richedit.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Asgcheck.hpp>	// Pascal unit
#include <Asghtmle.hpp>	// Pascal unit
#include <Basegrid.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Olectnrs.hpp>	// Pascal unit
#include <Advxpvs.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Winspool.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Asgdd.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Advobj.hpp>	// Pascal unit
#include <Advdatetimepicker.hpp>	// Pascal unit
#include <Advhintinfo.hpp>	// Pascal unit
#include <Advdropdown.hpp>	// Pascal unit
#include <Advtrackbardropdown.hpp>	// Pascal unit
#include <Advmemodropdown.hpp>	// Pascal unit
#include <Advcalculatordropdown.hpp>	// Pascal unit
#include <Advtimepickerdropdown.hpp>	// Pascal unit
#include <Advdetaildropdown.hpp>	// Pascal unit
#include <Advmulticolumndropdown.hpp>	// Pascal unit
#include <Advcolorpickerdropdown.hpp>	// Pascal unit
#include <Advimagepickerdropdown.hpp>	// Pascal unit
#include <Advcustomgriddropdown.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advgrid
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

__interface ICellGraphic;
typedef System::DelphiInterface<ICellGraphic> _di_ICellGraphic;
class DELPHICLASS TAdvStringGrid;
__interface  INTERFACE_UUID("{0712BE3F-5C9A-4771-BF71-4C987CDC39B3}") ICellGraphic  : public System::IInterface 
{
	
public:
	virtual void __fastcall Draw(Graphics::TCanvas* Canvas, const Types::TRect &R, int Col, int Row, bool Selected, TAdvStringGrid* Grid) = 0 ;
	virtual int __fastcall CellWidth(void) = 0 ;
	virtual int __fastcall CellHeight(void) = 0 ;
	virtual bool __fastcall IsBackground(void) = 0 ;
};

class DELPHICLASS TWinCtrl;
class PASCALIMPLEMENTATION TWinCtrl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	/* TWinControl.Create */ inline __fastcall virtual TWinCtrl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TWinCtrl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TWinCtrl(void) { }
	
};


typedef StaticArray<bool, 513> TBoolArray;

typedef TBoolArray *PBoolArray;

typedef StaticArray<short, 513> TWidthArray;

#pragma option push -b-
enum TAdvGridStyle { gsOffice2003Blue, gsOffice2003Silver, gsOffice2003Olive, gsOffice2003Classic, gsOffice2007Luna, gsOffice2007Obsidian, gsWindowsXP, gsWhidbey, gsCustom, gsOffice2007Silver, gsWindowsVista, gsWindows7, gsTerminal, gsOffice2010Blue, gsOffice2010Silver, gsOffice2010Black };
#pragma option pop

class DELPHICLASS EAdvGridError;
class PASCALIMPLEMENTATION EAdvGridError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EAdvGridError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EAdvGridError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EAdvGridError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EAdvGridError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EAdvGridError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EAdvGridError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EAdvGridError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EAdvGridError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EAdvGridError(void) { }
	
};


typedef void __fastcall (__closure *TDropDownButtonClickEvent)(System::TObject* Sender, int ACol, int ARow, int ButtonIndex);

typedef void __fastcall (__closure *TRatingChangeEvent)(System::TObject* Sender, int ACol, int ARow, double &NewRate, bool &Allow);

typedef void __fastcall (__closure *TRadioClickEvent)(System::TObject* Sender, int ACol, int ARow, int AIdx);

typedef void __fastcall (__closure *TRadioButtonClickEvent)(System::TObject* Sender, int ACol, int ARow);

typedef void __fastcall (__closure *TComboChangeEvent)(System::TObject* Sender, int ACol, int ARow, int AItemIndex, System::UnicodeString ASelection);

typedef void __fastcall (__closure *TComboObjectChangeEvent)(System::TObject* Sender, int ACol, int ARow, int AItemIndex, System::UnicodeString ASelection, System::TObject* AObject);

typedef void __fastcall (__closure *TFloatSpinClickEvent)(System::TObject* Sender, int ACol, int ARow, double AValue, bool UpDown);

typedef void __fastcall (__closure *TDateTimeSpinClickEvent)(System::TObject* Sender, int ACol, int ARow, System::TDateTime AValue, bool UpDown);

#pragma option push -b-
enum TSearchAction { saFindFirst, saFindPrevious, saFindNext };
#pragma option pop

typedef void __fastcall (__closure *TSearchFooterActionEvent)(System::TObject* Sender, System::UnicodeString Value, int ACol, int ARow, TSearchAction SearchAction);

typedef void __fastcall (__closure *TCellSaveLoadEvent)(System::TObject* Sender, int ACol, int ARow, System::UnicodeString &Value);

#pragma option push -b-
enum TScrollHintType { shNone, shVertical, shHorizontal, shBoth };
#pragma option pop

#pragma option push -b-
enum TFilterOperation { foSHORT, foNONE, foAND, foXOR, foOR };
#pragma option pop

typedef void __fastcall (__closure *TCustomFilterEvent)(System::TObject* Sender, int ARow, bool &AcceptRow);

#pragma option push -b-
enum TPrintPosition { ppNone, ppTopLeft, ppTopRight, ppTopCenter, ppBottomLeft, ppBottomRight, ppBottomCenter };
#pragma option pop

#pragma option push -b-
enum TPrintBorders { pbNoborder, pbSingle, pbDouble, pbVertical, pbHorizontal, pbAround, pbAroundVertical, pbAroundHorizontal, pbCustom };
#pragma option pop

#pragma option push -b-
enum TPrintMethod { prPreview, prPrint, prCalcPrint, prCalcPreview };
#pragma option pop

#pragma option push -b-
enum TSortDirection { sdAscending, sdDescending };
#pragma option pop

#pragma option push -b-
enum TIntelliPan { ipVertical, ipHorizontal, ipBoth, ipNone };
#pragma option pop

#pragma option push -b-
enum TScrollType { ssNormal, ssFlat, ssEncarta };
#pragma option pop

#pragma option push -b-
enum TXPColorScheme { xpNone, xpBlue, xpGreen, xpGray, vistaAero };
#pragma option pop

#pragma option push -b-
enum TGridLook { glStandard, glSoft, glClassic, glTMS, glXP, glListView, glVista, glWin7, glOffice2007, glCustom };
#pragma option pop

typedef void __fastcall (__closure *TGridProgressEvent)(System::TObject* Sender, short progress);

typedef void __fastcall (__closure *TClipboardEvent)(System::TObject* Sender, bool &Allow);

typedef void __fastcall (__closure *TNodeClickEvent)(System::TObject* Sender, int ARow, int ARowreal);

typedef void __fastcall (__closure *TNodeAllowEvent)(System::TObject* Sender, int ARow, int ARowReal, bool &Allow);

typedef void __fastcall (__closure *TSelectionResizeEvent)(System::TObject* Sender, const Grids::TGridRect &OrigSelection, const Grids::TGridRect &NewSelection);

typedef void __fastcall (__closure *TGridWideHintEvent)(System::TObject* Sender, int ARow, int ACol, System::WideString &hintstr);

typedef void __fastcall (__closure *TOleDragDropEvent)(System::TObject* Sender, int ARow, int ACol, System::UnicodeString data, bool &Allow);

typedef void __fastcall (__closure *TOleDropFileEvent)(System::TObject* Sender, int ARow, int ACol, System::UnicodeString FileName, bool &Allow);

typedef void __fastcall (__closure *TOleDropURLEvent)(System::TObject* Sender, int ARow, int ACol, System::UnicodeString URL, bool &Allow);

typedef void __fastcall (__closure *TOleDragOverEvent)(System::TObject* Sender, int ARow, int ACol, bool &Allow);

typedef void __fastcall (__closure *TOleDragStartEvent)(System::TObject* Sender, int ARow, int ACol);

typedef void __fastcall (__closure *TOleDragStopEvent)(System::TObject* Sender, int OLEEffect);

typedef void __fastcall (__closure *TOleDropColEvent)(System::TObject* Sender, int ARow, int ACol, int DropCol);

typedef void __fastcall (__closure *TOleDroppedEvent)(System::TObject* Sender, const Grids::TGridRect &ARect);

typedef void __fastcall (__closure *TRowChangingEvent)(System::TObject* Sender, int OldRow, int NewRow, bool &Allow);

typedef void __fastcall (__closure *TRowChangedEvent)(System::TObject* Sender, int OldRow, int NewRow);

typedef void __fastcall (__closure *TColChangingEvent)(System::TObject* Sender, int OldCol, int NewCol, bool &Allow);

typedef void __fastcall (__closure *TCellChangingEvent)(System::TObject* Sender, int OldRow, int OldCol, int NewRow, int NewCol, bool &Allow);

typedef void __fastcall (__closure *TAutoAdvanceEvent)(System::TObject* Sender, int OldRow, int OldCol, int &NewRow, int &NewCol, bool &Allow);

typedef void __fastcall (__closure *TGridPrintPageEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, int PageNr, int PageXSize, int PageYSize);

typedef void __fastcall (__closure *TGridPrintStartEvent)(System::TObject* Sender, int NrOfPages, int &FromPage, int &ToPage);

typedef void __fastcall (__closure *TGridPrintPageDoneEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, int LastRow, int LastRowOffset, int LastPage, int PageXSize, int PageYSize);

typedef void __fastcall (__closure *TGridPrintCancelEvent)(System::TObject* Sender, int PageNr, bool &Cancel);

typedef void __fastcall (__closure *TGridPrintNewPageEvent)(System::TObject* Sender, int ARow, bool &NewPage);

typedef void __fastcall (__closure *TGridPrintColumnWidthEvent)(System::TObject* Sender, int ACol, int &Width);

typedef void __fastcall (__closure *TGridPrintRowHeightEvent)(System::TObject* Sender, int ARow, int &Height);

typedef void __fastcall (__closure *TCustomStrToDateEvent)(System::TObject* Sender, System::UnicodeString Value, System::TDateTime &ADate);

typedef void __fastcall (__closure *TCanClickCellEvent)(System::TObject* Sender, int ARow, int ACol, bool &Allow);

typedef void __fastcall (__closure *TColorSelectedEvent)(System::TObject* Sender, int ACol, int ARow, Graphics::TColor &Color, System::UnicodeString &Value);

typedef void __fastcall (__closure *TColorSelectEvent)(System::TObject* Sender, int ACol, int ARow, Graphics::TColor Color, System::UnicodeString Value);

typedef void __fastcall (__closure *TImageSelectedEvent)(System::TObject* Sender, int ACol, int ARow, int &Index);

typedef void __fastcall (__closure *TImageSelectEvent)(System::TObject* Sender, int ACol, int ARow, int Index);

typedef void __fastcall (__closure *TIsFixedCellEvent)(System::TObject* Sender, int ARow, int ACol, bool &IsFixed);

typedef void __fastcall (__closure *TIsPasswordCellEvent)(System::TObject* Sender, int ARow, int ACol, bool &IsPassword);

typedef void __fastcall (__closure *TCellControlEvent)(System::TObject* Sender, int ARow, int ACol, System::UnicodeString CtrlID, System::UnicodeString CtrlType, System::UnicodeString CtrlVal);

typedef void __fastcall (__closure *TCellComboControlEvent)(System::TObject* Sender, int ARow, int ACol, System::UnicodeString CtrlID, System::UnicodeString CtrlType, System::UnicodeString CtrlVal, Classes::TStringList* Values, bool &Edit, int &DropCount);

typedef void __fastcall (__closure *TCellComboControlSelectEvent)(System::TObject* Sender, int ARow, int ACol, int ItemIndex, System::UnicodeString CtrlID, System::UnicodeString CtrlValue);

typedef void __fastcall (__closure *TCellValidateEvent)(System::TObject* Sender, int ACol, int ARow, System::UnicodeString &Value, bool &Valid);

typedef void __fastcall (__closure *TCellValidateWideEvent)(System::TObject* Sender, int ACol, int ARow, System::WideString &Value, bool &Valid);

typedef void __fastcall (__closure *TEditChangeEvent)(System::TObject* Sender, int ACol, int ARow, System::UnicodeString Value);

typedef void __fastcall (__closure *TEditCellDoneEvent)(System::TObject* Sender, int ACol, int ARow);

typedef void __fastcall (__closure *TDateTimeChangeEvent)(System::TObject* Sender, int ACol, int ARow, System::TDateTime ADateTime);

typedef void __fastcall (__closure *TCellsChangedEvent)(System::TObject* Sender, const Types::TRect &R);

typedef void __fastcall (__closure *TGetCheckEvent)(System::TObject* Sender, int ACol, int ARow, System::UnicodeString &Value);

class DELPHICLASS TEditLink;
typedef void __fastcall (__closure *TGetEditorPropEvent)(System::TObject* Sender, int ACol, int ARow, TEditLink* AEditLink);

typedef void __fastcall (__closure *TCustomCellSizeEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, int ACol, int ARow, Types::TPoint &ASize, bool Printing);

typedef void __fastcall (__closure *TDoFitToPageEvent)(System::TObject* Sender, double &ScaleFactor, bool &Allow);

typedef void __fastcall (__closure *TBeforeCellPasteEvent)(System::TObject* Sender, int ACol, int ARow, System::UnicodeString &Value, bool &Allow);

typedef void __fastcall (__closure *TAfterCellPasteEvent)(System::TObject* Sender, int ACol, int ARow, System::UnicodeString Value);

typedef void __fastcall (__closure *TBeforeCellPasteWideEvent)(System::TObject* Sender, int ACol, int ARow, System::WideString &Value, bool &Allow);

typedef void __fastcall (__closure *TAfterCellPasteWideEvent)(System::TObject* Sender, int ACol, int ARow, System::WideString Value);

typedef void __fastcall (__closure *TSelectionChanged)(System::TObject* Sender, int ALeft, int ATop, int ARight, int ABottom);

typedef void __fastcall (__closure *TRowDisjunctSelectEvent)(System::TObject* Sender, int ARow, bool AState, bool &Allow);

#pragma option push -b-
enum TFindParameters { fnMatchCase, fnMatchFull, fnMatchRegular, fnDirectionLeftRight, fnMatchStart, fnFindInCurrentRow, fnFindInCurrentCol, fnIncludeFixed, fnAutoGoto, fnIgnoreHTMLTags, fnBackward, fnIncludeHiddenColumns, fnFindInPresetCol, fnFindInPresetRow, fnSelectedCells, fnIncludeHiddenRows };
#pragma option pop

#pragma option push -b-
enum TCellHAlign { haLeft, haRight, haCenter, haBeforeText, haAfterText, haFull };
#pragma option pop

#pragma option push -b-
enum TCellVAlign { vaTop, vaBottom, vaCenter, vaUnderText, vaAboveText, vaFull };
#pragma option pop

#pragma option push -b-
enum TCellType { ctBitmap, ctIcon, ctNone, ctImageList, ctCheckBox, ctDataCheckBox, ctRotated, ctDataImage, ctNode, ctRadio, ctEmpty, ctImages, ctPicture, ctFilePicture, ctValue, ctProgress, ctComment, ctButton, ctBitButton, ctVirtCheckBox, ctRowCheckBox, ctProgressPie, ctSummary, ctRangeIndicator, ctXPProgress, ctInterface, ctScrollbar, ctRadioButton, ctBalloon, ctShape, ctRating };
#pragma option pop

#pragma option push -b-
enum TFitToPage { fpNever, fpGrow, fpShrink, fpAlways, fpCustom };
#pragma option pop

typedef Set<TFindParameters, fnMatchCase, fnIncludeHiddenRows>  TFindParams;

#pragma option push -b-
enum TStretchMode { noStretch, Stretch, StretchWithAspectRatio, Shrink, ShrinkWithAspectRatio };
#pragma option pop

#pragma option push -b-
enum TSortBlankPosition { blFirst, blLast };
#pragma option pop

#pragma option push -b-
enum TScrollBarAlways { saNone, saVert, saHorz, saBoth };
#pragma option pop

typedef void __fastcall (__closure *TScrollCellEvent)(System::TObject* Sender, int ACol, int ARow, int ScrollPosition, int ScrollMin, int ScrollMax);

typedef void __fastcall (__closure *THasComboEvent)(System::TObject* Sender, int ACol, int ARow, bool &HasComboBox);

typedef void __fastcall (__closure *THasSpinEditEvent)(System::TObject* Sender, int ACol, int ARow, bool &HasSpinEdit);

#pragma option push -b-
enum TGridExportState { esExportStart, esExportNewRow, esExportDone, esExportSelRow, esExportFail, esExportNextRow };
#pragma option pop

#pragma option push -b-
enum TGridImportState { isImportStart, isImportNewRow, isImportDone, isImportSelRow };
#pragma option pop

typedef void __fastcall (__closure *TCalcFooterEvent)(System::TObject* Sender, int ACol, int ARow, System::UnicodeString &Value);

typedef void __fastcall (__closure *TWordWrapEvent)(System::TObject* Sender, int ACol, int ARow, bool &WordWrap);

typedef void __fastcall (__closure *TGroupCalcEvent)(System::TObject* Sender, int ACol, int FromRow, int ToRow, double &Res);

typedef void __fastcall (__closure *TFixedDropDownEvent)(System::TObject* Sender, int ACol, int ARow, Menus::TPopupMenu* &AMenu, bool &KeepFixedCellHighlighted);

typedef void __fastcall (__closure *TCanShowFixedDropDownEvent)(System::TObject* Sender, int ACol, bool &CanShow);

class DELPHICLASS TDragScrollDelays;
class PASCALIMPLEMENTATION TDragScrollDelays : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FInitialDelay;
	int FRepeatDelay;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int InitialDelay = {read=FInitialDelay, write=FInitialDelay, default=1000};
	__property int RepeatDelay = {read=FRepeatDelay, write=FRepeatDelay, default=250};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TDragScrollDelays(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TDragScrollDelays(void) : Classes::TPersistent() { }
	
};


class DELPHICLASS TDragScrollMargins;
class PASCALIMPLEMENTATION TDragScrollMargins : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FTopMargin;
	int FBottomMargin;
	int FLeftMargin;
	int FRightMargin;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int TopMargin = {read=FTopMargin, write=FTopMargin, default=50};
	__property int BottomMargin = {read=FBottomMargin, write=FBottomMargin, default=50};
	__property int LeftMargin = {read=FLeftMargin, write=FLeftMargin, default=50};
	__property int RightMargin = {read=FRightMargin, write=FRightMargin, default=50};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TDragScrollMargins(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TDragScrollMargins(void) : Classes::TPersistent() { }
	
};


class DELPHICLASS TDragScrollOptions;
class PASCALIMPLEMENTATION TDragScrollOptions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FActive;
	TDragScrollDelays* FDelays;
	TDragScrollMargins* FMargins;
	
public:
	__fastcall TDragScrollOptions(void);
	__fastcall virtual ~TDragScrollOptions(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Active = {read=FActive, write=FActive, default=0};
	__property TDragScrollDelays* Delays = {read=FDelays, write=FDelays};
	__property TDragScrollMargins* Margins = {read=FMargins, write=FMargins};
};


#pragma option push -b-
enum TDragScrollDirections { dsdUp, dsdDown, dsdLeft, dsdRight };
#pragma option pop

typedef Set<TDragScrollDirections, dsdUp, dsdRight>  TDragScrollDirection;

typedef void __fastcall (__closure *TDragScrollEvent)(System::TObject* Sender, int TopRow, int LeftCol, TDragScrollDirection &DragScrollDir, bool &CanScroll);

typedef void __fastcall (__closure *TDropSelectEvent)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TFilterSelectEvent)(System::TObject* Sender, int Column, int ItemIndex, System::UnicodeString FriendlyName, System::UnicodeString &FilterCondition);

typedef void __fastcall (__closure *TGetColumnFilterEvent)(System::TObject* Sender, int Column, Classes::TStrings* Filter);

class DELPHICLASS TDropList;
class PASCALIMPLEMENTATION TDropList : public Stdctrls::TListBox
{
	typedef Stdctrls::TListBox inherited;
	
private:
	TDropSelectEvent FOnSelect;
	
protected:
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	
__published:
	__property TDropSelectEvent OnSelect = {read=FOnSelect, write=FOnSelect};
public:
	/* TCustomListBox.Create */ inline __fastcall virtual TDropList(Classes::TComponent* AOwner) : Stdctrls::TListBox(AOwner) { }
	/* TCustomListBox.Destroy */ inline __fastcall virtual ~TDropList(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDropList(HWND ParentWindow) : Stdctrls::TListBox(ParentWindow) { }
	
};


class DELPHICLASS TFilterDropDown;
class PASCALIMPLEMENTATION TFilterDropDown : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FAutoSize;
	int FHeight;
	int FWidth;
	Graphics::TColor FColor;
	Graphics::TFont* FFont;
	Graphics::TBitmap* FGlyph;
	Graphics::TBitmap* FGlyphActive;
	bool FColumnWidth;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphActive(const Graphics::TBitmap* Value);
	
protected:
	void __fastcall GlyphChanged(System::TObject* Sender);
	
public:
	__fastcall TFilterDropDown(void);
	__fastcall virtual ~TFilterDropDown(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, default=0};
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=-16777211};
	__property bool ColumnWidth = {read=FColumnWidth, write=FColumnWidth, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int Height = {read=FHeight, write=FHeight, default=150};
	__property int Width = {read=FWidth, write=FWidth, default=150};
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property Graphics::TBitmap* GlyphActive = {read=FGlyphActive, write=SetGlyphActive};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TCellGraphic;
class PASCALIMPLEMENTATION TCellGraphic : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TCellType FCellType;
	Graphics::TBitmap* FCellBitmap;
	Graphics::TIcon* FCellIcon;
	TCellVAlign FCellVAlign;
	TCellHAlign FCellHAlign;
	int FCellIndex;
	bool FCellTransparent;
	bool FCellCreated;
	bool FCellBoolean;
	int FCellAngle;
	double FCellValue;
	int FCellErrFrom;
	int FCellErrLen;
	System::UnicodeString FCellText;
	System::Variant FCellVar;
	
public:
	__fastcall TCellGraphic(void);
	__fastcall virtual ~TCellGraphic(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall SetInterfacedCell(Classes::TInterfacedPersistent* AObject);
	void __fastcall SetBitmap(Graphics::TBitmap* ABmp, bool Transparent, TCellHAlign hal, TCellVAlign val);
	void __fastcall SetPicture(Graphics::TPicture* APicture, bool Transparent, TStretchMode StretchMode, int padding, TCellHAlign hal, TCellVAlign val);
	void __fastcall SetFilePicture(Advobj::TFilePicture* APicture, bool Transparent, TStretchMode stretchmode, int padding, TCellHAlign hal, TCellVAlign val);
	void __fastcall SetImageIdx(int idx, TCellHAlign hal, TCellVAlign val);
	void __fastcall SetDataImage(int idx, TCellHAlign hal, TCellVAlign val);
	void __fastcall SetMultiImage(int Col, int Row, int dir, TCellHAlign hal, TCellVAlign val, Advobj::TImageChangeEvent Notifier);
	void __fastcall SetIcon(Graphics::TIcon* aicon, TCellHAlign hal, TCellVAlign val);
	void __fastcall SetCheckBox(bool Value, bool Data, bool Flat, TCellHAlign hal, TCellVAlign val);
	void __fastcall SetRadioButton(bool Value, bool Flat, TCellHAlign hal, TCellVAlign val);
	void __fastcall SetAngle(short AAngle);
	void __fastcall SetButton(int bw, int bh, System::UnicodeString caption, TCellHAlign hal, TCellVAlign val);
	void __fastcall SetBitButton(int bw, int bh, System::UnicodeString caption, Graphics::TBitmap* Glyph, TCellHAlign hal, TCellVAlign val);
	Types::TPoint __fastcall GetPictureSize(int cw, int rh, bool hastext);
	__property Graphics::TIcon* CellIcon = {read=FCellIcon, write=FCellIcon};
	__property Graphics::TBitmap* CellBitmap = {read=FCellBitmap, write=FCellBitmap};
	__property System::Variant CellVar = {read=FCellVar, write=FCellVar};
	
__published:
	__property TCellType CellType = {read=FCellType, write=FCellType, nodefault};
	__property TCellVAlign CellVAlign = {read=FCellVAlign, write=FCellVAlign, nodefault};
	__property TCellHAlign CellHAlign = {read=FCellHAlign, write=FCellHAlign, nodefault};
	__property int CellIndex = {read=FCellIndex, write=FCellIndex, nodefault};
	__property bool CellTransparent = {read=FCellTransparent, write=FCellTransparent, nodefault};
	__property bool CellCreated = {read=FCellCreated, write=FCellCreated, nodefault};
	__property bool CellBoolean = {read=FCellBoolean, write=FCellBoolean, nodefault};
	__property int CellAngle = {read=FCellAngle, write=FCellAngle, nodefault};
	__property double CellValue = {read=FCellValue, write=FCellValue};
	__property int CellErrFrom = {read=FCellErrFrom, write=FCellErrFrom, nodefault};
	__property int CellErrLen = {read=FCellErrLen, write=FCellErrLen, nodefault};
	__property System::UnicodeString CellText = {read=FCellText, write=FCellText};
};


class DELPHICLASS TBands;
class PASCALIMPLEMENTATION TBands : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FPrint;
	bool FActive;
	int FTotalLength;
	int FSecondaryLength;
	int FPrimaryLength;
	Graphics::TColor FSecondaryColor;
	Graphics::TColor FPrimaryColor;
	TAdvStringGrid* FOwner;
	void __fastcall SetActive(const bool Value);
	void __fastcall SetPrimaryColor(const Graphics::TColor Value);
	void __fastcall SetPrimaryLength(const int Value);
	void __fastcall SetSecondaryColor(const Graphics::TColor Value);
	void __fastcall SetSecondaryLength(const int Value);
	
public:
	__fastcall TBands(TAdvStringGrid* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property int TotalLength = {read=FTotalLength, nodefault};
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property Graphics::TColor PrimaryColor = {read=FPrimaryColor, write=SetPrimaryColor, default=-16777192};
	__property int PrimaryLength = {read=FPrimaryLength, write=SetPrimaryLength, default=1};
	__property Graphics::TColor SecondaryColor = {read=FSecondaryColor, write=SetSecondaryColor, default=-16777211};
	__property int SecondaryLength = {read=FSecondaryLength, write=SetSecondaryLength, default=1};
	__property bool Print = {read=FPrint, write=FPrint, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBands(void) { }
	
};


#pragma option push -b-
enum TNodeType { cnFlat, cn3D, cnGlyph, cnLeaf, cnXP };
#pragma option pop

class DELPHICLASS TCellNode;
class PASCALIMPLEMENTATION TCellNode : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FColor;
	TNodeType FNodeType;
	Graphics::TColor FNodeColor;
	Graphics::TBitmap* FExpandGlyph;
	bool FExpandOne;
	Graphics::TBitmap* FContractGlyph;
	TAdvStringGrid* FOwner;
	bool FShowTree;
	bool FShowTreeFull;
	int FNodeIndent;
	Graphics::TColor FTreeColor;
	void __fastcall SetExpandGlyph(Graphics::TBitmap* Value);
	void __fastcall SetContractGlyph(Graphics::TBitmap* Value);
	void __fastcall SetNodeType(TNodeType Value);
	void __fastcall SetShowTree(const bool Value);
	void __fastcall SetShowTreeFull(const bool Value);
	void __fastcall SetNodeIndent(const int Value);
	void __fastcall SetTreeColor(const Graphics::TColor Value);
	
public:
	__fastcall TCellNode(TAdvStringGrid* AOwner);
	__fastcall virtual ~TCellNode(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=12632256};
	__property bool ExpandOne = {read=FExpandOne, write=FExpandOne, default=0};
	__property TNodeType NodeType = {read=FNodeType, write=SetNodeType, default=4};
	__property Graphics::TColor NodeColor = {read=FNodeColor, write=FNodeColor, default=0};
	__property int NodeIndent = {read=FNodeIndent, write=SetNodeIndent, default=12};
	__property Graphics::TBitmap* ExpandGlyph = {read=FExpandGlyph, write=SetExpandGlyph};
	__property Graphics::TBitmap* ContractGlyph = {read=FContractGlyph, write=SetContractGlyph};
	__property bool ShowTree = {read=FShowTree, write=SetShowTree, default=1};
	__property bool ShowTreeFull = {read=FShowTreeFull, write=SetShowTreeFull, default=1};
	__property Graphics::TColor TreeColor = {read=FTreeColor, write=SetTreeColor, default=8421504};
};


#pragma option push -b-
enum TControlStyle { csClassic, csFlat, csWinXP, csBorland, csTMS, csGlyph, csTheme };
#pragma option pop

class DELPHICLASS TControlLook;
class PASCALIMPLEMENTATION TControlLook : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvStringGrid* FGrid;
	int FCheckBoxSize;
	Graphics::TBitmap* FUnCheckedGlyph;
	Graphics::TBitmap* FCheckedGlyph;
	TControlStyle FControlStyle;
	Graphics::TColor FColor;
	int FRadioSize;
	Graphics::TBitmap* FRadioOffGlyph;
	Graphics::TBitmap* FRadioOnGlyph;
	bool FFlatButton;
	int FProgressMarginY;
	int FProgressMarginX;
	bool FProgressXP;
	bool FDropDownAlwaysVisible;
	bool FSpinButtonsAlwaysVisible;
	bool FNoDisabledCheckRadioLook;
	bool FNoDisabledButtonLook;
	Graphics::TColor FCommentColor;
	Graphics::TColor FProgressBorderColor;
	Graphics::TColor FFixedGradientFrom;
	Graphics::TColor FFixedGradientTo;
	Graphics::TColor FFixedGradientMirrorFrom;
	Graphics::TColor FFixedGradientMirrorTo;
	Graphics::TColor FFixedGradientHoverFrom;
	Graphics::TColor FFixedGradientHoverTo;
	Graphics::TColor FFixedGradientHoverMirrorFrom;
	Graphics::TColor FFixedGradientHoverMirrorTo;
	Graphics::TColor FFixedGradientHoverBorder;
	Graphics::TColor FFixedGradientDownFrom;
	Graphics::TColor FFixedGradientDownTo;
	Graphics::TColor FFixedGradientDownMirrorFrom;
	Graphics::TColor FFixedGradientDownMirrorTo;
	Graphics::TColor FFixedGradientDownBorder;
	bool FFixedDropdownButton;
	bool FCheckAlwaysActive;
	bool FRadioAlwaysActive;
	Advdropdown::THeaderAppearance* FDropDownHeader;
	Advdropdown::TFooterAppearance* FDropDownFooter;
	void __fastcall SetCheckBoxSize(const int Value);
	void __fastcall SetControlStyle(const TControlStyle Value);
	void __fastcall SetCheckedGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetUnCheckedGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetRadioOffGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetRadioOnGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetRadioSize(const int Value);
	void __fastcall SetFlatButton(const bool Value);
	void __fastcall SetProgressMarginX(const int Value);
	void __fastcall SetProgressMarginY(const int Value);
	void __fastcall SetProgressXP(const bool Value);
	void __fastcall SetDropDownAlwaysVisible(const bool Value);
	void __fastcall SetSpinButtonsAlwaysVisible(const bool Value);
	void __fastcall SetNoDisabledCheckRadioLook(const bool Value);
	void __fastcall SetNoDisabledButtonLook(const bool Value);
	void __fastcall SetCommentColor(const Graphics::TColor Value);
	void __fastcall SetFixedGradientFrom(const Graphics::TColor Value);
	void __fastcall SetFixedGradientTo(const Graphics::TColor Value);
	void __fastcall SetFixedGradientMirrorFrom(const Graphics::TColor Value);
	void __fastcall SetFixedGradientMirrorTo(const Graphics::TColor Value);
	void __fastcall SetFixedGradientHoverFrom(const Graphics::TColor Value);
	void __fastcall SetFixedGradientHoverTo(const Graphics::TColor Value);
	void __fastcall SetFixedGradientHoverMirrorFrom(const Graphics::TColor Value);
	void __fastcall SetFixedGradientHoverMirrorTo(const Graphics::TColor Value);
	void __fastcall SetFixedGradientHoverBorder(const Graphics::TColor Value);
	void __fastcall SetFixedGradientDownFrom(const Graphics::TColor Value);
	void __fastcall SetFixedGradientDownTo(const Graphics::TColor Value);
	void __fastcall SetFixedGradientDownMirrorFrom(const Graphics::TColor Value);
	void __fastcall SetFixedGradientDownMirrorTo(const Graphics::TColor Value);
	void __fastcall SetFixedGradientDownBorder(const Graphics::TColor Value);
	void __fastcall SetDropDownFooter(const Advdropdown::TFooterAppearance* Value);
	void __fastcall SetDropDownHeader(const Advdropdown::THeaderAppearance* Value);
	
public:
	__fastcall TControlLook(TAdvStringGrid* AOwner);
	__fastcall virtual ~TControlLook(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=0};
	__property Graphics::TColor CommentColor = {read=FCommentColor, write=SetCommentColor, default=255};
	__property Graphics::TBitmap* CheckedGlyph = {read=FCheckedGlyph, write=SetCheckedGlyph};
	__property Graphics::TColor FixedGradientFrom = {read=FFixedGradientTo, write=SetFixedGradientTo, default=536870911};
	__property Graphics::TColor FixedGradientTo = {read=FFixedGradientFrom, write=SetFixedGradientFrom, default=536870911};
	__property Graphics::TColor FixedGradientMirrorFrom = {read=FFixedGradientMirrorTo, write=SetFixedGradientMirrorTo, default=536870911};
	__property Graphics::TColor FixedGradientMirrorTo = {read=FFixedGradientMirrorFrom, write=SetFixedGradientMirrorFrom, default=536870911};
	__property Graphics::TColor FixedGradientHoverFrom = {read=FFixedGradientHoverTo, write=SetFixedGradientHoverTo, default=16777215};
	__property Graphics::TColor FixedGradientHoverTo = {read=FFixedGradientHoverFrom, write=SetFixedGradientHoverFrom, default=8421504};
	__property Graphics::TColor FixedGradientHoverMirrorFrom = {read=FFixedGradientHoverMirrorTo, write=SetFixedGradientHoverMirrorTo, default=536870911};
	__property Graphics::TColor FixedGradientHoverMirrorTo = {read=FFixedGradientHoverMirrorFrom, write=SetFixedGradientHoverMirrorFrom, default=536870911};
	__property Graphics::TColor FixedGradientHoverBorder = {read=FFixedGradientHoverBorder, write=SetFixedGradientHoverBorder, default=12632256};
	__property Graphics::TColor FixedGradientDownFrom = {read=FFixedGradientDownTo, write=SetFixedGradientDownTo, default=12632256};
	__property Graphics::TColor FixedGradientDownTo = {read=FFixedGradientDownFrom, write=SetFixedGradientDownFrom, default=8421504};
	__property Graphics::TColor FixedGradientDownMirrorFrom = {read=FFixedGradientDownMirrorTo, write=SetFixedGradientDownMirrorTo, default=536870911};
	__property Graphics::TColor FixedGradientDownMirrorTo = {read=FFixedGradientDownMirrorFrom, write=SetFixedGradientDownMirrorFrom, default=536870911};
	__property Graphics::TColor FixedGradientDownBorder = {read=FFixedGradientDownBorder, write=SetFixedGradientDownBorder, default=8421504};
	__property bool FixedDropDownButton = {read=FFixedDropdownButton, write=FFixedDropdownButton, default=0};
	__property Graphics::TBitmap* UnCheckedGlyph = {read=FUnCheckedGlyph, write=SetUnCheckedGlyph};
	__property Graphics::TBitmap* RadioOnGlyph = {read=FRadioOnGlyph, write=SetRadioOnGlyph};
	__property Graphics::TBitmap* RadioOffGlyph = {read=FRadioOffGlyph, write=SetRadioOffGlyph};
	__property int CheckSize = {read=FCheckBoxSize, write=SetCheckBoxSize, default=15};
	__property bool CheckAlwaysActive = {read=FCheckAlwaysActive, write=FCheckAlwaysActive, default=0};
	__property int RadioSize = {read=FRadioSize, write=SetRadioSize, default=10};
	__property bool RadioAlwaysActive = {read=FRadioAlwaysActive, write=FRadioAlwaysActive, default=0};
	__property TControlStyle ControlStyle = {read=FControlStyle, write=SetControlStyle, default=6};
	__property bool DropDownAlwaysVisible = {read=FDropDownAlwaysVisible, write=SetDropDownAlwaysVisible, default=0};
	__property Advdropdown::THeaderAppearance* DropDownHeader = {read=FDropDownHeader, write=SetDropDownHeader};
	__property Advdropdown::TFooterAppearance* DropDownFooter = {read=FDropDownFooter, write=SetDropDownFooter};
	__property bool SpinButtonsAlwaysVisible = {read=FSpinButtonsAlwaysVisible, write=SetSpinButtonsAlwaysVisible, default=0};
	__property bool FlatButton = {read=FFlatButton, write=SetFlatButton, default=0};
	__property bool NoDisabledCheckRadioLook = {read=FNoDisabledCheckRadioLook, write=SetNoDisabledCheckRadioLook, default=0};
	__property bool NoDisabledButtonLook = {read=FNoDisabledButtonLook, write=SetNoDisabledButtonLook, default=0};
	__property Graphics::TColor ProgressBorderColor = {read=FProgressBorderColor, write=FProgressBorderColor, default=8421504};
	__property int ProgressMarginX = {read=FProgressMarginX, write=SetProgressMarginX, default=2};
	__property int ProgressMarginY = {read=FProgressMarginY, write=SetProgressMarginY, default=2};
	__property bool ProgressXP = {read=FProgressXP, write=SetProgressXP, default=0};
};


class DELPHICLASS TShowModified;
class PASCALIMPLEMENTATION TShowModified : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FEnabled;
	Graphics::TColor FColor;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetColor(const Graphics::TColor Value);
	
public:
	__fastcall TShowModified(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=0};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=65535};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TShowModified(void) { }
	
};


class DELPHICLASS TSizeWhileTyping;
class PASCALIMPLEMENTATION TSizeWhileTyping : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FHeight;
	bool FWidth;
	
public:
	__fastcall TSizeWhileTyping(void);
	__fastcall virtual ~TSizeWhileTyping(void);
	
__published:
	__property bool Height = {read=FHeight, write=FHeight, default=0};
	__property bool Width = {read=FWidth, write=FWidth, default=0};
};


#pragma option push -b-
enum TColumnSizeLocation { clRegistry, clIniFile };
#pragma option pop

#pragma option push -b-
enum TAutoSizeRows { arAll, arNormal, arFixed };
#pragma option pop

class DELPHICLASS TColumnSize;
class PASCALIMPLEMENTATION TColumnSize : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TComponent* Owner;
	bool FSave;
	System::UnicodeString FKey;
	System::UnicodeString FSection;
	bool FStretch;
	int FStretchColumn;
	bool FSynchWithGrid;
	bool FSynchNormalCellsOnly;
	TColumnSizeLocation FLocation;
	TAutoSizeRows FRows;
	void __fastcall SetStretch(bool Value);
	
public:
	__fastcall TColumnSize(Classes::TComponent* AOwner);
	__fastcall virtual ~TColumnSize(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TAutoSizeRows Rows = {read=FRows, write=FRows, default=0};
	__property bool Save = {read=FSave, write=FSave, default=0};
	__property System::UnicodeString Key = {read=FKey, write=FKey};
	__property System::UnicodeString Section = {read=FSection, write=FSection};
	__property bool Stretch = {read=FStretch, write=SetStretch, default=0};
	__property int StretchColumn = {read=FStretchColumn, write=FStretchColumn, default=-1};
	__property bool SynchWithGrid = {read=FSynchWithGrid, write=FSynchWithGrid, default=0};
	__property bool SynchNormalCellsOnly = {read=FSynchNormalCellsOnly, write=FSynchNormalCellsOnly, default=0};
	__property TColumnSizeLocation Location = {read=FLocation, write=FLocation, default=0};
};


class DELPHICLASS TGrouping;
class PASCALIMPLEMENTATION TGrouping : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FMergeHeader;
	bool FMergeSummary;
	Graphics::TColor FHeaderColor;
	Graphics::TColor FSummaryColor;
	Graphics::TColor FHeaderColorTo;
	Graphics::TColor FHeaderTextColor;
	bool FSummary;
	Graphics::TColor FSummaryTextColor;
	Graphics::TColor FSummaryColorTo;
	bool FHeaderUnderline;
	bool FSummaryLine;
	int FSummaryLineWidth;
	int FHeaderLineWidth;
	Graphics::TColor FSummaryLineColor;
	Graphics::TColor FHeaderLineColor;
	bool FShowGroupCount;
	System::UnicodeString FGroupCountFormat;
	bool FAutoSelectGroup;
	
public:
	__fastcall TGrouping(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool AutoSelectGroup = {read=FAutoSelectGroup, write=FAutoSelectGroup, default=0};
	__property System::UnicodeString GroupCountFormat = {read=FGroupCountFormat, write=FGroupCountFormat};
	__property Graphics::TColor HeaderColor = {read=FHeaderColor, write=FHeaderColor, default=536870911};
	__property Graphics::TColor HeaderColorTo = {read=FHeaderColorTo, write=FHeaderColorTo, default=536870911};
	__property Graphics::TColor HeaderTextColor = {read=FHeaderTextColor, write=FHeaderTextColor, default=536870911};
	__property bool HeaderUnderline = {read=FHeaderUnderline, write=FHeaderUnderline, default=0};
	__property Graphics::TColor HeaderLineColor = {read=FHeaderLineColor, write=FHeaderLineColor, default=16711680};
	__property int HeaderLineWidth = {read=FHeaderLineWidth, write=FHeaderLineWidth, default=2};
	__property bool MergeHeader = {read=FMergeHeader, write=FMergeHeader, default=0};
	__property bool MergeSummary = {read=FMergeSummary, write=FMergeSummary, default=0};
	__property bool ShowGroupCount = {read=FShowGroupCount, write=FShowGroupCount, default=0};
	__property bool Summary = {read=FSummary, write=FSummary, default=0};
	__property Graphics::TColor SummaryColor = {read=FSummaryColor, write=FSummaryColor, default=536870911};
	__property Graphics::TColor SummaryColorTo = {read=FSummaryColorTo, write=FSummaryColorTo, default=536870911};
	__property Graphics::TColor SummaryTextColor = {read=FSummaryTextColor, write=FSummaryTextColor, default=536870911};
	__property bool SummaryLine = {read=FSummaryLine, write=FSummaryLine, default=0};
	__property Graphics::TColor SummaryLineColor = {read=FSummaryLineColor, write=FSummaryLineColor, default=16711680};
	__property int SummaryLineWidth = {read=FSummaryLineWidth, write=FSummaryLineWidth, default=2};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGrouping(void) { }
	
};


class DELPHICLASS THTMLSettings;
class PASCALIMPLEMENTATION THTMLSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FAutoPreview;
	bool FConvertSpecialChars;
	bool FNonBreakingText;
	bool FSaveColor;
	bool FSaveFonts;
	System::UnicodeString FFooterFile;
	System::UnicodeString FHeaderFile;
	int FBorderSize;
	int FCellSpacing;
	int FCellPadding;
	System::UnicodeString FTableStyle;
	System::UnicodeString FPrefixTag;
	System::UnicodeString FSuffixTag;
	System::UnicodeString FSummary;
	int FWidth;
	Advobj::TIntList* FColWidths;
	bool FXHTML;
	bool FExportImages;
	
public:
	__fastcall THTMLSettings(void);
	__fastcall virtual ~THTMLSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Advobj::TIntList* ColWidths = {read=FColWidths};
	
__published:
	__property bool AutoPreview = {read=FAutoPreview, write=FAutoPreview, default=0};
	__property int BorderSize = {read=FBorderSize, write=FBorderSize, default=1};
	__property int CellSpacing = {read=FCellSpacing, write=FCellSpacing, default=0};
	__property int CellPadding = {read=FCellPadding, write=FCellPadding, default=0};
	__property bool ConvertSpecialChars = {read=FConvertSpecialChars, write=FConvertSpecialChars, default=0};
	__property bool ExportImages = {read=FExportImages, write=FExportImages, default=1};
	__property System::UnicodeString FooterFile = {read=FFooterFile, write=FFooterFile};
	__property System::UnicodeString HeaderFile = {read=FHeaderFile, write=FHeaderFile};
	__property bool NonBreakingText = {read=FNonBreakingText, write=FNonBreakingText, default=0};
	__property System::UnicodeString PrefixTag = {read=FPrefixTag, write=FPrefixTag};
	__property bool SaveColor = {read=FSaveColor, write=FSaveColor, default=1};
	__property bool SaveFonts = {read=FSaveFonts, write=FSaveFonts, default=1};
	__property System::UnicodeString SuffixTag = {read=FSuffixTag, write=FSuffixTag};
	__property System::UnicodeString Summary = {read=FSummary, write=FSummary};
	__property System::UnicodeString TableStyle = {read=FTableStyle, write=FTableStyle};
	__property int Width = {read=FWidth, write=FWidth, default=100};
	__property bool XHTML = {read=FXHTML, write=FXHTML, default=0};
};


class DELPHICLASS TBalloonSettings;
class PASCALIMPLEMENTATION TBalloonSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FInit;
	Graphics::TColor FBackgroundColor;
	Graphics::TColor FTextColor;
	int FReshowDelay;
	int FInitialDelay;
	int FAutoHideDelay;
	System::Byte FTransparency;
	bool FEnable;
	Classes::TNotifyEvent FOnEnableChange;
	void __fastcall SetEnable(const bool Value);
	
public:
	__fastcall TBalloonSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int AutoHideDelay = {read=FAutoHideDelay, write=FAutoHideDelay, default=-1};
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=FBackgroundColor, default=536870911};
	__property bool Enable = {read=FEnable, write=SetEnable, default=0};
	__property int InitialDelay = {read=FInitialDelay, write=FInitialDelay, default=-1};
	__property int ReshowDelay = {read=FReshowDelay, write=FReshowDelay, default=-1};
	__property Graphics::TColor TextColor = {read=FTextColor, write=FTextColor, default=536870911};
	__property System::Byte Transparency = {read=FTransparency, write=FTransparency, default=0};
	__property Classes::TNotifyEvent OnEnableChange = {read=FOnEnableChange, write=FOnEnableChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBalloonSettings(void) { }
	
};


class DELPHICLASS TPrintSettings;
class PASCALIMPLEMENTATION TPrintSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvStringGrid* FGrid;
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
	Classes::TStringList* FTitleLines;
	bool FCentered;
	bool FRepeatFixedRows;
	bool FRepeatFixedCols;
	int FFooterSize;
	int FHeaderSize;
	int FLeftSize;
	int FRightSize;
	int FColumnSpacing;
	int FRowSpacing;
	int FTitleSpacing;
	Printers::TPrinterOrientation FOrientation;
	System::UnicodeString FPagePrefix;
	System::UnicodeString FPageSuffix;
	int FFixedHeight;
	bool FUseFixedHeight;
	int FFixedWidth;
	bool FUseFixedWidth;
	TFitToPage FFitToPage;
	bool FNoAutoSize;
	bool FPrintGraphics;
	System::UnicodeString FJobName;
	bool FNoAutoSizeRow;
	int FPageNumberOffset;
	int FMaxPagesOffset;
	Graphics::TFont* FFixedFont;
	bool FUseDisplayFont;
	bool FUseDefaultOrientation;
	bool FFixedCellsAlways;
	Graphics::TColor FBorderColor;
	void __fastcall SetPrintFont(Graphics::TFont* Value);
	void __fastcall SetPrintHeaderFont(Graphics::TFont* Value);
	void __fastcall SetPrintFooterFont(Graphics::TFont* Value);
	void __fastcall SetTitleLines(Classes::TStringList* Value);
	void __fastcall SetFixedFont(const Graphics::TFont* Value);
	
public:
	__fastcall TPrintSettings(TAdvStringGrid* AOwner);
	__fastcall virtual ~TPrintSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property bool FixedCellsAlways = {read=FFixedCellsAlways, write=FFixedCellsAlways, nodefault};
	
__published:
	__property int FooterSize = {read=FFooterSize, write=FFooterSize, default=0};
	__property int HeaderSize = {read=FHeaderSize, write=FHeaderSize, default=0};
	__property TPrintPosition Time = {read=FTime, write=FTime, default=0};
	__property TPrintPosition Date = {read=FDate, write=FDate, default=0};
	__property System::UnicodeString DateFormat = {read=FDateFormat, write=FDateFormat};
	__property TPrintPosition PageNr = {read=FPageNr, write=FPageNr, default=0};
	__property TPrintPosition Title = {read=FTitle, write=FTitle, default=0};
	__property System::UnicodeString TitleText = {read=FTitleText, write=FTitleText};
	__property Classes::TStringList* TitleLines = {read=FTitleLines, write=SetTitleLines};
	__property Graphics::TFont* Font = {read=FFont, write=SetPrintFont};
	__property Graphics::TFont* FixedFont = {read=FFixedFont, write=SetFixedFont};
	__property Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetPrintHeaderFont};
	__property Graphics::TFont* FooterFont = {read=FFooterFont, write=SetPrintFooterFont};
	__property TPrintBorders Borders = {read=FBorders, write=FBorders, default=1};
	__property Graphics::TPenStyle BorderStyle = {read=FBorderStyle, write=FBorderStyle, default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, default=0};
	__property bool Centered = {read=FCentered, write=FCentered, default=1};
	__property bool RepeatFixedRows = {read=FRepeatFixedRows, write=FRepeatFixedRows, default=0};
	__property bool RepeatFixedCols = {read=FRepeatFixedCols, write=FRepeatFixedCols, default=0};
	__property int LeftSize = {read=FLeftSize, write=FLeftSize, default=0};
	__property int RightSize = {read=FRightSize, write=FRightSize, default=0};
	__property int ColumnSpacing = {read=FColumnSpacing, write=FColumnSpacing, default=0};
	__property int RowSpacing = {read=FRowSpacing, write=FRowSpacing, default=0};
	__property int TitleSpacing = {read=FTitleSpacing, write=FTitleSpacing, default=0};
	__property Printers::TPrinterOrientation Orientation = {read=FOrientation, write=FOrientation, default=0};
	__property System::UnicodeString PagePrefix = {read=FPagePrefix, write=FPagePrefix, stored=true};
	__property System::UnicodeString PageSuffix = {read=FPageSuffix, write=FPageSuffix};
	__property int PageNumberOffset = {read=FPageNumberOffset, write=FPageNumberOffset, default=0};
	__property int MaxPagesOffset = {read=FMaxPagesOffset, write=FMaxPagesOffset, default=0};
	__property int FixedWidth = {read=FFixedWidth, write=FFixedWidth, default=0};
	__property int FixedHeight = {read=FFixedHeight, write=FFixedHeight, default=0};
	__property bool UseFixedHeight = {read=FUseFixedHeight, write=FUseFixedHeight, default=0};
	__property bool UseFixedWidth = {read=FUseFixedWidth, write=FUseFixedWidth, default=0};
	__property TFitToPage FitToPage = {read=FFitToPage, write=FFitToPage, default=0};
	__property System::UnicodeString JobName = {read=FJobName, write=FJobName};
	__property System::UnicodeString PageNumSep = {read=FPageNumSep, write=FPageNumSep};
	__property bool NoAutoSize = {read=FNoAutoSize, write=FNoAutoSize, default=0};
	__property bool NoAutoSizeRow = {read=FNoAutoSizeRow, write=FNoAutoSizeRow, default=0};
	__property bool PrintGraphics = {read=FPrintGraphics, write=FPrintGraphics, default=0};
	__property bool UseDisplayFont = {read=FUseDisplayFont, write=FUseDisplayFont, default=1};
	__property bool UseDefaultOrientation = {read=FUseDefaultOrientation, write=FUseDefaultOrientation, default=0};
};


#pragma option push -b-
enum TBackGroundDisplay { bdTile, bdFixed, bdGradientHorz, bdGradientVert };
#pragma option pop

#pragma option push -b-
enum TBackGroundCells { bcNormal, bcFixed, bcAll };
#pragma option pop

#pragma option push -b-
enum TIndexSortKey { ikShift, ikCtrl };
#pragma option pop

class DELPHICLASS TSortSettings;
class PASCALIMPLEMENTATION TSortSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvStringGrid* FGrid;
	bool FSortShow;
	bool FSortIndexShow;
	bool FSortFull;
	bool FSortSingleColumn;
	bool FSortIgnoreBlanks;
	TSortBlankPosition FSortBlankPos;
	bool FSortAutoFormat;
	TSortDirection FSortDirection;
	Graphics::TBitmap* FSortUpGlyph;
	Graphics::TBitmap* FSortDownGlyph;
	Graphics::TBitmap* FIndexUpGlyph;
	Graphics::TBitmap* FIndexDownGlyph;
	bool FSortNormalCellsOnly;
	bool FSortFixedCols;
	int FSortColumn;
	int FSortRow;
	bool FAutoColumnMerge;
	Graphics::TColor FSortIndexColor;
	TSortDirection FInitSortDirection;
	bool FUndoSort;
	bool FAutoSortForGrouping;
	bool FVirtualCells;
	bool FIgnoreCase;
	Graphics::TColor FHeaderColor;
	Graphics::TColor FHeaderColorTo;
	Graphics::TColor FHeaderMirrorColor;
	Graphics::TColor FHeaderMirrorColorTo;
	TIndexSortKey FIndexSortKey;
	Graphics::TBitmap* __fastcall GetDownGlyph(void);
	Graphics::TBitmap* __fastcall GetUpGlyph(void);
	void __fastcall SetDownGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetUpGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetSortRow(const int Value);
	void __fastcall SetIndexDownGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetIndexUpGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetShow(const bool Value);
	void __fastcall SetHeaderColor(const Graphics::TColor Value);
	void __fastcall SetHeaderColorTo(const Graphics::TColor Value);
	void __fastcall SetHeaderMirrorColor(const Graphics::TColor Value);
	void __fastcall SetHeaderMirrorColorTo(const Graphics::TColor Value);
	
public:
	__fastcall TSortSettings(TAdvStringGrid* AOwner);
	__fastcall virtual ~TSortSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Remove(void);
	System::UnicodeString __fastcall SaveToString(void);
	void __fastcall LoadFromString(const System::UnicodeString Value);
	
__published:
	__property bool AutoSortForGrouping = {read=FAutoSortForGrouping, write=FAutoSortForGrouping, default=1};
	__property bool AutoColumnMerge = {read=FAutoColumnMerge, write=FAutoColumnMerge, default=0};
	__property int Column = {read=FSortColumn, write=FSortColumn, default=-1};
	__property bool Show = {read=FSortShow, write=SetShow, default=0};
	__property bool IndexShow = {read=FSortIndexShow, write=FSortIndexShow, default=0};
	__property Graphics::TColor IndexColor = {read=FSortIndexColor, write=FSortIndexColor, default=65535};
	__property TIndexSortKey IndexSortKey = {read=FIndexSortKey, write=FIndexSortKey, default=0};
	__property bool Full = {read=FSortFull, write=FSortFull, default=1};
	__property bool SingleColumn = {read=FSortSingleColumn, write=FSortSingleColumn, default=0};
	__property bool IgnoreBlanks = {read=FSortIgnoreBlanks, write=FSortIgnoreBlanks, default=0};
	__property TSortBlankPosition BlankPos = {read=FSortBlankPos, write=FSortBlankPos, default=0};
	__property bool AutoFormat = {read=FSortAutoFormat, write=FSortAutoFormat, default=1};
	__property TSortDirection Direction = {read=FSortDirection, write=FSortDirection, default=0};
	__property Graphics::TBitmap* UpGlyph = {read=GetUpGlyph, write=SetUpGlyph};
	__property Graphics::TBitmap* DownGlyph = {read=GetDownGlyph, write=SetDownGlyph};
	__property bool IgnoreCase = {read=FIgnoreCase, write=FIgnoreCase, default=0};
	__property Graphics::TBitmap* IndexUpGlyph = {read=FIndexUpGlyph, write=SetIndexUpGlyph};
	__property Graphics::TBitmap* IndexDownGlyph = {read=FIndexDownGlyph, write=SetIndexDownGlyph};
	__property TSortDirection InitSortDirection = {read=FInitSortDirection, write=FInitSortDirection, default=0};
	__property bool FixedCols = {read=FSortFixedCols, write=FSortFixedCols, default=0};
	__property bool NormalCellsOnly = {read=FSortNormalCellsOnly, write=FSortNormalCellsOnly, default=0};
	__property int Row = {read=FSortRow, write=SetSortRow, default=0};
	__property bool UndoSort = {read=FUndoSort, write=FUndoSort, default=0};
	__property bool SortOnVirtualCells = {read=FVirtualCells, write=FVirtualCells, default=1};
	__property Graphics::TColor HeaderColor = {read=FHeaderColor, write=SetHeaderColor, default=536870911};
	__property Graphics::TColor HeaderColorTo = {read=FHeaderColorTo, write=SetHeaderColorTo, default=536870911};
	__property Graphics::TColor HeaderMirrorColor = {read=FHeaderMirrorColor, write=SetHeaderMirrorColor, default=536870911};
	__property Graphics::TColor HeaderMirrorColorTo = {read=FHeaderMirrorColorTo, write=SetHeaderMirrorColorTo, default=536870911};
};


#pragma option push -b-
enum TProgressStyle { psXP, psClassic };
#pragma option pop

class DELPHICLASS TGridProgressAppearance;
class PASCALIMPLEMENTATION TGridProgressAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FUnCompleteFontColor;
	Graphics::TColor FCompleteColor;
	Graphics::TColor FUnCompleteColor;
	Graphics::TColor FCompleteFontColor;
	Classes::TNotifyEvent FOnChange;
	bool FStacked;
	bool FShowPercentage;
	bool FShowBorder;
	bool FCompletionSmooth;
	bool FShowGradient;
	int FLevel2Perc;
	int FLevel1Perc;
	int FSteps;
	Graphics::TColor FLevel3Color;
	Graphics::TColor FLevel1Color;
	Graphics::TColor FLevel0Color;
	Graphics::TColor FLevel3ColorTo;
	Graphics::TColor FLevel2ColorTo;
	Graphics::TColor FLevel0ColorTo;
	Graphics::TColor FLevel1ColorTo;
	Graphics::TColor FBorderColor;
	Graphics::TColor FLevel2Color;
	TProgressStyle FStyle;
	void __fastcall SetCompleteColor(const Graphics::TColor Value);
	void __fastcall SetCompleteFontColor(const Graphics::TColor Value);
	void __fastcall SetUnCompleteColor(const Graphics::TColor Value);
	void __fastcall SetUnCompleteFontColor(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetCompletionSmooth(const bool Value);
	void __fastcall SetLevel0Color(const Graphics::TColor Value);
	void __fastcall SetLevel0ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel1Color(const Graphics::TColor Value);
	void __fastcall SetLevel1ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel1Perc(const int Value);
	void __fastcall SetLevel2Color(const Graphics::TColor Value);
	void __fastcall SetLevel2ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel2Perc(const int Value);
	void __fastcall SetLevel3Color(const Graphics::TColor Value);
	void __fastcall SetLevel3ColorTo(const Graphics::TColor Value);
	void __fastcall SetShowBorder(const bool Value);
	void __fastcall SetShowGradient(const bool Value);
	void __fastcall SetShowPercentage(const bool Value);
	void __fastcall SetStacked(const bool Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall SetStyle(const TProgressStyle Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TGridProgressAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TProgressStyle Style = {read=FStyle, write=SetStyle, default=0};
	
__published:
	__property Graphics::TColor CompleteColor = {read=FCompleteColor, write=SetCompleteColor, default=255};
	__property Graphics::TColor CompleteFontColor = {read=FCompleteFontColor, write=SetCompleteFontColor, default=16711680};
	__property Graphics::TColor UnCompleteColor = {read=FUnCompleteColor, write=SetUnCompleteColor, default=536870911};
	__property Graphics::TColor UnCompleteFontColor = {read=FUnCompleteFontColor, write=SetUnCompleteFontColor, default=-16777208};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Graphics::TColor Level0Color = {read=FLevel0Color, write=SetLevel0Color, default=65280};
	__property Graphics::TColor Level0ColorTo = {read=FLevel0ColorTo, write=SetLevel0ColorTo, default=14811105};
	__property Graphics::TColor Level1Color = {read=FLevel1Color, write=SetLevel1Color, default=65535};
	__property Graphics::TColor Level1ColorTo = {read=FLevel1ColorTo, write=SetLevel1ColorTo, default=13303807};
	__property Graphics::TColor Level2Color = {read=FLevel2Color, write=SetLevel2Color, default=5483007};
	__property Graphics::TColor Level2ColorTo = {read=FLevel2ColorTo, write=SetLevel2ColorTo, default=11064319};
	__property Graphics::TColor Level3Color = {read=FLevel3Color, write=SetLevel3Color, default=255};
	__property Graphics::TColor Level3ColorTo = {read=FLevel3ColorTo, write=SetLevel3ColorTo, default=13290239};
	__property int Level1Perc = {read=FLevel1Perc, write=SetLevel1Perc, default=70};
	__property int Level2Perc = {read=FLevel2Perc, write=SetLevel2Perc, default=90};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property bool ShowBorder = {read=FShowBorder, write=SetShowBorder, default=0};
	__property bool Stacked = {read=FStacked, write=SetStacked, default=0};
	__property bool ShowPercentage = {read=FShowPercentage, write=SetShowPercentage, default=1};
	__property bool CompletionSmooth = {read=FCompletionSmooth, write=SetCompletionSmooth, default=1};
	__property bool ShowGradient = {read=FShowGradient, write=SetShowGradient, default=1};
	__property int Steps = {read=FSteps, write=SetSteps, default=11};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGridProgressAppearance(void) { }
	
};


class DELPHICLASS TBackGround;
class PASCALIMPLEMENTATION TBackGround : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvStringGrid* FGrid;
	int FTop;
	int FLeft;
	TBackGroundDisplay FDisplay;
	TBackGroundCells FBackgroundCells;
	Graphics::TColor FColorTo;
	Graphics::TColor FColor;
	void __fastcall SetBitmap(Graphics::TBitmap* Value);
	void __fastcall SetTop(int Value);
	void __fastcall SetLeft(int Value);
	void __fastcall SetDisplay(TBackGroundDisplay Value);
	void __fastcall SetBackGroundCells(const TBackGroundCells Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	Graphics::TBitmap* FBitmap;
	
public:
	__fastcall TBackGround(TAdvStringGrid* AGrid);
	__fastcall virtual ~TBackGround(void);
	
__published:
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property TBackGroundDisplay Display = {read=FDisplay, write=SetDisplay, default=0};
	__property Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property TBackGroundCells Cells = {read=FBackgroundCells, write=SetBackGroundCells, default=0};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777211};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=-16777201};
};


#pragma option push -b-
enum TEditStyle { esInplace, esPopup };
#pragma option pop

class PASCALIMPLEMENTATION TEditLink : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TAdvStringGrid* FOwner;
	bool FWantKeyLeftRight;
	bool FWantKeyUpDown;
	bool FWantKeyHomeEnd;
	bool FWantKeyPriorNext;
	bool FWantKeyReturn;
	bool FWantKeyEscape;
	TEditStyle FEditStyle;
	Forms::TForm* FPopupForm;
	int FPopupWidth;
	int FPopupHeight;
	bool FForcedExit;
	Types::TPoint FEditCell;
	int FTag;
	bool FAutoPopupWidth;
	int FPopupLeft;
	int FPopupTop;
	
protected:
	__property bool ForcedExit = {read=FForcedExit, write=FForcedExit, nodefault};
	
public:
	__fastcall virtual TEditLink(Classes::TComponent* AOwner);
	__fastcall virtual ~TEditLink(void);
	virtual void __fastcall EditKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall EditExit(System::TObject* Sender);
	void __fastcall FormExit(System::TObject* Sender);
	Controls::TWinControl* __fastcall GetParent(void);
	virtual Controls::TWinControl* __fastcall GetEditControl(void);
	System::UnicodeString __fastcall GetCellValue(void);
	void __fastcall SetCellValue(System::UnicodeString s);
	virtual void __fastcall CreateEditor(Controls::TWinControl* AParent);
	virtual void __fastcall DestroyEditor(void);
	void __fastcall HideEditor(void);
	void __fastcall RestoreWinProc(void);
	virtual void __fastcall SetFocus(bool Value);
	virtual void __fastcall SetRect(const Types::TRect &r);
	virtual void __fastcall SetVisible(bool Value);
	virtual void __fastcall SetProperties(void);
	virtual void __fastcall SetCellProps(Graphics::TColor AColor, Graphics::TFont* AFont);
	virtual System::UnicodeString __fastcall GetEditorValue(void);
	virtual void __fastcall SetEditorValue(System::UnicodeString s);
	__property TAdvStringGrid* Grid = {read=FOwner};
	__property Types::TPoint EditCell = {read=FEditCell};
	
__published:
	__property bool AutoPopupWidth = {read=FAutoPopupWidth, write=FAutoPopupWidth, nodefault};
	__property TEditStyle EditStyle = {read=FEditStyle, write=FEditStyle, nodefault};
	__property int PopupLeft = {read=FPopupLeft, write=FPopupLeft, default=-1};
	__property int PopupTop = {read=FPopupTop, write=FPopupTop, default=-1};
	__property int PopupWidth = {read=FPopupWidth, write=FPopupWidth, nodefault};
	__property int PopupHeight = {read=FPopupHeight, write=FPopupHeight, nodefault};
	__property bool WantKeyLeftRight = {read=FWantKeyLeftRight, write=FWantKeyLeftRight, nodefault};
	__property bool WantKeyUpDown = {read=FWantKeyUpDown, write=FWantKeyUpDown, nodefault};
	__property bool WantKeyHomeEnd = {read=FWantKeyHomeEnd, write=FWantKeyHomeEnd, nodefault};
	__property bool WantKeyPriorNext = {read=FWantKeyPriorNext, write=FWantKeyPriorNext, nodefault};
	__property bool WantKeyReturn = {read=FWantKeyReturn, write=FWantKeyReturn, nodefault};
	__property bool WantKeyEscape = {read=FWantKeyEscape, write=FWantKeyEscape, nodefault};
	__property int Tag = {read=FTag, write=FTag, nodefault};
};


class DELPHICLASS TControlCombo;
class PASCALIMPLEMENTATION TControlCombo : public Asgcombo::TASGComboBox
{
	typedef Asgcombo::TASGComboBox inherited;
	
private:
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
public:
	/* TASGCustomCombo.Create */ inline __fastcall virtual TControlCombo(Classes::TComponent* AOwner) : Asgcombo::TASGComboBox(AOwner) { }
	
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TControlCombo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TControlCombo(HWND ParentWindow) : Asgcombo::TASGComboBox(ParentWindow) { }
	
};


class DELPHICLASS TControlEdit;
class PASCALIMPLEMENTATION TControlEdit : public Mask::TMaskEdit
{
	typedef Mask::TMaskEdit inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
public:
	/* TCustomMaskEdit.Create */ inline __fastcall virtual TControlEdit(Classes::TComponent* AOwner) : Mask::TMaskEdit(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TControlEdit(HWND ParentWindow) : Mask::TMaskEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TControlEdit(void) { }
	
};


class DELPHICLASS TGridCombo;
class PASCALIMPLEMENTATION TGridCombo : public Asgcombo::TASGComboBox
{
	typedef Asgcombo::TASGComboBox inherited;
	
private:
	bool Forced;
	bool WorkMode;
	int ItemIdx;
	Classes::TNotifyEvent FOnReturnKey;
	bool ItemChange;
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC void __fastcall Change(void);
	
public:
	TAdvStringGrid* FGrid;
	void __fastcall DoChange(void);
	__fastcall virtual TGridCombo(Classes::TComponent* AOwner);
	void __fastcall SizeDropDownWidth(void);
	
__published:
	__property Classes::TNotifyEvent OnReturnKey = {read=FOnReturnKey, write=FOnReturnKey};
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TGridCombo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridCombo(HWND ParentWindow) : Asgcombo::TASGComboBox(ParentWindow) { }
	
};


class DELPHICLASS TGridSpin;
class PASCALIMPLEMENTATION TGridSpin : public Asgspin::TAsgSpinEdit
{
	typedef Asgspin::TAsgSpinEdit inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	
protected:
	void __fastcall DoClick(bool UpDown);
	virtual void __fastcall UpClick(System::TObject* Sender);
	virtual void __fastcall DownClick(System::TObject* Sender);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Change(void);
	
public:
	TAdvStringGrid* FGrid;
	__fastcall virtual TGridSpin(Classes::TComponent* AOwner);
	void __fastcall ReCreate(void);
public:
	/* TAsgSpinEdit.Destroy */ inline __fastcall virtual ~TGridSpin(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridSpin(HWND ParentWindow) : Asgspin::TAsgSpinEdit(ParentWindow) { }
	
};


class DELPHICLASS TGridTransEdit;
class PASCALIMPLEMENTATION TGridTransEdit : public Stdctrls::TCustomEdit
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	int FRow;
	int FCol;
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall DoExit(void);
	
public:
	TAdvStringGrid* FGrid;
	__fastcall virtual TGridTransEdit(Classes::TComponent* AOwner);
	bool __fastcall StopEdit(void);
	__property BorderStyle = {default=1};
	
__published:
	__property int Col = {read=FCol, write=FCol, nodefault};
	__property int Row = {read=FRow, write=FRow, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridTransEdit(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TGridTransEdit(void) { }
	
};


class DELPHICLASS TGridTrackbarDropDown;
class PASCALIMPLEMENTATION TGridTrackbarDropDown : public Advtrackbardropdown::TAdvTrackBarDropDown
{
	typedef Advtrackbardropdown::TAdvTrackBarDropDown inherited;
	
private:
	bool Forced;
	bool WorkMode;
	HIDESBASE MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC void __fastcall Change(void);
	
public:
	TAdvStringGrid* FGrid;
	void __fastcall DoChange(void);
	__fastcall virtual TGridTrackbarDropDown(Classes::TComponent* AOwner);
public:
	/* TAdvTrackBarDropDown.Destroy */ inline __fastcall virtual ~TGridTrackbarDropDown(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridTrackbarDropDown(HWND ParentWindow) : Advtrackbardropdown::TAdvTrackBarDropDown(ParentWindow) { }
	
};


class DELPHICLASS TGridMemoDropDown;
class PASCALIMPLEMENTATION TGridMemoDropDown : public Advmemodropdown::TAdvMemoDropDown
{
	typedef Advmemodropdown::TAdvMemoDropDown inherited;
	
private:
	bool Forced;
	bool WorkMode;
	HIDESBASE MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Change(void);
	
public:
	TAdvStringGrid* FGrid;
	__fastcall virtual TGridMemoDropDown(Classes::TComponent* AOwner);
public:
	/* TAdvMemoDropDown.Destroy */ inline __fastcall virtual ~TGridMemoDropDown(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridMemoDropDown(HWND ParentWindow) : Advmemodropdown::TAdvMemoDropDown(ParentWindow) { }
	
};


class DELPHICLASS TGridCalculatorDropDown;
class PASCALIMPLEMENTATION TGridCalculatorDropDown : public Advcalculatordropdown::TAdvCalculatorDropdown
{
	typedef Advcalculatordropdown::TAdvCalculatorDropdown inherited;
	
private:
	bool Forced;
	bool WorkMode;
	HIDESBASE MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Change(void);
	
public:
	TAdvStringGrid* FGrid;
	__fastcall virtual TGridCalculatorDropDown(Classes::TComponent* AOwner);
public:
	/* TAdvCalculatorDropdown.Destroy */ inline __fastcall virtual ~TGridCalculatorDropDown(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridCalculatorDropDown(HWND ParentWindow) : Advcalculatordropdown::TAdvCalculatorDropdown(ParentWindow) { }
	
};


class DELPHICLASS TGridTimepickerDropDown;
class PASCALIMPLEMENTATION TGridTimepickerDropDown : public Advtimepickerdropdown::TAdvTimePickerDropDown
{
	typedef Advtimepickerdropdown::TAdvTimePickerDropDown inherited;
	
private:
	bool Forced;
	bool WorkMode;
	HIDESBASE MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Change(void);
	
public:
	TAdvStringGrid* FGrid;
	__fastcall virtual TGridTimepickerDropDown(Classes::TComponent* AOwner);
public:
	/* TAdvTimePickerDropDown.Destroy */ inline __fastcall virtual ~TGridTimepickerDropDown(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridTimepickerDropDown(HWND ParentWindow) : Advtimepickerdropdown::TAdvTimePickerDropDown(ParentWindow) { }
	
};


class DELPHICLASS TGridDetailPickerDropDown;
class PASCALIMPLEMENTATION TGridDetailPickerDropDown : public Advdetaildropdown::TAdvDetailDropDown
{
	typedef Advdetaildropdown::TAdvDetailDropDown inherited;
	
private:
	bool Forced;
	bool WorkMode;
	HIDESBASE MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Change(void);
	
public:
	TAdvStringGrid* FGrid;
	__fastcall virtual TGridDetailPickerDropDown(Classes::TComponent* AOwner);
public:
	/* TAdvDetailDropDown.Destroy */ inline __fastcall virtual ~TGridDetailPickerDropDown(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridDetailPickerDropDown(HWND ParentWindow) : Advdetaildropdown::TAdvDetailDropDown(ParentWindow) { }
	
};


class DELPHICLASS TGridGridDropDown;
class PASCALIMPLEMENTATION TGridGridDropDown : public Advmulticolumndropdown::TAdvMultiColumnDropDown
{
	typedef Advmulticolumndropdown::TAdvMultiColumnDropDown inherited;
	
private:
	bool Forced;
	bool WorkMode;
	HIDESBASE MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Change(void);
	
public:
	TAdvStringGrid* FGrid;
	__fastcall virtual TGridGridDropDown(Classes::TComponent* AOwner);
public:
	/* TAdvMultiColumnDropDown.Destroy */ inline __fastcall virtual ~TGridGridDropDown(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridGridDropDown(HWND ParentWindow) : Advmulticolumndropdown::TAdvMultiColumnDropDown(ParentWindow) { }
	
};


class DELPHICLASS TGridAdvGridDropDown;
class PASCALIMPLEMENTATION TGridAdvGridDropDown : public Advcustomgriddropdown::TCustomAdvGridDropDown
{
	typedef Advcustomgriddropdown::TCustomAdvGridDropDown inherited;
	
private:
	bool Forced;
	bool WorkMode;
	HIDESBASE MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	TAdvStringGrid* __fastcall GetAdvGrid(void);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Change(void);
	
public:
	TAdvStringGrid* FGrid;
	__fastcall virtual TGridAdvGridDropDown(Classes::TComponent* AOwner);
	__property TAdvStringGrid* Grid = {read=GetAdvGrid};
public:
	/* TCustomAdvGridDropDown.Destroy */ inline __fastcall virtual ~TGridAdvGridDropDown(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridAdvGridDropDown(HWND ParentWindow) : Advcustomgriddropdown::TCustomAdvGridDropDown(ParentWindow) { }
	
};


class DELPHICLASS TGridColorDropDown;
class PASCALIMPLEMENTATION TGridColorDropDown : public Advcolorpickerdropdown::TAdvColorPickerDropDown
{
	typedef Advcolorpickerdropdown::TAdvColorPickerDropDown inherited;
	
private:
	bool Forced;
	bool WorkMode;
	HIDESBASE MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Change(void);
	
public:
	TAdvStringGrid* FGrid;
	__fastcall virtual TGridColorDropDown(Classes::TComponent* AOwner);
public:
	/* TAdvColorPickerDropDown.Destroy */ inline __fastcall virtual ~TGridColorDropDown(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridColorDropDown(HWND ParentWindow) : Advcolorpickerdropdown::TAdvColorPickerDropDown(ParentWindow) { }
	
};


class DELPHICLASS TGridImageDropDown;
class PASCALIMPLEMENTATION TGridImageDropDown : public Advimagepickerdropdown::TAdvImagePickerDropDown
{
	typedef Advimagepickerdropdown::TAdvImagePickerDropDown inherited;
	
private:
	bool Forced;
	bool WorkMode;
	HIDESBASE MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Change(void);
	
public:
	TAdvStringGrid* FGrid;
	__fastcall virtual TGridImageDropDown(Classes::TComponent* AOwner);
public:
	/* TAdvImagePickerDropDown.Destroy */ inline __fastcall virtual ~TGridImageDropDown(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridImageDropDown(HWND ParentWindow) : Advimagepickerdropdown::TAdvImagePickerDropDown(ParentWindow) { }
	
};


class DELPHICLASS TGridDatePicker;
class PASCALIMPLEMENTATION TGridDatePicker : public Comctrls::TDateTimePicker
{
	typedef Comctrls::TDateTimePicker inherited;
	
private:
	bool FOldDropped;
	bool FWeekNumbers;
	bool FShowToday;
	bool FShowTodayCircle;
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	
public:
	TAdvStringGrid* FGrid;
	__fastcall virtual TGridDatePicker(Classes::TComponent* AOwner);
	void __fastcall ReCreate(void);
	
__published:
	__property Text;
	__property bool Weeknumbers = {read=FWeekNumbers, write=FWeekNumbers, default=0};
	__property bool ShowToday = {read=FShowToday, write=FShowToday, default=1};
	__property bool ShowTodayCircle = {read=FShowTodayCircle, write=FShowTodayCircle, default=1};
public:
	/* TCommonCalendar.Destroy */ inline __fastcall virtual ~TGridDatePicker(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridDatePicker(HWND ParentWindow) : Comctrls::TDateTimePicker(ParentWindow) { }
	
};


class DELPHICLASS TGridDateTimePicker;
class PASCALIMPLEMENTATION TGridDateTimePicker : public Advdatetimepicker::TAdvDateTimePicker
{
	typedef Advdatetimepicker::TAdvDateTimePicker inherited;
	
protected:
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	
public:
	TAdvStringGrid* FGrid;
	__fastcall virtual TGridDateTimePicker(Classes::TComponent* AOwner);
public:
	/* TAdvDateTimePicker.Destroy */ inline __fastcall virtual ~TGridDateTimePicker(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridDateTimePicker(HWND ParentWindow) : Advdatetimepicker::TAdvDateTimePicker(ParentWindow) { }
	
};


class DELPHICLASS TGridCheckBox;
class PASCALIMPLEMENTATION TGridCheckBox : public Stdctrls::TCheckBox
{
	typedef Stdctrls::TCheckBox inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	
protected:
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	
public:
	TAdvStringGrid* FGrid;
	__fastcall virtual TGridCheckBox(Classes::TComponent* AOwner);
	void __fastcall ReCreate(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridCheckBox(HWND ParentWindow) : Stdctrls::TCheckBox(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TGridCheckBox(void) { }
	
};


class DELPHICLASS TGridEditBtn;
class PASCALIMPLEMENTATION TGridEditBtn : public Asgedit::TAsgEditBtn
{
	typedef Asgedit::TAsgEditBtn inherited;
	
private:
	bool WorkMode;
	int FSelKeyDown;
	TAdvStringGrid* FGrid;
	bool FStopEditAfterClick;
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	
protected:
	void __fastcall ExtClick(System::TObject* Sender);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Change(void);
	void __fastcall DoChange(void);
	
public:
	__fastcall virtual TGridEditBtn(Classes::TComponent* AOwner);
	void __fastcall ReCreate(void);
	
__published:
	__property bool StopEditAfterClick = {read=FStopEditAfterClick, write=FStopEditAfterClick, default=0};
public:
	/* TAsgEditBtn.Destroy */ inline __fastcall virtual ~TGridEditBtn(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridEditBtn(HWND ParentWindow) : Asgedit::TAsgEditBtn(ParentWindow) { }
	
};


class DELPHICLASS TGridUnitEditBtn;
class PASCALIMPLEMENTATION TGridUnitEditBtn : public Asgedit::TAsgUnitEditBtn
{
	typedef Asgedit::TAsgUnitEditBtn inherited;
	
private:
	TAdvStringGrid* FGrid;
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	
protected:
	void __fastcall ExtClick(System::TObject* Sender);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	
public:
	__fastcall virtual TGridUnitEditBtn(Classes::TComponent* AOwner);
	void __fastcall ReCreate(void);
public:
	/* TAsgUnitEditBtn.Destroy */ inline __fastcall virtual ~TGridUnitEditBtn(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridUnitEditBtn(HWND ParentWindow) : Asgedit::TAsgUnitEditBtn(ParentWindow) { }
	
};


class DELPHICLASS TGridButton;
class PASCALIMPLEMENTATION TGridButton : public Stdctrls::TButton
{
	typedef Stdctrls::TButton inherited;
	
private:
	TAdvStringGrid* FGrid;
	
protected:
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Msg);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TGridButton(Classes::TComponent* AOwner);
	void __fastcall ReCreate(void);
	
__published:
	__property Text;
public:
	/* TCustomButton.Destroy */ inline __fastcall virtual ~TGridButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridButton(HWND ParentWindow) : Stdctrls::TButton(ParentWindow) { }
	
};


class DELPHICLASS TAdvInplaceEdit;
class PASCALIMPLEMENTATION TAdvInplaceEdit : public Grids::TInplaceEdit
{
	typedef Grids::TInplaceEdit inherited;
	
private:
	int FSelKeyDown;
	int FOldSelStart;
	short FLengthLimit;
	bool FValign;
	bool FWordWrap;
	bool GotKey;
	bool FGotFocus;
	bool Workmode;
	TAdvStringGrid* FGrid;
	int FColE;
	int FRowE;
	bool FAltBack;
	void __fastcall SetVAlign(bool Value);
	void __fastcall SetWordWrap(bool Value);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyUp(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMCopy(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMCut(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall UpdateContents(void);
	virtual void __fastcall BoundsChanged(void);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	
public:
	__fastcall virtual TAdvInplaceEdit(Classes::TComponent* AOwner);
	void __fastcall DoChange(void);
	
__published:
	__property bool VAlign = {read=FValign, write=SetVAlign, nodefault};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, nodefault};
	__property short LengthLimit = {read=FLengthLimit, write=FLengthLimit, nodefault};
	__property PopupMenu;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvInplaceEdit(HWND ParentWindow) : Grids::TInplaceEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TAdvInplaceEdit(void) { }
	
};


class DELPHICLASS TNoActiveForm;
class PASCALIMPLEMENTATION TNoActiveForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Messages::TWMMouseActivate &Msg);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TNoActiveForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TNoActiveForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TNoActiveForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TNoActiveForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


#pragma option push -b-
enum TFilterCells { fcVirtual, fcNormal, fcStripHTML, fcCalculated, fcRow };
#pragma option pop

class DELPHICLASS TFilterData;
class PASCALIMPLEMENTATION TFilterData : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	short FColumn;
	System::UnicodeString FCondition;
	bool FCaseSensitive;
	System::UnicodeString FSuffix;
	System::UnicodeString FPrefix;
	TFilterOperation FOperation;
	TFilterCells FData;
	
public:
	__fastcall virtual TFilterData(Classes::TCollection* ACollection);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property short Column = {read=FColumn, write=FColumn, nodefault};
	__property System::UnicodeString Condition = {read=FCondition, write=FCondition};
	__property bool CaseSensitive = {read=FCaseSensitive, write=FCaseSensitive, default=1};
	__property TFilterCells Data = {read=FData, write=FData, default=0};
	__property System::UnicodeString Prefix = {read=FPrefix, write=FPrefix};
	__property System::UnicodeString Suffix = {read=FSuffix, write=FSuffix};
	__property TFilterOperation Operation = {read=FOperation, write=FOperation, nodefault};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TFilterData(void) { }
	
};


class DELPHICLASS TFilter;
class PASCALIMPLEMENTATION TFilter : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
private:
	TAdvStringGrid* FOwner;
	HIDESBASE TFilterData* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TFilterData* Value);
	TFilterData* __fastcall GetColFilter(int Col);
	
public:
	__fastcall TFilter(TAdvStringGrid* AOwner);
	HIDESBASE TFilterData* __fastcall Add(void);
	HIDESBASE TFilterData* __fastcall Insert(int index);
	__property TFilterData* Items[int Index] = {read=GetItem, write=SetItem};
	__property TFilterData* ColumnFilter[int Col] = {read=GetColFilter};
	bool __fastcall HasFilter(int Col);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TFilter(void) { }
	
};


class DELPHICLASS TGridItem;
class PASCALIMPLEMENTATION TGridItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FIdx;
	int FHeight;
	Classes::TStrings* FItems;
	int FLevel;
	void __fastcall SetIdx(const int Value);
	void __fastcall SetItems(const Classes::TStrings* Value);
	void __fastcall SetHeight(const int Value);
	
public:
	__fastcall virtual TGridItem(Classes::TCollection* Collection);
	__fastcall virtual ~TGridItem(void);
	
__published:
	__property int Idx = {read=FIdx, write=SetIdx, nodefault};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property int Level = {read=FLevel, write=FLevel, nodefault};
	__property Classes::TStrings* Items = {read=FItems, write=SetItems};
};


class DELPHICLASS TAdvRichEdit;
class PASCALIMPLEMENTATION TAdvRichEdit : public Comctrls::TRichEdit
{
	typedef Comctrls::TRichEdit inherited;
	
private:
	TAdvStringGrid* FGrid;
	int FReqHeight;
	int FReqWidth;
	bool FLocked;
	void __fastcall SelFormat(int offset);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &Msg);
	
protected:
	void __fastcall Lock(void);
	void __fastcall Unlock(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TAdvRichEdit(Classes::TComponent* AOwner);
	void __fastcall ReCreate(void);
	void __fastcall SelSubscript(void);
	void __fastcall SelSuperscript(void);
	void __fastcall SelNormal(void);
	bool __fastcall IsSelSubscript(void);
	bool __fastcall IsSelSuperscript(void);
	bool __fastcall IsSelNormal(void);
	
__published:
	__property int ReqWidth = {read=FReqWidth, nodefault};
	__property int ReqHeight = {read=FReqHeight, nodefault};
public:
	/* TCustomRichEdit.Destroy */ inline __fastcall virtual ~TAdvRichEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvRichEdit(HWND ParentWindow) : Comctrls::TRichEdit(ParentWindow) { }
	
};


#pragma option push -b-
enum TMouseSelectMode { msNormal, msColumn, msRow, msAll, msURL, msResize };
#pragma option pop

#pragma option push -b-
enum TClipOperation { coCut, coCopy };
#pragma option pop

class DELPHICLASS TDragDropSettings;
class PASCALIMPLEMENTATION TDragDropSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvStringGrid* FGrid;
	bool FOleDropRTF;
	bool FOleAcceptText;
	bool FOleEntireRows;
	bool FOleDropSource;
	bool FOleRemoveRows;
	bool FOleAcceptFiles;
	bool FOleAcceptURLs;
	bool FOleDropTarget;
	bool FOleInsertRows;
	bool FOleCopyAlways;
	bool FOleColumnDragDrop;
	bool FShowCells;
	void __fastcall SetOleDropRTF(const bool Value);
	void __fastcall SetOleDropTarget(const bool Value);
	void __fastcall SetShowCells(const bool Value);
	
public:
	__fastcall TDragDropSettings(TAdvStringGrid* AOwner);
	__fastcall virtual ~TDragDropSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool ShowCells = {read=FShowCells, write=SetShowCells, default=1};
	__property bool OleAcceptFiles = {read=FOleAcceptFiles, write=FOleAcceptFiles, default=1};
	__property bool OleAcceptText = {read=FOleAcceptText, write=FOleAcceptText, default=1};
	__property bool OleAcceptURLs = {read=FOleAcceptURLs, write=FOleAcceptURLs, default=1};
	__property bool OleCopyAlways = {read=FOleCopyAlways, write=FOleCopyAlways, default=0};
	__property bool OleDropTarget = {read=FOleDropTarget, write=SetOleDropTarget, default=0};
	__property bool OleDropSource = {read=FOleDropSource, write=FOleDropSource, default=0};
	__property bool OleEntireRows = {read=FOleEntireRows, write=FOleEntireRows, default=0};
	__property bool OleInsertRows = {read=FOleInsertRows, write=FOleInsertRows, default=0};
	__property bool OleRemoveRows = {read=FOleRemoveRows, write=FOleRemoveRows, default=0};
	__property bool OleDropRTF = {read=FOleDropRTF, write=SetOleDropRTF, default=0};
	__property bool OleColumnDragDrop = {read=FOleColumnDragDrop, write=FOleColumnDragDrop, default=0};
};


class DELPHICLASS TGridDropTarget;
class PASCALIMPLEMENTATION TGridDropTarget : public Asgdd::TASGDropTarget
{
	typedef Asgdd::TASGDropTarget inherited;
	
private:
	TAdvStringGrid* FGrid;
	
public:
	__fastcall TGridDropTarget(TAdvStringGrid* AGrid);
	virtual void __fastcall DropText(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DropStream(const Types::TPoint &pt, Classes::TMemoryStream* ms);
	virtual void __fastcall DropCol(const Types::TPoint &pt, int Col);
	virtual void __fastcall DropRTF(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DropFiles(const Types::TPoint &pt, Classes::TStrings* files);
	virtual void __fastcall DropURL(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DragMouseMove(const Types::TPoint &pt, bool &Allow, Asgdd::TDropFormats DropFormats);
	virtual void __fastcall DragMouseLeave(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TGridDropTarget(void) { }
	
};


class DELPHICLASS TGridDropSource;
class PASCALIMPLEMENTATION TGridDropSource : public Asgdd::TASGDropSource
{
	typedef Asgdd::TASGDropSource inherited;
	
private:
	TAdvStringGrid* FGrid;
	int FLastEffect;
	
protected:
	virtual void __fastcall DragDropStop(void);
	
public:
	__fastcall TGridDropSource(TAdvStringGrid* aGrid);
	virtual void __fastcall CurrentEffect(int dwEffect);
	virtual void __fastcall QueryDrag(void);
	__property int LastEffect = {read=FLastEffect, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TGridDropSource(void) { }
	
};


class DELPHICLASS TGridChangeNotifier;
class PASCALIMPLEMENTATION TGridChangeNotifier : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
protected:
	virtual void __fastcall CellsChanged(const Types::TRect &R);
public:
	/* TComponent.Create */ inline __fastcall virtual TGridChangeNotifier(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TGridChangeNotifier(void) { }
	
};


class DELPHICLASS THTMLHintWindow;
class PASCALIMPLEMENTATION THTMLHintWindow : public Controls::THintWindow
{
	typedef Controls::THintWindow inherited;
	
private:
	int FTextHeight;
	int FTextWidth;
	System::WideString FWideCaption;
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	__property System::WideString WideCaption = {read=FWideCaption, write=FWideCaption};
	
public:
	virtual void __fastcall ActivateHint(const Types::TRect &Rect, const System::UnicodeString AHint);
	virtual Types::TRect __fastcall CalcHintRect(int MaxWidth, const System::UnicodeString AHint, void * AData);
public:
	/* THintWindow.Create */ inline __fastcall virtual THTMLHintWindow(Classes::TComponent* AOwner) : Controls::THintWindow(AOwner) { }
	
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~THTMLHintWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THTMLHintWindow(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	
};


class DELPHICLASS TRetEdit;
class PASCALIMPLEMENTATION TRetEdit : public Stdctrls::TEdit
{
	typedef Stdctrls::TEdit inherited;
	
private:
	Classes::TNotifyEvent FOnReturn;
	Classes::TNotifyEvent FOnCtrlReturn;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
__published:
	__property Classes::TNotifyEvent OnReturn = {read=FOnReturn, write=FOnReturn};
	__property Classes::TNotifyEvent OnCtrlReturn = {read=FOnCtrlReturn, write=FOnCtrlReturn};
public:
	/* TCustomEdit.Create */ inline __fastcall virtual TRetEdit(Classes::TComponent* AOwner) : Stdctrls::TEdit(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRetEdit(HWND ParentWindow) : Stdctrls::TEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TRetEdit(void) { }
	
};


class DELPHICLASS TSearchPanel;
class PASCALIMPLEMENTATION TSearchPanel : public Extctrls::TPanel
{
	typedef Extctrls::TPanel inherited;
	
private:
	TAdvStringGrid* FGrid;
	TRetEdit* FEdit;
	Advobj::TAdvGridButton* FExitButton;
	Advobj::TAdvGridButton* FForwardButton;
	Advobj::TAdvGridButton* FBackwardButton;
	Advobj::TAdvGridButton* FHiliteButton;
	Advobj::TAdvCheckBox* FMatchCase;
	Classes::TNotifyEvent FOnForwardClick;
	Classes::TNotifyEvent FOnBackwardClick;
	Classes::TNotifyEvent FOnEditChange;
	Classes::TNotifyEvent FOnExitClick;
	Classes::TNotifyEvent FOnHighLightClick;
	Graphics::TColor FColorTo;
	System::UnicodeString FFindNextCaption;
	System::UnicodeString FFindPrevCaption;
	System::UnicodeString FMatchCaseCaption;
	System::UnicodeString FHintFindPrev;
	System::UnicodeString FHintClose;
	System::UnicodeString FHintFindNext;
	System::UnicodeString FHintHighlight;
	System::UnicodeString FHighLightCaption;
	void __fastcall SetColorTo(const Graphics::TColor Value);
	
protected:
	void __fastcall ForwardClick(System::TObject* Sender);
	void __fastcall BackwardClick(System::TObject* Sender);
	void __fastcall ExitClick(System::TObject* Sender);
	void __fastcall HighlightClick(System::TObject* Sender);
	void __fastcall EditChange(System::TObject* Sender);
	void __fastcall EditKeydown(System::TObject* Sender, System::Word &Key, Classes::TShiftState shift);
	void __fastcall EditReturn(System::TObject* Sender);
	void __fastcall EditCtrlReturn(System::TObject* Sender);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TSearchPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TSearchPanel(void);
	virtual void __fastcall CreateWnd(void);
	__property System::UnicodeString FindNextCaption = {read=FFindNextCaption, write=FFindNextCaption};
	__property System::UnicodeString FindPrevCaption = {read=FFindPrevCaption, write=FFindPrevCaption};
	__property System::UnicodeString MatchCaseCaption = {read=FMatchCaseCaption, write=FMatchCaseCaption};
	__property System::UnicodeString HighLightCaption = {read=FHighLightCaption, write=FHighLightCaption};
	__property System::UnicodeString HintClose = {read=FHintClose, write=FHintClose};
	__property System::UnicodeString HintFindNext = {read=FHintFindNext, write=FHintFindNext};
	__property System::UnicodeString HintFindPrev = {read=FHintFindPrev, write=FHintFindPrev};
	__property System::UnicodeString HintHighlight = {read=FHintHighlight, write=FHintHighlight};
	__property TRetEdit* EditControl = {read=FEdit};
	__property Advobj::TAdvCheckBox* MatchCase = {read=FMatchCase};
	__property Advobj::TAdvGridButton* HiliteButton = {read=FHiliteButton};
	__property Advobj::TAdvGridButton* ForwardButton = {read=FForwardButton};
	__property Advobj::TAdvGridButton* BackwardButton = {read=FBackwardButton};
	__property Advobj::TAdvGridButton* ExitButton = {read=FExitButton};
	
__published:
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Classes::TNotifyEvent OnBackwardClick = {read=FOnBackwardClick, write=FOnBackwardClick};
	__property Classes::TNotifyEvent OnEditChange = {read=FOnEditChange, write=FOnEditChange};
	__property Classes::TNotifyEvent OnForwardClick = {read=FOnForwardClick, write=FOnForwardClick};
	__property Classes::TNotifyEvent OnHighlightClick = {read=FOnHighLightClick, write=FOnHighLightClick};
	__property Classes::TNotifyEvent OnExitClick = {read=FOnExitClick, write=FOnExitClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TSearchPanel(HWND ParentWindow) : Extctrls::TPanel(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TFooterPaintEvent)(System::TObject* Sender, int AColumn, Graphics::TCanvas* Canvas, const Types::TRect &ARect);

class DELPHICLASS TFooterPanel;
class PASCALIMPLEMENTATION TFooterPanel : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	TAdvStringGrid* FGrid;
	int FLastHintX;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Controls::TCMHintShow &Msg);
	
protected:
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	System::UnicodeString __fastcall HTMLColReplace(System::UnicodeString s);
	int __fastcall PaintLastRow(void);
	int __fastcall PaintColPreview(void);
	int __fastcall PaintCustomPreview(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateWnd(void);
	Types::TRect __fastcall RTLCoord(bool rtl, const Types::TRect &ARect);
	
public:
	__fastcall virtual TFooterPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TFooterPanel(void);
	
__published:
	__property BorderWidth = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TFooterPanel(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
};


#pragma option push -b-
enum TFooterStyle { fsFixedLastRow, fsColumnPreview, fsCustomPreview };
#pragma option pop

class DELPHICLASS TFloatingFooter;
class PASCALIMPLEMENTATION TFloatingFooter : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvStringGrid* FGrid;
	int FHeight;
	bool FVisible;
	Graphics::TColor FColor;
	TFooterStyle FFooterStyle;
	int FColumn;
	TCalcFooterEvent FOnCalcFooter;
	System::UnicodeString FCustomTemplate;
	bool FCalculateHiddenRows;
	bool FEnableCalculation;
	bool FShowHint;
	Graphics::TColor FBorderColor;
	void __fastcall SetHeight(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFooterStyle(const TFooterStyle Value);
	void __fastcall SetColumn(const int Value);
	void __fastcall SetCustomTemplate(const System::UnicodeString Value);
	Basegrid::TColumnCalcType __fastcall GetColumnCalc(int c);
	void __fastcall SetColumnCalc(int c, const Basegrid::TColumnCalcType Value);
	void __fastcall SetEnableCalculation(const bool Value);
	void __fastcall SetShowHint(const bool Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	
public:
	__fastcall TFloatingFooter(TAdvStringGrid* AOwner);
	__fastcall virtual ~TFloatingFooter(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Invalidate(void);
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property Basegrid::TColumnCalcType ColumnCalc[int c] = {read=GetColumnCalc, write=SetColumnCalc};
	__property bool EnableCalculation = {read=FEnableCalculation, write=SetEnableCalculation, nodefault};
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=536870911};
	__property bool CalculateHiddenRows = {read=FCalculateHiddenRows, write=FCalculateHiddenRows, default=1};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777201};
	__property int Column = {read=FColumn, write=SetColumn, default=0};
	__property System::UnicodeString CustomTemplate = {read=FCustomTemplate, write=SetCustomTemplate};
	__property TFooterStyle FooterStyle = {read=FFooterStyle, write=SetFooterStyle, default=0};
	__property bool ShowHint = {read=FShowHint, write=SetShowHint, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property TCalcFooterEvent OnCalcFooter = {read=FOnCalcFooter, write=FOnCalcFooter};
};


struct TCellAlignment
{
	
public:
	Classes::TAlignment Alignment;
	Advobj::TVAlignment VAlignment;
};


#pragma option push -b-
enum THoverFixedCells { hfNone, hfAll, hfFixedRows, hfFixedColumns };
#pragma option pop

struct TScrollProp
{
	
public:
	int PageSize;
	int Range;
};


#pragma option push -b-
enum TInvalidEntryIcon { ieNone, ieInfo, ieWarning, ieError };
#pragma option pop

#pragma option push -b-
enum TBalloonIcon { biNone, biInfo, biWarning, biError };
#pragma option pop

typedef Set<char, 0, 255>  TCharSet;

class PASCALIMPLEMENTATION TAdvStringGrid : public Basegrid::TBaseGrid
{
	typedef Basegrid::TBaseGrid inherited;
	
private:
	Advstyleif::TTMSStyle FStyle;
	int FFilterLevel;
	System::UnicodeString FLastFilter;
	bool FForceSel;
	int FMoveColInd;
	int FMoveRowInd;
	int FGroupColumn;
	System::UnicodeString FGroupCaption;
	System::UnicodeString FGroupFooter;
	int FGroupWidth;
	bool FAutoSize;
	bool FAutoNumAlign;
	bool FEnhTextSize;
	bool FEditWithTags;
	bool FOemConvert;
	bool FLookup;
	bool FLoaded;
	bool FLookupCaseSensitive;
	bool FDeselectState;
	bool FSelectionClick;
	bool FMouseDown;
	bool FMouseKeepDown;
	bool FCtrlDown;
	bool FMouseResize;
	bool FMouseDownMove;
	bool FLookupHistory;
	bool FEnhRowColMove;
	bool FSizeWithForm;
	bool FMultilineCells;
	Advobj::TIntList* FSortRowXRef;
	Advobj::TIntList* FUnSortRowXRef;
	Advobj::TIntList* FMergedColumns;
	Advobj::TIntList* FSelectedCells;
	Advobj::TIntList* FSelectedRows;
	Advobj::TIntList* FModifiedRows;
	Advobj::TIntList* FEnabledRows;
	Advobj::TGridColorEvent FOnGetCellColor;
	Advobj::TGridGradientEvent FOnGetCellGradient;
	Advobj::TGridColorEvent FOnGetCellPrintColor;
	Advobj::TGridBorderEvent FOnGetCellBorder;
	Advobj::TGridBorderEvent FOnGetCellPrintBorder;
	Advobj::TGridAlignEvent FOnGetAlignment;
	Advobj::TGridFormatEvent FOnGetFormat;
	Advobj::TFloatFormatEvent FOnGetFloatFormat;
	TGetCheckEvent FOnGetCheckTrue;
	TGetCheckEvent FOnGetCheckFalse;
	TRowDisjunctSelectEvent FOnRowDisjunctSelect;
	Advobj::TAutoInsertRowEvent FOnRowDisjunctSelected;
	Advobj::TGridHintEvent FOnGridHint;
	TGridWideHintEvent FOnGridWideHint;
	TRowChangingEvent FOnRowChanging;
	TRowChangedEvent FOnRowChanged;
	TColChangingEvent FOnColChanging;
	TCellChangingEvent FOnCellChanging;
	TAutoAdvanceEvent FOnAutoAdvance;
	Forms::TShowHintEvent FOnShowHint;
	Advobj::TCanAddRowEvent FOnCanAddRow;
	Advobj::TAutoAddRowEvent FOnAutoAddRow;
	Advobj::TCanInsertRowEvent FOnCanInsertRow;
	Advobj::TAutoInsertRowEvent FOnAutoInsertRow;
	Advobj::TAutoInsertColEvent FOnAutoInsertCol;
	Advobj::TCanDeleteRowEvent FOnCanDeleteRow;
	Advobj::TAutoDeleteRowEvent FOnAutoDeleteRow;
	TOleDragDropEvent FOnOleDrop;
	TOleDragDropEvent FOnOleDrag;
	TOleDragOverEvent FOnOleDragOver;
	TOleDragStartEvent FOnOleDragStart;
	TOleDragStopEvent FOnOleDragStop;
	TOleDropColEvent FOnOleDropCol;
	TOleDroppedEvent FOnOleDropped;
	TGridDropTarget* FGridDropTarget;
	TOleDropFileEvent FOnOleDropFile;
	TOleDropURLEvent FOnOleDropURL;
	Advobj::TClickSortEvent FOnClickSort;
	Advobj::TCanSortEvent FOnCanSort;
	TNodeClickEvent FOnExpandNode;
	TNodeClickEvent FOnContractNode;
	TNodeAllowEvent FOnBeforeExpandNode;
	TNodeAllowEvent FOnBeforeContractNode;
	Advobj::TCustomCompareEvent FCustomCompare;
	Advobj::TRawCompareEvent FRawCompare;
	Advobj::TSearchEditChangeEvent FOnSearchEditChange;
	TSearchFooterActionEvent FOnSearchFooterAction;
	Classes::TNotifyEvent FOnSearchFooterClose;
	TClipboardEvent FOnClipboardPaste;
	TClipboardEvent FOnClipboardCut;
	TClipboardEvent FOnClipboardCopy;
	TBeforeCellPasteEvent FOnClipboardBeforePasteCell;
	TAfterCellPasteEvent FOnClipboardAfterPasteCell;
	TBeforeCellPasteWideEvent FOnClipboardBeforePasteWideCell;
	TAfterCellPasteWideEvent FOnClipboardAfterPasteWideCell;
	Advobj::TOnResizeEvent FOnResize;
	TGridPrintStartEvent FOnPrintStart;
	TGridPrintCancelEvent FOnPrintCancel;
	TGridPrintPageEvent FOnPrintPage;
	TGridPrintNewPageEvent FOnPrintNewPage;
	TGridPrintPageDoneEvent FOnPrintPageDone;
	TGridPrintColumnWidthEvent FOnPrintSetColumnWidth;
	TGridPrintRowHeightEvent FOnPrintSetRowHeight;
	TDoFitToPageEvent FDoFitToPage;
	Advobj::TClickCellEvent FOnClickCell;
	Advobj::TClickCellEvent FOnRightClickCell;
	Advobj::TDblClickCellEvent FOnDblClickCell;
	Advobj::TCanEditCellEvent FOnCanEditCell;
	TCanClickCellEvent FOnCanClickCell;
	TIsFixedCellEvent FOnIsFixedCell;
	TIsPasswordCellEvent FOnIsPasswordCell;
	Advobj::TAnchorClickEvent FOnAnchorClick;
	Advobj::TAnchorEvent FOnAnchorEnter;
	Advobj::TAnchorEvent FOnAnchorExit;
	Advobj::TAnchorHintEvent FOnAnchorHint;
	TCellControlEvent FOnControlClick;
	TCellControlEvent FOnControlEditDone;
	TCellComboControlEvent FOnControlComboList;
	TCellComboControlSelectEvent FOnControlComboSelect;
	TCellValidateEvent FOnCellValidate;
	TCellValidateWideEvent FOnCellValidateWide;
	TCellsChangedEvent FOnCellsChanged;
	TGridProgressEvent FOnFileProgress;
	TGridProgressEvent FOnFilterProgress;
	TFixedDropDownEvent FOnFixedDropDownClick;
	TCanShowFixedDropDownEvent FOnCanShowFixedDropDown;
	Classes::TNotifyEvent FOnRichEditSelectionChange;
	TGetColumnFilterEvent FOnGetColumnFilter;
	TFilterSelectEvent FOnFilterSelect;
	TColorSelectedEvent FOnColorSelected;
	TColorSelectEvent FOnColorSelect;
	TImageSelectedEvent FOnImageSelected;
	TImageSelectEvent FOnImageSelect;
	Classes::TNotifyEvent FOnFilterDone;
	Graphics::TColor FHintColor;
	Graphics::TColor FHighlightColor;
	Graphics::TColor FHighLightTextColor;
	bool FHintShowCells;
	bool FHintShowLargeText;
	bool FHintShowSizing;
	Types::TPoint FLastHintPos;
	Types::TPoint FLastBalloonPos;
	Graphics::TBitmap* FRowIndicator;
	Advobj::TSortIndexList* FSortIndexes;
	TBackGround* FBackGround;
	Grids::TGridRect FDropSelection;
	bool FOleDropTargetAssigned;
	Advobj::TArrowWindow* ArwU;
	Advobj::TArrowWindow* ArwD;
	Advobj::TArrowWindow* ArwL;
	Advobj::TArrowWindow* ArwR;
	Advobj::TColumnSizeEvent FOnColumnSize;
	Advobj::TRowSizingEvent FOnRowSizing;
	Advobj::TColumnSizingEvent FOnColumnSizing;
	Advobj::TRowSizeEvent FOnRowSize;
	Advobj::TColumnSizeEvent FOnColumnMove;
	Advobj::TColumnSizeEvent FOnColumnMoving;
	Advobj::TRowSizeEvent FOnRowMove;
	Advobj::TRowSizeEvent FOnRowMoving;
	Advobj::TEndColumnSizeEvent FOnEndColumnSize;
	Advobj::TEndRowSizeEvent FOnEndRowSize;
	TPrintSettings* FPrintSettings;
	bool FFastPrint;
	THTMLSettings* FHTMLSettings;
	TBands* FBands;
	Advobj::TNavigation* FNavigation;
	TColumnSize* FColumnSize;
	bool FScrollProportional;
	TCellNode* FCellNode;
	TSizeWhileTyping* FSizeWhileTyping;
	Advobj::TMouseActions* FMouseActions;
	TGrouping* FGrouping;
	TBoolArray FVisibleCol;
	TWidthArray FAllColWidths;
	int FUpdateCount;
	bool FLastValidation;
	int FNumNodes;
	int FNumHidden;
	Graphics::TColor FSelectionColor;
	Graphics::TColor FSelectionColorTo;
	Graphics::TColor FSelectionMirrorColor;
	Graphics::TColor FSelectionMirrorColorTo;
	Graphics::TColor FSelectionTextColor;
	bool FSelectionRectangle;
	bool FSelectionRTFKeep;
	Advobj::TVAlignment FVAlignment;
	unsigned FVAlign;
	bool FURLShow;
	bool FURLShowInText;
	bool FURLFull;
	Graphics::TColor FURLColor;
	bool FURLEdit;
	Imglist::TCustomImageList* FGridImages;
	TIntelliPan FIntelliPan;
	bool FIntelliZoom;
	TScrollType FScrollType;
	Graphics::TColor FScrollColor;
	int FScrollWidth;
	bool FScrollSynch;
	TScrollHintType FScrollHints;
	bool FIsFlat;
	TAdvRichEdit* FRichEdit;
	TAdvRichEdit* FInplaceRichEdit;
	bool FFixedAsButtons;
	Menus::TPopupMenu* FFixedDropDownMenu;
	bool FFixedCellPushed;
	Types::TRect FPushedFixedCell;
	Types::TPoint FPushedCellButton;
	bool FHideFocusRect;
	Graphics::TFont* FFixedFont;
	bool FFixedRowAlways;
	bool FFixedColAlways;
	int FFixedRowsMin;
	int FFixedColsMin;
	Classes::TStringList* FColumnHeaders;
	Classes::TStringList* FRowHeaders;
	Classes::TStringList* FLookupItems;
	Classes::TList* FRowSelect;
	Classes::TList* FColSelect;
	int FFixedFooters;
	int FFixedRightCols;
	System::WideChar FDelimiter;
	bool FNoDefaultDraw;
	System::WideChar FPasswordChar;
	bool FJavaCSV;
	System::UnicodeString FCheckTrue;
	System::UnicodeString FCheckFalse;
	System::UnicodeString FEditMask;
	bool FEnableHTML;
	bool FEnableWheel;
	bool FFlat;
	bool FAnchorHint;
	bool FSaveFixedCells;
	bool FLoadFirstRow;
	bool FSaveHiddenCells;
	bool FSaveVirtCells;
	bool FSaveWithHTML;
	bool FSaveWithRTF;
	bool FWordWrapEx;
	bool FModified;
	bool FEditDisable;
	bool FEditChange;
	bool FExcelStyleDecimalSeparator;
	bool FHovering;
	THoverFixedCells FHoverFixedCells;
	bool FNoMouseLeave;
	bool FDropDownDown;
	int FHoverFixedX;
	int FHoverFixedY;
	System::UnicodeString FFloatFormat;
	System::UnicodeString FOldCellText;
	System::UnicodeString FNewCellText;
	System::WideString FOldCellTextWide;
	System::WideChar FStartEditChar;
	int FOldCol;
	int FOldRow;
	int FOldRowSel;
	bool FOldModifiedValue;
	int FOldCursor;
	bool FBlockFocus;
	bool FBlockKill;
	bool FDblClk;
	Grids::TGridRect FOldSelection;
	Grids::TGridRect FSizeSelection;
	Grids::TGridRect FMoveSelection;
	bool FEntered;
	bool FEditing;
	bool FSpecialEditor;
	bool FEditActive;
	bool FValidating;
	bool FFindBusy;
	int FComboIdx;
	int SortDir;
	int SortRow;
	Types::TPoint SearchCell;
	bool ResizeAssigned;
	Grids::TGridRect FPrintRect;
	TFindParams FFindParams;
	System::UnicodeString SearchCache;
	System::WideString SearchCacheWide;
	System::UnicodeString SearchInc;
	int SearchTics;
	System::UnicodeString FAnchor;
	int FZoomFactor;
	bool FIsColChanging;
	bool ColchgFlg;
	bool ColMoveFlg;
	bool ColSizeFlg;
	bool ColSized;
	bool Rowsized;
	int Colclicked;
	int Rowclicked;
	int Colclickedsize;
	int Rowclickedsize;
	int Movecell;
	int MoveOfsX;
	int MoveOfsY;
	int Clickposx;
	int Clickposy;
	int Clickposdx;
	int Clickposdy;
	bool Invokedchange;
	bool InvokedFocusChange;
	unsigned wheelmsg;
	int wheelscrl;
	bool wheelpan;
	Types::TPoint wheelpanpos;
	unsigned wheeltimer;
	HICON prevcurs;
	TMouseSelectMode FMouseSelectMode;
	int FMouseSelectStart;
	bool FPrinterdriverfix;
	Types::TRect PrevRect;
	double Fontscalefactor;
	int FPrintPageWidth;
	Types::TRect FPrintPageRect;
	int FPrintColStart;
	int FPrintColEnd;
	int FPrintPageFrom;
	int FPrintPageTo;
	int FPrintPageNum;
	bool FExcelClipboardFormat;
	int FGridTimerID;
	bool FGridBlink;
	int FMaxEditLength;
	int FMaxComboLength;
	TGridLook FLook;
	Picturecontainer::TPictureContainer* FContainer;
	Asgcheck::TAdvStringGridCheck* FCellChecker;
	Picturecontainer::THTMLPictureCache* FImageCache;
	Types::TPoint FCtrlXY;
	System::UnicodeString FCtrlID;
	System::UnicodeString FCtrlType;
	bool FCtrlEditing;
	bool FPasteAll;
	bool FSpinUpClick;
	bool FSpinDnClick;
	StaticArray<int, 513> MaxWidths;
	StaticArray<int, 513> Indents;
	Advobj::TGetEditorTypeEvent FOnGetEditorType;
	THasComboEvent FOnHasComboBox;
	THasSpinEditEvent FOnHasSpinEdit;
	TGetEditorPropEvent FOnGetEditorProp;
	Advobj::TClickCellEvent FonGetEditorPropInt;
	Advobj::TEllipsClickEvent FOnEllipsClick;
	Advobj::TButtonClickEvent FOnButtonClick;
	Advobj::TCheckBoxClickEvent FOnCheckBoxClick;
	Advobj::TCheckBoxClickEvent FOnCheckBoxMouseUp;
	Advobj::TCheckBoxClickEvent FOnCheckBoxChange;
	TRatingChangeEvent FOnRatingChange;
	TRadioClickEvent FOnRadioClick;
	TRadioClickEvent FOnRadioMouseUp;
	TRadioButtonClickEvent FOnRadioButtonClick;
	TComboChangeEvent FOnComboChange;
	Advobj::TClickCellEvent FOnComboCloseUp;
	Advobj::TClickCellEvent FOnDatePickerCloseUp;
	Advobj::TClickCellEvent FOnDatePickerDropDown;
	TComboObjectChangeEvent FOnComboObjectChange;
	Advobj::TSpinClickEvent FOnSpinClick;
	TFloatSpinClickEvent FOnFloatSpinClick;
	TDateTimeSpinClickEvent FOntimeSpinClick;
	TDateTimeSpinClickEvent FOnDateSpinClick;
	TDateTimeChangeEvent FOnDateTimeChange;
	Advobj::TScrollHintEvent FOnScrollHint;
	TEditLink* FEditLink;
	TControlEdit* FEditControl;
	TControlCombo* FComboControl;
	Controls::TWinControl* EditCtrl;
	TGridCombo* EditCombo;
	TGridSpin* EditSpin;
	TGridTransEdit* EditTrans;
	TGridTrackbarDropDown* EditTrackBar;
	TGridMemoDropDown* EditMemo;
	TGridCalculatorDropDown* EditCalculator;
	TGridTimepickerDropDown* EditTimePicker;
	TGridDetailPickerDropDown* EditDetailPicker;
	TGridGridDropDown* EditGridPicker;
	TGridColorDropDown* EditColorPicker;
	TGridImageDropDown* EditImagePicker;
	TGridAdvGridDropDown* EditAdvGridPicker;
	TGridCheckBox* EditCheck;
	TGridEditBtn* EditBtn;
	TGridUnitEditBtn* UnitEditBtn;
	TGridDatePicker* EditDate;
	TGridDateTimePicker* EditDateTime;
	TGridButton* GridButton;
	Advobj::TPopupButton* MoveButton;
	Forms::TForm* MoveForm;
	Advobj::TEditorType EditControl;
	Classes::TCollection* FGridItems;
	TFilter* FFilter;
	bool FFilterActive;
	int FFilterCol;
	int FFilterFixedRows;
	TFilterDropDown* FFilterDropDown;
	TDropList* FDropList;
	Classes::TStringList* FFilterList;
	bool FAutoFilterUpdate;
	Classes::TList* FNotifierList;
	bool FActiveCellShow;
	Graphics::TFont* FActiveCellFont;
	Types::TPoint FXYOffset;
	bool FXYOffsetTopLeftOnly;
	int FOldSize;
	Advobj::TIntList* FOrigColSizes;
	bool FSizeFixed;
	int FSizeFixedCol;
	bool FSizingFixed;
	int FSizeFixedRow;
	bool FSizeFixedR;
	bool FSizingFixedR;
	int FSizeFixedX;
	int FSizeFixedY;
	bool FDisableChange;
	bool FNilObjects;
	bool FQuoteEmptyCells;
	bool FAutoThemeAdapt;
	bool FAlwaysQuotes;
	TSortSettings* FSortSettings;
	Graphics::TColor FSelectionRectangleColor;
	TDragDropSettings* FDragDropSettings;
	TControlLook* FControlLook;
	Advobj::TGridBorderPropEvent FOnGetCellBorderProp;
	TFooterPanel* FFooterPanel;
	TSearchPanel* FSearchPanel;
	Advobj::TSearchFooter* FSearchFooter;
	TFloatingFooter* FFloatingFooter;
	bool FIntegralHeight;
	bool FIsWinXP;
	bool FIsWin7;
	bool FIsWinVista;
	bool FIsComCtl6;
	bool FClearTextOnly;
	Classes::TNotifyEvent FOnEditingDone;
	TEditChangeEvent FOnEditChange;
	TEditCellDoneEvent FOnEditCellDone;
	Advobj::TUpdateColumnSizeEvent FOnUpdateColumnSize;
	bool FHTMLHint;
	bool FAlwaysValidate;
	bool FEnableBlink;
	Classes::TNotifyEvent FOnGridResize;
	bool FSizeGrowOnly;
	Graphics::TColor FActiveCellColor;
	Graphics::TColor FActiveCellColorTo;
	bool FSelectionResizer;
	int FMaxColWidth;
	int FMinRowHeight;
	int FMinColWidth;
	int FMaxRowHeight;
	TCustomFilterEvent FOnCustomFilter;
	Advobj::TCustomCellDrawEvent FOnCustomCellDraw;
	Advobj::TCustomCellDrawEvent FOnCustomCellBkgDraw;
	TCustomCellSizeEvent FOnCustomCellSize;
	TSelectionResizeEvent FSelectionResizeEvent;
	TSelectionResizeEvent FSelectionResizedEvent;
	TWordWrapEvent FOnGetWordWrap;
	TGroupCalcEvent FOnGroupCalc;
	Graphics::TColor FTMSGradFrom;
	Graphics::TColor FTMSGradTo;
	Graphics::TColor FTMSGradMirrorFrom;
	Graphics::TColor FTMSGradMirrorTo;
	Graphics::TColor FTMSGradHoverFrom;
	Graphics::TColor FTMSGradHoverTo;
	Graphics::TColor FTMSGradHoverMirrorFrom;
	Graphics::TColor FTMSGradHoverMirrorTo;
	Graphics::TColor FTMSGradHoverBorder;
	Graphics::TColor FTMSGradDownFrom;
	Graphics::TColor FTMSGradDownTo;
	Graphics::TColor FTMSGradDownMirrorFrom;
	Graphics::TColor FTMSGradDownMirrorTo;
	Graphics::TColor FTMSGradDownBorder;
	bool FUseHTMLHints;
	bool FShowNullDates;
	unsigned FICursor;
	int FFixedRowHeight;
	bool FSelHidden;
	Advobj::TIntList* FColumnOrder;
	TSortDirection FAutoNumberDirection;
	int FAutoNumberOffset;
	int FAutoNumberStart;
	int FOldLeftCol;
	int FOldKeepLeftCol;
	int FOldTopRow;
	TSelectionChanged FSelectionChanged;
	Stdctrls::TScrollStyle FScrollBars;
	TScrollCellEvent FOnScrollCell;
	Classes::TWndMethod FGridControlWndProc;
	int FNumCellControls;
	Advobj::TControlList* FControlList;
	bool FDisableSize;
	Advobj::TEditorType FDefaultEditor;
	Graphics::TColor FDisabledFontColor;
	Types::TPoint FHotFixedCell;
	Classes::TNotifyEvent FOnPainted;
	bool FCellSelectorMode;
	int FAECol;
	int FAERow;
	bool FShowEditProcess;
	bool FEditStart;
	TBalloonSettings* FBalloonSettings;
	unsigned FHToolTip;
	TScrollBarAlways FScrollBarAlways;
	StaticArray<System::WideChar, 4097> FToolTipBuffer;
	Advobj::TGridBalloonEvent FOnCellBalloon;
	TShowModified* FShowModified;
	TCellGraphic* FCellGraphic;
	TFooterPaintEvent FOnPaintFooter;
	TCalcFooterEvent FOnCalcFooter;
	TDragScrollOptions* FDragScrollOptions;
	int FTimerTicks;
	Extctrls::TTimer* FDragTmr;
	TDragScrollDirection FDragScrollDirection;
	TDragScrollEvent FOnDragScroll;
	int FFindCol;
	int FFindRow;
	bool FNoImageAndText;
	TCellSaveLoadEvent FOnSaveCell;
	TCellSaveLoadEvent FOnLoadCell;
	int FMaxRowCount;
	int FMaxColCount;
	bool FUseEnabledRows;
	int FLastTabCol;
	int FLastTabRow;
	TGridProgressAppearance* FProgressAppearance;
	TCustomStrToDateEvent FOnCustomStrToDate;
	Classes::TNotifyEvent FOnCreatedFloatingFooter;
	Classes::TNotifyEvent FOnCreatedSearchFooter;
	TDropDownButtonClickEvent FOnDropDownHeaderButtonClick;
	TDropDownButtonClickEvent FOnDropDownFooterButtonClick;
	Advobj::TOfficeHintEvent FOnOfficeHint;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	bool FScrollLock;
	int FPaintCount;
	System::UnicodeString FEditText;
	System::WideString FEditWideText;
	bool FNoEditChange;
	bool FNoAutoAdvance;
	bool FGridModified;
	Advobj::TIntList* FIgnoreColumns;
	System::UnicodeString FXMLEncoding;
	int FFilterRow;
	bool FFilterDropDownAuto;
	bool FFilterIncremental;
	System::UnicodeString FFilterDropDownClear;
	System::TDateTime FOriginalDateTime;
	Stdctrls::TScrollBar* FScrollBar;
	Stdctrls::TScrollBar* FPaintScrollBar;
	int FScrollCol;
	int FScrollRow;
	System::UnicodeString FInvalidEntryTitle;
	System::UnicodeString FInvalidEntryText;
	TInvalidEntryIcon FInvalidEntryIcon;
	bool FBlockCellChange;
	int FLastDesignChoice;
	bool FShowDesignHelper;
	bool FIsPrintPreview;
	System::UnicodeString FValidChars;
	TCharSet FValidCharSet;
	bool FUseInternalHintClass;
	Classes::TNotifyEvent FOnStartBlockFocus;
	Classes::TNotifyEvent FOnEndBlockFocus;
	void __fastcall SetDragScrollOptions(TDragScrollOptions* Value);
	void __fastcall NCPaintProc(void);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNotify(Messages::TWMNotify &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyUp(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMTimer(Messages::TWMTimer &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &WMScroll);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TWMScroll &WMScroll);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMCursorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	int __fastcall MouseOverDesignChoice(int X, int Y);
	void __fastcall HideEditControl(int ACol, int ARow);
	void __fastcall ShowEditControl(int ACol, int ARow);
	bool __fastcall IsPassword(int ACol, int ARow);
	void __fastcall HandleRadioClick(int ACol, int ARow, int Xpos, int Ypos);
	bool __fastcall HasStaticEdit(int ACol, int ARow);
	void __fastcall TabEdit(bool Dir);
	bool __fastcall ToggleRadio(int ACol, int ARow, bool FromEdit);
	TAdvInplaceEdit* __fastcall GetInplaceEditor(void);
	void __fastcall SetAutoSizeP(bool AAutoSize);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetFlat(const bool AValue);
	void __fastcall SetShowSelection(bool AValue);
	void __fastcall SetMaxEditLength(const int AValue);
	void __fastcall SetGroupColumn(int AGroupColumn);
	void __fastcall QuickSortRows(int Col, int Left, int Right);
	void __fastcall QuickSortRowsIndexed(int Col, int Left, int Right);
	void __fastcall QuickSortRowsRef(int Col, int Left, int Right);
	void __fastcall SetVAlignment(Advobj::TVAlignment AVAlignment);
	int __fastcall BuildPages(Graphics::TCanvas* Canvas, TPrintMethod PrintMethod, int MaxPages, bool SelRows);
	int __fastcall Compare(int Col, int ARow1, int ARow2, TSortDirection sd);
	int __fastcall CompareLine(int Col, int ARow1, int ARow2);
	int __fastcall CompareLineIndexed(int Colidx, int ARow1, int ARow2);
	bool __fastcall MatchCell(int Col, int Row, bool IsWide);
	void __fastcall ShowHintProc(System::UnicodeString &HintStr, bool &CanShow, Controls::THintInfo &HintInfo);
	void __fastcall DrawSortIndicator(Graphics::TCanvas* Canvas, int Col, int x, int y);
	void __fastcall GridResize(System::TObject* Sender);
	bool __fastcall FreeCellGraphic(int ACol, int ARow);
	bool __fastcall RemoveCellGraphic(int ACol, int ARow, TCellType CellType);
	TCellGraphic* __fastcall CreateCellGraphic(int ACol, int ARow);
	Advobj::TIntList* __fastcall GetCellImages(int ACol, int ARow);
	int __fastcall GetCellImageIdx(int ACol, int ARow);
	void __fastcall SetInts(int ACol, int ARow, const int Value);
	int __fastcall GetInts(int ACol, int ARow);
	void __fastcall SetAllInts(int ACol, int ARow, const int Value);
	int __fastcall GetAllInts(int ACol, int ARow);
	void __fastcall SetFloats(int ACol, int ARow, const double Value);
	double __fastcall GetFloats(int ACol, int ARow);
	void __fastcall SetAllFloats(int ACol, int ARow, const double Value);
	double __fastcall GetAllFloats(int ACol, int ARow);
	void __fastcall SetDates(int ACol, int ARow, const System::TDateTime Value);
	System::TDateTime __fastcall GetDates(int ACol, int ARow);
	void __fastcall SetTimes(int ACol, int ARow, const System::TDateTime Value);
	System::TDateTime __fastcall GetTimes(int ACol, int ARow);
	bool __fastcall GetRowSelect(int ARow);
	void __fastcall SetRowSelect(int ARow, bool Value);
	bool __fastcall GetRowModified(int ARow);
	void __fastcall SetRowModified(int ARow, bool Value);
	bool __fastcall GetRowEnabled(int ARow);
	void __fastcall SetRowEnabled(int ARow, bool Value);
	int __fastcall GetRowSelectCount(void);
	bool __fastcall GetColSelect(int ACol);
	void __fastcall SetColSelect(int ACol, bool Value);
	int __fastcall GetColSelectCount(void);
	void __fastcall SelectToColSelect(bool IsShift);
	Types::TRect __fastcall ButtonRect(int ACol, int ARow);
	void __fastcall SetFixedFont(Graphics::TFont* Value);
	void __fastcall FixedFontChanged(System::TObject* Sender);
	void __fastcall MultiImageChanged(System::TObject* Sender, int ACol, int ARow);
	void __fastcall MergedColumnsChanged(System::TObject* Sender, int ACol, int ARow);
	void __fastcall UndoColumnMerge(void);
	void __fastcall ApplyColumnMerge(void);
	void __fastcall RichSelChange(System::TObject* Sender);
	void __fastcall SetColumnHeaders(Classes::TStringList* Value);
	void __fastcall ColHeaderChanged(System::TObject* Sender);
	void __fastcall SetRowHeaders(Classes::TStringList* Value);
	void __fastcall RowHeaderChanged(System::TObject* Sender);
	int __fastcall GetPrintColWidth(int ACol);
	int __fastcall GetPrintColOffset(int ACol);
	void __fastcall SetLookupItems(Classes::TStringList* Value);
	int __fastcall PasteFunc(int ACol, int ARow, int &Cols, int &Rows);
	void __fastcall CopyFunc(const Grids::TGridRect &gd, bool DoDisjunct);
	void __fastcall CopyRTFFunc(int ACol, int ARow);
	void __fastcall CopyBinFunc(const Grids::TGridRect &gd);
	void __fastcall SetPreviewPage(int Value);
	Graphics::TBitmap* __fastcall GetRowIndicator(void);
	void __fastcall SetRowIndicator(Graphics::TBitmap* Value);
	void __fastcall SetBackground(TBackGround* Value);
	void __fastcall RTFPaint(int ACol, int ARow, Graphics::TCanvas* Canvas, const Types::TRect &ARect);
	HIDESBASE void __fastcall DrawSizingLine(int X);
	void __fastcall DrawSizingLineR(int Y);
	int __fastcall YOffsetSize(void);
	int __fastcall XOffsetSize(void);
	void __fastcall FlatInit(void);
	void __fastcall FlatDone(void);
	void __fastcall FlatUpdate(void);
	void __fastcall FlatSetScrollProp(int index, int newValue, BOOL fRedraw);
	void __fastcall FlatSetScrollInfo(int code, tagSCROLLINFO &scrollinfo, BOOL fRedraw);
	void __fastcall FlatShowScrollBar(int code, BOOL show);
	void __fastcall UpdateVScrollBar(void);
	void __fastcall UpdateHScrollBar(void);
	void __fastcall UpdateScrollBars(bool Refresh);
	void __fastcall UpdateType(void);
	void __fastcall UpdateColor(void);
	void __fastcall UpdateWidth(void);
	void __fastcall SetScrollBarsEx(const Stdctrls::TScrollStyle Value);
	Stdctrls::TScrollStyle __fastcall GetScrollBarsEx(void);
	void __fastcall SetScrollType(const TScrollType Value);
	void __fastcall SetScrollColor(const Graphics::TColor Value);
	void __fastcall SetScrollWidth(const int Value);
	void __fastcall SetScrollProportional(bool Value);
	void __fastcall SetActiveCellShow(const bool Value);
	void __fastcall SetActiveCellFont(const Graphics::TFont* Value);
	void __fastcall SetAutoThemeAdapt(const bool Value);
	void __fastcall SetXYOffset(const Types::TPoint &Value);
	bool __fastcall GetLockFlag(void);
	void __fastcall SetLockFlag(bool AValue);
	bool __fastcall InSizeZone(int x, int y);
	int __fastcall RemapCol(int ACol);
	int __fastcall RemapColInv(int ACol);
	int __fastcall RemapRow(int ARow);
	int __fastcall RemapRowInv(int ARow);
	void __fastcall SetVisibleCol(int i, bool AValue);
	bool __fastcall GetVisibleCol(int i);
	int __fastcall MaxLinesInGrid(void);
	int __fastcall MaxLinesInRow(int ARow);
	int __fastcall MaxCharsInCol(int ACol);
	void __fastcall SizeToLines(const int ARow, const int Lines, const int Padding);
	void __fastcall SizeToWidth(const int ACol, bool inconly);
	void __fastcall SizeToHeight(const int ARow, bool inconly);
	TCellAlignment __fastcall GetCellAlignment(int ACol, int ARow);
	void __fastcall DrawIntelliFocusPoint(void);
	void __fastcall EraseIntelliFocusPoint(void);
	void __fastcall SetImages(Imglist::TCustomImageList* Value);
	void __fastcall SetURLShow(bool Value);
	void __fastcall SetURLShowInText(bool Value);
	void __fastcall SetURLColor(Graphics::TColor Value);
	void __fastcall SetURLFull(bool Value);
	void __fastcall SetLook(TGridLook Value);
	System::UnicodeString __fastcall GetLookAsString(TGridLook Value);
	System::UnicodeString __fastcall GetLookAsFriendlyString(TGridLook Value);
	void __fastcall CalcTextPos(Types::TRect &ARect, int AAngle, System::UnicodeString ATxt, Classes::TAlignment hal, Advobj::TVAlignment val);
	void __fastcall SetFixedFooters(int Value);
	void __fastcall SetFixedRightCols(int Value);
	void __fastcall SetFixedColWidth(int Value);
	void __fastcall SetRowCountEx(int Value);
	int __fastcall GetRowCountEx(void);
	void __fastcall SetColCountEx(int Value);
	int __fastcall GetColCountEx(void);
	void __fastcall SetFixedRowsEx(int Value);
	int __fastcall GetFixedRowsEx(void);
	void __fastcall SetFixedColsEx(int Value);
	int __fastcall GetFixedColsEx(void);
	void __fastcall SetHovering(bool Value);
	int __fastcall GetFixedColWidth(void);
	void __fastcall SetFixedRowHeight(int Value);
	int __fastcall GetFixedRowHeight(void);
	void __fastcall SetWordWrapEx(bool Value);
	bool __fastcall GetWordWrapEx(void);
	void __fastcall SetSelectionColor(Graphics::TColor AColor);
	void __fastcall SetSelectionColorTo(Graphics::TColor AColor);
	void __fastcall SetSelectionMirrorColor(Graphics::TColor AColor);
	void __fastcall SetSelectionMirrorColorTo(Graphics::TColor AColor);
	void __fastcall SetSelectionTextColor(Graphics::TColor AColor);
	void __fastcall SetSelectionRectangle(bool AValue);
	void __fastcall SetFilterActive(const bool Value);
	void __fastcall SetFilterRow(const int Value);
	Controls::TCursor __fastcall GetCursorEx(void);
	void __fastcall SetCursorEx(const Controls::TCursor Value);
	System::UnicodeString __fastcall GetCellsEx(int i, int j);
	void __fastcall SetCellsEx(int i, int j, System::UnicodeString Value);
	System::UnicodeString __fastcall GetGridCellsEx(int i, int j);
	void __fastcall SetGridCellsEx(int i, int j, System::UnicodeString Value);
	System::WideString __fastcall GetWideCellsEx(int i, int j);
	void __fastcall SetWideCellsEx(int i, int j, System::WideString Value);
	System::TObject* __fastcall GetObjectsEx(int i, int j);
	void __fastcall SetObjectsEx(int i, int j, System::TObject* aObject);
	int __fastcall GetAllColWidths(int i);
	void __fastcall SetAllColWidths(int i, const int Value);
	Graphics::TColor __fastcall GetColors(int i, int j);
	void __fastcall SetColors(int i, int j, Graphics::TColor AColor);
	Graphics::TColor __fastcall GetColorsTo(int i, int j);
	void __fastcall SetColorsTo(int i, int j, Graphics::TColor AColor);
	Advobj::TCellGradientDirection __fastcall GetGradientDir(int i, int j);
	void __fastcall SetGradientDir(int i, int j, Advobj::TCellGradientDirection ADirection);
	void __fastcall SetRowColor(int i, Graphics::TColor AColor);
	void __fastcall SetRowColorTo(int i, Graphics::TColor AColor);
	void __fastcall SetRowFontColor(int i, Graphics::TColor AColor);
	bool __fastcall GetReadOnly(int i, int j);
	void __fastcall SetReadOnly(int i, int j, bool AValue);
	bool __fastcall GetWordWraps(int i, int j);
	void __fastcall SetWordWraps(int i, int j, bool AValue);
	Controls::TControl* __fastcall GetCellControls(int i, int j);
	void __fastcall SetCellControls(int i, int j, Controls::TControl* AControl);
	System::UnicodeString __fastcall GetStrippedCell(int i, int j);
	Classes::TStrings* __fastcall HiddenRow(int j);
	int __fastcall PasteText(int ACol, int ARow, System::WideChar * p, int &Cols, int &Rows);
	void __fastcall InputFromCSV(System::UnicodeString FileName, bool insertmode, int MaxRows);
	void __fastcall OutputToCSV(System::UnicodeString FileName, bool appendmode, bool unicode);
	void __fastcall OutputToHTML(System::UnicodeString FileName, bool appendmode);
	void __fastcall LoadXLS(System::UnicodeString filename, System::UnicodeString sheetname);
	void __fastcall SaveXLS(System::UnicodeString filename, System::UnicodeString sheetname, bool CreateNewSheet);
	TGridDatePicker* __fastcall GetDateTimePicker(void);
	void __fastcall SetArrowColor(Graphics::TColor Value);
	Graphics::TColor __fastcall GetArrowColor(void);
	Types::TPoint __fastcall PasteSize(System::WideChar * p);
	void __fastcall MarkCells(System::UnicodeString s, System::UnicodeString tag, bool DoCase, int FromCol, int FromRow, int ToCol, int ToRow);
	void __fastcall UnMarkCells(System::UnicodeString tag, int FromCol, int FromRow, int ToCol, int ToRow);
	System::UnicodeString __fastcall GetUnSortedCell(int i, int j);
	void __fastcall SetUnSortedCell(int i, int j, const System::UnicodeString Value);
	int __fastcall GetDefRowHeightEx(void);
	void __fastcall SetDefRowHeightEx(const int Value);
	void __fastcall SetIntegralHeight(const bool Value);
	bool __fastcall GetSelectedCells(int i, int j);
	void __fastcall SetSelectedCells(int i, int j, const bool Value);
	int __fastcall GetSelectedCellsCount(void);
	Grids::TGridCoord __fastcall GetSelectedCell(int i);
	int __fastcall GetSelectedRowCount(void);
	int __fastcall GetSelectedColCount(void);
	int __fastcall GetSelectedRow(int i);
	Graphics::TColor __fastcall GetFontColors(int i, int j);
	void __fastcall SetFontColors(int i, int j, const Graphics::TColor Value);
	Classes::TAlignment __fastcall GetAlignments(int i, int j);
	void __fastcall SetAlignments(int i, int j, const Classes::TAlignment Value);
	int __fastcall GetLinesInCell(int i, int j);
	void __fastcall SetActiveCellColor(const Graphics::TColor Value);
	void __fastcall SetActiveCellColorTo(const Graphics::TColor Value);
	void __fastcall SetSelectionResizer(const bool Value);
	Graphics::TFontStyles __fastcall GetFontStyles(int i, int j);
	void __fastcall SetFontStyles(int i, int j, const Graphics::TFontStyles Value);
	System::UnicodeString __fastcall GetFontNames(int i, int j);
	int __fastcall GetFontSizes(int i, int j);
	void __fastcall SetFontNames(int i, int j, const System::UnicodeString Value);
	void __fastcall SetFontSizes(int i, int j, const int Value);
	void __fastcall SetTMSGradFrom(const Graphics::TColor Value);
	void __fastcall SetTMSGradTo(const Graphics::TColor Value);
	void __fastcall SetTMSGradMirrorFrom(const Graphics::TColor Value);
	void __fastcall SetTMSGradMirrorTo(const Graphics::TColor Value);
	void __fastcall SetUseHTMLHints(const bool Value);
	void __fastcall ControlExit(System::TObject* Sender);
	void __fastcall ControlEnter(System::UnicodeString S, System::UnicodeString CT, System::UnicodeString CID, System::UnicodeString CV, const Types::TRect &CR, int X, int RX, int Y);
	System::UnicodeString __fastcall GetCtrlVal(int ACol, int ARow, System::UnicodeString ID);
	void __fastcall SetCtrlVal(int ACol, int ARow, System::UnicodeString ID, const System::UnicodeString Value);
	int __fastcall GetAllColCount(void);
	int __fastcall GetAllRowCount(void);
	System::WideString __fastcall GetWideCells(int i, int j);
	void __fastcall SetWideCells(int i, int j, const System::WideString Value);
	void __fastcall StartFixedEdit(int x, int y);
	int __fastcall NumFixedRightVis(void);
	int __fastcall FixedColsVis(void);
	bool __fastcall HoverFixedCell(int Col, int Row);
	Graphics::TCanvas* __fastcall GetFooterCanvas(void);
	Types::TPoint __fastcall FindInternal(const Types::TPoint &StartCell, System::UnicodeString s, System::WideString sw, bool IsWide, TFindParams FindParams);
	bool __fastcall InNodeRect(int ARow, int x);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SaveToDOCInt(System::UnicodeString FileName, System::UnicodeString bookmark, bool CreateNewDocument, bool Append);
	void __fastcall SaveToASCIIInt(System::UnicodeString FileName, bool AppendFile, bool Unicode);
	void __fastcall QSortGroupInt(bool Indexed);
	void __fastcall CreateToolTip(void);
	void __fastcall AddToolTip(int IconType, System::UnicodeString Text, System::UnicodeString Title);
	void __fastcall DestroyToolTip(void);
	void __fastcall SetShowModified(const TShowModified* Value);
	void __fastcall SetShowDesignHelper(const bool Value);
	void __fastcall SetBalloonSettings(const TBalloonSettings* Value);
	void __fastcall SearchEditChange(System::TObject* Sender);
	void __fastcall SearchBackward(System::TObject* Sender);
	void __fastcall SearchForward(System::TObject* Sender);
	void __fastcall SearchExit(System::TObject* Sender);
	void __fastcall SearchHighLight(System::TObject* Sender);
	void __fastcall SetScrollBarAlways(const TScrollBarAlways Value);
	Grids::TGridRect __fastcall GetSelectionEx(void);
	void __fastcall SetSelectionEx(const Grids::TGridRect &Value);
	void __fastcall SetProgressAppearance(const TGridProgressAppearance* Value);
	System::TObject* __fastcall GetAllGraphicsObject(int i, int j);
	System::UnicodeString __fastcall GetOriginalCells(int i, int j);
	void __fastcall SetOriginalCells(int i, int j, const System::UnicodeString Value);
	void __fastcall SetFilterDropDownAuto(const bool Value);
	void __fastcall FilterDropDownChanged(System::TObject* Sender);
	void __fastcall SetHighlightColor(const Graphics::TColor Value);
	void __fastcall SetHighlightTextColor(const Graphics::TColor Value);
	
protected:
	Types::TPoint FClipTopLeft;
	TClipOperation FClipLastOp;
	THTMLHintWindow* FScrollHintWnd;
	bool FScrollHintShow;
	bool FVirtualCells;
	System::UnicodeString FCellCache;
	bool FNoRTLOrientation;
	bool FIsGrouping;
	bool FIsDBVersion;
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SubclassProc(Messages::TMessage &Msg);
	virtual void __fastcall DoCalcFooter(int ACol);
	virtual void __fastcall UpdateEditingCell(int ACol, int ARow, System::UnicodeString Value);
	virtual void __fastcall UpdateOnSelection(Grids::TGridRect &GR);
	virtual void __fastcall PasteInCell(int ACol, int ARow, System::UnicodeString Value);
	virtual System::UnicodeString __fastcall GetCurrentCell(void);
	virtual void __fastcall SetCurrentCell(const System::UnicodeString AValue);
	virtual System::UnicodeString __fastcall GetCurrentDisplCell(void);
	virtual void __fastcall SetEditCell(const System::UnicodeString AValue);
	virtual void __fastcall CellTextChange(int ACol, int ARow);
	virtual void __fastcall RestoreCache(void);
	void __fastcall ThemeAdapt(void);
	void __fastcall ControlComboSelect(System::TObject* Sender);
	virtual bool __fastcall ToggleCheck(int ACol, int ARow, bool FromEdit);
	virtual bool __fastcall ToggleRadioButton(int ACol, int ARow, bool FromEdit);
	void __fastcall AdvanceEdit(int ACol, int ARow, bool Advance, bool Show, bool Frwrd, bool Recurs, bool FromEdit);
	void __fastcall AdvanceHTMLEdit(int ACol, int ARow, System::UnicodeString CtrlID);
	TCellGraphic* __fastcall GetGraphicDetails(int ACol, int ARow, int &W, int &H, bool &DisplText, TCellHAlign &HA, TCellVAlign &VA);
	virtual System::UnicodeString __fastcall GetFormattedCell(int ACol, int ARow);
	virtual int __fastcall NodeIndent(int ARow);
	virtual bool __fastcall HasNodes(void);
	virtual void __fastcall GetDisplText(int c, int r, System::UnicodeString &Value);
	void __fastcall UpdateFooter(void);
	virtual TCellType __fastcall GetCellType(int ACol, int ARow);
	virtual TCellGraphic* __fastcall GetCellGraphic(int ACol, int ARow);
	virtual Types::TPoint __fastcall GetCellGraphicSize(int ACol, int ARow);
	virtual Types::TPoint __fastcall GetPrintGraphicSize(int ACol, int ARow, int CW, int RH, double ResFactor);
	virtual void __fastcall DrawCell(int ACol, int ARow, const Types::TRect &ARect, Grids::TGridDrawState AState);
	virtual void __fastcall DrawGridCell(Graphics::TCanvas* Canvas, int ACol, int ARow, const Types::TRect &ARect, Grids::TGridDrawState AState);
	void __fastcall DrawCheck(const Types::TRect &R, bool State, bool Enabled, TControlStyle ControlStyle);
	void __fastcall DrawWallPaperFixed(const Types::TRect &crect);
	void __fastcall DrawWallPaperTile(const Types::TRect &crect);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC System::UnicodeString __fastcall GetEditMask(int ACol, int ARow);
	virtual Grids::TInplaceEdit* __fastcall CreateEditor(void);
	virtual bool __fastcall CanEditShow(void);
	virtual void __fastcall DoGetEditorProp(int ACol, int ARow, TEditLink* EditLink);
	bool __fastcall ShouldHandleTab(void);
	DYNAMIC void __fastcall SetEditText(int ACol, int ARow, const System::UnicodeString Value);
	DYNAMIC System::UnicodeString __fastcall GetEditText(int ACol, int ARow);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall ColumnMoved(int FromIndex, int ToIndex);
	DYNAMIC void __fastcall RowMoved(int FromIndex, int ToIndex);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	virtual bool __fastcall SelectCell(int ACol, int ARow);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC void __fastcall SizeChanged(int OldColCount, int OldRowCount);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall DragTimerProc(System::TObject* Sender);
	virtual void __fastcall CalcSizingState(int X, int Y, Grids::TGridState &State, int &Index, int &SizingPos, int &SizingOfs, Grids::TGridDrawInfo &FixedInfo);
	virtual void __fastcall SelectionChanged(int ALeft, int ATop, int ARight, int ABottom);
	virtual void __fastcall EditProgress(System::UnicodeString Value, const Types::TPoint &pt, int SelPos);
	virtual void __fastcall DoInsertRow(int ARow);
	virtual void __fastcall DoDeleteRow(int ARow);
	virtual void __fastcall DoFilterDone(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall Paint(void);
	void __fastcall PaintBackground(void);
	void __fastcall SelectToRowSelect(bool IsShift);
	bool __fastcall IsScrolledToLastRow(void);
	void __fastcall ScrollToLastRow(void);
	DYNAMIC int __fastcall GetEditLimit(void);
	DYNAMIC void __fastcall ColWidthsChanged(void);
	DYNAMIC void __fastcall RowHeightsChanged(void);
	void __fastcall InvalidateGridRect(const Grids::TGridRect &r);
	DYNAMIC void __fastcall TopLeftChanged(void);
	virtual void __fastcall FloatFooterUpdate(void);
	virtual void __fastcall UpdateColSize(int ACol, int &NewWidth);
	virtual void __fastcall UpdateAutoColSize(int ACol, int &NewWidth);
	virtual void __fastcall UpdateColHeaders(void);
	virtual System::UnicodeString __fastcall EllipsClick(System::UnicodeString s);
	virtual bool __fastcall MatchFilter(int ARow);
	virtual void __fastcall PasteStart(void);
	virtual void __fastcall PasteDone(void);
	virtual void __fastcall PasteNotify(const Types::TPoint &orig, const Grids::TGridRect &gr, TClipOperation LastOp);
	virtual System::UnicodeString __fastcall CalcCell(int ACol, int ARow);
	virtual System::UnicodeString __fastcall SaveCell(int ACol, int ARow);
	virtual void __fastcall LoadCell(int ACol, int ARow, System::UnicodeString Value);
	virtual void __fastcall UpdateCell(int ACol, int ARow);
	virtual void __fastcall InitValidate(int ACol, int ARow);
	virtual void __fastcall DoCanEditCell(int ACol, int ARow, bool &CanEdit);
	virtual void __fastcall DoSearchFooterAction(System::UnicodeString AValue, int ACol, int ARow, TSearchAction ASearchAction);
	virtual void __fastcall CellsChanged(const Types::TRect &R);
	virtual void __fastcall CellsLoaded(void);
	virtual void __fastcall GetCellHint(int ACol, int ARow, System::UnicodeString &AHint, System::WideString &AWideHint);
	virtual void __fastcall GetCellColor(int ACol, int ARow, Grids::TGridDrawState AState, Graphics::TBrush* ABrush, Graphics::TFont* AFont);
	virtual void __fastcall GetCellPrintColor(int ACol, int ARow, Grids::TGridDrawState AState, Graphics::TBrush* ABrush, Graphics::TFont* AFont);
	virtual void __fastcall GetCellBorder(int ACol, int ARow, Graphics::TPen* APen, Advobj::TCellBorders &Borders);
	virtual void __fastcall GetCellPrintBorder(int ACol, int ARow, Graphics::TPen* APen, Advobj::TCellBorders &Borders);
	virtual void __fastcall GetCellAlign(int ACol, int ARow, Classes::TAlignment &HAlign, Advobj::TVAlignment &VAlign);
	virtual void __fastcall GetColFormat(int ACol, Advobj::TSortStyle &AStyle, System::UnicodeString &aPrefix, System::UnicodeString &aSuffix);
	virtual void __fastcall GetStaticCellEditor(int ACol, int ARow, Advobj::TEditorType &AEditor);
	virtual void __fastcall GetCellEditor(int ACol, int ARow, Advobj::TEditorType &AEditor);
	virtual bool __fastcall GetEditorNone(int ACol, int ARow);
	virtual void __fastcall GetCellFixed(int ACol, int ARow, bool &IsFixed);
	virtual void __fastcall GetCellReadOnly(int ACol, int ARow, bool &IsReadOnly);
	virtual void __fastcall GetCellPassword(int ACol, int ARow, bool &IsPassword);
	virtual void __fastcall GetCellWordWrap(int ACol, int ARow, bool &WordWrap);
	virtual void __fastcall GetDefaultProps(int ACol, int ARow, Graphics::TFont* AFont, Graphics::TBrush* ABrush, Graphics::TColor &AColorTo, Graphics::TColor &AMirrorColor, Graphics::TColor &AMirrorColorTo, Classes::TAlignment &HA, Advobj::TVAlignment &VA, bool &WW, Advobj::TCellGradientDirection &GD);
	virtual bool __fastcall HasCombo(int ACol, int ARow);
	virtual bool __fastcall HasSpinEdit(int ACol, int ARow);
	virtual System::UnicodeString __fastcall GetCheckTrue(int ACol, int ARow);
	virtual System::UnicodeString __fastcall GetCheckFalse(int ACol, int ARow);
	virtual bool __fastcall GetFilter(int ACol);
	virtual Grids::TGridRect __fastcall GetUsedCells(void);
	int __fastcall GetSaveStartCol(void);
	int __fastcall GetSaveStartRow(void);
	int __fastcall GetSaveEndCol(void);
	int __fastcall GetSaveEndRow(void);
	int __fastcall GetSaveRowCount(void);
	int __fastcall GetSaveColCount(void);
	virtual void __fastcall RemoveRowsInternal(int RowIndex, int RCount);
	void __fastcall StretchColumn(int ACol);
	void __fastcall PrivatePrintRect(const Grids::TGridRect &Gridrect, bool SelRows);
	void __fastcall PrivatePrintPreviewRect(Graphics::TCanvas* Canvas, const Types::TRect &Displayrect, const Grids::TGridRect &Gridrect, bool SelRows);
	void __fastcall DoneEditing(int ACol, int ARow);
	void __fastcall UpdateActiveCells(int co, int ro, int cn, int rn);
	bool __fastcall HasDataCell(int ACol, int ARow);
	virtual void __fastcall QueryAddRow(bool &AllowAdd);
	virtual void __fastcall QueryInsertRow(int ARow, bool &AllowInsert);
	virtual void __fastcall DirectWheelChange(int delta, bool &SuppressMsg);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	void __fastcall DoHeaderButtonClick(System::TObject* Sender, int ButtonIndex);
	void __fastcall DoFooterButtonClick(System::TObject* Sender, int ButtonIndex);
	void __fastcall UpdateVScroller(void);
	void __fastcall UpdateHScroller(void);
	virtual void __fastcall DoAppendRow(void);
	void __fastcall AddSummary(int ARow);
	void __fastcall IRemoveRows(int RowIndex, int RCount, bool flg);
	void __fastcall CorrectSelection(void);
	__property bool CellSelectorMode = {read=FCellSelectorMode, write=FCellSelectorMode, nodefault};
	virtual void __fastcall CellSelect(int c, int r);
	virtual void __fastcall SetCellSelectMode(const bool Value);
	void __fastcall BalloonChange(System::TObject* Sender);
	void __fastcall ModifiedChanged(System::TObject* Sender);
	void __fastcall DatePickerCloseUp(System::TObject* Sender);
	void __fastcall DatePickerDropDown(System::TObject* Sender);
	void __fastcall DateTimePickerChange(System::TObject* Sender);
	void __fastcall DatePickerChange(System::TObject* Sender);
	void __fastcall SearchChanged(System::TObject* Sender);
	virtual void __fastcall UpdateSelectionRect(Grids::TGridRect &GR);
	virtual void __fastcall OnMouseActionsChanged(System::TObject* Sender);
	virtual void __fastcall OnMouseActionsIsDesigning(System::TObject* Sender, bool &IsDesigning);
	virtual void __fastcall OnMouseActionsInvalidate(System::TObject* Sender);
	virtual void __fastcall OnMouseActionsDisableEdit(System::TObject* Sender);
	virtual void __fastcall EditKeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Edit_WMKeyDown(Messages::TWMKey &Msg);
	virtual void __fastcall OnNavigationChanged(System::TObject* Sender);
	void __fastcall DrawRadio(Graphics::TCanvas* Canvas, const Types::TRect &R, int Num, int Idx, bool dir, bool dis, Classes::TStrings* sl, bool Selected, int ACol, int ARow, TControlStyle Style, double ResFactor, bool Print = false);
	Forms::TCustomForm* __fastcall GetParentForm(Controls::TControl* Control);
	void __fastcall ExpandNodeInt(int ARow);
	virtual void __fastcall TabToNextRowAtEnd(void);
	void __fastcall SetComment(int ACol, int ARow, System::UnicodeString value);
	System::UnicodeString __fastcall GetComment(int ACol, int ARow);
	virtual bool __fastcall DoAllowFmtPaste(void);
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	__property TDropList* DropList = {read=FDropList};
	__property int FilterColumn = {read=FFilterCol, write=FFilterCol, nodefault};
	virtual void __fastcall FilterSelect(System::TObject* Sender, int ItemIndex);
	tagSIZE __fastcall GetCellTextSizeInt(int ACol, int RCol, int ARow, bool VS = false, bool SB = false);
	virtual void __fastcall PaintDesigner(void);
	virtual void __fastcall HandleDesignChoice(int X, int Y);
	bool __fastcall IsOnLastRow(void);
	void __fastcall AppendLastRow(void);
	virtual bool __fastcall HasCustomCellBorder(void);
	bool __fastcall SetCheckBoxStateInt(int ACol, int ARow, bool state);
	void __fastcall SetEditorsStyle(Advstyleif::TTMSStyle AStyle);
	virtual void __fastcall DoCheckBoxChange(int ACol, int ARow, bool State);
	virtual bool __fastcall DoRatingChange(int ACol, int ARow, double &NewRate);
	virtual void __fastcall DoColorSelect(System::TObject* Sender);
	virtual void __fastcall DoImageSelect(System::TObject* Sender);
	virtual void __fastcall DoCellChanging(int ACol, int ARow, bool &CanChange);
	void __fastcall InsertRowsEx(int RowIndex, int RCount, bool UpdateCellControls = true);
	virtual bool __fastcall CanShowFixedDropDown(int ACol);
	virtual void __fastcall DoStartBlockFocus(void);
	virtual void __fastcall DoEndBlockFocus(void);
	__property Classes::TNotifyEvent OnStartBlockFocus = {read=FOnStartBlockFocus, write=FOnStartBlockFocus};
	__property Classes::TNotifyEvent OnEndBlockFocus = {read=FOnEndBlockFocus, write=FOnEndBlockFocus};
	
public:
	bool LButFlg;
	int Compares;
	int Swaps;
	unsigned SortTime;
	Classes::TStringList* Sortlist;
	int PrevSizeX;
	int PrevSizeY;
	bool EditMode;
	__property bool IsThemed = {read=FIsComCtl6, nodefault};
	__property bool IsPrintPreview = {read=FIsPrintPreview, write=FIsPrintPreview, nodefault};
	tagSIZE __fastcall GetCellTextSize(int ACol, int ARow, bool VS = false, bool SB = false);
	virtual void __fastcall ExportNotification(TGridExportState AState, int ARow);
	virtual void __fastcall ImportNotification(TGridImportState AState, int ARow);
	void __fastcall CellControlsUpdate(void);
	void __fastcall RegisterNotifier(TGridChangeNotifier* ANotifier);
	void __fastcall UnRegisterNotifier(TGridChangeNotifier* ANotifier);
	void __fastcall ClearComboString(void);
	void __fastcall AddComboString(const System::UnicodeString s);
	void __fastcall AddComboStringObject(const System::UnicodeString s, System::TObject* AObject);
	bool __fastcall RemoveComboString(const System::UnicodeString s);
	bool __fastcall SetComboSelectionString(const System::UnicodeString s);
	void __fastcall SetComboSelection(int idx);
	int __fastcall GetComboCount(void);
	__fastcall virtual TAdvStringGrid(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvStringGrid(void);
	virtual void __fastcall Invalidate(void);
	virtual void __fastcall AssignCells(Classes::TPersistent* Source);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall GetFontProperties(int ACol, int RCol, int ARow, Grids::TGridDrawState &AState, Graphics::TFont* AFont, Graphics::TBrush* ABrush, bool Remap);
	virtual void __fastcall GetVisualProperties(int ACol, int ARow, Grids::TGridDrawState &AState, bool Print, bool Select, bool Remap, Graphics::TBrush* ABrush, Graphics::TColor &AColorTo, Graphics::TColor &AMirrorColor, Graphics::TColor &AMirrorColorTo, Graphics::TFont* AFont, Classes::TAlignment &HA, Advobj::TVAlignment &VA, bool &WW, Advobj::TCellGradientDirection &GD);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual int __fastcall GetVersionNr(void);
	virtual System::UnicodeString __fastcall GetVersionString(void);
	__property int ZoomFactor = {read=FZoomFactor, write=FZoomFactor, nodefault};
	virtual bool __fastcall ValidateCell(const System::UnicodeString NewValue);
	virtual bool __fastcall ValidateCellWide(const System::WideString NewValue);
	void __fastcall BalloonInit(void);
	void __fastcall BalloonDone(void);
	void __fastcall ApplyFilter(void);
	bool __fastcall RemoveLastFilter(void);
	void __fastcall RemoveAllFilters(void);
	void __fastcall NarrowDown(System::UnicodeString ACondition, int AColumn = 0xffffffff);
	void __fastcall InitOrigColSizes(void);
	Forms::TForm* __fastcall SelectionToForm(const Grids::TGridRect &ARect);
	void __fastcall RemoveCheckedRows(int CheckBoxColumn, bool RemoveChecked = true);
	virtual void __fastcall RemoveRowsEx(int RowIndex, int RCount);
	virtual void __fastcall RemoveRows(int RowIndex, int RCount);
	virtual void __fastcall InsertRows(int RowIndex, int RCount, bool UpdateCellControls = true);
	virtual void __fastcall RemoveCols(int ColIndex, int CCount);
	virtual void __fastcall InsertCols(int ColIndex, int CCount);
	void __fastcall AddColumn(void);
	void __fastcall AddRow(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall FilterRow(int ARow);
	int __fastcall GetParentRow(int ARow);
	void __fastcall InsertChildRow(int ARow, int InsertAt = 0x1);
	void __fastcall RemoveChildRow(int ARow);
	void __fastcall InsertNormalRow(int ARow);
	void __fastcall RemoveNormalRow(int ARow);
	void __fastcall RemoveSelectedCols(void);
	void __fastcall RemoveUnSelectedCols(void);
	void __fastcall RemoveSelectedRows(void);
	void __fastcall RemoveUnSelectedRows(void);
	void __fastcall RemoveDuplicates(int ACol, bool DoCase);
	void __fastcall MergeCols(int ColIndex1, int ColIndex2, System::UnicodeString Separator = L" ");
	void __fastcall MergeColumnCells(int ColIndex, bool MainMerge);
	void __fastcall SplitColumnCells(int ColIndex);
	void __fastcall MergeRowCells(int RowIndex, bool MainMerge);
	void __fastcall SplitRowCells(int RowIndex);
	void __fastcall SplitAllCells(void);
	bool __fastcall IsSummary(int ARow);
	virtual bool __fastcall IsFixed(int ACol, int ARow);
	bool __fastcall IsEditable(int ACol, int ARow);
	void __fastcall SwapColumns(int ACol1, int ACol2);
	void __fastcall HideColumn(int ColIndex);
	void __fastcall UnHideColumn(int ColIndex);
	void __fastcall HideColumns(int FromCol, int ToCol);
	void __fastcall UnHideColumns(int FromCol, int ToCol);
	void __fastcall UnHideColumnsAll(void);
	bool __fastcall IsHiddenColumn(int Colindex);
	int __fastcall NumHiddenColumns(void);
	int __fastcall TotalColCount(void);
	void __fastcall RepaintRect(const Types::TRect &r);
	HIDESBASE void __fastcall RepaintCell(int c, int r);
	void __fastcall RepaintRow(int ARow);
	void __fastcall RepaintCol(int ACol);
	void __fastcall GroupCalc(int Colindex, int method);
	void __fastcall GroupSum(int Colindex);
	void __fastcall GroupAvg(int Colindex);
	void __fastcall GroupMin(int Colindex);
	void __fastcall GroupMax(int Colindex);
	void __fastcall GroupCustomCalc(int Colindex);
	void __fastcall GroupCount(int ColIndex);
	virtual void __fastcall SubGroup(int Colindex);
	virtual void __fastcall SubUnGroup(int Colindex);
	virtual void __fastcall Group(int Colindex);
	virtual void __fastcall UnGroup(void);
	void __fastcall HideRow(int Rowindex);
	void __fastcall HideRows(int FromRow, int ToRow);
	void __fastcall HideRowList(Advobj::TIntList* RowList);
	void __fastcall HideRowsEx(int FromRow, int ToRow);
	void __fastcall UnHideRow(int Rowindex);
	void __fastcall UnHideRows(int FromRow, int ToRow);
	void __fastcall UnHideRowList(void);
	void __fastcall UnHideRowsAll(void);
	void __fastcall HideSelectedRows(void);
	void __fastcall HideUnSelectedRows(void);
	bool __fastcall IsHiddenRow(int Rowindex)/* overload */;
	bool __fastcall IsHiddenRow(int Rowindex, Advobj::TIntList* &ListHidden)/* overload */;
	int __fastcall NumHiddenRows(void);
	int __fastcall TotalRowCount(void);
	int __fastcall RealRowIndex(int ARow);
	int __fastcall RealColIndex(int ACol);
	int __fastcall DisplRowIndex(int ARow);
	virtual int __fastcall DisplColIndex(int ACol);
	bool __fastcall IsIgnoredColumn(int ACol);
	void __fastcall SetColumnOrder(void);
	void __fastcall ResetColumnOrder(void);
	int __fastcall ColumnPosition(int ACol);
	int __fastcall ColumnAtPosition(int ACol);
	int __fastcall ColumnByHeader(System::UnicodeString AValue);
	int __fastcall UnSortedRowIndex(int ARow);
	int __fastcall SortedRowIndex(int ARow);
	int __fastcall GetRealCol(void);
	int __fastcall GetRealRow(void);
	int __fastcall GetRowEx(void);
	void __fastcall SetRowEx(const int Value);
	int __fastcall GetTopRowEx(void);
	void __fastcall SetTopRowEx(const int Value);
	void __fastcall ScreenToCell(const Types::TPoint &pt, int &ACol, int &ARow);
	void __fastcall HideSelection(void);
	void __fastcall UnHideSelection(void);
	void __fastcall UpdateEditMode(void);
	void __fastcall ScrollInView(int ColIndex, int RowIndex);
	HIDESBASE void __fastcall MoveRow(int FromIndex, int ToIndex);
	HIDESBASE void __fastcall MoveColumn(int FromIndex, int ToIndex);
	void __fastcall SwapRows(int ARow1, int ARow2);
	virtual void __fastcall SortSwapRows(int ARow1, int ARow2);
	virtual void __fastcall ClearRect(int ACol1, int ARow1, int ACol2, int ARow2);
	void __fastcall Clear(void);
	void __fastcall ClearAll(void);
	void __fastcall ClearRows(int RowIndex, int RCount);
	void __fastcall ClearCols(int ColIndex, int CCount);
	void __fastcall ClearNormalRows(int RowIndex, int RCount);
	void __fastcall ClearNormalCols(int ColIndex, int CCount);
	void __fastcall ClearNormalCells(void);
	void __fastcall ClearSelection(void);
	void __fastcall ClearRowSelect(void);
	void __fastcall ClearColSelect(void);
	HIDESBASE void __fastcall FocusCell(int Col, int Row);
	void __fastcall GotoCell(int Col, int Row);
	void __fastcall SwapCells(const Grids::TGridCoord &FromCell, const Grids::TGridCoord &ToCell);
	void __fastcall SelectRows(int RowIndex, int RCount);
	void __fastcall UnSelectRows(int RowIndex, int RCount);
	void __fastcall SelectCols(int ColIndex, int CCount);
	void __fastcall UnSelectCols(int ColIndex, int CCount);
	void __fastcall SelectRange(int FromCol, int ToCol, int FromRow, int ToRow);
	void __fastcall ClearSelectedCells(void);
	void __fastcall ClearModifiedRows(void);
	int __fastcall ModifiedRowCount(void);
	bool __fastcall IsCell(System::UnicodeString SubStr, int &ACol, int &ARow);
	bool __fastcall IsWideCell(int ACol, int ARow);
	void __fastcall SaveToFile(System::UnicodeString FileName, bool Unicode = true);
	void __fastcall SaveToCSV(System::UnicodeString FileName, bool Unicode = true);
	void __fastcall AppendToCSV(System::UnicodeString FileName, bool Unicode = true);
	void __fastcall AppendToASCII(System::UnicodeString FileName, bool Unicode = true);
	void __fastcall SaveToASCII(System::UnicodeString FileName, bool Unicode = true);
	void __fastcall SaveToBinFile(System::UnicodeString FileName);
	void __fastcall SaveToBinStream(Classes::TStream* Stream);
	void __fastcall SaveRectToBinStream(const Types::TRect &Rect, Classes::TStream* Stream);
	void __fastcall SaveToHTML(System::UnicodeString FileName, bool Show = false);
	System::UnicodeString __fastcall SaveToHTMLString(System::UnicodeString dir);
	void __fastcall AppendToHTML(System::UnicodeString FileName);
	void __fastcall SaveToXML(System::UnicodeString FileName, System::UnicodeString ListDescr, System::UnicodeString RecordDescr, Classes::TStrings* FieldDescr, bool ExportEmptyCells = false);
	void __fastcall LoadFromXML(System::UnicodeString FileName, bool LevelToRow = false, bool LoadFieldDescr = true);
	void __fastcall SaveToFixed(System::UnicodeString FileName, Advobj::TIntList* positions);
	void __fastcall SaveToStream(Classes::TStream* Stream);
	void __fastcall LoadFromFile(System::UnicodeString FileName);
	void __fastcall LoadFromBinFile(System::UnicodeString FileName);
	void __fastcall LoadFromBinStream(Classes::TStream* Stream);
	void __fastcall LoadAtPointFromBinStream(const Types::TPoint &Point, Classes::TStream* Stream);
	void __fastcall LoadFromCSV(System::UnicodeString FileName, int MaxRows = 0xffffffff);
	void __fastcall LoadFromFixed(System::UnicodeString FileName, Advobj::TIntList* positions, bool DoTrim = true, int MaxRows = 0xffffffff);
	void __fastcall InsertFromCSV(System::UnicodeString FileName, int MaxRows = 0xffffffff);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	void __fastcall SaveColSizes(void);
	void __fastcall LoadColSizes(void);
	virtual void __fastcall SaveColPositions(void);
	virtual void __fastcall LoadColPositions(void);
	System::UnicodeString __fastcall ColumnStatesToString(void);
	void __fastcall StringToColumnStates(System::UnicodeString Value);
	void __fastcall LoadVisualProps(System::UnicodeString FileName);
	void __fastcall SaveVisualProps(System::UnicodeString FileName);
	void __fastcall SavePrintSettings(System::UnicodeString Key, System::UnicodeString Section);
	void __fastcall LoadPrintSettings(System::UnicodeString Key, System::UnicodeString Section);
	void __fastcall CutToClipboard(void);
	void __fastcall CutSelectionToClipboard(void);
	void __fastcall CopyToClipBoard(void);
	void __fastcall CopyToClipBoardAsHTML(void);
	void __fastcall CopySelectionToClipboard(void);
	void __fastcall PasteFromClipboard(void);
	void __fastcall PasteSelectionFromClipboard(void);
	void __fastcall ShowColumnHeaders(void);
	void __fastcall ClearColumnHeaders(void);
	void __fastcall ShowRowHeaders(void);
	void __fastcall ClearRowHeaders(void);
	void __fastcall HideCellEdit(void);
	void __fastcall ShowCellEdit(void);
	void __fastcall UpdateXYOffset(int X, int Y);
	void __fastcall Select(void);
	void __fastcall SetTheme(TXPColorScheme Scheme);
	void __fastcall SetStyle(TAdvGridStyle AStyle);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall RandomFill(bool DoFixed = false, int Rnd = 0x64);
	void __fastcall LinearFill(bool DoFixed = false);
	void __fastcall TextFill(bool DoFixed, System::UnicodeString Txt);
	void __fastcall FormatFill(bool DoFixed, System::UnicodeString Fmt);
	System::UnicodeString __fastcall HilightText(bool DoCase, System::UnicodeString S, System::UnicodeString Text);
	System::UnicodeString __fastcall UnHilightText(System::UnicodeString S);
	void __fastcall HilightInCell(bool DoCase, int Col, int Row, System::UnicodeString HiText);
	void __fastcall HilightInCol(bool DoFixed, bool DoCase, int Col, System::UnicodeString HiText);
	void __fastcall HilightInRow(bool DoFixed, bool DoCase, int Row, System::UnicodeString HiText);
	void __fastcall HilightInGrid(bool DoFixed, bool DoCase, System::UnicodeString HiText);
	void __fastcall UnHilightInCell(int Col, int Row);
	void __fastcall UnHilightInCol(bool DoFixed, int Col);
	void __fastcall UnHilightInRow(bool DoFixed, int Row);
	void __fastcall UnHilightInGrid(bool DoFixed);
	System::UnicodeString __fastcall MarkText(bool DoCase, System::UnicodeString S, System::UnicodeString Text);
	System::UnicodeString __fastcall UnMarkText(System::UnicodeString S);
	void __fastcall MarkInCell(bool DoCase, int Col, int Row, System::UnicodeString HiText);
	void __fastcall MarkInCol(bool DoFixed, bool DoCase, int Col, System::UnicodeString HiText);
	void __fastcall MarkInRow(bool DoFixed, bool DoCase, int Row, System::UnicodeString HiText);
	void __fastcall MarkInGrid(bool DoFixed, bool DoCase, System::UnicodeString HiText);
	void __fastcall UnMarkInCell(int Col, int Row);
	void __fastcall UnMarkInCol(bool DoFixed, int Col);
	void __fastcall UnMarkInRow(bool DoFixed, int Row);
	void __fastcall UnMarkInGrid(bool DoFixed);
	bool __fastcall CheckCells(int FromCol, int FromRow, int ToCol, int ToRow);
	bool __fastcall CheckCell(int Col, int Row);
	bool __fastcall CheckGrid(bool DoFixed);
	bool __fastcall CheckCol(bool DoFixed, int Col);
	bool __fastcall CheckRow(bool DoFixed, int Row);
	void __fastcall Zoom(int x);
	void __fastcall SaveToXLS(System::UnicodeString Filename, bool CreateNewSheet = true);
	void __fastcall SaveToXLSSheet(System::UnicodeString Filename, System::UnicodeString SheetName);
	Classes::TStringList* __fastcall GetXLSSheets(System::UnicodeString FileName);
	void __fastcall LoadFromXLS(System::UnicodeString Filename);
	void __fastcall LoadFromXLSSheet(System::UnicodeString Filename, System::UnicodeString SheetName);
	void __fastcall LoadFromMDBTable(System::UnicodeString Filename, System::UnicodeString Table);
	void __fastcall LoadFromMDBSQL(System::UnicodeString Filename, System::UnicodeString SQL);
	void __fastcall AppendToDoc(System::UnicodeString Filename, System::UnicodeString Bookmark);
	void __fastcall SaveToDOC(System::UnicodeString Filename, bool CreateNewDocument = true);
	void __fastcall RichToCell(int Col, int Row, Comctrls::TRichEdit* Richeditor);
	System::UnicodeString __fastcall RichToString(Comctrls::TRichEdit* Richeditor);
	void __fastcall CellToRich(int Col, int Row, Comctrls::TRichEdit* Richeditor);
	double __fastcall CellToReal(int ACol, int ARow);
	void __fastcall AutoFitColumns(const bool DoFixedCells = true);
	void __fastcall AutoSizeCells(const bool DoFixedCells, const int PaddingX, const int PaddingY);
	void __fastcall AutoSizeColumns(const bool DoFixedCols, const int Padding = 0x4);
	void __fastcall AutoSizeCol(const int ACol, const int Padding = 0x0);
	void __fastcall AutoSizeRows(const bool DoFixedRows, const int Padding = 0x0);
	void __fastcall AutoSizeRow(const int ARow, const int Padding = 0x0);
	void __fastcall StretchRightColumn(void);
	void __fastcall SizeToCols(void);
	void __fastcall SizeToRows(void);
	void __fastcall SizeToCells(void);
	void __fastcall AutoNumberCol(const int ACol);
	void __fastcall AutoNumberRow(const int ARow);
	HIDESBASE bool __fastcall IsSelected(int ACol, int ARow);
	System::UnicodeString __fastcall SelectedText(void);
	void __fastcall SelectCells(int FromCol, int FromRow, int ToCol, int ToRow);
	void __fastcall ShowInplaceEdit(void);
	void __fastcall HideInplaceEdit(void);
	void __fastcall DoneInplaceEdit(System::Word Key, Classes::TShiftState Shift);
	virtual void __fastcall QSort(void);
	virtual void __fastcall QSortIndexed(void);
	virtual void __fastcall QSortGroup(void);
	virtual void __fastcall QSortGroupIndexed(void);
	virtual void __fastcall QUnSort(void);
	void __fastcall Sort(int Column, TSortDirection Direction = (TSortDirection)(0x0));
	void __fastcall InitSortXRef(void);
	void __fastcall Print(void);
	void __fastcall PrintRect(const Grids::TGridRect &Gridrect);
	void __fastcall PrintSelection(void);
	void __fastcall PrintSelectedRows(void);
	void __fastcall PrintSelectedCols(void);
	void __fastcall PrintPreview(Graphics::TCanvas* Canvas, const Types::TRect &Displayrect);
	void __fastcall PrintPreviewRect(Graphics::TCanvas* Canvas, const Types::TRect &Displayrect, const Grids::TGridRect &Gridrect);
	void __fastcall PrintPreviewSelectedRows(Graphics::TCanvas* Canvas, const Types::TRect &Displayrect);
	void __fastcall PrintPreviewSelectedCols(Graphics::TCanvas* Canvas, const Types::TRect &Displayrect);
	void __fastcall PrintPreviewSelection(Graphics::TCanvas* Canvas, const Types::TRect &Displayrect);
	void __fastcall PrintDraw(Graphics::TCanvas* Canvas, const Types::TRect &DrawRect);
	void __fastcall PrintDrawRect(Graphics::TCanvas* Canvas, const Types::TRect &DrawRect, const Grids::TGridRect &Gridrect);
	void __fastcall SortByColumn(int Col);
	void __fastcall QuickSort(int Col, int Left, int Right);
	void __fastcall QuickSortIndexed(int Left, int Right);
	bool __fastcall SortLine(int Col, int ARow1, int ARow2);
	int __fastcall Search(System::UnicodeString s);
	Types::TPoint __fastcall Find(const Types::TPoint &StartCell, System::UnicodeString s, TFindParams FindParams);
	Types::TPoint __fastcall FindWide(const Types::TPoint &StartCell, System::WideString s, TFindParams FindParams);
	Types::TPoint __fastcall FindFirst(System::UnicodeString s, TFindParams FindParams);
	Types::TPoint __fastcall FindNext(void);
	int __fastcall Replace(System::UnicodeString OrigStr, System::UnicodeString NewStr, TFindParams FindParams);
	int __fastcall MapFontHeight(int pointsize);
	int __fastcall MapFontSize(int Height);
	void __fastcall AddInterfacedCell(int ACol, int ARow, Classes::TInterfacedPersistent* AObject);
	void __fastcall RemoveInterfacedCell(int ACol, int ARow);
	Classes::TInterfacedPersistent* __fastcall GetInterfacedCell(int ACol, int ARow);
	Graphics::TBitmap* __fastcall CreateBitmap(int ACol, int ARow, bool transparent, TCellHAlign hal, TCellVAlign val);
	void __fastcall AddBitmap(int ACol, int ARow, Graphics::TBitmap* ABmp, bool Transparent, TCellHAlign hal, TCellVAlign val);
	void __fastcall RemoveBitmap(int ACol, int ARow);
	Graphics::TBitmap* __fastcall GetBitmap(int ACol, int ARow);
	Graphics::TPicture* __fastcall CreatePicture(int ACol, int ARow, bool transparent, TStretchMode stretchmode, int padding, TCellHAlign hal, TCellVAlign val);
	void __fastcall AddPicture(int ACol, int ARow, Graphics::TPicture* APicture, bool transparent, TStretchMode stretchmode, int padding, TCellHAlign hal, TCellVAlign val);
	void __fastcall RemovePicture(int ACol, int ARow);
	Graphics::TPicture* __fastcall GetPicture(int ACol, int ARow);
	Advobj::TFilePicture* __fastcall CreateFilePicture(int ACol, int ARow, bool Transparent, TStretchMode StretchMode, int padding, TCellHAlign hal, TCellVAlign val);
	void __fastcall AddFilePicture(int ACol, int ARow, Advobj::TFilePicture* AFilePicture, bool Transparent, TStretchMode stretchmode, int padding, TCellHAlign hal, TCellVAlign val);
	void __fastcall RemoveFilePicture(int ACol, int ARow);
	Advobj::TFilePicture* __fastcall GetFilePicture(int ACol, int ARow);
	void __fastcall AddNode(int ARow, int Span);
	void __fastcall RemoveNode(int ARow);
	void __fastcall RemoveAllNodes(void);
	bool __fastcall IsNode(int ARow);
	int __fastcall GetNodeSpanType(int ARow);
	bool __fastcall GetNodeState(int ARow);
	int __fastcall GetNodeLevel(int ARow);
	void __fastcall SetNodeState(int ARow, bool Value);
	int __fastcall GetNodeSpan(int ARow);
	void __fastcall SetNodeSpan(int ARow, int Span);
	int __fastcall GetSubNodeCount(int ARow);
	void __fastcall UpdateNodeSpan(int ARow, int Delta);
	void __fastcall UpdateSubNodeCount(int ARow, int Delta);
	void __fastcall ExpandNode(int ARow);
	void __fastcall ContractNode(int ARow);
	void __fastcall ExpandAll(void);
	void __fastcall ContractAll(void);
	void __fastcall AddRadio(int ACol, int ARow, int DirRadio, int IdxRadio, Classes::TStrings* sl);
	Classes::TStrings* __fastcall CreateRadio(int ACol, int ARow, int DirRadio, int IdxRadio);
	void __fastcall RemoveRadio(int ACol, int ARow);
	bool __fastcall IsRadio(int ACol, int ARow);
	bool __fastcall GetRadioIdx(int ACol, int ARow, int &IdxRadio);
	bool __fastcall SetRadioIdx(int ACol, int ARow, int IdxRadio);
	Classes::TStrings* __fastcall GetRadioStrings(int ACol, int ARow);
	void __fastcall AddImageIdx(int ACol, int ARow, int Aidx, TCellHAlign hal, TCellVAlign val);
	void __fastcall RemoveImageIdx(int ACol, int ARow);
	bool __fastcall GetImageIdx(int ACol, int ARow, int &idx);
	void __fastcall SetImageIdx(int ACol, int ARow, int Idx);
	void __fastcall AddMultiImage(int ACol, int ARow, int Dir, TCellHAlign hal, TCellVAlign val);
	void __fastcall RemoveMultiImage(int ACol, int ARow);
	void __fastcall AddDataImage(int ACol, int ARow, int Aidx, TCellHAlign hal, TCellVAlign val);
	void __fastcall RemoveDataImage(int ACol, int ARow);
	bool __fastcall HasDataImage(int ACol, int ARow);
	void __fastcall AddRotated(int ACol, int ARow, short AAngle, System::UnicodeString s);
	void __fastcall SetRotated(int ACol, int ARow, short AAngle);
	void __fastcall RemoveRotated(int ACol, int ARow);
	bool __fastcall IsRotated(int ACol, int ARow, int &aAngle);
	Graphics::TIcon* __fastcall CreateIcon(int ACol, int ARow, TCellHAlign hal, TCellVAlign val);
	void __fastcall AddIcon(int ACol, int ARow, Graphics::TIcon* AIcon, TCellHAlign hal, TCellVAlign val);
	void __fastcall RemoveIcon(int ACol, int ARow);
	void __fastcall AddButton(int ACol, int ARow, int bw, int bh, System::UnicodeString Caption, TCellHAlign hal, TCellVAlign val);
	void __fastcall SetButtonText(int ACol, int ARow, System::UnicodeString Caption);
	System::UnicodeString __fastcall GetButtonText(int ACol, int ARow);
	void __fastcall PushButton(int ACol, int ARow, bool push);
	void __fastcall RemoveButton(int ACol, int ARow);
	void __fastcall RemoveAllButtons(void);
	bool __fastcall HasButton(int ACol, int ARow);
	void __fastcall AddBitButton(int ACol, int ARow, int bw, int bh, System::UnicodeString Caption, Graphics::TBitmap* Glyph, TCellHAlign hal, TCellVAlign val);
	Graphics::TBitmap* __fastcall CreateBitButton(int ACol, int ARow, int bw, int bh, System::UnicodeString Caption, TCellHAlign hal, TCellVAlign val);
	void __fastcall AddCheckBox(int ACol, int ARow, bool State, bool Data);
	void __fastcall RemoveCheckBox(int ACol, int ARow);
	bool __fastcall HasCheckBox(int ACol, int ARow);
	bool __fastcall IsInCheckBox(int ACol, int ARow, int XPos, int YPos);
	void __fastcall AddCheckBoxColumn(int ACol, bool DefaultState = false, bool DataCheckBox = false);
	void __fastcall RemoveCheckBoxColumn(int ACol);
	bool __fastcall HasDataCheckBox(int ACol, int ARow);
	bool __fastcall GetCheckBoxState(int ACol, int ARow, bool &state);
	bool __fastcall IsChecked(int ACol, int ARow);
	bool __fastcall SetCheckBoxState(int ACol, int ARow, bool state);
	bool __fastcall ToggleCheckBox(int ACol, int ARow);
	void __fastcall CheckAll(int ACol);
	void __fastcall UnCheckAll(int ACol);
	void __fastcall AddRadioButton(int ACol, int ARow, bool State = false);
	void __fastcall RemoveRadioButton(int ACol, int ARow);
	bool __fastcall HasRadioButton(int ACol, int ARow);
	bool __fastcall IsRadioButtonChecked(int ACol, int ARow);
	bool __fastcall SetRadioButtonState(int ACol, int ARow, bool State);
	void __fastcall AddRadioButtonColumn(int ACol);
	void __fastcall RemoveRadioButtonColumn(int ACol);
	void __fastcall SetRadioButtonColumnIndex(int ACol, int Index);
	int __fastcall GetRadioButtonColumnIndex(int ACol);
	void __fastcall AddProgress(int ACol, int ARow, Graphics::TColor FGColor, Graphics::TColor BKColor);
	void __fastcall AddProgressEx(int ACol, int ARow, Graphics::TColor FGColor, Graphics::TColor FGTextColor, Graphics::TColor BKColor, Graphics::TColor BKTextColor);
	void __fastcall AddProgressFormatted(int ACol, int ARow, Graphics::TColor FGColor, Graphics::TColor FGTextColor, Graphics::TColor BKColor, Graphics::TColor BKTextColor, System::UnicodeString Fmt, int Min, int Max);
	void __fastcall RemoveProgress(int ACol, int ARow);
	void __fastcall AddAdvProgress(int ACol, int ARow, int Min = 0x0, int Max = 0x64);
	void __fastcall RemoveAdvProgress(int ACol, int ARow);
	void __fastcall AddProgressPie(int ACol, int ARow, Graphics::TColor Color, int Value);
	void __fastcall SetProgressPie(int ACol, int ARow, int Value);
	void __fastcall RemoveProgressPie(int ACol, int ARow);
	void __fastcall AddRangeIndicator(int ACol, int ARow, int Range = 0x64, Graphics::TColor NegColor = (Graphics::TColor)(0xff), Graphics::TColor PosColor = (Graphics::TColor)(0x0), bool ShowValue = false);
	void __fastcall RemoveRangeIndicator(int ACol, int ARow);
	void __fastcall AddBalloon(int ACol, int ARow, System::UnicodeString Title, System::UnicodeString Text, TBalloonIcon Icon);
	void __fastcall RemoveBalloon(int ACol, int ARow);
	bool __fastcall HasBalloon(int ACol, int ARow);
	bool __fastcall IsBalloon(int ACol, int ARow, System::UnicodeString &Title, System::UnicodeString &Text, TBalloonIcon &Icon);
	void __fastcall AddComment(int ACol, int ARow, System::UnicodeString Comment);
	void __fastcall AddColorComment(int ACol, int ARow, System::UnicodeString Comment, Graphics::TColor Color);
	void __fastcall RemoveComment(int ACol, int ARow);
	void __fastcall RemoveAllComments(void);
	void __fastcall AddMarker(int ACol, int ARow, int ErrPos, int ErrLen);
	void __fastcall RemoveMarker(int ACol, int ARow);
	void __fastcall RemoveAllMarkers(void);
	void __fastcall GetMarker(int ACol, int ARow, int &ErrPos, int &ErrLen);
	bool __fastcall IsComment(int ACol, int ARow, System::UnicodeString &comment);
	__property System::UnicodeString CellComment[int ACol][int ARow] = {read=GetComment, write=SetComment};
	void __fastcall AddScrollBar(int ACol, int ARow, bool AutoRange = false);
	void __fastcall RemoveScrollBar(int ACol, int ARow);
	bool __fastcall HasScrollBar(int ACol, int ARow);
	bool __fastcall HasAutoRangeScrollBar(int ACol, int ARow);
	void __fastcall AddShape(int ACol, int ARow, Advutil::TCellShape Shape, Graphics::TColor FillColor, Graphics::TColor LineColor, TCellHAlign hal, TCellVAlign val);
	void __fastcall RemoveShape(int ACol, int ARow);
	void __fastcall SetShapeColor(int ACol, int ARow, Graphics::TColor FillColor);
	Graphics::TColor __fastcall GetShapeColor(int ACol, int ARow);
	void __fastcall AddRating(int ACol, int ARow, int Scale, Graphics::TColor FillColor, Graphics::TColor EmptyColor);
	void __fastcall RemoveRating(int ACol, int ARow);
	bool __fastcall HasRating(int ACol, int ARow);
	int __fastcall GetScrollPosition(int ACol, int ARow);
	void __fastcall SetScrollPosition(int ACol, int ARow, int Pos);
	TScrollProp __fastcall GetScrollProp(int ACol, int ARow);
	void __fastcall SetScrollProp(int ACol, int ARow, const TScrollProp &Prop);
	double __fastcall ColumnSum(int ACol, int fromRow, int toRow);
	double __fastcall ColumnAvg(int ACol, int fromRow, int toRow);
	double __fastcall ColumnMin(int ACol, int fromRow, int toRow);
	double __fastcall ColumnMax(int ACol, int fromRow, int toRow);
	double __fastcall ColumnCustomCalc(int ACol, int fromRow, int toRow);
	double __fastcall RowSum(int ARow, int fromCol, int toCol);
	double __fastcall RowAvg(int ARow, int fromCol, int toCol);
	double __fastcall RowMin(int ARow, int fromCol, int toCol);
	double __fastcall RowMax(int ARow, int fromCol, int toCol);
	void __fastcall ResetFixedCellHighlight(void);
	virtual void __fastcall CalcFooter(int ACol);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall StartUpdate(void);
	void __fastcall ResetUpdate(void);
	__property bool LockUpdate = {read=GetLockFlag, write=SetLockFlag, nodefault};
	__property Grids::TGridRect UsedCells = {read=GetUsedCells};
	__property TCellType CellTypes[int ACol][int ARow] = {read=GetCellType};
	__property TCellGraphic* CellGraphics[int ACol][int ARow] = {read=GetCellGraphic};
	__property Types::TPoint CellGraphicSize[int ACol][int ARow] = {read=GetCellGraphicSize};
	__property Advobj::TIntList* CellImages[int ACol][int ARow] = {read=GetCellImages};
	__property int Ints[int ACol][int ARow] = {read=GetInts, write=SetInts};
	__property int AllInts[int ACol][int ARow] = {read=GetAllInts, write=SetAllInts};
	__property double Floats[int ACol][int ARow] = {read=GetFloats, write=SetFloats};
	__property double AllFloats[int ACol][int ARow] = {read=GetAllFloats, write=SetAllFloats};
	__property System::TDateTime Dates[int ACol][int ARow] = {read=GetDates, write=SetDates};
	__property System::TDateTime Times[int ACol][int ARow] = {read=GetTimes, write=SetTimes};
	__property System::UnicodeString ControlValues[int ACol][int ARow][System::UnicodeString ID] = {read=GetCtrlVal, write=SetCtrlVal};
	__property System::WideChar Delimiter = {read=FDelimiter, write=FDelimiter, nodefault};
	__property Classes::TStringList* FilterList = {read=FFilterList};
	__property bool NoDefaultDraw = {read=FNoDefaultDraw, write=FNoDefaultDraw, nodefault};
	__property System::WideChar PasswordChar = {read=FPasswordChar, write=FPasswordChar, nodefault};
	__property bool JavaCSV = {read=FJavaCSV, write=FJavaCSV, nodefault};
	__property bool FastPrint = {read=FFastPrint, write=FFastPrint, nodefault};
	__property int FindCol = {read=FFindCol, write=FFindCol, nodefault};
	__property int FindRow = {read=FFindRow, write=FFindRow, nodefault};
	__property System::UnicodeString CheckTrue = {read=FCheckTrue, write=FCheckTrue};
	__property System::UnicodeString CheckFalse = {read=FCheckFalse, write=FCheckFalse};
	__property bool LoadFirstRow = {read=FLoadFirstRow, write=FLoadFirstRow, nodefault};
	__property bool SaveFixedCells = {read=FSaveFixedCells, write=FSaveFixedCells, nodefault};
	__property bool SaveHiddenCells = {read=FSaveHiddenCells, write=FSaveHiddenCells, nodefault};
	__property bool SaveVirtCells = {read=FSaveVirtCells, write=FSaveVirtCells, nodefault};
	__property bool SaveWithHTML = {read=FSaveWithHTML, write=FSaveWithHTML, nodefault};
	__property bool SaveWithRTF = {read=FSaveWithRTF, write=FSaveWithRTF, nodefault};
	__property Advobj::TSortIndexList* SortIndexes = {read=FSortIndexes};
	__property System::UnicodeString OriginalCellValue = {read=FCellCache};
	__property bool EditActive = {read=FEditActive, nodefault};
	__property System::UnicodeString EditMask = {read=FEditMask, write=FEditMask};
	__property bool NoImageAndText = {read=FNoImageAndText, write=FNoImageAndText, nodefault};
	__property TGridDatePicker* DateTimePicker = {read=GetDateTimePicker};
	__property TGridDateTimePicker* DateAndTimePicker = {read=EditDateTime};
	__property TGridCombo* Combobox = {read=EditCombo};
	__property TGridTrackbarDropDown* TrackbarDropDown = {read=EditTrackBar};
	__property TGridMemoDropDown* MemoDropDown = {read=EditMemo};
	__property TGridCalculatorDropDown* CalculatorDropDown = {read=EditCalculator};
	__property TGridTimepickerDropDown* TimePickerDropDown = {read=EditTimePicker};
	__property TGridDetailPickerDropDown* DetailPickerDropDown = {read=EditDetailPicker};
	__property TGridGridDropDown* GridDropDown = {read=EditGridPicker};
	__property TGridColorDropDown* ColorPickerDropDown = {read=EditColorPicker};
	__property TGridImageDropDown* ImagePickerDropDown = {read=EditImagePicker};
	__property TGridAdvGridDropDown* AdvGridDropDown = {read=EditAdvGridPicker};
	__property bool ClearTextOnly = {read=FClearTextOnly, write=FClearTextOnly, nodefault};
	__property TGridSpin* SpinEdit = {read=EditSpin};
	__property TGridEditBtn* BtnEdit = {read=EditBtn};
	__property TGridButton* Btn = {read=GridButton};
	__property TGridUnitEditBtn* BtnUnitEdit = {read=UnitEditBtn};
	__property TAdvRichEdit* RichEdit = {read=FRichEdit};
	__property Graphics::TCanvas* FooterCanvas = {read=GetFooterCanvas};
	__property TAdvRichEdit* InplaceRichEdit = {read=FInplaceRichEdit};
	__property System::UnicodeString IncrSearchText = {read=SearchInc, write=SearchInc};
	__property TAdvInplaceEdit* NormalEdit = {read=GetInplaceEditor};
	__property TSearchPanel* SearchPanel = {read=FSearchPanel};
	__property bool PrinterDriverFix = {read=FPrinterdriverfix, write=FPrinterdriverfix, nodefault};
	__property bool RowSelect[int ARow] = {read=GetRowSelect, write=SetRowSelect};
	__property bool ColSelect[int ACol] = {read=GetColSelect, write=SetColSelect};
	__property int RowSelectCount = {read=GetRowSelectCount, nodefault};
	__property int ColSelectCount = {read=GetColSelectCount, nodefault};
	__property bool RowModified[int ARow] = {read=GetRowModified, write=SetRowModified};
	__property bool RowEnabled[int ARow] = {read=GetRowEnabled, write=SetRowEnabled};
	__property bool Modified = {read=FGridModified, write=FGridModified, nodefault};
	__property bool NodeState[int ARow] = {read=GetNodeState, write=SetNodeState};
	__property bool FindBusy = {read=FFindBusy, nodefault};
	__property Types::TRect PrintPageRect = {read=FPrintPageRect};
	__property int PrintPageWidth = {read=FPrintPageWidth, nodefault};
	__property int PrintColWidth[int ACol] = {read=GetPrintColWidth};
	__property int PrintColOffset[int ACol] = {read=GetPrintColOffset};
	__property int PrintColStart = {read=FPrintColStart, nodefault};
	__property int PrintColEnd = {read=FPrintColEnd, nodefault};
	__property int PrintNrOfPages = {read=FPrintPageNum, nodefault};
	__property bool ExcelClipboardFormat = {read=FExcelClipboardFormat, write=FExcelClipboardFormat, nodefault};
	__property int PreviewPage = {read=FPrintPageFrom, write=SetPreviewPage, nodefault};
	__property System::UnicodeString UnSortedCells[int i][int j] = {read=GetUnSortedCell, write=SetUnSortedCell};
	__property System::UnicodeString DisplCells[int i][int j] = {read=GetFormattedCell};
	__property System::UnicodeString AllCells[int i][int j] = {read=GetCellsEx, write=SetCellsEx};
	__property System::UnicodeString AllGridCells[int i][int j] = {read=GetGridCellsEx, write=SetGridCellsEx};
	__property System::WideString AllWideCells[int i][int j] = {read=GetWideCellsEx, write=SetWideCellsEx};
	__property System::WideString WideCells[int i][int j] = {read=GetWideCells, write=SetWideCells};
	__property System::TObject* AllObjects[int i][int j] = {read=GetObjectsEx, write=SetObjectsEx};
	__property System::UnicodeString OriginalCells[int i][int j] = {read=GetOriginalCells, write=SetOriginalCells};
	__property int AllColWidths[int i] = {read=GetAllColWidths, write=SetAllColWidths};
	__property int AllColCount = {read=GetAllColCount, nodefault};
	__property int AllRowCount = {read=GetAllRowCount, nodefault};
	__property Classes::TAlignment Alignments[int i][int j] = {read=GetAlignments, write=SetAlignments};
	__property int LinesInCell[int i][int j] = {read=GetLinesInCell};
	__property Graphics::TColor Colors[int i][int j] = {read=GetColors, write=SetColors};
	__property Graphics::TColor ColorsTo[int i][int j] = {read=GetColorsTo, write=SetColorsTo};
	__property Advobj::TCellGradientDirection Gradients[int i][int j] = {read=GetGradientDir, write=SetGradientDir};
	__property Advobj::TIntList* IgnoreColumns = {read=FIgnoreColumns};
	__property Graphics::TColor RowColor[int i] = {write=SetRowColor};
	__property Graphics::TColor RowColorTo[int i] = {write=SetRowColorTo};
	__property Graphics::TColor RowFontColor[int i] = {write=SetRowFontColor};
	__property Graphics::TColor FontColors[int i][int j] = {read=GetFontColors, write=SetFontColors};
	__property Graphics::TFontStyles FontStyles[int i][int j] = {read=GetFontStyles, write=SetFontStyles};
	__property int FontSizes[int i][int j] = {read=GetFontSizes, write=SetFontSizes};
	__property System::UnicodeString FontNames[int i][int j] = {read=GetFontNames, write=SetFontNames};
	__property Controls::TControl* CellControls[int i][int j] = {read=GetCellControls, write=SetCellControls};
	__property bool ReadOnly[int i][int j] = {read=GetReadOnly, write=SetReadOnly};
	__property bool WordWraps[int i][int j] = {read=GetWordWraps, write=SetWordWraps};
	__property System::UnicodeString StrippedCells[int i][int j] = {read=GetStrippedCell};
	__property bool SelectedCells[int i][int j] = {read=GetSelectedCells, write=SetSelectedCells};
	__property int SelectedCellsCount = {read=GetSelectedCellsCount, nodefault};
	__property Grids::TGridCoord SelectedCell[int i] = {read=GetSelectedCell};
	__property int SelectedRow[int i] = {read=GetSelectedRow};
	__property int SelectedRowCount = {read=GetSelectedRowCount, nodefault};
	__property int SelectedColCount = {read=GetSelectedColCount, nodefault};
	__property System::UnicodeString CurrentCell = {read=GetCurrentCell, write=SetCurrentCell};
	__property Graphics::TColor ArrowColor = {read=GetArrowColor, write=SetArrowColor, nodefault};
	__property int GroupColumn = {read=FGroupColumn, write=SetGroupColumn, nodefault};
	__property bool QuoteEmptyCells = {read=FQuoteEmptyCells, write=FQuoteEmptyCells, nodefault};
	__property bool AlwaysQuotes = {read=FAlwaysQuotes, write=FAlwaysQuotes, nodefault};
	__property Graphics::TColor SelectionRectangleColor = {read=FSelectionRectangleColor, write=FSelectionRectangleColor, nodefault};
	__property int RealRow = {read=GetRealRow, nodefault};
	__property int RealCol = {read=GetRealCol, nodefault};
	__property int Row = {read=GetRowEx, write=SetRowEx, nodefault};
	__property int TopRow = {read=GetTopRowEx, write=SetTopRowEx, nodefault};
	__property int SaveStartCol = {read=GetSaveStartCol, nodefault};
	__property int SaveStartRow = {read=GetSaveStartRow, nodefault};
	__property int SaveEndCol = {read=GetSaveEndCol, nodefault};
	__property int SaveEndRow = {read=GetSaveEndRow, nodefault};
	__property int SaveColCount = {read=GetSaveColCount, nodefault};
	__property int SaveRowCount = {read=GetSaveRowCount, nodefault};
	__property Grids::TGridRect Selection = {read=GetSelectionEx, write=SetSelectionEx};
	__property bool ShowNullDates = {read=FShowNullDates, write=FShowNullDates, nodefault};
	__property int VersionNr = {read=GetVersionNr, nodefault};
	__property System::UnicodeString VersionString = {read=GetVersionString};
	__property TEditLink* EditLink = {read=FEditLink, write=FEditLink};
	__property Types::TPoint XYOffset = {read=FXYOffset, write=SetXYOffset};
	__property bool XYOffsetTopLeftOnly = {read=FXYOffsetTopLeftOnly, write=FXYOffsetTopLeftOnly, nodefault};
	__property Picturecontainer::THTMLPictureCache* ImageCache = {read=FImageCache};
	__property Advobj::TIntList* MergedColumns = {read=FMergedColumns};
	__property bool AlwaysValidate = {read=FAlwaysValidate, write=FAlwaysValidate, nodefault};
	__property bool SizeGrowOnly = {read=FSizeGrowOnly, write=FSizeGrowOnly, nodefault};
	__property int MaxRowHeight = {read=FMaxRowHeight, write=FMaxRowHeight, nodefault};
	__property int MinRowHeight = {read=FMinRowHeight, write=FMinRowHeight, nodefault};
	__property int MaxColWidth = {read=FMaxColWidth, write=FMaxColWidth, nodefault};
	__property int MinColWidth = {read=FMinColWidth, write=FMinColWidth, nodefault};
	__property Graphics::TColor TMSGradientFrom = {read=FTMSGradFrom, write=SetTMSGradFrom, nodefault};
	__property Graphics::TColor TMSGradientTo = {read=FTMSGradTo, write=SetTMSGradTo, nodefault};
	__property Graphics::TColor TMSGradientMirrorFrom = {read=FTMSGradMirrorFrom, write=SetTMSGradMirrorFrom, nodefault};
	__property Graphics::TColor TMSGradientMirrorTo = {read=FTMSGradMirrorTo, write=SetTMSGradMirrorTo, nodefault};
	__property Graphics::TColor TMSGradientHoverFrom = {read=FTMSGradHoverFrom, write=FTMSGradHoverFrom, nodefault};
	__property Graphics::TColor TMSGradientHoverTo = {read=FTMSGradHoverTo, write=FTMSGradHoverTo, nodefault};
	__property Graphics::TColor TMSGradientHoverMirrorFrom = {read=FTMSGradHoverMirrorFrom, write=FTMSGradHoverMirrorFrom, nodefault};
	__property Graphics::TColor TMSGradientHoverMirrorTo = {read=FTMSGradHoverMirrorTo, write=FTMSGradHoverMirrorTo, nodefault};
	__property Graphics::TColor TMSGradientHoverBorder = {read=FTMSGradHoverBorder, write=FTMSGradHoverBorder, nodefault};
	__property Graphics::TColor TMSGradientDownFrom = {read=FTMSGradDownFrom, write=FTMSGradDownFrom, nodefault};
	__property Graphics::TColor TMSGradientDownTo = {read=FTMSGradDownTo, write=FTMSGradDownTo, nodefault};
	__property Graphics::TColor TMSGradientDownMirrorFrom = {read=FTMSGradDownMirrorFrom, write=FTMSGradDownMirrorFrom, nodefault};
	__property Graphics::TColor TMSGradientDownMirrorTo = {read=FTMSGradDownMirrorTo, write=FTMSGradDownMirrorTo, nodefault};
	__property Graphics::TColor TMSGradientDownBorder = {read=FTMSGradDownBorder, write=FTMSGradDownBorder, nodefault};
	__property System::UnicodeString XMLEncoding = {read=FXMLEncoding, write=FXMLEncoding};
	__property bool UseHTMLHints = {read=FUseHTMLHints, write=SetUseHTMLHints, nodefault};
	__property TSortDirection AutoNumberDirection = {read=FAutoNumberDirection, write=FAutoNumberDirection, nodefault};
	__property int AutoNumberOffset = {read=FAutoNumberOffset, write=FAutoNumberOffset, nodefault};
	__property int AutoNumberStart = {read=FAutoNumberStart, write=FAutoNumberStart, nodefault};
	__property Classes::TNotifyEvent OnPainted = {read=FOnPainted, write=FOnPainted};
	__property Advobj::TClickCellEvent OnGetEditorPropInt = {read=FonGetEditorPropInt, write=FonGetEditorPropInt};
	__property TCharSet ValidCharSet = {read=FValidCharSet, write=FValidCharSet};
	__property bool FilterIncremental = {read=FFilterIncremental, write=FFilterIncremental, default=1};
	
__published:
	__property TAutoAdvanceEvent OnAutoAdvance = {read=FOnAutoAdvance, write=FOnAutoAdvance};
	__property Advobj::TCustomCellDrawEvent OnCustomCellBkgDraw = {read=FOnCustomCellBkgDraw, write=FOnCustomCellBkgDraw};
	__property Advobj::TCustomCellDrawEvent OnCustomCellDraw = {read=FOnCustomCellDraw, write=FOnCustomCellDraw};
	__property TCustomCellSizeEvent OnCustomCellSize = {read=FOnCustomCellSize, write=FOnCustomCellSize};
	__property TCustomFilterEvent OnCustomFilter = {read=FOnCustomFilter, write=FOnCustomFilter};
	__property Advobj::TGridColorEvent OnGetCellColor = {read=FOnGetCellColor, write=FOnGetCellColor};
	__property Advobj::TGridGradientEvent OnGetCellGradient = {read=FOnGetCellGradient, write=FOnGetCellGradient};
	__property Advobj::TGridColorEvent OnGetCellPrintColor = {read=FOnGetCellPrintColor, write=FOnGetCellPrintColor};
	__property Advobj::TGridBorderEvent OnGetCellPrintBorder = {read=FOnGetCellPrintBorder, write=FOnGetCellPrintBorder};
	__property Advobj::TGridBorderEvent OnGetCellBorder = {read=FOnGetCellBorder, write=FOnGetCellBorder};
	__property Advobj::TGridBorderPropEvent OnGetCellBorderProp = {read=FOnGetCellBorderProp, write=FOnGetCellBorderProp};
	__property Advobj::TGridAlignEvent OnGetAlignment = {read=FOnGetAlignment, write=FOnGetAlignment};
	__property TWordWrapEvent OnGetWordWrap = {read=FOnGetWordWrap, write=FOnGetWordWrap};
	__property TGetColumnFilterEvent OnGetColumnFilter = {read=FOnGetColumnFilter, write=FOnGetColumnFilter};
	__property Classes::TNotifyEvent OnFilterDone = {read=FOnFilterDone, write=FOnFilterDone};
	__property TFilterSelectEvent OnFilterSelect = {read=FOnFilterSelect, write=FOnFilterSelect};
	__property Advobj::TGridFormatEvent OnGetFormat = {read=FOnGetFormat, write=FOnGetFormat};
	__property TGetCheckEvent OnGetCheckTrue = {read=FOnGetCheckTrue, write=FOnGetCheckTrue};
	__property TGetCheckEvent OnGetCheckFalse = {read=FOnGetCheckFalse, write=FOnGetCheckFalse};
	__property Advobj::TGridHintEvent OnGridHint = {read=FOnGridHint, write=FOnGridHint};
	__property TGridWideHintEvent OnGridWideHint = {read=FOnGridWideHint, write=FOnGridWideHint};
	__property TGroupCalcEvent OnGroupCalc = {read=FOnGroupCalc, write=FOnGroupCalc};
	__property Advobj::TOfficeHintEvent OnOfficeHint = {read=FOnOfficeHint, write=FOnOfficeHint};
	__property TRowChangedEvent OnRowUpdate = {read=FOnRowChanged, write=FOnRowChanged};
	__property TRowChangingEvent OnRowChanging = {read=FOnRowChanging, write=FOnRowChanging};
	__property TColChangingEvent OnColChanging = {read=FOnColChanging, write=FOnColChanging};
	__property TCellChangingEvent OnCellChanging = {read=FOnCellChanging, write=FOnCellChanging};
	__property Advobj::TGridBalloonEvent OnCellBalloon = {read=FOnCellBalloon, write=FOnCellBalloon};
	__property TCustomStrToDateEvent OnCustomStrToDate = {read=FOnCustomStrToDate, write=FOnCustomStrToDate};
	__property TGridPrintPageEvent OnPrintPage = {read=FOnPrintPage, write=FOnPrintPage};
	__property TGridPrintPageDoneEvent OnPrintPageDone = {read=FOnPrintPageDone, write=FOnPrintPageDone};
	__property TGridPrintStartEvent OnPrintStart = {read=FOnPrintStart, write=FOnPrintStart};
	__property TGridPrintCancelEvent OnPrintCancel = {read=FOnPrintCancel, write=FOnPrintCancel};
	__property TDoFitToPageEvent OnFitToPage = {read=FDoFitToPage, write=FDoFitToPage};
	__property TGridPrintNewPageEvent OnPrintNewPage = {read=FOnPrintNewPage, write=FOnPrintNewPage};
	__property TGridPrintColumnWidthEvent OnPrintSetColumnWidth = {read=FOnPrintSetColumnWidth, write=FOnPrintSetColumnWidth};
	__property TGridPrintRowHeightEvent OnPrintSetRowHeight = {read=FOnPrintSetRowHeight, write=FOnPrintSetRowHeight};
	__property Advobj::TCanAddRowEvent OnCanAddRow = {read=FOnCanAddRow, write=FOnCanAddRow};
	__property Advobj::TAutoAddRowEvent OnAutoAddRow = {read=FOnAutoAddRow, write=FOnAutoAddRow};
	__property Advobj::TCanInsertRowEvent OnCanInsertRow = {read=FOnCanInsertRow, write=FOnCanInsertRow};
	__property Advobj::TAutoInsertRowEvent OnAutoInsertRow = {read=FOnAutoInsertRow, write=FOnAutoInsertRow};
	__property Advobj::TAutoInsertColEvent OnAutoInsertCol = {read=FOnAutoInsertCol, write=FOnAutoInsertCol};
	__property Advobj::TCanDeleteRowEvent OnCanDeleteRow = {read=FOnCanDeleteRow, write=FOnCanDeleteRow};
	__property Advobj::TAutoDeleteRowEvent OnAutoDeleteRow = {read=FOnAutoDeleteRow, write=FOnAutoDeleteRow};
	__property Advobj::TClickSortEvent OnClickSort = {read=FOnClickSort, write=FOnClickSort};
	__property Advobj::TCanSortEvent OnCanSort = {read=FOnCanSort, write=FOnCanSort};
	__property TNodeClickEvent OnExpandNode = {read=FOnExpandNode, write=FOnExpandNode};
	__property TNodeClickEvent OnContractNode = {read=FOnContractNode, write=FOnContractNode};
	__property TDropDownButtonClickEvent OnDropDownHeaderButtonClick = {read=FOnDropDownHeaderButtonClick, write=FOnDropDownHeaderButtonClick};
	__property TDropDownButtonClickEvent OnDropDownFooterButtonClick = {read=FOnDropDownFooterButtonClick, write=FOnDropDownFooterButtonClick};
	__property TNodeAllowEvent OnBeforeExpandNode = {read=FOnBeforeExpandNode, write=FOnBeforeExpandNode};
	__property TNodeAllowEvent OnBeforeContractNode = {read=FOnBeforeContractNode, write=FOnBeforeContractNode};
	__property Advobj::TCustomCompareEvent OnCustomCompare = {read=FCustomCompare, write=FCustomCompare};
	__property Advobj::TRawCompareEvent OnRawCompare = {read=FRawCompare, write=FRawCompare};
	__property Advobj::TSearchEditChangeEvent OnSearchEditChange = {read=FOnSearchEditChange, write=FOnSearchEditChange};
	__property TSearchFooterActionEvent OnSearchFooterAction = {read=FOnSearchFooterAction, write=FOnSearchFooterAction};
	__property Classes::TNotifyEvent OnSearchFooterClose = {read=FOnSearchFooterClose, write=FOnSearchFooterClose};
	__property TCanShowFixedDropDownEvent OnCanShowFixedDropDown = {read=FOnCanShowFixedDropDown, write=FOnCanShowFixedDropDown};
	__property TFixedDropDownEvent OnFixedDropDownClick = {read=FOnFixedDropDownClick, write=FOnFixedDropDownClick};
	__property Advobj::TClickCellEvent OnClickCell = {read=FOnClickCell, write=FOnClickCell};
	__property Advobj::TClickCellEvent OnRightClickCell = {read=FOnRightClickCell, write=FOnRightClickCell};
	__property Advobj::TDblClickCellEvent OnDblClickCell = {read=FOnDblClickCell, write=FOnDblClickCell};
	__property TCanClickCellEvent OnCanClickCell = {read=FOnCanClickCell, write=FOnCanClickCell};
	__property Advobj::TCanEditCellEvent OnCanEditCell = {read=FOnCanEditCell, write=FOnCanEditCell};
	__property TIsFixedCellEvent OnIsFixedCell = {read=FOnIsFixedCell, write=FOnIsFixedCell};
	__property TIsPasswordCellEvent OnIsPasswordCell = {read=FOnIsPasswordCell, write=FOnIsPasswordCell};
	__property Advobj::TAnchorClickEvent OnAnchorClick = {read=FOnAnchorClick, write=FOnAnchorClick};
	__property Advobj::TAnchorEvent OnAnchorEnter = {read=FOnAnchorEnter, write=FOnAnchorEnter};
	__property Advobj::TAnchorEvent OnAnchorExit = {read=FOnAnchorExit, write=FOnAnchorExit};
	__property Advobj::TAnchorHintEvent OnAnchorHint = {read=FOnAnchorHint, write=FOnAnchorHint};
	__property TCellControlEvent OnControlClick = {read=FOnControlClick, write=FOnControlClick};
	__property TCellControlEvent OnControlEditDone = {read=FOnControlEditDone, write=FOnControlEditDone};
	__property TCellComboControlEvent OnControlComboList = {read=FOnControlComboList, write=FOnControlComboList};
	__property TCellComboControlSelectEvent OnControlComboSelect = {read=FOnControlComboSelect, write=FOnControlComboSelect};
	__property TClipboardEvent OnClipboardPaste = {read=FOnClipboardPaste, write=FOnClipboardPaste};
	__property TClipboardEvent OnClipboardCopy = {read=FOnClipboardCopy, write=FOnClipboardCopy};
	__property TClipboardEvent OnClipboardCut = {read=FOnClipboardCut, write=FOnClipboardCut};
	__property TAfterCellPasteEvent OnClipboardAfterPasteCell = {read=FOnClipboardAfterPasteCell, write=FOnClipboardAfterPasteCell};
	__property TAfterCellPasteWideEvent OnClipboardAfterPasteWideCell = {read=FOnClipboardAfterPasteWideCell, write=FOnClipboardAfterPasteWideCell};
	__property TBeforeCellPasteEvent OnClipboardBeforePasteCell = {read=FOnClipboardBeforePasteCell, write=FOnClipboardBeforePasteCell};
	__property TBeforeCellPasteWideEvent OnClipboardBeforePasteWideCell = {read=FOnClipboardBeforePasteWideCell, write=FOnClipboardBeforePasteWideCell};
	__property TCellValidateEvent OnCellValidate = {read=FOnCellValidate, write=FOnCellValidate};
	__property TCellValidateWideEvent OnCellValidateWide = {read=FOnCellValidateWide, write=FOnCellValidateWide};
	__property TCellsChangedEvent OnCellsChanged = {read=FOnCellsChanged, write=FOnCellsChanged};
	__property TGridProgressEvent OnFileProgress = {read=FOnFileProgress, write=FOnFileProgress};
	__property TGridProgressEvent OnFilterProgress = {read=FOnFilterProgress, write=FOnFilterProgress};
	__property THasComboEvent OnHasComboBox = {read=FOnHasComboBox, write=FOnHasComboBox};
	__property THasSpinEditEvent OnHasSpinEdit = {read=FOnHasSpinEdit, write=FOnHasSpinEdit};
	__property Advobj::TGetEditorTypeEvent OnGetEditorType = {read=FOnGetEditorType, write=FOnGetEditorType};
	__property TGetEditorPropEvent OnGetEditorProp = {read=FOnGetEditorProp, write=FOnGetEditorProp};
	__property Advobj::TFloatFormatEvent OnGetFloatFormat = {read=FOnGetFloatFormat, write=FOnGetFloatFormat};
	__property Advobj::TEllipsClickEvent OnEllipsClick = {read=FOnEllipsClick, write=FOnEllipsClick};
	__property Advobj::TButtonClickEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property Advobj::TCheckBoxClickEvent OnCheckBoxChange = {read=FOnCheckBoxChange, write=FOnCheckBoxChange};
	__property Advobj::TCheckBoxClickEvent OnCheckBoxClick = {read=FOnCheckBoxClick, write=FOnCheckBoxClick};
	__property Advobj::TCheckBoxClickEvent OnCheckBoxMouseUp = {read=FOnCheckBoxMouseUp, write=FOnCheckBoxMouseUp};
	__property TColorSelectedEvent OnColorSelected = {read=FOnColorSelected, write=FOnColorSelected};
	__property TColorSelectEvent OnColorSelect = {read=FOnColorSelect, write=FOnColorSelect};
	__property TImageSelectedEvent OnImageSelected = {read=FOnImageSelected, write=FOnImageSelected};
	__property TImageSelectEvent OnImageSelect = {read=FOnImageSelect, write=FOnImageSelect};
	__property TRadioClickEvent OnRadioClick = {read=FOnRadioClick, write=FOnRadioClick};
	__property TRadioClickEvent OnRadioMouseUp = {read=FOnRadioMouseUp, write=FOnRadioMouseUp};
	__property TRadioButtonClickEvent OnRadioButtonClick = {read=FOnRadioButtonClick, write=FOnRadioButtonClick};
	__property Advobj::TClickCellEvent OnDatePickerCloseUp = {read=FOnDatePickerCloseUp, write=FOnDatePickerCloseUp};
	__property Advobj::TClickCellEvent OnDatePickerDropDown = {read=FOnDatePickerDropDown, write=FOnDatePickerDropDown};
	__property TComboChangeEvent OnComboChange = {read=FOnComboChange, write=FOnComboChange};
	__property Advobj::TClickCellEvent OnComboCloseUp = {read=FOnComboCloseUp, write=FOnComboCloseUp};
	__property TComboObjectChangeEvent OnComboObjectChange = {read=FOnComboObjectChange, write=FOnComboObjectChange};
	__property Advobj::TSpinClickEvent OnSpinClick = {read=FOnSpinClick, write=FOnSpinClick};
	__property TFloatSpinClickEvent OnFloatSpinClick = {read=FOnFloatSpinClick, write=FOnFloatSpinClick};
	__property TDateTimeSpinClickEvent OnTimeSpinClick = {read=FOntimeSpinClick, write=FOntimeSpinClick};
	__property TDateTimeSpinClickEvent OnDateSpinClick = {read=FOnDateSpinClick, write=FOnDateSpinClick};
	__property Classes::TNotifyEvent OnRichEditSelectionChange = {read=FOnRichEditSelectionChange, write=FOnRichEditSelectionChange};
	__property TDragScrollEvent OnDragScroll = {read=FOnDragScroll, write=FOnDragScroll};
	__property Classes::TNotifyEvent OnEditingDone = {read=FOnEditingDone, write=FOnEditingDone};
	__property TEditCellDoneEvent OnEditCellDone = {read=FOnEditCellDone, write=FOnEditCellDone};
	__property TEditChangeEvent OnEditChange = {read=FOnEditChange, write=FOnEditChange};
	__property TDateTimeChangeEvent OnDateTimeChange = {read=FOnDateTimeChange, write=FOnDateTimeChange};
	__property TFooterPaintEvent OnFooterPaint = {read=FOnPaintFooter, write=FOnPaintFooter};
	__property TCalcFooterEvent OnFooterCalc = {read=FOnCalcFooter, write=FOnCalcFooter};
	__property Classes::TNotifyEvent OnResize = {read=FOnGridResize, write=FOnGridResize};
	__property TRowDisjunctSelectEvent OnRowDisjunctSelect = {read=FOnRowDisjunctSelect, write=FOnRowDisjunctSelect};
	__property Advobj::TAutoInsertRowEvent OnRowDisjunctSelected = {read=FOnRowDisjunctSelected, write=FOnRowDisjunctSelected};
	__property TSelectionChanged OnSelectionChanged = {read=FSelectionChanged, write=FSelectionChanged};
	__property TOleDragDropEvent OnOleDrop = {read=FOnOleDrop, write=FOnOleDrop};
	__property TOleDroppedEvent OnOleDropped = {read=FOnOleDropped, write=FOnOleDropped};
	__property TOleDragDropEvent OnOleDrag = {read=FOnOleDrag, write=FOnOleDrag};
	__property TOleDragOverEvent OnOleDragOver = {read=FOnOleDragOver, write=FOnOleDragOver};
	__property TOleDragStartEvent OnOleDragStart = {read=FOnOleDragStart, write=FOnOleDragStart};
	__property TOleDragStopEvent OnOleDragStop = {read=FOnOleDragStop, write=FOnOleDragStop};
	__property TOleDropColEvent OnOleDropCol = {read=FOnOleDropCol, write=FOnOleDropCol};
	__property TOleDropFileEvent OnOleDropFile = {read=FOnOleDropFile, write=FOnOleDropFile};
	__property TOleDropURLEvent OnOleDropURL = {read=FOnOleDropURL, write=FOnOleDropURL};
	__property TRatingChangeEvent OnRatingChange = {read=FOnRatingChange, write=FOnRatingChange};
	__property TDragDropSettings* DragDropSettings = {read=FDragDropSettings, write=FDragDropSettings};
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property Graphics::TColor HighlightColor = {read=FHighlightColor, write=SetHighlightColor, default=-16777203};
	__property Graphics::TColor HighlightTextColor = {read=FHighLightTextColor, write=SetHighlightTextColor, default=-16777202};
	__property Graphics::TColor HintColor = {read=FHintColor, write=FHintColor, default=-16777192};
	__property bool HintShowCells = {read=FHintShowCells, write=FHintShowCells, default=0};
	__property bool HintShowLargeText = {read=FHintShowLargeText, write=FHintShowLargeText, default=0};
	__property bool HintShowSizing = {read=FHintShowSizing, write=FHintShowSizing, default=0};
	__property bool HTMLHint = {read=FHTMLHint, write=FHTMLHint, default=0};
	__property Advobj::TScrollHintEvent OnScrollHint = {read=FOnScrollHint, write=FOnScrollHint};
	__property Advobj::TColumnSizeEvent OnColumnSize = {read=FOnColumnSize, write=FOnColumnSize};
	__property Advobj::TColumnSizingEvent OnColumnSizing = {read=FOnColumnSizing, write=FOnColumnSizing};
	__property Advobj::TColumnSizeEvent OnColumnMove = {read=FOnColumnMove, write=FOnColumnMove};
	__property Advobj::TColumnSizeEvent OnColumnMoving = {read=FOnColumnMoving, write=FOnColumnMoving};
	__property Advobj::TRowSizeEvent OnRowSize = {read=FOnRowSize, write=FOnRowSize};
	__property Advobj::TRowSizingEvent OnRowSizing = {read=FOnRowSizing, write=FOnRowSizing};
	__property Advobj::TRowSizeEvent OnRowMove = {read=FOnRowMove, write=FOnRowMove};
	__property Advobj::TRowSizeEvent OnRowMoving = {read=FOnRowMoving, write=FOnRowMoving};
	__property Advobj::TEndColumnSizeEvent OnEndColumnSize = {read=FOnEndColumnSize, write=FOnEndColumnSize};
	__property Advobj::TUpdateColumnSizeEvent OnUpdateColumnSize = {read=FOnUpdateColumnSize, write=FOnUpdateColumnSize};
	__property Advobj::TEndRowSizeEvent OnEndRowSize = {read=FOnEndRowSize, write=FOnEndRowSize};
	__property TScrollCellEvent OnScrollCell = {read=FOnScrollCell, write=FOnScrollCell};
	__property TSelectionResizeEvent OnSelectionResize = {read=FSelectionResizeEvent, write=FSelectionResizeEvent};
	__property TSelectionResizeEvent OnSelectionResized = {read=FSelectionResizedEvent, write=FSelectionResizedEvent};
	__property Classes::TNotifyEvent OnCreatedFloatingFooter = {read=FOnCreatedFloatingFooter, write=FOnCreatedFloatingFooter};
	__property Classes::TNotifyEvent OnCreatedSearchFooter = {read=FOnCreatedSearchFooter, write=FOnCreatedSearchFooter};
	__property TCellSaveLoadEvent OnSaveCell = {read=FOnSaveCell, write=FOnSaveCell};
	__property TCellSaveLoadEvent OnLoadCell = {read=FOnLoadCell, write=FOnLoadCell};
	__property bool OemConvert = {read=FOemConvert, write=FOemConvert, default=0};
	__property bool AnchorHint = {read=FAnchorHint, write=FAnchorHint, default=0};
	__property bool ActiveCellShow = {read=FActiveCellShow, write=SetActiveCellShow, default=0};
	__property Graphics::TFont* ActiveCellFont = {read=FActiveCellFont, write=SetActiveCellFont};
	__property Graphics::TColor ActiveCellColor = {read=FActiveCellColor, write=SetActiveCellColor, default=8421504};
	__property Graphics::TColor ActiveCellColorTo = {read=FActiveCellColorTo, write=SetActiveCellColorTo, default=536870911};
	__property bool AutoNumAlign = {read=FAutoNumAlign, write=FAutoNumAlign, default=0};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSizeP, default=0};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=SetAutoThemeAdapt, default=0};
	__property bool AutoFilterUpdate = {read=FAutoFilterUpdate, write=FAutoFilterUpdate, default=1};
	__property TBalloonSettings* Balloon = {read=FBalloonSettings, write=SetBalloonSettings};
	__property TBands* Bands = {read=FBands, write=FBands};
	__property TBackGround* BackGround = {read=FBackGround, write=SetBackground};
	__property TCellNode* CellNode = {read=FCellNode, write=FCellNode};
	__property Asgcheck::TAdvStringGridCheck* CellChecker = {read=FCellChecker, write=FCellChecker};
	__property int ColCount = {read=GetColCountEx, write=SetColCountEx, default=5};
	__property Classes::TStringList* ColumnHeaders = {read=FColumnHeaders, write=SetColumnHeaders};
	__property TColumnSize* ColumnSize = {read=FColumnSize, write=FColumnSize};
	__property TControlLook* ControlLook = {read=FControlLook, write=FControlLook};
	__property Controls::TCursor Cursor = {read=GetCursorEx, write=SetCursorEx, nodefault};
	__property int DefaultRowHeight = {read=GetDefRowHeightEx, write=SetDefRowHeightEx, default=22};
	__property Advobj::TEditorType DefaultEditor = {read=FDefaultEditor, write=FDefaultEditor, default=0};
	__property Graphics::TColor DisabledFontColor = {read=FDisabledFontColor, write=FDisabledFontColor, default=12632256};
	__property TDragScrollOptions* DragScrollOptions = {read=FDragScrollOptions, write=SetDragScrollOptions};
	__property bool EditWithTags = {read=FEditWithTags, write=FEditWithTags, default=0};
	__property bool EnableBlink = {read=FEnableBlink, write=FEnableBlink, default=0};
	__property bool EnableHTML = {read=FEnableHTML, write=FEnableHTML, default=1};
	__property bool EnableWheel = {read=FEnableWheel, write=FEnableWheel, default=1};
	__property bool EnhTextSize = {read=FEnhTextSize, write=FEnhTextSize, default=0};
	__property bool EnhRowColMove = {read=FEnhRowColMove, write=FEnhRowColMove, default=1};
	__property bool ExcelStyleDecimalSeparator = {read=FExcelStyleDecimalSeparator, write=FExcelStyleDecimalSeparator, default=0};
	__property TFilter* Filter = {read=FFilter, write=FFilter};
	__property bool FilterActive = {read=FFilterActive, write=SetFilterActive, default=0};
	__property TFilterDropDown* FilterDropDown = {read=FFilterDropDown, write=FFilterDropDown};
	__property bool FilterDropDownAuto = {read=FFilterDropDownAuto, write=SetFilterDropDownAuto, default=0};
	__property System::UnicodeString FilterDropDownClear = {read=FFilterDropDownClear, write=FFilterDropDownClear};
	__property int FilterDropDownRow = {read=FFilterRow, write=SetFilterRow, default=0};
	__property int FixedCols = {read=GetFixedColsEx, write=SetFixedColsEx, default=1};
	__property bool FixedAsButtons = {read=FFixedAsButtons, write=FFixedAsButtons, default=0};
	__property int FixedFooters = {read=FFixedFooters, write=SetFixedFooters, default=0};
	__property int FixedRightCols = {read=FFixedRightCols, write=SetFixedRightCols, default=0};
	__property int FixedColWidth = {read=GetFixedColWidth, write=SetFixedColWidth, default=64};
	__property Menus::TPopupMenu* FixedDropDownMenu = {read=FFixedDropDownMenu, write=FFixedDropDownMenu};
	__property int FixedRowHeight = {read=GetFixedRowHeight, write=SetFixedRowHeight, default=21};
	__property bool FixedRowAlways = {read=FFixedRowAlways, write=FFixedRowAlways, default=0};
	__property int FixedRows = {read=GetFixedRowsEx, write=SetFixedRowsEx, default=1};
	__property bool FixedColAlways = {read=FFixedColAlways, write=FFixedColAlways, default=0};
	__property Graphics::TFont* FixedFont = {read=FFixedFont, write=SetFixedFont};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property System::UnicodeString FloatFormat = {read=FFloatFormat, write=FFloatFormat};
	__property TFloatingFooter* FloatingFooter = {read=FFloatingFooter, write=FFloatingFooter};
	__property Imglist::TCustomImageList* GridImages = {read=FGridImages, write=SetImages};
	__property TGrouping* Grouping = {read=FGrouping, write=FGrouping};
	__property bool HideFocusRect = {read=FHideFocusRect, write=FHideFocusRect, default=0};
	__property bool Hovering = {read=FHovering, write=SetHovering, default=0};
	__property THoverFixedCells HoverFixedCells = {read=FHoverFixedCells, write=FHoverFixedCells, default=0};
	__property THTMLSettings* HTMLSettings = {read=FHTMLSettings, write=FHTMLSettings};
	__property bool IntegralHeight = {read=FIntegralHeight, write=SetIntegralHeight, default=0};
	__property TIntelliPan IntelliPan = {read=FIntelliPan, write=FIntelliPan, default=0};
	__property bool IntelliZoom = {read=FIntelliZoom, write=FIntelliZoom, default=1};
	__property System::UnicodeString InvalidEntryTitle = {read=FInvalidEntryTitle, write=FInvalidEntryTitle};
	__property TInvalidEntryIcon InvalidEntryIcon = {read=FInvalidEntryIcon, write=FInvalidEntryIcon, default=2};
	__property System::UnicodeString InvalidEntryText = {read=FInvalidEntryText, write=FInvalidEntryText};
	__property TGridLook Look = {read=FLook, write=SetLook, default=4};
	__property Classes::TStringList* LookupItems = {read=FLookupItems, write=SetLookupItems};
	__property bool Lookup = {read=FLookup, write=FLookup, default=0};
	__property bool LookupCaseSensitive = {read=FLookupCaseSensitive, write=FLookupCaseSensitive, default=0};
	__property bool LookupHistory = {read=FLookupHistory, write=FLookupHistory, default=0};
	__property int MaxEditLength = {read=FMaxEditLength, write=SetMaxEditLength, default=0};
	__property int MaxComboLength = {read=FMaxComboLength, write=FMaxComboLength, default=0};
	__property Advobj::TMouseActions* MouseActions = {read=FMouseActions, write=FMouseActions};
	__property bool Multilinecells = {read=FMultilineCells, write=FMultilineCells, default=0};
	__property Advobj::TNavigation* Navigation = {read=FNavigation, write=FNavigation};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property TPrintSettings* PrintSettings = {read=FPrintSettings, write=FPrintSettings};
	__property TGridProgressAppearance* ProgressAppearance = {read=FProgressAppearance, write=SetProgressAppearance};
	__property int RowCount = {read=GetRowCountEx, write=SetRowCountEx, default=10};
	__property Classes::TStringList* RowHeaders = {read=FRowHeaders, write=SetRowHeaders};
	__property Graphics::TBitmap* RowIndicator = {read=GetRowIndicator, write=SetRowIndicator};
	__property TScrollBarAlways ScrollBarAlways = {read=FScrollBarAlways, write=SetScrollBarAlways, default=0};
	__property Stdctrls::TScrollStyle ScrollBars = {read=GetScrollBarsEx, write=SetScrollBarsEx, nodefault};
	__property Graphics::TColor ScrollColor = {read=FScrollColor, write=SetScrollColor, default=536870911};
	__property bool ScrollProportional = {read=FScrollProportional, write=SetScrollProportional, default=0};
	__property bool ScrollSynch = {read=FScrollSynch, write=FScrollSynch, default=0};
	__property TScrollType ScrollType = {read=FScrollType, write=SetScrollType, default=0};
	__property int ScrollWidth = {read=FScrollWidth, write=SetScrollWidth, default=17};
	__property TScrollHintType ScrollHints = {read=FScrollHints, write=FScrollHints, default=0};
	__property Advobj::TSearchFooter* SearchFooter = {read=FSearchFooter, write=FSearchFooter};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=SetSelectionColor, default=15387318};
	__property Graphics::TColor SelectionColorTo = {read=FSelectionColorTo, write=SetSelectionColorTo, default=536870911};
	__property Graphics::TColor SelectionMirrorColor = {read=FSelectionMirrorColor, write=SetSelectionMirrorColor, default=536870911};
	__property Graphics::TColor SelectionMirrorColorTo = {read=FSelectionMirrorColorTo, write=SetSelectionMirrorColorTo, default=536870911};
	__property bool SelectionRectangle = {read=FSelectionRectangle, write=SetSelectionRectangle, default=0};
	__property bool SelectionResizer = {read=FSelectionResizer, write=SetSelectionResizer, default=0};
	__property bool SelectionRTFKeep = {read=FSelectionRTFKeep, write=FSelectionRTFKeep, default=0};
	__property Graphics::TColor SelectionTextColor = {read=FSelectionTextColor, write=SetSelectionTextColor, default=0};
	__property bool ShowSelection = {read=FShowSelection, write=SetShowSelection, default=1};
	__property TShowModified* ShowModified = {read=FShowModified, write=SetShowModified};
	__property bool ShowDesignHelper = {read=FShowDesignHelper, write=SetShowDesignHelper, default=1};
	__property TSizeWhileTyping* SizeWhileTyping = {read=FSizeWhileTyping, write=FSizeWhileTyping};
	__property bool SizeWithForm = {read=FSizeWithForm, write=FSizeWithForm, default=0};
	__property TSortSettings* SortSettings = {read=FSortSettings, write=FSortSettings};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property bool URLShow = {read=FURLShow, write=SetURLShow, default=0};
	__property bool URLShowInText = {read=FURLShowInText, write=SetURLShowInText, default=0};
	__property bool URLFull = {read=FURLFull, write=SetURLFull, default=0};
	__property bool URLEdit = {read=FURLEdit, write=FURLEdit, default=0};
	__property bool UseInternalHintClass = {read=FUseInternalHintClass, write=FUseInternalHintClass, default=1};
	__property System::UnicodeString ValidChars = {read=FValidChars, write=FValidChars};
	__property Advobj::TVAlignment VAlignment = {read=FVAlignment, write=SetVAlignment, default=0};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property bool WordWrap = {read=GetWordWrapEx, write=SetWordWrapEx, default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvStringGrid(HWND ParentWindow) : Basegrid::TBaseGrid(ParentWindow) { }
	
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


class DELPHICLASS TGridSLIO;
class PASCALIMPLEMENTATION TGridSLIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TStringList* FStrings;
	
public:
	__fastcall virtual TGridSLIO(Classes::TComponent* AOwner);
	__fastcall virtual ~TGridSLIO(void);
	
__published:
	__property Classes::TStringList* Strings = {read=FStrings, write=FStrings};
};


class DELPHICLASS TGridFilePicIO;
class PASCALIMPLEMENTATION TGridFilePicIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Advobj::TFilePicture* FPicture;
	
public:
	__fastcall virtual TGridFilePicIO(Classes::TComponent* AOwner);
	__fastcall virtual ~TGridFilePicIO(void);
	
__published:
	__property Advobj::TFilePicture* Picture = {read=FPicture, write=FPicture};
};


class DELPHICLASS TGridPicIO;
class PASCALIMPLEMENTATION TGridPicIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Graphics::TPicture* FPicture;
	
public:
	__fastcall virtual TGridPicIO(Classes::TComponent* AOwner);
	__fastcall virtual ~TGridPicIO(void);
	
__published:
	__property Graphics::TPicture* Picture = {read=FPicture, write=FPicture};
};


class DELPHICLASS TGridIconIO;
class PASCALIMPLEMENTATION TGridIconIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Graphics::TIcon* FIcon;
	
public:
	__fastcall virtual TGridIconIO(Classes::TComponent* AOwner);
	__fastcall virtual ~TGridIconIO(void);
	
__published:
	__property Graphics::TIcon* Icon = {read=FIcon, write=FIcon};
};


class DELPHICLASS TGridBMPIO;
class PASCALIMPLEMENTATION TGridBMPIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Graphics::TBitmap* FBitmap;
	
public:
	__fastcall virtual TGridBMPIO(Classes::TComponent* AOwner);
	__fastcall virtual ~TGridBMPIO(void);
	
__published:
	__property Graphics::TBitmap* Bitmap = {read=FBitmap, write=FBitmap};
};


class DELPHICLASS TGridPropIO;
class PASCALIMPLEMENTATION TGridPropIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	int FColCount;
	int FRowCount;
	System::UnicodeString FColWidths;
	System::UnicodeString FRowHeights;
	bool FFullGrid;
	int FID;
	
__published:
	__property int ColCount = {read=FColCount, write=FColCount, nodefault};
	__property int RowCount = {read=FRowCount, write=FRowCount, nodefault};
	__property System::UnicodeString ColWidths = {read=FColWidths, write=FColWidths};
	__property System::UnicodeString RowHeights = {read=FRowHeights, write=FRowHeights};
	__property bool FullGrid = {read=FFullGrid, write=FFullGrid, nodefault};
	__property int ID = {read=FID, write=FID, nodefault};
public:
	/* TComponent.Create */ inline __fastcall virtual TGridPropIO(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TGridPropIO(void) { }
	
};


class DELPHICLASS TGridGraphicIO;
class PASCALIMPLEMENTATION TGridGraphicIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TCellGraphic* FCellGraphic;
	
public:
	__fastcall virtual TGridGraphicIO(Classes::TComponent* AOwner);
	__fastcall virtual ~TGridGraphicIO(void);
	
__published:
	__property TCellGraphic* CellGraphic = {read=FCellGraphic, write=FCellGraphic};
};


class DELPHICLASS TGridCellPropIO;
class PASCALIMPLEMENTATION TGridCellPropIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Basegrid::TCellProperties* FCellProperties;
	bool FHasGraphic;
	
public:
	__fastcall virtual TGridCellPropIO(Classes::TComponent* AOwner);
	__fastcall virtual ~TGridCellPropIO(void);
	
__published:
	__property Basegrid::TCellProperties* CellProperties = {read=FCellProperties, write=FCellProperties};
	__property bool HasGraphic = {read=FHasGraphic, write=FHasGraphic, nodefault};
};


class DELPHICLASS TGridCellIO;
class PASCALIMPLEMENTATION TGridCellIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	System::Word FRow;
	System::Word FCol;
	System::UnicodeString FCell;
	bool FHasProp;
	
public:
	__fastcall virtual TGridCellIO(Classes::TComponent* AOwner);
	__fastcall virtual ~TGridCellIO(void);
	
__published:
	__property System::Word Col = {read=FCol, write=FCol, nodefault};
	__property System::Word Row = {read=FRow, write=FRow, nodefault};
	__property System::UnicodeString Cell = {read=FCell, write=FCell};
	__property bool HasProp = {read=FHasProp, write=FHasProp, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
static const Word MAXCOLUMNS = 0x200;
static const Word RTF_TWIPS = 0x5a0;
static const ShortInt MAJ_VER = 0x5;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;
#define DATE_VER L"July, 2010"
extern PACKAGE System::Word CF_GRIDCELLS;
extern PACKAGE System::Word WM_GRIDEDITDONE;
extern PACKAGE Grids::TGridCoord __fastcall GridCoord(int x, int y);

}	/* namespace Advgrid */
using namespace Advgrid;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvgridHPP
