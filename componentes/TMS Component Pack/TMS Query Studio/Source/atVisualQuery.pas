unit atVisualQuery;

{$I tmsdefs.inc}
{$DEFINE ParamTreeView}

interface

uses
  {$IFDEF TMSDOTNET}
  Types,
  {$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, CheckLst, Grids, DBGrids, ComCtrls, ImgList, Menus,
  Db, Buttons, atMetaSQL, atSqlParser, TypInfo,
  atParamTreeView, atParHTML,
  {$IFDEF DELPHI6_LVL} Variants, {$ENDIF}
  atCheckListEdit, Mask, atQueryCombo, uDBUtil, atDatabase;

type
  TClauseOption = (
     coVisible,
     coEditable,
     coCheckBoxes,
     coChangePosition,
     coInsertCustom,
     coShortText
      );

  /// Description:
  ///   Used by some TatVisualQuery properties that allows you to specify what clause of SQL can be edited or visible
  ///   by the end-user. For example, you might want to not allow end-user  to specify source tables or even see the
  ///   source tables definition. Or, you might want end-user to see the chosen data fields, but not to edit them.
  ///   TClauseOptions is a set of TClauseOption type, which offers these options:
  ///     coVisible – Allows user to see the clause definitions;
  ///     coEditable – Allows user to edit the clause definitions.
  TClauseOptions = set of TClauseOption;

const
  {do not include coShortText}
  coDefaultClauseOptions = [coVisible..coInsertCustom];

  { for future implementation }
  coShowInactives     = coVisible;
  coClickSetup        = coEditable;
  coInsertInactives   = coEditable;
  coInsertAvailFields = coEditable;
  coDeleteItems       = coEditable;

  coCanInsert = [coInsertInactives,coInsertAvailFields,coInsertCustom,coEditable];
  {$IFNDEF TMSDOTNET}
  FAKE_OBJECT_INSERTION = pointer(1);
  {$ENDIF}

type
  TatVisualQuery = class;
  TatMetaSqlDefs = class;
  TatMetaSqlDef = class;
  TatParamDefs = class;
  TatParamDef = class;
  TatParamListItems = class;
  TatParamListItem = class;
  TatParamValues = class;
  TatParamValue = class;
  TatQueryDefContainer = class;

  TPopupMode = (pmFull, pmInsertion);

  /// Description:
  ///   Defines the type of editor used to edit parameter. Options are:
  ///   - ptFreeEdit: A simple edit component will be used to edit the parameter. User must type the parameter value.
  ///   - ptDistinctList: A combo box will be used to edit the parameter. User can type the parameter value or choose
  ///   one option from combo items. The items in combo will be automatically filled with content of database. For
  ///   example, if the parameter is “Customer city”, and the field “CustomerCity” will be compared to this parameter,
  ///   the combo items will be filled with all possible city names. A distinct query is made to the field in database
  ///   to get all distinct values for the field.
  ///   - ptQueryList: A combo box will be used to edit the parameter. The items of the combo will be the query
  ///   result of the sql statement specified in MetaSQLStr property. The different between ptDistinctList and
  ///   ptQueryList is that the query in distinct list is automatically built by TatVisualQuery, while with
  ///   ptQueryList it’s the user that specified the sql statement.
  ///   - ptChooseList: A combo box will be displayed for editing the parameter. Each item in combo box is related
  ///   to an item in ListItems property. Once the user chooses the combo box item, the related ListItem is applied.
  ///   See ListItems property for more details.
  ///   - ptCheckList: Same as ptChooseList, but a check combo box is displayed instead. User can then choose one
  ///   or more items, so that more than one ListItem can be applied. 
  TatParamType = (ptUnknown, ptFreeEdit, ptDistinctList, ptQueryList, ptChooseList, ptCheckList);

  {$IFNDEF TMSDOTNET}
  HackControl = class(TControl);
  {$ENDIF}

  TatInternalMetaSql = class(TatMetaSql)
  public
    //constructor Create(AOwner: TComponent); override;
    procedure SetParentComponent(Value: TComponent); override;
    function GetParentComponent: TComponent; override;
  end;

  TNotifyObjectEvent = procedure(Sender: TObject; AObject: TObject) of object;
  TVQTreeViewParamChangedEvent = procedure(Sender:TObject;ANode: TTreeNode;
    href,oldvalue,newvalue: string; obj, colobj: TObject) of object;

  /// Description:
  ///   TatVisualQuery is a component for visual SQL building. By dropping it on a form and setting some
  ///   properties, your end-user will be able to build their own SQL statements with a friendly interface.
  TatVisualQuery = class(TCustomPanel)
  private
    FTreeView                  : TatParamTreeView;
    FTreeViewPanel             : TPanel;
    FImageList                 : TImageList;
    FPopupMenu                 : TPopupMenu;
    FRefreshTimer              : TTimer;
    FParamPanel                : TPanel;
    FMetaSqlDefs               : TatMetaSqlDefs;  // collection
    FMetaSqlDef                : TatMetaSqlDef;   // current item
    FTablesOptions             : TClauseOptions;
    FFieldsOptions             : TClauseOptions;
    FConditionsOptions         : TClauseOptions;
    FGroupingOptions           : TClauseOptions;
    FOrderingOptions           : TClauseOptions;
    FParamsOptions             : TClauseOptions;
    FOnMetaSqlChange           : TNotifyEvent;
    FLastPopUpPoint            : TPoint;
    FPopupMode                 : TPopupMode;
    FResizeHeight              : integer;
    FAutoAdjustHeight          : boolean;
    FIgnoreVisualAdjustments   : boolean;
    FIgnoreTreeViewArrangement : boolean;
    FIgnoreParamChanges        : boolean;
    FChangingParamEditors      : boolean;
    FQueryEditor               : TForm;
    FMetaSql                   : TatMetaSql;   // reference to external MetaSql (to be synchronized)
    FTargetDataset             : TDataset;     // reference to external Dataset (to be synchronized)
    FAutoGrouping              : boolean;
    FAutoQueryOpen             : boolean;
    FEditorColor               : TColor; // cor de fundo dos editores dinâmicos
    FShowQueryTitle            : boolean;
    FEditQueryTitle            : boolean;
    FUpdateCount               : integer;
    FParamEditorsReadOnly      : boolean;
    FShowParamEditors          : boolean;
    FContainer                 : TatQueryDefContainer;
    FDatabase                  : TatDatabase;
    FSelectionColor            : TColor;
    FSelectionFontColor        : TColor;
    FItemHeight                : integer;
    FSQLSyntax                 : TatSQLSyntax;
    FSyntaxConf                : TSQLSyntaxConf;
    FDisablePrettyText         : Boolean;
    FOnTreeViewParamChanged: TVQTreeViewParamChangedEvent;
    FOnItemDeleted: TNotifyEvent;
    FOnItemDeleting: TNotifyObjectEvent;
    FQualifiedFieldAliases: Boolean;
    FFieldAliasSeparator: String;
    FTableNames: TStrings;
    FAutoUpdateFieldAliases: Boolean;
    {$IFDEF TMSDOTNET}
    FAKE_OBJECT_INSERTION: TObject;
    {$ENDIF}
    { event handlers }
    function GetMetaSqlDef: TatMetaSqlDef;
    procedure SetMetaSqlDefs(const Value: TatMetaSqlDefs);
    procedure TreeViewArrangement(Sender: TObject; Node: TTreeNode);
    procedure FTreeViewCheckUncheck(Sender: TObject);
    procedure FTreeViewDragOver(Sender, Source: TObject; X, Y: Integer;State: TDragState; var Accept: Boolean);
    procedure FTreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FTreeViewEditing(Sender: TObject; Node: TTreeNode;var AllowEdit: Boolean);
    procedure FTreeViewKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FTreeViewEdited(Sender: TObject; Node: TTreeNode;var S: String);
    procedure FRefreshTimerTimer(Sender: TObject);
    procedure FPopupMenuPopup(Sender: TObject);
    { param editor methods }
    procedure DestroyParamEditors;
    procedure CreateParamEditors(AForceAutosize:boolean=False);
    function UpdateMetaSqlParams: boolean;
    procedure UpdateMetaSql;
    function SetParamValue(AParamName, AValue: string): boolean;
    { private methods }
    procedure RefreshDataset;
    procedure TriggerQueryRefresh(Sender: TObject);
    procedure AdjustParamEditors;
    procedure AdjustTreeView;
    procedure AdjustVisualQueryPanel;
    procedure AutoAdjustEditorSize(Sender: TObject);
    procedure DeleteQueryItemClick(Sender: TObject);
    procedure OpenQueryItemClick(Sender: TObject);
    procedure SaveQueryItemClick(Sender: TObject);
    procedure NewQueryItemClick(Sender: TObject);
    function ClauseNodeOptions(AItem: TTreeNode): TClauseOptions;
    function GetNodeActive(ANode: TTreeNode): boolean;
    procedure SetNodeActive(ANode: TTreeNode; AValue: boolean);
    procedure DeleteItem(ANode: TTreeNode);
    procedure PrepareConditionItemsMenu(AObj:TObject);
    procedure PrepareFieldItemsMenu;
    procedure PrepareGroupItemsMenu;
    procedure PrepareItemMenu;
    procedure PrepareOrderItemsMenu;
    procedure PrepareParamItemsMenu;
    procedure PrepareQueryMenu;
    procedure PrepareTableItemsMenu;
    procedure IncludeItemClick(Sender: TObject);
    {$IFDEF TMSDOTNET}
    function AddMenuItem(AOwner:TMenuItem;ACaption:string;AClick:TNotifyEvent;ATag: Variant = nil): TMenuItem;
    {$ELSE}
    function AddMenuItem(AOwner:TMenuItem;ACaption:string;AClick:TNotifyEvent;ATag:integer = 0): TMenuItem;
    {$ENDIF}
    procedure SelectNodeByObject(AObj: TObject);
    function GetConditionCaption(ACond: TatSqlCondition;Html:boolean=False): string;
    function GetOrderFieldCaption(AOrdFld: TatSqlOrderField): string;
    function GetGroupFieldCaption(AGrpFld: TatSqlGroupField): string;
    function GetTableCaption(ATab: TatSqlTable): string;
    function FindTableMenuItem(mn: TMenuItem;ABaseField: TatSqlBaseField): TMenuItem;
    procedure CheckIncludeMenu(var mi: TMenuItem; AObj: TObject);
    function NodeAllowSubNodes(node: TTreeNode): boolean;
    function NodeHasObject(node: TTreeNode): boolean;
    procedure OpenNodePopupMenu(mode: TPopupMode);
    function GetColor: TColor;
    procedure SetColor(const Value: TColor);
    function HasMetaSqlDefs: Boolean;
    procedure CreateEmbeddedComponents;
    procedure SetAutoAdjustHeight(const Value: boolean);
    function FormatParametricCaption(ACaption: string;AImg:integer; AObj: TObject; AHtml:boolean=True): string;
    procedure TreeViewHtmlParamChanged(Sender: TObject; ANode: TTreeNode;href, oldvalue, newvalue: string);
    procedure TreeViewHtmlParamPopup(Sender: TObject; ANode: TTreeNode;href: string; values: TStringlist; var DoPopup: Boolean);
    procedure TreeViewMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure LoadFieldNameList(ATableName: string; lst: TStrings);
    procedure LoadTableNameList(lst: TStrings);
    function TableNameFromAlias(AAlias: string): string;
    procedure PrettyTextList(lst: TStringList; ASort: boolean=True );
    function DisplayLabelByFieldAlias(msql:TatMetaSql;AAlias: string): string;
    function FieldAliasByDisplayLabel(msql:TatMetaSql;ALabel: string): string;
    function JoinByForeignTableAlias(msql:TatMetaSql;AAlias: string): TatSqlJoin;
    function JoinByCondition(ACond: TatSqlCondition): TatSqlJoin;
    function FindInvalidItem(AObj: TObject): TObject;
    procedure TreeViewHtmlParamEditing(Sender: TObject; ANode: TTreeNode;href: string; var value: string);
    procedure TreeViewHtmlParamEdited(Sender: TObject; ANode: TTreeNode;href: string; var value: string);
    procedure RebuildParamEditors;
    procedure CheckMetaSqlIntegrity;
    procedure CheckTableChange(ATable: TatSqlTable; AOldName,
      ANewName: string);
    procedure UpdateFieldType(AField: TatSQLField);
    procedure TreeViewHtmlParamEnter(Sender: TObject; ANode: TTreeNode;
      href, value: string);
    procedure TreeViewHtmlParamExit(Sender: TObject; ANode: TTreeNode;
      href, value: string);
    procedure DrawQueryOnTreeView(node: TTreeNode; mdef: TatMetaSqlDef;
      msql: TatMetaSql; ASelectedObj: TObject; ATitle: string; atomic: boolean;AAtomicObj:TObject);
    function GetQueryEditor: TForm;
    function HtmlParam(AName, AValue: string; Html: boolean): string;
    procedure AdjustPopupPoint;
    procedure SetTargetDataset(const Value: TDataset);
    function CreateParamName(AParamName: string): string;
    function EllipsisHtml: string;
    procedure TreeViewDblClick(Sender: TObject);
    procedure HighlightEditor(ALabel: TLabel; AEditor: TWinControl; AEnabled: boolean);
    function MetaSqlIsConsistent: boolean;
    procedure SetAutoGrouping(const Value: boolean);
    function AutoUpdateMetaSql: boolean;
    function UpdateMetaSqlGrouping: boolean;
    function UpdateMetaSqlJoins: boolean;
    procedure SetAutoQueryOpen(const Value: boolean);
    procedure SetConditionsOptions(const Value: TClauseOptions);
    procedure SetFieldsOptions(const Value: TClauseOptions);
    procedure SetGroupingOptions(const Value: TClauseOptions);
    procedure SetOrderingOptions(const Value: TClauseOptions);
    procedure SetParamsOptions(const Value: TClauseOptions);
    procedure SetTablesOptions(const Value: TClauseOptions);
    procedure SetEditorColor(const Value: TColor);
    function TargetDatasetSql: string;
    procedure SetShowQueryTitle(const Value: boolean);
    procedure SetEditQueryTitle(const Value: boolean);
    function NodeIsMainCollection(node: TTreeNode): boolean;
    function NodeIsQueryTitle(node: TTreeNode): boolean;
    procedure SetParamEditorsReadOnly(const Value: boolean);
    procedure SetShowParamEditors(const Value: boolean);
    procedure SetMetaSqlDef(const Value: TatMetaSqlDef);
    procedure TreeViewUpdateImage(Sender: TObject; Node: TTreeNode);
    procedure UpdateNodeImage(Node: TTreeNode);
    procedure SetDatabase(const Value: TatDatabase);
    procedure SetSyntaxConf(Value: TSQLSyntaxConf);
    procedure SetSQLSyntax(const Value: TatSQLSyntax);
    function GetSelectionColor: TColor;
    procedure SetSelectionColor(const Value: TColor);
    function GetSelectionFontColor: TColor;
    procedure SetSelectionFontColor(const Value: TColor);
    function GetItemHeight: integer;
    procedure SetItemHeight(const Value: integer);
    function PrettyText(s: string): string;
    procedure SetDisablePrettyText(const Value: Boolean);
    procedure ImportDatafieldsDisplaylabels(ADataset: TDataset);
    procedure SetQualifiedFieldAliases(const Value: Boolean);
    procedure SetFieldAliasSeparator(const Value: String);
    procedure TableAliasChanged(ATable: TatSQLTable; ANewAlias: string);
    procedure ResolveMetaSQLReferences;
    function IsSyntaxConfStored: boolean;
    procedure SyntaxConfChanged(Sender: TObject);
  protected
    procedure Resize; override;
    function GetChildOwner: TComponent; override;
    function GetUniqueMetaSqlName: string;
    procedure CreateWnd; override;
    procedure SetName(const Value: TComponentName); override;
    procedure Loaded; override;
    property QueryEditor: TForm read GetQueryEditor;
    procedure Notification(AComponent: TComponent;Operation: TOperation); override;
    property TreeView: TatParamTreeView read FTreeView;
    procedure ParamEditorsActivation(AEnable: boolean);
    function IsLoading: boolean;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure ClearDatabaseInfo;
    procedure LoadTreeView( AObj: TObject=nil );

    /// Description:
    ///   Call Assign to copy query properties from one TatVisualQuery to another. Styling properties are not copied.
    procedure Assign( ASource: TPersistent ); override;

    /// Description:
    ///   Call FullExpand to fully expand the nodes of TatVisualQuery component.
    procedure FullExpand;

    /// Description:
    ///   ImportFromTargetDataset will search for an SQL statement in the dataset specified by TargetDataset
    ///   property, and then update all query definitions in TatVisualQuery based on the SQL statement.
    procedure ImportFromTargetDataset;

    /// Description:
    ///   ImportFromTargetMetaSQL will update all TatVisualQuery query definitions with the definitions of metasql
    ///   component specified by TargetMetaSQL property. 
    procedure ImportFromTargetMetaSql;

    /// Description:
    ///   Call ImportQueriesFromFile to load query definitions saved in a file. This method will display an open
    ///   file dialog for choosing file name. 
    procedure ImportQueriesFromFile;

    /// Description:
    ///   Call ExportQueriesToFile to save query definitions to a file. This method will display a save file dialog
    ///   for choosing file name.
    procedure ExportQueriesToFile;

    /// Description:
    ///   Use BeginUpdate/EndUpdate methods to avoid TatVisualQuery to be visually updated while its properties are being changed.
    procedure BeginUpdate;

    /// Description:
    ///   Use BeginUpdate/EndUpdate methods to avoid TatVisualQuery to be visually updated while its properties are being changed.
    procedure EndUpdate;

    procedure UpdateCurrentQuery(ARefresh:boolean=True);

    /// Description:
    ///   Call VisualUpdate to refresh TatVisualQuery displaying of tree view and parameter editors.
    procedure VisualUpdate;
    
    property MetaSqlDef: TatMetaSqlDef read GetMetaSqlDef write SetMetaSqlDef;

    /// Description:
    ///   Use SaveQueriesToFile to save built queries to a file.
    procedure SaveQueriesToFile(AFileName: string);

    /// Description:
    ///   Use LoadQueriesFromFile to load built queries from a file.
    procedure LoadQueriesFromFile(AFileName: string);
    
    procedure SaveQueriesToStream(AStream: TStream);
    procedure LoadQueriesFromStream(AStream: TStream);
  published
    /// Description:
    ///   TargetMetaSQL points to a TatMetaSQL component. When end-user defines the query in TatVisualQuery
    ///   component, the TargetMetaSQL will be updated to reflect the new SQL built in TatVisualQuery.
    property TargetMetaSQL              : TatMetaSQL       read FMetaSQL           write FMetaSQL;

    /// Description:
    ///   Points to a TatMetaSQLDefs collection which holds information for all queries built in TatVisualQuery.
    ///   Title of the query and the SQL statement are available in the items of this collection.
    property MetaSqlDefs                : TatMetaSqlDefs   read FMetaSqlDefs       write SetMetaSqlDefs stored HasMetaSqlDefs;

    /// Description:
    ///   Specifies if "source tables" SQL clause (FROM) can be edited or visible by end-user.
    ///   See TClauseOptions for more details.
    property OptionsForSourceTables     : TClauseOptions   read FTablesOptions     write SetTablesOptions default coDefaultClauseOptions;

    /// Description:
    ///   Specifies if "data fields" SQL clause (SELECT) can be edited or visible by end-user.
    /// See Also:
    ///   TClauseOptions
    property OptionsForDataFields       : TClauseOptions   read FFieldsOptions     write SetFieldsOptions default coDefaultClauseOptions;

    /// Description:
    ///   Specifies if "filter conditions" SQL clause (WHERE) can be edited or visible by end-user.
    /// See Also:
    ///   TClauseOptions
    property OptionsForFilterConditions : TClauseOptions   read FConditionsOptions write SetConditionsOptions default coDefaultClauseOptions;

    /// Description:
    ///   Specifies if "grouping fields" SQL clause (GROUP BY) can be edited or visible by end-user.
    /// See Also:
    ///   TClauseOptions
    property OptionsForGroupingFields   : TClauseOptions   read FGroupingOptions   write SetGroupingOptions default coDefaultClauseOptions;

    /// Description:
    ///   Specifies if "ordering fields" SQL clause (ORDER BY) can be edited or visible by end-user.
    /// See Also:
    ///   TClauseOptions
    property OptionsForOrderingFields   : TClauseOptions   read FOrderingOptions   write SetOrderingOptions default coDefaultClauseOptions;

    /// Description:
    ///   Specifies if "parameter editors" clause can be edited or visible by end-user.
    /// See Also:
    ///   TClauseOptions
    property OptionsForParameterEditors : TClauseOptions   read FParamsOptions     write SetParamsOptions default coDefaultClauseOptions;

    /// Description:
    ///   This event is fired whenever user changes query definition in TatVisualQuery component, which in turn
    ///   causes the SQL to be updated.
    property OnMetaSqlChange            : TNotifyEvent     read FOnMetaSqlChange   write FOnMetaSqlChange;

    /// Description:
    ///   When AutoAdjustHeight property is true, the ResizeHeight property indicates the maximum height of
    ///   TatVisualQuery component.
    property ResizeHeight               : integer          read FResizeHeight      write FResizeheight;
    
    property Color                      : TColor           read GetColor           write SetColor default clWindow;

    /// Description:
    ///   If AutoAdjustHeight property is true, TatVisualQuery height will increase as the nodes are expanded by
    ///   the end-user. The maximum height it can grow is defined by ResizeHeight property.
    property AutoAdjustHeight           : boolean          read FAutoAdjustHeight    write SetAutoAdjustHeight default False;

    /// Description:
    ///   Specifies the dataset component that will be automatically updated by TatVisualQuery component. Not all
    ///   datasets are support, and the support dataset depends on the engine used defined by TatDatabase property.
    ///   The following tables lists the supported datasets for each engine used:
    ///     BDE - TQuery
    ///     ADO - TADOQuery
    ///     IBX - TIBQuery
    ///     DBExpress - TSQLQuery, TSimpleDataset and TClientDataset
    property TargetDataset              : TDataset         read FTargetDataset     write SetTargetDataset;

    /// Description:
    ///   Set AutoGrouping property to True to let visual query automatically build Group By clause of SQL. If the
    ///   user defines an aggregate function (Sum, Count, etc.) for one or more fields, the SQL will be automatically
    ///   grouped by the fields that are not part of aggregated functions.
    property AutoGrouping               : boolean          read FAutoGrouping write SetAutoGrouping default True;

    /// Description:
    ///   If AutoQueryOpen property is true, the dataset specified by TargetDataset will be automatically closed
    ///   and reopened whenever SQL changes.
    property AutoQueryOpen              : boolean          read FAutoQueryOpen write SetAutoQueryOpen default True;

    /// Description:
    ///   Contains the color of parameter editors.
    property EditorColor                : TColor           read FEditorColor write SetEditorColor default clWindow;

    /// Description:
    ///   Set ShowQueryTitle property to false to hide the name of query title, displayed at the top of
    ///   TatVisualQuery component.
    property ShowQueryTitle             : boolean          read FShowQueryTitle write SetShowQueryTitle default True;

    /// Description:
    ///   EditQueryTitle property specifies if end-user can edit the query name directly in TatVisualQuery component
    ///   (True) or not (False).
    property EditQueryTitle             : boolean          read FEditQueryTitle write SetEditQueryTitle default True;

    /// Description:
    ///   This property specifieds if end-user can change parameter values in parameter editors. If ParamEditorsReadOnly
    ///   is True, the param editors wil be read-only and user will not be able to change their values.
    property ParamEditorsReadOnly       : boolean          read FParamEditorsReadOnly write SetParamEditorsReadOnly default False;

    /// Description:
    ///   Set this property to false if you don’t want parameter editors to be displayed.
    property ShowParamEditors           : boolean          read FShowParamEditors write SetShowParamEditors default True;

    /// Description:
    ///   Set this property to one of TatDatabase descendants to specify which engine will be used and how to
    ///   connect to databases.  Options are TatBDEDatabase (for BDE), TatADODatabase (for ADO), TatIBXDatabase
    ///   (for IBX) and TatDBXDatabase (for dbExpress).
    property Database                   : TatDatabase      read FDatabase write SetDatabase;

    /// Description:
    ///   Specifies in which syntax the SQL will be built. See TatMetaSQL.SQLSyntax property for more details. 
    property SQLSyntax                  : TatSQLSyntax    read FSQLSyntax write SetSQLSyntax;

    property SyntaxConf                 : TSQLSyntaxConf  read FSyntaxConf write SetSyntaxConf stored IsSyntaxConfStored;
    property DisablePrettyText          : Boolean read FDisablePrettyText write SetDisablePrettyText;

    /// Description:
    ///   When two fields with same name exist in two different tables, visual query automatically set its field
    ///   alias. For example, a CustNo field might exist in both Customer and Orders tables. QualifiedFieldAliases
    ///   property defines how visual query will build the automatic field alias for fields with same names.
    ///   If QualifiedFieldAliases is false, fields will be differentiated by numbers (CustNo, CustNo1, CustNo2, etc.)
    ///   If QualifiedFieldAliases if true, fields will receive a prefix with the table alias and a field separator,
    ///   defined by FieldAliasSeparator property (Customer_CustNo, Orders_CustNo).
    property QualifiedFieldAliases      : Boolean read FQualifiedFieldAliases write SetQualifiedFieldAliases;

    /// Description:
    ///   Defines the string which will separate table alias from field name in the field aliases built. This property
    ///   is only used if QualifiedFieldAliases property is true.
    property FieldAliasSeparator        : String read FFieldAliasSeparator write SetFieldAliasSeparator;

    /// Description:
    ///   This property is only used if QualifiedFieldAliases is set to true. If AutoUpdateFieldAlias is true, whenever
    ///   the user changes a table alias, all field alias which was prefixed by the table alias are changed. For example,
    ///   suppose you have a field alias Customer_CustNo. If you change table alias from Customer” to “Cust” and
    ///   AutoUpdateFieldAlias is true, the field alias will change from “Customer_CustNo” to “Cust_CustNo”.
    ///   If AutoUpdateFieldAlias is false, the table alias changes, but the field alias remains the same.
    property AutoUpdateFieldAliases     : Boolean read FAutoUpdateFieldAliases write FAutoUpdateFieldAliases;

    property SelectionColor: TColor read GetSelectionColor write SetSelectionColor;
    property SelectionFontColor: TColor read GetSelectionFontColor write SetSelectionFontColor;
    property ItemHeight: integer read GetItemHeight write SetItemHeight;
    property OnTreeViewParamChanged: TVQTreeViewParamChangedEvent read FOnTreeViewParamChanged write FOnTreeViewParamChanged;
    property OnItemDeleting: TNotifyObjectEvent read FOnItemDeleting write FOnItemDeleting;
    property OnItemDeleted: TNotifyEvent read FOnItemDeleted write FOnItemDeleted;

    property Align;
    property Anchors;
    property BorderStyle default bsSingle;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  /// Description:
  ///   TatMetaSQLDefs class holds a collection of TatMetaSQLDef classes.
  /// See Also:
  ///   TatMetaSQLDef
  TatMetaSqlDefs = class(TOwnedCollection)
  private
    function GetItem(i: integer): TatMetaSqlDef;
  public
    function Add:TatMetaSqlDef;
    function IndexOf(ATitle:string):integer;
    property Items[i:integer]:TatMetaSqlDef read GetItem; default;
    {$IFDEF TMSDOTNET}
    function GetOwner: TPersistent; override;
    {$ENDIF}
  end;

  /// Description:
  ///   TatMetaSQLDef contains information of queries built in TatVisualQuery. TatVisualQuery holds this collection
  ///   in MetaSQLDefs property, and it is built this way (as a collection) because it can hold more that just one
  ///   query. Once the TatVisualQuery component holds more than one query, end-user can choose what query to
  ///   edit/execute by right - clicking on left top icon of TatVisualQuery component and choosing the query from
  ///   the popup menu that is displayed.
  TatMetaSqlDef = class(TCollectionItem)
  private
    FTitle : string;
    FMetaSql : TatInternalMetaSql;
    FParamDefs : TatParamDefs;
    FTempMetaSQLName: string;
    procedure SetMetaSql(const Value: TatInternalMetaSql);
    procedure SetParamDefs(const Value: TatParamDefs);
    function GetMetaSql: TatInternalMetaSql;
    function VisualQuery: TatVisualQuery;
    function IsStoredMetaSql: Boolean;
    function HasParamDefs: Boolean;
    function GetMetaSQLName: string;
    procedure SetMetaSQLName(const Value: string);
    procedure ResolveMetaSQLReference;
  public
    constructor Create(ACollection:TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function AllowSetup: boolean;
  published
    property MetaSQLName: string read GetMetaSQLName write SetMetaSQLName;

    /// Description:
    ///   Points to a internally created TatMetaSQL component that contains meta sql information about the query
    ///   created. Use MetaSQL.SQL property to get the SQL statement of query created.
    property MetaSql: TatInternalMetaSql read GetMetaSql write SetMetaSql stored {IsStoredMetaSql}false;

    /// Description:
    ///   Holds the title of query. Title is displayed on top of TatVisualQuery component, and also in the popup
    ///   menu where end-user chooses which query is active.
    property Title: string read FTitle write FTitle;

    /// Description:
    ///   ParamDefs property holds the definition of parameters specified in TatVisualQuery component.
    property ParamDefs: TatParamDefs read FParamDefs write SetParamDefs stored HasParamDefs;
  end;

  /// Description:
  ///   TatParamDefs class holds a collection of TatParamDef classes.
  /// See Also:
  ///   TatParamDef
  TatParamDefs = class(TOwnedCollection)
  private
    function GetItem(i: integer): TatParamDef;
  public
    function Add: TatParamDef;
    property Items[i:integer]: TatParamDef read GetItem; default;
  end;

  /// Description:
  ///   TatParamDef holds the definition of each parameter specified in TatVisualQuery component.
  TatParamDef = class(TCollectionItem)
  private
    FName       : string;
    FCaption    : string;
    FParamType  : TatParamType; { (ptUnknown, ptFreeEdit, ptDistinctList, ptQueryList, ptChooseList, ptCheckList }
    FDataType   : TFieldType;
    FListItems  : TatParamListItems;
    FMetaSql    : TatMetaSql;
    FMetaSqlStr : string;
    FActive     : boolean;
    FField      : TatSqlField;
    FValue      : variant;
    FText       : string;
    FEditor     : TWinControl;
    FLabel      : TLabel;
    FWidth      : integer;
    procedure SetCaption(const Value: string);
    procedure SetDataType(const Value: TFieldType);
    procedure SetListItems(const Value: TatParamListItems);
    procedure SetName(const Value: string);
    procedure SetParamType(const Value: TatParamType);
    procedure SetMetaSql(const Value: TatMetaSql);
    procedure SetActive(const Value: boolean);
    procedure SetValue(const Value: variant);
    function GetMetaSql: TatMetaSql;
    function GetMetaSQLStr: string;
    function IsStoredMetaSql: Boolean;
    function IsStoredMetaSqlStr: Boolean;
    procedure SetMetaSQLStr(const Value: string);
    function GetField: TatSqlField;
    procedure SetField(const Value: TatSqlField);
    function HasListItems: Boolean;
    function HasValue: Boolean;
    function GetValue: variant;
    function GetText: string;
    procedure SetText(const Value: string);
    procedure LoadComboItems(Sender: TObject);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function MetaSqlDef: TatMetaSqlDef;
    function VisualQuery: TatVisualQuery;

    /// Description:
    ///   Use Field property to get TatSQLField object that represents the field which will be compared with the parameter.
    property Field: TatSqlField read GetField write SetField;

    /// Description:
    ///   Use Editor property to have direct access to the control being used to edit the parameter.
    property Editor: TWinControl read FEditor;

    /// Description:
    ///   Use EditorLabel property to have direct access to the label component being used to display the parameter caption.
    property EditorLabel: TLabel read FLabel;

    /// Description:
    ///   Contains the default item to be applied to parameter. Only used when ParamType is ptChooseList and ptCheckList.
    function DefaultItem: TatParamListItem;

    /// Description:
    ///   Use this property to check if param value is null. 
    function IsNull: boolean;
  published
    /// Description:
    ///   Contains the name of parameter. The name identifies the parameter uniquely, and is used by meta sql to
    ///   find the referenced parameter. As an example, Name can be ‘CustomerName’, or ‘OrderNo’.
    property Name      : string read FName write SetName;

    /// Description:
    ///   Caption contains the text of parameter that will be displayed for the end-user. For example,
    ///   ‘Customer name’, ‘Order number’, or ‘Choose start date’. A label is put right above the parameter
    ///   editor, and the label caption contains the string specified in this Caption property.
    property Caption   : string read FCaption write SetCaption;

    /// Description:
    ///   ParamType defines the type of editor used to edit parameter.
    /// See Also:
    ///   TatParamType
    property ParamType : TatParamType read FParamType write SetParamType default ptFreeEdit;

    /// Description:
    ///   Indicates data type of parameter.
    property DataType  : TFieldType read FDataType write SetDataType default ftString;

    /// Description:
    ///   This property is only used when ParamType is ptChooseList or ptCheckList. The ListItems property holds a
    ///   collection of TatParamListItem objects. Each of these objects contains information about how SQL will be
    ///   updated. When end-user chooses an item in the combo, the related list item object is applied to SQL.
    /// See Also:
    ///   TatParamListItem
    property ListItems : TatParamListItems read FListItems write SetListItems stored HasListItems;

    /// Description:
    ///   If Active property is true, the parameter will not influentiate the SQL.
    property Active    : boolean read FActive write SetActive default True;

    /// Description:
    ///   MetaSQL property contains the meta sql information of MetaSQLStr property. You can read/write MetaSQLStr
    ///   property or change properties of MetaSQL. They are in sync with each other.
    property MetaSql   : TatMetaSql read GetMetaSql write SetMetaSql stored IsStoredMetaSql;

    /// Description:
    ///   MetaSQLStr contains the SQL to be used when ParamType is ptQueryList. You can read/write MetaSQLStr
    ///   property or change properties of MetaSQL. They are in sync with each other.
    property MetaSqlStr: string read GetMetaSqlStr write SetMetaSqlStr stored IsStoredMetaSqlStr;

    /// Description:
    ///   Use Width property to set the width of the control used to edit the parameter.
    property Width     : integer read FWidth write FWidth default 80;

    /// Description:
    ///   Value property contains the value of parameter to be used in SQL. Changing editor content will update
    ///   this property, and writing to this property will cause editor content to be updated.
    property Value     : variant read GetValue write SetValue stored HasValue;

    /// Description:
    ///   Contans the string representation of parameter value. 
    property Text      : string read GetText write SetText; // should be after Value
  end;

  /// Description:
  ///   Collection of TatParamListItem
  /// See Also:
  ///   TatParamListItem
  TatParamListItems = class(TOwnedCollection)
  private
    function GetItem(i: integer): TatParamListItem;
  public
    function Add: TatParamListItem;
    property Items[i: integer]: TatParamListItem read GetItem; default;
  end;

  /// Description:
  ///   TatParamListItem holds information about each item from a parameter editor list
  TatParamListItem = class(TCollectionItem)
  private
    FText : string;
    FParamValues : TatParamValues;
    procedure SetParamValues(const Value: TatParamValues);
    procedure SetText(const Value: string);
    function HasParamValues: Boolean;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    /// Description:
    ///   Contains the caption of the item. For example, “Medium-valued orders”.
    property Text : string read FText write SetText;

    /// Description:
    ///   Contains the parameter values that will be set. TatParamValues is a collection of TatParamValue classes.
    /// See Also:
    ///   TatParamValues
    property ParamValues : TatParamValues read FParamValues write SetParamValues stored HasParamValues;
  end;

  /// Description:
  ///   Collection of TParamValue
  /// See Also:
  ///   TatParamValue
  TatParamValues = class(TOwnedCollection)
  private
    function GetText(i: integer): string;
    function GetItem(i: integer): TatParamValue;
    function GetValues(s: string): string;
    procedure SetValues(s: string; const Value: string);
    function GetName(i: integer): string;
    procedure SetName(i: integer; const Value: string);
    procedure SetText(i: integer; const Value: string);
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function IndexOfName(const AName: string): integer;
    property Values[s: string]: string read GetValues write SetValues;
    property Names[i: integer]: string read GetName write SetName;
    property Texts[i: integer]: string read GetText write SetText; default;
    property Items[i:integer]: TatParamValue read GetItem;
    function Add(s: string): TatParamValue;
  end;

  TatParamValue = class(TCollectionItem)
  private
    FText: string;
    function GetValue: string;
    procedure SetValue(const AValue: string);
    function GetName: string;
    procedure SetName(const AValue: string);
    function GetText: string;
    procedure SetText(const AValue: string);
  public
    procedure Assign(ASource: TPersistent); override;

    /// Description:
    ///   Contains the value of parameter. You can read or write this value. It might contain, for example, “0” or “20000”.
    property Value: string read GetValue write SetValue;

    /// Description:
    ///   Contains the name of parameter that will be set, for example “LowValue” or “HighValue”.
    property Name: string read GetName write SetName;
  published
    /// Description:
    ///   Contains the full text for setting parameter, in the format “ParameterName=Value”. For example, “LowValue=0”, or “HighValue=20000”.
    property Text: string read GetText write SetText;
  end;

  TatQueryDefContainer = class(TComponent)
  private
    FVisualQuery : TatVisualQuery;
    procedure SetMetaSqlDefs(const Value: TatMetaSqlDefs);
    function GetMetaSqlDefs: TatMetaSqlDefs;
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  published
    property MetaSqlDefs: TatMetaSqlDefs read GetMetaSqlDefs write SetMetaSqlDefs;
  end;

implementation

uses
  fCustomEditor,
  fCustomTableEditor,
  fCustomGroupEditor,
  fCustomOrderEditor,
  fCustomFieldEditor,
  fSingleFieldEditor,
  fExpressionFieldEditor,
  fCompareConditionEditor,
  fExpressionConditionEditor,
  fSubconditionsEditor,
  fFreeEditParamEditor,
  fDistinctListParamEditor,
  fQueryListParamEditor,
  fChooseListParamEditor,
  fCheckListParamEditor,
  fQueryEditor,
  qsRes;

const
  UNDEFINED_PARAM = '';          // valor de um item nulo no meta-sql
  UNDEFINED_VALUE = 'undefined'; // valor mostrado no ParamTreeViem

procedure Msg(s:string);
begin
  ShowMessage(s);
end;

procedure SetControlPos(AControl:TControl;x,y:integer);
var r:TRect;
begin
  with AControl do
  begin
    r := BoundsRect;
    r.Right := r.Right + (x - r.Left);
    r.Bottom := r.Bottom + (y - r.Top);
    r.Left := x;
    r.Top := y;
    BoundsRect := r;
  end;
end;

procedure SetControlWidth(AControl:TControl;w:integer);
var r:TRect;
begin
  with AControl do
  begin
    r := BoundsRect;
    r.Right := r.Left + w - 0;
    BoundsRect := r;
  end;
end;

procedure SetControlHeight(AControl:TControl;h:integer);
var r:TRect;
begin
  with AControl do
  begin
    r := BoundsRect;
    r.Bottom := r.Top + h - 0;
    BoundsRect := r;
  end;
end;

procedure SetControlTop(AControl:TControl;y:integer);
var r:TRect;
begin
  with AControl do
  begin
    r := BoundsRect;
    r.Bottom := r.Bottom + (y-r.Top);
    r.Top := y;
    BoundsRect := r;
  end;
end;

procedure IncreaseControlDimensions(AControl:TControl;dw,dh:integer);
var r:TRect;
begin
  with AControl do
  begin
    r := BoundsRect;
    r.Right := r.Right + dw;
    r.Bottom := r.Bottom + dh;
    BoundsRect := r;
  end;
end;

procedure WriteComponentResStreamText(AStream: TStream; AInstance:TComponent);
var
  binStream : TMemoryStream;
begin
  binStream := TMemoryStream.Create;
  try
    binStream.WriteComponent(AInstance);
    binStream.Seek(0, soFromBeginning);
    ObjectBinaryToText(binStream, AStream);
  finally
    binStream.Free
  end;
end;

function ReadComponentResStreamText(AStream: TStream; Instance: TComponent=nil): TComponent;
var
  binStream  : TMemoryStream;
begin
  binStream := TMemoryStream.Create;
  try
    ObjectTextToBinary(AStream, binStream);
    binStream.Seek(0, soFromBeginning);
    Result := BinStream.ReadComponent(Instance);
  finally
    binStream.Free;
  end;
end;

procedure TatVisualQuery.RebuildParamEditors;
begin
  { Carrega o painel de filtros }
  DestroyParamEditors; 
  CreateParamEditors;
end;

procedure TatVisualQuery.UpdateCurrentQuery(ARefresh:boolean=True);
begin
   { Carrega o TreeView com a meta-sql }
   LoadTreeView;
   RebuildParamEditors;

   { reajusta os controles visuais do VisualQuery }
   AdjustVisualQueryPanel;

   { atualiza a Meta-sql com as definições do VisualQuery }
   if ARefresh then
      RefreshDataset;
end;

procedure TatVisualQuery.DestroyParamEditors;
var c: integer;
begin
  FChangingParamEditors := True;
  with MetaSqlDef, ParamDefs do
  try
    { primeiro exclui editores existentes }
    for c:=Count-1 downto 0 do
      with Items[c] do
      begin
         if Assigned(FEditor) then
         begin
           { armazena o valor do editor antes de destrui-lo }
           FValue := GetValue;
           FText := GetText;
           FreeAndNil(FEditor);
         end;
         if Assigned(FLabel) then
           FreeAndNil(FLabel);
      end;
  finally
    FChangingParamEditors := False;
  end;
end;

procedure TatVisualQuery.CreateParamEditors(AForceAutosize:boolean=False);
var c   : integer;
    c1  : integer;
begin
  FIgnoreVisualAdjustments := True;
  FChangingParamEditors := True;
  if FParamPanel <> nil then with MetaSqlDef, ParamDefs do
  try
    { cria os editores correspondentes aos parâmetros da consulta }
    for c:=0 to Count-1 do
      with Items[c] do
        if not Assigned(FLabel) and not Assigned(FEditor) then
        begin
          { cria o editor para o parâmetro }
          case ParamType of
            ptFreeEdit:
              begin
                FEditor := TMaskEdit.Create(Self);
                with TMaskEdit(FEditor) do
                begin
                   OnChange := TriggerQueryRefresh;
                   Color := EditorColor;
                   Enabled := not FParamEditorsReadOnly;
                   Parent := FParamPanel;
                end;
              end;

            ptDistinctList,
            ptQueryList:
              begin
                FEditor := TatComboBox.Create(Self);
                with TatComboBox(FEditor) do
                begin
                   OnSetKeyValue := TriggerQueryRefresh;
                   OnChangeItems := AutoAdjustEditorSize;
                   Color := EditorColor;
                   Enabled := not FParamEditorsReadOnly;
                   OnLoadItems := LoadComboItems;
                   Parent := FParamPanel;
                   { se está criando pela primeira vez o editor,
                     então também abre sua query para testá-la e já determinar
                     uma largura mínima para o combo }
                   if AForceAutosize then
                     DoLoadItems;
                end;
              end;

            ptChooseList:
              begin
                FEditor := TatComboBox.Create(Self);
                with TatComboBox(FEditor) do
                begin
                   OnChange := TriggerQueryRefresh;
                   Color := EditorColor;
                   Enabled := not FParamEditorsReadOnly;
                   Parent := FParamPanel;
                   for c1:=1 to ListItems.Count-1 do // first item is the default
                     Items.AddObject( ListItems[c1].Text, ListItems[c1] );
                end;
              end;

            ptCheckList:
              begin
                FEditor:=TatCheckListEdit.Create(Self);
                with TatCheckListEdit(FEditor) do
                begin
                   OnChange := TriggerQueryRefresh;
                   Color := EditorColor;
                   Enabled := not FParamEditorsReadOnly;
                   for c1:=1 to ListItems.Count-1 do // first item is the default
                     Items.AddObject( ListItems[c1].Text, ListItems[c1] );
                   Parent := FParamPanel;
                end;
              end;
            else
              FEditor := nil;
          end;

          { cria o rótulo do parâmetro }
          FLabel := TLabel.Create(Self);
          with FLabel do
          begin
             Caption := ParamDefs[c].Caption;
             FEditor.Width := FLabel.Width + 20;
             {$IFDEF TMSDOTNET}
             FEditor.Tag := Variant(FLabel);   
             {$ELSE}
             FEditor.Tag := integer( FLabel ); // referencia o label no editor
             {$ENDIF}
             FocusControl := FEditor; // referencia o editor no label
             Parent := FParamPanel;
          end;

          { garante que o handle do editor já esteja disponível para uso }
          FEditor.HandleNeeded;

          { ajusta o valor do conteúdo do editor }
          SetValue( FValue );
          SetText( FText );

          { controla a visibilidade do editor de acordo com seu conteúdo }
          HighlightEditor( FLabel, FEditor, not IsNull );
        end;

  finally
    FIgnoreVisualAdjustments := False;
    FChangingParamEditors := False;
  end;
end;

function TatVisualQuery.SetParamValue(AParamName: string; AValue: string): boolean;
var keyword : string;
    year, month, day : word;
    valueStr : string;
    prm : TatSqlParam;
begin
  prm := TatSqlParam(MetaSqlDef.MetaSql.Params.FindParam(AParamName));
  if Assigned(prm) then
    with prm do
    begin
      Active := True;
      { translate param value, unsing special keywords }
      DecodeDate(Date,Year,Month,Day);
      keyword := LowerCase( Trim( AValue ));
      if (keyword = '') or (keyword = 'off') or (keyword = _str(SOff)) then
        Active := False
      else if (keyword = 'null') or (keyword = _str(SNull)) then
        valueStr := ''
      else if (keyword = 'date') or (keyword = _str(SDate)) then
        valueStr := DateTimeToStr(Date)
      else if (keyword = 'today') or (keyword = _str(SToday)) then
        valueStr := DateToStr(Date)
      else if (keyword = 'now') or (keyword = _str(SNow)) then
        valueStr := DateTimeToStr(Now)
      else if (keyword = 'day') or (keyword = _str(SDay)) then
        valueStr := IntToStr(day)
      else if (keyword = 'month') or (keyword = _str(SMonth)) then
        valueStr := IntToStr(month)
      else if (keyword = 'year') or (keyword = _str(SYear)) then
        valueStr := IntToStr(year)
      else if copy(keyword,1,1) = '=' then
        valueStr := MetaSqlDef.MetaSql.Params.ParamByName(copy(keyword,2,MaxInt)).AsString
      else
        valueStr := AValue;

      { assign value according to the param datatype }
      if (valueStr='') then
        Clear
      else
        case DataType of
          ftString : AsString := valueStr;
          ftInteger : AsInteger := StrToInt(valueStr);
          ftDate : AsDate := StrToDate(valueStr);
          ftDateTime : AsDateTime := StrToDateTime(valueStr);
          ftCurrency : AsCurrency := StrToCurr(valueStr);
          ftFloat : AsFloat := StrToFloat(valueStr);
          ftBoolean : AsBoolean := UpperCase(copy(valueStr,1,1))='T'; // !!!
        else
          Value := valueStr;
        end;

      result := Active;
    end
  else
    result := False;
end;

procedure TatVisualQuery.HighlightEditor( ALabel: TLabel; AEditor: TWinControl; AEnabled: boolean );
begin
  if (ALabel <> nil) and (AEditor <> nil) then
  begin
    if AEnabled then
    begin
      { editor destacado }
      ALabel.Font.Color := clWindowText;
      {$IFDEF TMSDOTNET}
      AEditor.Font.Color := clWindowText;
      AEditor.Color := EditorColor;
      {$ELSE}
      HackControl(AEditor).Font.Color := clWindowText;
      HackControl(AEditor).Color := EditorColor;
      {$ENDIF}
    end
    else
    begin
      { editor discreto }
      ALabel.Font.Color := clGrayText; //InactiveCaptionText;
      {$IFDEF TMSDOTNET}
      AEditor.Font.Color := clGrayText;
      AEditor.Color := Self.Color;
      {$ELSE}
      HackControl(AEditor).Font.Color := clGrayText;
      HackControl(AEditor).Color := Self.Color;
      {$ENDIF}
    end;
  end;
end;

function TatVisualQuery.UpdateMetaSqlParams: boolean;
var c    : integer;
    i,j  : integer;
    txt  : string;
    enab : boolean;
begin
  result := True; {*** deveria retornar True somente quando algum parâmetro foi alterado ***}

  // update param data types (not implemented)

  { first, clear and deactivate all params }
  with MetaSqlDef.MetaSql.Params do
    for c:=0 to Count-1 do
      with Items[c] do
      begin
        Clear;
        Active := false;
      end;

  { load MetaSql params from editors }
  with MetaSqlDef.ParamDefs do
    for c:=0 to Count-1 do
      with Items[c] do
      begin
        enab := False;

        case ParamType of
          ptFreeEdit,
          ptDistinctList:
            enab := SetParamValue( Name, Text );

          ptQueryList:
            enab := SetParamValue( Name, VarToStr(Value) );

          ptChooseList:
            begin
              { primeiro aplica os parâmetros default }
              with DefaultItem.ParamValues do
                for j:=0 to Count-1 do
                begin
                  txt := Values[ Names[j] ];
                  SetParamValue( Names[j], txt );
                end;
              { depois aplica os parâmetros correspondentes ao item selecionado }
              i := TComboBox(FEditor).ItemIndex + 1;
              if i>0 then
                with ListItems[i].ParamValues do
                  for j:=0 to Count-1 do
                  begin
                    txt := Values[Names[j]];
                    SetParamValue( Names[j], txt );
                    enab := True;
                  end;
            end;

          ptCheckList:
            begin
              { primeiro aplica os parâmetros default }
              { depois aplica os parâmetros correspondentes aos itens selecionados }
              for i := 0 to ListItems.Count-1 do
                with ListItems[i].ParamValues do
                  if (i=0) or (TatCheckListEdit(FEditor).Checked[i-1]) then
                    for j:=0 to Count-1 do
                    begin
                      txt := Values[ Names[j] ];
                      SetParamValue( Names[j], txt );
                      enab := (i>0);
                    end;
            end;
        end;

        { controla a visibilidade do editor de acordo com seu conteúdo }
        HighlightEditor( FLabel, FEditor, enab );
      end;
end;

function TatParamDef.IsNull: boolean;
begin
  case ParamType of
    ptFreeEdit:
      result := TMaskEdit(Editor).Text = '';

    ptDistinctList:
      result := TatComboBox(Editor).Text = '';

    ptQueryList:
      result := TatComboBox(Editor).Text = '';

    ptChooseList:
      result := TatComboBox(Editor).Text = '';

    ptCheckList:
      result := TatCheckListEdit(FEditor).Text = '';

    else
      result := True;
  end;
end;

function TatVisualQuery.MetaSqlIsConsistent: boolean;
begin
  result := True;
end;

function TatVisualQuery.UpdateMetaSqlGrouping: boolean;
begin
  result := MetaSqlDef.MetaSql.AutoUpdateGroupFields
end;

function IsUndefined(s:string): boolean;
begin
  result := (s='') or (s=UNDEFINED_PARAM);
end;

function TatVisualQuery.UpdateMetaSqlJoins: boolean;
var c : integer;
    join : TatSqlJoin;

  function branch( cond: TatSqlConditions): boolean;
  var c: integer;
      fld1, fld2 : TatSqlField;
  begin
    result := false;
    with cond do
    begin
      for c:=0 to Count-1 do
        with cond[c] do
          if ConditionType = ctSubconditions then
            result := result or branch( Subconditions )
          else
          if (ConditionType = ctFieldCompare) then
          begin
             fld1 := MetaSql.SqlFields.FindByAlias( FieldAlias );
             fld2 := MetaSql.SqlFields.FindByAlias( Value );
             if Assigned(fld1) and Assigned(fld2) then
             begin
               if SameText(join.ForeignTableAlias, fld1.TableAlias) then
                 if IsUndefined(join.PrimaryTableAlias) then
                   join.PrimaryTableAlias := fld2.TableAlias
                 else
                   raise Exception.CreateFmt(
                     _str(SCapabilityNotSupportedJoins),
                     [ join.ForeignTableAlias, fld2.TableAlias ])
               else
                 if SameText(join.ForeignTableAlias, fld2.TableAlias) then
                   if IsUndefined(join.PrimaryTableAlias) then
                     join.PrimaryTableAlias := fld1.TableAlias
                   else
                     raise Exception.CreateFmt(
                       _str(SCapabilityNotSupportedJoins),
                       [ join.ForeignTableAlias, fld1.TableAlias ]);

             end;
          end else
            result := true;
    end;
  end;

  function FindAnyPrimaryAlias(AExcludeTable: TatSQLTable): string;
  var
    c: integer;
  begin
    result := '';
    for c := 0 to MetaSQLDef.MetaSQL.SQLTables.Count - 1 do
      if MetaSQLDef.MetaSQL.SQLTables[c] <> AExcludeTable then
      begin
        result := MetaSQLDef.MetaSQL.SQLTables[c].TableAlias;
        break;
      end;
  end;

var
  HasCustomExpr: boolean;
begin
  { varre as junções para completar junções mal-definidas }
  result := False;
  with MetaSqlDef.MetaSql do
    for c:=0 to TableJoins.Count-1 do
    begin
      join := TableJoins[c];
      with join do
        if not IsUndefined(ForeignTableAlias) and IsUndefined(PrimaryTableAlias) then
        begin
          { junção sem definição de tabela primária:
            determina a tabela primária encontrando a primeira condição do tipo
            field compare que liga um campo da tabela estrangeira }
          HasCustomExpr := branch( JoinConditions );
          { sinaliza que alterou a junção automaticamente }
          if HasCustomExpr and IsUndefined(PrimaryTableAlias) then
            join.PrimaryTableAlias := FindAnyPrimaryAlias(SQLTables.FindByAlias(join.ForeignTableAlias));
          result := result or not IsUndefined(join.PrimaryTableAlias);
        end;

    end;
end;

function TatVisualQuery.AutoUpdateMetaSql: boolean;
begin
  result := False;

  { define campos de agrupamento com base nos campos da sql que não são funções de agregação }
  if FAutoGrouping then
    result := result or UpdateMetaSqlGrouping;

  { completa expressões de junção automaticamente }
  result := result or UpdateMetaSqlJoins;

  { se ocorreu alguma alteração automática na meta-sql então reapresenta a meta-sql }
  if result and not (csLoading in ComponentState) then
  begin
    if FTreeView <> nil then
    begin
      if Assigned(FTreeview.Selected) then
        LoadTreeView( FTreeView.Selected.Data )
      else
        LoadTreeView;
    end;
    AdjustVisualQueryPanel;
  end;
end;

procedure TatVisualQuery.RefreshDataset;
var
  msql : TatMetaSql;
  sql : string;
  {$IFDEF TRIAL}
  msg: string;
  i: integer;
  {$ENDIF}
begin
  {$IFDEF TRIAL}
  if (Now > 40800) or (Now < 40430) then
  begin
    msg := 'Tfhfiesg hQjugefrdys yShtgufdeidof dvcevrfseidofnd wheassz aesxdpfitryeudu.g fPvldecaxssed rrteyguiishtjehrg,f dosrd s'+
      'tdor tcfognvtcisnwueed sewvratlhunagtbifnvgc sdzotwfnglhoiaodk jam nnhegwf d'+
      'vdefrrstigovnc sfdreormf xhttgtyph:j/u/iwnwhwg.btfmvscsdowfqtawsadreer.fcrotm';
    i := 2;
    while i < length(msg) do
    begin
      System.Delete(msg, i, 1);
      inc(i);
    end;
    raise Exception.Create(msg);
  end;
  {$ENDIF}

  msql := MetaSqlDef.MetaSql;
  if Assigned(msql) then
  begin
    { realiza eventuais ajustes automáticos na meta-sql (reapresentando o visual-query em caso de alteração) }
    AutoUpdateMetaSql;

    { a atualização da meta-sql associada ou da query associda não ocorre na carga do componente do stream }
    if not (csLoading in ComponentState) then
    begin
      { atualiza os parâmetros da meta-sql com base nos editores }
      UpdateMetaSqlParams;

      { atualiza a meta-sql ligada ao visual-query }
      if Assigned(FMetaSql) then
        FMetaSql.Assign( msql );

      { se possui evento para percepção de mudança na meta-sql então o dispara }
      if Assigned(FOnMetaSqlChange) then
        FOnMetaSqlChange( msql );

      { se possui um dataset que possa ser ajustado automaticamente (SQL e Fields)
        então o atualiza agora }
      if Assigned(FTargetDataset) then
        with FTargetDataset do
        begin
          { realiza uma consistência geral na meta-sql para obter uma representação string sql }
          if MetaSqlIsConsistent then
          begin
            sql := msql.Sql;
            if sql > '' then
            begin
              if HandleAllocated and Showing then
                DisableControls;
              Screen.Cursor := crHourGlass;
              try
                Close;
                WriteSqlProperty( FTargetDataset, FDatabase, sql );
                if FAutoQueryOpen then
                  Open;

                msql.UpdateDisplayLabels(FTargetDataset);
              finally
                if HandleAllocated and Showing then
                  EnableControls;
                Screen.Cursor := crDefault;
              end;
            end
            else
              { sem sql - apenas fecha a query }
              Close;
          end
          else
            { meta-sql inconsistente - apenas fecha a query }
            Close;
        end
    end;
  end;
end;

procedure TatVisualQuery.TreeViewArrangement(Sender: TObject; Node: TTreeNode);
begin
  if not FIgnoreTreeViewArrangement then
  begin
    FIgnoreTreeViewArrangement := True;
    try
      AdjustVisualQueryPanel;
    finally
      FIgnoreTreeViewArrangement := False;
    end;
  end;
  UpdateNodeImage( Node );
end;

procedure TatVisualQuery.AdjustTreeView;
var
  c, n : integer;
  barheight: integer;
begin
  if FTreeView <> nil then
  begin
    { ajusta a altura do painel que contém o TreeView em função
      do conteúdo do TreeView }
    with FTreeView do
    begin
      if not Visible then Exit;
      n:=0;
      for c:=0 to Items.Count-1 do
        if Items[c].IsVisible then Inc(n);
      if Height <> n * ItemHeight then
      begin
        Height := n * ItemHeight;
        if (GetWindowLong(FTreeView.handle, GWL_STYLE) and WS_HSCROLL <> 0) then
          barheight := GetSystemMetrics(SM_CYHSCROLL)
        else
          barheight := 0;
        Height := Height + barheight;
        if FTreeViewPanel <> nil then
        begin
          if n > 0 then
            SetControlHeight(FTreeViewPanel,Height + FTreeViewPanel.BorderWidth * 2)
          else
            SetControlHeight(FTreeViewPanel,FTreeViewPanel.BorderWidth);
        end;
      end;
    end;
  end;
end;

procedure TatVisualQuery.AdjustParamEditors;
const
  horzMargin = 6;
  vertMarginTop = 3;
  vertMarginBottom = 5;
  horzSpace = 5;
  vertSpace =5;
var
  c  : integer;
  x  : integer;
  y  : integer;
  h  : integer;
  c1 : integer;
begin
  { ajusta o posicionamento dos editores, sua visibilidade e a altura do painel }
  x := horzMargin;
  y := vertMarginTop;
  h := 0;
  with MetaSqlDef.ParamDefs do
    for c:=0 to Count-1 do
      with Items[c] do
        if Assigned(FLabel) and Assigned(FEditor) and FEditor.HandleAllocated then
        begin
          { controle da visibilidade }
          FLabel.Visible := Active and FShowParamEditors;
          FEditor.Visible := Active and FShowParamEditors;
          FEditor.Enabled := not ParamEditorsReadOnly;

          { controle do posicionamento do editor dentro do painel }
          if FLabel.Visible then
          begin
            { também ajusta o caption }
            FLabel.Caption := Caption;
            FLabel.AutoSize := False;
            FLabel.AutoSize := True;
            FLabel.AutoSize := False;

            IncreaseControlDimensions(FLabel,4,0);

            { if editor is a drop down list,
              determines its width based on list item widths }
            if FEditor is TComboBox then
              with TComboBox(FEditor) do
                if Items.Count>0 then
                begin
                  for c1:=0 to Items.Count-1 do
                    if FLabel.Width < Self.Canvas.TextWidth(Items[c1]) + 20 then
                      SetControlWidth(FLabel,Self.Canvas.TextWidth(Items[c1]) + 20);
                end
                else
                  { usa um tamanho previamente ajustado quando não houver item nenhum no combo }
                  SetControlWidth(FLabel,FWidth);

            if FEditor is TatCheckListEdit then
              with TatCheckListEdit(FEditor) do
                for c1:=0 to Items.Count-1 do
                  if FLabel.Width < Self.Canvas.TextWidth(Items[c1]) + 30 then
                    SetControlWidth(FLabel,Self.Canvas.TextWidth(Items[c1]) + 30);

            FWidth := FLabel.Width;
            SetControlWidth(FEditor,FWidth);

            if (FParamPanel <> nil) and (x + FEditor.Width > FParamPanel.Width - horzMargin) then
            begin
              x := horzMargin;
              Inc(y, FLabel.Height + FEditor.Height + vertSpace);
            end;

            SetControlPos(FLabel,x,y);

            SetControlPos(FEditor,x,FLabel.Top+FLabel.Height+1);

            FEditor.TabOrder := c;
            Inc(x, FEditor.Width + horzSpace );

            { controle da altura do painel }
            h := FEditor.Top + FEditor.Height + vertMarginTop + vertMarginBottom;
          end;

          { controla a visibilidade do editor de acordo com seu conteúdo }
          HighlightEditor( FLabel, FEditor, not IsNull );
        end;

   if (FParamPanel <> nil) and (FTreeViewPanel <> nil) then
   begin
      if FParamPanel.Top < FTreeViewPanel.Top then
        SetControlTop(FParamPanel,FTreeViewPanel.Top + 1);

      SetControlHeight(FParamPanel,h);
   end;
end;

procedure TatVisualQuery.AutoAdjustEditorSize(Sender:TObject);
begin
  AdjustVisualQueryPanel;
end;

procedure TatVisualQuery.Resize;
begin
  if not (csLoading in ComponentState)
     and HandleAllocated
     and Showing
     and not FIgnoreVisualAdjustments then
  begin
    { armazena a altura máxima do painel,
      para usar como limite em ajustes automáticos }
    FResizeHeight := Self.Height;
    AdjustVisualQueryPanel;
  end;

  inherited;
end;

procedure TatVisualQuery.SetAutoAdjustHeight(const Value: boolean);
begin
  if FAutoAdjustHeight <> Value then
  begin
    FAutoAdjustHeight := Value;
    if Value and
       not (csLoading in ComponentState) and
       HandleAllocated and
       Showing then
//    Resize;
      AdjustVisualQueryPanel;
   end;
end;

procedure TatVisualQuery.AdjustVisualQueryPanel;
var
  r: TRect;
begin    
  if not FIgnoreVisualAdjustments then
  try
    FIgnoreVisualAdjustments := True;

    { ajusta os controles que constituem o VisualQuery }
    AdjustTreeView;
    AdjustParamEditors;
  finally
    { ajusta o tamanho do VisualQuery quando estiver com AutoSize }
    if AutoAdjustHeight then
    begin
      { verifica se o conteudo do VisualQuery ainda cabe em sua área limite }
      if (FTreeViewPanel <> nil) and (FParamPanel <> nil) and
        (FTreeViewPanel.Height + FParamPanel.Height < FResizeHeight-(Self.Height-Self.ClientHeight)) then
      begin
        { o VisualQuery ainda é menor do que a área limite então ajusta seu tamanho
          em função de seu conteúdo }
        if not (Align in [alLeft, alRight]) then
          Self.ClientHeight := FTreeViewPanel.Height + FParamPanel.Height;
      end
      else
      begin
        { o VisualQuery é maior que a área limite então limita seu tamanho para
          corresponder à área limite }
        if not (Align in [alLeft, alRight]) then
          Self.Height := FResizeHeight;
        { também evita que o ParamPanel seja escondido pelo TreeView }
        if (FTreeViewPanel <> nil) and (FParamPanel <> nil) and (FTreeViewPanel <> nil) then
        begin
          FTreeViewPanel.Height := Self.ClientHeight - FParamPanel.Height;
          FTreeView.Height := FTreeViewPanel.ClientHeight - FTreeViewPanel.BorderWidth*2;
        end;
      end;
    end
    else
    begin
      { faz com o TreeView permaneça ajustado dentro do VisualQuery e
        também evita que o ParamPanel seja escondido pelo TreeView }
      if (FTreeViewPanel <> nil) and (FParamPanel <> nil) and (FTreeViewPanel <> nil) then
      begin
        FTreeViewPanel.Height := Self.ClientHeight - FParamPanel.Height;
        FTreeView.Height := FTreeViewPanel.ClientHeight - FTreeViewPanel.BorderWidth*2;
      end;
    end;

    { assegura que o item selecionado esteja visível }
    if FTreeView <> nil then
      with FTreeView do
        if Focused and Assigned(Selected) then
        begin
          IntersectRect(r,ClientRect,Selected.DisplayRect(true));
          if not EqualRect(r,Selected.DisplayRect(true)) then
            Selected.MakeVisible;
        end;

    FIgnoreVisualAdjustments := false;
  end;
end;

function TatVisualQuery.GetNodeActive( ANode:TTreeNode ): boolean;
begin
   if Assigned(ANode) and NodeHasObject(ANode) then
   begin
      { obtém a ativação do item correspondente na meta-sql }
      if TObject(ANode.Data) is TatSqlBaseField then
         result := TatSqlBaseField(ANode.Data).Active
      else
      if TObject(ANode.Data) is TatSqlCondition then
         result := TatSqlCondition(ANode.Data).Active
      else
      if TObject(ANode.Data) is TatParamDef then
         result := TatParamDef(ANode.Data).Active
      else
      if TObject(ANode.Data) is TatSqlTable then
         result := TatSqlTable(ANode.Data).Active
      else
         result := True;
   end
   else
      result := True;
end;

procedure TatVisualQuery.SetNodeActive( ANode:TTreeNode; AValue: boolean );
begin
   if Assigned(ANode) and NodeHasObject(ANode) then
   begin
      { controla a ativação do item correspondente na meta-sql }
      if TObject(ANode.Data) is TatSqlBaseField then
         TatSqlBaseField(ANode.Data).Active := AValue
      else
      if TObject(ANode.Data) is TatSqlCondition then
         TatSqlCondition(ANode.Data).Active := AValue
      else
      if TObject(ANode.Data) is TatParamDef then
      begin
         TatParamDef(ANode.Data).Active := AValue;
         { também atualiza os editores de parâmetros imediatamente }
         AdjustVisualQueryPanel;
      end
      else
      if TObject(ANode.Data) is TatSqlTable then
         TatSqlTable(ANode.Data).Active := AValue;
   end;
end;

procedure TatVisualQuery.TreeViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var node : TTreeNode;
    hitTests : THitTests;
    aux : TTReeNode;
begin
  if (Button = mbLeft) and (FTreeView <> nil) then
    with FTreeView do
    begin
      node := GetNodeAt(X,Y);
      hitTests := GetHitTestInfoAt(X,Y);
      {
      htAbove    	Above the client area.
      htBelow     	Below the client area.
      htNowhere	     Inside the control, but not on an item.
      htOnItem    	On an item, its text, or its bitmap.
      htOnButton 	On a button.
      htOnIcon	     On an icon.
      htOnIndent	     On the indented area of an item.
      htOnLabel	     On a label.
      htOnRight	     On the right side of an item.
      htOnStateIcon	On a state icon or bitmap associated with an item.
      htToLeft	     To the left of the client area.
      htToRight	     To the right of the client area.
      }

      { testa se alterou marcação do nó }
      if Assigned(node) and (htOnStateIcon in hitTests) and
        ((node.StateIndex=1) or (node.StateIndex=2)) then
      begin
        inherited;
        FTreeViewCheckUncheck(Sender);
        Exit;
      end;

      { se o nó possui filhos e não está sobre um hyperlink
        então abre ou fecha o nó }
      if Assigned(node) and (htOnItem in hitTests) and node.HasChildren and
         (Cursor <> crHandPoint) then
      begin
        { default click }
        inherited;

        FIgnoreTreeViewArrangement := True;
        try
          if Selected.Expanded then
            Selected.Collapse(False)
          else
          begin
            if Assigned(node.Parent) and (node.Parent.Count>1) then
            begin
              { encolhe todos os nos irmãos que estiverem abertos }
              aux := node.Parent.GetFirstChild;
              while Assigned(aux) do
              begin
                if aux.Expanded then
                  aux.Collapse(False);
                aux := aux.GetNextSibling;
              end;
            end;
            Selected.Expand(False);
          end;
        finally
          FIgnoreTreeViewArrangement := False;
        end;
        AdjustVisualQueryPanel;

        UpdateNodeImage(node);
        
        { evita que o ParamTreeView continue executando }
        StopMouseProcessing := true;
        Exit;
//        Abort;
      end;

      { teste se clicou sobre uma lacuna de inclusão }
      if Assigned(node) and (htOnItem in hitTests) and
        (node.Data = FAKE_OBJECT_INSERTION) and (Cursor <> crHandPoint) then
      begin
        { default click }
        inherited;

        AdjustPopupPoint;
        OpenNodePopupMenu(pmInsertion);
      end;
    end
  else
    inherited;
end;

procedure TatVisualQuery.TreeViewDblClick(Sender: TObject);
begin
  if FTreeView <> nil then
    with FTreeView do
    begin
      { testa se o item é uma lacuna para inclusão de novo item }
      if Selected.Data = FAKE_OBJECT_INSERTION then
      begin
        OpenNodePopupMenu(pmInsertion);
        Exit;
      end;
    end;
end;

procedure TatVisualQuery.FTreeViewCheckUncheck(Sender: TObject);
var opt  : TClauseOptions;
    node : TTreeNode;
    actv : boolean;
begin
  if FTreeView <> nil then with FTreeView do
  begin
    node := Selected;
    opt := ClauseNodeOptions(Selected);

    { testa se o item possui CheckBox e permite configuração através de duplo click }
//  if (coClickSetup in opt) and Assigned(node) and (node.Level>1) then
    if (node.StateIndex=1) or (node.StateIndex=2) then
    begin
      { alterna a ativação do item }
      actv := not GetNodeActive( node );

      SetNodeActive( node, actv );

      { controla a imagem do item de acordo com a ativação e opções }
      if (coCheckBoxes in opt) then
        node.StateIndex := 1 + byte(actv)
      else
        node.StateIndex := -1; // torna a imagem invisível

      node.Text := FormatParametricCaption( node.Text, node.StateIndex,
        node.Data, coEditable in opt );

      { se o item ficou desativado e as opções não permitem visualização de
        itens desativados então elimina o item }
      if not actv and not (coShowInactives in opt) then
      begin
        if node.GetNextSibling<>nil then
          Selected := node.GetNextSibling
        else
        if node.GetPrevSibling<>nil then
          Selected := node.GetPrevSibling
        else
          Selected := node.Parent;
        node.Delete;
      end;

      { dispara a reatualização da query }
      TriggerQueryRefresh(Self);
    end;
  end;
end;

function TatVisualQuery.GetTableCaption(ATab:TatSqlTable):string;
begin
  result := Format('%s (%s)',[ATab.TableName,ATab.TableAlias]);
end;

function TatVisualQuery.HtmlParam(AName,AValue:string;Html:boolean): string;
var edits: string;
begin
  if Html then
  begin
    { testa se o parâmetro deve possui um editor no local }
    if Assigned(FDatabase) then
      edits := 'CVAL,CPAR,CEXP,TIT, TALI,FALI,FDSP,FEXP,PCAP,PVAL,ITEM'
    else
      edits := 'CVAL,CPAR,CEXP,TIT, TALI,FALI,FDSP,FEXP,PCAP,PVAL,ITEM,TNAM,FNAM';

    AValue := HTMLPrep( AValue );

    { determina o tipo do editor (Edit simples ou Popup menu }
    if ((Pos(AName,edits)-1) mod 5 = 0) then
    begin
      if (AValue=UNDEFINED_PARAM) or (AValue='') then                                                               
        result := Format('<A HREF="%s" CLASS="EDIT">%s</A>',[AName,'<FONT color="#FF0000">(<B>'+_str(SUndefinedValue)+'</B>)</FONT>'])
      else
        result := Format('<A HREF="%s" CLASS="EDIT">%s</A>',[AName,AValue]);
    end
    else
    begin
      if AValue=UNDEFINED_PARAM then
        result := Format('<A HREF="%s" CLASS="MENU">%s</A>',[AName,'<FONT color="#FF0000">(<B>'+_str(SUndefinedValue)+'</B>)</FONT>'])
      else
        result := Format('<A HREF="%s" CLASS="MENU">%s</A>',[AName,AValue]);
    end;
  end
  else
    result := AValue;
end;

function TatVisualQuery.TableNameFromAlias( AAlias: string ): string;
var tab: TatSqlTable;
begin
  tab := MetaSqlDef.MetaSql.SqlTables.FindByAlias( AAlias );
  if Assigned(tab) then
    result := tab.TableName
  else
    result := '';
end;

procedure TatVisualQuery.LoadTableNameList(lst: TStrings);
begin
  if FTableNames.Count = 0 then
  begin
    if Assigned(FDatabase) then
      FDatabase.LoadTableNameList(FTableNames)
    else
      FTableNames.Clear;
  end;
  lst.Assign(FTableNames);
end;

function TatVisualQuery.PrettyText(s:string): string;
begin
   if FDisablePrettyText then
      result := s
   else
      result := AnsiUpperCase(Copy(s,1,1))+AnsiLowerCase(Copy(s,2,Length(s)));
end;

procedure TatVisualQuery.PrettyTextList( lst: TStringList; ASort: boolean=True );
var c: integer;
begin
  if NOT FDisablePrettyText then
  with lst do
  try
    BeginUpdate;
    for c:=0 to Count-1 do
      Strings[c]:=PrettyText(Strings[c]);
    if ASort then
      lst.Sort;
  finally
    EndUpdate;
  end;
end;

procedure TatVisualQuery.LoadFieldNameList( ATableName: string; lst: TStrings );
var
  RealTableName: string;
begin
  {Get correct tablename, to avoid problems with case sensitivity}
  if FTableNames.IndexOf(ATableName) > -1 then
    RealTableName := FTableNames[FTableNames.IndexOf(ATableName)]
  else
    RealTableName := ATableName;

  if Assigned(FDatabase) then
    FDatabase.LoadFieldNameList(RealTableName,lst)
  else
    lst.Clear;
end;

type
  TNodeParameterType = (
    ptNewItem,
    ptConditionConector,
    ptFieldAlias,
    ptJoinFieldAlias,
    ptCompareOperator,
    ptCompareLogic,
    ptTableName,
    ptJoinType,
    ptFieldKind,
    ptTableAlias,
    ptFieldName,
    ptSortDirection,
    ptParamName,
    ptFilterEditor,
    ptQueryEditor,
    ptCompareType );

procedure TatVisualQuery.TreeViewHtmlParamPopup(Sender:TObject;ANode: TTreeNode; href: string;values:TStringlist;var DoPopup: Boolean);
var paramVal : string;
    join : TatSqlJoin;           

  procedure PrepareParamPopup(pt:TNodeParameterType);
  var colObj, obj : TObject;
    j: Integer;
    grouper: string;
    I: Integer;
    c : integer;
    sortList: TStringList;
  begin
    sortList := TStringList.Create;
    try
      colObj := TObject(ANode.Parent.Data);
      obj := TObject(ANode.Data);
      case pt of
        ptNewItem:
          begin
            if colObj is TatSqlTables then
              values.CommaText :=
                '"' + _str(SSingleTable) + '",'+
                '"' + _str(STableLinkedToAnother) + '"'
            else
            if colObj is TatSqlFields then
              values.CommaText :=
                '"' + _str(SSingleField) + '",'+
                '"' + _str(SFieldCalculatedByAnExpression) + '"'
            else
            if (colObj is TatSqlConditions) or (colObj is TatSqlCondition) or (colObj is TatSqlTable) then
              values.CommaText :=
                '"' + _str(SCompareFieldToAnother) + '",'+
                '"' + _str(SCompareFieldToParametricValue) + '",'+
                '"' + _str(SCompareFieldToSpecificValue) + '",'+
                '"' + _str(SCustomExpressionSQLSyntax) + '",'+
                '"' + _str(SNestedConditions) + '"'
            else
              { simula um click no parâmetro 'NEW' }
              TreeViewHtmlParamChanged(Sender,ANode,href,'','');
          end;
        ptConditionConector:
          begin
            if TatSqlCondition(obj).Index=0 then
              values.CommaText :=
                '"' + _str(SWhen) + '",'+
                '"' + _str(SWhenNot) + '"'
            else
              values.CommaText :=
                '"' + _str(SAnd) + '",'+
                '"' + _str(SAndNot) + '",'+
                '"' + _str(SOr) + '",'+
                '"' + _str(SOrNot) + '"';
          end;
        ptFieldAlias:
          begin
            values.BeginUpdate;
            grouper := '';
            j := -1;
            if colObj is TatSqlTable then
              j := TatSqlTable(colObj).Index;

            for i := 0 to MetaSqlDef.MetaSql.SqlTables.Count - 1 do    // Iterate
            begin
              if i = j then
                break;
             { shall we group fields on this table? }
              if ((j = -1) and (MetaSqlDef.MetaSql.SqlTables.Count > 1))
              or ((j > -1) and (MetaSqlDef.MetaSql.SqlTables.Count > 2)) {table parent, exclude it} then
              begin
                values.Add(Format('%s (%s)',[MetaSqlDef.MetaSql.SqlTables[i].TableAlias,MetaSqlDef.MetaSql.SqlTables[i].TableName]));
                grouper := '#sm#'; { group fields on menu item! }
              end;
              sortList.Clear;
              for c := 0 to MetaSqlDef.MetaSql.SqlFields.Count - 1 do
                if SameText(MetaSqlDef.MetaSql.SQLTables[i].TableAlias, MetaSqlDef.MetaSql.SqlFields[c].TableAlias) then
                  sortList.Add(grouper + MetaSqlDef.MetaSql.SqlFields[c].DisplayLabel);
              sortList.Sort;
              values.AddStrings(sortList);
            end;
            (*for c:=0 to MetaSqlDef.MetaSql.SqlFields.Count-1 do
              values.Add(grouper + MetaSqlDef.MetaSql.SqlFields[c].DisplayLabel);
            values.Sort;*)
            values.EndUpdate;
          end;
        ptJoinFieldAlias:
          begin
            values.BeginUpdate;
            with MetaSqlDef.MetaSql.SqlFields do
              for c:=0 to Count-1 do
                if SameText( Items[c].TableAlias, join.ForeignTableAlias) then
                  values.Add( Items[c].DisplayLabel );
            values.Sort;
            values.EndUpdate;
          end;
        ptCompareOperator:
          begin
            values.CommaText :=
              '"' + _str(SEqual) + '",'+
              '"' + _str(SDifferent) + '",'+
              '"' + _str(SGreaterThan) + '",'+
              '"' + _str(SLessThan) + '",'+
              '"' + _str(SGreaterOrEqual) + '",'+
              '"' + _str(SLessOrEqual) + '",'+
              '"' + _str(SLike) + '",'+
              '"' + _str(SStartingWith) + '",'+
              '"' + _str(SEndingWith) + '",'+
              '"' + _str(SContaining) + '"';
          end;
        ptCompareLogic:
          begin
            values.CommaText :=
              '"' + _str(STrue) + '",'+
              '"' + _str(SFalse) + '"';
          end;
        ptTableName:
          begin
            LoadTableNameList(values);
            PrettyTextList( values );
          end;
        ptJoinType:
          begin
            values.CommaText :=
              '"' + _str(SAfter) + '",'+
              '"' + _str(SBefore) + '",'+
              '"' + _str(SWith) + '"';
          end;
        ptFieldKind:
          begin
            values.CommaText :=
              '"' + _str(SFieldKindBring) + '",'+
              '"' + _str(SFieldKindCount) + '",'+
              '"' + _str(SFieldKindSum) + '",'+
              '"' + _str(SFieldKindMax) + '",'+
              '"' + _str(SFieldKindMin) + '",'+
              '"' + _str(SFieldKindAvg) + '"';
          end;
        ptTableAlias:
          begin
            values.BeginUpdate;
            for c:=0 to MetaSqlDef.MetaSql.SqlTables.Count-1 do
              values.Add( Format('%s ' + _str(SAs) + ' %s',[
                PrettyText( MetaSqlDef.MetaSql.SqlTables[c].TableName),
                PrettyText( MetaSqlDef.MetaSql.SqlTables[c].TableAlias) ]) );
            values.Sort;
            values.EndUpdate;
          end;
        ptFieldName:
          begin
            if TatSqlField(obj).TableAlias>'' then
            begin
              LoadFieldNameList(TableNameFromAlias(TatSqlField(obj).TableAlias), values);
              PrettyTextList( values );
            end;
          end;
        ptSortDirection:
          begin
            values.CommaText :=
              '"' + _str(SAscending) + '",'+
              '"' + _str(SDescending) + '"';
          end;
        ptParamName:
          begin
            values.BeginUpdate;
            for c:=0 to MetaSqlDef.MetaSql.Params.Count-1 do
              values.Add( PrettyText( MetaSqlDef.MetaSql.Params[c].Name) );
            values.Sort;
            values.EndUpdate;
          end;
        ptFilterEditor:
          begin
            values.CommaText :=
              '"' + _str(SFreeTyping) + '",'+
              '"' + _str(SDropdownAutomatic) + '",'+
              '"' + _str(SDropdownQuery) + '",'+
              '"' + _str(SDropdownChoose) + '",'+
              '"' + _str(SDropdownCheck) + '"';
          end;
        ptQueryEditor:
          { simula um click no parâmetro 'QUERY' }
          TreeViewHtmlParamChanged(Sender,ANode,href,'','');
        ptCompareType:
          begin
            values.CommaText :=
              '"' + _str(SParameter) + '",'+
              '"' + _str(SField) + '",'+
              '"' + _str(SValue) + '"';
          end;
      end;
    finally
      sortList.Free;
    end;
  end;

begin
  paramVal := TatParamTreeView(ANode.TreeView).NodeParameter[ANode,href];

  if (href='NEW') then
    PrepareParamPopup(ptNewItem)
  else
  if (href='CNT') then
    PrepareParamPopup(ptConditionConector)
  else
  if (href='CFLD') then
  begin
    join := JoinByCondition( TatSqlCondition(ANode.Data) );
    if Assigned(join) then
      PrepareParamPopup(ptJoinFieldAlias)
    else
      PrepareParamPopup(ptFieldAlias);
  end
  else
  if (href='CFL2') or (href='FLD') then
    PrepareParamPopup(ptFieldAlias)
  else
  if (href='COPR') then
    PrepareParamPopup(ptCompareOperator)
  else
  if (href='CLOG') then
    PrepareParamPopup(ptCompareLogic)
  else
  if (href='TNAM') then
    PrepareParamPopup(ptTableName)
  else
  if (href='JOIN') then
    PrepareParamPopup(ptJoinType)
  else
  if (href='FKND') then
    PrepareParamPopup(ptFieldKind)
  else
  if (href='FTAL') then
    PrepareParamPopup(ptTableAlias)
  else
  if (href='FNAM') then
    PrepareParamPopup(ptFieldName)
  else
  if (href='SORT') then
    PrepareParamPopup(ptSortDirection)
  else
  if (href='PNAM') then
    PrepareParamPopup(ptParamName)
  else
  if (href='PKND') then
    PrepareParamPopup(ptFilterEditor)
  else
  if (href='QUERY') then
    PrepareParamPopup(ptQueryEditor)
  else
  if (href='CTYP') then
    PrepareParamPopup(ptCompareType);

  DoPopup := (values.Count > 0);
end;

function TatVisualQuery.JoinByForeignTableAlias(msql:TatMetaSql;AAlias:string): TatSqlJoin;
var c: integer;
begin
  with msql.TableJoins do
    for c:=0 to Count-1 do
      if SameText(Items[c].ForeignTableAlias,AAlias) then
      begin
        result := Items[c];
        Exit;
      end;
  result := nil;
end;

function TatVisualQuery.JoinByCondition(ACond: TatSqlCondition): TatSqlJoin;
begin
  result := TatSqlJoin(TatSQLConditions(ACond.Collection).GetOwner);
  while Assigned(result) do
  begin
    if TObject(result) is TatSqlJoin then
      Exit;
    if TObject(result) is TatSqlCondition then
      result := TatSqlJoin(TatSQLConditions( TatSqlCondition(result).Collection ).GetOwner )
    else
      result := nil;
  end;
  result := nil;
end;

function TatVisualQuery.FindInvalidItem(AObj:TObject): TObject;
var c: integer;
    join : TatSqlJoin;
begin
  { testa se o objeto é válido, se estiver Ok retorna nil,
    senão retorna o objeto ou subobjeto que está inválido }
    
  result := AObj;
  if AObj is TCollection then
    with TCollection(AObj) do
      for c:=0 to Count-1 do
      begin
        result := FindInvalidItem(Items[c]);
        if result <> nil then
          Exit;
      end
  else
  if AObj is TatSqlTable then
    with TatSqlTable(AObj) do
    begin
      if (IsUndefined(TableName)) or (IsUndefined(TableAlias)) then
        Exit;
      { se for uma tabela de junção então testa se a junção é válida }
      join := JoinByForeignTableAlias(MetaSql,TableAlias);
      if Assigned(join) then
      begin
        result := FindInvalidItem( join.JoinConditions );
        if result <> nil then
          Exit;
      end;
    end
  else
  if AObj is TatSqlField then
    with TatSqlField(AObj) do
      if (IsUndefined(FieldAlias)) or
         ((ExpressionType=etCustomExpr) and (IsUndefined(FieldExpression))) or
         (IsUndefined(DisplayLabel)) then
        Exit
      else
  else
  if AObj is TatSqlBaseField then {order or group field}
    with TatSqlBaseField(AObj) do
      if (IsUndefined(FieldAlias)) then
        Exit
      else
  else
  if AObj is TatSqlCondition then
    with TatSqlCondition(AObj) do
    begin
      if ((ConditionType=ctCustomExpr) and (IsUndefined(Expression))) or
         ((ConditionType in [ctFieldCompare,ctParamCompare,ctValueCompare]) and ((IsUndefined(FieldAlias)) or (IsUndefined(Operator)) or (IsUndefined(Value)))) then
        Exit;
      { se a condição possuir subcodições então as explora também }
      if (ConditionType=ctSubConditions) then
      begin
        result := FindInvalidItem(Subconditions);
        if result <> nil then
          Exit;
      end;
    end
  else
  if AObj is TatParamDef then
    with TatParamDef(AObj) do
    begin
      if (IsUndefined(Caption)) or
         ((ParamType in [ptFreeEdit, ptDistinctList, ptQueryList]) and IsUndefined(Name)) or
         ((ParamType=ptQueryList) and (MetaSql=nil)) then
        Exit;
      { se o parâmetro possuir lista de itens então os explore também }
      if ParamType in [ptChooseList, ptCheckList] then
      begin
        result := FindInvalidItem(ListItems);
        if result <> nil then
          Exit;
      end;
    end
  else
  if AObj is TatParamListItem then
    with TatParamListItem(AObj) do
    begin
      if (Index>0) and IsUndefined(Text) then
        Exit;
      { verifica também as atribuições de parâmetros do item de lista }
      result := FindInvalidItem(ParamValues);
      if result <> nil then
        Exit;
    end
  else
  if AObj is TatParamValue then
    with TatParamValue(AObj) do
    begin
      if IsUndefined(Name) or IsUndefined(Value) then
        Exit;
    end;

  result := nil;
end;

procedure TatVisualQuery.TreeViewHtmlParamEditing(Sender:TObject;ANode: TTreeNode; href: string;var value: string);
begin
  if (Pos(UNDEFINED_VALUE, Value) > 0) or (Pos(_str(SUndefinedValue), Value) > 0) then
    Value := ''
  else
    Value := InvHTMLPrep( Value );
end;

procedure TatVisualQuery.TreeViewHtmlParamEdited(Sender:TObject;ANode: TTreeNode; href: string;var value: string);
begin
  if (FTreeView <> nil) and ((Value=FTreeView.EmptyParam) or (Value='')) then
    Value := UNDEFINED_PARAM;
end;

procedure TatVisualQuery.TreeViewHtmlParamChanged(Sender:TObject;ANode: TTreeNode; href,oldvalue,newvalue: string);
const opers : array[0..9] of string=('=','<>','>','<','>=','<=','LIKE','STARTS','ENDS','CONTAINS');
var colObj, obj : TObject;
    c    : integer;
    join : TatSqlJoin;
    oper : TatLogicalOper;
    aux  : string;
begin
  {-------------------------------------------------------------}
  { reflete as modificação ocorridas em parâmetros do tree view }
  { nas propriedades internas do componente                     }
  {-------------------------------------------------------------}
  if (newvalue = UNDEFINED_VALUE) or (newvalue = _str(SUndefinedValue)) or (newvalue = '') then
    newvalue := UNDEFINED_PARAM
  else
    newvalue := InvHTMLPrep( newvalue );

  if not FIgnoreParamChanges then
  try
    FIgnoreParamChanges := True;

    { se o nó corrente não possuir um objeto associado então sobe na hierarquia
      até encontrar um nó com objeto associado }
    while not Assigned(ANode.Data) and Assigned(ANode.Parent) do
      ANode := ANode.Parent;

    if Assigned(ANode.Parent) then
      colObj := TObject(ANode.Parent.Data)
    else
      colObj := nil;
    obj := TObject(ANode.Data);

    if (href='NEW') then
    begin
       obj := FindInvalidItem( colObj );
       if not Assigned(obj) then
       begin
         if colObj is TatSqlTables then
         begin
           {-------------}
           { nova tabela }
           {-------------}
           obj := TCollection(colObj).Add; // MetaSqlDef.MetaSql.SqlTables.Add;
           with TatSqlTable(obj) do
           begin
              TableName := UNDEFINED_PARAM;
              TableAlias := UNDEFINED_PARAM;
           end;
           if newvalue = _str(STableLinkedToAnother) then
             with MetaSqlDef.MetaSql.TableJoins.Add do
             begin
               ForeignTableAlias := UNDEFINED_PARAM;
               LinkType := altLeftJoin;
               with JoinConditions.Add do
               begin
                 ConditionType := ctFieldCompare;
                 FieldAlias := UNDEFINED_PARAM;
                 Value := UNDEFINED_PARAM;
                 Operator := '=';
               end;
             end;
         end
         else
         if colObj is TatSqlFields then
         begin
           {------------}
           { novo campo }
           {------------}
           obj := TCollection(colObj).Add; // MetaSqlDef.MetaSql.SqlFields.Add;
           with TatSqlField(obj) do
           begin
             FieldAlias := UNDEFINED_PARAM;
             DisplayLabel := UNDEFINED_PARAM;
             if newvalue = _str(SSingleField) then
             begin
               TableAlias := UNDEFINED_PARAM;
               FieldName := UNDEFINED_PARAM;
             end
             else
             begin
               ExpressionType := etCustomExpr;
               FieldExpression := UNDEFINED_PARAM;
             end;
           end;
         end
         else
         if colObj is TatSqlGroupFields then
         begin
           {---------------------------}
           { novo campo de agrupamento }
           {---------------------------}
           obj := TCollection(colObj).Add; //MetaSqlDef.MetaSql.GroupFields.Add;
           TatSqlBaseField(obj).FieldAlias := UNDEFINED_PARAM;
         end
         else
         if colObj is TatSqlOrderFields then
         begin
           {-------------------------}
           { novo campo de ordenação }
           {-------------------------}
           obj := TCollection(colObj).Add;
           TatSqlBaseField(obj).FieldAlias := UNDEFINED_PARAM;
         end
         else
         if (colObj is TatSqlConditions) or (colObj is TatSqlCondition) or (colObj is TatSqlTable) then
         begin
           {-------------------------}
           { nova condição de filtro }
           {-------------------------}
           if colObj is TCollection then
             obj := TCollection(colObj).Add
           else
           if colObj is TatSqlCondition then
             obj := TatSqlCondition(colObj).Subconditions.Add
           else
           if colObj is TatSqlTable then
           begin
             join := JoinByForeignTableAlias(TatSqlTable(colObj).MetaSql,TatSqlTable(colObj).TableAlias);
             if not Assigned(join) then
               raise Exception.Create(_str(STableJoinHandlingFailure));
             obj := join.JoinConditions.Add;
           end;

           with TatSqlCondition(obj) do
           begin
             if Pos(_str(SCompareFieldToParametricValue),newvalue)>0 then
               ConditionType := ctParamCompare
             else
             if Pos(_str(SCompareFieldToSpecificValue),newvalue)>0 then
               ConditionType := ctValueCompare
             else
             if Pos(_str(SCompareFieldToAnother),newvalue)>0 then
               ConditionType := ctFieldCompare
             else
             if Pos(_str(SCustomExpressionSQLSyntax),newvalue)>0 then
               ConditionType := ctCustomExpr
             else
             if Pos(_str(SNestedConditions),newvalue)>0 then
               ConditionType := ctSubconditions;
             Expression := UNDEFINED_PARAM;
             FieldAlias := UNDEFINED_PARAM;
             Operator := '=';
             Value := UNDEFINED_PARAM;
           end;
         end
         else
         if colObj is TatParamDefs then
         begin
           {--------------------------}
           { novo editor de parâmetro }
           {--------------------------}
           obj := TCollection(colObj).Add;
           with TatParamDef(obj) do
           begin
             Name := UNDEFINED_PARAM;
             Caption := UNDEFINED_PARAM;
           end;
         end
         else
         if (colObj is TatParamDef) and (TatParamDef(colObj).ParamType in [ptChooseList, ptCheckList]) then
         begin
           {------------------------------------------------}
           { novo item de lista (em editores de parâmetros) }
           {------------------------------------------------}
           obj := TatParamDef(colObj).ListItems.Add;
           with TatParamListItem(obj) do
           begin
             Text := UNDEFINED_PARAM;
           end;
         end
         else
         if colObj is TatParamListItem then
         begin
           {---------------------------------------------------}
           { nova atribuição de parâmetro em editor tipo lista }
           {---------------------------------------------------}
           obj := TatParamListItem(colObj).ParamValues.Add('=');
           with TatParamValue(obj) do
           begin
             Name := UNDEFINED_PARAM;
             Value := UNDEFINED_PARAM;
           end;
         end;
       end
       else // if not Assigned(obj) then
       begin
         LoadTreeView( obj );
         obj := nil;
         ShowMessage(_str(SYouMustCompleteUndefinedItem));
       end;
    end
    else
    if (href='TIT') then
    begin
      { título da consulta }
      MetaSqlDef.Title := newvalue;
    end
    else
    if (href='TNAM') then
    begin
      { nome de uma tabela }
      TatSqlTable(obj).TableName := newvalue;
      if (TatSqlTable(obj).TableAlias = UNDEFINED_PARAM) or
         SameText(TatSqlTable(obj).TableAlias,newvalue) or
         SameText(TatSqlTable(obj).TableAlias,oldvalue) then
      begin
        { já que o Alias é definido automaticamente,
          então também conserta o TableAlias da junção correspondente (se houver uma) }
        TatSqlTable(obj).CascadeChangeTableAlias( newvalue );
      end;
      { verifica se deve criar campos em função de alteração na tabela }
      CheckTableChange( TatSqlTable(obj), oldvalue, newvalue );
      { verifica a integridade da Meta-Sql após alteração em nome de tabela }
      if oldvalue <> UNDEFINED_PARAM then
        CheckMetaSqlIntegrity;
    end
    else
    if (href='TALI') then
    begin
      { propaga alerações no TableAlias para outros elementos da sql (condições, campos) }
      TableAliasChanged(TatSQLTable(obj), newvalue);
      TatSqlTable(obj).CascadeChangeTableAlias(newvalue);
    end
    else
    if (href='JOIN') then
    begin
      { atualiza a junção correpondente }
      join := JoinByForeignTableAlias(TatSqlTable(obj).MetaSql,TatSqlTable(obj).TableAlias);
      if Assigned(join) then
        if newvalue = _str(SAfter) then
          join.LinkType := altLeftJoin
        else
        if newvalue = _str(SBefore) then
          join.LinkType := altRightJoin
        else
          join.LinkType := altInnerJoin;
    end
    else
    if (href='CFLD') then
    begin
      { campo de uma comparação }
      with TatSqlCondition(obj) do
      begin
        FieldAlias := FieldAliasByDisplayLabel(MetaSql,newvalue);
        { se a condição é paramétrica então define um nome de parâmetro automaticamente }
        aux := CreateParamName(FieldAlias);
        if (ConditionType = ctParamCompare) and
           ((Value = UNDEFINED_PARAM) or (Value = aux)) then
          Value := aux;
      end;
    end
    else
    if (href='CFL2') then
    begin
      { segundo campo de uma comparação }
      TatSqlCondition(obj).Value := FieldAliasByDisplayLabel(TatSqlCondition(obj).MetaSql,newvalue);
    end
    else
    if (href='COPR') then
    begin
      { operador de uma comparação }
      with TStringList.Create do
      try
        CommaText :=
              '"' + _str(SEqual) + '",'+
              '"' + _str(SDifferent) + '",'+
              '"' + _str(SGreaterThan) + '",'+
              '"' + _str(SLessThan) + '",'+
              '"' + _str(SGreaterOrEqual) + '",'+
              '"' + _str(SLessOrEqual) + '",'+
              '"' + _str(SLike) + '",'+
              '"' + _str(SStartingWith) + '",'+
              '"' + _str(SEndingWith) + '",'+
              '"' + _str(SContaining) + '"';
        c := IndexOf(newvalue);
        if c > -1 then
          TatSqlCondition(obj).Operator := opers[c];
      finally
        Free;
      end;
    end
    else
    if (href='FNAM') then
    begin
      { nome de um campo }
      TatSqlField(obj).FieldName := newvalue;
      UpdateFieldType(TatSQLField(obj));
      if (TatSqlField(obj).FieldAlias = UNDEFINED_PARAM) or
         SameText(TatSqlField(obj).FieldAlias,newvalue) or
         SameText(TatSqlField(obj).FieldAlias,oldvalue) then
      begin
        { já que o apelido é definido automaticamente,
          então também conserta o FieldAlias de dependências }
        TatSqlField(obj).CascadeChangeFieldAlias( newvalue );
      end;
    end
    else
    if (href='FALI') then
    begin
      { alias de um campo }
      { propaga alerações no FieldAlias para outros elementos da sql (condições, group by, order by) }
      TatSqlField(obj).CascadeChangeFieldAlias( newvalue );
    end
    else
    if (href='FDSP') then
    begin
      { legenda de um campo }
      TatSqlField(obj).DisplayLabel := newvalue;
    end
    else
    if (href='FTAL') then
    begin
      { tabela de um campo }
      c := Pos(' ' + _str(SAs) + ' ',newvalue);
      TatSqlField(obj).TableAlias := Copy(newvalue,c+4,Length(newvalue));
    end
    else
    if (href='FKND') then
    begin
      { função de agregação de um campo }
      if Pos(_str(SFieldKindBring),newvalue)>0 then
        TatSqlField(obj).GroupFunction := agfNone
      else
      if Pos(_str(SFieldKindCount),newvalue)>0 then
        TatSqlField(obj).GroupFunction := agfCount
      else
      if Pos(_str(SFieldKindSum),newvalue)>0 then
        TatSqlField(obj).GroupFunction := agfSum
      else
      if Pos(_str(SFieldKindMax),newvalue)>0 then
        TatSqlField(obj).GroupFunction := agfMax
      else
      if Pos(_str(SFieldKindMin),newvalue)>0 then
        TatSqlField(obj).GroupFunction := agfMin
      else
      if Pos(_str(SFieldKindAvg),newvalue)>0 then
        TatSqlField(obj).GroupFunction := agfAvg;
    end
    else
    if (href='FEXP') then
    begin
      { expressão de campo customizada }
      TatSqlField(obj).FieldExpression := InvHTMLPrep( newvalue );
    end
    else
    if (href='CEXP') then
    begin
      { expressão de condição customizada }
      TatSqlCondition(obj).Expression := InvHTMLPrep( newvalue );
    end
    else
    if (href='CVAL') then
    begin
      { valor de uma condição do tipo FieldCompare }
      TatSqlCondition(obj).Value := InvHTMLPrep( newvalue );
    end
    else
    if (href='CPAR') then
    begin
      { parâmetro de uma condição do tipo ParamCompare }
      TatSqlCondition(obj).Value := newvalue;
    end
    else
    if (href='CLOG') then
    begin
      { valor verdadeiro ou falso de uma condição }
      if (newvalue = 'TRUE') or (newvalue = _str(STrue)) then
        TatSqlCondition(obj).ConditionType := ctTrueExpr
      else
        TatSqlCondition(obj).ConditionType := ctFalseExpr;
    end
    else
    if (href='CTYP') then
    begin
      { tipo da condição }
      with TatSqlCondition(obj) do
      begin
        if newvalue = _str(SParameter) then
          ConditionType := ctParamCompare
        else
          if newvalue = _str(SField) then
            ConditionType := ctFieldCompare
          else
            if newvalue = _str(SValue) then
              ConditionType := ctValueCompare;
        Value := UNDEFINED_PARAM;
      end;
    end
    else
    if (href='SORT') then
    begin
      { direção da ordenação }
      if newvalue = _str(SAscending) then
        TatSqlOrderField(obj).SortType := ortAscending
      else
        TatSqlOrderField(obj).SortType := ortDescending;
    end
    else
    if (href='PNAM') then
    begin
      if obj is TatParamDef then
      begin
        { nome de parâmetro em um editor de filtro }
        if (TatParamDef(obj).Caption = TatParamDef(obj).Name) or
           (TatParamDef(obj).Caption = UNDEFINED_PARAM) then
        begin
          { também ajusta a legenda do editor de parâmetro }
          TatParamDef(obj).Name := newvalue;
          TatParamDef(obj).Caption := newvalue;
          RebuildParamEditors;
        end
        else
          TatParamDef(obj).Name := newvalue;
      end
      else
      if obj is TatParamValue then
        { nome de um parâmetro de item de lista }
        TatParamValue(obj).Name := newvalue;
    end
    else
    if (href='PVAL') then
    begin
      { valor setado para um parâmetro de item de lista }
      TatParamValue(obj).Value := newvalue;
    end
    else
    if (href='ITEM') then
    begin
      { descrição de um item de em editor de parâmetro}
      TatParamListItem(obj).Text := newvalue;
      RebuildParamEditors;
    end
    else
    if (href='PKND') then
    begin
      { destrói os editores para recriá-los depois da alteração }
      DestroyParamEditors;
      { estilo de editor de parâmetro }
      if newvalue = _str(SFreeTyping) then
        TatParamDef(obj).ParamType := ptFreeEdit
      else
      if newvalue = _str(SDropdownAutomatic) then
        TatParamDef(obj).ParamType := ptDistinctList
      else
      if newvalue = _str(SDropdownQuery) then
        TatParamDef(obj).ParamType := ptQueryList
      else
      if newvalue = _str(SDropdownChoose) then
        TatParamDef(obj).ParamType := ptChooseList
      else
      if newvalue = _str(SDropdownCheck) then
        TatParamDef(obj).ParamType := ptCheckList;
      { recria os editores }
      CreateParamEditors;
    end
    else
    if (href='PCAP') then
    begin
      { legenda do editor de parâmetro }
      TatParamDef(obj).Caption := newvalue;
      RebuildParamEditors;
    end
    else
    if (href='FLD') then
    begin
      { campo de ordenação ou agrupamento }
      TatSqlBaseField(obj).FieldAlias := MetaSqlDef.MetaSql.SqlFields.FindByLabel(newvalue).FieldAlias;
    end
    else
    if (href='CNT') then
    begin
      { conector lógico entre condições }
      with TatSqlCondition(obj) do
      begin
        if Pos(_str(SAnd),newvalue)>0 then
          oper := lgAnd
        else
          if Pos(_str(SOr),newvalue)>0 then
            oper := lgOr
          else
            oper := TatSqlConditions(Collection).LogicalOperator;
        if (oper=TatSqlConditions(Collection).LogicalOperator) or
           (Collection.Count<3) or
           (MessageDlg(_str(SConfirmChangeLogicalConnector),mtConfirmation,[mbYes,mbNo],0)=mrYes) then
        begin
          TatSqlConditions(Collection).LogicalOperator := oper;
          Negate := (newvalue=_str(SWhenNot)) or (newvalue=_str(SAndNot)) or (newvalue=_str(SOrNot));
        end;
      end;
    end
    else
    if (href='QUERY') then
    begin
      with TfmQueryEditor(QueryEditor) do
      begin
        AdjustPopupPoint;
        Left := FLastPopupPoint.X;
        Top := FLastPopupPoint.Y;
        Caption := Format(_str(SQueryEditorForParameter),[TatParamDef(obj).Name]);
        VisualQuery.OptionsForParameterEditors := VisualQuery.OptionsForParameterEditors - [coVisible];
        VisualQuery.Database := Database;
        VisualQuery.SyntaxConf := SyntaxConf;
        VisualQuery.SQLSyntax := TatParamDef(obj).MetaSql.SQLSyntax;
        VisualQuery.QualifiedFieldAliases := TatParamDef(obj).MetaSql.QualifiedFieldAliases;
        VisualQuery.FieldAliasSeparator := TatParamDef(obj).MetaSql.FieldAliasSeparator;
        VisualQuery.TargetMetaSql := TatParamDef(obj).MetaSql;
        VisualQuery.MetaSqlDef.Title := TatParamDef(obj).Caption;
        if ShowModal = mrOk then
        begin
          VisualQuery.UpdateMetaSql;
          TatParamDef(obj).Caption := VisualQuery.MetaSqlDef.Title;
        end;
      end;
    end;

    if Assigned(obj) then
    begin
      LoadTreeView( obj );
      AdjustVisualQueryPanel;
    end;

    if Assigned(FOnTreeViewParamChanged) then
      FOnTreeViewParamChanged(Sender, ANode, href, oldvalue, newvalue, obj, colobj);

    { se o item corrente não for inválido então também dispara a atualização da
      consulta }
    if FindInvalidItem( colObj ) = nil then
      TriggerQueryRefresh( Self );

  finally
    FIgnoreParamChanges := False;
  end;
end;

(*
procedure TatVisualQuery.CascadeChangeTableAlias(ATable:TatSqlTable;AOldAlias, ANewAlias: string);
var c: integer;
begin
  { propaga a alteração do TableAlias para as dependências da tabela }

  { atualiza as junções correpondentes }
  with MetaSqlDef.MetaSql.TableJoins do
    for c := 0 to Count-1 do
      if SameText(Items[c].ForeignTableAlias,AOldAlias) then
        Items[c].ForeignTableAlias := ANewAlias;

  { atualiza as junções correpondentes }
  with MetaSqlDef.MetaSql.TableJoins do
    for c := 0 to Count-1 do
      if SameText(Items[c].PrimaryTableAlias,AOldAlias) then
        Items[c].PrimaryTableAlias := ANewAlias;

  { atualiza os campos correspodentes }
  with MetaSqlDef.MetaSql.SqlFields do
    for c := 0 to Count-1 do
      if Items[c].ExpressionType = etStandard then
        if SameText(Items[c].TableAlias,AOldAlias) then
          Items[c].TableAlias := ANewAlias
        else
      else
        { *** a implementar: atualização para campos com expressão meta-SQL *** }
        ;
end;
*)
(*   moved to - atMetaSQL.SQLFields's code -

procedure TatVisualQuery.CascadeChangeFieldAlias(AField: TatSqlField;AOldAlias, ANewAlias: string);
var c: integer;

  procedure BranchConditions( ACond: TatSqlConditions );
  var c : integer;
  begin
    { atualiza os campos correspodentes }
    with ACond do
      for c := 0 to Count-1 do
        case Items[c].ConditionType of
          ctSubconditions:
            BranchConditions( Items[c].SubConditions );

          ctValueCompare, ctFieldCompare, ctParamCompare:
              if SameText(Items[c].FieldAlias,AOldAlias) then
                Items[c].FieldAlias := ANewAlias;

          ctCustomExpr :
            { *** a implementar: atualização para condições com expressão meta-SQL *** }
        end;
  end;

  procedure BranchFields( AFields: TatSqlBaseFields );
  var c : integer;
  begin
    { atualiza os campos correspodentes }
    with AFields do
      for c := 0 to Count-1 do
        if SameText(Items[c].FieldAlias,AOldAlias) then
          Items[c].FieldAlias := ANewAlias;
  end;

begin
  { propaga a alteração do FieldAlias para as dependências do field }

  { atualiza condições gerais }
  BranchConditions( MetaSqlDef.MetaSql.Conditions );

  { atualiza condições de junção entre tabelas }
  with MetaSqlDef.MetaSql.TableJoins do
    for c := 0 to Count-1 do
      BranchConditions( Items[c].JoinConditions );

  { atualiza campos de agrupamento }
  BranchFields( MetaSqlDef.MetaSql.GroupFields );

  { atualiza campos de ordenação }
  BranchFields( MetaSqlDef.MetaSql.OrderFields );
end;
*)

function TatVisualQuery.CreateParamName( AParamName: string ): string;
var c: integer;
begin
  { define um nome de parâmetro automaticamente }
  c:=0;
  result := AParamName;
  while MetaSqlDef.MetaSql.Params.FindParam(result) <> nil do 
  begin
    Inc(c);
    result := AParamName + IntToStr(c);
  end;
end;

procedure TatVisualQuery.CheckTableChange( ATable:TatSqlTable; AOldName, ANewName: string);
var c: integer;
    s: TStringList;
begin
  { se o nome da tabela foi modificado e ainda não existe nenhuma definição
    de campo para a nova tabela então inclui automaticamente todos
    os campos da nova tabela (desabilitados) }
  if not SameText(AOldName, ANewName) and (ATable.TableAlias <> UNDEFINED_PARAM) then
  begin
    { se econtrar algum campo já associado com a nova tabela
      então abandona esse procedimento }
    with MetaSqlDef.MetaSql.SqlFields do
      for c := 0 to Count-1 do
        if (Items[c].ExpressionType = etStandard) and (SameText(Items[c].TableAlias,ATable.TableAlias)) then
          Exit;

    s := TStringList.Create;
    try
      { inclui todos os campos da nova tabela a partir do dicionário de dados }
      LoadFieldNameList(ANewName, s );
      PrettyTextList(s, False );
      for c := 0 to s.Count - 1 do
      begin
        with MetaSqlDef.MetaSql.SqlFields.Add do
        begin
          TableAlias := ATable.TableAlias;
          FieldName := s[c];
          ChangeExclusiveFieldAlias( FieldName );
          {*** melhorar isso com o dicionário de dados ***}
          {$IFDEF TMSDOTNET}
          DataType := TFieldType(s.Objects[c]);
          {$ELSE}
          DataType := TFieldType(integer(s.Objects[c]));
          {$ENDIF}
          DisplayLabel := FieldAlias;
          Active := False;
        end;
      end;
    finally
      s.Free;
    end;
  end;
end;

procedure TatVisualQuery.CheckMetaSqlIntegrity;
begin
  { *** aqui deve ocorrer um completa verificação de integridade da meta-sql *** }
  { os elementos incorretos devem ser excluídos ou desativados automaticamente }
end;

function TatVisualQuery.DisplayLabelByFieldAlias(msql:TatMetaSql;AAlias: string): string;
var fld : TatSqlField;
begin
  fld := msql.SqlFields.FindByAlias(AAlias);
  if Assigned(fld) then
    result := fld.DisplayLabel
  else
    result := AAlias;
end;

function TatVisualQuery.FieldAliasByDisplayLabel(msql:TatMetaSql;ALabel: string): string;
var fld : TatSqlField;
begin
  fld := msql.SqlFields.FindByLabel(ALabel);
  if Assigned(fld) then
    result := fld.FieldAlias
  else
    result := '';
end;

function TatVisualQuery.GetConditionCaption(ACond:TatSqlCondition;Html:boolean=False):string;
const
  operstr: array[TatLogicalOper, boolean] of string = (('And', 'And not'), ('Or', 'Or not'));
var
  aux : string;
begin
  operstr[lgAnd, false] := _str(SAnd);
  operstr[lgAnd, true] := _str(SAndNot);
  operstr[lgOr, false] := _str(SOr);
  operstr[lgOr, true] := _str(SOrNot);

  with ACond do
  begin
    if Index = 0 then
      if Negate then
        aux := HtmlParam('CNT',_str(SWhenNot),Html)+' '
      else
        aux := HtmlParam('CNT',_str(SWhen),Html)+' '
    else
      aux := HtmlParam('CNT',operstr[ TatSqlConditions(Collection).LogicalOperator, Negate ],Html)+' ';

    case ConditionType of
      ctSubConditions:
        result := Trim(aux) + EllipsisHtml;

      ctValueCompare, ctFieldCompare, ctParamCompare:
        begin
          if FieldAlias > '' then
            aux := aux + HtmlParam('CFLD',DisplayLabelByFieldAlias(MetaSql,FieldAlias),Html) + ' '
          else
            aux := aux + HtmlParam('CFLD',UNDEFINED_PARAM,Html) + ' ';

          if Operator = '=' then
            aux := aux + HtmlParam('COPR',_str(SEqual),Html)
          else
          if Operator = '<>' then
            aux := aux + HtmlParam('COPR',_str(SDifferent),Html)
          else
          if Operator = '>' then
            aux := aux + HtmlParam('COPR',_str(SGreaterThan),Html)
          else
          if Operator = '<' then
            aux := aux + HtmlParam('COPR',_str(SLessThan),Html)
          else
          if Operator = '>=' then
            aux := aux + HtmlParam('COPR',_str(SGreaterOrEqual),Html)
          else
          if Operator = '<=' then
            aux := aux + HtmlParam('COPR',_str(SLessOrEqual),Html)
          else
          if LowerCase(Operator) = 'like' then
            aux := aux + HtmlParam('COPR',_str(SLike),Html)
          else
          if LowerCase(Operator) = 'starts' then
            aux := aux + HtmlParam('COPR',_str(SStartingWith),Html)
          else
          if LowerCase(Operator) = 'ends' then
            aux := aux + HtmlParam('COPR',_str(SEndingWith),Html)
          else
          if LowerCase(Operator) = 'contains' then
            aux := aux + HtmlParam('COPR',_str(SContaining),Html)
          else
            aux := aux + HtmlParam('COPR',UNDEFINED_PARAM,Html);

          case ConditionType of
            ctValueCompare:
              result := aux + ' ' + HtmlParam('CTYP',_str(SValue),Html) + ' "' + HtmlParam('CVAL',Value,Html) + '"';

            ctFieldCompare:
              result := aux + ' ' + HtmlParam('CTYP',_str(SField),Html) + ' ' + HtmlParam('CFL2',DisplayLabelByFieldAlias(MetaSql,Value),Html);

            ctParamCompare:
              result := aux + ' ' + HtmlParam('CTYP',_str(SParameter),Html) + ':' + HtmlParam('CPAR',Value,Html);
          end;
        end;

      ctCustomExpr:
        if Expression>'' then
          result := aux + ' "' + HtmlParam('CEXP',Expression,Html) + '"'
        else
          result := aux + ' "' + HtmlParam('CEXP',UNDEFINED_PARAM,Html) + '"';

      ctTrueExpr:
        result := aux + ' ' + HtmlParam('CLOG',_str(STrue),Html);

      ctFalseExpr:
        result := aux + ' ' + HtmlParam('CLOG',_str(SFalse),Html);
    end;
  end;
end;

function TatVisualQuery.GetGroupFieldCaption(AGrpFld:TatSqlGroupField):string;
var fld: TatSqlField;
begin
  with AGrpFld do
  begin
    fld := Field;
    if Assigned(fld) then
      result := fld.DisplayLabel
    else
      result := FieldAlias;
  end;
end;

function TatVisualQuery.GetOrderFieldCaption(AOrdFld:TatSqlOrderField):string;
var fld : TatSqlField;
begin
  with AOrdFld do
  begin
    fld := Field;
    if Assigned(fld) then
      result := fld.DisplayLabel
    else
      result := FieldAlias;
  end;
end;

function TatVisualQuery.FormatParametricCaption( ACaption: string; AImg: integer; AObj:TObject; AHtml:boolean=True ): string;
const
  JoinDesc : array[TatSQLJoinType] of string = ('with', 'after', 'before' );
  FuncDesc : array[TatSQLGroupFunction] of string = ('Bring','Count','Sum of','Maximum of','Minimum of','Average of');
  SortDesc : array[TatSortType] of string = ('ascending','descending');
begin
  JoinDesc[altInnerJoin] := _str(SWith);
  JoinDesc[altLeftJoin] := _str(SAfter);
  JoinDesc[altRightJoin] := _str(SBefore);
  FuncDesc[agfNone] := _str(SBring);
  FuncDesc[agfCount] := _str(SCount);
  FuncDesc[agfSum] := _str(SSum);
  FuncDesc[agfMax] := _str(SMax);
  FuncDesc[agfMin] := _str(SMin);
  FuncDesc[agfAvg] := _str(SAvg);
  SortDesc[ortAscending] := _str(SAscending);
  SortDesc[ortDescending] := _str(SDescending);

  result := ACaption;
  { controla por HTML o estilo do nó }
  if AObj = FAKE_OBJECT_INSERTION then
    result := HtmlParam('NEW','(' + ACaption + ')',AHtml)
  else
  if AObj is TatMetaSqlDef then
    if AHtml then
      if TatMetaSqlDef(AObj).AllowSetup then
        result := '<B>' + HtmlParam('TIT',ACaption,AHtml) + '</B>'+EllipsisHtml
      else
        result := '<B>' + HtmlParam('TIT',ACaption,AHtml) + '</B>'
    else
      result := HtmlParam('TIT',ACaption,AHtml)
  else
  if AObj is TCollection then
  begin
    if AHtml then
// retornar esse código somente quando corrigir o Delete
//    if FindInvalidItem(AObj)=nil then
        result := '<B>' + ACaption + '</B>'
//    else
//      result := '<FONT color="#FF0000"><B>' + ACaption + '</B></FONT>'
  end
  else
  if AObj is TatSqlTable then
    with TatSqlTable(AObj) do
      if Assigned( JoinConditions(TatSqlTable(AObj)) ) then
        result := Format(_str(STableAliasJoinedConditioned) + EllipsisHtml,
          [ HtmlParam('TNAM',PrettyText(TableName),AHtml),
            HtmlParam('TALI',PrettyText(TableAlias),AHtml),
            HtmlParam('JOIN',JoinDesc[JoinConditions(TatSqlTable(AObj)).LinkType],AHtml) ])
      else
        result := Format('%s ' + _str(SAlias) + ' %s',
          [ HtmlParam('TNAM',PrettyText(TableName),AHtml),
            HtmlParam('TALI',PrettyText(TableAlias),AHtml) ])
  else
  if AObj is TatSqlField then
    with TatSqlField(AObj) do
      if coShortText in OptionsForDataFields then
      begin
        result := Format('%s',
          [ HtmlParam('FDSP',DisplayLabel,AHtml) ])
      end else
      begin
        if (ExpressionType = etStandard) then
          result := Format('%s %s.%s ' + _str(SAlias) + ' %s, ' + _str(STitled) + ' "%s"',
            [ HtmlParam('FKND',FuncDesc[GroupFunction],AHtml),
              HtmlParam('FTAL',PrettyText(TableAlias),AHtml),
              HtmlParam('FNAM',PrettyText(FieldName),AHtml),
              HtmlParam('FALI',PrettyText(FieldAlias),AHtml),
              HtmlParam('FDSP',DisplayLabel,AHtml) ])
        else
          result := Format(_str(SExpressionAliasTitled),
            [ HtmlParam('FEXP',FieldExpression,AHtml),
              HtmlParam('FALI',PrettyText(FieldAlias),AHtml),
              HtmlParam('FDSP',DisplayLabel,AHtml) ])
      end
  else
  if AObj is TatSqlCondition then
    result := GetConditionCaption( TatSqlCondition(AObj), AHtml)
  else
  if AObj is TatSQLGroupField then
    with TatSqlGroupField(AObj) do
      result := HtmlParam('FLD',GetGroupFieldCaption(TatSqlGroupField(AObj)),AHtml)
  else
  if AObj is TatSQLOrderField then
    with TatSqlOrderField(AObj) do
      result := Format('%s %s',
        [ HtmlParam('FLD',GetOrderFieldCaption(TatSqlOrderField(AObj)),AHtml),
          HtmlParam('SORT',SortDesc[SortType],AHtml) ])
  else
  if AObj is TatParamDef then
    with TatParamDef(AObj) do
      case ParamType of
        ptFreeEdit:
          result := Format(_str(SEditParameterEditorTitled),[
            HtmlParam('PNAM',Name,AHtml),
            HtmlParam('PKND',_str(SFreeTyping),AHtml),
            HtmlParam('PCAP',Caption,AHtml) ]);
        ptDistinctList:
          result := Format(_str(SEditParameterEditorTitled),[
            HtmlParam('PNAM',Name,AHtml),
            HtmlParam('PKND',_str(SDropdownAutomatic),AHtml),
            HtmlParam('PCAP',Caption,AHtml) ]);
        ptQueryList:
          result := Format(_str(SEditParameterEditorTitled) + EllipsisHtml,[
            HtmlParam('PNAM',Name,AHtml),
            HtmlParam('PKND',_str(SDropdownQuery),AHtml),
            HtmlParam('PCAP',Caption,AHtml) ]);
        ptChooseList:
          result := Format(_str(SEditParameterEditorTitled) + EllipsisHtml,[
            HtmlParam('PKND',_str(SDropdownChoose),AHtml),
            HtmlParam('PCAP',Caption,AHtml) ]);
        ptCheckList:
          result := Format(_str(SEditParameterEditorTitled) + EllipsisHtml,[
            HtmlParam('PKND',_str(SDropdownCheck),AHtml),
            HtmlParam('PCAP',Caption,AHtml) ]);
      end
  else
  if AObj is TatParamListItem then
    with TatParamListItem(AObj) do
      result := Format(_str(SItemSets) + EllipsisHtml,
        [ HtmlParam('ITEM',Text,AHtml) ])
  else
  if AObj is TatParamValue then
    with TatParamValue(AObj) do
      result := Format(_str(SParameterTo),
        [ HtmlParam('PNAM',Name,AHtml),
          HtmlParam('PVAL',Value,AHtml) ]);

  { também formata a imagem correspondente ao caption
    (quando não há botoes isso é desnecessario porque o StateImages faz o mesmo efeito) }
  if (FTreeView <> nil) and (FTreeView.ShowButtons) then
    result := Format('<IMG src="idx:%d">%s',[AImg,result]);
end;

function TatVisualQuery.EllipsisHtml: string;
begin
//result := Format('<IMG src="idx:%d">',[6]);
  result := '...';
end;

procedure TatVisualQuery.DrawQueryOnTreeView(node:TTreeNode;mdef:TatMetaSqlDef;msql:TatMetaSql;ASelectedObj:TObject; ATitle: string; atomic:boolean;AAtomicObj:TObject);
var opt  : TClauseOptions;

   function newNode(AParentNode:TTreeNode;ACaption:string;AImageIndex:integer;AObj:TObject):TTreeNode;
   var ii : integer;
   begin
     { controle da imagem }
     { testa se pode exibir CheckBoxes }
     if atomic then
       ii := 6
     else
       if (AImageIndex<0) or (AImageIndex>1) or (coCheckBoxes in opt) then
         { exibe a imagem correspondente ao nó }
         ii := AImageIndex
       else
         { não exibe CheckBoxes }
         ii := -1;

     { ignora nós de inclusão e itens desabilitados quando em modo atômico }
     if atomic and ((AObj=FAKE_OBJECT_INSERTION) or (AImageIndex=0)) then
     begin
       { se o nó superior não possui filhos então também exclui o nó superior }
       if not AParentNode.HasChildren then
         AParentNode.Delete;
       result := nil;
       Exit;
     end;

     if (coEditable in opt) then
       if atomic then
         ACaption := '<A HREF="QUERY" CLASS="MENU">'+FormatParametricCaption( ACaption, ii+1, AObj, False )+'</A>'
       else
         ACaption := FormatParametricCaption( ACaption, ii+1, AObj, True )
     else
       ACaption := FormatParametricCaption( ACaption, ii+1, AObj, False );

     { todos os nós de uma meta-sql atômica ficam vinculados ao mesmo objeto passado }
     if atomic then
       AObj := AAtomicObj;

     if FTreeView <> nil then
     begin
       result := FTreeView.Items.AddChildObject(
         AParentNode,
         ACaption,
         AObj );
       result.StateIndex := ii + 1;
     end else
     begin
       result := nil;
       Exit;
     end;

   end;

   procedure addFieldNodes(AParentNode:TTreeNode);
   var node1 : TTreeNode;
       c : integer;
   begin
      if not (coVisible in opt) then Exit;
      begin
         { campos da listagem }
         node1:=newNode(AParentNode,_str(SDataFields)+EllipsisHtml,3,msql.SqlFields);
         with msql.SqlFields do
            for c:=0 to Count-1 do
               with Items[c] do
                  if not (foHiddenFromUser in Options) and (Active or (coShowInactives in opt)) then
                     newNode(node1,DisplayLabel,byte(Active),Items[c]);
         { item para inserção com click }
         if coCanInsert*opt<>[] then
            newNode(node1,_str(SNewField),5,FAKE_OBJECT_INSERTION)
      end;
   end;

   procedure addConditionNodes(AParentNode:TTreeNode;ACond:TatSqlConditions;AMainCond:boolean);
   var node1 : TTreeNode;

      procedure branch(ACond:TatSqlConditions;ANode:TTreeNode);
      var c: integer;
          node2 : TTreeNode;
      begin
         with ACond do
         begin
            if Count>0 then
            begin
               for c:=0 to Count-1 do
                  with Items[c] do
                     { só inclui o item se permite itens desativados ou ele está ativo }
                     if (Active or (coShowInactives in opt)) then
                     begin
                        node2 := newNode(ANode,GetConditionCaption(Items[c]),byte(Active),Items[c]);
                        if ConditionType = ctSubConditions then
                           branch( SubConditions, node2 );
                        node2.Expanded := True;
                     end;
            end;
            { item para inserção com click }
            if coCanInsert*opt<>[] then
               newNode(ANode,_str(SNewCondition),5,FAKE_OBJECT_INSERTION);
         end;
      end;

   begin
      if not (coVisible in opt) then Exit;

      begin
         { restrições da pesquisa }
         if AMainCond then
            node1 := newNode(AParentNode,_str(SFilterConditions)+EllipsisHtml,3,ACond)
         else
            node1 := AParentNode;
         branch(ACond,node1);
      end;
   end;

   procedure addTablesNodes(AParentNode:TTreeNode);
   var node1 : TTreeNode;
       node2 : TTreeNode;
       c, c1 : integer;
   begin
      if not (coVisible in opt) then Exit;

      begin
         { campos da listagem }
         node1:=newNode(AParentNode,_str(SSourceTables)+EllipsisHtml,3,msql.SqlTables);
         with msql.SqlTables do
            for c:=0 to Count-1 do
               with Items[c] do
                  if (Active or (coShowInactives in opt)) then
                  begin
                     { inclui a tabela }
                     node2 := newNode(node1,GetTableCaption(Items[c]),byte(Active),Items[c]);
                     { inclui as condições de junção }
                     for c1:=0 to msql.TableJoins.Count-1 do
                        if SameText(TableAlias,msql.TableJoins[c1].ForeignTableAlias) then
                        begin
                           { inclui as condições de junção }
                           addConditionNodes(node2,msql.TableJoins[c1].JoinConditions,false);
                           Break;
                        end;
                  end;
         { item para inserção com click }
         if coCanInsert*opt<>[] then
            newNode(node1,_str(SNewTable),5,FAKE_OBJECT_INSERTION);
      end;
   end;

   procedure addGroupNodes(AParentNode:TTreeNode);
   var node1 : TTreeNode;
       c : integer;
   begin
      if not (coVisible in opt) then Exit;

      begin
         { ordenação da listagem }
         node1:=newNode(node,_str(SGroupingFields)+EllipsisHtml,3,msql.GroupFields);
         with msql, GroupFields do
            for c:=0 to Count-1 do
               with Items[c] do
                  if (Active or (coShowInactives in opt)) then
                     newNode(node1,GetGroupFieldCaption(Items[c]),byte(Active),Items[c]);
         { item para inserção com click }
         if coCanInsert*opt<>[] then
            newNode(node1,_str(SNewGroupField),5,FAKE_OBJECT_INSERTION)
      end;
   end;

   procedure addOrderNodes(AParentNode:TTreeNode);
   var node1 : TTreeNode;
       c : integer;
   begin
      if not (coVisible in opt) then Exit;

      begin
         { ordenação da listagem }
         node1:=newNode(node,_str(SOrderingFields)+EllipsisHtml,3,msql.OrderFields);
         with msql, OrderFields do
            for c:=0 to Count-1 do
               with Items[c] do
                  if (Active or (coShowInactives in opt)) then
                     newNode(node1,GetOrderFieldCaption(Items[c]),byte(Active),Items[c]);
         { item para inserção com click }
         if coCanInsert*opt<>[] then
            newNode(node1,_str(SNewOrderField),5,FAKE_OBJECT_INSERTION)
      end;
   end;

   procedure addParamNodes(AParentNode:TTreeNode);
   var node1 : TTreeNode;
       node2 : TTreeNode;
       node3 : TTreeNode;
       c, c1, c2 : integer;
   begin
     if not (coVisible in opt) then Exit;
     { ordenação da listagem }
     node1:=newNode(node,_str(SParameterEditors)+EllipsisHtml,3,mdef.ParamDefs);
     with mdef.ParamDefs do
       for c:=0 to Count-1 do
         with Items[c] do
           if (Active or (coShowInactives in opt)) then
           begin
             node2 := newNode(node1,Caption,byte(Active),Items[c]);
             case ParamType of
               ptQueryList:
                 DrawQueryOnTreeView( node2, nil, MetaSql, nil, Items[c].Caption, True, nil );
               ptChooseList, ptCheckList:
                 begin
                   for c1 := 1 to ListItems.Count-1 do
                     with ListItems[c1] do
                     begin
                       node3 := newNode(node2,Text,7,ListItems[c1]);
                       for c2 := 0 to ParamValues.Count-1 do
                         newNode(node3,ParamValues[c2],8,ParamValues.Items[c2]);
                       newNode(node3,_str(SNewParameterAssignment),5,FAKE_OBJECT_INSERTION);
                     end;
                   if ParamType=ptChooseList then
                     newNode(node2,_str(SNewChooseItem),5,FAKE_OBJECT_INSERTION)
                   else
                     newNode(node2,_str(SNewCheckItem),5,FAKE_OBJECT_INSERTION);
                 end;
             end;
           end;
     { item para inserção com click }
     if coCanInsert*opt<>[] then
       newNode(node1,_str(SNewEditor),5,FAKE_OBJECT_INSERTION)
   end;

begin
  { carrega o TreeView com o conteúdo do meta-sql
    que poderá ser modificado pelo usuário }
  with msql do
  begin
    { título da consulta }
    if (ATitle>'') and FShowQueryTitle then
    begin
      if FEditQueryTitle then
        opt := [coVisible, coEditable]
      else
        opt := [];
      node := newNode(node, ATitle, 2, mdef);
    end;

    opt := FTablesOptions;
    addTablesNodes(node);

    opt := FFieldsOptions;
    addFieldNodes(node);

    opt := FConditionsOptions;
    addConditionNodes(node,msql.Conditions,true);

    opt := FGroupingOptions;
    addGroupNodes(node);

    opt := FOrderingOptions;
    addOrderNodes(node);

    if Assigned(mdef) then
    begin
      opt := FParamsOptions;
      addParamNodes(node);
    end;
  end;
end;

procedure TatVisualQuery.LoadTreeView( AObj: TObject=nil );
begin
  if FTreeView <> nil then
  begin
    FIgnoreVisualAdjustments := True;
    { carrega o TreeView com o conteúdo do meta-sql
      que poderá ser modificado pelo usuário }
    with FTreeView do
    try
      Visible := false;
      Items.BeginUpdate;
      Items.Clear;
      try
        { desenha no treeview a consulta atual }
        DrawQueryOnTreeView( nil, MetaSqlDef, MetaSqlDef.MetaSql, AObj, MetaSqlDef.Title, False, nil );

        { se indicou um objeto específico então tenta selecionar o item
          correspondente ao objeto dado }
        if Assigned(AObj) then
          SelectNodeByObject(AObj);
      finally
        Items.EndUpdate;
        Visible := True;
        if Assigned(AObj) and not Focused then
          SetFocus;
      end;

    finally
      FIgnoreVisualAdjustments := False;
    end;
  end;
end;

function TatVisualQuery.ClauseNodeOptions(AItem:TTreeNode):TClauseOptions;
begin
   result := [];

   { retorna as opções da cláusula correspondente ao item dado }

   if Assigned(AItem) then
   begin
     while Assigned(AItem) and not NodeIsMainCollection(AItem) do
       AItem := AItem.Parent;

     if Assigned(AItem) then
       if TObject(AItem.Data) is TatSqlTables then
         result := FTablesOptions
       else
       if TObject(AItem.Data) is TatSqlFields then
         result := FFieldsOptions
       else
       if TObject(AItem.Data) is TatSqlConditions then
         result := FConditionsOptions
       else
       if TObject(AItem.Data) is TatSqlGroupFields then
         result := FGroupingOptions
       else
       if TObject(AItem.Data) is TatSqlOrderFields then
         result := FOrderingOptions
       else
       if TObject(AItem.Data) is TatParamDefs then
         result := FParamsOptions;
   end;
end;

procedure TatVisualQuery.FTreeViewDragOver(Sender, Source: TObject; X, Y: Integer;State: TDragState; var Accept: Boolean);
var item : TTreeNode;
    opt  : TClauseOptions;
begin
   { só aceita arraste entre itens de mesma classe }
   { não aceita arraste de condições }
   if FTreeView <> nil then with FTreeView do
   begin
      item := GetNodeAt(X, Y);
      opt := ClauseNodeOptions(item);
      Accept := (Item<>Selected) and
                Assigned(Item) and
                NodeHasObject(Item) and
                Assigned(Selected) and
                NodeHasObject(Selected) and
                (TObject(Item.Data).ClassType=TObject(Selected.Data).ClassType) and
                not (TObject(Item.Data) is TatSqlCondition) and
                (coChangePosition in opt);
   end;
end;

procedure TatVisualQuery.FTreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
var Item:TTreeNode;
    sourceItem : TCollectionItem;
    targetItem : TCollectionItem;
    SaveStateIndex : integer;
begin
   { modifica a ordem do item de origem com referência ao item destino }
   if FTreeView <> nil then with FTreeView do
   begin
      Item := GetNodeAt(X, Y);
      sourceItem := TObject(Selected.Data) as TCollectionItem;
      targetItem := TObject(Item.Data) as TCollectionItem;
      sourceItem.Index := targetItem.Index;
      Visible := false;
      {Delphi 7 state image bug workaround}
      SaveStateIndex := Selected.StateIndex;
      Selected.StateIndex := -1;
      {Delphi 7 state image bug workaround}
      if Item.Index>Selected.Index then
         if (Item.GetNextSibling<>nil) then
            Selected.MoveTo(Item.GetNextSibling,naInsert)
         else
            Selected.MoveTo(Item,naAdd)
      else
         Selected.MoveTo(Item,naInsert);
      {Delphi 7 state image bug workaround}
      Selected.StateIndex := SaveStateIndex;
      {Delphi 7 state image bug workaround}
      Visible := true;

      { se modificou a ordem de um parâmetro, então ajusta-o imediatamente }
      if TObject(Selected.Data) is TatParamDef then
         AdjustVisualQueryPanel;

      { dispara a reatualização da query }
      TriggerQueryRefresh(Self);
   end;
end;

procedure TatVisualQuery.TreeViewHtmlParamEnter(Sender:TObject;ANode: TTreeNode; href,value: string);
begin
//  OutputDebugString(PChar(Format('Enter: %s = %s',[href,value])));
end;

procedure TatVisualQuery.TreeViewHtmlParamExit(Sender:TObject;ANode: TTreeNode; href,value: string);
begin
//  OutputDebugString(PChar(Format('Exit: %s = %s',[href,value])));
end;

procedure TatVisualQuery.TreeViewUpdateImage(Sender: TObject; Node: TTreeNode);
begin
  UpdateNodeImage( Node );
end;

procedure TatVisualQuery.UpdateNodeImage(Node: TTreeNode);
begin
  Exit;
  // não está funcionando (ver processamento do click)

  if Assigned(Node) and ((Node.StateIndex = 4) or (Node.StateIndex = 10)) then
    if Node.HasChildren and Node.Expanded then
      Node.StateIndex := 10
    else
      Node.StateIndex := 4;
end;

procedure TatVisualQuery.FTreeViewEditing(Sender: TObject; Node: TTreeNode;var AllowEdit: Boolean);
var opt : TClauseOptions;
begin
   { somente permite edição do nome da consulta, legenda de campo ou
     descrição de uma restrição de pesquisa }

   opt := ClauseNodeOptions(node);

   AllowEdit := NodeHasObject(Node)
                and
                (
                  {$IFDEF TMSDOTNET}
                  NodeIsQueryTitle(Node)
                  {$ELSE}
                  NodeIsQueryTitle(Node.Data)
                  {$ENDIF}
                  or
                  (
                    ( coEditable in opt )
                    and
                    (
                         ( TObject(Node.Data) is TatSqlField )
                      or ( TObject(Node.Data) is TatParamDef )
                      or ( TObject(Node.Data) is TatSqlCondition )
                    )
                  )
                );
end;

procedure TatVisualQuery.FTreeViewKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
   if FTreeView <> nil then with FTreeView do
      if not IsEditing then
      begin
         { permite Editar o item selecionado no TreeView ao pressionar F2 }
         if (key=VK_F2) and Assigned(Selected) then
            Selected.EditText; // *** deveria editar o parâmetro corrente
         { simula o duplo click ao pressionar ESPAÇO }
         if (key=VK_SPACE) then
         begin
            Key:=0;
            FTreeViewCheckUncheck(Sender);
         end;
         { exclui o item com DELETE }
         if (key=VK_DELETE) and Assigned(Selected) then
         begin
            Key:=0;
            DeleteItem(Selected);
         end;
         { abre o PopUpMenu com F1 }
         if (key=VK_F1) then
         begin
            OpenNodePopupMenu(pmFull);
            Key := 0;
         end;
         if (key=VK_INSERT) then
         begin
            OpenNodePopupMenu(pmInsertion);
            Key := 0;
         end;
      end;
end;

procedure TatVisualQuery.OpenNodePopupMenu( mode:TPopupMode );
begin
   if FTreeView <> nil then with FTreeView do
   begin
      FPopupMode := mode;
      AdjustPopupPoint;
      with FLastPopUpPoint do
         FTreeView.PopUpMenu.PopUp(X,Y);
   end;
end;

procedure TatVisualQuery.DeleteItem(ANode:TTreeNode);
var opt : TClauseOptions;
    isParam : boolean;
begin
   opt := ClauseNodeOptions(ANode);
   if (coDeleteItems in opt) and Assigned(ANode) and NodeHasObject(ANode) and
      (TObject(ANode.Data) is TCollectionItem) then
   begin
      isParam := TObject(ANode.Data) is TatParamDef;
      if Assigned(FOnItemDeleting) then
        FOnItemDeleting(Self, TObject(ANode.Data));
        
      TCollectionItem(ANode.Data).Collection.Delete(TCollectionItem(ANode.Data).Index);
      ANode.Delete;

      { recarrega todo o TreeView (porque a exclusão pode ter afetado mais de um item }
// a atualização completa ainda não está satisfatória porque não é possível retornar a seleção ao mesmo ponto
//      LoadTreeView( FTreeView.Selected.Data );

      { se era um parâmetro também destrói seu editor }
      if isParam then
        RebuildParamEditors;

      AdjustVisualQueryPanel;

      if Assigned(FOnItemDeleted) then
        FOnItemDeleted(Self);

      { dispara a reatualização da consulta }
      TriggerQueryRefresh(Self);
   end;
end;

procedure TatVisualQuery.FTreeViewEdited(Sender: TObject; Node: TTreeNode;var S: String);
begin
  { fim da edição de alguma legenda }
  if Assigned(node) then
    if NodeHasObject(Node) then
      with Node do
      begin
        if TObject(Data) is TatSqlField then
          TatSqlField(Data).DisplayLabel := S
        else
        if TObject(Data) is TatSqlCondition then
          TatSqlCondition(Data).Text := S
        else
        if TObject(Data) is TatParamDef then
        begin
          TatParamDef(Data).Caption := S;
          AdjustVisualQueryPanel;
        end;
      end
    else
      {$IFDEF TMSDOTNET}
      if NodeIsQueryTitle(Node) then
      {$ELSE}
      if NodeIsQueryTitle(Node.Data) then
      {$ENDIF}
        MetaSqlDef.Title := S;
end;

procedure TatVisualQuery.FRefreshTimerTimer(Sender: TObject);
begin           
  FRefreshTimer.Enabled := FALSE;
  if (FTreeView <> nil) and not FTreeView.Dragging then
    RefreshDataset;
end;

procedure TatVisualQuery.TriggerQueryRefresh(Sender: TObject);
begin
  if not FChangingParamEditors then
  begin
    { reset timer to refresh query }
    FRefreshTimer.Enabled := FALSE;
    FRefreshTimer.Enabled := TRUE;
  end;
end;

{ TatMetaSqlDefs }

function TatMetaSqlDefs.Add: TatMetaSqlDef;
begin
   result := TatMetaSqlDef( inherited Add );
end;

function TatMetaSqlDefs.GetItem(i: integer): TatMetaSqlDef;
begin
   result := TatMetaSqlDef( inherited Items[i] );
end;

{$IFDEF TMSDOTNET}
function TatMetaSqlDefs.GetOwner: TPersistent;
begin
  result := inherited GetOwner;
end;
{$ENDIF}

function TatMetaSqlDefs.IndexOf(ATitle: string): integer;
begin
   for result:=0 to Count-1 do
      if AnsiCompareTExt(Items[result].FTitle,ATitle)=0 then
         Exit;
   result := -1;
end;

{ TatMetaSqlDef }

procedure TatMetaSqlDef.Assign(Source: TPersistent);
begin
  if Source is TatMetaSqlDef then
  begin
    Title := TatMetaSqlDef(Source).Title;
    ParamDefs := TatMetaSqlDef(Source).ParamDefs;
    if TatMetaSqlDef(Source).IsStoredMetaSql then
      MetaSql := TatMetaSqlDef(Source).MetaSql;
  end
  else
    inherited Assign(Source);
end;

constructor TatMetaSqlDef.Create(ACollection: TCollection);
var aVisualQuery : TatVisualQuery;
begin
  inherited;
  FTitle := _str(SNewVisualQueryTitle);
  FParamDefs := TatParamDefs.Create(Self,TatParamDef);

  aVisualQuery := nil;
  if TatVisualQuery(TatMetaSqlDefs(Collection).GetOwner) is TatVisualQuery then
    aVisualQuery := TatVisualQuery(TatVisualQuery(TatMetaSqlDefs(Collection).GetOwner));
  if (not aVisualQuery.IsLoading) then
  begin
    MetaSQL.QualifiedFieldAliases := TatVisualQuery(TatMetaSqlDefs(Collection).GetOwner).QualifiedFieldAliases;
    MetaSQL.FieldAliasSeparator := TatVisualQuery(TatMetaSqlDefs(Collection).GetOwner).FieldAliasSeparator;
    MetaSQL.SyntaxConf := TatVisualQuery(TatMetaSQLDefs(Collection).GetOwner).SyntaxConf;
    MetaSQL.SQLSyntax := TatVisualQuery(TatMetaSqlDefs(Collection).GetOwner).SQLSyntax;
  end;
end;

destructor TatMetaSqlDef.Destroy;
begin 
  if (VisualQuery <> nil) and (VisualQuery.FMetaSQLDef = Self) then
    VisualQuery.FMetaSQLDef := nil;
  if Assigned(FMetaSql) then
    FMetaSql.Free;
  if Assigned(FParamDefs) then
    FParamDefs.Free;
  inherited;                                    
end;

function TatVisualQuery.GetMetaSqlDef: TatMetaSqlDef;
begin
  { se ainda não existe uma MetaSqlDef corrente então cria uma com base no
    MetaSql associado }
  if not Assigned(FMetaSqlDef) then
    { se já tem alguma então retorna a primeira, senão cria uma }
    if FMetaSqlDefs.Count > 0 then
      FMetaSqlDef := FMetaSqlDefs[0]
    else
//  begin
      FMetaSqlDef := FMetaSqlDefs.Add;
//    if Assigned(FMetaSql) then
//      FMetaSqlDef.MetaSql.Assign(FMetaSql);
//  end;

  result := FMetaSqlDef;
end;

function TatMetaSqlDef.VisualQuery: TatVisualQuery;
begin
  result := TatMetaSqlDefs(Collection).GetOwner as TatVisualQuery;
end;

function TatMetaSqlDef.GetMetaSql: TatInternalMetaSql;
begin
  { MetalSql is a referenced object, but when the reference is nil
    object is created here. This behaviour was made this way for
    streaming purposes }
  if not Assigned(FMetaSql) then
  begin
    FMetaSql := TatInternalMetaSql.Create(VisualQuery);
    FMetaSql.Name := VisualQuery.GetUniqueMetaSqlName;  
    if (VisualQuery <> nil) then
    begin
      FMetaSQL.QualifiedFieldAliases := VisualQuery.QualifiedFieldAliases;
      FMetaSQL.FieldAliasSeparator := VisualQuery.FieldAliasSeparator;
      FMetaSQL.SyntaxConf := VisualQuery.SyntaxConf;
      FMetaSQL.SQLSyntax := VisualQuery.SQLSyntax;
    end;
  end;
  result := FMetaSql;
end;

procedure TatMetaSqlDef.SetMetaSql(const Value: TatInternalMetaSql);
var root : TComponent;
begin
  { descobre o componente que é a raiz do streaming desta propriedade }
  root := TatMetaSqlDefs(Collection).GetOwner as TComponent;
  if Assigned(TatVisualQuery(root).FContainer) then
    root := TatVisualQuery(root).FContainer;

  { if loading component from stream
    then setting acts like referenced object,
    otherwise it atcs like a aggregated object setting }
  if Assigned(FMetaSql) then
    { copy meta-sql content from source }
    FMetaSql.Assign(Value)
  else
    if (csLoading in root.ComponentState) then
      { just assign the meta-sql reference }
      FMetaSql := Value
    else
      { creates a new MetaSql instance and copies meta-sql content from source }
      MetaSql.Assign(Value);
end;

procedure TatVisualQuery.SelectNodeByObject(AObj:TObject);
var c: integer;
begin
   if FTreeView <> nil then with FTreeView, Items do
   begin
      { varre todos os nós procurando pelo desejado }
      for c:=0 to Count-1 do
      begin
         { testa se o nó tem o texto dado e descende da classe dada }
         if NodeHasObject(Items[c]) and (TObject(Items[c].Data)=AObj) then
         begin
            { seleciona o item encontrado }
            Selected := Items[c];
            Exit;
         end;
      end;
   end;
end;

procedure TatVisualQuery.IncludeItemClick(Sender: TObject);
var obj : TObject;
    colObj : TObject;
    newObj : TObject;
    c : integer;
begin
   with Sender as TMenuItem do
   begin
      { encontra o objeto de coleção associado ao item de menu clicado }
      if Parent.Caption=_str(SInclude) + '...' then
         colObj := TObject(Parent.Tag)
      else
         if Parent.Parent.Caption=_str(SInclude) + '...' then
            colObj := TObject(Parent.Parent.Tag)
         else
            colObj := nil;

      { obtém o objeto associado ao item de menu clicado }
      obj := TObject(Tag);

      { ativa o objeto correspondente ao item de menu }

      if (colObj is TatSqlTables) then
         if (obj is TatSqlTable) then
            { reativa uma tabela }
            TatSqlTable(obj).Active := true
         else
         begin
            OpenItemEditor(
               TfmCustomTableEditor,
               FLastPopupPoint.X,
               FLastPopupPoint.Y,
               Self,
               MetaSqlDef,
               obj );
           { verifica se deve criar campos em função de alteração na tabela }
           if assigned(obj) then
              CheckTableChange( TatSqlTable(obj), '', TatSqlTable(obj).Tablename);
         end;

      if (colObj is TatSqlFields) then
         if (obj is TatSqlField) then
            { reativa um campo }
            TatSqlField(obj).Active := true
         else
            if (obj is TatSqlFields) then
               with TatSqlFields(obj) do
               begin
                  { reativa todos os campos inativos }
                  for c:=0 to Count-1 do
                     if not Items[c].Active and not (foHiddenFromUser in Items[c].Options) then
                        Items[c].Active := true;
               end
            else
               { inclui um campo com o assistente de inclusão }
               if Caption = _str(SSingleField) then
                  OpenItemEditor(
                     TfmSingleFieldEditor,
                     FLastPopupPoint.X,
                     FLastPopupPoint.Y,
                     Self,
                     MetaSqlDef,
                     obj )
               else
                  OpenItemEditor(
                     TfmExpressionFieldEditor,
                     FLastPopupPoint.X,
                     FLastPopupPoint.Y,
                     Self,
                     MetaSqlDef,
                     obj );

      if (colObj is TatSqlGroupFields) then
         if (obj is TatSqlGroupField) then
            { reativa um campo de agrupamento }
            TatSqlGroupField(obj).Active := true
         else
            if (obj is TatSqlField) then
            begin
               { inclui um novo campo de agrupamento }
               newObj := TatSqlGroupFields(colObj).Add;
               with TatSqlGroupField(newObj) do
                  FieldAlias := TatSqlField(obj).FieldAlias;
               obj := newObj;
            end
            else
               { inclui um campo de agrupamento com o assistente de inclusão }
               OpenItemEditor(
                  TfmCustomGroupEditor,
                  FLastPopupPoint.X,
                  FLastPopupPoint.Y,
                  Self,
                  MetaSqlDef,
                  obj );

      if (colObj is TatSqlOrderFields) then
         if (obj is TatSqlOrderField) then
            { reativa um campo de ordenação }
            TatSqlOrderField(obj).Active := true
         else
            if (obj is TatSqlField) then
            begin
               { inclui um novo campo de ordenação }
               newObj := TatSqlOrderFields(colObj).Add;
               with TatSqlOrderField(newObj) do
               begin
                  FieldAlias := TatSqlField(obj).FieldAlias;
               end;
               obj := newObj;
            end
            else
               { inclui um campo de ordenação com o assistente de inclusão }
               OpenItemEditor(
                  TfmCustomOrderEditor,
                  FLastPopupPoint.X,
                  FLastPopupPoint.Y,
                  Self,
                  MetaSqlDef,
                  obj );

      if (colObj is TatParamDefs) then
         if (obj is TatParamDef) then
         begin
            { reativa um parâmetro }
            TatParamDef(obj).Active := true;
            AdjustVisualQueryPanel;
         end
         else
         begin
            if Caption = _str(SFreeTypingEditor) then
               OpenItemEditor(
                  TfmFreeEditParamEditor,
                  FLastPopupPoint.X,
                  FLastPopupPoint.Y,
                  Self,
                  MetaSqlDef,
                  obj )
            else
            if Caption = _str(SAutomaticListEditor) then
               OpenItemEditor(
                  TfmDistinctListParamEditor,
                  FLastPopupPoint.X,
                  FLastPopupPoint.Y,
                  Self,
                  MetaSqlDef,
                  obj )
            else
            if Caption = _str(SQueryListEditor) then
               OpenItemEditor(
                  TfmQueryListParamEditor,
                  FLastPopupPoint.X,
                  FLastPopupPoint.Y,
                  Self,
                  MetaSqlDef,
                  obj )
            else
            if Caption = _str(SChooseListEditor) then
               OpenItemEditor(
                  TfmChooseListParamEditor,
                  FLastPopupPoint.X,
                  FLastPopupPoint.Y,
                  Self,
                  MetaSqlDef,
                  obj )
            else
               { 'Check-list editor' }
               OpenItemEditor(
                  TfmCheckListParamEditor,
                  FLastPopupPoint.X,
                  FLastPopupPoint.Y,
                  Self,
                  MetaSqlDef,
                  obj );

           if Assigned(obj) then
             RebuildParamEditors;
         end;

      if (colObj is TatSqlConditions) then
         if (obj is TatSqlCondition) then
            { reativa uma condição }
            TatSqlCondition(obj).Active := true
         else
         begin
            obj := colObj; { target Conditions for a new subcondition }

            if Caption = _str(SFieldComparing) then
               OpenItemEditor(
                  TfmCompareConditionEditor,
                  FLastPopupPoint.X,
                  FLastPopupPoint.Y,
                  Self,
                  MetaSqlDef,
                  obj )
            else
            if Caption = _str(SCustomExpression) then
               OpenItemEditor(
                  TfmExpressionConditionEditor,
                  FLastPopupPoint.X,
                  FLastPopupPoint.Y,
                  Self,
                  MetaSqlDef,
                  obj )
            else
               { 'Nested subconditions' }
               OpenItemEditor(
                  TfmSubconditionsEditor,
                  FLastPopupPoint.X,
                  FLastPopupPoint.Y,
                  Self,
                  MetaSqlDef,
                  obj );
         end;

      if obj=nil then
      begin
        obj := colObj;
        if FTreeView <> nil then
          FTreeView.Selected.Collapse(false);
      end
      else
      begin
        { recarrega todo o TreeView }
        LoadTreeView( obj );
        { dispara a reatualização da consulta }
        TriggerQueryRefresh(Sender);
      end;

      { reajusta os controles visuais do VisualQuery }
      AdjustVisualQueryPanel;
   end;
end;

{$IFDEF TMSDOTNET}
function TatVisualQuery.AddMenuItem(AOwner:TMenuItem;ACaption:string;AClick:TNotifyEvent;ATag: Variant = nil): TMenuItem;
{$ELSE}
function TatVisualQuery.AddMenuItem(AOwner:TMenuItem;ACaption:string;AClick:TNotifyEvent;ATag:integer=0):TMenuItem;
{$ENDIF}
begin
   result := TMenuItem.Create(AOwner);
   with result do
   begin
      Caption := ACaption;
      OnClick := AClick;
      Tag := ATag;
   end;
   AOwner.Add( result );
end;

function TatVisualQuery.NodeIsQueryTitle(node: TTreeNode): boolean;
begin
  result := Assigned(node) and
            Assigned(node.Data) and
            {$IFNDEF TMSDOTNET}
            ( integer(node.Data) > 1000 ) and
            {$ENDIF}
            ( TObject(node.Data) is TatMetaSqlDef );
end;

function TatVisualQuery.NodeIsMainCollection(node: TTreeNode): boolean;
begin
  result := Assigned(node) and
            Assigned(node.Data) and
            {$IFNDEF TMSDOTNET}
            ( integer(node.Data) > 1000 ) and
            {$ENDIF}
            (
              (TObject(node.Data) is TatSqlTables) or
              (TObject(node.Data) is TatSqlFields) or
              (TObject(node.Data) is TatSqlconditions) or
              (TObject(node.Data) is TatSqlGroupFields) or
              (TObject(node.Data) is TatSqlOrderFields) or
              (TObject(node.Data) is TatParamDefs)
            );
end;

function TatVisualQuery.NodeHasObject(node: TTreeNode): boolean;
begin
  result := Assigned(node) and
            Assigned(node.Data)
            {$IFNDEF TMSDOTNET}
            and (integer(node.Data)>1000)
            {$ENDIF}
            ;
end;

function TatVisualQuery.NodeAllowSubNodes(node: TTreeNode): boolean;
begin
   { retorna True se o nó está associado a uma coleção
      ou a uma Condition do tipo SubConditions }
   result := NodeHasObject(node)
             and
             (
               NodeIsQueryTitle(node) or
               NodeIsMainCollection(node)
               or
               (
                 (TObject(node.Data) is TatSqlCondition)
                 and (TatSqlCondition(node.Data).ConditionType=ctSubconditions)
               )
             );
end;

procedure TatVisualQuery.AdjustPopupPoint;
var r : TRect;
begin
  if FTreeView <> nil then
  begin
    r := FTreeView.Selected.DisplayRect(true);
    FLastPopUpPoint := ClientToScreen(Point(r.Left,r.Bottom));
  end;
end;

procedure TatVisualQuery.FPopupMenuPopup(Sender: TObject);
var
  node: TTreeNode;
  obj: TObject;
begin
   if FTreeView <> nil then with FTreeView do
   begin
      {update popup position (in case it was popuped by a mouse click}
      AdjustPopupPoint;
      Selected := Selected; // just for highlight the selected item

      FPopupMenu.Items.Clear;

      node := FTreeView.Selected;

      {find the collection node if the menu was activated from inside a collection (group)}
      while (FPopupMode = pmInsertion) and Assigned(node) and not NodeAllowSubNodes(node) do
         node := node.Parent;

      if NodeHasObject(node) then
         obj := TObject(node.Data)
      else
         obj := nil;

      if Assigned(node) then
      begin
         {Test the selected node in order to create the correct options}
         if NodeIsQueryTitle(node) then
            PrepareQueryMenu
         else
         if Assigned(obj) then
            if (obj is TatSqlTables) then
               PrepareTableItemsMenu
            else
            if (obj is TatSqlFields) then
               PrepareFieldItemsMenu
            else
            if (obj is TatSqlConditions) or
               ((obj is TatSqlCondition) and (TatSqlCondition(obj).ConditionType=ctSubConditions)) then
               PrepareConditionItemsMenu(obj)
            else
            if (obj is TatSqlGroupFields) then
               PrepareGroupItemsMenu
            else
            if (obj is TatSqlOrderFields) then
               PrepareOrderItemsMenu
            else
            if (obj is TatParamDefs) then
               PrepareParamItemsMenu
            else
            if (obj is TCollectionItem) then
               PrepareItemMenu;
      end
      else
        PrepareQueryMenu;
   end;
end;

procedure TatVisualQuery.PrepareQueryMenu;
var c: integer;
begin
  { prepara o menu popup com as opções gerais da consulta }
  if FMetaSqlDefs.Count>0 then
  begin
    for c:=0 to FMetaSqlDefs.Count-1 do
      AddMenuItem(
        FPopupMenu.Items,
        FMetaSqlDefs[c].Title,
        OpenQueryItemClick,
        {$IFDEF TMSDOTNET}
        Variant(FMetaSqlDefs[c])); // save a reference do MetaSqlDef into Tag property
        {$ELSE}
        integer(FMetaSqlDefs[c])); // save a reference do MetaSqlDef into Tag property
        {$ENDIF}
    AddMenuItem(FPopupMenu.Items,'-',nil);
  end;
  AddMenuItem(FPopupMenu.Items,_str(SNewQuery),NewQueryItemClick);
  AddMenuItem(FPopupMenu.Items,_str(SDuplicateThisQuery),SaveQueryItemClick);
  AddMenuItem(FPopupMenu.Items,_str(SDeleteThisQuery),DeleteQueryItemClick);
end;

function TatVisualQuery.FindTableMenuItem(mn:TMenuItem;ABaseField:TatSqlBaseField):TMenuItem;
var c: integer;
    tab : TatSqlTable;
    fld : TatSqlField;
begin
   { encontra o campo correspondente ao campo dado }
   fld := ABaseField.MetaSql.SqlFields.FindByAlias(ABaseField.FieldAlias);

   if (fld.ExpressionType=etStandard) then
      { encontra a tabela correspondente ao campo dado }
      tab := ABaseField.MetaSql.SqlTables.FindByAlias(fld.TableAlias)
   else
      tab := nil;

   if Assigned(tab) then
   begin
      { procura por um item de menu que corresponda a tabela indicada pelo ATableAlias }
      for c:=0 to mn.Count-1 do
         if TObject(mn.Items[c].Tag)=tab then
         begin
            result := mn.Items[c];
            Exit;
         end;

      { não encontrou então cria um item agora }
      {$IFDEF TMSDOTNET}
      result := AddMenuItem(mn,GetTableCaption(tab),nil,Variant(tab));
      {$ELSE}
      result := AddMenuItem(mn,GetTableCaption(tab),nil,integer(tab));
      {$ENDIF}
   end
   else
   begin
      { não cria submenu quando o campo não estiver associado a uma única tabela }
      result := mn;
      Exit;
   end;
end;

procedure TatVisualQuery.CheckIncludeMenu(var mi:TMenuItem; AObj:TObject);
begin
  if not Assigned(mi) then
    if FPopupMode=pmInsertion then
    begin
      { torna o próprio popup o menu de inclusão }
      mi := FPopUpMenu.Items;
      mi.Caption := _str(SInclude) + '...';
      {$IFDEF TMSDOTNET}
      mi.Tag := Variant(AObj);
      {$ELSE}
      mi.Tag := integer(AObj);
      {$ENDIF}
    end
    else
      { inclui um submenu para inclusão }
      mi:=AddMenuItem(
        FPopUpMenu.Items,
        _str(SInclude) + '...',
        nil,
        {$IFDEF TMSDOTNET}
        Variant(AObj) );
        {$ELSE}
        integer(AObj) );
        {$ENDIF}
end;

procedure TatVisualQuery.PrepareTableItemsMenu;
var opt : TClauseOptions;
    c   : integer;
    mi  : TMenuItem;
begin
   with MetaSqlDef.FMetaSql do
   begin
      { verifica se permite incluir tabelas inativas }
      opt := FTablesOptions;
      mi := nil;

      if coInsertInactives in opt then
      begin
         { permite incluir tabelas inativas (reativando-as) }
         for c:=0 to SqlTables.Count-1 do
            with SqlTables[c] do
               if not Active then
               begin
                  CheckIncludeMenu(mi, SqlTables);

                  AddMenuItem(
                     mi,
                     GetTableCaption(SqlTables[c]),
                     IncludeItemClick,
                     {$IFDEF TMSDOTNET}
                     Variant(SqlTables[c]));
                     {$ELSE}
                     integer(SqlTables[c]) );
                     {$ENDIF}
               end;
      end;

      { permite incluir tabelas com assistente }
      if coInsertCustom in opt then
      begin
         CheckIncludeMenu(mi, SqlTables);
         { opção para inclusão livre de tabela (com assistente) }
         AddMenuItem( mi, _str(STable) + '...', IncludeItemClick );
      end;
   end;
end;

procedure TatVisualQuery.PrepareFieldItemsMenu;
var opt : TClauseOptions;
    c   : integer;
    mi  : TMenuItem;
begin
   with MetaSqlDef.FMetaSql do
   begin
      { verifica se permite incluir tabelas inativas }
      opt := FFieldsOptions;
      mi := nil;

      if coInsertInactives in opt then
      begin
         { permite incluir campos inativos (reativando-os) }
         for c:=0 to SqlFields.Count-1 do
            with SqlFields[c] do
               if not Active and not (foHiddenFromUser in Options) then
               begin
                  CheckIncludeMenu(mi, SqlFields);

                  AddMenuItem(
                     FindTableMenuItem(mi,SqlFields[c]),
                     DisplayLabel,
                     IncludeItemClick,
                     {$IFDEF TMSDOTNET}
                     Variant(SqlFields[c]));
                     {$ELSE}
                     integer(SqlFields[c]) );
                     {$ENDIF}
               end;
      end;

      { permite incluir campos com assistente }
      if coInsertCustom in opt then
      begin
         CheckIncludeMenu(mi, SqlFields);
         AddMenuItem( mi, _str(SSingleField), IncludeItemClick );
         AddMenuItem( mi, _str(SExpression), IncludeItemClick );
      end;
   end;
end;

procedure TatVisualQuery.PrepareConditionItemsMenu(AObj:TObject);
var opt : TClauseOptions;
    mi  : TMenuItem;

    procedure branch(ACond:TatSqlConditions);
    var c : integer;
    begin
       { permite incluir condições inativas (reativando-as) }
       for c:=0 to ACond.Count-1 do
          with ACond[c] do
          begin
             if not Active then
             begin
                CheckIncludeMenu(mi, ACond);

                AddMenuItem(
                   mi,
                   GetConditionCaption(ACond[c]),
                   IncludeItemClick,
                   {$IFDEF TMSDOTNET}
                   Variant(ACond[c]));
                   {$ELSE}
                   integer(ACond[c]) );
                   {$ENDIF}
             end;
             if ConditionType=ctSubConditions then
                branch(SubConditions);
          end;
    end;

begin
   with MetaSqlDef.FMetaSql do
   begin
      { verifica se permite incluir codições inativas }
      opt := FConditionsOptions;
      mi := nil;

      { permite incluir condições com assistente }
      if coInsertCustom in opt then
      begin
         if AObj is TatSqlConditions then
           CheckIncludeMenu(mi, TatSqlConditions(AObj))
         else
           if AObj is TatSqlCondition then
             if TatSqlCondition(AObj).ConditionType=ctSubconditions then
               CheckIncludeMenu(mi, TatSqlCondition(AObj).SubConditions)
             else
               CheckIncludeMenu(mi, TatSqlCondition(AObj).Collection)
           else
             CheckIncludeMenu(mi, Conditions);

         AddMenuItem( mi, _str(SFieldComparing), IncludeItemClick );
         AddMenuItem( mi, _str(SCustomExpression), IncludeItemClick );
         AddMenuItem( mi, _str(SNestedSubconditions), IncludeItemClick );
      end;
   end;
end;

procedure TatVisualQuery.PrepareGroupItemsMenu;
var opt : TClauseOptions;
    c   : integer;
    mi  : TMenuItem;
    fld : TatSqlGroupField;
begin
   with MetaSqlDef.FMetaSql do
   begin
      { verifica se permite incluir tabelas inativas }
      opt := FGroupingOptions;
      mi := nil;

      if coInsertInactives in opt then
      begin
         { permite incluir campos de agrupamento inativos (reativando-as) }
         for c:=0 to GroupFields.Count-1 do
            with GroupFields[c] do
               if not Active then
               begin
                  CheckIncludeMenu(mi, GroupFields);

                  AddMenuItem(
                     FindTableMenuItem(mi,GroupFields[c]),
                     GetGroupFieldCaption(GroupFields[c]),
                     IncludeItemClick,
                     {$IFDEF TMSDOTNET}
                     Variant(GroupFields[c]));
                     {$ELSE}
                     integer(GroupFields[c]) );
                     {$ENDIF}
               end;
      end;

      if coInsertAvailFields in opt then
      begin
         { permite incluir campos que estão apenas nos fields }
         for c:=0 to SqlFields.Count-1 do
            with SqlFields[c] do
            begin
               { só permite incluir campos não ocultos e que não tem função de agrupamento }
               if not (foHiddenFromUser in Options) and
                  (GroupFunction=agfNone) then
               begin
                  fld := TatSqlGroupField( GroupFields.FindByAlias(FieldAlias) );
                  if not Assigned(fld) or
                     (not (coInsertInactives in opt) and not fld.Active) then
                  begin
                     CheckIncludeMenu(mi, GroupFields);

                     if Assigned(fld) then
                        AddMenuItem(
                           FindTableMenuItem(mi,fld),
                           GetGroupFieldCaption(fld),
                           IncludeItemClick,
                           {$IFDEF TMSDOTNET}
                           Variant(fld))
                           {$ELSE}
                           integer(fld))
                           {$ENDIF}
                     else
                        AddMenuItem(
                           FindTableMenuItem(mi,SqlFields[c]),
                           SqlFields[c].Displaylabel,
                           IncludeItemClick,
                           {$IFDEF TMSDOTNET}
                           Variant(SqlFields[c]));
                           {$ELSE}
                           integer(SqlFields[c]) );
                           {$ENDIF}
                  end;
               end;
            end;
      end;

      { permite incluir campo de agrupamento com assistente }
      if coInsertCustom in opt then
         CheckIncludeMenu(mi, GroupFields);
   end;
end;

procedure TatVisualQuery.PrepareOrderItemsMenu;
var opt : TClauseOptions;
    c   : integer;
    mi  : TMenuItem;
    fld : TatSqlOrderField;
begin
   with MetaSqlDef.FMetaSql do
   begin
      { verifica se permite incluir tabelas inativas }
      opt := FOrderingOptions;
      mi := nil;

      if coInsertInactives in opt then
      begin
         { permite incluir campos de ordenação inativos (reativando-as) }
         for c:=0 to OrderFields.Count-1 do
            with OrderFields[c] do
               if not Active then
               begin
                  CheckIncludeMenu(mi, OrderFields);

                  AddMenuItem(
                     FindTableMenuItem(mi,OrderFields[c]),
                     GetOrderFieldCaption(OrderFields[c]),
                     IncludeItemClick,
                     {$IFDEF TMSDOTNET}
                     Variant(OrderFields[c]));
                     {$ELSE}
                     integer(OrderFields[c]) );
                     {$ENDIF}
               end;
      end;

      if coInsertAvailFields in opt then
      begin
         { permite incluir campos que estão apenas nos fields }
         for c:=0 to SqlFields.Count-1 do
            with SqlFields[c] do
            begin
               { só permite incluir campos não ocultos }
               if not (foHiddenFromUser in Options) then
               begin
                  fld := TatSqlOrderField( OrderFields.FindByAlias(FieldAlias) );
                  if not Assigned(fld) or
                     (not (coInsertInactives in opt) and not fld.Active) then
                  begin
                     CheckIncludeMenu(mi, OrderFields);

                     if Assigned(fld) then
                        AddMenuItem(
                           FindTableMenuItem(mi,fld),
                           GetOrderFieldCaption(fld),
                           IncludeItemClick,
                           {$IFDEF TMSDOTNET}
                           Variant(fld))
                           {$ELSE}
                           integer(fld) )
                           {$ENDIF}
                     else
                        AddMenuItem(
                           FindTableMenuItem(mi,SqlFields[c]),
                           SqlFields[c].Displaylabel,
                           IncludeItemClick,
                           {$IFDEF TMSDOTNET}
                           Variant(SqlFields[c]));
                           {$ELSE}
                           integer(SqlFields[c]));
                           {$ENDIF}
                  end;
               end;
            end;
      end;

      { permite incluir campo de ordenação com assistente }
      if coInsertCustom in opt then
         CheckIncludeMenu(mi, OrderFields);
   end;
end;

procedure TatVisualQuery.PrepareParamItemsMenu;
var opt : TClauseOptions;
    c   : integer;
    mi  : TMenuItem;
begin
   with MetaSqlDef do
   begin
      { verifica se permite incluir tabelas inativas }
      opt := FParamsOptions;
      mi := nil;

      if coInsertInactives in opt then
      begin
         { permite incluir parâmetros inativos (reativando-as) }
         for c:=0 to ParamDefs.Count-1 do
            with ParamDefs[c] do
               if not Active then
               begin
                  CheckIncludeMenu(mi, ParamDefs);

                  AddMenuItem(
                     mi,
                     ParamDefs[c].Caption,
                     IncludeItemClick,
                     {$IFDEF TMSDOTNET}
                     Variant(ParamDefs[c]));
                     {$ELSE}
                     integer(ParamDefs[c]) );
                     {$ENDIF}
               end;
      end;

      { permite incluir parâmetro com assistente }
      if coInsertCustom in opt then
      begin
         CheckIncludeMenu(mi, ParamDefs);
         AddMenuItem( mi, _str(SFreeTypingEditor), IncludeItemClick );
         AddMenuItem( mi, _str(SAutomaticListEditor), IncludeItemClick );
         AddMenuItem( mi, _str(SQueryListEditor), IncludeItemClick );
         AddMenuItem( mi, _str(SChooseListEditor), IncludeItemClick );
         AddMenuItem( mi, _str(SCheckListEditor), IncludeItemClick );
      end;
   end;
end;

procedure TatVisualQuery.PrepareItemMenu;
begin
end;

procedure TatVisualQuery.OpenQueryItemClick(Sender:TObject);
begin
  { carrega a consulta selecionada }
  with TMenuItem(Sender) do
    if MetaSqlDef <> TatMetaSqlDef(Tag) then
    begin
       MetaSqlDef := TatMetaSqlDef(Tag);
//     UpdateCurrentQuery;
     end;
end;

procedure TatVisualQuery.NewQueryItemClick(Sender:TObject);
var
  i: integer;
  c: integer;
  title: string;
begin
  if Assigned(MetaSqlDef) then
  begin
    title := _str(SNewVisualQueryTitle);
    c := 0;
    while (FMetaSqlDefs.IndexOf(title) > -1) do
    begin
      inc(c);
      title := Format('%s (%d)',[_str(SNewVisualQueryTitle), c]);
    end;
    i := FMetaSqlDefs.Add.Index;
    FMetaSqlDefs[i].Title := title;
    { torna a nova consulta a atual e recarrega as definições }
    MetaSqlDef := FMetaSqlDefs[i];
  end;
end;

procedure TatVisualQuery.SaveQueryItemClick(Sender:TObject);
var title : string;
    i     : integer;
begin
  if Assigned(MetaSqlDef) then
  begin
    title := MetaSqlDef.Title;
    if InputQuery(_str(SSaveCurrentQuery), _str(SQueryTitle), title ) then
    begin
      { verifica se a consulta com o título dado já existe }
      i := FMetaSqlDefs.IndexOf(title);
      if (i>-1) then
        { se o título é o mesmo de uma consulta diferente da atual
          então confirma para sobrescrever }
        if (FMetaSqlDefs[i] <> MetaSqlDef) and
          (MessageDlg(Format(_str(SQueryAlreadyExists),[title]),
            mtConfirmation,[mbYes,mbCancel],0)<>mrYes) then
          Abort
        else
      else
        i := FMetaSqlDefs.Add.Index;

      if FMetaSqlDefs[i] <> MetaSqlDef then
      begin
        { copia todas as definições da consulta atual para a consulta
          relativa a posição i determinada pelo título da consulta }
        FMetaSqlDefs[i].Assign(MetaSqlDef);
        FMetaSqlDefs[i].Title := title;

        { torna a nova consulta a atual e recarrega as definições }
        MetaSqlDef := FMetaSqlDefs[i];
//      UpdateCurrentQuery(false);
      end;
    end;
  end;
end;

procedure TatVisualQuery.DeleteQueryItemClick(Sender:TObject);
begin
  if Assigned(MetaSqlDef) then
  begin
    if MessageDlg(Format(_str(SConfirmExcludeAllDefinitions),[MetaSqlDef.Title]),
       mtConfirmation,[mbYes,mbCancel],0)=mrYes then
    begin
      MetaSqlDef.Free;

      { define outra consulta como corrente e carrega suas definições }
      if FMetaSqlDefs.Count > 0 then
        MetaSqlDef := FMetaSqlDefs[0]
      else
        MetaSqlDef := FMetaSQLDefs.Add;
//    UpdateCurrentQuery;
    end;
  end;
end;

procedure TatVisualQuery.SetMetaSqlDefs(const Value: TatMetaSqlDefs);
begin
  FMetaSqlDefs.Assign(Value);
end;

procedure TatMetaSqlDef.SetParamDefs(const Value: TatParamDefs);
begin
  FParamDefs.Assign(Value);
end;

function TatMetaSqlDef.IsStoredMetaSql: Boolean;
begin
  result := True;
end;

function TatMetaSqlDef.HasParamDefs: Boolean;
begin
  result := FParamDefs.Count>0;
end;

function TatMetaSqlDef.AllowSetup: boolean;
begin
  with VisualQuery do
    result := (coVisible in FTablesOptions) or
              (coVisible in FFieldsOptions) or
              (coVisible in FConditionsOptions) or
              (coVisible in FGroupingOptions) or
              (coVisible in FOrderingOptions) or
              (coVisible in FParamsOptions);
end;

function TatMetaSqlDef.GetMetaSQLName: string;
begin
  if (FMetaSQL <> nil) then
    result := FMetaSQL.Name
  else
    result := _str(SEmpty);
end;

procedure TatMetaSqlDef.SetMetaSQLName(const Value: string);
begin
  FTempMetaSQLName := Value;
  if (VisualQuery <> nil) and not VisualQuery.IsLoading then
    ResolveMetaSQLReference;
end;

procedure TatMetaSQLDef.ResolveMetaSQLReference;
begin
  if FTempMetaSQLName = _str(SEmpty) then
    FMetaSQL := nil
  else
  begin
    if (VisualQuery <> nil) and (FTempMetaSQLName <> '') then
    begin
      FMetaSQL := TatInternalMetaSQL(VisualQuery.FindComponent(FTempMetaSQLName));
      if (FMetaSQL = nil) and (VisualQuery.FContainer <> nil) then
        FMetaSQL := TatInternalMetaSQL(VisualQuery.FContainer.FindComponent(FTempMetaSQLName))
      else
    end;
  end;
end;

{ TatVisualQuery }

constructor TatVisualQuery.Create(AOwner: TComponent);
begin
  inherited;
  FSyntaxConf := TSQLSyntaxConf.Create;
  FSyntaxConf.OnChange := SyntaxConfChanged;

  {$IFDEF TMSDOTNET}
  FAKE_OBJECT_INSERTION := TObject.Create;
  {$ENDIF}
  FTableNames := TStringList.Create;
  ControlStyle := ControlStyle + [csDesignInteractive] - [csAcceptsControls];

  FMetaSqlDefs := TatMetaSqlDefs.Create(Self,TatMetaSqlDef);
  FFieldAliasSeparator := '_'; {default}

  { set default properties }
  FTablesOptions         := coDefaultClauseOptions;
  FFieldsOptions         := coDefaultClauseOptions;
  FConditionsOptions     := coDefaultClauseOptions;
  FGroupingOptions       := coDefaultClauseOptions;
  FOrderingOptions       := coDefaultClauseOptions;
  FParamsOptions         := coDefaultClauseOptions;
  FSelectionColor        := clHighlight;
  FSelectionFontColor    := clHighlightText;
  FItemHeight            := 20;

  FEditorColor           := clWindow;
  BevelOuter             := bvNone;
  BorderStyle            := bsSingle;
  Color                  := clWindow;
  Caption                := '';
  Width                  := 400;
  Height                 := 200;
  FResizeHeight          := Height;
  FAutoAdjustHeight      := False;
  FAutoGrouping          := True;
  FAutoQueryOpen         := True;
  FShowQueryTitle        := True;
  FEditQueryTitle        := True;
  FParamEditorsReadOnly  := False;
  FShowParamEditors      := True;
end;

procedure TatVisualQuery.CreateEmbeddedComponents;
begin
  FIgnoreVisualAdjustments := True;
  try
    { create embedded components }
    FRefreshTimer := TTimer.Create(Self);
    with FRefreshTimer do
    begin
      Enabled := False;
      Interval := 1500;
      OnTimer := FRefreshTimerTimer;
    end;

    FTreeViewPanel := TPanel.Create(Self);
    with FTreeViewPanel do
    begin
      ControlStyle := ControlStyle - [csAcceptsControls];
      Parent := Self;
      Align := alTop;
      BevelOuter := bvNone;
      BorderWidth := 5;
      ParentColor := True;
      Caption := '';
    end;

    {$R VisualQuery.res} // treeview glyphs for visual querying
    FImageList := TImageList.Create(Self);
    FImageList.ResourceLoad(rtBitmap,'VisualQuery',clFuchsia);
//  FImageList.BlendColor := clWindow;
    FImageList.DrawingStyle := dsTransparent;

    FPopupMenu := TPopupMenu.Create(Self);
    with FPopupMenu do
    begin
      AutoHotkeys := maManual;
      OnPopup := FPopupMenuPopup;
    end;

    FTreeView := TatParamTreeView.Create(Self);

    with FTreeView do
    begin
      Parent := FTreeViewPanel;
      Align := alTop;
      AutoExpand := False;
      BorderStyle := bsNone;
      DragMode := dmAutomatic;
  //  HideSelection := False;
  //  HotTrack := True;
      StateImages := FImageList;
      ParentColor := True;
      ParentFont := True;
      PopupMenu := FPopupMenu;
      RightClickSelect := True;

//    ShowButtons := True;
//    ShowLines := True;

      ShowButtons := False;
      ShowLines := False;

//    ChangeDelay := 10;
      OnCollapsed := TreeViewArrangement;
      OnExpanded := TreeViewUpdateImage;
      OnMouseDown := TreeViewMouseDown; // OnClick
      OnDblClick := TreeViewDblClick;
      OnDragDrop := FTreeViewDragDrop;
      OnDragOver := FTreeViewDragOver;
      OnEdited := FTreeViewEdited;
      OnEditing := FTreeViewEditing;
      OnExpanded := TreeViewArrangement;
      OnKeyDown := FTreeViewKeyDown;

      HtmlImages := FImageList;
      SelectionColor := FSelectionColor;
      ItemHeight := FItemHeight;
      SelectionFontColor := FSelectionFontColor;
      ShowSelection := True;
      Hover := False;
      OnParamPopup := TreeViewHtmlParamPopup;
      OnParamChanged := TreeViewHtmlParamChanged;
      OnParamEditStart := TreeViewHtmlParamEditing;
      OnParamEditDone := TreeViewHtmlParamEdited;
      OnParamEnter := TreeViewHtmlParamEnter;
      OnParamExit := TreeViewHtmlParamExit;
      Indent := 16;

//    HandleNeeded;
    end;

    FParamPanel := TPanel.Create(Self);
    with FParamPanel do
    begin
      ControlStyle := ControlStyle - [csAcceptsControls];
      Parent := Self;
      Align := alTop;
      BevelOuter := bvNone;
      ParentCtl3D := True;
      ParentColor := True;
      Caption := '';

      { garante a alocação do Handle do FParamPanel porque ele vai ser usado como
        container de outros controles que serão criados em breve }
//    HandleNeeded;
    end;

  finally
    FIgnoreVisualAdjustments := False;
  end;
end;

destructor TatVisualQuery.Destroy;
begin
  FMetaSqlDefs.Free;
  FTableNames.Free;
  {$IFDEF TMSDOTNET}
  FAKE_OBJECT_INSERTION.Free;
  {$ENDIF}
  inherited;
end;

function TatVisualQuery.GetColor: TColor;
begin
  result := inherited Color;
end;

procedure TatVisualQuery.SetColor(const Value: TColor);
begin
  if inherited Color <> Value then
  begin
    inherited Color := Value;
    { atualiza todos os parâmetros da consulta para atualizar a cor dos editores }
    if not (csLoading in ComponentState) and HandleAllocated and Showing then
      UpdateMetaSqlParams;
  end;
end;

procedure TatVisualQuery.GetChildren(Proc: TGetChildProc; Root: TComponent);
var metasql   : TatMetaSql;
    c, c1     : integer;
    container : TatVisualQuery;
begin
  container := TatVisualQuery(MetaSqlDefs.GetOwner);
  { assume as child meta-sql all internal stored meta-sqls }
  with MetaSqlDefs do
    for c:=0 to Count-1 do
    begin
      { meta-sql from defs }
      if (Items[c].IsStoredMetaSql) then
      begin
        metasql := Items[c].MetaSql;
        if Assigned(metasql) and (metasql.Owner = container) and (metasql.Name>'') then
          Proc(metasql);
      end;
      { meta-sql from params }
      with Items[c].ParamDefs do
        for c1:=0 to Count-1 do
        begin
          if Items[c1].IsStoredMetaSql then
          begin
            metasql := Items[c1].MetaSql;
            if Assigned(metasql) and (metasql.Owner = container) and (metasql.Name>'') then
              Proc(metasql);
          end;
        end;
    end;
end;

function TatVisualQuery.GetUniqueMetaSqlName: string;
var
  i,c: integer;
begin
  c := 0;
  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TatMetaSql) and (Components[c].Name>'') then
      Inc(c);
  { results an exclusive name to MetaSql subcomponent - for streamming purposes }
  repeat
    Inc(c);
    result := 'MetaSql'+IntToStr(c);
  until FindComponent(result) = nil;
end;

function TatVisualQuery.HasMetaSqlDefs: Boolean;
begin
  result := FMetaSqlDefs.Count>0;
end;

procedure TatVisualQuery.CreateWnd;
begin
  inherited;
  { prepare the first component appearance }
  if not Assigned(FTreeView) then
  begin
    CreateEmbeddedComponents;
    UpdateCurrentQuery;
  end;
end;

procedure TatVisualQuery.SetName(const Value: TComponentName);
begin
  inherited;
  Caption := '';
end;

procedure TatVisualQuery.Loaded;
{$IFDEF TRIAL}
var
  msg: string;
  i: integer;
{$ENDIF}
begin
  inherited;

  {$IFDEF TRIAL}
  msg := 'Qtuyeurhyg xSctvubdnihoj htyrtigaflr evdesrwsqiaosnx.z sPduerrcfhtagshey '+
    'urjekgiiosltpeoriejdu hvnebrgsfivocnd fartt yhuthtypg:t/f/rwdwewd.stwmesdsrotfftgwyahruej.uchotmf.';
  i := 2;
  while i < length(msg) do
  begin
    System.Delete(msg, i, 1);
    inc(i);
  end;
  ShowMessage(msg);
  {$ENDIF}

  ResolveMetaSQLReferences;

  { sempre carrega na altura limite
    (para evitar que a altura limite se ajusta a altura inicial) }
  Height := ResizeHeight;

  { force each MetaSqlDef's property update }
  QualifiedFieldAliases := FQualifiedFieldAliases;
  FieldAliasSeparator := FFieldAliasSeparator;

  { ao concluir alterações na coleção de definições,
    deve verificar se é necessário e se pode criar editores de parâmetros.
    Especialmente útil para cópia de componentes através do streaming ou
    através de Assign }
  if HandleAllocated and Showing then
    UpdateCurrentQuery;
end;

procedure TatVisualQuery.UpdateMetaSql;
begin
  { atualiza a meta-sql principal com base na consulta atual em edição }
  FMetaSql.Assign( MetaSqlDef.VisualQuery.MetaSqlDef.MetaSql );
end;

function TatVisualQuery.GetQueryEditor: TForm;
begin
  if not Assigned(FQueryEditor) then
    FQueryEditor := TfmQueryEditor.Create(Self);
  result := FQueryEditor;
end;

procedure TatVisualQuery.Assign(ASource: TPersistent);
begin
  if ASource is ClassType then
  begin
    Database := TatVisualQuery(ASource).Database;
    (*
      (c) tenho que separar o Assign em cópia completa e copia parcial (somente das consultas)
      como já estou usando o Assign internamente, vou considerar que ele copia apenas as consultas

    FTablesOptions     := TatVisualQuery(ASource).FTablesOptions;
    FFieldsOptions     := TatVisualQuery(ASource).FFieldsOptions;
    FConditionsOptions := TatVisualQuery(ASource).FConditionsOptions;
    FGroupingOptions   := TatVisualQuery(ASource).FGroupingOptions;
    FOrderingOptions   := TatVisualQuery(ASource).FOrderingOptions;
    FParamsOptions     := TatVisualQuery(ASource).FParamsOptions;
    *)
    MetaSqlDef         := nil;
    MetaSqlDefs        := TatVisualQuery(ASource).MetaSqlDefs;

//  TargetMetaSql      := TatVisualQuery(ASource).TargetMetaSql;
//  TargetDataset      := TatVisualQuery(ASource).TargetDataset;
  end
  else
    inherited;
end;

procedure TatVisualQuery.SetTargetDataset(const Value: TDataset);
begin
  FTargetDataset := Value;
end;

procedure TatVisualQuery.FullExpand;
begin
  { expande toda a visualização da query no treeview }
  FIgnoreTreeViewArrangement := True;
  try
    if FTreeView <> nil then
      with FTreeView do
        if Items.Count>0 then
          Items[0].Expand(False);
  finally
    FIgnoreTreeViewArrangement := False;
  end;
  AdjustVisualQueryPanel;
end;

procedure TatVisualQuery.SetAutoGrouping(const Value: boolean);
begin
  if FAutoGrouping <> Value then
  begin
    FAutoGrouping := Value;
    if FAutoGrouping then
      UpdateMetaSqlGrouping;
  end;
end;

procedure TatVisualQuery.SetAutoQueryOpen(const Value: boolean);
begin
  if FAutoQueryOpen <> Value then
  begin
    FAutoQueryOpen := Value;
    if FAutoQueryOpen then
      RefreshDataset;
  end;
end;

procedure TatVisualQuery.SetConditionsOptions(const Value: TClauseOptions);
begin
  if FConditionsOptions <> Value then
  begin
    FConditionsOptions := Value;
    VisualUpdate;
  end;
end;

procedure TatVisualQuery.SetFieldsOptions(const Value: TClauseOptions);
begin
  if FFieldsOptions <> Value then
  begin
    FFieldsOptions := Value;
    VisualUpdate;
  end;
end;

procedure TatVisualQuery.SetGroupingOptions(const Value: TClauseOptions);
begin
  if FGroupingOptions <> Value then
  begin
    FGroupingOptions := Value;
    VisualUpdate;
  end;
end;

procedure TatVisualQuery.SetOrderingOptions(const Value: TClauseOptions);
begin
  if FOrderingOptions <> Value then
  begin
    FOrderingOptions := Value;
    VisualUpdate;
  end;
end;

procedure TatVisualQuery.SetParamsOptions(const Value: TClauseOptions);
begin
  if FParamsOptions <> Value then
  begin
    FParamsOptions := Value;
    VisualUpdate;
  end;
end;

procedure TatVisualQuery.SetTablesOptions(const Value: TClauseOptions);
begin
  if FTablesOptions <> Value then
  begin
    FTablesOptions := Value;
    VisualUpdate;
  end;
end;

procedure TatVisualQuery.VisualUpdate;
begin
  { redesenha o visual-query ao mudar alguma opção do componente }
  if not (csLoading in ComponentState) and HandleAllocated and Showing and not FIgnoreVisualAdjustments then
    UpdateCurrentQuery( False );
end;

procedure TatVisualQuery.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  { delete references to removed components }
  if (Operation = opRemove) then
    if (AComponent = FTargetDataset) then
      FTargetDataset := nil
    else
      if (AComponent = FMetaSql) then
        FMetaSql := nil
      else
        if (AComponent = FDatabase) then
          FDatabase := nil;
end;

procedure TatVisualQuery.SetEditorColor(const Value: TColor);
begin
  if FEditorColor <> Value then
  begin
    FEditorColor := Value;
    { atualiza todos os parâmetros da consulta para atualizar a cor dos editores }
    if not (csLoading in ComponentState) and HandleAllocated and Showing then
      UpdateMetaSqlParams;
  end;
end;

function TatVisualQuery.TargetDatasetSql: string;
begin
  result := ReadSQLProperty(FTargetDataset, FDatabase);
end;

procedure TatVisualQuery.ParamEditorsActivation( AEnable: boolean );
var c: integer;
begin
  with MetaSqlDef.ParamDefs do
    for c:=0 to Count-1 do
      Items[c].Active := AEnable;
end;

procedure TatVisualQuery.ImportDatafieldsDisplaylabels(ADataset : TDataset);
var
  NeedsCustomization : Boolean;
  i : Integer;
  SQLField : TatSQLField;
begin
   { customize datafield's displaylabels }
   with MetaSqlDef.MetaSql do
   begin
      { ascertain it's needed }
      NeedsCustomization := FALSE;
      for i := 0 to ADataset.fields.count-1 do
         if comparetext(ADataset.fields[i].DisplayLabel,ADataset.fields[i].FieldName) <> 0 then
            NeedsCustomization := TRUE;
      if NeedsCustomization then
        { doit, set datafield[i]'s displaylabel }
         for i := 0 to ADataset.fields.count-1 do
         begin
            SQLField := SQLFields.FindByAlias(ADataset.fields[i].fieldname);
            { reacheable? }
            if assigned(SQLField) then
               SQLField.DisplayLabel := ADataset.fields[i].DisplayLabel
            else
            begin
               { define datafields }
               SQLField := SQLFields.Add;
               //SQLField.TableAlias := {?}ADataset.fields[i].fieldname;
               SQLField.fieldname := ADataset.fields[i].fieldname;
               SQLField.ChangeExclusiveFieldAlias(ADataset.fields[i].FieldName);
               SQLField.DisplayLabel := ADataset.fields[i].DisplayLabel;
               SQLField.DataType := ADataset.fields[i].datatype;
            end
         end;
   end;
end;

procedure TatVisualQuery.ImportFromTargetDataset;
begin
  if Assigned(TargetDataset) then
  begin
    SQLStringToMetaSQL( TargetDatasetSql, MetaSqlDef.MetaSql);
    { import datafield's display labels }
    ImportDatafieldsDisplaylabels(TargetDataset);

    { desativa todos os editores de parâmetros porque podem não ser mais válidos }
    ParamEditorsActivation( False );
    { apresenta a consulta importada }
    UpdateCurrentQuery( True );
  end
  else
    raise Exception.Create(_str(SYouMustSpecifyTargetDataset));
end;

procedure TatVisualQuery.ImportFromTargetMetaSql;
begin
  if Assigned(TargetMetaSql) then
  begin
    MetaSqlDef.MetaSql.Assign( TargetMetaSql );
    { desativa todos os editores de parâmetros porque podem não ser mais válidos }
    ParamEditorsActivation( False );
    { apresenta a consulta importada }
    UpdateCurrentQuery( True );
  end
  else
    raise Exception.Create(_str(SYouMustSpecifyTargetMetaSQL));
end;

procedure TatVisualQuery.SetShowQueryTitle(const Value: boolean);
begin
  if FShowQueryTitle <> Value then
  begin
    FShowQueryTitle := Value;
    { atualiza as propriedades visuais do componente }
    VisualUpdate;
  end;
end;

procedure TatVisualQuery.BeginUpdate;
begin
  if FUpdateCount = 0 then
    FIgnoreVisualAdjustments := True;
  Inc( FUpdateCount );
end;

procedure TatVisualQuery.EndUpdate;
begin
  Dec( FUpdateCount );
  if FUpdateCount = 0 then
  begin
    FIgnoreVisualAdjustments := False;
    VisualUpdate;
  end;
end;

procedure TatVisualQuery.SetEditQueryTitle(const Value: boolean);
begin
  if FEditQueryTitle <> Value then
  begin
    FEditQueryTitle := Value;
    { atualiza as propriedades visuais do componente }
    VisualUpdate;
  end;
end;

procedure TatVisualQuery.SetParamEditorsReadOnly(const Value: boolean);
begin
  if FParamEditorsReadOnly <> Value then
  begin
    FParamEditorsReadOnly := Value;
    { atualiza as propriedades dos editores }
    AdjustParamEditors;
  end;
end;

procedure TatVisualQuery.SetShowParamEditors(const Value: boolean);
begin
  if FShowParamEditors <> Value then
  begin
    FShowParamEditors := Value;
    { atualiza as propriedades dos editores }
    AdjustParamEditors;
  end;
end;

procedure TatVisualQuery.SetMetaSqlDef(const Value: TatMetaSqlDef);
begin
  if FMetaSqlDef <> Value then
  begin
    FMetaSqlDef := Value;

    { apresenta a consulta corrente }
    if Assigned(FMetaSqlDef) then
      UpdateCurrentQuery;
  end;
end;

procedure TatVisualQuery.ResolveMetaSQLReferences;
var
  c: integer;
begin
  for c := 0 to MetaSQLDefs.Count - 1 do
    MetaSQLDefs[c].ResolveMetaSQLReference;
end;

procedure TatVisualQuery.LoadQueriesFromFile(AFileName: string);
var
  fileStream: TFileStream;
begin
  fileStream := TFileStream.Create(AFileName,fmOpenRead);
  try
    LoadQueriesFromStream(fileStream);
  finally
    fileStream.Free;
  end;
end;

procedure TatVisualQuery.SaveQueriesToFile(AFileName: string);
var
  fileStream: TFileStream;
begin
 fileStream := TFileStream.Create(AFileName,fmCreate);
 try
   SaveQueriesToStream(fileStream);
 finally
   fileStream.Free;
 end;
end;

procedure TatVisualQuery.LoadQueriesFromStream(AStream: TStream);
var originalOwner : TComponent;
    originalName : string;
begin
  BeginUpdate;

  { preserva o owner e o nome do visual query porque vai modificá-lo temporariamente }
  originalOwner := GetOwner as TComponent;
  originalName := Name;

  { cria um container temporário para a recuperação das consultas }
  if Assigned(FContainer) then FContainer.Free;
  FContainer := TatQueryDefContainer.Create(originalOwner);
  FContainer.FVisualQuery := Self;
  try
    { modifica o nome e o owner do VisualQuery temporariamente,
      para que o streaming resolva referências entre os componentes gravados }
    Name := 'Owner';
    originalOwner.RemoveComponent( Self );
    FContainer.InsertComponent( Self );

    { lê as consultas do VisualQuery como se elas estivessem agregadas ao container }
    //MetaSqlDefs.Clear;
    //MetaSqlDef := nil;
    ReadComponentResStreamText(AStream, FContainer );
  finally
    { restaura nome e owner originais do VisualQuery }
    FContainer.RemoveComponent( Self );
    originalOwner.InsertComponent( Self );
    ResolveMetaSQLReferences;
    Name := originalName;

    FreeAndNil(FContainer);
    EndUpdate;
    UpdateCurrentQuery;
  end;
end;

procedure TatVisualQuery.SaveQueriesToStream(AStream: TStream);
var originalName : string;
begin
  { preserva o nome do VisualQuery porque vai modificá-lo temporariamente }
  originalName := Name;

  if Assigned(FContainer) then FContainer.Free;
  FContainer := TatQueryDefContainer.Create(Self);
  FContainer.FVisualQuery := Self;
  try
    { modifica o nome do VisualQuery temporariamente,
      para que o streaming mantenha referências corretas entre os componentes gravados }
    Name := 'Owner'; { root name }

    { grava as consultas do VisualQuery em formato texto (tipo DFM)
      como se elas fossem agregadas ao container }
    WriteComponentResStreamText(AStream, FContainer);
  finally
    { restaura nome e original do VisualQuery }
    Name := originalName;

    FreeAndNil(FContainer);
  end;
end;

procedure TatVisualQuery.ImportQueriesFromFile;
var dialog : TOpenDialog;
begin
  dialog := TOpenDialog.Create(Application);
  with dialog do
  try
    DefaultExt := 'qdf';
    Filter := _str(SQueryDefinitionFile) + ' (*.qdf)|*.qdf|' + _str(SAnyFile) + ' (*.*)|*.*';
    Title := _str(SImportQueriesFromFile);
    Options := [ofPathMustExist, ofFileMustExist, ofEnableSizing];
    if Execute then
      LoadQueriesFromFile( FileName );
  finally
    Free;
  end;
end;

procedure TatVisualQuery.ExportQueriesToFile;
var dialog : TSaveDialog;
begin
  dialog := TSaveDialog.Create(Application);
  with dialog do
  try
    DefaultExt := 'qdf';
    Filter := _str(SQueryDefinitionFile) + ' (*.qdf)|*.qdf|' + _str(SAnyFile) + ' (*.*)|*.*';
    Title := _str(SExportQueriesToFile);
    Options := [ofEnableSizing];
    if Execute then
      SaveQueriesToFile( FileName );
  finally
    Free;
  end;
end;

procedure TatVisualQuery.SetDatabase(const Value: TatDatabase);
begin
  FDatabase := Value;
  ClearDatabaseInfo;
end;

function TatVisualQuery.IsSyntaxConfStored: boolean;
begin
  result := (SQLSyntax = ssCustom);
end;

procedure TatVisualQuery.SetSyntaxConf(Value: TSQLSyntaxConf);
begin
  FSyntaxConf.Assign(Value);
end;

procedure TatVisualQuery.SyntaxConfChanged(Sender: TObject);
var
  c, d: integer;
begin
  for c := 0 to MetaSQLDefs.Count - 1 do
  begin
    {Use FMetaSQL in code below. If using MetaSQL, it will automatically create
     the metasql and a lot of errors may raise - mostly errors like "a component
     name already exists"}
    if MetaSQLDefs[c].FMetaSQL <> nil then
      MetaSQLDefs[c].FMetaSQL.SyntaxConf := FSyntaxConf;

    for d := 0 to MetaSQLDefs[c].ParamDefs.Count - 1 do
      if MetaSQLDefs[c].ParamDefs[d].Metasql.SyntaxConf <> nil then
        MetaSQLDefs[c].ParamDefs[d].MetaSql.SyntaxConf := SyntaxConf;
  end;
end;

procedure TatVisualQuery.SetSQLSyntax(const Value: TatSQLSyntax);
var
  c, d: integer;
begin
  if FSQLSyntax <> Value then
  begin
    FSQLSyntax := Value;
    SyntaxConf.LoadPredefinedSyntax(FSQLSyntax); 
    //FDisablePrettyText := FSQLSyntax in [ssInterbase];
    for c := 0 to MetaSQLDefs.Count - 1 do
    begin
      {Use FMetaSQL in code below. If using MetaSQL, it will automatically create
       the metasql and a lot of errors may raise - mostly errors like "a component
       name already exists"}
      if MetaSQLDefs[c].FMetaSQL <> nil then
        MetaSQLDefs[c].FMetaSQL.SQLSyntax := FSQLSyntax;

      for d := 0 to MetaSQLDefs[c].ParamDefs.Count - 1 do
        if MetaSQLDefs[c].ParamDefs[d].MetaSql <> nil then
          MetaSQLDefs[c].ParamDefs[d].MetaSql.SQLSyntax := FSQLSyntax;
    end;
  end;
end;

function TatVisualQuery.GetSelectionColor: TColor;
begin
  result := FSelectionColor;
end;

procedure TatVisualQuery.SetSelectionColor(const Value: TColor);
begin
  FSelectionColor := Value;
  if FTreeView <> nil then
    FTreeView.SelectionColor := FSelectionColor;
end;

function TatVisualQuery.GetSelectionFontColor: TColor;
begin
  result := FSelectionFontColor;
end;

procedure TatVisualQuery.SetSelectionFontColor(const Value: TColor);
begin
  FSelectionFontColor := Value;
  if FTreeView <> nil then
    FTreeView.SelectionFontColor := FSelectionFontColor;
end;

function TatVisualQuery.GetItemHeight: integer;
begin
  result := FItemHeight;
end;

procedure TatVisualQuery.SetItemHeight(const Value: integer);
begin
  FItemHeight := Value;
  if FTreeView <> nil then
    FTreeView.ItemHeight := FItemHeight;
end;

procedure TatVisualQuery.SetDisablePrettyText(const Value: Boolean);
begin
  FDisablePrettyText := Value;
end;

procedure TatVisualQuery.SetQualifiedFieldAliases(const Value: Boolean);
var
  c, d: Integer;
begin
  FQualifiedFieldAliases := Value;
  if not (csLoading in ComponentState) then
    for c := 0 to MetaSQLDefs.Count - 1 do
    begin
      if MetaSQLDefs[c].MetaSQL <> nil then
         MetaSQLDefs[c].MetaSQL.QualifiedFieldAliases := FQualifiedFieldAliases;
      for d := 0 to MetaSQLDefs[c].ParamDefs.Count - 1 do
        if MetaSQLDefs[c].ParamDefs[d].MetaSql <> nil then
          MetaSQLDefs[c].ParamDefs[d].MetaSql.QualifiedFieldAliases := FQualifiedFieldAliases;
    end;
end;

procedure TatVisualQuery.SetFieldAliasSeparator(const Value: String);
var
  c, d: Integer;
begin
  FFieldAliasSeparator := Value;
  if not (csLoading in ComponentState) then
    for c := 0 to MetaSQLDefs.Count - 1 do
    begin
      if MetaSQLDefs[c].MetaSQL <> nil then
         MetaSQLDefs[c].MetaSQL.FieldAliasSeparator := FFieldAliasSeparator;
      for d := 0 to MetaSQLDefs[c].ParamDefs.Count - 1 do
        if MetaSQLDefs[c].ParamDefs[d].MetaSql <> nil then
          MetaSQLDefs[c].ParamDefs[d].MetaSql.FieldAliasSeparator := FFieldAliasSeparator;
    end;
end;

procedure TatVisualQuery.ClearDatabaseInfo;
begin
  FTableNames.Clear;
end;

procedure TatVisualQuery.UpdateFieldType(AField: TatSQLField);
var
  AFields: TStrings;
begin
  AFields := TStringList.Create;
  try
    if AField.Table <> nil then
    begin
      LoadFieldNameList(AField.Table.TableName, AFields);
      if AFields.IndexOf(AField.FieldName) > - 1 then
        AField.DataType := TFieldType(Integer(AFields.Objects[
          AFields.IndexOf(AField.FieldName)]));
    end;
  finally
    AFields.Free;
  end;
end;

procedure TatVisualQuery.TableAliasChanged(ATable: TatSQLTable; ANewAlias: string);
var
  c: integer;
  Prefix: string;
  AField: TatSQLField;
begin
  if QualifiedFieldAliases and AutoUpdateFieldAliases then
  begin
    Prefix := ATable.TableAlias + FieldAliasSeparator;
    for c := 0 to ATable.MetaSQL.SQLFields.Count - 1 do
    begin
      AField := ATable.MetaSQL.SQLFields[c];
      if Pos(Prefix, AField.FieldAlias) = 1 then
      begin
        AField.CascadeChangeFieldAlias(
          ANewAlias + FieldAliasSeparator +
          Copy(AField.FieldAlias, Length(Prefix) + 1, MaxInt));
      end;
    end;
  end;
end;

function TatVisualQuery.IsLoading: boolean;
begin
  result := (csLoading in ComponentState) or
    ((Owner is TatQueryDefContainer) and
     (csLoading in TatQueryDefContainer(Owner).ComponentState)
    );
end;

function TatVisualQuery.GetChildOwner: TComponent;
begin
  result := Self;
end;

{ TatParamDef }

procedure TatParamDef.Assign(Source: TPersistent);
begin
   if Source is TatParamDef then
   begin
      Name      := TatParamDef(Source).Name;
      Caption   := TatParamDef(Source).Caption;
      ParamType := TatParamDef(Source).ParamType;
      DataType  := TatParamDef(Source).DataType;
      ListItems := TatParamDef(Source).ListItems;
      Active    := TatParamDef(Source).Active;
      Value     := TatParamDef(Source).Value;
      Width     := TatParamDef(Source).Width;
      Text      := TatParamDef(Source).Text;
      if TatParamDef(Source).IsStoredMetaSql then
        MetaSql   := TatParamDef(Source).MetaSql;
      if TatParamDef(Source).IsStoredMetaSqlStr then
        MetaSqlStr:= TatParamDef(Source).MetaSqlStr;
   end
   else
      inherited;
end;

constructor TatParamDef.Create(ACollection: TCollection);
begin
   inherited;
   FListItems := TatParamListItems.Create(Self,TatParamListItem);
   DefaultItem; { cria o item default }
   FParamType := ptFreeEdit;
   FDataType := ftString;
   FActive := True;
   FWidth := 80;
   FValue := Null;
end;

destructor TatParamDef.Destroy;
begin
   if Assigned(FEditor) then FEditor.Free;
   if Assigned(FLabel) then FLabel.Free;
   if Assigned(FMetaSql) then FMetaSql.Free;
   if Assigned(FListItems) then FListItems.Free;
   inherited;
end;

function TatParamDef.DefaultItem: TatParamListItem;
begin
  { deixa o primeiro item como item default }
  if FListItems.Count=0 then
    FListItems.Add;
  result := FListItems[0];
end;

function TatParamDef.GetMetaSql: TatMetaSql;
begin
  { se a meta-sql já existe então retorna-a,
    senão cria-a automaticamente dependendo do tipo do parâmetro }
  if Assigned(FMetaSql) then
    result := FMetaSql
  else
    case ParamType of
      ptDistinctList,              
      ptQueryList:
        begin
          FMetaSql := TatInternalMetaSql.Create(VisualQuery);
          FMetaSql.Name := ''; // como não vai entrar no stream, não precisa de um nome
          if (MetaSQLDef <> nil) and (MetaSQLDef.VisualQuery <> nil) then
          begin
            FMetaSQL.QualifiedFieldAliases := MetaSQLDef.VisualQuery.QualifiedFieldAliases;
            FMetaSQL.FieldAliasSeparator := MetaSQLDef.VisualQuery.FieldAliasSeparator;
            FMetaSQL.SyntaxConf := MetaSQLDef.VisualQuery.SyntaxConf;
            FMetaSQL.SQLSyntax := MetaSQLDef.VisualQuery.SQLSyntax;
          end;
          try
            SQLStringToMetaSQL(MetaSqlStr,FMetaSql);
          except
            { mostra mensagem de erro na conversão, mas mata a exceção }
            on ex: Exception do
              Msg(ex.Message);
          end;
          result := FMetaSql;
        end
      else
        result := nil;
    end;
end;

procedure TatParamDef.SetMetaSql(const Value: TatMetaSql);
var root : TComponent;
begin
  { descobre o componente que é a raiz do streaming desta propriedade }
  root := TatMetaSqlDefs(TatMetaSqlDef(TatParamDefs(Collection).GetOwner).Collection).GetOwner as TComponent;
  if Assigned(TatVisualQuery(root).FContainer) then
    root := TatVisualQuery(root).FContainer;

  { if loading component from stream
    then setting acts like referenced object,
    otherwise it atcs like a aggregated object setting }
  if Assigned(FMetaSql) then
    { copy meta-sql content from source }
    FMetaSql.Assign(Value)
  else
    if csLoading in root.ComponentState then
      { just assign the meta-sql reference }
      FMetaSql := Value
    else
      { creates a new MetaSql instance and copies meta-sql content from source }
      if Assigned(MetaSql) then
        MetaSql.Assign(Value);
end;

procedure TatParamDef.SetActive(const Value: boolean);
begin
  FActive := Value;
end;

procedure TatParamDef.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure TatParamDef.SetDataType(const Value: TFieldType);
begin
  FDataType := Value;
end;

procedure TatParamDef.SetListItems(const Value: TatParamListItems);
begin
  FListItems.Assign(Value);
end;

procedure TatParamDef.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TatParamDef.SetParamType(const Value: TatParamType);
begin
  if (FParamType <> Value) then
    FParamType := Value;
end;

function TatParamDef.HasValue: Boolean;
var v: variant;
begin
  v := GetValue;
  result := not VarIsEmpty(v) and not VarIsNull(v);
end;

function TatParamDef.GetValue: variant;
begin
  { read param value from editor }
  if Assigned(FEditor) then
    case ParamType of
      ptFreeEdit:
        begin
          if (FEditor as TMaskEdit).Text > '' then
            result := (FEditor as TMaskEdit).Text
          else
            result := null;
        end;
      ptDistinctList,
      ptQueryList,
      ptChooseList:
        begin
          if TatComboBox(FEditor).KeyValue > -1 then
            result := TatComboBox(FEditor).KeyValue
          else
            result := Null;
        end;
      ptCheckList:
        begin
          if TatCheckListEdit(FEditor).Text > '' then
            result := TatCheckListEdit(FEditor).Text
          else
            result := null;
        end;
    end
  else
    result := null;
end;

function TatParamDef.GetText: string;
begin
  { read param text from editor }
  if Assigned(FEditor) and FEditor.HandleAllocated then
    case ParamType of
      ptDistinctList,
      ptQueryList,
      ptChooseList:
        result := TatComboBox(FEditor).Text;
      else
        result := VarToStr(GetValue);
    end
  else
    result := FText;
end;

procedure TatParamDef.SetValue(const Value: variant);
begin
  { set param value into editor }
  if Assigned(FEditor) and FEditor.HandleAllocated then
    case ParamType of
      ptFreeEdit:
        begin
          if VarIsNull(Value) then
            (FEditor as TMaskEdit).Text := ''
          else
            (FEditor as TMaskEdit).Text := VarToStr(Value);
        end;
      ptDistinctList,
      ptQueryList,
      ptChooseList:
        begin
          TatComboBox(FEditor).KeyValue := Value;
        end;
      ptCheckList:
        begin
          if VarIsNull(Value) then
            TatCheckListEdit(FEditor).Text := ''
          else
            TatCheckListEdit(FEditor).Text := VarToStr(Value);
        end;
    end
  else
    FValue := Value;
end;

procedure TatParamDef.SetText(const Value: string);
begin
  { set param text into editor }
  if Assigned(FEditor) then
    case ParamType of
      ptDistinctList,
      ptQueryList,
      ptChooseList:
        TatComboBox(FEditor).Text := Value;
      else
        SetValue( Value );
    end
  else
    FText := Value;
end;

function TatParamDef.GetMetaSqlStr: string;
begin
  if (FMetaSqlStr='') and (ParamType=ptDistinctList) and
     Assigned(MetaSqlDef.MetaSql) and Assigned(Field) then
    FMetaSqlStr := Format(
      'SELECT DISTINCT %s FROM %s ORDER BY %s',
      [ Field.FieldName,
        Field.Table.TableName,
        Field.FieldName ]);
  result := FMetaSqlStr;
end;

procedure TatParamDef.SetMetaSqlStr(const Value: string);
begin
  FMetaSqlStr := Value;
end;

function TatParamDef.IsStoredMetaSql: Boolean;
begin
  result := False;
end;

function TatParamDef.IsStoredMetaSqlStr: Boolean;
begin
  result := True;
end;

function TatParamDef.GetField: TatSqlField;
begin
  if not Assigned(FField) and Assigned(MetaSqlDef.MetaSql) then
    FField := MetaSqlDef.MetaSql.FindFieldByParamName( Name );
  result := FField;
end;

procedure TatParamDef.SetField(const Value: TatSqlField);
begin
  FField := Value;
end;

function TatParamDef.VisualQuery: TatVisualQuery;
begin
  result := MetaSqlDef.VisualQuery;
end;

function TatParamDef.MetaSqlDef: TatMetaSqlDef;
begin
  result := TatParamDefs(Collection).GetOwner as TatMetaSqlDef;
end;

function TatParamDef.HasListItems: Boolean;
begin
  result := FListItems.Count>0;
end;

procedure TatParamDef.LoadComboItems(Sender: TObject);
var
  SL: TStringList;
  c: integer;
begin
  if Assigned(VisualQuery.FDatabase) then
  begin
    SL := TStringList.Create;
    try
      if ParamType=ptDistinctList then
        { não precisa da meta-sql para montar essa consulta simples }
        VisualQuery.FDatabase.LoadLookupQuery(
          MetaSqlStr, // MetaSqlStr is equal to MetaSql.SQL !!!
          SL )
      else
        VisualQuery.FDatabase.LoadLookupQuery(
          MetaSql.SQL,
          SL );
      {Workaround for VCL bug - remove blank lines}
      c := 0;                                     
      while c < SL.Count do
      begin
        if Trim(SL[c]) = '' then
          SL.Delete(c)
        else
          inc(c);
      end;
      (Sender as TatComboBox).Items.Assign(SL);
    finally
      SL.Free;
    end;
  end;
end;

{ TatParamDefs }

function TatParamDefs.Add: TatParamDef;
begin
   result := TatParamDef( inherited Add );
end;

function TatParamDefs.GetItem(i: integer): TatParamDef;
begin
   result := TatParamDef( inherited Items[i] );
end;

{ TatParamListItems }

function TatParamListItems.Add: TatParamListItem;
begin
   result := TatParamListItem( inherited Add );
end;

function TatParamListItems.GetItem(i: integer): TatParamListItem;
begin
   result := TatParamListItem( inherited Items[i] );
end;

{ TatParamListItem }

procedure TatParamListItem.Assign(Source: TPersistent);
begin
  if Source is TatParamListItem then
  begin
    Text := TatParamListItem(Source).Text;
    ParamValues := TatParamListItem(Source).ParamValues;
  end
  else
    inherited;
end;

constructor TatParamListItem.Create(ACollection: TCollection);
begin
  inherited;
  FParamValues := TatParamValues.Create(Self);
end;

destructor TatParamListItem.Destroy;
begin
  FParamValues.Free;
  inherited;
end;

function TatParamListItem.HasParamValues: Boolean;
begin
  result := FParamValues.Count>0;
end;

procedure TatParamListItem.SetParamValues(const Value: TatParamValues);
begin
  FParamValues.Assign(Value);
end;

procedure TatParamListItem.SetText(const Value: string);
begin
  FText := Value;
end;

{ TatParamValues }

function TatParamValues.Add(S: string): TatParamValue;
begin
  result := TatParamValue(inherited Add);
  result.Text := S;
end;

constructor TatParamValues.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner,TatParamValue);
end;

destructor TatParamValues.Destroy;
begin
  inherited;
end;

function TatParamValues.GetText(i: integer): string;
begin
  result := Items[i].Text;
end;

function TatParamValues.GetName(i: integer): string;
begin
  result := Items[i].Name;
end;

function TatParamValues.GetValues(s: string): string;
var
  I: integer;
begin
  I := IndexOfName(S);
  if I > -1 then
    result := Items[I].Value;
end;

procedure TatParamValues.SetName(i: integer; const Value: string);
begin
  Items[i].Name := Value;
end;

procedure TatParamValues.SetValues(s: string; const Value: string);
var
  I: integer;
begin
  I := IndexOfName(S);
  if I > -1 then
    Items[i].Value := Value;
end;

function TatParamValues.GetItem(i: integer): TatParamValue;
begin
  result := TatParamValue( inherited Items[i] );
end;

procedure TatParamValues.SetText(i: integer; const Value: string);
begin
  Items[i].Text := Value;
end;

function TatParamValues.IndexOfName(const AName: string): integer;
var
  c: integer;
begin
  result := -1;
  for c := 0 to Count - 1 do
    if AnsiCompareText(AName, Items[c].Name) = 0 then
    begin
      result := c;
      break;
    end;
end;

{ TatParamValue }

procedure TatParamValue.Assign(ASource: TPersistent);
begin
  if ASource is TatParamValue then
  begin
    Text := TatParamValue(ASource).Text;
  end
  else
    inherited;
end;

function TatParamValue.GetName: string;
var
  P: Integer;
begin
  Result := FText;
  P := AnsiPos('=', Result);
  if P <> 0 then
    SetLength(Result, P - 1)
  else
    SetLength(Result, 0);
end;

function TatParamValue.GetValue: string;
begin
  Result := Copy(FText, Length(Name) + 2, MaxInt);
end;

function TatParamValue.GetText: string;
begin
  Result := FText;
end;

procedure TatParamValue.SetName(const AValue: string);
begin
  FText := AValue + '=' + Value;
end;

procedure TatParamValue.SetValue(const AValue: string);
begin
  FText := Name + '=' + AValue;
end;

procedure TatParamValue.SetText(const AValue: string);
begin
  FText := AValue;
end;

(*
 Otimização futura:
 LoadTreeView deveria receber flags indicando quais as seções da meta-sql que devem ser reconstruidas
*)

{ TatInternalMetaSql }

(*constructor TatInternalMetaSql.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AOwner is TatVisualQuery then
    SQLSyntax := TatVisualQuery(AOwner).SQLSyntax;
end;*)

function TatInternalMetaSql.GetParentComponent: TComponent;
begin
  result := Owner;
end;

procedure TatInternalMetaSql.SetParentComponent(Value: TComponent);
begin
  { se está tentando colocar o MetaSql dentro de um container
    é porque está utilizando-o em streaming de runtime (LoadQueriesFromFile),
    então assume que o proprietário da MetaSql é o VisualQuery associado ao container }
  if Value is TatQueryDefContainer then
    Value := TatQueryDefContainer(Value).FVisualQuery;

  { allow meta-sql exists as a child of another component (streaming matter) }
  if Value <> Owner then
  begin
     if Owner <> nil then Owner.RemoveComponent(Self);
     if Value <> nil then Value.InsertComponent(Self);
  end;
end;

{ TatQueryDefContainer }

procedure TatQueryDefContainer.GetChildren(Proc: TGetChildProc;Root: TComponent);
var metasql   : TatMetaSql;
    c, c1     : integer;
    container : TatVisualQuery;
begin
  container := TatVisualQuery(MetaSqlDefs.GetOwner);
  { assume as child meta-sql all internal stored meta-sqls }
  with MetaSqlDefs do
    for c:=0 to Count-1 do
    begin
      { meta-sql from defs }
      if (Items[c].IsStoredMetaSql) then
      begin
        metasql := Items[c].MetaSql;
        if Assigned(metasql) and (metasql.Owner = container) and (metasql.Name>'') then
          Proc(metasql);
      end;
      { meta-sql from params }
      with Items[c].ParamDefs do
        for c1:=0 to Count-1 do
        begin
          if Items[c1].IsStoredMetaSql then
          begin
            metasql := Items[c1].MetaSql;
            if Assigned(metasql) and (metasql.Owner = container) and (metasql.Name>'') then
              Proc(metasql);
          end;
        end;
    end;
end;

function TatQueryDefContainer.GetMetaSqlDefs: TatMetaSqlDefs;
begin
  result := FVisualQuery.MetaSqlDefs;
end;

procedure TatQueryDefContainer.SetMetaSqlDefs(const Value: TatMetaSqlDefs);
begin
  FVisualQuery.MetaSqlDefs := Value;
end;

initialization
  RegisterClasses([TatVisualQuery,TatInternalMetaSql]);

end.
