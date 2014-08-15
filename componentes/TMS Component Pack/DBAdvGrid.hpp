// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvgrid.pas' rev: 21.00

#ifndef DbadvgridHPP
#define DbadvgridHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Basegrid.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Advutil.hpp>	// Pascal unit
#include <Dbtables.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Advobj.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit
#include <Widestrings.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvgrid
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvGridDataLink;
class DELPHICLASS TDBAdvGrid;
class PASCALIMPLEMENTATION TAdvGridDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	typedef DynamicArray<int> _TAdvGridDataLink__1;
	
	
private:
	TDBAdvGrid* FGrid;
	int FFieldCount;
	_TAdvGridDataLink__1 FFieldMap;
	bool FModified;
	bool FInUpdateData;
	bool FSparseMap;
	bool FLockEffects;
	bool __fastcall GetDefaultFields(void);
	Db::TField* __fastcall GetFields(int I);
	
protected:
	virtual void __fastcall ActiveChanged(void);
	void __fastcall BuildAggMap(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall DataSetScrolled(int Distance);
	virtual void __fastcall FocusControl(Db::TFieldRef Field);
	virtual void __fastcall EditingChanged(void);
	virtual bool __fastcall IsAggRow(int Value);
	virtual void __fastcall LayoutChanged(void);
	virtual void __fastcall RecordChanged(Db::TField* Field);
	virtual void __fastcall UpdateData(void);
	int __fastcall GetMappedIndex(int ColIndex);
	
public:
	__fastcall TAdvGridDataLink(TDBAdvGrid* AGrid);
	__fastcall virtual ~TAdvGridDataLink(void);
	bool __fastcall AddMapping(const System::UnicodeString FieldName);
	void __fastcall ClearMapping(void);
	void __fastcall Modified(void);
	void __fastcall Reset(void);
	__property bool DefaultFields = {read=GetDefaultFields, nodefault};
	__property int FieldCount = {read=FFieldCount, nodefault};
	__property Db::TField* Fields[int I] = {read=GetFields};
	__property bool SparseMap = {read=FSparseMap, write=FSparseMap, nodefault};
	__property TDBAdvGrid* Grid = {read=FGrid};
};


#pragma option push -b-
enum TColumnPopupType { cpFixedCellsRClick, cpFixedCellsLClick, cpNormalCellsRClick, cpNormalCellsLClick, cpAllCellsRClick, cpAllCellsLClick };
#pragma option pop

class DELPHICLASS TDBGridColumnItem;
class PASCALIMPLEMENTATION TDBGridColumnItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Db::TField* FField;
	System::UnicodeString FFieldName;
	int FWidth;
	Classes::TAlignment FAlignment;
	System::UnicodeString FColumnHeader;
	Advobj::TSortStyle FSortStyle;
	System::UnicodeString FSortPrefix;
	System::UnicodeString FSortSuffix;
	System::UnicodeString FEditMask;
	int FEditLength;
	Advgrid::TEditLink* FEditLink;
	Graphics::TFont* FFont;
	Graphics::TColor FColor;
	Advobj::TEditorType FEditorType;
	bool FFixed;
	bool FReadOnly;
	Classes::TStringList* FComboItems;
	int FSpinMin;
	int FSpinMax;
	int FSpinStep;
	bool FPassword;
	Graphics::TFont* FPrintFont;
	Graphics::TColor FPrintColor;
	Advobj::TCellBorders FBorders;
	Graphics::TPen* FBorderPen;
	Advobj::TCellBorders FPrintBorders;
	Graphics::TPen* FPrintBorderPen;
	int FTag;
	int FDefIdx;
	System::UnicodeString FName;
	System::UnicodeString FCheckFalse;
	System::UnicodeString FCheckTrue;
	bool FShowBands;
	Classes::TStringList* FFilter;
	int FMaxSize;
	int FMinSize;
	int FAutoMinSize;
	int FAutoMaxSize;
	TColumnPopupType FColumnPopupType;
	Menus::TPopupMenu* FColumnPopup;
	bool FFilterCaseSensitive;
	System::UnicodeString FFloatFormat;
	bool FPictureField;
	bool FCheckBoxField;
	bool FProgressField;
	bool FDataImageField;
	Graphics::TColor FProgressColor;
	Graphics::TColor FProgressBKColor;
	Graphics::TColor FProgressTextColor;
	Graphics::TColor FProgressTextBKColor;
	System::UnicodeString FHTMLTemplate;
	Classes::TAlignment FHeaderAlignment;
	Graphics::TFont* FHeaderFont;
	bool FShowUnicode;
	Advgrid::TStretchMode FPictureStretch;
	bool FUseLookupEditor;
	void __fastcall SetWidth(const int Value);
	int __fastcall GetWidth(void);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetHeaderAlignment(const Classes::TAlignment Value);
	void __fastcall SetColumnHeader(const System::UnicodeString Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFixed(const bool Value);
	void __fastcall SetPassword(const bool Value);
	void __fastcall SetComboItems(const Classes::TStringList* Value);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall PenChanged(System::TObject* Sender);
	void __fastcall SetBorders(const Advobj::TCellBorders Value);
	void __fastcall SetBorderPen(const Graphics::TPen* Value);
	System::UnicodeString __fastcall GetRows(int idx);
	void __fastcall SetRows(int idx, const System::UnicodeString Value);
	System::TDateTime __fastcall GetDates(int idx);
	double __fastcall GetFloats(int idx);
	int __fastcall GetInts(int idx);
	void __fastcall SetDates(int idx, const System::TDateTime Value);
	void __fastcall SetFloats(int idx, const double Value);
	void __fastcall SetInts(int idx, const int Value);
	System::TDateTime __fastcall GetTimes(int idx);
	void __fastcall SetTimes(int idx, const System::TDateTime Value);
	void __fastcall SetEditorType(const Advobj::TEditorType Value);
	void __fastcall SetShowBands(const bool Value);
	void __fastcall SetFilter(const Classes::TStringList* Value);
	void __fastcall FilterChanged(System::TObject* Sender);
	void __fastcall SetFloatFormat(const System::UnicodeString Value);
	Db::TField* __fastcall GetField(void);
	virtual void __fastcall SetField(Db::TField* Value);
	void __fastcall SetFieldName(const System::UnicodeString Value);
	void __fastcall SetPictureField(const bool Value);
	void __fastcall SetCheckBoxField(const bool Value);
	void __fastcall SetProgressField(const bool Value);
	void __fastcall SetProgressColor(const Graphics::TColor Value);
	void __fastcall SetProgressBKColor(const Graphics::TColor Value);
	void __fastcall SetProgressTextColor(const Graphics::TColor Value);
	void __fastcall SetProgressTextBKColor(const Graphics::TColor Value);
	void __fastcall SetDataImageField(const bool Value);
	void __fastcall SetHTMLTemplate(const System::UnicodeString Value);
	void __fastcall SetHeaderFont(const Graphics::TFont* Value);
	void __fastcall SetPrintFont(const Graphics::TFont* Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	TDBAdvGrid* __fastcall GetGrid(void);
	virtual void __fastcall SetIndex(int Value);
	
public:
	__fastcall virtual TDBGridColumnItem(Classes::TCollection* Collection);
	__fastcall virtual ~TDBGridColumnItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AssignVisuals(Classes::TPersistent* Source);
	__property int DefIdx = {read=FDefIdx, write=FDefIdx, nodefault};
	__property System::UnicodeString Rows[int idx] = {read=GetRows, write=SetRows};
	__property int Ints[int idx] = {read=GetInts, write=SetInts};
	__property double Floats[int idx] = {read=GetFloats, write=SetFloats};
	__property System::TDateTime Dates[int idx] = {read=GetDates, write=SetDates};
	__property System::TDateTime Times[int idx] = {read=GetTimes, write=SetTimes};
	__property Db::TField* Field = {read=GetField, write=SetField};
	
__published:
	__property int AutoMinSize = {read=FAutoMinSize, write=FAutoMinSize, default=0};
	__property int AutoMaxSize = {read=FAutoMaxSize, write=FAutoMaxSize, default=0};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Advobj::TCellBorders Borders = {read=FBorders, write=SetBorders, nodefault};
	__property Graphics::TPen* BorderPen = {read=FBorderPen, write=SetBorderPen};
	__property bool CheckBoxField = {read=FCheckBoxField, write=SetCheckBoxField, default=0};
	__property System::UnicodeString CheckFalse = {read=FCheckFalse, write=FCheckFalse};
	__property System::UnicodeString CheckTrue = {read=FCheckTrue, write=FCheckTrue};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Menus::TPopupMenu* ColumnPopup = {read=FColumnPopup, write=FColumnPopup};
	__property TColumnPopupType ColumnPopupType = {read=FColumnPopupType, write=FColumnPopupType, default=0};
	__property Classes::TStringList* ComboItems = {read=FComboItems, write=SetComboItems};
	__property bool DataImageField = {read=FDataImageField, write=SetDataImageField, default=0};
	__property int EditLength = {read=FEditLength, write=FEditLength, default=0};
	__property Advgrid::TEditLink* EditLink = {read=FEditLink, write=FEditLink};
	__property System::UnicodeString EditMask = {read=FEditMask, write=FEditMask};
	__property Advobj::TEditorType Editor = {read=FEditorType, write=SetEditorType, default=0};
	__property System::UnicodeString FieldName = {read=FFieldName, write=SetFieldName};
	__property Classes::TStringList* Filter = {read=FFilter, write=SetFilter};
	__property bool FilterCaseSensitive = {read=FFilterCaseSensitive, write=FFilterCaseSensitive, default=0};
	__property bool Fixed = {read=FFixed, write=SetFixed, default=0};
	__property System::UnicodeString FloatFormat = {read=FFloatFormat, write=SetFloatFormat};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::UnicodeString Header = {read=FColumnHeader, write=SetColumnHeader};
	__property Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetHeaderFont};
	__property Classes::TAlignment HeaderAlignment = {read=FHeaderAlignment, write=SetHeaderAlignment, default=0};
	__property System::UnicodeString HTMLTemplate = {read=FHTMLTemplate, write=SetHTMLTemplate};
	__property int MinSize = {read=FMinSize, write=FMinSize, default=0};
	__property int MaxSize = {read=FMaxSize, write=FMaxSize, default=0};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property bool Password = {read=FPassword, write=SetPassword, default=0};
	__property bool PictureField = {read=FPictureField, write=SetPictureField, default=0};
	__property Advgrid::TStretchMode PictureStretch = {read=FPictureStretch, write=FPictureStretch, default=2};
	__property Advobj::TCellBorders PrintBorders = {read=FPrintBorders, write=FPrintBorders, nodefault};
	__property Graphics::TPen* PrintBorderPen = {read=FPrintBorderPen, write=FPrintBorderPen};
	__property Graphics::TColor PrintColor = {read=FPrintColor, write=FPrintColor, default=16777215};
	__property Graphics::TFont* PrintFont = {read=FPrintFont, write=SetPrintFont};
	__property Graphics::TColor ProgressColor = {read=FProgressColor, write=SetProgressColor, default=255};
	__property Graphics::TColor ProgressBKColor = {read=FProgressBKColor, write=SetProgressBKColor, default=16777215};
	__property Graphics::TColor ProgressTextColor = {read=FProgressTextColor, write=SetProgressTextColor, default=16777215};
	__property Graphics::TColor ProgressTextBKColor = {read=FProgressTextBKColor, write=SetProgressTextBKColor, default=255};
	__property bool ProgressField = {read=FProgressField, write=SetProgressField, default=0};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property bool ShowBands = {read=FShowBands, write=SetShowBands, default=0};
	__property bool ShowUnicode = {read=FShowUnicode, write=FShowUnicode, default=0};
	__property Advobj::TSortStyle SortStyle = {read=FSortStyle, write=FSortStyle, default=0};
	__property System::UnicodeString SortPrefix = {read=FSortPrefix, write=FSortPrefix};
	__property System::UnicodeString SortSuffix = {read=FSortSuffix, write=FSortSuffix};
	__property int SpinMax = {read=FSpinMax, write=FSpinMax, default=0};
	__property int SpinMin = {read=FSpinMin, write=FSpinMin, default=0};
	__property int SpinStep = {read=FSpinStep, write=FSpinStep, default=1};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property bool UseLookupEditor = {read=FUseLookupEditor, write=FUseLookupEditor, default=1};
	__property int Width = {read=GetWidth, write=SetWidth, default=50};
};


class DELPHICLASS TDBGridColumnCollection;
class PASCALIMPLEMENTATION TDBGridColumnCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TDBGridColumnItem* operator[](int Index) { return Items[Index]; }
	
private:
	TDBAdvGrid* FOwner;
	bool FNoRecursiveUpdate;
	HIDESBASE TDBGridColumnItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TDBGridColumnItem* Value);
	
protected:
	virtual void __fastcall Notify(Classes::TCollectionItem* Item, Classes::TCollectionNotification Action);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property TDBAdvGrid* Grid = {read=FOwner};
	
public:
	bool __fastcall HasFieldsDefined(void);
	virtual Classes::TCollectionItemClass __fastcall GetItemClass(void);
	HIDESBASE TDBGridColumnItem* __fastcall Add(void);
	HIDESBASE TDBGridColumnItem* __fastcall Insert(int index);
	__property TDBGridColumnItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__fastcall TDBGridColumnCollection(TDBAdvGrid* AOwner);
	void __fastcall SetOrganization(void);
	void __fastcall ResetOrganization(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TDBGridColumnCollection(void) { }
	
};


typedef void __fastcall (__closure *TSetQueryOrderEvent)(System::TObject* Sender, System::UnicodeString &SQL);

typedef void __fastcall (__closure *TGetRecordCountEvent)(System::TObject* Sender, int &Count);

typedef void __fastcall (__closure *TGetHTMLTemplateDataEvent)(System::TObject* Sender, int ACol, int ARow, System::UnicodeString Fieldname, System::UnicodeString &Data);

typedef void __fastcall (__closure *TDBColumnPopupEvent)(System::TObject* Sender, int ACol, int ARow, Menus::TPopupMenu* PopupMenu);

typedef void __fastcall (__closure *TInvalidPictureEvent)(System::TObject* Sender, int ACol, int ARow);

typedef void __fastcall (__closure *TFieldToStreamEvent)(System::TObject* Sender, int ACol, int ARow, Db::TField* DBField, Classes::TMemoryStream* MS);

#pragma option push -b-
enum TDataSetType { dtSequenced, dtNonSequenced };
#pragma option pop

#pragma option push -b-
enum TEditPostMode { epCell, epRow };
#pragma option pop

class PASCALIMPLEMENTATION TDBAdvGrid : public Advgrid::TAdvStringGrid
{
	typedef Advgrid::TAdvStringGrid inherited;
	
private:
	TDBGridColumnCollection* FColumnCollection;
	TAdvGridDataLink* FDataLink;
	bool FInternalCall;
	bool FDoNotUpdateMe;
	Advgrid::TCellGraphic* FCellGraphic;
	Advgrid::TRowChangedEvent FOnRowChanged;
	bool FShowMemoFields;
	Advgrid::TCellValidateEvent FOnCellValidate;
	Advgrid::TCellValidateWideEvent FOnCellValidateWide;
	Advobj::TCanSortEvent FOnCanSort;
	TSetQueryOrderEvent FOnSetQueryOrder;
	Db::TDataSetState FOldState;
	bool FRecordChanged;
	bool FShowDefinedFields;
	bool FInternalInsert;
	bool FShowDBIndicator;
	Sysutils::TBytes FOldPosition;
	bool FEmptyDataSet;
	bool FOldIsBOF;
	bool FOldIsEOF;
	bool FCancelEditReturn;
	bool FDoNotCountRow;
	TGetRecordCountEvent FOnGetRecordCount;
	bool FShowBooleanFields;
	bool FShowPictureFields;
	bool FNotDeletionUpdate;
	Graphics::TPicture* FPicture;
	bool FPageMode;
	Classes::TList* FPictureList;
	bool FRefreshOnDelete;
	bool FUpdateCancel;
	bool FNewRecord;
	bool FRefreshOnInsert;
	Classes::TStringList* FLookupKeys;
	int FVisibleFieldCount;
	TDataSetType FDataSetType;
	int FExportRow;
	bool FSelExport;
	bool FSelImport;
	int FSelRow;
	Sysutils::TBytes FImportPos;
	bool FNewAppendRecord;
	TGetHTMLTemplateDataEvent FOnGetHTMLTemplateData;
	bool FKeyDownAppend;
	bool FMouseWheelScrolling;
	bool FMouseWheelScrolled;
	int FLastDesignChoice;
	Advgrid::TRowChangingEvent FOnRowChanging;
	bool FFilteredDataSet;
	TDataSetType FOldDataSetType;
	Grids::TGetEditEvent FOnGetEditText;
	bool FShowUnicode;
	bool FInternalSelection;
	bool FDatasetTypeAuto;
	TEditPostMode FEditPostMode;
	int FEditRec;
	Classes::TStringList* FEditRecData;
	Db::TDataSetState FOldEditingState;
	bool FEditUpdating;
	System::UnicodeString FEditText;
	System::WideString FEditWideText;
	bool FDoNotCallSelect;
	bool FDoNotBounsBack;
	int FOldAR;
	int FOldTopRow;
	bool FAppending;
	bool FAppendOperation;
	bool FExporting;
	bool FEditEnding;
	bool FOldFoaterEnableCalc;
	bool FAllowRowChange;
	int FMustEnableControls;
	bool FAutoCreateColumns;
	bool FAutoRemoveColumns;
	TDBColumnPopupEvent FOnColumnPopup;
	bool FInternalMove;
	bool FBlockCallBack;
	bool FShouldNotPostChanges;
	Graphics::TPicture* FInvalidPicture;
	TInvalidPictureEvent FOnInvalidPicture;
	TFieldToStreamEvent FOnFieldToStream;
	bool FShowBlankRow;
	int FExportStartRow;
	bool FUseDBFieldWidths;
	void __fastcall DataUpdate(void);
	void __fastcall DataChange(void);
	void __fastcall ActiveChange(bool Value);
	void __fastcall RecordChanged(Db::TField* Field);
	void __fastcall EditingChanged(void);
	void __fastcall UpdateRowCount(void);
	bool __fastcall CheckDataSet(void);
	void __fastcall UpdateScrollBar(int distance);
	void __fastcall UpdateVisibleFields(void);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	Db::TDataSource* __fastcall GetDataSource(void);
	HIDESBASE bool __fastcall GetReadOnly(void);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	HIDESBASE void __fastcall SetReadOnly(const bool Value);
	void __fastcall SyncActiveRec(void);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &WMScroll);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	void __fastcall GetEditTextEvent(System::TObject* Sender, int ACol, int ARow, System::UnicodeString &Value);
	void __fastcall RowChangingEvent(System::TObject* Sender, int OldRow, int NewRow, bool &Allow);
	void __fastcall RowUpdateEvent(System::TObject* Sender, int OldRow, int NewRow);
	int __fastcall GetFieldCount(void);
	Db::TField* __fastcall GetFields(int FieldIndex);
	void __fastcall SynchColumns(void);
	void __fastcall SetColumnCollection(const TDBGridColumnCollection* Value);
	int __fastcall GetColCount(void);
	HIDESBASE void __fastcall SetColCount(const int Value);
	void __fastcall SetShowMemoFields(const bool Value);
	void __fastcall CellValidateEvent(System::TObject* Sender, int ACol, int ARow, System::UnicodeString &Value, bool &Valid);
	void __fastcall CellValidateWideEvent(System::TObject* Sender, int ACol, int ARow, System::WideString &Value, bool &Valid);
	void __fastcall CanSortEvent(System::TObject* Sender, int ACol, bool &DoSort);
	void __fastcall SetShowDBIndicator(const bool Value);
	void __fastcall SetShowBooleanFields(const bool Value);
	void __fastcall SetShowPictureFields(const bool Value);
	Db::TField* __fastcall GetDBFieldAtColumn(int ACol);
	Db::TField* __fastcall GetSelectedField(void);
	int __fastcall GetDBFieldIndexAtColumn(int ACol);
	HIDESBASE int __fastcall GetFixedRowsEx(void);
	HIDESBASE void __fastcall SetFixedRowsEx(const int Value);
	System::UnicodeString __fastcall HTMLDBReplace(System::UnicodeString s, Db::TDataSet* dataset, int ACol, int ARow);
	void __fastcall LoadFromDataSet(void);
	void __fastcall RemoveAllPictures(void);
	void __fastcall RemoveAllBooleanCheckBoxes(void);
	void __fastcall RemoveAllStringCheckBoxes(void);
	void __fastcall RemoveAllGraphics(void);
	void __fastcall RemoveAllCellValues(void);
	void __fastcall SetPageMode(const bool Value);
	void __fastcall SetDataSetType(const TDataSetType Value);
	int __fastcall GetDBRow(void);
	void __fastcall SetDBRow(const int Value);
	HIDESBASE int __fastcall MouseOverDesignChoice(int X, int Y);
	void __fastcall DesignerUpdate(void);
	TDBGridColumnItem* __fastcall GetColumnByName(System::UnicodeString AValue);
	TDBGridColumnItem* __fastcall GetColumnByFieldName(System::UnicodeString AValue);
	void __fastcall SetDatasetTypeAuto(const bool Value);
	void __fastcall SetEditPostMode(const TEditPostMode Value);
	void __fastcall SetAutoCreateColumns(const bool Value);
	void __fastcall SetAutoRemoveColumns(const bool Value);
	void __fastcall SetInvalidPicture(const Graphics::TPicture* Value);
	void __fastcall SetShowBlankRow(const bool Value);
	bool __fastcall CanShowBlankRow(void);
	
protected:
	virtual bool __fastcall CanEditShow(void);
	DYNAMIC bool __fastcall CanEditModify(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	HIDESBASE void __fastcall DoKeyDown(System::Word Key, Classes::TShiftState Shift);
	bool __fastcall DBWheelUp(void);
	bool __fastcall DBWheelDown(void);
	virtual void __fastcall DirectWheelChange(int delta, bool &SuppressMsg);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	virtual void __fastcall DoCanEditCell(int ACol, int ARow, bool &CanEdit);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual bool __fastcall SelectCell(int ACol, int ARow);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual bool __fastcall CanModify(void);
	virtual int __fastcall GetRecordCount(void);
	virtual System::UnicodeString __fastcall GetCurrentCell(void);
	virtual void __fastcall GetDisplText(int c, int r, System::UnicodeString &Value);
	virtual void __fastcall DrawCell(int ACol, int ARow, const Types::TRect &ARect, Grids::TGridDrawState AState);
	virtual void __fastcall Scroll(int Distance);
	DYNAMIC void __fastcall TopLeftChanged(void);
	DYNAMIC void __fastcall ColumnMoved(int FromIndex, int ToIndex);
	virtual void __fastcall Loaded(void);
	virtual TDBGridColumnCollection* __fastcall CreateColumns(void);
	DYNAMIC void __fastcall ColWidthsChanged(void);
	virtual void __fastcall GetCellAlign(int ACol, int ARow, Classes::TAlignment &HAlign, Advobj::TVAlignment &VAlign);
	virtual void __fastcall GetCellBorder(int ACol, int ARow, Graphics::TPen* APen, Advobj::TCellBorders &borders);
	virtual void __fastcall GetCellPrintBorder(int ACol, int ARow, Graphics::TPen* APen, Advobj::TCellBorders &borders);
	virtual void __fastcall GetCellPrintColor(int ACol, int ARow, Grids::TGridDrawState AState, Graphics::TBrush* ABrush, Graphics::TFont* AFont);
	virtual void __fastcall GetCellColor(int ACol, int ARow, Grids::TGridDrawState AState, Graphics::TBrush* ABrush, Graphics::TFont* AFont);
	virtual bool __fastcall HasCombo(int ACol, int ARow);
	virtual void __fastcall GetStaticCellEditor(int ACol, int ARow, Advobj::TEditorType &AEditor);
	virtual void __fastcall GetCellEditor(int ACol, int ARow, Advobj::TEditorType &AEditor);
	virtual bool __fastcall GetEditorNone(int ACol, int ARow);
	virtual void __fastcall GetCellFixed(int ACol, int ARow, bool &IsFixed);
	virtual void __fastcall GetCellPassword(int ACol, int ARow, bool &IsPassword);
	virtual void __fastcall GetColFormat(int ACol, Advobj::TSortStyle &ASortStyle, System::UnicodeString &aPrefix, System::UnicodeString &aSuffix);
	DYNAMIC int __fastcall GetEditLimit(void);
	DYNAMIC System::UnicodeString __fastcall GetEditMask(int ACol, int ARow);
	virtual Advgrid::TCellGraphic* __fastcall GetCellGraphic(int ACol, int ARow);
	virtual Advgrid::TCellType __fastcall GetCellType(int ACol, int ARow);
	virtual System::UnicodeString __fastcall GetCheckFalse(int ACol, int ARow);
	virtual System::UnicodeString __fastcall GetCheckTrue(int ACol, int ARow);
	virtual bool __fastcall GetFilter(int ACol);
	virtual void __fastcall UpdateColSize(int ACol, int &NewWidth);
	virtual void __fastcall UpdateAutoColSize(int ACol, int &NewWidth);
	virtual void __fastcall UpdateColHeaders(void);
	virtual System::UnicodeString __fastcall GetFormattedCell(int ACol, int ARow);
	DYNAMIC void __fastcall SetEditText(int ACol, int ARow, const System::UnicodeString Value);
	DYNAMIC System::UnicodeString __fastcall GetEditText(int ACol, int ARow);
	virtual void __fastcall GetCellReadOnly(int ACol, int ARow, bool &IsReadOnly);
	virtual bool __fastcall ToggleCheck(int ACol, int ARow, bool FromEdit);
	virtual void __fastcall PasteInCell(int ACol, int ARow, System::UnicodeString Value);
	virtual void __fastcall DoAppendRow(void);
	void __fastcall RemoveStringCheckBox(int ACol);
	void __fastcall AddStringCheckBox(int ACol);
	virtual void __fastcall QueryAddRow(bool &AllowAdd);
	void __fastcall LoadLookupList(Db::TField* fld, Classes::TStrings* list);
	void __fastcall LoadWideLookupList(Db::TField* fld, Widestrings::TWideStrings* list);
	System::UnicodeString __fastcall GetLookupKey(int i);
	__property TAdvGridDataLink* DataLink = {read=FDataLink};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	virtual void __fastcall UpdateOnSelection(Grids::TGridRect &GR);
	virtual void __fastcall UpdateSelectionRect(Grids::TGridRect &GR);
	void __fastcall BlobFieldToStream(Db::TBlobField* DBField, Types::TPoint &size, int Col, int Row);
	virtual void __fastcall TabToNextRowAtEnd(void);
	virtual void __fastcall OnMouseActionsChanged(System::TObject* Sender);
	virtual void __fastcall EditKeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Edit_WMKeyDown(Messages::TWMKey &Msg);
	virtual void __fastcall OnNavigationChanged(System::TObject* Sender);
	virtual bool __fastcall DoAllowFmtPaste(void);
	virtual void __fastcall DoInvalidPicture(int Col, int Row);
	virtual void __fastcall PaintDesigner(void);
	virtual void __fastcall HandleDesignChoice(int X, int Y);
	
public:
	__fastcall virtual TDBAdvGrid(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvGrid(void);
	virtual void __fastcall AssignCells(Classes::TPersistent* Source);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property TDBGridColumnItem* ColumnByName[System::UnicodeString AValue] = {read=GetColumnByName};
	__property TDBGridColumnItem* ColumnByFieldName[System::UnicodeString AValue] = {read=GetColumnByFieldName};
	virtual bool __fastcall ValidateCell(const System::UnicodeString NewValue);
	virtual void __fastcall ExportNotification(Advgrid::TGridExportState state, int ARow);
	virtual void __fastcall ImportNotification(Advgrid::TGridImportState AState, int ARow);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	__property int FieldCount = {read=GetFieldCount, nodefault};
	__property Db::TField* Fields[int FieldIndex] = {read=GetFields};
	void __fastcall AddAllFields(void);
	void __fastcall RemoveAllFields(void);
	void __fastcall RemoveAllColumns(void);
	void __fastcall SaveColumnPositions(System::UnicodeString Key, System::UnicodeString Section);
	void __fastcall LoadColumnPositions(System::UnicodeString Key, System::UnicodeString Section);
	virtual void __fastcall LoadColPositions(void);
	virtual void __fastcall SaveColPositions(void);
	void __fastcall UpdateActive(void);
	void __fastcall Reload(void);
	void __fastcall UpdateDisplay(void);
	__property int Row = {read=GetDBRow, write=SetDBRow, nodefault};
	__property Db::TField* SelectedField = {read=GetSelectedField};
	__property Db::TField* FieldAtColumn[int ACol] = {read=GetDBFieldAtColumn};
	__property int FieldIndexAtColumn[int Acol] = {read=GetDBFieldIndexAtColumn};
	__property bool ShowBlankRow = {read=FShowBlankRow, write=SetShowBlankRow, default=1};
	
__published:
	__property bool AutoCreateColumns = {read=FAutoCreateColumns, write=SetAutoCreateColumns, nodefault};
	__property bool AutoRemoveColumns = {read=FAutoRemoveColumns, write=SetAutoRemoveColumns, nodefault};
	__property TDBGridColumnCollection* Columns = {read=FColumnCollection, write=SetColumnCollection};
	__property int ColCount = {read=GetColCount, write=SetColCount, nodefault};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool DatasetTypeAuto = {read=FDatasetTypeAuto, write=SetDatasetTypeAuto, default=1};
	__property TDataSetType DataSetType = {read=FDataSetType, write=SetDataSetType, default=0};
	__property TEditPostMode EditPostMode = {read=FEditPostMode, write=SetEditPostMode, default=0};
	__property int FixedRows = {read=GetFixedRowsEx, write=SetFixedRowsEx, nodefault};
	__property bool PageMode = {read=FPageMode, write=SetPageMode, default=1};
	__property Graphics::TPicture* InvalidPicture = {read=FInvalidPicture, write=SetInvalidPicture};
	__property bool RefreshOnDelete = {read=FRefreshOnDelete, write=FRefreshOnDelete, default=0};
	__property bool RefreshOnInsert = {read=FRefreshOnInsert, write=FRefreshOnInsert, default=0};
	__property bool ShowDBIndicator = {read=FShowDBIndicator, write=SetShowDBIndicator, default=1};
	__property bool ShowMemoFields = {read=FShowMemoFields, write=SetShowMemoFields, default=0};
	__property bool ShowBooleanFields = {read=FShowBooleanFields, write=SetShowBooleanFields, default=0};
	__property bool ShowPictureFields = {read=FShowPictureFields, write=SetShowPictureFields, default=0};
	__property bool ShowUnicode = {read=FShowUnicode, write=FShowUnicode, nodefault};
	__property bool UseDBFieldWidths = {read=FUseDBFieldWidths, write=FUseDBFieldWidths, default=0};
	__property Advgrid::TRowChangingEvent OnRowChanging = {read=FOnRowChanging, write=FOnRowChanging};
	__property Advgrid::TRowChangedEvent OnRowUpdate = {read=FOnRowChanged, write=FOnRowChanged};
	__property Advgrid::TCellValidateEvent OnCellValidate = {read=FOnCellValidate, write=FOnCellValidate};
	__property Advgrid::TCellValidateWideEvent OnCellValidateWide = {read=FOnCellValidateWide, write=FOnCellValidateWide};
	__property Advobj::TCanSortEvent OnCanSort = {read=FOnCanSort, write=FOnCanSort};
	__property TDBColumnPopupEvent OnColumnPopup = {read=FOnColumnPopup, write=FOnColumnPopup};
	__property TSetQueryOrderEvent OnSetQueryOrder = {read=FOnSetQueryOrder, write=FOnSetQueryOrder};
	__property Grids::TGetEditEvent OnGetEditText = {read=FOnGetEditText, write=FOnGetEditText};
	__property TGetRecordCountEvent OnGetRecordCount = {read=FOnGetRecordCount, write=FOnGetRecordCount};
	__property TGetHTMLTemplateDataEvent OnGetHTMLTemplateData = {read=FOnGetHTMLTemplateData, write=FOnGetHTMLTemplateData};
	__property TInvalidPictureEvent OnInvalidPicture = {read=FOnInvalidPicture, write=FOnInvalidPicture};
	__property TFieldToStreamEvent OnFieldToStream = {read=FOnFieldToStream, write=FOnFieldToStream};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvGrid(HWND ParentWindow) : Advgrid::TAdvStringGrid(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0xe;
static const ShortInt BLD_VER = 0x2;
#define s_QuickConfig L"Quick config"
#define s_AddAllFIelds L"Add all DB fields"
#define s_RemoveAllFields L"Remove all DB fields"
#define s_RemoveAllColumns L"Remove all columns"

}	/* namespace Dbadvgrid */
using namespace Dbadvgrid;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvgridHPP
