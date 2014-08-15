
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressMasterView designer                                  }
{                                                                   }
{       Copyright (c) 1999-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSMASTERVIEW AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM      }
{   ONLY.                                                           }
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

unit dxMasterViewDesigner;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, dxMasterView,
  StdCtrls, ComCtrls, ExtCtrls,
  {$IFDEF DELPHI6}DesignIntf, DesignWindows{$ELSE}DsgnIntf, DsgnWnds{$ENDIF};

type
{$IFDEF DELPHI6}
  TMyDesignerSelections = class(TDesignerSelections);
{$ENDIF}

  TdxMVFormDesigner =
    {$IFDEF DELPHI6}IDesigner{$ELSE}{$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}{$ENDIF};
  TdxMVSelectionList =
    {$IFDEF DELPHI6}TMyDesignerSelections{$ELSE}{$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF}{$ENDIF};

  TdxMasterViewDesigner = class;

  TdxMVRealDesigner = class(TdxMVDesigner)
  private
    FControls: TList;
    FDesigners: TList;
  protected
    function DesignerFromControl(Control: TdxMasterView): TdxMasterViewDesigner;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Changed(Control: TdxMasterView; RefreshCodes: TdxMVDesignerRefreshCodes); override;
    procedure Hide(Control: TdxMasterView); override;
    function UniqueName(Control: TdxMasterView; const BaseName: string): string; override;
    procedure Show(Control: TdxMasterView; ADesigner: TCurDesigner); override;

    procedure Register(Control: TdxMasterView; Designer: TdxMasterViewDesigner);
    procedure Unregister(Designer: TdxMasterViewDesigner);
  end;

  TdxMasterViewDesigner = class(TDesignWindow)
    pcMain: TPageControl;
    pageMain: TTabSheet;
    pageStyles: TTabSheet;
    splMain: TSplitter;
    pnlLevels: TPanel;
    pnlLevelButtons: TPanel;
    btnLevelAdd: TButton;
    btnLevelDelete: TButton;
    pnlLevelHeader: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    Panel7: TPanel;
    tvLevels: TTreeView;
    Panel5: TPanel;
    Panel4: TPanel;
    Panel11: TPanel;
    Bevel1: TBevel;
    Panel15: TPanel;
    pcPages: TPageControl;
    tshColumns: TTabSheet;
    pnlColumnButtons: TPanel;
    btnColumnAdd: TButton;
    btnColumnDelete: TButton;
    btnColumnAddAll: TButton;
    btnColumnMoveUp: TButton;
    btnColumnRestoreDefaults: TButton;
    btnColumnRestoreWidth: TButton;
    btnColumnMoveDown: TButton;
    btnColumnChangeType: TButton;
    lbColumns: TListBox;
    Panel1: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    tshData: TTabSheet;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel12: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    lblDataSource: TLabel;
    lblID: TLabel;
    lblMasterKey: TLabel;
    lblDetailKey: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    cmbDataSource: TComboBox;
    cmbID: TComboBox;
    cmbMasterKey: TComboBox;
    cmbDetailKey: TComboBox;
    lblMasterDataSource: TLabel;
    pnlMasterDataSource: TPanel;
    Panel2: TPanel;
    lbStyles: TListBox;
    pnlStyleButtons: TPanel;
    btnStyleAdd: TButton;
    btnStyleDelete: TButton;
    btnStyleMoveUp: TButton;
    btnStyleMoveDown: TButton;
    Panel3: TPanel;
    Bevel3: TBevel;
    Label2: TLabel;
    Panel8: TPanel;
    pnlPreviews: TPanel;
    pnlMainPreview: TPanel;
    pnlAnotherPreview: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    bvlMainPreview: TBevel;
    bvlAnotherPreview: TBevel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure pcMainChanging(Sender: TObject; var AllowChange: Boolean);
    {procedure splMainCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);}
    procedure splMainMoved(Sender: TObject);
    procedure tvLevelsChange(Sender: TObject; Node: TTreeNode);
    procedure tvLevelsEnter(Sender: TObject);
    procedure tvLevelsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnLevelAddClick(Sender: TObject);
    procedure btnLevelDeleteClick(Sender: TObject);
    procedure lbColumnsClick(Sender: TObject);
    procedure lbColumnsEnter(Sender: TObject);
    procedure lbColumnsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnColumnAddClick(Sender: TObject);
    procedure btnColumnDeleteClick(Sender: TObject);
    procedure btnColumnAddAllClick(Sender: TObject);
    procedure btnColumnChangeTypeClick(Sender: TObject);
    procedure btnColumnMoveUpClick(Sender: TObject);
    procedure btnColumnMoveDownClick(Sender: TObject);
    procedure btnColumnRestoreDefaultsClick(Sender: TObject);
    procedure btnColumnRestoreWidthClick(Sender: TObject);
    procedure cmbMasterKeyClick(Sender: TObject);
    procedure cmbMasterKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbDataSourceChange(Sender: TObject);
    procedure cmbIDClick(Sender: TObject);
    procedure cmbIDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbDetailKeyClick(Sender: TObject);
    procedure cmbDetailKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbStylesClick(Sender: TObject);
    procedure lbStylesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnStyleAddClick(Sender: TObject);
    procedure btnStyleDeleteClick(Sender: TObject);
    procedure btnStyleMoveUpClick(Sender: TObject);
    procedure btnStyleMoveDownClick(Sender: TObject);
  private
    DontRefreshData: Boolean;
    FLevelsChangeLockCount: Integer;
    FMinSize: TPoint;
    FModifyLockCount: Integer;
    FSelectingComponents: Boolean;
    pageMainLastFocusedControl, pageStylesLastFocusedControl: TWinControl;
    TempList: TStrings;

    function GetSelectedColumn: TdxMasterViewColumn;
    function GetSelectedColumns: TdxMVSelectionList;
    function GetSelectedLevel: TdxMasterViewLevel;
    function GetSelectedStyle: TdxMasterViewStyle;
    function GetSelectedStyles: TdxMVSelectionList;
    procedure SetSelectedColumn(Value: TdxMasterViewColumn);
    procedure SetSelectedColumns(Value: TdxMVSelectionList);
    procedure SetSelectedStyle(Value: TdxMasterViewStyle);
    procedure SetSelectedStyles(Value: TdxMVSelectionList);
    procedure SetSelectedLevel(Value: TdxMasterViewLevel);

    procedure GetComponentNamesProc(const S: string);
    procedure GetDataSourceNames(List: TStrings);
    function GetNearestNonselectedObject(ListBox: TListBox): TObject;
    function GetObjectIndex(AObject: TPersistent): Integer;
    procedure SetObjectIndex(AObject: TPersistent; AIndex: Integer);
    function IsBrokenList(List: TdxMVSelectionList): Boolean;
    function GetSelectedObject(ListBox: TListBox): TObject;
    function GetSelectedObjects(ListBox: TListBox): TdxMVSelectionList;
    procedure SetSelectedObjects(ListBox: TListBox; Value: TdxMVSelectionList);
    function NodeFromLevel(Level: TdxMasterViewLevel): TTreeNode;

    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Modified;
    procedure MoveDown(ListBox: TListBox);
    procedure MoveUp(ListBox: TListBox);
    procedure SelectComponent(Component: TPersistent);
    procedure SelectComponents(List: TdxMVSelectionList);
    function SelectedComponent: TPersistent;
    function SelectedComponents: TdxMVSelectionList;
    function UniqueName(Component: TComponent): string; override;
  public
    AllowSelect: Boolean;
    Control: TdxMasterView;
    constructor CreateEx(AControl: TdxMasterView; ADesigner: TdxMVFormDesigner);
    destructor Destroy; override;
  {$IFDEF DELPHI6}
    procedure ItemsModified(const Designer: IDesigner); override;
  {$ELSE}
    procedure FormModified; override;
  {$ENDIF}  
    //function GetEditState: TEditState; override;
    procedure BeginLevelsChange;
    procedure EndLevelsChange;
    procedure BeginModify;
    procedure EndModify;
    procedure RefreshCaption;
    procedure RefreshColumns;
    procedure RefreshData;
    procedure RefreshEnables;
    procedure RefreshLevels;
    procedure RefreshPreviews;
    procedure RefreshStyles;
  {$IFDEF DELPHI6}
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections); override;
  {$ELSE}
    procedure SelectionChanged(ASelection: TdxMVSelectionList); override;
  {$ENDIF}  
    property SelectedColumn: TdxMasterViewColumn read GetSelectedColumn write SetSelectedColumn;
    property SelectedColumns: TdxMVSelectionList read GetSelectedColumns write SetSelectedColumns;
    property SelectedLevel: TdxMasterViewLevel read GetSelectedLevel write SetSelectedLevel;
    property SelectedStyle: TdxMasterViewStyle read GetSelectedStyle write SetSelectedStyle;
    property SelectedStyles: TdxMVSelectionList read GetSelectedStyles write SetSelectedStyles;
  end;

implementation

{$R *.DFM}

uses
  TypInfo, CommCtrl, DB, dxMasterViewColumnClassEditor;

var
  PrevBounds: TRect;

  pnlLevelsPrevHeight: Integer;

{ TdxMVRealDesigner }

constructor TdxMVRealDesigner.Create;
begin
  inherited;
  FControls := TList.Create;
  FDesigners := TList.Create;
end;

destructor TdxMVRealDesigner.Destroy;
begin
  FDesigners.Free;
  FControls.Free;
  inherited;
end;

function TdxMVRealDesigner.DesignerFromControl(Control: TdxMasterView): TdxMasterViewDesigner;
var
  I: Integer;
begin
  I := FControls.IndexOf(Control);
  if I = -1 then Result := nil
  else Result := FDesigners[I];
end;

procedure TdxMVRealDesigner.Changed(Control: TdxMasterView; RefreshCodes: TdxMVDesignerRefreshCodes);
var
  Designer: TdxMasterViewDesigner;
begin
  Designer := DesignerFromControl(Control);
  if Designer <> nil then
  begin
    if rcName in RefreshCodes then Designer.RefreshCaption;
    if rcLevels in RefreshCodes then Designer.RefreshLevels;
    if rcColumns in RefreshCodes then Designer.RefreshColumns;
    if rcData in RefreshCodes then Designer.RefreshData;
    if rcStyles in RefreshCodes then Designer.RefreshStyles;
    if rcEnables in RefreshCodes then Designer.RefreshEnables;
  end;
end;

procedure TdxMVRealDesigner.Hide(Control: TdxMasterView);
var
  Designer: TdxMasterViewDesigner;
begin
  Designer := DesignerFromControl(Control);
  if Designer <> nil then Designer.Free;//Release;
end;

function TdxMVRealDesigner.UniqueName(Control: TdxMasterView;
  const BaseName: string): string;
{var
  I: Integer;}
begin
  Result := DesignerFromControl(Control).Designer.UniqueName(BaseName);
{  for I := 1 to MaxInt do
  begin
    Result := BaseName + IntToStr(I);
    if Control.Owner.FindComponent(Result) = nil then Exit;
  end;}
end;

procedure TdxMVRealDesigner.Show(Control: TdxMasterView; ADesigner: TCurDesigner);
var
  Designer: TdxMasterViewDesigner;
begin
  Designer := DesignerFromControl(Control);
  if Designer = nil then
    TdxMasterViewDesigner.CreateEx(Control, TdxMVFormDesigner(ADesigner)).Show
  else
    Designer.BringToFront;
end;

procedure TdxMVRealDesigner.Register(Control: TdxMasterView; Designer: TdxMasterViewDesigner);
begin
  if DesignerFromControl(Control) <> nil then Exit;
  FControls.Add(Control);
  FDesigners.Add(Designer);
end;

procedure TdxMVRealDesigner.Unregister(Designer: TdxMasterViewDesigner);
var
  I: Integer;
begin
  I := FDesigners.Remove(Designer);
  if I <> -1 then FControls.Delete(I);
end;

{ TLevelsTreeView }

type
  TLevelsTreeView = class(TTreeView)
  private
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
  end;

procedure TLevelsTreeView.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
end;

{ TdxMasterViewDesigner }

constructor TdxMasterViewDesigner.CreateEx(AControl: TdxMasterView;
  ADesigner: TdxMVFormDesigner);
begin
  Control := AControl;
  inherited Create(nil);
  Designer := ADesigner;
  TdxMVRealDesigner(dxMVDesigner).Register(Control, Self);
  AllowSelect := True;
  FMinSize := Point(Width, Height);
  if IsRectEmpty(PrevBounds) then
  begin
    SetBounds(250, Top, 365, 470);
    pnlLevels.Height := pnlLevels.Height + tvLevels.Height;
  end
  else
  begin
    BoundsRect := PrevBounds;
    pnlLevels.Height := pnlLevelsPrevHeight;
  end;

  tvLevels.Free;
  tvLevels := TLevelsTreeView.Create(Self);
  with tvLevels do
  begin
    Align := alClient;
    HideSelection := False;
    ReadOnly := True;
    ShowButtons := False;
    ShowRoot := False;
    OnChange := tvLevelsChange;
    OnEnter := tvLevelsEnter;
    OnKeyDown := tvLevelsKeyDown;
    Parent := pnlLevels;
  end;

  with splMain do
  begin
  {$IFDEF DELPHI5}
    AutoSnap := False;
  {$ENDIF}  
    Beveled := False;
    MinSize :=
      pnlLevelHeader.Height + btnLevelDelete.BoundsRect.Bottom + 2;
  end;
  lbColumns.ItemIndex := -1;
  RefreshCaption;
  RefreshLevels;
  RefreshStyles;
  SelectedLevel := Control.Levels;
end;

destructor TdxMasterViewDesigner.Destroy;
begin
  Destroying;
  if not (csDestroying in Control.ComponentState) then
    SelectComponent(Control);
  TdxMVRealDesigner(dxMVDesigner).Unregister(Self);
  PrevBounds := BoundsRect;
  pnlLevelsPrevHeight := pnlLevels.Height;
  inherited;
end;

function TdxMasterViewDesigner.GetSelectedColumn: TdxMasterViewColumn;
begin
  Result := TdxMasterViewColumn(GetSelectedObject(lbColumns));
end;

function TdxMasterViewDesigner.GetSelectedColumns: TdxMVSelectionList;
begin
  Result := GetSelectedObjects(lbColumns);
end;

function TdxMasterViewDesigner.GetSelectedLevel: TdxMasterViewLevel;
begin
  with tvLevels do
    if Selected = nil then
      Result := nil
    else
      Result := Selected.Data;
end;

function TdxMasterViewDesigner.GetSelectedStyle: TdxMasterViewStyle;
begin
  Result := TdxMasterViewStyle(GetSelectedObject(lbStyles));
end;

function TdxMasterViewDesigner.GetSelectedStyles: TdxMVSelectionList;
begin
  Result := GetSelectedObjects(lbStyles);
end;

procedure TdxMasterViewDesigner.SetSelectedColumn(Value: TdxMasterViewColumn);
var
  List: TdxMVSelectionList;
begin
  List := TdxMVSelectionList.Create;
  if Value <> nil then List.Add(Value);
  SelectedColumns := List;
end;

procedure TdxMasterViewDesigner.SetSelectedColumns(Value: TdxMVSelectionList);
begin
  SetSelectedObjects(lbColumns, Value);
  RefreshEnables;
end;

procedure TdxMasterViewDesigner.SetSelectedLevel(Value: TdxMasterViewLevel);
begin
  if SelectedLevel <> Value then
    tvLevels.Selected := NodeFromLevel(Value);
end;

procedure TdxMasterViewDesigner.SetSelectedStyle(Value: TdxMasterViewStyle);
var
  List: TdxMVSelectionList;
begin
  List := TdxMVSelectionList.Create;
  if Value <> nil then List.Add(Value);
  SelectedStyles := List;
end;

procedure TdxMasterViewDesigner.SetSelectedStyles(Value: TdxMVSelectionList);
begin
  SetSelectedObjects(lbStyles, Value);
  RefreshPreviews;
  RefreshEnables;
end;

procedure TdxMasterViewDesigner.GetComponentNamesProc(const S: string);
begin
  TempList.Add(S);
end;

procedure TdxMasterViewDesigner.GetDataSourceNames(List: TStrings);
begin
  List.Clear;
  List.Add('(none)');
  TempList := List;
  try
    Designer.GetComponentNames(GetTypeData(PTypeInfo(TDataSource.ClassInfo)),
      GetComponentNamesProc);
  finally
    TempList := nil;
  end;
end;

function TdxMasterViewDesigner.GetNearestNonselectedObject(ListBox: TListBox): TObject;
var
  I: Integer;
begin
  with ListBox do
    if ItemIndex = -1 then
      Result := nil
    else
      if Selected[ItemIndex] then
      begin
        Result := nil;
        for I := ItemIndex + 1 to Items.Count - 1 do
          if not Selected[I] then
          begin
            Result := Items.Objects[I];
            Break;
          end;
        if Result = nil then
          for I := ItemIndex - 1 downto 0 do
            if not Selected[I] then
            begin
              Result := Items.Objects[I];
              Break;
            end;
      end
      else
        Result := Items.Objects[ItemIndex];
end;

function TdxMasterViewDesigner.GetObjectIndex(AObject: TPersistent): Integer;
begin
  if AObject is TdxMasterViewStyle then
    Result := TdxMasterViewStyle(AObject).Index
  else
    if AObject is TdxMasterViewColumn then
      Result := TdxMasterViewColumn(AObject).Index
    else
      Result := -1;
end;

procedure TdxMasterViewDesigner.SetObjectIndex(AObject: TPersistent; AIndex: Integer);
begin
  if AObject is TdxMasterViewStyle then
    TdxMasterViewStyle(AObject).Index := AIndex
  else
    if AObject is TdxMasterViewColumn then
      TdxMasterViewColumn(AObject).Index := AIndex;
end;

function TdxMasterViewDesigner.IsBrokenList(List: TdxMVSelectionList): Boolean;
var
  BaseIndex, I: Integer;
begin
  Result := False;
  if List.Count <> 0 then
  begin
    BaseIndex := GetObjectIndex(List[0]);
    for I := 1 to List.Count - 1 do
    begin
      Result := GetObjectIndex(List[I]) <> BaseIndex + I;
      if Result then Break;
    end;
  end;
end;

function TdxMasterViewDesigner.GetSelectedObject(ListBox: TListBox): TObject;
var
  I: Integer;
begin
  Result := nil;
  with ListBox do
    if SelCount = 0 then Exit
    else
      for I := 0 to Items.Count - 1 do
        if Selected[I] then
        begin
          Result := Items.Objects[I];
          Break;
        end;
end;

function TdxMasterViewDesigner.GetSelectedObjects(ListBox: TListBox): TdxMVSelectionList;
var
  I: Integer;
begin
  Result := TdxMVSelectionList.Create;
  with ListBox do
    for I := 0 to Items.Count - 1 do
      if Selected[I] then
        Result.Add(TPersistent(Items.Objects[I]));
end;

procedure TdxMasterViewDesigner.SetSelectedObjects(ListBox: TListBox;
  Value: TdxMVSelectionList);
var
  I, J: Integer;
begin
  try
    with ListBox do
    begin
      Items.BeginUpdate;
      try
        for I := 0 to Items.Count - 1 do
          Selected[I] := False;
        if Value <> nil then
          for I := 0 to Value.Count - 1 do
          begin
            J := Items.IndexOfObject(Value[I]);
            if J <> -1 then
            begin
              Selected[J] := True;
              ItemIndex := J;
            end;
          end;
      finally
        Items.EndUpdate;
      end;
    end;
  finally
    if Value <> nil then Value.Free;
  end;
end;

function TdxMasterViewDesigner.NodeFromLevel(Level: TdxMasterViewLevel): TTreeNode;
var
  I: Integer;
begin
  with tvLevels do
    for I := 0 to Items.Count - 1 do
    begin
      Result := Items[I];
      if Result.Data = Level then Exit;
    end;
  Result := nil;
end;

procedure TdxMasterViewDesigner.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  inherited;
  with Message.MinMaxInfo^ do
    ptMinTrackSize := FMinSize;
end;

procedure TdxMasterViewDesigner.WMSize(var Message: TWMSize);
var
  FreeSpace: Integer;
begin
  inherited;
  if Designer = nil{fsCreating in FormState} then Exit;
  FreeSpace :=
    pnlColumnButtons.Height - btnColumnRestoreWidth.BoundsRect.Bottom;
  if FreeSpace < 0 then
    pnlLevels.Height := pnlLevels.Height + FreeSpace;
  with pnlPreviews do
    Left := (Parent.Width + Panel21.Width - Width) div 2 - Panel21.Width;
end;

procedure TdxMasterViewDesigner.CreateParams(var Params: TCreateParams);
begin
  inherited;
{  with Params do
    WndParent := Control.Handle;}
{$IFDEF DELPHI9}
  Params.WndParent := Application.MainForm.Handle;
{$ENDIF}
end;

procedure TdxMasterViewDesigner.Modified;
begin
  Designer.Modified;
end;

procedure TdxMasterViewDesigner.MoveDown(ListBox: TListBox);
var
  List: TdxMVSelectionList;
  AIndex, I: Integer;
begin
  if ListBox = lbColumns then
    List := SelectedColumns
  else
    List := SelectedStyles;
  try
    ListBox.Items.BeginUpdate;
    try
      AIndex := GetObjectIndex(List[List.Count - 1]);
      if AIndex < ListBox.Items.Count - 1 then
      begin
        Inc(AIndex);
        SetObjectIndex(List[List.Count - 1], AIndex);
      end;
      for I := List.Count - 2 downto 0 do
      begin
        Dec(AIndex);
        SetObjectIndex(List[I], AIndex);
      end;  
      if ListBox = lbColumns then
        RefreshColumns
      else
        RefreshStyles;
    finally
      ListBox.Items.EndUpdate;
    end;
  finally
    List.Free;
    Modified;
  end;
end;  

procedure TdxMasterViewDesigner.MoveUp(ListBox: TListBox);
var
  List: TdxMVSelectionList;
  AIndex, I: Integer;
begin
  if ListBox = lbColumns then
    List := SelectedColumns
  else
    List := SelectedStyles;
  try
    ListBox.Items.BeginUpdate;
    try
      AIndex := GetObjectIndex(List[0]);
      if AIndex > 0 then
      begin
        Dec(AIndex);
        SetObjectIndex(List[0], AIndex);
      end;
      for I := 1 to List.Count - 1 do
      begin
        Inc(AIndex);
        SetObjectIndex(List[I], AIndex);
      end;
      if ListBox = lbColumns then
        RefreshColumns
      else
        RefreshStyles;
    finally
      ListBox.Items.EndUpdate;
    end;
  finally
    List.Free;
    Modified;
  end;
end;

procedure TdxMasterViewDesigner.SelectComponent(Component: TPersistent);
var
  List: TdxMVSelectionList;
begin
  List := TdxMVSelectionList.Create;
  List.Add(Component);
  SelectComponents(List);
end;

procedure TdxMasterViewDesigner.SelectComponents(List: TdxMVSelectionList);
begin
  if AllowSelect then
  begin
    FSelectingComponents := True;
    try
      SetSelection(List);
    finally
      FSelectingComponents := False;
    end;
  end
  else
    List.Free;
end;

function TdxMasterViewDesigner.SelectedComponent: TPersistent;
var
  AList: TdxMVSelectionList;
begin
  AList := SelectedComponents;
  try
    if AList.Count = 0 then
      Result := nil
    else
      Result := AList[0];
  finally
    AList.Free;
  end;
end;

function TdxMasterViewDesigner.SelectedComponents: TdxMVSelectionList;
begin
  Result := TdxMVSelectionList.Create;
  Designer.GetSelections(Result);
end;

function TdxMasterViewDesigner.UniqueName(Component: TComponent): string;
begin
  if Component is TdxMasterViewStyle then
    Result := Control.Name + 'Style'
  else
    if Component is TdxMasterViewColumn then
      Result := TdxMasterViewColumn(Component).Level.Name + 'Column'
    else
      if Component is TdxMasterViewLevel then
        Result := Control.Name + 'Level'
      else
      begin
        Result := Component.ClassName;
        Delete(Result, 1, 1);
      end;
  Result := dxMVDesigner.UniqueName(Control, Result)
end;

{$IFDEF DELPHI6}
procedure TdxMasterViewDesigner.ItemsModified(const Designer: IDesigner);
{$ELSE}
procedure TdxMasterViewDesigner.FormModified;
{$ENDIF}
begin
  if FModifyLockCount <> 0 then Exit;
  if DontRefreshData then
    DontRefreshData := False
  else
    RefreshData;
  RefreshPreviews;
  RefreshEnables;
end;

procedure TdxMasterViewDesigner.BeginLevelsChange;
begin
  Inc(FLevelsChangeLockCount);
end;

procedure TdxMasterViewDesigner.EndLevelsChange;
begin
  if FLevelsChangeLockCount > 0 then
  begin
    Dec(FLevelsChangeLockCount);
    if FLevelsChangeLockCount = 0 then
      tvLevelsChange(nil, nil);
  end;
end;

procedure TdxMasterViewDesigner.BeginModify;
begin
  Inc(FModifyLockCount);
end;

procedure TdxMasterViewDesigner.EndModify;
begin
  if FModifyLockCount > 0 then
  begin
    Dec(FModifyLockCount);
    if FModifyLockCount = 0 then
    {$IFDEF DELPHI6}
      ItemsModified(Designer);
    {$ELSE}
      FormModified;
    {$ENDIF}
  end;
end;

procedure TdxMasterViewDesigner.RefreshCaption;
begin
  Caption := 'Designer - ' + Control.Name;
end;

procedure TdxMasterViewDesigner.RefreshColumns;
var
  AColumns: TdxMVSelectionList;
  AFocusedColumn: TObject;
  ATopIndex, I: Integer;
begin
  AColumns := SelectedColumns;
  with lbColumns do
  begin
    ATopIndex := TopIndex;
    if (ItemIndex = -1) or (Items.Count = 0) then
      AFocusedColumn := nil
    else
      AFocusedColumn := Items.Objects[ItemIndex];
    Items.BeginUpdate;
    try
      Clear;
      with SelectedLevel do
        for I := 0 to ColumnCount - 1 do
          lbColumns.Items.AddObject(Columns[I].Name, Columns[I]);
    finally
      TopIndex := ATopIndex;
      Items.EndUpdate;
      SelectedColumns := AColumns;
      if AFocusedColumn <> nil then
      begin
        I := Items.IndexOfObject(AFocusedColumn);
        if I <> -1 then ItemIndex := I;
      end;
    end;
  end;
end;

procedure TdxMasterViewDesigner.RefreshData;
var
  Level: TdxMasterViewLevel;
  S: string;
  List: TStringList;
  I: Integer;
  AEnabled: Boolean;
begin
  Level := SelectedLevel;
  if Level.Parent = nil then
  begin
    for I := 0 to tshData.ControlCount - 1 do
      with tshData.Controls[I] do
      begin
        if ClassType <> TLabel then SetTextBuf('');
        Enabled := False;
      end;
    cmbDataSource.ItemIndex := -1;  
    Exit;
  end
  else
  begin
    lblDataSource.Enabled := True;
    cmbDataSource.Enabled := True;
    lblID.Enabled := True;
    cmbID.Enabled := True;
  end;

  if Level.Parent.DataSet = nil then
    cmbMasterKey.Items.Clear
  else
    try
      Level.Parent.DataSet.GetFieldNames(cmbMasterKey.Items);
    except
      cmbMasterKey.Items.Clear;
    end;
  if Level.Parent.DataSource = nil then
    S := '(none)'
  else
    S := Designer.GetComponentName(Level.Parent.DataSource);
  pnlMasterDataSource.Caption := ' ' + S;
  cmbMasterKey.Text := Level.MasterKey;

  List := TStringList.Create;
  try
    GetDataSourceNames(List);
    cmbDataSource.Items := List;
    if Level.DataSet = nil then
      List.Clear
    else
      try
        Level.DataSet.GetFieldNames(List);
      except
        List.Clear;
      end;
    cmbID.Items := List;
    cmbDetailKey.Items := List;
  finally
    List.Free;
  end;
  if Level.DataSource = nil then
    I := 0
  else
    I := cmbDataSource.Items.IndexOf(Designer.GetComponentName(Level.DataSource));
  cmbDataSource.ItemIndex := I;
  cmbID.Text := Level.ID;
  cmbDetailKey.Text := Level.DetailKey;

  AEnabled := not Level.IsTop;
  lblMasterDataSource.Enabled := AEnabled;
  pnlMasterDataSource.Enabled := AEnabled;
  lblMasterKey.Enabled := AEnabled;
  cmbMasterKey.Enabled := AEnabled or (cmbMasterKey.Text <> '');
  lblDetailKey.Enabled := AEnabled;
  cmbDetailKey.Enabled := AEnabled or (cmbDetailKey.Text <> '');
end;

procedure TdxMasterViewDesigner.RefreshEnables;
var
  AEnabled: Boolean;
  List: TdxMVSelectionList;

  function CanAddOrDelete: Boolean;
  begin
  {$IFDEF DELPHI5}
    Result := not (csInline in Control.Owner.ComponentState);
  {$ELSE}
    Result := True;
  {$ENDIF}
  end;

  function CanMoveUp: Boolean;
  begin
    Result := (GetObjectIndex(List[0]) <> 0) or IsBrokenList(List);
  end;

  function CanMoveDown: Boolean;
  var
    ACount: Integer;
  begin
    if List[0] is TdxMasterViewColumn then
      ACount := lbColumns.Items.Count
    else
      ACount := lbStyles.Items.Count;
    Result :=
      (GetObjectIndex(List[List.Count - 1]) <> ACount - 1) or IsBrokenList(List);
  end;

  function CanRestoreDefaults: Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to List.Count - 1 do
    begin
      Result := TdxMasterViewColumn(List[I]).AssignedValues <> [];
      if Result then Break;
    end;
  end;

  function CanRestoreWidth: Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to List.Count - 1 do
    begin
      Result := cvWidth in TdxMasterViewColumn(List[I]).AssignedValues;
      if Result then Break;
    end;
  end;

begin
  // main page
  AEnabled :=
    CanAddOrDelete and (SelectedLevel <> nil) and (SelectedLevel.Parent <> nil);

  btnLevelAdd.Enabled := CanAddOrDelete;
  btnLevelDelete.Enabled := AEnabled;

  btnColumnAdd.Enabled := AEnabled;
  with SelectedLevel do
    btnColumnAddAll.Enabled := AEnabled and (DataSet <> nil) and
      ((DataSet.State <> dsInactive) or (DataSet.FieldCount <> 0));
  List := SelectedColumns;
  try
    AEnabled := List.Count <> 0;
    btnColumnDelete.Enabled := AEnabled and CanAddOrDelete;
    btnColumnChangeType.Enabled := AEnabled and CanAddOrDelete;
    btnColumnMoveUp.Enabled := AEnabled and CanAddOrDelete and CanMoveUp;
    btnColumnMoveDown.Enabled := AEnabled and CanAddOrDelete and CanMoveDown;
    btnColumnRestoreDefaults.Enabled := AEnabled and CanRestoreDefaults;
    btnColumnRestoreWidth.Enabled := AEnabled and CanRestoreWidth;
  finally
    List.Free;
  end;
  // styles page
  List := SelectedStyles;
  try
    AEnabled := (List.Count <> 0) and CanAddOrDelete;
    btnStyleAdd.Enabled := CanAddOrDelete;
    btnStyleDelete.Enabled := AEnabled;
    btnStyleMoveUp.Enabled := AEnabled and CanMoveUp;
    btnStyleMoveDown.Enabled := AEnabled and CanMoveDown;
  finally
    List.Free;
  end;
end;

procedure TdxMasterViewDesigner.RefreshLevels;
var
  Level: TdxMasterViewLevel;
  S: string;

  procedure AddItems(Node: TTreeNode; Level: TdxMasterViewLevel);
  var
    I: Integer;
  begin
    for I := 0 to Level.Count - 1 do
    begin
      with Level[I] do
      begin
        S := Name;
        if Caption <> '' then S := S + '     [' + Caption + ']';
      end;
      AddItems(tvLevels.Items.AddChildObject(Node, S, Level[I]), Level[I]);
    end;
    Node.Expanded := True;
  end;

begin
  Level := SelectedLevel;
  with tvLevels do
  begin
    Items.BeginUpdate;
    try
      Items.Clear;
      Items.AddObject(nil, '<Root>', Control.Levels);
      AddItems(Items[0], Control.Levels);
    finally
      Items.EndUpdate;
      SelectedLevel := Level;
      if Selected <> nil then Selected.MakeVisible;
      RefreshEnables;
    end;
  end;
end;

procedure TdxMasterViewDesigner.RefreshPreviews;
var
  AStyle: TdxMasterViewStyle;
begin
  AStyle := SelectedStyle;
  with SelectedStyles do
    try
      if Count > 1 then AStyle := nil;
    finally  
      Free;
    end;
  with pnlMainPreview do
  begin
    if (AStyle <> nil) and (svColor in AStyle.AssignedValues) then
      Color := AStyle.Color
    else
      ParentColor := True;
    if (AStyle <> nil) and (svFont in AStyle.AssignedValues) then
      Font := AStyle.Font
    else
      Font.Color := Color;
  end;
  bvlMainPreview.Visible :=
    (AStyle <> nil) and ([svColor, svFont] * AStyle.AssignedValues <> []);
  with pnlAnotherPreview do
  begin
    if (AStyle <> nil) and (svAnotherColor in AStyle.AssignedValues) then
      Color := AStyle.AnotherColor
    else
      ParentColor := True;
    if not ParentColor and
      (AStyle <> nil) and (svFont in AStyle.AssignedValues) then
      Font := AStyle.Font
    else
      Font.Color := Color;
    bvlAnotherPreview.Visible := not ParentColor;
  end;
end;

procedure TdxMasterViewDesigner.RefreshStyles;
var
  AStyles: TdxMVSelectionList;
  ATopIndex, I: Integer;
  AFocusedStyle: TObject;
  AStyle: TdxMasterViewStyle;
begin
  AStyles := SelectedStyles;
  with lbStyles do
  begin
    ATopIndex := TopIndex;
    if (ItemIndex = -1) or (Items.Count = 0) then
      AFocusedStyle := nil
    else
      AFocusedStyle := Items.Objects[ItemIndex];
    Items.BeginUpdate;
    try
      Items.Clear;
      for I := 0 to Control.StyleCount - 1 do
      begin
        AStyle := Control.Styles[I];
        Items.AddObject(AStyle.Name, AStyle);
      end;
    finally
      TopIndex := ATopIndex;
      Items.EndUpdate;
      SelectedStyles := AStyles;
      if AFocusedStyle <> nil then
      begin
        I := Items.IndexOfObject(AFocusedStyle);
        if I <> -1 then ItemIndex := I;
      end;
    end;
  end;
end;

{$IFDEF DELPHI6}
procedure TdxMasterViewDesigner.SelectionChanged(const ADesigner: IDesigner;
  const ASelection: IDesignerSelections);
{$ELSE}
procedure TdxMasterViewDesigner.SelectionChanged(ASelection: TdxMVSelectionList);
{$ENDIF}
var
  ASelectedComponent: TPersistent;
  SelectStylesPage: Boolean;
{$IFDEF DELPHI9}
  AList: TdxMVSelectionList;
{$ENDIF}
begin
  if not (csDestroying in ComponentState) and not FSelectingComponents then
  begin
    SelectStylesPage := False;
    ASelectedComponent := SelectedComponent;
    if ASelectedComponent is TdxMasterViewStyle then
    begin
      SelectedStyles := SelectedComponents;
      SelectStylesPage := True;
    end
    else
      if ASelectedComponent is TdxMasterViewColumn then
      begin
        SelectedLevel := TdxMasterViewColumn(ASelectedComponent).Level;
        SelectedColumns := SelectedComponents;
      end
      else
        if ASelectedComponent is TdxMasterViewLevel then
          if SelectedLevel = ASelectedComponent then
            SelectedColumn := nil
          else
            SelectedLevel := TdxMasterViewLevel(ASelectedComponent)
        else
          if ASelectedComponent is TdxMasterView then
          begin
          {$IFDEF DELPHI9}
            if pcMain.ActivePage = pageStyles then
            begin
              AList := SelectedStyles;
              try
                if AList.Count = 0 then Exit;
              finally
                AList.Free;
              end;
            end;
          {$ENDIF}
            SelectedLevel := Control.Levels;
            SelectedStyles := nil;
          end
          else
            Exit;
    with pcMain do
      ActivePage := Pages[Byte(SelectStylesPage)];
  end;
end;

procedure TdxMasterViewDesigner.FormActivate(Sender: TObject);
var
  List: TdxMVSelectionList;
begin
  if pcMain.ActivePage = pageMain then
    if ActiveControl = tvLevels then
      tvLevelsEnter(nil)
    else
      lbColumnsEnter(nil)
  else
    if pcMain.ActivePage = pageStyles then
    begin
      List := SelectedStyles;
      if List.Count = 0 then
      begin
        List.Free;
        SelectComponent(Control);
      end
      else
        SelectComponents(List);
    end;
end;

procedure TdxMasterViewDesigner.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TdxMasterViewDesigner.FormDeactivate(Sender: TObject);
begin
  if ActiveControl = cmbMasterKey then cmbMasterKeyClick(nil);
  if ActiveControl = cmbID then cmbIDClick(nil);
  if ActiveControl = cmbDetailKey then cmbDetailKeyClick(nil);
end;

procedure TdxMasterViewDesigner.pcMainChange(Sender: TObject);
begin
  FormActivate(nil);
  case pcMain.ActivePage.PageIndex of
    0: if pageMainLastFocusedControl <> nil then
         ActiveControl := pageMainLastFocusedControl;
    1: if pageStylesLastFocusedControl <> nil then
         ActiveControl := pageStylesLastFocusedControl;
  end;
end;

procedure TdxMasterViewDesigner.pcMainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  case pcMain.ActivePage.PageIndex of
    0: pageMainLastFocusedControl := ActiveControl;
    1: pageStylesLastFocusedControl := ActiveControl;
  end;
end;
{
procedure TdxMasterViewDesigner.splMainCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
var
  FreeSpace: Integer;
begin
  FreeSpace :=
    NewSize - pnlLevelHeader.Height - btnLevelDelete.BoundsRect.Bottom - 2;
  if FreeSpace < 0 then Accept := False;
end;
}
procedure TdxMasterViewDesigner.splMainMoved(Sender: TObject);
var
  FreeSpace: Integer;
begin
  FreeSpace :=
    pnlColumnButtons.Height - btnColumnRestoreWidth.BoundsRect.Bottom;
  if FreeSpace < 0 then
    Height := Height - FreeSpace;
end;

procedure TdxMasterViewDesigner.tvLevelsChange(Sender: TObject; Node: TTreeNode);
begin
  if FLevelsChangeLockCount <> 0 then Exit;
  if SelectedLevel = Control.Levels then
    SelectComponent(Control)
  else
    SelectComponent(tvLevels.Selected.Data);
  RefreshColumns;
  RefreshData;
  RefreshEnables;
end;

procedure TdxMasterViewDesigner.tvLevelsEnter(Sender: TObject);
begin
  tvLevelsChange(nil, nil);
end;

procedure TdxMasterViewDesigner.tvLevelsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      if (Shift = []) and btnLevelAdd.Enabled then btnLevelAdd.Click;
    VK_DELETE:
      if (Shift = []) and btnLevelDelete.Enabled then btnLevelDelete.Click;
    VK_ADD, VK_SUBTRACT:
      Key := 0;
    VK_LEFT:
      if tvLevels.Selected.Expanded then Key := 0;
  end;
end;

procedure TdxMasterViewDesigner.btnLevelAddClick(Sender: TObject);
var
  Level: TdxMasterViewLevel;
begin
  Level := SelectedLevel.Add;
  if Level <> nil then
  begin
    BeginLevelsChange;
    try
      Level.Name := UniqueName(Level);
    finally
      SelectedLevel := Level;
      EndLevelsChange;
      Modified;
    end;  
  end;
end;

procedure TdxMasterViewDesigner.btnLevelDeleteClick(Sender: TObject);
var
  Level: TdxMasterViewLevel;
begin
  BeginLevelsChange;
  tvLevels.Items.BeginUpdate;
  try
    Level := SelectedLevel;
    with Level do
      if Parent.Count = 1 then
        SelectedLevel := Parent
      else
        if Index = Parent.Count - 1 then
          SelectedLevel := Parent[Index - 1]
        else
          SelectedLevel := Parent[Index + 1];
    Level.Free;
  finally
    RefreshLevels;
    tvLevels.Items.EndUpdate;
    EndLevelsChange;
    Modified;
  end;
end;

procedure TdxMasterViewDesigner.lbColumnsClick(Sender: TObject);
var
  List: TdxMVSelectionList;
begin
  List := SelectedColumns;
  if List.Count = 0 then
  begin
    List.Free;
    tvLevelsChange(nil, nil);
  end
  else
    SelectComponents(List);
  RefreshEnables;
end;

procedure TdxMasterViewDesigner.lbColumnsEnter(Sender: TObject);
begin
  lbColumnsClick(nil);
end;

procedure TdxMasterViewDesigner.lbColumnsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      if (Shift = []) and btnColumnAdd.Enabled then btnColumnAdd.Click;
    VK_DELETE:
      if (Shift = []) and btnColumnDelete.Enabled then btnColumnDelete.Click;
  end;
end;

procedure TdxMasterViewDesigner.btnColumnAddClick(Sender: TObject);
var
  ColumnClass: TdxMasterViewColumnClass;
  Column: TdxMasterViewColumn;
begin
  ColumnClass := TdxMasterViewColumn;
  if SelectColumnClass('Add new column', ColumnClass) then
  begin
    lbColumns.Items.BeginUpdate;
    try
      Column := SelectedLevel.CreateColumn(ColumnClass);
      try
        Column.Name := UniqueName(Column);
      finally
        RefreshColumns;
        SelectedColumn := Column;
      end;  
    finally
      lbColumns.Items.EndUpdate;
      lbColumnsClick(nil);
      Modified;
    end;
  end;
end;

procedure TdxMasterViewDesigner.btnColumnDeleteClick(Sender: TObject);
var
  List: TdxMVSelectionList;
  I: Integer;
  PrevCursor: TCursor;
  LockControlLayout, LockSorting: Boolean;
begin
  lbColumns.Items.BeginUpdate;
  try
    List := SelectedColumns;
    try
      PrevCursor := Screen.Cursor;
      Screen.Cursor := crHourglass;
      BeginModify;
      try
        with lbColumns do
          if ItemIndex <> -1 then
          begin
            SelectedColumn :=
              TdxMasterViewColumn(GetNearestNonselectedObject(lbColumns));
            lbColumnsClick(nil);
          end;
        LockControlLayout := False;
        LockSorting := False;
        SelectedLevel.BeginLayout;
        try
          for I := 0 to List.Count - 1 do
            with TdxMasterViewColumn(List[I]) do
            begin
              if not LockControlLayout and (GroupIndex <> -1) then
              begin
                LockControlLayout := True;
                Control.BeginLayout;
              end;
              if not LockSorting and (SortOrder <> soNone) then
              begin
                LockSorting := True;
                Level.BeginSorting;
              end;
              Free;
            end;
        finally
          try
            SelectedLevel.EndLayout;
          finally
            try
              if LockSorting then SelectedLevel.EndSorting;
            finally
              if LockControlLayout then Control.EndLayout;
            end;  
          end;
        end;
      finally    
        EndModify;
        Screen.Cursor := PrevCursor;
      end;
    finally
      List.Free;
      RefreshColumns;
    end;
  finally
    lbColumns.Items.EndUpdate;
    Modified;
  end;
end;

procedure TdxMasterViewDesigner.btnColumnAddAllClick(Sender: TObject);
var
  I: Integer;
  PrevCursor: TCursor;
begin
  if SelectedLevel.ColumnCount = 0 then I := ID_NO
  else
  begin
    I := Application.MessageBox('Delete existing columns?', 'Confirm',
      MB_ICONQUESTION or MB_YESNOCANCEL);
    if I = ID_CANCEL then Exit;
  end;

  if I = ID_YES then tvLevelsChange(nil, nil);
  PrevCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    lbColumns.Items.BeginUpdate;
    try
      BeginModify;
      try
        SelectedLevel.BeginLayout;
        try
          with SelectedLevel, DataSet do
          begin
            if I = ID_YES then DestroyColumns;
            CreateAllColumns;
          end;
        finally
          SelectedLevel.EndLayout;
        end;
      finally
        EndModify;
      end;
      RefreshColumns;
    finally
      lbColumns.Items.EndUpdate;
    end;
  finally    
    Screen.Cursor := PrevCursor;
    Modified;
  end;
end;

procedure TdxMasterViewDesigner.btnColumnChangeTypeClick(Sender: TObject);
var
  List, NewList1, NewList2: TdxMVSelectionList;
  ColumnClass: TdxMasterViewColumnClass;
  PrevFocusedControl: TWinControl;
  I, PrevItemIndex: Integer;
  Column: TdxMasterViewColumn;
  AName: string;
begin
  List := SelectedColumns;
  try
    ColumnClass := nil;
    for I := 0 to List.Count - 1 do
      if I = 0 then
        ColumnClass := TdxMasterViewColumnClass(List[I].ClassType)
      else
        if List[I].ClassType <> ColumnClass then
        begin
          ColumnClass := nil;
          Break;
        end;
    if SelectColumnClass('Change column type', ColumnClass) then
    begin
      BeginModify;
      try
        PrevFocusedControl := ActiveControl;
        try
          SelectComponent(SelectedLevel);
          NewList1 := TdxMVSelectionList.Create;
          NewList2 := TdxMVSelectionList.Create;
          try
            PrevItemIndex := lbColumns.ItemIndex;
            lbColumns.Items.BeginUpdate;
            try
              for I := 0 to List.Count - 1 do
              begin
                Column := TdxMasterViewColumn(List[I]);
                if Column.ClassType <> ColumnClass then
                begin
                  Column := SelectedLevel.CreateColumn(ColumnClass);
                  Column.Assign(List[I]);
                  if Column.Visible and (Column.Level.ViewMode = vmHorizontal) then
                    Column.ColIndex := Column.ColIndex + 1;
                  AName := TdxMasterViewColumn(List[I]).Name;
                  List[I].Free;
                  Column.Name := AName;
                end;
                NewList1.Add(Column);
                NewList2.Add(Column);
              end;
              RefreshColumns;
            finally
              SelectedColumns := NewList1;
              SelectComponents(NewList2);
              lbColumns.ItemIndex := PrevItemIndex;
              lbColumns.Items.EndUpdate;
            end;
          except
            NewList1.Free;
            NewList2.Free;
            raise;
          end;
        finally
          Modified;
          if (PrevFocusedControl <> nil) and PrevFocusedControl.CanFocus then
            ActiveControl := PrevFocusedControl;
        end;
      finally
        EndModify;
      end;
    end;
  finally
    List.Free;
  end;
end;

procedure TdxMasterViewDesigner.btnColumnMoveUpClick(Sender: TObject);
begin
  MoveUp(lbColumns);
end;

procedure TdxMasterViewDesigner.btnColumnMoveDownClick(Sender: TObject);
begin
  MoveDown(lbColumns);
end;

procedure TdxMasterViewDesigner.btnColumnRestoreDefaultsClick(Sender: TObject);
var
  List: TdxMVSelectionList;
  I: Integer;
begin
  List := SelectedColumns;
  SelectedLevel.BeginAssignWidths;
  try
    BeginModify;
    try
      for I := 0 to List.Count - 1 do
        TdxMasterViewColumn(List[I]).AssignedValues := [];
    finally
      EndModify;
    end;
  finally
    SelectedLevel.EndAssignWidths;
    List.Free;
    Modified;
  end;
end;

procedure TdxMasterViewDesigner.btnColumnRestoreWidthClick(Sender: TObject);
var
  List: TdxMVSelectionList;
  I: Integer;
begin
  List := SelectedColumns;
  SelectedLevel.BeginAssignWidths;
  try
    BeginModify;
    try
      for I := 0 to List.Count - 1 do
        with TdxMasterViewColumn(List[I]) do
          AssignedValues := AssignedValues - [cvWidth];
    finally
      EndModify;
    end;
  finally
    SelectedLevel.EndAssignWidths;
    List.Free;
    Modified;
  end;
end;

procedure TdxMasterViewDesigner.cmbMasterKeyClick(Sender: TObject);
begin
  if SelectedLevel.MasterKey <> cmbMasterKey.Text then
  begin
    SelectedLevel.MasterKey := cmbMasterKey.Text;
    DontRefreshData := True;
    Designer.Modified;
  end;  
end;

procedure TdxMasterViewDesigner.cmbMasterKeyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then cmbMasterKeyClick(nil);
end;

procedure TdxMasterViewDesigner.cmbDataSourceChange(Sender: TObject);
var
  Value: TDataSource;
begin
  Value :=
    TDataSource(Designer.GetComponent(cmbDataSource.Items[cmbDataSource.ItemIndex]));
  if SelectedLevel.DataSource <> Value then
  begin
    SelectedLevel.DataSource := Value;
    Designer.Modified;
  end;
end;

procedure TdxMasterViewDesigner.cmbIDClick(Sender: TObject);
begin
  if SelectedLevel.ID <> cmbID.Text then
  begin
    SelectedLevel.ID := cmbID.Text;
    DontRefreshData := True;
    Designer.Modified;
  end;  
end;

procedure TdxMasterViewDesigner.cmbIDKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then cmbIDClick(nil);
end;

procedure TdxMasterViewDesigner.cmbDetailKeyClick(Sender: TObject);
begin
  if SelectedLevel.DetailKey <> cmbDetailKey.Text then
  begin
    SelectedLevel.DetailKey := cmbDetailKey.Text;
    DontRefreshData := True;
    Designer.Modified;
  end;  
end;

procedure TdxMasterViewDesigner.cmbDetailKeyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then cmbDetailKeyClick(nil);
end;

procedure TdxMasterViewDesigner.lbStylesClick(Sender: TObject);
var
  List: TdxMVSelectionList;
begin
  List := SelectedStyles;
  if List.Count = 0 then
  begin
    List.Free;
    SelectComponent(Control);
  end
  else
    SelectComponents(List);
  RefreshPreviews;
  RefreshEnables;
end;

procedure TdxMasterViewDesigner.lbStylesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      if (Shift = []) and btnStyleAdd.Enabled then btnStyleAdd.Click;
    VK_DELETE:
      if (Shift = []) and btnStyleDelete.Enabled then btnStyleDelete.Click;
  end;
end;

procedure TdxMasterViewDesigner.btnStyleAddClick(Sender: TObject);
var
  Style: TdxMasterViewStyle;
begin
  lbStyles.Items.BeginUpdate;
  try
    Style := Control.CreateStyle(TdxMasterViewStyle);
    try
      Style.Name := UniqueName(Style);
    finally
      RefreshStyles;
      SelectedStyle := Style;
    end;  
  finally
    lbStyles.Items.EndUpdate;
    lbStylesClick(nil);
    Modified;
  end;
end;

procedure TdxMasterViewDesigner.btnStyleDeleteClick(Sender: TObject);
var
  List: TdxMVSelectionList;
  I: Integer;
  PrevCursor: TCursor;
begin
  lbStyles.Items.BeginUpdate;
  try
    List := SelectedStyles;
    try
      BeginModify;
      try
        with lbStyles do
          if ItemIndex <> -1 then
          begin
            SelectedStyle :=
              TdxMasterViewStyle(GetNearestNonselectedObject(lbStyles));
            lbStylesClick(nil);
          end;
        PrevCursor := Screen.Cursor;
        Screen.Cursor := crHourglass;
        Control.BeginUpdate;
        try
          for I := 0 to List.Count - 1 do
            TdxMasterViewStyle(List[I]).Free;
        finally
          Control.EndUpdate;
          Screen.Cursor := PrevCursor;
        end;
      finally
        EndModify;
      end;
    finally
      List.Free;
      RefreshStyles;
    end;
  finally
    lbStyles.Items.EndUpdate;
    Modified;
  end;
end;

procedure TdxMasterViewDesigner.btnStyleMoveUpClick(Sender: TObject);
begin
  MoveUp(lbStyles);
end;

procedure TdxMasterViewDesigner.btnStyleMoveDownClick(Sender: TObject);
begin
  MoveDown(lbStyles);
end;

end.
