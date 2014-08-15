{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxCustomTableViewEditor;

{$I cxGridVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Windows,
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Menus,
  cxClasses, cxCustomData, cxDBData, cxNavigator, cxGridCustomView, cxGridCustomTableView,
  cxGridStructureNavigator, cxViewEditor;

type
  TcxCustomTableViewEditor = class(TcxViewEditor)
    PageControl1: TPageControl;
    TSItems: TTabSheet;
    TSSummary: TTabSheet;
    Panel1: TPanel;
    LBColumns: TListBox;
    BColumnAdd: TButton;
    BColumnAddEx: TButton;
    BColumnDelete: TButton;
    BColumnAddAll: TButton;
    BColumnRestore: TButton;
    PMColumns: TPopupMenu;
    MIColumnAdd: TMenuItem;
    MIColumnDelete: TMenuItem;
    MIColumnRestore: TMenuItem;
    MIColumnSelectAll: TMenuItem;
    PageControl2: TPageControl;
    TSFooterSummaryItems: TTabSheet;
    TSDefaultGroupSummaryItems: TTabSheet;
    TabSheet3: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    BAddFooterSummaryItem: TButton;
    BDeleteFooterSummaryItem: TButton;
    LBFooterSummary: TListBox;
    Panel4: TPanel;
    Label1: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    BDefaultGroupSummaryAdd: TButton;
    BDefaultGroupSummaryDelete: TButton;
    LBDefaultGroupsSummary: TListBox;
    Panel7: TPanel;
    Label2: TLabel;
    PSummaryGroups: TPanel;
    PLinks: TPanel;
    Label3: TLabel;
    PGroupItems: TPanel;
    Panel11: TPanel;
    BGroupSummaryItemAdd: TButton;
    BGroupSummaryItemDelete: TButton;
    LBGroupSummaryItems: TListBox;
    Panel12: TPanel;
    Label4: TLabel;
    PGroups: TPanel;
    Panel14: TPanel;
    BSummaryGroupAdd: TButton;
    BSummaryGroupDelete: TButton;
    LBSummaryGroups: TListBox;
    Panel15: TPanel;
    Label5: TLabel;
    PUnlinkedColumns: TPanel;
    LBUnlinkedColumns: TListBox;
    Panel19: TPanel;
    Label6: TLabel;
    PLinkUnlink: TPanel;
    PLinkedColumns: TPanel;
    LBLinkedColumns: TListBox;
    Panel23: TPanel;
    Label7: TLabel;
    BColumnLink: TButton;
    BColumnUnlink: TButton;
    Splitter2: TSplitter;
    PGSeparator: TPanel;
    N1: TMenuItem;
    BColumnMoveUp: TButton;
    BColumnMoveDown: TButton;
    N2: TMenuItem;
    MIColumnMoveUp: TMenuItem;
    MIColumnMoveDown: TMenuItem;
    PMFooterSummary: TPopupMenu;
    MIFooterSummaryAdd: TMenuItem;
    MIFooterSummaryDelete: TMenuItem;
    MenuItem4a: TMenuItem;
    MIFooterSummarySelectAll: TMenuItem;
    PMDefaultGroupsSummary: TPopupMenu;
    MIDefaultGroupSummaryAdd: TMenuItem;
    MIDefaultGroupSummaryDelete: TMenuItem;
    MenuItem3b: TMenuItem;
    MIDefaultGroupSummarySelectAll: TMenuItem;
    PMSummaryGroups: TPopupMenu;
    MISummaryGroupAdd: TMenuItem;
    MISummaryGroupDelete: TMenuItem;
    MenuItem5d: TMenuItem;
    MISummaryGroupSelectAll: TMenuItem;
    PMGroupSummaryItems: TPopupMenu;
    MIGroupSummaryItemsAdd: TMenuItem;
    MIGroupSummaryItemsDelete: TMenuItem;
    MenuItem6c: TMenuItem;
    MIGroupSummaryItemsSelectAll: TMenuItem;
    procedure LBColumnsClick(Sender: TObject);
    procedure BColumnAddClick(Sender: TObject);
    procedure BColumnAddExClick(Sender: TObject);
    procedure BColumnDeleteClick(Sender: TObject);
    procedure BColumnRestoreClick(Sender: TObject);
    procedure MIColumnSelectAllClick(Sender: TObject);
    procedure LBFooterSummaryClick(Sender: TObject);
    procedure BAddFooterSummaryItemClick(Sender: TObject);
    procedure BDeleteFooterSummaryItemClick(Sender: TObject);
    procedure LBDefaultGroupsSummaryClick(Sender: TObject);
    procedure BDefaultGroupSummaryAddClick(Sender: TObject);
    procedure BDefaultGroupSummaryDeleteClick(Sender: TObject);
    procedure LBSummaryGroupsClick(Sender: TObject);
    procedure BSummaryGroupAddClick(Sender: TObject);
    procedure BSummaryGroupDeleteClick(Sender: TObject);
    procedure LBGroupSummaryItemsClick(Sender: TObject);
    procedure BGroupSummaryItemAddClick(Sender: TObject);
    procedure BGroupSummaryItemDeleteClick(Sender: TObject);
    procedure LBUnlinkedColumnsClick(Sender: TObject);
    procedure BColumnLinkClick(Sender: TObject);
    procedure BColumnUnlinkClick(Sender: TObject);
    procedure BColumnAddAllClick(Sender: TObject);
    procedure PLinksResize(Sender: TObject);
    procedure PSummaryGroupsResize(Sender: TObject);
    procedure LBColumnsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LBColumnsEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure LBColumnsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure LBColumnsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BColumnMoveUpClick(Sender: TObject);
    procedure BColumnMoveDownClick(Sender: TObject);
    procedure MIFooterSummarySelectAllClick(Sender: TObject);
    procedure MIDefaultGroupSummarySelectAllClick(Sender: TObject);
    procedure MISummaryGroupSelectAllClick(Sender: TObject);
    procedure MIGroupSummaryItemsSelectAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LBColumnsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FColumnsPrevDragIndex: Integer;
    function GetDefaultGroupSummaryItems: TcxDataGroupSummaryItems;
    function GetFooterSummaryItems: TcxDataFooterSummaryItems;
    function GetSummaryGroups: TcxDataSummaryGroups;
    function GetView: TcxCustomGridTableView;
    procedure ReindexColumnsProc(AList: TList; ANewIndex: Integer);
    procedure UpdateSummaryGroupLinks;
    procedure UpdateSummaryGroups;
  protected
    procedure CollectionItemsAdd(AListBox: TListBox; ACollection: TCollection);
    procedure CollectionItemsClick(AListBox: TListBox; APersistent: TPersistent);
    procedure CollectionItemsDelete(AListBox: TListBox; ACollection: TCollection);
    function GetCurrentGroup: TcxDataSummaryGroup;
    function GetDeleteItemsCaption: string; virtual;
    procedure SelectAllColumns;
    procedure UpdateButtons; virtual;
    procedure UpdateColumnList; virtual;
    procedure UpdateColumnListSelection; virtual;
    procedure UpdateEditor; override;
    procedure UpdateSelection; override;
    procedure UpdateSummary;
    procedure UpdateSummarySelection;
  public
    class function GetViewByObject(APersistent: TPersistent): TcxCustomGridView; override;
    property DefaultGroupSummaryItems: TcxDataGroupSummaryItems read GetDefaultGroupSummaryItems;
    property FooterSummaryItems: TcxDataFooterSummaryItems read GetFooterSummaryItems;
    property SummaryGroups: TcxDataSummaryGroups read GetSummaryGroups;
    property View: TcxCustomGridTableView read GetView;
  end;

  { TcxCustomGridTableViewStorage }

  TcxCustomGridTableViewStorage = class(TcxCustomGridViewStorage)
  private
    function GetNavigatorButtons: TcxNavigatorControlButtons;
  protected
    function CustomTableView: TcxCustomGridTableView;
  public
    class function GetViewClass: TcxCustomGridViewClass; override;
  published
    property NavigatorButtons: TcxNavigatorControlButtons read GetNavigatorButtons;
  end;

implementation

uses
  cxDesignWindows;

{$R *.dfm}

function CheckInDataController(APersistent: TPersistent): TcxCustomGridView;
var
  ADataController: TcxCustomDataController;
  AIDataController: IcxCustomGridDataController;
begin
  ADataController := nil;
  if APersistent is TcxCustomDataSummaryItem then
    ADataController := (APersistent as TcxCustomDataSummaryItem).DataController
  else
  if APersistent is TcxDataSummaryItems then
    ADataController := (APersistent as TcxDataSummaryItems).DataController
  else
  if APersistent is TcxDataSummaryGroups then
    ADataController := (APersistent as TcxDataSummaryGroups).Summary.DataController
  else
  if APersistent is TcxDataSummaryGroup then
    ADataController := (APersistent as TcxDataSummaryGroup).SummaryGroups.Summary.DataController
  else
  if APersistent is TcxDataSummaryGroupItemLinks then
    ADataController :=
      (APersistent as TcxDataSummaryGroupItemLinks).SummaryGroup.SummaryGroups.Summary.DataController;
  if (ADataController <> nil) and Supports(ADataController, IcxCustomGridDataController) then
  begin
    ADataController.GetInterface(IcxCustomGridDataController, AIDataController);
    Result := AIDataController.GridView;
  end
  else
    Result := nil;
end;

{ TcxCustomGridTableViewStorage }

function TcxCustomGridTableViewStorage.GetNavigatorButtons: TcxNavigatorControlButtons;
begin
  Result := CustomTableView.NavigatorButtons;
end;

function TcxCustomGridTableViewStorage.CustomTableView: TcxCustomGridTableView;
begin
  Result := inherited View as TcxCustomGridTableView;
end;

class function TcxCustomGridTableViewStorage.GetViewClass: TcxCustomGridViewClass;
begin
  Result := TcxCustomGridTableView;
end;

{ TcxCustomTableViewEditor }

class function TcxCustomTableViewEditor.GetViewByObject(APersistent: TPersistent): TcxCustomGridView;
begin
  // Items
  if APersistent is TcxCustomGridTableItem then
    Result := (APersistent as TcxCustomGridTableItem).GridView
  else
    // DataController
    Result := CheckInDataController(APersistent);
end;

procedure TcxCustomTableViewEditor.CollectionItemsAdd(AListBox: TListBox;
  ACollection: TCollection);
var
  AItem: TCollectionItem;
begin
  ListBoxClearSelection(AListBox);
  AItem := ACollection.Add;
  ListBoxLoadCollection(AListBox, ACollection);
  ListBoxSelectByObject(AListBox, AItem);
  CollectionItemsClick(AListBox, nil);
  UpdateDesigner;
end;

procedure TcxCustomTableViewEditor.CollectionItemsClick(AListBox: TListBox;
  APersistent: TPersistent);
var
  AList: TList;
begin
  BeginUpdate;
  try
    AList := TList.Create;
    try
      ListBoxGetSelection(AListBox, AList);
      FormEditor.SelectComponents(AList, APersistent);
    finally
      AList.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomTableViewEditor.CollectionItemsDelete(AListBox: TListBox;
  ACollection: TCollection);
begin
  if AListBox.SelCount > 0 then
  begin
    BeginUpdate;
    try
      ListBoxDeleteSelection(AListBox, True);
      ListBoxLoadCollection(AListBox, ACollection);
      CollectionItemsClick(AListBox, ACollection);
      UpdateDesigner;
    finally
      EndUpdate;
    end;
  end;
end;

function TcxCustomTableViewEditor.GetCurrentGroup: TcxDataSummaryGroup;

  function GetGroupByItems(ASummaryItems: TcxDataSummaryItems): TcxDataSummaryGroup;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to SummaryGroups.Count - 1 do
      if SummaryGroups[I].SummaryItems = ASummaryItems then
      begin
        Result := SummaryGroups[I];
        Break;
      end;
  end;

  function GetGroupByItemLinks(ASummaryGroupItemLinks: TcxDataSummaryGroupItemLinks): TcxDataSummaryGroup;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to SummaryGroups.Count - 1 do
      if SummaryGroups[I].Links = ASummaryGroupItemLinks then
      begin
        Result := SummaryGroups[I];
        Break;
      end;
  end;

  function GetSummaryGroup(APersistent: TPersistent): TcxDataSummaryGroup;
  begin
    if APersistent is TcxDataSummaryGroup then
      Result := APersistent as TcxDataSummaryGroup
    else
    if APersistent is TcxDataSummaryItem then
      Result := GetGroupByItems((APersistent as TcxDataSummaryItem).SummaryItems)
    else
    if APersistent is TcxDataSummaryItems then
      Result := GetGroupByItems(APersistent as TcxDataSummaryItems)
    else
    if APersistent is TcxDataSummaryGroupItemLink then
      Result := GetGroupByItemLinks((APersistent as TcxDataSummaryGroupItemLink).SummaryGroupItemLinks)
    else
    if APersistent is TcxDataSummaryGroupItemLinks then
      Result := GetGroupByItemLinks(APersistent as TcxDataSummaryGroupItemLinks)
    else
      Result := nil;
  end;

var
  AList: TList;
  I: Integer;
  ASummaryGroup: TcxDataSummaryGroup;
begin
  Result := nil;
  AList := TList.Create;
  try
    GetSelectionList(AList);
    for I := 0 to AList.Count - 1 do
    begin
      ASummaryGroup := GetSummaryGroup(AList[I]);
      if (ASummaryGroup <> nil) and (GetViewByObject(ASummaryGroup) <> View) then
        Continue;
      if Result = nil then
        Result := ASummaryGroup
      else
      begin
        if Result <> ASummaryGroup then
        begin
          Result := nil;
          Break;
        end;    
      end;
    end;
  finally
    AList.Free;
  end;
end;

function TcxCustomTableViewEditor.GetDeleteItemsCaption: string;
begin
  Result := 'Delete existing columns?';
end;

procedure TcxCustomTableViewEditor.SelectAllColumns;
begin
  ListBoxSelectAll(LBColumns);
end;

procedure TcxCustomTableViewEditor.UpdateButtons;
begin
  // Columns
  BColumnDelete.Enabled := LBColumns.SelCount > 0;
  BColumnRestore.Enabled := LBColumns.SelCount > 0;
  BColumnMoveUp.Enabled := LBColumns.SelCount > 0;
  BColumnMoveDown.Enabled := LBColumns.SelCount > 0;
  BColumnAddAll.Enabled := IsViewDataLinked(View);

  MIColumnDelete.Enabled := BColumnDelete.Enabled;
  MIColumnRestore.Enabled := BColumnRestore.Enabled;
  MIColumnMoveUp.Enabled := BColumnMoveUp.Enabled;
  MIColumnMoveDown.Enabled := BColumnMoveDown.Enabled;
  MIColumnSelectAll.Enabled := LBColumns.SelCount < LBColumns.Items.Count;
  // Summary
  BDeleteFooterSummaryItem.Enabled := LBFooterSummary.SelCount > 0;
  BDefaultGroupSummaryDelete.Enabled := LBDefaultGroupsSummary.SelCount > 0;
  BSummaryGroupDelete.Enabled := LBSummaryGroups.SelCount > 0;
  BGroupSummaryItemAdd.Enabled := GetCurrentGroup <> nil;
  BGroupSummaryItemDelete.Enabled := BGroupSummaryItemAdd.Enabled and
    (LBGroupSummaryItems.SelCount > 0);
  BColumnLink.Enabled := LBUnlinkedColumns.SelCount > 0;
  BColumnUnlink.Enabled := LBLinkedColumns.SelCount > 0;

  MIFooterSummaryDelete.Enabled := BDeleteFooterSummaryItem.Enabled;
  MIFooterSummarySelectAll.Enabled := LBFooterSummary.SelCount < LBFooterSummary.Items.Count;

  MIDefaultGroupSummaryDelete.Enabled := BDefaultGroupSummaryDelete.Enabled;
  MIDefaultGroupSummarySelectAll.Enabled := LBDefaultGroupsSummary.SelCount < LBDefaultGroupsSummary.Items.Count;

  MISummaryGroupDelete.Enabled := BSummaryGroupDelete.Enabled;
  MISummaryGroupSelectAll.Enabled := LBSummaryGroups.SelCount < LBSummaryGroups.Items.Count;

  MIGroupSummaryItemsAdd.Enabled := BGroupSummaryItemAdd.Enabled; 
  MIGroupSummaryItemsDelete.Enabled := BGroupSummaryItemDelete.Enabled;
  MIGroupSummaryItemsSelectAll.Enabled := LBGroupSummaryItems.SelCount < LBGroupSummaryItems.Items.Count;
end;

procedure TcxCustomTableViewEditor.UpdateColumnList;
var
  I, AItemIndex, ATopIndex: Integer;
  ASelection: TStringList;
  S: string;
begin
  ListBoxSaveSelection(LBColumns, ASelection, AItemIndex, ATopIndex);
  try
    LBColumns.Items.Clear;
    for I := 0 to View.ItemCount - 1 do
    begin
      S := View.Items[I].Name;
      if View.Items[I].RepositoryItem <> nil then
        S := S + ' (' + View.Items[I].RepositoryItem.Name + ')'; // TODO: description
      LBColumns.Items.AddObject(S, View.Items[I]);
    end;
  finally
    ListBoxRestoreSelection(LBColumns, ASelection, AItemIndex, ATopIndex);
  end;
end;

procedure TcxCustomTableViewEditor.UpdateColumnListSelection;
var
  AList: TList;
begin
  AList := TList.Create;
  try
    FormEditor.GetSelectionList(AList);
    ListBoxSyncSelection(LBColumns, AList);
  finally
    AList.Free;
  end;
end;

procedure TcxCustomTableViewEditor.UpdateEditor;
begin
  BColumnAddAll.Visible := IsViewDataBound(View);
  UpdateColumnList;
  UpdateSummary;
end;

procedure TcxCustomTableViewEditor.UpdateSelection;
begin
  UpdateColumnListSelection;
  UpdateSummarySelection;
  UpdateButtons;
end;

procedure TcxCustomTableViewEditor.UpdateSummary;
begin
  ListBoxLoadCollection(LBFooterSummary, FooterSummaryItems);
  ListBoxLoadCollection(LBDefaultGroupsSummary, DefaultGroupSummaryItems);
  ListBoxLoadCollection(LBSummaryGroups, SummaryGroups);
  UpdateSummaryGroups;
end;

procedure TcxCustomTableViewEditor.UpdateSummarySelection;
var
  AList: TList;
  ACurrentGroup: TcxDataSummaryGroup;
begin
  AList := TList.Create;
  try
    FormEditor.GetSelectionList(AList);
    ListBoxSyncSelection(LBFooterSummary, AList);
    ListBoxSyncSelection(LBDefaultGroupsSummary, AList);
    ACurrentGroup := GetCurrentGroup;
    ListBoxSyncSelection(LBSummaryGroups, AList);
    if ACurrentGroup <> GetCurrentGroup then
      UpdateSummaryGroups;
    ListBoxSyncSelection(LBGroupSummaryItems, AList);
  finally
    AList.Free;
  end;
end;

function TcxCustomTableViewEditor.GetDefaultGroupSummaryItems: TcxDataGroupSummaryItems;
begin
  Result := View.DataController.Summary.DefaultGroupSummaryItems;
end;

function TcxCustomTableViewEditor.GetFooterSummaryItems: TcxDataFooterSummaryItems;
begin
  Result := View.DataController.Summary.FooterSummaryItems;
end;

function TcxCustomTableViewEditor.GetSummaryGroups: TcxDataSummaryGroups;
begin
  Result := View.DataController.Summary.SummaryGroups;
end;

function TcxCustomTableViewEditor.GetView: TcxCustomGridTableView;
begin
  Result := inherited View as TcxCustomGridTableView;
end;

procedure TcxCustomTableViewEditor.ReindexColumnsProc(AList: TList; ANewIndex: Integer);
var
  I: Integer;
begin
  if AList.Count = 0 then Exit;
  if TcxCustomGridTableItem(AList[0]).Index < ANewIndex then
  begin
    for I := 0 to AList.Count - 1 do
      TcxCustomGridTableItem(AList[I]).Index := ANewIndex;
  end
  else
  begin
    for I := AList.Count - 1 downto 0 do
      TcxCustomGridTableItem(AList[I]).Index := ANewIndex;
  end;
  UpdateDesigner;
end;

procedure TcxCustomTableViewEditor.UpdateSummaryGroupLinks;
var
  ACurrentGroup: TcxDataSummaryGroup;
  I: Integer;
  AItemLink: TObject;
  ADataController: TcxCustomDataController;
  AItemIndex1, ATopIndex1, AItemIndex2, ATopIndex2: Integer;
  ASelection1, ASelection2: TStringList;
begin
  ACurrentGroup := GetCurrentGroup;
  ListBoxSaveSelection(LBUnlinkedColumns, ASelection1, AItemIndex1, ATopIndex1);
  ListBoxSaveSelection(LBLinkedColumns, ASelection2, AItemIndex2, ATopIndex2);
  try
    LBUnlinkedColumns.Items.Clear;
    LBLinkedColumns.Items.Clear;
    if ACurrentGroup <> nil then
    begin
      for I := 0 to ACurrentGroup.Links.Count - 1 do
      begin
        AItemLink := ACurrentGroup.Links[I].ItemLink;
        if AItemLink is TComponent then
          LBLinkedColumns.Items.AddObject((AItemLink as TComponent).Name, AItemLink);
      end;
      ADataController := ACurrentGroup.SummaryGroups.Summary.DataController;
      for I := 0 to ADataController.ItemCount - 1 do
      begin
        AItemLink := ADataController.GetItem(I);
        if LBLinkedColumns.Items.IndexOfObject(AItemLink) = -1 then
          LBUnlinkedColumns.Items.AddObject((AItemLink as TComponent).Name, AItemLink);
      end;
    end;
  finally
    ListBoxRestoreSelection(LBUnlinkedColumns, ASelection1, AItemIndex1, ATopIndex1);
    ListBoxRestoreSelection(LBLinkedColumns, ASelection2, AItemIndex2, ATopIndex2);
  end;
end;

procedure TcxCustomTableViewEditor.UpdateSummaryGroups;
var
  ACurrentGroup: TcxDataSummaryGroup;
begin
  ACurrentGroup := GetCurrentGroup;
  if ACurrentGroup <> nil then
    ListBoxLoadCollection(LBGroupSummaryItems, ACurrentGroup.SummaryItems)
  else
    LBGroupSummaryItems.Items.Clear;
  UpdateSummaryGroupLinks;
end;

// Columns

procedure TcxCustomTableViewEditor.LBColumnsClick(Sender: TObject);
var
  AList: TList;
begin
  BeginUpdate;
  try
    AList := TList.Create;
    try
      ListBoxGetSelection(LBColumns, AList);
      FormEditor.SelectComponents(AList, View);
    finally
      AList.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomTableViewEditor.BColumnAddClick(Sender: TObject);
var
  AItem: TcxCustomGridTableItem;
begin
  ListBoxClearSelection(LBColumns);
  AItem := View.CreateItem;
  AItem.Name := UniqueName(AItem);
  UpdateColumnList;
  ListBoxSelectByObject(LBColumns, AItem);
  LBColumnsClick(nil);
  UpdateDesigner;
end;

procedure TcxCustomTableViewEditor.BColumnAddExClick(Sender: TObject);
begin
//
end;

procedure TcxCustomTableViewEditor.BColumnDeleteClick(Sender: TObject);
begin
  if LBColumns.SelCount > 0 then
  begin
    BeginUpdate;
    try
      ListBoxDeleteSelection(LBColumns, True);
      UpdateColumnList;
      LBColumnsClick(nil);
      UpdateDesigner;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxCustomTableViewEditor.BColumnRestoreClick(Sender: TObject);
var
  I: Integer; 
begin
  if LBColumns.SelCount > 0 then
  try
    for I := 0 to LBColumns.Items.Count - 1 do
      if LBColumns.Selected[I] then
        TcxCustomGridTableItem(LBColumns.Items.Objects[I]).RestoreDefaults;
  finally
    UpdateColumnList;
    LBColumnsClick(nil);
    UpdateDesigner;
  end;
end;

procedure TcxCustomTableViewEditor.BColumnMoveUpClick(Sender: TObject);
begin
  ListBoxMoveUpItems(LBColumns, FColumnsPrevDragIndex, ReindexColumnsProc);
end;

procedure TcxCustomTableViewEditor.BColumnMoveDownClick(Sender: TObject);
begin
  ListBoxMoveDownItems(LBColumns, FColumnsPrevDragIndex, ReindexColumnsProc);
end;

procedure TcxCustomTableViewEditor.BColumnAddAllClick(Sender: TObject);
begin
  if IsViewDataBound(View) then
  begin
    if View.ItemCount > 0 then
    begin
      case Application.MessageBox(PChar(GetDeleteItemsCaption), 'Confirm', MB_YESNOCANCEL) of
        IDYES:
          View.ClearItems;
        IDCANCEL:
          Exit;
      end;
    end;
    CreateViewAllItems(OwnerForm, View);
    UpdateColumnList;
    LBColumnsClick(nil);
    UpdateDesigner;
  end;  
end;

procedure TcxCustomTableViewEditor.MIColumnSelectAllClick(Sender: TObject);
begin
  SelectAllColumns;
  LBColumnsClick(nil);
end;

// Summary - Footer

procedure TcxCustomTableViewEditor.LBFooterSummaryClick(Sender: TObject);
begin
  CollectionItemsClick(LBFooterSummary, FooterSummaryItems);
end;

procedure TcxCustomTableViewEditor.BAddFooterSummaryItemClick(
  Sender: TObject);
begin
  CollectionItemsAdd(LBFooterSummary, FooterSummaryItems);
end;

procedure TcxCustomTableViewEditor.BDeleteFooterSummaryItemClick(
  Sender: TObject);
begin
  CollectionItemsDelete(LBFooterSummary, FooterSummaryItems);
end;

// Summary - Default Group

procedure TcxCustomTableViewEditor.LBDefaultGroupsSummaryClick(
  Sender: TObject);
begin
  CollectionItemsClick(LBDefaultGroupsSummary, DefaultGroupSummaryItems);
end;

procedure TcxCustomTableViewEditor.BDefaultGroupSummaryAddClick(Sender: TObject);
begin
  CollectionItemsAdd(LBDefaultGroupsSummary, DefaultGroupSummaryItems);
end;

procedure TcxCustomTableViewEditor.BDefaultGroupSummaryDeleteClick(
  Sender: TObject);
begin
  CollectionItemsDelete(LBDefaultGroupsSummary, DefaultGroupSummaryItems);
end;

// Summary - Groups

procedure TcxCustomTableViewEditor.LBSummaryGroupsClick(Sender: TObject);
begin
  CollectionItemsClick(LBSummaryGroups, SummaryGroups);
  UpdateSummaryGroups;
end;

procedure TcxCustomTableViewEditor.BSummaryGroupAddClick(Sender: TObject);
begin
  CollectionItemsAdd(LBSummaryGroups, SummaryGroups);
end;

procedure TcxCustomTableViewEditor.BSummaryGroupDeleteClick(
  Sender: TObject);
begin
  CollectionItemsDelete(LBSummaryGroups, SummaryGroups);
end;

// Summary - Selected Group

procedure TcxCustomTableViewEditor.LBGroupSummaryItemsClick(
  Sender: TObject);
begin
  if GetCurrentGroup <> nil then
    CollectionItemsClick(LBGroupSummaryItems, GetCurrentGroup.SummaryItems);
end;

procedure TcxCustomTableViewEditor.BGroupSummaryItemAddClick(
  Sender: TObject);
begin
  if GetCurrentGroup <> nil then
    CollectionItemsAdd(LBGroupSummaryItems, GetCurrentGroup.SummaryItems);
end;

procedure TcxCustomTableViewEditor.BGroupSummaryItemDeleteClick(
  Sender: TObject);
begin
  if GetCurrentGroup <> nil then
    CollectionItemsDelete(LBGroupSummaryItems, GetCurrentGroup.SummaryItems);
end;

procedure TcxCustomTableViewEditor.LBUnlinkedColumnsClick(Sender: TObject);
begin
  UpdateButtons;
end;

procedure TcxCustomTableViewEditor.BColumnLinkClick(Sender: TObject);
var
  ACurrentGroup: TcxDataSummaryGroup;
  I: Integer;
  AGroupItemLink: TcxDataSummaryGroupItemLink;
begin
  BeginUpdate;
  try
    ACurrentGroup := GetCurrentGroup;
    for I := 0 to LBUnlinkedColumns.Items.Count - 1 do
      if LBUnlinkedColumns.Selected[I] then
      begin
        AGroupItemLink := ACurrentGroup.Links.Add;
        AGroupItemLink.ItemLink := LBUnlinkedColumns.Items.Objects[I];
      end;
    UpdateSummaryGroupLinks;
    UpdateDesigner;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomTableViewEditor.BColumnUnlinkClick(Sender: TObject);
var
  ACurrentGroup: TcxDataSummaryGroup;
  I: Integer;
  AGroupItemLink: TcxDataSummaryGroupItemLink;
begin
  BeginUpdate;
  try
    ACurrentGroup := GetCurrentGroup;
    for I := LBLinkedColumns.Items.Count - 1 downto 0 do
      if LBLinkedColumns.Selected[I] then
      begin
        AGroupItemLink := ACurrentGroup.Links.ItemOfItemLink(LBLinkedColumns.Items.Objects[I]);
        AGroupItemLink.Free;
      end;
    UpdateSummaryGroupLinks;
    UpdateDesigner;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomTableViewEditor.PLinksResize(Sender: TObject);
var
  W: Integer;
begin
  W := (PLinks.Width - PLinkUnlink.Width) div 2;
  PUnlinkedColumns.Width := W;
  PLinkedColumns.Width := W;
end;

procedure TcxCustomTableViewEditor.PSummaryGroupsResize(Sender: TObject);
var
  W: Integer;
begin
  // Groups
  W := (PSummaryGroups.Width - PGSeparator.Width) div 2;
  PGroups.Width := W;
  PGroupItems.Width := W;
end;

// Drag Drop Columns

procedure TcxCustomTableViewEditor.LBColumnsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FColumnsPrevDragIndex := -1;
end;

procedure TcxCustomTableViewEditor.LBColumnsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  ListBoxDragOver(LBColumns, Sender, Source, X, Y, State, Accept, FColumnsPrevDragIndex);
end;

procedure TcxCustomTableViewEditor.LBColumnsEndDrag(Sender,
  Target: TObject; X, Y: Integer);
begin
  ListBoxEndDrag(LBColumns, Sender, Target, X, Y, FColumnsPrevDragIndex);
end;

procedure TcxCustomTableViewEditor.LBColumnsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
begin
  ListBoxDragDrop(LBColumns, Sender, Source, X, Y, FColumnsPrevDragIndex, ReindexColumnsProc);
end;

// Summary: Select All

procedure TcxCustomTableViewEditor.MIFooterSummarySelectAllClick(
  Sender: TObject);
begin
  ListBoxSelectAll(LBFooterSummary);
  LBFooterSummaryClick(nil);
end;

procedure TcxCustomTableViewEditor.MIDefaultGroupSummarySelectAllClick(
  Sender: TObject);
begin
  ListBoxSelectAll(LBDefaultGroupsSummary);
  LBDefaultGroupsSummaryClick(nil);
end;

procedure TcxCustomTableViewEditor.MISummaryGroupSelectAllClick(
  Sender: TObject);
begin
  ListBoxSelectAll(LBSummaryGroups);
  LBSummaryGroupsClick(nil);
end;

procedure TcxCustomTableViewEditor.MIGroupSummaryItemsSelectAllClick(
  Sender: TObject);
begin
  ListBoxSelectAll(LBGroupSummaryItems);
  LBGroupSummaryItemsClick(nil);
end;

procedure TcxCustomTableViewEditor.FormCreate(Sender: TObject);
begin
  inherited;
end;

procedure TcxCustomTableViewEditor.LBColumnsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
end;

initialization
  RegisterViewEditorClass(TcxCustomGridTableView, TcxCustomTableViewEditor);

finalization
  UnregisterViewEditorClass(TcxCustomGridTableView, TcxCustomTableViewEditor);

end.
