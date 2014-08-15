{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressNavBar                                               }
{                                                                   }
{       Copyright (c) 2002-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSNAVBAR AND ALL ACCOMPANYING   }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxfmNavBarDsgnEditor;

{$I cxVer.inc}

interface

uses
  Dialogs, Classes, Controls, Messages, Forms, StdCtrls, ExtCtrls, Menus, ImgList, ComCtrls,
{$IFDEF DELPHI6}
    DesignWindows, DesignIntf, DesignEditors,
{$ELSE}
  DsgnIntf, DsgnWnds, LibIntf,
{$ENDIF}

  dxNavBar, dxNavBarBase, dxNavBarCollns, dxNavBarStyles, dxNavBarDsgnUtils,
  cxClasses;

type
  TdxfmNavBarDesignWindow = class;

  TdxNavBarDsgnWindowPageHandler = class
  private
    FDsgnWindow: TdxfmNavBarDesignWindow;
    function GetNavBar: TdxCustomNavBar;
  protected
    class function DesignerCaptionPostfix: string; virtual;

    function CanAdd: Boolean; virtual;
    function CanCopy: Boolean; virtual;
    function CanCut: Boolean; virtual;
    function CanDelete: Boolean; virtual;
    function CanSelectAll: Boolean; virtual;
    function CanMoveUp: Boolean; virtual;
    function CanMoveDown: Boolean; virtual;
    function CanPaste: Boolean; virtual;
  public
    constructor Create(ADsgnWindow: TdxfmNavBarDesignWindow);
    destructor Destroy; override;

    procedure Activate;
    procedure Add; virtual;
    procedure Copy; virtual;
    procedure Cut; virtual;
    procedure Delete; virtual;
    procedure DeleteItem(AItem: TComponent); virtual;
    procedure GetSelections(const ASelections: IDesignerSelections); virtual;
    procedure MoveSelection(ADelta: Integer); virtual;
    procedure Paste; virtual;
    procedure SelectAll; virtual;
    procedure UpdateButtonsPanel; virtual;
    procedure UpdateButtonsState;
    procedure UpdateContent; virtual;
    procedure UpdateItem(AItem: TComponent); virtual;
    procedure UpdateScrollBar; virtual;
    procedure UpdateSelections(const ASelections: IDesignerSelections); virtual;

    property DsgnWindow: TdxfmNavBarDesignWindow read FDsgnWindow;
    property NavBar: TdxCustomNavBar read GetNavBar;
  end;

  TdxfmNavBarDesignWindow = class(TDesignWindow)
    pcMain: TPageControl;
    tsGroups: TTabSheet;
    tsItems: TTabSheet;
    tsLinks: TTabSheet;
    tsCustomStyles: TTabSheet;
    lbxGroups: TListBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Splitter1: TSplitter;
    Panel4: TPanel;
    tvLinkDesignerGroups: TTreeView;
    Panel5: TPanel;
    Label2: TLabel;
    lbxItems: TListBox;
    pnButtons: TPanel;
    lbxCustomStyles: TListBox;
    ilLinkDesigner: TImageList;
    ilPopup: TImageList;
    pmMain: TPopupMenu;
    miAdd: TMenuItem;
    N2: TMenuItem;
    miEdit: TMenuItem;
    miCut: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
    miDelete: TMenuItem;
    N3: TMenuItem;
    miSelectAll: TMenuItem;
    N4: TMenuItem;
    miMoveUp: TMenuItem;
    miMoveDown: TMenuItem;
    lbxLinkDesignerItems: TListView;
    nbMain: TdxNavBar;
    bgMain: TdxNavBarGroup;
    bgStyles: TdxNavBarGroup;
    biGroups: TdxNavBarItem;
    biItems: TdxNavBarItem;
    biLinks: TdxNavBarItem;
    biViews: TdxNavBarItem;
    biDefaultStyles: TdxNavBarItem;
    biCustomStyles: TdxNavBarItem;
    ilNavBarLarge: TImageList;
    ilNavBarSmall: TImageList;
    tsViews: TTabSheet;
    tsDefaultStyles: TTabSheet;
    lbxDefaultStyles: TListBox;
    pnBtnAddDelete: TPanel;
    btAdd: TButton;
    btDelete: TButton;
    nbPreview: TdxNavBar;
    Label3: TLabel;
    Label4: TLabel;
    cbViewStyles: TComboBox;
    ilPreviewLarge: TImageList;
    ilPreviewSmall: TImageList;
    bgLocal: TdxNavBarGroup;
    bgNews: TdxNavBarGroup;
    biInbox: TdxNavBarItem;
    biOutbox: TdxNavBarItem;
    biSentItems: TdxNavBarItem;
    biDeletedItems: TdxNavBarItem;
    biDrafts: TdxNavBarItem;
    biNews: TdxNavBarItem;
    Panel1: TPanel;
    pnBtnSelect: TPanel;
    btSelectAll: TButton;
    Panel6: TPanel;
    pnBtnMove: TPanel;
    btMoveUp: TButton;
    btMoveDown: TButton;
    Panel7: TPanel;
    pnBtnDefaultSettings: TPanel;
    btnDefaultSettings: TButton;
    pnBtnApply: TPanel;
    btnApply: TButton;
    procedure ListBoxClick(Sender: TObject);
    procedure AddClick(Sender: TObject);
    procedure ActionClick(Sender: TObject);
    procedure MoveUpClick(Sender: TObject);
    procedure MoveDownClick(Sender: TObject);
    procedure tvLinkDesignerGroupsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tvLinkDesignerGroupsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure tvLinkDesignerGroupsStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure lbxLinkDesignerItemsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lbxLinkDesignerItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbxLinkDesignerItemsStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure tvLinkDesignerGroupsExit(Sender: TObject);
    procedure tvLinkDesignerGroupsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pmMainPopup(Sender: TObject);
    procedure tvLinkDesignerGroupsClick(Sender: TObject);
    procedure lbxLinkDesignerItemsClick(Sender: TObject);
    procedure tvLinkDesignerGroupsEndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure lbxLinkDesignerItemsEndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure nbMainLinkClick(Sender: TObject; ALink: TdxNavBarItemLink);
    procedure DefaultSettingsClick(Sender: TObject);
    procedure cbViewStylesChange(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
  private
    FNavBar: TdxCustomNavBar;
    FHandlers: TList;
    FCurrentHandler: TdxNavBarDsgnWindowPageHandler;
    FSaveCursor: TCursor;

    function GetNavBarDesigner: TAbstractcxNavBarDesigner;
    procedure SetNavBar(Value: TdxCustomNavBar);

    function CanAdd: Boolean;
    function CanCopy: Boolean;
    function CanCut: Boolean;
    function CanDelete: Boolean;
    function CanMoveDown: Boolean;
    function CanMoveUp: Boolean;
    function CanPaste: Boolean;
    function CanSelectAll: Boolean;
    procedure Copy;
    procedure Cut;
    procedure Delete;
    procedure HandleException;
    function GetRegistryPath: string;
    procedure Paste;
    procedure RestoreLayout;
    procedure Select(AComponent: TComponent; AddToSelection: Boolean);
    procedure SelectAll;
    procedure SelectNavBar;
    procedure StartWait;
    procedure StopWait;
    procedure StoreLayout;
    procedure UpdateButtonsState;
    procedure UpdateCaption;
    procedure UpdateItem(AItem: TComponent);
    procedure UpdateMenuState;
    procedure UpdateSelections(const ASelections: IDesignerSelections);

    function GetHandler(Index: Integer): TdxNavBarDsgnWindowPageHandler;
    function GetHandlerCount: Integer;
  protected
    procedure Activated; override;
  {$IFDEF DELPHI9}
    procedure CreateParams(var Params: TCreateParams); override;
  {$ENDIF}
    function UniqueName(Component: TComponent): string; override;

    procedure ActiveDesignerPageChanged;
    procedure InitializeHandlers;
    procedure InitializeViewStyles;
    procedure FinalizeHandlers;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ClipboardComponents: Boolean;

   {$IFDEF DELPHI6}
    function EditAction(Action: TEditAction): Boolean; override;
   {$ELSE}
    procedure EditAction(Action: TEditAction); override;
   {$ENDIF}
    function GetEditState: TEditState; override;

   {$IFDEF DELPHI6}
    procedure ItemDeleted(const ADesigner: IDesigner; Item: TPersistent); override;
    procedure ItemsModified(const Designer: IDesigner); override;
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections); override;
   {$ELSE}
    procedure ComponentDeleted(Component: IPersistent); override;
    procedure FormModified; override;
    procedure SelectionChanged(ASelection: TDesignerSelectionList); override;
   {$ENDIF}

    property CurrentHandler: TdxNavBarDsgnWindowPageHandler read FCurrentHandler write FCurrentHandler;
    property HandlerCount: Integer read GetHandlerCount;
    property Handlers[Index: Integer]: TdxNavBarDsgnWindowPageHandler read GetHandler;
    property NavBar: TdxCustomNavBar read FNavBar write SetNavBar;
    property NavBarDesigner: TAbstractcxNavBarDesigner read GetNavBarDesigner;
  end;

procedure dxShowNavBarDesigner(ANavBar: TdxCustomNavBar;
  ADelphiDesigner: IDelphiDesigner);

implementation

{$R *.DFM}

uses
  Windows, SysUtils, TypInfo, {$IFDEF DELPHI6}Variants,{$ENDIF} Registry
  , ToolsAPI , dxNavBarViewsFact, dxNavBarDsgnConsts;

type
  TdxNavBarDesigner = class(TAbstractcxNavBarDesigner)
  private
    FDelphiDesigner: IDelphiDesigner;
    FDesignWindow: TdxfmNavBarDesignWindow;
    FUpdateCount: Integer;
    FIsBeingModified: Boolean;

    function GetDesignWindow: TdxfmNavBarDesignWindow;
    procedure Activate;
  protected
    procedure Modified; override;
    procedure Update(AItem: TComponent); override;
  public
    constructor Create(ANavBar: TdxCustomNavBar; ADelphiDesigner: IDelphiDesigner);
    destructor Destroy; override;

    procedure BeginUpdate; override;
    procedure CancelUpdate; override;
    procedure EndUpdate; override;

    property DelphiDesigner: IDelphiDesigner read FDelphiDesigner;
    property DesignWindow: TdxfmNavBarDesignWindow read GetDesignWindow;
  end;

procedure dxShowNavBarDesigner(ANavBar: TdxCustomNavBar; ADelphiDesigner: IDelphiDesigner);
begin
  if ANavBar.Designer = nil then
    TdxNavBarDesigner.Create(ANavBar, ADelphiDesigner);
  TdxNavBarDesigner(ANavBar.Designer).Activate;
end;

{ TdxWebStyleControllerDesigner }

constructor TdxNavBarDesigner.Create(ANavBar: TdxCustomNavBar;
  ADelphiDesigner: IDelphiDesigner);
begin
  inherited Create(ANavBar);
  FDelphiDesigner := ADelphiDesigner;
end;

destructor TdxNavBarDesigner.Destroy;
begin
  if FDesignWindow <> nil then
  begin
    FDesignWindow.Designer := nil;
    FDesignWindow.Free;
  end;
  inherited Destroy;
end;

procedure TdxNavBarDesigner.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TdxNavBarDesigner.CancelUpdate;
begin
  if FUpdateCount <> 0 then Dec(FUpdateCount);
end;

procedure TdxNavBarDesigner.EndUpdate;
begin
  if FUpdateCount <> 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then Update(nil);
  end;
end;

function TdxNavBarDesigner.GetDesignWindow: TdxfmNavBarDesignWindow;
begin
  if FDesignWindow = nil then
  begin
    FDesignWindow := TdxfmNavBarDesignWindow.Create(nil);
    FDesignWindow.Designer := DelphiDesigner;
    FDesignWindow.NavBar := NavBar;
  end;
  Result := FDesignWindow;
end;

procedure TdxNavBarDesigner.Activate;
begin
  DesignWindow.Show;
end;

procedure TdxNavBarDesigner.Modified;
begin
  if not FIsBeingModified and (DelphiDesigner <> nil) then
  begin
    FIsBeingModified := True;
    try
      DelphiDesigner.Modified;
    finally
      FIsBeingModified := False
    end;
  end;
end;

procedure TdxNavBarDesigner.Update(AItem: TComponent);
begin
  if (FUpdateCount = 0) and (FDesignWindow <> nil) then
    DesignWindow.UpdateItem(AItem);
end;

type
  TdxNavBarDsgnWindowComponentCollectionPageHandler = class(TdxNavBarDsgnWindowPageHandler)
  private
    function GetItem(Index: Integer): TdxNavBarComponentCollectionItem;
    function GetItemCount: Integer;
    function GetSelected(Index: Integer): Boolean;
    function GetSelectedCount: Integer;
    procedure SetSelected(Index: Integer; const Value: Boolean);
  protected
    function MainList: TListBox; virtual;
    class function ItemNamePrefix: string; virtual;
    class function ItemClass: TComponentClass; virtual;

    function CanAdd: Boolean; override;
    function CanCopy: Boolean; override;
    function CanCut: Boolean; override;
    function CanDelete: Boolean; override;
    function CanSelectAll: Boolean; override;
    function CanMoveUp: Boolean; override;
    function CanMoveDown: Boolean; override;
    function CanPaste: Boolean; override;
  public
    procedure Add; override;
    procedure Copy; override;
    procedure Cut; override;
    procedure Delete; override;
    procedure DeleteItem(AItem: TComponent); override;
    function IndexOf(AItem: TComponent): Integer;
    procedure GetSelections(const ASelections: IDesignerSelections); override;
    procedure MoveSelection(ADelta: Integer); override;
    procedure Paste; override;
    procedure RefreshListValues; virtual;
    procedure SelectAll; override;
    procedure UpdateButtonsPanel; override;
    procedure UpdateContent; override;
    procedure UpdateItem(AItem: TComponent); override;
    procedure UpdateScrollBar; override;
    procedure UpdateSelections(const ASelections: IDesignerSelections); override;

    property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
    property SelectedCount: Integer read GetSelectedCount;
    property Items[Index: Integer]: TdxNavBarComponentCollectionItem read GetItem;
    property ItemCount: Integer read GetItemCount;

    property DsgnWindow: TdxfmNavBarDesignWindow read FDsgnWindow;
    property NavBar: TdxCustomNavBar read GetNavBar;
  end;

{ TdxNavBarDsgnWindowComponentCollectionPageHandler }

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.Add;
begin
  inherited;

end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.CanAdd: Boolean;
begin
  Result := (NavBar <> nil) and (NavBar.Owner <> nil);
  if Result then
    Result := not (csInline in NavBar.Owner.ComponentState);
end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.CanCopy: Boolean;
begin
  Result := SelectedCount <> 0;
end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.CanCut: Boolean;
begin
  Result := CanCopy and CanDelete;
end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.CanDelete: Boolean;
var
  I: Integer;
begin
  Result := SelectedCount <> 0;
  if Result then
    for I := 0 to ItemCount - 1 do
      if Selected[I] and (csAncestor in Items[I].ComponentState) then
      begin
        Result := False;
        Exit;
      end;
end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.CanMoveDown: Boolean;
var
  I, Counter: Integer;
begin
  Counter := 0;
  for I := ItemCount - 1 downto 0 do
  begin
    if not Selected[I] then
    begin
      Result := Counter < SelectedCount;
      Exit;
    end;
    Inc(Counter);
  end;
  Result := False;
end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.CanMoveUp: Boolean;
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
    if not Selected[I] then
    begin
      Result := I < SelectedCount;
      Exit;
    end;
  Result := False;
end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.CanPaste: Boolean;
begin
  Result := CanAdd and DsgnWindow.ClipboardComponents and DsgnWindow.Designer.CanPaste;
end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.CanSelectAll: Boolean;
begin
  Result := ItemCount <> SelectedCount;
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.Copy;
var
  Components: {$IFDEF DELPHI6}IDesignerSelections{$ELSE}TDesignerSelectionList{$ENDIF};
begin
{$IFDEF DELPHI6}
  Components := CreateSelectionList;
{$ELSE}
  Components := TDesignerSelectionList.Create;
  try
{$ENDIF}
    GetSelections(Components);
    DsgnWindow.CopyComponents(NavBar.Owner, Components);
{$IFNDEF DELPHI6}
  finally
    Components.Free;
  end;
{$ENDIF}
  UpdateScrollBar;
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.Cut;
begin
  Copy;
  Delete;
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.Delete;
var
  Selections: IDesignerSelections;
  I: Integer;
begin
  DsgnWindow.StartWait;
  try
    Selections := CreateSelectionList;
    GetSelections(Selections);
    for I := 0 to Selections.Count - 1 do
      dxNavBarDsgnUtils.TryExtractPersistent(Selections[I]).Free;
    NavBar.DesignerModified;
  finally
    DsgnWindow.StopWait;
  end;
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.DeleteItem(
  AItem: TComponent);
var
  Index, ItemIndex: Integer;
begin
  if (AItem = nil) or (AItem.ClassType <> ItemClass) then exit;

  Index := IndexOf(AItem);
  if Index <> -1 then
  begin
    ItemIndex := MainList.ItemIndex;
    MainList.Items.Delete(Index);

    if ItemIndex > ItemCount - 1 then
      ItemIndex := ItemCount - 1;
    if ItemIndex <> -1 then
      DsgnWindow.Select(Items[ItemIndex], False)
    else DsgnWindow.SelectNavBar;
    UpdateScrollBar;
  end;
end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.GetItem(
  Index: Integer): TdxNavBarComponentCollectionItem;
begin
  if MainList <> nil then
    Result := TdxNavBarComponentCollectionItem(MainList.Items.Objects[Index])
  else Result := nil;
end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.GetItemCount: Integer;
begin
  if MainList <> nil then
    Result := MainList.Items.Count
  else Result := 0;
end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.GetSelected(
  Index: Integer): Boolean;
begin
  if MainList <> nil then
    Result := MainList.Selected[Index]
  else Result := False;
end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.GetSelectedCount: Integer;
begin
  if MainList <> nil then
    Result := MainList.SelCount
  else Result := 0;
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.GetSelections(
  const ASelections: IDesignerSelections);
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
    if Selected[I] then
      ASelections.Add(dxNavBarDsgnUtils.MakeIComponent(Items[I]));
  if ASelections.Count = 0 then
    ASelections.Add(dxNavBarDsgnUtils.MakeIComponent(NavBar));
end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.IndexOf(
  AItem: TComponent): Integer;
begin
  Result := MainList.Items.IndexOfObject(AItem);
end;

function TdxNavBarDsgnWindowComponentCollectionPageHandler.MainList: TListBox;
begin
  Result := nil;
end;

class function TdxNavBarDsgnWindowComponentCollectionPageHandler.ItemClass: TComponentClass;
begin
  Result := nil;
end;

class function TdxNavBarDsgnWindowComponentCollectionPageHandler.ItemNamePrefix: string;
begin
  Result := '';
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.MoveSelection(
  ADelta: Integer);

  procedure MoveDown(ADelta: Integer);
  var
    I, Index: Integer;
  begin
//    for I := ItemCount - 1 downto 0 do
    for I := 0 to ItemCount - 1 do
      if Selected[I] then
      begin
        Index := Items[I].Index;
        Inc(Index, ADelta);
        if Index > ItemCount - 1 then
          Index := ItemCount - 1;
        while (Index < ItemCount) and Selected[Index] do
          Inc(Index);
        Items[I].Index := Index;
      end;
  end;

  procedure MoveUp(ADelta: Integer);
  var
    I, Index: Integer;
  begin
//    for I := 0 to ItemCount - 1 do
    for I := ItemCount - 1 downto 0 do
      if Selected[I] then
      begin
        Index := Items[I].Index;
        Inc(Index, ADelta);
        if Index < 0 then
          Index := 0;
        while (Index > -1) and Selected[Index] do
          Dec(Index);
        Items[I].Index := Index;
      end;
  end;

begin
  DsgnWindow.NavBarDesigner.BeginUpdate;
  try
    if ADelta > 0 then MoveDown(ADelta)
    else MoveUp(ADelta);
  finally
    DsgnWindow.NavBarDesigner.EndUpdate;
  end;
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.Paste;
var
  Components: {$IFDEF DELPHI6}IDesignerSelections{$ELSE}TDesignerSelectionList{$ENDIF};
  I: Integer;
begin
{$IFDEF DELPHI6}
  Components := CreateSelectionList;
{$ELSE}
  Components := TDesignerSelectionList.Create;
  try
{$ENDIF}
    DsgnWindow.StartWait;
    try
      MainList.Items.BeginUpdate;
      try
        DsgnWindow.NavBarDesigner.BeginUpdate;
        try
          DsgnWindow.PasteComponents(NavBar.Owner, NavBar, Components);
        finally
          DsgnWindow.NavBarDesigner.EndUpdate;
        end;
        for I := ItemCount - 1 downto ItemCount - Components.Count do
          Selected[I] := True;
        DsgnWindow.Designer.SetSelections(Components);
      finally
        MainList.Items.EndUpdate;
      end;
    finally
      DsgnWindow.StopWait;
    end;
{$IFNDEF DELPHI6}
  finally
    Components.Free;
  end;
{$ENDIF}
  UpdateScrollBar;
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.UpdateContent;
var
  Selections: IDesignerSelections;
  I, Index: Integer;
  Component: TComponent;
begin
  MainList.Items.BeginUpdate;
  try
    Selections := CreateSelectionList;
    GetSelections(Selections);

    MainList.Items.Clear;
    if NavBar = nil then Exit;
    RefreshListValues;

    for I := 0 to Selections.Count - 1 do
    begin
      Component := dxNavBarDsgnUtils.TryExtractComponent(Selections[I]);
      if Component is ItemClass then
      begin
        Index := IndexOf(Component);
        if Index <> -1 then Selected[Index] := True;
      end;
    end;
  finally
    MainList.Items.EndUpdate;
  end;
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.RefreshListValues;
begin
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.SelectAll;
var
  Selections: IDesignerSelections;
  I: Integer;
begin
  Selections := CreateSelectionList;
  for I := 0 to ItemCount - 1 do
    Selections.Add(dxNavBarDsgnUtils.MakeIComponent(Items[I]));
  DsgnWindow.Designer.SetSelections(Selections);
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.SetSelected(
  Index: Integer; const Value: Boolean);
begin
  if MainList <> nil then
    MainList.Selected[Index] := Value;
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.UpdateButtonsPanel;
begin
  DsgnWindow.pnBtnAddDelete.Visible := True;
  DsgnWindow.pnBtnSelect.Visible := True;
  DsgnWindow.pnBtnMove.Visible := True;
  DsgnWindow.pnBtnDefaultSettings.Visible := False;
  DsgnWindow.pnBtnApply.Visible := False;
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.UpdateItem(AItem: TComponent);
var
  Index: Integer;
begin
  if AItem <> nil then
  begin
    Index := IndexOf(AItem);
    if Index <> -1 then
    begin
      MainList.Items[Index] := AItem.Name;
      UpdateScrollBar;
    end
  end
  else UpdateContent;
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.UpdateScrollBar;
var
  I, NewWidth, CurrentWidth: Integer;
begin
  NewWidth := 0;
  with MainList do
  begin
    for I := 0 to Items.Count - 1 do
    begin
      CurrentWidth := 2 + Canvas.TextWidth(Items[I]) + 1;
      if CurrentWidth > NewWidth then NewWidth := CurrentWidth;
    end;
    SendMessage(Handle, LB_SETHORIZONTALEXTENT, NewWidth, 0);
  end;
end;

procedure TdxNavBarDsgnWindowComponentCollectionPageHandler.UpdateSelections(const ASelections: IDesignerSelections);

  function InSelection(AItem: TComponent): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to ASelections.Count - 1 do
      if AItem = dxNavBarDsgnUtils.TryExtractComponent(ASelections[I]) then
      begin
        Result := True;
        break;
      end;
  end;

var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
    if Selected[I] xor InSelection(Items[I]) then
      Selected[I] := not Selected[I];
end;

type
  TdxNavBarDsgnWindowGroupsHandler = class(TdxNavBarDsgnWindowComponentCollectionPageHandler)
  protected
    function MainList: TListBox; override;
    class function DesignerCaptionPostfix: string; override;
    class function ItemNamePrefix: string; override;
    class function ItemClass: TComponentClass; override;
  public
    procedure Add; override;
    procedure RefreshListValues; override;
  end;

{ TdxNavBarDsgnWindowGroupsHandler }

procedure TdxNavBarDsgnWindowGroupsHandler.Add;
var
  Group: TdxNavBarGroup;
begin
  Group := NavBar.Groups.Add;
  DsgnWindow.NavBarDesigner.BeginUpdate;
  try
    Group.Name := DsgnWindow.UniqueName(Group);
  finally
    DsgnWindow.NavBarDesigner.CancelUpdate;
  end;
  MainList.Items.AddObject(Group.Name, Group);
  DsgnWindow.Select(Group, False);
  UpdateScrollBar;
  MainList.Update;
end;

function TdxNavBarDsgnWindowGroupsHandler.MainList: TListBox;
begin
  Result := DsgnWindow.lbxGroups;
end;

class function TdxNavBarDsgnWindowGroupsHandler.DesignerCaptionPostfix: string;
begin
  Result := sdxGroupsDesigner;
end;

class function TdxNavBarDsgnWindowGroupsHandler.ItemNamePrefix: string;
begin
  Result := sdxGroup;
end;

class function TdxNavBarDsgnWindowGroupsHandler.ItemClass: TComponentClass;
begin
  Result := TdxNavBarGroup;
end;

procedure TdxNavBarDsgnWindowGroupsHandler.RefreshListValues;
var
  I: Integer;
  Group: TdxNavBarGroup;
begin
  for I := 0 to NavBar.Groups.Count - 1 do
  begin
    Group := NavBar.Groups[I];
    if Group.Owner = NavBar.Owner then
      MainList.Items.AddObject(Group.Name, Group);
  end;
end;

type
  TdxNavBarDsgnWindowItemsHandler = class(TdxNavBarDsgnWindowComponentCollectionPageHandler)
  protected
    function MainList: TListBox; override;
    class function DesignerCaptionPostfix: string; override;
    class function ItemNamePrefix: string; override;
    class function ItemClass: TComponentClass; override;
  public
    procedure Add; override;
    procedure RefreshListValues; override;
  end;

{ TdxNavBarDsgnWindowItemsHandler }

procedure TdxNavBarDsgnWindowItemsHandler.Add;
var
  Item: TdxNavBarItem;
begin
  Item := NavBar.Items.Add;
  DsgnWindow.NavBarDesigner.BeginUpdate;
  try
    Item.Name := DsgnWindow.UniqueName(Item);
  finally
    DsgnWindow.NavBarDesigner.CancelUpdate;
  end;
  MainList.Items.AddObject(Item.Name, Item);
  DsgnWindow.Select(Item, False);
  UpdateScrollBar;
  MainList.Update;
end;

function TdxNavBarDsgnWindowItemsHandler.MainList: TListBox;
begin
  Result := DsgnWindow.lbxItems;
end;

class function TdxNavBarDsgnWindowItemsHandler.DesignerCaptionPostfix: string;
begin
  Result := sdxItemsDesigner;
end;

class function TdxNavBarDsgnWindowItemsHandler.ItemNamePrefix: string;
begin
  Result := sdxItem;
end;

class function TdxNavBarDsgnWindowItemsHandler.ItemClass: TComponentClass;
begin
  Result := TdxNavBarItem;
end;

procedure TdxNavBarDsgnWindowItemsHandler.RefreshListValues;
var
  I: Integer;
  Item: TdxNavBarItem;
begin
  for I := 0 to NavBar.Items.Count - 1 do
  begin
    Item := NavBar.Items[I];
    if Item.Owner = NavBar.Owner then
      MainList.Items.AddObject(Item.Name, Item);
  end;
end;

type
  TdxNavBarDsgnWindowCustomStylesHandler = class(TdxNavBarDsgnWindowComponentCollectionPageHandler)
  protected
    function MainList: TListBox; override;
    class function DesignerCaptionPostfix: string; override;
    class function ItemNamePrefix: string; override;
    class function ItemClass: TComponentClass; override;
  public
    procedure Add; override;
    procedure RefreshListValues; override;
  end;

{ TdxNavBarDsgnWindowSlylesHandler }

procedure TdxNavBarDsgnWindowCustomStylesHandler.Add;
var
  Style: TdxNavBarStyleItem;
begin
  Style := NavBar.Styles.Add;
  DsgnWindow.NavBarDesigner.BeginUpdate;
  try
    Style.Name := DsgnWindow.UniqueName(Style);
  finally
    DsgnWindow.NavBarDesigner.CancelUpdate;
  end;
  MainList.Items.AddObject(Style.Name, Style);
  DsgnWindow.Select(Style, False);
  UpdateScrollBar;
  MainList.Update;
end;

function TdxNavBarDsgnWindowCustomStylesHandler.MainList: TListBox;
begin
  Result := DsgnWindow.lbxCustomStyles;
end;

class function TdxNavBarDsgnWindowCustomStylesHandler.DesignerCaptionPostfix: string;
begin
  Result := sdxCustomStylesDesigner;
end;

class function TdxNavBarDsgnWindowCustomStylesHandler.ItemNamePrefix: string;
begin
  Result := sdxStyleItem;
end;

class function TdxNavBarDsgnWindowCustomStylesHandler.ItemClass: TComponentClass;
begin
  Result := TdxNavBarStyleItem;
end;

procedure TdxNavBarDsgnWindowCustomStylesHandler.RefreshListValues;
var
  I: Integer;
  Style: TdxNavBarStyleItem;
begin
  for I := 0 to NavBar.Styles.Count - 1 do
  begin
    Style := NavBar.Styles[I];
    if Style.Owner = NavBar.Owner then
      MainList.Items.AddObject(Style.Name, Style);
  end;
end;

type
  TdxNavBarDsgnWindowLinksHandler = class(TdxNavBarDsgnWindowPageHandler)
  private
    FSourceItem: TdxNavBarItem;
    FSourceLink: TdxNavBarItemLink;
    FTargetGroup: TdxNavBarGroup;
    FTargetLink: TdxNavBarItemLink;

    function GetSelectedGroup: TdxNavBarGroup;
    function GetSelectedItem: TdxNavBarItem;
    function GetSelectedLink: TdxNavBarItemLink;
  protected
    function CanAdd: Boolean; override;
    function CanDelete: Boolean; override;
    function CanSelectAll: Boolean; override;
    function CanMoveUp: Boolean; override;
    function CanMoveDown: Boolean; override;
    class function DesignerCaptionPostfix: string; override;

    function ItemsLV: TListView;
    function LinksTV: TTreeView;
    procedure RefreshGroupTreeView;
    procedure RefreshItemList;
    function GetGroupByNode(ANode: TTreeNode): TdxNavBarGroup;
    function GetLinkByNode(ANode: TTreeNode): TdxNavBarItemLink;
    function GetItemByNode(ANode: TListItem): TdxNavBarItem;
    function GetNodeByGroup(AGroup: TdxNavBarGroup): TTreeNode;
    function GetNodeByLink(ALink: TdxNavBarItemLink): TTreeNode;
    procedure CreateNodeByLink(ALink: TdxNavBarItemLink);
    procedure RemoveNodeByLink(ALink: TdxNavBarItemLink);

    function GetGroupNodeCation(AGroup: TdxNavBarGroup): string;
    function GetItemNodeCation(AItem: TdxNavBarItem): string;
    procedure SetTargetGroupNodeImage(AImageIndex: Integer);
    procedure SetTargetLinkNodeImage(AImageIndex: Integer);
    procedure UpdateTargets(ANode: TTreeNode);
    procedure ClearTargets;

    procedure CreateLink(AItem: TdxNavBarItem; AGroup: TdxNavBarGroup; AIndex: Integer);
    procedure MoveLink(ALink: TdxNavBarItemLink; AGroup: TdxNavBarGroup; AIndex: Integer);
    procedure RemoveLink(ALink: TdxNavBarItemLink);
  public
    procedure Add; override;
    procedure Delete; override;
    procedure MoveSelection(ADelta: Integer); override;
    procedure UpdateButtonsPanel; override;
    procedure UpdateContent; override;
    procedure UpdateItem(AItem: TComponent); override;

    property SelectedGroup: TdxNavBarGroup read GetSelectedGroup;
    property SelectedItem: TdxNavBarItem read GetSelectedItem;
    property SelectedLink: TdxNavBarItemLink read GetSelectedLink;
    property SourceItem: TdxNavBarItem read FSourceItem write FSourceItem;
    property SourceLink: TdxNavBarItemLink read FSourceLink write FSourceLink;
    property TargetGroup: TdxNavBarGroup read FTargetGroup;
    property TargetLink: TdxNavBarItemLink read FTargetLink;
  end;

{ TdxNavBarDsgnWindowLinksHandler }

function TdxNavBarDsgnWindowLinksHandler.CanAdd: Boolean;
begin
  Result := (SelectedItem <> nil) and (SelectedGroup <> nil);
end;

function TdxNavBarDsgnWindowLinksHandler.CanDelete: Boolean;
begin
  Result := SelectedLink <> nil;
end;

function TdxNavBarDsgnWindowLinksHandler.CanSelectAll: Boolean;
begin
  Result := False;
end;

function TdxNavBarDsgnWindowLinksHandler.CanMoveUp: Boolean;
begin
  Result := (SelectedLink <> nil) and (SelectedLink.Index > 0);
end;

function TdxNavBarDsgnWindowLinksHandler.CanMoveDown: Boolean;
begin
  Result := (SelectedLink <> nil) and (SelectedLink.Index < SelectedLink.Group.LinkCount - 1);
end;

class function TdxNavBarDsgnWindowLinksHandler.DesignerCaptionPostfix: string;
begin
  Result := sdxLinksDesigner;
end;

function TdxNavBarDsgnWindowLinksHandler.GetGroupByNode(ANode: TTreeNode): TdxNavBarGroup;
begin
  if TObject(ANode.Data) is TdxNavBarGroup then
    Result := TdxNavBarGroup(ANode.Data)
  else Result := nil;
end;

function TdxNavBarDsgnWindowLinksHandler.GetLinkByNode(ANode: TTreeNode): TdxNavBarItemLink;
begin
  if TObject(ANode.Data) is TdxNavBarItemLink then
    Result := TdxNavBarItemLink(ANode.Data)
  else Result := nil;
end;

function TdxNavBarDsgnWindowLinksHandler.GetItemByNode(ANode: TListItem): TdxNavBarItem;
begin
  if TObject(ANode.Data) is TdxNavBarItem then
    Result := TdxNavBarItem(ANode.Data)
  else Result := nil;
end;

function TdxNavBarDsgnWindowLinksHandler.GetNodeByGroup(AGroup: TdxNavBarGroup): TTreeNode;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to DsgnWindow.tvLinkDesignerGroups.Items.Count - 1 do
    if TObject(DsgnWindow.tvLinkDesignerGroups.Items[I].Data) = AGroup then
    begin
      Result := DsgnWindow.tvLinkDesignerGroups.Items[I];
      break;
    end;
end;

function TdxNavBarDsgnWindowLinksHandler.GetNodeByLink(ALink: TdxNavBarItemLink): TTreeNode;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to DsgnWindow.tvLinkDesignerGroups.Items.Count - 1 do
    if TObject(DsgnWindow.tvLinkDesignerGroups.Items[I].Data) = ALink then
    begin
      Result := DsgnWindow.tvLinkDesignerGroups.Items[I];
      break;
    end;
end;

procedure TdxNavBarDsgnWindowLinksHandler.CreateNodeByLink(ALink: TdxNavBarItemLink);
var
  ANode: TTreeNode;
begin
  ANode := GetNodeByGroup(ALink.Group);
  if ANode <> nil then
  begin
    if ALink.Index = ALink.Group.LinkCount - 1 then
      ANode := LinksTV.Items.AddChildObject(ANode, GetItemNodeCation(ALink.Item), ALink)
    else
    begin
      ANode := GetNodeByLink(ALink.Group.Links[ALink.Index + 1]);
      ANode := LinksTV.Items.InsertObject(ANode, GetItemNodeCation(ALink.Item), ALink);
    end;
    with ANode do
    begin
      ImageIndex := 2;
      SelectedIndex := 2;
    end;
    LinksTV.Selected := ANode;
  end;
end;

procedure TdxNavBarDsgnWindowLinksHandler.RemoveNodeByLink(ALink: TdxNavBarItemLink);
var
  ANode: TTreeNode;
begin
  ANode := GetNodeByLink(ALink);
  if ANode <> nil then
    LinksTV.Items.Delete(ANode);
end;

function TdxNavBarDsgnWindowLinksHandler.GetGroupNodeCation(AGroup: TdxNavBarGroup): string;
begin
  Result := AGroup.Caption + ' [' + AGroup.Name + ']';
end;

function TdxNavBarDsgnWindowLinksHandler.GetItemNodeCation(AItem: TdxNavBarItem): string;
begin
  Result := AItem.Caption + ' [' + AItem.Name + ']';
end;

procedure TdxNavBarDsgnWindowLinksHandler.SetTargetGroupNodeImage(AImageIndex: Integer);
var
  ANode: TTreeNode;
begin
  if TargetGroup <> nil then
  begin
    ANode := GetNodeByGroup(TargetGroup);
    if ANode <> nil then
      with ANode do
      begin
        ImageIndex := AImageIndex;
        SelectedIndex := AImageIndex;
      end;
  end;
end;

procedure TdxNavBarDsgnWindowLinksHandler.SetTargetLinkNodeImage(AImageIndex: Integer);
var
  ANode: TTreeNode;
begin
  if TargetLink <> nil then
  begin
    ANode := GetNodeByLink(TargetLink);
    if ANode <> nil then
      with ANode do
      begin
        ImageIndex := AImageIndex;
        SelectedIndex := AImageIndex;
      end;
  end;
end;

procedure TdxNavBarDsgnWindowLinksHandler.UpdateTargets(ANode: TTreeNode);
var
  AGroup: TdxNavBarGroup;
  ALink: TdxNavBarItemLink;
begin
  if ANode <> nil then
  begin
    ALink := GetLinkByNode(ANode);
    AGroup := GetGroupByNode(ANode);
  end
  else
  begin
    AGroup := nil;
    ALink := nil;
  end;
  if FTargetGroup <> AGroup then
  begin
    SetTargetGroupNodeImage(1);
    FTargetGroup := AGroup;
    SetTargetGroupNodeImage(3);
  end;
  if FTargetLink <> ALink then
  begin
    SetTargetLinkNodeImage(2);
    FTargetLink := ALink;
    SetTargetLinkNodeImage(4);
  end;
end;

procedure TdxNavBarDsgnWindowLinksHandler.ClearTargets;
begin
  SetTargetGroupNodeImage(1);
  SetTargetLinkNodeImage(2);
  FTargetGroup := nil;
  FTargetLink := nil;;
end;

procedure TdxNavBarDsgnWindowLinksHandler.Add;
begin
  CreateLink(SelectedItem, SelectedGroup, -1);
  UpdateButtonsState;
end;

procedure TdxNavBarDsgnWindowLinksHandler.Delete;
begin
  RemoveLink(SelectedLink);
  UpdateButtonsState;
end;

procedure TdxNavBarDsgnWindowLinksHandler.MoveSelection(ADelta: Integer);
begin
  MoveLink(SelectedLink, SelectedGroup, SelectedLink.Index + ADelta);
  UpdateButtonsState;
end;

procedure TdxNavBarDsgnWindowLinksHandler.UpdateContent;
begin
  RefreshItemList;
  RefreshGroupTreeView;
end;

procedure TdxNavBarDsgnWindowLinksHandler.UpdateItem(AItem: TComponent);
begin
  UpdateContent;// TODO
end;

procedure TdxNavBarDsgnWindowLinksHandler.UpdateButtonsPanel;
begin
  DsgnWindow.pnBtnAddDelete.Visible := True;
  DsgnWindow.pnBtnSelect.Visible := False;
  DsgnWindow.pnBtnMove.Visible := True;
  DsgnWindow.pnBtnDefaultSettings.Visible := False;
  DsgnWindow.pnBtnApply.Visible := False;
end;

function TdxNavBarDsgnWindowLinksHandler.ItemsLV: TListView;
begin
  Result := DsgnWindow.lbxLinkDesignerItems;
end;

function TdxNavBarDsgnWindowLinksHandler.LinksTV: TTreeView;
begin
  Result := DsgnWindow.tvLinkDesignerGroups;
end;

procedure TdxNavBarDsgnWindowLinksHandler.CreateLink(AItem: TdxNavBarItem; AGroup: TdxNavBarGroup; AIndex: Integer);
var
  ALink: TdxNavBarItemLink;
begin
  DsgnWindow.tvLinkDesignerGroups.Items.BeginUpdate;
  try
    ALink := AGroup.CreateLink(AItem);
    if (AIndex >= 0) and (AIndex < AGroup.LinkCount) then
      ALink.Index := AIndex;
    CreateNodeByLink(ALink);
  finally
    DsgnWindow.tvLinkDesignerGroups.FullExpand;
    DsgnWindow.tvLinkDesignerGroups.Items.EndUpdate;
  end;
end;

procedure TdxNavBarDsgnWindowLinksHandler.MoveLink(ALink: TdxNavBarItemLink; AGroup: TdxNavBarGroup; AIndex: Integer);
var
  AItem: TdxNavBarItem;
begin
  AItem := ALink.Item;
  RemoveLink(ALink);
  CreateLink(AItem, AGroup, AIndex);
end;

procedure TdxNavBarDsgnWindowLinksHandler.RemoveLink(ALink: TdxNavBarItemLink);
begin
  RemoveNodeByLink(ALink);
  ALink.Group.RemoveLink(ALink.Index);
end;

procedure TdxNavBarDsgnWindowLinksHandler.RefreshGroupTreeView;
var
  I, J: Integer;
  Group: TdxNavBarGroup;
  Node: TTreeNode;
begin
  LinksTV.Items.BeginUpdate;
  try
    LinksTV.Items.Clear;
    if NavBar = nil then Exit;

    for I := 0 to NavBar.Groups.Count - 1 do
    begin
      Group := NavBar.Groups[I];
      if Group.Owner = NavBar.Owner then
      begin
        Node := LinksTV.Items.AddObject(nil, GetGroupNodeCation(Group), Group);
        Node.ImageIndex := 1;
        Node.SelectedIndex := 1;
        for J := 0 to Group.LinkCount - 1 do
        begin
          with LinksTV.Items.AddChildObject(Node, GetItemNodeCation(Group.Links[J].Item), Group.Links[J]) do
          begin
            ImageIndex := 2;
            SelectedIndex := 2;
          end;
        end;
      end;
    end;
    LinksTV.FullExpand;
  finally
    LinksTV.Items.EndUpdate;
  end;
end;

procedure TdxNavBarDsgnWindowLinksHandler.RefreshItemList;
var
  I: Integer;
  Item: TdxNavBarItem;
begin
  ItemsLV.Items.BeginUpdate;
  try
    ItemsLV.Items.Clear;
    if NavBar = nil then Exit;

    for I := 0 to NavBar.Items.Count - 1 do
    begin
      Item := NavBar.Items[I];
      if Item.Owner = NavBar.Owner then
      with ItemsLV.Items.Add do
      begin
        Caption := GetItemNodeCation(Item);
        Data := Item;
        ImageIndex := 2;
      end;
    end;
  finally
    ItemsLV.Items.EndUpdate;
  end;
end;

function TdxNavBarDsgnWindowLinksHandler.GetSelectedGroup: TdxNavBarGroup;
var
  ALink: TdxNavBarItemLink;
begin
  if LinksTV.Selected <> nil then
  begin
    Result := GetGroupByNode(LinksTV.Selected);
    if Result = nil then
    begin
      ALink := GetLinkByNode(LinksTV.Selected);
      if ALink <> nil then Result := ALink.Group;
    end;
  end
  else Result := nil;
end;

function TdxNavBarDsgnWindowLinksHandler.GetSelectedItem: TdxNavBarItem;
begin
  if ItemsLV.Selected <> nil then
    Result := GetItemByNode(ItemsLV.Selected)
  else Result := nil;
end;

function TdxNavBarDsgnWindowLinksHandler.GetSelectedLink: TdxNavBarItemLink;
begin
  if LinksTV.Selected <> nil then
    Result := GetLinkByNode(LinksTV.Selected)
  else Result := nil;
end;

type
  TdxNavBarDsgnWindowViewsHandler = class(TdxNavBarDsgnWindowPageHandler)
  protected
    class function DesignerCaptionPostfix: string; override;
  public
    procedure UpdateButtonsPanel; override;
    procedure UpdateContent; override;
    procedure UpdateItem(AItem: TComponent); override;
  end;

{ TdxNavBarDsgnWindowViewsHandler }

class function TdxNavBarDsgnWindowViewsHandler.DesignerCaptionPostfix: string;
begin
  Result := sdxViewsDesigner;
end;

procedure TdxNavBarDsgnWindowViewsHandler.UpdateContent;
begin
  DsgnWindow.cbViewStyles.ItemIndex := NavBar.View;
  DsgnWindow.nbPreview.View := NavBar.View;
end;

procedure TdxNavBarDsgnWindowViewsHandler.UpdateButtonsPanel;
begin
  DsgnWindow.pnBtnAddDelete.Visible := False;
  DsgnWindow.pnBtnSelect.Visible := False;
  DsgnWindow.pnBtnMove.Visible := False;
  DsgnWindow.pnBtnDefaultSettings.Visible := False;
  DsgnWindow.pnBtnApply.Visible := True;
end;

procedure TdxNavBarDsgnWindowViewsHandler.UpdateItem(AItem: TComponent);
begin
  if AItem = nil then UpdateContent;
end;

type
  TdxNavBarDsgnWindowDefaultStylesHandler = class(TdxNavBarDsgnWindowPageHandler)
  private
    function GetItem(Index: Integer): TdxNavBarDefaultStyle;
    function GetItemCount: Integer;
    function GetSelected(Index: Integer): Boolean;
    procedure SetSelected(Index: Integer; const Value: Boolean);
  protected
    class function DesignerCaptionPostfix: string; override;
    function MainList: TListBox;
  public
    procedure GetSelections(const ASelections: IDesignerSelections); override;
    procedure UpdateButtonsPanel; override;
    procedure UpdateContent; override;
    procedure UpdateSelections(const ASelections: IDesignerSelections); override;

    property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
    property Items[Index: Integer]: TdxNavBarDefaultStyle read GetItem;
    property ItemCount: Integer read GetItemCount;
  end;

{ TdxNavBarDsgnWindowDefaultStylesHandler }

class function TdxNavBarDsgnWindowDefaultStylesHandler.DesignerCaptionPostfix: string;
begin
  Result := sdxDefaultStylesDesigner;
end;

function TdxNavBarDsgnWindowDefaultStylesHandler.GetItem(
  Index: Integer): TdxNavBarDefaultStyle;
begin
  if MainList <> nil then
    Result := TdxNavBarDefaultStyle(MainList.Items.Objects[Index])
  else Result := nil;
end;

function TdxNavBarDsgnWindowDefaultStylesHandler.GetItemCount: Integer;
begin
  if MainList <> nil then
    Result := MainList.Items.Count
  else Result := 0;
end;

function TdxNavBarDsgnWindowDefaultStylesHandler.GetSelected(
  Index: Integer): Boolean;
begin
  if MainList <> nil then
    Result := MainList.Selected[Index]
  else Result := False;
end;

procedure TdxNavBarDsgnWindowDefaultStylesHandler.GetSelections(
  const ASelections: IDesignerSelections);
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
    if Selected[I] then
      ASelections.Add(dxNavBarDsgnUtils.MakeIPersistent(Items[I]));
  if ASelections.Count = 0 then
    ASelections.Add(dxNavBarDsgnUtils.MakeIComponent(NavBar));
end;

function TdxNavBarDsgnWindowDefaultStylesHandler.MainList: TListBox;
begin
  Result := DsgnWindow.lbxDefaultStyles;
end;

procedure TdxNavBarDsgnWindowDefaultStylesHandler.UpdateContent;
var
  PropList: TPropList;
  V: Variant;
  I: Integer;
  AStyle: TdxNavBarDefaultStyle;
  ACount: Integer;
begin
  if MainList.Items.Count > 0 then exit;
  ACount := GetPropList(TypeInfo(TdxNavBarDefaultStyles), [tkClass], @PropList);
  for I := 0 to ACount - 1 do
  begin
    if TdxNavBarDefaultStyle.ClassName = PropList[I].PropType^.Name then
    begin
      V := GetPropValue(NavBar.DefaultStyles, PropList[I].Name);
       //TODO !!!!
      AStyle := TdxNavBarDefaultStyle(TVarData(V).VPointer);
      MainList.Items.AddObject(PropList[I].Name, AStyle);
    end;
  end;
end;

procedure TdxNavBarDsgnWindowDefaultStylesHandler.UpdateButtonsPanel;
begin
  DsgnWindow.pnBtnAddDelete.Visible := False;
  DsgnWindow.pnBtnSelect.Visible := False;
  DsgnWindow.pnBtnMove.Visible := False;
  DsgnWindow.pnBtnDefaultSettings.Visible := True;
  DsgnWindow.pnBtnApply.Visible := False;
end;

procedure TdxNavBarDsgnWindowDefaultStylesHandler.SetSelected(
  Index: Integer; const Value: Boolean);
begin
  if MainList <> nil then
    MainList.Selected[Index] := Value;
end;

procedure TdxNavBarDsgnWindowDefaultStylesHandler.UpdateSelections(
  const ASelections: IDesignerSelections);

  function InSelection(AItem: TPersistent): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to ASelections.Count - 1 do
      if AItem = dxNavBarDsgnUtils.TryExtractPersistent(ASelections[I]) then
      begin
        Result := True;
        break;
      end;
  end;

var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
    if Selected[I] xor InSelection(Items[I]) then
      Selected[I] := not Selected[I];
end;

{ TdxNavBarDsgnWindowPageHandler }

constructor TdxNavBarDsgnWindowPageHandler.Create(ADsgnWindow: TdxfmNavBarDesignWindow);
begin
  inherited Create;
  FDsgnWindow := ADsgnWindow;
end;

destructor TdxNavBarDsgnWindowPageHandler.Destroy;
begin
  inherited;
end;

procedure TdxNavBarDsgnWindowPageHandler.Activate;
begin
  UpdateContent;
  UpdateButtonsPanel;
  UpdateButtonsState;
end;

procedure TdxNavBarDsgnWindowPageHandler.Add;
begin
end;

procedure TdxNavBarDsgnWindowPageHandler.Copy;
begin
end;

procedure TdxNavBarDsgnWindowPageHandler.Cut;
begin
end;

procedure TdxNavBarDsgnWindowPageHandler.Delete;
begin
end;

procedure TdxNavBarDsgnWindowPageHandler.DeleteItem(AItem: TComponent);
begin
end;

procedure TdxNavBarDsgnWindowPageHandler.GetSelections(const ASelections: IDesignerSelections);
begin
end;

procedure TdxNavBarDsgnWindowPageHandler.MoveSelection(ADelta: Integer);
begin
end;

procedure TdxNavBarDsgnWindowPageHandler.Paste;
begin
end;

procedure TdxNavBarDsgnWindowPageHandler.UpdateContent;
begin
end;

procedure TdxNavBarDsgnWindowPageHandler.SelectAll;
begin
end;

class function TdxNavBarDsgnWindowPageHandler.DesignerCaptionPostfix: string;
begin
  Result := sdxNavBarDesigner;
end;

function TdxNavBarDsgnWindowPageHandler.CanAdd: Boolean;
begin
  Result := False;
end;

function TdxNavBarDsgnWindowPageHandler.CanCopy: Boolean;
begin
  Result := False;
end;

function TdxNavBarDsgnWindowPageHandler.CanCut: Boolean;
begin
  Result := False;
end;

function TdxNavBarDsgnWindowPageHandler.CanDelete: Boolean;
begin
  Result := False;
end;

function TdxNavBarDsgnWindowPageHandler.CanSelectAll: Boolean;
begin
  Result := False;
end;

function TdxNavBarDsgnWindowPageHandler.CanMoveUp: Boolean;
begin
  Result := False;
end;

function TdxNavBarDsgnWindowPageHandler.CanMoveDown: Boolean;
begin
  Result := False;
end;

function TdxNavBarDsgnWindowPageHandler.CanPaste: Boolean;
begin
  Result := False;
end;

procedure TdxNavBarDsgnWindowPageHandler.UpdateButtonsPanel;
begin
end;

procedure TdxNavBarDsgnWindowPageHandler.UpdateButtonsState;
begin
  DsgnWindow.UpdateButtonsState;
end;

procedure TdxNavBarDsgnWindowPageHandler.UpdateItem(AItem: TComponent);
begin
end;

procedure TdxNavBarDsgnWindowPageHandler.UpdateScrollBar;
begin
end;

procedure TdxNavBarDsgnWindowPageHandler.UpdateSelections(const ASelections: IDesignerSelections);
begin
end;

function TdxNavBarDsgnWindowPageHandler.GetNavBar: TdxCustomNavBar;
begin
  if DsgnWindow <> nil then
    Result := DsgnWindow.NavBar
  else Result := nil;
end;

{ TdxfmNavBarDesignWindow }

constructor TdxfmNavBarDesignWindow.Create(AOwner: TComponent);
begin
  inherited;
  FHandlers := TList.Create;
  InitializeHandlers;
  InitializeViewStyles;

  btDelete.Tag := Integer(eaDelete);
  btSelectAll.Tag := Integer(eaSelectAll);
  miCut.Tag := Integer(eaCut);
  miCopy.Tag := Integer(eaCopy);
  miPaste.Tag := Integer(eaPaste);
  miDelete.Tag := Integer(eaDelete);
  miSelectAll.Tag := Integer(eaSelectAll);

  pcMain.ActivePage := pcMain.Pages[0];
  ActiveDesignerPageChanged;
  RestoreLayout; 
end;

destructor TdxfmNavBarDesignWindow.Destroy;
begin
  FinalizeHandlers;
  FHandlers.Free;
  StoreLayout;
  if NavBarDesigner <> nil then
    TdxNavBarDesigner(NavBarDesigner).FDesignWindow := nil;
  inherited;
end;

function TdxfmNavBarDesignWindow.ClipboardComponents: Boolean;
begin
  Result := inherited ClipboardComponents;
end;

{$IFDEF DELPHI6}
function TdxfmNavBarDesignWindow.EditAction(Action: TEditAction): Boolean;
{$ELSE}
procedure TdxfmNavBarDesignWindow.EditAction(Action: TEditAction);
{$ENDIF}
begin
{$IFDEF DELPHI6}
  Result := True;
{$ENDIF}
  case Action of
    eaCut: Cut;
    eaCopy: Copy;
    eaPaste: Paste;
    eaDelete: Delete;
    eaSelectAll: SelectAll;
  end;
end;

function TdxfmNavBarDesignWindow.GetEditState: TEditState;
begin
  Result := [];
  if CanDelete then
    Result := Result + [esCanDelete];
  if CanSelectAll then
    Result := Result + [esCanSelectAll];
  if CanCut then
    Result := Result + [esCanCut];
  if CanCopy then
    Result := Result + [esCanCopy];
  if CanPaste then
    Result := Result + [esCanPaste];
end;

{$IFDEF DELPHI6}
procedure TdxfmNavBarDesignWindow.ItemDeleted(const ADesigner: IDesigner;
  Item: TPersistent);
{$ELSE}
procedure TdxfmNavBarDesignWindow.ComponentDeleted(Component: IPersistent);
{$ENDIF}
var
  AComponent: TComponent;
begin
  inherited;
{$IFDEF DELPHI6}
  if Item is TComponent then
{$ENDIF}
  begin
    AComponent := dxNavBarDsgnUtils.TryExtractComponent({$IFDEF DELPHI6}Item{$ELSE}Component{$ENDIF});
    if (NavBar <> nil) and not (csDestroying in NavBar.ComponentState) and
      (CurrentHandler <> nil) then
      CurrentHandler.DeleteItem(AComponent);
  end;
end;

{$IFDEF DELPHI6}
procedure TdxfmNavBarDesignWindow.ItemsModified(const Designer: IDesigner);
{$ELSE}
procedure TdxfmNavBarDesignWindow.FormModified;
{$ENDIF}
begin
  inherited;
  UpdateCaption;
end;

{$IFDEF DELPHI6}
procedure TdxfmNavBarDesignWindow.SelectionChanged(const ADesigner: IDesigner;
  const ASelection: IDesignerSelections);
{$ELSE}
procedure TdxfmNavBarDesignWindow.SelectionChanged(ASelection: TDesignerSelectionList);
{$ENDIF}
begin
  inherited;
{$IFDEF DELPHI6}
  if ADesigner = Designer then
{$ENDIF}
    UpdateSelections(ASelection);
end;

procedure TdxfmNavBarDesignWindow.Activated;
var
  Selections: IDesignerSelections;
begin
  inherited;
  if CurrentHandler <> nil then
    CurrentHandler.Activate;
  Selections := CreateSelectionList;
  Designer.GetSelections(Selections);
  UpdateSelections(Selections);
end;

{$IFDEF DELPHI9}
procedure TdxfmNavBarDesignWindow.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := Application.MainForm.Handle;
end;
{$ENDIF}

function TdxfmNavBarDesignWindow.UniqueName(Component: TComponent): string;
begin
  if CurrentHandler is TdxNavBarDsgnWindowComponentCollectionPageHandler then
    Result := NavBar.Name + (CurrentHandler as TdxNavBarDsgnWindowComponentCollectionPageHandler).ItemNamePrefix
  else
    Result := NavBar.Name;
  Result := Designer.UniqueName(Result);
end;

procedure TdxfmNavBarDesignWindow.ActiveDesignerPageChanged;
begin
  SelectNavBar;
  if pcMain.ActivePage.PageIndex < HandlerCount then
  begin
    CurrentHandler := Handlers[pcMain.ActivePage.PageIndex];
    if CurrentHandler <> nil then
      CurrentHandler.Activate;
    UpdateCaption;
  end;
end;

function TdxfmNavBarDesignWindow.GetNavBarDesigner: TAbstractcxNavBarDesigner;
begin
  if NavBar <> nil then
    Result := NavBar.Designer
  else Result := nil;
end;

procedure TdxfmNavBarDesignWindow.SetNavBar(Value: TdxCustomNavBar);
begin
  if FNavBar <> Value then
  begin
    FNavBar := Value;
    if CurrentHandler <> nil then
      CurrentHandler.UpdateContent;
    UpdateCaption;
    UpdateButtonsState;
  end;
end;

function TdxfmNavBarDesignWindow.CanAdd: Boolean;
begin
  if CurrentHandler <> nil then
    Result := CurrentHandler.CanAdd
  else Result := False;
end;

function TdxfmNavBarDesignWindow.CanCopy: Boolean;
begin
  if CurrentHandler <> nil then
    Result := CurrentHandler.CanCopy
  else Result := False;
end;

function TdxfmNavBarDesignWindow.CanCut: Boolean;
begin
  if CurrentHandler <> nil then
    Result := CurrentHandler.CanCut
  else Result := False;
end;

function TdxfmNavBarDesignWindow.CanDelete: Boolean;
begin
  if CurrentHandler <> nil then
    Result := CurrentHandler.CanDelete
  else Result := False;
end;

function TdxfmNavBarDesignWindow.CanMoveDown: Boolean;
begin
  if CurrentHandler <> nil then
    Result := CurrentHandler.CanMoveDown
  else Result := False;
end;

function TdxfmNavBarDesignWindow.CanMoveUp: Boolean;
begin
  if CurrentHandler <> nil then
    Result := CurrentHandler.CanMoveUp
  else Result := False;
end;

function TdxfmNavBarDesignWindow.CanPaste: Boolean;
begin
  if CurrentHandler <> nil then
    Result := CurrentHandler.CanPaste
  else Result := False;
end;

function TdxfmNavBarDesignWindow.CanSelectAll: Boolean;
begin
  if CurrentHandler <> nil then
    Result := CurrentHandler.CanSelectAll
  else Result := False;
end;

procedure TdxfmNavBarDesignWindow.Copy;
begin
  if CurrentHandler <> nil then
    CurrentHandler.Copy;
end;

procedure TdxfmNavBarDesignWindow.Cut;
begin
  if CurrentHandler <> nil then
    CurrentHandler.Cut;
end;

procedure TdxfmNavBarDesignWindow.Delete;
begin
  if CurrentHandler <> nil then
    CurrentHandler.Delete;
end;

procedure TdxfmNavBarDesignWindow.HandleException;
begin
  Abort;
end;

function TdxfmNavBarDesignWindow.GetRegistryPath: string;
begin
  Result := (BorlandIDEServices as IOTAServices).GetBaseRegistryKey + '\' +
      sdxExpressNavBarDesignerLayoutRegPath;
end;

procedure TdxfmNavBarDesignWindow.Paste;
begin
  if CurrentHandler <> nil then
    CurrentHandler.Paste;
end;

procedure TdxfmNavBarDesignWindow.RestoreLayout;
begin
  with TRegistry.Create do
  try
    try
      if OpenKey(GetRegistryPath, False) then
      begin
        if ValueExists(sdxWidth) then
          Width := ReadInteger(sdxWidth);
        if ValueExists(sdxHeight) then
          Height := ReadInteger(sdxHeight);
      end;
    except
      HandleException;
    end;
  finally
    Free;
  end;
  if CurrentHandler <> nil then
    CurrentHandler.UpdateScrollBar;
end;

procedure TdxfmNavBarDesignWindow.Select(AComponent: TComponent; AddToSelection: Boolean);
var
  Selections: IDesignerSelections;
begin
  Selections := CreateSelectionList;
  if AddToSelection then
    Designer.GetSelections(Selections);
  Selections.Add(dxNavBarDsgnUtils.MakeIComponent(AComponent));
  Designer.SetSelections(Selections);
end;

procedure TdxfmNavBarDesignWindow.SelectAll;
begin
  if CurrentHandler <> nil then
    CurrentHandler.SelectAll;
end;

procedure TdxfmNavBarDesignWindow.SelectNavBar;
begin
  if NavBar <> nil then
    Select(NavBar, False);
end;

procedure TdxfmNavBarDesignWindow.StartWait;
begin
  FSaveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
end;

procedure TdxfmNavBarDesignWindow.StopWait;
begin
  Screen.Cursor := FSaveCursor;
end;

procedure TdxfmNavBarDesignWindow.StoreLayout;
begin
  with TRegistry.Create do
  try
    try
      if OpenKey(GetRegistryPath, True) then
      begin
        WriteInteger(sdxWidth, Width);
        WriteInteger(sdxHeight, Height);
      end;
    except
      HandleException;
    end;
  finally
    Free;
  end;
end;

procedure TdxfmNavBarDesignWindow.UpdateButtonsState;
begin
  btAdd.Enabled := CanAdd;
  btDelete.Enabled := CanDelete;
  btSelectAll.Enabled := CanSelectAll;
  btMoveUp.Enabled := CanMoveUp;
  btMoveDown.Enabled := CanMoveDown;
end;

procedure TdxfmNavBarDesignWindow.UpdateCaption;
var
  APostfix: string;
begin
  if (NavBar <> nil) and (NavBar.Owner <> nil) then
  begin
    if CurrentHandler <> nil then
      APostfix := CurrentHandler.DesignerCaptionPostfix
    else APostfix := sdxNavBarDesigner;
    Caption := Format(sdxDesignerCaption, [NavBar.Owner.Name, NavBar.Name, APostfix]);
  end;
end;

procedure TdxfmNavBarDesignWindow.UpdateItem(AItem: TComponent);
begin
  if CurrentHandler <> nil then
    CurrentHandler.UpdateItem(AItem);
  UpdateButtonsState;
end;

procedure TdxfmNavBarDesignWindow.UpdateMenuState;
begin
  miAdd.Enabled := CanAdd;
  miCut.Enabled := CanCut;
  miCopy.Enabled := CanCopy;
  miPaste.Enabled := CanPaste;
  miDelete.Enabled := CanDelete;
  miSelectAll.Enabled := CanSelectAll;
  miMoveUp.Enabled := CanMoveUp;
  miMoveDown.Enabled := CanMoveDown;
end;

procedure TdxfmNavBarDesignWindow.UpdateSelections(const ASelections: IDesignerSelections);
begin
  if (NavBar = nil) or (csDestroying in NavBar.ComponentState) or (ASelections = nil) then exit;
  if CurrentHandler <> nil then
    CurrentHandler.UpdateSelections(ASelections);
  UpdateButtonsState;
end;

procedure TdxfmNavBarDesignWindow.ListBoxClick(Sender: TObject);
var
  Selections: IDesignerSelections;
begin
  Selections := CreateSelectionList;
  if CurrentHandler <> nil then
    CurrentHandler.GetSelections(Selections);
  Designer.SetSelections(Selections);
end;

function TdxfmNavBarDesignWindow.GetHandler(Index: Integer): TdxNavBarDsgnWindowPageHandler;
begin
  Result := TdxNavBarDsgnWindowPageHandler(FHandlers.Items[Index]);
end;

function TdxfmNavBarDesignWindow.GetHandlerCount: Integer;
begin
  Result := FHandlers.Count;
end;

procedure TdxfmNavBarDesignWindow.InitializeHandlers;
begin
  FHandlers.Add(TdxNavBarDsgnWindowGroupsHandler.Create(Self));
  FHandlers.Add(TdxNavBarDsgnWindowItemsHandler.Create(Self));
  FHandlers.Add(TdxNavBarDsgnWindowLinksHandler.Create(Self));
  FHandlers.Add(TdxNavBarDsgnWindowViewsHandler.Create(Self));
  FHandlers.Add(TdxNavBarDsgnWindowDefaultStylesHandler.Create(Self));
  FHandlers.Add(TdxNavBarDsgnWindowCustomStylesHandler.Create(Self));
end;

procedure TdxfmNavBarDesignWindow.InitializeViewStyles;
var
  I: Integer;
begin
  for I := 0 to dxNavBarViewsFactory.Count - 1 do
     cbViewStyles.Items.Add(dxNavBarViewsFactory.Names[I]);
end;

procedure TdxfmNavBarDesignWindow.FinalizeHandlers;
var
  I: Integer;
begin
  for I := 0 to FHandlers.Count - 1 do
    TdxNavBarDsgnWindowPageHandler(FHandlers.Items[I]).Free;
  FHandlers.Clear;
end;

procedure TdxfmNavBarDesignWindow.AddClick(Sender: TObject);
begin
  if CurrentHandler <> nil then
    CurrentHandler.Add;
end;

procedure TdxfmNavBarDesignWindow.ActionClick(Sender: TObject);
begin
  EditAction(TEditAction(TComponent(Sender).Tag));
end;

procedure TdxfmNavBarDesignWindow.MoveUpClick(Sender: TObject);
begin
  if CurrentHandler <> nil then
    CurrentHandler.MoveSelection(-1);
end;

procedure TdxfmNavBarDesignWindow.MoveDownClick(Sender: TObject);
begin
  if CurrentHandler <> nil then
    CurrentHandler.MoveSelection(1);
end;

procedure TdxfmNavBarDesignWindow.tvLinkDesignerGroupsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var
  AGroup: TdxNavBarGroup;
  AIndex: Integer;
begin
  if CurrentHandler is TdxNavBarDsgnWindowLinksHandler then
    with (CurrentHandler as TdxNavBarDsgnWindowLinksHandler) do
    begin
      SetTargetGroupNodeImage(1);
      SetTargetLinkNodeImage(2);
      if TargetLink <> nil then
      begin
        AIndex := TargetLink.Index;
        AGroup := TargetLink.Group;
      end
      else
      begin
        AIndex := -1;
        AGroup := TargetGroup;
      end;
      if AGroup <> nil then
      begin
        if SourceItem <> nil then
          CreateLink(SourceItem, AGroup, AIndex)
        else if SourceLink <> nil then
          MoveLink(SourceLink, AGroup, AIndex);
      end;
      SourceItem := nil;
      SourceLink := nil;
      ClearTargets;
    end;
  UpdateButtonsState;
end;

procedure TdxfmNavBarDesignWindow.tvLinkDesignerGroupsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if CurrentHandler is TdxNavBarDsgnWindowLinksHandler then
    with (CurrentHandler as TdxNavBarDsgnWindowLinksHandler) do
    begin
      Accept := (SourceLink <> nil) or (SourceItem <> nil);
      if Accept then
        UpdateTargets(tvLinkDesignerGroups.GetNodeAt(X, Y));
      Accept := Accept and ((TargetGroup <> nil) or (TargetLink <> nil));
    end
  else Accept := False;
end;

procedure TdxfmNavBarDesignWindow.lbxLinkDesignerItemsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if CurrentHandler is TdxNavBarDsgnWindowLinksHandler then
    with (CurrentHandler as TdxNavBarDsgnWindowLinksHandler) do
      Accept := (SourceLink <> nil)
  else Accept := False
end;

procedure TdxfmNavBarDesignWindow.lbxLinkDesignerItemsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
begin
  if CurrentHandler is TdxNavBarDsgnWindowLinksHandler then
    with (CurrentHandler as TdxNavBarDsgnWindowLinksHandler) do
    begin
      RemoveLink(SourceLink);
      SourceLink := nil;
    end;
  UpdateButtonsState;      
end;

procedure TdxfmNavBarDesignWindow.lbxLinkDesignerItemsStartDrag(
  Sender: TObject; var DragObject: TDragObject);
begin
  if CurrentHandler is TdxNavBarDsgnWindowLinksHandler then
    with (CurrentHandler as TdxNavBarDsgnWindowLinksHandler) do
    begin
      SourceItem := GetItemByNode(lbxLinkDesignerItems.Selected);
      if SourceItem = nil then CancelDrag;
    end;
end;

procedure TdxfmNavBarDesignWindow.tvLinkDesignerGroupsStartDrag(
  Sender: TObject; var DragObject: TDragObject);
begin
  if CurrentHandler is TdxNavBarDsgnWindowLinksHandler then
    with (CurrentHandler as TdxNavBarDsgnWindowLinksHandler) do
    begin
      SourceLink := GetLinkByNode(tvLinkDesignerGroups.Selected);
      if SourceLink = nil then CancelDrag;
    end;
end;

procedure TdxfmNavBarDesignWindow.tvLinkDesignerGroupsExit(
  Sender: TObject);
begin
  if CurrentHandler is TdxNavBarDsgnWindowLinksHandler then
    with (CurrentHandler as TdxNavBarDsgnWindowLinksHandler) do ClearTargets;
end;

procedure TdxfmNavBarDesignWindow.tvLinkDesignerGroupsKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  UpdateButtonsState;
end;

procedure TdxfmNavBarDesignWindow.pmMainPopup(Sender: TObject);
begin
  UpdateMenuState;
end;

procedure TdxfmNavBarDesignWindow.tvLinkDesignerGroupsClick(
  Sender: TObject);
begin
  UpdateButtonsState;
end;

procedure TdxfmNavBarDesignWindow.lbxLinkDesignerItemsClick(
  Sender: TObject);
begin
  UpdateButtonsState;
end;

procedure TdxfmNavBarDesignWindow.tvLinkDesignerGroupsEndDrag(Sender,
  Target: TObject; X, Y: Integer);
begin
  if CurrentHandler is TdxNavBarDsgnWindowLinksHandler then
    with (CurrentHandler as TdxNavBarDsgnWindowLinksHandler) do ClearTargets;
end;

procedure TdxfmNavBarDesignWindow.lbxLinkDesignerItemsEndDrag(Sender,
  Target: TObject; X, Y: Integer);
begin
  if CurrentHandler is TdxNavBarDsgnWindowLinksHandler then
    with (CurrentHandler as TdxNavBarDsgnWindowLinksHandler) do ClearTargets;
end;

procedure TdxfmNavBarDesignWindow.nbMainLinkClick(Sender: TObject;
  ALink: TdxNavBarItemLink);
begin
  if ALink.Item.Index < pcMain.PageCount then
    pcMain.ActivePage := pcMain.Pages[ALink.Item.Index];
  ActiveDesignerPageChanged;
end;

procedure TdxfmNavBarDesignWindow.DefaultSettingsClick(Sender: TObject);
begin
  NavBar.AssignDefaultStyles;
  Designer.Modified;
end;

procedure TdxfmNavBarDesignWindow.cbViewStylesChange(Sender: TObject);
begin
  nbPreview.View := (Sender as TComboBox).ItemIndex;
end;

procedure TdxfmNavBarDesignWindow.btnApplyClick(Sender: TObject);
begin
  NavBar.View := nbPreview.View;
  Designer.Modified;
end;

end.
 
