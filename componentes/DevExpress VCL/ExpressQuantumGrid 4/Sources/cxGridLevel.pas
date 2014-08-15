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

unit cxGridLevel;

{$I cxGridVer.inc}

interface

uses
  Classes, Graphics,
  cxControls, cxGraphics, cxLookAndFeelPainters, cxStyles,
  cxCustomData,
  cxGridCustomView, cxGridCustomTableView;

type
  TcxGridDetailTabsPosition = (dtpNone, dtpLeft, dtpTop);

const
  cxGridLevelDefaultDetailFrameWidth = 1;
  cxGridLevelDefaultDetailTabsPosition = dtpNone;
  cxGridLevelDefaultRootDetailFrameWidth = 0;
  cxGridLevelDefaultRootDetailTabsPosition = dtpNone;

  lsFirst = 0;
  lsTab = lsFirst;
  lsTabsBackground = lsFirst + 1;
  lsLast = lsTabsBackground;

type
  TcxGridLevel = class;

  TcxGridLevelOptions = class(TPersistent)
  private
    FDetailFrameColor: TColor;
    FDetailFrameWidth: Integer;
    FDetailTabsPosition: TcxGridDetailTabsPosition;
    FLevel: TcxGridLevel;
    procedure SetDetailFrameColor(Value: TColor);
    procedure SetDetailFrameWidth(Value: Integer);
    procedure SetDetailTabsPosition(Value: TcxGridDetailTabsPosition);
    function DefaultDetailFrameWidth: Integer;
    function DefaultDetailTabsPosition: TcxGridDetailTabsPosition;
    function IsDetailFrameWidthStored: Boolean;
    function IsDetailTabsPositionStored: Boolean;
  protected
    procedure Changed(AHardChange: Boolean = True);
    property Level: TcxGridLevel read FLevel;
  public
    constructor Create(ALevel: TcxGridLevel); virtual;
    function GetDetailFrameColor: TColor;
  published
    property DetailFrameColor: TColor read FDetailFrameColor write SetDetailFrameColor
      default clDefault;
    property DetailFrameWidth: Integer read FDetailFrameWidth write SetDetailFrameWidth
      stored IsDetailFrameWidthStored;
    property DetailTabsPosition: TcxGridDetailTabsPosition read FDetailTabsPosition
      write SetDetailTabsPosition stored IsDetailTabsPositionStored;
  end;

  TcxGridLevelGetTabStyleEvent = procedure(Sender, ATabLevel: TcxGridLevel;
    {$IFDEF BCB}var{$ELSE}out{$ENDIF} AStyle: TcxStyle) of object;

  TcxGridLevelStylesClass = class of TcxGridLevelStyles;

  TcxGridLevelStyles = class(TcxStyles)
  private
    FOnGetTabStyle: TcxGridLevelGetTabStyleEvent;
    function GetLevel: TcxGridLevel;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
  protected
    procedure Changed(AIndex: Integer); override;
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  public
    property Level: TcxGridLevel read GetLevel;
    procedure GetTabParams(ATabLevel: TcxGridLevel; out AParams: TcxViewParams); virtual;
  published
    property Tab: TcxStyle index lsTab read GetValue write SetValue;
    property TabsBackground: TcxStyle index lsTabsBackground read GetValue write SetValue;
    property OnGetTabStyle: TcxGridLevelGetTabStyleEvent read FOnGetTabStyle write FOnGetTabStyle;
  end;

  TcxGridLevelGetGridViewEvent = procedure(Sender: TcxGridLevel; AMasterRecord: TcxCustomGridRecord;
    var AGridView: TcxCustomGridView) of object;

  TcxGridLevelChangeKind = (lcName, lcCaption, lcGridView, lcStructure, lcVisibility);

  TcxGridLevelClass = class of TcxGridLevel;

  TcxGridLevel = class(TComponent)
  private
    FCaption: string;
    FControl: TcxControl;  // TcxCustomGrid;
    FDataRelation: TcxCustomDataRelation;
    FGridView: TcxCustomGridView;
    FItems: TList;
    FMaxDetailHeight: Integer;
    FOptions: TcxGridLevelOptions;
    FParent: TcxGridLevel;
    FStyles: TcxGridLevelStyles;
    FVisible: Boolean;
    FVisibleItems: TList;
    FSubClassEvents: TNotifyEvent;
    FOnGetGridView: TcxGridLevelGetGridViewEvent;

    function GetActive: Boolean;
    function GetActuallyVisible: Boolean;
    function GetCanBeVisible: Boolean;
    function GetCount: Integer;
    function GetIndex: Integer;
    function GetIsLoading: Boolean;
    function GetIsMaster: Boolean;
    function GetIsRoot: Boolean;
    function GetIsTop: Boolean;
    function GetItem(Index: Integer): TcxGridLevel;
    function GetLevel: Integer;
    function GetParentGridView: TcxCustomGridView;
    function GetVisibleCount: Integer;
    function GetVisibleIndex: Integer;
    function GetVisibleItem(Index: Integer): TcxGridLevel;
    procedure SetActive(Value: Boolean);
    procedure SetCaption(const Value: string);
    procedure SetGridView(Value: TcxCustomGridView);
    procedure SetIndex(Value: Integer);
    procedure SetMaxDetailHeight(Value: Integer);
    procedure SetParent(Value: TcxGridLevel);
    procedure SetStyles(Value: TcxGridLevelStyles);
    procedure SetVisible(Value: Boolean);

    procedure AddItem(AItem: TcxGridLevel);
    procedure RemoveItem(AItem: TcxGridLevel);
    procedure ChangeItemIndex(AItem: TcxGridLevel; Value: Integer);
    function GetItemIndex(AItem: TcxGridLevel): Integer;
    procedure DestroyItems;
    procedure RefreshVisibleItemsList;

    procedure AddDataRelation(AItem: TcxGridLevel);
    procedure MoveDataRelation(AItem: TcxGridLevel; AIndex: Integer);
    procedure RemoveDataRelation(AItem: TcxGridLevel);
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParentComponent(Value: TComponent); override;

    function CreateLinkObject(ARelation: TcxCustomDataRelation;
      ARecordIndex: Integer): TcxCustomGridView; virtual;
    procedure Changed(AHardChange: Boolean = True); virtual;
    procedure CheckHeight(var Value: Integer); virtual;
    function GetItemClass: TcxGridLevelClass; virtual;
    function GetStylesClass: TcxGridLevelStylesClass; virtual;
    procedure ItemVisibleChanged(AItem: TcxGridLevel); virtual;
    procedure NotifyControl(AChangeKind: TcxGridLevelChangeKind);
    procedure SetupMasterRelation(AVisible, AIsPattern: Boolean);

    property IsLoading: Boolean read GetIsLoading;
    property IsRoot: Boolean read GetIsRoot;
    property ParentGridView: TcxCustomGridView read GetParentGridView;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    function Add: TcxGridLevel;
    function GetAvailableItem: TcxGridLevel;
    function HasAsChild(ALevel: TcxGridLevel): Boolean;

    property Active: Boolean read GetActive write SetActive;
    property ActuallyVisible: Boolean read GetActuallyVisible;
    property CanBeVisible: Boolean read GetCanBeVisible;
    property Control: TcxControl read FControl write FControl;
    property Count: Integer read GetCount;
    property DataRelation: TcxCustomDataRelation read FDataRelation;
    property Index: Integer read GetIndex write SetIndex;
    property IsMaster: Boolean read GetIsMaster;
    property IsTop: Boolean read GetIsTop;
    property Items[Index: Integer]: TcxGridLevel read GetItem; default;
    property Level: Integer read GetLevel;
    property Parent: TcxGridLevel read FParent write SetParent;
    property VisibleCount: Integer read GetVisibleCount;
    property VisibleIndex: Integer read GetVisibleIndex;
    property VisibleItems[Index: Integer]: TcxGridLevel read GetVisibleItem;
  published
    property Caption: string read FCaption write SetCaption;
    property GridView: TcxCustomGridView read FGridView write SetGridView;
    property MaxDetailHeight: Integer read FMaxDetailHeight write SetMaxDetailHeight default 0;
    property Options: TcxGridLevelOptions read FOptions write FOptions;
    property Styles: TcxGridLevelStyles read FStyles write SetStyles;
    property Visible: Boolean read FVisible write SetVisible default True;
    property StylesEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;
    property OnGetGridView: TcxGridLevelGetGridViewEvent read FOnGetGridView write FOnGetGridView;
  end;

implementation

uses
  SysUtils, cxClasses, cxGrid, cxGridStrs;

type
  TcxCustomGridAccess = class(TcxCustomGrid);
  TcxCustomGridViewAccess = class(TcxCustomGridView);

{ TcxGridLevelOptions }

constructor TcxGridLevelOptions.Create(ALevel: TcxGridLevel);
begin
  inherited Create;
  FLevel := ALevel;
  FDetailFrameColor := clDefault;
  FDetailFrameWidth := cxGridLevelDefaultDetailFrameWidth;
  FDetailTabsPosition := cxGridLevelDefaultDetailTabsPosition;
end;

procedure TcxGridLevelOptions.SetDetailFrameColor(Value: TColor);
begin
  if FDetailFrameColor <> Value then
  begin
    FDetailFrameColor := Value;
    Changed(False);
  end;
end;

procedure TcxGridLevelOptions.SetDetailFrameWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FDetailFrameWidth <> Value then
  begin
    FDetailFrameWidth := Value;
    Changed;
  end;
end;

procedure TcxGridLevelOptions.SetDetailTabsPosition(Value: TcxGridDetailTabsPosition);
begin
  if FDetailTabsPosition <> Value then
  begin
    FDetailTabsPosition := Value;
    Changed;
  end;
end;

function TcxGridLevelOptions.DefaultDetailFrameWidth: Integer;
begin
  if FLevel.IsRoot then
    Result := cxGridLevelDefaultRootDetailFrameWidth
  else
    Result := cxGridLevelDefaultDetailFrameWidth;
end;

function TcxGridLevelOptions.DefaultDetailTabsPosition: TcxGridDetailTabsPosition;
begin
  if FLevel.IsRoot then
    Result := cxGridLevelDefaultRootDetailTabsPosition
  else
    Result := cxGridLevelDefaultDetailTabsPosition;
end;

function TcxGridLevelOptions.IsDetailFrameWidthStored: Boolean;
begin
  Result := FDetailFrameWidth <> DefaultDetailFrameWidth;
end;

function TcxGridLevelOptions.IsDetailTabsPositionStored: Boolean;
begin
  Result := FDetailTabsPosition <> DefaultDetailTabsPosition;
end;

procedure TcxGridLevelOptions.Changed(AHardChange: Boolean = True);
begin
  FLevel.Changed(AHardChange);
end;

function TcxGridLevelOptions.GetDetailFrameColor: TColor;
begin
  Result := FDetailFrameColor;
  if Result = clDefault then
    Result := TcxCustomGrid(FLevel.Control).LookAndFeelPainter.DefaultFixedSeparatorColor;
end;

{ TcxGridLevelStyles }

function TcxGridLevelStyles.GetLevel: TcxGridLevel;
begin
  Result := TcxGridLevel(GetOwner);
end;

function TcxGridLevelStyles.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := TcxCustomGrid(Level.Control).LookAndFeelPainter;;
end;

procedure TcxGridLevelStyles.Changed(AIndex: Integer);
begin
  inherited;
  Level.Changed;
end;

procedure TcxGridLevelStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
begin
  inherited;
  AParams.Font := TcxCustomGrid(Level.Control).Font;
  with LookAndFeelPainter, AParams do
    case Index of
      lsTab:
        begin
          Color := DefaultTabColor;
          TextColor := DefaultTabTextColor;
        end;
      lsTabsBackground:
        Color := DefaultTabsBackgroundColor;
    end;
end;

procedure TcxGridLevelStyles.GetTabParams(ATabLevel: TcxGridLevel; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetTabStyle) then FOnGetTabStyle(Level, ATabLevel, AStyle);
  GetViewParams(lsTab, ATabLevel, AStyle, AParams);
end;

{ TcxGridLevel }

constructor TcxGridLevel.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TList.Create;
  FOptions := TcxGridLevelOptions.Create(Self);
  FStyles := GetStylesClass.Create(Self);
  FVisible := True;
  FVisibleItems := TList.Create;
end;

destructor TcxGridLevel.Destroy;
begin
  DestroyItems;
  GridView := nil;
  if FParent <> nil then
    FParent.RemoveItem(Self);
  FVisibleItems.Free;
  FItems.Free;
  FStyles.Free;
  FOptions.Free;
  inherited;
end;

function TcxGridLevel.GetActive: Boolean;
begin
  Result := TcxCustomGrid(FControl).ActiveLevel = Self;
end;

function TcxGridLevel.GetActuallyVisible: Boolean;
begin
  Result := FVisible and (not IsTop or Active) and
    ((FParent = nil) or FParent.ActuallyVisible);
end;

function TcxGridLevel.GetCanBeVisible: Boolean;
begin
  Result := FVisible and ((FParent = nil) or FParent.CanBeVisible);
end;

function TcxGridLevel.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridLevel.GetIndex: Integer;
begin
  Result := FParent.GetItemIndex(Self);
end;

function TcxGridLevel.GetIsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

function TcxGridLevel.GetIsMaster: Boolean;
begin
  Result := VisibleCount <> 0;
end;

function TcxGridLevel.GetIsRoot: Boolean;
begin
  Result := TcxCustomGrid(FControl).Levels = Self;
end;

function TcxGridLevel.GetIsTop: Boolean;
begin
  Result := FParent = TcxCustomGrid(FControl).Levels;
end;

function TcxGridLevel.GetItem(Index: Integer): TcxGridLevel;
begin
  Result := FItems[Index];
end;

function TcxGridLevel.GetLevel: Integer;
var
  AParent: TcxGridLevel;
begin
  Result := -1;
  AParent := Parent;
  while AParent <> nil do
  begin
    Inc(Result);
    AParent := AParent.Parent;
  end;
end;

function TcxGridLevel.GetParentGridView: TcxCustomGridView;
begin
  if FParent <> nil then
    Result := FParent.GridView
  else
    Result := nil;
end;

function TcxGridLevel.GetVisibleCount: Integer;
begin
  Result := FVisibleItems.Count;
end;

function TcxGridLevel.GetVisibleIndex: Integer;
begin
  Result := FParent.FVisibleItems.IndexOf(Self);
end;

function TcxGridLevel.GetVisibleItem(Index: Integer): TcxGridLevel;
begin
  Result := FVisibleItems[Index];
end;

procedure TcxGridLevel.SetActive(Value: Boolean);
begin
  if Active <> Value then
    if Value then
      if IsTop then
        TcxCustomGrid(FControl).ActiveLevel := Self
      else  
    else
      TcxCustomGrid(FControl).ActiveLevel := nil;
end;

procedure TcxGridLevel.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed;
    NotifyControl(lcCaption);
  end;
end;

procedure TcxGridLevel.SetGridView(Value: TcxCustomGridView);
var
  I: Integer;
  APrevGridView: TcxCustomGridView;

  procedure CheckFocusedGridView;
  begin         
    if FGridView <> nil then
      if (APrevGridView = nil) and (TcxCustomGrid(FControl).FocusedView = nil) or
        (APrevGridView <> nil) and APrevGridView.Focused then
        FGridView.Focused := True
      else  
    else
      APrevGridView.Focused := False;
  end;

begin
  if FGridView <> Value then
  begin
    if (Value <> nil) and (Value.Level <> nil) then
      TcxGridLevel(Value.Level).GridView := nil;
    if FGridView <> nil then
    begin
      FGridView.BeginUpdate;
      try
        for I := 0 to Count - 1 do
          RemoveDataRelation(Items[I]);
      finally
        FGridView.EndUpdate;
      end;
      TcxCustomGridViewAccess(FGridView).SetLevel(nil);
    end;
    APrevGridView := FGridView;
    FGridView := Value;
    if FGridView <> nil then
      FGridView.Control := Control;  {5}
    if FParent <> nil then
      FParent.RefreshVisibleItemsList;

    if FGridView <> nil then FGridView.BeginUpdate;
    try
      if APrevGridView <> nil then
        APrevGridView.DataController.SetMasterMode(nil, True);
      if FGridView <> nil then
      begin
        TcxCustomGridViewAccess(FGridView).SetLevel(Self);
        SetupMasterRelation(FVisible, not IsTop);
        for I := 0 to Count - 1 do
          AddDataRelation(Items[I]);
      end;
      Changed(False);  {5}
    finally
      if FGridView <> nil then FGridView.EndUpdate;
    end;
    CheckFocusedGridView;
    if APrevGridView <> nil then
      APrevGridView.Control := APrevGridView.StorageControl;
    NotifyControl(lcGridView);
  end;
end;

procedure TcxGridLevel.SetIndex(Value: Integer);
begin
  FParent.ChangeItemIndex(Self, Value);
end;

procedure TcxGridLevel.SetMaxDetailHeight(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMaxDetailHeight <> Value then
  begin
    FMaxDetailHeight := Value;
    Changed;
  end;
end;

procedure TcxGridLevel.SetParent(Value: TcxGridLevel);
begin
  if FParent <> Value then
  begin
    TcxCustomGrid(Control).BeginUpdate;
    try
      if (Value <> nil) and ((Value = Self) or HasAsChild(Value)) then
        raise Exception.Create(scxGridRecursiveLevels);
      if FParent <> nil then
        FParent.RemoveItem(Self);
      if Value <> nil then
        Value.AddItem(Self);
    finally
      TcxCustomGrid(Control).EndUpdate;
    end;
  end;
end;

procedure TcxGridLevel.SetStyles(Value: TcxGridLevelStyles);
begin
  FStyles.Assign(Value);
end;

procedure TcxGridLevel.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    {if Value and (FGridView <> nil) then
      SetupMasterRelation(Value, not IsTop);}
    FVisible := Value;
    if Value and (FGridView <> nil) then
      SetupMasterRelation(Value, not IsTop);
    if FParent <> nil then
      FParent.ItemVisibleChanged(Self);
    if FVisible then
      if TcxCustomGrid(FControl).ActiveLevel = nil then
        Active := True
      else
    else
      Active := False;
    Changed;
    TcxCustomGrid(Control).CheckFocusedView;
    if not Value and (FGridView <> nil) then
      SetupMasterRelation(Value, not IsTop);
    NotifyControl(lcVisibility);
  end;
end;

procedure TcxGridLevel.AddItem(AItem: TcxGridLevel);
begin
  FItems.Add(AItem);
  AItem.FControl := FControl;
  AItem.FParent := Self;
  RefreshVisibleItemsList;
  AddDataRelation(AItem);
  if IsRoot and (TcxCustomGrid(FControl).ActiveLevel = nil) then
    TcxCustomGrid(FControl).ActiveLevel := GetAvailableItem;
  Changed;
  NotifyControl(lcStructure);
end;

procedure TcxGridLevel.RemoveItem(AItem: TcxGridLevel);
begin
  FItems.Remove(AItem);
  FVisibleItems.Remove(AItem);
  AItem.FParent := nil;
  RemoveDataRelation(AItem);
  AItem.Active := False;
  Changed;
  NotifyControl(lcStructure);
end;

procedure TcxGridLevel.ChangeItemIndex(AItem: TcxGridLevel; Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value >= Count then Value := Count - 1;
  FItems.Move(AItem.Index, Value);
  RefreshVisibleItemsList;
  MoveDataRelation(AItem, Value);
  Changed;
  NotifyControl(lcStructure);
end;

function TcxGridLevel.GetItemIndex(AItem: TcxGridLevel): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

procedure TcxGridLevel.DestroyItems;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Items[I].Free;
end;

procedure TcxGridLevel.RefreshVisibleItemsList;
var
  I: Integer;
begin
  FVisibleItems.Clear;
  for I := 0 to Count - 1 do
    if Items[I].Visible then
      FVisibleItems.Add(Items[I]);
end;

procedure TcxGridLevel.AddDataRelation(AItem: TcxGridLevel);
begin
  if FGridView <> nil then
  begin
    AItem.FDataRelation := FGridView.DataController.Relations.Add(AItem);
    with AItem do
      if GridView <> nil then
        SetupMasterRelation(Visible, GridView.DataController.IsPattern);
  end;
end;

procedure TcxGridLevel.MoveDataRelation(AItem: TcxGridLevel; AIndex: Integer);
begin
  if FGridView <> nil then
    FGridView.DataController.Relations.Move(AItem.DataRelation.Index, AIndex);
end;

procedure TcxGridLevel.RemoveDataRelation(AItem: TcxGridLevel);
begin
  FreeAndNil(AItem.FDataRelation);
end;

procedure TcxGridLevel.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  inherited;
  for I := 0 to Count - 1 do
    if Items[I].Owner = Root then
      Proc(Items[I]);
end;

procedure TcxGridLevel.SetName(const NewName: TComponentName);
begin
  inherited;
  NotifyControl(lcName);
end;

procedure TcxGridLevel.SetParentComponent(Value: TComponent);
begin
  inherited;
  if Value is TcxCustomGrid then
    TcxCustomGrid(Value).Levels.AddItem(Self)
  else
    if Value is TcxGridLevel then
      TcxGridLevel(Value).AddItem(Self);
end;

function TcxGridLevel.CreateLinkObject(ARelation: TcxCustomDataRelation;
  ARecordIndex: Integer): TcxCustomGridView;
var
  AGridView: TcxCustomGridView;

  function GetMasterRecord: TcxCustomGridRecord;
  var
    AIDataController: IcxCustomGridDataController;
  begin
    ARelation.DataController.GetInterface(IcxCustomGridDataController, AIDataController);
    Result := (AIDataController.GridView as TcxCustomGridTableView).ViewData.GetRecordByRecordIndex(ARecordIndex);
  end;

begin
  AGridView := FGridView;
  if Assigned(FOnGetGridView) then FOnGetGridView(Self, GetMasterRecord, AGridView);
  if (AGridView = nil) or not Visible then
    Result := nil
  else
  begin
    Result := TcxCustomGridViewClass(AGridView.ClassType).CreateEx(FControl);
    Result.BeginUpdate;
    try
      TcxCustomGridViewAccess(Result).AssignPattern(AGridView);
      Result.DataController.Relations.BeginUpdate;
      try
        Result.DataController.Relations.Assign(AGridView.DataController.Relations);
        Result.DataController.SetMasterRelation(ARelation, ARecordIndex);
      finally
        Result.DataController.Relations.EndUpdate;
      end;
      TcxCustomGridViewAccess(Result).SetLevel(Self);
    finally
      Result.CancelUpdate;
    end;
    {try
      Result.Assign(AGridView);
      TcxCustomGridViewAccess(Result).SetLevel(Self);
      Result.DataController.BeginUpdate;
      try
        Result.DataController.Assign(AGridView.DataController);
        Result.DataController.Relations.BeginUpdate;
        try
          Result.DataController.Relations.Assign(AGridView.DataController.Relations);
          Result.DataController.SetMasterRelation(ARelation, ARecordIndex);
        finally
          Result.DataController.Relations.EndUpdate;
        end;
      finally
        Result.DataController.EndUpdate;
      end;
    finally
      Result.CancelUpdate;
    end;}
    TcxCustomGridViewAccess(AGridView).AddClone(Result);
  end;
end;

procedure TcxGridLevel.Changed(AHardChange: Boolean);
begin
  if AHardChange then
    TcxCustomGrid(FControl).SizeChanged
  else
    TcxCustomGrid(FControl).LayoutChanged
end;

procedure TcxGridLevel.CheckHeight(var Value: Integer);
begin
  if Value < 0 then Value := 0;
  if (FMaxDetailHeight <> 0) and (Value > FMaxDetailHeight) then
    Value := FMaxDetailHeight;
end;

function TcxGridLevel.GetItemClass: TcxGridLevelClass;
begin
  Result := TcxGridLevel;
end;

function TcxGridLevel.GetStylesClass: TcxGridLevelStylesClass;
begin
  Result := TcxGridLevelStyles;
end;

procedure TcxGridLevel.ItemVisibleChanged(AItem: TcxGridLevel);
var
  APrevVisibleCount: Integer;
begin
  APrevVisibleCount := VisibleCount;
  RefreshVisibleItemsList;
  if FGridView <> nil then
    TcxCustomGridViewAccess(FGridView).DetailVisibleChanged(AItem, APrevVisibleCount, VisibleCount);
end;

procedure TcxGridLevel.NotifyControl(AChangeKind: TcxGridLevelChangeKind);
begin
  TcxCustomGridAccess(FControl).LevelChanged(Self, AChangeKind);
end;

procedure TcxGridLevel.SetupMasterRelation(AVisible, AIsPattern: Boolean);
begin
  if AVisible then
    FGridView.DataController.SetMasterMode(FDataRelation, AIsPattern)
  else
    FGridView.DataController.SetMasterMode(nil, True);
end;

function TcxGridLevel.GetParentComponent: TComponent;
begin
  if IsTop then
    Result := FControl
  else
    Result := FParent;
end;

function TcxGridLevel.HasParent: Boolean;
begin
  Result := True;
end;

function TcxGridLevel.Add: TcxGridLevel;
begin
  Result := GetItemClass.Create(FControl.Owner);
  AddItem(Result);
end;

function TcxGridLevel.GetAvailableItem: TcxGridLevel;
begin
  if (VisibleCount = 0) or Control.IsDestroying then
    Result := nil
  else
    Result := VisibleItems[0];
end;

function TcxGridLevel.HasAsChild(ALevel: TcxGridLevel): Boolean;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := (Items[I] = ALevel) or Items[I].HasAsChild(ALevel);
    if Result then Exit;
  end;
  Result := False;
end;

end.
