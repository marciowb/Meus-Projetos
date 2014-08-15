unit ifpicall;
{
  Innerfuse Pascal Script Call unit
  You may not copy a part of this unit, only use it as whole, with
  Innerfuse Pascal Script Script Engine.
}
{$I ifps3_def.inc}
interface
uses
  ifps3, ifps3utl, ifps3common{$IFDEF HAVEVARIANT}{$IFDEF D6PLUS}, variants{$ENDIF}{$ENDIF}, SysUtils;

type
  TCallingConvention = (ccRegister, ccPascal, CCCdecl, CCStdCall);
  PResourcePtrSupportFuncs = ^TResourcePtrSupportFuncs;
  TResourcePtrToStrProc = function (PSelf: PResourcePtrSupportFuncs; Sender: TIFPSExec; P: PIFVariant): string;
  TVarResourcePtrToStrProc = function (PSelf: PResourcePtrSupportFuncs; Sender: TIFPSExec; P: PIFVariant): string;
  TResultToRsourcePtr = procedure(PSelf: PResourcePtrSupportFuncs; Sender: TIFPSExec; Data: Longint; P: PIFVariant);

  TRPSResultMethod = (rmParam, rmRegister);
  TResourcePtrSupportFuncs = record
    Ptr: Pointer;
    PtrToStr: TResourcePtrToStrProc;
    VarPtrToStr: TVarResourcePtrToStrProc;
    ResultMethod: TRPSResultMethod;
    ResToPtr: TResultToRsourcePtr;
    ProcPtrToStr: TResourcePtrToStrProc;
  end;
function InnerfuseCall(SE: TIFPSExec; Self, Address: Pointer; CallingConv: TCallingConvention; Params: TIfList; res: PIfVariant; SupFunc: PResourcePtrSupportFuncs): Boolean;

{$IFDEF HAVEVARIANT}
function PIFVariantToVariant(Sender: TIFPSExec; Src: PIFVariant; var Dest: Variant): Boolean;
function VariantToPIFVariant(Sender: TIFPSExec; const Src: Variant; Dest: PIFVariant): Boolean;
{$ENDIF}
implementation

{$IFDEF HAVEVARIANT}
var
  VNull: Variant;

const
  VariantType: TIFTypeRec = (ext:nil;BaseType: btVariant);
  VariantArrayType: TIFTypeRec = (ext:@VariantType;basetype: btArray);
{$ENDIF}

function RealFloatCall_Register(p: Pointer;
  _EAX, _EDX, _ECX: Cardinal;
  StackData: Pointer;
  StackDataLen: Longint // stack length are in 4 bytes. (so 1 = 4 bytes)
  ): Extended; Stdcall; // make sure all things are on stack
var
  E: Extended;
begin
  asm
    mov ecx, stackdatalen
    jecxz @@2
    mov eax, stackdata
    @@1:
    mov edx, [eax]
    push edx
    sub eax, 4
    dec ecx
    or ecx, ecx
    jnz @@1
    @@2:
    mov eax,_EAX
    mov edx,_EDX
    mov ecx,_ECX
    call p
    fstp tbyte ptr [e]
  end;
  Result := E;
end;

function RealFloatCall_Other(p: Pointer;
  StackData: Pointer;
  StackDataLen: Longint // stack length are in 4 bytes. (so 1 = 4 bytes)
  ): Extended; Stdcall; // make sure all things are on stack
var
  E: Extended;
begin
  asm
    mov ecx, stackdatalen
    jecxz @@2
    mov eax, stackdata
    @@1:
    mov edx, [eax]
    push edx
    sub eax, 4
    dec ecx
    or ecx, ecx
    jnz @@1
    @@2:
    call p
    fstp tbyte ptr [e]
  end;
  Result := E;
end;

function RealFloatCall_CDecl(p: Pointer;
  StackData: Pointer;
  StackDataLen: Longint // stack length are in 4 bytes. (so 1 = 4 bytes)
  ): Extended; Stdcall; // make sure all things are on stack
var
  E: Extended;
begin
  asm
    mov ecx, stackdatalen
    jecxz @@2
    mov eax, stackdata
    @@1:
    mov edx, [eax]
    push edx
    sub eax, 4
    dec ecx
    or ecx, ecx
    jnz @@1
    @@2:
    call p
    fstp tbyte ptr [e]
    @@5:
    mov ecx, stackdatalen
    jecxz @@2
    @@6:
    pop edx
    dec ecx
    or ecx, ecx
    jnz @@6
  end;
  Result := E;
end;

function RealCall_Register(p: Pointer;
  _EAX, _EDX, _ECX: Cardinal;
  StackData: Pointer;
  StackDataLen: Longint; // stack length are in 4 bytes. (so 1 = 4 bytes)
  ResultLength: Longint; ResEDX: Pointer): Longint; Stdcall; // make sure all things are on stack
var
  r: Longint;
begin
  asm
    mov ecx, stackdatalen
    jecxz @@2
    mov eax, stackdata
    @@1:
    mov edx, [eax]
    push edx
    sub eax, 4
    dec ecx
    or ecx, ecx
    jnz @@1
    @@2:
    mov eax,_EAX
    mov edx,_EDX
    mov ecx,_ECX
    call p
    mov ecx, resultlength
    cmp ecx, 0
    je @@5
    cmp ecx, 1
    je @@3
    cmp ecx, 2
    je @@4
    mov r, eax
    jmp @@5
    @@3:
    xor ecx, ecx
    mov cl, al
    mov r, ecx
    jmp @@5
    @@4:
    xor ecx, ecx
    mov cx, ax
    mov r, ecx
    @@5:
    mov ecx, resedx
    jecxz @@6
    mov [ecx], edx
    @@6:
  end;
  Result := r;
end;

function RealCall_Other(p: Pointer;
  StackData: Pointer;
  StackDataLen: Longint; // stack length are in 4 bytes. (so 1 = 4 bytes)
  ResultLength: Longint; ResEDX: Pointer): Longint; Stdcall; // make sure all things are on stack
var
  r: Longint;
begin
  asm
    mov ecx, stackdatalen
    jecxz @@2
    mov eax, stackdata
    @@1:
    mov edx, [eax]
    push edx
    sub eax, 4
    dec ecx
    or ecx, ecx
    jnz @@1
    @@2:
    call p
    mov ecx, resultlength
    cmp ecx, 0
    je @@5
    cmp ecx, 1
    je @@3
    cmp ecx, 2
    je @@4
    mov r, eax
    jmp @@5
    @@3:
    xor ecx, ecx
    mov cl, al
    mov r, ecx
    jmp @@5
    @@4:
    xor ecx, ecx
    mov cx, ax
    mov r, ecx
    @@5:
    mov ecx, resedx
    jecxz @@6
    mov [ecx], edx
    @@6:
  end;
  Result := r;
end;

function RealCall_CDecl(p: Pointer;
  StackData: Pointer;
  StackDataLen: Longint; // stack length are in 4 bytes. (so 1 = 4 bytes)
  ResultLength: Longint; ResEDX: Pointer): Longint; Stdcall; // make sure all things are on stack
var
  r: Longint;
begin
  asm
    mov ecx, stackdatalen
    jecxz @@2
    mov eax, stackdata
    @@1:
    mov edx, [eax]
    push edx
    sub eax, 4
    dec ecx
    or ecx, ecx
    jnz @@1
    @@2:
    call p
    mov ecx, resultlength
    cmp ecx, 0
    je @@5
    cmp ecx, 1
    je @@3
    cmp ecx, 2
    je @@4
    mov r, eax
    jmp @@5
    @@3:
    xor ecx, ecx
    mov cl, al
    mov r, ecx
    jmp @@5
    @@4:
    xor ecx, ecx
    mov cx, ax
    mov r, ecx
    @@5:
    mov ecx, stackdatalen
    jecxz @@2
    @@6:
    pop eax
    dec ecx
    or ecx, ecx
    jnz @@6
    mov ecx, resedx
    jecxz @@7
    mov [ecx], edx
    @@7:
  end;
  Result := r;
end;
{$IFDEF HAVEVARIANT}
function PIFVariantToVariant(Sender: TIFPSExec; Src: PIFVariant; var Dest: Variant): Boolean;
  function CreateArrayVariant: Boolean;
  var
    v: Variant;
    i: Integer;
  begin
    Dest := VarArrayCreate([0, GetIFPSArrayLength(Sender, Src)-1], vtVariant);
    for i := GetIFPSArrayLength(Sender, Src) -1 downto 0 do
    begin
      if (not PIFVariantToVariant(Sender, Src^.tArray.Fields[i], v)) or (VarIsArray(v)) then
      begin
        Result := False;
        exit;
      end;
      Dest[i] := v;
    end;
    Result := True;
  end;
begin
  if Src^.FType.BaseType = btVariant then Src := Src^.tvariant;
  if Src^.Ftype = nil then
  begin
    Dest := null;
    Result := True;
    exit;
  end;
  case Src^.FType^.BaseType of
    btArray:
      begin
        if not CreateArrayVariant then
        begin
          Result := False;
          exit;
        end;
      end;
    btU8: Dest := Src^.tu8;
    btS8: Dest := Src^.ts8;
    btU16: Dest := Src^.tu16;
    btS16: Dest := Src^.ts16;
    btU32: Dest := Longint(Src^.tu32);
    btS32: Dest := Src^.ts32;
    btSingle: Dest := Src^.tsingle;
    btDouble: Dest := Src^.tdouble;
    btExtended: Dest := Src^.textended;
    btPChar, btString: Dest := tbtString(Src^.tstring);
  {$IFNDEF NOINT64}
  {$IFDEF D6PLUS} btS64: Dest := Src^.ts64; {$ELSE} bts64: begin Result := False; exit; end; {$ENDIF} 
  {$ENDIF}
    btChar: Dest := src^.tChar;
  {$IFNDEF NOWIDESTRING}
    btWideString: Dest := tbtWideString(src^.twidestring);
    btWideChar: Dest := src^.twidechar;
  {$ENDIF}
  else
    begin
      Result := False;
      exit;
    end;
  end;
  Result := True;
end;

function VariantToPIFVariant(Sender: TIFPSExec; const Src: Variant; Dest: PIFVariant): Boolean;
var
  I: Longint;
  L: Cardinal;
  PT: PIFTypeRec;
begin
  if Dest^.FType.BaseType <> btVariant then begin Result := False; exit; end;
  if VarIsArray(Src) then
  begin
    if VarArrayDimCount(Src) > 1 then
    begin
      Result := False;
      exit;
    end;
    l := 0;
    repeat
      pt := Sender.FindType(l, btArray, l);
      if PIFTypeRec(Sender.GetTypeNo(Cardinal(pt^.Ext)))^.BaseType = btVariant then break;
    until pt = nil;
    if pt = nil then pt := @VariantArrayType;
    ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF}Dest^.tvariant, pt);
    SetIFPSArrayLength(Sender, Dest^.tvariant, VarArrayHighBound(Src, 1) - VarArrayLowBound(Src, 1)+1);
    for i := VarArrayLowBound(Src, 1) to VarArrayHighBound(Src, 1) do
    begin
      if not VariantToPIFVariant(Sender, Src[i], Dest^.tVariant^.tArray^.Fields[i - VarArrayLowBound(Src, 1)]) then
      begin
        Result := False;
        Exit;
      end;
    end;
  end else
  begin
    case VarType(Src) of
    varEmpty:
      begin
        ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF} Dest^.tvariant, nil);
      end;
    varSmallint:
      begin
        ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF} Dest^.tvariant, Sender.FindType2(btS16));
        Dest^.tvariant.ts16 := Src;
      end;
    varInteger:
      begin
        ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF} Dest^.tvariant, Sender.FindType2(btS32));
        Dest^.tvariant.ts32 := Src;
      end;
    varSingle:
      begin
        ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF} Dest^.tvariant, Sender.FindType2(btSingle));
        Dest^.tvariant.tsingle := Src;
      end;
    varDate, varCurrency, varDouble:
      begin
        ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF} Dest^.tvariant, Sender.FindType2(btDouble));
        Dest^.tvariant.tDouble := Src;
      end;
    {$IFNDEF NOWIDESTRING}
    varOleStr:
      begin
        ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF} Dest^.tvariant, Sender.FindType2(btWideString));
        tbtWideString(Dest^.tvariant.twidestring) := Src;
      end;
    {$ENDIF}
    varBoolean:
      begin
        ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF} Dest^.tvariant, Sender.FindType2(btu8));
        Boolean(Dest^.tvariant.tu8) := Src;
      end;
    {$IFDEF D6PLUS} varShortInt:
      begin
        ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF} Dest^.tvariant, Sender.FindType2(btS8));
        Dest^.tvariant.ts8 := Src;
      end;
    varByte:
      begin
        ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF} Dest^.tvariant, Sender.FindType2(btu8));
        Dest^.tvariant.tu8 := Src;
      end;
    varWord:
      begin
        ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF} Dest^.tvariant, Sender.FindType2(btS16));
        Dest^.tvariant.tu16 := Src;
      end;
    varLongWord:
      begin
        ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF} Dest^.tvariant, Sender.FindType2(btu32));
        Dest^.tvariant.tu32 := Src;
      end;
    {$IFNDEF NOINT64}
    varInt64:
      begin
        ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF} Dest^.tvariant, Sender.FindType2(btS64));
        Dest^.tvariant.ts16 := Src;
      end;
    {$ENDIF}{$ENDIF}
    varStrArg, varString:
      begin
        ChangeVariantType({$IFNDEF NOSMARTMM}Sender.MemoryManager, {$ENDIF} Dest^.tvariant, Sender.FindType2(btstring));
        tbtstring(Dest^.tvariant.tstring) := Src;
      end;
    else
      begin
        Result := False;
        exit;
      end;
    end;
  end;
  Result := True;
end;
{$ENDIF}
type
  POpenArray = ^TOpenArray;
  TOpenArray = record
    AType: Byte; {0}
    OrgVar: PIFVariant;
    ElementSize,
    ItemCount: Longint;
    Data: string;
    VarParam: Boolean;
  end;
{$IFDEF HAVEVARIANT}
  PVariant = ^TVariant;
  TVariant = record
    AType: Byte; {1}
    OrgVar: PIFVariant;
    P: Variant;
    VarParam: Boolean;
  end;
{$ENDIF}
  PRecord = ^TRecord;
  TRecord = record
    AType: Byte; {2}
    OrgVar: PIFVariant;
    Data: string;
    VarParam: Boolean;
  end;
{$IFDEF DYNARRAY}
  PDynArray = ^TDynArray;
  TDynArray = record
    AType: Byte; {3}
    OrgVar: PIfVariant;
    VarParam: Boolean;
    Data: Pointer;
  end;
{$ENDIF}
{$IFDEF HAVEVARIANT}
function CreateVariant(VarParam: Boolean; Sender: TIFPSExec; SupFunc: PResourcePtrSupportFuncs; Val: PIFVariant): PVariant;
begin
  New(Result);
  Result.AType := 1;
  Result.OrgVar := Val;
  Result.VarParam := VarParam;
  if not PIFVariantToVariant(Sender, Val, Result^.P) then
  begin
    Dispose(Result);
    Result := nil;
    exit;
  end;
end;

procedure DestroyVariant(Sender: TIFPSExec; SupFunc: PResourcePtrSupportFuncs; V: PVariant);
begin
  if V.VarParam then
  begin
    VariantToPIFVariant(Sender, V^.P, V^.OrgVar);
  end;
  Dispose(V);
end;
{$ENDIF}

function CreateOpenArray(VarParam: Boolean; Sender: TIFPSExec; SupFunc: PResourcePtrSupportFuncs; Val: PIFVariant): POpenArray;
var
  p: Pointer;
  i: Longint;
{$IFDEF HAVEVARIANT}
  fv: PIFVariant;
  temps: string;
{$ENDIF}
begin
  if Val.FType^.BaseType <> btArray then
  begin
    Result := nil;
    exit;
  end;
  New(Result);
  Result.AType := 0;
  Result.OrgVar := Val;
  Result.VarParam := VarParam;
  Result^.ItemCount := GetIFPSArrayLength(Sender, Val);
  case Sender.GetTypeNo(Longint(Val^.FType^.Ext))^.BaseType of
    {$IFDEF HAVEVARIANT}
    btVariant:
      begin
        if Val^.FType.ExportName = '!OPENARRAYOFVARIANT' then
          Result^.ElementSize := SizeOf(Variant)
        else
          Result^.ElementSize := SizeOf(TVarRec);
      end;
    {$ENDIF}
    btU8, bts8: Result^.ElementSize := 1;
    btu16, bts16: Result^.ElementSize := 2;
    btu32, bts32: Result^.ElementSize := 4;
    btsingle: Result^.ElementSize := 4;
    btdouble: Result^.ElementSize := 8;
    btextended: Result^.ElementSize := SizeOf(Extended);
    btstring, btpchar: Result^.ElementSize := 4;
    btchar: Result^.ElementSize := 1;
    {$IFNDEF NOINT64}
    btS64: Result^.ElementSize := 8;
    {$ENDIF}
    {$IFNDEF NOWIDESTRING}
    btWidestring: Result^.ElementSize := 4;
    btwidechar: Result^.ElementSize := 2;
    {$ENDIF}
  else
    begin
      Dispose(Result);
      Result := nil;
      exit;
    end;
  end;
  SetLength(Result^.Data, Result^.ItemCount * Result^.ElementSize);
  P := @Result^.Data[1];
  FillChar(p^, Result^.ItemCount * Result^.ElementSize, 0);
  case Sender.GetTypeNo(Longint(Val^.FType^.Ext))^.BaseType of
    btPChar, btChar, {$IFNDEF NOWIDESTRING}btWideChar, {$ENDIF}btU8, btS8, btU16, btS16, btu32, bts32, btSingle, btDouble, btExtended:
    begin
      for i := 0 to Result^.ItemCount -1 do
      begin
        Move(Val^.tArray.Fields[i].tu8, p^, Result^.elementsize);
        p := PChar(p) + Result^.ElementSize;
      end;
    end;
    {$IFNDEF NOWIDESTRING}
    btWideString:
    begin
      for i := 0 to Result^.ItemCount -1 do
      begin
        tbtwidestring(p^) := tbtwidestring(Val^.tArray.Fields[i].twidestring);
        p := PChar(p) + Result^.ElementSize;
      end;
    end;
    {$ENDIF}
    btString:
    begin
      for i := 0 to Result^.ItemCount -1 do
      begin
        string(p^) := string(Val^.tArray.Fields[i].tstring);
        p := PChar(p) + Result^.ElementSize;
      end;
    end;
    {$IFDEF HAVEVARIANT}
    btVariant:
    begin
      if Val^.FType.ExportName = '!OPENARRAYOFVARIANT' then
      begin
        for i := 0 to Result^.ItemCount -1 do
        begin
          Initialize(variant(p^));
          PIFVariantToVariant(Sender, val^.Tarray.Fields[i], Variant(p^));
          p := PChar(p) + Result^.ElementSize;
        end;
      end
      else
      begin
        for i := 0 to Result^.ItemCount -1 do
        begin
          fv := val^.tArray.Fields[i];
          if fv^.tvariant^.FType = nil then
          begin
            tvarrec(p^).VType := vtVariant;
            tvarrec(p^).VVariant := @VNull;
          end else begin
            case fv^.tvariant^.ftype^.BaseType of
              btchar: begin
                  tvarrec(p^).VType := vtChar;
                  tvarrec(p^).VChar := fv^.tvariant^.tchar;
                end;
              btSingle:
                begin
                  tvarrec(p^).VType := vtExtended;
                  New(tvarrec(p^).VExtended);
                  tvarrec(p^).VExtended^ := fv^.tvariant^.tsingle;
                end;
              btExtended:
                begin
                  tvarrec(p^).VType := vtExtended;
                  New(tvarrec(p^).VExtended);
                  tvarrec(p^).VExtended^ := fv^.tvariant^.textended;
                end;
              btDouble:
                begin
                  tvarrec(p^).VType := vtExtended;
                  New(tvarrec(p^).VExtended);
                  tvarrec(p^).VExtended^ := fv^.tvariant^.tdouble;
                end;
              {$IFNDEF NOWIDESTRING}
              btwidechar: begin
                  tvarrec(p^).VType := vtWideChar;
                  tvarrec(p^).VWideChar := fv^.tvariant^.twidechar;
                end;
              btwideString: begin
                tvarrec(p^).VType := vtWideString;
                widestring(TVarRec(p^).VWideString) := widestring(fv^.tvariant^.twidestring);
              end;
              {$ENDIF}
              btU8: begin
                  tvarrec(p^).VType := vtInteger;
                  tvarrec(p^).VInteger := fv^.tvariant^.tu8;
                end;
              btS8: begin
                  tvarrec(p^).VType := vtInteger;
                  tvarrec(p^).VInteger := fv^.tvariant^.ts8;
                end;
              btU16: begin
                  tvarrec(p^).VType := vtInteger;
                  tvarrec(p^).VInteger := fv^.tvariant^.tu16;
                end;
              btS16: begin
                  tvarrec(p^).VType := vtInteger;
                  tvarrec(p^).VInteger := fv^.tvariant^.ts16;
                end;
              btU32: begin
                  tvarrec(p^).VType := vtInteger;
                  tvarrec(p^).VInteger := Longint(fv^.tvariant^.tu32);
                end;
              btS32: begin
                  tvarrec(p^).VType := vtInteger;
                  tvarrec(p^).VInteger := fv^.tvariant^.ts32;
                end;
              btString: begin
                tvarrec(p^).VType := vtAnsiString;
                string(TVarRec(p^).VAnsiString) := string(fv^.tvariant^.tstring);
              end;
              {$IFNDEF NOINT64}
              btS64:
                begin
                  tvarrec(p^).VType := vtInt64;
                  new(tvarrec(p^).VInt64);
                  tvarrec(p^).VInt64^ := fv^.tvariant^.ts64;
                end;
              {$ENDIF}
              btPChar: begin
                tvarrec(p^).VType := vtPchar;
                TVarRec(p^).VPChar := pointer(fv^.tvariant^.tstring);
              end;
              btResourcePointer: begin
                temps := SupFunc.PtrToStr(supfunc, Sender, fv^.tvariant);
                if length(temps) =4 then
                begin
                tvarrec(p^).VType := vtObject;
                TVarRec(p^).VObject := Pointer((@temps[1])^);
                end;
              end;
            end;
          end;
          p := PChar(p) + Result^.ElementSize;
        end;
      end;
    end;
    {$ENDIF}
  end;
end;

procedure DestroyOpenArray(Sender: TIFPSExec; SupFunc: PResourcePtrSupportFuncs; V: POpenArray);
var
  p: Pointer;
  fv: PIFVariant;
  i: Longint;
begin
  p := @v^.Data[1];
  case Sender.GetTypeNo(Longint(V^.OrgVar^.FType^.Ext))^.BaseType of
    btPChar, btU8, btS8, btU16, btS16, btu32, bts32, btSingle, btDouble, btExtended, btChar{$IFNDEF NOWIDESTRING}, btWidechar{$ENDIF}:
    begin
      if v^.VarParam then
      begin
        for i := 0 to v^.ItemCount -1 do
        begin
          Move(p^, v^.orgvar^.tArray.Fields[i].tu8, v^.ElementSize);
          p := pchar(p) + v^.ElementSize;
        end;
      end;
    end;
    {$IFNDEF NOWIDESTRING}
    btWideString:
    begin
      for i := 0 to v^.ItemCount -1 do
      begin
        if v^.varparam then
          widestring(v^.OrgVar^.tArray.Fields[i].twidestring) := widestring(p^);
        Finalize(widestring(p^));
        p := pchar(p) + v^.ElementSize;
      end;
    end;
    {$ENDIF}
    btString:
    begin
      for i := 0 to v^.ItemCount -1 do
      begin
        if v^.varparam then
          string(v^.OrgVar^.tArray.Fields[i].tstring) := string(p^);
        Finalize(string(p^));
        p := pchar(p) + v^.ElementSize;
      end;
    end;
    btVariant:
    begin
    {$IFDEF HAVEVARIANT}
      if v^.OrgVar^.FType.ExportName = '!OPENARRAYOFVARIANT' then
      begin
        for i := 0 to v^.ItemCount -1 do
        begin
          if v^.varparam then
            VariantToPIFVariant(Sender, variant(p^), v^.OrgVar^.tArray.Fields[i]);
          Finalize(variant(p^));
          p := pchar(p) + v^.ElementSize;
        end;
      end
      else
      {$ENDIF}
      begin
        for i := 0 to v^.ItemCount -1 do
        begin
          fv := v^.OrgVar^.tArray.Fields[i];
          if fv^.tvariant^.FType = nil then
          begin
            tvarrec(p^).VType := vtInteger;
          end else begin
            case fv^.tvariant^.ftype^.BaseType of
              btU8: begin
                  if v^.varParam then
                    fv^.tvariant^.tu8 := tvarrec(p^).VInteger;
                end;
              btS8: begin
                  if v^.varParam then
                  fv^.tvariant^.ts8 := tvarrec(p^).VInteger;
                end;
              btU16: begin
                  if v^.varParam then
                  fv^.tvariant^.tu16 := tvarrec(p^).VInteger;
                end;
              btS16: begin
                  if v^.varParam then
                  fv^.tvariant^.ts16 := tvarrec(p^).VInteger;
                end;
              btU32: begin
                  if v^.varParam then
                  fv^.tvariant^.tu32 := tvarrec(p^).VInteger;
                end;
              btS32: begin
                  if v^.varParam then
                  fv^.tvariant^.ts32 := tvarrec(p^).VInteger;
                end;
              btChar: begin
                  if v^.VarParam then
                  fv^.tvariant^.tchar := tvarrec(p^).VChar;
                end;
              btSingle: begin
                if v^.VarParam then
                fv^.tvariant^.tsingle := tvarrec(p^).vextended^;
                dispose(tvarrec(p^).vextended);
              end;
              btDouble: begin
                if v^.VarParam then
                fv^.tvariant^.tdouble := tvarrec(p^).vextended^;
                dispose(tvarrec(p^).vextended);
              end;
              btExtended: begin
                if v^.VarParam then
                fv^.tvariant^.textended := tvarrec(p^).vextended^;
                dispose(tvarrec(p^).vextended);
              end;
              {$IFNDEF NOINT64}
              btS64:
                begin
                  if v^.VarParam then
                    fv^.tvariant^.tu8 := tvarrec(p^).VInt64^;
                  dispose(tvarrec(p^).VInt64);
                end;
              {$ENDIF}
              {$IFNDEF NOWIDESTRING}
              btWideChar: begin
                  if v^.varParam then
                  fv^.tvariant^.twidechar := tvarrec(p^).VWideChar;
                end;
              btWideString:
                begin
                if v^.VarParam then
                  widestring(fv^.tvariant^.twidestring) := widestring(TVarRec(p^).VWideString);
                finalize(widestring(TVarRec(p^).VWideString));
                end;
              {$ENDIF}
              btString: begin
                if v^.VarParam then
                  string(fv^.tvariant^.tstring) := string(TVarRec(p^).VAnsiString);
                finalize(string(TVarRec(p^).VAnsiString));
              end;
              btResourcePointer: begin
                if v^.varparam then
                begin
                  SupFunc.ResToPtr(SupFunc, Sender, Longint(TVarRec(p^).VObject), fv);
                end;
              end;
            end;
          end;
          p := pchar(p) + v^.ElementSize;
        end;
      end;
    end;
  end;
  Dispose(V);
end;

procedure CreateRecordData(Rec: PIFVariant; var Data: string; SE: TIFPSExec; SupFunc: PResourcePtrSupportFuncs);
var
  I: Longint;
begin
  while Rec^.FType^.BaseType = btPointer do
  begin
    Rec := Rec^.tPointer;
    if Rec = nil then begin Data := Data + #0#0#0#0; Exit; end;
  end;
  case Rec^.FType^.BaseType of
  btchar, btS8, btU8: Data := Data + Chr(Rec^.tu8);
  {$IFNDEF NOWIDESTRING}btWideChar, {$ENDIF}btU16, btS16: begin Data := Data + #0#0; Word((@Data[Length(Data)-1])^) := Rec^.tu16; end;
  btS32, btU32: begin Data := Data + #0#0#0#0; Cardinal((@Data[Length(Data)-3])^) := Rec^.tu32; end;
  btSingle: begin Data := Data + #0#0#0#0; Single((@Data[Length(Data)-3])^) := Rec^.tsingle; end;
  btDouble: begin Data := Data + #0#0#0#0#0#0#0#0; Double((@Data[Length(Data)-7])^) := Rec^.tdouble; end;
  btExtended: begin Data := Data + #0#0#0#0#0#0#0#0#0#0; Extended((@Data[Length(Data)-9])^) := Rec^.tExtended; end;
  btString, btPChar: begin Data := Data + #0#0#0#0; tbtString((@Data[Length(Data)-3])^) := tbtString(Rec^.tString); end;
  {$IFNDEF NOWIDESTRING}
  btWideString: begin Data := Data + #0#0#0#0; tbtWideString((@Data[Length(Data)-3])^) := tbtWideString(Rec^.twidestring); end;
  {$ENDIF}
  btRecord, btArray:
    begin
      if Rec^.trecord <> nil then
      begin
        for i := 0 to Rec^.trecord^.FieldCount -1 do
        begin
          CreateRecordData(Rec^.trecord^.Fields[I], Data, Se, SupFunc);
        end;
      end;
    end;
  btResourcePointer:
    begin
      Data := Data + SupFunc^.PtrToStr(SupFunc, Se, Rec);
    end;
{$IFNDEF NOINT64}btS64: begin Data := Data + #0#0#0#0#0#0#0#0; int64((@Data[Length(Data)-7])^) := Rec^.ts64; end;{$ENDIF}
  end;
end;

function CreateRecord(VarParam: Boolean; Sender: TIFPSExec; SupFunc: PResourcePtrSupportFuncs; Val: PIFVariant): PRecord;
begin
  New(Result);
  Result^.AType := 2;
  Result^.orgvar := Val;
  Result^.varparam:= VarParam;
  CreateRecordData(Val, Result^.Data, Sender, SupFunc);
end;

procedure DestroyRecord_(CopyBack: Boolean; Rec: PIFVariant; var Position: Longint; const Data: string; SE: TIFPSExec; SupFunc: PResourcePtrSupportFuncs);
var
  I: Longint;
  P: Pointer;

  procedure GetP(var D; Len: Longint);
  begin
    if Position + Len -1 <= Length(Data) then
    begin
      if CopyBack then Move(Data[Position], D, Len);
      Position := Position + Len;
    end else Position := Length(Data) + 1;
  end;


begin
  while Rec^.FType^.BaseType = btPointer do
  begin
    Rec := Rec^.tPointer;
    if Rec = nil then begin Inc(position, 4); Exit; end;
  end;
  case Rec^.FType^.BaseType of
  btS8, btU8: GetP(Rec^.tu8, 1);
  btU16, btS16: GetP(Rec^.tu16, 2);
  btS32, btU32: GetP(Rec^.tu32, 4);
  btSingle: GetP(Rec^.tsingle, 4);
  btDouble: GetP(Rec^.tdouble, 8);
  btExtended: GetP(Rec^.TExtended, 10);
  btString, btPChar: begin GetP(P, 4); tbtString(Rec^.tString) := string(p); Finalize(tbtString(Rec^.tString)); end;
  {$IFNDEF NOWIDESTRING}
  btWideString: begin GetP(P, 4); tbtWideString(Rec^.tWideString) := WideString(p); Finalize(tbtwideString(Rec^.twideString)); end;
  {$ENDIF}
  btRecord, btArray:
    begin
      if Rec^.trecord <> nil then
      begin
        for i := 0 to Rec^.trecord^.FieldCount -1 do
        begin
          DestroyRecord_(CopyBack, Rec^.trecord^.Fields[I], Position, Data, Se, SupFunc);
        end;
      end;
    end;
  btResourcePointer:
    begin
      GetP(I, 4);
      SupFunc^.ResToPtr(SupFunc, SE, I, Rec);
    end;
{$IFNDEF NOINT64}btS64: begin GetP(Rec^.ts64, 8); end;{$ENDIF}
  end;
end;


procedure DestroyRecord(Sender: TIFPSExec; SupFunc: PResourcePtrSupportFuncs; V: PRecord);
var
  Pos: Longint;
begin
  Pos := 1;
  DestroyRecord_(V^.varparam, V^.orgvar, Pos, V^.Data, Sender, SupFunc);
  Dispose(v);
end;

{$IFDEF DYNARRAY}
type
  TArrU8 = array of byte;
  TArrS8 = array of ShortInt;
  TArrU16 = array of SmallInt;
  TArrS16 = array of Word;
  TArrU32 = array of Cardinal;
  TArrS32 = array of Longint;
  TArrSingle = array of Single;
  TArrDouble = array of Double;
  TArrExtended = array of Extended;
  TArrString = array of String;
{$IFDEF HAVEVARIANT}
  TArrVariant = array of Variant;
{$ENDIF}
{$IFNDEF NOINT64}
    TArrS64 = array of Int64;
{$ENDIF}
  TArrChar = array of Char;
{$IFNDEF NOWIDESTRING}
  TArrWideString = array of WideString;
  TArrWideChar = array of WideChar;
{$ENDIF}


function CreateDynamicArray(VarParam: Boolean; Sender: TIFPSExec; SupFunc: PResourcePtrSupportFuncs; Val: PIFVariant): PDynArray;
var
  I, Len: Longint;
begin
  New(Result);
  Result^.AType := 3;
  Result^.OrgVar := Val;
  Result^.VarParam := VarParam;
  Result^.Data := nil;
  Len := GetIFPSArrayLength(Sender, Val);
  case Sender.GetTypeNo(Longint(Val^.FType^.Ext))^.BaseType of
    btU8:
      begin
        SetLength(TArrU8(Result^.Data), Len);
        for i := Length(TArrU8(Result^.Data)) -1 downto 0 do
          TArrU8(Result^.Data)[i] := Val.tarray.fields[i].tu8;
      end;
    btS8:
      begin
        SetLength(TArrS8(Result^.Data), Len);
        for i := Length(TArrS8(Result^.Data)) -1 downto 0 do
          TArrS8(Result^.Data)[i] := Val.tarray.fields[i].tS8;
      end;
    btU16:
      begin
        SetLength(TArrU16(Result^.Data), Len);
        for i := Length(TArrU16(Result^.Data)) -1 downto 0 do
          TArrU16(Result^.Data)[i] := Val.tarray.fields[i].tu16;
      end;
    btS16:
      begin
        SetLength(TArrs16(Result^.Data), Len);
        for i := Length(TArrs16(Result^.Data)) -1 downto 0 do
          TArrS16(Result^.Data)[i] := Val.tarray.fields[i].ts16;
      end;
    btU32:
      begin
        SetLength(TArrU32(Result^.Data), Len);
        for i := Length(TArrU32(Result^.Data)) -1 downto 0 do
          TArrU32(Result^.Data)[i] := Val.tarray.fields[i].tu32;
      end;
    bts32:
      begin
        SetLength(TArrS32(Result^.Data), Len);
        for i := Length(TArrS32(Result^.Data)) -1 downto 0 do
          TArrS32(Result^.Data)[i] := Val.tarray.fields[i].ts8;
      end;
    btSingle:
      begin
        SetLength(TArrU8(Result^.Data), Len);
        for i := Length(TArrU8(Result^.Data)) -1 downto 0 do
          TArrU8(Result^.Data)[i] := Val.tarray.fields[i].tu8;
      end;
    btDouble:
      begin
        SetLength(TArrDouble(Result^.Data), Len);
        for i := Length(TArrDouble(Result^.Data)) -1 downto 0 do
          TArrDouble(Result^.Data)[i] := Val.tarray.fields[i].tdouble;
      end;
    btExtended:
      begin
        SetLength(TArrExtended(Result^.Data), Len);
        for i := Length(TArrExtended(Result^.Data)) -1 downto 0 do
          TArrExtended(Result^.Data)[i] := Val.tarray.fields[i].tExtended;
      end;
    btString:
      begin
        SetLength(TArrString(Result^.Data), Len);
        for i := Length(TArrString(Result^.Data)) -1 downto 0 do
          TArrString(Result^.Data)[i] := tbtstring(Val.tarray.fields[i].tstring);
      end;
  {$IFDEF HAVEVARIANT}
    btVariant:
      begin
        SetLength(TArrVariant(Result^.Data), Len);
        for i := Length(TArrVariant(Result^.Data)) -1 downto 0 do
        begin
          if not PIFVariantToVariant(Sender, Val.tarray.fields[i], TArrVariant(Result^.Data)[i]) then
          begin
            SetLength(TArrVariant(Result^.Data), 0);
            Dispose(result);
            exit;
          end;
        end;
      end;
  {$ENDIF}
  {$IFNDEF NOINT64}
    btS64:
      begin
        SetLength(TArrS64(Result^.Data), Len);
        for i := Length(TArrS64(Result^.Data)) -1 downto 0 do
          TArrS64(Result^.Data)[i] := Val.tarray.fields[i].ts64;
      end;
  {$ENDIF}
    btChar:
      begin
        SetLength(TArrchar(Result^.Data), Len);
        for i := Length(TArrchar(Result^.Data)) -1 downto 0 do
          TArrchar(Result^.Data)[i] := Val.tarray.fields[i].tchar;
      end;
  {$IFNDEF NOWIDESTRING}
    btWideString:
      begin
        SetLength(TArrwidestring(Result^.Data), Len);
        for i := Length(TArrwidestring(Result^.Data)) -1 downto 0 do
          TArrwidestring(Result^.Data)[i] := tbtwidestring(Val.tarray.fields[i].twidestring);
      end;
    btWideChar:
      begin
        SetLength(TArrWidechar(Result^.Data), Len);
        for i := Length(TArrWidechar(Result^.Data)) -1 downto 0 do
          TArrWidechar(Result^.Data)[i] := Val.tarray.fields[i].twidechar;
      end;
  {$ENDIF}
    else begin
      Dispose(Result);
      Result := nil;
      exit;
    end;
  end;
end;

procedure DestroyDynamicArray(Sender: TIFPSExec; SupFunc: PResourcePtrSupportFuncs; V: PDynArray);
var
  C, I: Longint;
begin
  case Sender.GetTypeNo(Longint(V^.OrgVar^.FType^.Ext))^.BaseType of
    btU8:
      begin
        if v.VarParam then
        begin
          c := Length(TArrU8(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            V.OrgVar.tarray.fields[i].tu8 := TArrU8(v^.Data)[i];
        end;
        SetLength(TArrU8(V^.Data), 0);
      end;
    btS8:
      begin
        if v.VarParam then
        begin
          c := Length(TArrs8(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            V.OrgVar.tarray.fields[i].ts8 := TArrs8(v^.Data)[i];
        end;
        SetLength(TArrs8(V^.Data), 0);
      end;
    btU16:
      begin
        if v.VarParam then
        begin
          c := Length(TArrU16(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            V.OrgVar.tarray.fields[i].tu16 := TArrU16(v^.Data)[i];
        end;
        SetLength(TArrU16(V^.Data), 0);
      end;
    btS16:
      begin
        if v.VarParam then
        begin
          c := Length(TArrs16(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            V.OrgVar.tarray.fields[i].ts16 := TArrs16(v^.Data)[i];
        end;
        SetLength(TArrs16(V^.Data), 0);
      end;
    btU32:
      begin
        if v.VarParam then
        begin
          c := Length(TArrU32(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            V.OrgVar.tarray.fields[i].tu32 := TArrU32(v^.Data)[i];
        end;
        SetLength(TArrU32(V^.Data), 0);
      end;
    bts32:
      begin
        if v.VarParam then
        begin
          c := Length(TArrs32(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            V.OrgVar.tarray.fields[i].ts32 := TArrs32(v^.Data)[i];
        end;
        SetLength(TArrs32(V^.Data), 0);
      end;
    btSingle:
      begin
        if v.VarParam then
        begin
          c := Length(TArrsingle(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            V.OrgVar.tarray.fields[i].tsingle := TArrsingle(v^.Data)[i];
        end;
        SetLength(TArrsingle(v^.Data), 0);
      end;
    btDouble:
      begin
        if v.VarParam then
        begin
          c := Length(TArrDouble(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            V.OrgVar.tarray.fields[i].tdouble := TArrDouble(v^.Data)[i];
        end;
        SetLength(TArrDouble(V^.Data), 0);
      end;
    btExtended:
      begin
        if v.VarParam then
        begin
          c := Length(TArrextended(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            V.OrgVar.tarray.fields[i].tExtended := TArrextended(v^.Data)[i];
        end;
        SetLength(TArrextended(V^.Data), 0);
      end;
    btString:
      begin
        if v.VarParam then
        begin
          c := Length(TArrString(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            tbtstring(V.OrgVar.tarray.fields[i].tstring) := TArrString(v^.Data)[i];
        end;
        SetLength(TArrString(V^.Data), 0);
      end;
  {$IFDEF HAVEVARIANT}
    btVariant:
      begin
        if v.VarParam then
        begin
          c := Length(TArrVariant(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            VariantToPIFVariant(Sender,TArrVariant(v^.Data)[i], V.OrgVar.tarray.fields[i]);
        end;
        SetLength(TArrVariant(V^.Data), 0);
      end;
  {$ENDIF}
  {$IFNDEF NOINT64}
    btS64:
      begin
        if v.VarParam then
        begin
          c := Length(TArrs64(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            V.OrgVar.tarray.fields[i].ts64 := TArrs64(v^.Data)[i];
        end;
        SetLength(TArrU8(V^.Data), 0);
      end;
  {$ENDIF}
    btChar:
      begin
        if v.VarParam then
        begin
          c := Length(TArrChar(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            V.OrgVar.tarray.fields[i].tchar := TArrChar(v^.Data)[i];
        end;
        SetLength(TArrchar(V^.Data), 0);
      end;
  {$IFNDEF NOWIDESTRING}
    btWideString:
      begin
        if v.VarParam then
        begin
          c := Length(TArrWideString(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            tbtwidestring(V.OrgVar.tarray.fields[i].twidestring) := TArrWideString(v^.Data)[i];
        end;
        SetLength(TArrWideString(V^.Data), 0);
      end;
    btWideChar:
      begin
        if v.VarParam then
        begin
          c := Length(TArrWideChar(V^.Data));
          SetIFPSArrayLength(Sender, v.OrgVar, c);
          for i := c -1 downto 0 do
            V.OrgVar.tarray.fields[i].twidechar := TArrWideChar(v^.Data)[i];
        end;
        SetLength(TArrU8(V^.Data), 0);
      end;
  {$ENDIF}
  end;
  Dispose(V);
end;
{$ENDIF}



function InnerfuseCall(SE: TIFPSExec; Self, Address: Pointer; CallingConv: TCallingConvention; Params: TIfList; res: PIfVariant; SupFunc: PResourcePtrSupportFuncs): Boolean;
var
  Stack: ansistring;
  I: Longint;
  RegUsage: Byte;
  CallData: TIfList;
  pp: ^Byte;

  EAX, EDX, ECX: Longint;

  function GetPtr(fVar: PIfVariant): Boolean;
  var
    varPtr: Pointer;
    UseReg: Boolean;
    tempstr: string;
    p: Pointer;
  begin
    Result := False;
    if fVar^.RefCount >= IFPSAddrStackStart then begin
      fvar^.RefCount := FVar^.RefCount and not IFPSAddrStackStart;
      case fVar^.FType^.BaseType of
        btArray:
          begin
            if Copy(fvar^.Ftype^.ExportName, 1, 10) = '!OPENARRAY' then
            begin
              p := CreateOpenArray(True, SE, SupFunc, FVar);
              if p = nil then exit;
              CallData.Add(p);
              case RegUsage of
                0: begin EAX := Longint(@POpenArray(p)^.Data[1]); Inc(RegUsage); end;
                1: begin EDX := Longint(@POpenArray(p)^.Data[1]); Inc(RegUsage); end;
                2: begin ECX := Longint(@POpenArray(p)^.Data[1]); Inc(RegUsage); end;
                else begin
                  Stack := #0#0#0#0 + Stack;
                  Pointer((@Stack[1])^) := @POpenArray(p)^.Data[1];
                end;
              end;
              case RegUsage of
                0: begin EAX := Longint(POpenArray(p)^.ItemCount - 1); Inc(RegUsage); end;
                1: begin EDX := Longint(POpenArray(p)^.ItemCount -1); Inc(RegUsage); end;
                2: begin ECX := Longint(POpenArray(p)^.ItemCount -1); Inc(RegUsage); end;
                else begin
                  Stack := #0#0#0#0 + Stack;
                  Longint((@Stack[1])^) := POpenArray(p)^.ItemCount -1;
                end;
              end;
              Result := True;
              Exit;
            end else begin
            {$IFDEF DYNARRAY}
              p := CreateDynamicArray(True, Se, SupFunc, FVar);
              if p = nil then exit;
              varPtr := @(PDynArray(p)^.Data);
              CallData.Add(p);
            {$ELSE}
              Exit;
            {$ENDIF}
            end;
          end;
        {$IFDEF HAVEVARIANT}
        btVariant:
          begin
            p := CreateVariant(True, SE, SupFunc, FVar);
            VarPtr := @(PVariant(p)^.P);
            CallData.Add(p);
          end;
        {$ENDIF}
        btRecord:
          begin
            p := CreateRecord(True, SE, SupFunc, FVar);
            VarPtr := @(PRecord(P).Data[1]);
            CallData.Add(p);
          end;
        btResourcePointer:
          begin
            if SupFunc = nil then exit;
            tempstr := SupFunc^.VarPtrToStr(SupFunc, SE, fVar);
            if length(tempstr) <> 4 then exit;
            VarPtr := Pointer((@tempstr[1])^);
          end;
        btString: VarPtr := @tbtString(fvar^.tstring);
        btU8, btS8, btU16, btS16, btU32, btS32, btSingle, btDouble,
        btExtended{$IFNDEF NOINT64}, bts64{$ENDIF}: VarPtr := @(fVar^.tu8);
      else begin
          exit; //invalid type
        end;
      end; {case}
      case RegUsage of
        0: begin EAX := Longint(VarPtr); Inc(RegUsage); end;
        1: begin EDX := Longint(VarPtr); Inc(RegUsage); end;
        2: begin ECX := Longint(VarPtr); Inc(RegUsage); end;
        else begin
          Stack := #0#0#0#0 + Stack;
          Pointer((@Stack[1])^) := VarPtr;
        end;
      end;
    end else begin
      UseReg := True;
      case fVar^.FType^.BaseType of
        btArray:
          begin
            if Copy(fvar^.Ftype^.ExportName, 1, 10) = '!OPENARRAY' then
            begin
              p := CreateOpenArray(False, SE, SupFunc, FVar);
              if p =nil then exit;
              CallData.Add(p);
              case RegUsage of
                0: begin EAX := Longint(@POpenArray(p)^.Data[1]); Inc(RegUsage); end;
                1: begin EDX := Longint(@POpenArray(p)^.Data[1]); Inc(RegUsage); end;
                2: begin ECX := Longint(@POpenArray(p)^.Data[1]); Inc(RegUsage); end;
                else begin
                  Stack := #0#0#0#0 + Stack;
                  Pointer((@Stack[1])^) := @POpenArray(p)^.Data[1];
                end;
              end;
              case RegUsage of
                0: begin EAX := Longint(POpenArray(p)^.ItemCount -1); Inc(RegUsage); end;
                1: begin EDX := Longint(POpenArray(p)^.ItemCount -1); Inc(RegUsage); end;
                2: begin ECX := Longint(POpenArray(p)^.ItemCount -1); Inc(RegUsage); end;
                else begin
                  Stack := #0#0#0#0 + Stack;
                  Longint((@Stack[1])^) := POpenArray(p)^.ItemCount -1;
                end;
              end;
              Result := True;
              exit;
            end else begin
            {$IFDEF DYNARRAY}
              p := CreateDynamicArray(True, Se, SupFunc, FVar);
              if p = nil then exit;
              CallData.Add(p);
              TempStr := #0#0#0#0;
              Pointer((@TempStr[1])^) := PDynArray(P)^.Data;
            {$ELSE}
              Exit;
            {$ENDIF}
            end;
          end;
        {$IFDEF HAVEVARIANT}
        btVariant:
          begin
            p := CreateVariant(False, Se, SupFunc, FVar);
            if p = nil then exit;
            TempStr := #0#0#0#0;
            Pointer((@TempStr[1])^) := @(PVariant(p).P);
            CallData.Add(p);
          end;
        {$ENDIF}
        btRecord:
          begin
            p := CreateRecord(False, SE, SupFunc, Fvar);
            CallData.Add(p);
            TempStr := #0#0#0#0;
            Pointer((@TempStr[1])^) := @(PRecord(p).Data[1]);
          end;
        btDouble: {8 bytes} begin
            TempStr := #0#0#0#0#0#0#0#0;
            UseReg := False;
            double((@TempStr[1])^) := fVar^.tdouble;
          end;

        btSingle: {4 bytes} begin
            TempStr := #0#0#0#0;
            UseReg := False;
            Single((@TempStr[1])^) := fVar^.tsingle;
          end;

        btExtended: {10 bytes} begin
            UseReg := False;
            TempStr:= #0#0#0#0#0#0#0#0#0#0#0#0;
            Extended((@TempStr[1])^) := fVar^.textended;
          end;
        btChar,
        btU8,
        btS8: begin
            TempStr := char(fVar^.tu8) + #0#0#0;
          end;
        {$IFNDEF NOWIDESTRING}btWideChar, {$ENDIF}
        btu16, btS16: begin
            TempStr := #0#0#0#0;
            Word((@TempStr[1])^) := fVar^.tu16;
          end;
        btu32, bts32: begin
            TempStr := #0#0#0#0;
            Longint((@TempStr[1])^) := fVar^.tu32;
          end;
        btPChar, btString: begin
            TempStr := #0#0#0#0;
            Pointer((@TempStr[1])^) := fVar^.tstring;
          end;
          {$IFNDEF NOWIDESTRING}
        btWideString: begin
            TempStr := #0#0#0#0;
            Pointer((@TempStr[1])^) := fVar^.twidestring;
          end;
          {$ENDIF}

        btProcPtr:
          begin
            if SupFunc = nil then exit;
            TempStr := SupFunc^.ProcPtrToStr(SupFunc, SE, fVar);
            if Length(TempStr) > 4 then
              UseReg := False
            else
              SetLength(TempStr, 4);
          end;

        btResourcePointer:
          begin
            if SupFunc = nil then exit;
            TempStr := SupFunc^.PtrToStr(SupFunc, SE, fVar);
            if Length(TempStr) > 4 then
              UseReg := False
            else
              SetLength(TempStr, 4);
          end;
        {$IFNDEF NOINT64}bts64: begin
            TempStr:= #0#0#0#0#0#0#0#0;
            Int64((@TempStr[1])^) := fvar^.ts64;
            UseReg := False;
        end;{$ENDIF}
      end; {case}
      if UseReg then
      begin
        case RegUsage of
          0: begin EAX := Longint((@Tempstr[1])^); Inc(RegUsage); end;
          1: begin EDX := Longint((@Tempstr[1])^); Inc(RegUsage); end;
          2: begin ECX := Longint((@Tempstr[1])^); Inc(RegUsage); end;
          else Stack := TempStr + Stack;
        end;
      end else begin
        Stack := TempStr + Stack;
      end;
    end;
    Result := True;
  end;
begin
  InnerfuseCall := False;
  if Address = nil then
    exit; // need address
  Stack := '';
  CallData := TIfList.Create;
  res := rp(res);
  if res <> nil then
    res^.RefCount := res^.RefCount or IFPSAddrStackStart;
  try
  try
    case CallingConv of
      ccRegister: begin
          EAX := 0;
          EDX := 0;
          ECX := 0;
          RegUsage := 0;
          if assigned(Self) then begin
            RegUsage := 1;
            EAX := Longint(Self);
          end;
          for I := 0 to Params.Count - 1 do
          begin
            if not GetPtr(rp(Params.GetItem(I))) then Exit;
          end;
          if assigned(res) then begin
            case res^.FType^.BaseType of
              btResourcePointer:
                begin
                  if SupFunc = nil then exit;
                  if SupFunc^.ResultMethod = rmParam then GetPtr(res);
                end;
              {$IFNDEF NOWIDESTRING}btWideString, {$ENDIF}btrecord, btstring{$IFDEF HAVEVARIANT}, btVariant{$ENDIF}: GetPtr(res);
            end;
            case res^.FType^.BaseType of
              btSingle:      res^.tsingle := RealFloatCall_Register(Address, EAX, EDX, ECX, @Stack[Length(Stack)-3], Length(Stack) div 4);
              btDouble:      res^.tdouble:= RealFloatCall_Register(Address, EAX, EDX, ECX, @Stack[Length(Stack)-3], Length(Stack) div 4);
              btExtended:    res^.textended:= RealFloatCall_Register(Address, EAX, EDX, ECX, @Stack[Length(Stack)-3], Length(Stack) div 4);
              btchar,btU8, btS8:    res^.tu8 := RealCall_Register(Address, EAX, EDX, ECX, @Stack[Length(Stack)-3], Length(Stack) div 4, 1, nil);
              {$IFNDEF NOWIDESTRING}btWideChar, {$ENDIF}btu16, bts16:  res^.tu16:= RealCall_Register(Address, EAX, EDX, ECX, @Stack[Length(Stack)-3], Length(Stack) div 4, 2, nil);
              btu32, bts32:  res^.tu32:= RealCall_Register(Address, EAX, EDX, ECX, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, nil);
              btPChar:       TBTSTRING(res^.tstring) := Pchar(RealCall_Register(Address, EAX, EDX, ECX, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, nil));
              {$IFNDEF NOINT64}bts64:
                begin
                  EAX := RealCall_Register(Address, EAX, EDX, ECX, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, @EDX);
                  res^.ts64 := (EDX shl 32) or EAX;
                end;
              {$ENDIF}
              {$IFDEF HAVEVARIANT}btVariant, {$ENDIF}
              {$IFNDEF NOWIDESTRING}btWidestring: RealCall_Register(Address, EAX, EDX, ECX, @Stack[Length(Stack)-3], Length(Stack) div 4, 0, nil); {$ENDIF}
              btrecord, btstring:      RealCall_Register(Address, EAX, EDX, ECX, @Stack[Length(Stack)-3], Length(Stack) div 4, 0, nil);
              btResourcePointer: if SupFunc^.ResultMethod = rmParam then
                  RealCall_Register(Address, EAX, EDX, ECX, @Stack[Length(Stack)-3], Length(Stack) div 4, 0, nil)
                else
                  SupFunc^.ResToPtr(SupFunc, SE, RealCall_Register(Address, EAX, EDX, ECX, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, nil), res);
            else
              exit;
            end;
          end else
            RealCall_Register(Address, EAX, EDX, ECX, @Stack[Length(Stack)-3], Length(Stack) div 4, 0, nil);
          Result := True;
        end;
      ccPascal: begin
          RegUsage := 3;
          for I :=  0 to Params.Count - 1 do begin
            if not GetPtr(Params.GetItem(i)) then Exit;
          end;
          if assigned(res) then begin
            case res^.FType^.BaseType of
              btResourcePointer:
                begin
                  if SupFunc = nil then exit;
                  if SupFunc^.ResultMethod = rmParam then GetPtr(res);
                end;
              {$IFNDEF NOWIDESTRING}btWideString, {$ENDIF}btrecord, btstring{$IFDEF HAVEVARIANT}, btVariant{$ENDIF}: GetPtr(res);
            end;
          end;
          if assigned(Self) then begin
            Stack := #0#0#0#0 +Stack;
            Pointer((@Stack[1])^) := Self;
          end;
          if assigned(res) then begin
            case res^.FType^.BaseType of
              btSingle:      res^.tsingle := RealFloatCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4);
              btDouble:      res^.tdouble:= RealFloatCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4);
              btExtended:    res^.textended:= RealFloatCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4);
              btChar, btU8, btS8:    res^.tu8 := RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 1, nil);
              {$IFNDEF NOWIDESTRING}btWideChar, {$ENDIF}btu16, bts16:  res^.tu16:= RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 2, nil);
              btu32, bts32:  res^.tu32:= RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, nil);
              btPChar:       TBTSTRING(res^.tstring) := Pchar(RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, nil));
              {$IFNDEF NOINT64}bts64:
                begin
                  EAX := RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, @EDX);
                  res^.ts64 := (EDX shl 32) or EAX;
                end;
              {$ENDIF}
              {$IFDEF HAVEVARIANT}btVariant, {$ENDIF}
              btrecord, btstring:      RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 0, nil);
              btResourcePointer: if SupFunc^.ResultMethod = rmParam then
                  RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 0, nil)
                else
                  SupFunc^.ResToPtr(SupFunc, SE, RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, nil), res);
            else
              exit;
            end;
          end else
            RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 0, nil);
          Result := True;
        end;

      CCCdecl: begin
          RegUsage := 3;
          if assigned(Self) then begin
            Stack := #0#0#0#0;
            Pointer((@Stack[1])^) := Self;
          end;
          for I := Params.Count - 1 downto 0 do begin
            if not GetPtr(Params.GetItem(I)) then Exit;
          end;
          if assigned(res) then begin
            case res^.FType^.BaseType of
              btSingle:      res^.tsingle := RealFloatCall_Cdecl(Address, @Stack[Length(Stack)-3], Length(Stack) div 4);
              btDouble:      res^.tdouble:= RealFloatCall_Cdecl(Address, @Stack[Length(Stack)-3], Length(Stack) div 4);
              btExtended:    res^.textended:= RealFloatCall_Cdecl(Address, @Stack[Length(Stack)-3], Length(Stack) div 4);
              btCHar, btU8, btS8:    res^.tu8 := RealCall_Cdecl(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 1, nil);
              {$IFNDEF NOWIDESTRING}btWideChar, {$ENDIF}btu16, bts16:  res^.tu16:= RealCall_Cdecl(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 2, nil);
              btu32, bts32:  res^.tu32:= RealCall_Cdecl(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, nil);
              btPChar:       TBTSTRING(res^.tstring) := Pchar(RealCall_Cdecl(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, nil));
              {$IFNDEF NOINT64}bts64:
                begin
                  EAX := RealCall_CDecl(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, @EDX);
                  res^.ts64 := (EDX shl 32) or EAX;
                end;
              {$ENDIF}
              {$IFDEF HAVEVARIANT}btVariant, {$ENDIF}{$IFNDEF NOWIDESTRING}btWideString, {$ENDIF}
              btrecord, btstring:      begin GetPtr(res); RealCall_Cdecl(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 0, nil); end;
              btResourcePointer: begin
                if SupFunc = nil then exit;
                if SupFunc^.ResultMethod = rmParam then begin
                  GetPtr(res);
                  RealCall_Cdecl(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 0, nil);
                end else
                  SupFunc^.ResToPtr(SupFunc, SE, RealCall_Cdecl(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, nil), res);
              end;
            else
              exit;
            end;
          end else begin
            RealCall_CDecl(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 0, nil);
          end;
          Result := True;
        end;
      CCStdCall: begin
          RegUsage := 3;
          if assigned(Self) then begin
            Stack := #0#0#0#0;
            Pointer((@Stack[1])^) := Self;
          end;
          for I := Params.Count - 1 downto 0 do begin
            if not GetPtr(Params.GetItem(I)) then exit;
          end;
          if assigned(res) then begin
            case res^.FType^.BaseType of
              btSingle:      res^.tsingle := RealFloatCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4);
              btDouble:      res^.tdouble:= RealFloatCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4);
              btExtended:    res^.textended:= RealFloatCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4);
              btChar, btU8, btS8:    res^.tu8 := RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 1, nil);
              {$IFNDEF NOWIDESTRING}btWideChar, {$ENDIF}btu16, bts16:  res^.tu16:= RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 2, nil);
              btu32, bts32:  res^.tu32:= RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, nil);
              btPChar:       TBTSTRING(res^.tstring) := Pchar(RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, nil));
              {$IFNDEF NOINT64}bts64:
                begin
                  EAX := RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, @EDX);
                  res^.ts64 := (EDX shl 32) or EAX;
                end;
              {$ENDIF}
              {$IFDEF HAVEVARIANT}btVariant, {$ENDIF}{$IFNDEF NOWIDESTRING}btWideString, {$ENDIF}
              btrecord, btstring:      begin GetPtr(res); RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 0, nil); end;
              btResourcePointer: begin
                if SupFunc = nil then exit;
                if SupFunc^.ResultMethod = rmParam then begin
                  GetPtr(res);
                  RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 0, nil);
                end else
                  SupFunc^.ResToPtr(SupFunc, SE, RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 4, nil), res);
              end;
            else
              exit;
            end;
          end else begin
            RealCall_Other(Address, @Stack[Length(Stack)-3], Length(Stack) div 4, 0, nil);
          end;
          Result := True;
        end;
    end;
  except
    on e: Exception do
    begin
      SE.CMD_Err2(erCustomError, e.Message);
      Result := False;
    end;
  end;
  finally
    if res <> nil then
      res^.RefCount := res^.RefCount and not IFPSAddrStackStart;
    for i := CallData.Count -1 downto 0 do
    begin
      pp := CallData.GetItem(i);
      case pp^ of
        0: DestroyOpenArray(SE, SupFunc, Pointer(pp));
        {$IFDEF HAVEVARIANT}1: DestroyVariant(SE, SupFunc, Pointer(pp)); {$ENDIF}
        2: DestroyRecord(SE, SupFunc, Pointer(pp));
        {$IFDEF DYNARRAY}3: DestroyDynamicArray(SE, SupFunc, Pointer(pp));{$ENDIF}
      end;
    end;
    CallData.Free;
  end;
end;
{$IFDEF HAVEVARIANT}
begin
  VNull := Null;
{$ENDIF}
end.

