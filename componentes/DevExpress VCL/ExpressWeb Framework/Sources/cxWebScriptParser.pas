{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Script Parser Module                                        }
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
unit cxWebScriptParser;

interface

{$I cxVer.inc}

uses Classes, SysUtils, Contnrs, HTTPApp, HTTPProd,
  cxWebAppSrv;

const
{ Script parser error codes }
  UNKNOWN_PARSER_ERROR = 0;
  UNSUPPORTED_INCLUDE_TYPE = 1;
  RECURSIVE_INCLUDE = 2;
  CANT_FIND_INCLUDE_PAGE = 3;
  CANT_FIND_INCLUDE_FILE = 4;
  INCLUSION_NOT_SUPPORTED = 5;
  EXPECTED_SYMBOL = 6;

type
  TcxWebScriptBlockType = (btEcho, btComment, btNone);

  TcxLineNumberMap = class;
  TcxIncludeFiles = class;

  PcxWebParserExcptionInfo = ^TcxWebParserExcptionInfo;
  TcxWebParserExcptionInfo = record
    Position: Integer;
    Description: string;
    ErrorCode: Integer;
    FileName: string;
  end;

  EcxWebScriptParserException = class(Exception)
  private
    FInfo: TcxWebParserExcptionInfo;
  public
    constructor Create(const AInfo: TcxWebParserExcptionInfo);
    property Info: TcxWebParserExcptionInfo read FInfo;
  end;

  TcxWebParserErrorEvent = procedure(AParserError: EcxWebScriptParserException) of object;

  TcxWebScriptParser = class
  private
    FHTMLBlocks: TStrings;
    FIncludeFiles: TcxIncludeFiles;
    FLineNumberMap: TcxLineNumberMap;
    FNeedEndLineChar: Boolean;
    FScript: string;
    FSource: TStream;
    FOnError: TcxWebParserErrorEvent;
    FOnGetFileStream: TcxWebGetFileStreamEvent;
    procedure DoOnError(AError: Exception; APosition: Integer; AFileName: string);
    function GetScript: WideString;

    function FindDestinationPos(AStr: string; var ALine, ACharPos: Integer): Boolean;
    procedure Init(AStream: TStream);
    procedure LoadFile(const AFileName: string);
    procedure LoadPage(const APageName: string);
    procedure TrimScript(var ScriptBlock: string; var APosition: Integer; IsEcho: Boolean);
    procedure WriteInclude(const AType, AName: string);
    procedure WriteScript(AScript: string; BlockType: TcxWebScriptBlockType; APosition: Integer);
    procedure WriteHTML(AHTML: string; ServerTAG: Boolean; APosition: Integer);
  protected
    function GetError(ACode: Integer; AMsg: string): EcxWebScriptParserException;
  public
    constructor Create(ANeedEndLineChar: Boolean);
    destructor Destroy; override;
    procedure ParseStream(ASource: TStream);
    procedure ParseString(const ASource: string);

    property HTMLBlocks: TStrings read FHTMLBlocks;
    property IncludeFiles: TcxIncludeFiles read FIncludeFiles;
    property LineNumberMap: TcxLineNumberMap read FLineNumberMap;
    property Script: WideString read GetScript;

    property OnError: TcxWebParserErrorEvent read FOnError write FOnError;
    property OnGetFileStream: TcxWebGetFileStreamEvent read FOnGetFileStream write FOnGetFileStream;
  end;

  PcxIncludeFile = ^TcxIncludeFile;
  TcxIncludeFile = record
    FileName: string;
    FileSource: string;
  end;

  TcxIncludeFiles = class
  private
    FList: TList;
    function GetFileName: string;
    function GetFileSource: string;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Add(AFileName: string; AFileStream: TStream);
    procedure Clear;
    procedure Delete;
    function IndexOf(AFileName: string): Integer;

    property FileName: string read GetFileName;
    property FileSource: string read GetFileSource;
  end;

  PcxLineNumbers = ^TcxLineNumbers;
  TcxLineNumbers = record
    AbsolutePosition: Integer;
    DestStartLine: Integer;
    DestStartCharPos: Integer;
    FileName: string;
    Source: string;
  end;

  TcxLineNumberMap = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetLineNumber(Index: Integer): PcxLineNumbers;
  protected
    function Add(APosition, ADestStartLine, ADestStartCharPos: Integer;
        AFileName, ASource: string): PcxLineNumbers;
    procedure Clear;
    procedure FindErrorPosition(ASource: string; AbsolutePos: Integer; out Line, CharPos: Integer);
    procedure CorrectErrorPosition(ASource: string; SkipLines, CharPos: Integer; var AbsolutePos: Integer);

    property Count: Integer read GetCount;
    property LineNumbers[Index: Integer]: PcxLineNumbers read GetLineNumber;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Convert(var APosition, ADestLine, ADestCharPos: Integer; var AFileName: string);
  end;

implementation

uses
  StrUtils, WebCntxt, cxWebScript,
  {$IFDEF VCL}
  cxWebGlobalDispImp,
  {$ENDIF}
  cxWebUtils, cxWebIntf, cxWebStrs;

{ EcxWebParserException }

constructor EcxWebScriptParserException.Create(
  const AInfo: TcxWebParserExcptionInfo);
begin
  inherited Create(AInfo.Description);
  FInfo := AInfo;
end;

{ TcxWebScriptParser }

constructor TcxWebScriptParser.Create(ANeedEndLineChar: Boolean);
begin
  FNeedEndLineChar := ANeedEndLineChar;
  FHTMLBlocks := TStringList.Create;
  FLineNumberMap := TcxLineNumberMap.Create;
  FIncludeFiles := TcxIncludeFiles.Create;
  FScript := '';
end;

destructor TcxWebScriptParser.Destroy;
begin
  FIncludeFiles.Free;
  FLineNumberMap.Free;
  FHTMLBlocks.Free;
  inherited;
end;

function TcxWebScriptParser.GetScript: WideString;
begin
  Result := FScript;
end;

function TcxWebScriptParser.FindDestinationPos(AStr: string; var ALine, ACharPos: Integer): Boolean;
var
  S: string;
  APos: Integer;
begin
  Result := False;
  APos := Pos(AStr, FScript);
  if APos > 0 then
  begin
    S := LeftStr(FScript, APos - 1);
    ALine := 1;
    while True do
    begin
      APos := Pos(#13#10, S);
      if APos = 0 then
      begin
        ACharPos := Length(S);
        break;
      end;
      Inc(ALine);
      S := RightStr(S, Length(S) - APos - 1);
    end;
    Result := True;
  end;
  if not Result then
  begin
    ALine := 0;
    ACharPos := 0;
  end;
end;

procedure TcxWebScriptParser.Init(AStream: TStream);
begin
  if IncludeFiles.FileName = '' then
  begin
    FHTMLBlocks.Clear;
    FScript := '';
    IncludeFiles.Clear;
    IncludeFiles.Add('', AStream);
    LineNumberMap.Clear;
    Assert(FSource = nil);
    FSource := AStream;
  end;
end;

procedure TcxWebScriptParser.LoadFile(const AFileName: string);
var
  IsOwned: Boolean;
  Stream: TStream;
  AFileFullName: string;
begin
  IsOwned := False;
  Stream := nil;
  if DesignerFileManager <> nil then
    Stream := DesignerFileManager.GetStream(AFileName, IsOwned);
  if (Stream = nil) and Assigned(FOnGetFileStream) then
    FOnGetFileStream(Self, AFileName, Stream, IsOwned);
  if Stream = nil then
  begin
    AFileFullName := QualifyFileName(AFileName);
    if not FileExists(AFileFullName) then
      raise GetError(CANT_FIND_INCLUDE_FILE, Format(scxCantFindIncludeFile, [AFileFullName]));
    Stream := TFileStream.Create(AFileFullName, fmOpenRead or fmShareDenyWrite);
    IsOwned := True;
  end;

  IncludeFiles.Add(AFileName, Stream);
  try
    ParseStream(Stream);
  finally
    if IsOwned then Stream.Free;
    IncludeFiles.Delete;
  end;
end;

procedure TcxWebScriptParser.LoadPage(const APageName: string);
var
  Stream: TStream;
  IsOwned: Boolean;
  Page: TObject;
  WebPage: IcxWebPage;
begin
  if not WebContext.FindPage(APageName, [], Page) then
    raise GetError(CANT_FIND_INCLUDE_PAGE, Format(scxCantFindIncludePage, [APageName]));
  if not Supports(Page, IcxWebPage, WebPage) then
    raise GetError(INCLUSION_NOT_SUPPORTED, Format(scxInclusionNotSupported, [APageName]));
  Stream := WebPage.IncludePage(APageName, IsOwned);
  try
    ParseStream(Stream);
  finally
    if IsOwned then
      Stream.Free;
  end;
end;

procedure TcxWebScriptParser.TrimScript(var ScriptBlock: string; var APosition: Integer; IsEcho: Boolean);
var
  APos: Integer;
begin
  if IsEcho then
    APos := Pos('=', ScriptBlock)
  else APos := Pos('%', ScriptBlock);
  Inc(APosition, APos);
  ScriptBlock := RightStr(ScriptBlock, Length(ScriptBlock) - APos);
  APos := Pos('%', ReverseString(ScriptBlock));
  ScriptBlock := LeftStr(ScriptBlock, Length(ScriptBlock) - APos);
end;

procedure TcxWebScriptParser.WriteInclude(const AType, AName: string);
begin
  if IncludeFiles.IndexOf(AName) <> -1 then
    raise GetError(RECURSIVE_INCLUDE, Format(scxRecursiveInclude, [AName, AType]));
  if SameText(AType, 'page') then // Do not localize
    LoadPage(AName)
  else if SameText(AType, 'file') then // Do not localize
    LoadFile(AName)
  else if SameText(AType, 'virtual') then // Do not localize
    LoadFile(AName)
  else raise GetError(UNSUPPORTED_INCLUDE_TYPE, Format(scxUnsupportedIncludeType, [AType]));
end;

procedure TcxWebScriptParser.WriteScript(AScript: string; BlockType: TcxWebScriptBlockType;
    APosition: Integer);
var
  ALine, ACharPos: Integer;
begin
  TrimScript(AScript, APosition, BlockType = btEcho);
  if not IsBlank(AScript) then
  begin
    if BlockType = btEcho then
    begin
      AScript := Format('%s.Write(%s)', [cxsoResponse, AScript]);
      if FNeedEndLineChar then AScript := AScript + ';';
    end;
    FScript := FScript + AScript + #13#10;
    FindDestinationPos(AScript, ALine, ACharPos);
    LineNumberMap.Add(APosition, ALine, ACharPos, IncludeFiles.FileName, IncludeFiles.FileSource);
  end;
end;

procedure TcxWebScriptParser.WriteHTML(AHTML: string; ServerTAG: Boolean;
    APosition: Integer);
var
  AScript: string;
  ALine, ACharPos: Integer;
begin
  if not IsBlank(AHTML) then
  begin
    FHTMLBlocks.AddObject(AHTML, TObject(ServerTAG));
    AScript := Format('%s.WriteItem(%d)', [cxsoResponse, FHTMLBlocks.Count - 1]); // Do not localize
    if FNeedEndLineChar then AScript := AScript + ';';
    FScript := FScript + AScript + #13#10;
    FindDestinationPos(AScript, ALine, ACharPos);
    LineNumberMap.Add(APosition, ALine, ACharPos, IncludeFiles.FileName, IncludeFiles.FileSource);
  end;
end;

procedure TcxWebScriptParser.ParseStream(ASource: TStream);
var
  Parser: TcxParser;
  ScriptBlock, HTMLBlock: string;
  SavedPos, SavedHTMLPos, SavedScriptPos: Integer;
  BlockType: TcxWebScriptBlockType;

  function ExtractInclude(var AType, AName: string): Boolean;
  var
    Pos: Integer;
  begin
    with Parser do
    begin
      if (NextToken = '-') and (NextToken = '-') and (NextToken = '#') then
      begin
        if (NextToken = toSymbol) and SameText(TokenString, 'include') then
        begin
          if NextToken = toSymbol then
          begin
            AType := TokenString;
            if SameText(AType, 'file') or SameText(AType, 'page') or
              SameText(AType, 'virtual') then
            begin
              if NextToken = '=' then
              begin
                if NextToken = '"' then
                begin
                  Pos := OutStringLength;
                  while not (NextToken in [toEOF, '"', '>']) do;
                  if Token = '"' then
                  begin
                    AName := RightStr(OutString, OutStringLength - Pos);
                    SetString(AName, PChar(AName), Length(AName) - 1)
                  end
                  else
                    raise GetError(EXPECTED_SYMBOL, Format(scxExpectedSymbol, ['"']));
                  while True do
                  begin
                    if NextToken = '-' then
                      if NextToken = '-' then
                        if NextToken = '>' then
                          break
                        else
                        begin
                          PrevToken;
                          PrevToken;
                        end
                      else PrevToken;
                    if IsEOF then raise GetError(EXPECTED_SYMBOL, Format(scxExpectedSymbol, ['-->']));
                  end;
                  Result := True;
                end
                else
                  raise GetError(EXPECTED_SYMBOL, Format(scxExpectedSymbol, ['"']));
              end
              else
                raise GetError(EXPECTED_SYMBOL, Format(scxExpectedSymbol, ['=']));
            end
            else
              raise GetError(EXPECTED_SYMBOL, Format(scxExpectedSymbol, ['page or file']));
          end
          else
            raise GetError(EXPECTED_SYMBOL, Format(scxExpectedSymbol, ['page or file']));
        end
        else Result := False;
      end
      else Result := False;
    end;
  end;

var
  IncludeType, IncludeFileName: string;
begin
  Init(ASource);
  SavedHTMLPos := 0;

  Parser := TcxParser.Create(ASource);
  with Parser do
  try
    while True do
    begin
      while not ((Token = '<') or IsEOF) do SkipUntilNextToken('<');
      if IsEOF then break;

      if Token = '<' then
      begin
        SavedPos := OutStringLength;
        SavedScriptPos := Parser.Position;
        if NextToken = '%' then
        begin
          try
            if NextToken = '=' then
              BlockType := btEcho
            else if Token = '-' then
            begin
              if NextToken = '-' then
                BlockType := btComment
              else
              begin
                PrevToken;
                BlockType := btNone;
              end;
            end
            else BlockType := btNone;

            while True do
            begin
              if BlockType = btComment then
              begin
                if Token = '-' then
                  if NextToken = '-' then
                    if NextToken = '%' then
                      if NextToken = '>' then
                        break
                      else
                      begin
                        PrevToken;
                        PrevToken;
                        PrevToken;
                      end
                    else
                    begin
                      PrevToken;
                      PrevToken;
                    end
                  else PrevToken;

                if Token = toEOF then
                  raise GetError(EXPECTED_SYMBOL, Format(scxExpectedSymbol, ['--%>']));
              end
              else
              begin
                if Token = '%' then
                  if NextToken = '>' then
                    break
                  else PrevToken;
                if Token = toEOF then
                  raise GetError(EXPECTED_SYMBOL, Format(scxExpectedSymbol, ['%>']));
              end;
              NextToken;
            end;
            HTMLBlock := LeftStr(OutString, SavedPos - 1);
            WriteHTML(HTMLBlock, False, SavedHTMLPos);
            if BlockType <> btComment then
            begin
              ScriptBlock := RightStr(OutString, OutStringLength - SavedPos + 1);
              WriteScript(ScriptBlock, BlockType, SavedScriptPos);
            end;
            SavedHTMLPos := Parser.Position;
            ResetOutput;
          except
            on E: Exception do
              DoOnError(E, Position, IncludeFiles.FileName);
          end;
        end
        else if Token = '!' then
        begin
          try
            if ExtractInclude(IncludeType, IncludeFileName) then
            begin
              HTMLBlock := LeftStr(OutString, SavedPos - 1);
              WriteHTML(HTMLBlock, False, SavedHTMLPos);
              WriteInclude(IncludeType, IncludeFileName);
            end
            else WriteHTML(OutString, False, SavedScriptPos);

            SavedHTMLPos := Parser.Position;
            ResetOutput;
          except
            on E: Exception do
              DoOnError(E, Position, IncludeFiles.FileName);
          end;
          if Token = toEof then break;
          NextToken;
        end
        else if Token = '#' then
        begin
          while True do
          begin
            if (NextToken = '>') then
                break;
            if Token = toEOF then
              raise GetError(EXPECTED_SYMBOL, Format(scxExpectedSymbol, ['>']));
          end;
          HTMLBlock := LeftStr(OutString, SavedPos - 1);
          WriteHTML(HTMLBlock, False, SavedHTMLPos);
          HTMLBlock := RightStr(OutString, OutStringLength - SavedPos + 1);
          WriteHTML(HTMLBlock, True, SavedScriptPos);
          SavedHTMLPos := Parser.Position;
          ResetOutput;
        end;
      end;
    end;
    WriteHTML(OutString, False, SavedHTMLPos);
  finally
    Parser.Free;
  end;
end;

procedure TcxWebScriptParser.ParseString(const ASource: string);
begin
  FSource := TStringStream.Create(ASource);
  try
    ParseStream(FSource);
  finally
    FSource.Free;
  end;
end;

function TcxWebScriptParser.GetError(ACode: Integer; AMsg: string): EcxWebScriptParserException;
var
  ErrInfo: TcxWebParserExcptionInfo;
begin
  with ErrInfo do
  begin
    ErrorCode := ACode;
    Description := AMsg;
  end;
  Result := EcxWebScriptParserException.Create(ErrInfo);
end;

procedure TcxWebScriptParser.DoOnError(AError: Exception; APosition: Integer; AFileName: string);
begin
  if not Assigned(FOnError) then Exit;
  if AError is EcxWebScriptParserException then
  begin
    (AError as EcxWebScriptParserException).FInfo.Position := APosition;
    (AError as EcxWebScriptParserException).FInfo.FileName := AFileName;
    FOnError(AError as EcxWebScriptParserException)
  end
  else FOnError(GetError(UNKNOWN_PARSER_ERROR, AError.Message));
end;

{ TcxIncludeFiles }

constructor TcxIncludeFiles.Create;
begin
  FList := TList.Create;
end;

destructor TcxIncludeFiles.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

procedure TcxIncludeFiles.Add(AFileName: string; AFileStream: TStream);
var
  Item: PcxIncludeFile;
begin
  New(Item);
  with Item^ do
  begin
    FileName := AFileName;
    AFileStream.Position := 0;
    SetLength(FileSource, AFileStream.Size);
    AFileStream.ReadBuffer(FileSource[1], AFileStream.Size);
  end;
  FList.Add(Item);
end;

procedure TcxIncludeFiles.Clear;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
    Dispose(PcxIncludeFile(FList[I]));
  FList.Clear;
end;

procedure TcxIncludeFiles.Delete;
begin
  Dispose(PcxIncludeFile(FList[FList.Count - 1]));
  FList.Delete(FList.Count - 1);
end;

function TcxIncludeFiles.IndexOf(AFileName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FList.Count - 1 do
    if CompareText(PcxIncludeFile(FList[I])^.FileName, AFileName) = 0 then
    begin
      Result := I;
      break;
    end;
end;

function TcxIncludeFiles.GetFileName: string;
begin
  if FList.Count > 0 then
    Result := PcxIncludeFile(FList[FList.Count - 1])^.FileName
  else Result := ''
end;

function TcxIncludeFiles.GetFileSource: string;
begin
  if FList.Count > 0 then
    Result := PcxIncludeFile(FList.Items[FList.Count - 1])^.FileSource
  else Result := '';
end;

{ TcxLineNumberMap }

constructor TcxLineNumberMap.Create;
begin
  FItems := TList.Create;
end;

destructor TcxLineNumberMap.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

function TcxLineNumberMap.Add(APosition, ADestStartLine, ADestStartCharPos: Integer;
    AFileName, ASource: string): PcxLineNumbers;
var
  Item: PcxLineNumbers;
begin
  New(Item);
  with Item^ do
  begin
    AbsolutePosition := APosition;
    DestStartLine := ADestStartLine;
    DestStartCharPos := ADestStartCharPos;
    FileName := AFileName;
    Source := ASource;
  end;
  FItems.Add(Item);
  Result := PcxLineNumbers(FItems[Count - 1]);
end;

procedure TcxLineNumberMap.Clear;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    Dispose(PcxLineNumbers(FItems[I]));
  FItems.Clear;
end;

procedure TcxLineNumberMap.FindErrorPosition(ASource: string; AbsolutePos: Integer; out Line, CharPos: Integer);
var
  I: Integer;
  S: string;
begin
  S := ASource;
  Line := 1;
  CharPos := 0;
  for I := 1 to AbsolutePos do
  begin
    if (I > 1) and (S[I - 1] = #13) and (S[I] = #10) then
    begin
      CharPos := 0;
      Inc(Line);
    end;
    Inc(CharPos);    
  end;
end;

procedure TcxLineNumberMap.CorrectErrorPosition(ASource: string; SkipLines, CharPos: Integer; var AbsolutePos: Integer);
var
  I: Integer;
begin
  if SkipLines = 0 then
    Inc(AbsolutePos, CharPos - 1)
  else for I := AbsolutePos + 2 to Length(ASource) do
  begin
    if (ASource[I - 2] = #13) and (ASource[I - 1] = #10) then
      Dec(SkipLines);
    if SkipLines = 0 then
    begin
      AbsolutePos := I + CharPos - 1;
      break;
    end;
  end;

end;

procedure TcxLineNumberMap.Convert(var APosition, ADestLine, ADestCharPos: Integer; var AFileName: string);
var
  I: Integer;
begin
  APosition := 0;
  for I := 0 to Count - 1 do
  begin
    if I = Count - 1 then
      APosition := LineNumbers[I]^.AbsolutePosition
    else
    if (LineNumbers[I]^.DestStartLine <= ADestLine) and
      (LineNumbers[I + 1]^.DestStartLine > ADestLine) then
    begin
      APosition := LineNumbers[I]^.AbsolutePosition;
      CorrectErrorPosition(LineNumbers[I]^.Source, ADestLine - LineNumbers[I]^.DestStartLine, ADestCharPos, APosition);
      AFileName := LineNumbers[I]^.FileName;
      if AFileName <> '' then
        FindErrorPosition(LineNumbers[I]^.Source, APosition, ADestLine, ADestCharPos);
      break;
    end;
  end;
end;

function TcxLineNumberMap.GetLineNumber(Index: Integer): PcxLineNumbers;
begin
  if (Index >= 0) and (Index < Count) then
    Result := PcxLineNumbers(FItems[Index])
  else Result := nil;
end;

function TcxLineNumberMap.GetCount: Integer;
begin
  Result := FItems.Count;
end;

end.
