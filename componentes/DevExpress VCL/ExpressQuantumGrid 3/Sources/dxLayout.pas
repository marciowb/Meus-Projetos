
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid Layout                                   }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSGRID AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxLayout;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxTL, dxDBGrid, DB, dxDBCtrl;

type
  { TdxDBGridWrapper }
  
  TdxDBGridWrapper = class(TdxDBGrid)
  protected
    function GetChildOwner: TComponent; override;
    procedure SetName(const NewName: TComponentName); override;
  public
    function GetNamePath: string; override;
    property IsCustomStoring;
  published
    property Align stored False;
    property Left stored False;
    property Top stored False;
    property Width stored False;
    property Height stored False;
    property Enabled stored False;
    property TabOrder stored False;
    property TabStop stored False;
    property Visible stored False;
    property Name stored False;
    property ShowHint stored False;
    {$IFDEF DELPHI4}
    property Anchors;
    property Constraints;
    {$ENDIF}
    // TODO store
  //  property Bands stored False;
  end;

  { TdxDBGridLayout }
  
  TdxDBGridLayoutList = class;

  TdxDBGridLayout = class(TComponent)
  private
    FLayoutList: TdxDBGridLayoutList;
    FDBGrid: TdxDBGrid;
    FDBGridParent: TWinControl;
    FStream: TMemoryStream;
    function GetDBGrid: TdxDBGrid;
    procedure SetDBGrid(Value: TdxDBGrid);
    procedure SetDBGridParent(Value: TWinControl);
    function GetActive: Boolean;
    procedure SetActive(Value: Boolean);
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
    procedure SaveToStream(ADBGrid: TdxDBGrid);
    procedure LoadFromStream(ADBGrid: TdxDBGrid);
    procedure SetLayoutList(ALayoutList: TdxDBGridLayoutList);
  protected
    // ovveride TComponent
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ReadState(Reader: TReader); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParentComponent(AParent: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure Clear;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure RestoreDefault(ADBGrid: TdxDBGrid);
    property Active: Boolean read GetActive write SetActive stored False;
    property DBGrid: TdxDBGrid read GetDBGrid write SetDBGrid;
    property DBGridParent: TWinControl read FDBGridParent write SetDBGridParent;
    property LayoutList: TdxDBGridLayoutList read FLayoutList write SetLayoutList;
  end;

  { TdxDBGridLayoutList }
  
  TdxDBGridLayoutListDesigner =class;

  TdxDBGridLayoutList = class(TComponent)
  private
    FItems: TList;
    FDesigner: TdxDBGridLayoutListDesigner;
    procedure AddItem(ALayout: TdxDBGridLayout);
    function GetItem(Index: Integer): TdxDBGridLayout;
    function GetCount: Integer;
    procedure RemoveItem(ALayout: TdxDBGridLayout);
    procedure SetItem(Index: Integer; ALayout: TdxDBGridLayout);
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearItems;
    function AddLayout: TdxDBGridLayout;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TdxDBGridLayout read GetItem write SetItem; default;
    property Designer: TdxDBGridLayoutListDesigner read FDesigner;
  end;

  { TdxDBGridLayoutListDesigner }
  
  TdxDBGridLayoutListDesigner = class
  private
    FLayoutList: TdxDBGridLayoutList;
  public
    constructor Create(ALayoutList: TdxDBGridLayoutList);
    destructor Destroy; override;
    procedure ChangedName(Layout: TdxDBGridLayout); virtual;
    procedure LayoutChanged; virtual;
    property LayoutList: TdxDBGridLayoutList read FLayoutList;
  end;

implementation

uses
  StdCtrls;

{ TdxDBGridLayout }

function TdxDBGridWrapper.GetChildOwner: TComponent;
begin
  Result := Self;
end;

function TdxDBGridWrapper.GetNamePath: string;
begin
  Result := Owner.Name + '.(DBGrid)';
end;

procedure TdxDBGridWrapper.SetName(const NewName: TComponentName);
begin
end;

{ TdxDBGridLayout }

constructor TdxDBGridLayout.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStream := TMemoryStream.Create;
end;

destructor TdxDBGridLayout.Destroy;
begin
  if FLayoutList <> nil then
    FLayoutList.RemoveItem(Self);
  SetActive(False);
  FStream.Free;
  FStream := nil;
  inherited Destroy;
end;

procedure TdxDBGridLayout.Assign(Source: TPersistent);
begin
  FStream.Clear;
  if Source = nil then Exit;
  if Source is TdxDBGridLayout then
    FStream.CopyFrom(TdxDBGridLayout(Source).FStream, 0)
  else
  if Source is TdxDBGrid then
  begin
    Active := True;
    SaveToStream(TdxDBGrid(Source));
    LoadFromStream(FDBGrid);
    SaveToStream(FDBGrid);
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBGridLayout.AssignTo(Dest: TPersistent);
var
  PrevName: string;
  PrevValue: Boolean;
begin
  if Dest is TdxDBGrid then
  begin
    with TdxDBGridWrapper(Dest) do
    begin
      BeginUpdate;
      try
        RestoreDefault(TdxDBGrid(Dest));
        PrevValue := IsCustomStoring;
        IsCustomStoring := True;
        try
          PrevName := Name;
          LoadFromStream(TdxDBGrid(Dest));
          Name := PrevName;
        finally
          IsCustomStoring := PrevValue;
          Loaded;
        end;
      finally
        EndUpdate;
      end;
    end;
  end
  else
    inherited AssignTo(Dest);
end;

procedure TdxDBGridLayout.Clear;
begin
  Assign(nil);
end;

function TdxDBGridLayout.GetParentComponent: TComponent;
begin
  Result := LayoutList;
end;

function TdxDBGridLayout.HasParent: Boolean;
begin
  HasParent := LayoutList <> nil;
end;

procedure TdxDBGridLayout.RestoreDefault(ADBGrid: TdxDBGrid);
var
  AFont: TFont;
begin
  with TdxDBGridWrapper(ADBGrid) do
  begin
    BeginUpdate;
    AFont := TFont.Create;
    try
      DataSource := nil;
      // TODO store
      DestroyColumns;
      // properties
      BorderStyle := bsSingle;
      Color := clWindow;
      Ctl3D := True;
      DragCursor := crDrag;
      DragMode := dmManual;
      Font.Assign(AFont);
      ParentColor := False;
      ParentCtl3D := True;
      ParentFont := True;
      ParentShowHint := True;
      PopupMenu := nil;
      ArrowsColor := dxclArrows;
      GroupPanelColor := dxclGroupPanel;
      GroupPanelFontColor := dxclGroupPanelText;
      GroupNodeColor := clBtnFace;
      GroupNodeTextColor := clNone;
      BandColor := clBtnFace;
      BandFont.Assign(AFont);
      RowFooterColor := cl3DLight;
      RowFooterTextColor := clWindowText;
      HeaderColor := clBtnFace;
      HeaderFont.Assign(AFont);
      HideFocusRect := False;
      HideSelection := False;
      IndentDesc := 20;
      FixedBandLineWidth := dxGridFixedBandLineWidth;
      LookAndFeel := lfStandard;
      {
      Options := [egoEditing, egoColumnSizing, egoColumnMoving,
        egoCanDelete, egoConfirmDelete, egoCanNavigation, egoCancelOnExit,
        egoImmediateEditor, egoCanInsert, egoTabThrough];
      OptionsEx := [egoUseBitmap, egoBandHeaderWidth, egoBandSizing, egoBandMoving, egoAutoSort,
        egoEnterShowEditor, egoVertThrough, egoDragScroll];
      }  
      DefaultRowHeight := 17;  // reset
      RowSeparatorLineWidth := 1;
      PreviewLines := 2;
      AFont.Color := clBlue;
      PreviewFont.Assign(AFont);
      HighlightColor := clHighlight;
      HighlightTextColor := clHighlightText;
      HideSelectionColor := clHighlight;
      HideSelectionTextColor := clHighlightText;
      WaitForExpandNodeTime := dxWaitForExpandNodeTime;
      ScrollBars := ssBoth;
      CustomizingRowCount := dxCustomizingRowCount;
      ShowBands := False;
      ShowGrid := True;
      ShowPreviewGrid := True;
      ShowHeader := True;
      ShowRowFooter := False;
      ShowNewItemRow := False;
      IniFileName := '';
      GrIndicatorWidth := dxDBGridIndicatorWidth;
      PreviewFieldName := '';
      RegistryPath := '';
      GridLineColor := clNone;
      DefaultFields := False;
      KeyField := '';
      ShowGroupPanel := False;
      ShowSummaryFooter := False;
      SummarySeparator := ', ';
      PreviewMaxLength := 0;
      // new
      Filter.RestoreDefaults;
      AutoExpandOnSearch := True;
      AutoSearchColor := clNone;
      AutoSearchTextColor := clNone;
      DblClkExpanding := True;
      FixedBandLineColor := clWindowFrame;
      IniSectionName := '';
      MaxRowLineCount := -1;
      OptionsBehavior := dxDBGridDefaultOptionsBehavior;
      OptionsCustomize := dxDBGridDefaultOptionsCustomize;
      OptionsDB := dxDBGridDefaultOptionsDB;
      OptionsView := dxDBGridDefaultOptionsView;
      ShowHiddenInCustomizeBox := False;
      SimpleCustomizeBox := False;
    finally
      AFont.Free;
      EndUpdate;
    end;
  end;
end;

// protected TdxDBGridLayout
procedure TdxDBGridLayout.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, FStream.Size > 0);
end;

procedure TdxDBGridLayout.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = DBGridParent then DBGridParent := nil;
end;

procedure TdxDBGridLayout.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TdxDBGridLayoutList then
    LayoutList := TdxDBGridLayoutList(Reader.Parent);
end;

procedure TdxDBGridLayout.SetName(const NewName: TComponentName);
begin
  inherited SetName(NewName);
  if Assigned(FLayoutList) and Assigned(FLayoutList.FDesigner) then
    FLayoutList.FDesigner.ChangedName(Self);
end;

procedure TdxDBGridLayout.SetParentComponent(AParent: TComponent);
begin
  if not (csLoading in ComponentState) and (AParent is TdxDBGridLayoutList) then
    LayoutList := AParent as TdxDBGridLayoutList;
end;

procedure TdxDBGridLayout.SaveToStream(ADBGrid: TdxDBGrid);
var
  PrevValue: Boolean;
begin
  FStream.Clear;
  with TdxDBGridWrapper(ADBGrid) do
  begin
    PrevValue := IsCustomStoring;
    IsCustomStoring := True;
    try
      FStream.WriteComponent(ADBGrid);
    finally
      IsCustomStoring := PrevValue;
    end;
  end;
end;

procedure TdxDBGridLayout.LoadFromStream(ADBGrid: TdxDBGrid);
begin
  if FStream.Size = 0 then Exit;
  FStream.Position := 0;
  FStream.ReadComponent(ADBGrid);
end;

procedure TdxDBGridLayout.SetLayoutList(ALayoutList: TdxDBGridLayoutList);
begin
  if FLayoutList <> ALayoutList then
  begin
    if FLayoutList <> nil then FLayoutList.RemoveItem(Self);
    if ALayoutList <> nil then ALayoutList.AddItem(Self);
  end;
end;

// private TdxDBGridLayout
procedure TdxDBGridLayout.ReadData(Stream: TStream);
var
  Size: Integer;
begin
  Stream.ReadBuffer(Size, SizeOf(Size));
  FStream.Clear;
  FStream.CopyFrom(Stream, Size);
end;

procedure TdxDBGridLayout.WriteData(Stream: TStream);
var
  Size: Integer;
begin
  if Active then SaveToStream(FDBGrid);
  Size := FStream.Size;
  FStream.Position := 0;
  Stream.WriteBuffer(Size, SizeOf(Size));
  Stream.CopyFrom(FStream, Size);
end;

function TdxDBGridLayout.GetDBGrid: TdxDBGrid;
begin
//  Active := True;
  Result := FDBGrid;
end;

procedure TdxDBGridLayout.SetDBGrid(Value: TdxDBGrid);
begin
  Self.Assign(Value);
end;

procedure TdxDBGridLayout.SetDBGridParent(Value: TWinControl);
begin
  if FDBGridParent <> Value then
  begin
    FDBGridParent := Value;
    if Value <> nil then
      Value.FreeNotification(Self);
  end;
end;

function TdxDBGridLayout.GetActive: Boolean;
begin
  Result := FDBGrid <> nil;
end;

procedure TdxDBGridLayout.SetActive(Value: Boolean);
begin
  if Active <> Value then
  begin
    if Value then
    begin
      if FDBGrid = nil then
        FDBGrid := TdxDBGridWrapper.Create(Self);
      if DBGridParent <> nil then // design-time
      begin
        FDBGrid.Visible := False; // TODO: Check
        FDBGrid.SetBounds(0, 0, DBGridParent.ClientWidth, DBGridParent.ClientHeight);
        FDBGrid.Parent := DBGridParent;
      end;
      if FStream.Size > 0 then
      begin
        AssignTo(FDBGrid);
      end
      else
        SaveToStream(FDBGrid);
    end
    else
    begin
      SaveToStream(FDBGrid);
      FDBGrid.Free;
      FDBGrid := nil;
    end;
  end;
end;

{ TdxDBGridLayoutList }

constructor TdxDBGridLayoutList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TList.Create;
end;

destructor TdxDBGridLayoutList.Destroy;
begin
  Destroying;
  if FDesigner <> nil then FDesigner.Free;
  if Assigned(FItems) then ClearItems;
  FItems.Free;
  FItems := nil;
  inherited Destroy;
end;

procedure TdxDBGridLayoutList.ClearItems;
var
  AItem: TdxDBGridLayout;
begin
  while FItems.Count > 0 do
  begin
    AItem := FItems.Last;
    RemoveItem(AItem);
    AItem.Free;
  end;
end;

function TdxDBGridLayoutList.AddLayout: TdxDBGridLayout;
var
  I: Integer;
begin
  Result := TdxDBGridLayout.Create(Self.Owner);
  I := Count + 1;
  while I <> -1 do
    try
      Result.Name := Name + 'Item' + IntToStr(I);
      I := -1;
    except
      Inc(I);
    end;
  Result.LayoutList := Self;
end;

procedure TdxDBGridLayoutList.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  Item: TdxDBGridLayout;
begin
  for I := 0 to FItems.Count - 1 do
  begin
    Item := FItems[I];
    if Item.Owner = Root then Proc(Item);
  end;
end;

procedure TdxDBGridLayoutList.AddItem(ALayout: TdxDBGridLayout);
begin
  FItems.Add(ALayout);
  ALayout.FLayoutList := Self;
end;

function TdxDBGridLayoutList.GetItem(Index: Integer): TdxDBGridLayout;
begin
  Result := FItems[Index];
end;

function TdxDBGridLayoutList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

procedure TdxDBGridLayoutList.RemoveItem(ALayout: TdxDBGridLayout);
begin
  ALayout.FLayoutList := nil; 
  FItems.Remove(ALayout);
end;

procedure TdxDBGridLayoutList.SetItem(Index: Integer; ALayout: TdxDBGridLayout);
begin
  TdxDBGridLayout(FItems[Index]).Assign(ALayout);
end;

{ TdxDBGridLayoutListDesigner }

constructor TdxDBGridLayoutListDesigner.Create(ALayoutList: TdxDBGridLayoutList);
begin
  FLayoutList := ALayoutList;
  FLayoutList.FDesigner := Self;
end;

destructor TdxDBGridLayoutListDesigner.Destroy;
begin
  FLayoutList.FDesigner := nil;
  inherited Destroy;
end;

procedure TdxDBGridLayoutListDesigner.ChangedName(Layout: TdxDBGridLayout);
begin
end;

procedure TdxDBGridLayoutListDesigner.LayoutChanged;
begin
end;

initialization
  Classes.RegisterClasses([TdxDBGridLayout, TdxDBGridWrapper]);

end.
