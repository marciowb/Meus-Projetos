// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atVisualQuery.pas' rev: 22.00

#ifndef AtvisualqueryHPP
#define AtvisualqueryHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <CheckLst.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <DBGrids.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <atMetaSQL.hpp>	// Pascal unit
#include <atSqlParser.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <atParamTreeView.hpp>	// Pascal unit
#include <atParHTML.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <atCheckListEdit.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <atQueryCombo.hpp>	// Pascal unit
#include <uDBUtil.hpp>	// Pascal unit
#include <atDatabase.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atvisualquery
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TClauseOption { coVisible, coEditable, coCheckBoxes, coChangePosition, coInsertCustom, coShortText };
#pragma option pop

typedef System::Set<TClauseOption, TClauseOption::coVisible, TClauseOption::coShortText>  TClauseOptions;

#pragma option push -b-
enum TPopupMode { pmFull, pmInsertion };
#pragma option pop

#pragma option push -b-
enum TatParamType { ptUnknown, ptFreeEdit, ptDistinctList, ptQueryList, ptChooseList, ptCheckList };
#pragma option pop

class DELPHICLASS HackControl;
class PASCALIMPLEMENTATION HackControl : public Controls::TControl
{
	typedef Controls::TControl inherited;
	
public:
	/* TControl.Create */ inline __fastcall virtual HackControl(Classes::TComponent* AOwner) : Controls::TControl(AOwner) { }
	/* TControl.Destroy */ inline __fastcall virtual ~HackControl(void) { }
	
};


class DELPHICLASS TatInternalMetaSql;
class PASCALIMPLEMENTATION TatInternalMetaSql : public Atmetasql::TatMetaSQL
{
	typedef Atmetasql::TatMetaSQL inherited;
	
public:
	DYNAMIC void __fastcall SetParentComponent(Classes::TComponent* Value);
	DYNAMIC Classes::TComponent* __fastcall GetParentComponent(void);
public:
	/* TatMetaSQL.Create */ inline __fastcall virtual TatInternalMetaSql(Classes::TComponent* AOwner) : Atmetasql::TatMetaSQL(AOwner) { }
	/* TatMetaSQL.Destroy */ inline __fastcall virtual ~TatInternalMetaSql(void) { }
	
};


typedef void __fastcall (__closure *TNotifyObjectEvent)(System::TObject* Sender, System::TObject* AObject);

typedef void __fastcall (__closure *TVQTreeViewParamChangedEvent)(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, System::UnicodeString oldvalue, System::UnicodeString newvalue, System::TObject* obj, System::TObject* colobj);

class DELPHICLASS TatVisualQuery;
class DELPHICLASS TatMetaSqlDefs;
class DELPHICLASS TatMetaSqlDef;
class DELPHICLASS TatQueryDefContainer;
class PASCALIMPLEMENTATION TatVisualQuery : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Atparamtreeview::TatParamTreeView* FTreeView;
	Extctrls::TPanel* FTreeViewPanel;
	Controls::TImageList* FImageList;
	Menus::TPopupMenu* FPopupMenu;
	Extctrls::TTimer* FRefreshTimer;
	Extctrls::TPanel* FParamPanel;
	TatMetaSqlDefs* FMetaSqlDefs;
	TatMetaSqlDef* FMetaSqlDef;
	TClauseOptions FTablesOptions;
	TClauseOptions FFieldsOptions;
	TClauseOptions FConditionsOptions;
	TClauseOptions FGroupingOptions;
	TClauseOptions FOrderingOptions;
	TClauseOptions FParamsOptions;
	Classes::TNotifyEvent FOnMetaSqlChange;
	Types::TPoint FLastPopUpPoint;
	TPopupMode FPopupMode;
	int FResizeHeight;
	bool FAutoAdjustHeight;
	bool FIgnoreVisualAdjustments;
	bool FIgnoreTreeViewArrangement;
	bool FIgnoreParamChanges;
	bool FChangingParamEditors;
	Forms::TForm* FQueryEditor;
	Atmetasql::TatMetaSQL* FMetaSql;
	Db::TDataSet* FTargetDataset;
	bool FAutoGrouping;
	bool FAutoQueryOpen;
	Graphics::TColor FEditorColor;
	bool FShowQueryTitle;
	bool FEditQueryTitle;
	int FUpdateCount;
	bool FParamEditorsReadOnly;
	bool FShowParamEditors;
	TatQueryDefContainer* FContainer;
	Atdatabase::TatDatabase* FDatabase;
	Graphics::TColor FSelectionColor;
	Graphics::TColor FSelectionFontColor;
	int FItemHeight;
	Atmetasql::TatSQLSyntax FSQLSyntax;
	Atmetasql::TSQLSyntaxConf* FSyntaxConf;
	bool FDisablePrettyText;
	TVQTreeViewParamChangedEvent FOnTreeViewParamChanged;
	Classes::TNotifyEvent FOnItemDeleted;
	TNotifyObjectEvent FOnItemDeleting;
	bool FQualifiedFieldAliases;
	System::UnicodeString FFieldAliasSeparator;
	Classes::TStrings* FTableNames;
	bool FAutoUpdateFieldAliases;
	TatMetaSqlDef* __fastcall GetMetaSqlDef(void);
	void __fastcall SetMetaSqlDefs(const TatMetaSqlDefs* Value);
	void __fastcall TreeViewArrangement(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall FTreeViewCheckUncheck(System::TObject* Sender);
	void __fastcall FTreeViewDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall FTreeViewDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall FTreeViewEditing(System::TObject* Sender, Comctrls::TTreeNode* Node, bool &AllowEdit);
	void __fastcall FTreeViewKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall FTreeViewEdited(System::TObject* Sender, Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall FRefreshTimerTimer(System::TObject* Sender);
	void __fastcall FPopupMenuPopup(System::TObject* Sender);
	void __fastcall DestroyParamEditors(void);
	void __fastcall CreateParamEditors(bool AForceAutosize = false);
	bool __fastcall UpdateMetaSqlParams(void);
	void __fastcall UpdateMetaSql(void);
	bool __fastcall SetParamValue(System::UnicodeString AParamName, System::UnicodeString AValue);
	void __fastcall RefreshDataset(void);
	void __fastcall TriggerQueryRefresh(System::TObject* Sender);
	void __fastcall AdjustParamEditors(void);
	void __fastcall AdjustTreeView(void);
	void __fastcall AdjustVisualQueryPanel(void);
	void __fastcall AutoAdjustEditorSize(System::TObject* Sender);
	void __fastcall DeleteQueryItemClick(System::TObject* Sender);
	void __fastcall OpenQueryItemClick(System::TObject* Sender);
	void __fastcall SaveQueryItemClick(System::TObject* Sender);
	void __fastcall NewQueryItemClick(System::TObject* Sender);
	TClauseOptions __fastcall ClauseNodeOptions(Comctrls::TTreeNode* AItem);
	bool __fastcall GetNodeActive(Comctrls::TTreeNode* ANode);
	void __fastcall SetNodeActive(Comctrls::TTreeNode* ANode, bool AValue);
	void __fastcall DeleteItem(Comctrls::TTreeNode* ANode);
	void __fastcall PrepareConditionItemsMenu(System::TObject* AObj);
	void __fastcall PrepareFieldItemsMenu(void);
	void __fastcall PrepareGroupItemsMenu(void);
	void __fastcall PrepareItemMenu(void);
	void __fastcall PrepareOrderItemsMenu(void);
	void __fastcall PrepareParamItemsMenu(void);
	void __fastcall PrepareQueryMenu(void);
	void __fastcall PrepareTableItemsMenu(void);
	void __fastcall IncludeItemClick(System::TObject* Sender);
	Menus::TMenuItem* __fastcall AddMenuItem(Menus::TMenuItem* AOwner, System::UnicodeString ACaption, Classes::TNotifyEvent AClick, int ATag = 0x0);
	void __fastcall SelectNodeByObject(System::TObject* AObj);
	System::UnicodeString __fastcall GetConditionCaption(Atmetasql::TatSQLCondition* ACond, bool Html = false);
	System::UnicodeString __fastcall GetOrderFieldCaption(Atmetasql::TatSQLOrderField* AOrdFld);
	System::UnicodeString __fastcall GetGroupFieldCaption(Atmetasql::TatSQLGroupField* AGrpFld);
	System::UnicodeString __fastcall GetTableCaption(Atmetasql::TatSqlTable* ATab);
	Menus::TMenuItem* __fastcall FindTableMenuItem(Menus::TMenuItem* mn, Atmetasql::TatSqlBaseField* ABaseField);
	void __fastcall CheckIncludeMenu(Menus::TMenuItem* &mi, System::TObject* AObj);
	bool __fastcall NodeAllowSubNodes(Comctrls::TTreeNode* node);
	bool __fastcall NodeHasObject(Comctrls::TTreeNode* node);
	void __fastcall OpenNodePopupMenu(TPopupMode mode);
	Graphics::TColor __fastcall GetColor(void);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	bool __fastcall HasMetaSqlDefs(void);
	void __fastcall CreateEmbeddedComponents(void);
	void __fastcall SetAutoAdjustHeight(const bool Value);
	System::UnicodeString __fastcall FormatParametricCaption(System::UnicodeString ACaption, int AImg, System::TObject* AObj, bool AHtml = true);
	void __fastcall TreeViewHtmlParamChanged(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, System::UnicodeString oldvalue, System::UnicodeString newvalue);
	void __fastcall TreeViewHtmlParamPopup(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, Classes::TStringList* values, bool &DoPopup);
	void __fastcall TreeViewMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall LoadFieldNameList(System::UnicodeString ATableName, Classes::TStrings* lst);
	void __fastcall LoadTableNameList(Classes::TStrings* lst);
	System::UnicodeString __fastcall TableNameFromAlias(System::UnicodeString AAlias);
	void __fastcall PrettyTextList(Classes::TStringList* lst, bool ASort = true);
	System::UnicodeString __fastcall DisplayLabelByFieldAlias(Atmetasql::TatMetaSQL* msql, System::UnicodeString AAlias);
	System::UnicodeString __fastcall FieldAliasByDisplayLabel(Atmetasql::TatMetaSQL* msql, System::UnicodeString ALabel);
	Atmetasql::TatSQLJoin* __fastcall JoinByForeignTableAlias(Atmetasql::TatMetaSQL* msql, System::UnicodeString AAlias);
	Atmetasql::TatSQLJoin* __fastcall JoinByCondition(Atmetasql::TatSQLCondition* ACond);
	System::TObject* __fastcall FindInvalidItem(System::TObject* AObj);
	void __fastcall TreeViewHtmlParamEditing(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, System::UnicodeString &value);
	void __fastcall TreeViewHtmlParamEdited(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, System::UnicodeString &value);
	void __fastcall RebuildParamEditors(void);
	void __fastcall CheckMetaSqlIntegrity(void);
	void __fastcall CheckTableChange(Atmetasql::TatSqlTable* ATable, System::UnicodeString AOldName, System::UnicodeString ANewName);
	void __fastcall UpdateFieldType(Atmetasql::TatSqlField* AField);
	void __fastcall TreeViewHtmlParamEnter(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, System::UnicodeString value);
	void __fastcall TreeViewHtmlParamExit(System::TObject* Sender, Comctrls::TTreeNode* ANode, System::UnicodeString href, System::UnicodeString value);
	void __fastcall DrawQueryOnTreeView(Comctrls::TTreeNode* node, TatMetaSqlDef* mdef, Atmetasql::TatMetaSQL* msql, System::TObject* ASelectedObj, System::UnicodeString ATitle, bool atomic, System::TObject* AAtomicObj);
	Forms::TForm* __fastcall GetQueryEditor(void);
	System::UnicodeString __fastcall HtmlParam(System::UnicodeString AName, System::UnicodeString AValue, bool Html);
	void __fastcall AdjustPopupPoint(void);
	void __fastcall SetTargetDataset(const Db::TDataSet* Value);
	System::UnicodeString __fastcall CreateParamName(System::UnicodeString AParamName);
	System::UnicodeString __fastcall EllipsisHtml(void);
	void __fastcall TreeViewDblClick(System::TObject* Sender);
	void __fastcall HighlightEditor(Stdctrls::TLabel* ALabel, Controls::TWinControl* AEditor, bool AEnabled);
	bool __fastcall MetaSqlIsConsistent(void);
	void __fastcall SetAutoGrouping(const bool Value);
	bool __fastcall AutoUpdateMetaSql(void);
	bool __fastcall UpdateMetaSqlGrouping(void);
	bool __fastcall UpdateMetaSqlJoins(void);
	void __fastcall SetAutoQueryOpen(const bool Value);
	void __fastcall SetConditionsOptions(const TClauseOptions Value);
	void __fastcall SetFieldsOptions(const TClauseOptions Value);
	void __fastcall SetGroupingOptions(const TClauseOptions Value);
	void __fastcall SetOrderingOptions(const TClauseOptions Value);
	void __fastcall SetParamsOptions(const TClauseOptions Value);
	void __fastcall SetTablesOptions(const TClauseOptions Value);
	void __fastcall SetEditorColor(const Graphics::TColor Value);
	System::UnicodeString __fastcall TargetDatasetSql(void);
	void __fastcall SetShowQueryTitle(const bool Value);
	void __fastcall SetEditQueryTitle(const bool Value);
	bool __fastcall NodeIsMainCollection(Comctrls::TTreeNode* node);
	bool __fastcall NodeIsQueryTitle(Comctrls::TTreeNode* node);
	void __fastcall SetParamEditorsReadOnly(const bool Value);
	void __fastcall SetShowParamEditors(const bool Value);
	void __fastcall SetMetaSqlDef(const TatMetaSqlDef* Value);
	void __fastcall TreeViewUpdateImage(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall UpdateNodeImage(Comctrls::TTreeNode* Node);
	void __fastcall SetDatabase(const Atdatabase::TatDatabase* Value);
	void __fastcall SetSyntaxConf(Atmetasql::TSQLSyntaxConf* Value);
	void __fastcall SetSQLSyntax(const Atmetasql::TatSQLSyntax Value);
	Graphics::TColor __fastcall GetSelectionColor(void);
	void __fastcall SetSelectionColor(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetSelectionFontColor(void);
	void __fastcall SetSelectionFontColor(const Graphics::TColor Value);
	int __fastcall GetItemHeight(void);
	void __fastcall SetItemHeight(const int Value);
	System::UnicodeString __fastcall PrettyText(System::UnicodeString s);
	void __fastcall SetDisablePrettyText(const bool Value);
	void __fastcall ImportDatafieldsDisplaylabels(Db::TDataSet* ADataset);
	void __fastcall SetQualifiedFieldAliases(const bool Value);
	void __fastcall SetFieldAliasSeparator(const System::UnicodeString Value);
	void __fastcall TableAliasChanged(Atmetasql::TatSqlTable* ATable, System::UnicodeString ANewAlias);
	void __fastcall ResolveMetaSQLReferences(void);
	bool __fastcall IsSyntaxConfStored(void);
	void __fastcall SyntaxConfChanged(System::TObject* Sender);
	
protected:
	DYNAMIC void __fastcall Resize(void);
	DYNAMIC Classes::TComponent* __fastcall GetChildOwner(void);
	System::UnicodeString __fastcall GetUniqueMetaSqlName(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall SetName(const Classes::TComponentName Value);
	virtual void __fastcall Loaded(void);
	__property Forms::TForm* QueryEditor = {read=GetQueryEditor};
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	__property Atparamtreeview::TatParamTreeView* TreeView = {read=FTreeView};
	void __fastcall ParamEditorsActivation(bool AEnable);
	bool __fastcall IsLoading(void);
	
public:
	__fastcall virtual TatVisualQuery(Classes::TComponent* AOwner);
	__fastcall virtual ~TatVisualQuery(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	void __fastcall ClearDatabaseInfo(void);
	void __fastcall LoadTreeView(System::TObject* AObj = (System::TObject*)(0x0));
	virtual void __fastcall Assign(Classes::TPersistent* ASource);
	void __fastcall FullExpand(void);
	void __fastcall ImportFromTargetDataset(void);
	void __fastcall ImportFromTargetMetaSql(void);
	void __fastcall ImportQueriesFromFile(void);
	void __fastcall ExportQueriesToFile(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall UpdateCurrentQuery(bool ARefresh = true);
	void __fastcall VisualUpdate(void);
	__property TatMetaSqlDef* MetaSqlDef = {read=GetMetaSqlDef, write=SetMetaSqlDef};
	void __fastcall SaveQueriesToFile(System::UnicodeString AFileName);
	void __fastcall LoadQueriesFromFile(System::UnicodeString AFileName);
	void __fastcall SaveQueriesToStream(Classes::TStream* AStream);
	void __fastcall LoadQueriesFromStream(Classes::TStream* AStream);
	
__published:
	__property Atmetasql::TatMetaSQL* TargetMetaSQL = {read=FMetaSql, write=FMetaSql};
	__property TatMetaSqlDefs* MetaSqlDefs = {read=FMetaSqlDefs, write=SetMetaSqlDefs, stored=HasMetaSqlDefs};
	__property TClauseOptions OptionsForSourceTables = {read=FTablesOptions, write=SetTablesOptions, default=31};
	__property TClauseOptions OptionsForDataFields = {read=FFieldsOptions, write=SetFieldsOptions, default=31};
	__property TClauseOptions OptionsForFilterConditions = {read=FConditionsOptions, write=SetConditionsOptions, default=31};
	__property TClauseOptions OptionsForGroupingFields = {read=FGroupingOptions, write=SetGroupingOptions, default=31};
	__property TClauseOptions OptionsForOrderingFields = {read=FOrderingOptions, write=SetOrderingOptions, default=31};
	__property TClauseOptions OptionsForParameterEditors = {read=FParamsOptions, write=SetParamsOptions, default=31};
	__property Classes::TNotifyEvent OnMetaSqlChange = {read=FOnMetaSqlChange, write=FOnMetaSqlChange};
	__property int ResizeHeight = {read=FResizeHeight, write=FResizeHeight, nodefault};
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, default=-16777211};
	__property bool AutoAdjustHeight = {read=FAutoAdjustHeight, write=SetAutoAdjustHeight, default=0};
	__property Db::TDataSet* TargetDataset = {read=FTargetDataset, write=SetTargetDataset};
	__property bool AutoGrouping = {read=FAutoGrouping, write=SetAutoGrouping, default=1};
	__property bool AutoQueryOpen = {read=FAutoQueryOpen, write=SetAutoQueryOpen, default=1};
	__property Graphics::TColor EditorColor = {read=FEditorColor, write=SetEditorColor, default=-16777211};
	__property bool ShowQueryTitle = {read=FShowQueryTitle, write=SetShowQueryTitle, default=1};
	__property bool EditQueryTitle = {read=FEditQueryTitle, write=SetEditQueryTitle, default=1};
	__property bool ParamEditorsReadOnly = {read=FParamEditorsReadOnly, write=SetParamEditorsReadOnly, default=0};
	__property bool ShowParamEditors = {read=FShowParamEditors, write=SetShowParamEditors, default=1};
	__property Atdatabase::TatDatabase* Database = {read=FDatabase, write=SetDatabase};
	__property Atmetasql::TatSQLSyntax SQLSyntax = {read=FSQLSyntax, write=SetSQLSyntax, nodefault};
	__property Atmetasql::TSQLSyntaxConf* SyntaxConf = {read=FSyntaxConf, write=SetSyntaxConf, stored=IsSyntaxConfStored};
	__property bool DisablePrettyText = {read=FDisablePrettyText, write=SetDisablePrettyText, nodefault};
	__property bool QualifiedFieldAliases = {read=FQualifiedFieldAliases, write=SetQualifiedFieldAliases, nodefault};
	__property System::UnicodeString FieldAliasSeparator = {read=FFieldAliasSeparator, write=SetFieldAliasSeparator};
	__property bool AutoUpdateFieldAliases = {read=FAutoUpdateFieldAliases, write=FAutoUpdateFieldAliases, nodefault};
	__property Graphics::TColor SelectionColor = {read=GetSelectionColor, write=SetSelectionColor, nodefault};
	__property Graphics::TColor SelectionFontColor = {read=GetSelectionFontColor, write=SetSelectionFontColor, nodefault};
	__property int ItemHeight = {read=GetItemHeight, write=SetItemHeight, nodefault};
	__property TVQTreeViewParamChangedEvent OnTreeViewParamChanged = {read=FOnTreeViewParamChanged, write=FOnTreeViewParamChanged};
	__property TNotifyObjectEvent OnItemDeleting = {read=FOnItemDeleting, write=FOnItemDeleting};
	__property Classes::TNotifyEvent OnItemDeleted = {read=FOnItemDeleted, write=FOnItemDeleted};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BorderStyle = {default=1};
	__property Constraints;
	__property Ctl3D;
	__property UseDockManager = {default=1};
	__property DockSite = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetSiteInfo;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnUnDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TatVisualQuery(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TatMetaSqlDefs : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatMetaSqlDef* operator[](int i) { return Items[i]; }
	
private:
	HIDESBASE TatMetaSqlDef* __fastcall GetItem(int i);
	
public:
	HIDESBASE TatMetaSqlDef* __fastcall Add(void);
	int __fastcall IndexOf(System::UnicodeString ATitle);
	__property TatMetaSqlDef* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatMetaSqlDefs(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatMetaSqlDefs(void) { }
	
};


class DELPHICLASS TatParamDefs;
class PASCALIMPLEMENTATION TatMetaSqlDef : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FTitle;
	TatInternalMetaSql* FMetaSql;
	TatParamDefs* FParamDefs;
	System::UnicodeString FTempMetaSQLName;
	void __fastcall SetMetaSql(const TatInternalMetaSql* Value);
	void __fastcall SetParamDefs(const TatParamDefs* Value);
	TatInternalMetaSql* __fastcall GetMetaSql(void);
	TatVisualQuery* __fastcall VisualQuery(void);
	bool __fastcall IsStoredMetaSql(void);
	bool __fastcall HasParamDefs(void);
	System::UnicodeString __fastcall GetMetaSQLName(void);
	void __fastcall SetMetaSQLName(const System::UnicodeString Value);
	void __fastcall ResolveMetaSQLReference(void);
	
public:
	__fastcall virtual TatMetaSqlDef(Classes::TCollection* ACollection);
	__fastcall virtual ~TatMetaSqlDef(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	bool __fastcall AllowSetup(void);
	
__published:
	__property System::UnicodeString MetaSQLName = {read=GetMetaSQLName, write=SetMetaSQLName};
	__property TatInternalMetaSql* MetaSql = {read=GetMetaSql, write=SetMetaSql, stored=false};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property TatParamDefs* ParamDefs = {read=FParamDefs, write=SetParamDefs, stored=HasParamDefs};
};


class DELPHICLASS TatParamDef;
class PASCALIMPLEMENTATION TatParamDefs : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatParamDef* operator[](int i) { return Items[i]; }
	
private:
	HIDESBASE TatParamDef* __fastcall GetItem(int i);
	
public:
	HIDESBASE TatParamDef* __fastcall Add(void);
	__property TatParamDef* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatParamDefs(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatParamDefs(void) { }
	
};


class DELPHICLASS TatParamListItems;
class DELPHICLASS TatParamListItem;
class PASCALIMPLEMENTATION TatParamDef : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	System::UnicodeString FCaption;
	TatParamType FParamType;
	Db::TFieldType FDataType;
	TatParamListItems* FListItems;
	Atmetasql::TatMetaSQL* FMetaSql;
	System::UnicodeString FMetaSqlStr;
	bool FActive;
	Atmetasql::TatSqlField* FField;
	System::Variant FValue;
	System::UnicodeString FText;
	Controls::TWinControl* FEditor;
	Stdctrls::TLabel* FLabel;
	int FWidth;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetDataType(const Db::TFieldType Value);
	void __fastcall SetListItems(const TatParamListItems* Value);
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetParamType(const TatParamType Value);
	void __fastcall SetMetaSql(const Atmetasql::TatMetaSQL* Value);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetValue(const System::Variant &Value);
	Atmetasql::TatMetaSQL* __fastcall GetMetaSql(void);
	System::UnicodeString __fastcall GetMetaSQLStr(void);
	bool __fastcall IsStoredMetaSql(void);
	bool __fastcall IsStoredMetaSqlStr(void);
	void __fastcall SetMetaSQLStr(const System::UnicodeString Value);
	Atmetasql::TatSqlField* __fastcall GetField(void);
	void __fastcall SetField(const Atmetasql::TatSqlField* Value);
	bool __fastcall HasListItems(void);
	bool __fastcall HasValue(void);
	System::Variant __fastcall GetValue(void);
	System::UnicodeString __fastcall GetText(void);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall LoadComboItems(System::TObject* Sender);
	
public:
	__fastcall virtual TatParamDef(Classes::TCollection* ACollection);
	__fastcall virtual ~TatParamDef(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	TatMetaSqlDef* __fastcall MetaSqlDef(void);
	TatVisualQuery* __fastcall VisualQuery(void);
	__property Atmetasql::TatSqlField* Field = {read=GetField, write=SetField};
	__property Controls::TWinControl* Editor = {read=FEditor};
	__property Stdctrls::TLabel* EditorLabel = {read=FLabel};
	TatParamListItem* __fastcall DefaultItem(void);
	bool __fastcall IsNull(void);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property TatParamType ParamType = {read=FParamType, write=SetParamType, default=1};
	__property Db::TFieldType DataType = {read=FDataType, write=SetDataType, default=1};
	__property TatParamListItems* ListItems = {read=FListItems, write=SetListItems, stored=HasListItems};
	__property bool Active = {read=FActive, write=SetActive, default=1};
	__property Atmetasql::TatMetaSQL* MetaSql = {read=GetMetaSql, write=SetMetaSql, stored=IsStoredMetaSql};
	__property System::UnicodeString MetaSqlStr = {read=GetMetaSQLStr, write=SetMetaSQLStr, stored=IsStoredMetaSqlStr};
	__property int Width = {read=FWidth, write=FWidth, default=80};
	__property System::Variant Value = {read=GetValue, write=SetValue, stored=HasValue};
	__property System::UnicodeString Text = {read=GetText, write=SetText};
};


class PASCALIMPLEMENTATION TatParamListItems : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TatParamListItem* operator[](int i) { return Items[i]; }
	
private:
	HIDESBASE TatParamListItem* __fastcall GetItem(int i);
	
public:
	HIDESBASE TatParamListItem* __fastcall Add(void);
	__property TatParamListItem* Items[int i] = {read=GetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TatParamListItems(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TatParamListItems(void) { }
	
};


class DELPHICLASS TatParamValues;
class PASCALIMPLEMENTATION TatParamListItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FText;
	TatParamValues* FParamValues;
	void __fastcall SetParamValues(const TatParamValues* Value);
	void __fastcall SetText(const System::UnicodeString Value);
	bool __fastcall HasParamValues(void);
	
public:
	__fastcall virtual TatParamListItem(Classes::TCollection* ACollection);
	__fastcall virtual ~TatParamListItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property TatParamValues* ParamValues = {read=FParamValues, write=SetParamValues, stored=HasParamValues};
};


class DELPHICLASS TatParamValue;
class PASCALIMPLEMENTATION TatParamValues : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	System::UnicodeString operator[](int i) { return Texts[i]; }
	
private:
	System::UnicodeString __fastcall GetText(int i);
	HIDESBASE TatParamValue* __fastcall GetItem(int i);
	System::UnicodeString __fastcall GetValues(System::UnicodeString s);
	void __fastcall SetValues(System::UnicodeString s, const System::UnicodeString Value);
	System::UnicodeString __fastcall GetName(int i);
	void __fastcall SetName(int i, const System::UnicodeString Value);
	void __fastcall SetText(int i, const System::UnicodeString Value);
	
public:
	__fastcall TatParamValues(Classes::TPersistent* AOwner);
	__fastcall virtual ~TatParamValues(void);
	int __fastcall IndexOfName(const System::UnicodeString AName);
	__property System::UnicodeString Values[System::UnicodeString s] = {read=GetValues, write=SetValues};
	__property System::UnicodeString Names[int i] = {read=GetName, write=SetName};
	__property System::UnicodeString Texts[int i] = {read=GetText, write=SetText/*, default*/};
	__property TatParamValue* Items[int i] = {read=GetItem};
	HIDESBASE TatParamValue* __fastcall Add(System::UnicodeString s);
};


class PASCALIMPLEMENTATION TatParamValue : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FText;
	System::UnicodeString __fastcall GetValue(void);
	void __fastcall SetValue(const System::UnicodeString AValue);
	System::UnicodeString __fastcall GetName(void);
	void __fastcall SetName(const System::UnicodeString AValue);
	System::UnicodeString __fastcall GetText(void);
	void __fastcall SetText(const System::UnicodeString AValue);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* ASource);
	__property System::UnicodeString Value = {read=GetValue, write=SetValue};
	__property System::UnicodeString Name = {read=GetName, write=SetName};
	
__published:
	__property System::UnicodeString Text = {read=GetText, write=SetText};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TatParamValue(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TatParamValue(void) { }
	
};


class PASCALIMPLEMENTATION TatQueryDefContainer : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TatVisualQuery* FVisualQuery;
	void __fastcall SetMetaSqlDefs(const TatMetaSqlDefs* Value);
	TatMetaSqlDefs* __fastcall GetMetaSqlDefs(void);
	
protected:
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	
__published:
	__property TatMetaSqlDefs* MetaSqlDefs = {read=GetMetaSqlDefs, write=SetMetaSqlDefs};
public:
	/* TComponent.Create */ inline __fastcall virtual TatQueryDefContainer(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TatQueryDefContainer(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define coDefaultClauseOptions (System::Set<TClauseOption, TClauseOption::coVisible, TClauseOption::coShortText> () << TClauseOption::coVisible << TClauseOption::coEditable << TClauseOption::coCheckBoxes << TClauseOption::coChangePosition << TClauseOption::coInsertCustom )
static const TClauseOption coShowInactives = (TClauseOption)(0);
static const TClauseOption coClickSetup = (TClauseOption)(1);
static const TClauseOption coInsertInactives = (TClauseOption)(1);
static const TClauseOption coInsertAvailFields = (TClauseOption)(1);
static const TClauseOption coDeleteItems = (TClauseOption)(1);
#define coCanInsert (System::Set<TClauseOption, TClauseOption::coVisible, TClauseOption::coShortText> () << TClauseOption::coEditable << TClauseOption::coInsertCustom )
#define FAKE_OBJECT_INSERTION (void *)(0x1)

}	/* namespace Atvisualquery */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atvisualquery;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtvisualqueryHPP
