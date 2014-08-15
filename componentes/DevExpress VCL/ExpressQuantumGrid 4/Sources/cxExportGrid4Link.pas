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

{$I cxGridVer.inc}

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
  Classes, SysUtils, cxGridCustomView, cxGridViewData, cxCustomData,
  cxGridCustomTableView, cxStyles, cxGridCardView, cxGridLevel, cxEdit,
  cxCalendar, cxCurrencyEdit, cxSpinEdit, cxCalc, cxTimeEdit, cxGraphics,
  cxClasses, cxGridStrs, cxDataUtils, cxGridDBDataDefinitions, dxCore;

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
  cxXLSExport, cxHtmlXmlTxtExport;

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
    procedure AddBandRect(AStart, AWidth, AIndex: Integer; ACaption: string);
    procedure AddRect(AStartX, AStartY, AWidth, AHeight, AIndex: Integer; ACaption: string);
    procedure DeleteScaleItem(AIndex: Integer);
    function GetScaleIndex(AValue: Integer): Integer;
    procedure UpdateScale(AX: Integer);
    property BandLine: TcxGridExportTableMapLine read FBandLine;
    property LineCount: Integer read GetLineCount;
    property Lines[Index: Integer]: TcxGridExportTableMapLine read GetLines;
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
    FExport: IcxExportProvider;
    FExportType: Integer;
    FExpand: Boolean;
    FFileName: string;
    FSaveAll: Boolean;
    FViewInfo: TcxCustomGridViewInfo;
    FUseNativeFormat: Boolean;
    FSeparators: TStringList;
    procedure AddSelectedRow(ARow: TcxCustomGridRecord; AIsRealSelected: Boolean);
    function AlignmentToExportAlignment(AAlignment: TAlignment): TcxAlignText;
    function CalculateRowCount: Integer; dynamic; abstract;
    procedure CreateExportCache; dynamic; abstract;
    procedure DoCreateExportCache; dynamic; 
    function NativeFormatProperties(AProperties: TcxCustomEditProperties): Boolean;
    procedure RegisterStyles; virtual; abstract;
    procedure StyleToExportStyle(AStyle: TcxStyle; var AExportStyle: TcxCacheCellStyle;
      AColor: Boolean = True; ATextColor: Boolean = True; AFont: Boolean = True);
    property IsRowRealSelected[Index: Integer]: Boolean read GetIsRowRealSelected;
    property SelectedRowCount: Integer read GetSelectedRowCount;
    property SelectedRows[Index: Integer]: TcxCustomGridRecord read GetSelectedRows;
  public
    constructor Create(AFileName: string; AExportType: Integer; AGridView: TcxCustomGridView;
        AViewInfo: TcxCustomGridViewInfo = nil); virtual;
    destructor Destroy; override;
    procedure DoExport; dynamic; abstract;
    property Expand: Boolean read FExpand write FExpand;
    property SaveAll: Boolean read FSaveAll write FSaveAll;
    property UseNativeFormat: Boolean read FUseNativeFormat write FUseNativeFormat;
    property Separators: TStringList read FSeparators;
  end;

  TcxGridCustomExportClass = class of TcxGridCustomExport;

  { TcxGridCardViewExport }
  TcxGridCardViewExport = class(TcxGridCustomExport)
  private
    FCardColumnCount: Integer;
    FCardRowCount: Integer;
    FTotalColumnCount: Integer;
    FTotalRowCount: Integer;
    function GetBorderColor: Integer;
    function GetCaptionStyle(ANumber: Integer): TcxCacheCellStyle;
    function GetCardBorderWidth: Integer;
//    function GetCardCaptionWidth(ACardNumber: Integer): Integer;
    function GetCardContentWidth: Integer;
    function GetCardCount: Integer;
    function GetCardColumnCount: Integer;
    function GetCardRowCount: Integer;
    function GetCards(AIndex: Integer): TcxGridCard;
    function GetEmptySpaceSize: Integer;
    function GetEmptySpaceStyle: TcxCacheCellStyle;
    function GetHeaderEvenStyle(ANumber: Integer): TcxCacheCellStyle;
    function GetHeaderOddStyle(ANumber: Integer): TcxCacheCellStyle;
    function GetLayoutDirection: TcxGridCardViewLayoutDirection;
    function GetRecordEvenStyle(ANumber: Integer): TcxCacheCellStyle;
    function GetRecordOddStyle(ANumber: Integer): TcxCacheCellStyle;
    function GetSeparatorColor: Integer;
    function GetSeparatorWidth: Integer;
    function GetVisibleCardColumnCount: Integer;
    function GetVisibleCardRowCount: Integer;
    function GetVisibleRowCount: Integer;
    procedure RegisterCardRowStyles;
    procedure RegisterSeparatorStyles;
  protected
    cxCardRecordEvenStyle: array of Integer;
    cxCardRecordOddStyle: array of Integer;
    cxCardHeaderEvenStyle: array of Integer;
    cxCardHeaderOddStyle: array of Integer;
    cxCardRecordCaptionStyle: array of Integer;
    cxCardHeaderCaptionStyle: array of Integer;
    cxCardEmptySpaceStyle: Integer;
    cxCardLeftSeparatorStyle: Integer;
    cxCardUpSeparatorStyle: Integer;
    cxCardRightSeparatorStyle: Integer;
    cxCardDownSeparatorStyle: Integer;
    function CalculateColumnCount: Integer;
    function CalculateRowCount: Integer; override;
    procedure CreateBackGround;
    procedure CreateContentExportCache(AStartCol, AStartRow, ACardNumber: Integer);
    procedure CreateHSeparator(ARow: Integer);
    procedure CreateExportCache; override;
    procedure CreateSelectedCards;
    procedure CreateVSeparator(ACol: Integer);
    procedure DoCreateExportCache; override;
    function GetDisplayText(ACardNumber, ADataIndex: Integer): string;
    function GetDisplayValue(ACardNumber, ADataIndex: Integer): Variant; 
    function GetViewInfo: TcxGridCardViewViewInfo;
    procedure InternalCreateExportCache;
    procedure RegisterStyles; override;
  public
    constructor Create(AFileName: string;  AExportType: Integer; AGridView: TcxCustomGridView;
        AViewInfo: TcxCustomGridViewInfo = nil); override;
    destructor Destroy; override;
    procedure DoExport; override;
  end;

  { TcxGridTableViewExport }
  TcxGridTableViewExport = class(TcxGridCustomExport)
  private
    FCacheColumnCount: Integer;
    FCacheRowCount: Integer;
    procedure CorrectBottomBorders(ARow: Integer);
    procedure CreateScale;
    procedure ExpandSelectedRecords;
    procedure FullExpandRecords;

    function GetColumnCount: Integer;
    function GetDefaultStyle: TcxCacheCellStyle;
    function GetExpandButtonStyle(ALevel: Integer): TcxCacheCellStyle;
    function GetFooterStyle(AColumnNumber: Integer): TcxCacheCellStyle;
    function GetGridViewFooterStyle: TcxCacheCellStyle;
    function GetGroupRowEvenStyle(ALevel: Integer): TcxCacheCellStyle;
    function GetGroupRowOddStyle(ALevel: Integer): TcxCacheCellStyle;
    function GetGroupScaleItemSize: Integer;
    function GetHeaderStyle(AColumnNumber: Integer): TcxCacheCellStyle;
    function GetMasterEmptySpaceEvenStyle: TcxCacheCellStyle;
    function GetMasterEmptySpaceOddStyle: TcxCacheCellStyle;
    function GetMasterExpandButtonStyle: TcxCacheCellStyle;
    function GetRowCount: Integer;
    function GetIsRowRealSelected(AIndex: Integer): Boolean;
    function GetRows(AIndex: Integer): TcxCustomGridRow;
    function GetRowLevelStyle(ALevel: Integer): TcxCacheCellStyle;
    function GetVisibleColumnCount: Integer;
    procedure InsertRightCellBorders;
    procedure RegisterColumnStyles;
    procedure RegisterRowLevelStyles;
    procedure SetGridLines(var AStyle: TcxCacheCellStyle);
  protected
    Map: TcxGridExportTableMap;
    cxHeaderStyle:  array of Integer;
    cxFooterStyle: array of Integer;
    cxGridViewFooterStyle: Integer;
    cxGroupRowEvenStyle: array of Integer;
    cxGroupRowOddStyle: array of Integer;
    cxMasterEmptySpaceEvenStyle: Integer;
    cxMasterEmptySpaceOddStyle: Integer;
    cxMasterExpandButtonStyle: Integer;
    cxRecordEvenStyle: array of Integer;
    cxRecordOddStyle: array of Integer;
    cxPreviewStyle: array[Boolean] of Integer;
    cxExpandButtonStyle: array of Integer;
    cxRowLevelStyle: array of Integer;
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
    function GetPreviewEvenStyle: TcxCacheCellStyle; virtual;
    function GetPreviewLineCount: Integer;
    function GetPreviewOddStyle: TcxCacheCellStyle; virtual;
    function GetRecordEvenStyle(AColumnNumber: Integer): TcxCacheCellStyle; virtual;
    function GetRecordOddStyle(AColumnNumber: Integer): TcxCacheCellStyle; virtual;
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
    procedure SetLevelStyle(ALevel, ARow: Integer);
    procedure SetRange;
  public
    constructor Create(AFileName: string; AExportType: Integer; AGridView: TcxCustomGridView;
        AViewInfo: TcxCustomGridViewInfo = nil); override;
    destructor Destroy; override;
    procedure DoExport; override;
  end;

  { TcxGridBandedTableViewExport }
  TcxGridBandedTableViewExport = class(TcxGridTableViewExport)
  private
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
    function GetBandCount: Integer;
    function GetBandNumber(AI: Integer): Integer;
    function GetBandStyle(ABandNumber: Integer): TcxCacheCellStyle;
    function GetFooterEmptySpaceStyle: TcxCacheCellStyle;
    function GetHeaderEmptySpaceStyle(ABandNumber: Integer): TcxCacheCellStyle;
    function GetRecordEvenEmptySpaceStyle(ABandNumber: Integer): TcxCacheCellStyle;
    function GetRecordOddEmptySpaceStyle(ABandNumber: Integer): TcxCacheCellStyle;
    function GetTotalWidth(Index: Integer): Integer;
    function GetVisibleBandCount: Integer;
    function IsVertSeparatorPos(APos: Integer): Boolean;
    procedure RegisterBandStyles;
    procedure SetTotalWidth(Index: Integer; AValue: Integer);
  protected
    cxBandStyle: array of Integer;
    cxHeaderEmptySpaceStyle: array of Integer;
    cxFooterEmptySpaceStyle: Integer;
    cxRecordEvenEmptySpaceStyle: array of Integer;
    cxRecordOddEmptySpaceStyle: array of Integer;
    function CalculateRowCount: Integer; override;
    procedure CreateExportCache; override;
    procedure CreateMap; override;
    procedure CreateBandMap(ABandIndex, ABandStartX: Integer);
    procedure CreateContentExportCache(AStartRow, ARecordNumber, ALevel: Integer;
        AContentKind: TcxGridContentKind); override;
    function GetBandAlignment(ABandNumber: Integer): TAlignment;
    function GetBandLineCount: Integer; virtual;
    function GetHeaderLineCount: Integer; override;
    function GetFooterDisplayValue(ACol: Integer): Variant;
    function GetFooterDisplayText(ACol: Integer): string;
    function GetGroupFooterDisplayValue(ACol, ARow, ALevel: Integer): Variant;
    function GetGroupFooterDisplayText(ACol, ARow, ALevel: Integer): string;
    function GetPreviewEvenStyle: TcxCacheCellStyle; override;
    function GetPreviewOddStyle: TcxCacheCellStyle; override;
    function GetRecordEvenStyle(AColumnNumber: Integer): TcxCacheCellStyle; override;
    function GetRecordOddStyle(AColumnNumber: Integer): TcxCacheCellStyle; override;
    function GetViewInfo: TcxGridBandedTableViewInfo;
    function IsBandVisible: Boolean;
    procedure RegisterStyles; override;
  public
    constructor Create(AFileName: string;  AExportType: Integer; AGridView: TcxCustomGridView;
        AViewInfo: TcxCustomGridViewInfo = nil); override;
    destructor Destroy; override;
  end;

  TcxCustomGridTableViewAccessor = class(TcxCustomGridTableView);
  TcxCustomEditPropertiesAccessor = class(TcxCustomEditProperties);

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

function InternalGetGridExportClass(ALevel: TcxGridLevel): TcxGridCustomExportClass;
var
  AGridView: TcxCustomGridView;
begin
  if ALevel.GridView = nil then
    raise EcxGridExport.Create(cxGetResourceString(@scxNotExistGridView));
  AGridView := ALevel.GridView;

  if AGridView is TcxGridBandedTableView then
    Result := TcxGridBandedTableViewExport
  else if AGridView is TcxGridTableView then
    Result := TcxGridTableViewExport
  else
    Result := TcxGridCardViewExport;
end;

function GetGridExportClass(AGrid: TcxGrid): TcxGridCustomExportClass;
begin
  if AGrid.ActiveLevel = nil then
    raise EcxGridExport.Create(cxGetResourceString(@scxNotExistGridLevel));

  Result := InternalGetGridExportClass(AGrid.FocusedView.Level as TcxGridLevel);
//  Result := InternalGetGridExportClass(AGrid.ActiveLevel);
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
    AGridExport := GetGridExportClass(AGrid).Create(AFileName, AExportType, AView);
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
  for I := 0 to FScale.Count - 1do
    Dispose(PInteger(FScale[I]));
  FScale.Free;
end;

procedure TcxGridExportTableMap.AddBandRect(AStart, AWidth, AIndex: Integer; ACaption: string);
begin
  GetScaleCoords(AStart, AWidth);
  FBandLine.Add(AStart, AWidth, 1, AIndex, ACaption);
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
    AGridView: TcxCustomGridView; AViewInfo: TcxCustomGridViewInfo = nil);
begin
  FGridView := AGridView;
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

procedure TcxGridCustomExport.StyleToExportStyle(AStyle: TcxStyle;
  var AExportStyle: TcxCacheCellStyle; AColor, ATextColor, AFont: Boolean);
begin
  if AStyle <> nil then
  begin
    with AExportStyle do
    begin
      if AColor then
        if cxStyles.svColor in AStyle.AssignedValues then
          BrushBkColor := cxColorToRGB(AStyle.Color);
      if ATextColor then
        if cxStyles.svTextColor in AStyle.AssignedValues then
          FontColor := cxColorToRGB(AStyle.TextColor);
      if AFont then
        if cxStyles.svFont in AStyle.AssignedValues then
        begin
          FillChar(FontName, SizeOf(FontName), 0);
          dxStringToBytes(AStyle.Font.Name, FontName);
          FontStyle := TcxFontStyles(AStyle.Font.Style);
          FontSize := AStyle.Font.Size;
          FontCharset := Integer(AStyle.Font.Charset);
        end;
    end;
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

{ TcxGridCardViewExport }

constructor TcxGridCardViewExport.Create(AFileName: string; AExportType: Integer;
    AGridView: TcxCustomGridView; AViewInfo: TcxCustomGridViewInfo = nil);
begin
  inherited Create(AFileName, AExportType, AGridView, AViewInfo);

  FCardColumnCount := 0;
  FCardRowCount := 0;
  FTotalColumnCount := -1;
  FTotalRowCount := -1;
end;

destructor TcxGridCardViewExport.Destroy;
begin
  SetLength(cxCardRecordEvenStyle, 0);
  SetLength(cxCardRecordOddStyle, 0);
  SetLength(cxCardHeaderEvenStyle, 0);
  SetLength(cxCardHeaderOddStyle, 0);
  SetLength(cxCardRecordCaptionStyle, 0);
  SetLength(cxCardHeaderCaptionStyle, 0);

  inherited Destroy;
end;

procedure TcxGridCardViewExport.DoExport;
begin
  DoCreateExportCache;
  FExport.Commit;
end;

function TcxGridCardViewExport.CalculateColumnCount: Integer;
begin
  if FTotalColumnCount < 0 then
  begin
    Result := GetCardColumnCount;
    FCardColumnCount := Result;
    if Result > 0 then
    begin
      case GetLayoutDirection of
        ldHorizontal:
          Result := Result * 4;
        ldVertical:
          Result := Result * 3 + 1;
      end;
    end;

    FTotalColumnCount := Result;
  end
  else
    Result := FTotalColumnCount;
end;

function TcxGridCardViewExport.CalculateRowCount: Integer;
begin
  if FTotalRowCount < 0 then
  begin
    Result := GetCardRowCount;
    FCardRowCount := Result;
    if Result > 0 then
      Result := Result * (GetVisibleRowCount + 2);

    FTotalRowCount := Result;
  end
  else
    Result := FTotalRowCount;
end;

procedure TcxGridCardViewExport.CreateBackGround;
var
  I, J: Integer;
begin
  for I := 0 to CalculateColumnCount - 1 do
    for J := 0 to CalculateRowCount - 1 do
      FExport.SetCellStyle(I, J, cxCardEmptySpaceStyle);
end;

procedure TcxGridCardViewExport.CreateContentExportCache(AStartCol, AStartRow,
    ACardNumber: Integer);
var
  I: Integer;
  ADataIndex: Integer;
begin
  with TcxGridCardView(FGridView) do
  begin
    for I := 0 to VisibleRowCount - 1 do
    begin
      case VisibleRows[I].Kind of
        rkData:
        begin
          if ACardNumber mod 2 = 0 then
          begin
            FExport.SetCellStyle(AStartCol, AStartRow + I, cxCardHeaderEvenStyle[I]);
            FExport.SetCellStyle(AStartCol + 1, AStartRow + I, cxCardRecordEvenStyle[I]);
          end
          else
          begin
            FExport.SetCellStyle(AStartCol, AStartRow + I, cxCardHeaderOddStyle[I]);
            FExport.SetCellStyle(AStartCol + 1, AStartRow + I, cxCardRecordOddStyle[I])
          end;
        end;
        rkCaption:
        begin
          FExport.SetCellStyle(AStartCol, AStartRow + I, cxCardHeaderCaptionStyle[I]);
          FExport.SetCellStyle(AStartCol + 1, AStartRow + I, cxCardRecordCaptionStyle[I]);
        end;
      end;
      ADataIndex := VisibleRows[I].Index;
      FExport.SetCellDataString(AStartCol, AStartRow + I,
          VisibleRows[I].Caption);
      if FUseNativeFormat then
        FExport.SetCellValue(AStartCol + 1, AStartRow + I, GetDisplayValue(ACardNumber, ADataIndex))
      else
        FExport.SetCellDataString(AStartCol + 1, AStartRow + I, GetDisplayText(ACardNumber, ADataIndex));
//      FExport.SetColumnWidth(AStartCol, GetCardCaptionWidth(ACardNumber));
      FExport.SetColumnWidth(AStartCol + 1, GetCardContentWidth);
    end;
  end;
end;

procedure TcxGridCardViewExport.CreateHSeparator(ARow: Integer);
var
  ACol: Integer;
begin
  for ACol := 1 to CalculateColumnCount - 2 do
  begin
    FExport.SetCellStyle(ACol, ARow, cxCardDownSeparatorStyle);
    FExport.SetCellStyle(ACol, ARow + 1, cxCardUpSeparatorStyle);
  end;
end;

procedure TcxGridCardViewExport.CreateExportCache;
begin
  RegisterStyles;
  if not SaveAll then
    CreateSelectedCards;

  if SaveAll or (CalculateColumnCount > 0) or (CalculateRowCount > 0) then
  begin
    FExport.SetRange(CalculateColumnCount, CalculateRowCount, False);
    InternalCreateExportCache;
  end;
end;

procedure TcxGridCardViewExport.CreateSelectedCards;
var
  I: Integer;
begin
  with TcxGridCardView(FGridView).ViewData do
  begin
    for I := 0 to CardCount - 1 do
    begin
      if Cards[I].Selected then
        AddSelectedRow(Cards[I], True);
    end;
  end;
end;

procedure TcxGridCardViewExport.CreateVSeparator(ACol: Integer);
var
  ARow: Integer;
begin
  for ARow := 1 to CalculateRowCount - 2 do
  begin
    FExport.SetCellStyle(ACol, ARow, cxCardRightSeparatorStyle);
    FExport.SetCellStyle(ACol + 1, ARow, cxCardLeftSeparatorStyle);
  end;
end;

procedure TcxGridCardViewExport.DoCreateExportCache;
begin
  inherited DoCreateExportCache;
  CreateExportCache;
end;

function TcxGridCardViewExport.GetDisplayText(ACardNumber,
  ADataIndex: Integer): string;
begin
  with TcxGridCardView(FGridView).Rows[ADataIndex].GetProperties do
  begin
    if GetEditValueSource(False) = evsValue then
      Result := GetDisplayText(TcxGridCardView(FGridView).ViewData.Cards[ACardNumber].Values[ADataIndex], True)
    else
      Result := TcxGridCardView(FGridView).ViewData.Cards[ACardNumber].DisplayTexts[ADataIndex];
  end;
end;

function TcxGridCardViewExport.GetDisplayValue(ACardNumber,
  ADataIndex: Integer): Variant;
var
  AProperties: TcxCustomEditProperties;
begin
  AProperties := TcxGridCardView(FGridView).Rows[ADataIndex].GetProperties;
  if NativeFormatProperties(AProperties) then
    Result := TcxGridCardView(FGridView).ViewData.Cards[ACardNumber].Values[ADataIndex]
  else
    Result := GetDisplayText(ACardNumber, ADataIndex);
end;

function TcxGridCardViewExport.GetViewInfo: TcxGridCardViewViewInfo;
begin
  if FViewInfo = nil then
    Result := TcxGridCardView(FGridView).ViewInfo
  else
    Result := TcxGridCardViewViewInfo(FViewInfo);
end;

procedure TcxGridCardViewExport.InternalCreateExportCache;
var
  I, J: Integer;
  ACoordX, ACoordY: Integer;
  ACardIndex: Integer;
  ACardNumber: Integer;
begin
  ACoordX := 1;
  ACoordY := 1;
  ACardNumber := 0;
  ACardIndex := GetCards(0).Index;

  CreateBackGround;

  case GetLayoutDirection of
    ldHorizontal:
    begin
      for I := 0 to FCardColumnCount - 1 do
      begin
        for J := 0 to FCardRowCount - 1 do
        begin
          CreateContentExportCache(ACoordX, ACoordY, ACardIndex);

          Inc(ACardNumber);
          if ACardNumber >= GetCardCount then
            Exit;
          ACardIndex := GetCards(ACardNumber).Index;
          Inc(ACoordY, GetVisibleRowCount + 2);
        end;
        Inc(ACoordX, 2);
        FExport.SetColumnWidth(ACoordX, GetEmptySpaceSize);
        Inc(ACoordX);
        FExport.SetColumnWidth(ACoordX, GetEmptySpaceSize);
        Inc(ACoordX);

        ACoordY := 1;

        CreateVSeparator(ACoordX - 2);
      end;
    end;
    ldVertical:
    begin
      for J := 0 to FCardRowCount - 1 do
      begin
        for I := 0 to FCardColumnCount - 1 do
        begin
          CreateContentExportCache(ACoordX, ACoordY, ACardIndex);

          Inc(ACardNumber);
          if ACardNumber >= GetCardCount then
            Exit;
          ACardIndex := GetCards(ACardNumber).Index;            
          if J = 0 then
          begin
            Inc(ACoordX, 2);
            FExport.SetColumnWidth(ACoordX, GetEmptySpaceSize);
            Inc(ACoordX);
          end
          else
            Inc(ACoordX, 3);
        end;
        Inc(ACoordY, GetVisibleRowCount + 2);
        ACoordX := 1;

        CreateHSeparator(ACoordY - 2);
      end;
    end;
  end;
end;

procedure TcxGridCardViewExport.RegisterStyles;
begin
  FExport.SetDefaultStyle(DefaultCardStyle);
  RegisterCardRowStyles;
  RegisterSeparatorStyles;
end;

function TcxGridCardViewExport.GetBorderColor: Integer;
begin
  with TcxGridCardView(FGridView).Styles do
  begin
    if CardBorder <> nil then
      Result := cxColorToRGB(CardBorder.Color)
    else
      Result := -1;
  end;
end;

function TcxGridCardViewExport.GetCaptionStyle(ANumber: Integer): TcxCacheCellStyle;
begin
  with TcxGridCardView(FGridView) do
  begin
    Result := DefaultCardCaptionStyle;
    with Styles do
      StyleToExportStyle(CaptionRow, Result);
    with VisibleRows[ANumber].Styles do
      StyleToExportStyle(CaptionRow, Result);
  end;
end;

function TcxGridCardViewExport.GetCardBorderWidth: Integer;
begin
  Result := TcxGridCardView(FGridView).OptionsView.CardBorderWidth;
end;

{function TcxGridCardViewExport.GetCardCaptionWidth(ACardNumber: Integer): Integer;
begin
  Result := GetViewInfo.RecordsViewInfo.Items[ACardNumber].CaptionWidth;
end;}

function TcxGridCardViewExport.GetCardContentWidth: Integer;
begin
  Result := GetViewInfo.RecordsViewInfo.CardContentWidth;
end;

function TcxGridCardViewExport.GetCardCount: Integer;
begin
  if SaveAll then
    Result := TcxGridCardView(FGridView).ViewData.CardCount
  else
    Result := SelectedRowCount;
end;

function TcxGridCardViewExport.GetCardColumnCount: Integer;
begin
  if GetCardCount > 0 then
  begin
    case GetLayoutDirection of
      ldHorizontal:
      begin
        Result := GetCardCount div GetVisibleCardRowCount;
        if (GetCardCount mod GetVisibleCardRowCount) <> 0 then
          Inc(Result);
      end;
      ldVertical:
      begin
        if GetCardCount < GetVisibleCardColumnCount then
          Result := GetCardCount
        else
          Result := GetVisibleCardColumnCount;
      end;
      else
        Result := 0;
    end;
  end
  else
    Result := 0;
end;

function TcxGridCardViewExport.GetCardRowCount: Integer;
begin
  if GetCardCount > 0 then
  begin
    case GetLayoutDirection of
      ldHorizontal:
      begin
        if GetCardCount < GetVisibleCardRowCount then
          Result := GetCardCount
        else
          Result := GetVisibleCardRowCount;
      end;
      ldVertical:
      begin
        Result := GetCardCount div GetVisibleCardColumnCount;
        if (GetCardCount mod GetVisibleCardColumnCount) <> 0 then
          Inc(Result);
      end;
      else
        Result := 0;
    end;
  end
  else
    Result := 0; 
end;

function TcxGridCardViewExport.GetCards(AIndex: Integer): TcxGridCard;
begin
  if SaveAll then
    Result := TcxGridCard(TcxGridCardView(FGridView).ViewData.Cards[AIndex])
  else
    Result := TcxGridCard(SelectedRows[AIndex]);
end;

function TcxGridCardViewExport.GetEmptySpaceSize: Integer;
begin
  Result := 15;
end;

function TcxGridCardViewExport.GetEmptySpaceStyle: TcxCacheCellStyle;
begin
  with TcxGridCardView(FGridView) do
  begin
    Result := DefaultCardStyle;
    with Styles do
      StyleToExportStyle(Background, Result);
  end;
end;

function TcxGridCardViewExport.GetHeaderEvenStyle(ANumber: Integer): TcxCacheCellStyle;
begin
  with TcxGridCardView(FGridView) do
  begin
    Result := DefaultCardStyle;
    with Styles do
    begin
      StyleToExportStyle(Content, Result);
      StyleToExportStyle(ContentEven, Result);
    end;
    with VisibleRows[ANumber].Styles do
      StyleToExportStyle(Content, Result);
    with Styles do
      StyleToExportStyle(RowCaption, Result);
    with VisibleRows[ANumber].Styles do
      StyleToExportStyle(Caption, Result);
  end;
end;

function TcxGridCardViewExport.GetHeaderOddStyle(ANumber: Integer): TcxCacheCellStyle;
begin
  with TcxGridCardView(FGridView) do
  begin
    Result := DefaultCardStyle;
    with Styles do
    begin
      StyleToExportStyle(Content, Result);
      StyleToExportStyle(ContentOdd, Result);
    end;
    with VisibleRows[ANumber].Styles do
      StyleToExportStyle(Content, Result);
    with Styles do
      StyleToExportStyle(RowCaption, Result);
    with VisibleRows[ANumber].Styles do
      StyleToExportStyle(Caption, Result);
  end;
end;

function TcxGridCardViewExport.GetLayoutDirection: TcxGridCardViewLayoutDirection;
begin
  with TcxGridCardView(FGridView) do
    Result := LayoutDirection;
end;

function TcxGridCardViewExport.GetRecordEvenStyle(ANumber: Integer): TcxCacheCellStyle;
begin
  with TcxGridCardView(FGridView) do
  begin
    Result := DefaultCardStyle;
    with Styles do
    begin
      StyleToExportStyle(Content, Result);
      StyleToExportStyle(ContentEven, Result);
    end;
    with VisibleRows[ANumber].Styles do
      StyleToExportStyle(Content, Result);
  end;
end;

function TcxGridCardViewExport.GetRecordOddStyle(ANumber: Integer): TcxCacheCellStyle;
begin
  with TcxGridCardView(FGridView) do
  begin
    Result := DefaultCardStyle;
    with Styles do
    begin
      StyleToExportStyle(Content, Result);
      StyleToExportStyle(ContentOdd, Result);
    end;
    with VisibleRows[ANumber].Styles do
      StyleToExportStyle(Content, Result);
  end;
end;

function TcxGridCardViewExport.GetSeparatorColor: Integer;
begin
  with TcxGridCardView(FGridView).OptionsView do
  begin
    if SeparatorColor = clDefault then
      Result := cxColorToRGB(TcxGridCardView(FGridView).LookAndFeelPainter.DefaultSeparatorColor)
    else
      Result := cxColorToRGB(SeparatorColor);
  end;
end;

function TcxGridCardViewExport.GetSeparatorWidth: Integer;
begin
  with TcxGridCardView(FGridView).OptionsView do
    Result := SeparatorWidth;
end;

function TcxGridCardViewExport.GetVisibleCardColumnCount: Integer;
begin
  with GetViewInfo.RecordsViewInfo.Columns do
    Result := Count;
end;

function TcxGridCardViewExport.GetVisibleCardRowCount: Integer;
begin
  with GetViewInfo.RecordsViewInfo.Columns.Items[0] do
    Result := RowCount;
end;

function TcxGridCardViewExport.GetVisibleRowCount: Integer;
begin
  with TcxGridCardView(FGridView) do
    Result := VisibleRowCount;
end;

procedure TcxGridCardViewExport.RegisterCardRowStyles;
var
  I: Integer;
  ABorderColor: Integer;
  AStyle: TcxCacheCellStyle;
begin
  if GetVisibleRowCount > 0 then
  begin
    SetLength(cxCardRecordEvenStyle, GetVisibleRowCount);
    SetLength(cxCardRecordOddStyle, GetVisibleRowCount);
    for I := 0 to GetVisibleRowCount - 1 do
    begin
      cxCardRecordEvenStyle[I] := FExport.RegisterStyle(GetRecordEvenStyle(I));
      cxCardRecordOddStyle[I] := FExport.RegisterStyle(GetRecordOddStyle(I));
    end;

    SetLength(cxCardHeaderEvenStyle, GetVisibleRowCount);
    SetLength(cxCardHeaderOddStyle, GetVisibleRowCount);
    for I := 0 to GetVisibleRowCount - 1 do
    begin
      cxCardHeaderEvenStyle[I] := FExport.RegisterStyle(GetHeaderEvenStyle(I));
      cxCardHeaderOddStyle[I] := FExport.RegisterStyle(GetHeaderOddStyle(I));
    end;

    SetLength(cxCardRecordCaptionStyle, GetVisibleRowCount);
    for I := 0 to GetVisibleRowCount - 1 do
      cxCardRecordCaptionStyle[I] := FExport.RegisterStyle(GetCaptionStyle(I));

    SetLength(cxCardHeaderCaptionStyle, GetVisibleRowCount);
    for I := 0 to GetVisibleRowCount - 1 do
      cxCardHeaderCaptionStyle[I] := FExport.RegisterStyle(GetCaptionStyle(I));

    // card border style
    ABorderColor := GetBorderColor;
    if ABorderColor <> -1 then
    begin
      AStyle := FExport.GetStyle(cxCardRecordEvenStyle[0])^;
      AStyle.Borders[1].Width := GetCardBorderWidth;
      AStyle.Borders[1].Color := ABorderColor;
      AStyle.Borders[2].Width := GetCardBorderWidth;
      AStyle.Borders[2].Color := ABorderColor;
      cxCardRecordEvenStyle[0] := FExport.RegisterStyle(AStyle);
      AStyle := FExport.GetStyle(cxCardRecordOddStyle[0])^;
      AStyle.Borders[1].Width := GetCardBorderWidth;
      AStyle.Borders[1].Color := ABorderColor;
      AStyle.Borders[2].Width := GetCardBorderWidth;
      AStyle.Borders[2].Color := ABorderColor;
      cxCardRecordOddStyle[0] := FExport.RegisterStyle(AStyle);

      AStyle := FExport.GetStyle(cxCardHeaderEvenStyle[0])^;
      AStyle.Borders[1].Width := GetCardBorderWidth;
      AStyle.Borders[1].Color := ABorderColor;
      AStyle.Borders[0].Width := GetCardBorderWidth;
      AStyle.Borders[0].Color := ABorderColor;
      cxCardHeaderEvenStyle[0] := FExport.RegisterStyle(AStyle);
      AStyle := FExport.GetStyle(cxCardHeaderOddStyle[0])^;
      AStyle.Borders[1].Width := GetCardBorderWidth;
      AStyle.Borders[1].Color := ABorderColor;
      AStyle.Borders[0].Width := GetCardBorderWidth;
      AStyle.Borders[0].Color := ABorderColor;
      cxCardHeaderOddStyle[0] := FExport.RegisterStyle(AStyle);

      AStyle := FExport.GetStyle(cxCardRecordCaptionStyle[0])^;
      AStyle.Borders[1].Width := GetCardBorderWidth;
      AStyle.Borders[1].Color := ABorderColor;
      AStyle.Borders[2].Width := GetCardBorderWidth;
      AStyle.Borders[2].Color := ABorderColor;
      cxCardRecordCaptionStyle[0] := FExport.RegisterStyle(AStyle);
      AStyle := FExport.GetStyle(cxCardHeaderCaptionStyle[0])^;
      AStyle.Borders[1].Width := GetCardBorderWidth;
      AStyle.Borders[1].Color := ABorderColor;
      AStyle.Borders[0].Width := GetCardBorderWidth;
      AStyle.Borders[0].Color := ABorderColor;
      cxCardHeaderCaptionStyle[0] := FExport.RegisterStyle(AStyle);

      for I := 1 to GetVisibleRowCount - 2 do
      begin
        AStyle := FExport.GetStyle(cxCardRecordEvenStyle[I])^;
        AStyle.Borders[2].Width := GetCardBorderWidth;
        AStyle.Borders[2].Color := ABorderColor;
        cxCardRecordEvenStyle[I] := FExport.RegisterStyle(AStyle);
        AStyle := FExport.GetStyle(cxCardRecordOddStyle[I])^;
        AStyle.Borders[2].Width := GetCardBorderWidth;
        AStyle.Borders[2].Color := ABorderColor;
        cxCardRecordOddStyle[I] := FExport.RegisterStyle(AStyle);

        AStyle := FExport.GetStyle(cxCardHeaderEvenStyle[I])^;
        AStyle.Borders[0].Width := GetCardBorderWidth;
        AStyle.Borders[0].Color := ABorderColor;
        cxCardHeaderEvenStyle[I] := FExport.RegisterStyle(AStyle);
        AStyle := FExport.GetStyle(cxCardHeaderOddStyle[I])^;
        AStyle.Borders[0].Width := GetCardBorderWidth;
        AStyle.Borders[0].Color := ABorderColor;
        cxCardHeaderOddStyle[I] := FExport.RegisterStyle(AStyle);

        AStyle := FExport.GetStyle(cxCardRecordCaptionStyle[I])^;
        AStyle.Borders[2].Width := GetCardBorderWidth;
        AStyle.Borders[2].Color := ABorderColor;
        cxCardRecordCaptionStyle[I] := FExport.RegisterStyle(AStyle);
        AStyle := FExport.GetStyle(cxCardHeaderCaptionStyle[I])^;
        AStyle.Borders[0].Width := GetCardBorderWidth;
        AStyle.Borders[0].Color := ABorderColor;
        cxCardHeaderCaptionStyle[I] := FExport.RegisterStyle(AStyle);
      end;

      AStyle := FExport.GetStyle(cxCardRecordEvenStyle[GetVisibleRowCount - 1])^;
      AStyle.Borders[3].Width := GetCardBorderWidth;
      AStyle.Borders[3].Color := ABorderColor;
      AStyle.Borders[2].Width := GetCardBorderWidth;
      AStyle.Borders[2].Color := ABorderColor;
      cxCardRecordEvenStyle[GetVisibleRowCount - 1] := FExport.RegisterStyle(AStyle);
      AStyle := FExport.GetStyle(cxCardRecordOddStyle[GetVisibleRowCount - 1])^;
      AStyle.Borders[3].Width := GetCardBorderWidth;
      AStyle.Borders[3].Color := ABorderColor;
      AStyle.Borders[2].Width := GetCardBorderWidth;
      AStyle.Borders[2].Color := ABorderColor;
      cxCardRecordOddStyle[GetVisibleRowCount - 1] := FExport.RegisterStyle(AStyle);

      AStyle := FExport.GetStyle(cxCardHeaderEvenStyle[GetVisibleRowCount - 1])^;
      AStyle.Borders[3].Width := GetCardBorderWidth;
      AStyle.Borders[3].Color := ABorderColor;
      AStyle.Borders[0].Width := GetCardBorderWidth;
      AStyle.Borders[0].Color := ABorderColor;
      cxCardHeaderEvenStyle[GetVisibleRowCount - 1] := FExport.RegisterStyle(AStyle);
      AStyle := FExport.GetStyle(cxCardHeaderOddStyle[GetVisibleRowCount - 1])^;
      AStyle.Borders[3].Width := GetCardBorderWidth;
      AStyle.Borders[3].Color := ABorderColor;
      AStyle.Borders[0].Width := GetCardBorderWidth;
      AStyle.Borders[0].Color := ABorderColor;
      cxCardHeaderOddStyle[GetVisibleRowCount - 1] := FExport.RegisterStyle(AStyle);

      AStyle := FExport.GetStyle(cxCardRecordCaptionStyle[GetVisibleRowCount - 1])^;
      AStyle.Borders[3].Width := GetCardBorderWidth;
      AStyle.Borders[3].Color := ABorderColor;
      AStyle.Borders[2].Width := GetCardBorderWidth;
      AStyle.Borders[2].Color := ABorderColor;
      cxCardRecordCaptionStyle[GetVisibleRowCount - 1] := FExport.RegisterStyle(AStyle);
      AStyle := FExport.GetStyle(cxCardHeaderCaptionStyle[GetVisibleRowCount - 1])^;
      AStyle.Borders[3].Width := GetCardBorderWidth;
      AStyle.Borders[3].Color := ABorderColor;
      AStyle.Borders[0].Width := GetCardBorderWidth;
      AStyle.Borders[0].Color := ABorderColor;
      cxCardHeaderCaptionStyle[GetVisibleRowCount - 1] := FExport.RegisterStyle(AStyle);
    end;
  end;
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

  case GetLayoutDirection of
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

{ TcxGridTableViewExport }

constructor TcxGridTableViewExport.Create(AFileName: string;  AExportType: Integer;
    AGridView: TcxCustomGridView; AViewInfo: TcxCustomGridViewInfo = nil);
begin
  inherited Create(AFileName, AExportType, AGridView, AViewInfo);

  Map := TcxGridExportTableMap.Create;
end;

destructor TcxGridTableViewExport.Destroy;
begin
  Map.Free;
  SetLength(cxHeaderStyle, 0);
  SetLength(cxFooterStyle, 0);
  SetLength(cxGroupRowEvenStyle, 0);
  SetLength(cxGroupRowOddStyle, 0);
  SetLength(cxRecordEvenStyle, 0);
  SetLength(cxRecordOddStyle, 0);  
  SetLength(cxExpandButtonStyle, 0);
  SetLength(cxRowLevelStyle, 0);

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
              if ARow.Expandable and ARow.Expanded then
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
            AStyle := cxHeaderStyle[Index];
          end;
          gckRecord:           // Record
          begin
            if I = 0 then
            begin
              AStartX := ALevel;
              if IsMasterView then
                if (FGridView.Level as TcxGridLevel).VisibleCount > 0 then
                  Inc(AStartX);
              SetLevelStyle(ALevel, AStartRow);
            end
            else
              AStartX := StartX;
            AStartY := AStartRow;
            AHeight := 1;
            AWidth := 1;
            if FUseNativeFormat then
              AValue1 := GetDisplayValue(Index, ARecordNumber)
            else
              AValue := GetDisplayText(Index, ARecordNumber);
            if ARecordNumber mod 2 = 0 then
              AStyle := cxRecordEvenStyle[Index]
            else
              AStyle := cxRecordOddStyle[Index];
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
            if (AValue <> '') or not VarIsNull(AValue1) then
              AStyle := cxFooterStyle[Index]
            else
              AStyle := cxGridViewFooterStyle;
          end;
          gckGroupFooter:     // Grouped Footer
          begin
            if I = 0 then
            begin
              if GetGroupFootersMode = gfVisibleWhenExpanded then
              begin
                AStartX := ALevel + 1;
                AWidth := GetGroupColumnCount - ALevel;
                SetLevelStyle(ALevel + 1, AStartRow);
              end
              else
              begin
                AStartX := ALevel;
                AWidth := GetGroupColumnCount - ALevel + 1;
                SetLevelStyle(ALevel, AStartRow);
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
              AStyle := cxFooterStyle[Index]
            else
              AStyle := cxGridViewFooterStyle;
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

procedure TcxGridTableViewExport.CreateSelectedRows;

  procedure AddParents(AIndex: Integer);
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

var
  I: Integer;
  MinSelectLevel: Integer;
begin
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
      Result := GetRows(ARow).DisplayTexts[ACol];
  end;
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

function TcxGridTableViewExport.GetMasterEmptySpaceEvenStyle: TcxCacheCellStyle;
begin
  with TcxGridTableView(FGridView).Styles do
  begin
    Result := DefaultCellStyle;
    StyleToExportStyle(Content, Result);
    StyleToExportStyle(ContentEven, Result);
  end;
end;

function TcxGridTableViewExport.GetMasterEmptySpaceOddStyle: TcxCacheCellStyle;
begin
  with TcxGridTableView(FGridView).Styles do
  begin
    Result := DefaultCellStyle;
    StyleToExportStyle(Content, Result);
    StyleToExportStyle(ContentOdd, Result);
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

function TcxGridTableViewExport.GetPreviewEvenStyle: TcxCacheCellStyle;
begin
  with TcxGridTableView(FGridView) do
  begin
    Result := DefaultPreviewStyle;
    SetGridLines(Result);
    Result.AlignText := AlignmentToExportAlignment(GetPreviewAlignment);
    with Styles do
    begin
      StyleToExportStyle(Content, Result);
      StyleToExportStyle(ContentEven, Result);
      StyleToExportStyle(Preview, Result);
    end;
    if Preview.Column <> nil then
    with Preview.Column.Styles do
      StyleToExportStyle(Content, Result);
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

function TcxGridTableViewExport.GetPreviewOddStyle: TcxCacheCellStyle;
begin
  with TcxGridTableView(FGridView) do
  begin
    Result := DefaultPreviewStyle;
    SetGridLines(Result);
    Result.AlignText := AlignmentToExportAlignment(GetPreviewAlignment);
    with Styles do
    begin
      StyleToExportStyle(Content, Result);
      StyleToExportStyle(ContentOdd, Result);
      StyleToExportStyle(Preview, Result);
    end;
    if Preview.Column <> nil then
    with Preview.Column.Styles do
      StyleToExportStyle(Content, Result);
  end;
end;

function TcxGridTableViewExport.GetRecordEvenStyle(AColumnNumber: Integer): TcxCacheCellStyle;
begin
  with TcxGridTableView(FGridView) do
  begin
    Result := DefaultCellStyle;
    SetGridLines(Result);
    Result.AlignText := AlignmentToExportAlignment(GetColumnAlignment(AColumnNumber));
    with Styles do
    begin
      StyleToExportStyle(Content, Result);
      StyleToExportStyle(ContentEven, Result);
    end;
    with Columns[AColumnNumber].Styles do
      StyleToExportStyle(Content, Result);
  end;
end;

function TcxGridTableViewExport.GetRecordOddStyle(AColumnNumber: Integer): TcxCacheCellStyle;
begin
  with TcxGridTableView(FGridView) do
  begin
    Result := DefaultCellStyle;
    SetGridLines(Result);
    Result.AlignText := AlignmentToExportAlignment(GetColumnAlignment(AColumnNumber));
    with Styles do
    begin
      StyleToExportStyle(Content, Result);
      StyleToExportStyle(ContentOdd, Result);
    end;
    with Columns[AColumnNumber].Styles do
      StyleToExportStyle(Content, Result);
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
  begin
    if IsPreviewVisible then
    begin
      with ARow do
      begin
        FExport.SetCellStyleEx(Level, AStartRow, 1,
          Map.ScaleItemCount - Level, cxPreviewStyle[I mod 2 <> 0]);
        FExport.SetCellDataString(Level, AStartRow, GetPreview(I));
        SetLevelStyle(Level, AStartRow);
        Inc(AStartRow);
      end;
    end;
  end;

  procedure CreateMasterPreview;
  begin
    if IsPreviewVisible then
    begin
      with TcxGridMasterDataRow(ARow) do
      begin
        FExport.SetCellStyleEx(Level + 1, AStartRow, 1,
          Map.ScaleItemCount - Level - 1, cxPreviewStyle[I mod 2 <> 0]);
        FExport.SetCellDataString(Level + 1, AStartRow, GetPreview(I));
        SetLevelStyle(Level, AStartRow);
        if I mod 2 = 0 then
          FExport.SetCellStyle(Level, AStartRow, cxMasterEmptySpaceEvenStyle)
        else
          FExport.SetCellStyle(Level, AStartRow, cxMasterEmptySpaceOddStyle);
        Inc(AStartRow);
      end;
    end;
  end;

var
  AGridFooterInfo: TcxGridFooterInfo;
  ADetailExport: TcxGridCustomExport;
  ADetailViewInfo: TcxCustomGridTableViewInfo;
  ACellInternalCache: IcxCellInternalCache;
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
          FExport.SetCellStyle(Level, AStartRow, cxExpandButtonStyle[Level]);
          if Expanded then
            FExport.SetCellDataString(Level, AStartRow, '-')
          else
            FExport.SetCellDataString(Level, AStartRow, '+');
          SetLevelStyle(Level, AStartRow);
          if I mod 2 = 0 then
            FExport.SetCellStyleEx(Level + 1, AStartRow, 1,
               Map.ScaleItemCount - Level - 1, cxGroupRowEvenStyle[Level])
          else
            FExport.SetCellStyleEx(Level + 1, AStartRow, 1,
              Map.ScaleItemCount - Level - 1, cxGroupRowOddStyle[Level]);
          FExport.SetCellDataString(Level + 1, AStartRow, DisplayText);
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
              if ARow.Expandable and ARow.Expanded then
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
          FExport.SetCellStyle(Level, AStartRow, cxMasterExpandButtonStyle);
          if Expanded then
            FExport.SetCellDataString(Level, AStartRow, '-')
          else
            FExport.SetCellDataString(Level, AStartRow, '+');
          SetLevelStyle(Level, AStartRow);
          Inc(AStartRow, GetHeaderLineCount);

          if TcxGridTableView(FGridView).Preview.Place = ppBottom then
            CreateMasterPreview;

          if Expanded then
          begin
            SetLevelStyle(Level, AStartRow);
            if I mod 2 = 0 then
            begin
              FExport.SetCellStyle(Level, AStartRow, cxMasterEmptySpaceEvenStyle);
              FExport.SetCellStyleEx(Level + 1, AStartRow, 1,
                Map.ScaleItemCount - Level - 1, cxMasterEmptySpaceEvenStyle)
            end
            else
            begin
              FExport.SetCellStyle(Level, AStartRow, cxMasterEmptySpaceOddStyle);
              FExport.SetCellStyleEx(Level + 1, AStartRow, 1,
                Map.ScaleItemCount - Level - 1, cxMasterEmptySpaceOddStyle);
            end;
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

                  if ADetailViewInfo <> nil then
                  begin
                    ADetailExport := InternalGetGridExportClass(ActiveDetailLevel).Create(FFileName, FExportType, ActiveDetailGridView, ADetailViewInfo);
                    ADetailExport.SaveAll := GetIsRowRealSelected(I);
                    ADetailExport.Expand := Self.Expand;
                    Inc(DetailExportCounter);
                    ADetailExport.DoCreateExportCache;
                    {$IFDEF DELPHI5}
                    if Supports(ADetailExport.FExport, IcxCellInternalCache, ACellInternalCache) then
                    {$ELSE}
                    if (ADetailExport.FExport.QueryInterface(IcxCellInternalCache, ACellInternalCache) = S_OK) then
                    {$ENDIF}
                      (FExport as IcxCellInternalCache).SetCacheIntoCell(Level + 1, AStartRow, ACellInternalCache);
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
  cxPreviewStyle[False] := FExport.RegisterStyle(GetPreviewEvenStyle);
  cxPreviewStyle[True] := FExport.RegisterStyle(GetPreviewOddStyle);
  cxGridViewFooterStyle := FExport.RegisterStyle(GetGridViewFooterStyle);
  cxMasterExpandButtonStyle := FExport.RegisterStyle(GetMasterExpandButtonStyle);
  cxMasterEmptySpaceEvenStyle := FExport.RegisterStyle(GetMasterEmptySpaceEvenStyle);
  cxMasterEmptySpaceOddStyle := FExport.RegisterStyle(GetMasterEmptySpaceOddStyle);

  RegisterColumnStyles;
  RegisterRowLevelStyles;
end;

procedure TcxGridTableViewExport.SetLevelStyle(ALevel, ARow: Integer);
var
  I: Integer;
begin
  for I := 0 to ALevel - 1 do
    FExport.SetCellStyle(I, ARow, cxRowLevelStyle[I]);
end;

procedure TcxGridTableViewExport.SetRange;
begin
  FCacheColumnCount := Map.ScaleItemCount;
  FCacheRowCount := CalculateRowCount;
  if (FCacheColumnCount > 0) and (FCacheRowCount > 0) then
    FExport.SetRange(FCacheColumnCount, FCacheRowCount, False);
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
        Rows[I].Expand(True);
      Inc(I, RowCount - APrevRowCount + 1);
      Dec(ALastRowCount);
    end;
  end;
end;

procedure TcxGridTableViewExport.FullExpandRecords;
var
  I: Integer;
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
      Rows[I].Expand(True);
      Inc(I, RowCount - APrevRowCount + 1);
      Dec(ALastRowCount);
    end;
  end;
end;

function TcxGridTableViewExport.GetDefaultStyle: TcxCacheCellStyle;
begin
  Result := DefaultCellStyle;
end;

function TcxGridTableViewExport.GetExpandButtonStyle(ALevel: Integer): TcxCacheCellStyle;
begin
  Result := DefaultExpandButtonStyle;
end;

function TcxGridTableViewExport.GetFooterStyle(AColumnNumber: Integer): TcxCacheCellStyle;
begin
  with TcxGridTableView(FGridView) do
  begin
    Result := DefaultHeaderStyle;
    Result.AlignText := AlignmentToExportAlignment(GetColumnFooterAlignment(AColumnNumber));
    with Styles do
      StyleToExportStyle(Footer, Result);
    with Columns[AColumnNumber].Styles do
      StyleToExportStyle(Footer, Result);
  end;
end;

function TcxGridTableViewExport.GetGridViewFooterStyle: TcxCacheCellStyle;
begin
  with TcxGridTableView(FGridView).Styles do
  begin
    Result := DefaultHeaderStyle;
    StyleToExportStyle(Footer, Result);
  end;
end;

function TcxGridTableViewExport.GetGroupRowEvenStyle(
  ALevel: Integer): TcxCacheCellStyle;
begin
  with TcxGridTableView(FGridView).Styles do
  begin
    Result := DefaultHeaderStyle;
    Result.AlignText := AlignmentToExportAlignment(taLeftJustify);
    SetGridLines(Result);
    StyleToExportStyle(Content, Result, False, False, True);
    StyleToExportStyle(ContentEven, Result, False, False, True);
    StyleToExportStyle(Group, Result);
  end;
end;

function TcxGridTableViewExport.GetGroupRowOddStyle(
  ALevel: Integer): TcxCacheCellStyle;
begin
  with TcxGridTableView(FGridView).Styles do
  begin
    Result := DefaultHeaderStyle;
    Result.AlignText := AlignmentToExportAlignment(taLeftJustify);    
    SetGridLines(Result);
    StyleToExportStyle(Content, Result, False, False, True);
    StyleToExportStyle(ContentOdd, Result, False, False, True);    
    StyleToExportStyle(Group, Result);
  end;
end;

function TcxGridTableViewExport.GetGroupScaleItemSize: Integer;
begin
  Result := 16;
end;

function TcxGridTableViewExport.GetHeaderStyle(AColumnNumber: Integer): TcxCacheCellStyle;
begin
  with TcxGridTableView(FGridView) do
  begin
    Result := DefaultHeaderStyle;
    Result.AlignText := AlignmentToExportAlignment(GetColumnHeaderAlignment(AColumnNumber)); 
    with Styles do
      StyleToExportStyle(Header, Result);
    with Columns[AColumnNumber].Styles do
      StyleToExportStyle(Header, Result);
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
    Result := TcxGridTableView(FGridView).ViewData.Rows[AIndex]
  else
    Result := TcxCustomGridRow(SelectedRows[AIndex]);
end;

function TcxGridTableViewExport.GetRowLevelStyle(ALevel: Integer): TcxCacheCellStyle;
begin
  with TcxGridTableView(FGridView).Styles do
  begin
    Result := DefaultLevelStyle;
    if not HasHorizontalGridLines then
    begin
      Result.Borders[0].Width := 0;
      Result.Borders[2].Width := 0;
    end;
    StyleToExportStyle(Group, Result);
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

function TcxGridTableViewExport.GetColumnCount: Integer;
begin
  with TcxGridTableView(FGridView) do
    Result := ColumnCount;
end;

procedure TcxGridTableViewExport.RegisterColumnStyles;
var
  I: Integer;
begin
  if GetColumnCount > 0 then
  begin
    SetLength(cxHeaderStyle, GetColumnCount);
    for I := 0 to GetColumnCount - 1 do
      cxHeaderStyle[I] := FExport.RegisterStyle(GetHeaderStyle(I));

    SetLength(cxRecordEvenStyle, GetColumnCount);
    SetLength(cxRecordOddStyle, GetColumnCount);
    for I := 0 to GetColumnCount - 1 do
    begin
      cxRecordEvenStyle[I] := FExport.RegisterStyle(GetRecordEvenStyle(I));
      cxRecordOddStyle[I] := FExport.RegisterStyle(GetRecordOddStyle(I));
    end;

    SetLength(cxFooterStyle, GetColumnCount);
    for I := 0 to GetColumnCount - 1 do
      cxFooterStyle[I] := FExport.RegisterStyle(GetFooterStyle(I));
  end;
end;

procedure TcxGridTableViewExport.RegisterRowLevelStyles;
var
  I: Integer;
begin
  if GetGroupColumnCount > 0 then
  begin
    SetLength(cxGroupRowEvenStyle, GetGroupColumnCount);
    SetLength(cxGroupRowOddStyle, GetGroupColumnCount);
    for I := 0 to GetGroupColumnCount - 1 do
    begin
      cxGroupRowEvenStyle[I] := FExport.RegisterStyle(GetGroupRowEvenStyle(I));
      cxGroupRowOddStyle[I] := FExport.RegisterStyle(GetGroupRowOddStyle(I));
    end;

    SetLength(cxExpandButtonStyle, GetGroupColumnCount);
    for I := 0 to GetGroupColumnCount - 1 do
      cxExpandButtonStyle[I] := FExport.RegisterStyle(GetExpandButtonStyle(I));

    SetLength(cxRowLevelStyle, GetGroupColumnCount);
    for I := 0 to GetGroupColumnCount - 1 do
      cxRowLevelStyle[I] := FExport.RegisterStyle(GetRowLevelStyle(I));
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

{ TcxGridBandedTableViewExport }

constructor TcxGridBandedTableViewExport.Create(AFileName: string;  AExportType: Integer;
    AGridView: TcxCustomGridView; AViewInfo: TcxCustomGridViewInfo = nil);
begin
  inherited Create(AFileName, AExportType, AGridView, AViewInfo);

  FLinesTotalWidth := nil;
  FRowCount := -1;
  FNewBandWidth := -1;
  FVertSeparatorPos := TList.Create;
  FVertSeparatorPosCreated := False;
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
  SetLength(cxBandStyle, 0);
  SetLength(cxHeaderEmptySpaceStyle, 0);
  SetLength(cxRecordEvenEmptySpaceStyle, 0);
  SetLength(cxRecordOddEmptySpaceStyle, 0);

  inherited Destroy;
end;

function TcxGridBandedTableViewExport.CalculateRowCount: Integer;
begin
  if FRowCount < 0 then
  begin
    Result := 0;
    if IsBandVisible then
      Inc(Result, GetBandLineCount);
    Inc(Result, inherited CalculateRowCount);
    FRowCount := Result;
  end
  else
    Result := FRowCount; 
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
      if IsBandVisible then
      begin
        with Map.BandLine do
        begin
          for I := 0 to Count - 1 do
          begin
            FExport.SetCellStyleEx(Items[I].StartX, 0, 1, Items[I].Width, cxBandStyle[I]);
            FExport.SetCellDataString(Items[I].StartX, 0, Items[I].Value);
          end;
        end;
        AStartRow := 1
      end;

      if (GetVisibleColumnCount > 0){ or (GetGroupedColumnCount > 0) }then
      begin
        // Header empty space
        for I := 0 to Map.ScaleItemCount - 1 do
          for J := AStartRow to AStartRow + GetHeaderLineCount - 1 do
            FExport.SetCellStyle(I, J, cxHeaderEmptySpaceStyle[GetBandNumber(I)]);

        CreateVertSeparatorPos;
        InternalCreateExportCache(AStartRow);
      end;
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
    for I := 0 to Count - 1 do
    begin
      CreateBandMap(I, ATotalWidth);
      with Items[I] do
      begin
        with RowsViewInfo do
        begin
          if (I = 0) and (FNewBandWidth > 0) then
          begin
            Map.AddBandRect(ATotalWidth, FNewBandWidth, Band.Index, Band.Caption);
            Inc(ATotalWidth, FNewBandWidth);
          end
          else
          begin
            Map.AddBandRect(ATotalWidth, Width, Band.Index, Band.Caption);
            Inc(ATotalWidth, Width);
          end;
        end;
      end;
    end;
  end;
end;

procedure TcxGridBandedTableViewExport.CreateBandMap(ABandIndex, ABandStartX: Integer);
var
  I: Integer;
begin
  with GetViewInfo.HeaderViewInfo.BandsViewInfo do
  begin
    CreateLinesTotalWidth(LineCount, ABandStartX);
    with Items[ABandIndex] do
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
        FExport.SetCellStyle(I, J, cxFooterEmptySpaceStyle);
  end
  // Record empty space
  else if AContentKind = gckRecord then
  begin
    if ARecordNumber mod 2 = 0 then
    begin
      for I := 0 to Map.ScaleItemCount - 1 do
        for J := AStartRow to AStartRow + GetHeaderLineCount - 1 do
          FExport.SetCellStyle(I, J, cxRecordEvenEmptySpaceStyle[GetBandNumber(I)]);
    end
    else
    begin
      for I := 0 to Map.ScaleItemCount - 1 do
        for J := AStartRow to AStartRow + GetHeaderLineCount - 1 do
          FExport.SetCellStyle(I, J, cxRecordOddEmptySpaceStyle[GetBandNumber(I)]);
    end;
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
              AStyle := cxHeaderStyle[Index];
            end;
            gckRecord:              // Record
            begin
              if (J = 0) and (ABandNumber = 0) then
              begin
                AStartX := ALevel;
                if IsMasterView then
                  if (FGridView.Level as TcxGridLevel).VisibleCount > 0 then
                    Inc(AStartX); 
                AWidth := Width - AStartX;
              end
              else
              begin
                AStartX := StartX;
                AWidth := Width;
              end;
              for K := 0 to Height - 1 do
                SetLevelStyle(ALevel, ARow + K);
              AStartY := ARow;
              AHeight := Height;
              if FUseNativeFormat then
                AValue1 := GetDisplayValue(Index, ARecordNumber)
              else
                AValue := GetDisplayText(Index, ARecordNumber);
              if ARecordNumber mod 2 = 0 then
                AStyle := cxRecordEvenStyle[Index]
              else
                AStyle := cxRecordOddStyle[Index];
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
                AStyle := cxFooterStyle[Index]
              else
                AStyle := cxGridViewFooterStyle;
            end;
            gckGroupFooter:         // Group Footer
            begin
              if (J = 0) and (ABandNumber = 0) then
              begin
                if GetGroupFootersMode = gfVisibleWhenExpanded then
                begin
                  AStartX := ALevel + 1;
                  AWidth := Width - ALevel - 1;
                  SetLevelStyle(ALevel + 1, ARow);
                end
                else
                begin
                  AStartX := ALevel;
                  AWidth := Width - ALevel;
                  SetLevelStyle(ALevel, ARow);
                end;
              end
              else
              begin
                AStartX := StartX;
                AWidth := Width;
              end;
              for K := 0 to Height - 1 do
              begin
                if GetGroupFootersMode = gfVisibleWhenExpanded then
                  SetLevelStyle(ALevel + 1, ARow + K)
                else
                  SetLevelStyle(ALevel, ARow + K);
              end;
              AStartY := ARow;
              AHeight := Height;
              if FUseNativeFormat then
                AValue1 := GetGroupFooterDisplayValue(Index, ARecordNumber, ALevel)
              else
                AValue := GetGroupFooterDisplayText(Index, ARecordNumber, ALevel);
              if (AValue <> '') or not VarIsNull(AValue1) then
                AStyle := cxFooterStyle[Index]
              else
                AStyle := cxGridViewFooterStyle;
            end;
          end;
          FExport.SetCellStyleEx(AStartX, AStartY, AHeight, AWidth, AStyle);
          if AContentKind in [gckRecord, gckFooter, gckGroupFooter] then
          begin
            if FUseNativeFormat then
              FExport.SetCellValue(AStartX, AStartY, AValue1)
            else
              FExport.SetCellDataString(AStartX, AStartY, AValue);
          end
          else
            FExport.SetCellDataString(AStartX, AStartY, AValue);
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
//            if AContentKind = gckFooter then
            FExport.SetCellStyle(I, J, ABaseStyle);
            AFlag := False;
          end;
        end;
      end;
  end

  // record separators
  else if AContentKind = gckRecord then
  begin
    AFlag := False;
    for I := 0 to Map.ScaleItemCount - 1 do
      for J := AStartRow to AStartRow + GetHeaderLineCount - 1 do
      begin
        if I >= ALevel then
        begin
          ABaseStyle := FExport.GetCellStyle(I, J)^;
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
  with TcxGridBandedTableView(FGridView).Bands.VisibleItems[ABandNumber] do
    Result := Alignment;
end;

function TcxGridBandedTableViewExport.GetBandLineCount: Integer;
begin
  Result := 1;
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

function TcxGridBandedTableViewExport.GetPreviewEvenStyle: TcxCacheCellStyle;
begin
  with TcxGridBandedTableView(FGridView) do
  begin
    Result := DefaultPreviewStyle;
    Result.AlignText := AlignmentToExportAlignment(GetPreviewAlignment);
    SetGridLines(Result);
    with Styles do
    begin
      StyleToExportStyle(Content, Result);
      StyleToExportStyle(ContentEven, Result);
      StyleToExportStyle(Preview, Result);
    end;
    if Preview.Column <> nil then
    with TcxGridBandedColumn(Preview.Column) do
    begin
      if Position.Band <> nil then
        with Position.Band.Styles do
          StyleToExportStyle(Content, Result);
      with Styles do
        StyleToExportStyle(Content, Result);
    end;
  end;
end;

function TcxGridBandedTableViewExport.GetPreviewOddStyle: TcxCacheCellStyle;
begin
  with TcxGridBandedTableView(FGridView) do
  begin
    Result := DefaultPreviewStyle;
    Result.AlignText := AlignmentToExportAlignment(GetPreviewAlignment);
    SetGridLines(Result);
    with Styles do
    begin
      StyleToExportStyle(Content, Result);
      StyleToExportStyle(ContentOdd, Result);
      StyleToExportStyle(Preview, Result);
    end;
    if Preview.Column <> nil then
    with TcxGridBandedColumn(Preview.Column) do
    begin
      if Position.Band <> nil then
        with Position.Band.Styles do
          StyleToExportStyle(Content, Result);
      with Styles do
        StyleToExportStyle(Content, Result);
    end;
  end;
end;

function TcxGridBandedTableViewExport.GetRecordEvenStyle(
  AColumnNumber: Integer): TcxCacheCellStyle;
begin
  with TcxGridBandedTableView(FGridView) do
  begin
    Result := DefaultCellStyle;
    SetGridLines(Result);
    Result.AlignText := AlignmentToExportAlignment(GetColumnAlignment(AColumnNumber));
    with Styles do
    begin
      StyleToExportStyle(Content, Result);
      StyleToExportStyle(ContentEven, Result);
    end;
    if Columns[AColumnNumber].Position.Band <> nil then
      with Columns[AColumnNumber].Position.Band.Styles do
        StyleToExportStyle(Content, Result);
    with Columns[AColumnNumber].Styles do
      StyleToExportStyle(Content, Result);
  end;
end;

function TcxGridBandedTableViewExport.GetRecordOddStyle(
  AColumnNumber: Integer): TcxCacheCellStyle;
begin
  with TcxGridBandedTableView(FGridView) do
  begin
    Result := DefaultCellStyle;
    SetGridLines(Result);
    Result.AlignText := AlignmentToExportAlignment(GetColumnAlignment(AColumnNumber));
    with Styles do
    begin
      StyleToExportStyle(Content, Result);
      StyleToExportStyle(ContentOdd, Result);
    end;
    if Columns[AColumnNumber].Position.Band <> nil then
      with Columns[AColumnNumber].Position.Band.Styles do
        StyleToExportStyle(Content, Result);
    with Columns[AColumnNumber].Styles do
      StyleToExportStyle(Content, Result);
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

  RegisterBandStyles;
  cxFooterEmptySpaceStyle := FExport.RegisterStyle(GetFooterEmptySpaceStyle);
end;

procedure TcxGridBandedTableViewExport.CreateBandScale(ABandIndex,
  ABandStartX: Integer);
var
  I: Integer;
begin
  with GetViewInfo.HeaderViewInfo.BandsViewInfo do
  begin
    CreateLinesTotalWidth(LineCount, ABandStartX);
    with Items[ABandIndex] do
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
    for I := 0 to Count - 1 do
    begin
      CreateBandScale(I, ATotalWidth);
      with Items[I].RowsViewInfo do
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

function TcxGridBandedTableViewExport.GetBandCount: Integer;
begin
  with TcxGridBandedTableView(FGridView).Bands do
    Result := Count;
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
begin
  Result := DefaultBandStyle;
  Result.AlignText := AlignmentToExportAlignment(GetBandAlignment(ABandNumber));
  with TcxGridBandedTableViewStyles(TcxGridTableView(FGridView).Styles) do
    StyleToExportStyle(BandHeader, Result);
  with TcxGridBandedTableView(FGridView).Bands.VisibleItems[ABandNumber].Styles do
    StyleToExportStyle(Header, Result);
end;

function TcxGridBandedTableViewExport.GetFooterEmptySpaceStyle: TcxCacheCellStyle;
begin
  with TcxGridTableView(FGridView).Styles do
  begin
    Result := DefaultFooterEmptySpaceStyle;
    StyleToExportStyle(Footer, Result);
  end;

  Result.FontStyle := [];  
end;

function TcxGridBandedTableViewExport.GetHeaderEmptySpaceStyle(ABandNumber: Integer): TcxCacheCellStyle;
begin
  Result := DefaultHeaderEmptySpaceStyle;
  with TcxGridBandedTableViewStyles(TcxGridTableView(FGridView).Styles) do
    StyleToExportStyle(BandBackground, Result);
  with TcxGridBandedTableView(FGridView).Bands.VisibleItems[ABandNumber].Styles do
    StyleToExportStyle(BackGround, Result);
  Result.FontStyle := [];
end;

function TcxGridBandedTableViewExport.GetRecordEvenEmptySpaceStyle(
  ABandNumber: Integer): TcxCacheCellStyle;
begin
  Result := DefaultRecordEmptySpaceStyle;
  with TcxGridBandedTableViewStyles(TcxGridTableView(FGridView).Styles) do
  begin
    StyleToExportStyle(Content, Result);
    StyleToExportStyle(ContentEven, Result);
  end;
  with TcxGridBandedTableView(FGridView).Bands.VisibleItems[ABandNumber].Styles do
    StyleToExportStyle(Content, Result);
  Result.FontStyle := [];
end;

function TcxGridBandedTableViewExport.GetRecordOddEmptySpaceStyle(
  ABandNumber: Integer): TcxCacheCellStyle;
begin
  Result := DefaultRecordEmptySpaceStyle;
  with TcxGridBandedTableViewStyles(TcxGridTableView(FGridView).Styles) do
  begin
    StyleToExportStyle(Content, Result);
    StyleToExportStyle(ContentOdd, Result);
  end;
  with TcxGridBandedTableView(FGridView).Bands.VisibleItems[ABandNumber].Styles do
    StyleToExportStyle(Content, Result);
  Result.FontStyle := [];
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

procedure TcxGridBandedTableViewExport.RegisterBandStyles;
var
  I: Integer;
begin
  if GetBandCount > 0 then
  begin
    SetLength(cxBandStyle, GetVisibleBandCount);
    for I := 0 to GetVisibleBandCount - 1 do
      cxBandStyle[I] := FExport.RegisterStyle(GetBandStyle(I));

    SetLength(cxHeaderEmptySpaceStyle, GetVisibleBandCount);
    for I := 0 to GetVisibleBandCount - 1 do
      cxHeaderEmptySpaceStyle[I] := FExport.RegisterStyle(GetHeaderEmptySpaceStyle(I));

    SetLength(cxRecordEvenEmptySpaceStyle, GetVisibleBandCount);
    SetLength(cxRecordOddEmptySpaceStyle, GetVisibleBandCount);
    for I := 0 to GetVisibleBandCount - 1 do
    begin
      cxRecordEvenEmptySpaceStyle[I] := FExport.RegisterStyle(GetRecordEvenEmptySpaceStyle(I));
      cxRecordOddEmptySpaceStyle[I] := FExport.RegisterStyle(GetRecordOddEmptySpaceStyle(I));      
    end;
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
