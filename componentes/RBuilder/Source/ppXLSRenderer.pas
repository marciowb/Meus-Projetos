
{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppXLSRenderer;

interface

uses
  Classes,
  SysUtils,
  Graphics,
  ExtCtrls,
  Forms,
  Variants,
  ppCharacter,

  ppTypes,
  ppUtils,
  ppDevice,
  ppFilDev,
  ppDrwCmd,
  ppRichTxDrwCmd,
  ppFormatStyles,
  ppXLSWorkbook,
  ppXLSSettings;

type

  TppXLSRendererClass = class of TppXLSRenderer;

  TppXLSRendererType = (erCell, erDrawing);


 {
     DrawCommands -- Renderers

     DrawText     - RendererText
     DrawRichText - RendererRichText
     DrawImage    - RendererImage
     DrawLine     - RendererLine
     DrawShape    - RendererShape
     DrawCommand  - RendererGeneric

 }

  {TppXLSRenderer

      Abstract ancestor. Defines properties and methods common to all XLS Renderers

  }
  TppXLSRenderer = class
  private
    FXLSPage: TppXLSPage;
    FWorkBookInfo: TppXLSWorkbookInfo;
    FWorkSheetInfo: TppXLSWorksheetInfo;
    FXLSSettings: TppXLSSettings;
    function GetPropRendererType: TppXLSRendererType;
  protected
    class function GetDrawCommandSortOrder(aDrawCommand: TppDrawCommand; aXLSSettings: TppXLSSettings; aZOrder: Integer = 0): string;

  public
    class function GetRendererType(aXLSSettings: TppXLSSettings): TppXLSRendererType; virtual; abstract;
    class function DrawCommandClass: TppDrawCommandClass; virtual; abstract;
    class procedure GetDrawCommandsForExport(aPage: TppPage; aXLSSettings: TppXLSSettings; var aDrawCommands: TStringList); virtual;
    procedure RenderToXLS(aDrawCommand: TppDrawCommand); virtual; abstract;

    property RendererType: TppXLSRendererType read GetPropRendererType;
    property XLSPage: TppXLSPage read FXLSPage write FXLSPage;
    property WorkBookInfo: TppXLSWorkbookInfo read FWorkBookInfo write FWorkBookInfo;
    property WorkSheetInfo: TppXLSWorksheetInfo read FWorkSheetInfo write FWorkSheetInfo;
    property XLSSettings: TppXLSSettings read FXLSSettings write FXLSSettings;

  end;

  {TppXLSRendererCell

    - abstract ancestor for cell renderers
  }
  TppXLSRendererCell = class(TppXLSRenderer)
  private
    FXLSRow: TppXLSRow;
  protected
    function AddCell(aDrawCommand: TppDrawCommand): TppXLSCell; virtual;
  public
    class function GetRendererType(aXLSSettings: TppXLSSettings): TppXLSRendererType; override;
    property XLSRow: TppXLSRow read FXLSRow write FXLSRow;
  end;


  {TppXLSRendererText

     - Renderer for plain text
  }
  TppXLSRendererText = class(TppXLSRendererCell)
  public
    class function DrawCommandClass: TppDrawCommandClass; override;
    class procedure GetDrawCommandsForExport(aPage: TppPage; aXLSSettings: TppXLSSettings; var aDrawCommands: TStringList); override;
    procedure RenderToXLS(aDrawCommand: TppDrawCommand); override;
  end;


  {TppXLSRendererRichText

     - Renderer for RichText
     - Splits DrawRichText into DrawRichTextLines
     - Delegates rendering to TppXLSRendererRichTextLine

  }
  TppXLSRendererRichText = class(TppXLSRendererCell)
  public
    class function DrawCommandClass: TppDrawCommandClass; override;
    class procedure GetDrawCommandsForExport(aPage: TppPage; aXLSSettings: TppXLSSettings; var aDrawCommands: TStringList); override;
    class function GetRendererType(aXLSSettings: TppXLSSettings): TppXLSRendererType; override;
    procedure RenderToXLS(aDrawCommand: TppDrawCommand); override;
  end;


  {TppXLSRendererRichTextLine

      - Renderer for a single RichText Line
  }
  TppXLSRendererRichTextLine = class(TppXLSRendererRichText)
  public
    class function DrawCommandClass: TppDrawCommandClass; override;
    class procedure GetDrawCommandsForExport(aPage: TppPage; aXLSSettings: TppXLSSettings; var aDrawCommands: TStringList); override;
    procedure RenderToXLS(aDrawCommand: TppDrawCommand); override;
  end;

  {TppXLSRendererDrawing

     - abstract ancestor for drawing renderers
  }
  TppXLSRendererDrawing = class(TppXLSRenderer)
  private
    function GetCol1IndexForDrawCommand(aDrawCommand: TppDrawCommand): Integer;
    function GetCol2IndexForDrawCommand(aDrawCommand: TppDrawCommand): Integer;
    function GetDy1ValueForDrawCommand(aDrawCommand: TppDrawCommand; aRowIndex: Integer): Integer;
    function GetDx1ValueForDrawCommand(aDrawCommand: TppDrawCommand; aColIndex: Integer): Integer;
    function GetDx2ValueForDrawCommand(aDrawCommand: TppDrawCommand; aColIndex: Integer): Integer;
    function GetDy2ValueForDrawCommand(aDrawCommand: TppDrawCommand; aRowIndex: Integer): Integer;
    function GetRow1IndexForDrawCommand(aDrawCommand: TppDrawCommand): Integer;
    function GetRow2IndexForDrawCommand(aDrawCommand: TppDrawCommand): Integer;
  protected
    procedure CalcXLSDrawingPosition(aDrawCommand: TppDrawCommand; aXLSDrawingShape: TppXLSDrawingShape); virtual;
  public
    class function GetRendererType(aXLSSettings: TppXLSSettings): TppXLSRendererType; override;
  end;

  { TppXLSRendererImage }
  TppXLSRendererImage = class(TppXLSRendererDrawing)
  public
    class function DrawCommandClass: TppDrawCommandClass; override;
    procedure RenderToXLS(aDrawCommand: TppDrawCommand); override;
  end;

  { TppXLSRendererGeneric }
  TppXLSRendererGeneric = class(TppXLSRendererDrawing)
  public
    class function DrawCommandClass: TppDrawCommandClass; override;
    function GetComponentType(aDrawCommand: TppDrawCommand): TppExportComponentType;
    class procedure GetDrawCommandsForExport(aPage: TppPage; aXLSSettings: TppXLSSettings; var aDrawCommands: TStringList); override;
    procedure RenderToXLS(aDrawCommand: TppDrawCommand); override;
  end;

  { TppXLSRendererLine }
  TppXLSRendererLine = class(TppXLSRendererDrawing)
  protected
    function GenerateXLSDrawingLine(aDrawLine: TppDrawLine): TppXLSDrawingLine;
    function GenerateXLSDrawingLineOffSet(aDrawLine: TppDrawLine): TppXLSDrawingLine;
    procedure CalcXLSDrawingPosition(aDrawCommand: TppDrawCommand; aXLSDrawingShape: TppXLSDrawingShape); override;
  public
    class function DrawCommandClass: TppDrawCommandClass; override;
    procedure RenderToXLS(aDrawCommand: TppDrawCommand); override;
  end;

  { TppXLSRendererShape }
  TppXLSRendererShape = class(TppXLSRendererDrawing)
  protected
    procedure CalcXLSDrawingPosition(aDrawCommand: TppDrawCommand; aXLSDrawingShape: TppXLSDrawingShape); override;
    function GetXLSFillPattern(aBrushStyle: TBrushStyle): Integer;
  public
    class function DrawCommandClass: TppDrawCommandClass; override;
    procedure RenderToXLS(aDrawCommand: TppDrawCommand); override;
  end;


implementation

uses
  ppXLSDevice,
  ppXLSRendererManager,
  ppOutlineDrawCommand,
  ppBarCodDrwCmd,
  ppBarCode2DDrawCmd;

class procedure TppXLSRenderer.GetDrawCommandsForExport(aPage: TppPage; aXLSSettings: TppXLSSettings; var aDrawCommands: TStringList);
var
  lDrawCommand: TppDrawCommand;
  liDrawCommand: Integer;
begin

  for liDrawCommand := 0 to aPage.DrawCommandCount - 1 do
    begin
      if not(aPage.DrawCommands[liDrawCommand] is DrawCommandClass) then Continue;

      lDrawCommand := aPage.DrawCommands[liDrawCommand];

      aDrawCommands.AddObject(GetDrawCommandSortOrder(lDrawCommand, aXLSSettings, liDrawCommand), lDrawCommand);

    end;

end;

class function TppXLSRenderer.GetDrawCommandSortOrder(aDrawCommand: TppDrawCommand; aXLSSettings: TppXLSSettings; aZOrder: Integer = 0): string;
var
  lsPrefix: String;
begin

  if GetRendererType(aXLSSettings) = erCell  then
    lsPrefix := 'A'
  else
    lsPrefix := 'B' + Format('%8d', [aZOrder]);

  Result := lsPrefix + Format('%8d',[aDrawCommand.Top]) + Format('%8d',[aDrawCommand.Left]);


end;

function TppXLSRenderer.GetPropRendererType: TppXLSRendererType;
begin
  Result := GetRendererType(XLSSettings);
end;

class function TppXLSRendererText.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawText;
end;

class procedure TppXLSRendererText.GetDrawCommandsForExport(aPage: TppPage; aXLSSettings: TppXLSSettings; var aDrawCommands: TStringList);
var
  lDrawText: TppDrawText;
  lDrawMemo: TppDrawText;
  liDrawCommand: Integer;
  liIndex: Integer;
  liTop: Integer;
  liFontHeight: Integer;
  liLineHeight: Integer;
begin

  for liDrawCommand := 0 to aPage.DrawCommandCount - 1 do
    begin
      if not(aPage.DrawCommands[liDrawCommand] is TppDrawText) then Continue;

      lDrawText := TppDrawText(aPage.DrawCommands[liDrawCommand]);

      if not(lDrawText.IsMultiLine) then
        aDrawCommands.AddObject(GetDrawCommandSortOrder(lDrawText, aXLSSettings), lDrawText)
      else
        begin

          lDrawMemo := lDrawText;

          // calc line height
          liLineHeight := Round(lDrawMemo.Height / lDrawMemo.WrappedText.Count);

          // calc font height
          liFontHeight := ppGetSpTextHeight(lDrawMemo.Font, 'O');
          liFontHeight := Round(ppFromScreenPixels(liFontHeight, utMMThousandths, pprtVertical, nil));

          // use smaller of the two
          //   - LineHeight works best for stretchable memos
          //   - FontHeight works for static memo in which text does not fill the bounds
          if (liFontHeight < liLineHeight) then
            liLineHeight := liFontHeight;

          liTop := lDrawMemo.Top;

          for liIndex := 0 to lDrawMemo.WrappedText.Count - 1 do
            begin
              lDrawText := TppDrawText.Create(lDrawMemo);
              lDrawText.Text := lDrawMemo.WrappedText[liIndex];
              lDrawText.Font := lDrawMemo.Font;
              lDrawText.Transparent := lDrawMemo.Transparent;
              lDrawText.Color := lDrawMemo.Color;
              lDrawText.Height := liLineHeight;
              lDrawText.Left := lDrawMemo.Left;
              lDrawText.Top := liTop;
              lDrawText.Width := lDrawMemo.Width;
              lDrawText.TextAlignment := lDrawMemo.TextAlignment;
              lDrawText.WordWrap := True;
              lDrawText.DataType := lDrawMemo.DataType;

              aDrawCommands.AddObject(GetDrawCommandSortOrder(lDrawText, aXLSSettings), lDrawText);

              liTop := liTop + liLineHeight + 1;

            end;

        end;

    end;


end;

procedure TppXLSRendererText.RenderToXLS(aDrawCommand: TppDrawCommand);
begin

  if not(ecText in XLSSettings.ExportComponents) then Exit;


  AddCell(aDrawCommand);

end;

class function TppXLSRendererRichText.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawRichText;
end;

class procedure TppXLSRendererRichText.GetDrawCommandsForExport(aPage: TppPage; aXLSSettings: TppXLSSettings; var aDrawCommands: TStringList);
var
  lDrawRichText: TppDrawRichText;
  lDrawRichTextLine: TppDrawRichTextLine;
  liDrawCommand: Integer;
  liIndex: Integer;
begin

  for liDrawCommand := 0 to aPage.DrawCommandCount - 1 do
    begin

      if not(aPage.DrawCommands[liDrawCommand] is TppDrawRichText) then Continue;

      lDrawRichText := TppDrawRichText(aPage.DrawCommands[liDrawCommand]);

      if aXLSSettings.ExportRTFAsBitmap then
        aDrawCommands.AddObject(GetDrawCommandSortOrder(lDrawRichText, aXLSSettings, liDrawCommand), lDrawRichText)
      else
        begin

          for liIndex := 0 to lDrawRichText.Lines.Count - 1 do
           begin
             lDrawRichTextLine := lDrawRichText.Lines[liIndex];

             aDrawCommands.AddObject(GetDrawCommandSortOrder(lDrawRichTextLine, aXLSSettings), lDrawRichTextLine);

           end;

        end;

    end;


end;

class function TppXLSRendererRichText.GetRendererType(aXLSSettings: TppXLSSettings): TppXLSRendererType;
begin
  if aXLSSettings.ExportRTFAsBitmap then
    Result := erDrawing
  else
    Result := erCell;
end;

procedure TppXLSRendererRichText.RenderToXLS(aDrawCommand: TppDrawCommand);
var
  lGenericRenderer: TppXLSRendererGeneric;
begin

  if not(XLSSettings.ExportRTFAsBitmap) then Exit;

  if not(ecRichText in XLSSettings.ExportComponents) then Exit;

  // use generic renderer to render as bitmap
  lGenericRenderer := TppXLSRendererGeneric.Create;

  try

    lGenericRenderer.XLSPage := XLSPage;
    lGenericRenderer.WorkBookInfo := WorkbookInfo;
    lGenericRenderer.WorkSheetInfo := WorksheetInfo;
    lGenericRenderer.XLSSettings := XLSSettings;

    lGenericRenderer.RenderToXLS(aDrawCommand);

  finally

    lGenericRenderer.Free;

  end;

end;

class function TppXLSRendererRichTextLine.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawRichTextLine;
end;

class procedure TppXLSRendererRichTextLine.GetDrawCommandsForExport(aPage: TppPage; aXLSSettings: TppXLSSettings; var aDrawCommands: TStringList);
begin

  // do nothing

end;

procedure TppXLSRendererRichTextLine.RenderToXLS(aDrawCommand: TppDrawCommand);
var
  lRichTextLine: TppDrawRichTextLine;
  lDrawText: TppDrawText;
  liIndex: Integer;
  lFormatRuns: TppStringFormatRuns;
  lDrawItem: TppDrawText;
  lCell: TppXLSCell;
begin
  if XLSSettings.ExportRTFAsBitmap then Exit;

  if not(ecRichText in XLSSettings.ExportComponents) then Exit;

  if not(aDrawCommand is TppDrawRichTextLine) then Exit;

  lRichTextLine := TppDrawRichTextLine(aDrawCommand);

  if (lRichTextLine.Items.Count = 0) then Exit;

  lDrawText := TppDrawText.Create(nil);

  lDrawText.Assign(lRichTextLine);

  lDrawItem := lRichTextLine.Items[0];

  lDrawText.Font := lDrawItem.Font;
  lDrawText.Text := lDrawItem.Text;

  SetLength(lFormatRuns, lRichTextLine.Items.Count-1);

  for liIndex := 1 to lRichTextLine.Items.Count-1 do
    begin

      lDrawItem := lRichTextLine.Items[liIndex];

      // add format run
      lFormatRuns[liIndex-1].CharIndex := Length(lDrawText.Text) - 1;
      lFormatRuns[liIndex-1].FontIndex :=  WorkBookInfo.FormatStyles.GetFontIndex(lDrawItem.Font);

      // add text
      lDrawText.Text := lDrawText.Text + lDrawItem.Text;

    end;

  // draw RichTextLine
  lCell := AddCell(lDrawText);

  // add format runs
  WorkBookInfo.StringTable[lCell.StringIndex].FormatRuns := lFormatRuns;

  lDrawText.Free;

end;

class function TppXLSRendererImage.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawImage;
end;

procedure TppXLSRendererImage.RenderToXLS(aDrawCommand: TppDrawCommand);
var
  lXLSDrawingImage: TppXLSDrawingImage;
  lImageDrawCommand: TppDrawImage;
begin

  if not(ecImage in XLSSettings.ExportComponents) then Exit;

  lImageDrawCommand := TppDrawImage(aDrawCommand);

  if (lImageDrawCommand.Picture.Graphic = nil) then Exit;

  lXLSDrawingImage := TppXLSDrawingImage.Create;

  // calc position (do this first)
  CalcXLSDrawingPosition(lImageDrawCommand, lXLSDrawingImage);

  lXLSDrawingImage.Bounds := lImageDrawCommand.DrawRect;

  lXLSDrawingImage.Graphic := lImageDrawCommand.Picture.Graphic;
  lXLSDrawingImage.ImageName := lImageDrawCommand.ImageName;

  if not(lImageDrawCommand.Stretch) or (lImageDrawCommand.MaintainAspectRatio) then
    begin
      lXLSDrawingImage.Graphic := TppFileDeviceUtils.DrawCommandToBitmap(aDrawCommand, 100, clWhite);
      lXLSDrawingImage.OwnsGraphic := True;
    end;


  // add image to page
  FXLSPage.Shapes.Add(lXLSDrawingImage);


end;

function TppXLSRendererCell.AddCell(aDrawCommand: TppDrawCommand): TppXLSCell;
var
  liColumnIndex: Integer;
  lXLSCell: TppXLSCell;
  liDrawPos: Integer;
  lDrawText: TppDrawText;
  lbMergeCells: Boolean;
  lFrac: Double;
begin

  Result := nil;

  if (aDrawCommand.Value = Null) and not(aDrawCommand.DataType in [dtString, dtMemo, dtChar]) then Exit;

  liDrawPos := aDrawCommand.DrawLeft; // default

  lbMergeCells := True; // always merge cells

  if not lbMergeCells and (aDrawCommand is TppDrawText) then
    begin
      lDrawText := TppDrawText(aDrawCommand);

      if (lDrawText.DataType in [dtString, dtMemo, dtChar]) then
        begin
          case lDrawText.TextAlignment of
            taLeftJustified: ; // nothing

            taCentered:
               liDrawPos := aDrawCommand.DrawLeft + (aDrawCommand.DrawWidth div 2);

            taRightJustified:
               liDrawPos := aDrawCommand.DrawRight;

          end;

        end;

    end;


  // map Left to ColumnIndex
  liColumnIndex := (liDrawPos div (FWorksheetInfo.DefaultColWidth * 256));

  // check for overlapping cells
  if (XLSRow.Count > 0) and (liColumnIndex <= XLSRow.Cells[XLSRow.Count-1].ColumnIndex) then
   liColumnIndex := XLSRow.Cells[XLSRow.Count-1].ColumnIndex + 1;

   // convert boolean values to string
   // xls does not handle boolean formatting very well
  if (aDrawCommand.DataType = dtBoolean) then
    begin
      aDrawCommand.DataType := dtString;
      aDrawCommand.DisplayFormat := '';
      aDrawCommand.Value := TppDrawText(aDrawCommand).Text;
    end;


  aDrawCommand.DisplayFormat := FWorkbookInfo.FormatStyles.GetDefaultDisplayFormat(aDrawCommand);

  // add format style
  FWorkbookInfo.FormatStyles.Add(aDrawCommand);

  // add cell
  lXLSCell := FXLSRow.Add;
  lXLSCell.ColumnIndex := liColumnIndex;
  lXLSCell.DataType := aDrawCommand.DataType;

  lXLSCell.Value := aDrawCommand.Value;

  lXLSCell.FormatIndex := FWorkbookInfo.FormatStyles.GetElementFormatIndex(aDrawCommand);

  // add to string table
  if (aDrawCommand.DataType in [dtString, dtMemo, dtChar]) then
    lXLSCell.StringIndex := FWorkbookInfo.StringTable.Add(aDrawCommand.Value);

  // calc cell range (i.e. number of cells required for width)

  if lbMergeCells or not(aDrawCommand.DataType in [dtString, dtMemo]) then
    lXLSCell.ColumnRange := Round(aDrawCommand.DrawWidth / (FWorksheetInfo.DefaultColWidth * 256));

  if not(aDrawCommand.DataType in [dtString, dtMemo]) and (TppDrawText(aDrawCommand).AutoSize) then
//  if (aDrawCommand.DataType in [dtDateTime, dtDate, dtTime]) then
    begin
      lFrac := Frac(aDrawCommand.DrawWidth / (FWorksheetInfo.DefaultColWidth * 256));
      if (lFrac > 0) and (lFrac < 0.5) then
        lXLSCell.ColumnRange := lXLSCell.ColumnRange + 1;
    end;


//  if not(aDrawCommand.DataType in [dtString, dtMemo]) then
//    lXLSCell.ColumnRange := lXLSCell.ColumnRange + 1;

  // max row height
  if (aDrawCommand.DrawHeight > FXLSRow.Height) then
    FXLSRow.Height := aDrawCommand.DrawHeight;

  Result := lXLSCell;


end;

class function TppXLSRendererCell.GetRendererType(aXLSSettings: TppXLSSettings): TppXLSRendererType;
begin
  Result := erCell;
end;

procedure TppXLSRendererDrawing.CalcXLSDrawingPosition(aDrawCommand: TppDrawCommand; aXLSDrawingShape: TppXLSDrawingShape);
begin

  // calc row/col positions (Left, Top, Right, Bottom)
  aXLSDrawingShape.Row1 := GetRow1IndexForDrawCommand(aDrawCommand);
  aXLSDrawingShape.Col1 := GetCol1IndexForDrawCommand(aDrawCommand);
  aXLSDrawingShape.Row2 := GetRow2IndexForDrawCommand(aDrawCommand);
  aXLSDrawingShape.Col2 := GetCol2IndexForDrawCommand(aDrawCommand);

  // calc cell offsets (Left, Top, Right, Bottom)
  aXLSDrawingShape.Dx1 := GetDx1ValueForDrawCommand(aDrawCommand, aXLSDrawingShape.Col1);
  aXLSDrawingShape.Dy1 := GetDy1ValueForDrawCommand(aDrawCommand, aXLSDrawingShape.Row1);
  aXLSDrawingShape.Dx2 := GetDx2ValueForDrawCommand(aDrawCommand, aXLSDrawingShape.Col2);
  aXLSDrawingShape.Dy2 := GetDy2ValueForDrawCommand(aDrawCommand, aXLSDrawingShape.Row2);

end;

function TppXLSRendererDrawing.GetRow1IndexForDrawCommand(aDrawCommand: TppDrawCommand): Integer;
var
  liIndex: Integer;
  lRow: TppXLSRow;
begin

  liIndex := 0;
  Result := -1;

  while (Result < 0) and (liIndex < XLSPage.Rows.Count) do
    begin
      lRow := XLSPage.Rows[liIndex];

      if (aDrawCommand.DrawTop < (lRow.Top + lRow.Height)) then
        Result := lRow.RowIndex
      else
        Inc(liIndex);

    end;

end;

function TppXLSRendererDrawing.GetCol1IndexForDrawCommand(aDrawCommand: TppDrawCommand): Integer;
begin

  Result := (aDrawCommand.DrawLeft div (FWorksheetInfo.DefaultColWidth * 256));

end;

function TppXLSRendererDrawing.GetCol2IndexForDrawCommand(aDrawCommand: TppDrawCommand): Integer;
begin

  Result := Round(aDrawCommand.DrawRight div (FWorksheetInfo.DefaultColWidth * 256));


end;

function TppXLSRendererDrawing.GetDy1ValueForDrawCommand(aDrawCommand: TppDrawCommand; aRowIndex: Integer): Integer;
var
  lRow: TppXLSRow;
begin

  lRow := XLSPage.Rows.ByAbsoluteIndex[aRowIndex];
  Result := aDrawCommand.DrawTop - lRow.Top;

  // convert to 1024ths cell height
//  Result := Result * 1024 div lRow.Height;


end;

function TppXLSRendererDrawing.GetDx1ValueForDrawCommand(aDrawCommand: TppDrawCommand; aColIndex: Integer): Integer;
//var
//  liCellWidth: Integer;
begin

  // return - 0, so that objects will align with cell data
  Result := 0;

{  liCellWidth := (FWorksheetInfo.DefaultColWidth * 256);

  Result := aDrawCommand.DrawLeft - (liCellWidth * aColIndex);

  // convert to 1024ths cell width
  Result := Result * 1024 div liCellWidth;
}
end;

function TppXLSRendererDrawing.GetDx2ValueForDrawCommand(aDrawCommand: TppDrawCommand; aColIndex: Integer): Integer;
//var
//  liCellWidth: Integer;
begin
  // return - 0, so that objects will align with cell data
  Result := 0;

{  liCellWidth := (FWorksheetInfo.DefaultColWidth * 256);

  Result := aDrawCommand.DrawRight - (liCellWidth * aColIndex);

  // convert to 1024ths cell width
  Result := Result * 1024 div liCellWidth;
}
end;

function TppXLSRendererDrawing.GetDy2ValueForDrawCommand(aDrawCommand: TppDrawCommand; aRowIndex: Integer): Integer;
var
  lRow: TppXLSRow;
begin

  lRow := XLSPage.Rows.ByAbsoluteIndex[aRowIndex];
  Result := aDrawCommand.DrawBottom - lRow.Top;

  // convert to 1024ths cell height
//  Result := Result * 1024 div lRow.Height;

end;

function TppXLSRendererDrawing.GetRow2IndexForDrawCommand(aDrawCommand: TppDrawCommand): Integer;
var
  liIndex: Integer;
  lRow: TppXLSRow;
begin

  liIndex := 0;
  Result := -1;

  while (Result < 0) and (liIndex < XLSPage.Rows.Count) do
    begin
      lRow := XLSPage.Rows[liIndex];

      if (aDrawCommand.DrawBottom < (lRow.Top + lRow.Height)) then
        Result := lRow.RowIndex
      else
        Inc(liIndex);

    end;

end;

class function TppXLSRendererDrawing.GetRendererType(aXLSSettings: TppXLSSettings): TppXLSRendererType;
begin
  Result := erDrawing;
end;

class function TppXLSRendererGeneric.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawCommand;
end;

function TppXLSRendererGeneric.GetComponentType(aDrawCommand: TppDrawCommand): TppExportComponentType;
begin

  if (aDrawCommand is TppDrawBarCode) then
    Result := ecBarCode
  else if (aDrawCommand is TppDraw2DBarCode) then
    Result := ecBarCode
  else
    Result := ecOther;

end;

class procedure TppXLSRendererGeneric.GetDrawCommandsForExport(aPage: TppPage; aXLSSettings: TppXLSSettings; var aDrawCommands: TStringList);
var
  liIndex: Integer;
  lDrawCommand: TppDrawCommand;
  lRendererClass: TppXLSRendererClass;
begin

  for liIndex := 0 to aPage.DrawCommandCount - 1 do
    begin
      lDrawCommand := TppDrawCommand(aPage.DrawCommands[liIndex]);

      if (lDrawCommand is TppOutlineDrawCommand) then Continue;

      lRendererClass := TppXLSRendererManager.GetRendererClass(TppDrawCommandClass(lDrawCommand.ClassType));

      if (lRendererClass = Self) then
        aDrawCommands.AddObject(GetDrawCommandSortOrder(lDrawCommand, aXLSSettings, liIndex), lDrawCommand);

    end;

end;

procedure TppXLSRendererGeneric.RenderToXLS(aDrawCommand: TppDrawCommand);
var
  lXLSDrawingImage: TppXLSDrawingImage;
  lImage: TGraphic;
  lComponentType: TppExportComponentType;
begin

  lComponentType := GetComponentType(aDrawCommand);

  if not(lComponentType in XLSSettings.ExportComponents)  then Exit;

  lXLSDrawingImage := TppXLSDrawingImage.Create;

  // calc position (do this first)
  CalcXLSDrawingPosition(aDrawCommand, lXLSDrawingImage);

  lXLSDrawingImage.ImageName := ppCreateGuidString;
  lXLSDrawingImage.Bounds := aDrawCommand.DrawRect;

  lImage := nil;

  if (lComponentType = ecBarCode) then
    begin
      if (aDrawCommand is TppDrawBarCode) then
        lImage := TppDrawBarCode(aDrawCommand).AsMetaFile
      else if (aDrawCommand is TppDraw2DBarCode) then
        lImage := TppDraw2DBarCode(aDrawCommand).AsMetaFile;
    end;

    // warning: calling this re-scales the drawcommand vertices
  if (lImage = nil) then
    lImage := TppFileDeviceUtils.DrawCommandToBitmap(aDrawCommand, 100, clWhite);

  lXLSDrawingImage.OwnsGraphic := True;
  lXLSDrawingImage.Graphic := lImage;

  // add shape to page
  FXLSPage.Shapes.Add(lXLSDrawingImage);


end;


class function TppXLSRendererLine.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawLine;
end;

procedure TppXLSRendererLine.CalcXLSDrawingPosition(aDrawCommand: TppDrawCommand; aXLSDrawingShape: TppXLSDrawingShape);
var
  lLinePosition: TppLinePositionType;
  lDrawingLine: TppXLSDrawingLine;
  liOffset: Integer;
begin



  lLinePosition := TppDrawLine(aDrawCommand).LinePosition;
  lDrawingLine := TppXLSDrawingLine(aXLSDrawingShape);

  liOffset := Round(TppDrawLine(aDrawCommand).Weight * 20) div 2;  //20 twips per point

  case lLinePosition of
    lpTop:
      begin
        aDrawCommand.DrawTop := aDrawCommand.DrawTop + liOffSet;
        aDrawCommand.DrawBottom := aDrawCommand.DrawTop;
      end;
    lpBottom:
      begin
        aDrawCommand.DrawBottom := aDrawCommand.DrawBottom - liOffSet;
        aDrawCommand.DrawTop := aDrawCommand.DrawBottom;
      end;
    lpLeft:
      begin
//        aDrawCommand.DrawLeft := aDrawCommand.DrawLeft + liOffSet;
        aDrawCommand.DrawRight := aDrawCommand.DrawLeft;
      end;
    lpRight:
      begin
//        aDrawCommand.DrawRight := aDrawCommand.DrawRight - liOffSet;
        aDrawCommand.DrawLeft := aDrawCommand.DrawRight;
      end;
    lpDiagLeft:
      lDrawingLine.Quadrant := 0; // left to right
    lpDiagRight:
      lDrawingLine.Quadrant := 1; // right to left

  end;

  inherited;

end;


function TppXLSRendererLine.GenerateXLSDrawingLine(aDrawLine: TppDrawLine): TppXLSDrawingLine;
var
  lXLSDrawingLine: TppXLSDrawingLine;
begin
  lXLSDrawingLine := TppXLSDrawingLine.Create;

  lXLSDrawingLine.Bounds := aDrawLine.DrawRect;
  lXLSDrawingLine.LineColorIndex := WorkBookInfo.FormatStyles.GetColorIndex(aDrawLine.Pen.Color);
  lXLSDrawingLine.LineStyle := Ord(aDrawLine.Pen.Style);
  lXLSDrawingLine.LineWeight := Round(aDrawLine.Weight);

  // calc position
  CalcXLSDrawingPosition(aDrawLine, lXLSDrawingLine);

  Result := lXLSDrawingLine;

end;

function TppXLSRendererLine.GenerateXLSDrawingLineOffSet(aDrawLine: TppDrawLine): TppXLSDrawingLine;
var
  liOffset: Integer;
begin

  liOffset := Round(aDrawLine.Weight * 20);  //20 twips per point

  if (aDrawLine.LinePosition in [lpLeft, lpRight]) then
    liOffset := Trunc(liOffset * WorkbookInfo.FormatStyles.GetDefaultFontWidthScale);

  if not(aDrawLine.LinePosition in [lpDiagLeft, lpDiagRight]) then
    liOffset := liOffset * 2;

  case aDrawLine.LinePosition of
    lpTop:
      aDrawLine.DrawTop  := aDrawLine.DrawTop  + liOffset;
    lpBottom:
      aDrawLine.DrawBottom := aDrawLine.DrawBottom - liOffset;
    lpLeft:
      aDrawLine.DrawLeft := aDrawLine.DrawLeft  + liOffset;

    lpRight:
      aDrawLine.DrawRight := aDrawLine.DrawRight - liOffset;
    lpDiagLeft:
      begin
        aDrawLine.DrawLeft := aDrawLine.DrawLeft  + liOffset;
        aDrawLine.DrawBottom := aDrawLine.DrawBottom  - liOffset;
      end;
    lpDiagRight:
      begin
        aDrawLine.DrawRight := aDrawLine.DrawRight - liOffset;
        aDrawLine.DrawTop := aDrawLine.DrawTop  + liOffset;
      end;
  end;

  Result := GenerateXLSDrawingLine(aDrawLine);

end;

procedure TppXLSRendererLine.RenderToXLS(aDrawCommand: TppDrawCommand);
var
  lDrawLine: TppDrawLine;
  lXLSDrawingLine: TppXLSDrawingLine;
begin

  if not(ecLine in XLSSettings.ExportComponents) then Exit;

  lDrawLine := TppDrawLine(aDrawCommand);

  lXLSDrawingLine := GenerateXLSDrawingLine(lDrawLine);

  // add line to page
  FXLSPage.Shapes.Add(lXLSDrawingLine);

  if (lDrawLine.LineStyle = lsDouble) then
    begin
      lXLSDrawingLine := GenerateXLSDrawingLineOffSet(lDrawLine);

      // add line to page
      FXLSPage.Shapes.Add(lXLSDrawingLine);

    end;


end;

procedure TppXLSRendererShape.CalcXLSDrawingPosition(aDrawCommand: TppDrawCommand; aXLSDrawingShape: TppXLSDrawingShape);
begin

  if (TppDrawShape(aDrawCommand).ShapeType in [stSquare, stRoundSquare, stCircle]) then
    begin
      // force width = height
      if (aDrawCommand.DrawHeight > aDrawCommand.DrawWidth) then
        aDrawCommand.DrawBottom := aDrawCommand.DrawTop + aDrawCommand.DrawWidth
      else
        aDrawCommand.DrawRight := aDrawCommand.DrawLeft + aDrawCommand.DrawHeight;
    end;


  inherited;

end;

class function TppXLSRendererShape.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawShape;
end;

function TppXLSRendererShape.GetXLSFillPattern(aBrushStyle: TBrushStyle): Integer;
begin
  case aBrushStyle of
    bsSolid:
      Result := 1;
    bsClear:
      Result := 0;
    else
      Result := Ord(aBrushStyle) + 9;

    // same as the above
{    bsHorizontal:
      Result := 11;
    bsVertical:
      Result := 12;
    bsFDiagonal:
      Result := 13;
    bsBDiagonal:
      Result := 14;
    bsCross:
      Result := 15;
    bsDiagCross:
      Result := 16;
}
  end;

end;

procedure TppXLSRendererShape.RenderToXLS(aDrawCommand: TppDrawCommand);
var
  lDrawShape: TppDrawShape;
  lXLSDrawingRectangle: TppXLSDrawingRectangle;
begin

  if not(ecShape in XLSSettings.ExportComponents) then Exit;

  lDrawShape := TppDrawShape(aDrawCommand);

  if (lDrawShape.ShapeType in [stEllipse, stCircle]) then
    lXLSDrawingRectangle := TppXLSDrawingOval.Create
  else
    lXLSDrawingRectangle := TppXLSDrawingRectangle.Create;

  // calc position
  CalcXLSDrawingPosition(lDrawShape, lXLSDrawingRectangle);

  lXLSDrawingRectangle.FillColorIndex := WorkBookInfo.FormatStyles.GetColorIndex(lDrawShape.Brush.Color);
  lXLSDrawingRectangle.FillPattern := GetXLSFillPattern(lDrawShape.Brush.Style);
  lXLSDrawingRectangle.LineColorIndex := WorkBookInfo.FormatStyles.GetColorIndex(lDrawShape.Pen.Color);
  lXLSDrawingRectangle.LineStyle := Ord(lDrawShape.Pen.Style);
  lXLSDrawingRectangle.LineWeight := Round(TppFileDeviceUtils.PixelsToPoints(lDrawShape.Pen.Width, Screen.PixelsPerInch));
  lXLSDrawingRectangle.RoundedCorners := (lDrawShape.ShapeType in [stRoundRect, stRoundSquare, stCircle, stEllipse]);

  // add shape to page
  FXLSPage.Shapes.Add(lXLSDrawingRectangle);


end;

initialization

  TppXLSRendererManager.RegisterRenderer(TppXLSRendererText);
  TppXLSRendererManager.RegisterRenderer(TppXLSRendererRichText);
  TppXLSRendererManager.RegisterRenderer(TppXLSRendererRichTextLine);
  TppXLSRendererManager.RegisterRenderer(TppXLSRendererImage);
  TppXLSRendererManager.RegisterRenderer(TppXLSRendererLine);
  TppXLSRendererManager.RegisterRenderer(TppXLSRendererShape);
  TppXLSRendererManager.RegisterRenderer(TppXLSRendererGeneric);

finalization

  TppXLSRendererManager.UnregisterRenderer(TppXLSRendererText);
  TppXLSRendererManager.UnregisterRenderer(TppXLSRendererRichText);
  TppXLSRendererManager.UnRegisterRenderer(TppXLSRendererRichTextLine);
  TppXLSRendererManager.UnRegisterRenderer(TppXLSRendererImage);
  TppXLSRendererManager.UnRegisterRenderer(TppXLSRendererLine);
  TppXLSRendererManager.UnRegisterRenderer(TppXLSRendererShape);
  TppXLSRendererManager.UnRegisterRenderer(TppXLSRendererGeneric);

end.
