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

unit cxGridStructureNavigator; // TODO transparency

{$I cxGridVer.inc}

interface

uses
  Windows, Messages,
{$IFDEF DELPHI6}
  DesignIntf,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  TypInfo, Classes, SysUtils, Controls, Graphics, Forms,
  dxMessages, cxControls, cxClasses, cxGraphics,
  cxDesignWindows,
  cxGridCommon, cxGrid, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView,
  cxGridBandedTableView, cxGridDBBandedTableView,
  cxGridCardView, cxGridDBCardView,
  cxGridDBDataDefinitions,
  cxGridViewLayoutEditor,
  Menus, ExtCtrls, Buttons;

type
  TcxGridStructureControl = class;
  TcxGridStructureNavigator = class;
  
  { TcxGridStructureControlViewInfo }

  TcxGridStructureControlRowViewInfo = class
    Bounds: TRect;

    LevelBounds: TRect;
    LevelContentBounds: TRect;
    LevelHighlighted: Boolean;
    LevelSelected: Boolean;
    LevelText: string;
    LevelTextArea: TRect;

    ViewBounds: TRect;
    ViewContentBounds: TRect;
    ViewHighlighted: Boolean;
    ViewSelected: Boolean;
    ViewText: string;
    ViewTextArea: TRect;

    TreeLineVertCount: Integer;
    TreeLineIsParent: Boolean;
    TreeLineIsLast: Boolean;
  end;

  TcxGridStructureControlRowsViewInfo = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TcxGridStructureControlRowViewInfo;
  public
    property Items[Index: Integer]: TcxGridStructureControlRowViewInfo read GetItem; default;
  end;

  TcxGridStructureControlViewInfo = class
  private
    FCanvas: TcxCanvas;
    FStructureControl: TcxGridStructureControl;
    FTextHeight: Integer;
    FRowHeight: Integer;
    FRows: TcxGridStructureControlRowsViewInfo;
    function GetCanvas: TcxCanvas;
    function GetGrid: TcxCustomGrid;
    function GetLevelByIndex(AIndex: Integer): TcxGridLevel;
    procedure GetLevelInfo(AIndex: Integer; var ALevelText, AViewText: string; var ALevelIndex: Integer; var AIsParent, AIsLast: Boolean);
    function GetRowCount: Integer;
  public
    Bounds: TRect;
    constructor Create(AStructureControl: TcxGridStructureControl);
    destructor Destroy; override;
    procedure Calculate;
    function GetContentColor: TColor;
    function GetContentFont: TFont;
    function GetContentFontColor: TColor;
    function GetGridColor: TColor;
    function GetGridLineWidth: Integer;
    function GetGridTreeLineColor: TColor;
    function GetGridTreeLineWidth: Integer;
    function GetHighlightedFontColor: TColor;
    function GetLevelColor: TColor;
    function GetRootLevelColor: TColor;
    function GetSelectedColor: TColor;
    function GetSelectedFontColor: TColor;
    function GetViewColor: TColor;
    procedure Paint;

    property Canvas: TcxCanvas read GetCanvas;
    property Grid: TcxCustomGrid read GetGrid;
    property StructureControl: TcxGridStructureControl read FStructureControl;
    property Rows: TcxGridStructureControlRowsViewInfo read FRows;
  end;

  { TcxGridStructureControl }

  TcxGridStructureControlSelectComponentEvent = procedure(Sender: TObject; AComponent: TComponent) of object;

  TcxGridStructureControlHitTest = (htNowhere, htLevel, htView);

  TcxGridStructureControlHitInfo = record
    HitTest: TcxGridStructureControlHitTest;
    RowIndex: Integer;
  end;

  TcxGridStructureControl = class(TcxControl)
  private
    FGrid: TcxCustomGrid;
    FHitInfo: TcxGridStructureControlHitInfo;
    FLockCount: Integer;
    FMayFocused: Boolean;
    FMouseDownHitInfo: TcxGridStructureControlHitInfo;
    FMousePressed: Boolean;
    FMultiSelect: Boolean;
    FSelectOneItem: Boolean;
    FViewInfo: TcxGridStructureControlViewInfo;
    FOnSelectComponent: TcxGridStructureControlSelectComponentEvent;
    FOnSelectionChanged: TNotifyEvent;
    procedure ClearSelection;
    procedure SetGrid(Value: TcxCustomGrid);
    procedure SetMultiSelect(Value: Boolean);
    procedure SetSelectOneItem(Value: Boolean);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;

    procedure AddToSelection(AComponent: TComponent; AClearSelection: Boolean);
    procedure CancelPressed(P: TPoint);
    procedure CheckMousePos(P: TPoint);
    procedure BoundsChanged; override;
    procedure FontChanged; override;
    function GetComponentByHitInfo(AHitInfo: TcxGridStructureControlHitInfo): TComponent;
    function GetCursor(X, Y: Integer): TCursor; override;
    function MayFocus: Boolean; override;
    procedure MouseLeave(AControl: TControl); override;
    procedure SelectComponent(AComponent: TComponent);
    procedure SelectionChanged; virtual;
    procedure SetPressed(APressed: Boolean);
    procedure UpdateContent; virtual;
    procedure UpdateHighlighted;
    property LockCount: Integer read FLockCount;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure Changed;
    procedure EndUpdate;
    function GetHitInfo(P: TPoint): TcxGridStructureControlHitInfo;
    function GetLevelByRowIndex(ARowIndex: Integer): TcxGridLevel;
    function GetSelectedLevel: TcxGridLevel;
    procedure GetSelection(ASelectionList: TList);
    procedure GetSelectionLevels(ASelectionList: TList);
    function GetSelectionLevelCount: Integer;
//    function GetSelectedView: TcxCustomGridView;
    procedure GetSelectionViews(ASelectionList: TList);
    function GetSelectionViewCount: Integer;
    procedure SyncSelection(ASelectionList: TList);
    property Grid: TcxCustomGrid read FGrid write SetGrid;
    property Keys;
    property MayFocused: Boolean read FMayFocused write FMayFocused;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect;
    property SelectOneItem: Boolean read FSelectOneItem write SetSelectOneItem;
    property ViewInfo: TcxGridStructureControlViewInfo read FViewInfo;
    property OnKeyPress;
    property OnSelectComponent: TcxGridStructureControlSelectComponentEvent read FOnSelectComponent write FOnSelectComponent;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
  end;

  { TcxGridStructureHelper }

  TcxGridStructureHelper = class
  private
    FPopupMenu: TPopupMenu;
    FPopupMenuLevel: TcxGridLevel;
    FStructureControl: TcxGridStructureControl;
    FOnUpdateDesigner: TNotifyEvent;
    procedure CreateAllItemsClick(Sender: TObject);
    procedure CreateLevelClick(Sender: TObject);
    procedure CreateViewClick(Sender: TObject);
    procedure DeleteAllItemsClick(Sender: TObject);
    procedure DeleteLevelClick(Sender: TObject);
    procedure DeleteViewClick(Sender: TObject);
    procedure EditViewLayoutClick(Sender: TObject);
    procedure SetAsDefaultClick(Sender: TObject);
  protected
    procedure StructureControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure UpdateDesigner;
  public
    constructor Create(AStructureControl: TcxGridStructureControl); virtual;
    destructor Destroy; override;
    property StructureControl: TcxGridStructureControl read FStructureControl;
    property OnUpdateDesigner: TNotifyEvent read FOnUpdateDesigner write FOnUpdateDesigner;
  end;

  { TcxGridStructureNavigator }

  TcxGridStructureNavigator = class(TcxCustomGridStructureNavigator)
  private
    FCloseButton: TSpeedButton;
    FCustomizeButton: TSpeedButton;
    FDefaultLevel: TcxGridLevel;
    FDefaultView: TcxCustomGridView;
    FSeparator: TBevel;
    FStructureControl: TcxGridStructureControl;
    FStructureHelper: TcxGridStructureHelper;
    procedure CloseButtonClick(Sender: TObject);
    procedure CustomizeButtonClick(Sender: TObject);
    procedure UpdateDesigner(Sender: TObject);
    procedure CMDeferUpdate(var Message); message DXM_REFRESHCUSTOMIZATION;
  protected
    procedure Paint; override;
    procedure Calculate;
    function CalculateBoundsRect: TRect; override;
    procedure Changed; override;
    procedure CreateDefaultComponents;
    function GetDesigner: {$IFDEF DELPHI6}IDesigner{$ELSE}IFormDesigner{$ENDIF};
    procedure NotifyEditors;
    procedure SelectComponent(Sender: TObject; AComponent: TComponent);
  public
    constructor Create(AGrid: TcxCustomGrid); override;
    destructor Destroy; override;
    procedure BeforeGridLoading; override;
  end;

function GenLevelName(AGrid: TcxCustomGrid; ALevel: TcxGridLevel): string;
function GenViewName(AOwnerComponent: TComponent; AView: TcxCustomGridView): string;
procedure CreateViewAllItems(AOwnerForm: TComponent; AView: TcxCustomGridView);
function IsViewDataBound(AView: TcxCustomGridView): Boolean;
function IsViewDataLinked(AView: TcxCustomGridView): Boolean;

const
  ScxGridTruncateClassName = 'TcxGrid';

implementation

uses
  cxLookAndFeelPainters, cxDBData, cxCustomData, cxGridEditor, cxViewEditor;

const
  ButtonBorderSize = 1;
  ButtonOffset = 2;
  CloseButtonHeight = 13;
  CloseButtonWidth = 14;
  FrameBorderSize = 2;
  LevelIndent = 16;
  NodeBorderSize = 1;
  NodeOffset = 2;
  TextOffset = 2;
  NavigatorOffset = 12;
  // strings
  SCustomizeText = 'Customize...'; // TODO res
  SSubStr = 'TcxGrid';

type
  TcxGridLevelAccess = class(TcxGridLevel); // TODO
  TLookAndFeelPainter = class(TcxUltraFlatLookAndFeelPainter);
  TColorIndex = (ciGrid, ciLevel, ciView);
  TcxCustomGridTableViewAccess = class(TcxCustomGridTableView);
  TcxCustomGridTableItemAccess = class(TcxCustomGridTableItem);

function GenLevelName(AGrid: TcxCustomGrid; ALevel: TcxGridLevel): string;
begin
  Result := CreateUniqueName(AGrid.Owner, AGrid, ALevel, ScxGridTruncateClassName, '');
end;

function GenViewName(AOwnerComponent: TComponent; AView: TcxCustomGridView): string;
begin
  Result := CreateUniqueName(AOwnerComponent.Owner, AOwnerComponent, AView, ScxGridTruncateClassName, '');
end;

procedure CreateViewAllItems(AOwnerForm: TComponent; AView: TcxCustomGridView);
var
  ADataController: TcxDBDataController;
  I: Integer;
  AItem: TcxCustomGridTableItem;
begin
  if AView.DataController is TcxDBDataController then
    ADataController := AView.DataController as TcxDBDataController
  else
    ADataController := nil;
  if (ADataController = nil) or (ADataController.DataSet = nil) then Exit;
  AView.BeginUpdate;
  try
    with ADataController.DataSet do
      for I := 0 to FieldCount - 1 do
      begin
        AItem := TcxCustomGridTableViewAccess(AView).CreateItem;
        with TcxCustomGridTableItemAccess(AItem) do
        begin
          with DataBinding as TcxGridItemDBDataBinding do
            FieldName := Fields[I].FieldName;
          Name := CreateUniqueName(AOwnerForm, AView, AItem, ScxGridTruncateClassName,Fields[I].FieldName);
          Visible := Fields[I].Visible;
        end;
      end;
  finally
    AView.EndUpdate;
  end;
end;

function IsViewDataBound(AView: TcxCustomGridView): Boolean;
begin
  Result := (AView.DataController is TcxDBDataController);
end;

function IsViewDataLinked(AView: TcxCustomGridView): Boolean;
begin
  Result := (AView.DataController is TcxDBDataController) and
    ((AView.DataController as TcxDBDataController).DataSet <> nil);
end;

procedure CreateCloseBitmap(ABitmap: TBitmap);
var
  ACanvas: TcxCanvas;
  ALookAndFeelPainter: TLookAndFeelPainter;
  R: TRect;
begin
  R := Rect(0, 0, CloseButtonWidth, CloseButtonHeight);
  with ABitmap do
  begin
    Width := R.Right - R.Left;
    Height := R.Bottom - R.Top;
    Canvas.Brush.Color := clBtnFace;
    Canvas.FillRect(R);
    ACanvas := TcxCanvas.Create(Canvas);
    ALookAndFeelPainter := TLookAndFeelPainter.Create;
    try
      ALookAndFeelPainter.DrawButtonCross(ACanvas, R, clBtnText, cxbsNormal);
    finally
      ALookAndFeelPainter.Free;
      ACanvas.Free;
    end;
  end;
end;

{ TcxGridStructureControlRowsViewInfo }

function TcxGridStructureControlRowsViewInfo.GetItem(Index: Integer): TcxGridStructureControlRowViewInfo;
begin
  Result := TcxGridStructureControlRowViewInfo(inherited Items[Index]);
end;

{ TcxGridStructureControlViewInfo }

constructor TcxGridStructureControlViewInfo.Create(AStructureControl: TcxGridStructureControl);
begin
  inherited Create;
  FStructureControl := AStructureControl;
  FRows := TcxGridStructureControlRowsViewInfo.Create;
end;

destructor TcxGridStructureControlViewInfo.Destroy;
begin
  FRows.Free;
  FreeAndNil(FCanvas);
  inherited Destroy;
end;

procedure TcxGridStructureControlViewInfo.Calculate;
var
  W, H: Integer;
  I, ALevelOffset, ATop: Integer;
  ARow: TcxGridStructureControlRowViewInfo;
begin
  // TODO: ref
  if Grid = nil then Exit;
  // Init
  Canvas.Font := GetContentFont;
  FTextHeight := Canvas.TextHeight('Wg');
  FRowHeight := 2 * NodeOffset + 2 * NodeBorderSize + 2 * TextOffset + FTextHeight;
  // Rows
  FRows.Clear;
  H := GetRowCount * FRowHeight;
  Bounds := Rect(0, 0, 0, H);
  ATop := 0;
  for I := 0 to GetRowCount - 1 do
  begin
    ARow := TcxGridStructureControlRowViewInfo.Create;
    GetLevelInfo(I, ARow.LevelText, ARow.ViewText, ARow.TreeLineVertCount,
      ARow.TreeLineIsParent, ARow.TreeLineIsLast);
    // Level
    ARow.LevelTextArea := Rect(0, ATop, Canvas.TextWidth(ARow.LevelText), ATop + FTextHeight);
    OffsetRect(ARow.LevelTextArea, TextOffset, TextOffset);
    ARow.LevelContentBounds := ARow.LevelTextArea;
    InflateRect(ARow.LevelContentBounds, TextOffset, TextOffset);
    OffsetRect(ARow.LevelTextArea, NodeBorderSize, NodeBorderSize);
    OffsetRect(ARow.LevelContentBounds, NodeBorderSize, NodeBorderSize);
    ARow.LevelBounds := ARow.LevelContentBounds;
    InflateRect(ARow.LevelBounds, NodeBorderSize, NodeBorderSize);
    ARow.Bounds := ARow.LevelBounds;
    OffsetRect(ARow.LevelBounds, NodeOffset, NodeOffset);
    OffsetRect(ARow.LevelContentBounds, NodeOffset, NodeOffset);
    OffsetRect(ARow.LevelTextArea, NodeOffset, NodeOffset);
    InflateRect(ARow.Bounds, NodeOffset, NodeOffset);
    OffsetRect(ARow.Bounds, NodeOffset, NodeOffset);
    // Indent
    ALevelOffset := ARow.TreeLineVertCount * (LevelIndent + NodeOffset);
    OffsetRect(ARow.LevelBounds, ALevelOffset, 0);
    OffsetRect(ARow.LevelContentBounds, ALevelOffset, 0);
    OffsetRect(ARow.LevelTextArea, ALevelOffset, 0);
    OffsetRect(ARow.Bounds, ALevelOffset, 0);
    // View
    if (I > 0) and (ARow.ViewText <> '') then
    begin
      W := 2 * NodeBorderSize + 2 * TextOffset + Canvas.TextWidth(ARow.ViewText);
      ARow.ViewBounds := Rect(ARow.LevelBounds.Right - 1, ARow.LevelBounds.Top,
        ARow.LevelBounds.Right - 1 + W, ARow.LevelBounds.Bottom);
      ARow.ViewContentBounds := ARow.ViewBounds;
      InflateRect(ARow.ViewContentBounds, -NodeBorderSize, -NodeBorderSize);
      ARow.ViewTextArea := ARow.ViewContentBounds;
      InflateRect(ARow.ViewTextArea, -TextOffset, -TextOffset);
      Inc(ARow.Bounds.Right, W);
    end;
    FRows.Add(ARow);
    if Bounds.Right < ARow.Bounds.Right then
      Bounds.Right := ARow.Bounds.Right;
    Inc(ATop, FRowHeight);
  end;
  Bounds.Bottom := ATop;
end;

function TcxGridStructureControlViewInfo.GetContentColor: TColor;
begin
  Result := GetRealColor($F5F5F5); //clWindow;
end;

function TcxGridStructureControlViewInfo.GetContentFont: TFont;
begin
  Result := StructureControl.Font;
end;

function TcxGridStructureControlViewInfo.GetContentFontColor: TColor;
begin
  Result := clBlack; //clWindowText;
end;

function TcxGridStructureControlViewInfo.GetGridColor: TColor;
begin
  Result := clBtnShadow; //RGB?
end;

function TcxGridStructureControlViewInfo.GetGridLineWidth: Integer;
begin
  Result := 1;
end;

function TcxGridStructureControlViewInfo.GetGridTreeLineColor: TColor;
begin
  Result := GetGridColor;
end;

function TcxGridStructureControlViewInfo.GetGridTreeLineWidth: Integer;
begin
  Result := 1;
end;

function TcxGridStructureControlViewInfo.GetHighlightedFontColor: TColor;
begin
  Result := clBlue; // TODO
end;

function TcxGridStructureControlViewInfo.GetLevelColor: TColor;
begin
  Result := GetRealColor($FACE87); //$00FCB369; // TODO
end;

function TcxGridStructureControlViewInfo.GetRootLevelColor: TColor;
begin
  Result := GetRealColor($82CCC9); //$A5D500; //$00BCFEA0; // TODO
end;

function TcxGridStructureControlViewInfo.GetSelectedColor: TColor;
begin
  Result := clHighlight; // TODO : LFPainters
end;

function TcxGridStructureControlViewInfo.GetSelectedFontColor: TColor;
begin
  Result := clHighlightText; // TODO : LFPainters
end;

function TcxGridStructureControlViewInfo.GetViewColor: TColor;
begin
  Result := GetRealColor($D5EFFF); //$00FFFF80; // TODO
end;

procedure TcxGridStructureControlViewInfo.Paint;

  procedure SetFontAndBrush(ASelected, AHighlighted: Boolean; AColorIndex: TColorIndex);
  begin
    if ASelected then
    begin
      Canvas.Brush.Color := GetSelectedColor;
      Canvas.Font.Color := GetSelectedFontColor;
    end
    else
    begin
      case AColorIndex of
        ciLevel:
          Canvas.Brush.Color := GetLevelColor;
        ciView:
          Canvas.Brush.Color := GetViewColor;
      else
        Canvas.Brush.Color := GetRootLevelColor;
      end;
      if AHighlighted then
        Canvas.Font.Color := GetHighlightedFontColor
      else
        Canvas.Font.Color := GetContentFontColor;
    end;
    if AHighlighted then
      Canvas.Font.Style := Canvas.Font.Style + [fsUnderline]
    else
      Canvas.Font.Style := Canvas.Font.Style - [fsUnderline];
  end;

  procedure DrawCell(ACellRect, ATextRect: TRect; const AText: string);
  begin
    Canvas.FillRect(ACellRect);
    Canvas.Brush.Style := bsClear;
    Canvas.DrawText(AText, ATextRect, cxAlignLeft or cxAlignVCenter or cxSingleLine);
    Canvas.Brush.Style := bsSolid;
  end;

  function IsLastInLevel(ARowIndex, ALevelIndex: Integer): Boolean;
(*  var
    ALevel, ALevel1: TcxGridLevel;
    I: Integer;*)
  begin
    Result := False;
(*    ALevel := GetLevelByIndex(ARowIndex);
    I := 0;
    ALevel1 := ALevel;
    repeat
      if I = ALevelIndex then
        Break;
    until ;
    while ALevel1.Parent <> nil do
    begin
      Inc(I);
      ALevel1 := ALevel1.Parent;
    end;
    ALevel1 := ALevel;
    while ALevelIndex < I do
    begin
      ALevel1 := ALevel1.Parent;

    end;
           *)
  end;

  procedure DrawTreeLines(ARowIndex: Integer; ARow: TcxGridStructureControlRowViewInfo);
  var
    R: TRect;
    I: Integer;
  begin
    Canvas.Brush.Color := GetGridTreeLineColor;
    if ARow.TreeLineIsParent then
    begin
      R.Left := ARow.LevelBounds.Left + (LevelIndent div 2);
      R.Right := R.Left + GetGridTreeLineWidth;
      R.Top := ARow.LevelBounds.Bottom;
      R.Bottom := ARow.Bounds.Bottom;
      Canvas.FillRect(R);
    end;
    for I := 0 to ARow.TreeLineVertCount -1 do
    begin
      // TODO
      R.Left := (I + 1) * (NodeOffset + LevelIndent) - (LevelIndent div 2);
      R.Right := R.Left + GetGridTreeLineWidth;
      R.Top := ARow.Bounds.Top;
      if (I = (ARow.TreeLineVertCount -1)) and ARow.TreeLineIsLast then
        R.Bottom := (ARow.Bounds.Bottom + ARow.Bounds.Top) div 2
      else
        if not IsLastInLevel(ARowIndex, I) then
          R.Bottom := ARow.Bounds.Bottom
        else
          R.Bottom := R.Top; // None
      Canvas.FillRect(R);
    end;
    if ARow <> Rows[0] then
    begin
      R.Right := ARow.LevelBounds.Left;
      R.Left := R.Right - NodeOffset - (LevelIndent div 2);
      R.Top := (ARow.Bounds.Bottom + ARow.Bounds.Top) div 2;
      R.Bottom := R.Top + GetGridTreeLineWidth;
      Canvas.FillRect(R);
    end;
  end;

  procedure DrawRows;
  const
    ColorIndexA: array[Boolean, Boolean] of TColorIndex = ((ciGrid, ciGrid), (ciLevel, ciView));
  var
    I: Integer;
    ARow: TcxGridStructureControlRowViewInfo;
  begin
    for I := 0 to Rows.Count - 1 do
    begin
      ARow := Rows[I];
      // Level
      Canvas.FrameRect(ARow.LevelBounds, GetGridColor, NodeBorderSize);
      SetFontAndBrush(ARow.LevelSelected, ARow.LevelHighlighted, ColorIndexA[I > 0, False]);
      DrawCell(ARow.LevelContentBounds, ARow.LevelTextArea, ARow.LevelText);
      // View
      if not IsRectEmpty(ARow.ViewBounds) then
      begin
        Canvas.FrameRect(ARow.ViewBounds, GetGridColor, NodeBorderSize);
        SetFontAndBrush(ARow.ViewSelected, ARow.ViewHighlighted, ColorIndexA[I > 0, True]);
        DrawCell(ARow.ViewContentBounds, ARow.ViewTextArea, ARow.ViewText);
      end;
      // TreeLines
//      DrawTreeLines(I, ARow);
    end;
  end;

begin
  Canvas.Brush.Color := GetContentColor;
  if StructureControl.HandleAllocated then
    Canvas.FillRect(StructureControl.ClientRect)
  else
    Canvas.FillRect(Bounds);
  // Rows
  Canvas.Font := GetContentFont;
  DrawRows;
end;

function TcxGridStructureControlViewInfo.GetCanvas: TcxCanvas;
begin
  if StructureControl.HandleAllocated then
  begin
    if FCanvas <> nil then
      FreeAndNil(FCanvas);
    Result := StructureControl.Canvas;
  end
  else
  begin
    if FCanvas = nil then
      FCanvas := TcxScreenCanvas.Create;
    Result := FCanvas;
  end;
end;

function TcxGridStructureControlViewInfo.GetGrid: TcxCustomGrid;
begin
  Result := StructureControl.Grid;
end;

function TcxGridStructureControlViewInfo.GetLevelByIndex(AIndex: Integer): TcxGridLevel;
var
  ACurrent: Integer;

  procedure CalculateCount(ALevel: TcxGridLevel);
  var
    I: Integer;
  begin
    if ALevel = nil then Exit;
    if ACurrent = AIndex then
      Result := ALevel
    else
    begin
      Inc(ACurrent);
      for I := 0 to ALevel.Count - 1 do
      begin
        CalculateCount(ALevel[I]);
        if Result <> nil then
          Break;
      end;
    end;  
  end;

begin
  Result := nil;
  ACurrent := 0;
  if (Grid <> nil) and (Grid.Levels <> nil) then
    CalculateCount(Grid.Levels);
end;

procedure TcxGridStructureControlViewInfo.GetLevelInfo(AIndex: Integer;
  var ALevelText, AViewText: string; var ALevelIndex: Integer;
  var AIsParent, AIsLast: Boolean);

  function GetCompName(AComponent: TComponent): string;
  begin
    Result := AComponent.Name;
    if Result = '' then
      Result := '< >';
  end;

var
  ALevel: TcxGridLevel;
begin
  ALevelText := '';
  AViewText := '';
  ALevelIndex := 0;
  AIsParent := False;
  AIsLast := False;
  ALevel := GetLevelByIndex(AIndex);
  if ALevel <> nil then
  begin
    AIsParent := ALevel.Count > 0;
    AIsLast := (ALevel.Parent <> nil) and
      (ALevel.Parent[ALevel.Parent.Count - 1] = ALevel);
    if TcxGridLevelAccess(ALevel).IsRoot then // TODO: IsRoot
      ALevelText := GetCompName(Grid)
    else
    begin
      ALevelText := GetCompName(ALevel);
      if ALevel.GridView <> nil then
        AViewText := GetCompName(ALevel.GridView);
    end;
  end;
  ALevelIndex := 0;
  while ALevel <> nil do
  begin
    if TcxGridLevelAccess(ALevel).IsRoot then // TODO: IsRoot
      Break
    else
    begin
      Inc(ALevelIndex);
      ALevel := ALevel.Parent;
    end;
  end;
end;

function TcxGridStructureControlViewInfo.GetRowCount: Integer;

  procedure CalculateCount(ALevel: TcxGridLevel);
  var
    I: Integer;
  begin
    Inc(Result, ALevel.Count);
    for I := 0 to ALevel.Count - 1 do
      CalculateCount(ALevel[I]);
  end;

begin
  if Grid = nil then
    Result := 0
  else
  begin
    Result := 1; // Root
    if Grid.Levels <> nil then
      CalculateCount(Grid.Levels);
  end;    
end;

{ TcxGridStructureControl }

constructor TcxGridStructureControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FViewInfo := TcxGridStructureControlViewInfo.Create(Self);
end;

destructor TcxGridStructureControl.Destroy;
begin
  FreeAndNil(FViewInfo);
  inherited Destroy;
end;

procedure TcxGridStructureControl.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TcxGridStructureControl.Changed;
begin
  if LockCount = 0 then
    UpdateContent;
end;

procedure TcxGridStructureControl.EndUpdate;
begin
  Dec(FLockCount);
  Changed;
end;

function TcxGridStructureControl.GetHitInfo(P: TPoint): TcxGridStructureControlHitInfo;
var
  I: Integer;
begin
  Result.HitTest := htNowhere;
  Result.RowIndex := -1;
  for I := 0 to ViewInfo.Rows.Count - 1 do
    if PtInRect(ViewInfo.Rows[I].Bounds, P) then
    begin
      Result.RowIndex := I;
      if PtInRect(ViewInfo.Rows[I].LevelBounds, P) then
      begin
        Result.HitTest := htLevel;
        Break;
      end
      else
        if PtInRect(ViewInfo.Rows[I].ViewBounds, P) then
        begin
          Result.HitTest := htView;
          Break;
        end;
    end;
end;

function TcxGridStructureControl.GetLevelByRowIndex(ARowIndex: Integer): TcxGridLevel;
begin
  Result := ViewInfo.GetLevelByIndex(ARowIndex);
end;

function TcxGridStructureControl.GetSelectedLevel: TcxGridLevel;
var
  ASelectionList: TList;
begin
  Result := nil;
  ASelectionList := TList.Create;
  try
    GetSelectionLevels(ASelectionList);
    if ASelectionList.Count = 1 then
      Result := ASelectionList[0];
  finally
    ASelectionList.Free;
  end;
end;

procedure TcxGridStructureControl.GetSelection(ASelectionList: TList);
var
  I: Integer;
  ALevel: TcxGridLevel;
begin
  ASelectionList.Clear;
  for I := 0 to ViewInfo.Rows.Count - 1 do
  begin
    ALevel := ViewInfo.GetLevelByIndex(I);
    if Assigned(ALevel) then
    begin
      if ViewInfo.Rows[I].LevelSelected then
      begin
        if TcxGridLevelAccess(ALevel).IsRoot then // TODO: IsRoot
          ASelectionList.Add(Grid)
        else
          ASelectionList.Add(ALevel);
      end;
      if ViewInfo.Rows[I].ViewSelected and (ALevel.GridView <> nil) then
        ASelectionList.Add(ALevel.GridView);
    end;
  end;
end;

procedure TcxGridStructureControl.GetSelectionLevels(ASelectionList: TList);
var
  I: Integer;
begin
  GetSelection(ASelectionList);
  for I := ASelectionList.Count - 1 downto 0 do
    if not (TObject(ASelectionList[I]) is TcxGridLevel) then
      ASelectionList.Delete(I);
end;

function TcxGridStructureControl.GetSelectionLevelCount: Integer;
var
  ASelectionList: TList;
begin
  ASelectionList := TList.Create;
  try
    GetSelectionLevels(ASelectionList);
    Result := ASelectionList.Count;
  finally
    ASelectionList.Free;
  end;
end;

procedure TcxGridStructureControl.GetSelectionViews(ASelectionList: TList);
var
  I: Integer;
begin
  GetSelection(ASelectionList);
  for I := ASelectionList.Count - 1 downto 0 do
    if not (TObject(ASelectionList[I]) is TcxCustomGridView) then
      ASelectionList.Delete(I);
end;

function TcxGridStructureControl.GetSelectionViewCount: Integer;
var
  ASelectionList: TList;
begin
  ASelectionList := TList.Create;
  try
    GetSelectionViews(ASelectionList);
    Result := ASelectionList.Count;
  finally
    ASelectionList.Free;
  end;
end;

procedure TcxGridStructureControl.SyncSelection(ASelectionList: TList);

  procedure CheckLevel(ARow: TcxGridStructureControlRowViewInfo; AComponent: TComponent);
  var
    ASelected: Boolean;
  begin
    ASelected := ASelectionList.IndexOf(AComponent) <> -1;
    if ARow.LevelSelected <> ASelected then
    begin
      ARow.LevelSelected := ASelected;
      InvalidateRect(ARow.LevelBounds, False);
    end;
  end;

  procedure CheckView(ARow: TcxGridStructureControlRowViewInfo; AComponent: TComponent);
  var
    ASelected: Boolean;
  begin
    ASelected := ASelectionList.IndexOf(AComponent) <> -1;
    if ARow.ViewSelected <> ASelected then
    begin
      ARow.ViewSelected := ASelected;
      InvalidateRect(ARow.ViewBounds, False);
    end;
  end;

var
  I: Integer;
  ALevel: TcxGridLevel;
begin
  for I := 0 to ViewInfo.Rows.Count - 1 do
  begin
    ALevel := ViewInfo.GetLevelByIndex(I);
    if Assigned(ALevel) then
      if TcxGridLevelAccess(ALevel).IsRoot then // TODO: IsRoot
        CheckLevel(ViewInfo.Rows[I], Grid)
      else
      begin
        CheckLevel(ViewInfo.Rows[I], ALevel);
        if ALevel.GridView <> nil then
          CheckView(ViewInfo.Rows[I], ALevel.GridView);
      end;
  end;
end;

procedure TcxGridStructureControl.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  AComponent: TComponent;
begin
  FMouseDownHitInfo := GetHitInfo(Point(X, Y));
  if Button in [mbLeft, mbRight] then
  begin
    AComponent := GetComponentByHitInfo(FMouseDownHitInfo);
    if AComponent <> nil then
    begin
      if Button = mbRight then
      begin
        AddToSelection(AComponent, True);
        SelectComponent(AComponent);
      end
      else
        if MultiSelect then
          AddToSelection(AComponent, SelectOneItem or not (ssCtrl in Shift))
        else
          SelectComponent(AComponent);
    end;      
    SetPressed(True);
    CheckMousePos(Point(X, Y));
  end;
  inherited;
end;

procedure TcxGridStructureControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  CheckMousePos(Point(X, Y));
end;

procedure TcxGridStructureControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button in [mbLeft, mbRight] then
    CancelPressed(Point(X, Y));
end;

procedure TcxGridStructureControl.Paint;
begin
  ViewInfo.Paint;
end;

procedure TcxGridStructureControl.AddToSelection(AComponent: TComponent; AClearSelection: Boolean);

  function IsEquals(AList1, AList2: TList): Boolean;
  var
    I: Integer;
  begin
    Result := AList1.Count = AList2.Count;
    if Result then
      for I := 0 to AList1.Count - 1 do
        if AList1[I] <> AList2[I] then
        begin
          Result := False;
          Break;
        end;
  end;

var
  APrevSelection, ASelection: TList;
begin
  APrevSelection := TList.Create;
  ASelection := TList.Create;
  try
    GetSelection(APrevSelection);
    if not AClearSelection then
      GetSelection(ASelection);
    if (AComponent <> nil) and (ASelection.Remove(AComponent) = -1) then
      ASelection.Add(AComponent);
    if not IsEquals(ASelection, APrevSelection) then
    begin
      SyncSelection(ASelection);
      SelectionChanged;
    end;
  finally
    ASelection.Free;
    APrevSelection.Free;
  end;
end;

procedure TcxGridStructureControl.CancelPressed(P: TPoint);
begin
  if not MultiSelect then
    ClearSelection;
  SetPressed(False);
  CheckMousePos(P);
end;

procedure TcxGridStructureControl.CheckMousePos(P: TPoint);
begin
  FHitInfo := GetHitInfo(P);
  UpdateHighlighted;
end;

procedure TcxGridStructureControl.BoundsChanged;
begin
  inherited;
  Changed;
end;

procedure TcxGridStructureControl.FontChanged;
begin
  inherited;
  Changed;
end;

function TcxGridStructureControl.GetComponentByHitInfo(AHitInfo: TcxGridStructureControlHitInfo): TComponent;
var
  ALevel: TcxGridLevel;
begin
  Result := nil;
  if AHitInfo.RowIndex = -1 then Exit;
  ALevel := ViewInfo.GetLevelByIndex(AHitInfo.RowIndex);
  if ALevel = nil then Exit;
  if AHitInfo.HitTest = htLevel then
  begin
    if TcxGridLevelAccess(ALevel).IsRoot then // TODO
      Result := Grid
    else
      Result := ALevel;
  end
  else
    if AHitInfo.HitTest = htView then
    begin
      if ALevel.GridView <> nil then
        Result := ALevel.GridView;
    end;
end;

function TcxGridStructureControl.GetCursor(X, Y: Integer): TCursor;
begin
  if GetHitInfo(Point(X, Y)).HitTest in [htLevel, htView] then
    Result := crHandPoint // TODO
  else
    Result := inherited GetCursor(X, Y);
end;

function TcxGridStructureControl.MayFocus: Boolean;
begin
  Result := FMayFocused;
end;

procedure TcxGridStructureControl.MouseLeave(AControl: TControl);
begin
  CheckMousePos(Point(-1, -1));
end;

procedure TcxGridStructureControl.SelectComponent(AComponent: TComponent);
begin
  if Assigned(FOnSelectComponent) then
    FOnSelectComponent(Self, AComponent);
end;

procedure TcxGridStructureControl.SelectionChanged;
begin
  if Assigned(FOnSelectionChanged) then
    FOnSelectionChanged(Self);
end;

procedure TcxGridStructureControl.SetPressed(APressed: Boolean);
begin
  if FMousePressed <> APressed then
  begin
    FMousePressed := APressed;
    // TODO
  end;
end;

procedure TcxGridStructureControl.UpdateContent;
var
  ASelectionList: TList;
begin
  ASelectionList := TList.Create;
  try
    GetSelection(ASelectionList);
    ViewInfo.Calculate;
    SyncSelection(ASelectionList);
    Invalidate;
  finally
    ASelectionList.Free;
  end;
end;

procedure TcxGridStructureControl.UpdateHighlighted;

  procedure CheckLevel(ARow: TcxGridStructureControlRowViewInfo; AHighlighted: Boolean);
  begin
    if ARow.LevelHighlighted <> AHighlighted then
    begin
      ARow.LevelHighlighted := AHighlighted;
      InvalidateRect(ARow.LevelBounds, False);
    end;
  end;

  procedure CheckView(ARow: TcxGridStructureControlRowViewInfo; AHighlighted: Boolean);
  begin
    if ARow.ViewHighlighted <> AHighlighted then
    begin
      ARow.ViewHighlighted := AHighlighted;
      InvalidateRect(ARow.ViewBounds, False);
    end;
  end;

var
  I: Integer;
  AHitInfo: TcxGridStructureControlHitInfo;
begin
  for I := 0 to ViewInfo.Rows.Count - 1 do
  begin
    if FMousePressed then
      AHitInfo := FMouseDownHitInfo
    else
      AHitInfo := FHitInfo;
    if AHitInfo.HitTest = htLevel then
    begin
      CheckLevel(ViewInfo.Rows[I], (AHitInfo.RowIndex = I));
      CheckView(ViewInfo.Rows[I], False);
    end
    else
      if AHitInfo.HitTest = htView then
      begin
        CheckLevel(ViewInfo.Rows[I], False);
        CheckView(ViewInfo.Rows[I], (AHitInfo.RowIndex = I));
      end
      else
      begin
        CheckLevel(ViewInfo.Rows[I], False);
        CheckView(ViewInfo.Rows[I], False);
      end;
  end;
end;

procedure TcxGridStructureControl.ClearSelection;
begin
  AddToSelection(nil, True);
end;

procedure TcxGridStructureControl.SetGrid(Value: TcxCustomGrid);
begin
  if FGrid <> Value then
  begin
    FGrid := Value;
    Changed;
  end;
end;

procedure TcxGridStructureControl.SetMultiSelect(Value: Boolean);
begin
  if FMultiSelect <> Value then
  begin
    FMultiSelect := Value;
    ClearSelection;
  end;
end;

procedure TcxGridStructureControl.SetSelectOneItem(Value: Boolean);
begin
  if FSelectOneItem <> Value then
  begin
    FSelectOneItem := Value;
    ClearSelection;
  end;
end;

{ TcxGridStructureHelper }

constructor TcxGridStructureHelper.Create(AStructureControl: TcxGridStructureControl);
begin
  inherited Create;
  FStructureControl := AStructureControl;
  FStructureControl.OnMouseDown := StructureControlMouseDown;
end;

destructor TcxGridStructureHelper.Destroy;
begin
  FreeAndNil(FPopupMenu);
  inherited Destroy;
end;

procedure TcxGridStructureHelper.StructureControlMouseDown(Sender: TObject; Button:
  TMouseButton; Shift: TShiftState; X, Y: Integer);

  function CreateMenuItem(const ACaption: string; AEnabled: Boolean; AOnClick: TNotifyEvent): TMenuItem;
  begin
    Result := TMenuItem.Create(FPopupMenu);
    Result.Caption := ACaption;
    Result.Enabled := AEnabled;
    Result.OnClick := AOnClick;
  end;

  procedure PrepareViewSubMenu(AMenuItem: TMenuItem);
  var
    I: Integer;
  begin
    for I := 0 to cxGridRegisteredViews.Count - 1 do
      AMenuItem.Add(CreateMenuItem(cxGridRegisteredViews.Descriptions[I], True, CreateViewClick));
  end;

  function IsViewEmpty(AView: TcxCustomGridView): Boolean;
  begin
    Result := AView.DataController.ItemCount = 0;
  end;

  procedure PrepareGridMenu;
  begin
    FPopupMenu.Items.Add(CreateMenuItem('Add Level', True, CreateLevelClick));
  end;

  procedure PrepareLevelMenu;
  var
    AMenuItem: TMenuItem;
  begin
    AMenuItem := CreateMenuItem('Create View', True, nil);
    FPopupMenu.Items.Add(AMenuItem);
    PrepareViewSubMenu(AMenuItem);
    PrepareGridMenu;
    FPopupMenu.Items.Add(CreateMenuItem('-', True, nil));
    FPopupMenu.Items.Add(CreateMenuItem('Delete Level', True, DeleteLevelClick));
  end;

  procedure PrepareViewMenu;
  begin
    if IsViewDataBound(FPopupMenuLevel.GridView) then
    begin
      if IsViewDataLinked(FPopupMenuLevel.GridView) then
        FPopupMenu.Items.Add(CreateMenuItem('Create All Columns', True, CreateAllItemsClick))
      else
        FPopupMenu.Items.Add(CreateMenuItem('(no data linked)', False, nil));
      FPopupMenu.Items.Add(CreateMenuItem('-', True, nil));
      FPopupMenu.Items.Add(CreateMenuItem('Delete All Columns',
        not IsViewEmpty(FPopupMenuLevel.GridView), DeleteAllItemsClick));
    end;
    FPopupMenu.Items.Add(CreateMenuItem('Delete View', True, DeleteViewClick));
    FPopupMenu.Items.Add(CreateMenuItem('-', True, nil));
    FPopupMenu.Items.Add(CreateMenuItem('Set As Default', True, SetAsDefaultClick));
    FPopupMenu.Items.Add(CreateMenuItem('Edit Layout...', True, EditViewLayoutClick));
  end;

var
  AHitInfo: TcxGridStructureControlHitInfo;
  P: TPoint;
begin
  if Button <> mbRight then Exit;
  P := Point(X, Y);
  AHitInfo := FStructureControl.GetHitInfo(P);
  if AHitInfo.HitTest <> htNowhere then
  begin
    if FPopupMenu = nil then
      FPopupMenu := TPopupMenu.Create(nil);
    while FPopupMenu.Items.Count > 0 do
      FPopupMenu.Items[0].Free;
    FPopupMenuLevel := FStructureControl.GetLevelByRowIndex(AHitInfo.RowIndex);
    if FPopupMenuLevel <> nil then
    begin
      if TcxGridLevelAccess(FPopupMenuLevel).IsRoot then
        PrepareGridMenu
      else
      begin
        if AHitInfo.HitTest = htLevel then
          PrepareLevelMenu
        else
          PrepareViewMenu;
      end;
      P := FStructureControl.ClientToScreen(P);
//TODO:!      FStructureControl.Cursor := crHourGlass;
      FPopupMenu.Popup(P.X, P.Y);
      FStructureControl.CancelPressed(Point(X, Y));
    end;
  end;
end;

procedure TcxGridStructureHelper.UpdateDesigner;
begin
  if Assigned(FOnUpdateDesigner) then
    FOnUpdateDesigner(Self);
end;

procedure TcxGridStructureHelper.CreateAllItemsClick(Sender: TObject);
begin
  if FPopupMenuLevel.GridView.DataController is TcxDBDataController then
  begin
    CreateViewAllItems(StructureControl.Grid.Owner, FPopupMenuLevel.GridView);
    UpdateDesigner;
  end;
end;

procedure TcxGridStructureHelper.CreateLevelClick(Sender: TObject);
var
  ALevel: TcxGridLevel;
begin
  StructureControl.BeginUpdate;
  try
    ALevel := FPopupMenuLevel.Add;
    ALevel.Name := GenLevelName(StructureControl.Grid, ALevel);
    UpdateDesigner;
  finally
    StructureControl.EndUpdate;
  end;
end;

procedure TcxGridStructureHelper.CreateViewClick(Sender: TObject);

  procedure CreateView(AViewClass: TcxCustomGridViewClass);
  var
    AView: TcxCustomGridView;
  begin
    StructureControl.BeginUpdate;
    try
      AView := StructureControl.Grid.CreateView(AViewClass);
      AView.Name := GenViewName(StructureControl.Grid, AView);
      RestoreViewFromTemplate(GetViewTemplateRegKey, AView);
      FPopupMenuLevel.GridView := AView;
      UpdateDesigner;
    finally
      StructureControl.EndUpdate;
    end;
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

procedure TcxGridStructureHelper.DeleteAllItemsClick(Sender: TObject);
begin
  if FPopupMenuLevel.GridView is TcxCustomGridTableView then
  begin
    (FPopupMenuLevel.GridView as TcxCustomGridTableView).ClearItems;
    UpdateDesigner;
  end;
end;

procedure TcxGridStructureHelper.DeleteLevelClick(Sender: TObject);
begin
  StructureControl.BeginUpdate;
  try
    FPopupMenuLevel.Free;
    UpdateDesigner;
  finally
    StructureControl.EndUpdate;
  end;
end;

procedure TcxGridStructureHelper.DeleteViewClick(Sender: TObject);
begin
  StructureControl.BeginUpdate;
  try
    FPopupMenuLevel.GridView.Free;
    UpdateDesigner;
  finally
    StructureControl.EndUpdate;
  end;
end;

procedure TcxGridStructureHelper.EditViewLayoutClick(Sender: TObject);
begin
  if ShowGridViewLayoutEditor(FPopupMenuLevel.GridView) then
    UpdateDesigner;
end;

procedure TcxGridStructureHelper.SetAsDefaultClick(Sender: TObject);
begin
  SaveViewToTemplate(GetViewTemplateRegKey, FPopupMenuLevel.GridView);
end;

{ TcxGridStructureNavigator }

constructor TcxGridStructureNavigator.Create(AGrid: TcxCustomGrid);
begin
  inherited;
  FStructureControl := TcxGridStructureControl.Create(Self);
  with FStructureControl do
  begin
    SetBounds(0, 0, 0, 0);
    Grid := Self.Grid;
    OnSelectComponent := Self.SelectComponent;
    Parent := Self;
  end;
  FStructureHelper := TcxGridStructureHelper.Create(FStructureControl);
  FStructureHelper.OnUpdateDesigner := UpdateDesigner;
  FCloseButton := TSpeedButton.Create(Self);
  with FCloseButton do
  begin
    CreateCloseBitmap(Glyph);
    Flat := True;
    SetBounds(0, 0, 0, 0);
    OnClick := CloseButtonClick;
    Parent := Self;
  end;
  FCustomizeButton := TSpeedButton.Create(Self);
  with FCustomizeButton do
  begin
    Caption := SCustomizeText;
    Flat := True;
    SetBounds(0, 0, 0, 0);
    OnClick := CustomizeButtonClick;
    Parent := Self;
  end;
  FSeparator := TBevel.Create(Self);
  with FSeparator do
  begin
    Shape := bsTopLine;
    SetBounds(0, 0, 0, 0);
    Parent := Self;
  end;
  CreateDefaultComponents;
end;

destructor TcxGridStructureNavigator.Destroy;
begin
  FreeAndNil(FStructureHelper);
  inherited Destroy;
end;

procedure TcxGridStructureNavigator.BeforeGridLoading;
begin
  FreeAndNil(FDefaultLevel);
  FreeAndNil(FDefaultView);
end;

procedure TcxGridStructureNavigator.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  // Border
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := clWindowFrame;
  Canvas.FrameRect(R, clDefault, FrameBorderSize, [bTop]);
  Inc(R.Top, FrameBorderSize);
  Canvas.FrameRect(R, clDefault, FrameBorderSize, [bLeft, bBottom, bRight]);
  Inc(R.Left);
  Dec(R.Right);
  Dec(R.Bottom);
  // Bk
  Canvas.Brush.Color := FStructureControl.ViewInfo.GetContentColor; // clWindow;
  Canvas.FillRect(R);
end;

(*
procedure TcxGridStructureNavigator.Calculate;
var
  R: TRect;
  ACanvas: TcxCanvas;
  ACloseButtonSize: TSize;
  ACloseButtonArea: TRect;
  ACustomizeButtonArea: TRect;
  ASeparatorArea: TRect;
  ASeparatorHeight: Integer;
begin
  FStructureControl.ViewInfo.Calculate;
  R := FStructureControl.ViewInfo.Bounds;
  OffsetRect(R, FrameBorderSize, FrameBorderSize);
  FStructureControl.BoundsRect := R;
  // Calc Customize Button
  ASeparatorHeight := ButtonOffset * 2;
  ACanvas := FStructureControl.ViewInfo.Canvas;
  ACanvas.Font := FCustomizeButton.Font;
  ACloseButtonSize.cx := 2 * TextOffset + ACanvas.TextWidth(SCustomizeText) + 2 * ButtonBorderSize;
  ACloseButtonSize.cy := 2 * TextOffset + ACanvas.TextHeight(SCustomizeText) + 2 * ButtonBorderSize;
  ACustomizeButtonArea := Rect(R.Left, R.Bottom + ASeparatorHeight, R.Left + 2 * ButtonOffset + ACloseButtonSize.cx,
    R.Bottom + ASeparatorHeight + 2 * ButtonOffset + ACloseButtonSize.cy);
  FCustomizeButton.SetBounds(ACustomizeButtonArea.Left + ButtonOffset,
    ACustomizeButtonArea.Top + ButtonOffset, ACloseButtonSize.cx, ACloseButtonSize.cy);
  ASeparatorArea := Rect(ACustomizeButtonArea.Left, ACustomizeButtonArea.Top - ASeparatorHeight,
    ACustomizeButtonArea.Right, ACustomizeButtonArea.Top);
  if R.Right < ACustomizeButtonArea.Right then
    R.Right := ACustomizeButtonArea.Right;
  FSeparator.BoundsRect := Rect(ASeparatorArea.Left + ButtonOffset,
    ASeparatorArea.Top + ButtonOffset, R.Right - ButtonOffset,
    ASeparatorArea.Bottom);
  // Calc Close Button
  ACloseButtonArea := Rect(R.Right, R.Top,
    R.Right + 2 * ButtonOffset + CloseButtonWidth + 2 * ButtonBorderSize,
    R.Top + 2 * ButtonOffset + CloseButtonHeight + 2 * ButtonBorderSize);
  FCloseButton.SetBounds(ACloseButtonArea.Left + ButtonOffset,
    ACloseButtonArea.Top + ButtonOffset, CloseButtonWidth + 2 * ButtonBorderSize,
    CloseButtonHeight + 2 * ButtonBorderSize);
  if R.Bottom < ACloseButtonArea.Bottom then
    R.Bottom := ACloseButtonArea.Bottom;
  // Total Area
  R.Right := ACloseButtonArea.Right;
  R.Bottom := ACustomizeButtonArea.Bottom;
  InflateRect(R, FrameBorderSize, FrameBorderSize);
  SetBounds(Left, Top, R.Right - R.Left, R.Bottom - R.Top);
end;
*)

procedure TcxGridStructureNavigator.Calculate;
var
  R: TRect;
  ACanvas: TcxCanvas;
  ACloseButtonSize: TSize;
//  ACloseButtonArea: TRect;
  ACustomizeButtonArea: TRect;
  ASeparatorArea: TRect;
  ASeparatorHeight: Integer;
begin
  FStructureControl.ViewInfo.Calculate;
  R := FStructureControl.ViewInfo.Bounds;
  OffsetRect(R, FrameBorderSize, FrameBorderSize);
  FStructureControl.BoundsRect := R;
  // Calc Customize Button
  ASeparatorHeight := ButtonOffset * 2;
  ACanvas := FStructureControl.ViewInfo.Canvas;
  ACanvas.Font := FCustomizeButton.Font;
  ACloseButtonSize.cx := 2 * TextOffset + ACanvas.TextWidth(SCustomizeText) + 2 * ButtonBorderSize;
  ACloseButtonSize.cy := 2 * TextOffset + ACanvas.TextHeight(SCustomizeText) + 2 * ButtonBorderSize;
  ACustomizeButtonArea := Rect(R.Left, R.Bottom + ASeparatorHeight, R.Left + 2 * ButtonOffset + ACloseButtonSize.cx,
    R.Bottom + ASeparatorHeight + 2 * ButtonOffset + ACloseButtonSize.cy);
  FCustomizeButton.SetBounds(ACustomizeButtonArea.Left + ButtonOffset,
    ACustomizeButtonArea.Top + ButtonOffset, ACloseButtonSize.cx, ACloseButtonSize.cy);
  ASeparatorArea := Rect(ACustomizeButtonArea.Left, ACustomizeButtonArea.Top - ASeparatorHeight,
    ACustomizeButtonArea.Right, ACustomizeButtonArea.Top);
  if R.Right < ACustomizeButtonArea.Right then
    R.Right := ACustomizeButtonArea.Right;
  FSeparator.BoundsRect := Rect(ASeparatorArea.Left + ButtonOffset,
    ASeparatorArea.Top + ButtonOffset, R.Right - ButtonOffset,
    ASeparatorArea.Bottom);
  {// Calc Close Button
  ACloseButtonArea := Rect(R.Right, R.Top,
    R.Right + 2 * ButtonOffset + CloseButtonWidth + 2 * ButtonBorderSize,
    R.Top + 2 * ButtonOffset + CloseButtonHeight + 2 * ButtonBorderSize);
  FCloseButton.SetBounds(ACloseButtonArea.Left + ButtonOffset,
    ACloseButtonArea.Top + ButtonOffset, CloseButtonWidth + 2 * ButtonBorderSize,
    CloseButtonHeight + 2 * ButtonBorderSize);
  if R.Bottom < ACloseButtonArea.Bottom then
    R.Bottom := ACloseButtonArea.Bottom;
  // Total Area
  R.Right := ACloseButtonArea.Right;
  }
  R.Bottom := ACustomizeButtonArea.Bottom;
  InflateRect(R, FrameBorderSize, FrameBorderSize);
  SetBounds(Left, Top, R.Right - R.Left, R.Bottom - R.Top);
end;

function TcxGridStructureNavigator.CalculateBoundsRect: TRect;
begin
  Result := Rect(0, 0, Width, Height);
  OffsetRect(Result, Grid.ClientBounds.Right - Result.Right - NavigatorOffset,
    Grid.ClientBounds.Bottom - Result.Bottom - NavigatorOffset);
end;

procedure TcxGridStructureNavigator.Changed;
begin
  Calculate;
  inherited Changed;
  FStructureControl.Invalidate;
  NotifyEditors;
end;

procedure TcxGridStructureNavigator.CreateDefaultComponents;
const
  SDefaultViewClass = 'TcxGridDBTableView'; // TODO
var
  AViewClass: TcxCustomGridViewClass;
begin
  AViewClass := TcxCustomGridViewClass(cxGridRegisteredViews.FindByClassName(SDefaultViewClass));
  if AViewClass <> nil then
  begin
    FDefaultView := Grid.CreateView(AViewClass);
    FDefaultView.Name := GenViewName(Grid, FDefaultView);
    RestoreViewFromTemplate(GetViewTemplateRegKey, FDefaultView);
    // TODO: load default
    FDefaultLevel := Grid.Levels.Add;
    FDefaultLevel.Name := GenLevelName(Grid, FDefaultLevel);
    FDefaultLevel.GridView := FDefaultView;
  end;
end;

function TcxGridStructureNavigator.GetDesigner: {$IFDEF DELPHI6}IDesigner{$ELSE}IFormDesigner{$ENDIF};
begin
  Result := GetParentForm(Grid).Designer as {$IFDEF DELPHI6}IDesigner{$ELSE}IFormDesigner{$ENDIF};
end;

procedure TcxGridStructureNavigator.NotifyEditors;
var
  Msg: TMsg;
begin
  if not HandleAllocated then Exit;
  if not PeekMessage(Msg, Handle, DXM_REFRESHCUSTOMIZATION, DXM_REFRESHCUSTOMIZATION, PM_NOREMOVE) then
    PostMessage(Handle, DXM_REFRESHCUSTOMIZATION, 0, 0);
end;

procedure TcxGridStructureNavigator.CloseButtonClick(Sender: TObject);
begin
  // TODO:
//  Visible := False;
end;

procedure TcxGridStructureNavigator.CustomizeButtonClick(Sender: TObject);
begin
  // TODO:
  if GetDesigner <> nil then
    ShowGridEditor(GetDesigner, Grid);
end;

procedure TcxGridStructureNavigator.SelectComponent(Sender: TObject; AComponent: TComponent);
begin
  if GetDesigner <> nil then
    GetDesigner.SelectComponent(AComponent);
end;

procedure TcxGridStructureNavigator.UpdateDesigner(Sender: TObject);
begin
  if GetDesigner <> nil then
    GetDesigner.Modified;
end;

procedure TcxGridStructureNavigator.CMDeferUpdate(var Message);
begin
  UpdateDesignFormEditors(Grid);
end;

initialization
  cxGridStructureNavigatorClass := TcxGridStructureNavigator;

end.
