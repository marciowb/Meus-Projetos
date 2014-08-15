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
unit ap_DBCommon;

interface

uses
  Windows,
  Variants,
  Classes,
  DB,
  SqlTimSt,
  DBCommon,
  atScript;

{$WARNINGS OFF}

type
  TatDBCommonLibrary = class(TatScripterLibrary)
    procedure __TFilterExprDestroy(AMachine: TatVirtualMachine);
    procedure __SetTFilterExprDataSet(AMachine: TatVirtualMachine);
    procedure __TExprParserDestroy(AMachine: TatVirtualMachine);
    procedure __TExprParserSetExprParams(AMachine: TatVirtualMachine);
    procedure __GetTExprParserDataSize(AMachine: TatVirtualMachine);
    procedure __GetFieldInfo(AMachine: TatVirtualMachine);
    procedure __NextSQLToken(AMachine: TatVirtualMachine);
    procedure __GetIndexForOrderBy(AMachine: TatVirtualMachine);
    procedure __GetTableNameFromSQL(AMachine: TatVirtualMachine);
    procedure __GetTableNameFromQuery(AMachine: TatVirtualMachine);
    procedure __AddParamSQLForDetail(AMachine: TatVirtualMachine);
    procedure __IsMultiTableQuery(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TFilterExprClass = class of TFilterExpr;
  TExprParserClass = class of TExprParser;


  TExprNodeWrapper = class(TatRecordWrapper)
  private
    FFKind: TExprNodeKind;
    FFPartial: Boolean;
    FFOperator: TCANOperator;
    FFData: Variant;
    FFDataType: TFieldType;
    FFDataSize: Integer;
    FFArgs: TList;
    FFScopeKind: TExprScopeKind;
  public
    constructor Create(ARecord: TExprNode);
    function ObjToRec: TExprNode;
  published
    property FKind: TExprNodeKind read FFKind write FFKind;
    property FPartial: Boolean read FFPartial write FFPartial;
    property FOperator: TCANOperator read FFOperator write FFOperator;
    property FData: Variant read FFData write FFData;
    property FDataType: TFieldType read FFDataType write FFDataType;
    property FDataSize: Integer read FFDataSize write FFDataSize;
    property FArgs: TList read FFArgs write FFArgs;
    property FScopeKind: TExprScopeKind read FFScopeKind write FFScopeKind;
  end;
  
  TFieldInfoWrapper = class(TatRecordWrapper)
  private
    FDatabaseName: string;
    FTableName: string;
    FOriginalFieldName: string;
  public
    constructor Create(ARecord: TFieldInfo);
    function ObjToRec: TFieldInfo;
  published
    property DatabaseName: string read FDatabaseName write FDatabaseName;
    property TableName: string read FTableName write FTableName;
    property OriginalFieldName: string read FOriginalFieldName write FOriginalFieldName;
  end;
  

implementation

constructor TExprNodeWrapper.Create(ARecord: TExprNode);
begin
  inherited Create;
  FFKind := ARecord.FKind;
  FFPartial := ARecord.FPartial;
  FFOperator := ARecord.FOperator;
  FFData := ARecord.FData;
  FFDataType := ARecord.FDataType;
  FFDataSize := ARecord.FDataSize;
  FFArgs := ARecord.FArgs;
  FFScopeKind := ARecord.FScopeKind;
end;

function TExprNodeWrapper.ObjToRec: TExprNode;
begin
  result.FKind := FFKind;
  result.FPartial := FFPartial;
  result.FOperator := FFOperator;
  result.FData := FFData;
  result.FDataType := FFDataType;
  result.FDataSize := FFDataSize;
  result.FArgs := FFArgs;
  result.FScopeKind := FFScopeKind;
end;

constructor TFieldInfoWrapper.Create(ARecord: TFieldInfo);
begin
  inherited Create;
  FDatabaseName := ARecord.DatabaseName;
  FTableName := ARecord.TableName;
  FOriginalFieldName := ARecord.OriginalFieldName;
end;

function TFieldInfoWrapper.ObjToRec: TFieldInfo;
begin
  result.DatabaseName := FDatabaseName;
  result.TableName := FTableName;
  result.OriginalFieldName := FOriginalFieldName;
end;



procedure TatDBCommonLibrary.__TFilterExprDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFilterExpr(CurrentObject).Destroy;
  end;
end;

procedure TatDBCommonLibrary.__SetTFilterExprDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFilterExpr(CurrentObject).DataSet:=TDataSet(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBCommonLibrary.__TExprParserDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TExprParser(CurrentObject).Destroy;
  end;
end;

procedure TatDBCommonLibrary.__TExprParserSetExprParams(AMachine: TatVirtualMachine);
  var
  Param1: TFilterOptions;
  Param2: TParserOptions;
begin
  with AMachine do
  begin
IntToSet(Param1, VarToInteger(GetInputArg(1)), SizeOf(Param1));
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
    TExprParser(CurrentObject).SetExprParams(GetInputArg(0),Param1,Param2,GetInputArg(3));
  end;
end;

procedure TatDBCommonLibrary.__GetTExprParserDataSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TExprParser(CurrentObject).DataSize));
  end;
end;

procedure TatDBCommonLibrary.__GetFieldInfo(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFieldInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TFieldInfoWrapper) then 
  Param1Rec := TFieldInfoWrapper.Create(Param1);
Param1 := TFieldInfoWrapper(Param1Rec).ObjToRec;
AResult := DBCommon.GetFieldInfo(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TFieldInfoWrapper.Create(Param1)));
  end;
end;

procedure TatDBCommonLibrary.__NextSQLToken(AMachine: TatVirtualMachine);
  var
  Param0: PChar;
  Param1: string;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := PChar(VarToStr(GetInputArg(0)));
Param1 := GetInputArg(1);
AResult := DBCommon.NextSQLToken(Param0,Param1,GetInputArg(2));
    ReturnOutputArg(AResult);
    SetInputArg(0,string(Param0));
    SetInputArg(1,Param1);
  end;
end;

procedure TatDBCommonLibrary.__GetIndexForOrderBy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DBCommon.GetIndexForOrderBy(GetInputArg(0),TDataSet(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCommonLibrary.__GetTableNameFromSQL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DBCommon.GetTableNameFromSQL(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCommonLibrary.__GetTableNameFromQuery(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DBCommon.GetTableNameFromQuery(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCommonLibrary.__AddParamSQLForDetail(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
3: AResult := DBCommon.AddParamSQLForDetail(TParams(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
4: AResult := DBCommon.AddParamSQLForDetail(TParams(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2),GetInputArg(3));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCommonLibrary.__IsMultiTableQuery(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DBCommon.IsMultiTableQuery(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCommonLibrary.Init;
begin
  With Scripter.DefineClass(TFilterExpr) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TFilterExprDestroy,false,0);
    DefineProp('DataSet',tkClass,nil,__SetTFilterExprDataSet,TDataSet,false,0);
  end;
  With Scripter.DefineClass(TExprParser) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TExprParserDestroy,false,0);
    DefineMethod('SetExprParams',4,tkNone,nil,__TExprParserSetExprParams,false,0);
    DefineProp('DataSize',tkInteger,__GetTExprParserDataSize,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetFieldInfo',2,tkVariant,nil,__GetFieldInfo,false,0).SetVarArgs([1]);
    DefineMethod('NextSQLToken',3,tkEnumeration,nil,__NextSQLToken,false,0).SetVarArgs([0,1]);
    DefineMethod('GetIndexForOrderBy',2,tkClass,TIndexDef,__GetIndexForOrderBy,false,0);
    DefineMethod('GetTableNameFromSQL',1,tkVariant,nil,__GetTableNameFromSQL,false,0);
    DefineMethod('GetTableNameFromQuery',1,tkVariant,nil,__GetTableNameFromQuery,false,0);
    DefineMethod('AddParamSQLForDetail',4,tkVariant,nil,__AddParamSQLForDetail,false,1);
    DefineMethod('IsMultiTableQuery',1,tkVariant,nil,__IsMultiTableQuery,false,0);
    AddConstant('coNOTDEFINED',coNOTDEFINED);
    AddConstant('coISBLANK',coISBLANK);
    AddConstant('coNOTBLANK',coNOTBLANK);
    AddConstant('coEQ',coEQ);
    AddConstant('coNE',coNE);
    AddConstant('coGT',coGT);
    AddConstant('coLT',coLT);
    AddConstant('coGE',coGE);
    AddConstant('coLE',coLE);
    AddConstant('coNOT',coNOT);
    AddConstant('coAND',coAND);
    AddConstant('coOR',coOR);
    AddConstant('coTUPLE2',coTUPLE2);
    AddConstant('coFIELD2',coFIELD2);
    AddConstant('coCONST2',coCONST2);
    AddConstant('coMINUS',coMINUS);
    AddConstant('coADD',coADD);
    AddConstant('coSUB',coSUB);
    AddConstant('coMUL',coMUL);
    AddConstant('coDIV',coDIV);
    AddConstant('coMOD',coMOD);
    AddConstant('coREM',coREM);
    AddConstant('coSUM',coSUM);
    AddConstant('coCOUNT',coCOUNT);
    AddConstant('coMIN',coMIN);
    AddConstant('coMAX',coMAX);
    AddConstant('coAVG',coAVG);
    AddConstant('coCONT',coCONT);
    AddConstant('coUDF2',coUDF2);
    AddConstant('coCONTINUE2',coCONTINUE2);
    AddConstant('coLIKE',coLIKE);
    AddConstant('coIN',coIN);
    AddConstant('coLIST2',coLIST2);
    AddConstant('coUPPER',coUPPER);
    AddConstant('coLOWER',coLOWER);
    AddConstant('coFUNC2',coFUNC2);
    AddConstant('coLISTELEM2',coLISTELEM2);
    AddConstant('coASSIGN',coASSIGN);
    AddConstant('nodeNULL',nodeNULL);
    AddConstant('nodeUNARY',nodeUNARY);
    AddConstant('nodeBINARY',nodeBINARY);
    AddConstant('nodeCOMPARE',nodeCOMPARE);
    AddConstant('nodeFIELD',nodeFIELD);
    AddConstant('nodeCONST',nodeCONST);
    AddConstant('nodeTUPLE',nodeTUPLE);
    AddConstant('nodeCONTINUE',nodeCONTINUE);
    AddConstant('nodeUDF',nodeUDF);
    AddConstant('nodeLIST',nodeLIST);
    AddConstant('nodeFUNC',nodeFUNC);
    AddConstant('nodeLISTELEM',nodeLISTELEM);
    AddConstant('poExtSyntax',poExtSyntax);
    AddConstant('poAggregate',poAggregate);
    AddConstant('poDefaultExpr',poDefaultExpr);
    AddConstant('poUseOrigNames',poUseOrigNames);
    AddConstant('poFieldNameGiven',poFieldNameGiven);
    AddConstant('poFieldDepend',poFieldDepend);
    AddConstant('enField',enField);
    AddConstant('enConst',enConst);
    AddConstant('enOperator',enOperator);
    AddConstant('enFunc',enFunc);
    AddConstant('skField',skField);
    AddConstant('skAgg',skAgg);
    AddConstant('skConst',skConst);
    AddConstant('etEnd',etEnd);
    AddConstant('etSymbol',etSymbol);
    AddConstant('etName',etName);
    AddConstant('etLiteral',etLiteral);
    AddConstant('etLParen',etLParen);
    AddConstant('etRParen',etRParen);
    AddConstant('etEQ',etEQ);
    AddConstant('etNE',etNE);
    AddConstant('etGE',etGE);
    AddConstant('etLE',etLE);
    AddConstant('etGT',etGT);
    AddConstant('etLT',etLT);
    AddConstant('etADD',etADD);
    AddConstant('etSUB',etSUB);
    AddConstant('etMUL',etMUL);
    AddConstant('etDIV',etDIV);
    AddConstant('etComma',etComma);
    AddConstant('etLIKE',etLIKE);
    AddConstant('etISNULL',etISNULL);
    AddConstant('etISNOTNULL',etISNOTNULL);
    AddConstant('etIN',etIN);
    AddConstant('stUnknown',stUnknown);
    AddConstant('stTableName',stTableName);
    AddConstant('stFieldName',stFieldName);
    AddConstant('stAscending',stAscending);
    AddConstant('stDescending',stDescending);
    AddConstant('stSelect',stSelect);
    AddConstant('stFrom',stFrom);
    AddConstant('stWhere',stWhere);
    AddConstant('stGroupBy',stGroupBy);
    AddConstant('stHaving',stHaving);
    AddConstant('stUnion',stUnion);
    AddConstant('stPlan',stPlan);
    AddConstant('stOrderBy',stOrderBy);
    AddConstant('stForUpdate',stForUpdate);
    AddConstant('stEnd',stEnd);
    AddConstant('stPredicate',stPredicate);
    AddConstant('stValue',stValue);
    AddConstant('stIsNull',stIsNull);
    AddConstant('stIsNotNull',stIsNotNull);
    AddConstant('stLike',stLike);
    AddConstant('stAnd',stAnd);
    AddConstant('stOr',stOr);
    AddConstant('stNumber',stNumber);
    AddConstant('stAllFields',stAllFields);
    AddConstant('stComment',stComment);
    AddConstant('stDistinct',stDistinct);
    AddConstant('CANEXPRSIZE',CANEXPRSIZE);
    AddConstant('CANHDRSIZE',CANHDRSIZE);
    AddConstant('CANEXPRVERSION',CANEXPRVERSION);
    AddConstant('SQLSections',IntFromConstSet(SQLSections));
  end;
end;

class function TatDBCommonLibrary.LibraryName: string;
begin
  result := 'DBCommon';
end;

initialization
  RegisterScripterLibrary(TatDBCommonLibrary, True);

{$WARNINGS ON}

end.

