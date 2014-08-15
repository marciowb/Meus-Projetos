{This unit contains types and functions used by the compiler and executer}
unit ifps3utl;
{$I ifps3_def.inc}
{

Innerfuse Pascal Script III
Copyright (C) 2000-2002 by Carlo Kok (ck@carlo-kok.com)

}

interface

const
  {Maximum number of items in a list}
  MaxListSize = Maxint div 16;

type
  {PPointerList is pointing to an array of pointers}
  PPointerList = ^TPointerList;
  {An array of pointers}
  TPointerList = array[0..MaxListSize - 1] of Pointer;

  {TIfList is the list class used in IFPS}
  TIfList = class(TObject)
  private
    FCapacity: Cardinal;
    FCount: Cardinal;
    FData: PPointerList;
    {$IFNDEF NOSMARTLIST}
    FCheckCount: Cardinal;
    {$ENDIF}
  public
    {$IFNDEF NOSMARTLIST}
	{Recreate the list}
    procedure Recreate;
    {$ENDIF}
    {create}
    constructor Create;
	{destroy}
    destructor Destroy; override;
	{Contains the number of items in the list}
    property Count: Cardinal read FCount;
	{Return item no Nr} 
    function GetItem(Nr: Cardinal): Pointer;
	{Set item no NR}
    procedure SetItem(Nr: Cardinal; P: Pointer);
	{Add an item}
    procedure Add(P: Pointer);
	{Add a block of items}
    procedure AddBlock(List: PPointerList; Count: Longint);
	{Remove an item}
    procedure Remove(P: Pointer);
	{Remove an item}
    procedure Delete(Nr: Cardinal);
	{Clear the list}
    procedure Clear; virtual;
  end;

  TIfStringList = class(TObject)
  private
    List: TIfList;
  public
    {Returns the number of items in the list}
    function Count: LongInt;
	{Return item no nr}
    function GetItem(Nr: LongInt): string;
	{Set item no nr}
    procedure SetItem(Nr: LongInt; const s: string);
	{Add an item to the list}
    procedure Add(const P: string);
	{Delete item no NR}
    procedure Delete(NR: LongInt);
	{Clear the list}
    procedure Clear;
	{create} 
    constructor Create;
	{destroy}
    destructor Destroy; override;
  end;

  
type
  {TIFPasToken is used to store the type of the current token}
  TIfPasToken = (
    CSTI_EOF,
  {Items that are used internally}
    CSTIINT_Comment,
    CSTIINT_WhiteSpace,
  {Tokens}
    CSTI_Identifier,
    CSTI_SemiColon,
    CSTI_Comma,
    CSTI_Period,
    CSTI_Colon,
    CSTI_OpenRound,
    CSTI_CloseRound,
    CSTI_OpenBlock,
    CSTI_CloseBlock,
    CSTI_Assignment,
    CSTI_Equal,
    CSTI_NotEqual,
    CSTI_Greater,
    CSTI_GreaterEqual,
    CSTI_Less,
    CSTI_LessEqual,
    CSTI_Plus,
    CSTI_Minus,
    CSTI_Divide,
    CSTI_Multiply,
    CSTI_Integer,
    CSTI_Real,
    CSTI_String,
    CSTI_Char,
    CSTI_HexInt,
    CSTI_AddressOf,
    CSTI_Dereference,
  {Identifiers}
    CSTII_and,
    CSTII_array,
    CSTII_begin,
    CSTII_case,
    CSTII_const,
    CSTII_div,
    CSTII_do,
    CSTII_downto,
    CSTII_else,
    CSTII_end,
    CSTII_for,
    CSTII_function,
    CSTII_if,
    CSTII_in,
    CSTII_mod,
    CSTII_not,
    CSTII_of,
    CSTII_or,
    CSTII_procedure,
    CSTII_program,
    CSTII_repeat,
    CSTII_record,
    CSTII_set,
    CSTII_shl,
    CSTII_shr,
    CSTII_then,
    CSTII_to,
    CSTII_type,
    CSTII_until,
    CSTII_uses,
    CSTII_var,
    CSTII_while,
    CSTII_with,
    CSTII_xor,
    CSTII_exit,
    CSTII_break,
    CSTII_class,
    CSTII_constructor,
    CSTII_destructor,
    CSTII_inherited,
    CSTII_private,
    CSTII_public,
    CSTII_published,
    CSTII_protected,
    CSTII_property,
    CSTII_virtual,
    CSTII_override,
    CSTII_As,
    CSTII_Is,
    CSTII_Unit,
    CSTII_Continue,
    CSTII_Try,
    CSTII_Except,
    CSTII_Finally,
    CSTII_External,
    CSTII_Forward,
    CSTII_Export,
    CSTII_Label,
    CSTII_Goto,
    CSTII_Chr,
    CSTII_Ord,
    CSTII_Interface,
    CSTII_Implementation,
    CSTII_out
    );
  {TIFParserErrorKind is used to store the parser error}
  TIFParserErrorKind = (iNoError, iCommentError, iStringError, iCharError, iSyntaxError);
  TIFParserErrorEvent = procedure (Parser: TObject; Kind: TIFParserErrorKind; Position: Cardinal) of object;

  {TIfPacalParser is the parser used to parse the current script}
  TIfPascalParser = class(TObject)
  private
    FData: string;
    FText: PChar;
    FRealPosition, FTokenLength: Cardinal;
    FTokenId: TIfPasToken;
    FToken: string;
    FOriginalToken: string;
    FParserError: TIFParserErrorEvent;
    FEnableComments: Boolean;
    FEnableWhitespaces: Boolean;
    // only applicable when Token in [CSTI_Identifier, CSTI_Integer, CSTI_Real, CSTI_String, CSTI_Char, CSTI_HexInt]
  public
    property EnableComments: Boolean read FEnableComments;
    property EnableWhitespaces: Boolean read FEnableWhitespaces;
    {Go to the next token}
    procedure Next;
    {Return the token in case it is a string, char, integer, number or identifier}
    property GetToken: string read FToken;
    {Return the token but do not uppercase it}
    property OriginalToken: string read FOriginalToken;
    {The current token position}
    property CurrTokenPos: Cardinal read FRealPosition;
    {The current token ID}
    property CurrTokenID: TIFPasToken read FTokenId;
    {Load a script}
    procedure SetText(const Data: string);
    {Parser error event will be called on (syntax) errors in the script}
    property OnParserError: TIFParserErrorEvent read FParserError write FParserError;
  end;
{Convert a float to a string}
function FloatToStr(E: Extended): string;
{Fast lowercase}
function FastLowerCase(const s: String): string;
{Return the first word of a string}
function Fw(const S: string): string;
{Integer to string conversion}
function IntToStr(I: LongInt): string;
{String to integer}
function StrToIntDef(const S: string; Def: LongInt): LongInt;
{String to integer}
function StrToInt(const S: string): LongInt;
{Fast uppercase}
function FastUpperCase(const s: String): string;
{Get the first word and remove it}
function GRFW(var s: string): string;

implementation

function GRFW(var s: string): string;
var
  l: Longint;
begin
  l := 1;
  while l <= Length(s) do
  begin
    if s[l] = ' ' then
    begin
      Result := copy(s, 1, l - 1);
      Delete(s, 1, l);
      exit;
    end;
    l := l + 1;
  end;
  Result := s;
  s := '';
end;
//-------------------------------------------------------------------

function IntToStr(I: LongInt): string;
var
  s: string;
begin
  Str(i, s);
  IntToStr := s;
end;
//-------------------------------------------------------------------

function FloatToStr(E: Extended): string;
var
  s: string;
begin
  Str(e:0:12, s);
  result := s;
end;

function StrToInt(const S: string): LongInt;
var
  e: Integer;
  Res: LongInt;
begin
  Val(S, Res, e);
  if e <> 0 then
    StrToInt := -1
  else
    StrToInt := Res;
end;
//-------------------------------------------------------------------

function StrToIntDef(const S: string; Def: LongInt): LongInt;
var
  e: Integer;
  Res: LongInt;
begin
  Val(S, Res, e);
  if e <> 0 then
    StrToIntDef := Def
  else
    StrToIntDef := Res;
end;
//-------------------------------------------------------------------

constructor TIfList.Create;
begin
  inherited Create;
  FCount := 0;
  FCapacity := 16;
  {$IFNDEF NOSMARTLIST}
  FCheckCount := 0;
  {$ENDIF}
  GetMem(FData, 64);
end;

const
  FCapacityInc = 32;
{$IFNDEF NOSMARTLIST}
  FMaxCheckCount = (FCapacityInc div 4) * 16;
{$ENDIF}

function MM(i1,i2: Integer): Integer;
begin
  if ((i1 div i2) * i2) < i1 then
    mm := (i1 div i2 + 1) * i2
  else
    mm := (i1 div i2) * i2;
end;

{$IFNDEF NOSMARTLIST}
procedure TIfList.Recreate;
var
  NewData: PPointerList;
  NewCapacity: Cardinal;
  I: Longint;

begin

  FCheckCount := 0;
  NewCapacity := mm(FCount, FCapacityInc);
  if NewCapacity < 64 then NewCapacity := 64;
  GetMem(NewData, NewCapacity * 4);
  for I := 0 to Longint(FCount) -1 do
  begin
    NewData^[i] := FData^[I];
  end;
  FreeMem(FData, FCapacity * 4);
  FData := NewData;
  FCapacity := NewCapacity;
end;
{$ENDIF}

//-------------------------------------------------------------------

procedure TIfList.Add(P: Pointer);
begin
  if FCount >= FCapacity then
  begin
    Inc(FCapacity, FCapacityInc);// := FCount + 1;
    ReAllocMem(FData, FCapacity shl 2);
  end;
  FData[FCount] := P; // Instead of SetItem
  Inc(FCount);
{$IFNDEF NOSMARTLIST}
  Inc(FCheckCount);
  if FCheckCount > FMaxCheckCount then Recreate;
{$ENDIF}
end;

procedure TIfList.AddBlock(List: PPointerList; Count: Longint);
var
  L: Longint;

begin
  if Longint(FCount) + Count > Longint(FCapacity) then
  begin
    Inc(FCapacity, mm(Count, FCapacityInc));
    ReAllocMem(FData, FCapacity shl 2);
  end;
  for L := 0 to Count -1 do
  begin
    FData^[FCount] := List^[L];
    Inc(FCount);
  end;
{$IFNDEF NOSMARTLIST}
  Inc(FCheckCount);
  if FCheckCount > FMaxCheckCount then Recreate;
{$ENDIF}
end;


//-------------------------------------------------------------------

procedure TIfList.Delete(Nr: Cardinal);
begin
  if FCount = 0 then Exit;
  if Nr < FCount then
  begin
    Move(FData[Nr + 1], FData[Nr], (FCount - Nr) * 4);
    Dec(FCount);
{$IFNDEF NOSMARTLIST}
    Inc(FCheckCount);
    if FCheckCount > FMaxCheckCount then Recreate;
{$ENDIF}
  end;
end;
//-------------------------------------------------------------------

procedure TIfList.Remove(P: Pointer);
var
  I: Cardinal;
begin
  if FCount = 0 then Exit;
  I := 0;
  while I < FCount do
  begin
    if FData[I] = P then
    begin
      Delete(I);
      Exit;
    end;
    Inc(I);
  end;
end;
//-------------------------------------------------------------------

procedure TIfList.Clear;
begin
  FCount := 0;
{$IFNDEF NOSMARTLIST}
  Recreate;
{$ENDIF}
end;
//-------------------------------------------------------------------

destructor TIfList.Destroy;
begin
  FreeMem(FData, FCapacity * 4);
  inherited Destroy;
end;
//-------------------------------------------------------------------

procedure TIfList.SetItem(Nr: Cardinal; P: Pointer);
begin
  if (FCount = 0) or (Nr >= FCount) then
    Exit;
  FData[Nr] := P;
end;
//-------------------------------------------------------------------

function TifList.GetItem(Nr: Cardinal): Pointer;  {12}
begin
  if Nr < FCount then
    GetItem := FData[Nr]
  else
    GetItem := nil;
end;
//-------------------------------------------------------------------

function TIfStringList.Count: LongInt;
begin
  count := List.count;
end;
type pStr = ^string;

//-------------------------------------------------------------------

function TifStringList.GetItem(Nr: LongInt): string;
var
  S: PStr;
begin
  s := List.GetItem(Nr);
  if s = nil then
    Result := ''
  else

    Result := s^;
end;
//-------------------------------------------------------------------

procedure TifStringList.SetItem(Nr: LongInt; const s: string);
var
  p: PStr;
begin
  p := List.GetItem(Nr);
  if p = nil
    then
    Exit;
  p^ := s;
end;
//-------------------------------------------------------------------

procedure TifStringList.Add(const P: string);
var
  w: PStr;
begin
  new(w);
  w^ := p;
  List.Add(w);
end;
//-------------------------------------------------------------------

procedure TifStringList.Delete(NR: LongInt);
var
  W: PStr;
begin
  W := list.getitem(nr);
  if w<>nil then
  begin
    dispose(w);
  end;
  list.Delete(Nr);
end;

procedure TifStringList.Clear;
begin
  while List.Count > 0 do Delete(0);
end;

constructor TifStringList.Create;
begin
  inherited Create;
  List := TIfList.Create;
end;

destructor TifStringList.Destroy;
begin
  while List.Count > 0 do
    Delete(0);
  List.Destroy;
  inherited Destroy;
end;

//-------------------------------------------------------------------


function Fw(const S: string): string; //  First word
var
  x: integer;
begin
  x := pos(' ', s);
  if x > 0
    then Fw := Copy(S, 1, x - 1)
  else Fw := S;
end;
//-------------------------------------------------------------------
function FastUpperCase(const s: String): string;
{Fast uppercase}
var
  I: Integer;
  C: Char;
begin
  Result := S;
  I := Length(Result);
  while I > 0 do
  begin
    C := Result[I];
    if C in [#97..#122] then
      Dec(Byte(Result[I]), 32);
    Dec(I);
  end;
end;
function FastLowerCase(const s: String): string;
{Fast lowercase}
var
  I: Integer;
  C: Char;
begin
  Result := S;
  I := Length(Result);
  while I > 0 do
  begin
    C := Result[I];
    if C in [#65..#90] then
      Inc(Byte(Result[I]), 32);
    Dec(I);
  end;
end;
//-------------------------------------------------------------------

type
  TRTab = record
    name: string;
    c: TIfPasToken;
  end;


const
  KEYWORD_COUNT = 64;
  LookupTable: array[0..KEYWORD_COUNT - 1] of TRTab = (
      (name: 'AND'; c: CSTII_and),
      (name: 'ARRAY'; c: CSTII_array),
      (name: 'AS'; c: CSTII_as),
      (name: 'BEGIN'; c: CSTII_begin),
      (name: 'BREAK'; c: CSTII_break),
      (name: 'CASE'; c: CSTII_case),
      (name: 'CHR'; c: CSTII_chr),
      (name: 'CLASS'; c: CSTII_class),
      (name: 'CONST'; c: CSTII_const),
      (name: 'CONSTRUCTOR'; c: CSTII_constructor),
      (name: 'CONTINUE'; c: CSTII_Continue),
      (name: 'DESTRUCTOR'; c: CSTII_destructor),
      (name: 'DIV'; c: CSTII_div),
      (name: 'DO'; c: CSTII_do),
      (name: 'DOWNTO'; c: CSTII_downto),
      (name: 'ELSE'; c: CSTII_else),
      (name: 'END'; c: CSTII_end),
      (name: 'EXCEPT'; c: CSTII_except),
      (name: 'EXIT'; c: CSTII_exit),
      (name: 'EXPORT'; c: CSTII_Export),
      (name: 'EXTERNAL'; c: CSTII_External),
      (name: 'FINALLY'; c: CSTII_finally),
      (name: 'FOR'; c: CSTII_for),
      (name: 'FORWARD'; c: CSTII_Forward),
      (name: 'FUNCTION'; c: CSTII_function),
      (name: 'GOTO'; c: CSTII_Goto),
      (name: 'IF'; c: CSTII_if),
      (name: 'IMPLEMENTATION'; c: CSTII_Implementation),
      (name: 'IN'; c: CSTII_in),
      (name: 'INHERITED'; c: CSTII_inherited),
      (name: 'INTERFACE'; c: CSTII_Interface),
      (name: 'IS'; c: CSTII_is),
      (name: 'LABEL'; c: CSTII_Label),
      (name: 'MOD'; c: CSTII_mod),
      (name: 'NOT'; c: CSTII_not),
      (name: 'OF'; c: CSTII_of),
      (name: 'OR'; c: CSTII_or),
      (name: 'ORD'; c: CSTII_ord),
      (name: 'OUT'; c: CSTII_Out),
      (name: 'OVERRIDE'; c: CSTII_override),
      (name: 'PRIVATE'; c: CSTII_private),
      (name: 'PROCEDURE'; c: CSTII_procedure),
      (name: 'PROGRAM'; c: CSTII_program),
      (name: 'PROPERTY'; c: CSTII_property),
      (name: 'PROTECTED'; c: CSTII_protected),
      (name: 'PUBLIC'; c: CSTII_public),
      (name: 'PUBLISHED'; c: CSTII_published),
      (name: 'RECORD'; c: CSTII_record),
      (name: 'REPEAT'; c: CSTII_repeat),
      (name: 'SET'; c: CSTII_set),
      (name: 'SHL'; c: CSTII_shl),
      (name: 'SHR'; c: CSTII_shr),
      (name: 'THEN'; c: CSTII_then),
      (name: 'TO'; c: CSTII_to),
      (name: 'TRY'; c: CSTII_try),
      (name: 'TYPE'; c: CSTII_type),
      (name: 'UNIT'; c: CSTII_Unit),
      (name: 'UNTIL'; c: CSTII_until),
      (name: 'USES'; c: CSTII_uses),
      (name: 'VAR'; c: CSTII_var),
      (name: 'VIRTUAL'; c: CSTII_virtual),
      (name: 'WHILE'; c: CSTII_while),
      (name: 'WITH'; c: CSTII_with),
      (name: 'XOR'; c: CSTII_xor));

procedure TIfPascalParser.Next;
var
  Err: TIFParserErrorKind;
  function CheckReserved(Const S: ShortString; var CurrTokenId: TIfPasToken): Boolean;
  var
    L, H, I: LongInt;
    J: Char;
    SName: ShortString;
  begin
    L := 0;
    J := S[0];
    H := KEYWORD_COUNT-1;
    while L <= H do
    begin
      I := (L + H) shr 1;
      SName := LookupTable[i].Name;
      if J = SName[0] then
      begin
        if S = SName then
        begin
          CheckReserved := True;
          CurrTokenId := LookupTable[I].c;
          Exit;
        end;
        if S > SName then
          L := I + 1
        else
          H := I - 1;
      end else
        if S > SName then
          L := I + 1
        else
          H := I - 1;
    end;
    CheckReserved := False;
  end;
  //-------------------------------------------------------------------

  function GetToken(CurrTokenPos, CurrTokenLen: Cardinal): string;
  var
    s: string;
  begin
    SetLength(s, CurrTokenLen);
    Move(FText[CurrTokenPos], S[1], CurrtokenLen);
    GetToken := s;
  end;

  function ParseToken(var CurrTokenPos, CurrTokenLen: Cardinal; var CurrTokenId: TIfPasToken): TIFParserErrorKind;
  {Parse the token}
  var
    ct, ci: Cardinal;
    hs: Boolean;
  begin
    ParseToken := iNoError;
    ct := CurrTokenPos;
    case FText[ct] of
      #0:
        begin
          CurrTokenId := CSTI_EOF;
          CurrTokenLen := 0;
        end;
      'A'..'Z', 'a'..'z', '_':
        begin
          ci := ct + 1;
          while (FText[ci] in ['_', '0'..'9', 'a'..'z', 'A'..'Z']) do begin
            Inc(ci);
          end;
          CurrTokenLen := ci - ct;
          if not CheckReserved(FastUppercase(GetToken(CurrTokenPos, CurrtokenLen)), CurrTokenId) then
          begin
            CurrTokenId := CSTI_Identifier;
          end;
        end;
      '$':
        begin
          ci := ct + 1;

          while (FText[ci] in ['0'..'9', 'a'..'f', 'A'..'F'])
            do Inc(ci);

          CurrTokenId := CSTI_HexInt;
          CurrTokenLen := ci - ct;
        end;

      '0'..'9':
        begin
          hs := False;
          ci := ct;
          while (FText[ci] in ['0'..'9']) do
          begin
            Inc(ci);
            if (FText[ci] = '.') and (not hs) then
            begin
              if FText[ci+1] = '.' then break;
              hs := True;
              Inc(ci);
            end;
          end;

          if hs
            then CurrTokenId := CSTI_Real
          else CurrTokenId := CSTI_Integer;

          CurrTokenLen := ci - ct;
        end;


      #39:
        begin
          ci := ct + 1;
          while (FText[ci] <> #0) and (FText[ci] <> #13) and
            (FText[ci] <> #10) and (FText[ci] <> #39)
            do begin
            Inc(ci);
          end;
          if FText[ci] = #39 then
            CurrTokenId := CSTI_String
          else
          begin
            CurrTokenId := CSTI_String;
            ParseToken := iStringError;
          end;
          CurrTokenLen := ci - ct + 1;
        end;
      '#':
        begin
          ci := ct + 1;
          if FText[ci] = '$' then
          begin
            inc(ci);
            while (FText[ci] in ['A'..'F', 'a'..'f', '0'..'9']) do begin
              Inc(ci);
            end;
            CurrTokenId := CSTI_Char;
            CurrTokenLen := ci - ct;
          end else
          begin
            while (FText[ci] in ['0'..'9']) do begin
              Inc(ci);
            end;         
            if FText[ci] in ['A'..'Z', 'a'..'z', '_'] then
            begin
              ParseToken := iCharError;
              CurrTokenId := CSTI_Char;
            end else
              CurrTokenId := CSTI_Char;
            CurrTokenLen := ci - ct;
          end;
        end;
      '=':
        begin
          CurrTokenId := CSTI_Equal;
          CurrTokenLen := 1;
        end;
      '>':
        begin
          if FText[ct + 1] = '=' then
          begin
            CurrTokenid := CSTI_GreaterEqual;
            CurrTokenLen := 2;
          end else
          begin
            CurrTokenid := CSTI_Greater;
            CurrTokenLen := 1;
          end;
        end;
      '<':
        begin
          if FText[ct + 1] = '=' then
          begin
            CurrTokenId := CSTI_LessEqual;
            CurrTokenLen := 2;
          end else
            if FText[ct + 1] = '>' then
            begin
              CurrTokenId := CSTI_NotEqual;
              CurrTokenLen := 2;
            end else
            begin
              CurrTokenId := CSTI_Less;
              CurrTokenLen := 1;
            end;
        end;
      ')':
        begin
          CurrTokenId := CSTI_CloseRound;
          CurrTokenLen := 1;
        end;
      '(':
        begin
          if FText[ct + 1] = '*' then
          begin
            ci := ct + 1;
            while (FText[ci] <> #0) do begin
              if (FText[ci] = '*') and (FText[ci + 1] = ')') then
                Break;
              Inc(ci);
            end;
            if (FText[ci] = #0) then
            begin
              CurrTokenId := CSTIINT_Comment;
              ParseToken := iCommentError;
            end else
            begin
              CurrTokenId := CSTIINT_Comment;
              Inc(ci, 2);
            end;
            CurrTokenLen := ci - ct;
          end
          else
          begin
            CurrTokenId := CSTI_OpenRound;
            CurrTokenLen := 1;
          end;
        end;
      '[':
        begin
          CurrTokenId := CSTI_OpenBlock;
          CurrTokenLen := 1;
        end;
      ']':
        begin
          CurrTokenId := CSTI_CloseBlock;
          CurrTokenLen := 1;
        end;
      ',':
        begin
          CurrTokenId := CSTI_Comma;
          CurrTokenLen := 1;
        end;
      '.':
        begin
          CurrTokenId := CSTI_Period;
          CurrTokenLen := 1;
        end;
      '@':
        begin
          CurrTokenId := CSTI_AddressOf;
          CurrTokenLen := 1;
        end;
      '^':
        begin
          CurrTokenId := CSTI_Dereference;
          CurrTokenLen := 1;
        end;
      ';':
        begin
          CurrTokenId := CSTI_Semicolon;
          CurrTokenLen := 1;
        end;
      ':':
        begin
          if FText[ct + 1] = '=' then
          begin
            CurrTokenId := CSTI_Assignment;
            CurrTokenLen := 2;
          end else
          begin
            CurrTokenId := CSTI_Colon;
            CurrTokenLen := 1;
          end;
        end;
      '+':
        begin
          CurrTokenId := CSTI_Plus;
          CurrTokenLen := 1;
        end;
      '-':
        begin
          CurrTokenId := CSTI_Minus;
          CurrTokenLen := 1;
        end;
      '*':
        begin
          CurrTokenId := CSTI_Multiply;
          CurrTokenLen := 1;
        end;
      '/':
        begin
          if FText[ct + 1] = '/' then
          begin
            ci := ct + 1;
            while (FText[ci] <> #0) and (FText[ci] <> #13) and
              (FText[ci] <> #10) do begin
              Inc(ci);
            end;
            if (FText[ci] = #0) then
            begin
              CurrTokenId := CSTIINT_Comment;
              ParseToken := iCommentError;
            end else
            begin
              if FText[ci + 1] = #10 then
                Inc(ci) else

                if FText[ci + 1] = #13 then
                  Inc(ci);
              CurrTokenId := CSTIINT_Comment;
            end;
            CurrTokenLen := ci - ct + 1;
          end else
          begin
            CurrTokenId := CSTI_Divide;
            CurrTokenLen := 1;
          end;
        end;
      #32, #9, #13, #10:
        begin
          ci := ct + 1;
          while (FText[ci] in [#32, #9, #13, #10]) do begin
            Inc(ci);
          end;
          CurrTokenId := CSTIINT_WhiteSpace;
          CurrTokenLen := ci - ct;
        end;
      '{':
        begin
          ci := ct + 1;
          while (FText[ci] <> #0) and (FText[ci] <> '}') do begin
            Inc(ci);
          end;
          if (FText[ci] = #0) then
          begin
            CurrTokenId := CSTIINT_Comment;
            ParseToken := iCommentError;
          end else
            CurrTokenId := CSTIINT_Comment;
          CurrTokenLen := ci - ct + 1;
        end;
    else
      begin
        ParseToken := iSyntaxError;
        CurrTokenId := CSTIINT_Comment;
        CurrTokenLen := 1;
      end;
    end;
  end;
  //-------------------------------------------------------------------
begin
  if FText = nil then
  begin
    FTokenLength := 0;
    FRealPosition := 0;
    FTokenId := CSTI_EOF;
    Exit;
  end;
  repeat
    FRealPosition := FRealPosition + FTokenLength;
    Err := ParseToken(FRealPosition, FTokenLength, FTokenID);
    if Err <> iNoError then
    begin
      FTokenLength := 0;
      FTokenId := CSTI_EOF;
      FToken := '';
      FOriginalToken := '';
      if @FParserError <> nil then FParserError(Self, Err, FRealPosition);
      exit;
    end;
    case FTokenID of
      CSTIINT_Comment: if not FEnableComments then Continue else
        begin
          FOriginalToken := GetToken(FRealPosition, FTokenLength);
          FToken := FOriginalToken;
        end;
      CSTIINT_WhiteSpace: if not FEnableWhitespaces then Continue else
        begin
          FOriginalToken := GetToken(FRealPosition, FTokenLength);
          FToken := FOriginalToken;
        end;
      CSTI_Integer, CSTI_Real, CSTI_String, CSTI_Char, CSTI_HexInt:
        begin
          FOriginalToken := GetToken(FRealPosition, FTokenLength);
          FToken := FOriginalToken;
        end;
      CSTI_Identifier:
        begin
          FOriginalToken := GetToken(FRealPosition, FTokenLength);
          FToken := FastUppercase(FOriginalToken);
        end;
    else
      begin
        FOriginalToken := '';
        FToken := '';
      end;
    end;
    Break;
  until False;
end;

procedure TIfPascalParser.SetText(const Data: string);
begin
  FData := Data;
  FText := Pointer(FData);
  FTokenLength := 0;
  FRealPosition := 0;
  FTokenId := CSTI_EOF;
  Next;
end;

end.


