{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppCharacter;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF UNICODE} Character, {$ENDIF}
  SysUtils,
  Classes,
  ppTypes;

type

{$IFDEF UNICODE}
  TppCharacter = TCharacter;
{$ELSE}

  TppCharacter = class
  public
    class function IsLetter(aChar: Char):Boolean;
    class function IsLetterOrDigit(aChar: Char): Boolean;
    class function IsDigit(aChar: Char):Boolean;
    class function IsWhiteSpace(aChar: Char): Boolean;
  end;
{$ENDIF}

  TppAnsiStrings = array of AnsiString;

{$IFDEF UNICODE}
// Report Output. TextFileEncodingType

//  TppEncodingType = (enAuto, enDefault, enASCII, enUTF7, enUTF8, enUnicode, enBigEndianUnicode);


{$ELSE}
//  TppEncodingType = (enDefault);

  TCharArray = array of Char;

  TEncoding = class
  private
    FIsSingleByte: Boolean;
  public
    constructor Create;
    class function Default: TEncoding;

    class function GetBufferEncoding(aBuffer: TBytes; var aEncoding: TEncoding): Integer;

    function GetPreamble: TBytes;
    function GetByteCount(aString: String): Integer; overload;
    function GetByteCount(aChars: TCharArray): Integer; overload;
    function GetBytes(aString: String): TBytes; overload;
    function GetChars(const Bytes: TBytes; ByteIndex, ByteCount: Integer): TCharArray;

    property IsSingleByte: Boolean read FIsSingleByte;
  end;

{$ENDIF}

  TppEncodingUtils = class
  private
  public
    class function GetBufferEncoding(aBuffer: TBytes): TEncoding;
    class function GetStreamEncoding(aStream: TStream): TEncoding;
    class function GetDefaultEncoding: TEncoding;
    class function GetBOMLength(aEncoding: TEncoding): Integer;
  end;

  TppAnsiCharSet = set of AnsiChar;

  function ppCharSize: Integer;

  function ppCharInSet(aChar: AnsiChar; aCharSet: TppAnsiCharSet): Boolean; overload;
  function ppCharInSet(aChar: WideChar; aCharSet: TppAnsiCharSet): Boolean; overload;

  function ppCharInArray(aChar: AnsiChar; aCharSet: array of AnsiChar): Boolean; overload;
  function ppCharInArray(aChar: WideChar; aCharSet: array of WideChar): Boolean; overload;

  function ppIsLeadChar(aChar: AnsiChar): Boolean; overload;
  function ppIsLeadChar(aChar: WideChar): Boolean; overload;

  function ppByteLength(aString: String): Integer; overload;
  function ppByteLength(aPChar: PChar): Integer; overload;
  function ppByteLength(aChars: TCharArray): Integer; overload;
  function ppByteLength(aCharCount: Integer): Integer; overload;

  function ppCharLength(aByteCount: Integer): Integer; overload;

  function ppUnicodeSymbolsToAnsi(aPWideChar: PWideChar; aLength: Integer): AnsiString; overload;
{$IFDEF UNICODE}
  function ppUnicodeSymbolsToAnsi(aUnicodeString: String): AnsiString; overload;
{$ENDIF}



implementation

//const
//  uCharSize = SizeOf(Char);

var
  uEncoding: TEncoding;

function ppCharSize: Integer;
begin
  Result := SizeOf(Char);
end;

function ppCharInSet(aChar: AnsiChar; aCharSet: TppAnsiCharSet): Boolean;
begin
  Result := (aChar in aCharSet);
end;

function ppCharInSet(aChar: WideChar; aCharSet: TppAnsiCharSet): Boolean;
begin
  Result := (aChar < #$0100) and (AnsiChar(aChar) in aCharSet);

end;

function ppCharInArray(aChar: AnsiChar; aCharSet: array of AnsiChar): Boolean;
var
  liIndex: Integer;
begin

  Result := True;

  for liIndex := Low(aCharSet) to High(aCharSet) do
    if (aChar = aCharSet[liIndex]) then Exit;

  Result := False;

end;

function ppCharInArray(aChar: WideChar; aCharSet: array of WideChar): Boolean;
var
  liIndex: Integer;
begin

  Result := True;

  for liIndex := Low(aCharSet) to High(aCharSet) do
    if (aChar = aCharSet[liIndex]) then Exit;

  Result := False;

end;

function ppIsLeadChar(aChar: AnsiChar): Boolean;
begin
  Result := (aChar in LeadBytes);
end;

function ppIsLeadChar(aChar: WideChar): Boolean;
begin
  Result := (aChar >= #$D800) and (aChar <= #$DFFF);

end;

function ppByteLength(aString: String): Integer;
begin
  Result := Length(aString) * SizeOf(Char);
end;

function ppByteLength(aPChar: PChar): Integer;
begin
  Result := StrLen(aPChar) * SizeOf(Char);
end;

function ppByteLength(aChars: TCharArray): Integer;
begin
  Result := Length(aChars) * SizeOf(Char);
end;

function ppByteLength(aCharCount: Integer): Integer;
begin
  Result := aCharCount * SizeOf(Char);
end;

function ppCharLength(aByteCount: Integer): Integer; 
begin
  Result := aByteCount div SizeOf(Char);

end;

{TppCharacter }

{$IFNDEF UNICODE}

class function TppCharacter.IsDigit(aChar: Char): Boolean;
begin
  Result := aChar in ['0'..'9'];

end;

class function TppCharacter.IsLetter(aChar: Char): Boolean;
begin
  Result := aChar in ['A'..'Z', 'a'..'z'];

end;

class function TppCharacter.IsLetterOrDigit(aChar: Char): Boolean;
begin
  Result := (aChar in ['A'..'Z', 'a'..'z', '0'..'9']);
end;

class function TppCharacter.IsWhiteSpace(aChar: Char): Boolean;
begin
  Result := (aChar in [' ', #9, #13]);
end;

{$ENDIF}

{TppEncoding }

{$IFDEF UNICODE}

{$ELSE}

constructor TEncoding.Create;
begin
  inherited;
  FIsSingleByte := True; 
end;

class function TEncoding.Default: TEncoding;
begin
  Result := TppEncodingUtils.GetDefaultEncoding;
end;

class function TEncoding.GetBufferEncoding(aBuffer: TBytes; var aEncoding: TEncoding): Integer;
begin

  aEncoding := TppEncodingUtils.GetDefaultEncoding;

  Result := 0;
  
end;

function TEncoding.GetPreamble: TBytes;
begin
  SetLength(Result, 0);
end;

function TEncoding.GetByteCount(aString: String): Integer;
begin
  Result := Length(aString);

end;

function TEncoding.GetByteCount(aChars: TCharArray): Integer;
begin
  Result := Length(aChars);

end;

function TEncoding.GetBytes(aString: String): TBytes;
begin
  SetLength(Result, Length(aString));
  Move(aString[1], Result[0], Length(aString));
end;

function TEncoding.GetChars(const Bytes: TBytes; ByteIndex, ByteCount: Integer): TCharArray;
begin
  SetLength(Result, ByteCount);
  Move(Bytes[ByteIndex], Result[0], ByteCount);
end;

{$ENDIF}

{
class function TppEncoding.ContainsPreamble(const Buffer, Signature: TBytes): Boolean;
var
  liIndex: Integer;
begin

  Result := False;

  if Length(Buffer) >= Length(Signature) then
    begin
      for liIndex := 0 to Length(Signature)-1 do
        if Buffer[liIndex] <> Signature [liIndex] then Exit;

      Result := True;
    end;

end;
}
class function TppEncodingUtils.GetBOMLength(aEncoding: TEncoding): Integer;
begin
  Result := Length(aEncoding.GetPreamble);
end;

class function TppEncodingUtils.GetBufferEncoding(aBuffer: TBytes): TEncoding;
var
  lEncoding: TEncoding;
begin

  lEncoding := nil;
  
  TEncoding.GetBufferEncoding(aBuffer, lEncoding);

  Result := lEncoding;

end;

class function TppEncodingUtils.GetDefaultEncoding: TEncoding;
begin
{$IFDEF UNICODE}
  Result := TEncoding.Default;
{$ELSE}
  if (uEncoding = nil) then
    uEncoding := TEncoding.Create;

  Result := uEncoding;
{$ENDIF}

end;

class function TppEncodingUtils.GetStreamEncoding(aStream: TStream): TEncoding;
const
  cMaxPreambleSize = 10;
var
  lBuffer: TBytes;
begin
  SetLength(lBuffer, cMaxPreambleSize);
  aStream.Read(lBuffer[0], cMaxPreambleSize);

  Result := GetBufferEncoding(lBuffer);

end;

function ppUnicodeSymbolsToAnsi(aPWideChar: PWideChar; aLength: Integer): AnsiString; overload;
var
  liIndex: Integer;
  lpWChar: PWideChar;
begin
  Result := '';

  lpWChar := aPWideChar;

  for liIndex := 0 to aLength - 1 do
    begin
      Result := Result + AnsiChar(Ord(lpWChar^) - $F0000); // PUA 15 - (U+F0000 to U+FFFFD)
      Inc(lpWChar);
    end;

end;


{$IFDEF UNICODE}
function ppUnicodeSymbolsToAnsi(aUnicodeString: String): AnsiString; overload;
begin
  Result := ppUnicodeSymbolsToAnsi(PWideChar(aUnicodeString), Length(aUnicodeString));
end;
{$ENDIF}

initialization

finalization
  uEncoding.Free;
  uEncoding := nil;



end.
