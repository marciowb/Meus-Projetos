{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit ppForms;

interface

{$I ppIfDef.pas}

uses
  Classes,
  Controls,
  ExtCtrls,
  Forms,
  Dialogs,
  Graphics,
  Messages,
  StdCtrls,
  ComCtrls,
  Menus,

  ppTypes,
  ppEmailSettings;

type

  {@TppUpDown }
  TppUpDown = class(TUpDown)
    private
      FCanvas: TControlCanvas;
      FBuddy: TControl;

      procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
      procedure SetBuddy(aBuddy: TControl);
    protected
      procedure Paint;
    public
     constructor Create(aOwner: TComponent); override;
     constructor CreateForControl(aControl: TControl); virtual;
     destructor Destroy; override;

     property Buddy: TControl read FBuddy write SetBuddy;
  end; {class, TppUpDown}



  {@TppForm

    TppForm is an abstract ancestor class for the replaceable dialogs in
    ReportBuilder.}

  {@TppForm.LanguageIndex

    Base number to be used when loading strings from the resource file or DLL.
    Setting this property causes the LanguageChanged method to fire, at which
    point all of the strings of the form are reloaded.}

  {@TppForm.ppOnActivate

    This event is equivalent to the OnActivate event of a TForm.  It allows
    ReportBuilder components to connect to this event without disturbing any
    event handler which might be assigned to the OnActivate event of the form.}

  {@TppForm.ppOnClose

    This event is equivalent to the OnClose event of a TForm.  It allows
    ReportBuilder components to connect to this event without disturbing any
    event handler which might be assigned to the OnClose event of the form.}

 {@TppForm.ppOnDestroy

    This event is equivalent to the OnDestroy event of a TForm.  It allows
    ReportBuilder components to connect to this event without disturbing any
    event handler which might be assigned to the OnDestroy event of the form.}

  {@TppForm.Report

    The report component to which the dialog is assigned.  The form usually
    typecasts this property as a TppReport or TppCustomReport and then retrieves
    necessary property value settings from the report.}

  TppForm = class(TForm)
  private
    FppOnActivate: TNotifyEvent;
    FppOnCancel: TNotifyEvent;
    FppOnClose: TNotifyEvent;
    FppOnDestroy: TNotifyEvent;
    FLanguageIndex: Longint;
    FReport: TComponent;
    FTimer: TTimer;

    procedure SetLanguageIndex(Value: Longint);
    procedure SetReport(aReport: TComponent);

  protected
    procedure WMClose(var Message: TMessage); message WM_CLOSE;

    procedure Activate; override;
    procedure CalcScreenCenter(var aLeft, aTop: Integer);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoOnCancel; virtual;
    procedure ehTimer_Notify(Sender: TObject);
    procedure LanguageChanged; virtual;
    procedure ReportAssigned; virtual;

    procedure ExitActiveControl;
    procedure WarningDlg(aMessge: String);

  public
    constructor Create(aOwner: TComponent); override;
    destructor  Destroy; override;

    function CloseQuery: Boolean; override;
    function ShowModal: Integer; override;

    function ToCurrentPixelsPerInch(aQuantity: Integer): Integer;
    function FromCurrentPixelsPerInch(aQuantity: Integer): Integer;

    property LanguageIndex: Longint read FLanguageIndex write SetLanguageIndex;
    property Report: TComponent read FReport write SetReport;

    {events - used internally by TppReport }
    property ppOnActivate: TNotifyEvent read FppOnActivate write FppOnActivate;
    property ppOnCancel: TNotifyEvent read FppOnCancel write FppOnCancel;
    property ppOnClose: TNotifyEvent read FppOnClose write FppOnClose;
    property ppOnDestroy: TNotifyEvent read FppOnDestroy write FppOnDestroy;

  end; {class, TppForm}

  {@TppCustomPreviewer }
  TppCustomPreviewer = class(TppForm)
    private
      FDisplayDocumentName: Boolean;


    protected
      function GetViewer: TObject; virtual;

    public
      constructor Create(aOwner: TComponent); override;
      procedure Init; virtual;

      property DisplayDocumentName: Boolean read FDisplayDocumentName write FDisplayDocumentName;

    published
      property Viewer: TObject read GetViewer;

  end; {class, TppCustomPreviewer}


 {@TppCustomAutoSearchDialog

    This class contains the API used by the report component when it is handling
    AutoSearch dialogs.  If ShowAutoSearchDialog is True, the report component
    retrieves the currently registered AutoSearch dialog class and creates an
    instance of it.  The report then fires the OnAutoSearchDialogCreate event.
    The Init method is then called and it is expected that the search controls
    which will represent the AutoSearchFields of the report will be created at
    this point.  Finally, the report will call the ShowModal event of the form.}

 {@TppCustomAutoSearchDialog.AutoSearchGroups

   Provides access to the AutoSearchFields associated with the report component.
   It is assigned after the OnAutoSearchDialogCreate event has fired so that
   any changes made to the AutoSearchFields in the handler for this event are
   reflected in the AutoSearchDialog.}

  TppCustomAutoSearchDialog = class(TppForm)
    protected
      function GetAutosearchGroups: TPersistent; virtual; abstract;
      procedure SetAutosearchGroups(aAutosearchGroups: TPersistent); virtual; abstract;

    public
      procedure Init; virtual; abstract;
      procedure AssignAutoSearchFields(aAutoSearchFields: TList); virtual; abstract;

      property AutoSearchGroups: TPersistent read GetAutoSearchGroups write SetAutoSearchGroups;

  end; {class, TppCustomAutoSearchDialog}

  {@TppCustomReportExplorer }
  TppCustomReportExplorer = class(TppForm)
    private
      FFormSettingsRemembered: Boolean;
      FMergeMenu: TMainMenu;

    protected
      procedure SetFormSettingsRemembered(aValue: Boolean);
      function  GetReportExplorer: TComponent; virtual; abstract;
      procedure SetReportExplorer(aComponent: TComponent); virtual; abstract;

    public
      constructor Create(aComponent: TComponent); override;

      procedure ehFilePrintClick(Sender: TObject); virtual; abstract;
      procedure ehFilePrintPreviewClick(Sender: TObject); virtual; abstract;
      procedure ehFileEmailClick(Sender: TObject); virtual; abstract;
      procedure ehFileOpenClick(Sender: TObject); virtual; abstract;
      procedure ehFileNewFolderClick(Sender: TObject); virtual; abstract;
      procedure ehFileNewReportClick(Sender: TObject); virtual; abstract;
      procedure ehFileDeleteClick(Sender: TObject); virtual; abstract;
      procedure ehFileRenameClick(Sender: TObject); virtual; abstract;
      procedure ehViewListClick(Sender: TObject); virtual; abstract;
      procedure ehViewDetailsClick(Sender: TObject); virtual; abstract;
      procedure ehViewToolbarClick(Sender: TObject); virtual; abstract;
      procedure ehViewStatusBarClick(Sender: TObject); virtual; abstract;
      procedure ehFileCloseClick(Sender: TObject); virtual; abstract;
      procedure ehHelpAboutClick(Sender: TObject); virtual; abstract;
      procedure ehHelpTopicsClick(Sender: TObject); virtual; abstract;
      procedure ehUpOneLevelClick(Sender: TObject); virtual; abstract;
      procedure ehFileDesignClick(Sender: TObject); virtual; abstract;
      procedure ehEmptyRecycleBinClick(Sender: TObject); virtual; abstract;

      procedure Initialize; virtual; abstract;
      procedure Refresh; virtual; abstract;

      property ReportExplorer: TComponent read GetReportExplorer write SetReportExplorer;

      property FormSettingsRemembered: Boolean read FFormSettingsRemembered;
      property MergeMenu: TMainMenu read FMergeMenu write FMergeMenu;
  end;

  {@TppCustomPrintDialog }
  TppCustomPrintDialog = class(TppForm)
  private
    FAllowEmail: Boolean;
    FAllowPrintToArchive: Boolean;
    FAllowPrintToFile: Boolean;
    FArchiveFileName: String;
    FDefaultFileExt: String;
    FDeviceType: String;
    FDefaultFileDeviceType: String;
    FFileFilter: String;
    FTextFileName: String;
    FPageRequest: TObject;
    FPrinter: TObject;
    FPrinterChanged: Boolean;
    FPrintToArchive: Boolean;
    FPrintToFile: Boolean;
    FDesignState: TppDesignStates;

  protected
    function GetBackgroundPrintSettings: TObject; virtual; abstract;
    procedure SetPageRequest(aPageRequest: TObject); virtual;
    procedure SetBackgroundPrintingActive(aBackgroundPrintingActive: Boolean); virtual; abstract;
    procedure SetBackgroundPrintSettings(aBackgroundPrintSettings: TObject); virtual; abstract;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Init; virtual; abstract;

    property AllowEmail: Boolean read FAllowEmail write FAllowEmail;
    property AllowPrintToArchive: Boolean read FAllowPrintToArchive write FAllowPrintToArchive;
    property AllowPrintToFile: Boolean read FAllowPrintToFile write FAllowPrintToFile;
    property ArchiveFileName: String read FArchiveFileName write FArchiveFileName;
    property DeviceType: String read FDeviceType write FDeviceType;
    property DefaultFileDeviceType: String read FDefaultFileDeviceType write FDefaultFileDeviceType;
    property DefaultFileExt: String read FDefaultFileExt write FDefaultFileExt;
    property DesignState: TppDesignStates read FDesignState write FDesignState;
    property BackgroundPrintSettings: TObject read GetBackgroundPrintSettings write SetBackgroundPrintSettings;
    property FileFilter: String read FFileFilter write FFileFilter;
    property PageRequest: TObject read FPageRequest write SetPageRequest;
    property PrinterChanged: Boolean read FPrinterChanged write FPrinterChanged;
    property Printer: TObject read FPrinter write FPrinter;
    property PrintToArchive: Boolean read FPrintToArchive write FPrintToArchive;
    property PrintToFile: Boolean read FPrintToFile write FPrintToFile;
    property TextFileName: String read FTextFileName write FTextFileName;

  end; {class TppCustomPrintDialog}

  {@TppCustomCancelDialog }
  TppCustomCancelDialog = class(TppForm)
  private
    FActiveForm: TForm;
    FAllowPrintCancel: Boolean;
    FModal: Boolean;
    FPrintProgress: String;
    FTimer: TTimer;
    FppOnShowModal: TNotifyEvent;

    procedure FormHideEvent;
    procedure FormShowEvent;
    procedure SetPrintProgress(Value: String);
    procedure TimerEvent(Sender: TObject);

  protected
    procedure WMShowWindow(var Message: TMessage); message WM_SHOWWINDOW;

    procedure PrintProgressChanged; virtual;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure ppShowModal;

    property AllowPrintCancel: Boolean read FAllowPrintCancel write FAllowPrintCancel;
    property PrintProgress: String read FPrintProgress write SetPrintProgress;

    {event used internally by Report}
    property ppOnShowModal: TNotifyEvent read FppOnShowModal write FppOnShowModal;

  end; {class, TppCustomCancelDialog}


  {@TppCustomNoDataDialog }
  TppCustomNoDataDialog = class(TppForm)

  end; {class, TppCustomNoDataDialog}


  {@TppCustomAboutDialog }
  TppCustomAboutDialog = class(TppForm)
  end; {class, TppCustomAboutDialog}


  {@TppCustomDemoDialog }
  TppCustomDemoDialog = class(TppForm)
  private

  end; {class, TppCustomDemoDialog}


  {@TppCustomTemplateDialog }
  TppCustomTemplateDialog = class(TppForm)
  private
    FDataPipeline: TComponent;
    FDialogType: TppDialogType;
    FFolderId: Integer;
    FItemType: Integer;
    FNameField: String;
    FOnHelpClick: TNotifyEvent;

  protected
    procedure DoOnHelpClick;
    function  GetTemplateName: String; virtual; abstract;
    function  GetTemplateNames: TStrings; virtual; abstract;
    function  HelpEventAssigned: Boolean;
    procedure SetDataPipeline(aComponent: TComponent); virtual;
    procedure SetTemplateName(aTemplateName: String); virtual; abstract;
    procedure SetTemplateNames(aTemplateNames: TStrings); virtual; abstract;

  public
    property DataPipeline: TComponent read FDataPipeline write SetDataPipeline;
    property DialogType: TppDialogType read FDialogType write FDialogType;
    property ItemType: Integer read FItemType write FItemType;
    property NameField: String read FNameField write FNameField;
    property OnHelpClick: TNotifyEvent read FOnHelpClick write FOnHelpClick;
    property FolderId: Integer read FFolderId write FFolderId;
    property TemplateName: String read GetTemplateName write SetTemplateName;
    property TemplateNames: TStrings read GetTemplateNames write SetTemplateNames;

  end; {class, TppCustomTemplateDialog}


  {@TppCustomTemplateErrorDialog }
  TppCustomTemplateErrorDialog = class(TppForm)
  private

  protected
    function  GetErrorMessage: String; virtual; abstract;
    procedure SetErrorMessage(aMessage: String); virtual; abstract;

  public
    property ErrorMessage: String read GetErrorMessage write SetErrorMessage;

  end; {class, TppCustomTemplateErrorDialog}

  TppCustomEmailDialog = class(TppForm)
  private
    FEmailSettings: TppEmailSettings;

  protected
    procedure SetEmailSettings(const Value: TppEmailSettings); virtual;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Init; virtual; abstract;
    property EmailSettings: TppEmailSettings read FEmailSettings write SetEmailSettings;

  end;


  {register procedures}
  function  ppFormClassList: TStringList;
  function  ppGetFormClass(aAncestorClass: TFormClass): TFormClass;
  procedure ppRegisterForm(aAncestorClass, aDescendantClass: TFormClass);
  procedure ppUnRegisterForm(aAncestorClass: TFormClass);

implementation

uses
  ppUtils;

var
  FFormClassList: TStringList = nil;


{******************************************************************************
 *
 ** T p p U p D o w n
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppUpDown.Create }

constructor TppUpDown.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  Min := -100;

  {create a canvas}
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppUpDown.Destroy }

destructor TppUpDown.Destroy;
begin

  FCanvas.Free;
  
  inherited Destroy;

end; {destructor, Destroy}


{------------------------------------------------------------------------------}
{ TppUpDown.CreateForControl }

constructor TppUpDown.CreateForControl(aControl: TControl);
begin

  Create(aControl.Owner);

  Parent := aControl.Parent;
  SetBuddy(aControl);

end; {constructor, CreateWithBuddy}

{------------------------------------------------------------------------------}
{ TppUpDown.SetBuddy }

procedure TppUpDown.SetBuddy(aBuddy: TControl);
begin
  FBuddy := aBuddy;

  Left   := FBuddy.left + FBuddy.Width - Width -2;
  Top    := FBuddy.Top + 2;
  Height := FBuddy.Height - 4;

end; {procdure, SetBuddy}

{------------------------------------------------------------------------------}
{ TppUpDown.WMPaint }

procedure TppUpDown.WMPaint(var Message: TWMPaint);
begin

  inherited;

  // do custom painting when not running on XP
  // (when using XPMan, the extra painting is not needed and looks bad)
  if not(ppIsWinXP)then
    Paint;

end; {procedure, WMPaint}

{------------------------------------------------------------------------------}
{ TppUpDown.Paint }

procedure TppUpDown.Paint;
var
  liCenter: Integer;
  liStartY: Integer;
  liCount: Integer;

begin

  FCanvas.Pen.Color := clBlack;

  liCenter := (Width div 2) - 1;

  liStartY := 2;

  {draw top arrow}
  for liCount := 0 to 2 do
    begin
      FCanvas.MoveTo(liCenter - liCount,   liStartY + liCount);
      FCanvas.LineTo(liCenter + liCount+1, liStartY + liCount);
    end;

  liStartY := Height - 3;

  {draw bottom arrow}
  for liCount := 0 to 2 do
    begin
      FCanvas.MoveTo(liCenter - liCount,   liStartY - liCount);
      FCanvas.LineTo(liCenter + liCount+1, liStartY - liCount);
    end;


end; {procedure, Paint}

{******************************************************************************
 *
 ** F O R M
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppForm.Create }

constructor TppForm.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FppOnActivate  := nil;
  FppOnCancel    := nil;
  FppOnClose     := nil;
  FppOnDestroy   := nil;
  FLanguageIndex := 0;
  FReport        := nil;

  ParentFont := True;

  Font.Height := Graphics.DefFontData.Height;

end; {constructor, Create}


{------------------------------------------------------------------------------}
{ TppForm.Destroy }

destructor TppForm.Destroy;
begin

  if Assigned(FppOnDestroy) then FppOnDestroy(Self);

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{@TppForm.CloseQuery

  Fires when the form begins to close, but before the form has been destroyed.
  Overriding this methods is superior to coding a WMClose, which doesn't get
  called when the Close box is clicked or triggering the OnClose from
  the destroy method , which is too late to access any of the form's internals
  and makes the event far less useful.}

function TppForm.CloseQuery: Boolean;
begin

  if Assigned(FppOnClose) then FppOnClose(Self);

  Result := inherited CloseQuery;

end;

{------------------------------------------------------------------------------}
{ TppForm.Activate }

procedure TppForm.Activate;
begin

  inherited Activate;

  if Assigned(FppOnActivate) then
    begin
      FTimer := TTimer.Create(nil);
      FTimer.Interval := 10;
      FTimer.Enabled := True;
      FTimer.OnTimer := ehTimer_Notify;
    end;

end;


{------------------------------------------------------------------------------}
{ TppForm.ehTimer_Notify}

procedure TppForm.ehTimer_Notify(Sender: TObject);
begin

  FTimer.Free;
  FTimer := nil;

  {this allows a modal previewer to continue the report}
  if Assigned(FppOnActivate) then FppOnActivate(Self);

end;

 
{------------------------------------------------------------------------------}
{ TppForm.CalcScreenCenter}

procedure TppForm.CalcScreenCenter(var aLeft, aTop: Integer);
begin

  aLeft := Trunc((Screen.Width / 2) - (Width / 2));
  aTop := Trunc((Screen.Height / 2) - (Height / 2));

end; {procedure, CalcScreenCenter}

{------------------------------------------------------------------------------}
{ TppComponentDesigner.CreateParams}

procedure TppForm.CreateParams(var Params: TCreateParams);
begin

  inherited CreateParams(Params);

{$IFDEF Delphi9}
  // nothing
{$ELSE}
  if (fsModal in FormState) then
    if (Screen.ActiveForm <> nil) and not(csDestroying in Screen.ActiveForm.ComponentState) then
      Params.WndParent := Screen.ActiveForm.Handle;
{$ENDIF}

end; {procedure, CreateParams}

{------------------------------------------------------------------------------}
{ TppForm.WMClose }

procedure TppForm.WMClose(var Message: TMessage);
begin

  {note: WMClose never fires when the Close button of the form is pressed
         so this code is useless}
  {if Assigned(FppOnClose) then FppOnClose(Self);}

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppForm.SetLanguageIndex }

procedure TppForm.SetLanguageIndex(Value: Longint);
begin
  FLanguageIndex := Value;

  LanguageChanged;
end;

{------------------------------------------------------------------------------}
{ TppForm.LanguageChanged }

procedure TppForm.LanguageChanged;
begin

end;

function TppForm.ShowModal: Integer;
begin

{$IFDEF Delphi9}
  if (PopupParent = nil) then
    PopupParent := Screen.ActiveForm;
{$ELSE}
  if HandleAllocated then
    RecreateWnd;
{$ENDIF}

  Result := inherited ShowModal;

end;

{------------------------------------------------------------------------------}
{ TppForm.SetReport }

procedure TppForm.SetReport(aReport: TComponent);
begin
  FReport := aReport;
  ReportAssigned;
end;

{------------------------------------------------------------------------------}
{ TppForm.ReportAssigned }

procedure TppForm.ReportAssigned;
begin

end;

{------------------------------------------------------------------------------}
{ TppForm.WarningDlg }

procedure TppForm.WarningDlg(aMessge: String);
begin
  {set ModalResult to none, because when the Default button of a dialog
   is activated by the keyboard and an error occurrs we do not want to
   close the dialog}
  ModalResult := mrNone;
  MessageDlg(aMessge, mtWarning, [mbOK], 0);

end; {procedure, WarningDlg}

{------------------------------------------------------------------------------}
{ TppForm.ExitActiveControl }

procedure TppForm.ExitActiveControl;
begin
  {note: this method can be called from the close button of the dialog;
         when the close button is the default button the OnExit event of
         an active TEdit will not fire when the default button is activated
         by the keyboard }
  
  {if ActiveControl is an Edit box, fire the OnExit event}
  if (ActiveControl is TEdit) and Assigned(TEdit(ActiveControl).OnExit) then
    TEdit(ActiveControl).OnExit(ActiveControl);

end;

{------------------------------------------------------------------------------}
{ TppForm.DoOnCancel }

procedure TppForm.DoOnCancel;
begin
  if Assigned(FppOnCancel) then FppOnCancel(Self);
end; {procedure, DoOnCancel}



{------------------------------------------------------------------------------}
{ TppForm.ToCurrentPixelsPerInch }

function TppForm.ToCurrentPixelsPerInch(aQuantity: Integer): Integer;
begin

  Result := Round(aQuantity * Screen.PixelsPerInch / PixelsPerInch);

end; { function, ScaleQuantity )

{------------------------------------------------------------------------------}
{ TppForm.FromCurrentPixelsPerInch }

function TppForm.FromCurrentPixelsPerInch(aQuantity: Integer): Integer;
begin

  Result := Round(aQuantity * PixelsPerInch / Screen.PixelsPerInch);

end; { function, FromCurrentPixelsPerInch )

{******************************************************************************
 *
 ** C U S T O M   R E P O R T   E X P L O R E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.Create }

constructor TppCustomReportExplorer.Create(aComponent: TComponent);
begin

  inherited Create(aComponent);

  FFormSettingsRemembered := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomReportExplorer.SetFormSettingsRemembered }

procedure TppCustomReportExplorer.SetFormSettingsRemembered(aValue: Boolean);
begin

  FFormSettingsRemembered := aValue;

end; {constructor, SetFormSettingsRemembered}


{******************************************************************************
 *
 ** P R I N T   P R E V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomPreviewer.Create }

constructor TppCustomPreviewer.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDisplayDocumentName := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomPreviewer.GetViewer }

function TppCustomPreviewer.GetViewer: TObject;
begin
  Result := nil;
end; {function, GetViewer}

{------------------------------------------------------------------------------}
{ TppCustomPreviewer.Init }

procedure TppCustomPreviewer.Init;
begin

end; {procedure, Init}

{******************************************************************************
 *
 ** P R I N T   D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomPrintDialog.Create }

constructor TppCustomPrintDialog.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FAllowEmail := False;
  FAllowPrintToArchive := False;
  FAllowPrintToFile := False;
  FArchiveFileName  := '';
  FDesignState := [];
  FDeviceType       := '';
  FDefaultFileDeviceType := '';
  FPrinterChanged   := False;
  FPrintToArchive   := False;
  FPrintToFile      := False;
  FPrinter          := nil;
  FTextFileName     := '';

end; {constructor, Create}
    
{------------------------------------------------------------------------------}
{ TppCustomPrintDialog.Destroy }

destructor TppCustomPrintDialog.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCustomPrintDialog.SetPageRequest }

procedure TppCustomPrintDialog.SetPageRequest(aPageRequest: TObject);
begin

  FPageRequest := aPageRequest;

end; {procedure, SetPageRequest}


{******************************************************************************
 *
 ** C A N C E L   D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomCancelDialog.Create }

constructor TppCustomCancelDialog.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FActiveForm       := nil;
  FAllowPrintCancel := False;
  FModal            := False;
  FPrintProgress    := '';
  FppOnShowModal      := nil;

  {create timer used to implement ppCloseModal}
  FTimer := TTimer.Create(Self);
  FTimer.Enabled  := False;
  FTimer.Interval := 10;
  FTimer.OnTimer  := TimerEvent;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomCancelDialog.Destroy }

destructor TppCustomCancelDialog.Destroy;
begin

  {call form hide event handler here, because for in many cases WMShowWindow
   never fires the hide event}
  FormHideEvent;

  FTimer.Free;
  inherited Destroy;
end; {destructor, Destroy}


{------------------------------------------------------------------------------}
{ TppCustomCancelDialog.WMShowWindow}

procedure TppCustomCancelDialog.WMShowWindow(var Message: TMessage);
begin

  if (Message.wParam = 1) then

    FormShowEvent
  else
    FormHideEvent;

  inherited;

end; {procedure, WMShowWindow}


{------------------------------------------------------------------------------}
{ TppCustomCancelDialog.SetPrintProgress }

procedure TppCustomCancelDialog.SetPrintProgress(Value: String);
begin
  FPrintProgress := Value;

  PrintProgressChanged;
end;

{------------------------------------------------------------------------------}
{ TppCustomCancelDialog.PrintProgressChanged }

procedure TppCustomCancelDialog.PrintProgressChanged;
begin

end;

{------------------------------------------------------------------------------}
{ TppCustomCancelDialog.FormShow}

procedure TppCustomCancelDialog.FormShowEvent;
begin

  if FModal then Exit;

  {disable the currently active form}
  FActiveForm := Screen.ActiveForm;

  {if (FActiveForm <> nil) then
    FActiveForm.Enabled := False;}

end; {procedure, FormShow}

{------------------------------------------------------------------------------}
{ TppCustomCancelDialog.FormHide}

procedure TppCustomCancelDialog.FormHideEvent;
begin

  if FModal then Exit;

  {re-enable the previously active form}
  if (FActiveForm <> nil) and not(FActiveForm.Enabled) then
    begin

      FActiveForm.Enabled := True;

      if (FActiveForm.CanFocus) and (Screen.ActiveForm = Self) then
        FActiveForm.SetFocus;

    end;

end; {procedure, FormHide}


{------------------------------------------------------------------------------}
{ TppCustomCancelDialog.ppShowModal}

procedure TppCustomCancelDialog.ppShowModal;
begin
  FModal := True;

  {use timer to trigger an event just after the show modal call}
  FTimer.Enabled := True;

  ShowModal;

end; {procedure, ppShowModal}


{------------------------------------------------------------------------------}
{ TppCustomCancelDialog.TimerEvent }

procedure TppCustomCancelDialog.TimerEvent;
begin

  FTimer.Enabled := False;

  if Assigned(FppOnShowModal) then FppOnShowModal(Self);
    
end; {procedure, TimerEvent}


{******************************************************************************
 *
 ** C U S T O M   T E M P L A T E   D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomTemplateDialog.DoOnHelpClick }

procedure TppCustomTemplateDialog.DoOnHelpClick;
begin
  if HelpEventAssigned then FOnHelpClick(Self);
end; {function, DoOnHelpClick}

{------------------------------------------------------------------------------}
{ TppCustomTemplateDialog.HelpEventAssigned }

function TppCustomTemplateDialog.HelpEventAssigned: Boolean;
begin
  Result := Assigned(FOnHelpClick);
end; {function, HelpEventAssigned}

{******************************************************************************
 *
 ** T E M P L A T E   D I A L O G
 *
{******************************************************************************}

procedure TppCustomTemplateDialog.SetDataPipeline(aComponent: TComponent);
begin
  FDataPipeline := aComponent;
end; {function, SetDataPipeline}

{******************************************************************************
 *
 ** C U S T O M   E M A I L   D I A L O G
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{TppCustomEmailDialog.Create}

constructor TppCustomEmailDialog.Create(aOwner: TComponent);
begin
  inherited;

  FEmailSettings := TppEmailSettings.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{TppCustomEmailDialog.Destroy}

destructor TppCustomEmailDialog.Destroy;
begin
  inherited;

  FEmailSettings.Free;
  FEmailSettings := nil;

end; {destructor, destroy}

{------------------------------------------------------------------------------}
{TppCustomEmailDialog.SetEmailSettings}

procedure TppCustomEmailDialog.SetEmailSettings(const Value: TppEmailSettings);
begin
  FEmailSettings.Assign(Value);

end; {procedure, SetEmailSettings}


{******************************************************************************
 *
 ** R E G I S T E R   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ppGetFormClassList - this routine creates the stringlist which will contain
  the class reference variables for the ReportBuilder forms.  The register
  routines always call this routine first, thus forcing the creation of the
  stringlist. This approach was taken because unit loading sequences would not
  guarantee that ppForm initialization fired first, resulting in a nil
  ppFormClassList. This function solves that problem...}

function ppFormClassList: TStringList;
begin
  if FFormClassList = nil then
    FFormClassList := TStringList.Create;

  Result := FFormClassList;
end;


{@ppRegisterForm
 Call this procedure to register a replacement for any of the dialogs you see in
 the ReportBuilder user interface.  See the 'Customizing the Report Explorer
 Form' tutorial in the Developer's Guide for an example of how to call this
 procedure.}

procedure ppRegisterForm(aAncestorClass, aDescendantClass: TFormClass);
var
  lClassList: TStringList;
begin

  ppUnRegisterForm(aAncestorClass);

  {register class so descendant can be instantiated}
  RegisterClass(aDescendantClass);

  lClassList := ppFormClassList;

  lClassList.AddObject(aAncestorClass.ClassName, TObject(aDescendantClass));

end;


{@ppUnRegisterForm
 Call this procedure to unregister a replacement for any of the dialogs you see
 in the ReportBuilder user interface.  See the 'Customizing the Report Explorer
 Form' tutorial in the Developer's Guide for an example of how to call this
 procedure.}

procedure ppUnRegisterForm(aAncestorClass: TFormClass);
var
  liIndex: Integer;
  lFormClass: TFormClass;
  lClassList: TStringList;

begin

  if (aAncestorClass = nil) then Exit;

  if (FFormClassList = nil) then Exit;

  lClassList := ppFormClassList;

  liIndex := lClassList.IndexOf(aAncestorClass.ClassName);

  if liIndex >= 0 then
    begin
      lFormClass := TFormClass(lClassList.Objects[liIndex]);

      UnRegisterClass(lFormClass);

      lClassList.Delete(liIndex);
    end;
end;

{------------------------------------------------------------------------------}
{ ppGetFormClass }

function ppGetFormClass(aAncestorClass: TFormClass): TFormClass;
var
  liIndex: Integer;
  lClassList: TStringList;

begin
  lClassList := ppFormClassList;

  liIndex :=  lClassList.IndexOf(aAncestorClass.ClassName);

  if liIndex >= 0 then
    Result := TFormClass(lClassList.Objects[liIndex])
  else
    Result := nil;

end;


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

finalization

  FFormClassList.Free;
  FFormClassList := nil;
  
end.
