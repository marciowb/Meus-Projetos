{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_IBScript;

interface

uses
  SysUtils,
  Classes,
  IBDatabase,
  IBCustomDataset,
  IBSQL,
  IBDatabaseInfo,
  IBScript,
  atScript;

{$WARNINGS OFF}

type
  TatIBScriptLibrary = class(TatScripterLibrary)
    procedure __TIBSQLParserCreate(AMachine: TatVirtualMachine);
    procedure __TIBSQLParserDestroy(AMachine: TatVirtualMachine);
    procedure __TIBSQLParserParse(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLParserCurrentLine(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLParserCurrentTokens(AMachine: TatVirtualMachine);
    procedure __TIBScriptStatsCreate(AMachine: TatVirtualMachine);
    procedure __TIBScriptStatsDestroy(AMachine: TatVirtualMachine);
    procedure __TIBScriptStatsStart(AMachine: TatVirtualMachine);
    procedure __TIBScriptStatsClear(AMachine: TatVirtualMachine);
    procedure __TIBScriptStatsStop(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptStatsDatabase(AMachine: TatVirtualMachine);
    procedure __SetTIBScriptStatsDatabase(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptStatsBuffers(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptStatsReads(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptStatsWrites(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptStatsSeqReads(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptStatsFetches(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptStatsReadIdx(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptStatsDeltaMem(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptStatsStartingMem(AMachine: TatVirtualMachine);
    procedure __TIBScriptCreate(AMachine: TatVirtualMachine);
    procedure __TIBScriptDestroy(AMachine: TatVirtualMachine);
    procedure __TIBScriptValidateScript(AMachine: TatVirtualMachine);
    procedure __TIBScriptExecuteScript(AMachine: TatVirtualMachine);
    procedure __TIBScriptParamByName(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptPaused(AMachine: TatVirtualMachine);
    procedure __SetTIBScriptPaused(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptParams(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptStats(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptCurrentTokens(AMachine: TatVirtualMachine);
    procedure __GetTIBScriptValidating(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBSQLParserClass = class of TIBSQLParser;
  TIBScriptStatsClass = class of TIBScriptStats;
  TIBScriptClass = class of TIBScript;

  TatIBScriptDispatcher = class(TatEventDispatcher)
  private
    procedure __TIBSQLParseError( Sender: TObject;  Error: string;  SQLText: string;  LineIndex: Integer);
    procedure __TIBSQLExecuteError( Sender: TObject;  Error: string;  SQLText: string;  LineIndex: Integer; var Ignore: Boolean);
    procedure __TIBSQLParseStmt( Sender: TObject;  AKind: TIBParseKind;  SQLText: string);
  end;


implementation



procedure TatIBScriptLibrary.__TIBSQLParserCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBSQLParserClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBScriptLibrary.__TIBSQLParserDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSQLParser(CurrentObject).Destroy;
  end;
end;

procedure TatIBScriptLibrary.__TIBSQLParserParse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSQLParser(CurrentObject).Parse;
  end;
end;

procedure TatIBScriptLibrary.__GetTIBSQLParserCurrentLine(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBSQLParser(CurrentObject).CurrentLine));
  end;
end;

procedure TatIBScriptLibrary.__GetTIBSQLParserCurrentTokens(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBSQLParser(CurrentObject).CurrentTokens));
  end;
end;

procedure TatIBScriptLibrary.__TIBScriptStatsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBScriptStatsClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBScriptLibrary.__TIBScriptStatsDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBScriptStats(CurrentObject).Destroy;
  end;
end;

procedure TatIBScriptLibrary.__TIBScriptStatsStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBScriptStats(CurrentObject).Start;
  end;
end;

procedure TatIBScriptLibrary.__TIBScriptStatsClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBScriptStats(CurrentObject).Clear;
  end;
end;

procedure TatIBScriptLibrary.__TIBScriptStatsStop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBScriptStats(CurrentObject).Stop;
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptStatsDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBScriptStats(CurrentObject).Database));
  end;
end;

procedure TatIBScriptLibrary.__SetTIBScriptStatsDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBScriptStats(CurrentObject).Database:=TIBDatabase(Integer(GetInputArg(0)));
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptStatsBuffers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBScriptStats(CurrentObject).Buffers));
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptStatsReads(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBScriptStats(CurrentObject).Reads));
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptStatsWrites(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBScriptStats(CurrentObject).Writes));
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptStatsSeqReads(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBScriptStats(CurrentObject).SeqReads));
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptStatsFetches(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBScriptStats(CurrentObject).Fetches));
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptStatsReadIdx(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBScriptStats(CurrentObject).ReadIdx));
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptStatsDeltaMem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBScriptStats(CurrentObject).DeltaMem));
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptStatsStartingMem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBScriptStats(CurrentObject).StartingMem));
  end;
end;

procedure TatIBScriptLibrary.__TIBScriptCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBScriptClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBScriptLibrary.__TIBScriptDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBScript(CurrentObject).Destroy;
  end;
end;

procedure TatIBScriptLibrary.__TIBScriptValidateScript(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBScript(CurrentObject).ValidateScript;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBScriptLibrary.__TIBScriptExecuteScript(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBScript(CurrentObject).ExecuteScript;
  end;
end;

procedure TatIBScriptLibrary.__TIBScriptParamByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBScript(CurrentObject).ParamByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptPaused(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBScript(CurrentObject).Paused);
  end;
end;

procedure TatIBScriptLibrary.__SetTIBScriptPaused(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBScript(CurrentObject).Paused:=GetInputArg(0);
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBScript(CurrentObject).Params));
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptStats(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBScript(CurrentObject).Stats));
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptCurrentTokens(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBScript(CurrentObject).CurrentTokens));
  end;
end;

procedure TatIBScriptLibrary.__GetTIBScriptValidating(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBScript(CurrentObject).Validating);
  end;
end;

procedure TatIBScriptDispatcher.__TIBSQLParseError( Sender: TObject;  Error: string;  SQLText: string;  LineIndex: Integer);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TIBSQLParseError(BeforeCall)(Sender,Error,SQLText,LineIndex);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Error,SQLText,LineIndex]);
    if AssignedMethod(AfterCall) then
      TIBSQLParseError(AfterCall)(Sender,Error,SQLText,LineIndex);
  end;
end;

procedure TatIBScriptDispatcher.__TIBSQLExecuteError( Sender: TObject;  Error: string;  SQLText: string;  LineIndex: Integer; var Ignore: Boolean);
var
  IgnoreTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TIBSQLExecuteError(BeforeCall)(Sender,Error,SQLText,LineIndex,Ignore);
    IgnoreTemp := Ignore;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Error,SQLText,LineIndex,IgnoreTemp]);
    Ignore := IgnoreTemp;
    if AssignedMethod(AfterCall) then
      TIBSQLExecuteError(AfterCall)(Sender,Error,SQLText,LineIndex,Ignore);
  end;
end;

procedure TatIBScriptDispatcher.__TIBSQLParseStmt( Sender: TObject;  AKind: TIBParseKind;  SQLText: string);
var
  AKindTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TIBSQLParseStmt(BeforeCall)(Sender,AKind,SQLText);
    AKindTemp := AKind;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,AKindTemp,SQLText]);
    if AssignedMethod(AfterCall) then
      TIBSQLParseStmt(AfterCall)(Sender,AKind,SQLText);
  end;
end;

procedure TatIBScriptLibrary.Init;
begin
  With Scripter.DefineClass(TIBSQLParser) do
  begin
    DefineMethod('Create',1,tkClass,TIBSQLParser,__TIBSQLParserCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBSQLParserDestroy,false,0);
    DefineMethod('Parse',0,tkNone,nil,__TIBSQLParserParse,false,0);
    DefineProp('CurrentLine',tkInteger,__GetTIBSQLParserCurrentLine,nil,nil,false,0);
    DefineProp('CurrentTokens',tkClass,__GetTIBSQLParserCurrentTokens,nil,TStrings,false,0);
  end;
  With Scripter.DefineClass(TIBScriptStats) do
  begin
    DefineMethod('Create',0,tkClass,TIBScriptStats,__TIBScriptStatsCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBScriptStatsDestroy,false,0);
    DefineMethod('Start',0,tkNone,nil,__TIBScriptStatsStart,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TIBScriptStatsClear,false,0);
    DefineMethod('Stop',0,tkNone,nil,__TIBScriptStatsStop,false,0);
    DefineProp('Database',tkClass,__GetTIBScriptStatsDatabase,__SetTIBScriptStatsDatabase,TIBDatabase,false,0);
    DefineProp('Buffers',tkVariant,__GetTIBScriptStatsBuffers,nil,nil,false,0);
    DefineProp('Reads',tkVariant,__GetTIBScriptStatsReads,nil,nil,false,0);
    DefineProp('Writes',tkVariant,__GetTIBScriptStatsWrites,nil,nil,false,0);
    DefineProp('SeqReads',tkVariant,__GetTIBScriptStatsSeqReads,nil,nil,false,0);
    DefineProp('Fetches',tkVariant,__GetTIBScriptStatsFetches,nil,nil,false,0);
    DefineProp('ReadIdx',tkVariant,__GetTIBScriptStatsReadIdx,nil,nil,false,0);
    DefineProp('DeltaMem',tkVariant,__GetTIBScriptStatsDeltaMem,nil,nil,false,0);
    DefineProp('StartingMem',tkVariant,__GetTIBScriptStatsStartingMem,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TIBScript) do
  begin
    DefineMethod('Create',1,tkClass,TIBScript,__TIBScriptCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBScriptDestroy,false,0);
    DefineMethod('ValidateScript',0,tkVariant,nil,__TIBScriptValidateScript,false,0);
    DefineMethod('ExecuteScript',0,tkNone,nil,__TIBScriptExecuteScript,false,0);
    DefineMethod('ParamByName',1,tkClass,TIBXSQLVAR,__TIBScriptParamByName,false,0);
    DefineProp('Paused',tkVariant,__GetTIBScriptPaused,__SetTIBScriptPaused,nil,false,0);
    DefineProp('Params',tkClass,__GetTIBScriptParams,nil,TIBXSQLDA,false,0);
    DefineProp('Stats',tkClass,__GetTIBScriptStats,nil,TIBScriptStats,false,0);
    DefineProp('CurrentTokens',tkClass,__GetTIBScriptCurrentTokens,nil,TStrings,false,0);
    DefineProp('Validating',tkVariant,__GetTIBScriptValidating,nil,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TIBSQLParseError), TatIBScriptDispatcher, @TatIBScriptDispatcher.__TIBSQLParseError);
  DefineEventAdapter(TypeInfo(TIBSQLExecuteError), TatIBScriptDispatcher, @TatIBScriptDispatcher.__TIBSQLExecuteError);
  DefineEventAdapter(TypeInfo(TIBSQLParseStmt), TatIBScriptDispatcher, @TatIBScriptDispatcher.__TIBSQLParseStmt);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('stmtDDL',stmtDDL);
    AddConstant('stmtDML',stmtDML);
    AddConstant('stmtSET',stmtSET);
    AddConstant('stmtCONNECT',stmtCONNECT);
    AddConstant('stmtDrop',stmtDrop);
    AddConstant('stmtCREATE',stmtCREATE);
    AddConstant('stmtINPUT',stmtINPUT);
    AddConstant('stmtUNK',stmtUNK);
    AddConstant('stmtEMPTY',stmtEMPTY);
    AddConstant('stmtTERM',stmtTERM);
    AddConstant('stmtERR',stmtERR);
    AddConstant('stmtCOMMIT',stmtCOMMIT);
    AddConstant('stmtROLLBACK',stmtROLLBACK);
  end;
end;

class function TatIBScriptLibrary.LibraryName: string;
begin
  result := 'IBScript';
end;

initialization
  RegisterScripterLibrary(TatIBScriptLibrary, True);

{$WARNINGS ON}

end.

