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

unit cxGridEditor; // TODO: Add Level and View...

{$I cxGridVer.inc}

interface

uses
  Windows,
{$IFDEF DELPHI6}
  DesignIntf,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  Classes, SysUtils, Controls, Graphics, Forms, cxClasses,
  StdCtrls, ExtCtrls, ComCtrls, Menus,
  cxControls, cxDesignWindows, cxGridStructureNavigator,
  cxGrid, cxGridLevel, cxGridCustomView, cxViewEditor,
  cxGridViewLayoutEditor;

type
  TSelectedViewInfo = record
    View: TcxCustomGridView;
    MultiView: Boolean;
  end;

  TcxGridEditor = class(TcxDesignFormEditor)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    BClose: TButton;
    Panel4: TPanel;
    PLeft: TPanel;
    PageControl1: TPageControl;
    tsLevels: TTabSheet;
    TabSheet2: TTabSheet;
    Splitter1: TSplitter;
    PLevels: TPanel;
    PViews: TPanel;
    LBViews: TListBox;
    Panel7: TPanel;
    Panel8: TPanel;
    PMGridStructureControl: TPopupMenu;
    Panel6: TPanel;
    BAddLevel: TButton;
    BDeleteLevel: TButton;
    Panel9: TPanel;
    BAddView: TButton;
    BDeleteView: TButton;
    PMViews: TPopupMenu;
    PViewFrame: TPanel;
    Panel11: TPanel;
    Label1: TLabel;
    LSelectedView: TLabel;
    Panel10: TPanel;
    PMViewList: TPopupMenu;
    miDeleteView: TMenuItem;
    N1: TMenuItem;
    miEditLayout: TMenuItem;
    procedure BCloseClick(Sender: TObject);
    procedure BDeleteLevelClick(Sender: TObject);
    procedure BAddLevelClick(Sender: TObject);
    procedure LBViewsClick(Sender: TObject);
    procedure BAddViewClick(Sender: TObject);
    procedure BDeleteViewClick(Sender: TObject);
    procedure GridStructureControlKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miEditLayoutClick(Sender: TObject);
  private
    FGridStructureControl: TcxGridStructureControl;
    FGridStructureHelper: TcxGridStructureHelper;
    FViewEditor: TcxViewEditor;
    procedure CreateViewClick(Sender: TObject);
    function GetGrid: TcxCustomGrid;
    function GetView(Index: Integer): TcxCustomGridView;
    function GetViewCount: Integer;
    function GetViewRepository: TcxGridViewRepository;
    procedure GridStructureControlSelectionChanged(Sender: TObject);
    procedure HideViewFrame;
    procedure ShowViewFrame(AView: TcxCustomGridView; AMultiView: Boolean; ARefreshNeeded: Boolean);
    procedure UpdateButtons;
    procedure UpdateDesigner(Sender: TObject);
    procedure UpdateGridStructureControl;
    procedure UpdateGridStructureControlSelection;
    procedure UpdateViewFrame(ARefreshNeeded: Boolean);
    procedure UpdateViewFrameCaption;
    procedure UpdateViewList;
    procedure UpdateViewListSelection;
  protected
    function GetSelectedViewInfo: TSelectedViewInfo;
    function GetViewEditorClass(AView: TcxCustomGridView): TcxViewEditorClass; virtual;
    procedure InitFormEditor; override;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure ShowDefaultView;
    function UniqueName(Component: TComponent): string; override;
    procedure UpdateContent; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoItemsModified; override;
    function GetRegKey: string;
    function GetRegSectionName: string;
    procedure SelectionsChanged(const ASelection: TDesignerSelectionList); override;
    property Grid: TcxCustomGrid read GetGrid;
    property ViewCount: Integer read GetViewCount;
    property ViewRepository: TcxGridViewRepository read GetViewRepository;
    property Views[Index: Integer]: TcxCustomGridView read GetView;
  end;

procedure ShowGridEditor(ADesigner: IDesigner; AGrid: TcxCustomGrid);
procedure ShowViewRepositoryEditor(ADesigner: IDesigner; AViewRepository: TcxGridViewRepository);

implementation

{$IFDEF WIN32}
uses
  Registry;
{$ENDIF}

{$R *.dfm}

procedure ShowGridEditor(ADesigner: IDesigner; AGrid: TcxCustomGrid);
begin
  ShowFormEditorClass(ADesigner, AGrid, TcxGridEditor);
end;

procedure ShowViewRepositoryEditor(ADesigner: IDesigner; AViewRepository: TcxGridViewRepository);
begin
  ShowFormEditorClass(ADesigner, AViewRepository, TcxGridEditor);
end;

{ TcxGridEditor }

constructor TcxGridEditor.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TcxGridEditor.Destroy;
begin
  FreeAndNil(FGridStructureHelper);
  inherited Destroy;
end;

procedure TcxGridEditor.DoItemsModified;
begin
  inherited;
  UpdateViewList;
  UpdateViewFrame(True);
end;

function TcxGridEditor.GetRegKey: string;
begin
  Result := GetBaseRegKey + '\TcxGridEditor';
end;

function TcxGridEditor.GetRegSectionName: string;
begin
  Result := ComponentClassName;
end;

procedure TcxGridEditor.SelectionsChanged(const ASelection: TDesignerSelectionList);
begin
  if Closing then Exit;
  UpdateGridStructureControlSelection;
  UpdateViewListSelection;
  UpdateButtons;
  UpdateViewFrame(False);
end;

function TcxGridEditor.GetSelectedViewInfo: TSelectedViewInfo;
var
  ASelectionList: TDesignerSelectionList;
  AView: TcxCustomGridView;
  I: Integer;
begin
  Result.View := nil;
  Result.MultiView := False;
  ASelectionList := CreateDesignerSelectionList;
  try
    Designer.GetSelections(ASelectionList);
    // Views
    for I := 0 to ASelectionList.Count - 1 do
      if (ASelectionList[I] is TcxCustomGridView) and
        IsViewLinkedToComponent(TcxCustomGridView(ASelectionList[I]), Component) then
        if Result.View = nil then
          Result.View := ASelectionList[I] as TcxCustomGridView
        else
        begin
          Result.View := nil;
          Result.MultiView := True;
          Exit;
        end;
    // Levels
    if Result.View = nil then
      for I := 0 to ASelectionList.Count - 1 do
        if (ASelectionList[I] is TcxGridLevel) and
          (TcxGridLevel(ASelectionList[I]).GetParentComponent = Component) then
          if Result.View = nil then
            Result.View := (ASelectionList[I] as TcxGridLevel).GridView
          else
          begin
            Result.View := nil;
            Result.MultiView := True;
            Break;
          end;
    // View childs
    if Result.View = nil then
      for I := 0 to ASelectionList.Count - 1 do
      begin
        AView := GetLinkedView(ASelectionList[I]);
        if (AView <> nil) and IsViewLinkedToComponent(AView, Component) then
          if Result.View = nil then
            Result.View := AView
          else
            if Result.View <> AView then
            begin
              Result.View := nil;
              Result.MultiView := True;
              Break;
            end;
      end;
  finally
    DeleteDesignerSelectionList(ASelectionList);
  end;
  if (Result.View <> nil) and (csDestroying in Result.View.ComponentState) then
    Result.View := nil;
end;

function TcxGridEditor.GetViewEditorClass(AView: TcxCustomGridView): TcxViewEditorClass;
begin
  Result := cxViewEditor.GetViewEditorClass(TcxCustomGridViewClass(AView.ClassType));
end;

procedure TcxGridEditor.InitFormEditor;
begin
  inherited InitFormEditor;
  FGridStructureControl := TcxGridStructureControl.Create(Self);
  with FGridStructureControl do
  begin
    Align := alClient;
    Grid := Self.Grid;
    MayFocused := True;
    MultiSelect := True;
    Keys := [kChars];
    OnKeyPress := GridStructureControlKeyPress;
    OnSelectionChanged := GridStructureControlSelectionChanged;
    Parent := PLevels;
  end;
  FGridStructureHelper := TcxGridStructureHelper.Create(FGridStructureControl);
  FGridStructureHelper.OnUpdateDesigner := UpdateDesigner;
  tsLevels.TabVisible := Grid <> nil;
  LSelectedView.Caption := '';
  UpdateViewList;
  UpdateSelection;
  ShowDefaultView;
  LoadSettings;
end;

procedure TcxGridEditor.LoadSettings;                   
begin
  Constraints.MinHeight := 340; // TODO
  Constraints.MinWidth := 430;
  {$IFDEF WIN32}
  with TRegIniFile.Create(GetRegKey) do
  try
    Width := ReadInteger(GetRegSectionName, 'Width', Width);
    Height := ReadInteger(GetRegSectionName, 'Height', Height);
    PLeft.Width := ReadInteger(GetRegSectionName, 'PLeft.Width', PLeft.Width);
    // TODO: splitters
  finally
    Free;
  end;
  {$ENDIF}
end;

procedure TcxGridEditor.SaveSettings;
begin
  {$IFDEF WIN32}
  with TRegIniFile.Create(GetRegKey) do
  try
    EraseSection(GetRegSectionName);
    WriteInteger(GetRegSectionName, 'Width', Width);
    WriteInteger(GetRegSectionName, 'Height', Height);
    WriteInteger(GetRegSectionName, 'PLeft.Width', PLeft.Width);
    // TODO: splitters
  finally
    Free;
  end;
  {$ENDIF}
end;

procedure TcxGridEditor.ShowDefaultView;
begin
  if (FViewEditor = nil) and (Grid <> nil) and (Grid.Levels.Count > 0) and
    (Grid.Levels[0].GridView <> nil) then
    ShowViewFrame(Grid.Levels[0].GridView, False, True);
end;

function TcxGridEditor.UniqueName(Component: TComponent): string;
begin
  if Component is TcxGridLevel then
  begin
    if Grid <> nil then
      Result := GenLevelName(Grid, Component as TcxGridLevel)
    else
      Result := inherited UniqueName(Component); // TODO
  end
  else
    if Component is TcxCustomGridView then
      Result := GenViewName(Self.Component, Component as TcxCustomGridView)
    else
      Result := inherited UniqueName(Component); // TODO
end;

procedure TcxGridEditor.UpdateContent;
begin
  inherited UpdateContent;
  UpdateGridStructureControl;
  UpdateViewList;
  UpdateButtons;
  UpdateViewFrame(True);
end;

procedure TcxGridEditor.CreateViewClick(Sender: TObject);

  procedure CreateView(AViewClass: TcxCustomGridViewClass);
  var
    AView: TcxCustomGridView;
  begin
    FGridStructureControl.BeginUpdate;
    try
      ListBoxClearSelection(LBViews);
      if Grid <> nil then
        AView := Grid.CreateView(AViewClass)
      else
        AView := ViewRepository.CreateItem(AViewClass);
      AView.Name := GenViewName(Component, AView);
      RestoreViewFromTemplate(GetViewTemplateRegKey, AView);
      UpdateViewList;
      ListBoxSelectByObject(LBViews, AView);
      UpdateDesigner(nil);
    finally
      FGridStructureControl.EndUpdate;
    end;
    LBViewsClick(nil);
  end;

var
  AMenuItem: TMenuItem;
  AIndex: Integer;
begin
  AMenuItem := Sender as TMenuItem;
  AIndex := AMenuItem.Parent.IndexOf(AMenuItem);
  if (0 <= AIndex) and (AIndex < cxGridRegisteredViews.Count) then
    CreateView(TcxCustomGridViewClass(cxGridRegisteredViews[AIndex]));
end;

function TcxGridEditor.GetGrid: TcxCustomGrid;
begin
  if Component is TcxCustomGrid then
    Result := TcxCustomGrid(Component) 
  else
    Result := nil;
end;

function TcxGridEditor.GetView(Index: Integer): TcxCustomGridView;
begin
  if Grid <> nil then
    Result := Grid.Views[Index]
  else
    Result := ViewRepository[Index];
end;

function TcxGridEditor.GetViewCount: Integer;
begin
  if Grid <> nil then
    Result := Grid.ViewCount
  else
    Result := ViewRepository.Count;
end;

function TcxGridEditor.GetViewRepository: TcxGridViewRepository;
begin
  if Component is TcxGridViewRepository then
    Result := TcxGridViewRepository(Component)
  else
    Result := nil;
end;

procedure TcxGridEditor.GridStructureControlKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    #13, #33..#126:
      begin
        if Key = #13 then Key := #0;
        ActivateInspector(Key);
        Key := #0;
      end;
  end;
end;

procedure TcxGridEditor.GridStructureControlSelectionChanged(Sender: TObject);
var
  AList: TList;
begin
  BeginUpdate;
  try
    AList := TList.Create;
    try
      FGridStructureControl.GetSelection(AList);
      SelectComponents(AList, Component.Owner);
    finally
      AList.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxGridEditor.HideViewFrame;
begin
  if FViewEditor <> nil then
  begin
    FViewEditor.HideFrame;
    FViewEditor.PViewEditor.Parent := FViewEditor;
    FViewEditor.Release;
  end;
  FViewEditor := nil;
end;

procedure TcxGridEditor.ShowViewFrame(AView: TcxCustomGridView; AMultiView: Boolean;
  ARefreshNeeded: Boolean);

  function IsExist(AView: TcxCustomGridView): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to ViewCount - 1 do
      if Views[I] = AView then
      begin
        Result := True;
        Break;
      end;
  end;

var
  AViewEditorClass: TcxViewEditorClass;
begin
  if (FViewEditor <> nil) and (AView = nil) and not AMultiView and IsExist(FViewEditor.View) then
  begin
    FViewEditor.SetView(FViewEditor.View, ARefreshNeeded);
  end  
  else
    if (FViewEditor <> nil) and
      (AView <> nil) and (FViewEditor.ClassType = GetViewEditorClass(AView)) and
      (FViewEditor.View = AView) then
    begin
      FViewEditor.SetView(AView, ARefreshNeeded);
    end
    else
    begin
      HideViewFrame;
      if AView <> nil then
      begin
        AViewEditorClass := GetViewEditorClass(AView);
        if AViewEditorClass <> nil then
        begin
          FViewEditor := AViewEditorClass.Create(Self);
          FViewEditor.FormEditor := Self;
          FViewEditor.SetView(AView, True);
          FViewEditor.PViewEditor.Parent := PViewFrame;
        end;
      end;
    end;
  UpdateViewFrameCaption;
end;

procedure TcxGridEditor.UpdateButtons;
var
  ASelectionLevelCount: Integer;
begin
  ASelectionLevelCount := FGridStructureControl.GetSelectionLevelCount;
  BAddLevel.Enabled := ASelectionLevelCount <= 1;
  BDeleteLevel.Enabled := ASelectionLevelCount > 0;
  BDeleteView.Enabled := LBViews.SelCount > 0;
  miDeleteView.Enabled := BDeleteView.Enabled;
  miEditLayout.Enabled := LBViews.SelCount = 1;
  // TODO: Popup Menu
end;

procedure TcxGridEditor.UpdateDesigner(Sender: TObject);
begin
  Designer.Modified;
end;

procedure TcxGridEditor.UpdateGridStructureControl;
begin
  FGridStructureControl.Changed;
end;

procedure TcxGridEditor.UpdateGridStructureControlSelection;
var
  AList: TList;
begin
  AList := TList.Create;
  try
    GetSelectionList(AList);
    FGridStructureControl.SyncSelection(AList);
  finally
    AList.Free;
  end;
end;

procedure TcxGridEditor.UpdateViewFrame(ARefreshNeeded: Boolean);
var
  ASelectedViewInfo: TSelectedViewInfo;
begin
  ASelectedViewInfo := GetSelectedViewInfo;
  ShowViewFrame(ASelectedViewInfo.View, ASelectedViewInfo.MultiView, ARefreshNeeded);
end;

procedure TcxGridEditor.UpdateViewFrameCaption;
begin
  if FViewEditor <> nil then
    LSelectedView.Caption := FViewEditor.View.Name
  else
    LSelectedView.Caption := '';
end;

procedure TcxGridEditor.UpdateViewList;
var
  I, AItemIndex, ATopIndex: Integer;
  ASelection: TStringList;
begin
  ListBoxSaveSelection(LBViews, ASelection, AItemIndex, ATopIndex);
  try
    LBViews.Items.Clear;
    for I := 0 to ViewCount - 1 do
      LBViews.Items.AddObject(Views[I].Name, Views[I]);
  finally
    ListBoxRestoreSelection(LBViews, ASelection, AItemIndex, ATopIndex);
  end;
end;

procedure TcxGridEditor.UpdateViewListSelection;
var
  AList: TList;
begin
  AList := TList.Create;
  try
    GetSelectionList(AList);
    ListBoxSyncSelection(LBViews, AList);
//Application.ProcessMessages;
  finally
    AList.Free;
  end;
end;

procedure TcxGridEditor.BCloseClick(Sender: TObject);
begin
  Close;
end;

// Levels

procedure TcxGridEditor.BAddLevelClick(Sender: TObject);
var
  ALevel: TcxGridLevel;
begin
  if Grid = nil then Exit;
  FGridStructureControl.BeginUpdate;
  try
    ALevel := FGridStructureControl.GetSelectedLevel;
    if ALevel <> nil then
      ALevel := ALevel.Add
    else
      ALevel := Grid.Levels.Add;
    ALevel.Name := GenLevelName(Grid, ALevel);
    UpdateDesigner(nil);
  finally
    FGridStructureControl.EndUpdate;
  end;
  GridStructureControlSelectionChanged(nil);
end;

procedure TcxGridEditor.BDeleteLevelClick(Sender: TObject);
var
  AList: TList;
  ALevel: TcxGridLevel;
  I, J: Integer;
begin
  AList := TList.Create;
  try
    FGridStructureControl.GetSelectionLevels(AList);
    for I := AList.Count - 1 downto 0 do
    begin
      ALevel := TcxGridLevel(AList[I]);
      for J := 0 to I - 1 do
        if TcxGridLevel(AList[J]).HasAsChild(ALevel) then
        begin
          AList.Delete(I);
          Break;
        end;
    end;
    if AList.Count > 0 then
    begin
      FGridStructureControl.BeginUpdate;
      try
        for I := 0 to AList.Count - 1 do
          TcxGridLevel(AList[I]).Free;
        UpdateDesigner(nil);
      finally
        FGridStructureControl.EndUpdate;
      end;
    end;
  finally
    AList.Free;
  end;
  GridStructureControlSelectionChanged(nil);
end;

// Views

procedure TcxGridEditor.LBViewsClick(Sender: TObject);
var
  AList: TList;
begin
  BeginUpdate;
  try
    AList := TList.Create;
    try
      ListBoxGetSelection(LBViews, AList);
      SelectComponents(AList, Component);
    finally
      AList.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxGridEditor.BAddViewClick(Sender: TObject);

  function CreateMenuItem(const ACaption: string; AOnClick: TNotifyEvent): TMenuItem;
  begin
    Result := TMenuItem.Create(PMViews);
    Result.Caption := ACaption;
    Result.OnClick := AOnClick;
  end;

var
  I: Integer;
  P: TPoint;
begin
  // TODO: cxButton
  while PMViews.Items.Count > 0 do
    PMViews.Items[0].Free;
  for I := 0 to cxGridRegisteredViews.Count - 1 do
    PMViews.Items.Add(CreateMenuItem(cxGridRegisteredViews.Descriptions[I], CreateViewClick));
  P.X := 0;
  P.Y := BAddView.Height;
  P := BAddView.ClientToScreen(P);
  PMViews.Popup(P.X, P.Y);
end;

procedure TcxGridEditor.BDeleteViewClick(Sender: TObject);
begin
  if LBViews.SelCount > 0 then
  begin
    BeginUpdate;
    try
      ListBoxDeleteSelection(LBViews, True);
      UpdateViewList;
      LBViewsClick(nil);
      UpdateDesigner(nil);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxGridEditor.miEditLayoutClick(Sender: TObject);
var
  ASelectedViewInfo: TSelectedViewInfo;
begin
  ASelectedViewInfo := GetSelectedViewInfo;
  if not ASelectedViewInfo.MultiView and (ASelectedViewInfo.View <> nil) then
  begin
    if ShowGridViewLayoutEditor(ASelectedViewInfo.View) then
      UpdateDesigner(nil);
  end;
end;

procedure TcxGridEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SaveSettings;
  inherited;
end;

end.
