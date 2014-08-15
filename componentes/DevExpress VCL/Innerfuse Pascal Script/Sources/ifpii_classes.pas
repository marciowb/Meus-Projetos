unit ifpii_classes;

{$I ifps3_def.inc}
interface
uses
  ifpscomp, ifps3common, ifps3utl, ifpiclass;

{
  Will register files from:
    Classes (exception TPersistent and TComponent)

  Register STD first

}
procedure SIRegister_Classes_TypesAndConsts(Cl: TIFPSCompileTimeClassesImporter);

procedure SIRegisterTStrings(cl: TIFPSCompileTimeClassesImporter; Streams: Boolean);
procedure SIRegisterTStringList(cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTBITS(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTSTREAM(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTHANDLESTREAM(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTMEMORYSTREAM(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTFILESTREAM(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTCUSTOMMEMORYSTREAM(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTRESOURCESTREAM(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTPARSER(Cl: TIFPSCompileTimeClassesImporter);

procedure SIRegister_Classes(Cl: TIFPSCompileTimeClassesImporter; Streams: Boolean{$IFDEF D4PLUS}=True{$ENDIF});

implementation

procedure SIRegisterTStrings(cl: TIFPSCompileTimeClassesImporter; Streams: Boolean); // requires TPersistent
begin
  with Cl.Add2(cl.FindClass('TPersistent'), 'TSTRINGS') do
  begin
    RegisterMethod('function Add(S: string): Integer;');
    RegisterMethod('procedure Append(S: string);');
    RegisterMethod('procedure AddStrings(Strings: TStrings);');
    RegisterMethod('procedure Clear;');
    RegisterMethod('procedure Delete(Index: Integer);');
    RegisterMethod('function IndexOf(const S: string): Integer; ');
    RegisterMethod('procedure Insert(Index: Integer; S: string); ');
    RegisterProperty('Count', 'Integer', iptR);
    RegisterProperty('Text', 'String', iptrw);
    RegisterProperty('CommaText', 'String', iptrw);
    if Streams then
    begin
      RegisterMethod('procedure LoadFromFile(FileName: string); ');
      RegisterMethod('procedure SaveToFile(FileName: string); ');
    end;
    RegisterProperty('Strings', 'String Integer', iptRW);
    RegisterProperty('Objects', 'TObject Integer', iptRW);

    {$IFNDEF MINIVCL}
    RegisterMethod('procedure BeginUpdate;');
    RegisterMethod('procedure EndUpdate;');
    RegisterMethod('function Equals(Strings: TStrings): Boolean;');
    RegisterMethod('procedure Exchange(Index1, Index2: Integer);');
    RegisterMethod('function IndexOfName(Name: string): Integer;');
    if Streams then
      RegisterMethod('procedure LoadFromStream(Stream: TStream); ');
    RegisterMethod('procedure Move(CurIndex, NewIndex: Integer); ');
    if Streams then
      RegisterMethod('procedure SaveToStream(Stream: TStream); ');
    RegisterMethod('procedure SetText(Text: PChar); ');
    RegisterProperty('Names', 'String Integer', iptrw);
    RegisterProperty('Values', 'String String', iptRW);
    RegisterMethod('function ADDOBJECT(S:STRING;AOBJECT:TOBJECT):INTEGER');
    RegisterMethod('procedure APPEND(S:STRING)');
    RegisterMethod('function GETTEXT:PCHAR');
    RegisterMethod('function INDEXOFOBJECT(AOBJECT:TOBJECT):INTEGER');
    RegisterMethod('procedure INSERTOBJECT(INDEX:INTEGER;S:STRING;AOBJECT:TOBJECT)');
    {$ENDIF}
  end;
end;

procedure SIRegisterTSTRINGLIST(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TSTRINGS'), 'TSTRINGLIST') do
  begin
    RegisterMethod('function FIND(S:STRING;var INDEX:INTEGER):BOOLEAN');
    RegisterMethod('procedure SORT');
    RegisterProperty('DUPLICATES', 'TDUPLICATES', iptrw);
    RegisterProperty('SORTED', 'BOOLEAN', iptrw);
    RegisterProperty('ONCHANGE', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONCHANGING', 'TNOTIFYEVENT', iptrw);
  end;
end;




procedure SIRegisterTBITS(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TObject'), 'TBITS') do
  begin
    RegisterMethod('function OPENBIT:INTEGER');
    RegisterProperty('BITS:INTEGER', 'BOOLEAN INTEGER', iptrw);
    RegisterProperty('SIZE', 'INTEGER', iptrw);
  end;
end;

procedure SIRegisterTSTREAM(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TOBJECT'), 'TSTREAM') do
  begin
    RegisterMethod('function READ(BUFFER:STRING;COUNT:LONGINT):LONGINT');
    RegisterMethod('function WRITE(BUFFER:STRING;COUNT:LONGINT):LONGINT');
    RegisterMethod('function SEEK(OFFSET:LONGINT;ORIGIN:WORD):LONGINT');
    RegisterMethod('procedure READBUFFER(BUFFER:STRING;COUNT:LONGINT)');
    RegisterMethod('procedure WRITEBUFFER(BUFFER:STRING;COUNT:LONGINT)');
    RegisterMethod('function COPYFROM(SOURCE:TSTREAM;COUNT:LONGINT):LONGINT');
    RegisterProperty('POSITION', 'LONGINT', iptrw);
    RegisterProperty('SIZE', 'LONGINT', iptr);
  end;
end;

procedure SIRegisterTHANDLESTREAM(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TSTREAM'), 'THANDLESTREAM') do
  begin
    RegisterMethod('constructor CREATE(AHANDLE:INTEGER)');
    RegisterProperty('HANDLE', 'INTEGER', iptr);
  end;
end;

procedure SIRegisterTMEMORYSTREAM(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TCUSTOMMEMORYSTREAM'), 'TMEMORYSTREAM') do
  begin
    RegisterMethod('procedure CLEAR');
    RegisterMethod('procedure LOADFROMSTREAM(STREAM:TSTREAM)');
    RegisterMethod('procedure LOADFROMFILE(FILENAME:STRING)');
    RegisterMethod('procedure SETSIZE(NEWSIZE:LONGINT)');
  end;
end;

procedure SIRegisterTFILESTREAM(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('THANDLESTREAM'), 'TFILESTREAM') do
  begin
    RegisterMethod('constructor CREATE(FILENAME:STRING;MODE:WORD)');
  end;
end;

procedure SIRegisterTCUSTOMMEMORYSTREAM(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TSTREAM'), 'TCUSTOMMEMORYSTREAM') do
  begin
    RegisterMethod('procedure SAVETOSTREAM(STREAM:TSTREAM)');
    RegisterMethod('procedure SAVETOFILE(FILENAME:STRING)');
  end;
end;

procedure SIRegisterTRESOURCESTREAM(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TCUSTOMMEMORYSTREAM'), 'TRESOURCESTREAM') do
  begin
    RegisterMethod('constructor CREATE(INSTANCE:THANDLE;RESNAME:STRING;RESTYPE:PCHAR)');
    RegisterMethod('constructor CREATEFROMID(INSTANCE:THANDLE;RESID:INTEGER;RESTYPE:PCHAR)');
  end;
end;

procedure SIRegisterTPARSER(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TOBJECT'), 'TPARSER') do
  begin
    RegisterMethod('constructor CREATE(STREAM:TSTREAM)');
    RegisterMethod('procedure CHECKTOKEN(T:CHAR)');
    RegisterMethod('procedure CHECKTOKENSYMBOL(S:STRING)');
    RegisterMethod('procedure ERROR(IDENT:INTEGER)');
    RegisterMethod('procedure ERRORSTR(MESSAGE:STRING)');
    RegisterMethod('procedure HEXTOBINARY(STREAM:TSTREAM)');
    RegisterMethod('function NEXTTOKEN:CHAR');
    RegisterMethod('function SOURCEPOS:LONGINT');
    RegisterMethod('function TOKENCOMPONENTIDENT:STRING');
    RegisterMethod('function TOKENFLOAT:EXTENDED');
    RegisterMethod('function TOKENINT:LONGINT');
    RegisterMethod('function TOKENSTRING:STRING');
    RegisterMethod('function TOKENSYMBOLIS(S:STRING):BOOLEAN');
    RegisterProperty('SOURCELINE', 'INTEGER', iptr);
    RegisterProperty('TOKEN', 'CHAR', iptr);
  end;
end;

procedure SIRegister_Classes_TypesAndConsts(Cl: TIFPSCompileTimeClassesImporter);
begin
  Cl.SE.AddConstantN('soFromBeginning', 'Longint')^.Value.ts32 := 0;
  Cl.SE.AddConstantN('soFromCurrent', 'Longint')^.Value.ts32 := 1;
  Cl.SE.AddConstantN('soFromEnd', 'Longint')^.Value.ts32 := 2;
  Cl.SE.AddConstantN('fmCreate', 'Longint')^.Value.ts32 := $FFFF;
  Cl.SE.AddConstantN('toEOF', 'Char')^.Value.tchar := #0;
  Cl.SE.AddConstantN('toSymbol', 'Char')^.Value.tchar := #1;
  Cl.SE.AddConstantN('toString', 'Char')^.Value.tchar := #2;
  Cl.SE.AddConstantN('toInteger', 'Char')^.Value.tchar := #3;
  Cl.SE.AddConstantN('toFloat', 'Char')^.Value.tchar := #4;
  Cl.SE.AddConstantN('ssShift', 'Byte')^.Value.tu8 := 1;
  Cl.SE.AddConstantN('ssAlt', 'Byte')^.Value.tu8 := 2;
  Cl.SE.AddConstantN('ssCtrl', 'Byte')^.Value.tu8 := 4;
  Cl.SE.AddConstantN('ssLeft', 'Byte')^.Value.tu8 := 8;
  Cl.SE.AddConstantN('ssRight', 'Byte')^.Value.tu8 := 16;
  Cl.SE.AddConstantN('ssMiddle', 'Byte')^.Value.tu8 := 32;
  Cl.SE.AddConstantN('ssDouble', 'Byte')^.Value.tu8 := 64;
  Cl.SE.AddConstantN('fmOpenRead', 'Longint')^.Value.ts32 := 0;
  Cl.SE.AddConstantN('fmOpenWrite', 'Longint')^.Value.ts32 := 1;
  Cl.SE.AddConstantN('fmOpenReadWrite', 'Longint')^.Value.ts32 := 2;
  Cl.SE.AddConstantN('fmShareCompat', 'Longint')^.Value.ts32 := 0;
  Cl.SE.AddConstantN('fmShareExclusive', 'Longint')^.Value.ts32 := $10;
  Cl.SE.AddConstantN('fmShareDenyWrite', 'Longint')^.Value.ts32 := $20;
  Cl.SE.AddConstantN('SecsPerDay', 'Longint')^.Value.ts32 := 86400;
  Cl.SE.AddConstantN('MSecPerDay', 'Longint')^.Value.ts32 := 86400000;
  Cl.SE.AddConstantN('DateDelta', 'Longint')^.Value.ts32 := 693594;
  cl.SE.AddTypeS('TAlignment', '(taLeftJustify, taRightJustify, taCenter)');
  cl.Se.AddTypeS('THelpEvent', 'function (Command: Word; Data: Longint; var CallHelp: Boolean): Boolean');
  Cl.Se.AddTypeS('TGetStrProc', 'procedure(const S: string)');
  cl.se.AddTypeS('TDuplicates', '(dupIgnore, dupAccept, dupError)');
  cl.se.AddTypeS('TOperation', '(opInsert, opRemove)');

  cl.se.AddTypeS('TNotifyEvent', 'procedure (Sender: TObject)');
end;

procedure SIRegisterTCOLLECTIONITEM(CL: TIFPSCompileTimeClassesImporter);
Begin
  if cl.FindClass('TCOLLECTION') = nil then cl.Add2(cl.FindClass('TPERSISTENT'), 'TCOLLECTION');
  With cl.Add2(cl.FindClass('TPERSISTENT'),'TCOLLECTIONITEM') do
  begin
  RegisterMethod('Constructor CREATE( COLLECTION : TCOLLECTION)');
  RegisterProperty('COLLECTION', 'TCOLLECTION', iptrw);
  RegisterProperty('ID', 'INTEGER', iptr);
  RegisterProperty('INDEX', 'INTEGER', iptrw);
  RegisterProperty('DISPLAYNAME', 'STRING', iptrw);
  end;
end;

procedure SIRegisterTCOLLECTION(CL: TIFPSCompileTimeClassesImporter);
var
  cr: TIFPSCompileTimeClass;
Begin
  cr := CL.FindClass('TCOLLECTION');
  if cr = nil then cr := cl.Add2(cl.FindClass('TPERSISTENT'), 'TCOLLECTION');
With cr do
  begin
  RegisterMethod('Constructor CREATE( ITEMCLASS : TCOLLECTIONITEMCLASS)');
  RegisterMethod('Function OWNER : TPERSISTENT');
  RegisterMethod('Function ADD : TCOLLECTIONITEM');
  RegisterMethod('Procedure BEGINUPDATE');
  RegisterMethod('Procedure CLEAR');
  RegisterMethod('Procedure DELETE( INDEX : INTEGER)');
  RegisterMethod('Procedure ENDUPDATE');
  RegisterMethod('Function FINDITEMID( ID : INTEGER) : TCOLLECTIONITEM');
  RegisterMethod('Function INSERT( INDEX : INTEGER) : TCOLLECTIONITEM');
  RegisterProperty('COUNT', 'INTEGER', iptr);
  RegisterProperty('ITEMCLASS', 'TCOLLECTIONITEMCLASS', iptr);
  RegisterProperty('ITEMS', 'TCOLLECTIONITEM INTEGER', iptrw);
  end;
end;

procedure SIRegisterTOWNEDCOLLECTION(CL: TIFPSCompileTimeClassesImporter);
Begin
With Cl.Add2(cl.FindClass('TCOLLECTION'),'TOWNEDCOLLECTION') do
  begin
  RegisterMethod('Constructor CREATE( AOWNER : TPERSISTENT; ITEMCLASS : TCOLLECTIONITEMCLASS)');
  end;
end;


procedure SIRegister_Classes(Cl: TIFPSCompileTimeClassesImporter; Streams: Boolean);
begin
  SIRegister_Classes_TypesAndConsts(Cl);
  {$IFNDEF MINIVCL}
  if Streams then
    SIRegisterTSTREAM(Cl);
  {$ENDIF}
  SIRegisterTStrings(cl, Streams);
  SIRegisterTStringList(cl);
  {$IFNDEF MINIVCL}
  SIRegisterTBITS(cl);
  if Streams then
  begin
    SIRegisterTHANDLESTREAM(Cl);
    SIRegisterTMEMORYSTREAM(Cl);
    SIRegisterTFILESTREAM(Cl);
    SIRegisterTCUSTOMMEMORYSTREAM(Cl);
    SIRegisterTRESOURCESTREAM(Cl);
  end;
  SIRegisterTPARSER(Cl);
  SIRegisterTCOLLECTIONITEM(Cl);
  SIRegisterTCOLLECTION(Cl);
  SIRegisterTOWNEDCOLLECTION(Cl);
  {$ENDIF}
end;

// MiniVCL changes by Martijn Laan (mlaan at wintax _dot_ nl)


end.
