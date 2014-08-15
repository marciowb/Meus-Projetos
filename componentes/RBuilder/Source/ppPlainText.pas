{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPlainText;

interface

{x$Define CodeSite}

uses
  {$IFDEF CodeSite} csIntf, {$ENDIF}
  Windows,
  Graphics,
  Classes,
  Math,
  ppTypes,
  ppPrintr,
  ppCharacter;

type

  {TppPlainText}
  TppPlainText = class
    private
      class function AddBreakCharsToSingleWord(aString: String; var aBreakCharCount, aStartCharCounter, aEndCharCounter: Integer): String;

    public
      class procedure ConvertTabStopPos(aUnits: TppUnitType; aTabList: TStrings; var aTabArray: TppTabStopPos; var aSize: Integer; aPrinter: TObject);
      class function GetTabbedTextWidth(aCanvas: TCanvas; const aString: String; aTabStopCount: Integer; aTabStopArray: TppTabStopPos): Integer;
      class function MaxLinesFit(aFont: TFont; aLeading: Longint; aSpaceAvailable: Longint; aPrinter: TObject; var aLineHeight: Longint): Integer;
      class procedure SetCanvasToJustify(aCanvas: TCanvas; aRect: TRect; var aString: String; aTabStopCount: Integer; aTabStopArray: TppTabStopPos);
      class function StringStrip(const aString, aStripString: String): String;
      class procedure WordWrap(const aText: String; aRect: TppRect; aTextAlignment: TppTextAlignment; aAutoSize: Boolean; aFont: TFont; aCharWrap: Boolean; aLeading: Integer; aTabStops: TStrings; aPrinter: TObject; var aCharPos: Integer; aWrappedText: TStrings);
      class function WordCount(const aString: String): Integer;
      class function WordCountByDelimeter(const aString: String; const aDelimeters: TppAnsiCharSet): Integer;
      class function WordByIndex(const aString: String; aIndex: Integer): String;
      class function WordByIndexByDelimeter(const aString: String; aIndex: Integer; const aDelimeters: TppAnsiCharSet): String;
      class function WordPosition(const aWordIndex: Integer; const aString: string; const aDelimeters: TppAnsiCharSet): Integer;
  end;

  {TppTextMarkups}
  TppTextMarkups = class
    public
      class function Tab: Char;
      class function CR: Char;
      class function LF: Char;
      class function CRLF: String;
      class function Null: Char;
      class function EOP: String;
      class function Empty: String;
      class function Space: Char;
      class function SoftReturn: String;
      class function SoftReturnForCharWrap: String;
  end;

  {TppPlainTextParser

   Parser for plain text.

   Set the Text property and optionally set CharPos to the starting character
   position.

   Use NextWord/NextChar to read the next word/char

   Use PeekNextWord/PeekNextChar to look at the next word/char without incrementing
   CharPos

   }
  TppPlainTextParser = class
    private
      FCharPos: Integer;
      FAllWordsParsed: Boolean;
      FNextWord: String;
      FText: String;
      FTextLength: Integer;

      function GetEndOfText: Boolean;
      function GetNextWord: String;
      function GetNextChar: String;
      function ParseNextWord: String;
      function GetPeekNextWord: String;
      function GetPeekNextChar: String;
      procedure SetText(const aText: String);
      procedure SetCharPos(aCharPos: Integer);

    public
      constructor Create;
      destructor Destroy; override;

      property CharPos: Integer read FCharPos write SetCharPos;
      property EndOfText: Boolean read GetEndOfText;
      property NextWord: String read GetNextWord;
      property NextChar: String read GetNextChar;
      property PeekNextChar: String read GetPeekNextChar;
      property PeekNextWord: String read GetPeekNextWord;
      property Text: String read FText write SetText;
      property TextLength: Integer read FTextLength;

  end;


  {TppPlainTextWrapper}
  TppPlainTextWrapper = class
  private
    FAlignment: TppTextAlignment;
    FAreaAvailable: TppRect;
    FAutoSize: Boolean;
    FBottomless: Boolean;
    FCharPos: Integer;
    FCharWrap: Boolean;
    FFont: TFont;
    FLeading: Integer;
    FMaxLines: Integer;
    FMaxLineWidth: Integer;
    FPrinter: TppPrinter;
    FTabs: TStrings;
    FText: String;
    FWantReturns: Boolean;
    FWrappedText: TStrings;

    FCanvas: TCanvas;
    FDeviceUnits: TppUnitType;
    FLineHeight: Integer;
    FTabStopArray: TppTabStopPos;
    FTabStopCount: Integer;
    FTextParser: TppPlainTextParser;
    FTrimLeadingSpaces: Boolean;
    FWidthAvailable: Integer;

    procedure SetTabs(aTabs: TStrings);
    
  protected

    procedure AddWordsToLine(var aLine, aLastWord: String);
    procedure AddCharsToLine(var aLine: String);
    procedure AddLineToText(aLine: String);
    function CalcTextWidth(const aText: String): Integer;
    procedure Initialize;
    function WrapLine: String;
    procedure WrapText;

  public
    constructor Create;
    destructor Destroy; override;
    
    procedure Wrap;

    property Alignment: TppTextAlignment read FAlignment write FAlignment;
    property AreaAvailable: TppRect read FAreaAvailable write FAreaAvailable;
    property AutoSize: Boolean read FAutoSize write FAutoSize;
    property Bottomless: Boolean read FBottomless write FBottomless;
    property CharPos: Integer read FCharPos write FCharPos;
    property CharWrap: Boolean read FCharWrap write FCharWrap;
    property Font: TFont read FFont write FFont;
    property Leading: Integer read FLeading write FLeading;
    property MaxLineWidth: Integer read FMaxLineWidth;
    property Printer: TppPrinter read FPrinter write FPrinter;
    property Tabs: TStrings read FTabs write SetTabs;
    property Text: String read FText write FText;
    property WantReturns: Boolean read FWantReturns write FWantReturns;
    property WrappedText: TStrings read FWrappedText;

  end;


implementation

uses
  SysUtils,
  ppUtils;

{******************************************************************************
 *
 **  T E X T   M A R K U P S
 *
{******************************************************************************}

class function TppTextMarkups.Tab: Char;
begin
  Result := #9;
end;

class function TppTextMarkups.CR: Char;
begin
  Result := #13;
end;

class function TppTextMarkups.LF: Char;
begin
  Result := #10;
end;

class function TppTextMarkups.CRLF: String;
begin
  Result := #13#10;
end;

class function TppTextMarkups.Null: Char;
begin
  Result := #0;
end;

class function TppTextMarkups.EOP: String;
begin
  Result := String(#36#182);
end;

class function TppTextMarkups.Empty: String;
begin
  Result := '';
end;

class function TppTextMarkups.Space: Char;
begin
  Result := #32;
end;

class function TppTextMarkups.SoftReturn: String;
begin
  Result := #13#13#10;
end;

class function TppTextMarkups.SoftReturnForCharWrap: String;
begin
  Result := #13#13#13#10;
end;

{******************************************************************************
 *
 **  P L A I N   T E X T   P A R S E R
 *
{******************************************************************************}

{@TppPlainTextParser.Create}

constructor TppPlainTextParser.Create;
begin

  inherited Create;

  FCharPos := 0;
  FAllWordsParsed := False;
  FText := '';
  FNextWord := '';

end;

{@TppPlainTextParser.Destroy}

destructor TppPlainTextParser.Destroy;
begin
  inherited Destroy;
end;

function TppPlainTextParser.GetEndOfText: Boolean;
begin
  Result := (FCharPos >= FTextLength);
end;

{@TppPlainTextParser.SetText}

procedure TppPlainTextParser.SetText(const aText: String);
begin
  FText := aText;
  FNextWord := '';

  FTextLength := Length(FText);

  FCharPos := 0;

  FAllWordsParsed := False;
end;

{@TppPlainTextParser.SetCharPos}

procedure TppPlainTextParser.SetCharPos(aCharPos: Integer);
begin
  FCharPos := aCharPos;
  FNextWord := '';
  FAllWordsParsed := (FCharPos > FTextLength);
end;

{TppPlainTextParser.GetNextWord}

function TppPlainTextParser.GetNextWord: String;
begin

  if FNextWord = '' then
    Result := ParseNextWord
  else // next word already parsed
    begin
      Result := FNextWord;
      Inc(FCharPos, Length(FNextWord));
      FNextWord := '';
    end;

end;

{TppPlainTextParser.GetNextWord}

function TppPlainTextParser.GetNextChar: String;
var
  lsChar: String;
begin

  lsChar := '';

  Inc(FCharPos);

  {reached end of the text}
  if (FCharPos > FTextLength) then
    FAllWordsParsed := True
  else
    lsChar := FText[FCharPos];

  Result := lsChar;

end;

{TppPlainTextParser.GetNextWord}

function TppPlainTextParser.ParseNextWord: String;
var
  lbEndOfWord: Boolean;
  lCharacter: Char;
  lsWord: String;
begin

  lsWord := '';
  lbEndOfWord := False;

  while not(lbEndOfWord) and not(FAllWordsParsed) do
    begin
      {move to next position in the text}
      Inc(FCharPos);

      {reached end of the text}
      if (FCharPos > FTextLength) then
        FAllWordsParsed := True
      else
        begin

          lCharacter := FText[FCharPos];

          if (lCharacter = TppTextMarkups.Null) then
            FAllWordsParsed := True

          else if (lCharacter = TppTextMarkups.Space) then
            begin
              lbEndOfWord := True;

              if (lsWord = '') then
                lsWord := TppTextMarkups.Space
              else
                Dec(FCharPos);
            end

          else if (lCharacter = TppTextMarkups.CR) then
            begin
              lbEndOfWord := True;

              if (lsWord <> '') then
                Dec(FCharPos)

              else
                begin

                  if ((FCharPos + 1) <= FTextLength) and (FText[FCharPos + 1] = TppTextMarkups.LF) then
                    Inc(FCharPos);

                  {skip over the LF char since it was found immediately following CR}
                  if (FCharPos <= FTextLength) then
                    lsWord := TppTextMarkups.CRLF;

                end;

            end

          else if (lCharacter = TppTextMarkups.LF) then
            begin
              lbEndOfWord := True;

              if (lsWord <> '') then
                Dec(FCharPos)

              else if (FCharPos <= FTextLength) then
                lsWord := TppTextMarkups.CRLF;

            end

          else if (lCharacter = TppTextMarkups.Tab) then
            begin
              lbEndOfWord := True;

              if (lsWord = '') then
                lsWord := TppTextMarkups.Tab
              else
                Dec(FCharPos);
              end

          else if ((FCharPos + 1) <= FTextLength) and (lCharacter + FText[FCharPos + 1] = TppTextMarkups.EOP) then
            begin
              lbEndOfWord := True;

              if (lsWord <> '') then
                Dec(FCharPos)

              else
                begin
                  Inc(FCharPos);

                  lsWord := TppTextMarkups.CRLF;
                end;

            end

          else
            lsWord := lsWord + lCharacter;

        end;

    end;

  Result := lsWord;

end;

{TppPlainTextParser.GetPeekNextWord}

function TppPlainTextParser.GetPeekNextWord: String;
var
  liCharPos: Integer;
begin

  // save current position
  liCharPos := FCharPos;

  Result := GetNextWord;

  // restore char pos
  FCharPos := liCharPos;
  FAllWordsParsed := (FCharPos > FTextLength);

end;

{TppPlainTextParser.GetPeekNextWord}

function TppPlainTextParser.GetPeekNextChar: String;
var
  liCharPos: Integer;
begin

  // save current position
  liCharPos := FCharPos;

  Result := GetNextChar;

  // restore char pos
  FCharPos := liCharPos;
  FAllWordsParsed := (FCharPos > FTextLength);

end;


{******************************************************************************
 *
 **  P L A I N   T E X T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPlainText.WordWrap

  Returns wrapped lines of text that can fit into the area specified by aRect.
  The aCharPos parameter specifies the starting character position. It is updated
  by this method to indicate the position of the last character that fit.
}

class procedure TppPlainText.WordWrap(const aText: String; aRect: TppRect; aTextAlignment: TppTextAlignment; aAutoSize: Boolean; aFont: TFont; aCharWrap: Boolean; aLeading: Integer; aTabStops: TStrings; aPrinter: TObject; var aCharPos: Integer; aWrappedText: TStrings);
var
  lTextWrapper: TppPlainTextWrapper;
begin

  lTextWrapper := TppPlainTextWrapper.Create;

  lTextWrapper.AreaAvailable := aRect;
  lTextWrapper.Alignment := aTextAlignment;
  lTextWrapper.AutoSize := aAutoSize;
  lTextWrapper.CharWrap := aCharWrap;
  lTextWrapper.Font := aFont;
  lTextWrapper.Leading := aLeading;
  lTextWrapper.Printer := TppPrinter(aPrinter);
  lTextWrapper.Tabs := aTabStops;
  lTextWrapper.Text := aText;

  try
    {set the current character position}
    lTextWrapper.CharPos := aCharPos;

    {wrap the text}
    lTextWrapper.Wrap;

    {get the new character position}
    aCharPos := lTextWrapper.CharPos;

    {get the wrapped text}
    aWrappedText.Assign(lTextWrapper.WrappedText);

  finally
    lTextWrapper.Free;
  end;

end;

{------------------------------------------------------------------------------}
{ TppPlainText.AddBreakCharsToSingleWord

  Adds a break character (space) between each letter in a string. This is used
  by the text justification method, SetCanvasToJustify.
}

class function TppPlainText.AddBreakCharsToSingleWord(aString: String; var aBreakCharCount, aStartCharCounter, aEndCharCounter: Integer): String;
var
  liIndex: Integer;
begin

  aBreakCharCount := 0;
  Result := '';

  // add a space after each letter, except the last
  for liIndex := 1 to Length(aString)- 1 do
    begin
      Result := Result + aString[liIndex] + ' ';

      Inc(aBreakCharCount);
    end;

  Result := Result + aString[length(aString)];

  aStartCharCounter := 1;
  aEndCharCounter := Length(Result);

  while Result[aStartCharCounter] = ' ' do
    Inc(aStartCharCounter);

  while Result[aEndCharCounter] = ' ' do
    Dec(aEndCharCounter);

end;

{------------------------------------------------------------------------------}
{ TppPlainText.GetTabbedTextWidth

  Calculates the width of a string when rendered to a canvas. The string can
  optionally include tab characters. An array of tabstop positions can be
  specified.
}

class function TppPlainText.GetTabbedTextWidth(aCanvas: TCanvas; const aString: String; aTabStopCount: Integer; aTabStopArray: TppTabStopPos): Integer;
var
  lDWord: DWord;
begin

  lDWord := GetTabbedTextExtent(aCanvas.Handle, PChar(aString), Length(aString), aTabStopCount, aTabStopArray);

  Result := LoWord(lDWord);

end;

{------------------------------------------------------------------------------}
{ TppPlainText.SetCanvasToJustify

  Used for justified text. Calculates the amount of extra space and the number
  of break chars, then calls Windows.SetTextJustification(Canvas, ExtraSpace, BreakCharCount)
}

class procedure TppPlainText.SetCanvasToJustify(aCanvas: TCanvas; aRect: TRect; var aString: String; aTabStopCount: Integer; aTabStopArray: TppTabStopPos);
var
  liBreakCharCount: Integer;
  liIndex: Integer;
  liStartCharCounter: Integer;
  liEndCharCounter: Integer;
  lOutputString: String;
  liTabbedTextWidth: Integer;
begin

  if aString <> '' then
    begin
      liBreakCharCount := 0;
      liStartCharCounter := 1;
      liEndCharCounter := Length(aString);

      // find start of text
      while aString[liStartCharCounter] = ' ' do
        Inc(liStartCharCounter);

      // count number of spaces in text
      for liIndex := liStartCharCounter to Length(aString) do
        if aString[liIndex] = ' ' then
          Inc(liBreakCharCount);

      // adjust for spaces at end of text
      while aString[liEndCharCounter] = ' ' do
        begin
          Dec(liEndCharCounter);
          Dec(liBreakCharCount);
        end;

      // if no break characters, then the text is single word
      if liBreakCharCount = 0 then
        aString := AddBreakCharsToSingleWord(aString, liBreakCharCount, liStartCharCounter, liEndCharCounter);

      // clear
      SetTextJustification(aCanvas.Handle, 0, 0);

      // get text (removing trailing and leading spaces)
      lOutputString := Copy(aString, liStartCharCounter, liEndCharCounter - liStartCharCounter + 1);

      // calc text width
      liTabbedTextWidth := GetTabbedTextWidth(aCanvas, lOutputString, aTabStopCount, aTabStopArray);

      // specify amount of space to be added to the break characters (Canvas.Handle, ExtraSpace, BreakCharCount)
      SetTextJustification(aCanvas.Handle, aRect.Right - aRect.Left - liTabbedTextWidth, liBreakCharCount);

      //Added 09/28/05 to strip the actual string of leading and ending spaces.
      aString := lOutputString;
    end
    
  else
    SetTextJustification(aCanvas.Handle, 0, 0);

end;

{------------------------------------------------------------------------------}
{ TppPlainText.MaxLinesFit

  Calculates line height and the maximum number of lines that can fit into
  the specified vertical space. Also set aLineHeight to be the height of a
  single line in microns.}

class function TppPlainText.MaxLinesFit(aFont: TFont; aLeading: Longint; aSpaceAvailable: Longint; aPrinter: TObject; var aLineHeight: Longint): Integer;
var
  lBitmap: TBitmap;
  lCanvas: TCanvas;
  llLineHeight: Longint;
  llSpaceAvailable: Longint;
  lTextMetric: TTextMetric;
begin

  {get a canvas}
  if (aPrinter <> nil) and (aPrinter is TppPrinter) and (TppPrinter(aPrinter).DC <> 0) then
    begin
      lCanvas := TppPrinter(aPrinter).Canvas;
      lBitmap := nil;
    end
  else
    begin
      lBitmap := TBitmap.Create;
      lCanvas := lBitmap.Canvas;
    end;

  lCanvas.Font := aFont;

  {calc the line height}
  GetTextMetrics(lCanvas.Handle, lTextMetric);

  llLineHeight := lTextMetric.tmHeight;

  {add leading to line height}
  if aLeading <> 0 then
    llLineHeight := llLineHeight + Trunc(ppFromMMThousandths(aLeading, utPrinterPixels, pprtVertical, aPrinter));

  {calculate the maximum lines which will fit in the space}
  llSpaceAvailable := Trunc(ppFromMMThousandths(aSpaceAvailable, utPrinterPixels, pprtVertical, aPrinter));

  Result := Trunc(llSpaceAvailable / llLineHeight);

  aLineHeight := ppToMMThousandths(llLineHeight, utPrinterPixels, pprtVertical, aPrinter);

  {free the canvas}
  lBitmap.Free;

end;

{------------------------------------------------------------------------------}
{ TppPlainText.ConvertTabStopPos

  Converts tab stop positions from microns to Units (screen pixels or printer pixels}

class procedure TppPlainText.ConvertTabStopPos(aUnits: TppUnitType; aTabList: TStrings; var aTabArray: TppTabStopPos; var aSize: Integer; aPrinter: TObject);
var
  liItem: Integer;
  liTabPos: Integer;
begin

  if (aUnits <> utPrinterPixels) and (aUnits <> utScreenPixels) then Exit;

  aSize := 0;

  for liItem := 0 to aTabList.Count - 1 do
    begin
      try
        // microns
        liTabPos := StrToInt(aTabList[liItem]);

        // convert to units
        aTabArray[aSize] := Trunc(ppFromMMThousandths(liTabPos, aUnits, pprtHorizontal, aPrinter));

        // count valid tab stop positions
        Inc(aSize);

      except on EConvertError do
        {do nothing}
      end; {try}

    end;

end;

{------------------------------------------------------------------------------}
{ TppPlainText.StringStrip

  Removes all occurences of a substring from a string}

  class function TppPlainText.StringStrip(const aString, aStripString: String): String;
begin

  Result := StringReplace(aString, aStripString, '', [rfReplaceAll]);

end;


{------------------------------------------------------------------------------}
{ TppPlainText.WordCount

  Counts the number of words in a string.
}

class function TppPlainText.WordCount(const aString: String): Integer;
begin
  Result := WordCountByDelimeter(aString, [' ']);
end; {class function, WordCount}


{------------------------------------------------------------------------------}
{ TppPlainText.WordCountByDelimeter

  Counts the number of words in a delimeted string.
}

class function TppPlainText.WordCountByDelimeter(const aString: String; const aDelimeters: TppAnsiCharSet): Integer;
var
  liLength: Integer;
  liIndex: Integer;
begin

  Result := 0;
  liIndex := 1;

  liLength := Length(aString);

  while (liIndex <= liLength) do
    begin
      // skip over delimters
      while ((liIndex <= liLength) and ppCharInSet(aString[liIndex], aDelimeters)) do
        Inc(liIndex);

      // increment word count
      if (liIndex <= liLength) then
        Inc(Result);

      // find the end of the word
      while ((liIndex <= liLength) and not(ppCharInSet(aString[liIndex], aDelimeters))) do
        Inc(liIndex);
    end;

end; {class function, WordCountByDelimeter}


{------------------------------------------------------------------------------}
{ TppPlainText.WordByIndex

  Returns the word at the specified index of string delimeted by spaces.}

class function TppPlainText.WordByIndex(const aString: String; aIndex: Integer): String;
begin
  Result := WordByIndexByDelimeter(aString, aIndex, [' ']);
end; {class function, WordByIndex}


{------------------------------------------------------------------------------}
{ TppPlainText.WordByIndexByDelimeter

  Returns the word at the specied index of a delimeted string. }

class function TppPlainText.WordByIndexByDelimeter(const aString: String; aIndex: Integer; const aDelimeters: TppAnsiCharSet): String;
var
  liIndex: Integer;
  liLength: Integer;
begin

  liLength := 0;

  liIndex := WordPosition(aIndex, aString, aDelimeters);

  if (liIndex <> 0) then
    while ((liIndex <= Length(aString)) and not(ppCharInSet(aString[liIndex], aDelimeters))) do
      begin
        Inc(liLength);

        SetLength(Result, liLength);

        Result[liLength] := aString[liIndex];

        Inc(liIndex);
      end;

  SetLength(Result, liLength);

end; {class function, WordByIndexByDelimeter}


{------------------------------------------------------------------------------}
{ TppPlainText.WordPosition

  Returns the starting position of a word at the specified index of a
  delimeted string.}

class function TppPlainText.WordPosition(const aWordIndex: Integer; const aString: string; const aDelimeters: TppAnsiCharSet): Integer;
var
  liCount: Integer;
  liIndex: Integer;
  liLength: Integer;
begin

  liCount := 0;
  liIndex := 1;
  Result := 0;

  liLength := Length(aString);

  while ((liIndex <= liLength) and (liCount <> aWordIndex)) do
    begin

      // skip over delimeters
      while (liIndex <= liLength) and (ppCharInSet(aString[liIndex], aDelimeters)) do
        Inc(liIndex);

      // increment word count
      if (liIndex <= liLength) then
        Inc(liCount);

      // return the word, or find the end of this word
      if (liCount <> aWordIndex) then
        while ((liIndex <= Length(aString)) and not (ppCharInSet(aString[liIndex], aDelimeters))) do
          Inc(liIndex)
      else
        Result := liIndex;
    end;

end; {class function, WordPosition}

{******************************************************************************
 *
 **  T E X T   W R A P P E R
 *
{******************************************************************************}

{ TppTextWrapperBase.Create }

constructor TppPlainTextWrapper.Create;
begin

  inherited Create;

  FAlignment := taLeftJustified;
  FAreaAvailable := ppRect(0, 0, 0, 0);
  FAutoSize := False;
  FCharPos := 0;
  FCharWrap := False;
  FFont := nil;
  FLeading := 0;
  FTabs := nil;
  FTabStopCount := 0;
  FText := '';
  FPrinter := nil;
  FWrappedText := TStringList.Create;

  FTextParser := TppPlainTextParser.Create;
  FCanvas := nil;
  FLineHeight := 0;
  FMaxLineWidth := 0;

end;

{ TppTextWrapperBase.Destroy }

destructor TppPlainTextWrapper.Destroy;
begin

  FTabs.Free;
  FTabs := nil;
  FTextParser.Free;
  FTextParser := nil;
  FWrappedText.Free;
  FWrappedText := nil;

  inherited Destroy;

end;

procedure TppPlainTextWrapper.AddWordsToLine(var aLine, aLastWord: String);
var
  lsNextWord: String;
  lbEndOfLine: Boolean;
  lbWordFit: Boolean;
  liTestWidth: Integer;
  lbSpaceChar: Boolean;
begin

  lbEndOfLine := False;

  // parse spaces at beginning of line
  while (FTextParser.PeekNextWord = TppTextMarkups.Space) do
    aLine := aLine + FTextParser.NextWord;

  // trim leading spaces, if needed
  if FTrimLeadingSpaces and (Length(aLine) <= 2) then
    aLine := '';

  while not lbEndOfLine do
    begin

      // get next word for testing
      lsNextWord := FTextParser.PeekNextWord;

      lbSpaceChar := (lsNextWord = TppTextMarkups.Space);

      // a space cannot fit at the end of the line by itself
      if lbSpaceChar then
        begin
          // NextWord = Space + PeekNextWord
          FTextParser.NextWord;

          if (FTextParser.PeekNextWord = TppTextMarkups.CRLF) then
            begin
              aLine := aLine + TppTextMarkups.Space;
              lsNextWord := TppTextMarkups.CRLF;
            end
          else
            lsNextWord := TppTextMarkups.Space + FTextParser.PeekNextWord;
        end;

      // 3 cases:
      //     - end of text
      //     - hard return
      //     - word

      if (lsNextWord = '') then // end of text
        begin
          lbWordFit := True;
          lbEndOfLine := True;
        end
      else if (lsNextWord = TppTextMarkups.CRLF) then // hard return
        begin
          // when full justified, add EOP
          if (FAlignment = taFullJustified) and not(FWantReturns) then
            aLine := aLine + TppTextMarkups.EOP;

          lbWordFit := True;
          lbEndOfLine := True;

        end
      else // check whether word fits
        begin
          liTestWidth := CalcTextWidth(aLine + lsNextWord);

          lbWordFit := liTestWidth <= FWidthAvailable;

          if lbWordFit then
            aLine := aLine + lsNextWord  // add word to line
          else
            begin
              lbEndOfLine := True;
              if CharWrap and lbSpaceChar then
                FTextParser.CharPos := FTextParser.CharPos -1;
            end;

        end;

      // call Parser.NextWord to increment the char pos
      if lbWordFit then
        aLastWord := FTextParser.NextWord;

    end;

  // add return chars, if needed
  if FWantReturns and (aLastWord = TppTextMarkups.CRLF) then
    aLine := aLine + TppTextMarkups.CRLF;

end;

{TppPlainTextWrapper.AddCharsToLine

  Called in cases in which a word cannot fit on the line, but need to fit as many
  characters of the word as possible on the line.}

procedure TppPlainTextWrapper.AddCharsToLine(var aLine: String);
var
  lsNextChar: String;
  lbEndOfLine: Boolean;
  lbCharFit: Boolean;
  liTestWidth: Integer;
begin

  lbEndOfLine := False;

  while not lbEndOfLine do
    begin

      lsNextChar := FTextParser.PeekNextChar;

      // check for end of text
      if (lsNextChar = '') then
        lbEndOfLine := True

      else // check whether char fits
        begin
          liTestWidth := CalcTextWidth(aLine + lsNextChar);

          lbCharFit := liTestWidth <= FWidthAvailable;

          // add char to line
          if lbCharFit then
            begin
              aLine := aLine + lsNextChar;
              FTextParser.NextChar; // increment the char pos
            end
          else
            lbEndOfLine := True;

        end;

    end;

  // add returns, if needed
  if FWantReturns and not(FTextParser.EndOfText) then
    aLine := aLine + TppTextMarkups.SoftReturn;


end;

procedure TppPlainTextWrapper.AddLineToText(aLine: String);
var
  liLineWidth: Integer;
begin

  liLineWidth := CalcTextWidth(aLine);

  // calc max line width
  FMaxLineWidth := Math.Max(liLineWidth, FMaxLineWidth);

  FWrappedText.Add(aLine);

//  CodeSite.Send('AddLine(' + (IntToStr(FWrappedText.Count)) + '): Length = ' + IntToStr(Length(aLine)));

end;

{ TppTextWrapperBase.CalcTextWidth

  Calculates width of text in microns}

function TppPlainTextWrapper.CalcTextWidth(const aText: String): Integer;
begin

  if (Pos(TppTextMarkups.Tab, aText) <> 0) then
    Result := TppPlainText.GetTabbedTextWidth(FCanvas, aText, FTabStopCount, FTabStopArray)
  else
    Result := FCanvas.TextWidth(aText);

  Result := ppToMMThousandths(Result, FDeviceUnits, pprtHorizontal, FPrinter)

end;

procedure TppPlainTextWrapper.Initialize;
var
  lBitmap: TBitmap;
  liThreshold: Integer;
begin

  FWrappedText.Clear;

  if FWantReturns then
    begin
      Text := StringReplace(Text, TppTextMarkups.CRLF + TppTextMarkups.SoftReturn, TppTextMarkups.CRLF, [rfReplaceAll]);
      Text := StringReplace(Text, TppTextMarkups.SoftReturnForCharWrap, '', [rfReplaceAll]);
      Text := StringReplace(Text, TppTextMarkups.SoftReturn, ' ', [rfReplaceAll]);
    end;

  // initialize references to canvas and units
  if (FPrinter <> nil) then
    begin
      lBitmap := nil;
      FDeviceUnits := utPrinterPixels;

      FCanvas := FPrinter.Canvas;
      FCanvas.Font := FFont;

    end
  else
    begin
      lBitmap := TBitmap.Create;
      FDeviceUnits := utScreenPixels;

      FCanvas := lBitmap.Canvas;
      FCanvas.Font := FFont;
    end;

  // calc line height in microns
  FLineHeight := FCanvas.TextHeight('W');
  FLineHeight := ppToMMThousandths(FLineHeight, FDeviceUnits, pprtVertical, FPrinter) + FLeading;

  // convert tab stop positions to microns
  if (FTabs <> nil) then
    TppPlainText.ConvertTabStopPos(utPrinterPixels, FTabs, FTabStopArray, FTabStopCount, FPrinter);

  // calc threshold
  if FAutoSize then
    begin
      liThreshold := FCanvas.TextWidth(TppTextMarkups.Space);
      liThreshold := ppToMMThousandths(liThreshold, FDeviceUnits, pprtVertical, FPrinter);
      liThreshold := Round(liThreshold * 0.3);
    end
  else
    liThreshold := 0;

  // initialize parser
  FTextParser.Text := FText;
  FTextParser.CharPos := FCharPos;

  FMaxLineWidth := 0;
  FWidthAvailable := (FAreaAvailable.Right - FAreaAvailable.Left) + liThreshold;

  if FBottomLess then
    FMaxLines := MaxInt
  else
    FMaxLines := (FAreaAvailable.Bottom - FAreaAvailable.Top) div FLineHeight;

  lBitmap.Free;

end;

{ TppTextWrapperBase.SetTabs }

procedure TppPlainTextWrapper.SetTabs(aTabs: TStrings);
begin

  if (FTabs = nil) and (aTabs <> nil) and (aTabs.Count > 0) then
    begin
      FTabs := TStringList.Create;

      FTabs.Assign(aTabs);
    end;

end;

{@TppTextWrapperBase.Wrap

 Wraps Text and stores result to WrappedText. Also calculates MaxLineWidth.}

procedure TppPlainTextWrapper.Wrap;
begin

  Initialize;

  WrapText;

end;

function TppPlainTextWrapper.WrapLine: String;
var
  lsLine: String;
  lsLastWord: String;
  lbLineComplete: Boolean;
  lbCharWrap: Boolean;
begin

  lsLine := '';
  lsLastWord := '';
  lbLineComplete := False;
  lbCharWrap := CharWrap;

  // determine whether to trim leading spaces
  if (FTextParser.CharPos = 0) then  // start of text
    FTrimLeadingSpaces := False
  else if (Ord(FText[FTextParser.CharPos-1]) in [13, 10]) then  // hard return
    FTrimLeadingSpaces := False
  else
    FTrimLeadingSpaces := True;


  // add words to line
  AddWordsToLine(lsLine, lsLastWord);

  if FTextParser.EndOfText then 
    lbLineComplete := True

  else if (lsLastWord = TppTextMarkups.CRLF) then
    lbLineComplete := True

  else if CharWrap then
    AddCharsToLine(lsLine)

  else if CalcTextWidth(FTextParser.PeekNextWord) > FWidthAvailable then
    // word is too big to fit on a line by itself
    begin
      lbCharWrap := True;
      AddCharsToLine(lsLine);
    end;

  if FWantReturns and not(lbLineComplete) then
    if lbCharWrap then
      lsLine := lsLine + TppTextMarkups.SoftReturnForCharWrap
    else
      lsLine := lsLine + TppTextMarkups.SoftReturn;

  Result := lsLine;

end;

{ TppTextWrapperBase.WrapText }

procedure TppPlainTextWrapper.WrapText;
var
  lsLine: string;
begin

  // add lines until either EndOfText or reach MaxLines
  while not(FTextParser.EndOfText) and (FWrappedText.Count < FMaxLines) do
    begin
      lsLine := WrapLine();

      AddLineToText(lsLine);

    end;

  FCharPos := FTextParser.CharPos;


end;





end.
