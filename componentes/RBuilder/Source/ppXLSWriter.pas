{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB }

unit ppXLSWriter;

interface

uses
  Windows,
  Classes,
  SysUtils,
  Graphics,
  ppCollectionBase,
  ppUtils,

  ppStructuredStorage,
  ppXLSRecordBif,
  ppXLSRecordMso,
  ppFormatStyles,
  ppXLSWorkbook;

type

  { TppXLSWorkbookWriterBase }
  TppXLSWorkbookWriterBase = class
  private
    FCacheToFile: Boolean;
    FTempFileName: String;
    FWorkbookInfo: TppXLSWorkbookInfo;
  protected
    function CreateTempStream: TStream;
    procedure FreeTempStream(aStream: TStream);
  public
    constructor Create(aWorkbook: TppXLSWorkbookInfo; aCacheToFile: Boolean); virtual;
    property CacheToFile: Boolean read FCacheToFile;
    property WorkbookInfo: TppXLSWorkbookInfo read FWorkbookInfo;
  end;

  { TppXLSWorkBookGlobalsWriter }
  TppXLSWorkBookGlobalsWriter = class(TppXLSWorkbookWriterBase)
  public
    procedure Write(aStream: TStream);
  end;

  { TppXLSWorksheetWriter }
  TppXLSWorksheetWriter = class(TppXLSWorkbookWriterBase)
  private
    FRowStream: TStream;
    FCellStream: TStream;
    FDBCellIndex: TppIntegerCollection;
    FDrawingStream: TStream;
    FIndex: TppIntegerCollection;
    FObjStream: TStream;
    FRowBlockRow1EndPos: Integer;
    FRowBlockStartPos: Integer;
    FRowBlockStartIndex: Integer;

    procedure EndRowBlock;
    // procedure StartRowBlock;

  protected
    procedure WriteRow(aRow: TppXLSRow);
    procedure WriteRows(aRows: TppXLSRowCollection);
    procedure WriteShapeImage(aDrawingImage: TppXLSDrawingImage);
    procedure WriteShapeLine(aDrawingLine: TppXLSDrawingLine);
    procedure WriteShapeRectangle(aXLSDrawingRectangle: TppXLSDrawingRectangle);
    procedure WriteShapeOval(aXLSDrawingOval: TppXLSDrawingOval);
    procedure WriteShapes(aShapes: TppXLSDrawingShapeCollection);

  public
    constructor Create(aWorkbook: TppXLSWorkbookInfo; aCacheToFile: Boolean); override;
    destructor Destroy; override;
    procedure Write(aStream: TStream);
    procedure WritePage(aExcelPage: TppXLSPage);
  end;

  { TppXLSWriter }
  TppXLSWriter = class
  private
    FCacheToFile: Boolean;
    FWorkbookInfo: TppXLSWorkbookInfo;
    FWorkbookGlobalsWriter: TppXLSWorkBookGlobalsWriter;
    FWorksheetWriter: TppXLSWorksheetWriter;
    function GetWorkbookGlobalsWriter: TppXLSWorkBookGlobalsWriter;
    function GetWorksheetWriter: TppXLSWorksheetWriter;

  protected
  public
    constructor Create;
    destructor Destroy; override;

    procedure SaveToFile(aFileName: String);
    procedure SaveToStream(aStream: TStream);

    procedure WritePage(aExcelPage: TppXLSPage);
    procedure WriteRow(aRow: TppXLSRow);
    property CacheToFile: Boolean read FCacheToFile write FCacheToFile;
    property WorkbookInfo: TppXLSWorkbookInfo read FWorkbookInfo;

  end;

implementation

constructor TppXLSWriter.Create;
begin

  inherited Create;

  FWorkbookInfo := TppXLSWorkbookInfo.Create;


end;

destructor TppXLSWriter.Destroy;
begin

  FWorkbookGlobalsWriter.Free;
  FWorkbookGlobalsWriter := nil;

  FWorksheetWriter.Free;
  FWorksheetWriter := nil;

  FWorkbookInfo.Free;
  FWorkbookInfo := nil;

  inherited;

end;

function TppXLSWriter.GetWorkbookGlobalsWriter: TppXLSWorkBookGlobalsWriter;
begin

  // create on demand
  if (FWorkbookGlobalsWriter = nil) then
    FWorkbookGlobalsWriter := TppXLSWorkBookGlobalsWriter.Create(FWorkbookInfo, FCacheToFile);

  Result := FWorkbookGlobalsWriter;

end;

function TppXLSWriter.GetWorksheetWriter: TppXLSWorksheetWriter;
begin
  if (FWorksheetWriter = nil) then
    FWorksheetWriter := TppXLSWorksheetWriter.Create(FWorkbookInfo, FCacheToFile);

  Result := FWorksheetWriter;
end;

procedure TppXLSWriter.SaveToFile(aFileName: String);
var
  lStorage: TppStructuredStorage;
  lStorageStream: TppStructuredStorageStream;
  lDocSummaryStorage: TppDocumentSummaryStorage;
begin

  lStorage := TppStructuredStorage.Create(aFileName, amReadWrite, smExclusive, tmDirect, True);

  try

    // write document
    lStorageStream := TppStructuredStorageStream.Create('Workbook', lStorage, amWrite, True);

    try

      GetWorkbookGlobalsWriter.Write(lStorageStream);

      GetWorksheetWriter.Write(lStorageStream);

    finally

      lStorageStream.Free;

    end;

    // write doc summary info
    lDocSummaryStorage := TppDocumentSummaryStorage.Create(lStorage);

    try

      lDocSummaryStorage.Write();
    finally
      lDocSummaryStorage.Free;

    end;

  finally
    lStorage.Free;

  end;

end;


procedure TppXLSWriter.SaveToStream(aStream: TStream);
var
  lsTempFileName: String;
  lFileStream: TFileStream;
begin

  // save to temp file
  lsTempFileName := ppGetTempFileName(ppGetTempPath, 'xls');

  SaveToFile(lsTempFileName);

  if not FileExists(lsTempFileName) then Exit;

  // copy to aStream
  lFileStream := TFileStream.Create(lsTempFilename, fmOpenReadWrite or fmShareExclusive);

  try

    aStream.CopyFrom(lFileStream, 0);
  finally
    lFileStream.Free;

    DeleteFile(lsTempFileName);

  end;


end;


{

 // this code tries to avoid using a temp file, but does not work
procedure TppXLSWriter.SaveToStream(aStream: TStream);
var
  lStorage: TppStructuredStorage;
  lStorageStream: TppStructuredStorageStream;
  lDocSummaryStorage: TppDocumentSummaryStorage;
begin

  lStorage := TppStructuredStorage.Create('', amReadWrite, smExclusive, tmDirect, True);

  try

    // write document
    lStorageStream := TppStructuredStorageStream.Create('Workbook', lStorage, amReadWrite, True);

    try

      FWorkbookGlobalsWriter.Write(lStorageStream);

      FWorksheetWriter.Write(lStorageStream);

      aStream.CopyFrom(lStorageStream, 0);

    finally

      lStorageStream.Free;

    end;

    // write doc summary info
    lDocSummaryStorage := TppDocumentSummaryStorage.Create(lStorage);

    try

      lDocSummaryStorage.Write();
    finally
      lDocSummaryStorage.Free;

    end;

  finally
    lStorage.Free;

  end;

end;

}


procedure TppXLSWriter.WritePage(aExcelPage: TppXLSPage);
begin

  GetWorksheetWriter.WritePage(aExcelPage);

end;

procedure TppXLSWriter.WriteRow(aRow: TppXLSRow);
begin

  GetWorksheetWriter.WriteRow(aRow);

end;

constructor TppXLSWorkbookWriterBase.Create(aWorkbook: TppXLSWorkbookInfo; aCacheToFile: Boolean);
begin

  inherited Create;

  FWorkbookInfo := aWorkbook;
  FCacheToFile := aCacheToFile;

end;

function TppXLSWorkbookWriterBase.CreateTempStream: TStream;
begin

  if FCacheToFile then
    begin
      FTempFileName := ppGetTempFileName(ppGetTempPath, 'tmp');
      Result := TFileStream.Create(FTempFileName, fmCreate);
    end

  else
    Result := TMemoryStream.Create;

end;

procedure TppXLSWorkbookWriterBase.FreeTempStream(aStream: TStream);
begin

  aStream.Free;

  if (FTempFileName <> '') then
    DeleteFile(FTempFileName);

end;

constructor TppXLSWorksheetWriter.Create(aWorkbook: TppXLSWorkbookInfo; aCacheToFile: Boolean);
begin
  inherited;

  FRowBlockStartIndex := -1;
  FCellStream := CreateTempStream;
  FRowStream := CreateTempStream;
  FDrawingStream := CreateTempStream;
  FObjStream := CreateTempStream;
  FDBCellIndex := TppIntegerCollection.Create;
  FIndex := TppIntegerCollection.Create;

end;

destructor TppXLSWorksheetWriter.Destroy;
begin

  FreeTempStream(FCellStream);
  FreeTempStream(FRowStream);
  FreeTempStream(FDrawingStream);
  FreeTempStream(FObjStream);

  FCellStream := nil;
  FRowStream := nil;
  FDrawingStream := nil;
  FObjStream := nil;

  FDBCellIndex.Free;
  FDBCellIndex := nil;

  FIndex.Free;
  FIndex := nil;

  inherited;
end;

procedure TppXLSWorksheetWriter.EndRowBlock;
var
  liOffsetFirstRow: Integer;
  liStartCellPos: Integer;
  liOffSetFirstCell: Integer;
begin

  if (FCellStream.Size = 0) then
    Exit;

  liStartCellPos := FRowStream.Position;

  // append cell stream to row stream
  FRowStream.CopyFrom(FCellStream, 0);

  // calc offset from first dbcell rec back to first row record (positive number)
  liOffsetFirstRow := FRowStream.Position - FRowBlockStartPos;

  // calc offset from end of first row rec to first cell rec
  liOffSetFirstCell := liStartCellPos - FRowBlockRow1EndPos;

  // update DBCellIndex with the offset to first cell
  FDBCellIndex.Insert(0, liOffSetFirstCell);

  // delete record added by last row
  FDBCellIndex.Delete(FDBCellIndex.Count - 1);

  FIndex.Add(FRowStream.Position);

  // write db cell records to row stream
  TppBifWriterDBCell.Write(FRowStream, liOffsetFirstRow, FDBCellIndex);

  // clear
  FRowBlockStartIndex := -1;
  FRowBlockStartPos := 0;
  FRowBlockRow1EndPos := 0;
  FCellStream.Size := 0;
  FDBCellIndex.Clear;

end;

{
  procedure TppXLSWorksheetWriter.StartRowBlock;
  begin


  end;
}
procedure TppXLSWorksheetWriter.Write(aStream: TStream);
var
  liIndexPos: Int64;
  liColWidthPos: Int64;
  liRowBlockPos: Int64;
  liSavePos: Int64;
begin

  // commit last row block
  EndRowBlock;

  // update drawing container info
  if (FDrawingStream.Size > 0) then
    begin
      FDrawingStream.Position := SizeOf(TppBifHeaderRec);
      TppBifWriterMsoDrawing.WriteContainer(FDrawingStream, WorkbookInfo.Worksheetinfo.DrawingContainerInfo);
    end;

  // bof
  TppBifWriterBof.WriteBofWorksheet(aStream);

  liIndexPos := aStream.Position;

  // index
  TppBifWriterIndex.Write(aStream, WorkbookInfo.Worksheetinfo.RowCount, 0, 0, FIndex);

  // sheet ptr (if want fit to page width)
  // TppBifWriterSheetPtr.Write(aStream);

  // margins
  TppBifWriterMargins.Write(aStream, WorkbookInfo.Worksheetinfo);

  // page setup
  TppBifWriterPageSetup.Write(aStream, WorkbookInfo.Worksheetinfo.PrinterSetup);

  // default row height
  TppBifWriterDefaultRowHeight.Write(aStream, WorkbookInfo.Worksheetinfo.DefaultRowHeight);

  liColWidthPos := aStream.Position;

  // default col width
  TppBifWriterDefColWidth.Write(aStream, WorkbookInfo.Worksheetinfo.DefaultColWidth);

  // col info
  TppBifWriterColInfo.Write(aStream, WorkbookInfo.Worksheetinfo);

  // dimension
  TppBifWriterDimension.Write (aStream, 0, 0, WorkbookInfo.Worksheetinfo.RowCount, WorkbookInfo.Worksheetinfo.ColCount);

  liRowBlockPos := aStream.Position;

  // rows
  aStream.CopyFrom(FRowStream, 0);

  // mergegd cells
  TppBifWriterMergedCells.Write(aStream, WorkbookInfo.Worksheetinfo);

  // drawings
  aStream.CopyFrom(FDrawingStream, 0);

  // obj
  aStream.CopyFrom(FObjStream, 0);

  // worksheet view settings  (window2)
  TppBifWriterWorksheetViewSettings.Write(aStream);

  // eof
  TppBifWriterEof.Write(aStream);

  liSavePos := aStream.Position;

  aStream.Position := liIndexPos;

  // index - adjusted
  TppBifWriterIndex.Write(aStream, WorkbookInfo.Worksheetinfo.RowCount, liColWidthPos, liRowBlockPos, FIndex);

  aStream.Position := liSavePos;

end;

procedure TppXLSWorksheetWriter.WritePage(aExcelPage: TppXLSPage);
begin

  WriteRows(aExcelPage.Rows);

  WriteShapes(aExcelPage.Shapes);

end;

// dbcell info - see page 93
procedure TppXLSWorksheetWriter.WriteRow(aRow: TppXLSRow);
var
  liIndex: Integer;
  liCellOffSet: Int64;
  liCellStartPos: Int64;
begin

  if FRowBlockStartIndex = -1 then
  begin
    FRowBlockStartIndex := aRow.RowIndex;
    FRowBlockStartPos := FRowStream.Position;
  end;

  // write row rec to row stream
  TppBifWriterRow.Write(FRowStream, WorkbookInfo, aRow);

  if (FRowBlockStartIndex = aRow.RowIndex) then
    FRowBlockRow1EndPos := FRowStream.Position;

  liCellStartPos := FCellStream.Position;

  // write cell recs to cell stream
  for liIndex := 0 to aRow.Count - 1 do
  begin

    TppBifWriterCell.Write(FCellStream, WorkbookInfo, aRow.Cells[liIndex]);
    // (or get render and delegate to the renderer)

  end;

  // update DBDCellIndex with cell offset for this row
  liCellOffSet := FCellStream.Position - liCellStartPos;

  FDBCellIndex.Add(liCellOffSet);

  // determine whether to end the row block
  if (aRow.RowIndex - FRowBlockStartIndex) = 31 then
    EndRowBlock;

end;

procedure TppXLSWorksheetWriter.WriteRows(aRows: TppXLSRowCollection);
var
  liIndex: Integer;
begin

  for liIndex := 0 to aRows.Count - 1 do
    WriteRow(aRows[liIndex]);

end;

procedure TppXLSWorksheetWriter.WriteShapeImage(aDrawingImage: TppXLSDrawingImage);
var
  liStartPos: Integer;
  lDrawingContanerInfo: TppXLSDrawingContainerInfo;
begin

  liStartPos := FDrawingStream.Position;

  lDrawingContanerInfo := WorkbookInfo.Worksheetinfo.DrawingContainerInfo;

  // for first shape, must write the drawing container
  if (FDrawingStream.Size = 0) then
    TppBifWriterMsoDrawing.WriteContainer(FDrawingStream, lDrawingContanerInfo, aDrawingImage)
  else
    TppBifWriterMsoDrawing.WriteShapeImage(FDrawingStream, aDrawingImage);

  if liStartPos = 0 then
    liStartPos := SizeOf(TppBifHeaderRec) + SizeOf(TppMsofbHeaderRec)
  else
    liStartPos := liStartPos + SizeOf(TppBifHeaderRec);


  lDrawingContanerInfo.StreamedSize := lDrawingContanerInfo.StreamedSize + (FDrawingStream.Position - liStartPos);

  // write Bif Obj
  TppBifWriterObjPicture.Write(FDrawingStream, aDrawingImage);

end;

procedure TppXLSWorksheetWriter.WriteShapeLine(aDrawingLine: TppXLSDrawingLine);
begin
  TppBifWriterObjLine.Write(FObjStream, aDrawingLine);
end;

procedure TppXLSWorksheetWriter.WriteShapeRectangle(aXLSDrawingRectangle: TppXLSDrawingRectangle);
begin
  TppBifWriterObjRectangle.Write(FObjStream, aXLSDrawingRectangle);
end;

procedure TppXLSWorksheetWriter.WriteShapeOval(aXLSDrawingOval: TppXLSDrawingOval);
begin
  TppBifWriterObjOval.Write(FObjStream, aXLSDrawingOval);
end;

procedure TppXLSWorksheetWriter.WriteShapes(aShapes: TppXLSDrawingShapeCollection);
var
  liIndex: Integer;
  lShape: TppXLSDrawingShape;
begin

  for liIndex := 0 to aShapes.Count - 1 do
    begin
      lShape := aShapes[liIndex];

      // image
      if (lShape is TppXLSDrawingImage) then
        WriteShapeImage(TppXLSDrawingImage(lShape))

      // line
      else if (lShape is TppXLSDrawingLine) then
        WriteShapeLine(TppXLSDrawingLine(lShape))

      // oval
      else if (lShape is TppXLSDrawingOval) then
        WriteShapeOval(TppXLSDrawingOval(lShape))

      // rectangle
      else if (lShape is TppXLSDrawingRectangle) then
        WriteShapeRectangle(TppXLSDrawingRectangle(lShape));

    end;

end;

procedure TppXLSWorkBookGlobalsWriter.Write(aStream: TStream);
var
  liBoundSheetPos: Longword;
  liSavePos: Longword;
begin

  // bof
  TppBifWriterBof.WriteBofWorkbookGlobals(aStream);

  // window settings
  TppBifWriterWindowSettings.Write(aStream);

  // date mode
  TppBifWriterDateMode.Write(aStream);

  // font table
  TppBifWriterFontTable.Write(aStream, FWorkbookInfo.FormatStyles);

  // display format table
  TppBifWriterFormatTable.Write(aStream, FWorkbookInfo.FormatStyles);

  // extended format table
  TppBifWriterXFTable.Write(aStream, FWorkbookInfo.FormatStyles);

  // named style table
  TppBifWriterStyleTable.Write(aStream, FWorkbookInfo.FormatStyles);

  // write palette (color table)
  TppBifWriterPalette.Write(aStream, FWorkbookInfo.FormatStyles.Colors);

  // worksheet index
  // TODO: need a SheetTable structure
  liBoundSheetPos := TppBifWriterSheetTable.Write(aStream);

  // drawing group - shared images (b-store)
  TppBifWriterMsoDrawingGroup.Write(aStream, FWorkbookInfo.DrawingGroupInfo);

  // shared string table
  TppBifWriterSharedStringTable.Write(aStream, FWorkbookInfo.StringTable);

  // auto picture compression mode (used for a test, not needed)
//  TppBifWriterCompressedPictures.Write(aStream);

  // eof
  TppBifWriterEof.Write(aStream);

  // update bound sheet with BOF for the sheet stream
  liSavePos := aStream.Position;

  aStream.Position := liBoundSheetPos;
  aStream.Write(liSavePos, SizeOf(Longword));

  aStream.Position := liSavePos;

end;

end.
