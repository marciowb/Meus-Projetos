{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit ppRptExpCommon;

interface

uses
  Windows,
  Classes,
  SysUtils,
  Menus,
  ppComm,
  ppUtils,
  ppForms,

  ppTB2Dock,
  ppTB2Item,
  ppTBX,

  ppToolbarTBX,
  ppPopupMenuBase;


type
  TppFolderOptionType = (foAllowNew, foAllowDelete, foAllowRename, foAllowMove);
  TppItemOptionType = (ioAllowDesign, ioAllowNew, ioAllowDelete, ioAllowRename, ioAllowMove, ioAllowEmail);
  TppItemActionType = (iaOpenToDesign, iaOpenToPreview);

  TppFolderOptions = set of TppFolderOptionType;
  TppItemOptions = set of TppItemOptionType;


const
  itAllFolders = 0;
  itReport = 1;
  itCode = 2;
  itData = 3;
  itFolder = 4;
  itRecycleBin = -2;
  cDefaultFolderOptions = [foAllowNew, foAllowDelete, foAllowRename, foAllowMove];
  cDefaultItemOptions = [ioAllowDesign, ioAllowNew, ioAllowRename, ioAllowDelete, ioAllowMove, ioAllowEmail];


type  


  {@TppFolderFieldNames }
  TppFolderFieldNames = class(TPersistent)
    private
      FName: String;
      FFolderId: String;
      FParentId: String;
      FReportExplorer: TppCommunicator;

    public
      constructor Create(aExplorer: TppCommunicator);

      procedure Assign(Source: TPersistent); override;

      property ReportExplorer: TppCommunicator read FReportExplorer;

    published
      property FolderId: String read FFolderId write FFolderId;
      property Name: String read FName write FName;
      property ParentId: String read FParentId write FParentId;

  end; {class, TppFolderFieldNames}

  {@TppItemFieldNames }
  TppItemFieldNames = class(TPersistent)
    private
      FDeleted: String;
      FFolderId: String;
      FItemId: String;
      FModified: String;
      FName: String;
      FReportExplorer: TppCommunicator;
      FSize: String;
      FTemplate: String;
      FItemType: String;

    public
      constructor Create(aExplorer: TppCommunicator);

      procedure Assign(Source: TPersistent); override;

      property ReportExplorer: TppCommunicator read FReportExplorer;

    published
      property Deleted: String read FDeleted write FDeleted;
      property FolderId: String read FFolderId write FFolderId;
      property ItemId: String read FItemId write FItemId;
      property Modified: String read FModified write FModified;
      property Name: String read FName write FName;
      property Size: String read FSize write FSize;
      property Template: String read FTemplate write FTemplate;
      property ItemType: String read FItemType write FItemType;

  end; {class, TppItemFieldNames}

  {TppExplorerNewMenuTBX}
  TppExplorerNewMenu = class(TppSubMenuItem)
  private
    FFolder: TppTBXItem;
    FReport: TppTBXItem;
    FReportExplorer: TppCustomReportExplorer;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject);

  public
    constructor CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer); virtual;

    procedure LanguageChanged; override;

    property Folder: TppTBXItem read FFolder;
    property Report: TppTBXItem read FReport;

  end;

  {TppExplorerFileMenuTBX}
  TppExplorerFileMenu = class(TppSubMenuItem)
  private
    FOpen: TppTBXitem;
    FNew: TppExplorerNewMenu;
    FNewSeparator: TppTBXSeparatorItem;
    FPrint: TppTBXItem;
    FPrintPreview: TppTBXItem;
    FEmail: TppTBXItem;
    FErase: TppTBXItem;
    FRemoveSeparator: TppTBXSeparatorItem;
    FRename: TppTBXItem;
    FRenameSeparator: TppTBXSeparatorItem;
    FClose: TppTBXItem;
    FDesign: TppTBXItem;
    FOnItemClick: TNotifyEvent;
    FReportExplorer: TppCustomReportExplorer;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject); virtual;

  public
    constructor CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer); virtual;

    procedure LanguageChanged; override;

    property Open: TppTBXitem read FOpen;
    property New:  TppExplorerNewMenu read FNew;
    property NewSeparator: TppTBXSeparatorItem read FNewSeparator;
    property Print: TppTBXItem read FPrint;
    property PrintPreview: TppTBXItem read FPrintPreview;
    property Email: TppTBXItem read FEmail;
    property Erase: TppTBXItem read FErase;
    property RemoveSeparator: TppTBXSeparatorItem read FRemoveSeparator;
    property Rename: TppTBXItem read FRename;
    property RenameSeparator: TppTBXSeparatorItem read FRenameSeparator;
    property Close: TppTBXItem read FClose;
    property Design: TppTBXItem read FDesign;

  published
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;

  end;

  {TppExplorerViewMenuTBX}
  TppExplorerViewMenu = class(TppSubMenuItem)
  private
    FToolbar: TppTBXitem;
    FStatusbar: TppTBXItem;
    FList: TppTBXItem;
    FDetails: TppTBXItem;
    FOnItemClick: TNotifyEvent;
    FReportExplorer: TppCustomReportExplorer;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject); virtual;

  public
    constructor CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer); virtual;

    procedure LanguageChanged; override;

    property Toolbar: TppTBXitem read FToolbar;
    property Statusbar:  TppTBXItem read FStatusbar;
    property List: TppTBXItem read FList;
    property Details: TppTBXItem read FDetails;

  published
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;

  end;

  {TppExplorerHelpMenuTBX}
  TppExplorerHelpMenu = class(TppSubMenuItem)
  private
    FHelpTopics: TppTBXitem;
    FAbout: TppTBXItem;
    FOnItemClick: TNotifyEvent;
    FReportExplorer: TppCustomReportExplorer;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject); virtual;

  public
    constructor CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer); virtual;

    procedure LanguageChanged; override;

    property HelpTopics: TppTBXitem read FHelpTopics;
    property About:  TppTBXItem read FAbout;

  published
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;

  end;

  {TppExplorerMenu }
  TppExplorerMenu = class(TppMenubar)
    private
      FFileMenu: TppExplorerFileMenu;
      FViewMenu: TppExplorerViewMenu;
      FHelpMenu: TppExplorerHelpMenu;
      FReportExplorer: TppCustomReportExplorer;

    protected
      procedure CreateItems; override;

    public
      constructor Create(Owner: TComponent); override;
      constructor CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer); virtual;

      procedure LanguageChanged; override;

      property FileMenu: TppExplorerFileMenu read FFileMenu;
      property ViewMenu: TppExplorerViewMenu read FViewMenu;
      property HelpMenu: TppExplorerHelpMenu read FHelpMenu;

  end; {class, TppExplorerMenu}

  {TppExplorerPopupMenu}
  TppExplorerPopupMenu = class(TppTBXPopupMenu)
    private
      FItemOrder: TStringList;
      FLanguageIndex: Longint;
      FReportExplorer: TppCustomReportExplorer;

    protected
      procedure CreateMenuItems; virtual; abstract;
      procedure SetLanguageIndex(aLanguageIndex: Integer); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      constructor CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer); virtual;
      destructor Destroy; override;

      function AddItem(aGroupIndex: Integer; const aItemName, aCaption: String; aStringId: Longint): TppTBXItem;
      function AddSeparator(aGroupIndex: Integer; aItemName: string): TppTBXSeparatorItem;
      function AddSubMenuItem(aGroupIndex: Integer; const aItemName, aCaption: String; aStringId: Longint): TppTBXSubMenuItem;

      property LanguageIndex: Longint read FLanguageIndex write SetLanguageIndex;
      property ReportExplorer: TppCustomReportExplorer read FReportExplorer;

  end;

  {TppFoldersPopupMenu}
  TppFoldersPopupMenu = class(TppExplorerPopupMenu)
  private
    FOpen: TppTBXItem;
    FEmptyRecycleBin: TppTBXItem;
    FNewFolder: TppTBXItem;
    FNewReport: TppTBXItem;
    FErase: TppTBXItem;
    FRename: TppTBXItem;
    FOnItemClick: TNotifyEvent;

  protected
    procedure CreateMenuItems; override;
    procedure ehItem_Click(Sender: TObject);

  public
    property Open: TppTBXItem read FOpen;
    property EmptyRecycleBin: TppTBXItem read FEmptyRecycleBin;
    property NewFolder: TppTBXItem read FNewFolder;
    property NewReport: TppTBXItem read FNewReport;
    property Erase: TppTBXItem read FErase;
    property Rename: TppTBXItem read FRename;

  published
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;

  end;

  {TppReportsPopupMenu}
  TppReportsPopupMenu = class(TppExplorerPopupMenu)
  private
    FOpen: TppTBXItem;
    FNewFolder: TppTBXItem;
    FNewReport: TppTBXItem;
    FDesign: TppTBXItem;
    FPrint: TppTBXItem;
    FPrintPreview: TppTBXItem;
    FEmail: TppTBXItem;
    FView: TppTBXSubMenuItem;
    FList: TppTBXItem;
    FDetails: TppTBXItem;
    FErase: TppTBXItem;
    FOnItemClick: TNotifyEvent;
    FRename: TppTBXItem;

  protected
    procedure CreateMenuItems; override;
    procedure ehItem_Click(Sender: TObject);

  public
    property Open: TppTBXItem read FOpen;
    property NewFolder: TppTBXItem read FNewFolder;
    property NewReport: TppTBXItem read FNewReport;
    property Design: TppTBXItem read FDesign;
    property Print: TppTBXItem read FPrint;
    property PrintPreview: TppTBXItem read FPrintPreview;
    property Email: TppTBXItem read FEmail;
    property View: TppTBXSubMenuItem read FView;
    property List: TppTBXItem read FList;
    property Details: TppTBXItem read FDetails;
    property Erase: TppTBXItem read FErase;
    property Rename: TppTBXItem read FRename;

  published
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;
  end;

  {TppExplorerToolbar}
  TppExplorerToolbar = class(TppToolbar)
  private
    FDesign: TppTBXItem;
    FDetails: TppTBXItem;
    FEmail: TppTBXItem;
    FErase: TppTBXItem;
    FList: TppTBXItem;
    FNewFolder: TppTBXItem;
    FNewFolderSeparator: TppTBXSeparatorItem;
    FNewReport: TppTBXItem;
    FNewReportSeparator: TppTBXSeparatorItem;
    FNewReportTopSpacer: TppTBXItem;
    FNewReportBottomSpacer: TppTBXItem;
    FOpen: TppTBXItem;
    FPrint: TppTBXItem;
    FPrintPreview: TppTBXItem;
    FUpOneLevel: TppTBXItem;
    FReportExplorer: TppCustomReportExplorer;

  protected
    procedure CreateItems; override;
    procedure ehItem_Click(Sender: TObject);

  public
    constructor Create(aOwner: TComponent); override;
    constructor CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer); virtual;
    procedure LanguageChanged; override;

    property Design: TppTBXItem read FDesign;
    property Details: TppTBXItem read FDetails;
    property Email: TppTBXItem read FEmail;
    property Erase: TppTBXItem read FErase;
    property List: TppTBXItem read FList;
    property NewFolder: TppTBXItem read FNewFolder;
    property NewFolderSeparator: TppTBXSeparatorItem read FNewFolderSeparator;
    property NewReport: TppTBXItem read FNewReport;
    property NewReportSeparator: TppTBXSeparatorItem read FNewReportSeparator;
    property NewReportTopSpacer: TppTBXItem read FNewReportTopSpacer;
    property NewReportBottomSpacer: TppTBXItem read FNewReportBottomSpacer;
    property Open: TppTBXItem read FOpen;
    property Print: TppTBXItem read FPrint;
    property PrintPreview: TppTBXItem read FPrintPreview;
    property UpOneLevel: TppTBXItem read FUpOneLevel;
  end;


  function ppGetTypeExtension(aItemType: Integer): String;
  function ppGetTypeDesc(aItemType: Integer): String;

implementation

uses
  ppToolResources;

{------------------------------------------------------------------------------}
{ TppReportExplorer.ppGetTypeExtension }

function ppGetTypeExtension(aItemType: Integer): String;
begin

  case aItemType of
    itReport: Result := 'rtm';
    itCode:   Result := 'ctm';
    itData:   Result := 'dtm';
  end;

end; {function, ppGetTypeExtension}

{------------------------------------------------------------------------------}
{ TppReportExplorer.ppGetTypeDesc }

function ppGetTypeDesc(aItemType: Integer): String;
begin

  case aItemType of
    itReport: Result := ppLoadStr(579); {Report}
    itFolder: Result := ppLoadStr(554); {Folder}
    itData:   Result := ppLoadStr(546); {Data Module}
    itCode: Result   := ppLoadStr(535); {Code Module}
  end;

end; {function, ppGetTypeDesc}


{******************************************************************************
 *
 ** F O L D E R   F I E L D   N A M E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppFolderFieldNames.Create }

constructor TppFolderFieldNames.Create(aExplorer: TppCommunicator);
begin

  inherited Create;

  FReportExplorer := aExplorer;

  FFolderId := 'FolderId';
  FName := 'Name';
  FParentId := 'ParentId';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppFolderFieldNames.Assign }

procedure TppFolderFieldNames.Assign(Source: TPersistent);
var
  lSource: TppFolderFieldNames;
begin

  if not(Source is TppFolderFieldNames) then Exit;

  lSource := TppFolderFieldNames(Source);

  FFolderId := lSource.FolderId;
  FName := lSource.Name;
  FParentId := lSource.ParentId;

end; {procedure, Assign}

{******************************************************************************
 *
 ** I T E M   F I E L D   N A M E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppItemFieldNames.Create }

constructor TppItemFieldNames.Create(aExplorer: TppCommunicator);
begin

  inherited Create;

  FReportExplorer := aExplorer;

  FDeleted := 'Deleted';
  FFolderId := 'FolderId';
  FItemId := 'ItemId';
  FItemType := 'ItemType';
  FModified := 'Modified';
  FName := 'Name';
  FSize := 'Size';
  FTemplate := 'Template';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppItemFieldNames.Assign }

procedure TppItemFieldNames.Assign(Source: TPersistent);
var
  lSource: TppItemFieldNames;
begin

  if not(Source is TppItemFieldNames) then Exit;

  lSource := TppItemFieldNames(Source);

  FDeleted := lSource.Deleted;
  FFolderId := lSource.FolderId;
  FItemId := lSource.ItemId;
  FItemType := lSource.ItemType;
  FModified := lSource.Modified;
  FName := lSource.Name;
  FSize := lSource.Size;
  FTemplate := lSource.Template;

end; {procedure, Assign}


{******************************************************************************
 *
 ** F I L E   M E N U
 *
{******************************************************************************}

procedure TppExplorerFileMenu.CreateControls;
begin
  FOpen := AddChildItem();
  FOpen.ShortCut := Menus.ShortCut(Ord('O'), [ssCtrl]); // Ctrl+O
  FOpen.ImageIndex := ToolImageList.AddTool('PPOPEN');
  FOpen.OnClick := ehItem_Click;

  AddSeparator();

  FNew := TppExplorerNewMenu.CreateMenu(Owner, FReportExplorer);
  Add(FNew);

  FNewSeparator := AddSeparator();

  FDesign := AddChildItem();
  FDesign.ImageIndex := ToolImageList.AddTool('PPDESIGN');
  FDesign.OnClick := ehItem_Click;

  FPrint := AddChildItem();
  FPrint.ShortCut := Menus.ShortCut(Ord('P'), [ssCtrl]); // Ctrl+P
  FPrint.ImageIndex := ToolImageList.AddTool('PPPRINT');
  FPrint.OnClick := ehItem_Click;

  FPrintPreview := AddChildItem();
  FPrintPreview.ImageIndex := ToolImageList.AddTool('PPPRINTPREVIEW');
  FPrintPreview.OnClick := ehItem_Click;

  FEmail := AddChildItem();
  FEmail.ImageIndex := ToolImageList.AddTool('PPEMAIL');
  FEmail.OnClick := ehItem_Click;

  AddSeparator();

  FErase := AddChildItem();
  FErase.ShortCut := Menus.ShortCut(VK_Delete, [ssCtrl]); // Ctrl+Del
  FErase.ImageIndex := ToolImageList.AddTool('PPDELETE');
  FErase.OnClick := ehItem_Click;

  FRemoveSeparator := AddSeparator();
  FRemoveSeparator.Visible := False;

  FRename := AddChildItem();
  FRename.OnClick := ehItem_Click;

  FRenameSeparator := AddSeparator();

  FClose := AddChildItem();
  FClose.OnClick := ehItem_Click;

end;

constructor TppExplorerFileMenu.CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer);
begin
  FReportExplorer := aReportExplorer;

  Create(aOwner);

end;

procedure TppExplorerFileMenu.ehItem_Click(Sender: TObject);
begin
  if (Sender = FOpen) then
    FReportExplorer.ehFileOpenClick(Sender)

  else if (Sender = FDesign) then
    FReportExplorer.ehFileDesignClick(Sender)

  else if (Sender = FPrint) then
    FReportExplorer.ehFilePrintClick(Sender)

  else if (Sender = FPrintPreview) then
    FReportExplorer.ehFilePrintPreviewClick(Sender)

  else if (Sender = FPrintPreview) then
    FReportExplorer.ehFileEmailClick(Sender)

  else if (Sender = FEmail) then
    FReportExplorer.ehFileEmailClick(Sender)

  else if (Sender = FErase) then
    FReportExplorer.ehFileDeleteClick(Sender)

  else if (Sender = FRename) then
    FReportExplorer.ehFileRenameClick(Sender)

  else if (Sender = FClose) then
    FReportExplorer.ehFileCloseClick(Sender);

end;

procedure TppExplorerFileMenu.LanguageChanged;
begin
  Caption := ppLoadStr(131);

  FOpen.Caption         := ppLoadStr(134);
  FNew.LanguageChanged();
  FDesign.Caption       := ppLoadStr(185);
  FPrint.Caption        := ppLoadStr(136);
  FPrintPreview.Caption := ppLoadStr(576);
  FEmail.Caption        := ppLoadStr(1093);
  FErase.Caption        := ppLoadStr(124);
  FRename.Caption       := ppLoadStr(512);
  FClose.Caption        := ppLoadStr(132);

end;

{******************************************************************************
 *
 ** N E W   M E N U
 *
{******************************************************************************}

procedure TppExplorerNewMenu.CreateControls;
begin
  FFolder := AddChildItem();
  FFolder.ImageIndex := ToolImageList.AddTool('PPNEWFOLDER');
  FFolder.OnClick := ehItem_Click;

  FReport := AddChildItem();
  FReport.ImageIndex := ToolImageList.AddTool('PPNEW');
  FReport.OnClick := ehItem_Click;

end;

constructor TppExplorerNewMenu.CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer);
begin
  Create(aOwner);

  FReportExplorer := aReportExplorer;
  
end;

procedure TppExplorerNewMenu.ehItem_Click(Sender: TObject);
begin
  if (Sender = FFolder) then
    FReportExplorer.ehFileNewFolderClick(Sender)

  else if (Sender = FReport) then
    FReportExplorer.ehFileNewReportClick(Sender)

end;

procedure TppExplorerNewMenu.LanguageChanged;
begin
  Caption := ppLoadStr(133);

  FFolder.Caption := ppLoadStr(509);
  FReport.Caption := ppLoadStr(579);

end;

{******************************************************************************
 *
 ** V I E W   M E N U
 *
{******************************************************************************}

procedure TppExplorerViewMenu.CreateControls;
begin
  FToolbar := AddChildItem();
  FToolbar.Checked := True;
  FToolbar.OnClick := ehItem_Click;

  FStatusbar := AddChildItem();
  FStatusbar.Checked := True;
  FStatusbar.OnClick := ehItem_Click;

  AddSeparator();

  FList := AddChildItem();
  FList.ImageIndex := ToolImageList.AddTool('PPLIST');
  FList.GroupIndex := 1;
  FList.Checked := True;
  FList.OnClick := ehItem_Click;

  FDetails := AddChildItem();
  FDetails.ImageIndex := ToolImageList.AddTool('PPDETAILS');
  FDetails.GroupIndex := 1;
  FDetails.OnClick := ehItem_Click;
end;

constructor TppExplorerViewMenu.CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer);
begin
  Create(aOwner);

  FReportExplorer := aReportExplorer;

end;

procedure TppExplorerViewMenu.ehItem_Click(Sender: TObject);
begin

  if (Sender = FToolbar) then
    FReportExplorer.ehViewToolbarClick(Sender)

  else if (Sender = FStatusbar) then
    FReportExplorer.ehViewStatusBarClick(Sender)

  else if (Sender = FList) then
    FReportExplorer.ehViewListClick(Sender)

  else if (Sender = FDetails) then
    FReportExplorer.ehViewDetailsClick(Sender);

end;

procedure TppExplorerViewMenu.LanguageChanged;
begin
  Caption := ppLoadStr(155);

  FToolbar.Caption := ppLoadStr(514);
  FStatusbar.Caption := ppLoadStr(513);
  FList.Caption := ppLoadStr(510);
  FDetails.Caption := ppLoadStr(508);

end;

{******************************************************************************
 *
 ** H E L P  M E N U
 *
{******************************************************************************}

procedure TppExplorerHelpMenu.CreateControls;
begin
  FHelpTopics := AddChildItem();
  FHelpTopics.ImageIndex := ToolImageList.AddTool('PPHELP');
  FHelpTopics.OnClick := ehItem_Click;

  FAbout := AddChildItem();
  FAbout.OnClick := ehItem_Click;

end;

constructor TppExplorerHelpMenu.CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer);
begin
  Create(aOwner);

  FReportExplorer := aReportExplorer

end;

procedure TppExplorerHelpMenu.ehItem_Click(Sender: TObject);
begin
  if (Sender = FHelpTopics) then
    FReportExplorer.ehHelpTopicsClick(Sender)

  else if (Sender = FAbout) then
    FReportExplorer.ehHelpAboutClick(Sender);

end;

procedure TppExplorerHelpMenu.LanguageChanged;
begin
  Caption := ppLoadStr(142);

  FHelpTopics.Caption := ppLoadStr(144);
  FAbout.Caption := ppLoadStr(143);

end;

{******************************************************************************
 *
 ** M A I N  M E N U
 *
{******************************************************************************}

constructor TppExplorerMenu.Create(Owner: TComponent);
begin
  inherited;

  Name := 'Menu'; // do not localize
  MenuBar := True;

  DockMode := dmCannotFloatOrChangeDocks;

end;

procedure TppExplorerMenu.CreateItems;
begin
  FFileMenu := TppExplorerFileMenu.CreateMenu(nil, FReportExplorer);
  FFileMenu.GroupIndex := 10;
  Items.Add(FFileMenu);

  FViewMenu := TppExplorerViewMenu.CreateMenu(nil, FReportExplorer);
  FViewMenu.GroupIndex := 20;
  Items.Add(FViewMenu);

  FHelpMenu := TppExplorerHelpMenu.CreateMenu(nil, FReportExplorer);
  FHelpMenu.GroupIndex := 30;
  Items.Add(FHelpMenu);

  LanguageChanged();

end;

constructor TppExplorerMenu.CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer);
begin
  FReportExplorer := aReportExplorer;

  Create(aOwner);

end;

procedure TppExplorerMenu.LanguageChanged;
var
  liIndex: Integer;
begin

  for liIndex := 0 to Items.Count-1 do
    if (Items[liIndex] is TppSubMenuItem) then
      TppSubMenuItem(Items[liIndex]).LanguageChanged();

end;

{******************************************************************************
 *
 ** E X P L O R E R   P O P U P   M E N U S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppExplorerPopupMenu.Create }

constructor TppExplorerPopupMenu.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  Images := ToolImageList;
  FItemOrder := TStringList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppExplorerPopupMenu.CreateMenu }

constructor TppExplorerPopupMenu.CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer);
begin
  FReportExplorer := aReportExplorer;

  Create(aOwner);

end; {constructor, CreateMenu}

{------------------------------------------------------------------------------}
{ TppExplorerPopupMenu.Destroy }

destructor TppExplorerPopupMenu.Destroy;
begin

  FItemOrder.Free;

  inherited Destroy;


end; {destructor, Create}

{------------------------------------------------------------------------------}
{ TppExplorerPopupMenu.AddItem }

function TppExplorerPopupMenu.AddItem(aGroupIndex: Integer; const aItemName, aCaption: String; aStringId: Longint): TppTBXItem;
var
  liIndex: Integer;
  lsSortID: String;
begin

  Result := nil;

  if (FindComponent(aItemName) <> nil) then Exit;

  lsSortID := Format('%8d',[aGroupIndex]) + aItemName;

  liIndex := FItemOrder.Add(lsSortID);

  Result          := TppTBXItem.Create(Self);
  Result.Name     := aItemName;
  Result.Tag      := aStringId;
  Result.ImageIndex := ToolImageList.AddIcon('PP' + UpperCase(aItemName));

  if (aCaption = '') and (aStringId <> 0) then
    Result.Caption := ppLoadStr(aStringId)
  else
    Result.Caption  := aCaption;

  Items.Insert(liIndex, Result);

end; {function, AddItem}

{------------------------------------------------------------------------------}
{ TppExplorerPopupMenu.AddSeparator }

function TppExplorerPopupMenu.AddSeparator(aGroupIndex: Integer; aItemName: string): TppTBXSeparatorItem;
var
  liIndex: Integer;
  lsSortID: String;
begin

  Result := nil;

  if (FindComponent(aItemName) <> nil) then Exit;

  lsSortID := Format('%8d',[aGroupIndex]) + aItemName;

  liIndex := FItemOrder.Add(lsSortID);

  Result := TppTBXSeparatorItem.Create(Self);
  Result.Name     := aItemName;

  Items.Insert(liIndex, Result);

end;

{------------------------------------------------------------------------------}
{ TppExplorerPopupMenu.AddItem }

function TppExplorerPopupMenu.AddSubMenuItem(aGroupIndex: Integer; const aItemName, aCaption: String; aStringId: Longint): TppTBXSubMenuItem;
var
  liIndex: Integer;
  lsSortID: String;
begin

  Result := nil;

  if (FindComponent(aItemName) <> nil) then Exit;

  lsSortID := Format('%8d',[aGroupIndex]) + aItemName;

  liIndex := FItemOrder.Add(lsSortID);

  Result          := TppTBXSubMenuItem.Create(Self);
  Result.Name     := aItemName;
  Result.Tag      := aStringId;
  Result.ImageIndex := ToolImageList.AddIcon('PP' + UpperCase(aItemName));

  if (aCaption = '') and (aStringId <> 0) then
    Result.Caption := ppLoadStr(aStringId)
  else
    Result.Caption  := aCaption;

  Items.Insert(liIndex, Result);

end; {function, AddItem}

{------------------------------------------------------------------------------}
{ TppExplorerPopupMenu.SetLanguageIndex }

procedure TppExplorerPopupMenu.SetLanguageIndex(aLanguageIndex: Integer);
begin

  if (FLanguageIndex <> aLanguageIndex) or (Items.Count = 0) then
    begin

      FLanguageIndex := aLanguageIndex;

      {clear menu items and recreate}
      Items.Clear;

      FItemOrder.Clear;

      CreateMenuItems;
    end;

end; {procedure, SetLanguageIndex}

{******************************************************************************
 *
 ** F O L D E R S   P O P U P   M E N U
 *
{******************************************************************************}

procedure TppFoldersPopupMenu.CreateMenuItems;
begin

  FOpen := AddItem(30, 'Open', '', 134);
  FOpen.OnClick := ehItem_Click;

  FEmptyRecycleBin := AddItem(30, 'EmptyRecycleBin', '', 595);
  FEmptyRecycleBin.OnClick := ehItem_Click;
  FEmptyRecycleBin.Visible := False;

  AddSeparator(30, '');

  FNewFolder := AddItem(30, 'NewFolder', '', 570);
  FNewFolder.OnClick := ehItem_Click;

  FNewReport := AddItem(30, 'New', '', 571);
  FNewReport.OnClick := ehItem_Click;

  AddSeparator(30, '');

  FErase := AddItem(30, 'Delete', '', 124);
  FErase.OnClick := ehItem_Click;

  FRename := AddItem(30, 'Rename', '', 512);
  FRename.OnClick := ehItem_Click;

end;

procedure TppFoldersPopupMenu.ehItem_Click(Sender: TObject);
begin
  if (Sender = FOpen) then
    ReportExplorer.ehFileOpenClick(Sender)

  else if (Sender = FEmptyRecycleBin) then
    ReportExplorer.ehEmptyRecycleBinClick(Sender)

  else if (Sender = FNewFolder) then
    ReportExplorer.ehFileNewFolderClick(Sender)

  else if (Sender = FNewReport) then
    ReportExplorer.ehFileNewReportClick(Sender)

  else if (Sender = FErase) then
    ReportExplorer.ehFileDeleteClick(Sender)

  else if (Sender = FRename) then
    ReportExplorer.ehFileRenameClick(Sender);

end;

{******************************************************************************
 *
 ** R E P O R T S   P O P U P   M E N U
 *
{******************************************************************************}

procedure TppReportsPopupMenu.CreateMenuItems;
begin
  FOpen := AddItem(30, 'Open', '', 134);
  FOpen.OnClick := ehItem_Click;

  AddSeparator(30, '');

  FNewFolder := AddItem(30, 'NewFolder', '', 570);
  FNewFolder.OnClick := ehItem_Click;

  FNewReport := AddItem(30, 'New', '', 571);
  FNewReport.OnClick := ehItem_Click;

  AddSeparator(30, '');

  FDesign := AddItem(30, 'Design', '', 185);
  FDesign.OnClick := ehItem_Click;

  FPrint := AddItem(30, 'Print', '', 136);
  FPrint.OnClick := ehItem_Click;

  FPrintPreview := AddItem(30, 'PrintPreview', '', 576);
  FPrintPreview.OnClick := ehItem_Click;

  FEmail := AddItem(30, 'Email', '', 1093);
  FEmail.OnClick := ehItem_Click;

  AddSeparator(30, '');

  FView := AddSubMenuItem(30, 'View', '', 155);

  FList := TppTBXItem.Create(self);
  FList.GroupIndex := 31;
  FList.Caption := ppLoadStr(510);
  FList.ImageIndex := ToolImageList.AddIcon('PPLIST');
  FList.OnClick := ehItem_Click;

  FDetails := TppTBXItem.Create(self);
  FDetails.GroupIndex := 31;
  FDetails.Caption := ppLoadStr(508);
  FDetails.ImageIndex := ToolImageList.AddIcon('PPDETAILS');
  FDetails.OnClick := ehItem_Click;

  FView.Add(FList);
  FView.Add(FDetails);

  AddSeparator(30, '');

  FErase := AddItem(30, 'Delete', '', 124);
  FErase.OnClick := ehItem_Click;

  FRename := AddItem(30, 'Rename', '', 512);
  FRename.OnClick := ehItem_Click;

end;

procedure TppReportsPopupMenu.ehItem_Click(Sender: TObject);
begin
  if (Sender = FOpen) then
    ReportExplorer.ehFileOpenClick(Sender)

  else if (Sender = FNewFolder) then
    ReportExplorer.ehFileNewFolderClick(Sender)

  else if (Sender = FNewReport) then
    ReportExplorer.ehFileNewReportClick(Sender)

  else if (Sender = FDesign) then
    ReportExplorer.ehFileDesignClick(Sender)

  else if (Sender = FPrint) then
    ReportExplorer.ehFilePrintClick(Sender)

  else if (Sender = FPrintPreview) then
    ReportExplorer.ehFilePrintPreviewClick(Sender)

  else if (Sender = FEmail) then
    ReportExplorer.ehFileEmailClick(Sender)

  else if (Sender = FList) then
    ReportExplorer.ehViewListClick(Sender)

  else if (Sender = FDetails) then
    ReportExplorer.ehViewDetailsClick(Sender)

  else if (Sender = FErase) then
    ReportExplorer.ehFileDeleteClick(Sender)

  else if (Sender = FRename) then
    ReportExplorer.ehFileRenameClick(Sender);
end;


{******************************************************************************
 *
 ** E X P L O R E R   T O O L B A R
 *
{******************************************************************************}

constructor TppExplorerToolbar.Create(aOwner: TComponent);
begin
  inherited;

  DockMode := dmCannotFloatOrChangeDocks;

end;

constructor TppExplorerToolbar.CreateMenu(aOwner: TComponent; aReportExplorer: TppCustomReportExplorer);
begin
  FReportExplorer := aReportExplorer;

  Create(aOwner);

end;

procedure TppExplorerToolbar.CreateItems;
begin
  FUpOneLevel := AddButton();
  FUpOneLevel.ImageIndex := ToolImageList.AddIcon('PPUPONEFOLDER');
  FUpOneLevel.OnClick := ehItem_Click;

  FNewFolder := AddButton();
  FNewFolder.ImageIndex := ToolImageList.AddIcon('PPNEWFOLDER');
  FNewFolder.OnClick := ehItem_Click;

  AddSpacer(9);
  FNewFolderSeparator := AddSeparator();
  AddSpacer(9);

  FNewReport := AddButton();
  FNewReport.ImageIndex := ToolImageList.AddIcon('PPNEW');
  FNewReport.OnClick := ehItem_Click;

  FOpen := AddButton();
  FOpen.ImageIndex := ToolImageList.AddIcon('PPOPEN');
  FOpen.OnClick := ehItem_Click;

  FNewReportTopSpacer := AddSpacer(9);
  FNewReportSeparator := AddSeparator();
  FNewReportBottomSpacer := AddSpacer(9);

  FDesign := AddButton();
  FDesign.ImageIndex := ToolImageList.AddIcon('PPDESIGN');
  FDesign.OnClick := ehItem_Click;

  FPrint := AddButton();
  FPrint.ImageIndex := ToolImageList.AddIcon('PPPRINT');
  FPrint.OnClick := ehItem_Click;

  FPrintPreview := AddButton();
  FPrintPreview.ImageIndex := ToolImageList.AddIcon('PPPRINTPREVIEW');
  FPrintPreview.OnClick := ehItem_Click;

  FEmail := AddButton();
  FEmail.ImageIndex := ToolImageList.AddIcon('PPEMAIL');
  FEmail.OnClick := ehItem_Click;

  AddSpacer(9);
  AddSeparator();
  AddSpacer(9);

  FErase := AddButton();
  FErase.ImageIndex := ToolImageList.AddIcon('PPDELETE');
  FErase.OnClick := ehItem_Click;

  AddSpacer(9);
  AddSeparator();
  AddSpacer(9);

  FList := AddButton();
  FList.ImageIndex := ToolImageList.AddIcon('PPLIST');
  FList.OnClick := ehItem_Click;

  FDetails := AddButton();
  FDetails.ImageIndex := ToolImageList.AddIcon('PPDETAILS');
  FDetails.OnClick := ehItem_Click;

end;

procedure TppExplorerToolbar.ehItem_Click(Sender: TObject);
begin
  if (Sender = FUpOneLevel) then
    FReportExplorer.ehUpOneLevelClick(Sender)

  else if (Sender = FNewFolder) then
    FReportExplorer.ehFileNewFolderClick(Sender)

  else if (Sender = FOpen) then
    FReportExplorer.ehFileOpenClick(Sender)

  else if (Sender = FNewReport) then
    FReportExplorer.ehFileNewReportClick(Sender)

  else if (Sender = FDesign) then
    FReportExplorer.ehFileDesignClick(Sender)

  else if (Sender = FPrint) then
    FReportExplorer.ehFilePrintClick(Sender)

  else if (Sender = FPrintPreview) then
    FReportExplorer.ehFilePrintPreviewClick(Sender)

  else if (Sender = FEmail) then
    FReportExplorer.ehFileEmailClick(Sender)

  else if (Sender = FList) then
    FReportExplorer.ehViewListClick(Sender)

  else if (Sender = FDetails) then
    FReportExplorer.ehViewDetailsClick(Sender)

  else if (Sender = FErase) then
    FReportExplorer.ehFileDeleteClick(Sender);

end;

procedure TppExplorerToolbar.LanguageChanged;
var
  lsHint: String;
begin

  FUpOneLevel.Hint   := ppLoadStr(589);
  FNewFolder.Hint    := ppLoadStr(570);
  FNewReport.Hint    := ppLoadStr(571);

  lsHint := StringReplace(ppLoadStr(134), '&', '', []);
  lsHint := StringReplace(lsHint, '...', '', []);
  FOpen.Hint         := lsHint;
  FDesign.Hint       := ppLoadStr(185);
  FPrint.Hint        := StringReplace(ppLoadStr(136), '&', '', []);
  FPrintPreview.Hint := StringReplace(ppLoadStr(576), '&', '', []);
  FEmail.Hint        := ppLoadStr(1093);
  FErase.Hint        := StringReplace(ppLoadStr(124), '&', '', []);
  FList.Hint         := StringReplace(ppLoadStr(510), '&', '', []);
  FDetails.Hint      := StringReplace(ppLoadStr(508), '&', '', []);

end;





end.
