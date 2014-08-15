{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppCTCell;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}Variants,{$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppComm, ppRelatv, ppDB, ppTypes, ppUtils, ExtCtrls, StdCtrls;

const
  ciCellHeight = 20;
  ciCellWidth = 75;

  ppNumerics: TppDataTypeSet = [dtDate, dtTime, dtDateTime, dtInteger, dtSingle,
                                dtDouble, dtExtended, dtCurrency, dtLongint];

type

  TppBorderType = (btLeft, btRight, btTop, btBottom);

  {@TppCoordinate }
  TppCoordinate = class(TObject)
    private
      FColumn: Integer;
      FRow: Integer;

    public
      constructor Create(aColumn, aRow: Integer);

      property Column: Integer read FColumn write FColumn;
      property Row: Integer read FRow write FRow;
  end; {class, TppCoordinate}

  {@TppSubTotalCoordinate }
  TppSubTotalCoordinate = class(TppCoordinate)
    private
      FDefIndex: Integer;

    public
      constructor Create(aColumn, aRow: Integer; aDefIndex: Integer);

      property DefIndex: Integer read FDefIndex write FDefIndex;

  end; {class, TppSubTotalCoordinate}

  {@TppColumnSubTotalCoordinate }
  TppColumnSubTotalCoordinate = class(TppSubTotalCoordinate)
  end;

  {@TppRowSubTotalCoordinate }
  TppRowSubTotalCoordinate = class(TppSubTotalCoordinate)
  end;

  {TppDataType = (dtBoolean, dtDate, dtTime, dtDateTime, dtInteger, dtSingle,
                 dtDouble, dtExtended, dtCurrency, dtChar, dtString,
                 dtLongint, dtBLOB, dtMemo, dtGraphic, dtNotKnown);}

  {@TppMatrix

    The matrix object is generated when the crosstab engine applies the crosstab
    definition to the data supplied via the DataPipeline. The matrix represents
    a set of homogenous cells, whose properties can be access via a set of array
    properties declared in the matrix class. When the engine generates the
    matrix, it uses various properties and methods to populate the matrix with
    the captions and calculations of the crosstab.  The matrix has thecapability
    to reserve rows at the top and columns on the left for captions.  That means
    only string values will go into these cells.  The number of reserved columns
    is indicated by the RowHeaderCount property.  The number of rows reserved is
    indicated by the ColumnHeaderCount property. The string cells in these areas
    are not only used to store captions, they are also used to store additional
    information (such as the DefIndex, the ValueDefIndex and whether or not the
    row or column is a total row or total column). This information is not
    available when accessing the value cells located in the remainder of the
    matrix.  For this reason, the caption areas act as 'metadata',  describing
    the structure of the crosstab, while the value cells simply contain values.

    Once the engine has populated the matrix, the renderer uses an additional
    set of matrix properties and methods to store information about the height
    and width of each column and row in order to suppress repeating caption
    values and to compute the exact size and location of the grid lines. This
    information is also stored in the caption cells areas.  Some of the key
    properties and methods used in this process are: Caption, CaptionWidth,
    CaptionHeight, CaptionVisible and Borders.

    The renderer completes the last step in printing a crosstab by converting
    the information in the matrix into DrawText and DrawLine commands.  While
    the generation and formatting steps must take into account the entire
    crosstab, the renderer only needs to create the draw commands necessary for
    the current page. Then when the report requests the next page, the renderer
    resumes where it left off.  This process continues until the entire crosstab
    is rendered.}

  {@TppMatrix.Borders

    Controls whether the border of a given cell is on or off.  Applies to
    caption cells only.}

  {@TppMatrix.CaptionHeight

    The height of the caption, as calculated by the renderer.}

  {@TppMatrix.CaptionWidth

    The width of the caption, as calculated by the renderer.}

  {@TppMatrix.CaptionVisible

    Determines whether or not the caption in the given cell is visible.  
    This value is set by the renderer.}

  {@TppMatrix.ColumnCount

    Total number of columns in the matrix.}

  {@TppMatrix.ColumnHeaderCount

    Number of rows at the top of the matrix that are reserved for captions.
    All of the rows from row 0 to ColumnHeaderCount - 1 can contain string
    values only.}

  {@TppMatrix.Count

    Retrieves the value of the cells as an integer, used for average 
    calculations only.}

  {@TppMatrix.DataType

    The data type of the cell in the given position.  For caption cells, 
    this property always returns dtString.  For value cells this property
    returns the data type of the associated value dimension.}

  {@TppMatrix.DefIndex

    Returns the Index of the RowDef or ColumnDef component associated with 
    a row or column.}

  {@TppMatrix.ElementIndex

    Indicates the index of the crosstab definition component associated 
    with the cell.  Valid for all cells.}

  {@TppMatrix.IsNull

    Indicates whether the value of the cell has ever been set.}

  {@TppMatrix.RowCount

    Total number of rows in the matrix.}

  {@TppMatrix.RowHeaderCount

    Number of columns on the left hand side of the matrix that are reserved 
    for captions.  All of the columns from column 0 to RowHeaderCount - 1
    can contain string values only.}

  {@TppMatrix.Sum

    Retrieves the value of the cell as variant, used for average 
    calculations only.}

  {@TppMatrix.Value

    The native value in the cell at this position, returned as a variant.}

  {@TppMatrix.ValueDefCaption

    Returns the caption of the ValueDef component associated with a row or 
    column total. Only valid for TotalCaption type cells, (ie. must be a
    total column with a row value less than RowHeaderCount or a total row
    with a column value less than RowHeaderCount).}

  {@TppMatrix.ValueDefIndex

    Returns the Index of the ValueDef component associated with a row or
    column total. Only valid for TotalCaption type cells, (ie. must be a
    total column with a row value less than RowHeaderCount or a total row
    with a column value must less than RowHeaderCount).}

  TppMatrix = class
    private
      FColumnHeaderCount: Integer;
      FRowHeaderCount: Integer;

      FColumns: TList;

      function  CreateColumnCell(aColumn, aRow: Integer; aValueDataType: TppDataType): TObject;
      function  CreateRowCell(aColumn, aRow: Integer; aValueDataType: TppDataType): TObject;
      procedure FreeCells;
      procedure FreeColumns;
      function  GetBorders(aColumn, aRow: Integer; aBorderType: TppBorderType): Boolean;
      function  GetCaptionHeight(aColumn, aRow: Integer): Integer;
      function  GetCaptionWidth(aColumn, aRow: Integer): Integer;
      function  GetCaptionVisible(aColumn, aRow: Integer): Boolean;
      function  GetCopyColumn(aColumn: Integer): Integer;
      function  GetCount(aColumn, aRow: Integer): Integer;
      function  GetDataType(aColumn, aRow: Integer): TppDataType;
      function  GetDefCaption(aColumn, aRow: Integer): String;
      function  GetDefIndex(aColumn, aRow: Integer): Integer;
      function  GetElementIndex(aColumn, aRow: Integer): Integer;
      function  GetIsCaption(aColumn, aRow: Integer): Boolean;
      function  GetIsEmpty(aColumn, aRow: Integer): Boolean;
      function  GetIsNull(aColumn, aRow: Integer): Boolean;
      function  GetSum(aColumn, aRow: Integer): Variant;
      function  GetValue(aColumn, aRow: Integer): Variant;
      function  GetValueDefIndex(aColumn, aRow: Integer): Integer;
      function  GetValueDefCaption(aColumn, aRow: Integer): String;
      function  GetColumnCount: Integer;
      function  GetRowCount: Integer;
      function  HeaderCell(aColumn, aRow: Integer): Boolean;
      procedure SetBorders(aColumn, aRow: Integer; aBorderType: TppBorderType; aValue: Boolean);
      procedure SetCaptionHeight(aColumn, aRow: Integer; aValue: Integer);
      procedure SetCaptionWidth(aColumn, aRow: Integer; aValue: Integer);
      procedure SetCaptionVisible(aColumn, aRow: Integer; aValue: Boolean);
      procedure SetCount(aColumn, aRow: Integer; aValue: Integer);
      procedure SetDefIndex(aColumn, aRow: Integer; aDefIndex: Integer);
      procedure SetElementIndex(aColumn, aRow: Integer; aElementIndex: Integer);
      procedure SetIsNull(aColumn, aRow: Integer; aValue: Boolean);
      procedure SetSum(aColumn, aRow: Integer; aValue: Variant);
      procedure SetValue(aColumn, aRow: Integer; aValue: Variant);

    public
      constructor Create;
      destructor Destroy; override;

      procedure AppendColumns(aColumnCount: Integer; aValueDataType: TppDataType);
      procedure AppendRows(aRowCount: Integer; aValueDataType: TppDataType);
      procedure DeleteColumns(aStartColumn, aEndColumn: Integer);
      procedure DeleteRows(aStartRow, aEndRow: Integer);
      procedure InsertColumns(aColumn, aColumnCount: Integer; aValueDataType: TppDataType);
      procedure InsertRows(aRow, aRowCount: Integer; aValueDataType: TppDataType);
      procedure InsertTotalColumn(aColumn, aColumnDef: Integer; aValueDataType: TppDataType;
                                  aColumnDefValue: Variant; const aColumnDefCaption: String; aIsSubTotal: Boolean);
      procedure InsertTotalRow(aRow, aRowDef, aValueDef: Integer; aValueDataType: TppDataType;
                               aRowDefValue: Variant; const aRowDefCaption, aValueDefCaption: String; aIsSubTotal: Boolean);

      function  IsTotalColumn(aColumn: Integer): Boolean;
      function  IsTotalRow(aRow: Integer): Boolean;
      function  FirstLabelColumnOfRowTotal(aRow: Integer): Integer;
      function  FirstLabelRowOfColumnTotal(aColumn: Integer): Integer;
      function  FirstDataColumn(aColumn: Integer): Integer;

      property Borders[aColumn, aRow: Integer; aBorderType: TppBorderType]: Boolean read GetBorders write SetBorders;
      property Count[aColumn, aRow: Integer]: Integer read GetCount write SetCount;
      property CaptionHeight[aColumn, aRow: Integer]: Integer read GetCaptionHeight write SetCaptionHeight;
      property CaptionWidth[aColumn, aRow: Integer]: Integer read GetCaptionWidth write SetCaptionWidth;
      property CaptionVisible[aColumn, aRow: Integer]: Boolean read GetCaptionVisible write SetCaptionVisible;
      property DataType[aColumn, aRow: Integer]: TppDataType read GetDataType;
      property DefCaption[aColumn, aRow: Integer]: String read GetDefCaption;
      property DefIndex[aColumn, aRow: Integer]: Integer read GetDefIndex write SetDefIndex;
      property ElementIndex[aColumn, aRow: Integer]: Integer read GetElementIndex write SetElementIndex;
      property IsCaption[aColumn, aRow: Integer]: Boolean read GetIsCaption;
      property IsEmpty[aColumn, aRow: Integer]: Boolean read GetIsEmpty;
      property IsNull[aColumn, aRow: Integer]: Boolean read GetIsNull write SetIsNull;
      property Sum[aColumn, aRow: Integer]: Variant read GetSum write SetSum;
      property ValueDefCaption[aColumn, aRow: Integer]: String read GetValueDefCaption;
      property ValueDefIndex[aColumn, aRow: Integer]: Integer read GetValueDefIndex;
      property Value[aColumn, aRow: Integer]: Variant read GetValue write SetValue;

      property ColumnCount: Integer read GetColumnCount;
      property ColumnHeaderCount: Integer read FColumnHeaderCount write FColumnHeaderCount;
      property RowCount: Integer read GetRowCount;
      property RowHeaderCount: Integer read FRowHeaderCount write FRowHeaderCount;

  end; {class, TppMatrix}

  function ppDataTypesCompatible(aDataType1, aDataType2: TppDataType): Boolean;
  function ppStringToCaption(aValue: String): String;

implementation


type

  {@TppCellValue }
  TppCellValue = class
    private
      FIsEmpty: Boolean;
      FIsNull: Boolean;
      FElementIndex: Integer;

    public
      constructor Create;

      function  DataType: TppDataType; virtual; abstract;
      function  GetValue: Variant; virtual; abstract;
      procedure SetValue(aValue: Variant); virtual;

      {averages only}
      function  GetCount: Integer; virtual; abstract;
      function  GetSum: Variant; virtual; abstract;
      procedure SetCount(aValue: Variant); virtual; abstract;
      procedure SetSum(aValue: Variant); virtual; abstract;

      property ElementIndex: Integer read FElementIndex write FElementIndex;
      property IsNull: Boolean read FIsNull write FIsNull;
      property IsEmpty: Boolean read FIsEmpty write FIsEmpty;

  end; {class, TppCellValue}

  {@TppStringCellValue }
  TppStringCellValue = class(TppCellValue)
    private
      FBorders: array[0..3] of Boolean;
      FCaption: String;
      FCaptionVisible: Boolean;
      FDataValue: TppCellValue;
      FHeight: Integer;
      FWidth: Integer;

      function  GetBorders(aBorderType: TppBorderType): Boolean;
      procedure SetBorders(aBorderType: TppBorderType; aValue: Boolean);

    public
      constructor Create;
      destructor Destroy; override;

      function  DataType: TppDataType; override;
      function  GetValue: Variant; override;
      procedure SetValue(aValue: Variant); override;

      {averages only}
      function  GetCount: Integer; override;
      function  GetSum: Variant; override;
      procedure SetCount(aValue: Variant); override;
      procedure SetSum(aValue: Variant); override;

      property  Borders[Index: TppBorderType]: Boolean read GetBorders write SetBorders;

      property  CaptionVisible: Boolean read FCaptionVisible write FCaptionVisible;
      property  Height: Integer read FHeight write FHeight;
      property  Width: Integer read FWidth write FWidth;
  end; {class, TppStringCellValue}

  {@TppTotalLabel }
  TppTotalLabel = class(TppStringCellValue)
    private
      FDefCaption: String;
      FDefIndex: Integer;
      FValueDefIndex: Integer;
      FValueDefCaption: String;

    public
      constructor Create;

      function  DefIndex: Integer;
      function  DefCaption: String;
      function  ValueDefCaption: String;
      function  ValueDefIndex: Integer;
      procedure SetDefCaption(aDefCaption: String);
      procedure SetDefIndex(aDefIndex: Integer);
      procedure SetValueDefIndex(aValueDefIndex: Integer);
      procedure SetValueDefCaption(aCaption: String);

  end; {class, TppTotalLabel}

  {@TppIntegerCellValue }
  TppIntegerCellValue = class(TppCellValue)
    private
      FValue: Integer;
      FSum: Integer;
      FCount: Integer;

    public
      constructor Create;

      function  DataType: TppDataType; override;
      function  GetValue: Variant; override;
      procedure SetValue(aValue: Variant); override;

      {averages only}
      function  GetCount: Integer; override;
      function  GetSum: Variant; override;
      procedure SetCount(aValue: Variant); override;
      procedure SetSum(aValue: Variant); override;

  end; {class, TppIntegerCellValue}

  {@TppLongintCellValue }
  TppLongintCellValue = class(TppCellValue)
    private
      FValue: Longint;
      FSum: Longint;
      FCount: Integer;

    public
      constructor Create;

      function  DataType: TppDataType; override;
      function  GetValue: Variant; override;
      procedure SetValue(aValue: Variant); override;

      {averages only}
      function  GetCount: Integer; override;
      function  GetSum: Variant; override;
      procedure SetCount(aValue: Variant); override;
      procedure SetSum(aValue: Variant); override;

  end; {class, TppLongintCellValue}

  {@TppDateTimeCellValue }
  TppDateTimeCellValue = class(TppCellValue)
    private
      FValue: TDateTime;
      FSum: TDateTime;
      FCount: Integer;

    public
      constructor Create;

      function  DataType: TppDataType; override;
      function  GetValue: Variant; override;
      procedure SetValue(aValue: Variant); override;

      {averages only}
      function  GetCount: Integer; override;
      function  GetSum: Variant; override;
      procedure SetCount(aValue: Variant); override;
      procedure SetSum(aValue: Variant); override;

  end; {class, TppDateTimeCellValue}

  {@TppCurrencyCellValue }
  TppCurrencyCellValue = class(TppCellValue)
    private
      FValue: Currency;
      FSum: Currency;
      FCount: Integer;

    public
      constructor Create;

      function  DataType: TppDataType; override;
      function  GetValue: Variant; override;
      procedure SetValue(aValue: Variant); override;

      {averages only}
      function  GetCount: Integer; override;
      function  GetSum: Variant; override;
      procedure SetCount(aValue: Variant); override;
      procedure SetSum(aValue: Variant); override;

  end; {class, TppCurrencyCellValue}

  {@TppExtendedCellValue }
  TppExtendedCellValue = class(TppCellValue)
    private
      FValue: Extended;
      FSum: Extended;
      FCount: Integer;

    public
      constructor Create;

      function  DataType: TppDataType; override;
      function  GetValue: Variant; override;
      procedure SetValue(aValue: Variant); override;

      {averages only}
      function  GetCount: Integer; override;
      function  GetSum: Variant; override;
      procedure SetCount(aValue: Variant); override;
      procedure SetSum(aValue: Variant); override;

  end; {class, TppExtendedCellValue}

  {@TppBooleanCellValue }
  TppBooleanCellValue = class(TppCellValue)
    private
      FValue: Boolean;
      FCount: Integer;

    public
      constructor Create;

      function  DataType: TppDataType; override;
      function  GetValue: Variant; override;
      procedure SetValue(aValue: Variant); override;

      {averages only}
      function  GetCount: Integer; override;
      function  GetSum: Variant; override;
      procedure SetCount(aValue: Variant); override;
      procedure SetSum(aValue: Variant); override;

  end; {class, TppBooleanCellValue}

{------------------------------------------------------------------------------}
{ ppDataTypesCompatible }

function ppDataTypesCompatible(aDataType1, aDataType2: TppDataType): Boolean;
const
  lcNumerics = [dtInteger, dtSingle, dtDouble, dtExtended, dtCurrency, dtLongint];
  lcDates = [dtDate, dtTime, dtDateTime];
begin

  if (aDataType1 = aDataType2) then
    Result := True

  else if (aDataType1 in lcNumerics) and (aDataType2 in lcNumerics) then
    Result := True

  else if (aDataType1 in lcDates) and (aDataType2 in lcDates) then
    Result := True

  else
    Result := False;
    
end; {function, ppDataTypesCompatible}


{------------------------------------------------------------------------------}
{ ppCreateCellForDataType }

function ppCreateCellForDataType(aDataType: TppDataType): TObject;
begin
  Result := nil;

  case aDataType of
    dtCurrency: Result := TppCurrencyCellValue.Create;
    dtInteger: Result := TppIntegerCellValue.Create;
    dtLongint: Result := TppLongintCellValue.Create;
    dtDate, dtTime, dtDateTime: Result := TppDateTimeCellValue.Create;
    dtSingle, dtDouble, dtExtended: Result := TppExtendedCellValue.Create;
    dtBoolean: Result := TppBooleanCellValue.Create;
    dtString: Result := TppStringCellValue.Create;
  end;
end; {function, ppCreateCellForDataType}

{------------------------------------------------------------------------------}
{ ppStringToCaption }

function ppStringToCaption(aValue: String): String;
begin
  if (Length(Trim(aValue)) = 0) then
    Result := ppLoadStr(68) {(blank)}
  else
    Result := aValue;
end; {function, ppStringToCaption}

{******************************************************************************
 *
 ** C O O R D I N A T E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCoordinate.Create }

constructor TppCoordinate.Create(aColumn, aRow: Integer);
begin

  inherited Create;

  FColumn := aColumn;
  FRow := aRow;

end; {constructor, Create}

{******************************************************************************
 *
 ** S U B T O T A L   C O O R D I N A T E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSubTotalCoordinate.Create }

constructor TppSubTotalCoordinate.Create(aColumn, aRow: Integer; aDefIndex: Integer);
begin

  inherited Create(aColumn, aRow);

  FDefIndex := aDefIndex;

end; {constructor, Create}

{******************************************************************************
 *
 ** M A T R I X
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppMatrix.Create }

constructor TppMatrix.Create;
begin

  inherited Create;

  FColumns := TList.Create;
  FColumnHeaderCount := 0;
  FRowHeaderCount := 0;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppMatrix.Destroy }

destructor TppMatrix.Destroy;
begin

  FreeCells;
  FreeColumns;

  FColumns.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppMatrix.FreeCells }

procedure TppMatrix.FreeCells;
var
  lRowList: TList;
  liRow: Integer;
  liColumn: Integer;
begin

  liColumn := 0;

  while (liColumn < ColumnCount) do
    begin

      lRowList := TList(FColumns[liColumn]);

      liRow := 0;

      while (liRow < RowCount) do
        begin
          TppCellValue(lRowList[liRow]).Free;

          Inc(liRow);
        end;

      Inc(liColumn);
    end;

end; {procedure, FreeCells}

{------------------------------------------------------------------------------}
{ TppMatrix.FreeColumns }

procedure TppMatrix.FreeColumns;
var
  liIndex: Integer;

begin
  for liIndex := 0 to FColumns.Count-1 do
    TObject(FColumns[liIndex]).Free;

  FColumns.Clear;

end;  {procedure, FreeColumns}

{------------------------------------------------------------------------------}
{ TppMatrix.GetCaptionHeight }

function TppMatrix.GetCaptionHeight(aColumn, aRow: Integer): Integer;
var
  lRowList: TList;
  lCell: TppCellValue;
begin

  lRowList := TList(FColumns[aColumn]);

  lCell := TppCellValue(lRowList[aRow]);

  if (lCell is TppStringCellValue) then
    Result := TppStringCellValue(lRowList[aRow]).Height
  else
    Result := 0;

end; {function, GetCaptionHeight}

{------------------------------------------------------------------------------}
{ TppMatrix.GetCaptionWidth }

function TppMatrix.GetCaptionWidth(aColumn, aRow: Integer): Integer;
var
  lRowList: TList;
  lCell: TppCellValue;
begin

  lRowList := TList(FColumns[aColumn]);

  if (aRow > lRowList.Count - 1) then
    aRow :=  lRowList.Count - 1;
    
  lCell := TppCellValue(lRowList[aRow]);

  if (lCell is TppStringCellValue) then
    Result := TppStringCellValue(lRowList[aRow]).Width
  else
    Result := 0;

end; {function, GetCaptionWidth}

{------------------------------------------------------------------------------}
{ TppMatrix.GetCaptionVisible }

function TppMatrix.GetCaptionVisible(aColumn, aRow: Integer): Boolean;
var
  lRowList: TList;
  lCell: TppCellValue;
begin

  lRowList := TList(FColumns[aColumn]);

  lCell := TppCellValue(lRowList[aRow]);

  if (lCell is TppStringCellValue) then
    Result := TppStringCellValue(lRowList[aRow]).CaptionVisible
  else
    Result := False;

end; {function, GetCaptionVisible}

{------------------------------------------------------------------------------}
{ TppMatrix.GetBorders }

function TppMatrix.GetBorders(aColumn, aRow: Integer; aBorderType: TppBorderType): Boolean;
var
  lRowList: TList;
  lCell: TppCellValue;
begin

  lRowList := TList(FColumns[aColumn]);

  lCell := TppCellValue(lRowList[aRow]);

  if (lCell is TppStringCellValue) then
    Result := TppStringCellValue(lCell).Borders[aBorderType]
  else
    Result := False;

end; {function, GetBorders}

{------------------------------------------------------------------------------}
{ TppMatrix.GetDataType }

function TppMatrix.GetDataType(aColumn, aRow: Integer): TppDataType;
var
  lRowList: TList;
begin

  lRowList := TList(FColumns[aColumn]);

  Result := TppCellValue(lRowList[aRow]).DataType;

end; {function, GetDataType}

{------------------------------------------------------------------------------}
{ TppMatrix.GetDefCaption }

function TppMatrix.GetDefCaption(aColumn, aRow: Integer): String;
var
  lRowList: TList;
  lCell: TppCellValue;
begin

  Result := '';

  lRowList := TList(FColumns[aColumn]);

  lCell := TppCellValue(lRowList[aRow]);

  if (lCell is TppTotalLabel) then
    Result := TppTotalLabel(lCell).DefCaption;

end; {function, GetDefCaption}

{------------------------------------------------------------------------------}
{ TppMatrix.GetDefIndex }

function TppMatrix.GetDefIndex(aColumn, aRow: Integer): Integer;
var
  lRowList: TList;
  lCell: TppCellValue;
begin

  Result := -1;

  lRowList := TList(FColumns[aColumn]);

  lCell := TppCellValue(lRowList[aRow]);

  if (lCell is TppTotalLabel) then
    Result := TppTotalLabel(lCell).DefIndex;

end; {function, GetDefIndex}

{------------------------------------------------------------------------------}
{ TppMatrix.GetValueDefIndex }

function TppMatrix.GetValueDefIndex(aColumn, aRow: Integer): Integer;
var
  lRowList: TList;
  lCell: TppCellValue;
begin

  Result := -1;

  lRowList := TList(FColumns[aColumn]);

  lCell := TppCellValue(lRowList[aRow]);

  if (lCell is TppTotalLabel) then
    Result := TppTotalLabel(lCell).ValueDefIndex;

end; {function, GetValueDefIndex}

{------------------------------------------------------------------------------}
{ TppMatrix.GetValueDefCaption }

function TppMatrix.GetValueDefCaption(aColumn, aRow: Integer): String;
var
  lRowList: TList;
  lCell: TppCellValue;
begin

  Result := '';

  lRowList := TList(FColumns[aColumn]);

  lCell := TppCellValue(lRowList[aRow]);

  if (lCell is TppTotalLabel) then
    Result := TppTotalLabel(lCell).ValueDefCaption;

end; {function, GetValueDefCaption}


{@TppMatrix.IsTotalColumn
 Determines whether or not the given column is used for a subtotal or grand
 total.}

function TppMatrix.IsTotalColumn(aColumn: Integer): Boolean;
var
  lRowList: TList;
  lCell: TppCellValue;
  liRow: Integer;
begin

  lRowList := TList(FColumns[aColumn]);

  liRow := ColumnHeaderCount - 1;

  lCell := TppCellValue(lRowList[liRow]);

  Result := (lCell is TppTotalLabel);

end; {function, IsTotalColumn}


{@TppMatrix.FirstDataColumn
 Given a column, locates the first column that contains value calculations (as
 opposed to Totals).}

function TppMatrix.FirstDataColumn(aColumn: Integer): Integer;
begin

  while (aColumn < ColumnCount) and (IsTotalColumn(aColumn)) do
    Inc(aColumn);

  Result := aColumn;
  
end; {function, FirstDataColumn}


{@TppMatrix.FirstLabelRowOfColumnTotal
 Returns first subtotal label row of a column subtotal. Used by renderer when
 formatting nested subtotals.}

function TppMatrix.FirstLabelRowOfColumnTotal(aColumn: Integer): Integer;
var
  lRowList: TList;
  lCell: TppCellValue;
  liRow: Integer;
begin

  Result := -1;

  lRowList := TList(FColumns[aColumn]);

  liRow := 0;

  while (liRow < ColumnHeaderCount) and (Result = -1) do
    begin
      lCell := TppCellValue(lRowList[liRow]);

      if (lCell is TppTotalLabel) then
        Result := liRow
      else
        Inc(liRow);
    end;

end; {function, FirstLabelRowOfColumnTotal}


{@TppMatrix.IsTotalRow
 Determines whether or not the given row is used for a subtotal or grand total.}

function TppMatrix.IsTotalRow(aRow: Integer): Boolean;
var
  lRowList: TList;
  lCell: TppCellValue;
  liColumn: Integer;
begin

  Result := False;

  if (RowHeaderCount = 0) then Exit;

  liColumn := RowHeaderCount - 1;

  lRowList := TList(FColumns[liColumn]);

  lCell := TppCellValue(lRowList[aRow]);

  Result := (lCell is TppTotalLabel);

end; {function, IsTotalRow}


{@TppMatrix.FirstLabelColumnOfRowTotal
 Returns first subtotal label column of a row subtotal. Used by renderer when
 formatting nested subtotals.}

function TppMatrix.FirstLabelColumnOfRowTotal(aRow: Integer): Integer;
var
  lRowList: TList;
  lCell: TppCellValue;
  liColumn: Integer;
begin

  Result := -1;

  liColumn := 0;

  while (liColumn < RowHeaderCount) and (Result = -1) do
    begin
      lRowList := TList(FColumns[liColumn]);

      lCell := TppCellValue(lRowList[aRow]);

      if (lCell is TppTotalLabel) then
        Result := liColumn
      else
        Inc(liColumn);
    end;

end; {function, FirstLabelColumnOfRowTotal}

{------------------------------------------------------------------------------}
{ TppMatrix.GetValue }

function TppMatrix.GetValue(aColumn, aRow: Integer): Variant;
var
  lRowList: TList;
begin

  lRowList := TList(FColumns[aColumn]);

  Result := TppCellValue(lRowList[aRow]).GetValue;

end; {function, GetValue}

{------------------------------------------------------------------------------}
{ TppMatrix.GetSum }

function TppMatrix.GetSum(aColumn, aRow: Integer): Variant;
var
  lRowList: TList;
begin

  lRowList := TList(FColumns[aColumn]);

  Result := TppCellValue(lRowList[aRow]).GetSum;

end; {function, GetSum}

{------------------------------------------------------------------------------}
{ TppMatrix.GetCount }

function TppMatrix.GetCount(aColumn, aRow: Integer): Integer;
var
  lRowList: TList;
begin

  lRowList := TList(FColumns[aColumn]);

  Result := TppCellValue(lRowList[aRow]).GetCount;

end; {function, GetCount}

{------------------------------------------------------------------------------}
{ TppMatrix.GetElementIndex }

function TppMatrix.GetElementIndex(aColumn, aRow: Integer): Integer;
var
  lRowList: TList;
begin

  lRowList := TList(FColumns[aColumn]);

  Result := TppCellValue(lRowList[aRow]).ElementIndex;

end; {function, GetElementIndex}

{------------------------------------------------------------------------------}
{ TppMatrix.SetElementIndex }

procedure TppMatrix.SetElementIndex(aColumn, aRow: Integer; aElementIndex: Integer);
var
  lRowList: TList;
begin

  lRowList := TList(FColumns[aColumn]);

  TppCellValue(lRowList[aRow]).ElementIndex := aElementIndex;

end; {procedure, SetElementIndex}

{------------------------------------------------------------------------------}
{ TppMatrix.GetIsCaption }

function TppMatrix.GetIsCaption(aColumn, aRow: Integer): Boolean;
begin
  Result := (aColumn < FRowHeaderCount) or (aRow < FColumnHeaderCount);
end; {procedure, GetIsCaption}

{------------------------------------------------------------------------------}
{ TppMatrix.GetIsEmpty }

function TppMatrix.GetIsEmpty(aColumn, aRow: Integer): Boolean;
var
  lRowList: TList;
begin

  lRowList := TList(FColumns[aColumn]);

  Result := TppCellValue(lRowList[aRow]).IsEmpty;

end; {procedure, GetIsEmpty}

{------------------------------------------------------------------------------}
{ TppMatrix.GetIsNull }

function TppMatrix.GetIsNull(aColumn, aRow: Integer): Boolean;
var
  lRowList: TList;
begin

  lRowList := TList(FColumns[aColumn]);

  Result := TppCellValue(lRowList[aRow]).IsNull;

end; {procedure, GetIsNull}

{------------------------------------------------------------------------------}
{ TppMatrix.SetIsNull }

procedure TppMatrix.SetIsNull(aColumn, aRow: Integer; aValue: Boolean);
var
  lRowList: TList;
begin

  lRowList := TList(FColumns[aColumn]);

  TppCellValue(lRowList[aRow]).IsNull := aValue;

end; {procedure, SetIsNull}

{------------------------------------------------------------------------------}
{ TppMatrix.SetDefIndex }

procedure TppMatrix.SetDefIndex(aColumn, aRow: Integer; aDefIndex: Integer);
var
  lRowList: TList;
  lCell: TppCellValue;
begin

  lRowList := TList(FColumns[aColumn]);

  lCell := TppCellValue(lRowList[aRow]);

  if (lCell is TppTotalLabel) then
    TppTotalLabel(lCell).SetDefIndex(aDefIndex);

end; {procedure, SetDefIndex}

{------------------------------------------------------------------------------}
{ TppMatrix.SetValue }

procedure TppMatrix.SetValue(aColumn, aRow: Integer; aValue: Variant);
var
  lRowList: TList;
begin

  lRowList := TList(FColumns[aColumn]);

  TppCellValue(lRowList[aRow]).SetValue(aValue);

end; {procedure, SetValue}

{------------------------------------------------------------------------------}
{ TppMatrix.SetSum }

procedure TppMatrix.SetSum(aColumn, aRow: Integer; aValue: Variant);
var
  lRowList: TList;
begin

  lRowList := TList(FColumns[aColumn]);

  TppCellValue(lRowList[aRow]).SetSum(aValue);

end; {procedure, SetSum}

{------------------------------------------------------------------------------}
{ TppMatrix.SetCaptionHeight }

procedure TppMatrix.SetCaptionHeight(aColumn, aRow: Integer; aValue: Integer);
var
  lRowList: TList;
  lCell: TppCellValue;
begin

  lRowList := TList(FColumns[aColumn]);

  lCell := TppCellValue(lRowList[aRow]);

  if (lCell is TppStringCellValue) then
    TppStringCellValue(lRowList[aRow]).Height := aValue;

end; {procedure, SetCaptionHeight}

{------------------------------------------------------------------------------}
{ TppMatrix.SetCaptionWidth }

procedure TppMatrix.SetCaptionWidth(aColumn, aRow: Integer; aValue: Integer);
var
  lRowList: TList;
  lCell: TppCellValue;
begin

  lRowList := TList(FColumns[aColumn]);

  lCell := TppCellValue(lRowList[aRow]);

  if (lCell is TppStringCellValue) then
    TppStringCellValue(lRowList[aRow]).Width := aValue;

end; {procedure, SetCaptionWidth}

{------------------------------------------------------------------------------}
{ TppMatrix.SetCaptionVisible }

procedure TppMatrix.SetCaptionVisible(aColumn, aRow: Integer; aValue: Boolean);
var
  lRowList: TList;
  lCell: TppCellValue;
begin

  lRowList := TList(FColumns[aColumn]);

  lCell := TppCellValue(lRowList[aRow]);

  if (lCell is TppStringCellValue) then
    TppStringCellValue(lRowList[aRow]).CaptionVisible := aValue;

end; {procedure, SetCaptionVisible}

{------------------------------------------------------------------------------}
{ TppMatrix.SetBorders }

procedure TppMatrix.SetBorders(aColumn, aRow: Integer; aBorderType: TppBorderType; aValue: Boolean);
var
  lRowList: TList;
  lCell: TppCellValue;
begin

  lRowList := TList(FColumns[aColumn]);

  lCell := TppCellValue(lRowList[aRow]);

  if (lCell is TppStringCellValue) then
    TppStringCellValue(lRowList[aRow]).Borders[aBorderType] := aValue;

end; {procedure, SetBorders}

{------------------------------------------------------------------------------}
{ TppMatrix.SetCount }

procedure TppMatrix.SetCount(aColumn, aRow: Integer; aValue: Integer);
var
  lRowList: TList;
begin

  lRowList := TList(FColumns[aColumn]);

  TppCellValue(lRowList[aRow]).SetCount(aValue);

end; {procedure, SetCount}

{------------------------------------------------------------------------------}
{ TppMatrix.GetColumnCount }

function  TppMatrix.GetColumnCount: Integer;
begin
  Result := FColumns.Count;
end; {function, GetColumnCount}

{------------------------------------------------------------------------------}
{ TppMatrix.GetRowCount }

function  TppMatrix.GetRowCount: Integer;
begin
  if (FColumns.Count > 0) then
    Result := TList(FColumns[0]).Count
  else
    Result := 0;
end; {function, GetRowCount}


{@TppMatrix.AppendRows
 Adds new rows onto matrix.}

procedure TppMatrix.AppendRows(aRowCount: Integer; aValueDataType: TppDataType);
var
  lCell: TppCellValue;
  lColumnList: TList;
  liColumn: Integer;
  liRow: Integer;
  liRowCount: Integer;
begin

  if (ColumnCount = 0) then
    begin
      AppendColumns(RowHeaderCount + 1, aValueDataType);

      aRowCount := aRowCount - RowCount;
    end;

  liColumn := 0;
  liRowCount := RowCount;

  while (liColumn < ColumnCount) do
    begin

      lColumnList := TList(FColumns[liColumn]);

      liRow := 0;

      while (liRow < aRowCount) do
        begin
          lCell := TppCellValue(CreateRowCell(liColumn, liRow + liRowCount, aValueDataType));

          lColumnList.Add(lCell);

          Inc(liRow);
        end;

      Inc(liColumn);
    end;

end; {procedure, AppendRows}


{@TppMatrix.AppendColumns
 Adds new columns onto matrix.}

procedure TppMatrix.AppendColumns(aColumnCount: Integer; aValueDataType: TppDataType);
var
  lCell: TppCellValue;
  lColumnList: TList;
  liRows: Integer;
  liRow: Integer;
  liColumn: Integer;
  liColumnCount: Integer;
begin

  if (ColumnCount > 0) then
    liRows := RowCount
  else
    liRows := ColumnHeaderCount + 1;

  liColumn := 0;
  liColumnCount := ColumnCount;

  while (liColumn < aColumnCount) do
    begin

      lColumnList := TList.Create;

      FColumns.Add(lColumnList);

      liRow := 0;

      while (liRow < liRows) do
        begin
          lCell := TppCellValue(CreateColumnCell(liColumn + liColumnCount, liRow, aValueDataType));

          lColumnList.Add(lCell);

          Inc(liRow);
        end;

      Inc(liColumn);
    end;

end; {procedure, AppendColumns}

{------------------------------------------------------------------------------}
{ TppMatrix.CreateRowCell }

function TppMatrix.CreateRowCell(aColumn, aRow: Integer; aValueDataType: TppDataType): TObject;
begin

  if HeaderCell(aColumn, aRow) then
    Result := TppStringCellValue.Create
  else
    Result := ppCreateCellForDataType(aValueDataType);

end; {procedure, CreateRowCell}

{------------------------------------------------------------------------------}
{ TppMatrix.CreateColumnCell }

function TppMatrix.CreateColumnCell(aColumn, aRow: Integer; aValueDataType: TppDataType): TObject;
var
  lValueDataType: TppDataType;
  liCopyColumn: Integer;
begin

  if HeaderCell(aColumn, aRow) then
    Result := TppStringCellValue.Create
  else
    begin
      liCopyColumn := GetCopyColumn(aColumn);

      if (liCopyColumn <> -1) then
        lValueDataType := DataType[liCopyColumn, aRow]
      else
        lValueDataType := aValueDataType;

      Result := ppCreateCellForDataType(lValueDataType);

      if (liCopyColumn <> -1) then
        TppCellValue(Result).ElementIndex := ElementIndex[liCopyColumn, aRow];
    end;

end; {procedure, CreateColumnCell}

{------------------------------------------------------------------------------}
{ TppMatrix.GetCopyColumn }

function TppMatrix.GetCopyColumn(aColumn: Integer): Integer;
begin
  Result := -1;

  if (ColumnCount = FRowHeaderCount) then Exit;

  Result := FRowHeaderCount;

  if (Result = aColumn) then
    Inc(Result);

  if (Result = ColumnCount) then
    Result := -1;
end; {procedure, GetCopyColumn}

{------------------------------------------------------------------------------}
{ TppMatrix.HeaderCell }

function TppMatrix.HeaderCell(aColumn, aRow: Integer): Boolean;
begin
  Result := (aRow < FColumnHeaderCount) or (aColumn < FRowHeaderCount);
end; {function, HeaderCell}


{@TppMatrix.InsertTotalRow
 Inserts a row for use by a row subtotal or grand total.}

procedure TppMatrix.InsertTotalRow(aRow, aRowDef, aValueDef: Integer; aValueDataType: TppDataType;
                                   aRowDefValue: Variant; const aRowDefCaption, aValueDefCaption: String;
                                   aIsSubTotal: Boolean);
var
  liColumn: Integer;
  lRowList: TList;
  lTotal: TppTotalLabel;
  liStartColumn: Integer;
begin

  InsertRows(aRow, 1, aValueDataType);

  if aIsSubTotal then
    liStartColumn := aRowDef
  else
    liStartColumn := 0;

  for liColumn := liStartColumn to FRowHeaderCount - 1 do
    begin
      lRowList := TList(FColumns[liColumn]);

      TppCellValue(lRowList[aRow]).Free;

      lRowList.Delete(aRow);

      lTotal := TppTotalLabel.Create;

      lTotal.SetValue(aRowDefValue);

      lTotal.SetDefCaption(aRowDefCaption);
      lTotal.SetDefIndex(aRowDef);
      lTotal.SetValueDefIndex(aValueDef);
      lTotal.SetValueDefCaption(aValueDefCaption);

      lRowList.Insert(aRow, lTotal);
    end;

end; {function, InsertTotalRow}


{@TppMatrix.InsertTotalColumn
 Inserts a column for use by column subtotal or grand total.}

procedure TppMatrix.InsertTotalColumn(aColumn, aColumnDef: Integer; aValueDataType: TppDataType;
                                      aColumnDefValue: Variant; const aColumnDefCaption: String;
                                      aIsSubTotal: Boolean);
var
  liRow: Integer;
  liStartRow: Integer;
  lRowList: TList;
  lTotal: TppTotalLabel;
begin

  InsertColumns(aColumn, 1, aValueDataType);

  if aIsSubTotal then
    liStartRow := aColumnDef
  else
    liStartRow := 0;

  lRowList := TList(FColumns[aColumn]);

  for liRow := liStartRow to FColumnHeaderCount - 1 do
    begin
      TppCellValue(lRowList[liRow]).Free;

      lRowList.Delete(liRow);

      lTotal := TppTotalLabel.Create;

      lTotal.SetValue(aColumnDefValue);

      lTotal.SetDefCaption(aColumnDefCaption);
      lTotal.SetDefIndex(aColumnDef);

      lRowList.Insert(liRow, lTotal);
    end;

end; {function, InsertTotalColumn}


{@TppMatrix.InsertRows
 Inserts a new row into the matrix.  Row must be used for values, not totals.}

procedure TppMatrix.InsertRows(aRow, aRowCount: Integer; aValueDataType: TppDataType);
var
  lCell: TppCellValue;
  lColumnList: TList;
  liColumn: Integer;
  liColumns: Integer;
  liRow: Integer;
begin

  if (ColumnCount > 0) then
    liColumns := ColumnCount
  else
    liColumns := RowHeaderCount + 1;

  liColumn := 0;

  while (liColumn < liColumns) do
    begin

      if (liColumn = FColumns.Count) then
        begin
          lColumnList := TList.Create;

          FColumns.Add(lColumnList);
        end
      else
        lColumnList := TList(FColumns[liColumn]);

      liRow := 0;

      while (liRow < aRowCount) do
        begin
          lCell := TppCellValue(CreateRowCell(liColumn, aRow, aValueDataType));

          lColumnList.Insert(aRow, lCell);

          Inc(liRow);
        end;

      Inc(liColumn);
    end;

end; {procedure, InsertRows}


{@TppMatrix.InsertColumns
 Inserts a new column into the matrix.  Column must be used for values, not
 totals.}

procedure TppMatrix.InsertColumns(aColumn, aColumnCount: Integer; aValueDataType: TppDataType);
var
  lCell: TppCellValue;
  lColumnList: TList;
  liColumn: Integer;
  liRow: Integer;
  liRows: Integer;
begin

  if (ColumnCount > 0) then
    liRows := RowCount
  else
    liRows := ColumnHeaderCount + 1;

  liColumn := 0;

  while (liColumn < aColumnCount) do
    begin

      lColumnList := TList.Create;

      FColumns.Insert(aColumn, lColumnList);

      liRow := 0;

      while (liRow < liRows) do
        begin
          lCell := TppCellValue(CreateColumnCell(aColumn, liRow, aValueDataType));

          lColumnList.Add(lCell);

          Inc(liRow);
        end;

      Inc(liColumn);
    end;

end; {procedure, InsertColumns}


{@TppMatrix.DeleteColumns
 Deletes columns from matrix. Not called by engine or renderer.}

procedure TppMatrix.DeleteColumns(aStartColumn, aEndColumn: Integer);
var
  lColumnList: TList;
  liColumn: Integer;
  liRow: Integer;
begin

  liColumn := aStartColumn;

  while (liColumn <= aEndColumn) do
    begin

      lColumnList := TList(FColumns[aStartColumn]);

      liRow := 0;

      while (liRow < lColumnList.Count) do
        begin
          TppCellValue(lColumnList[liRow]).Free;

          Inc(liRow);
        end;

      FColumns.Delete(aStartColumn);
      lColumnList.Free;

      Inc(liColumn);
    end;

end; {procedure, DeleteColumns}


{@TppMatrix.DeleteRows
 Deletes rows from matrix. Not called by engine or renderer.}

procedure TppMatrix.DeleteRows(aStartRow, aEndRow: Integer);
var
  lColumnList: TList;
  liColumn: Integer;
  liRow: Integer;
begin

  liColumn := 0;

  while (liColumn < ColumnCount) do
    begin

      lColumnList := TList(FColumns[liColumn]);

      liRow := aStartRow;

      while (liRow <= aEndRow) do
        begin
          TppCellValue(lColumnList[aStartRow]).Free;

          lColumnList.Delete(aStartRow);

          Inc(liRow);
        end;

      if (lColumnList.Count = 0) then
        DeleteColumns(liColumn, liColumn)
      else
        Inc(liColumn);
    end;

end; {procedure, DeleteRows}

{------------------------------------------------------------------------------}
{ TppCellValue.Create }

constructor TppCellValue.Create;
begin

  inherited Create;

  FElementIndex := -1;
  FIsEmpty := True;
  FIsNull := True;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCellValue.SetValue }

procedure TppCellValue.SetValue(aValue: Variant);
begin

  if VarType(aValue) = varNull then
    FIsNull := True
  else
    FIsNull := False;

  FIsEmpty := False;

end; {procedure, SetValue}

{******************************************************************************
 *
 ** L O N G I N T   C E L L   V A L U E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppLongintCellValue.Create }

constructor TppLongintCellValue.Create;
begin

  inherited Create;

  FValue := 0;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppLongintCellValue.DataType }

function TppLongintCellValue.DataType: TppDataType;
begin
  Result := dtLongint;
end; {function, DataType}

{------------------------------------------------------------------------------}
{ TppLongintCellValue.GetValue }

function TppLongintCellValue.GetValue: Variant;
begin
  Result := FValue;
end; {function, GetValue}

{------------------------------------------------------------------------------}
{ TppLongintCellValue.SetValue }

procedure TppLongintCellValue.SetValue(aValue: Variant);
begin
  inherited SetValue(aValue);

  if not(FIsNull) then
    FValue := aValue;
end; {function, SetValue}

{------------------------------------------------------------------------------}
{ TppLongintCellValue.GetCount }

function TppLongintCellValue.GetCount: Integer;
begin
  Result := FCount;
end; {function, GetCount}

{------------------------------------------------------------------------------}
{ TppLongintCellValue.GetSum }

function TppLongintCellValue.GetSum: Variant;
begin
  Result := FSum;
end; {function, GetSum}

{------------------------------------------------------------------------------}
{ TppLongintCellValue.SetCount }

procedure TppLongintCellValue.SetCount(aValue: Variant);
begin
  FCount := aValue;
end; {procedure, SetCount}

{------------------------------------------------------------------------------}
{ TppLongintCellValue.SetSum }

procedure TppLongintCellValue.SetSum(aValue: Variant);
begin
  FSum := aValue;
end; {procedure, SetSum}

{******************************************************************************
 *
 ** D A T E T I M E   C E L L   V A L U E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDateTimeCellValue.Create }

constructor TppDateTimeCellValue.Create;
begin

  inherited Create;

  FValue := 0;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDateTimeCellValue.DataType }

function TppDateTimeCellValue.DataType: TppDataType;
begin
  Result := dtDateTime;
end; {function, DataType}

{------------------------------------------------------------------------------}
{ TppDateTimeCellValue.GetValue }

function TppDateTimeCellValue.GetValue: Variant;
begin
  Result := FValue;
end; {function, GetValue}

{------------------------------------------------------------------------------}
{ TppDateTimeCellValue.SetValue }

procedure TppDateTimeCellValue.SetValue(aValue: Variant);
begin
  inherited SetValue(aValue);

  if not(FIsNull) then
    FValue := aValue;
end; {function, SetValue}

{------------------------------------------------------------------------------}
{ TppDateTimeCellValue.GetCount }

function TppDateTimeCellValue.GetCount: Integer;
begin
  Result := FCount;
end; {function, GetCount}

{------------------------------------------------------------------------------}
{ TppDateTimeCellValue.GetSum }

function TppDateTimeCellValue.GetSum: Variant;
begin
  Result := FSum;
end; {function, GetSum}

{------------------------------------------------------------------------------}
{ TppDateTimeCellValue.SetCount }

procedure TppDateTimeCellValue.SetCount(aValue: Variant);
begin
  FCount := aValue;
end; {procedure, SetCount}

{------------------------------------------------------------------------------}
{ TppDateTimeCellValue.SetSum }

procedure TppDateTimeCellValue.SetSum(aValue: Variant);
begin
  FSum := aValue;
end; {procedure, SetSum}

{******************************************************************************
 *
 ** E X T E N D E D   C E L L   V A L U E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppExtendedCellValue.Create }

constructor TppExtendedCellValue.Create;
begin

  inherited Create;

  FValue := 0;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppExtendedCellValue.DataType }

function TppExtendedCellValue.DataType: TppDataType;
begin
  Result := dtExtended;
end; {function, DataType}

{------------------------------------------------------------------------------}
{ TppExtendedCellValue.GetValue }

function TppExtendedCellValue.GetValue: Variant;
begin
  Result := FValue;
end; {function, GetValue}

{------------------------------------------------------------------------------}
{ TppExtendedCellValue.SetValue }

procedure TppExtendedCellValue.SetValue(aValue: Variant);
begin
  inherited SetValue(aValue);

  if not(FIsNull) then
    FValue := aValue;
end; {function, SetValue}

{------------------------------------------------------------------------------}
{ TppExtendedCellValue.GetCount }

function TppExtendedCellValue.GetCount: Integer;
begin
  Result := FCount;
end; {function, GetCount}

{------------------------------------------------------------------------------}
{ TppExtendedCellValue.GetSum }

function TppExtendedCellValue.GetSum: Variant;
begin
  Result := FSum;
end; {function, GetSum}

{------------------------------------------------------------------------------}
{ TppExtendedCellValue.SetCount }

procedure TppExtendedCellValue.SetCount(aValue: Variant);
begin
  FCount := aValue;
end; {procedure, SetCount}

{------------------------------------------------------------------------------}
{ TppExtendedCellValue.SetSum }

procedure TppExtendedCellValue.SetSum(aValue: Variant);
begin
  FSum := aValue;
end; {procedure, SetSum}

{******************************************************************************
 *
 ** I N T E G E R   C E L L   V A L U E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppIntegerCellValue.Create }

constructor TppIntegerCellValue.Create;
begin

  inherited Create;

  FValue := 0;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppIntegerCellValue.DataType }

function TppIntegerCellValue.DataType: TppDataType;
begin
  Result := dtInteger;
end; {function, DataType}

{------------------------------------------------------------------------------}
{ TppIntegerCellValue.GetValue }

function TppIntegerCellValue.GetValue: Variant;
begin
  Result := FValue;
end; {function, GetValue}

{------------------------------------------------------------------------------}
{ TppIntegerCellValue.SetValue }

procedure TppIntegerCellValue.SetValue(aValue: Variant);
begin
  inherited SetValue(aValue);

  if not(FIsNull) then
    FValue := aValue;
end; {function, SetValue}

{------------------------------------------------------------------------------}
{ TppIntegerCellValue.GetCount }

function TppIntegerCellValue.GetCount: Integer;
begin
  Result := FCount;
end; {function, GetCount}

{------------------------------------------------------------------------------}
{ TppIntegerCellValue.GetSum }

function TppIntegerCellValue.GetSum: Variant;
begin
  Result := FSum;
end; {function, GetSum}

{------------------------------------------------------------------------------}
{ TppIntegerCellValue.SetCount }

procedure TppIntegerCellValue.SetCount(aValue: Variant);
begin
  FCount := aValue;
end; {procedure, SetCount}

{------------------------------------------------------------------------------}
{ TppIntegerCellValue.SetSum }

procedure TppIntegerCellValue.SetSum(aValue: Variant);
begin
  FSum := aValue;
end; {procedure, SetSum}

{******************************************************************************
 *
 ** C U R R E N C Y   C E L L   V A L U E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCurrencyCellValue.Create }

constructor TppCurrencyCellValue.Create;
begin

  inherited Create;

  FValue := 0;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCurrencyCellValue.DataType }

function TppCurrencyCellValue.DataType: TppDataType;
begin
  Result := dtCurrency;
end; {function, DataType}

{------------------------------------------------------------------------------}
{ TppCurrencyCellValue.GetValue }

function TppCurrencyCellValue.GetValue: Variant;
begin
  Result := FValue;
end; {function, GetValue}

{------------------------------------------------------------------------------}
{ TppCurrencyCellValue.SetValue }

procedure TppCurrencyCellValue.SetValue(aValue: Variant);
begin
  inherited SetValue(aValue);

  if not(FIsNull) then
    FValue := aValue;
end; {function, SetValue}

{------------------------------------------------------------------------------}
{ TppCurrencyCellValue.GetCount }

function TppCurrencyCellValue.GetCount: Integer;
begin
  Result := FCount;
end; {function, GetCount}

{------------------------------------------------------------------------------}
{ TppCurrencyCellValue.GetSum }

function TppCurrencyCellValue.GetSum: Variant;
begin
  Result := FSum;
end; {function, GetSum}

{------------------------------------------------------------------------------}
{ TppCurrencyCellValue.SetCount }

procedure TppCurrencyCellValue.SetCount(aValue: Variant);
begin
  FCount := aValue;
end; {procedure, SetCount}

{------------------------------------------------------------------------------}
{ TppCurrencyCellValue.SetSum }

procedure TppCurrencyCellValue.SetSum(aValue: Variant);
begin
  FSum := aValue;
end; {procedure, SetSum}

{******************************************************************************
 *
 ** S T R I N G   C E L L   V A L U E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppStringCellValue.Create }

constructor TppStringCellValue.Create;
begin

  inherited Create;

  FCaptionVisible := True;
  FDataValue := nil;
  FBorders[Ord(btLeft)]   := True;
  FBorders[Ord(btTop)]    := True;
  FBorders[Ord(btRight)]  := True;
  FBorders[Ord(btBottom)] := True;
  FHeight := 0;
  FCaption := '';
  FWidth := 0;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppStringCellValue.Destroy }

destructor TppStringCellValue.Destroy;
begin

  FDataValue.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppStringCellValue.DataType }

function TppStringCellValue.DataType: TppDataType;
begin
  if (FDataValue = nil) then
    Result := dtString
  else
    Result := FDataValue.DataType;
end; {function, DataType}

{------------------------------------------------------------------------------}
{ TppStringCellValue.GetValue }

function TppStringCellValue.GetValue: Variant;
begin

  if (IsEmpty) then
    Result := ''

  else if (Length(FCaption) > 0) then
    Result := FCaption

  {else if (FDataValue = nil) then
    Result := ppStringToCaption(FCaption)}

  else if (FDataValue = nil) then
    Result := Null

  else
    Result := FDataValue.GetValue;
    
end; {function, GetValue}

{------------------------------------------------------------------------------}
{ TppStringCellValue.SetValue }

procedure TppStringCellValue.SetValue(aValue: Variant);
var
  lDataType: TppDataType;
begin

  inherited SetValue(aValue);

  FDataValue.Free;
  FDataValue := nil;

  if (FIsNull) then Exit;

  if ppVariantIsString(aValue) then
    begin
      FCaption := aValue;
      FDataValue := nil;
    end
  else
    begin
      lDataType := ppVariantTypeToDataType(VarType(aValue));

      FDataValue := TppCellValue(ppCreateCellForDataType(lDataType));

      if (FDataValue <> nil) then
        FDataValue.SetValue(aValue);
    end;

end; {function, SetValue}

{------------------------------------------------------------------------------}
{ TppStringCellValue.GetBorders }

function TppStringCellValue.GetBorders(aBorderType: TppBorderType): Boolean;
begin
  Result := FBorders[Ord(aBorderType)];
end; {function, GetBorders}

{------------------------------------------------------------------------------}
{ TppStringCellValue.SetBorders }

procedure TppStringCellValue.SetBorders(aBorderType: TppBorderType; aValue: Boolean);
begin
  FBorders[Ord(aBorderType)] := aValue;
end; {function, SetBorders}

{------------------------------------------------------------------------------}
{ TppStringCellValue.GetCount }

function TppStringCellValue.GetCount: Integer;
begin
  Result := 0;
end; {function, GetCount}

{------------------------------------------------------------------------------}
{ TppStringCellValue.GetSum }

function TppStringCellValue.GetSum: Variant;
begin
  Result := 0;
end; {function, GetSum}

{------------------------------------------------------------------------------}
{ TppStringCellValue.SetCount }

procedure TppStringCellValue.SetCount(aValue: Variant);
begin

end; {function, SetCount}

{------------------------------------------------------------------------------}
{ TppStringCellValue.SetSum }

procedure TppStringCellValue.SetSum(aValue: Variant);
begin

end; {function, SetSum}


{******************************************************************************
 *
 ** T O T A L   L A B E L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTotalLabel.Create }

constructor TppTotalLabel.Create;
begin

  inherited Create;

  FDefCaption := '';
  FDefIndex := -1;
  FValueDefIndex := -1;
  FValueDefCaption := '';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppTotalLabel.DefCaption }

function TppTotalLabel.DefCaption: String;
begin
  Result := FDefCaption;
end; {function, DefCaption}

{------------------------------------------------------------------------------}
{ TppTotalLabel.DefIndex }

function TppTotalLabel.DefIndex: Integer;
begin
  Result := FDefIndex;
end; {function, DefIndex}

{------------------------------------------------------------------------------}
{ TppTotalLabel.SetDefCaption }

procedure TppTotalLabel.SetDefCaption(aDefCaption: String);
begin
  FDefCaption := aDefCaption;
end; {procedure, SetDefCaption}

{------------------------------------------------------------------------------}
{ TppTotalLabel.SetDefIndex }

procedure TppTotalLabel.SetDefIndex(aDefIndex: Integer);
begin
  FDefIndex := aDefIndex;
end; {procedure, SetDefIndex}

{------------------------------------------------------------------------------}
{ TppTotalLabel.ValueDefIndex }

function TppTotalLabel.ValueDefIndex: Integer;
begin
  Result := FValueDefIndex;
end; {function, ValueDefIndex}

{------------------------------------------------------------------------------}
{ TppTotalLabel.SetValueDefIndex }

procedure TppTotalLabel.SetValueDefIndex(aValueDefIndex: Integer);
begin
  FValueDefIndex := aValueDefIndex;
end; {procedure, SetValueDefIndex}

{------------------------------------------------------------------------------}
{ TppTotalLabel.ValueDefCaption }

function TppTotalLabel.ValueDefCaption: String;
begin
  Result := FValueDefCaption;
end; {function, ValueDefCaption}

{------------------------------------------------------------------------------}
{ TppTotalLabel.SetValueDefCaption }

procedure TppTotalLabel.SetValueDefCaption(aCaption: String);
begin
  FValueDefCaption := aCaption;
end; {procedure, SetValueDefCaption}

{******************************************************************************
 *
 ** B O O L E A N   C E L L   V A L U E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBooleanCellValue.Create }

constructor TppBooleanCellValue.Create;
begin

  inherited Create;

  FValue := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppBooleanCellValue.DataType }

function TppBooleanCellValue.DataType: TppDataType;
begin
  Result := dtBoolean;
end; {function, DataType}

{------------------------------------------------------------------------------}
{ TppBooleanCellValue.GetValue }

function TppBooleanCellValue.GetValue: Variant;
begin
  Result := FValue;
end; {function, GetValue}

{------------------------------------------------------------------------------}
{ TppBooleanCellValue.SetValue }

procedure TppBooleanCellValue.SetValue(aValue: Variant);
begin
  inherited SetValue(aValue);

  if not(FIsNull) then
    FValue := aValue;
end; {function, SetValue}

{------------------------------------------------------------------------------}
{ TppBooleanCellValue.GetCount }

function TppBooleanCellValue.GetCount: Integer;
begin
  Result := FCount;
end; {function, GetCount}

{------------------------------------------------------------------------------}
{ TppBooleanCellValue.GetSum }

function TppBooleanCellValue.GetSum: Variant;
begin
  Result := False;
end; {function, GetSum}

{------------------------------------------------------------------------------}
{ TppBooleanCellValue.SetCount }

procedure TppBooleanCellValue.SetCount(aValue: Variant);
begin
  FCount := aValue;
end; {procedure, SetCount}

{------------------------------------------------------------------------------}
{ TppBooleanCellValue.SetSum }

procedure TppBooleanCellValue.SetSum(aValue: Variant);
begin

end; {procedure, SetSum}



end.
