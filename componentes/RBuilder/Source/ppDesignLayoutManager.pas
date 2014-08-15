{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignLayoutManager;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Controls,
  ComCtrls,
  Forms,

  ppTypes,
  ppUtils,
  ppClass,
  ppReport,
  ppBands,
  ppPrintr,

  ppDsIntf,
  ppDesignEventHub,
  ppDesignWorkspaceView,
  ppDesignControllers,
  ppDesignToolActions,
  ppDesignSelection,

  ppToolWnTBX,
  ppTBX,
  ppTBXStatusBars,
  ppDesignToolManagerTBX,

  ppDesignDialogController,
  ppDesignDocumentController,
  ppDesignSelectionController,
  ppDesignWorkspaceController;

type

  {TppDesignLayoutManager}
  TppDesignLayoutManager = class(TppDesignModule)
  private
    FDesignControllers: TppDesignControllers;
    FEventHub: TppDesignEventHub;
    FMsgHeight: String;
    FMsgLeft: String;
    FMsgObject: String;
    FMsgObjects: String;
    FMsgReady: String;
    FMsgTop: String;
    FMsgWidth: String;
    FReport: TppReport;
    FRestoreSelection: Boolean;
    FToolActionManager: TppDesignToolActionManager;
    FToolManager: TppDesignToolManager;
    FWorkspaceView: TppDesignWorkspaceView;

    procedure ArrangeStatusBarPanels;
    procedure ehStatusBar_Resize(Sender: TObject);
    procedure InitializeStatusBar;
    procedure FinalizeStatusBar;
    function GetDialogController: TppDesignDialogController;
    function GetDocumentController: TppDesignDocumentController;
    function GetSelection: TppDesignSelection;
    function GetSelectionController: TppDesignSelectionController;
    function GetWorkspaceController: TppDesignWorkspaceController;

  protected
     // housekeeping
    procedure ActiveChanged; override;
    procedure CreateControls;
    procedure ehComponent_AfterPropertyChange(Sender, aParameters: TObject); virtual;
    procedure ehEndUser_AfterPreview(Sender, aParams: TObject); virtual;
    procedure ehEndUser_BeforePreview(Sender, aParams: TObject); virtual;
    procedure ehSelection_AfterChange(Sender, aParameters: TObject); virtual;

    procedure SetComponent(aComponent: TComponent); override;
    procedure SetEventHub(aEventHub: TppDesignEventHub); virtual;
    procedure SetLanguageIndex(aLanguageIndex: Integer); override;
    procedure SetReport(aReport: TppReport); virtual;


  public
    constructor CreateModule(aParent: TWinControl; aComponentDesigner: TppComponentDesigner); override;

    destructor Destroy; override;

    procedure ActiveChanging(var aAllowChange: Boolean); override;
    procedure CloseQuery(var aCanClose: Boolean); override;
    procedure LoadStateInfo; override;
    procedure Notification(aComponent: TComponent; Operation: TOperation); override;
    procedure SaveStateInfo; override;
    procedure SetStatusbarToSelection;

    property DesignControllers: TppDesignControllers read FDesignControllers;
    property DialogController: TppDesignDialogController read GetDialogController;
    property DocumentController: TppDesignDocumentController read GetDocumentController;
    property EventHub: TppDesignEventHub read FEventHub write SetEventHub;
    property Selection: TppDesignSelection read GetSelection;
    property SelectionController: TppDesignSelectionController read GetSelectionController;
    property ToolActionManager: TppDesignToolActionManager read FToolActionManager;
    property ToolManager: TppDesignToolManager read FToolManager;
    property WorkspaceController: TppDesignWorkspaceController read GetWorkspaceController;
    property WorkspaceView: TppDesignWorkspaceView read FWorkspaceView;

  end;

implementation

uses
  ppDsgner;


{******************************************************************************
 *
 ** D E S I G N   L A Y O U T   M A N A G E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.CreateModule }

constructor TppDesignLayoutManager.CreateModule(aParent: TWinControl; aComponentDesigner: TppComponentDesigner);
begin

  inherited CreateModule(aParent, aComponentDesigner);

  Name := 'Design'; // do not localize

  Caption := ppLoadStr(185); {Design}
  OrderIndex := 3;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.Destroy }

destructor TppDesignLayoutManager.Destroy;
begin

  FDesignControllers.Free;
  FDesignControllers := nil;

  FWorkspaceView.Free;
  FWorkspaceView := nil;

  FToolManager.Free;
  FToolManager := nil;

  FToolActionManager.Free;
  FToolActionManager := nil;

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.ActiveChanged }

procedure TppDesignLayoutManager.ActiveChanged;
begin

  if Active then
    begin
      if (FWorkspaceView.Workspace.HandleAllocated) and (FWorkspaceView.Workspace.CanFocus) then
        begin
        FWorkspaceView.Workspace.SetFocus();

        ArrangeStatusBarPanels;
        end;

    end;

end; {procedure, ActiveChanged}

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.ActiveChanging }

procedure TppDesignLayoutManager.ActiveChanging(var aAllowChange: Boolean);
begin

  if (ComponentDesigner = nil) then Exit;

  if (FWorkspaceView = nil) then
    CreateControls();

  if (Active) then
    begin
      FToolManager.ActivateTools(False);
      FinalizeStatusBar;
    end
  else
    begin
      TppDesignerWindow(ComponentDesigner).MainMenu := FToolManager.Menubar;

      FToolManager.ActivateTools(True);

      InitializeStatusBar;

      // do this here due to timing
      if FRestoreSelection then
        begin
          Selection.RestoreState();
          FRestoreSelection := False;
        end;

    end;

  aAllowChange := True;

end;

procedure TppDesignLayoutManager.ArrangeStatusBarPanels;
begin
  StatusBar.Panels[0].Width := StatusBar.Width -
                                (StatusBar.Panels[1].Width + StatusBar.Panels[2].Width +
                                 StatusBar.Panels[3].Width + StatusBar.Panels[4].Width) - 20;
end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.CloseQuery }

procedure TppDesignLayoutManager.CloseQuery(var aCanClose: Boolean);
begin

  FWorkspaceView.Selection.Clear;

end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.CreateControls }

procedure TppDesignLayoutManager.CreateControls;
begin

  if (FReport <> nil) then
    FReport.DesignEventHub := FEventHub;

  // workspace view
  FWorkspaceView := TppDesignWorkspaceView.Create(Self);
  FWorkspaceView.Parent := Parent;
  FWorkspaceView.FreeNotification(Self);

  // design controllers
  FDesignControllers := TppDesignControllers.Create(Self);
  FDesignControllers.WorkspaceView := FWorkspaceView;

  // tool actions and tool manager
  FToolActionManager := TppDesignToolActionManager.Create(Self);

  FToolManager := TppDesignToolManager.Create(Self);
  FToolManager.DesignControllers := FDesignControllers;

  FToolManager.Initialize(Parent, FToolActionManager);

  // assign event hub to design observers
  FDesignControllers.EventHub := FEventHub;
  FToolManager.EventHub := FEventHub;
  FToolActionManager.EventHub := FEventHub;
  FWorkspaceView.EventHub := FEventHub;
  
  SetLanguageIndex(0);

  LoadStateInfo;

end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.ehComponent_PropertyChange}

procedure TppDesignLayoutManager.ehComponent_AfterPropertyChange(Sender, aParameters: TObject);
begin
  SetStatusBartoSelection();

  // set current report modified (might be the main report or a childreport)
  if (WorkspaceView <> nil) and (WorkspaceView.Report <> nil) then
    WorkspaceView.Report.Modified := True;

//  if (FReport <> nil) then
//    FReport.Modified := True;


end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.ehEndUser_AfterPreview}

procedure TppDesignLayoutManager.ehEndUser_AfterPreview(Sender, aParams: TObject);
begin

//  Selection.Report := FReport;  // Selection.RestoreStart will do this

  FRestoreSelection := True;  // used in ActiveChanging
//  Selection.RestoreState(); // delay doing this - see ActiveChanging

  WorkspaceView.UndoManager.Active := True;   // turn on the undo manager

end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.ehEndUser_BeforePreview}

procedure TppDesignLayoutManager.ehEndUser_BeforePreview(Sender, aParams: TObject);
begin

  WorkspaceView.UndoManager.Active := False; // turn off the undo manager
  Selection.SaveState();
//  Selection.Report := nil;  // no need to clear this

end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.ehSelection_AfterChange}

procedure TppDesignLayoutManager.ehSelection_AfterChange(Sender, aParameters: TObject);
begin
  SetStatusBartoSelection();
end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.ehStatusBar_Resize}

procedure TppDesignLayoutManager.ehStatusBar_Resize(Sender: TObject);
begin

  if (Active) then
    ArrangeStatusBarPanels;

end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.InitializeStatusBar}

procedure TppDesignLayoutManager.InitializeStatusBar;
var
  liPanel: Integer;
  lStatusPanel: TppTBXStatusPanel;
begin

  StatusBar.SimplePanel := False;
  StatusBar.Panels.BeginUpdate;
  StatusBar.Panels.Clear;
  StatusBar.OnResize := ehStatusBar_Resize;

  for liPanel := 0 to 4 do
    begin
      lStatusPanel := StatusBar.Panels.Add;
      lStatusPanel.Width := 90;
    end;

  StatusBar.Panels.EndUpdate;

  SetStatusBartoSelection();

end;

{------------------------------------------------------------------------------}
{ TppDesigner.FinalizeStatusBar}

procedure TppDesignLayoutManager.FinalizeStatusBar;
begin

  StatusBar.OnResize := nil;

end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.GetDialogController }

function TppDesignLayoutManager.GetDialogController: TppDesignDialogController;
begin
  Result := FDesignControllers.DialogController;
end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.GetDocumentController }

function TppDesignLayoutManager.GetDocumentController: TppDesignDocumentController;
begin
  Result := FDesignControllers.DocumentController;
end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.GetSelection }

function TppDesignLayoutManager.GetSelection: TppDesignSelection;
begin

  if (FWorkspaceView <> nil) then
    Result := FWorkspaceView.Selection
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.GetSelectionController }

function TppDesignLayoutManager.GetSelectionController: TppDesignSelectionController;
begin

  Result := FDesignControllers.SelectionController;

end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.GetSelectionController }

function TppDesignLayoutManager.GetWorkspaceController: TppDesignWorkspaceController;
begin

  Result := FDesignControllers.WorkspaceController;

end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.LoadStateInfo }

procedure TppDesignLayoutManager.LoadStateInfo;
begin

  FWorkspaceView.LoadPreferences;
  FToolManager.LoadPreferences;

end; {procedure, LoadStateInfo}

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.Notification }

procedure TppDesignLayoutManager.Notification(aComponent: TComponent; Operation: TOperation);
begin

  if ((aComponent = FWorkspaceView) and (Operation = opRemove)) then
    FWorkspaceView := nil;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.SaveStateInfo }

procedure TppDesignLayoutManager.SaveStateInfo;
begin

  FWorkspaceView.SavePreferences;
  FToolManager.SavePreferences;

end; {procedure, SaveStateInfo}

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.SetComponent }

procedure TppDesignLayoutManager.SetComponent(aComponent: TComponent);
begin

  if (aComponent is TppReport) then
    SetReport(TppReport(aComponent))
  else
    SetReport(nil);

end; {procedure, SetComponent}

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.SetEventHub }

procedure TppDesignLayoutManager.SetEventHub(aEventHub: TppDesignEventHub);
begin

  if (FEventHub <> aEventHub) then
    begin
      if (FEventHub <> nil) and not(csDestroying in FEventHub.ComponentState) then
        begin
          FEventHub.EndUserEvents.mcAfterPreview.RemoveNotify(ehEndUser_AfterPreview);
          FEventHub.EndUserEvents.mcBeforePreview.RemoveNotify(ehEndUser_BeforePreview);
          FEventHub.SelectionEvents.mcAfterChange.RemoveNotify(ehSelection_AfterChange);
          FEventHub.ComponentEvents.mcAfterPropertyChange.RemoveNotify(ehComponent_AfterPropertyChange);
        end;

      FEventHub := aEventHub;

      if (FEventHub <> nil) then
        begin
          FEventHub.EndUserEvents.mcAfterPreview.AddNotify(ehEndUser_AfterPreview);
          FEventHub.EndUserEvents.mcBeforePreview.AddNotify(ehEndUser_BeforePreview);
          FEventHub.SelectionEvents.mcAfterChange.AddNotify(ehSelection_AfterChange);
          FEventHub.ComponentEvents.mcAfterPropertyChange.AddNotify(ehComponent_AfterPropertyChange);
        end;

    end;


end;

{------------------------------------------------------------------------------}
{ TppDesignModule.LanguageChanged }

procedure TppDesignLayoutManager.SetLanguageIndex(aLanguageIndex: Integer);
begin

  Caption := ppLoadStr(185); {Design}


  FMsgReady := ppLoadStr(180); {Ready}
  FMsgObject := ppLoadStr(269); {Object}
  FMsgObjects := ppLoadStr(270); {Objects}

  FMsgLeft :=  ppLoadStr(181); {Left}
  FMsgTop := ppLoadStr(182); {Top}
  FMsgWidth := ppLoadStr(183); {Width}
  FMsgHeight := ppLoadStr(184); {Height}

  FToolManager.LanguageChanged();

  SetStatusbarToSelection();

end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.SetReport }

procedure TppDesignLayoutManager.SetReport(aReport: TppReport);
begin

  if (FReport <> nil) then
    begin
      FWorkspaceView.Selection.SelectReport(nil);
      FReport.DesignEventHub := nil;
      FReport.RemoveFreeNotification(Self);
    end;

  FReport := aReport;

  if (FReport <> nil) then
    begin
      FReport.DesignEventHub := FEventHub;
      FReport.FreeNotification(Self);
      SetLanguageIndex(aReport.LanguageIndex);
      if (FWorkspaceView <> nil) then
        FWorkspaceView.Selection.SelectReport(FReport);
    end;


end;

{------------------------------------------------------------------------------}
{ TppDesignLayoutManager.SetStatusbarToSelection }

procedure TppDesignLayoutManager.SetStatusbarToSelection;
var
 lPrinter: TppPrinter;
 lfLeft: Single;
 lfTop: Single;
 lfWidth: Single;
 lfHeight: Single;
 llTop: Longint;
 lBand: TppBand;

begin

  if csDestroying in ComponentState then Exit;

  if (FReport = nil) or (Selection = nil) then Exit;

  {set status selection bounds}
  if (Statusbar = nil) or (Statusbar.Panels.Count < 5) then Exit;

//  if (FDisableUpdates > 0) then Exit;

  {set status Caption based on number of objects in selection}
  if (Selection.Count = 0) then
    Statusbar.Panels[0].Text := FMsgReady {Ready}

  else if (Selection.Count = 1) then
    Statusbar.Panels[0].Text := FMsgObject + ': ' + Selection[0].UserName

  else // if (Selection.Count >= 1) then
    Statusbar.Panels[0].Text := FMsgObjects + ': ' + IntToStr(Selection.Count);

 if Selection.Count = 0 then
    llTop := 0
  else
    begin
      {calc top of selection relative to the band it is in}
      lBand := DesignControllers.SelectionController.GetBandForPos(Selection.SelectionBounds.Top);

      if (lBand <> nil) then
        llTop := Selection.SelectionBounds.ObjectTop - lBand.mmTop
      else
        llTop := 0;
    end;

  {optimize - only get printer if necessary}
  if FReport.Units = utPrinterPixels then
    lPrinter := FReport.Printer
  else
    lPrinter := nil;

  {convert selection bounds to report units}
  lfLeft   := ppFromMMThousandths(Selection.SelectionBounds.ObjectLeft,   FReport.Units, pprtHorizontal, lPrinter);
  lfTop    := ppFromMMThousandths(llTop,                           FReport.Units, pprtVertical,   lPrinter);
  lfWidth  := ppFromMMThousandths(Selection.SelectionBounds.ObjectWidth,  FReport.Units, pprtHorizontal, lPrinter);
  lfHeight := ppFromMMThousandths(Selection.SelectionBounds.ObjectHeight, FReport.Units, pprtVertical,   lPrinter);


  Statusbar.Panels[1].Text  := FMsgLeft  + ': ' + FloatToStrF(lfLeft,   ffGeneral, 7, 0);
  Statusbar.Panels[2].Text  := FMsgTop   + ': ' + FloatToStrF(lfTop,    ffGeneral, 7, 0);
  Statusbar.Panels[3].Text  := FMsgWidth   + ': ' + FloatToStrF(lfWidth,  ffGeneral, 7, 0);
  Statusbar.Panels[4].Text  := FMsgHeight  + ': ' + FloatToStrF(lfHeight, ffGeneral, 7, 0);

end;  {procedure, SetStatusbarToSelection}



initialization
  ppRegisterDesignModule(TppDesignLayoutManager, 'TppDesignerWindow');

finalization
  ppUnRegisterDesignModule(TppDesignLayoutManager, 'TppDesignerWindow');


end.
