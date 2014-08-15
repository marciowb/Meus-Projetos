unit ifpiclass;
{
  Innerfuse Pascal Script III
  Copyright (C) 2000-2002 by Carlo Kok (ck@carlo-kok.com)
}
{$I ifps3_def.inc}
interface
uses
  ifpscomp, ifps3utl, ifps3common;

type
  TIFPSCompileTimeClass = class;
  {Class importer at compile time}
  TIFPSCompileTimeClassesImporter = class
  private
    FClasses: TIFList;
    FSE: TIFPSPascalCompiler;
  public
    {Script Engine}
    property SE: TIFPSPascalCompiler read FSe;
    {create}
    constructor Create(AOwner: TIFPSPascalCompiler; AutoFree: Boolean);
	{destroy}
    destructor Destroy; override;
    {Add a class}
    function Add(InheritsFrom: TIFPSCompileTimeClass; FClass: TClass): TIFPSCompileTimeClass;
    function Add2(InheritsFrom: TIFPSCompileTimeClass; FClassName: string): TIFPSCompileTimeClass;
	{Find a class}
    function FindClass(const aClassName: string):TIFPSCompileTimeClass;
    {Clear the list of classes}
    procedure Clear;
  end;
  {Property type: iptRW = Read/Write; iptR= readonly; iptW= writeonly}
  TIFPSPropType = (iptRW, iptR, iptW);
  {Compiletime class}
  TIFPSCompileTimeClass = class
  private
    FInheritsFrom: TIFPSCompileTimeClass;
    FClass: TClass;
    FClassName: string;
    FClassNameHash: Longint;
    FClassItems: TIFList;

    FOwner: TIFPSCompileTimeClassesImporter;
  public
    property ClassInheritsFrom: TIFPSCompileTimeClass read FInheritsFrom write FInheritsFrom; 
    {Register a method/constructor}
    function RegisterMethod(const Decl: string): Boolean;
	{Register a property}
    procedure RegisterProperty(const PropertyName, PropertyType: string; PropAC: TIFPSPropType);
    {Register all published properties}
    procedure RegisterPublishedProperties;
    {Register a published property}
    function RegisterPublishedProperty(const Name: string): Boolean;
    {create2}
    constructor Create2(ClassName: string; aOwner: TIFPSCompileTimeClassesImporter);
    {create}
    constructor Create(FClass: TClass; aOwner: TIFPSCompileTimeClassesImporter);
	{destroy}
    destructor Destroy; override;
  end;

function AddImportedClassVariable(Sender: TIFPSPascalCompiler; const VarName, VarType: string): Boolean;

implementation
uses
  TypInfo, ifpidelphi;

type
   TComp = class (TIFPSPascalCompiler) end;

function AddImportedClassVariable(Sender: TIFPSPascalCompiler; const VarName, VarType: string): Boolean;
var
  P: PIFPSVar;
begin
  P := Sender.AddVariableN(VarName, VarType);
  if p = nil then
  begin
    Result := False;
    Exit;
  end;
  SetVarExportName(P, FastUppercase(VarName));
  p^.Used := True;
  Result := True;
end;


{'class:'+CLASSNAME+'|'+FUNCNAME+'|'+chr(CallingConv)+chr(hasresult)+params

For property write functions there is an '@' after the funcname.
}
type
  PClassItem = ^TClassItem;
  TClassItem = record
    Owner: TIFPSCompileTimeClass;
    Name: string;
    NameHash: Longint;
    FType: Byte; { 0 = method; 1 = property; 2 = constructor/class method }
    ProcDecl: string;
    PropAC: TIFPSPropType;
    case byte of
      0: (MethodProcNo: Cardinal);
      1: (PropReadProcNo, PropWriteProcNo: Cardinal);
  end;
  TIFPSDelphiClass = class(TIFPSExternalClass)
  private
    Ce: TIFPSCompileTimeClass;
    CompareProcNo, CastProcNo, NilProcNo: Cardinal;
  public
    function SelfType: Cardinal; override;

    constructor Create(CE: TIFPSCompileTimeClass);
    destructor Destroy; override;

    function Property_Find(const Name: string; var Index: Cardinal): Boolean; override;
    function Property_Get(Index: Cardinal; var ProcNo: Cardinal): Boolean; override;
    function Property_Set(Index: Cardinal; var ProcNo: Cardinal): Boolean; override;
    function Property_GetHeader(Index: Cardinal; var s: string): Boolean; override;

    function Func_Find(const Name: string; var Index: Cardinal): Boolean; override;
    function Func_Call(Index: Cardinal; var ProcNo: Cardinal): Boolean; override;

    function ClassFunc_Find(const Name: string; var Index: Cardinal): Boolean; override;
    function ClassFunc_Call(Index: Cardinal; var ProcNo: Cardinal): Boolean; override;

    function IsCompatibleWith(Cl: TIFPSExternalClass): Boolean; override;
    function SetNil(TypeNo: Cardinal; var ProcNo: Cardinal): Boolean; override;
    function CastToType(TypeNo, IntoType: Cardinal; var ProcNo: Cardinal): Boolean; override;
    function CompareClass(OtherTypeNo: Cardinal; var ProcNo: Cardinal): Boolean; override;
  end;

{ TIFPSCompileTimeClass }

constructor TIFPSCompileTimeClass.Create(FClass: TClass; aOwner: TIFPSCompileTimeClassesImporter);
begin
  inherited Create;
  FClassName := FastUppercase(FClass.ClassName);
  FClassNameHash := MakeHash(FClassName);
  FClassItems := TIfList.Create;
  Self.FClass := FClass;
  FOwner := aOwner;
end;

constructor TIFPSCompileTimeClass.Create2(ClassName: string;
  aOwner: TIFPSCompileTimeClassesImporter);
begin
  inherited Create;
  FClassName := Classname;
  FClassNameHash := MakeHash(FClassName);
  FClassItems := TIfList.Create;
  FOwner := aOwner;
end;

destructor TIFPSCompileTimeClass.Destroy;
var
  I: Longint;
  P: PClassItem;
begin
  for i := FClassItems.Count -1 downto 0 do
  begin
    p := FClassItems.GetItem(I);
    Dispose(P);
  end;
  FClassItems.Free;
  inherited Destroy;
end;


function TIFPSCompileTimeClass.RegisterMethod(const Decl: string): Boolean;
var
  DName,
  DDecl: string;
  FT: TFuncType;
  p: PClassItem;
begin
  if not ParseMethod(FOwner.FSE, FClassName, Decl, DName, DDecl, FT) then
  begin
    Result := False;
    exit;
  end;
  New(p);
  p^.Owner := Self;
  p^.Name := DName;
  p^.NameHash := MakeHash(DName);
  if FT = ftConstructor then
    p^.FType := 2
  else
    p^.FType := 0;
  p^.ProcDecl := DDecl;
  p^.MethodProcNo := Cardinal(-1);
  FClassItems.Add(p);
  Result := True;
end;

procedure TIFPSCompileTimeClass.RegisterProperty(const PropertyName,
  PropertyType: string; PropAC: TIFPSPropType);
var
  FType: Cardinal;
  p: PClassItem;
  PT, s: string;
begin
  pt := PropertyType;
  repeat
    FType := FOwner.FSE.FindType(FastUpperCase(grfw(pt)));
    if FType = cardinal(-1) then Exit;
    if s = '' then s := inttostr(ftype) else s := s + ' '+ inttostr(ftype);
  until pt = '';
  New(p);
  p^.Owner := Self;
  p^.Name := FastUppercase(PropertyName);
  p^.NameHash := MakeHash(p^.Name);
  p^.FType := 1;
  p^.PropAC := PropAC;
  p^.ProcDecl := s;
  p^.PropReadProcNo := Cardinal(-1);
  p^.PropWriteProcNo := Cardinal(-1);
  FClassItems.Add(p);
end;


procedure TIFPSCompileTimeClass.RegisterPublishedProperties;
var
  p: PPropList;
  i, Count: Longint;
  a: TIFPSPropType;
begin
  if (Fclass = nil) or (Fclass.ClassInfo = nil) then exit;
  Count := GetTypeData(fclass.ClassInfo)^.PropCount;
  GetMem(p, Count * SizeOf(Pointer));
  GetPropInfos(fclass.ClassInfo, p);
  for i := Count -1 downto 0 do
  begin
    if p^[i]^.PropType^.Kind in [tkLString, tkInteger, tkChar, tkEnumeration, tkFloat, tkString, tkSet, tkClass, tkMethod] then
    begin
      if (p^[i]^.GetProc <> nil) then
      begin
        if p^[i]^.SetProc = nil then
          a := iptr
        else
          a := iptrw;
      end else
      begin
        a := iptW;
        if p^[i]^.SetProc = nil then continue;
      end;
      RegisterProperty(p^[i]^.Name, p^[i]^.PropType^.Name, a);
    end;
  end;
  FreeMem(p);
end;

function TIFPSCompileTimeClass.RegisterPublishedProperty(const Name: string): Boolean;
var
  p: PPropInfo;
  a: TIFPSPropType;
begin
  if (Fclass = nil) or (Fclass.ClassInfo = nil) then begin Result := False; exit; end;
  p := GetPropInfo(fclass.ClassInfo, Name);
  if p = nil then begin Result := False; exit; end;
  if (p^.GetProc <> nil) then
  begin
    if p^.SetProc = nil then
      a := iptr
    else
      a := iptrw;
  end else
  begin
    a := iptW;
    if p^.SetProc = nil then begin result := False; exit; end;
  end;
  RegisterProperty(p^.Name, p^.PropType^.Name, a);
  Result := True;
end;

{ TIFPSCompileTimeClassesImporter }
function TIFPSCompileTimeClassesImporter.Add(InheritsFrom: TIFPSCompileTimeClass; FClass: TClass): TIFPSCompileTimeClass;
var
  f: PIFPSType;
begin
  Result := TIFPSCompileTimeClass.Create(fClass, Self);
  Result.FInheritsFrom := InheritsFrom;
  FClasses.Add(Result);
  f := FSE.AddType(Result.FClassName, btClass);
  TIFPSClassType(f).ClassHelper := TIFPSDelphiClass.Create(Result);
  f.ExportName := True;
end;

function TIFPSCompileTimeClassesImporter.Add2(
  InheritsFrom: TIFPSCompileTimeClass;
  FClassName: string): TIFPSCompileTimeClass;
var
  f: PIFPSType;
begin
  Result := TIFPSCompileTimeClass.Create2(fClassname, Self);
  Result.FInheritsFrom := InheritsFrom;
  FClasses.Add(Result);
  f := FSE.AddType(Result.FClassName, btClass);
  TIFPSClassType(f).ClassHelper := TIFPSDelphiClass.Create(Result);
  f.ExportName := True;
end;

procedure TIFPSCompileTimeClassesImporter.Clear;
var
  I: Longint;
begin
  for i := FClasses.Count -1 downto 0 do
  begin
    TIFPSCompileTimeClass(FClasses.GetItem(I)).Free;
  end;
  FClasses.Clear;
end;

constructor TIFPSCompileTimeClassesImporter.Create(AOwner: TIFPSPascalCompiler; AutoFree: Boolean);
begin
  inherited Create;
  FSE := AOwner;
  FClasses := TIfList.Create;
  if AutoFree then
    FSE.AddToFreeList(Self);
end;

destructor TIFPSCompileTimeClassesImporter.Destroy;
begin
  Clear;
  FClasses.Free;
  inherited Destroy;
end;

function TIFPSCompileTimeClassesImporter.FindClass(const aClassName: string):TIFPSCompileTimeClass;
var
  i: Longint;
  Cl: string;
  H: Longint;
  x: TIFPSCompileTimeClass;
begin
  cl := FastUpperCase(aClassName);
  H := MakeHash(Cl);
  for i :=0 to FClasses.Count -1 do
  begin
    x := FClasses.GetItem(I);
    if (X.FClassNameHash = H) and (X.FClassName = Cl) then
    begin
      Result := X;
      Exit;
    end;
  end;
  Result := nil;
end;



const
  IFPSClassType = '!IFPSClass';
  ProcHDR = 'procedure a;';
type
  TIFPSPascalCompiler2 = class (TIFPSPascalCompiler) end;

{ TIFPSDelphiClass }

constructor TIFPSDelphiClass.Create(CE: TIFPSCompileTimeClass);
begin
  inherited Create(CE.FOwner.FSE);
  NilProcNo := Cardinal(-1);
  CastProcNo := Cardinal(-1);
  CompareProcNo := Cardinal(-1);

  Self.Ce := CE;
end;

function TIFPSDelphiClass.Func_Call(Index: Cardinal; var ProcNo: Cardinal): Boolean;
var
  C: PClassItem;
  P: TIFPSExternalProcedure;
  s, w, n: string;

begin
  C := Pointer(Index);
  if c^.MethodProcNo = Cardinal(-1) then
  begin
    ProcNo := TIFPSPascalCompiler2(Se).AddUsedFunction2(P);
    P.RegProc := SE.AddFunction(ProcHDR);
    P.RegProc.Name := '';
    TIFPSPascalCompiler2(Se).ReplaceTypes(C^.ProcDecl);
    P.RegProc.Decl := c^.ProcDecl;
    s := 'class:' + C.Owner.FClassName + '|' + C.Name + '|'+ chr(0);
    w := C^.ProcDecl;
    if GRFW(w) = '-1' then
      s := s + #0
    else
      s := s + #1;
    while W <> '' do
    begin
      n := grfw(w);
      grfw(w);
      if (n <> '') and (n[1] = '!') then
        s := s + #1
      else
        s := s + #0;
    end;
    P.RegProc.ImportDecl := s;
    C^.MethodProcNo := ProcNo;
  end else begin
     ProcNo := c^.MethodProcNo;
  end;
  Result := True;
end;

function TIFPSDelphiClass.Func_Find(const Name: string; var Index: Cardinal): Boolean;
var
  H: Longint;
  I: Longint;
  CurrClass: TIFPSCompileTimeClass;
  C: PClassItem;
begin
  H := MakeHash(Name);
  CurrClass := Ce;
  while CurrClass <> nil do
  begin
    for i := CurrClass.FClassItems.Count -1 downto 0 do
    begin
      C := CurrClass.FClassItems.GetItem(I);
      if (c^.Ftype = 0) and (C^.NameHash = H) and (C^.Name = Name) then
      begin
        Index := Cardinal(C);
        Result := True;
        exit;
      end;
    end;
    CurrClass := CurrClass.FInheritsFrom;
  end;
  Result := False;
end;

function TIFPSDelphiClass.Property_Find(const Name: string;
  var Index: Cardinal): Boolean;
var
  H: Longint;
  I: Longint;
  CurrClass: TIFPSCompileTimeClass;
  C: PClassItem;
begin
  H := MakeHash(Name);
  CurrClass := Ce;
  while CurrClass <> nil do
  begin
    for i := CurrClass.FClassItems.Count -1 downto 0 do
    begin
      C := CurrClass.FClassItems.GetItem(I);
      if (c^.Ftype = 1) and (C^.NameHash = H) and (C^.Name = Name) then
      begin
        Index := Cardinal(C);
        Result := True;
        exit;
      end;
    end;
    CurrClass := CurrClass.FInheritsFrom;
  end;
  Result := False;
end;

function TIFPSDelphiClass.Property_Get(Index: Cardinal;
  var ProcNo: Cardinal): Boolean;
var
  C: PClassItem;
  P: TIFPSExternalProcedure;
  w,s: string;
  i: Longint;

begin
  C := Pointer(Index);
  if c^.PropAC = iptW then
  begin
    Result := False;
    exit;
  end;
  if c^.PropReadProcNo = Cardinal(-1) then
  begin
    ProcNo := TIFPSPascalCompiler2(Se).AddUsedFunction2(P);
    P.RegProc := SE.AddFunction(ProcHDR);
    P.RegProc.Name := '';
    P.RegProc.Decl := IntToStr(TIFPSPascalCompiler2(Se).AT2UT(StrToIntDef(Fw(C^.ProcDecl), -1)));
    s := 'class:' + C.Owner.FClassName + '|' + C.Name + '|';
    w := C^.ProcDecl;
    i := 0;
    repeat
      grfw(w);
      inc(i);
    until w = '';
    s := s + #0#0#0#0;
    Longint((@(s[length(s)-3]))^) := i;
    P.RegProc.ImportDecl := s;
    C^.PropReadProcNo := ProcNo;
  end else begin
     ProcNo := c^.PropReadProcNo;
  end;
  Result := True;
end;

function TIFPSDelphiClass.Property_Set(Index: Cardinal;
  var ProcNo: Cardinal): Boolean;
var
  C: PClassItem;
  P: TIFPSExternalProcedure;
  s, w: string;
  i: Longint;

begin
  C := Pointer(Index);
  if c^.PropAC = iptR then
  begin
    Result := False;
    exit;
  end;
  if c^.PropWriteProcNo = Cardinal(-1) then
  begin
    ProcNo := TIFPSPascalCompiler2(Se).AddUsedFunction2(P);
    P.RegProc := SE.AddFunction(ProcHDR);
    P.RegProc.Name := '';
    P.RegProc.Decl := '-1';
    s := 'class:' + C.Owner.FClassName + '|' + C.Name + '@|';
    w := C^.ProcDecl;
    i := 0;
    repeat
      grfw(w);
      inc(i);
    until w = '';
    s := s + #0#0#0#0;
    Longint((@(s[length(s)-3]))^) := i;
    P.RegProc.ImportDecl := s;
    C^.PropWriteProcNo := ProcNo;
  end else begin
     ProcNo := c^.PropWriteProcNo;
  end;
  Result := True;
end;

function TIFPSDelphiClass.Property_GetHeader(Index: Cardinal;
  var s: string): Boolean;
var
  c: PClassItem;
begin
  C := Pointer(Index);
  s := c^.ProcDecl;
  Result := True;
end;

function TIFPSDelphiClass.SelfType: Cardinal;
begin
  Result := SE.FindType(IFPSClassType);
  if Result = Cardinal(-1) then
  begin
    SE.AddType(IFPSClassType, btResourcePointer);
    Result := SE.FindType(IFPSClassType);
  end;
end;

function TIFPSDelphiClass.ClassFunc_Call(Index: Cardinal;
  var ProcNo: Cardinal): Boolean;
var
  C: PClassItem;
  P: TIFPSExternalProcedure;
  s, w, n: string;

begin
  C := Pointer(Index);
  if c^.MethodProcNo = Cardinal(-1) then
  begin
    ProcNo := TIFPSPascalCompiler2(Se).AddUsedFunction2(P);
    P.RegProc := SE.AddFunction(ProcHDR);
    P.RegProc.Name := '';
    TIFPSPascalCompiler2(Se).ReplaceTypes(C^.ProcDecl);
    P.RegProc.Decl := C^.ProcDecl;
    s := 'class:' + C.Owner.FClassName + '|' + C.Name + '|'+ chr(0);
    w := C^.ProcDecl;
    if GRFW(w) = '-1' then
      s := s + #0
    else
      s := s + #1;
    while W <> '' do
    begin
      n := grfw(w);
      grfw(w);
      if (n <> '') and (n[1] = '!') then
        s := s + #1
      else
        s := s + #0;
    end;
    P.RegProc.ImportDecl := s;
    C^.MethodProcNo := ProcNo;
  end else begin
     ProcNo := c^.MethodProcNo;
  end;
  Result := True;
end;

function TIFPSDelphiClass.ClassFunc_Find(const Name: string;
  var Index: Cardinal): Boolean;
var
  H: Longint;
  I: Longint;
  CurrClass: TIFPSCompileTimeClass;
  C: PClassItem;
begin
  H := MakeHash(Name);
  CurrClass := Ce;
  while CurrClass <> nil do
  begin
    for i := CurrClass.FClassItems.Count -1 downto 0 do
    begin
      C := CurrClass.FClassItems.GetItem(I);
      if (c^.Ftype = 2) and (C^.NameHash = H) and (C^.Name = Name) then
      begin
        Index := Cardinal(C);
        Result := True;
        exit;
      end;
    end;
    CurrClass := CurrClass.FInheritsFrom;
  end;
  Result := False;
end;

function TIFPSDelphiClass.IsCompatibleWith(
  Cl: TIFPSExternalClass): Boolean;
var
  Temp: TIFPSCompileTimeClass;
begin
  if not (cl is TIFPSDelphiClass) then
  begin
    Result := False;
    exit;
  end;
  temp := TIFPSDelphiClass(cl).Ce;
  while Temp <> nil do
  begin
    if Temp = Ce then
    begin
      Result := True;
      exit;
    end;
    Temp := Temp.FInheritsFrom;
  end;
  Result := False;
end;

destructor TIFPSDelphiClass.Destroy;
begin
  inherited Destroy;
end;

function TIFPSDelphiClass.SetNil(TypeNo: Cardinal; var ProcNo: Cardinal): Boolean;
var
  P: TIFPSExternalProcedure;

begin
  if NilProcNo <> Cardinal(-1) then
  begin
    Procno := NilProcNo;
    Result := True;
    exit;
  end;
  ProcNo := TIFPSPascalCompiler2(Se).AddUsedFunction2(P);
  P.RegProc := SE.AddFunction(ProcHDR);
  P.RegProc.Name := '';
  P.RegProc.Decl := '-1 !VARNO '+IntToStr(TypeNo);
  P.RegProc.ImportDecl := 'class:-';
  NilProcNo := Procno;
  Result := True;
end;

function TIFPSDelphiClass.CastToType(TypeNo, IntoType: Cardinal;
  var ProcNo: Cardinal): Boolean;
var
  P: TIFPSExternalProcedure;
  Pt: PIFPSType;

begin
  pt := TComp(Se).FUsedTypes.GetItem(IntoType);
  if (pt <> nil) and (pt.BaseType <> btClass) or (not (TIFPSClassType(pt).ClassHelper is TIFPSDelphiClass)) then
  begin
    Result := False;
    exit;
  end;
  if CastProcNo <> Cardinal(-1) then
  begin
    Procno := CastProcNo;
    Result := True;
    exit;
  end;
  ProcNo := TIFPSPascalCompiler2(Se).AddUsedFunction2(P);
  P.RegProc := SE.AddFunction(ProcHDR);
  P.RegProc.Name := '';
  P.RegProc.Decl := '-1 !VARTO '+IntToStr(TypeNo)+' !TYPENO '+IntToStr(TComp(SE).GetType(btu32));
  P.RegProc.ImportDecl := 'class:+';
  CastProcNo := ProcNo;
  Result := True;
end;

function TIFPSDelphiClass.CompareClass(OtherTypeNo: Cardinal;
  var ProcNo: Cardinal): Boolean;
var
  P: TIFPSExternalProcedure;
  Pt: PIFPSType;

begin
  if OtherTypeNo <> cardinal(-1) then
  begin
    pt := TComp(Se).FUsedTypes.GetItem(OtherTypeNo);
    if (pt <> nil) and (pt.BaseType <> btClass) or (not (TIFPSClassType(pt).ClassHelper is TIFPSDelphiClass)) then
    begin
      Result := False;
      exit;
    end;
  end;
  if CompareProcNo <> Cardinal(-1) then
  begin
    Procno := CompareProcNo;
    Result := True;
    exit;
  end;
  ProcNo := TIFPSPascalCompiler2(Se).AddUsedFunction2(P);
  P.RegProc := SE.AddFunction(ProcHDR);
  P.RegProc.Name := '';
  P.RegProc.Decl := IntToStr(TComp(SE).at2ut(TComp(SE).FBooleanType))+' !K '+IntToStr(TComp(SE).at2ut(TComp(SE).FindType('TObject')))+' !J '+IntToStr(TComp(SE).at2ut(TComp(SE).FindType('TObject')));
  P.RegProc.ImportDecl := 'class:*';
  CompareProcNo := ProcNo;
  Result := True;
end;

end.


