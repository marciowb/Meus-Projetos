{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit daQueryDesigner;

interface

{$I ppIfDef.pas}

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Buttons, ComCtrls, Tabs, Menus,
  ppComm, ppClass, ppWizard, ppTypes, ppUtils, ppDB, ppDsgnDB, ppTreeVw, ppIniStorage,
  daDB, daDataWizard, daQueryDataView, daSQL,

  daSQLEdit,

  ppParameter,
  ppTabbedNoteBook,

  ppTB2Item,
  ppTBX,
  
  ppPopupMenuBase,
  ppToolResources,
  daSQLBuilder;

type

  TdaEditPage = class;
  TdaQueryDesignerForm = class;

  { TdaQueryDesigner }
  TdaQueryDesigner = class(TdaCustomDataWizard)
    private
      FDataView: TdaQueryDataView;
      FForm: TdaQueryDesignerForm;

      procedure CloseQueryEvent(Sender: TObject; var CanClose: Boolean);

    protected
      function GetDataView: TObject; override;
      function GetDataViewName: String; override;

      procedure LoadStateInfo(aIniStorage: TppIniStorage); override;
      procedure SaveStateInfo(aIniStorage: TppIniStorage); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      class function ClassBitmap: THandle; override;
      class function ClassDescription: String; override;
      class function DataViewClass: TdaDataViewClass; override;

      procedure ClearQuery;
      function Execute: Boolean; override;

  end; {class, TdaQueryDesigner}

  { TdaQueryDesignerForm }
  TdaQueryDesignerForm = class(TForm)
    pnlForm: TPanel;
    pnlButtons: TPanel;
    pnlAnchorButtons: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ehNotebook_TabChanged(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    private
      FAllowEditSQL: Boolean;
      FCancelClicked: Boolean;
      FEditMode: TppDataEditType;
      FEditPage: TdaEditPage;
      FEditSQLAsText: Boolean;
      FNotebook: TppTabbedNotebook;
      FOKClicked: Boolean;
      FOnValidateName: TppValidateNameEvent;
      FPages: TList;
      FSQL: TdaSQL;
      FSQLClass: TdaSQLClass;

      procedure ActivatePage;
      procedure DeactivatePage;
      procedure DoOnValidateName(Sender: TObject; const aName: String; var aNameValid: Boolean);
      procedure EditSQLAsTextEvent(Sender: TObject);
      procedure SetSQL(aSQL: TdaSQL);
      procedure SetSQLClass(aSQLClass: TdaSQLClass);

    public
      procedure Initialize;
      procedure SelectPage(aIndex: Integer);
      function Validate: Boolean;

      property AllowEditSQL: Boolean read FAllowEditSQL write FAllowEditSQL;
      property CancelClicked: Boolean read FCancelClicked write FCancelClicked;
      property EditMode: TppDataEditType read FEditMode write FEditMode;
      property EditSQLAsText: Boolean read FEditSQLAsText write FEditSQLAsText;
      property OKClicked: Boolean read FOKClicked write FOKClicked;
      property OnValidateName: TppValidateNameEvent read FOnValidateName write FOnValidateName;
      property Notebook: TppTabbedNotebook read FNotebook;
      property SQL: TdaSQL read FSQL write SetSQL;
      property SQLClass: TdaSQLClass read FSQLClass write SetSQLClass;

  end; {class, TdaQueryDesignerForm}

  { TdaEditPage }
  TdaEditPage = class(TppCommunicator)
    private
      FInitialized: Boolean;
      FNotebook: TppTabbedNotebook;
      FSettingControls: Boolean;
      FSQL: TdaSQL;
      FPage: TPage;
      FSQLOutOfSync: Boolean;
      procedure FreeControls;
      procedure SetSQL(aSQL: TdaSQL);

    protected
      procedure CreateControls; virtual; abstract;
      procedure SQLToControls; virtual; abstract;
      function  OutOfSync: Boolean; virtual; abstract;
      function  ParentForm: TForm;

      property Initialized: Boolean read FInitialized;
      property Notebook: TppTabbedNotebook read FNotebook;
      property Page: TPage read FPage;
      property SettingControls: Boolean read FSettingControls;
      property SQL: TdaSQL read FSQL write SetSQL;
      property SQLOutOfSync: Boolean read FSQLOutOfSync write FSQLOutOfSync;
    public
      constructor CreatePage(aOwner: TComponent; aNotebook: TppTabbedNotebook); virtual;

      procedure Notification(aComponent: TComponent; aOperation: TOperation); override;
      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      class function PageName: String; virtual;

      procedure Activate;
      procedure Deactivate; virtual;
      class function ImageIndex: Integer; virtual;
      procedure Reset;
      function  Valid: Boolean; virtual; abstract;

  end; {class, TdaEditPage}

  { TdaDualListPage }
  TdaDualListPage = class(TdaEditPage)
    private
      FAllowSorting: Boolean;
      FBottomLabel: TLabel;
      FBottomList: TppListView;
      FBottomPanel: TPanel;
      FDeselecting: Boolean;
      FListsCleared: Boolean;
      FMoveUp: TSpeedButton;
      FMoveDown: TSpeedButton;
      FSelecting: Boolean;
      FSelectionList: TList;
      FSortMode: Integer;
      FTopLabel: TLabel;
      FTopList: TppListView;
      FTopPanel: TPanel;
      FMoveSelectedItems: Boolean;

      procedure ItemsToList(aListItems: TListItems; aList: TList);
      procedure DeselectItems(aList: TList);
      procedure Move(aIncrement: Integer);
      procedure SelectItems(aList: TList);
      procedure UpdateMoveButtons;

    protected
      property AllowSorting: Boolean read FAllowSorting write FAllowSorting;
      property BottomLabel: TLabel read FBottomLabel;
      property BottomList: TppListView read FBottomList;
      property BottomPanel: TPanel read FBottomPanel;
      property SortMode: Integer read FSortMode;
      property TopLabel: TLabel read FTopLabel;
      property TopList: TppListView read FTopList;
      property TopPanel: TPanel read FTopPanel;

      procedure CreateControls; override;
      procedure CreateSelectedColumns(aSelectedList: TppListView); virtual;
      function  SelectedReadOnly: Boolean; virtual;
      function  SelectedMultiSelect: Boolean; virtual;
      procedure SQLToControls; override;

      procedure CalcEditControlPosition(aControl: TControl; aItem: TListItem; aFieldPosition: Integer);
      procedure BuildAvailableList;
      procedure BuildSelectedList;
      procedure DeselectAllItems;
      procedure SelectAllItems;

      procedure ChildToAvailableItem(aChild: TdaChild; aItem: TListItem); virtual; abstract;
      procedure ChildToSelectedItem(aChild: TdaChild; aItem: TListItem); virtual; abstract;
      function  DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild; virtual; abstract;
      function  GetAvailableChild(aIndex: Integer): TdaChild; virtual; abstract;
      function  GetAvailableChildCount: Integer; virtual; abstract;
      function  GetChildType: TdaChildType; virtual; abstract;
      function  GetSelectedChild(aIndex: Integer): TdaChild; virtual; abstract;
      function  GetSelectedChildCount: Integer; virtual; abstract;
      procedure DisplayEditControls(aVisibility: Boolean); virtual;
      function  SelectItem(aAvailableIndex: Integer): TdaChild; virtual; abstract;

      procedure AvailableColumnClickEvent(Sender: TObject; Column: TListColumn); virtual;
      procedure AvailableDblClickEvent(Sender: TObject); virtual;
      procedure AvailableDragOverEvent(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean); virtual;
      procedure AvailableDragDropEvent(Sender, Source: TObject; X,Y: Integer); virtual;
      procedure MoveDownClickEvent(Sender: TObject); virtual;
      procedure MoveUpClickEvent(Sender: TObject); virtual;
      procedure SelectedClickEvent(Sender: TObject); virtual;
      procedure SelectedColumnResizeEvent(aListView: TListView; aColumn: TListColumn); virtual;
      procedure SelectedDblClickEvent(Sender: TObject); virtual;
      procedure SelectedDragOverEvent(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean); virtual;
      procedure SelectedDragDropEvent(Sender, Source: TObject; X,Y: Integer); virtual;
      procedure SelectedEditedEvent(Sender: TObject; Item: TListItem; var S: String); virtual;
      procedure SelectedEditingEvent(Sender: TObject; Item: TListItem; var AllowEdit: Boolean); virtual;
      procedure SelectedResizeEvent(Sender: TObject); virtual;
      procedure SelectedScrollEvent(Sender: TObject); virtual;
      procedure SelectedSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean); virtual;

      property Deselecting: Boolean read FDeselecting;
      property MoveSelectedItems: Boolean read FMoveSelectedItems write FMoveSelectedItems;
      property Selecting: Boolean read FSelecting;

    public
      constructor CreatePage(aOwner: TComponent; aNotebook: TppTabbedNotebook); override;
      destructor Destroy; override;

  end; {class, TdaDualListPage}

  { TdaTablePage }
  TdaTablePage = class(TdaDualListPage)
    private
      FAvailableTables: TppListView;
      FSelectedTables: TppListView;
      FcbxDistinct: TCheckBox;
      FspbJoin: TSpeedButton;

      procedure AvailableDrawEnableItemEvent(Sender: TCustomListView; aItem: TListItem; var aEnabled, aBolded: Boolean);
      procedure DistinctClickEvent(Sender: TObject);
      procedure JoinClickEvent(Sender: TObject);

    protected
      procedure CreateControls; override;
      procedure CreateSelectedColumns(aSelectedList: TppListView); override;
      function  OutOfSync: Boolean; override;
      procedure SQLToControls; override;

      procedure SelectedSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean); override;

      {dual list methods}
      procedure ChildToAvailableItem(aChild: TdaChild; aItem: TListItem); override;
      procedure ChildToSelectedItem(aChild: TdaChild; aItem: TListItem); override;
      function  DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild; override;
      function  GetAvailableChild(aIndex: Integer): TdaChild; override;
      function  GetAvailableChildCount: Integer; override;
      function  GetChildType: TdaChildType; override;
      function  GetSelectedChild(aIndex: Integer): TdaChild; override;
      function  GetSelectedChildCount: Integer; override;
      procedure DisplayEditControls(aVisibility: Boolean); override;
      function  SelectItem(aAvailableIndex: Integer): TdaChild; override;

    public
      class function ImageIndex: Integer; override;
      class function PageName: String; override;

      function  Valid: Boolean; override;

  end; {class, TdaTablePage}

  { TdaFieldPage }
  TdaFieldPage = class(TdaDualListPage)
    private
      FAvailableFields: TppListView;
      FSelectedFields: TppListView;

      FcbxAllFields: TCheckBox;
      FlblInvalidExpression: TLabel;

    protected
      function  AliasIsRBAlias(const aAlias: String): Boolean; virtual;
      procedure CreateControls; override;
      procedure CreateSelectedColumns(aSelectedList: TppListView); override;
      function  OutOfSync: Boolean; override;
      function  SelectedReadOnly: Boolean; override;
      procedure ShowInvalidExpressionLabel(aShow: Boolean); virtual;
      procedure SQLToControls; override;

      procedure AvailableColumnClickEvent(Sender: TObject; Column: TListColumn); override;
      procedure SelectedEditedEvent(Sender: TObject; Item: TListItem; var S: String); override;

      {dual list methods}
      procedure ChildToAvailableItem(aChild: TdaChild; aItem: TListItem); override;
      procedure ChildToSelectedItem(aChild: TdaChild; aItem: TListItem); override;
      function  DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild; override;
      function  GetAvailableChild(aIndex: Integer): TdaChild; override;
      function  GetAvailableChildCount: Integer; override;
      function  GetChildType: TdaChildType; override;
      function  GetSelectedChild(aIndex: Integer): TdaChild; override;
      function  GetSelectedChildCount: Integer; override;
      function  SelectItem(aAvailableIndex: Integer): TdaChild; override;

      procedure AllFieldsClickEvent(Sender: TObject); virtual;
      function CreatePopupMenu: TppPopupMenuBase; virtual;
      procedure ehTopList_Compare(Sender: TObject; aItem1, aItem2: TListItem; aData: Integer; var aCompare: Integer); virtual;
      procedure RenamListItemEvent(Sender: TObject); virtual;
      procedure UpdateAvailableColumnCaptions;

      property CheckBox: TCheckBox read FcbxAllFields;

    public
      class function PageName: String; override;

      function  Valid: Boolean; override;

  end; {class, TdaFieldPage}

  { TdaCalcPage }
  TdaCalcPage = class(TdaFieldPage)
    private
      FcbxFunction: TComboBox;
      FResizing: Boolean;


      procedure CalcTypeChangeEvent(Sender: TObject);
    protected
      procedure CreateControls; override;
      procedure CreateSelectedColumns(aSelectedList: TppListView); override;
      function  OutOfSync: Boolean; override;

      procedure SelectedSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean); override;

      {dual list methods}
      procedure ChildToSelectedItem(aChild: TdaChild; aItem: TListItem); override;
      function  DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild; override;
      function  GetAvailableChild(aIndex: Integer): TdaChild; override;
      function  GetAvailableChildCount: Integer; override;
      function  GetChildType: TdaChildType; override;
      function  GetSelectedChild(aIndex: Integer): TdaChild; override;
      function  GetSelectedChildCount: Integer; override;
      procedure DisplayEditControls(aVisibility: Boolean); override;
      function  SelectItem(aAvailableIndex: Integer): TdaChild; override;
      procedure SelectedResizeEvent(Sender: TObject); override;

    public
      class function ImageIndex: Integer; override;
      class function PageName: String; override;

      function  Valid: Boolean; override;

  end; {class, TdaCalcPage}

  { TdaGroupPage }
  TdaGroupPage = class(TdaFieldPage)
    protected
      procedure CreateControls; override;
      function  OutOfSync: Boolean; override;
      function  SelectedReadOnly: Boolean; override;
      procedure SQLToControls; override;

      {dual list methods}
      function  DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild; override;
      function  GetAvailableChild(aIndex: Integer): TdaChild; override;
      function  GetAvailableChildCount: Integer; override;
      function  GetChildType: TdaChildType; override;
      function  GetSelectedChild(aIndex: Integer): TdaChild; override;
      function  GetSelectedChildCount: Integer; override;
      function  SelectItem(aAvailableIndex: Integer): TdaChild; override;

    public
      class function ImageIndex: Integer; override;
      class function PageName: String; override;

      function  Valid: Boolean; override;

  end; {class, TdaGroupPage}

  { TdaSearchPage }
  TdaSearchPage = class(TdaFieldPage)
    private
      FcbxOperator: TComboBox;
      FedtValue: TEdit;
      FcbxAutoSearch: TCheckBox;
      FcbxMandatory: TCheckBox;
      FcbxParameter: TComboBox;
      FcbxShowAll: TCheckBox;
      FResizing: Boolean;

      procedure DisableMandatoryForBlankCriteria;

      procedure OperatorChangeEvent(Sender: TObject);
      procedure ComparisonChangeEvent(Sender: TObject);
      procedure AutoSearchClickEvent(Sender: TObject);
      procedure MandatoryClickEvent(Sender: TObject);
      procedure ParameterChangeEvent(Sender: TObject);
      procedure ShowAllClickEvent(Sender: TObject);

      procedure AddParenthesesClickEvent(Sender: TObject);
      procedure RemoveParenthesesClickEvent(Sender: TObject);
      procedure InsertCriteriaClickEvent(Sender: TObject);
      procedure InsertORClickEvent(Sender: TObject);
      procedure InsertNOTClickEvent(Sender: TObject);
      procedure PopupMenuPopupEvent(Sender: TObject);
      procedure RemoveCriteriaClickEvent(Sender: TObject);

    protected
      procedure CreateControls; override;
      procedure CreateSelectedColumns(aSelectedList: TppListView); override;
      function  OutOfSync: Boolean; override;
      function  SelectedMultiSelect: Boolean; override;
      function  SelectedReadOnly: Boolean; override;

      {event}
      procedure SelectedEditedEvent(Sender: TObject; Item: TListItem; var S: String); override;
      procedure SelectedSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean); override;
      procedure SelectedResizeEvent(Sender: TObject); override;

      {dual list methods}
      procedure ChildToSelectedItem(aChild: TdaChild; aItem: TListItem); override;
      function CreatePopupMenu: TppPopupMenuBase; override;
      function  DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild; override;
      function  GetAvailableChild(aIndex: Integer): TdaChild; override;
      function  GetAvailableChildCount: Integer; override;
      function  GetChildType: TdaChildType; override;
      function  GetSelectedChild(aIndex: Integer): TdaChild; override;
      function  GetSelectedChildCount: Integer; override;
      procedure DisplayEditControls(aVisibility: Boolean); override;
      function  SelectItem(aAvailableIndex: Integer): TdaChild; override;

    public
      class function ImageIndex: Integer; override;
      class function PageName: String; override;

      function  Valid: Boolean; override;

  end; {class, TdaSearchPage}

  { TdaSortPage }
  TdaSortPage = class(TdaFieldPage)
    private
      FcbxDescending: TCheckBox;
      FResizing: Boolean;

      procedure DescendingClickEvent(Sender: TObject);

    protected
      procedure CreateControls; override;
      procedure CreateSelectedColumns(aSelectedList: TppListView); override;
      function  OutOfSync: Boolean; override;
      function  SelectedReadOnly: Boolean; override;
      procedure SQLToControls; override;

      {dual list methods}
      procedure ChildToAvailableItem(aChild: TdaChild; aItem: TListItem); override;
      procedure ChildToSelectedItem(aChild: TdaChild; aItem: TListItem); override;
      function  DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild; override;
      function  GetAvailableChild(aIndex: Integer): TdaChild; override;
      function  GetAvailableChildCount: Integer; override;
      function  GetChildType: TdaChildType; override;
      function  GetSelectedChild(aIndex: Integer): TdaChild; override;
      function  GetSelectedChildCount: Integer; override;
      procedure DisplayEditControls(aVisibility: Boolean); override;
      function  SelectItem(aAvailableIndex: Integer): TdaChild; override;

      {events}
      procedure AllFieldsClickEvent(Sender: TObject); override;
      procedure SelectedSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean); override;
      procedure SelectedResizeEvent(Sender: TObject); override;

    public
      class function ImageIndex: Integer; override;
      class function PageName: String; override;

      function  Valid: Boolean; override;

  end; {class, TdaSortPage}

  { TdaSQLPage }
  TdaSQLPage = class(TdaEditPage)
    private
      FAllowEditSQL: Boolean;
      FDPName: TEdit;
      FNameError: TLabel;
      FOnEditSQLAsText: TNotifyEvent;
      FOnValidateName: TppValidateNameEvent;
      FSQLText: TdaSQLEdit;

      procedure DoOnValidateName(Sender: TObject; const aName: String; var aNameValid: Boolean);
      procedure EditSQLClickEvent(Sender: TObject);
      procedure GenerateValidName;
      procedure NameChangeEvent(Sender: TObject);
      procedure SetAllowEditSQL(aValue: Boolean);
    protected
      procedure CreateControls; override;
      procedure SQLToControls; override;
      function  OutOfSync: Boolean; override;

    public
      class function ImageIndex: Integer; override;
      class function PageName: String; override;

      function  Valid: Boolean; override;

      property AllowEditSQL: Boolean read FAllowEditSQL write SetAllowEditSQL;
      property OnEditSQLAsText: TNotifyEvent read FOnEditSQLAsText write FOnEditSQLAsText;
      property OnValidateName: TppValidateNameEvent read FOnValidateName write FOnValidateName;

  end; {class, TdaSQLPage}

  { TdaGroupSearchPage }
  TdaGroupSearchPage = class(TdaFieldPage)
  private
    FcbxOperator: TComboBox;
    FcbxFunction: TComboBox;
    FcbxParameter: TComboBox;
    FcbxAutoSearch: TCheckBox;
    FcbxMandatory: TCheckBox;
    FcbxShowAll: TCheckBox;
    FedtValue: TEdit;
    FResizing: Boolean;

    procedure AddParenthesesClickEvent(Sender: TObject);
    procedure AutoSearchClickEvent(Sender: TObject);
    procedure CalcTypeChangeEvent(Sender: TObject);
    procedure CalcTypeDblClickEvent(Sender: TObject);
    procedure ComparisonChangeEvent(Sender: TObject);
    procedure InsertCriteriaClickEvent(Sender: TObject);
    procedure InsertNOTClickEvent(Sender: TObject);
    procedure InsertORClickEvent(Sender: TObject);
    procedure MandatoryClickEvent(Sender: TObject);
    procedure OperatorChangeEvent(Sender: TObject);
    procedure ParameterChangeEvent(Sender: TObject);
    procedure PopupMenuPopupEvent(Sender: TObject);
    procedure RemoveCriteriaClickEvent(Sender: TObject);
    procedure RemoveParenthesesClickEvent(Sender: TObject);
    procedure ShowAllClickEvent(Sender: TObject);

  protected
    {dual list methods}
    procedure ChildToSelectedItem(aChild: TdaChild; aItem: TListItem); override;
    procedure CreateControls; override;
    function CreatePopupMenu: TppPopupMenuBase; override;
    procedure CreateSelectedColumns(aSelectedList: TppListView); override;
    function  DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild; override;
    procedure DisplayEditControls(aVisibility: Boolean); override;
    function  GetAvailableChild(aIndex: Integer): TdaChild; override;
    function  GetAvailableChildCount: Integer; override;
    function  GetChildType: TdaChildType; override;
    function  GetSelectedChild(aIndex: Integer): TdaChild; override;
    function  GetSelectedChildCount: Integer; override;
    function  OutOfSync: Boolean; override;

    {event}
    procedure SelectedEditedEvent(Sender: TObject; Item: TListItem; var S: String); override;
    function  SelectedMultiSelect: Boolean; override;
    function  SelectedReadOnly: Boolean; override;
    procedure SelectedResizeEvent(Sender: TObject); override;
    procedure SelectedSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean); override;
    function  SelectItem(aAvailableIndex: Integer): TdaChild; override;

  public
    class function ImageIndex: Integer; override;
    class function PageName: String; override;

    function Valid: Boolean; override;

  end; {class, TdaGroupSearchPage}

var
  daQueryDesignerForm: TdaQueryDesignerForm;

implementation

{$R *.DFM}

{******************************************************************************
 *
 ** Q U E R Y   E D I T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaQueryDesigner.Create }

constructor TdaQueryDesigner.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDataView := nil;
  FForm := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaQueryDesigner.Destroy }

destructor TdaQueryDesigner.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaQueryDesigner.LoadStateInfo }

procedure TdaQueryDesigner.LoadStateInfo(aIniStorage: TppIniStorage);
var
  liFormLeft: Integer;
  liFormTop: Integer;
  liFormWidth: Integer;
  liFormHeight: Integer;
begin

  inherited LoadStateInfo(aIniStorage);

  liFormWidth := FForm.Width;
  liFormHeight := FForm.Height;
  liFormLeft := FForm.Left;
  liFormTop := FForm.Top;

  ppFormToScreenCenter(liFormHeight, liFormWidth, liFormLeft, liFormTop);

  FForm.Left := aIniStorage.ReadInteger('QueryDesigner', 'FormLeft', liFormLeft);
  FForm.Top := aIniStorage.ReadInteger('QueryDesigner', 'FormTop', liFormTop);
  FForm.Width := aIniStorage.ReadInteger('QueryDesigner', 'FormWidth', liFormWidth);
  FForm.Height := aIniStorage.ReadInteger('QueryDesigner', 'FormHeight', liFormHeight);

end; {procedure, LoadStateInfo}

{------------------------------------------------------------------------------}
{ TdaQueryDesigner.SaveStateInfo }

procedure TdaQueryDesigner.SaveStateInfo(aIniStorage: TppIniStorage);
begin

  inherited SaveStateInfo(aIniStorage);

  aIniStorage.WriteInteger('QueryDesigner', 'FormLeft', FForm.Left);
  aIniStorage.WriteInteger('QueryDesigner', 'FormTop', FForm.Top);
  aIniStorage.WriteInteger('QueryDesigner', 'FormWidth', FForm.Width);
  aIniStorage.WriteInteger('QueryDesigner', 'FormHeight', FForm.Height);

end; {procedure, SaveStateInfo}

{------------------------------------------------------------------------------}
{ TdaQueryDesigner.GetDataView }

function  TdaQueryDesigner.GetDataView: TObject;
begin
  Result := FDataView;
end; {function, GetDataView}

{------------------------------------------------------------------------------}
{ TdaQueryDesigner.GetDataViewName }

function TdaQueryDesigner.GetDataViewName: String;
begin
  if (FDataView <> nil) then
    Result := FDataView.SQL.DataPipelineName;
end; {function, GetDataViewName}

{------------------------------------------------------------------------------}
{ TdaQueryDesigner.ClassDescription }

class function TdaQueryDesigner.ClassDescription: String;
begin
  Result := ppLoadStr(810); {Query Designer}
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaQueryDesigner.ClassBitmap }

class function TdaQueryDesigner.ClassBitmap: THandle;
begin
  Result := ppBitmapFromResource('DAQUERYDESIGNER');
end; {class function, ClassBitmap}

{------------------------------------------------------------------------------}
{ TdaQueryDesigner.DataViewClass }

class function TdaQueryDesigner.DataViewClass: TdaDataViewClass;
begin
  Result := TdaQueryDataView;
end; {class function, DataViewClass}

{------------------------------------------------------------------------------}
{ TdaQueryDesigner.Notify }

procedure TdaQueryDesigner.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if not(aOperation = ppopRemove) then Exit;

  if (aCommunicator = FDataView) then
    FDataView := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TdaQueryDesigner.CloseQueryEvent }

procedure TdaQueryDesigner.CloseQueryEvent(Sender: TObject; var CanClose: Boolean);
var
  lbValidate: Boolean;
  lsMessage: String;
begin

  if FForm.CancelClicked then Exit;

  lbValidate := False;

  if FForm.OKClicked then
    lbValidate := True

  else if FForm.SQL.Modified then
    begin
      lsMessage := ppLoadStrWithParms(817, [FForm.SQL.DataPipelineName]);

      case MessageDlg(lsMessage, mtConfirmation,[mbYes, mbNo, mbCancel], 0) of
        mrYes:     lbValidate := True;
        mrCancel:  CanClose := False;
        mrNo:      CanClose := True;
      end;

    end;

  if (lbValidate) then
    begin

      // optimization, only check Form.SQL.Valid when not EditSQLAsText,
      // when EditSQLAsText the SQL has already been validated by the Page.Valid
      if FForm.Validate and (FForm.SQL.EditSQLAsText or FForm.SQL.Valid) then
        FForm.ModalResult := mrOK
      else
        CanClose := False;
    end;

end; {procedure, CloseQueryEvent}

{------------------------------------------------------------------------------}
{ TdaQueryDesigner.ClearQuery }

procedure TdaQueryDesigner.ClearQuery;
begin
  if (FDataView <> nil) then
    FDataView.SQL.Clear;
end; {procedure, ClearQuery}

{------------------------------------------------------------------------------}
{ TdaQueryDesigner.Execute }

function TdaQueryDesigner.Execute: Boolean;
begin

  Result := False;

  DoOnCreateDataView(TObject(FDataView));

  if (FDataView = nil) then Exit;

  FDataView.Init;

  if (FForm = nil) then
    FForm := TdaQueryDesignerForm.Create(Application);

  try
    LoadState;

    {get sql from dataview}
    FForm.SQLClass := FDataView.SQLClass;
    FForm.SQL := FDataView.SQL;

    if Report <> nil then
      FForm.SQL.ReportParameters := Report.Parameters
    else
      FForm.SQL.ReportParameters := FDataView.SQL.ReportParameters;


    FForm.SQL.AddNotify(FDataView);

    {set form properties}

    {FForm.Icon := FDataView.Report.Icon;}
    FForm.AllowEditSQL := DataSettings.AllowEditSQL;
    FForm.EditMode := EditMode;
    FForm.EditSQLAsText := FDataView.SQL.EditSQLAsText;
    FForm.OnValidateName := DoOnValidateName;
    FForm.OnCloseQuery := CloseQueryEvent;

    {set SQL properties}
    FForm.SQL.DatabaseName    := DataSettings.DatabaseName;
    FForm.SQL.DatabaseType    := DataSettings.DatabaseType;
    FForm.SQL.CollationType   := DataSettings.CollationType;
    FForm.SQL.GuidCollationType := DataSettings.GuidCollationType;
    FForm.SQL.NullCollationType := DataSettings.NullCollationType;
    FForm.SQL.IsCaseSensitive := DataSettings.IsCaseSensitive;
    FForm.SQL.SQLType := DataSettings.SQLType;
    FForm.SQL.LanguageIndex := LanguageIndex;

    if DataSettings.UseDataDictionary then
      FForm.SQL.DataDictionary := TppDataDictionary(DataSettings.DataDictionary)
    else
      FForm.SQL.DataDictionary := nil;

    FForm.Initialize;

    {show form}
    if (FForm.ShowModal = mrOK) then
      begin
        FDataView.SQL := FForm.SQL;
        FDataView.SQL.Modified := False;
        FDataView.UpdateLinkColors(False);

        Result := True;
      end;

    FForm.SQL.RemoveNotify(FDataView);

    SaveState;

  finally

    FForm.Free;
    FForm := nil;

  end;

end; {function, Execute}

{******************************************************************************
 *
 ** Q U E R Y   D E S I G N E R   F O R M
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.FormCreate }

procedure TdaQueryDesignerForm.FormCreate(Sender: TObject);
begin

  FAllowEditSQL := False;
  FCancelClicked := False;
  FEditMode := ppemAll;
  FEditSQLAsText := False;
  FOKClicked := False;
  FOnValidateName := nil;
  FPages := nil;
  FSQL := nil;
  FSQLClass := nil;

end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.FormDestroy }

procedure TdaQueryDesignerForm.FormDestroy(Sender: TObject);
begin

  FPages.Free;

  FSQL.Free;



end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.SelectPage }

procedure TdaQueryDesignerForm.SelectPage(aIndex: Integer);
begin

  DeactivatePage;

  if (aIndex >= FPages.Count) then
    aIndex := FPages.Count - 1;

  if (FNoteBook.ActivePageIndex = aIndex) then Exit; 

  FNoteBook.ActivePage := TdaEditPage(FPages[aIndex]).Page;

  ActivatePage;

end; {procedure, SelectPage}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.Validate }

function TdaQueryDesignerForm.Validate: Boolean;
var
  liIndex: Integer;
  lPage: TdaEditPage;
begin

  Result := True;

  liIndex := 0;
  lPage := nil;

  while (Result) and (liIndex < FPages.Count) do
    begin
      lPage := TdaEditPage(FPages[liIndex]);

      if not(lPage.Initialized) then
        begin
          lPage.CreateControls;

          lPage.SQLToControls;

          lPage.FInitialized := True;
        end;

      if not(lPage.Valid) then
        Result := False
      else
        Inc(liIndex);
    end;

  if not(Result) and (lPage <> FEditPage) then
    begin
      FEditPage := lPage;

      FNoteBook.ActivePage := FEditPage.Page;

      ActivatePage;
    end;

end; {procedure, Validate}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.Initialize }

procedure TdaQueryDesignerForm.Initialize;
var
  liIndex: Integer;
  lSQLPage: TdaSQLPage;
begin

  FNoteBook := TppTabbedNotebook.Create(Self);
  FNoteBook.Initialize(pnlForm);
  FNotebook.Images := ToolImageList;

  Caption := ppLoadStr(810); {Data}

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

  if (FPages = nil) then
    begin
      FPages := TList.Create;

      FPages.Add(TdaTablePage.CreatePage(Self, FNoteBook));
      FPages.Add(TdaFieldPage.CreatePage(Self, FNoteBook));
      FPages.Add(TdaCalcPage.CreatePage(Self, FNoteBook));
      FPages.Add(TdaSearchPage.CreatePage(Self, FNoteBook));
      FPages.Add(TdaGroupPage.CreatePage(Self, FNoteBook));
      FPages.Add(TdaGroupSearchPage.CreatePage(Self, FNoteBook));
      FPages.Add(TdaSortPage.CreatePage(Self, FNoteBook));

      FPages.Add(TdaSQLPage.CreatePage(Self, FNoteBook));
      
      lSQLPage := TdaSQLPage(FPages[FPages.Count - 1]);

      lSQLPage.AllowEditSQL := FAllowEditSQL;
      lSQLPage.OnEditSQLAsText := EditSQLAsTextEvent;
      lSQLPage.OnValidateName := DoOnValidateName;

      for liIndex := 0 to FPages.Count - 1 do
        TdaEditPage(FPages[liIndex]).SQL := FSQL;

    end;

  {default to first page}
  case FEditMode of
    ppemAll, ppemTables: FEditPage := TdaEditPage(FPages[0]);
    ppemFields:          FEditPage := TdaEditPage(FPages[1]);
    ppemCalcs:           FEditPage := TdaEditPage(FPages[2]);
    ppemSearch:          FEditPage := TdaEditPage(FPages[3]);
    ppemGroup:           FEditPage := TdaEditPage(FPages[4]);
    ppemGroupSearch:     FEditPage := TdaEditPage(FPages[5]);
    ppemSort:            FEditPage := TdaEditPage(FPages[6]);
    ppemText:            FEditPage := TdaEditPage(FPages[7]);
  end;

  FNoteBook.OnTabChanged := ehNotebook_TabChanged;
  FNotebook.ActivePage := FEditPage.Page;

  if (FNotebook.ActivePageIndex = 0) then
    begin
      FNotebook.ActivePageIndex := 1;
      FNotebook.ActivePageIndex := 0;
    end;

  // hide tabs, if edit sql as text
  if (FSQL.EditSQLAsText) then
    FNoteBook.SetTabsVisible(False);
//  else if FSQL.GroupByFieldCount = 0 then
//    FNotebook.SetTabVisible(5, False);


  ActivatePage;

  FSQL.Modified := False;

end; {procedure, Initialize}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.DoOnValidateName }

procedure TdaQueryDesignerForm.DoOnValidateName(Sender: TObject; const aName: String; var aNameValid: Boolean);
begin
  if Assigned(FOnValidateName) then FOnValidateName(Sender, aName, aNameValid);
end; {procedure, DoOnValidateName}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.ActivatePage }

procedure TdaQueryDesignerForm.ActivatePage;
begin

  FEditPage := TdaEditPage(FNotebook.ActivePage.Tag);

  FEditPage.Activate;

end; {procedure, ActivatePage}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.DeactivatePage }

procedure TdaQueryDesignerForm.DeactivatePage;
begin

  FEditPage := TdaEditPage(FNotebook.ActivePage.Tag);

  FEditPage.Deactivate;

end; {procedure, ActivatePage}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.btnCancelClick }

procedure TdaQueryDesignerForm.btnCancelClick(Sender: TObject);
begin
  FCancelClicked := True;
end; {procedure, btnCancelClick}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.btnOKClick }

procedure TdaQueryDesignerForm.btnOKClick(Sender: TObject);
begin
  FOKClicked := True;
end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.pgcDesignerChange }

procedure TdaQueryDesignerForm.ehNotebook_TabChanged(Sender: TObject);
begin
  ActivatePage;
end; {procedure, pgcDesignerChange}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.SetSQLClass }

procedure TdaQueryDesignerForm.SetSQLClass(aSQLClass: TdaSQLClass);
begin

  if (FSQLClass = aSQLClass) then Exit;

  if (FSQL <> nil) then
    FSQL.Free;

  FSQLClass := aSQLClass;

  FSQL := FSQLClass.Create(Self);

end; {procedure, SetSQLClass}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.SetSQL }

procedure TdaQueryDesignerForm.SetSQL(aSQL: TdaSQL);
begin

  FSQL.Assign(aSQL);

  FSQL.AllowSelfJoin := True;

end; {procedure, SetSQL}

{------------------------------------------------------------------------------}
{ TdaQueryDesignerForm.EditSQLAsTextEvent }

procedure TdaQueryDesignerForm.EditSQLAsTextEvent(Sender: TObject);
begin

  // hide tabs
  FNoteBook.SetTabsVisible(False);

end; {procedure, EditSQLAsTextEvent}

procedure TdaQueryDesignerForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  lbCancel: Boolean;
begin

  if Key = VK_Escape then
    begin

      // display confirmation dialog
      if FSQL.Modified then
         lbCancel := MessageDlg(btnCancel.Caption + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
      else
        lbCancel := True;

      if lbCancel then
        btnCancel.Click;

    end;


end;


{******************************************************************************
 *
 ** E D I T   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaEditPage.CreatePage }

constructor TdaEditPage.CreatePage(aOwner: TComponent; aNotebook: TppTabbedNotebook);
begin

  inherited Create(aOwner);

  FNotebook := aNotebook;

  FSQL := nil;

  FPage := FNotebook.AddPage(PageName);
  FNotebook.SetPageImageIndex(FPage, ImageIndex);
  FPage.Tag := Integer(Self);

end; {constructor, CreatePage}

{------------------------------------------------------------------------------}
{ TdaEditPage.Notification }

procedure TdaEditPage.Notification(aComponent: TComponent; aOperation: TOperation);
begin

  inherited Notification(aComponent, aOperation);

  if (aComponent = FNotebook) and (aOperation = opRemove) then
    FNotebook := nil;

end; {procedure, Notification}

{------------------------------------------------------------------------------}
{ TdaEditPage.Notify }

procedure TdaEditPage.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aCommunicator = FSQL) and (aOperation = ppopRemove) then
    FSQL := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TdaEditPage.SetSQL }

procedure TdaEditPage.SetSQL(aSQL: TdaSQL);
begin

  if (FSQL <> nil) then
    FSQL.RemoveNotify(Self);

  FSQL := aSQL;

  if (FSQL <> nil) then
    FSQL.AddNotify(Self);

end; {procedure, SetSQL}

{------------------------------------------------------------------------------}
{ TdaEditPage.PageName }

class function TdaEditPage.PageName: String;
begin
  Result := ClassName;
end; {class function, PageName}

{------------------------------------------------------------------------------}
{ TdaEditPage.Activate }

procedure TdaEditPage.Activate;
begin

  if (FInitialized) and not(OutOfSync) then Exit;

  FSettingControls := True;

  if not(FInitialized) then
    begin
      CreateControls;

      SQLToControls;

      FInitialized := True;
    end

  else if OutOfSync then
    SQLToControls;

  FSettingControls := False;

end; {procedure, Activate}

{------------------------------------------------------------------------------}
{ TdaEditPage.Deactivate }

procedure TdaEditPage.Deactivate;
begin
  if FSQLOutOfSync then
    begin
      FSQL.Resync;
      FSQLOutOfSync := False;
    end;

end; 

{------------------------------------------------------------------------------}
{ TdaEditPage.FreeControls }

procedure TdaEditPage.FreeControls;
var
  liIndex: Integer;
  lComponent: TComponent;
begin

  for liIndex := ComponentCount - 1 downto 0 do
    begin
      lComponent := Components[liIndex];

      if (lComponent <> FPage) and (lComponent <> FSQL) then
        lComponent.Free;
    end;

end; {procedure, FreeControls}

class function TdaEditPage.ImageIndex: Integer;
begin
  Result := 0;
end;

{------------------------------------------------------------------------------}
{ TdaEditPage.Reset }

procedure TdaEditPage.Reset;
begin

  FreeControls;

  FInitialized := False;

end; {procedure, Reset}

{------------------------------------------------------------------------------}
{ TdaEditPage.ParentForm }

function TdaEditPage.ParentForm: TForm;
var
  lParent: TControl;
begin

  Result := nil;

  lParent := FPage.Parent;

  while (lParent <> nil) and (Result = nil) do
    if (lParent is TForm) then
      Result := TForm(lParent)
    else
      lParent := lParent.Parent;

end; {function, ParentForm}

{******************************************************************************
 *
 ** D U A L   L I S T   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDualListPage.CreatePage }

constructor TdaDualListPage.CreatePage(aOwner: TComponent; aNotebook: TppTabbedNotebook);
begin

  inherited CreatePage(aOwner, aNotebook);

  FAllowSorting := False;
  FSelectionList := TList.Create;

end; {constructor, CreatePage}

{------------------------------------------------------------------------------}
{ TdaDualListPage.Destroy }

destructor TdaDualListPage.Destroy;
begin

  FSelectionList.Free;

  inherited Destroy;

end; {constructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaDualListPage.CreateControls }

procedure TdaDualListPage.CreateControls;
var
  lTopPanel: TPanel;
  lBottomPanel: TPanel;
  lSplitter: TSplitter;
  lBottomListPanel: TPanel;
  lMovePanel: TPanel;
begin

  if (FNotebook = nil) or (SQL = nil) then Exit;

  FDeselecting := False;
  FMoveSelectedItems := True;
  FSelecting := False;
  FSortMode := 1;
  
  {top panel}
  lTopPanel := TPanel.Create(Self);
  lTopPanel.Parent := Page;
  lTopPanel.Align := alTop;
  lTopPanel.Height := 141;
  lTopPanel.BevelOuter := bvNone;

  {top title panel}
  FTopPanel := TPanel.Create(Self);
  FTopPanel.Parent := lTopPanel;
  FTopPanel.Align := alTop;
  FTopPanel.Height := 21;
  FTopPanel.BevelOuter := bvNone;

  FTopLabel := TLabel.Create(Self);
  FTopLabel.Parent := FTopPanel;
  FTopLabel.Left := 6;
  FTopLabel.Top := 4;

  FTopList := TppListView.Create(Self);
  FTopList.Parent := lTopPanel;
  FTopList.Align := alClient;
  FTopList.ViewStyle := vsReport;
  FTopList.DragCursor := crDefault;
  FTopList.DragMode := dmAutomatic;
  FTopList.ReadOnly := True;
  FTopList.ColumnClick := FAllowSorting;

  {forces rows to height of imagelist}
  FTopList.SmallImages := TImageList.Create(Self);;
  FTopList.SmallImages.Height := 16;
  FTopList.SmallImages.Width := 3;

  {bottom panel}
  lBottomPanel := TPanel.Create(Self);
  lBottomPanel.Parent := Page;
  lBottomPanel.Align := alTop;
  lBottomPanel.Height := 141;
  lBottomPanel.BevelOuter := bvNone;

  {bottom title panel}
  FBottomPanel := TPanel.Create(Self);
  FBottomPanel.Parent := lBottomPanel;
  FBottomPanel.Top := 205;
  FBottomPanel.Height := 21;
  FBottomPanel.Align := alTop;
  FBottomPanel.BevelInner := bvLowered;
  FBottomPanel.BevelOuter := bvNone;

  FBottomLabel := TLabel.Create(Self);
  FBottomLabel.Parent := FBottomPanel;
  FBottomLabel.Left := 6;
  FBottomLabel.Top := 4;

  {bottom list panel}
  lBottomListPanel := TPanel.Create(Self);
  lBottomListPanel.Parent := lBottomPanel;
  lBottomListPanel.Align := alClient;
  lBottomListPanel.BevelOuter := bvNone;

  FBottomList := TppListView.Create(Self);
  FBottomList.Name := 'FBottomList';
  FBottomList.Parent := lBottomListPanel;
  FBottomList.Align := alClient;
  FBottomList.ViewStyle := vsReport;
  FBottomList.MultiSelect := SelectedMultiSelect;
  FBottomList.ReadOnly := SelectedReadOnly;
  FBottomList.ColumnClick := False;

  CreateSelectedColumns(FBottomList);

  {forces rows to height of imagelist}
  FBottomList.SmallImages := TImageList.Create(Self);;
  FBottomList.SmallImages.Height := 16;
  FBottomList.SmallImages.Width := 3;

  {assign event handlers}
  if FAllowSorting then
    FTopList.OnColumnClick := AvailableColumnClickEvent;

  {create order buttons}
  if (FAllowSorting) then
    begin
      lMovePanel := TPanel.Create(Self);
      lMovePanel.Parent := lBottomListPanel;
      lMovePanel.Height := lBottomListPanel.Height;
      lMovePanel.Width := 29;
      lMovePanel.BevelOuter := bvNone;
      lMovePanel.Align := alRight;

      FMoveUp := TSpeedButton.Create(Self);
      FMoveUp.Parent := lMovePanel;
      FMoveUp.Left := 3;
      FMoveUp.Top := 101 - 58;
      FMoveUp.Width := 25;
      FMoveUp.Height := 17;
      FMoveUp.Glyph.Handle := ppBitmapFromResource('DAMOVEUP');
      FMoveUp.OnClick := MoveUpClickEvent;
      FMoveUp.Anchors := [];


      FMoveDown := TSpeedButton.Create(Self);
      FMoveDown.Parent := lMovePanel;
      FMoveDown.Left := 3;
      FMoveDown.Top := (101 - 58) + 41;
      FMoveDown.Width := 25;
      FMoveDown.Height := 17;
      FMoveDown.Glyph.Handle := ppBitmapFromResource('DAMOVEDOWN');
      FMoveDown.OnClick := MoveDownClickEvent;
      FMoveDown.Anchors := [];

    end
  else
    begin
      FMoveUp := nil;
      FMoveDown := nil;
    end;


  FTopList.OnDblClick := AvailableDblClickEvent;
  FTopList.OnDragOver := AvailableDragOverEvent;
  FTopList.OnDragDrop := AvailableDragDropEvent;
  
  FBottomList.OnClick := SelectedClickEvent;
  FBottomList.OnDblClick := SelectedDblClickEvent;
  FBottomList.OnDragOver := SelectedDragOverEvent;
  FBottomList.OnDragDrop := SelectedDragDropEvent;
  FBottomList.OnColumnResize := SelectedColumnResizeEvent;
  FBottomList.OnScroll := SelectedScrollEvent;
  FBottomList.OnResize := SelectedResizeEvent;
  FBottomList.OnSelectItem := SelectedSelectItemEvent;

  {do this last}
  lBottomPanel.Align := alBottom;

  {splitter}
  lSplitter := TSplitter.Create(Self);
  lSplitter.Parent := Page;
  lSplitter.Top := 0;
  lSplitter.Align := alBottom;
  lSplitter.Height := 3;
  lSplitter.Cursor := crVSplit;

  lTopPanel.Align := alClient;

  {fixes bug in Delphi which causes these buttons to disappear on this page}
  if (FMoveUp <> nil) then
    begin

      if (ParentForm.Visible) then
        begin
          FMoveUp.Top := 43;
          FMoveDown.Top := 84;
        end
      else
        begin
          FMoveUp.Top := 0;
          FMoveDown.Top := FMoveUp.Top + FMoveUp.Height;
        end;
    end;


end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaDualListPage.CreateSelectedColumns }

procedure TdaDualListPage.CreateSelectedColumns(aSelectedList: TppListView);
begin

end; {procedure, CreateSelectedColumns}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectedReadOnly }

function TdaDualListPage.SelectedReadOnly: Boolean;
begin
  Result := True;
end; {procedure, SelectedReadOnly}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectedMultiSelect }

function TdaDualListPage.SelectedMultiSelect: Boolean;
begin
  Result := False;
end; {procedure, SelectedMultiSelect}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SQLToControls }

procedure TdaDualListPage.SQLToControls;
begin

  BuildAvailableList;

  BuildSelectedList;

end; {procedure, SQLToControls}

{------------------------------------------------------------------------------}
{ TdaDualListPage.BuildAvailableList }

procedure TdaDualListPage.BuildAvailableList;
var
  liIndex: Integer;
  liCount: Integer;
  lChild: TdaChild;
  lItem: TListItem;
begin

  FListsCleared := True;

  FTopList.Items.Clear;

  liCount := GetAvailableChildCount;

  for liIndex := 0 to liCount - 1 do
    begin
      lChild := GetAvailableChild(liIndex);

      lItem := FTopList.Items.Add;

      ChildToAvailableItem(lChild, lItem);
    end;

end; {procedure, BuildAvailableList}

{------------------------------------------------------------------------------}
{ TdaDualListPage.BuildSelectedList }

procedure TdaDualListPage.BuildSelectedList;
var
  liIndex: Integer;
  liCount: Integer;
  lChild: TdaChild;
  lItem: TListItem;
begin

  FBottomList.Items.Clear;

  liCount := GetSelectedChildCount;

  for liIndex := 0 to liCount - 1 do
    begin
      lChild := GetSelectedChild(liIndex);

      lItem := FBottomList.Items.Add;

      ChildToSelectedItem(lChild, lItem);
    end;
    
  UpdateMoveButtons;

end; {procedure, BuildSelectedList}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectAllItems }

procedure TdaDualListPage.SelectAllItems;
var
  lList: TList;
begin

  lList := TList.Create;

  ItemsToList(FTopList.Items, lList);

  SelectItems(lList);

  lList.Free;

end; {procedure, SelectAllItems}

{------------------------------------------------------------------------------}
{ TdaDualListPage.DeselectAllItems }

procedure TdaDualListPage.DeselectAllItems;
var
  lList: TList;
begin

  lList := TList.Create;

  ItemsToList(FBottomList.Items, lList);

  DeselectItems(lList);

  lList.Free;

end; {procedure, DeselectAllItems}

{------------------------------------------------------------------------------}
{ TdaDualListPage.ItemsToList }

procedure TdaDualListPage.ItemsToList(aListItems: TListItems; aList: TList);
var
 liIndex: Integer;
begin
  for liIndex := 0 to aListItems.Count - 1 do
    aList.Add(aListItems[liIndex]);
end; {procedure, ItemsToList}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectItems }

procedure TdaDualListPage.SelectItems(aList: TList);
var
  liIndex: Integer;
  lItem1: TListItem;
  lItem2: TListItem;
  lChild: TdaChild;
begin

  for liIndex := 0 to aList.Count - 1 do
    begin
      lItem1 := TListItem(aList[liIndex]);

      FListsCleared := False;

      FSelecting := True;

      lChild := SelectItem(lItem1.Index);

      FSelecting := False;

      if (lChild <> nil) then
        begin
          lItem2 := FBottomList.Items.Add;

          ChildToSelectedItem(lChild, lItem2);

          if (FMoveSelectedItems) and not(FListsCleared) then
            lItem1.Free;
        end;

      FListsCleared := False;
    end;

   if FTopList.DrawEnabledItems then
     FTopList.Refresh;
     
   UpdateMoveButtons;

end; {procedure, SelectItems}

{------------------------------------------------------------------------------}
{ TdaDualListPage.UpdateMoveButtons }

procedure TdaDualListPage.UpdateMoveButtons;
var
  lbEnabled: Boolean;
begin

  if (FMoveUp = nil) then Exit;

  lbEnabled := (GetSelectedChildCount > 1);

  FMoveUp.Enabled := lbEnabled;
  FMoveDown.Enabled := lbEnabled;
  
end; {procedure, UpdateMoveButtons}

{------------------------------------------------------------------------------}
{ TdaDualListPage.DeselectItems }

procedure TdaDualListPage.DeselectItems(aList: TList);
var
  liIndex: Integer;
  lItem: TListItem;
  lChild: TdaChild;
  lbValidDeselection: Boolean;
begin

  for liIndex := 0 to aList.Count - 1 do
    begin
      lItem  := TListItem(aList[liIndex]);
      lbValidDeselection := True;

      FListsCleared := False;

      FDeselecting := True;

      lChild := DeselectItem(lItem.Index, lbValidDeselection);

      FDeselecting := False;

      if not(FListsCleared) and lbValidDeselection then
        begin
          {remove the item from the selected list, if deselect is valid}
          lItem.Free;

          {re-add the item to the available list, if move is valid}
          if (lChild <> nil) and (FMoveSelectedItems) then
            begin
              lItem := FTopList.Items.Insert(lChild.Tag);

              ChildToAvailableItem(lChild, lItem);
            end;

        end;

      if FMoveSelectedItems then
        FListsCleared := False;

    end;

  TopList.Sort;

  UpdateMoveButtons;

end; {procedure, DeselectItems}

{------------------------------------------------------------------------------}
{ TdaDualListPage.AvailableColumnClickEvent }

procedure TdaDualListPage.AvailableColumnClickEvent(Sender: TObject; Column: TListColumn);
begin

  if (FSortMode = (Column.Index + 1)) then
    FSortMode := FSortMode * -1
  else
    FSortMode := Column.Index + 1;

end; {procedure, ColumnClickEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.AvailableDblClickEvent }

procedure TdaDualListPage.AvailableDblClickEvent(Sender: TObject);
var
  lList: TList;
  lItem: TListItem;
begin

  lItem := FTopList.Selected;

  if (lItem = nil) then Exit;

  lList := TList.Create;

  lList.Add(lItem);

  SelectItems(lList);

  lList.Free;

end; {procedure, AvailableDblClickEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.AvailableDragOverEvent }

procedure TdaDualListPage.AvailableDragOverEvent(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = FBottomList);
end; {procedure, AvailableDragOverEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.AvailableDragDropEvent }

procedure TdaDualListPage.AvailableDragDropEvent(Sender, Source: TObject; X,Y: Integer);
var
  lList: TList;
  lItem: TListItem;
begin

  lItem := FBottomList.Selected;

  if (lItem = nil) then Exit;

  lList := TList.Create;

  while (lItem <> nil) do
    begin
      lList.Add(lItem);

      lItem := FBottomList.GetNextItem(lItem, sdAll, [isSelected]);
    end;

  DeselectItems(lList);

  lList.Free;

end; {procedure, AvailableDragDropEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectedColumnResizeEvent }

procedure TdaDualListPage.SelectedColumnResizeEvent(aListView: TListView; aColumn: TListColumn);
begin
  if FSettingControls then Exit;

  SelectedSelectItemEvent(Self, FBottomList.Selected, True);
end; {procedure, SelectedColumnResizeEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectedClickEvent }

procedure TdaDualListPage.SelectedClickEvent(Sender: TObject);
var
  lItem: TListItem;
  lPoint: TPoint;
begin

  if FSettingControls then Exit;

  Windows.GetCursorPos(lPoint);

  lPoint := FBottomList.ScreenToClient(lPoint);

  lItem := FBottomList.GetItemAt(6, lPoint.Y);

  if (lItem <> nil) then
    FBottomList.Selected := lItem;

end; {procedure, SelectedClickEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectedDblClickEvent }

procedure TdaDualListPage.SelectedDblClickEvent(Sender: TObject);
var
  lList: TList;
  lItem: TListItem;
begin

  if FSettingControls then Exit;

  lItem := FBottomList.Selected;

  if (lItem = nil) then Exit;

  lList := TList.Create;

  lList.Add(lItem);

  DeselectItems(lList);

  lList.Free;

end; {procedure, SelectedDblClickEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectedDragOverEvent }

procedure TdaDualListPage.SelectedDragOverEvent(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if FSettingControls then Exit;

  Accept := (Source = FTopList);
end; {procedure, SelectedDragOverEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectedDragDropEvent }

procedure TdaDualListPage.SelectedDragDropEvent(Sender, Source: TObject; X,Y: Integer);
var
  lList: TList;
  lItem: TListItem;
begin

  if FSettingControls then Exit;

  lItem := FTopList.Selected;

  if (lItem = nil) then Exit;

  lList := TList.Create;

  while (lItem <> nil) do
    begin
      lList.Add(lItem);

      lItem := FTopList.GetNextItem(lItem, sdAll, [isSelected]);
    end;

  SelectItems(lList);

  lList.Free;

end; {procedure, SelectedDragDropEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.DisplayEditControls }

procedure TdaDualListPage.DisplayEditControls(aVisibility: Boolean);
begin
  
end; {procedure, DisplayEditControls}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectedResizeEvent }

procedure TdaDualListPage.SelectedResizeEvent(Sender: TObject);
begin

end; {procedure, SelectedResizeEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectedScrollEvent }

procedure TdaDualListPage.SelectedScrollEvent(Sender: TObject);
begin
  if FSettingControls then Exit;
  
  DisplayEditControls(False);
end; {procedure, SelectedScrollEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectedEditingEvent }

procedure TdaDualListPage.SelectedEditingEvent(Sender: TObject; Item: TListItem; var AllowEdit: Boolean);
begin

end; {procedure, SelectedEditingEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectedEditedEvent }

procedure TdaDualListPage.SelectedEditedEvent(Sender: TObject; Item: TListItem; var S: String);
begin

end; {procedure, SelectedEditedEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.SelectedSelectItemEvent }

procedure TdaDualListPage.SelectedSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);
begin

end; {procedure, SelectedSelectItemEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.Move }

procedure TdaDualListPage.Move(aIncrement: Integer);
var
  liIndex: Integer;
  liNewIndex: Integer;
  lChild: TdaChild;
  liEnd: Integer;
  lList: TList;
  liCount: Integer;
  lItem: TListItem;
begin

  liCount := FBottomList.Items.Count;

  if (liCount = 0) then Exit;

  if (FBottomList.Items[0].Selected) and (aIncrement < 0) then Exit;

  if FBottomList.Items[liCount - 1].Selected and (aIncrement > 0) then Exit;


  if (aIncrement < 0) then
    begin
      liIndex := 0;
      liEnd := FBottomList.Items.Count;
    end
  else
    begin
      liIndex := FBottomList.Items.Count - 1;
      liEnd := -1;
    end;

  lList := TList.Create;
  
  while (liIndex <> liEnd) do
    begin
      if FBottomList.Items[liIndex].Selected then
        begin
          lChild := GetSelectedChild(liIndex);

          liNewIndex := liIndex + aIncrement;

          if (liNewIndex > -1) and (liNewIndex < FBottomList.Items.Count) then
            begin
              FSQL.MoveChild(lChild, liIndex, liNewIndex);

              FBottomList.Items.Delete(liIndex);

              lItem := FBottomList.Items.Insert(liNewIndex);

              ChildToSelectedItem(lChild, lItem);

              lList.Add(TObject(liNewIndex));
            end;
        end;

      liIndex := liIndex + (aIncrement * -1);
    end;

  for liIndex := 0 to lList.Count - 1 do
    FBottomList.Items[Integer(lList[liIndex])].Selected := True;

  if (lList.Count > 0) then
    begin
      if (aIncrement < 0) then
        begin
          lItem := FBottomList.Items[Integer(lList[0])];

         while (FBottomList.VisibleRowCount > 0) and
               ((lItem.Index - (FBottomList.TopItem.Index)) < 0) do
            FBottomList.Scroll(0, -10);
        end
      else
        begin
          lItem := FBottomList.Items[Integer(lList[lList.Count - 1])];

          while (FBottomList.VisibleRowCount > 0) and
                ((lItem.Index - (FBottomList.TopItem.Index)) >= FBottomList.VisibleRowCount) do
            FBottomList.Scroll(0, 10);
        end;

      lItem.Focused := True;
    end;

  FBottomList.Items.EndUpdate;

  lList.Free;

end; {procedure, Move}

{------------------------------------------------------------------------------}
{ TdaDualListPage.MoveUpClickEvent }

procedure TdaDualListPage.MoveUpClickEvent(Sender: TObject);
begin
  Move(-1);
end; {procedure, MoveUpClickEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.MoveDownClickEvent }

procedure TdaDualListPage.MoveDownClickEvent(Sender: TObject);
begin
  Move(1);
end; {procedure, MoveDownClickEvent}

{------------------------------------------------------------------------------}
{ TdaDualListPage.CalcEditControlPosition }

procedure TdaDualListPage.CalcEditControlPosition(aControl: TControl; aItem: TListItem; aFieldPosition: Integer);
var
  liIndex: Integer;
  liOffset: Integer;
  liLeft: Integer;
  liWidth: Integer;
  liControlEdge: Integer;
  liListViewEdge: Integer;
begin

  if (aItem = nil) then
    begin
      aControl.Visible := False;

      Exit;
    end;

  liOffset := (FBottomList.Columns.Count - aFieldPosition) + 1;

  liLeft := 0;

  for liIndex := 0 to FBottomList.Columns.Count - liOffset do
    liLeft := liLeft + FBottomList.Columns[liIndex].Width;

  liControlEdge := liLeft + FBottomList.Columns[aFieldPosition].Width;
  liListViewEdge := (FBottomList.Left + FBottomList.Width);

  liWidth := FBottomList.Columns[aFieldPosition].Width - 2;

  // adjust for vert scrollbar, as neededd
  if (Windows.GetWindowLong(FBottomList.Handle, GWL_STYLE) and WS_VSCROLL) <> 0  then
    liWidth := liWidth - Windows.GetSystemMetrics(SM_CXVSCROLL);

  liLeft := liLeft + aItem.Left;

  if (liControlEdge > liListViewEdge) then
    liWidth := (liWidth - (liControlEdge - liListViewEdge)) - 2;

  if (liWidth < 12) then
    aControl.Visible := False

  else
    begin
      aControl.Visible := True;

      if (aControl is TComboBox) then
        begin
          aControl.Left := liLeft + 2;
          aControl.Top := aItem.Top + 21;
          aControl.Width := liWidth - 2;
        end

      else if (aControl is TEdit) then
        begin
          aControl.Left := liLeft + 3;
          aControl.Top := aItem.Top + 21;
          aControl.Width := liWidth - 3;
        end

      else if (aControl is TCheckBox) then
        begin
          aControl.Left := liLeft + 4;
          aControl.Top := aItem.Top + 24;
          aControl.Width := liWidth - 7;
        end;
    end;


end; {procedure, CalcEditControlPosition}

{******************************************************************************
 *
 ** T A B L E   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaTablePage.PageName }

class function TdaTablePage.PageName: String;
begin
  Result := ppLoadStr(836); {Tables}
end; {procedure, PageName}

{------------------------------------------------------------------------------}
{ TdaTablePage.ImageIndex }

class function TdaTablePage.ImageIndex: Integer;
begin
  Result := ToolImageList.AddTool('DATABLES');
end;

{------------------------------------------------------------------------------}
{ TdaTablePage.CreateControls }

procedure TdaTablePage.CreateControls;
var
  lColumn: TListColumn;
  lPanel: TPanel;
  lBitmap: TBitmap;
begin

  inherited CreateControls;

  TopLabel.Caption := ppLoadStr(728); {Available Tables}

  FAvailableTables := TopList;

  FAvailableTables.DrawEnabledItems  := True;
  FAvailableTables.OnDrawEnabledItem := AvailableDrawEnableItemEvent;

  MoveSelectedItems := not(SQL.AllowSelfJoin);

  lColumn := FAvailableTables.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := ppLoadStr(833); {Table}

  lColumn := FAvailableTables.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := ppLoadStr(834); {Table Name}
  lBitmap := TBitmap.Create;

{$IFNDEF Delphi5}
  lPanel := TPanel.Create(Self);
  lPanel.Parent := BottomPanel;
  lPanel.BevelOuter := bvNone;
  lPanel.Align := alRight;
  lPanel.Width := lBitmap.Canvas.TextWidth(FcbxDistinct.Caption) + 30;

  FcbxDistinct := TCheckBox.Create(Self);
  FcbxDistinct.Parent := lPanel;
  FcbxDistinct.Caption := ppLoadStr(754); {Distinct}
  FcbxDistinct.Top := 1;
  FcbxDistinct.Left := 0;

{$ELSE}
  FcbxDistinct := TCheckBox.Create(Self);
  FcbxDistinct.Parent := BottomPanel;
  FcbxDistinct.Caption := ppLoadStr(754); {Distinct}
  FcbxDistinct.Top := 3;
  FcbxDistinct.Left := BottomPanel.Width - (FcbxDistinct.Width + 10);
  FcbxDistinct.Width := lBitmap.Canvas.TextWidth(FcbxDistinct.Caption) + 30;
  FcbxDistinct.Anchors := [akTop, akRight];
{$ENDIF}
  
  lBitmap.Free;

  FcbxDistinct.OnClick := DistinctClickEvent;

  BottomLabel.Caption := ppLoadStr(824); {Selected Tables}

  if (SQL.AllowManualJoins) then
    begin

      lPanel := TPanel.Create(Self);
      lPanel.Parent := BottomPanel.Parent;
      lPanel.BevelOuter := bvNone;
      lPanel.Height := 16;
      lPanel.Width := 16;

      FspbJoin := TSpeedButton.Create(Self);
      FspbJoin.Parent := lPanel;
      FspbJoin.Height := 16;
      FspbJoin.Width := 16;
      FspbJoin.Glyph.Handle := ppBitmapFromResource('DADIALOG');
      FspbJoin.Parent.Visible := False;
      FspbJoin.OnClick := JoinClickEvent;
    end
  else
    FspbJoin := nil;
    
  FSelectedTables := BottomList;

  FSelectedTables.DragCursor := crDefault;
  FSelectedTables.DragMode := dmAutomatic;

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaTablePage.AvailableDrawEnableItemEvent }

procedure TdaTablePage.AvailableDrawEnableItemEvent(Sender: TCustomListView; aItem: TListItem; var aEnabled, aBolded: Boolean);
begin

  if (FSQL.DataDictionary <> nil) and (FSQL.DataDictionary.AutoJoin) and (FSQL.AllowManualJoins) then
    begin
      aEnabled := True;

      if (FSQL.SelectTableCount > 0) then
        aBolded := TdaTable(FSQL.AvailableSelectTables[aItem.Index]).Joinable
      else
        aBolded := False;
    end

  else
    begin
      aEnabled := TdaTable(FSQL.AvailableSelectTables[aItem.Index]).Joinable;
      aBolded := False;
    end;

end; {procedure, AvailableDrawEnableItemEvent}

{------------------------------------------------------------------------------}
{ TdaTablePage.CreateSelectedColumns }

procedure TdaTablePage.CreateSelectedColumns(aSelectedList: TppListView);
var
  lColumn: TListColumn;
begin

  inherited CreateSelectedColumns(aSelectedList);

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := ppLoadStr(833); {Table}

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := ppLoadStr(834); {Table Name}

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := ppLoadStr(830); {SQL Alias}

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := ppLoadStr(782); {Join Type}

end; {procedure, CreateSelectedColumns}

{------------------------------------------------------------------------------}
{ TdaTablePage.SQLToControls }

procedure TdaTablePage.SQLToControls;
begin

  inherited SQLToControls;

  {if all fields selected, check checkbox}
  FcbxDistinct.Checked := SQL.Distinct;

end; {procedure, SQLToControls}

{------------------------------------------------------------------------------}
{ TdaTablePage.OutOfSync }

function TdaTablePage.OutOfSync: Boolean;
begin
  Result := FSQL.TablesOutOfSync;
end; {procedure, OutOfSync}

{------------------------------------------------------------------------------}
{ TdaTablePage.Valid }

function TdaTablePage.Valid: Boolean;
begin
  Result := True;
end; {procedure, Valid}

{------------------------------------------------------------------------------}
{ TdaTablePage.ChildToAvailableItem }

procedure TdaTablePage.ChildToAvailableItem(aChild: TdaChild; aItem: TListItem);
var
  lTable: TdaTable;
begin

  lTable := TdaTable(aChild);

  aItem.Caption := lTable.TableAlias;

  if (aItem.SubItems.Count = 0) then
    aItem.SubItems.Add('');

  aItem.SubItems[0] := lTable.TableName;

end; {procedure, ChildToAvailableItem}

{------------------------------------------------------------------------------}
{ TdaTablePage.ChildToSelectedItem }

procedure TdaTablePage.ChildToSelectedItem(aChild: TdaChild; aItem: TListItem);
var
  lTable: TdaTable;
begin

  lTable := TdaTable(aChild);

  aItem.Caption := lTable.TableAlias;

  if (aItem.SubItems.Count = 0) then
    begin
      aItem.SubItems.Add('');
      aItem.SubItems.Add('');
      aItem.SubItems.Add('');
    end;

  aItem.SubItems[0] := lTable.TableName;
  aItem.SubItems[1] := lTable.SQLAlias;
  aItem.SubItems[2] := lTable.JoinTypeDesc;

end; {procedure, ChildToSelectedItem}

{------------------------------------------------------------------------------}
{ TdaTablePage.SelectItem }

function TdaTablePage.SelectItem(aAvailableIndex: Integer): TdaChild;
var
  liJoinIndex: Integer;
  lTable: TdaTable;
begin

  Result := nil;
  
  lTable := SQL.AvailableSelectTables[aAvailableIndex];

  if not(lTable.Joinable) and not(SQL.AllowManualJoins) then Exit;

  liJoinIndex := lTable.IndexOfFirstJoinTable(SQL);

  Result := SQL.SelectTable(aAvailableIndex, liJoinIndex);

end; {function, SelectItem}

{------------------------------------------------------------------------------}
{ TdaTablePage.DeselectItem }

function TdaTablePage.DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild;
begin
  Result := SQL.DeselectTable(aSelectedIndex);

  if (Result <> nil) then
    SQLToControls;
end; {procedure, DeselectItem}

{------------------------------------------------------------------------------}
{ TdaTablePage.GetAvailableChild }

function TdaTablePage.GetAvailableChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.AvailableTables[aIndex];
end; {function, GetAvailableChild}

{------------------------------------------------------------------------------}
{ TdaTablePage.GetAvailableChildCount }

function TdaTablePage.GetAvailableChildCount: Integer;
begin
  Result := SQL.AvailableTableCount;
end; {function, GetAvailableChildCount}

{------------------------------------------------------------------------------}
{ TdaTablePage.GetChildType }

function TdaTablePage.GetChildType: TdaChildType;
begin
  Result := dactSelectTable;
end; {function, GetChildType}

{------------------------------------------------------------------------------}
{ TdaTablePage.GetSelectedChild }

function  TdaTablePage.GetSelectedChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.SelectTables[aIndex];
end; {function, GetSelectedChild}

{------------------------------------------------------------------------------}
{ TdaTablePage.GetSelectedChildCount }

function  TdaTablePage.GetSelectedChildCount: Integer;
begin
  Result := SQL.SelectTableCount;
end; {function, GetSelectedChildCount}

{------------------------------------------------------------------------------}
{ TdaTablePage.DisplayEditControls }

procedure TdaTablePage.DisplayEditControls(aVisibility: Boolean);
begin
  if (FspbJoin <> nil) then
    FspbJoin.Parent.Visible := aVisibility;
end; {function, DisplayEditControls}

{------------------------------------------------------------------------------}
{ TdaTablePage.SelectedSelectItemEvent }

procedure TdaTablePage.SelectedSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  liLeft: Integer;
begin

  if FSettingControls then Exit;

  if (csDestroying in ComponentState) then Exit;

  {hide controls}
  if (Item = nil) or not(Selected) or (FSelectedTables.SelCount > 1) or
     ((Item <> nil) and (Item.Index = 0)) then
    begin
      DisplayEditControls(False);

      Exit;
    end;

  liLeft := FSelectedTables.Columns[0].Width;
  liLeft := liLeft + FSelectedTables.Columns[1].Width;
  liLeft := liLeft + FSelectedTables.Columns[2].Width;
  liLeft := liLeft + FSelectedTables.Columns[3].Width;

  if (FspbJoin <> nil) then
    begin
      FspbJoin.Parent.Left := liLeft - FspbJoin.Width;
      FspbJoin.Parent.Top := Item.Top +  FspbJoin.Height + 6;
    end;

  DisplayEditControls(True);

end; {procedure, SelectedSelectItemEvent}

{------------------------------------------------------------------------------}
{ TdaTablePage.DistinctClickEvent }

procedure TdaTablePage.DistinctClickEvent;
begin
  SQL.Distinct := FcbxDistinct.Checked;
  SQL.Modification;
end; {procedure, DistinctClickEvent}



{------------------------------------------------------------------------------}
{ TdaTablePage.JoinClickEvent }

procedure TdaTablePage.JoinClickEvent(Sender: TObject);
var
  lTable: TdaTable;
  lsTable1: String;
  lsTable2: String;
  lItem: TListItem;
begin

  if (FSelectedTables.Items.Count < 2) then Exit;

  lItem := FSelectedTables.Selected;

  if (lItem = nil) then Exit;

  lTable := SQL.SelectTables[lItem.Index];

  if (lTable.TableJoinCount = 0) then Exit;

  lsTable1 := lTable.TableJoins[0].ForeignField.TableSQLAlias;
  lsTable2 := lTable.SQLAlias;

  if SQL.EditTableJoin(lsTable1, lsTable2) then
    ChildToSelectedItem(FSQL.SelectTables[lItem.Index], lItem);

end; {procedure, JoinClickEvent}

{------------------------------------------------------------------------------}
{ TdaFieldPage.AliasIsRBAlias }

function TdaFieldPage.AliasIsRBAlias(const aAlias: String): Boolean;
var
  liIndex: Integer;
begin

  if (aAlias <> '') then
    begin
      liIndex := Pos('(', aAlias);
      Result := (aAlias[Length(aAlias)] = ')') and (liIndex > 0);
    end
  else
    Result := False;


end; {function, AliasIsRBAlias}

{******************************************************************************
 *
 ** F I E L D   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaFieldPage.PageName }

class function TdaFieldPage.PageName: String;
begin
  Result := ppLoadStr(763); {Fields}
end; {procedure, PageName}

{------------------------------------------------------------------------------}
{ TdaFieldPage.CreateControls }

procedure TdaFieldPage.CreateControls;
var
  lColumn: TListColumn;
  lBitmap: TBitmap;
{$IFNDEF Delphi5}
  lPanel: TPanel;
{$ENDIF}
begin

  AllowSorting := True;

  inherited CreateControls;
  TopList.OnCompare := ehTopList_Compare;

  TopLabel.Caption := ppLoadStr(727); {Available Fields}

  FAvailableFields := TopList;
  FAvailableFields.MultiSelect := True;

  lColumn := FAvailableFields.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := ppLoadStr(761); {Field Alias}

  lColumn := FAvailableFields.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := ppLoadStr(762); {Field SQL Alias}

  lColumn := FAvailableFields.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := ppLoadStr(835); {Table SQL Alias}

  lBitmap := TBitmap.Create;
{$IFNDEF Delphi5}
  lPanel := TPanel.Create(Self);
  lPanel.Parent := BottomPanel;
  lPanel.BevelOuter := bvNone;
  lPanel.Align := alRight;

  FcbxAllFields := TCheckBox.Create(Self);
  FcbxAllFields.Parent := lPanel;
  FcbxAllFields.Caption := ppLoadStr(718); {All Fields}
  FcbxAllFields.Left := 0;
  FcbxAllFields.Top := 1;

  lPanel.Width := lBitmap.Canvas.TextWidth(FcbxAllFields.Caption) + 30;
{$ELSE}

  FcbxAllFields := TCheckBox.Create(Self);
  FcbxAllFields.Parent := BottomPanel;
  FcbxAllFields.Caption := ppLoadStr(718); {All Fields}
  FcbxAllFields.Top := 3;
  FcbxAllFields.Width := lBitmap.Canvas.TextWidth(FcbxAllFields.Caption) + 30;
  FcbxAllFields.Left := BottomPanel.Width - (FcbxAllFields.Width + 10);
  FcbxAllFields.Anchors := [akTop, akRight];

{$ENDIF}
  lBitmap.Free;

  FcbxAllFields.OnClick := AllFieldsClickEvent;

  BottomLabel.Caption := ppLoadStr(823); {Selected Fields}

  FSelectedFields := BottomList;

  FSelectedFields.OnEdited := SelectedEditedEvent;
  FSelectedFields.OnEditing := SelectedEditingEvent;

  if not(SelectedReadOnly) then
    FSelectedFields.PopupMenu := CreatePopupMenu;
  

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaFieldPage.SelectedReadOnly }

function TdaFieldPage.SelectedReadOnly: Boolean;
begin
  Result := False;
end; {procedure, SelectedReadOnly}

{------------------------------------------------------------------------------}
{ TdaFieldPage.CreateSelectedColumns }

procedure TdaFieldPage.CreateSelectedColumns(aSelectedList: TppListView);
var
  lColumn: TListColumn;
begin

  inherited CreateSelectedColumns(aSelectedList);
  
  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := ppLoadStr(761); {Field Alias}

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := ppLoadStr(762); {Field SQL Alias}

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := ppLoadStr(835); {Table SQL Alias}

end; {procedure, CreateSelectedColumns}

{------------------------------------------------------------------------------}
{ TdaFieldPage.SQLToControls }

procedure TdaFieldPage.SQLToControls;
begin

  inherited SQLToControls;

  {if all fields selected, check checkbox}
  FcbxAllFields.Checked := (GetAvailableChildCount = 0);

end; {procedure, SQLToControls}

{------------------------------------------------------------------------------}
{ TdaFieldPage.OutOfSync }

function TdaFieldPage.OutOfSync: Boolean;
begin
  Result := True;
end; {procedure, OutOfSync}

{------------------------------------------------------------------------------}
{ TdaFieldPage.Valid }

function TdaFieldPage.Valid: Boolean;
begin
  Result := True;
end; {procedure, Valid}

{------------------------------------------------------------------------------}
{ TdaFieldPage.GetAvailableChild }

function TdaFieldPage.GetAvailableChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.AvailableSelectFields[aIndex];
  Result.Tag := aIndex;
end; {procedure, GetAvailableChild}

{------------------------------------------------------------------------------}
{ TdaFieldPage.GetAvailableChildCount }

function TdaFieldPage.GetAvailableChildCount: Integer;
begin
  Result := SQL.AvailableSelectFieldCount;
end; {procedure, GetAvailableChildCount}

{------------------------------------------------------------------------------}
{ TdaFieldPage.GetChildType }

function TdaFieldPage.GetChildType: TdaChildType;
begin
  Result := dactSelectField;
end; {function, GetChildType}

{------------------------------------------------------------------------------}
{ TdaFieldPage.GetSelectedChild }

function TdaFieldPage.GetSelectedChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.SelectFields[aIndex];
end; {procedure, GetSelectedChild}

{------------------------------------------------------------------------------}
{ TdaFieldPage.GetSelectedChildCount }

function TdaFieldPage.GetSelectedChildCount: Integer;
begin
  Result := SQL.SelectFieldCount;
end; {procedure, GetSelectedChildCount}

{------------------------------------------------------------------------------}
{ TdaFieldPage.ChildToAvailableItem }

procedure TdaFieldPage.ChildToAvailableItem(aChild: TdaChild; aItem: TListItem);
var
  lField: TdaField;
begin

  lField := TdaField(aChild);

  aItem.Data := lField;

  if (lField is TdaCalculation) then
    aItem.Caption := lField.Alias
  else
    aItem.Caption := lField.FieldAlias;
    
  aItem.SubItems.Add(lField.SelectSQLString);
  aItem.SubItems.Add(lField.TableSQLAlias);

end; {function, ChildToAvailableItem}

{------------------------------------------------------------------------------}
{ TdaFieldPage.ChildToSelectedItem }

procedure TdaFieldPage.ChildToSelectedItem(aChild: TdaChild; aItem: TListItem);
var
  lField: TdaField;
begin

  lField := TdaField(aChild);

  aItem.Data := lField;
  
  aItem.Caption := lField.Alias;

  if (aItem.SubItems.Count = 0) then
    begin
      aItem.SubItems.Add('');
      aItem.SubItems.Add('');
    end;

  aItem.SubItems[0] := lField.SelectSQLString;
  aItem.SubItems[1] := lField.TableSQLAlias;
  
end; {procedure, ChildToSelectedItem}

{------------------------------------------------------------------------------}
{ TdaFieldPage.SelectItem }

function TdaFieldPage.SelectItem(aAvailableIndex: Integer): TdaChild;
var
  lField: TdaField;
  liIndex: Integer;
begin

  if TopList.Items[aAvailableIndex].Data <> nil then
    begin  
      lField := TdaField(TopList.Items[aAvailableIndex].Data);
      liIndex := FSQL.FindAvailableField(lField.TableAlias, lField.FieldName);
    end
  else
    liIndex := aAvailableIndex;

  Result := FSQL.SelectField(liIndex);

  FcbxAllFields.Checked := (SQL.AvailableSelectFieldCount = 0);

end; {function, SelectItem}

{------------------------------------------------------------------------------}
{ TdaFieldPage.DeselectItem }

function TdaFieldPage.DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild;
begin

  Result := FSQL.DeselectField(aSelectedIndex);

  FcbxAllFields.Checked := False;

end; {procedure, DeselectItem}

{------------------------------------------------------------------------------}
{ TdaFieldPage.AvailableColumnClickEvent }

procedure TdaFieldPage.AvailableColumnClickEvent(Sender: TObject; Column: TListColumn);
begin

  // set available list sort mode
  if (Column.Index = 0) then
    begin
      if (TopList.SortMode = 0) then
        TopList.SortMode := 1
      else if (TopList.SortMode = 1) then
        TopList.SortMode := -1
      else
        TopList.SortMode := 0;
    end

  else if (TopList.SortMode = (Column.Index + 1)) then
    TopList.SortMode := TopList.SortMode * -1

  else
    TopList.SortMode := Column.Index + 1;

  // sort avaialble list
  TopList.Sort; // this triggers ehTopList_Compare method

  // update column captions to reflect sort mode
  UpdateAvailableColumnCaptions;

end; {procedure, AvailableColumnClickEvent}

{------------------------------------------------------------------------------}
{ TdaFieldPage.SelectedEditedEvent }

procedure TdaFieldPage.SelectedEditedEvent(Sender: TObject; Item: TListItem; var S: String);
var
  lField: TdaField;
begin
  if FSettingControls then Exit;

  lField := TdaField(GetSelectedChild(Item.Index));

  lField.Alias := S;

  if SQL.ValidateFieldAlias(lField, False) then
    begin
      lField.Alias := S;

      Self.SQLOutOfSync := True;
    end
  else
    begin
      S := Item.Caption;

      lField.Alias := S;
    end;

end; {procedure, SelectedEditedEvent}

{------------------------------------------------------------------------------}
{ TdaFieldPage.AllFieldsClickEvent }

procedure TdaFieldPage.AllFieldsClickEvent(Sender: TObject);
begin

  if (Selecting or Deselecting) then Exit;

  if FcbxAllFields.Checked then
    SelectAllItems
  else
    DeselectAllItems;

end; {procedure, AllFieldsClickEvent}

function TdaFieldPage.CreatePopupMenu: TppPopupMenuBase;
var
  lPopupMenu: TppPopupMenuBase;
  lMenuItem: TppTBXItem;
begin

  lPopupMenu := TppPopupMenuBase.Create(Self);

  lMenuItem := lPopupMenu.AddChildItem();
  lMenuItem.Caption := ppLoadStr(542); {Rename}
  lMenuItem.OnClick := RenamListItemEvent;

  Result := lPopupMenu;

end;

procedure TdaFieldPage.ehTopList_Compare(Sender: TObject; aItem1, aItem2: TListItem; aData: Integer; var aCompare: Integer);
var
  lField1: TdaField;
  lField2: TdaField;
begin

  //sort in selected order
  if (TopList.SortMode = 0) then
    begin
      lField1 := TdaField(aItem1.Data);
      lField2 := TdaField(aItem2.Data);

      // Field.tag holds the original order
      if (lField1.Tag > lField2.Tag) then
        aCompare := 1
      else
        aCompare := -1;

    end
  else if TopList.SortMode = 1 then
    aCompare := CompareText(aItem1.Caption, aItem2.Caption)
  else if TopList.SortMode = -1 then
    aCompare := CompareText(aItem2.Caption, aItem1.Caption)
  else if TopList.SortMode > 0 then
    aCompare := CompareText(aItem1.SubItems[TopList.SortMode-2], aItem2.SubItems[TopList.SortMode-2])
  else // TopList.SortMode < 0
    aCompare := CompareText(aItem2.SubItems[Abs(TopList.SortMode)-2], aItem1.SubItems[Abs(TopList.SortMode)-2]);

end;

{------------------------------------------------------------------------------}
{ TdaFieldPage.RenamListItemEvent }

procedure TdaFieldPage.RenamListItemEvent(Sender: TObject);
begin

  if not(SelectedReadOnly) and (FSelectedFields.Selected <> nil) then
    FSelectedFields.Selected.EditCaption;

end;

{------------------------------------------------------------------------------}
{ TdaFieldPage.ShowInvalidExpressionLabel }

procedure TdaFieldPage.ShowInvalidExpressionLabel(aShow: Boolean);
var
  lPanel: TPanel;
begin

  if (aShow) then
    begin
      if (FlblInvalidExpression = nil) then
        begin
          lPanel := BottomPanel;

          if (lPanel <> nil) then
            begin
              FlblInvalidExpression := TLabel.Create(Self);
              FlblInvalidExpression.Parent := lPanel;
              FlblInvalidExpression.Top := 4;
              FlblInvalidExpression.Left := 4;
              FlblInvalidExpression.Caption := 'Expression cannot contain alias';
              FlblInvalidExpression.Font.Color := clRed;
            end;
        end;
    end

  else
    begin
      FlblInvalidExpression.Free;
      FlblInvalidExpression := nil;
    end;

end; {procedure, ShowInvalidExpressionLabel}

procedure TdaFieldPage.UpdateAvailableColumnCaptions;
var
  lsSortDesc: string;
  liIndex: Integer;
begin

  TopList.Columns[0].Caption := ppLoadStr(761); {Field Alias}
  TopList.Columns[1].Caption := ppLoadStr(762); {Field SQL Alias}
  TopList.Columns[2].Caption := ppLoadStr(835); {Table SQL Alias}

  if TopList.SortMode = 0 then
    lsSortDesc := ''
  else if TopList.SortMode > 0 then
    lsSortDesc := ' ' + ppLoadStr(515) {(a > z)}
  else
    lsSortDesc := ' ' + ppLoadStr(520); {(z > a)}

  if TopList.SortMode = 0 then
    liIndex := 0
  else if TopList.SortMode > 0 then
    liIndex := TopList.SortMode - 1
  else
    liIndex := Abs(TopList.SortMode) - 1;

  TopList.Columns[liIndex].Caption := TopList.Columns[liIndex].Caption + lsSortDesc;


end;

{******************************************************************************
 *
 ** C A L C   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaCalcPage.PageName }

class function TdaCalcPage.PageName: String;
begin
  Result := ppLoadStr(735); {Calcs}
end; {procedure, PageName}

{------------------------------------------------------------------------------}
{ TdaCalcPage.ImageIndex }

class function TdaCalcPage.ImageIndex: Integer;
begin
  Result := ToolImageList.AddTool('DACALCS');
end;

{------------------------------------------------------------------------------}
{ TdaCalcPage.CreateControls }

procedure TdaCalcPage.CreateControls;
begin

  inherited CreateControls;

  FResizing := False;

  MoveSelectedItems := False;

  TopLabel.Caption := ppLoadStr(727); {Available Fields}

  BottomLabel.Caption := ppLoadStr(737); {Calculations}

  CheckBox.OnClick := nil;
  CheckBox.Visible := False;

  FcbxFunction := TComboBox.Create(Self);
  FcbxFunction.Parent := BottomPanel.Parent;
  FcbxFunction.Style := csDropDown;
  FcbxFunction.Top := 3;
  FcbxFunction.Width := 150;
  FcbxFunction.Visible := False;

  FcbxFunction.OnChange := CalcTypeChangeEvent;

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaCalcPage.CreateSelectedColumns }

procedure TdaCalcPage.CreateSelectedColumns(aSelectedList: TppListView);
begin

  inherited CreateSelectedColumns(aSelectedList);

  aSelectedList.Columns[2].Caption := ppLoadStr(766); {Function}
  aSelectedList.Columns[2].Width := 150;

end; {procedure, CreateSelectedColumns}

{------------------------------------------------------------------------------}
{ TdaCalcPage.OutOfSync }

function TdaCalcPage.OutOfSync: Boolean;
begin
  Result := FSQL.CalcFieldsOutOfSync;
end; {function, OutOfSync}

{------------------------------------------------------------------------------}
{ TdaCalcPage.Valid }

function TdaCalcPage.Valid: Boolean;
begin
  Result := True;
end; {function, Valid}

{------------------------------------------------------------------------------}
{ TdaCalcPage.DisplayEditControls }

procedure TdaCalcPage.DisplayEditControls(aVisibility: Boolean);
begin
  FcbxFunction.Visible := aVisibility;
end; {procedure, DisplayEditControls}

{------------------------------------------------------------------------------}
{ TdaCalcPage.SelectedSelectItemEvent }

procedure TdaCalcPage.SelectedSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  lCalc: TdaCalculation;
  lCalcType: TdaCalcType;
begin
  if FSettingControls then Exit;

  if (csDestroying in ComponentState) then Exit;

  if not(FNotebook.ActivePage = FPage) then Exit;


  if (Item = nil) or not(Selected) then
    DisplayEditControls(False)
    
  else
    begin
      CalcEditControlPosition(FcbxFunction, Item, 2);

      lCalc := SQL.CalcFields[Item.Index];

      //Populate the function combo box.
      FcbxFunction.Items.Clear;
      for lCalcType := dacaAvg to dacaExpression do
        if lCalcType = dacaExpression then
          FcbxFunction.Items.Add(ppLoadStr(759)) // Expression
        else
          FcbxFunction.Items.Add(lCalc.GetDescription(lCalcType));

      if lCalc.CalcType = dacaExpression then
        FcbxFunction.Text := lCalc.Expression
      else
        FcbxFunction.ItemIndex := Ord(lCalc.CalcType);

     // removed this, to allow using keyboard arrows to traverse list of items
     // FcbxFunction.SetFocus;
    end;

end; {procedure, SelectedSelectItemEvent}

{------------------------------------------------------------------------------}
{ TdaCalcPage.SelectedResizeEvent }

procedure TdaCalcPage.SelectedResizeEvent(Sender: TObject);
var
  liTotalColumnWidth: Integer;
  liTotalColumnWidth2: Integer;
  liListViewWidth: Integer;
  liIndex: Integer;
begin

  if FSettingControls then Exit;

  if (FResizing) then Exit;

  // this line fixes a weird bug in the display of the calc page
  if (FSelectedFields.Items.Count = 0) then Exit;

  FResizing := True;

  liTotalColumnWidth := 0;
  for liIndex := 0 to FSelectedFields.Columns.Count - 1 do
    liTotalColumnWidth := liTotalColumnWidth + FSelectedFields.Columns[liIndex].Width;

  liTotalColumnWidth2 := 0;
  for liIndex := 0 to FSelectedFields.Columns.Count - 2 do
    liTotalColumnWidth2 := liTotalColumnWidth2 + FSelectedFields.Columns[liIndex].Width;


  liListViewWidth := FSelectedFields.Width;

  if (liListViewWidth <= liTotalColumnWidth) then
    FSelectedFields.Columns[2].Width := 100
  else
    FSelectedFields.Columns[2].Width := (liListViewWidth - liTotalColumnWidth2) - 4;

  if (FSelectedFields.Selected <> nil) then
    CalcEditControlPosition(FcbxFunction, FSelectedFields.Selected, 2);

  FResizing := False;

end; {procedure, SelectedResizeEvent}

{------------------------------------------------------------------------------}
{ TdaCalcPage.GetAvailableChild }

function TdaCalcPage.GetAvailableChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.AvailableCalcFields[aIndex];
  Result.Tag := aIndex;
end; {function, GetAvailableChild}

{------------------------------------------------------------------------------}
{ TdaCalcPage.GetAvailableChildCount }

function TdaCalcPage.GetAvailableChildCount: Integer;
begin
  Result := SQL.AvailableCalcFieldCount;
end; {function, AvailableChildCount}

{------------------------------------------------------------------------------}
{ TdaCalcPage.GetChildType }

function TdaCalcPage.GetChildType: TdaChildType;
begin
  Result := dactCalcField;
end; {function, GetChildType}

{------------------------------------------------------------------------------}
{ TdaCalcPage.GetSelectedChild }

function TdaCalcPage.GetSelectedChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.CalcFields[aIndex];
end; {function, GetSelectedChild}

{------------------------------------------------------------------------------}
{ TdaCalcPage.GetSelectedChildCount }

function TdaCalcPage.GetSelectedChildCount: Integer;
begin
  Result := SQL.CalcFieldCount;
end; {function, GetSelectedChildCount}

{------------------------------------------------------------------------------}
{ TdaCalcPage.ChildToSelectedItem }

procedure TdaCalcPage.ChildToSelectedItem(aChild: TdaChild; aItem: TListItem);
var
  lCalculation: TdaCalculation;
begin

  lCalculation := TdaCalculation(aChild);

  aItem.Caption := lCalculation.Alias;

  if (aItem.SubItems.Count = 0) then
    begin
      aItem.SubItems.Add('');
      aItem.SubItems.Add('');
    end;

  aItem.SubItems[0] := lCalculation.SelectSQLString;

  if (lCalculation.CalcType = dacaExpression) then
    aItem.SubItems[1] := lCalculation.Expression
  else
    aItem.SubItems[1] := lCalculation.Description;

end; {procedure, ChildToSelectedItem}

{------------------------------------------------------------------------------}
{ TdaCalcPage.SelectItem }

function TdaCalcPage.SelectItem(aAvailableIndex: Integer): TdaChild;
var
  lField: TdaField;
  liIndex: Integer;
  lCalcFields: TdaSQLCalcFields;
begin

  if TopList.Items[aAvailableIndex].Data <> nil then
    begin
      lField := TdaField(TopList.Items[aAvailableIndex].Data);

      lCalcFields := TdaSQLCalcFields.Create(FSQL);

      liIndex := lCalcFields.IndexOfAvailable(lField.TableAlias, lField.FieldName);
      lCalcFields.Free;
    end
  else
    liIndex := aAvailableIndex;

  Result := SQL.SelectCalcField(liIndex);


end; {function, SelectItem}

{------------------------------------------------------------------------------}
{ TdaCalcPage.DeselectItem }

function TdaCalcPage.DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild;
begin
  Result := SQL.DeselectCalcField(aSelectedIndex);

  FcbxFunction.Visible := False;
end; {procedure, DeselectItem}

{------------------------------------------------------------------------------}
{ TdaCalcPage.CalcTypeChangeEvent }

procedure TdaCalcPage.CalcTypeChangeEvent(Sender: TObject);
var
  lItem: TListItem;
  lCalc: TdaCalculation;
  lbInvalid: Boolean;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  lCalc := SQL.CalcFields[lItem.Index];

  if (FcbxFunction.ItemIndex = -1) then
    lCalc.CalcType := dacaExpression
  else
    lCalc.CalcType := TdaCalcType(FcbxFunction.ItemIndex);

  if (lCalc.CalcType = dacaExpression) then
    begin
      {Warn if Expression contains " AS "}
      lbInvalid := False;

      daRemoveInvalidAliasing(FcbxFunction.Text, lbInvalid);

      ShowInvalidExpressionLabel(lbInvalid);

      // align the label with the combo box
      if FlblInvalidExpression <> nil then
        FlblInvalidExpression.Left := FcbxFunction.Left;

      lCalc.Expression := FcbxFunction.Text;
    end;

  lCalc.GenerateSQLFieldName;
  lCalc.Alias := lCalc.SQLFieldName;

  FSQL.ValidateFieldAlias(lCalc, True);
  FSQL.Modification;

  ChildToSelectedItem(lCalc, lItem);

end; {procedure, CalcTypeChangeEvent}


{******************************************************************************
 *
 ** G R O U P   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaGroupPage.PageName }

class function TdaGroupPage.PageName: String;
begin
  Result := ppLoadStr(767); {Groups}
end; {procedure, PageName}

{------------------------------------------------------------------------------}
{ TdaGroupPage.ImageIndex }

class function TdaGroupPage.ImageIndex: Integer;
begin
  Result := ToolImageList.AddTool('DAGROUP');
end;

{------------------------------------------------------------------------------}
{ TdaGroupPage.CreateControls }

procedure TdaGroupPage.CreateControls;
begin

  inherited CreateControls;

  FcbxAllFields.Visible := False;

  TopLabel.Caption := ppLoadStr(727); {Available Fields}

  BottomLabel.Caption := ppLoadStr(769); {Group Fields}

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaGroupPage.SelectedReadOnly }

function TdaGroupPage.SelectedReadOnly: Boolean;
begin
  Result := True;
end; {procedure, SelectedReadOnly}

{------------------------------------------------------------------------------}
{ TdaGroupPage.SQLToControls }

procedure TdaGroupPage.SQLToControls;
begin

  inherited SQLToControls;

  {if all fields selected, check checkbox}
  CheckBox.Checked := (SQL.AvailableGroupByFieldCount = 0);

end; {procedure, SQLToControls}

{------------------------------------------------------------------------------}
{ TdaGroupPage.OutOfSync }

function TdaGroupPage.OutOfSync: Boolean;
begin
  Result := FSQL.GroupByFieldsOutOfSync;
end; {procedure, OutOfSync}

{------------------------------------------------------------------------------}
{ TdaGroupPage.Valid }

function TdaGroupPage.Valid: Boolean;
begin
  Result := True;
end; {procedure, Valid}

{------------------------------------------------------------------------------}
{ TdaGroupPage.GetAvailableChild }

function TdaGroupPage.GetAvailableChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.AvailableGroupByFields[aIndex];
  Result.Tag := aIndex;
end; {function, GetAvailableChild}

{------------------------------------------------------------------------------}
{ TdaGroupPage.GetAvailableChildCount }

function TdaGroupPage.GetAvailableChildCount: Integer;
begin
  Result := SQL.AvailableGroupByFieldCount;
end; {function, GetAvailableChildCount}

{------------------------------------------------------------------------------}
{ TdaGroupPage.GetChildType }

function TdaGroupPage.GetChildType: TdaChildType;
begin
  Result := dactGroupByField;
end; {function, GetChildType}

{------------------------------------------------------------------------------}
{ TdaGroupPage.GetSelectedChild }

function TdaGroupPage.GetSelectedChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.GroupByFields[aIndex];
end; {function, GetSelectedChild}

{------------------------------------------------------------------------------}
{ TdaGroupPage.GetSelectedChildCount }

function TdaGroupPage.GetSelectedChildCount: Integer;
begin
  Result := SQL.GroupByFieldCount;
end; {function, GetSelectedChildCount}

{------------------------------------------------------------------------------}
{ TdaGroupPage.SelectItem }

function TdaGroupPage.SelectItem(aAvailableIndex: Integer): TdaChild;
var
  lField: TdaField;
  liIndex: Integer;
  lGroupFields: TdaSQLGroupByFields;
begin

  if TopList.Items[aAvailableIndex].Data <> nil then
    begin
      lField := TdaField(TopList.Items[aAvailableIndex].Data);

      lGroupFields := TdaSQLGroupByFields.Create(FSQL);

      if (lField is TdaCalculation) then
        liIndex := lGroupFields.IndexOfAvailable(lField.TableAlias, TdaCalculation(lField).SQLFieldName)
      else
        liIndex := lGroupFields.IndexOfAvailable(lField.TableAlias, lField.FieldName);

      lGroupFields.Free;
    end
  else
    liIndex := aAvailableIndex;

  Result := SQL.SelectGroupByField(liIndex);


  CheckBox.Checked := (SQL.AvailableGroupByFieldCount = 0);

//  if (SQL.GroupByFieldCount = 1) then
//    FNotebook.SetTabVisible(5, True);


end; {function, SelectItem}

{------------------------------------------------------------------------------}
{ TdaGroupPage.DeselectItem }

function TdaGroupPage.DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild;
begin

  Result := SQL.DeselectGroupByField(aSelectedIndex);

  aValid := (Result <> nil);

  CheckBox.Checked := False;

//  if (SQL.GroupByFieldCount = 0) then
//    FNotebook.SetTabVisible(5, False);

end; {procedure, DeselectItem}



{******************************************************************************
 *
 ** S E A R C H   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSearchPage.PageName }

class function TdaSearchPage.PageName: String;
begin
  Result := ppLoadStr(818); {Search}
end; {procedure, PageName}

{------------------------------------------------------------------------------}
{ TdaSearchPage.ImageIndex }

class function TdaSearchPage.ImageIndex: Integer;
begin
  Result := ToolImageList.AddTool('DASEARCH');
end;

{------------------------------------------------------------------------------}
{ TdaSearchPage.CreateControls }

procedure TdaSearchPage.CreateControls;
var
  lOperator: TdaCriteriaOperatorType;
  lPopupMenu: TppPopupMenuBase;
begin

  FResizing := False;

  inherited CreateControls;

  MoveSelectedItems := False;

  TopLabel.Caption := ppLoadStr(727); {Available Fields}

  BottomLabel.Caption := ppLoadStr(741); {Criteria}

  CheckBox.OnClick := nil;
  CheckBox.Visible := False;

  FcbxAutoSearch := TCheckBox.Create(Self);
  FcbxAutoSearch.Parent := BottomPanel.Parent;
  FcbxAutoSearch.Color := clWhite;
  FcbxAutoSearch.Top := 3;
  FcbxAutoSearch.Width := 17;
  FcbxAutoSearch.Visible := False;
  FcbxAutoSearch.OnClick := AutoSearchClickEvent;

  FcbxMandatory := TCheckBox.Create(Self);
  FcbxMandatory.Parent := BottomPanel.Parent;
  FcbxMandatory.Color := clWhite;
  FcbxMandatory.Top := 3;
  FcbxMandatory.Width := 17;
  FcbxMandatory.Visible := False;
  FcbxMandatory.OnClick := MandatoryClickEvent;

  FcbxShowAll := TCheckBox.Create(Self);
  FcbxShowAll.Parent := BottomPanel.Parent;
  FcbxShowAll.Color := clWhite;
  FcbxShowAll.Top := 3;
  FcbxShowAll.Width := 17;
  FcbxShowAll.Visible := False;
  FcbxShowAll.OnClick := ShowAllClickEvent;

  FcbxOperator := TComboBox.Create(Self);
  FcbxOperator.Parent := BottomPanel.Parent;
  FcbxOperator.Style := csDropDownList;
  FcbxOperator.Top := 3;
  FcbxOperator.Width := 100;
  FcbxOperator.Visible := False;

  for lOperator := Low(TdaCriteriaOperatorType) to High(TdaCriteriaOperatorType) do
    FcbxOperator.Items.Add(daGetOperatorDesc(lOperator));

  FcbxOperator.OnChange := OperatorChangeEvent;

  FcbxParameter := TComboBox.Create(Self);
  FcbxParameter.Parent := BottomPanel.Parent;
  FcbxParameter.Style := csDropDownList;
  FcbxParameter.Top := 3;
  FcbxParameter.Width := 100;
  FcbxParameter.Visible := False;

  // populate cbxParameter with report param names
  if (SQL <> nil) and (SQL.ReportParameters <> nil) then
    SQL.ReportParameters.GetVisibleNames(FcbxParameter.Items);

  FcbxParameter.Items.Add(ppLoadStr(343)); {<None>}

  FcbxParameter.OnChange := ParameterChangeEvent;

  FedtValue := TEdit.Create(Self);
  FedtValue.Parent := BottomPanel.Parent;
  FedtValue.Top := 3;
  FedtValue.Width := 100;
  FedtValue.Visible := False;

  FedtValue.OnChange := ComparisonChangeEvent;

  lPopupMenu := CreatePopupMenu;

  FAvailableFields.PopupMenu := lPopupMenu;
  FSelectedFields.PopupMenu := lPopupMenu;


end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaSearchPage.SelectedReadOnly }

function TdaSearchPage.SelectedReadOnly: Boolean;
begin
  Result := False;
end; {procedure, SelectedReadOnly}

{------------------------------------------------------------------------------}
{ TdaSearchPage.SelectedMultiSelect }

function TdaSearchPage.SelectedMultiSelect: Boolean;
begin
  Result := True;
end; {procedure, SelectedMultiSelect}


{------------------------------------------------------------------------------}
{ TdaSearchPage.SelectedEditedEvent }

procedure TdaSearchPage.SelectedEditedEvent(Sender: TObject; Item: TListItem; var S: String);
var
  lCriteria: TdaCriteria;
begin

  if FSettingControls then Exit;

  lCriteria := TdaCriteria(GetSelectedChild(Item.Index));

  lCriteria.Expression := S;

end;  {procedure, SelectedMultiSelect}

{------------------------------------------------------------------------------}
{ TdaSearchPage.CreateSelectedColumns }

procedure TdaSearchPage.CreateSelectedColumns(aSelectedList: TppListView);
var
  lColumn: TListColumn;
begin

  inherited CreateSelectedColumns(aSelectedList);

  aSelectedList.Columns[0].Caption := ppLoadStr(760); {Field}
  aSelectedList.Columns[1].Caption := ppLoadStr(802); {Operator}
  aSelectedList.Columns[2].Caption := ppLoadStr(837); {Value}

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := {ppLoadStr(841)}'Parameter'; {'Parameter'} //TODO Localize

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 75;
  lColumn.Caption := ppLoadStr(841); {'AutoSearch'}

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 75;
  lColumn.Caption := ppLoadStr(842); {'Mandatory'}

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 75;
  lColumn.Caption := ppLoadStr(846); {'Show All'}

end; {procedure, CreateSelectedColumns}

{------------------------------------------------------------------------------}
{ TdaSearchPage.PopupMenuPopupEvent }

procedure TdaSearchPage.PopupMenuPopupEvent(Sender: TObject);
var
  lPopupMenu: TppPopupMenuBase;
begin

  lPopupMenu := TppPopupMenuBase(Sender);

  lPopupMenu.Items[0].Enabled := False; {Insert Criteria}
  lPopupMenu.Items[1].Enabled := False; {Insert OR}
  lPopupMenu.Items[2].Enabled := False; {Insert NOT}
  lPopupMenu.Items[4].Enabled := False; {Remove}
  lPopupMenu.Items[6].Enabled := False; {Add Parentheses}
  lPopupMenu.Items[7].Enabled := False; {Remove Parentheses}

  if FAvailableFields.Focused then
    lPopupMenu.Items[0].Enabled := (FAvailableFields.Selected <> nil) {Insert Criteria}

  else if FSelectedFields.Focused then
    begin
      lPopupMenu.Items[0].Enabled := (FAvailableFields.Selected <> nil); {Insert Criteria}

      if (FSelectedFields.Selected = nil) then Exit;

      lPopupMenu.Items[1].Enabled := True; {Insert OR}
      lPopupMenu.Items[2].Enabled := True; {Insert NOT}
      lPopupMenu.Items[4].Enabled := True; {Remove}

      lPopupMenu.Items[6].Enabled := True; {Add Parentheses}
      lPopupMenu.Items[7].Enabled := True; {Remove Parentheses}
    end;

end; {procedure, PopupMenuPopupEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.OutOfSync }

function TdaSearchPage.OutOfSync: Boolean;
begin
  Result := FSQL.CriteriaOutOfSync;
end; {procedure, OutOfSync}

{------------------------------------------------------------------------------}
{ TdaSearchPage.Valid }

function TdaSearchPage.Valid: Boolean;
begin
  Result := True;
end; {procedure, Valid}

{------------------------------------------------------------------------------}
{ TdaSearchPage.GetChildType }

function TdaSearchPage.GetChildType: TdaChildType;
begin
  Result := dactCriteria;
end; {function, GetChildType}

{------------------------------------------------------------------------------}
{ TdaSearchPage.ChildToSelectedItem }

procedure TdaSearchPage.ChildToSelectedItem(aChild: TdaChild; aItem: TListItem);
var
  lField: TdaField;
  lCriteria: TdaCriteria;
begin

  if (aChild is TdaField) then
    begin
      lField := TdaField(aChild);

      if (lField is TdaCalculation) then
        aItem.Caption := lField.Alias
      else
        aItem.Caption := lField.FieldAlias;
    end
  else
    begin
      lCriteria := TdaCriteria(aChild);

      if (lCriteria.CriteriaType = dacrField) then
        begin

          if (lCriteria.IsExpression) then
            aItem.Caption := lCriteria.Expression
          else
            aItem.Caption := lCriteria.Field.SQLString;

          if (aItem.SubItems.Count = 0) then
            begin
              aItem.SubItems.Add('');
              aItem.SubItems.Add('');
              aItem.SubItems.Add('');
              aItem.SubItems.Add('');
              aItem.SubItems.Add('');
              aItem.SubItems.Add('');
            end;

          aItem.SubItems[0] := lCriteria.OperatorDesc;
          aItem.SubItems[1] := lCriteria.Value;
          aItem.SubItems[2] := lCriteria.ParamName;
          aItem.SubItems[3] := lCriteria.AutoSearchDesc;
          aItem.SubItems[4] := lCriteria.MandatoryDesc;
          aItem.SubItems[5] := lCriteria.ShowAllDesc;
        end
      else
        aItem.Caption := lCriteria.Description;

    end;

end; {function, ChildToSelectedItem}

{------------------------------------------------------------------------------}
{ TdaSearchPage.GetAvailableChild }

function TdaSearchPage.GetAvailableChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.AvailableCriteria[aIndex];
  Result.Tag := aIndex;
end; {function, GetAvailableChild}

{------------------------------------------------------------------------------}
{ TdaSearchPage.GetAvailableChildCount }

function TdaSearchPage.GetAvailableChildCount: Integer;
begin
  Result := SQL.AvailableCriteriaCount;
end; {function, AvailableChildCount}

{------------------------------------------------------------------------------}
{ TdaSearchPage.GetSelectedChild }

function TdaSearchPage.GetSelectedChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.Criteria[aIndex];
end; {function, GetSelectedChild}

{------------------------------------------------------------------------------}
{ TdaSearchPage.GetSelectedChildCount }

function TdaSearchPage.GetSelectedChildCount: Integer;
begin
  Result := SQL.CriteriaCount;
end; {function, GetSelectedChildCount}

{------------------------------------------------------------------------------}
{ TdaSearchPage.SelectItem}

function TdaSearchPage.SelectItem(aAvailableIndex: Integer): TdaChild;
var
  lField: TdaField;
  liIndex: Integer;
  lSearchCriteria: TdaSQLCriteriaList;
begin

  if TopList.Items[aAvailableIndex].Data <> nil then
    begin
      lField := TdaField(TopList.Items[aAvailableIndex].Data);

      lSearchCriteria := TdaSQLCriteriaList.Create(FSQL);

      if (lField is TdaCalculation) then
        liIndex := lSearchCriteria.IndexOfAvailable(lField.TableAlias, TdaCalculation(lField).SQLFieldName)
      else
        liIndex := lSearchCriteria.IndexOfAvailable(lField.TableAlias, lField.FieldName);

      lSearchCriteria.Free;
    end
  else
    liIndex := aAvailableIndex;

  Result := SQL.SelectCriteria(liIndex);

end; {function, SelectItem}

{------------------------------------------------------------------------------}
{ TdaSearchPage.DeselectItem }

function TdaSearchPage.DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild;
begin
  Result := nil;

  RemoveCriteriaClickEvent(Self);
end; {function, DeselectItem}

{------------------------------------------------------------------------------}
{ TdaSearchPage.DisplayEditControls }

procedure TdaSearchPage.DisplayEditControls(aVisibility: Boolean);
begin
  FcbxOperator.Visible := aVisibility;
  FedtValue.Visible := aVisibility;
  FcbxAutoSearch.Visible := aVisibility;
  FcbxMandatory.Visible := aVisibility;
  FcbxShowAll.Visible := aVisibility;
  FcbxParameter.Visible := aVisibility;
end; {procedure, DisplayEditControls}

{------------------------------------------------------------------------------}
{ TdaSearchPage.SelectedSelectItemEvent }

procedure TdaSearchPage.SelectedSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  lItem: TListItem;
  lCriteria: TdaCriteria;
begin

  if FSettingControls then Exit;

  if (csDestroying in ComponentState) then Exit;
  
  {build selection list}
  FSelectionList.Clear;

  if (Item = nil) or not(Selected) or (FSelectedFields.SelCount > 1) then
    begin
      lItem := FSelectedFields.Selected;

      while (lItem <> nil) do
        begin
          FSelectionList.Add(lItem);

          lItem := FSelectedFields.GetNextItem(lItem, sdAll, [isSelected]);
        end;

    end
  else
    FSelectionList.Add(Item);

  {hide controls}
  if (Item = nil) or not(Selected) or (FSelectedFields.SelCount > 1) then
    begin
      DisplayEditControls(False);

      Exit;
    end;

  {configure controls}
  if (FSelectionList.Count = 1) then
    begin
      lCriteria := SQL.Criteria[Item.Index];

      if (lCriteria.CriteriaType <> dacrField) then
        begin
          FcbxOperator.Visible := False;
          FedtValue.Visible := False;
          FcbxParameter.Visible := False;
          FcbxAutoSearch.Visible := False;
          FcbxMandatory.Visible := False;
          FcbxShowAll.Visible := False;
        end
      else
        begin
          CalcEditControlPosition(FcbxOperator, Item, 1);
          CalcEditControlPosition(FedtValue, Item, 2);
          CalcEditControlPosition(FcbxParameter, Item, 3);
          CalcEditControlPosition(FcbxAutoSearch, Item, 4);
          CalcEditControlPosition(FcbxMandatory, Item, 5);
          CalcEditControlPosition(FcbxShowAll, Item, 6);

          FcbxOperator.ItemIndex := Ord(lCriteria.Operator);
          FedtValue.Text := lCriteria.Value;

          FcbxParameter.ItemIndex := FcbxParameter.Items.IndexOf(lCriteria.ParamName);

          FcbxAutoSearch.Checked := lCriteria.AutoSearch;
          FcbxMandatory.Checked := lCriteria.Mandatory;
          FcbxShowAll.Checked := lCriteria.ShowAllValues;

          DisableMandatoryForBlankCriteria;

        end;

    end;

end; {procedure, SelectedSelectItemEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.SelectedResizeEvent }

procedure TdaSearchPage.SelectedResizeEvent(Sender: TObject);
begin

  if FSettingControls then Exit;

  if (FResizing) then Exit;

  FResizing := True;

  CalcEditControlPosition(FcbxOperator, FSelectedFields.Selected, 1);
  CalcEditControlPosition(FedtValue, FSelectedFields.Selected, 2);
  CalcEditControlPosition(FcbxParameter, FSelectedFields.Selected, 3);
  CalcEditControlPosition(FcbxAutoSearch, FSelectedFields.Selected, 4);
  CalcEditControlPosition(FcbxMandatory, FSelectedFields.Selected, 5);
  CalcEditControlPosition(FcbxShowAll, FSelectedFields.Selected, 6);

  FResizing := False;

end; {procedure, SelectedResizeEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.InsertCriteriaClickEvent }

procedure TdaSearchPage.InsertCriteriaClickEvent(Sender: TObject);
var
  lItem: TListItem;
  liIndex: Integer;
  lCriteria: TdaCriteria;
  lField: TdaField;
  lAvailableField: TdaField;
begin

  lItem := FAvailableFields.Selected;

  if (lItem = nil) then Exit;

  lAvailableField := SQL.AvailableCriteria[lItem.Index];

  lField := TdaField.Create(SQL);

  lField.Assign(lAvailableField);

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then
    liIndex := 0
  else
    liIndex := lItem.Index;

  lCriteria := SQL.InsertCriteria(liIndex, dacrField);

  lField.Parent := lCriteria;

  lItem := FSelectedFields.Items.Insert(liIndex);

  ChildToSelectedItem(lCriteria, lItem);

end; {procedure, InsertCriteriaClickEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.RemoveCriteriaClickEvent }

procedure TdaSearchPage.RemoveCriteriaClickEvent(Sender: TObject);
var
  liIndex: Integer;
  lItem: TListItem;
begin

  FSelectedFields.Items.BeginUpdate;

  liIndex := 0;

  while (liIndex < FSelectionList.Count) do
    begin
      lItem := TListItem(FSelectionList[liIndex]);

      if (SQL.DeselectCriteria(lItem.Index)) then
        lItem.Free
      else
        Inc(liIndex);
    end;

  SQLToControls;

  FSelectedFields.Items.EndUpdate;

end; {procedure, RemoveCriteriaClickEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.AddParenthesesClickEvent }

procedure TdaSearchPage.AddParenthesesClickEvent(Sender: TObject);
var
  lList: TList;
  lItem: TListItem;
  liIndex: Integer;
begin

  lList := TList.Create;

  for liIndex := 0 to FSelectionList.Count - 1 do
    begin
      lItem := TListItem(FSelectionList[liIndex]);

      lList.Add(TObject(lItem.Index));
    end;

  if SQL.AddParentheses(lList) then
    SQLToControls;

  lList.Free;

end; {procedure, AddParenthesesClickEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.RemoveParenthesesClickEvent }

procedure TdaSearchPage.RemoveParenthesesClickEvent(Sender: TObject);
var
  lList: TList;
  lItem: TListItem;
  liIndex: Integer;
begin

  lList := TList.Create;

  for liIndex := 0 to FSelectionList.Count - 1 do
    begin
      lItem := TListItem(FSelectionList[liIndex]);

      lList.Add(TObject(lItem.Index));
    end;

  if SQL.RemoveParentheses(lList) then
    SQLToControls;

  lList.Free;

end; {procedure, RemoveParenthesesClickEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.InsertORClickEvent }

procedure TdaSearchPage.InsertORClickEvent(Sender: TObject);
var
  liItem: Integer;
begin

  if (FSelectionList.Count > 0) then
    liItem := TListItem(FSelectionList[0]).Index
  else
    liItem := 0;

  SQL.InsertCriteria(liItem, dacrOR);

  SQLToControls;

end; {procedure, InsertORClickEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.InsertNOTClickEvent }

procedure TdaSearchPage.InsertNOTClickEvent(Sender: TObject);
var
  liItem: Integer;
begin

  if (FSelectionList.Count > 0) then
    liItem := TListItem(FSelectionList[0]).Index
  else
    liItem := 0;

  SQL.InsertCriteria(liItem, dacrNOT);

  SQLToControls;

end; {procedure, InsertNOTClickEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.ComparisonChangeEvent }

procedure TdaSearchPage.ComparisonChangeEvent(Sender: TObject);
var
  lItem: TListItem;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  SQL.Criteria[lItem.Index].Value := FedtValue.Text;
  SQL.Modification;

  lItem.SubItems[1] := FedtValue.Text;

end; {procedure, ComparisonChangeEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.ParameterChangeEvent }

procedure TdaSearchPage.ParameterChangeEvent(Sender: TObject);
var
  lItem: TListItem;
  lCriteria: TdaCriteria;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  lCriteria := SQL.Criteria[lItem.Index];

  // update parameter or blank it out, as needed
  if SQL.ReportParameters.InList(FcbxParameter.Text) then
    lCriteria.ParamName := FcbxParameter.Text
  else
    lCriteria.ParamName := '';

  SQL.Modification;

  // update list view columns ParamName, Value
  lItem.SubItems[2] := lCriteria.ParamName;
  lItem.SubItems[1] := lCriteria.Value;

  // update editbox and checkbox controls
  FEdtValue.Text := lCriteria.Value;
  FcbxAutoSearch.Checked := lCriteria.AutoSearch;
  FcbxShowAll.Checked := lCriteria.ShowAllValues;
  FcbxMandatory.Checked := lCriteria.Mandatory;

end; {procedure, ParameterChangeEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.AutoSearchClickEvent }

procedure TdaSearchPage.AutoSearchClickEvent(Sender: TObject);
var
  lItem: TListItem;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  SQL.Criteria[lItem.Index].AutoSearch := FcbxAutoSearch.Checked;
  SQL.Modification;

  lItem.SubItems[3] := SQL.Criteria[lItem.Index].AutoSearchDesc;

end; {procedure, AutoSearchClickEvent}

function TdaSearchPage.CreatePopupMenu: TppPopupMenuBase;
var
  lPopupMenu: TppPopupMenuBase;
  lMenuItem: TppTBXItem;
begin

//  lPopupMenu := inherited CreatePopupMenu;
//  lPopupMenu.AddSeparator();

  lPopupMenu := TppPopupMenuBase.Create(Self);

  lMenuItem := lPopupMenu.AddChildItem();
  lMenuItem.Caption := ppLoadStr(774); {Insert Criteria}
  lMenuItem.OnClick := InsertCriteriaClickEvent;

  lMenuItem := lPopupMenu.AddChildItem();
  lMenuItem.Caption := ppLoadStr(776); {Insert OR}
  lMenuItem.OnClick := InsertORClickEvent;

  lMenuItem := lPopupMenu.AddChildItem();
  lMenuItem.Caption := ppLoadStr(775); {Insert NOT}
  lMenuItem.OnClick := InsertNOTClickEvent;

  lPopupMenu.AddSeparator();

  lMenuItem := lPopupMenu.AddChildItem();
  lMenuItem.Caption := ppLoadStr(813); {Remove}
  lMenuItem.OnClick := RemoveCriteriaClickEvent;

  lPopupMenu.AddSeparator();

  lMenuItem := lPopupMenu.AddChildItem();
  lMenuItem.Caption := ppLoadStr(716); {Add Parentheses}
  lMenuItem.OnClick := AddParenthesesClickEvent;

  lMenuItem := lPopupMenu.AddChildItem();
  lMenuItem.Caption := ppLoadStr(814); {Remove Parentheses}
  lMenuItem.OnClick := RemoveParenthesesClickEvent;

  lPopupMenu.OnPopup := PopupMenuPopupEvent;

  Result := lPopupMenu;

end;

{------------------------------------------------------------------------------}
{ TdaSearchPage.MandatoryClickEvent }

procedure TdaSearchPage.MandatoryClickEvent(Sender: TObject);
var
  lItem: TListItem;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  SQL.Criteria[lItem.Index].Mandatory := FcbxMandatory.Checked;
  SQL.Modification;

  lItem.SubItems[4] := SQL.Criteria[lItem.Index].MandatoryDesc;

  if FcbxMandatory.Checked and SQL.Criteria[lItem.Index].ShowAllValues then
    begin
      SQL.Criteria[lItem.Index].ShowAllValues := False;
      FcbxShowAll.Checked := False;
    end;

end; {procedure, MandatoryClickEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.ShowAllClickEvent }

procedure TdaSearchPage.ShowAllClickEvent(Sender: TObject);
var
  lItem: TListItem;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  SQL.Criteria[lItem.Index].ShowAllValues := FcbxShowAll.Checked;
  SQL.Modification;

  lItem.SubItems[5] := SQL.Criteria[lItem.Index].ShowAllDesc;

  if FcbxShowAll.Checked and SQL.Criteria[lItem.Index].Mandatory then
    begin
      SQL.Criteria[lItem.Index].Mandatory := False;
      FcbxMandatory.Checked := False;
    end;

end; {procedure, ShowAllClickEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.OperatorChangeEvent }

procedure TdaSearchPage.OperatorChangeEvent(Sender: TObject);
var
  lItem: TListItem;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  SQL.Criteria[lItem.Index].Operator := TdaCriteriaOperatorType(FcbxOperator.ItemIndex);
  SQL.Modification;

  lItem.SubItems[0] := FcbxOperator.Items[FcbxOperator.ItemIndex];

  DisableMandatoryForBlankCriteria;

end; {procedure, OperatorChangeEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.DisableMandatoryForBlankCriteria }

procedure TdaSearchPage.DisableMandatoryForBlankCriteria;
var
  lItem: TListItem;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  if (FcbxOperator.ItemIndex = Ord(dacoBlank)) or (FcbxOperator.ItemIndex = Ord(dacoNotBlank)) then
    begin
      FcbxMandatory.Checked := False;

      FcbxMandatory.Enabled := False;

      SQL.Criteria[lItem.Index].Mandatory := False;
    end
  else
    begin
      FcbxMandatory.Checked := SQL.Criteria[lItem.Index].Mandatory;

      FcbxMandatory.Enabled := True;
    end

end; {procedure, DisableMandatoryForBlankCriteria}



{******************************************************************************
 *
 ** S O R T   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSortPage.PageName }

class function TdaSortPage.PageName: String;
begin
  Result := ppLoadStr(827); {Sort}
end; {procedure, PageName}

{------------------------------------------------------------------------------}
{ TdaSortPage.ImageIndex }

class function TdaSortPage.ImageIndex: Integer;
begin
  Result := ToolImageList.AddTool('DASORT');
end;

{------------------------------------------------------------------------------}
{ TdaSortPage.CreateControls }

procedure TdaSortPage.CreateControls;
var
  lBitmap: TBitmap;
begin

  FResizing := False;

  inherited CreateControls;

  TopLabel.Caption := ppLoadStr(727); {Available Fields}

  CheckBox.Caption := ppLoadStr(790); {Natural Order}

  lBitmap := TBitmap.Create;
{$IFNDEF Delphi5}
  CheckBox.Left := 0;
  CheckBox.Top := 1;

  CheckBox.Parent.Width := lBitmap.Canvas.TextWidth(CheckBox.Caption) + 30;
{$ELSE}
  CheckBox.Top := 3;
  CheckBox.Width := lBitmap.Canvas.TextWidth(CheckBox.Caption) + 30;
  CheckBox.Left := BottomPanel.Width - (CheckBox.Width + 10);
  CheckBox.Anchors := [akTop, akRight];
{$ENDIF}
  lBitmap.Free;

  FcbxDescending := TCheckBox.Create(Self);
  FcbxDescending.Parent := BottomPanel.Parent;
  FcbxDescending.Color := clWhite;
  FcbxDescending.Top := 3;
  FcbxDescending.Width := 17;
  FcbxDescending.Visible := False;
  FcbxDescending.OnClick := DescendingClickEvent;

  CheckBox.BringToFront;
  
  BottomLabel.Caption := ppLoadStr(828); {Sort Fields};

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaSortPage.SelectedReadOnly }

function TdaSortPage.SelectedReadOnly: Boolean;
begin
  Result := True;
end; {procedure, SelectedReadOnly}

{------------------------------------------------------------------------------}
{ TdaSortPage.CreateSelectedColumns }

procedure TdaSortPage.CreateSelectedColumns(aSelectedList: TppListView);
var
  lColumn: TListColumn;
begin

  inherited CreateSelectedColumns(aSelectedList);

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := ppLoadStr(751) + ' ' + ppLoadStr(710); {Desc (z > a)}

end; {procedure, CreateSelectedColumns}

{------------------------------------------------------------------------------}
{ TdaSortPage.SQLToControls }

procedure TdaSortPage.SQLToControls;
begin

  CheckBox.OnClick := nil;

  inherited SQLToControls;

  CheckBox.Checked := (SQL.OrderByFieldCount = 0);
  CheckBox.Enabled := (SQL.OrderByFieldCount > 0);

  CheckBox.OnClick := AllFieldsClickEvent;

end; {procedure, SQLToControls}

{------------------------------------------------------------------------------}
{ TdaSortPage.OutOfSync }

function TdaSortPage.OutOfSync: Boolean;
begin
  Result := FSQL.OrderByFieldsOutOfSync;
end; {procedure, OutOfSync}

{------------------------------------------------------------------------------}
{ TdaSortPage.Valid }

function TdaSortPage.Valid: Boolean;
begin
  Result := True;
end; {procedure, Valid}

{------------------------------------------------------------------------------}
{ TdaSortPage.GetChildType }

function TdaSortPage.GetChildType: TdaChildType;
begin
  Result := dactOrderByField;
end; {function, GetChildType}

{------------------------------------------------------------------------------}
{ TdaSortPage.ChildToAvailableItem }

procedure TdaSortPage.ChildToAvailableItem(aChild: TdaChild; aItem: TListItem);
var
  lField: TdaField;
begin

  lField := TdaField(aChild);

  aItem.Data := lField;

  aItem.Caption := lField.Alias;
  aItem.SubItems.Add(lField.SelectSQLString);
  aItem.SubItems.Add(lField.TableSQLAlias);

end; {function, ChildToAvailableItem}

{------------------------------------------------------------------------------}
{ TdaSortPage.ChildToSelectedItem }

procedure TdaSortPage.ChildToSelectedItem(aChild: TdaChild; aItem: TListItem);
var
  lField: TdaField;
begin

  lField := TdaField(aChild);

  {aItem.Caption := lField.Description;}
  aItem.Caption := lField.Alias;

  if (aItem.SubItems.Count = 0) then
    begin
      aItem.SubItems.Add('');
      aItem.SubItems.Add('');
      aItem.SubItems.Add('');
    end;

  aItem.SubItems[0] := lField.SelectSQLString;
  aItem.SubItems[1] := lField.TableSQLAlias;
  aItem.SubItems[2] := lField.OrderByDesc;

end; {procedure, ChildToSelectedItem}

{------------------------------------------------------------------------------}
{ TdaSortPage.GetAvailableChild }

function TdaSortPage.GetAvailableChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.AvailableOrderByFields[aIndex];
  Result.Tag := aIndex;
end; {function, GetAvailableChild}

{------------------------------------------------------------------------------}
{ TdaSortPage.GetAvailableChildCount }

function TdaSortPage.GetAvailableChildCount: Integer;
begin
  Result := SQL.AvailableOrderByFieldCount;
end; {function, GetAvailableChildCount}

{------------------------------------------------------------------------------}
{ TdaSortPage.GetSelectedChild }

function TdaSortPage.GetSelectedChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.OrderByFields[aIndex];
end; {function, GetSelectedChild}

{------------------------------------------------------------------------------}
{ TdaSortPage.GetSelectedChildCount }

function TdaSortPage.GetSelectedChildCount: Integer;
begin
  Result := SQL.OrderByFieldCount;
end; {function, GetSelectedChildCount}

{------------------------------------------------------------------------------}
{ TdaSortPage.SelectItem }

function TdaSortPage.SelectItem(aAvailableIndex: Integer): TdaChild;
var
  lField: TdaField;
  liIndex: Integer;
  lOrderByFields: TdaSQLOrderByFields;
begin

  if TopList.Items[aAvailableIndex].Data <> nil then
    begin
      lField := TdaField(TopList.Items[aAvailableIndex].Data);

      lOrderByFields := TdaSQLOrderByFields.Create(FSQL);

      if (lField is TdaCalculation) then
        liIndex := lOrderByFields.IndexOfAvailable(lField.TableAlias, TdaCalculation(lField).SQLFieldName)
      else
        liIndex := lOrderByFields.IndexOfAvailable(lField.TableAlias, lField.FieldName);

      lOrderByFields.Free;
    end
  else
    liIndex := aAvailableIndex;


  Result := SQL.SelectOrderByField(liIndex);

  {turn natural order off}
  if CheckBox.Checked then
    begin
      CheckBox.Checked := False;
      CheckBox.Enabled := True;
    end;

end; {function, SelectItem}

{------------------------------------------------------------------------------}
{ TdaSortPage.DeselectItem }

function TdaSortPage.DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild;
begin

  Result := SQL.DeselectOrderByField(aSelectedIndex);

  {turn natural order on}
  if (SQL.OrderByFieldCount = 0) then
    begin
      CheckBox.Checked := True;
      CheckBox.Enabled := False;
    end;

end; {procedure, DeselectItem}

{------------------------------------------------------------------------------}
{ TdaSortPage.DisplayEditControls }

procedure TdaSortPage.DisplayEditControls(aVisibility: Boolean);
begin
  FcbxDescending.Visible := aVisibility;
end; {procedure, DisplayEditControls}

{------------------------------------------------------------------------------}
{ TdaSortPage.SelectedSelectItemEvent }

procedure TdaSortPage.SelectedSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  lField: TdaField;
begin

  if FSettingControls then Exit;

  if (csDestroying in ComponentState) then Exit;

  {hide controls}
  if (Item = nil) or not(Selected) then
    DisplayEditControls(False)

  else
    begin
      CalcEditControlPosition(FcbxDescending, Item, 3);

      lField := SQL.OrderByFields[Item.Index];

      FcbxDescending.Checked := not(lField.Ascending);
    end;

end; {procedure, SelectedSelectItemEvent}

{------------------------------------------------------------------------------}
{ TdaSortPage.SelectedResizeEvent }

procedure TdaSortPage.SelectedResizeEvent(Sender: TObject);
begin

  if FSettingControls then Exit;

  if (FResizing) then Exit;

  FResizing := True;

  CalcEditControlPosition(FcbxDescending, FSelectedFields.Selected, 3);

  FResizing := False;

end; {procedure, SelectedResizeEvent}

{------------------------------------------------------------------------------}
{ TdaSortPage.AllFieldsClickEvent }

procedure TdaSortPage.AllFieldsClickEvent(Sender: TObject);
begin
  if CheckBox.Checked and not(Deselecting) then
    DeselectAllItems;
end; {procedure, AllFieldsClickEvent}

{------------------------------------------------------------------------------}
{ TdaSortPage.DescendingClickEvent }

procedure TdaSortPage.DescendingClickEvent(Sender: TObject);
var
  lItem: TListItem;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  SQL.OrderByFields[lItem.Index].Ascending := not(FcbxDescending.Checked);
  SQL.Modification;

  lItem.SubItems[2] := SQL.OrderByFields[lItem.Index].OrderByDesc;

end; {procedure, DescendingClickEvent}




{******************************************************************************
 *
 ** S Q L   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSQLPage.SetAllowEditSQL }

procedure TdaSQLPage.SetAllowEditSQL(aValue: Boolean);
var
  lPopupMenu: TppPopupMenuBase;
  lMenuItem: TppTBXItem;
begin

  FAllowEditSQL := aValue;

  if (FSQLText = nil) then Exit;

  if FSQLText.ReadOnly and (FSQLText.PopupMenu = nil) then
    begin
      lPopupMenu := TppPopupMenuBase.Create(Self);

      lMenuItem := lPopupMenu.AddChildItem();
      lMenuItem.Caption := ppLoadStr(757); {Edit SQL}
      lMenuItem.OnClick := EditSQLClickEvent;

      {set menu item visibility based on FAllowEditSQL value
        - need to create a popup menu with no items to disable the memo's
          default popup menu}
      lMenuItem.Visible := FAllowEditSQL;

      FSQLText.PopupMenu := lPopupMenu;
    end;


end; {procedure, SetAllowEditSQL}

{------------------------------------------------------------------------------}
{ TdaSQLPage.PageName }

class function TdaSQLPage.PageName: String;
begin
  Result := ppLoadStr(829); {SQL}
end; {procedure, PageName}

{------------------------------------------------------------------------------}
{ TdaSQLPage.ImageIndex }

class function TdaSQLPage.ImageIndex: Integer;
begin
  Result := ToolImageList.AddTool('DATEXTONLY');
end;


{------------------------------------------------------------------------------}
{ TdaSQLPage.CreateControls }

procedure TdaSQLPage.CreateControls;
var
  lLabel: TLabel;
  lImage: TImage;
  lPanel: TPanel;
begin

  {title panel}
  lPanel := TPanel.Create(Self);
  lPanel.Parent := Page;
  lPanel.Align := alTop;
  lPanel.Height := 51;
  lPanel.BevelInner := bvNone;
  lPanel.BevelOuter := bvNone;

  lImage := TImage.Create(Self);
  lImage.Parent := lPanel;
  lImage.AutoSize := True;
  lImage.Left := 6;
  lImage.Top := 3;
  lImage.Picture.Bitmap.Handle := ppBitmapFromResource('DATEXTONLY');
  lImage.Transparent := True;

  lLabel := TLabel.Create(Self);
  lLabel.Parent := lPanel;
  lLabel.Left := 28;
  lLabel.Top := 4;
  lLabel.Caption := ppLoadStr(569); {'Name'}

  FDPName := TEdit.Create(Self);
  FDPName.Parent := lPanel;
  FDPName.Left := 28;
  FDPName.Top := 23;
  FDPName.Width := 220;
  FDPName.OnChange := NameChangeEvent;

  FNameError := TLabel.Create(Self);
  FNameError.Parent := lPanel;
  FNameError.AutoSize := False;
  FNameError.Font.Color := clRed;
  FNameError.Caption := '';
  FNameError.Left := FDPName.Left + FDPName.Width + 20;
  FNameError.Top := 4;
  FNameError.Height := 45;
  FNameError.Width := 220;
  FNameError.WordWrap := True;
  FNameError.Visible := False;

  {memo panel}
  lPanel := TPanel.Create(Self);
  lPanel.Parent := Page;
  lPanel.Top := 100;
  lPanel.Align := alClient;
  lPanel.BevelInner := bvNone;
  lPanel.BevelOuter := bvNone;

  FSQLText := TdaSQLEdit.Create(Self);
  FSQLText.Parent := lPanel;
  FSQLText.Align := alClient;
  FSQLText.Color := clBtnFace;
  FSQLText.ScrollBars := ssBoth;

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaSQLPage.SQLToControls }

procedure TdaSQLPage.SQLToControls;
var
  lPopupMenu: TppPopupMenuBase;
  lMenuItem: TppTBXItem;
begin

  GenerateValidName;
  FDPName.Text := SQL.DataPipelineName;

  FSQLText.DatabaseType := SQL.DatabaseType;
  FSQLText.OnChange := nil;
  FSQLText.Lines.Clear;
  FSQLText.Lines := SQL.SQLText;

  if SQL.EditSQLAsText then
    FSQLText.ReadOnly := False
  else
    FSQLText.ReadOnly := True;

  if FSQLText.ReadOnly and (FSQLText.PopupMenu = nil) then
    begin
      lPopupMenu := TppPopupMenuBase.Create(Self);

      lMenuItem := lPopupMenu.AddChildItem;
      lMenuItem.Caption := ppLoadStr(757); {Edit SQL}
      lMenuItem.OnClick := EditSQLClickEvent;

      {set menu item visibility based on FAllowEditSQL value
        - need to create a popup menu with no items to disable the memo's
          default popup menu}
      lMenuItem.Visible := FAllowEditSQL;

      FSQLText.PopupMenu := lPopupMenu;
    end;

  if not(FSQLText.ReadOnly) then
    FSQLText.Color := clWindow;


end; {procedure, SQLToControls}

{------------------------------------------------------------------------------}
{ TdaSQLPage.OutOfSync }

function TdaSQLPage.OutOfSync: Boolean;
begin
  Result := True;
end; {procedure, OutOfSync}

{------------------------------------------------------------------------------}
{ TdaSQLPage.GenerateValidName }

procedure TdaSQLPage.GenerateValidName;
var
  lbValid: Boolean;
  liSerialNo: Integer;
  lsName: String;
  lsNewName: String;
begin

  lsName := SQL.DataPipelineName;
  lbValid := True;

  DoOnValidateName(Self, lsName, lbValid);

  if not(lbValid) then
    begin

      liSerialNo := 2;

      while not(lbValid) do
        begin
          lsNewName := lsName + IntToStr(liSerialNo);

          DoOnValidateName(Self, lsNewName, lbValid);

          Inc(liSerialNo);
        end;

      SQL.DataPipelineName := lsNewName;

    end;

end; {procedure, GenerateValidName}

{------------------------------------------------------------------------------}
{ TdaSQLPage.Valid }

function TdaSQLPage.Valid: Boolean;
begin

  Result := True;

  if (FSQL.DataPipelineName = '') then
    begin
      Result := False;

      FNameError.Caption := ppLoadStr(805); {'Please enter a description of your query.'}
      FNameError.Visible := True;
    end

  else if not(IsValidIdent(FSQL.DataPipelineName)) then
    begin
      Result := False;

      FNameError.Caption := ppLoadStrWithParms(712, [FSQL.DataPipelineName]); {<name> is not a valid Data Pipeline name.}
      FNameError.Visible := True;
    end

  else
    begin
      DoOnValidateName(Self, FSQL.DataPipelineName, Result);

      if not(Result) then
        begin
          FNameError.Caption := ppLoadStrWithParms(859, [FSQL.DataPipelineName]); {'<name> is already used in the report, please enter a new name.'}
          FNameError.Visible := True;
        end

      else
        begin

          if SQL.EditSQLAsText then
            begin
              Result := SQL.ValidateSQLText(FSQLText.Lines);

              if (Result) then
                SQL.SQLText := FSQLText.Lines;
            end;
            
        end;

    end;

end; {procedure, Valid}

{------------------------------------------------------------------------------}
{ TdaSQLPage.DoOnValidateName }

procedure TdaSQLPage.DoOnValidateName(Sender: TObject; const aName: String; var aNameValid: Boolean);
begin
  if Assigned(FOnValidateName) then FOnValidateName(Sender, aName, aNameValid);
end; {procedure, DoOnValidateName}

{------------------------------------------------------------------------------}
{ TdaSQLPage.NameChangeEvent }

procedure TdaSQLPage.NameChangeEvent(Sender: TObject);
begin
  FSQL.DataPipelineName := ppTextToIdentifier(FDPName.Text);
end; {procedure, NameChangeEvent}

{------------------------------------------------------------------------------}
{ TdaSQLPage.EditSQLClickEvent }

procedure TdaSQLPage.EditSQLClickEvent(Sender: TObject);
var
  lsMessage: String;
begin

  {Are you sure you want to edit the SQL?...}
  lsMessage := ppLoadStr(725) + #13#10 + #13#10 + ppLoadStr(801);

  if MessageDlg(lsMessage, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      FSQLText.PopupMenu.Free;
      FSQLText.ReadOnly := False;
      FSQLText.Color := clWindow;

      SQL.EditSQLAsText := True;

      if Assigned(FOnEditSQLAsText) then FOnEditSQLAsText(Self);
    end;

end; {procedure, EditSQLClickEvent}

{******************************************************************************
 *
 ** G R O U P   S E A R C H   P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.AddParenthesesClickEvent }

procedure TdaGroupSearchPage.AddParenthesesClickEvent(Sender: TObject);
var
  lList: TList;
  lItem: TListItem;
  liIndex: Integer;
begin

  lList := TList.Create;

  for liIndex := 0 to FSelectionList.Count - 1 do
    begin
      lItem := TListItem(FSelectionList[liIndex]);

      lList.Add(TObject(lItem.Index));
    end;

  if SQL.AddParentheses(lList, True) then
    SQLToControls;

  lList.Free;

end; {procedure, AddParenthesesClickEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.AutoSearchClickEvent }

procedure TdaGroupSearchPage.AutoSearchClickEvent(Sender: TObject);
var
  lItem: TListItem;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  SQL.GroupCriteria[lItem.Index].AutoSearch := FcbxAutoSearch.Checked;
  SQL.Modification;

  lItem.SubItems[3] := SQL.GroupCriteria[lItem.Index].AutoSearchDesc;

end; {procedure, AutoSearchClickEvent}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.CalcTypeChangeEvent }

procedure TdaGroupSearchPage.CalcTypeChangeEvent(Sender: TObject);
var
  lItem: TListItem;
  lCriteria: TdaCriteria;
  lCalc: TdaCalculation;
  lbInvalid: Boolean;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  lCriteria := SQL.GroupCriteria[lItem.Index];

  lCalc := TdaCalculation(lCriteria.Field);

  if (FcbxFunction.ItemIndex = -1) then
    lCalc.CalcType := dacaExpression
  else
    lCalc.CalcType := TdaCalcType(FcbxFunction.ItemIndex);

  if (lCalc.CalcType = dacaExpression) then
    begin
      {Warn if Expression contains " AS "}
      lbInvalid := False;

      daRemoveInvalidAliasing(FcbxFunction.Text, lbInvalid);

      ShowInvalidExpressionLabel(lbInvalid);

      // align the label with the combo box
      if FlblInvalidExpression <> nil then
        FlblInvalidExpression.Left := FcbxFunction.Left;

      if (lCalc.Expression = lCalc.Alias) then
        begin
          lCalc.Expression := FcbxFunction.Text;

          lCalc.Alias := lCalc.CalcFieldAlias;
        end
      else
        begin
          lCalc.Expression := FcbxFunction.Text;

          if (lCalc.CalcType = dacaExpression) and (AliasIsRBAlias(lCalc.Alias)) and
             ((lCalc.Expression <> '') and (lCalc.Expression[Length(lCalc.Expression)] <> ' ')) then
            lCalc.Alias := lCalc.CalcFieldAlias
          else
            lCalc.GenerateSQLFieldName;

        end;
    end;

  FSQL.ValidateFieldAlias(lCalc, True);
  FSQL.Modification;

  ChildToSelectedItem(lCalc, lItem);

end; {procedure, CalcTypeChangeEvent}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.CalcTypeDblClickEvent }

procedure TdaGroupSearchPage.CalcTypeDblClickEvent(Sender: TObject);
var
  lbValid: Boolean;
begin

  DeselectItem(BottomList.Selected.Index, lbValid);

end; {procedure, CalcTypeDblClickEvent}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.ChildToSelectedItem }

procedure TdaGroupSearchPage.ChildToSelectedItem(aChild: TdaChild; aItem: TListItem);
var
  lCriteria: TdaCriteria;
  lCalc: TdaCalculation;
begin

  if (aChild is TdaCalculation) then
    begin
      lCalc := TdaCalculation(aChild);

      if lCalc.CalcType = dacaExpression then
        aItem.Caption := lCalc.Expression
      else
        aItem.Caption := lCalc.Description;
    end
  else
    begin
      lCriteria := TdaCriteria(aChild);

      if (lCriteria.CriteriaType = dacrField) then
        begin
          lCalc := TdaCalculation(lCriteria.Field);

          if (lCriteria.IsExpression) then
            aItem.Caption := lCriteria.Expression
          else
            begin
              aItem.Caption := lCalc.Description;
            end;

          if (aItem.SubItems.Count = 0) then
            begin
              aItem.SubItems.Add('');
              aItem.SubItems.Add('');
              aItem.SubItems.Add('');
              aItem.SubItems.Add('');
              aItem.SubItems.Add('');
              aItem.SubItems.Add('');
            end;

            aItem.SubItems[0] := lCriteria.OperatorDesc;
            aItem.SubItems[1] := lCriteria.Value;
            aItem.SubItems[2] := lCriteria.ParamName;
            aItem.SubItems[3] := lCriteria.AutoSearchDesc;
            aItem.SubItems[4] := lCriteria.MandatoryDesc;
            aItem.SubItems[5] := lCriteria.ShowAllDesc;
        end
      else
        aItem.Caption := lCriteria.Description;
    end;

end; {function, ChildToSelectedItem}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.ComparisonChangeEvent }

procedure TdaGroupSearchPage.ComparisonChangeEvent(Sender: TObject);
var
  lItem: TListItem;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  SQL.GroupCriteria[lItem.Index].Value := FedtValue.Text;
  SQL.Modification;

  lItem.SubItems[1] := FedtValue.Text;

end; {procedure, ComparisonChangeEvent}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.CreateControls }

procedure TdaGroupSearchPage.CreateControls;
var
  lPopupMenu: TppPopupMenuBase;
  lOperator: TdaCriteriaOperatorType;
begin

  FResizing := False;

  inherited CreateControls;

  MoveSelectedItems := False;

  TopLabel.Caption := ppLoadStr(727); {Available Fields}

  BottomLabel.Caption := ppLoadStr(741); {Criteria}

  CheckBox.OnClick := nil;
  CheckBox.Visible := False;

  FcbxAutoSearch := TCheckBox.Create(Self);
  FcbxAutoSearch.Parent := BottomPanel.Parent;
  FcbxAutoSearch.Color := clWhite;
  FcbxAutoSearch.Top := 3;
  FcbxAutoSearch.Width := 17;
  FcbxAutoSearch.Visible := False;
  FcbxAutoSearch.OnClick := AutoSearchClickEvent;

  FcbxMandatory := TCheckBox.Create(Self);
  FcbxMandatory.Parent := BottomPanel.Parent;
  FcbxMandatory.Color := clWhite;
  FcbxMandatory.Top := 3;
  FcbxMandatory.Width := 17;
  FcbxMandatory.Visible := False;
  FcbxMandatory.OnClick := MandatoryClickEvent;

  FcbxShowAll := TCheckBox.Create(Self);
  FcbxShowAll.Parent := BottomPanel.Parent;
  FcbxShowAll.Color := clWhite;
  FcbxShowAll.Top := 3;
  FcbxShowAll.Width := 17;
  FcbxShowAll.Visible := False;
  FcbxShowAll.OnClick := ShowAllClickEvent;

  //Function ComboBox

  FcbxFunction := TComboBox.Create(Self);
  FcbxFunction.Parent := BottomPanel.Parent;
  FcbxFunction.Style := csDropDown;
  FcbxFunction.Top := 3;
  FcbxFunction.Width := 200;
  FcbxFunction.Visible := False;

  FcbxFunction.OnChange := CalcTypeChangeEvent;
  FcbxFunction.OnDblClick := CalcTypeDblClickEvent;

  //Operator ComboBox

  FcbxOperator := TComboBox.Create(Self);
  FcbxOperator.Parent := BottomPanel.Parent;
  FcbxOperator.Style := csDropDownList;
  FcbxOperator.Top := 3;
  FcbxOperator.Width := 100;
  FcbxOperator.Visible := False;

  for lOperator := Low(TdaCriteriaOperatorType) to High(TdaCriteriaOperatorType) do
    FcbxOperator.Items.Add(daGetOperatorDesc(lOperator));

  FcbxOperator.OnChange := OperatorChangeEvent;

  //Value EditBox

  FedtValue := TEdit.Create(Self);
  FedtValue.Parent := BottomPanel.Parent;
  FedtValue.Top := 3;
  FedtValue.Width := 100;
  FedtValue.Visible := False;

  FedtValue.OnChange := ComparisonChangeEvent;

  FcbxParameter := TComboBox.Create(Self);
  FcbxParameter.Parent := BottomPanel.Parent;
  FcbxParameter.Style := csDropDownList;
  FcbxParameter.Top := 3;
  FcbxParameter.Width := 100;
  FcbxParameter.Visible := False;

  // populate cbxParameter with report param names
  if (SQL <> nil) and (SQL.ReportParameters <> nil) then
    SQL.ReportParameters.GetVisibleNames(FcbxParameter.Items);

  FcbxParameter.Items.Add(ppLoadStr(343)); {<None>}

  FcbxParameter.OnChange := ParameterChangeEvent;

  //Popup Menu Items

  lPopupMenu := CreatePopupMenu;

  FAvailableFields.PopupMenu := lPopupMenu;
  FSelectedFields.PopupMenu := lPopupMenu;
  FcbxFunction.PopupMenu := lPopupMenu;

end; {procedure, CreateControls}

function TdaGroupSearchPage.CreatePopupMenu: TppPopupMenuBase;
var
  lPopupMenu: TppPopupMenuBase;
  lMenuItem: TppTBXItem;
begin

//  lPopupMenu := inherited CreatePopupMenu;
//  lPopupMenu.AddSeparator();

  //Popup Menu Items

  lPopupMenu := TppPopupMenuBase.Create(Self);

  lMenuItem := lPopupMenu.AddChildItem();
  lMenuItem.Caption := ppLoadStr(774); {Insert Criteria}
  lMenuItem.OnClick := InsertCriteriaClickEvent;

  lMenuItem := lPopupMenu.AddChildItem();
  lMenuItem.Caption := ppLoadStr(776); {Insert OR}
  lMenuItem.OnClick := InsertORClickEvent;

  lMenuItem := lPopupMenu.AddChildItem();
  lMenuItem.Caption := ppLoadStr(775); {Insert NOT}
  lMenuItem.OnClick := InsertNOTClickEvent;

  lPopupMenu.AddSeparator();

  lMenuItem := lPopupMenu.AddChildItem();
  lMenuItem.Caption := ppLoadStr(813); {Remove}
  lMenuItem.OnClick := RemoveCriteriaClickEvent;

  lPopupMenu.AddSeparator();

  lMenuItem := lPopupMenu.AddChildItem();
  lMenuItem.Caption := ppLoadStr(716); {Add Parentheses}
  lMenuItem.OnClick := AddParenthesesClickEvent;

  lMenuItem := lPopupMenu.AddChildItem();
  lMenuItem.Caption := ppLoadStr(814); {Remove Parentheses}
  lMenuItem.OnClick := RemoveParenthesesClickEvent;

  lPopupMenu.OnPopup := PopupMenuPopupEvent;

  Result := lPopupMenu;

end;

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.CreateSelectedColumns }

procedure TdaGroupSearchPage.CreateSelectedColumns(aSelectedList: TppListView);
var
  lColumn: TListColumn; 
begin

  inherited CreateSelectedColumns(aSelectedList);

  aSelectedList.Columns[0].Caption := ppLoadStr(766); {Function}
  aSelectedList.Columns[0].Width := 150;

  aSelectedList.Columns[1].Caption := ppLoadStr(802); {Operator}
  aSelectedList.Columns[2].Caption := ppLoadStr(837); {Value}

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 100;
  lColumn.Caption := {ppLoadStr(841)}'Parameter'; {'Parameter'} //TODO Localize

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 75;
  lColumn.Caption := ppLoadStr(841); {'AutoSearch'}

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 75;
  lColumn.Caption := ppLoadStr(842); {'Mandatory'}

  lColumn := aSelectedList.Columns.Add;
  lColumn.Width := 75;
  lColumn.Caption := ppLoadStr(846); {'Show All'}

end; {procedure, CreateSelectedColumns}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.DeselectItem }

function TdaGroupSearchPage.DeselectItem(aSelectedIndex: Integer; var aValid: Boolean): TdaChild;
begin
  Result := nil;

  RemoveCriteriaClickEvent(Self);
end; {function, DeselectItem}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.DisplayEditControls }

procedure TdaGroupSearchPage.DisplayEditControls(aVisibility: Boolean);
begin
  FcbxOperator.Visible := aVisibility;
  FedtValue.Visible := aVisibility;
  FcbxFunction.Visible := aVisibility;
  FcbxParameter.Visible := aVisibility;
  FcbxAutoSearch.Visible := aVisibility;
  FcbxMandatory.Visible := aVisibility;
  FcbxShowAll.Visible := aVisibility;

end; {procedure, DisplayEditControls}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.GetAvailableChild }

function TdaGroupSearchPage.GetAvailableChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.AvailableGroupCriteria[aIndex];

end; {function, GetAvailableChild}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.GetAvailableChildCount }

function TdaGroupSearchPage.GetAvailableChildCount: Integer;
begin
  Result := SQL.AvailableGroupCriteriaCount;

end; {function, AvailableChildCount}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.GetChildType }

function TdaGroupSearchPage.GetChildType: TdaChildType;
begin
  Result := dactGroupCriteria;

end; {function, GetChildType}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.GetSelectedChild }

function TdaGroupSearchPage.GetSelectedChild(aIndex: Integer): TdaChild;
begin
  Result := SQL.GroupCriteria[aIndex];

end; {function, GetSelectedChild}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.GetSelectedChildCount }

function TdaGroupSearchPage.GetSelectedChildCount: Integer;
begin
  Result := SQL.GroupCriteriaCount;

end; {function, GetSelectedChildCount}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.ImageIndex }

class function TdaGroupSearchPage.ImageIndex: Integer;
begin
  Result := ToolImageList.AddTool('DAGROUPSEARCH');

end;

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.InsertCriteriaClickEvent }

procedure TdaGroupSearchPage.InsertCriteriaClickEvent(Sender: TObject);
var
  lItem: TListItem;
  liIndex: Integer;
  lCriteria: TdaCriteria;
  lField: TdaField;
  lAvailableField: TdaField;
begin

  lItem := FAvailableFields.Selected;

  if (lItem = nil) then Exit;

  lAvailableField := SQL.AvailableGroupCriteria[lItem.Index];

  lField := lAvailableField.Clone(Self);

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then
    liIndex := 0
  else
    liIndex := lItem.Index;

  lCriteria := SQL.InsertGroupCriteria(liIndex, dacrField);

  lField.Parent := lCriteria;

  lItem := FSelectedFields.Items.Insert(liIndex);

  ChildToSelectedItem(lCriteria, lItem);

end; {procedure, InsertCriteriaClickEvent}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.InsertNOTClickEvent }

procedure TdaGroupSearchPage.InsertNOTClickEvent(Sender: TObject);
var
  liItem: Integer;
begin

  if (FSelectionList.Count > 0) then
    liItem := TListItem(FSelectionList[0]).Index
  else
    liItem := 0;

  SQL.InsertGroupCriteria(liItem, dacrNOT);

  SQLToControls;

end; {procedure, InsertNOTClickEvent}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.InsertORClickEvent }

procedure TdaGroupSearchPage.InsertORClickEvent(Sender: TObject);
var
  liItem: Integer;
begin

  if (FSelectionList.Count > 0) then
    liItem := TListItem(FSelectionList[0]).Index
  else
    liItem := 0;

  SQL.InsertGroupCriteria(liItem, dacrOR);

  SQLToControls;

end; {procedure, InsertORClickEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.MandatoryClickEvent }

procedure TdaGroupSearchPage.MandatoryClickEvent(Sender: TObject);
var
  lItem: TListItem;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  SQL.GroupCriteria[lItem.Index].Field.Mandatory := FcbxMandatory.Checked;
  SQL.Modification;

  lItem.SubItems[4] := SQL.GroupCriteria[lItem.Index].MandatoryDesc;

  if FcbxMandatory.Checked and SQL.GroupCriteria[lItem.Index].Field.ShowAllValues then
    begin
      SQL.GroupCriteria[lItem.Index].Field.ShowAllValues := False;
      FcbxShowAll.Checked := False;
    end;


end; {procedure, MandatoryClickEvent}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.OperatorChangeEvent }

procedure TdaGroupSearchPage.OperatorChangeEvent(Sender: TObject);
var
  lItem: TListItem;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  SQL.GroupCriteria[lItem.Index].Operator := TdaCriteriaOperatorType(FcbxOperator.ItemIndex);
  SQL.Modification;

  lItem.SubItems[0] := FcbxOperator.Items[FcbxOperator.ItemIndex];

end; {procedure, OperatorChangeEvent}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.OutOfSync }

function TdaGroupSearchPage.OutOfSync: Boolean;
begin
  Result := FSQL.GroupCriteriaOutOfSync;

end; {procedure, OutOfSync}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.PageName }

class function TdaGroupSearchPage.PageName: String;
begin
  Result := ppLoadStr(1170);

end; {procedure, PageName}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.ParameterChangeEvent }

procedure TdaGroupSearchPage.ParameterChangeEvent(Sender: TObject);
var
  lItem: TListItem;
  lCriteria: TdaCriteria;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  lCriteria := SQL.GroupCriteria[lItem.Index];

  // update parameter or blank it out, as needed
  if SQL.ReportParameters.InList(FcbxParameter.Text) then
    lCriteria.ParamName := FcbxParameter.Text
  else
    lCriteria.ParamName := '';

  SQL.Modification;

  // update list view columns ParamName, Value
  lItem.SubItems[2] := lCriteria.ParamName;
  lItem.SubItems[1] := lCriteria.Value;

  // update editbox and checkbox controls
  FEdtValue.Text := lCriteria.Value;
  FcbxAutoSearch.Checked := lCriteria.AutoSearch;
  FcbxShowAll.Checked := lCriteria.ShowAllValues;
  FcbxMandatory.Checked := lCriteria.Mandatory;

end; {procedure, ParameterChangeEvent}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.PopupMenuPopupEvent }

procedure TdaGroupSearchPage.PopupMenuPopupEvent(Sender: TObject);
var
  lPopupMenu: TppPopupMenuBase;
begin

  lPopupMenu := TppPopupMenuBase(Sender);

  lPopupMenu.Items[0].Enabled := False; {Insert Criteria}
  lPopupMenu.Items[1].Enabled := False; {Insert OR}
  lPopupMenu.Items[2].Enabled := False; {Insert NOT}
  lPopupMenu.Items[4].Enabled := False; {Remove}
  lPopupMenu.Items[6].Enabled := False; {Add Parentheses}
  lPopupMenu.Items[7].Enabled := False; {Remove Parentheses}

  if FAvailableFields.Focused then
    lPopupMenu.Items[0].Enabled := (FAvailableFields.Selected <> nil) {Insert Criteria}

  else if (FSelectedFields.Focused) or (FcbxFunction.Focused) then
    begin
      lPopupMenu.Items[0].Enabled := (FAvailableFields.Selected <> nil); {Insert Criteria}

      if (FSelectedFields.Selected = nil) then Exit;

      lPopupMenu.Items[1].Enabled := True; {Insert OR}
      lPopupMenu.Items[2].Enabled := True; {Insert NOT}
      lPopupMenu.Items[4].Enabled := True; {Remove}

      lPopupMenu.Items[6].Enabled := True; {Add Parentheses}
      lPopupMenu.Items[7].Enabled := True; {Remove Parentheses}
    end;

end; {procedure, PopupMenuPopupEvent}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.RemoveCriteriaClickEvent }

procedure TdaGroupSearchPage.RemoveCriteriaClickEvent(Sender: TObject);
var
  liIndex: Integer;
  lItem: TListItem;
begin

  FSelectedFields.Items.BeginUpdate;

  liIndex := 0;

  while (liIndex < FSelectionList.Count) do
    begin
      lItem := TListItem(FSelectionList[liIndex]);

      if (SQL.DeselectGroupCriteria(lItem.Index)) then
        lItem.Free
      else
        Inc(liIndex);
    end;

  SQLToControls;

  FSelectedFields.Items.EndUpdate;

end; {procedure, RemoveCriteriaClickEvent}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.RemoveParenthesesClickEvent }

procedure TdaGroupSearchPage.RemoveParenthesesClickEvent(Sender: TObject);
var
  lList: TList;
  lItem: TListItem;
  liIndex: Integer;
begin

  lList := TList.Create;

  for liIndex := 0 to FSelectionList.Count - 1 do
    begin
      lItem := TListItem(FSelectionList[liIndex]);

      lList.Add(TObject(lItem.Index));
    end;

  if SQL.RemoveParentheses(lList, True) then  
    SQLToControls;

  lList.Free;

end; {procedure, RemoveParenthesesClickEvent}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.CreateSelectedColumns }

procedure TdaGroupSearchPage.SelectedEditedEvent(Sender: TObject; Item: TListItem; var S: String);
var
  lCriteria: TdaCriteria;
begin

  if FSettingControls then Exit;

  lCriteria := TdaCriteria(GetSelectedChild(Item.Index));

  lCriteria.Expression := S;

end;  {procedure, SelectedMultiSelect}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.SelectedMultiSelect }

function TdaGroupSearchPage.SelectedMultiSelect: Boolean;
begin
  Result := True;
end; {procedure, SelectedMultiSelect}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.SelectedReadOnly }

function TdaGroupSearchPage.SelectedReadOnly: Boolean;
begin
  Result := False;
end; {procedure, SelectedReadOnly}

{------------------------------------------------------------------------------}
{ TdaGroupSearchPage.SelectedResizeEvent }

procedure TdaGroupSearchPage.SelectedResizeEvent(Sender: TObject);
begin

  if FSettingControls then Exit;

  if (FResizing) then Exit;

  FResizing := True;

  CalcEditControlPosition(FcbxFunction, FSelectedFields.Selected, 0);
  CalcEditControlPosition(FcbxOperator, FSelectedFields.Selected, 1);
  CalcEditControlPosition(FedtValue, FSelectedFields.Selected, 2);
  CalcEditControlPosition(FcbxParameter, FSelectedFields.Selected, 3);
  CalcEditControlPosition(FcbxAutoSearch, FSelectedFields.Selected, 4);
  CalcEditControlPosition(FcbxMandatory, FSelectedFields.Selected, 5);
  CalcEditControlPosition(FcbxShowAll, FSelectedFields.Selected, 6);

  FResizing := False;

end; {procedure, SelectedResizeEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.SelectedSelectItemEvent }

procedure TdaGroupSearchPage.SelectedSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  lItem: TListItem;
  lCriteria: TdaCriteria;
  lCalc: TdaCalculation;
  lCalcType: TdaCalcType;
begin

  if FSettingControls then Exit;

  if (csDestroying in ComponentState) then Exit;
  
  {build selection list}
  FSelectionList.Clear;

  if (Item = nil) or not(Selected) or (FSelectedFields.SelCount > 1) then
    begin
      lItem := FSelectedFields.Selected;

      while (lItem <> nil) do
        begin
          FSelectionList.Add(lItem);

          lItem := FSelectedFields.GetNextItem(lItem, sdAll, [isSelected]);
        end;

    end
  else
    FSelectionList.Add(Item);

  {hide controls}
  if (Item = nil) or not(Selected) or (FSelectedFields.SelCount > 1) then
    begin
      DisplayEditControls(False);

      Exit;
    end;

  {configure controls}
  lCriteria := SQL.GroupCriteria[Item.Index];

  if (FSelectionList.Count = 1) and (lCriteria.CriteriaType = dacrField) then
    begin
      lCalc := TdaCalculation(lCriteria.Field);

      FcbxFunction.Items.Clear;
      for lCalcType := dacaAvg to dacaExpression do
        if lCalcType = dacaExpression then
          FcbxFunction.Items.Add(LoadStr(759)) // Expression
        else
          FcbxFunction.Items.Add(lCalc.GetDescription(lCalcType));

      CalcEditControlPosition(FcbxFunction, Item, 0);
      CalcEditControlPosition(FcbxOperator, Item, 1);
      CalcEditControlPosition(FedtValue, Item, 2);
      CalcEditControlPosition(FcbxParameter, Item, 3);
      CalcEditControlPosition(FcbxAutoSearch, Item, 4);
      CalcEditControlPosition(FcbxMandatory, Item, 5);
      CalcEditControlPosition(FcbxShowAll, Item, 6);

      if lCalc.CalcType = dacaExpression then
        FcbxFunction.Text := lCalc.Expression
      else
        FcbxFunction.ItemIndex := Ord(lCalc.CalcType);

      FcbxOperator.ItemIndex := Ord(lCriteria.Operator);
      FedtValue.Text := lCriteria.Value;

      FcbxParameter.ItemIndex := FcbxParameter.Items.IndexOf(lCriteria.ParamName);

      FcbxAutoSearch.Checked := lCriteria.AutoSearch;
      FcbxMandatory.Checked := lCriteria.Mandatory;
      FcbxShowAll.Checked := lCriteria.ShowAllValues;

    end;

end; {procedure, SelectedSelectItemEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.SelectItem}

function TdaGroupSearchPage.SelectItem(aAvailableIndex: Integer): TdaChild;
var
  lField: TdaField;
  liIndex: Integer;
  lGroupCriteria: TdaSQLGroupCriteriaList;
begin

  if TopList.Items[aAvailableIndex].Data <> nil then
    begin
      lField := TdaField(TopList.Items[aAvailableIndex].Data);

      lGroupCriteria := TdaSQLGroupCriteriaList.Create(FSQL);

      liIndex := lGroupCriteria.IndexOfAvailable(lField.TableAlias, lField.FieldName);
      lGroupCriteria.Free;
    end
  else
    liIndex := aAvailableIndex;

  Result := SQL.SelectGroupCriteria(liIndex);

end; {function, SelectItem}

{------------------------------------------------------------------------------}
{ TdaSearchPage.ShowAllClickEvent }

procedure TdaGroupSearchPage.ShowAllClickEvent(Sender: TObject);
var
  lItem: TListItem;
begin

  lItem := FSelectedFields.Selected;

  if (lItem = nil) then Exit;

  SQL.GroupCriteria[lItem.Index].ShowAllValues := FcbxShowAll.Checked;
  SQL.Modification;

  lItem.SubItems[4] := SQL.GroupCriteria[lItem.Index].ShowAllDesc;

  if FcbxShowAll.Checked and SQL.GroupCriteria[lItem.Index].Mandatory then
    begin
      SQL.GroupCriteria[lItem.Index].Mandatory := False;
      FcbxMandatory.Checked := False;
    end;

end; {procedure, ShowAllClickEvent}

{------------------------------------------------------------------------------}
{ TdaSearchPage.Valid }

function TdaGroupSearchPage.Valid: Boolean;
begin
  Result := True;
end; {procedure, Valid}




end.
