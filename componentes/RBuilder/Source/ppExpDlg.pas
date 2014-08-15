{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppExpDlg;

interface

{$I ppIfDef.pas}

uses

  Windows, Messages, Forms, Buttons, StdCtrls, Controls, Classes, ExtCtrls,
  SysUtils, ComCtrls, Dialogs, ImgList,
  ppRptExp, ppForms, ppTypes, ppUtils, Menus, ppRptExpCommon;

type

  {@TppOpenSaveDialog }
  TppOpenSaveDialog = class(TppCustomTemplateDialog)
    splViews: TPanel;
    lblSaveIn: TLabel;
    cbxFileType: TComboBox;
    spbUpOneLevel: TSpeedButton;
    spbNewFolder: TSpeedButton;
    spbListView: TSpeedButton;
    spbDetailView: TSpeedButton;
    edtItemName: TEdit;
    lblItemName: TLabel;
    lblSaveAsType: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    cbxFolders: TComboBox;
    ppmItems: TPopupMenu;
    ppmView: TMenuItem;
    ppmViewList: TMenuItem;
    ppmViewDetails: TMenuItem;
    N8: TMenuItem;
    ppmNewFolder: TMenuItem;
    N10: TMenuItem;
    ppmDelete: TMenuItem;
    ppmRename: TMenuItem;
    procedure spbNewFolderClick(Sender: TObject);
    procedure spbUpOneLevelClick(Sender: TObject);
    procedure cbxFoldersChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtItemNameChange(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure spbListViewClick(Sender: TObject);
    procedure spbDetailViewClick(Sender: TObject);
    procedure cbxFoldersDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbxFoldersDropDown(Sender: TObject);
    procedure ppmDeleteClick(Sender: TObject);
    procedure ppmRenameClick(Sender: TObject);
    procedure ppmViewListClick(Sender: TObject);
    procedure ppmViewDetailsClick(Sender: TObject);
    procedure ppmNewFolderClick(Sender: TObject);
    procedure cbxFoldersMeasureItem(Control: TWinControl; Index: Integer; var Height: Integer);
    
  protected
    procedure Activate; override;

    function  GetTemplateName: String; override;
    function  GetTemplateNames: TStrings; override;
    procedure SetTemplateName(aTemplateName: String); override;
    procedure SetTemplateNames(aTemplateNames: TStrings); override;

  private
    FReportExplorer: TppReportExplorer;
    FDummyList: TStringList;
    FFolderLevels: TList;
    FFolderIndex: Integer;
    FItemName: String;
    FListView: TppItemList;

    function  CloseConfirmed: Boolean;
    procedure CreateNewFolder;
    procedure InitializeIcons;
    procedure ListDoubleClickEvent(Sender: TObject);
    procedure ListFolderChangeEvent(Sender: TObject);
    procedure ListSelectionChangeEvent(Sender: TObject);
    procedure SelectNewFolder;
    procedure SelectViewStyle(Value: Boolean);
    procedure SetReportExplorer(aExplorer: TppReportExplorer);
    procedure UpdateDropDownList;

  public
    property ReportExplorer: TppReportExplorer read FReportExplorer write SetReportExplorer;

    property ItemName: String read FItemName write FItemName;

  end; {class, TppOpenSaveDialog}

var
  ppOpenSaveDialog: TppOpenSaveDialog;

implementation

uses
  ppToolResources;

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.FormCreate }

procedure TppOpenSaveDialog.FormCreate(Sender: TObject);
begin

  FFolderLevels := TList.Create;
  FDummyList := TStringList.Create;

  InitializeIcons;

  if (FListView = nil) then
    begin
      FListView := TppItemList.Create(Self);
      FListView.Parent := Self;
      FListView.PopupMenu := ppmItems;
      FListView.ViewStyle := vsList;

      FListView.Left := lblSaveIn.Left;
      FListView.Top := spbUpOneLevel.Top + spbUpOneLevel.Height + 8;
      FListView.Width := (btnOK.Left + btnOK.Width) - lblSaveIn.Left;
      FListView.Height := (btnOK.Top - FListView.Top) - 8;

      FListView.Columns[0].Width := FListView.Width;

      FListView.OnDoubleClick := ListDoubleClickEvent;
      FListView.OnFolderChange := ListFolderChangeEvent;
      FListView.OnSelectionChange := ListSelectionChangeEvent;
    end;

end;  {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.FormDestroy }

procedure TppOpenSaveDialog.FormDestroy(Sender: TObject);
begin
  FFolderLevels.Free;
  FDummyList.Free;
end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.InitializeIcons }

procedure TppOpenSaveDialog.InitializeIcons;
begin
  spbUpOneLevel.Glyph.Handle := ppBitmapFromResource('PPUPONEFOLDER');
  spbNewFolder.Glyph.Handle := ppBitmapFromResource('PPNEWFOLDER');
  spbListView.Glyph.Handle := ppBitmapFromResource('PPLIST');
  spbDetailView.Glyph.Handle := ppBitmapFromResource('PPDETAILS');

  ToolImageList.AddTool('PPOPENFOLDER');
  ToolImageList.AddTool('PPOPENFOLDERSHADED');
  ToolImageList.AddTool('PPFOLDER');
  ToolImageList.AddTool('PPFOLDERSHADED');
  ToolImageList.AddTool('PPREPORT');

end; {procedure, InitializeIcons}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.SetReportExplorer }

procedure TppOpenSaveDialog.SetReportExplorer(aExplorer: TppReportExplorer);
begin
  FReportExplorer := aExplorer;

  FListView.ReportExplorer := aExplorer;

end; {procedure, SetReportExplorer}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.btnSaveClick }

procedure TppOpenSaveDialog.btnOKClick(Sender: TObject);
begin
  if CloseConfirmed then
    ModalResult := mrOK;
end; {procedure, btnSaveClick}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.btnHelpClick }

procedure TppOpenSaveDialog.btnHelpClick(Sender: TObject);
begin
  DoOnHelpClick;
end; {procedure, btnHelpClick}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.spbListViewClick }

procedure TppOpenSaveDialog.spbListViewClick(Sender: TObject);
begin
  SelectViewStyle(True);
end;

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.spbDetailViewClick }

procedure TppOpenSaveDialog.spbDetailViewClick(Sender: TObject);
begin
  SelectViewStyle(False);
end;

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.edtReportNameChange }

procedure TppOpenSaveDialog.edtItemNameChange(Sender: TObject);
begin
  ItemName := edtItemName.Text;
end; {procedure, edtReportNameChange}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.spbUpOneLevelClick }

procedure TppOpenSaveDialog.spbUpOneLevelClick(Sender: TObject);
begin
  FolderId := Integer(cbxFolders.Items.Objects[cbxFolders.ItemIndex]);

  if (FolderId = 0) then Exit;

  FolderId := FReportExplorer.GetParentId(FolderId);

  SelectNewFolder;

end; {procedure, spbUpOneLevelClick}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.cbxFoldersChange }

procedure TppOpenSaveDialog.cbxFoldersChange(Sender: TObject);
begin
  FolderId := Integer(cbxFolders.Items.Objects[cbxFolders.ItemIndex]);

  SelectNewFolder;
end;

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.ListSelectionChangeEvent }

procedure TppOpenSaveDialog.ListSelectionChangeEvent(Sender: TObject);
begin

  if (FListView.ItemType = ItemType) and (FListView.ItemName <> '') then
    edtItemName.Text := FListView.ItemName;

  if (FListView.ItemType = itFolder) then
    begin
      ppmDelete.Enabled := (foAllowDelete in FReportExplorer.FolderOptions);
      ppmRename.Enabled := (foAllowRename in FReportExplorer.FolderOptions);
    end
  else
    begin
      ppmDelete.Enabled := (ioAllowDelete in FReportExplorer.ItemOptions);
      ppmRename.Enabled := (ioAllowRename in FReportExplorer.ItemOptions);
    end;
    
end; {procedure, ListSelectionChangeEvent}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.ListDoubleClickEvent }

procedure TppOpenSaveDialog.ListDoubleClickEvent(Sender: TObject);
begin

  if (FListView.ItemType = ItemType) then
    begin
      ItemName := FListView.ItemName;

      if CloseConfirmed then
        ModalResult := mrOK;
    end;

end; {procedure, ListDoubleClickEvent}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.ListFolderChangeEvent }

procedure TppOpenSaveDialog.ListFolderChangeEvent(Sender: TObject);
begin
  FolderId := FListView.FolderId;

  SelectNewFolder;
end; {procedure, ListFolderChangeEvent}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.spbNewFolderClick }

procedure TppOpenSaveDialog.spbNewFolderClick(Sender: TObject);
begin
  CreateNewFolder;
end; {procedure, spbNewFolderClick}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.UpdateDropDownList }

procedure TppOpenSaveDialog.UpdateDropDownList;
var
  lFolders: TStringList;
  lParentFolders: TStringList;
  liIndex: Integer;
  liIndex2: Integer;
  lFolderInfo: TppFolderInfo;
  lsParentName: String;
  liSelected: Integer;
  liLevel: Integer;
begin

  lFolders := TStringList.Create;
  lParentFolders := TStringList.Create;

  FFolderLevels.Clear;

  {get root folders (those assigned to 'All Folders')}
  FReportExplorer.GetChildFolders(0, lFolders);

  for liIndex := 0 to lFolders.Count - 1 do
    FFolderLevels.Add(TObject(1));

  {get chain of parent folders for current folder}
  FReportExplorer.GetParentFolders(FolderId, lParentFolders);

  {insert the current folder at the top of the parent folder chain}
  if (FolderId <> 0) then
    begin
      lFolderInfo := TppFolderInfo.Create;
      lFolderInfo.FolderId := FolderId;
      lFolderInfo.Name := FReportExplorer.GetFolderName(FolderId);
      lFolderInfo.ParentId := FReportExplorer.GetParentId(FolderId);

      lParentFolders.InsertObject(0, lFolderInfo.Name, lFolderInfo);
    end;

  if (lParentFolders.Count > 0) then
    begin
      {locate parent folder}
      lsParentName := lParentFolders[lParentFolders.Count - 1];

      liIndex := lFolders.IndexOf(lsParentName);

      {if parent folder found, remove it from the parent folder chain}
      if (liIndex <> -1) then
        begin
          lFolderInfo := TppFolderInfo(lParentFolders.Objects[lParentFolders.Count - 1]);

          lFolderInfo.Free;
          
          lParentFolders.Delete(lParentFolders.Count - 1);
        end
      else
        liIndex := 0;

      {insert chain of parent folders in folder list}
      for liIndex2 := 0 to lParentFolders.Count - 1 do
        begin
          lFolderInfo := TppFolderInfo(lParentFolders.Objects[liIndex2]);

          lFolders.InsertObject(liIndex + 1, lFolderInfo.Name, lFolderInfo);

          liLevel := lParentFolders.Count - liIndex2 + 1;

          FFolderLevels.Insert(liIndex + 1, TObject(liLevel));
        end;
    end;

  {transfer completed folder list to combo box}
  cbxFolders.Items.BeginUpdate;

  cbxFolders.Items.Clear;

  liSelected := -1;
  
  {insert main folder at top of list}
  lFolderInfo := TppFolderInfo.Create;
  lFolderInfo.FolderId := 0;
  lFolderInfo.Name := ppLoadStr(524); {All Folders}
  lFolderInfo.ParentId := -1;

  lFolders.InsertObject(0, lFolderInfo.Name, lFolderInfo);
  FFolderLevels.Insert(0, TObject(0));

  for liIndex := 0 to lFolders.Count - 1 do
    begin
      lFolderInfo := TppFolderInfo(lFolders.Objects[liIndex]);

      cbxFolders.Items.AddObject(lFolderInfo.Name, TObject(lFolderInfo.FolderId));

      if (lFolderInfo.FolderId = FolderId) then
        liSelected := liIndex;

      lFolderInfo.Free;
    end;

  cbxFolders.ItemIndex := liSelected;
  
  cbxFolders.Items.EndUpdate;

  spbUpOneLevel.Enabled := (FolderId <> 0);

  lFolders.Free;
  lParentFolders.Free;

end; {procedure, UpdateDropDownList}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.CloseConfirmed }

function TppOpenSaveDialog.CloseConfirmed: Boolean;
var
  lsMessage: String;
  liIndex: Integer;
  lbFound: Boolean;
  lItem: TListItem;
begin

  if (ItemName = '') then
    begin
      Result := False;
      Exit;
    end;


  {does report already exist with this name?}
  liIndex := 0;
  lbFound := False;

  while (liIndex < FListView.Items.Count) and not(lbFound) do
    begin
      lItem := FListView.Items[liIndex];

      if ((lItem.ImageIndex + 1) = ItemType) and (CompareText(lItem.Caption, ItemName) = 0) then
        lbFound := True
      else
        Inc(liIndex);
    end;

  if (DialogType = ppdtOpen) then
    begin
      Result := lbFound;

      {Item not found: <name>}
      lsMessage := ppLoadStr(560);
      lsMessage := ppSetMessageParameters(lsMessage);
      lsMessage := Format(lsMessage, [ItemName]);

      if not(lbFound) then
        MessageDlg(lsMessage, mtInformation, [mbOK], 0);
    end
  else
    begin
      if lbFound then
        begin
          {<name> already exists.}
          lsMessage := ppLoadStr(523);
          lsMessage := ppSetMessageParameters(lsMessage);
          lsMessage := Format(lsMessage, [ItemName]);

          lsMessage := lsMessage + #13#10 + ppLoadStr(550);

          Result := (MessageDlg(lsMessage, mtConfirmation, [mbYes, mbNo], 0) = mrYes);
        end
      else
        Result := True;
    end;

end; {function, CloseConfirmed}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.CreateNewFolder }

procedure TppOpenSaveDialog.CreateNewFolder;
var
  lItem: TListItem;
  lsName: String;
  liFolderId: Integer;
begin

  lsName := FReportExplorer.GetNewFolderName(FolderId);

  {create the folder record}
  FReportExplorer.AddFolder(FolderId, lsName, liFolderId);

  FListView.Items.BeginUpdate;

  lItem := FListView.Items.Add;
  lItem.Caption := lsName;
  lItem.Data := TObject(liFolderId);
  lItem.ImageIndex := itFolder - 1;

  FListView.Selected := lItem;

  FListView.Items.EndUpdate;

  FListView.Selected.EditCaption;
  
end; {procedure, CreateNewFolder}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.SelectNewFolder }

procedure TppOpenSaveDialog.SelectNewFolder;
begin

  UpdateDropDownList;

  FListView.ItemTypeFilter := ItemType;
  FListView.FolderId := FolderId;

end; {procedure, SelectNewFolder}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.SelectViewStyle }

procedure TppOpenSaveDialog.SelectViewStyle(Value: Boolean);
begin
  if Value then
    begin
      ppmViewList.Checked := True;
      spbListView.Down := True;
      spbDetailView.Down := False;

      FListView.Columns[0].Width := FListView.Width;
      FListView.ViewStyle := vsList;
    end
  else
    begin
      ppmViewDetails.Checked := True;
      spbListView.Down := False;
      spbDetailView.Down := True;

      FListView.Columns[0].Width := 250;
      FListView.ViewStyle := vsReport;
    end;

end; {procedure, SelectViewStyle}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.GetTemplateName }

function TppOpenSaveDialog.GetTemplateName: String;
begin
  Result := ItemName;
end; {procedure, GetTemplateName}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.GetTemplateNames }

function TppOpenSaveDialog.GetTemplateNames: TStrings;
begin
  Result := FDummyList;
end; {procedure, GetTemplateNames}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.SetTemplateName }

procedure TppOpenSaveDialog.SetTemplateName(aTemplateName: String);
begin
  ItemName := aTemplateName;
end; {procedure, SetTemplateName}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.SetTemplateNames }

procedure TppOpenSaveDialog.SetTemplateNames(aTemplateNames: TStrings);
begin

end; {procedure, SetTemplateNames}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.Activate }

procedure TppOpenSaveDialog.Activate;
begin
  inherited Activate;

  UpdateDropDownList;

  FListView.ItemTypeFilter := ItemType;
  FListView.FolderId := FolderId;

  if DialogType = ppdtOpen then
    begin
      Caption := ppLoadStr(361); {Open}
      btnOK.Caption := ppLoadStr(134); {&Open}
      btnCancel.Caption := ppLoadStr(ppMsgCancel);

      lblSaveIn.Caption := ppLoadStr(567); {Look &in:}

      FListView.MultiSelect := True;
    end

  else if DialogType = ppdtSave then
    begin
      Caption := ppLoadStr(362) + ' ' + ItemName + ' ' +
                 ppLoadStr(38); {Save <name> As}
      btnOK.Caption := ppLoadStr(138); {&Save}
      btnCancel.Caption := ppLoadStr(ppMsgCancel);

      lblSaveIn.Caption := ppLoadStr(582); {Save &in:}

      FListView.MultiSelect := False;
    end;

  btnHelp.Caption := ppLoadStr(557); {Help}
  btnHelp.Visible := HelpEventAssigned;

  if not(btnHelp.Visible) then
    ClientHeight := btnCancel.Top + btnCancel.Height + 8;
    
  lblItemName.Caption := ppLoadStr(39); {Name}
  edtItemName.Text := ItemName;
  edtItemName.SelectAll;

  spbUpOneLevel.Hint := ppLoadStr(589); {Up One Level}
  spbNewFolder.Hint := ppLoadStr(545); {Create New Folder}
  spbListView.Hint := ppLoadStr(566); {List}
  spbDetailView.Hint := ppLoadStr(549); {Details}

  ppmView.Caption := ppLoadStr(155); {&View}
  ppmViewList.Caption := ppLoadStr(510); {&List}
  ppmViewDetails.Caption := ppLoadStr(508); {&Details}
  ppmNewFolder.Caption := ppLoadStr(558); {New &Folder}
  ppmDelete.Caption := ppLoadStr(124); {&Delete}
  ppmRename.Caption := ppLoadStr(542); {&Rena&me}

  spbNewFolder.Visible := (foAllowNew in FReportExplorer.FolderOptions);
  ppmNewFolder.Visible := (foAllowNew in FReportExplorer.FolderOptions);

  ppmDelete.Visible := (foAllowDelete in FReportExplorer.FolderOptions) or (ioAllowDelete in FReportExplorer.ItemOptions);
  ppmRename.Visible := (foAllowRename in FReportExplorer.FolderOptions) or (ioAllowRename in FReportExplorer.ItemOptions);

  SelectViewStyle(True);

  FListView.LanguageIndex := LanguageIndex;

  ActiveControl := edtItemName;

end;  {procedure, Activate}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.cbxFoldersDrawItem }

procedure TppOpenSaveDialog.cbxFoldersDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  liOffset: Integer;
begin

  {clear drawing area}
  cbxFolders.Canvas.FillRect(Rect);

  liOffset := 1;

  liOffset := liOffset + (Integer(FFolderLevels[Index]) * 20);

  {draw bitmap}
  if not(cbxFolders.DroppedDown) or (Index = FFolderIndex) then
    begin
      {draw open folder}
       if (odSelected in State) then
         ToolImageList.Draw(cbxFolders.Canvas, Rect.Left + liOffset, Rect.Top, ToolImageList.IndexOfTool('PPOPENFOLDERSHADED'))
       else
         ToolImageList.Draw(cbxFolders.Canvas, Rect.Left + liOffset, Rect.Top, ToolImageList.IndexOfTool('PPOPENFOLDER'));
    end
  else
    begin
      {draw closed folder}
       if (odSelected in State) then
         ToolImageList.Draw(cbxFolders.Canvas, Rect.Left + liOffset, Rect.Top, ToolImageList.IndexOfTool('PPFOLDERSHADED'))
       else
         ToolImageList.Draw(cbxFolders.Canvas, Rect.Left + liOffset, Rect.Top, ToolImageList.IndexOfTool('PPFOLDER'));
    end;

  {draw text}
  liOffset := liOffset + 20;

  cbxFolders.Canvas.TextOut(Rect.Left + liOffset, Rect.Top, cbxFolders.Items[Index]);

end;  {procedure, cbxFoldersDrawItem}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.cbxFoldersDropDown }

procedure TppOpenSaveDialog.cbxFoldersDropDown(Sender: TObject);
begin
  FFolderIndex := cbxFolders.ItemIndex;
end; {procedure, cbxFoldersDropDown}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.ppmDeleteClick }

procedure TppOpenSaveDialog.ppmDeleteClick(Sender: TObject);
begin
  FListView.DeleteSelection;
end; {procedure, ppmDeleteClick}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.ppmRenameClick }

procedure TppOpenSaveDialog.ppmRenameClick(Sender: TObject);
begin
  FListView.RenameItem;
end; {procedure, ppmRenameClick}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.ppmListViewClick }

procedure TppOpenSaveDialog.ppmViewListClick(Sender: TObject);
begin
  SelectViewStyle(True);
end; {procedure, ppmListViewClick}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.ppmDetailViewClick }

procedure TppOpenSaveDialog.ppmViewDetailsClick(Sender: TObject);
begin
  SelectViewStyle(False);
end; {procedure, ppmDetailViewClick}

{------------------------------------------------------------------------------}
{ TppOpenSaveDialog.ppmNewFolderClick }

procedure TppOpenSaveDialog.ppmNewFolderClick(Sender: TObject);
begin
  CreateNewFolder;
end; {procedure, ppmNewFolderClick}



procedure TppOpenSaveDialog.cbxFoldersMeasureItem(Control: TWinControl; Index: Integer; var Height: Integer);
begin
 {adjust height of list box for large fonts}
  Height := Trunc(Screen.PixelsPerInch * 0.15625);
end;

end.
