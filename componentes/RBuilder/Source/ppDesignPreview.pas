{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }
  
unit ppDesignPreview;

interface

uses
  Classes,
  Controls,
  Forms,
  Dialogs,
  SysUtils,

  ppTypes,
  ppUtils,
  ppPreview,
  ppReport,
  ppViewr,
  ppDsIntf,
  ppDesignEventHub,
  ppToolbarTBX,
  ppTBXStatusBars;

type

  {TppDesignPreviewManager}
  TppDesignPreviewManager = class(TppDesignModule)
  private
    FPreviewer: TppCustomPreview;
    FReport: TppReport;
    FReportStateModified: Boolean;
    FReportStateStream: TMemoryStream;

    function GetEventHub: TppDesignEventHub;
    function GetViewer: TppViewer;
    procedure InitializeStatusBar;
    procedure RestoreReportFromStream;
    procedure SaveReportToStream;
    
  protected
     // housekeeping
    procedure ActiveChanged; override;
    procedure CreateControls; virtual;
    procedure SetComponent(aComponent: TComponent); override;
    procedure SetReport(aReport: TppReport); virtual;

    // internal event-handlers
    procedure ehPreview_AfterPrint(Sender: TObject); virtual;
    procedure ehPreview_BeforePrint(Sender: TObject); virtual;

    // main actions
    procedure CancelPreview; virtual;
    procedure HandleException(aMessage: String); virtual;
    function Preview: Boolean; virtual;
    procedure SetLanguageIndex(aLanguageIndex: Integer); override;
    property EventHub: TppDesignEventHub read GetEventHub;

  public
    constructor CreateModule(aParent: TWinControl; aComponentDesigner: TppComponentDesigner); override;
    destructor Destroy; override;

    procedure ActiveChanging(var aAllowChange: Boolean); override;
    procedure CloseQuery(var CanClose: Boolean); override;
    procedure Notification(aComponent: TComponent; Operation: TOperation); override;

    property Previewer: TppCustomPreview read FPreviewer;
    property Viewer: TppViewer read GetViewer;

  end;


implementation

{******************************************************************************
 *
 ** D E S I G N  P R E V I E W   M A N A G E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.CreateModule }

constructor TppDesignPreviewManager.CreateModule(aParent: TWinControl; aComponentDesigner: TppComponentDesigner);
begin

  inherited CreateModule(aParent, aComponentDesigner);

  Name := 'Preview'; // do not localize

  Caption := ppLoadStr(186); {Preview}
  OrderIndex := 4;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.Destroy }

destructor TppDesignPreviewManager.Destroy;
begin

  FReportStateStream.Free;
  FReportStateStream := nil;

  FPreviewer.Free;
  FPreviewer := nil;

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.ActiveChanged }

procedure TppDesignPreviewManager.ActiveChanged;
begin

  if Active then
    Preview();
  
end; {procedure, ActiveChanged}

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.ActiveChanging }

procedure TppDesignPreviewManager.ActiveChanging(var aAllowChange: Boolean);
begin

  if (ComponentDesigner = nil) then Exit;

  if (FPreviewer = nil) then
    CreateControls();

  if FReport <> nil then
    if Active then
      begin
        CancelPreview();
        aAllowChange := True;
      end
//    else
//      Preview();  // moved to ActiveChanged to allow preview page to be displayed
                    // prior to report generation
end;

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.CancelPreview }

procedure TppDesignPreviewManager.CancelPreview;
begin
  if (Viewer = nil) or (csDestroying in Viewer.ComponentState) then Exit;
  
  Viewer.Cancel;
  Application.ProcessMessages;
  Viewer.Reset;
  Viewer.Report := nil;

  RestoreReportFromStream();

  FPreviewer.AfterPreview;

  if (FReport <> nil) then
    FReport.DSExclude([pppcDesignPreviewing]);

  if (EventHub <> nil) then
    EventHub.EndUserEvents.mcAfterPreview.Notify(Self, nil);

end; {procedure, CancelPreview}

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.CloseQuery }

procedure TppDesignPreviewManager.CloseQuery(var CanClose: Boolean);
begin

  // if clos while previewing, might need to restore the report from stream
  if (FReportStateStream <> nil) then
    RestoreReportFromStream;

end; {procedure, CloseQuery}

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.CreateControls }

procedure TppDesignPreviewManager.CreateControls;
begin

  FPreviewer := TppPreviewPlugIn.CreatePreviewPlugin(Parent);
  FPreviewer.Viewer.DesignViewer := True;
  FPreviewer.Viewer.BorderStyle := bsNone;
  FPreviewer.Viewer.Anchors := [];
  FPreviewer.Viewer.Left := 0;
  FPreviewer.Viewer.Width := FPreviewer.Viewer.Width + 4;
  FPreviewer.Viewer.Height := FPreviewer.Viewer.Height + 2;
  FPreviewer.Viewer.Anchors := [akLeft, akTop, akRight, akBottom];
  FPreviewer.BeforePrint := ehPreview_BeforePrint;
  FPreviewer.AfterPrint := ehPreview_AfterPrint;

end;

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.ehPreview_AfterPrint }

procedure TppDesignPreviewManager.ehPreview_AfterPrint(Sender: TObject);
begin
  FReport.DSExclude([pppcDesignPrinting]);

end;

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.ehPreview_BeforePrint }

procedure TppDesignPreviewManager.ehPreview_BeforePrint(Sender: TObject);
begin
  FReport.DSInclude([pppcDesignPrinting]);
  
end;

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.GetEventHub }

function TppDesignPreviewManager.GetEventHub: TppDesignEventHub;
begin

  if (FReport <> nil) and (FReport.DesignEventHub <> nil) then
    Result := TppDesignEventHub(FReport.DesignEventHub)
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.GetViewer }

function TppDesignPreviewManager.GetViewer: TppViewer;
begin

  if (FPreviewer <> nil) then
    Result := FPreviewer.Viewer
  else
    Result := nil;
    
end;

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.HandleException }

procedure TppDesignPreviewManager.HandleException(aMessage: String);
begin

  CancelPreview();

  MessageDlg(aMessage, mtError, [mbOK], 0);

end;

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.InitializeStatusBar}

procedure TppDesignPreviewManager.InitializeStatusBar;
var
  liPanel: Integer;
  lStatusPanel: TppTBXStatusPanel;
begin

  if (StatusBar = nil) then Exit;

  StatusBar.SimplePanel := False;

  StatusBar.Panels.BeginUpdate;
  StatusBar.Panels.Clear;

  for liPanel := 0 to 1 do
    begin
      lStatusPanel := StatusBar.Panels.Add;
      lStatusPanel.Width := 275;
    end;

  Statusbar.Panels[0].Text := '';
  StatusBar.Panels.EndUpdate;

end; {procedure, InitializeStatusBar}

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.Notification}

procedure TppDesignPreviewManager.Notification(aComponent: TComponent; Operation: TOperation);
begin

  if (aComponent = FReport) and (Operation = opRemove) then
    SetReport(nil);

  inherited;

end; {procedure, Notification}

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.Preview }

function TppDesignPreviewManager.Preview: Boolean;
begin

  Result := False;

  if (FReport = nil) or (FPreviewer = nil) then Exit;

  try
    FReport.DSInclude([pppcDesignPreviewing]);

    if (EventHub <> nil) then
      EventHub.EndUserEvents.mcBeforePreview.Notify(Self, nil);

    SaveReportToStream();

    Viewer.Report := FReport;
    Viewer.Reset;

    FPreviewer.BeforeDesignerTabChange;

    if FReport.InitializeParameters then
      begin
        InitializeStatusBar;
        FPreviewer.StatusBarTbx := StatusBar;
        FPreviewer.OutlineVisible := FReport.OutlineSettings.Enabled;
        FPreviewer.BeforePreview;
        FReport.PrintToDevices;
        Result := True;
      end;

  except on E:Exception do
    HandleException(E.Message);

  end;


end;

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.RestoreReportState }

procedure TppDesignPreviewManager.RestoreReportFromStream;
var
  lSaveTo: TppSaveToType;
begin

  if (FReport = nil) then Exit;

  if (FReportStateStream = nil) or (FReportStateStream.Size = 0) then Exit;

  FReport.BeginUpdate;

//  Include(FDesignerState, dsRestoringReportState);
  lSaveTo := FReport.Template.SaveTo;

  try

    FReport.Template.SaveTo := stFile;

    FReportStateStream.Position := 0;
    FReport.Template.LoadFromStream(FReportStateStream);


  finally
    FReportStateStream.Free;
    FReportStateStream := nil;
    
    FReport.Template.SaveTo := lSaveTo;

    FReport.EndUpdate;
    FReport.Modified := FReportStateModified;

//    Exclude(FDesignerState, dsRestoringReportState);

//    EndUpdate;

  end;

end; {procedure, RestoreReportState}

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.SaveReportState }

procedure TppDesignPreviewManager.SaveReportToStream;
var
  lModuleClass: TClass;
  lSaveTo: TppSaveToType;
begin

  if (FReport = nil) then Exit;

  lModuleClass := GetClass('TraCodeModule');

  // if RAP not being used, exit
  if (lModuleClass = nil) then Exit;

  // if Delphi design-time and report does not contain RAP code, exit
  if gbDesignTime and (FReport.GetModuleForClass(lModuleClass) = nil) then Exit;


//  Include(FDesignerState, dsSavingReportState);

  lSaveTo := FReport.Template.SaveTo;

  try
    FReportStateModified := FReport.Modified;

    FReportStateStream := TMemoryStream.Create;

    FReport.Template.SaveTo := stFile;
    FReport.Template.SaveToStream(FReportStateStream);

    FReport.Modified := False;

  finally
    FReport.Template.SaveTo := lSaveTo;

//    Exclude(FDesignerState, dsSavingReportState);

  end;

end; {procedure, SaveReportState}

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.SetComponent }

procedure TppDesignPreviewManager.SetComponent(aComponent: TComponent);
begin

  inherited;
  
  if (aComponent is TppReport) then
    SetReport(TppReport(aComponent))
  else
    SetReport(nil);

end; {procedure, SetComponent}

{------------------------------------------------------------------------------}
{ TppDesignModule.LanguageChanged }

procedure TppDesignPreviewManager.SetLanguageIndex(aLanguageIndex: Integer);
begin

  Caption := ppLoadStr(186); {Preview}

  if (FPreviewer <> nil) then
    FPreviewer.LanguageChanged();

end;

{------------------------------------------------------------------------------}
{ TppDesignPreviewManager.SetReport }

procedure TppDesignPreviewManager.SetReport(aReport: TppReport);
begin

  if (FReport = aReport) then Exit;

  if Active and (FReport <> nil) and not(csDestroying in FReport.ComponentState) then
    CancelPreview();

  if (FReport <> nil) then
    FReport.RemoveFreeNotification(Self);

  FReport := aReport;

  if (FReport <> nil) then
    begin
      FReport.FreeNotification(Self);
      SetLanguageIndex(FReport.LanguageIndex);
    end;

  if Active and (FReport <> nil) then
    Preview();


end;

initialization
  ppRegisterDesignModule(TppDesignPreviewManager, 'TppDesignerWindow');

finalization
  ppUnRegisterDesignModule(TppDesignPreviewManager, 'TppDesignerWindow');


end.
