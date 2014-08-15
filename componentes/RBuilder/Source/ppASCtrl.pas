{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppASCtrl;

interface

{$I ppIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Buttons, Menus,

  ppTypes,
  ppCharacter,
  ppUtils,
  ppASField;

type

  TppAutoSearchPanel = class;
  TppAutoSearchPanelClass = class of TppAutoSearchPanel;

  TppAutoSearchDateTimePicker = class;
  TppDateTimeSearchControl = class;

  TppCreatePanelEvent = procedure(aField: TppAutoSearchField; aPanel: TppAutoSearchPanel) of object;
  TppGetPanelClassEvent = procedure(aField: TppAutoSearchField; var aPanelClass: TppAutoSearchPanelClass) of object;

  {@TppAutoSearchNotebook
  
    This component is part of the implementation of AutoSearch dialog.  When
    the Init method of the AutoSearch dialog is call by the report component,
    an AutoSearchNotebook is created and the Init method of the notebook is
    called.}

  {@TppAutoSearchNotebook.AutoSearchGroups

    Provides access to the AutoSearchFields associated with the report.
    It is assigned after the dialog has created the
    AutoSearchNotebook, but before the Init method od the notebook is
    called.}

  {@TppAutoSearchNotebook.Designing

    Indicates whether a Report Designer component exists for the current
    report.

    If a designer exists, the AutoSearch dialog displays a special popup
    menu when the AutoSearchFields have been created by multiple dataviews.
    In this case, a notebook tab containing the AutoSearch panels for each
    dataview is created.  The popup menu allows you to configure the order
    of these tabs.}

  {@TppAutoSearchNotebook.Height

    Returns the sum of the height of all AutoSearchPanels in the notebook.}

  {@TppAutoSearchNotebook.Init

    Configures the contents of the AutoSearchNotebook based on the
    AutoSearchFields.  If the AutoSearchFields have been supplied by
    multiple dataviews, then a tabbed notebook interface is used to show
    the fields from each data view.  If the AutoSearchFields have been
    supplied by one dataview or via code (as in ReportBuilder standard),
    then all the AutoSearchPanels appear in a single scroll box control.}

  {@TppAutoSearchNotebook.MandatoryFieldsExist

    This property is only valid after the Init method is called.  It is
    used by the AutoSearch dialog when determining whether to show the
    mandatory label.}

  {@TppAutoSearchNotebook.OnCreatePanel

    This event fires after a panel has been created, but before the Init
    method of the panel has been called.  This event is assigned by the
    AutoSearchDialog, which passes calls through to the PanelCreated
    virtual method.  By creating a descendant of the AutoSearch dialog and
    overriding this method, you can customize an instantiated panel.  An
    example of this approach is provided in the RBuilder\Demos\AutoSearch
    directory.}

  {@TppAutoSearchNotebook.OnGetPanelClass

    This event fires after a panel class has been selected, but the panel
    has been created.  This event is assigned by the AutoSearchDialog,
    which passes calls through to the GetPanelClassForField virtual method.
    By creating a descendant of the AutoSearch dialog and overriding this
    method, you can gain control over which panel class is used for a given
    field.  An example of this approach is provided in the
    RBuilder\\Demos\\AutoSearch directory.}

  {@TppAutoSearchNotebook.Parent

    When the AutoSearchNotebook is created, the AutoSearch dialog assigns
    itself as the Parent.  This setting is then used to assign the Parent
    property of the TScrollBox component created by the notebook.
    Effectively the AutoSearch dialog becomes the parent of the TScrollBox
    and the TScrollBox becomes the parent of the AutoSearchPanels.}

  TppAutoSearchNotebook = class(TObject)
    private
      FAutoSearchGroups: TppAutoSearchGroups;
      FDesigning: Boolean;
      FHeight: Integer;
      FMandatoryFieldsExist: Boolean;
      FOnCreatePanel: TppCreatePanelEvent;
      FOnGetPanelClass: TppGetPanelClassEvent;
      FPageControl: TPageControl;
      FParent: TWinControl;
      FScrollBox: TScrollBox;
      FWidth: Integer;

      procedure AddSearchField(aField: TppAutoSearchField; aPanel: TppAutoSearchPanel);
      procedure CalcDimensions;
      procedure CalcPanelDimensions(aScrollBox: TScrollBox; var aWidth, aHeight: Integer);
      procedure CreatePageControl;
      procedure CreateControlsForGroup(aAutoSearchGroup: TppAutoSearchGroup);
      procedure CreateNoteBookControls;
      function  CreatePanelForField(aField: TppAutoSearchField): TppAutoSearchPanel;
      procedure CreateTabSheet(aGroup: TppAutoSearchGroup);
      procedure CreateTabSheets;
      function  FindTabSheet(const aCaption: String): TTabSheet;
      procedure MoveTabLeftClickEvent(Sender: TObject);
      procedure MoveTabRightClickEvent(Sender: TObject);
      procedure PopupMenuPopupEvent(Sender: TObject);
      function ValidGroup(aAutoSearchGroup: TppAutoSearchGroup): Boolean;
      procedure ValidateTabSheet(aSetActivePage, aValid: Boolean; aPanel: TppAutoSearchPanel);

    public
      constructor Create(aParent: TWinControl);
      destructor Destroy; override;

      procedure Init;
      procedure SetFocus;
      function  Valid: Boolean;

      property AutoSearchGroups: TppAutoSearchGroups read FAutoSearchGroups write FAutoSearchGroups;
      property Designing: Boolean read FDesigning write FDesigning;
      property Height: Integer read FHeight write FHeight;
      property MandatoryFieldsExist: Boolean read FMandatoryFieldsExist;
      property OnCreatePanel: TppCreatePanelEvent read FOnCreatePanel write FOnCreatePanel;
      property OnGetPanelClass: TppGetPanelClassEvent read FOnGetPanelClass write FOnGetPanelClass;
      property Parent: TWinControl read FParent;
      property Width: Integer read FWidth write FWidth;

  end; {class, TppAutoSearchNotebook}

 // TppAutoSearchPanelGroup = class
    // property AutoSearchGroup: TppAutoSearchGroup
    //
//  end;


  {@TppAutoSearchPanel

    Ancestor from which all AutoSearch panels descend. The standard
    AutoSearch panels provided with ReportBuilder are:

            - TppSimpleSearchPanel
               - TppSimpleLookupListSearchPanel
               - TppBetweenSearchPanel
                  - TppBewteenLookupListSearchPanel
               - TppInListSearchPanel
                  - TppInListLookupListSearchPanel

    The following screen shot shows a typical AutoSearch dialog with a
    SimpleSearchPanel and an InListSearchPanel.  The component parts of the
    panels are labeled.

    <IMAGE AutoSearchDialogWithCallouts>}

  {@TppAutoSearchPanel.ErrorBullet

    This is a red, circular shape.  It is positioned at the upper right of
    the edit control for the search panel.  If the criteria fails the
    validation test, the panel makes this shape visible, along with the
    ErrorLabel.}

  {@TppAutoSearchPanel.ErrorLabel

    This label is located directly beneath the edit control for the search
    panel.  If the search criteria fails validation, this label is assigned
    an appropriate caption and is made visible along with the ErrorBullet.
    The font color of this label is red.}

  {@TppAutoSearchPanel.Field

    The AutoSearchField to which the panel has been assigned.  When the
    Init method is called, the panel creates the edit controls which are
    appropriate given the value of the FieldAlias, SearchOperator and
    SearchExpression.}

  {@TppAutoSearchPanel.FieldAliasLabel

    Contains the AutoSearchField's FieldAlias in the caption.}

  {@TppAutoSearchPanel.LogicalLabel

    This is leftmost label in the search panel.  If the value of the
    Position property of the field is zero, then the caption contains the
    string 'Show all data where', otherwise it contains the string 'and
    the'.}

  {@TppAutoSearchPanel.MandatoryBullet

    This is a black, circular shape positioned to the right of the edit
    control of the search panel.  If the Mandatory property of the Field is
    True, then this shape is displayed when the search panel is created.}

  {@TppAutoSearchPanel.OperatorLabel

    The caption of this control contains a description of the operator to
    be used with this AutoSearchField.}

  TppAutoSearchPanel = class(TPanel)
    private
      FField: TppAutoSearchField;

      {controls}
      FLogicalLabel: TLabel;
      FFieldAliasLabel: TLabel;
      FOperatorLabel: TLabel;
      FErrorBullet: TShape;
      FErrorLabel: TLabel;
      FFieldGroup: TppAutoSearchGroup;
      FMandatoryBullet: TShape;
      FShowAllValues: TCheckBox;

      function  FirstField: Boolean;
      function  LastField: Boolean;
      procedure SetField(aField: TppAutoSearchField);
      procedure ClickEvent(Sender: TObject);
      function GetLookupList: TppLookupList;

    protected
      procedure DisableControls; virtual;
      procedure EnableControls; virtual;
      function  OverEditControl(aX, aY: Integer): Boolean; virtual; abstract;
      procedure ShowAllValuesClickEvent(Sender: TObject); virtual;
      procedure ppParseString(aString: String; aStrings: TStrings); // backward compatibility

      property ErrorBullet: TShape read FErrorBullet;
      property ErrorLabel: TLabel read FErrorLabel;
      property MandatoryBullet: TShape read FMandatoryBullet;
      property LookupList: TppLookupList read GetLookupList;
      property ShowAllValues: TCheckBox read FShowAllValues;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      function  CalcHeight: Integer; virtual;
      function  CalcWidth: Integer; virtual;
      procedure Init; virtual;
      procedure Configure; virtual;
      procedure SetTabOrder; virtual;
      function  Valid: Boolean; virtual;
      function  ValidateValue(const aValue: String; aDataType: TppDataType; var aErrorMessage: String): Boolean;

      property Field: TppAutoSearchField read FField write SetField;
      property FieldAliasLabel: TLabel read FFieldAliasLabel write FFieldAliasLabel;
      property FieldGroup: TppAutoSearchGroup read FFieldGroup write FFieldGroup;
      property LogicalLabel: TLabel read FLogicalLabel write FLogicalLabel;
      property OperatorLabel: TLabel read FOperatorLabel write FOperatorLabel;

  end; {class, TppAutoSearchPanel}


  {@TppSimpleSearchPanel

    The SimpleSearchPanel is created as part of the AutoSearchDialog.  This
    panel is designed to handle a single field, singular operator, and an edit
    control. An AutoSearch dialog containing a SimpleSearchPanel is pictured
    below.

    <IMAGE AutoSearchSimplePanel>


    When the panel is instantiated, the AutoSearchField property values are
    assigned as follows:

    <Table>
    Field Property      SimpleSearchPanel Control
    -----------------   -------------------------
    Position            LogicalLabel
    FieldAlias	        FieldAliasLabel
    OperatorDesc        OperatorLabel
    SearchExpression    EditControl
    Mandatory           MandatoryBullet
    </Table>

    Descends from TppAutoSearchPanel and adds logic that can manage a single
    control such as an edit box or combo box. Descendants include
    
               - TppSimpleLookupListSearchPanel
               - TppBetweenSearchPanel
               - TppInListSearchPanel}

  {@TppSimpleSearchPanel.EditControl

    Contains the search expression as entered by the user.}

  {@TppSimpleSearchPanel.ControlText

    Contains the search expression as entered by the user.}

  TppSimpleSearchPanel = class(TppAutoSearchPanel)
    private
      FControl: TWinControl;
      FEditControl: TEdit;
    protected
      function CreateControl: TWincontrol; virtual;
      procedure DisableControls; override;
      procedure EditControlKeyUpEvent(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure EnableControls; override;
      function GetControlText: String; virtual;
      function  OverEditControl(aX, aY: Integer): Boolean; override;
      procedure SetControlText(const Value: String); virtual;
      procedure ShowAllValuesClickEvent(Sender: TObject); override;

      property Control: TWinControl read FControl;
      property ControlText: String read GetControlText write SetControlText;
    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      {overriden from TPanel}
      procedure SetFocus; override;

      function  CalcWidth: Integer; override;
      procedure Init; override;
      function  Valid: Boolean; override;
      function ValidateControl(aControl: TWinControl): Boolean;
      property EditControl: TEdit read FEditControl;

  end; {class, TppSimpleSearchPanel}


  {@TppSimpleLookupListSearchPanel

    The SimpleLookupListSearchPanel is created as part of the AutoSearchDialog.  This
    panel is designed to handle a single field, singular operator, and a
    combobox control. The combobox control displays a drop down list of items
    from which the user can select.

    When the panel is instantiated, the AutoSearchField property values are
    assigned as follows:

    <Table>
    Field Property      SimpleSearchPanel Control
    -----------------   -------------------------
    Position            LogicalLabel
    FieldAlias	        FieldAliasLabel
    OperatorDesc        OperatorLabel
    SearchExpression    ComboBox
    Mandatory           MandatoryBullet
    </Table>}

  {@TppSimpleLookupListSearchPanel.ComboBox

    The combobox that displays a drop down list of search values from which from
    which the user can select.}

  TppSimpleLookupListSearchPanel = class(TppSimpleSearchPanel)
    private
      FComboBox: TComboBox;
    protected
      function CreateControl: TWincontrol; override;
      procedure ehComboBox_Select(Sender: TObject); virtual;
      function GetControlText: String; override;
      procedure SetControlText(const Value: String); override;
    public
      property ComboBox: TComboBox read FComboBox;

  end; {class, TppSimpleLookupListSearchPanel}


 {@TppBetweenSearchPanel
  
    The BetweenSearchPanel is created as part of the AutoSearchDialog.
    This panel is designed to handle the Between and Not Between Search
    Operators.  It is expected that the SearchExpression contains a comma-
    delimited set of two values.  The first value is assigned to the
    EditControl the second to EditControl2. An AutoSearch dialog containing
    a BetweenSearchPanel is pictured below.

    <IMAGE AutoSearchBetweenPanel>

    When the panel is instantiated the AutoSearchField property values are
    assigned as follows:

    <Table>
    Field Property      BetweenSearchPanel Control
    ----------------    -------------------------
    Position            LogicalLabel
    FieldAlias          FieldAliasLabel
    OperatorDesc        OperatorLabel
    SearchExpression    EditControl
    SearchExpression    EditControl2
    Mandatory           MandatoryBullet
    </Table>}

  {@TppBetweenSearchPanel.AndLabel

    This is label is positioned between the two edit controls and contains
    the string 'and'.}

  {@TppBetweenSearchPanel.EditControl2

    This control takes the second search value in the
    Field.SearchExpression property.  When using the Between and Not
    Between operators the SearchExpression must be a comma-delimited set of
    two values.}

  {@TppBetweenSearchPanel.Control2Text

    The second search value int he AutoSearchField.SearchExpression.  When using
    the Between and Not Between operators the SearchExpression contains a
    comma-delimited set of two values.}

  TppBetweenSearchPanel = class(TppSimpleSearchPanel)
    private
      FAndLabel: TLabel;
      FControl2: TWinControl;
      FEditControl2: TEdit;
      FMandatoryBullet2: TShape;

    protected
      function CreateControl2: TWincontrol; virtual;
      procedure DisableControls; override;
      procedure EnableControls; override;
      function GetControl2Text: String; virtual;
      function  OverEditControl(aX, aY: Integer): Boolean; override;
      procedure SetControl2Text(const Value: String); virtual;

      property AndLabel: TLabel read FAndLabel;
      property Control2: TWinControl read FControl2;
      property MandatoryBullet2: TShape read FMandatoryBullet2;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      function  CalcWidth: Integer; override;
      procedure Init; override;
      function  Valid: Boolean; override;
      function ValidateControl2(aControl: TWinControl): Boolean;

      property Control2Text: String read GetControl2Text write SetControl2Text;
      property EditControl2: TEdit read FEditControl2;

  end; {class, TppBetweenSearchPanel}


  {@TppBetweenLookupListSearchPanel

    The BetweenLookupListSearchPanel is created as part of the AutoSearchDialog.
    This panel is designed to handle the Between and Not Between Search
    Operators.  It is expected that the SearchExpression contains a comma-
    delimited set of two values.  The first value is assigned to the
    ComboBox the second to ComboBox2. Each ComboBox displays a list of
    available items from the which user can choose.

    When the panel is instantiated the AutoSearchField property values are
    assigned as follows:

    <Table>
    Field Property      BetweenSearchPanel Control
    ----------------    -------------------------
    Position            LogicalLabel
    FieldAlias          FieldAliasLabel
    OperatorDesc        OperatorLabel
    SearchExpression    EditControl
    SearchExpression    EditControl2
    Mandatory           MandatoryBullet
    </Table>}

  {@TppBetweenSearchPanel.AndLabel

    This is label is positioned between the two edit controls and contains
    the string 'and'.}

  {@TppBetweenSearchPanel.Combobox

    This control takes the first search value in the
    Field.SearchExpression property.  When using the Between and Not
    Between operators the SearchExpression must be a comma-delimited set of
    two values.}

  {@TppBetweenSearchPanel.Combobox2

    This control takes the second search value in the
    Field.SearchExpression property.  When using the Between and Not
    Between operators the SearchExpression must be a comma-delimited set of
    two values.}

  TppBetweenLookupListSearchPanel = class(TppBetweenSearchPanel)
    private
      FComboBox: TComboBox;
      FComboBox2: TComboBox;
    protected
      function CreateControl: TWincontrol; override;
      function CreateControl2: TWincontrol; override;
      function GetControlText: String; override;
      function GetControl2Text: String; override;
      procedure SetControlText(const Value: String); override;
      procedure SetControl2Text(const Value: String); override;
    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      property ComboBox: TComboBox read FComboBox;
      property ComboBox2: TComboBox read FComboBox2;

  end; {class, TppBetweenLookupListSearchPanel}


  {@TppInListSearchPanel

    The InListSearchPanel is created as part of the AutoSearchDialog.  This
    panel is designed to handle the InList and Not InList search operators.  It
    is expected that the SearchExpression contains a comma-delimited set of
    values.  The values are parsed and assigned to the ListBox. An AutoSearch
    dialog containing a InListSearchPanel is pictured below.

    <IMAGE AutoSearchInListPanel>

    When the panel is instantiated the AutoSearchField property values are
    assigned as follows:

    <Table>
    Field Property      BetweenSearchPanel Control
    -----------------   --------------------------
    Position            LogicalLabel
    FieldAlias          FieldAliasLabel
    OperatorDesc        OperatorLabel
    SearchExpression    ListBox
    Mandatory           MandatoryBullet
    </Table>}

  {@TppInListSearchPanel.AddButton

    The button positioned between the EditControl and the list box.  When a user
    enters search criteria in the list box, they can click this button to add it
    to the list.}

  {@TppInListSearchPanel.ListBox

    This control contains the search values that will be assigned to the 
    SearchExpression of the Field as a comma-delimited string.}

  {@TppInListSearchPanel.RemoveButton

    The button positioned between the EditControl and the ListBox.  If the user
    selects a search criteria value in the ListBox, he can click this button to
    delete it.}

  TppInListSearchPanel = class(TppSimpleSearchPanel)
    private
      FListBox: TListBox;
      FAddButton: TSpeedButton;
      FRemoveButton: TSpeedButton;
      procedure ehListBox_DblClick(Sender: TObject);

    protected
      procedure AddButtonClickEvent(Sender: TObject);  virtual;
      procedure RemoveButtonClickEvent(Sender: TObject); virtual;
      function  ValidateListBoxControl(aListBox: TListBox): Boolean; virtual;

      procedure DisableControls; override;
      procedure EnableControls; override;
      function  OverEditControl(aX, aY: Integer): Boolean; override;

      property ListBox: TListBox read FListBox;
      property AddButton: TSpeedButton read FAddButton;
      property RemoveButton: TSpeedButton read FRemoveButton;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      function  CalcWidth: Integer; override;
      procedure DeselectItem(aIndex: Integer); overload; virtual;
      procedure DeselectItem(aItemName: String); overload; virtual;
      procedure Init; override;
      procedure SelectItem(aItemName: String); overload; virtual;
      function  Valid: Boolean; override;

  end; {class, TppInListSearchPanel}

  
  {@TppInListLookupListSearchPanel

    The InListLookupListSearchPanel is created as part of the AutoSearchDialog.  This
    panel is designed to handle the InList and Not InList search operators.  It
    is expected that the SearchExpression contains a comma-delimited set of
    values.  The values are parsed and assigned to the ListBox.
    
    When the panel is instantiated the AutoSearchField property values are
    assigned as follows:

    <Table>
    Field Property      BetweenSearchPanel Control
    -----------------   --------------------------
    Position            LogicalLabel
    FieldAlias          FieldAliasLabel
    OperatorDesc        OperatorLabel
    SearchExpression    ListBox
    Mandatory           MandatoryBullet
    </Table>}

  {@TppInListSearchPanel.ComboBox

    Combox used to seelect a search value to be added added to the list.}

  TppInListLookupListSearchPanel = class(TppInListSearchPanel)
  private
    FComboBox: TComboBox;
    FAvailableList: TppLookupList;
    FSearchValues: TStringList;
  protected
    procedure AddButtonClickEvent(Sender: TObject); override;
    function CreateControl: TWincontrol; override;
    function GetControlText: String; override;
    procedure SetControlText(const Value: String); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure DeselectItem(aIndex: Integer); override;
    procedure Init; override;
    procedure SelectItem(aItemName: String); override;
    function Valid: Boolean; override;
  public
    property ComboBox: TComboBox read FComboBox;
  end;


  {@TppSimpleDateTimeSearchPanel

    The SimpleLookupListSearchPanel is created as part of the AutoSearchDialog.  This
    panel is designed to handle a single field, singular operator, and a
    DatePicker control. The DatePicker control displays a calendar or
    a an updown edit control.

    When the panel is instantiated, the AutoSearchField property values are
    assigned as follows:

    <Table>
    Field Property      SimpleSearchPanel Control
    -----------------   -------------------------
    Position            LogicalLabel
    FieldAlias	        FieldAliasLabel
    OperatorDesc        OperatorLabel
    SearchExpression    DatePicker
    Mandatory           MandatoryBullet
    </Table>}

  {@TppSimpleDateTimeSearchPanel.DatePicker

    The DatePicker that displays used to specify a date and/or time.}

  TppSimpleDateTimeSearchPanel = class(TppSimpleSearchPanel)
    private
      FDateTimeControl: TppDateTimeSearchControl;
    protected
      function CreateControl: TWincontrol; override;
      function GetControlText: String; override;
      procedure SetControlText(const Value: String); override;
    public
      property DateTimeControl: TppDateTimeSearchControl read FDateTimeControl;

  end; {class, TppSimpleDateTimeSearchPanel}


  {@TppBetweenDateTimeSearchPanel

    The BetweenLookupListSearchPanel is created as part of the AutoSearchDialog.
    This panel is designed to handle the Between and Not Between Search
    Operators.  It is expected that the SearchExpression contains a comma-
    delimited set of two values.  The first value is assigned to the
    DateTimeControl the second to DateTimePicker2. Each DateTimeControl control
    enables the user to specify a date and/or time using a calendar.

    When the panel is instantiated the AutoSearchField property values are
    assigned as follows:

    <Table>
    Field Property      BetweenSearchPanel Control
    ----------------    -------------------------
    Position            LogicalLabel
    FieldAlias          FieldAliasLabel
    OperatorDesc        OperatorLabel
    SearchExpression    EditControl
    SearchExpression    EditControl2
    Mandatory           MandatoryBullet
    </Table>}

  {@TppBetweenSearchPanel.AndLabel

    This is label is positioned between the two edit controls and contains
    the string 'and'.}

  {@TppBetweenSearchPanel.DateTimeControl

    This control takes the first search value in the
    Field.SearchExpression property.  When using the Between and Not
    Between operators the SearchExpression must be a comma-delimited set of
    two values.}

  {@TppBetweenSearchPanel.DateTimePicker2

    This control takes the second search value in the
    Field.SearchExpression property.  When using the Between and Not
    Between operators the SearchExpression must be a comma-delimited set of
    two values.}

  TppBetweenDateTimeSearchPanel = class(TppBetweenSearchPanel)
    private
      FDateTimeControl: TppDateTimeSearchControl;
      FDateTimeControl2: TppDateTimeSearchControl;
    protected
      function CreateControl: TWincontrol; override;
      function CreateControl2: TWincontrol; override;
      function GetControlText: String; override;
      function GetControl2Text: String; override;
      procedure SetControlText(const Value: String); override;
      procedure SetControl2Text(const Value: String); override;
    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;
      procedure Init; override;
      property DateTimeControl: TppDateTimeSearchControl read FDateTimeControl;
      property DateTimeControl2: TppDateTimeSearchControl read FDateTimeControl2;

  end; {class, TppBetweenDateTimeSearchPanel}


  {@TppInListDateTimeSearchPanel

    The InListLookupListSearchPanel is created as part of the AutoSearchDialog.  This
    panel is designed to handle the InList and Not InList search operators.  It
    is expected that the SearchExpression contains a comma-delimited set of
    values.  The values are parsed and assigned to the ListBox.
    
    When the panel is instantiated the AutoSearchField property values are
    assigned as follows:

    <Table>
    Field Property      BetweenSearchPanel Control
    -----------------   --------------------------
    Position            LogicalLabel
    FieldAlias          FieldAliasLabel
    OperatorDesc        OperatorLabel
    SearchExpression    ListBox
    Mandatory           MandatoryBullet
    </Table>}

  {@TppInListSearchPanel.DateTimeControl

    DateTimeControl used to select a search value to be added added to the list.}

  TppInListDateTimeSearchPanel = class(TppInListSearchPanel)
  private
    FDateTimeControl: TppDateTimeSearchControl;
  protected
    function CreateControl: TWincontrol; override;
    function GetControlText: String; override;
    procedure SetControlText(const Value: String); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  public
    property DateTimeControl: TppDateTimeSearchControl read FDateTimeControl;
  end;

 {@TppAutoSearchDateTimePicker}
  TppAutoSearchDateTimePicker = class(TDateTimePicker)
  private
    FField: TppAutoSearchField;
    function GetDateTimeString: string;
    function GetFormat: String;
    procedure SetDateTimeString(const Value: string);

    procedure DateChangeEvent(Sender: TObject);
  public
    procedure Initialize(aField: TppAutoSearchField; aValueIndex: Integer = 0;
        aKind: TDateTimeKind = dtkDate);
    property DateTimeString: string read GetDateTimeString write SetDateTimeString;
  end;

 {@TppDateTimeSearchControl}
  TppDateTimeSearchControl = class(TCustomControl)
    private
      FDatePicker: TppAutoSearchDateTimePicker;
      FField: TppAutoSearchField;
      FTimePicker: TppAutoSearchDateTimePicker;
    protected
      function GetControlText: String;
    public
      procedure Initialize(aField: TppAutoSearchField; aValueIndex: Integer = 0);
      procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
      property ControlText: String read GetControlText;
      property Field: TppAutoSearchField read FField write FField;
      property DatePicker: TppAutoSearchDateTimePicker read FDatePicker;
      property TimePicker: TppAutoSearchDateTimePicker read FTimePicker;

  end; {class, TppDateTimeSearchControl}



implementation

{******************************************************************************
 *
 ** A U T O   S E A R C H    N O T E B O O K
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.Create}

constructor TppAutoSearchNotebook.Create(aParent: TWinControl);
begin

  inherited Create;

  FHeight := 0;
  FMandatoryFieldsExist := False;
  FOnCreatePanel := nil;
  FOnGetPanelClass := nil;
  FPageControl := nil;
  FParent := aParent;
  FScrollBox := nil;
  FWidth := 0;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.Destroy}

destructor TppAutoSearchNotebook.Destroy;
var
  liIndex: Integer;
  liGroup: Integer;
  lGroup: TppAutoSearchGroup;
  lField: TppAutoSearchField;
begin

  for liGroup := 0 to FAutoSearchGroups.Count-1 do
    begin
      lGroup := FAutoSearchGroups[liGroup];

      for liIndex := 0 to lGroup.FieldCount - 1 do
        begin
          lField := lGroup.Fields[liIndex];

          lField.ParentControl := nil;
          lField.AutoSearchPanel := nil;
        end;

    end;

  FScrollBox.Free;
  FPageControl.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.SetFocus }

procedure TppAutoSearchNotebook.SetFocus;
var
  lField: TppAutoSearchField;
  lPanel: TppAutoSearchPanel;
  lScrollBox: TScrollBox;
begin

  if (FAutoSearchGroups.Count = 0) then Exit;

  if (FPageControl = nil) then
    begin

      lField := TppAutoSearchField(FAutoSearchGroups[0].Fields[0]);

      lPanel := TppAutoSearchPanel(lField.AutoSearchPanel);

      lPanel.SetFocus;
    end
  else
    begin
      lScrollBox := TScrollBox(FPageControl.Pages[0].Controls[0]);

      lPanel := TppAutoSearchPanel(lScrollBox.Controls[0]);

      lPanel.SetFocus;
    end;

end; {procedure, SetFocus}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.Init }

procedure TppAutoSearchNotebook.Init;
begin

  CreateNoteBookControls;

  CalcDimensions;

end; {procedure, Init}


{@TppAutoSearchNotebook.Valid
 Returns the status of the AutoSearchPanels.  The Valid method of each
 AutoSearchPanel is called.  If any panels contain invalid search criteria, then
 false is returned.}

function TppAutoSearchNotebook.Valid: Boolean;
var
  lbValid: Boolean;
  liIndex: Integer;
begin

  Result := True;

  for liIndex := 0 to FAutoSearchGroups.Count-1 do
    begin
      lbValid := ValidGroup(FAutoSearchGroups[liIndex]);

      if not(lbValid) and Result then
        Result := False;

    end;

end; {function, Valid}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.ValidGroup}

function TppAutoSearchNotebook.ValidGroup(aAutoSearchGroup: TppAutoSearchGroup): Boolean;
var
  lbValid: Boolean;
  liIndex: Integer;
  lField: TppAutoSearchField;
  lPanel: TppAutoSearchPanel;
begin

  Result := True;

  for liIndex := 0 to aAutoSearchGroup.FieldCount-1 do
    begin
      lField := aAutoSearchGroup.Fields[liIndex];

      lPanel := TppAutoSearchPanel(lField.AutoSearchPanel);

      lbValid := lPanel.Valid;

      ValidateTabSheet(Result, lbValid, lPanel);

      if not(lbValid) and Result then
        Result := False;

    end;


end; {function, ValidGroup}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.ValidateTabSheet}

procedure TppAutoSearchNotebook.ValidateTabSheet(aSetActivePage, aValid: Boolean; aPanel: TppAutoSearchPanel);
var
  lTabSheet: TTabSheet;
  lScrollBox: TScrollBox;
begin

  if (FPageControl = nil) then Exit;

  lScrollBox := TScrollBox(aPanel.Parent);

  lTabSheet := TTabSheet(lScrollBox.Parent);

  if (aPanel = lScrollBox.Controls[0]) then
    lTabSheet.ImageIndex := -1;

  if not(aValid) then
    lTabSheet.ImageIndex := 0;


  if aSetActivePage and (FPageControl.ActivePage <> lTabSheet) then
    FPageControl.ActivePage := lTabSheet;

end; {procedure, ValidateTabSheet}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.AddSearchField}

procedure TppAutoSearchNotebook.AddSearchField(aField: TppAutoSearchField; aPanel: TppAutoSearchPanel);
var
  lPreviousPanel: TppAutoSearchPanel;
  lScrollBox: TScrollBox;
begin

  lScrollBox := TScrollBox(aField.ParentControl);

  aPanel.Parent := lScrollBox;
  aPanel.Field := aField;
  aPanel.Init;
  aPanel.SetTabOrder;
  aPanel.Configure;

  if (lScrollBox.ControlCount > 1) then
    begin
      lPreviousPanel := TppAutoSearchPanel(lScrollBox.Controls[lScrollBox.ControlCount - 2]);

      aPanel.Left := 0;
      aPanel.Top := lPreviousPanel.Top + lPreviousPanel.Height;
    end;

  aPanel.Align := alTop;

end; {procedure, AddSearchField}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.CreateTabSheets }

procedure TppAutoSearchNotebook.CreateTabSheets;
var
  liIndex: Integer;
  lGroupTabOrder: TStringList;
  lGroup: TppAutoSearchGroup;
  lsTabOrder: String;
begin

  lGroupTabOrder := TStringList.Create;

  try

    for liIndex := 0 to FAutoSearchGroups.Count-1 do
      begin
        lGroup := FAutoSearchGroups[liIndex];
        lsTabOrder := Format('%8d', [lGroup.TabOrder]);
        lGroupTabOrder.AddObject(lsTabOrder, lGroup);
      end;

    lGroupTabOrder.Sort;

    for liIndex := 0 to FAutoSearchGroups.Count-1 do
      begin
        lGroup := TppAutoSearchGroup(lGroupTabOrder.Objects[liIndex]);
        lGroup.TabOrder := liIndex;

        CreateTabSheet(lGroup)

      end;

  finally

    lGroupTabOrder.Free;
  end;

end; {procedure, CreateTabSheets}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.CreatePageControl }

procedure TppAutoSearchNotebook.CreatePageControl;
var
  lPopupMenu: TPopupMenu;
  lMenuItem: TMenuItem;
  lBitmap: TBitmap;
  lImageList: TImageList;
begin

  if (FPageControl <> nil) then Exit;

  FPageControl := TPageControl.Create(FParent);
  FPageControl.Parent := (FParent);
  FPageControl.Align := alClient;

  if (FDesigning) then
    begin
      lPopupMenu := TPopupMenu.Create(FPageControl);
      FPageControl.PopupMenu := lPopupMenu;

     lMenuItem := TMenuItem.Create(lPopupMenu);
     lMenuItem.Caption := ppLoadStr(1025); {'Move Tab &Left'}
     lMenuItem.OnClick := MoveTabLeftClickEvent;
     lPopupMenu.Items.Add(lMenuItem);

     lMenuItem := TMenuItem.Create(lPopupMenu);
     lMenuItem.Caption := ppLoadStr(1026); {'Move Tab &Right'}
     lMenuItem.OnClick := MoveTabRightClickEvent;
     lPopupMenu.Items.Add(lMenuItem);

     lPopupMenu.OnPopup := PopupMenuPopupEvent;

     lImageList := TImageList.Create(FPageControl);
     lImageList.Height := 5;
     lImageList.Width := 5;

     lBitmap := TBitmap.Create;
     lBitmap.Handle := ppBitmapFromResource('PPERRORBULLET');
     lImageList.AddMasked(lBitmap, clWhite);
     lBitmap.Free;

     FPageControl.Images := lImageList;

  end;

end; {procedure, CreatePageControl}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.MoveTabLeftClickEvent }

procedure TppAutoSearchNotebook.MoveTabLeftClickEvent(Sender: TObject);
var
  lTabSheet: TTabSheet;
  lPrevTabSheet: TTabSheet;
begin
  lTabSheet := FPageControl.ActivePage;
  lPrevTabSheet := FPageControl.Pages[lTabSheet.PageIndex - 1];

  lTabSheet.PageIndex := lTabSheet.PageIndex - 1;

  TppAutoSearchGroup(lTabSheet.Tag).TabOrder := lTabSheet.PageIndex;
  TppAutoSearchGroup(lPrevTabSheet.Tag).TabOrder := lTabSheet.PageIndex + 1;

end; {procedure, MoveTabLeftClickEvent}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.MoveTabRightClickEvent }

procedure TppAutoSearchNotebook.MoveTabRightClickEvent(Sender: TObject);
var
  lTabSheet: TTabSheet;
  lNextTabSheet: TTabSheet;
begin
  lTabSheet := FPageControl.ActivePage;
  lNextTabSheet := FPageControl.Pages[lTabSheet.PageIndex + 1];

  lTabSheet.PageIndex := lTabSheet.PageIndex + 1;

  TppAutoSearchGroup(lTabSheet.Tag).TabOrder := lTabSheet.PageIndex;
  TppAutoSearchGroup(lNextTabSheet.Tag).TabOrder := lTabSheet.PageIndex - 1;

end; {procedure, MoveTabRightClickEvent}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.PopupMenuPopupEvent }

procedure TppAutoSearchNotebook.PopupMenuPopupEvent(Sender: TObject);
begin
  FPageControl.PopupMenu.Items[0].Enabled := (FPageControl.ActivePage.TabIndex <> 0); {TMO}
  FPageControl.PopupMenu.Items[1].Enabled := (FPageControl.ActivePage.TabIndex <> (FPageControl.PageCount - 1)); {TMO}
end; {procedure, PopupMenuPopupEvent}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.CreateTabSheet }

procedure TppAutoSearchNotebook.CreateTabSheet(aGroup: TppAutoSearchGroup);
var
  lTabSheet: TTabSheet;
  lScrollBox: TScrollBox;
begin

  lTabSheet := TTabSheet.Create(FParent);
  lTabSheet.Parent := FPageControl;
  lTabSheet.PageControl := FPageControl;
  lTabSheet.Caption := aGroup.Description;
  lTabSheet.Tag := Integer(aGroup);

  lTabSheet.ImageIndex := -1;

  lScrollBox := TScrollBox.Create(FParent);
  lScrollBox.Parent := lTabSheet;
  lScrollBox.Align := alClient;
  lScrollBox.BorderStyle := bsNone;

end; {procedure, CreateTabSheet}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.FindTabSheet }

function TppAutoSearchNotebook.FindTabSheet(const aCaption: String): TTabSheet;
var
  liIndex: Integer;
begin

  Result := nil;

  if (FPageControl = nil) then Exit;

  liIndex := 0;

  while (Result = nil) and (liIndex < FPageControl.PageCount) do
    begin

      if (CompareText(FPageControl.Pages[liIndex].Caption, aCaption) = 0) then
        Result := FPageControl.Pages[liIndex]
      else
        Inc(liIndex);
    end;

end; {procedure, FindTabSheet}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.CreateNoteBookControls }

procedure TppAutoSearchNotebook.CreateNoteBookControls;
var
  liIndex: Integer;
begin

  if (FAutoSearchGroups.Count > 1) then
    begin
      CreatePageControl;
      CreateTabSheets;
    end
  else   {if single group, then just use a single scroll box}
    begin
      FScrollBox := TScrollBox.Create(FParent);
      FScrollBox.Parent := FParent;
      FScrollBox.Align := alClient;
      FScrollBox.BorderStyle := bsNone;

    end;

  {create group controls}
  for liIndex := 0 to FAutoSearchGroups.Count - 1 do
    CreateControlsForGroup(FAutoSearchGroups[liIndex]);

end; {procedure, CreateNoteBookControls}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.CreateControlsForGroup }

procedure TppAutoSearchNotebook.CreateControlsForGroup(aAutoSearchGroup: TppAutoSearchGroup);
var
  liIndex: Integer;
  lField: TppAutoSearchField;
  lPanel: TppAutoSearchPanel;
  lScrollBox: TScrollbox;
  lTabSheet: TTabSheet;
begin

  lScrollBox := nil;
                                           
  {get scrollbox for group}
  if (FAutoSearchGroups.Count > 1) then
    begin
      lTabSheet := FindTabSheet(aAutoSearchGroup.Description);

      if (lTabSheet <> nil) then
        lScrollBox := TScrollBox(lTabSheet.Controls[0]);

    end
  else
    lScrollbox := FScrollbox;


  {create autosearch panels for each field}
  for liIndex := 0 to aAutoSearchGroup.FieldCount-1 do
    begin
      lField := aAutoSearchGroup.Fields[liIndex];

      if (lScrollBox <> nil) then
        lField.ParentControl := lScrollBox;

      {create panel for field}
      lPanel := CreatePanelForField(lField);
      lPanel.FieldGroup := aAutoSearchGroup;

      AddSearchField(lField, lPanel);

      if lField.Mandatory then
        FMandatoryFieldsExist := True;

    end;

end; {procedure, CreateControlsForGroup}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.CreatePanelForField }

function TppAutoSearchNotebook.CreatePanelForField(aField: TppAutoSearchField): TppAutoSearchPanel;
var
  lPanelClass: TppAutoSearchPanelClass;
begin

  case aField.SearchOperator of

    soInList, soNotInList:
      begin
        if (aField.HasLookupList) then
          lPanelClass := TppInListLookupListSearchPanel
        else if (aField.DataType in [dtDateTime, dtDate, dtTime]) then
           lPanelClass := TppInListDateTimeSearchPanel
        else
          lPanelClass := TppInListSearchPanel
      end;
    soBetween, soNotBetween:
      begin
        if (aField.HasLookupList) then
          lPanelClass := TppBetweenLookupListSearchPanel
        else if (aField.DataType in [dtDateTime, dtDate, dtTime]) then
           lPanelClass := TppBetweenDateTimeSearchPanel
        else
          lPanelClass := TppBetweenSearchPanel
      end;
    else
      begin
        if (aField.HasLookupList) then
           lPanelClass := TppSimpleLookupListSearchPanel
        else if (aField.DataType in [dtDateTime, dtDate, dtTime]) then
           lPanelClass := TppSimpleDateTimeSearchPanel
         else
           lPanelClass := TppSimpleSearchPanel
      end;

  end;

  if Assigned(FOnGetPanelClass) then FOnGetPanelClass(aField, lPanelClass);

  Result := lPanelClass.Create(FParent);

  aField.AutoSearchPanel := Result;

  if Assigned(FOnCreatePanel) then FOnCreatePanel(aField, Result);

end; {function, CreatePanel}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.CalcPanelDimensions}

procedure TppAutoSearchNotebook.CalcPanelDimensions(aScrollBox: TScrollBox; var aWidth, aHeight: Integer);
var
  liIndex: Integer;
  lPanel: TppAutoSearchPanel;
begin

  aWidth := 0;
  aHeight := 0;

  for liIndex := 0 to (aScrollBox.ControlCount - 1) do
    begin
      lPanel := TppAutoSearchPanel(aScrollBox.Controls[liIndex]);

      if (lPanel.CalcWidth > aWidth) then
        aWidth := lPanel.CalcWidth;

      aHeight := aHeight + lPanel.CalcHeight;
    end;

  if (FPageControl <> nil) then
    aHeight := aHeight + 28;

end; {procedure, CalcPanelDimensions}

{------------------------------------------------------------------------------}
{ TppAutoSearchNotebook.CalcDimensions}

procedure TppAutoSearchNotebook.CalcDimensions;
var
  liIndex: Integer;
  lTabSheet: TTabSheet;
  lScrollBox: TScrollBox;
  liWidth: Integer;
  liHeight: Integer;
  liMaxWidth: Integer;
  liMaxHeight: Integer;
begin

  if (FPageControl = nil) then
    CalcPanelDimensions(FScrollBox, liMaxWidth, liMaxHeight)

  else
    begin
      liMaxWidth := 0;
      liMaxHeight := 0;

      for liIndex := 0 to (FPageControl.PageCount - 1) do
        begin
          lTabSheet := FPageControl.Pages[liIndex];

          lScrollBox := TScrollBox(lTabSheet.Controls[0]);

          CalcPanelDimensions(lScrollBox, liWidth, liHeight);

          if (liWidth > liMaxWidth) then
            liMaxWidth := liWidth;

          if (liHeight > liMaxHeight) then
            liMaxHeight := liHeight;
        end;

      FPageControl.Width := liMaxWidth + 20;
      FPageControl.Height := liMaxHeight + 20;
    end;

  FWidth := liMaxWidth;
  FHeight := liMaxHeight;

end; {function, CalcDimensions}


{******************************************************************************
 *
 ** A U T O   S E A R C H   P A N E L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.Create}

constructor TppAutoSearchPanel.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  OnClick := ClickEvent;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.Destroy}

destructor TppAutoSearchPanel.Destroy;
begin

  FLogicalLabel := nil;
  FFieldAliasLabel := nil;
  FOperatorLabel := nil;
  FErrorBullet := nil;
  FErrorLabel := nil;
  FMandatoryBullet := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.ClickEvent}

procedure TppAutoSearchPanel.ClickEvent(Sender: TObject);
var
  lPoint: TPoint;
begin

  if not(FShowAllValues.Visible) or not(FShowAllValues.Checked) then Exit;

  GetCursorPos(lPoint);

  lPoint := ScreenToClient(lPoint);

  if OverEditControl(lPoint.X, lPoint.Y) then
    FShowAllValues.Checked := False;

end; {procedure, ClickEvent}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.FirstField}

function TppAutoSearchPanel.FirstField: Boolean;
begin

  Result := False;

  if (Parent = nil) then Exit;

  Result := (Self = Parent.Controls[0]);

end; {function, FirstField}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.LastField}

function TppAutoSearchPanel.LastField: Boolean;
begin

  Result := False;

  if (Parent = nil) then Exit;

  Result := (Self = Parent.Controls[Parent.ControlCount - 1]);

end; {function, LastField}


{@TppAutoSearchPanel.Init
 When this method is called, the visual controls are created and the values from
 the Field properties are transferred to the controls.}

procedure TppAutoSearchPanel.Init;
var
  lBevel: TBevel;
  lsMessage: String;

begin

  ParentFont := False;

  FShowAllValues := TCheckBox.Create(Self);
  FShowAllValues.Parent := Self;

  lsMessage := ppLoadStr(1033); {'Show all values of the <name> field.'}
  lsMessage := ppSetMessageParameters(lsMessage);
  lsMessage := Format(lsMessage, [FField.FieldAlias]);

  FShowAllValues.Caption := lsMessage;
  FShowAllValues.Left := 8;
  FShowAllValues.Top := 5;
  FShowAllValues.Width := Width;
  FShowAllValues.Visible := not(FField.Mandatory);

  if FShowAllValues.Visible then
    FShowAllValues.Checked := FField.ShowAllValues;

  FShowAllValues.OnClick := ShowAllValuesClickEvent;

  FLogicalLabel := TLabel.Create(Self);
  FLogicalLabel.Parent := Self;
  FLogicalLabel.Transparent := False;

  FField.FirstField := FirstField;

  FLogicalLabel.Caption := FField.LogicalPrefixDescr;

  FLogicalLabel.Left := 8;
  FLogicalLabel.Top := 29;

  FFieldAliasLabel := TLabel.Create(Self);
  FFieldAliasLabel.Parent := Self;
  FFieldAliasLabel.Font.Color := clBlue;
  FFieldAliasLabel.Caption := FField.FieldAlias;
  FFieldAliasLabel.Left := FLogicalLabel.Left + FLogicalLabel.Width + 5;
  FFieldAliasLabel.Top := 29;
  FFieldAliasLabel.Transparent := False;

  FOperatorLabel := TLabel.Create(Self);
  FOperatorLabel.Parent := Self;
  FOperatorLabel.Caption := FField.OperatorDesc;
  FOperatorLabel.Left := FFieldAliasLabel.Left + FFieldAliasLabel.Width + 5;
  FOperatorLabel.Top := 29;
  FOperatorLabel.transparent := False;

  FErrorBullet := TShape.Create(Self);
  FErrorBullet.Parent := Self;
  FErrorBullet.Shape := stCircle;
  FErrorBullet.Pen.Color := clRed;
  FErrorBullet.Brush.Color := clRed;
  FErrorBullet.Visible := False;
  FErrorBullet.Width := 5;
  FErrorBullet.Height := 7;

  FErrorLabel := TLabel.Create(Self);
  FErrorLabel.Parent := Self;
  FErrorLabel.Font.Color := clRed;
  FErrorLabel.Visible := False;
  FErrorLabel.Transparent := False;

  FMandatoryBullet := TShape.Create(Self);
  FMandatoryBullet.Parent := Self;
  FMandatoryBullet.Shape := stCircle;
  FMandatoryBullet.Pen.Color := clBlack;
  FMandatoryBullet.Brush.Color := clBlack;
  FMandatoryBullet.Width := 5;
  FMandatoryBullet.Height := 7;

  if (Parent <> nil) and (Parent.Parent is TTabSheet) then
    begin
      BevelOuter := bvNone;

      if not(LastField) then
        begin
          lBevel := TBevel.Create(Self);
          lBevel.Parent := Self;
          lBevel.Align := alBottom;
          lBevel.Shape := bsBottomLine;
        end;
    end;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.ShowAllValuesClickEvent}

procedure TppAutoSearchPanel.ShowAllValuesClickEvent(Sender: TObject);
begin
  Configure;
end; {procedure, ShowAllValuesClickEvent}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.Configure}

procedure TppAutoSearchPanel.Configure;
begin

  if (FShowAllValues.Visible) and (FShowAllValues.Checked) then
    DisableControls
  else
    EnableControls;

end; {procedure, Configure}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.DisableControls}

procedure TppAutoSearchPanel.DisableControls;
begin
  FLogicalLabel.Enabled := False;
  FFieldAliasLabel.Enabled := False;
  FOperatorLabel.Enabled := False;
end; {function, DisableControls}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.EnableControls}

procedure TppAutoSearchPanel.EnableControls;
begin
  FLogicalLabel.Enabled := True;
  FFieldAliasLabel.Enabled := True;
  FOperatorLabel.Enabled := True;
end; {function, EnableControls}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.CalcHeight}

function TppAutoSearchPanel.CalcHeight: Integer;
begin
  Result := Height;
end; {function, CalcHeight}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.CalcWidth}

function TppAutoSearchPanel.CalcWidth: Integer;
begin
  Result := Width;
end; {function, CalcWidth}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.GetLookupList}

function TppAutoSearchPanel.GetLookupList: TppLookupList;
begin

  if (FField <> nil) then
    Result := Field.LookupList
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.SetField}

procedure TppAutoSearchPanel.SetField(aField: TppAutoSearchField);
begin
  FField := aField;
end; {procedure, SetField}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.SetTabOrder}

procedure TppAutoSearchPanel.SetTabOrder;
begin
  {make show all values have last tab order}
  FShowAllValues.TabOrder := ControlCount-1;

end; {function, SetTabOrder}


{@TppAutoSearchPanel.Valid
 Called when the AutoSearch dialog is about to be closed.  Returns whether or
 not the search criteria entered by the user is valid.}

function TppAutoSearchPanel.Valid: Boolean;
begin
  Result := True;
end; {procedure, Valid}


{@TppAutoSearchPanel.ValidateValue
 Checks to make sure the value is compatible with the given data type.  If it is
 not, returns the appropriate error message.}

function TppAutoSearchPanel.ValidateValue(const aValue: String; aDataType: TppDataType; var aErrorMessage: String): Boolean;
var
  lsValue: String;
begin

  Result := True;

  if (Length(aValue) = 0) then Exit;
  
  case aDataType of
    dtDate:
      try
        StrToDate(aValue);
      except on EConvertError do
        begin
          Result := False;

          aErrorMessage := aValue + ' ' + ppLoadStr(56); {is not a valid date.}
        end;
      end;

    dtTime:
      try
        StrToTime(aValue);
      except on EConvertError do
        begin
          Result := False;

          aErrorMessage := aValue + ' ' + ppLoadStr(57); {is not a valid time.}
        end;
      end;

    dtDateTime:
      try
        ppStrToDateTime(aValue);
      except on EConvertError do
        begin
          Result := False;

          aErrorMessage := aValue + ' ' + ppLoadStr(58); {is not a valid datetime.}
        end;
      end;

    dtInteger, dtLongint:
      begin
        lsValue := ppRemoveCharacter(ThousandSeparator, aValue);

        try
          StrToInt(lsValue);
        except on EConvertError do
          begin
            Result := False;
            aErrorMessage := aValue + ' ' + ppLoadStr(59); {is not a valid number.}
          end;
        end;

      end;

    dtSingle, dtDouble, dtExtended, dtCurrency:
      begin
        lsValue := ppRemoveCharacter(ThousandSeparator, aValue);

        try
          StrToFloat(lsValue);
        except on EConvertError do
          begin
            Result := False;
            aErrorMessage := aValue + ' ' + ppLoadStr(59); {is not a valid number.}
          end;
        end;
      end;

    dtBoolean:
      begin
        Result := (Length(aValue) > 0) and ppCharInSet(UpperCase(aValue[1])[1], ['T', 'Y', '1', 'F', 'N', '0']);

        if not(Result) then
          aErrorMessage := ppLoadStr(60); {Value must be either True or False.}
      end;

  else
    Result := True;
  end;

end; {procedure, ValidateValue}

{------------------------------------------------------------------------------}
{ TppAutoSearchPanel.ppParseString

 Included to supply backward compatibility for custom search panels that
 were calling ppParseString in ppUtils. We want to override that call.}

procedure TppAutoSearchPanel.ppParseString(aString: String; aStrings: TStrings);
begin

  aStrings.CommaText := aString;

end;

{******************************************************************************
 *
 ** S I M P L E   S E A R C H   P A N E L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.Create}

constructor TppSimpleSearchPanel.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.Destroy}

destructor TppSimpleSearchPanel.Destroy;
begin

  FControl := nil;
  FEditControl := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.SetFocus}

procedure TppSimpleSearchPanel.SetFocus;
begin

  inherited SetFocus;

  if (FControl.Visible) and (FControl.Enabled) then
    begin
      FControl.SetFocus;
      if (FControl is TEdit) then
        TEdit(FControl).SelectAll;
    end;

end; {function, SetFocus}

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.Init}

procedure TppSimpleSearchPanel.Init;
begin

  inherited Init;

  FControl := CreateControl;
  FControl.Parent := Self;

  if (FField.ValueCount < 2) then
    SetControlText(FField.SearchExpression);

  FControl.Left := FOperatorLabel.Left + FOperatorLabel.Width + 5;
  FControl.Top := 26;
  FControl.Width := 273;

  FErrorLabel.Left := FControl.Left + 4;
  FErrorLabel.Top := 8;

  FShowAllValues.Left := FControl.Left;
  FShowAllValues.Top := FControl.Top + FControl.Height + 5;
  FShowAllValues.Width := FControl.Width;

  if (FField.SearchOperator in [soBlank, soNotBlank]) then
    begin
      FControl.Visible := False;
      FShowAllValues.Left := FFieldAliasLabel.Left;

      FOperatorLabel.Caption := FOperatorLabel.Caption + '.';

    end;

  FMandatoryBullet.Visible := Field.Mandatory;
  FMandatoryBullet.Left := FControl.Left + FControl.Width + 3;
  FMandatoryBullet.Top := FControl.Top;

  Height := 73;
  Width :=  FControl.Left + FControl.Width + 5;

  {set show all values to last tab order}
  {FShowAllValues.TabOrder := 1;}

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.OverEditControl}

function TppSimpleSearchPanel.OverEditControl(aX, aY: Integer): Boolean;
begin

  if (aX >= FControl.Left) and (aX <= (FControl.Left + FControl.Width)) and
     (aY >= FControl.Top) and (aY <= (FControl.Top + FControl.Height)) then
    Result := True
  else
    Result := False;

end; {function, OverEditControl}

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.ShowAllValuesClickEvent}

procedure TppSimpleSearchPanel.ShowAllValuesClickEvent(Sender: TObject);
begin

  inherited ShowAllValuesClickEvent(Sender);

  if (FControl.Enabled) and (FControl.Visible) then
    begin
      FControl.SetFocus;
    end;

end; {function, ShowAllValuesClickEvent}

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.DisableControls}

procedure TppSimpleSearchPanel.DisableControls;
begin

  inherited DisableControls;

  FControl.Enabled := False;

end; {function, DisableControls}

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.EnableControls}

procedure TppSimpleSearchPanel.EnableControls;
begin

  inherited EnableControls;

  FControl.Enabled := True;

end; {function, EnableControls}

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.CalcWidth}

function TppSimpleSearchPanel.CalcWidth: Integer;
begin
  if (FField.SearchOperator in [soBlank, soNotBlank]) then
    begin
      if ShowAllValues.Visible then
        Result := FShowAllValues.Left + FShowAllValues.Width + 20
      else
        Result := FOperatorLabel.Left + FOperatorLabel.Width + 20
    end
  else
    Result := FControl.Left + FControl.Width + 20;
end; {function, CalcWidth}

{------------------------------------------------------------------------------}
{ TppSimpleLookupListSearchPanel.CreateControl}

function TppSimpleSearchPanel.CreateControl: TWincontrol;
begin
  FEditControl := TEdit.Create(Self);
  FEditControl.OnKeyUp := EditControlKeyUpEvent;

  Result := FEditControl;
end;

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.EditControlKeyUpEvent}

procedure TppSimpleSearchPanel.EditControlKeyUpEvent(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
Exit;
  if FShowAllValues.Visible and not(Key = VK_TAB) then
    FShowAllValues.Checked := Length(FEditControl.Text) = 0;

end; {procedure, EditControlKeyUpEvent}

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.GetControlText}

function TppSimpleSearchPanel.GetControlText: String;
begin

  Result := FEditControl.Text;

end;

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.SetControlText}

procedure TppSimpleSearchPanel.SetControlText(const Value: String);
begin

  FEditControl.Text := Value;

end;


{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.Valid}

function TppSimpleSearchPanel.Valid: Boolean;
begin

  Result := False;

  if not(FShowAllValues.Visible) or ((FShowAllValues.Visible) and not(FShowAllValues.Checked)) then
    if not(ValidateControl(FControl)) then Exit;

  Result := True;

  FField.SearchExpression := ControlText;

  // when no SearchExpression specified, automatically set ShowAllValues to True
  if (FField.SearchExpression = '') and (FShowAllValues.Visible) then
    if not(FField.SearchOperator in [soBlank, soNotBlank]) then
      FShowAllValues.Checked := True;

  FField.ShowAllValues := (FShowAllValues.Visible) and (FShowAllValues.Checked);

end;

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.ValidateControl}

function TppSimpleSearchPanel.ValidateControl(aControl: TWinControl):
    Boolean;
var
  lsErrorMessage: String;
begin

  if FField.Mandatory and (ControlText = '') then
    begin
      Result := False;

      lsErrorMessage := ppLoadStr(61); {Search value must be entered.}
    end
  else
    Result := ValidateValue(ControlText, FField.DataType, lsErrorMessage);


  if Result then
    begin
      FErrorLabel.Visible := False;
      FErrorBullet.Visible := False;
    end

  else
    begin
      FErrorLabel.Caption := lsErrorMessage;

      FErrorBullet.Top := aControl.Top;
      FErrorBullet.Left := aControl.Left + aControl.Width + 3;

      {show error labels}
      FErrorLabel.Visible := True;

      FErrorBullet.BringToFront;
      FErrorBullet.Visible := True;
    end;


end; 

{******************************************************************************
 *
 ** B E T W E E N   S E A R C H   P A N E L 
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBetweenSearchPanel.Create}

constructor TppBetweenSearchPanel.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppBetweenSearchPanel.Destroy}

destructor TppBetweenSearchPanel.Destroy;
begin

  FControl2 := nil;;
  FAndLabel := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppBetweenSearchPanel.Init}

procedure TppBetweenSearchPanel.Init;
var
  lValues: TStrings;
begin

  inherited Init;

  FControl.Width := 150;

  FAndLabel := TLabel.Create(Self);
  FAndLabel.Parent := Self;
  FAndLabel.Caption := ppLoadStr(62); {and}
  FAndLabel.Left := FControl.Left + FControl.Width + 10;
  FAndLabel.Top := 29;

  FControl2 := CreateControl2;
  FControl2.Parent := Self;
  FControl2.Left := FAndLabel.Left + FAndLabel.Width + 10;
  FControl2.Top := 26;
  FControl2.Width := 150;

  FErrorLabel.Top := 8;

  lValues := TStringList.Create;

  lValues.CommaText := FField.SearchExpression;

  if (lValues.Count > 0) then
    SetControlText(lValues[0]);

  if (lValues.Count > 1) then
    SetControl2Text(lValues[1]);

  lValues.Free;

  FErrorBullet.Left := FControl2.Left + FControl2.Width + 5;

  FMandatoryBullet2 := TShape.Create(Self);
  FMandatoryBullet2.Parent := Self;
  FMandatoryBullet2.Shape := stCircle;
  FMandatoryBullet2.Pen.Color := clBlack;
  FMandatoryBullet2.Brush.Color := clBlack;
  FMandatoryBullet2.Width := 5;
  FMandatoryBullet2.Height := 7;

  FMandatoryBullet.Visible := Field.Mandatory;
  FMandatoryBullet.Left := FControl.Left + FControl.Width + 3;
  FMandatoryBullet.Top := Control.Top;

  FMandatoryBullet2.Visible := Field.Mandatory;
  FMandatoryBullet2.Left := FControl2.Left + FControl2.Width + 3;
  FMandatoryBullet2.Top := FControl2.Top;

  Height := 73;
  Width :=  FControl2.Left + FControl2.Width + 5;

  {set show all values to last tab order}
  {FShowAllValues.TabOrder := 2;}

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppBetweenSearchPanel.OverEditControl}

function TppBetweenSearchPanel.OverEditControl(aX, aY: Integer): Boolean;
begin

  Result := inherited OverEditControl(aX, aY);

  if Result then Exit;

  if (aX >= FControl2.Left) and (aX <= (FControl2.Left + FControl2.Width)) and
     (aY >= FControl2.Top) and (aY <= (FControl2.Top + FControl2.Height)) then
    Result := True;

end; {function, OverEditControl}

{------------------------------------------------------------------------------}
{ TppBetweenSearchPanel.DisableControls}

procedure TppBetweenSearchPanel.DisableControls;
begin

  inherited DisableControls;

  FAndLabel.Enabled := False;
  FControl2.Enabled := False;

end; {function, DisableControls}

{------------------------------------------------------------------------------}
{ TppBetweenSearchPanel.EnableControls}

procedure TppBetweenSearchPanel.EnableControls;
begin

  inherited EnableControls;

  FAndLabel.Enabled := True;
  FControl2.Enabled := True;

end; {function, EnableControls}

{------------------------------------------------------------------------------}
{ TppBetweenSearchPanel.CalcWidth}

function TppBetweenSearchPanel.CalcWidth: Integer;
begin
  Result := FControl2.Left + FControl2.Width + 20;
end; {function, CalcWidth}

{------------------------------------------------------------------------------}
{ TppSimpleLookupListSearchPanel.CreateControl}

function TppBetweenSearchPanel.CreateControl2: TWincontrol;
begin
  FEditControl2 := TEdit.Create(Self);
  Result := FEditControl2;
end;

{------------------------------------------------------------------------------}
{ TppSimpleLookupListSearchPanel.GetControlText}

function TppBetweenSearchPanel.GetControl2Text: String;
begin

  Result := FEditControl2.Text;

end;

{------------------------------------------------------------------------------}
{ TppSimpleLookupListSearchPanel.SetControlText}

procedure TppBetweenSearchPanel.SetControl2Text(const Value: String);
begin

  FEditControl2.Text := Value;

end;

{------------------------------------------------------------------------------}
{ TppBetweenSearchPanel.Valid}

function TppBetweenSearchPanel.Valid: Boolean;
var
  lValues: TStringList;
begin

  Result := True;

  FField.ShowAllValues := FShowAllValues.Visible and FShowAllValues.Checked;

  if not(FField.ShowAllValues) then
    begin

      if not(ValidateControl(FControl)) then
        begin
          FErrorLabel.Left := FControl.Left + 4;

          Result := False;
        end

      else if not(ValidateControl2(FControl2)) then
        begin
          FErrorLabel.Left := FControl2.Left + 4;

          Result := False;
        end

      else
        begin

          if (Length(ControlText) > 0) and (Length(Control2Text) > 0) then
            begin
              lValues := TStringList.Create;
              lValues.Add(ControlText);
              lValues.Add(Control2Text);
              FField.SearchExpression := lValues.CommaText;
              lValues.Free;
            end
          else
            FField.SearchExpression := '';

        end;

    end;

end; {procedure, Valid}

{------------------------------------------------------------------------------}
{ TppSimpleSearchPanel.ValidateControl2}

function TppBetweenSearchPanel.ValidateControl2(aControl: TWinControl): Boolean;
var
  lsErrorMessage: String;
begin

  if FField.Mandatory and (Control2Text = '') then
    begin
      Result := False;

      lsErrorMessage := ppLoadStr(61); {Search value must be entered.}
    end
  else
    Result := ValidateValue(Control2Text, FField.DataType, lsErrorMessage);


  if Result then
    begin
      FErrorLabel.Visible := False;
      FErrorBullet.Visible := False;
    end

  else
    begin
      FErrorLabel.Caption := lsErrorMessage;

      FErrorBullet.Top := aControl.Top;
      FErrorBullet.Left := aControl.Left + aControl.Width + 3;

      {show error labels}
      FErrorLabel.Visible := True;

      FErrorBullet.BringToFront;
      FErrorBullet.Visible := True;
    end;


end; 

{******************************************************************************
 *
 ** I N L I S T   S E A R C H   P A N E L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppInListSearchPanel.Create}

constructor TppInListSearchPanel.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppInListSearchPanel.Destroy}

destructor TppInListSearchPanel.Destroy;
begin

  FListBox := nil;
  FAddButton := nil;
  FRemoveButton := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppInListSearchPanel.Init}

procedure TppInListSearchPanel.Init;
var
  liLeft: Integer;
begin

  inherited Init;

  Control.Width := 200;
  Control.Top := 53;
  Control.Left := FLogicalLabel.Left;
  ControlText := '';

  FErrorLabel.Left := Control.Left + 4;
  FErrorLabel.Top := Control.Top + Control.Height + 4;

  FErrorBullet.Top := Control.Top;
  FErrorBullet.Left := Control.Left + Control.Width + 5;

  FOperatorLabel.Caption := FOperatorLabel.Caption + ':';

  FAddButton := TSpeedButton.Create(Self);
  FAddButton.Parent := Self;
  FAddButton.Caption := ppLoadStr(63); {Add to list}
  FAddButton.Left := Control.Left + Control.Width + 15;
  FAddButton.Top := 53;
  FAddButton.Width := 95;
  FAddButton.Height := 25;
  FAddButton.OnClick := AddButtonClickEvent;

  FRemoveButton := TSpeedButton.Create(Self);
  FRemoveButton.Parent := Self;
  FRemoveButton.Caption := ppLoadStr(64); {Remove from list}
  FRemoveButton.Left := Control.Left + Control.Width + 15;
  FRemoveButton.Top := 85;
  FRemoveButton.Width := 95;
  FRemoveButton.Height := 25;
  FRemoveButton.OnClick := RemoveButtonClickEvent;

  liLeft := FAddButton.Left + FAddButton.Width + 10;

  if (liLeft < (FOperatorLabel.Left + FOperatorLabel.Width + 10)) then
    liLeft := FOperatorLabel.Left + FOperatorLabel.Width + 10;
    
  FListBox := TListBox.Create(Self);
  FListBox.Parent := Self;
  FListBox.Left := liLeft;
  FListBox.Top := 26;
  FListBox.Width := 200;
  FListBox.Height := 131;
  FListBox.OnDblClick := ehListBox_DblClick;

  FListBox.Items.CommaText := FField.SearchExpression;

  FMandatoryBullet.Visible := Field.Mandatory;
  FMandatoryBullet.Left := FListBox.Left + FListBox.Width + 3;
  FMandatoryBullet.Top := FListBox.Top;

  Height := 183;
  Width :=  FListBox.Left + FListBox.Width + 5;

  FShowAllValues.Left := FListBox.Left;
  FShowAllValues.Top := FListBox.Top + FListBox.Height + 5;

  {set width to max of the listbox or checkbox}
  if FShowAllValues.Width < FListBox.Width then
    FShowAllValues.Width := FListBox.Width
  else
    FListBox.Width := FShowAllValues.Width;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppInListSearchPanel.OverEditControl}

function TppInListSearchPanel.OverEditControl(aX, aY: Integer): Boolean;
begin

  Result := inherited OverEditControl(aX, aY);

  if Result then Exit;

  if (aX >= FListBox.Left) and (aX <= (FListBox.Left + FListBox.Width)) and
     (aY >= FListBox.Top) and (aY <= (FListBox.Top + FListBox.Height)) then
    Result := True;

end; {function, OverEditControl}

{------------------------------------------------------------------------------}
{ TppInListSearchPanel.DisableControls}

procedure TppInListSearchPanel.DisableControls;
begin

  inherited DisableControls;

  FAddButton.Enabled := False;
  FRemoveButton.Enabled := False;
  FListBox.Enabled := False;

end; {function, DisableControls}

{------------------------------------------------------------------------------}
{ TppInListSearchPanel.EnableControls}

procedure TppInListSearchPanel.EnableControls;
begin

  inherited EnableControls;

  FAddButton.Enabled := True;
  FRemoveButton.Enabled := True;
  FListBox.Enabled := True;

end; {function, EnableControls}

{------------------------------------------------------------------------------}
{ TppInListSearchPanel.CalcWidth}

function TppInListSearchPanel.CalcWidth: Integer;
begin
  Result := FListBox.Left + FListBox.Width + 20;
end; {function, CalcWidth}

{------------------------------------------------------------------------------}
{ TppInListSearchPanel.Valid}

function TppInListSearchPanel.Valid: Boolean;
begin

  Result := False;

  if not(ValidateListBoxControl(FListBox)) then Exit;

  Result := True;

  FField.SearchExpression := FListBox.Items.CommaText;
  FField.ShowAllValues := FShowAllValues.Visible and FShowAllValues.Checked;

  if FField.Mandatory and (FField.SearchExpression = '') and not(FField.ShowAllValues) then
    Result := False;

end; {procedure, Valid}

{------------------------------------------------------------------------------}
{ TppInListSearchPanel.AddButtonClickEvent}

procedure TppInListSearchPanel.AddButtonClickEvent(Sender: TObject);
begin

  if not(ValidateControl(FControl)) then Exit;

  SelectItem(ControlText);

  FControl.SetFocus;

end; 

procedure TppInListSearchPanel.DeselectItem(aIndex: Integer);
begin

  if (aIndex = -1) then Exit;

  FListBox.Items.Delete(aIndex);

  if (aIndex >= FListBox.Items.Count) then
    FListBox.ItemIndex := FListBox.Items.Count - 1
  else
    FListBox.ItemIndex := aIndex;


end;

procedure TppInListSearchPanel.DeselectItem(aItemName: String);
var
  liIndex: Integer;
begin

  liIndex := FListBox.Items.IndexOf(aItemName);

  DeselectItem(liIndex);

end;

procedure TppInListSearchPanel.ehListBox_DblClick(Sender: TObject);
begin

  DeselectItem(FListBox.ItemIndex);

  FListBox.SetFocus;

end;

{------------------------------------------------------------------------------}
{ TppInListSearchPanel.RemoveButtonClickEvent}

procedure TppInListSearchPanel.RemoveButtonClickEvent(Sender: TObject);
begin

  DeselectItem(FListBox.ItemIndex);

  FListBox.SetFocus;

end; {procedure, RemoveButtonClickEvent}

procedure TppInListSearchPanel.SelectItem(aItemName: String);
begin

  if (Length(aItemName) > 0) and (FListBox.Items.IndexOf(aItemName) = -1) then
    FListBox.ItemIndex := FListBox.Items.Add(aItemName);

end;

{------------------------------------------------------------------------------}
{ TppInListSearchPanel.ValidateListBoxControl}

function TppInListSearchPanel.ValidateListBoxControl(aListBox: TListBox): Boolean;
var
  lsErrorMessage: String;
begin

  if FField.Mandatory and (aListBox.Items.Count = 0) then
    begin
      Result := False;

      lsErrorMessage := ppLoadStr(61); {Search value must be entered.}
    end
  else
    Result := True;


  if Result then
    begin
      FErrorLabel.Visible := False;
      FErrorBullet.Visible := False;
    end

  else
    begin
      FErrorLabel.Caption := lsErrorMessage;

      {position error labels}
      FErrorLabel.Left := aListBox.Left;
      FErrorLabel.Top := aListBox.Top + aListBox.Height + 4;

      FErrorBullet.Top := aListBox.Top;
      FErrorBullet.Left := aListBox.Left + aListBox.Width + 3;

      {show error labels}
      FErrorLabel.Visible := True;

      FErrorBullet.BringToFront;
      FErrorBullet.Visible := True;
    end;


end; {procedure, ValidateListBoxControl}

{------------------------------------------------------------------------------}
{ TppSimpleLookupListSearchPanel.CreateControl}

function TppSimpleLookupListSearchPanel.CreateControl: TWincontrol;
begin

  // create combobox
  FComboBox := TComboBox.Create(Self);
  FComboBox.Parent := Self;
  FComboBox.Style := csDropDownList;
  FComboBox.OnSelect := ehComboBox_Select;

   // initalize combobox items
  LookupList.GetDisplayNames(FComboBox.Items);

  Result := FComboBox;
  
end;

procedure TppSimpleLookupListSearchPanel.ehComboBox_Select(Sender: TObject);
begin
//  LookupList.ItemIndex := FComboBox.ItemIndex;
//  iterate over autosearchfields and rebuild the LookupList
//  iterate over autosearchfields and call Init

end;

{------------------------------------------------------------------------------}
{ TppSimpleLookupListSearchPanel.GetControlText}

function TppSimpleLookupListSearchPanel.GetControlText: String;
begin
  Result := LookupList.GetValueForIndex(FComboBox.ItemIndex);
end;

{------------------------------------------------------------------------------}
{ TppSimpleLookupListSearchPanel.SetControlText}

procedure TppSimpleLookupListSearchPanel.SetControlText(const Value: String);
begin

  FComboBox.ItemIndex := LookupList.IndexOfValue(Value);

end;

{******************************************************************************
 *
 ** B E T W E E N   L  O O K U P  L I S T  S E A R C H   P A N E L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBetweenLookupListSearchPanel.Create}

constructor TppBetweenLookupListSearchPanel.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppBetweenLookupListSearchPanel.Destroy}

destructor TppBetweenLookupListSearchPanel.Destroy;
begin

  FComboBox := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppBetweenLookupListSearchPanel.CreateControl}

function TppBetweenLookupListSearchPanel.CreateControl: TWincontrol;
begin

  // create combobox
  FComboBox := TComboBox.Create(Self);
  FComboBox.Parent := Self;
  FComboBox.Style := csDropDownList;

  // initailize combobox items
  LookupList.GetDisplayNames(FComboBox.Items);

  Result := FComboBox;
  
end;

{------------------------------------------------------------------------------}
{ TppBetweenLookupListSearchPanel.CreateControl}

function TppBetweenLookupListSearchPanel.CreateControl2: TWincontrol;
begin

  // create combobox
  FComboBox2 := TComboBox.Create(Self);
  FComboBox2.Parent := Self;
  FComboBox2.Style := csDropDownList;

  // initailize combobox items
  LookupList.GetDisplayNames(FComboBox2.Items);

  Result := FComboBox2;

end;

{------------------------------------------------------------------------------}
{ TppBetweenLookupListSearchPanel.GetControlText}

function TppBetweenLookupListSearchPanel.GetControlText: String;
begin
  Result := LookupList.GetValueForIndex(FComboBox.ItemIndex);
end;

{------------------------------------------------------------------------------}
{ TppBetweenLookupListSearchPanel.GetControlText}

function TppBetweenLookupListSearchPanel.GetControl2Text: String;
begin
  Result := LookupList.GetValueForIndex(FComboBox2.ItemIndex);
end;

{------------------------------------------------------------------------------}
{ TppBetweenLookupListSearchPanel.SetControlText}

procedure TppBetweenLookupListSearchPanel.SetControlText(const Value: String);
begin

  FComboBox.ItemIndex := LookupList.IndexOfValue(Value);

end;

{------------------------------------------------------------------------------}
{ TppBetweenLookupListSearchPanel.SetControlText}

procedure TppBetweenLookupListSearchPanel.SetControl2Text(const Value: String);
begin

  FComboBox2.ItemIndex := LookupList.IndexOfValue(Value);

end;

{******************************************************************************
 *
 ** I N L I S T   L O O K U P  L I S T  S E A R C H   P A N E L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppInListLookupListSearchPanel.Create}

constructor TppInListLookupListSearchPanel.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppInListLookupListSearchPanel.Destroy}

destructor TppInListLookupListSearchPanel.Destroy;
begin

  FComboBox := nil;

  FAvailableList.Free;
  FAvailableList := nil;

  FSearchValues.Free;
  FSearchValues := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppInListLookupListSearchPanel.AddButtonClickEvent}

procedure TppInListLookupListSearchPanel.AddButtonClickEvent(Sender: TObject);
begin

  if not(ValidateControl(FControl)) then Exit;

  SelectItem(FComboBox.Items[FComboBox.ItemIndex]);

  FComboBox.SetFocus;

end; {procedure, AddButtonClickEvent}

{------------------------------------------------------------------------------}
{ TppInListLookupListSearchPanel.CreateControl}

function TppInListLookupListSearchPanel.CreateControl: TWincontrol;
begin

  // create combobox
  FComboBox := TComboBox.Create(Self);
  FComboBox.Parent := Self;
  FComboBox.Style := csDropDownList;

  // initialize combobox items
  LookupList.GetDisplayNames(FComboBox.Items);

  Result := FComboBox;
end;

procedure TppInListLookupListSearchPanel.DeselectItem(aIndex: Integer);
var
  liIndex: Integer;
  lsItemName: String;
begin

  if aIndex < 0 then Exit;

  lsItemName := FListBox.Items[aIndex];

  // add item from lookup list, back to the available list)
  liIndex := LookupList.IndexOfDisplayName(lsItemName);

  FAvailableList.Add(LookupList[liIndex]);

  // add item from available back to combobox
  liIndex := FAvailableList.IndexOfDisplayName(lsItemName);

  FComboBox.Items.Insert(liIndex, lsItemName);
  FComboBox.ItemIndex := liIndex;

  // delete from list box
  FListBox.Items.Delete(aIndex);

  // delete from search valuess
  FSearchValues.Delete(aIndex);

  if (aIndex >= FListBox.Items.Count) then
    FListBox.ItemIndex := FListBox.Items.Count - 1
  else
    FListBox.ItemIndex := aIndex;

end;

{------------------------------------------------------------------------------}
{ TppInListLookupListSearchPanel.GetControlText}

function TppInListLookupListSearchPanel.GetControlText: String;
begin
  Result := LookupList.GetValueForIndex(ComboBox.ItemIndex);
end;

{------------------------------------------------------------------------------}
{ TppInListLookupListSearchPanel.Init}

procedure TppInListLookupListSearchPanel.Init;
var
  liIndex: Integer;
  lsDisplayName: String;
  lValues: TStringList;
begin

  inherited Init;

  // initialize available items list
  FAvailableList := TppLookupList.Create;
  FAvailableList.Assign(LookupList);

  // search values is updated by SelectItem, DeslectItem
  FSearchValues := TStringList.Create;


  // initialize the availble list and the selected list by parsing the
  // autosearch field search expression and selecting each item
  lValues := TStringList.Create;

  try

    lValues.CommaText := FField.SearchExpression;

    ListBox.Items.Clear;
  
    for liIndex := 0 to lValues.Count - 1 do
      begin
        lsDisplayName := LookupList.GetDisplayNameForValue(lValues[liIndex]);

        if (lsDisplayName <> '') then
          SelectItem(lsDisplayName);

      end;
  finally
     lValues.Free;
  end;

  if FComboBox.Items.Count > 0 then
    FComboBox.ItemIndex := 0;

end; {procedure, Init}

procedure TppInListLookupListSearchPanel.SelectItem(aItemName: String);
var
  liIndex: Integer;
begin

  liIndex := FComboBox.Items.IndexOf(aItemName);

  if (liIndex = -1) then Exit;
  

  // add item to list box
  if (Length(aItemName) > 0) and (FListBox.Items.IndexOf(aItemName) = -1) then
    FListBox.ItemIndex := FListBox.Items.Add(aItemName);

  FSearchValues.Add(FAvailableList.GetValueForDisplayName(aItemName));

  // remove item from available
  FAvailableList.Delete(liIndex);
  FComboBox.Items.Delete(liIndex);

  if liIndex <= FComboBox.Items.Count-1 then
    FComboBox.ItemIndex := liIndex
  else
    FComboBox.ItemIndex := FComboBox.Items.Count-1


end;

{------------------------------------------------------------------------------}
{ TppInListLookupListSearchPanel.SetControlText}

procedure TppInListLookupListSearchPanel.SetControlText(const Value: String);
begin

  ComboBox.ItemIndex := LookupList.IndexOfValue(Value);

end;

{------------------------------------------------------------------------------}
{ TppInListLookupListSearchPanel.Valid}

function TppInListLookupListSearchPanel.Valid: Boolean;
begin

  Result := False;

  if not(ValidateListBoxControl(FListBox)) then Exit;

  Result := True;

  FField.SearchExpression := FSearchValues.CommaText;
  FField.ShowAllValues := FShowAllValues.Visible and FShowAllValues.Checked;

  if FField.Mandatory and (FField.SearchExpression = '') and not(FField.ShowAllValues) then
    Result := False;

end; {procedure, Valid}


{******************************************************************************
 *
 ** S i m p l e   D a t e   T i m e   S e a r c h   P a n e l
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSimpleDateTimeSearchPanel.CreateControl}

function TppSimpleDateTimeSearchPanel.CreateControl: TWincontrol;
begin

  FDateTimeControl := TppDateTimeSearchControl.Create(Self);
  FDateTimeControl.Parent := Self;

  FDateTimeControl.Initialize(Field, 0);

  Result := FDateTimeControl;

end;

{------------------------------------------------------------------------------}
{ TppSimpleDateTimeSearchPanel.GetControlText}

function TppSimpleDateTimeSearchPanel.GetControlText: String;
begin

  Result := FDateTimeControl.ControlText;

end;

{------------------------------------------------------------------------------}
{ TppSimpleDateTimeSearchPanel.SetControlText}

procedure TppSimpleDateTimeSearchPanel.SetControlText(const Value: String);
begin

  // do nothing, see FDateTimeControl.Initialize(Field)

end;

{******************************************************************************
 *
 ** B E T W E E N   D A T E   T I M E  S E A R C H   P A N E L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBetweenDateTimeSearchPanel.Create}

constructor TppBetweenDateTimeSearchPanel.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppBetweenDateTimeSearchPanel.Destroy}

destructor TppBetweenDateTimeSearchPanel.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppBetweenDateTimeSearchPanel.CreateControl}

function TppBetweenDateTimeSearchPanel.CreateControl: TWincontrol;
begin

  // create DateTimeControl
  FDateTimeControl := TppDateTimeSearchControl.Create(Self);
  FDateTimeControl.Parent := Self;

  FDateTimeControl.Initialize(Field, 0);

  Result := FDateTimeControl;

end;

{------------------------------------------------------------------------------}
{ TppBetweenDateTimeSearchPanel.CreateControl}

function TppBetweenDateTimeSearchPanel.CreateControl2: TWincontrol;
begin

  // create DateTimeControl
  FDateTimeControl2 := TppDateTimeSearchControl.Create(Self);
  FDateTimeControl2.Parent := Self;

  FDateTimeControl2.Initialize(Field, 1);

  Result := FDateTimeControl2;

end;

{------------------------------------------------------------------------------}
{ TppBetweenDateTimeSearchPanel.GetControlText}

function TppBetweenDateTimeSearchPanel.GetControlText: String;
begin
  Result := FDateTimeControl.ControlText;
end;

{------------------------------------------------------------------------------}
{ TppBetweenDateTimeSearchPanel.GetControlText}

function TppBetweenDateTimeSearchPanel.GetControl2Text: String;
begin
  Result := FDateTimeControl2.ControlText;
end;

{------------------------------------------------------------------------------}
{ TppBetweenSearchPanel.Init}

procedure TppBetweenDateTimeSearchPanel.Init;
begin

  inherited Init;

  if Field.DataType = dtDateTime then
    begin
      FControl.Width := 200;
      FAndLabel.Left := FControl.Left + FControl.Width + 10;
      FControl2.Left := FAndLabel.Left + FAndLabel.Width + 10;
      FControl2.Width := 200;
    end;

  FErrorBullet.Left := FControl2.Left + FControl2.Width + 5;
  FMandatoryBullet2.Left := FControl2.Left + FControl2.Width + 3;
  FMandatoryBullet.Left := FControl.Left + FControl.Width + 3;

  Width :=  FControl2.Left + FControl2.Width + 5;

  {set show all values to last tab order}
  {FShowAllValues.TabOrder := 2;}

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppBetweenDateTimeSearchPanel.SetControlText}

procedure TppBetweenDateTimeSearchPanel.SetControlText(const Value: String);
begin

  // do nothing, see FDateTimeControl.Initialize(Field)

end;

{------------------------------------------------------------------------------}
{ TppBetweenDateTimeSearchPanel.SetControlText}

procedure TppBetweenDateTimeSearchPanel.SetControl2Text(const Value: String);
begin

  // do nothing, see FDateTimeControl2.Initialize(Field)

end;

{******************************************************************************
 *
 ** I N L I S T   D A T E T I M E  L I S T  S E A R C H   P A N E L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppInListDateTimeSearchPanel.Create}

constructor TppInListDateTimeSearchPanel.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppInListDateTimeSearchPanel.Destroy}

destructor TppInListDateTimeSearchPanel.Destroy;
begin

  FDateTimeControl := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppInListDateTimeSearchPanel.CreateControl}

function TppInListDateTimeSearchPanel.CreateControl: TWincontrol;
begin

  // create DateTimeControl
  FDateTimeControl := TppDateTimeSearchControl.Create(Self);
  FDateTimeControl.Parent := Self;

  FDateTimeControl.Initialize(Field, 0);

  Result := FDateTimeControl;

end;

{------------------------------------------------------------------------------}
{ TppInListDateTimeSearchPanel.GetControlText}

function TppInListDateTimeSearchPanel.GetControlText: String;
begin
  Result := FDateTimeControl.ControlText;
end;

{------------------------------------------------------------------------------}
{ TppInListDateTimeSearchPanel.SetControlText}

procedure TppInListDateTimeSearchPanel.SetControlText(const Value: String);
begin

  // do nothing, see FDateTimeControl.Initialize(Field)

end;

{******************************************************************************
 *
 **  A U T O S E A R C H   D A T E T I M E   P I C K E R
 *
{******************************************************************************}

function GetEmptyDateTimeFormat: String;
begin

  if (Win32MajorVersion > 6) or ( (Win32MajorVersion = 6) and (Win32MinorVersion >= 1)) then
    Result := ' '  // Win7 and later
  else
    Result := 'gg';  // work around for older Windows versions

end;

procedure TppAutoSearchDateTimePicker.DateChangeEvent(Sender: TObject);
begin
  if (Format = GetEmptyDateTimeFormat()) then
    Format := GetFormat;

end;

function TppAutoSearchDateTimePicker.GetDateTimeString: string;
var
  lsFormat: String;
begin

  if (Format = GetEmptyDateTimeFormat()) then
    Result := ''
  else
    begin
      if Kind = dtkDate then
        lsFormat := ShortDateFormat
      else
        lsFormat := LongTimeFormat;

        Result := FormatDateTime(lsFormat, DateTime);
    end;

end;

function TppAutoSearchDateTimePicker.GetFormat: String;
var
  lsFormat: String;
begin

  if Kind = dtkDate then
    lsFormat := ShortDateFormat
  else
    lsFormat := LongTimeFormat;

  // make sure format is compatible with windows
  lsFormat := StringReplace(lsFormat, 'AMPM', 'tt', []);

  // when 'tt' is absent, must use HH for 24 hour time
  if (Pos('tt', lsFormat) = 0) then
    lsFormat := StringReplace(lsFormat, 'h', 'H', [rfReplaceAll]);

  // for windows MM is month, mm is minutes
  lsFormat := StringReplace(lsFormat, 'mm/', 'MM/', []);
  lsFormat := StringReplace(lsFormat, 'mm-', 'MM-', []);
  lsFormat := StringReplace(lsFormat, 'm/', 'M/', []);
  lsFormat := StringReplace(lsFormat, 'm/', 'M-', []);
  lsFormat := StringReplace(lsFormat, 'yyyymm', 'yyyyMM', [rfIgnoreCase]);
  lsFormat := StringReplace(lsFormat, 'yyyym', 'yyyyM', [rfIgnoreCase]);

  Result := lsFormat;

end;

procedure TppAutoSearchDateTimePicker.Initialize(aField: TppAutoSearchField; aValueIndex: Integer = 0; aKind: TDateTimeKind = dtkDate);
begin

  FField := aField;
  Kind := aKind;

  // initialize DateTime
  if (aField.SearchExpression <> '') then
    DateTime := aField.Values[aValueIndex]
  else
    DateTime := SysUtils.Date;

  if Kind = dtkDate then
    begin
      ShowTodayCircle := False;
      ShowToday := False;
    end;

  // configure format, use 'gg' to show blank
  if (aField.SearchExpression = '') then
    Format := GetEmptyDateTimeFormat()
  else if (Kind = dtkTime) and (Frac(DateTime) = 0) then
    Format := GetEmptyDateTimeFormat()
  else
    Format := GetFormat;

  if (Format = GetEmptyDateTimeFormat()) then
    begin
      OnChange := DateChangeEvent;
      OnEnter := DateChangeEvent;
    end;

end;

procedure TppAutoSearchDateTimePicker.SetDateTimeString(const Value: string);
begin

  if (Value <> '') then
    DateTime := ppStrToDateTime(Value);

end;

{******************************************************************************
 *
 **  D A T E T I M E   S E A R C H   C O N T R O L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDateTimeSearchControl.Initialize}

procedure TppDateTimeSearchControl.Initialize(aField: TppAutoSearchField; aValueIndex: Integer = 0);
begin

  Height := 22;
  Width := 273;

  Field := aField;

  // create DatePicker
  FDatePicker := TppAutoSearchDateTimePicker.Create(Self);
  FDatePicker.Parent := Self;
  FDatePicker.Initialize(Field, aValueIndex, dtkDate);

  // create TimePicker
  FTimePicker := TppAutoSearchDateTimePicker.Create(Self);
  FTimePicker.Parent := Self;
  FTimePicker.Initialize(Field, aValueIndex, dtkTime);

  FTimePicker.Top := FDatePicker.Top;
  FTimePicker.Left := FDatePicker.Left;
  FTimePicker.Width := FDatePicker.Width;

  case Field.DataType of
    dtDate:
      FTimePicker.Visible := False;
    dtTime:
      FDatePicker.Visible := False;
    dtDateTime:
      begin
        FDatePicker.Width := 125;
        FTimePicker.Width := 125;
        FTimePicker.Left := FDatePicker.Left + FDatePicker.Width + 10;
        Width := FTimePicker.Left + FTimePicker.Width;
      end;

  end;


end; {procedure, Initialize}

{------------------------------------------------------------------------------}
{ TppDateTimeSearchControl.GetControlText}

function TppDateTimeSearchControl.GetControlText: String;
begin

  case Field.DataType of
    dtDate:
      Result := FDatePicker.DateTimeString;
    dtTime:
      Result := FTimePicker.DateTimeString;
    dtDateTime:
      begin
        Result := FDatePicker.DateTimeString;
        if (FTimePicker.DateTimeString <> '') then
          Result := Result + ' ' + FTimePicker.DateTimeString;
      end;

  end;

end;

{------------------------------------------------------------------------------}
{ TppDateTimeSearchControl.SetBounds}

procedure TppDateTimeSearchControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  liChange: Integer;
begin

  // shrink DatePicker and TimePicker width as needed
  if (aWidth <> Width) and (aWidth <> 273) then
    begin

      if (FDatePicker.Visible) and (FTimePicker.Visible) then
        begin
          liChange := ((TimePicker.Left + TimePicker.Width) - aWidth) div 2;
          FDatePicker.Width := FDatePicker.Width - liChange;
          FTimePicker.Left := FDatePicker.Left + FDatePicker.Width + 4;
          FTimePicker.Width := FTimePicker.Width - liChange;
        end
      else if (FDatePicker.Visible) then
        begin
          if FDatePicker.Width >= aWidth then
            FDatePicker.Width := aWidth;
        end
      else
        begin
          if FTimePicker.Width >= aWidth then
            FTimePicker.Width := aWidth;
        end

    end;

  inherited SetBounds(aLeft, aTop, aWidth, aHeight);

end;



end.
