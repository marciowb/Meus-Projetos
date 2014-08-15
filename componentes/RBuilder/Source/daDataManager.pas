{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daDataManager;

interface

{$I ppIfDef.pas}

uses
  Messages, SysUtils, Classes, Controls, Dialogs, Graphics, Forms, Menus,
  StdCtrls, Windows, ExtCtrls,

  ppTypes,
  ppUtils,
  ppComm,
  ppClass,
  ppDB,
  ppIniStorage,
  ppDsgnDB,
  ppDsIntf,
  ppWizard,
  ppForms,

  daDataModule,
  daDataView,
  daDB,
  daForms,
  daDataWizardManager,
  daDataWizard,
  daDataViewToolWin,
  daLinkManager,

  ppTBX,

  ppToolBarTBX,
  ppDsgner,
  ppPopupMenuBase,
  ppToolResources;

type

  TdaDesignerMenu = class;

  TppDataViewWindowList = class;

  { TdaDataManager

    Handles the coordination of the various visual elements displayed in the
    Data workspace, including the tool windows for each dataview and any links
    which may have been established between them.  Utilizes the DataWizardManager
    for the creation of new dataviews, but takes responsibility for configuring
    and displaying the dataview once it has been created. }

  TdaDataManager = class(TppDesignModule)
    private
      FCurrentReport: TppCustomReport;
      FDataModule: TdaDataModule;
      FDataViewWindows: TppDataViewWindowList;
      FReportDesigner: TppDesignerWindow;
      FLinkManager: TdaLinkManager;
      FMenuBar: TdaDesignerMenu;
      FPaintBox: TPaintBox;
      FReport: TppCustomReport;
      FWalkieTalkie: TppCommunicator;
      FWizardManager: TdaDataWizardManager;
      FWorkSpace: TdaScrollBox;

      function  AddDataViewWindow(aDataView: TdaDataView): TdaDataViewToolWin;
      function GetDefaultSaveToType:TppSaveToType;
      procedure AdjustDataViewTops(aMergeDataModule: TdaDataModule);
      procedure CalcWindowPosition(aDataViewWindow: TdaDataViewToolWin);
      procedure CreateControls;
      procedure DisplayMetaData;
      procedure FreeAllVisualControls;
      procedure FreeVisualControls(aDataView: TdaDataView);
      function GetDataModuleForReport: TdaDataModule;
      procedure HideVisualControls;
      procedure InitializeDataViewWindows;
      procedure InitializeStatusBar;
      procedure SetDataViewsOutOfSync;
      procedure SetAllowDataSettingsChange(aValue: Boolean);
      procedure SetDataModule(aDataModule: TdaDataModule);
      procedure SetReport(aReport: TppCustomReport);
      procedure ShowVisualControls;
      procedure SyncDataViews;
      procedure UpdateDataViewWindows;

      {event handlers}
      procedure EditDataViewEvent(Sender: TObject);
      procedure FileMenuClickEvent(Sender: TObject);
      procedure FileMenuItemClickEvent(Sender: TObject);
      procedure DataModuleRemoveChildEvent(Sender: TObject);
      procedure DataModuleLanguageChangedEvent(Sender: TObject);
      procedure DeleteDataViewEvent(Sender: TObject);
      procedure DesignerDataSettingsChangeEvent(Sender: TObject);
      procedure WalkieTalkieNotifyEvent(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType);
      procedure WorkspaceMouseDownEvent(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    protected
      procedure ActivateDataWorkspace; virtual;
      procedure DeactivateDataWorkspace; virtual;
      procedure SetComponent(aComponent: TComponent); override;
      procedure SetLanguageIndex(aLanguageIndex: Integer); override;

    public
      constructor CreateModule(aParent: TWinControl; aComponentDesigner: TppComponentDesigner); override;
      destructor Destroy; override;

      procedure ActiveChanging(var aAllowChange: Boolean); override;
      procedure LoadStart; override;
      procedure LoadEnd; override;
      procedure SaveStateInfo; override;
      procedure LoadStateInfo; override;
      procedure SaveStart; override;

      function DesignDataView(aDataView: TdaDataView): Boolean;
      procedure DisplayDataSettingsDialog;
      procedure ExportDataModule(aTarget: TppSaveToType);
      function GetDefaultDescription: String;
      function GetToolWindowForDataView(aDataView: TdaDataView): TdaDataViewToolWin;
      procedure ImportDataModule(aSource: TppSaveToType);
      procedure MergeDataModule(aSource: TppSaveToType);
      procedure NewDataView;
      procedure UpdateEnabledOptions;

      property DataModule: TdaDataModule read FDataModule write SetDataModule;
      property DataViewWindows: TppDataViewWindowList read FDataViewWindows;
      property MenuBar: TdaDesignerMenu read FMenuBar;

   end; {class, TdaDataManager}


  { TppDataViewWindowList

    Manages a dual list of ToolWindows and their corresponding DataViews,
    thus allowing access via an Index or a DataView }

  TppDataViewWindowList = class
    private
      FToolWindows: TList;
      FDataViews: TList;

      function GetCount: Integer;
      function GetDataViewWindow(aIndex: Integer): TdaDataViewToolWin;

    public
      constructor Create;
      destructor Destroy; override;

      procedure Add(aDataViewToolWin: TdaDataViewToolWin);
      procedure Clear;
      procedure Delete(aIndex: Integer);
      function GetWindowForDataView(aDataView: TdaDataView): TdaDataViewToolWin;
      function IndexOfDataView(aDataView: TdaDataView): Integer;
      procedure Remove(aDataViewToolWin: TdaDataViewToolWin);

      property Count: Integer read GetCount;
      property ToolWindows[Index: Integer]: TdaDataViewToolWin read GetDataViewWindow; default;

  end; {class, TppDataViewWindowList}


  {TdaDataFileMenu}
  TdaDataFileMenu = class(TppSubMenuItem)
  private
    FClose: TppTBXitem;
    FDataSettings: TppTBXItem;
    FExport: TppTBXItem;
    FExportToFile: TppTBXItem;
    FImport: TppTBXItem;
    FImportFromFile: TppTBXItem;
    FMerge: TppTBXItem;
    FNew: TppTBXItem;
    FOnItemClick: TNotifyEvent;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject); virtual;

  public

    procedure LanguageChanged; override;
    property Close: TppTBXitem read FClose;
    property DataSettings: TppTBXItem read FDataSettings;
    property Export: TppTBXItem read FExport;
    property ExportToFile: TppTBXItem read FExportToFile;
    property Import: TppTBXItem read FImport;
    property ImportFromFile: TppTBXItem read FImportFromFile;
    property Merge: TppTBXItem read FMerge;
    property New: TppTBXItem read FNew;

  published
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;
  end;


  {TdaDesignerMenu }
  TdaDesignerMenu = class(TppMenuBar)
  private
    FFileMenu: TdaDataFileMenu;
    
  protected
    procedure CreateItems; override;

  public
    constructor Create(Owner: TComponent); override;
    procedure LanguageChanged; override;

    property FileMenu: TdaDataFileMenu read FFileMenu;
  end;


implementation

uses
  daMetaDataDlg;
  
type
  TdaFileMenuCommandType = (fmDataSettings, fmNew, fmClose, fmImport, fmMerge, fmExport, fmImportFromFile, fmExportToFile);

const
  cMenuCaptions: array [0..0] of Integer = (704); {&File}

  {'&Data Settings', '&New', 'Close', '&Import', '&Merge', '&Export', '&Import From File', '&Export To File', }
  cFileMenuCaptions: array [Low(TdaFileMenuCommandType)..High(TdaFileMenuCommandType)] of Integer =
                     (701, 708, 132, 705, 707, 702, 706, 703);


{------------------------------------------------------------------------------}
{ daDefaultDatabaseType }

function daDefaultDatabaseType(aDataOwner: TComponent; const aSessionType, aDatabaseName: String): TppDatabaseType;
var
  lSessionClass: TdaSessionClass;
  lSession: TdaSession;
begin

  Result := dtOther;

  lSessionClass := daGetSessionClass(aSessionType);

  if (lSessionClass <> nil) then
    begin
      lSession := lSessionClass.Create(nil);
      lSession.DataOwner := aDataOwner;
 
      Result := lSession.GetDatabaseType(aDatabaseName);

      lSession.Free;
    end;

end; {function, daDefaultDatabaseType}

{******************************************************************************
 *
 ** D A T A   M A N A G E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDataManager.CreateModule }

constructor TdaDataManager.CreateModule(aParent: TWinControl; aComponentDesigner: TppComponentDesigner);
begin

  inherited CreateModule(aParent, aComponentDesigner);

  Name := 'Data'; // do not localize
  
  Caption := ppLoadStr(742); {Data}
  OrderIndex := 1;

  FCurrentReport := nil;
  FDataModule := nil;
  FDataViewWindows := TppDataViewWindowList.Create;
  FLinkManager := TdaLinkManager.Create(Self);
  FPaintBox := nil;
  FReport := nil;
  FWalkieTalkie := TppCommunicator.Create(nil);
  FWalkieTalkie.OnNotify := WalkieTalkieNotifyEvent;
  FWizardManager := TdaDataWizardManager.Create(nil);
  FWizardManager.DataManager := Self;
  FWorkspace := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaDataManager.Destroy }

destructor TdaDataManager.Destroy;
begin

  if (FReportDesigner <> nil) and (FReportDesigner.DataSettings <> nil) then
    TppDataSettings(FReportDesigner.DataSettings).OnChange := nil;


  {clear the data view window list}
  FDataViewWindows.Clear;

  SetDataModule(nil);

  FLinkManager.Free;
  FLinkManager := nil;

  FDataViewWindows.Free;
  FDataViewWindows := nil;

  FWizardManager.Free;
  FWizardManager := nil;

  FWalkieTalkie.Free;
  FWalkieTalkie := nil;

  inherited Destroy;

end; {constructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaDataManager.WalkieTalkieNotifyEvent }

procedure TdaDataManager.WalkieTalkieNotifyEvent(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  if (aOperation = ppopRemove) and (aCommunicator = FDataModule) then
    SetDataModule(nil);

end; {procedure, WalkieTalkieNotifyEvent}


{------------------------------------------------------------------------------}
{ TdaDataManager.SetComponent }

procedure TdaDataManager.SetComponent(aComponent: TComponent);
begin

  if (aComponent <> nil) and not (aComponent is TppCustomReport) then Exit;

  inherited SetComponent(aComponent);

  SetReport(TppCustomReport(aComponent));

end; {procedure, SetComponent}

{------------------------------------------------------------------------------}
{ TdaDataManager.SetReport }

procedure TdaDataManager.SetReport(aReport: TppCustomReport);
begin

  FReport := aReport;

  if (csDestroying in ComponentState) then Exit;

  if (FReport <> nil) then
     SetLanguageIndex(FReport.LanguageIndex);

  if (Active) then
    begin
      if (FMenubar <> nil) then
        FMenubar.EnableItems(FReport <> nil);
      SetDataModule(GetDataModuleForReport);
    end;

end; {procedure, SetReport}

{------------------------------------------------------------------------------}
{ TdaDataManager.SetDataModule }

procedure TdaDataManager.SetDataModule(aDataModule: TdaDataModule);
begin

  if (FDataModule = aDataModule) then Exit;

  if (FDataModule <> nil) then
    begin
      FDataModule.RemoveNotify(FWalkieTalkie);

      FDataModule.OnRemoveChild := nil;
      FDataModule.OnLanguageChanged := nil;

      if Active then
        FreeAllVisualControls;
    end;

  FDataModule := aDataModule;
  FLinkManager.DataModule := aDataModule;
  FWizardManager.DataModule := aDataModule;

  if (FDataModule <> nil) then
    begin
      FDataModule.AddNotify(FWalkieTalkie);

      FDataModule.OnRemoveChild := DataModuleRemoveChildEvent;
      FDataModule.OnLanguageChanged := DataModuleLanguageChangedEvent;

      InitializeDataViewWindows;
    end;

end; {procedure, SetDataModule}

{------------------------------------------------------------------------------}
{ TdaDataManager.DataModuleRemoveChildEvent}

procedure TdaDataManager.DataModuleRemoveChildEvent(Sender: TObject);
var
  lDataView: TdaDataView;
begin

  lDataView := TdaDataView(Sender);

  FreeVisualControls(lDataView);

end; {procedure, DataModuleRemoveChildEvent}

{------------------------------------------------------------------------------}
{ TdaDataManager.DataModuleLanguageChangedEvent}

procedure TdaDataManager.DataModuleLanguageChangedEvent(Sender: TObject);
begin

  if (FReport <> nil) then
    SetLanguageIndex(FReport.LanguageIndex);

end; {procedure, DataModuleLanguageChangedEvent}

{------------------------------------------------------------------------------}
{ TdaDataManager.SetAllowDataSettingsChange }

procedure TdaDataManager.SetAllowDataSettingsChange(aValue: Boolean);
var
  liIndex: Integer;
begin

  FMenubar.FFileMenu.DataSettings.Visible := aValue;

  liIndex := FMenubar.FFileMenu.IndexOf(FMenubar.FFileMenu.DataSettings);

  {set the line "-" item  visibility also}
  FMenubar.FFileMenu.Items[liIndex+1].Visible := aValue;

end; {procedure, SetAllowDataSettingsChange}

{------------------------------------------------------------------------------}
{ TdaDataManager.CreateControls }

procedure TdaDataManager.CreateControls;
begin

  FReportDesigner := TppDesignerWindow(ComponentDesigner);

  FMenuBar := TdaDesignerMenu.Create(Parent);
  FMenuBar.Initialize(nil);
  FMenuBar.FileMenu.OnClick := FileMenuClickEvent;
  FMenuBar.FileMenu.OnItemClick := FileMenuItemClickEvent;

  {create workspace scrollbox}
  FWorkSpace := TdaScrollBox.Create(Parent);
  FWorkSpace.Parent := Parent;
  FWorkSpace.Align := alClient;
{$IFDEF Delphi7}
  FWorkSpace.ParentColor := True;
{$ELSE}
  FWorkSpace.Color := clWindow;
//  FWorkSpace.Color := clBtnFace; // old color
{$ENDIF}

//  FWorkSpace.Ctl3D := False;  // not needed
  FWorkSpace.BorderStyle := bsNone;

  FWorkSpace.HorzScrollBar.Range := 7200;
  FWorkSpace.VertScrollBar.Range := 7200;

  {create workspace paintbox}
  FPaintBox := TPaintBox.Create(FWorkSpace);
  FPaintBox.Parent := FWorkSpace;
  FPaintBox.Align := alClient;

  FLinkManager.SetVisualControls(FWorkspace, FPaintBox);

  {enable display of meta data cache}
  FPaintBox.OnMouseDown := WorkspaceMouseDownEvent;

  LoadStateInfo;

  if (FReportDesigner.DataSettings <> nil) then
   TppDataSettings(FReportDesigner.DataSettings).OnChange := DesignerDataSettingsChangeEvent;

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaDataManager.WorkspaceMouseDownEvent }

procedure TdaDataManager.WorkspaceMouseDownEvent(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (ssCtrl in Shift) then
    DisplayMetaData;
end; {procedure, WorkspaceMouseDownEvent}

{------------------------------------------------------------------------------}
{ TdaDataManager.DisplayMetaData }

procedure TdaDataManager.DisplayMetaData;
var
  lDialog: TForm;
begin

  lDialog := TdaMetaDataDialog.Create(Owner);

  lDialog.ShowModal;

  lDialog.Free;

end; {procedure, DisplayMetaData}

{------------------------------------------------------------------------------}
{ TdaDataManager.LoadStateInfo }

procedure TdaDataManager.LoadStateInfo;
var
  lIniStorage: TppIniStorage;
begin

  if FWorkSpace = nil then Exit;

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  FWizardManager.DataSettings.LoadStateInfo(lIniStorage, FDataModule);

  lIniStorage.Free;

end; {procedure, LoadStateInfo}

{------------------------------------------------------------------------------}
{ TdaDataManager.SaveStateInfo }

procedure TdaDataManager.SaveStateInfo;
var
  lIniStorage: TppIniStorage;
begin

  if FWorkspace = nil then Exit;

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  FWizardManager.DataSettings.SaveStateInfo(lIniStorage);

  lIniStorage.Free;

end; {procedure, SaveStateInfo}

{------------------------------------------------------------------------------}
{ TdaDataManager.GetToolWindowForDataView }

function TdaDataManager.GetToolWindowForDataView(aDataView: TdaDataView): TdaDataViewToolWin;
begin

  Result := FDataViewWindows.GetWindowForDataView(aDataView);

end; {function, GetToolWindowForDataView}

{------------------------------------------------------------------------------}
{ TdaDataManager.GetDataModuleForReport }

function TdaDataManager.GetDataModuleForReport: TdaDataModule;
begin

 {create a new data module, if needed}
  if (FReport = nil) then
    Result := nil

  else if (daGetDataModule(FReport) = nil) then
    Result := TdaDataModule.CreateForReport(FReport)

  else
    Result := daGetDataModule(FReport);

end; {procedure, GetDataModuleForReport}

{------------------------------------------------------------------------------}
{ TdaDataManager.LoadStart }

procedure TdaDataManager.LoadStart;
begin

  if FDataModule = nil then Exit;

  {free the dataview windows
    - this only fires when loading subreports}
  FreeAllVisualControls;

end; {procedure, LoadStart}

{------------------------------------------------------------------------------}
{ TdaDataManager.LoadEnd }

procedure TdaDataManager.LoadEnd;
begin

  if FDataModule = nil then Exit;

  {re-build the dataview windows
    - this condition only occurs when loading subreports}
  if (FDataViewWindows.Count = 0) then
    InitializeDataViewWindows;

end; {procedure, LoadEnd}

{------------------------------------------------------------------------------}
{ TdaDataManager.SaveStart }

procedure TdaDataManager.SaveStart;
var
  liIndex: Integer;
begin

  if (FDataModule = nil) then Exit;

  for liIndex := FDataViewWindows.Count - 1 downto 0 do
    FDataViewWindows[liIndex].SaveState;

end; {procedure, SaveStart}

{------------------------------------------------------------------------------}
{ TdaDataManager.ActiveChanging }

procedure TdaDataManager.ActiveChanging(var aAllowChange: Boolean);
begin


  if (ComponentDesigner = nil) then Exit;

  if (FWorkspace = nil) then
    CreateControls;

  if Active then
    DeactivateDataWorkspace()
  else
    ActivateDataWorkspace();

end;

{------------------------------------------------------------------------------}
{ TdaDataManager.DeactivateDataWorkspace }

procedure TdaDataManager.DeactivateDataWorkspace;
var
  lDataSettings: TppDataSettings;
begin

  FMenubar.EnableItems(False);
  HideVisualControls;

  SaveStateInfo;

  if (FReportDesigner <> nil) and (FReportDesigner.DataSettings <> nil) then
    lDataSettings := TppDataSettings(FReportDesigner.DataSettings)
  else
    lDataSettings := nil;

  if (lDataSettings <> nil) and not(lDataSettings.EqualTo(FWizardManager.DataSettings)) then
    lDataSettings.Assign(FWizardManager.DataSettings);

  if (FDataModule <> nil) and (FDataModule.IsEmpty) then
    begin
      FDataModule.Free;
      SetDataModule(nil);
      ComponentDesigner.ComponentModified;
    end;

  {must do this after assigning data settings}
  if (FDataModule <> nil) and FDataModule.Modified then
    SyncDataViews;

end;

{------------------------------------------------------------------------------}
{ TdaDataManager.ActivateDataWorkspace }

procedure TdaDataManager.ActivateDataWorkspace;
var
  lDataSettings: TppDataSettings;
begin

  // menu
  FReportDesigner.MainMenu := FMenubar;
  FMenubar.EnableItems(FReport <> nil);

  // status bar
  InitializeStatusBar;

  // set datamodule
  SetDataModule(GetDataModuleForReport);

  FCurrentReport := TppCustomReport(ComponentDesigner.CurrentComponent);


  if (FReport <> nil) and not (csDesigning in FReport.ComponentState) then
    begin
      if (FReportDesigner <> nil) and (FReportDesigner.DataSettings <> nil) then
        begin
          lDataSettings := TppDataSettings(FReportDesigner.DataSettings);

          if (lDataSettings.DatabaseType = dtOther) then
            lDataSettings.DatabaseType := daDefaultDatabaseType(DataModule.Owner, lDataSettings.SessionType, lDataSettings.DatabaseName);

          FWizardManager.DataSettings := lDataSettings;

        end;

      SetAllowDataSettingsChange(FReportDesigner.AllowDataSettingsChange);
    end;


  {create dataview windows, if necessary}
  UpdateDataViewWindows;

  {workspace must have focus, otherwise any delete keystrokes will be captured by parent tabsheet}
//old      FWorkspace.SetFocus;

  ShowVisualControls;


end;

{------------------------------------------------------------------------------}
{ TdaDataManager.HideVisualControls }

procedure TdaDataManager.HideVisualControls;
var
  liIndex: Integer;
begin

  FPaintBox.Visible := False;

  for liIndex := 0 to FDataViewWindows.Count - 1 do
    FDataViewWindows[liIndex].Visible := False;

end; {procedure, HideVisualControls}

{------------------------------------------------------------------------------}
{ TdaDataManager.ShowVisualControls }

procedure TdaDataManager.ShowVisualControls;
var
  liIndex: Integer;
begin

  for liIndex := 0 to FDataViewWindows.Count - 1 do
    FDataViewWindows[liIndex].Visible := True;

  FPaintBox.Visible := True;

end; {procedure, ShowVisualControls}

{------------------------------------------------------------------------------}
{ TdaDataManager.DesignerDataSettingsChangeEvent }

procedure TdaDataManager.DesignerDataSettingsChangeEvent(Sender: TObject);
begin

  if (FReportDesigner <> nil) and (FReportDesigner.DataSettings <> nil) then
    begin
      FWizardManager.DataSettings := TppDataSettings(FReportDesigner.DataSettings);

      SetDataViewsOutOfSync;
    end;

end; {procedure, DesignerDataSettingsChangeEvent}

{------------------------------------------------------------------------------}
{ TdaDataManager.InitializeDataViewWindows }

procedure TdaDataManager.InitializeDataViewWindows;
var
  liIndex: Integer;
  lDataView: TdaCustomDataView;
  lToolWindow: TdaDataViewToolWin;
begin

  if (FDataModule = nil) then
    raise EDesignError.Create('TdaDataManager.InitializeDataViewWindows: Attempting to initialize Data Manager without data module assigned.');

  for liIndex := 0 to FDataModule.DataViewCount-1 do
    begin
      lDataView := FDataModule.DataViews[liIndex];

      lToolWindow := AddDataViewWindow(lDataView);

      {if dataview is merged then its width will be 0}
      if (lDataView.Width > 0) then
        lToolWindow.RestoreState;

    end;

  FLinkManager.InitializeVisualLinks;

  UpdateEnabledOptions;

  if (FPaintBox.Visible) then
    FPaintBox.Refresh;

end; {procedure, InitializeDataViewWindows}

{------------------------------------------------------------------------------}
{ TdaDataManager.UpdateDataViewWindows }

procedure TdaDataManager.UpdateDataViewWindows;
var
  liIndex: Integer;
  lDataView: TdaCustomDataView;
  lbUpdate: Boolean;
begin

  if (FDataModule = nil) then Exit;

  lbUpdate := False;

  for liIndex := 0 to FDataModule.DataViewCount - 1 do
    begin
      lDataView := FDataModule.DataViews[liIndex];

      if FDataViewWindows.IndexOfDataView(lDataView) < 0 then
        begin
          AddDataViewWindow(lDataView);

          lbUpdate := True;
        end;
    end;

  {update enabled options on each dataview window}
  if lbUpdate then
    UpdateEnabledOptions;

end; {procedure, UpdateDataViewWindows}

{------------------------------------------------------------------------------}
{ TdaDataManager.UpdateEnabledOptions }

procedure TdaDataManager.UpdateEnabledOptions;
var
  liIndex: Integer;
  lDataView: TdaCustomDataView;
  lToolWindow: TdaDataViewToolWin;
  lEnabledOptions: TppDataEditTypes;
  lDataViews: TList;
begin

  if (FDataViewWindows = nil) then Exit;

  lDataViews := TList.Create;
  FDataModule.GetLinkableDataViews(lDataViews);

  for liIndex := 0 to FDataViewWindows.Count - 1 do
    begin
      lToolWindow := FDataViewWindows[liIndex];

      lDataView := lToolWindow.DataView;

      if (lDataView <> nil) then
        begin
          lEnabledOptions := lDataView.EnabledOptions;

          lDataView.UpdateEnabledOptions(lDataViews);

          if (lEnabledOptions <> lDataView.EnabledOptions) then
            lToolWindow.UpdateEnabledOptions;
        end;
    end;

  lDataViews.Free;

end; {procedure, UpdateEnabledOptions}

{------------------------------------------------------------------------------}
{ TdaDataManager.AddDataViewWindow }

function TdaDataManager.AddDataViewWindow(aDataView: TdaDataView): TdaDataViewToolWin;
var
  lToolWindow: TdaDataViewToolWin;
begin

  lToolWindow := TdaDataViewToolWin.Create(FWorkSpace);
  lToolWindow.Parent := FWorkSpace;
  lToolWindow.DataView := TdaCustomDataView(aDataView);

  lToolWindow.OnDeleteDataView := DeleteDataViewEvent;
  lToolWindow.OnEditDataView := EditDataViewEvent;

  lToolWindow.OnDeleteKeyDown := FLinkManager.DataViewDeleteKeyDownEvent;
  lToolWindow.OnDeleteLink := FLinkManager.DataViewDeleteLinkEvent;
  lToolWindow.OnEndLink := FLinkManager.DataViewEndLinkEvent;
  lToolWindow.OnLinking := FLinkManager.DataViewLinkingEvent;
  lToolWindow.OnSelectField := FLinkManager.DataViewSelectFieldEvent;
  lToolWindow.OnStartLink := FLinkManager.DataViewStartLinkEvent;

  CalcWindowPosition(lToolWindow);

  lToolWindow.Visible := True;
  
  {this call must be made, otherwise the column headers are blank}
  lToolWindow.ListView.Refresh;

  FDataViewWindows.Add(lToolWindow);

  Result := lToolWindow;

end; {procedure, AddDataViewWindow}

{------------------------------------------------------------------------------}
{ TdaDataManager.CalcWindowPosition }

procedure TdaDataManager.CalcWindowPosition(aDataViewWindow: TdaDataViewToolWin);
var
  liIndex: Integer;
  lWindow: TdaDataViewToolWin;
  liRight: Integer;
  liMaxRight: Integer;
  liBottom: Integer;
  lbOpeningFound: Boolean;
  liSpace: Integer;
  lWindows: TStringList;
begin

  {set top}
  aDataViewWindow.Top := 10;


  {set window height, so that all fields are shown}
  aDataViewWindow.Height := aDataViewWindow.ShowAllFieldsHeight + 60;


  {set width}
  aDataViewWindow.Width := 224;
  {lToolWindow.Width := 274;} {old width which shows all tool buttons}


  {set left}
  lWindows := TStringList.Create;

  {build a list of the dataview windows ordered from left to right}
  for liIndex := 0 to FDataViewWindows.Count - 1 do
    begin
      lWindow := DataViewWindows[liIndex];

      lWindows.AddObject(Format('%8d', [lWindow.Left]), lWindow);
    end;

  lWindows.Sort;

  {search for a dataview windows sized space between the existing windows.}
  liMaxRight := 0;
  liRight := 0;
  lbOpeningFound := False;
  liIndex := 0;

  while not(lbOpeningFound) and (liIndex < lWindows.Count) do
    begin
      lWindow := TdaDataViewToolWin(lWindows.Objects[liIndex]);

      if (liRight <> 0) then
        begin
          liSpace := lWindow.Left - liRight;

          if (liSpace > 188) then
            lbOpeningFound := True;

        end;

      if not(lbOpeningFound) then
        begin
          liRight := lWindow.Left + lWindow.Width;

          if (liRight > liMaxRight) then
            liMaxRight := liRight;
        end;

      Inc(liIndex);
    end;

  lWindows.Free;

  if (liMaxRight = 0) then
    aDataViewWindow.Left := 10
  else
    aDataViewWindow.Left := liMaxRight + 50;

  {make sure window is within visible area}
  if (aDataViewWindow.Left >= FWorkSpace.ClientWidth) then
    aDataViewWindow.Left := FWorkSpace.ClientWidth - 25;

  liBottom := aDataViewWindow.Top + aDataViewWindow.Height;

  if (liBottom >= FWorkSpace.ClientHeight) then
    aDataViewWindow.Height := aDataViewWindow.Height - ((liBottom - FWorkSpace.ClientHeight) + 25);


end;{procedure, CalcWindowPosition}

{------------------------------------------------------------------------------}
{ TdaDataManager.SetDataViewsOutOfSync }

procedure TdaDataManager.SetDataViewsOutOfSync;
var
  liIndex: Integer;
begin
  if (FDataModule = nil) then Exit;

  for liIndex := 0 to FDataModule.DataViewCount - 1 do
    FDataModule.DataViews[liIndex].OutOfSync;

end; {procedure, SetDataViewsOutOfSync}

{------------------------------------------------------------------------------}
{ TdaDataManager.SyncDataViews }

procedure TdaDataManager.SyncDataViews;
var
  liIndex: Integer;
  lSaveCursor: TCursor;
begin

  if (FDataModule = nil) then Exit;

  lSaveCursor := Screen.Cursor;

  Screen.Cursor := crHourGlass;

  try
    for liIndex := 0 to FDataModule.DataViewCount - 1 do
      FDataModule.DataViews[liIndex].Sync;
  finally
    Screen.Cursor := lSaveCursor;
  end;

end; {procedure, SyncDataViews}

{------------------------------------------------------------------------------}
{ TdaDataManager.FreeAllVisualControls }

procedure TdaDataManager.FreeAllVisualControls;
var
  liIndex: Integer;
begin

  for liIndex := FDataViewWindows.Count - 1 downto 0 do
    FreeVisualControls(FDataViewWindows[liIndex].DataView);

end; {procedure, FreeAllVisualControls}

{------------------------------------------------------------------------------}
{ TdaDataManager.FreeVisualControls }

procedure TdaDataManager.FreeVisualControls(aDataView: TdaDataView);
var
  liIndex: Integer;
  lDataViewWindow: TdaDataViewToolWin;
begin

  liIndex := FDataViewWindows.IndexOfDataView(aDataView);

  if (liIndex <> -1) then
    begin
      {remove any links}
      FLinkManager.RemoveVisualLinksForDataView(aDataView);

      lDataViewWindow := FDataViewWindows[liIndex];

      lDataViewWindow.SaveState;

      {remove the data view window}
      FDataViewWindows.Delete(liIndex);
      lDataViewWindow.Free;
    end;

end; {procedure, FreeVisualControls}

{------------------------------------------------------------------------------}
{ TdaDataManager.DeleteDataViewEvent }

procedure TdaDataManager.DeleteDataViewEvent(Sender: TObject);
var
  lDataView: TdaDataView;
begin

  lDataView := TdaDataViewToolWin(Sender).DataView;

  {must call this before dataview is freed}
  FLinkManager.DataViewDeleted(lDataView);

  lDataView.Free;

  FDataModule.Modified := True;

  UpdateEnabledOptions;

end;  {procedure, DeleteDataViewEvent}

{------------------------------------------------------------------------------}
{ TdaDataManager.NewDataView }

procedure TdaDataManager.NewDataView;
var
  lDataView: TdaCustomDataView;
  lDataDictionary: TppDataDictionary;
begin

  if (FDataModule = nil) then
    raise EDesignError.Create('TdaDataManager.NewDataView: Attempting to create a new dataview without a data module assigned.');

  if (FReport = nil) then
    raise EDesignError.Create('TdaDataManager.NewDataView: Attempting to create a new dataview without a report assigned.');


  if FWizardManager.NewDataView(lDataView) then
    begin
      {always assign current report to dataview}
      lDataView.Report := FCurrentReport;

      AddDataViewWindow(lDataView);

      if FWizardManager.DataSettings.UseDataDictionary then
        lDataDictionary := FWizardManager.DataSettings.DataDictionary
      else
        lDataDictionary := nil;

      FLinkManager.NewDataView(lDataView, lDataDictionary);

      UpdateEnabledOptions;

      FDataModule.Modified := True;
    end;

end; {procedure, NewDataView}

{------------------------------------------------------------------------------}
{ TdaDataManager.EditDataViewEvent }

procedure TdaDataManager.EditDataViewEvent(Sender: TObject);
var
  lDataView: TdaDataView;
begin

  lDataView := TdaDataViewToolWin(Sender).DataView;

  if lDataView.EditMode = ppemPreview then
    lDataView.Preview

  else if lDataView.EditMode = ppemLink then
    FLinkManager.EditLinks(lDataView)

  else if DesignDataView(lDataView) then
    begin
      TdaDataViewToolWin(Sender).UpdateEnabledOptions;

      TdaDataViewToolWin(Sender).Refresh;

      FDataModule.Modified := True;
    end;

end;  {procedure, EditDataViewEvent}

{------------------------------------------------------------------------------}
{ TdaDataManager.DesignDataView }

function TdaDataManager.DesignDataView(aDataView: TdaDataView): Boolean;
begin

  aDataView.Active := False;

  Result := FWizardManager.DesignDataView(TdaCustomDataView(aDataView));

end;  {procedure, DesignDataView}

{------------------------------------------------------------------------------}
{ TdaDataManager.GetDefaultDescription }

function TdaDataManager.GetDefaultDescription: String;
var
  liPos: Integer;
begin

  Result := '';

  if (FDataModule = nil) or (FReport = nil) then Exit;


  Result := FDataModule.Template.Description;

  if Result = '' then
    Result := FReport.MainReport.Template.Description + ' ' + ppLoadStr(742); {Data}

  liPos := Pos('.', Result);

  if (liPos <> 0) then
    Result := Copy(Result, 1, liPos - 1);

end; {function, GetDefaultDescription}

{------------------------------------------------------------------------------}
{ TdaDataManager.ImportDataModule }

procedure TdaDataManager.ImportDataModule(aSource: TppSaveToType);
begin

  if (FDataModule = nil) then
    raise EDesignError.Create('TdaDataManager.ImportDataModule: Attempting to import a data module without a data module assigned.');


  FDataModule.Template.InitializeSettings(FReport.Template);
  FDataModule.Template.SaveTo := aSource;

  if FDataModule.Template.ShowOpenDialog then
    try
      {delete old dataview windows}
      FreeAllVisualControls;

      FDataModule.Template.Load;

      {connect report to first dataview}
      if FDataModule.DataViewCount > 0 then
        FDataModule.DataViews[0].Report := FReport;

      FDataModule.Modified := True;

    finally
      {add new data views}
      InitializeDataViewWindows;
    end;

end;  {procedure, ImportDataModule}


{------------------------------------------------------------------------------}
{ TdaDataManager.MergeDataModule }

procedure TdaDataManager.MergeDataModule(aSource: TppSaveToType);
var
  lMergeDataModule: TdaDataModule;
begin

  if (FDataModule = nil) then
    raise EDesignError.Create('TdaDataManager.MergeDataModule: Attempting to merge a data module without a data module assigned.');

  {create a temporary module}
  lMergeDataModule := TdaDataModule.Create(FDataModule.Owner);

  lMergeDataModule.Template.InitializeSettings(FReport.Template);
  lMergeDataModule.Template.SaveTo := aSource;

  if lMergeDataModule.Template.ShowOpenDialog then
    begin
      try
        begin
          {delete old dataview windows}
          FreeAllVisualControls;

          lMergeDataModule.Template.Load;

          {position new dataviews below existing dataviews}
          AdjustDataViewTops(lMergeDataModule);

          {merge with existing data module}
          FDataModule.Merge(lMergeDataModule);

          FDataModule.Modified := True;
        end;

      finally
        {add new data views}
        InitializeDataViewWindows;
      end;

    end;

  lMergeDataModule.Free;

end;  {procedure, MergeDataModule}

{------------------------------------------------------------------------------}
{ TdaDataManager.AdjustDataViewTops }

procedure TdaDataManager.AdjustDataViewTops(aMergeDataModule: TdaDataModule);
var
  liIndex: Integer;
  liBottom: Integer;
  liMaxBottom: Integer;
  liTop: Integer;
  liMinTop: Integer;
  lDataView: TdaCustomDataView;
begin

  liMaxBottom := 0;

  for liIndex := 0 to FDataModule.DataViewCount - 1 do
    begin
      lDataView := FDataModule.DataViews[liIndex];

      liBottom := lDataView.Top + lDataView.Height;

      if (liBottom > liMaxBottom) then
        liMaxBottom := liBottom;
    end;

  liMinTop := 2000;

  for liIndex := 0 to aMergeDataModule.DataViewCount - 1 do
    begin
      lDataView := aMergeDataModule.DataViews[liIndex];

      liTop := lDataView.Top;

      if (liTop < liMinTop) then
        liMinTop := liTop;
    end;


  for liIndex := 0 to aMergeDataModule.DataViewCount - 1 do
    begin
      lDataView := aMergeDataModule.DataViews[liIndex];

      lDataView.Top := (lDataView.Top - liMinTop) + liMaxBottom + 50;
    end;

end;  {procedure, AdjustDataViewTops}

{------------------------------------------------------------------------------}
{ TdaDataManager.GetDefaultSaveToType }

function TdaDataManager.GetDefaultSaveToType:TppSaveToType;
begin

  if FReport <> nil then
    Result := FReport.Template.SaveTo
  else if FDataModule <> nil then
    Result := FDataModule.Template.SaveTo
  else
    Result := stFile;

end; {procedure, GetDefaultSaveToType}



{------------------------------------------------------------------------------}
{ TdaDataManager.ExportDataModule }

procedure TdaDataManager.ExportDataModule(aTarget: TppSaveToType);
begin

  if (FDataModule = nil) then
    raise EDesignError.Create('TdaDataManager.ExportDataModule: Attempting to export a dataview without a data module assigned.');

  if (FReport = nil) then
    raise EDesignError.Create('TdaDataManager.ExportDataModule: Attempting to export a dataview without a report assigned.');


  FDataModule.Template.InitializeSettings(FReport.Template);
  FDataModule.Template.SaveTo := aTarget;

  FDataModule.Template.Description := GetDefaultDescription;

  if FDataModule.Template.ShowSaveDialog then
    begin
      if (aTarget = stFile) then
        FDataModule.Template.Format := ftASCII;

      FDataModule.Template.Save;
    end;

end; {procedure, ExportDataModule}

{------------------------------------------------------------------------------}
{ TdaDataManager.FileMenuClickEvent }

procedure TdaDataManager.FileMenuClickEvent(Sender: TObject);
var
  liIndex: Integer;
begin

  {set visibility of explicit file import and export options}
  FMenubar.FileMenu.ImportFromFile.Visible := FReportDesigner.AllowSaveToFile and (FCurrentReport.Template.SaveTo = stDataBase);

  liIndex := FMenubar.FileMenu.IndexOf(FMenubar.FileMenu.ImportFromFile);

  FMenubar.FileMenu.Items[liIndex - 1].Visible := FMenubar.FileMenu.ImportFromFile.Visible;
  FMenubar.FileMenu.Items[liIndex + 1].Visible := FMenubar.FileMenu.ImportFromFile.Visible;


end; {procedure, FileMenuClickEvent}

{------------------------------------------------------------------------------}
{ TdaDataManager.FileMenuItemClickEvent }

procedure TdaDataManager.FileMenuItemClickEvent(Sender: TObject);
begin

  case TdaFileMenuCommandType(TMenuItem(Sender).Tag) of
    fmDataSettings: DisplayDataSettingsDialog;
    fmNew: NewDataView;
    fmImport: ImportDataModule(GetDefaultSaveToType);
    fmMerge: MergeDataModule(GetDefaultSaveToType);
    fmExport: ExportDataModule(GetDefaultSaveToType);
    fmExportToFile: ExportDataModule(stFile);
    fmImportFromFile: ImportDataModule(stFile);
    fmClose:  ComponentDesigner.Perform(WM_CLOSE, 0, 0); {note: send a message, do not call close}
  end;

end; {procedure, FileMenuItemClickEvent}

{------------------------------------------------------------------------------}
{ TdaDataManager.DisplayDataSettingsDialog }

procedure TdaDataManager.DisplayDataSettingsDialog;
var
  lDataSettingsDlg: TppCustomDataSettingsDialog;
  lFormClass: TFormClass;
begin

  if (FDataModule = nil) then Exit;

  lFormClass := ppGetFormClass(TppCustomDataSettingsDialog);

  lDataSettingsDlg := TppCustomDataSettingsDialog(lFormClass.Create(Application));
  lDataSettingsDlg.DataModule := FDataModule;
  lDataSettingsDlg.LanguageIndex := FCurrentReport.LanguageIndex;
  lDataSettingsDlg.DataSettings := FWizardManager.DataSettings;

  lDataSettingsDlg.ShowModal;

  lDataSettingsDlg.Free;

end; {procedure, DisplayDataSettingsDialog}

{------------------------------------------------------------------------------}
{ TdaDataManager.SetLanguageIndex}

procedure TdaDataManager.SetLanguageIndex(aLanguageIndex: Longint);
var
  liIndex: Integer;
begin

  inherited SetLanguageIndex(aLanguageIndex);

  Caption := ppLoadStr(742); {Data}

  if (FMenuBar <> nil) then
    FMenuBar.LanguageChanged();

  {update tool windows}
  for liIndex := 0 to FDataViewWindows.Count - 1 do
    FDataViewWindows[liIndex].LanguageIndex := aLanguageIndex;

  if (FLinkManager <> nil) then
    FLinkManager.LanguageIndex := aLanguageIndex;

end; {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TdaDataManager.InitializeStatusBar}

procedure TdaDataManager.InitializeStatusBar;
begin

  StatusBar.SimplePanel := True;
  StatusBar.SimpleText  := ppLoadStr(180);

end; {procedure, InitializeStatusBar}

  
{******************************************************************************
 *
 ** D A T A V I E W   W I N D O W   L I S T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDataViewWindowList.Create }

constructor TppDataViewWindowList.Create;
begin

  inherited Create;

  FToolWindows := TList.Create;
  FDataViews := TList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDataViewWindowList.Destroy }

destructor TppDataViewWindowList.Destroy;
begin

  FToolWindows.Free;
  FDataViews.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDataViewWindowList.GetCount }

function TppDataViewWindowList.GetCount: Integer;
begin
  Result := FToolWindows.Count;
end; {function, GetCount}

{------------------------------------------------------------------------------}
{ TppDataViewWindowList.GetDataViewWindow }

function TppDataViewWindowList.GetDataViewWindow(aIndex: Integer): TdaDataViewToolWin;
begin
  Result := TdaDataViewToolWin(FToolWindows[aIndex]);
end; {function, GetDataViewWindow}

{------------------------------------------------------------------------------}
{ TppDataViewWindowList.GetWindowForDataView }

function TppDataViewWindowList.GetWindowForDataView(aDataView: TdaDataView): TdaDataViewToolWin;
var
  liIndex: Integer;
begin

  liIndex := IndexOfDataView(aDataView);

  if liIndex >= 0 then
    Result := GetDataViewWindow(liIndex)
  else
    Result := nil;

end; {function, GetWindowForDataView}

{------------------------------------------------------------------------------}
{ TppDataViewWindowList.Add }

procedure TppDataViewWindowList.Add(aDataViewToolWin: TdaDataViewToolWin);
begin
  FToolWindows.Add(aDataViewToolWin);
  FDataViews.Add(aDataViewToolWin.DataView);

end; {procedure, Add}

{------------------------------------------------------------------------------}
{ TppDataViewWindowList.Clear }

procedure TppDataViewWindowList.Clear;
begin

  FToolWindows.Clear;
  FDataViews.Clear;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppDataViewWindowList.Delete }

procedure TppDataViewWindowList.Delete(aIndex: Integer);
begin

  FToolWindows.Delete(aIndex);
  FDataViews.Delete(aIndex);

end; {procedure, Delete}

{------------------------------------------------------------------------------}
{ TppDataViewWindowList.IndexOfDataView }

function TppDataViewWindowList.IndexOfDataView(aDataView: TdaDataView): Integer;
begin
  Result := FDataViews.IndexOf(aDataView);

end; {procedure, IndexOfDataView}

{------------------------------------------------------------------------------}
{ TppDataViewWindowList.Remove }

procedure TppDataViewWindowList.Remove(aDataViewToolWin: TdaDataViewToolWin);
var
  liIndex: Integer;
begin

  liIndex := FToolWindows.Remove(aDataViewToolWin);

  FDataViews.Delete(liIndex);

end; {procedure, Remove}



{      if (lFileCommandType <> fmClose) then
        lMenuItem.Caption := ppLoadStrWithEllipses(cFileMenuCaptions[lFileCommandType])
      else
        lMenuItem.Caption := ppLoadStr(cFileMenuCaptions[lFileCommandType]);

      lMenuItem.Tag     := Ord(lFileCommandType);
      lMenuItem.OnClick := FileMenuItemClickEvent;

      if (lFileCommandType = fmDataSettings) then
        FMenuItemDataSettings := lMenuItem;

      if (lFileCommandType = fmImportFromFile) then
        FMenuItemImportFromFile := lMenuItem;

      //insert separator
      if (lFileCommandType in [fmDataSettings, fmClose, fmExport]) then
        begin
          FFileMenu.Add(lMenuItem);
          lMenuItem := TMenuItem.Create(Parent);
          lMenuItem.Caption := '-';
        end;

      FFileMenu.Add(lMenuItem);
    end;
}

{------------------------------------------------------------------------------}
{ TdaDataFileMenu.CreateControls}

procedure TdaDataFileMenu.CreateControls;
var
  lFileCommandType: TdaFileMenuCommandType;
  lMenuItem: TppTBXItem;
begin

//  TdaFileMenuCommandType = (fmDataSettings, fmNew, fmClose, fmImport, fmMerge, fmExport, fmImportFromFile, fmExportToFile);

  {create File menu and subitemitems: Open, Save, SaveAs}
  for lFileCommandType := Low(TdaFileMenuCommandType) to High(TdaFileMenuCommandType) do
    begin
      lMenuItem := AddChildItem();

      if (lFileCommandType <> fmClose) then
        lMenuItem.Caption := ppLoadStrWithEllipses(cFileMenuCaptions[lFileCommandType])
      else
        lMenuItem.Caption := ppLoadStr(cFileMenuCaptions[lFileCommandType]);

      lMenuItem.Tag     := Ord(lFileCommandType);
      lMenuItem.OnClick := ehItem_Click;

      case lFileCommandType of
        fmDataSettings: FDataSettings := lMenuItem;
        fmNew: FNew := lMenuItem;
        fmClose: FClose := lMenuItem;
        fmImport: FImport := lMenuItem;
        fmMerge: FMerge := lMenuItem;
        fmExport: FExport := lMenuItem;
        fmImportFromFile: FImportFromFile := lMenuItem;
        fmExportToFile: FExportToFile := lMenuItem;
      end;

      {insert separator}
      if (lFileCommandType in [fmDataSettings, fmClose, fmExport]) then
       AddSeparator();

    end;

  FDataSettings.ImageIndex := ToolImageList.AddIcon('PPDATASETTINGS');
  FNew.ShortCut := Menus.ShortCut(Ord('N'), [ssCtrl]); // Ctrl+N
  FNew.ImageIndex := ToolImageList.AddIcon('PPNEW');
  FImport.ImageIndex := ToolImageList.AddIcon('PPIMPORT');
  FMerge.ImageIndex := ToolImageList.AddIcon('PPMERGE');
  FExport.ImageIndex := ToolImageList.AddIcon('PPEXPORT');


end;

{------------------------------------------------------------------------------}
{ TdaDataFileMenu.ehItem_Click}

procedure TdaDataFileMenu.ehItem_Click(Sender: TObject);
begin

  if Assigned(FOnItemClick) then FOnItemClick(Sender);

end;

{------------------------------------------------------------------------------}
{ TdaDataFileMenu.LanguageChanged}

procedure TdaDataFileMenu.LanguageChanged;
begin

  Caption := ppLoadStr(131);

//  TdaFileMenuCommandType = (fmDataSettings, fmNew, fmClose, fmImport, fmMerge, fmExport, fmImportFromFile, fmExportToFile);

  FDataSettings.Caption    := ppLoadStrWithEllipses(cFileMenuCaptions[fmDataSettings]);
  FNew.Caption             := ppLoadStrWithEllipses(cFileMenuCaptions[fmNew]);
  FClose.Caption           := ppLoadStr(cFileMenuCaptions[fmClose]);

  FImport.Caption          := ppLoadStrWithEllipses(cFileMenuCaptions[fmImport]);
  FMerge.Caption           := ppLoadStrWithEllipses(cFileMenuCaptions[fmMerge]);
  FExport.Caption          := ppLoadStrWithEllipses(cFileMenuCaptions[fmExport]);

  FImportFromFile.Caption  := ppLoadStrWithEllipses(cFileMenuCaptions[fmImportFromFile]);
  FExportToFile.Caption    := ppLoadStrWithEllipses(cFileMenuCaptions[fmExportToFile]);

end;

{------------------------------------------------------------------------------}
{ TppDesignerMenu.Create}

constructor TdaDesignerMenu.Create(Owner: TComponent);
begin
  inherited;

  Name := 'DataMenu'; // do not localize

end;

{------------------------------------------------------------------------------}
{ TdaDesignerMenu.CreateItems}

procedure TdaDesignerMenu.CreateItems;
begin

  FFileMenu := TdaDataFileMenu.Create(nil);
  Items.Add(FFileMenu);

  LanguageChanged();

end;

{------------------------------------------------------------------------------}
{ TdaDesignerMenu.LanguageChanged}

procedure TdaDesignerMenu.LanguageChanged;
var
  liIndex: Integer;
begin

//  Caption := 'Data Menu Bar';

  for liIndex := 0 to Items.Count-1 do
    if (Items[liIndex] is TppSubMenuItem) then
      TppSubMenuItem(Items[liIndex]).LanguageChanged();


end;




end.
