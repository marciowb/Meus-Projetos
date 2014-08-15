{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppRTFDocument;

interface

uses
  Classes,
  Windows,
  Graphics,
  ppDevice,
  ppFormatStyles,
  ppRTFPage,
  ppRTFRendererManager,
  ppRTFObject,
  ppRTFSettings;

type

  TppRTFRTFPageInfo = record
    PageWidth: Integer;
    PageHeight: Integer;
    MarginLeft: Integer;
    MarginTop: Integer;
    MarginRight: Integer;
    MarginBottom: Integer;
    Landscape: Boolean;
  end;

  {@TppRTFDocument

    Represents the document structure of a Richtext file.  The RTFDocument
    consists of a collection of rows each containing a collection of objects.
    These rows and objects are arranged in the proper order to be exported
    effeciently to a RTF document.

    Once all rows and objects have been added for a received page, the
    RTFDocument will write that page to the document stream before beginning the
    next page.}

  TppRTFDocument = class(TObject)
  private
    FColorTable: TppColorTable;
    FDocStream: TStream;
    FFirstPage: Boolean;
    FFontTable: TppFontTable;
    FRTFSettings: TppRTFSettings;
    FReportPage: TppPage;
    FRTFPage: TppRTFPage;
    FRTFRendererManager: TppRTFRendererManager;
    FTempFileName: String;

    procedure AddDrawCommandsToGrid(aPage: TppPage);
    procedure CreateDocStream;
    function  GeneratePageInfo: TppRTFRTFPageInfo;
    procedure NewSection;
    procedure PrepareGrid;
    procedure RenderObject(aRTFObject: TppRTFObject; aID: Integer); overload;
    procedure RenderObject(aRTFObject: TppRTFObject); overload;
    procedure SetRTFSettings(const Value: TppRTFSettings);
    procedure StartNewPage;
    procedure WritePageToStream;
    procedure WriteTabPositions(aRow: TppRTFRow);

  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure GenerateFontTable(aOutputStream: TStream);
    procedure GenerateColorTable(aOutputStream: TStream);
    procedure SaveToStream(aOutputStream: TStream);

    procedure WritePage(aPage: TppPage);

    property DocStream: TStream read FDocStream;
    property RTFSettings: TppRTFSettings read FRTFSettings write SetRTFSettings;

  end;

implementation

uses
  SysUtils,
  Printers,
  ppFilDev,
  ppRTFRenderer,
  ppUtils,
  ppOutlineDrawCommand,
  ppRichTxDrwCmd;

{******************************************************************************
 *
 ** TppRTFDocument
 *
{******************************************************************************}

constructor TppRTFDocument.Create;
begin
  inherited;

  FRTFPage := nil;
  FDocStream := nil;
  FRTFSettings := nil;

  FColorTable := TppColorTable.Create;
  FFontTable := TppFontTable.Create;
  FRTFPage := TppRTFPage.Create;

  FTempFileName := '';

  FRTFRendererManager := TppRTFRendererManager.Create;

  FFirstPage := True;

end;

destructor TppRTFDocument.Destroy;
begin
  FRTFRendererManager.Free;
  FRTFRendererManager := nil;

  FRTFPage.Free;
  FRTFPage := nil;

  FFontTable.Free;
  FFontTable := nil;

  FColorTable.Free;
  FColorTable := nil;

  FDocStream.Free;
  FDocStream := nil;

  if (RTFSettings <> nil) and (RTFSettings.CacheToFile) then
    DeleteFile(FTempFileName);

  inherited;
end;

procedure TppRTFDocument.AddDrawCommandsToGrid(aPage: TppPage);
var
  liIndex: Integer;
begin

  for liIndex := 0 to aPage.DrawCommandCount - 1 do
    if not(aPage.DrawCommands[liIndex] is TppOutlineDrawCommand) then
      if (aPage.DrawCommands[liIndex] is TppDrawRichText) and (RTFSettings.MergeRichText) then
        FRTFPage.AddRTFDrawCommandToRow(aPage.DrawCommands[liIndex])
      else
        FRTFPage.AddDrawCommandToRow(aPage.DrawCommands[liIndex]);

end;

procedure TppRTFDocument.Clear;
begin
  FRTFPage.Clear;

end;

procedure TppRTFDocument.CreateDocStream;
begin
  if RTFSettings.CacheToFile then
    begin
      FTempFileName := ppGetTempFileName(ppGetTempPath, 'tmp');
      FDocStream := TFileStream.Create(FTempFileName, fmCreate);
    end
  else
    FDocStream := TMemoryStream.Create;

end;

procedure TppRTFDocument.GenerateColorTable(aOutputStream: TStream);
var
  liColorRGB: Integer;
  liIndex: Integer;
begin

  //Generate the color table and output to stream
  TppFileDeviceUtils.WriteLine(aOutputStream, '{\colortbl;');

  for liIndex := 0 to FColorTable.Count - 1 do
    begin
      liColorRGB := ColorToRGB(FColorTable[liIndex]);
      TppFileDeviceUtils.WriteMem(aOutputStream, '\red' + AnsiString(IntToStr(GetRValue(liColorRGB))));
      TppFileDeviceUtils.WriteMem(aOutputStream, '\green' + AnsiString(IntToStr(GetGValue(liColorRGB))));
      TppFileDeviceUtils.WriteMem(aOutputStream, '\blue' + AnsiString(IntToStr(GetBValue(liColorRGB))) + ';');
    end;

  TppFileDeviceUtils.WriteMem(aOutputStream, '}' + #13#10);

end;

procedure TppRTFDocument.GenerateFontTable(aOutputStream: TStream);
var
  liIndex: Integer;
begin

  //Generate the font table and output to stream
  TppFileDeviceUtils.WriteLine(aOutputStream, '{\fonttbl');

  for liIndex := 0 to FFontTable.Count - 1 do
    TppFileDeviceUtils.WriteLine(aOutputStream, '{\f' + AnsiString(IntToStr(liIndex)) + ' ' + AnsiString(FFontTable[liIndex].Name) + '}');

  TppFileDeviceUtils.WriteLine(aOutputStream, '}');

end;

function TppRTFDocument.GeneratePageInfo: TppRTFRTFPageInfo;
begin
  Result.PageWidth := TppFileDeviceUtils.MicronsToTwips(FReportPage.PageDef.mmWidth);
  Result.PageHeight := TppFileDeviceUtils.MicronsToTwips(FReportPage.PageDef.mmHeight);
  Result.MarginLeft := TppFileDeviceUtils.MicronsToTwips(FReportPage.PageDef.mmMarginLeft);
  Result.MarginTop := TppFileDeviceUtils.MicronsToTwips(FReportPage.PageDef.mmMarginTop);
  Result.MarginRight := TppFileDeviceUtils.MicronsToTwips(FReportPage.PageDef.mmMarginRight);
  Result.MarginBottom := TppFileDeviceUtils.MicronsToTwips(FReportPage.PageDef.mmMarginBottom);
  Result.Landscape := (FReportPage.PrinterSetup.Orientation = poLandscape);

end;

procedure TppRTFDocument.NewSection;
var
  lPageInfo: TppRTFRTFPageInfo;
begin

  lPageInfo := GeneratePageInfo;

  TppFileDeviceUtils.WriteLine(FDocStream, '\sectd');  //reset section
  TppFileDeviceUtils.WriteMem(FDocStream, '\pgwsxn' + AnsiString(IntToStr(lPageInfo.PageWidth)));      //page width (twips)
  TppFileDeviceUtils.WriteMem(FDocStream, '\pghsxn' + AnsiString(IntToStr(lPageInfo.PageHeight)));     //page height
  TppFileDeviceUtils.WriteMem(FDocStream, '\marglsxn' + AnsiString(IntToStr(lPageInfo.MarginLeft)));   //left margin
  TppFileDeviceUtils.WriteMem(FDocStream, '\margtsxn' + AnsiString(IntToStr(lPageInfo.MarginTop)));    //top margin
  TppFileDeviceUtils.WriteMem(FDocStream, '\margrsxn' + AnsiString(IntToStr(lPageInfo.MarginRight)));  //right margin
  TppFileDeviceUtils.WriteMem(FDocStream, '\margbsxn' + AnsiString(IntToStr(lPageInfo.MarginBottom))); //bottom margin

  if lPageInfo.Landscape then
    TppFileDeviceUtils.WriteMem(FDocStream, '\lndscpsxn');  //landscape mode

end;

procedure TppRTFDocument.PrepareGrid;
begin
  //Sort RTFRTFPage and RTFObjects
  FRTFPage.Sort;

  //Adjust row positions (remove overlap)
  FRTFPage.AdjustRowPositions;

  //Adjust tab positions (remove text overlap)
  FRTFPage.AdjustTabPositions;

  //Allocate empty space by adding empty rows using default row size
  FRTFPage.AllocateTopSpace;
  FRTFPage.AllocateRowSpace;

end;

procedure TppRTFDocument.RenderObject(aRTFObject: TppRTFObject);
begin
  RenderObject(aRTFObject, -1);
end;

procedure TppRTFDocument.RenderObject(aRTFObject: TppRTFObject; aID: Integer);
var
  lRenderer: TppRTFRenderer;
begin

  lRenderer := FRTFRendererManager.GetRendererForDrawCommand(aRTFObject.DrawCommand);
  lRenderer.RTFObject := aRTFObject;
  lRenderer.FontTable := FFontTable;
  lRenderer.ColorTable := FColorTable;
  lRenderer.DocStream := FDocStream;
  lRenderer.RTFSettings := RTFSettings;
  lRenderer.ID := aID;

  lRenderer.RenderToRTF;

end;

procedure TppRTFDocument.SaveToStream(aOutputStream: TStream);
begin
  FDocStream.Position := 0;
  aOutputStream.CopyFrom(FDocStream, FDocStream.Size);

end;

procedure TppRTFDocument.SetRTFSettings(const Value: TppRTFSettings);
begin
  FRTFSettings := Value;

  if FFontTable.Count > 0 then
    FFontTable[0].Assign(FRTFSettings.DefaultFont)
  else
    FFontTable.Add(FRTFSettings.DefaultFont);
end;

procedure TppRTFDocument.StartNewPage;
begin
  TppFileDeviceUtils.WriteLine(DocStream, '\sect');

end;

procedure TppRTFDocument.WritePageToStream;
var
  liIndex1: Integer;
  liIndex2: Integer;
  liFontSize: Integer;
begin

  NewSection;

  //Loop through graphic objects first
  for liIndex1 := 0 to FRTFPage.GraphicObjects.Count - 1 do
    RenderObject(FRTFPage.GraphicObjects.Objects[liIndex1], liIndex1);

  //Loop through each row in the collection and render text
  for liIndex1 := 0 to FRTFPage.Count - 1 do
    begin
      TppFileDeviceUtils.WriteMem(DocStream, '\pard');      //Temporary (end current paragraph)

      liFontSize := FRTFPage[liIndex1].Font.Size * 2;

      TppFileDeviceUtils.WriteLine(DocStream, '\f0\fs' + AnsiString(IntToStr(liFontSize)));

      if FRTFPage[liIndex1].Count > 0 then
        WriteTabPositions(FRTFPage[liIndex1]);

      //Loop through each object in the row and create a renderer for that object
      for liIndex2 := 0 to FRTFPage[liIndex1].Count - 1 do
        RenderObject(FRTFPage.Rows[liIndex1].Objects[liIndex2]);

      TppFileDeviceUtils.WriteMem(DocStream, '\par');       //Temporary (start new paragraph)
    end;

end;

procedure TppRTFDocument.WritePage(aPage: TppPage);
begin
  //Clear any existing page information
  Clear;
  FReportPage := aPage;

  //Initialize Row collection
  FRTFPage.ReportPage := FReportPage;
  FRTFPage.RTFSettings := FRTFSettings;

  if DocStream = nil then
    CreateDocStream;

  //Add each drawcommand to the grid
  AddDrawCommandsToGrid(aPage);

  //Prepare grid to be exported (sort/adjust row positions)
  PrepareGrid;

  //Start new page if needed
  if not(FFirstPage) then
    StartNewPage
  else
    FFirstPage := False;

  //Write RTFObjects to stream
  WritePageToStream;

end;

procedure TppRTFDocument.WriteTabPositions(aRow: TppRTFRow);
var
  liTabPos: Integer;
  liIndex: Integer;
begin

  //Write the list of tab positions to be used with the current paragraph (line).
  for liIndex := 0 to aRow.Count - 1 do
    begin
      liTabPos := Trunc(aRow[liIndex].TabPosition);
      TppFileDeviceUtils.WriteMem(DocStream, '\tx' + AnsiString(IntToStr(liTabPos)));
    end;

  TppFileDeviceUtils.WriteLine(DocStream, '');

end;

end.
