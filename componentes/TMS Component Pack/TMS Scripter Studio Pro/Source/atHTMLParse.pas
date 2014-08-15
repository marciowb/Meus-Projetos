unit atHTMLParse;

interface

uses
  SysUtils, Classes;

type
  TatLanguage = (alPascal, alBasic);
  TAfterPreCompileEvent = procedure (Sender: TObject; ALanguage: TatLanguage; PreCompiledCode: TStrings) of object;
  TDirectiveEvent = procedure (Sender: TObject; const ADirective: string; var AReplace: string) of object;

procedure ParseWebScript(AInStream: TStream; AOutCode: TStrings;var ALanguage: TatLanguage; var AOptionExplicit: Boolean; Sender: TObject = nil; ADirProc: TDirectiveEvent = nil);

implementation

const
  PS_START     = 0;
  PS_READLANG  = 1;
  PS_READ      = 2;
  PS_READCODE  = 3;
  PS_READDIR   = 4;
  PS_READDIRVB = 5;
  PS_READEVAL  = 6;
  PS_END       = 7;

procedure ParseWebScript(AInStream: TStream; AOutCode: TStrings;var ALanguage: TatLanguage; var AOptionExplicit: Boolean; Sender: TObject; ADirProc: TDirectiveEvent);
const
  CAQuote: array[TatLanguage] of string = ('''', '"');
  CAConCat: array[TatLanguage] of string = (' + ', ' & ');
  CALnStart: array[TatLanguage] of string = ('WriteLn(', 'WriteLn(');
  CALnEnd: array[TatLanguage] of string = (');', ')');
  CAVarToStrStart: array[TatLanguage] of string = (' VarToStr(', ' VarToStr(');
  CAVarToStrEnd: array[TatLanguage] of string = (') ', ' )');
var
  EndOfStream: Boolean;
  iPState, iPrevState: integer;
  Buf: array[0..20] of Char; // The buffer size = 10 -> PeekString has a max. of 10 !!
  CPrev, CCur, CNext, CLast: ^Char;
  SCurLang, SCurData, SCurEval, SCurCode, SCurDir, SDirRepl: string;

  function ScrQuote: string;
  begin
    Result := CAQuote[ALanguage];
  end;

  function ScrConCat: string;
  begin
    Result := CAConCat[ALanguage];
  end;

  function ScrLnStart: string;
  begin
    Result := CALnStart[ALanguage];
  end;

  function ScrLnEnd: string;
  begin
    Result := CALnEnd[ALanguage];
  end;

  function ScrEvalStart: string;
  begin
    Result := CAVarToStrStart[ALanguage];
  end;

  function ScrEvalEnd: string;
  begin
    Result := CAVarToStrEnd[ALanguage];
  end;

  procedure SetParserState(ANewState: integer);
  begin
    if ANewState <> iPState then
    begin
      iPrevState := iPState;
      iPState := ANewState;
    end;
  end;

  function GetNextChar: Char;
  var
    i: integer;
  begin
    // Shift the buffer
    for i := Low(Buf) + 1 to High(Buf) do Buf[i-1] := Buf[i];

    if AInStream.Position < AInStream.Size then
      AInStream.Read(CLast^, SizeOf(Char))
    else begin
      EndOfStream := True;
      CLast^ := #0;
    end;
    Result := CCur^;
  end;

  function PeekString(ACount: integer): string;
  begin
    SetString(Result, PChar(CNext), ACount * SizeOf(Char));
  end;

  function CompareBuf(ACompare: string; SkipIfTrue: Boolean): Boolean;
  var
    S: string;
    i: integer;
  begin
    // The first char will be deleted since this is checked in the main-loop.
    // The reason for this is to make the keywords in the loop a little more
    // readable.
    Delete(ACompare, 1, 1);
    SetString(S, PChar(CNext), Length(ACompare));
    Result := SameText(S, ACompare);
    if Result and SkipIfTrue then
      for i := 1 to Length(S) do GetNextChar;
  end;

  procedure ProcessChar;
  begin
    case iPState of
      PS_READLANG:
        SCurLang := SCurLang + CCur^;
      PS_READ:
        begin
          if Length(SCurCode) > 0 then
          begin
            AOutCode.Add(SCurCode);
            SCurCode := '';
          end;
          if Length(SCurEval) > 0 then
          begin
            //SCurData := SCurData + ''' + ' + SCurEval + ' + '''; or
            //SCurData := SCurData + '" & ' + SCurEval + ' & "';
            SCurData := SCurData + ScrQuote + ScrConCat + ScrEvalStart + SCurEval + ScrEvalEnd + ScrConCat + ScrQuote;
            SCurEval := '';
          end;
          if CCur^ = ScrQuote then
            SCurData := sCurData + CCur^ + CCur^ // Add double ' or "
          else
            SCurData := sCurData + CCur^;
        end;
      PS_READDIR, PS_READDIRVB:
        SCurDir := SCurDir + CCur^;
      PS_READCODE:
        begin
          if Length(SCurData) > 0 then
          begin
            AOutCode.Add(SCurData);
            SCurData := '';
          end;
          SCurCode := SCurCode + CCur^;
        end;
      PS_READEVAL:
        SCurEval := SCurEval + CCur^;
    end;
  end;

  procedure AddLineToOutput;
  begin
    case iPState of
      PS_READ, PS_END:
        begin
          if Length(SCurEval) > 0 then
            AOutCode.Add(ScrLnStart + ScrQuote + SCurData + ScrQuote + ScrConCat + ScrEvalStart + SCurEval + ScrEvalEnd + ScrLnEnd)
          else
          begin
            if (Length(SCurData) > 0) then
              AOutCode.Add(ScrLnStart + ScrQuote + SCurData + ScrQuote + ScrLnEnd); //WriteLn('<SCurData>');
          end;
        end;
      PS_READCODE:
        AOutCode.Add(SCurCode);
      PS_READEVAL:
        AOutCode.Add(ScrLnStart + ScrEvalStart + SCurEval + ScrEvalEnd + ScrLnEnd); //WriteLn(VarToStr(<SCurEval>));
    end;
    SCurData := '';
    SCurCode := '';
    SCurEval := '';
  end;

  procedure HandleDirectiveCode;
  var
    SStrm: TStream;
  begin
    SDirRepl := '';
    if Assigned(ADirProc) then
    begin
      ADirProc(Sender, SCurDir, SDirRepl);  // Launch event

      //SStrm := TStringStream.Create(SDirRepl);
      SStrm := TMemoryStream.Create;
      SStrm.WriteBuffer(PChar(SDirRepl)^, Length(SDirRepl) * SizeOf(Char));
      SStrm.Position := 0;
      try
        ParseWebScript(SStrm, AOutCode, ALanguage, AOptionExplicit, Sender, ADirProc);
      finally
        SStrm.Free;
      end;
    end;
    SCurDir := '';
  end;

begin
  if AInStream.Size = 0 then Exit;

  iPState := PS_START;
  iPrevState := PS_START;

  SCurLang := '';
  SCurData := '';
  SCurEval := '';
  SCurCode := '';
  SCurDir  := '';

  // init the buffer and pointers pointer reference
  FillChar(Buf, SizeOf(Buf), 0);
  CPrev := @Buf[0];
  CCur  := @Buf[1];
  CNext := @Buf[2];
  CLast := @Buf[High(Buf)];
  EndOfStream := (AInStream.Read(Buf[2], SizeOf(Char) * (High(Buf) - 1)) <> (High(Buf) - 1) * SizeOf(Char));
  {
  <%@Language=VBScript%>
  <%@Language=Pascal%>
  }

  while (iPState <> PS_END) do
  begin
    case GetNextChar of
      '<':
        begin
          if (iPState = PS_START) and CompareBuf('<%@Language=', True) and (SCurLang = '') then
          begin
            SetParserState(PS_READLANG) //This is only allowed when ParserState = PS_Start
          end
          else if (CNext^ = '%') and (iPState <= PS_READ) then
          begin
            GetNextChar; // Skip the '%'
            SetParserState(PS_READCODE);
          end
          else if (iPState = PS_READ) and CompareBuf('<!--#', True) then
          begin // check for ASP <!--# directive -->
            AddLineToOutput; //Flush pending data
            SetParserState(PS_READDIRVB);
          end
          else begin
            if iPState = PS_START then iPState := PS_READ;
            ProcessChar;
          end;
        end;
      '%':
        if (CNext^ = '>') and (iPState >= PS_READCODE) then
        begin
          if (iPState = PS_READCODE) then
            AddLineToOutput;

          GetNextChar;
          SetParserState(PS_READ);
        end
        else if (CNext^ = '>') and (iPState = PS_READLANG) then
        begin
          if SameText(SCurLang, 'VBScript') then
            ALanguage := alBasic
          else
            ALanguage := alPascal;

          GetNextChar;
          SetParserState(PS_READ);
          //iPrevState := PS_START;
        end
        else if not ((CPrev^ = '<') and (iPState = PS_READCODE) and (iPrevState = PS_READ)) then
          ProcessChar;
      '=':
        begin
          if (CPrev^ = '%') and (iPState = PS_READCODE) then
            SetParserState(PS_READEVAL)
          else
            ProcessChar;
        end;
      '{':
        begin
          if (iPState < PS_READDIR) and (CNext^ = '$') then
          begin
            GetNextChar; // Skip the '$'
            AddLineToOutput; //Flush pending data
            SetParserState(PS_READDIR);
          end
          else
            ProcessChar;
        end;
      '}':
        begin
          if (iPState = PS_READDIR) then
          begin
            HandleDirectiveCode;
            SetParserState(iPrevState); //  PS_READ)
          end
          else
            ProcessChar;
        end;
      '-':
        begin
          if (iPState = PS_READDIRVB) and CompareBuf('-->', True) then
          begin
            HandleDirectiveCode;
            SetParserState(iPrevState);
          end
          else
            ProcessChar;
        end;
      'o', 'O': // Check for Option Explicit
        begin
          if (iPState = PS_READCODE) and CompareBuf('option explicit', True) then
            AOptionExplicit := True
          else
            ProcessChar;
        end;
      #10:;
      #13:
        begin
          if (iPState <= PS_READCODE) then
            AddLineToOutput
          else
            ProcessChar;
        end;
      #0:
        if (CNext^ = #0) then SetParserState(PS_END);
    else
      ProcessChar;
    end;
    if (iPState = PS_END) and EndOfStream then Break;
  end;
  AddLineToOutput;
end;

end.

