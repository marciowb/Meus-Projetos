// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Basegrid.pas' rev: 21.00

#ifndef BasegridHPP
#define BasegridHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Advobj.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Basegrid
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TColumnCalcType { acNONE, acSUM, acAVG, acCOUNT, acMIN, acMAX, acSPREAD, acCUSTOM };
#pragma option pop

class DELPHICLASS TCellProperties;
class DELPHICLASS TBaseGrid;
class PASCALIMPLEMENTATION TCellProperties : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TBaseGrid* FOwnerGrid;
	int FOwnerCol;
	int FOwnerRow;
	int FObject;
	System::TObject* FGraphicObject;
	Graphics::TBrushStyle FBrushStyle;
	Graphics::TColor FBrushColor;
	Graphics::TColor FBrushColorTo;
	int FFontSize;
	Graphics::TColor FFontColor;
	Graphics::TFontStyles FFontStyle;
	int FCellSpanY;
	int FCellSpanX;
	int FBorderWidth;
	Graphics::TColor FBorderColor;
	Classes::TAlignment FAlignment;
	Advobj::TVAlignment FVAlignment;
	int FPaintID;
	bool FWordWrap;
	bool FIsBaseCell;
	TColumnCalcType FCalcType;
	System::TObject* FCalcObject;
	int FNodeLevel;
	Advobj::TEditorType FEditor;
	System::UnicodeString FFontName;
	bool FReadOnly;
	Advobj::TCellGradientDirection FGradientDirection;
	Controls::TControl* FControl;
	void __fastcall SetBrushColor(const Graphics::TColor Value);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetVAlignment(const Advobj::TVAlignment Value);
	void __fastcall SetWordWrap(const bool Value);
	Types::TPoint __fastcall GetBaseCell(int c, int r);
	void __fastcall SetBrushColorTo(const Graphics::TColor Value);
	
protected:
	__property Types::TPoint BaseCell[int c][int r] = {read=GetBaseCell};
	__property int PaintID = {read=FPaintID, write=FPaintID, nodefault};
	__property System::TObject* GraphicObject = {read=FGraphicObject, write=FGraphicObject};
	
public:
	__property TColumnCalcType CalcType = {read=FCalcType, write=FCalcType, nodefault};
	__property System::TObject* CalcObject = {read=FCalcObject, write=FCalcObject};
	__fastcall TCellProperties(TBaseGrid* AOwner, int ACol, int ARow);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool IsBaseCell = {read=FIsBaseCell, write=FIsBaseCell, nodefault};
	__property int CellSpanX = {read=FCellSpanX, write=FCellSpanX, nodefault};
	__property int CellSpanY = {read=FCellSpanY, write=FCellSpanY, nodefault};
	__property int OwnerCol = {read=FOwnerCol, write=FOwnerCol, stored=false, nodefault};
	__property int OwnerRow = {read=FOwnerRow, write=FOwnerRow, stored=false, nodefault};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, nodefault};
	__property int BorderWidth = {read=FBorderWidth, write=FBorderWidth, nodefault};
	__property Graphics::TColor BrushColor = {read=FBrushColor, write=SetBrushColor, nodefault};
	__property Graphics::TColor BrushColorTo = {read=FBrushColorTo, write=SetBrushColorTo, nodefault};
	__property Graphics::TBrushStyle BrushStyle = {read=FBrushStyle, write=FBrushStyle, nodefault};
	__property int CellObject = {read=FObject, write=FObject, nodefault};
	__property Graphics::TColor FontColor = {read=FFontColor, write=FFontColor, nodefault};
	__property System::UnicodeString FontName = {read=FFontName, write=FFontName};
	__property int FontSize = {read=FFontSize, write=FFontSize, nodefault};
	__property Graphics::TFontStyles FontStyle = {read=FFontStyle, write=FFontStyle, nodefault};
	__property Advobj::TEditorType Editor = {read=FEditor, write=FEditor, nodefault};
	__property Advobj::TCellGradientDirection GradientDirection = {read=FGradientDirection, write=FGradientDirection, nodefault};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, nodefault};
	__property Advobj::TVAlignment VAlignment = {read=FVAlignment, write=SetVAlignment, nodefault};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, nodefault};
	__property int NodeLevel = {read=FNodeLevel, write=FNodeLevel, nodefault};
	__property Controls::TControl* Control = {read=FControl, write=FControl};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TCellProperties(void) { }
	
};


typedef void __fastcall (__closure *TGetDisplWideTextEvent)(System::TObject* Sender, int ACol, int ARow, System::WideString &Value);

class DELPHICLASS TUndoRedoItem;
class PASCALIMPLEMENTATION TUndoRedoItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FRow;
	int FCol;
	System::UnicodeString FValue;
	System::UnicodeString FOrigValue;
	bool FSequenceStart;
	bool FSequenceStop;
	
__published:
	__property System::UnicodeString Value = {read=FValue, write=FValue};
	__property System::UnicodeString OrigValue = {read=FOrigValue, write=FOrigValue};
	__property int Col = {read=FCol, write=FCol, nodefault};
	__property int Row = {read=FRow, write=FRow, nodefault};
	__property bool SequenceStart = {read=FSequenceStart, write=FSequenceStart, nodefault};
	__property bool SequenceStop = {read=FSequenceStop, write=FSequenceStop, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TUndoRedoItem(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TUndoRedoItem(void) { }
	
};


class DELPHICLASS TUndoRedoCollection;
class PASCALIMPLEMENTATION TUndoRedoCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	__fastcall TUndoRedoCollection(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TUndoRedoCollection(void) { }
	
};


typedef void __fastcall (__closure *TAdvGridUndoRedoEvent)(System::TObject* Sender, TBaseGrid* Grid, int Col, int Row, System::UnicodeString OrigValue, System::UnicodeString NewValue);

class DELPHICLASS TAdvGridUndoRedo;
class PASCALIMPLEMENTATION TAdvGridUndoRedo : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TUndoRedoCollection* FItems;
	TBaseGrid* FGrid;
	int FLevel;
	int FMaxLevel;
	TAdvGridUndoRedoEvent FOnUndo;
	TAdvGridUndoRedoEvent FOnRedo;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	__fastcall virtual TAdvGridUndoRedo(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvGridUndoRedo(void);
	virtual void __fastcall RegisterChange(int ACol, int ARow, System::UnicodeString OldValue, System::UnicodeString NewValue);
	virtual void __fastcall StartSequence(void);
	virtual void __fastcall StopSequence(void);
	__property int Level = {read=FLevel, write=FLevel, nodefault};
	__property TUndoRedoCollection* Items = {read=FItems, write=FItems};
	__property TBaseGrid* Grid = {read=FGrid, write=FGrid};
	void __fastcall Undo(void);
	void __fastcall Redo(void);
	void __fastcall Reset(void);
	bool __fastcall CanUndo(void);
	bool __fastcall CanRedo(void);
	
__published:
	__property int MaxLevel = {read=FMaxLevel, write=FMaxLevel, nodefault};
	__property TAdvGridUndoRedoEvent OnUndo = {read=FOnUndo, write=FOnUndo};
	__property TAdvGridUndoRedoEvent OnRedo = {read=FOnRedo, write=FOnRedo};
};


#pragma option push -b-
enum TGridSelectionStyle { ssDefault, ssVista, ssWin7, ssOffice2007 };
#pragma option pop

struct TCustomCellProps
{
	
public:
	Grids::TGridDrawState AState;
	bool Print;
	bool Select;
	bool Remap;
	Graphics::TBrush* ABrush;
	Graphics::TColor AColorTo;
	Graphics::TColor AMirrorColor;
	Graphics::TColor AMirrorColorTo;
	Graphics::TFont* AFont;
	Classes::TAlignment HA;
	Advobj::TVAlignment VA;
	bool WW;
	Advobj::TCellGradientDirection GD;
};


class PASCALIMPLEMENTATION TBaseGrid : public Advobj::TObjStringGrid
{
	typedef Advobj::TObjStringGrid inherited;
	
private:
	bool FDefaultDrawing;
	int FGridLineWidth;
	Graphics::TColor FGridLineColor;
	Graphics::TColor FGridFixedLineColor;
	int FPaintID;
	bool FCustomSelect;
	Advobj::TGetDisplTextEvent FOnGetDisplText;
	TGetDisplWideTextEvent FOnGetDisplWideText;
	bool FHideLastRow;
	int FNormalRowCount;
	TAdvGridUndoRedo* FUndoRedo;
	bool FWordWrap;
	bool FActiveRowShow;
	Graphics::TColor FActiveRowColor;
	TGridSelectionStyle FSelectionStyle;
	bool __fastcall GetDefaultDrawing(void);
	void __fastcall SetDefaultDrawing(const bool Value);
	int __fastcall GetGridLineWidth(void);
	HIDESBASE void __fastcall SetGridLineWidth(const int Value);
	void __fastcall SetGridLineColor(const Graphics::TColor Value);
	void __fastcall SetGridFixedLineColor(const Graphics::TColor Value);
	void __fastcall SetObjectEx(int c, int r, const System::TObject* Value);
	System::TObject* __fastcall GetObjectEx(int c, int r);
	System::UnicodeString __fastcall GetCellEx(int c, int r);
	void __fastcall SetCellEx(int c, int r, const System::UnicodeString Value);
	System::TObject* __fastcall GetGraphicObjectEx(int c, int r);
	void __fastcall SetGraphicObjectEx(int c, int r, const System::TObject* Value);
	void __fastcall RepaintFixedMergedCols(void);
	void __fastcall RepaintFixedMergedRows(void);
	System::TObject* __fastcall GetGridObject(int c, int r);
	void __fastcall SetGridObject(int c, int r, const System::TObject* Value);
	System::UnicodeString __fastcall GetGridCell(int c, int r);
	void __fastcall SetGridCell(int c, int r, const System::UnicodeString Value);
	void __fastcall SetUndoRedo(const TAdvGridUndoRedo* Value);
	void __fastcall SetActiveRowColor(const Graphics::TColor Value);
	void __fastcall SetSelectionStyle(const TGridSelectionStyle Value);
	void __fastcall SetActiveRowShow(const bool Value);
	
protected:
	int FHoverRowIdx;
	bool FHoverRow;
	Graphics::TColor FHoverRowColor;
	Graphics::TColor FHoverRowColorTo;
	bool FShowSelection;
	bool FHasCellProps;
	int FMergeCount;
	System::TObject* __fastcall GetCPGraphicObject(TCellProperties* cp);
	void __fastcall CopyRows(int ARow1, int ARow2);
	void __fastcall CopyCols(int ACol1, int ACol2);
	void __fastcall NilRow(int ARow);
	void __fastcall NilCol(int ACol);
	void __fastcall NilCell(int ACol, int ARow);
	void __fastcall SelectBaseCell(void);
	virtual bool __fastcall IsFixed(int ACol, int ARow);
	bool __fastcall IsSelected(int ACol, int ARow);
	virtual int __fastcall NodeIndent(int ARow);
	virtual bool __fastcall HasNodes(void);
	int __fastcall FixedColsWidth(void);
	int __fastcall FixedRowsHeight(void);
	DYNAMIC void __fastcall TopLeftChanged(void);
	virtual void __fastcall DrawCell(int ACol, int ARow, const Types::TRect &ARect, Grids::TGridDrawState AState);
	virtual void __fastcall DrawGridCell(Graphics::TCanvas* Canvas, int ACol, int ARow, const Types::TRect &ARect, Grids::TGridDrawState AState);
	bool __fastcall HasCellProperties(int ACol, int ARow);
	void __fastcall ClearProps(void);
	void __fastcall ClearPropCell(int ACol, int ARow);
	void __fastcall ClearPropRow(int ARow);
	void __fastcall ClearPropRect(int ACol1, int ARow1, int ACol2, int ARow2);
	virtual bool __fastcall SelectCell(int ACol, int ARow);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	virtual void __fastcall Paint(void);
	virtual void __fastcall FloatFooterUpdate(void);
	DYNAMIC void __fastcall SetEditText(int ACol, int ARow, const System::UnicodeString Value);
	DYNAMIC System::UnicodeString __fastcall GetEditText(int ACol, int ARow);
	bool __fastcall IsBaseCellEx(int ACol, int ARow, int &MCol, int &MRow);
	Types::TRect __fastcall GetCellRect(int c, int r);
	__property int PaintID = {read=FPaintID, nodefault};
	__property bool CustomSelect = {read=FCustomSelect, write=FCustomSelect, nodefault};
	__property bool HideLastRow = {read=FHideLastRow, write=FHideLastRow, nodefault};
	__property int NormalRowCount = {read=FNormalRowCount, write=FNormalRowCount, nodefault};
	__property System::TObject* GridObjects[int c][int r] = {read=GetGridObject, write=SetGridObject};
	virtual void __fastcall GetDisplText(int c, int r, System::UnicodeString &Value);
	virtual void __fastcall GetDisplWideText(int c, int r, System::WideString &Value);
	virtual void __fastcall GetDefaultProps(int ACol, int ARow, Graphics::TFont* AFont, Graphics::TBrush* ABrush, Graphics::TColor &AColorTo, Graphics::TColor &AMirrorColor, Graphics::TColor &AMirrorColorTo, Classes::TAlignment &HA, Advobj::TVAlignment &VA, bool &WW, Advobj::TCellGradientDirection &GD);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	virtual void __fastcall CellTextChange(int ACol, int ARow);
	virtual bool __fastcall HasCustomCellBorder(void);
	
public:
	__fastcall virtual TBaseGrid(Classes::TComponent* aOwner);
	__fastcall virtual ~TBaseGrid(void);
	TCellProperties* __fastcall GetCellProperties(int c, int r);
	void __fastcall SetCellProperties(int c, int r, const TCellProperties* Value);
	__property TCellProperties* CellProperties[int c][int r] = {read=GetCellProperties, write=SetCellProperties};
	__property TGridSelectionStyle SelectionStyle = {read=FSelectionStyle, write=SetSelectionStyle, nodefault};
	virtual void __fastcall GetVisualProperties(int ACol, int ARow, Grids::TGridDrawState &AState, bool Print, bool Select, bool Remap, Graphics::TBrush* ABrush, Graphics::TColor &AColorTo, Graphics::TColor &AMirrorColor, Graphics::TColor &AMirrorColorTo, Graphics::TFont* AFont, Classes::TAlignment &HA, Advobj::TVAlignment &VA, bool &WW, Advobj::TCellGradientDirection &GD);
	HIDESBASE Types::TRect __fastcall CellRect(int c, int r);
	Types::TPoint __fastcall CellSize(int c, int r);
	virtual int __fastcall DisplColIndex(int ACol);
	bool __fastcall IsBaseCell(int ACol, int ARow);
	bool __fastcall IsMergedCell(int ACol, int ARow);
	bool __fastcall IsMergedNonBaseCell(int ACol, int ARow);
	bool __fastcall IsXMergedCell(int ACol, int ARow);
	bool __fastcall IsYMergedCell(int ACol, int ARow);
	Types::TPoint __fastcall BaseCell(int ACol, int ARow);
	Types::TRect __fastcall FullCell(int c, int r);
	Types::TPoint __fastcall CellSpan(int ACol, int ARow);
	Types::TPoint __fastcall CellExt(int ACol, int ARow);
	int __fastcall MinRowSpan(int ARow);
	int __fastcall MaxRowSpan(int ARow);
	bool __fastcall RowSpanIdentical(int ARow1, int ARow2);
	bool __fastcall ColSpanIdentical(int ACol1, int ACol2);
	virtual void __fastcall MergeCells(int c, int r, int spanx, int spany);
	virtual void __fastcall SplitCells(int c, int r);
	void __fastcall RepaintCell(int c, int r);
	__property System::TObject* Objects[int c][int r] = {read=GetObjectEx, write=SetObjectEx};
	__property System::TObject* GraphicObjects[int c][int r] = {read=GetGraphicObjectEx, write=SetGraphicObjectEx};
	__property System::UnicodeString Cells[int c][int r] = {read=GetCellEx, write=SetCellEx};
	__property System::UnicodeString GridCells[int c][int r] = {read=GetGridCell, write=SetGridCell};
	__property bool WordWrap = {read=FWordWrap, write=FWordWrap, nodefault};
	
__published:
	__property bool ActiveRowShow = {read=FActiveRowShow, write=SetActiveRowShow, default=0};
	__property Graphics::TColor ActiveRowColor = {read=FActiveRowColor, write=SetActiveRowColor, default=-16777192};
	__property bool DefaultDrawing = {read=GetDefaultDrawing, write=SetDefaultDrawing, default=0};
	__property int GridLineWidth = {read=GetGridLineWidth, write=SetGridLineWidth, default=1};
	__property Graphics::TColor GridLineColor = {read=FGridLineColor, write=SetGridLineColor, default=12632256};
	__property Graphics::TColor GridFixedLineColor = {read=FGridFixedLineColor, write=SetGridFixedLineColor, default=8421504};
	__property bool HoverRow = {read=FHoverRow, write=FHoverRow, default=0};
	__property Graphics::TColor HoverRowColor = {read=FHoverRowColor, write=FHoverRowColor, default=-16777192};
	__property Graphics::TColor HoverRowColorTo = {read=FHoverRowColorTo, write=FHoverRowColorTo, default=536870911};
	__property Advobj::TGetDisplTextEvent OnGetDisplText = {read=FOnGetDisplText, write=FOnGetDisplText};
	__property TGetDisplWideTextEvent OnGetDisplWideText = {read=FOnGetDisplWideText, write=FOnGetDisplWideText};
	__property TAdvGridUndoRedo* UndoRedo = {read=FUndoRedo, write=SetUndoRedo};
public:
	/* TWinControl.CreateParented */ inline __fastcall TBaseGrid(HWND ParentWindow) : Advobj::TObjStringGrid(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Basegrid */
using namespace Basegrid;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// BasegridHPP
