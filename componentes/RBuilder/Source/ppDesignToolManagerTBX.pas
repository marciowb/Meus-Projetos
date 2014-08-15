{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignToolManagerTBX;

interface

uses
  Dialogs,
  SysUtils,
  Classes,
  Controls,
  Messages,
  Graphics,
  Forms,

  ppTB2Item,
  PPTB2Dock,
  PPTBX,
  PPTBXThemes,

  ppTypes,
  ppClass,
  ppIniStorage,
  ppUtils,
  ppCmpReg,
  ppTmplat,

  ppToolbarTBX,
  ppDesignToolbar,
  ppDesignToolWindow,
  ppToolResources,
  ppDesignToolActions,
  ppDesignLayoutMenu,
  ppPopupMenus,

  ppDesignObserver,
  ppDesignWorkspaceView,
  ppDesignControls,
  ppDesignControllers,
  ppDesignDialogController,
  ppDesignDocumentController,
  ppDesignSelectionController,
  ppDesignWorkspaceController,
  ppDesignEventHub;

type

  TppDesignToolManager = class;

  TppToolbarEvent = procedure(Sender: TObject; aToolbarTBX: TppToolbar) of object;

  {TppComponentPalette}
  TppComponentPalette = class(TppRegListSubScriber)
  private
    FComponentBars: TppToolbarCollection;
    FComponentClasses: TStrings;
    FDesignControllers: TppDesignControllers;
    FEnabled: Boolean;
    FEventHub: TppDesignEventHub;
    FOnToolbarAdded: TppToolbarEvent;
    FOnToolbarRemoved: TppToolbarEvent;
    FPaletteButton: TppTBXItem;
    FParent: TWinControl;
    FReport: TppCustomReport;
    FSelectObjectButton: TppTBXItem;

    procedure AddComponent(aClassName: String);
    procedure AddSelectObjectItem;
    procedure BuildComponentBars;
    procedure ehComponentButton_Click(Sender: TObject);
    procedure ehSelectObjectButton_Click(Sender: TObject);
    procedure ehWorkspace_DesignModeChanged(Sender, aEventParams: TObject);
    procedure FreeComponentBar(aComponentBar: TppToolbar);
    procedure FreeComponentBars;
    function GetToolbar(aToolbarName: String): TppToolbar;
    function GetWorkspaceController: TppDesignWorkspaceController;
    procedure RemoveComponent(aClassName: String);
    procedure SetComponentClasses(aComponentClasses: TStrings);
    procedure SetDesignControllers(const Value: TppDesignControllers);
    procedure SetEnabled(const Value: Boolean);
    procedure SetReport(const Value: TppCustomReport);
    function TranslateToolbarCaption(const aToolbarCaption: String): String;

  protected
    procedure DoOnToolbarAdded(aToolbar: TppToolbar);
    procedure DoOnToolbarRemoved(aToolbar: TppToolbar);

    property WorkspaceController: TppDesignWorkspaceController read GetWorkspaceController;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Initialize(aParent: TWinControl);
    procedure LanguageChanged;
    procedure RegisterListChanged; override;
    procedure SetEventHub(aEventHub: TppDesignEventHub);

    property ComponentBars: TppToolbarCollection read FComponentBars;
    property ComponentClasses: TStrings read FComponentClasses write SetComponentClasses;
    property DesignControllers: TppDesignControllers read FDesignControllers write SetDesignControllers;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property PaletteButton: TppTBXItem read FPaletteButton;
    property Report: TppCustomReport read FReport write SetReport;
    property SelectObjectButton: TppTBXItem read FSelectObjectButton;

    property OnToolbarAdded: TppToolbarEvent read FOnToolbarAdded write FOnToolbarAdded;
    property OnToolbarRemoved: TppToolbarEvent read FOnToolbarRemoved write FOnToolbarRemoved;
  end;


  {TppDesignToolManager}
  TppDesignToolManager = class(TppDesignObserver)
  private
    FActionManager: TppDesignToolActionManager;
    FDocks: TppToolDockCollection;
    FInitialized: Boolean;
    FMenubar: TppDesignerMenu;
    FToolbarPopupMenu: TppDesignToolbarPopupMenu;
    FToolbars: TppToolbarCollection;
    FComponentPalette: TppComponentPalette;
    FDesignControllers: TppDesignControllers;
    FFloatingTools: TList;
    FParent: TWinControl;
    FRulerPopupMenu: TppDesignRulerPopupMenu;
    FToolWindows: TppToolWindowCollection;

    procedure ehComponent_DesignControlCreate(Sender, aParameters: TObject);
    procedure ehBand_DesignControlCreate(Sender, aParameters: TObject);
    procedure ehEndUserEvents_UpdateMRU(Sender, aParameters: TObject);
    procedure SetDesignControllers(const Value: TppDesignControllers);
  protected
    procedure BuildFloatingToolList;
    procedure SetReport(const Value: TppCustomReport); override;
    procedure ehComponentPalette_ToolbarAdded(Sender: TObject; aToolbar: TppToolbar);
    procedure ehComponentPalette_ToolbarRemoved(Sender: TObject; aToolbar: TppToolbar);
    procedure LoadToolPreferences(aIniStorage: TppIniStorage);
    procedure SaveToolPreferences(aIniStorage: TppIniStorage);
    procedure SetEventHub(aEventHub: TppDesignEventHub); override;

    procedure HideFloatingTools;
    procedure ShowFloatingTools(aVisible: Boolean); overload;
    procedure ShowFloatingTools; overload;

  public
    destructor Destroy; override;

    procedure ActivateTools(aActive: Boolean);
    procedure AddToolbar(aToolbar: TppToolbar);

    procedure Initialize(aParent: TWinControl; aActionManager: TppDesignToolActionManager);
    procedure LanguageChanged;

    procedure LoadPreferences;
    procedure Notification(aComponent: TComponent; aOperation: TOperation); override;
    procedure RemoveToolbar(aToolbar: TppToolbar);
    procedure SavePreferences;

    property ComponentPalette: TppComponentPalette read FComponentPalette;
    property DesignControllers: TppDesignControllers read FDesignControllers write SetDesignControllers;
    property Menubar: TppDesignerMenu read FMenubar;
    property Docks: TppToolDockCollection read FDocks;
    property RulerPopupMenu: TppDesignRulerPopupMenu read FRulerPopupMenu;
    property ToolbarPopupMenu: TppDesignToolbarPopupMenu read FToolbarPopupMenu;
    property Toolbars: TppToolbarCollection read FToolbars;
    property ToolWindows: TppToolWindowCollection read FToolWindows;

  end;



implementation

uses
  ppDesignToolbarsTBX;

  
{------------------------------------------------------------------------------}
{ TppDesignToolManager.Destroy}

destructor TppDesignToolManager.Destroy;
begin

  FFloatingTools.Free;
  FFloatingTools := nil;

  FToolbars.Free;
  FToolbars := nil;

  FToolWindows.Free;
  FToolWindows := nil;

  FMenubar := nil;

  if (FComponentPalette <> nil) then
    begin
      FComponentPalette.OnToolbarAdded := nil;
      FComponentPalette.OnToolbarRemoved := nil;
    end;

  FComponentPalette.Free;
  FComponentPalette := nil;
  
  FDocks.Free;

  FToolbarPopupMenu.Free;
  FToolbarPopupMenu := nil;
  
  FRulerPopupMenu.Free;
  FRulerPopupMenu := nil;

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.ActivateTools}

procedure TppDesignToolManager.ActivateTools(aActive: Boolean);
var
  liIndex: Integer;
  lToolWindow: TppToolWindow;
begin

  ShowFloatingTools(aActive);

  // add floating, visible toolwindows
  for liIndex := 0 to FToolWindows.Count - 1 do
    begin
      lToolWindow := FToolWindows[liIndex];

      if not(lToolWindow.Floating) and lToolWindow.Visible then
        lToolWindow.ShowingChanged(aActive);

    end;

  // refresh datapipeline, datafield lists
  if aActive then
    FActionManager.EditActions.InitializeValueLists;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.AddToolbar}

procedure TppDesignToolManager.AddToolbar(aToolbar: TppToolbar);
var
  liIndex: Integer;
begin

  liIndex := FComponentPalette.ComponentBars.Count-1;

  if (FToolbars <> nil) then
    FToolbars.Insert(liIndex, aToolbar);

  aToolbar.CurrentDock := FDocks.Top;

  // update main  menu
  if (FMenuBar <> nil) then
    begin
      FMenubar.ViewMenu.Toolbars.InsertTool(liIndex, aToolbar);
      if (liIndex = 0) then
        FMenubar.ViewMenu.Toolbars.InsertSeparator(1);
    end;


  // update popup menu
  if (FToolbarPopupMenu <> nil) then
    begin
      FToolbarPopupMenu.InsertTool(liIndex, aToolbar);
      if (liIndex = 0) then
        FToolbarPopupMenu.InsertSeparator(1);
    end;

  aToolbar.FreeNotification(Self);

  end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.BuildFloatingToolList}

procedure TppDesignToolManager.BuildFloatingToolList;
var
  liIndex: Integer;
  lToolbar: TppToolbar;
  lToolWindow: TppToolWindow;
begin

  FFloatingTools.Clear;

  // add floating, visible toolbars
  for liIndex := 0 to FToolbars.Count - 1 do
    begin
      lToolbar := FToolbars[liIndex];

      if lToolbar.Floating and lToolbar.Visible then
        FFloatingTools.Add(lToolbar);

    end;

  // add floating, visible toolwindows
  for liIndex := 0 to FToolWindows.Count - 1 do
    begin
      lToolWindow := FToolWindows[liIndex];

      if lToolWindow.Floating and lToolWindow.Visible then
        FFloatingTools.Add(lToolWindow);

    end;




end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.ehComponentPalette_ToolbarAdded}

procedure TppDesignToolManager.ehComponentPalette_ToolbarAdded(Sender: TObject; aToolbar: TppToolbar);
begin

  AddToolbar(aToolbar);

end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.ehComponentPalette_ToolbarRemoved}

procedure TppDesignToolManager.ehComponentPalette_ToolbarRemoved(Sender: TObject; aToolbar: TppToolbar);
begin

  RemoveToolbar(aToolbar);

end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.ehComponent_DesignControlCreate}

procedure TppDesignToolManager.ehComponent_DesignControlCreate(Sender, aParameters: TObject);
var
  lDesignControl: TppDesignControl;
begin

  lDesignControl := TppDesignControl(aParameters);

  if (lDesignControl <> nil) and (lDesignControl.PopupMenu is TppPopupMenu) then
    TppPopupMenu(lDesignControl.PopupMenu).DesignControllers := FDesignControllers;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.ehBand_DesignControlCreate}

procedure TppDesignToolManager.ehBand_DesignControlCreate(Sender, aParameters: TObject);
var
  lDesignControl: TppDesignControl;
begin

  lDesignControl := TppDesignControl(aParameters);

  if (lDesignControl <> nil) and (lDesignControl.PopupMenu is TppPopupMenu) then
    TppPopupMenu(lDesignControl.PopupMenu).DesignControllers := FDesignControllers;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.ehEndUserEvents_UpdateMRU}

procedure TppDesignToolManager.ehEndUserEvents_UpdateMRU(Sender, aParameters: TObject);
var
  lTemplate: TppTemplate;
begin

  lTemplate := TppTemplate(aParameters);

  FMenuBar.FileMenu.MRUItems.AddTemplateItem(lTemplate);

end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.HideToolWindows}

procedure TppDesignToolManager.HideFloatingTools;
begin

  ShowFloatingTools(False);
  
end;


{------------------------------------------------------------------------------}
{ TppDesignToolManager.Initialize}

procedure TppDesignToolManager.Initialize(aParent: TWinControl; aActionManager: TppDesignToolActionManager);
var
  liIndex: Integer;
  lToolbar: TppToolbar;
  lEditbar: TppToolbar;
  lStdCompbar: TppToolbar;
  lDataCompbar: TppToolbar;
  lAdvancedCompbar: TppToolbar;
  lToolWindow: TppToolWindow;
  lWorkspaceView: TppDesignWorkspaceView;
begin

  if (aParent = nil) then
    raise EReportBuilderError.Create('TppDesignToolManager.Initialize: aParent is nil');

  FInitialized := True;

  FParent := aParent;
  FParent.FreeNotification(Self);

  FActionManager := aActionManager;
  FActionManager.DesignControllers := FDesignControllers;

  // create docks
  FDocks := TppToolDockCollection.Create(aParent);

  // create toolbars
  FToolbars := TppToolbarFactory.CreateToolbars(Self);

  // create toolwindows
  FToolWindows := TppToolWindowFactory.CreateToolWindows(Self);

  FFloatingTools := TList.Create;

  // configure the menu bar
  lToolbar := FToolbars.ItemsByName['Menu'];

  if not(lToolbar is TppDesignerMenu) then
    raise EReportBuilderError.Create('TppDesignToolManager.Initialize: ' + 'Menu must be of type TppDesignerMenuTBX');

  FMenubar := TppDesignerMenu(lToolbar);
  FMenubar.Initialize(nil, aActionManager.ActionLists.ItemsByName[lToolbar.Name]);
  FMenubar.DesignControllers := FDesignControllers;
  FMenubar.EnableItems(False);

  FToolbars.Remove(FMenubar);

  FDocks.BeginUpdate();

  // default dock positions - toolbars
  for liIndex := 0 to FToolbars.Count-1 do
    begin
      lToolbar := FToolbars[liIndex];
      lToolbar.CurrentDock := FDocks.Top;
      lToolbar.DockPos := 0;
      lToolbar.DockRow := 4;
      lToolbar.Visible := False;

      if (lToolbar is TppDesignToolbar) then
        TppDesignToolbar(lToolbar).Initialize(FDocks.Top, aActionManager.ActionLists.ItemsByName[lToolbar.Name])
      else
        lToolbar.Initialize(FDocks.Top);

      lToolbar.FreeNotification(Self);
    end;

  lEditbar := FToolbars.ItemsByName['Edit'];

  if (lEditbar <> nil) then
    begin
      lEditbar.Visible := True;
      lEditbar.DockRow := 3;
      lEditbar.DockPos := 0;
    end;

  lToolbar := FToolbars.ItemsByName['Format'];

  if (lToolbar <> nil) then
    begin
      lToolbar.Visible := True;
      lToolbar.DockRow := 3;
      lToolbar.DockPos := lEditbar.Width+1;
    end;


  // default dock positions - toolwindows
  for liIndex := 0 to FToolWindows.Count-1 do
    begin
      lToolWindow := FToolWindows[liIndex];

      if (liIndex = 0) then
        lToolWindow.CurrentDock := FDocks.LeftToolWindowDock
      else
        lToolWindow.CurrentDock := FDocks.RightToolWindowDock;

      lToolWindow.Visible := False;

      if (lToolWindow is TppDesignToolWindow) then
        TppDesignToolWindow(lToolWindow).Initialize(lToolWindow.CurrentDock, FDesignControllers)
      else
        lToolWindow.Initialize(lToolWindow.CurrentDock);

      lToolWindow.FreeNotification(Self);
    end;

  FDocks.EndUpdate();

  // create toolbar popup menu
  FToolbarPopupMenu := TppDesignToolbarPopupMenu.Create(nil);
  FToolbarPopupMenu.AddToolWindows(FToolWindows);
  FToolbarPopupMenu.AddSeparator();
  FToolbarPopupMenu.AddToolbars(FToolbars);

  // add toolwindows and toolbars to the view menu
  FMenubar.ViewMenu.Toolbars.AddToolWindows(FToolWindows);
  FMenubar.ViewMenu.Toolbars.AddSeparator;
  FMenubar.ViewMenu.Toolbars.AddToolbars(FToolbars);

  // create component palette
  FComponentPalette := TppComponentPalette.Create();
  FComponentPalette.OnToolbarAdded := ehComponentPalette_ToolbarAdded;
  FComponentPalette.OnToolbarRemoved := ehComponentPalette_ToolbarRemoved;
  FComponentPalette.Initialize(aParent);
  FComponentPalette.DesignControllers := FDesignControllers;

  // arrange component bars: standard, data, advanced
  lStdCompbar := FToolbars.ItemsByName['StandardComponents'];
  lDataCompbar := FToolbars.ItemsByName['DataComponents'];
  lAdvancedCompbar := FToolbars.ItemsByName['AdvancedComponents'];

  if (lStdCompbar <> nil) then
    lStdCompbar.DockPos := 0;

  if (lStdCompbar <> nil) and (lDataCompbar <> nil) then
    lDataCompbar.DockPos := lStdCompbar.Width;

  if (lStdCompbar <> nil) and (lDataCompbar <> nil) and (lAdvancedCompbar <> nil) then
    lAdvancedCompbar.DockPos := lStdCompbar.Width + lDataCompbar.Width;

  // assign popup menu for docks
  FDocks.Top.PopupMenu := FToolbarPopupMenu;
  FDocks.Left.PopupMenu := FToolbarPopupMenu;
  FDocks.Right.PopupMenu := FToolbarPopupMenu;
  FDocks.Bottom.PopupMenu := FToolbarPopupMenu;

  // create ruler popup menu
  FRulerPopupMenu := TppDesignRulerPopupMenu.Create(Self);
  FRulerPopupMenu.DesignControllers := DesignControllers;

  // assign ruler popup menu to workspace rulers
  if (DesignControllers <> nil) then
    begin
      lWorkspaceView := DesignControllers.WorkspaceView;
      lWorkspaceView.HorizontalRuler.PopupMenu := FRulerPopupMenu;

      for liIndex := 0 to lWorkspaceView.VerticalRulers.Count-1 do
        lWorkspaceView.VerticalRulers[liIndex].PopupMenu := FRulerPopupMenu;
    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.LanguageChanged}

procedure TppDesignToolManager.LanguageChanged;
var
  liIndex: Integer;
  lToolbar: TppToolbar;
  lToolWindow: TppToolWindow;
begin


  // update toolbars
  for liIndex := 0 to FToolbars.Count - 1 do
    begin
      lToolbar := FToolbars[liIndex];

      lToolbar.LanguageChanged();

    end;

  // update toolwindws
  for liIndex := 0 to FToolWindows.Count - 1 do
    begin
      lToolWindow := FToolWindows[liIndex];

      lToolWindow.LanguageChanged();

    end;

  // update popup menus
  if (Report <> nil) then
   TppPopupMenuManager.SetLanguageIndex(Report.LanguageIndex);

  // do these last, in this order
  FComponentPalette.LanguageChanged();
  FMenuBar.LanguageChanged();
  FActionManager.LanguageChanged();


end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.LoadPreferences}

procedure TppDesignToolManager.LoadPreferences;
var
  lIniStorage: TppIniStorage;
begin

  if not(FInitialized) then Exit;

  lIniStorage := TppIniStoragePlugin.CreateInstance;

  FDocks.BeginUpdate();

  try

    LoadToolPreferences(lIniStorage);

    FActionManager.LoadPreferences(lIniStorage);


  finally
    lIniStorage.Free;
    FDocks.EndUpdate();
    
  end;


end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.LoadToolbarPreferences}

procedure TppDesignToolManager.LoadToolPreferences(aIniStorage: TppIniStorage);
var
  liIndex: Integer;
  lToolbar: TppToolbar;
  lToolWindow: TppToolWindow;
  lsDockName: String;
  lbVisible: Boolean;
  lbFloating: Boolean;
begin

  FMenuBar.LoadPreferences(aIniStorage);

  for liIndex := 0 to FToolbars.Count-1 do
    begin
      lToolbar := Toolbars[liIndex];

      {load whether toolbar is floating, visible}
      lbFloating := aIniStorage.ReadBool(lToolbar.Name, 'Floating', False);
      lsDockName := aIniStorage.ReadString(lToolbar.Name, 'DockName', '');
      lbVisible  := aIniStorage.ReadBool(lToolbar.Name, 'Visible', lToolbar.Visible);

      if lbFloating then
        lToolbar.Floating := True
      else if (lsDockName <> '') then
        lToolbar.CurrentDock := FDocks[lsDockName];

      lToolbar.Visible := lbVisible;

    end;

  for liIndex := 0 to FToolWindows.Count-1 do
    begin
      lToolWindow := ToolWindows[liIndex];

      {load whether toolbar is floating, visible}
      lbFloating := aIniStorage.ReadBool(lToolWindow.Name, 'Floating', False);
      lsDockName := aIniStorage.ReadString(lToolWindow.Name, 'DockName', '');
      lbVisible  := aIniStorage.ReadBool(lToolWindow.Name, 'Visible', True);

      if lbFloating then
        lToolWindow.Floating := True
      else if (lsDockName <> '') then
        lToolWindow.CurrentDock := FDocks[lsDockName];

      lToolWindow.Visible := lbVisible;

    end;

  // load toolbar prefs
  for liIndex := 0 to FToolbars.Count-1 do
    Toolbars[liIndex].LoadPreferences(aIniStorage);


  for liIndex := 0 to FToolWindows.Count-1 do
    ToolWindows[liIndex].LoadPreferences(aIniStorage);

end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.Notification}

procedure TppDesignToolManager.Notification(aComponent: TComponent; aOperation: TOperation);
begin

  inherited;

  if (csDestroying in ComponentState) then Exit;

  if (aOperation <> opRemove) then Exit;

  if (aComponent = FParent) then
    FParent := nil
  else if (aComponent is TppToolbar) and (FToolbars <> nil) then
    FToolbars.Remove(TppToolbar(aComponent))

  else if (aComponent is TppToolWindow) and (FToolWindows <> nil) then
    FToolWindows.Remove(TppToolWindow(aComponent));


end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.RemoveToolbar}

procedure TppDesignToolManager.RemoveToolbar(aToolbar: TppToolbar);
var
  lbLastToolbar: Boolean;
begin

  lbLastToolbar := FComponentPalette.ComponentBars.Count <= 1;

  if (FToolbars <> nil) then
    FToolbars.Remove(aToolbar);

  // update main  menu
  if (FMenuBar <> nil) then
    begin
      FMenubar.ViewMenu.Toolbars.RemoveTool(aToolbar);
      if (lbLastToolbar) and (FMenubar.ViewMenu.Count > 0)  then
        FMenubar.ViewMenu.Delete(0);
    end;

  // update popup  menu
  if (FToolbarPopupMenu <> nil) then
    begin
      FToolbarPopupMenu.RemoveTool(aToolbar);
      if (lbLastToolbar) and (FToolbarPopupMenu.Items.Count > 0) then
        FToolbarPopupMenu.Items.Delete(0);
    end;

  aToolbar.RemoveFreeNotification(Self);
  
end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.SavePreferences}

procedure TppDesignToolManager.SavePreferences;
var
  lIniStorage: TppIniStorage;
begin

  if not(FInitialized) then Exit;

  lIniStorage := TppIniStoragePlugin.CreateInstance;

  try

    FActionManager.SavePreferences(lIniStorage);

    SaveToolPreferences(lIniStorage);

  finally
    lIniStorage.Free;
  end;
  
end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.SaveToolbarPreferences}

procedure TppDesignToolManager.SaveToolPreferences(aIniStorage: TppIniStorage);
var
  liIndex: Integer;
  lToolbar: TppToolbar;
  lToolWindow: TppToolWindow;
begin

  FMenuBar.SavePreferences(aIniStorage);

  // save toolbar prefs
  for liIndex := 0 to FToolbars.Count-1 do
    Toolbars[liIndex].SavePreferences(aIniStorage);

  for liIndex := 0 to FToolWindows.Count-1 do
    ToolWindows[liIndex].SavePreferences(aIniStorage);

  // save docking and visible info
  for liIndex := 0 to FToolbars.Count-1 do
    begin
      lToolbar := Toolbars[liIndex];

      aIniStorage.WriteBool(lToolbar.Name, 'Floating', lToolbar.Floating);

      if lToolbar.Floating then
        aIniStorage.WriteString(lToolbar.Name, 'DockName', '')
      else if (lToolbar.CurrentDock <> nil) then

        aIniStorage.WriteString(lToolbar.Name, 'DockName', lToolbar.CurrentDock.Name);

      aIniStorage.WriteBool(lToolbar.Name, 'Visible', lToolbar.Visible);

    end;  

  // save docking and visible info
  for liIndex := 0 to FToolWindows.Count-1 do
    begin
      lToolWindow := ToolWindows[liIndex];

      aIniStorage.WriteBool(lToolWindow.Name, 'Floating', lToolWindow.Floating);

      if lToolWindow.Floating then
        aIniStorage.WriteString(lToolWindow.Name, 'DockName', '')
      else if (lToolWindow.CurrentDock <> nil) then
        aIniStorage.WriteString(lToolWindow.Name, 'DockName', lToolWindow.CurrentDock.Name);

      aIniStorage.WriteBool(lToolWindow.Name, 'Visible', lToolWindow.Visible);

    end;  

end;  {procedure, SaveToolbarPreferences}

{------------------------------------------------------------------------------}
{ TppDesignToolManager.SetDesignControllers}

procedure TppDesignToolManager.SetDesignControllers(const Value: TppDesignControllers);
begin

  if FDesignControllers <> Value then
    begin
      FDesignControllers := Value;

      if (FComponentPalette <> nil) then
        FComponentPalette.DesignControllers := FDesignControllers;
        
      if (FMenubar <> nil) then
        FMenubar.DesignControllers := FDesignControllers;

    end;

end;

{------------------------------------------------------------------------------}
{TppDesignObserver.SetEventHub}

procedure TppDesignToolManager.SetEventHub(aEventHub: TppDesignEventHub);
var
  liIndex: Integer;
begin

  // remove event handlers
  if (EventHub <> nil) and not(csDestroying in EventHub.ComponentState)  then
    begin
      EventHub.ComponentEvents.mcDesignControlCreate.RemoveNotify(ehComponent_DesignControlCreate);
      EventHub.BandEvents.mcDesignControlCreate.RemoveNotify(ehBand_DesignControlCreate);
      EventHub.EndUserEvents.mcUpdateMRU.RemoveNotify(ehEndUserEvents_UpdateMRU);
    end;

  inherited;

  // add event handlers
  if (EventHub <> nil) then
    begin
      EventHub.ComponentEvents.mcDesignControlCreate.AddNotify(ehComponent_DesignControlCreate);
      EventHub.BandEvents.mcDesignControlCreate.AddNotify(ehBand_DesignControlCreate);
      EventHub.EndUserEvents.mcUpdateMRU.AddNotify(ehEndUserEvents_UpdateMRU);

    end;

  for liIndex := 0 to FToolWindows.Count-1 do
    if (FToolWindows[liIndex] is TppDesignToolWindow) then
      TppDesignToolWindow(FToolWindows[liIndex]).EventHub := aEventHub;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.SetReport}

procedure TppDesignToolManager.SetReport(const Value: TppCustomReport);
begin

  if Report <> Value then
    begin
      FComponentPalette.Report := Value;
      FMenubar.EnableItems(Value <> nil);
    end;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolManager.ShowFloatingTools}

procedure TppDesignToolManager.ShowFloatingTools(aVisible: Boolean);
var
 liIndex: Integer;
begin

  if not(aVisible) then 
    BuildFloatingToolList();

  for liIndex := 0 to FFloatingTools.Count-1 do
    TWinControl(FFloatingTools[liIndex]).Visible := aVisible;

end;


procedure TppDesignToolManager.ShowFloatingTools;
begin
  ShowFloatingTools(True);
end;

{******************************************************************************
 *
 **  C o m p o n e n t   P a l e t t e 
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppComponentPalette.Create}

constructor TppComponentPalette.Create;
begin

  inherited Create;

  FComponentBars := TppToolbarCollection.Create;

  ppComponentClassList.AddNotify(Self);

  FComponentClasses := TStringList.Create;
  FComponentClasses.Assign(ppComponentClassList);

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.Destroy}

destructor TppComponentPalette.Destroy;
begin

  ppComponentClassList.RemoveNotify(Self);
  FComponentClasses.Free;
  FComponentClasses := nil;

  FComponentBars.Free;
  FComponentBars := nil;

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.AddPaletteButton}

procedure TppComponentPalette.AddComponent(aClassName: String);
var
  lToolbar: TppToolbar;
  lButton: TppTBXItem;
  lRegComponent: TppRegComponent;
  liIndex: Integer;
begin

  liIndex := FComponentClasses.IndexOf(aClassName);

  if (liIndex < 0) then Exit;

  lRegComponent :=  TppRegComponent(FComponentClasses.Objects[liIndex]);

  // get toolbar
  lToolbar := GetToolbar(lRegComponent.ToolBarName);

  // create button
  lButton := lToolbar.AddButton();
  lButton.AutoCheck := True;
  lButton.GroupIndex := 1;
  lButton.OnClick := ehComponentButton_Click;

  lButton.Name  := aClassName;

  lButton.ImageIndex := ToolImageList.AddTool(UpperCase(aClassName));

  {assign button hint}
  if lRegComponent.HintIndex > 0 then
    begin
      lButton.Tag  := lRegComponent.HintIndex;
      lButton.Hint := ppLoadStr(lRegComponent.HintIndex)
    end
  else
    lButton.Hint := lRegComponent.Hint;

  if (lButton.Hint = '') then
    lButton.Hint := TppComponentClass(lRegComponent.ComponentClass).DefaultHint;

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.AddSelectObjectItem}

procedure TppComponentPalette.AddSelectObjectItem;
var
  lFirstToolbar: TppToolbar;
  lSeparator: TppTBXSeparatorItem;
begin

  {if no toolbars created, create a standard components toolbar}
  lFirstToolbar := GetToolbar('Standard Components');

  {add selection arrow button to first component bar}
  if (lFirstToolbar <> nil) then
    begin
      lFirstToolbar.BeginUpdate;

      {create the arrow button}
      FSelectObjectButton := TppTBXItem.Create(nil);

      lFirstToolbar.Items.Insert(0, FSelectObjectButton);

      FSelectObjectButton.AutoCheck := True;
      FSelectObjectButton.GroupIndex := 1;
      FSelectObjectButton.Checked := True;

      FSelectObjectButton.OnClick := ehSelectObjectButton_Click;
      FSelectObjectButton.Name := 'SelectObject';
      FSelectObjectButton.ImageIndex := ToolImageList.AddTool('PPSELECTOBJECT');
      FSelectObjectButton.Hint := ppLoadStr(273);
      FSelectObjectButton.Tag  := 273;

      if (lFirstToolbar.Items.Count > 1) then
        begin
          {add a separator}
          lSeparator := TppTBXSeparatorItem.Create(nil);
          lFirstToolbar.Items.Insert(1, lSeparator);
        end;


     lFirstToolbar.EndUpdate;

   end;
end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.BuildComponentBars}

procedure TppComponentPalette.BuildComponentBars;
var
  liIndex: Integer;
begin

  if (FParent = nil) or (csDestroying in FParent.ComponentState) then Exit;
  
  // free existing component bars
  FreeComponentBars;

  // add item for each registered class
  for liIndex := 0 to FComponentClasses.Count-1 do
    AddComponent(FComponentClasses[liIndex]);


  // add the select object item
  AddSelectObjectItem();


end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.DoOnToolbarAdded}

procedure TppComponentPalette.DoOnToolbarAdded(aToolbar: TppToolbar);
begin
  if Assigned(FOnToolbarAdded) then FOnToolbarAdded(Self, aToolbar);
end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.DoOnToolbarRemoved}

procedure TppComponentPalette.DoOnToolbarRemoved(aToolbar: TppToolbar);
begin
  if Assigned(FOnToolbarRemoved) then FOnToolbarRemoved(Self, aToolbar);
end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.ehComponentButton_Click}

procedure TppComponentPalette.ehComponentButton_Click(Sender: TObject);
var
  lsClassName: String;
  lPersistentClass: TPersistentClass;
begin

  FPaletteButton := TppTBXItem(Sender);
  lsClassName := FPaletteButton.Name;

  {get the class and check it's ancestry }
  lPersistentClass := GetClass(lsClassName);

  if (lPersistentClass <> nil) and lPersistentClass.InheritsFrom(TppComponent) then
    begin
      WorkspaceController.DesignMode := dmCreateComponent;
      WorkspaceController.DefaultComponentClass := TppComponentClass(lPersistentClass);
    end;

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.ehSelectObjectButton_Click}

procedure TppComponentPalette.ehSelectObjectButton_Click(Sender: TObject);
begin

  WorkspaceController.DesignMode := dmSelect;

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.ehWorkspace_DesignModeChanged}

procedure TppComponentPalette.ehWorkspace_DesignModeChanged(Sender, aEventParams: TObject);
begin

  FSelectObjectButton.Checked := (WorkspaceController.DesignMode = dmSelect);

  if (FPaletteButton <> nil) then
    FPaletteButton.Checked := (WorkspaceController.DesignMode = dmCreateComponent);

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.FreeComponentBar}

procedure TppComponentPalette.FreeComponentBar(aComponentBar: TppToolbar);
begin
  FComponentBars.Remove(aComponentBar);
  DoOnToolbarRemoved(aComponentBar);
  aComponentBar.Free;
end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.FreeComponentBars}

procedure TppComponentPalette.FreeComponentBars;
var
  liIndex: Integer;
begin

  for liIndex := FComponentBars.Count-1 downto 0 do
    FreeComponentBar(FComponentBars[liIndex]);

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.GetToolbar}

function TppComponentPalette.GetToolbar(aToolbarName: String): TppToolbar;
var
  lsName: String;
begin

  lsName := StringReplace(aToolbarName, ' ', '', [rfReplaceAll]);

  Result := FComponentBars.ItemsByName[lsName];

  if (Result = nil) then
    begin
      Result := TppToolbar.Create(nil);
      Result.Name  := lsName;
      Result.Caption := TranslateToolbarCaption(lsName);
      Result.Images := ToolImageList;
      Result.DockRow := 1;

      // add to collection
      FComponentBars.Add(Result);

      // fire event
      DoOnToolbarAdded(Result);
      
    end;

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.GetWorkspaceController}

function TppComponentPalette.GetWorkspaceController: TppDesignWorkspaceController;
begin
  if DesignControllers <> nil then
    Result := DesignControllers.WorkspaceController
  else
    Result := nil;
end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.Initialize}

procedure TppComponentPalette.Initialize(aParent: TWinControl);
begin
  FParent := aParent;

  BuildComponentBars;
  
end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.LanguageChanged}

procedure TppComponentPalette.LanguageChanged;
var
  liIndex: Integer;
  liItem: Integer;
  lToolbar: TppToolbar;
  lButton: TppTBCustomItem;
begin

  for liIndex := 0 to FComponentBars.Count - 1 do
    begin
      lToolbar := FComponentBars[liIndex];

      // update component bar caption
      lToolbar.LanguageChanged();
      lToolbar.Caption := TranslateToolbarCaption(lToolbar.Name);

      // update hints for items that store the hint index in the tag
      for liItem := 0 to lToolbar.Items.Count - 1 do
        begin
          lButton := lToolbar.Items[liItem];

          if (lButton.Tag > 0) then
            lButton.Hint := ppLoadStr(lButton.Tag)

        end;

    end;
    

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.RegisterListChanged}

procedure TppComponentPalette.RegisterListChanged;
begin

  inherited;

  BuildComponentBars;

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.RemoveComponent}

procedure TppComponentPalette.RemoveComponent(aClassName: String);
var
  lButton:  TComponent;
  liToolbar: Integer;
  lToolbar: TppToolbar;

begin

  lButton   := nil;
  liToolbar := 0;

  {find component button}
  while (lButton = nil) and (liToolbar < FComponentBars.Count) do
    begin
      lToolbar := FComponentBars[liToolbar];

      lButton := lToolbar.GetItemForName(aClassName);

      if lButton = nil then
        Inc(liToolbar);

    end;

  {destroy component button}
  lButton.Free;

  for liToolbar := FComponentBars.Count-1 downto 0 do
    begin
      lToolbar := FComponentBars[liToolbar];

      {if not more buttons then free the toolbar}
      if (lToolbar <> nil) and (lToolbar.Items.Count = 0) then
        FreeComponentBar(lToolbar);
    end;

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.SetComponentClasses}

procedure TppComponentPalette.SetComponentClasses(aComponentClasses: TStrings);
var
  liIndex: Integer;
  lsClassName: String;
  lOldClasses: TStringList;
begin

  lOldClasses := TStringList.Create;

  lOldClasses.Assign(FComponentClasses);

  FComponentClasses.Assign(aComponentClasses);

  for liIndex := 0 to FComponentClasses.Count-1 do
    begin
      lsClassName := FComponentClasses[liIndex];

      if lOldClasses.IndexOf(lsClassName) < 0 then
        AddComponent(lsClassName);

    end;

  for liIndex := 0 to lOldClasses.Count-1 do
    begin
      lsClassName := lOldClasses[liIndex];

      if aComponentClasses.IndexOf(lsClassName) < 0 then
        RemoveComponent(lsClassName);

    end;

  lOldClasses.Free;

end; {procedure, SetComponentClasses}


{------------------------------------------------------------------------------}
{ TppComponentPalette.SetDesignControllers}

procedure TppComponentPalette.SetDesignControllers(const Value: TppDesignControllers);
begin

  if FDesignControllers <> Value then
  begin
    FDesignControllers := Value;
  end;

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.SetEnabled}

procedure TppComponentPalette.SetEnabled(const Value: Boolean);
var
  liIndex: Integer;
  lToolbar: TppToolbar;

begin

  if (FEnabled <> Value) then
    begin

      FEnabled := Value;

      for liIndex := 0 to FComponentBars.Count-1 do
        begin
          lToolbar := FComponentBars[liIndex];
          lToolbar.EnableItems(Value);

        end;

    end;

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.SetEventHub}

procedure TppComponentPalette.SetEventHub(aEventHub: TppDesignEventHub);
begin

  if (FEventHub = aEventHub) then Exit;

  if (FEventHub <> nil) and not(csDestroying in FEventHub.ComponentState)  then
    begin
      // workspace events
      FEventHub.WorkspaceEvents.mcDesignModeChanged.RemoveNotify(ehWorkspace_DesignModeChanged);
    end;

  FEventHub := aEventHub;

  if (FEventHub <> nil) then
    begin
      // workspace events
      FEventHub.WorkspaceEvents.mcDesignModeChanged.AddNotify(ehWorkspace_DesignModeChanged);
    end;

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.SetReport}

procedure TppComponentPalette.SetReport(const Value: TppCustomReport);
begin

  if FReport <> Value then
    begin
      FReport := Value;

      if (FReport <> nil) and (FReport.MainReport <> nil) and (FReport.MainReport.DesignEventHub <> nil) then
        SetEventHub(TppDesignEventHub(FReport.MainReport.DesignEventHub))
      else
        SetEventHub(nil);

      SetEnabled(Report <> nil);


    end;

end;

{------------------------------------------------------------------------------}
{ TppComponentPalette.TranslateToolbarCaption}

function TppComponentPalette.TranslateToolbarCaption(const aToolbarCaption: String): String;
begin

  if aToolbarCaption = 'StandardComponents' then
    Result := ppLoadStr(464)

  else if aToolbarCaption = 'DataComponents' then
    Result := ppLoadStr(465)

  else if aToolbarCaption = 'AdvancedComponents' then
     Result := ppLoadStr(466)
  else
    Result  := aToolbarCaption;

end; {function, TranslateToolbarCaption}

end.
