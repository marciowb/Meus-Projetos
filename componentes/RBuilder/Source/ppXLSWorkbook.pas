{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB

  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppXLSWorkbook;

interface

uses
  Variants,
  SysUtils,
  Classes,
  Graphics,
  Forms,
  Types,
  JPEG,

  ppTypes,
  ppUtils,
  ppCollectionBase,
  ppDevice,
  ppFilDev,
  ppPrintr,
  ppFormatStyles;

type

  TppXLSCell = class;
  TppXLSCellCollection = class;
  TppXLSRow = class;
  TppXLSRowCollection = class;
  TppXLSDrawingShapeCollection = class;
  TppXLSWorksheetInfo = class;
  TppXLSFormatStyles = class;
  TppXLSCellRangeCollection = class;
  TppXLSDrawingGroupInfo = class;

  TppMD4Type = array[0..15] of Byte;

  {TppXLSWorkbookInfo

    Represents and describes an XLS Workbook. A Workbook includes global
    information such as FormatStyles and StringTable. A Workbook contains
    one of more WorkSheets}

  TppXLSWorkbookInfo = class
  private
    FDrawingGroupInfo: TppXLSDrawingGroupInfo;
    FFormatStyles: TppXLSFormatStyles;
    FStringTable: TppStringTable;
    FWorksheetInfo: TppXLSWorksheetInfo;

  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;

    property DrawingGroupInfo: TppXLSDrawingGroupInfo read FDrawingGroupInfo;
    property FormatStyles: TppXLSFormatStyles read FFormatStyles;
    property StringTable: TppStringTable read FStringTable;
    property WorksheetInfo: TppXLSWorksheetInfo read FWorksheetInfo write FWorksheetInfo;

  end;

  TppIntegerArray = array of Integer;

  TppXLSDrawingContainerInfo = class;

  {TppXLSWorksheetInfo

   Represents and describes an XLS Worksheet}

  TppXLSWorksheetInfo = class
  private
    FColWidths: TppIntegerArray;
    FDefaultColWidth: Integer;
    FDefaultRowHeight: Integer;
    FDrawingContainerInfo: TppXLSDrawingContainerInfo;
    FMergedCells: TppXLSCellRangeCollection;
    FName: string;
    FPrinterSetup: TppPrinterSetup;
    FRowCount: Integer;
    FWorkbookInfo: TppXLSWorkbookInfo;
    function GetColCount: Integer;
    procedure SetColCount(const Value: Integer);
    procedure SetPrinterSetup(const Value: TppPrinterSetup);

  protected
    property WorkbookInfo: TppXLSWorkbookInfo read  FWorkbookInfo;

  public
    constructor Create(aWorkbookInfo: TppXLSWorkbookInfo); virtual;
    destructor Destroy; override;

    property ColCount: Integer read GetColCount write SetColCount;
    property ColWidths: TppIntegerArray read FColWidths;
    property DefaultColWidth: Integer read FDefaultColWidth write FDefaultColWidth;
    property DefaultRowHeight: Integer read FDefaultRowHeight write FDefaultRowHeight;
    property DrawingContainerInfo: TppXLSDrawingContainerInfo read FDrawingContainerInfo;
    property MergedCells: TppXLSCellRangeCollection read FMergedCells;
    property Name: string read FName write FName;
    property PrinterSetup: TppPrinterSetup read FPrinterSetup write SetPrinterSetup;
    property RowCount: Integer read FRowCount write FRowCount;

  end;


  { TppXLSPage }
  TppXLSPage = class
  private
    FShapes: TppXLSDrawingShapeCollection;
    FRows: TppXLSRowCollection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    property Shapes: TppXLSDrawingShapeCollection read FShapes;
    property Rows: TppXLSRowCollection read FRows;
  end;



  {TppXLSRowCollection}
  TppXLSRowCollection = class(TppCollectionBase)
  private
    function GetRows(Index: Integer): TppXLSRow;
  public
    constructor Create; override;
    function Add(aRow: TppXLSRow): Integer; overload;
    function Add: TppXLSRow; overload;
    function GetByAbsoluteIndex(Index: Integer): TppXLSRow;
    property Rows[Index: Integer]: TppXLSRow read GetRows; default;
    property ByAbsoluteIndex[Index: Integer]: TppXLSRow read GetByAbsoluteIndex;
  end;


  {TppXLSCellCollection}
  TppXLSCellCollection = class(TppCollectionBase)
  private
    function GetCells(Index: Integer): TppXLSCell;
  public

    constructor Create; override;

    function Add(aCell: TppXLSCell): Integer; overload; virtual;
    function Add: TppXLSCell; overload; virtual;
    function GetCellForColumnIndex(aColumnIndex: Integer): TppXLSCell;
    function IndexOf(aCell: TppXLSCell): Integer;
    procedure Insert(aIndex: Integer; aCell: TppXLSCell); overload; virtual;
    function Insert(aIndex: Integer): TppXLSCell; overload; virtual;

    property Cells[Index: Integer]: TppXLSCell read GetCells; default;

  end;

  {TppXLSRow}
  TppXLSRow = class(TppXLSCellCollection)
  private
    FHeight: Integer;
    FRowIndex: Integer;
    FTop: Integer;
    function GetColIndexFirst: Integer;
    function GetColIndexLast: Integer;
  public
    function Add(aCell: TppXLSCell): Integer; overload; override;
    function Add: TppXLSCell; overload; override;
    function Insert(aIndex: Integer): TppXLSCell; overload; override;
    procedure Insert(aIndex: Integer; aCell: TppXLSCell); overload; override;
    property ColIndexFirst: Integer read GetColIndexFirst;
    property ColIndexLast: Integer read GetColIndexLast;
    property Height: Integer read FHeight write FHeight;
    property RowIndex: Integer read FRowIndex write FRowIndex;
    property Top: Integer read FTop write FTop;
  end;


  {TppXLSCell}
  TppXLSCell = class
  private
    FColumnIndex: Integer;
    FColumnRange: Integer;
    FDataType: TppDataType;
    FFormatIndex: Integer;
    FIsBlank: Boolean;
    FRowIndex: Integer;
    FStringIndex: Integer;
    FValue: Variant;
  public
    destructor Destroy; override;
    property ColumnIndex: Integer read FColumnIndex write FColumnIndex;
    property ColumnRange: Integer read FColumnRange write FColumnRange;
    property DataType: TppDataType read FDataType write FDataType;
    property FormatIndex: Integer read FFormatIndex write FFormatIndex;
    property IsBlank: Boolean read FIsBlank write FIsBlank;
    property RowIndex: Integer read FRowIndex write FRowIndex;
    property StringIndex: Integer read FStringIndex write FStringIndex;
    property Value: Variant read FValue write FValue;
  end;


  {TppXLSCellRange

    Defines a range of adjacent cells.}

  TppXLSCellRange = class
  private
    FColIndexFirst: Integer;
    FColindexLast: Integer;
    FRowIndexFirst: Integer;
    FRowIndexLast: Integer;

  public
    property ColIndexFirst: Integer read FColIndexFirst write FColIndexFirst;
    property ColindexLast: Integer read FColindexLast write FColindexLast;
    property RowIndexFirst: Integer read FRowIndexFirst write FRowIndexFirst;
    property RowIndexLast: Integer read FRowIndexLast write FRowIndexLast;
  end;

  {TppXLSCellRangeCollection

    A collection of Cell Range items. Used for the Worksheet MergedCells list}
  TppXLSCellRangeCollection = class(TppCollectionBase)
  private
    function GetItems(Index: Integer): TppXLSCellRange;
  public
    constructor Create; override;
    function Add(aCellRange: TppXLSCellRange): Integer; overload;
    function Add: TppXLSCellRange; overload;
    property Items[Index: Integer]: TppXLSCellRange read GetItems; default;
  end;



  {TppXLSDefaultFormats
    - default display formats for datatypes}
  TppXLSDefaultFormats = class
  private
    FBoolean: string;
    FCurrency: string;
    FDate: String;
    FDateTime: String;
    FDecimal: string;
    FInteger: string;
    FTime: String;
  public
    constructor Create; virtual;

    property Boolean: string read FBoolean write FBoolean;
    property Currency: string read FCurrency write FCurrency;
    property Date: String read FDate write FDate;
    property DateTime: String read FDateTime write FDateTime;
    property Decimal: string read FDecimal write FDecimal;
    property Integer: string read FInteger write FInteger;
    property Time: String read FTime write FTime;

  end;


  {TppXLSFormatStyles

    Descends from FormatStyles and adds information specific to the XLS
    file format.}

  TppXLSFormatStyles = class(TppFormatStyles)
  private
    FDefaultFontWidthScale: Double;
    FDefaultFormats: TppXLSDefaultFormats;
    function GetDefaultFont: TFont;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;


    function GetColorIndex(aColor: TColor): Integer;
    function GetDefaultDisplayFormat(aDataType: TppDataType): String; overload; virtual;
    function GetDefaultDisplayFormat(aDrawCommand: TppDrawCommand): String; overload; virtual;
    function GetDisplayFormatIndex(aDisplayFormat: String): Integer;
    function GetElementFormatIndex(aDrawCommand: TppDrawCommand): Integer;
    function GetFontIndex(aFont: TFont): Integer;
    function GetDefaultFontWidthScale: Double;
    property DefaultFont: TFont read GetDefaultFont;
    property DefaultFormats: TppXLSDefaultFormats read FDefaultFormats;

  end;


{  ----------------- XLS drawing related classes --------------- }
{

  Workbook
    DrawingGroupInfo
       BStore[ ]
         Blip
         Name
         IdMD4
       DrawingCount
       MaxShapeID
       ShapeCount
       SpIdClusters[ ]
         DrawingId
         MaxShapeId


  Worksheet
    DrawingContainerInfo
      MaxShapeID
      PatriarchShapeID
      ShapeCount
      Drawings[ ]

}

  TppXLSSpidClusterCollection = class;
  TppXLSBStore = class;



  {TppXLSDrawingGroupInfo

     - per document info

     DrawingGroupInfo
       BStore[]
       SpIdClusters[]

  }

  TppXLSDrawingShape = class;

  TppXLSDrawingGroupInfo = class
  private
    FBStore: TppXLSBStore;
    FDrawingCount: Integer;
    FMaxObjectId: Integer;
    FSpIdClusters: TppXLSSpidClusterCollection;
    FMaxShapeId: Integer;
    FShapeCount: Integer;

  protected
    procedure AddDrawing(aDrawingContainer: TppXLSDrawingContainerInfo);

  public

    constructor Create;
    destructor Destroy; override;

    function AddShape(aShape: TppXLSDrawingShape; aDrawingContainer: TppXLSDrawingContainerInfo): Integer;

    property BStore: TppXLSBStore read FBStore;
    property DrawingCount: Integer read FDrawingCount;
    property MaxObjectId: Integer read FMaxObjectId;
    property SpIdClusters: TppXLSSpidClusterCollection read FSpIdClusters;
    property MaxShapeId: Integer read FMaxShapeId;
    property ShapeCount: Integer read FShapeCount;
  end;

  {TppXLSSpIdCluster}
  TppXLSSpIdCluster = class
  private
    FDrawingId: Integer;
    FShapeCount: Integer;
  public
    property DrawingId: Integer read FDrawingId write FDrawingId;
    property ShapeCount: Integer read FShapeCount write FShapeCount;
  end;

  {TppXLSSpidClusterCollection}
  TppXLSSpidClusterCollection = class(TppCollectionBase)
  private
    function GetItems(Index: Integer): TppXLSSpIdCluster;
  public
    constructor Create; override;
    function Add: TppXLSSpIdCluster;
    property Items[Index: Integer]: TppXLSSpIdCluster read GetItems; default;
  end;


  {TppXLSBStoreEntry}
  TppXLSBStoreEntry = class
  private
    FBlip: TGraphic;
    FIdMD4: TppMD4Type;
    FIndex: Integer;
    FName: string;
    FRefCount: Integer;

    function CloneGraphic(aGraphic: TGraphic): TGraphic;
  public
    constructor Create(const aImageName: String; aGraphic: TGraphic);
    destructor Destroy; override;

    property Blip: TGraphic read FBlip;
    property IdMD4: TppMD4Type read FIdMD4 write FIdMD4;
    property Index: Integer read FIndex write FIndex;
    property Name: string read FName;
    property RefCount: Integer read FRefCount write FRefCount;
  end;

  {TppXLSBStore}
  TppXLSBStore = class(TppCollectionBase)
  private
    function GetItems(Index: Integer): TppXLSBStoreEntry;
  public
    constructor Create; override;
    function Add(const aImageName: String; aGraphic: TGraphic): Integer;
    function IndexOf(const aImageName: String): Integer;
    property Items[Index: Integer]: TppXLSBStoreEntry read GetItems; default;
  end;


  {TppXLSDrawingContainerInfo
     - per sheet info}
  TppXLSDrawingContainerInfo = class
  private
    FDrawingID: Integer;
    FMaxShapeID: Integer;
    FPatriarchShapeID: Integer;
    FShapeCount: Integer;
    FStreamedSize: Integer;
  public

    constructor Create;

    property DrawingID: Integer read FDrawingID write FDrawingID;
    property MaxShapeID: Integer read FMaxShapeID write FMaxShapeID;
    property PatriarchShapeID: Integer read FPatriarchShapeID write FPatriarchShapeID;
    property ShapeCount: Integer read FShapeCount write FShapeCount;
    property StreamedSize: Integer read FStreamedSize write FStreamedSize;
  end;


  {TppXLSDrawingShape}
  TppXLSDrawingShape = class
  private
    FBounds: TRect;
    FCol1: Integer;
    FCol2: Integer;
    FDx1: Integer;
    FDx2: Integer;
    FDy1: Integer;
    FDy2: Integer;
    FObjectId: Integer;
    FRow1: Integer;
    FRow2: Integer;
    FShapeId: Integer;
  public
    property Bounds: TRect read FBounds write FBounds;
    property Col1: Integer read FCol1 write FCol1;
    property Col2: Integer read FCol2 write FCol2;
    property Dx1: Integer read FDx1 write FDx1;
    property Dx2: Integer read FDx2 write FDx2;
    property Dy1: Integer read FDy1 write FDy1;
    property Dy2: Integer read FDy2 write FDy2;
    property ObjectId: Integer read FObjectId write FObjectId;
    property Row1: Integer read FRow1 write FRow1;
    property Row2: Integer read FRow2 write FRow2;
    property ShapeId: Integer read FShapeId write FShapeId;
  end;

  TppXLSDrawingImage = class(TppXLSDrawingShape)
  private
    FGraphic: TGraphic;
    FImageIndex: Integer;
    FImageName: String;
    FOwnsGraphic: Boolean;
  public
    destructor Destroy; override;
    property Graphic: TGraphic read FGraphic write FGraphic;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property ImageName: String read FImageName write FImageName;
    property OwnsGraphic: Boolean read FOwnsGraphic write FOwnsGraphic;
  end;

  {TppXLSDrawingLine}
  TppXLSDrawingLine = class(TppXLSDrawingShape)
  private
    FLineColorIndex: Integer;
    FLineStyle: Integer;
    FLineWeight: Integer;
    FQuadrant: Integer;
  public
    property LineColorIndex: Integer read FLineColorIndex write FLineColorIndex;
    property LineStyle: Integer read FLineStyle write FLineStyle;
    property LineWeight: Integer read FLineWeight write FLineWeight;
    property Quadrant: Integer read FQuadrant write FQuadrant;

  end;


  {TppXLSDrawingRectangle}
  TppXLSDrawingRectangle = class(TppXLSDrawingShape)
  private
    FFillColorIndex: Integer;
    FFillPattern: Integer;
    FLineColorIndex: Integer;
    FLineStyle: Integer;
    FLineWeight: Integer;
    FRoundedCorners: Boolean;
  public
    property FillColorIndex: Integer read FFillColorIndex write FFillColorIndex;
    property FillPattern: Integer read FFillPattern write FFillPattern;
    property LineColorIndex: Integer read FLineColorIndex write FLineColorIndex;
    property LineStyle: Integer read FLineStyle write FLineStyle;
    property LineWeight: Integer read FLineWeight write FLineWeight;
    property RoundedCorners: Boolean read FRoundedCorners write FRoundedCorners;
  end;

  TppXLSDrawingOval = class(TppXLSDrawingRectangle)

  end;


  {TppXLSDrawingShapeCollection}
  TppXLSDrawingShapeCollection = class(TppCollectionBase)
  private
    function GetItems(Index: Integer): TppXLSDrawingShape;
  public
    constructor Create; override;
    function Add(aShape: TppXLSDrawingShape): Integer; overload;
    function Add: TppXLSDrawingShape; overload;
    property Items[Index: Integer]: TppXLSDrawingShape read GetItems; default;
  end;




implementation

constructor TppXLSCellCollection.Create;
begin

  inherited;

  InnerList.OwnsObjects := True;

end;

function TppXLSCellCollection.Add(aCell: TppXLSCell): Integer;
begin
  Result := InnerList.Add(aCell);

end;

function TppXLSCellCollection.Add: TppXLSCell;
begin
  Result := TppXLSCell.Create;
  Add(Result);
end;

function TppXLSCellCollection.GetCellForColumnIndex(aColumnIndex: Integer): TppXLSCell;
var
  liIndex: Integer;
begin

  Result := nil;

  for liIndex := 0 to Count - 1 do
    if Cells[liIndex].ColumnIndex = aColumnIndex then
      begin
        Result := Cells[liIndex];
        Exit;
      end;

end;

function TppXLSCellCollection.GetCells(Index: Integer): TppXLSCell;
begin
  Result := TppXLSCell(InnerList[Index]);
end;

function TppXLSCellCollection.IndexOf(aCell: TppXLSCell): Integer;
begin
  Result := InnerList.IndexOf(aCell);
end;

procedure TppXLSCellCollection.Insert(aIndex: Integer; aCell: TppXLSCell);
begin
  InnerList.Insert(aIndex, aCell);

end;

function TppXLSCellCollection.Insert(aIndex: Integer): TppXLSCell;
begin
  Result := TppXLSCell.Create;

  Insert(aIndex, Result);

end;

constructor TppXLSWorksheetInfo.Create(aWorkbookInfo: TppXLSWorkbookInfo);
begin
  inherited Create;

  FWorkbookInfo := aWorkbookInfo;

  Name := 'Report'; // TODO: localize

  FMergedCells := TppXLSCellRangeCollection.Create;

  FPrinterSetup := TppPrinterSetup.Create(nil);

  FDefaultRowHeight := TppFileDeviceUtils.PixelsToTwips(20, Screen.PixelsPerInch);

  DefaultColWidth := 6; // characters (using zero char of default font)

  FDrawingContainerInfo := TppXLSDrawingContainerInfo.Create;

end;

destructor TppXLSWorksheetInfo.Destroy;
begin

  FDrawingContainerInfo.Free;
  FDrawingContainerInfo := nil;

  FMergedCells.Free;
  FMergedCells := nil;

  FPrinterSetup.Free;
  FPrinterSetup := nil;

  inherited;

end;

function TppXLSWorksheetInfo.GetColCount: Integer;
begin

  if (FColWidths <> nil) then
    Result := Length(FColWidths)
  else
    Result := 0;

end;

procedure TppXLSWorksheetInfo.SetColCount(const Value: Integer);
begin
  SetLength(FColWidths, Value);
end;

procedure TppXLSWorksheetInfo.SetPrinterSetup(const Value: TppPrinterSetup);
begin
  FPrinterSetup.Assign(Value);
end;


constructor TppXLSRowCollection.Create;
begin

  inherited;

  InnerList.OwnsObjects := True;

end;

function TppXLSRowCollection.Add(aRow: TppXLSRow): Integer;
begin

  Result := InnerList.Add(aRow);
end;

function TppXLSRowCollection.Add: TppXLSRow;
begin

  Result := TppXLSRow.Create;
  Add(Result);
end;

function TppXLSRowCollection.GetRows(Index: Integer): TppXLSRow;
begin

  Result := TppXLSRow(InnerList[Index]);
end;

function TppXLSRowCollection.GetByAbsoluteIndex(Index: Integer): TppXLSRow;
begin
  if Count > 0 then
    Index := Index - Rows[0].RowIndex;
  Result := Rows[Index];
end;



constructor TppXLSFormatStyles.Create;
var
  lFont: TFont;
  liFontWidth: Integer;
begin

  inherited;

  FDefaultFormats := TppXLSDefaultFormats.Create;


  // default font
  lFont := TFont.Create;

  if (Win32MajorVersion >= 6) then
    begin
       // default for Vista and later
      lFont.Name := 'Calibri';
      lFont.Size := 11;
    end
  else
    begin
      lFont.Name := 'Arial';
      lFont.Size := 10;
    end;

  Fonts.Add(lFont);

  // calc width of zero chars
  liFontWidth := ppGetSpTextWidth(lFont, '0');

  liFontWidth := TppFileDeviceUtils.PixelsToTwips(liFontWidth, Screen.PixelsPerInch);

  // calc scaling factor - 256th's of a char
  FDefaultFontWidthScale := 256 / liFontWidth;

  lFont.Free;


end;

destructor TppXLSFormatStyles.Destroy;
begin

  FDefaultFormats.Free;
  FDefaultFormats := nil;

  inherited;

end;

function TppXLSFormatStyles.GetColorIndex(aColor: TColor): Integer;
begin

  Result := Colors.Add(aColor);

  // 1st user-defined color starts at 8
  Result := Result + 8;


end;

function TppXLSFormatStyles.GetDefaultDisplayFormat(aDataType: TppDataType): String;
begin

  case aDataType of
    dtBoolean: Result := FDefaultFormats.Boolean;
    dtDate: Result := FDefaultFormats.Date;
    dtTime: Result := FDefaultFormats.Time;
    dtDateTime: Result := FDefaultFormats.DateTime;
    dtInteger,
    dtLongint,
    dtLargeInt: Result := FDefaultFormats.Integer;
    dtSingle,
    dtDouble,
    dtExtended: Result := FDefaultFormats.Decimal;
    dtCurrency: Result := FDefaultFormats.Currency;
    else
//    dtChar: ;
//    dtString: ;
//    dtVariant: ;
//    dtBLOB: ;
//    dtMemo: ;
//    dtGraphic: ;
//    dtNotKnown: ;
//    dtGUID: ;
      Result := '';
  end;



end;

function TppXLSFormatStyles.GetDefaultDisplayFormat(aDrawCommand: TppDrawCommand): String;
var
  lDataType: TppDataType;
begin

  if aDrawCommand.DisplayFormat <> '' then
    Result := aDrawCommand.DisplayFormat
  else
    begin

      if aDrawCommand.DataType= dtVariant then
         lDataType := ppVariantTypeToDataType(VarType(aDrawCommand.Value))
      else
        lDataType := aDrawCommand.DataType;

      // get default format for datatype
      Result := GetDefaultDisplayFormat(lDataType);

    end;

end;

function TppXLSFormatStyles.GetDefaultFont: TFont;
begin

  if (Fonts <> nil) and (Fonts.Count > 0) then
    Result := Fonts[0]
  else
    Result := nil;

end;

function TppXLSFormatStyles.GetDisplayFormatIndex(aDisplayFormat: String): Integer;
begin

  Result := DisplayFormats.IndexOf(aDisplayFormat);

  // 1st user-defined format starts at 164 (0-163 are reserved)
  Result := Result + 164;

end;

function TppXLSFormatStyles.GetElementFormatIndex(aDrawCommand: TppDrawCommand): Integer;
begin
  Result := ElementFormats.Add(aDrawCommand) + 21;
end;

function TppXLSFormatStyles.GetFontIndex(aFont: TFont): Integer;
begin

  Result := Fonts.Add(aFont);

  // first 4 fonts have 0 based index, then 1 based after that
  if (Result >= 4) then
    Inc(Result);

end;

function TppXLSFormatStyles.GetDefaultFontWidthScale: Double;
begin

 Result := FDefaultFontWidthScale;

end;

constructor TppXLSWorkbookInfo.Create;
begin

  inherited;

  FDrawingGroupInfo := TppXLSDrawingGroupInfo.Create;
  FFormatStyles := TppXLSFormatStyles.Create;
  FStringTable := TppStringTable.Create;
  FWorksheetInfo := TppXLSWorksheetInfo.Create(Self);

end;

destructor TppXLSWorkbookInfo.Destroy;
begin

  FDrawingGroupInfo.Free;
  FDrawingGroupInfo := nil;

  FFormatStyles.Free;
  FFormatStyles := nil;

  FStringTable.Free;
  FStringTable := nil;

  FWorksheetInfo.Free;
  FWorksheetInfo := nil;

  inherited;

end;

function TppXLSRow.Add(aCell: TppXLSCell): Integer;
begin
  aCell.RowIndex := FRowIndex;
  Result := inherited Add(aCell);
end;

function TppXLSRow.Add: TppXLSCell;
begin
  Result := inherited Add;

  Result.RowIndex := FRowIndex;
  Result.ColumnIndex := Count-1;

end;

function TppXLSRow.GetColIndexFirst: Integer;
begin

  if Count = 0 then
    Result :=-1
  else
    Result := Cells[0].ColumnIndex;

end;

function TppXLSRow.GetColIndexLast: Integer;
begin

  if Count = 0 then
    Result :=-1
  else
    Result := Cells[Count-1].ColumnIndex;

end;

function TppXLSRow.Insert(aIndex: Integer): TppXLSCell;
begin
  Result := TppXLSCell.Create;

  Insert(aIndex, Result);

end;

procedure TppXLSRow.Insert(aIndex: Integer; aCell: TppXLSCell);
begin
  aCell.RowIndex := FRowIndex;
  InnerList.Insert(aIndex, aCell);

end;

constructor TppXLSCellRangeCollection.Create;
begin

  inherited;

  InnerList.OwnsObjects := True;

end;

function TppXLSCellRangeCollection.Add(aCellRange: TppXLSCellRange):
    Integer;
begin
  Result := InnerList.Add(aCellRange);
end;

function TppXLSCellRangeCollection.Add: TppXLSCellRange;
begin
  Result := TppXLSCellRange.Create;
  InnerList.Add(Result);
end;

function TppXLSCellRangeCollection.GetItems(Index: Integer): TppXLSCellRange;
begin
  Result := TppXLSCellRange(InnerList[Index]);
end;

destructor TppXLSCell.Destroy;
begin
  inherited;

end;

constructor TppXLSDefaultFormats.Create;
begin

  inherited;

  FCurrency := '"$"#,##0.00_);("$"#,##0.00)';

  // update currency with region settings
  FCurrency := StringReplace(FCurrency, '$', CurrencyString, [rfReplaceAll]);

  // updating thousand/decimal seps requires two steps
  FCurrency := StringReplace(FCurrency, ',', 'c', [rfReplaceAll]);
  FCurrency := StringReplace(FCurrency, '.', 'd', [rfReplaceAll]);
  FCurrency := StringReplace(FCurrency, 'c', ThousandSeparator, [rfReplaceAll]);
  FCurrency := StringReplace(FCurrency, 'd', DecimalSeparator, [rfReplaceAll]);

  FDate := ShortDateFormat;

//  FDecimal := '#,##0';
//  FTime := 'h:mm AM/PM'; // ShortTimeFormat;
  FTime := ShortTimeFormat;

  // update for xls compatibilty
  FTime := StringReplace(ShortTimeFormat, 'AMPM', 'AM/PM', [rfReplaceAll]);

  FDateTime := FDate + ' ' + FTime;

end;

constructor TppXLSDrawingShapeCollection.Create;
begin

  inherited;

  InnerList.OwnsObjects := True;

end;

function TppXLSDrawingShapeCollection.Add(aShape: TppXLSDrawingShape): Integer;
begin
  Result := InnerList.Add(aShape);
end;

function TppXLSDrawingShapeCollection.Add: TppXLSDrawingShape;
begin
  Result := TppXLSDrawingShape.Create;
  InnerList.Add(Result);
end;

function TppXLSDrawingShapeCollection.GetItems(Index: Integer): TppXLSDrawingShape;
begin
  Result := TppXLSDrawingShape(InnerList[Index]);
end;

constructor TppXLSPage.Create;
begin

  inherited;

  FShapes := TppXLSDrawingShapeCollection.Create;
  FRows := TppXLSRowCollection.Create;

end;

destructor TppXLSPage.Destroy;
begin

  FShapes.Free;
  FRows.Free;

  inherited;

end;

procedure TppXLSPage.Clear;
begin
  FShapes.Clear;
  FRows.Clear;

end;

constructor TppXLSBStore.Create;
begin

  inherited;

  InnerList.OwnsObjects := True;

end;

function TppXLSBStore.Add(const aImageName: String; aGraphic: TGraphic): Integer;
var
  lBStoreEntry: TppXLSBStoreEntry;
begin

  Result := IndexOf(aImageName);


  if Result >= 0 then
    Items[Result].RefCount := Items[Result].RefCount + 1
  else
    begin
      lBStoreEntry := TppXLSBStoreEntry.Create(aImageName, aGraphic);
      Result := InnerList.Add(lBStoreEntry);

    end;

end;

function TppXLSBStore.GetItems(Index: Integer): TppXLSBStoreEntry;
begin
  Result := TppXLSBStoreEntry(InnerList[Index]);
end;

function TppXLSBStore.IndexOf(const aImageName: String): Integer;
var
  liIndex: Integer;
begin
  Result := -1;

  for liIndex := 0 to InnerList.Count - 1 do
    if (Items[liIndex].Name = aImageName) then
      begin
        Result := liIndex;
        Exit;
      end;
end;

constructor TppXLSSpidClusterCollection.Create;
begin

  inherited;

  InnerList.OwnsObjects := True;

end;

function TppXLSSpidClusterCollection.Add: TppXLSSpIdCluster;
begin
  Result := TppXLSSpIdCluster.Create;
  InnerList.Add(Result);
end;

function TppXLSSpidClusterCollection.GetItems(Index: Integer): TppXLSSpIdCluster;
begin
  Result := TppXLSSpIdCluster(InnerList[Index]);
end;

constructor TppXLSDrawingGroupInfo.Create;
begin

  inherited Create;

  FBStore := TppXLSBStore.Create;
  FSpIdClusters := TppXLSSpidClusterCollection.Create;

  FMaxObjectId := 0;
  FMaxShapeID := 1024

end;

destructor TppXLSDrawingGroupInfo.Destroy;
begin

  FBStore.Free;
  FBStore := nil;

  FSpIdClusters.Free;
  FSpIdClusters := nil;

  inherited;

end;

procedure TppXLSDrawingGroupInfo.AddDrawing(aDrawingContainer: TppXLSDrawingContainerInfo);
begin

  Inc(FDrawingCount);
  Inc(FMaxShapeID);
  Inc(FShapeCount);

  aDrawingContainer.DrawingID := FDrawingCount;
  aDrawingContainer.PatriarchShapeID := FMaxShapeID;
  aDrawingContainer.ShapeCount := FShapeCount;

  // add SpidCluster
  FSpIdClusters.Add;

  FSpIdClusters.Items[0].DrawingId := FDrawingCount;
  FSpIdClusters.Items[0].ShapeCount := 1;


end;

function TppXLSDrawingGroupInfo.AddShape(aShape: TppXLSDrawingShape; aDrawingContainer: TppXLSDrawingContainerInfo): Integer;
var
  lDrawingImage: TppXLSDrawingImage;
begin

  Result := 0;

  if not (aShape is TppXLSDrawingImage) then
    begin
      Inc(FMaxObjectId);
      aShape.ObjectId := FMaxObjectId;
      Exit;
    end;

  lDrawingImage := TppXLSDrawingImage(aShape);

  if (lDrawingImage.Graphic = nil) then Exit;

  if (aDrawingContainer.ShapeCount = 0) then
    AddDrawing(aDrawingContainer);

  Inc(FMaxObjectId);
  Inc(FShapeCount);
  Inc(FMaxShapeId);

  lDrawingImage.ObjectId := FMaxObjectId;
  lDrawingImage.ShapeId := FMaxShapeId;
  lDrawingImage.ImageIndex := FBStore.Add(lDrawingImage.ImageName, lDrawingImage.Graphic);

  aDrawingContainer.MaxShapeID := FMaxShapeId;
  aDrawingContainer.ShapeCount :=  aDrawingContainer.ShapeCount + 1;

  FSpIdClusters.Items[0].ShapeCount := aDrawingContainer.ShapeCount;

  Result := lDrawingImage.ImageIndex;

end;

constructor TppXLSBStoreEntry.Create(const aImageName: String; aGraphic: TGraphic);
begin
  inherited Create;

  FName := aImageName;
  FBlip := CloneGraphic(aGraphic);
  FRefCount := 1;

end;

destructor TppXLSBStoreEntry.Destroy;
begin

  FBlip.Free;
  FBlip := nil;

  inherited;

end;

function TppXLSBStoreEntry.CloneGraphic(aGraphic: TGraphic): TGraphic;
var
  lClassType: TGraphicClass;
begin

  lClassType := TGraphicClass(aGraphic.ClassType);

  // convert bmp to jpeg
  if lClassType = TBitmap then
    lClassType := TJPEGImage;

  Result := lClassType.Create;
  Result.Assign(aGraphic);

end;

constructor TppXLSDrawingContainerInfo.Create;
begin

  inherited Create;

end;

destructor TppXLSDrawingImage.Destroy;
begin

  if FOwnsGraphic then
    begin
      FGraphic.Free;
      FGraphic := nil;
    end;

  inherited;

end;

end.
