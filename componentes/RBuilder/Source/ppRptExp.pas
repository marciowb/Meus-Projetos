{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit ppRptExp;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}Variants,{$ENDIF}
  Windows, Classes, SysUtils, Forms, Controls, Graphics, Menus, Dialogs, ComCtrls,
  ppComm, ppDB, ppTypes, ppUtils, ppTmplat, ppEndUsr, ppClass, ppReport, ppForms,
  ppModule,
  ppFormWrapper, ppRptExpCommon,
  ppRTTI,

  ppTB2Item;


type

  {forward declarations}
  TppItemInfo = class;
  TppFolderInfo = class;

  {@TppReportExplorer

    This component is designed to give your end users the ability to save and
    organize their reports in a nested folder structure.  The interface is very
    similar to the Windows Explorer.  When this component is assigned to a
    TppDesigner (via the Designer property), it registers Open and Save dialogs
    which also support the folder metaphor. These dialogs are also very similar
    to the standard Open and Save Dialogs found in Windows.  Together these
    three dialogs give your users the illusion that they are working with
    standard Windows, when in fact all of the folders and reports are being
    saved via data pipelines.

    The Report Explorer is invoked via a call to the Execute method.

    The Report Explorer requires a minimum of two data pipelines:
    the FolderPipeline (which is used to save the folder names and
    the relations between the folders) and the ItemPipeline
    (which is used to save the report layouts along with
    supporting information such as the size of the layout, the date last
    modified, and the report name). To optimize performance use a third
    data pipeline, the ItemTemplatePipeline, to read/update the blob
    field that stores the report template and use the ItemPipeline to
    provide read-only access to the item names (and other descriptive info).

    The required structure for the tables underlying these pipelines is
    outlined in the FolderPipeline and ItemPipeline help topics respectively.

    Though the underlying tables for these data pipelines must support a minimum
    configuration, you have total control over the names of the fields within
    these tables.  The FolderFieldNames and ItemFieldNames properties allow you
    correlate the Report Explorer's required fields to the field names you've
    created in the tables.

    In order to see an example of the Report Explorer in action, check out the
    EndUser.dpr project in the RBuilder\\Demos\\EndUser directory.  In order to see how
    this example was constructed, see the 'Building an End-User Reporting
    Application' tutorial in the Developer's Guide. (The Developer's
    Guide is located in the RBuilder.doc file in the install root directory

    Additional examples of using the ReportExplorer with various data
    access component sets and database engines are installed to the
    RBuilder\\Demos\\EndUser Databases directory.}

  {@TppReportExplorer.CurrentFolderId

    The FolderId of the folder for the most recently edited report.}

  {@TppReportExplorer.CurrentItemName

    The name of the item that was most recently edited or created.}

  {@TppReportExplorer.CurrentItemType

    The type of the item that was most recently edited or created.}

  {@TppReportExplorer.Designer

    A Designer can be placed on the same form with the Report Explorer and
    assigned to the Explorer via this property.  The Explorer will display the
    assigned Designer whenever end users want to create new reports or edit
    existing reports.}

  {@TppReportExplorer.ErrorMessage

    When the Execute method returns False, the Report Explorer is not displayed.
    If ValidateSettings has been set to True, this property will contain a
    detailed message explaining why the Execute call failed.}

  {@TppReportExplorer.FolderFieldNames

    This property contains all of the field names from the FolderPipeline that
    correlate to the Folder fields required by the Explorer. This object allows
    you to use any field names you desire in your database table. The properties
    of this object have the following meanings:

    <Table>
    Field       Use
    ---------   ------
    FolderId    An integer that uniquely identifies the folder from all other
                folders in the table. This number should start with 1.
    Name        The name of the folder as given by the user.
    ParentId    The FolderId for the folder in which this folder is nested.
                Folders that appear as children to the main folder (entitled
                'All Folders') have a ParentId of 0 and are considered 'root'
                folders.  Root folders are always displayed in the Open and
                Save dialogs accessible from the Report Designer File | Open and
                File | Save As... menu options. Note: The main folder (entitled
                'All Folders') is hard-coded into the Report Explorer and is not
                saved as a record via the FolderPipeline.
    </Table>}

  {@TppReportExplorer.FolderOptions

    The items included in this set property control what the user can do with
    the folders displayed in the report explorer.  The properties of this object
    have the following meanings:

    <Table>
    Value	          Meaning
    -------------   -----------
    foAllowNew	    Gives the user the ability to create new folders.
    foAllowDelete	  Gives the user the ability to delete folders.  It is not
                    possible to allow the deletion of folders without also
                    allowing the deletion of items (i.e., if this setting is
                    included in FolderOptions, then ioAllowDelete will
                    automatically be added to ItemOptions).
    foAllowRename	  Gives the user the ability to rename folders.
    </Table>

    Note: FolderOptions must be set before the Report Explorer Execute method is
    called.  Changes made to these settings after the Report Explorer form has
    been displayed are ignored.}

  {@TppReportExplorer.FolderPipeline

    The FolderPipeline property should be assigned to a data pipeline that
    represents the place where folder information should be stored. The Report
    Explorer requires the following fields:

    <Table>
    Field       Type      Use
    ---------   -------   -------
    FolderId    Integer   An integer that uniquely identifies the folder from
                          all other folders in the table.
    Name        String    The name of the folder as given by the user.
    ParentId    Integer   The FolderId for the folder in which this folder is
                          nested.  Folders that appear as children to the main
                          folder (entitled 'All Folders') have a ParentId of 0
                          and are considered 'root' folders.  Root folders are
                          always displayed in the Open and Save dialogs
                          accessible from the Report Designer File | Open and
                          File | Save As...menu options. Note: The main folder
                          (entitled 'All Folders') is hard-coded into the Report
                          Explorer and is not saved as a record via the
                          FolderPipeline.
    </Table>

    Note: Use the FolderFieldNames property to specify the exact field names
    that correspond to these properties.}

  {@TppReportExplorer.Form

    After the Execute method has been called, this property contains a reference
    to the Report Explorer form. The form is usually an instance of the class
    TppReportExplorer Form,which can be found in the pp ExpFrm unit.  You can
    replace this form with an explorer form of your own using the ppRegisterForm
    capability within ReportBuilder.  For an example of this technique, see the
    CustomEx.dpr project in the Demos\EndUser directory.}

  {@TppReportExplorer.MergeMenu

    The MergeMenu is a standard Delphi menu. It is used to override the default
    sub-menus of the designer window, typically the File and Help sub-menus.

    This menu gets merged into the Report Explorer's menu at run-time. Each
    sub-menu of the Report Explorer's main menu has a unqiue GroupIndex property
    value. You can override any sub-menu by creating a custom sub-menu with the
    same GroupIndex value. You can add new sub menus by assigning a unique
    GroupIndex value.

    Note: 	When using the Report Explorer as an MDI child window, the
    MergeMenu will not work because of the way in which Delphi merges MDI child
    menus with the MDI parent form.  Therefore, you must write the code to do
    the merging using the Menu property to access the Report Explorer's menu
    items.

    <Table>
    GroupIndex  SubMenu
    ----------  -------
    10          File
    20          View
    30          Help
    </Table>}

  {@TppReportExplorer.ItemAction

    This property controls what happens when the user double-clicks on a report
    or selects the Open menu option with the list view selected.  The possible
    values are:

    <Table>
    Value	           Meaning
    --------------   ---------
    ioOpenToDesign	 Causes the Report Explorer to display the Report
                     Designer when the user opens a report or double-clicks
                     on a report.  This option is only valid when ItemOptions
                     allows design.
    ioOpenToPreview	 Causes the Report Explorer to display the Print Preview
                     Window when the user opens a report or double-clicks on
                     a report.
    </Table>

    Note: ItemAction must be set before the Report Explorer Execute method is
    called. Changes made to this property after the Report Explorer form has
    been displayed are ignored.}

  {@TppReportExplorer.ItemFieldNames

    This property contains all of the field names for the ItemPipeline which
    correlate to the item fields required by the Explorer. This object allows
    you to use any field names you desire in your database.  The properties of
    this object have the following meanings:

    <Table>
    Field       Type            Use
    ---------   ------------    ----------
    Deleted     DateTime        DateTime stamp indicates the time this item was
                                moved to the recycle bin. This field is null if
                                the item has never been deleted.
    FolderId    Integer         Identifies the folder in which this item will
                                appear. When combined with the Name and ItemType
                                fields, this value represents the 'primary key'
                                and should always be unique (for items which are
                                not in the recycle bin). The Report Explorer
                                uses the Locate method of the DataPipeline to
                                ensure that this uniqueness is enforced.
                                In simple terms, you cannot save two reports
                                with the same name in the same folder. This rule
                                does not hold for items assigned to the recycle
                                bin, which is indicated by a FolderId of -2.
    ItemType    Integer         Integer code indicates the item type.
                                (1 - report, 2- code module, 3- data module)
    Modified    DateTime        DateTime stamp indicates the last time this item
                                was modified.
    Name        String          The name of the item as given by the end user.
                                When combined with the FolderId and ItemType,
                                this value represents the 'primary key' and
                                should always be unique.
    Size        Integer         The size of the item in bytes.
    Template    Binary/Memo     The binary or memo field in which the item is to
                                be saved. When the ItemPipeline is first opened,
                                the Report Explorer will detect whether this
                                field is a memo or binary type field. It will
                                then save all templates in either ASCII or
                                binary format, based on the type of the field.
                                For more information on template formats, see
                                the Format property of the Report.Template
                                object.
    </Table>}

  {@TppReportExplorer.ItemOptions

    The items included in this set property control what the user can do with
    the report layouts and other items displayed in the report explorer.  The
    properties of this object have the following meanings:

    <Table>
    Value	              Meaning
    -------------       -------
    ioAllowDesign	      Gives the user the ability to edit report layouts (i.e.
                        launch the report designer).
    ioAllowNew	        Gives the user the ability to create new reports.
    ioAllowDelete	      Gives the user the ability to delete reports.  This
                        setting cannot be removed if folder deletion has been
                        allowed (i.e., if you allow users to delete folders via
                        FolderOptions, you can not prevent them from deleting
                        reports).
    ioAllowRename	Gives the user the ability to rename reports.
    </Table>

    Note: ItemOptions must be set before the Report Explorer Execute method is
    called. Changes made to these settings after the Report Explorer form has
    been displayed are ignored.}

  {@TppReportExplorer.ItemPipeline

    The ItemPipeline property should be assigned to a data pipeline that
    represents the place where the reports are stored.

    To optimize performance connect the ItemPipeline to a query that selects
    all fields except the Template (blob) field. Connect the
    ItemTemplatePipeline to a parameterized query that is linked to the main
    item query.

    For an example, see...

    RBuilder\\Demos\\EndUser\\ReportExplorer\\EndUser.dpr


    The Report Explorer requires the following fields for this pipeline:

    <Table>
    Field       Use
    ---------   --------------

    Deleted     DateTime stamp indicates the time this item was moved to the
                recycle bin. This field is null if the item has never been
                deleted.

    FolderId    Identifies the folder in which this item will appear. When
                combined with the Name and ItemType fields, this value
                represents the 'primary key' and should always be unique (for
                items which are not in the recycle bin).  The Report Explorer
                uses the Locate method of the DataPipeline to ensure that this
                uniqueness is enforced.  In simple terms, you cannot save two
                reports with the same name in the same folder. This rule does
                not hold for items assigned to the recycle bin, which is
                indicated by a FolderId of -2.

    ItemType    Integer code indicates the item type. (1- report, 2- code
                module, 3- data module)

    Modified    DateTime stamp indicates the last time this item was modified.

    Name        The name of the item as given by the end user.  When combined
                with the FolderId and ItemType, this value represents the
                'primary key' and should always be unique.
    Size        The size of the item in bytes.

    Template    The binary or memo field in which the item is to be saved.  When
                the ItemPipeline is first opened, the Report Explorer will
                detect whether this field is a memo or binary type field. It
                will then save all templates in either ASCII or binary format,
                based on the type of the field. For more information on template
                formats, see the Format property of the Report.Template object.
    </Table>}

  {@TppReportExplorer.ItemTemplatePipeline

    Optional. Use an ItemTemplatePipeline to optimize Report Explorer performance.

    Connect the ItemPipeline to a query that selects all fields except
    the Template (blob) field. Connect the ItemTemplatePipeline to a parameterized
    query that is linked to the main item query.

    For an example, see...

    RBuilder\\Demos\\EndUser\\ReportExplorer\\EndUser.dpr

  }

  {@TppReportExplorer.ModalForm

    Defaults to True.  When True the Report Explorer is displayed as a modal
    dialog. When False the Report Explorer is displayed as a modeless form.  If
    you intend to use the Explorer as modeless form, it is a good idea to close
    any open Report Designer window in the OnActivate of the Explorer. Launching
    several Report Designer windows can be resource intensive. You can check the
    visibility of the Report Designer via the Visible property.}

  {@TppReportExplorer.ValidateSettings

    Defaults to True.  When True, the ReportExplorer will perform checks on the
    ItemPipeline and FolderPipeline to ensure that reports and folders can be
    opened and created. If a problem is found, the Execute method returns False
    and an ErrorMessage is returned.

    You can see an example of this capability in the \\Demos\\EndUser\\EndUser.dpr
    project. Simply disconnect the FolderPipeline or ItemPipeline property and
    run the project. When you click the 'Launch' button, an error message will
    be displayed at the bottom of the Launch window.}

  TppReportExplorer = class(TppFormWrapper)
    private
      FDesigner: TppDesigner;
      FErrorMessage: String;
      FFolderFieldNames: TppFolderFieldNames;
      FFolderPipeline: TppDataPipeline;
      FForm: TForm;
      FInitialized: Boolean;
      FItemFieldNames: TppItemFieldNames;
      FItemPipeline: TppDataPipeline;
      FItemFormat: TppFormatType;
      FMergeMenu: TMainMenu;
      FModalForm: Boolean;
      FReport: TppReport;
      FRecyclingItems: Boolean;
      FSaveFormClass: TFormClass;
      FShowMessages: Boolean;
      FValidateSettings: Boolean;
      FYesToAll: Boolean;

      FItemAction: TppItemActionType;
      FItemOptions: TppItemOptions;
      FFolderOptions: TppFolderOptions;
      FItemTemplatePipeline: TppDataPipeline;

      procedure ConfigureReportTemplate;
      function CreateExplorerForm: TppCustomReportExplorer;
      procedure DeleteItemsInFolder(aFolderId: Integer);
      procedure DesignerCloseEvent(Sender: TObject; var Action: TCloseAction);
      function GetCurrentFolderId: Integer;
      function GetCurrentItemName: String;
      function GetCurrentItemType: Integer;
      function  Initialize: Boolean;
      function  ItemTypeForTemplate(aTemplate: TppTemplate): Integer;
      function  LocateFolderRecord(const aFolderName: String; aParentId: Integer): Boolean;
      function  LocateItemRecord(const aItemName: String; aItemType, aFolderId: Integer): Boolean;
      procedure ReportCreateDialogEvent(Sender: TObject; aDialog: TObject);
      procedure ReportLoadEndEvent(Sender: TObject);
      function  ReportLocateRecordEvent(Sender: TObject; const aItemName: String): Boolean;
      procedure ReportNewEvent(Sender: TObject);
      procedure ReportSaveEndEvent(Sender: TObject; aStream: TStream);
      procedure SetCurrentFolderId(const Value: Integer);
      procedure SetCurrentItemName(const Value: String);
      procedure SetDesigner(aDesigner: TppDesigner);
      procedure SetFolderFieldNames(aFolderFieldNames: TppFolderFieldNames);
      procedure SetFolderOptions(aFolderOptions: TppFolderOptions);
      procedure SetFolderPipeline(aFolderPipeline: TppDataPipeline);
      procedure SetMergeMenu(aMenu: TMainMenu);
      procedure SetItemFieldNames(aItemFieldNames: TppItemFieldNames);
      procedure SetItemAction(aItemAction: TppItemActionType);
      procedure SetItemOptions(aItemOptions: TppItemOptions);
      procedure SetItemPipeline(aItemPipeline: TppDataPipeline);
      procedure SetItemTemplatePipeline(aItemPipeline: TppDataPipeline);


    protected
      function  GetForm: TForm; override;

      procedure AfterShowForm; override;
      function  BeforeShowForm: Boolean; override;
      function  MoveFolderToFolder(aFolderId, aNewParentId: Integer): Boolean;
      function  MoveFoldersToFolder(aOldFolderId, aNewFolderId: Integer): Boolean;
      function  MoveItemToFolder(const aItemName: String; aItemType, aFolderId, aNewFolderId: Integer): Boolean;
      function  MoveItemsToFolder(aOldFolderId, aNewFolderId: Integer): Boolean;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
      procedure Notification(aComponent: TComponent; Operation: TOperation); override;

      function  Execute: Boolean; virtual;

      procedure SetReport(aReport: TppReport); virtual;
      function  ValidSettings: Boolean; virtual;

      {item routines}
      function  ChangeFolder(const aItemName: String; aItemType, aFolderId, aNewFolderId: Integer): Boolean; virtual;
      procedure Delete(const aItemName: String; aItemType, aFolderId: Integer); virtual;
      procedure FreeItems(aList: TStrings);
      function  GetNewReportName(aFolderId: Integer): String; virtual;
      procedure GetItems(aFolderId, aItemType: Integer; aList: TStrings); virtual;
      function  IsReport(const aItemName: String; aFolderId: Integer): Boolean; virtual;
      procedure LoadReport(const aReportName: String; aFolderId: Integer); virtual;
      procedure New(aFolderId: Integer);
      procedure Open(const aReportName: String; aFolderId: Integer); virtual;
      procedure Print(const aReportName: String; aFolderId: Integer); virtual;
      procedure PrintPreview(const aReportName: String; aFolderId: Integer); virtual;
      procedure Rename(const aItemName, aNewName: String; aItemType, aFolderId: Integer); virtual;
      procedure SaveReport(const aReportName: String; aFolderId: Integer); virtual;
      procedure SendEmail(aSelectedList: TStringList; aFolderId: Integer); virtual;
      function  ValidItemName(const aItemName: String; aItemType, aFolderId: Integer): Boolean; virtual;

      {folder routines}
      procedure AddFolder(aParentId: Integer; aFolderName: String; var aFolderId: Integer); virtual;
      function  ChangeParentFolder(aFolderId, aNewParentId: Integer): Boolean; virtual;
      function  DeleteFolder(aFolderId: Integer): Boolean; virtual;
      procedure GetChildFolders(aFolderId: Integer; aList: TStrings); virtual;
      function  GetParentId(aFolderId: Integer): Integer; virtual;
      function  GetNewFolderName(aParentId: Integer): String; virtual;
      function  GetFolderName(aFolderId: Integer): String; virtual;
      procedure GetFolders(aList: TStrings); virtual;
      procedure GetParentFolders(aFolderId: Integer; aList: TStrings); virtual;
      procedure RenameFolder(aFolderId: Integer; const aNewName: String); virtual;
      function  ValidFolderName(aParentId: Integer; aFolderName: String): Boolean; virtual;

      {confirmation routines}
      function  ConfirmDeleteFolder(const aFolderName: String): Boolean; virtual;
      function  ConfirmDeleteFolders(aList: TStrings): Boolean; virtual;
      function  ConfirmDeleteItem(const aItemName: String): Boolean; virtual;
      function  ConfirmDeleteItems(aList: TStrings): Boolean; virtual;
      function  ConfirmRecycleItem(const aItemName: String): Boolean; virtual;
      function  ConfirmRecycleItems(aList: TStrings): Boolean; virtual;
      function  ConfirmRenameFolder(const aOldName, aNewName: String; aParentId: Integer): Boolean; virtual;
      function  ConfirmRenameItem(const aOldName, aNewName: String; aItemType, aFolderId: Integer): Boolean; virtual;
      function  ConfirmReplaceFolder(const aFolderName: String): Word; virtual;
      function  ConfirmReplaceItem(const aItemName: String): Boolean; virtual;
      procedure RejectMoveFolder(const aFolderName: String); virtual;
      procedure RejectMoveItem(const aItemName: String); virtual;

      property CurrentItemName: String read GetCurrentItemName write SetCurrentItemName;
      property CurrentItemType: Integer read GetCurrentItemType;
      property CurrentFolderId: Integer read GetCurrentFolderId write SetCurrentFolderId;
      property ErrorMessage: String read FErrorMessage;
      property Form: TForm read GetForm;
      property Initialized: Boolean read FInitialized write FInitialized;

    published
      property Designer: TppDesigner read FDesigner write SetDesigner;
      property FolderFieldNames: TppFolderFieldNames read FFolderFieldNames write SetFolderFieldNames;
      property FolderOptions: TppFolderOptions read FFolderOptions write SetFolderOptions default cDefaultFolderOptions;
      property FolderPipeline: TppDataPipeline read FFolderPipeline write SetFolderPipeline;
      property ItemFieldNames: TppItemFieldNames read FItemFieldNames write SetItemFieldNames;
      property ItemAction: TppItemActionType read FItemAction write SetItemAction default iaOpenToDesign;
      property ItemOptions: TppItemOptions read FItemOptions write SetItemOptions default cDefaultItemOptions;
      property ItemPipeline: TppDataPipeline read FItemPipeline write SetItemPipeline;
      property ItemTemplatePipeline: TppDataPipeline read FItemTemplatePipeline write SetItemTemplatePipeline;
      property MergeMenu: TMainMenu read FMergeMenu write SetMergeMenu;
      property ModalForm: Boolean read FModalForm write FModalForm default True;
      property ValidateSettings: Boolean read FValidateSettings write FValidateSettings default True;

      {form wrapper properties}
      property FormCaption;
      property FormStyle;
      property FormIcon;
      property FormPosition;
      property FormHeight;
      property FormLeft;
      property FormTag;
      property FormTop;
      property FormWidth;
      property FormState;

      {form wrapper events}
      property OnActivate;
      property OnClose;
      property OnCloseQuery;
      property OnCreate;
      property OnDeactivate;
      property OnDestroy;
      property OnHide;
      property OnResize;
      property OnShow;

  end; {class, TppReportExplorer}


  {@TppFolderInfo }
  TppFolderInfo = class
    private
      FName: String;
      FFolderId: Integer;
      FParentId: Integer;

    public
      property Name: String read FName write FName;
      property FolderId: Integer read FFolderId write FFolderId;
      property ParentId: Integer read FParentId write FParentId;
  end;

  {@TppItemInfo }
  TppItemInfo = class
    private
      FDeleted: TDateTime;
      FFolderId: Integer;
      FItemId: Integer;
      FModified: TDateTime;
      FName: String;
      FSize: Integer;
      FItemType: Integer;

    public
      property Deleted: TDateTime read FDeleted write FDeleted;
      property FolderId: Integer read FFolderId write FFolderId;
      property ItemId: Integer read FItemId write FItemId;
      property Modified: TDateTime read FModified write FModified;
      property Name: String read FName write FName;
      property Size: Integer read FSize write FSize;
      property ItemType: Integer read FItemType write FItemType;

  end;

  {@TppItemList }
  TppItemList = class(TListView)
    private
      FAllFolders: Boolean;
      FFolderId: Integer;
      FFoldersInSelection: Boolean;
      FImageList: TImageList;
      FItemTypeFilter: Integer;
      FLanguageIndex: Longint;
      FOnDoubleClick: TNotifyEvent;
      FOnDragOver: TDragOverEvent;
      FOnFolderChange: TNotifyEvent;
      FOnRenameFolder: TppRenameFolderEvent;
      FOnSelectionChange: TNotifyEvent;
      FReportExplorer: TppReportExplorer;
      FSelectionCount: Integer;
      FSelectionSize: Integer;
      FSortMode: Integer;

      procedure DoOnDoubleClick;
      procedure DoOnDragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
      procedure DoOnFolderChange;
      procedure DoOnRenameFolder(aFolderId: Integer; const aNewName: String);
      procedure DoOnSelectionChange;
      function  GetItemId: Integer;
      function  GetItemName: String;
      function  GetItemType: Integer;
      procedure LanguageChanged;
      procedure SetLanguageIndex(aLanguageIndex: Longint);
      procedure GetSelectedItems(aList: TStrings);
      procedure SetFolderId(aFolderId: Integer);
      procedure SetItemName(aName: String);
      procedure SetReportExplorer(aExplorer: TppReportExplorer);
      procedure SetSortMode(aSortMode: Integer);

      {event handlers}
      procedure ChangeEvent(Sender: TObject; Item: TListItem; Change: TItemChange);
      procedure CompareEvent(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
      procedure ColumnClickEvent(Sender: TObject; Column: TListColumn);
      procedure DblClickEvent(Sender: TObject);
      procedure DragDropEvent(Sender, Source: TObject; X, Y: Integer);
      procedure DragOverEvent(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
      procedure EditedEvent(Sender: TObject; Item: TListItem; var S: String);
      procedure EditingEvent(Sender: TObject; Item: TListItem; var AllowEdit: Boolean);

    protected
      procedure SetParent(aParent: TWinControl); override;
      procedure GetItemsForFolder; virtual;
      procedure SetSortModeDescription; virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure DeleteSelection;
      procedure EmptyRecycleBin;
      procedure MoveSelectionToFolder(aFolderId: Integer);
      procedure RenameItem;

      property AllFolders: Boolean read FAllFolders;
      property FolderId: Integer read FFolderId write SetFolderId;
      property FoldersInSelection: Boolean read FFoldersInSelection;
      property ItemName: String read GetItemName write SetItemName;
      property ItemId: Integer read GetItemId;
      property ItemType: Integer read GetItemType;
      property ItemTypeFilter: Integer read FItemTypeFilter write FItemTypeFilter;
      property LanguageIndex: Longint read FLanguageIndex write SetLanguageIndex;
      property ReportExplorer: TppReportExplorer read FReportExplorer write SetReportExplorer;
      property SelectionCount: Integer read FSelectionCount;
      property SelectionSize: Integer read FSelectionSize;
      property SortMode: Integer read FSortMode write SetSortMode;

      property OnDragOver: TDragOverEvent read FOnDragOver write FOnDragOver;
      property OnDoubleClick: TNotifyEvent read FOnDoubleClick write FOnDoubleClick;
      property OnFolderChange: TNotifyEvent read FOnFolderChange write FOnFolderChange;
      property OnRenameFolder: TppRenameFolderEvent read FOnRenameFolder write FOnRenameFolder;
      property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;

  end; {class, TppItemList}


implementation

uses
  ppDesignLayoutMenu,
  ppExpDlg,
  ppExpFrm,
  ppEmail;

{******************************************************************************
 *
 ** I T E M   L I S T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppItemList.Create }

constructor TppItemList.Create(aOwner: TComponent);
var
  lBitmap: TBitmap;
begin

  inherited Create(aOwner);

  FAllFolders := False;
  FFolderId := 0;
  FFoldersInSelection := False;
  FItemTypeFilter := itAllFolders;
  FOnDoubleClick := nil;
  FOnDragOver := nil;
  FOnFolderChange := nil;
  FOnRenameFolder := nil;
  FOnSelectionChange := nil;
  FReportExplorer := nil;
  FSelectionCount := 0;
  FSelectionSize := 0;
  FSortMode := 1;

  OnChange := ChangeEvent;
  OnColumnClick := ColumnClickEvent;
  OnCompare := CompareEvent;
  OnDblClick := DblClickEvent;
  OnDragDrop := DragDropEvent;
  OnDragOver := DragOverEvent;
  OnEdited := EditedEvent;
  OnEditing := EditingEvent;

  DragCursor := crDefault;
  DragMode := dmAutomatic;
  SortType := stText;
  MultiSelect := True;

  FImageList := TImageList.Create(Self);
  FImageList.Width := 16;
  FImageList.Width := 16;

  lBitmap := TBitmap.Create;

  lBitmap.Handle := ppBitmapFromResource(UpperCase('TppSubReport'));
  FImageList.AddMasked(lBitmap, clSilver);

  lBitmap.Handle := ppBitmapFromResource(UpperCase('ppCodeModule'));
  FImageList.AddMasked(lBitmap, clWhite);

  lBitmap.Handle := ppBitmapFromResource(UpperCase('ppDataModule'));
  FImageList.AddMasked(lBitmap, lBitmap.TransparentColor);

  lBitmap.Handle := ppBitmapFromResource(UpperCase('ppFolder'));
  FImageList.AddMasked(lBitmap, clWhite);

  lBitmap.Free;

  SmallImages := FImageList;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppItemList.Destroy }

destructor TppItemList.Destroy;
begin

  FImageList.Free;

  inherited Destroy;

end; {destructor, Destroy}


{------------------------------------------------------------------------------}
{ TppItemList.Destroy }

procedure TppItemList.SetParent(aParent: TWinControl);
var
  lColumn: TListColumn;

begin

  inherited SetParent(aParent);

  if (csDestroying in ComponentState) or (Columns.Count > 0) then Exit;

  {create columns - must do this after parent is assigned}
  lColumn := Columns.Add;
  lColumn.Width := 250;

  lColumn := Columns.Add;
  lColumn.Width := 120;
  lColumn.Alignment := taRightJustify;

  lColumn := Columns.Add;
  lColumn.Width := 100;

  lColumn := Columns.Add;
  lColumn.Width := 140;


end; {procedure, SetParent}

{------------------------------------------------------------------------------}
{ TppItemList.SetReportExplorer }

procedure TppItemList.SetReportExplorer(aExplorer: TppReportExplorer);
begin
  FReportExplorer := aExplorer;
end; {procedure, SetReportExplorer}

{------------------------------------------------------------------------------}
{ TppItemList.SetLanguageIndex }

procedure TppItemList.SetLanguageIndex(aLanguageIndex: Longint);
begin
  FLanguageIndex := aLanguageIndex;

  LanguageChanged;
end; {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppItemList.SetItemName }

procedure TppItemList.SetItemName(aName: String);
var
  lbFound: Boolean;
  liIndex: Integer;
  lItem: TListItem;
begin

  lItem := nil;
  lbFound := False;
  liIndex := 0;

  while not(lbFound) and (liIndex < Items.Count) do
    begin
      lItem := Items[liIndex];

      if (CompareText(lItem.Caption, aName) = 0) then
        lbFound := True
      else
        Inc(liIndex);

    end;

  if lbFound then
    begin
      Selected := lItem;

      DoOnSelectionChange;
    end;

end; {procedure, SetItemName}

{------------------------------------------------------------------------------}
{ TppItemList.LanguageChanged }

procedure TppItemList.LanguageChanged;
begin

  SetSortModeDescription;

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppItemList.SetFolderId }

procedure TppItemList.SetFolderId(aFolderId: Integer);
begin

  FFolderId := aFolderId;

  GetItemsForFolder;

end; {constructor, SetFolderId}

{------------------------------------------------------------------------------}
{ TppItemList.SetSortMode }

procedure TppItemList.SetSortMode(aSortMode: Integer);
begin

  FSortMode := aSortMode;

  SetSortModeDescription;

  AlphaSort;


end; {procedure, SetSortMode}

{------------------------------------------------------------------------------}
{ TppItemList.GetItemId }

function TppItemList.GetItemId: Integer;
begin

  if FReportExplorer.LocateItemRecord(GetItemName, GetItemType, FFolderId) then
    begin
      Result :=  FReportExplorer.ItemPipeline.GetFieldValue(FReportExplorer.ItemFieldNames.ItemId);
    end
  else
    Result := -1;

end; {function, GetItemId}

{------------------------------------------------------------------------------}
{ TppItemList.GetItemType }

function TppItemList.GetItemType: Integer;
var
  lItem: TListItem;
begin
  lItem := Selected;

  if (lItem <> nil) then
    Result := lItem.ImageIndex + 1
  else
    Result := -1;

end; {function, GetItemType}

{------------------------------------------------------------------------------}
{ TppItemList.GetItemName }

function TppItemList.GetItemName: String;
var
  lItem: TListItem;
begin
  lItem := Selected;

  if (lItem <> nil) then
    Result := lItem.Caption
  else
    Result := '';

end; {function, GetItemName}

{------------------------------------------------------------------------------}
{ TppItemList.DoOnDoubleClick }

procedure TppItemList.DoOnDoubleClick;
begin
  if Assigned(FOnDoubleClick) then FOnDoubleClick(Self);
end; {procedure, DoOnDoubleClick}

{------------------------------------------------------------------------------}
{ TppItemList.DoOnFolderChange }

procedure TppItemList.DoOnFolderChange;
begin
  if Assigned(FOnFolderChange) then FOnFolderChange(Self);
end; {procedure, DoOnFolderChange}

{------------------------------------------------------------------------------}
{ TppItemList.DoOnRenameFolder }

procedure TppItemList.DoOnRenameFolder(aFolderId: Integer; const aNewName: String);
begin
  if Assigned(FOnRenameFolder) then FOnRenameFolder(Self, aFolderId, aNewName);
end; {procedure, DoOnRenameFolder}

{------------------------------------------------------------------------------}
{ TppItemList.DoOnSelectionChange }

procedure TppItemList.DoOnSelectionChange;
begin
  if Assigned(FOnSelectionChange) then FOnSelectionChange(Self);
end; {procedure, DoOnSelectionChange}

{------------------------------------------------------------------------------}
{ TppItemList.ChangeEvent }

procedure TppItemList.ChangeEvent(Sender: TObject; Item: TListItem; Change: TItemChange);
var
  lItem: TListItem;
  liCount: Integer;
  liSize: Integer;
  lsSize: String;
  lItems: TStrings;
  liIndex: Integer;
begin

  lItems := TStringList.Create;

  GetSelectedItems(lItems);

  liCount := lItems.Count;
  liSize := 0;
  FAllFolders := True;
  FFoldersInSelection := False;

  for liIndex := 0 to lItems.Count - 1 do
    begin
      lItem := TListItem(lItems.Objects[liIndex]);

      if ((lItem.ImageIndex + 1) <> itFolder) then
        begin
          FAllFolders := False;

          lsSize := lItem.SubItems[0];
          lsSize := Copy(lsSize, 1, Length(lsSize) - Length(ppLoadStr(565))); {'KB'}

          liSize := liSize + (StrToInt(lsSize) * 1000);
        end
      else
       FFoldersInSelection := True;

    end;

  lItems.Free;

  FSelectionCount := liCount;
  FSelectionSize := liSize;

  DoOnSelectionChange;

end; {procedure, ChangeEvent}

{------------------------------------------------------------------------------}
{ TppItemList.DblClickEvent }

procedure TppItemList.DblClickEvent(Sender: TObject);
var
  lItem: TListItem;
begin

  lItem := Selected;

  if (lItem = nil) then Exit;

  if ((lItem.ImageIndex + 1) = itFolder) then
    begin
      FFolderId := Integer(lItem.Data);

      GetItemsForFolder;

      DoOnFolderChange;
    end

  else
    DoOnDoubleClick;

end; {procedure, DblClickEvent}

{------------------------------------------------------------------------------}
{ TppItemList.ColumnClickEvent }

procedure TppItemList.ColumnClickEvent(Sender: TObject; Column: TListColumn);
begin

  if (FSortMode = (Column.Index + 1)) then
    SetSortMode(FSortMode * -1)
  else
    SetSortMode(Column.Index + 1);

end; {procedure, ColumnClickEvent}

{------------------------------------------------------------------------------}
{ TppItemList.CompareEvent }

procedure TppItemList.CompareEvent(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
var
  liSize1: Integer;
  liSize2: Integer;
  ldDateTime1: TDateTime;
  ldDateTime2: TDateTime;
  liDiff: Double;
begin

  {both items are folders}
  if ((Item1.ImageIndex + 1) = itFolder) and ((Item2.ImageIndex + 1) = itFolder) then
    begin
      case FSortMode of
        1: Compare := CompareText(Item1.Caption, Item2.Caption);

       -1: Compare := CompareText(Item2.Caption, Item1.Caption);
      end;
    end

  {first item is folder}
  else if ((Item1.ImageIndex + 1) = itFolder) then
    Compare := -1

  {second item is folder}
  else if ((Item2.ImageIndex + 1) = itFolder) then
    Compare := 1

  {neither item is folder}
  else
  case FSortMode of
     1: Compare := CompareText(Item1.Caption, Item2.Caption);

    -1: Compare := CompareText(Item2.Caption, Item1.Caption);

    2, -2:
      begin
        liSize1 := StrToInt(Copy(Item1.SubItems[0], 1, Length(Item1.SubItems[0]) - Length(ppLoadStr(565)))); {'KB'}
        liSize2 := StrToInt(Copy(Item2.SubItems[0], 1, Length(Item2.SubItems[0]) - Length(ppLoadStr(565)))); {'KB'}

        if (FSortMode = 2) then
          Compare := liSize1 - liSize2
        else
          Compare := liSize2 - liSize1;

      end;

     3: Compare := CompareText(Item1.SubItems[1], Item2.SubItems[1]);

    -3: Compare := CompareText(Item2.SubItems[1], Item1.SubItems[1]);

    4, -4:
      begin
        ldDateTime1 := ppStrToDateTime(Item1.SubItems[2]);
        ldDateTime2 := ppStrToDateTime(Item2.SubItems[2]);

        if (FSortMode = 4) then
          liDiff := ldDateTime1 - ldDateTime2
        else
          liDiff := ldDateTime2 - ldDateTime1;

        if (liDiff > 0) then
          Compare := 1
        else if (liDiff < 0) then
          Compare := -1
        else
          Compare := 0;
      end;
  end;

  if (Compare = 0) then
    Compare := CompareText(Item1.Caption, Item2.Caption);

end; {procedure, CompareEvent}

{------------------------------------------------------------------------------}
{ TppItemList.DragDropEvent }

procedure TppItemList.DragDropEvent(Sender, Source: TObject; X, Y: Integer);
var
  lTargetItem: TListItem;
begin

  lTargetItem := GetItemAt(X, Y);

  if (lTargetItem = nil) then Exit;

  if ((lTargetItem.ImageIndex + 1) <> itFolder) then Exit;

  MoveSelectionToFolder(Integer(lTargetItem.Data));

end; {procedure, DragDropEvent}

{------------------------------------------------------------------------------}
{ TppItemList.DragOverEvent }

procedure TppItemList.DragOverEvent(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  lItem: TListItem;
begin

  lItem := GetItemAt(X, Y);

  if (lItem <> nil) then
    Accept := ((lItem.ImageIndex + 1) = itFolder)
  else
    Accept := False;

  DoOnDragOver(Source, X, Y, State, Accept);

end; {procedure, DragOverEvent}

{------------------------------------------------------------------------------}
{ TppItemList.DoOnDragOver }

procedure TppItemList.DoOnDragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Assigned(FOnDragOver) then FOnDragOver(Self, Source, X, Y, State, Accept);
end; {procedure, DoOnDragOver}

{------------------------------------------------------------------------------}
{ TppItemList.EditingEvent }

procedure TppItemList.EditingEvent(Sender: TObject; Item: TListItem; var AllowEdit: Boolean);
begin

  if (FFolderId = itRecycleBin) then
    AllowEdit := False
  else if ((Item.ImageIndex + 1) = itFolder) then
    AllowEdit := (foAllowRename in FReportExplorer.FolderOptions)
  else
    AllowEdit := (ioAllowRename in FReportExplorer.ItemOptions);

end; {procedure, EditingEvent}

{------------------------------------------------------------------------------}
{ TppItemList.EditedEvent }

procedure TppItemList.EditedEvent(Sender: TObject; Item: TListItem; var S: String);
var
  liParentId: Integer;
begin

  if ((Item.ImageIndex + 1) = itFolder) then
    begin
      liParentId := FReportExplorer.GetParentId(Integer(Item.Data));

      if FReportExplorer.ConfirmRenameFolder(Item.Caption, S, liParentId) then
        begin
          DoOnRenameFolder(Integer(Item.Data), S);

          FReportExplorer.RenameFolder(Integer(Item.Data), S)
        end
      else
        S := Item.Caption;
    end
  else
    begin
      if FReportExplorer.ConfirmRenameItem(Item.Caption, S, Item.ImageIndex + 1, Integer(Item.Data)) then
        FReportExplorer.Rename(Item.Caption, S, Item.ImageIndex + 1, Integer(Item.Data))
      else
        S := Item.Caption;
    end;

end; {procedure, EditedEvent}

{------------------------------------------------------------------------------}
{ TppItemList.MoveSelectionToFolder }

procedure TppItemList.MoveSelectionToFolder(aFolderId: Integer);
var
  lItem: TListItem;
  liIndex: Integer;
  lItems: TStrings;
  lbChange: Boolean;
  lbFolderChange: Boolean;
begin

  lItems := TStringList.Create;

  GetSelectedItems(lItems);

  lbChange := False;
  lbFolderChange := False;

  for liIndex := 0 to lItems.Count - 1 do
    begin
      lItem := TListItem(lItems.Objects[liIndex]);

      if ((lItem.ImageIndex + 1) = itFolder) then
        begin
          if FReportExplorer.ChangeParentFolder(Integer(lItem.Data), aFolderId) then
            lbFolderChange :=  True;
        end
      else
        begin
          if FReportExplorer.ChangeFolder(lItem.Caption, lItem.ImageIndex + 1, Integer(lItem.Data), aFolderId) then
            lbChange := True;
        end;
    end;

  lItems.Free;

  if lbFolderChange then
    DoOnFolderChange

  else if lbChange then
    GetItemsForFolder;

end; {procedure, MoveSelectionToFolder}

{------------------------------------------------------------------------------}
{ TppItemList.EmptyRecycleBin }

procedure TppItemList.EmptyRecycleBin;
var
  lbConfirmed: Boolean;
  lItems: TStringList;
  liIndex: Integer;
begin

  lItems := TStringList.Create;

  FReportExplorer.GetItems(itRecycleBin, itAllFolders, lItems);

  lbConfirmed := FReportExplorer.ConfirmDeleteItems(lItems);

  for liIndex := 0 to lItems.Count - 1 do
    TppItemInfo(lItems.Objects[liIndex]).Free;

  if (lbConfirmed) then
    begin
      FReportExplorer.DeleteItemsInFolder(itRecycleBin);

      DoOnFolderChange;
    end;

  lItems.Free;

end; {procedure, EmptyRecycleBin}

{------------------------------------------------------------------------------}
{ TppItemList.DeleteSelection }

procedure TppItemList.DeleteSelection;
var
  lItem: TListItem;
  lItems: TStrings;
  liIndex: Integer;
  lbConfirmed: Boolean;
  lbFolderChange: Boolean;
begin

  lItems := TStringList.Create;

  GetSelectedItems(lItems);

  if (FFolderId = itRecycleBin) then
    lbConfirmed := FReportExplorer.ConfirmDeleteItems(lItems)
  else
    lbConfirmed := FReportExplorer.ConfirmRecycleItems(lItems);

  if not(lbConfirmed) then Exit;

  Items.BeginUpdate;

  lbFolderChange := False;

  for liIndex := 0 to lItems.Count - 1 do
    begin
      lItem := TListItem(lItems.Objects[liIndex]);

      if ((lItem.ImageIndex + 1) = itFolder) then
        lbFolderChange :=  True;

      if (FFolderId = itRecycleBin) then
        FReportExplorer.Delete(lItem.Caption, lItem.ImageIndex + 1, Integer(lItem.Data))
      else
        begin
          if ((lItem.ImageIndex + 1) = itFolder) then
            FReportExplorer.ChangeParentFolder(Integer(lItem.Data), -2)
          else
            FReportExplorer.ChangeFolder(lItem.Caption, lItem.ImageIndex + 1, Integer(lItem.Data), -2);
        end;

      lItem.Free;
    end;

  lItems.Free;

  Items.EndUpdate;

  if lbFolderChange then
    DoOnFolderChange;

end; {procedure, DeleteSelection}

{------------------------------------------------------------------------------}
{ TppItemList.RenameItem }

procedure TppItemList.RenameItem;
var
  lItem: TListItem;
begin

  lItem := Selected;

  if (lItem <> nil) and (Integer(lItem.Data) >= 0) then
    lItem.EditCaption;

end; {procedure, RenameItem}

{------------------------------------------------------------------------------}
{ TppItemList.SetSortModeDescription }

procedure TppItemList.SetSortModeDescription;
var
  lsSortDesc: String;
  liIndex: Integer;
begin

  Columns[0].Caption := ppLoadStr(569); {Name}
  Columns[1].Caption := ppLoadStr(583); {Size}
  Columns[2].Caption := ppLoadStr(588); {Type}
  Columns[3].Caption := ppLoadStr(568); {Modified}

  case FSortMode of
      1: lsSortDesc := ' ' + ppLoadStr(515); {(a > z)}
     -1: lsSortDesc := ' ' + ppLoadStr(520); {(z > a)}
      2: lsSortDesc := ' ' + ppLoadStr(519); {(small > large)}
     -2: lsSortDesc := ' ' + ppLoadStr(516); {(large > small)}
      3: lsSortDesc := ' ' + ppLoadStr(515); {(a > z)}
     -3: lsSortDesc := ' ' + ppLoadStr(520); {(z > a)}
      4: lsSortDesc := ' ' + ppLoadStr(518); {(older > newer)}
     -4: lsSortDesc := ' ' + ppLoadStr(517); {(newer > older)}
  end;

  if (FSortMode < 0) then
    liIndex := (FSortMode * -1) - 1
  else
    liIndex := FSortMode - 1;

 Columns[liIndex].Caption := Columns[liIndex].Caption + lsSortDesc;

end; {procedure, SetSortModeDescription}

{------------------------------------------------------------------------------}
{ TppItemList.GetSelectedItems }

procedure TppItemList.GetSelectedItems(aList: TStrings);
var
  lItem: TListItem;
begin

  lItem := Selected;

  while (lItem <> nil) do
    begin
      aList.AddObject(lItem.Caption, lItem);

      lItem := GetNextItem(lItem, sdAll, [isSelected]);
    end;

end; {procedure, GetSelectedItems}

{------------------------------------------------------------------------------}
{ TppItemList.GetItemsForFolder }

procedure TppItemList.GetItemsForFolder;
var
  lFolders: TStringList;
  lFolderInfo: TppFolderInfo;
  lItemNames: TStringList;
  lItem: TListItem;
  liIndex: Integer;
  lItemInfo: TppItemInfo;
  liTotalSize: Integer;
begin

  lFolders := TStringList.Create;
  lItemNames := TStringList.Create;

  Items.BeginUpdate;

  Items.Clear;

  FReportExplorer.GetChildFolders(FFolderId, lFolders);

  for liIndex := 0 to lFolders.Count - 1 do
    begin
      lFolderInfo := TppFolderInfo(lFolders.Objects[liIndex]);

      lItem := Items.Add;

      lItem.Caption := lFolderInfo.Name;
      lItem.Data := TObject(lFolderInfo.FolderId);
      lItem.ImageIndex := itFolder - 1;

      lItem.SubItems.Add('');
      lItem.SubItems.Add(ppGetTypeDesc(itFolder));

      lFolderInfo.Free;
    end;

  if (FItemTypeFilter <> itAllFolders) then
    FReportExplorer.GetItems(FFolderId, FItemTypeFilter, lItemNames)
  else
    FReportExplorer.GetItems(FFolderId, itAllFolders, lItemNames);

  liTotalSize := 0;

  for liIndex := 0 to lItemNames.Count - 1 do
    begin
      lItemInfo := TppItemInfo(lItemNames.Objects[liIndex]);

      lItem := Items.Add;

      lItem.Caption := lItemInfo.Name;
      lItem.ImageIndex := lItemInfo.ItemType - 1;
      lItem.Data := TObject(lItemInfo.FolderId);
//      lItem.Data := TObject(lItemInfo.ItemId);

      lItem.SubItems.Add(IntToStr(lItemInfo.Size div 1000) + ppLoadStr(565)); {KB}
      lItem.SubItems.Add(ppGetTypeDesc(lItemInfo.ItemType));
      lItem.SubItems.Add(FormatDateTime(ShortDateFormat + ' ' + ShortTimeFormat, lItemInfo.Modified));

      liTotalSize := liTotalSize + lItemInfo.Size;

      lItemInfo.Free;
    end;

  FSelectionCount := lItemNames.Count;
  FSelectionSize := liTotalSize;

  lFolders.Free;
  lItemNames.Free;

  Items.EndUpdate;

  AlphaSort;

end; {procedure, GetItemsForFolder}


{******************************************************************************
 *
 ** R E P O R T   E X P L O R E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportExplorer.Create }

constructor TppReportExplorer.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDesigner := nil;
  FErrorMessage := '';
  FFolderFieldNames := TppFolderFieldNames.Create(Self);
  FFolderOptions := cDefaultFolderOptions;
  FFolderPipeline := nil;
  FForm := nil;
  FMergeMenu := nil;
  FReport := nil;
  FInitialized := False;
  FItemAction := iaOpenToDesign;
  FItemOptions := cDefaultItemOptions;
  FItemFieldNames := TppItemFieldNames.Create(Self);
  FItemFormat := ftBinary;
  FItemPipeline := nil;
  FModalForm := True;
  FValidateSettings := True;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppReportExplorer.Destroy }

destructor TppReportExplorer.Destroy;
begin

  FFolderFieldNames.Free;
  FItemFieldNames.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppReportExplorer.Notify }

procedure TppReportExplorer.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation <> ppopRemove) then Exit;

  if (aCommunicator = FFolderPipeline) then
    FFolderPipeline := nil

  else if (aCommunicator = FItemPipeline) then
    FItemPipeline := nil

  else if (aCommunicator = FDesigner) then
    FDesigner := nil

  else if (aCommunicator = FReport) then
    FReport := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppReportExplorer.Notification }

procedure TppReportExplorer.Notification(aComponent: TComponent; Operation: TOperation);
begin

  inherited Notification(aComponent, Operation);

  if (aComponent = FMergeMenu) and (Operation = opRemove) then
    FMergeMenu := nil;

end; {procedure, Notification}

{------------------------------------------------------------------------------}
{ TppReportExplorer.GetForm }

function TppReportExplorer.GetForm: TForm;
begin

  Result := nil;

  if (csDesigning in ComponentState) or (csReading in ComponentState)  then Exit;

  if FForm <> nil then
    Result := FForm
  else
    Result := CreateExplorerForm;

end; {function, GetForm}

{------------------------------------------------------------------------------}
{ TppReportExplorer.Initialize }

function TppReportExplorer.Initialize: Boolean;
var
  lMenuBar: TppDesignerMenu;
begin

  Result := FInitialized;

  if (FInitialized) then Exit;

  if (FDesigner <> nil) then
    begin
      SetReport(FDesigner.Report);

      FDesigner.OnClose := DesignerCloseEvent;

      lMenuBar := FDesigner.Form.LayoutManager.ToolManager.Menubar;

      {set menu options based on ItemOptions}
      lMenuBar.FileMenu.New.Visible := (ioAllowNew in FItemOptions);
      lMenuBar.FileMenu.NewReport.Visible := (ioAllowNew in FItemOptions);
      lMenuBar.FileMenu.SaveAs.Visible := (ioAllowRename in FItemOptions);

    end;

  {create form here}
  if ValidSettings then
    begin
      ConfigureReportTemplate;

      FInitialized := True;
    end;

  Result := FInitialized;

end; {procedure, Initialize}

{------------------------------------------------------------------------------}
{ TppReportExplorer.BeforeShowForm }

function TppReportExplorer.BeforeShowForm: Boolean;
var
  lFormClass: TFormClass;
begin

  Result := False;

  if (csDesigning in ComponentState) then Exit;

  lFormClass := ppGetFormClass(TppCustomTemplateDialog);

  if not(lFormClass = TppOpenSaveDialog) then
    begin
      FSaveFormClass := lFormClass;
      ppRegisterForm(TppCustomTemplateDialog, TppOpenSaveDialog);
    end;

  if not(Initialize) then Exit;

  if (FForm = nil) then
    FForm := CreateExplorerForm;

  Result := True;

end; {function, BeforeShowForm}

{------------------------------------------------------------------------------}
{ TppReportExplorer.AfterShowForm }

procedure TppReportExplorer.AfterShowForm;
begin

  {restore previously registered form}
  if (FSaveFormClass <> nil) then
    ppRegisterForm(TppCustomTemplateDialog, FSaveFormClass);

  FForm.Free;

  FForm := nil;

end; {procedure, AfterShowForm}


{@TppReportExplorer.Execute
 Creates an instance of the registered Report Explorer form and displays it
 using either Show or ShowModal.  If ModalForm is set to True, then ShowModal is
 called; otherwise, Show is called.  Once it is created, the Report Explorer
 form is accessible via the Form property.

 If ValidateSettings is set to True, then Execute will first attempt to ensure
 that the FolderPipeline, ReportPipeline and other Explorer properties are
 assigned and viable. If there is a problem, then the Execute procedure will not
 create the form and will return False.  At that point a detailed message
 describing the problem will be available via the ErrorMessage property.}

function TppReportExplorer.Execute: Boolean;
begin

  Screen.Cursor := crHourglass;

  try
    Result := ValidSettings;
  finally
    Screen.Cursor := crDefault;
  end;

  if not(Result) then Exit;

  if FModalForm then
    inherited ShowModal
  else
    inherited Show;

end; {function, Execute}

{------------------------------------------------------------------------------}
{ TppReportExplorer.ValidSettings }

function TppReportExplorer.ValidSettings: Boolean;
var
  lFieldNames: TStrings;
  lDataType: TppDataType;
  lbClose: Boolean;
begin

  Result := False;

  FErrorMessage := '';


  lbClose := True;

  // for DBPipelines related to Items data, set the CloseDataSource property to true
  if (FItemPipeline <> nil) and TraRTTI.IsValidPropName(FItemPipeline, 'CloseDataSource') then
    TraRTTI.SetPropValue(FItemPipeline, 'CloseDataSource', lbClose);

  if (FItemTemplatePipeline <> nil) and TraRTTI.IsValidPropName(FItemTemplatePipeline, 'CloseDataSource') then
    TraRTTI.SetPropValue(FItemTemplatePipeline, 'CloseDataSource', lbClose);


  if not(FValidateSettings) then
    begin
      Result := True;

      Exit;
    end;

  if (FDesigner = nil) then
    begin
      {Designer property is not assigned.}
      FErrorMessage := ppLoadStr(548);
      Exit;
    end;

  if (FDesigner.Report = nil) then
    begin
      {Report property of Designer is not assigned.}
      FErrorMessage := ppLoadStr(581);
      Exit;
    end;

  if (FDesigner.DataSettings.DataDictionary <> nil) and
     (FDesigner.DataSettings.UseDataDictionary) and not(FDesigner.DataSettings.DataDictionary.ValidSettings) then
    begin
      FErrorMessage := FDesigner.DataSettings.DataDictionary.ErrorMessage;
      Exit;
    end;

  if (FItemPipeline = nil) then
    begin
      {ItemPipeline property is not assigned.}
      FErrorMessage := ppLoadStr(563);
      Exit;
    end;

  // backward compatibility and non-optimized mode
  if (FItemTemplatePipeline = nil) then
    FItemTemplatePipeline := FItemPipeline;

  {make sure pipelines can be opened}
  try
    FFolderPipeline.Open;
  except
    {FolderPipeline <name> could not be opened.}
    FErrorMessage := ppLoadStr(556);
    FErrorMessage := ppSetMessageParameters(FErrorMessage);
    FErrorMessage := Format(FErrorMessage, [FFolderPipeline.Name]);
    Exit;
  end;

  if not(FFolderPipeline.Active) then
    begin
      {FolderPipeline <name> could not be opened.}
      FErrorMessage := ppLoadStr(556);
      FErrorMessage := ppSetMessageParameters(FErrorMessage);
      FErrorMessage := Format(FErrorMessage, [FFolderPipeline.Name]);
      Exit;
    end;

  try
    FItemPipeline.Open;
  except
    {ItemPipeline <name> could not be opened.}
    FErrorMessage := ppLoadStr(564);
    FErrorMessage := ppSetMessageParameters(FErrorMessage);
    FErrorMessage := Format(FErrorMessage, [FItemPipeline.Name]);
    Exit;
  end;

  if not(FItemPipeline.Active) then
    begin
      {ItemPipeline <name> could not be opened.}
      FErrorMessage := ppLoadStr(564);
      FErrorMessage := ppSetMessageParameters(FErrorMessage);
      FErrorMessage := Format(FErrorMessage, [FItemPipeline.Name]);
      Exit;
    end;

  {make sure field names are valid}
  lFieldNames := TStringList.Create;

  FFolderPipeline.GetFieldNames(lFieldNames);

  if (lFieldNames.IndexOf(FFolderFieldNames.FolderId) = -1) then
    begin
      lFieldNames.Free;

      {FolderPipeline <name> field: '<name>' could not be found.}
      FErrorMessage := ppLoadStr(591);
      FErrorMessage := ppSetMessageParameters(FErrorMessage);
      FErrorMessage := Format(FErrorMessage, ['FolderId', FFolderFieldNames.FolderId]);

      Exit;
    end;

  if (lFieldNames.IndexOf(FFolderFieldNames.Name) = -1) then
    begin
      lFieldNames.Free;

      {FolderPipeline <name> field: '<name>' could not be found.}
      FErrorMessage := ppLoadStr(591);
      FErrorMessage := ppSetMessageParameters(FErrorMessage);
      FErrorMessage := Format(FErrorMessage, ['Name', FFolderFieldNames.Name]);

      Exit;
    end;

  if (lFieldNames.IndexOf(FFolderFieldNames.ParentId) = -1) then
    begin
      lFieldNames.Free;

      {FolderPipeline <name> field: '<name>' could not be found.}
      FErrorMessage := ppLoadStr(591);
      FErrorMessage := ppSetMessageParameters(FErrorMessage);
      FErrorMessage := Format(FErrorMessage, ['ParentId', FFolderFieldNames.ParentId]);

      Exit;
    end;

  {make sure field names are valid}
  lFieldNames.Clear;

  FItemTemplatePipeline.GetFieldNames(lFieldNames);


  if (lFieldNames.IndexOf(FItemFieldNames.Name) = -1) then
    begin
      lFieldNames.Free;

      {ItemPipeline <name> field: '<name>' could not be found.}
      FErrorMessage := ppLoadStr(561);
      FErrorMessage := ppSetMessageParameters(FErrorMessage);
      FErrorMessage := Format(FErrorMessage, ['Name', FItemFieldNames.Name]);

      Exit;
    end;

  if (lFieldNames.IndexOf(FItemFieldNames.FolderId) = -1) then
    begin
      lFieldNames.Free;

      {ItemPipeline <name> field: '<name>' could not be found.}
      FErrorMessage := ppLoadStr(561);
      FErrorMessage := ppSetMessageParameters(FErrorMessage);
      FErrorMessage := Format(FErrorMessage, ['FolderId', FItemFieldNames.FolderId]);

      Exit;
    end;

  if (lFieldNames.IndexOf(FItemFieldNames.Modified) = -1) then
    begin
      lFieldNames.Free;

      {ItemPipeline <name> field: '<name>' could not be found.}
      FErrorMessage := ppLoadStr(561);
      FErrorMessage := ppSetMessageParameters(FErrorMessage);
      FErrorMessage := Format(FErrorMessage, ['Modified', FItemFieldNames.Modified]);

      Exit;
    end;

  if (lFieldNames.IndexOf(FItemFieldNames.Size) = -1) then
    begin
      lFieldNames.Free;

      {ItemPipeline <name> field: '<name>' could not be found.}
      FErrorMessage := ppLoadStr(561);
      FErrorMessage := ppSetMessageParameters(FErrorMessage);
      FErrorMessage := Format(FErrorMessage, ['Size', FItemFieldNames.Size]);

      Exit;
    end;

  if (lFieldNames.IndexOf(FItemFieldNames.Template) = -1) then
    begin
      lFieldNames.Free;

      // ItemPipeline <name> field: '<name>' could not be found.
      FErrorMessage := ppLoadStr(561);
      FErrorMessage := ppSetMessageParameters(FErrorMessage);
      FErrorMessage := Format(FErrorMessage, ['Template', FItemFieldNames.Template]);

      Exit;
    end;


  if (lFieldNames.IndexOf(FItemFieldNames.ItemId) = -1) then
    begin
      lFieldNames.Free;

      {ItemPipeline <name> field: '<name>' could not be found.}
      FErrorMessage := ppLoadStr(561);
      FErrorMessage := ppSetMessageParameters(FErrorMessage);
      FErrorMessage := Format(FErrorMessage, ['ItemId', FItemFieldNames.ItemId]);

      Exit;
    end;

  if (lFieldNames.IndexOf(FItemFieldNames.Deleted) = -1) then
    begin
      lFieldNames.Free;

      {ItemPipeline <name> field: '<name>' could not be found.}
      FErrorMessage := ppLoadStr(561);
      FErrorMessage := ppSetMessageParameters(FErrorMessage);
      FErrorMessage := Format(FErrorMessage, ['Deleted', FItemFieldNames.Deleted]);

      Exit;
    end;

  lFieldNames.Free;

  {set FItemFormat based on Report.Template.Format}
  FItemFormat := FDesigner.Report.Template.Format;

  {check for dtMemo template field type and override ItemForm to ftASCII as needed}
  lDataType := FItemTemplatePipeline.GetFieldDataType(FItemFieldNames.Template);

   if (lDataType = dtMemo) then
     FItemFormat := ftASCII;

  if (FItemTemplatePipeline <> FItemPipeline) then
    FItemTemplatePipeline.Close;

  Result := True;

end; {function, ValidSettings}

{------------------------------------------------------------------------------}
{ TppReportExplorer.SetMergeMenu }

procedure TppReportExplorer.SetMergeMenu(aMenu: TMainMenu);
begin
  FMergeMenu := aMenu;
end; {procedure, SetMergeMenu}

{------------------------------------------------------------------------------}
{ TppReportExplorer.SetFolderOptions }

procedure TppReportExplorer.SetFolderOptions(aFolderOptions: TppFolderOptions);
begin

  FFolderOptions := aFolderOptions;

  if (foAllowDelete in FFolderOptions) and not(ioAllowDelete in FItemOptions) then
    Include(FItemOptions, ioAllowDelete);

end; {procedure, SetFolderOptions}

{------------------------------------------------------------------------------}
{ TppReportExplorer.SetItemAction }

procedure TppReportExplorer.SetItemAction(aItemAction: TppItemActionType);
begin
  FItemAction := aItemAction;
end; {procedure, SetItemAction}

{------------------------------------------------------------------------------}
{ TppReportExplorer.SetItemOptions }

procedure TppReportExplorer.SetItemOptions(aItemOptions: TppItemOptions);
begin

  FItemOptions := aItemOptions;

  {if design is not allowed, we cannot open to design}
  if (FItemAction = iaOpenToDesign) and not(ioAllowDesign in FItemOptions) then
    FItemAction := iaOpenToPreview;

  if (ioAllowDelete in FItemOptions) and not(foAllowDelete in FFolderOptions) then
    Include(FFolderOptions, foAllowDelete);

end; {procedure, SetItemOptions}

{------------------------------------------------------------------------------}
{ TppReportExplorer.SetFolderFieldNames }

procedure TppReportExplorer.SetFolderFieldNames(aFolderFieldNames: TppFolderFieldNames);
begin
  FFolderFieldNames.Assign(aFolderFieldNames);
end; {procedure, SetFolderFieldNames}

{------------------------------------------------------------------------------}
{ TppReportExplorer.SetItemFieldNames }

procedure TppReportExplorer.SetItemFieldNames(aItemFieldNames: TppItemFieldNames);
begin
  FItemFieldNames.Assign(aItemFieldNames);
end; {procedure, SetItemFieldNames}

{------------------------------------------------------------------------------}
{ TppReportExplorer.SetDesigner }

procedure TppReportExplorer.SetDesigner(aDesigner: TppDesigner);
begin

  if (FDesigner <> nil) then
    FDesigner.RemoveNotify(Self);

  FDesigner := aDesigner;

  if (FDesigner <> nil) then
    FDesigner.AddNotify(Self);

end; {procedure, SetDesigner}

{------------------------------------------------------------------------------}
{ TppReportExplorer.SetFolderPipeline }

procedure TppReportExplorer.SetFolderPipeline(aFolderPipeline: TppDataPipeline);
begin

  if (FFolderPipeline <> nil) then
    FFolderPipeline.RemoveNotify(Self);

  FFolderPipeline := aFolderPipeline;

  if (FFolderPipeline <> nil) then
    FFolderPipeline.AddNotify(Self);

end; {procedure, SetFolderPipeline}

{------------------------------------------------------------------------------}
{ TppReportExplorer.SetItemPipeline }

procedure TppReportExplorer.SetItemPipeline(aItemPipeline: TppDataPipeline);
begin

  if (FItemPipeline <> nil) then
    FItemPipeline.RemoveNotify(Self);

  FItemPipeline := aItemPipeline;

  if (FItemPipeline <> nil) then
    FItemPipeline.AddNotify(Self);

end; {procedure, SetItemPipeline}

{------------------------------------------------------------------------------}
{ TppReportExplorer.SetReport }

procedure TppReportExplorer.SetReport(aReport: TppReport);
begin

  if (FReport <> nil) then
    FReport.RemoveNotify(Self);

  FReport := aReport;

  if (FReport <> nil) then
    begin
      if (FForm <> nil) then
        TppReportExplorerForm(FForm).LanguageIndex := FReport.LanguageIndex;
      FReport.AddNotify(Self);
    end;

end; {procedure, SetReport}


{@TppReportExplorer.LoadReport
 Loads the report template for the given report into the report object.  This
 method does not display the Report Designer.

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

procedure TppReportExplorer.LoadReport(const aReportName: String; aFolderId: Integer);
var
  lLanguage: TppLanguageType;
  liCurrentFolderId: Integer;
  lsCurrentName: String;
begin

  if not(Initialize) then Exit;

  lLanguage := FReport.Language;

  lsCurrentName := FReport.Template.DataBaseSettings.Name;
  liCurrentFolderId := FReport.Template.DataBaseSettings.FolderId;

  try

    FReport.Template.DataBaseSettings.Name := aReportName;
    FReport.Template.DataBaseSettings.FolderId := aFolderId;

    if (Designer <> nil) then
      Designer.Form.LayoutManager.DocumentController.LoadTemplate(FReport)
    else
      FReport.Template.LoadFromDatabase;

    ConfigureReportTemplate;

  except
    FReport.Template.DataBaseSettings.Name := lsCurrentName;
    FReport.Template.DataBaseSettings.FolderId := liCurrentFolderId;

    raise;

  end;

  FReport.Language := lLanguage;


end; {procedure, LoadReport}


{@TppReportExplorer.SaveReport
 Saves any changes made to the given report.

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

procedure TppReportExplorer.SaveReport(const aReportName: String; aFolderId: Integer);
begin

  if not(Initialize) then Exit;

  FReport.Template.DataBaseSettings.Name := aReportName;
  FReport.Template.DataBaseSettings.FolderId := aFolderId;

  if (Designer <> nil) then
    Designer.Form.LayoutManager.DocumentController.SaveTemplate(FReport)
  else
    FReport.Template.SaveToDatabase;

end; {procedure, SaveReport}

{------------------------------------------------------------------------------}
{ TppReportExplorer.ReportCreateDialogEvent }

procedure TppReportExplorer.ReportCreateDialogEvent(Sender: TObject; aDialog: TObject);
var
  lDialog: TppOpenSaveDialog;
  lTemplate: TppTemplate;
begin

  if (aDialog is TppOpenSaveDialog) then
    begin
      lDialog := TppOpenSaveDialog(aDialog);

      lTemplate := TppTemplate(Sender);

      lDialog.ReportExplorer := Self;
      lDialog.ItemType := ItemTypeForTemplate(lTemplate);

    end;

end; {procedure, ReportCreateDialogEvent}

{------------------------------------------------------------------------------}
{ TppReportExplorer.ReportNewEvent }

procedure TppReportExplorer.ReportNewEvent(Sender: TObject);
var
  lTemplate: TppTemplate;
begin

  lTemplate := TppTemplate(Sender);

  if (ItemTypeForTemplate(lTemplate) = itReport) then
    TppTemplate(Sender).DatabaseSettings.Name := GetNewReportName(CurrentFolderId);

end; {procedure, ReportNewEvent}

{------------------------------------------------------------------------------}
{ TppReportExplorer.ReportLoadEndEvent }

procedure TppReportExplorer.ReportLoadEndEvent(Sender: TObject);
//var
//  lTemplate: TppTemplate;
begin

// no longer need this code  NFM 

{  if (Sender) is TppCustomReport then  // TppReport or TppChildReport
    lTemplate := TppCustomReport(Sender).Template
  else if (Sender is TppReportModule) then  // TdaDataModule or TraCodeModule
    lTemplate := TppReportModule(Sender).Template
  else
    Exit;

  if (lTemplate.SaveTo = stFile) then Exit;

  if not(ppdaNoRecords in FItemPipeline.State) then
    begin
      lTemplate.DatabaseSettings.FolderId := FItemPipeline.GetFieldValue(FItemFieldNames.FolderId);
      lTemplate.DatabaseSettings.Name := FItemPipeline.GetFieldValue(FItemFieldNames.Name);
    end;
}

end; {procedure, ReportLoadEndEvent}

{------------------------------------------------------------------------------}
{ TppReportExplorer.ReportLocateRecordEvent }

function TppReportExplorer.ReportLocateRecordEvent(Sender: TObject; const aItemName: String): Boolean;
var
  lTemplate: TppTemplate;
  lItemType: Integer;
  liFolderID: Integer;
begin

  lTemplate := TppTemplate(Sender);

  lItemType := ItemTypeForTemplate(lTemplate);
  liFolderID := lTemplate.DatabaseSettings.FolderId;

  // locate the item in the dataset
  Result := LocateItemRecord(aItemName, lItemType, liFolderID);

  // for an Insert, need to close the master dataset
  if not(Result) and (FItemPipeline <> FItemTemplatePipeline) then
    FItemPipeline.Close;

end; {function, ReportLocateRecordEvent}

{------------------------------------------------------------------------------}
{ TppReportExplorer.ReportSaveEndEvent }

procedure TppReportExplorer.ReportSaveEndEvent(Sender: TObject; aStream: TStream);
var
  lTemplate: TppTemplate;
  lItemType: Integer;
  liFolderID: Integer;
  ldNow: Double;
begin

  lTemplate := TppTemplate(Sender);
  ldNow := Now;

  if (lTemplate.SaveTo = stFile) then Exit;

  lItemType := ItemTypeForTemplate(lTemplate);
  liFolderID := lTemplate.DatabaseSettings.FolderId;

  FItemTemplatePipeline.SetFieldValue(FItemFieldNames.ItemType, lItemType);
  FItemTemplatePipeline.SetFieldValue(FItemFieldNames.FolderId, liFolderID);
  FItemTemplatePipeline.SetFieldValue(FItemFieldNames.Size, Integer(aStream.Size)); {Delphi6}
  FItemTemplatePipeline.SetFieldValue(FItemFieldNames.Modified, ldNow);


end; {procedure, ReportSaveEndEvent}

{------------------------------------------------------------------------------}
{ TppReportExplorer.DesignerCloseEvent }

procedure TppReportExplorer.DesignerCloseEvent(Sender: TObject; var Action: TCloseAction);
begin
  if (FForm <> nil) then
    TppReportExplorerForm(FForm).Refresh;
end; {procedure, DesignerCloseEvent}


{@TppReportExplorer.ValidItemName
 Given the item name, type and folder id, returns whether the name is valid.}

function TppReportExplorer.ValidItemName(const aItemName: String; aItemType, aFolderId: Integer): Boolean;
begin

  Result := False;

  if not(Initialize) then Exit;

  if (Length(aItemName) = 0) then Exit;

  Result := not(LocateItemRecord(aItemName, aItemType, aFolderId));

end; {function, ValidItemName}


{@TppReportExplorer.IsReport
 Given the item name and folder, returns whether the item is a report.}

function TppReportExplorer.IsReport(const aItemName: String; aFolderId: Integer): Boolean;
begin

  Result := False;

  if not(Initialize) then Exit;

  Result := LocateItemRecord(aItemName, itReport, aFolderId);

end; {function, IsReport}

{------------------------------------------------------------------------------}
{ TppReportExplorer.LocateFolderRecord }

function TppReportExplorer.LocateFolderRecord(const aFolderName: String; aParentId: Integer): Boolean;
var
  lsFieldNames: String;
begin

  lsFieldNames := FFolderFieldNames.Name + ';' +
                  FFolderFieldNames.ParentId;

  Result := FFolderPipeline.Locate(lsFieldNames, VarArrayOf([aFolderName, aParentId]), [pploCaseInsensitive]);

end; {procedure, LocateFolderRecord}

{------------------------------------------------------------------------------}
{ TppReportExplorer.LocateItemRecord }

function TppReportExplorer.LocateItemRecord(const aItemName: String; aItemType, aFolderId: Integer): Boolean;
var
  lsFieldNames: String;
begin

  lsFieldNames := FItemFieldNames.FolderId + ';' +
                  FItemFieldNames.ItemType + ';' +
                  FItemFieldNames.Name;

  Result := FItemPipeline.Locate(lsFieldNames, VarArrayOf([aFolderId, aItemType, aItemName]), [pploCaseInsensitive]);

end; {procedure, LocateItemRecord}

{------------------------------------------------------------------------------}
{ TppReportExplorer.ItemTypeForTemplate }

function TppReportExplorer.ItemTypeForTemplate(aTemplate: TppTemplate): Integer;
begin

  if CompareText(aTemplate.FileExtension, 'rtm') = 0 then
    Result := itReport
  else if CompareText(aTemplate.FileExtension, 'ctm') = 0 then
    Result := itCode
  else if CompareText(aTemplate.FileExtension, 'dtm') = 0 then
    Result := itData
  else
    Result := itReport;

end; {function, ItemTypeForTemplate}


{@TppReportExplorer.ValidFolderName
 Given the folder name and parent id, returns whether the folder name is valid.}

function TppReportExplorer.ValidFolderName(aParentId: Integer; aFolderName: String): Boolean;
var
  lsFieldNames: String;
begin

  Result := False;

  if not(Initialize) then Exit;

  if (Length(aFolderName) = 0) then Exit;
  
  lsFieldNames := FFolderFieldNames.Name + ';' + FFolderFieldNames.ParentId;

  Result := not(FFolderPipeline.Locate(lsFieldNames, VarArrayOf([aFolderName, aParentId]), [pploCaseInsensitive]));

end; {function, ValidFolderName}


{@TppReportExplorer.Open
 Opens the given report and displays the Report Designer.

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

procedure TppReportExplorer.Open(const aReportName: String; aFolderId: Integer);
begin

  if not(Initialize) then Exit;

  if IsReport(aReportName, aFolderId)then
    begin
      LoadReport(aReportName, aFolderId);
      
      FDesigner.ShowModal;
    end;

end; {procedure, Open}


{@TppReportExplorer.Print
 Opens the given report and prints it to the printer.

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

procedure TppReportExplorer.Print(const aReportName: String; aFolderId: Integer);
begin

  if not(Initialize) then Exit;

  if IsReport(aReportName, aFolderId)then
    begin
      LoadReport(aReportName, aFolderId);

      FReport.DeviceType := dtPrinter;
      FReport.Print;
    end;

end; {procedure, Print}


{@TppReportExplorer.PrintPreview
 Opens the given report and prints it to the registered Print Preview form.

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

procedure TppReportExplorer.PrintPreview(const aReportName: String; aFolderId: Integer);
begin

  if not(Initialize) then Exit;

  if IsReport(aReportName, aFolderId)then
    begin
      LoadReport(aReportName, aFolderId);

      FReport.DeviceType := dtScreen;
      FReport.Print;
    end;

end; {procedure, PrintPreview}

{------------------------------------------------------------------------------}
{@TppReportExplorer.SendEmail
 Exports and sends the given report(s) via email based on the email settings of
 the first report selected.

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

procedure TppReportExplorer.SendEmail(aSelectedList: TStringList; aFolderId: Integer);
var
  liIndex: Integer;
  lsReportName: String;
  lEmail: TppEmail;
  lReport: TppReport;
  lReportList: TList;
begin

  if not(Initialize) then Exit;

  lEmail := TppEmail.Create;
  lReportList := TList.Create;

  try

    //Loop through and load each selected report
    for liIndex := 0 to aSelectedList.Count - 1 do
      begin
        lsReportName := aSelectedList[liIndex];

        lReport := TppReport.Create(nil);

        if IsReport(lsReportName, aFolderID) then
          begin
            //Assign template properties
            lReport.SaveAsTemplate  := True;
            lReport.Template.SaveTo := stDatabase;
            lReport.Template.Format := FItemFormat;
            lReport.Template.DatabaseSettings.DataPipeline := FItemTemplatePipeline;
            lReport.Template.DatabaseSettings.NameField := FItemFieldNames.Name;
            lReport.Template.DatabaseSettings.TemplateField := FItemFieldNames.Template;
            lReport.Template.DataBaseSettings.Name := lsReportName;
            lReport.Template.DataBaseSettings.FolderId := aFolderId;

            //Load the report
            lReport.Template.LoadFromDatabase;
            lReport.EmailSettings.FileName := lsReportName;
            lReportList.Add(lReport);
          end;
      end;

    //Add loaded report(s) to the email object
    for liIndex := 0 to lReportList.Count - 1 do
      lEmail.AddReport(TppReport(lReportList[liIndex]));

    //Send mail
    lEmail.Send;

  finally
    for liIndex := lReportList.Count - 1 downto 0 do
      TppReport(lReportList[liIndex]).Free;

    lReportList.Free;
    lEmail.Free;
  end;

end; {procedure, SendEmail}

{------------------------------------------------------------------------------}
{ TppReportExplorer.ConfigureReportTemplate }

procedure TppReportExplorer.ConfigureReportTemplate;
begin

  FReport.Template.reOnCreateDialog := ReportCreateDialogEvent;
  FReport.Template.reOnNew := ReportNewEvent;
  FReport.Template.reOnSaveEnd := ReportSaveEndEvent;
  FReport.Template.reOnLoadEnd := ReportLoadEndEvent;
  FReport.Template.reOnLocateRecord := ReportLocateRecordEvent;

  FReport.SaveAsTemplate  := True;
  FReport.Template.SaveTo := stDatabase;
  FReport.Template.Format := FItemFormat;

  FReport.Template.DatabaseSettings.DataPipeline := FItemTemplatePipeline;
  FReport.Template.DatabaseSettings.NameField := FItemFieldNames.Name;
  FReport.Template.DatabaseSettings.TemplateField := FItemFieldNames.Template;

  FReport.Modified := False;
  
end; {procedure, ConfigureReportTemplate}


{@TppReportExplorer.New
 Creates a new report based on the information given in aReportInfo and displays
 the Report Designer.

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

procedure TppReportExplorer.New(aFolderId: Integer);
begin

  if not(Initialize) then Exit;

  FReport.FreeModules;

  FReport.Template.New;
  FReport.Template.DatabaseSettings.FolderId := aFolderId;
  FReport.Template.DatabaseSettings.Name := GetNewReportName(aFolderId);

  ConfigureReportTemplate;

  FDesigner.ShowModal;

end; {procedure, New}


{@TppReportExplorer.GetNewFolderName
 Returns a valid folder name for the given parent folder.  Folder names take the
 form 'New Folder', 'New Folder (2)', 'New Folder (3)', etc.}

function TppReportExplorer.GetNewFolderName(aParentId: Integer): String;
var
  lFolders: TStringList;
  liIndex: Integer;
  lsFolderName: String;
  liIncrement: Integer;
begin

  if not(Initialize) then Exit;

  lFolders := TStringList.Create;

  GetChildFolders(aParentId, lFolders);

  lsFolderName := ppLoadStr(570); {New Folder}
  liIndex := lFolders.IndexOf(lsFolderName);
  liIncrement := 2;

  while (liIndex <> -1) do
    begin
      lsFolderName := ppLoadStr(570) + ' (' + IntToStr(liIncrement) + ')';

      liIndex := lFolders.IndexOf(lsFolderName);

      Inc(liIncrement);
    end;

  for liIndex := 0 to lFolders.Count - 1 do
    TppFolderInfo(lFolders.Objects[liIndex]).Free;

  lFolders.Free;

  Result := lsFolderName;

end; {function, GetNewFolderName}


{@TppReportExplorer.GetNewReportName
 Returns a valid report name for the given folder.  Report names take the form
 'New Report', 'New Report (2)', 'New Report (3)', etc.}

function TppReportExplorer.GetNewReportName(aFolderId: Integer): String;
var
  lReports: TStringList;
  liIndex: Integer;
  lsReportName: String;
  liIncrement: Integer;
begin

  if not(Initialize) then Exit;

  lReports := TStringList.Create;

  GetItems(aFolderId, itReport, lReports);

  lsReportName := ppLoadStr(571); {New Report}
  liIndex := lReports.IndexOf(lsReportName);
  liIncrement := 2;

  while (liIndex <> -1) do
    begin
      lsReportName := ppLoadStr(571) + ' (' + IntToStr(liIncrement) + ')';

      liIndex := lReports.IndexOf(lsReportName);

      Inc(liIncrement);
    end;

  for liIndex := 0 to lReports.Count - 1 do
    TppItemInfo(lReports.Objects[liIndex]).Free;

  lReports.Free;

  Result := lsReportName;

end; {function, GetNewReportName}


{@TppReportExplorer.AddFolder
 Creates a new folder with the name given by the aFolderName parameter.  Nests
 the new folder within the folder specified in the aParentId parameter. If
 aParentId is 0 then the folder becomes a 'root' folder and is attached directly
 to the main folder (entitled 'All Folders').

 This procedure is called by the Report Explorer form when the end user wants
 add a new folder. You should not need to call this routine unless you are
 replacing the Report Explorer form with a form of your own.  For more
 information on replacing the Report Explorer form, see the Form property.}

procedure TppReportExplorer.AddFolder(aParentId: Integer; aFolderName: String; var aFolderId: Integer);
begin

  if not(Initialize) then Exit;

  FFolderPipeline.Insert;
  FFolderPipeline.SetFieldValue(FFolderFieldNames.Name, aFolderName);
  FFolderPipeline.SetFieldValue(FFolderFieldNames.ParentId, aParentId);
  FFolderPipeline.Post;

  {note: the following is a workaround to refresh the buffer with the
         FolderId value that was auto generated by the database}
  if LocateFolderRecord(aFolderName, aParentId) then
    aFolderId := FFolderPipeline.GetFieldValue(FFolderFieldNames.FolderId)
  else
    aFolderId := -1;

  {a folder id of zero is invalid, since this id is used by itAllFolders. So
   if the DB returns zero, delete the record and create another one}
  if (aFolderId = 0) then
    begin
      FFolderPipeline.Delete;

      FFolderPipeline.Insert;
      FFolderPipeline.SetFieldValue(FFolderFieldNames.Name, aFolderName);
      FFolderPipeline.SetFieldValue(FFolderFieldNames.ParentId, aParentId);
      FFolderPipeline.Post;
      {note: the following is a workaround to refresh the buffer with the
             FolderId value that was auto generated by the database}
      if LocateFolderRecord(aFolderName, aParentId) then
        aFolderId := FFolderPipeline.GetFieldValue(FFolderFieldNames.FolderId)
      else
        aFolderId := -1;
    end;

end; {procedure, AddFolder}


{@TppReportExplorer.GetParentId
 Returns the ParentId for the folder specified by the aFolderId parameter.  The
 ParentId indicates the folder in which the specified folder is nested.

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

function TppReportExplorer.GetParentId(aFolderId: Integer): Integer;
begin

  Result := -1;

  if not(Initialize) then Exit;

  if FFolderPipeline.Locate(FFolderFieldNames.FolderId, aFolderId, [pploCaseInsensitive]) then
    Result := FFolderPipeline.GetFieldValue(FFolderFieldNames.ParentId)
  else
    Result := -1;

end; {procedure, GetParentId}


{@TppReportExplorer.GetFolderName
 Returns the name of the folder corresponding to the aFolderId parameter.

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

function TppReportExplorer.GetFolderName(aFolderId: Integer): String;
begin

  Result := '';
  
  if not(Initialize) then Exit;

  if FFolderPipeline.Locate(FFolderFieldNames.FolderId, aFolderId, [pploCaseInsensitive]) then
    Result := FFolderPipeline.GetFieldValue(FFolderFieldNames.Name);

end; {procedure, GetFolderName}


{@TppReportExplorer.RenameFolder
 Renames the given folder using the aNewName parameter.

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

procedure TppReportExplorer.RenameFolder(aFolderId: Integer; const aNewName: String);
begin

  if not(Initialize) then Exit;

  if FFolderPipeline.Locate(FFolderFieldNames.FolderId, aFolderId, [pploCaseInsensitive]) then
    begin
      FFolderPipeline.Edit;
      FFolderPipeline.SetFieldValue(FFolderFieldNames.Name, aNewName);
      FFolderPipeline.Post;
    end;

end; {procedure, RenameFolder}


{@TppReportExplorer.ConfirmRenameFolder
 If the new folder name is not valid, false is returned and the message: 'Cannot
 rename \<aOldName\>: A folder with the name you specified already exists. Specify
 a different folder name.' is displayed.  If the new folder name is valid,
 returns True.}

function TppReportExplorer.ConfirmRenameFolder(const aOldName, aNewName: String; aParentId: Integer): Boolean;
var
  lsCaption: String;
  lsMessage: String;
begin

  Result := ValidFolderName(aParentId, aNewName);

  if Result then Exit;

  lsCaption := ppLoadStr(552); {Error Renaming Folder}

  if (Length(aNewName) = 0) then
    lsMessage := ppLoadStr(1111) {You must type a folder name.}

  else
    begin
      {Cannot rename <name>: A folder with the name you specified already exists.}
      lsMessage := ppLoadStr(533);
      lsMessage := ppSetMessageParameters(lsMessage);
      lsMessage := Format(lsMessage, [aOldName]);
      lsMessage := lsMessage + #13#10 + #13#10 + ppLoadStr(584);
    end;

  ppMessageDlg(lsCaption, lsMessage, mtError, [mbOK], 0);

end; {procedure, ConfirmRenameFolder}


{@TppReportExplorer.ConfirmRenameItem
 If the new item name is not valid, false is returned and the message: 'Cannot
 rename <aOldName>: An item with the name you specified already exists. Specify
 a different item name.' is displayed.  If the new item name is valid, returns
 True.}

function TppReportExplorer.ConfirmRenameItem(const aOldName, aNewName: String; aItemType, aFolderId: Integer): Boolean;
var
  lsCaption: String;
  lsMessage: String;
begin

  Result := ValidItemName(aNewName, aItemType, aFolderId);

  if Result then Exit;

  lsCaption := ppLoadStr(553); {Error Renaming Item}

  if (Length(aNewName) = 0) then
    lsMessage := ppLoadStr(1112) {You must type an item name.}

  else
    begin
      {Cannot rename <name>: An item with the name you specified already exists.}
      lsMessage := ppLoadStr(534);
      lsMessage := ppSetMessageParameters(lsMessage);
      lsMessage := Format(lsMessage, [aOldName]);
      lsMessage := lsMessage + #13#10 + #13#10 + ppLoadStr(585);
    end;

  ppMessageDlg(lsCaption, lsMessage, mtError, [mbOK], 0);

end; {procedure, ConfirmRenameItem}


{@TppReportExplorer.RejectMoveFolder

 Displays the message: 'Cannot move \<foldername\>: The destination folder is the
 same as the source folder.'}

procedure TppReportExplorer.RejectMoveFolder(const aFolderName: String);
var
  lsCaption: String;
  lsMessage: String;
begin

  lsCaption := ppLoadStr(551); {Error Moving Folder}

  {Cannot move <aFolderName>: The destination folder is the same as the source folder.}
  lsMessage := ppLoadStr(532);
  lsMessage := ppSetMessageParameters(lsMessage);
  lsMessage := Format(lsMessage, [aFolderName]);

  ppMessageDlg(lsCaption, lsMessage, mtError, [mbOK], 0);

end; {procedure, RejectMoveFolder}

{@TppReportExplorer.RejectMoveItem

 Displays the message: 'Cannot move \<aItemName\>: The destination folder is the
 same as the source folder.'}

procedure TppReportExplorer.RejectMoveItem(const aItemName: String);
var
  lsCaption: String;
  lsMessage: String;
begin

  lsCaption := ppLoadStr(553); {Error Renaming Item}

  {Cannot move <aItemName>: The destination folder is the same as the source folder.}
  lsMessage := ppLoadStr(532);
  lsMessage := ppSetMessageParameters(lsMessage);
  lsMessage := Format(lsMessage, [aItemName]);

  ppMessageDlg(lsCaption, lsMessage, mtError, [mbOK], 0);

end; {procedure, RejectMoveFolder}


{@TppReportExplorer.ConfirmReplaceFolder
 Displays the message: 'This folder already contains a folder called
 \<aFolderName\> If the items in the existing folder have the same name as reports
 in the folder you are moving, do you want to replace the existing items?'. The
 Yes, No, Cancel and Yes to All buttons are displayed.  The modal result is
 returned.}

function TppReportExplorer.ConfirmReplaceFolder(const aFolderName: String): Word;
var
  lsCaption: String;
  lsMessage: String;
  lBitmapHandle: THandle;
begin

  lsCaption := ppLoadStr(537); {Confirm Folder Replace}

  {This folder already contains a folder called...}
  lsMessage := ppLoadStr(586);
  lsMessage := ppSetMessageParameters(lsMessage);
  lsMessage := Format(lsMessage, [aFolderName]);
  lsMessage := lsMessage + #13#10 + #13#10 + ppLoadStr(592) + ' ' + ppLoadStr(593);

  lBitmapHandle := ppBitmapFromResource('PPREPLACEFOLDER');

  Result := ppMessageDlg(lsCaption, lsMessage, mtConfirmation, [mbYes, mbYesToAll, mbNo, mbCancel], lBitmapHandle);

end; {function, ConfirmReplaceFolder}


{@TppReportExplorer.ConfirmReplaceItem
 Displays the message: 'This folder already contains an item called \<aItemName\>
 'Would you like to replace the existing item?'.  If the user selects yes, True
 is returned.}

function TppReportExplorer.ConfirmReplaceItem(const aItemName: String): Boolean;
var
  lsCaption: String;
  lsMessage: String;
  lBitmapHandle: THandle;
begin

  lsCaption := ppLoadStr(540); {Confirm Item Replace}

  {This folder already contains an item called '<name>'. }
  lsMessage := ppLoadStr(587);
  lsMessage := ppSetMessageParameters(lsMessage);
  lsMessage := Format(lsMessage, [aItemName]);
  lsMessage := lsMessage + #13#10 + #13#10 + ppLoadStr(590);

  lBitmapHandle := ppBitmapFromResource('PPREPLACEREPORT');

  Result := (ppMessageDlg(lsCaption, lsMessage, mtConfirmation, [mbYes, mbNo, mbCancel], lBitmapHandle) = mrYes);

end; {function, ConfirmReplaceItem}


{@TppReportExplorer.ConfirmDeleteFolder
 Displays the message: 'Are you sure you want to remove the folder \<aFolderName\>
 and move all its contents to the Recycle Bin?'.  A Yes and No button are
 displayed. If the user clicks the Yes button, this function returns True.}

function TppReportExplorer.ConfirmDeleteFolder(const aFolderName: String): Boolean;
var
  lsMessage: String;
  lsCaption: String;
  lBitmapHandle: THandle;
begin

  lsCaption := ppLoadStr(536); {Confirm Folder Delete}

  {Are you sure you want to remove the folder '<name>' and...}
  lsMessage := ppLoadStr(528);
  lsMessage := ppSetMessageParameters(lsMessage);
  lsMessage := Format(lsMessage, [aFolderName]);

  lBitmapHandle := ppBitmapFromResource('PPRECYCLEFOLDER');

  Result := (ppMessageDlg(lsCaption, lsMessage, mtWarning, [mbYes, mbNo], lBitmapHandle) = mrYes);

end; {function, ConfirmDeleteFolder}


{@TppReportExplorer.ConfirmDeleteFolders
 Displays the message: 'Are you sure you want to send these <\aList.Count\> items
 to the Recycle Bin?'.  A Yes and No button are displayed. If the user clicks
 the Yes button, this function returns True.}

function TppReportExplorer.ConfirmDeleteFolders(aList: TStrings): Boolean;
var
  lsCaption: String;
  lsMessage: String;
  lBitmapHandle: THandle;
begin

  Result := False;

  if (aList.Count = 0) then Exit;

  if (aList.Count = 1) then
    Result := ConfirmDeleteFolder(aList[0])
  else
    begin
      lsCaption := ppLoadStr(541); {Confirm Multiple Folder Delete}

      {Are you sure you want to delete these <count> folders...}
      lsMessage := ppLoadStr(526);
      lsMessage := ppSetMessageParameters(lsMessage);
      lsMessage := Format(lsMessage, [IntToStr(aList.Count)]);

      lBitmapHandle := ppBitmapFromResource('PPRECYCLEFOLDER');

      Result := (ppMessageDlg(lsCaption, lsMessage, mtWarning, [mbYes, mbNo], lBitmapHandle) = mrYes);
    end;

end; {function, ConfirmDeleteFolders}


{@TppReportExplorer.ConfirmDeleteItem
 Displays the message: 'Are you sure you want to delete \<aItemName\>?'.  A Yes
 and No button are displayed. If the user clicks the Yes button, this function
 returns True. This message is used before the item is really deleted.  The
 message displayed when the item is sent to the recycle bin can be displayed via
 the ConfirmRecycleItem method.}

function TppReportExplorer.ConfirmDeleteItem(const aItemName: String): Boolean;
var
  lsMessage: String;
  lsCaption: String;
  lBitmapHandle: THandle;
begin

  lsCaption := ppLoadStr(539); {Confirm Item Delete}

  {Are you sure you want to delete '<name>'?}
  lsMessage := ppLoadStr(525);
  lsMessage := ppSetMessageParameters(lsMessage);
  lsMessage := Format(lsMessage, [aItemName]);

  lBitmapHandle := ppBitmapFromResource('PPDELETEREPORT');

  Result := (ppMessageDlg(lsCaption, lsMessage, mtWarning, [mbYes, mbNo], lBitmapHandle) = mrYes);

end; {function, ConfirmDeleteItem}


{@TppReportExplorer.ConfirmDeleteItems
 Displays the message: 'Are you sure you want to delete these
 \<aList.Count\> items?'.  A Yes and No button are displayed. If the user clicks
 the Yes button, this function returns True.This message is used before the
 items are really deleted.  The message displayed when items are sent to the
 recycle bin can be displayed via the ConfirmRecycleItems method.}

function TppReportExplorer.ConfirmDeleteItems(aList: TStrings): Boolean;
var
  lsCaption: String;
  lsMessage: String;
  lBitmapHandle: THandle;
begin

  Result := False;

  if (aList.Count = 0) then Exit;

  if (aList.Count = 1) then
    Result := ConfirmDeleteItem(aList[0])
  else
    begin
      lsCaption := ppLoadStr(543); {Confirm Multiple Item Delete}

      {Are you sure you want to delete these <count> items?}
      lsMessage := ppLoadStr(527);
      lsMessage := ppSetMessageParameters(lsMessage);
      lsMessage := Format(lsMessage, [IntToStr(aList.Count)]);

      lBitmapHandle := ppBitmapFromResource('PPDELETEREPORT');

      Result := (ppMessageDlg(lsCaption, lsMessage, mtWarning, [mbYes, mbNo], lBitmapHandle) = mrYes);
    end;

end; {function, ConfirmDeleteItems}


{@TppReportExplorer.ConfirmRecycleItem
 Displays the message: 'Are you sure you want to send \<aItemName\> to the Recycle
 Bin?'.  A Yes and No button are displayed. If the user clicks the Yes button,
 this function returns True.}

function TppReportExplorer.ConfirmRecycleItem(const aItemName: String): Boolean;
var
  lsMessage: String;
  lsCaption: String;
  lBitmapHandle: THandle;
begin

  lsCaption := ppLoadStr(539); {Confirm Item Delete}

  {Are you sure you want to send '<name>' to the Recycle Bin?}
  lsMessage := ppLoadStr(529);
  lsMessage := ppSetMessageParameters(lsMessage);
  lsMessage := Format(lsMessage, [aItemName]);

  lBitmapHandle := ppBitmapFromResource('PPRECYCLEREPORT');

  Result := (ppMessageDlg(lsCaption, lsMessage, mtWarning, [mbYes, mbNo], lBitmapHandle) = mrYes);

end; {function, ConfirmRecycleItem}


{@TppReportExplorer.ConfirmRecycleItems
 Displays the message: 'Are you sure you want to send these \<aList.Count\> items
 to the Recycle Bin?'.  A Yes and No button are displayed. If the user clicks
 the Yes button, this function returns True.}

function TppReportExplorer.ConfirmRecycleItems(aList: TStrings): Boolean;
var
  lsCaption: String;
  lsMessage: String;
  lBitmapHandle: THandle;
  lItem: TListItem;
  lbAllFolders: Boolean;
  liIndex: Integer;
begin

  Result := False;

  if (aList.Count = 0) then Exit;

  if (aList.Count = 1) then
    begin
      lItem := TListItem(aList.Objects[0]);

      if ((lItem.ImageIndex + 1) = itFolder) then
        Result := ConfirmDeleteFolder(aList[0])
      else
        Result := ConfirmRecycleItem(aList[0]);
    end
  else
    begin

      lbAllFolders := True;
      liIndex := 0;

      while lbAllFolders and (liIndex < aList.Count) do
        begin
          lItem := TListItem(aList.Objects[liIndex]);

          if ((lItem.ImageIndex + 1) <> itFolder) then
            lbAllFolders := False
          else
            Inc(liIndex);
        end;

      if lbAllFolders then
        Result := ConfirmDeleteFolders(aList)
      else
        begin
          lsCaption := ppLoadStr(543); {Confirm Multiple Item Delete}

          {Are you sure you want to send these <count> items to the Recycle Bin?}
          lsMessage := ppLoadStr(530);
          lsMessage := ppSetMessageParameters(lsMessage);
          lsMessage := Format(lsMessage, [IntToStr(aList.Count)]);

          lBitmapHandle := ppBitmapFromResource('PPRECYCLEREPORT');

          Result := (ppMessageDlg(lsCaption, lsMessage, mtWarning, [mbYes, mbNo], lBitmapHandle) = mrYes);
        end;
        
    end;

end; {function, ConfirmRecycleItems}


{@TppReportExplorer.DeleteFolder
 Locates the folder with the given id and deletes it.  This routine deletes the
 folder, all reports within it, all folders nested within it, and all reports in
 the nested folders.  It does this directly without displaying a confirmation
 message.

 This procedure is called by the Report Explorer form when the end user wants
 delete a folder.  The Report Explorer displays a confirmation message before
 calling this routine. You should not need to call this routine unless you are
 replacing the Report Explorer form with a form of your own.  For more
 information on replacing the Report Explorer form, see the Form property.}

function TppReportExplorer.DeleteFolder(aFolderId: Integer): Boolean;
begin

  Result := False;

  if not(Initialize) then Exit;

  if (aFolderId = itAllFolders) or (aFolderId = itRecycleBin) then Exit;

  {delete child folders}
  while FFolderPipeline.Locate(FFolderFieldNames.ParentId, aFolderId, [pploCaseInsensitive]) do
    DeleteFolder(FFolderPipeline.GetFieldValue(FFolderFieldNames.FolderId));

  {delete reports}
  DeleteItemsInFolder(aFolderId);

  {delete folder}
  if FFolderPipeline.Locate(FFolderFieldNames.FolderId, aFolderId, [pploCaseInsensitive]) then
    FFolderPipeline.Delete;

  Result := True;

end; {function, DeleteFolder}

{------------------------------------------------------------------------------}
{ TppReportExplorer.DeleteItemsInFolder }

procedure TppReportExplorer.DeleteItemsInFolder(aFolderId: Integer);
begin
  while FItemPipeline.Locate(FItemFieldNames.FolderId, aFolderId, [pploCaseInsensitive]) do
    FItemPipeline.Delete;
end; {procedure, DeleteItemsInFolder}


{@TppReportExplorer.ChangeParentFolder
 Nests an existing folder within the folder specified in the aNewParentId
 parameter. If aParentId is 0, then the folder becomes a 'root' folder and is
 attached directly to the 'main folder' (the folder entitled 'All Folders').
 If the folder specified in aFolderId contains other folders, these are moved
 also.

 This procedure is called by the Report Explorer form when the end user wants
 move a folder. You should not need to call this routine unless you are
 replacing the Report Explorer form with a form of your own.  For more
 information on replacing the Report Explorer form, see the Form property.}

function TppReportExplorer.ChangeParentFolder(aFolderId, aNewParentId: Integer): Boolean;
begin

  Result := False;

  if not(Initialize) then Exit;

  if (aFolderId = aNewParentId) then
    begin
      RejectMoveFolder(GetFolderName(aFolderId));

      Exit;
    end;

  if (aNewParentId = itRecycleBin) then
    FRecyclingItems := True;

  FYesToAll := False;

  Result := MoveFolderToFolder(aFolderId, aNewParentId);

  if (aNewParentId = itRecycleBin) then
    FRecyclingItems := False;

end; {procedure, ChangeParentFolder}


{@TppReportExplorer.ChangeFolder
 Moves an item from one folder to another.  The item is located in the database
 using the aItemName, aItemType and aFolderId parameters.  It is then moved to
 the folder specified in the aNewFolderId parameter.

 This procedure is called by the Report Explorer form when the end user wants
 move an item to a new folder. You should not need to call this routine unless
 you are replacing the Report Explorer form with a form of your own.  For more
 information on replacing the Report Explorer form, see the Form property.}

function TppReportExplorer.ChangeFolder(const aItemName: String; aItemType, aFolderId, aNewFolderId: Integer): Boolean;
begin

  Result := False;

  if Initialize then
    begin

      if (aFolderID = aNewFolderID) then
        RejectMoveItem(aItemName)

      else
        begin

          if (aNewFolderId = itRecycleBin) then
            FRecyclingItems := True;

          FShowMessages := True;

          Result := MoveItemToFolder(aItemName, aItemType, aFolderId, aNewFolderId);

          if (aNewFolderId = itRecycleBin) then
            FRecyclingItems := False;
        end;

    end;

end; {procedure, ChangeFolder}

{------------------------------------------------------------------------------}
{ TppReportExplorer.CreateExplorerForm }

function TppReportExplorer.CreateExplorerForm: TppCustomReportExplorer;
var
  //lForm: TppCustomReportExplorer;
  lFormClass: TFormClass;
begin

  Result := nil;

  lFormClass := ppGetFormClass(TppCustomReportExplorer);

  if (lFormClass = nil) then
    begin
      {No Report Explorer form class is registered.}
      FErrorMessage := ppLoadStr(573);

      Exit;
    end;

  Result := TppCustomReportExplorer(lFormClass.Create(Application));

  FForm := Result;

  Result.ReportExplorer := Self;

  if (FReport <> nil) then
    Result.LanguageIndex := FReport.LanguageIndex;

  Result.Position := FormPosition;
  Result.Caption := FormCaption;
  Result.Height := FormHeight;

  if (FormIcon <> nil) and not(FormIcon.Empty) then
    Result.Icon := FormIcon;

  Result.Left := FormLeft;
  Result.WindowState := FormState;
  Result.FormStyle := FormStyle;
  Result.Tag := FormTag;
  Result.Top := FormTop;
  Result.Width := FormWidth;

  if (FMergeMenu <> nil) then
    Result.MergeMenu := FMergeMenu;

  Result.Initialize;

end; {function, CreateExplorerForm}

{------------------------------------------------------------------------------}
{ TppReportExplorer.MoveFolderToFolder }

function TppReportExplorer.MoveFolderToFolder(aFolderId, aNewParentId: Integer): Boolean;
var
  lsFolderName: String;
  liCollidingId: Integer;
  lbAllReportsMoved: Boolean;
  lbAllFoldersMoved: Boolean;
  lResult: Word;
begin

  Result := False;

  lsFolderName := GetFolderName(aFolderId);

  if FRecyclingItems then
    begin
      liCollidingId := -2;

      MoveFoldersToFolder(aFolderId, liCollidingId);
      MoveItemsToFolder(aFolderId, liCollidingId);

      DeleteFolder(aFolderId);

      Result := True;
    end

  else if not(ValidFolderName(aNewParentId, lsFolderName)) then
    begin

      liCollidingId := FFolderPipeline.GetFieldValue(FFolderFieldNames.FolderId);

      if not(FYesToAll) then
        begin
          lResult := ConfirmReplaceFolder(lsFolderName);

          case lResult of
            mrYesToAll:  FYesToAll := True;
            mrNo:        Exit;
            mrCancel:    Exit;
          end;

        end;

      lbAllFoldersMoved := MoveFoldersToFolder(aFolderId, liCollidingId);
      lbAllReportsMoved := MoveItemsToFolder(aFolderId, liCollidingId);

      if (lbAllReportsMoved) and (lbAllFoldersMoved) then
        DeleteFolder(aFolderId);

      Result := True;
    end

  else
    begin

      if (FFolderPipeline.Locate(FFolderFieldNames.FolderId, aFolderId, [pploCaseInsensitive])) then
        begin
          FFolderPipeline.Edit;
          FFolderPipeline.SetFieldValue(FFolderFieldNames.ParentId, aNewParentId);
          FFolderPipeline.Post;

          Result := True;
        end;
    end;

end; {procedure, MoveFolderToFolder}

{------------------------------------------------------------------------------}
{ TppReportExplorer.MoveFoldersToFolder }

function TppReportExplorer.MoveFoldersToFolder(aOldFolderId, aNewFolderId: Integer): Boolean;
var
  lList: TStringList;
  liIndex: Integer;
  lFolderInfo: TppFolderInfo;
begin

  Result := True;

  lList := TStringList.Create;

  GetChildFolders(aOldFolderId, lList);

  for liIndex := 0 to lList.Count - 1 do
    begin
      lFolderInfo := TppFolderInfo(lList.Objects[liIndex]);

      if not(MoveFolderToFolder(lFolderInfo.FolderId, aNewFolderId)) then
        Result := False;

      lFolderInfo.Free;
    end;

  lList.Free;

end; {function, MoveFoldersToFolder}

{------------------------------------------------------------------------------}
{ TppReportExplorer.MoveItemsToFolder }

function TppReportExplorer.MoveItemsToFolder(aOldFolderId, aNewFolderId: Integer): Boolean;
var
  lList: TStringList;
  lbSaveShowMessages: Boolean;
  liIndex: Integer;
  lItemInfo: TppItemInfo;
begin

  Result := True;

  lList := TStringList.Create;

  GetItems(aOldFolderId, itAllFolders, lList);

  lbSaveShowMessages := FShowMessages;
  FShowMessages := False;

  for liIndex := 0 to lList.Count - 1 do
    begin
      lItemInfo := TppItemInfo(lList.Objects[liIndex]);

      if not(MoveItemToFolder(lItemInfo.Name, lItemInfo.ItemType, lItemInfo.FolderId, aNewFolderId)) then
        Result := False;

      lItemInfo.Free;
    end;

  FShowMessages := lbSaveShowMessages;

  lList.Free;

end; {function, MoveItemsToFolder}

{------------------------------------------------------------------------------}
{ TppReportExplorer.MoveItemToFolder }

function TppReportExplorer.MoveItemToFolder(const aItemName: String; aItemType, aFolderId, aNewFolderId: Integer): Boolean;
var
  lbUpdateFolder: Boolean;
  lbDeleteReport: Boolean;
  ldNow: Double;
begin

  Result := False;

  lbUpdateFolder := True;

  ldNow := Now;

  if not(FRecyclingItems) and (LocateItemRecord(aItemName, aItemType, aNewFolderId)) then
    begin

      if (FShowMessages) then
        lbDeleteReport := ConfirmReplaceItem(aItemName)
      else
        lbDeleteReport := True;

      if lbDeleteReport then
        Delete(aItemName, aItemType, aNewFolderId)
      else
        lbUpdateFolder := False;

    end;

  if lbUpdateFolder and (LocateItemRecord(aItemName, aItemType, aFolderId)) then
    begin

      FItemPipeline.Edit;

      FItemPipeline.SetFieldValue(FItemFieldNames.FolderId, aNewFolderId);

      // update deleted field
      if FRecyclingItems then
        FItemPipeline.SetFieldValue(FItemFieldNames.Deleted, ldNow)
      else
        FItemPipeline.SetFieldValue(FItemFieldNames.Deleted, Null);

      FItemPipeline.Post;

      Result := True;
    end;

end; {procedure, MoveItemToFolder}


{@TppReportExplorer.Delete
 Locates the item with the given name, item type, and folder id and deletes it.
 This routine deletes the item directly, without displaying any confirmation
 message. In order to display a confirmation message, call ConfirmItemDelete.

 This procedure is called by the Report Explorer form when the end user wants to
 delete a report.  The Report Explorer displays a confirmation message before
 calling this routine. You should not need to call this routine unless you are
 replacing the Report Explorer form with a form of your own.  For more
 information on replacing the Report Explorer form, see the Form property.}

procedure TppReportExplorer.Delete(const aItemName: String; aItemType, aFolderId: Integer);
begin

  if not(Initialize) then Exit;

  if LocateItemRecord(aItemName, aItemType, aFolderId) then
    FItemPipeline.Delete;

end; {procedure, Delete}


{@TppReportExplorer.Rename
 Renames the given item using the aNewName parameter.

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

procedure TppReportExplorer.Rename(const aItemName, aNewName: String; aItemType, aFolderId: Integer);
begin

  if not(Initialize) then Exit;

  if LocateItemRecord(aItemName, aItemType, aFolderId) then
    begin
      FItemPipeline.Edit;
      FItemPipeline.SetFieldValue(FItemFieldNames.Name, aNewName);
      FItemPipeline.Post;
    end;

end; {procedure, Rename}


{@TppReportExplorer.GetItems
 Returns all of the items in a given folder.  The folder is specified via the
 aFolderId parameter.  If the aItemType = 0, then all items are returned;
 otherwise, only items matching the specified type are returned (1- reports,
 2 - code modules, 3 - data modules).

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

procedure TppReportExplorer.GetItems(aFolderId, aItemType: Integer; aList: TStrings);
var
  lItemInfo: TppItemInfo;
begin

  if not(Initialize) then Exit;

  aList.Clear;

  // to optimize performance close the update pipeline
  if (FItemTemplatePipeline <> FItemPipeline) then
    FItemTemplatePipeline.Close;


  if not(FItemPipeline.Active) then
    FItemPipeline.Open;

  FItemPipeline.First;

  while not(FItemPipeline.EOF) do
    begin

      if (FItemPipeline.GetFieldValue(FItemFieldNames.FolderId) = aFolderId) and
         ((aItemType = 0) or (FItemPipeline.GetFieldValue(FItemFieldNames.ItemType) = aItemType)) then
        begin
          lItemInfo := TppItemInfo.Create;

          if (FItemPipeline.GetFieldValue(FItemFieldNames.Deleted) <> Null) then
            lItemInfo.Deleted := FItemPipeline.GetFieldValue(FItemFieldNames.Deleted);

          if (FItemPipeline.GetFieldValue(FItemFieldNames.Modified) <> Null) then
            lItemInfo.Modified := FItemPipeline.GetFieldValue(FItemFieldNames.Modified);

          lItemInfo.FolderId := FItemPipeline.GetFieldValue(FItemFieldNames.FolderId);
          lItemInfo.ItemId := FItemPipeline.GetFieldValue(FItemFieldNames.ItemId);
          lItemInfo.ItemType := FItemPipeline.GetFieldValue(FItemFieldNames.ItemType);
          lItemInfo.Name := FItemPipeline.GetFieldValue(FItemFieldNames.Name);
          lItemInfo.Size := FItemPipeline.GetFieldValue(FItemFieldNames.Size);

          aList.AddObject(lItemInfo.Name, lItemInfo);
        end;

      FItemPipeline.Next;
    end;

end; {procedure, GetItems}

{------------------------------------------------------------------------------}
{ TppReportExplorer.FreeItems }

procedure TppReportExplorer.FreeItems(aList: TStrings);
var
  liIndex: Integer;
  
begin

  for liIndex := 0 to aList.Count-1 do
    aList.Objects[liIndex].Free;

  aList.Clear;

end; {procedure, FreeItems}


{@TppReportExplorer.GetFolders
 Returns a list of all folders in the FolderPipeline.  The list must then be
 reduced using the nesting relations between the folders.

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

procedure TppReportExplorer.GetFolders(aList: TStrings);
var
  lFolderInfo: TppFolderInfo;
begin

  if not(Initialize) then Exit;

  aList.Clear;

  FFolderPipeline.First;

  while not(FFolderPipeline.EOF) do
    begin
      lFolderInfo := TppFolderInfo.Create;

      lFolderInfo.Name := FFolderPipeline.GetFieldValue(FFolderFieldNames.Name);
      lFolderInfo.FolderId := FFolderPipeline.GetFieldValue(FFolderFieldNames.FolderId);
      lFolderInfo.ParentId := FFolderPipeline.GetFieldValue(FFolderFieldNames.ParentId);

      aList.AddObject(lFolderInfo.Name, lFolderInfo);

      FFolderPipeline.Next;
    end;

end; {procedure, GetFolders}


{@TppReportExplorer.GetParentFolders
 Returns the chain of folders in which the folder specified by the aFolderId
 parameter is nested.

 This procedure is called by the Report Explorer form. You should not need to
 call this routine unless you are replacing the Report Explorer form with a form
 of your own.  For more information on replacing the Report Explorer form, see
 the Form property.}

procedure TppReportExplorer.GetParentFolders(aFolderId: Integer; aList: TStrings);
var
  lFolderInfo: TppFolderInfo;
  liParentId: Integer;
begin

  if not(Initialize) then Exit;

  FFolderPipeline.First;

  if not(ppdaNoRecords in FFolderPipeline.State) and FFolderPipeline.Locate(FFolderFieldNames.FolderId, aFolderId, [pploCaseInsensitive]) then
    liParentId := FFolderPipeline.GetFieldValue(FFolderFieldNames.ParentId)
  else
    liParentId := -1;

  if liParentID = -1 then Exit;

  FFolderPipeline.First;

  if FFolderPipeline.Locate(FFolderFieldNames.FolderId, liParentId, [pploCaseInsensitive]) then
    begin
      lFolderInfo := TppFolderInfo.Create;

      lFolderInfo.Name := FFolderPipeline.GetFieldValue(FFolderFieldNames.Name);
      lFolderInfo.FolderId := FFolderPipeline.GetFieldValue(FFolderFieldNames.FolderId);
      lFolderInfo.ParentId := FFolderPipeline.GetFieldValue(FFolderFieldNames.ParentId);

      aList.AddObject(lFolderInfo.Name, lFolderInfo);

      GetParentFolders(lFolderInfo.FolderId, aList);
    end;

end; {procedure, GetParentFolders}


{@TppReportExplorer.GetChildFolders
 Returns all of the immediate children of the folder specified in the
 aFolderName parameter.

 This procedure is called by the Report Explorer form when the end user clicks
 on a new folder. You should not need to call this routine unless you are
 replacing the Report Explorer form with a form of your own.  For more
 information on replacing the Report Explorer form, see the Form property.}

procedure TppReportExplorer.GetChildFolders(aFolderId: Integer; aList: TStrings);
var
  lFolderInfo: TppFolderInfo;
begin

  if not(Initialize) then Exit;

  aList.Clear;

  FFolderPipeline.First;

  while not(FFolderPipeline.EOF) do
    begin

      if (FFolderPipeline.GetFieldValue(FFolderFieldNames.ParentId) = aFolderId) then
        begin
          lFolderInfo := TppFolderInfo.Create;

          lFolderInfo.Name := FFolderPipeline.GetFieldValue(FFolderFieldNames.Name);
          lFolderInfo.FolderId := FFolderPipeline.GetFieldValue(FFolderFieldNames.FolderId);
          lFolderInfo.ParentId := FFolderPipeline.GetFieldValue(FFolderFieldNames.ParentId);

          aList.AddObject(lFolderInfo.Name, lFolderInfo);
        end;

      FFolderPipeline.Next;
    end;

end; {procedure, GetChildFolders}

{------------------------------------------------------------------------------}
{ TppReportExplorer.GetCurrentFolderId }

function TppReportExplorer.GetCurrentFolderId: Integer;
begin

 if (FReport <> nil) then
   Result := FReport.Template.DatabaseSettings.FolderId
 else
   Result := 0;

end;

{------------------------------------------------------------------------------}
{ TppReportExplorer.GetCurrentItemName }

function TppReportExplorer.GetCurrentItemName: String;
begin

  if (FReport <> nil) then
    Result := FReport.Template.DatabaseSettings.Name
  else
    Result := '';

end;

{------------------------------------------------------------------------------}
{ TppReportExplorer.GetCurrentItemType }

function TppReportExplorer.GetCurrentItemType: Integer;
begin

 if (FReport <> nil) then
   Result := ItemTypeForTemplate(FReport.Template)
 else
   Result := -1;

end;

{------------------------------------------------------------------------------}
{ TppReportExplorer.SetCurrentFolderId }

procedure TppReportExplorer.SetCurrentFolderId(const Value: Integer);
begin

 if (FReport <> nil) then
   FReport.Template.DatabaseSettings.FolderId := Value;

end;

{------------------------------------------------------------------------------}
{ TppReportExplorer.SetCurrentItemName }

procedure TppReportExplorer.SetCurrentItemName(const Value: String);
begin

 if (FReport <> nil) then
   FReport.Template.DatabaseSettings.Name := Value;

end;

{------------------------------------------------------------------------------}
{ TppReportExplorer.SetItemTemplatePipeline }

procedure TppReportExplorer.SetItemTemplatePipeline(aItemPipeline:
    TppDataPipeline);
begin

  if (FItemTemplatePipeline <> nil) then
    FItemTemplatePipeline.RemoveNotify(Self);

  FItemTemplatePipeline := aItemPipeline;

  if (FItemTemplatePipeline <> nil) then
    FItemTemplatePipeline.AddNotify(Self);

end; {procedure, SetItemTemplatePipeline}


end.
