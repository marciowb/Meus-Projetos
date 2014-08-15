{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppStrUtils;

interface

{$I ppIfDef.pas}

type

  {TppStrUtils

    A collection of string functions that have been optimized over their
    Delphi counterparts or are otherwise absent from the Delphi library.}

  TppStrUtils = class
    public
      class function LeftString(const aText: String; const aCount: Integer): String;
      class function PosBack(aSubString, aString: String; aIndex: Integer = 0): Integer;
      class function ReplaceSubstring(aSubString, aString: String; aBeginIndex, aEndIndex: Integer): String;
      {$IFNDEF Delphi7}
      class function PosEx(const aSubString, aString: string; aOffset: Cardinal = 1): Integer;
      {$ENDIF}

  end;

implementation

uses
  SysUtils;

{------------------------------------------------------------------------------}
{ TppStrUtils.PosBack
    PosBack searches for the first occurence of a substring within a string
    starting at an index. If no index is passed the search begins at the
    end of the string. This could be further optimized with something like
    Karp-Rabin.                                                                }

class function TppStrUtils.PosBack(aSubString: String; aString: String; aIndex: Integer = 0): Integer;
var
  lpStr: PChar;
  lpSub: PChar;

  lpStrBegin: PChar;
  lpSubBegin: PChar;
  lpSubEnd: PChar;
begin

  Result := 0;

  lpStrBegin := PChar(aString);
  lpSubBegin := PChar(aSubString);
  lpSubEnd := lpSubBegin + Length(aSubString) - 1;

  if (aString = '') then
    lpStr := nil
  else if (aIndex = 0) then
    lpStr := lpStrBegin + Length(aString) - 1
  else
    lpStr := lpStrBegin + aIndex;
    
  lpSub := lpSubEnd;

  if (lpStr = nil) then
    Result := 0
  else
    while(lpStr <> lpStrBegin) and (Result = 0) do
      begin

        { do the current characters match }
        if (lpStr^ = lpSub^) then
          begin
            if (lpSub = lpSubBegin) then
              Result := lpStr - lpStrBegin
            else
              lpSub := lpSub - 1;
          end

        { do we have a new start of the substring }
        else if (lpStr^ = lpSubEnd^) then
          lpSub := lpSubEnd - 1

        { start all over }
        else
          lpSub := lpSubEnd;

        lpStr := lpStr - 1;

      end;

  if (lpSub = lpSubBegin) then
    Result := Result + 1; // need to adjust by one

end;

{------------------------------------------------------------------------------}
{ TppStrUtils.ReplaceSubstring
    Replace substring replaces a single occurence of a substring in the main
    string with another substring. The substring of the main string to be
    replaced is determined by aBeginIndex and aEndIndex inclusive.             }

class function TppStrUtils.ReplaceSubstring(aSubString: String; aString: String; aBeginIndex: Integer; aEndIndex: Integer): String;
var
  lsString: String;
  lpSrc: PChar;
  lpDst: PChar;
  lpBegins: Array[0..2] of PChar;
  lpEnds: Array[0..2] of PChar;
  liIndex: Integer;
begin

  { beginning of the main string }
  lpBegins[0] := PChar(aString);
  { beginning of the substring }
  lpBegins[1] := PChar(aSubString);
  { beginning of the remainder of the main string }
  lpBegins[2] := lpBegins[0] + aEndIndex;

  { end of the first part of the main string }
  lpEnds[0] := lpBegins[0] + aBeginIndex;
  { end of the substring }
  lpEnds[1] := lpBegins[1] + Length(aSubString) - 1;
  { end of the main string }
  lpEnds[2] := lpBegins[0] + Length(aString) - 1;

  SetLength(lsString, Length(aSubString) + Length(aString) - (aEndIndex - aBeginIndex - 1));

  lpDst := PChar(lsString);

  { copy the source data into the destination string in the following order:
    1. main string through begin index,
    2. substring,
    3. main string from end index to end }
  for liIndex := 0 to 2 do
    begin

      lpSrc := lpBegins[liIndex];

      while (lpSrc <= lpEnds[liIndex]) do
        begin
          lpDst^ := lpSrc^;

          lpSrc := lpSrc + 1;
          lpDst := lpDst + 1;
        end;
    end;

  Result := lsString;

end;

{@TppStrUtils.LeftString }

class function TppStrUtils.LeftString(const aText: String; const aCount: Integer): String;
begin
  Result := Copy(aText, 1, aCount);
end;

{@TppStrUtils.PosEx }
{$IFNDEF Delphi7}
class function TppStrUtils.PosEx(const aSubString, aString: string; aOffset: Cardinal = 1): Integer;
var
  liI: Integer;
  liX: Integer;
  liLen: Integer;
  liLenSubStr: Integer;
begin

  if aOffset = 1 then
    Result := Pos(aSubString, aString)
  else
    begin
      liI := aOffset;
      liLenSubStr := Length(aSubString);
      liLen := Length(aString) - liLenSubStr + 1;

      while liI <= liLen do
        begin
          if aString[liI] = aSubString[1] then
            begin
              liX := 1;

              while (liX < liLenSubStr) and (aString[liI + liX] = aSubString[liX + 1]) do
                Inc(liX);

              if (liX = liLenSubStr) then
                begin
                  Result := liI;
                  exit;
                end;

            end;
            Inc(liI);
          end;

      Result := 0;
    end;

end;
{$ENDIF}

end.
