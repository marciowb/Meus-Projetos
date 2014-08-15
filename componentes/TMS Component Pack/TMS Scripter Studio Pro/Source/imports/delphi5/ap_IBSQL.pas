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
unit ap_IBSQL;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Forms,
  Controls,
  IBHeader,
  IBErrorCodes,
  IBExternals,
  DB,
  IB,
  IBDatabase,
  IBUtils,
  IBXConst,
  IBSQL,
  ap_IBHeader,
  atScript;

{$WARNINGS OFF}

type
  TatIBSQLLibrary = class(TatScripterLibrary)
    procedure __TIBXSQLVARCreate(AMachine: TatVirtualMachine);
    procedure __TIBXSQLVARAssign(AMachine: TatVirtualMachine);
    procedure __TIBXSQLVARLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TIBXSQLVARLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TIBXSQLVARSaveToFile(AMachine: TatVirtualMachine);
    procedure __TIBXSQLVARSaveToStream(AMachine: TatVirtualMachine);
    procedure __TIBXSQLVARClear(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsDate(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsDate(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsTime(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsTime(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsDateTime(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsDateTime(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsDouble(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsDouble(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsFloat(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsFloat(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsCurrency(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsCurrency(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsInt64(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsInt64(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsInteger(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsInteger(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsLong(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsLong(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsQuad(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsQuad(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsShort(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsShort(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsString(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsString(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsTrimString(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsTrimString(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARAsVariant(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARAsVariant(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARIsNull(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARIsNull(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARIsNullable(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARIsNullable(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARIndex(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARModified(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARModified(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARName(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARSize(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARSQLType(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLVARValue(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLVARValue(AMachine: TatVirtualMachine);
    procedure __TIBXSQLDACreate(AMachine: TatVirtualMachine);
    procedure __TIBXSQLDADestroy(AMachine: TatVirtualMachine);
    procedure __TIBXSQLDAAddName(AMachine: TatVirtualMachine);
    procedure __TIBXSQLDAByName(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLDACount(AMachine: TatVirtualMachine);
    procedure __SetTIBXSQLDACount(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLDAModified(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLDANames(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLDARecordSize(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLDAVars(AMachine: TatVirtualMachine);
    procedure __GetTIBXSQLDAUniqueRelationName(AMachine: TatVirtualMachine);
    procedure __TIBBatchReadyFile(AMachine: TatVirtualMachine);
    procedure __GetTIBBatchColumns(AMachine: TatVirtualMachine);
    procedure __SetTIBBatchColumns(AMachine: TatVirtualMachine);
    procedure __GetTIBBatchFilename(AMachine: TatVirtualMachine);
    procedure __SetTIBBatchFilename(AMachine: TatVirtualMachine);
    procedure __GetTIBBatchParams(AMachine: TatVirtualMachine);
    procedure __SetTIBBatchParams(AMachine: TatVirtualMachine);
    procedure __TIBBatchInputReadParameters(AMachine: TatVirtualMachine);
    procedure __TIBBatchOutputWriteColumns(AMachine: TatVirtualMachine);
    procedure __TIBOutputDelimitedFileDestroy(AMachine: TatVirtualMachine);
    procedure __TIBOutputDelimitedFileReadyFile(AMachine: TatVirtualMachine);
    procedure __TIBOutputDelimitedFileWriteColumns(AMachine: TatVirtualMachine);
    procedure __GetTIBOutputDelimitedFileColDelimiter(AMachine: TatVirtualMachine);
    procedure __SetTIBOutputDelimitedFileColDelimiter(AMachine: TatVirtualMachine);
    procedure __GetTIBOutputDelimitedFileOutputTitles(AMachine: TatVirtualMachine);
    procedure __SetTIBOutputDelimitedFileOutputTitles(AMachine: TatVirtualMachine);
    procedure __GetTIBOutputDelimitedFileRowDelimiter(AMachine: TatVirtualMachine);
    procedure __SetTIBOutputDelimitedFileRowDelimiter(AMachine: TatVirtualMachine);
    procedure __TIBInputDelimitedFileDestroy(AMachine: TatVirtualMachine);
    procedure __TIBInputDelimitedFileGetColumn(AMachine: TatVirtualMachine);
    procedure __TIBInputDelimitedFileReadParameters(AMachine: TatVirtualMachine);
    procedure __TIBInputDelimitedFileReadyFile(AMachine: TatVirtualMachine);
    procedure __GetTIBInputDelimitedFileColDelimiter(AMachine: TatVirtualMachine);
    procedure __SetTIBInputDelimitedFileColDelimiter(AMachine: TatVirtualMachine);
    procedure __GetTIBInputDelimitedFileReadBlanksAsNull(AMachine: TatVirtualMachine);
    procedure __SetTIBInputDelimitedFileReadBlanksAsNull(AMachine: TatVirtualMachine);
    procedure __GetTIBInputDelimitedFileRowDelimiter(AMachine: TatVirtualMachine);
    procedure __SetTIBInputDelimitedFileRowDelimiter(AMachine: TatVirtualMachine);
    procedure __GetTIBInputDelimitedFileSkipTitles(AMachine: TatVirtualMachine);
    procedure __SetTIBInputDelimitedFileSkipTitles(AMachine: TatVirtualMachine);
    procedure __TIBOutputRawFileDestroy(AMachine: TatVirtualMachine);
    procedure __TIBOutputRawFileReadyFile(AMachine: TatVirtualMachine);
    procedure __TIBOutputRawFileWriteColumns(AMachine: TatVirtualMachine);
    procedure __TIBInputRawFileDestroy(AMachine: TatVirtualMachine);
    procedure __TIBInputRawFileReadParameters(AMachine: TatVirtualMachine);
    procedure __TIBInputRawFileReadyFile(AMachine: TatVirtualMachine);
    procedure __TIBOutputXMLWriteXML(AMachine: TatVirtualMachine);
    procedure __GetTIBOutputXMLHeaderTag(AMachine: TatVirtualMachine);
    procedure __SetTIBOutputXMLHeaderTag(AMachine: TatVirtualMachine);
    procedure __GetTIBOutputXMLDatabaseTag(AMachine: TatVirtualMachine);
    procedure __SetTIBOutputXMLDatabaseTag(AMachine: TatVirtualMachine);
    procedure __GetTIBOutputXMLStream(AMachine: TatVirtualMachine);
    procedure __SetTIBOutputXMLStream(AMachine: TatVirtualMachine);
    procedure __GetTIBOutputXMLTableTag(AMachine: TatVirtualMachine);
    procedure __SetTIBOutputXMLTableTag(AMachine: TatVirtualMachine);
    procedure __GetTIBOutputXMLRowTag(AMachine: TatVirtualMachine);
    procedure __SetTIBOutputXMLRowTag(AMachine: TatVirtualMachine);
    procedure __GetTIBOutputXMLFlags(AMachine: TatVirtualMachine);
    procedure __SetTIBOutputXMLFlags(AMachine: TatVirtualMachine);
    procedure __TIBSQLCreate(AMachine: TatVirtualMachine);
    procedure __TIBSQLDestroy(AMachine: TatVirtualMachine);
    procedure __TIBSQLBatchInput(AMachine: TatVirtualMachine);
    procedure __TIBSQLBatchOutput(AMachine: TatVirtualMachine);
    procedure __TIBSQLCall(AMachine: TatVirtualMachine);
    procedure __TIBSQLCheckClosed(AMachine: TatVirtualMachine);
    procedure __TIBSQLCheckOpen(AMachine: TatVirtualMachine);
    procedure __TIBSQLCheckValidStatement(AMachine: TatVirtualMachine);
    procedure __TIBSQLClose(AMachine: TatVirtualMachine);
    procedure __TIBSQLCurrent(AMachine: TatVirtualMachine);
    procedure __TIBSQLExecQuery(AMachine: TatVirtualMachine);
    procedure __TIBSQLFieldByName(AMachine: TatVirtualMachine);
    procedure __TIBSQLFreeHandle(AMachine: TatVirtualMachine);
    procedure __TIBSQLNext(AMachine: TatVirtualMachine);
    procedure __TIBSQLPrepare(AMachine: TatVirtualMachine);
    procedure __TIBSQLGetUniqueRelationName(AMachine: TatVirtualMachine);
    procedure __TIBSQLParamByName(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLBof(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLEof(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLFields(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLFieldIndex(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLOpen(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLParams(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLPlan(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLPrepared(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLRecordCount(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLRowsAffected(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLSQLType(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLGenerateParamNames(AMachine: TatVirtualMachine);
    procedure __SetTIBSQLGenerateParamNames(AMachine: TatVirtualMachine);
    procedure __GetTIBSQLUniqueRelationName(AMachine: TatVirtualMachine);
    procedure __OutputXML(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBXSQLVARClass = class of TIBXSQLVAR;
  TIBXSQLDAClass = class of TIBXSQLDA;
  TIBBatchClass = class of TIBBatch;
  TIBBatchInputClass = class of TIBBatchInput;
  TIBBatchOutputClass = class of TIBBatchOutput;
  TIBOutputDelimitedFileClass = class of TIBOutputDelimitedFile;
  TIBInputDelimitedFileClass = class of TIBInputDelimitedFile;
  TIBOutputRawFileClass = class of TIBOutputRawFile;
  TIBInputRawFileClass = class of TIBInputRawFile;
  TIBOutputXMLClass = class of TIBOutputXML;
  TIBSQLClass = class of TIBSQL;



implementation



procedure TatIBSQLLibrary.__TIBXSQLVARCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBXSQLVARClass(CurrentClass.ClassRef).Create(TIBXSQLDA(Integer(GetInputArg(0))),TIBSQL(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__TIBXSQLVARAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).Assign(TIBXSQLVAR(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBSQLLibrary.__TIBXSQLVARLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).LoadFromFile(GetInputArg(0));
  end;
end;

procedure TatIBSQLLibrary.__TIBXSQLVARLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBSQLLibrary.__TIBXSQLVARSaveToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).SaveToFile(GetInputArg(0));
  end;
end;

procedure TatIBSQLLibrary.__TIBXSQLVARSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBSQLLibrary.__TIBXSQLVARClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).Clear;
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).AsDate);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsDate:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).AsTime);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsTime:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsDateTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).AsDateTime);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsDateTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsDateTime:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsDouble(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).AsDouble);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsDouble(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsDouble:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsFloat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).AsFloat);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsFloat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsFloat:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsCurrency(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).AsCurrency);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsCurrency(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsCurrency:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsInt64(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBXSQLVAR(CurrentObject).AsInt64));
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsInt64(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsInt64:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsInteger(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBXSQLVAR(CurrentObject).AsInteger));
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsInteger(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsInteger:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsLong(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBXSQLVAR(CurrentObject).AsLong));
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsLong(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsLong:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsQuad(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGDS_QUADWrapper.Create(TIBXSQLVAR(CurrentObject).AsQuad)));
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsQuad(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsQuad:=TGDS_QUADWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsShort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBXSQLVAR(CurrentObject).AsShort));
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsShort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsShort:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).AsString);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsString:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsTrimString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).AsTrimString);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsTrimString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsTrimString:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARAsVariant(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).AsVariant);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARAsVariant(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).AsVariant:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARIsNull(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).IsNull);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARIsNull(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).IsNull:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARIsNullable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).IsNullable);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARIsNullable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).IsNullable:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBXSQLVAR(CurrentObject).Index));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).Modified);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).Modified:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).Name);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBXSQLVAR(CurrentObject).Size));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARSQLType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBXSQLVAR(CurrentObject).SQLType));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLVARValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLVAR(CurrentObject).Value);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLVARValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLVAR(CurrentObject).Value:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__TIBXSQLDACreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBXSQLDAClass(CurrentClass.ClassRef).Create(TIBSQL(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__TIBXSQLDADestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLDA(CurrentObject).Destroy;
  end;
end;

procedure TatIBSQLLibrary.__TIBXSQLDAAddName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLDA(CurrentObject).AddName(GetInputArg(0),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatIBSQLLibrary.__TIBXSQLDAByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBXSQLDA(CurrentObject).ByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLDACount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBXSQLDA(CurrentObject).Count));
  end;
end;

procedure TatIBSQLLibrary.__SetTIBXSQLDACount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBXSQLDA(CurrentObject).Count:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLDAModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLDA(CurrentObject).Modified);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLDANames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLDA(CurrentObject).Names);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLDARecordSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBXSQLDA(CurrentObject).RecordSize));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLDAVars(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBXSQLDA(CurrentObject).Vars[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBXSQLDAUniqueRelationName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBXSQLDA(CurrentObject).UniqueRelationName);
  end;
end;

procedure TatIBSQLLibrary.__TIBBatchReadyFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBatch(CurrentObject).ReadyFile;
  end;
end;

procedure TatIBSQLLibrary.__GetTIBBatchColumns(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBatch(CurrentObject).Columns));
  end;
end;

procedure TatIBSQLLibrary.__SetTIBBatchColumns(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBatch(CurrentObject).Columns:=TIBXSQLDA(Integer(GetInputArg(0)));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBBatchFilename(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBBatch(CurrentObject).Filename);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBBatchFilename(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBatch(CurrentObject).Filename:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBBatchParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBatch(CurrentObject).Params));
  end;
end;

procedure TatIBSQLLibrary.__SetTIBBatchParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBatch(CurrentObject).Params:=TIBXSQLDA(Integer(GetInputArg(0)));
  end;
end;

procedure TatIBSQLLibrary.__TIBBatchInputReadParameters(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBBatchInput(CurrentObject).ReadParameters;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__TIBBatchOutputWriteColumns(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBBatchOutput(CurrentObject).WriteColumns;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__TIBOutputDelimitedFileDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBOutputDelimitedFile(CurrentObject).Destroy;
  end;
end;

procedure TatIBSQLLibrary.__TIBOutputDelimitedFileReadyFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBOutputDelimitedFile(CurrentObject).ReadyFile;
  end;
end;

procedure TatIBSQLLibrary.__TIBOutputDelimitedFileWriteColumns(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBOutputDelimitedFile(CurrentObject).WriteColumns;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBOutputDelimitedFileColDelimiter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBOutputDelimitedFile(CurrentObject).ColDelimiter);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBOutputDelimitedFileColDelimiter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBOutputDelimitedFile(CurrentObject).ColDelimiter:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBOutputDelimitedFileOutputTitles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBOutputDelimitedFile(CurrentObject).OutputTitles);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBOutputDelimitedFileOutputTitles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBOutputDelimitedFile(CurrentObject).OutputTitles:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBOutputDelimitedFileRowDelimiter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBOutputDelimitedFile(CurrentObject).RowDelimiter);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBOutputDelimitedFileRowDelimiter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBOutputDelimitedFile(CurrentObject).RowDelimiter:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__TIBInputDelimitedFileDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBInputDelimitedFile(CurrentObject).Destroy;
  end;
end;

procedure TatIBSQLLibrary.__TIBInputDelimitedFileGetColumn(AMachine: TatVirtualMachine);
  var
  Param0: string;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TIBInputDelimitedFile(CurrentObject).GetColumn(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatIBSQLLibrary.__TIBInputDelimitedFileReadParameters(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBInputDelimitedFile(CurrentObject).ReadParameters;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__TIBInputDelimitedFileReadyFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBInputDelimitedFile(CurrentObject).ReadyFile;
  end;
end;

procedure TatIBSQLLibrary.__GetTIBInputDelimitedFileColDelimiter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBInputDelimitedFile(CurrentObject).ColDelimiter);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBInputDelimitedFileColDelimiter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBInputDelimitedFile(CurrentObject).ColDelimiter:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBInputDelimitedFileReadBlanksAsNull(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBInputDelimitedFile(CurrentObject).ReadBlanksAsNull);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBInputDelimitedFileReadBlanksAsNull(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBInputDelimitedFile(CurrentObject).ReadBlanksAsNull:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBInputDelimitedFileRowDelimiter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBInputDelimitedFile(CurrentObject).RowDelimiter);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBInputDelimitedFileRowDelimiter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBInputDelimitedFile(CurrentObject).RowDelimiter:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBInputDelimitedFileSkipTitles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBInputDelimitedFile(CurrentObject).SkipTitles);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBInputDelimitedFileSkipTitles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBInputDelimitedFile(CurrentObject).SkipTitles:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__TIBOutputRawFileDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBOutputRawFile(CurrentObject).Destroy;
  end;
end;

procedure TatIBSQLLibrary.__TIBOutputRawFileReadyFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBOutputRawFile(CurrentObject).ReadyFile;
  end;
end;

procedure TatIBSQLLibrary.__TIBOutputRawFileWriteColumns(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBOutputRawFile(CurrentObject).WriteColumns;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__TIBInputRawFileDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBInputRawFile(CurrentObject).Destroy;
  end;
end;

procedure TatIBSQLLibrary.__TIBInputRawFileReadParameters(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBInputRawFile(CurrentObject).ReadParameters;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__TIBInputRawFileReadyFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBInputRawFile(CurrentObject).ReadyFile;
  end;
end;

procedure TatIBSQLLibrary.__TIBOutputXMLWriteXML(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBOutputXML(CurrentObject).WriteXML(TIBSQL(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBOutputXMLHeaderTag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBOutputXML(CurrentObject).HeaderTag);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBOutputXMLHeaderTag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBOutputXML(CurrentObject).HeaderTag:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBOutputXMLDatabaseTag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBOutputXML(CurrentObject).DatabaseTag);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBOutputXMLDatabaseTag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBOutputXML(CurrentObject).DatabaseTag:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBOutputXMLStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBOutputXML(CurrentObject).Stream));
  end;
end;

procedure TatIBSQLLibrary.__SetTIBOutputXMLStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBOutputXML(CurrentObject).Stream:=TStream(Integer(GetInputArg(0)));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBOutputXMLTableTag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBOutputXML(CurrentObject).TableTag);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBOutputXMLTableTag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBOutputXML(CurrentObject).TableTag:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBOutputXMLRowTag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBOutputXML(CurrentObject).RowTag);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBOutputXMLRowTag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBOutputXML(CurrentObject).RowTag:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBOutputXMLFlags(AMachine: TatVirtualMachine);
var
PropValueSet: TIBXMLFlags;
begin
  with AMachine do
  begin
    PropValueSet := TIBOutputXML(CurrentObject).Flags;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatIBSQLLibrary.__SetTIBOutputXMLFlags(AMachine: TatVirtualMachine);
  var
  TempVar: TIBXMLFlags;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TIBOutputXML(CurrentObject).Flags:=TempVar;
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBSQLClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSQL(CurrentObject).Destroy;
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLBatchInput(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSQL(CurrentObject).BatchInput(TIBBatchInput(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLBatchOutput(AMachine: TatVirtualMachine);
  var
  Param0: TIBBatchOutput;
begin
  with AMachine do
  begin
Param0 := TIBBatchOutput(Integer(GetInputArg(0)));
    TIBSQL(CurrentObject).BatchOutput(Param0);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLCall(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBSQL(CurrentObject).Call(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLCheckClosed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSQL(CurrentObject).CheckClosed;
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLCheckOpen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSQL(CurrentObject).CheckOpen;
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLCheckValidStatement(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSQL(CurrentObject).CheckValidStatement;
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSQL(CurrentObject).Close;
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLCurrent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBSQL(CurrentObject).Current);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLExecQuery(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSQL(CurrentObject).ExecQuery;
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLFieldByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBSQL(CurrentObject).FieldByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLFreeHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSQL(CurrentObject).FreeHandle;
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLNext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBSQL(CurrentObject).Next);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLPrepare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSQL(CurrentObject).Prepare;
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLGetUniqueRelationName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBSQL(CurrentObject).GetUniqueRelationName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__TIBSQLParamByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBSQL(CurrentObject).ParamByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBSQLBof(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBSQL(CurrentObject).Bof);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBSQLEof(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBSQL(CurrentObject).Eof);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBSQLFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBSQL(CurrentObject).Fields[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBSQLFieldIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBSQL(CurrentObject).FieldIndex[GetArrayIndex(0)]));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBSQLOpen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBSQL(CurrentObject).Open);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBSQLParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBSQL(CurrentObject).Params));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBSQLPlan(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBSQL(CurrentObject).Plan);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBSQLPrepared(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBSQL(CurrentObject).Prepared);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBSQLRecordCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBSQL(CurrentObject).RecordCount));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBSQLRowsAffected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBSQL(CurrentObject).RowsAffected));
  end;
end;

procedure TatIBSQLLibrary.__GetTIBSQLSQLType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBSQL(CurrentObject).SQLType);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBSQLGenerateParamNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBSQL(CurrentObject).GenerateParamNames);
  end;
end;

procedure TatIBSQLLibrary.__SetTIBSQLGenerateParamNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSQL(CurrentObject).GenerateParamNames:=GetInputArg(0);
  end;
end;

procedure TatIBSQLLibrary.__GetTIBSQLUniqueRelationName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBSQL(CurrentObject).UniqueRelationName);
  end;
end;

procedure TatIBSQLLibrary.__OutputXML(AMachine: TatVirtualMachine);
  var
  Param1: TIBOutputXML;
begin
  with AMachine do
  begin
Param1 := TIBOutputXML(Integer(GetInputArg(1)));
    IBSQL.OutputXML(TIBSQL(Integer(GetInputArg(0))),Param1);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatIBSQLLibrary.Init;
begin
  With Scripter.DefineClass(TIBXSQLVAR) do
  begin
    DefineMethod('Create',2,tkClass,TIBXSQLVAR,__TIBXSQLVARCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TIBXSQLVARAssign,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TIBXSQLVARLoadFromFile,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TIBXSQLVARLoadFromStream,false,0);
    DefineMethod('SaveToFile',1,tkNone,nil,__TIBXSQLVARSaveToFile,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TIBXSQLVARSaveToStream,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TIBXSQLVARClear,false,0);
    DefineProp('AsDate',tkVariant,__GetTIBXSQLVARAsDate,__SetTIBXSQLVARAsDate,nil,false,0);
    DefineProp('AsTime',tkVariant,__GetTIBXSQLVARAsTime,__SetTIBXSQLVARAsTime,nil,false,0);
    DefineProp('AsDateTime',tkVariant,__GetTIBXSQLVARAsDateTime,__SetTIBXSQLVARAsDateTime,nil,false,0);
    DefineProp('AsDouble',tkVariant,__GetTIBXSQLVARAsDouble,__SetTIBXSQLVARAsDouble,nil,false,0);
    DefineProp('AsFloat',tkVariant,__GetTIBXSQLVARAsFloat,__SetTIBXSQLVARAsFloat,nil,false,0);
    DefineProp('AsCurrency',tkVariant,__GetTIBXSQLVARAsCurrency,__SetTIBXSQLVARAsCurrency,nil,false,0);
    DefineProp('AsInt64',tkVariant,__GetTIBXSQLVARAsInt64,__SetTIBXSQLVARAsInt64,nil,false,0);
    DefineProp('AsInteger',tkInteger,__GetTIBXSQLVARAsInteger,__SetTIBXSQLVARAsInteger,nil,false,0);
    DefineProp('AsLong',tkInteger,__GetTIBXSQLVARAsLong,__SetTIBXSQLVARAsLong,nil,false,0);
    DefineProp('AsQuad',tkVariant,__GetTIBXSQLVARAsQuad,__SetTIBXSQLVARAsQuad,nil,false,0);
    DefineProp('AsShort',tkInteger,__GetTIBXSQLVARAsShort,__SetTIBXSQLVARAsShort,nil,false,0);
    DefineProp('AsString',tkVariant,__GetTIBXSQLVARAsString,__SetTIBXSQLVARAsString,nil,false,0);
    DefineProp('AsTrimString',tkVariant,__GetTIBXSQLVARAsTrimString,__SetTIBXSQLVARAsTrimString,nil,false,0);
    DefineProp('AsVariant',tkVariant,__GetTIBXSQLVARAsVariant,__SetTIBXSQLVARAsVariant,nil,false,0);
    DefineProp('IsNull',tkVariant,__GetTIBXSQLVARIsNull,__SetTIBXSQLVARIsNull,nil,false,0);
    DefineProp('IsNullable',tkVariant,__GetTIBXSQLVARIsNullable,__SetTIBXSQLVARIsNullable,nil,false,0);
    DefineProp('Index',tkInteger,__GetTIBXSQLVARIndex,nil,nil,false,0);
    DefineProp('Modified',tkVariant,__GetTIBXSQLVARModified,__SetTIBXSQLVARModified,nil,false,0);
    DefineProp('Name',tkVariant,__GetTIBXSQLVARName,nil,nil,false,0);
    DefineProp('Size',tkInteger,__GetTIBXSQLVARSize,nil,nil,false,0);
    DefineProp('SQLType',tkInteger,__GetTIBXSQLVARSQLType,nil,nil,false,0);
    DefineProp('Value',tkVariant,__GetTIBXSQLVARValue,__SetTIBXSQLVARValue,nil,false,0);
  end;
  With Scripter.DefineClass(TIBXSQLDA) do
  begin
    DefineMethod('Create',1,tkClass,TIBXSQLDA,__TIBXSQLDACreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBXSQLDADestroy,false,0);
    DefineMethod('AddName',2,tkNone,nil,__TIBXSQLDAAddName,false,0);
    DefineMethod('ByName',1,tkClass,TIBXSQLVAR,__TIBXSQLDAByName,false,0);
    DefineProp('Count',tkInteger,__GetTIBXSQLDACount,__SetTIBXSQLDACount,nil,false,0);
    DefineProp('Modified',tkVariant,__GetTIBXSQLDAModified,nil,nil,false,0);
    DefineProp('Names',tkVariant,__GetTIBXSQLDANames,nil,nil,false,0);
    DefineProp('RecordSize',tkInteger,__GetTIBXSQLDARecordSize,nil,nil,false,0);
    DefaultProperty := DefineProp('Vars',tkClass,__GetTIBXSQLDAVars,nil,TIBXSQLVAR,false,1);
    DefineProp('UniqueRelationName',tkVariant,__GetTIBXSQLDAUniqueRelationName,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TIBBatch) do
  begin
    DefineMethod('ReadyFile',0,tkNone,nil,__TIBBatchReadyFile,false,0);
    DefineProp('Columns',tkClass,__GetTIBBatchColumns,__SetTIBBatchColumns,TIBXSQLDA,false,0);
    DefineProp('Filename',tkVariant,__GetTIBBatchFilename,__SetTIBBatchFilename,nil,false,0);
    DefineProp('Params',tkClass,__GetTIBBatchParams,__SetTIBBatchParams,TIBXSQLDA,false,0);
  end;
  With Scripter.DefineClass(TIBBatchInput) do
  begin
    DefineMethod('ReadParameters',0,tkVariant,nil,__TIBBatchInputReadParameters,false,0);
  end;
  With Scripter.DefineClass(TIBBatchOutput) do
  begin
    DefineMethod('WriteColumns',0,tkVariant,nil,__TIBBatchOutputWriteColumns,false,0);
  end;
  With Scripter.DefineClass(TIBOutputDelimitedFile) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TIBOutputDelimitedFileDestroy,false,0);
    DefineMethod('ReadyFile',0,tkNone,nil,__TIBOutputDelimitedFileReadyFile,false,0);
    DefineMethod('WriteColumns',0,tkVariant,nil,__TIBOutputDelimitedFileWriteColumns,false,0);
    DefineProp('ColDelimiter',tkVariant,__GetTIBOutputDelimitedFileColDelimiter,__SetTIBOutputDelimitedFileColDelimiter,nil,false,0);
    DefineProp('OutputTitles',tkVariant,__GetTIBOutputDelimitedFileOutputTitles,__SetTIBOutputDelimitedFileOutputTitles,nil,false,0);
    DefineProp('RowDelimiter',tkVariant,__GetTIBOutputDelimitedFileRowDelimiter,__SetTIBOutputDelimitedFileRowDelimiter,nil,false,0);
  end;
  With Scripter.DefineClass(TIBInputDelimitedFile) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TIBInputDelimitedFileDestroy,false,0);
    DefineMethod('GetColumn',1,tkInteger,nil,__TIBInputDelimitedFileGetColumn,false,0).SetVarArgs([0]);
    DefineMethod('ReadParameters',0,tkVariant,nil,__TIBInputDelimitedFileReadParameters,false,0);
    DefineMethod('ReadyFile',0,tkNone,nil,__TIBInputDelimitedFileReadyFile,false,0);
    DefineProp('ColDelimiter',tkVariant,__GetTIBInputDelimitedFileColDelimiter,__SetTIBInputDelimitedFileColDelimiter,nil,false,0);
    DefineProp('ReadBlanksAsNull',tkVariant,__GetTIBInputDelimitedFileReadBlanksAsNull,__SetTIBInputDelimitedFileReadBlanksAsNull,nil,false,0);
    DefineProp('RowDelimiter',tkVariant,__GetTIBInputDelimitedFileRowDelimiter,__SetTIBInputDelimitedFileRowDelimiter,nil,false,0);
    DefineProp('SkipTitles',tkVariant,__GetTIBInputDelimitedFileSkipTitles,__SetTIBInputDelimitedFileSkipTitles,nil,false,0);
  end;
  With Scripter.DefineClass(TIBOutputRawFile) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TIBOutputRawFileDestroy,false,0);
    DefineMethod('ReadyFile',0,tkNone,nil,__TIBOutputRawFileReadyFile,false,0);
    DefineMethod('WriteColumns',0,tkVariant,nil,__TIBOutputRawFileWriteColumns,false,0);
  end;
  With Scripter.DefineClass(TIBInputRawFile) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TIBInputRawFileDestroy,false,0);
    DefineMethod('ReadParameters',0,tkVariant,nil,__TIBInputRawFileReadParameters,false,0);
    DefineMethod('ReadyFile',0,tkNone,nil,__TIBInputRawFileReadyFile,false,0);
  end;
  With Scripter.DefineClass(TIBOutputXML) do
  begin
    DefineMethod('WriteXML',1,tkNone,nil,__TIBOutputXMLWriteXML,false,0);
    DefineProp('HeaderTag',tkVariant,__GetTIBOutputXMLHeaderTag,__SetTIBOutputXMLHeaderTag,nil,false,0);
    DefineProp('DatabaseTag',tkVariant,__GetTIBOutputXMLDatabaseTag,__SetTIBOutputXMLDatabaseTag,nil,false,0);
    DefineProp('Stream',tkClass,__GetTIBOutputXMLStream,__SetTIBOutputXMLStream,TStream,false,0);
    DefineProp('TableTag',tkVariant,__GetTIBOutputXMLTableTag,__SetTIBOutputXMLTableTag,nil,false,0);
    DefineProp('RowTag',tkVariant,__GetTIBOutputXMLRowTag,__SetTIBOutputXMLRowTag,nil,false,0);
    DefineProp('Flags',tkInteger,__GetTIBOutputXMLFlags,__SetTIBOutputXMLFlags,nil,false,0);
  end;
  With Scripter.DefineClass(TIBSQL) do
  begin
    DefineMethod('Create',1,tkClass,TIBSQL,__TIBSQLCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBSQLDestroy,false,0);
    DefineMethod('BatchInput',1,tkNone,nil,__TIBSQLBatchInput,false,0);
    DefineMethod('BatchOutput',1,tkNone,nil,__TIBSQLBatchOutput,false,0).SetVarArgs([0]);
    DefineMethod('Call',2,tkInteger,nil,__TIBSQLCall,false,0);
    DefineMethod('CheckClosed',0,tkNone,nil,__TIBSQLCheckClosed,false,0);
    DefineMethod('CheckOpen',0,tkNone,nil,__TIBSQLCheckOpen,false,0);
    DefineMethod('CheckValidStatement',0,tkNone,nil,__TIBSQLCheckValidStatement,false,0);
    DefineMethod('Close',0,tkNone,nil,__TIBSQLClose,false,0);
    DefineMethod('Current',0,tkClass,TIBXSQLDA,__TIBSQLCurrent,false,0);
    DefineMethod('ExecQuery',0,tkNone,nil,__TIBSQLExecQuery,false,0);
    DefineMethod('FieldByName',1,tkClass,TIBXSQLVAR,__TIBSQLFieldByName,false,0);
    DefineMethod('FreeHandle',0,tkNone,nil,__TIBSQLFreeHandle,false,0);
    DefineMethod('Next',0,tkClass,TIBXSQLDA,__TIBSQLNext,false,0);
    DefineMethod('Prepare',0,tkNone,nil,__TIBSQLPrepare,false,0);
    DefineMethod('GetUniqueRelationName',0,tkVariant,nil,__TIBSQLGetUniqueRelationName,false,0);
    DefineMethod('ParamByName',1,tkClass,TIBXSQLVAR,__TIBSQLParamByName,false,0);
    DefineProp('Bof',tkVariant,__GetTIBSQLBof,nil,nil,false,0);
    DefineProp('Eof',tkVariant,__GetTIBSQLEof,nil,nil,false,0);
    DefineProp('Fields',tkClass,__GetTIBSQLFields,nil,TIBXSQLVAR,false,1);
    DefineProp('FieldIndex',tkInteger,__GetTIBSQLFieldIndex,nil,nil,false,1);
    DefineProp('Open',tkVariant,__GetTIBSQLOpen,nil,nil,false,0);
    DefineProp('Params',tkClass,__GetTIBSQLParams,nil,TIBXSQLDA,false,0);
    DefineProp('Plan',tkVariant,__GetTIBSQLPlan,nil,nil,false,0);
    DefineProp('Prepared',tkVariant,__GetTIBSQLPrepared,nil,nil,false,0);
    DefineProp('RecordCount',tkInteger,__GetTIBSQLRecordCount,nil,nil,false,0);
    DefineProp('RowsAffected',tkInteger,__GetTIBSQLRowsAffected,nil,nil,false,0);
    DefineProp('SQLType',tkEnumeration,__GetTIBSQLSQLType,nil,nil,false,0);
    DefineProp('GenerateParamNames',tkVariant,__GetTIBSQLGenerateParamNames,__SetTIBSQLGenerateParamNames,nil,false,0);
    DefineProp('UniqueRelationName',tkVariant,__GetTIBSQLUniqueRelationName,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('OutputXML',2,tkNone,nil,__OutputXML,false,0).SetVarArgs([1]);
    AddConstant('xmlAttribute',xmlAttribute);
    AddConstant('xmlDisplayNull',xmlDisplayNull);
    AddConstant('xmlNoHeader',xmlNoHeader);
    AddConstant('SQLUnknown',SQLUnknown);
    AddConstant('SQLSelect',SQLSelect);
    AddConstant('SQLInsert',SQLInsert);
    AddConstant('SQLUpdate',SQLUpdate);
    AddConstant('SQLDelete',SQLDelete);
    AddConstant('SQLDDL',SQLDDL);
    AddConstant('SQLGetSegment',SQLGetSegment);
    AddConstant('SQLPutSegment',SQLPutSegment);
    AddConstant('SQLExecProcedure',SQLExecProcedure);
    AddConstant('SQLStartTransaction',SQLStartTransaction);
    AddConstant('SQLCommit',SQLCommit);
    AddConstant('SQLRollback',SQLRollback);
    AddConstant('SQLSelectForUpdate',SQLSelectForUpdate);
    AddConstant('SQLSetGenerator',SQLSetGenerator);
  end;
end;

class function TatIBSQLLibrary.LibraryName: string;
begin
  result := 'IBSQL';
end;

initialization
  RegisterScripterLibrary(TatIBSQLLibrary, True);

{$WARNINGS ON}

end.

