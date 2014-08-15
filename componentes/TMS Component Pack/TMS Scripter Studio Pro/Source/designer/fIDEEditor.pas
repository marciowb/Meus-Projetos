unit fIDEEditor;

interface

{$I ASCRIPT.INC}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, IDEMain, Menus, atScripter, atScript, atPascal, AdvMemo, fObjectInspector,
  fWatches,
  {$IFDEF DELPHI9_LVL}
  fToolPalette,
  {$ENDIF}
  {$IFDEF THEMED_IDE}
  AdvToolbar, AdvGlowButton, AdvToolBarStylers, AdvMenus, AdvMenuStylers,
  AdvOfficeTabSetStylers, AdvOfficeTabSet, AdvAppStyler, AdvSplitter,
  AdvStyleIF,
  {$ENDIF}
  Buttons, dIDEActions, StdCtrls,
  ToolWin, Tabs, ImgList, ActnList;

type
  TIDEEditorForm = class(TForm)
    FLeftPanel: TPanel;
    MainMenu1: TMainMenu;
    FLeftSplitter: TSplitter;
    IDEPaletteToolbar2: TIDEPaletteToolbar;
    File1: TMenuItem;
    N1: TMenuItem;
    Save1: TMenuItem;
    Saveas1: TMenuItem;
    Saveall1: TMenuItem;
    N2: TMenuItem;
    Closefile1: TMenuItem;
    Closeall1: TMenuItem;
    N3: TMenuItem;
    Exit1: TMenuItem;
    N4: TMenuItem;
    Open1: TMenuItem;
    View1: TMenuItem;
    ToggleFormUnit1: TMenuItem;
    Run1: TMenuItem;
    Run2: TMenuItem;
    N5: TMenuItem;
    Stepover1: TMenuItem;
    Traceinto1: TMenuItem;
    Runtocursor1: TMenuItem;
    Rununtilreturn1: TMenuItem;
    Pause1: TMenuItem;
    Scriptreset1: TMenuItem;
    N6: TMenuItem;
    Addwatch1: TMenuItem;
    Togglebreakpoint1: TMenuItem;
    Removefromproject1: TMenuItem;
    Saveprojectas1: TMenuItem;
    Newproject1: TMenuItem;
    N7: TMenuItem;
    Openproject1: TMenuItem;
    Edit1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    SelectAll1: TMenuItem;
    N8: TMenuItem;
    AligntoGrid1: TMenuItem;
    BringtoFront1: TMenuItem;
    SendtoBack1: TMenuItem;
    Align1: TMenuItem;
    Size1: TMenuItem;
    TabOrder1: TMenuItem;
    acLock1: TMenuItem;
    Tools1: TMenuItem;
    DesignerOptions1: TMenuItem;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolBar2: TToolBar;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolBar3: TToolBar;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    FRightPanel: TPanel;
    FRightSplitter: TSplitter;
    NewUnit1: TMenuItem;
    NewForm1: TMenuItem;
    ToolButton15: TToolButton;
    Project1: TMenuItem;
    SelectMainUnit1: TMenuItem;
    ActionList1: TActionList;
    acViewWatches: TAction;
    acViewPalette: TAction;
    acViewInspector: TAction;
    N9: TMenuItem;
    ObjectInspector1: TMenuItem;
    ToolPalette1: TMenuItem;
    Watches1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    TabControl1: TTabControl;
    IDEFormDesignControl1: TIDEFormDesignControl;
    IDEMemo1: TIDEMemo;
    TabSet1: TTabSet;
    FBottomPanel: TPanel;
    FBottomSplitter: TSplitter;
    PopupMenu1: TPopupMenu;
    ToolBar4: TToolBar;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    N10: TMenuItem;
    Undo1: TMenuItem;
    N11: TMenuItem;
    Find1: TMenuItem;
    Replace1: TMenuItem;
    Searchagain1: TMenuItem;
    Redo1: TMenuItem;
    Compile1: TMenuItem;
    procedure PanelDockDrop(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer);
    procedure PanelUnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure ControlBar1DockOver(Sender: TObject; Source: TDragDockObject;
      X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acViewInspectorExecute(Sender: TObject);
    procedure acViewPaletteExecute(Sender: TObject);
    procedure acViewWatchesExecute(Sender: TObject);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    { Private declarations }
  private
    FIDEActions: TdmIDEActions;
    FInspectorForm: TfmObjectInspector;
    {$IFDEF DELPHI9_LVL}
    FPaletteForm: TfmToolPalette;
    {$ENDIF}
    FWatchesForm: TfmWatches;
    FUpdatingTabset: boolean;
    FTitle: string;
    FEngine: TIDEEngine;
    FCloseAllOnExit: boolean;

    {fields for saving engine state}
    FOldDesignControl: TIDEFormDesignControl;
    FOldMemo: TIDEMemo;
    FOldPaletteToolbar: TIDEPaletteToolbar;
    FOldTabControl: TControl;

    FOldBeforeAddWatchDlg: TNotifyEvent;
    FOldOnActiveFileChanged: TNotifyEvent;
    FOldOnRunningChanged: TRunningChangeEvent;
    FOldOnViewModeChanged: TNotifyEvent;
    FOldOnProjNameChanged: TNotifyEvent;
    FOnNotifyShow: TNotifyEvent;

    {$IFDEF THEMED_IDE}
    FTMSFormStyler: TAdvFormStyler;
    FTMSToolbarStyler: TAdvToolbarOfficeStyler;
    FTMSTabStyler: TAdvOfficeTabSetOfficeStyler;
    FTMSMenuStyler: TAdvMenuOfficeStyler;
    FTMSDockPanel: TAdvDockPanel;
    FTMSTabSet: TAdvOfficeTabSet;
    {$ENDIF}

    procedure IDEEngineProjNameChanged(Sender: TObject);
    procedure UpdateCodeTabset(ATabset: TTabset);
    function PanelSplitter(APanel: TPanel): TSplitter;
    function PanelSize(APanel: TPanel): integer;
    procedure SetPanelSize(APanel: TPanel; ASize: integer);
    procedure SetSplitterPos(APanel: TPanel; APos: integer);
    procedure UpdatePanel(APanel: TPanel; AIgnore: TControl = nil);
    procedure ShowDockedForm(AForm: TForm; AVisible: boolean; AFocus: boolean = true);
    procedure DockFormClose(Sender: TObject; var Action: TCloseAction);
    procedure SetTitle(const Value: string);
    procedure IDEEngineViewModeChanged(Sender: TObject);
    procedure IDEEngineActiveFileChanged(Sender: TObject);
    procedure IDEEngineBeforeAddWatchDlg(Sender: TObject);
    procedure IDEEngineRunningChanged(Sender: TObject;
      ARunning: Boolean);

    {$IFDEF THEMED_IDE}
    procedure TMSStyleChanged(Sender: TObject);
    procedure CreateTMSInterface;
    function GetAppStyler: TAdvAppStyler;
    procedure SetAppStyler(const Value: TAdvAppStyler);
    {$ENDIF}
  public
    procedure AttachEngine(AEngine: TIDEEngine);
    procedure DetachEngine;

    procedure ShowInspector(AVisible: boolean);
    procedure ShowPalette(AVisible: boolean);
    procedure ShowWatches(AVisible: boolean; AFocus: boolean = true);

    property IDEActions: TdmIDEActions read FIDEActions;
    property Title: string read FTitle write SetTitle;
    property CloseAllOnExit: boolean read FCloseAllOnExit write FCloseAllOnExit;
    property OnNotifyShow: TNotifyEvent read FOnNotifyShow write FOnNotifyShow;
    property InspectorForm: TfmObjectInspector read FInspectorForm;

    {$IFDEF THEMED_IDE}
    property AppStyler: TAdvAppStyler read GetAppStyler write SetAppStyler;
    {$ENDIF}
  end;

var
  IDEEditorForm: TIDEEditorForm;

implementation

{$R *.DFM}

function TIDEEditorForm.PanelSplitter(APanel: TPanel): TSplitter;
begin
  if APanel = FLeftPanel then
    result := FLeftSplitter
  else
  if APanel = FRightPanel then
    result := FRightSplitter
  else
    result := FBottomSplitter;
end;

function TIDEEditorForm.PanelSize(APanel: TPanel): integer;
begin
  if APanel.Align in [alTop, alBottom] then
    result := APanel.Height
  else
    result := APanel.Width;
end;

procedure TIDEEditorForm.AttachEngine(AEngine: TIDEEngine);
var
  AActiveFile: TIDEProjectFile;
begin
  FEngine := AEngine;

  {properties}
  FOldDesignControl := FEngine.DesignControl;
  FOldMemo := FEngine.Memo;
  FOldPaletteToolbar := FEngine.PaletteToolbar;
  FOldTabControl := FEngine.TabControl;

  FEngine.DesignControl := IDEFormDesignControl1;
  FEngine.Memo := IDEMemo1;
  FEngine.PaletteToolbar := IDEPaletteToolbar2;
  {$IFDEF THEMED_IDE}
  FEngine.TabControl := FTMSTabSet;
  IDEMemo1.BorderStyle := bsNone;
  {$ELSE}
  FEngine.TabControl := TabControl1;
  {$ENDIF}

  {events}
  FOldBeforeAddWatchDlg := FEngine.BeforeAddWatchDlg;
  FOldOnActiveFileChanged := FEngine.OnActiveFileChanged;
  FOldOnRunningChanged := FEngine.OnRunningChanged;
  FOldOnViewModeChanged := FEngine.OnViewModeChanged;
  FOldOnProjNameChanged := FEngine.OnProjNameChanged;

  FEngine.BeforeAddWatchDlg := IDEEngineBeforeAddWatchDlg;
  FEngine.OnActiveFileChanged := IDEEngineActiveFileChanged;
  FEngine.OnRunningChanged := IDEEngineRunningChanged;
  FEngine.OnViewModeChanged := IDEEngineViewModeChanged;
  FEngine.OnProjNameChanged := IDEEngineProjNameChanged;

  {controls}
  FIDEActions.Engine := FEngine;
  FInspectorForm.Engine := FEngine;
  {$IFDEF DELPHI9_LVL}
  FPaletteForm.Engine := FEngine;
  {$ENDIF}
  FWatchesForm.Engine := FEngine;

  {Choose active file}
  AActiveFile := FEngine.ActiveFile;
  if AActiveFile = nil then
    AActiveFile := FEngine.MainUnit;
  if (AActiveFile = nil) and (FEngine.Files.Count > 0) then
    AActiveFile := FEngine.Files[0];
  FEngine.UpdateIDE(AActiveFile);
end;

procedure TIDEEditorForm.DetachEngine;
begin
  if FEngine <> nil then
  begin
    FEngine.UpdateIDE(nil);

    FEngine.DesignControl := FOldDesignControl;
    FEngine.Memo := FOldMemo;
    FEngine.PaletteToolbar := FOldPaletteToolbar;
    FEngine.TabControl := FOldTabControl;

    FEngine.BeforeAddWatchDlg := FOldBeforeAddWatchDlg;
    FEngine.OnActiveFileChanged := FOldOnActiveFileChanged;
    FEngine.OnRunningChanged := FOldOnRunningChanged;
    FEngine.OnViewModeChanged := FOldOnViewModeChanged;
    FEngine.OnProjNameChanged := FOldOnProjNameChanged;
  end;
end;

{$IFDEF THEMED_IDE}
procedure TIDEEditorForm.SetAppStyler(const Value: TAdvAppStyler);
begin
  if FTMSFormStyler <> nil then
    FTMSFormStyler.AppStyle := Value;
end;
{$ENDIF}

procedure TIDEEditorForm.SetPanelSize(APanel: TPanel; ASize: integer);
begin
  if APanel.Align in [alTop, alBottom] then
    APanel.Height := ASize
  else
    APanel.Width := ASize;
end;

procedure TIDEEditorForm.SetSplitterPos(APanel: TPanel; APos: integer);
begin
  if APanel.Align in [alTop, alBottom] then
    PanelSplitter(APanel).Top := APos
  else
    PanelSplitter(APanel).Left := APos;
end;

procedure TIDEEditorForm.UpdatePanel(APanel: TPanel; AIgnore: TControl = nil);
var
  AEmpty: boolean;
  c: integer;
begin
  AEmpty := true;
  {If there is *one* control dock that is visible, and this control is not the ignore control,
   than the panel is not empty}
  for c := 0 to APanel.DockClientCount - 1 do
    if APanel.DockClients[c].Visible and (APanel.DockClients[c] <> AIgnore) then
    begin
      AEmpty := false;
      break;
    end;

  if AEmpty then
  begin
    if PanelSize(APanel) > 0 then
    begin
      APanel.Tag := PanelSize(APanel);
      SetPanelSize(APanel, 0);
    end;
    PanelSplitter(APanel).Visible := false;
  end else
  begin
    if APanel.Tag <> 0 then
    begin
      SetPanelSize(APanel, APanel.Tag);
      APanel.Tag := 0;
    end;
    PanelSplitter(APanel).Visible := true;
    SetSplitterPos(APanel, PanelSize(APanel));
  end;
end;

procedure TIDEEditorForm.PanelDockDrop(Sender: TObject; Source: TDragDockObject;
  X, Y: Integer);
begin
  UpdatePanel(TPanel(Sender));
end;

procedure TIDEEditorForm.PanelUnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
  UpdatePanel(TPanel(Sender), Client);
end;

procedure TIDEEditorForm.ControlBar1DockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  Accept := not (Source.Control is TCustomForm);
end;

{$IFDEF THEMED_IDE}
procedure TIDEEditorForm.CreateTMSInterface;

  function CreateToolBar(APanel: TAdvDockPanel): TAdvToolBar;
  begin
    result := TAdvToolBar.Create(APanel);
    result.Images := FIDEActions.ImageList1;
    result.Parent := APanel;

    result.AutoPositionControls := True;
    result.AutoArrangeButtons := True;
    result.AutoSize := True;

    result.ShowOptionIndicator := false;
    result.ShowRightHandle := false;
  end;

  function ReplaceSplitter(ASplitter: TSplitter): TSplitter;
  var
    TMSSplitter: TAdvSplitter;
  begin
    TMSSplitter := TAdvSplitter.Create(Self);
    TMSSplitter.Parent := ASplitter.Parent;
    TMSSplitter.Align := ASplitter.Align;
    TMSSplitter.AutoSnap := ASplitter.AutoSnap;
    TMSSplitter.BoundsRect := ASplitter.BoundsRect;
    TMSSplitter.ResizeStyle := ASplitter.ResizeStyle;
    TMSSplitter.Visible := ASplitter.Visible;
    ASplitter.Visible := false;

    result := TMSSplitter;
  end;

var
  TMSBar: TAdvToolbar;
  TMSButton: TAdvGlowButton;

  TMSMenu: TAdvMainMenu;
  MenuItem: TMenuItem;
  DelphiBar: TToolbar;
  DelphiButton: TToolButton;
  c: integer;
  d: integer;

  ATop: integer;
  ALastLeft: integer;
begin
  {Create a new whole tms interface on the fly, based on the existing controls}
  FTMSFormStyler := TAdvFormStyler.Create(Self);
  FTMSFormStyler.OnChange := TMSStyleChanged;

  {--- Creating the dock panel ---}
  FTMSToolbarStyler := TAdvToolbarOfficeStyler.Create(Self);
  FTMSMenuStyler := TAdvMenuOfficeStyler.Create(Self);
  FTMSToolbarStyler.AdvMenuStyler := FTMSMenuStyler;

  FTMSDockPanel := TAdvDockPanel.Create(Self);
  FTMSDockPanel.ToolBarStyler := FTMSToolbarStyler;
  FTMSDockPanel.Parent := Self;

  {--- Replacing MENU ---}
  TMSMenu := TAdvMainMenu.Create(Self);
  while Menu.Items.Count > 0 do
  begin
    MenuItem := Menu.Items[0];
    Menu.Items.Remove(MenuItem);
    TMSMenu.Items.Add(MenuItem);
  end;
  Menu := nil;

  TMSBar := CreateToolBar(FTMSDockPanel);
  TMSBar.Menu := TMSMenu;
  TMSBar.FullSize := true;
  TMSBar.UpdateMenu;

  {--- Replacing TOOLBAR ---}
  ATop := -1;
  ALastLeft := 0;
  for c := 0 to ControlBar1.ControlCount - 1 do
    if ControlBar1.Controls[c] is TToolbar then
    begin
      DelphiBar := TToolbar(ControlBar1.Controls[c]);
      TMSBar := CreateToolBar(FTMSDockPanel);

      for d := 0 to DelphiBar.ButtonCount - 1 do
      begin
        DelphiButton := DelphiBar.Buttons[d];
        case DelphiButton.Style of
          tbsButton:
            begin
              TMSButton := TAdvGlowButton.Create(TMSBar);
              TMSButton.ImageIndex := DelphiButton.ImageIndex;
              TMSButton.Action := DelphiButton.Action;
              TMSButton.ShowCaption := false;
              TMSButton.Transparent := true;
              TMSBar.AddToolBarControl(TMSButton);
              TMSButton.AutoSize := true;
            end;
          tbsSeparator:
            begin
              TMSBar.AddToolBarControl(TAdvToolBarSeparator.Create(TMSBar));
            end;
        end;
      end;

      tmsbar.left := Width;   // place it to the right so that it should be added to the tail of upper row

      if ATop = -1 then
        ATop := TMSBar.Top
      else
        TMSBar.Top := ATop;
      tmsbar.left := ALastLeft;
      ALastLeft := ALastLeft + tmsbar.Width;
    end;

  ControlBar1.Visible := false;

  //Force first bar
  FTMSDockPanel.ArrangeToolBars;


  {--- Replacing Office Tabset ---}
  FTMSTabStyler := TAdvOfficeTabSetOfficeStyler.Create(Self);
  FTMSTabSet := TAdvOfficeTabSet.Create(Self);
  FTMSTabSet.Parent := Panel2;
  FTMSTabSet.Align := alTop;
  FTMSTabSet.Height := 26;
  FTMSTabSet.AdvOfficeTabSetStyler := FTMSTabStyler;
  FTMSTabSet.Init;
  while TabControl1.ControlCount > 0 do
    TabControl1.Controls[0].Parent := Panel2;
  TabControl1.Visible := false;

  {--- Replacing splitters ---}
  FRightSplitter := ReplaceSplitter(FRightSplitter);
  FLeftSplitter := ReplaceSplitter(FLeftSplitter);
  FBottomSplitter := ReplaceSplitter(FBottomSplitter);


  {--- final settings ---}
  FTMSFormStyler.Style := AdvStyleIf.tsWindowsXP;
  FTMSFormStyler.Style := AdvStyleIf.tsOffice2003Blue;
  {tsOffice2003Blue, tsOffice2003Silver, tsOffice2003Olive,
   tsOffice2003Classic, tsOffice2007Luna, tsOffice2007Obsidian,
   tsWindowsXP, tsWhidbey, tsCustom, tsOffice2007Silver}
end;
{$ENDIF}

procedure TIDEEditorForm.FormCreate(Sender: TObject);
var
  c: integer;
begin
  FIDEActions := TdmIDEActions.Create(Self);

  //FIDEActions.Engine := FEngine;

  {Create object inspector form}
  FInspectorForm := TfmObjectInspector.Create(Self);
  FInspectorForm.OnClose := DockFormClose;
  {Dock the form to the panel so it begins docked}
  FInspectorForm.ManualDock(FLeftPanel, nil, alClient);
  //FInspectorForm.Engine := FEngine;
  ShowInspector(true);

  {Create palette buttons if current Delphi version support it.
   Otherwise, hide right panel}
  {$IFDEF DELPHI9_LVL}
  FPaletteForm := TfmToolPalette.Create(Self);
  FPaletteForm.OnClose := DockFormClose;
  FPaletteForm.ManualDock(FRightPanel, nil, alClient);
  //FPaletteForm.Engine := FEngine;
  ShowPalette(true);
  IDEPaletteToolbar2.Visible := false;

  {visual stuff}
  Tabset1.Style := tsSoftTabs;
  {$IFDEF DELPHI2006_LVL}
  ControlBar1.DrawingStyle := ExtCtrls.dsGradient;
  {$ENDIF}
  //IDEMemo1.BorderStyle := bsNone;

  {$ELSE}
  UpdatePanel(FRightPanel);
  {$ENDIF}

  for c := 0 to ControlBar1.ControlCount - 1 do
    With TToolbar(ControlBar1.Controls[c]) do
    begin
      {$IFDEF DELPHI2006_LVL}
      DrawingStyle := dsGradient;
      {$ENDIF}
      EdgeInner := esNone;
      EdgeOuter := esNone;
      Transparent := true;
    end;
  {Create watch form}
  FWatchesForm := TfmWatches.Create(Self);
  FWatchesForm.OnClose := DockFormClose;
  FWatchesForm.ManualDock(FBottomPanel, nil, alClient);
  //FWatchesForm.Engine := FEngine;
  ShowWatches(false);

  {Assign remaining components to IDEEngine}
  //FEngine.NewProject;

  {$IFDEF THEMED_IDE}
  CreateTMSInterface;
  {$ENDIF}
end;

procedure TIDEEditorForm.DockFormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (Sender is TForm) and (TForm(Sender).HostDockSite is TPanel) then
    UpdatePanel(TPanel(TForm(Sender).HostDockSite), TForm(Sender));
end;

procedure TIDEEditorForm.ShowInspector(AVisible: boolean);
begin
  ShowDockedForm(FInspectorForm, AVisible);
end;

procedure TIDEEditorForm.ShowPalette(AVisible: boolean);
begin
  {$IFDEF DELPHI9_LVL}
  ShowDockedForm(FPaletteForm, AVisible);
  {$ENDIF}
end;

procedure TIDEEditorForm.ShowWatches(AVisible: boolean; AFocus: boolean = true);
begin
  ShowDockedForm(FWatchesForm, AVisible, AFocus);
end;

procedure TIDEEditorForm.ShowDockedForm(AForm: TForm; AVisible: boolean;
  AFocus: boolean = true);
var
  APanel: TPanel;
begin
  AForm.Visible := AVisible;
  if (AForm.HostDockSite <> nil) and (AForm.HostDockSite is TPanel) then
    APanel := TPanel(AForm.HostDockSite)
  else
    APanel := nil;

  if (APanel <> nil) then //form is docked
  begin
    if AVisible then
    begin
      if Self.Visible and APanel.CanFocus and AFocus then
        APanel.SetFocus;
      if Self.Visible and AForm.CanFocus and AFocus then
        AForm.SetFocus;
    end;
    UpdatePanel(APanel);
  end else
    if Self.Visible and AForm.CanFocus and AFocus then
      AForm.SetFocus;
end;

procedure TIDEEditorForm.FormShow(Sender: TObject);
begin
  {Request realign so the control is alClient aligned}
  FLeftPanel.Width := FLeftPanel.Width + 1;
  FLeftPanel.Width := FLeftPanel.Width - 1;
  FRightPanel.Width := FRightPanel.Width + 1;
  FRightPanel.Width := FRightPanel.Width - 1;
  FBottomPanel.Height := FBottomPanel.Height + 1;
  FBottomPanel.Height := FBottomPanel.Height + 1;

  {Create the main units. We must call this in FormShow (not FormCreate) because
   some errors might occur}
  if FEngine <> nil then
  begin
    if FEngine.Files.Count = 0 then
      FEngine.CreateMainUnits(slPascal);
  end;

  {$IFDEF THEMED_IDE}
  FTMSDockPanel.ArrangeToolBars;
  {$ENDIF}

  if Assigned(FOnNotifyShow) then
    FOnNotifyShow(Self);
end;

{$IFDEF THEMED_IDE}
function TIDEEditorForm.GetAppStyler: TAdvAppStyler;
begin
  if FTMSFormStyler <> nil then
    result := FTMSFormStyler.AppStyle
  else
    result := nil;
end;
{$ENDIF}

procedure TIDEEditorForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
  if FEngine <> nil then
  begin
    FEngine.UpdateIDE(nil);
    if FCloseAllOnExit then
      CanClose := FEngine.DlgCloseAll
  end;
end;

procedure TIDEEditorForm.IDEEngineProjNameChanged(Sender: TObject);
begin
  if FEngine <> nil then
    Caption := Format(Title, [FEngine.ProjectName])
  else
    Caption := '';
end;

procedure TIDEEditorForm.IDEEngineViewModeChanged(Sender: TObject);
begin
  UpdateCodeTabset(Tabset1);
end;

procedure TIDEEditorForm.UpdateCodeTabset(ATabset: TTabset);
begin
  FUpdatingTabset := true;
  try
    if (FEngine <> nil) and (FEngine.ActiveFile <> nil) then
    begin
      {make tabset visible if there is an active file}
      ATabset.Visible := true;

      {Create one (code) or two (code/design) tabs depending if the active file has a form} 
      if ATabset.Tabs.Count = 0 then
        ATabset.Tabs.Add(' Code ');
      if FEngine.ActiveFile.IsForm then
      begin
        if ATabset.Tabs.Count = 1 then
          ATabset.Tabs.Add(' Design ');
      end else
      begin
        if ATabset.Tabs.Count = 2 then
          ATabset.Tabs.Delete(1);
      end;

      {make the correct tab active}
      Case FEngine.ActiveFile.ViewMode of
        vmUnit:
          if ATabSet.Tabs.Count > 0 then
            ATabset.TabIndex := 0;
        vmForm:
          if ATabSet.Tabs.Count > 1 then
            ATabset.TabIndex := 1;
      end;
    end else
      ATabset.Visible := false;
  finally
    FUpdatingTabset := false;
  end;
end;

procedure TIDEEditorForm.TabSet1Change(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  if (FEngine <> nil) and (FEngine.ActiveFile <> nil) and not FUpdatingTabset then
  Case NewTab of
    0: FEngine.ActiveFile.ViewMode := vmUnit;
    1: FEngine.ActiveFile.ViewMode := vmForm;
  end;
end;

{$IFDEF THEMED_IDE}
procedure TIDEEditorForm.TMSStyleChanged(Sender: TObject);
var
  PanelColor: TColor;
begin
  case FTMSFormStyler.Style of
    tsOffice2003Blue:
      begin
      end;
    tsOffice2003Silver:
      begin
      end;
    tsOffice2003Olive:
      begin
      end;
    tsOffice2003Classic:
      begin
      end;
    tsOffice2007Luna:
      begin
      end;
    tsOffice2007Obsidian:
      begin
      end;
    tsWindowsXP:
      begin
      end;
    tsWhidbey:
      begin
      end;
    tsOffice2007Silver:
      begin
      end;
  end;

  PanelColor := FTMSToolbarStyler.DockColor.ColorTo;

  {Apply styles to}
  Self.Color := PanelColor;
  FRightPanel.Color := PanelColor;
  FLeftPanel.Color := PanelColor;
  FBottomPanel.Color := PanelColor;
end;
{$ENDIF}

procedure TIDEEditorForm.IDEEngineActiveFileChanged(Sender: TObject);
begin
  UpdateCodeTabset(Tabset1);
end;

procedure TIDEEditorForm.acViewInspectorExecute(Sender: TObject);
begin
  ShowInspector(true);
end;

procedure TIDEEditorForm.acViewPaletteExecute(Sender: TObject);
begin
  ShowPalette(true);
end;

procedure TIDEEditorForm.acViewWatchesExecute(Sender: TObject);
begin
  ShowWatches(true);
end;

procedure TIDEEditorForm.IDEEngineBeforeAddWatchDlg(Sender: TObject);
begin
  ShowWatches(true);
end;

procedure TIDEEditorForm.IDEEngineRunningChanged(Sender: TObject;
  ARunning: Boolean);
begin
  ShowWatches(ARunning, false);
end;

procedure TIDEEditorForm.SetTitle(const Value: string);
begin
  if FTitle <> Value then
  begin
    FTitle := Value;
    IDEEngineProjNameChanged(nil);
  end;
end;

end.
