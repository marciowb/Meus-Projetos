{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppXLSRecordBif;

interface

{$I ppIfDef.pas}

{

  XLSRecords

  XLSWriterGlobals
  XLSWriterWorksheet
  XLSWriterWorkbook

  XLSWorkbook
    GlobalStyles
    WorkSheets

  XLSWorkSheet
    RowBlocks
    Rows
     Cells
   MergedCells

  XLSRow
    Cells

  XLSDevice                        SpreadsheetModel        XLSWriter
    process Page.DrawCommands --->     Worksheets      --->  xls file

    - translate page to SpreadSheetModel and then Write Rows

}

uses
  Types,
  Forms,
  SysUtils,
  Classes,
  Graphics,


  ppTypes,
  ppUtils,
  ppCharacter,
  ppCollectionBase,
  ppFormatStyles,
  ppXLSWorkbook,
  ppPrintr;


type

{-------------------------------------------------------------------------------
  General Bif records

-------------------------------------------------------------------------------}

  TppBifHeaderRec = packed record
    Id: Word;
    DataSize: Word;
  end;

  TppBifStringRec = packed record
    Length: Word;
    Options: Byte;
//    Characters: TBytes;
  end;

  TppBifStringByteRec =  packed record
    Length: Byte;
    Options: Byte;
//    Characters: TBytes;
  end;


  TppBifRTFStringRec = packed record
    Length: Word;
    Options: Byte;
    FormatRunCount: Word;
//    Characters: TBytes;
//    FormatRuns: array of TppRTFFormatRun;

  end;

  TppBifRTFFormatRunRec = packed record
    CharIndex: Word;
    FontIndex: Word;
  end;

  TppBifCharsRec = packed record
    Compressed: Boolean;
    Bytes: TBytes;
    CharCount: Longword;
  end;

  TppBifWriterBase = class
  protected
    class function CalcStringByteDataSize(aCharsRec: TppBifCharsRec): Word;
    class function CalcStringDataSize(aCharsRec: TppBifCharsRec): Word;
    class function CompressBytes(aBytes: TBytes): TBytes;
{$IFDEF Unicode}
    class procedure CompressString(aString: string; var aCharsRec: TppBifCharsRec);
{$ELSE}
    class procedure CompressString(aString: WideString; var aCharsRec: TppBifCharsRec);
{$ENDIF}

    class procedure WriteHeader(aStream: TStream; aRecordId, aDataSize: Word);
    class procedure WriteString(aStream: TStream; aCharsRec: TppBifCharsRec); overload;
    class procedure WriteStringRichText(aStream: TStream; aCharsRec: TppBifCharsRec; aFormatRuns: TppStringFormatRuns); overload;
    class procedure WriteStringByte(aStream: TStream; aCharsRec: TppBifCharsRec);

  public

  end;

  TppBifBofRec =  packed record
    Version: Word;
    BofType: Word;
    BuildId: Word;
    BuildYear: Word;
    FileHistory: LongWord;
    LoVersion: LongWord;
  end;

  TppBifWriterBof = class(TppBifWriterBase)
  protected
    class procedure InitializeBofRec(var aBofRec: TppBifBofRec); virtual;
  public
    class procedure WriteBofWorkbookGlobals(aStream: TStream);
    class procedure WriteBofWorksheet(aStream: TStream);
  end;

  TppBifWriterEof = class(TppBifWriterBase)
  public
    class procedure Write(aStream: TStream);
  end;


{-------------------------------------------------------------------------------
  Workbook Global records

    - bof
    - window1
    - date mode
    - font table
    - format table
    - xf table
    - style table
    - palette
    - sheet table
    - sst
    - eof

-------------------------------------------------------------------------------}

  {Window1 }
  TppBifWindow1Rec =  packed record
    XPos: Word;
    YPos: Word;
    Width: Word;
    Height: Word;
    Options: Word;
    TabCurrent: Word;
    TabFirst: Word;
    TabsSelected: Word;
    TabRatio: Word;
  end;

  TppBifWriterWindowSettings = class(TppBifWriterBase)
  public
    class procedure Write(aStream: TStream);
  end;

  {DateMode }
  TppBifDateModeRec = packed record
    Mode: Word;
  end;

  TppBifWriterDateMode = class(TppBifWriterBase)
  public
    class procedure Write(aStream: TStream);
  end;

  {Font Table}
  TppBifFontRec =  packed record
    Height: Word;
    Options: Word;
    ColorIndex: Word;
    Weight: Word;
    Escapement: Word;
    Underline: Byte;
    Family: Byte;
    CharSet: Byte;
    Reserved: Byte;
//    Name: String;
  end;


  TppBifWriterFontTable = class(TppBifWriterBase)
  protected
    class procedure WriteFont(aStream: TStream; aFont: TFont; aFormatStyles: TppXLSFormatStyles);
  public
    class procedure Write(aStream: TStream; aFormatStyles: TppXLSFormatStyles);
  end;

  {Format Table }
  TppBifFormatRec = packed record
    FormatIndex: Word;
//    FormatString: String;
  end;

  TppBifWriterFormatTable = class(TppBifWriterBase)
  protected
    class procedure WriteFormat(aStream: TStream; aDisplayFormat: String; aFormatStyles: TppXLSFormatStyles);
  public
    class procedure Write(aStream: TStream; aFormatStyles: TppXLSFormatStyles);
  end;


  {XF Table }
  TppBifXFRec = packed record
    FontIndex: Word;
    FormatIndex: Word;
    CellOptions: Word;
    AlignmentOptions: Byte;
    RotateOptions: Byte;
    IndentOptions: Byte;
    UsedAttributes: Byte;
    Borderoptions1: Longword;
    BorderOptions2: Longword;
    FillPaletteOptions: Word;
  end;


  TppBifWriterXFTable = class(TppBifWriterBase)
  protected
    class function CalcBorderLineStyle(aBorder: TppBorder): Byte;
    class function CalcTextAlignment(aTextAlignment: TppTextAlignment): Byte;
    class procedure InitializeXFStyleRec(var aXFRecord: TppBifXFRec);
    class procedure WriteXF(aStream: TStream; aElementFormat: TppElementFormat; aFormatStyles: TppXLSFormatStyles);
    class procedure WriteXFCellDefault(aStream: TStream);
    class procedure WriteXFStyleBuiltInFormat(aStream: TStream);
    class procedure WriteXFStyleNormal(aStream: TStream);
    class procedure WriteXFStyleOutline(aStream: TStream);
  public
    class procedure Write(aStream: TStream; aFormatStyles: TppXLSFormatStyles);
  end;

  {Style Table}
  TppBifStyleBuiltInRec = packed record
    XFIndex: Word;
    BuiltInStyleNo: Byte;
    OutlineLevel: Byte;
  end;

  TppBifStyleUserDefRec = packed record
    XFIndex: Word;
//    Name: String;
  end;

  TppBifWriterStyleTable = class(TppBifWriterBase)
  protected
    class procedure WriteStyleBuiltIn(aStream: TStream; aXFIndex, aStyleNo: Integer);
    class procedure WriteStyleDefault(aStream: TStream);
  public
    class procedure Write(aStream: TStream; aFormatStyles: TppXLSFormatStyles);
  end;

  {Palette }
  TppBifPaletteRec = packed record
    Count: word;
//    Colors: array[count] of Longword
  end;

  TppBifWriterPalette = class(TppBifWriterBase)
  public
    class procedure Write(aStream: TStream; aColorTable: TppColorTable);
  end;

  {Sheet Table }
  TppBifBoundSheetRec = packed record
    BofPos: Longword;
    Options: Word;
//    Name: String;
  end;

  TppBifWriterSheetTable = class(TppBifWriterBase)
  public
    class function Write(aStream: TStream): Integer;
  end;


  {String Table}
  TppBifSSTRec = packed record
    TotalStringCount: Longword;
    UniqueStringCount: Longword;
//    Strings: array [0..n] of Unicode Strings
  end;

  TppBifWriterSharedStringTable = class(TppBifWriterBase)
  protected
    class procedure WriteRecSST(aStream, aStringStream: TStream; aStringTable: TppStringTable);
    class procedure WriteRecContinue(aStream, aStringStream: TStream);
    class procedure WriteStringBlock(aStream: TStream; aStringTable: TppStringTable; var aIndex: Integer);
  public
    class procedure Write(aStream: TStream; aStringTable: TppStringTable);
  end;

{-------------------------------------------------------------------------------
  Worksheet records
    Bof
    Index
    PageSettings block
      Margins
      PageSetup
    Cell Table - page 90
      DefaultRowHeight
      SheetPtr
      DefColWidth
      ColInfo
      Dimension
      RowBlocks
        Row recs
        Cell blocks
        DBCell
      //StandardWidth
      MergedCells
    Worksheet View Settings
    Eof


--------------------------------------------------------------------------------}


  {Index}
  TppBifIndexRec = packed record
    Reserved: Longword;
    RowMin: Longword;
    RowMax: Longword;
    PosOfDefColWidth: Longword;
//  DBCellPositions: array of Longword  (array of positions for DBCell recs (one DBCell for each row block)
  end;

  TppBifWriterIndex = class(TppBifWriterBase)
  public
    class procedure Write(aStream: TStream; aRowCount: Integer; aColDefPos, aRowBlockPos: Int64; aIndex: TppIntegerCollection);
  end;

  {--------Page Settings -----------------------}

  TppBifMarginRec = packed record
    Margin: Double;
  end;

  TppBifWriterMargins = class(TppBifWriterBase)
  protected
    class procedure WriteMargin(aStream: TStream; aRecordId: Word; aMargin: Double);
  public
    class procedure Write(aStream: TStream; aWorksSheeInfo: TppXLSWorksheetInfo);
  end;

  TppBifPageSetupRec = packed record
    PaperSize: Word;
    ScalingFactor: Word;
    StartPageNo: Word;
    FitSheetWidth: Word;
    FitSheetHeight: Word;
    Options: Word;
    DPI: Word;
    VertDPI: Word;
    HeaderMargin: Double;
    FooterMargin: Double;
    Copies: Word;
  end;

  TppBifWriterPageSetup = class(TppBifWriterBase)
  protected
  public
    class procedure Write(aStream: TStream; aPrinterSetup: TppPrinterSetup);
  end;



  {---- Cell Table ------------------------}

  {Default Row Height}
  TppBifDefaultRowHeightRec = packed record
    Options: Word;
    DefaultHeight: Word;
  end;

  TppBifWriterDefaultRowHeight = class(TppBifWriterBase)
  public
    class procedure Write(aStream: TStream; aHeight: Integer);
  end;

  TppBifSheetPtrRec = packed record
    Options: Word;
  end;

  TppBifWriterSheetPtr = class(TppBifWriterBase)

  public
    class procedure Write(aStream: TStream);
  end;



  {Default Col Width}
  TppBifDefColWidthRec = packed record
    DefaultWidth: Word;
  end;

  TppBifWriterDefColWidth = class(TppBifWriterBase)
  public
    class procedure Write(aStream: TStream; aWidth: Integer);
  end;

  {Col Info}
  TppBifColInfoRec = packed record
    ColIndexFirst: Word;
    ColIndexLast: Word;
    Width: Word; // 1/256 of zero character using default font
    XFIndex: Word;
    Options: Word;
    Reserved: Word;
  end;

  TppBifWriterColInfo = class(TppBifWriterBase)
  protected
    class procedure WriteItem(aStream: TStream; aColIndex: Integer; aWorksheetInfo: TppXLSWorksheetInfo);
  public
    class procedure Write(aStream: TStream; aWorksheetInfo: TppXLSWorksheetInfo);
  end;

  {Dimenstion}
  TppBifDimensionRec = packed record
    RowIndexFirst: Longword;
    RowIndexLast: Longword;
    ColIndexFirst: Word;
    ColIndexLast: Word;
    Reserved: Word;
  end;

  TppBifWriterDimension = class(TppBifWriterBase)
  public
    class procedure Write(aStream: TStream; aRowIndexFirst, aColIndexFirst, aRowIndexLast, aColIndexLast: Integer);
  end;

  {Row }
  TppBifRowRec = packed record
    RowNumber: Word;
    ColIndexFirst: Word;
    ColIndexLast: Word;
    RowHeight: Word;
    NotUsed1: Word;
    NotUsed2: Word;
    Options: Word;
    XFIndex: Word;
  end;

  TppBifWriterRow = class(TppBifWriterBase)
  protected
  public
    class procedure Write(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aRow: TppXLSRow);
  end;

  {----- Cell ---------------}

  {Blank }
  TppBifBlankRec = packed record
    RowIndex: Word;
    ColIndex: Word;
    XFIndex: Word;
  end;

  {Label SST}
  TppBifLabelSSTRec = packed record
    RowIndex: Word;
    ColIndex: Word;
    XFIndex: Word;
    SSTIndex: Longword;
  end;


  TppBifLabelRec = packed record
    RowIndex: Word;
    ColIndex: Word;
    XFIndex: Word;
//    Value: String; // 16-bit length
  end;

  {Number }
  TppBifNumberRec = packed record
    RowIndex: Word;
    ColIndex: Word;
    XFIndex: Word;
    Value: Double;
  end;

  {RK Value}
  TppBifRKValueRec = packed record
    RowIndex: Word;
    ColIndex: Word;
    XFIndex: Word;
    Value: Longint; // see page 20
  end;

  // Boolean Value
  TppBifBooleanRec = packed record
    RowIndex: Word;
    ColIndex: Word;
    XFIndex: Word;
    Value: Byte;
    Flag: Byte;
  end;


  TppBifWriterCell = class(TppBifWriterBase)
  public
    class procedure Write(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
    class procedure WriteDate(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
    class procedure WriteBlank(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
    class procedure WritelFloat(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
    class procedure WriteInteger(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
    class procedure WriteBoolean(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
    class procedure WriteString(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
  end;

  {DBCell }
  TppBifDBCellRec = packed record
    OffsetFirstRow: Longword;
// OffsetRows array[0..n] of Word;
  end;

  TppBifWriterDBCell = class(TppBifWriterBase)
  public
    class procedure Write(aStream: TStream; aOffSetFirstRow: Integer; aDBCellIndex: TppIntegerCollection);
  end;

  {Worksheet View (Window2) }
  TppBifWindow2Rec =  packed record
    Options1: Byte;
    Options2: Byte;
    TopRowVisible: Word;
    LeftColVisible: Word;
    HeaderColorIndex: Longword;
    ScalePageBreakView: Word;
    ScaleNormalView: Word;
    Reserved: Longword;
  end;

  TppBifCellRangeRec = packed record
    RowIndexFirst: Word;
    RowIndexLast: Word;
    ColIndexFirst: Word;
    ColIndexLast: Word;
  end;

  TppBifMergedCellsRec = packed record
    Count: Word;
// CellRanges: array [0..n] of TppBifCellRangeRec

  end;

  TppBifWriterMergedCells = class(TppBifWriterBase)
  protected
    class procedure WriteBlock(aStream: TStream; aMergedCells: TppXLSCellRangeCollection; var aIndex: Integer);
    class procedure WriteRecord(aStream, aCellStream: TStream);
  public
    class procedure Write(aStream: TStream; aWorksSheeInfo: TppXLSWorksheetInfo);
  end;


  TppBifWriterWorksheetViewSettings = class(TppBifWriterBase)
  public
    class procedure Write(aStream: TStream);
  end;


  TppBifCompressPicturesRec = packed record
    RecordType: Word;
    grBitFrt: Word;
    Reserved: array [0..7] of Byte;
    Compressed: Integer;
  end;

  TppBifWriterCompressedPictures = class(TppBifWriterBase)
  public
    class procedure Write(aStream: TStream); reintroduce;
  end;

implementation



class function TppBifWriterBase.CalcStringByteDataSize(aCharsRec: TppBifCharsRec): Word;
begin

  Result := SizeOf(TppBifStringByteRec) + Length(aCharsRec.Bytes);

end;

class function TppBifWriterBase.CalcStringDataSize(aCharsRec: TppBifCharsRec): Word;
begin

  Result := SizeOf(TppBifStringRec) + Length(aCharsRec.Bytes);

end;

{$IFDEF Unicode}

class procedure TppBifWriterBase.CompressString(aString: string; var aCharsRec: TppBifCharsRec);
var
  lBytes: TBytes;
begin

  lBytes := TEncoding.Unicode.GetBytes(aString);

  lBytes := CompressBytes(lBytes);

  aCharsRec.Compressed := Length(lBytes) = Length(aString);
  aCharsRec.Bytes := lBytes;
  aCharsRec.CharCount := Length(aString);

end;

{$ELSE}

class procedure TppBifWriterBase.CompressString(aString: WideString; var aCharsRec: TppBifCharsRec);
var
  lsWideString: WideString;
  lBytes: TBytes;
  liByteLen: Integer;
begin

  lsWideString := aString;

  liByteLen := Length(aString) * 2;

  SetLength(lBytes, liByteLen);

  Move(lsWideString[1], lBytes[0], liByteLen);

  lBytes := CompressBytes(lBytes);

  aCharsRec.Compressed := Length(lBytes) = Length(aString);
  aCharsRec.Bytes := lBytes;
  aCharsRec.CharCount := Length(aString);

end;

{$ENDIF}

class function TppBifWriterBase.CompressBytes(aBytes: TBytes): TBytes;
var
  liIndex: Integer;
  lCompressedBytes: TBytes;
  lbCompressed: Boolean;
  liCompIndex: Integer;
begin

  lbCompressed := True;

  SetLength(lCompressedBytes, Length(aBytes) div 2);

  liIndex := 1;
  liCompIndex := 0;

  // check whether high order bytes are empty
  while lbCompressed and (liIndex < Length(aBytes)) do
    begin
      lbCompressed := (aBytes[liIndex] = $0);

      if lbCompressed then
        lCompressedBytes[liCompIndex] := aBytes[liIndex-1];

      Inc(liIndex, 2);
      Inc(liCompIndex, 1);

    end;

  if lbCompressed then
    Result := lCompressedBytes
  else
    Result := aBytes;

end;


class procedure TppBifWriterBase.WriteHeader(aStream: TStream; aRecordId, aDataSize: Word);
var
  lHeader: TppBifHeaderRec;
begin

  lHeader.Id := aRecordId;
  lHeader.DataSize := aDataSize;

  aStream.Write(lHeader, SizeOf(TppBifHeaderRec));

end;

class procedure TppBifWriterBase.WriteString(aStream: TStream; aCharsRec: TppBifCharsRec);
var
  lStringRec: TppBifStringRec;
begin

  FillChar(lStringRec, SizeOf(TppBifStringRec), 0);

  // number of chars
  lStringRec.Length := aCharsRec.CharCount;

  // if not compressed, set flag
  if not(aCharsRec.Compressed) then
     lStringRec.Options := lStringRec.Options or $01;

  aStream.Write(lStringRec, SizeOf(TppBifStringRec));
  aStream.Write(aCharsRec.Bytes[0], Length(aCharsRec.Bytes));

end;

class procedure TppBifWriterBase.WriteStringRichText(aStream: TStream; aCharsRec: TppBifCharsRec; aFormatRuns: TppStringFormatRuns);
var
  lStringRec: TppBifRTFStringRec;
//  lFormatRun: TppBifRTFFormatRunRec;
//  liIndex: Integer;
begin

  FillChar(lStringRec, SizeOf(TppBifRTFStringRec), 0);

  // number of chars
  lStringRec.Length := aCharsRec.CharCount;

  lStringRec.FormatRunCount := Length(aFormatRuns);

  // if not compressed, set flag
  if not(aCharsRec.Compressed) then
     lStringRec.Options := lStringRec.Options or $01;

  // rtf flag
  lStringRec.Options := lStringRec.Options or $08;

  // write string rec, byte[] and formatruns
  aStream.Write(lStringRec, SizeOf(TppBifRTFStringRec));
  aStream.Write(aCharsRec.Bytes[0], Length(aCharsRec.Bytes));

  aStream.Write(aFormatRuns[0], lStringRec.FormatRunCount * SizeOf(TppBifRTFFormatRunRec));

{  for liIndex := 0 to Length(aFormatRuns) - 1 do
    begin
      lFormatRun.CharIndex := aFormatRuns[liIndex].CharIndex;
      lFormatRun.FontIndex := aFormatRuns[liIndex].FontIndex;
      aStream.Write(lFormatRun, SizeOf(TppBifRTFFormatRunRec));
    end;
}

end;

class procedure TppBifWriterBase.WriteStringByte(aStream: TStream; aCharsRec: TppBifCharsRec);
var
  lStringRec: TppBifStringByteRec;
begin

  FillChar(lStringRec, SizeOf(TppBifStringByteRec), 0);

  // number of chars
  lStringRec.Length := aCharsRec.CharCount;

  // if not compressed, set flag
  if not(aCharsRec.Compressed) then
    lStringRec.Options := lStringRec.Options or $01;

  aStream.Write(lStringRec, SizeOf(TppBifStringByteRec));
  aStream.Write(aCharsRec.Bytes[0], Length(aCharsRec.Bytes));

end;


class procedure TppBifWriterBof.InitializeBofRec(var aBofRec: TppBifBofRec);
begin

  FillChar(aBofRec, SizeOf(TppBifBOFRec), 0);

  aBofRec.Version := $0600; // Biff 8
  aBofRec.BofType := $0005; // workbook globals
  aBofRec.BuildId := $0DBB; // XLS 97
  aBofRec.BuildYear := $07CC; // XLS 97

  aBofRec.LoVersion := $0600; // lowest version that can read the file (Biff 8)

  aBofRec.BuildId := $27F3; // XLS 97
  aBofRec.BuildYear := $07CD; // XLS 97
  aBofRec.LoVersion := $0106; // lowest version that can read the file (Biff 8)

  aBofRec.FileHistory := $40C9;

end;

class procedure TppBifWriterBof.WriteBofWorkbookGlobals(aStream: TStream);
var
  lBofRec: TppBifBofRec;
begin

  WriteHeader(aStream, $0809, SizeOf(TppBifBOFRec));

  InitializeBofRec(lBofRec);

  aStream.Write(lBofRec, SizeOf(TppBifBOFRec));

end;

class procedure TppBifWriterBof.WriteBofWorksheet(aStream: TStream);
var
  lBofRec: TppBifBofRec;
begin

  WriteHeader(aStream, $0809, SizeOf(TppBifBOFRec));

  InitializeBofRec(lBofRec);

  lBofRec.BofType := $0010; // worksheet

  aStream.Write(lBofRec, SizeOf(TppBifBOFRec));

end;

class procedure TppBifWriterWindowSettings.Write(aStream: TStream);
var
  lWindow1Rec: TppBifWindow1Rec;
begin

  // units are twips (1/20 pt)
  lWindow1Rec.XPos := $00F0;
  lWindow1Rec.YPos := $002D;
  lWindow1Rec.Width := $3B97;
  lWindow1Rec.Height := $29D6;

  lWindow1Rec.Options := $0008 or $0010 or $0020; // display horz & vert scrollbars, and tabs
  lWindow1Rec.TabCurrent := $0000;  // only one tab
  lWindow1Rec.TabFirst := $0000;
  lWindow1Rec.TabsSelected := $0001;
  lWindow1Rec.TabRatio := $0258;

  WriteHeader(aStream, $3D, SizeOf(TppBifWindow1Rec));

  // write data
  aStream.Write(lWindow1Rec, SizeOf(TppBifWindow1Rec));

end;

class procedure TppBifWriterFontTable.Write(aStream: TStream; aFormatStyles: TppXLSFormatStyles);
var
  liIndex: Integer;
  lFont: TFont;
begin

  for liIndex := 0 to aFormatStyles.Fonts.Count - 1 do
    WriteFont(aStream, aFormatStyles.Fonts[liIndex], aFormatStyles);

  // must be at least 5 fonts
  if (aFormatStyles.Fonts.Count < 5) then
    begin

      if aFormatStyles.Fonts.Count > 0 then
        lFont := aFormatStyles.Fonts[0]
      else
        lFont := TFont.Create;

      liIndex := aFormatStyles.Fonts.Count;


      // minimum of 5 fonts
      while liIndex < 5 do
        begin
          WriteFont(aStream, lFont, aFormatStyles);
          Inc(liIndex);
        end;

      if aFormatStyles.Fonts.Count = 0 then
        lFont.Free;

    end;

end;

class procedure TppBifWriterFontTable.WriteFont(aStream: TStream; aFont: TFont; aFormatStyles: TppXLSFormatStyles);
var
  lFontRec: TppBifFontRec;
  liDataSize: Integer;
  lsFontName: String;
  lCharsRec: TppBifCharsRec;
begin

  FillChar(lFontRec, SizeOf(TppBifFontRec), 0);

//  lFontRec.Height := ScreenPixelsToTwips(Abs(aFont.Height));
  lFontRec.Height := Abs(aFont.Size) * 20;  // twips are 1/20th point

  // get color index
  lFontRec.ColorIndex := aFormatStyles.GetColorIndex(aFont.Color);

  // set Options - bold and underline are not used for Biff8
//  if (fsBold in aFont.Style) then lFontRec.Options := lFontRec.Options or $0001;
  if (fsItalic in aFont.Style) then lFontRec.Options := lFontRec.Options or $0002;
//  if (fsUnderline in aFont.Style) then lFontRec.Options := lFontRec.Options or $0004;
  if (fsStrikeOut in aFont.Style) then lFontRec.Options := lFontRec.Options or $0008;

  // for Biff8, bold and underline are set here (redundant)
  if (fsBold in aFont.Style) then
    lFontRec.Weight := $02BC  // bold text
  else
    lFontRec.Weight := $0190; // normal text

  if (fsUnderLine in aFont.Style) then
    lFontRec.Underline := $01 // single underline
  else
    lFontRec.Underline := $00; // none

  lFontRec.CharSet := aFont.Charset;

  lsFontName := aFont.Name;

  CompressString(aFont.Name, lCharsRec);

  liDataSize :=  SizeOf(TppBifFontRec) + CalcStringByteDataSize(lCharsRec);

  // write header
  WriteHeader(aStream, $0031, liDataSize);

  // write font rec
  aStream.Write(lFontRec, SizeOf(TppBifFontRec));

  // write font name
  WriteStringByte(aStream, lCharsRec);


end;

class procedure TppBifWriterEof.Write(aStream: TStream);
begin
  WriteHeader(aStream, $000A, 0);
end;

class procedure TppBifWriterFormatTable.Write(aStream: TStream; aFormatStyles: TppXLSFormatStyles);
var
  liIndex: Integer;
begin

  for liIndex := 0 to aFormatStyles.DisplayFormats.Count - 1 do
    WriteFormat(aStream, aFormatStyles.DisplayFormats[liIndex], aFormatStyles);

end;

class procedure TppBifWriterFormatTable.WriteFormat(aStream: TStream; aDisplayFormat: String; aFormatStyles: TppXLSFormatStyles);
var
  lFormatRec: TppBifFormatRec;
  liDataSize: Integer;
  lCharsRec: TppBifCharsRec;
begin

  FillChar(lFormatRec, SizeOf(TppBifFormatRec), 0);

  lFormatRec.FormatIndex := aFormatStyles.GetDisplayFormatIndex(aDisplayFormat);

  CompressString(aDisplayFormat, lCharsRec);

  liDataSize :=  SizeOf(TppBifFormatRec) + CalcStringDataSize(lCharsRec);

  // write header
  WriteHeader(aStream, $0041E, liDataSize);

  // write format rec
  aStream.Write(lFormatRec, SizeOf(TppBifFormatRec));

  // write string
  WriteString(aStream, lCharsRec);

end;

class function TppBifWriterXFTable.CalcBorderLineStyle(aBorder: TppBorder): Byte;
begin

  if (aBorder.Style = psDash) then
    Result := $03  // dashed
 else  if (aBorder.Style = psDot) then
    Result := $04  // dotted
 else  if (aBorder.Style = psDashDot) then
    Result := $09  // thin dash-dotted
 else  if (aBorder.Style = psDashDotDot) then
    Result := $0B  // thin dash-dot-dotted
  else // psSolid
    Result := $01;  // thin solid

end;

class function TppBifWriterXFTable.CalcTextAlignment(aTextAlignment: TppTextAlignment): Byte;
begin

  // text alignment
  case aTextAlignment of
    taLeftJustified:
      Result := 1;
    taCentered:
      Result := 2;
    taRightJustified:
      Result := 3;
    taFullJustified:
      Result := 5;
    else
      Result := 1;
  end;

end;

class procedure TppBifWriterXFTable.InitializeXFStyleRec(var aXFRecord: TppBifXFRec);
begin

  // write normal XF
  FillChar(aXFRecord, SizeOf(TppBifXFRec), 0);

  // default to 0
  aXFRecord.FontIndex := $0000;
  aXFRecord.FormatIndex := $0000;

  // fStyle = 1
  aXFRecord.CellOptions := (aXFRecord.CellOptions or $0004);

  // last 24 bits, parent style index, always $FFF for style records
  aXFRecord.CellOptions := (aXFRecord.CellOptions or $FFF0);

  // locked = 1
  aXFRecord.CellOptions := (aXFRecord.CellOptions or $0001);

end;

{
    XF table requirements

       0 - normal style

       1 - outline rowlevel_1
       2 - outline collevel_1
       3 - outline rowlevel_2
       4 - outline collevel_2
       ...
       13 - outline rowlevel_7
       14 - outline collevel_7

       15 - workbook default cell style

   plus built-in styles

       16 - comma
       17 - comma[0]
       18 - currency
       19 - currency[0]
       20 - percent

}

class procedure TppBifWriterXFTable.Write(aStream: TStream; aFormatStyles: TppXLSFormatStyles);
var
  liIndex: Integer;
begin

  // xf 0
  WriteXFStyleNormal(aStream);

  // xf 1 thru 14
  WriteXFStyleOutline(aStream);

  // xf 15
  WriteXFCellDefault(aStream);

  // xf 16 thru 20
  WriteXFStyleBuiltInFormat(aStream);

  // write element formats
  for liIndex := 0 to aFormatStyles.ElementFormats.Count - 1 do
    WriteXF(aStream, aFormatStyles.ElementFormats[liIndex], aFormatStyles);

end;

class procedure TppBifWriterXFTable.WriteXF(aStream: TStream; aElementFormat: TppElementFormat; aFormatStyles: TppXLSFormatStyles);
var
  lXFRecord: TppBifXFRec;
  liColorIndex: Word;
  liLineStyle: Cardinal;
  lBorder: TppBorder;
begin

  // initialize
  FillChar(lXFRecord, SizeOf(TppBifXFRec), 0);

  // locked = 1
  lXFRecord.CellOptions := (lXFRecord.CellOptions or $0001);

  // font
  lXFRecord.FontIndex := aFormatStyles.GetFontIndex(aElementFormat.Font);
  lXFRecord.UsedAttributes := lXFRecord.UsedAttributes or $02; // font is set

  // display format
  if (aElementFormat.DisplayFormat <> '') then
    begin
      lXFRecord.FormatIndex := aFormatStyles.GetDisplayFormatIndex(aElementFormat.DisplayFormat);
      lXFRecord.UsedAttributes := lXFRecord.UsedAttributes or $01; // format is set
    end;

  // text alignment
  lXFRecord.AlignmentOptions := CalcTextAlignment(aElementFormat.TextAlignment);
  lXFRecord.UsedAttributes := lXFRecord.UsedAttributes or $04; // alignment is set

  if aElementFormat.WrapText then
    lXFRecord.AlignmentOptions := lXFRecord.AlignmentOptions or (1 shl 3);

  // rotation
  if (aElementFormat.Angle <> 0) then
    lXFRecord.RotateOptions := aElementFormat.Angle;

  // backfground color
  if (aElementFormat.Color <> clNone) then
    begin
      liColorIndex := aFormatStyles.GetColorIndex(aElementFormat.Color);
      lXFRecord.BorderOptions2 :=  lXFRecord.BorderOptions2 or (1 shl 26); // solid pattern
      lXFRecord.FillPaletteOptions := lXFRecord.FillPaletteOptions or liColorIndex; // patter color
      lXFRecord.UsedAttributes := lXFRecord.UsedAttributes or $10; // background is set
    end;

  // border
  if (aElementFormat.Border.Visible) then
    begin
      lBorder := aElementFormat.Border;

      // border line style
      liLineStyle := CalcBorderLineStyle(lBorder);
      if (bpLeft in lBorder.BorderPositions) then
        lXFRecord.Borderoptions1 := lXFRecord.BorderOptions1 or (liLineStyle shl 0);
      if (bpRight in lBorder.BorderPositions) then
        lXFRecord.Borderoptions1 := lXFRecord.BorderOptions1 or (liLineStyle shl 4);
      if (bpTop in lBorder.BorderPositions) then
        lXFRecord.Borderoptions1 := lXFRecord.BorderOptions1 or (liLineStyle shl 8);
      if (bpBottom in lBorder.BorderPositions) then
        lXFRecord.Borderoptions1 := lXFRecord.BorderOptions1 or (liLineStyle shl 12);

      // border color
      liColorIndex := aFormatStyles.GetColorIndex(lBorder.Color);
      if (bpLeft in lBorder.BorderPositions) then
        lXFRecord.Borderoptions1 := lXFRecord.BorderOptions1 or (liColorIndex shl 16);
      if (bpRight in lBorder.BorderPositions) then
        lXFRecord.Borderoptions1 := lXFRecord.BorderOptions1 or (liColorIndex shl 23);
      if (bpTop in lBorder.BorderPositions) then
        lXFRecord.Borderoptions2 := lXFRecord.BorderOptions2 or (liColorIndex shl 0);
      if (bpBottom in lBorder.BorderPositions) then
        lXFRecord.Borderoptions2 := lXFRecord.BorderOptions2 or (liColorIndex shl 7);

      lXFRecord.UsedAttributes := lXFRecord.UsedAttributes or $08; // border is set
    end;

  WriteHeader(aStream, $E0, SizeOf(TppBifXFRec));

  aStream.Write(lXFRecord, SizeOf(TppBifXFRec));

end;

class procedure TppBifWriterXFTable.WriteXFCellDefault(aStream: TStream);
var
  lXFRecord: TppBifXFRec;
begin

  // initialize
  FillChar(lXFRecord, SizeOf(TppBifXFRec), 0);

  // note: for default, all options are set to 0

  WriteHeader(aStream, $E0, SizeOf(TppBifXFRec));

  aStream.Write(lXFRecord, SizeOf(TppBifXFRec));

end;

class procedure TppBifWriterXFTable.WriteXFStyleBuiltInFormat(aStream: TStream);
var
  lXFRecord: TppBifXFRec;
  lFormatId: array [0..4] of Word;
  liIndex: Integer;
begin

  lFormatId[0] := $03; // comma
  lFormatId[1] := $04; // comma[0]
  lFormatId[2] := $05; // currency
  lFormatId[3] := $07; // currency[0]
  lFormatId[4] := $09; // percent

  for liIndex := 0 to 4 do
    begin
      InitializeXFStyleRec(lXFRecord);

      lXFRecord.FormatIndex := lFormatId[liIndex];

      WriteHeader(aStream, $E0, SizeOf(TppBifXFRec));

      aStream.Write(lXFRecord, SizeOf(TppBifXFRec));

    end;

end;

class procedure TppBifWriterXFTable.WriteXFStyleNormal(aStream: TStream);
var
  lXFRecord: TppBifXFRec;
begin

  InitializeXFStyleRec(lXFRecord);

  WriteHeader(aStream, $E0, SizeOf(TppBifXFRec));

  aStream.Write(lXFRecord, SizeOf(TppBifXFRec));

end;

class procedure TppBifWriterXFTable.WriteXFStyleOutline(aStream: TStream);
var
  liIndex: Integer;
begin

  for liIndex := 1 to 14 do
    WriteXFStyleNormal(aStream);

end;


class procedure TppBifWriterStyleTable.Write(aStream: TStream; aFormatStyles: TppXLSFormatStyles);
begin

  WriteStyleDefault(aStream);

end;

class procedure TppBifWriterStyleTable.WriteStyleBuiltIn(aStream: TStream; aXFIndex, aStyleNo: Integer);
var
  lStyleRec: TppBifStyleBuiltInRec;
begin

  // write normal XF
  FillChar(lStyleRec, SizeOf(TppBifStyleBuiltInRec), 0);

  lStyleRec.XFIndex := aXFIndex;
  lStyleRec.BuiltInStyleNo := aStyleNo;

  // built-in style flag
  lStyleRec.XFIndex := lStyleRec.XFIndex or (1 shl 15);

  lStyleRec.OutlineLevel := $FF;

  WriteHeader(aStream, $293, SizeOf(TppBifStyleBuiltInRec));

  aStream.Write(lStyleRec, SizeOf(TppBifStyleBuiltInRec));


end;

class procedure TppBifWriterStyleTable.WriteStyleDefault(aStream: TStream);
begin

  WriteStyleBuiltIn(aStream, 16, 3); // comma
  WriteStyleBuiltIn(aStream, 17, 6); // comma[0]
  WriteStyleBuiltIn(aStream, 18, 4); // currency
  WriteStyleBuiltIn(aStream, 19, 7); // currency[0]
  WriteStyleBuiltIn(aStream, 0, 0); // normal
  WriteStyleBuiltIn(aStream, 20, 5); // percent

end;

class function TppBifWriterSheetTable.Write(aStream: TStream): Integer;
var
  lBoundSheetRec: TppBifBoundSheetRec;
  lsSheetName: String;
  liDataSize: Integer;
  lCharsRec: TppBifCharsRec;
begin

  FillChar(lBoundSheetRec, SizeOf(TppBifBoundSheetRec), 0);

  lBoundSheetRec.BofPos := 0;
  lBoundSheetRec.Options := 0;

  lsSheetName := 'Report';

  CompressString(lsSheetName, lCharsRec);

  liDataSize := SizeOf(TppBifBoundSheetRec) + CalcStringByteDataSize(lCharsRec);

  WriteHeader(aStream, $85, liDataSize);

  Result := aStream.Position;

  aStream.Write(lBoundSheetRec, SizeOf(TppBifBoundSheetRec));

  WriteStringByte(aStream, lCharsRec);

end;

class procedure TppBifWriterSharedStringTable.Write(aStream: TStream; aStringTable: TppStringTable);
var
  liIndex: Integer;
  lbFirst: Boolean;
  lStringStream: TMemoryStream;
begin

  lStringStream := TMemoryStream.Create;

  try

    liIndex := 0;
    lbFirst := True;

    while (liIndex < aStringTable.Count) do
      begin

        // write block to string stream
        WriteStringBlock(lStringStream, aStringTable, liIndex);

        // write record: SST or Continue
        if lbFirst then
          WriteRecSST(aStream, lStringStream, aStringTable)
        else
          WriteRecContinue(aStream, lStringStream);

        lbFirst := False;
        lStringStream.Clear;

      end

  finally
    lStringStream.Free;
  end;


end;

class procedure TppBifWriterSharedStringTable.WriteRecSST(aStream, aStringStream: TStream; aStringTable: TppStringTable);
var
  lSSTRec: TppBifSSTRec;
  liDataSize: Integer;
begin

  // initialize
  FillChar(lSSTRec, SizeOf(lSSTRec), 0);

  lSSTRec.TotalStringCount := aStringTable.OccurenceCount;
  lSSTRec.UniqueStringCount := aStringTable.Count;

  liDataSize := SizeOf(TppBifSSTRec) + aStringStream.Size;

  // write header
  WriteHeader(aStream, $FC, liDataSize);

  // write SST rec
  aStream.Write(lSSTRec, SizeOf(TppBifSSTRec));

  // write string stream
  aStream.CopyFrom(aStringStream, 0);


end;

class procedure TppBifWriterSharedStringTable.WriteRecContinue(aStream, aStringStream: TStream);
begin

  // write Continue header
  WriteHeader(aStream, $003C, aStringStream.Size);

  // write string stream
  aStream.CopyFrom(aStringStream, 0);


end;

class procedure TppBifWriterSharedStringTable.WriteStringBlock(aStream: TStream; aStringTable: TppStringTable; var aIndex: Integer);
const
  cMaxBlockSize = 8224;
var
  liSize: Integer;
  lCharsRec: TppBifCharsRec;
  lStringItem: TppStringTableItem;
  liMaxBlockSize: Integer;
//  liTest: Integer;
begin

  liSize := 0;

  if aIndex = 0 then
    liMaxBlockSize := cMaxBlockSize - SizeOf(TppBifSSTRec)
  else
    liMaxBlockSize := cMaxBlockSize;

//  liTest := 0;

  while (aIndex < aStringTable.Count) do
   begin

     lStringItem := aStringTable[aIndex];

     CompressString(lStringItem.Text, lCharsRec);

     // calc size
     liSize := liSize + Length(lCharsRec.Bytes);

     if lStringItem.IsRichText then
       begin
         liSize := liSize +  SizeOf(TppBifRTFStringRec);
         liSize := liSize + (Length(lStringItem.FormatRuns) * SizeOf(TppBifRTFFormatRunRec));
       end
     else
       liSize := liSize + SizeOf(TppBifStringRec);

     // check whether string fits in this block
     if (liSize > liMaxBlockSize) then Break;

     if lStringItem.IsRichText then
       WriteStringRichText(aStream, lCharsRec, lStringItem.FormatRuns)
     else
       WriteString(aStream, lCharsRec);

     Inc(aIndex);

//     if (liTest > 3) then Break;

//     Inc(liTest);


   end;

end;

class procedure TppBifWriterDimension.Write(aStream: TStream; aRowIndexFirst, aColIndexFirst, aRowIndexLast, aColIndexLast: Integer);
var
  lDimensionRec: TppBifDimensionRec;
begin

  FillChar(lDimensionRec, SizeOf(TppBifDimensionRec), 0);

  lDimensionRec.RowIndexFirst := aRowIndexFirst;
  lDimensionRec.ColIndexFirst := aColIndexFirst;

  lDimensionRec.RowIndexLast := aRowIndexLast;
  lDimensionRec.ColIndexLast := aColIndexLast;

  WriteHeader(aStream, $0200, SizeOf(TppBifDimensionRec));

  // write data
  aStream.Write(lDimensionRec, SizeOf(TppBifDimensionRec));


end;

class procedure TppBifWriterWorksheetViewSettings.Write(aStream: TStream);
var
  lWindow2Rec: TppBifWindow2Rec;
begin

  FillChar(lWindow2Rec, SizeOf(TppBifWindow2Rec), 0);

  // fDspGrid =  display grid lines
  lWindow2Rec.Options1 := lWindow2Rec.Options1 or $02;

  // fDspRwCol = display row/col headings
  lWindow2Rec.Options1 := lWindow2Rec.Options1 or $04;

  // fDspZeros = display zeros
  lWindow2Rec.Options1 := lWindow2Rec.Options1 or $10;

  // fDefaultHdr = row/col header use default foreground color
  lWindow2Rec.Options1 := lWindow2Rec.Options1 or $20;

  // fSelected = sheet tab selected
  lWindow2Rec.Options2 := lWindow2Rec.Options2 or $02;

  // fPaged = sheet visible
  lWindow2Rec.Options2 := lWindow2Rec.Options2 or $04;


  lWindow2Rec.TopRowVisible := 0;
  lWindow2Rec.LeftColVisible := 0;
  lWindow2Rec.HeaderColorIndex := 0;
  lWindow2Rec.ScalePageBreakView := 0;
  lWindow2Rec.ScaleNormalView := 0;

  WriteHeader(aStream, $23E, SizeOf(TppBifWindow2Rec));

  aStream.Write(lWindow2Rec, SizeOf(TppBifWindow2Rec));
end;

class procedure TppBifWriterRow.Write(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aRow: TppXLSRow);
var
  lRowRec: TppBifRowRec;
begin

  // write row info
  FillChar(lRowRec, SizeOf(TppBifRowRec), 0);

  lRowRec.RowNumber := aRow.RowIndex;
  lRowRec.ColIndexFirst := aRow.ColIndexFirst;
  lRowRec.ColIndexLast := aRow.ColIndexLast+1;
  lRowRec.RowHeight := aRow.Height;
  lRowRec.Options := 0;

  // set bit to indicate height is different from default
  lRowRec.Options := lRowRec.Options or $00000040;

  // bit 7 always 1
  lRowRec.Options := lRowRec.Options or $00000100;

//  lRowRec.XFIndex := $0F; // default cell style for row

  WriteHeader(aStream, $208, SizeOf(TppBifRowRec));
  aStream.Write(lRowRec, SizeOf(TppBifRowRec));

end;

class procedure TppBifWriterDefaultRowHeight.Write(aStream: TStream; aHeight: Integer);
var
  lDefRowHeightRec: TppBifDefaultRowHeightRec;
begin

  FillChar(lDefRowHeightRec, SizeOf(TppBifDefaultRowHeightRec), 0);

  lDefRowHeightRec.DefaultHeight := aHeight; // twips

  WriteHeader(aStream, $225, SizeOf(TppBifDefaultRowHeightRec));

  aStream.Write(lDefRowHeightRec, SizeOf(TppBifDefaultRowHeightRec));

end;

class procedure TppBifWriterDateMode.Write(aStream: TStream);
var
  lDateModeRec: TppBifDateModeRec;
begin

  // Base date is 1899-Dec-31 (the cell value 1 represents 1900-Jan-01)
  lDateModeRec.Mode := 0;

  WriteHeader(aStream, $0022, SizeOf(TppBifDateModeRec));

  // write data
  aStream.Write(lDateModeRec, SizeOf(TppBifDateModeRec));

end;

class procedure TppBifWriterCell.Write(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
begin

  if aCell.IsBlank then
    WriteBlank(aStream, aWorkBookInfo, aCell)
  else

    case aCell.DataType of
      dtInteger,
      dtLongint,
      dtLargeInt:
        WriteInteger(aStream, aWorkBookInfo, aCell);

      dtSingle,
      dtDouble,
      dtExtended,
      dtCurrency:
        WritelFloat(aStream, aWorkBookInfo, aCell);

      dtDate,
      dtTime,
      dtDateTime:
         WriteDate(aStream, aWorkBookInfo, aCell);

      dtBoolean:
         WriteBoolean(aStream, aWorkBookInfo, aCell);

      else
        WriteString(aStream, aWorkBookInfo, aCell);

   {  dtBoolean: ;
      dtChar: ;
      dtString: ;
      dtVariant: ;
      dtBLOB: ;
      dtMemo: ;
      dtGraphic: ;
      dtNotKnown: ;
      dtGUID: ; }

    end;

end;

class procedure TppBifWriterCell.WriteDate(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
begin

//  aCell.Value := aCell.Value - 1;

  WritelFloat(aStream, aWorkBookInfo, aCell);


end;

class procedure TppBifWriterCell.WriteBlank(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
var
  lCellRecBlank: TppBifBlankRec;
begin

  // write label
  FillChar(lCellRecBlank, SizeOf(TppBifBlankRec), 0);

  lCellRecBlank.RowIndex := aCell.RowIndex;
  lCellRecBlank.ColIndex := aCell.ColumnIndex;
  lCellRecBlank.XFIndex := aCell.FormatIndex;

  WriteHeader(aStream, $0201, SizeOf(TppBifBlankRec));

  aStream.Write(lCellRecBlank, SizeOf(TppBifBlankRec));

end;

class procedure TppBifWriterCell.WritelFloat(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
var
  lCellRecFloat: TppBifNumberRec;
begin

  // write float
  FillChar(lCellRecFloat, SizeOf(TppBifNumberRec), 0);
  lCellRecFloat.RowIndex := aCell.RowIndex;
  lCellRecFloat.ColIndex := aCell.ColumnIndex;
  lCellRecFloat.XFIndex := aCell.FormatIndex;

  lCellRecFloat.Value := aCell.Value;

  WriteHeader(aStream, $0203, SizeOf(TppBifNumberRec));

  aStream.Write(lCellRecFloat, SizeOf(TppBifNumberRec));

end;

class procedure TppBifWriterCell.WriteInteger(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
var
  lCellRecRKValue: TppBifRKValueRec;
  liValue: Integer;
begin

// write integer
  FillChar(lCellRecRKValue, SizeOf(TppBifRKValueRec), 0);
  lCellRecRKValue.RowIndex := aCell.RowIndex;
  lCellRecRKValue.ColIndex := aCell.ColumnIndex;
  lCellRecRKValue.XFIndex :=  aCell.FormatIndex;

  liValue := aCell.Value;

  // shift up 2 and set the second bit to 1 for integer type
  lCellRecRKValue.Value := (liValue shl 2) or  ($1 shl 1);

  WriteHeader(aStream, $027E, SizeOf(TppBifRKValueRec));

  aStream.Write(lCellRecRKValue, SizeOf(TppBifRKValueRec));

end;

class procedure TppBifWriterCell.WriteBoolean(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
var
  lCellRecBoolean: TppBifBooleanRec;
begin

  // write boolean
  FillChar(lCellRecBoolean, SizeOf(TppBifBooleanRec), 0);
  lCellRecBoolean.RowIndex := aCell.RowIndex;
  lCellRecBoolean.ColIndex := aCell.ColumnIndex;
  lCellRecBoolean.XFIndex := aCell.FormatIndex;

  lCellRecBoolean.Value := aCell.Value;

  WriteHeader(aStream, $0205, SizeOf(TppBifBooleanRec));

  aStream.Write(lCellRecBoolean, SizeOf(TppBifBooleanRec));

end;

class procedure TppBifWriterCell.WriteString(aStream: TStream; aWorkBookInfo: TppXLSWorkbookInfo; aCell: TppXLSCell);
var
  lCellRecLabel: TppBifLabelSSTRec;
begin

  // write label sst
  FillChar(lCellRecLabel, SizeOf(TppBifLabelSSTRec), 0);

  lCellRecLabel.RowIndex := aCell.RowIndex;
  lCellRecLabel.ColIndex := aCell.ColumnIndex;
  lCellRecLabel.SSTIndex := aCell.StringIndex;
  lCellRecLabel.XFIndex :=  aCell.FormatIndex;

  WriteHeader(aStream, $FD, SizeOf(TppBifLabelSSTRec));

  aStream.Write(lCellRecLabel, SizeOf(TppBifLabelSSTRec));

end;

class procedure TppBifWriterDBCell.Write(aStream: TStream; aOffSetFirstRow: Integer; aDBCellIndex: TppIntegerCollection);
var
  lDBCellRec: TppBifDBCellRec;
  liDataSize: Integer;
  liIndex: Integer;
  liRowOffset: Word;
begin

  // initialize
  FillChar(lDBCellRec, SizeOf(TppBifDBCellRec), 0);

  lDBCellRec.OffsetFirstRow := aOffSetFirstRow;

  // calc data size
  liDataSize := SizeOf(TppBifDBCellRec) + (SizeOf(Word) * aDBCellIndex.Count);

  WriteHeader(aStream, $D7, liDataSize);

  aStream.Write(lDBCellRec, SizeOf(TppBifDBCellRec));

  // write array of row offsets
  for liIndex := 0 to aDBCellIndex.Count - 1 do
    begin
      liRowOffset := aDBCellIndex[liIndex];
      aStream.Write(liRowOffset, SizeOf(Word));
    end;

end;

class procedure TppBifWriterPalette.Write(aStream: TStream; aColorTable: TppColorTable);
var
  lPaletteRec: TppBifPaletteRec;
  liDataSize: Integer;
  liIndex: Integer;
  lColor: Longword;
begin

  // initialize
  FillChar(lPaletteRec, SizeOf(lPaletteRec), 0);

  // calc data size
  lPaletteRec.Count := aColorTable.Count;

  liDataSize := SizeOf(TppBifPaletteRec) + (SizeOf(Longword) * aColorTable.Count);

  WriteHeader(aStream, $0092, liDataSize);

  aStream.Write(lPaletteRec, SizeOf(TppBifPaletteRec));

  // write colors
  for liIndex := 0 to aColorTable.Count - 1 do
    begin
      lColor := ColorToRGB(aColorTable[liIndex]);

      aStream.Write(lColor, SizeOf(Longword));

      // limit to how many colors you can define
      if liIndex > 55 then Exit;

    end;

end;

class procedure TppBifWriterDefColWidth.Write(aStream: TStream; aWidth: Integer);
var
  lDefColWidthRec: TppBifDefColWidthRec;
begin

  // initialize
  FillChar(lDefColWidthRec, SizeOf(TppBifDefColWidthRec), 0);

  lDefColWidthRec.DefaultWidth := aWidth; // number of O chars using default font

  // write header and data
  WriteHeader(aStream, $0055, SizeOf(TppBifDefColWidthRec));

  aStream.Write(lDefColWidthRec, SizeOf(TppBifDefColWidthRec));



end;

class procedure TppBifWriterIndex.Write(aStream: TStream; aRowCount: Integer; aColDefPos, aRowBlockPos: Int64; aIndex: TppIntegerCollection);
var
  lIndexRec: TppBifIndexRec;
  liDataSize: Integer;
  liIndex: Integer;
  liAbsolutePos: Longword;
begin

  // initialize
  FillChar(lIndexRec, SizeOf(TppBifIndexRec), 0);

  // calc data size
  liDataSize := SizeOf(TppBifIndexRec) + (SizeOf(Longword) * aIndex.Count);

  // write header and data
  WriteHeader(aStream, $20B, liDataSize);

  lIndexRec.RowMin := 0;
  lIndexRec.RowMax := aRowCount;
  lIndexRec.PosOfDefColWidth := aColDefPos;

  aStream.Write(lIndexRec, SizeOf(TppBifIndexRec));

  // write array of row offsets
  for liIndex := 0 to aIndex.Count - 1 do
    begin
      liAbsolutePos := aIndex[liIndex] + aRowBlockPos;
      aStream.Write(liAbsolutePos, SizeOf(Longword));
    end;

end;

class procedure TppBifWriterColInfo.Write(aStream: TStream; aWorksheetInfo: TppXLSWorksheetInfo);
var
  liIndex: Integer;
begin

  for liIndex := 0 to aWorksheetInfo.ColCount-1 do
    WriteItem(aStream, liIndex, aWorksheetInfo);

end;

class procedure TppBifWriterColInfo.WriteItem(aStream: TStream; aColIndex: Integer; aWorksheetInfo: TppXLSWorksheetInfo);
var
  lColInfoRec: TppBifColInfoRec;
begin

  // initialize
  FillChar(lColInfoRec, SizeOf(TppBifColInfoRec), 0);

  lColInfoRec.ColIndexFirst := aColIndex;
  lColInfoRec.ColIndexLast := aColIndex;
  lColInfoRec.Width := aWorksheetInfo.ColWidths[aColIndex];
  lColInfoRec.XFIndex := $0F; // default cell XF

  // WriteItem header and data
  WriteHeader(aStream, $007D, SizeOf(TppBifColInfoRec));

  aStream.Write(lColInfoRec, SizeOf(TppBifColInfoRec));

end;

class procedure TppBifWriterMargins.Write(aStream: TStream; aWorksSheeInfo: TppXLSWorksheetInfo);
begin

  aWorksSheeInfo.PrinterSetup.Units := utInches;

  // left, right, top, bottom   26, 27, 28, 29
  WriteMargin(aStream, $26, aWorksSheeInfo.PrinterSetup.MarginLeft);
  WriteMargin(aStream, $27, aWorksSheeInfo.PrinterSetup.MarginRight);
  WriteMargin(aStream, $28, aWorksSheeInfo.PrinterSetup.MarginTop);
  WriteMargin(aStream, $29, aWorksSheeInfo.PrinterSetup.MarginBottom);

end;

class procedure TppBifWriterMargins.WriteMargin(aStream: TStream; aRecordId: Word; aMargin: Double);
var
  lMarginRec: TppBifMarginRec;
begin

  // initialize
  FillChar(lMarginRec, SizeOf(TppBifMarginRec), 0);

  lMarginRec.Margin := aMargin;

  // WriteItem header and data
  WriteHeader(aStream, aRecordId, SizeOf(TppBifMarginRec));

  aStream.Write(lMarginRec, SizeOf(TppBifMarginRec));


end;

class procedure TppBifWriterMergedCells.Write(aStream: TStream; aWorksSheeInfo: TppXLSWorksheetInfo);
var
  liIndex: Integer;
  lCellStream: TMemoryStream;
begin

  if (aWorksSheeInfo.MergedCells.Count = 0) then Exit;

  lCellStream := TMemoryStream.Create;

  try

    liIndex := 0;

    while liIndex <  aWorksSheeInfo.MergedCells.Count - 1 do
      begin

        // write block to temp stream
        WriteBlock(lCellStream, aWorksSheeInfo.MergedCells, liIndex);

        // write merged cell recs for block
        WriteRecord(aStream, lCellStream);

        lCellStream.Clear;

      end;

  finally

    lCellStream.Free;

  end;

end;

class procedure TppBifWriterMergedCells.WriteBlock(aStream: TStream; aMergedCells: TppXLSCellRangeCollection; var aIndex: Integer);
const
  cMaxRecordsPerBlock = 1027;
var
  liCount: Integer;
  lCellRangeRec: TppBifCellRangeRec;
begin

  liCount := 0;

  while (aIndex <  aMergedCells.Count) do
    begin

      lCellRangeRec.RowIndexFirst := aMergedCells[aIndex].RowIndexFirst;
      lCellRangeRec.RowIndexLast := aMergedCells[aIndex].RowIndexLast;
      lCellRangeRec.ColIndexFirst := aMergedCells[aIndex].ColIndexFirst;
      lCellRangeRec.ColIndexLast := aMergedCells[aIndex].ColIndexLast;

      aStream.Write(lCellRangeRec, SizeOf(TppBifCellRangeRec));

      Inc(aIndex);
      Inc(liCount);

      if liCount >= cMaxRecordsPerBlock then Break;

    end;

end;

class procedure TppBifWriterMergedCells.WriteRecord(aStream, aCellStream: TStream);
var
  lMergedCellsRec: TppBifMergedCellsRec;
  liDataSize: Integer;
begin

  // write header
  liDataSize := SizeOf(TppBifMergedCellsRec) + aCellStream.Size;

  WriteHeader(aStream, $00E5, liDataSize);

  // write merged cells data
  FillChar(lMergedCellsRec, SizeOf(TppBifMergedCellsRec), 0);

  lMergedCellsRec.Count := aCellStream.Size div SizeOf(TppBifCellRangeRec);

  aStream.Write(lMergedCellsRec, SizeOf(TppBifMergedCellsRec));

  aStream.CopyFrom(aCellStream, 0);

end;

class procedure TppBifWriterPageSetup.Write(aStream: TStream; aPrinterSetup: TppPrinterSetup);
var
  lPageSetupRec: TppBifPageSetupRec;
begin

  // initialize
  FillChar(lPageSetupRec, SizeOf(TppBifPageSetupRec), 0);

  lPageSetupRec.PaperSize := aPrinterSetup.PaperSize;
  lPageSetupRec.Copies := aPrinterSetup.Copies;

  if (Ord(aPrinterSetup.Orientation) = 0) then
    lPageSetupRec.Options := lPageSetupRec.Options or (1 shl 1); // portrait

  lPageSetupRec.FitSheetWidth := 1;
//  lPageSetupRec.ScalingFactor := ;
//  lPageSetupRec.StartPageNo := 0;
//  lPageSetupRec.FitSheetHeight := 0;

  // WriteItem header and data
  WriteHeader(aStream, $00A1, SizeOf(TppBifPageSetupRec));

  aStream.Write(lPageSetupRec, SizeOf(TppBifPageSetupRec));


end;

class procedure TppBifWriterSheetPtr.Write(aStream: TStream);
var
  lSheetPtrRec: TppBifSheetPtrRec;
begin

  // initialize
  FillChar(lSheetPtrRec, SizeOf(lSheetPtrRec), 0);

  lSheetPtrRec.Options :=  lSheetPtrRec.Options or (1 shl 8); // fit prinout to number of pages

    // WriteItem header and data
  WriteHeader(aStream, $0081, SizeOf(lSheetPtrRec));

  aStream.Write(lSheetPtrRec, SizeOf(lSheetPtrRec));

end;


class procedure TppBifWriterCompressedPictures.Write(aStream: TStream);
var
  lCompressedPicturesRec: TppBifCompressPicturesRec;
begin

  FillChar(lCompressedPicturesRec, SizeOf(lCompressedPicturesRec), 0);

  lCompressedPicturesRec.RecordType := $89B;
  lCompressedPicturesRec.Compressed := 1;

  WriteHeader(aStream, $89B, SizeOf(TppBifCompressPicturesRec));

  aStream.Write(lCompressedPicturesRec, SizeOf(TppBifCompressPicturesRec));

end;


end.
