{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppDsgner;                                                                     

interface

{$I ppIFDef.pas}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ComCtrls,
  ExtCtrls,
  Variants,

  ppTypes,
  ppClass,
  ppUtils,
  ppReport,
  ppIniStorage,

  ppDsIntf,
  ppToolbarTBX,
  ppTBX,
  ppTBXStatusBars,
  ppTBXOffice2003Theme,
  ppFormWrapper,
  ppTabbedNotebook,
  ppDesignControllers,
  ppToolResources,
  ppDesignLayoutManager,
  ppDesignPreview,
  ppDesignEventHub;

type

  TppDesignModuleActionType = (ppdmBeforePreview, ppdmAfterPreview, ppdmClose, ppdmCloseQuery,
                               ppdmSaveState, ppdmLoadState, ppdmLoadStart, ppdmLoadEnd, ppdmSaveStart,
                               ppdmLanguageChange);

  {TppDesignerWindow }
  TppDesignerWindow = class(TppComponentDesigner)
  private
    FAllowDataSettingsChange: Boolean;
    FAllowSaveToFile: Boolean;
    FBeforeDestroy: TNotifyEvent;
    FComponentList: TppDesignerSelectionList;
    FDataSettings: TPersistent;
    FDefaultCaption: String;
    FDesignModules: TppDesignModuleCollection;
    FDesignTime: Boolean;
    FEventHub: TppDesignEventHub;
    FFreeOnClose: Boolean;
    FLastActivePage: TPage;
    FLayoutManager: TppDesignLayoutManager;
    FMainMenu: TppMenuBar;
    FMenuDock: TppDock;
    FNotebook: TppTabbedNotebook;
    FOnRapInterfaceChange: TNotifyEvent;
    FPreviewManager: TppDesignPreviewManager;
    FRAPInterface: TppRAPInterfaceOptions;
    FRAPOptions: TppRAPOptions;
    FReport: TppReport;
    FStatusBar: TppTBXStatusBar;

    procedure FreeDesignModules;
    function GetComponentClasses: TStrings;
    function GetCurrentReport: TppCustomReport;
    function GetDesignControllers: TppDesignControllers;
    function GetDesignModuleForPage(aPageIndex: Integer): TppDesignModule; overload;
    function GetDesignModuleForPage(aPage: TPage): TppDesignModule; overload;
    function GetDesignPageIndex: Integer;
    function GetLiveData: Boolean;
    function GetPageIndexForDesignModule(aDesignModule: TppDesignModule): Integer;
    function GetPreviewPageIndex: Integer;
    procedure InternalClose;
    function InternalCloseQuery: Boolean;
    function NotifyDesignModules(aAction: TppDesignModuleActionType): Boolean;
    procedure SetComponentClasses(aComponentClasses: TStrings);
    procedure SetCurrentReport(aReport: TppCustomReport);
    procedure SetLiveData(const Value: Boolean);
    procedure SetMainMenu(const Value: TppMenuBar);
    procedure SetRAPInterface(aInterfaceOptions: TppRAPInterfaceOptions);
    procedure SetRAPOptions(aRAPOptions: TppRAPOptions);

  protected
    procedure CreateControls;
    procedure CreateDesignModules; virtual;
    procedure ehLayoutManager_Help(Sender, aParameters: TObject); virtual;
    procedure ehLayoutManager_LanguageChange(Sender, aParameters: TObject);
    procedure ehReport_LoadEnd(Sender, aParameters: TObject);
    procedure ehLayoutManager_Preview(Sender, aParameters: TObject); virtual;
    procedure ehLayoutManager_SelectionAfterChanged(Sender, aParameters: TObject); virtual;
    procedure ehLayoutManager_UpdateWindowCaption(Sender, aParameters: TObject); virtual;
    procedure ehNotebook_OnTabChanged(Sender: TObject); virtual;
    procedure ehNotebook_OnTabChanging(Sender: TObject; aTabIndex: Integer; var aAllowChange: Boolean); virtual;
    procedure ehReport_BeginUpdate(Sender, aParameters: TObject); virtual;
    procedure ehReport_EndUpdate(Sender, aParameters: TObject); virtual;
    procedure ehReport_SaveStart(Sender, aParameters: TObject);
    function GetCurrentComponent: TComponent; override;
    function GetStatusBar: TppTBXStatusBar; override;
    procedure SetComponent(aComponent: TComponent); override;
    procedure SetCurrentComponent(aComponent: TComponent); override;
    procedure SetDefaultCaption(aCaption: String); virtual;
    procedure SetObjectInspectorToSelection;  //Delphi design-time support
    procedure SetPageActive(aPage: TPage; aActive: Boolean; var aAllowChange: Boolean); virtual;
    procedure SetReport(aReport: TppReport); virtual;
    procedure UpdateWindowCaption;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    

    procedure SelectionChanged(aSelection: TppDesignerSelectionList); override; //Delphi design-time support

    procedure ChangeFormStyle(aFormStyle: TFormStyle);
    function CloseQuery: Boolean; override;
    procedure LoadStateInfo;
    procedure Notification(aComponent: TComponent; Operation: TOperation); override;
    procedure SaveStateInfo;
    procedure SetTabsVisible(aVisible: Boolean);

    property AllowDataSettingsChange: Boolean read FAllowDataSettingsChange write FAllowDataSettingsChange default False;
    property AllowSaveToFile: Boolean read FAllowSaveToFile write FAllowSaveToFile default True;
    property ComponentClasses: TStrings read GetComponentClasses write SetComponentClasses;
    property CurrentReport: TppCustomReport read GetCurrentReport write SetCurrentReport;
    property DataSettings: TPersistent read FDataSettings write FDataSettings;
    property DefaultCaption: String read FDefaultCaption write SetDefaultCaption;
    property DesignControllers: TppDesignControllers read GetDesignControllers;
    property DesignModules: TppDesignModuleCollection read FDesignModules;
    property DesignPageIndex: Integer read GetDesignPageIndex;
    property EventHub: TppDesignEventHub read FEventHub;
    property LayoutManager: TppDesignLayoutManager read FLayoutManager;
    property LiveData: Boolean read GetLiveData write SetLiveData;
    property MainMenu: TppMenuBar read FMainMenu write SetMainMenu;
    property MenuDock: TppDock read FMenuDock;
    property Notebook: TppTabbedNotebook read FNotebook;
    property PreviewManager: TppDesignPreviewManager read FPreviewManager;
    property PreviewPageIndex: Integer read GetPreviewPageIndex;
    property RAPInterface: TppRAPInterfaceOptions read FRAPInterface write SetRAPInterface default cAllRAPInterfaceOptions;
    property RAPOptions: TppRAPOptions read FRAPOptions write SetRAPOptions default cAllRAPOptions;
    property Report: TppReport read FReport write SetReport;
    property StatusBar: TppTBXStatusBar read FStatusBar;

    // events
    property BeforeDestroy: TNotifyEvent read FBeforeDestroy write FBeforeDestroy;
    property OnRapInterfaceChange: TNotifyEvent read FOnRapInterfaceChange write FOnRapInterfaceChange;
  end;

var
  ppDesignerWindowTBX: TppDesignerWindow;

implementation

{$R *.dfm}

{------------------------------------------------------------------------------}
{ TppDesignerWindow.Create }

constructor TppDesignerWindow.Create(aOwner: TComponent);
begin

  inherited;

  FDefaultCaption := 'ReportBuilder';

  FDesignTime := ppUtils.gbDesignTime;

  FAllowDataSettingsChange := False;
  FAllowSaveToFile := True;
  
  FRAPInterface := cAllRAPInterfaceOptions;
  FRAPOptions   := cAllRAPOptions;

  CreateControls();

  LoadStateInfo();

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.Destroy }

destructor TppDesignerWindow.Destroy;
begin

  if Assigned(FBeforeDestroy) then FBeforeDestroy(Self);

  SetReport(nil);

  FDataSettings := nil;

  FreeDesignModules;

  FComponentList.Free;
  FComponentList := nil;

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ ChangeFormStyle}

procedure TppDesignerWindow.ChangeFormStyle(aFormStyle: TFormStyle);
begin

  FormStyle := aFormStyle;

end; {procedure, ChangeFormStyle}

{------------------------------------------------------------------------------}
{ CloseQuery}

function TppDesignerWindow.CloseQuery: Boolean;
begin

  Result := InternalCloseQuery;

  if Result then
    Result := inherited CloseQuery;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.CreateControls }

procedure TppDesignerWindow.CreateControls;
var
  lbAllowChange: Boolean;
begin

  // create event hub
  FEventHub := TppDesignEventHub.Create(Self);

  // status bar = align bottom
  FStatusBar := TppTBXStatusBar.Create(Self);
  FStatusBar.Parent := Self;
  FStatusBar.Panels.Add;
  FStatusBar.Panels.Add;
  FStatusBar.Panels.Add;
  FStatusBar.Panels.Add;

  // menu dock
  FMenuDock := TppDock.Create(Self);
  FMenuDock.Parent := Self;
  FMenuDock.Align := alTop;
  FMenuDock.Height := 100;

  // notebook
  FNotebook := TppTabbedNotebook.Create(Self);
  FNotebook.Initialize(Self);
  FNotebook.Images := ToolImageList;

  // design modules: data, calc, design, preview
  CreateDesignModules();

  // design event hub
  FEventHub.EndUserEvents.mcPreview.AddNotify(ehLayoutManager_Preview);
  FEventHub.EndUserEvents.mcHelp.AddNotify(ehLayoutManager_Help);
  FEventHub.EndUserEvents.mcUpdateWindowCaption.AddNotify(ehLayoutManager_UpdateWindowCaption);
  FEventHub.ReportEvents.mcBeginUpdate.AddNotify(ehReport_BeginUpdate);
  FEventHub.ReportEvents.mcEndUpdate.AddNotify(ehReport_EndUpdate);
  FEventHub.ReportEvents.mcLoadEnd.AddNotify(ehReport_LoadEnd);
  FEventHub.ReportEvents.mcSaveStart.AddNotify(ehReport_SaveStart);
  FEventHub.ReportEvents.mcNameChange.AddNotify(ehLayoutManager_UpdateWindowCaption);
  FEventHub.ReportEvents.mcLanguageChange.AddNotify(ehLayoutManager_LanguageChange);
  FEventHub.SelectionEvents.mcAfterChange.AddNotify(ehLayoutManager_SelectionAfterChanged);

  // set design page active - this code assumes that there is always at least
  // the Design and Preview pages.
  if (FNoteBook.PageCount >= 2) then
    begin
      FNotebook.ActivePageIndex := PreviewPageIndex;
      FNotebook.ActivePageIndex := DesignPageIndex;  // make sure that the page will be visible.
      SetPageActive(FNotebook.ActivePage, True, lbAllowChange);
      FLastActivePage := FNotebook.ActivePage;
      GetDesignModuleForPage(FNotebook.ActivePage).Active := True; // make sure page is Active
    end;

  FNotebook.OnTabChanging  := ehNotebook_OnTabChanging;
  FNotebook.OnTabChanged := ehNotebook_OnTabChanged;


end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.CreateDesignModules }

procedure TppDesignerWindow.CreateDesignModules;
var
  lClassList: TList;
  lTabOrder: TStringList;
  lPage : TPage;
  lDesignModule: TppDesignModule;
  liIndex: Integer;
begin

  FDesignModules := TppDesignModuleCollection.Create;

  lClassList := TList.Create;
  lTabOrder := TStringList.Create;
  lTabOrder.Sorted := True;

  ppGetDesignModuleClasses('TppDesignerWindow', lClassList);

  for liIndex := 0 to lClassList.Count-1 do
    begin

      lPage := FNotebook.AddPage('');
      lDesignModule := TppDesignModuleClass(lClassList[liIndex]).CreateModule(lPage, Self);
//      lDesignModule.Component := FReport;

      FNotebook.SetPageCaption(liIndex, lDesignModule.Caption);
      FNotebook.SetPageImageIndex(liIndex, ToolImageList.AddTool(UpperCase('pp' + lDesignModule.Name)));

      lPage.Tag := LongInt(lDesignModule);

      FDesignModules.Add(lDesignModule);

      lTabOrder.AddObject(IntToStr(lDesignModule.OrderIndex), lPage);

    end;

   {reposition tabs based upon order}
   for liIndex := lTabOrder.Count-1 downto 0  do
     begin
       lPage :=  TPage(lTabOrder.Objects[liIndex]);
       FNoteBook.SetPageIndex(lPage, liIndex);
     end;


  lClassList.Free;
  lTabOrder.Free;

  FLayoutManager := TppDesignLayoutManager(FDesignModules.ItemsByName['Design']);
  FLayoutManager.EventHub := FEventHub;

//  if FDesignTime then
//    FLayoutManager.ToolManager.Menubar.FileMenu.Save.ShortCut := '';


  FPreviewManager := TppDesignPreviewManager(FDesignModules.ItemsByName['Preview']);


end; {procedure, CreateDesignModules}


{------------------------------------------------------------------------------}
{ TppDesignerWindow.ehLayoutManager_Help }

procedure TppDesignerWindow.ehLayoutManager_Help(Sender, aParameters: TObject);
var
  lEventParams: TppHelpEventParams;
  lsHelpFile: String;
  lsKeyPhrase: String;
  lbCallHelp: Boolean;
begin

  lEventParams := TppHelpEventParams(aParameters);

  lsHelpFile := lEventParams.HelpFile;
  lsKeyPhrase := lEventParams.KeyPhrase;
  lbCallHelp := lEventParams.CallHelp;

  DoOnHelp(Sender, lsHelpFile, lsKeyPhrase, lbCallHelp);

  lEventParams.HelpFile := lsHelpFile;
  lEventParams.KeyPhrase := lsKeyPhrase;
  lEventParams.CallHelp := lbCallHelp;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.ehLayoutManager_LanguageChange }

procedure TppDesignerWindow.ehLayoutManager_LanguageChange(Sender, aParameters:  TObject);
var
  liIndex: Integer;
begin

  // notify design modules
  NotifyDesignModules(ppdmLanguageChange);

  // update notebook page captions
  for liIndex := 0 to FNotebook.PageCount-1 do
    FNotebook.SetPageCaption(liIndex, GetDesignModuleForPage(liIndex).Caption);

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.ehLayoutManager_LoadEnd }

procedure TppDesignerWindow.ehReport_LoadEnd(Sender, aParameters: TObject);
var
  liDesignPage: Integer;
begin

  if (Report = nil) or (pppcDesignPreviewing in Report.DesignState) then Exit;

  UpdateWindowCaption;

  liDesignPage := GetDesignPageIndex();

  // set design page active
  if (aParameters = Report) and (FNoteBook.ActivePageIndex <> liDesignPage) then
    FNotebook.ActivePageIndex := liDesignPage;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.ehLayoutManager_Preview }

procedure TppDesignerWindow.ehLayoutManager_Preview(Sender, aParameters: TObject);
begin

  // select the preview page
  FNotebook.ActivePageIndex := GetPreviewPageIndex();

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.ehLayoutManager_SelectionAfterChanged }

procedure TppDesignerWindow.ehLayoutManager_SelectionAfterChanged(Sender, aParameters: TObject);
begin

  if not(FLayoutManager.Selection.IsUpdating) then
    SetObjectInspectorToSelection();

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.ehLayoutManager_UpdateWindowCaption }

procedure TppDesignerWindow.ehLayoutManager_UpdateWindowCaption(Sender, aParameters: TObject);
begin

  UpdateWindowCaption();

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.ehNotebook_OnTabChanged }

procedure TppDesignerWindow.ehNotebook_OnTabChanged(Sender: TObject);
var
  lDesignModule: TppDesignModule;
begin

  lDesignModule := GetDesignModuleForPage(FNotebook.ActivePage);

  {set design module active}
  if (lDesignModule <> nil) then
    lDesignModule.Active := True;

  {fire event }
  if (EventHub <> nil) then
    EventHub.EndUserEvents.mcTabChanged.Notify(FNotebook, nil);

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.ehNotebook_OnTabChange }

procedure TppDesignerWindow.ehNotebook_OnTabChanging(Sender: TObject; aTabIndex: Integer; var aAllowChange: Boolean);
var
  lDesignModule: TppDesignModule;
begin

  if (csDestroying in ComponentState) then Exit;

  // deactivate the current page
  SetPageActive(FNotebook.ActivePage, False, aAllowChange);

  // activate the selected page
  if aAllowChange then
    begin
      SetPageActive(FNotebook.Pages[aTabIndex], True, aAllowChange);

      // re-active current page
      if not(aAllowChange) then
        begin
          SetPageActive(FNotebook.ActivePage, True, aAllowChange);

          aAllowChange := False;

          lDesignModule := GetDesignModuleForPage(FNotebook.ActivePage);

          {set design module active
             - required because in this case, ehNotebook_OnTabChanged will not fire}
          if (lDesignModule <> nil) then
            lDesignModule.Active := True;

        end;

    end;


end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.ehReport_BeginUpdate }

procedure TppDesignerWindow.ehReport_BeginUpdate(Sender, aParameters: TObject);
begin

  SetCurrentReport(nil);

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.ehReport_EndUpdate }

procedure TppDesignerWindow.ehReport_EndUpdate(Sender, aParameters: TObject);
begin

  SetCurrentReport(TppCustomReport(aParameters));

  UpdateWindowCaption;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.ehReport_SaveStart }

procedure TppDesignerWindow.ehReport_SaveStart(Sender, aParameters: TObject);
begin

  NotifyDesignModules(ppdmSaveStart);

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.FreeDesignModules }

procedure TppDesignerWindow.FreeDesignModules;
var
  liPage: Integer;
  lDesignModule: TppDesignModule;
begin

//  if (csDestroying in ComponentState) then Exit;

  for liPage := FNotebook.PageCount-1 downto 0  do
   begin
     lDesignModule := GetDesignModuleForPage(liPage);

     if (lDesignModule <> nil) then
       lDesignModule.Free;

     FNotebook.Pages[liPage].Free;

   end;

  FDesignModules.Free;
  FDesignModules := nil;

end; {procedure, FreeDesignModules}

{------------------------------------------------------------------------------}
{TppDesignerWindow.GetComponentClasses }

function TppDesignerWindow.GetComponentClasses: TStrings;
begin
  if (FLayoutManager <> nil) and (FLayoutManager.ToolManager <> nil) then
    Result := FLayoutManager.ToolManager.ComponentPalette.ComponentClasses
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.GetCurrentComponent}

function TppDesignerWindow.GetCurrentComponent: TComponent;
begin

  Result := GetCurrentReport;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.GetCurrentReport}

function TppDesignerWindow.GetCurrentReport: TppCustomReport;
begin

  if (FLayoutManager <> nil) and (FLayoutManager.Selection <> nil) then
    Result := FLayoutManager.Selection.Report
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.GetDesignControllers }

function TppDesignerWindow.GetDesignControllers: TppDesignControllers;
begin

  Result := LayoutManager.DesignControllers;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.GetDesignModuleForPage }

function TppDesignerWindow.GetDesignModuleForPage(aPageIndex: Integer): TppDesignModule;
begin

  Result := GetDesignModuleForPage(FNotebook.Pages[aPageIndex]);

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.GetDesignModuleForPage }

function TppDesignerWindow.GetDesignModuleForPage(aPage: TPage): TppDesignModule;
begin
  if aPage.Tag = 0 then
    Result := nil
  else
    Result := TppDesignModule(aPage.Tag);

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.GetDesignPageIndex }

function TppDesignerWindow.GetDesignPageIndex: Integer;
begin
  Result := GetPageIndexForDesignModule(FLayoutManager);
end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.GetLiveData }

function TppDesignerWindow.GetLiveData: Boolean;
begin

  Result := FLayoutManager.WorkspaceView.LiveData;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.GetPageIndexForDesignModule }

function TppDesignerWindow.GetPageIndexForDesignModule(aDesignModule: TppDesignModule): Integer;
begin
  Result := FNotebook.IndexOfPage(TPage(aDesignModule.Parent));
end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.GetPreviewPageIndex }

function TppDesignerWindow.GetPreviewPageIndex: Integer;
begin
  Result := GetPageIndexForDesignModule(FPreviewManager);
end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.GetStatusBar }

function TppDesignerWindow.GetStatusBar: TppTBXStatusBar;
begin

 Result := FStatusBar;

end;  

{------------------------------------------------------------------------------}
{ InternalClose}

procedure TppDesignerWindow.InternalClose;
var
  liDesignPage: Integer;
begin

  SaveStateInfo;

  NotifyDesignModules(ppdmClose);

  liDesignPage := GetDesignPageIndex();

  // prior to closing, activate the design page
  if (FNotebook.ActivePageIndex <> liDesignPage) then
    FNotebook.ActivePageIndex := liDesignPage;

  if (FReport <> nil) then
    FReport.CloseDataPipelines;

  if FDesignTime and FFreeOnClose then
    Release;

end; {procedure, InternalClose}

{------------------------------------------------------------------------------}
{ InternalCloseQuery}

function TppDesignerWindow.InternalCloseQuery: Boolean;
begin

  Result := True;

  if (FReport = nil) then Exit;

  if Report.Printing then
    Result := False

  // if Preview page is selected, then select the Design page this will cancel
  // the preview and restore the report state prior to saving
  else if (FNotebook.ActivePageIndex = PreviewPageIndex) then   //  Preview
     FNotebook.ActivePageIndex := DesignPageIndex;   // select Design page

  if not Result then Exit;

  // notify design modules
  Result := NotifyDesignModules(ppdmCloseQuery);

  if Result then
    Result := DesignControllers.DocumentController.CloseQuery;

  if Result then
    InternalClose;


end; {function, InternalCloseQuery}

{------------------------------------------------------------------------------}
{ TppDesignerWindow.LoadStateInfo }

procedure TppDesignerWindow.LoadStateInfo;
var
  lIniStorage: TppIniStorage;
  lScreenRes: TPoint;
  liLeft: Integer;
  liTop: Integer;
  liWidth: Integer;
  liHeight: Integer;
  liWindowState: Integer;
begin

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  {set initial size based on screen res}
  lScreenRes := ppGetScreenRes;

  {calc default screen size }

  {set size based on 1024 x 768 }
  liWidth  := 790;
  liHeight := 600;

  if lScreenRes.X <> 1024 then
    begin
      liWidth  := (liWidth  * lScreenRes.X)  div 1024;
      liHeight := (liHeight * lScreenRes.Y) div 768;
    end;

  {default to center of screen}
  liLeft := (Screen.Width  - liWidth)  div 2;
  liTop  := (Screen.Height - liHeight) div 2;


  if FDesignTime then
    FFreeOnClose := lIniStorage.ReadBool('Designer Preferences', 'FreeOnClose', True);

  liWindowState := lIniStorage.ReadInteger('Designer Position', 'WindowState', Ord(WindowState));

  if TWindowState(liWindowState) = wsNormal then
    begin

      {load positions from ini file}
      liLeft   := lIniStorage.ReadInteger('Designer Position', 'Left',   liLeft);
      liTop    := lIniStorage.ReadInteger('Designer Position', 'Top',    liTop);
      liWidth  := lIniStorage.ReadInteger('Designer Position', 'Width',  liWidth);
      liHeight := lIniStorage.ReadInteger('Designer Position', 'Height', liHeight);

      // adjust for work area, as needed
      if (liLeft < Screen.WorkAreaLeft) then
        liLeft := Screen.WorkAreaLeft;

      if (liTop < Screen.WorkAreaTop) then
        liTop := Screen.WorkAreaTop;

      if (liWidth > Screen.WorkAreaWidth) then
        liWidth := Screen.WorkAreaWidth;

      if (liHeight > Screen.WorkAreaHeight) then
        liHeight := Screen.WorkAreaHeight;

    end;

  SetBounds(liLeft, liTop, liWidth, liHeight);

  if TWindowState(liWindowState) <> wsMinimized then
    WindowState :=  TWindowState(liWindowState);

  lIniStorage.Free;

end;

{------------------------------------------------------------------------------}
{ TppComponentDesigner.Notification}

procedure TppDesignerWindow.Notification(aComponent: TComponent; Operation: TOperation);
begin

  if (aComponent = FReport) and (Operation = opRemove) then
    SetReport(nil);

  inherited;

end; {procedure, Notification}

{------------------------------------------------------------------------------}
{ TppDesignerWindow.NotifyDesignModules }

function TppDesignerWindow.NotifyDesignModules(aAction: TppDesignModuleActionType): Boolean;
var
  liIndex: Integer;
  lDesignModule: TppDesignModule;
begin

  Result := True;

  if (FDesignModules = nil) then Exit;

  for liIndex := 0 to FDesignModules.Count-1 do
    begin

      lDesignModule := FDesignModules[liIndex];

      if (lDesignModule = nil) then Continue;

      case aAction of
//        ppdmBeforePreview: lDesignModule.BeforePreview;

//        ppdmAfterPreview:  lDesignModule.AfterPreview;

//        ppdmClose: lDesignModule.Close;

        ppdmLanguageChange:
          if (FReport <> nil) then
            lDesignModule.LanguageIndex := Ord(FReport.LanguageIndex);

        ppdmLoadStart: lDesignModule.LoadStart;

        ppdmLoadEnd: lDesignModule.LoadEnd;

        ppdmCloseQuery: lDesignModule.CloseQuery(Result);

//        ppdmLoadState: lDesignModule.LoadStateInfo;    no longer used

        ppdmSaveState: lDesignModule.SaveStateInfo;

        ppdmSaveStart: lDesignModule.SaveStart;

      end;

      if not Result then Exit;

    end;

end; 


{------------------------------------------------------------------------------}
{ TppDesignerWindow.SaveStateInfo }

procedure TppDesignerWindow.SaveStateInfo;
var
  lIniStorage: TppIniStorage;
begin

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  if FDesignTime then
    lIniStorage.WriteBool('Designer Preferences', 'FreeOnClose', FFreeOnClose);

  lIniStorage.WriteInteger('Designer Position', 'WindowState', Ord(WindowState));

  lIniStorage.WriteInteger('Designer Position', 'Left',   Left);
  lIniStorage.WriteInteger('Designer Position', 'Top',    Top);
  lIniStorage.WriteInteger('Designer Position', 'Width',  Width);
  lIniStorage.WriteInteger('Designer Position', 'Height', Height);


  lIniStorage.Free;

  NotifyDesignModules(ppdmSaveState);

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SelectionChanged }

procedure TppDesignerWindow.SelectionChanged(aSelection: TppDesignerSelectionList);
begin

  if (csDestroying in ComponentState) or (CurrentReport = nil) then Exit;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  {note: if dUpdating then no need to notify Object Inspector,
         because the Object Inspector initiated the change (prevents a stack fault)}
  if (FLayoutManager = nil) or (FLayoutManager.Selection.IsUpdating) then Exit;

  if not(Self.Visible) then Exit;

//TODO?  if (dsDeleting in FDesignerState) then Exit;

//TODO?      Include(FDesignerState, dsSelectionChanged);

  FLayoutManager.Selection.SetSelection(aSelection);

//TODO?      Exclude(FDesignerState, dsSelectionChanged);

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SetComponent }

procedure TppDesignerWindow.SetComponent(aComponent: TComponent);
var
  lReport: TppReport;
begin

  inherited SetComponent(aComponent);

  if (aComponent <> nil) and not(aComponent is TppReport) then
    raise EReportBuilderError.Create('TppDesignerWindow.SetComponent: Component is not of type TppReport');

  lReport := TppReport(aComponent);

  SetReport(lReport);

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SetComponentClasses }

procedure TppDesignerWindow.SetComponentClasses(aComponentClasses: TStrings);
begin

  if (FLayoutManager <> nil) then
    FLayoutManager.ToolManager.ComponentPalette.ComponentClasses := aComponentClasses;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SetCurrentComponent}

procedure TppDesignerWindow.SetCurrentComponent(aComponent: TComponent);
begin

  if (aComponent is TppCustomReport) then
    SetCurrentReport(TppCustomReport(aComponent));

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SetCurrentReport}

procedure TppDesignerWindow.SetCurrentReport(aReport: TppCustomReport);
begin

  if (FLayoutManager <> nil) and (FLayoutManager.Selection <> nil) then
    FLayoutManager.Selection.Report := aReport;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SetDefaultCaption }

procedure TppDesignerWindow.SetDefaultCaption(aCaption: String);
begin

  FDefaultCaption := aCaption;

  UpdateWindowCaption;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SetLiveData }

procedure TppDesignerWindow.SetLiveData(const Value: Boolean);
begin

  if ((FLayoutManager <> nil) and (FLayoutManager.WorkspaceView <> nil)) then
    FLayoutManager.WorkspaceView.LiveData := Value;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SetMainMenu }

procedure TppDesignerWindow.SetMainMenu(const Value: TppMenuBar);
begin

  if FMainMenu <> Value then
    begin
      FMenuDock.BeginUpdate();

      try
        if (FMainMenu <> nil) then
          FMainMenu.Visible := False;

        FMainMenu := Value;

        if (FMainMenu <> nil) then
          begin
            if (FMainMenu.CurrentDock = nil) then
              FMainMenu.CurrentDock := FMenuDock;
            FMainMenu.Visible := True;
          end;
          
      finally
        FMenuDock.EndUpdate();

      end;

    end;
    
end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SetObjectInspectorToSelection }

procedure TppDesignerWindow.SetObjectInspectorToSelection;
begin

  if (csDestroying in ComponentState) or (CurrentReport = nil) or (Report = nil) then Exit;

  {note: if Updating then no need to notify Object Inspector,
         because the Object Inspector initiated the change (prevents a stack fault)}
  if (FLayoutManager = nil) or (FLayoutManager.Selection.IsUpdating) then Exit;

  FComponentList.Free;

  FComponentList := FLayoutManager.Selection.ToDesignerSelection;

  {call TDesignWindow.SetSelection method to notify Object Inspector}
  DoOnSetSelection(FComponentList);

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SetPageActive }

procedure TppDesignerWindow.SetPageActive(aPage: TPage; aActive: Boolean; var aAllowChange: Boolean);
var
  lDesignModule: TppDesignModule;
  lEventParams: TppTabChangeEventParams;
begin

  aAllowChange := True;

  {notify the active design module of the change}
  lDesignModule := GetDesignModuleForPage(aPage);

  if ((lDesignModule <> nil) and (lDesignModule.Active = aActive)) then Exit;

  {fire event }
  if aActive and (EventHub <> nil) then
    begin
      lEventParams := TppTabChangeEventParams.Create;
      lEventParams.TabIndex := FNotebook.IndexOfPage(aPage);
      lEventParams.AllowChange := True;
      if (EventHub <> nil) then
        EventHub.EndUserEvents.mcTabChange.Notify(FNotebook, lEventParams);
      aAllowChange := lEventParams.AllowChange;

      lEventParams.Free;
    end;

  if not aAllowChange then Exit;

  if (lDesignModule <> nil) then
    begin
      lDesignModule.ActiveChanging(aAllowChange);

      // set DesignModule.Active to false here, the Notebook.OnTabChanged event
      // handles the true case
      if aAllowChange and (aActive = False) then
        lDesignModule.Active := False;

    end;


end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SetRAPInterface }

procedure TppDesignerWindow.SetRAPInterface(aInterfaceOptions: TppRAPInterfaceOptions);
begin

  FRAPInterface := aInterfaceOptions;
  
  if Assigned(FOnRapInterfaceChange) then FOnRapInterfaceChange(Self);

end; {procedure, SetRAPInterface}

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SetRAPOptions }

procedure TppDesignerWindow.SetRAPOptions(aRAPOptions: TppRAPOptions);
begin
  FRAPOptions := aRAPOptions;

  if Assigned(FOnRapInterfaceChange) then FOnRapInterfaceChange(Self);

end; {procedure, SetRAPInterface}

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SetReport }

procedure TppDesignerWindow.SetReport(aReport: TppReport);
var
  liIndex: Integer;
begin

  if (FReport <> nil) then
    begin
      FReport.ReportDesigner := nil;
      FReport.RemoveFreeNotification(Self);
    end;

  FReport := aReport;

  if (FReport <> nil) then
    begin
      FReport.ReportDesigner := Self;
      FReport.FreeNotification(Self);
    end;

  // assign report to design modules
  for liIndex := 0 to FDesignModules.Count-1 do
    FDesignModules[liIndex].Component := aReport;


  UpdateWindowCaption;

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.SetTabsVisible }

procedure TppDesignerWindow.SetTabsVisible(aVisible: Boolean);
begin

  FNotebook.SetTabsVisible(aVisible);

end;

{------------------------------------------------------------------------------}
{ TppDesignerWindow.UpdateWindowCaption }

procedure TppDesignerWindow.UpdateWindowCaption;
var
  lsCaption: String;
begin

  if (FReport <> GetCurrentReport) then Exit;

//  if (dsSavingReportState in FDesignerState) or (dsRestoringReportState in FDesignerState) then Exit;

  {update window caption, if report name changed}
  if (FReport = nil) then
    Caption := FDefaultCaption
  else
    begin

      lsCaption := FDefaultCaption;

      if (csDesigning in FReport.ComponentState) then
        lsCaption := lsCaption + ' - ' + FReport.Name;

      if FReport.SaveAsTemplate then
        begin
          lsCaption := lsCaption + ': ' + FReport.Template.Description;

          if (FReport.Template.SaveTo = stFile) and (FReport.Template.ReadOnly) then
            lsCaption := lsCaption + ' ' + ppLoadStr(685); {'[Read Only]'}

        end;

      if lsCaption <> Caption then
        Caption := lsCaption;
        
    end;


end;

initialization

  TppResourceManager.RegisterFileName('rbIDE');

  RegisterClass(TppDesignerWindow);

finalization

  TppResourceManager.UnRegisterFileName('rbIDE');

  UnRegisterClass(TppDesignerWindow);

end.
