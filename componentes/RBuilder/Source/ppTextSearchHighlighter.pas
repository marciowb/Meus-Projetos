{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchHighlighter;

interface

uses
  Graphics,
  ppDrwCmd, ppDevice, ppTextSearchDrawCommandHighlighter, ppTextSearchOccurrence;

type

  {@TppTextSearchHighlighter

    Finds the search text in the draw command and creates a draw command on top
    to it to effectively show the highlighted text in place.

    Use this class to search a TppDrawText object.

    In order to control the highlight draw command which is created for the actual
    hihglight on the page, create a descendent of this class and override the
    CreateDrawCommand method to create the highlight draw command of your
    choice:

    <Code>
      function TmyDrawTextBoundingBoxHighlighter.CreateDrawCommand: TppDrawCommand;
      var
        lDrawShape: TppDrawShape;
      begin

        lDrawShape := TppDrawShape.Create(nil);
        lDrawShape.ShapeType := stRectangle;
        lDrawShape.RedrawPage := True;
        lDrawShape.Brush.Style := bsClear;
        lDrawShape.Pen.Style := psSolid;
        lDrawShape.Pen.Width := 1;
        lDrawShape.Pen.Color := Color;

        Result := lDrawShape;

      end;
    </Code>}

  TppTextSearchHighlighter  = class(TppTextSearchDrawCommandHighlighter)
    private
      FFullLineText: String;
      FDrawText: TppDrawText;
      FTopPosition: Integer;
      FTextHeight: Integer;
      FTextWidth: Integer;
      FLeftPosition: Integer;
      FSearchText: String;
      FCanvas: TCanvas;
      FOriginalDrawCommandFont: TFont;

      procedure CalculateLeftPosition(aTotalPos, aSearchTextLength: Integer; const aOriginalText: String);
      procedure CalculateTextPosition(const aSearchText: String; aDrawText: TppDrawText; aTextSearchOccurrence: TppTextSearchOccurrence);
      procedure CalculateMemoTextPosition(const aSearchText: String; aDrawText: TppDrawText; aTextSearchOccurrence: TppTextSearchOccurrence);
      procedure CalculateSize(aDrawText: TppDrawText);
      procedure PositionHighlightDrawCommand(aDrawText: TppDrawText; aHighlightDrawCommand: TppDrawCommand);
      procedure Scale(var aHorizontalValue, aVerticalValue: Integer);
      procedure CalculateCenteredLeftPosition(const aOriginalPrefixText, aOriginalPostfixText: String);
      procedure CalculateJustifiedLeftPosition(const aOriginalText, aOriginalPrefixText, aOriginalPostfixText: String);
      procedure CalculateRightJustifiedLeftPosition(const aOriginalPostfixText: String);

    protected
      function CreateDrawCommand: TppDrawCommand; virtual;
      function FindTextInLine(const aSearchText: String; var aText, aPrefixText: String; aSearchTextLength: Integer; var aTotalPos: Integer): Integer; virtual;

      function GetSearchText: String;
      function GetOriginalDrawCommandFont: TFont;

    public
      constructor Create; override;
      destructor Destroy; override;

      function CreateHighlight(aDrawCommand: TppDrawCommand; aTextSearchOccurrence: TppTextSearchOccurrence; aSearchText: String; aCanvas: TCanvas): TppDrawCommand; override;
    end;

    
  {@TppTextSearchHighlighter Class }

  TppTextSearchHighlighterClass = class of TppTextSearchHighlighter ;

implementation

uses
  {$IFDEF Delphi6} Types, {$ENDIF}
  
  ExtCtrls, SysUtils, Windows,
  ppTypes, ppUtils, ppTextSearchError, ppPlainText,
  ppTextSearchToolbox;

{@TppTextSearchHighlighter.Create }

constructor TppTextSearchHighlighter.Create;
begin

  inherited Create;

  FDrawText := nil;
  FCanvas := nil;
  FFullLineText := '';
  FSearchText := '';
  FLeftPosition := 0;
  FTopPosition := 0;
  FTextWidth := 0;
  FTextHeight := 0;
  FOriginalDrawCommandFont := nil;

end;
 
{@TppTextSearchHighlighter.Destroy }

destructor TppTextSearchHighlighter.Destroy;
begin

  inherited Destroy;

end;
   
{@TppTextSearchHighlighter.GetSearchText }

function TppTextSearchHighlighter.GetSearchText: String;
begin
  Result := FSearchText;
end;

{@TppTextSearchHighlighter.CreateHighlight

  Creates a highlight draw command which is added to the current TppPage
  in order to highlight the text in the proper position. The highlight
  draw command is in the correct position as a result of this routine.}

function TppTextSearchHighlighter.CreateHighlight(aDrawCommand: TppDrawCommand; aTextSearchOccurrence: TppTextSearchOccurrence; aSearchText: String; aCanvas: TCanvas): TppDrawCommand;
var
  lToolbox: TppTextSearchToolboxClass;
  lHighlightDrawCommand: TppDrawCommand;
  liPos: Integer;
begin

  inherited CreateHighlight(aDrawCommand, aTextSearchOccurrence, aSearchText, aCanvas);

  if not(aDrawCommand is TppDrawText) then
    raise ESearchHighlightError.Create('TppTextSearchHighlighter.HighlightText: Must pass a TppDrawText object.');

  FDrawText := TppDrawText(aDrawCommand);

  aTextSearchOccurrence.OriginalBackgroundColor := FDrawText.Color;
  aTextSearchOccurrence.OriginalTextColor := FDrawText.Font.Color;

  FCanvas := aCanvas;
  FCanvas.Font := FDrawText.Font;
  FCanvas.Font.Name := TppDeviceSubstitutions.SubstituteFont(FDrawText.Font.Name);

  {save the font from the original draw command so that the highlight draw
  command can use the same font and let the screen device scale the font normally.}
  FOriginalDrawCommandFont := TppDrawText(aDrawCommand).Font;

  {must use a screen device to generate}
  if (FDrawText.DeviceFontHeight = 0) then
    raise ESearchHighlightError.Create('TppTextSearchHighlighter.CreateHighlight: Must use a screen device to generate highlights. ' + aDrawCommand.ClassName);

  FCanvas.Font.Height := FDrawText.DeviceFontHeight;

  if FDrawText.IsMultiLine then
    CalculateMemoTextPosition(aSearchText, FDrawText, aTextSearchOccurrence)
  else
    CalculateTextPosition(aSearchText, FDrawText, aTextSearchOccurrence);

  lHighlightDrawCommand := CreateDrawCommand;

  if (lHighlightDrawCommand = nil) then
    raise ESearchHighlightError.Create('TppTextSearchHighlighter.Highlight: Cannot create a draw command to highligh the text.');

  PositionHighlightDrawCommand(FDrawText, lHighlightDrawCommand);

  {Rotated text: Highlights the entire draw command}
  if (FDrawText.Angle <> 0) then
    TppDrawText(lHighlightDrawCommand).Text := FDrawText.Text;

  {Need to highlight full justified text, but can't, because it is a
   rich text behavior. Can't use rich text because TRichEdit doens't support
   full justify. Current implementation is to highlight the entire line where
   the text is found.}
  if (FDrawText.TextAlignment = taFullJustified) and FDrawText.IsMemo then
    begin
      lToolbox := TppTextSearchToolboxRegistry.GetToolboxPlugin;

      lToolbox.SearchLine(FFullLineText, TppTextMarkups.EOP, CaseSensitive, WholeWord, liPos);

      TppDrawText(lHighlightDrawCommand).Text := lToolbox.StringReplace(FFullLineText, TppTextMarkups.EOP, '', True, CaseSensitive);

      if (liPos = 0) then
        TppDrawText(lHighlightDrawCommand).TextAlignment := taFullJustified;
    end;

  Result := lHighlightDrawCommand;

end;

{@TppTextSearchHighlighter.CalculateTextPosition }

procedure TppTextSearchHighlighter.CalculateTextPosition(const aSearchText: String; aDrawText: TppDrawText; aTextSearchOccurrence: TppTextSearchOccurrence);
var
  liSearchTextLength: Integer;
  liTotalPos: Integer;
  lsSearchText: String;
  lsPrefixText: String;
  lsText: String;
  liIndex: Integer;
begin

  if (aTextSearchOccurrence.OccurrenceIndex > 0) then
    begin
      lsPrefixText := '';
      lsText := aDrawText.Text;
      lsSearchText := aSearchText;
      liSearchTextLength := Length(lsSearchText);
      liTotalPos := 0;

      for liIndex := 1 to aTextSearchOccurrence.OccurrenceIndex do
        FindTextInLine(lsSearchText, lsText, lsPrefixText, liSearchTextLength, liTotalPos);

      CalculateLeftPosition(liTotalPos, liSearchTextLength, aDrawText.Text);

      FFullLineText := aDrawText.Text;

      FTopPosition := 0;

      CalculateSize(aDrawText);

      Scale(FLeftPosition, FTopPosition);
      Scale(FTextWidth, FTextHeight);
    end;

end;

{@TppTextSearchHighlighter.CalculateMemoTextPosition }

procedure TppTextSearchHighlighter.CalculateMemoTextPosition(const aSearchText: String; aDrawText: TppDrawText; aTextSearchOccurrence: TppTextSearchOccurrence);
var
  liTopPosition: Integer;
  liTotalPos: Integer;
  lsOriginalText: String;
  liOccurrences: Integer;
  lsSearchText: String;
  lsPrefixText: String;
  liPos: Integer;
  lsText: String;
  liSearchTextLength: Integer;
begin

  {need to calc FTextHeight before loop in order to calculate the top position of the highlight}
  FSearchText := UpperCase(aSearchText);

  lsText := aDrawText.WrappedText[aTextSearchOccurrence.LineNumber - 1];

  lsSearchText := aSearchText;
  liOccurrences := 0;
  lsOriginalText := lsText;
  lsPrefixText := '';
  liTotalPos := 0;
  liSearchTextLength := Length(lsSearchText);

  {find the occurrence of search text in this line}
  while (liOccurrences < aTextSearchOccurrence.OccurrenceIndex) do
    begin
      liPos := FindTextInLine(lsSearchText, lsText, lsPrefixText, liSearchTextLength, liTotalPos);

      if (liPos <> 0) then
        Inc(liOccurrences);
    end;

  if (liOccurrences > 0) then
    begin
      CalculateLeftPosition(liTotalPos, liSearchTextLength, lsOriginalText);

      CalculateSize(aDrawText);

      Scale(FLeftPosition, FTopPosition);
      Scale(FTextWidth, FTextHeight);

      {update the top position}
      liTopPosition := aTextSearchOccurrence.LineNumber * FTextHeight;

      FTopPosition := liTopPosition - FTextHeight;

      FFullLineText := lsOriginalText;
    end;

end;

{@TppTextSearchHighlighter.CalculateLeftPosition }

procedure TppTextSearchHighlighter.CalculateLeftPosition(aTotalPos, aSearchTextLength: Integer; const aOriginalText: String);
var
  lsOriginalPostfixText: String;
  liStartPos: Integer;
  lsOriginalPrefixText: String;
  liPrefixWidth: Integer;
begin

  liStartPos := aTotalPos - aSearchTextLength + 1;

  FSearchText := Copy(aOriginalText, liStartPos, aSearchTextLength);

  lsOriginalPrefixText := Copy(aOriginalText, 0, liStartPos - 1);

  lsOriginalPostfixText := Copy(aOriginalText, liStartPos + aSearchTextLength, Length(aOriginalText));

  case FDrawText.TextAlignment of

    taLeftJustified:
      begin
        liPrefixWidth := TppTextSearchToolbox.CalculateTextWidth(lsOriginalPrefixText, FCanvas);

        FLeftPosition := ppToMMThousandths(liPrefixWidth, utScreenPixels, pprtHorizontal, nil);
      end;

    taRightJustified:  CalculateRightJustifiedLeftPosition(lsOriginalPostfixText);

    taCentered: CalculateCenteredLeftPosition(lsOriginalPrefixText, lsOriginalPostfixText);

    taFullJustified: CalculateJustifiedLeftPosition(aOriginalText, lsOriginalPrefixText, lsOriginalPostfixText);

  end;

end;
 {@TppTextSearchHighlighter.CalculateRightJustifiedLeftPosition }

procedure TppTextSearchHighlighter.CalculateRightJustifiedLeftPosition(const aOriginalPostfixText: String);
var
  liDrawTextWidth: Integer;
  liSearchTextWidth: Integer;
  liPostfixWidth: Integer;
  liLeft: Integer;
begin

  liSearchTextWidth := TppTextSearchToolbox.CalculateTextWidth(FSearchText, FCanvas);

  liPostfixWidth := TppTextSearchToolbox.CalculateTextWidth(aOriginalPostfixText, FCanvas);

  liDrawTextWidth := Round(ppFromMMThousandths(FDrawText.Width, utScreenPixels, pprtHorizontal, nil));

  liDrawTextWidth := Round(liDrawTextWidth * ScaleX);

  liLeft := liDrawTextWidth - liSearchTextWidth - liPostFixWidth;

  FLeftPosition := ppToMMThousandths(liLeft, utScreenPixels, pprtHorizontal, nil);

end;

{@TppTextSearchHighlighter.CalculateCenteredLeftPosition }

procedure TppTextSearchHighlighter.CalculateCenteredLeftPosition(const aOriginalPrefixText, aOriginalPostfixText: String);
var
  liDrawTextWidth: Integer;
  liPrefixWidth: Integer;
  liSearchTextWidth: Integer;
  liPostfixWidth: Integer;
  liTextWidth: Integer;
  liStartingLeft: Integer;
begin

  liDrawTextWidth := Trunc(ppFromMMThousandths(FDrawText.DeviceLineWidth, utScreenPixels, pprtHorizontal, nil));

  liPrefixWidth := TppTextSearchToolbox.CalculateTextWidth(aOriginalPrefixText, FCanvas);

  liSearchTextWidth := TppTextSearchToolbox.CalculateTextWidth(FSearchText, FCanvas);

  liPostfixWidth := TppTextSearchToolbox.CalculateTextWidth(aOriginalPostfixText, FCanvas);

  liTextWidth := liPrefixWidth + liSearchTextWidth + liPostfixWidth;

  liStartingLeft := Round( ( (liDrawTextWidth - liTextWidth) / 2) - 0.5);

  FLeftPosition := ppToMMThousandths(liStartingLeft + liPrefixWidth, utScreenPixels, pprtHorizontal, nil);

end;

{@TppTextSearchHighlighter.CalculateJustifiedLeftPosition

  Not yet fully implemented.}

procedure TppTextSearchHighlighter.CalculateJustifiedLeftPosition(const aOriginalText, aOriginalPrefixText, aOriginalPostfixText: String);
begin
  FLeftPosition := 0;
end;

{@TppTextSearchHighlighter.CalculateSize }

procedure TppTextSearchHighlighter.CalculateSize(aDrawText: TppDrawText);
begin

  if (FDrawText.TextAlignment in [taLeftJustified, taRightJustified, taCentered]) and (FDrawText.Angle = 0) then
    begin
      FTextWidth := FCanvas.TextWidth(FSearchText);
      FTextWidth := ppToMMThousandths(FTextWidth, utScreenPixels, pprtHorizontal, nil);
    end
  else
    FTextWidth := aDrawText.DeviceLineWidth;

  if (fsItalic in aDrawText.Font.Style) then
    FTextWidth := FTextWidth + Round(750 * ScaleX)
  else
    FTextWidth := FTextWidth + Round(100 * ScaleX);

  if (aDrawText.DeviceLineHeight = 0) then
    raise ESearchHighlightError.Create('TppTextSearchHighlighter.CalculateSize: Must use a screen device to generate highlights.');

  FTextHeight := aDrawText.DeviceLineHeight;

end;

{@TppTextSearchHighlighter.Scale }

procedure TppTextSearchHighlighter.Scale(var aHorizontalValue, aVerticalValue: Integer);
begin
  aHorizontalValue := Round(aHorizontalValue / ScaleX);

  aVerticalValue := Round(aVerticalValue / ScaleY);
end;

{@TppTextSearchHighlighter.FindTextInLine }

function TppTextSearchHighlighter.FindTextInLine(const aSearchText: String; var aText, aPrefixText: String; aSearchTextLength: Integer; var aTotalPos: Integer): Integer;
var
  liEndPos: Integer;
  liPos: Integer;
begin

  TppTextSearchToolboxRegistry.GetToolboxPlugin.SearchLine(aText, aSearchText, CaseSensitive, WholeWord, liPos);

  if (liPos <> 0) then
    begin
      liEndPos := liPos + aSearchTextLength - 1;

      aPrefixText := aPrefixText + Copy(aText, 0, liEndPos);

      Delete(aText, 1, liEndPos);

      {calculate the ending position in the text}
      aTotalPos := aTotalPos + liEndPos;
    end;

  Result := liPos;

end;

{@TppTextSearchHighlighter.CreateDrawCommand }

function TppTextSearchHighlighter.CreateDrawCommand: TppDrawCommand;
var
  lDrawText: TppDrawText;
begin

  lDrawText := TppDrawText.Create(nil);
  lDrawText.Angle := FDrawText.Angle;
  lDrawText.RotatedOrigin := FDrawText.RotatedOrigin;
  lDrawText.RedrawPage := True;
  lDrawText.Color := Color;
  lDrawText.Font := GetOriginalDrawCommandFont;
  lDrawText.Font.Color := TextColor;
  lDrawText.Font.Name := TppDeviceSubstitutions.SubstituteFont(lDrawText.Font.Name);
  lDrawText.Text := GetSearchText;
  lDrawText.Transparent := Transparent;

  // use the device font height, but need to unscale it
  // need to use the device font height because the screen device can adjust
  // the font height for memo text
  lDrawText.Font.Height := Trunc(FDrawText.DeviceFontHeight / ScaleY);

  Result := lDrawText;

end;

{@TppTextSearchHighlighter.PositionHighlightDrawCommand }

procedure TppTextSearchHighlighter.PositionHighlightDrawCommand(aDrawText: TppDrawText; aHighlightDrawCommand: TppDrawCommand);
begin
  if aDrawText.Angle <> 0 then
    begin
      aHighlightDrawCommand.Top := aDrawText.Top;
      aHighlightDrawCommand.Left := aDrawText.Left;
    end
  else
    begin
      aHighlightDrawCommand.Top := aDrawText.Top + FTopPosition;
      aHighlightDrawCommand.Left := aDrawText.Left + FLeftPosition;
    end;

  aHighlightDrawCommand.Width := FTextWidth;
  aHighlightDrawCommand.Height := FTextHeight;
end;

{@TppTextSearchHighlighter.PositionHighlightDrawCommand

  Provides descendents with the font that was assigned to the draw command from
  the report engine during the generation process.}

function TppTextSearchHighlighter.GetOriginalDrawCommandFont: TFont;
begin
  Result := FOriginalDrawCommandFont;
end;

end.
