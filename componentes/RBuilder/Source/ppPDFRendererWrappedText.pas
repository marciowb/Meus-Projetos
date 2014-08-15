{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPDFRendererWrappedText;

interface

uses
  Classes,
  Windows,
  ppPrintr,
  ppDevice,
  ppDrwCmd,
  ppTypes,
  ppPDFRendererCustomText;

type

  {@TppPDFWrappedText

    This class descends from TppPDFRendererCustomText and is used to render the
    two types of wrapped text components available in ReportBuilder: TppMemos,
    and TppLables.  Not all wrapped text features are currently supported in
    PDF.  Below is a list of supported Wrapped Text features.

    - Left, Right, Center Aligned Text.
    - Full Justified Text.
    - Forced Full Justified Text.
    - Underlined/Strikeout Text.
    - Tabbed text with built in tab stops (Left align only).
    - Tabbed Text with user defined tab stops (Left align only). }
    
  TppPDFRendererWrappedText = class(TppPDFRendererCustomText)
    private
      FBottomOffset: Double;
      FDescent: Double;
      FFirstLine: Boolean;
      FLastWordWidth: Double;
      FLeftOffset: Double;
      FLineHeight: Double;
      FRunningOffset: Double;
      FTabOffset: Double;
      FTabsDefined: Boolean;
      FWrappedText: TStrings;

      procedure AdjustBorderedText(aAlignment: TppTextAlignment);
      procedure AddLeftLastLine(aText: String);
      procedure CreateTabSections(aText: String; aSections: TStrings);
      procedure CreateTabStoppedText(aText: String; aTabs: TStrings);
      procedure CreateWrappedText;
      procedure ProcessFullTextSpacing(aText: String);
      procedure WriteLeftText;
      procedure WriteCenterRightText;
      procedure WriteFullText;

      function GetTabPosition(aCurrentleft: Double; aTabs: TStrings): Double;
      function ProcessCenterRightJustification(aText: String; aTextAlignment: TppTextAlignment; aTextWidth, aLastOffset: Double): Double;
      function Stylized: Boolean;
      function TabsPresent: Boolean;
      function TextHeightPoints(aText: String): Double;
      function TextWidthPoints(aText: String): Double;


    public
      class function DrawCommandClass: TppDrawCommandClass; override;
      procedure RenderToPDF; override;

  end;

implementation

uses
  Forms,
  Graphics,
  SysUtils,
  StrUtils,
  ppPDFUtils,
  ppPlainText,
  Math;

{TppPDFWrappedText.CreateTabStoppedText

  Draws tabbed Memo text to PDF file.  This routine takes a line of text and
  separates it into tabbed sections.  Then with relation to the beginning cursor
  point, draws the section of text to PDF with the tab spacing included. }

procedure TppPDFRendererWrappedText.CreateTabStoppedText(aText: String; aTabs: TStrings);
var
  ldCurrentLeft: Double;
  liIndex: Integer;
  ldBottomOffset: Double;
  ldLeftOffset: Double;
  ldTabOffset: Double;
  ldOldLeft: Double;
  lTabStrings: TStringList;
  lsText: String;
begin

  lsText := aText;

  ldCurrentLeft := 0;
  ldLeftOffset := 0;
  ldOldLeft := 0;

  lTabStrings := TStringList.Create;

  try
    CreateTabSections(lsText, lTabStrings);

    for liIndex := 0 to lTabStrings.Count - 1 do
      begin
        {First line first word (Treated differently in PDF)}
        if (FFirstLine) and (liIndex = 0) then
          begin

            {Tab at the beginning of the first line}
            if (lTabStrings[liIndex] = '') then
              begin
                ldLeftOffset := GetTabPosition(0, aTabs);
                ldCurrentLeft := ldLeftOffset;
              end
            else
              ldCurrentLeft := TextWidthPoints(lTabStrings[liIndex]);

            FFirstLine := False;

          end
        {First word, subsequent line}
        else if (not(FFirstLine)) and (liIndex = 0) then
          begin
            ldBottomOffset := -CalcLineHeight;
            ldLeftOffset := -FTabOffset;

            PDFCanvas.TextPos(ldLeftOffset, ldBottomOffset);

            ldCurrentLeft := TextWidthPoints(lTabStrings[liIndex]);

            {Reset after new line}
            ldLeftOffset := 0;
            FTabOffset := 0;

          end
        else
          begin
            ldBottomOffset := 0;
            ldOldLeft := ldOldLeft + ldLeftOffset;

            ldTabOffset := GetTabPosition(ldCurrentLeft, aTabs);
            ldLeftOffset := RoundTo(ldTabOffset - ldOldLeft, -5);

            PDFCanvas.TextPos(ldLeftOffset, ldBottomOffset);

            //Actual current left position (not offset)
            ldCurrentLeft := ldTabOffset + TextWidthPoints(lTabStrings[liIndex]);

            FTabOffset := FTabOffset + ldLeftOffset;

          end;

        PDFCanvas.WriteText(lTabStrings.Strings[liIndex]);

      end;

    {Clear the StringList}
    lTabStrings.Clear;

  finally
    lTabStrings.Free;

  end;

end;

{TppPDFWrappedText.CreateTabSections

  Separates out a line of text into sections based on a delimiter of a TAB
  character.  Each section is then placed in a String List to later be
  positioned properly in the PDF file.  The TAB character (#9) is removed.}

procedure TppPDFRendererWrappedText.CreateTabSections(aText: String; aSections: TStrings);
var
  liIndex: Integer;
  lsDelimiter: String;
  lbTabs: Boolean;
  lsText: String;
  lsTemp: String;
begin

  {Parse the text line based on a TAB delimiter}
  lsDelimiter := TppTextMarkups.Tab;
  lsText := aText;
  lbTabs := True;

  if (Pos(lsDelimiter, lsText) = 0) then
    aSections.Add(lsText)               //if there are no tabs add the entire line
  else
    begin

      while lbTabs do
        begin
          if (Pos(lsDelimiter, lsText) > 0) then
            begin
              liIndex := Pos(lsDelimiter, lsText);
              lsTemp := Copy(lsText, 1, liIndex);
              Delete(lsTemp, liIndex, liIndex);
              aSections.Add(lsTemp);
              Delete(lsText, 1, liIndex);
            end;

          if Pos(lsDelimiter, lsText) = 0 then
            begin
              if lsText <> '' then
                aSections.Add(lsText);  //add last text (if any)
              lbTabs := False;
            end;

        end;
    end;

end;

{TppPDFWrappedText.CreateWrappedText

  Determines the initial location and values of the text object and based on
  the text alignment, draws wrapped text to the PDF file.}

procedure TppPDFRendererWrappedText.CreateWrappedText;
var
  lAlignment: TppTextAlignment;
begin

  FWrappedText := DrawTextCommand.WrappedText;

  FDescent := TppPDFUtils.PixelsToPoints(TextMetric.tmDescent, Printer.PixelsPerInch.Y);
  FLineHeight := CalcLineHeight;

  {Initial left and bottom offsets}
  FLeftOffset := TppPDFUtils.MicronsToPoints(DrawTextCommand.Left);
  FBottomOffset := RoundTo(PageHeight - TppPDFUtils.MicronsToPoints(DrawTextCommand.Top) - FLineHeight + FDescent, -2);

  lAlignment := DrawTextCommand.TextAlignment;

  case lAlignment of
    taCentered: WriteCenterRightText;
    taLeftJustified: WriteLeftText;
    taFullJustified: WriteFullText;
    taRightJustified: WriteCenterRightText;
  end;

end;

{TppPDFWrappedText.ProcessCenterRightJustification

  Returns the left offset relative to the last offset (necessary in PDF) of the
  line of text sent with respect to the control box width. }

function TppPDFRendererWrappedText.ProcessCenterRightJustification(aText: String; aTextAlignment: TppTextAlignment; aTextWidth, aLastOffset: Double): Double;
var
  ldControlWidth: Double;
  ldOffset: Double;
begin

  Result := 0;

  ldControlWidth := TppPDFUtils.MicronsToPoints(DrawTextCommand.Width);

  ldOffset := ldControlWidth - aTextWidth;
  FRunningOffset := FRunningOffset + aLastOffset;

  case aTextAlignment of
    taCentered: Result := (ldOffset/2) - FRunningOffset;
    taRightJustified: Result := ldOffset - FRunningOffset;
  end;

end;

{TppPDFWrappedText.GetTabPosition

  Calculates the next position of the cursor as if a tab has been entered.  This
  method will not calculate the absolute position of the cursor, only the offset
  with respect to the current cursor location. }

function TppPDFRendererWrappedText.GetTabPosition(aCurrentLeft: Double; aTabs: TStrings): Double;
var
  liTabWidth: Integer;
  ldTabWidth: Double;
  liIndex: Integer;
  ldPosition: Double;
  lTabStopArray: TppTabStopPos;
begin

  Result := 0;

  //Get default tab measurements
  Printer.Canvas.Font := DrawTextCommand.Font;
  liTabWidth := TppPlainText.GetTabbedTextWidth(Printer.Canvas, #9, 0, lTabStopArray);
  ldTabWidth := TppPDFUtils.PixelsToPoints(liTabWidth, Printer.PixelsPerInch.X);

  //If tabs are user-defined, use them instead of the default
  for liIndex := 0 to aTabs.Count - 1 do
    begin

      ldTabWidth := TppPDFUtils.MicronsToPoints(StrToInt(aTabs.Strings[liIndex]));
      if ((ldTabWidth > aCurrentLeft) and ((Result = 0) or (ldTabWidth < Result))) then
        Result := ldTabWidth;

    end;

  if (Result = 0) then
    begin
      ldPosition := 0;

      while (ldPosition <= aCurrentLeft) do
        ldPosition := ldPosition + (ldTabWidth);

      Result := ldPosition;

    end;

end;

{TppPDFWrappedText.ProcessFullTextSpacing

  Processes a line of text into full justified text.  This routine breaks a line
  of text into separate words and adds them to a string list.  Then using the
  Text Extent (ie. w/out spaces), an equal space is set between each word from
  the space left over. (ControlWidth - TextExtent)}

procedure TppPDFRendererWrappedText.ProcessFullTextSpacing(aText: String);
var
  ldControlWidth: Double;
  ldExtraPadding: Double;
  liIndex: Integer;
  ldPadding: Double;
  lbSingleWord: Boolean;
  lbEndParagraph: Boolean;
  lsText: String;
  ldTextExtent: Double;
  ldSpaceExtent: Double;
  lsWord: String;
  lsRawWord: String;
  liWordCount: Integer;
  ldWordExtent: Double;
  ldWordLeft: Double;
  ldWordBottom: Double;
  ldLineLength: Double;
begin

  lsText := TppPlainText.StringStrip(aText, TppTextMarkups.EOP);

  {Text Measurments}
  ldTextExtent := TextWidthPoints(TppPlainText.StringStrip(lsText, ' '));
  ldSpaceExtent := TextWidthPoints(#35);
  ldControlWidth := TppPDFUtils.MicronsToPoints(DrawTextCommand.Width);
  liWordCount := TppPlainText.WordCount(lsText);
  ldLineLength := 0;

  lbSingleWord := False;
  if (liWordCount = 1) then
    begin
      lbSingleWord := True;
      liWordCount := Length(lsText);
    end;

  {Padding} 
  ldPadding := 0;
  if (liWordCount > 1) then
    ldPadding := RoundTo((ldControlWidth - ldTextExtent) / (liWordCount - 1), -2);

  ldExtraPadding := (ldControlWidth - ldTextExtent) - (ldPadding * (liWordCount - 1));

  lbEndParagraph := False;
  if (ldTextExtent + (ldSpaceExtent * liWordCount) < ldControlWidth * 0.8) then
    begin
      ldPadding := ldSpaceExtent;
      ldExtraPadding := 0;
      lbEndParagraph := True;
    end;
  

  if FFirstLine then
    begin
      ldWordLeft := TppPDFUtils.MicronsToPoints(DrawTextCommand.Left);
      ldWordBottom := RoundTo(PageHeight - TppPDFUtils.MicronsToPoints(DrawTextCommand.Top) - FLineHeight + FDescent, -2);
      FFirstLine := False;
    end
  else
    begin
      ldWordLeft := -ldControlWidth + FLastWordWidth;
      ldWordBottom := -FLineHeight;
    end;

  {Write first word to PDF}
  if lbSingleWord then
    lsWord := lsText[1]
  else
    lsWord := TppPlainText.WordByIndex(lsText, 1);

  lsRawWord := lsWord;  //Keep a copy of the original text for measuring.

  PDFCanvas.TextPos(ldWordLeft, ldWordBottom);
  PDFCanvas.WriteText(lsWord);

  for liIndex := 1 to liWordCount - 1 do
    begin
      ldWordExtent := TextWidthPoints(lsRawWord);

      if lbSingleWord then
        lsWord := lsText[liIndex + 1]
      else
        lsWord := TppPlainText.WordByIndex(lsText, liIndex + 1);

      ldWordLeft := ldWordExtent + ldPadding;
      if (liIndex >= liWordCount - ldExtraPadding) then
        ldWordLeft := ldWordLeft + 1;

      ldWordBottom := 0;

      {Write Next the word to PDF}
      lsRawWord := lsWord;

      PDFCanvas.TextPos(ldWordLeft, ldWordBottom);
      PDFCanvas.WriteText(lsWord);

      ldLineLength := ldLineLength + ldWordExtent + ldPadding;

    end;

  if lbEndParagraph then
    FLastWordWidth := ldControlWidth - ldLineLength
  else
    FLastWordWidth := TextWidthPoints(TppPlainText.WordByIndex(lsText, liWordCount));

end;

{TppPDFWrappedText.Stylized

  Returns True if the DrawText command is Underlined or Strikeout. }

function TppPDFRendererWrappedText.Stylized: Boolean;
begin
  Result := (fsUnderline in DrawTextCommand.Font.Style) or (fsStrikeOut in DrawTextCommand.Font.Style);
end;

{TppPDFWrappedText.TabsPresent

  Returns true if the DrawText command contains tabbed text. }

function TppPDFRendererWrappedText.TabsPresent: Boolean;
var
  liIndex: Integer;
begin

  Result := False;

  for liIndex := 0 to FWrappedText.Count - 1 do
    begin
      if (Pos(TppTextMarkups.Tab, FWrappedText.Strings[liIndex]) > 0) then
        Result := True;

    end;

end;

{@TppPDFWrappedText.TextHeightPoints

  Calculates the Height of a line of text in points according to it's font. }

function TppPDFRendererWrappedText.TextHeightPoints(aText: String): Double;
var
  lCanvas: TCanvas;
  liTextHeightPixels: Integer;
begin

  lCanvas := Printer.Canvas;

  lCanvas.Font := DrawTextCommand.Font;

  {Find height of text and convert to points}
  liTextHeightPixels := lCanvas.TextHeight(aText);
  Result := TppPDFUtils.PixelsToPoints(liTextHeightPixels, Printer.PixelsPerInch.Y);

end;

{TppPDFWrappedText.TextWidthPoints

  Calculates the Width of a line of text in points according to it's font. }

function TppPDFRendererWrappedText.TextWidthPoints(aText: String): Double;
var
  lCanvas: TCanvas;
  liTextWidthPixels: Integer;
begin

  lCanvas := Printer.Canvas;

  lCanvas.Font := DrawTextCommand.Font;

  {Find width of text and convert to points}
  liTextWidthPixels := lCanvas.TextWidth(aText);
  Result := TppPDFUtils.PixelsToPoints(liTextWidthPixels, Printer.PixelsPerInch.X);
end;

{@TppPDFWrappedText.RenderToPDF

  Write instructions in PDF code to the PDF Content Stream creating a new
  wrapped text object. }

procedure TppPDFRendererWrappedText.RenderToPDF;
begin
  inherited;

  FFirstLine := True;
  FTabsDefined := False;

  if DrawTextCommand.TabStopPositions.Count > 0 then
    FTabsDefined := True;

  CreateWrappedText;
  EndText;

end;

{TppPDFWrappedText.WriteCenterRightText

  Write Center or Right aligned text to the content stream. }

procedure TppPDFRendererWrappedText.WriteCenterRightText;
var
  ldLastOffset: Double;
  liIndex: Integer;
  lsText: String;
  ldTextWidth: Double;
begin

  FRunningOffset := 0;

  {Write the first line in the memo/wrapped label}
  if FWrappedText.Count > 0 then
    begin
      lsText := FWrappedText.Strings[0];
      ldTextWidth := TextWidthPoints(FWrappedText.Strings[0]);
    end
  else
    begin
      lsText := '';
      ldTextWidth := 0;
    end;
    
  ldLastOffset := ProcessCenterRightJustification(lsText, DrawTextCommand.TextAlignment, ldTextWidth, 0);
  FLeftOffset := FLeftOffset + ldLastOffset;
  PDFCanvas.TextPos(FLeftOffset, FBottomOffset);
  PDFCanvas.WriteText(lsText);

  {Base the remaining lines on the initial offset}
  for liIndex := 1 to FWrappedText.Count - 1 do
    begin
      lsText := FWrappedText.Strings[liIndex];
      ldTextWidth := TextWidthPoints(FWrappedText.Strings[liIndex]);

      FLeftOffset := ProcessCenterRightJustification(lsText, DrawTextCommand.TextAlignment, ldTextWidth, ldLastOffset);
      FBottomOffset := -FLineHeight;

      PDFCanvas.TextPos(FLeftOffset, FBottomOffset);
      PDFCanvas.WriteText(lsText);

      ldLastOffset := FLeftOffset;

    end;

  PDFCanvas.EndText;

end;

{TppPDFWrappedText.WriteFullText

  Write Full Justified text to the Content stream. }

procedure TppPDFRendererWrappedText.WriteFullText;
var
  ldControlWidth: Double;
  liIndex: Integer;
  lsText: String;
  lbOneLine: Boolean;
begin

  {Check to be sure at least one line of text is present.}
  if FWrappedText.Count = 0  then exit;

  ldControlWidth := TppPDFUtils.MicronsToPoints(DrawTextCommand.Width);
  lsText := '';
  lbOneLine := False;

  {Process all lines except the last one}
  if (FWrappedText.Count > 1) then   //Check for one liner
    begin
      for liIndex := 0 to FWrappedText.Count - 2 do
        begin
          ProcessFullTextSpacing(FWrappedText.Strings[liIndex]);
        end;
    end
  else
    lbOneLine := True;

  {Force justify the last line if needed.  Otherwise left justify}
  if (DrawTextCommand.ForceJustifyLastLine) then
    ProcessFullTextSpacing(FWrappedText.Strings[FWrappedText.Count - 1])

  else if lbOneLine then
    begin
      FWrappedText.Strings[0] := TppPlainText.StringStrip(FWrappedText.Strings[0], TppTextMarkups.EOP);
      WriteLeftText;
    end

  else
    AddLeftLastLine(FWrappedText.Strings[FWrappedText.Count - 1]);

  if not(lbOneLine) then
    begin

      PDFCanvas.EndText;

      {Stylize the Wrapped Text if needed (ie. Underline/Strikeout)}
      if Stylized then
        begin
          for liIndex := 0 to FWrappedText.Count - 1 do
            begin
              lsText := FWrappedText.Strings[liIndex];

              StylizeText(ldControlWidth, TextHeightPoints(lsText), FBottomOffset, FLeftOffset);
              FBottomOffset := FBottomOffset - FLineHeight;

            end;

        end;
    end;

end;

procedure TppPDFRendererWrappedText.AddLeftLastLine(aText: String);
var
  lsText: String;
  ldControlWidth: Double;
  ldLineLeft: Double;
  ldLineBottom: Double;
begin

  lsText := TppPlainText.StringStrip(aText, TppTextMarkups.EOP);

  ldControlWidth := TppPDFUtils.MicronsToPoints(DrawTextCommand.Width);
  ldLineLeft := -ldControlWidth + FLastWordWidth;
  ldLineBottom := -FLineHeight;

  PDFCanvas.TextPos(ldLineLeft, ldLineBottom);
  PDFCanvas.WriteText(lsText);

end;

{@TppPDFWrappedText.WriteLeftText

  Write Left Aligned text to the content stream. }

procedure TppPDFRendererWrappedText.WriteLeftText;
var
  lsText: String;
  liIndex: Integer;
begin

  FTabOffset := 0;  //need to reset this value for each wrapped text component

  if DrawTextCommand.Border.Visible then
    AdjustBorderedText(DrawTextCommand.TextAlignment);

  {Write Left Wrapped text}
  WriteLine(ExtToStr(FLineHeight) + ' TL');
  PDFCanvas.TextPos(FLeftOffset, FBottomOffset);

  for liIndex := 0 to FWrappedText.Count - 1 do
    begin
      lsText := FWrappedText.Strings[liIndex];

      if TabsPresent then
        CreateTabStoppedText(lsText, DrawTextCommand.TabStopPositions)
      else
        PDFCanvas.WriteText(lsText, True);

    end;

  PDFCanvas.EndText;

    {Stylize the Wrapped Text if needed (ie. Underline/Strikeout)}
    if Stylized then
      begin
        for liIndex := 0 to FWrappedText.Count - 1 do
          begin
            lsText := FWrappedText.Strings[liIndex];

            StylizeText(TextWidthPoints(lsText), TextHeightPoints(lsText), FBottomOffset, FLeftOffset);
            FBottomOffset := FBottomOffset - FLineHeight;

          end;

      end;

end;


procedure TppPDFRendererWrappedText.AdjustBorderedText(aAlignment: TppTextAlignment);
var
  lWeight: Single;
  lBorderPositions: TppBorderPositions;
begin

  {Adjust for borders}
  lWeight := DrawTextCommand.Border.Weight;
  lBorderPositions := DrawTextCommand.Border.BorderPositions;

  if (bpTop in lBorderPositions) then
    FBottomOffset := FBottomOffset - lWeight;

  if (bpLeft in lBorderPositions) and (aAlignment = taLeftJustified) then
    FLeftOffset := FLeftOffset + lWeight
  else if (bpLeft in lBorderPositions) and (aAlignment = taRightJustified) then
    FLeftOffset := FLeftOffset - lWeight;

end;

class function TppPDFRendererWrappedText.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawText;
  
end;

end.
