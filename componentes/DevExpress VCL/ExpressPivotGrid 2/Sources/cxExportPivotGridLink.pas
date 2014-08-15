{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressPivotGrid                                 }
{                                                                    }
{       Copyright (c) 2005-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPIVOTGRID AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
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
unit cxExportPivotGridLink;

{$I cxVer.inc}

interface

uses
  cxCustomPivotGrid, dxCore;

procedure cxExportPivotGridToHTML(const AFileName: string;
  APivotGrid: TcxCustomPivotGrid; AExpand: Boolean = True;
  const AFileExt: string = 'html');
procedure cxExportPivotGridToXML(const AFileName: string;
  APivotGrid: TcxCustomPivotGrid; AExpand: Boolean = True;
  const AFileExt: string = 'xml');
procedure cxExportPivotGridToExcel(const AFileName: string;
  APivotGrid: TcxCustomPivotGrid; AExpand: Boolean = True;
  AUseNativeFormat: Boolean = True;
  const AFileExt: string = 'xls');
procedure cxExportPivotGridToText(const AFileName: string;
  APivotGrid: TcxCustomPivotGrid; AExpand: Boolean = True;
  const ASeparator: string = '';
  const ABeginString: string = '';
  const AEndString: string = '';
  const AFileExt: string = 'txt');
procedure cxExportPivotGridToFile(AFileName: string;
  APivotGrid: TcxCustomPivotGrid; AExportType: Integer;
  AExpand, AUseNativeFormat: Boolean; const ASeparators: array of string;
  const AFileExt: string);

implementation

uses
  Windows, Graphics, cxGeometry,
  Variants, Types, DB,
  cxEdit, cxCalendar, cxCurrencyEdit, cxSpinEdit, cxCalc, cxTimeEdit, cxMaskEdit,
  SysUtils, Classes, cxClasses, cxGraphics, cxStyles,
  cxDataUtils, cxDataStorage, cxExport, cxXLSExport, cxHtmlXmlTxtExport,
  cxDBPivotGrid;

type
  TcxPivotGridExportHelper = class;
  TcxPivotGridFieldAccess = class(TcxPivotGridField);

  { TcxPivotGridExportCell }

  TcxPivotGridExportCell = class
  private
    FBounds: TRect;
    FCell: TcxPivotGridCustomCellViewInfo;
    FStyleIndex: Integer;
  public
    constructor Create(ACell: TcxPivotGridCustomCellViewInfo; ABounds: TRect; AStyleIndex: Integer);
    property Bounds: TRect read FBounds;
    property Cell: TcxPivotGridCustomCellViewInfo read FCell;
    property StyleIndex: Integer read FStyleIndex;
  end;

  { TcxPivotGridExportCellList }

  TcxPivotGridExportCellList = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TcxPivotGridExportCell;
  public
    property Items[Index: Integer]: TcxPivotGridExportCell read GetItem; default;
  end;

  { TcxPivotGridMapInfo }

  TcxPivotGridMapsInfo = class
  private
    FCells: TcxPivotGridExportCellList;
    FCols: TList;
    FController: TcxPivotGridExportController;
    FGridLineColor: TColor;
    FGridLines: TcxPivotGridLines;
    FOwner: TcxPivotGridExportHelper;
    FRows: TList;
    FViewInfo: TcxPivotGridViewInfo;
    procedure AddRect(const R: TRect);
    function ConvertBounds(const R: TRect): TRect;
    function CheckNativeValue(AProperties: TcxCustomEditProperties;
      APivotField: TcxPivotGridField; const AValue: Variant): Variant;
    function GetProvider: IcxExportProvider;
    function IsCurrencyField(APivotField: TcxPivotGridField): Boolean;
    function IsCurrencyProperties(AProperties: TcxCustomEditProperties): Boolean;
    function IsNativeFormatProperties(AProperties: TcxCustomEditProperties): Boolean;
  protected
    procedure AddPivotGridCell(ACell: TcxPivotGridCustomCellViewInfo);
    procedure AddPivotGridCells(ACells: TcxPivotGridCells);
    procedure CalculateColsAndRows;
    procedure ConvertCellToCacheCellStyle(ACell: TcxPivotGridCustomCellViewInfo; var AStyle: TcxCacheCellStyle);
    procedure ConvertDataCell(ACell: TcxPivotGridDataCellViewInfo; var AStyle: TcxCacheCellStyle);
    procedure ConvertHeaderCell(ACell: TcxPivotGridHeaderCellViewInfo; var AStyle: TcxCacheCellStyle);
    function CreateExportCell(ACell: TcxPivotGridCustomCellViewInfo): TcxPivotGridExportCell;
    procedure WriteCell(AExportCell: TcxPivotGridExportCell);
    procedure WriteCellData(ACol, ARow: Integer; ACell: TcxPivotGridCustomCellViewInfo);
    procedure WriteCells;
    procedure WriteColumnWidths;
    procedure WriteRowHeights;

    property Controller: TcxPivotGridExportController read FController; 
    property GridLineColor: TColor read FGridLineColor;
    property GridLines: TcxPivotGridLines read FGridLines;
    property Owner: TcxPivotGridExportHelper read FOwner;
    property Provider: IcxExportProvider read GetProvider;
    property ViewInfo: TcxPivotGridViewInfo read FViewInfo;
  public
    constructor Create(AOwner: TcxPivotGridExportHelper;
      AController: TcxPivotGridExportController); virtual;
    destructor Destroy; override;
    procedure Calculate;
    procedure Write;
  end;

  TcxPivotGridMapsInfoClass = class of TcxPivotGridMapsInfo;

  { TcxPivotGridExportHelper }

  TcxPivotGridExportHelper = class
  private
    FExpand: Boolean;
    FIsNativeFormat: Boolean;
    FPivotGrid: TcxCustomPivotGrid;
    FProvider: IcxExportProvider;
  protected
    MapsInfo: TcxPivotGridMapsInfo;
    function GetMapsInfoClass: TcxPivotGridMapsInfoClass; virtual;
  public
    constructor Create(APivotGrid: TcxCustomPivotGrid;
      AExportType: Integer; const AFileName: string); virtual;
    destructor Destroy; override;
    procedure ExportPivotGrid;
    property Expand: Boolean read FExpand write FExpand;
    property IsNativeFormat: Boolean read FIsNativeFormat;
    property Provider: IcxExportProvider read FProvider;
    property PivotGrid: TcxCustomPivotGrid read FPivotGrid;
  end;

const
  cxDefaultExportFontName = 'Tahoma';
  cxDefaultExportStyle: TcxCacheCellStyle =
  ( AlignText: catCenter;
    FontStyle: [];
    FontColor: 0;
    FontSize: 12;
    FontCharset: 0;
    BrushStyle: cbsSolid);

  AlignToCxAlign: array[TAlignment] of TcxAlignText =
    (catLeft, catRight, catCenter);
  cxUsedBorder: TcxCellBorders = (IsDefault: False; Width: 1);
  cxEmptyBorder: TcxCellBorders = (IsDefault: True; Width: 0);

function cxSetBorder(var ABorder: TcxCellBorders; NeedSet: Boolean; Color: Integer): Boolean;
begin
  Result := NeedSet;
  if NeedSet then
  begin
    ABorder := cxUsedBorder;
    ABorder.Color := Color;
  end
  else
    ABorder := cxEmptyBorder;
end;

procedure cxCheckBorders(var AStyle: TcxCacheCellStyle;
  const ABorders: TcxBorders; AColor: TColor; AGridLines: TcxPivotGridLines);
begin
  cxSetBorder(AStyle.Borders[0],
    (bLeft in ABorders) and (AGridLines in [pglVert, pglBoth]), AColor);
  cxSetBorder(AStyle.Borders[1],
    (bTop in ABorders) and (AGridLines in [pglHorz, pglBoth]), AColor);
  cxSetBorder(AStyle.Borders[2],
    (bRight in ABorders) and (AGridLines in [pglVert, pglBoth]), AColor);
  cxSetBorder(AStyle.Borders[3],
    (bBottom in ABorders) and (AGridLines in [pglHorz, pglBoth]), AColor);
end;

procedure cxViewParamsToCacheStyle(
  AViewParams: TcxViewParams; var ACacheStyle: TcxCacheCellStyle);
begin
  ACacheStyle := DefaultCellStyle;
  with ACacheStyle do
  begin
    FillChar(FontName, SizeOf(FontName), 0);
    dxStringToBytes(AViewParams.Font.Name, FontName);
    FontStyle := TcxFontStyles(AViewParams.Font.Style);
    FontColor := ColorToRgb(AViewParams.TextColor);
    FontSize := AViewParams.Font.Size;
    FontCharset := AViewParams.Font.Charset;
    BrushStyle := cbsSolid;
    BrushBkColor := ColorToRgb(AViewParams.Color);
    BrushFgColor := BrushBkColor;
  end;
end;

{ TcxPivotGridExportCell }

constructor TcxPivotGridExportCell.Create(
  ACell: TcxPivotGridCustomCellViewInfo; ABounds: TRect;
  AStyleIndex: Integer);
begin
  inherited Create;
  FCell := ACell;
  FStyleIndex := AStyleIndex;
  FBounds := ABounds;
end;

{ TcxPivotGridExportCellList }

function TcxPivotGridExportCellList.GetItem(
  Index: Integer): TcxPivotGridExportCell;
begin
  Result := TcxPivotGridExportCell(List^[Index]);
end;

{ TcxPivotGridMapsInfo }

constructor TcxPivotGridMapsInfo.Create(
  AOwner: TcxPivotGridExportHelper; AController: TcxPivotGridExportController);
begin
  FOwner := AOwner;
  FController := AController;
  FViewInfo := FController.CalculateViewInfo;

  with FController.OptionsView do
  begin
    //todo: FGridLineColor := GridLineColor; 
    FGridLines := GridLines;
  end;
  FCols := TList.Create;
  FRows := TList.Create;
  FCells := TcxPivotGridExportCellList.Create;
end;

destructor TcxPivotGridMapsInfo.Destroy;
begin
  FCells.Free;
  FCols.Free;
  FRows.Free;
  inherited Destroy;
end;

function CompareInt(A, B: Pointer): Integer;
begin
  Result := Integer(A) - Integer(B);
end;

procedure TcxPivotGridMapsInfo.AddPivotGridCell(
  ACell: TcxPivotGridCustomCellViewInfo);
begin
  FCells.Add(CreateExportCell(ACell));
end;

procedure TcxPivotGridMapsInfo.AddPivotGridCells(ACells: TcxPivotGridCells);
var
  I: Integer;
begin
  for I := 0 to ACells.Count - 1 do
    AddPivotGridCell(ACells[I]);
end;

procedure TcxPivotGridMapsInfo.CalculateColsAndRows;

  procedure AddCellBounds(ACells: TcxPivotGridCells);
  var
    I: Integer;
  begin
    for I := 0 to ACells.Count - 1 do
      AddRect(ACells[I].Bounds);
  end;

begin
  with ViewInfo do
  begin
    AddCellBounds(ColumnHeaders);
    AddCellBounds(FieldHeaders);
    AddCellBounds(RowHeaders);
    AddCellBounds(DataCells);
  end;
  FCols.Sort(CompareInt);
  FRows.Sort(CompareInt);
end;

procedure TcxPivotGridMapsInfo.ConvertCellToCacheCellStyle(
  ACell: TcxPivotGridCustomCellViewInfo; var AStyle: TcxCacheCellStyle);
begin
  if ACell is TcxPivotGridDataCellViewInfo then
    ConvertDataCell(TcxPivotGridDataCellViewInfo(ACell), AStyle)
  else if ACell is TcxPivotGridHeaderCellViewInfo then
    ConvertHeaderCell(TcxPivotGridHeaderCellViewInfo(ACell), AStyle)
end;

procedure TcxPivotGridMapsInfo.ConvertDataCell(
  ACell: TcxPivotGridDataCellViewInfo; var AStyle: TcxCacheCellStyle);
begin
//todo:  AStyle.AlignText := AlignToCxAlign[ACell.AlignHorz];
  AStyle.AlignText := catRight;
end;

procedure TcxPivotGridMapsInfo.ConvertHeaderCell(
  ACell: TcxPivotGridHeaderCellViewInfo; var AStyle: TcxCacheCellStyle);
begin
  AStyle.AlignText := AlignToCxAlign[ACell.AlignHorz];
end;

function TcxPivotGridMapsInfo.CreateExportCell(
  ACell: TcxPivotGridCustomCellViewInfo): TcxPivotGridExportCell;
var
  AStyle: TcxCacheCellStyle;
begin
  cxViewParamsToCacheStyle(ACell.ViewParams, AStyle);
  cxCheckBorders(AStyle, cxBordersAll, GridLineColor, GridLines);
  ConvertCellToCacheCellStyle(ACell, AStyle);
  Result := TcxPivotGridExportCell.Create(ACell, ConvertBounds(ACell.Bounds),
    Provider.RegisterStyle(AStyle));
end;

procedure TcxPivotGridMapsInfo.Calculate;
begin
  CalculateColsAndRows;
  with ViewInfo do
  begin
    AddPivotGridCells(ColumnHeaders);
    AddPivotGridCells(FieldHeaders);
    AddPivotGridCells(RowHeaders);
    AddPivotGridCells(DataCells);
  end;
end;

procedure TcxPivotGridMapsInfo.Write;
begin
  if (FCols.Count = 0) or (FRows.Count = 0) then Exit;
  Provider.SetRange(FCols.Count - 1, FRows.Count - 1, False);
  WriteColumnWidths;
  WriteRowHeights;
  WriteCells;
end;

procedure TcxPivotGridMapsInfo.WriteCell(AExportCell: TcxPivotGridExportCell);
begin
  with AExportCell, Bounds do
  begin
    WriteCellData(Left, Top, Cell);
    Provider.SetCellStyleEx(Left, Top, Bottom - Top, Right - Left , StyleIndex);
  end;
end;

procedure TcxPivotGridMapsInfo.WriteCellData(ACol, ARow: Integer;
  ACell: TcxPivotGridCustomCellViewInfo);
var
  ADisplayTextAssigned: Boolean;
  AProperties: TcxCustomEditProperties;
  AValue: Variant;
  ADataCell: TcxPivotGridDataCellViewInfo;
begin
  if ACell is TcxPivotGridDataCellViewInfo then
  begin
    ADataCell := TcxPivotGridDataCellViewInfo(ACell);
    if ADataCell.DataField <> nil then
    begin
      ADisplayTextAssigned := Assigned(ADataCell.DataField.OnGetDisplayText);
      if Owner.IsNativeFormat and not ADisplayTextAssigned then
      begin
        AProperties := ADataCell.Properties;
        AValue := ADataCell.Value;
        if (AProperties <> nil) and IsNativeFormatProperties(AProperties) then
          AValue := CheckNativeValue(AProperties, ADataCell.DataField, ADataCell.Value);
        Provider.SetCellValue(ACol, ARow, AValue);
      end
      else
        Provider.SetCellDataString(ACol, ARow, ADataCell.DisplayText);
    end;
  end
  else
    if ACell is TcxPivotGridHeaderCellViewInfo then
      Provider.SetCellDataString(ACol, ARow, TcxPivotGridHeaderCellViewInfo(ACell).DisplayText);
end;

procedure TcxPivotGridMapsInfo.WriteCells;
var
  I: Integer;
begin
  for I := 0 to FCells.Count - 1 do
    WriteCell(FCells[I]);
end;

procedure TcxPivotGridMapsInfo.WriteColumnWidths;
var
  I: Integer;
begin
  for I := 0 to FCols.Count - 2 do
    Provider.SetColumnWidth(I, Integer(FCols[I + 1]) - Integer(FCols[I]));
end;

procedure TcxPivotGridMapsInfo.WriteRowHeights;
var
  I: Integer;
begin
  for I := 0 to FRows.Count - 2 do
    Provider.SetRowHeight(I, Integer(FRows[I + 1]) - Integer(FRows[I]));
end;

procedure TcxPivotGridMapsInfo.AddRect(const R: TRect);

  procedure AddEdge(Value: Integer; L: TList);
  begin
    if L.IndexOf(Pointer(Value)) = -1 then
      L.Add(Pointer(Value));
  end;

begin
  AddEdge(R.Left, FCols);
  AddEdge(R.Right, FCols);
  AddEdge(R.Top, FRows);
  AddEdge(R.Bottom, FRows);
end;

function TcxPivotGridMapsInfo.ConvertBounds(const R: TRect): TRect;
begin
  Result.Left := FCols.IndexOf(Pointer(R.Left));
  Result.Right := FCols.IndexOf(Pointer(R.Right));
  Result.Top := FRows.IndexOf(Pointer(R.Top));
  Result.Bottom := FRows.IndexOf(Pointer(R.Bottom));
end;

function TcxPivotGridMapsInfo.CheckNativeValue(AProperties: TcxCustomEditProperties;
  APivotField: TcxPivotGridField; const AValue: Variant): Variant;
begin
  try
    if (IsCurrencyField(APivotField) and IsCurrencyProperties(AProperties)) or
      (AProperties is TcxCurrencyEditProperties) then
      VarCast(Result, AValue, varCurrency)
    else
      if (VarType(AValue) = varCurrency) and not IsCurrencyField(APivotField) and
        not (AProperties is TcxCurrencyEditProperties) then
        VarCast(Result, AValue, varDouble)
      else
        Result := AValue;
  except
    on EVariantError do
      Result := AValue
    else
      raise;
  end;
end;

function TcxPivotGridMapsInfo.GetProvider: IcxExportProvider;
begin
  Result := FOwner.Provider;
end;

function TcxPivotGridMapsInfo.IsCurrencyField(APivotField: TcxPivotGridField): Boolean;
var
  APivotFieldAccess: TcxPivotGridFieldAccess;
begin
  APivotFieldAccess := TcxPivotGridFieldAccess(APivotField);
  Result := APivotFieldAccess.IsCurrency(APivotField.DataBinding.ValueTypeClass);
end;

function TcxPivotGridMapsInfo.IsCurrencyProperties(AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := (AProperties is TcxMaskEditProperties) or (AProperties is TcxCalcEditProperties) or
    (AProperties is TcxCurrencyEditProperties);
end;

function TcxPivotGridMapsInfo.IsNativeFormatProperties(AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := (AProperties is TcxDateEditProperties) or (AProperties is TcxSpinEditProperties)
     or (AProperties is TcxTimeEditProperties) or IsCurrencyProperties(AProperties);
end;

{ TcxPivotGridExportHelper }

constructor TcxPivotGridExportHelper.Create(
  APivotGrid: TcxCustomPivotGrid; AExportType: Integer;
  const AFileName: string);

  function DefaultStyle: TcxCacheCellStyle;
  var
    I: Integer;
  begin
    cxViewParamsToCacheStyle(PivotGrid.Styles.GetBackgroundParams, Result);
    for I := 0 to 3 do
      Result.Borders[I] := cxEmptyBorder;
  end;

begin
  FPivotGrid := APivotGrid;
  TcxExport.Provider(AExportType, AFileName).GetInterface(IcxExportProvider, FProvider);
  FProvider.SetDefaultStyle(DefaultStyle);
end;

destructor TcxPivotGridExportHelper.Destroy;
begin
  try
    FProvider := nil;
  finally
    inherited Destroy;
  end;
end;

procedure TcxPivotGridExportHelper.ExportPivotGrid;
var
  AController: TcxPivotGridExportController;
begin
  AController := TcxPivotGridExportController.Create(PivotGrid);
  try
    AController.ExpandRows := Expand;
    AController.ExpandColumns := Expand;
    MapsInfo := GetMapsInfoClass.Create(Self, AController);
    try
      MapsInfo.Calculate;
      MapsInfo.Write;
      Provider.Commit;
    finally
      FreeAndNil(MapsInfo);
    end;
  finally
    AController.Free;
  end;
end;

function TcxPivotGridExportHelper.GetMapsInfoClass: TcxPivotGridMapsInfoClass;
begin
  Result := TcxPivotGridMapsInfo;
end;

// external procedures definition
{$IFNDEF DELPHI6}
type
  IInterface = IUnknown;
{$ENDIF}

function cxSupports(const Instance: IInterface; const IID: TGUID; out Intf): Boolean;
begin
  Result := (Instance <> nil) and (Instance.QueryInterface(IID, Intf) = 0);
end;

procedure cxExportPivotGridToFile(AFileName: string;
  APivotGrid: TcxCustomPivotGrid; AExportType: Integer;
  AExpand, AUseNativeFormat: Boolean; const ASeparators: array of string;
  const AFileExt: string);
var
  I: Integer;
  AIntf: IcxExportWithSeparators;
begin
  if AFileExt <> '' then
    AFileName := ChangeFileExt(AFileName, '.' + AFileExt);
  with TcxPivotGridExportHelper.Create(APivotGrid, AExportType, AFileName) do
  try
    Expand := AExpand;
    FIsNativeFormat :=  AUseNativeFormat;
    if cxSupports(Provider, IcxExportWithSeparators, AIntf) and (Length(ASeparators) > 0) then
    begin
      for I := Low(ASeparators) to High(ASeparators) do
        AIntf.AddSeparator(ASeparators[I]);
    end;
    ExportPivotGrid;
  finally
    Free;
  end;
end;

procedure cxExportPivotGridToHTML(const AFileName: string;
  APivotGrid: TcxCustomPivotGrid; AExpand: Boolean = True;
  const AFileExt: string = 'html');
begin
  cxExportPivotGridToFile(AFileName, APivotGrid, cxExportToHtml, AExpand, False,
    [], AFileExt);
end;

procedure cxExportPivotGridToXML(const AFileName: string;
  APivotGrid: TcxCustomPivotGrid; AExpand: Boolean = True;
  const AFileExt: string = 'xml');
begin
  cxExportPivotGridToFile(AFileName, APivotGrid, cxExportToXML, AExpand, False,
    [], AFileExt);
end;

procedure cxExportPivotGridToExcel(const AFileName: string;
  APivotGrid: TcxCustomPivotGrid; AExpand: Boolean = True;
  AUseNativeFormat: Boolean = True; const AFileExt: string = 'xls');
begin
  cxExportPivotGridToFile(AFileName, APivotGrid, cxExportToExcel, AExpand,
    AUseNativeFormat, [], AFileExt);
end;

procedure cxExportPivotGridToText(const AFileName: string;
  APivotGrid: TcxCustomPivotGrid; AExpand: Boolean = True;
  const ASeparator: string = ''; const ABeginString: string = '';
  const AEndString: string = '';  const AFileExt: string = 'txt');
begin
  cxExportPivotGridToFile(AFileName, APivotGrid, cxExportToText, AExpand, False,
    [ASeparator, ABeginString, AEndString], AFileExt);
end;

initialization
  Move(cxDefaultExportFontName[1], cxDefaultExportStyle.FontName[0], Length(cxDefaultExportFontName));
  cxExportInit(TcxGetResourceStringProc(@cxGetResourceString), @ColorToRGB, True);

end.

