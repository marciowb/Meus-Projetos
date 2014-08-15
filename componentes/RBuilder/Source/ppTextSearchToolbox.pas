{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchToolbox;

interface

uses
  Graphics, Classes, ComCtrls,
  ppDrwCmd;

type

  TppTextSearchToolbox = class;
  TppTextSearchToolboxClass = class of TppTextSearchToolbox;

  {TppTextSearchToolboxRegistry}

  TppTextSearchToolboxRegistry = class
    public
      class procedure Register(aTextSearchToolboxClass: TppTextSearchToolboxClass);
      class procedure UnRegister(aTextSearchToolboxClass: TppTextSearchToolboxClass);
      class function GetToolboxPlugin: TppTextSearchToolboxClass;
    end;

  {@TppTextSearchToolbox

    The class which contains the class functions which perform the search
    operations on a string. Provides an open architecture to alter the search
    algorithm used by the Text Search Engine and the Draw Command Highlighter.}

  TppTextSearchToolbox = class
    protected
      class function WordMatchFirstWord(const aFullText, aSearchText: String; aCaseSensitive: Boolean; var aFoundPos: Integer): Boolean;
      class function WordMatchInnerWords(const aFullText, aSearchText: String; aCaseSensitive: Boolean; var aFoundPos: Integer): Boolean;
      class function WordMatchLastWord(const aFullText, aSearchText: String; aCaseSensitive: Boolean; var aFoundPos: Integer): Boolean;

    public
      class procedure PopulateGrammaticalMarksList(aGrammaticalMarks: TStringList); virtual;
      class function CalculateLineHeight(aDrawText: TppDrawText; aCanvas: TCanvas; aScaleY: Double): Integer; virtual;
      class function CalculateTextWidth(const aText: String; aCanvas: TCanvas): Integer; virtual;
      class procedure SearchLine(const aFullText, aSearchText: String; aCaseSensitive, aWholeWord: Boolean; var aFoundPos: Integer); virtual;
      class function SearchRichText(aRichEdit: TCustomRichEdit; const aSearchText: String; aStartPosition, aLengthToSearchFromStart: Integer; aSearchTypes: TSearchTypes): Integer; virtual;
      class function StringReplace(const aFullText, aSearchText, aReplaceText: String; aReplaceAll, aCaseSensitive: Boolean): String; virtual;
    end;

implementation

uses
  SysUtils, Windows,
  ppUtils, ppTypes, ppPlainText,
  ppTextSearchError, ppDevice;

var
  uTextSearchToolboxClass: TppTextSearchToolboxClass = TppTextSearchToolbox;
  uGrammaticalMarks: TStringList = nil;

{******************************************************************************
 *
 * T E X T   S E A R C H   T O O L B O X   R E G I S T R Y
 *
{******************************************************************************}

{@TppTextSearchToolboxRegistry.Register

  Registers a TextSearch class to be used by the text search engine and the draw
  command highlghter. The registering a new class is the way to override the
  search Toolbox. The default search Toolbox uses the Delphi search
  technology.}

class procedure TppTextSearchToolboxRegistry.Register(aTextSearchToolboxClass: TppTextSearchToolboxClass);
begin
  uTextSearchToolboxClass := aTextSearchToolboxClass;
end;

{@TppTextSearchToolboxRegistry.UnRegister

  Un-registers a TextSearchToolbox plug-in class.}

class procedure TppTextSearchToolboxRegistry.UnRegister(aTextSearchToolboxClass: TppTextSearchToolboxClass);
begin
  uTextSearchToolboxClass := nil;
end;

{@TppTextSearchToolboxRegistry.GetToolboxPlugin

  Get the currently registered TextSearch plug-in class in order to make class
  function calls on the class without needing to know the class type
  in order to support different search Toolboxs.}

class function TppTextSearchToolboxRegistry.GetToolboxPlugin: TppTextSearchToolboxClass;
begin

  if (uTextSearchToolboxClass = nil) then
    uTextSearchToolboxClass := TppTextSearchToolbox;

  if (uGrammaticalMarks = nil) then
    begin
      uGrammaticalMarks := TStringList.Create;

      TppTextSearchToolbox.PopulateGrammaticalMarksList(uGrammaticalMarks);
    end;

  Result := uTextSearchToolboxClass;

end;

{******************************************************************************
 *
 * T E X T   S E A R C H   T O O L B O X   
 *
{******************************************************************************}

{@TppTextSearchToolbox.CalculateLineHeight

  The line height is calculated for the screen device based upon the leading in
  the memo and the font height.}

class function TppTextSearchToolbox.CalculateLineHeight(aDrawText: TppDrawText; aCanvas: TCanvas; aScaleY: Double): Integer;
var
  liLineHeight: Integer;
  liCalcHeight: Integer;
  liLeading: Integer;
  lTextMetric: TTextMetric;
  lSaveFont: TFont;
begin

  if (aCanvas = nil) then
    raise ESearchError.Create('TppTextMetrics.CalculateLineHeight: Must assign current canvas before calling this routine.');

  if (aCanvas.Font = nil) then
    raise ESearchError.Create('TppTextMetrics.CalculateLineHeight: Must assign current canvas before calling this routine.');

  lSaveFont := aCanvas.Font;

  aCanvas.Font := aDrawText.Font;
  aCanvas.Font.Name := TppDeviceSubstitutions.SubstituteFont(aDrawText.Font.Name);
  aCanvas.Font.Height := Round(aCanvas.Font.Height * aScaleY);

  GetTextMetrics(aCanvas.Handle, lTextMetric);

  {use default leading for this font}
  if not(aDrawText.IsMultiLine) then
    liLeading := lTextMetric.tmExternalLeading
  else
    liLeading := Trunc(ppFromMMThousandths(aDrawText.Leading, utScreenPixels, pprtVertical, nil));

  liLineHeight := lTextMetric.tmHeight + liLeading;

  if aDrawText.IsMultiLine and (aDrawText.WrappedText.Count > 0) then
    liCalcHeight := Round((aDrawText.DrawBottom - aDrawText.DrawTop) / aDrawText.WrappedText.Count)
  else
    liCalcHeight := Round(aDrawText.DrawBottom - aDrawText.DrawTop);

  if (liLineHeight > 0) and ((Abs(liCalcHeight - liLineHeight) / liLineHeight) <= 0.10) then
    liLineHeight := liCalcHeight;

  {restore font}
  aCanvas.Font := lSaveFont;

  Result := ppToMMThousandths(liLineHeight, utScreenPixels, pprtVertical, nil);

end;

{@TppTextSearchToolbox.CalculateTextWidth }

class function TppTextSearchToolbox.CalculateTextWidth(const aText: String; aCanvas: TCanvas): Integer;
var
 lTabStopArray: TppTabStopPos;
begin
  Result := TppPlainText.GetTabbedTextWidth(aCanvas, aText, 0, lTabStopArray);
end;

{@TppTextSearchToolbox.StringReplace }

class function TppTextSearchToolbox.StringReplace(const aFullText, aSearchText, aReplaceText: String; aReplaceAll, aCaseSensitive: Boolean): String;
var
  lFlags: TReplaceFlags;
begin

  lFlags := [];

  if aReplaceAll then
    lFlags := lFlags + [rfReplaceAll];

  if aCaseSensitive then
    lFlags := lFlags + [rfIgnoreCase];

  Result := SysUtils.StringReplace(aFullText, aSearchText, aReplaceText, lFlags);

end;

{@TppTextSearchToolbox.SearchLine

  Passes back the position in the FullText parameter that the SearchText begins.
  It finds the first matching occurrence using the CaseSensitve and WholeWord
  parameters to evaluate the string of text.

  If not found, then aFoundPos returns zero.}

class procedure TppTextSearchToolbox.SearchLine(const aFullText, aSearchText: String; aCaseSensitive, aWholeWord: Boolean; var aFoundPos: Integer);
var
  lsFullString: String;
  liLastPos: Integer;
  lbFound: Boolean;
begin

  if (uGrammaticalMarks.IndexOf(aSearchText) = -1) and aWholeWord then
    begin
      aFoundPos := 0;

      if (Length(aSearchText) <= Length(aFullText)) then
        begin
           lbFound := WordMatchFirstWord(aFullText, aSearchText, aCaseSensitive, aFoundPos);

          {check last word possibility}
          if not(lbFound) then
            begin
              lbFound := WordMatchLastWord(aFullText, aSearchText, aCaseSensitive, aFoundPos);

              {check the middle text for whole word}
              if not(lbFound) then
                WordMatchInnerWords(aFullText, aSearchText, aCaseSensitive, aFoundPos)
              else
                begin
                  {trim the string from the last word, since it was found there}
                  lsFullString := Copy(aFullText, 1, Length(aFullText) - Length(aSearchText));
                  liLastPos := aFoundPos;

                  if not(WordMatchInnerWords(lsFullString, aSearchText, aCaseSensitive, aFoundPos)) then
                    aFoundPos := liLastPos;

                end;

            end;

        end;
    end

  else
    begin
      if aCaseSensitive then
        aFoundPos := Pos(aSearchText, aFullText)
      else
        aFoundPos := Pos(AnsiUpperCase(aSearchText), AnsiUpperCase(aFullText));
    end;

end;

{@TppTextSearchToolbox.WordMatchFirstWord

  Check first word.}

class function TppTextSearchToolbox.WordMatchFirstWord(const aFullText, aSearchText: String; aCaseSensitive: Boolean; var aFoundPos: Integer): Boolean;
var
  liSearchLength: Integer;
  liFullLength: Integer;
  liNextCharPos: Integer;
  liPos: Integer;
  lsFirstWord: String;
begin

  liFullLength := Length(aFullText);
  liSearchLength := Length(aSearchText);

  lsFirstWord := Copy(aFullText, 0, liSearchLength);

  if aCaseSensitive then
    liPos := AnsiCompareStr(lsFirstWord, aSearchText)
  else
    liPos := AnsiCompareText(lsFirstWord, aSearchText);

  liNextCharPos := liSearchLength + 1;

  {if the first word matched, then need to compare the next character}
  if (liPos = 0) then
    begin
      aFoundPos := 1;

      {if there is a next character to compare}
      if (liFullLength > 0) and (liNextCharPos < liFullLength) and (uGrammaticalMarks.IndexOf(aFullText[liNextCharPos]) = -1) then
        begin
          aFoundPos := 0;
          liPos := -1;
        end;

    end;

  if (liPos = 0) then
    Result := True
  else
    Result := False;

end;

{@TppTextSearchToolbox.WordMatchLastWord

  Check last word.}

class function TppTextSearchToolbox.WordMatchLastWord(const aFullText, aSearchText: String; aCaseSensitive: Boolean; var aFoundPos: Integer): Boolean;
var
  liFullLength: Integer;
  liSearchLength: Integer;
  liPos: Integer;
  lsLastWord: String;
  liLastWordStartIndex: Integer;
begin

  liSearchLength := Length(aSearchText);
  liFullLength := Length(aFullText);

  liLastWordStartIndex := liFullLength - liSearchLength;

  lsLastWord := Copy(aFullText, liLastWordStartIndex, liSearchLength);

  if aCaseSensitive then
    liPos := AnsiCompareStr(lsLastWord, aSearchText)
  else
    liPos := AnsiCompareText(lsLastWord, aSearchText);

  if (liPos <> 0) and (liFullLength > 0) and (liLastWordStartIndex > 0) and (uGrammaticalMarks.IndexOf(aFullText[liLastWordStartIndex]) <> -1) then
    aFoundPos := liLastWordStartIndex
  else
    liPos := -1;

  if (liPos = 0) then
    Result := True
  else
    Result := False;

end;

{@TppTextSearchToolbox.WordMatchInnerWords

  Check words in the middle of the line for whole word matches.}

class function TppTextSearchToolbox.WordMatchInnerWords(const aFullText, aSearchText: String; aCaseSensitive: Boolean; var aFoundPos: Integer): Boolean;
var
  liSearchLength: Integer;
  lsPrefix: String;
  lsPostfix: String;
  liTotalPos: Integer;
  liPos: Integer;
  lsFullString: String;
begin

  {find first occurance of sub string, then compare the adjacent chars}
  lsFullString := aFullText;
  liPos := -1;
  liTotalPos := 0;
  liSearchLength := Length(aSearchText);
  aFoundPos := 0;
  
  while (liPos <> 0) do
    begin

      if aCaseSensitive then
        liPos := Pos(aSearchText, lsFullString)
      else
        liPos := Pos(AnsiUpperCase(aSearchText), AnsiUpperCase(lsFullString));

      if (liPos <> 0) and (Length(lsFullString) > 1) then
        begin

          if (liPos = 1) then
            lsPrefix := uGrammaticalMarks[0]
          else
            lsPrefix := lsFullString[liPos - 1];

          if ((liPos + liSearchLength) < Length(lsFullString)) then
            lsPostfix := lsFullString[liPos + liSearchLength]
          else
            lsPostfix := uGrammaticalMarks[0];

          {did not find it}
          if (uGrammaticalMarks.IndexOf(lsPrefix) = -1) or (uGrammaticalMarks.IndexOf(lsPostfix) = -1) then
            begin
              lsFullString := Copy(lsFullString, liPos + liSearchLength, Length(lsFullString));

              liTotalPos := liTotalPos + liPos + liSearchLength - 1;
            end
          else if (uGrammaticalMarks.IndexOf(lsPrefix) <> -1) and (uGrammaticalMarks.IndexOf(lsPostfix) <> -1) then
            begin
              aFoundPos := liTotalPos + liPos;
              liPos := 0;
            end;

        end
      else
        liPos := 0;

    end;

  if (liPos = 0) then
    Result := False
  else
    Result := True;

end;

{@TppTextSearchToolbox.SearchRichText

  Returns the position in the rich text to select to find the occurrence.}

class function TppTextSearchToolbox.SearchRichText(aRichEdit: TCustomRichEdit; const aSearchText: String; aStartPosition, aLengthToSearchFromStart: Integer; aSearchTypes: TSearchTypes): Integer;
begin
  Result := aRichEdit.FindText(aSearchText, aStartPosition, aLengthToSearchFromStart, aSearchTypes);
end;

{@TppTextSearchToolbox.PopulateGrammaticalMarksList

  A list of all the characters which can be treated the same as a space when
  identifying whole words in a plain text search.}

class procedure TppTextSearchToolbox.PopulateGrammaticalMarksList(aGrammaticalMarks: TStringList);
begin
  aGrammaticalMarks.Clear;

  aGrammaticalMarks.Add(' ');
  aGrammaticalMarks.Add('"');
  aGrammaticalMarks.Add('.');
  aGrammaticalMarks.Add('''');
  aGrammaticalMarks.Add(',');
  aGrammaticalMarks.Add('?');
  aGrammaticalMarks.Add(';');
  aGrammaticalMarks.Add(':');
  aGrammaticalMarks.Add('(');
  aGrammaticalMarks.Add(')');
  aGrammaticalMarks.Add('!');
  aGrammaticalMarks.Add('@');
  aGrammaticalMarks.Add('#');
  aGrammaticalMarks.Add('$');
  aGrammaticalMarks.Add('%');
  aGrammaticalMarks.Add('^');
  aGrammaticalMarks.Add('&');
  aGrammaticalMarks.Add('*');
  aGrammaticalMarks.Add('-');
  aGrammaticalMarks.Add('+');
  aGrammaticalMarks.Add('=');
  aGrammaticalMarks.Add('{');
  aGrammaticalMarks.Add('}');
  aGrammaticalMarks.Add('[');
  aGrammaticalMarks.Add(']');
  aGrammaticalMarks.Add('/');
  aGrammaticalMarks.Add('~');
  aGrammaticalMarks.Add('`');
  aGrammaticalMarks.Add('|');
  aGrammaticalMarks.Add('\');
end;

initialization
  if (uGrammaticalMarks = nil) then
    begin
      uGrammaticalMarks := TStringList.Create;

      TppTextSearchToolbox.PopulateGrammaticalMarksList(uGrammaticalMarks);
    end;

finalization
  uGrammaticalMarks.Free;
  uGrammaticalMarks := nil;

end.
