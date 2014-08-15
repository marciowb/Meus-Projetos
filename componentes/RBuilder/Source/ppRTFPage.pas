{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppRTFPage;

interface

uses
  Classes,
  Windows,
  Graphics,
  ppCollectionBase,
  ppDevice,
  ppDrwCmd,
  ppRTFObject,
  ppRTFSettings,
  ppPrintr;

const
  cTwipsPerPoint = 20;

type

  TppRTFObjectCollection = class;
  TppRTFRow = class;

  {@TppRTFRowCollection

    Abstract ancestor of the TppRTFPage class.}

  TppRTFRowCollection = class(TppCollectionBase)
  private
    function GetRows(Index: Integer): TppRTFRow;

  public
    function  Add: TppRTFRow; overload; virtual;
    function  Add(aRow: TppRTFRow): Integer; overload; virtual;
    function  Insert(aIndex: Integer): TppRTFRow; overload; virtual;
    function  Insert(aIndex: Integer; aRow: TppRTFRow): TppRTFRow; overload; virtual;

    procedure Clear; override;
    procedure Sort;

    property Rows[Index: Integer]: TppRTFRow read GetRows; default;
  end;

  {@TppRTFPage

    Container object for all RTFRow objects in a received page.  This class
    manages the vertical spacing of the RTF document first creating rows to
    hold each object, then calculating the "best fit" scenario for each row
    based on the limitations of a text document.}

  TppRTFPage = class(TppRTFRowCollection)
  private
    FDefaultRowHeight: Integer;
    FGraphicObjects: TppRTFObjectCollection;
    FRTFSettings: TppRTFSettings;
    FReportPage: TppPage;
    FFontError: Double;
    FPrinter: TppPrinter;

    procedure CreateNewRow(aRTFObject: TppRTFObject);
    function  CalcFontHeight(aFont: TFont): Integer;
    function  CalcLeading(aFont: TFont): Integer;
    function  GetTextMetric(aFont: TFont): TTextMetric;
    function  GetRowFontSize(aRow: TppRTFRow): Integer;
    function  GetObjectForTextCommand(aDrawText: TppDrawText; aIndex: Integer): TppRTFTextObject; overload;
    function  GetObjectForTextCommand(aDrawText: TppDrawText): TppRTFTextObject; overload;
    function  GetTextTabPosition(aDrawText: TppDrawText): Integer;
    procedure SetReportPage(aPage: TppPage);
    procedure SetRTFSettings(aRTFSettings: TppRTFSettings);
    procedure AddObjectToRow(aRTFObject: TppRTFObject);
    function  GetLineHeight(aDrawText: TppDrawText): Integer;
    procedure NormalizeRow(aRow: TppRTFRow; aObject: TppRTFObject);

  public
    constructor Create; override;
    destructor  Destroy; override;

    function  Add: TppRTFRow; override;
    function  Insert(aIndex: Integer): TppRTFRow; override;
    procedure AddDrawCommandToRow(aDrawCommand: TppDrawCommand);
    procedure AddRTFDrawCommandToRow(aDrawCommand: TppDrawCommand);
    procedure AdjustRowPositions;
    procedure AdjustTabPositions;
    procedure AllocateTopSpace;
    procedure AllocateRowSpace;
    procedure Clear; override;

    property GraphicObjects: TppRTFObjectCollection read FGraphicObjects;
    property RTFSettings: TppRTFSettings read FRTFSettings write SetRTFSettings;
    property ReportPage: TppPage read FReportPage write SetReportPage;

  end;

  {@TppRTFObjectCollection

    Abstract ancestor of the TppRTFRow class.}

  TppRTFObjectCollection = class(TppCollectionBase)
  private
    function GetObjects(Index: Integer): TppRTFObject;

  public
    constructor Create; override;

    function Add: TppRTFObject; overload; virtual;
    function Add(aObject: TppRTFObject): Integer; overload; virtual;

    property Objects[Index: Integer]: TppRTFObject read GetObjects; default;
  end;

  {@TppRTFRow

    Represents a line of text inside a Richtext document.  The height of a row
    is determined by the text object with the largest font inside the row.}

  TppRTFRow = class(TppRTFObjectCollection)
  private
    FHeight: Integer;
    FRowIndex: Integer;
    FTop: Integer;
    FFont: TFont;

    function  GetBottom: Integer;
    procedure SetFont(aFont: TFont);

  public
    constructor Create; override;
    destructor Destroy; override;

    function  Add(aObject: TppRTFObject): Integer; override;
    function  ContainsWrappedText: Integer;
    procedure Sort;

    property Bottom: Integer read GetBottom;
    property Height: Integer read FHeight write FHeight;
    property RowIndex: Integer read FRowIndex write FRowIndex;
    property Top: Integer read FTop write FTop;
    property Font: TFont read FFont write SetFont;

  end;

implementation

uses
  ppRTFDocument,
  ppFilDev,
  ppRichTxDrwCmd;

{******************************************************************************
 *
 ** Sort Routines
 *
{******************************************************************************}

function CompareRTFRows(aRow1, aRow2: Pointer): Integer;
begin
  if TppRTFRow(aRow1).Top > TppRTFRow(aRow2).Top then
    Result := 1
  else if TppRTFRow(aRow1).Top < TppRTFRow(aRow2).Top then
    Result := -1
  else
    Result := 0;

end;

function CompareRTFObjects(aObject1, aObject2: Pointer): Integer;
begin
  if TppRTFObject(aObject1).TabPosition > TppRTFObject(aObject2).TabPosition then
    Result := 1
  else if TppRTFObject(aObject1).TabPosition < TppRTFObject(aObject2).TabPosition then
    Result := -1
  else
    Result := 0;

end;

{******************************************************************************
 *
 ** TppRTFPage
 *
{******************************************************************************}

constructor TppRTFPage.Create;
begin
  inherited;

  InnerList.OwnsObjects := True;

  FGraphicObjects := TppRTFObjectCollection.Create;
  FGraphicObjects.InnerList.OwnsObjects := True;

  FPrinter := TppPrinter.Create;
  FReportPage := nil;

  FFontError := 0;

end;

destructor TppRTFPage.Destroy;
begin
  FPrinter.Free;
  FPrinter := nil;

  FGraphicObjects.Free;
  FGraphicObjects := nil;

  inherited;
end;

function TppRTFPage.CalcLeading(aFont: TFont): Integer;
var
  lTextMetric: TTextMetric;
  liLeading: Integer;
begin

  lTextMetric := GetTextMetric(aFont);

  liLeading := lTextMetric.tmExternalLeading;

  Result := TppFileDeviceUtils.PixelsToTwips(liLeading, FPrinter.PixelsPerInch.Y);

end;

procedure TppRTFPage.Clear;
begin
  inherited;

  FGraphicObjects.Clear;

end;

procedure TppRTFPage.CreateNewRow(aRTFObject: TppRTFObject);
var
  lRTFRow: TppRTFRow;
begin

  lRTFRow := Add;  //create a new row
  lRTFRow.Top := aRTFObject.Top;
  lRTFRow.Height := aRTFObject.Height;
  lRTFRow.Add(aRTFObject);

  if aRTFObject is TppRTFTextObject then
    lRTFRow.Font := TppRTFTextObject(aRTFObject).Font;

end;

function TppRTFPage.Add: TppRTFRow;
begin
  Result := inherited Add;
  Result.Font := RTFSettings.DefaultFont;

end;

procedure TppRTFPage.AddDrawCommandToRow(aDrawCommand: TppDrawCommand);
var
  lRTFObject: TppRTFObject;
  liIndex: Integer;
begin

  //Create a new object for each drawcommand.
  if (aDrawCommand is TppDrawText) then
    begin
      if TppDrawText(aDrawCommand).IsMultiLine then
        //Create multiple objects for multi-line text objects
        for liIndex := 0 to TppDrawText(aDrawCommand).WrappedText.Count - 1 do
          AddObjectToRow(GetObjectForTextCommand(TppDrawText(aDrawCommand), liIndex))
      else
        AddObjectToRow(GetObjectForTextCommand(TppDrawText(aDrawCommand)));

    end
  else
    begin
      //Create a new generic RTFObject for non-text components
      lRTFObject := TppRTFObject.Create;
      lRTFObject.DrawCommand := aDrawCommand;
      lRTFObject.TabPosition := TppFileDeviceUtils.MicronsToTwips(aDrawCommand.Left);
      lRTFObject.Top := TppFileDeviceUtils.MicronsToTwips(aDrawCommand.Top);
      lRTFObject.Width := TppFileDeviceUtils.MicronsToTwips(aDrawCommand.Width);
      lRTFObject.Height := FDefaultRowHeight;

      FGraphicObjects.Add(lRTFObject);

  end;

end;

procedure TppRTFPage.AddObjectToRow(aRTFObject: TppRTFObject);
var
  liIndex: Integer;
  lRTFRow: TppRTFRow;
  ldTopThreshold: Double;
  ldBottomThreshold: Double;
  lbFound: Boolean;
begin

  liIndex := 0;
  lbFound := False;

  while (liIndex <= Count - 1) and not(lbFound) do
    begin
      lRTFRow := Rows[liIndex];
      ldTopThreshold := lRTFRow.Top;
      ldBottomThreshold := lRTFRow.Top + (lRTFRow.Height / 2);

      //Check if object fits in an existing row
      if (aRTFObject.Top >= ldTopThreshold) and (aRTFObject.Top <= ldBottomThreshold) or
         (aRTFObject.Top < ldTopThreshold) and ((aRTFObject.Bottom - ldTopThreshold) > (aRTFObject.Height / 2)) then
        begin                                 //if the object is in the top half of the current row, or more than half of the object is in the row.
          lbFound := True;
          lRTFRow.Add(aRTFObject);
          NormalizeRow(lRTFRow, aRTFObject);
        end
      else if (aRTFObject.Top > ldBottomThreshold) and (aRTFObject.Top < lRTFRow.Bottom) then
        aRTFObject.Top := lRTFRow.Bottom;    //if the object is in the bottom half of the current row, move the object down.

      Inc(liIndex);
    end;

  //If no row is found above, create a new row.
  if not(lbFound) then
    CreateNewRow(aRTFObject);

end;

procedure TppRTFPage.AddRTFDrawCommandToRow(aDrawCommand: TppDrawCommand);
var
  lDrawRichText: TppDrawRichText;
  lRichTextObject: TppRTFTextObject;
  lDrawText: TppDrawText;
  liRowIndex: Integer;
  liItemIndex: Integer;
begin

  lDrawRichText := TppDrawRichText(aDrawCommand);

  //Use the metareader to generate drawcommands for the richtext object, then add each command to a row
  for liRowIndex := 0 to lDrawRichText.Lines.Count - 1 do
    for liItemIndex := 0 to lDrawRichText.Lines[liRowIndex].Items.Count - 1 do
      begin
        lDrawText := lDrawRichText.Lines[liRowIndex].Items[liItemIndex];
        lRichTextObject := GetObjectForTextCommand(lDrawText);
        lRichTextObject.Wrapped := True;  //make sure the object is considered wrapped text so the row will be normalized

        if lDrawText.Text <> '' then
          AddObjectToRow(lRichTextObject);
      end;

end;

procedure TppRTFPage.AdjustRowPositions;
var
  liIndex: Integer;
  lRow1: TppRTFRow;
  lRow2: TppRTFRow;
begin

  if Count > 1 then
    for liIndex := 0 to Count - 2 do
      begin
        lRow1 := Rows[liIndex];
        lRow2 := Rows[liIndex + 1];

        //Move row down if there is overlap
        if (lRow2.Top < lRow1.Bottom) then
          lRow2.Top := lRow1.Bottom;
      end;

end;

procedure TppRTFPage.AdjustTabPositions;
var
  liRowIndex: Integer;
  liObjectIndex: Integer;
  lRow: TppRTFRow;
  liBuffer: Integer;
begin

 for liRowIndex := 0 to Count - 1 do
    begin
      lRow := Rows[liRowIndex];

      if (lRow[0].TabPosition = 0) then
        lRow[0].UseTab := False;

      liBuffer := cTwipsPerPoint;  //one point (This may need to be font specific)

      for liObjectIndex := 0 to lRow.Count - 2 do
        if (lRow[liObjectIndex + 1].TabPosition <= lRow[liObjectIndex].Right + liBuffer) then
          lRow[liObjectIndex + 1].UseTab := False;
    end;

end;

procedure TppRTFPage.AllocateRowSpace;
var
  liIndex: Integer;
  liIndex2: Integer;
  liNumRows: Integer;
  liRowIndex: Integer;
  lRow1: TppRTFRow;
  lRow2: TppRTFRow;
  lEmptyRow: TppRTFRow;
  liEmptySpace: Integer;
begin

  if not(Count > 0) then exit;

  liIndex := 0;
  while (liIndex < Count - 1) do
    begin
      if Count <= 1 then exit;
      lRow1 := Rows[liIndex];
      lRow2 := Rows[liIndex + 1];
      liRowIndex := liIndex + 1;  //keep track of the second row's index for later use
      liNumRows := 0;  //Need to reset this every loop

      //Create empty rows if there is extra space
      if (lRow2.Top > lRow1.Bottom) then
        begin
          liEmptySpace := lRow2.Top - lRow1.Bottom;
          liNumRows := Trunc(liEmptySpace / FDefaultRowHeight);

          if  FRTFSettings.UsePrecisionLines and ((liEmptySpace mod FDefaultRowHeight) > cTwipsPerPoint) then  //Add a precision row if needed
            Inc(liNumRows);

          if liNumRows = 0 then
            lRow2.Top := lRow1.Bottom
          else
            begin
              for liIndex2 := liNumRows - 1 downto 0 do
                begin
                  lEmptyRow := Insert(liIndex + 1);
                  if FRTFSettings.UsePrecisionLines and (liIndex2 = 0) and ((liEmptySpace mod FDefaultRowHeight) > cTwipsPerPoint) then
                    begin
                      lEmptyRow.Height := liEmptySpace mod FDefaultRowHeight;
                      lEmptyRow.Font.Size := GetRowFontSize(lEmptyRow);
                    end
                  else
                    lEmptyRow.Height := FDefaultRowHeight;
                  lEmptyRow.Top := Rows[liIndex].Bottom + (FDefaultRowHeight * liIndex2);
                end;
            end;
        end;
      liIndex := liRowIndex + liNumRows;

    end;
end;

procedure TppRTFPage.AllocateTopSpace;
var
  liMarginTop: Integer;
  liEmptySpace: Integer;
  liNumRows: Integer;
  liIndex: Integer;
  lEmptyRow: TppRTFRow;
begin

  if not(Count > 0) then exit;

  //Insert Top empty rows
  liMarginTop := TppFileDeviceUtils.MicronsToTwips(FReportPage.PageDef.mmMarginTop);
  if Rows[0].Top > liMarginTop then
    begin
      liEmptySpace := Rows[0].Top - liMarginTop;
      liNumRows := Trunc(liEmptySpace / FDefaultRowHeight);

      if FRTFSettings.UsePrecisionLines and ((liEmptySpace mod FDefaultRowHeight) > cTwipsPerPoint) then  //Add a precision row if needed
        Inc(liNumRows);

      if liNumRows = 0 then
        Rows[0].Top := liMarginTop
      else
        begin
          for liIndex := 0 to liNumRows - 1 do
            begin
              lEmptyRow := Insert(liIndex);
              lEmptyRow.Height := FDefaultRowHeight;
              if liIndex = 0 then
                begin
                  if FRTFSettings.UsePrecisionLines and ((liEmptySpace mod FDefaultRowHeight) > cTwipsPerPoint) then
                    begin
                      lEmptyRow.Height := liEmptySpace mod FDefaultRowHeight;
                      lEmptyRow.Font.Size := GetRowFontSize(lEmptyRow);
                    end;
                  lEmptyRow.Top := liMarginTop;
                end
              else
                lEmptyRow.Top := Rows[liIndex - 1].Bottom;
            end;
          Rows[liNumRows].Top := Rows[liNumRows - 1].Bottom;
        end;
    end;

end;

function TppRTFPage.CalcFontHeight(aFont: TFont): Integer;
var
  lTextMetric: TTextMetric;
begin

  lTextMetric := GetTextMetric(aFont);

  Result := TppFileDeviceUtils.PixelsToTwips(lTextMetric.tmHeight, FPrinter.PixelsPerInch.Y)

end;

function TppRTFPage.GetLineHeight(aDrawText: TppDrawText): Integer;
var
  liLeading: Integer;
begin

  if not(aDrawText.IsMemo) then
    liLeading := CalcLeading(aDrawText.Font) //Get Leading from the Textmetric structure
  else
    liLeading := TppFileDeviceUtils.MicronsToTwips(aDrawText.Leading); //User defined leading

  Result := CalcFontHeight(aDrawText.Font) + liLeading;

end;

function TppRTFPage.GetObjectForTextCommand(aDrawText: TppDrawText; aIndex: Integer): TppRTFTextObject;
var
  lRTFTextObject: TppRTFTextObject;
begin

  lRTFTextObject := TppRTFTextObject.Create;
  lRTFTextObject.DrawCommand := aDrawText;
  lRTFTextObject.Font := aDrawText.Font;
  lRTFTextObject.LineIndex := aIndex;
  lRTFTextObject.TabPosition := GetTextTabPosition(aDrawText);
  lRTFTextObject.Height := TppFileDeviceUtils.MicronsToTwips(aDrawText.Height);
  lRTFTextObject.Width := TppFileDeviceUtils.MicronsToTwips(aDrawText.Width);

  //aIndex = -1 implies a single line text
  if aIndex >= 0 then
    begin
      //if not FRTFSettings.UsePrecisionLines then
      lRTFTextObject.Height := GetLineHeight(aDrawText);
      lRTFTextObject.Top := TppFileDeviceUtils.MicronsToTwips(aDrawText.Top) + (lRTFTextObject.Height * aIndex);
      lRTFTextObject.Wrapped := True;
    end
  else
    lRTFTextObject.Top := TppFileDeviceUtils.MicronsToTwips(aDrawText.Top);

  Result := lRTFTextObject;

end;

function TppRTFPage.GetObjectForTextCommand(aDrawText: TppDrawText): TppRTFTextObject;
begin
  //create single line text object
  Result := GetObjectForTextCommand(aDrawText, -1);

end;

function TppRTFPage.GetRowFontSize(aRow: TppRTFRow): Integer;
begin

  aRow.Font.Height := -TppFileDeviceUtils.TwipsToPixels(aRow.Height, aRow.Font.PixelsPerInch);

  FFontError := FFontError + (aRow.Height mod cTwipsPerPoint);

  if FFontError >= FRTFSettings.ShiftThreshold then
    begin
      Result := aRow.Font.Size - 1;
      FFontError := 0;
    end
  else
    Result := aRow.Font.Size;

end;

function TppRTFPage.GetTextMetric(aFont: TFont): TTextMetric;
var
  lCanvas: TCanvas;
  lTextMetric: TTextMetric;
begin

  lCanvas := FPrinter.Canvas;
  lCanvas.Font := aFont;

  GetTextMetrics(lCanvas.Handle, lTextMetric);
  Result := lTextMetric;

end;

function TppRTFPage.GetTextTabPosition(aDrawText: TppDrawText): Integer;
var
  liLeft: Integer;
  liRight: Integer;
  liWidth: Integer;
  liTextWidth: Integer;
begin

  FPrinter.Canvas.Font := aDrawText.Font;

  liLeft := TppFileDeviceUtils.MicronsToTwips(aDrawText.Left - FReportPage.PageDef.mmMarginLeft);
  liRight := TppFileDeviceUtils.MicronsToTwips((aDrawText.Left + aDrawText.Width) - FReportPage.PageDef.mmMarginLeft);
  liWidth := TppFileDeviceUtils.MicronsToTwips(aDrawText.Width);
  liTextWidth := TppFileDeviceUtils.PixelsToTwips(FPrinter.Canvas.TextWidth(aDrawText.Text), FPrinter.PixelsPerInch.X);

  //Handle text alignment
  case aDrawText.Alignment of
    taRightJustify: Result := liRight - liTextWidth;
    taCenter: Result := Round(liLeft + (liWidth / 2) - (liTextWidth / 2));
  else
    Result := liLeft;
  end;

end;

function TppRTFPage.Insert(aIndex: Integer): TppRTFRow;
begin
  Result := inherited Insert(aIndex);
  Result.Font := RTFSettings.DefaultFont;

end;

procedure TppRTFPage.NormalizeRow(aRow: TppRTFRow; aObject: TppRTFObject);
var
  liIndex: Integer;
  liWIndex: Integer;
  liFontSize: Integer;
  liRowHeight: Integer;
begin

  liWIndex := aRow.ContainsWrappedText; //Index of the left-most wrapped text object in the row

  if liWIndex >= 0 then
    begin
      //Get the height and font size of the left-most wrapped text object in the row
      liFontSize := TppRTFTextObject(aRow.Objects[liWIndex]).Font.Size;
      liRowHeight := aRow.Objects[liWIndex].Height;

      //Re-assign the height of the row and the font-size of every other object in the row.
      for liIndex := 0 to aRow.Count - 1 do
        begin
          aRow.Height := liRowHeight;
          aRow.Objects[liIndex].Height := liRowHeight;

          if (aRow.Objects[liIndex] is TppRTFTextObject) and  (TppRTFTextObject(aRow.Objects[liIndex]).Font.Size > liFontSize) then
            TppRTFTextObject(aRow.Objects[liIndex]).Font.Size := liFontSize;
        end;
    end
  else
    begin
      if aObject.Height > aRow.Height then
        begin
          aRow.Height := aObject.Height;
            if (aObject is TppRTFTextObject) and (TppRTFTextObject(aObject).Font.Size > aRow.Font.Size) then
              aRow.Font := TppRTFTextObject(aObject).Font;
        end;
    end;

end;

procedure TppRTFPage.SetReportPage(aPage: TppPage);
begin
  FReportPage := aPage;

end;

procedure TppRTFPage.SetRTFSettings(aRTFSettings: TppRTFSettings);
var
  liLeading: Integer;
begin

  FRTFSettings := aRTFSettings;

  liLeading := CalcLeading(FRTFSettings.DefaultFont);
  FDefaultRowHeight := CalcFontHeight(FRTFSettings.DefaultFont) + liLeading;

end;

{******************************************************************************
 *
 ** TppRTFObjectCollection
 *
{******************************************************************************}

constructor TppRTFObjectCollection.Create;
begin

  inherited;

  InnerList.OwnsObjects := True;

end;

function TppRTFObjectCollection.Add: TppRTFObject;
begin
  Result := TppRTFObject.Create;
  Add(Result);

end;

function TppRTFObjectCollection.Add(aObject: TppRTFObject): Integer;
begin
  Result := InnerList.Add(aObject);

end;

function TppRTFObjectCollection.GetObjects(Index: Integer): TppRTFObject;
begin
  Result := TppRTFObject(InnerList[Index]);

end;

{******************************************************************************
 *
 ** TppRTFRow
 *
{******************************************************************************}

function TppRTFRow.Add(aObject: TppRTFObject): Integer;
begin
  aObject.ObjectIndex:= Count + 1;
  Result := inherited Add(aObject);

end;

constructor TppRTFRow.Create;
begin
  inherited;

  FFont := TFont.Create;
end;

destructor TppRTFRow.Destroy;
begin
  FFont.Free;
  FFont := nil;

  inherited;
end;

function TppRTFRow.ContainsWrappedText: Integer;
var
  liIndex: Integer;
  lRTFObject: TppRTFObject;
begin

  Result := -1;

  //Return the index of the left-most wrapped text object in the row.  -1 implies no wrapped text.
  for liIndex := 0 to Count - 1 do
    begin
      lRTFObject := Objects[liIndex];
      if (lRTFObject is TppRTFTextObject) and (TppRTFTextObject(lRTFObject).Wrapped) then
        begin
          Result := liIndex;
          Exit;
        end;
    end;

end;

function TppRTFRow.GetBottom: Integer;
begin
  Result := Top + Height;

end;

procedure TppRTFRow.SetFont(aFont: TFont);
begin
  FFont.Assign(aFont);
end;

procedure TppRTFRow.Sort;
begin
  InnerList.Sort(@CompareRTFObjects);

end;

function TppRTFRowCollection.Add: TppRTFRow;
begin
  Result := TppRTFRow.Create;
  Add(Result);

end;

function TppRTFRowCollection.Add(aRow: TppRTFRow): Integer;
begin
  aRow.RowIndex := Count + 1;
  Result := InnerList.Add(aRow);

end;

procedure TppRTFRowCollection.Clear;
var
  liIndex: Integer;
begin

  for liIndex := 0 to Count - 1 do
    Rows[liIndex].Clear;

  inherited;

end;

function TppRTFRowCollection.GetRows(Index: Integer): TppRTFRow;
begin
  Result := TppRTFRow(InnerList[Index]);

end;

function TppRTFRowCollection.Insert(aIndex: Integer): TppRTFRow;
begin
  Result := TppRTFRow.Create;
  Insert(aIndex, Result);

end;

function TppRTFRowCollection.Insert(aIndex: Integer; aRow: TppRTFRow): TppRTFRow;
begin
  InnerList.Insert(aIndex, aRow);
  Result := TppRTFRow(InnerList[aIndex]);

end;

procedure TppRTFRowCollection.Sort;
var
  liIndex: Integer;
begin

  //Sort Rows by vertical position
  InnerList.Sort(@CompareRTFRows);

  //Sort objects by horizontal position
  for liIndex := 0 to Count - 1 do
    Rows[liIndex].Sort;

end;

end.
