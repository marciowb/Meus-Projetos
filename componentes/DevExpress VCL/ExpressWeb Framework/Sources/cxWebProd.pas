{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Page Producer                                               }
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

unit cxWebProd;

interface

{$I cxVer.inc}

uses Classes, SysUtils, HTTPProd,
  cxWebIntf, cxWebHTMLProd;

type
  EcxWebPreParsingException = class(Exception)
  private
    FPosition: Integer;
  public
    constructor Create(const Msg: string; const Pos: Integer);
    property Position: Integer read FPosition;
  end;

  PcxScriptBlock = ^TcxScriptBlock;
  TcxScriptBlock = record
    Script: string;
    ScriptLanguage: string;
    BeginPos: Integer;
    EndPos: Integer;
  end;

  TcxWebModulePageProducer = class(TBasePageProducer)
  private
    FPageModule: TComponent;
    FScriptBlocks: TList;
    function GetScriptBlock(Index: Integer): TcxScriptBlock;
    function GetScriptBlockCount: Integer;
    function GetIsFirstRequest: Boolean;
  protected
    function GetWebHtmlProdClass: TcxWebHTMLProdClass; virtual;
    procedure DoTagEvent(Tag: TTag; const TagString: string; TagParams: TStrings;
       var ReplaceText: string); override;
    function GetScriptEngine: string; override;
    procedure AddScriptBlock(AScript: string; AScriptLanguage: string;
        ABeginPos, AEndPos: Integer);
    procedure ClearScriptBlocks;
    procedure InitScriptBlocks(AContent: string); virtual;

    procedure FindErrorPosition(ASource: string; AbsolutePos: Integer; out Line, CharPos: Integer);
    function HandlePreParsingErrors(E: EcxWebPreParsingException; ASource: string): EScriptError;
    function HandleScriptErrors(E: EScriptError; ASource: string; ABlock: TcxScriptBlock): EScriptError;

    property ScriptBlocks[Index: Integer]: TcxScriptBlock read GetScriptBlock;
    property ScriptBlockCount: Integer read GetScriptBlockCount;
    function HandleScriptTag(const TagString: string;
      TagParams: TStrings; var ReplaceString: string): Boolean; override;
    function HandleTag(const TagString: string; TagParams: TStrings): string; override;
    function ParseServerScripts(Input: string): string;

    property IsFirstRequest: Boolean read GetIsFirstRequest;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ContentFromStream(Stream: TStream): string; override;
    function GetServerScript(Stream: TStream): string;
    property OnHTMLTag;
  end;

implementation

uses
  cxWebScript,
  {$IFDEF VCL}
  cxScriptDispFactory,
  {$ENDIF}
  StrUtils, TypInfo, cxWebStrs, cxWebUtils;

{ EcxWebPreParsingException }

constructor EcxWebPreParsingException.Create(const Msg: string; const Pos: Integer);
begin
  inherited Create(Msg);
  FPosition := Pos;
end;

{ TcxWebModulePageProducer }

constructor TcxWebModulePageProducer.Create(AOwner: TComponent);
begin
  if csDesigning in AOwner.ComponentState then
    inherited Create(nil)
  else
    inherited Create(AOwner);
  FPageModule := AOwner;
  FScriptBlocks := TList.Create;
end;

destructor TcxWebModulePageProducer.Destroy;
begin
  ClearScriptBlocks;
  FScriptBlocks.Free;
  inherited Destroy;
{$IFDEF VCL}
  if ScriptDispFactory <> nil then
    ScriptDispFactory.ReleaseInstance;
{$ENDIF}
end;

function TcxWebModulePageProducer.ContentFromStream(Stream: TStream): string;
var
  HTMLProd: TcxWebHTMLProd;
  IsInserted: Boolean;
begin
  IsInserted := False;
  if Owner = nil then
  begin
    IsInserted := True;
    FPageModule.InsertComponent(Self);
  end;

  HTMLProd := GetWebHtmlProdClass.Create(FPageModule);
  try
    SetLength(Result, Stream.Size);
    Stream.ReadBuffer(Result[1], Stream.Size);
    Result := ParseServerScripts(Result);
    HTMLProd.ParseHTML(Result);
    Result := HTMLProd.RenderHTML;
  finally
    HTMLProd.Free;
    if IsInserted then
      FPageModule.RemoveComponent(Self);
  end;
end;

function TcxWebModulePageProducer.GetWebHtmlProdClass: TcxWebHTMLProdClass;
begin
  Result := TcxWebHTMLProd;
end;

procedure TcxWebModulePageProducer.DoTagEvent(Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  inherited DoTagEvent(Tag, TagString, TagParams, ReplaceText);
end;

const
  scxScript = 'serverscript';

function TcxWebModulePageProducer.GetScriptEngine: string;
var
  PageIntf: IcxWebPage;
begin
  if Supports(Owner, IcxWebPage, PageIntf) then
    Result := AvailableScriptEngines.GetEngineName(PageIntf.GetServerScript)
  else
    Result := '';
end;

procedure TcxWebModulePageProducer.AddScriptBlock(AScript: string; AScriptLanguage: string;
  ABeginPos, AEndPos: Integer);
var
  Block: PcxScriptBlock;
begin
  New(Block);
  with Block^ do
  begin
    Script := AScript;
    ScriptLanguage := AScriptLanguage;
    BeginPos := ABeginPos;
    EndPos := AEndPos;
  end;
  FScriptBlocks.Add(Block);
end;

procedure TcxWebModulePageProducer.ClearScriptBlocks;
var
  I: Integer;
begin
  for I := 0 to FScriptBlocks.Count - 1 do
    Dispose(PcxScriptBlock(FScriptBlocks.Items[I]));
  FScriptBlocks.Clear;
end;

procedure TcxWebModulePageProducer.InitScriptBlocks(AContent: string);
var
  AStream: TStream;
  Parser: TcxParser;
  SavedPos, ABeginBlockPos, AEndBlockPos: Integer;
  AScriptLanguage, ANewScriptLanguage: string;
begin
  ClearScriptBlocks;
  AStream := TStringStream.Create(AContent);
  try
    Parser := TcxParser.Create(AStream);
    AScriptLanguage := ScriptEngine;
    try
      with Parser do
      begin
        ABeginBlockPos := 0;
        while true do
        begin
          while not ((Token = '<') or IsEOF) do NextToken;
          if IsEOF then break;

          AEndBlockPos := Parser.Position - 1;
          SavedPos := OutStringLength;
          if NextToken = '%' then
          begin
            if (NextToken = toSymbol) and SameText(TokenString, scxScript) then
            begin
              if (NextToken = '=') then
              begin
                if (NextToken = toSymbol) then
                begin
                  ANewScriptLanguage := TokenString;
                  if AvailableScriptEngines.IndexOfName(ANewScriptLanguage) < 0 then
                    raise EcxWebPreParsingException.Create(Format(scxUnknownScriptEngine, [ANewScriptLanguage]), Position);
                  AddScriptBlock(LeftStr(OutString, SavedPos - 1), AScriptLanguage, ABeginBlockPos, AEndBlockPos);
                  if NextToken <> '%' then
                    raise EcxWebPreParsingException.Create(Format(scxExpectedSymbol, ['%']), Position);
                  if NextToken <> '>' then
                    raise EcxWebPreParsingException.Create(Format(scxExpectedSymbol, ['>']), Position);
                  ResetOutput;
                  AScriptLanguage := ANewScriptLanguage;
                  ABeginBlockPos := Parser.Position;
                end
              end
              else raise EcxWebPreParsingException.Create(Format(scxExpectedSymbol, ['=']), Position);
            end
            else if (Token = '/') and (NextToken = toSymbol) and
                SameText(TokenString, scxScript) then
            begin
              AddScriptBlock(LeftStr(OutString, SavedPos - 1), AScriptLanguage, ABeginBlockPos, AEndBlockPos);
              if NextToken <> '%' then
                raise EcxWebPreParsingException.Create(Format(scxExpectedSymbol, ['%']), Position);
              if NextToken <> '>' then
                raise EcxWebPreParsingException.Create(Format(scxExpectedSymbol, ['>']), Position);
              ResetOutput;
              AScriptLanguage := ScriptEngine;
              ABeginBlockPos := Parser.Position;
            end;
          end;
        end;
        AddScriptBlock(OutString, AScriptLanguage, ABeginBlockPos, Parser.Position);
      end;
    finally
      Parser.Free;
    end;
  finally
    AStream.Free;
  end;
end;

procedure TcxWebModulePageProducer.FindErrorPosition(ASource: string; AbsolutePos: Integer; out Line, CharPos: Integer);
var
  I: Integer;
  S: string;
begin
  S := ASource;
  Line := 1;
  CharPos := 0;
  if (AbsolutePos >=0) and (AbsolutePos < Length(S)) then
  begin
    for I := 1 to AbsolutePos do
    begin
      if (I > 1) and (S[I - 1] = #13) and (S[I] = #10) then
      begin
        CharPos := -1;
        Inc(Line);
      end;
      Inc(CharPos);
    end;
  end;
end;

function TcxWebModulePageProducer.HandlePreParsingErrors(E: EcxWebPreParsingException; ASource: string): EScriptError;
var
  ALine, ACharPos: Integer;
  AErrors: TcxWebScriptErrors;
  AError: TcxWebScriptError;
  AStrings: TStringList;
begin
  AErrors := TcxWebScriptErrors.Create;
  AError := TcxWebScriptError.Create;
  AError.Position := E.Position;
  AError.Description := E.Message;
  AError.Source := scxWebPreParsingError;
  FindErrorPosition(ASource, AError.Position, ALine, ACharPos);
  AError.Line := ALine;
  AError.CharPos := ACharPos;
  if AError.SourceLine = '' then
  begin
    AStrings := TStringList.Create;
    AStrings.Text := ASource;
    if (0 <= ALine - 1) and (ALine - 1 < AStrings.Count) then
      AError.SourceLine := AStrings.Strings[ALine - 1];
    AStrings.Free;
  end;
  AErrors.Add(TcxWebScriptError.Create(AError));
  Result := EScriptError.Create(AErrors, ASource);
end;

function TcxWebModulePageProducer.HandleScriptErrors(E: EScriptError;
  ASource: string; ABlock: TcxScriptBlock): EScriptError;
var
  I, ALine, ACharPos: Integer;
  AErrors: TcxWebScriptErrors;
  AError: TcxWebScriptError;
  AStrings: TStringList;
begin
  AErrors := TcxWebScriptErrors.Create;
  for I := 0 to E.Errors.Count - 1 do
    if E.Errors[I] is TcxWebScriptError then
    begin
      AError := TcxWebScriptError(E.Errors[I]);
      if AError.FileName = '' then
      begin
        AError.Position := AError.Position + ABlock.BeginPos;
        FindErrorPosition(ASource, AError.Position, ALine, ACharPos);
        AError.Line := ALine;
        AError.CharPos := ACharPos;
        if AError.SourceLine = '' then
        begin
          AStrings := TStringList.Create;
          AStrings.Text := ASource;
          if (0 <= ALine - 1) and (ALine - 1 < AStrings.Count) then
            AError.SourceLine := AStrings.Strings[ALine - 1];
          AStrings.Free;
        end;
      end;
    end;
  for I := 0 to E.Errors.Count - 1 do
  begin
    AError := TcxWebScriptError(E.Errors[I]);
    AErrors.Add(TcxWebScriptError.Create(AError));
  end;
  Result := EScriptError.Create(AErrors, E.Content);
end;

function TcxWebModulePageProducer.GetServerScript(Stream: TStream): string;
begin
  Result := ServerScriptFromStream(Stream);
end;

function TcxWebModulePageProducer.HandleScriptTag(const TagString: string;
  TagParams: TStrings; var ReplaceString: string): Boolean;
begin
  Result := False;
end;

function TcxWebModulePageProducer.HandleTag(const TagString: string;
  TagParams: TStrings): string;
begin
  Result := ImplHandleTag(TagString, TagParams);
end;

function TcxWebModulePageProducer.ParseServerScripts(Input: string): string;

  function GetLocateFileService: ILocateFileService;
  var
    GetIntf: IGetLocateFileService;
  begin
    Result := nil;
    if DispatcherComponent <> nil then
      if Supports(IUnknown(DispatcherComponent), IGetLocateFileService, GetIntf) then
        Result := GetIntf.GetLocateFileService;
  end;

var
  I: Integer;
  AScriptEngine: string;
  InStream: TStringStream;
begin
  InStream := TStringStream.Create(Input);
  try
    Result := '';
    try
      InitScriptBlocks(Input);
      for I := 0 to ScriptBlockCount - 1 do
      begin
        cxInitScriptProducer(AvailableScriptEngines.GetProducerClass(ScriptBlocks[I].ScriptLanguage));
        try
          InStream.Position := 0;
          InStream.WriteString(ScriptBlocks[I].Script);
          InStream.Position := 0;
          AScriptEngine := ScriptBlocks[I].ScriptLanguage;
          try
            Result := Result + HttpProd.ContentFromScriptStream(InStream, WebModuleContext, StripParamQuotes, HandleTag,
              nil, AScriptEngine, GetLocateFileService)
          except
            on E: EScriptError do
              raise HandleScriptErrors(E, Input, ScriptBlocks[I]);
            else raise;
          end;
        finally
          cxFinishScriptProducer;
        end;
      end;
    except
      on E: EcxWebPreParsingException do
        raise HandlePreParsingErrors(E, Input);
      else raise;
    end;
    InStream.WriteString('<html></html>');
  finally
    InStream.Free;
  end;
end;

function TcxWebModulePageProducer.GetScriptBlock(Index: Integer): TcxScriptBlock;
begin
  Result := TcxScriptBlock(FScriptBlocks.Items[Index]^);
end;

function TcxWebModulePageProducer.GetScriptBlockCount: Integer;
begin
  Result := FScriptBlocks.Count;
end;

function TcxWebModulePageProducer.GetIsFirstRequest: Boolean;
var
  ClientData: IcxWebClientData;
begin
  if Supports(FPageModule, IcxWebClientData, ClientData) then
    Result := ClientData.GetIsFirstRequest
  else Result := true;
end;

end.
