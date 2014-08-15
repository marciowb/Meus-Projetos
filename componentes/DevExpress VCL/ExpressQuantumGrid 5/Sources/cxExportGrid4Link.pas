{*******************************************************************}
{                                                                   }
{       Developer Express Cross Platform Component Library          }
{       ExpressQuantumGrid                                          }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL           }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
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
unit cxExportGrid4Link;

{$I cxVer.inc}
{$DEFINE CHARTVIEW}
interface

uses
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  Windows,
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Graphics, cxGrid, cxExport, cxGridTableView, cxGridBandedTableView,
  Classes, SysUtils, cxGridCustomView, cxCustomData,
  cxGridCustomTableView, cxStyles, cxGridCardView, cxGridLevel, cxEdit,
  cxCalendar, cxCurrencyEdit, cxSpinEdit, cxCalc, cxTimeEdit, cxGraphics,
  cxClasses, cxGridStrs, cxDataUtils, cxGridDBDataDefinitions, cxLookAndFeels,
  cxGridCommon{$IFDEF CHARTVIEW}, cxGridChartView {$ENDIF}, dxCore;

type
  EcxGridExport = class(Exception);

procedure ExportGrid4ToHTML(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const AFileExt: string = 'html');
procedure ExportGrid4ToXML(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const AFileExt: string = 'xml');
procedure ExportGrid4ToExcel(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean = True; ASaveAll: Boolean = True; AUseNativeFormat: Boolean = True;
  const AFileExt: string = 'xls');
procedure ExportGrid4ToText(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const ASeparator: string = '';
  const ABeginString: string = ''; const AEndString: string = '';
  const AFileExt: string = 'txt');

implementation

uses
  cxXLSExport, cxHtmlXmlTxtExport, Math;

type
  TcxGridContentKind = (gckHeader, gckRecord, gckFooter, gckGroupFooter);

  { TcxGridExportTableMapItem }
  TcxGridExportTableMapItem = record
    Height: Integer;
    Index: Integer;
    StartX: Integer;
    Value: string;
    Width: Integer;
  end;

  PcxGridExportTableMapItem = ^TcxGridExportTableMapItem;

  { TcxGridExportTableMapLine }
  TcxGridExportTableMapLine = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItems(Index: Integer): TcxGridExportTableMapItem;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(AStartX, AWidth, AHeight, AIndex: Integer; AValue: string);
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxGridExportTableMapItem read GetItems; default;
  end;

  { TcxGridExportTableMap }
  TcxGridExportTableMap = class
  private
    FBandLine: TcxGridExportTableMapLine;
    FLines: TList;
    FScale: TList;
    procedure AddScaleItem(AValue: Integer);
    function GetLineCount: Integer;
    function GetLines(Index: Integer): TcxGridExportTableMapLine;
    function GetScaleCoord(AX: Integer): Integer;
    procedure GetScaleCoords(var AStart, AWidth: Integer);
    function GetScaleItemCount: Integer;
    function GetScaleItems(Index: Integer): Integer;
    procedure InsertScaleItem(AIndex: Integer; AValue: Integer);
    procedure SetScaleItems(Index: Integer; Value: Integer);
    property ScaleItemCount: Integer read GetScaleItemCount;
    property ScaleItems[Index: Integer]: Integer read GetScaleItems write SetScaleItems;
  public
    constructor Create;
    destructor Destroy; override;
    function GetBandLineTotalWidth: Integer;
    procedure AddBandRect(AStartX, AWidth, AHeight, AIndex: Integer; ACaption: string);
    procedure AddRect(AStartX, AStartY, AWidth, AHeight, AIndex: Integer; ACaption: string);
    procedure DeleteScaleItem(AIndex: Integer);
    function GetScaleIndex(AValue: Integer): Integer;
    procedure UpdateScale(AX: Integer);
    property BandLine: TcxGridExportTableMapLine read FBandLine;
    property LineCount: Integer read GetLineCount;
    property Lines[Index: Integer]: TcxGridExportTableMapLine read GetLines;
  end;

  { TcxGridExportBandMapItem }
  PcxGridExportBandMapItem = ^TcxGridExportBandMapItem;
  TcxGridExportBandMapItem = record
    X: Integer;
    Y: Integer;
    Width: Integer;
    Height: Integer;
    Text: string;
  end;

  { TcxGridExportBandMap }
  TcxGridExportBandMap = class
  private
    FItems: TList;
    FBands: TList;
    function GetBands(AIndex: Integer): TcxGridBand;
    function GetCount: Integer;
    function GetItems(AIndex: Integer): TcxGridExportBandMapItem;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(X, Y, Width, Height: Integer; AText: string; ABand: TcxGridBand);
    function AddParentBand(ABandViewInfo: TcxGridBandViewInfo): Boolean;
    procedure AddBottomBand(ABandViewInfo: TcxGridBandViewInfo; AMapItem: TcxGridExportTableMapItem);
    procedure Clear;
    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TcxGridExportBandMapItem read GetItems; default;
    property Bands[AIndex: Integer]: TcxGridBand read GetBands;
  end;

  { TcxSelectedRow }
  PcxSelectedRow = ^TcxSelectedRow;
  TcxSelectedRow = record
    Row: TcxCustomGridRecord;
    IsRealSelected: Boolean;
  end;

  { TcxGridCustomExport }
  TcxGridCustomExport = class
  private
    FSelectedRows: TList;
    function GetIsRowRealSelected(Index: Integer): Boolean;
    function GetSelectedRowCount: Integer;
    function GetSelectedRows(Index: Integer): TcxCustomGridRecord;
  protected
    FGridView: TcxCustomGridView;
    FGrid: TcxCustomGrid;
    FExport: IcxExportProvider;
    FExportType: Integer;
    FExpand: Boolean;
    FFileName: string;
    FSaveAll: Boolean;
    FViewInfo: TcxCustomGridViewInfo;
    FUseNativeFormat: Boolean;
    FSeparators: TStringList;
    procedure AddSelectedRow(ARow: TcxCustomGridRecord; AIsRealSelected: Boolean);
    procedure CreateSelectedRowsInGridMode;
    function AlignmentToExportAlignment(AAlignment: TAlignment): TcxAlignText;
    procedure CreateSelectedRowsInStandardMode; dynamic; abstract;
    function CalculateRowCount: Integer; dynamic; abstract;
    procedure CreateExportCache; dynamic; abstract;
    procedure DoCreateExportCache; dynamic;
    function NativeFormatProperties(AProperties: TcxCustomEditProperties): Boolean;
    procedure RegisterStyles; virtual; abstract;
    procedure ViewParamsToExportStyle(AViewParams: TcxViewParams; var AExportStyle: TcxCacheCellStyle);
    property IsRowRealSelected[Index: Integer]: Boolean read GetIsRowRealSelected;
    property SelectedRowCount: Integer read GetSelectedRowCount;
    property SelectedRows[Index: Integer]: TcxCustomGridRecord read GetSelectedRows;
  public
    constructor Create(AFileName: string; AExportType: Integer; AGridView: TcxCustomGridView;
        AGrid: TcxCustomGrid; AViewInfo: TcxCustomGridViewInfo = nil); virtual;
    destructor Destroy; override;
    procedure DoExport; dynamic; abstract;
    property Expand: Boolean read FExpand write FExpand;
    property SaveAll: Boolean read FSaveAll write FSaveAll;
    property UseNativeFormat: Boolean read FUseNativeFormat write FUseNativeFormat;
    property Separators: TStringList read FSeparators;
  end;

  TcxGridCustomExportClass = class of TcxGridCustomExport;

  { TcxGridCardViewExportMapItem }
  PcxGridCardViewExportMapItem = ^TcxGridCardViewExportMapItem;
  TcxGridCardViewExportMapItem = record
    Column: Integer;
    Row: Integer;
    Card: TcxGridCard;
  end;

  { TcxGridCardViewExportMap }
  TcxGridCardViewExportMapClass = class of TcxGridCardViewExportMap;
  TcxGridCardViewExportMap = class(TList)
  private
    FTotalColumnCount: Integer;
    FTotalRowCount: Integer;
    FView: TcxGridCardView;
    FSaveAll: Boolean;
    function GetItems(AIndex: Integer): PcxGridCardViewExportMapItem;
  protected
    procedure DoProcessView; virtual;
    function GetVisibleRowCount(AIndex: Integer): Integer;
    procedure SetTotalColumnCount(AValue: Integer);
    procedure SetTotalRowCount(AValue: Integer);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Add: PcxGridCardViewExportMapItem;
    procedure AddItem(AColumn, ARow: Integer; ACard: TcxGridCard);
    procedure Clear; override;
    procedure ProcessView(AView: TcxGridCardView; ASaveAll: Boolean);
    property Items[AIndex: Integer]: PcxGridCardViewExportMapItem read GetItems; default;
    property SaveAll: Boolean read FSaveAll;
    property TotalColumnCount: Integer read FTotalColumnCount;
    property TotalRowCount: Integer read FTotalRowCount;
    property View: TcxGridCardView read FView;
  end;

  { TcxGridHorizontalCardViewExportMap }
  TcxGridHorizontalCardViewExportMap = class(TcxGridCardViewExportMap)
  private
    function CalculateMaxCardsInColumn: Integer;
  protected
    procedure DoProcessView; override;
  end;

  { TcxGridVerticalCardViewExportMap }
  TcxGridVerticalCardViewExportMap = class(TcxGridCardViewExportMap)
  private
    FSeparatorRows: TList;
    function CalculateMaxCardsInRow: Integer;
    function GetSeparatorRowCount: Integer;
    function GetSeparatorRows(AIndex: Integer): PInteger;
  protected
    procedure AddSeparatorRow(AValue: Integer);
    procedure ClearSeparatorRows;
    procedure DoProcessView; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property SeparatorRowCount: Integer read GetSeparatorRowCount;
    property SeparatorRows[AIndex: Integer]: PInteger read GetSeparatorRows;
  end;

  { TcxGridCardViewExport }
  TcxGridCardViewExport = class(TcxGridCustomExport)
  private
    FMap: TcxGridCardViewExportMap;
    FTotalColumnCount: Integer;
    FTotalRowCount: Integer;
    cxCardEmptySpaceStyle: Integer;
    cxCardLeftSeparatorStyle: Integer;
    cxCardUpSeparatorStyle: Integer;
    cxCardRightSeparatorStyle: Integer;
    cxCardDownSeparatorStyle: Integer;
    function MeasureText(AText: string; AFont: TFont): Integer;
    function CalculateCardCaptionWidth: Integer;
    function CorrectHeaderBorderStyle(AStyle: TcxCacheCellStyle; AVisibleRowIndex: Integer;
      AVisibleRowCount: Integer; ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
    function CorrectRecordBorderStyle(AStyle: TcxCacheCellStyle; AVisibleRowIndex: Integer;
      AVisibleRowCount: Integer; ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
    procedure CreateBackGround;
    function GetCardBorderStyle(ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
    function GetCardBorderWidth: Integer;
    function GetCaptionStyle(AVisibleRowIndex: Integer; ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
    function GetCaptionHeaderStyle(AVisibleRowIndex: Integer; ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
    function GetCaptionRecordStyle(AVisibleRowIndex: Integer; ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
    function GetDisplayText(ACard: TcxGridCard; ADataIndex: Integer): string;
    function GetDisplayValue(ACard: TcxGridCard; ADataIndex: Integer): Variant;
    function GetEmptySpaceStyle: TcxCacheCellStyle;
    function GetHeaderStyle(AVisibleRowIndex: Integer; ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
    function GetRecordStyle(AVisibleRowIndex: Integer; ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
    function GetSeparatorColor: Integer;
    function GetSeparatorWidth: Integer;
    function GetEmptySpaceWidth: Integer;
    function GetView: TcxGridCardView;
    procedure RegisterSeparatorStyles;
  protected
    procedure CreateContentExportCache(AColumn, ARow: Integer; ACard: TcxGridCard);
    procedure CreateExportCache; override;
    procedure CreateSeparators;
    procedure CreateSeparatorsH;
    procedure CreateSeparatorsV;
    procedure DoCreateExportCache; override;
    procedure InternalCreateExportCache;
    procedure RegisterStyles; override;
    procedure SetEmptySpaceWidth;
    property View: TcxGridCardView read GetView;
  public
    constructor Create(AFileName: string; AExportType: Integer; AGridView: TcxCustomGridView;
        AGrid: TcxCustomGrid;
        AViewInfo: TcxCustomGridViewInfo = nil); override;
    destructor Destroy; override;
    procedure DoExport; override;
    class function GetMapClass(AView: TcxGridCardView): TcxGridCardViewExportMapClass;
  end;

{$IFDEF CHARTVIEW}
  { TcxGridChartViewExport }

  TcxGridChartViewExport = class(TcxGridCustomExport)
  private
    function GetView: TcxGridChartView;
  protected
    procedure CreateExportCache; override;
    procedure DoCreateExportCache; override;
    procedure DoExport; override;
    procedure ExportAsGraphic; virtual;
    procedure ExportAsData; virtual;

    property View: TcxGridChartView read GetView;
  end;
{$ENDIF}

  { TcxGridTableViewExport }
  TcxGridTableViewExport = class(TcxGridCustomExport)
  private
    FCacheColumnCount: Integer;
    FCacheRowCount: Integer;
    procedure CorrectBottomBorders(ARow: Integer);
    procedure CreateScale;
    procedure ExpandSelectedRecords;
    procedure FullExpandRecords;

    function GetDefaultStyle: TcxCacheCellStyle;
    function GetExpandButtonStyle: TcxCacheCellStyle;
    function GetFooterCellStyle(ARow: TcxCustomGridRow; ALevel: Integer; AColumnNumber: Integer): TcxCacheCellStyle;
    function GetFooterStyle(ARow: TcxCustomGridRow; ALevel: Integer): TcxCacheCellStyle;
    function GetGroupRowStyle(ARecord: TcxCustomGridRecord; ALevel: Integer): TcxCacheCellStyle;
    function GetGroupScaleItemSize: Integer;
    function GetHeaderStyle(AColumnNumber: Integer): TcxCacheCellStyle;
    function GetMasterEmptySpaceStyle(ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
    function GetMasterExpandButtonStyle: TcxCacheCellStyle;
    function GetRowCount: Integer;
    function GetIsRowRealSelected(AIndex: Integer): Boolean;
    function GetRows(AIndex: Integer): TcxCustomGridRow;
    function GetRowLevelStyle(ARecord: TcxCustomGridRecord; ALevel: Integer): TcxCacheCellStyle;
    function GetVisibleColumnCount: Integer;
    procedure InsertRightCellBorders;
    procedure SetGridLines(var AStyle: TcxCacheCellStyle);
    function IsGroupsAlwaysExpanded: Boolean;
  protected
    Map: TcxGridExportTableMap;
    function CalculateRowCount: Integer; override;
    function CalculateTableViewInfo(AGridView: TcxCustomGridTableView;
        ABounds: TRect): TcxCustomGridTableViewInfo; virtual;
    function CalculateCardViewViewInfo(AGridView: TcxGridCardView;
        ABounds: TRect): TcxGridCardViewViewInfo; virtual;
    procedure CreateExportCache; override;
    procedure CreateGroupScale;
    procedure CreateMap; virtual;
    procedure CreateContentExportCache(AStartRow, ARecordNumber, ALevel: Integer;
        AContentKind: TcxGridContentKind); virtual;
    procedure AddParents(AIndex: Integer);
//    procedure CreateSelectedRowsInGridMode;
    procedure CreateSelectedRows;
    procedure DoCreateExportCache; override;
    procedure DoExpand;
    function GetColumnAlignment(ACol: Integer): TAlignment;
    function GetColumnFooterAlignment(ACol: Integer): TAlignment;
    function GetColumnHeaderAlignment(ACol: Integer): TAlignment;
    function GetDisplayText(const ACol, ARow: Integer): string;
    function GetDisplayValue(const ACol, ARow: Integer): Variant;
    function GetFooterDisplayValue(ACol: Integer): Variant;
    function GetFooterItemIndex(ACol: Integer): Integer;
    function GetFooterDisplayText(ACol: Integer): string;
    function GetGroupFooterDisplayValue(ACol, ARow, ALevel: Integer): Variant;
    function GetGroupFooterDisplayText(ACol, ARow, ALevel: Integer): string;
    function GetGroupFootersMode: TcxGridGroupFootersMode;
    function GetGroupColumnCount: Integer;
    function GetHeaderLineCount: Integer; virtual;
    function GetMasterScaleItemSize: Integer; virtual;
    function GetPreview(ARow: Integer): string;
    function GetPreviewAlignment: TAlignment;
    function GetPreviewStyle(ARecord: TcxCustomGridRecord): TcxCacheCellStyle; virtual;
    function GetPreviewLineCount: Integer;
    function GetRecordStyle(ARecord: TcxCustomGridRecord; AColumnNumber: Integer): TcxCacheCellStyle; virtual;
    function GetViewInfo: TcxGridTableViewInfo;
    function HasHorizontalGridLines: Boolean;
    function HasVerticalGridLines: Boolean;
    procedure InternalCreateExportCache(AStartRow: Integer);
    function IsDetailSelected(AGridView: TcxCustomGridView): Boolean;
    function IsFooterVisible: Boolean;
    function IsHeaderVisible: Boolean;
    function IsMasterView: Boolean;
    function IsPreviewVisible: Boolean;
    procedure RegisterStyles; override;
    procedure SetLevelStyle(ALevel, ARow: Integer; ARecord: TcxCustomGridRecord);
    procedure SetRange;
    function GetExpandButtonWidth: Integer;
    function IsOffice11Style: Boolean;
  public
    constructor Create(AFileName: string; AExportType: Integer; AGridView: TcxCustomGridView;
        AGrid: TcxCustomGrid; AViewInfo: TcxCustomGridViewInfo = nil); override;
    destructor Destroy; override;
    procedure DoExport; override;
  end;

  { TcxGridBandedTableViewExport }
  TcxGridBandedTableViewExport = class(TcxGridTableViewExport)
  private
    FBandMap: TcxGridExportBandMap;
    FLinesTotalWidth: TList;
    FNewBandWidth: Integer;
    FRowCount: Integer;
    FVertSeparatorPos: TList;
    FVertSeparatorPosCreated: Boolean;
    procedure CreateBandScale(ABandIndex, ABandStartX: Integer);
    procedure CreateLinesTotalWidth(ACount: Integer; AStartValue: Integer = 0);
    procedure CreateScale;
    procedure CreateVertSeparatorPos;
    procedure FreeLinesTotalWidth;
    function GetBandNumber(AI: Integer): Integer;
    function GetBandStyle(ABandNumber: Integer): TcxCacheCellStyle;
    function GetFooterEmptySpaceStyle(ARow: TcxCustomGridRow; ALevel: Integer): TcxCacheCellStyle;
    function GetHeaderEmptySpaceStyle(ABandNumber: Integer): TcxCacheCellStyle;
    function GetRecordEmptySpaceStyle(ARecord: TcxCustomGridRecord; ABandNumber: Integer): TcxCacheCellStyle;
    function GetTotalWidth(Index: Integer): Integer;
    function GetVisibleBandCount: Integer;
    function IsVertSeparatorPos(APos: Integer): Boolean;
    procedure SetTotalWidth(Index: Integer; AValue: Integer);
  protected
    function CalculateRowCount: Integer; override;
    procedure CreateBandsExportCache(var AStartRow: Integer);
    procedure CreateExportCache; override;
    procedure CreateParentBandMap(ABandViewInfo: TcxGridBandViewInfo);
    procedure CreateParentBandsMap;
    procedure CreateMap; override;
    procedure CreateBandMap(ABandIndex, ABandStartX: Integer);
    procedure CreateContentExportCache(AStartRow, ARecordNumber, ALevel: Integer;
        AContentKind: TcxGridContentKind); override;
    function GetBandAlignment(ABandNumber: Integer): TAlignment;
    function GetBandsLineCount: Integer;
    function GetHeaderLineCount: Integer; override;
    function GetFooterDisplayValue(ACol: Integer): Variant;
    function GetFooterDisplayText(ACol: Integer): string;
    function GetGroupFooterDisplayValue(ACol, ARow, ALevel: Integer): Variant;
    function GetGroupFooterDisplayText(ACol, ARow, ALevel: Integer): string;
    function GetViewInfo: TcxGridBandedTableViewInfo;
    function IsBandVisible: Boolean;
    procedure RegisterStyles; override;
  public
    constructor Create(AFileName: string;  AExportType: Integer; AGridView: TcxCustomGridView;
        AGrid: TcxCustomGrid; AViewInfo: TcxCustomGridViewInfo = nil); override;
    destructor Destroy; override;
  end;

  TcxCustomGridTableViewAccessor = class(TcxCustomGridTableView);
  TcxCustomEditPropertiesAccessor = class(TcxCustomEditProperties);
  TcxCustomGridTableItemAccess = class(TcxCustomGridTableItem);

var
  DetailExportCounter: Integer = 0;

function DefaultHeaderEmptySpaceStyle: TcxCacheCellStyle;
var
  I: Integer;
begin
  Result := DefaultCellStyle;
  for I := 0 to 3 do
    Result.Borders[I].Width := 0;
  Result.BrushBkColor := cxColorToRGB(clDkGray);
end;

function DefaultRecordEmptySpaceStyle: TcxCacheCellStyle;
var
  I: Integer;
begin
  Result := DefaultCellStyle;
  for I := 0 to 3 do
    Result.Borders[I].Width := 0;
end;

function DefaultFooterEmptySpaceStyle: TcxCacheCellStyle;
var
  I: Integer;
begin
  Result := DefaultCellStyle;
  for I := 0 to 3 do
    Result.Borders[I].Width := 0;
  Result.BrushBkColor := cxColorToRGB(clBtnFace);
end;

function DefaultLevelStyle: TcxCacheCellStyle;
begin
  Result := DefaultCellStyle;
  Result.Borders[1].Width := 0;
  Result.Borders[3].Width := 0;
  Result.BrushBkColor := cxColorToRGB(clBtnFace);
end;

function DefaultBandStyle: TcxCacheCellStyle;
begin
  Result := DefaultCellStyle;
  Result.AlignText := catCenter;
  Result.BrushBkColor := cxColorToRGB(clBtnFace);
end;

function DefaultHeaderStyle: TcxCacheCellStyle;
begin
  Result := DefaultCellStyle;
  Result.BrushBkColor := cxColorToRGB(clBtnFace);
end;

function DefaultPreviewStyle: TcxCacheCellStyle;
begin
  Result := DefaultCellStyle;
  Result.FontColor := cxColorToRGB(clBlue);
end;

function DefaultExpandButtonStyle: TcxCacheCellStyle;
begin
  Result := DefaultCellStyle;
  Result.AlignText := catCenter;
  Result.BrushBkColor := cxColorToRGB(clBtnFace);
end;

function DefaultCardStyle: TcxCacheCellStyle;
var
  I: Integer;
begin
  Result := DefaultCellStyle;
  for I := 0 to 3 do
    Result.Borders[I].Width := 0;
end;

function DefaultCardCaptionStyle: TcxCacheCellStyle;
begin
  Result := DefaultCardStyle;
  Result.BrushBkColor := cxColorToRGB(clBtnFace);
end;

function InternalGetGridExportClass(AGridView: TcxCustomGridView): TcxGridCustomExportClass;
begin
  if AGridView = nil then
    raise EcxGridExport.Create(cxGetResourceString(@scxNotExistGridView));

  if AGridView is TcxGridBandedTableView then
    Result := TcxGridBandedTableViewExport
  else
    if AGridView is TcxGridTableView then
      Result := TcxGridTableViewExport
    else
      if AGridView is TcxGridCardView then
        Result := TcxGridCardViewExport
      else
     {$IFDEF CHARTVIEW}
        if AGridView is TcxGridChartView then
          Result := TcxGridChartViewExport
        else
     {$ENDIF}
          Result := TcxGridCustomExport;
end;

function GetGridExportClass(AGrid: TcxGrid): TcxGridCustomExportClass;
begin
  if AGrid.ActiveLevel = nil then
    raise EcxGridExport.Create(cxGetResourceString(@scxNotExistGridLevel));

  Result := InternalGetGridExportClass(AGrid.FocusedView);
end;

procedure ExportToFile(AFileName: string; AExportType: Integer;
  AGrid: TcxGrid; AExpand, ASaveAll, AUseNativeFormat: Boolean;
  const ASeparator, ABeginString, AEndString: string; const AFileExt: string);
var
  AGridExport: TcxGridCustomExport;
  AGridMode: Boolean;
  AView: TcxCustomGridView;
  ADataController: TcxGridDBDataController;
begin
  if AGrid <> nil then
  begin
    if AFileExt <> '' then
      AFileName := ChangeFileExt(AFileName, '.' + AFileExt);
    AView := AGrid.FocusedView; {ActiveLevel.GridView}
    AGridExport := GetGridExportClass(AGrid).Create(AFileName, AExportType, AView, AGrid);
    AGridExport.SaveAll := ASaveAll;
    AGridExport.Expand := AExpand;
    AGridExport.UseNativeFormat := AUseNativeFormat;
    with AGridExport.Separators do
    begin
      Add(ASeparator);
      Add(ABeginString);
      Add(AEndString);
    end;
    try
      ADataController := nil;
      if AView.DataController is TcxGridDBDataController then
        ADataController := TcxGridDBDataController(AView.DataController);
      if ADataController <> nil then
      begin
        AGridMode := ADataController.DataModeController.GridMode;
        try
          if not (ADataController.IsGridMode and not ASaveAll) then
            ADataController.DataModeController.GridMode := False;
          AGridExport.DoExport;
        finally
          ADataController.DataModeController.GridMode := AGridMode;
        end;
      end
      else
        AGridExport.DoExport;
    finally
      AGridExport.Free;
    end;
  end;
end;

procedure ExportGrid4ToHTML(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean; ASaveAll: Boolean; const AFileExt: string);
begin
  ExportToFile(AFileName, cxExportToHtml, AGrid, AExpand, ASaveAll, False, '', '', '', AFileExt);
end;

procedure ExportGrid4ToXML(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean; ASaveAll: Boolean; const AFileExt: string);
begin
  ExportToFile(AFileName, cxExportToXml, AGrid, AExpand, ASaveAll, False, '', '', '', AFileExt);
end;

procedure ExportGrid4ToExcel(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean; ASaveAll: Boolean; AUseNativeFormat: Boolean; const AFileExt: string);
begin
  ExportToFile(AFileName, cxExportToExcel, AGrid, AExpand, ASaveAll, AUseNativeFormat, '', '', '', AFileExt);
end;

procedure ExportGrid4ToText(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean; ASaveAll: Boolean; const ASeparator: string;
  const ABeginString: string; const AEndString: string; const AFileExt: string);
begin
  ExportToFile(AFileName, cxExportToText, AGrid, AExpand, ASaveAll, False,
    ASeparator, ABeginString, AEndString, AFileExt);
end;

{ TcxGridExportBandMap }
constructor TcxGridExportBandMap.Create;
begin
  inherited Create;
  FItems := TList.Create;
  FBands := TList.Create;
end;

destructor TcxGridExportBandMap.Destroy;
begin
  Clear;
  FBands.Free;
  FItems.Free;
  inherited Destroy;
end;

procedure TcxGridExportBandMap.Add(X, Y, Width, Height: Integer; AText: string;
  ABand: TcxGridBand);
var
  P: PcxGridExportBandMapItem;
begin
  if ABand = nil then Exit;
  New(P);
  P^.X := X;
  P^.Y := Y;
  P^.Width := Width;
  P^.Height := Height;
  P^.Text := AText;
  FItems.Add(P);
  FBands.Add(ABand);
end;

function TcxGridExportBandMap.AddParentBand(ABandViewInfo: TcxGridBandViewInfo): Boolean;
var
  ABand: TcxGridBand;
  AIndex0, AIndex: Integer;
  ABandWidth: Integer;
  I: Integer;
begin
  Result := False;
  ABand := ABandViewInfo.Band;
  if ABand.VisibleChildBandCount = 0 then Exit;
  if FBands.IndexOf(ABand) <> -1 then Exit;
  AIndex0 := FBands.IndexOf(ABand.VisibleChildBands[0]);
  if AIndex0 = -1 then Exit;
  ABandWidth := Items[AIndex0].Width;
  for I := 1 to ABand.VisibleChildBandCount - 1 do
  begin
    AIndex := FBands.IndexOf(ABand.VisibleChildBands[I]);
    if AIndex = - 1 then Exit;
    ABandWidth := ABandWidth + Items[AIndex].Width;
  end;
  Add(Items[AIndex0].X, Items[AIndex0].Y + 1, ABandWidth, 1, ABand.Caption, ABand);
  Result := True;
end;

procedure TcxGridExportBandMap.AddBottomBand(ABandViewInfo: TcxGridBandViewInfo;
  AMapItem: TcxGridExportTableMapItem);
begin
  Add(AMapItem.StartX, AMapItem.Height - 1, AMapItem.Width, AMapItem.Height,
    AMapItem.Value, ABandViewInfo.Band);
end;

procedure TcxGridExportBandMap.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Dispose(PcxGridExportBandMapItem(FItems[I]));
  FItems.Clear;
  FBands.Clear;
end;

function TcxGridExportBandMap.GetBands(AIndex: Integer): TcxGridBand;
begin
  Result := TcxGridBand(FBands[AIndex]);
end;

function TcxGridExportBandMap.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridExportBandMap.GetItems(AIndex: Integer): TcxGridExportBandMapItem;
begin
  Result := PcxGridExportBandMapItem(FItems[AIndex])^;
end;

{ TcxGridExportTableMapLine }

constructor TcxGridExportTableMapLine.Create;
begin
  FItems := TList.Create;
end;

destructor TcxGridExportTableMapLine.Destroy;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    Dispose(PcxGridExportTableMapItem(FItems[I]));
  FItems.Free;
end;

procedure TcxGridExportTableMapLine.Add(AStartX, AWidth, AHeight, AIndex: Integer; AValue: string);
var
  P: PcxGridExportTableMapItem;
begin
  New(P);
  with P^ do
  begin
    StartX := AStartX;
    Width := AWidth;
    Height := AHeight;
    Value := AValue;
    Index := AIndex;
  end;
  FItems.Add(P);
end;

function TcxGridExportTableMapLine.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridExportTableMapLine.GetItems(
  Index: Integer): TcxGridExportTableMapItem;
begin
  Result := PcxGridExportTableMapItem(FItems[Index])^;
end;

{ TcxGridExportTableMap }

constructor TcxGridExportTableMap.Create;
begin
  FBandLine := TcxGridExportTableMapLine.Create;
  FLines := TList.Create;
  FScale := TList.Create;
end;

destructor TcxGridExportTableMap.Destroy;
var
  I: Integer;
begin
  FBandLine.Free;
  for I := 0 to FLines.Count - 1 do
    TcxGridExportTableMapLine(FLines[I]).Free;
  FLines.Free;
  for I := 0 to FScale.Count - 1 do
    Dispose(PInteger(FScale[I]));
  FScale.Free;
end;

function TcxGridExportTableMap.GetBandLineTotalWidth: Integer;
begin
  if BandLine.Count > 0 then
  with BandLine.Items[BandLine.Count - 1] do
    Result := StartX + Width
  else
    Result := 0;
end;

procedure TcxGridExportTableMap.AddBandRect(AStartX, AWidth, AHeight, AIndex: Integer; ACaption: string);
begin
  GetScaleCoords(AStartX, AWidth);
  BandLine.Add(AStartX, AWidth, AHeight, AIndex, ACaption);
end;

procedure TcxGridExportTableMap.AddRect(AStartX, AStartY, AWidth, AHeight, AIndex: Integer;
    ACaption: string);
var
  I: Integer;
begin
  GetScaleCoords(AStartX, AWidth);
  for I := LineCount to AStartY do
    FLines.Add(TcxGridExportTableMapLine.Create);
  Lines[AStartY].Add(AStartX, AWidth, AHeight, AIndex, ACaption);
end;

procedure TcxGridExportTableMap.DeleteScaleItem(AIndex: Integer);
begin
 if (AIndex >= 0) and (AIndex < ScaleItemCount) then
 begin
   Dispose(PInteger(FScale[AIndex]));
   FScale.Delete(AIndex);
 end;
end;

function TcxGridExportTableMap.GetScaleIndex(AValue: Integer): Integer;
var
  I: Integer;
  ATotalValue: Integer;
begin
  ATotalValue := 0;
  for I := 0 to ScaleItemCount - 1 do
  begin
    Inc(ATotalValue, ScaleItems[I]);
    if ATotalValue = AValue then
    begin
      Result := I;
      Exit;
    end
    else if ATotalValue > AValue then
      Break;
  end;
  Result := -1;
end;

procedure TcxGridExportTableMap.UpdateScale(AX: Integer);
var
  I: Integer;
  AAbsX: Integer;
begin
  if AX < 0 then
    AX := 0;

  AAbsX := 0;
  for I := 0 to ScaleItemCount - 1 do
  begin
    Inc(AAbsX, ScaleItems[I]);

    if AX = AAbsX then
      Exit;
    if AX < AAbsX then
    begin
      InsertScaleItem(I, ScaleItems[I] - (AAbsX - AX));
      ScaleItems[I + 1] := AAbsX - AX;
      Exit;
    end;
  end;

  AddScaleItem(AX - AAbsX);
end;

procedure TcxGridExportTableMap.AddScaleItem(AValue: Integer);
var
  IntP: PInteger;
begin
  New(IntP);
  IntP^ := AValue;
  FScale.Add(IntP);
end;

function TcxGridExportTableMap.GetLineCount: Integer;
begin
  Result := FLines.Count;
end;

function TcxGridExportTableMap.GetLines(
  Index: Integer): TcxGridExportTableMapLine;
begin
  Result := TcxGridExportTableMapLine(FLines[Index]);
end;

function TcxGridExportTableMap.GetScaleCoord(AX: Integer): Integer;
var
  I: Integer;
  AAbsX: Integer;
begin
  if AX < 0 then
    AX := 0;

  if AX = 0 then
  begin
    Result := 0;
    Exit;
  end;

  AAbsX := 0;
  for I := 0 to ScaleItemCount - 1 do
  begin
    Inc(AAbsX, ScaleItems[I]);

    if AX <= AAbsX then
    begin
      Result := I + 1;
      Exit;
    end;
  end;

  Result := ScaleItemCount - 1; 
end;

procedure TcxGridExportTableMap.GetScaleCoords(var AStart, AWidth: Integer);
var
  AEnd: Integer;
begin
  AEnd := AStart + AWidth;

  AStart := GetScaleCoord(AStart);
  AWidth := GetScaleCoord(AEnd) - AStart;
end;

function TcxGridExportTableMap.GetScaleItemCount: Integer;
begin
  Result := FScale.Count;
end;

function TcxGridExportTableMap.GetScaleItems(Index: Integer): Integer;
begin
  Result := PInteger(FScale[Index])^;
end;

procedure TcxGridExportTableMap.InsertScaleItem(AIndex, AValue: Integer);
var
  IntP: PInteger;
begin
  New(IntP);
  IntP^ := AValue;
  FScale.Insert(AIndex, IntP);
end;

procedure TcxGridExportTableMap.SetScaleItems(Index, Value: Integer);
begin
  PInteger(FScale[Index])^ := Value;
end;

{ TcxGridCustomExport }

constructor TcxGridCustomExport.Create(AFileName: string;  AExportType: Integer;
    AGridView: TcxCustomGridView; AGrid: TcxCustomGrid; AViewInfo: TcxCustomGridViewInfo = nil);
begin
  FGridView := AGridView;
  FGrid := AGrid;
  FViewInfo := AViewInfo;
  FSelectedRows := TList.Create;
  try
  {$IFDEF DELPHI5}
    FExport := TcxExport.Provider(AExportType, AFileName) as IcxExportProvider;
  {$ELSE}
    TcxExport.Provider(AExportType, AFileName).GetInterface(IcxExportProvider, FExport);
  {$ENDIF}
  except
    on EFCreateError do
      raise EcxGridExport.Create(cxGetResourceString(@scxCantCreateExportOutputFile));
  end;
  FExpand := True;
  FSaveAll := True;
  FUseNativeFormat := False;
  FSeparators := TStringList.Create;
  FFileName := AFileName;
  FExportType := AExportType;
end;

destructor TcxGridCustomExport.Destroy;
var
  I: Integer;
begin
  FExport := nil;

  for I := 0 to FSelectedRows.Count - 1 do
    Dispose(PcxSelectedRow(FSelectedRows[I]));
  FSelectedRows.Free;
  FSeparators.Free;
end;

procedure TcxGridCustomExport.AddSelectedRow(ARow: TcxCustomGridRecord; AIsRealSelected: Boolean);
var
  P: PcxSelectedRow;
begin
  New(P);
  P^.Row := ARow;
  P^.IsRealSelected := AIsRealSelected;
  FSelectedRows.Add(P);
end;

procedure TcxGridCustomExport.CreateSelectedRowsInGridMode;
type
  PInteger = ^Integer;
var
  I: Integer;
  AView: TcxCustomGridTableView;
  ASelectedIndeces: TList;
  ASelectedIndex: Integer;
  P: PInteger;
begin
  if FGridView is TcxCustomGridTableView then
  begin
    ASelectedIndeces := TList.Create;
    try
      AView := TcxCustomGridTableView(FGridView);
      with AView.DataController do
      begin
        SaveDataSetPos;
        try
          for I := 0 to GetSelectedCount - 1 do
          begin
            if FocusSelectedRow(I) then
            begin
              New(P);
              P^ := FocusedRecordIndex;
              ASelectedIndeces.Add(P);
            end;
          end;
        finally
          FGridView.DataController.RestoreDataSetPos;
        end;
      end;
      TcxGridDBDataController(AView.DataController).DataModeController.GridMode := False;
      for I := 0 to ASelectedIndeces.Count - 1 do
      begin
        ASelectedIndex := PInteger(ASelectedIndeces[I])^;
        AddSelectedRow(TcxGridTableView(FGridView).ViewData.Rows[ASelectedIndex], True);
      end;
    finally
      for I := 0 to ASelectedIndeces.Count - 1 do
        Dispose(PInteger(ASelectedIndeces[I]));
      ASelectedIndeces.Free;
    end;
  end;
end;

function TcxGridCustomExport.AlignmentToExportAlignment(AAlignment: TAlignment): TcxAlignText;
begin
  case AAlignment of
    taLeftJustify:
      Result := catLeft;
    taRightJustify:
      Result := catRight;
    taCenter:
      Result := catCenter;
    else
      Result := catLeft;
  end;
end;

procedure TcxGridCustomExport.DoCreateExportCache;
var
  AExportWithSeparators: IcxExportWithSeparators;
  I: Integer;
begin
  {$IFDEF DELPHI5}
  if Supports(FExport, IcxExportWithSeparators, AExportWithSeparators) then
  {$ELSE}
  if (FExport.QueryInterface(IcxExportWithSeparators, AExportWithSeparators) = S_OK) then
  {$ENDIF}
  begin
    for I := 0 to FSeparators.Count  - 1 do
      AExportWithSeparators.AddSeparator(FSeparators[I]);
  end;
end;

function TcxGridCustomExport.NativeFormatProperties(AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := (AProperties is TcxDateEditProperties) or (AProperties is TcxCurrencyEditProperties) or
    (AProperties is TcxSpinEditProperties) or (AProperties is TcxCalcEditProperties) or
    (AProperties is TcxTimeEditProperties);
end;

procedure TcxGridCustomExport.ViewParamsToExportStyle(AViewParams: TcxViewParams;
  var AExportStyle: TcxCacheCellStyle);
begin
  with AExportStyle do
  begin
    BrushBkColor := cxColorToRGB(AViewParams.Color);
    FontColor := cxColorToRGB(AViewParams.TextColor);
    FillChar(FontName, SizeOf(FontName), 0);
    dxStringToBytes(AViewParams.Font.Name, FontName);
    FontStyle := TcxFontStyles(AViewParams.Font.Style);
    FontSize := AViewParams.Font.Size;
    FontCharset := Integer(AViewParams.Font.Charset);
  end;
end;

function TcxGridCustomExport.GetIsRowRealSelected(Index: Integer): Boolean;
begin
  Result := PcxSelectedRow(FSelectedRows[Index])^.IsRealSelected;
end;

function TcxGridCustomExport.GetSelectedRowCount: Integer;
begin
  Result := FSelectedRows.Count;
end;

function TcxGridCustomExport.GetSelectedRows(
  Index: Integer): TcxCustomGridRecord;
begin
  Result := TcxCustomGridRecord(PcxSelectedRow(FSelectedRows[Index])^.Row);
end;

{ TcxGridCardViewExportMap }

constructor TcxGridCardViewExportMap.Create;
begin
  inherited Create;
end;

destructor TcxGridCardViewExportMap.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TcxGridCardViewExportMap.Add: PcxGridCardViewExportMapItem;
begin
  New(Result);
  inherited Add(Result);
end;

procedure TcxGridCardViewExportMap.AddItem(AColumn, ARow: Integer; ACard: TcxGridCard);
begin
  if (AColumn < 0) or (ARow < 0) or (ACard = nil) then Exit;
  with Add^ do
  begin
    Column := AColumn;
    Row := ARow;
    Card := ACard;
  end;
end;

procedure TcxGridCardViewExportMap.Clear;
var
  I: Integer;
begin
  FTotalColumnCount := -1;
  FTotalRowCount := -1;
  try
    for I := 0 to Count - 1 do
      Dispose(Items[I]);
  finally
    inherited Clear;
  end;
end;

procedure TcxGridCardViewExportMap.ProcessView(AView: TcxGridCardView; ASaveAll: Boolean);
begin
  if AView = nil then Exit;
  Clear;
  FView := AView;
  FSaveAll := ASaveAll;
  DoProcessView;
end;

procedure TcxGridCardViewExportMap.DoProcessView;
begin
end;

function TcxGridCardViewExportMap.GetVisibleRowCount(AIndex: Integer): Integer;
var
  ARows: TList;
begin
  if (AIndex < 0) or (AIndex >= View.ViewData.CardCount) then
  begin
    Result := 0;
    Exit;
  end;
  ARows := TList.Create;
  try
    View.ViewData.Cards[AIndex].GetVisibleRows(ARows);
    Result := ARows.Count;
  finally
    ARows.Free;
  end;
end;

procedure TcxGridCardViewExportMap.SetTotalColumnCount(AValue: Integer);
begin
  if FTotalColumnCount = -1 then
    if AValue >= 0 then
      FTotalColumnCount := AValue;
end;

procedure TcxGridCardViewExportMap.SetTotalRowCount(AValue: Integer);
begin
  if FTotalRowCount = -1 then
    if AValue >= 0 then
      FTotalRowCount := AValue;
end;

function TcxGridCardViewExportMap.GetItems(AIndex: Integer): PcxGridCardViewExportMapItem;
begin
  Result := PcxGridCardViewExportMapItem(inherited Items[AIndex]);
end;

{ TcxGridHorizontalCardViewExportMap }

procedure TcxGridHorizontalCardViewExportMap.DoProcessView;
var
  I: Integer;
  AColumn, ARow: Integer;
  ATotalRowCount: Integer;
  AMaxCardsInColumn: Integer;
  AIndex: Integer;
  procedure ProcessIndex;
  begin
    Inc(ARow, GetVisibleRowCount(I) + 1);
    if ARow > ATotalRowCount then
      ATotalRowCount := ARow;
    if AIndex >= AMaxCardsInColumn then
    begin
      Inc(AColumn, 4);
      ARow := 1;
      AIndex := 0;
    end;
  end;
begin
  AColumn := 1;
  ARow := 1;
  ATotalRowCount := 0;
  AMaxCardsInColumn := CalculateMaxCardsInColumn;
  AIndex := 0;
  with View.ViewData do
    if CardCount > 0 then
    begin
      for I := 0 to CardCount - 1 do
      begin
        if (not SaveAll) and (not Cards[I].Selected) then Continue;
        AddItem(AColumn, ARow, Cards[I]);
        Inc(AIndex);
        ProcessIndex;
      end;
      if AIndex = 0 then
        SetTotalColumnCount(AColumn - 1)
      else
        SetTotalColumnCount(AColumn + 3);
      SetTotalRowCount(ATotalRowCount);
    end;
end;

function TcxGridHorizontalCardViewExportMap.CalculateMaxCardsInColumn: Integer;
var
  I: Integer;
begin
  Result := 0;
  with View.ViewInfo.RecordsViewInfo do
    for I := 0 to Columns.Count - 1 do
      if Columns[I].RowCount > Result then
        Result := Columns[I].RowCount;
end;

{ TcxGridVerticalCardViewExportMap }

constructor TcxGridVerticalCardViewExportMap.Create;
begin
  inherited Create;
  FSeparatorRows := TList.Create;
end;

destructor TcxGridVerticalCardViewExportMap.Destroy;
begin
  ClearSeparatorRows;
  FSeparatorRows.Free;
  inherited Destroy;
end;

procedure TcxGridVerticalCardViewExportMap.ClearSeparatorRows;
var
  I: Integer;
begin
  for I := 0 to SeparatorRowCount - 1 do
    Dispose(SeparatorRows[I]);
  FSeparatorRows.Clear;
end;

procedure TcxGridVerticalCardViewExportMap.AddSeparatorRow(AValue: Integer);
var
  AP: PInteger;
begin
  New(AP);
  AP^ := AValue;
  FSeparatorRows.Add(AP);
end;

procedure TcxGridVerticalCardViewExportMap.DoProcessView;
var
  I: Integer;
  AColumn: Integer;
  ARow: Integer;
  AIndex: Integer;
  AMaxCardsInRow: Integer;
  AMaxVisibleRowsInCard: Integer;
  AVisibleRowsInCard: Integer;
  procedure ProcessIndex;
  begin
    AVisibleRowsInCard := GetVisibleRowCount(I);
    if AVisibleRowsInCard > AMaxVisibleRowsInCard then
      AMaxVisibleRowsInCard := AVisibleRowsInCard;
    Inc(AColumn, 3);
    if AIndex >= AMaxCardsInRow then
    begin
      SetTotalColumnCount(AColumn);
      Inc(ARow, AMaxVisibleRowsInCard);
      AddSeparatorRow(ARow);
      Inc(ARow, 2);
      AMaxVisibleRowsInCard := 0;
      AColumn := 1;
      AIndex := 0;
    end
  end;
begin
  AMaxCardsInRow := CalculateMaxCardsInRow;
  AMaxVisibleRowsInCard := 0;
  AColumn := 1;
  ARow := 1;
  AIndex := 0;
  with View.ViewData do
    if CardCount > 0 then
    begin
      for I := 0 to CardCount - 1 do
      begin
        if (not SaveAll) and (not Cards[I].Selected) then Continue;
        AddItem(AColumn, ARow, Cards[I]);
        Inc(AIndex);
        ProcessIndex;
      end;
      if AIndex = 0 then
      begin
        SetTotalRowCount(ARow - 1);
        if FSeparatorRows.Count > 0 then
          FSeparatorRows.Delete(FSeparatorRows.Count - 1);
      end
      else
        SetTotalRowCount(ARow + AMaxVisibleRowsInCard + 1);
      SetTotalColumnCount(AColumn);
    end;
end;

function TcxGridVerticalCardViewExportMap.CalculateMaxCardsInRow: Integer;
begin
  Result := View.ViewInfo.RecordsViewInfo.Columns.Count;
end;

function TcxGridVerticalCardViewExportMap.GetSeparatorRowCount: Integer;
begin
  Result := FSeparatorRows.Count;
end;

function TcxGridVerticalCardViewExportMap.GetSeparatorRows(AIndex: Integer): PInteger;
begin
  Result := PInteger(FSeparatorRows[AIndex]);
end;

{ TcxGridCardViewExport }

constructor TcxGridCardViewExport.Create(AFileName: string; AExportType: Integer;
  AGridView: TcxCustomGridView; AGrid: TcxCustomGrid; AViewInfo: TcxCustomGridViewInfo = nil);
begin
  inherited Create(AFileName, AExportType, AGridView, AGrid, AViewInfo);
  FMap := GetMapClass(AGridView as TcxGridCardView).Create;
end;

destructor TcxGridCardViewExport.Destroy;
begin
  FMap.Free;
  inherited Destroy;
end;

procedure TcxGridCardViewExport.DoExport;
begin
  DoCreateExportCache;
  FExport.Commit;
end;

class function TcxGridCardViewExport.GetMapClass(AView: TcxGridCardView): TcxGridCardViewExportMapClass;
begin
  case AView.LayoutDirection of
    ldHorizontal:
      Result := TcxGridHorizontalCardViewExportMap;
    ldVertical:
      Result := TcxGridVerticalCardViewExportMap;
    else
      Result := TcxGridCardViewExportMap;
  end;
end;

procedure TcxGridCardViewExport.CreateContentExportCache(AColumn, ARow: Integer; ACard: TcxGridCard);
var
  I: Integer;
  ACardViewRow: TcxGridCardViewRow;
  AVisibleRows: TList;
  ARowIndex, AVisibleRowIndex: Integer;
  ACaption: string;
  ARowKind: TcxGridCardViewRowKind;
  procedure PrepareLocalValues;
  begin
    ACardViewRow := TcxGridCardViewRow(AVisibleRows[I]);
    ARowIndex := ACardViewRow.Index;
    AVisibleRowIndex := ACardViewRow.VisibleIndex;
    ACaption := ACardViewRow.VisibleCaption;
    ARowKind := ACardViewRow.Kind;
  end;
  procedure ExportData;
  var
    ADataCol: Integer;
  begin
    ADataCol := AColumn;
    if ACardViewRow.Options.ShowCaption then
    begin
      FExport.SetCellDataString(AColumn, ARow, ACaption);
      Inc(ADataCol);
    end;
    if FUseNativeFormat then
      FExport.SetCellValue(ADataCol, ARow, GetDisplayValue(ACard, ARowIndex))
    else
      FExport.SetCellDataString(ADataCol, ARow, GetDisplayText(ACard, ARowIndex));
  end;
  procedure ExportStyles;
  var
    ARowCaptionStyle: TcxCacheCellStyle;
    ARowDataStyle: TcxCacheCellStyle;
    ARowDataStyle2: TcxCacheCellStyle;
    ACaptionRowStyle: TcxCacheCellStyle;
    ACaptionRowStyle2: TcxCacheCellStyle;
  begin
    case ARowKind of
      rkData:
        begin
          ARowCaptionStyle := CorrectHeaderBorderStyle(GetHeaderStyle(AVisibleRowIndex, ACard),
            I, AVisibleRows.Count, ACard);
          ARowDataStyle := CorrectRecordBorderStyle(GetRecordStyle(AVisibleRowIndex, ACard),
            I, AVisibleRows.Count, ACard);
          ARowDataStyle2 := CorrectHeaderBorderStyle(GetRecordStyle(AVisibleRowIndex, ACard),
            I, AVisibleRows.Count, ACard);
          if ACardViewRow.Options.ShowCaption then
          begin
            FExport.SetCellStyle(AColumn, ARow, ARowCaptionStyle);
            FExport.SetCellStyle(AColumn + 1, ARow, ARowDataStyle);
          end
          else
          begin
            FExport.SetCellStyle(AColumn, ARow, ARowDataStyle2);
            FExport.SetCellStyle(AColumn + 1, ARow, ARowDataStyle);
          end;
        end;
      rkCaption:
        begin
          ACaptionRowStyle := CorrectHeaderBorderStyle(GetCaptionHeaderStyle(AVisibleRowIndex, ACard),
            I, AVisibleRows.Count, ACard);
          ACaptionRowStyle2 := CorrectRecordBorderStyle(GetCaptionRecordStyle(AVisibleRowIndex, ACard),
            I, AVisibleRows.Count, ACard);
          FExport.SetCellStyle(AColumn, ARow, ACaptionRowStyle);
          FExport.SetCellStyle(AColumn + 1, ARow, ACaptionRowStyle2);
        end;
    end;
  end;
begin
  AVisibleRows := TList.Create;
  try
    ACard.GetVisibleRows(AVisibleRows);
    for I := 0 to AVisibleRows.Count - 1 do
    begin
      PrepareLocalValues;
      ExportData;
      ExportStyles;
      Inc(ARow);
    end;
  finally
    AVisibleRows.Free;
  end;
end;

procedure TcxGridCardViewExport.CreateExportCache;
begin
  RegisterStyles;
  FTotalColumnCount := FMap.TotalColumnCount;
  FTotalRowCount := FMap.TotalRowCount;
  if (FTotalColumnCount > 0) and (FTotalRowCount > 0) then
  begin
    FExport.SetRange(FTotalColumnCount, FTotalRowCount, False);
    InternalCreateExportCache;
  end;
end;

procedure TcxGridCardViewExport.CreateSeparators;
begin
  case View.LayoutDirection of
    ldHorizontal:
      CreateSeparatorsH;
    ldVertical:
      CreateSeparatorsV;
  end;
end;

procedure TcxGridCardViewExport.CreateSeparatorsH;
var
  ACol: Integer;
  I: Integer;
begin
  ACol := 3;
  while ACol < (FTotalColumnCount - 1) do
  begin
    for I := 1 to FTotalRowCount - 2 do
    begin
      FExport.SetCellStyle(ACol, I, cxCardRightSeparatorStyle);
      FExport.SetCellStyle(ACol + 1, I, cxCardLeftSeparatorStyle);
    end;
    FExport.SetColumnWidth(ACol, GetEmptySpaceWidth);
    FExport.SetColumnWidth(ACol + 1, GetEmptySpaceWidth);
    Inc(ACol, 4);
  end;
end;

procedure TcxGridCardViewExport.CreateSeparatorsV;
var
  I, J: Integer;
begin
  with FMap as TcxGridVerticalCardViewExportMap do
  begin
    for I := 0 to SeparatorRowCount - 1 do
    begin
      for J := 1 to FTotalColumnCount - 2 do
      begin
        FExport.SetCellStyle(J, SeparatorRows[I]^, cxCardDownSeparatorStyle);
        FExport.SetCellStyle(J, SeparatorRows[I]^ + 1, cxCardUpSeparatorStyle);
      end;
    end;
  end;
end;

procedure TcxGridCardViewExport.DoCreateExportCache;
begin
  inherited DoCreateExportCache;
  FMap.ProcessView(View, SaveAll);  
  CreateExportCache;
end;

procedure TcxGridCardViewExport.InternalCreateExportCache;
var
  I: Integer;
  ACardContentWidth: Integer;
  ACardCaptionWidth: Integer;
begin
  ACardContentWidth := View.ViewInfo.RecordsViewInfo.CardContentWidth;
  ACardCaptionWidth := CalculateCardCaptionWidth;
  CreateBackGround;
  for I := 0 to FMap.Count - 1 do
    with FMap[I]^ do
    begin
      CreateContentExportCache(Column, Row, Card);
      FExport.SetColumnWidth(Column, ACardCaptionWidth);
      FExport.SetColumnWidth(Column + 1, ACardContentWidth - ACardCaptionWidth);
    end;
  CreateSeparators;
  SetEmptySpaceWidth;
end;

procedure TcxGridCardViewExport.RegisterStyles;
begin
  FExport.SetDefaultStyle(DefaultCardStyle);
  RegisterSeparatorStyles;
end;

procedure TcxGridCardViewExport.SetEmptySpaceWidth;
var
  I: Integer;
begin
  FExport.SetColumnWidth(0, GetEmptySpaceWidth);
  FExport.SetColumnWidth(FTotalColumnCount - 1, GetEmptySpaceWidth);
  if View.LayoutDirection = ldVertical then
  begin
    I := 3;
    while I <= FTotalColumnCount - 4 do
    begin
      FExport.SetColumnWidth(I, GetEmptySpaceWidth);
      Inc(I, 3)
    end;
  end;
end;

procedure TcxGridCardViewExport.CreateBackGround;
var
  I, J: Integer;
begin
  for I := 0 to FTotalColumnCount - 1 do
    for J := 0 to FTotalRowCount - 1 do
      FExport.SetCellStyle(I, J, cxCardEmptySpaceStyle);
end;

function TcxGridCardViewExport.GetCardBorderStyle(ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  Result := DefaultCardStyle;
  with TcxGridCardView(FGridView) do
  begin
    Styles.GetCardBorderParams(ARecord, AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;
end;

function TcxGridCardViewExport.GetCardBorderWidth: Integer;
begin
  Result := View.OptionsView.CardBorderWidth;
end;

function TcxGridCardViewExport.GetCaptionStyle(AVisibleRowIndex: Integer;
  ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  Result := DefaultCardStyle;
  with TcxGridCardView(FGridView) do
  begin
    VisibleRows[AVisibleRowIndex].Styles.GetCaptionRowParams(ARecord, AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;
end;

function TcxGridCardViewExport.GetCaptionHeaderStyle(AVisibleRowIndex: Integer;
  ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
begin
  Result := GetCaptionStyle(AVisibleRowIndex, ARecord);
  Result.AlignText := AlignmentToExportAlignment(View.VisibleRows[AVisibleRowIndex].CaptionAlignmentHorz);
end;

function TcxGridCardViewExport.GetCaptionRecordStyle(AVisibleRowIndex: Integer;
  ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
begin
  Result := GetCaptionStyle(AVisibleRowIndex, ARecord);
  Result.AlignText := AlignmentToExportAlignment(
    TcxCustomEditPropertiesAccessor(View.VisibleRows[AVisibleRowIndex].GetProperties).Alignment.Horz);
end;

function TcxGridCardViewExport.GetDisplayText(ACard: TcxGridCard; ADataIndex: Integer): string;
var
  AProperties: TcxCustomEditProperties;
begin
  AProperties := View.Rows[ADataIndex].GetProperties;
  if AProperties.GetEditValueSource(False) = evsValue then
    Result := AProperties.GetDisplayText(ACard.Values[ADataIndex], True)
  else
    Result := ACard.DisplayTexts[ADataIndex];
   TcxCustomGridTableItemAccess(View.Rows[ADataIndex]).DoGetDisplayText(ACard, Result);
end;

function TcxGridCardViewExport.GetDisplayValue(ACard: TcxGridCard; ADataIndex: Integer): Variant;
var
  AProperties: TcxCustomEditProperties;
begin
  AProperties := View.Rows[ADataIndex].GetProperties;
  if NativeFormatProperties(AProperties) then
    Result := ACard.Values[ADataIndex]
  else
    Result := GetDisplayText(ACard, ADataIndex);
end;

function TcxGridCardViewExport.MeasureText(AText: string; AFont: TFont): Integer;
begin
  with TcxScreenCanvas.Create do
  try
    Font := AFont;
    Result := TextWidth(AText);
    GetCellTextAreaSize(Result);
  finally
    Free;
  end;
end;

function TcxGridCardViewExport.CalculateCardCaptionWidth: Integer;
var
  I: Integer;
  AViewParams: TcxViewParams;
begin
  Result := View.OptionsView.CaptionWidth;
  if Result = 0 then
  begin
    for I := 0 to View.VisibleRowCount - 1 do
      with TcxGridCardViewRow(View.VisibleRows[I]) do
      begin
        Styles.GetCaptionParams(nil, AViewParams);
        Result := Max(Result, MeasureText(Caption, AViewParams.Font));
      end;
    Inc(Result, 3);
  end;
end;

function TcxGridCardViewExport.CorrectHeaderBorderStyle(AStyle: TcxCacheCellStyle;
  AVisibleRowIndex: Integer; AVisibleRowCount: Integer;
  ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
var
  ABorderColor: Integer;
begin
  Result := AStyle;
  ABorderColor := GetCardBorderStyle(ARecord).BrushBkColor;
  if ABorderColor = -1 then Exit;
  if AVisibleRowIndex = 0 then
  begin
    Result.Borders[1].Width := GetCardBorderWidth;
    Result.Borders[1].Color := ABorderColor;
    Result.Borders[0].Width := GetCardBorderWidth;
    Result.Borders[0].Color := ABorderColor;
  end
  else if (AVisibleRowIndex > 0) and (AVisibleRowIndex < AVisibleRowCount - 1) then
  begin
    Result.Borders[0].Width := GetCardBorderWidth;
    Result.Borders[0].Color := ABorderColor;
  end
  else if AVisibleRowIndex = AVisibleRowCount - 1 then
  begin
    Result.Borders[3].Width := GetCardBorderWidth;
    Result.Borders[3].Color := ABorderColor;
    Result.Borders[0].Width := GetCardBorderWidth;
    Result.Borders[0].Color := ABorderColor;
  end;
end;

function TcxGridCardViewExport.CorrectRecordBorderStyle(AStyle: TcxCacheCellStyle;
  AVisibleRowIndex: Integer; AVisibleRowCount: Integer;
  ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
var
  ABorderColor: Integer;
begin
  Result := AStyle;
  ABorderColor := GetCardBorderStyle(ARecord).BrushBkColor;
  if ABorderColor = -1 then Exit;
  if AVisibleRowIndex = 0 then
  begin
    Result.Borders[1].Width := GetCardBorderWidth;
    Result.Borders[1].Color := ABorderColor;
    Result.Borders[2].Width := GetCardBorderWidth;
    Result.Borders[2].Color := ABorderColor;
  end
  else if (AVisibleRowIndex > 0) and (AVisibleRowIndex < AVisibleRowCount - 1) then
  begin
    Result.Borders[2].Width := GetCardBorderWidth;
    Result.Borders[2].Color := ABorderColor;
  end
  else if AVisibleRowIndex = AVisibleRowCount - 1 then
  begin
    Result.Borders[3].Width := GetCardBorderWidth;
    Result.Borders[3].Color := ABorderColor;
    Result.Borders[2].Width := GetCardBorderWidth;
    Result.Borders[2].Color := ABorderColor;
  end;
end;

function TcxGridCardViewExport.GetEmptySpaceStyle: TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  with TcxGridCardView(FGridView).Styles do
  begin
    Result := DefaultCardStyle;
    GetViewParams(vsBackground, nil, nil, AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;
end;

function TcxGridCardViewExport.GetHeaderStyle(AVisibleRowIndex: Integer;
  ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  Result := DefaultCardStyle;
  View.VisibleRows[AVisibleRowIndex].Styles.GetCaptionParams(ARecord, AViewParams);
  ViewParamsToExportStyle(AViewParams, Result);
  Result.AlignText := AlignmentToExportAlignment(View.VisibleRows[AVisibleRowIndex].CaptionAlignmentHorz);
end;

function TcxGridCardViewExport.GetRecordStyle(AVisibleRowIndex: Integer;
  ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  Result := DefaultCardStyle;
  with TcxGridCardView(FGridView) do
  begin
    VisibleRows[AVisibleRowIndex].Styles.GetContentParams(ARecord, AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
    Result.AlignText := AlignmentToExportAlignment(
      TcxCustomEditPropertiesAccessor(VisibleRows[AVisibleRowIndex].GetProperties).Alignment.Horz);
  end;
end;

function TcxGridCardViewExport.GetSeparatorColor: Integer;
begin
  Result := cxColorToRGB(View.OptionsView.GetSeparatorColor);
end;

function TcxGridCardViewExport.GetSeparatorWidth: Integer;
begin
  Result := View.OptionsView.SeparatorWidth;
end;

function TcxGridCardViewExport.GetEmptySpaceWidth: Integer;
begin
  Result := 10;
end;

function TcxGridCardViewExport.GetView: TcxGridCardView;
begin
  Result := FGridView as TcxGridCardView;
end;

procedure TcxGridCardViewExport.RegisterSeparatorStyles;
var
  ALeftSeparatorStyle: TcxCacheCellStyle;
  AUpSeparatorStyle: TcxCacheCellStyle;
  ARightSeparatorStyle: TcxCacheCellStyle;
  ADownSeparatorStyle: TcxCacheCellStyle;
begin
  ALeftSeparatorStyle := GetEmptySpaceStyle;
  AUpSeparatorStyle := GetEmptySpaceStyle;
  ARightSeparatorStyle := GetEmptySpaceStyle;
  ADownSeparatorStyle := GetEmptySpaceStyle;

  cxCardEmptySpaceStyle := FExport.RegisterStyle(GetEmptySpaceStyle);

  case View.LayoutDirection of
    ldHorizontal:
    begin
      ARightSeparatorStyle.Borders[2].Width := GetSeparatorWidth div 2;
      if GetSeparatorWidth mod 2 <> 0 then
        Inc(ARightSeparatorStyle.Borders[2].Width);
      ARightSeparatorStyle.Borders[2].Color := GetSeparatorColor;

      ALeftSeparatorStyle.Borders[0].Width := GetSeparatorWidth div 2;
      ALeftSeparatorStyle.Borders[0].Color := GetSeparatorColor;
    end;
    ldVertical:
    begin
      AUpSeparatorStyle.Borders[1].Width := GetSeparatorWidth div 2;
      if GetSeparatorWidth mod 2 <> 0 then
        Inc(AUpSeparatorStyle.Borders[1].Width);
      AUpSeparatorStyle.Borders[1].Color := GetSeparatorColor;

      ADownSeparatorStyle.Borders[3].Width := GetSeparatorWidth div 2;
      ADownSeparatorStyle.Borders[3].Color := GetSeparatorColor;
    end;
  end;

  cxCardLeftSeparatorStyle := FExport.RegisterStyle(ALeftSeparatorStyle);
  cxCardUpSeparatorStyle := FExport.RegisterStyle(AUpSeparatorStyle);
  cxCardRightSeparatorStyle := FExport.RegisterStyle(ARightSeparatorStyle);
  cxCardDownSeparatorStyle := FExport.RegisterStyle(ADownSeparatorStyle);
end;

{$IFDEF CHARTVIEW}
{ TcxGridChartViewExport }

procedure TcxGridChartViewExport.CreateExportCache;
begin
  if FExport.SupportGraphic then
    ExportAsGraphic
  else
    ExportAsData;
end;

procedure TcxGridChartViewExport.DoCreateExportCache;
begin
  inherited DoCreateExportCache;
  CreateExportCache;
end;

procedure TcxGridChartViewExport.DoExport;
begin
  DoCreateExportCache;
  FExport.Commit;
end;

procedure TcxGridChartViewExport.ExportAsGraphic;
var
  AGraphic: TGraphic;
begin
  FExport.SetRange(1, 1, False);
  if SupportGraphic(cxExportGraphicClass) then
    AGraphic := View.CreateImage(cxExportGraphicClass)
  else
    AGraphic := View.CreateImage(TBitmap);
  try
    FExport.SetCellDataGraphic(0, 0, AGraphic);
  finally
    AGraphic.Free;
  end;
end;

procedure TcxGridChartViewExport.ExportAsData;
var
  AColCount, ARowCount, C, R: Integer;
  ASeries: TcxGridChartSeries;
  AHeaderStyle, AStyle: TcxCacheCellStyle;
begin
  AStyle := DefaultCellStyle;
  for C := 0 to 3 do
    with AStyle.Borders[C] do
    begin
      IsDefault := False;
      Width := 1;
      Color := clBlack;
    end;
  AHeaderStyle := AStyle;
  AHeaderStyle.BrushStyle := cbsSolid;
  AHeaderStyle.BrushBkColor := cxColorToRGB(clBtnFace);
  FExport.SetDefaultStyle(DefaultCellStyle);
  AColCount := Max(View.VisibleSeriesCount + 1, 1);
  ARowCount := View.DataController.RowCount + 1;
  FExport.SetRange(AColCount, ARowCount, False);
  for C := 0 to AColCount - 1 do
  begin
    if C = 0 then
    begin
      FExport.SetCellDataWideString(C, 0, 'Category');
      for R := 0 to ARowCount - 2 do
      begin
        FExport.SetCellValue(C, R + 1, View.ViewData.Categories[R]);
        FExport.SetCellStyle(C, R + 1, AHeaderStyle);
      end;
    end
    else
    begin
      ASeries := View.VisibleSeries[C - 1];
      FExport.SetCellDataWideString(C, 0, ASeries.GetDisplayText);
      for R := 0 to ARowCount - 2 do
      begin
        FExport.SetCellValue(C, R + 1, ASeries.Values[R]);
        FExport.SetCellStyle(C, R + 1, AStyle);
      end;
    end;
    FExport.SetCellStyle(C, 0, AHeaderStyle);
  end;
end;

function TcxGridChartViewExport.GetView: TcxGridChartView;
begin
  Result := TcxGridChartView(FGridView);
end;

{$ENDIF}

{ TcxGridTableViewExport }

constructor TcxGridTableViewExport.Create(AFileName: string;  AExportType: Integer;
    AGridView: TcxCustomGridView; AGrid: TcxCustomGrid; AViewInfo: TcxCustomGridViewInfo = nil);
begin
  inherited Create(AFileName, AExportType, AGridView, AGrid, AViewInfo);

  Map := TcxGridExportTableMap.Create;
end;

destructor TcxGridTableViewExport.Destroy;
begin
  Map.Free;

  inherited Destroy;
end;

procedure TcxGridTableViewExport.DoExport;
begin
  DoCreateExportCache;
  if HasVerticalGridLines then
    InsertRightCellBorders;
  FExport.Commit;
end;

function TcxGridTableViewExport.CalculateRowCount: Integer;
var
  I: Integer;
  ARow: TcxCustomGridRow;
begin
  Result := 0;

  if IsHeaderVisible then
    Inc(Result, GetHeaderLineCount);

  with TcxGridTableView(FGridView).ViewData do
  begin
    for I := 0 to GetRowCount - 1 do
    begin
      ARow := GetRows(I);
      if ARow is TcxGridGroupRow then
      begin
        Inc(Result);
        if SaveAll then
        begin
          case GetGroupFootersMode of
            gfAlwaysVisible:
              Inc(Result, GetHeaderLineCount);
            gfVisibleWhenExpanded:
            begin
              if (*ARow.Expandable and *)ARow.Expanded then
                Inc(Result, GetHeaderLineCount);
            end;
          end;
        end;
      end
      else if ARow is TcxGridMasterDataRow then
      begin
        Inc(Result, GetHeaderLineCount);
        if IsPreviewVisible then
          Inc(Result);
        if ARow.Expanded then
          Inc(Result);
      end
      else if ARow is TcxGridDataRow then
      begin
        Inc(Result, GetHeaderLineCount);
        if IsPreviewVisible then
          Inc(Result);
      end;
    end;
  end;

  if SaveAll and IsFooterVisible then
    Inc(Result, GetHeaderLineCount);
end;

function TcxGridTableViewExport.CalculateTableViewInfo(AGridView: TcxCustomGridTableView;
  ABounds: TRect): TcxCustomGridTableViewInfo;
begin
  Result := nil;
{$IFDEF CHARTVIEW}
  if AGridView.InheritsFrom(TcxGridChartView) then Exit;
{$ENDIF}
  try
    Result := TcxCustomGridTableViewInfo(
    TcxCustomGridTableViewAccessor(AGridView).GetViewInfoClass.Create(AGridView));
    Result.CalculateDown := True;
    Result.FirstRecordIndex := 0;
    Result.MainCalculate(ABounds);
  except
    FreeAndNil(Result);
  end;
end;

type
  TcxGridCardViewAccessor = class(TcxGridCardView);

function TcxGridTableViewExport.CalculateCardViewViewInfo(
  AGridView: TcxGridCardView; ABounds: TRect): TcxGridCardViewViewInfo;
begin
  Result := TcxGridCardViewViewInfo(
    TcxGridCardViewAccessor(AGridView).GetViewInfoClass.Create(AGridView));
  try
    Result.CalculateDown := True;
    Result.FirstRecordIndex := 0;
    Result.MainCalculate(ABounds);
  except
    FreeAndNil(Result);
  end;
end;

procedure TcxGridTableViewExport.CreateExportCache;
var
  I: Integer;
begin
  RegisterStyles;
  if not SaveAll then
    CreateSelectedRows;
  if GetVisibleColumnCount > 0 then
  begin
    if SaveAll or (SelectedRowCount > 0) or IsHeaderVisible or IsFooterVisible then
    begin
      SetRange;//FExport.SetRange(Map.ScaleItemCount, CalculateRowCount, False);
      for I := 0 to Map.ScaleItemCount - 1 do
        FExport.SetColumnWidth(I, Map.ScaleItems[I]);

      InternalCreateExportCache(0);
    end;
  end;
end;

procedure TcxGridTableViewExport.CreateGroupScale;
var
  I: Integer;
  ATotalWidth: Integer;
begin
  ATotalWidth := 0;
  for I := 0 to GetGroupColumnCount - 1 do
  begin
    Inc(ATotalWidth, GetGroupScaleItemSize);
    Map.UpdateScale(ATotalWidth);
  end;
  if IsMasterView then
  begin
    if (FGridView.Level as TcxGridLevel).VisibleCount > 0 then
    begin
      Inc(ATotalWidth, GetMasterScaleItemSize);
      Map.UpdateScale(ATotalWidth);
    end;
  end;
end;

procedure TcxGridTableViewExport.CreateMap;
var
  I: Integer;
  ATotalWidth: Integer;
begin
  CreateScale;

  with GetViewInfo.HeaderViewInfo do
  begin
    ATotalWidth := 0;
    for I := 0 to Count - 1 do
    begin
      with Items[I] do
      begin
        Map.AddRect(ATotalWidth, 0, Width, 1, Column.Index, Column.Caption);
        Inc(ATotalWidth, Width);
      end;
    end;
  end;
end;

procedure TcxGridTableViewExport.CreateContentExportCache(
  AStartRow, ARecordNumber, ALevel: Integer; AContentKind: TcxGridContentKind);
var
  I: Integer;
  AStartX: Integer;
  AStartY: Integer;
  AHeight: Integer;
  AWidth: Integer;
  AValue: string;
  AValue1: Variant;
  AStyle: Integer;
begin
  AStartX := 0;
  AStartY := 0;
  AHeight := 0;
  AWidth := 0;
  AValue := '';
  AStyle := -1;

  with Map.Lines[0] do
  begin
    for I := 0 to Count - 1 do
    begin
      with Items[I] do
      begin
        case AContentKind of
          gckHeader:            // Header
          begin
            AStartX := StartX;
            AStartY := AStartRow;
            AHeight := 1;
            AWidth := Width;
            AValue := Value;
            AStyle := FExport.RegisterStyle(GetHeaderStyle(Index));
          end;
          gckRecord:           // Record
          begin
            AWidth := 1;
            if I = 0 then
            begin
              AStartX := ALevel;
              if IsOffice11Style and (ALevel > 0) then
              begin
                Dec(AStartX);
                Inc(AWidth);
              end;
              if IsMasterView then
                if (FGridView.Level as TcxGridLevel).VisibleCount > 0 then
                  Inc(AStartX);
              SetLevelStyle(ALevel, AStartRow, GetRows(ARecordNumber));
            end
            else
              AStartX := StartX;
            AStartY := AStartRow;
            AHeight := 1;
            if FUseNativeFormat then
              AValue1 := GetDisplayValue(Index, ARecordNumber)
            else
              AValue := GetDisplayText(Index, ARecordNumber);
              AStyle := FExport.RegisterStyle(GetRecordStyle(GetRows(ARecordNumber), Index));
          end;
          gckFooter:          // Footer
          begin
            AStartX := StartX;
            AStartY := AStartRow;
            AHeight := 1;
            AWidth := Width;
            if FUseNativeFormat then
              AValue1 := GetFooterDisplayValue(I)
            else
              AValue := GetFooterDisplayText(I);
            if (AValue <> '') or not VarIsEmpty(AValue1) and not VarIsNull(AValue1) then
              AStyle := FExport.RegisterStyle(GetFooterCellStyle(GetRows(ARecordNumber), 0, Index))
            else
              AStyle := FExport.RegisterStyle(GetFooterStyle(GetRows(ARecordNumber), 0));
          end;
          gckGroupFooter:     // Grouped Footer
          begin
            if I = 0 then
            begin
              if GetGroupFootersMode = gfVisibleWhenExpanded then
              begin
                AStartX := ALevel + 1;
                AWidth := GetGroupColumnCount - ALevel;
                if IsOffice11Style and (AStartX = GetGroupColumnCount) then
                begin
                  Dec(AStartX);
                  Inc(AWidth);
                end;
                SetLevelStyle(ALevel + 1, AStartRow, GetRows(ARecordNumber));
              end
              else
              begin
                AStartX := ALevel;
                AWidth := GetGroupColumnCount - ALevel + 1;
                SetLevelStyle(ALevel, AStartRow, GetRows(ARecordNumber));
              end;
              if IsMasterView then
                if (FGridView.Level as TcxGridLevel).VisibleCount > 0 then
                  Inc(AWidth);
            end
            else
            begin
              AStartX := StartX;
              AWidth := 1;
            end;
            AStartY := AStartRow;
            AHeight := 1;
            if FUseNativeFormat then
              AValue1 := GetGroupFooterDisplayValue(I, ARecordNumber, ALevel)
            else
              AValue := GetGroupFooterDisplayText(I, ARecordNumber, ALevel);
            if (AValue <> '') or not VarIsNull(AValue1) then
              AStyle := FExport.RegisterStyle(GetFooterCellStyle(GetRows(ARecordNumber), ALevel, Index))
            else
              AStyle := FExport.RegisterStyle(GetFooterStyle(GetRows(ARecordNumber), ALevel));
          end;
        end;
        FExport.SetCellStyleEx(AStartX, AStartY, AHeight, AWidth, AStyle);
        if (AContentKind in [gckRecord, gckFooter, gckGroupFooter]) and FUseNativeFormat then
          FExport.SetCellValue(AStartX, AStartY, AValue1)
        else
          FExport.SetCellDataString(AStartX, AStartY, AValue);
      end;
    end;
  end;
end;

procedure TcxGridTableViewExport.AddParents(AIndex: Integer);
var
  I: Integer;
begin
  with TcxGridTableView(FGridView).ViewData do
  begin
    for I := AIndex - 1 downto 0 do
    begin
      if Rows[I].Level >= Rows[AIndex].Level then
      begin
        if Rows[I].Selected then
          Break;
      end
      else if Rows[I].Level < Rows[AIndex].Level then
      begin
        if Rows[I].Level = 0 then
          AddSelectedRow(Rows[I], True)
        else
        begin
          AddParents(I);
          AddSelectedRow(Rows[I], True);
        end;
        Break;
      end;
    end;
  end;
end;

(*procedure TcxGridTableViewExport.CreateSelectedRowsInGridMode;
type
  PInteger = ^Integer;
var
  I: Integer;
  AView: TcxCustomGridTableView;
  ASelectedIndeces: TList;
  ASelectedIndex: Integer;
  P: PInteger;
begin
  if FGridView is TcxCustomGridTableView then
  begin
    ASelectedIndeces := TList.Create;
    try
      AView := TcxCustomGridTableView(FGridView);
      with AView.DataController do
      begin
        SaveDataSetPos;

        try
          for I := 0 to GetSelectedCount - 1 do
          begin
            if FocusSelectedRow(I) then
            begin
              New(P);
              P^ := FocusedRecordIndex;
              ASelectedIndeces.Add(P);
            end;
          end;
        finally
          FGridView.DataController.RestoreDataSetPos;
        end;
      end;
      TcxGridDBDataController(AView.DataController).DataModeController.GridMode := False;
      for I := 0 to ASelectedIndeces.Count - 1 do
      begin
        ASelectedIndex := PInteger(ASelectedIndeces[I])^;
        AddParents(ASelectedIndex);
        AddSelectedRow(TcxGridTableView(FGridView).ViewData.Rows[ASelectedIndex], True);
      end;
    finally
      for I := 0 to ASelectedIndeces.Count - 1 do
        Dispose(PInteger(ASelectedIndeces[I]));
      ASelectedIndeces.Free;
    end;
  end;
end;*)

procedure TcxGridTableViewExport.CreateSelectedRows;
var
  I: Integer;
  MinSelectLevel: Integer;
begin
  if FGridView.DataController.IsGridMode then
  begin
    CreateSelectedRowsInGridMode;
    Exit;
  end;

  MinSelectLevel := 0;
  with TcxGridTableView(FGridView).ViewData do
  begin
    for I := 0 to RowCount - 1 do
    begin
      if MinSelectLevel > 0 then
      begin
        if Rows[I].Level >= MinSelectLevel then
        begin
          AddSelectedRow(Rows[I], True);
          Continue;
        end
        else
          MinSelectLevel := 0;
      end;

      if Rows[I].Selected then
      begin
        AddParents(I);
        AddSelectedRow(Rows[I], True);
        MinSelectLevel := Rows[I].Level + 1;
      end
      else
      begin
        if (Rows[I] is TcxGridMasterDataRow) and Rows[I].Expanded then
        begin
          if IsDetailSelected(TcxGridMasterDataRow(Rows[I]).ActiveDetailGridView) then
          begin
            AddParents(I);
            AddSelectedRow(Rows[I], False);
          end;
        end;
      end;
    end;
  end;
end;

procedure TcxGridTableViewExport.DoCreateExportCache;
begin
  inherited DoCreateExportCache;
  if Expand then
    DoExpand;

  CreateMap;
  CreateExportCache;
end;

procedure TcxGridTableViewExport.DoExpand;
begin
  with TcxGridTableView(FGridView) do
  begin
   (TcxGridLevel(Level).Control as TcxCustomGrid).BeginUpdate;
    try
      if SaveAll then
        FullExpandRecords
      else
        ExpandSelectedRecords;
    finally
      (TcxGridLevel(Level).Control as TcxCustomGrid).EndUpdate;
    end;
  end;
end;

function TcxGridTableViewExport.GetColumnAlignment(ACol: Integer): TAlignment;
begin
  with TcxCustomEditPropertiesAccessor(TcxGridTableView(FGridView).Columns[ACol].GetProperties) do
    Result := Alignment.Horz;
end;

function TcxGridTableViewExport.GetColumnFooterAlignment(ACol: Integer): TAlignment;
begin
  with TcxGridTableView(FGridView).Columns[ACol] do
    Result := FooterAlignmentHorz;
end;

function TcxGridTableViewExport.GetColumnHeaderAlignment(ACol: Integer): TAlignment;
begin
  with TcxGridTableView(FGridView).Columns[ACol] do
    Result := HeaderAlignmentHorz;
end;

function TcxGridTableViewExport.GetDisplayText(const ACol,
  ARow: Integer): string;
begin
  with TcxGridTableView(FGridView).Columns[ACol].GetProperties do
  begin
    if GetEditValueSource(False) = evsValue then
      Result := GetDisplayText(GetRows(ARow).Values[ACol], True)
    else
      Result := GetDisplayText(GetRows(ARow).DisplayTexts[ACol], True);
  end;
  TcxCustomGridTableItemAccess(TcxGridTableView(FGridView).Columns[ACol]).DoGetDisplayText(GetRows(ARow), Result);
end;

function TcxGridTableViewExport.GetDisplayValue(const ACol,
  ARow: Integer): Variant;
var
  AProperties: TcxCustomEditProperties;
begin
  AProperties := TcxGridTableView(FGridView).Columns[ACol].GetProperties;
  if NativeFormatProperties(AProperties) then
    Result := GetRows(ARow).Values[ACol]
  else
    Result := GetDisplayText(ACol, ARow);
end;

function TcxGridTableViewExport.GetFooterDisplayValue(
  ACol: Integer): Variant;
var
  AIndex: Integer;
begin
  AIndex := GetFooterItemIndex(ACol);
  Result := FGridView.DataController.Summary.FooterSummaryValues[AIndex];
end;

function TcxGridTableViewExport.GetFooterItemIndex(ACol: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  with FGridView.DataController.Summary.FooterSummaryItems do
  begin
    for I := 0 to Count - 1 do
    begin
      if Items[I].ItemLink is TcxGridColumn then
      with TcxGridColumn(Items[I].ItemLink) do
      begin
        if VisibleIndex = ACol then
        begin
          Result := I;
          Exit;
        end;
      end;
    end;
  end;
end;

function TcxGridTableViewExport.GetFooterDisplayText(ACol: Integer): string;
begin
  with GetViewInfo.FooterViewInfo.Items[ACol] do
    Result := Text;
end;

function TcxGridTableViewExport.GetGroupFooterDisplayValue(ACol, ARow, ALevel: Integer): Variant;
var
  AColumn: TcxGridColumn;
begin
  with TcxGridTableView(FGridView) do
  begin
    AColumn := VisibleColumns[ACol];
    with DataController.Summary do
      Result := GroupSummaryDisplayValues[ARow, ALevel, GroupFooterIndexOfItemLink[ALevel, AColumn]];
  end;
end;

function TcxGridTableViewExport.GetGroupFooterDisplayText(ACol, ARow, ALevel: Integer): string;
var
  AColumn: TcxGridColumn;
begin
  with TcxGridTableView(FGridView) do
  begin
    AColumn := VisibleColumns[ACol];
    with DataController.Summary do
      Result := GroupFooterSummaryTexts[ARow, ALevel, GroupFooterIndexOfItemLink[ALevel, AColumn]];
  end;
end;

function TcxGridTableViewExport.GetGroupFootersMode: TcxGridGroupFootersMode;
begin
  with TcxGridTableView(FGridView).OptionsView do
    Result := GroupFooters;
end;

function TcxGridTableViewExport.GetGroupColumnCount: Integer;
begin
  Result := TcxGridTableView(FGridView).GroupedColumnCount;
end;

function TcxGridTableViewExport.GetHeaderLineCount: Integer;
begin
  Result := 1;
end;

function TcxGridTableViewExport.GetMasterEmptySpaceStyle(ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  with TcxGridTableView(FGridView) do
  begin
    Result := DefaultCellStyle;
    Result.AlignText := catLeft;
    Styles.GetContentParams(ARecord, nil, AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;
end;

function TcxGridTableViewExport.GetMasterExpandButtonStyle: TcxCacheCellStyle;
begin
  Result := DefaultExpandButtonStyle;
end;

function TcxGridTableViewExport.GetMasterScaleItemSize: Integer;
begin
  Result := 16;
end;

function TcxGridTableViewExport.GetPreview(ARow: Integer): string;
begin
  with TcxGridTableView(FGridView) do
    Result := GetDisplayText(Preview.Column.Index, ARow)
end;

function TcxGridTableViewExport.GetPreviewAlignment: TAlignment;
begin
  Result := taLeftJustify;
  if TcxGridTableView(FGridView).Preview.Column <> nil then
    with TcxCustomEditPropertiesAccessor(TcxGridTableView(FGridView).Preview.Column.GetProperties) do
      Result := Alignment.Horz
end;

function TcxGridTableViewExport.GetPreviewStyle(ARecord: TcxCustomGridRecord): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  with TcxGridTableView(FGridView) do
  begin
    Result := DefaultPreviewStyle;
    SetGridLines(Result);
    Result.AlignText := AlignmentToExportAlignment(GetPreviewAlignment);
    if Preview.Column <> nil then
      Preview.Column.Styles.GetContentParams(ARecord, AViewParams)
    else
      Styles.GetPreviewParams(nil, nil, AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;
end;

function TcxGridTableViewExport.GetPreviewLineCount: Integer;
begin
  with TcxGridTableView(FGridView).Preview do
  begin
    if not AutoHeight then
      Result := MaxLineCount
    else
      Result := 1;
  end;
end;

function TcxGridTableViewExport.GetRecordStyle(ARecord: TcxCustomGridRecord;
  AColumnNumber: Integer): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  with TcxGridTableView(FGridView) do
  begin
    Result := DefaultCellStyle;
    SetGridLines(Result);
    Result.AlignText := AlignmentToExportAlignment(GetColumnAlignment(AColumnNumber));
    Columns[AColumnNumber].Styles.GetContentParams(ARecord, AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;
end;

function TcxGridTableViewExport.GetViewInfo: TcxGridTableViewInfo;
begin
  if FViewInfo = nil then
    Result := TcxGridTableView(FGridView).ViewInfo
  else
    Result := TcxGridTableViewInfo(FViewInfo);
end;

function TcxGridTableViewExport.HasHorizontalGridLines: Boolean;
begin
  Result := TcxGridTableView(FGridView).OptionsView.GridLines in [glHorizontal, glBoth];
end;

function TcxGridTableViewExport.HasVerticalGridLines: Boolean;
begin
  Result := TcxGridTableView(FGridView).OptionsView.GridLines in [glVertical, glBoth];
end;

procedure TcxGridTableViewExport.InternalCreateExportCache(AStartRow: Integer);
var
  AGroupFooterStack: TList;
  ARow: TcxCustomGridRow;
  I: Integer;    
type
  PcxGridFooterInfo = ^TcxGridFooterInfo;
  TcxGridFooterInfo = record
    Level: Integer;
    RecordNumber: Integer;
  end;

  procedure FreeGroupFooterStack;
  var
    I: Integer;
  begin
    for I := 0 to AGroupFooterStack.Count - 1 do
      Dispose(PcxGridFooterInfo(AGroupFooterStack[I]));
    AGroupFooterStack.Free;
  end;

  procedure Push(AGridFooterInfo: TcxGridFooterInfo);
  var
    P: PcxGridFooterInfo;
  begin
    New(P);
    P^ := AGridFooterInfo;
    AGroupFooterStack.Add(P)
  end;

  function Pop: PcxGridFooterInfo;
  begin
    if AGroupFooterStack.Count > 0 then
    begin
      Result := PcxGridFooterInfo(AGroupFooterStack.Last);
      AGroupFooterStack.Delete(AGroupFooterStack.Count - 1);
    end
    else
      Result := nil;
  end;

  procedure CreateGroupFooterExportCache(ACount: Integer);
  var
    AGridFooterInfo: PcxGridFooterInfo;
  begin
    AGridFooterInfo := Pop;
    while AGridFooterInfo <> nil do
    begin
      with AGridFooterInfo^ do
      begin
        CreateContentExportCache(AStartRow, RecordNumber, Level, gckGroupFooter);
        Inc(AStartRow, GetHeaderLineCount);
        Dispose(AGridFooterInfo);
      end;

      Dec(ACount);
      if ACount = 0 then
        Break;
      AGridFooterInfo := Pop;
    end;
  end;

  procedure CreatePreview;
  var
    AStartColumn: Integer;
    AWidth: Integer;
  begin
    if IsPreviewVisible then
    begin
      with ARow do
      begin
        AStartColumn := Level;
        AWidth := Map.ScaleItemCount - Level;
        if IsOffice11Style and (AStartColumn > 0) then
        begin
          Dec(AStartColumn);
          Inc(AWidth);
        end;
        FExport.SetCellStyleEx(AStartColumn, AStartRow, 1, AWidth,
          FExport.RegisterStyle(GetPreviewStyle(ARow)));
        FExport.SetCellDataString(AStartColumn, AStartRow, GetPreview(I));
        SetLevelStyle(AStartColumn, AStartRow, ARow);
        Inc(AStartRow);
      end;
    end;
  end;

  procedure CreateMasterPreview;
  var
    AStartColumn: Integer;
    AWidth: Integer;
  begin
    if IsPreviewVisible then
    begin
      with TcxGridMasterDataRow(ARow) do
      begin
        AStartColumn := Level + 1;
        AWidth := Map.ScaleItemCount - Level - 1;
        if IsOffice11Style and (Level > 0) then
        begin
          Dec(AStartColumn);
          Inc(AWidth);
        end;
        FExport.SetCellStyleEx(AStartColumn, AStartRow, 1, AWidth,
          FExport.RegisterStyle(GetPreviewStyle(ARow)));
        FExport.SetCellDataString(AStartColumn, AStartRow, GetPreview(I));
        if AStartColumn > 0 then
        begin
          SetLevelStyle(AStartColumn - 1, AStartRow, ARow);
          FExport.SetCellStyle(AStartColumn - 1, AStartRow, FExport.RegisterStyle(GetMasterEmptySpaceStyle(ARow)));
        end;
        Inc(AStartRow);
      end;
    end;
  end;

var
  AGridFooterInfo: TcxGridFooterInfo;
  ADetailExport: TcxGridCustomExport;
  ADetailViewInfo: TcxCustomGridTableViewInfo;
  ACellInternalCache: IcxCellInternalCache;
  ALevel: Integer;
  S: string;
begin
  AGroupFooterStack := TList.Create;
  ADetailViewInfo := nil;

  // header
  if IsHeaderVisible then
  begin
    CreateContentExportCache(AStartRow, 0, 0, gckHeader);
    Inc(AStartRow, GetHeaderLineCount);
  end;

  // body
  with TcxGridTableView(FGridView).ViewData do
  begin
    for I := 0 to GetRowCount - 1 do
    begin
      ARow := GetRows(I);
      if ARow is TcxGridGroupRow then // Group row
      begin
        if SaveAll and (ARow.Level < AGroupFooterStack.Count) then
          CreateGroupFooterExportCache(AGroupFooterStack.Count - ARow.Level);

        with TcxGridGroupRow(ARow) do
        begin
          FExport.SetCellStyle(Level, AStartRow, FExport.RegisterStyle(GetExpandButtonStyle));
          if Expanded then
            FExport.SetCellDataString(Level, AStartRow, '-')
          else
            FExport.SetCellDataString(Level, AStartRow, '+');
          FExport.SetColumnWidth(Level, GetExpandButtonWidth);
          SetLevelStyle(Level, AStartRow, ARow);
          S := DisplayText;
          TcxCustomGridTableItemAccess(GroupedColumn).DoGetDisplayText(ARow, S);
          if IsGroupsAlwaysExpanded then
          begin
            FExport.SetCellStyleEx(Level, AStartRow, 1, Map.ScaleItemCount - Level,
              FExport.RegisterStyle(GetGroupRowStyle(ARow, Level)));
            FExport.SetCellDataString(Level, AStartRow, S);
          end
          else
          begin
            FExport.SetCellStyleEx(Level + 1, AStartRow, 1, Map.ScaleItemCount - Level - 1,
              FExport.RegisterStyle(GetGroupRowStyle(ARow, Level)));
            FExport.SetCellDataString(Level + 1, AStartRow, S);
          end;
        end;
        Inc(AStartRow);
        if SaveAll then
        begin
          case GetGroupFootersMode of
            gfAlwaysVisible:
            begin
              AGridFooterInfo.Level := ARow.Level;
              AGridFooterInfo.RecordNumber := I;
              Push(AGridFooterInfo);
            end;
            gfVisibleWhenExpanded:
            begin
              if (*ARow.Expandable and *)ARow.Expanded then
              begin
                AGridFooterInfo.Level := ARow.Level;
                AGridFooterInfo.RecordNumber := I;
                Push(AGridFooterInfo);
              end;
            end;
          end;
        end;
      end
      else if ARow is TcxGridMasterDataRow then // Master Data row
      begin
        with TcxGridMasterDataRow(ARow) do
        begin
          if TcxGridTableView(FGridView).Preview.Place = ppTop then
            CreateMasterPreview;

          CreateContentExportCache(AStartRow, I, ARow.Level, gckRecord);
          ALevel := Level;
          if IsOffice11Style and (Level > 0) then
            Dec(ALevel);
          FExport.SetCellStyle(ALevel, AStartRow, FExport.RegisterStyle(GetMasterExpandButtonStyle));
          if Expanded then
            FExport.SetCellDataString(ALevel, AStartRow, '-')
          else
            FExport.SetCellDataString(ALevel, AStartRow, '+');
          FExport.SetColumnWidth(ALevel, GetExpandButtonWidth);
          SetLevelStyle(ALevel, AStartRow, ARow);
          Inc(AStartRow, GetHeaderLineCount);

          if TcxGridTableView(FGridView).Preview.Place = ppBottom then
            CreateMasterPreview;

          if Expanded then
          begin
            SetLevelStyle(ALevel, AStartRow, ARow);
              FExport.SetCellStyle(ALevel, AStartRow, FExport.RegisterStyle(GetMasterEmptySpaceStyle(ARow)));
              FExport.SetCellStyleEx(ALevel + 1, AStartRow, 1, Map.ScaleItemCount - ALevel - 1,
                FExport.RegisterStyle(GetMasterEmptySpaceStyle(ARow)));
            ADetailExport := nil;
            {$IFDEF DELPHI5}
            if Supports(FExport, IcxCellInternalCache, ACellInternalCache) then
            {$ELSE}
            if (FExport.QueryInterface(IcxCellInternalCache, ACellInternalCache) = S_OK) then
            {$ENDIF}
            begin
              try
                try
                  if ActiveDetailGridView is TcxGridCardView then
                    ADetailViewInfo := CalculateCardViewViewInfo(TcxGridCardView(ActiveDetailGridView), GetViewInfo.Bounds)
                  else
                    ADetailViewInfo := CalculateTableViewInfo(TcxCustomGridTableView(ActiveDetailGridView), GetViewInfo.Bounds);

                  if (ADetailViewInfo <> nil) {$IFDEF CHARTVIEW}or (ActiveDetailGridView is TcxGridChartView){$ENDIF} then
                  begin
                    ADetailExport := InternalGetGridExportClass(ActiveDetailGridView).Create(FFileName, FExportType, ActiveDetailGridView, FGrid, ADetailViewInfo);
                    ADetailExport.SaveAll := GetIsRowRealSelected(I);
                    ADetailExport.Expand := Self.Expand;
                    Inc(DetailExportCounter);
                    ADetailExport.DoCreateExportCache;
                    {$IFDEF DELPHI5}
                    if Supports(ADetailExport.FExport, IcxCellInternalCache, ACellInternalCache) then
                    {$ELSE}
                    if (ADetailExport.FExport.QueryInterface(IcxCellInternalCache, ACellInternalCache) = S_OK) then
                    {$ENDIF}
                      (FExport as IcxCellInternalCache).SetCacheIntoCell(ALevel + 1, AStartRow, ACellInternalCache);
                  end;
                except
                  on EcxExportData do;
                  on EcxGridExport do;
                end;
              finally
                ADetailExport.Free;
                ADetailViewInfo.Free;
              end;
            end;
            Inc(AStartRow);
          end;
        end;
      end
      else if ARow is TcxGridDataRow then // Data row
      begin
        if TcxGridTableView(FGridView).Preview.Place = ppBottom then
        begin
          CreateContentExportCache(AStartRow, I, ARow.Level, gckRecord);
          Inc(AStartRow, GetHeaderLineCount);
          CreatePreview;
        end
        else
        begin
          CreatePreview;
          CreateContentExportCache(AStartRow, I, ARow.Level, gckRecord);
          Inc(AStartRow, GetHeaderLineCount);
        end;
      end;
    end;
  end;

  CreateGroupFooterExportCache(AGroupFooterStack.Count);

  // footer
  if SaveAll and IsFooterVisible then
  begin
    CreateContentExportCache(AStartRow, 0, 0, gckFooter);
    Inc(AStartRow);
  end;

  Dec(AStartRow);
  if AStartRow >= 0 then
    CorrectBottomBorders(AStartRow);
  FreeGroupFooterStack;
end;

function TcxGridTableViewExport.IsDetailSelected(
  AGridView: TcxCustomGridView): Boolean;
var
  I: Integer;
begin
  Result := False;

  if AGridView is TcxGridTableView then
  begin
    with TcxGridTableView(AGridView).ViewData do
    begin
      for I := 0 to RowCount - 1 do
      begin
        if Rows[I].Selected then
        begin
          Result := True;
          Break;
        end;
        if (Rows[I] is TcxGridMasterDataRow) and Rows[I].Expanded then
        begin
          Result := IsDetailSelected(TcxGridMasterDataRow(Rows[I]).ActiveDetailGridView);
          if Result then
            Break;
        end;
      end;
    end;
  end
  else if AGridView is TcxGridCardView then
  begin
    with TcxGridCardView(AGridView).ViewData do
    begin
      for I := 0 to CardCount - 1 do
      begin
        if Cards[I].Selected then
        begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
end;

function TcxGridTableViewExport.IsFooterVisible: Boolean;
begin
  with TcxGridTableView(FGridView).OptionsView do
    Result := Footer;
end;

function TcxGridTableViewExport.IsHeaderVisible: Boolean;
begin
  with TcxGridTableView(FGridView).OptionsView do
    Result := Header;
end;

function TcxGridTableViewExport.IsMasterView: Boolean;
begin
  with TcxGridTableView(FGridView).DataController do
    Result := Relations.Count > 0; 
end;

function TcxGridTableViewExport.IsPreviewVisible: Boolean;
begin
  with TcxGridTableView(FGridView).Preview do
    Result := Visible and (Column <> nil);
end;

procedure TcxGridTableViewExport.RegisterStyles;
begin
  FExport.SetDefaultStyle(GetDefaultStyle);
end;

procedure TcxGridTableViewExport.SetLevelStyle(ALevel, ARow: Integer; ARecord: TcxCustomGridRecord);
var
  I: Integer;
begin
  for I := 0 to ALevel - 1 do
    FExport.SetCellStyle(I, ARow, FExport.RegisterStyle(GetRowLevelStyle(ARecord, I)));
end;

procedure TcxGridTableViewExport.SetRange;
begin
  FCacheColumnCount := Map.ScaleItemCount;
  FCacheRowCount := CalculateRowCount;
  if (FCacheColumnCount > 0) and (FCacheRowCount > 0) then
    FExport.SetRange(FCacheColumnCount, FCacheRowCount, False);
end;

function TcxGridTableViewExport.GetExpandButtonWidth: Integer;
begin
  Result := 17;
end;

function TcxGridTableViewExport.IsOffice11Style: Boolean;
begin
  Result := TcxGridTableView(FGridView).OptionsView.GroupRowStyle = grsOffice11;
end;

procedure TcxGridTableViewExport.CorrectBottomBorders(ARow: Integer);
var
  I: Integer;
  AStyle: TcxCacheCellStyle;
  AStyleP: PcxCacheCellStyle;
begin
  for I := 0 to Map.Lines[0].Count - 1 do
  begin
    AStyleP := FExport.GetCellStyle(I, ARow);
    if AStyleP <> nil then
    begin
      AStyle := AStyleP^;
      if AStyle.Borders[3].Width = 0 then
      begin
        AStyle.Borders[3].Width := 1;
        FExport.SetCellStyle(I, ARow, FExport.RegisterStyle(AStyle));
      end
      else
        Break;
     end;
  end;
end;

procedure TcxGridTableViewExport.CreateScale;
var
  I: Integer;
  ATotalWidth: Integer;
begin
  with GetViewInfo.HeaderViewInfo do
  begin
    ATotalWidth := 0;
    for I := 0 to Count - 1 do
    begin
      with Items[I] do
      begin
        Inc(ATotalWidth, Width);
        Map.UpdateScale(ATotalWidth);
      end;
    end;
  end;

  if GetVisibleColumnCount > 0 then
    CreateGroupScale;
end;

procedure TcxGridTableViewExport.ExpandSelectedRecords;
var
  I: Integer;
  J: Integer;
  APrevRowCount: Integer;
  ALastRowCount: Integer;
begin
  with TcxGridTableView(FGridView).ViewData do
  begin
    I := 0;
    ALastRowCount := RowCount;
    while ALastRowCount > 0 do
    begin
      APrevRowCount := RowCount;
      if Rows[I].Selected then
      begin
        Rows[I].Expand(True);
        for J := I + 1 to I + RowCount - APrevRowCount do
          Rows[J].Expand(True);
      end;
      Inc(I, RowCount - APrevRowCount + 1);
      Dec(ALastRowCount);
    end;
  end;
end;

procedure TcxGridTableViewExport.FullExpandRecords;
begin
  TcxGridTableView(FGridView).ViewData.Expand(True);
end;

function TcxGridTableViewExport.GetDefaultStyle: TcxCacheCellStyle;
begin
  Result := DefaultCellStyle;
end;

function TcxGridTableViewExport.GetExpandButtonStyle: TcxCacheCellStyle;
begin
  Result := DefaultExpandButtonStyle;
end;

function TcxGridTableViewExport.GetFooterCellStyle(ARow: TcxCustomGridRow;
  ALevel: Integer; AColumnNumber: Integer): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  with TcxGridTableView(FGridView) do
  begin
    Result := DefaultHeaderStyle;
    Result.AlignText := AlignmentToExportAlignment(GetColumnFooterAlignment(AColumnNumber));
    Columns[AColumnNumber].Styles.GetFooterParams(ARow, ALevel, AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;
end;

function TcxGridTableViewExport.GetFooterStyle(ARow: TcxCustomGridRow;
  ALevel: Integer): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  with TcxGridTableView(FGridView) do
  begin
    Result := DefaultHeaderStyle;
    Styles.GetFooterParams(ARow, nil, ALevel, AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;
end;

function TcxGridTableViewExport.GetGroupRowStyle(ARecord: TcxCustomGridRecord; ALevel: Integer): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  with TcxGridTableView(FGridView) do
  begin
    Result := DefaultHeaderStyle;
    Result.AlignText := AlignmentToExportAlignment(taLeftJustify);
    SetGridLines(Result);
    Styles.GetGroupParams(ARecord, ALevel, AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;
end;

function TcxGridTableViewExport.GetGroupScaleItemSize: Integer;
begin
  Result := 16;
end;

function TcxGridTableViewExport.GetHeaderStyle(AColumnNumber: Integer): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  with TcxGridTableView(FGridView) do
  begin
    Result := DefaultHeaderStyle;
    Result.AlignText := AlignmentToExportAlignment(GetColumnHeaderAlignment(AColumnNumber));
    Columns[AColumnNumber].Styles.GetHeaderParams(AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;
end;

function TcxGridTableViewExport.GetRowCount: Integer;
begin
  if SaveAll then
    Result := TcxGridTableView(FGridView).ViewData.RowCount
  else
    Result := SelectedRowCount;
end;

function TcxGridTableViewExport.GetIsRowRealSelected(
  AIndex: Integer): Boolean;
begin
  if SaveAll then
    Result := True
  else
    Result := IsRowRealSelected[AIndex];
end;

function TcxGridTableViewExport.GetRows(AIndex: Integer): TcxCustomGridRow;
begin
  if SaveAll then
    if TcxGridTableView(FGridView).ViewData.RowCount = 0 then
      Result := nil
    else
      Result := TcxGridTableView(FGridView).ViewData.Rows[AIndex]
  else
    Result := TcxCustomGridRow(SelectedRows[AIndex]);
end;

function TcxGridTableViewExport.GetRowLevelStyle(ARecord: TcxCustomGridRecord; ALevel: Integer): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  with TcxGridTableView(FGridView).Styles do
  begin
    Result := DefaultLevelStyle;
    if not HasHorizontalGridLines then
    begin
      Result.Borders[0].Width := 0;
      Result.Borders[2].Width := 0;
    end;
    GetGroupParams(nil, ALevel, AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;
end;

function TcxGridTableViewExport.GetVisibleColumnCount: Integer;
begin
  with TcxGridTableView(FGridView) do
    Result := VisibleColumnCount;
end;

procedure TcxGridTableViewExport.InsertRightCellBorders;
var
  I: Integer;
  AStyle: TcxCacheCellStyle;
  AStyleP: PcxCacheCellStyle;  
begin
  for I := 0 to FCacheRowCount - 1 do
  begin
    AStyleP := FExport.GetCellStyle(FCacheColumnCount - 1, I);
    if AStyleP <> nil then
    begin
      AStyle := AStyleP^;
      AStyle.Borders[2].Width := 1;
      FExport.SetCellStyle(FCacheColumnCount - 1, I, FExport.RegisterStyle(AStyle));
    end;
  end;
end;

procedure TcxGridTableViewExport.SetGridLines(var AStyle: TcxCacheCellStyle);
begin
  if HasHorizontalGridLines then
  begin
    AStyle.Borders[1].Width := 1;
    AStyle.Borders[3].Width := 1;
  end
  else
  begin
    AStyle.Borders[1].Width := 0;
    AStyle.Borders[3].Width := 0;
  end;
  if HasVerticalGridLines then
  begin
    AStyle.Borders[0].Width := 1;
    AStyle.Borders[2].Width := 1;
  end
  else
  begin
    AStyle.Borders[0].Width := 0;
    AStyle.Borders[2].Width := 0;
  end;
end;

function TcxGridTableViewExport.IsGroupsAlwaysExpanded: Boolean;
begin
  Result := dcoGroupsAlwaysExpanded in (FGridView as TcxCustomGridTableView).DataController.Options;
end;

{ TcxGridBandedTableViewExport }

constructor TcxGridBandedTableViewExport.Create(AFileName: string;  AExportType: Integer;
    AGridView: TcxCustomGridView; AGrid: TcxCustomGrid; AViewInfo: TcxCustomGridViewInfo = nil);
begin
  inherited Create(AFileName, AExportType, AGridView, AGrid, AViewInfo);

  FLinesTotalWidth := nil;
  FRowCount := -1;
  FNewBandWidth := -1;
  FVertSeparatorPos := TList.Create;
  FVertSeparatorPosCreated := False;
  FBandMap := TcxGridExportBandMap.Create;
end;

destructor TcxGridBandedTableViewExport.Destroy;
var
  I: Integer;
begin
  if FVertSeparatorPos <> nil then
  begin
    for I := 0 to FVertSeparatorPos.Count - 1 do
      Dispose(PInteger(FVertSeparatorPos[I]));
    FVertSeparatorPos.Free;
  end;
  FBandMap.Free;
  inherited Destroy;
end;

function TcxGridBandedTableViewExport.CalculateRowCount: Integer;
begin
  if FRowCount < 0 then
  begin
    Result := 0;
    if IsBandVisible then
      Inc(Result, GetBandsLineCount);
    Inc(Result, inherited CalculateRowCount);
    FRowCount := Result;
  end
  else
    Result := FRowCount;
end;

procedure TcxGridBandedTableViewExport.CreateBandsExportCache(var AStartRow: Integer);
var
  I: Integer;
begin
  if not IsBandVisible then Exit;
  Inc(AStartRow, GetBandsLineCount);
  for I := 0 to FBandMap.Count - 1 do
  with FBandMap[I] do
  begin
    FExport.SetCellStyleEx(X, AStartRow - Y - 1, Height, Width, FExport.RegisterStyle(GetBandStyle(FBandMap.Bands[I].Index)));
    FExport.SetCellDataString(X, AStartRow - Y - 1, Text);
  end;
end;

procedure TcxGridBandedTableViewExport.CreateExportCache;
var
  I, J: Integer;
  AStartRow: Integer;
begin
  RegisterStyles;
  if not SaveAll then
    CreateSelectedRows;
  if GetVisibleBandCount > 0 then
  begin
    if SaveAll or (SelectedRowCount > 0) or IsHeaderVisible or IsFooterVisible then
    begin
      //////////////////////////////////
      if GetVisibleColumnCount = 0 then
        FExport.SetRange(Map.ScaleItemCount, 1, False)
      else
      //////////////////////////////////
        SetRange;//FExport.SetRange(Map.ScaleItemCount, CalculateRowCount, False);
      for I := 0 to Map.ScaleItemCount - 1 do
        FExport.SetColumnWidth(I, Map.ScaleItems[I]);

      AStartRow := 0;
      CreateBandsExportCache(AStartRow);

      if (GetVisibleColumnCount > 0){ or (GetGroupedColumnCount > 0) }then
      begin
        // Header empty space
        for I := 0 to Map.ScaleItemCount - 1 do
          for J := AStartRow to AStartRow + GetHeaderLineCount - 1 do
            FExport.SetCellStyle(I, J, FExport.RegisterStyle(GetHeaderEmptySpaceStyle(GetBandNumber(I))));

        CreateVertSeparatorPos;
        InternalCreateExportCache(AStartRow);
      end;
    end;
  end;
end;

procedure TcxGridBandedTableViewExport.CreateParentBandMap(ABandViewInfo: TcxGridBandViewInfo);
begin
  if FBandMap.AddParentBand(ABandViewInfo) then
    if ABandViewInfo.Band.ParentBand <> nil then
      CreateParentBandMap(ABandViewInfo.ParentBandViewInfo);
end;

procedure TcxGridBandedTableViewExport.CreateParentBandsMap;
var
  I: Integer;
begin
  with GetViewInfo.HeaderViewInfo.BandsViewInfo do
  begin
    for I := 0 to BottomItemCount - 1 do
      FBandMap.AddBottomBand(BottomItems[I], Map.BandLine.Items[I]);
    for I := 0 to BottomItemCount - 1 do
    begin
      if BottomItems[I].Band.ParentBand <> nil then
        CreateParentBandMap(BottomItems[I].ParentBandViewInfo);
    end;
  end;
end;

procedure TcxGridBandedTableViewExport.CreateMap;
var
  I: Integer;
  ATotalWidth: Integer;
begin
  CreateScale;
  with GetViewInfo.HeaderViewInfo.BandsViewInfo do
  begin
    ATotalWidth := 0;
    for I := 0 to BottomItemCount - 1 do
    begin
      CreateBandMap(I, ATotalWidth);
      with BottomItems[I] do
      begin
        with RowsViewInfo do
        begin
          if (I = 0) and (FNewBandWidth > 0) then
          begin
            Map.AddBandRect(ATotalWidth, FNewBandWidth, BandViewInfo.HeaderViewInfo.RowCount, Band.Index, Band.Caption);
            Inc(ATotalWidth, FNewBandWidth);
          end
          else
          begin
            Map.AddBandRect(ATotalWidth, Width, BandViewInfo.HeaderViewInfo.RowCount, Band.Index, Band.Caption);
            Inc(ATotalWidth, Width);
          end;
        end;
      end;
    end;
  end;
  CreateParentBandsMap;
end;

procedure TcxGridBandedTableViewExport.CreateBandMap(ABandIndex, ABandStartX: Integer);
var
  I: Integer;
begin
  with GetViewInfo.HeaderViewInfo.BandsViewInfo do
  begin
    CreateLinesTotalWidth(LineCount, ABandStartX);
    with BottomItems[ABandIndex] do
    begin
      for I := 0 to ColumnViewInfoCount - 1 do
      begin
        with ColumnViewInfos[I] do
        begin
          Map.AddRect(GetTotalWidth(Column.Position.RowIndex), Column.Position.RowIndex,
              Width, Column.Position.LineCount, Column.Index, Column.Caption);
          SetTotalWidth(Column.Position.RowIndex, GetTotalWidth(Column.Position.RowIndex) +
              Width);
        end;
      end;
    end;
  end;
  FreeLinesTotalWidth;
end;

procedure TcxGridBandedTableViewExport.CreateContentExportCache(
  AStartRow, ARecordNumber, ALevel: Integer; AContentKind: TcxGridContentKind);
var
  AMaxHeights: TList;

  procedure FreeMaxHeights;
  var
    I: Integer;
  begin
    if AMaxHeights <> nil then
    begin
      for I := 0 to AMaxHeights.Count - 1 do
        Dispose(PInteger(AMaxHeights[I]));
      AMaxHeights.Free;
    end;
    AMaxHeights := nil;
  end;

  procedure CreateMaxHeights(ACount: Integer);
  var
    I: Integer;
    P: PInteger;
  begin
    FreeMaxHeights;
    AMaxHeights := TList.Create;
    for I := 0 to ACount - 1 do
    begin
      New(P);
      P^ := 0;
      AMaxHeights.Add(P);
    end;
  end;

  procedure SetMaxHeights(AIndex: Integer; AValue: Integer);
  begin
    PInteger(AMaxHeights[AIndex])^ := AValue;
  end;

  function GetMaxHeights(AIndex: Integer): Integer;
  begin
    Result := PInteger(AMaxHeights[AIndex])^;
  end;

var
  I, J, K: Integer;
  ABandNumber: Integer;
  ANewBandNumber: Integer;
  ARow: Integer;
  AFlag: Boolean;
  AStartX: Integer;
  AStartXX: Integer;
  AStartY: Integer;
  AHeight: Integer;
  AWidth: Integer;
  AValue: string;
  AValue1: Variant;
  AStyle: Integer;
  ABaseStyle: TcxCacheCellStyle;
  ABaseStylePointer: PcxCacheCellStyle;
  ARealLevel: Integer;
begin
  AStartX := 0;
  AStartY := 0;
  AHeight := 0;
  AWidth := 0;
  AValue := '';

  AMaxHeights := nil;
  CreateMaxHeights(Map.BandLine.Count);
  ARow := AStartRow;
  AFlag := True;
  ABandNumber := -1;
  AStyle := -1;

  // Footer empty space
  if (AContentKind = gckFooter) or (AContentKind = gckGroupFooter) then
  begin
    for I := 0 to Map.ScaleItemCount - 1 do
      for J := AStartRow to AStartRow + GetHeaderLineCount - 1 do
        FExport.SetCellStyle(I, J, GetFooterEmptySpaceStyle(GetRows(ARecordNumber), ALevel));
  end
  // Record empty space
  else if AContentKind = gckRecord then
  begin
    for I := 0 to Map.ScaleItemCount - 1 do
      for J := AStartRow to AStartRow + GetHeaderLineCount - 1 do
        FExport.SetCellStyle(I, J, GetRecordEmptySpaceStyle(GetRows(ARecordNumber), GetBandNumber(I)));
  end;

  // Cells
  with Map do
  begin
    for I := 0 to LineCount - 1 do
    begin
      for J := 0 to Lines[I].Count - 1 do
      begin
        with Lines[I].Items[J] do
        begin
          ANewBandNumber := GetBandNumber(StartX);
          if ANewBandNumber <> ABandNumber then
          begin
            ABandNumber := ANewBandNumber;
            ARow := AStartRow + GetMaxHeights(ABandNumber);
            AFlag := True;
          end
          else
          begin
            if not AFlag then
            begin
              ARow := AStartRow + GetMaxHeights(ABandNumber);
              AFlag := True;
            end;
          end;

          case AContentKind of
            gckHeader:              // Header
            begin
              AStartX := StartX;
              AStartY := ARow;
              AHeight := Height;
              AWidth := Width;
              AValue := Value;
              AStyle := FExport.RegisterStyle(GetHeaderStyle(Index));
            end;
            gckRecord:              // Record
            begin
              ARealLevel := ALevel;
              if (J = 0) and (ABandNumber = 0) then
              begin
                AStartX := ALevel;
                if IsMasterView then
                  if (FGridView.Level as TcxGridLevel).VisibleCount > 0 then
                    Inc(AStartX);
                AWidth := Width - AStartX;
                if IsOffice11Style and (ALevel > 0) then
                begin
                  Dec(AStartX);
                  Inc(AWidth);
                end;
              end
              else
              begin
                AStartX := StartX;
                AWidth := Width;
              end;
              if IsOffice11Style and (ARealLevel > 0) then
                Dec(ARealLevel);
              for K := 0 to Height - 1 do
                SetLevelStyle(ARealLevel, ARow + K, GetRows(ARecordNumber));
              AStartY := ARow;
              AHeight := Height;
              if FUseNativeFormat then
                AValue1 := GetDisplayValue(Index, ARecordNumber)
              else
                AValue := GetDisplayText(Index, ARecordNumber);
              AStyle := FExport.RegisterStyle(GetRecordStyle(GetRows(ARecordNumber), Index));
            end;
            gckFooter:              // Footer
            begin
              AStartX := StartX;
              AStartY := ARow;
              AHeight := Height;
              AWidth := Width;
              if FUseNativeFormat then
                AValue1 := GetFooterDisplayValue(Index)
              else
                AValue := GetFooterDisplayText(Index);
              if (AValue <> '') or not VarIsNull(AValue1) then
                AStyle := FExport.RegisterStyle(GetFooterCellStyle(GetRows(ARecordNumber), 0, Index))
              else
                AStyle := FExport.RegisterStyle(GetFooterStyle(GetRows(ARecordNumber), 0));
            end;
            gckGroupFooter:         // Group Footer
            begin
              if (J = 0) and (ABandNumber = 0) then
              begin
                if GetGroupFootersMode = gfVisibleWhenExpanded then
                begin
                  AStartX := ALevel + 1;
                  AWidth := Width - ALevel - 1;
                  if IsOffice11Style and (AStartX = GetGroupColumnCount) then
                  begin
                    Dec(AStartX);
                    Inc(AWidth);
                  end;
                  SetLevelStyle(ALevel + 1, ARow, GetRows(ARecordNumber));
                end
                else
                begin
                  AStartX := ALevel;
                  AWidth := Width - ALevel;
                  SetLevelStyle(ALevel, ARow, GetRows(ARecordNumber));
                end;
              end
              else
              begin
                AStartX := StartX;
                AWidth := Width;
              end;
              ARealLevel := ALevel;
              for K := 0 to Height - 1 do
                if GetGroupFootersMode = gfVisibleWhenExpanded then
                begin
                  if IsOffice11Style and (ARealLevel = GetGroupColumnCount - 1) then
                    Dec(ARealLevel);
                  SetLevelStyle(ARealLevel + 1, ARow + K, GetRows(ARecordNumber));
                end
                else
                  SetLevelStyle(ARealLevel, ARow + K, GetRows(ARecordNumber));
              AStartY := ARow;
              AHeight := Height;
              if FUseNativeFormat then
                AValue1 := GetGroupFooterDisplayValue(Index, ARecordNumber, ALevel)
              else
                AValue := GetGroupFooterDisplayText(Index, ARecordNumber, ALevel);
              if (AValue <> '') or not VarIsNull(AValue1) then
                AStyle := FExport.RegisterStyle(GetFooterCellStyle(GetRows(ARecordNumber), ARealLevel, Index))
              else
                AStyle := FExport.RegisterStyle(GetFooterStyle(GetRows(ARecordNumber), ARealLevel));
            end;
          end;
          if AContentKind in [gckRecord, gckFooter, gckGroupFooter] then
          begin
            if FUseNativeFormat then
              FExport.SetCellValue(AStartX, AStartY, AValue1)
            else
              FExport.SetCellDataString(AStartX, AStartY, AValue);
          end
          else
            FExport.SetCellDataString(AStartX, AStartY, AValue);
          FExport.SetCellStyleEx(AStartX, AStartY, AHeight, AWidth, AStyle);
          if GetMaxHeights(ABandNumber) < ARow + Height - AStartRow then
            SetMaxHeights(ABandNumber, ARow + Height - AStartRow);
        end;
      end;
      AFlag := False;
    end;
  end;

  // footer separators
  if (AContentKind = gckFooter) or (AContentKind = gckGroupFooter) then
  begin
    AFlag := False;
    if AContentKind = gckFooter then
      AStartXX := 0
    else
    begin
      if GetGroupFootersMode = gfVisibleWhenExpanded then
        AStartXX := ALevel + 1
      else
        AStartXX := ALevel;
    end;
    for I := 0 to Map.ScaleItemCount - 1 do
      for J := AStartRow to AStartRow + GetHeaderLineCount - 1 do
      begin
        if I >= AStartXX then
        begin
          ABaseStyle := FExport.GetCellStyle(I, J)^;
          if J = AStartRow then
          begin
            ABaseStyle.Borders[1].Width := 1;
            AFlag := True;
          end;
          if J = AStartRow + GetHeaderLineCount - 1 then
          begin
            ABaseStyle.Borders[3].Width := 1;
            AFlag := True;
          end;
          if AFlag then
          begin
            FExport.SetCellStyle(I, J, ABaseStyle);
            AFlag := False;
          end;
        end;
      end;
  end

  // record separators
  else if AContentKind = gckRecord then
  begin
    ARealLevel := ALevel;
    if IsOffice11Style and (ALevel > 0) then
      Dec(ARealLevel);
    AFlag := False;
    for I := 0 to Map.ScaleItemCount - 1 do
      for J := AStartRow to AStartRow + GetHeaderLineCount - 1 do
      begin
        if I >= ARealLevel then
        begin
          ABaseStylePointer := FExport.GetCellStyle(I, J);
          if ABaseStylePointer = nil then
            Continue;
          ABaseStyle := ABaseStylePointer^;
          if IsVertSeparatorPos(I) then
          begin
            if HasVerticalGridLines then
            begin
              ABaseStyle.Borders[2].Width := 1;
              AFlag := True;
            end;
          end;
          if (I > 0) and IsVertSeparatorPos(I - 1) then
          begin
            if HasVerticalGridLines then
            begin
              ABaseStyle.Borders[0].Width := 1;
              AFlag := True;
            end;
          end;
          if J = AStartRow then
          begin
            if HasHorizontalGridLines then
            begin
              ABaseStyle.Borders[1].Width := 1;
              AFlag := True;
            end;
          end;
          if J = AStartRow + GetHeaderLineCount - 1 then
          begin
            if HasHorizontalGridLines then
            begin
              ABaseStyle.Borders[3].Width := 1;
              AFlag := True;
            end;
          end;
          if AFlag then
          begin
            FExport.SetCellStyle(I, J, ABaseStyle);
            AFlag := False;
          end;
        end;
      end;
  end;
  FreeMaxHeights;
end;

function TcxGridBandedTableViewExport.GetBandAlignment(ABandNumber: Integer): TAlignment;
begin
  with TcxGridBandedTableView(FGridView).Bands.Items[ABandNumber] do
    Result := Alignment;
end;

function TcxGridBandedTableViewExport.GetBandsLineCount: Integer;
begin
  Result := GetViewInfo.HeaderViewInfo.BandsViewInfo.BandHeaderRowCount;
end;

function TcxGridBandedTableViewExport.GetHeaderLineCount: Integer;
begin
  with GetViewInfo.HeaderViewInfo do
    Result := LineCount;
end;

function TcxGridBandedTableViewExport.GetFooterDisplayValue(ACol: Integer): Variant;
var
  AColumn: TcxGridColumn;
  AIndex: Integer;
begin
  with TcxGridBandedTableView(FGridView) do
  begin
    AColumn := Columns[ACol];
    AIndex := GetFooterItemIndex(AColumn.VisibleIndex);
    Result := DataController.Summary.FooterSummaryValues[AIndex];
  end;
end;

function TcxGridBandedTableViewExport.GetFooterDisplayText(ACol: Integer): string;
begin
  with GetViewInfo.FooterViewInfo.Items[TcxGridBandedTableView(FGridView).Columns[ACol].VisibleIndex] do
    Result := Text;
end;

function TcxGridBandedTableViewExport.GetGroupFooterDisplayValue(ACol,
  ARow, ALevel: Integer): Variant;
var
  AColumn: TcxGridColumn;
begin
  with TcxGridBandedTableView(FGridView) do
  begin
    AColumn := Columns[ACol];
    with DataController.Summary do
      Result := GroupSummaryDisplayValues[ARow, ALevel, GroupFooterIndexOfItemLink[ALevel, AColumn]];
  end;
end;

function TcxGridBandedTableViewExport.GetGroupFooterDisplayText(ACol,
  ARow, ALevel: Integer): string;
var
  AColumn: TcxGridColumn;
begin
  with TcxGridBandedTableView(FGridView) do
  begin
    AColumn := Columns[ACol];
    with DataController.Summary do
      Result := GroupFooterSummaryTexts[ARow, ALevel, GroupFooterIndexOfItemLink[ALevel, AColumn]];
  end;
end;

function TcxGridBandedTableViewExport.GetViewInfo: TcxGridBandedTableViewInfo;
begin
  if FViewInfo = nil then
    Result := TcxGridBandedTableView(FGridView).ViewInfo
  else
    Result := TcxGridBandedTableViewInfo(FViewInfo);
end;

function TcxGridBandedTableViewExport.IsBandVisible: Boolean;
begin
  with TcxGridBandedTableView(FGridView).OptionsView do
    Result := BandHeaders;
end;

procedure TcxGridBandedTableViewExport.RegisterStyles;
begin
  inherited RegisterStyles;
end;

procedure TcxGridBandedTableViewExport.CreateBandScale(ABandIndex,
  ABandStartX: Integer);
var
  I: Integer;
begin
  with GetViewInfo.HeaderViewInfo.BandsViewInfo do
  begin
    CreateLinesTotalWidth(LineCount, ABandStartX);
    with BottomItems[ABandIndex] do
    begin
      for I := 0 to ColumnViewInfoCount - 1 do
      begin
        with ColumnViewInfos[I] do
        begin
          SetTotalWidth(Column.Position.RowIndex, GetTotalWidth(Column.Position.RowIndex) + Width);
          Map.UpdateScale(GetTotalWidth(Column.Position.RowIndex));
        end;
      end;
    end;
  end;
  FreeLinesTotalWidth;
end;

procedure TcxGridBandedTableViewExport.CreateLinesTotalWidth(ACount: Integer; AStartValue: Integer);
var
  I: Integer;
  P: PInteger;
begin
  FreeLinesTotalWidth;

  FLinesTotalWidth := TList.Create;
  for I := 0 to ACount - 1 do
  begin
    New(P);
    P^ := AStartValue;
    FLinesTotalWidth.Add(P);
  end;
end;

procedure TcxGridBandedTableViewExport.CreateScale;
var
  I: Integer;
  ATotalWidth: Integer;
begin
  with GetViewInfo.HeaderViewInfo.BandsViewInfo do
  begin
    ATotalWidth := 0;
    for I := 0 to BottomItemCount - 1 do
    begin
      CreateBandScale(I, ATotalWidth);
      with BottomItems[I].RowsViewInfo do
      begin
        if (I = 0) and (Width <= GetGroupColumnCount * GetGroupScaleItemSize) then
        begin
          if IsMasterView and ((FGridView.Level as TcxGridLevel).VisibleCount > 0) then
            FNewBandWidth := GetGroupColumnCount * GetGroupScaleItemSize + GetGroupScaleItemSize
          else
            FNewBandWidth := GetGroupColumnCount * GetGroupScaleItemSize + 1;
          Inc(ATotalWidth, FNewBandWidth)
        end
        else
          Inc(ATotalWidth, Width);

        Map.UpdateScale(ATotalWidth);
      end;
    end;
  end;

  if (GetVisibleBandCount > 0) and (GetVisibleColumnCount > 0) then
    CreateGroupScale;
end;

procedure TcxGridBandedTableViewExport.CreateVertSeparatorPos;
var
  P: PInteger;
  I: Integer;
begin
  if not FVertSeparatorPosCreated then
  begin
    for I := 1 to Map.ScaleItemCount - 1 do
    begin
      if GetBandNumber(I) > GetBandNumber(I - 1) then
      begin
        New(P);
        P^ := I - 1;
        FVertSeparatorPos.Add(P);
      end;
    end;

    FVertSeparatorPosCreated := True;
  end;
end;

procedure TcxGridBandedTableViewExport.FreeLinesTotalWidth;
var
  I: Integer;
begin
  if FLinesTotalWidth <> nil then
  begin
    for I := 0 to FLinesTotalWidth.Count - 1 do
      Dispose(PInteger(FLinesTotalWidth[I]));
    FLinesTotalWidth.Free;
    FLinesTotalWidth := nil;
  end;
end;

function TcxGridBandedTableViewExport.GetBandNumber(AI: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  with Map.BandLine do
    for I := 0 to Map.BandLine.Count - 1 do
      with Items[I] do
        if (AI >= StartX) and (AI < StartX + Width) then
        begin
          Result := I;
          Exit;
        end;
end;

function TcxGridBandedTableViewExport.GetBandStyle(ABandNumber: Integer): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  with TcxGridBandedTableView(FGridView).Bands.Items[ABandNumber] do
  begin
    Result := DefaultBandStyle;
    Result.AlignText := AlignmentToExportAlignment(GetBandAlignment(ABandNumber));
    Styles.GetHeaderParams(AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;
end;

function TcxGridBandedTableViewExport.GetFooterEmptySpaceStyle(ARow: TcxCustomGridRow;
  ALevel: Integer): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
begin
  with TcxGridTableView(FGridView).Styles do
  begin
    Result := DefaultFooterEmptySpaceStyle;
    GetFooterParams(ARow, nil, ALevel, AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;

  Result.FontStyle := [];
end;

function TcxGridBandedTableViewExport.GetHeaderEmptySpaceStyle(ABandNumber: Integer): TcxCacheCellStyle;
var
  AViewParams: TcxViewParams;
  ABand: TcxGridBand;
begin
  ABand := TcxGridBandedTableView(FGridView).Bands.VisibleBottomItems[ABandNumber];
  with ABand.Styles do
  begin
    Result := DefaultHeaderEmptySpaceStyle;
    GetViewParams(bsBackground, ABand, nil, AViewParams);
    ViewParamsToExportStyle(AViewParams, Result);
  end;
  Result.FontStyle := [];
end;

function TcxGridBandedTableViewExport.GetRecordEmptySpaceStyle(ARecord: TcxCustomGridRecord;
  ABandNumber: Integer): TcxCacheCellStyle;
var
  ACellPos: TcxGridDataCellPos;
  AViewParams: TcxViewParams;
  ABand: TcxGridBand;
begin
  ACellPos := TcxGridDataCellPos.Create;
   try
     with ACellPos do
     begin
       GridRecord := ARecord;
       Item := nil;
      end;
      Result := DefaultRecordEmptySpaceStyle;
      ABand := TcxGridBandedTableView(FGridView).Bands.VisibleBottomItems[ABandNumber];
      ABand.Styles.GetViewParams(bsContent, ACellPos, nil, AViewParams);
      ViewParamsToExportStyle(AViewParams, Result);
      Result.FontStyle := [];
    finally
      ACellPos.Free;
    end;
end;

function TcxGridBandedTableViewExport.GetTotalWidth(Index: Integer): Integer;
begin
  if Index >= FLinesTotalWidth.Count then
    Index := FLinesTotalWidth.Count - 1;
  if FLinesTotalWidth <> nil then
    Result := PInteger(FLinesTotalWidth[Index])^
  else
    Result := -1;
end;

function TcxGridBandedTableViewExport.GetVisibleBandCount: Integer;
begin
  with TcxGridBandedTableView(FGridView).Bands do
    Result := VisibleCount;
end;

function TcxGridBandedTableViewExport.IsVertSeparatorPos(APos: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;

  for I := 0 to FVertSeparatorPos.Count - 1 do
    if APos = PInteger(FVertSeparatorPos[I])^ then
    begin
      Result := True;
      Exit;
    end;
end;

procedure TcxGridBandedTableViewExport.SetTotalWidth(Index,
  AValue: Integer);
begin
  if Index >= FLinesTotalWidth.Count then
    Index := FLinesTotalWidth.Count - 1;
  if FLinesTotalWidth <> nil then
    PInteger(FLinesTotalWidth[Index])^ := AValue;
end;

initialization
  cxExportInit(TcxGetResourceStringProc(@cxGetResourceString), @ColorToRGB,  True );

end.
