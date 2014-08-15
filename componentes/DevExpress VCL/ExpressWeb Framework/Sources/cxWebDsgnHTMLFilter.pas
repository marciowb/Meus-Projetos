{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit cxWebDsgnHTMLFilter;

interface

uses Classes, SysUtils;

type
  TcxDsgnHTMLParser = class(TObject)
  private
    FBuffer: PChar;
    FIndex: Integer;
    FHasValue: Boolean;
    FLength: Integer;
    FStream: TStream;
    FStack: string;
    FFormatStore: string;
    FInsideTag: Boolean;
    FValidTag: Boolean;
    function GetToken: Char;
    function GetNextToken: Char;
    function GetStack: string;
    function GetFormating: string;
  public
    constructor Create(AStream: TStream);
    destructor Destroy; override;
    procedure SkipToken;
    procedure SkipToToken(const Ch: Char);
    procedure SkipTokens(const AChars: TSysCharSet);
    procedure SkipToNextTag;
    function IsCustomTag: Boolean;
    function IsClosingTag: Boolean;
    function IsScriptTag: Boolean;
    function IsTagBegin: Boolean;
    function IsTagEnd: Boolean;
    function IsEOF: Boolean;
    function IsSpace: Boolean;
    function TagName: string;
    function AttrName: string;
    function AttrValue: string;
    function EncodeFormating(const AStr: string): string;
    function DecodeFormating(const AFormat: string): string;
    property AttrHasValue: Boolean read FHasValue;
    property Stack: string read GetStack;
    property Formating: string read GetFormating;
    property Token: Char read GetToken;
    property NextToken: Char read GetNextToken;
    property ValidTag: Boolean read FValidTag;
  end;

procedure FilterHTMLDocument(InStream, OutStream: TStream);
procedure FilterUpHTMLDocument(InStream, OutStream: TStream);

function FilterHTMLTemplate(const St: string): string;
function FilterMSIEHTML(const St: string): string;

implementation

const
  SpaceTokens = [Chr(9), Chr(10), Chr(12), Chr(13), Chr(32)];
  SymbolTokens = ['A'..'Z', 'a'..'z', '_'];

{ TcxDsgnHTMLParser }

constructor TcxDsgnHTMLParser.Create(AStream: TStream);
begin
  FStream := AStream;
  FLength := FStream.Size - FStream.Position;
  GetMem(FBuffer, FLength);
  FStream.ReadBuffer(FBuffer^, FLength);
  FFormatStore := '';
  FInsideTag := False;
  FIndex := 0;
  FStack := '';
  FHasValue := False;
end;

destructor TcxDsgnHTMLParser.Destroy;
begin
  if FBuffer <> nil then
    FreeMem(FBuffer, FLength);
  inherited;
end;

function TcxDsgnHTMLParser.AttrValue: string;
var
  QuoteToken: Char;
begin
  Result := '';
  if FHasValue then
  begin
    if (Token = '"') or (Token = Chr(39){'}) then
    begin
      QuoteToken := Token;
      Inc(FIndex); // skip left quote
      while not IsEOF and (Token <> QuoteToken) do
      begin
        Result := Result + Token;
        Inc(FIndex);
      end;
      Inc(FIndex); // skip right quote
    end
    else
      while not IsEOF and not IsSpace and not IsTagEnd {and not IsClosingTag} do
      begin
        Result := Result + Token;
        Inc(FIndex);
      end;
    Result := StringReplace(Result, '"', '&quot;', [rfReplaceAll]);
    SkipTokens(SpaceTokens);
    FHasValue := False;
  end;
end;

function TcxDsgnHTMLParser.DecodeFormating(const AFormat: string): string;
var
  I: Integer;
begin
  Result := AFormat;
  for I := 1 to Length(Result) do
    Result[I] := Chr(Ord(Result[I]) - Ord('A'));
end;

function TcxDsgnHTMLParser.EncodeFormating(const AStr: string): string;
var
  I: Integer;
begin
  Result := AStr;
  for I := 1 to Length(Result) do
    Result[I] := Chr(Ord(Result[I]) + Ord('A'));
end;

procedure TcxDsgnHTMLParser.SkipToken;
begin
  if not IsEOF then
  begin
    if IsTagBegin then
      FInsideTag := True;
    if FInsideTag then
      FStack := FStack + Token
    else
      if Token in SpaceTokens then
        FFormatStore := FFormatStore + Token
      else
      begin
        FStack := FStack + FFormatStore + Token;
        FFormatStore := '';
      end;
    if IsTagEnd then
    begin
      FInsideTag := False;
      FFormatStore := '';
    end;
    Inc(FIndex);
  end;
end;

procedure TcxDsgnHTMLParser.SkipToToken(const Ch: Char);
begin
  while not IsEOF and (Token <> Ch) do
    SkipToken;
end;

procedure TcxDsgnHTMLParser.SkipTokens(const AChars: TSysCharSet);
begin
  while not IsEOF and (Token in AChars) do
    SkipToken;
end;

procedure TcxDsgnHTMLParser.SkipToNextTag;
begin
  SkipToToken('<');
  FValidTag := False;
end;

function TcxDsgnHTMLParser.IsCustomTag: Boolean;
begin
  Result := (Token = '#');
end;

function TcxDsgnHTMLParser.IsClosingTag: Boolean;
begin
  Result := (Token = '/');
end;

function TcxDsgnHTMLParser.IsEOF: Boolean;
begin
  Result := (Token = toEOF);
end;

function TcxDsgnHTMLParser.IsScriptTag: Boolean;
begin
  Result := (Token = '%');
end;

function TcxDsgnHTMLParser.IsTagBegin: Boolean;
begin
  Result := (Token = '<');
end;

function TcxDsgnHTMLParser.IsTagEnd: Boolean;
begin
  Result := (Token = '>');
end;

function TcxDsgnHTMLParser.IsSpace: Boolean;
begin
  Result := (Token in SpaceTokens);
end;

function TcxDsgnHTMLParser.AttrName: string;
begin
  Result := '';
  if Token in SymbolTokens then
  begin
    while not IsEOF and not IsSpace and (Token <> '=') and not IsTagEnd and not IsClosingTag do
    begin
      Result := Result + Token;
      Inc(FIndex);
    end;
    SkipTokens(SpaceTokens);
    FHasValue := (Result <> '') and (Token = '=');
    if FHasValue then
      SkipToken;
    SkipTokens(SpaceTokens);
  end;
end;

function TcxDsgnHTMLParser.TagName: string;
begin
  Result := '';
  FValidTag := False;
  if Token in SymbolTokens then
  begin
    while not IsEOF and not IsSpace and not IsTagEnd and not IsClosingTag do
    begin
      Result := Result + Token;
      Inc(FIndex);
    end;
    FValidTag := Result <> '';
    if FValidTag and IsTagEnd then
      FValidTag := Pos('--', Result) <> (Length(Result) - 1);
    SkipTokens(SpaceTokens);
  end;
end;

function TcxDsgnHTMLParser.GetToken: Char;
begin
  if FIndex < FLength then
    Result := (FBuffer + FIndex)^
  else
    Result := toEOF;
end;

function TcxDsgnHTMLParser.GetNextToken: Char;
begin
  if (FIndex + 1) < FLength then
    Result := (FBuffer + FIndex + 1)^
  else
    Result := toEOF;
end;

function TcxDsgnHTMLParser.GetStack: string;
begin
  Result := FStack;
  FStack := '';
end;

function TcxDsgnHTMLParser.GetFormating: string;
begin
  Result := EncodeFormating(FFormatStore);
end;

procedure FilterHTMLDocument(InStream, OutStream: TStream);

  procedure WriteString(const S: string);
  begin
    OutStream.WriteBuffer(PChar(S)^, Length(S));
  end;

var
  SaveOutPos: Int64;
  TagBuffer: string;
begin
  SaveOutPos := OutStream.Position;
  with TcxDsgnHTMLParser.Create(InStream) do
  try
    while not IsEOF do
    begin
      if IsTagBegin then
      begin
        SkipToken;
        if IsCustomTag then
        begin
          WriteString(Stack);
          WriteString('%');
          SkipToToken('>');
          WriteString(Stack);
          WriteString('%');
          SkipToNextTag;
        end
        else
        begin
          if IsClosingTag then
            SkipToken;
          TagBuffer := Stack;
          TagBuffer := TagBuffer + TagName;
          if ValidTag then
          begin
            { save tag position as attribute }
            TagBuffer := TagBuffer + ' ewf_fp="' + Formating + '"';
            if not IsTagEnd and not IsClosingTag then
              TagBuffer := TagBuffer + ' ';
          end
          else
            { leave current tag position }
            WriteString(DecodeFormating(Formating));
          WriteString(TagBuffer);
        end;  
      end
      else
        SkipToNextTag;
      WriteString(Stack);
    end;
  finally
    Free;
  end;
  OutStream.Position := SaveOutPos;
end;

procedure FilterUpHTMLDocument(InStream, OutStream: TStream);

  procedure WriteString(const S: string);
  begin
    OutStream.Write(PChar(S)^, Length(S));
  end;

var
  SaveOutPos: Int64;
  TagBuffer, SpaceBuffer, Attribute, CurrTag: string;
  KeepCurFormating, ExcludeTag: Boolean;
begin
  SaveOutPos := OutStream.Position;
  with TcxDsgnHTMLParser.Create(InStream) do
  try
    while not IsEOF do
    begin
      if IsTagBegin then
      begin
        WriteString(Stack);
        SkipToken;
        if IsScriptTag and (NextToken = '#') then
        begin
          WriteString(Stack);
          SkipToken;
          Stack;
          SkipToToken('%');
          WriteString(Stack);
          SkipToken;
          Stack;
          SkipToNextTag;
        end
        else
        begin
          KeepCurFormating := not IsClosingTag;
          if IsClosingTag then
            SkipToken;
          TagBuffer := Stack;
          CurrTag := TagName;
          ExcludeTag := SameText(CurrTag, 'BASE');
          { switch to lowercase tag name }
          TagBuffer := TagBuffer + LowerCase(CurrTag);
          while ValidTag and not IsTagEnd and not IsClosingTag do
          begin
            SpaceBuffer := Stack;
            { switch to lowercase attribute name }
            Attribute := LowerCase(AttrName);
            if Attribute = '' then break;
            if SameText(Attribute, 'ewf_designer') and ExcludeTag then
            begin
              { remove tag 'BASE'}
              SkipToNextTag;
              Stack;
              TagBuffer := '';
              KeepCurFormating := False;
              break;
            end;
            if SameText(Attribute, 'ewf_fp') then
            begin
              { restore tag position from attribute }
              Stack;
              WriteString(DecodeFormating(AttrValue));
              KeepCurFormating := False;
            end
            else
            begin
              TagBuffer := TagBuffer + SpaceBuffer + Attribute;
              if AttrHasValue then
              begin
                { enclose attribute value in quotes }
                TagBuffer := TagBuffer + Stack;
                TagBuffer := TagBuffer + '"' + AttrValue + '"';
              end;
            end;
          end;
          if KeepCurFormating then
            WriteString(DecodeFormating(Formating));
          WriteString(TagBuffer);
        end;
      end
      else
        SkipToNextTag;
      WriteString(Stack);
    end;
  finally
    Free;
  end;
  OutStream.Position := SaveOutPos;
end;

function FilterHTMLTemplate(const St: string): string;
var
  AInStream, AOutStream: TStringStream;
begin
  AInStream := TStringStream.Create(St);
  AOutStream := TStringStream.Create('');
  try
    FilterHTMLDocument(AInStream, AOutStream);
    Result := AOutStream.DataString;
  finally
    AInStream.Free;
    AOutStream.Free;
  end;
end;

function FilterMSIEHTML(const St: string): string;
var
  AInStream, AOutStream: TStringStream;
begin
  AInStream := TStringStream.Create(St);
  AOutStream := TStringStream.Create('');
  try
    FilterUpHTMLDocument(AInStream, AOutStream);
    Result := AOutStream.DataString;
  finally
    AInStream.Free;
    AOutStream.Free;
  end;
end;

end.
