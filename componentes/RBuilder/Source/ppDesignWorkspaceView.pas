{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignWorkspaceView;

interface

{$I ppIfDef.pas}

uses
  windows,
  Types,
  Classes,
  Controls,
  ExtCtrls,
  Forms,
  Graphics,
  Menus,
  Messages,
  StdCtrls,
  SysUtils,
  Tabs,

  ppTypes,
  ppUtils,
  ppPrintr,
  ppComm,
  ppClass,
  ppReport,
  ppSubRpt,
  ppIniStorage,
  ppRuler,
  ppScrollbox,

  ppDesignObserver,
  ppDesignControls,
  ppDesignEventHub,
  ppDesignerWorkspace,
  ppDesignSelection,
  ppToolResources,
  ppUndo,
  
  ppTBX,
  ppTBXThemes,
  ppTBXDkPanels;

type


  {TppScrollableWorkspace

    - manages scrollbox,
              workspace,
              ruler panels,
              rulers }

  TppScrollableWorkspace = class(TppDesignObserver)
  private
    FHorizontalRuler: TppRuler;
    FHorizontalRulerArea: TPanel;
    FPanelParent: TPanel;
    FParent: TWinControl;
    FScrollbox: TppScrollbox;
    FVerticalRulerArea: TPanel;
    FVerticalRulers: TppRulerCollection;
    FWorkspace: TppWorkspace;
    FLastVertScrollPos: Integer;
  protected
    procedure AddVerticalRuler(aRuler: TppRuler);
    procedure CreateControls(aParent: TWinControl); virtual;
    procedure ehBand_DesignControlCreate(Sender, aParameters: TObject); virtual;
    procedure ehReport_LoadEnd(Sender, aParameters: TObject); virtual;
    procedure ehReport_UnitsChange(Sender, aParameters: TObject); virtual;
    procedure ehRuler_GetPrinter(Sender: TObject; var aPrinter: TppPrinter); virtual;
    procedure ehScrollableArea_VerticalScroll(Sender: TObject; aPosition: SmallInt; aEventType: TppVerticalScrollEventType);  virtual;
    procedure ehScrollableArea_HorizontalScroll(Sender: TObject; aPosition: SmallInt; aEventType: TppHorizontalScrollEventType); virtual;
    procedure ehScrollbox_ScrollInView(Sender: TObject; aControl: TControl; var aAccept: Boolean);
    procedure ehWorkspace_Resize(Sender: TObject); virtual;
    procedure ehScrollbox_MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean); virtual;
    procedure ScrollVertRulers;
    procedure SetUnits(aUnits: TppUnitType); virtual;
    procedure SetReport(const Value: TppCustomReport); override;
    procedure SetEventHub(aEventHub: TppDesignEventHub); override;
    procedure SetParent(const aParent: TWinControl); virtual;
    procedure TBMThemeChange(var Message: TMessage); message TBM_THEMECHANGE;
    procedure UpdateRulerColor; virtual;
    procedure UpdateScrollableArea;  virtual;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetRulerColor(aColor: TColor); virtual;

    property HorizontalRuler: TppRuler read FHorizontalRuler;
    property HorizontalRulerArea: TPanel read FHorizontalRulerArea;
    property Scrollbox: TppScrollbox read FScrollbox;
    property VerticalRulers: TppRulerCollection read FVerticalRulers;
    property VerticalRulerArea: TPanel read FVerticalRulerArea;
    property Workspace: TppWorkspace read FWorkspace;
    property Parent: TWinControl read FParent write SetParent;

  end;

  TppReportTabView = class;

  {TppDesignWorkspaceView

   - extends scrollable workspace to include
      DesignControlManager,
      Selection,
      UndoManager,
      Report Tabs }

  TppDesignWorkspaceView = class(TppScrollableWorkspace)
  private
    FDesignControlManager: TppDesignControlManager;
    FDefaultFont: TFont;
    FDefaultTextAlignment: TppTextAlignment;
    FLiveData: Boolean;
    FReportTabView: TppReportTabView;
    FSelection: TppDesignSelection;
    FSelectReportButton: TppTBXButton;
    FUndoManager: TppUndoManager;
    FShowDesignGuides: Boolean;


  protected
    procedure CreateControls(aParent: TWinControl); override;
    procedure ehComponent_AfterPropertyChange(Sender, aParams: TObject); virtual;
    procedure ehComponent_BeforePropertyChange(Sender, aParams: TObject); virtual;
    procedure ehReport_AddSubreport(Sender, aParameters: TObject); virtual;
    procedure ehReport_LanguageChange(Sender, aParams: TObject); virtual;
    procedure ehReport_CaptionChange(Sender, aParams: TObject); virtual;
    procedure ehReport_LoadEnd(Sender, aParameters: TObject); override;
    procedure ehReport_NewEnd(Sender, aParameters: TObject); virtual;
    procedure ehReport_RemoveSubreport(Sender, aParameters: TObject); virtual;
    procedure ehSelectReportButton_Click(Sender: TObject); virtual;
    procedure ehComponent_ZOrderChange(Sender, aParameters: TObject);
    procedure ehReport_LoadStart(Sender, aParameters: TObject); virtual;
    function GetReportTabs: TTabSet; virtual;
    procedure InitializeView; virtual;
    procedure SetDefaultFont(const Value: TFont);
    procedure SetEventHub(aEventHub: TppDesignEventHub); override;
    procedure SetLiveData(const Value: Boolean);
    procedure SetReport(const Value: TppCustomReport); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadPreferences; virtual;
    procedure SavePreferences; virtual;
    
    procedure SetRulerColor(aColor: TColor); override;

    property DesignControlManager: TppDesignControlManager read FDesignControlManager;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property DefaultTextAlignment: TppTextAlignment read FDefaultTextAlignment write FDefaultTextAlignment;
    property LiveData: Boolean read FLiveData write SetLiveData;
    property ReportTabs: TTabSet read GetReportTabs;
    property Selection: TppDesignSelection read FSelection;
    property SelectReportButton: TppTBXButton read FSelectReportButton;
    property UndoManager: TppUndoManager read FUndoManager;
    property ShowDesignGuides: Boolean read FShowDesignGuides write FShowDesignGuides;

  end;


  {TppReportTabView}
  TppReportTabView = class
  private
    FTabSet: TTabSet;
    FWorkspaceView: TppDesignWorkspaceView;
    
    function GetTabSet: TTabSet;
    
  protected
    procedure CreateTabSet;
    procedure ehTabSet_Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure FreeTabSet;
    
  public
    constructor Create(aWorkspaceView: TppDesignWorkspaceView); virtual;

    procedure Add(aReport: TppCustomReport);
    procedure Initialize(aReport: TppCustomReport);
    procedure Remove(aReport: TppCustomReport);
    procedure UpdateTabCaption(aReport: TppCustomReport);

    property TabSet: TTabSet read GetTabSet;

  end;


implementation

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.Create }

constructor TppScrollableWorkspace.Create(aOwner: TComponent);
begin

  inherited;
  AddThemeNotification(Self);

  FVerticalRulers := TppRulerCollection.Create;

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.Destroy }

destructor TppScrollableWorkspace.Destroy;
begin

  FVerticalRulers.Free;
  FVerticalRulers := nil;

  RemoveThemeNotification(Self);

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.AddVerticalRuler }

procedure TppScrollableWorkspace.AddVerticalRuler(aRuler: TppRuler);
begin

  aRuler.Parent := FVerticalRulerArea;
  aRuler.Color := FHorizontalRuler.Color;
  aRuler.Units := FHorizontalRuler.Units;
  aRuler.OnGetPrinter := ehRuler_GetPrinter;
  aRuler.PopupMenu := FHorizontalRuler.PopupMenu;
  aRuler.Width := FVerticalRulerArea.Width;

  aRuler.FreeNotification(Self);

  FVerticalRulers.Add(aRuler);

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.CalcScrollableArea }

procedure TppScrollableWorkspace.UpdateScrollableArea;
begin

  // set scrollbox & background width to 1 inch larger than workspace width
  FScrollbox.HorzScrollbar.Range := FWorkSpace.Width  + Screen.PixelsPerInch;
  FScrollbox.VertScrollbar.Range := FWorkSpace.Height + Screen.PixelsPerInch;

  // adjust vert rulers
  ScrollVertRulers();

  // horizontal ruler extends to end of scrollable area
  FHorizontalRuler.Width  := FScrollbox.HorzScrollbar.Range - FHorizontalRuler.Left;

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.CreateControls }

procedure TppScrollableWorkspace.CreateControls(aParent: TWinControl);
begin

  // parent panel
  FPanelParent := TPanel.Create(Owner);
  FPanelParent.Parent := aParent;
  FPanelParent.Align := alClient;
  FPanelParent.BevelOuter := bvNone;

  // horizontal ruler area
  FHorizontalRulerArea := TPanel.Create(Owner);
  FHorizontalRulerArea.Parent := FPanelParent;

{$IFDEF Delphi7}
   FHorizontalRulerArea.ParentBackground := False;
 {$ENDIF}

  FHorizontalRulerArea.Align := alTop;
  FHorizontalRulerArea.BevelOuter := bvNone;
  FHorizontalRulerArea.Height := 24;

  // horizontal ruler
  FHorizontalRuler := TppRuler.Create(Owner);
  FHorizontalRuler.Parent := FHorizontalRulerArea;
  FHorizontalRuler.Orientation  := roHorizontal;
  FHorizontalRuler.Left := 23;
  FHorizontalRuler.Top := 0;
  FHorizontalRuler.Width := FHorizontalRulerArea.Width;
  FHorizontalRuler.Height := FHorizontalRulerArea.Height;

  FHorizontalRuler.OnGetPrinter := ehRuler_GetPrinter;


  // vertical ruler area
  FVerticalRulerArea := TPanel.Create(Owner);
  FVerticalRulerArea.Parent := FPanelParent;

  {$IFDEF Delphi7}
  FVerticalRulerArea.ParentBackground := False;
  {$ENDIF}

  FVerticalRulerArea.Align := alLeft;
  FVerticalRulerArea.BevelOuter := bvNone;
  FVerticalRulerArea.Width := 23;

  // scrollbox
  FScrollbox := TppScrollbox.Create(Owner);
  FScrollbox.Parent := FPanelParent;
  FScrollbox.Left := 23;
  FScrollbox.Top := 23;
  FScrollbox.Align := alClient;
  FScrollbox.Color := clBtnShadow;
  FScrollbox.BevelKind := bkNone;
  FScrollbox.BorderStyle := bsNone;
  FScrollbox.HorzScrollBar.Tracking := True;
  FScrollbox.VertScrollBar.Tracking := True;

  FScrollbox.OnVerticalScroll := ehScrollableArea_VerticalScroll;
  FScrollbox.OnHorizontalScroll := ehScrollableArea_HorizontalScroll;
  FScrollbox.OnScrollInView := ehScrollbox_ScrollInView;
  FScrollbox.OnMouseWheel := ehScrollbox_MouseWheel;


  // workspace
  FWorkspace := TppWorkspace.Create(Owner);
  FWorkspace.Parent := FScrollbox;
  FWorkspace.Left := 0;
  FWorkspace.Top := 0;

  FWorkspace.Width := Round(8.5 * Screen.PixelsPerInch);
  FWorkspace.Height := Round(11.0 * Screen.PixelsPerInch);
  FWorkspace.OnResize := ehWorkspace_Resize;

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.ehBand_DesignControlCreate }

procedure TppScrollableWorkspace.ehBand_DesignControlCreate(Sender, aParameters: TObject);
var
  lBandControl: TppBandControl;
begin

  lBandControl := TppBandControl(aParameters);
  lBandControl.Color := FHorizontalRuler.Color;
  AddVerticalRuler(TppBandControl(aParameters).Ruler);

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.ehReport_LoadEnd }

procedure TppScrollableWorkspace.ehReport_LoadEnd(Sender, aParameters: TObject);
var
  lReport: TppCustomReport;
begin

  lReport := TppCustomReport(aParameters);

  if (Report <> lReport) then
    SetReport(lReport)
  else if (Report <> nil) then
    SetUnits(Report.Units);
  
end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.ehReport_UnitsChange }

procedure TppScrollableWorkspace.ehReport_UnitsChange(Sender, aParameters: TObject);
begin
  if (Report <> nil) then
    SetUnits(Report.Units);

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.ehRuler_GetPrinter }

procedure TppScrollableWorkspace.ehRuler_GetPrinter(Sender: TObject; var aPrinter: TppPrinter);
begin

  if (Report <> nil) then
    aPrinter := Report.Printer
  else
    aPrinter := nil;

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.ehScrollableArea_VerticalScroll }

procedure TppScrollableWorkspace.ehScrollableArea_VerticalScroll(Sender: TObject; aPosition: SmallInt; aEventType: TppVerticalScrollEventType);
begin

  // adjust vert rulers
  ScrollVertRulers();

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.ehScrollableArea_HorizontalScroll }

procedure TppScrollableWorkspace.ehScrollableArea_HorizontalScroll(Sender: TObject; aPosition: SmallInt; aEventType: TppHorizontalScrollEventType);
begin

  // scroll ruler
  FHorizontalRuler.Scroll(aPosition);

end;

procedure TppScrollableWorkspace.ehScrollbox_ScrollInView(Sender: TObject; aControl: TControl; var aAccept: Boolean);
begin

  if (aControl = FWorkspace) then
    aAccept := False;
  
end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.ehWorkspace_Resize }

procedure TppScrollableWorkspace.ehWorkspace_Resize(Sender: TObject);
begin

  UpdateScrollableArea;

end;

{@TppPreview.MouseWheelEvent}

procedure TppScrollableWorkspace.ehScrollbox_MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin

  // scroll
  FScrollbox.VertScrollBar.Position := FScrollbox.VertScrollBar.Position - WheelDelta div 10;

  // adjust vert rulers
  ScrollVertRulers();

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.ScrollVertRulers }

procedure TppScrollableWorkspace.ScrollVertRulers;
var
  liIndex: Integer;
  liIncrement: Integer;
begin

  liIncrement := FScrollbox.VertScrollbar.Position - FLastVertScrollPos;

  for liIndex := 0 to FVerticalRulers.Count-1 do
    FVerticalRulers[liIndex].Top := FVerticalRulers[liIndex].Top - liIncrement;

  FLastVertScrollPos := FScrollbox.VertScrollBar.Position;

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.SetCurrentReport }

procedure TppScrollableWorkspace.SetReport(const Value: TppCustomReport);
begin

  if (Report <> nil) and (pppcUpdating in Report.DesignState) then Exit;

  if (Report <> Value) then
    begin
      inherited;

      if (Value <> nil) then
        SetUnits(Value.Units);

      FWorkspace.Report := Value;

    end;

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.SetEventHub }

procedure TppScrollableWorkspace.SetEventHub(aEventHub: TppDesignEventHub);
begin

  if (EventHub <> nil) and not(csDestroying in EventHub.ComponentState)  then
    begin
      EventHub.BandEvents.mcDesignControlCreate.RemoveNotify(ehBand_DesignControlCreate);
      EventHub.ReportEvents.mcUnitsChange.RemoveNotify(ehReport_UnitsChange);
      EventHub.ReportEvents.mcLoadEnd.RemoveNotify(ehReport_LoadEnd);
    end;

  inherited;

  if (EventHub <> nil) then
    begin
      EventHub.BandEvents.mcDesignControlCreate.AddNotify(ehBand_DesignControlCreate);
      EventHub.ReportEvents.mcUnitsChange.AddNotify(ehReport_UnitsChange);
      EventHub.ReportEvents.mcLoadEnd.AddNotify(ehReport_LoadEnd);
    end;


end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.SetParent }

procedure TppScrollableWorkspace.SetParent(const aParent: TWinControl);
begin

  if (FParent <> aParent) then
    begin
      if (FParent = nil) and (aParent <> nil) then
        CreateControls(aParent);

      FParent := aParent;
    end;

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.SetRulerColor }

procedure TppScrollableWorkspace.SetRulerColor(aColor: TColor);
var
  liIndex: Integer;
begin

  if (aColor <> FHorizontalRuler.Color) then
    begin
      FHorizontalRulerArea.Color := aColor;
      FHorizontalRuler.Color := aColor;
      FVerticalRulerArea.Color := aColor;

      for liIndex := 0 to FVerticalRulers.Count-1 do
        FVerticalRulers[liIndex].Color := aColor;

    end;

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.SetUnits }

procedure TppScrollableWorkspace.SetUnits(aUnits: TppUnitType);
begin

  if (Report <> nil) then
    begin
      FHorizontalRuler.Units := aUnits;
      FVerticalRulers.SetUnits(aUnits);
    end;

end;

{------------------------------------------------------------------------------}
{ TppScrollableWorkspace.TBMThemeChange }

procedure TppScrollableWorkspace.TBMThemeChange(var Message: TMessage);
begin

  if Message.WParam = TSC_VIEWCHANGE then
    UpdateRulerColor();

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.UpdateRulerColor }

procedure TppScrollableWorkspace.UpdateRulerColor;
var
  lColor: TColor;
begin
//  lColor := CurrentTheme.GetViewColor(VT_TOOLBAR or TVT_MENUBAR);
  lColor := CurrentTheme.GetViewColor(VT_TOOLBAR);

  SetRulerColor(lColor);
end;


{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.Create }

constructor TppDesignWorkspaceView.Create(aOwner: TComponent);
begin

  inherited;

  FDefaultFont := TFont.Create;
  FDefaultFont.Name  := 'Arial';
  FDefaultFont.Size  := 10;
  FDefaultFont.Style := [];
  FDefaultFont.Color := clBlack;

  FDesignControlManager := TppDesignControlManager.Create(nil);
  FSelection := TppDesignSelection.Create(nil);
  FSelection.DesignControlManager := FDesignControlManager;
  FUndoManager := TppUndoManager.Create;

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.Destroy }

destructor TppDesignWorkspaceView.Destroy;
begin

  FReportTabView.Free;
  FReportTabView := nil;
  
  FDefaultFont.Free;
  FDefaultFont := nil;

  FDesignControlManager.Free;
  FDesignControlManager := nil;

  FSelection.Free;
  FSelection := nil;

  FUndoManager.Free;
  FUndoManager := nil;

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.CreateControls }

procedure TppDesignWorkspaceView.CreateControls(aParent: TWinControl);
begin

  inherited;

  // create the select report button
  FSelectReportButton := TppTBXButton.Create(FHorizontalRulerArea);
  FSelectReportButton.Parent := Scrollbox.Parent;
  FSelectReportButton.Left := 0;
  FSelectReportButton.Top := 0;
  FSelectReportButton.ButtonStyle := bsFlat;
  FSelectReportButton.Height := 22;
  FSelectReportButton.Width := 23;
  FSelectReportButton.Images := ToolImageList;
  FSelectReportButton.ImageIndex :=  ToolImageList.AddTool('PPSELECTREPORT');
  FSelectReportButton.OnClick := ehSelectReportButton_Click;
  FSelectReportButton.Tag := 392;
  FSelectReportButton.Hint := ppLoadStr(392); {'Select Report'}
  FSelectReportButton.TabStop := False;

  FReportTabView := TppReportTabView.Create(Self);


  // initialize selection.Workspace reference
  FSelection.Workspace := Workspace;

  UpdateRulerColor();



end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.ehComponent_AfterPropertyChange }

procedure TppDesignWorkspaceView.ehComponent_AfterPropertyChange(Sender, aParams: TObject);
begin

  if FUndoManager.Active then
    FUndoManager.EndTask;

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.ehComponent_BeforePropertyChange }

procedure TppDesignWorkspaceView.ehComponent_BeforePropertyChange(Sender, aParams: TObject);
var
  lEventParams: TppPropertyChangeEventParams;
begin

  if FUndoManager.Active then
    begin
      lEventParams := TppPropertyChangeEventParams(aParams);

      FUndoManager.BeginTask;
      FUndoManager.AddOperation(lEventParams.PropertyName, lEventParams.Component);
    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.ehComponent_ZOrderChange }

procedure TppDesignWorkspaceView.ehComponent_ZOrderChange(Sender, aParameters: TObject);
var
  lComponent: TppComponent;
  lNeighbor: TppComponent;
  lDesignControl: TppDesignControl;
  lNeighborDesignControl: TppDesignControl;
  liComponentIndex: Integer;
  liDesignZOrder: Integer;
begin

  lComponent := TppComponent(Sender);

  if (lComponent.Band = nil) or (lComponent.Band.ObjectCount = 1) then Exit;

   // get design control for component
  lDesignControl := FDesignControlManager.DesignControls[lComponent];

  // compute design control z-order, by looking at neighbor control
  
  liComponentIndex := lComponent.Index;

  if (liComponentIndex = 0) then
    begin
      lNeighbor := lComponent.Band.Objects[1];
      lNeighborDesignControl := FDesignControlManager.DesignControls[lNeighbor];
      liDesignZOrder := Workspace.IndexOfControl(lNeighborDesignControl)-1;
    end
  else
    begin
      lNeighbor := lComponent.Band.Objects[liComponentIndex-1];
      lNeighborDesignControl := FDesignControlManager.DesignControls[lNeighbor];
      liDesignZOrder := Workspace.IndexOfControl(lNeighborDesignControl)+1;

    end;

  // update workspace z-order
  Workspace.UpdateZOrder(lDesignControl, liDesignZOrder);

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.ehReport_AddSubreport }

procedure TppDesignWorkspaceView.ehReport_AddSubreport(Sender, aParameters: TObject);
var
  lReport: TppCustomReport;
begin

  lReport := TppCustomReport(aParameters);

  FReportTabView.Add(lReport);

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.ehReport_CaptionChange }

procedure TppDesignWorkspaceView.ehReport_CaptionChange(Sender, aParams: TObject);
var
  lReport: TppCustomReport;
begin

  if (ReportTabs <> nil) then
    begin
    
      if (aParams is TppReport) then
        lReport := TppReport(aParams)
      else if (aParams is TppSubreport) then
        lReport := TppSubReport(aParams).Report
      else
        lReport := nil;

      if lReport <> nil then
        FReportTabView.UpdateTabCaption(lReport);

    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.ehReport_LanguageChange }

procedure TppDesignWorkspaceView.ehReport_LanguageChange(Sender, aParams: TObject);
begin
  FSelectReportButton.Hint := ppLoadStr(392); {'Select Report'}

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.ehReport_LoadEnd }

procedure TppDesignWorkspaceView.ehReport_LoadEnd(Sender, aParameters: TObject);
var
  lbSameReport: Boolean;
begin

  lbSameReport := (Report = TppCustomReport(aParameters));

  inherited;

  if lbSameReport then
    InitializeView

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.ehReport_LoadStart }

procedure TppDesignWorkspaceView.ehReport_LoadStart(Sender, aParameters: TObject);
begin

  FUndoManager.Clear;
  FUndoManager.Active := False;

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.ehReport_NewEnd }

procedure TppDesignWorkspaceView.ehReport_NewEnd(Sender, aParameters: TObject);
begin
  InitializeView;

end;


{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.ehReport_RemoveSubreport }

procedure TppDesignWorkspaceView.ehReport_RemoveSubreport(Sender, aParameters: TObject);
var
  lReport: TppCustomReport;
begin

  lReport := TppCustomReport(aParameters);

  FReportTabView.Remove(lReport);

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.ehSelectReportButton_Click }

procedure TppDesignWorkspaceView.ehSelectReportButton_Click(Sender: TObject);
begin

  {clearing the selection, will cause the report to be selected}
  Selection.Clear;

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.GetReportTabs }

function TppDesignWorkspaceView.GetReportTabs: TTabSet;
begin

  Result := FReportTabView.TabSet;
  
end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.InitializeView }

procedure TppDesignWorkspaceView.InitializeView;
begin

  FUndoManager.Clear;
  FUndoManager.Active := False;

  {create header, detail, footer bands, if needed }
  if (Report <> nil) then
    begin
      Report.CreateDefaultBands;

      if FLiveData then
        Report.DSInclude([pppcDisplayData])
      else
        Report.DSExclude([pppcDisplayData]);

      {initialize template props of master report}
      if (Report <> MainReport) then
        Report.Template.InitializeSettings(MainReport.Template);
    end;

  FSelection.Report := Report;
  FSelection.Clear();

  FDesignControlManager.Report := Report;

  FReportTabView.Initialize(Report);

  FUndoManager.Active := (Report <> nil);

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.LoadPreferences }

procedure TppDesignWorkspaceView.LoadPreferences;
var
  lbShowData: Boolean;
  lIniStorage: TppIniStorage;
begin

  lIniStorage := TppIniStoragePlugin.CreateInstance;

  try

    lbShowData := lIniStorage.ReadBool('Designer Preferences', 'ShowData',  True);
    SetLiveData(lbShowData);

    FUndoManager.Capacity := lIniStorage.ReadInteger('Undo Options', 'Capacity', FUndoManager.Capacity);
    FShowDesignGuides := lIniStorage.ReadBool('Designer Preferences', 'ShowDesignGuides',  True);

    FDefaultFont.Name := lIniStorage.ReadString('Format', 'DefaultFontName', 'Arial');
    FDefaultFont.Size := lIniStorage.ReadInteger('Format', 'DefaultFontSize', 10);

    {read grid options from ini file {default grid to off and gridspace to 8 by 8) }
    FWorkspace.GridOptions.SnapToGrid := lIniStorage.ReadBool('Grid Options',    'SnapToGrid',  False);
    FWorkspace.GridOptions.Visible := lIniStorage.ReadBool('Grid Options',    'DisplayGrid', FWorkspace.GridOptions.Visible);
    FWorkspace.GridOptions.SpacingX  := lIniStorage.ReadInteger('Grid Options', 'XGridSpace',  FWorkspace.GridOptions.SpacingX);
    FWorkspace.GridOptions.SpacingY  := lIniStorage.ReadInteger('Grid Options', 'YGridSpace',  FWorkspace.GridOptions.SpacingY);

  finally
    lIniStorage.Free;
  end;

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.SavePreferences }

procedure TppDesignWorkspaceView.SavePreferences;
var
  lIniStorage: TppIniStorage;
begin

  lIniStorage := TppIniStoragePlugin.CreateInstance;

  try

    lIniStorage.WriteBool('Designer Preferences', 'ShowData',  FLiveData);
    lIniStorage.WriteInteger('Undo Options', 'Capacity', FUndoManager.Capacity);
    lIniStorage.WriteBool('Designer Preferences', 'ShowDesignGuides',  FShowDesignGuides);

    lIniStorage.WriteBool('Grid Options',    'SnapToGrid',  FWorkspace.GridOptions.SnapToGrid);
    lIniStorage.WriteBool('Grid Options',    'DisplayGrid', FWorkspace.GridOptions.Visible);
    lIniStorage.WriteInteger('Grid Options', 'XGridSpace',  FWorkspace.GridOptions.SpacingX);
    lIniStorage.WriteInteger('Grid Options', 'YGridSpace',  FWorkspace.GridOptions.SpacingY);

  finally
    lIniStorage.Free;
  end;

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.SetDesignFont }

procedure TppDesignWorkspaceView.SetDefaultFont(const Value: TFont);
begin

  if FDefaultFont <> Value then
    begin
      FDefaultFont.Assign(Value);
    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.SetEventHub }

procedure TppDesignWorkspaceView.SetEventHub(aEventHub: TppDesignEventHub);
begin

  if (EventHub <> nil) and not(csDestroying in EventHub.ComponentState)  then
    begin
      EventHub.ReportEvents.mcAddSubreport.RemoveNotify(ehReport_AddSubreport);
      EventHub.ReportEvents.mcRemoveSubreport.RemoveNotify(ehReport_RemoveSubreport);
      EventHub.ReportEvents.mcLanguageChange.RemoveNotify(ehReport_LanguageChange);
      EventHub.ReportEvents.mcCaptionChange.RemoveNotify(ehReport_CaptionChange);
      EventHub.ReportEvents.mcLoadStart.RemoveNotify(ehReport_LoadStart);
//      EventHub.ReportEvents.mcLoadEnd.RemoveNotify(ehReport_LoadEnd);  // ancestor already subscribes
      EventHub.ReportEvents.mcNewEnd.RemoveNotify(ehReport_NewEnd);
      EventHub.ComponentEvents.mcBeforePropertyChange.RemoveNotify(ehComponent_BeforePropertyChange);
      EventHub.ComponentEvents.mcAfterPropertyChange.RemoveNotify(ehComponent_AfterPropertyChange);
      EventHub.ComponentEvents.mcZOrderChange.RemoveNotify(ehComponent_ZOrderChange);
    end;

  inherited;

  if (EventHub <> nil) then
    begin
      EventHub.ReportEvents.mcAddSubreport.AddNotify(ehReport_AddSubreport);
      EventHub.ReportEvents.mcRemoveSubreport.AddNotify(ehReport_RemoveSubreport);
      EventHub.ReportEvents.mcLanguageChange.AddNotify(ehReport_LanguageChange);
      EventHub.ReportEvents.mcCaptionChange.AddNotify(ehReport_CaptionChange);
      EventHub.ReportEvents.mcLoadStart.AddNotify(ehReport_LoadStart);
//      EventHub.ReportEvents.mcLoadEnd.AddNotify(ehReport_LoadEnd);  // ancestor already subscribes
      EventHub.ReportEvents.mcNewEnd.AddNotify(ehReport_NewEnd);
      EventHub.ComponentEvents.mcBeforePropertyChange.AddNotify(ehComponent_BeforePropertyChange);
      EventHub.ComponentEvents.mcAfterPropertyChange.AddNotify(ehComponent_AfterPropertyChange);
      EventHub.ComponentEvents.mcZOrderChange.AddNotify(ehComponent_ZOrderChange);
    end;


end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.SetLiveData}

procedure TppDesignWorkspaceView.SetLiveData(const Value: Boolean);
begin

  if FLiveData <> Value then
    begin
      FLiveData := Value;

      if (Report = nil) then Exit;

      if FLiveData then
        Report.DSInclude([pppcDisplayData])
      else
        Report.DSExclude([pppcDisplayData]);

    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.SetReport }

procedure TppDesignWorkspaceView.SetReport(const Value: TppCustomReport);
begin

  if (Report <> nil) and (pppcUpdating in Report.DesignState) then Exit;

  if (Report <> Value) then
    begin

      inherited;

      InitializeView();

   end;


end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.SetRulerColor }

procedure TppDesignWorkspaceView.SetRulerColor(aColor: TColor);
var
  liIndex: Integer;
begin

  if (aColor <> HorizontalRuler.Color) then
    begin

      inherited;

      if (DesignControlManager <> nil) then
        for liIndex := 0 to DesignControlManager.BandControlCount-1 do
          DesignControlManager.BandControlsByIndex[liIndex].Color := aColor;

    end;

end;

{------------------------------------------------------------------------------}
{TppReportTabView.Create}

constructor TppReportTabView.Create(aWorkspaceView: TppDesignWorkspaceView);
begin

  inherited Create;

  FWorkspaceView := aWorkspaceView;

end;

{------------------------------------------------------------------------------}
{TppReportTabView.Add}

procedure TppReportTabView.Add(aReport: TppCustomReport);
begin

  if (GetTabSet.Tabs.Count = 0) then
    TabSet.Tabs.InsertObject(0, aReport.MainReport.Caption, aReport.MainReport);

  TabSet.Tabs.AddObject(aReport.Caption, aReport);
  TabSet.Visible := TabSet.Tabs.Count > 1;
  TabSet.Invalidate;
  
end;

{------------------------------------------------------------------------------}
{TppReportTabView.CreateReportTabs}

procedure TppReportTabView.CreateTabSet;
begin

  FTabSet := TTabSet.Create(FWorkspaceView.Scrollbox.Parent);

{$IFDEF Delphi7}
  FTabSet.ParentBackground := False;
{$ENDIF}

  FTabSet.Parent := FWorkspaceView.Scrollbox.Parent;
  FTabSet.BackgroundColor := clWindow;
  FTabSet.Visible := False;
  FTabSet.Top := FWorkspaceView.Scrollbox.Top + FWorkspaceView.Scrollbox.Height + 1;
  FTabSet.Align := alBottom;
  FTabSet.SoftTop := True;
  FTabSet.OnChange := ehTabSet_Change;
{$IFDEF Delphi9}
  FTabSet.Style := tsSoftTabs;
{$ENDIF}

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkspaceView.ehReportTabs_Change }

procedure TppReportTabView.ehTabSet_Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
var
  lReport: TppCustomReport;
begin

  lReport := TppCustomReport(FTabSet.Tabs.Objects[NewTab]);

  // select the report
  if (lReport <> FWorkspaceView.Report) then
    FWorkspaceView.Selection.SelectReport(lReport);

end;

{------------------------------------------------------------------------------}
{ TppReportTabView.FreeReportTabs }

procedure TppReportTabView.FreeTabSet;
begin

  FTabSet.Free;
  FTabSet := nil;

end;

{------------------------------------------------------------------------------}
{TppReportTabView.GetTabSet}

function TppReportTabView.GetTabSet: TTabSet;
begin

  if (FTabSet = nil) then
    CreateTabSet;

  Result := FTabSet;

end;

{------------------------------------------------------------------------------}
{TppReportTabView.Initialize}

procedure TppReportTabView.Initialize(aReport: TppCustomReport);
var
  lMainReport: TppCustomReport;
  lSubReports: TStringList;
  liIndex: Integer;
begin

  // clear tabset
  if FTabSet <> nil then
    FTabSet.Tabs.Clear;

  // initialize the tabs
  if (aReport <> nil) then
    begin

      lMainReport := aReport.MainReport;

      {get list of all subReports related to the main report }
      lSubReports := TStringList.Create;

      try
        lMainReport.GetSubReports(lSubReports);

        if (lSubreports.Count > 0) then
          begin
            GetTabSet.Tabs.AddStrings(lSubReports);

            {insert 'main' tab}
            GetTabSet.Tabs.InsertObject(0, lMainReport.Caption, lMainReport);

            liIndex := FTabSet.Tabs.IndexOfObject(aReport);

            if (FTabSet.TabIndex <> liIndex)  then
              FTabSet.TabIndex := liIndex;

          end;

      finally
       lSubReports.Free;

      end;

    end;

  // free tabset or make visible
  if (FTabSet <> nil) and (FTabSet.Tabs.Count <= 1) then
    FreeTabSet
  else if (FTabSet <> nil) then
    FTabSet.Visible := True;
      
end;

{------------------------------------------------------------------------------}
{TppReportTabView.Remove}

procedure TppReportTabView.Remove(aReport: TppCustomReport);
var
  liIndex: Integer;
begin

  liIndex := TabSet.Tabs.IndexOfObject(aReport);

  if (liIndex >= 0) then
    begin
      TabSet.Tabs.Delete(liIndex);

      if (TabSet.Tabs.Count <= 1) then
        FreeTabSet;
        
    end;

end;

{------------------------------------------------------------------------------}
{ TppReportTabView.UpdateTabCaption }

procedure TppReportTabView.UpdateTabCaption(aReport: TppCustomReport);
var
  liIndex: Integer;
begin

  if (FWorkspaceView.Report = nil) or (aReport = nil) then Exit;

  if (aReport.MainReport = aReport) or (FTabSet = nil) then Exit;

  liIndex := FTabSet.Tabs.IndexOfObject(aReport);

  {update tab caption }
  if liIndex >= 0 then
    FTabSet.Tabs[liIndex] := aReport.Caption;

end;


end.
