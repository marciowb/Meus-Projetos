{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignLayoutMenu;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Menus,
  Forms,
  Clipbrd,
  Printers,

  ppTB2Item,
  ppTB2Toolbar,
  ppTB2Dock,

  ppTBX,
  ppTBXExtItems,

  ppCollectionBase,
  ppTypes,
  ppUtils,
  ppClass,
  ppBands,
  ppReport,
  ppWizard,

  ppToolbarTBX,
  ppDesignToolbar,
  ppPopupMenuBase,
  ppToolResources,
  ppDesignWorkspaceView,
  ppDesignControllers,
  ppDesignDocumentController,
  ppDesignDialogController,
  ppDesignSelectionController,
  ppDesignWorkspaceController,
  ppIniStorage,
  ppTmplat,
  Controls;

type

  
  {TppDesignSubMenuItem}
  TppDesignSubMenuItem = class(TppSubMenuItem)
  private
    FDesignControllers: TppDesignControllers;
    FDialogController: TppDesignDialogController;
    FDocumentController: TppDesignDocumentController;
    FSelectionController: TppDesignSelectionController;
    FWorkspaceController: TppDesignWorkspaceController;
  protected
    procedure DoPopup(Sender: TppTBCustomItem; FromLink: Boolean); override;
    procedure SetDesignControllers(const Value: TppDesignControllers); virtual;
    procedure UpdateStatus(aReport: TppBandedReport); virtual;
    property DialogController: TppDesignDialogController read FDialogController;
    property DocumentController: TppDesignDocumentController read FDocumentController;
    property SelectionController: TppDesignSelectionController read FSelectionController;
    property WorkspaceController: TppDesignWorkspaceController read FWorkspaceController;
  public
    property DesignControllers: TppDesignControllers read FDesignControllers write SetDesignControllers;
  end;


  {TppMRUList}
  TppMRUList = class(TppTBXMRUList)
  private
    FTemplateItems: TppMRUTemplateItemCollection;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure AddTemplateItem(aTemplate: TppTemplate); overload;
    procedure AddTemplateItem(aTemplateItem: TppMRUTemplateItem); overload;

    procedure LoadPreferences(aIniStorage: TppIniStorage);
    procedure SavePreferences(aIniStorage: TppIniStorage);

    property TemplateItems: TppMRUTemplateItemCollection read FTemplateItems;

  end;


  {TppDesignFileMenu}
  TppDesignFileMenu = class(TppDesignSubMenuItem)
  private
    FClose: TppTBXItem;
    FLoadFromFile: TppTBXItem;
    FLoadFromFileSeparator: TppTBXSeparatorItem;
    FLoadSubReport: TppTBXItem;
    FLoadSubReportFromFile: TppTBXItem;
    FLoadSubReportFromFileSeparator: TppTBXSeparatorItem;
    FLoadSubreportSeparator: TppTBXSeparatorItem;
    FMRUItems: TppMRUList;
    FNew: TppTBXItem;
    FNewReport: TppTBXItem;
    FOpen: TppTBXItem;
    FPageSetup: TppTBXItem;
    FPrint: TppTBXItem;
    FPrintToFileSetup: TppTBXItem;
    FSaveAs: TppTBXItem;
    FSave: TppTBXItem;
    FSaveSubReport: TppTBXItem;
    FSaveSubReportToFile: TppTBXItem;
    FSaveToFile: TppTBXItem;
    
  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject);
    procedure ehMRUItems_Click(Sender: TObject; const aFileName: String);

  public
    procedure Click; override;
    procedure LanguageChanged; override;
    procedure LoadPreferences(aIniStorage: TppIniStorage); override;
    procedure SavePreferences(aIniStorage: TppIniStorage); override;

    property Close: TppTBXItem read FClose;
    property LoadFromFile: TppTBXItem read FLoadFromFile;
    property LoadSubReport: TppTBXItem read FLoadSubReport;
    property LoadSubReportFromFile: TppTBXItem read FLoadSubReportFromFile;
    property MRUItems: TppMRUList read FMRUItems;
    property New: TppTBXItem read FNew;
    property NewReport: TppTBXItem read FNewReport;
    property Open: TppTBXItem read FOpen;
    property PageSetup: TppTBXItem read FPageSetup;
    property Print: TppTBXItem read FPrint;
    property PrintToFileSetup: TppTBXItem read FPrintToFileSetup;
    property SaveAs: TppTBXItem read FSaveAs;
    property Save: TppTBXItem read FSave;
    property SaveSubReport: TppTBXItem read FSaveSubReport;
    property SaveSubReportToFile: TppTBXItem read FSaveSubReportToFile;
    property SaveToFile: TppTBXItem read FSaveToFile;

  end;

  {TppDesignEditMenu}
  TppDesignEditMenu = class(TppDesignSubMenuItem)
  private
    FBringForward: TppTBXitem;
    FBringToFront: TppTBXItem;
    FCopy: TppTBXItem;
    FCut: TppTBXItem;
    FDelete: TppTBXItem;
    FPaste: TppTBXItem;
    FRedo: TppTBXItem;
    FSelectAll: TppTBXItem;
    FSendBackward: TppTBXItem;
    FSendToBack: TppTBXItem;
    FUndo: TppTBXItem;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject);

  public
    procedure Click; override;
    procedure LanguageChanged; override;

    property BringForward: TppTBXitem read FBringForward write FBringForward;
    property BringToFront: TppTBXItem read FBringToFront;
    property Copy: TppTBXItem read FCopy;
    property Cut: TppTBXItem read FCut;
    property DeleteItem: TppTBXItem read FDelete;
    property Paste: TppTBXItem read FPaste;
    property Redo: TppTBXItem read FRedo;
    property SelectAll: TppTBXItem read FSelectAll;
    property SendBackward: TppTBXItem read FSendBackward write FSendBackward;
    property SendToBack: TppTBXItem read FSendToBack;
    property Undo: TppTBXItem read FUndo;
  end;

  {TppDesignToolbarMenu}
  TppDesignToolbarMenu = class(TppDesignSubMenuItem)
  public
    procedure AddTool(aToolbar: TppTBCustomDockableWindow);
    procedure AddToolbars(aToolbarCollection: TppToolbarCollection);
    procedure AddToolWindows(aToolWindowCollection: TppToolWindowCollection);
    function IndexOfTool(aTool: TppTBCustomDockableWindow): Integer;
    procedure InsertTool(aIndex: Integer; aToolbar: TppTBCustomDockableWindow);
    procedure LanguageChanged; override;
    procedure Notification(aComponent: TComponent; aOperation: TOperation); override;
    procedure RemoveTool(aToolbar: TppTBCustomDockableWindow);
  end;

  {TppDesignToolbarMenu}
  TppDesignThemeMenu = class(TppDesignSubMenuItem)
  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject);
  public
    procedure AddThemeItem(aThemeName: String);
    procedure LanguageChanged; override;
  end;

  {TppDesignViewMenu}
  TppDesignViewMenu = class(TppDesignSubMenuItem)
  private
    FDesignGuides: TppTBXItem;
    FGridOptions: TppTBXItem;
    FRulers: TppTBXItem;
    FShowData: TppTBXItem;
    FThemes: TppDesignThemeMenu;
    FToolbars: TppDesignToolbarMenu;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject);
    procedure UpdateStatus(aReport: TppBandedReport); override;

  public
    procedure LanguageChanged; override;

    property DesignGuides: TppTBXItem read FDesignGuides;
    property GridOptions: TppTBXItem read FGridOptions;
    property Rulers: TppTBXItem read FRulers;
    property ShowData: TppTBXItem read FShowData;
    property Themes: TppDesignThemeMenu read FThemes;
    property Toolbars: TppDesignToolbarMenu read FToolbars;

  end;


  {TppDesignPassSettingMenu}
  TppDesignPassSettingMenu = class(TppDesignSubMenuItem)
  private
    FOnePass: TppTBXItem;
    FPassSetting: TppPassSettingType;
    FTwoPass: TppTBXItem;
    procedure SetPassSetting(const Value: TppPassSettingType);

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject);

  public
    procedure LanguageChanged; override;

    property OnePass: TppTBXItem read FOnePass;
    property PassSetting: TppPassSettingType read FPassSetting write SetPassSetting;
    property TwoPass: TppTBXItem read FTwoPass;

  end;

  {TppDesignUnitsMenu}
  TppDesignUnitsMenu = class(TppDesignSubMenuItem)
  private
    FInches: TppTBXItem;
    FMillimeters: TppTBXItem;
    FMMThousandths: TppTBXItem;
    FPrinterPixels: TppTBXItem;
    FScreenPixels: TppTBXItem;
    function GetUnits: TppUnitType;
    procedure SetUnits(const Value: TppUnitType);

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject);

  public
    procedure LanguageChanged; override;

    property Inches: TppTBXItem read FInches;
    property Millimeters: TppTBXItem read FMillimeters;
    property MMThousandths: TppTBXItem read FMMThousandths;
    property PrinterPixels: TppTBXItem read FPrinterPixels;
    property ScreenPixels: TppTBXItem read FScreenPixels;
    property Units: TppUnitType read GetUnits write SetUnits;

  end;

  {TppDesignReportMenu}
  TppDesignReportMenu = class(TppDesignSubMenuItem)
  private
    FCachePages: TppTBXItem;
    FData: TppTBXItem;
    FFindTextSettings: TppTBXItem;
    FFooter: TppTBXItem;
    FGroups: TppTBXItem;
    FHeader: TppTBXItem;
    FLandscape: TppTBXItem;
    FOutlineSettings: TppTBXItem;
    FPageStyle: TppTBXItem;
    FPassSetting: TppDesignPassSettingMenu;
    FPortrait: TppTBXItem;
    FSummary: TppTBXItem;
    FTitle: TppTBXItem;
    FUnits: TppDesignUnitsMenu;
    
  protected
    procedure CreateControls; override;
    procedure ehBandItem_Click(Sender: TObject);
    procedure ehDialogItem_Click(Sender: TObject);
    procedure ehPropertyItem_Click(Sender: TObject);
    procedure SetDesignControllers(const Value: TppDesignControllers); override;
    procedure UpdateStatus(aReport: TppBandedReport); override;

  public
    procedure LanguageChanged; override;

    property CachePages: TppTBXItem read FCachePages;
    property Data: TppTBXItem read FData;
    property FindTextSettings: TppTBXItem read FFindTextSettings;
    property Footer: TppTBXItem read FFooter;
    property Groups: TppTBXItem read FGroups;
    property Header: TppTBXItem read FHeader;
    property Landscape: TppTBXItem read FLandscape;
    property OutlineSettings: TppTBXItem read FOutlineSettings;
    property PageStyle: TppTBXItem read FPageStyle;
    property PassSetting: TppDesignPassSettingMenu read FPassSetting;
    property Portrait: TppTBXItem read FPortrait;
    property Summary: TppTBXItem read FSummary;
    property Title: TppTBXItem read FTitle;
    property Units: TppDesignUnitsMenu read FUnits;

  end;

  {TppDesignHelpMenu}
  TppDesignHelpMenu = class(TppDesignSubMenuItem)
  private
    FAbout: TppTBXItem;
    FHelpTopics: TppTBXItem;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject);

  public
    procedure LanguageChanged; override;

    property About: TppTBXItem read FAbout;
    property HelpTopics: TppTBXItem read FHelpTopics;

  end;

  {TppMenuUtils}
{  TppMenuUtils = class
  public
    class procedure CreateToolItemFromMenuItem(aMenuItem: TMenuItem): TppTBXItem;
    class procedure Merge(aSource: TMainMenu; aTarget: TppToolbarTBX);
  end;
}


  {TppDesignerMenu}
  TppDesignerMenu = class(TppDesignMenuBar)
  private
    FDesignControllers: TppDesignControllers;
    FFileMenu: TppDesignFileMenu;
    FEditMenu: TppDesignEditMenu;
    FHelpMenu: TppDesignHelpMenu;
    FReportMenu: TppDesignReportMenu;
    FViewMenu: TppDesignViewMenu;

    procedure SetDesignControllers(const Value: TppDesignControllers);

  protected
    procedure CreateItems; override;

  public
    constructor Create(Owner: TComponent); override;

    procedure LanguageChanged; override;
    procedure LoadPreferences(aIniStorage: TppIniStorage); override;
    procedure SavePreferences(aIniStorage: TppIniStorage); override;

    property DesignControllers: TppDesignControllers read FDesignControllers write SetDesignControllers;

    property EditMenu: TppDesignEditMenu read FEditMenu;
    property FileMenu: TppDesignFileMenu read FFileMenu;
    property HelpMenu: TppDesignHelpMenu read FHelpMenu;
    property ReportMenu: TppDesignReportMenu read FReportMenu;
    property ViewMenu: TppDesignViewMenu read FViewMenu;

  end;


  {TppDesignPopupMenu}
  TppDesignPopupMenu = class(TppPopupMenuBase)
  private
    FDesignControllers: TppDesignControllers;
    FDialogController: TppDesignDialogController;
    FDocumentController: TppDesignDocumentController;
    FSelectionController: TppDesignSelectionController;
    FWorkspaceController: TppDesignWorkspaceController;

  protected
    procedure SetDesignControllers(const Value: TppDesignControllers); virtual;

    property DialogController: TppDesignDialogController read FDialogController;
    property DocumentController: TppDesignDocumentController read FDocumentController;
    property SelectionController: TppDesignSelectionController read FSelectionController;
    property WorkspaceController: TppDesignWorkspaceController read FWorkspaceController;

  public
    property DesignControllers: TppDesignControllers read FDesignControllers write SetDesignControllers;

  end;

  {TppDesignToolbarPopupMenu}
  TppDesignToolbarPopupMenu = class(TppTBXPopupMenu)
  public
    procedure AddSeparator;
    procedure AddTool(aToolbar: TppTBCustomDockableWindow);
    procedure AddToolbars(aToolbarCollection: TppToolbarCollection);
    procedure AddToolWindows(aToolWindowCollection: TppToolWindowCollection);
    function Contains(aTool: TControl): Boolean;
    function IndexOfTool(aTool: TControl): Integer;
    function IndexOfTool1(aTool: TppTBCustomDockableWindow): Integer;
    procedure InsertSeparator(aIndex: Integer);
    procedure InsertTool(aIndex: Integer; aToolbar: TppTBCustomDockableWindow);
    procedure Notification(aComponent: TComponent; aOperation: TOperation); override;
    procedure RemoveTool(aToolbar: TppTBCustomDockableWindow);
  end;

  
  {TppDesignRulerPopupMenu}
  TppDesignRulerPopupMenu = class(TppDesignPopupMenu)
  private
    FHide: TppTBXItem;
    FUnitGroup: TppTBGroupItem;
    FUnits: TppDesignUnitsMenu;

  protected
    procedure CreateItems; override;

    procedure ehHideItem_Click(Sender: TObject);
    procedure SetDesignControllers(const Value: TppDesignControllers); override;

  public
    procedure LanguageChanged; override;
    procedure Popup(X, Y: Integer); override;

    property Units: TppDesignUnitsMenu read FUnits;
    property Hide: TppTBXItem read FHide;

  end;


implementation

uses
  ppDsgner,
  ppDesignerWorkspace;

{------------------------------------------------------------------------------}
{ TppDesignerMenu.Create}

constructor TppDesignerMenu.Create(Owner: TComponent);
begin

  inherited;

  Name := 'Menu'; // do not localize
  MenuBar := True;

  DockMode := dmCannotFloatOrChangeDocks;

end;

{------------------------------------------------------------------------------}
{ TppDesignerMenu.CreateItems}

procedure TppDesignerMenu.CreateItems;
begin

  FFileMenu := TppDesignFileMenu.Create(nil);
  FFileMenu.GroupIndex := 10;
  Items.Add(FFileMenu);

  FEditMenu := TppDesignEditMenu.Create(nil);
  FEditMenu.GroupIndex := 20;
  Items.Add(FEditMenu);

  FViewMenu := TppDesignViewMenu.Create(nil);
  FViewMenu.GroupIndex := 30;
  Items.Add(FViewMenu);

  FReportMenu := TppDesignReportMenu.Create(nil);
  FReportMenu.GroupIndex := 40;
  Items.Add(FReportMenu);

  FHelpMenu := TppDesignHelpMenu.Create(nil);
  FHelpMenu.GroupIndex := 50;
  Items.Add(FHelpMenu);

  LanguageChanged();

end;

{------------------------------------------------------------------------------}
{ TppDesignerMenu.LanguageChanged}

procedure TppDesignerMenu.LanguageChanged;
var
  liIndex: Integer;
begin

  for liIndex := 0 to Items.Count-1 do
    if (Items[liIndex] is TppSubMenuItem) then
      TppSubMenuItem(Items[liIndex]).LanguageChanged();


end;

{------------------------------------------------------------------------------}
{ TppDesignerMenu.LoadPreferences}

procedure TppDesignerMenu.LoadPreferences(aIniStorage: TppIniStorage);
var
  liIndex: Integer;
begin

  inherited;

  for liIndex := 0 to Items.Count-1 do
    if (Items[liIndex] is TppSubMenuItem) then
      TppSubMenuItem(Items[liIndex]).LoadPreferences(aIniStorage);


end;

{------------------------------------------------------------------------------}
{ TppDesignerMenu.SavePreferences}

procedure TppDesignerMenu.SavePreferences(aIniStorage: TppIniStorage);
var
  liIndex: Integer;
begin

  inherited;

  for liIndex := 0 to Items.Count-1 do
    if (Items[liIndex] is TppSubMenuItem) then
      TppSubMenuItem(Items[liIndex]).SavePreferences(aIniStorage);

end;

{------------------------------------------------------------------------------}
{ TppDesignerMenu.CreateControls}

procedure TppDesignerMenu.SetDesignControllers(const Value: TppDesignControllers);
begin
  if FDesignControllers <> Value then
  begin
    FDesignControllers := Value;
    FFileMenu.DesignControllers := FDesignControllers;
    FEditMenu.DesignControllers := FDesignControllers;
    FHelpMenu.DesignControllers := FDesignControllers;
    FReportMenu.DesignControllers := FDesignControllers;
    FViewMenu.DesignControllers := FDesignControllers;

  end;
end;

{------------------------------------------------------------------------------}
{ TppDesignFileMenu.Click}

procedure TppDesignFileMenu.Click;
var
  lbTemplateEnabled: Boolean;
  lBlankWizardClass: TppReportWizardClass;
  lbSubReportOptions: Boolean;
  lbAllowSaveToFile: Boolean;
  lReport: TppCustomReport;
begin

  lReport := WorkspaceController.Report;

  if (lReport = nil) then Exit;

  lbTemplateEnabled := (lReport.Template.SaveTo = stFile) or
                       (lReport.Template.CheckDatabaseSettings);

  Open.Enabled   := lbTemplateEnabled;
  Save.Enabled   := lbTemplateEnabled;
  SaveAs.Enabled := lbTemplateEnabled;

  {set visibility of load/save subreport options}
  lbSubReportOptions := (lReport is TppChildReport);

  LoadSubreport.Visible := lbSubReportOptions;
  SaveSubreport.Visible := lbSubReportOptions;
  FLoadSubreportSeparator.Visible := lbSubReportOptions;


  {set visibility of explicit file load & save options}
  lbAllowSaveToFile := TppDesignerWindow(lReport.ReportDesigner).AllowSaveToFile;
  LoadFromFile.Visible := lbAllowSaveToFile  and (lReport.Template.SaveTo = stDataBase);
  SaveToFile.Visible   := LoadFromFile.Visible;
  FLoadFromFileSeparator.Visible := LoadFromFile.Visible;

  LoadSubReportFromFile.Visible := LoadFromFile.Visible and lbSubReportOptions;
  SaveSubReportToFile.Visible   := LoadSubreportFromFile.Visible;
  FLoadSubReportFromFileSeparator.Visible := LoadSubreportFromFile.Visible;


  {set file new caption based on default wizard}
  lBlankWizardClass := ppDefaultBlankReportWizard;

  if (lBlankWizardClass <> nil) and (lBlankWizardClass.DisplaysDialog) then
    NewReport.Caption := ppLoadStr(572) + '...'
  else
    NewReport.Caption := ppLoadStr(572);

end;

{------------------------------------------------------------------------------}
{ TppDesignFileMenu.CreateControls}

procedure TppDesignFileMenu.CreateControls;
var
  liIndex: Integer;
  lMRUListItem: TppTBXMRUListItem;
begin

  // new, open, close
  FNew := AddChildItem();
  FNew.ShortCut := Menus.ShortCut(Ord('N'), [ssCtrl]); // Ctrl+N
  FNew.ImageIndex := ToolImageList.AddTool('PPNEW');

  FNewReport := AddChildItem();

  FOpen := AddChildItem();
  FOpen.ImageIndex := ToolImageList.AddTool('PPOPEN');
  FOpen.ShortCut := Menus.ShortCut(Ord('O'), [ssCtrl]); // Ctrl+O

  FClose := AddChildItem();

  AddSeparator();

  // save, save as
  FSave := AddChildItem();
  FSave.ImageIndex := ToolImageList.AddTool('PPSAVE');
  FSave.ShortCut := Menus.ShortCut(Ord('S'), [ssCtrl]); // Ctrl+S

  FSaveAs := AddChildItem();

  //  FSaveForm := AddChildItem();

  AddSeparator();

  // load subreport
  FLoadSubReport := AddChildItem();
  FSaveSubReport := AddChildItem();
  FLoadSubreportSeparator := AddSeparator();

  // load from file

  FLoadFromFile := AddChildItem();
  FSaveToFile  := AddChildItem();
  FLoadFromFileSeparator := AddSeparator();


  // load subreport from file
  FLoadSubReportFromFile  := AddChildItem();
  FSaveSubReportToFile  := AddChildItem();
  FLoadSubReportFromFileSeparator := AddSeparator();

  // page setup, print
  FPageSetup  := AddChildItem();
  FPageSetup.ImageIndex := ToolImageList.AddTool('PPPAGESETUP');

  FPrint  := AddChildItem();
  FPrint.ShortCut := Menus.ShortCut(Ord('P'), [ssCtrl]); // Ctrl+P
  FPrint.ImageIndex := ToolImageList.AddTool('PPPRINT');

  AddSeparator();

  // print to file setup
  FPrintToFileSetup  := AddChildItem();

  // attach item click event handler
  for liIndex := 0 to Count-1 do
    Items[liIndex].OnClick := ehItem_Click;

  // MRU list
  AddSeparator();

  FMRUItems := TppMRUList.Create(Self);
  FMRUItems.OnClick := ehMRUItems_Click;

  lMRUListItem := TppTBXMRUListItem.Create(Self);
  lMRUListItem.MRUList := FMRUItems;

  Self.Add(lMRUListItem);


end;

{------------------------------------------------------------------------------}
{ TppDesignFileMenu.ehItemClick}

procedure TppDesignFileMenu.ehItem_Click(Sender: TObject);
begin

  if (Sender = FNew) then
    DocumentController.New(True {DisplayDialog})

  else if (Sender = FNewReport) then
    DocumentController.New()

  else if (Sender = FOpen) then
    DocumentController.Open()

  else if (Sender = FSave) then
    DocumentController.Save()

  else if (Sender = FSaveAs) then
    DocumentController.SaveAs()

  else if (Sender = FLoadSubReport) then
    DocumentController.Open(DocumentController.Report)

  else if (Sender = FSaveSubReport) then
    DocumentController.Save(DocumentController.Report)

  else if (Sender = FLoadFromFile) then
    DocumentController.OpenFile()

  else if (Sender = FSaveToFile) then
    DocumentController.SaveFile()

  else if (Sender = FLoadSubReportFromFile) then
    DocumentController.OpenFile(DocumentController.Report)

  else if (Sender = FSaveSubReportToFile) then
    DocumentController.SaveFile(DocumentController.Report)

  else if (Sender = FPageSetup) then
    DialogController.ShowPageSetupDialog()

  else if (Sender = FPrintToFileSetup) then
    DialogController.ShowPrintToFileSetupDialog()

  else if (Sender = FPrint) then
    DocumentController.Print()

  else if (Sender = FClose) then
    DesignControllers.Report.ComponentDesigner.Perform(WM_CLOSE, 0, 0);


end;

{------------------------------------------------------------------------------}
{ TppDesignFileMenu.ehMRUItems_Click}

procedure TppDesignFileMenu.ehMRUItems_Click(Sender: TObject; const aFileName: String);
var
  liIndex: Integer;
begin

  liIndex := FMRUItems.TemplateItems.IndexOf(aFileName);

  if (liIndex >= 0) then
    DocumentController.Open(FMRUItems.TemplateItems[liIndex]);

end;

{------------------------------------------------------------------------------}
{ TppDesignFileMenu.LanguageChanged}

procedure TppDesignFileMenu.LanguageChanged;
begin

  Caption := ppLoadStr(131);

  FNew.Caption       := ppLoadStr(133) + '...';
  FNewReport.Caption := ppLoadStr(572);
  FOpen.Caption      := ppLoadStr(134);
  FClose.Caption  := ppLoadStr(132);
  FSave.Caption      := ppLoadStr(138);
  FSaveAs.Caption    := ppLoadStr(139);

  FLoadSubReport.Caption := ppLoadStr(696); {'&Load SubReport...'}
  FSaveSubReport.Caption := ppLoadStr(697); {'S&ave SubReport...'}

//  FSaveForm.Caption  := ppLoadStr(140);

  FLoadFromFile.Caption := ppLoadStr(698); {'Loa&d From File...'}
  FSaveToFile.Caption   := ppLoadStr(699); {'Sa&ve to File...'}

  FLoadSubReportFromFile.Caption := ppLoadStr(700); {'Load SubReport From File...'}
  FSaveSubReportToFile.Caption   := ppLoadStr(1101); {'Save SubReport To File...'}

  FPageSetup.Caption := ppLoadStr(135);
  FPrint.Caption     := ppLoadStr(136);
  FPrintToFileSetup.Caption  := ppLoadStr(137);

end;

{------------------------------------------------------------------------------}
{ TppDesignFileMenu.LoadPreferences}

procedure TppDesignFileMenu.LoadPreferences(aIniStorage: TppIniStorage);
begin
  FMRUItems.LoadPreferences(aIniStorage);

end;

{------------------------------------------------------------------------------}
{ TppDesignFileMenu.SavePreferences}

procedure TppDesignFileMenu.SavePreferences(aIniStorage: TppIniStorage);
begin
  FMRUItems.SavePreferences(aIniStorage);

end;

{------------------------------------------------------------------------------}
{ TppDesignEditMenu.Click}

procedure TppDesignEditMenu.Click;
var
  lbUndoEnabled : Boolean;
begin

  FPaste.Enabled := ClipBoard.HasFormat(CF_PPDATA); // or ClipBoard.HasFormat(CF_TEXT);

  lbUndoEnabled := SelectionController.UndoManager.UndoableCount > 0;

  FUndo.Caption := ppLoadStr(130) + ':' + IntToStr(SelectionController.UndoManager.UndoableCount);
  FRedo.Caption := ppLoadStr(126) + ':' + IntToStr(SelectionController.UndoManager.RedoableCount);

  FUndo.Enabled := lbUndoEnabled;
  FRedo.Enabled := (SelectionController.UndoManager.RedoableCount > 0);

end;

{------------------------------------------------------------------------------}
{ TppDesignEditMenu.CreateControls}

procedure TppDesignEditMenu.CreateControls;
begin

  FUndo := AddChildItem();
  FUndo.ShortCut := Menus.ShortCut(Ord('Z'), [ssCtrl]); // Ctrl+Z
  FUndo.OnClick := ehItem_Click;
  FUndo.ImageIndex := ToolImageList.AddTool('PPUNDO');

  FRedo := AddChildItem();
  FRedo.ShortCut := Menus.ShortCut(Ord('Y'), [ssCtrl]); // Ctrl+Y
  FRedo.OnClick := ehItem_Click;
  FRedo.ImageIndex := ToolImageList.AddTool('PPREDO');

  AddSeparator();

  FCut := AddChildItem();
  FCut.ShortCut := Menus.ShortCut(Ord('X'), [ssCtrl]); // Ctrl+X
  FCut.ImageIndex := ToolImageList.AddTool('PPCUT');
  FCut.OnClick := ehItem_Click;

  FCopy := AddChildItem();
  FCopy.ShortCut := Menus.ShortCut(Ord('C'), [ssCtrl]); // Ctrl+C
  FCopy.ImageIndex := ToolImageList.AddTool('PPCOPY');
  FCopy.OnClick := ehItem_Click;

  FPaste := AddChildItem();
  FPaste.ShortCut := Menus.ShortCut(Ord('V'), [ssCtrl]); // Ctrl+V
  FPaste.ImageIndex := ToolImageList.AddTool('PPPASTE');
  FPaste.OnClick := ehItem_Click;

  FDelete := AddChildItem();
  FDelete.ShortCut := Menus.ShortCut(VK_DELETE, [ssCtrl]); // Ctrl+Del
  FDelete.OnClick := ehItem_Click;
  FDelete.ImageIndex := ToolImageList.AddTool('PPDELETE');

  FSelectAll := AddChildItem();
  FSelectAll.ShortCut := Menus.ShortCut(Ord('A'), [ssCtrl]); // Ctrl+A
  FSelectAll.OnClick := ehItem_Click;

  AddSeparator();

  FBringToFront := AddChildItem();
  FBringToFront.ImageIndex := ToolImageList.AddTool('PPBRINGTOFRONT');
  FBringToFront.OnClick := ehItem_Click;

  FBringForward := AddChildItem();
  FBringForward.ImageIndex := ToolImageList.AddTool('PPBringForward');
  FBringForward.OnClick := ehItem_Click;

  FSendToBack := AddChildItem();
  FSendToBack.ImageIndex := ToolImageList.AddTool('PPSENDTOBACK');
  FSendToBack.OnClick := ehItem_Click;

  FSendBackward := AddChildItem();
  FSendBackward.ImageIndex := ToolImageList.AddTool('PPSENDBackward');
  FSendBackward.OnClick := ehItem_Click;

end;

{------------------------------------------------------------------------------}
{ TppDesignEditMenu.ehItem_Click}

procedure TppDesignEditMenu.ehItem_Click(Sender: TObject);
begin

  if (Screen.ActiveControl is TppWorkspace) then
    begin
      // call selection controller
      if (Sender = FUndo) then
        SelectionController.Undo()

      else if (Sender = FRedo) then
        SelectionController.Redo()

      else if (Sender = FCut) then
        SelectionController.CutToClipboard()

      else if (Sender = FCopy) then
        SelectionController.CopyToClipboard()

      else if (Sender = FPaste) then
        SelectionController.PasteFromClipboard()

      else if (Sender = FDelete) then
        SelectionController.Delete()

      else if (Sender = FSelectAll) then
        SelectionController.SelectAll()

      else if (Sender = FBringForward) then
        SelectionController.BringForward()

      else if (Sender = FBringToFront) then
        SelectionController.BringToFront()

      else if (Sender = FSendBackward) then
        SelectionController.SendBackward()

      else if (Sender = FSendToBack) then
        SelectionController.SendToBack();
    end

  else if (Screen.ActiveControl <> nil) then
    begin

      // send message to the active control
      if (Sender = FUndo) then
        SendMessage(Screen.ActiveControl.Handle, WM_UNDO, 0, 0)

//      else if (Sender = FRedo) then
//        SendMessage(Screen.ActiveControl.Handle, WM_REDO, 0, 0) // no such animal

      else if (Sender = FCut) then
        SendMessage(Screen.ActiveControl.Handle, WM_CUT, 0, 0)

      else if (Sender = FCopy) then
        SendMessage(Screen.ActiveControl.Handle, WM_COPY, 0, 0)


      else if (Sender = FPaste) then
        SendMessage(Screen.ActiveControl.Handle, WM_PASTE, 0, 0)

      else if (Sender = FDelete) then
        SendMessage(Screen.ActiveControl.Handle, WM_CUT, 0, 0)

      else if (Sender = FSelectAll) then
        SendMessage(Screen.ActiveControl.Handle, EM_SETSEL, 0, 0)

    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignEditMenu.LanguageChanged}

procedure TppDesignEditMenu.LanguageChanged;
begin

  Caption := ppLoadStr(120);

  FUndo.Caption         := ppLoadStr(130);
  FRedo.Caption         := ppLoadStr(126);
  FCut.Caption          := ppLoadStr(123);
  FCopy.Caption         := ppLoadStr(122);
  FPaste.Caption        := ppLoadStr(125);
  FDelete.Caption       := ppLoadStr(124);
  FSelectAll.Caption    := ppLoadStr(127);
  FBringToFront.Caption := ppLoadStr(121);
  FSendToBack.Caption   := ppLoadStr(128);
  FBringForward.Caption := ppLoadStr(1159); // Bring Forward
  FSendBackward.Caption := ppLoadStr(1160); // Send Backward 

end;

{------------------------------------------------------------------------------}
{ TppDesignViewMenu.CreateControls}

procedure TppDesignViewMenu.CreateControls;
begin

  FToolbars := TppDesignToolbarMenu.Create(Owner);
  FToolbars.ImageIndex := ToolImageList.AddIcon('PPTOOLBARS');
  Add(FToolbars);

  FRulers := AddChildItem();
  FRulers.AutoCheck := True;
  FRulers.OnClick := ehItem_Click;
  FRulers.ImageIndex := ToolImageList.AddIcon('PPRULER');

  AddSeparator();

  FDesignGuides := AddChildItem();
  FDesignGuides.AutoCheck := True;
  FDesignGuides.OnClick := ehItem_Click;

  FGridOptions := AddChildItem();
  FGridOptions.OnClick := ehItem_Click;
  FGridOptions.ImageIndex := ToolImageList.AddIcon('PPGRID');

  FShowData := AddChildItem();
  FShowData.AutoCheck := True;
  FShowData.OnClick := ehItem_Click;

  AddSeparator();

  FThemes := TppDesignThemeMenu.Create(Owner);
  Add(FThemes);

end;

{------------------------------------------------------------------------------}
{ TppDesignViewMenu.ehItem_Click}

procedure TppDesignViewMenu.ehItem_Click(Sender: TObject);
begin

  if (Sender = FDesignGuides) then
     WorkspaceController.WorkspaceView.ShowDesignGuides := FDesignGuides.Checked

  else if (Sender = FRulers) then
    begin
      WorkspaceController.WorkspaceView.HorizontalRulerArea.Visible := FRulers.Checked;
      WorkspaceController.WorkspaceView.VerticalRulerArea.Visible := FRulers.Checked;
    end
  else if (Sender = FGridOptions) then
    DialogController.ShowGridOptionsDialog

  else if (Sender = FShowData) then
    WorkspaceController.WorkspaceView.LiveData := FShowData.Checked;

end;

{------------------------------------------------------------------------------}
{ TppDesignViewMenu.CreateControls}

procedure TppDesignViewMenu.LanguageChanged;
begin

  Caption := ppLoadStr(155);

  FDesignGuides.Caption := ppLoadStr(1158); //'Design Guides'
  FRulers.Caption := ppLoadStr(158);
  FGridOptions.Caption := ppLoadStr(344) + '...';
  FShowData.Caption := ppLoadStr(159);

  FToolbars.LanguageChanged();

  FThemes.LanguageChanged();

end;

{------------------------------------------------------------------------------}
{ TppDesignPassSettingMenu.UpdateStatus}

procedure TppDesignViewMenu.UpdateStatus(aReport: TppBandedReport);
begin

  FRulers.Checked := WorkspaceController.WorkspaceView.HorizontalRulerArea.Visible;
  FDesignGuides.Checked := WorkspaceController.WorkspaceView.ShowDesignGuides;
  FShowData.Checked := WorkspaceController.WorkspaceView.LiveData;

end;

{------------------------------------------------------------------------------}
{ TppDesignHelpMenu.CreateControls}

procedure TppDesignHelpMenu.CreateControls;
begin

  FHelpTopics := AddChildItem();
  FHelpTopics.OnClick := ehItem_Click;
  FHelpTopics.ImageIndex := ToolImageList.AddIcon('PPHELP');

  AddSeparator();

  FAbout := AddChildItem();
  FAbout.OnClick := ehItem_Click;

end;

{------------------------------------------------------------------------------}
{ TppDesignHelpMenu.ehItem_Click}

procedure TppDesignHelpMenu.ehItem_Click(Sender: TObject);
begin

  if (Sender = FHelpTopics) then
    DialogController.ShowHelp()

  else if (Sender = FAbout) then
    DialogController.ShowAboutDialog();

end;

{------------------------------------------------------------------------------}
{ TppDesignHelpMenu.CreateControls}

procedure TppDesignHelpMenu.LanguageChanged;
begin

  Caption := ppLoadStr(142);

  FHelpTopics.Caption := ppLoadStr(144);

  FAbout.Caption := ppLoadStr(143) + '...';

end;

{------------------------------------------------------------------------------}
{ TppDesignReportMenu.CreateControls}

procedure TppDesignReportMenu.CreateControls;
begin


  Images := ToolImageList;

  FData := AddChildItem();
  FData.OnClick := ehDialogItem_Click;
  FData.ImageIndex := ToolImageList.AddIcon('PPTABLES');

  AddSeparator();

  FTitle  := AddChildItem();
  FTitle.AutoCheck := True;
  FTitle.OnClick := ehBandItem_Click;
  FTitle.ImageIndex := ToolImageList.AddIcon('PPTITLE');

  FSummary := AddChildItem();
  FSummary.AutoCheck := True;
  FSummary.OnClick := ehBandItem_Click;
  FSummary.ImageIndex := ToolImageList.AddIcon('PPSUMMARY');

  AddSeparator();

  FHeader  := AddChildItem();
  FHeader.AutoCheck := True;
  FHeader.OnClick := ehBandItem_Click;
  FHeader.ImageIndex := ToolImageList.AddIcon('PPHEADER');

  FFooter := AddChildItem();
  FFooter.AutoCheck := True;
  FFooter.OnClick := ehBandItem_Click;
  FFooter.ImageIndex := ToolImageList.AddIcon('PPFOOTER');

  AddSeparator();

  FPageStyle := AddChildItem();
  FPageStyle.AutoCheck := True;
  FPageStyle.OnClick := ehBandItem_Click;

  AddSeparator();

  FGroups := AddChildItem();
  FGroups.ShortCut := Menus.ShortCut(Ord('G'), [ssCtrl]); // Ctrl+G
  FGroups.OnClick := ehDialogItem_Click;
  FGroups.ImageIndex := ToolImageList.AddIcon('PPGROUPS');

  AddSeparator();

  FOutlineSettings := AddChildItem();
  FOutlineSettings.OnClick := ehDialogItem_Click;
  FOutlineSettings.ImageIndex := ToolImageList.AddIcon('PPOUTLINE');

  FFindTextSettings := AddChildItem();
  FFindTextSettings.OnClick := ehDialogItem_Click;
  FFindTextSettings.ImageIndex := ToolImageList.AddIcon('PPTEXTSEARCH');

  AddSeparator();

  FPortrait :=  AddChildItem();
  FPortrait.AutoCheck := True;
  FPortrait.GroupIndex := 2;
  FPortrait.OnClick := ehPropertyItem_Click;
  FPortrait.ImageIndex := ToolImageList.AddIcon('PPPORTRAIT');

  FLandscape := AddChildItem();
  FLandscape.AutoCheck := True;
  FLandscape.GroupIndex := 2;
  FLandscape.OnClick := ehPropertyItem_Click;
  FLandscape.ImageIndex := ToolImageList.AddIcon('PPLANDSCAPE');

  AddSeparator();

  FCachePages := AddChildItem();
  FCachePages.AutoCheck := True;
  FCachePages.OnClick := ehPropertyItem_Click;

  FPassSetting := TppDesignPassSettingMenu.Create(nil);
  Add(FPassSetting);

  AddSeparator();

  FUnits := TppDesignUnitsMenu.Create(nil);
  Add(FUnits);

end;

{------------------------------------------------------------------------------}
{ TppDesignReportMenu.ehBandItem_Click}

procedure TppDesignReportMenu.ehBandItem_Click(Sender: TObject);
begin

  if (Sender = FTitle) then
    begin
      if (FTitle.Checked) then
        WorkspaceController.AddBand(TppTitleBand)
      else
        WorkspaceController.RemoveBand(TppTitleBand);
    end
  else if (Sender = FSummary) then
    begin
      if (FSummary.Checked) then
        WorkspaceController.AddBand(TppSummaryBand)
      else
        WorkspaceController.RemoveBand(TppSummaryBand);
    end
  else if (Sender = FHeader) then
    begin
      if (FHeader.Checked) then
        WorkspaceController.AddBand(TppHeaderBand)
      else
        WorkspaceController.RemoveBand(TppHeaderBand);
    end
  else if (Sender = FFooter) then
    begin
      if (FFooter.Checked) then
        WorkspaceController.AddBand(TppFooterBand)
      else
        WorkspaceController.RemoveBand(TppFooterBand);
    end
  else if (Sender = FPageStyle) then
    begin
      if (FPageStyle.Checked) then
        WorkspaceController.AddBand(TppPageStyle)
      else
        WorkspaceController.RemoveBand(TppPageStyle);
    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignReportMenu.ehDialogItem_Click}

procedure TppDesignReportMenu.ehDialogItem_Click(Sender: TObject);
begin

  if (Sender = FData) then
    DialogController.ShowDataDialog()

  else if (Sender = FGroups) then
    DialogController.ShowGroupsDialog()

  else if (Sender = FOutlineSettings) then
    DialogController.ShowOutlineSettingsDialog()

  else if (Sender = FFindTextSettings) then
    DialogController.ShowTextSearchSettingsDialog()


end;

{------------------------------------------------------------------------------}
{ TppDesignReportMenu.ehPropertyItem_Click}

procedure TppDesignReportMenu.ehPropertyItem_Click(Sender: TObject);
begin

  if (Sender = FPortrait) then
    DialogController.Report.PrinterSetup.Orientation := poPortrait

  else if (Sender = FLandscape) then
    DialogController.Report.PrinterSetup.Orientation := poLandscape

  else if  (Sender = FCachePages) then
    DialogController.MainReport.CachePages := FCachePages.Checked

end;

{------------------------------------------------------------------------------}
{ TppDesignReportMenu.LanguageChanged}

procedure TppDesignReportMenu.LanguageChanged;
begin

  Caption := ppLoadStr(145);

  FData.Caption             := ppLoadStr(394);
  FTitle.Caption            := ppLoadStr(150);
  FSummary.Caption          := ppLoadStr(149);
  FHeader.Caption           := ppLoadStr(193);
  FFooter.Caption           := ppLoadStr(190);
  FPageStyle.Caption :=  ppLoadStr(691);

  FOutlineSettings.Caption  := ppLoadStr(1140); // 'Outline Settings...'
  FFindTextSettings.Caption := ppLoadStr(1150) + '...'; {'Text Search Settings';}

  FGroups.Caption           := ppLoadStr(146);
  FLandscape.Caption        := ppLoadStr(147);
  FPortrait.Caption         := ppLoadStr(148);

  FCachePages.Caption       := ppLoadStr(1113); {'&Cache Pages'}

  FPassSetting.LanguageChanged;
  FUnits.LanguageChanged;

end;

{------------------------------------------------------------------------------}
{ TppDesignPassSettingMenu.SetDesignControllers}

procedure TppDesignReportMenu.SetDesignControllers(const Value: TppDesignControllers);
begin

  inherited;

  FPassSetting.DesignControllers := Value;
  FUnits.DesignControllers := Value;

end;

{------------------------------------------------------------------------------}
{ TppDesignPassSettingMenu.UpdateStatus}

procedure TppDesignReportMenu.UpdateStatus(aReport: TppBandedReport);
begin

  FCachePages.Checked := TppReport(aReport.MainReport).CachePages;

  FTitle.Checked := (aReport.Title <> nil);
  FHeader.Checked := (aReport.Header <> nil);
  FFooter.Checked := (aReport.Footer <> nil);
  FSummary.Checked := (aReport.Summary <> nil);
  FPageStyle.Checked := (aReport.Pagestyle <> nil);

  FLandscape.Checked := (aReport.PrinterSetup.Orientation = poLandscape);
  FPortrait.Checked := (aReport.PrinterSetup.Orientation = poPortrait);

  FPassSetting.PassSetting := TppReport(aReport.MainReport).PassSetting;
  
  FUnits.Units := TppReport(aReport.MainReport).Units;

end;

{------------------------------------------------------------------------------}
{ TppDesignPassSettingMenu.CreateControls}

procedure TppDesignPassSettingMenu.CreateControls;
begin

  FOnePass := AddChildItem();
  FOnePass.AutoCheck := True;
  FOnePass.GroupIndex := 1;
  FOnePass.OnClick := ehItem_Click;

  FTwoPass := AddChildItem();
  FTwoPass.AutoCheck := True;
  FTwoPass.GroupIndex := 1;
  FTwoPass.OnClick := ehItem_Click;

end;

{------------------------------------------------------------------------------}
{ TppDesignPassSettingMenu.ehItem_Click}

procedure TppDesignPassSettingMenu.ehItem_Click(Sender: TObject);
begin

  if (Sender = FOnePass) then
    DialogController.MainReport.PassSetting := psOnePass
  else
    DialogController.MainReport.PassSetting := psTwoPass;

end;

{------------------------------------------------------------------------------}
{ TppDesignPassSettingMenu.CreateControls}

procedure TppDesignPassSettingMenu.LanguageChanged;
begin

  Caption := ppLoadStr(1114); {'P&ass Setting'}

  FOnePass.Caption       := ppLoadStr(1115); {'&One Pass'}
  FTwoPass.Caption       := ppLoadStr(1116); {'&Two Pass'}

end;

{------------------------------------------------------------------------------}
{ TppDesignPassSettingMenu.CreateControls}

procedure TppDesignPassSettingMenu.SetPassSetting(const Value: TppPassSettingType);
begin

  FPassSetting := Value;

  if FPassSetting = psOnePass then
    FOnePass.Checked := True
  else
    FTwoPass.Checked := True;

end;

{------------------------------------------------------------------------------}
{ TppDesignUnitsMenu.CreateControls}

procedure TppDesignUnitsMenu.CreateControls;
begin

  FInches := AddChildItem();
  FInches.AutoCheck := True;
  FInches.GroupIndex := 1;
  FInches.OnClick := ehItem_Click;

  FMillimeters := AddChildItem();
  FMillimeters.AutoCheck := True;
  FMillimeters.GroupIndex := 1;
  FMillimeters.OnClick := ehItem_Click;

  FPrinterPixels := AddChildItem();
  FPrinterPixels.AutoCheck := True;
  FPrinterPixels.GroupIndex := 1;
  FPrinterPixels.OnClick := ehItem_Click;

  FScreenPixels := AddChildItem();
  FScreenPixels.AutoCheck := True;
  FScreenPixels.GroupIndex := 1;
  FScreenPixels.OnClick := ehItem_Click;

  FMMThousandths := AddChildItem();
  FMMThousandths.AutoCheck := True;
  FMMThousandths.GroupIndex := 1;
  FMMThousandths.OnClick := ehItem_Click;


end;

{------------------------------------------------------------------------------}
{ TppDesignUnitsMenu.ehItem_Click}

procedure TppDesignUnitsMenu.ehItem_Click(Sender: TObject);
begin

  if (DialogController = nil) then Exit;
  
  if (Sender = FInches) then
    DialogController.Report.Units := utInches
  else if (Sender = FMillimeters) then
    DialogController.Report.Units := utMillimeters
  else if (Sender = FPrinterPixels) then
    DialogController.Report.Units := utPrinterPixels
  else if (Sender = FScreenPixels) then
    DialogController.Report.Units := utScreenPixels
  else if (Sender = FMMThousandths) then
    DialogController.Report.Units := utMMThousandths;

end;

{------------------------------------------------------------------------------}
{ TppDesignUnitsMenu.GetUnits}

function TppDesignUnitsMenu.GetUnits: TppUnitType;
begin

  if (FInches.Checked) then
    Result := utInches
  else if (FMillimeters.Checked) then
    Result := utMillimeters
  else if (FScreenPixels.Checked) then
    Result := utScreenPixels
  else if (FPrinterPixels.Checked) then
    Result := utPrinterPixels
  else // if (FMMThousandths.Checked) then
    Result := utMMThousandths;


end;

{------------------------------------------------------------------------------}
{ TppDesignUnitsMenu.LanguageChanged}

procedure TppDesignUnitsMenu.LanguageChanged;
begin

  Caption := ppLoadStr(151);

  FInches.Caption        := ppLoadStr(152);
  FMillimeters.Caption   := ppLoadStr(153);
  FScreenPixels.Caption  := ppLoadStr(387);
  FPrinterPixels.Caption := ppLoadStr(388);
  FMMThousandths.Caption := ppLoadStr(389);


end;

{------------------------------------------------------------------------------}
{ TppDesignUnitsMenu.SetUnits}

procedure TppDesignUnitsMenu.SetUnits(const Value: TppUnitType);
begin

  case Value of
    utInches:        FInches.Checked := True;
    utMillimeters:   FMillimeters.Checked := True;
    utScreenPixels:  FScreenPixels.Checked := True;
    utPrinterPixels: FPrinterPixels.Checked := True;
    utMMThousandths: FMMThousandths.Checked  := True;

  end;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.AddToolbar}

procedure TppDesignToolbarMenu.AddTool(aToolbar: TppTBCustomDockableWindow);
var
  lItem: TppTBXVisibilityToggleItem;
begin

  lItem := TppTBXVisibilityToggleItem.Create(Owner);
  lItem.Control := aToolbar;

  Add(lItem);

  aToolbar.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.AddToolbars}

procedure TppDesignToolbarMenu.AddToolbars(aToolbarCollection: TppToolbarCollection);
var
  liIndex: Integer;
begin

  for liIndex := 0 to aToolbarCollection.Count-1 do
    AddTool(aToolbarCollection[liIndex]);


end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.AddToolWindows}

procedure TppDesignToolbarMenu.AddToolWindows(aToolWindowCollection:
    TppToolWindowCollection);
var
  liIndex: Integer;
begin

  for liIndex := 0 to aToolWindowCollection.Count-1 do
    AddTool(aToolWindowCollection[liIndex]);

end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.IndexOfTool}

function TppDesignToolbarMenu.IndexOfTool(aTool: TppTBCustomDockableWindow): Integer;
var
  lbFound: Boolean;
  liIndex: Integer;
begin

  lbFound := False;
  liIndex := 0;

  while not(lbFound) and (liIndex < Count) do
    begin
      if (Items[liIndex] is TppTBXVisibilityToggleItem) then
        lbFound := TppTBXVisibilityToggleItem(Items[liIndex]).Control = aTool;

      if not(lbFound) then
        Inc(liIndex);

    end;

  if lbFound then
    Result := liIndex
  else
    Result := -1;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.InsertToolbar}

procedure TppDesignToolbarMenu.InsertTool(aIndex: Integer; aToolbar: TppTBCustomDockableWindow);
var
  lItem: TppTBXVisibilityToggleItem;
begin

  lItem := TppTBXVisibilityToggleItem.Create(Owner);
  lItem.Control := aToolbar;

  Insert(aIndex, lItem);

  aToolbar.FreeNotification(Self);
  
end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.LanguageChanged}

procedure TppDesignToolbarMenu.LanguageChanged;
var
  liIndex: Integer;
  lItem: TppTBXVisibilityToggleItem;
  lControl: TControl;
begin

  Caption := ppLoadStr(499);  {Toolbars}

  // refresh item captions
  for liIndex := 0 to Count - 1 do
    if Items[liIndex] is TppTBXVisibilityToggleItem then
      begin
        lItem := TppTBXVisibilityToggleItem(Items[liIndex]);

        // to refresh the caption: remove, blank out caption and then re-add 
        lControl := lItem.Control;
        lItem.Control := nil;
        lItem.Caption := '';
        lItem.Control := lControl;

      end;


end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.Notification}

procedure TppDesignToolbarMenu.Notification(aComponent: TComponent; aOperation: TOperation);
begin

  inherited;

  if (csDestroying in ComponentState) then Exit;

  if (aOperation <> opRemove) then Exit;

  if (aComponent is TppTBCustomDockableWindow) then
    RemoveTool(TppTBCustomDockableWindow(aComponent));


end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.RemoveTool}

procedure TppDesignToolbarMenu.RemoveTool(aToolbar: TppTBCustomDockableWindow);
var
  liIndex: Integer;
begin

  if (csDestroying in ComponentState) then Exit;

  liIndex := IndexOfTool(aToolbar);

  if (liIndex >= 0) then
    Items[liIndex].Free;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.AddSeparator}

procedure TppDesignToolbarPopupMenu.AddSeparator;
var
  lItem: TppTBXSeparatorItem;
begin

  lItem := TppTBXSeparatorItem.Create(Owner);

  Items.Add(lItem);
  
end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.AddToolbar}

procedure TppDesignToolbarPopupMenu.AddTool(aToolbar: TppTBCustomDockableWindow);
var
  lItem: TppTBXVisibilityToggleItem;
begin

  if Contains(aToolbar) then Exit;

  lItem := TppTBXVisibilityToggleItem.Create(Owner);
  lItem.Control := aToolbar;

  Items.Add(lItem);

  aToolbar.FreeNotification(Self);

end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.AddToolbar}

procedure TppDesignToolbarPopupMenu.AddToolbars(aToolbarCollection: TppToolbarCollection);
var
  liIndex: Integer;
begin

  for liIndex := 0 to aToolbarCollection.Count-1 do
    AddTool(aToolbarCollection[liIndex]);


end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarPopupMenu.AddToolWindows}

procedure TppDesignToolbarPopupMenu.AddToolWindows(aToolWindowCollection:
    TppToolWindowCollection);
var
  liIndex: Integer;
begin

  for liIndex := 0 to aToolWindowCollection.Count-1 do
    AddTool(aToolWindowCollection[liIndex]);

end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.Contains}

function TppDesignToolbarPopupMenu.Contains(aTool: TControl): Boolean;
begin

  Result := IndexOfTool(aTool) >= 0;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.IndexOfTool}

function TppDesignToolbarPopupMenu.IndexOfTool(aTool: TControl): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
  lItem: TppTBCustomItem;
begin

  lbFound := False;
  liIndex := 0;

  while not(lbFound) and (liIndex < Items.Count) do
    begin

      lItem := Items[liIndex];

      if (lItem is TppTBXVisibilityToggleItem) then
        lbFound := TppTBXVisibilityToggleItem(lItem).Control = aTool;

      if not(lbFound) then
        Inc(liIndex);

    end;

  if (lbFound) then
    Result := liIndex
  else
    Result := -1;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.IndexOfTool}

function TppDesignToolbarPopupMenu.IndexOfTool1(aTool:
    TppTBCustomDockableWindow): Integer;
var
  lbFound: Boolean;
  liIndex: Integer;
begin

  lbFound := False;
  liIndex := 0;

  while not(lbFound) and (liIndex < Items.Count) do
    begin
      if (Items[liIndex] is TppTBXVisibilityToggleItem) then
        lbFound := TppTBXVisibilityToggleItem(Items[liIndex]).Control = aTool;

      if not(lbFound) then
        Inc(liIndex);

    end;

  if lbFound then
    Result := liIndex
  else
    Result := -1;

end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.InsertSeparator}

procedure TppDesignToolbarPopupMenu.InsertSeparator(aIndex: Integer);
var
  lItem: TppTBXSeparatorItem;
begin

  lItem := TppTBXSeparatorItem.Create(Owner);

  Items.Insert(aIndex, lItem);
end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.InsertToolbar}

procedure TppDesignToolbarPopupMenu.InsertTool(aIndex: Integer; aToolbar:
    TppTBCustomDockableWindow);
var
  lItem: TppTBXVisibilityToggleItem;
begin

  lItem := TppTBXVisibilityToggleItem.Create(Owner);
  lItem.Control := aToolbar;

  Items.Insert(aIndex, lItem);

  aToolbar.FreeNotification(Self);

end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.Notification}

procedure TppDesignToolbarPopupMenu.Notification(aComponent: TComponent;
    aOperation: TOperation);
begin

  inherited;

  if (csDestroying in ComponentState) then Exit;

  if (aOperation <> opRemove) then Exit;

  if (aComponent is TppTBCustomDockableWindow) then
    RemoveTool(TppTBCustomDockableWindow(aComponent));


end;

{------------------------------------------------------------------------------}
{ TppDesignToolbarMenu.RemoveToolbar}

procedure TppDesignToolbarPopupMenu.RemoveTool(aToolbar: TppTBCustomDockableWindow);
var
  liIndex: Integer;
begin

  if (csDestroying in ComponentState) then Exit;

  liIndex := IndexOfTool(aToolbar);

  if (liIndex >= 0) then
    Items[liIndex].Free;

end;


{------------------------------------------------------------------------------}
{ TppDesignPopupMenu.SetDesignControllers}

procedure TppDesignPopupMenu.SetDesignControllers(const Value: TppDesignControllers);
begin

  if FDesignControllers <> Value then
    begin
      FDesignControllers := Value;

      if (FDesignControllers <> nil) then
        begin
          FDialogController := FDesignControllers.DialogController;
          FDocumentController := FDesignControllers.DocumentController;
          FSelectionController := FDesignControllers.SelectionController;
          FWorkspaceController := FDesignControllers.WorkspaceController;
        end
      else
        begin
          FDialogController := nil;
          FDocumentController := nil;
          FSelectionController := nil;
          FWorkspaceController := nil;
        end;

    end;
    
end;

{******************************************************************************
 *
 **  Ruler Popup Menu
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDesignRulerPopupMenu.CreateItems}

procedure TppDesignRulerPopupMenu.CreateItems;
begin

  FUnits := TppDesignUnitsMenu.Create(Self);

  FUnitGroup := TppTBGroupItem.Create(Self);
  FUnitGroup.LinkSubitems := FUnits;

  Items.Add(FUnitGroup);

  AddSeparator();

  FHide := AddChildItem();
  FHide.AutoCheck := True;
  FHide.OnClick := ehHideItem_Click;

  LanguageChanged();

end;

{------------------------------------------------------------------------------}
{ TppDesignRulerPopupMenu.ehItem_Click}

procedure TppDesignRulerPopupMenu.ehHideItem_Click(Sender: TObject);
begin

  if (WorkspaceController <> nil) then
    begin
      WorkspaceController.WorkspaceView.HorizontalRulerArea.Visible := not(FHide.Checked);
      WorkspaceController.WorkspaceView.VerticalRulerArea.Visible := not(FHide.Checked);
    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignRulerPopupMenu.LanguageChanged}

procedure TppDesignRulerPopupMenu.LanguageChanged;
begin

  FUnits.LanguageChanged;

  FHide.Caption := ppLoadStr(225);

end;

{------------------------------------------------------------------------------}
{ TppDesignRulerPopupMenu.Popup}

procedure TppDesignRulerPopupMenu.Popup(X, Y: Integer);
begin

  if (WorkspaceController <> nil) then
    begin

      FHide.Checked := not(FWorkspaceController.WorkspaceView.HorizontalRulerArea.Visible);

      if (FWorkspaceController.Report <> nil) then
        FUnits.Units := FWorkspaceController.Report.Units;

    end;


  inherited;

end;

{------------------------------------------------------------------------------}
{ TppDesignRulerPopupMenu.SetDesignControllers}

procedure TppDesignRulerPopupMenu.SetDesignControllers(const Value: TppDesignControllers);
begin

  inherited;

  FUnits.DesignControllers := Value;

end;



{------------------------------------------------------------------------------}
{ TppMRUList.Create}

constructor TppMRUList.Create(aOwner: TComponent);
begin

  inherited;

  FTemplateItems := TppMRUTemplateItemCollection.Create;

end;

{------------------------------------------------------------------------------}
{ TppMRUList.Destroy}

destructor TppMRUList.Destroy;
begin

  FTemplateItems.Clear;
  FTemplateItems.Free;
  FTemplateItems := nil;

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppMRUList.AddTemplateItem}

procedure TppMRUList.AddTemplateItem(aTemplate: TppTemplate);
var
  lItem: TppMRUTemplateItem;
begin

  lItem := TppMRUTemplateItem.FromTemplate(aTemplate);

  AddTemplateItem(lItem);

end;

{------------------------------------------------------------------------------}
{ TppMRUList.AddTemplateItem}

procedure TppMRUList.AddTemplateItem(aTemplateItem: TppMRUTemplateItem);
var
  liIndex: Integer;
begin

  // delete existing item
  liIndex := FTemplateItems.IndexOf(aTemplateItem.Description);

  if (liIndex >= 0) then
    FTemplateItems.Delete(liIndex);

  // add new item
  Add(aTemplateItem.Description);

  FTemplateItems.Insert(aTemplateItem);

  // remove last item, if max exceeded
  if (FTemplateItems.Count > MaxItems) then
    FTemplateItems.RemoveLast;

end;

{------------------------------------------------------------------------------}
{ TppMRUList.LoadPreferences}

procedure TppMRUList.LoadPreferences(aIniStorage: TppIniStorage);
var
  liItem: Integer;
  lsCommaText: String;
begin

  AddFullPath := False; // aIniStorage.ReadBool('Last Reports Accessed', 'AddFullPath', True);
  HidePathExtension := aIniStorage.ReadBool('Last Reports Accessed', 'HidePathExtension', False);
  MaxItems := aIniStorage.ReadInteger('Last Reports Accessed', 'Max', 5);

  for liItem := MaxItems-1 downto 0  do
    begin

      lsCommaText := aIniStorage.ReadString('Last Reports Accessed','R'+IntToStr(liItem),'');

      try
        if (lsCommaText <> '') then
          AddTemplateItem(TppMRUTemplateItem.FromCommaText(lsCommaText));
      except
         // suppress exception
      end;

    end;


end;

{------------------------------------------------------------------------------}
{ TppMRUList.SavePreferences}

procedure TppMRUList.SavePreferences(aIniStorage: TppIniStorage);
var
  liIndex: Integer;
begin

//  aIniStorage.WriteBool('Last Reports Accessed', 'AddFullPath', AddFullPath);
  aIniStorage.WriteBool('Last Reports Accessed', 'HidePathExtension', HidePathExtension);
  aIniStorage.WriteInteger('Last Reports Accessed', 'Max', MaxItems);

  for liIndex := 0 to TemplateItems.Count-1 do
    aIniStorage.WriteString('Last Reports Accessed','R'+ IntToStr(liIndex), TemplateItems[liIndex].AsCommaText);

end;

{------------------------------------------------------------------------------}
{ TppSubMenuItem.DoPopup}

procedure TppDesignSubMenuItem.DoPopup(Sender: TppTBCustomItem; FromLink:
    Boolean);
begin

  if (DesignControllers <> nil) and (DesignControllers.Report <> nil) then
    UpdateStatus(TppBandedReport(DesignControllers.Report));

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppSubMenuItem.SetDesignControllers}

procedure TppDesignSubMenuItem.SetDesignControllers(const Value:
    TppDesignControllers);
begin

  
  if (FDesignControllers <> Value) then
    begin
      FDesignControllers := Value;

      if (FDesignControllers <> nil) then
        begin
          FDialogController := FDesignControllers.DialogController;
          FDocumentController := FDesignControllers.DocumentController;
          FSelectionController := FDesignControllers.SelectionController;
          FWorkspaceController := FDesignControllers.WorkspaceController;
        end
      else
        begin
          FDialogController := nil;
          FDocumentController := nil;
          FSelectionController := nil;
          FWorkspaceController := nil;
        end;

    end;

end;

{------------------------------------------------------------------------------}
{ TppSubMenuItem.UpdateStatus}

procedure TppDesignSubMenuItem.UpdateStatus(aReport: TppBandedReport);
begin

// descendants can add code here to update item status

end;

{------------------------------------------------------------------------------}
{ TppDesignThemeMenu.AddThemeItem}

procedure TppDesignThemeMenu.AddThemeItem(aThemeName: String);
var
  lItem: TppTBXCustomItem;
begin

  lItem := TppThemeManager.GetThemeSubMenu(aThemeName);

  if lItem <> nil then
    Add(lItem)
  else
    lItem := AddChildItem();

  lItem.Caption := aThemeName;
  lItem.Checked := (TppThemeManager.GetCurrentThemeName = aThemeName);
  lItem.AutoCheck := True;
  lItem.GroupIndex := 1;
  lItem.OnClick := ehItem_Click;



end;

{------------------------------------------------------------------------------}
{ TppDesignThemeMenu.CreateControls}

procedure TppDesignThemeMenu.CreateControls;
var
  lThemes: TStringList;
  liIndex: Integer;
begin

  lThemes := TStringList.Create;

  try
    TppThemeManager.GetThemeNames(lThemes);

    for liIndex := 0 to lThemes.Count - 1 do
      AddThemeItem(lThemes[liIndex]);
      
  finally
    lThemes.Free;
  end;

 LanguageChanged;

end;

{------------------------------------------------------------------------------}
{ TppDesignThemeMenu.ehItem_Click}

procedure TppDesignThemeMenu.ehItem_Click(Sender: TObject);
var
  lsThemeName: String;
begin

  lsThemeName := TppTBXItem(Sender).Caption;

  TppThemeManager.SetCurrentTheme(lsThemeName);

end;

{------------------------------------------------------------------------------}
{ TppDesignThemeMenu.LanguageChanged}

procedure TppDesignThemeMenu.LanguageChanged;
begin

  Caption := ppLoadStr(1156); {'Themes'}

end;



initialization
  TppToolbarFactory.Register(TppDesignerMenu);

finalization
  TppToolbarFactory.UnRegister(TppDesignerMenu);



end.

