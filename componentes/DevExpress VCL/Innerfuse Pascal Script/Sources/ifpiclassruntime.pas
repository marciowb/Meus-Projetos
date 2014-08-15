{Classes runtime unit}
unit ifpiclassruntime;
{
Innerfuse Pascal Script III
Copyright (C) 2000-2002 by Carlo Kok (ck@carlo-kok.com)
}
{$I ifps3_def.inc}
interface
uses SysUtils, ifps3, ifps3utl, ifps3common, ifpicall;

type
  EIFPS3Exception = class(Exception);
  {TIFPSRuntimeClass is one class at runtime}
  TIFPSRuntimeClass = class
  protected
    FClassName: string;
    FClassNameHash: Longint;

    FClassItems: TIFList;
    FClass: TClass;

    FEndOfVmt: Longint;
  public
    {Register a constructor}
    procedure RegisterConstructor(ProcPtr: Pointer; const Name: string);
	{Register a virtual constructor}
    procedure RegisterVirtualConstructor(ProcPtr: Pointer; const Name: string);
	{Register a method}
    procedure RegisterMethod(ProcPtr: Pointer; const Name: string);
	{Register a virtual method}
    procedure RegisterVirtualMethod(ProcPtr: Pointer; const Name: string);
	{Register an abstract virtual method}
    procedure RegisterVirtualAbstractMethod(ClassDef: TClass; ProcPtr: Pointer; const Name: string);
    {Register a property helper}
    procedure RegisterPropertyHelper(ReadFunc, WriteFunc: Pointer; const Name: string);
    {Register a property helper that is an event}
    procedure RegisterEventPropertyHelper(ReadFunc, WriteFunc: Pointer; const Name: string);
    {create}
    constructor Create(aClass: TClass; const AName: string);
	{destroy}
    destructor Destroy; override;
  end;
  {TIFPSRuntimeClassImporter is the runtime class importer}
  TIFPSRuntimeClassImporter = class
  private
    FClasses: TIFList;
  public
    {create}
    constructor Create;
	{destroy}
    destructor Destroy; override;
    {Add a class}
    function Add(aClass: TClass): TIFPSRuntimeClass;
    function Add2(aClass: TClass; const Name: string): TIFPSRuntimeClass;
    {Clear}
    procedure Clear;
    {Search for a class}
    function FindClass(const Name: string): TIFPSRuntimeClass;
  end;


{Register the classes at runtime}
procedure RegisterClassLibraryRuntime(SE: TIFPSExec; Importer: TIFPSRuntimeClassImporter);
{Set a runtime variant}
procedure SetVariantToClass(V: PIFVariant; Cl: TObject);
{Return the RPFuncs for other libraries}
function ClassRuntimeGetRPFuncs: PResourcePtrSupportFuncs;

{Internal function: Script Event Handler}
procedure MyAllMethodsHandler;
function DummyResourceFree(FMode: TVRFMode; P, IntoP: PIFVariant): Boolean;
{Internal Function: Returns the Data pointer of a TMethod for a ProcNo}
function GetMethodInfoRec(SE: TIFPSExec; ProcNo: Cardinal): Pointer;

function MkMethod(FSE: TIFPSExec; No: Cardinal): TMethod;

function ClassVariantInfo(pvar: PIFVariant; const PropertyName: string): string;

implementation
uses
  TypInfo, ifpidelphiruntime;

type
  TIFPSExecHack = class (TIFPSExec) end;
  PScriptMethodInfo = ^TScriptMethodInfo;
  TScriptMethodInfo = record
    Se: TIFPSExecHack;
    ProcNo: Cardinal;
  end;


function MkMethod(FSE: TIFPSExec; No: Cardinal): TMethod;
begin
  if no = 0 then
  begin
    Result.Code := nil;
    Result.Data := nil;
  end else begin
    Result.Code := @MyAllMethodsHandler;
    Result.Data := GetMethodInfoRec(FSE, No);
  end;
end;


procedure PFree(Sender: TIFPSExec; P: PScriptMethodInfo);
begin
  Dispose(p);
end;

function GetMethodInfoRec(SE: TIFPSExec; ProcNo: Cardinal): Pointer;
var
  I: Longint;
  pp: PScriptMethodInfo;
begin
  I := 0;
  repeat
    pp := Se.FindProcResource2(@PFree, I);
    if (i <> -1) and (pp^.ProcNo = ProcNo) then
    begin
      Result := Pp;
      exit;
    end;
  until i = -1;
  New(pp);
  pp^.Se := TIFPSExecHack(Se);
  pp^.ProcNo := Procno;
  Se.AddResource(@PFree, pp);
  Result := pp;
end;

function DummyResourceFree(FMode: TVRFMode; P, IntoP: PIFVariant): Boolean;
begin
  if FMode = vrfDuplicate then
  begin
    IntoP.tResourceP1 := p.tResourceP1;
    IntoP.tResourceFreeProc := p.tResourceFreeProc;
  end;

  Result := True;
end;

function PropertyToString(Instance: TObject; PName: string): string;
var
  s: string;
  i: Longint;
  PP: PPropInfo;
begin
  if PName = '' then
  begin
    Result := Instance.ClassName;
    exit;
  end;
  while Length(PName) > 0 do
  begin
    i := pos('.', pname);
    if i = 0 then
    begin
      s := Trim(PNAme);
      pname := '';
    end else begin
      s := trim(Copy(PName, 1, i-1));
      Delete(PName, 1, i);
    end;
    pp := GetPropInfo(PTypeInfo(Instance.ClassInfo), s);
    if pp = nil then begin Result := 'Unknown Identifier'; exit; end;

    case pp^.PropType^.Kind of
      tkInteger: begin Result := IntToStr(GetOrdProp(Instance, pp)); exit; end;
      tkChar: begin Result := '#'+IntToStr(GetOrdProp(Instance, pp)); exit; end;
      tkEnumeration: begin Result := GetEnumName(pp^.PropType{$IFDEF D3PLUS}^{$ENDIF}, GetOrdProp(Instance, pp)); exit; end;
      tkFloat: begin Result := FloatToStr(GetFloatProp(Instance, PP)); exit; end;
      tkString, tkLString: begin Result := ''''+GetStrProp(Instance, PP)+''''; exit; end;
      tkSet: begin Result := '[Set]'; exit; end;
      tkClass: begin Instance := TObject(GetOrdProp(Instance, pp)); end;
      tkMethod: begin Result := '[Method]'; exit; end;
      tkVariant: begin Result := '[Variant]'; exit; end;
      else begin Result := '[Unknown]'; exit; end;
    end;
    if Instance = nil then begin result := 'nil'; exit; end;
  end;
  Result := Instance.ClassName;
 end;

function ClassVariantInfo(pvar: PIFVariant; const PropertyName: string): string;
begin
  if pvar^.FType^.BaseType = btResourcePointer then
  begin
    if (pvar^.tResourceP1 = nil) or (@pvar^.tResourceFreeProc = nil) then
	begin
      if PropertyName = '' then
        Result := 'nil'
	  else 
	    Result := 'Inaccessible Value';
    end else if (@pvar^.tResourceFreeProc = @DummyResourceFree) then
      Result := PropertyToString(TObject(pvar^.tResourceP1), PropertyName);
  end else Result := 'Invalid Type';
end;


function ResourcePtrToStr(PSelf: PResourcePtrSupportFuncs; Sender: TIFPSExec; P: PIFVariant): string;
begin
  SetLength(Result, 4);
  Pointer((@Result[1])^) := P^.tResourceP1;
end;

function VarResourcePtrToStr(PSelf: PResourcePtrSupportFuncs; Sender: TIFPSExec; P: PIFVariant): string;
begin
  SetLength(Result, 4);
  Pointer((@Result[1])^) := @P^.tResourceP1;
  p^.tResourceFreeProc := DummyResourceFree;
end;

procedure ResultToResourcePtr(PSelf: PResourcePtrSupportFuncs; Sender: TIFPSExec; Data: Longint; P: PIFVariant);
begin
  if Data = 0 then
  begin
    p^.tResourceP1 := nil;
    p^.tResourceFreeProc := nil;
  end else
  begin
    p^.tResourceP1 := Pointer(Data);
    p^.tResourceFreeProc := DummyResourceFree;
  end;
end;


function ProcPtrToStr(PSelf: PResourcePtrSupportFuncs; Sender: TIFPSExec; P: PIFVariant): string;
begin
  Setlength(Result, 8);
  TMethod((@Result[1])^) := MKMethod(Sender, P^.tu32);
end;

const
  ResourcePtrSupport: TResourcePtrSupportFuncs = (
    ptr: nil;
    PtrToStr: ResourcePtrToStr;
    VarPtrToStr: VarResourcePtrToStr;
    ResultMethod: rmRegister;
    ResToPtr: ResultToResourcePtr;
    ProcPtrToStr: ProcPtrToStr);

function ClassRuntimeGetRPFuncs: PResourcePtrSupportFuncs;
begin
  Result := @ResourcePtrSupport;
end;

type
  TPtrArr = array[0..1000] of Pointer;
  PPtrArr = ^TPtrArr;
  TByteArr = array[0..1000] of byte;
  PByteArr = ^TByteArr;
  PPointer = ^Pointer;


function VirtualMethodPtrToPtr(Ptr, FSelf: Pointer): Pointer;
begin
  Result := PPtrArr(PPointer(FSelf)^)^[Longint(Ptr)];
end;

function VirtualClassMethodPtrToPtr(Ptr, FSelf: Pointer): Pointer;
begin
  Result := PPtrArr(FSelf)^[Longint(Ptr)];
end;


procedure CheckPackagePtr(var P: PByteArr);
begin
  if (word((@p[0])^) = $25FF) and (word((@p[6])^)=$C08B)then
  begin
    p := PPointer((@p[2])^)^;
  end;
end;

function FindVirtualMethodPtr(Ret: TIFPSRuntimeClass; FClass: TClass; Ptr: Pointer): Pointer;
// Idea of getting the number of VMT items from GExperts
var
  p: PPtrArr;
  I: Longint;
begin
  p := Pointer(FClass);
  CheckPackagePtr(PByteArr(Ptr));
  if Ret.FEndOfVMT = MaxInt then
  begin
    I := {$IFDEF VER90}-48{$ELSE}vmtSelfPtr{$ENDIF} div SizeOf(Pointer) + 1;
    while I < 0 do
    begin
      if I < 0 then
      begin
        if I <> ({$IFDEF VER90}-44{$ELSE}vmtTypeInfo{$ENDIF} div SizeOf(Pointer)) then
        begin // from GExperts code
          if (Longint(p^[I]) > Longint(p)) and ((Longint(p^[I]) - Longint(p))
            div
            4 < Ret.FEndOfVMT) then
          begin
            Ret.FEndOfVMT := (Longint(p^[I]) - Longint(p)) div SizeOf(Pointer);
          end;
        end;
      end;
      Inc(I);
    end;
    if Ret.FEndOfVMT = MaxInt then
    begin
      Ret.FEndOfVMT := 0; // cound not find EndOfVMT
      Result := nil;
      exit;
    end;
  end;
  I := 0;
  while I < Ret.FEndOfVMT do
  begin
    if p^[I] = Ptr then
    begin
      Result := Pointer(I);
      exit;
    end;
    I := I + 1;
  end;
  Result := nil;
end;


type
  PClassItem = ^TClassItem;
  TClassItem = record
    FName: string;
    FNameHash: Longint;
    b: byte;
    case byte of
    0: (Ptr: Pointer); {Method}
    1: (PointerInList: Pointer); {Virtual Method}
    3: (FReadFunc, FWriteFunc: Pointer); {Property Helper}
    4: (Ptr2: Pointer); {Constructor}
    5: (PointerInList2: Pointer); {virtual constructor}
    6: (); {Property helper, like 3}
  end;


function ClassCallProcMethod(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
var
  i: Integer;
  MyList: TIfList;
  n: PIFVariant;
  FSelf: Pointer;
  CurrStack: Cardinal;
  cc: TCallingConvention;
  s: string;
begin
  s := p^.ExportDecl;
  if length(S) < 2 then
  begin
    Result := False;
    exit;
  end;
  cc := TCallingConvention(s[1]);
  delete(s, 1, 1);
  if s[1] = #0 then
    n := rp(Stack.GetItem(Stack.Count -1))
  else
    n := rp(Stack.GetItem(Stack.Count -2));
  if (n = nil) or (n^.Ftype^.BaseType <> btResourcePointer) or (@n^.tResourceFreeProc <> @DummyResourceFree) or (n^.tresourcep1 = nil) then
  begin
    result := false;
    exit;
  end;
  FSelf := n^.tResourceP1;
  CurrStack := Stack.Count - Cardinal(length(s)) -1;
  if s[1] = #0 then inc(CurrStack);
  MyList := tIfList.Create;
  for i := 2 to length(s) do
  begin
    MyList.Add(nil);
  end;
  for i := length(s) downto 2 do
  begin
    n :=rp(Stack.GetItem(CurrStack));
    if s[i] <> #0 then
    begin
      n^.RefCount := n^.RefCount or IFPSAddrStackStart;
    end;
    MyList.SetItem(i - 2, n);
    inc(CurrStack);
  end;
  try
    if s[1] <> #0 then
    begin
      n := rp(Stack.GetItem(CurrStack + 1));
    end else n := nil;
    if p^.Ext2 = nil then
      InnerfuseCall(Caller, FSelf, p^.Ext1, cc, MyList, n, @ResourcePtrSupport)
    else
      InnerfuseCall(Caller, FSelf, VirtualMethodPtrToPtr(p^.Ext1, FSelf), cc, MyList, n, @ResourcePtrSupport);
    result := true;
  except
    result := false;
  end;
  MyList.Free;
end;

const
  IntType: TIFTypeRec = (BaseType: btU32);
  IntVal: TIFVariant = (FType: @IntType; RefCount: 1; tu32: 1);


function ClassCallProcConstructor(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
var
  i, h: Longint;
  MyList: TIfList;
  n: PIFVariant;
  FSelf: Pointer;
  CurrStack: Cardinal;
  cc: TCallingConvention;
  s: string;
  FType: PIFTypeRec;
  x: TIFPSRuntimeClass;
begin
  n := rp(Stack.GetItem(Stack.Count -2));
  if (n = nil) or (n^.Ftype^.BaseType <> btU32)  then
  begin
    result := false;
    exit;
  end;
  FType := Caller.GetTypeNo(N^.tu32);
  if (FType = nil)  then
  begin
    Result := False;
    exit;
  end;
  h := MakeHash(FType^.ExportName);
  FSelf := nil;
  for i := 0 to TIFPSRuntimeClassImporter(p^.Ext2).FClasses.Count -1 do
  begin
    x:= TIFPSRuntimeClassImporter(p^.Ext2).FClasses.GetItem(i);
    if (x.FClassNameHash = h) and (x.FClassName = FType^.ExportName) then
    begin
      FSelf := x.FClass;
    end;
  end;
  if FSelf = nil then begin
    Result := False;
    exit;
  end;
  s := p^.ExportDecl;
  if length(S) < 2 then
  begin
    Result := False;
    exit;
  end;
  cc := TCallingConvention(s[1]);
  delete(s, 1, 1);
  CurrStack := Stack.Count - Cardinal(length(s)) -1;
//CurrStack := Stack.Count - Cardinal(length(s));
  if s[1] = #0 then inc(CurrStack);
  MyList := tIfList.Create;
  MyList.Add(@IntVal);
  for i := 2 to length(s) do
  begin
    MyList.Add(nil);
  end;
  for i := length(s) downto 2 do
  begin
    n :=rp(Stack.GetItem(CurrStack));
    if s[i] <> #0 then
    begin
      n^.RefCount := n^.RefCount or IFPSAddrStackStart;
    end;
    MyList.SetItem(i - 1, n);
    inc(CurrStack);
  end;
  try
    if s[1] <> #0 then
    begin
      n := rp(Stack.GetItem(CurrStack +1));
    end else n := nil;
    InnerfuseCall(Caller, FSelf, p^.Ext1, cc, MyList, n, @ResourcePtrSupport);
    result := true;
  except
    result := false;
  end;
  MyList.Free;
end;
function ClassCallProcVirtualConstructor(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
var
  i, h: Longint;
  MyList: TIfList;
  n: PIFVariant;
  FSelf: Pointer;
  CurrStack: Cardinal;
  cc: TCallingConvention;
  s: string;
  FType: PIFTypeRec;
  x: TIFPSRuntimeClass;
begin
  n := rp(Stack.GetItem(Stack.Count -2));
  if (n = nil) or (n^.Ftype^.BaseType <> btU32)  then
  begin
    result := false;
    exit;
  end;
  FType := Caller.GetTypeNo(N^.tu32);
  if (FType = nil)  then
  begin
    Result := False;
    exit;
  end;
  h := MakeHash(FType^.ExportName);
  FSelf := nil;
  for i := 0 to TIFPSRuntimeClassImporter(p^.Ext2).FClasses.Count -1 do
  begin
    x:= TIFPSRuntimeClassImporter(p^.Ext2).FClasses.GetItem(i);
    if (x.FClassNameHash = h) and (x.FClassName = FType^.ExportName) then
    begin
      FSelf := x.FClass;
      Break;
    end;
  end;
  if FSelf = nil then begin
    Result := False;
    exit;
  end;
  s := p^.ExportDecl;
  if length(S) < 2 then
  begin
    Result := False;
    exit;
  end;
  cc := TCallingConvention(s[1]);
  delete(s, 1, 1);
  CurrStack := Stack.Count - Cardinal(length(s)) -1;
  if s[1] = #0 then inc(CurrStack);
  MyList := tIfList.Create;
  MyList.Add(@IntVal);
  for i := 2 to length(s) do
  begin
    MyList.Add(nil);
  end;
  for i := length(s) downto 2 do
  begin
    n :=rp(Stack.GetItem(CurrStack));
    if s[i] <> #0 then
    begin
      n^.RefCount := n^.RefCount or IFPSAddrStackStart;
    end;
    MyList.SetItem(i - 1, n);
    inc(CurrStack);
  end;
  try
    if s[1] <> #0 then
    begin
      n := rp(Stack.GetItem(CurrStack + 1));
    end else n := nil;
    InnerfuseCall(Caller, FSelf, VirtualClassMethodPtrToPtr(p^.Ext1, FSelf), cc, MyList, n, @ResourcePtrSupport);
    result := true;
  except
    result := false;
  end;
  MyList.Free;
end;

function CastProc(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
var
  TypeNo, InVar, ResVar: PIFVariant;
  FSelf: TClass;
  FType: PIFTypeRec;
  H, I: Longint;
  x: TIFPSRuntimeClass;
begin
  TypeNo := rp(Stack.GetItem(Stack.Count-3));
  InVar := rp(Stack.GetItem(Stack.Count-2));
  ResVar := rp(Stack.GetItem(Stack.Count-1));
  if (TypeNo = nil) or (InVar = nil) or (ResVar = nil) or (InVar^.FType^.BaseType <> btResourcePointer) or (ResVar^.FType^.BaseType <> btResourcePointer) or (TypeNo^.FType^.BaseType <> btu32) then
  begin
    Result := False;
    Exit;
  end;
  if InVar^.tResourceP1 = nil then
  begin
    ResVar^.tResourceP1 := nil;
    ResVar^.tResourceFreeProc:= nil;
    result := True;
    exit;
  end;
  FType := Caller.GetTypeNo(TypeNo^.tu32);
  if (FType = nil)  then
  begin
    Result := False;
    exit;
  end;
  h := MakeHash(FType^.ExportName);
  FSelf := nil;
  for i := 0 to TIFPSRuntimeClassImporter(p^.Ext2).FClasses.Count -1 do
  begin
    x:= TIFPSRuntimeClassImporter(p^.Ext2).FClasses.GetItem(i);
    if (x.FClassNameHash = h) and (x.FClassName = FType^.ExportName) then
    begin
      FSelf := x.FClass;
    end;
  end;
  if FSelf = nil then begin
    Result := False;
    exit;
  end;
  ResVar^.tResourceFreeProc := DummyResourceFree;
  try
    resVar^.tResourceP1 := TObject(InVar^.tResourceP1) as FSelf;
  except
    Result := False;
    exit;
  end;
  result := True;
end;

function CompareProc(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
var
  p1, p2, pres: PIFVariant;
begin
  p1 := rp(Stack.GetItem(Stack.Count -3));
  p2 := rp(Stack.GetItem(Stack.Count -2));
  pres := rp(Stack.GetItem(Stack.Count -1));
  if (p1=nil) or (p2=nil) or (pres = nil) or (p1^.FType^.BaseType <> btResourcePointer) or (p2^.FType^.BaseType <> btResourcePointer) or (pres^.FType^.BaseType <> btu8) then
  begin
    Result := False;
    exit;
  end;
  if (p1^.tResourceP1 = p2^.tResourceP1) and (@p1^.tResourceFreeProc = @p2^.tResourceFreeProc) then
    pres^.tu32 := 1
  else
    pres^.tu32 := 0;
  Result := True;
end;

function NilProc(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
var
  n: PIFVariant;
begin
  n := rp(Stack.GetItem(Stack.Count-1));
  if (n = nil) or (n^.FType^.BaseType <> btResourcePointer) then
  begin
    Result := False;
    Exit;
  end;
  n^.tResourceP1 := nil;
  n^.tResourceFreeProc := nil;
  result := True;
end;


function getMethodNo(P: TMethod): Cardinal;
begin
  if (p.Code <> @MyAllMethodsHandler) or (p.Data = nil) then
    Result := 0
  else
  begin
    Result := PScriptMethodInfo(p.Data)^.ProcNo;
  end;
end;

function ClassCallProcProperty(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
var
  n: PIFVariant;
  FSelf: Pointer;
begin
  if p^.Ext2 = Pointer(0) then
  begin
    n := rp(Stack.GetItem(Stack.Count -1));
    if (n = nil) or (n^.Ftype^.BaseType <> btResourcePointer) or (@n^.tResourceFreeProc <> @DummyResourceFree) then
    begin
      result := false;
      exit;
    end;
    FSelf := n^.tResourceP1;
    n := rp(Stack.GetItem(Stack.Count -2));
    if (PPropInfo(p^.Ext1)^.PropType^.Kind = tkMethod) and ((n^.FType^.BaseType = btu32) or (n^.FType^.BaseType = btProcPtr))then
    begin
        SetMethodProp(TObject(FSelf), PPropInfo(p^.Ext1), MkMethod(Caller, n^.tu32));
    end else
    case n^.FType^.BaseType of
      btChar, btU8: SetOrdProp(TObject(FSelf), PPropInfo(p^.Ext1), n^.tu8);
      btS8: SetOrdProp(TObject(FSelf), PPropInfo(p^.Ext1), n^.ts8);
      {$IFNDEF NOWIDESTRING}btwidechar, {$ENDIF}btU16: SetOrdProp(TObject(FSelf), PPropInfo(p^.Ext1), n^.tu16);
      btS16: SetOrdProp(TObject(FSelf), PPropInfo(p^.Ext1), n^.ts16);
      btU32: SetOrdProp(TObject(FSelf), PPropInfo(p^.Ext1), n^.tu32);
      btS32: SetOrdProp(TObject(FSelf), PPropInfo(p^.Ext1), n^.ts32);
      btSingle: SetFloatProp(TObject(FSelf), p^.Ext1, n^.tsingle);
      btDouble: SetFloatProp(TObject(FSelf), p^.Ext1, n^.tdouble);
      btExtended: SetFloatProp(TObject(FSelf), p^.Ext1, Extended(n^.textended));
      btString: SetStrProp(TObject(FSelf), p^.Ext1, string(n^.tstring));
      btPChar: SetStrProp(TObject(FSelf), p^.Ext1, string(n^.tstring));
      btResourcePointer:
      begin
        if (@n^.tResourceFreeProc = nil) then
          SetOrdProp(TObject(FSelf), p^.Ext1, Longint(n^.tResourceP1))
        else if @n^.tResourceFreeProc = @DummyResourceFree then
          SetOrdProp(TObject(FSelf), p^.Ext1, Longint(n^.tResourceP1))
        else begin
          Result := False;
          exit;
        end;

      end;
      else
      begin
        Result := False;
        exit;
      end;
    end;
    Result := true;
  end else begin
    n := rp(Stack.GetItem(Stack.Count -2));
    if (n = nil) or (n^.Ftype^.BaseType <> btResourcePointer) or (@n^.tResourceFreeProc <> @DummyResourceFree) then
    begin
      result := false;
      exit;
    end;
    FSelf := n^.tResourceP1;
    n := rp(Stack.GetItem(Stack.Count -1));
    if (PPropInfo(p^.Ext1)^.PropType^.Kind = tkMethod) and ((n^.FType^.BaseType = btu32) or (n^.FType^.BaseType = btprocptr)) then
    begin
      n^.tu32 := GetMethodNo(GetMethodProp(TObject(FSelf), PPropInfo(p^.Ext1)));
    end else
    case n^.FType^.BaseType of
      btU8: n^.tu8 := GetOrdProp(TObject(FSelf), p^.Ext1);
      btS8: n^.tS8 := GetOrdProp(TObject(FSelf), p^.Ext1);
      btU16: n^.tu16 := GetOrdProp(TObject(FSelf), p^.Ext1);
      btS16: n^.tS16 := GetOrdProp(TObject(FSelf), p^.Ext1);
      btU32: n^.tu32 := GetOrdProp(TObject(FSelf), p^.Ext1);
      btS32: n^.tS32 := GetOrdProp(TObject(FSelf), p^.Ext1);
      btSingle: n^.tsingle := GetFloatProp(TObject(FSelf), p^.Ext1);
      btDouble: n^.tdouble := GetFloatProp(TObject(FSelf), p^.Ext1);
      btExtended: n^.textended := GetFloatProp(TObject(FSelf), p^.Ext1);
      btString: string(n^.tstring) := GetStrProp(TObject(FSelf), p^.Ext1);
      btPChar: string(n^.tstring) := GetStrProp(TObject(FSelf), p^.Ext1);
      btResourcePointer:
      begin
        n^.tResourceP1 := Pointer(GetOrdProp(TObject(FSelf), p^.Ext1));
        n^.tResourceFreeProc := DummyResourceFree;
      end;
    else
      begin
        Result := False;
        exit;
      end;

    end;
    Result := True;
  end;
end;

function ClassCallProcPropertyHelper(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
var
  I, ParamCount: Longint;
  Params: TIfList;
  n: PIfVariant;
  FSelf: Pointer;
begin
  if Length(P^.ExportDecl) < 4 then begin
    Result := False;
    exit;
  end;
  ParamCount := Longint((@P^.ExportDecl[1])^);
  if Longint(Stack.Count) < ParamCount +1 then begin
    Result := False;
    exit;
  end;
  Dec(ParamCount);
  if p^.Ext1 <> nil then // read
  begin
    n := rp(Stack.GetItem(Longint(Stack.Count) - 2));
    if (n = nil) or (n^.Ftype^.BaseType <> btResourcePointer) or (@n^.tResourceFreeProc <> @DummyResourceFree) then
    begin
      result := false;
      exit;
    end;
    FSelf := n^.tResourceP1;
    Params := TIfList.Create;
    n := rp(Stack.GetItem(Longint(Stack.Count) - 1)); // Result
    n^.RefCount := n^.RefCount or IFPSAddrStackStart;
    Params.Add(n);
    for i := Stack.Count -3 downto Longint(Stack.Count) - ParamCount -2 do
    begin
      n := rp(Stack.GetItem(I));
      Params.Add(n);
    end;
    InnerfuseCall(Caller, FSelf, p^.Ext1, ccRegister, Params, nil, @ResourcePtrSupport);
    Params.Free;
    Result := True;
  end else begin
    n := rp(Stack.GetItem(Stack.Count -1));
    if (n = nil) or (n^.Ftype^.BaseType <> btResourcePointer) or (@n^.tResourceFreeProc <> @DummyResourceFree) then
    begin
      result := false;
      exit;
    end;
    FSelf := n^.tResourceP1;
    Params := TIfList.Create;
    Params.Add(rp(Stack.GetItem(Longint(Stack.Count) - ParamCount - 2)));

    for i := Stack.Count -2 downto Longint(Stack.Count) - ParamCount -1 do
    begin
      Params.Add(rp(Stack.GetItem(I)));
    end;
    InnerfuseCall(Caller, FSelf, p^.Ext2, ccregister, Params, nil, @ResourcePtrSupport);
    Params.Free;
    Result := True;
  end;
end;


const
  TMethodType: TIFTypeRec = (Ext: nil; BaseType: btDouble);


function ClassCallProcEventPropertyHelper(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
{Event property helper}
var
  I, ParamCount: Longint;
  Params: TIfList;
  n, n2: PIfVariant;
  FSelf: Pointer;
begin
  if Length(P^.ExportDecl) < 4 then begin
    Result := False;
    exit;
  end;
  ParamCount := Longint((@P^.ExportDecl[1])^);
  if Longint(Stack.Count) < ParamCount +1 then begin
    Result := False;
    exit;
  end;
  Dec(ParamCount);
  if p^.Ext1 <> nil then // read
  begin
    n := rp(Stack.GetItem(Longint(Stack.Count) - 2));
    if (n = nil) or (n^.Ftype^.BaseType <> btResourcePointer) or (@n^.tResourceFreeProc <> @DummyResourceFree) then
    begin
      result := false;
      exit;
    end;
    FSelf := n^.tResourceP1;
    n := rp(Stack.GetItem(Longint(Stack.Count) - 1)); // Result
    if n^.FType^.BaseType <> btU32 then
    begin
      Result := False;
      exit;
    end;
    Params := TIfList.Create;
    new(n2);
    n2^.FType := @TMethodType;
    n2^.RefCount := 1 + IFPSAddrStackStart;
    TMethod(n2^.tdouble).Code := nil;
    TMethod(n2^.tdouble).Data := nil;
    Params.Add(n2);
    for i := Stack.Count -3 downto Longint(Stack.Count) - ParamCount -2 do
    begin
      n := rp(Stack.GetItem(I));
      Params.Add(n);
    end;
    InnerfuseCall(Caller, FSelf, p^.Ext1, ccRegister, Params, nil, @ResourcePtrSupport);
    n^.tu32 := getMethodNo(TMethod(n2^.tdouble));
    Params.Free;
    Result := True;
  end else begin
    n := rp(Stack.GetItem(Stack.Count -1));
    if (n = nil) or (n^.Ftype^.BaseType <> btResourcePointer) or (@n^.tResourceFreeProc <> @DummyResourceFree) then
    begin
      result := false;
      exit;
    end;
    FSelf := n^.tResourceP1;
    n := rp(Stack.GetItem(Longint(Stack.Count) - ParamCount - 2));
    if (n^.FType^.BaseType <> btu32) and (n^.FType^.BaseType <> btProcPtr) then
    begin
      result := false;
      exit;
    end;
    new(n2);
    n2^.FType := @TMethodType;
    n2^.RefCount := 1;
    TMethod(n2^.tdouble) := MkMethod(Caller, n^.tu32);
    Params := TIfList.Create;
    Params.Add(n2);

    for i := Stack.Count -2 downto Longint(Stack.Count) - ParamCount -1 do
    begin
      Params.Add(rp(Stack.GetItem(I)));
    end;
    InnerfuseCall(Caller, FSelf, p^.Ext2, ccregister, Params, nil, @ResourcePtrSupport);
    Dispose(n2);
    Params.Free;
    Result := True;
  end;
end;


{'class:'+CLASSNAME+'|'+FUNCNAME+'|'+chr(CallingConv)+chr(hasresult)+params

For property write functions there is an '@' after the funcname.
}
function SpecImport(Sender: TIFPSExec; p: PIFProcRec; Tag: Pointer): Boolean;
var
  H, I: Longint;
  S, s2: string;
  CL: TIFPSRuntimeClass;
  Px: PClassItem;
  pp: PPropInfo;
  IsRead: Boolean;
begin
  s := p^.ExportDecl;
  delete(s, 1, 6);
  if s = '-' then {nil function}
  begin
    p^.ProcPtr := NilProc;
    Result := True;
    exit;
  end;
  if s = '+' then {cast function}
  begin
    p^.ProcPtr := CastProc;
    p^.Ext2 := Tag;
    Result := True;
    exit;
  end;
  if s = '*' then {compare function}
  begin
    p^.ProcPtr := CompareProc;
    p^.Ext2 := Tag;
    Result := True;
    exit;
  end;
  s2 := copy(S, 1, pos('|', s)-1);
  delete(s, 1, length(s2) + 1);
  H := MakeHash(s2);
  ISRead := False;
  cl := nil;
  for I := TIFPSRuntimeClassImporter(Tag).FClasses.Count -1 downto 0 do
  begin
    Cl := TIFPSRuntimeClassImporter(Tag).FClasses.GetItem(I);
    if (Cl.FClassNameHash = h) and (cl.FClassName = s2) then
    begin
      IsRead := True;
      break;
    end;
  end;
  if not isRead then begin
    Result := False;
    exit;                 
  end;
  s2 := copy(S, 1, pos('|', s)-1);
  delete(s, 1, length(s2) + 1);
  if (s2 <> '') and (s2[length(s2)] = '@') then
  begin
    IsRead := False;
    Delete(S2, length(s2), 1);
  end else
    isRead := True;
  H := MakeHash(s2);
  for i := cl.FClassItems.Count -1 downto 0 do
  begin
    px := cl.FClassItems.GetItem(I);
    if (px^.FNameHash = h) and (px^.FName = s2) then
    begin
      p^.ExportDecl := s;
      case px^.b of
  {0: ext1=ptr}
  {1: ext1=pointerinlist}
  {2: ext1=propertyinfo}
  {3: ext1=readfunc; ext2=writefunc}
        4:
          begin
            p^.ProcPtr := ClassCallProcConstructor;
            p^.Ext1 := px^.Ptr;
            p^.Ext2 := Tag;
          end;
        5:
          begin
            p^.ProcPtr := ClassCallProcVirtualConstructor;
            p^.Ext1 := px^.Ptr;
            p^.Ext2 := Tag;
          end;
        6:
          begin
            p^.ProcPtr := ClassCallProcEventPropertyHelper;
            if IsRead then
            begin
              p^.Ext1 := px^.FReadFunc;
              p^.Ext2 := nil;
            end else
            begin
              p^.Ext1 := nil;
              p^.Ext2 := px^.FWriteFunc;
            end;
          end;
        0:
          begin
            p^.ProcPtr := ClassCallProcMethod;
            p^.Ext1 := px^.Ptr;
            p^.Ext2 := nil;
          end;
        1:
          begin
            p^.ProcPtr := ClassCallProcMethod;
            p^.Ext1 := px^.PointerInList;
            p^.ext2 := pointer(1);
          end;
        3:
          begin
            p^.ProcPtr := ClassCallProcPropertyHelper;
            if IsRead then
            begin
              p^.Ext1 := px^.FReadFunc;
              p^.Ext2 := nil;
            end else
            begin
              p^.Ext1 := nil;
              p^.Ext2 := px^.FWriteFunc;
            end;
          end;
        else
         begin
           result := false;
           exit;
         end;
      end;
      Result := true;
      exit;
    end;
  end;
  pp := GetPropInfo(cl.FClass.ClassInfo, s2);
  if pp <> nil then
  begin
     p^.ProcPtr := ClassCallProcProperty;
     p^.Ext1 := pp;
     if IsRead then
       p^.Ext2 := Pointer(1)
     else
       p^.Ext2 := Pointer(0);
     Result := True;
  end else
    result := false;
end;

procedure RegisterClassLibraryRuntime(SE: TIFPSExec; Importer: TIFPSRuntimeClassImporter);
begin
  SE.AddSpecialProcImport('class', SpecImport, Importer);
end;

{ TIFPSRuntimeClass }

constructor TIFPSRuntimeClass.Create(aClass: TClass; const AName: string);
begin
  inherited Create;
  FClass := AClass;
  if AName = '' then
  begin
    FClassName := FastUpperCase(aClass.ClassName);
    FClassNameHash := MakeHash(FClassName);
  end else begin
    FClassName := AName;
    FClassNameHash := MakeHash(AName);
  end;
  FClassItems:= TIfList.Create;
  FEndOfVmt := MaxInt;
end;

destructor TIFPSRuntimeClass.Destroy;
var
  I: Longint;
  P: PClassItem;
begin
  for i:= FClassItems.Count -1 downto 0 do
  begin
    P := FClassItems.GetItem(I);
    Dispose(p);
  end;
  FClassItems.Free;
  inherited Destroy;
end;

procedure TIFPSRuntimeClass.RegisterVirtualAbstractMethod(ClassDef: TClass;
  ProcPtr: Pointer; const Name: string);
var
  P: PClassItem;
begin
  New(P);
  p^.FName := Name;
  p^.FNameHash := MakeHash(Name);
  p^.b := 1;
  p^.PointerInList := FindVirtualMethodPtr(Self, ClassDef, ProcPtr);
  FClassItems.Add(p);
end;

procedure TIFPSRuntimeClass.RegisterConstructor(ProcPtr: Pointer;
  const Name: string);
var
  P: PClassItem;
begin
  New(P);
  p^.FName := Name;
  p^.FNameHash := MakeHash(Name);
  p^.b := 4;
  p^.Ptr := ProcPtr;
  FClassItems.Add(p);
end;

procedure TIFPSRuntimeClass.RegisterMethod(ProcPtr: Pointer; const Name: string);
var
  P: PClassItem;
begin
  New(P);
  p^.FName := Name;
  p^.FNameHash := MakeHash(Name);
  p^.b := 0;
  p^.Ptr := ProcPtr;
  FClassItems.Add(p);
end;


procedure TIFPSRuntimeClass.RegisterPropertyHelper(ReadFunc,
  WriteFunc: Pointer; const Name: string);
var
  P: PClassItem;
begin
  New(P);
  p^.FName := Name;
  p^.FNameHash := MakeHash(Name);
  p^.b := 3;
  p^.FReadFunc := ReadFunc;
  p^.FWriteFunc := WriteFunc;
  FClassItems.Add(p);
end;

procedure TIFPSRuntimeClass.RegisterVirtualConstructor(ProcPtr: Pointer;
  const Name: string);
var
  P: PClassItem;
begin
  New(P);
  p^.FName := Name;
  p^.FNameHash := MakeHash(Name);
  p^.b := 5;
  p^.PointerInList := FindVirtualMethodPtr(Self, FClass, ProcPtr);
  FClassItems.Add(p);
end;

procedure TIFPSRuntimeClass.RegisterVirtualMethod(ProcPtr: Pointer; const Name: string);
var
  P: PClassItem;
begin
  New(P);
  p^.FName := Name;
  p^.FNameHash := MakeHash(Name);
  p^.b := 1;
  p^.PointerInList := FindVirtualMethodPtr(Self, FClass, ProcPtr);
  FClassItems.Add(p);
end;

procedure TIFPSRuntimeClass.RegisterEventPropertyHelper(ReadFunc,
  WriteFunc: Pointer; const Name: string);
var
  P: PClassItem;
begin
  New(P);
  p^.FName := Name;
  p^.FNameHash := MakeHash(Name);
  p^.b := 6;
  p^.FReadFunc := ReadFunc;
  p^.FWriteFunc := WriteFunc;
  FClassItems.Add(p);
end;

{ TIFPSRuntimeClassImporter }

function TIFPSRuntimeClassImporter.Add(aClass: TClass): TIFPSRuntimeClass;
begin
  Result := TIFPSRuntimeClass.Create(aClass, '');
  FClasses.Add(Result);
end;

function TIFPSRuntimeClassImporter.Add2(aClass: TClass;
  const Name: string): TIFPSRuntimeClass;
begin
  Result := TIFPSRuntimeClass.Create(aClass, Name);
  FClasses.Add(Result);
end;

procedure TIFPSRuntimeClassImporter.Clear;
var
  I: Longint;
begin
  for i := 0 to FClasses.Count -1 do
  begin
    TIFPSRuntimeClass(FClasses.GetItem(I)).Free;
  end;
  FClasses.Clear;
end;

constructor TIFPSRuntimeClassImporter.Create;
begin
  inherited Create;
  FClasses := TIfList.Create;
end;

destructor TIFPSRuntimeClassImporter.Destroy;
begin
  Clear;
  FClasses.Free;
  inherited Destroy;
end;

procedure SetVariantToClass(V: PIFVariant; Cl: TObject);
begin
  if v <> nil then
  begin
    v^.tResourceP1 := cl;
    if cl <> nil then
      v^.tResourceFreeProc := DummyResourceFree
    else
      v^.TResourceFreeProc := nil;
  end;
end;

{













}
function BGRFW(var s: string): string;
var
  l: Longint;
begin
  l := Length(s);
  while l >0 do
  begin
    if s[l] = ' ' then
    begin
      Result := copy(s, l + 1, Length(s) - l);
      Delete(s, l, Length(s) - l + 1);
      exit;
    end;
    Dec(l);
  end;
  Result := s;
  s := '';
end;



function MyAllMethodsHandler2(Self: PScriptMethodInfo; const Stack: PPointer; _EDX, _ECX: Pointer): Integer; forward;

procedure MyAllMethodsHandler;
//  On entry:
//     EAX = Self pointer
//     EDX, ECX = param1 and param2
//     STACK = param3... paramcount
asm
  push ecx
  push edx
  mov edx, esp
  add edx, 12
  pop ecx
  call MyAllMethodsHandler2
  mov edx, [esp]
  add esp, eax
  mov [esp], edx
end;

function MyAllMethodsHandler2(Self: PScriptMethodInfo; const Stack: PPointer; _EDX, _ECX: Pointer): Integer;
var
  Decl: string;
  I, C, regno: Integer;
  Params: TIfList;
//  VarParams: TIfList;
  Tmp: PIFVariant;
  cpt: PIFTypeRec;
  fmod: char;
  s,e: string;
  FStack: pointer;
begin
  Decl := PIFProcRec(Self^.Se.FProcs.GetItem(Self^.ProcNo))^.ExportDecl;

  FStack := Stack;
  Params := TIfList.Create;
//  VarParams := TIfList.Create;
  s := decl;
  grfw(s);
  while s <> '' do
  begin
    Params.Add(nil);
    grfw(s);
  end;
  c := Params.Count;
  regno := 0;
  I := C -1 ;
  Result := 0;
  s := decl;
  grfw(s);
  while I >= 0 do
  begin
    e := grfw(s);
    fmod := e[1];
    delete(e, 1, 1);
    cpt := Self.Se.GetTypeNo(StrToInt(e));
    if fmod = '!' then
    begin
      case cpt.BaseType of
      
        btResourcePointer:
          begin
            Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
            if regno = 0 then
            begin
              Inc(regno);
              Tmp^.tResourceP1:= Pointer(Pointer(_EDX)^);
              tmp^.tResourceFreeProc := DummyResourceFree;

            end
            else if regno = 1 then
            begin
              Inc(regno);
              Tmp^.tResourceP1:= Pointer(Pointer(_ECX)^);
              tmp^.tResourceFreeProc := DummyResourceFree;
            end;
//            VarParams.Add(tmp);
            Params.SetItem(I, Tmp);
          end;

        btString, btPChar:
          begin
            Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
            if regno = 0 then
            begin
              Inc(regno);
              string(Tmp^.tString):= string(Pointer(_EDX)^);
            end
            else if regno = 1 then
            begin
              Inc(regno);
              string(Tmp^.tstring):= string(Pointer(_ECX)^);
            end;
//            VarParams.Add(tmp);
            Params.SetItem(I,  Tmp);
          end;
        btDouble{$IFNDEF NOINT64}, btS64{$ENDIF}:
          begin
            Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
            if regno = 0 then
            begin
              Inc(regno);
              Move(Pointer(_EDX)^, tmp^.tDouble, 8);
            end
            else if regno = 1 then
            begin
              Inc(regno);
              Move(Pointer(_ECX)^, tmp^.tDouble, 8);
            end;
//            VarParams.Add(tmp);
            Params.SetItem(I,  Tmp);
          end;
        btExtended:
          begin
            Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
            if regno = 0 then
            begin
              Inc(regno);
              Move(Pointer(_EDX)^, tmp^.textended, 10);
            end
            else if regno = 1 then
            begin
              Inc(regno);
              Move(Pointer(_ECX)^, tmp^.textended, 10);
            end;
//            VarParams.Add(tmp);
            Params.SetItem(I,  Tmp);
          end;
        btSingle,
          btU8,
          btS8,
          Btu16,
          bts16,
          btu32,
          bts32:
          begin
            Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
            if regno = 0 then
            begin
              Inc(regno);
              Tmp^.ts32 := Longint(Pointer(_EDX)^);
            end
            else if regno = 1 then
            begin
              Inc(regno);
              Tmp^.ts32:= Longint(Pointer(_ECX)^);
            end;
//            VarParams.Add(tmp);
            Params.SetItem(I,  Tmp);
          end;
      else
        begin
          FreePIFVariantList({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF} Params);
//          FreePIFVariantList({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF} VarParams);
        end;
      end;
    end
    else
    begin
      case cpt.BaseType of
        btResourcePointer:
          begin
            Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);;
            if regno = 0 then
            begin
              Inc(regno);
              Tmp^.tResourceP1 := _EDX;
              tmp^.tResourceFreeProc := DummyResourceFree;
            end
            else if regno = 1 then
            begin
              Inc(regno);
              Tmp^.tResourceP1 := _ECX;
              tmp^.tResourceFreeProc := DummyResourceFree;
            end;
            Params.SetItem(I, Tmp);
          end;

        btString:
          begin
            Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
            if regno = 0 then
            begin
              Inc(regno);
              string(Tmp^.tstring) := string(_EDX);
            end
            else if regno = 1 then
            begin
              Inc(regno);
              string(Tmp^.tstring) := string(_ECX);
            end;
            Params.SetItem(I,  Tmp);
          end;
          btU8,
          btS8,
          Btu16,
          bts16,
          btu32,
          bts32:
          begin
            Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
            if regno = 0 then
            begin
              Inc(regno);
              Tmp^.ts32 := Longint(_EDX);
            end
            else if regno = 1 then
            begin
              Inc(regno);
              Tmp^.ts32 := Longint(_ECX);
            end;
            Params.SetItem(I,  Tmp);
          end;
      end;
    end;
    dec(i);
    if regno = 2 then
      break;
  end;
  s := decl;
  grfw(s);
  for I := 0 to C-1 do
  begin
    e := BGRFW(s);
    if Params.GetItem(I) = nil then
    begin
      fmod := e[1];
      Delete(e, 1, 1);
      cpt := Self.Se.GetTypeNo(StrToInt(e));
      if fmod = '!' then
      begin
        case cpt.BaseType of

          btResourcePointer:
            begin
              Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
              Tmp^.tResourceP1 := Pointer(Pointer(FStack^)^);
              tmp^.tResourceFreeProc := DummyResourceFree;
              FStack := Pointer(Longint(FStack) + 4);
              Inc(Result, 4);
//              VarParams.Add(Tmp);
              Params.SetItem(I, Tmp);
            end;
          btString:
            begin
              Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
              String(Tmp^.tstring) := string(FStack^);
              FStack := Pointer(Pointer(Longint(FStack) + 4)^);
              Inc(Result, 4);
//              VarParams.Add(Tmp);
              Params.SetItem(I, Tmp);
            end;
          btDouble{$IFNDEF NOINT64}, bts64{$ENDIF}:
            begin
              Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
              Move(Pointer(FStack^)^, Tmp^.tDouble, 8);
              FStack := Pointer(Longint(FStack) + 4);
              Inc(Result, 4);
//              VarParams.Add(Tmp);
              Params.SetItem(I, Tmp);
            end;
          btExtended:
            begin
              Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
              Move(Pointer(FStack^)^, Tmp^.tExtended, 10);
              FStack := Pointer(Longint(FStack) + 4);
              Inc(Result, 4);
//              VarParams.Add(Tmp);
              Params.SetItem(I, Tmp);
            end;
          btSingle,
          btS8,
          btu8,
          bts16,
          btu16,
          bts32,
          btu32:
            begin
              Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
              Move(Pointer(FStack^)^, Tmp^.ts32, 4);
              FStack := Pointer(Longint(FStack) + 4);
              Inc(Result, 4);
//              VarParams.Add(Tmp);
              Params.SetItem(I, Tmp);
            end;
        else
          begin
            FreePIFVariantList({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}Params);
//            VarParams.Free;
            exit;
          end;
        end;
      end
      else
      begin
        case cpt.BaseType of
          btResourcePointer:
            begin
              Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
              tmp^.tResourceP1 := Pointer(FStack^);
              tmp^.tResourceFreeProc := DummyResourceFree;
              FStack := Pointer(Longint(FStack) + 4);
              Inc(Result, 4);
              Params.SetItem(I, tmp);
            end;
          btString:
            begin
              Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
              string(Tmp^.tstring):= string(FStack^);
              FStack := Pointer(Longint(FStack) + 4);
              Inc(Result, 4);
              Params.SetItem(I, tmp);
            end;
          btDouble{$IFNDEF NOINT64}, bts64{$ENDIF}:
            begin
              Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
              Move(FStack^, Tmp^.tDouble, 8);
              FStack := Pointer(Longint(FStack) + 8);
              Inc(Result, 8);
              Params.SetItem(I, tmp);
            end;
          btExtended:
            begin
              Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
              Move(FStack^, Tmp^.tExtended, 10);
              FStack := Pointer(Longint(FStack) + 12);
              Inc(Result, 12);
              Params.SetItem(I, tmp);
            end;
          btSingle,
          bts8,
          btu8,
          bts16,
          btu16,
          bts32,
          btu32:
            begin
              Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
              Tmp^.ts32 := Longint(FStack^);
              Params.SetItem(I, tmp);
              FStack := Pointer(Longint(FStack) + 4);
              Inc(Result, 4);
            end;
        else
          begin
            FreePIFVariantList({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}Params);
//            VarParams.Free;
            exit;
          end;
        end;
      end;
    end;
  end;
  s := decl;
  e := grfw(s);

(*  if e <> '-1' then
  begin
    cpt := Self.Se.GetTypeNo(StrToInt(e));
    Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
    Params.Add(tmp);
  end;
*)
  Self.Se.RunProc(Params, Self.ProcNo);
(*
  if e <> '-1' then
  begin
    cpt := Self.Se.GetTypeNo(StrToInt(e));
    Tmp := CreateVariant({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}cpt);
    Params.Add(tmp);
  end;
*)
  FStack := Stack;
  regno := 0;
  I := C-1;

  while I >= 0 do
  begin
    e := grfw(s);
    fmod := e[1];
    delete(e, 1, 1);
    cpt := Self.Se.GetTypeNo(StrToInt(e));
    if fmod = '!' then
    begin
      case cpt.BaseType of
        btResourcePointer:
          begin
            tmp := Params.GetItem(I);
            if regno = 0 then
            begin
              Inc(regno);
              Pointer(Pointer(_EDX)^) := Tmp^.tResourceP1;
              DisposeVariant({$IFNDEF NOSMARTMM}Self.Se.mm, {$ENDIF}tmp);
              Params.SetItem(I, nil);
            end
            else if regno = 1 then
            begin
              Inc(regno);
              Pointer(Pointer(_ECX)^) := Tmp^.tResourceP1;
              DisposeVariant({$IFNDEF NOSMARTMM}Self.Se.mm, {$ENDIF}tmp);
              Params.SetItem(I, nil);
            end;
          end;
        btString:
          begin
            tmp := Params.GetItem(I);
            if regno = 0 then
            begin
              Inc(regno);
              string(Pointer(_EDX)^) := string(Tmp^.tstring);
              DisposeVariant({$IFNDEF NOSMARTMM}Self.Se.mm, {$ENDIF}tmp);
              Params.SetItem(I, nil);
            end
            else if regno = 1 then
            begin
              Inc(regno);
              string(Pointer(_ECX)^) := string(Tmp^.tstring);
              DisposeVariant({$IFNDEF NOSMARTMM}Self.Se.mm, {$ENDIF}tmp);
              Params.SetItem(I, nil);
            end;
          end;
        btDouble{$IFNDEF NOINT64}, bts64{$ENDIF}:
          begin
            tmp := Params.GetItem(I);
            if regno = 0 then
            begin
              Inc(regno);
              Move(tmp^.tDouble, Pointer(_EDX)^, 8);
              DisposeVariant({$IFNDEF NOSMARTMM}Self.Se.mm, {$ENDIF}tmp);
              Params.SetItem(I, nil);
            end
            else if regno = 1 then
            begin
              Inc(regno);
              Move(tmp^.tDouble, Pointer(_ECX)^, 8);
              DisposeVariant({$IFNDEF NOSMARTMM}Self.Se.mm, {$ENDIF}tmp);
              Params.SetItem(I, nil);
            end;
          end;
        btExtended:
          begin
            tmp := Params.GetItem(I);
            if regno = 0 then
            begin
              Inc(regno);
              Move(tmp^.tExtended, Pointer(_EDX)^, 10);
              DisposeVariant({$IFNDEF NOSMARTMM}Self.Se.mm, {$ENDIF}tmp);
              Params.SetItem(I, nil);
            end
            else if regno = 1 then
            begin
              Inc(regno);
              Move(tmp^.tExtended, Pointer(_ECX)^, 10);
              DisposeVariant({$IFNDEF NOSMARTMM}Self.Se.mm, {$ENDIF}tmp);
              Params.SetItem(I, nil);
            end;
          end;
          btSingle,
          bts8,
          btu8,
          bts16,
          btu16,
          bts32,
          btu32:
          begin
            tmp := Params.GetItem(I);
            if regno = 0 then
            begin
              Inc(regno);
              Longint(Pointer(_EDX)^) := Tmp^.ts32;
              DisposeVariant({$IFNDEF NOSMARTMM}Self.Se.mm, {$ENDIF}tmp);
              Params.SetItem(I, nil);
            end
            else if regno = 1 then
            begin
              Inc(regno);
              Longint(Pointer(_ECX)^) := Tmp^.ts32;
              DisposeVariant({$IFNDEF NOSMARTMM}Self.Se.mm, {$ENDIF}tmp);
              Params.SetItem(I, nil);
            end;
          end;
      else
        begin
          FreePIFVariantList({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}Params);
//          VarParams.Free;
          exit;
        end;
      end;
    end else begin
      case cpt.BaseType of
        btResourcePointer,
        btString,
        bts8,
        btu8,
        bts16,
        btu16,
        bts32,
        btu32:
          begin
            Inc(regno);
            DisposeVariant({$IFNDEF NOSMARTMM}Self.Se.mm, {$ENDIF}Params.GetItem(I));
            Params.SetItem(I, nil);
          end;
      end;
    end;
    Dec(i);
  end;
  s := Decl;
  grfw(s);

  for I := 0 to C - 1 do
  begin
    e := BGRFW(s);
    fmod := e[1];
    delete(e, 1, 1);
    cpt := Self.Se.GetTypeNo(StrToInt(e));
    tmp := Params.GetItem(i);
    if tmp <> nil then
    begin
      if (fmod = '!') then
      begin
        case cpt.BaseType of
         btResourcePointer:
            begin
              Pointer(Pointer(FStack^)^) := tmp^.tResourceP1;
              FStack := Pointer(Longint(FStack) + 4);
            end;
          btString:
            begin
              string(FStack^) := string(Tmp^.tstring);
              FStack := Pointer(Pointer(Longint(FStack) + 4)^);
            end;
          btDouble{$IFNDEF NOINT64}, bts64{$ENDIF}:
            begin
              Move(Tmp^.tDouble, Pointer(FStack^)^, 8);
              FStack := Pointer(Longint(FStack) + 4);
            end;
          btExtended:
            begin
              Move(Tmp^.tExtended, Pointer(FStack^)^, 10);
              FStack := Pointer(Longint(FStack) + 4);
            end;
            btSingle,
            bts8,
            btu8,
            bts16,
            btu16,
            bts32,
            btu32:
            begin
              Longint(Pointer(FStack^)^) := Tmp^.ts32;
              FStack := Pointer(Longint(FStack) + 4);
            end;
        else
          begin
            FreePIFVariantList({$IFNDEF NOSMARTMM}Self.Se.MM, {$ENDIF}Params);
            exit;
          end;
        end;

      end;
      DisposeVariant({$IFNDEF NOSMARTMM}Self.Se.mm, {$ENDIF}tmp);
    end;
  end;
  Params.Free;
  if Self.Se.ExEx <> erNoError then
  begin
    raise EIFPS3Exception.Create('['+IntToStr(Self.Se.ExceptionProcNo) +':'+IntToStr(Self.Se.ExceptionPos) +'] ' +
      TIFErrorToString(Self.SE.ExceptionCode, Self.Se.ExceptionString));
  end;
end;

function TIFPSRuntimeClassImporter.FindClass(const Name: string): TIFPSRuntimeClass;
var
  h, i: Longint;
  p: TIFPSRuntimeClass;
begin
  h := MakeHash(Name);
  for i := FClasses.Count -1 downto 0 do
  begin
    p := FClasses.GetItem(i);
    if (p.FClassNameHash = h) and (p.FClassName = Name) then
    begin
      Result := P;
      exit;
    end;
  end;
  Result := nil;
end;
initialization
  DelphiRPFunc := ClassRuntimeGetRPFuncs;
end.

