{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit ppProd;

interface

{$I ppIfDef.pas}

uses                      
  Windows,
  SysUtils,                                             
  Classes,
  Controls,
  Graphics,
  Forms,
  Dialogs,
  ExtCtrls,

  ppRelatv,
  ppComm,
  ppTypes,
  ppUtils,
  ppForms,
  ppDevice,
  ppFilDev,
  ppPrnDev,
  ppPrintr,
  ppRTTI,
  ppPreviewFormSettings,
  ppTextSearchSettings,
  ppBackgroundPrintSettings,
  ppPDFSettings,
  ppRTFSettings,
  ppXLSSettings,
  ppEmailSettings;

type

  {@TppProducer

    The ancestor from which all components which must manage the print process
    descend.

    There are currently three descendants which implement Producer functionality:

            - TppArchiveReader
            - TppReport
            - TppClientReport}

  {@TppProducer.AfterPrint

    This event fires after the print process has been completed.  When printing
    to the printer or to the file, AfterPrint fires after the print job has been
    closed or after the file has been closed.  When printing to the screen,
    AfterPrint fires after the Print Preview form has been closed.

    Note: BeforePrint, AfterPrint, and OnPrintingComplete fire only when the
    Print method is used to print the report.}

  {@TppProducer.AfterEmail

    This event fires after an email has been sent either by calling the
    TppReport.SendMail routine or by selecting to send an email from the
    previewer.

    Use the AfterEmail event to determine when an email has been sent. }

  {@TppProducer.AllowPrintToArchive

    If this property is set to True, then printing to an archive file will be an
    option when the Print Dialog is displayed.}

  {@TppProducer.AllowPrintToFile

    If this property is set to True, then printing the report to a text file
    will be an option when the Print Dialog is displayed.}

  {@TppProducer.ArchiveFileName

    The name of the file to which output should be directed when printing to an
    archive.

    The AllowPrintToArchive property is must be set to True in order for the
    user to print the report to an archive file. The Print Dialog allows the
    user to specify whether or not the report should go to an archive and to
    change the name of the archive file. If AllowPrintToArchive is set to False,
    the Print Dialog will not display the Print to Archive option.}

  {@TppProducer.BackgroundPrintSettings

    Use background printing in order to print a report in a background thread so
    that the main application can continue execution while the report is
    generating to the desired output device.

    This property is only applicable at runtime.

    Autosearch is supported in background printing. When the report
    is executed from the main application with autosearch criteria values,
    either created with DADE or manually in Delphi code, then the report
    is printed in the background using the same autosearch criteria values
    that were entered in the autosearch dialog from the main application.

    Background printing supports the printer device, archive device as well as
    other file output devices including add on devices.
    An EBackgroundPrintError is raised when attempting to print a report in
    the background to the screen device as this is not supported.

    In order to support background printing, you must first make the owner
    container (TForm or TDatamodule) threadsafe. To ensure that the data
    access components are threadsafe, add the applicable database session
    component and set AutoSessionName to true. For example, when using the BDE
    and the BDE data access components, add a TSession object to the form or
    datamodule and set Session.AutoSessionName to True.

    All objects and data access components the report relies on to execute must
    reside on the form or data module where the report is located. In order to
    determine if your report can be made to execute safely in a background thread,
    make sure that the form does not rely on objects from other units in the
    project. Any references to objects in other units of your project, which
    are called from the container to support report generation, are not
    supported when generating the report in a background thread.

    Background printing also requires that no forms be shown in your report's
    event handlers. This includes the Report as well.
    The Report's ShowAutosearchDialog and ShowCancelDialog
    properties are set to False for the report which is executing in the
    background thread. The autosearch values are transferred from the
    the report which is executing in the main application thread so that the
    autosearch dialog isn't shown inside of the background thread.
    Any add-on devices which have the capability to show custom forms,
    also must have these options turned off. For example, in the Pragnaan
    PDF device, the two properties ShowProgress and ShowSetupDialog
    must be set to false on the device in order to execute the report
    in the background thread.

    The approach which prints the report in the background is best described
    as taking a snapshot of all of the report's property
    values and settings at the time of the report is about to begin
    generating pages inside of the Report.Print method call.
    A new instance of the container form or datamodule
    is created in a background thread. The snapshot of the report is
    reproduced in the conatainer. This includes all autosearch criteria
    values and all the print settings of the printer setup or from the
    configuration of the page request using the printer setup dialog which
    is shown in the main application thread. The event handlers connected to the
    report and its components will fire inside the background thread's container
    and be handled inside the container's event handlers.

    If you want to use the autosearch dialog to enter criteria solely
    for printing to the printer, then set the Report DeviceType to Printer.
    This allows you to call Report.Print, which begins the process to generate
    the report for the printer without showing a screen preview.
    This sequence of steps executes in the main thread, so the Autosearch
    dialog can be shown in the main thread based on the ShowAutosearchDialog
    property. The print dialog can be shown giving the option to print to the background,
    based on the ShowPrintDialog property. The report is able print to the printer
    in the background, using the autosearch criteria that is entered in the
    autosearch dialog and also the page request configuration that is set in
    the print dialog. It is also possible to not show the autosearch dialog and
    assign the autosearch values directly on the Report.AutosearchFields array
    property as you normally would using the Report.CreateAutosearchField method.}

  {@TppProducer.BeforePrint

    This event fires before the print process begins.

    Note: BeforePrint, AfterPrint, and OnPrintingComplete fire only when the
    Print method is used to print the report.}

  {@TppProducer.BeforeEmail

    This event fires before an email is sent either by making a call to the
    TppReport.SendMail routine or selecting the email button in the previewer.

    Use the BeforeEmail event to make changes to the EmailSettings or to
    determine if the user has selected to email a report. }

  {@TppProducer.CancelDialog

    When the report is printing to the printer or to a file, then this dialog is
    displayed to show the print progress.

    If ShowCancelDialog is set to False, then this dialog is not be displayed.}

  {@TppProducer.Converted

    Whether or not the report was converted from an older version of
    ReportBuilder when it was loaded.}

  {@TppProducer.CurrentPage

    This property is used to support the current page option of the Print
    Dialog.  When printing the report to a printer or to a file from within the
    Print Preview form, this property is set to the page currently being
    previewed.

    Defaults to 1.}

  {@TppProducer.Device

    Use the DeviceType property. This property discontinued as of version 4.0.

    It is replaced by the DeviceType property.}

  {@TppProducer.DeviceType

    The DeviceType property determines where output goes when the Print method
    is called. ReportBuilder defines the following constants which are declared
    in the ppTypes unit:

    <Table>
    Value	           Meaning
    -----------      ---------
    dtPrinter	       The Print Dialog is displayed and then output is directed
                     to the printer specified in the PrinterSetup property.
    dtScreen	       The Print Preview form is created and the first page of
                     the report is sent to the Viewer component of this form.
    dtPDF            The Print Dialog is displayed and then output is
                     directed to the file specified in the TextFileName
                     property.
    dtTextFile	     The Print Dialog is displayed and then output is
                     directed to the file specified in the TextFileName
                     property.
    dtReportTextFile The Print Dialog is displayed and then output is
                     directed to the file specified in the TextFileName
                     property.
    dtArchive	       The Print Dialog is displayed and then output is directed
                     to the file specified in the ArchiveFileName property.
    </Table>

    When assigning the value of the DeviceType programatically, you can use the
    following constants, which are declared in the ppTypes unit:
    dtPrinter, dtScreen, dtTextFile, dtReportTextFile, dtArchive.

    Additional device types may be specified if you have installed additional
    devices using the ppRegisterDevice routine.}

  {@TppProducer.DefaultFileDeviceType

    Defines the default file device to be used when exporting a report to file.
    When a report is printed, and the AllowPrintToFile and/or
    AllowPrintToArchive property is set to True, the print dialog will display
    its Print to File section near the bottom of the form.  This property
    controls the default value of the combobox displaying the file device names.

    Note that this property only affects the combobox if the DeviceType
    property is set to a non-file device such as "Screen" or "Printer".  If the
    DeviceType property is set to a file device type, it will take precedence
    over this property and the print dialog will default to that device.}

  {@TppProducer.Email

   Provides access to the email object that is used when emailing a report.
   Use this property to access the OnStatusChanged and OnEmailError events of
   the SMTP object.
   <CODE>

      uses
        ppEmail;

      begin
        TppEmail(Report.Email).SMTP.OnEmailError := EmailErrorEvent;
        Report.SendMail;

      end;

    </CODE>}

  {@TppProducer.EmailSettings

    Settings needed to send a report as an attachement inside an email message.
    See the TppEmailSettings topic for information on each sub property. }

  {@TppProducer.FileDevice

   Read only. Provides access to the file device object that is created when
   printing a report to a file. This property returns nil, unless a file
   device has been created. Use the Report.BeforePrint event to access this
   property. You can use the Delphi 'is' operator to determine whether the
   TppFileDevice is a TppArchiveDevice, TppTextFileDevice, etc. }

  {@TppProducer.Icon

    This property allows you to control the icon that is displayed in the
    built-in Print Preview window.  Simply specify an icon, and it will be
    assigned to the Print Preview form when the report prints.}

  {@TppProducer.LanguageID

    The LanguageID property determines the language that will be used
    throughout the user interface.

    ReportBuilder includes 12 built-in language translations including the
    following...

    Danish (Denmark)
    Dutch (Netherlands)
    English (United States)
    French (France)
    German (Germany)
    Italian (Italy)
    Portuguese (Brazil)
    Portuguese (Portugal)
    Norwegian (Norway)
    Spanish (Mexico)
    Spanish (Spain)
    Swedish (Sweden)

    These translations must be installed with the product in order to be used.

    Note: A special language translation application is available upon request
    from Digital Metaphors. This application contains screen shots that show
    exactly where each string is used, allows numerous new translations to be
    entered, and generates the required .RC files once the translation is
    complete. This application can greatly speed the creation of new
    translations. Write info@digital-metaphors.com to receive a copy.

    If your language is not directly supported, you can add your own
    translation. For more information see Deploying Your Own Translation.}

  {TppProducer.Language

    <Deprecated>

    The language property determines the language that will be used throughout
    the user interface.

    <Table>
    Value	               Meaning
    --------------       ---------
    lgCustom             If your language is not supported directly, use this
                         type to create a new translation.
    lgDanish	           Messages are displayed in Danish
    lgDutch	             Messages are displayed in Dutch
    lgEnglish	           Messages are displayed in English.
    lgFrench	           Messages are displayed in French
    lgGerman	           Messages are displayed in German
    lgItalian	           Messages are displayed in Italian
    lgPortugueseBrazil	 Messages are displayed in brasilian Portuguese.
    lgPortuguese	       Messages are displayed in Portuguese.
    lgNorwegian	         Messages are displayed in Norwegian
    lgSpanish	           Messages are displayed in Spanish
    lgSwedish	           Messages are displayed in Swedish
    </Table>

    Note: A special language translation application is available upon request
    from Digital Metaphors. This application contains screen shots that show
    exactly where each string is used, allows a new translation to be entered,
    and generates the required .RC files once the translation is complete. This
    application can greatly speed the creation of new translations. Write
    info@digital-metaphors.com to receive a copy.

    If your language is not directly supported, you can add your own
    translation. For more information see Deploying Your Own Translation.}

  {@TppProducer.LanguageIndex

    Run-time and read only. This value is derived from the value of the Language
    property. It is the base number for the currently selected language, and is
    used when calling the LoadStr method to load strings from the ppLang.res
    file.}

  {@TppProducer.ModalCancelDialog

    When the report is sent to the printer, this property determines whether the
    Cancel Dialog is modal.}

  {@TppProducer.ModalPreview

    When the report is sent to the screen, this property determines whether the
    Print Preview form is modal.}

  {@TppProducer.OnCancel

    This event fires when the user has cancelled the print process.}

  {@TppProducer.OnCancelDialogClose

    This event fires when the Cancel Dialog is closed. This dialog is closed
    either when the user clicks the Cancel button, or when the printing process
    is complete.  The Cancel Dialog is only displayed when printing to the
    printer or to a file.}

  {@TppProducer.OnCancelDialogCreate

    This event fires after the cancel dialog has been created.  You can access
    the Cancel dialog via the CancelDialog property.}

  {@TppProducer.OnFileDeviceCreate

    This event fires after a FileDevice has been created.  You can access
    the FileDevice via the FileDevice property. You can typecast the FileDevice
    and to configure its properties. Example:

    <CODE>
      uses
        ppPDFDevice;

      var
        lPDFDevice: TppPDEFDevice;

      begin
        if (myReport.FileDevice is TppPDFDevice) then
          begin
             lPDFDevice := TppPDFDevice(myReport.FileDevice);

             // add code here to configure PDFDevice properties...

          end;

      end;


    </CODE>}

  {@TppProducer.OnPageRequest

    This event fires after the Print method has been called and all of the
    currently connected devices have been polled for the pages of the report
    which are needed.  The result of this polling process is summarized by the
    Publisher into one PageRequest object, which is then passed to the Producer.
    The Producer then attempts to supply the requested pages, either by running
    the report engine (as in the case of CustomReport producers), or by
    searching the archive file (as in the case of ArchiveReader prodcers).}

  {@TppProducer.OnPreviewFormClose

    This event fires after the Print Preview form is closed. The Print Preview
    form is only created when the DeviceType has been set to dtScreen and the
    Print method has been called.}

  {@TppProducer.OnAssignPreviewFormSettings

    This event fires to support the setting of the TppPreviewFormSettings
    and the TppTextSearchSettings before the values are
    assigned to the preview form.  Provides the proper timing to assign them
    new values before they are transferred to the preview form.

    Use the OnPreviewFormCreate to control the dialog properties directly, as
    the OnPreviewFormCreate event fires after the settings have been
    transferred.}

  {@TppProducer.OnPreviewFormCreate

    This event fires after the Print Preview form has been created.  You can
    access the Print Preview form via the PreviewForm property.

    You can set the characteristics of the Print Preview form and of the Viewer
    component. For example, the following code sets the Print Preview form to
    maximized and sets the Viewer ZoomSetting to page width.

      ppReport1.PreviewForm.WindowState := wsMaximized;

      TppViewer(ppReport1.PreviewForm.Viewer).ZoomSetting := zs100Percent;

    Note: Make sure you put ppTypes in the uses clause of your unit so that the
    ZoomSetting enumerated type is recognized by the compiler.}

  {@TppProducer.OnPrinterDeviceCreate

    This event fires after a PrinterDevice has been created.  You can access
    the PrinterDevice via the PrinterDevice property.}

  {@TppProducer.OnPrinterDeviceStateChange

    The PrinterDevice fires this event while sending pages to the printer.
    One use of this event is to enable printer escape codes to be sent
    directly to the printer.

    The Report.PrinterDevice is created when sending pages to a printer. The
    aDeviceState parameter is of type TppDeviceStateType - an enumerated type
    declared in the ppTypes unit.

    <TABLE>

    DeviceState         Timing
    -----------------   --------------------------
    dsBeforeStartJob      Before print job starts
    dsAfterStartJob       After print job starts
    dsBeforeStartPage     Before page starts
    dsAfterStartPage      After page starts
    dsBeforeEndPage       Before page ends
    dsAfterEndPage        After page ends
    dsBeforeEndJob        Before print job ends
    dsAfterEndJob         After print job ends
    dsBeforeDrawCommand   Before a draw command is rendered
    dsAfterDrawCommand    After a draw command is rendered

    </TABLE>

    Code example:

    <CODE>
      uses
        ppTypes;

      procedure Form1.ppReport1OnPrinterDeviceStateChange(Sender: TObject; aStateChange: TppDeviceStateChangeType);
      begin
        if (aStateChange = dsAfterStartPage) then
          ppReport1.SendEscape('some escape code here');

      end;
    </CODE>

    }

  {@TppProducer.OnPrintDialogClose

    This event fires after the Print Dialog has closed. You can access the Print
    Dialog via the PrintDialog property.}

  {@TppProducer.OnPrintDialogCreate

    This event fires after the Print Dialog has been created.  You can access
    the Print Dialog via the PrintDialog property.}

  {@TppProducer.OnPrintingComplete

    This event fires after the print process is complete.}

  {@TppProducer.OnSaveText

    The OnSaveText event fires before a textual component is written to the line
    of text by the TextFileDevice. Any modifications made to the Text parameter
    will be saved to the line. This event only fires when printing to a text
    file.

    Note: The Sender is always the TextFileDevice responsible for creating the
    text file.}

  {@TppProducer.PDFSettings

    The PDF settings control the options for the PDF Device for exporting a
    Report to PDF. See TppPDFSettings for more information on the individual
    settings. }

  {@TppProducer.PreviewForm

    Run-time and read-only.  When a report is being previewed with the built-in
    preview form, this property contains a reference to the preview form.  This
    property is most often accessed in the OnAssignPreviewFormSettings
    event in order to set various preview form properties.}

  {@TppProducer.PreviewFormSettings

    The preview form settings control the preview form window state, zoom
    setting, and zoom percentage. These settings can be overridden at runtime
    by configuring the preview form settings on the viewer object in the
    OnPreviewFormCreate event.}

  {@TppProducer.PrintDialog

    Run-time and read-only.  When a report is being printed to the printer or to
    a file, this property contains a reference to the print dialog.  This
    property is most often accessed in the OnPrintDialogClose event in order to
    detect various printer settings.}

  {@TppProducer.Printer

    Pointer to a printer object that has been configured based on the values in
    the PrinterSetup property.}

  {@TppProducer.PrinterDevice

   Read only. Provides access to the printer device object that is created when
   printing a report to the printer. This property returns nil, unless a printer
   device has been created. Use the Report.BeforePrint event to access this
   property.}

  {@TppProducer.PrinterSetup

    This property allows you to select the printer, paper size, orientation, and
    paper bin which should be used when printing the report. When the report is
    done printing, the printer is restored to its former settings.

    If you want a report to use the current windows printer, set the PrinterName
    property to 'Current'.}

  {@TppProducer.Printing

    Run-time and read only. This property indicates when a report is in the
    process of printing to any device. Use the Device property to determine the
    type of device to which the print job is currently directed.}

  {@TppProducer.Publisher

    Run-time and read-only. Contains a pointer to the Publisher object used by
    the producer.}

  {@TppProducer.RTFSettings

    Contains settings used to control the creation of Richtext documents.  See
    the help topic for TppRTFSettings for more information. }

  {@TppProducer.SavePrinterSetup

    Defaults to False. This property determines whether any printer setttings
    selected by the user from the Print Dialog are retained, or whether the
    original settings are restored after the Print method of the report object
    has been called.

    Note: Printer settings retained via SavePrinterSetup last only for the
    current instance of the report object.  If the report is freed and reloaded
    or if the application is exited and re-run, the printer settings will once
    again reflect the state as specified by the developer at design-time.}

  {@TppProducer.ShowAutoSearchDialog

    Determines whether or not the AutoSearchDialog will be displayed before the
    report is generated.}

  {@TppProducer.ShowCancelDialog

    Determines whether the Print Dialog will be displayed while printing to the
    printer or to a file.}

  {@TppProducer.ShowPrintDialog

    Determines whether the Print Dialog will be displayed while printing to the
    printer or to a file.}

  {@TppProducer.TextFileName

    The name of the file to which output should be directed when printing to a
    text file.

    If the AllowPrintToFile property is set to True, the user can change the
    name of this file at run-time from the Print Dialog.}

  {@TppProducer.TextFileType

    The TextFileType property determines format of the file when printing to a
    text file.

    <Table>
    Value	           Meaning
    ------------     ----------
    ftComma     	   Comma delimited file
    ftTab	           Tab delimited file.
    ftFixedLength	   Fixed Length records, each textual component is saved
                     with the length specified in the SaveLength property.
    ftCustom	       No delimiters or carriage return line-feeds are
                     provided. The textual components are streamed together
                     unless you use the OnSave event to add formatting.
    </Table>}

  {@TppProducer.TextSearchSettings

    Controls the options in the print preview form for text searching in the
    preview form's pages. See the TppTextSearchSettings topic for more
    information on the different settings. These settings can be overridden
    at runtime by configuring this property in the OnAssignPreviewFormSettings
    event.}

  {@TppProducer.Version

    The current version of the report in the form of a string (i.e.,
    'ReportBuilder 3.01').}

  {@TppProducer.VersionNo

    The version of the report in thousands (i.e., if the Version is
    'ReportBuilder 3.01' then the VersionNo would be 3010).  This property is
    used in order to determine whether a report needs to be converted from an
    old format.}

  {@TppProducer.XLSSettings

    Contains settings used to control the creation of XLS documents.  See
    the help topic for TppXLSSettings for more information. }


  TppProducer = class(TppRelative)
    private
      FAllowPrintToArchive: Boolean;
      FAllowPrintToFile: Boolean;
      FArchiveFileName: String;
      FBackgroundPrintSettings: TppBackgroundPrintSettings;
      FBeforePrintTriggered: Boolean;
      FCancelDialog: TppCustomCancelDialog;
      FConverted: Boolean;
      FCurrentPage: Longint;
      FDeviceType: String;
      FDefaultFileDeviceType: String;
      FEmailSettings: TppEmailSettings;
      FEmail: TObject;
      FEnableProcessMessages: Boolean;
      FFileDevice: TppFileDevice; {used for text files, archiving, and PDF}
      FIcon: TIcon;
      FInitialized: Boolean;
      FLanguage: TppLanguageType;
      FLanguageID: String;
      FLanguageIndex: Longint;
      FModalCancelDialog: Boolean;
      FModalPreview: Boolean;
      FOriginalPrinterSetup: TppPrinterSetup;
      FPDFSettings: TppPDFSettings;
      FRTFSettings: TppRTFSettings;
      FPreviewForm: TppCustomPreviewer;
      FPreviewFormSettings: TppPreviewFormSettings;
      FPrintCancelled: Boolean;
      FPrinterDevice: TppPrinterDevice;
      FPrinterSetup: TppPrinterSetup;
      FPrintDialog: TppCustomPrintDialog;
      FPrinting: Boolean;
      FPrinter: TppPrinter;
      FProducing: Boolean;
      FPublisher: TppPublisher;
      FResetEngineAfterPrinting: Boolean;
      FSavePrinterSetup: Boolean;
      FShowAutoSearchDialog: Boolean;
      FShowCancelDialog: Boolean;
      FShowPrintDialog: Boolean;
      FTextFileName: String;
      FTextFileType: TppFileType;
      FVersion: String;
      FVersionNo: Integer;

      {retained for backward compatibility}
      FDevice: TppDeviceType;

      {events}
      FAfterPrint: TNotifyEvent;
      FBeforePrint: TNotifyEvent;
      FOnCancel: TNotifyEvent;
      FOnCancelDialogCreate: TNotifyEvent;
      FOnCancelDialogClose: TNotifyEvent;
      FOnPageRequest: TppPageRequestEvent;
      FOnAssignPreviewFormSettings: TNotifyEvent;
      FOnPreviewFormCreate: TNotifyEvent;
      FOnPreviewFormClose: TNotifyEvent;
      FOnPrintDialogCreate: TNotifyEvent;
      FOnPrintDialogClose: TNotifyEvent;
      FOnSaveText: TppSaveTextEvent;
      FOnPrintingComplete: TNotifyEvent;
      FBeforeEmail: TNotifyEvent;
      FAfterEmail: TNotifyEvent;

      {used to convert pre 4.0 reports during a print run}
      FConvertedFromPre40: Boolean;
      FModalException: TObject;
      FOnFileDeviceCreate: TNotifyEvent;
      FOnPrinterDeviceCreate: TNotifyEvent;
      FOnPrinterDeviceStateChange: TppPrinterDeviceStateChangeEvent;
      FWaitForTimer: Boolean;
      FTimer: TTimer;

      FTextSearchSettings: TppTextSearchSettings;
      FXLSSettings: TppXLSSettings;

      function IsFileDevice(aDeviceName: String): Boolean;
      procedure ConvertedFromPre40TimerEvent(Sender: TObject);
      procedure ConvertedFromPre40Print(aPrintToDevices: Boolean);

      {property handling routines}
      procedure SetAllowPrintToArchive(Value: Boolean);
      procedure SetAllowPrintToFile(Value: Boolean);
      procedure SetArchiveFileName(aFileName: String);
      procedure SetEmailSettings(aEmailSettings: TppEmailSettings);
      procedure SetIcon(aIcon: TIcon);
      procedure SetModalCancelDialog(Value: Boolean);
      procedure SetModalPreview(Value: Boolean);
      procedure SetPDFSettings(aPDFSettings: TppPDFSettings);
      procedure SetRTFSettings(aRTFSettings: TppRTFSettings);
      procedure SetPrinterSetup(aPrinterSetup: TppPrinterSetup);
      procedure SetPreviewFormSettings(aSettings: TppPreviewFormSettings);
      procedure SetShowCancelDialog(Value: Boolean);
      procedure SetShowPrintDialog(Value: Boolean);
      procedure SetTextFileType(aFileType: TppFileType);
      procedure SetTextFileName(aFileName: String);
      procedure SetBackgroundPrintSettings(aBackgroundPrintSettings: TppBackgroundPrintSettings);
      procedure SetTextSearchSettings(aTextSearchSettings: TppTextSearchSettings);

      {production related}
      function  CreateCancelDialog: TppCustomCancelDialog;
      function  CreatePreviewForm: TppCustomPreviewer;
      procedure FinalizePrintToPrinter;
      procedure PrintToPrinter;
      procedure PrintToScreen;

      {form event handlers}
      procedure CancelDialogShowModalEvent(Sender: TObject);
      procedure CancelDialogCancelEvent(Sender: TObject);
      procedure CancelDialogCloseEvent(Sender: TObject);
      procedure PreviewFormActivateEvent(Sender: TObject);
      procedure PreviewFormCloseEvent(Sender: TObject);
      procedure PreviewFormDestroyEvent(Sender: TObject);
      procedure TextDeviceSaveEvent(aTextDevice: TObject; aComponent: TObject; var Text: String); virtual;

      procedure PreviewFormSettingsChangeEvent(Sender: TObject);
      procedure SettingsToPreviewForm;

      {printer setup handlers}
      function  GetPrinter: TppPrinter;
      procedure PrinterSetupGetPrinterEvent(Sender: TObject; var aPrinter: TppPrinter);

      {support version property}
      procedure ReadVersion(Reader: TReader);
      procedure WriteVersion(Writer: TWriter);

      {eat the old device property}
      procedure ReadDevice(Reader: TReader);

      {eat the old language property}
      procedure ReadLanguage(Reader: TReader);
      function  ConvertLanguage(aLanguageName: String): String;
      procedure SetXLSSettings(const Value: TppXLSSettings);
    protected
      class function AppearsOnDelphiPalette: Boolean; override;

      {supports 'fake' version property}
      procedure DefineProperties(Filer: TFiler); override;

      procedure InitializeReport; virtual;
      procedure PublishReport; virtual;
      procedure FinalizeReport; virtual;

      function  CreatePrintDialog: TppCustomPrintDialog; virtual;

      procedure SetEnableProcessMessages(aValue: Boolean);  virtual;
      function  HasEmailGroups: Boolean; virtual;

      {event triggers}
      procedure DoAfterPrint; virtual;
      procedure DoBeforePrint; virtual;
      procedure DoOnCancel; virtual;
      procedure DoOnCancelDialogCreate; virtual;
      procedure DoOnCancelDialogClose; virtual;
      procedure DeviceCreated(aDevice: TppDevice); virtual;
      procedure DoOnPageRequest(Sender: TObject; aPageRequest: TObject); virtual;
      procedure DoOnAssignPreviewFormSettings; virtual;
      procedure DoOnFileDeviceCreate; virtual;
      procedure DoOnPreviewFormCreate; virtual;
      procedure DoOnPreviewFormClose; virtual;
      procedure DoOnPrintDialogCreate; virtual;
      procedure DoOnPrintDialogClose; virtual;
      procedure DoOnPrinterDeviceCreate; virtual;
      procedure DoOnPrintingComplete; virtual;
      procedure DoOnSaveText(aTextDevice: TppTextFileDevice; var aText: String); virtual;
      procedure DoBeforeEmail; virtual;
      procedure DoAfterEmail; virtual;
      procedure ehPrinterDevice_StateChange(aCommunicator: TppCommunicator; aParams: TraParamList);
      function  FireAfterPrint: Boolean; virtual;
      procedure LanguageChanged; virtual;
      procedure PrinterSetupChanged; virtual;
      procedure PageDefChanged; virtual;
      procedure SetDevice(aDevice: TppDeviceType); virtual;
      procedure SetDeviceType(const aDeviceName: String); virtual;
      procedure SetDefaultFileDeviceType(const aFileDeviceType: String); virtual;
      procedure SetLanguage(aLanguageType: TppLanguageType); virtual;
      procedure SetLanguageID(aLanguageID: String); virtual;

      {printer setup handlers}
      procedure PrinterSetupChangeQueryEvent(Sender: TObject; aNewPageDef: TObject; var CanChange: Boolean); virtual;
      procedure PrinterSetupPageDefChangeEvent(Sender: TObject); virtual;
      procedure PrinterSetupPrintJobChangeEvent(Sender: TObject); virtual;

      {event properties}
      property AfterPrint: TNotifyEvent read FAfterPrint write FAfterPrint;
      property BeforePrint: TNotifyEvent read FBeforePrint write FBeforePrint;
      property OnAssignPreviewFormSettings: TNotifyEvent read FOnAssignPreviewFormSettings write FOnAssignPreviewFormSettings;
      property OnCancel: TNotifyEvent read FOnCancel write FOnCancel;
      property OnCancelDialogClose: TNotifyEvent read FOnCancelDialogClose write FOnCancelDialogClose;
      property OnCancelDialogCreate: TNotifyEvent read FOnCancelDialogCreate write FOnCancelDialogCreate;
      property OnPageRequest: TppPageRequestEvent read FOnPageRequest write FOnPageRequest;
      property OnPreviewFormClose: TNotifyEvent read FOnPreviewFormClose write FOnPreviewFormClose;
      property OnPreviewFormCreate: TNotifyEvent read FOnPreviewFormCreate write FOnPreviewFormCreate;
      property OnPrintDialogClose: TNotifyEvent read FOnPrintDialogClose write FOnPrintDialogClose;
      property OnPrintDialogCreate: TNotifyEvent read FOnPrintDialogCreate write FOnPrintDialogCreate;
      property OnPrintingComplete: TNotifyEvent read FOnPrintingComplete write FOnPrintingComplete;
      property OnSaveText: TppSaveTextEvent read FOnSaveText write FOnSaveText;
      property BeforeEmail: TNotifyEvent read FBeforeEmail write FBeforeEmail;
      property AfterEmail: TNotifyEvent read FAfterEmail write FAfterEmail;

    public
      constructor Create(aOwner: TComponent); override;
      destructor  Destroy; override;

      procedure Loaded; override; {contains temporary conversion routine}

      procedure Cancel; virtual;
      procedure Convert(aVersionNo: Integer); virtual;
      function  DeviceClass: TppDeviceClass;
      function  DisplayAutoSearchDialog: Boolean; virtual;
      procedure Print; virtual;
      procedure PrintWithSameParameters; virtual;
      procedure PrintToDevices; virtual;
      procedure PrintInBackground; overload; virtual;
      procedure PrintInBackground(aPageRequest: TppPageRequest; const aDeviceType, aArchiveFileName, aTextFileName: String); overload; virtual;
      procedure ProcessMessages; virtual;
      procedure RequestPage(Sender: TObject; aPageRequest: TObject); virtual;
      procedure RaiseException(aException: Exception); virtual;
      procedure Reset; virtual;
      procedure ResetDevices;
      procedure Transfer(aSource: TppCommunicator); override;
      procedure TriggerCodeModuleAfterPrint; virtual;
      procedure TriggerCodeModuleBeforePrint; virtual;
      procedure TriggerCodeModuleCreate; virtual;
      procedure TriggerCodeModuleDestroy; virtual;

      {used for conversion to 3.1}
      procedure AssignOnSave(aOnSave: String);
      function CreateFileDevice(aDeviceClass: TppDeviceClass): TppFileDevice;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;
      procedure SendMail;

      property AllowPrintToArchive: Boolean read FAllowPrintToArchive write SetAllowPrintToArchive default False;
      property AllowPrintToFile: Boolean read FAllowPrintToFile write SetAllowPrintToFile default False;
      property ArchiveFileName: String read FArchiveFileName write SetArchiveFileName;
      property BackgroundPrintSettings: TppBackgroundPrintSettings read FBackgroundPrintSettings write SetBackgroundPrintSettings;
      property CancelDialog: TppCustomCancelDialog read FCancelDialog;
      property Converted: Boolean read FConverted write FConverted;
      property ConvertedFromPre40: Boolean read FConvertedFromPre40;
      property CurrentPage: Longint read FCurrentPage write FCurrentPage;
      property Device: TppDeviceType read FDevice write SetDevice;
      property DeviceType: String read FDeviceType write SetDeviceType;
      property DefaultFileDeviceType: String read FDefaultFileDeviceType write SetDefaultFileDeviceType;
      property Email: TObject read FEmail;
      property EmailSettings: TppEmailSettings read FEmailSettings write SetEmailSettings;
      property EnableProcessMessages: Boolean read FEnableProcessMessages write SetEnableProcessMessages;
      property FileDevice: TppFileDevice read FFileDevice;
      property Icon: TIcon read FIcon write SetIcon;
      property Initialized: Boolean read FInitialized;
      property Language: TppLanguageType read FLanguage write SetLanguage;
      property LanguageID: String read FLanguageID write SetLanguageID;
      property LanguageIndex: Longint read FLanguageIndex;
      property ModalCancelDialog: Boolean read FModalCancelDialog write SetModalCancelDialog default True;
      property ModalPreview: Boolean read FModalPreview write SetModalPreview default True;
      property PDFSettings: TppPDFSettings read FPDFSettings write SetPDFSettings;
      property RTFSettings: TppRTFSettings read FRTFSettings write SetRTFSettings;
      property PreviewForm: TppCustomPreviewer read FPreviewForm;
      property PreviewFormSettings: TppPreviewFormSettings read FPreviewFormSettings write SetPreviewFormSettings;
      property PrinterSetup: TppPrinterSetup read FPrinterSetup write SetPrinterSetup;
      property Printer: TppPrinter read GetPrinter;
      property PrintDialog: TppCustomPrintDialog read FPrintDialog;
      property Printing: Boolean read FPrinting write FPrinting;
      property Producing: Boolean read FProducing write FProducing;
      property PrinterDevice: TppPrinterDevice read FPrinterDevice;
      property Publisher: TppPublisher read FPublisher;
      property SavePrinterSetup: Boolean read FSavePrinterSetup write FSavePrinterSetup default False;
      property ShowAutoSearchDialog: Boolean read FShowAutoSearchDialog write FShowAutoSearchDialog default False;
      property ShowCancelDialog: Boolean read FShowCancelDialog write SetShowCancelDialog default True;
      property ShowPrintDialog: Boolean read FShowPrintDialog write SetShowPrintDialog default True;
      property TextFileName: String read FTextFileName write SetTextFileName;
      property TextFileType: TppFileType read FTextFileType write SetTextFileType default ftComma;
      property TextSearchSettings: TppTextSearchSettings read FTextSearchSettings write SetTextSearchSettings;
      property Version: String read FVersion write FVersion;
      property VersionNo: Integer read FVersionNo write FVersionNo;
      property XLSSettings: TppXLSSettings read FXLSSettings write SetXLSSettings;

    published
      property OnFileDeviceCreate: TNotifyEvent read FOnFileDeviceCreate write FOnFileDeviceCreate;
      property OnPrinterDeviceCreate: TNotifyEvent read FOnPrinterDeviceCreate write FOnPrinterDeviceCreate;
      property OnPrinterDeviceStateChange: TppPrinterDeviceStateChangeEvent read FOnPrinterDeviceStateChange write FOnPrinterDeviceStateChange;

  end; {class, TppProducer}

{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppProducerRTTI }
  TraTppProducerRTTI = class(TraTppRelativeRTTI)
    public
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppProducerRTTI}


implementation

{$R rbPrint.res}

uses
  ppTextSearchRegistration,
  ppPrvDlg,
  ppCDlg,
  ppPDlg,
  ppViewr,
  ppBackgroundPrintManager,
  ppEmail,
  ppLanguage,
  ppRTFDevice,
  ppXLSDevice,
  ppImageDevice;


{******************************************************************************
 *
 ** P R O D U C E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppProducer.Create }

constructor TppProducer.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FAllowPrintToArchive := False;
  FAllowPrintToFile := False;
  FArchiveFileName := '';
  FBackgroundPrintSettings := TppBackgroundPrintSettings.Create;
  FBeforePrintTriggered := False;
  FCancelDialog := nil;
  FConverted := False;
  FConvertedFromPre40 := False;
  FCurrentPage := 1;
  FDevice := dvScreen;
  FDeviceType := TppScreenDevice.DeviceName;
  FEmail := TppEmail.Create;
  FEmailSettings := TppEmailSettings.Create;
  FEnableProcessMessages := True;
  FFileDevice := nil;
  FIcon := TIcon.Create;
  FInitialized := False;
  FLanguage := lgDefault;
  FLanguageID := 'Default';
  FLanguageIndex := 0;
  FModalCancelDialog := True;
  FModalPreview := True;
  FPDFSettings := TppPDFSettings.Create;
  FRTFSettings := TppRTFSettings.Create;
  FXLSSettings := TppXLSSettings.Create;
  FPreviewForm := nil;
  FPreviewFormSettings := TppPreviewFormSettings.Create;
  FPreviewFormSettings.OnPreviewSettingsChange := PreviewFormSettingsChangeEvent;
  FPrintCancelled := False;
  FPrinterDevice := nil;
  FPrintDialog := nil;
  FPrinting := False;
  FPrinter := nil;
  FProducing := False;
  FSavePrinterSetup := False;
  FShowAutoSearchDialog := False;
  FShowCancelDialog := True;
  FShowPrintDialog := True;
  FTextFileName := '';
  FTextFileType := ftComma;
  FTextSearchSettings := TppTextSearchSettings.Create;
  FVersion := '1.0';
  FVersionNo := 1000;

  {events}
  EventNotifies := EventNotifies + [ciPrinterDeviceStateChange];

  FAfterPrint := nil;
  FBeforePrint := nil;
  FOnAssignPreviewFormSettings := nil;
  FOnCancel := nil;
  FOnCancelDialogCreate := nil;
  FOnCancelDialogClose := nil;
  FOnPreviewFormCreate := nil;
  FOnPreviewFormClose := nil;
  FOnPrintDialogCreate := nil;
  FOnPrintDialogClose := nil;
  FOnPrintingComplete := nil;
  FOnSaveText := nil;

  {create printer setup and assign event handlers}
  FPrinterSetup := TppPrinterSetup.Create(Self);
  FPrinterSetup.OnGetPrinter         := PrinterSetupGetPrinterEvent;
  FPrinterSetup.OnPageDefChangeQuery := PrinterSetupChangeQueryEvent;
  FPrinterSetup.OnPageDefChange      := PrinterSetupPageDefChangeEvent;
  FPrinterSetup.OnPrintJobChange     := PrinterSetupPrintJobChangeEvent;

  {create publisher and assign pass-thru events}
  FPublisher := TppPublisher.Create(Self);
  FPublisher.OnPageRequest := RequestPage;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppProducer.Destroy }

destructor TppProducer.Destroy;
begin

 {showMessage('TppProducer.Destroy - begin');}

 {showMessage('TppProducer.Destroy - notify the Preview Form');}
  {notify the Preview Form}
  if (FPreviewForm <> nil) then
    FPreviewForm.Perform(RM_REPORTDESTROY, ppWCustomMsg, 0);

  { showMessage('TppProducer.Destroy - free the Preview Form');}

  {free the Preview Form}
  if (FPreviewForm <> nil) then
    begin
      FPreviewForm.Free;
      FPreviewForm := nil;
    end;

  { showMessage('TppProducer.Destroy -notify the Cancel Dlg');}
 {notify the Cancel Dialog}
  if (FCancelDialog <> nil) then
    FCancelDialog.Perform(RM_REPORTDESTROY, ppWCustomMsg, 0);

  { showMessage('TppProducer.Destroy -free FCancelDialog');}
 {free the Cancel Dialog}
  if (FCancelDialog <> nil) then
    begin
      FCancelDialog.Free;
      FCancelDialog := nil;
    end;

  FIcon.Free;

  { showMessage('TppProducer.Destroy -FPrinterSetup.Free');}
  FPrinterSetup.Free;

   {showMessage('TppProducer.Destroy -FPublisher.Free');}
  FPublisher.Free;

  FPrinter.Free;

  FPreviewFormSettings.Free;
  FTextSearchSettings.Free;
  FBackgroundPrintSettings.Free;
  FPDFSettings.Free;
  FRTFSettings.Free;
  FXLSSettings.Free;
  FEmailSettings.Free;
  FEmail.Free;

  inherited Destroy;
 {showMessage('TppProducer.Destroy - end');}

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppProducer.Loaded }

procedure TppProducer.Loaded;
var
  lbConvert: Boolean;
  liPos: Integer;
  liBuild: Integer;
begin

  lbConvert := (FVersionNo < ppVersionToInt(ppVersion));

  liPos := Pos('Beta Build', FVersion);

  if not(lbConvert) and (liPos <> 0) then
    begin
      liBuild := StrToInt(Copy(FVersion, liPos + 11, 1));

      if (liBuild < 7) then
        FVersionNo := 3998
      else
        FVersionNo := 3999;
    end;

  lbConvert := (FVersionNo < ppVersionToInt(ppVersion));

  if (FVersionNo < 4000) then
    FConvertedFromPre40 := True
  else
    FConvertedFromPre40 := False;

  {perform any needed compatibility conversions }
  if lbConvert then
    begin
      Convert(FVersionNo);

      FConverted := True;
    end;

  {set new version no}
  FVersion := ppVersion;
  FVersionNo := ppVersionToInt(ppVersion);

  {this clears csLoading from ComponentState}
  inherited Loaded;

end; {procedure, Loaded}

{------------------------------------------------------------------------------}
{ TppProducer.ProcessMessages }

procedure TppProducer.ProcessMessages;
begin
  if not FEnableProcessMessages then Exit;

  Application.ProcessMessages;

end; {procedure, ProcessMessages}

{------------------------------------------------------------------------------}
{ TppProducer.Convert }

procedure TppProducer.Convert(aVersionNo: Integer);
begin

  {convert AutoStop property value}
  if (aVersionNo <= 4210) and (LanguageID = 'Spanish(Spain)') then
    SetLanguageID('Spanish(Mexico)');

  if (aVersionNo < 7010) then
    TextSearchSettings.Enabled := False;

end; {procedure, Convert}


{------------------------------------------------------------------------------}
{ TppProducer.AppearsOnDelphiPalette}

class function TppProducer.AppearsOnDelphiPalette: Boolean;
begin

  {this class function enables TppRelative descendants to decide whether to use
   the TComponent fake Left, Top  properties required for non-visual components
   installed onto the Delphi component palette}
  Result := True;

end; {class function, AppearsOnDelphiPalette}


{------------------------------------------------------------------------------}
{ TppProducer.AssignOnSave }

procedure TppProducer.AssignOnSave(aOnSave: String);
begin

  if (Owner <> nil) then
    @FOnSaveText := Owner.MethodAddress(aOnSave);

end; {procedure, AssignOnSave}

{------------------------------------------------------------------------------}
{ TppProducer.DefineProperties - read/write private 'fake' properties }

procedure TppProducer.DefineProperties(Filer: TFiler);
var
  lAncestor: TppProducer;

begin

  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppProducer) then
    lAncestor := TppProducer(Filer.Ancestor)
  else
    lAncestor := nil;

  if (lAncestor <> nil) then
    begin
      Filer.DefineProperty('Device', ReadDevice, nil, False);
      Filer.DefineProperty('Language', ReadLanguage, nil, False);
      Filer.DefineProperty('Version', ReadVersion, WriteVersion, False);
    end
  else
    begin
      Filer.DefineProperty('Device', ReadDevice, nil, False);
      Filer.DefineProperty('Language', ReadLanguage, nil, False);
      Filer.DefineProperty('Version', ReadVersion, WriteVersion, True);
    end;
end;

{------------------------------------------------------------------------------}
{ TppProducer.ReadDevice }

procedure TppProducer.ReadDevice(Reader: TReader);
var
  lsDevice: String;
begin
  lsDevice := Reader.ReadIdent;

  if (lsDevice = 'dvScreen') then
    SetDeviceType(TppScreenDevice.DeviceName)
  else if (lsDevice = 'dvPrinter') then
    SetDeviceType(TppPrinterDevice.DeviceName)
  else if (lsDevice = 'dvFile') then
    SetDeviceType(TppTextFileDevice.DeviceName)
  else if (lsDevice = 'dvArchive') then
    SetDeviceType(TppArchiveDevice.DeviceName);

end; {procedure, ReadDevice}

{------------------------------------------------------------------------------}
{ TppProducer.ReadLanguage }

procedure TppProducer.ReadLanguage(Reader: TReader);
var
  lsLanguage: String;
begin
  lsLanguage := Reader.ReadIdent;

  SetLanguageID(ConvertLanguage(lsLanguage));

end; {procedure, ReadDevice}

{------------------------------------------------------------------------------}
{ TppProducer.ReadVersion }

procedure TppProducer.ReadVersion(Reader: TReader);
begin
  FVersion:= Reader.ReadString;
  FVersionNo := ppVersionToInt(FVersion);
end;

{------------------------------------------------------------------------------}
{ TppProducer.WriteVersion }

procedure TppProducer.WriteVersion(Writer: TWriter);
begin
  Writer.WriteString(ppVersion);
end;


{@TppProducer.ResetDevices
 This method calls the Publisher.ResetDevices procedure, which loops through all
 of the connected devices and calls their Reset method.  This is used when a new
 report or archive file has been selected and the current devices contain
 results from the previous report or archive file.}

procedure TppProducer.ResetDevices;
begin
  FPublisher.ResetDevices;
end; {procedure, ResetDevices}

function TppProducer.ConvertLanguage(aLanguageName: String): String;
begin

  if (aLanguageName = 'lgDefault') then
    Result := 'Default'
  else if (aLanguageName = 'lgDanish') then
    Result := 'Danish (Denmark)'
  else if (aLanguageName = 'lgDutch') then
    Result := 'Dutch (Netherlands)'
  else if (aLanguageName = 'lgEnglish') then
    Result := 'English (United States)'
  else if (aLanguageName = 'lgFrench') then
    Result := 'French (France)'
  else if (aLanguageName = 'lgGerman') then
    Result := 'German (Germany)'
  else if (aLanguageName = 'lgItalian') then
    Result := 'Italian (Italy)'
  else if (aLanguageName = 'lgPortugueseBrazil') then
    Result := 'Portuguese (Brazil)'
  else if (aLanguageName = 'lgPortuguese') then
    Result := 'Portuguese (Portugal)'
  else if (aLanguageName = 'lgSpanish') then
    Result := 'Spanish (Spain)'
  else if (aLanguageName = 'lgSpanishMexico') then
    Result := 'Spanish (Mexico)'
  else if (aLanguageName = 'lgSwedish') then
    Result := 'Swedish (Sweden)'
  else if (aLanguageName = 'lgNorwegian') then
    Result := 'Norwegian (Norway)'
  else if (aLanguageName = 'lgCustom') then
    Result := 'Custom'
  else
    Result := aLanguageName;

end;

{------------------------------------------------------------------------------}
{ TppProducer.Transfer }

procedure TppProducer.Transfer(aSource: TppCommunicator);
var
  lSourceProducer: TppProducer;
begin

  if not(aSource is TppProducer) then Exit;

  lSourceProducer := TppProducer(aSource);

  {assign properties}
  FAllowPrintToFile     := lSourceProducer.FAllowPrintToFile;
  FAllowPrintToArchive  := lSourceProducer.FAllowPrintToArchive;
  FArchiveFileName      := lSourceProducer.FArchiveFileName;
  FConverted            := lSourceProducer.FConverted;
  FConvertedFromPre40   := lSourceProducer.FConvertedFromPre40;
  FDevice               := lSourceProducer.FDevice;
  FDeviceType           := lSourceProducer.FDeviceType;
  FIcon.Assign(lSourceProducer.FIcon);
  FLanguage             := lSourceProducer.FLanguage;
  FLanguageIndex        := lSourceProducer.FLanguageIndex;
  FModalCancelDialog    := lSourceProducer.FModalCancelDialog;
  FShowCancelDialog     := lSourceProducer.FShowCancelDialog;
  FShowPrintDialog      := lSourceProducer.FShowPrintDialog;
  Tag                   := lSourceProducer.Tag;
  FTextFileName         := lSourceProducer.FTextFileName;
  FTextFileType         := lSourceProducer.FTextFileType;
  FVersion              := lSourceProducer.FVersion;
  FVersionNo            := lSourceProducer.FVersionNo;

  FPrinterSetup.Transfer(lSourceProducer.FPrinterSetup);

  FTextSearchSettings.Assign(lSourceProducer.FTextSearchSettings);

  FBackgroundPrintSettings.Assign(lSourceProducer.FBackgroundPrintSettings);

  FEmailSettings.Assign(lSourceProducer.FEmailSettings);

  FPDFSettings.Assign(lSourceProducer.FPDFSettings);
  FRTFSettings.Assign(lSourceProducer.FRTFSettings);
  FXLSSettings.Assign(lSourceProducer.FXLSSettings);

  {assign event handlers}
  FAfterPrint  := lSourceProducer.FAfterPrint;
  FBeforePrint := lSourceProducer.FBeforePrint;

  FOnCancel             := lSourceProducer.FOnCancel;
  FOnCancelDialogCreate := lSourceProducer.FOnCancelDialogCreate;
  FOnCancelDialogClose  := lSourceProducer.FOnCancelDialogClose;
  FOnAssignPreviewFormSettings := lSourceProducer.FOnAssignPreviewFormSettings;
  FOnPreviewFormCreate  := lSourceProducer.FOnPreviewFormCreate;
  FOnPreviewFormClose   := lSourceProducer.FOnPreviewFormClose;
  FOnPrintDialogCreate  := lSourceProducer.FOnPrintDialogCreate;
  FOnPrintDialogClose   := lSourceProducer.FOnPrintDialogClose;
  FOnPrintingComplete   := lSourceProducer.FOnPrintingComplete;
  FOnSaveText           := lSourceProducer.FOnSaveText;

  FBeforeEmail := lSourceProducer.FBeforeEmail;
  FAfterEmail := lSourceProducer.FAfterEmail;

end; {procedure, Transfer}

{------------------------------------------------------------------------------}
{ TppProducer.ConvertedFromPre40Print }

procedure TppProducer.ConvertedFromPre40Print;

  procedure AfterConvertPrintToDevices;
  begin
    {trigger event}
    DoBeforePrint;

    if not(FInitialized) and not(FPrintCancelled) then
      FPublisher.Reset;

    {generate pages}
    FInitialized := True;
    FPrintCancelled := False;

    FPublisher.Publish;


    {notify devices that job was cancelled}
    if FPrintCancelled then
      FPublisher.CancelJob;


    if (DeviceClass <> TppScreenDevice) then
      begin
        {trigger event}
        DoAfterPrint;

        {retained for backward compatiblity}
        DoOnPrintingComplete;
      end;
  end; {procedure, AfterConvertPrintToDevices}

  procedure AfterConvertPrint;
  begin

    FProducing := True;

    if (DeviceType = TppScreenDevice.DeviceName) then
      PrintToScreen
    else
      PrintToPrinter;

  end; {procedure, AfterConvertPrint}

begin

  if FPrinting then Exit;

  ShowMessage('This report will be converted to 4.0 format before printing.');

  {keep other reports from loading}
  FPrinting := True;

  {wait three seconds}
  FTimer := TTimer.Create(Self);

  try
    FTimer.OnTimer := ConvertedFromPre40TimerEvent;
    FTimer.Interval := 1000;
    FTimer.Enabled := True;

    FWaitForTimer := True;

    while (FWaitForTimer) do
      Application.ProcessMessages;

  finally
    FTimer.Free;
  end; {try, finally}

  FConvertedFromPre40 := False;

  FPrinting := False;

  if (aPrintToDevices) then
    AfterConvertPrintToDevices
  else
    AfterConvertPrint

end; {procedure, ConvertedFromPre40Print}

{------------------------------------------------------------------------------}
{ TppProducer.ConvertedFromPre40TimerEvent }

procedure TppProducer.ConvertedFromPre40TimerEvent(Sender: TObject);
begin
  FTimer.Enabled := False;

  FWaitForTimer := False;
end; {procedure, ConvertedFromPre40TimerEvent}


{@TppProducer.Print
 This is the method that puts the producer in motion.  First the producer will
 check the Device property.  If the Device is dtScreen, a Print Preview form is
 created, the ScreenDevice within this form is assigned to the Publisher, and
 the Publisher is told to begin sending pages to the device. As a result, the
 first page of the report is displayed in the Print Preview form.

 If the Device is dtPrinter, dtTextFile or dtArchive, then a Print Dialog is
 created. The user can then select the pages and the printer or file to which
 output should be sent. A PrinterDevice or FileDevice is then created, attached
 to the Publisher, and the Publisher is told to begin sending pages to the
 device. Pages are generated until all the pages requested by the device are
 received. The Publisher then ends the print process.}

procedure TppProducer.Print;
begin

  if (FConvertedFromPre40) then
    begin
      ConvertedFromPre40Print(False);

      Exit;
    end;

  FProducing := True;

  if (DeviceType = TppScreenDevice.DeviceName) then
    PrintToScreen
  else
    PrintToPrinter;

end; {procedure, Print}

{------------------------------------------------------------------------------}
{@TppProducer.PrintWithSameParameters
 This method is called internally by the report viewer. PrintWithSameParameters
 can be called in cases in which Print was called to enable parameters to be
 entered and then subsequently you need to generate the report with the
 same parameters.}

procedure TppProducer.PrintWithSameParameters;
begin

  {same code as print above}
  FProducing := True;

  if (DeviceType = TppScreenDevice.DeviceName) then
    PrintToScreen
  else
    PrintToPrinter;

end;

{------------------------------------------------------------------------------}
{ TppProducer.InitializeReport }

procedure TppProducer.InitializeReport;
begin

  if (FConvertedFromPre40) then
    begin
      ConvertedFromPre40Print(True);

      Exit;
    end;

  {trigger event}
  DoBeforePrint;

  if not(FInitialized) and not(FPrintCancelled) then
    FPublisher.Reset;

  {generate pages}
  FInitialized := True;
  FPrintCancelled := False;

  FPublisher.StartJob;

end; {procedure, InitializeReport}

{------------------------------------------------------------------------------}
{ TppProducer.PublishReport }

procedure TppProducer.PublishReport;
begin
  FPublisher.Publish;
end;

{------------------------------------------------------------------------------}
{ TppProducer.FinalizeReport }

procedure TppProducer.FinalizeReport;
var
  lbFireAfterPrint: Boolean;
begin

  {notify devices that job has ended
  if FPrintCancelled then
    FPublisher.CancelJob
  else
    FPublisher.EndJob;}

  // use a local variable, in case firing the OnCancel free's this instance
  lbFireAfterPrint := FireAfterPrint;

  if FPrintCancelled then
    DoOnCancel
  else
    FPublisher.EndJob;

  if (lbFireAfterPrint) then
    begin

      {trigger event}
      DoAfterPrint;

      {retained for backward compatiblity}
      DoOnPrintingComplete;

      FinalizePrintToPrinter;
    end;

end; {procedure, FinalizeReport}


{@TppProducer.PrintToDevices

 When you call the PrintToDevices method, the Publisher will poll the current
 devices collecting the page requests from each device.  It will then generate
 pages based on the requests.  No forms or devices are created when
 PrintToDevices is called.  If you want the built-in Print Preview Form or Print
 Dialog to display, use the Print method.

 This method allows you to take manual control over the printing process. You
 must create and attach the appropriate devices before making the call to this
 method. PrintToDevices is most often used when the ScreenDevice of a custom
 Viewer component has been attached to the report.}

procedure TppProducer.PrintToDevices;
begin

  if FBackgroundPrintSettings.Active and (DeviceClass <> TppScreenDevice) then
    PrintInBackground
  else
    begin

      try
        InitializeReport;

        PublishReport;

      finally
        FinalizeReport;
      end;

    end;

end; {procedure, PrintToDevices}

{------------------------------------------------------------------------------}
{ TppProducer.FireAfterPrint }

function TppProducer.FireAfterPrint: Boolean;
begin
  Result := (DeviceClass <> TppScreenDevice);
end; {function, FireAfterPrint}

{------------------------------------------------------------------------------}
{ TppProducer.RaiseException }

procedure TppProducer.RaiseException(aException: Exception);
begin
  FPublisher.CancelJob;
end; {procedure, RaiseException}


{@TppProducer.RequestPage
 This procedure is an event handler assigned to the Publisher.  After the
 currently connected devices have been polled, the Publisher triggers its
 OnPageRequest event.  This procedure is then called and the Producer descendant
 must supply the requested pages.  The Report does this by running the Engine.
 The ArchiveReader reads the pages from the archive file.}

procedure TppProducer.RequestPage(Sender: TObject; aPageRequest: TObject);
begin
  DoOnPageRequest(Sender, aPageRequest);
end;


{@TppProducer.DisplayAutoSearchDialog
 Displays the AutoSearch dialog and returns True when valid search criteria is
 entered and the user clicks the OK button.  This routine is called
 automatically by the report when the ShowAutoSearchDialog property is set to
 True.}

function TppProducer.DisplayAutoSearchDialog: Boolean;
begin
  Result := False;
end; {function, DisplayAutoSearchDialog}


{@TppProducer.Cancel
 When this method is called, the printing process is halted.}

procedure TppProducer.Cancel;
begin
  FPrintCancelled := True;

  if (FPublisher <> nil) then
    FPublisher.CancelJob;

end; {procedure, Cancel}


{@TppProducer.Reset
 After Print or PrintToDevices has been called, the producer is in an
 initialized state. Calling Reset returns the producer to its pre-initialized
 state.

 As a descendant, TppReport responds to Reset by resetting the Engine (and any
 caching associated with it).  If you are making changes to a dataset and then
 re-running a report, you may need to call this procedure.}

procedure TppProducer.Reset;
begin

  if (FPrinting) then Exit;
  
  FInitialized := False;
  FPrintCancelled := False;

end; {procedure, Reset}

{------------------------------------------------------------------------------}
{ TppProducer.PrintToScreen }

procedure TppProducer.PrintToScreen;
begin

  if (FPreviewForm <> nil) then Exit;

  FPreviewForm := CreatePreviewForm;

  if (FPreviewForm = nil) then Exit;

  {chance to assign the preview form settings and text search settings}
  DoOnAssignPreviewFormSettings;

  {PreviewFormSettings and TextSearchSettings get applied to previewer}
  SettingsToPreviewForm;

  {trigger event to allow controlling of the preview form directly after the
  preview form and text search settings have been applied.}
  DoOnPreviewFormCreate;

  {display the form}
  if FModalPreview then
    begin
      FPreviewForm.ppOnActivate := PreviewFormActivateEvent;

      FPreviewForm.Showmodal;
    end

  else
    begin
      FPreviewForm.Show;

      PrintToDevices;
    end;

  {note: this enables the FormClose and FormDestroy messages to fire
         when Report.Print is called from within a loop }
  ProcessMessages;


end; {procedure, PrintToScreen}

{------------------------------------------------------------------------------}
{ TppProducer.PrintToPrinter }

procedure TppProducer.PrintToPrinter;
var
  lFileDevice: TppFileDevice;
  lbPrintToFile: Boolean;
  lDeviceClass: TppDeviceClass;
  lsErrorMessage: String;
begin

  if (FCancelDialog <> nil) then Exit;

  {get device class}
  lDeviceClass := DeviceClass;
  lbPrintToFile := DeviceClass.InheritsFrom(TppFileDevice);

  if (lDeviceClass = nil) then Exit;

  FResetEngineAfterPrinting := False;

  {save current printer setup}
  FOriginalPrinterSetup := TppPrinterSetup.Create(nil);
  FOriginalPrinterSetup.Assign(PrinterSetup);

  {create a printer device}
  FPrinterDevice := TppPrinterDevice.Create(Self);
  FPrinterDevice.Stackable := True;
  FPrinterDevice.LanguageIndex := LanguageIndex;
  FPrinterDevice.AddEventNotify(Self);

  if FPrinterDevice.Printer <> nil then
    FPrinterDevice.Printer.PrinterSetup := PrinterSetup;

  FPrintDialog := CreatePrintDialog;

  DoOnPrintDialogCreate;

  if (FPrintDialog <> nil) then
    begin
      FPrintDialog.ShowModal;

      DoOnPrintDialogClose;

      FBackgroundPrintSettings.Active := TppBackgroundPrintSettings(FPrintDialog.BackgroundPrintSettings).Active;

      if (FPrintDialog.ModalResult <> mrOK) then
        begin
          FinalizePrintToPrinter;
          Exit;
        end;

      lDeviceClass := ppDeviceClassForName(FPrintDialog.DeviceType);
      lbPrintToFile := lDeviceClass.InheritsFrom(lDeviceClass);

    end;

  if FBackgroundPrintSettings.Active then
    lbPrintToFile := False
  else if lbPrintToFile then

    begin
      lFileDevice := CreateFileDevice(lDeviceClass);

      if (FFileDevice <> nil) and (lFileDevice <> nil) then
        begin
          lFileDevice.Free;

          raise EReportBuilderError.Create('TppProducer.PrintToPrinter: The file device has already been created.');
        end;

      FFileDevice := lFileDevice;

      lbPrintToFile := FFileDevice <> nil;

      // check print dc
      if not(lbPrintToFile) then
          begin
            if not FPrinterDevice.Printer.CheckDC(lsErrorMessage) then
              begin
                lsErrorMessage := ppLoadStr(1020) + ' ' + lsErrorMessage;

                MessageDlg(lsErrorMessage, mtWarning, [mbOK], 0);

                FinalizePrintToPrinter;

                Exit;

              end;

            if (FPrintDialog <> nil) then
              FPrinterDevice.PageRequest := TppPageRequest(FPrintDialog.PageRequest);

          end;

    end;

  {assign device to publisher}
  if (lbPrintToFile) then
    begin
      FFileDevice.Publisher := FPublisher;

      DeviceCreated(FFileDevice);
    end

  else
    begin
      FPrinterDevice.Publisher := FPublisher;

      DeviceCreated(FPrinterDevice);
    end;


  {assign printer device to publisher}
  if not(lbPrintToFile) then
    begin

      {get printer device's printersetup - note: do not use assign here}
       PrinterSetup := FPrinterDevice.Printer.PrinterSetup;

    end;


  { regenerate report if printer has changed }
  if not(FPrinterDevice.Printer.PrinterSetup.IsPrinterDefEqual(FOriginalPrinterSetup)) then
    begin
      FResetEngineAfterPrinting := True;
      Producing := False;
      Publisher.Clear;
      Reset;
      Producing := True;
    end;


  {create the cancel dialog}
  FCancelDialog := CreateCancelDialog;

  try

    {assign cancel dialog to device}
    if (FCancelDialog <> nil) and (lbPrintToFile) then
       FFileDevice.CancelDialog := FCancelDialog

    else if (FCancelDialog <> nil) then
      FPrinterDevice.CancelDialog := FCancelDialog;

    {trigger event}
    DoOnCancelDialogCreate;

    {print report}

    {display cancel dialog}
    if (FCancelDialog <> nil) then
      begin
        if FModalCancelDialog then
          begin
            {for modal dialog, must call PrintToDevice from the forms Activate event}
            FCancelDialog.ppOnShowModal := CancelDialogShowModalEvent;
            try
              FCancelDialog.ppShowModal;
              if FModalException <> nil then
                raise FModalException;
            finally
              FModalException := nil;
            end;

          end
        else
          begin
            FCancelDialog.Show;

            PrintToDevices;
          end;
      end

    else
      begin
        if FBackgroundPrintSettings.Active then
          begin

            try

              if (FPrintDialog <> nil) then
                PrintInBackground(TppPageRequest(FPrintDialog.PageRequest), FPrintDialog.DeviceType, FPrintDialog.ArchiveFileName, FPrintDialog.TextFileName)
              else
                PrintInBackground;

            finally
              FinalizePrintToPrinter;
            end;

          end
        else
          PrintToDevices;
      end;

  finally

    if (FCancelDialog <> nil) then
      begin
        FCancelDialog.Release;
        ProcessMessages;
      end;

    FCancelDialog := nil;

  end;

end; {procedure, PrintToPrinter}

{@TppProducer.CreateFileDevice

  Returns true if created a file device.}

function TppProducer.CreateFileDevice(aDeviceClass: TppDeviceClass): TppFileDevice;
begin

  Result := nil;

  {create the device}
  if not (aDeviceClass.InheritsFrom(TppFileDevice)) then Exit;

  Result := TppFileDevice(aDeviceClass.Create(Self));
  Result.LanguageIndex := LanguageIndex;

  if (FPrintDialog <> nil) then
    begin
      if (aDeviceClass.InheritsFrom(TppArchiveDevice)) then
        Result.FileName := FPrintDialog.ArchiveFileName
      else
        Result.FileName := FPrintDialog.TextFileName;
      Result.PageRequest := TppPageRequest(FPrintDialog.PageRequest);
      Result.AllowEmail := FPrintDialog.AllowEmail;
    end
  else
    begin
      if (aDeviceClass.InheritsFrom(TppArchiveDevice)) then
        Result.FileName := FArchiveFileName
      else
        Result.FileName := FTextFileName;
    end;


  if aDeviceClass.InheritsFrom(TppTextFileDevice) then
    begin
      TppTextFileDevice(Result).OnSave := TextDeviceSaveEvent;

      TppTextFileDevice(Result).TextFileType := FTextFileType;
    end;

  if TraRTTI.IsValidPropName(Result, 'PDFSettings') then
    begin
      TraRTTI.SetPropValue(Result, 'PDFSettings', FPDFSettings);
    end;

  if TraRTTI.IsValidPropName(Result, 'RTFSettings') then
    begin
      TraRTTI.SetPropValue(Result, 'RTFSettings', FRTFSettings);
    end;

  if TraRTTI.IsValidPropName(Result, 'XLSSettings') then
    begin
      TraRTTI.SetPropValue(Result, 'XLSSettings', FXLSSettings);
    end;

end;

{@TppProducer.PrintInBackground

  Call this routine in order to print the report in a background thread. This
  allows the application to continue execution in the main thread while the
  report is generating in a background thread.

  Before calling this routine, set the device type on the report.
  This can be any device except the screen device.

  For optimization reasons, the background print calls are queued up and
  executed in order, one at a time. Shutting down the application will cause
  any remaining unprocessed print requests to be freed. Any reports which
  have not been generated to the printer spool file will not be printed
  once the application closes.}

procedure TppProducer.PrintInBackground;
begin
  PrintInBackground(nil, DeviceType, ArchiveFileName, TextFileName);
end;

procedure TppProducer.PrintInBackground(aPageRequest: TppPageRequest; const aDeviceType, aArchiveFileName, aTextFileName: String);
begin
  if (aDeviceType = dtScreen) then
    raise EBackgroundPrintError.Create('TppProducer.InternalPrintInBackground: Cannot print to the screen in the background.');

  gBackgroundPrintManager.Print(Self, aPageRequest, aDeviceType, aArchiveFileName, aTextFileName);
end;

{------------------------------------------------------------------------------}
{ TppProducer.FinalizePrintToPrinter }

procedure TppProducer.FinalizePrintToPrinter;
begin

  if (FCancelDialog <> nil) then
    begin
      if FModalCancelDialog then
        FCancelDialog.ModalResult := mrOK
      else
        FCancelDialog.Close;
    end;

  if FResetEngineAfterPrinting then
    begin
      Producing := False;
      Publisher.Clear;
      Reset;
      Producing := True;
    end;

  if not(FSavePrinterSetup) and (FOriginalPrinterSetup <> nil) then
    PrinterSetup.Assign(FOriginalPrinterSetup);

  {free objects created during print process}
  GlobalNameSpace.BeginWrite;

  try
    FPrintDialog.Free;
    FPrintDialog := nil;

    FOriginalPrinterSetup.Free;
    FOriginalPrinterSetup := nil;

    FFileDevice.Free;
    FFileDevice := nil;

    FPrinterDevice.Free;
    FPrinterDevice := nil;

  finally
    GlobalNameSpace.EndWrite;
  end;

  FProducing := False;
  FResetEngineAfterPrinting := False;

  SendEventNotify(Self, ciProducerAfterPrintToPrinter, nil);

end;


{@TppProducer.TextDeviceSaveEvent
 This procedure is an event handler assigned to the TextFileDevice when printing
 to a text file. As each draw command is written to the text file, the
 TextFileDevice triggers an event, firing this procedure. As a descendant,
 TppReport overrides this event handler and fires the OnSave event of the
 component passed in the aComponent parameter.  When printing via an
 ArchiveReader, the aComponent parameter is always nil.

 When this procedure is called, the Producer triggers its own OnSaveText event.}

procedure TppProducer.TextDeviceSaveEvent(aTextDevice: TObject; aComponent: TObject; var Text: String);
begin
  DoOnSaveText(TppTextFileDevice(aTextDevice), Text);
end; {procedure, TextDeviceSaveEvent}

{------------------------------------------------------------------------------}
{ TppProducer.CreatePreviewForm }

function TppProducer.CreatePreviewForm: TppCustomPreviewer;
var
  lFormClass: TFormClass;
begin

  {instantiate the previewer}
  lFormClass   := ppGetFormClass(TppCustomPreviewer);
  Result := TppCustomPreviewer(lFormClass.Create(nil));

  {these assigned to 'pp' events, so developer can use Delphi events}
  Result.ppOnClose    := PreviewFormCloseEvent;
  Result.ppOnDestroy  := PreviewFormDestroyEvent;
  Result.ppOnCancel   := CancelDialogCancelEvent;

  {set the report property, devices are added by the preview form}
  Result.Report := Self;

end; {function, CreatePreviewForm}

{------------------------------------------------------------------------------}
{ TppProducer.CreateCancelDialog }

function TppProducer.CreateCancelDialog: TppCustomCancelDialog;
var
  lFormClass: TFormClass;
  lCancelDialog: TppCustomCancelDialog;
begin
  Result := nil;

  if not(FShowCancelDialog) then Exit;

  if FBackgroundPrintSettings.Active then Exit;

  lFormClass := ppGetFormClass(TppCustomCancelDialog);

  lCancelDialog := TppCustomCancelDialog(lFormClass.Create(nil));
  
  lCancelDialog.Report           := Self;
  lCancelDialog.LanguageIndex    := LanguageIndex;
  lCancelDialog.ppOnCancel       := CancelDialogCancelEvent;
  lCancelDialog.ppOnClose        := CancelDialogCloseEvent;
  lCancelDialog.AllowPrintCancel := True;

  if not(FIcon.Empty) then
    lCancelDialog.Icon := FIcon;

  Result := lCancelDialog;

end; {function, CreateCancelDialog}

{------------------------------------------------------------------------------}
{ TppProducer.CreatePrintDialog }

function TppProducer.CreatePrintDialog: TppCustomPrintDialog;
var
  lFormClass: TFormClass;
  lPrintDialog: TppCustomPrintDialog;
begin

  Result := nil;

  if not ((pppcDesignPrinting in DesignState) or (FShowPrintDialog)) then Exit;

  lFormClass   := ppGetFormClass(TppCustomPrintDialog);

  lPrintDialog := TppCustomPrintDialog(lFormClass.Create(Application));

  {suppress delphi design time background printing}
  if (Self.Owner <> nil) and (csDesigning in Self.Owner.ComponentState) then
    lPrintDialog.DesignState := [pppcDesigning]
  else
    lPrintDialog.DesignState := [];

  lPrintDialog.Report := Self;
  lPrintDialog.DeviceType := FDeviceType;
  lPrintDialog.DefaultFileDeviceType := FDefaultFileDeviceType;
  lPrintDialog.Printer := TppPrinterDevice(FPrinterDevice).Printer;
  lPrintDialog.LanguageIndex := LanguageIndex;
  lPrintDialog.AllowPrintToArchive := FAllowPrintToArchive;
  lPrintDialog.AllowPrintToFile := FAllowPrintToFile;
  lPrintDialog.ArchiveFileName := FArchiveFileName;
  lPrintDialog.BackgroundPrintSettings := FBackgroundPrintSettings;
  lPrintDialog.TextFileName := FTextFileName;

  TppPageRequest(lPrintDialog.PageRequest).PageRequested := FCurrentPage;

  if not(FIcon.Empty) then
    lPrintDialog.Icon := FIcon;

  lPrintDialog.Init;

  Result := lPrintDialog;

end; {procedrue, CreatePrintDialog}

{@TppProducer.SendMail
 Call SendMail to automatically export and send a report via. email.  This uses
 the current EmailSettings defined for the report. }

procedure TppProducer.SendMail;
begin

  DoBeforeEmail;  //Fire before email event

  TppEmail(FEmail).AddReport(Self);  //Add the report to the email
  TppEmail(FEmail).Send;             //Send the email

  DoAfterEmail;   //Fire after email event

end;

{******************************************************************************
 *
 ** F O R M   E V E N T   H A N D L E R S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppProducer.CancelDialogShowModalEvent }

procedure TppProducer.CancelDialogShowModalEvent(Sender: TObject);
begin

  {if this routine is called we have a modal cancel dialog and
   we need to continue the report printing process by calling print}
  try
    PrintToDevices;
  except
    FModalException := AcquireExceptionObject();
    FCancelDialog.ModalResult := mrAbort;

  end;

end; {procedure, CancelDialogActivate}

{------------------------------------------------------------------------------}
{ TppProducer.CancelDialogCancelEvent }

procedure TppProducer.CancelDialogCancelEvent(Sender: TObject);
begin
  Cancel;


end; {procedure, CancelDialogCancelEvent}

{------------------------------------------------------------------------------}
{ TppProducer.CancelDialogCloseEvent }

procedure TppProducer.CancelDialogCloseEvent(Sender: TObject);
begin
  {trigger event}
  DoOnCancelDialogClose;

  if (FPrinterDevice <> nil) then
    TppPrinterDevice(FPrinterDevice).CancelDialog := nil

  else if (FFileDevice <> nil) then
    TppTextFileDevice(FFileDevice).CancelDialog := nil;
end;

{------------------------------------------------------------------------------}
{ TppProducer.PreviewFormActivateEvent }

procedure TppProducer.PreviewFormActivateEvent(Sender: TObject);
begin

  {if this routine is called when we have a modal previewer and
   we need to continue the report printing process by calling print.
   Need to check dtScreen, because when ModalPreview is true and ModalCancel is
   False, this event fires when printing from the preview}

  if DeviceType = dtScreen then
    PrintToDevices;

end; {procedure, PreviewFormActivateEvent}

{------------------------------------------------------------------------------}
{ TppProducer.PreviewFormCloseEvent }

procedure TppProducer.PreviewFormCloseEvent(Sender: TObject);
begin
  FProducing := False;

  DoAfterPrint;

  DoOnPreviewFormClose;
end;

{------------------------------------------------------------------------------}
{ TppProducer.PreviewFormDestroyEvent }

procedure TppProducer.PreviewFormDestroyEvent(Sender: TObject);
begin

  FPreviewForm := nil;

end; {procedure, PreviewFormDestroyEvent}
 
{@TppProducer.SetFPreviewFormSettings }

procedure TppProducer.SetPreviewFormSettings(aSettings: TppPreviewFormSettings);
begin
  FPreviewFormSettings.Clone(aSettings);
end;

{@TppProducer.SetBackgroundPrintSettings }

procedure TppProducer.SetBackgroundPrintSettings(aBackgroundPrintSettings: TppBackgroundPrintSettings);
begin
  FBackgroundPrintSettings.Assign(aBackgroundPrintSettings);
end;

{@TppProducer.SetTextSearchSettings }

procedure TppProducer.SetTextSearchSettings(aTextSearchSettings: TppTextSearchSettings);
begin
  FTextSearchSettings.Assign(aTextSearchSettings);
end;

{@TppProducer.PreviewFormSettingsChangeEvent }

procedure TppProducer.PreviewFormSettingsChangeEvent(Sender: TObject);
begin
  SettingsToPreviewForm;
end;

{@TppProducer.SettingsToPreviewForm }

procedure TppProducer.SettingsToPreviewForm;
var
  lViewer: TppViewer;
begin

  if (FPreviewForm <> nil) then
    begin
      lViewer := TppViewer(FPreviewForm.Viewer);

      lViewer.ZoomSetting := FPreviewFormSettings.ZoomSetting;

      if (lViewer.ZoomSetting = zsPercentage) then
        lViewer.ZoomPercentage := FPreviewFormSettings.ZoomPercentage;

      FPreviewForm.WindowState := FPreviewFormSettings.WindowState;

      // fixes a bug in D2005
      if (FPreviewForm.WindowState = wsMaximized) then
        FPreviewForm.Position := poDefaultPosOnly;

      FEmailSettings.Enabled := (HasEmailGroups = False);
      FPreviewForm.Init;
    end;

end;

{******************************************************************************
 *
 ** E V E N T   T R I G G E R S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppProducer.DoOnPageRequest }

procedure TppProducer.DoOnPageRequest(Sender: TObject; aPageRequest: TObject);
begin
  if Assigned(FOnPageRequest) then FOnPageRequest(Sender, aPageRequest);

  SendEventNotify(Self, ciProducerPageRequest, nil);
end;

{------------------------------------------------------------------------------}
{ TppProducer.DoOnPrintingComplete }

procedure TppProducer.DoOnPrintingComplete;
begin
  if Assigned(FOnPrintingComplete) then FOnPrintingComplete(Self);
end;

{------------------------------------------------------------------------------}
{ TppProducer.TriggerCodeModuleBeforePrint }

procedure TppProducer.TriggerCodeModuleBeforePrint;
begin

  if (FBeforePrintTriggered) then Exit;

  FBeforePrintTriggered := True;

  SendEventNotify(Self, ciProducerBeforePrint, nil);

end;

{------------------------------------------------------------------------------}
{ TppProducer.TriggerCodeModuleAfterPrint }

procedure TppProducer.TriggerCodeModuleAfterPrint;
begin

  if not(FBeforePrintTriggered) then Exit;

  FBeforePrintTriggered := False;

  SendEventNotify(Self, ciProducerAfterPrint, nil);

end;


{@TppProducer.DoAfterPrint
 Triggers the AfterPrint event.}

procedure TppProducer.DoAfterPrint;
begin

  TriggerCodeModuleAfterPrint;

  if Assigned(FAfterPrint) then FAfterPrint(Self);
end;


{@TppProducer.DoBeforePrint
 Triggers the BeforePrint event.}

procedure TppProducer.DoBeforePrint;
begin
  if Assigned(FBeforePrint) then FBeforePrint(Self);
end;

{------------------------------------------------------------------------------}
{ TppProducer.DoAfterEmail }

procedure TppProducer.DoAfterEmail;
begin
  if Assigned(FAfterEmail) then FAfterEmail(Self);

  SendEventNotify(Self, ciProducerAfterEmail, nil);

end;

{------------------------------------------------------------------------------}
{ TppProducer.DoBeforeEmail }

procedure TppProducer.DoBeforeEmail;
begin
  if Assigned(FBeforeEmail) then FBeforeEmail(Self);

  SendEventNotify(Self, ciProducerBeforeEmail, nil);

end;

{------------------------------------------------------------------------------}
{ TppProducer.TriggerCodeModuleCreate }

procedure TppProducer.TriggerCodeModuleCreate;
var
  lbProducing: Boolean;
begin
  lbProducing := Producing;
  Producing := True;
  try
  SendEventNotify(Self, ciProducerCreate, nil);
  finally
    Producing := lbProducing;
  end;
  
end;

{------------------------------------------------------------------------------}
{ TppProducer.TriggerCodeModuleDestroy }

procedure TppProducer.TriggerCodeModuleDestroy;
begin
  SendEventNotify(Self, ciProducerDestroy, nil);
end;

{------------------------------------------------------------------------------}
{ TppProducer.DoOnCancel }

procedure TppProducer.DoOnCancel;
begin
  Reset;

  // fire this first, Delphi event-handler might free the report
  SendEventNotify(Self, ciProducerCancel, nil);

  if Assigned(FOnCancel) then FOnCancel(Self);

end;


{@TppProducer.DoOnCancelDialogCreate
 Triggers the OnCancelDialogCreate event.}

procedure TppProducer.DoOnCancelDialogCreate;
begin
  if Assigned(FOnCancelDialogCreate) then FOnCancelDialogCreate(Self);

  SendEventNotify(Self, ciProducerCancelDialogCreate, nil);
end;


{@TppProducer.DoOnCancelDialogClose
 Triggers the OnCancelDialogClose event.}

procedure TppProducer.DoOnCancelDialogClose;
begin
  if Assigned(FOnCancelDialogClose) then FOnCancelDialogClose(Self);

  SendEventNotify(Self, ciProducerCancelDialogClose, nil);
end;


{@TppProducer.LanguageChanged
 This method is called after the Language property has been changed.}

procedure TppProducer.LanguageChanged;
begin
  FTextSearchSettings.LanguageChanged;
end; {procedure, LanguageChanged}


{@TppProducer.DeviceCreated
 This method is called after the producer has created a device, before the
 device is assigned to the Publisher.}

procedure TppProducer.DeviceCreated(aDevice: TppDevice);
begin

  if (aDevice is TppFileDevice) then
    DoOnFileDeviceCreate()
  else if (aDevice is TppPrinterDevice) then
    DoOnPrinterDeviceCreate();

end;

{@TppProducer.DoOnAssignPreviewFormSettings

 Triggers the OnAssignPreviewFormSettings event.}

procedure TppProducer.DoOnAssignPreviewFormSettings;
begin
  if Assigned(FOnAssignPreviewFormSettings) then FOnAssignPreviewFormSettings(Self);

  SendEventNotify(Self, ciProducerAssignPreviewFormSettings, nil);
end;

{@TppProducer.DoOnPreviewFormCreate

 Triggers the OnPreviewFormCreate event.}

procedure TppProducer.DoOnPreviewFormCreate;
begin
  FPreviewForm.LanguageIndex := FLanguageIndex;

  if not(FIcon.Empty) then FPreviewForm.Icon := FIcon;

  if Assigned(FOnPreviewFormCreate) then FOnPreviewFormCreate(Self);

  SendEventNotify(Self, ciProducerPreviewFormCreate, nil);
end;


{@TppProducer.DoOnPreviewFormClose
 Triggers the OnPreviewFormClose event.}

procedure TppProducer.DoOnPreviewFormClose;
begin
  {if we're printing, stop the job}
  if FPrinting then Cancel;

  if Assigned(FOnPreviewFormClose) then FOnPreviewFormClose(Self);

  SendEventNotify(Self, ciProducerPreviewFormClose, nil);
end;


{@TppProducer.DoOnPrintDialogCreate
 Triggers the OnPrintDialogCreate event.}

procedure TppProducer.DoOnPrintDialogCreate;
begin
  if Assigned(FOnPrintDialogCreate) then FOnPrintDialogCreate(Self);

  SendEventNotify(Self, ciProducerPrintDialogCreate, nil);
end;


{@TppProducer.DoOnPrintDialogClose
 Triggers the OnPrintDialogClose event.}

procedure TppProducer.DoOnPrintDialogClose;
begin
  if Assigned(FOnPrintDialogClose) then FOnPrintDialogClose(Self);

  SendEventNotify(Self, ciProducerPrintDialogClose, nil);
end;


{@TppProducer.DoOnSaveText
 Triggers the OnSaveText event, passing aTextDevice as the Sender.}

procedure TppProducer.DoOnSaveText(aTextDevice: TppTextFileDevice; var aText: String);
var
  lParams: TraParamList;
begin

  if Assigned(FOnSaveText) then FOnSaveText(aTextDevice, aText);

  lParams := TraTppProducerRTTI.GetParams('OnSaveText');

  lParams.CreateValuePointer(0, aText);

  SendEventNotify(Self, ciProducerSaveText, lParams);

  lParams.Free;

end; {procedure, DoOnSaveText}

{******************************************************************************
 *
 ** P R O P E R T Y   H A N D L E R S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppProducer.SetAllowPrintToArchive }

procedure TppProducer.SetAllowPrintToArchive(Value: Boolean);
begin
  if FPrinting then Exit;

  FAllowPrintToArchive := Value;
end;

{------------------------------------------------------------------------------}
{ TppProducer.SetAllowPrintToFile }

procedure TppProducer.SetAllowPrintToFile(Value: Boolean);
begin
  if FPrinting then Exit;

  FAllowPrintToFile := Value;
end;

{------------------------------------------------------------------------------}
{ TppProducer.SetIcon }

procedure TppProducer.SetIcon(aIcon: TIcon);
begin
  if FPrinting then Exit;

  FIcon.Assign(aIcon);
end;

{------------------------------------------------------------------------------}
{ TppProducer.DeviceClass }

function TppProducer.DeviceClass: TppDeviceClass;
begin
  Result := ppDeviceClassForName(FDeviceType);
end; {procedure, DeviceClass}

procedure TppProducer.DoOnFileDeviceCreate;
begin
  if Assigned(OnFileDeviceCreate) then OnFileDeviceCreate(Self);

  SendEventNotify(Self, ciFileDeviceCreate, nil);

end;

procedure TppProducer.DoOnPrinterDeviceCreate;
begin
  if Assigned(OnPrinterDeviceCreate) then OnPrinterDeviceCreate(Self);

  SendEventNotify(Self, ciPrinterDeviceCreate, nil);

end;

procedure TppProducer.ehPrinterDevice_StateChange(aCommunicator: TppCommunicator; aParams: TraParamList);
var
  lDeviceState: TppDeviceStateType;
begin

  if Assigned(FOnPrinterDeviceStateChange) then
    begin
      lDeviceState := TppDeviceStateType(aParams[0].Value^);

      FOnPrinterDeviceStateChange(Self, lDeviceState);

    end;

  SendEventNotify(Self, ciPrinterDeviceStateChange, aParams);

end;

{------------------------------------------------------------------------------}
{ TppProducer.EventNotify }

procedure TppProducer.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  inherited EventNotify(aCommunicator, aEventID, aParams);

  if (aEventID = ciPrinterDeviceStateChange) then
    ehPrinterDevice_StateChange(aCommunicator, aParams);

end; {procedure, EventNotify}


{@TppProducer.SetDevice
 This is the property handling method for the Device property. The ArchiveReader
 overrides this method to disallow the assignment of the DeviceType proper to
 dtArchive.}

procedure TppProducer.SetDevice(aDevice: TppDeviceType);
begin

  {this routine supports code like:  ppReport1.Device := dvPrinter, for backward compatiblity}
  case aDevice of
    dvScreen:  SetDeviceType(TppScreenDevice.DeviceName);
    dvPrinter: SetDeviceType(TppPrinterDevice.DeviceName);
    dvFile:    SetDeviceType(TppTextFileDevice.DeviceName);
    dvArchive: SetDeviceType(TppArchiveDevice.DeviceName);
  end;

end; {procedure, SetDevice}

{------------------------------------------------------------------------------}
{ TppProducer.SetDeviceType }

procedure TppProducer.SetDeviceType(const aDeviceName: String);
var
  lsOldType: String;
begin

{6.5 Separation of DeviceType save and restore in ppViewer means that the producer
     is printing when DeviceType is set, therefore this check must be disabled.}

//  if FPrinting then Exit;

  lsOldType := FDeviceType;

  FDeviceType := aDeviceName;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (ppDeviceClassForName(aDeviceName) = nil) then
    FDeviceType := lsOldType
  else if IsFileDevice(aDeviceName) then
    FDefaultFileDeviceType := aDeviceName;

end; {procedure, SetDeviceType}

{------------------------------------------------------------------------------}
{ TppProducer.SetDefaultFileDeviceType }

procedure TppProducer.SetDefaultFileDeviceType(const aFileDeviceType: String);
var
  lsOldType: String;
begin

  if IsFileDevice(FDeviceType) then Exit;

  lsOldType := FDefaultFileDeviceType;

  FDefaultFileDeviceType := aFileDeviceType;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (ppDeviceClassForName(FDefaultFileDeviceType) = nil) or not(IsFileDevice(FDefaultFileDeviceType)) then
    FDefaultFileDeviceType := lsOldType;

end; {procedure, SetDefaultFileDeviceType}

function TppProducer.IsFileDevice(aDeviceName: String): Boolean;
begin
  Result := not(aDeviceName = 'Screen') and not(aDeviceName = 'Printer');

end;

{------------------------------------------------------------------------------}
{ TppProducer.SetEnableProcessMessages }

procedure TppProducer.SetEnableProcessMessages(aValue: Boolean);
begin
  FEnableProcessMessages := aValue;

end; {procedure, SetEnableProcessMessages}

{------------------------------------------------------------------------------}
{ TppProducer.SetShowPrintDialog }

procedure TppProducer.SetShowPrintDialog(Value: Boolean);
begin
  if FPrinting then Exit;

  FShowPrintDialog := Value;
end;

{------------------------------------------------------------------------------}
{ TppProducer.SetShowCancelDialog }

procedure TppProducer.SetShowCancelDialog(Value: Boolean);
begin
  if FPrinting then Exit;

  FShowCancelDialog := Value;
end;

{------------------------------------------------------------------------------}
{ TppProducer.SetModalCancelDialog }

procedure TppProducer.SetModalCancelDialog(Value: Boolean);
begin
  if FPrinting then Exit;

  FModalCancelDialog := Value;
end;

{------------------------------------------------------------------------------}
{ TppProducer.SetModalPreview }

procedure TppProducer.SetModalPreview(Value: Boolean);
begin
  if FPrinting then Exit;

  FModalPreview := Value;
end;

{------------------------------------------------------------------------------}
{ TppProducer.SetArchiveFileName }

procedure TppProducer.SetArchiveFileName(aFileName: String);
begin
  if FPrinting then Exit;

  FArchiveFileName := aFileName;

  Reset;
  ResetDevices;

end;

{------------------------------------------------------------------------------}
{ TppProducer.SetTextFileType }

procedure TppProducer.SetTextFileType(aFileType: TppFileType);
begin
  if FPrinting then Exit;

  FTextFileType := aFileType;
end;

{------------------------------------------------------------------------------}
{ TppProducer.SetTextFileName }

procedure TppProducer.SetTextFileName(aFileName: String);
begin
  if FPrinting then Exit;

  FTextFileName := aFileName;
end;

{------------------------------------------------------------------------------}
{ TppProducer.SetLanguage }

procedure TppProducer.SetLanguage(aLanguageType: TppLanguageType);
var
  lsLanguageName: String;
begin

  if FPrinting then Exit;

  lsLanguageName := ConvertLanguage(ppGetEnumName(TypeInfo(TppLanguageType), Ord(aLanguageType)));

  SetLanguageID(lsLanguageName);

end;

procedure TppProducer.SetLanguageID(aLanguageID: String);
var
  lsLanguageExt: String;
begin

  lsLanguageExt := ppGetLanguageExtForName(aLanguageID);

  if not ppResourceManager.SetLanguage(aLanguageID, lsLanguageExt) then
    if (csReading in ComponentState) or (csLoading in ComponentState) then
        ppResourceManager.SetLanguage('Default', 'dft')
    else
      Exit;

  FLanguageID := aLanguageID;

end;

{------------------------------------------------------------------------------}
{ TppProducer.SetPDFSettings }

procedure TppProducer.SetPDFSettings(aPDFSettings: TppPDFSettings);
begin
  FPDFSettings.Assign(aPDFSettings);
end;

{------------------------------------------------------------------------------}
{ TppProducer.SetRTFSettings }

procedure TppProducer.SetRTFSettings(aRTFSettings: TppRTFSettings);
begin
  FRTFSettings.Assign(aRTFSettings);
end;

{------------------------------------------------------------------------------}
{ TppProducer.SetEmailSettings }

procedure TppProducer.SetEmailSettings(aEmailSettings: TppEmailSettings);
begin
  FEmailSettings.Assign(aEmailSettings);
end;

{------------------------------------------------------------------------------}
{ TppProducer.SetPrinterSetup }

procedure TppProducer.SetPrinterSetup(aPrinterSetup: TppPrinterSetup);
var
  lOldPageDef: TppPageDef;
  liOldOrientation: Integer;
begin

  lOldPageDef := nil;
  liOldOrientation := 0;

  {save the old pagedef info}
  if not (csReading in ComponentState) and not (csLoading in ComponentState) then
    begin
      lOldPageDef := TppPageDef.Create;
      lOldPageDef.Assign(FPrinterSetup.PageDef);
      liOldOrientation := Ord(FPrinterSetup.Orientation);
    end;

  FPrinterSetup.Assign(aPrinterSetup);

  {check whether PageDef changed}
  if (lOldPageDef <> nil) then
    begin

      {Call PageDef changed if there is a new page def, it will call PrinterSetupChanged
         This was added to support communication to all subreports when the parent report's
         pagedef changes}
      if not lOldPageDef.IsEqual(FPrinterSetup.PageDef) or (liOldOrientation <> Ord(FPrinterSetup.Orientation)) then
        PageDefChanged
      else
        PrinterSetupChanged;

      lOldPageDef.Free;
    end;

end; {procedure, SetPrinterSetup}


{******************************************************************************
 *
 ** P R I N T E R  S E T U P   E V E N T    H A N D L E R S
 *
{******************************************************************************}


{@TppProducer.PrinterSetupChanged
 Called when any of the properties of the PrinterSetup object are modified.}

procedure TppProducer.PrinterSetupChanged;
begin

end;  {procedure, PrinterSetupChanged}

{------------------------------------------------------------------------------}
{ TppProducer.PageDefChanged }

procedure TppProducer.PageDefChanged;
begin
  PrinterSetupChanged;

end; {procedure, PageDefChanged}

{------------------------------------------------------------------------------}
{ TppProducer.GetPrinter }

function TppProducer.GetPrinter: TppPrinter;
begin

  if (FPrinter <> nil) then
    begin
      FPrinter.PrinterSetup := FPrinterSetup;
      Result := FPrinter;
    end

  else if (FPrinterDevice <> nil) then
    Result := FPrinterDevice.Printer

  else if not(ppInMainThread) and (ppPrinter <> nil) then
    begin
      {create a printer for this thread - do not use global printer}
      FPrinter := TppPrinter.Create;
      FPrinter.PrinterSetup := FPrinterSetup;
      Result := FPrinter;
    end

  else
    begin
      {global printer}
      Result := ppPrinter;

      if (Result <> nil) then
        Result.PrinterSetup := FPrinterSetup;
    end;


end; {function, GetPrinter}

{------------------------------------------------------------------------------}
{ TppProducer.HasEmailGroups }

function TppProducer.HasEmailGroups: Boolean;
begin
  Result := False;
  //implemented in the descendents
end; {function, HasEmailGroups}

{------------------------------------------------------------------------------}
{ TppProducer.PrinterSetupGetPrinterEvent }

procedure TppProducer.PrinterSetupGetPrinterEvent(Sender: TObject; var aPrinter: TppPrinter);
begin
  aPrinter := GetPrinter;
end;


{@TppProducer.PrinterSetupChangeQueryEvent
 This is an event handler that is assigned to the PrinterSetup object.  Whenever
 a change is made to the printer setup object, this change can be cancelled by a
 descendant by returning False in the CanChange event.

 TppReport uses this property to disallow changes to PrinterSetup while printing
 is in progress.}

procedure TppProducer.PrinterSetupChangeQueryEvent(Sender: TObject; aNewPageDef: TObject; var CanChange: Boolean);
begin

end; {procedure, PrinterSetupChangeQueryEvent}


{@TppProducer.PrinterSetupPageDefChangeEvent
 This is an event handler that is assigned to the PrinterSetup object.  Whenever
 a change is made to the PageDef of the printer setup object, this event handler
 is called.}

procedure TppProducer.PrinterSetupPageDefChangeEvent(Sender: TObject);
begin

  PageDefChanged;

end; {procedure, PrinterSetupPageDefChangeEvent}


{@TppProducer.PrinterSetupPrintJobChangeEvent
 This is an event handler that is assigned to the PrinterSetup object.  Whenever
 a change is made to the printer setup object, which relates to the print job,
 this event handler is called.}

procedure TppProducer.PrinterSetupPrintJobChangeEvent(Sender: TObject);
begin

  PrinterSetupChanged;

end; {procedure, PrinterSetupPrintJobChangeEvent}

procedure TppProducer.SetXLSSettings(const Value: TppXLSSettings);
begin
  FXLSSettings.Assign(Value);
end;

{******************************************************************************
 *
 ** P R O D U C E R   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppProducerRTTI.RefClass }

class function TraTppProducerRTTI.RefClass: TClass;
begin
  Result := TppProducer;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppProducerRTTI.GetPropList }

class procedure TraTppProducerRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  aPropList.AddProp('Printer');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppProducerRTTI.GetPropRec }

class function TraTppProducerRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;


  {events}
  if ppEqual(aPropName, 'AfterPrint') then
    EventToRec(aPropName, ciProducerAfterPrint, False, aPropRec)

  else if ppEqual(aPropName, 'BeforePrint') then
    EventToRec(aPropName, ciProducerBeforePrint, False, aPropRec)

  else if ppEqual(aPropName, 'OnCancel') then
    EventToRec(aPropName, ciProducerCancel, False, aPropRec)

  else if ppEqual(aPropName, 'OnCancelDialogCreate') then
    EventToRec(aPropName, ciProducerCancelDialogCreate, False, aPropRec)

  else if ppEqual(aPropName, 'OnCancelDialogClose') then
    EventToRec(aPropName, ciProducerCancelDialogClose, False, aPropRec)

  else if ppEqual(aPropName, 'OnAssignPreviewFormSettings') then
    EventToRec(aPropName, ciProducerAssignPreviewFormSettings, False, aPropRec)

  else if ppEqual(aPropName, 'OnFileDeviceCreate') then
    EventToRec(aPropName, ciFileDeviceCreate, False, aPropRec)

  else if ppEqual(aPropName, 'OnPageRequest') then
    EventToRec(aPropName, ciProducerPageRequest, False, aPropRec)

  else if ppEqual(aPropName, 'OnPreviewFormCreate') then
    EventToRec(aPropName, ciProducerPreviewFormCreate, False, aPropRec)

  else if ppEqual(aPropName, 'OnPreviewFormClose') then
    EventToRec(aPropName, ciProducerPreviewFormClose, False, aPropRec)

  else if ppEqual(aPropName, 'OnPrinterDeviceCreate') then
    EventToRec(aPropName, ciPrinterDeviceCreate, False, aPropRec)

  else if ppEqual(aPropName, 'OnPrinterDeviceStateChange') then
    EventToRec(aPropName, ciPrinterDeviceStateChange, True, aPropRec)

  else if ppEqual(aPropName, 'OnCancelDialogCreate') then
    EventToRec(aPropName, ciProducerCancelDialogCreate, False, aPropRec)

  else if ppEqual(aPropName, 'OnPrintDialogCreate') then
    EventToRec(aPropName, ciProducerPrintDialogCreate, False, aPropRec)

  else if ppEqual(aPropName, 'OnPrintDialogClose') then
    EventToRec(aPropName, ciProducerPrintDialogClose, False, aPropRec)

  else if ppEqual(aPropName, 'OnSaveText') then
    EventToRec(aPropName, ciProducerSaveText, True, aPropRec)

  else if ppEqual(aPropName, 'BeforeEmail') then
    EventToRec(aPropName, ciProducerBeforeEmail, False, aPropRec)

  else if ppEqual(aPropName, 'AfterEmail') then
    EventToRec(aPropName, ciProducerAfterEmail, False, aPropRec)

    
  {properties & methods}
  else if ppEqual(aPropName, 'AllowPrintToArchive') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'AllowPrintToFile') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'ArchiveFileName') then
    PropToRec(aPropName, daString, False, aPropRec)

  else if ppEqual(aPropName, 'Cancel') then
    MethodToRec(aPropName, False, aPropRec)

  else if ppEqual(aPropName, 'CancelDialog') then
    ClassPropToRec(aPropName, TppCustomCancelDialog, True, aPropRec)

  else if ppEqual(aPropName, 'Converted') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'ConvertedFromPre40') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'CurrentPage') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'DeviceType') then
    PropToRec(aPropName, daString, False, aPropRec)

  else if ppEqual(aPropName, 'EnableProcessMessages') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'FileDevice') then
    ClassPropToRec(aPropName, TppFileDevice, True, aPropRec)

  else if ppEqual(aPropName, 'Icon') then
    ClassPropToRec(aPropName, TIcon, False, aPropRec)

  else if ppEqual(aPropName, 'Language') then
   EnumPropToRec(aPropName, 'TppLanguageType', True, aPropRec)

  else if ppEqual(aPropName, 'LanguageIndex') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'ModalCancelDialog') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'ModalPreview') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'PreviewForm') then
    ClassPropToRec(aPropName, TppCustomPreviewer, True, aPropRec)

  else if ppEqual(aPropName, 'PreviewFormSettings') then
    ClassPropToRec(aPropName, TppPreviewFormSettings, True, aPropRec)

  else if ppEqual(aPropName, 'PrinterSetup') then
    ClassPropToRec(aPropName, TppPrinterSetup, True, aPropRec)

  else if ppEqual(aPropName, 'Printer') then
    ClassPropToRec(aPropName, TppPrinter, True, aPropRec)

  else if ppEqual(aPropName, 'PrintDialog') then
    ClassPropToRec(aPropName, TppCustomPrintDialog, True, aPropRec)

  else if ppEqual(aPropName, 'Printing') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'Producing') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'PrinterDevice') then
    ClassPropToRec(aPropName, TppPrinterDevice, True, aPropRec)

  else if ppEqual(aPropName, 'Publisher') then
    ClassPropToRec(aPropName, TppPublisher, True, aPropRec)

  else if ppEqual(aPropName, 'SavePrinterSetup') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'SendMail') then
    MethodToRec(aPropName, False, aPropRec)

  else if ppEqual(aPropName, 'ShowAutoSearchDialog') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'ShowCancelDialog') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'ShowPrintDialog') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'TextFileName') then
    PropToRec(aPropName, daString, False, aPropRec)

  else if ppEqual(aPropName, 'TextFileType') then
    EnumPropToRec(aPropName, 'TppFileType', False, aPropRec)

  else if ppEqual(aPropName, 'TextSearchSettings') then
    ClassPropToRec(aPropName, TppTextSearchSettings, True, aPropRec)

  else if ppEqual(aPropName, 'Version') then
    PropToRec(aPropName, daString, True, aPropRec)

  else if ppEqual(aPropName, 'VersionNo') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppProducerRTTI.GetParams }

class function TraTppProducerRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if ppEqual(aMethodName, 'OnSaveText') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Text', daString, nil, '', False, True);
    end

  else if ppEqual(aMethodName, 'OnPrinterDeviceStateChange') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('DeviceState', daEnum, nil,' TppDeviceStateType', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppProducerRTTI.GetPropValue }

class function TraTppProducerRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'AllowPrintToArchive') then
    Boolean(aValue) := TppProducer(aObject).AllowPrintToArchive

  else if ppEqual(aPropName, 'AllowPrintToFile') then
    Boolean(aValue) := TppProducer(aObject).AllowPrintToFile

  else if ppEqual(aPropName, 'ArchiveFileName') then
    String(aValue) := TppProducer(aObject).ArchiveFileName

  else if ppEqual(aPropName, 'CancelDialog') then
    Integer(aValue) := Integer(TppProducer(aObject).CancelDialog)

  else if ppEqual(aPropName, 'Converted') then
    Boolean(aValue) := TppProducer(aObject).Converted

  else if ppEqual(aPropName, 'ConvertedFromPre40') then
    Boolean(aValue) := TppProducer(aObject).ConvertedFromPre40

  else if ppEqual(aPropName, 'CurrentPage') then
    Integer(aValue) := TppProducer(aObject).CurrentPage

  else if ppEqual(aPropName, 'DeviceType') then
    String(aValue) := TppProducer(aObject).DeviceType

  else if ppEqual(aPropName, 'EnableProcessMessages') then
    Boolean(aValue) := TppProducer(aObject).EnableProcessMessages

  else if ppEqual(aPropName, 'FileDevice') then
    Integer(aValue) := Integer(TppProducer(aObject).FileDevice)

  else if ppEqual(aPropName, 'Icon') then
    Integer(aValue) := Integer(TppProducer(aObject).Icon)

  else if ppEqual(aPropName, 'Language') then
    Integer(aValue) := Ord(TppProducer(aObject).Language)

  else if ppEqual(aPropName, 'LanguageIndex') then
    Integer(aValue) := TppProducer(aObject).LanguageIndex

  else if ppEqual(aPropName, 'ModalCancelDialog') then
    Boolean(aValue) := TppProducer(aObject).ModalCancelDialog

  else if ppEqual(aPropName, 'ModalPreview') then
    Boolean(aValue) := TppProducer(aObject).ModalPreview

  else if ppEqual(aPropName, 'PreviewForm') then
    Integer(aValue) := Integer(TppProducer(aObject).PreviewForm)

  else if ppEqual(aPropName, 'PreviewFormSettings') then
    Integer(aValue) := Integer(TppProducer(aObject).PreviewFormSettings)

  else if ppEqual(aPropName, 'PrinterSetup') then
    Integer(aValue) := Integer(TppProducer(aObject).PrinterSetup)

  else if ppEqual(aPropName, 'Printer') then
    Integer(aValue) := Integer(TppProducer(aObject).Printer)

  else if ppEqual(aPropName, 'PrintDialog') then
    Integer(aValue) := Integer(TppProducer(aObject).PrintDialog)

  else if ppEqual(aPropName, 'Printing') then
    Boolean(aValue) := TppProducer(aObject).Printing

  else if ppEqual(aPropName, 'Producing') then
    Boolean(aValue) := TppProducer(aObject).Producing

  else if ppEqual(aPropName, 'PrinterDevice') then
    Integer(aValue) := Integer(TppProducer(aObject).PrinterDevice)

  else if ppEqual(aPropName, 'Publisher') then
    Integer(aValue) := Integer(TppProducer(aObject).Publisher)

  else if ppEqual(aPropName, 'SavePrinterSetup') then
    Boolean(aValue) := TppProducer(aObject).SavePrinterSetup

  else if ppEqual(aPropName, 'ShowAutoSearchDialog') then
    Boolean(aValue) := TppProducer(aObject).ShowAutoSearchDialog

  else if ppEqual(aPropName, 'ShowCancelDialog') then
    Boolean(aValue) := TppProducer(aObject).ShowCancelDialog

  else if ppEqual(aPropName, 'ShowPrintDialog') then
    Boolean(aValue) := TppProducer(aObject).ShowPrintDialog

  else if ppEqual(aPropName, 'TextFileName') then
    String(aValue) := TppProducer(aObject).TextFileName

  else if ppEqual(aPropName, 'TextFileType') then
    Integer(aValue) := Ord(TppProducer(aObject).TextFileType)

  else if ppEqual(aPropName, 'TextSearchSettings') then
    Integer(aValue) := Integer(TppProducer(aObject).TextSearchSettings)

  else if ppEqual(aPropName, 'Version') then
    String(aValue) := TppProducer(aObject).Version

  else if ppEqual(aPropName, 'VersionNo') then
    Integer(aValue) := TppProducer(aObject).VersionNo

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppProducerRTTI.SetPropValue }

class function TraTppProducerRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'AllowPrintToArchive') then
    TppProducer(aObject).AllowPrintToArchive := Boolean(aValue)

  else if ppEqual(aPropName, 'AllowPrintToFile') then
    TppProducer(aObject).AllowPrintToFile := Boolean(aValue)

  else if ppEqual(aPropName, 'ArchiveFileName') then
    TppProducer(aObject).ArchiveFileName := String(aValue)

  else if ppEqual(aPropName, 'DeviceType') then
    TppProducer(aObject).DeviceType := String(aValue)

  else if ppEqual(aPropName, 'Language') then
    TppProducer(aObject).Language := TppLanguageType(aValue)

  else if ppEqual(aPropName, 'LanguageID') then
    TppProducer(aObject).LanguageID := String(aValue)

  else if ppEqual(aPropName, 'ModalCancelDialog') then
    TppProducer(aObject).ModalCancelDialog := Boolean(aValue)

  else if ppEqual(aPropName, 'ModalPreview') then
    TppProducer(aObject).ModalPreview := Boolean(aValue)

  else if ppEqual(aPropName, 'PreviewFormSettings') then
    TppProducer(aObject).PreviewFormSettings := TppPreviewFormSettings(aValue)

  else if ppEqual(aPropName, 'SavePrinterSetup') then
    TppProducer(aObject).SavePrinterSetup := Boolean(aValue)

  else if ppEqual(aPropName, 'ShowAutoSearchDialog') then
    TppProducer(aObject).ShowAutoSearchDialog := Boolean(aValue)

  else if ppEqual(aPropName, 'ShowCancelDialog') then
    TppProducer(aObject).ShowCancelDialog := Boolean(aValue)

  else if ppEqual(aPropName, 'ShowPrintDialog') then
    TppProducer(aObject).ShowPrintDialog := Boolean(aValue)

  else if ppEqual(aPropName, 'TextFileName') then
    TppProducer(aObject).TextFileName := String(aValue)

  else if ppEqual(aPropName, 'TextFileType') then
    TppProducer(aObject).TextFileType := TppFileType(aValue)

  else if ppEqual(aPropName, 'TextSearchSettings') then
    TppProducer(aObject).TextSearchSettings := TppTextSearchSettings(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}
    
{------------------------------------------------------------------------------}
{ TraTppProducerRTTI.CallMethod }

class function  TraTppProducerRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lProducer: TppProducer;
begin

  Result := True;

  lProducer := TppProducer(aObject);

  if ppEqual(aMethodName, 'Cancel') then
    lProducer.Cancel

  else if ppEqual(aMethodName, 'SendMail') then
    lProducer.SendMail

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}



initialization

  TppResourceManager.RegisterFileName('rbPrint');

  RegisterClasses([TppProducer, TppPrinterSetup]);

  raRegisterRTTI(TraTppProducerRTTI);

finalization

  TppResourceManager.UnregisterFileName('rbPrint');

  UnRegisterClasses([TppProducer, TppPrinterSetup]);

  raUnRegisterRTTI(TraTppProducerRTTI);

end.
