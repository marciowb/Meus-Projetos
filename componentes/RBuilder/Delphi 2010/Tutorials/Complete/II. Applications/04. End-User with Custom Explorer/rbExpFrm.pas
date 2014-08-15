{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit rbExpFrm;

interface

{$I ppIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, Buttons, ComCtrls, ImgList,
  ppUtils, ppRptExp, ppForms, ppIniStorage, ppRptExpCommon, ppTBX, ppToolbarTBX;

type

  {@TrbReportExplorerForm }
  TrbReportExplorerForm = class(TppCustomReportExplorer)
    sbrExplorer: TStatusBar;
    pnlFolders: TPanel;
    pnlFolderTitle: TPanel;
    trvFolders: TTreeView;
    pnlReports: TPanel;
    pnlReportTitle: TPanel;
    splViews: TSplitter;
    procedure trvFoldersEdited(Sender: TObject; Node: TTreeNode; var S: String);

    procedure trvFoldersCollapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
    procedure trvFoldersDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure trvFoldersDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure trvFoldersEditing(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
    procedure ehFoldersPopup(Sender: TObject);
    procedure trvFoldersChange(Sender: TObject; Node: TTreeNode);
    
  private
    FListView: TppItemList;
    FMenuBar: TppExplorerMenu;
    FMenuDock: TppDock;
    FToolbar: TppExplorerToolbar;
    FFoldersPopupMenu: TppFoldersPopupMenu;
    FReportsPopupMenu: TppReportsPopupMenu;
    FReportExplorer: TppReportExplorer;
    FSpeedButtons: TList;
    FAllFoldersNode: TTreeNode;
    FRecycleBinNode: TTreeNode;

    procedure Design;
    procedure EnableFolderOptions;
    procedure EnableItemOptions;
    function  FindDataInTreeView(aTreeView: TTreeView; aData: Integer): TTreeNode;
    function  FindNearestNode(aNode: TTreeNode): TTreeNode;
    procedure FoldersSelectionChange;
    procedure InitializeOptions;
    procedure InitializeIcons;
    procedure ListDoubleClickEvent(Sender: TObject);
    procedure ListDragOverEvent(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ListFolderChangeEvent(Sender: TObject);
    procedure ListRenameFolderEvent(Sender: TObject; aFolderId: Integer; const aNewName: String);
    procedure ListSelectionChangeEvent(Sender: TObject);
    procedure LoadMainMenu;
    procedure LoadPopupMenus;
    procedure LoadStateInfo;
    procedure OpenItem;
    procedure Print;
    procedure PrintPreview;
    procedure SaveStateInfo;
    procedure SelectFolder(aFolderId: Integer);
    procedure SetViewStyle(Value: Boolean);
    procedure SetViewToolbar(Value: Boolean);
    procedure SetViewStatusBar(Value: Boolean);
    procedure UpdateRecycleBin;
    procedure UpdateStatusBar;
    procedure UpdateTreeView;

  protected
    procedure LanguageChanged; override;

    function  GetReportExplorer: TComponent; override;
    procedure SetReportExplorer(aComponent: TComponent); override;

    property AllFoldersNode: TTreeNode read FAllFoldersNode;
    property ListView: TppItemList read FListView;
    property RecycleBinNode: TTreeNode read FRecycleBinNode;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure ehFilePrintClick(Sender: TObject); override;
    procedure ehFilePrintPreviewClick(Sender: TObject); override;
    procedure ehFileOpenClick(Sender: TObject); override;
    procedure ehFileNewReportClick(Sender: TObject); override;
    procedure ehFileDeleteClick(Sender: TObject); override;
    procedure ehViewListClick(Sender: TObject); override;
    procedure ehViewDetailsClick(Sender: TObject); override;
    procedure ehViewToolbarClick(Sender: TObject); override;
    procedure ehViewStatusBarClick(Sender: TObject); override;
    procedure ehFileCloseClick(Sender: TObject); override;
    procedure ehHelpAboutClick(Sender: TObject); override;
    procedure ehHelpTopicsClick(Sender: TObject); override;
    procedure ehFileNewFolderClick(Sender: TObject); override;
    procedure ehFileRenameClick(Sender: TObject); override;
    procedure ehUpOneLevelClick(Sender: TObject); override;
    procedure ehFileDesignClick(Sender: TObject); override;
    procedure ehEmptyRecycleBinClick(Sender: TObject); override;

    procedure CreateParams(var Params: TCreateParams); override;

    procedure Initialize; override;
    procedure Refresh; override;

    property FoldersPopupMenu: TppFoldersPopupMenu read FFoldersPopupMenu;
    property MenuBar: TppExplorerMenu read FMenuBar;
    property MenuDock: TppDock read FMenuDock;
    property ReportsPopupMenu: TppReportsPopupMenu read FReportsPopupMenu;
    property Toolbar: TppExplorerToolbar read FToolbar;

  end; {class, TppReportExplorerForm}

var
  ppReportExplorerForm: TrbReportExplorerForm;

implementation

uses
  ppToolResources;

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.Create }

constructor TrbReportExplorerForm.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FReportExplorer := nil;
  FSpeedButtons := nil;

  if (FListView = nil) then
    begin
      FListView := TppItemList.Create(Self);
      FListView.Parent := pnlReports;
      FListView.Align := alClient;
      FListView.MultiSelect := True;
      //FListView.PopupMenu := ppmReports;
      FListView.ViewStyle := vsList;

      FListView.OnDoubleClick := ListDoubleClickEvent;
      FListView.OnDragOver := ListDragOverEvent;
      FListView.OnFolderChange := ListFolderChangeEvent;
      FListView.OnRenameFolder := ListRenameFolderEvent;
      FListView.OnSelectionChange := ListSelectionChangeEvent;
    end;

end; {procedure, Create}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.Destroy }

destructor TrbReportExplorerForm.Destroy;
begin

  FSpeedButtons.Free;
  
  SaveStateInfo;

  inherited Destroy;

end; {procedure, Destroy}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.CreateParams}

procedure TrbReportExplorerForm.CreateParams(var Params: TCreateParams);
begin

  inherited CreateParams(Params);

  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;

end; {procedure, CreateParams}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.Initialize }

procedure TrbReportExplorerForm.Initialize;
begin

  InitializeIcons;

  LoadMainMenu;
  LoadPopupMenus;

  LoadStateInfo;

  InitializeOptions;

  UpdateTreeView;

  SelectFolder(FListView.FolderId);

end; {procedure, Initialize}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.LanguageChanged }

procedure TrbReportExplorerForm.LanguageChanged;
var
  lsMessage: String;
begin

  pnlFolderTitle.Caption := ppLoadStr(524);  {All Folders}

  FListView.LanguageIndex := LanguageIndex;

  {Contents of '<name>'}
  lsMessage := ppLoadStr(544);
  lsMessage := ppSetMessageParameters(lsMessage);
  lsMessage := Format(lsMessage, [ppLoadStr(524)]); {'All Folders'}

  pnlReportTitle.Caption := ' ' + lsMessage;

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.InitializeOptions }

procedure TrbReportExplorerForm.InitializeOptions;
var
  lbVisible: Boolean;
begin

  {set visibilty based on open options}
  FMenuBar.FileMenu.Design.Visible := (FReportExplorer.ItemAction <> iaOpenToDesign);
  FMenuBar.FileMenu.PrintPreview.Visible := (FReportExplorer.ItemAction <> iaOpenToPreview);

  FReportsPopupMenu.Design.Visible := FMenuBar.FileMenu.Design.Visible;
  FReportsPopupMenu.PrintPreview.Visible := FMenuBar.FileMenu.PrintPreview.Visible;

  lbVisible := (ioAllowDesign in FReportExplorer.ItemOptions);
  FMenuBar.FileMenu.Design.Visible := FMenuBar.FileMenu.Design.Visible and lbVisible;
  FReportsPopupMenu.Design.Visible := FReportsPopupMenu.Design.Visible and lbVisible;

  lbVisible := (ioAllowNew in FReportExplorer.ItemOptions);
  FMenuBar.FileMenu.New.Report.Visible := lbVisible;
  FToolbar.NewReport.Visible := lbVisible;
  FToolbar.NewReportTopSpacer.Visible := lbVisible;
  FToolbar.NewReportSeparator.Visible := lbVisible;
  FToolbar.NewReportBottomSpacer.Visible := lbVisible;
  FFoldersPopupMenu.NewReport.Visible := lbVisible;
  FReportsPopupMenu.NewReport.Visible := lbVisible;

  {set visibilty based on folder options}
  lbVisible := (foAllowNew in FReportExplorer.FolderOptions);

  FMenuBar.FileMenu.New.Folder.Visible := lbVisible;
  FToolbar.NewFolder.Visible := lbVisible;
  FFoldersPopupMenu.NewFolder.Visible := lbVisible;
  FReportsPopupMenu.NewFolder.Visible := lbVisible;

  if not(foAllowNew in FReportExplorer.FolderOptions) and not(ioAllowNew in FReportExplorer.ItemOptions) then
    begin
      FMenuBar.FileMenu.New.Visible := False;
      FMenuBar.FileMenu.NewSeparator.Visible := False;
    end;


  FFoldersPopupMenu.Erase.Visible := (foAllowDelete in FReportExplorer.FolderOptions);

  if not(foAllowDelete in FReportExplorer.FolderOptions) and not(ioAllowDelete in FReportExplorer.ItemOptions) then
    begin
      FMenuBar.FileMenu.Erase.Visible := False;
      FToolbar.Erase.Visible := False;
      FReportsPopupMenu.Erase.Visible := False;

    end;


  FFoldersPopupMenu.Rename.Visible := (foAllowRename in FReportExplorer.FolderOptions);

  if not(foAllowRename in FReportExplorer.FolderOptions) and
     not(ioAllowRename in FReportExplorer.ItemOptions) then
    begin
      FMenuBar.FileMenu.Rename.Visible := False;
      FMenuBar.FileMenu.RenameSeparator.Visible := False;
      FMenuBar.FileMenu.RemoveSeparator.Visible := FMenuBar.FileMenu.Erase.Visible;
      FReportsPopupMenu.Rename.Visible := False;
    end;

end; {procedure, InitializeOptions}

procedure TrbReportExplorerForm.InitializeIcons;
begin

  ToolImageList.AddTool('PPFOLDER');
  ToolImageList.AddTool('PPOPENFOLDER');
  ToolImageList.AddTool('PPRECYCLEBIN');
  ToolImageList.AddTool('PPEMPTYRECYCLEBIN');

  TrvFolders.Images := ToolImageList;

end;

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.GetReportExplorer }

function  TrbReportExplorerForm.GetReportExplorer: TComponent;
begin
  Result := FReportExplorer;
end; {function, GetReportExplorer}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.SetReportExplorer }

procedure TrbReportExplorerForm.SetReportExplorer(aComponent: TComponent);
begin
  if not(aComponent is TppReportExplorer) then Exit;

  FReportExplorer := TppReportExplorer(aComponent);

  FListView.ReportExplorer := TppReportExplorer(aComponent);

end; {procedure, SetReportExplorer}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.LoadMainMenu }

procedure TrbReportExplorerForm.LoadMainMenu;
begin
  // menu dock
  FMenuDock := TppDock.Create(Self);
  FMenuDock.Parent := Self;
  FMenuDock.Align := alTop;
  FMenuDock.Height := 200;

  FMenuBar := TppExplorerMenu.CreateMenu(Self, Self);
  FMenuBar.Initialize(nil);
  FMenuBar.FreeNotification(Self);
  FMenuBar.CurrentDock := FMenuDock;
  FMenuBar.FileMenu.FontSettings.Color := clWhite;
  FMenuBar.ViewMenu.FontSettings.Color := clWhite;
  FMenuBar.HelpMenu.FontSettings.Color := clWhite;

  if MergeMenu <> nil then
    FMenuBar.Merge(MergeMenu);

  FToolbar := TppExplorerToolbar.CreateMenu(Self, Self);
  FToolbar.Initialize(nil);
  FToolbar.FreeNotification(Self);
  FToolbar.CurrentDock := FMenuDock;
  FToolbar.LanguageChanged();

end; {procedure, LoadMainMenu}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.LoadPopupMenus }

procedure TrbReportExplorerForm.LoadPopupMenus;
begin
  FFoldersPopupMenu := TppFoldersPopupMenu.CreateMenu(Self, Self);
  FFoldersPopupMenu.FreeNotification(Self);
  FFoldersPopupMenu.LanguageIndex := LanguageIndex;
  FFoldersPopupMenu.OnPopup := ehFoldersPopup;
  trvFolders.PopupMenu := FFoldersPopupMenu;

  FReportsPopupMenu := TppReportsPopupMenu.CreateMenu(Self, Self);
  FReportsPopupMenu.FreeNotification(Self);
  FReportsPopupMenu.LanguageIndex := LanguageIndex;
  pnlReports.PopupMenu := FReportsPopupMenu;

end; {procedure, LoadPopupMenus}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.LoadStateInfo }

procedure TrbReportExplorerForm.LoadStateInfo;
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

  SetFormSettingsRemembered(True);

  {set initial size based on screen res}
  lScreenRes := ppGetScreenRes;

  {calc default screen size }

  {set size based on 1024 x 768 }
  liWidth  := 790;
  liHeight := 600;

  if lScreenRes.X < 1024 then
    begin
      liWidth  := (liWidth  * lScreenRes.X)  div 1024;
      liHeight := (liHeight * lScreenRes.Y) div 768;
    end;

  {default to center of screen}
  liLeft := (Screen.Width  - liWidth)  div 2;
  liTop  := (Screen.Height - liHeight) div 2;


  liWindowState := lIniStorage.ReadInteger('Explorer Form Position', 'WindowState', Ord(wsNormal));

  {load positions from ini file}
  if TWindowState(liWindowState) = wsNormal then
    begin
      liLeft   := lIniStorage.ReadInteger('Explorer Form Position', 'Left',   liLeft);
      liTop    := lIniStorage.ReadInteger('Explorer Form Position', 'Top',    liTop);
      liWidth  := lIniStorage.ReadInteger('Explorer Form Position', 'Width',  liWidth);
      liHeight := lIniStorage.ReadInteger('Explorer Form Position', 'Height', liHeight);
    end;

  SetBounds(liLeft, liTop, liWidth, liHeight);

  if TWindowState(liWindowState) <> wsMinimized then
    WindowState := TWindowState(liWindowState);

  SetViewStyle(lIniStorage.ReadBool('Explorer Form State', 'ViewList', True));
  SetViewToolbar(lIniStorage.ReadBool('Explorer Form State', 'ViewToolbar', True));
  SetViewStatusBar(lIniStorage.ReadBool('Explorer Form State', 'ViewStatusBar', True));

  FListView.SortMode := lIniStorage.ReadInteger('Explorer Form State', 'SortMode', 1);

  FListView.Columns[0].Width := lIniStorage.ReadInteger('Explorer Form State', 'ListViewColumn1Width', 250);
  FListView.Columns[1].Width := lIniStorage.ReadInteger('Explorer Form State', 'ListViewColumn2Width', 120);
  FListView.Columns[2].Width := lIniStorage.ReadInteger('Explorer Form State', 'ListViewColumn3Width', 100);
  FListView.Columns[3].Width := lIniStorage.ReadInteger('Explorer Form State', 'ListViewColumn4Width', 140);

  FListView.FolderId := lIniStorage.ReadInteger('Explorer Form State', 'Selected Folder', 0);
  FListView.ItemName := lIniStorage.ReadString('Explorer Form State', 'Selected Item', '');

  FReportExplorer.CurrentFolderId := FListView.FolderId;
  FReportExplorer.CurrentItemName := FListView.ItemName;

  lIniStorage.Free;
  
end; {procedure, LoadStateInfo}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.SaveStateInfo }

procedure TrbReportExplorerForm.SaveStateInfo;
var
  lIniStorage: TppIniStorage;
begin

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  lIniStorage.WriteInteger('Explorer Form Position', 'WindowState', Ord(WindowState));

  lIniStorage.WriteInteger('Explorer Form Position', 'Left',   Left);
  lIniStorage.WriteInteger('Explorer Form Position', 'Top',    Top);
  lIniStorage.WriteInteger('Explorer Form Position', 'Width',  Width);
  lIniStorage.WriteInteger('Explorer Form Position', 'Height', Height);

  lIniStorage.WriteBool('Explorer Form State', 'ViewList',  FMenuBar.ViewMenu.List.Checked);
  lIniStorage.WriteBool('Explorer Form State', 'ViewToolbar', FMenuBar.ViewMenu.Toolbar.Checked);
  lIniStorage.WriteBool('Explorer Form State', 'ViewStatusBar', FMenuBar.ViewMenu.StatusBar.Checked);

  lIniStorage.WriteInteger('Explorer Form State', 'SortMode', FListView.SortMode);

  lIniStorage.WriteInteger('Explorer Form State', 'ListViewColumn1Width', FListView.Columns[0].Width);
  lIniStorage.WriteInteger('Explorer Form State', 'ListViewColumn2Width', FListView.Columns[1].Width);
  lIniStorage.WriteInteger('Explorer Form State', 'ListViewColumn3Width', FListView.Columns[2].Width);
  lIniStorage.WriteInteger('Explorer Form State', 'ListViewColumn4Width', FListView.Columns[3].Width);

  lIniStorage.WriteInteger('Explorer Form State', 'Selected Folder', FListView.FolderId);
  lIniStorage.WriteString('Explorer Form State', 'Selected Item', FListView.ItemName);

  lIniStorage.Free;

end; {procedure, SaveStateInfo}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehFileOpenClick }

procedure TrbReportExplorerForm.ehFileOpenClick(Sender: TObject);
begin

  if (trvFolders.Focused) then
    begin
      if (trvFolders.Selected <> nil) and not(trvFolders.Selected.Expanded) then
        trvFolders.Selected.Expanded := True;
    end
  else
    OpenItem;

end; {procedure, ehFileOpenClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.OpenItem }

procedure TrbReportExplorerForm.OpenItem;
begin

  case FReportExplorer.ItemAction of

    iaOpenToDesign: Design;

    iaOpenToPreview: PrintPreview;

  end;

end; {procedure, OpenItem}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.Design }

procedure TrbReportExplorerForm.Design;
begin

  if (FListView.FolderId = itRecycleBin) then Exit;

  if (FListView.ItemType <> itReport) or (FListView.ItemName = '') then Exit;

  Cursor := crHourGlass;
  FListView.Cursor := crHourGlass;

  try
    FReportExplorer.Open(FListView.ItemName, FListView.FolderId);

  finally
    Cursor := crDefault;
    FListView.Cursor := crDefault;
  end;

end; {procedure, Design}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.Print }

procedure TrbReportExplorerForm.Print;
begin

  if (FListView.ItemName = '') then Exit;

  FReportExplorer.Print(FListView.ItemName, FListView.FolderId);

end; {procedure, Print}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.PrintPreview }

procedure TrbReportExplorerForm.PrintPreview;
begin

  if (FListView.ItemName = '') then Exit;

  FReportExplorer.PrintPreview(FListView.ItemName, FListView.FolderId);

end; {procedure, PrintPreview}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehFileDesignClick }

procedure TrbReportExplorerForm.ehFileDesignClick(Sender: TObject);
begin
  Design;
end; {procedure, ehFileDesignClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehFilePrintClick }

procedure TrbReportExplorerForm.ehFilePrintClick(Sender: TObject);
begin
  Print;
end; {procedure, ehFilePrintClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehFilePrintPreviewClick }

procedure TrbReportExplorerForm.ehFilePrintPreviewClick(Sender: TObject);
begin
  PrintPreview;
end; {procedure, ehFilePrintPreviewClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.Refresh }

procedure TrbReportExplorerForm.Refresh;
begin
  UpdateTreeView;

  SelectFolder(FReportExplorer.CurrentFolderId);

  FListView.ItemName := FReportExplorer.CurrentItemName;
end; {procedure, Refresh}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehFileNewReportClick }

procedure TrbReportExplorerForm.ehFileNewReportClick(Sender: TObject);
var
  liFolderId: Integer;
begin

  if( trvFolders.Selected <> nil) then
    liFolderId := Integer(trvFolders.Selected.Data)
  else
    liFolderId := itAllFolders;

  FReportExplorer.New(liFolderId);

end; {procedure, ehFileNewReportClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehFileDeleteClick }

procedure TrbReportExplorerForm.ehFileDeleteClick(Sender: TObject);
var
  lNode: TTreeNode;
  lNewNode: TTreeNode;
  liFolderId: Integer;
begin

  lNode := trvFolders.Selected;

  if (lNode = nil) then Exit;

  if (trvFolders.Focused) then
    begin
      liFolderId := Integer(lNode.Data);

      if (liFolderId = itRecycleBin) then Exit;
      if (liFolderId = itAllFolders) then Exit;

      if FReportExplorer.ConfirmDeleteFolder(lNode.Text) then
        begin
          if FReportExplorer.ChangeParentFolder(liFolderId, itRecycleBin) then
            begin
              lNewNode := FindNearestNode(lNode);

              SelectFolder(Integer(lNewNode.Data));

              lNode.Free;
            end;
        end;
    end

  else 
    FListView.DeleteSelection;

  UpdateRecycleBin;

end; {procedure, ehFileDeleteClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehViewListClick }

procedure TrbReportExplorerForm.ehViewListClick(Sender: TObject);
begin
  SetViewStyle(True);
end; {procedure, ehViewListClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehViewDetailsClick }

procedure TrbReportExplorerForm.ehViewDetailsClick(Sender: TObject);
begin
  SetViewStyle(False);
end; {procedure, ehViewDetailsClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehViewToolbarClick }

procedure TrbReportExplorerForm.ehViewToolbarClick(Sender: TObject);
begin
  SetViewToolbar(not(FMenuBar.ViewMenu.Toolbar.Checked));
end; {procedure, ehViewToolbarClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehViewStatusBarClick }

procedure TrbReportExplorerForm.ehViewStatusBarClick(Sender: TObject);
begin
  SetViewStatusBar(not(FMenuBar.ViewMenu.StatusBar.Checked));
end; {procedure, ehViewStatusBarClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehFileCloseClick }

procedure TrbReportExplorerForm.ehFileCloseClick(Sender: TObject);
begin
  Close;
end; {procedure, ehFileCloseClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehHelpAboutClick }

procedure TrbReportExplorerForm.ehHelpAboutClick(Sender: TObject);
var
  lAboutDlg : TppCustomAboutDialog;
  lFormClass: TFormClass;
begin

  lFormClass := ppGetFormClass(TppCustomAboutDialog);

  lAboutDlg := TppCustomAboutDialog(lFormClass.Create(Self));
  lAboutDlg.ShowModal;
  lAboutDlg.Free;

end; {procedure, ehHelpAboutClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehHelpTopicsClick }

procedure TrbReportExplorerForm.ehHelpTopicsClick(Sender: TObject);
var
  lsDelphiHelpFile : String;
  lsDelphiPath: String;

begin
  lsDelphiPath := ppGetDelphiPath;

  if (lsDelphiPath = '') then Exit;

  lsDelphiHelpFile := Application.HelpFile;
  Application.HelpFile := lsDelphiPath + '\Help\RBuilder.HLP';

  Application.HelpCommand(HELP_FINDER, 0);
  Application.HelpFile := lsDelphiHelpFile;

end; {procedure, ehHelpTopicsClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.SetViewStyle }

procedure TrbReportExplorerForm.SetViewStyle(Value: Boolean);
begin

  if Value then
    begin
      FMenuBar.ViewMenu.List.Checked := True;
      FReportsPopupMenu.List.Checked := True;

      FToolbar.Details.Checked := False;
      FToolbar.List.Checked := True;

      FListView.ViewStyle := vsList;
    end
  else
    begin
      FMenuBar.ViewMenu.Details.Checked := True;
      FReportsPopupMenu.List.Checked := True;

      FToolbar.List.Checked := False;
      FToolbar.Details.Checked := True;

      FListView.ViewStyle := vsReport;
    end;

end; {procedure, SetViewStyle}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.SetViewToolbar }

procedure TrbReportExplorerForm.SetViewToolbar(Value: Boolean);
begin

  FMenuBar.ViewMenu.Toolbar.Checked := Value;

  FToolBar.Visible := Value;

end; {procedure, SetViewToolbar}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.SetViewStatusBar }

procedure TrbReportExplorerForm.SetViewStatusBar(Value: Boolean);
begin

  FMenuBar.ViewMenu.StatusBar.Checked := Value;  

  sbrExplorer.Visible := Value;

end; {procedure, SetViewStatusBar}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehFileNewFolderClick }

procedure TrbReportExplorerForm.ehFileNewFolderClick(Sender: TObject);
var
  lItem: TTreeNode;
  lsName: String;
  liFolderId: Integer;
begin
  lItem := trvFolders.Selected;

  if (lItem = nil) then Exit;

  if (Integer(lItem.Data) = itRecycleBin) then Exit;

  trvFolders.Items.BeginUpdate;

  lsName := FReportExplorer.GetNewFolderName(Integer(lItem.Data));

  {create the folder record}
  if (trvFolders.Selected <> nil) then
    FReportExplorer.AddFolder(Integer(trvFolders.Selected.Data), lsName, liFolderID)
  else
    FReportExplorer.AddFolder(itAllFolders, lsName, liFolderId);

  {create the folder node}
  lItem := trvFolders.Items.AddChild(trvFolders.Selected, lsName);

  lItem.Data := TObject(liFolderID);
  lItem.ImageIndex := ToolImageList.IndexOfTool('PPFOLDER');
  lItem.SelectedIndex := ToolImageList.IndexOfTool('PPOPENFOLDER');

  {display the folder node}
  if (lItem.Parent <> nil) then
    lItem.Parent.Expand(False);

  trvFolders.Selected := lItem;

  trvFolders.Items.EndUpdate;

  {put the node in edit mode}
  trvFolders.Selected.EditText;

end; {procedure, ehFileNewFolderClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.trvFoldersEdited }

procedure TrbReportExplorerForm.trvFoldersEdited(Sender: TObject; Node: TTreeNode; var S: String);
begin

  if FReportExplorer.ConfirmRenameFolder(Node.Text, S, Integer(Node.Parent.Data)) then
    FReportExplorer.RenameFolder(Integer(Node.Data), S)
  else
    S := Node.Text;

end; {procedure, trvFoldersEdited}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.trvFoldersChange }

procedure TrbReportExplorerForm.trvFoldersChange(Sender: TObject; Node: TTreeNode);
begin
  if (trvFolders.Selected <> nil) then
    SelectFolder(Integer(trvFolders.Selected.Data));

end; {procedure, trvFoldersChange}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehFileRenameClick }

procedure TrbReportExplorerForm.ehFileRenameClick(Sender: TObject);
var
  lNode: TTreeNode;
begin

  if (trvFolders.Focused) then
    begin
      lNode := trvFolders.Selected;

      if (lNode <> nil) and (Integer(lNode.Data) > itAllFolders) then
        lNode.EditText;
    end
  else
    FListView.RenameItem;

end; {procedure, ehFileRenameClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.trvFoldersCollapsing }

procedure TrbReportExplorerForm.trvFoldersCollapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
begin
  if (Integer(Node.Data) = itAllFolders) then
    AllowCollapse := False;
end; {procedure, trvFoldersCollapsing}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ListDoubleClickEvent }

procedure TrbReportExplorerForm.ListDoubleClickEvent(Sender: TObject);
begin
  OpenItem;
end; {procedure, ListDoubleClickEvent}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ListRenameFolderEvent }

procedure TrbReportExplorerForm.ListRenameFolderEvent(Sender: TObject; aFolderId: Integer; const aNewName: String);
var
  lTreeNode: TTreeNode;
begin
  lTreeNode := FindDataInTreeView(trvFolders, aFolderId);

  lTreeNode.Text := aNewName;
end; {procedure, ListRenameFolderEvent}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ListDragOverEvent }

procedure TrbReportExplorerForm.ListDragOverEvent(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
begin

  {enforce security: foAllowMove}
  if not(foAllowMove in FReportExplorer.FolderOptions) and (FListView.ItemType = itFolder) then
    Accept := False

  else if not(ioAllowMove in FReportExplorer.ItemOptions) and (FListView.ItemType <> itFolder) then
    Accept := False;

end; {procedure, ListDragOverEvent}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.FindDataInTreeView }

function TrbReportExplorerForm.FindDataInTreeView(aTreeView: TTreeView; aData: Integer): TTreeNode;
var
  liIndex: Integer;
  lTreeNode: TTreeNode;
begin

  Result := nil;

  if (aTreeView.Items.Count = 0) then Exit;
  
  liIndex := 0;
  lTreeNode := aTreeView.Items[liIndex];

  while (liIndex < aTreeView.Items.Count) and (Integer(lTreeNode.Data) <> aData) do
    begin
      Inc(liIndex);

      lTreeNode := aTreeView.Items[liIndex];
    end;

  Result := lTreeNode;

end; {procedure, FindDataInTreeView}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ListFolderChangeEvent }

procedure TrbReportExplorerForm.ListFolderChangeEvent(Sender: TObject);
var
  liID: Integer;
begin
  liID := FListView.FolderId;

  UpdateTreeView;

  SelectFolder(liID);
end; {procedure, ListFolderChangeEvent}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.trvFoldersEditing }

procedure TrbReportExplorerForm.trvFoldersEditing(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
begin

  if (Integer(Node.Data) = itAllFolders) or (Integer(Node.Data) = itRecycleBin) then
    AllowEdit := False
  else
    AllowEdit := (foAllowRename in FReportExplorer.FolderOptions);

end; {procedure, trvFoldersEditing}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehUpOneLevelClick }

procedure TrbReportExplorerForm.ehUpOneLevelClick(Sender: TObject);
var
  lItem: TTreeNode;
begin

  lItem := trvFolders.Selected;

  if (lItem.Parent <> nil) then
    SelectFolder(Integer(lItem.Parent.Data));

end; {procedure, ehUpOneLevelClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.trvFoldersDragOver }

procedure TrbReportExplorerForm.trvFoldersDragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
var
  lItem: TTreeNode;
  lSelected: TTreeNode;
  lbDragAllowed: Boolean;
begin

  Accept := False;

  lSelected := trvFolders.Selected;

  if (lSelected = nil) then Exit;

  if (Source = trvFolders) and ((lSelected = FAllFoldersNode) or (lSelected = FRecycleBinNode)) then Exit;

  lbDragAllowed := True;

  {enforce security: foAllowMove}
  if not(foAllowMove in FReportExplorer.FolderOptions) then
    lbDragAllowed := ((Source = FListView) and (FListView.ItemType <> itFolder));

  {enforce security: ioAllowMove}
  if lbDragAllowed and not(ioAllowMove in FReportExplorer.ItemOptions) then
    lbDragAllowed := ((Source = trvFolders) or (FListView.ItemType = itFolder));


  if lbDragAllowed then
    begin
      lItem := trvFolders.GetNodeAt(X, Y);

      if (Source = trvFolders) and (lItem <> nil) then
        Accept := (lItem <> lSelected) and (lItem <> lSelected.Parent)
      else
        Accept := True;
    end;

end; {procedure, trvFoldersDragOver}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.trvFoldersDragDrop }

procedure TrbReportExplorerForm.trvFoldersDragDrop(Sender, Source: TObject; X,Y: Integer);
var
  lTargetItem: TTreeNode;
  lSourceItem: TTreeNode;
  lNewNode: TTreeNode;
  liTargetFolderId: Integer;
  liSourceFolderId: Integer;
  liFolderId: Integer;
begin

  lTargetItem := trvFolders.GetNodeAt(X, Y);

  if (lTargetItem <> nil) then
    begin
      liTargetFolderId := Integer(lTargetItem.Data);

      if (Source = trvFolders) then
        begin
          lSourceItem := trvFolders.Selected;

          if (lSourceItem = nil) then Exit;

          liSourceFolderId := Integer(lSourceItem.Data);

          if FReportExplorer.ChangeParentFolder(liSourceFolderId, liTargetFolderId) then
            begin
              if (liTargetFolderId = itRecycleBin) then
                begin
                  lNewNode := FindNearestNode(lSourceItem);

                  if (lNewNode <> nil) then
                    liFolderId := Integer(lNewNode.Data)
                  else
                    liFolderId := itAllFolders;
                end
              else
                liFolderId := liSourceFolderId;

              UpdateTreeView;

              SelectFolder(liFolderId);
            end;

        end

      else if (Source = FListView) then
        begin
          FListView.MoveSelectionToFolder(liTargetFolderId);

          lSourceItem := trvFolders.Selected;

          if (lSourceItem = nil) then Exit;

          liSourceFolderId := Integer(lSourceItem.Data);

          if (liTargetFolderId = itRecycleBin) then
            UpdateRecycleBin
          else if (liSourceFolderId = itRecycleBin) then
            UpdateRecycleBin

        end;

    end;

end; {procedure, trvFoldersDragDrop}

{******************************************************************************
 *
 ** R O U T I N E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.FindNearestNode }

function TrbReportExplorerForm.FindNearestNode(aNode: TTreeNode): TTreeNode;
begin

  Result := aNode.GetNextSibling;

  if (Result <> nil) then Exit;

  Result := aNode.GetPrevSibling;

  if (Result <> nil) then Exit;

  Result := aNode.Parent;

  if (Result <> nil) then Exit;

  Result := trvFolders.Items[0];

end; {function, FindNearestNode}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.SelectFolder }

procedure TrbReportExplorerForm.SelectFolder(aFolderId: Integer);
var
  liIndex: Integer;
  lItem: TTreeNode;
  lItemFound: TTreeNode;
begin

  trvFolders.Items.BeginUpdate;

  liIndex := 0;
  lItemFound := nil;

  while (liIndex < trvFolders.Items.Count) do
    begin
      lItem := trvFolders.Items[liIndex];

      if (Integer(lItem.Data) >= itAllFolders) then
        lItem.ImageIndex := ToolImageList.IndexOfTool('PPFOLDER');

      if (lItemFound = nil) and (Integer(lItem.Data) = aFolderId) then
        lItemFound := lItem;
          
      Inc(liIndex);
    end;

  if (lItemFound <> nil) then
    begin
      trvFolders.Selected := lItemFound;

      if (Integer(lItemFound.Data) >= itAllFolders) then
        lItemFound.ImageIndex := ToolImageList.IndexOfTool('PPOPENFOLDER');

      lItem := lItemFound.Parent;

      while (lItem <> nil) do
        begin
          if not(lItem.Expanded) then
            lItem.Expanded := True;

          lItem.ImageIndex := ToolImageList.IndexOfTool('PPOPENFOLDER');

          lItem := lItem.Parent;
        end;

      FoldersSelectionChange;
    end
  else
    trvFolders.Selected := trvFolders.Items[0];

  FListView.FolderId := Integer(trvFolders.Selected.Data);

  // force call to EnableItemOptions, when no listview items
  if (FListView.Items.Count = 0) then
    EnableItemOptions;

  trvFolders.Items.EndUpdate;

  UpdateStatusBar;

end; {procedure, SelectFolder}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.UpdateStatusBar }

procedure TrbReportExplorerForm.UpdateStatusBar;
var
  lsMessage: String;
begin

  if (trvFolders.Focused) then
    lsMessage := ppLoadStr(522) {<count> item(s)}
  else
    lsMessage := ppLoadStr(521); {<count> item(s) selected}

  lsMessage := ppSetMessageParameters(lsMessage);
  lsMessage := Format(lsMessage, [IntToStr(FListView.SelectionCount)]);

  sbrExplorer.Panels[0].Text := lsMessage;

  if (FListView.AllFolders) then
    sbrExplorer.Panels[1].Text := ''
  else if (FListView.SelectionSize = 0) then
    sbrExplorer.Panels[1].Text := '0 ' + ppLoadStr(531) {bytes}
  else
    sbrExplorer.Panels[1].Text := IntToStr(FListView.SelectionSize div 1000) + ppLOadStr(565); {KB}

end; {procedure, UpdateStatusBar}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.FoldersSelectionChange }

procedure TrbReportExplorerForm.FoldersSelectionChange;
var
  lsFolderName: String;
  lItem: TTreeNode;
  lsMessage: String;
begin

  lItem := trvFolders.Selected;

  if (lItem = nil) then Exit;

  {get folder chain description}
  lsFolderName := '';

  while (lItem <> nil) and (Integer(lItem.Data) > itAllFolders) do
    begin
      if (lsFolderName <> '') then
        lsFolderName := lItem.Text + '\'+ lsFolderName
      else
        lsFolderName := lItem.Text;

      lItem := lItem.Parent;
    end;

  if (lItem <> nil) and (lsFolderName = '') then
    lsFolderName := lItem.Text;

  {Contents of '<name>'}
  lsMessage := ppLoadStr(544);
  lsMessage := ppSetMessageParameters(lsMessage);
  lsMessage := Format(lsMessage, [lsFolderName]);

  pnlReportTitle.Caption := ' ' + lsMessage;

  EnableFolderOptions;

end; {procedure, FoldersSelectionChange}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ListSelectionChangeEvent }

procedure TrbReportExplorerForm.ListSelectionChangeEvent(Sender: TObject);
begin

  UpdateStatusBar;

  EnableItemOptions;

end; {procedure, ListSelectionChangeEvent}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.EnableFolderOptions }

procedure TrbReportExplorerForm.EnableFolderOptions;
var
  liFolderId: Integer;
  lItem: TTreeNode;
begin

  lItem := trvFolders.Selected;

  if (lItem = nil) then Exit;

  liFolderId := Integer(lItem.Data);

  {enable options}
  if (liFolderId = itRecycleBin) then
    begin
      FToolbar.UpOneLevel.Enabled := False;

      FMenuBar.FileMenu.Open.Enabled := False;
      FFoldersPopupMenu.Open.Enabled := False;

      FMenuBar.FileMenu.New.Enabled := False;

      FToolbar.Erase.Enabled := False;
      FMenuBar.FileMenu.Erase.Enabled := False;
      FFoldersPopupMenu.Erase.Enabled := False;

      FMenuBar.FileMenu.Rename.Enabled := False;
      FFoldersPopupMenu.Rename.Enabled := False;
    end

  else if (liFolderId = itAllFolders) then
    begin
      FToolbar.UpOneLevel.Enabled := False;

      FMenuBar.FileMenu.Open.Enabled := False;
      FFoldersPopupMenu.Open.Enabled := False;

      FToolbar.Erase.Enabled := False;
      FMenuBar.FileMenu.Erase.Enabled := False;
      FFoldersPopupMenu.Erase.Enabled := False;

      FMenuBar.FileMenu.Rename.Enabled := False;
      FFoldersPopupMenu.Rename.Enabled := False;
    end

  else
    begin
      FToolbar.UpOneLevel.Enabled := True;

      FMenuBar.FileMenu.Open.Enabled := not(trvFolders.Selected.ImageIndex = ToolImageList.IndexOfTool('PPOPENFOLDER'));
      FFoldersPopupMenu.Open.Enabled := not(trvFolders.Selected.ImageIndex = ToolImageList.IndexOfTool('PPOPENFOLDER'));

      FToolbar.Erase.Enabled := True;
      FMenuBar.FileMenu.Erase.Enabled := True;
      FFoldersPopupMenu.Erase.Enabled := True;

      FMenuBar.FileMenu.Rename.Enabled := True;
      FFoldersPopupMenu.Rename.Enabled := True;
    end;

  if trvFolders.Focused then
    begin
      FToolbar.Erase.Enabled := FToolbar.Erase.Enabled and (foAllowDelete in FReportExplorer.FolderOptions);
      FMenuBar.FileMenu.Erase.Enabled := FMenuBar.FileMenu.Erase.Enabled and (foAllowDelete in FReportExplorer.FolderOptions);
      FFoldersPopupMenu.Erase.Enabled := FFoldersPopupMenu.Erase.Enabled and (foAllowDelete in FReportExplorer.FolderOptions);

      FMenuBar.FileMenu.Rename.Enabled := FMenuBar.FileMenu.Rename.Enabled and (foAllowRename in FReportExplorer.FolderOptions);
      FFoldersPopupMenu.Rename.Enabled := FFoldersPopupMenu.Rename.Enabled and (foAllowRename in FReportExplorer.FolderOptions);
    end;

end; {procedure, EnableFolderOptions}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.EnableItemOptions }

procedure TrbReportExplorerForm.EnableItemOptions;
var
  lbEnabled: Boolean;
  liFolderId: Integer;
  lItem: TTreeNode;
  lbNewFolder: Boolean;
  lbNewReport: Boolean;
begin

  lItem := trvFolders.Selected;

  if (lItem = nil) then Exit;

  liFolderId := Integer(lItem.Data);

  if (liFolderId = itRecycleBin) then
    begin
      lbEnabled := False;

      lbNewFolder := False;
      lbNewReport := False;
    end
  else
    begin
      lbEnabled := (FListView.Selected <> nil) and (FListView.ItemType <> itFolder);

      lbNewFolder := (foAllowNew in FReportExplorer.FolderOptions);
      lbNewReport := (ioAllowNew in FReportExplorer.ItemOptions);
    end;

  {assign new report, new folder}
  FToolbar.NewFolder.Enabled := lbNewFolder;
  FToolbar.NewReport.Enabled := lbNewReport;

  FMenuBar.FileMenu.New.Enabled := True;

  FMenuBar.FileMenu.New.Folder.Enabled := lbNewFolder;
  FMenuBar.FileMenu.New.Report.Enabled := lbNewReport;

  FFoldersPopupMenu.NewFolder.Enabled := lbNewFolder;
  FFoldersPopupMenu.NewReport.Enabled := lbNewReport;

  FReportsPopupMenu.NewFolder.Enabled := lbNewFolder;
  FReportsPopupMenu.NewReport.Enabled := lbNewReport;

  {assign properties which pertain to reports only}
  FToolbar.Print.Enabled := lbEnabled;
  FToolbar.PrintPreview.Enabled := lbEnabled;

  FMenuBar.FileMenu.Design.Enabled := lbEnabled and (ioAllowDesign in FReportExplorer.ItemOptions);
  FMenuBar.FileMenu.Print.Enabled := lbEnabled;
  FMenuBar.FileMenu.PrintPreview.Enabled := lbEnabled;

  FReportsPopupMenu.Open.Enabled := lbEnabled;
  FReportsPopupMenu.Design.Enabled := lbEnabled and (ioAllowDesign in FReportExplorer.ItemOptions);
  FReportsPopupMenu.Print.Enabled := lbEnabled;
  FReportsPopupMenu.PrintPreview.Enabled := lbEnabled;

  {assign properties which pertain to both reports and folders}
  if FListView.Focused then
    begin
      FMenuBar.FileMenu.Open.Enabled := lbEnabled;

      if (FListView.FoldersInSelection) then
        begin
          FToolbar.Erase.Enabled := (foAllowDelete in FReportExplorer.FolderOptions);
          FMenuBar.FileMenu.Erase.Enabled := (foAllowDelete in FReportExplorer.FolderOptions);
          FReportsPopupMenu.Erase.Enabled := (foAllowDelete in FReportExplorer.FolderOptions);
        end
      else
        begin
          FToolbar.Erase.Enabled := lbEnabled and (ioAllowDelete in FReportExplorer.ItemOptions);
          FMenuBar.FileMenu.Erase.Enabled := lbEnabled and (ioAllowDelete in FReportExplorer.ItemOptions);
          FReportsPopupMenu.Erase.Enabled := lbEnabled and (ioAllowDelete in FReportExplorer.ItemOptions);
        end;

      if (FListView.ItemType = itFolder) then
        begin
          FMenuBar.FileMenu.Rename.Enabled := (foAllowRename in FReportExplorer.FolderOptions);
          FReportsPopupMenu.Rename.Enabled := (foAllowRename in FReportExplorer.FolderOptions);
        end
      else
        begin
          FMenuBar.FileMenu.Rename.Enabled := lbEnabled and (ioAllowRename in FReportExplorer.ItemOptions);
          FReportsPopupMenu.Rename.Enabled := lbEnabled and (ioAllowRename in FReportExplorer.ItemOptions);
        end;
    end;

end; {procedure, EnableItemOptions}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.UpdateTreeView }

procedure TrbReportExplorerForm.UpdateTreeView;
var
  liIndex: Integer;
  lItems: TTreeNodes;
  lItem: TTreeNode;
  lFolders: TStringList;
  lFolderNodes: TStringList;
  lFolderInfo: TppFolderInfo;
  liParentIndex: Integer;
  lParentNode: TTreeNode;
begin

  lFolders := TStringList.Create;
  lFolderNodes := TStringList.Create;

  FReportExplorer.GetFolders(lFolders);

  lItems := trvFolders.Items;

  lItems.BeginUpdate;

  lItems.Clear;

  {All Folders}
  FAllFoldersNode := trvFolders.Items.AddObject(nil, ppLoadStr(524), TObject(itAllFolders));
  FAllFoldersNode.ImageIndex := ToolImageList.IndexOfTool('PPFOLDER');
  FAllFoldersNode.SelectedIndex := ToolImageList.IndexOfTool('PPOPENFOLDER');
  lFolderNodes.AddObject(IntToStr(itAllFolders), FAllFoldersNode);

  {Recycle Bin}
  if (ioAllowDelete in FReportExplorer.ItemOptions) then
    begin
      FRecycleBinNode := trvFolders.Items.AddObject(nil, ppLoadStr(578), TObject(itRecycleBin));
      lFolderNodes.AddObject(IntToStr(itRecycleBin), FRecycleBinNode);
    end
  else
    FRecycleBinNode := nil;

  while (lFolders.Count > 0) do
    begin
      liIndex := 0;

      lFolderInfo := TppFolderInfo(lFolders.Objects[liIndex]);
      liParentIndex := lFolderNodes.IndexOf(IntToStr(lFolderInfo.ParentId));

      while (liParentIndex = -1) and (liIndex < lFolders.Count - 1) do
        begin
          Inc(liIndex);
          
          lFolderInfo := TppFolderInfo(lFolders.Objects[liIndex]);
          liParentIndex := lFolderNodes.IndexOf(IntToStr(lFolderInfo.ParentId));
        end;

      if (liParentIndex <> -1) then
        lParentNode := TTreeNode(lFolderNodes.Objects[liParentIndex])
      else
        lParentNode := FAllFoldersNode;

      lItem := lItems.AddChild(lParentNode, lFolderInfo.Name);
      lItem.Data := TObject(lFolderInfo.FolderId);
      lItem.ImageIndex := ToolImageList.IndexOfTool('PPFOLDER');
      lItem.SelectedIndex := ToolImageList.IndexOfTool('PPOPENFOLDER');

      lFolderNodes.AddObject(IntToStr(lFolderInfo.FolderId), lItem);

      lFolderInfo.Free;

      lFolders.Delete(liIndex);
    end;

  trvFolders.AlphaSort;

  lItems.EndUpdate;

  UpdateRecycleBin;

  lFolders.Free;
  lFolderNodes.Free;

  FAllFoldersNode.Expanded := True;

end; {procedure, UpdateTreeView}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.UpdateRecycleBin }

procedure TrbReportExplorerForm.UpdateRecycleBin;
var
  lItemNames: TStringList;
  liIndex: Integer;

begin

  if (FRecycleBinNode = nil) then Exit;

  trvFolders.Items.BeginUpdate;

  lItemNames := TStringList.Create;

  FReportExplorer.GetItems(itRecycleBin, itAllFolders, lItemNames);

  if (lItemNames.Count > 0) then
    begin
      FRecycleBinNode.ImageIndex := ToolImageList.IndexOfTool('PPRECYCLEBIN');
      FRecycleBinNode.SelectedIndex := ToolImageList.IndexOfTool('PPRECYCLEBIN');
    end
  else
    begin
      FRecycleBinNode.ImageIndex := ToolImageList.IndexOfTool('PPEMPTYRECYCLEBIN');
      FRecycleBinNode.SelectedIndex := ToolImageList.IndexOfTool('PPEMPTYRECYCLEBIN');
    end;

  for liIndex := 0 to lItemNames.Count-1 do
    lItemNames.Objects[liIndex].Free;

  lItemNames.Free;

  trvFolders.Items.EndUpdate;

end; {procedure, UpdateRecycleBin}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehEmptyRecycleBinClick }

procedure TrbReportExplorerForm.ehEmptyRecycleBinClick(Sender: TObject);
begin

  FListView.EmptyRecycleBin;

  UpdateTreeView;

end; {procedure, EmptyRecycleBinClick}

{------------------------------------------------------------------------------}
{ TppReportExplorerForm.ehFoldersPopup }

procedure TrbReportExplorerForm.ehFoldersPopup(Sender: TObject);
var
  lNode: TTreeNode;
  liFolderId: Integer;
begin

  lNode := trvFolders.Selected;

  if (lNode = nil) then Exit;

  liFolderId := Integer(lNode.Data);

  if (liFolderId = itRecycleBin) then
    FFoldersPopupMenu.EmptyRecycleBin.Visible := True
  else
    FFoldersPopupMenu.EmptyRecycleBin.Visible := False;

end; {procedure, ppmFoldersPopup}



{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomReportExplorer, TrbReportExplorerForm);

finalization

  ppUnRegisterForm(TppCustomReportExplorer);

end.
