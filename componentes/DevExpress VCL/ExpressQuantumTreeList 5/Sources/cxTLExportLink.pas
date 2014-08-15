{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumTreeList                                       }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMTREELIST AND ALL        }
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

unit cxTLExportLink;

{$I cxVer.inc}

interface

uses
  Windows, Graphics, cxGeometry, Variants, Types, SysUtils, Classes, Contnrs,
  dxCore, cxControls, cxClasses, cxGraphics, cxInplaceContainer, cxTL, cxTLStrs,
  cxExport, cxXLSExport, cxHtmlXmlTxtExport, cxMaskEdit;

procedure cxExportTLToHTML(const AFileName: string; ATreeList: TcxCustomTreeList;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const AFileExt: string = 'html');
procedure cxExportTLToXML(const AFileName: string; ATreeList: TcxCustomTreeList;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const AFileExt: string = 'xml');
procedure cxExportTLToExcel(const AFileName: string; ATreeList: TcxCustomTreeList;
  AExpand: Boolean = True; ASaveAll: Boolean = True; AUseNativeFormat: Boolean = True;
  const AFileExt: string = 'xls');
procedure cxExportTLToText(const AFileName: string; ATreeList: TcxCustomTreeList;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const ASeparator: string = '';
  const ABeginString: string = ''; const AEndString: string = '';
  const AFileExt: string = 'txt');
procedure cxExportTLToFile(AFileName: string; ATreeList: TcxCustomTreeList;
  AExportType: Integer; AExpand, ASaveAll, AUseNativeFormat: Boolean;
  const ASeparators: array of string; const AFileExt: string);

implementation

uses
  Math, cxEdit, cxDataUtils, cxCalendar, cxCurrencyEdit, cxSpinEdit,
  cxCalc, cxTimeEdit;

type
  TcxTreeListBandAccess = class(TcxTreeListBand);
  TcxCustomViewInfoItemAccess = class(TcxCustomViewInfoItem);
  TcxCustomEditPropertiesAccess = class(TcxCustomEditProperties);
  TcxTreeListAccess = class(TcxCustomTreeList);
  TcxTreeListEditCellViewInfoAccess = class(TcxTreeListEditCellViewInfo);

  { TcxTreeListExportViewInfo }

  TcxTreeListExportViewInfo = class(TcxTreeListViewInfo)
  private
    FNodes: TList;
  protected
    procedure AfterCalculate; override;
    procedure BeforeCalculate; override;
    procedure CalculateBackgroundParts; override;
    procedure CalculateNodesOrigin; override;
    procedure CalculateNodesViewData; override;
    procedure CorrectBorders; override;
    function GetContentBounds: TRect; override;
    function GetIsIndicatorVisible: Boolean; override;
    function GetIsPrinting: Boolean; override;
    procedure UpdateScrollBars; override;
  public
    constructor CreateEx(ATreeList: TcxCustomTreeList; ANodes: TList); virtual;

    property Nodes: TList read FNodes;
  end;

  TcxExportVisualItem = class
  public
    Bounds: TRect;
    Borders: TcxBorders;
    Data: TObject;
    DisplayText: string;
    IsBackground: Boolean;
    Style: Integer;
    Value: Variant;
  end;

  TcxItemVisualInfo = class
  public
    Alignment: TAlignment;
    BorderColor: TColor;
    Borders: TcxBorders;
    FontSize: Integer;
    ViewParams: TcxViewParams;
  end;

  TcxExportVisualItemClass = class of TcxExportVisualItem;

  { TcxTreeListExportHelper }

  TcxTreeListExportHelper = class
  private
    FColumnHeadersList: TcxObjectList;
    FColumns: TcxExportScale;
    FDefaultRowHeight: Integer;
    FDefaultStyle: TcxCacheCellStyle;
    FDefaultStyleIndex: Integer;
    FExpand: Boolean;
    FIsNativeFormat: Boolean;
    FNodes: TList;
    FProvider: IcxExportProvider;
    FRows: TcxExportScale;
    FSaveAll: Boolean;
    FTreeList: TcxTreeListAccess;
    FViewInfo: TcxTreeListExportViewInfo;
    FVisualInfo: TcxItemVisualInfo;
    FVisualItemsList: TcxObjectList;
    function GetCells: TcxCustomControlCells;
    function GetColumnHeader(AIndex: Integer): TcxExportVisualItem;
    function GetColumnHeaderCount: Integer;
    function GetIncludeParentNodes: Boolean;
    function GetVisualItem(AIndex: Integer): TcxExportVisualItem;
    function GetVisualItemCount: Integer;
  protected
    function AddVisualItem(AItemClass: TcxExportVisualItemClass; const ABounds: TRect): TcxExportVisualItem;
    function AddVisualItemEx(const AItemBounds: TRect; const ADisplayText: string;
      AVisualInfo: TcxItemVisualInfo; AIsBackground: Boolean = False): TcxExportVisualItem; overload;
    function AddVisualItemEx(const AItemBounds: TRect; const ADisplayText: string;
      AStyle: Integer; AIsBackground: Boolean = False): TcxExportVisualItem; overload;
    function CanHasBorders(ACell: TcxCustomViewInfoItem): Boolean;
    procedure CreateExportCache;
    procedure CreateExportCells;
    procedure ExportCells;
    procedure ExtractNodesForExport;
    procedure FillArea(const ABounds: TRect; AStyleIndex: Integer;
      ABorderColor: TColor = clDefault; ABorders: TcxBorders = cxBordersAll);
    procedure FillRealArea(const ABounds: TRect; AStyleIndex: Integer;
      ABorderColor: TColor = clDefault; ABorders: TcxBorders = cxBordersAll);
    function GetCellVisualInfo(ACell: TcxCustomViewInfoItem): TcxItemVisualInfo;
    function HasAllBorders(ACell: TcxCustomViewInfoItem): Boolean;
    function IsNativeFormatProperties(AProperties: TcxCustomEditProperties): Boolean;
    function IsBackgroundCell(ACell: TcxCustomViewInfoItem): Boolean;
    function IsEmpty: Boolean;
    procedure ProcessExportCells;
    procedure RealBoundsToLogicalBounds(const ABounds: TRect;
      out ALogicalBounds: TRect);
    procedure RealBoundsToLogicalBoundsEx(const ABounds, ASearchArea: TRect;
      out ALogicalBounds: TRect);
    procedure RegisterStyles;
    procedure SetCellAsGraphic(AColumn, ARow: Integer; AGraphic: TGraphic);
    procedure SetRealCellStyleAndValue(const ARealBounds, ASearchArea: TRect;
      AStyleIndex: Integer; const AValue: Variant);
    procedure SetRealCellStyleAndValueEx(const ARealBounds, ASearchArea: TRect;
      AStyleIndex: Integer; AGraphic: TGraphic; AValue: Variant);
    function SkipExportCell(ACell: TcxCustomViewInfoItem): Boolean;
    procedure ViewParamsToExportStyle(const AViewParams: TcxViewParams;
      var AExportStyle: TcxCacheCellStyle; const AAlignment: TAlignment = taLeftJustify;
      ABorders: TcxBorders = []; ABorderColor: TColor = clDefault; AFontSize: Integer = 0);

    property Cells: TcxCustomControlCells read GetCells;
    property DefaultRowHeight: Integer read FDefaultRowHeight write FDefaultRowHeight;
    property DefaultStyle: TcxCacheCellStyle read FDefaultStyle write FDefaultStyle;
    property DefaultStyleIndex: Integer read FDefaultStyleIndex write FDefaultStyleIndex;
  public
    constructor Create(ATreeList: TcxCustomTreeList;
      AExportType: Integer; const AFileName: string); virtual;
    destructor Destroy; override;
    procedure DoExport;
    property ColumnHeaderCount: Integer read GetColumnHeaderCount;
    property ColumnHeaders[Index: Integer]: TcxExportVisualItem read GetColumnHeader;
    property Columns: TcxExportScale read FColumns;
    property Expand: Boolean read FExpand write FExpand;
    property IncludePrentNodes: Boolean read GetIncludeParentNodes;
    property IsNativeFormat: Boolean read FIsNativeFormat write FIsNativeFormat;
    property Provider: IcxExportProvider read FProvider;
    property Rows: TcxExportScale read FRows;
    property SaveAll: Boolean read FSaveAll write FSaveAll;
    property TreeList: TcxTreeListAccess read FTreeList;
    property VisualItemCount: Integer read GetVisualItemCount;
    property VisualItems[Index: Integer]: TcxExportVisualItem read GetVisualItem;
  end;

const
  cxDefaultRowHeight   = 19;
  cxInvalidIndex       = -1;
  cxIndentFontName     = 'Tahoma';
  vsBackground         = 0;

  AlignToCxAlign: array[TAlignment] of TcxAlignText = (catLeft, catRight, catCenter);
  BorderWidths: array[Boolean] of Integer = (0, 1);

{ TcxTreeListExportViewInfo }

constructor TcxTreeListExportViewInfo.CreateEx(
  ATreeList: TcxCustomTreeList; ANodes: TList);
begin
  inherited Create(ATreeList);
  FNodes := ANodes;
end;

procedure TcxTreeListExportViewInfo.AfterCalculate;
begin
end;

procedure TcxTreeListExportViewInfo.BeforeCalculate;
var
  R: TRect; 
  I: Integer;
begin
  inherited BeforeCalculate;
  R := cxRect(0, 0, 0, 200);
  for I := 0 to Bands.BottomItemCount - 1 do
    Inc(R.Right, Bands.BottomItems[I].DisplayWidth);
  if Bands.VisibleLeftFixedCount > 0 then
    Inc(R.Right, OptionsView.FixedSeparatorWidth);
  if Bands.VisibleRightFixedCount > 0 then
    Inc(R.Right, OptionsView.FixedSeparatorWidth);
  Bounds := R;
  GridLines := [];
end;

procedure TcxTreeListExportViewInfo.CalculateBackgroundParts;
begin
end;

procedure TcxTreeListExportViewInfo.CalculateNodesOrigin;
begin
end;

procedure TcxTreeListExportViewInfo.CalculateNodesViewData;
var
  AOffset, I, J: Integer;
  ANode: TcxTreeListNode;
  ACell: TcxCustomViewInfoItemAccess;
  ACells: TcxCustomControlCells;
  AViewData: TcxTreeListNodeViewData;
begin
  ContentHeight := MaxInt;
  ACells := Cells;
  AOffset := HeadersHeight + BandsHeight; 
  for I := 0 to Nodes.Count - 1 do
  begin
    ANode := TcxTreeListNode(Nodes[I]);
    AViewData := AddNodeViewData(ANode, False);
    for J := 0 to Cells.Count - 1 do
    begin
      ACell := TcxCustomViewInfoItemAccess(Cells[J]);
      ACell.CheckVisibleInfo;
      OffsetRect(ACell.DisplayRect, 0, AOffset);
      OffsetRect(ACell.VisibleBounds, 0, AOffset);
    end;
    ACells.Count := ACells.Count + Cells.Count;
    Move(Cells.List^, ACells.List^[ACells.Count -
      Cells.Count], Cells.Count * SizeOf(Integer));
    Inc(AOffset, AViewData.Height);
    Cells.Count := 0;
    Cells := ACells
  end;
  ContentHeight := AOffset;
  Bounds := cxRectSetHeight(Bounds, AOffset + FooterHeight);
  CalculateNodesOrigin;   
  ContentHeight := HeadersHeight + BandsHeight;
end;

procedure TcxTreeListExportViewInfo.CorrectBorders;
begin
end;

function TcxTreeListExportViewInfo.GetContentBounds: TRect;
begin
  Result := inherited GetContentBounds;
end;

function TcxTreeListExportViewInfo.GetIsIndicatorVisible: Boolean;
begin
  Result := False;
end;

function TcxTreeListExportViewInfo.GetIsPrinting: Boolean;
begin
  Result := True; 
end;

procedure TcxTreeListExportViewInfo.UpdateScrollBars;
begin
end;

{ TcxTreeListExportHelper }

constructor TcxTreeListExportHelper.Create(ATreeList: TcxCustomTreeList;
  AExportType: Integer; const AFileName: string);

  function DefaultStyle: TcxCacheCellStyle;
  begin
    ViewParamsToExportStyle(TreeList.Styles.GetBackgroundParams, Result);
  end;

begin
  FTreeList := TcxTreeListAccess(ATreeList);
  TcxExport.Provider(AExportType, AFileName).GetInterface(IcxExportProvider, FProvider);
  FProvider.SetDefaultStyle(DefaultStyle);
  FVisualItemsList := TcxObjectList.Create;
  FColumnHeadersList := TcxObjectList.Create(False);
  FColumns := TcxExportScale.Create;
  FRows := TcxExportScale.Create;
  FDefaultRowHeight := cxDefaultRowHeight;
  FVisualInfo := TcxItemVisualInfo.Create;
end;

destructor TcxTreeListExportHelper.Destroy;
begin
  try
    FVisualInfo.Free;
    FProvider := nil;
    FreeAndNil(FVisualItemsList);
    FreeAndNil(FColumnHeadersList);
    FreeAndNil(FColumns);
    FreeAndNil(FRows);
  finally
    inherited Destroy;
  end;
end;

procedure TcxTreeListExportHelper.DoExport;
begin
  CreateExportCache;
  Provider.Commit;
end;

function TcxTreeListExportHelper.AddVisualItem(
  AItemClass: TcxExportVisualItemClass; const ABounds: TRect): TcxExportVisualItem;
begin
  Result := AItemClass.Create();
  Result.Style := -1;
  Result.Bounds := ABounds;
  with ABounds do
  begin
    Columns.AddPairs(Left, Right);
    Rows.AddPairs(Top, Bottom);
  end;
  FVisualItemsList.Add(Result);
end;

function TcxTreeListExportHelper.AddVisualItemEx(const AItemBounds: TRect;
  const ADisplayText: string; AVisualInfo: TcxItemVisualInfo;
  AIsBackground: Boolean = False): TcxExportVisualItem;
var
  ASide: TcxBorder;
  AStyle: TcxCacheCellStyle;
begin
  ViewParamsToExportStyle(AVisualInfo.ViewParams, AStyle, AVisualInfo.Alignment,
    [], clDefault, AVisualInfo.FontSize);
  if (AVisualInfo.BorderColor <> clDefault) and not AIsBackground then
  begin
    for ASide := bLeft to bBottom do
      if ASide in AVisualInfo.Borders then
      begin
        AStyle.Borders[Integer(ASide)].IsDefault := False;
        AStyle.Borders[Integer(ASide)].Color := ColorToRgb(AVisualInfo.BorderColor);
        AStyle.Borders[Integer(ASide)].Width := 1;
      end;
  end;
  Result := AddVisualItemEx(AItemBounds, ADisplayText,
    Provider.RegisterStyle(AStyle), AIsBackground);
  Result.Borders := AVisualInfo.Borders; 
end;

function TcxTreeListExportHelper.AddVisualItemEx(
  const AItemBounds: TRect; const ADisplayText: string;
  AStyle: Integer; AIsBackground: Boolean = False): TcxExportVisualItem;
begin
  Result := AddVisualItem(TcxExportVisualItem, AItemBounds);
  Result.Bounds := AItemBounds;
  Result.IsBackground := AIsBackground;
  Result.DisplayText := ADisplayText;
  Result.Style := AStyle;
end;

function TcxTreeListExportHelper.CanHasBorders(ACell: TcxCustomViewInfoItem): Boolean;
begin
  Result := (ACell is TcxTreeListBandCellViewInfo) or (ACell is TcxTreeListCustomHeaderCellViewInfo) or 
   (ACell is TcxTreeListEditCellViewInfo) or (ACell is TcxTreeListFooterCellViewInfo);
end;

procedure TcxTreeListExportHelper.CreateExportCache;
begin
  ExtractNodesForExport;
  RegisterStyles;
  CreateExportCells;
end;

function cxCompareItems(AItem1, AItem2: TcxExportVisualItem): Integer;
begin
  Result := Byte(AItem2.IsBackground) - Byte(AItem1.IsBackground);
end;

procedure TcxTreeListExportHelper.CreateExportCells;
var
  I: Integer;
begin
  TreeList.BeginUpdate;
  try
    FViewInfo := TcxTreeListExportViewInfo.CreateEx(TreeList, FNodes);
    try
      FViewInfo.Calculate;
      for I := 0 to Cells.Count - 1 do
        Cells[I].CheckVisibleInfo;
      FVisualItemsList.Capacity := Cells.Count;
      ProcessExportCells;
      FVisualItemsList.Sort(@cxCompareItems);
    finally
      FreeAndNil(FViewInfo);
    end;
  finally
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListExportHelper.ExportCells;

  procedure DrawImage(AItem: TcxExportVisualItem; const ASearchArea: TRect);
  var
    ABitmap: TBitmap;
    AIndent: TcxTreeListIndentCellViewInfo;
  begin
    AIndent := TcxTreeListIndentCellViewInfo(AItem.Data);
    if AIndent.Images <> nil then
    begin
      ABitmap := TBitmap.Create;
      try
        ABitmap.Width := AIndent.Images.Width;
        ABitmap.Height := AIndent.Images.Height;
        with TcxCanvas.Create(ABitmap.Canvas) do
        try
          FillRect(Rect(0, 0, ABitmap.Width, ABitmap.Height), AIndent.ViewParams);
        finally
          Free;
        end;
        AIndent.Images.Draw(ABitmap.Canvas, 0, 0, AIndent.ImageIndex);
        AIndent.Images.Draw(ABitmap.Canvas, 0, 0, AIndent.OverlayIndex);
        SetRealCellStyleAndValueEx(AItem.Bounds, ASearchArea, AItem.Style, ABitmap, Null);
      finally
        ABitmap.Free;
      end;
    end;
  end;

var
  I: Integer;
  AItem: TcxExportVisualItem;
  R: TRect;
begin
  FVisualItemsList.Sort(@cxCompareItems);
  for I := 0 to Columns.VisibleCount - 1 do
    Provider.SetColumnWidth(I, Columns.Delta[I]);
  for I := 0 to Rows.VisibleCount - 1 do
  begin
    if Rows.Delta[I] <> DefaultRowHeight then
      Provider.SetRowHeight(I, Rows.Delta[I]);
  end;
  FillArea(Rect(0, 0, Columns.Count - 1, Rows.Count - 1),  DefaultStyleIndex);
  R := Rect(0, 0, Columns.Count - 1, Rows.Count - 1);
  for I := 0 to VisualItemCount - 1 do
  begin
    AItem := VisualItems[I];
    if cxRectIsEmpty(AItem.Bounds) then Continue;
    if AItem.IsBackground then
      FillRealArea(AItem.Bounds, AItem.Style, clBtnShadow, AItem.Borders)
    else
      if AItem.Data is TcxTreeListNode then
        SetRealCellStyleAndValue(AItem.Bounds, R, AItem.Style, AItem.Value) 
      else
        if (AItem.Data is TcxTreeListIndentCellViewInfo) and TcxTreeListIndentCellViewInfo(AItem.Data).HasImage then
          DrawImage(AItem, R)
        else
          SetRealCellStyleAndValue(AItem.Bounds, R, AItem.Style, AItem.DisplayText); 
  end;
end;

procedure TcxTreeListExportHelper.ExtractNodesForExport;
var
  ACount, I: Integer;
begin
  if SaveAll then
  begin
    repeat
      ACount := TreeList.AbsoluteVisibleCount;
      TreeList.BeginUpdate;
      try
        FNodes := TreeList.AbsoluteVisibleItemsList;
        for I := FNodes.Count - 1 downto 0 do
          if Expand and TcxTreeListNode(FNodes[I]).HasChildren then
            TcxTreeListNode(FNodes[I]).Expanded := True;
      finally
        TreeList.EndUpdate;
      end;
    until ACount = TreeList.AbsoluteVisibleCount;
  end
  else
  begin
    FNodes := TreeList.SelectionList;
  end;
end;

function TcxTreeListExportHelper.GetCellVisualInfo(
  ACell: TcxCustomViewInfoItem): TcxItemVisualInfo;
const
  ABorders: array[TcxTreeListGridLines] of TcxBorders =
   ([], [bTop, bBottom], [bLeft, bRight], cxBordersAll);
begin
  Result := FVisualInfo;
  Result.FontSize := 0;
  Result.ViewParams := ACell.ViewParams;
  Result.Borders := [];
  Result.BorderColor := clDefault;
  if ACell is TcxTreeListFooterCellViewInfo then
    Result.Alignment  := TcxTreeListFooterCellViewInfo(ACell).AlignHorz
  else
    if ACell is TcxTreeListIndentCellViewInfo then
    begin
      Result.Alignment := taCenter;
      Result.FontSize := 12;
    end
    else
      if ACell is TcxTreeListHeaderCellViewInfo then
        Result.Alignment := TcxTreeListHeaderCellViewInfo(ACell).AlignHorz
      else
        if ACell is TcxTreeListEditCellViewInfo then
          Result.Alignment := TcxTreeListEditCellViewInfoAccess(ACell).Column.PropertiesValue.Alignment.Horz
        else
          Result.Alignment := taLeftJustify;
  if CanHasBorders(ACell) then
  begin
    if HasAllBorders(ACell) then
      Result.Borders := cxBordersAll
    else
      if (ACell is TcxTreeListBandCellViewInfo) and
        (TcxTreeListBandCellViewInfo(ACell).Part in [tlbpGroupFooter, tlbpFooter]) then
      begin
        Result.Borders := cxBordersAll;
        if TcxTreeListBandCellViewInfo(ACell).Band.VisibleIndex > 0 then
          Exclude(Result.Borders, bLeft);
        if TcxTreeListBandCellViewInfo(ACell).Band.VisibleIndex < (TreeList.Bands.BottomItemCount - 1) then
          Exclude(Result.Borders, bRight);
      end
      else
        Result.Borders := ABorders[TreeList.OptionsView.GridLines];
    if Result.Borders <> [] then
      Result.BorderColor := FViewInfo.GridLineColor;
  end;
end;

function TcxTreeListExportHelper.HasAllBorders(
  ACell: TcxCustomViewInfoItem): Boolean;
begin
  Result := (ACell is TcxTreeListFooterCellViewInfo) or
    (ACell is TcxTreeListCustomHeaderCellViewInfo); 
end;

function TcxTreeListExportHelper.IsNativeFormatProperties(
  AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := IsNativeFormat and
   ((AProperties is TcxDateEditProperties) or
    (AProperties is TcxMaskEditProperties) or
    (AProperties is TcxCurrencyEditProperties) or
    (AProperties is TcxSpinEditProperties) or
    (AProperties is TcxCalcEditProperties) or
    (AProperties is TcxTimeEditProperties));
end;

procedure TcxTreeListExportHelper.FillArea(const ABounds: TRect; AStyleIndex: Integer;
  ABorderColor: TColor = clDefault; ABorders: TcxBorders = cxBordersAll);
var
  AStyle: TcxCacheCellStyle;
  I, J, AActualStyleIndex: Integer;

  procedure SetBorderStyle(ASide: TcxBorder);
  begin
    if not (ASide in ABorders) then Exit;  
    AStyle.Borders[Integer(ASide)].IsDefault := False;
    AStyle.Borders[Integer(ASide)].Width := 1;
    AStyle.Borders[Integer(ASide)].Color := ColorToRgb(ABorderColor);
  end;

begin
  for I := ABounds.Top to ABounds.Bottom - 1 do
    for J := ABounds.Left to ABounds.Right - 1 do
    begin
      AActualStyleIndex := AStyleIndex;
      if (ABorderColor <> clDefault) and (ABorders <> []) then
      begin
        AStyle := Provider.GetStyle(AStyleIndex)^;
        if J = ABounds.Left then
          SetBorderStyle(bLeft);
        if I = ABounds.Top then
          SetBorderStyle(bTop);
        if J = ABounds.Right - 1 then
          SetBorderStyle(bRight);
        if I = ABounds.Bottom - 1 then
          SetBorderStyle(bBottom);
        AActualStyleIndex := Provider.RegisterStyle(AStyle);
      end;
      Provider.SetCellStyle(J, I, AActualStyleIndex);
    end;
end;

procedure TcxTreeListExportHelper.FillRealArea(const ABounds: TRect; AStyleIndex: Integer;
  ABorderColor: TColor = clDefault; ABorders: TcxBorders = cxBordersAll);
var
  ALogicalBounds: TRect;
begin
  RealBoundsToLogicalBounds(ABounds, ALogicalBounds);
  FillArea(ALogicalBounds, AStyleIndex, ABorderColor, ABorders);
end;

function TcxTreeListExportHelper.IsBackgroundCell(
  ACell: TcxCustomViewInfoItem): Boolean;
begin
  Result := ACell is TcxTreeListBandCellViewInfo;
end;

function TcxTreeListExportHelper.IsEmpty: Boolean;
begin
  Result := (Columns.VisibleCount = 0) or (Rows.VisibleCount = 0);
end;

procedure TcxTreeListExportHelper.ProcessExportCells;
var
  I: Integer;
  ACell: TcxCustomViewInfoItem;
  AEditCell: TcxTreeListEditCellViewInfoAccess;
  AExportVisualItem: TcxExportVisualItem;
const
  AExpandChar: array[Boolean] of Char = ('+', '-');
begin
  for I := 0 to Cells.Count - 1 do
  begin
    ACell := Cells[I];
    if SkipExportCell(ACell) then Continue;
    AExportVisualItem := AddVisualItemEx(ACell.BoundsRect, '', GetCellVisualInfo(ACell), IsBackgroundCell(ACell));
    AExportVisualItem.Data := ACell;
    if ACell is TcxTreeListEditCellViewInfo then
    begin
      AEditCell := TcxTreeListEditCellViewInfoAccess(ACell);
      if IsNativeFormatProperties(AEditCell.Properties) then
      begin
        AExportVisualItem.Data := AEditCell.Node;
        AExportVisualItem.Value := AEditCell.Node.Values[AEditCell.Column.ItemIndex]
      end
      else
        AExportVisualItem.DisplayText := AEditCell.Node.Texts[AEditCell.Column.ItemIndex];
    end
    else
      if ACell is TcxTreeListIndentCellViewInfo then
      begin
        if TcxTreeListIndentCellViewInfo(ACell).Button then
          AExportVisualItem.DisplayText := AExpandChar[TcxTreeListIndentCellViewInfo(ACell).Node.Expanded];
      end
      else
        if ACell is TcxTreeListHeaderCellViewInfo then
          AExportVisualItem.DisplayText := TcxTreeListHeaderCellViewInfo(ACell).Text
        else
          if ACell is TcxTreeListFooterCellViewInfo then
            AExportVisualItem.DisplayText := TcxTreeListFooterCellViewInfo(ACell).Text;
  end;
  Columns.Arrange;
  Rows.Arrange;
  if not IsEmpty then
  begin
    Provider.SetRange(Columns.VisibleCount, Rows.VisibleCount, False);
    ExportCells;
  end;
end;

procedure TcxTreeListExportHelper.RealBoundsToLogicalBounds(
  const ABounds: TRect; out ALogicalBounds: TRect);
begin
  with ALogicalBounds do
  begin
    Columns.GetPosition(ABounds.Left, ABounds.Right, Left, Right);
    Rows.GetPosition(ABounds.Top, ABounds.Bottom, Top, Bottom);
  end;
end;

procedure TcxTreeListExportHelper.RealBoundsToLogicalBoundsEx(
  const ABounds, ASearchArea: TRect; out ALogicalBounds: TRect);
begin
  with ALogicalBounds do
  begin
    Columns.GetPositionEx(ABounds.Left, ABounds.Right,
      ASearchArea.Left, ASearchArea.Right, Left, Right);
    Rows.GetPositionEx(ABounds.Top, ABounds.Bottom,
      ASearchArea.Top, ASearchArea.Bottom, Top, Bottom);
  end;
end;

procedure TcxTreeListExportHelper.RegisterStyles;
var
  AViewParams: TcxViewParams;
begin
  TreeList.Styles.GetViewParams(vsBackground, nil,
    TreeList.Styles.BandBackground, AViewParams);
  ViewParamsToExportStyle(AViewParams, FDefaultStyle);
  Provider.SetDefaultStyle(DefaultStyle);
  DefaultStyleIndex := Provider.RegisterStyle(DefaultStyle);
end;

procedure TcxTreeListExportHelper.SetCellAsGraphic(AColumn, ARow: Integer;
  AGraphic: TGraphic);
begin
  if AGraphic <> nil then
    Provider.SetCellDataGraphic(AColumn, ARow, AGraphic);
end;

procedure TcxTreeListExportHelper.SetRealCellStyleAndValue(
  const ARealBounds, ASearchArea: TRect; AStyleIndex: Integer; const AValue: Variant);
var
  R: TRect;
begin
  RealBoundsToLogicalBoundsEx(ARealBounds, ASearchArea, R);
  if not VarIsNull(AValue) then
    Provider.SetCellValue(R.Left, R.Top, AValue);
  Provider.SetCellStyleEx(R.Left, R.Top, R.Bottom - R.Top, R.Right - R.Left, AStyleIndex);
end;

procedure TcxTreeListExportHelper.SetRealCellStyleAndValueEx(
  const ARealBounds, ASearchArea: TRect; AStyleIndex: Integer;
  AGraphic: TGraphic; AValue: Variant);
var
  R: TRect;
begin
  RealBoundsToLogicalBoundsEx(ARealBounds, ASearchArea, R);
  if Provider.SupportGraphic and (AGraphic <> nil) and not AGraphic.Empty then
    SetCellAsGraphic(R.Left, R.Top, AGraphic)
  else
    Provider.SetCellValue(R.Left, R.Top, AValue);
  Provider.SetCellStyleEx(R.Left, R.Top, R.Bottom - R.Top, R.Right - R.Left, AStyleIndex);
end;

function TcxTreeListExportHelper.SkipExportCell(
  ACell: TcxCustomViewInfoItem): Boolean;
begin
  Result := not ACell.Visible or not (
    (ACell is TcxTreeListCustomCellViewInfo) or (ACell is TcxTreeListEditCellViewInfo)) or 
    ((ACell is TcxTreeListFooterCellViewInfo) and TcxTreeListFooterCellViewInfo(ACell).Hidden);
end;

procedure TcxTreeListExportHelper.ViewParamsToExportStyle(const AViewParams: TcxViewParams;
 var AExportStyle: TcxCacheCellStyle; const AAlignment: TAlignment = taLeftJustify;
 ABorders: TcxBorders = []; ABorderColor: TColor = clDefault; AFontSize: Integer = 0);
var
  I: Integer;
begin
  AExportStyle := DefaultCellStyle;
  with AExportStyle do
  begin
    if ABorders = [] then
      ABorderColor := clDefault;
    BrushBkColor := cxColorToRGB(AViewParams.Color);
    FontColor := cxColorToRGB(AViewParams.TextColor);
    FillChar(FontName, SizeOf(FontName), 0);
    dxStringToBytes(AViewParams.Font.Name, FontName);
    FontStyle := TcxFontStyles(AViewParams.Font.Style);
    if AFontSize = 0 then 
      FontSize := AViewParams.Font.Size
    else
      FontSize := AFontSize;
    FontCharset := Integer(AViewParams.Font.Charset);
    AlignText := AlignToCxAlign[AAlignment];
    for I := 0 to 3 do
    begin
      Borders[I].IsDefault := (ABorderColor = clDefault) or not (TcxBorder(I) in ABorders);
      Borders[I].Width := Byte(not Borders[I].IsDefault);
      if not Borders[I].IsDefault then
        Borders[I].Color := ColorToRgb(ABorderColor);
    end;
  end;
end;

function TcxTreeListExportHelper.GetCells: TcxCustomControlCells;
begin
  Result := FViewInfo.Cells;
end;

function TcxTreeListExportHelper.GetColumnHeader(AIndex: Integer): TcxExportVisualItem;
begin
  Result := FColumnHeadersList[AIndex] as TcxExportVisualItem;
end;

function TcxTreeListExportHelper.GetColumnHeaderCount: Integer;
begin
  Result := FColumnHeadersList.Count;
end;

function TcxTreeListExportHelper.GetIncludeParentNodes: Boolean;
begin
  Result := True;
end;

function TcxTreeListExportHelper.GetVisualItem(AIndex: Integer): TcxExportVisualItem;
begin
  Result := FVisualItemsList[AIndex] as TcxExportVisualItem;
end;

function TcxTreeListExportHelper.GetVisualItemCount: Integer;
begin
  Result := FVisualItemsList.Count;
end;

procedure cxExportTLToHTML(const AFileName: string; ATreeList: TcxCustomTreeList;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const AFileExt: string = 'html');
begin
  cxExportTLToFile(AFileName, ATreeList, cxExportToHtml, AExpand, ASaveAll, False, [], AFileExt);
end;

procedure cxExportTLToXML(const AFileName: string; ATreeList: TcxCustomTreeList;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const AFileExt: string = 'xml');
begin
  cxExportTLToFile(AFileName, ATreeList, cxExportToXML, AExpand, ASaveAll, False, [], AFileExt);
end;

procedure cxExportTLToExcel(const AFileName: string; ATreeList: TcxCustomTreeList;
  AExpand: Boolean = True; ASaveAll: Boolean = True; AUseNativeFormat: Boolean = True;
  const AFileExt: string = 'xls');
begin
  cxExportTLToFile(AFileName, ATreeList, cxExportToExcel, AExpand, ASaveAll,
    AUseNativeFormat, [], AFileExt);
end;

procedure cxExportTLToText(const AFileName: string; ATreeList: TcxCustomTreeList;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const ASeparator: string = '';
  const ABeginString: string = ''; const AEndString: string = '';
  const AFileExt: string = 'txt');
begin
  cxExportTLToFile(AFileName, ATreeList, cxExportToText, AExpand, ASaveAll, False,
    [ASeparator, ABeginString, AEndString], AFileExt);
end;

function Supports(const Instance: IUnknown; const IID: TGUID; out Intf): Boolean; overload;
begin
  Result := (Instance <> nil) and (Instance.QueryInterface(IID, Intf) = 0);
end;

procedure cxExportTLToFile(AFileName: string; ATreeList: TcxCustomTreeList;
  AExportType: Integer; AExpand, ASaveAll, AUseNativeFormat: Boolean;
  const ASeparators: array of string; const AFileExt: string);

var
  I: Integer;
  AIntf: IcxExportWithSeparators;
begin
  if AFileExt <> '' then
    AFileName := ChangeFileExt(AFileName, '.' + AFileExt);
  if not ATreeList.Visible then
    cxTreeListError(scxExportNotVisibleControl);
  with TcxTreeListExportHelper.Create(ATreeList, AExportType, AFileName) do
  try
    Expand := AExpand;
    IsNativeFormat := AUseNativeFormat;
    SaveAll := ASaveAll;
    if cxTLExportLink.Supports(Provider, IcxExportWithSeparators, AIntf) and
      (Length(ASeparators) > 0) then
    begin
      for I := Low(ASeparators) to High(ASeparators) do
        AIntf.AddSeparator(ASeparators[I]);
    end;
    DoExport;
  finally
    Free;
  end;
end;

initialization
  cxExportInit(TcxGetResourceStringProc(@cxGetResourceString), @ColorToRGB, True);

end.

