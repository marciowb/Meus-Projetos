// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advdblookupcombobox.pas' rev: 21.00

#ifndef AdvdblookupcomboboxHPP
#define AdvdblookupcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Alxpvs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advdblookupcombobox
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFindList;
class DELPHICLASS TAdvDBLookupComboBox;
class PASCALIMPLEMENTATION TFindList : public Classes::TStringList
{
	typedef Classes::TStringList inherited;
	
private:
	int BaseIndex;
	System::UnicodeString KeyField;
	TAdvDBLookupComboBox* FGrid;
	
public:
	__fastcall TFindList(TAdvDBLookupComboBox* Agrid);
	__fastcall virtual ~TFindList(void);
};


typedef void __fastcall (__closure *TLookupErrorEvent)(System::TObject* Sender, System::UnicodeString LookupValue);

typedef void __fastcall (__closure *TLookupSuccessEvent)(System::TObject* Sender, System::UnicodeString LookupValue, System::UnicodeString LookupResult);

#pragma option push -b-
enum TLabelPosition { lpLeftTop, lpLeftCenter, lpLeftBottom, lpTopLeft, lpBottomLeft, lpLeftTopLeft, lpLeftCenterLeft, lpLeftBottomLeft, lpTopCenter, lpBottomCenter, lpRightTop, lpRightCenter, lpRightBottom };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

#pragma option push -b-
enum TDropDownType { ddUser, ddAuto, ddOnError };
#pragma option pop

#pragma option push -b-
enum TSortType { stAscendent, stDescendent };
#pragma option pop

#pragma option push -b-
enum TTitleOrientation { toHorizontal, toVertical };
#pragma option pop

#pragma option push -b-
enum TVertAlignment { tvaCenter, tvaTop, tvaBottom };
#pragma option pop

class DELPHICLASS TDBGridLookupDataLink;
class PASCALIMPLEMENTATION TDBGridLookupDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	TAdvDBLookupComboBox* FGrid;
	
protected:
	void __fastcall Modify(void);
	virtual void __fastcall DataSetScrolled(int distance);
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall RecordChanged(Db::TField* Field);
	virtual void __fastcall DataSetChanged(void);
	
public:
	__fastcall TDBGridLookupDataLink(TAdvDBLookupComboBox* AGrid);
	__fastcall virtual ~TDBGridLookupDataLink(void);
};


class DELPHICLASS TDBGridDataLink;
class PASCALIMPLEMENTATION TDBGridDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	TAdvDBLookupComboBox* FGrid;
	int FNumberRecords;
	Db::TDataSetState OldState;
	bool FLoadingData;
	int FOldRecNo;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall RecordChanged(Db::TField* Field);
	virtual void __fastcall DataSetChanged(void);
	
public:
	__fastcall TDBGridDataLink(TAdvDBLookupComboBox* AGrid);
	__fastcall virtual ~TDBGridDataLink(void);
};


#pragma option push -b-
enum TEllipsType { etNone, etEndEllips, etPathEllips };
#pragma option pop

class DELPHICLASS TLabelEx;
class PASCALIMPLEMENTATION TLabelEx : public Stdctrls::TLabel
{
	typedef Stdctrls::TLabel inherited;
	
private:
	TEllipsType FEllipsType;
	void __fastcall SetEllipsType(const TEllipsType Value);
	
protected:
	virtual void __fastcall Paint(void);
	
__published:
	__property TEllipsType EllipsType = {read=FEllipsType, write=SetEllipsType, nodefault};
public:
	/* TCustomLabel.Create */ inline __fastcall virtual TLabelEx(Classes::TComponent* AOwner) : Stdctrls::TLabel(AOwner) { }
	
public:
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TLabelEx(void) { }
	
};


#pragma option push -b-
enum TDBColumnType { ctText, ctImage };
#pragma option pop

class DELPHICLASS TDBColumnItem;
class PASCALIMPLEMENTATION TDBColumnItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FWidth;
	Classes::TAlignment FAlignment;
	Graphics::TFont* FFont;
	Graphics::TColor FColor;
	TDBColumnType FColumnType;
	System::UnicodeString FListField;
	System::UnicodeString FTitle;
	System::UnicodeString FName;
	Graphics::TFont* FTitleFont;
	bool FAutoSize;
	Graphics::TColor FFixedColor;
	Graphics::TColor FFixedColorTo;
	TGradientDirection FGradientDir;
	TTitleOrientation FTitleOrientation;
	Classes::TAlignment FTitleAlignment;
	TVertAlignment FTitleVerticalAlignment;
	bool FFontChanged;
	bool FTitleFontChanged;
	void __fastcall SetWidth(const int value);
	void __fastcall SetAlignment(const Classes::TAlignment value);
	void __fastcall SetFont(const Graphics::TFont* value);
	void __fastcall SetColor(const Graphics::TColor value);
	System::UnicodeString __fastcall GetListField(void);
	void __fastcall SetListField(const System::UnicodeString Value);
	void __fastcall SetColumnType(const TDBColumnType Value);
	TAdvDBLookupComboBox* __fastcall GetCombo(void);
	System::UnicodeString __fastcall GetName(void);
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetTitleFont(const Graphics::TFont* Value);
	void __fastcall OnFontChanged(System::TObject* Sender);
	void __fastcall OnTitleFontChanged(System::TObject* Sender);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TDBColumnItem(Classes::TCollection* Collection);
	__fastcall virtual ~TDBColumnItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TAdvDBLookupComboBox* Combo = {read=GetCombo};
	
__published:
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, default=0};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777211};
	__property TDBColumnType ColumnType = {read=FColumnType, write=SetColumnType, default=0};
	__property Graphics::TColor FixedColor = {read=FFixedColor, write=FFixedColor, nodefault};
	__property Graphics::TColor FixedColorTo = {read=FFixedColorTo, write=FFixedColorTo, nodefault};
	__property TGradientDirection GradientDir = {read=FGradientDir, write=FGradientDir, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, default=100};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::UnicodeString ListField = {read=GetListField, write=SetListField};
	__property System::UnicodeString Name = {read=GetName, write=SetName};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property Graphics::TFont* TitleFont = {read=FTitleFont, write=SetTitleFont};
	__property Classes::TAlignment TitleAlignment = {read=FTitleAlignment, write=FTitleAlignment, default=2};
	__property TVertAlignment TitleVerticalAlignment = {read=FTitleVerticalAlignment, write=FTitleVerticalAlignment, default=0};
	__property TTitleOrientation TitleOrientation = {read=FTitleOrientation, write=FTitleOrientation, default=0};
};


class DELPHICLASS TDBColumnCollection;
class PASCALIMPLEMENTATION TDBColumnCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TDBColumnItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvDBLookupComboBox* FOwner;
	HIDESBASE TDBColumnItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TDBColumnItem* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	HIDESBASE TDBColumnItem* __fastcall Add(void);
	HIDESBASE TDBColumnItem* __fastcall Insert(int index);
	__property TDBColumnItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__fastcall TDBColumnCollection(TAdvDBLookupComboBox* AOwner);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TDBColumnCollection(void) { }
	
};


class DELPHICLASS TDropForm;
class PASCALIMPLEMENTATION TDropForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	bool FSizeable;
	bool FDroppedDown;
	Extctrls::TTimer* FHideTimer;
	HIDESBASE MESSAGE void __fastcall WMClose(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	void __fastcall OnHideTimer(System::TObject* Sender);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__fastcall virtual TDropForm(Classes::TComponent* AOwner);
	__fastcall virtual TDropForm(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TDropForm(void);
	
__published:
	__property bool Sizeable = {read=FSizeable, write=FSizeable, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDropForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TInplaceStringGrid;
class PASCALIMPLEMENTATION TInplaceStringGrid : public Grids::TStringGrid
{
	typedef Grids::TStringGrid inherited;
	
private:
	TAdvDBLookupComboBox* FParentEdit;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	
protected:
	DYNAMIC void __fastcall DoExit(void);
	__property TAdvDBLookupComboBox* ParentEdit = {read=FParentEdit, write=FParentEdit};
public:
	/* TStringGrid.Create */ inline __fastcall virtual TInplaceStringGrid(Classes::TComponent* AOwner) : Grids::TStringGrid(AOwner) { }
	/* TStringGrid.Destroy */ inline __fastcall virtual ~TInplaceStringGrid(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInplaceStringGrid(HWND ParentWindow) : Grids::TStringGrid(ParentWindow) { }
	
};


class DELPHICLASS TDropGridListButton;
class PASCALIMPLEMENTATION TDropGridListButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	Controls::TWinControl* FFocusControl;
	Classes::TNotifyEvent FMouseClick;
	Graphics::TBitmap* FArrEnabled;
	bool FIsWinXP;
	bool FHover;
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	__property bool Hover = {read=FHover, write=FHover, nodefault};
	
public:
	DYNAMIC void __fastcall Click(void);
	__fastcall virtual TDropGridListButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TDropGridListButton(void);
	__property bool IsWinXP = {read=FIsWinXP, write=FIsWinXP, nodefault};
	
__published:
	__property Controls::TWinControl* FocusControl = {read=FFocusControl, write=FFocusControl};
	__property Classes::TNotifyEvent MouseClick = {read=FMouseClick, write=FMouseClick};
};


typedef void __fastcall (__closure *TGridListItemToText)(System::TObject* sender, System::UnicodeString &aText);

typedef void __fastcall (__closure *TTextToGridListItem)(System::TObject* sender, System::UnicodeString &aItem);

typedef void __fastcall (__closure *TDrawGridCellProp)(System::TObject* Sender, int RowIndex, int ColIndex, Db::TField* DBField, System::UnicodeString Value, Graphics::TFont* AFont, Graphics::TColor &AColor);

typedef void __fastcall (__closure *TGridSelectCellEvent)(System::TObject* Sender, int Col, int Row, System::UnicodeString Avalue, bool &CanSelect);

#pragma option push -b-
enum TDropDirection { ddDown, ddUp };
#pragma option pop

#pragma option push -b-
enum TSortMethod { smText, smNumeric, smDate };
#pragma option pop

#pragma option push -b-
enum TLookupMethod { lmNormal, lmFast, lmRequired };
#pragma option pop

#pragma option push -b-
enum TLookupLoad { llAlways, llOnNeed };
#pragma option pop

class PASCALIMPLEMENTATION TAdvDBLookupComboBox : public Stdctrls::TCustomEdit
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	TDropGridListButton* FButton;
	bool FEditorEnabled;
	Classes::TNotifyEvent FOnClickBtn;
	TInplaceStringGrid* FStringGrid;
	int FDropHeight;
	int FDropWidth;
	int FSortColumns;
	TSortMethod FSortMethod;
	Graphics::TColor FDropColor;
	Graphics::TFont* FDropFont;
	bool FDropSorted;
	TDropDirection fDropDirection;
	TDropForm* FChkForm;
	bool FChkClosed;
	bool FCloseClick;
	TGridListItemToText FOnGridListItemToText;
	TTextToGridListItem FOnTextToGridListItem;
	TDBColumnCollection* FColumns;
	TDBGridDataLink* FListDataLink;
	TDBGridLookupDataLink* FDataSourceLink;
	Classes::TList* FAllfields;
	Graphics::TBitmap* FBitmapUp;
	Graphics::TBitmap* FBitmapdown;
	bool FDataScroll;
	int FItemIndex;
	int FOldItemIndex;
	int FOldItemIndex2;
	System::UnicodeString FKeyField;
	System::UnicodeString FDataField;
	Graphics::TColor FHeaderColor;
	Graphics::TColor FSelectionColor;
	System::UnicodeString FCurrentSearch;
	bool FAccept;
	TSortType FSensSorted;
	Graphics::TColor FSelectionTextColor;
	bool FGridLines;
	bool FGridColumnSize;
	System::UnicodeString FFilterValue;
	System::UnicodeString FFilterField;
	Sysutils::TBytes FBookmark;
	TLookupMethod FLookupMethod;
	bool FLabelAlwaysEnabled;
	bool FLabelTransparent;
	int FLabelMargin;
	Graphics::TFont* FLabelFont;
	TLabelPosition FLabelPosition;
	TLabelEx* FLabel;
	TDropDownType FDropDownType;
	TLookupErrorEvent FOnLookupError;
	TLookupSuccessEvent FOnLookupSuccess;
	System::UnicodeString FLabelField;
	System::UnicodeString FSortColumn;
	int FLabelWidth;
	int FGridRowHeight;
	int FGridHeaderHeight;
	TLookupLoad FLookupLoad;
	bool FDisableChange;
	bool FInLookup;
	bool FDropSizeable;
	Classes::TNotifyEvent FOnDropDown;
	Classes::TNotifyEvent FOnCloseUp;
	Classes::TNotifyEvent FOnClosed;
	bool FReturnIsTab;
	Graphics::TColor FFocusColor;
	Graphics::TColor FNormalColor;
	Controls::TImageList* FImages;
	bool FShowGridTitleRow;
	int FLookupColumn;
	bool FInternalCall;
	TDrawGridCellProp FOnDrawProp;
	int FDropStretchColumn;
	Graphics::TColor FDisabledColor;
	bool FGridHeaderAutoSize;
	TGridSelectCellEvent FOnGridSelectCell;
	bool FGridCellNotSelected;
	bool FAlwaysRefreshDropDownList;
	int FHoveredRow;
	Graphics::TColor FHoverColor;
	Graphics::TColor FHoverTextColor;
	bool FSelectionChanged;
	bool FShowMemoFields;
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	MESSAGE void __fastcall WMPaste(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMCut(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSysKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	int __fastcall GetMinHeight(void);
	void __fastcall SetEditRect(void);
	void __fastcall OnGridResize(System::TObject* Sender);
	void __fastcall OnDropDownResize(System::TObject* Sender);
	System::UnicodeString __fastcall GridToString(void);
	void __fastcall ShowGridList(bool Focus);
	void __fastcall HideGridList(void);
	void __fastcall UpdateLookup(void);
	void __fastcall FormDeactivate(System::TObject* Sender);
	void __fastcall MouseClick(System::TObject* Sender);
	void __fastcall DownClick(System::TObject* Sender);
	void __fastcall SetDropFont(const Graphics::TFont* Value);
	HIDESBASE System::UnicodeString __fastcall GetText(void);
	HIDESBASE void __fastcall SetText(const System::UnicodeString Value);
	bool __fastcall CheckDataSet(void);
	bool __fastcall CheckEditDataSet(void);
	Db::TDataSource* __fastcall GetListsource(void);
	void __fastcall SetListsource(const Db::TDataSource* Value);
	int __fastcall GetItemIndex(void);
	void __fastcall SetItemIndex(int Value);
	Db::TDataSource* __fastcall GetDatasource(void);
	void __fastcall SetDatasource(const Db::TDataSource* Value);
	void __fastcall SetSortColumns(const int Value);
	int __fastcall GetRealItemIndex(int Index);
	void __fastcall SetFilterField(const System::UnicodeString Value);
	void __fastcall SetFilterValue(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetLabelCaption(void);
	void __fastcall SetLabelAlwaysEnabled(const bool Value);
	void __fastcall SetLabelCaption(const System::UnicodeString Value);
	void __fastcall SetLabelFont(const Graphics::TFont* Value);
	void __fastcall SetLabelMargin(const int Value);
	void __fastcall SetLabelPosition(const TLabelPosition Value);
	void __fastcall SetLabelTransparent(const bool Value);
	void __fastcall UpdateLabel(void);
	void __fastcall LabelFontChange(System::TObject* Sender);
	void __fastcall SetLabelField(const System::UnicodeString Value);
	void __fastcall SetSortColumn(const System::UnicodeString Value);
	void __fastcall SetLabelWidth(const int Value);
	void __fastcall SetSortDownGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetSortUpGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetLookupLoad(const TLookupLoad Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	bool __fastcall GetEnabledEx(void);
	void __fastcall SetEnabledEx(const bool Value);
	void __fastcall SetDisabledColor(const Graphics::TColor Value);
	void __fastcall SetLookupColumn(const int Value);
	System::Variant __fastcall SecureLookup(const Db::TDataSet* Data, const Db::TField* Field, const System::UnicodeString KeyFields, const System::Variant &KeyValues, const System::Variant &KeyValuesDefault, const System::UnicodeString ResultFields);
	int __fastcall GetDropDownRowCount(void);
	void __fastcall DestroyBookMark(void);
	void __fastcall SetShowMemoFields(const bool Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual Forms::TCustomForm* __fastcall GetParentForm(Controls::TControl* Control);
	void __fastcall LoadGridOptions(void);
	void __fastcall StringGridDrawCell(System::TObject* Sender, int ACol, int ARow, const Types::TRect &Rect, Grids::TGridDrawState State);
	void __fastcall GridMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall GridMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall StringGridKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall StringGridSelectCell(System::TObject* Sender, int ACol, int ARow, bool &CanSelect);
	int __fastcall LoadFromListSource(void);
	void __fastcall SetActive(bool Active);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	bool __fastcall FindField(System::UnicodeString Value);
	TLabelEx* __fastcall CreateLabel(void);
	void __fastcall UpdateText(System::UnicodeString s);
	__property int SortColumns = {read=FSortColumns, write=SetSortColumns, default=0};
	void __fastcall SetSortMethod(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	int __fastcall GetGridColumnsWidth(void);
	void __fastcall UpdateDropStretchColumnWidth(void);
	Db::TField* __fastcall GetColumnField(int ACol);
	void __fastcall CancelChanges(void);
	virtual bool __fastcall CanModify(void);
	Db::TField* __fastcall GetLookupDataField(void);
	void __fastcall UpdateDisplayText(void);
	
public:
	__fastcall virtual TAdvDBLookupComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvDBLookupComboBox(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Init(void);
	__property TDropGridListButton* Button = {read=FButton};
	__property System::UnicodeString Text = {read=GetText, write=SetText};
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall DropDown(void);
	void __fastcall UpdateDisplText(void);
	__property bool AlwaysRefreshDropDownList = {read=FAlwaysRefreshDropDownList, write=FAlwaysRefreshDropDownList, default=0};
	__property int DropDownRowCount = {read=GetDropDownRowCount, nodefault};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property AutoSelect = {default=1};
	__property AutoSize = {default=1};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BevelEdges = {default=15};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Graphics::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, default=12632256};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property TDropDownType DropDownType = {read=FDropDownType, write=FDropDownType, default=0};
	__property bool EditorEnabled = {read=FEditorEnabled, write=FEditorEnabled, default=1};
	__property bool Enabled = {read=GetEnabledEx, write=SetEnabledEx, nodefault};
	__property System::UnicodeString FilterField = {read=FFilterField, write=SetFilterField};
	__property System::UnicodeString FilterValue = {read=FFilterValue, write=SetFilterValue};
	__property Font;
	__property System::UnicodeString LabelCaption = {read=GetLabelCaption, write=SetLabelCaption};
	__property TLabelPosition LabelPosition = {read=FLabelPosition, write=SetLabelPosition, nodefault};
	__property int LabelMargin = {read=FLabelMargin, write=SetLabelMargin, nodefault};
	__property bool LabelTransparent = {read=FLabelTransparent, write=SetLabelTransparent, nodefault};
	__property bool LabelAlwaysEnabled = {read=FLabelAlwaysEnabled, write=SetLabelAlwaysEnabled, nodefault};
	__property System::UnicodeString LabelField = {read=FLabelField, write=SetLabelField};
	__property Graphics::TFont* LabelFont = {read=FLabelFont, write=SetLabelFont};
	__property int LabelWidth = {read=FLabelWidth, write=SetLabelWidth, nodefault};
	__property int LookupColumn = {read=FLookupColumn, write=SetLookupColumn, nodefault};
	__property TLookupMethod LookupMethod = {read=FLookupMethod, write=FLookupMethod, nodefault};
	__property TLookupLoad LookupLoad = {read=FLookupLoad, write=SetLookupLoad, nodefault};
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property Height;
	__property Width;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnEndDock;
	__property OnStartDock;
	__property TDBColumnCollection* Columns = {read=FColumns, write=FColumns};
	__property System::UnicodeString DataField = {read=FDataField, write=FDataField};
	__property Db::TDataSource* DataSource = {read=GetDatasource, write=SetDatasource};
	__property int DropWidth = {read=FDropWidth, write=FDropWidth, nodefault};
	__property int DropStretchColumn = {read=FDropStretchColumn, write=FDropStretchColumn, nodefault};
	__property int DropHeight = {read=FDropHeight, write=FDropHeight, default=100};
	__property Graphics::TColor DropColor = {read=FDropColor, write=FDropColor, default=-16777211};
	__property Graphics::TFont* DropFont = {read=FDropFont, write=SetDropFont};
	__property TDropDirection DropDirection = {read=fDropDirection, write=fDropDirection, default=0};
	__property bool DropSorted = {read=FDropSorted, write=FDropSorted, default=0};
	__property bool DropSizeable = {read=FDropSizeable, write=FDropSizeable, default=0};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=FFocusColor, default=536870911};
	__property bool GridLines = {read=FGridLines, write=FGridLines, default=1};
	__property bool GridColumnSize = {read=FGridColumnSize, write=FGridColumnSize, default=1};
	__property int GridRowHeight = {read=FGridRowHeight, write=FGridRowHeight, default=21};
	__property bool GridHeaderAutoSize = {read=FGridHeaderAutoSize, write=FGridHeaderAutoSize, default=0};
	__property int GridHeaderHeight = {read=FGridHeaderHeight, write=FGridHeaderHeight, default=21};
	__property Graphics::TColor HeaderColor = {read=FHeaderColor, write=FHeaderColor, default=-16777201};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=FHoverColor, default=-16777203};
	__property Graphics::TColor HoverTextColor = {read=FHoverTextColor, write=FHoverTextColor, default=-16777202};
	__property Controls::TImageList* Images = {read=FImages, write=FImages};
	__property System::UnicodeString KeyField = {read=FKeyField, write=FKeyField};
	__property Db::TDataSource* ListSource = {read=GetListsource, write=SetListsource};
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, default=0};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=FSelectionColor, default=-16777203};
	__property Graphics::TColor SelectionTextColor = {read=FSelectionTextColor, write=FSelectionTextColor, default=-16777202};
	__property bool ShowMemoFields = {read=FShowMemoFields, write=SetShowMemoFields, default=0};
	__property System::UnicodeString SortColumn = {read=FSortColumn, write=SetSortColumn};
	__property Graphics::TBitmap* SortUpGlyph = {read=FBitmapdown, write=SetSortUpGlyph};
	__property Graphics::TBitmap* SortDownGlyph = {read=FBitmapUp, write=SetSortDownGlyph};
	__property bool ShowGridTitleRow = {read=FShowGridTitleRow, write=FShowGridTitleRow, nodefault};
	__property Classes::TNotifyEvent OnClickBtn = {read=FOnClickBtn, write=FOnClickBtn};
	__property Classes::TNotifyEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property Classes::TNotifyEvent OnClosed = {read=FOnClosed, write=FOnClosed};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property TGridSelectCellEvent OnGridSelectCell = {read=FOnGridSelectCell, write=FOnGridSelectCell};
	__property TTextToGridListItem OnTextToGridListItem = {read=FOnTextToGridListItem, write=FOnTextToGridListItem};
	__property TGridListItemToText OnGridListItemToText = {read=FOnGridListItemToText, write=FOnGridListItemToText};
	__property TLookupErrorEvent OnLookupError = {read=FOnLookupError, write=FOnLookupError};
	__property TLookupSuccessEvent OnLookupSuccess = {read=FOnLookupSuccess, write=FOnLookupSuccess};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TDrawGridCellProp OnDrawProp = {read=FOnDrawProp, write=FOnDrawProp};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvDBLookupComboBox(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x8;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advdblookupcombobox */
using namespace Advdblookupcombobox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvdblookupcomboboxHPP
