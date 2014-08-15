{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit ppEndUsr;

interface

{$I ppIfDef.pas}

uses
  Classes,
  Controls,
  SysUtils,
  Forms,
  Graphics,
  Menus,
  Messages,
  Tabs,

  ppTypes,
  ppComm,
  ppClass,
  ppReport,
  ppTmplat,
  ppViewr,
  ppIniStorage,
  ppDsgnDB,
  ppDsIntf,
  ppWizard,
  ppTabbedNoteBook,
  ppDesignEventHub,
  ppDsgner,
  ppToolbarTBX;

type


  {@TppDesigner

    The designer is a non-visual component that installs onto Delphi's
    component palette.  This component is used to display and control the
    end-user designer at run-time.  Many of the designer's properties and
    events are identical to those found in Delphi's TForm object.

    Set the Caption and Icon properties to customize the appearance of the
    window icon and caption displayed in the upper left corner of the
    designer. Use the MergeMenu property to override default sub-menus such
    as the File and Help sub-menus. If you want to add, delete, or modify
    the report designer's menu items use the Menu property.

    Use the Show, ShowModal, and ShowInPanel methods to display the designer
    window.

    Set the TabsVisible property to True to display the design and preview 
    tabs. When set to False only the design page will be shown.

    Use the Notebook and TabSet properties to access the Notebook and
    TabSet controls of the Designer. 

    Use the OnCreateComponent event to assign default property values to 
    report components created by the end-user.

    You can specify longer, more readable data field names for the end-user
    by setting the FieldAliases property and then translate the 
    FieldAliases to their underlying DataField, DataPipeline values by
    coding event handlers for the OnAssignField, OnGetAliasForField and 
    OnGetFieldForAlias events.

    If you want to specify custom display formats, use the
    OnGetDisplayFormats event handler.}

  {@TppDesigner.AllowDataSettingsChange

    This property determines whether the 'Data Settings...' menu option is
    available from File menu of the Report Designer's Data tab.  Setting
    this property to True will allow the end-user to change the
    DatabaseName used by the Query Wizard.  The Data Settings dialog
    provides a means to set all of the properties the DataSettings object.}

  {@TppDesigner.AllowSaveToFile

    Determines whether the Save to File and Load from File menu options
    appear on the Report Designer File menu.}

  {@TppDesigner.Caption

    The Caption property is the text that appears in the upper left corner 
    of the designer window.}

  {@TppDesigner.CurrentReport

    Run-time and read-only. Use the CurrentReport property to access the
    current report being designed by the end-user. The CurrentReport may be
    the main report or a subreport. When a report contains subreports there
    are separate tabs in the report designer used to access the design
    layout of the main report and each of the subreports. Thus the value of
    the CurrentReport property changes as the user accesses each tab.

    Note: The Report property always returns the "main" report being
    designed and never a subreport.}

  {@TppDesigner.DataSettings

    This property allows you to configure the settings to be used by the Query Wizard when it is invoked within the Report Designer.

    <Table>
    Value               Meaning
    --------------      --------------
    AllowEditSQL        Whether or not the end-user can edit the SQL created by
                        the Query Wizard.
    DatabaseName        The name of the database from which data will be
                        retrieved when the query executes.
    DatabaseType        The type of database being accessed.  This setting is
                        used by the Query Designer and Query Wizard in order to
                        customize the generated SQL.
    DataDictionary      The data dictionary object which will convert raw table
                        and field names to aliases.
    SessionType         Defaults to BDESession.  Should only be changed if you have
                        created your own Session class in order to use the Query
                        Wizard with a proprietary database engine.
    SQLType             Defaults to sqBDELocal.  If you are not using dBase or
                        Paradox tables then you should set this property to
                        sqSQL1, as the Local SQL dialect is not supported by
                        most other database types. If your database supports
                        ANSI-92 SQL then you can set this property to sqSQL2
                        instead of sqSQL1.
    UseDataDictionary   Determines whether the data dictionary object assigned
                        to the DataDicitionary property will be used.
    </Table>

    Note: If you are having difficulty getting the Data tab to appear in the
          Report Designer, then see Controlling the End-User Application.}


  {@TppDesigner.EnableHelp

    This property controls whether or not the Report Designer will invoke
    Help when the menu item is selected or the F1 key is pressed.

    Use the HelpFile property to specify the name of the Help File.

    Use the OnHelp event to perform special processing when the user
    requests help.

    Add WinHelpViewer or HtmlHelpViewer to the uses of your project to include
    VCL WinHelp or HtmlHelp support.}

  {@TppDesigner.FieldAliases

    Retained for backward compatibility. For new applications use the
    DataDictionary component.

    The FieldAliases property can be set at run-time to provide a list of
    longer, more readable data field names. You must then enable the Report
    Designer to translate the field aliases into their underlying
    DataField, DataPipeline values by coding an event handler for the
    OnGetFieldForAlias event.

    When using field aliases, you must also code event-handlers for the
    OnAssignField and OnGetAliasForFieldName events.}

  {@TppDesigner.FormStyle

    Run-time only. The FormStyle describes the style of the form. The possible
    values are

    <Table>
    Value	        Meaning
    ----------    --------
    fsNormal	    The form is neither an MDI parent window nor an MDI child window
    fsMDIChild	  The form is an MDI child window.
    fsMDIForm	    The form is an MDI parent window.
    fsStayOnTop	  This form remains on top of the desktop and of other forms in
                  the project.
    </Table>

  {@TppDesigner.HelpFile

    Use this property when you want to supply your own help file with the
    end-user reporting solution. When the user select the Help menu item or
    presses F1 in the Report Designer, this property determines the help file
    which will be opened by WinHelp. HelpFile can contain either a file name or
    a full path and file name.}

  {@TppDesigner.Icon

    The Icon property is the graphical icon that appears in the upper left
    corner of the designer window.}

  {@TppDesigner.IniStorageName

    The file name or registry key within which all user preferences are
    stored. Whether preferences are registry or file-based is controlled by
    the IniStorageType property. The default value is
    ($LocalAppData)\\RBuilder\\RBuilder.ini. The ($LocalAppData) is
    is a file path variable, the following file path variables are supported.

    <Table>
    Value              Meaning
    ---------------    ------------
    ($LocalAppData)    User's local app data
    ($CommonAppData)   All User's app data
    ($Application)     Application directory
    ($WinSys)          Windows System directory
    </Table>

    }

  {@TppDesigner.IniStorageType

    Controls the location where user preferences are stored. There are two
    predefined storage types: Registry and IniFile. The default value is
    IniFile. The registry key or file name is specified by IniStorageName.

    <Table>
    Value	          Meaning
    ---------       -----------------
    IniFile	        Stores user preferences to the .ini file specified by
                    the IniStorageName property. If no path is specified,
                    the .ini file will be located in the user's local app data
                    folder.
    IniNone         No preferences are stored.
    Registry	      Stores user preferences to the windows registry under
                    the key HKEY_CURRENT_USER.
    </Table>

    Additional storage type plug-ins may be defined and registered for use
    within ReportBuilder. TppIniStorage is the ancestor class for all
    IniStorageTypes. Please see ..\\RBuilder\\Source\\ppIniStorage.pas for
    detailed information.}

  {@TppDesigner.Menu

    Run-time and read-only. The Menu property gives you access to the menu
    items of the report designer. You can use the Menu property to add,
    delete, and modify the menu items of the report designer
    programatically at run-time.

    Note: When using the designer as an MDI child window, the MergeMenu
    will not work because of the way in which Delphi merges MDI child
    menu's with the MDI parent form.  Therefore you must write the code to
    do the merging using the Menu property to access the designer's menu
    items. An example can be found in MDIForm unit of the MDI project
    located in the RBuilder\\Demos\\EndUser directory.}

  {@TppDesigner.MergeMenu

    The MergeMenu is a standard Delphi menu. It is used to override the
    default sub-menus of the designer window, typically the File and Help
    sub-menus.

    This menu gets merged into the designer's menu at run-time. Each sub-
    menu of the designer's main menu has a unqiue GroupIndex property
    value. You can override any sub-menu by creating a custom sub-menu with
    the same GroupIndex value. You can add new sub menus by assigning a
    unique GroupIndex value.

    Note: 	When using the designer as an MDI child window, the
    MergeMenu will not work because of the way in which Delphi merges MDI
    child menu's with the MDI parent form.  Therefore you must write the
    code to do the merging using the Menu property to access the designer's
    menu items. An example can be found in MDIForm unit of the MDI project 
    located in the RBuilder\\Demos\\EndUser directory.

    <Table>
    GroupIndex	SubMenu
    ----------  --------
            10	File
            20	Edit
            30	View
            40	Report
            50	Help
    </Table>}

  {@TppDesigner.Notebook

    Run-time and read-only. Use the Notebook property to access and control
    the designer's notebook control. The Notebook contains a Design page
    and a Preview page used by the end-user to design and preview reports.}

  {@TppDesigner.OnActivate

    The OnActivate event for a form occurs when the form becomes active. A
    form becomes active when focus is transferred to it (when the user
    clicks on the form, for example).

    Note: The OnActivate event of the application (TApplication), not the
    form, occurs when Windows switches control from another application to
    your application.}

  {@TppDesigner.OnAssignField

    The OnAssignField event for the designer fires after the DataPipeline
    and DataField properties of a data-aware control have been assigned.
    The Sender is the data-aware component.  This event can be used to
    perform any further initialization required after a field has been
    assigned.

    Note: This event fires only after the user has selected a field for a
    report component. This differs from the OnGetAliasForField event, which
    also fires when the Groups dialog is accessed.}

  {@TppDesigner.OnClose

    The OnClose event specifies which event handler to call when a designer is
    about to close. A form is closed by the Close method or when the user
    chooses Close from the form's system menu.

    The TCloseEvent type points to a method that handles the closing of a form.
    The value of the Action parameter determines if the form actually closes.
    These are the possible values of Action::

    <Table>
    Value	      Meaning
    -------     -------
    caNone	    The form is not allowed to close, so nothing happens.
    caHide	    The form is not closed, but just hidden. Your application can
                still access a hidden form.
    caFree	    The form is closed and all allocated memory for the form is
                freed.
    caMinimize	The form is minimized, rather than closed. This is the default
                action for MDI child forms.
    </Table>

    To close a form and free it in an OnClose event, set Action to caFree. The
    default is caHide.}

  {@TppDesigner.OnCloseQuery

    The OnCloseQuery event occurs when an action to close the form takes
    place--that is, when the Close method is called or when the user
    chooses Close from the form's System menu. An OnCloseQuery event
    handler contains a Boolean CanClose variable that determines whether a
    form is allowed to close. It's default value is True.

    You can use an OnCloseQuery event handler to ask users if they are sure
    they really want the form closed immediately. For example, you can use
    the handler to display a message box that prompts the user to save a 
    file before closing the form.

    The TCloseQueryEvent type points to the method that determines whether
    a form can be closed. The value of the CanClose parameter determines if
    the form can close or not.}

  {@TppDesigner.OnCreate

    The OnCreate event specifies which event handler to call when the
    designer is first created. You can write code in the event handler that
    sets initial values for properties and does any processing you want to
    occur before the user begins interacting with the designer.
    When a form is being created and its Visible property is True, the
    following events occur in the order listed:

            OnCreate
            OnShow
            OnActivate
            OnPaint}

  {@TppDesigner.OnCreateComponent

    The OnCreateComponent event occurs whenever a new component is created
    by the end-user in the Designer.

    You can use the OnCreateComponent to assign default property values for
    components the user creates.}

  {@TppDesigner.OnCreateReport

    Fires when a new report is created.}

  {@TppDesigner.OnCustomOpenDoc

    Provides full control over the report loading process.  When this event
    handler is assigned, you must provide the logic which will load the report.}

  {@TppDesigner.OnCustomSaveDoc

    Provides full control over the report saving process.  When this event
    handler is assigned, you must provide the logic which will save the report.}

  {@TppDesigner.OnDeactivate

    The OnDeactivate event for a form occurs when the form becomes inactive. A
    form becomes inactive when focus is transferred to another window.

    Note: The OnDeactivate event of the application (TApplication), not the
    form, occurs when Windows switches control from your application to another
    application.}

  {@TppDesigner.OnDestroy

    The OnDestroy event occurs when the designer is about to be destroyed. A
    form is destroyed by the Destroy, Free, or Release methods, or when the main
    form of the application is closed.}

  {@TppDesigner.OnDestroyComponent

    Fires when a component is freed.}

  {@TppDesigner.OnGetAliasForField

    Retained for backward compatibility. For new applications use the
    DataDictionary component.

    The OnGetAliasForField event is used to tell the designer which FieldAlias
    to display for a given DataPipeline and DataField. It is used in conjunction
    with the FieldAliases property.

    The designer fires OnGetAliasForField each time the end-user selects a
    data-aware report component. The FieldAlias which is returned is used to
    select the correct list item in the Data Fields combo-box of the Format
    Bar.}

  {@TppDesigner.OnGetDataNames

    Called whenever a list of names is needed (usually when populating the data
    pipeline drop-down list box or data pipeline list in the Report Wizard.)
    You can use this list to control the data pipeline names which are presented
    to the user.

    If you simply want to hide a data pipeline from the user, set the Visible
    property of the data pipeline.}

  {@TppDesigner.OnGetDisplayFormats

    The OnGetDisplayFormats event is used to tell the designer which display
    formats are valid for a given text based report component. A standard set of
    display formats are displayed by default. You can specify your own custom
    display formats in the event handler code for this event.

    The Sender is the report component. The event handler code must assign
    DisplayFormats to return to the designer.}

  {@TppDesigner.OnGetFieldForAlias

    Retained for backward compatibility. For new applications use the
    DataDictionary component.

    The OnGetFieldForAlias event is used to tell the designer which DataPipeline
    and DataField correspond to a given field alias. It is used in conjunction
    with the FieldAliases property.

    The designer fires OnGetFieldForAlias each time the end-user selects a
    datafield for a data-aware report component.  The DataPipeline and DataField
    returned are assigned to the component.}

  {@TppDesigner.OnGetFields

    This event fires whenever a list of fields is retrieved for a given data
    pipeline.  You can use this event to control which fields appear to the
    user - though this more easily done using the Data Dictionary component.}

  {@TppDesigner.OnHelp

    Write an OnHelp event handler to perform special processing when the user
    requests help. The OnHelp event is triggered when the user makes a selection
    and clicks 'F1' or access the Help | Help Topics menu option.

    The aHelpFile parameter can take a file name or full path and file
    name.  If the aCallHelp parameter is set to False, WinHelp will not be
    called.

    See also: HelpFile, EnableHelp}

  {@TppDesigner.OnHide

    The OnHide event occurs just before the form is hidden on the screen. Use
    the OnHide event to specify any special processing you want to happen just
    before the form disappears.}

  {@TppDesigner.OnReportSelected

    The OnReportSelected event occurs whenever a new report or subreport is
    selected as the CurrentReport in the Designer.

    In the Report Notebook of the End-User Framework (see rpNoteBk.pas in the
    EndUser.dpr demo project) the OnReportSelected event is used to assign
    DataView event-handler's to the Designer's OnGetFieldForAlias,
    OnGetAliasForField events and to assign the DataView's FieldAliases list to
    the Designer's FieldAliases property.}

  {@TppDesigner.OnResize

    The OnResize event occurs whenever the form is resized while an application
    is running. Use the OnResize event handler when you want something to happen
    in your application when the form is resized.}

  {@TppDesigner.OnSelectionChanged

    The OnSelection event occurs whenever the selection changes. Normally the
    end-user controls which items are selected by clicking on them with the
    mouse. The selection can also change if your application issues a
    SetSelection command.

    Use the OnSelectionChanged event handler to specify any special processing
    you want to occur when the selection changes.

    Note: TComponentList is a special kind of TList.  It is described in the
    Delphi help and in Delphi's DsgnIntf unit.}

  {@TppDesigner.OnShow

    The OnShow event occurs just before a form becomes visible. Use the OnShow
    event to specify any special processing you want to happen before the form
    appears.}

  {@TppDesigner.OnTabChange

    The OnTabChange event occurs just before a new tab is selected. To prevent
    the Tab from changing, you can set AllowChange parameter to False.}

  {@TppDesigner.OnTabChanged

    The OnTabChanged event occurs just after a new tab is selected.}

  {@TppDesigner.OnValidateComponent

The OnValidateComponent event fires whenever a new component is created by the end-
user in the Designer. Returning false in the Valid parameter causes the component to be 
freed.  This is useful when you want the user to configure the component a certain way.  
If the component is not configured properly you can disallow its creation.  User 
configuration is usually provided via a custom dialog displayed in response to the 
OnCreateComponent event.}

  {@TppDesigner.Position

    The Position property determines the size and placement of the designer
    window when it appears in your application. These are the possible values:

    <Table>
    Value	              Meaning
    --------------      ---------
    poDesigned	        The form appears positioned on the screen and with the
                        same height and width as it had at design time.
    poDefault	          The form appears in a position on the screen and with a
                        height and width determined by Windows. Each time you
                        run the application, the form moves slightly down and to
                        the right. The right side of the form is always near the
                        far right side of the screen, and the bottom of the form
                        is always near the bottom of the screen, regardless of
                        the screen's resolution.
    poDefaultPosOnly	   The form displays with the size you created it at design
                        time, but Windows chooses its position on the screen.
                        Each time you run the application, the form moves
                        slightly down and to the right. When the form can no
                        longer move down and to the right and keep the same size
                        while remaining entirely visible on the screen, the form
                        displays at the top-left corner of the screen
    poDefaultSizeOnly	  The form appears in the position you left it at design
                        time, but Windows chooses its size. The right side of
                        the form is always near the far right side of the
                        screen, and the bottom of the form is always near the
                        bottom of thescreen, regardless of the screen's
                        resolution.
    poScreenCenter	    The form remains the size you left it at design time,
                        but is positioned in the center of the screen.
    </Table>

    The default value is poDesigned.}

  {@TppDesigner.RAPInterface

    This property allows you to control the user interface for RAP.  These are
    the values which can make up the set:

    <Table>
    Value	           Meaning
    -------------    ---------
    riDialog 	       Enables the Calculations dialog accessible from the
                     Calculations... speed menu option a TppVariable component.
    riNotebookTab    Enables the Calc tab within the Report Designer.
    </Table>

    Note: If you are having difficulty getting the Calc tab to appear in the
    Report Designer, then see Controlling the End-User Application.}

  {@TppDesigner.RAPOptions

    Controls the make-up of the RAP interface when RAPInterfaceOptions contains
    riNotebook. These are the values which can make up the set:

    <Table>
    Value	              Meaning
    ----------------    ---------
    roViewVariables	    Calc tab is visible in the Report Designer. When clicked
                        shows a list of bands with variables for each band.
                        Variable calc routines can be viewed but not modified.
    roEditVariables	    When ViewVariables is selected, allows variable calc
                        routines to be edited.
    roViewEvents	      All objects can be viewed within the Calc tab.  When
                        object is selected, all events for that object are
                        displayed.  Any event handlers assigned to objects can
                        be viewed but not edited.
    roEditEvents	      When ViewEvents is selected, allows the event handlers
                        routines to be edited.
    roViewGlobals	      Global procedures and objects can be viewed within Calc
                        tab.  When global object or procedure is selected,
                        routines can be viewed but not edited.
    roEditGlobals       When ViewGlobals is selected, allows global object event
                        handlers and global procedures to be edited.
    </Table>

    Note: If you are having difficulty getting the Calc tab to appear in the
    Report Designer, then see Controlling the End-User Application.}

  {@TppDesigner.Report

    The Report property is the report that is being designed.}

  {@TppDesigner.SendToBack

    The SendToBack method puts the designer behind all other forms.}

  {@TppDesigner.ShowComponents

    This property can be used to control exactly which components display in the
    report designer.  Each component is display in the report designer depending
    on the contents of the set.  The set can contain the following values:

    <Table>
    Value	            Meaning
    ---------         ----------
    scLabel	          TppLabel component is displayed.
    scMemo	          TppMemo component is displayed.
    scRichText	      TppRichText component is displayed.
    scCalc	          TppCalc component is displayed.
    scImage	          TppImage component is displayed.
    scShape	          TppShape component is displayed.
    scLine	          TppLine component is displayed.
    scBarCode	        TppBarCode component is displayed.
    scTeeChart	      TppTeeChart component is displayed.
    scDBText	        TppDBText component is displayed.
    scDBMemo	        TppDBMemo component is displayed.
    scDBRichText      TppDBRichText component is displayed.
    scDBCalc	        TppDBCalc component is displayed.
    scDBImage	        TppDBImage component is displayed.
    scDBBarCode	      TppDBBarCode component is displayed.
    scDBTeeChart      TppDBTeeChart component is displayed.
    scRegion	        TppRegion component is displayed.
    scSubReport	      TppSubReport component is displayed.
    scSystemVariable  TppSystemVariable component is displayed.
    scVariable        TppVariable component is displayed.
    scPageBreak       TppPageBreak component is displayed.
    sc2DBarCode       Tpp2DBarCode component is displayed.
    scDB2DBarCode     TppB2DBarCode component is displayed.
    scPaintBox        TppPaintBox component is displayed.
    </Table>}

  {@TppDesigner.ShowData

    The ShowData property controls whether or not data is displayed for
    data-aware controls in the designer.  You can select the Show Data option of
    the designer's View menu in order to toggle this value.

    This property allows you to work with templates using field names even when
    the underlying DataSets are open.  Important features such as the
    DisplayFormat dialog work best when DataSets are open and information
    regarding field types is available.

    Note: The ShowData property does not open the DataSets associated with a
    report.  If the DataSets are closed, the data will not be shown, even if
    ShowData is set to True.  For this reason it is usually best to open the
    DataSets before the user begins editing the report.}

  {@TppDesigner.TabSet

    Run-time and read-only. Use the TabSet property to gain access to the
    TTabSet control of the designer. The TabSet is only displayed when the
    report being designed contains subreports. There is one tab for the main
    report and for each subreport.}

  {@TppDesigner.TabsVisible

    The TabsVisible property determines whether the design and preview tabs are
    displayed. When set to False, the tabs are hidden and only the design page
    is shown.}

  {@TppDesigner.Visible

    The Visible property determines whether the designer window is shown on the
    screen.}

  {@TppDesigner.WindowHeight

    The WindowHeight property of a control is the vertical size of the window in
    pixels.}

  {@TppDesigner.WindowLeft

    The WindowLeft property of a control is the horizontal coordinate of the
    left edge of the window relative to the screen. The value is expressed in
    pixels.}

  {@TppDesigner.WindowState

    The WindowState determines the initial state of the form. These are the possible values:

    <Table>
    Value	        Meaning
    -----------   ------
    wsNormal	    The form appears neither maximized nor minimized
    wsMaximized	  The form is maximized
    wsMinimized	  The form is minimized
    </Table>

    The default value is wsNormal.}

  {@TppDesigner.WindowTag

    The WindowTag property is not used by Delphi or ReportBuilder. It is
    provided for the convenience of storing additional integer value or pointer
    information for special needs in an application.}

  {@TppDesigner.WindowTop

    The WindowTop property of a control is the vertical coordinate of the top
    edge of the window relative to the screen. The value is expressed in
    pixels.}

  {@TppDesigner.WindowWidth

    The WindowWidth property of a control is the horizontal size of the window
    in pixels.}

 TppDesigner = class(TppCommunicator)
    private
      FAllowDataSettingsChange: Boolean;
      FAllowSaveToFile: Boolean;
      FCaption: String;
      FComponentClasses: TStrings;
      FNagem: Boolean;
      FIcon: TIcon;
      FMergeMenu: TMainMenu;
      FPosition: TPosition;
      FDesignerWindow: TppDesignerWindow;
      FReport: TppReport;
      FShowComponents: TppShowComponents;
      FShowData: Boolean;
      FTabsVisible: Boolean;
      FVisible: Boolean;
      FWindowHeight: Integer;
      FWindowLeft: Integer;
      FWindowState: TWindowState;
      FWindowTag: LongInt;
      FWindowTop: Integer;
      FWindowWidth: Integer;
      FDataSettings: TppDataSettings;
      FOnHelp: TppHelpEvent;
      FEnableHelp: Boolean;
      FFieldAliases: TStringList;
      FFormStyle: TFormStyle;
      FHelpFile: String;
      FIniStorageName: String;
      FIniStorageType: String;

      {events}
      FOnActivate: TNotifyEvent;
      FOnAssignField: TNotifyEvent;
      FOnClose: TCloseEvent;
      FOnCreate: TNotifyEvent;
      FOnCreateComponent: TppComponentEvent;
      FOnCreateReport: TppCreateReportEvent;
      FOnCustomOpenDoc: TNotifyEvent;
      FOnCustomSaveDoc: TNotifyEvent;
      FOnDestroyComponent: TppComponentEvent;
      FOnDeActivate: TNotifyEvent;
      FOnDestroy: TNotifyEvent;
      FOnCloseQuery: TCloseQueryEvent;
      FOnGetDataNames: TppGetDataNamesEvent;
      FOnGetAliasForField: TppGetAliasForFieldEvent;
      FOnGetDisplayFormats: TppGetDisplayFormatsEvent;
      FOnGetFieldForAlias: TppGetFieldForAliasEvent;
      FOnGetFields: TppGetFieldsEvent;
      FOnHide: TNotifyEvent;
      FOnReportSelected: TNotifyEvent;
      FOnResize: TNotifyEvent;
      FOnSelectionChanged: TppSetSelectionEvent;
      FOnShow: TNotifyEvent;
      FOnTabChange: TppTabChangeEvent;
      FOnTabChanged: TNotifyEvent;
      FOnValidateComponent: TppValidateComponentEvent;
      FRAPInterface: TppRAPInterfaceOptions;
      FRAPOptions: TppRAPOptions;

      function CreateDesignerWindow: TppDesignerWindow;
      procedure ConfigureIniStorage;
      function GetCurrentReport: TppCustomReport;
      function GetDesignerWindow: TppDesignerWindow;
      function GetFieldAliases: TStrings;
      function GetForm: TppDesignerWindow;
      function GetFormStyle: TFormStyle;
      function GetNotebook: TppTabbedNotebook;

      procedure GetShowComponentClasses(aComponentClasses: TStrings);

      function GetShowData: Boolean;
      function GetTabSet: TTabset;
      function GetVisible: Boolean;
      function GetMenu: TppMenuBar;
      function GetViewer: TppViewer;
      function GetWindowHeight: Integer;
      function GetWindowLeft: Integer;
      function GetWindowTop: Integer;
      function GetWindowWidth: Integer;
      function GetWindowState: TWindowState;
      function GetWindowTag: LongInt;

      procedure DesignerWindowShowEvent(Sender: TObject);
      procedure DesignerWindowDestroyed(Sender: TObject);
      procedure IconChange(Sender: TObject);
      procedure SetAllowDataSettingsChange(aValue: Boolean);
      procedure SetAllowSaveToFile(aValue: Boolean);
      procedure SetComponentClasses(aComponentClasses: TStrings);
      procedure SetCaption(aCaption: String);
      procedure SetDataSettings(aDataSettings: TppDataSettings);
      procedure SetFormStyle(aFormStyle: TFormStyle);
      procedure SetFieldAliases(aFieldAliases: TStrings);
      procedure SetMergeMenu(aMenu: TMainMenu); 
      procedure SetHeight(aHeight: Integer);
      procedure SetIcon(aIcon: TIcon);
      procedure SetLeft(aLeft: Integer);
      procedure SetPosition(aPosition: TPosition);
      procedure SetIniStorageType(aStorageType: String);
      procedure SetIniStorageName(aStorageName: String);
      procedure SetTabsVisible(aValue: Boolean);
      procedure SetTop(aTop: Integer);
      procedure SetVisible(aValue: Boolean);
      procedure SetWidth(aWidth: Integer);
      procedure SetWindowState(aWindowState: TWindowState);
      procedure SetWindowTag(aTag: LongInt);

      procedure SetOnActivate(aNotifyEvent: TNotifyEvent);
      procedure SetOnAssignField(const Value: TNotifyEvent);
      procedure SetOnClose(aCloseEvent: TCloseEvent);
      procedure SetOnCloseQuery(aCloseQueryEvent: TCloseQueryEvent);
      procedure SetOnCreateComponent(const Value: TppComponentEvent);
      procedure SetOnCreateReport(const Value: TppCreateReportEvent);
      procedure SetOnCustomOpenDoc(const Value: TNotifyEvent);
      procedure SetOnCustomSaveDoc(const Value: TNotifyEvent);
      procedure SetOnDestroy(aNotifyEvent: TNotifyEvent);
      procedure SetOnDeactivate(aNotifyEvent: TNotifyEvent);
      procedure SetOnDestroyComponent(const Value: TppComponentEvent);
      procedure SetOnGetDataNames(const Value: TppGetDataNamesEvent);
      procedure SetOnGetDisplayFormats(const Value: TppGetDisplayFormatsEvent);
      procedure SetOnGetFields(const Value: TppGetFieldsEvent);
      procedure SetOnSelectionChanged(aSetSelectionEvent: TppSetSelectionEvent);
      procedure SetOnHide(aNotifyEvent: TNotifyEvent);
      procedure SetOnResize(aNotifyEvent: TNotifyEvent);
      procedure SetRAPInterface(aInterfaceOptions: TppRAPInterfaceOptions);
      procedure SetRAPOptions(aRAPOptions: TppRAPOptions);
      procedure SetReport(aReport: TppReport);
      procedure SetShowComponents(aShowComponents: TppShowComponents);
      procedure SetShowData(Value: Boolean);
      procedure ShowNagDlg;
      procedure SetOnHelp(aHelpEvent: TppHelpEvent);
      procedure SetOnReportSelected(const Value: TNotifyEvent);
      procedure SetOnTabChange(const Value: TppTabChangeEvent);
      procedure SetOnTabChanged(const Value: TNotifyEvent);
      procedure SetOnValidateComponent(const Value: TppValidateComponentEvent);

    protected
      procedure Loaded; override;
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;
      procedure DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean);

      procedure ehLayoutManager_AssignField(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_CreateComponent(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_CreateReport(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_CustomOpenDoc(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_CustomSaveDoc(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_DestroyComponent(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_GetDataNames(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_GetDisplayFormats(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_GetFields(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_GetFieldAliases(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_ReportDestroy(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_ReportSelected(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_TabChange(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_TabChanged(Sender, aParameters: TObject); virtual;
      procedure ehLayoutManager_ValidateComponent(Sender, aParameters: TObject); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure BringToFront;
      procedure Close;
      procedure Hide;
      procedure Invalidate;
      procedure PrintReport;
      procedure SendToBack;
      procedure SetBounds(aLeft, aTop, aWidth, aHeight: Integer);
      procedure SetSelection(aSelection: TppDesignerSelectionList);

      procedure Show;
      procedure ShowInPanel(aParent: TWinControl);
      procedure ShowModal;
      procedure UpdateDocHistory(aTemplate: TppTemplate);

      property ComponentClasses: TStrings read FComponentClasses write SetComponentClasses;
      property CurrentReport: TppCustomReport read GetCurrentReport;
      property FieldAliases: TStrings read GetFieldAliases write SetFieldAliases;
      property Form: TppDesignerWindow read GetForm;
      property FormStyle: TFormStyle read GetFormStyle write SetFormStyle default fsNormal;
      property Menu: TppMenuBar read GetMenu;
      property Notebook: TppTabbedNotebook read GetNotebook;
      property Viewer: TppViewer read GetViewer;

      property TabSet: TTabset read GetTabSet;

     {public events - support for versions 3.52 and prior}
      property OnGetAliasForField: TppGetAliasForFieldEvent read FOnGetAliasForField write FOnGetAliasForField;
      property OnGetFieldForAlias: TppGetFieldForAliasEvent read FOnGetFieldForAlias write FOnGetFieldForAlias;

   published
      property AllowDataSettingsChange: Boolean read FAllowDataSettingsChange write SetAllowDataSettingsChange default False;
      property AllowSaveToFile: Boolean read FAllowSaveToFile write SetAllowSaveToFile default True;
      property Caption: String read FCaption write SetCaption;
      property DataSettings: TppDataSettings read FDataSettings write SetDataSettings;
      property EnableHelp: Boolean read FEnableHelp write FEnableHelp default True;
      property HelpFile: String read FHelpFile write FHelpFile;
      property Icon: TIcon read FIcon write SetIcon;
      property MergeMenu: TMainMenu read FMergeMenu write SetMergeMenu;
      property Position: TPosition read FPosition write SetPosition;
      property ShowComponents: TppShowComponents read FShowComponents write SetShowComponents
                                               default cAllShowComponents;

      property RAPInterface: TppRAPInterfaceOptions read FRAPInterface write SetRAPInterface
                                               default cAllRAPInterfaceOptions;
      property RAPOptions: TppRAPOptions read FRAPOptions write SetRAPOptions
                                               default cAllRAPOptions;



      property Report: TppReport read FReport write SetReport;
      property ShowData: Boolean read GetShowData write SetShowData default True;
      property IniStorageType: String read FIniStorageType write SetIniStorageType;
      property IniStorageName: String read FIniStorageName write SetIniStorageName;
      property TabsVisible: Boolean read FTabsVisible write SetTabsVisible default True;
      property Visible: Boolean read GetVisible write SetVisible default True;
      property WindowHeight: Integer read GetWindowHeight write SetHeight;
      property WindowLeft: Integer read GetWindowLeft write SetLeft;
      property WindowTop: Integer read GetWindowTop write SetTop;
      property WindowWidth: Integer read GetWindowWidth write SetWidth;
      property WindowState: TWindowState read GetWindowState write SetWindowState default wsNormal;
      property WindowTag: LongInt read GetWindowTag write SetWindowTag default 0;

      {events}
      property OnActivate: TNotifyEvent read FOnActivate write SetOnActivate;
      property OnAssignField: TNotifyEvent read FOnAssignField write SetOnAssignField;
      property OnClose: TCloseEvent read FOnClose write SetOnClose;
      property OnCloseQuery: TCloseQueryEvent read FOnCloseQuery write SetOnCloseQuery;
      property OnCreate: TNotifyEvent read FOnCreate write FOnCreate;
      property OnCreateComponent: TppComponentEvent read FOnCreateComponent write SetOnCreateComponent;
      property OnCreateReport: TppCreateReportEvent read FOnCreateReport write SetOnCreateReport;
      property OnCustomOpenDoc: TNotifyEvent read FOnCustomOpenDoc write SetOnCustomOpenDoc;
      property OnCustomSaveDoc: TNotifyEvent read FOnCustomSaveDoc write SetOnCustomSaveDoc;
      property OnDestroyComponent: TppComponentEvent read FOnDestroyComponent write SetOnDestroyComponent;
      property OnDeactivate: TNotifyEvent read FOnDeactivate write SetOnDeactivate;
      property OnDestroy: TNotifyEvent read FOnDestroy write SetOnDestroy;
      property OnGetDataNames: TppGetDataNamesEvent read FOnGetDataNames write SetOnGetDataNames;
      property OnGetDisplayFormats: TppGetDisplayFormatsEvent read FOnGetDisplayFormats write SetOnGetDisplayFormats;
      property OnGetFields: TppGetFieldsEvent read FOnGetFields write SetOnGetFields;
      property OnHelp: TppHelpEvent read FOnHelp write SetOnHelp;
      property OnHide: TNotifyEvent read FOnHide write SetOnHide;
      property OnResize: TNotifyEvent read FOnResize write SetOnResize;
      property OnReportSelected: TNotifyEvent read FOnReportSelected write SetOnReportSelected;
      property OnSelectionChanged: TppSetSelectionEvent read FOnSelectionChanged write SetOnSelectionChanged;
      property OnShow: TNotifyEvent read FOnShow write FOnShow;
      property OnTabChange: TppTabChangeEvent read FOnTabChange write SetOnTabChange;
      property OnTabChanged: TNotifyEvent read FOnTabChanged write SetOnTabChanged;
      property OnValidateComponent: TppValidateComponentEvent read FOnValidateComponent write SetOnValidateComponent;

  end; {class, TppDesigner }


implementation

uses
  TypInfo,
  ppFormWrapper, // link in design-time resources
  ppForms,
  ppUtils,
  ppCmpReg;

{------------------------------------------------------------------------------}
{ TppDesigner.ShowNagDlg }

procedure TppDesigner.ShowNagDlg;
var
  lDemoDialog: TppCustomDemoDialog;
  lFormClass: TFormClass;

begin

  if FNagem then
    begin
      FNagem := False;
      lFormClass := ppGetFormClass(TppCustomDemoDialog);
      lDemoDialog := TppCustomDemoDialog(lFormClass.Create(Application));
      lDemoDialog.ShowModal;
      lDemoDialog.Release;
    end;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.Create }

constructor TppDesigner.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FAllowDataSettingsChange := False;
  FAllowSaveToFile := True;

  FCaption := 'ReportBuilder';

  {default ini storage}
  FIniStorageType := TppIniStoragePlugIn.GetStorageClass.ClassDescription;
  FIniStorageName := TppIniStoragePlugIn.GetStorageClass.DefaultStorageName;

  if not(ppValidDate) then
    FNagem := True
  else
    FNagem := False;

  FFormStyle    := fsNormal;
  FMergeMenu    := nil;
  FWindowHeight := 400;
  FIcon         := TIcon.Create;
  FIcon.OnChange := IconChange;
  FWindowLeft   := 100;
  FPosition     := poScreenCenter;
  FReport       := nil;
  FShowData     := True;
  FTabsVisible  := True;
  FWindowTop    := 50;
  FVisible      := True;
  FWindowWidth  := 600;
  FWindowState  := wsNormal;
  FWindowTag    := 0;

  FDataSettings := TppDataSettings.Create(Self);

  FShowComponents := cAllShowComponents;
  FComponentClasses := TStringList.Create;
  GetShowComponentClasses(FComponentClasses);

  FRAPInterface := cAllRAPInterfaceOptions;
  FRAPOptions   := cAllRAPOptions;

  FEnableHelp := True;
  FHelpFile   := '';

  {events }
  FOnActivate             := nil;
  FOnAssignField          := nil;
  FOnClose                := nil;
  FOnCloseQuery           := nil;
  FOnCreate               := nil;
  FOnDeactivate           := nil;
  FOnDestroy              := nil;
  FOnGetAliasForField     := nil;
  FOnGetDataNames         := nil;
  FOnGetDisplayFormats    := nil;
  FOnGetFieldForAlias     := nil;
  FOnGetFields            := nil;
  FOnHide                 := nil;
  FOnSelectionChanged     := nil;
  FOnShow                 := nil;
  FOnResize               := nil;
  FOnTabChange            := nil;
  FOnHelp                 := nil;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.Destroy }

destructor TppDesigner.Destroy;
begin

  if (FDesignerWindow <> nil) then
    FDesignerWindow.DataSettings := nil;
  
  FDataSettings.Free;
  FDataSettings := nil;
  FReport := nil;

  FIcon.Free;
  FIcon := nil;

  FComponentClasses.Free;
  FComponentClasses := nil;
  
  FFieldAliases.Free;
  FFieldAliases := nil;

  {let MDI Parent free the child window}
  if (FDesignerWindow <> nil) and (FDesignerWindow.FormStyle = fsMDIChild) then
    begin
      FDesignerWindow.BeforeDestroy   := nil;
//      FDesignerWindow.OnReportDestroy := nil;
      FDesignerWindow.OnShow          := nil;
      FDesignerWindow := nil;
    end;

  FDesignerWindow.Free;
  FDesignerWindow := nil;

  inherited Destroy;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.Loaded }

procedure TppDesigner.Loaded;
begin

  inherited Loaded;

  if Assigned(FOnCreate) then FOnCreate(Self);

end; {procedure, Loaded}

{------------------------------------------------------------------------------}
{ TppDesigner.GetDesignerWindow }

function TppDesigner.GetDesignerWindow: TppDesignerWindow;
begin

  if (FDesignerWindow = nil) then
    Result := CreateDesignerWindow
  else
    Result := FDesignerWindow;

end; {function, GetDesignerWindow}

{------------------------------------------------------------------------------}
{ TppDesigner.CreateDesignerWindow }

function TppDesigner.CreateDesignerWindow: TppDesignerWindow;
begin

  Result := nil;

  if (FDesignerWindow <> nil) then
    raise EDesignError.Create('TppDesigner.CreateDesignerWindow: DesignerWindow already exists.');

  if (csDesigning in ComponentState) then Exit;

  {setup the ini storage class}
  ConfigureIniStorage;

  {create the window}
  FDesignerWindow := TppDesignerWindow.Create(Self);

  {internal events}
  FDesignerWindow.BeforeDestroy   := DesignerWindowDestroyed;
  FDesignerWindow.OnShow          := DesignerWindowShowEvent;

  if (FMergeMenu <> nil) then
    FDesignerWindow.MainMenu.Merge(FMergeMenu);

  FDesignerWindow.SetTabsVisible(FTabsVisible);

  {pass-thru props}
  FDesignerWindow.AllowDataSettingsChange := FAllowDataSettingsChange;
  FDesignerWindow.AllowSaveToFile :=  FAllowSaveToFile;
  FDesignerWindow.DefaultCaption := FCaption;
  FDesignerWindow.DataSettings := FDataSettings;

  if (FIcon <> nil) and not(FIcon.Empty) then
    FDesignerWindow.Icon :=  FIcon;
    
  FDesignerWindow.Position := FPosition;
  FDesignerWindow.LiveData := FShowData;
  FDesignerWindow.Height := FWindowHeight;
  FDesignerWindow.Left := FWindowLeft;
  FDesignerWindow.Top := FWindowTop;
  FDesignerWindow.Width := FWindowWidth;
  FDesignerWindow.WindowState := FWindowState;
  FDesignerWindow.Tag := FWindowTag;

  {pass-thru events}
  FDesignerWindow.OnActivate := FOnActivate;
  FDesignerWindow.OnClose := FOnClose;
  FDesignerWindow.OnCloseQuery := FOnCloseQuery;
  FDesignerWindow.OnDeactivate := FOnDeactivate;
  FDesignerWindow.OnDestroy := FOnDestroy;
  FDesignerWindow.OnHelp := DoOnHelp;
  FDesignerWindow.OnHide := FOnHide;
  FDesignerWindow.OnResize := FOnResize;

  // design hub end-user events (these are multi-cast events)
  if Assigned(FOnAssignField) then
    FDesignerWindow.EventHub.EndUserEvents.mcAssignField.AddNotify(ehLayoutManager_AssignField);

  if Assigned(FOnCreateComponent) then
    FDesignerWindow.EventHub.EndUserEvents.mcCreateComponent.AddNotify(ehLayoutManager_CreateComponent);

  if Assigned(FOnCreateReport) then
    FDesignerWindow.EventHub.EndUserEvents.mcCreateReport.AddNotify(ehLayoutManager_CreateReport);

  if Assigned(FOnCustomOpenDoc) then
    FDesignerWindow.EventHub.EndUserEvents.mcCustomOpenDoc.AddNotify(ehLayoutManager_CustomOpenDoc);

  if Assigned(FOnCustomSaveDoc) then
    FDesignerWindow.EventHub.EndUserEvents.mcCustomSaveDoc.AddNotify(ehLayoutManager_CustomSaveDoc);

  if Assigned(FOnDestroyComponent) then
    FDesignerWindow.EventHub.EndUserEvents.mcDestroyComponent.AddNotify(ehLayoutManager_DestroyComponent);

  if Assigned(FOnGetDataNames) then
    FDesignerWindow.EventHub.EndUserEvents.mcGetDataNames.AddNotify(ehLayoutManager_GetDataNames);

  if Assigned(FOnGetDisplayFormats) then
    FDesignerWindow.EventHub.EndUserEvents.mcGetDisplayFormats.AddNotify(ehLayoutManager_GetDisplayFormats);

  if Assigned(FOnGetFields) then
    FDesignerWindow.EventHub.EndUserEvents.mcGetFields.AddNotify(ehLayoutManager_GetFields);

  if Assigned(FFieldAliases) and (FFieldAliases.Count > 0) then
    FDesignerWindow.EventHub.EndUserEvents.mcGetFieldAliases.AddNotify(ehLayoutManager_GetFieldAliases);

  if Assigned(FOnReportSelected) then
    FDesignerWindow.EventHub.EndUserEvents.mcReportSelected.AddNotify(ehLayoutManager_ReportSelected);
    
  FDesignerWindow.EventHub.EndUserEvents.mcReportDestroy.AddNotify(ehLayoutManager_ReportDestroy);

  if Assigned(FOnTabChange) then
    FDesignerWindow.EventHub.EndUserEvents.mcTabChange.AddNotify(ehLayoutManager_TabChange);

  if Assigned(FOnTabChanged) then
    FDesignerWindow.EventHub.EndUserEvents.mcTabChanged.AddNotify(ehLayoutManager_TabChanged);

  if Assigned(FOnValidateComponent) then
    FDesignerWindow.EventHub.EndUserEvents.mcValidateComponent.AddNotify(ehLayoutManager_ValidateComponent);

  FDesignerWindow.OnSetSelection:= FOnSelectionChanged;

  {connect Report to Designer - note: do this last}
  FDesignerWindow.Report := FReport;
  FDesignerWindow.LoadStateInfo;

  FDesignerWindow.ChangeFormStyle(FormStyle);

  Result := FDesignerWindow;

end; {function, CreateDesignerWindow}

{------------------------------------------------------------------------------}
{ TppDesigner.ConfigureIniStorage}

procedure TppDesigner.ConfigureIniStorage;
var
  lIniStorageClass: TppIniStorageClass;
begin

  lIniStorageClass := TppIniStoragePlugIns.GetClassForName(FIniStorageType);

  if (lIniStorageClass <> nil) then
    begin
      TppIniStoragePlugIn.SetClass(lIniStorageClass);
      TppIniStoragePlugIn.SetStorageName(FIniStorageName);
    end;

end; {procedure, ConfigureIniStorage}


{------------------------------------------------------------------------------}
{ TppDesigner.DesignerWindowShowEvent}

procedure TppDesigner.DesignerWindowShowEvent(Sender: TObject);
begin

  if (FDesignerWindow <> nil) then
    begin
      FDesignerWindow.SetTabsVisible(FTabsVisible);
      FDesignerWindow.RAPInterface := FRAPInterface;
      FDesignerWindow.RAPOptions := FRAPOptions;
      
      {optimization}
      if (FShowComponents <> cAllShowComponents) then
        FDesignerWindow.ComponentClasses := FComponentClasses;
    end;

  ShowNagDlg;

  if Assigned(FOnShow) then FOnShow(FDesignerWindow);

end; {procedure, DesignerWindowShowEvent}


{------------------------------------------------------------------------------}
{ TppDesigner.DesignerWindowDestroyed}

procedure TppDesigner.DesignerWindowDestroyed(Sender: TObject);
begin
  FDesignerWindow := nil;
end;

{------------------------------------------------------------------------------}
{ TppDesigner.Notification }

procedure TppDesigner.Notification(AComponent: TComponent; Operation: TOperation);
begin

  inherited Notification(AComponent, Operation);

  if (aComponent = FReport) and (Operation = opRemove) then
    FReport := nil

  else if (aComponent = FMergeMenu) and (Operation = opRemove) then
    FMergeMenu := nil
  else if (aComponent = FDesignerWindow) and (Operation = opRemove) then
     FDesignerWindow := nil;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.Notify }

procedure TppDesigner.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation <> ppopRemove) or (csDestroying in ComponentState) then Exit;

  if (FDataSettings <> nil) and (aCommunicator = FDataSettings.DataDictionary) then
    FDataSettings.DataDictionary := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppDesigner.DoOnHelp}

procedure TppDesigner.DoOnHelp(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean);
begin
  aCallHelp := FEnableHelp;

  if (FHelpFile <> '') then
    aHelpFile := FHelpFile;

  {fire the help event}
  if Assigned(FOnHelp) then FOnHelp(Sender, aHelpFile, aKeyphrase, aCallHelp);

end; {procedure, DoOnHelp}

{------------------------------------------------------------------------------}
{ TppDesigner.SetMergeMenu }

procedure TppDesigner.SetMergeMenu(aMenu: TMainMenu);
begin

  FMergeMenu := aMenu;

  {merge MergeMenu with DesignerWindow's menu}
  if (FDesignerWindow <> nil) and (FMergeMenu <> nil) then
    FDesignerWindow.MainMenu.Merge(FMergeMenu);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetReport }

procedure TppDesigner.SetReport(aReport: TppReport);
begin

  if (FReport = aReport) then Exit;

  {remove old designer window }
  if (FDesignerWindow <> nil) and (FReport <> nil) then
    FDesignerWindow.Component := nil;

  FReport := aReport;

  {if reading or loading, do not attach report to designer, until the loaded}
  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

 {assign report to the designer window}
 if (FDesignerWindow <> nil) then
    FDesignerWindow.Component := aReport;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetForm }

function TppDesigner.GetForm: TppDesignerWindow;
begin
  Result := GetDesignerWindow;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetFormStyle }

function TppDesigner.GetFormStyle: TFormStyle;
begin
  if (GetDesignerWindow = nil) then
    Result := FFormStyle
  else
    Result := FDesignerWindow.FormStyle;
end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetNotebook }


function TppDesigner.GetNotebook: TppTabbedNotebook;
begin
  if (GetDesignerWindow = nil) then
    Result := nil
  else
    Result := FDesignerWindow.Notebook;
end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetShowData }

function TppDesigner.GetShowData: Boolean;
begin
  if (FDesignerWindow = nil) then
    Result := FShowData
  else
    Result := FDesignerWindow.LiveData;
end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetTabset }

function TppDesigner.GetTabset: TTabset;
begin
  if (GetDesignerWindow = nil) then
    Result := nil
  else
    Result := FDesignerWindow.LayoutManager.WorkspaceView.ReportTabs;
end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetMenu }

function TppDesigner.GetMenu: TppMenuBar;
begin

  if (GetDesignerWindow = nil) then
    Result := nil
  else
    Result := FDesignerWindow.MainMenu;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetViewer }

function TppDesigner.GetViewer: TppViewer;
begin
  if (GetDesignerWindow = nil) then
    Result := nil
  else
    Result := FDesignerWindow.PreviewManager.Viewer;
end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetVisible }

function TppDesigner.GetVisible: Boolean;
begin
  if (FDesignerWindow = nil) then
    Result := FVisible
  else
    Result := FDesignerWindow.Visible;
end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetWindowHeight }

function TppDesigner.GetWindowHeight: Integer;
begin

  if (FDesignerWindow = nil) then
    Result := FWindowHeight
  else
    Result := FDesignerWindow.Height;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetWindowLeft }

function TppDesigner.GetWindowLeft: Integer;
begin

  if (FDesignerWindow = nil) then
    Result := FWindowLeft
  else
    Result := FDesignerWindow.Left;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetWindowTop }

function TppDesigner.GetWindowTop: Integer;
begin

  if (FDesignerWindow = nil) then
    Result := FWindowTop
  else
    Result := FDesignerWindow.Top;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetWindowWidth }

function TppDesigner.GetWindowWidth: Integer;
begin

  if (FDesignerWindow = nil) then
    Result := FWindowWidth
  else
    Result := FDesignerWindow.Width;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetWindowState }

function TppDesigner.GetWindowState: TWindowState;
begin

  if (FDesignerWindow = nil) then
    Result := FWindowState
  else
    Result := FDesignerWindow.WindowState;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetWindowTag }

function TppDesigner.GetWindowTag: LongInt;
begin

  if (FDesignerWindow = nil) then
    Result := FWindowTag
  else
    Result := FDesignerWindow.Tag;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetRAPInterface }

procedure TppDesigner.SetRAPInterface(aInterfaceOptions: TppRAPInterfaceOptions);
var
  lNewOptions: TppRAPInterfaceOptions;

begin
  if (FRAPInterface = aInterfaceOptions) then Exit;

  lNewOptions := aInterfaceOptions - FRAPInterface;

  FRAPInterface := aInterfaceOptions;

  {note: must set this in the OnShow for Delphi 5 or get an error.}
  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (FDesignerWindow <> nil) and (FDesignerWindow.Visible) then
    FDesignerWindow.RAPInterface := FRAPInterface;


  {if no interface then no options }
  if (FRAPInterface = []) then
    FRAPOptions := []

  else if (FRAPInterface = [riDialog]) then
    FRAPOptions := cRAPDialogOptions

  else if (riNotebookTab in lNewOptions) then
    FRAPOptions := cALLRAPOptions;


end; {procedure, SetRAPInterface}

{------------------------------------------------------------------------------}
{ TppDesigner.SetRAPOptions }

procedure TppDesigner.SetRAPOptions(aRAPOptions: TppRAPOptions);
begin

  {cannot set any options if interface is turned off}
  if (FRAPInterface = []) then Exit;

  {if interface is dialog only dialog options may be set}
  if (FRAPInterface = [riDialog]) then
    FRAPOptions := (aRAPOptions * cRAPDialogOptions) + [roViewVariables]
  else
    begin
      {when notebook tab is visible, user can at a minimum view the variables}
      FRAPOptions := aRAPOptions + [roViewVariables];

      {if editing allowed, then viewing must be allowed also}
      if (roEditEvents in FRAPOptions) then
        FRAPOptions := aRAPOptions + [roViewEvents];

      if (roEditGlobals in FRAPOptions) then
        FRAPOptions := aRAPOptions + [roViewGlobals];

    end;

  if (FDesignerWindow <> nil) and (FDesignerWindow.Visible) then
    FDesignerWindow.RAPOptions := FRAPOptions;

end; {procedure, FRAPOptions}

{------------------------------------------------------------------------------}
{ TppDesigner.SetShowComponents }

procedure TppDesigner.SetShowComponents(aShowComponents: TppShowComponents);
var
  lComponentClasses: TStringList;

begin

  if (FShowComponents = aShowComponents) then Exit;

  FShowComponents := aShowComponents;

  lComponentClasses := TStringList.Create;

  GetShowComponentClasses(lComponentClasses);

  SetComponentClasses(lComponentClasses);

  lComponentClasses.Free;

end; {procedure, SetShowComponents}

{------------------------------------------------------------------------------}
{ TppDesigner.SetComponentClasses}

procedure TppDesigner.SetComponentClasses(aComponentClasses: TStrings);
begin

   FComponentClasses.Assign(aComponentClasses);

  if (FDesignerWindow <> nil) then
    FDesignerWindow.ComponentClasses := FComponentClasses;

end; {procedure, SetComponentClasses}

{------------------------------------------------------------------------------}
{ TppDesigner.SetComponentClasses}

procedure TppDesigner.SetAllowSaveToFile(aValue: Boolean);
begin

  FAllowSaveToFile := aValue;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.AllowSaveToFile := FAllowSaveToFile;

end; {procedure, SetComponentClasses}


{------------------------------------------------------------------------------}
{ TppDesigner.SetAllowDataSettingsChange}

procedure TppDesigner.SetAllowDataSettingsChange(aValue: Boolean);
begin

  FAllowDataSettingsChange := aValue;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.AllowDataSettingsChange := FAllowDataSettingsChange;

end; {procedure, SetAllowDataSettingsChange}


{------------------------------------------------------------------------------}
{ TppDesigner.GetShowComponentClasses}

procedure TppDesigner.GetShowComponentClasses(aComponentClasses: TStrings);
var
  liIndex: Integer;
  liClass: Integer;
  lEnumNames: TStringList;
  lsClassName: String;
  lHideComponents: TStringList;

begin

  lEnumNames := TStringList.Create;
  lHideComponents := TStringList.Create;

  {get list of enum names}
  ppGetEnumNames(TypeInfo(TppShowComponent), lEnumNames);

  {determine list of components to be ommitted (i.e. not shown on palette}
  for liIndex := lEnumNames.Count-1 downto 0 do
    if TppShowComponent(liIndex) in FShowComponents then
      lEnumNames.Delete(liIndex);

  {build list of classnames for items to be hidden}
  for liIndex := 0 to lEnumNames.Count-1 do
    begin
      lsClassName := 'Tpp' + Copy(lEnumNames[liIndex],3, Length(lEnumNames[liIndex]));

      lHideComponents.Add(lsClassName);

      // handle special case of DPTeeChart
      if (lEnumNames[liIndex] = 'scDBTeeChart') then
        lHideComponents.Add('TppDPTeeChart');

    end;


  {get list of all registered classes}
  aComponentClasses.Assign(ppComponentClassList);

  {delete any class to be hidden}
  for liClass := 0 to lHideComponents.Count-1 do
    begin
      liIndex := aComponentClasses.IndexOf(lHideComponents[liClass]);

      if liIndex >= 0 then
        aComponentClasses.Delete(liIndex);

    end;


  lHideComponents.Free;
  lEnumNames.Free;


end; {procedure, GetShowComponentClasses}


{------------------------------------------------------------------------------}
{ TppDesigner.SetShowData }

procedure TppDesigner.SetShowData(Value: Boolean);
begin
  FShowData := Value;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.LiveData := Value;
end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetTabsVisible }

procedure TppDesigner.SetTabsVisible(aValue: Boolean);
begin
  FTabsVisible := aValue;

  {note: must set this in the Onshow for Delphi 5 or get an error.}
  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.SetTabsVisible(aValue);

end;


{@TppDesigner.BringToFront
 The BringToFront method puts the designer in front of all other forms.
 BringToFront is especially useful for making certain that the designer is
 visible.}

procedure TppDesigner.BringToFront;
begin

  if (FDesignerWindow <> nil) then
    FDesignerWindow.BringToFront;

end;


{@TppDesigner.Close
 The Close method closes the form. Calling the Close method on a form
 corresponds to the user selecting the Close menu item on the form's System
 menu. The Close method first calls the CloseQuery method to determine if the
 form can close. If CloseQuery returns False, the close operation is aborted.
 Otherwise, if CloseQuery returns True, the code attached to the OnClose event
 is executed. The CloseAction parameter of the OnClose event controls how the
 form is actually closed.}

procedure TppDesigner.Close;
begin
  if (FDesignerWindow <> nil) then
    FDesignerWindow.Close;
end;

procedure TppDesigner.ehLayoutManager_AssignField(Sender, aParameters: TObject);
begin
  if Assigned(FOnAssignField) then FOnAssignField(Sender);
end;

procedure TppDesigner.ehLayoutManager_CreateComponent(Sender, aParameters: TObject);
begin
  if Assigned(FOnCreateComponent) then FOnCreateComponent(Sender, TComponent(aParameters));
end;

procedure TppDesigner.ehLayoutManager_CreateReport(Sender, aParameters: TObject);
var
  lEventParams: TppCreatReportEventParams;
  lReport: TObject;
begin
  lEventParams := TppCreatReportEventParams(aParameters);
  lReport := lEventParams.Report;
  if Assigned(FOnCreateReport) then FOnCreateReport(Sender, lEventParams.DataName, lReport);
  lEventParams.Report := TppCustomReport(lReport);
end;

procedure TppDesigner.ehLayoutManager_CustomOpenDoc(Sender, aParameters: TObject);
begin
  if Assigned(FOnCustomOpenDoc) then FOnCustomOpenDoc(Sender);
  
end;

procedure TppDesigner.ehLayoutManager_CustomSaveDoc(Sender, aParameters: TObject);
begin
  if Assigned(FOnCustomSaveDoc) then FOnCustomSaveDoc(Sender);

end;

procedure TppDesigner.ehLayoutManager_DestroyComponent(Sender, aParameters: TObject);
begin
  if Assigned(FOnDestroyComponent) then FOnDestroyComponent(Sender, TComponent(aParameters));

end;

procedure TppDesigner.ehLayoutManager_GetDataNames(Sender, aParameters: TObject);
begin
  if Assigned(FOnGetDataNames) then FOnGetDataNames(Sender, TStrings(aParameters));
end;

procedure TppDesigner.ehLayoutManager_GetDisplayFormats(Sender, aParameters: TObject);
var
  lEventParams: TppGetDisplayFormatsEventParams;
begin
  lEventParams := TppGetDisplayFormatsEventParams(aParameters);
  if Assigned(FOnGetDisplayFormats) then FOnGetDisplayFormats(lEventParams.Component, lEventParams.DisplayFormats);
end;

procedure TppDesigner.ehLayoutManager_GetFields(Sender, aParameters: TObject);
var
  lEventParams: TppGetFieldsEventParams;
begin
  lEventParams := TppGetFieldsEventParams(aParameters);
  if Assigned(FOnGetFields) then FOnGetFields(Sender, lEventParams.DataName, lEventParams.FieldList);
end;

procedure TppDesigner.ehLayoutManager_GetFieldAliases(Sender, aParameters: TObject);
var
  lEventParams: TppGetFieldAliasesEventParams;
begin
  lEventParams := TppGetFieldAliasesEventParams(aParameters);
  if (FFieldAliases <> nil) then
    lEventParams.FieldAliases := FFieldAliases;
end;

procedure TppDesigner.ehLayoutManager_ReportDestroy(Sender, aParameters: TObject);
begin

  if (aParameters = FReport) then
    FReport := nil;

end;

procedure TppDesigner.ehLayoutManager_ReportSelected(Sender, aParameters: TObject);
begin
  if Assigned(FOnReportSelected) then FOnReportSelected(Sender);
end;

procedure TppDesigner.ehLayoutManager_TabChange(Sender, aParameters: TObject);
var
  lEventParams: TppTabChangeEventParams;
  lbAllowChange: Boolean;
  lsPageCaption: String;
begin
  lEventParams := TppTabChangeEventParams(aParameters);
  lbAllowChange := lEventParams.AllowChange;
  lsPageCaption := FDesignerWindow.Notebook.Captions[lEventParams.TabIndex];
  if Assigned(FOnTabChange) then FOnTabChange(Sender, lsPageCaption, lbAllowChange);
  lEventParams.AllowChange := lbAllowChange;
end;

procedure TppDesigner.ehLayoutManager_TabChanged(Sender, aParameters: TObject);
begin
  if Assigned(FOnTabChanged) then FOnTabChanged(Sender);
end;

procedure TppDesigner.ehLayoutManager_ValidateComponent(Sender, aParameters: TObject);
var
  lEventParams: TppValidateComponentEventParams;
  lbValid: Boolean;
begin
  lEventParams := TppValidateComponentEventParams(aParameters);
  lbValid := True;
  if Assigned(FOnValidateComponent) then FOnValidateComponent(Sender, TppComponent(lEventParams.Component), lbValid);
  lEventParams.IsValid := lbValid;
end;


{@TppDesigner.Show
 The Show method makes the designer visible by setting its Visible property to
 True. If the Show method of a form is called and the form is somehow obscured,
 Show tries to make the form visible by bringing it to the front with the
 BringToFront method.}

procedure TppDesigner.Show;
begin

  if (GetDesignerWindow <> nil) then
    FDesignerWindow.Show;

end;


{@TppDesigner.ShowModal
 The ShowModal method makes a form the active form, just like Show, but also
 makes the form modal; therefore the user must put the form away before the
 application can continue to run.}

procedure TppDesigner.ShowModal;
begin

  if (GetDesignerWindow <> nil) then
    begin

//OB      FDesignerWindow.DesignerState := FDesignerWindow.DesignerState + [dsModal];

      try
        FDesignerWindow.ShowModal;
      finally
//OB          FDesignerWindow.DesignerState := FDesignerWindow.DesignerState - [dsModal];
      end;

    end;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.ShowInPanel
  Displays the designer inside a panel. Use the aParent parameter to specify the
  parent WinControl.}

procedure TppDesigner.ShowInPanel(aParent: TWinControl);
begin

  if (aParent <> nil) and (GetDesignerWindow <> nil) then
    begin
      FDesignerWindow.Parent := aParent;
      FDesignerWindow.BorderStyle := bsNone;
      FDesignerWindow.Align := alClient;
      FDesignerWindow.Show;
    end;


end;



{@TppDesigner.Hide
 The Hide method makes the designer invisible by setting the Visible property of
 the form to False. Although a form or control that is hidden is not visible,
 you can still set the properties of the form or control, or call its methods.}

procedure TppDesigner.Hide;
begin
  if (FDesignerWindow <> nil) then
    FDesignerWindow.Hide;
end;


{------------------------------------------------------------------------------}
{ TppDesigner.UpdateDocHistory }

procedure TppDesigner.UpdateDocHistory(aTemplate: TppTemplate);
begin

  if (FDesignerWindow <> nil) then
   FDesignerWindow.LayoutManager.ToolManager.Menubar.FileMenu.MRUItems.AddTemplateItem(aTemplate);

end; {procedure, UpdateDocHistory}



{@TppDesigner.Invalidate
 The Invalidate method method forces the designer window to repaint as soon as
 possible.}

procedure TppDesigner.Invalidate;
begin
  if (FDesignerWindow <> nil) then
    FDesignerWindow.Invalidate;
end;


{@TppDesigner.PrintReport
 The PrintReport method used to print the report being designed to the
 printer..}

procedure TppDesigner.PrintReport;
begin
  if (FDesignerWindow <> nil) then
    FDesignerWindow.PreviewManager.Viewer.Print;
end;

{------------------------------------------------------------------------------}
{ TppDesigner.SendToBack }

procedure TppDesigner.SendToBack;
begin
  if (FDesignerWindow <> nil) then
    FDesignerWindow.SendToBack;
end;


{@TppDesigner.SetBounds
 The SetBounds method sets designer boundary properties, WindowLeft, WindowTop,
 WindowWidth, and WindowHeight, to the values passed in aLeft, aTop, aWidth, and
 aHeight, respectively.}

procedure TppDesigner.SetBounds(aLeft, aTop, aWidth, aHeight: Integer);
begin
  if (FDesignerWindow <> nil) then
    FDesignerWindow.SetBounds(aLeft, aTop, aWidth, aHeight);
end;


{------------------------------------------------------------------------------}
{ TppDesigner.SetCaption }

procedure TppDesigner.SetCaption(aCaption: String);
begin
  FCaption := aCaption;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.DefaultCaption := FCaption;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetDataSettings }

procedure TppDesigner.SetDataSettings(aDataSettings: TppDataSettings);
begin

  FDataSettings.Assign(aDataSettings);

  if (FDesignerWindow <> nil) then
    FDesignerWindow.DataSettings := FDataSettings;


end;  {procedure, SetDataSettings}


{------------------------------------------------------------------------------}
{ TppDesigner.SetFormStyle }

procedure TppDesigner.SetFormStyle(aFormStyle: TFormStyle);
begin

  FFormStyle := aFormStyle;

  if (FDesignerWindow <> nil) then
    begin
      FDesignerWindow.ChangeFormStyle(aFormStyle);
      FDesignerWindow.ComponentClasses := FComponentClasses;
    end;


end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetHeight }

procedure TppDesigner.SetHeight(aHeight: Integer);
begin
  FWindowHeight := aHeight;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.Height := FWindowHeight;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetIcon }

procedure TppDesigner.SetIcon(aIcon: TIcon);
begin

  FIcon.Assign(aIcon);

  if (FDesignerWindow <> nil) then
    FDesignerWindow.Icon := FIcon;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.IconChange }

procedure TppDesigner.IconChange(Sender: TObject);
begin

  if (FDesignerWindow <> nil) then
    FDesignerWindow.Icon := FIcon;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetLeft }

procedure TppDesigner.SetLeft(aLeft: Integer);
begin
  FWindowLeft:= aLeft;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.Left := FWindowLeft;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetPosition }

procedure TppDesigner.SetPosition(aPosition: TPosition);
begin

  FPosition := aPosition;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.Position := FPosition;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetIniStorageType }

procedure TppDesigner.SetIniStorageType(aStorageType: String);
begin

  if (TppIniStoragePlugIns.GetClassForName(aStorageType) <> nil) then
    FIniStorageType := aStorageType;

  if not (csDesigning in ComponentState) then
    ConfigureIniStorage;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetIniStorageName }

procedure TppDesigner.SetIniStorageName(aStorageName: String);
begin

  FIniStorageName := aStorageName;

  if not (csDesigning in ComponentState) then
    ConfigureIniStorage;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetTop }

procedure TppDesigner.SetTop(aTop: Integer);
begin
  FWindowTop:= aTop;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.Top := FWindowTop;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetVisible }

procedure TppDesigner.SetVisible(aValue: Boolean);
begin
  FVisible := aValue;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.Visible := FVisible;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetWidth }

procedure TppDesigner.SetWidth(aWidth: Integer);
begin
  FWindowWidth := aWidth;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.Width := FWindowWidth;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetWindowState }

procedure TppDesigner.SetWindowState(aWindowState: TWindowState);
begin
  FWindowState := aWindowState;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.WindowState := aWindowState;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetWindowTag }

procedure TppDesigner.SetWindowTag(aTag: LongInt);
begin
  FWindowTag := aTag;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.Tag := aTag;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnActivate }

procedure TppDesigner.SetOnActivate(aNotifyEvent: TNotifyEvent);
begin
  FOnActivate := aNotifyEvent;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.OnActivate := FOnActivate;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnClose }

procedure TppDesigner.SetOnClose(aCloseEvent: TCloseEvent);
begin

  FOnClose := aCloseEvent;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.OnClose := FOnClose;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnCloseQuery }

procedure TppDesigner.SetOnCloseQuery(aCloseQueryEvent: TCloseQueryEvent);
begin
  FOnCloseQuery := aCloseQueryEvent;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.OnCloseQuery := FOnCloseQuery;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnDestroy }

procedure TppDesigner.SetOnDestroy(aNotifyEvent: TNotifyEvent);
begin
  FOnDestroy := aNotifyEvent;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.OnDestroy := FOnDestroy;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnDeactivate }

procedure TppDesigner. SetOnDeactivate(aNotifyEvent: TNotifyEvent);
begin
  FOnDeactivate := aNotifyEvent;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.OnDeactivate := FOnDeactivate;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetCurrentReport }

function TppDesigner.GetCurrentReport: TppCustomReport;
begin
   if (FDesignerWindow = nil) then
    Result := nil
  else
    Result := FDesignerWindow.CurrentReport;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.GetFieldAliases }

function TppDesigner.GetFieldAliases: TStrings;
begin

  if (FFieldAliases = nil) then
    FFieldAliases := TStringList.Create;

  Result := FFieldAliases;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetFieldAliases }

procedure TppDesigner.SetFieldAliases(aFieldAliases: TStrings);
begin

  GetFieldAliases.Assign(aFieldAliases);

  if (FDesignerWindow <> nil) then
    if (FFieldAliases.Count > 0) then
      FDesignerWindow.EventHub.EndUserEvents.mcAssignField.AddNotify(ehLayoutManager_AssignField)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcAssignField.RemoveNotify(ehLayoutManager_AssignField);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnAssignField }

procedure TppDesigner.SetOnAssignField(const Value: TNotifyEvent);
begin

  FOnAssignField := Value;

  if (FDesignerWindow <> nil) then
    if Assigned(FOnAssignField) then
      FDesignerWindow.EventHub.EndUserEvents.mcAssignField.AddNotify(ehLayoutManager_AssignField)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcAssignField.RemoveNotify(ehLayoutManager_AssignField);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnCreateComponent }

procedure TppDesigner.SetOnCreateComponent(const Value: TppComponentEvent);
begin

  FOnCreateComponent := Value;

  if (FDesignerWindow <> nil) then
    if Assigned(FOnCreateComponent) then
      FDesignerWindow.EventHub.EndUserEvents.mcCreateComponent.AddNotify(ehLayoutManager_CreateComponent)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcCreateComponent.RemoveNotify(ehLayoutManager_CreateComponent);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnCreateReport }

procedure TppDesigner.SetOnCreateReport(const Value: TppCreateReportEvent);
begin

  FOnCreateReport := Value;

  if (FDesignerWindow <> nil) then
    if Assigned(FOnCreateReport) then
      FDesignerWindow.EventHub.EndUserEvents.mcCreateReport.AddNotify(ehLayoutManager_CreateReport)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcCreateReport.RemoveNotify(ehLayoutManager_CreateReport);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnCustomOpenDoc }

procedure TppDesigner.SetOnCustomOpenDoc(const Value: TNotifyEvent);
begin

  FOnCustomOpenDoc := Value;

  if (FDesignerWindow <> nil) then
    if Assigned(FOnCustomOpenDoc) then
      FDesignerWindow.EventHub.EndUserEvents.mcCustomOpenDoc.AddNotify(ehLayoutManager_CustomOpenDoc)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcCustomOpenDoc.RemoveNotify(ehLayoutManager_CustomOpenDoc);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnCustomSaveDoc }

procedure TppDesigner.SetOnCustomSaveDoc(const Value: TNotifyEvent);
begin

  FOnCustomSaveDoc := Value;

  if (FDesignerWindow <> nil) then
    if Assigned(FOnCustomSaveDoc) then
      FDesignerWindow.EventHub.EndUserEvents.mcCustomSaveDoc.AddNotify(ehLayoutManager_CustomSaveDoc)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcCustomSaveDoc.RemoveNotify(ehLayoutManager_CustomSaveDoc);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnDestroyComponent }

procedure TppDesigner.SetOnDestroyComponent(const Value: TppComponentEvent);
begin

  FOnDestroyComponent := Value;

  if (FDesignerWindow <> nil) then
    if Assigned(FOnDestroyComponent) then
      FDesignerWindow.EventHub.EndUserEvents.mcDestroyComponent.AddNotify(ehLayoutManager_DestroyComponent)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcDestroyComponent.RemoveNotify(ehLayoutManager_DestroyComponent);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnGetDataNames }

procedure TppDesigner.SetOnGetDataNames(const Value: TppGetDataNamesEvent);
begin

  FOnGetDataNames := Value;

  if (FDesignerWindow <> nil) then
    if Assigned(FOnGetDataNames) then
      FDesignerWindow.EventHub.EndUserEvents.mcGetDataNames.AddNotify(ehLayoutManager_GetDataNames)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcGetDataNames.RemoveNotify(ehLayoutManager_GetDataNames);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnGetDisplayFormats }

procedure TppDesigner.SetOnGetDisplayFormats(const Value: TppGetDisplayFormatsEvent);
begin
  FOnGetDisplayFormats := Value;

  if (FDesignerWindow <> nil) then
    if Assigned(FOnGetDisplayFormats) then
      FDesignerWindow.EventHub.EndUserEvents.mcGetDisplayFormats.AddNotify(ehLayoutManager_GetDisplayFormats)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcGetDisplayFormats.RemoveNotify(ehLayoutManager_GetDisplayFormats);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnGetFields }

procedure TppDesigner.SetOnGetFields(const Value: TppGetFieldsEvent);
begin

  FOnGetFields := Value;

  if (FDesignerWindow <> nil) then
    if Assigned(FOnGetFields) then
      FDesignerWindow.EventHub.EndUserEvents.mcGetFields.AddNotify(ehLayoutManager_GetFields)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcGetFields.RemoveNotify(ehLayoutManager_GetFields);


end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnHelp }

procedure TppDesigner.SetOnHelp(aHelpEvent: TppHelpEvent);
begin

  FOnHelp := aHelpEvent;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.OnHelp := FOnHelp;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnHide }

procedure TppDesigner.SetOnHide(aNotifyEvent: TNotifyEvent);
begin

  FOnHide := aNotifyEvent;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.OnHide := FOnHide;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnReportSelected }


procedure TppDesigner.SetOnReportSelected(const Value: TNotifyEvent);
begin

  FOnReportSelected := Value;

  if (FDesignerWindow <> nil) then
    if Assigned(FOnReportSelected) then
      FDesignerWindow.EventHub.EndUserEvents.mcReportSelected.AddNotify(ehLayoutManager_ReportSelected)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcReportSelected.RemoveNotify(ehLayoutManager_ReportSelected)


end;



{@TppDesigner.SetSelection
 The SetSelection method can be used to specify which report components are
 selected. Normally the end-user controls which items are selected by clicking
 on them with the mouse. Therefore you will seldom need to use this method.

 Be aware that each time the selection changes the OnSelectionChanged event will
 fire.

 Note: TComponentList is a special kind of TList.  It is described in the Delphi
 help and in Delphi's DsgnIntf unit.}


procedure TppDesigner.SetSelection(aSelection: TppDesignerSelectionList);
begin

  if (FDesignerWindow <> nil) then
    FDesignerWindow.SelectionChanged(aSelection);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnResize }

procedure TppDesigner.SetOnResize(aNotifyEvent: TNotifyEvent);
begin

  FOnResize := aNotifyEvent;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.OnResize := FOnResize;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnSelectionChangedd }

procedure TppDesigner.SetOnSelectionChanged(aSetSelectionEvent: TppSetSelectionEvent);
begin

  FOnSelectionChanged := aSetSelectionEvent;

  if (FDesignerWindow <> nil) then
    FDesignerWindow.OnSetSelection := FOnSelectionChanged;

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnTabChange }

procedure TppDesigner.SetOnTabChange(const Value: TppTabChangeEvent);
begin

  FOnTabChange := Value;

  if (FDesignerWindow <> nil) then
    if Assigned(FOnTabChange) then
      FDesignerWindow.EventHub.EndUserEvents.mcTabChange.AddNotify(ehLayoutManager_TabChange)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcTabChange.RemoveNotify(ehLayoutManager_TabChange);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnTabChanged }

procedure TppDesigner.SetOnTabChanged(const Value: TNotifyEvent);
begin

  FOnTabChanged := Value;

  if (FDesignerWindow <> nil) then
    if Assigned(FOnTabChanged) then
      FDesignerWindow.EventHub.EndUserEvents.mcTabChanged.AddNotify(ehLayoutManager_TabChanged)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcTabChanged.RemoveNotify(ehLayoutManager_TabChanged);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.SetOnValidateComponent }

procedure TppDesigner.SetOnValidateComponent(const Value: TppValidateComponentEvent);
begin

  FOnValidateComponent := Value;

  if (FDesignerWindow <> nil) then
    if Assigned(FOnValidateComponent) then
      FDesignerWindow.EventHub.EndUserEvents.mcValidateComponent.AddNotify(ehLayoutManager_ValidateComponent)
    else
      FDesignerWindow.EventHub.EndUserEvents.mcValidateComponent.RemoveNotify(ehLayoutManager_ValidateComponent);


end;


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  RegisterClasses([TppDesigner]);

finalization

  UnRegisterClasses([TppDesigner]);

end.

