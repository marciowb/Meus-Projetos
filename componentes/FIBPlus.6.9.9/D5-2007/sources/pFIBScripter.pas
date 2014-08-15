{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ InterBase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2007 Devrace Ltd.                       }
{    Written by Serge Buzadzhy (buzz@devrace.com)               }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page: http://www.fibplus.com/                 }
{    FIBPlus support  : http://www.devrace.com/support/         }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}

unit pFIBScripter;

interface
{$I FIBPlus.inc}
{$IFDEF D6+}
{$A2}
{$ENDIF}
 uses SysUtils,Classes{$IFDEF D6+},Types{$ENDIF}
  ,pFIBDatabase,pFIBQuery,FIBQuery,fib
 ;

//{$DEFINE BEZBAZY}
type
  TStmtType = (sUnknown,sInvalid,sDML,
     sConnect, sDisconnect, sReconnect,
     sCreateDatabase,sDropDatabase,
     sCommit, sRollBack,
     sCreate, sAlter,sRecreate, sDrop,  sSet, sSetGenerator,sSetStatistics,sDescribe,sDeclare,
     sComment,sGrant,sRunFromFile,sBatch {Temp Type},sBatchStart,sBatchExecute, sExecute
    );
  TObjectType =
    (otNone,otDatabase,otDomain,otTable,otView,otProcedure,otTrigger,
     otFunction,otException,otGenerator,otIndex,
     otConstraint,  otFilter,otField,otParameter,otRole,otBlock
    );

  TStmtCoord=record
   X: Word;
   Y: Integer;
  end;
  PStmtCoord=^TStmtCoord;

  TStatementDesc = record
    smdBegin:TStmtCoord;
    smdEnd  :TStmtCoord;
    smtType :TStmtType;
    objType :TObjectType;
    objName :string;
//    NoValid :boolean;
  end;
  PStatementDesc=^TStatementDesc;

  TScriptMap= array of TStatementDesc;


  TOnParseStmt = procedure(Sender: TObject;StatementNo: Integer; Coord:TStatementDesc;
   SQLText:TStrings) of object;




  TpFIBScriptParser = class
  private
    FScript:TStrings;
    FTemp  :TStrings;
    FCurDBName:string;
    FMakeConnectInScript:boolean;
    FHaveDMLStatements   :boolean;
    FHaveUnknownStatements:boolean;

    function  NextTokenPos(TokenPos:TStmtCoord; EndCoord:TStmtCoord ):TStmtCoord;
    function  GetToken(TokenPos:TStmtCoord;IgnoreQuote:boolean=True):string;
    procedure SearchObjectType(var stmtDesc:TStatementDesc;var BegSearch:TStmtCoord;ForGrant:boolean=False);
    function  ValidateStatement(var stmtDesc:TStatementDesc;const NeedCheckCanEnd:boolean ):boolean; // Показывает можно ли завершать стэйтмент
    function  StmtTypeNameToType(const TestString:string; Position:integer):TStmtType;
    function  TypeNameToObjectType(const TestString:string; Position:integer):TObjectType;
  public
   constructor Create;
   destructor  Destroy; override;
   procedure ParseScript(AScript:TStrings;var Terminator:Char;
     var FScriptMap:TScriptMap; IgnoreLastTerm:boolean=True
   );

  end;


  TOnStatementExecute = procedure(Sender: TObject;Line:Integer; StatementNo: Integer;  Desc:TStatementDesc;
    Statement: TStrings) of object;
  TOnSQLScriptExecError = procedure(Sender: TObject; StatementNo: Integer;
    Line:Integer; Statement: TStrings; SQLCode: Integer; const Msg: string;
    var doRollBack:boolean;  var Stop: Boolean) of object;

  TDynStringArray= array of string;
  
  TpFIBScripter=class(TComponent)
  private
     FPrepared:boolean;
     FMakeConnectInScript:boolean;
     FParser:TpFIBScriptParser;
     FScript:TStrings;
     FScriptMap:TScriptMap;
     FLineCountInFile:integer;
     procedure SetScript(const Value: TStrings);
     procedure DoOnChangeScript(Sender: TObject);
  private
     FDatabase   :TpFIBDatabase;
     FTransaction:TpFIBTransaction;
     FQuery      :TpFIBQuery;
     FPaused     :Boolean;
     FStopStatementNo:integer;
     FSQLDialect :integer;
     FLibraryName:string;
     FCharSet    :string;
     FAutoDDL    :boolean;
     FBlobFile   :string;
     FBlobFileStream:TFileStream;
     vInternalDatabase:boolean;
     FExternalTransaction:TpFIBTransaction;
     FHaveDMLStatements   :boolean;
     FHaveUnknownStatements:boolean;
     FNeedRestoreForceWrite:boolean;
  private
     FOnExecuteError:TOnSQLScriptExecError;
     FBeforeStatementExecute:TOnStatementExecute;
     FAfterStatementExecute :TOnStatementExecute;
     procedure SetDatabase(const Value: TpFIBDatabase);
     procedure SetTransaction(const Value: TpFIBTransaction);
     function  GetTransaction:TpFIBTransaction;
     procedure DoReconnect;
     procedure SetConnectParams(StartToken:TStmtCoord;EndCoord:TStmtCoord);
     procedure TryFillBlobParams;
  private
  //IB2007
      FInBatchCollect:boolean;
      FBatchSQLs :TDynStringArray;
  protected
      procedure Notification(AComponent: TComponent;
       Operation: TOperation); override;
      procedure CreateInternalDatabase;
      procedure CopyFragment(BegPos,EndPos:TStmtCoord;Dest:TStrings);
      procedure DoQueryExecute(SQL:TStrings;ParamValues:array of variant);
  public
     constructor Create(AOwner:TComponent); override;
     destructor  Destroy;override;
     procedure   Parse(Terminator:Char=';');
     procedure   ExecuteScript(FromStmt:integer=1);
     procedure   ExecuteFromFile(const FileName: string;Terminator:Char=';');
     procedure   ExecuteStatement(StmtTxt:TStrings;stmt:PStatementDesc;StmtNo:integer;
      TmpSQL:TStrings=nil;LineInFile:integer=-1
     );
     procedure   ClearPrepared;
     function    StatementsCount:integer;
     function    GetStatement(StmtNo:integer;Text:TStrings):PStatementDesc;
     function    LineCountInCurrentFile:integer;

     property    Prepared:boolean read FPrepared;
     property    StopStatementNo:Integer read FStopStatementNo;
     property    Query:TpFIBQuery read FQuery;
     property    MakeConnectInScript:boolean read FMakeConnectInScript;

     property Paused: Boolean read FPaused write FPaused;
  published
     property Script:TStrings read FScript write SetScript;
     property Database:TpFIBDatabase read FDatabase write SetDatabase;
     property Transaction: TpFIBTransaction read FExternalTransaction write SetTransaction;
     property OnExecuteError:TOnSQLScriptExecError
       read FOnExecuteError write FOnExecuteError;
     property AutoDDL :boolean read FAutoDDL write FAutoDDL default True;
     property BeforeStatementExecute:TOnStatementExecute read FBeforeStatementExecute write
      FBeforeStatementExecute;
     property AfterStatementExecute:TOnStatementExecute read FAfterStatementExecute write
      FAfterStatementExecute      ;

  end;


implementation
uses  StrUtil,SqlTxtRtns,StdFuncs;
{ TpFIBScripter }
type
   TParseDisposition= (pdBetweenStatements,pdInStatement);
   TParserState =(psNormal,psInComment,psInFBComment,psInQuote,psInDoubleQuote);


function StmtCoord(X:Word;Y:Integer):TStmtCoord;
begin
  Result.X := X;
  Result.Y := Y;
end;


function IsClause( const EtalonClause:string; const Source:string;
 Position:integer
):boolean;
 // 1 аргумент обязан быть написан в uppercase. Это эталон
var
  Len:Integer;
  LenEtalon:Byte;
  pSource:PChar;
  pEtalon:PChar;
  pEtalon1:PChar;
begin
 Len:=Length(Source);
 LenEtalon:=Length(EtalonClause);
 if Len-Position+1<LenEtalon then
   Result:=False
 else
 begin
    pSource:=Pointer(Source);
    Inc(pSource,Position-1);
    pEtalon:=Pointer(EtalonClause);
    pEtalon1:=Pointer(EtalonClause);
    Inc(pEtalon1,LenEtalon);
    Result:=True;
    while (pEtalon<>pEtalon1) do
    begin
      if pSource^<>pEtalon^ then
      begin
        // все что не между 'a'..'z' должно отсеяться на пред проверке
          if Byte(pSource^)-32<>Byte(pEtalon^) then
          begin
            Result:=False;
            Break;
          end;
      end;
      Inc(pSource);
      Inc(pEtalon);
    end;
    if Result and (Len-Position>=LenEtalon) then
      Result:=Source[Position+LenEtalon] in [' ',#13,#9,#10,'/','-',';','^',',']
 end
end;

procedure TpFIBScripter.ClearPrepared;
begin
 SetLength(FScriptMap,0);
 FPrepared:=False;
end;

procedure TpFIBScripter.CopyFragment(BegPos, EndPos: TStmtCoord;
  Dest: TStrings);
var
 y1:Integer;
 L:Word;
 CurStr:String;
begin
  if Assigned(Dest) then
  begin
    Dest.Clear;
    if (EndPos.X=0) and (FScript.Count>0) then
    begin
    // Нет завершающего терма
     EndPos.Y:=FScript.Count-1;
     EndPos.X:=Length(FScript[FScript.Count-1])
    end;

    for y1:=BegPos.Y to EndPos.Y do
    begin
      CurStr:=FScript[y1];
      if y1=BegPos.Y then   // Первая строка
      begin
        if BegPos.Y=EndPos.Y then
         L:=EndPos.X-BegPos.X+1
        else
         L:=Length(CurStr)-BegPos.X+1;
        if L<>Length(CurStr) then
         Dest.Add(Copy(CurStr,BegPos.X,L))
        else
         Dest.Add(CurStr)
      end
      else
      if y1=EndPos.Y then   // последняя строка
      begin
         L:=EndPos.X;
        if L<>Length(CurStr) then
         Dest.Add(Copy(CurStr,1,L))
        else
         Dest.Add(CurStr)
      end
      else
         Dest.Add(CurStr)
    end;
  end;
end;

constructor TpFIBScripter.Create(AOwner:TComponent);
begin
  inherited;
  FScript:=TStringList.Create;
  TStringList(FScript).OnChanging:=DoOnChangeScript;
  FParser:=TpFIBScriptParser.Create;

  FTransaction:=TpFIBTransaction.Create(Self);
  FQuery      :=TpFIBQuery.Create(Self);
  FQuery.Transaction:=FTransaction;
  FSQLDialect:=3;
  FAutoDDL:=True;
  FBlobFileStream:=nil;
end;

procedure TpFIBScripter.CreateInternalDatabase;
begin
 if not Assigned(FDatabase) then
 begin
  Database:=TpFIBDatabase.Create(Self);
  vInternalDatabase:=True
 end 
end;

destructor TpFIBScripter.Destroy;
begin
  FParser.Free;
  FScript.Free;
  SetLength(FScriptMap,0);
  if Assigned(FBlobFileStream) then
   FBlobFileStream.Free;
  inherited;
end;

procedure TpFIBScripter.DoOnChangeScript(Sender: TObject);
begin
 ClearPrepared
end;

procedure TpFIBScripter.DoQueryExecute(SQL:TStrings;
  ParamValues: array of variant);
begin

end;

procedure TpFIBScripter.DoReconnect;
begin
  if Assigned(FDatabase) then
  begin
    if GetTransaction.InTransaction then
      GetTransaction.Commit;
    FDatabase.Connected := False;
    FDatabase.Connected := True
  end;
end;

{$IFNDEF D6+}
// Copy from SysUtils (D6+) 
function AnsiDequotedStr(const S: string; AQuote: Char): string;
var
  LText: PChar;
begin
  LText := PChar(S);
  Result := AnsiExtractQuotedStr(LText, AQuote);
  if Result = '' then
    Result := S;
end;
{$ENDIF}


procedure   TpFIBScripter.ExecuteStatement(StmtTxt:TStrings;stmt:PStatementDesc;
 StmtNo:integer; TmpSQL:TStrings=nil;LineInFile:integer=-1);
var
   vToken:TStmtCoord;
   tmpStr:string;
   vIsInternalTmpSQL:boolean;
   doRollBack:boolean;
begin
 if stmt<>nil then
 begin
   if TmpSQL=nil then
   begin
    vIsInternalTmpSQL:=True;
    TmpSQL:=TStringList.Create;
   end
   else
    vIsInternalTmpSQL:=False;
   try
    if Assigned(FBeforeStatementExecute) then
     if LineInFile=-1 then
      FBeforeStatementExecute(Self,stmt.smdBegin.Y+1,StmtNo+1,stmt^,StmtTxt)
     else
     begin
      FBeforeStatementExecute(Self,LineInFile,StmtNo+1,stmt^,StmtTxt);
     end;
    case stmt.smtType of
     sCreateDatabase:
     begin
        CreateInternalDatabase;
        vToken:=FParser.NextTokenPos(stmt.smdBegin, stmt.smdEnd);
        vToken:=FParser.NextTokenPos(vToken, stmt.smdEnd);
        if FDatabase.Connected then
         FDatabase.Close;

        FDataBase.DBName:=FParser.GetToken(vToken);
        vToken:=FParser.NextTokenPos(vToken, stmt.smdEnd);
        CopyFragment(vToken,stmt.smdEnd,FDataBase.DBParams);        
        FDatabase.SQLDialect:=FSQLDialect;
{$IFNDEF BEZBAZY}
       try           
        FDatabase.CreateDatabase;
        if FDatabase.NeedUTFEncodeDDL// and (FHaveDMLStatements or FHaveUnknownStatements)
        then
        begin
{ TODO : 
Не очень понятно что делать. С одной стороны надо переконнектиться
С другой после переконнекта - тормоза }
          if FDatabase.FBAttachCharsetID=0 then
          begin
            FDatabase.Connected:=False;
            SetConnectParams(vToken,stmt.smdEnd);
            FDatabase.DBParams.Add('force_write=0');
            FNeedRestoreForceWrite:=True;
            FDatabase.Connected:=True;
          end
        end;
       except
          on E :EFIBError do
          begin
           if Assigned(FOnExecuteError) then
           begin
            FPaused:=True;
            FOnExecuteError(Self,StmtNo+1,stmt.smdBegin.Y+1,TmpSQL,E.SQLCode,E.Message,doRollBack,FPaused);
           end
           else
            raise;
          end;
       end
{$ENDIF}        
     end;
     sDropDatabase:
       FDatabase.DropDatabase;
     sDisconnect:
       FDatabase.Connected:=False;
     sConnect:
     begin
      CreateInternalDatabase;
      try
        if FDatabase.Connected then
         FDatabase.Close;
        vToken:=FParser.NextTokenPos(stmt.smdBegin, stmt.smdEnd);
        FDataBase.DBName:=FParser.GetToken(vToken);
        vToken:=FParser.NextTokenPos(vToken, stmt.smdEnd);
        SetConnectParams(vToken,stmt.smdEnd);
        FDatabase.Connected:=True
      except
        on E :EFIBError do
        begin
         if Assigned(FOnExecuteError) then
         begin
          FPaused:=True;
          FOnExecuteError(Self,StmtNo+1,stmt.smdBegin.Y+1,TmpSQL,E.SQLCode,E.Message,doRollBack,FPaused);
         end
         else
          raise;
        end;
      end
     end;
     sCommit:
      if GetTransaction.InTransaction then
      try
       GetTransaction.Commit;
      except
        on E :EFIBError do
        begin
         if Assigned(FOnExecuteError) then
         begin
          FPaused:=True;
          FOnExecuteError(Self,StmtNo+1,stmt.smdBegin.Y+1,TmpSQL,E.SQLCode,E.Message,doRollBack,FPaused);
          if GetTransaction.InTransaction then
            GetTransaction.RollBack
         end
         else
          raise;
        end;
      end;
     sRollBack:
      if GetTransaction.InTransaction then
        GetTransaction.Rollback;
     sSet:
     begin
      vToken:=FParser.NextTokenPos(stmt.smdBegin, stmt.smdEnd);
      if vToken.X>0 then
      begin
       tmpStr:=FParser.GetToken(vToken);
       if IsClause('AUTODDL',tmpStr,1) then
       begin
        vToken:=FParser.NextTokenPos(vToken, stmt.smdEnd);
        if (vToken.X>0) then
        begin
          tmpStr:=FParser.GetToken(vToken);
          if IsClause('ON',tmpStr,1) then
           FAutoDDL:=True
          else
          if IsClause('OFF',tmpStr,1) then
           FAutoDDL:=False
        end
       end
       else
       if IsClause('SQL',tmpStr,1) then
       begin
        vToken:=FParser.NextTokenPos(vToken, stmt.smdEnd);
        if (vToken.X>0) then
        begin
          tmpStr:=FParser.GetToken(vToken);
          if IsClause('DIALECT',tmpStr,1) then
          begin
           vToken:=FParser.NextTokenPos(vToken, stmt.smdEnd);
           if (vToken.X>0) then
           begin
            tmpStr:=FParser.GetToken(vToken);
            FSQLDialect:=StrToInt(tmpStr)
           end;
          end;
        end;
       end
       else
       if IsClause('NAMES',tmpStr,1) then
       begin
        vToken:=FParser.NextTokenPos(vToken, stmt.smdEnd);
        if (vToken.X>0) then
        begin
         FCharSet:=FParser.GetToken(vToken);
        end
       end
       else //CLIENTLIB
       if IsClause('CLIENTLIB',tmpStr,1) then
       begin
        vToken:=FParser.NextTokenPos(vToken, stmt.smdEnd);
        if vToken.X<>0 then
        begin
         tmpStr:=FParser.GetToken(vToken);
         FLibraryName:= FParser.GetToken(vToken);
        end
       end
       else
       if IsClause('BLOBFILE',tmpStr,1) then
       begin
        vToken:=FParser.NextTokenPos(vToken, stmt.smdEnd);
        if (vToken.X>0) then
        begin
         if Assigned(FBlobFileStream) then
         begin
          FBlobFileStream.Free;
          FBlobFileStream:=nil;
         end;
         FBlobFile:=FParser.GetToken(vToken);
        end
       end;
      end;
     end;
     sReconnect:
     begin
{$IFNDEF BEZBAZY}     
      DoReconnect;
{$ENDIF}
     end;
     sDescribe:
     begin
       vToken:=FParser.NextTokenPos(stmt.smdBegin, stmt.smdEnd);
       if (vToken.X>0) then
       begin
        tmpSQL.Clear;
        case stmt.objType of
         otDomain:
          tmpSQL.Add('UPDATE RDB$FIELDS SET RDB$DESCRIPTION = :DESCR WHERE (RDB$FIELD_NAME = :FIELD)');
         otView,otTable:
         begin
          tmpSQL.Add('UPDATE RDB$RELATIONS SET RDB$DESCRIPTION = :DESCR '+
           'WHERE RDB$RELATION_NAME = :TABNAME');
         end;
         otTrigger:
          tmpSQL.Add(
           'UPDATE RDB$TRIGGERS SET RDB$DESCRIPTION = :DESCR WHERE (RDB$TRIGGER_NAME = :TR_NAME)');
         otField:
          tmpSQL.Add('UPDATE RDB$RELATION_FIELDS SET RDB$DESCRIPTION = :DESCR '+
           'WHERE (RDB$RELATION_NAME = :TABNAME) and (RDB$FIELD_NAME = :FIELD)');
         otParameter:
          tmpSQL.Add('UPDATE RDB$PROCEDURE_PARAMETERS SET RDB$DESCRIPTION = :DESCR '+
           'WHERE (RDB$PROCEDURE_NAME = :PROCNAME) and(RDB$PARAMETER_NAME = :FIELD)');
         otProcedure:
           tmpSQL.Add('UPDATE RDB$PROCEDURES SET RDB$DESCRIPTION = :DESCR '+
            'WHERE (RDB$PROCEDURE_NAME = :PROCNAME)');
         otException:
           tmpSQL.Add('UPDATE RDB$EXCEPTIONS SET RDB$DESCRIPTION = :DESCR '+
            'WHERE (RDB$EXCEPTION_NAME = :EXC_NAME)');
         otFunction:
          tmpSQL.Add(
           'update RDB$FUNCTIONS set RDB$DESCRIPTION = ?DESC where (RDB$FUNCTION_NAME = ?FUNC_NAME)'
          );
         otGenerator:
          tmpSQL.Add(
           'update RDB$GENERATORS SET RDB$DESCRIPTION = ?DESC where (RDB$GENERATOR_NAME = ?GEN_NAME)'
          );
        else
         tmpStr:=FParser.GetToken(vToken) ;
         raise Exception.Create('Unsupported DESCRIBE type '+tmpStr) // Потом пометить как инвалида
        end;


        vToken:=FParser.NextTokenPos(vToken, stmt.smdEnd); // Имя  объекта;
        tmpStr:=FParser.GetToken(vToken) ; // Имя объекта;

        FQuery.SQL.Assign(tmpSQL);

        if stmt.objType in [otField,otParameter] then
        begin
         FQuery.Params[2].AsString:=tmpStr; // Имя поля.параметра;
         vToken:=FParser.NextTokenPos(vToken, stmt.smdEnd); // Имя типа хозяина;
         vToken:=FParser.NextTokenPos(vToken, stmt.smdEnd); // Имя  хозяина;
         FQuery.Params[1].AsString:=FParser.GetToken(vToken);
        end
        else
         FQuery.Params[1].AsString:=tmpStr; // Имя объекта;
         vToken:=FParser.NextTokenPos(vToken, stmt.smdEnd);

         CopyFragment(vToken,stmt.smdEnd,TmpSQL);
         FQuery.Params[0].AsString := AnsiDequotedStr(TmpSQL.Text,'''');
{$IFNDEF BEZBAZY}
         if not GetTransaction.InTransaction then
           GetTransaction.StartTransaction;
         FQuery.ExecQuery;
{$ENDIF}
       end;
     end;
     sRunFromFile:
     begin
       vToken:=FParser.NextTokenPos(stmt.smdBegin, stmt.smdEnd); // Имя файла
       tmpStr:=FParser.GetToken(vToken) ; // Имя файла;
       ExecuteFromFile(tmpStr)
     end;
    else
// Cчитаем что это обыкновенный SQL statement
     FQuery.SQL:=TmpSQL;
     try
{$IFNDEF BEZBAZY}
       if not GetTransaction.InTransaction then
        GetTransaction.StartTransaction;
       if Length(FBlobFile)>0 then
        if (FQuery.ParamCount>0) then
         TryFillBlobParams;
       FQuery.ExecQuery;
       if Assigned(FAfterStatementExecute) then
       begin
         if LineInFile=-1 then
          FAfterStatementExecute(Self,stmt.smdBegin.Y+1,StmtNo+1,stmt^,StmtTxt)
         else
         begin
          FAfterStatementExecute(Self,LineInFile,StmtNo+1,stmt^,StmtTxt);
         end;
       end;
       if FAutoDDL  and (FQuery.SQLKind=skDDL) then
        FQuery.Transaction.Commit;
{$ENDIF}        
     except
      on E :EFIBError do
      begin
       if Assigned(FOnExecuteError) then
       begin
        FPaused:=True;
        doRollBack:=True;
        FOnExecuteError(Self,StmtNo+1,stmt.smdBegin.Y+1,TmpSQL,E.SQLCode,E.Message,doRollBack,FPaused);
        if doRollBack then
          GetTransaction.Rollback;
       end
       else
        raise;
      end
     end;
    end;
   finally
    if vIsInternalTmpSQL then
     TmpSQL.Free
   end
end;
end;

procedure TpFIBScripter.ExecuteScript(FromStmt:integer=1);
var
   i:integer;
   sc:Integer;
   stmt:PStatementDesc;
   TmpSQL:TStrings;
begin
  FPaused:=False;
  if not FPrepared then
   Parse;

  FSQLDialect:=3;
  FCharSet   :='';
  TmpSQL:=TStringList.Create;
  try
    sc:=StatementsCount-1;
    for i:=FromStmt-1 to sc do
    begin
     if FPaused  then
     begin
      FStopStatementNo:=i+1;
      Exit;
     end;

     stmt:=GetStatement(i+1,TmpSQL);
     case stmt.smtType of
      sBatchStart:
      begin
       FInBatchCollect:=True;
       SetLength(FBatchSQLs,0)
      end;
      sBatchExecute:
      begin
       FInBatchCollect:=False;
       if not GetTransaction.InTransaction then
          GetTransaction.StartTransaction;

       if Assigned(FBeforeStatementExecute) then
        FBeforeStatementExecute(Self,stmt.smdBegin.Y+1,i+1,stmt^,nil);
 {$IFDEF SUPPORT_IB2007}
       FQuery.ExecuteAsBatch(FBatchSQLs);
 {$ELSE}
       raise
        Exception.Create('Batch execute support for IB2007 only');
 {$ENDIF}
       SetLength(FBatchSQLs,0)
      end
     else
      if not FInBatchCollect then
       ExecuteStatement(TmpSQL,stmt,i,TmpSQL)
      else
      begin
       SetLength(FBatchSQLs,Length(FBatchSQLs)+1);
       FBatchSQLs[Length(FBatchSQLs)-1]:=TmpSQL.Text;
      end
     end
    end;
  finally
   if FNeedRestoreForceWrite then
   begin
    Database.Connected:=False;
    Database.DBParams.Values['force_write']:='1';
    Database.Connected:=True;    
   end;

   if vInternalDatabase then
   begin
     if GetTransaction.InTransaction then
      GetTransaction.Commit;
     Database:=nil;
   end   ;



   TmpSQL.Free;
   if Assigned(FBlobFileStream) then
   begin
    FBlobFileStream.Free;
    FBlobFileStream:=nil;
   end;
  end;
end;

function TpFIBScripter.GetStatement(StmtNo: integer;
  Text: TStrings): PStatementDesc;
begin
  if StmtNo>Length(FScriptMap) then
   raise
     Exception.Create('Statement №'+IntToStr(StmtNo)+' don''t exist');
  Result:=@FScriptMap[StmtNo-1];
  CopyFragment(Result.smdBegin,Result.smdEnd,Text);
end;

procedure TpFIBScripter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FDatabase then
      FDatabase := nil
    else
    if AComponent = FExternalTransaction then
      FExternalTransaction:=nil;
  end;
end;

procedure TpFIBScripter.Parse(Terminator:Char=';');
begin
 FMakeConnectInScript:=False;
 FHaveDMLStatements    :=False;
 FHaveUnknownStatements:=False;
 FLibraryName   := 'gds32.dll';
 FParser.ParseScript(FScript,Terminator,FScriptMap);
 FPrepared:=True;

 FMakeConnectInScript:=FParser.FMakeConnectInScript;
 FHaveDMLStatements    :=FParser.FHaveDMLStatements;
 FHaveUnknownStatements:=FParser.FHaveUnknownStatements;
end;

procedure TpFIBScripter.SetDatabase(const Value: TpFIBDatabase);
begin
  if GetTransaction.InTransaction then
   GetTransaction.Commit;

  if Assigned(FDatabase) then
   if vInternalDatabase and
    ((Value=nil) or (Value.Owner<>Self)) then // Old database -  InternalDatabase
   begin
    FDatabase.Free;
    vInternalDatabase:=False;
   end;
  FDatabase := Value;
  if Assigned(FDatabase) then
    FreeNotification(FDatabase);
  FTransaction.DefaultDatabase:=FDatabase;
  if Assigned(FExternalTransaction) then
   FExternalTransaction.DefaultDatabase:=FDatabase;
  FQuery.Database:=FDatabase;
  FQuery.Transaction:=GetTransaction;  
end;

procedure TpFIBScripter.SetScript(const Value: TStrings);
begin
  FScript.Assign(Value);
end;


procedure TpFIBScripter.SetConnectParams(StartToken: TStmtCoord;EndCoord:TStmtCoord);
var
   vToken:TStmtCoord;
   tmpStr:String;
begin
      FDataBase.Connected:=False;
      FDataBase.DBParams.Clear; 
      vToken:=StartToken;
      while  (vToken.X<>0) do
      begin
       tmpStr:=FParser.GetToken(vToken);
       if IsClause('USER',tmpStr,1) then
       begin
        vToken:=FParser.NextTokenPos(vToken, EndCoord);
        if vToken.X<>0 then
         FDataBase.ConnectParams.UserName:=FParser.GetToken(vToken);
       end
       else
       if IsClause('PASSWORD',tmpStr,1) then
       begin
        vToken:=FParser.NextTokenPos(vToken, EndCoord);
        if vToken.X<>0 then
         FDataBase.ConnectParams.Password:=FParser.GetToken(vToken);
       end
       else
       if IsClause('ROLE',tmpStr,1) then
       begin
        vToken:=FParser.NextTokenPos(vToken, EndCoord);
        if vToken.X<>0 then
         FDataBase.ConnectParams.RoleName:=FParser.GetToken(vToken);
       end
       else
       if IsClause('SET',tmpStr,1) then
       begin
        vToken:=FParser.NextTokenPos(vToken, EndCoord);
        if vToken.X<>0 then
        begin
         tmpStr:=FParser.GetToken(vToken);
         if IsClause('CHARACTER',tmpStr,1) then
         begin
          vToken:=FParser.NextTokenPos(vToken, EndCoord);
          if vToken.X<>0 then
          begin
           tmpStr:=FParser.GetToken(vToken);
           FDataBase.ConnectParams.CharSet:=FParser.GetToken(vToken);
          end
         end
        end
       end;
       if vToken.X<>0 then
        vToken:=FParser.NextTokenPos(vToken, EndCoord);
      end;
      FDatabase.SQLDialect:=FSQLDialect;
      FDataBase.LibraryName:= FLibraryName;
      FDatabase.ConnectParams.CharSet:=FCharSet;
end;

function TpFIBScripter.StatementsCount: integer;
begin
 Result:=Length(FScriptMap)
end;

function  GetLineCountInFile(const FileName:string):integer;
var
  F: TextFile;
begin
  Result:=0;
  AssignFile(F, FileName);
  Reset(F);
  try
    repeat
      ReadLn(F);
      Inc(Result)
    until EOF(F);
  finally
    CloseFile(F);
  end;  
end;

procedure TpFIBScripter.ExecuteFromFile(const FileName: string;Terminator:Char=';');
var
  F: TextFile;
  S: string;
  vStatement: TStrings;
  FullScript:TStrings;
  Map:TScriptMap;
  i,j:integer;
  PredTerm:Char;
  vRunStatement:TStrings;
  MapIndex:integer;
begin
  FLineCountInFile:=GetLineCountInFile(FileName);
  FPaused:=False;
  AssignFile(F, FileName);
  Reset(F);
  vStatement:=TStringList.Create;
  vRunStatement:=TStringList.Create;
  FullScript:=FScript;
  i:=0; j:=0; S:='';
  try
    FParser.FScript:=vStatement;
    FScript:=vStatement;
    repeat
      if FPaused then
      begin
       FStopStatementNo:=i+1;
       Exit;
      end;
      if Length(S)>0 then
       vStatement.Add(S);
      ReadLn(F, S);
      vStatement.Add(S);
      S:='';
      Inc(j);
      PredTerm:=Terminator;
      FParser.ParseScript(vStatement,Terminator,Map,False);
      if (Length(Map)>=1) and (Map[0].smdEnd.X>0) then
      begin
       case Map[0].smtType of
        sBatchStart:
        begin
         vStatement.Clear;
         FInBatchCollect:=True;
         SetLength(FBatchSQLs,0)
        end;
        sBatchExecute:
        begin
         vStatement.Clear;
         FInBatchCollect:=False;
         if not GetTransaction.InTransaction then
            GetTransaction.StartTransaction;
         if Assigned(FBeforeStatementExecute) then
          FBeforeStatementExecute(Self,j,i+1,Map[0],nil);
 {$IFDEF SUPPORT_IB2007}
       FQuery.ExecuteAsBatch(FBatchSQLs);
       SetLength(Map,0);
 {$ELSE}
       raise
        Exception.Create('Batch execute support for IB2007 only');
 {$ENDIF}
         SetLength(FBatchSQLs,0)
        end
       else
          if not FInBatchCollect then
          begin
           MapIndex:=0;
           while MapIndex<Length(Map) do
           begin
            if (Map[MapIndex].smdEnd.X>0) then
            begin
             CopyFragment(Map[MapIndex].smdBegin,Map[MapIndex].smdEnd,vRunStatement);
             ExecuteStatement(vRunStatement,@Map[MapIndex],i,vRunStatement,j);
            end
            else
              S:=Copy(vStatement[vStatement.Count-1],Map[MapIndex].smdBegin.X,MaxInt);
            Inc(MapIndex)
           end;
           SetLength(Map,0)
          end
          else
          begin
           SetLength(FBatchSQLs,Length(FBatchSQLs)+1);
           FBatchSQLs[Length(FBatchSQLs)-1]:=vStatement.Text;
          end;
          vStatement.Clear;
       end;
       Inc(i)
      end
      else
      if Terminator<>PredTerm then // Просто смена терминатора
      begin
       vStatement.Clear;
       Inc(i)
      end;
    until EOF(F);
  finally
   CloseFile(F);

   FParser.FScript:=FullScript;
   FScript:=FullScript;

   vStatement.Free;
   vRunStatement.Free;

   if FNeedRestoreForceWrite then
   begin
    Database.Connected:=False;
    Database.DBParams.Values['force_write']:='1';
    Database.DBParams.Values['no_reserve']:='0';    
    Database.Connected:=True;
   end;
   
   if vInternalDatabase then
   begin
     if GetTransaction.InTransaction then
      GetTransaction.Commit;
     Database:=nil;
   end   ;

   if Assigned(FBlobFileStream) then
   begin
    FBlobFileStream.Free;
    FBlobFileStream:=nil;
   end;
  end;
end;

procedure TpFIBScripter.SetTransaction(const Value: TpFIBTransaction);
begin
  FExternalTransaction:= Value;
  FExternalTransaction.DefaultDatabase:=FDatabase;
  FQuery.Transaction:=FExternalTransaction;
end;

function TpFIBScripter.GetTransaction: TpFIBTransaction;
begin
 if Assigned(FExternalTransaction) then
  Result:=FExternalTransaction
 else
  Result:=FTransaction
end;

function TpFIBScripter.LineCountInCurrentFile: integer;
begin
 Result:=FLineCountInFile;
end;

{ TpFIBScriptParser }

 

procedure TpFIBScriptParser.ParseScript(AScript: TStrings;var Terminator:Char;
    var FScriptMap:TScriptMap;IgnoreLastTerm:boolean);
type TTermState=(ttNorma,ttMayBeChange,ttWaitChange);

var
   x,y:integer;
   pd:TParseDisposition;
   CurStr:String;
   lCurStr:integer;
   State:TParserState;
   TermState:TTermState;
   NewTerminator:Char;
   CurStmt:Integer;
   vCanEndStmt:boolean;

procedure FixBeginStatement;
var
 L:Integer;
begin
  Inc(CurStmt);
  pd:=pdInStatement;
  L:=Length(FScriptMap);
  if L<CurStmt then
  begin
   if L>64 then
    Inc(L,L div 4)
   else
   if L>8 then
    Inc(L,16)
   else
    Inc(L,4);
   SetLength(FScriptMap,L);
  end;
  FScriptMap[CurStmt-1].smdBegin:=StmtCoord(X,Y);
end;

var
 L:integer;

begin
  FCurDBName:='';
  NewTerminator:=Terminator;
  FScript:=AScript;
  TermState:=ttNorma;
  pd:=pdBetweenStatements;
  State:=psNormal;
  L:=FScript.Count div 16;
  if L<3 then
   L:=3;
  SetLength(FScriptMap,L);


  CurStmt:=0;
  vCanEndStmt:=True;
 try
  for y:=0 to Pred(FScript.Count) do
  begin
   CurStr:=FScript.Strings[y];
   lCurStr:=Length(CurStr);
    for x:=1 to lCurStr do
    case pd of
     pdBetweenStatements :
     case State of
      psNormal:
       case  CurStr[x] of
        '-': if (x<lCurStr) and (CurStr[x+1]='-') then
              Break // FBComment
             else
             begin
              FixBeginStatement;
              FScriptMap[CurStmt-1].smtType:=sInvalid;
             end;
        '/': if (x<lCurStr) and (CurStr[x+1]='*') then
              State:=psInComment
             else
             begin
              FixBeginStatement;
              FScriptMap[CurStmt-1].smtType:=sInvalid;
             end;
        ' ',#13,#10,#9: ;
        'S','s':// May be set
        if IsClause('SET',CurStr,x) then
        begin
          FixBeginStatement;
          TermState:=ttMayBeChange;
          FScriptMap[CurStmt-1].smtType:=sSet;
        end
        else
        begin
          FixBeginStatement;
          FScriptMap[CurStmt-1].smtType:=sUnknown;
        end
       else
        if CurStr[x]<>NewTerminator then
        begin
//Buzz 1        
          FixBeginStatement;
          FScriptMap[CurStmt-1].smtType:=sUnknown;
        end  
       end;
      psInComment:
         case  CurStr[x] of
          '/': if (x>1) and (CurStr[x-1]='*') then
                 State:=psNormal;
         end;
     end; // end case state
    pdInStatement:  //  case pd
     case State of
      psNormal:
         case CurStr[x] of
          '''':  State:=psInQuote;
          '"' :  State:=psInDoubleQuote;
          '-' : if (x<lCurStr) and (CurStr[x+1]='-') then
                 Break; // FBComment
          '/': if (x<lCurStr) and (CurStr[x+1]='*') then
              State:=psInComment;
          'T','t': if (TermState=ttMayBeChange) and IsClause('TERM',CurStr,x) then
                    TermState:=ttWaitChange;
         else
          if (TermState=ttWaitChange) and not (CurStr[x] in [' ',#13,#10,#9,Terminator]) then
          begin
           NewTerminator:=CurStr[x]
          end;
          if CurStr[x]=Terminator then
          begin
           if (TermState=ttWaitChange) then
           begin
             Terminator:=NewTerminator;
             TermState:=ttNorma;
             Dec(CurStmt) // Не хер термы вообще обрабатывать
           end
           else
           begin
            TermState:=ttNorma;
            if (X>1) or (Y=0) then
             FScriptMap[CurStmt-1].smdEnd:=StmtCoord(X-1,Y)
            else
             FScriptMap[CurStmt-1].smdEnd:=StmtCoord(Length(FScript[Y-1]),Y-1);
             if FScriptMap[CurStmt-1].smtType<>sInvalid then
              vCanEndStmt:=ValidateStatement(FScriptMap[CurStmt-1],Terminator=';');
           end;
           if vCanEndStmt then
           begin
            pd:=pdBetweenStatements;
            if FScriptMap[CurStmt-1].smtType =sDML then
             FHaveDMLStatements:=True
            else
            if FScriptMap[CurStmt-1].smtType in [sUnknown,sInvalid] then
             FHaveUnknownStatements:=True
           end
           else
            FScriptMap[CurStmt-1].smdEnd.X:=0;
          end;
         end;
      psInComment:
         case  CurStr[x] of
          '/': if (x>1) and (CurStr[x-1]='*') then
                 State:=psNormal;
         end;
      psInQuote:
         case  CurStr[x] of
          '''':  State:=psNormal;
         end;
      psInDoubleQuote:
         case  CurStr[x] of
          '"':  State:=psNormal;
         end;
     end;
    end; // end case pd
   end;
 finally
   SetLength(FScriptMap,CurStmt);
   if IgnoreLastTerm  then
    if Length(FScriptMap)>0 then
     if  (FScriptMap[CurStmt-1].smdEnd.X=0)  then // Нет завершающего терма
     begin
      FScriptMap[CurStmt-1].smdEnd.X:=Length(FScript[FScript.Count-1]);
      FScriptMap[CurStmt-1].smdEnd.Y:=FScript.Count-1;
      ValidateStatement(FScriptMap[CurStmt-1],False)
     end;
 end    
end;

//================
constructor TpFIBScriptParser.Create;
begin
  inherited;
  FTemp  :=TStringList.Create;
end;

destructor TpFIBScriptParser.Destroy;
begin
  FTemp.Free;
  inherited;
end;
{
procedure TpFIBScriptParser.DoOnParse(StatementNo: Integer; stmtDesc:TStatementDesc);
begin
 if Assigned(FOnParseProc) then
  FOnParseProc(Self,StatementNo,stmtDesc,nil) // Доделать вырезку в 4 аргумент
end;
}

procedure TpFIBScriptParser.SearchObjectType(var stmtDesc:TStatementDesc;var BegSearch:TStmtCoord;ForGrant:boolean=False);
var
  TmpCoord1:TStmtCoord;
  CurStr:string;
  S:string;
  
begin
   TmpCoord1:=NextTokenPos(BegSearch,stmtDesc.smdEnd);
   While (TmpCoord1.X<>0) do
   begin                 // CREATE UNIQUE ASCENDING INDEX
     CurStr:=FScript[TmpCoord1.Y];
     if not ForGrant then
     begin
       stmtDesc.objType:=TypeNameToObjectType(CurStr,TmpCoord1.X);
       if stmtDesc.objType=otNone then
        TmpCoord1:=NextTokenPos(TmpCoord1,stmtDesc.smdEnd)
       else
        Break
     end
     else
     begin
     // Гранты
      S:=GetToken(TmpCoord1);
      if IsClause('ON',CurStr,TmpCoord1.X) then
      begin
        TmpCoord1:=NextTokenPos(TmpCoord1,stmtDesc.smdEnd);
        stmtDesc.objType:=TypeNameToObjectType(CurStr,TmpCoord1.X);
        if stmtDesc.objType<>otNone then
         TmpCoord1:=NextTokenPos(TmpCoord1,stmtDesc.smdEnd);
        stmtDesc.objName:=GetToken(TmpCoord1);
        BegSearch:=TmpCoord1;
        Exit
      end
      else
        TmpCoord1:=NextTokenPos(TmpCoord1,stmtDesc.smdEnd)
     end;
   end;
   if stmtDesc.objType<>otNone then
     BegSearch:=TmpCoord1;
end;

function   TpFIBScriptParser.ValidateStatement(var stmtDesc: TStatementDesc;const NeedCheckCanEnd:boolean ):boolean;
var
   CurStr:string;
   TmpCoord:TStmtCoord;
   BegCount:integer;
   ExistAs:boolean;

begin
   Result:=True;
// Step 1
   CurStr:=FScript.Strings[stmtDesc.smdBegin.Y];
   stmtDesc.smtType:=StmtTypeNameToType(CurStr,stmtDesc.smdBegin.X);
// Step 2
   stmtDesc.objType:=otNone;

   case stmtDesc.smtType of
    sConnect  :
    begin
      stmtDesc.objType:=otDatabase;
      TmpCoord:=NextTokenPos(stmtDesc.smdBegin,stmtDesc.smdEnd);
      if TmpCoord.X<>0 then
      begin
        stmtDesc.objName:=GetToken(TmpCoord);
        FCurDBName:=stmtDesc.objName;
      end;
      FMakeConnectInScript:=True;
    end;
    SReconnect,sDisconnect,sCommit,sRollback:
    begin
      stmtDesc.objName:=FCurDBName;
      stmtDesc.objType:=otDatabase;
    end;

    sAlter,sCreate,sDrop,sRecreate,sExecute: // Next Word may be type Object
    begin
     TmpCoord:=NextTokenPos(stmtDesc.smdBegin,stmtDesc.smdEnd);
     if TmpCoord.X<>0 then
     begin  
       if  stmtDesc.smtType=sExecute then
       begin
         CurStr:=GetToken(TmpCoord);
         stmtDesc.smtType:=sDML;
         if IsClause('BLOCK',CurStr,1) then
          stmtDesc.objType:=otBlock
         else
          Exit;
       end
       else
       begin
        CurStr:=FScript[TmpCoord.Y];
        stmtDesc.objType:=TypeNameToObjectType(CurStr,TmpCoord.X);
       end ;
       case stmtDesc.objType of
        otNone:
         SearchObjectType(stmtDesc,TmpCoord);    //Возможно это индекс
        otDatabase: case stmtDesc.smtType of
                     sCreate:
                     begin
                      FMakeConnectInScript:=True;
                      stmtDesc.smtType:=sCreateDatabase;
                     end;
                     sDrop  : stmtDesc.smtType:=sDropDatabase
                    end;
       end;

       if  stmtDesc.objType<>otBlock then
       begin
        TmpCoord:=NextTokenPos(TmpCoord,stmtDesc.smdEnd);
        if TmpCoord.X<>0 then
         stmtDesc.objName:=GetToken(TmpCoord)
        else
         stmtDesc.objName:='';
       end;  
       if  stmtDesc.smtType=sCreateDatabase then
        FCurDBName:=stmtDesc.objName       
       else
       if  stmtDesc.smtType=sDropDatabase then
        stmtDesc.objName:=FCurDBName;

       if NeedCheckCanEnd then
        if  (stmtDesc.objType in [otProcedure,otTrigger,otBlock]) and (stmtDesc.smtType<>sDrop) then
        begin
// Надо проверить можно ли завершить стэйтмент если терминатор =';'
          BegCount:=0;
          ExistAs:=False;
          Result:=False;
          TmpCoord:=NextTokenPos(TmpCoord,stmtDesc.smdEnd);
          While (TmpCoord.X<>0) do
          begin
             CurStr:=FScript[TmpCoord.Y];
             if IsClause('AS',CurStr,TmpCoord.X) then
             begin
              ExistAs:=True;
             end
             else
             if IsClause('BEGIN',CurStr,TmpCoord.X) then
             begin
              BegCount:=1;
              Break;
             end;
             TmpCoord:=NextTokenPos(TmpCoord,stmtDesc.smdEnd);
          end;
          if (BegCount=0) then
          begin
          // до первого бегина
           if not ExistAs then  // ALTER TRIGGER INACTIVE 
             Result:=True;
           Exit;
          end;
          TmpCoord:=NextTokenPos(TmpCoord,stmtDesc.smdEnd);
          While (TmpCoord.X<>0) do
          begin
             CurStr:=FScript[TmpCoord.Y];
             if IsClause('BEGIN',CurStr,TmpCoord.X) then
              Inc(BegCount)
             else
             if IsClause('CASE',CurStr,TmpCoord.X) then
              Inc(BegCount)
             else
             if IsClause('END',CurStr,TmpCoord.X) then
              Dec(BegCount);
             if BegCount=0 then
             begin
              Result:=True;
              Exit;
             end;
             TmpCoord:=NextTokenPos(TmpCoord,stmtDesc.smdEnd);
          end;
        end;
     end;
    end;
    sDeclare:
    begin
     stmtDesc.objType:=otNone;
     TmpCoord:=NextTokenPos(stmtDesc.smdBegin,stmtDesc.smdEnd);
     if TmpCoord.X<>0 then
     begin
       CurStr:=FScript[TmpCoord.Y];
       if IsClause('EXTERNAL',CurStr,TmpCoord.X) then
         stmtDesc.objType:=otFunction
       else
       if IsClause('FILTER',CurStr,TmpCoord.X) then
         stmtDesc.objType:=otFilter;
       case stmtDesc.objType of
         otFunction:
         begin
           TmpCoord:=NextTokenPos(TmpCoord,stmtDesc.smdEnd);
           TmpCoord:=NextTokenPos(TmpCoord,stmtDesc.smdEnd);
           if TmpCoord.X<>0 then
            stmtDesc.objName:=GetToken(TmpCoord)
           else
            stmtDesc.objName:=''
         end;
       end
     end
    end;
    sSet:
    begin
     stmtDesc.objType:=otNone;
     TmpCoord:=NextTokenPos(stmtDesc.smdBegin,stmtDesc.smdEnd);
     if TmpCoord.X<>0 then
     begin
       CurStr:=FScript[TmpCoord.Y];
       if IsClause('GENERATOR',CurStr,TmpCoord.X) then
       begin
         stmtDesc.objType:=otGenerator;
         stmtDesc.smtType:=sSetGenerator;
       end
       else
       if IsClause('STATISTICS',CurStr,TmpCoord.X) then
       begin
         stmtDesc.objType:=otIndex;
         stmtDesc.smtType:=sSetStatistics;
         TmpCoord:=NextTokenPos(TmpCoord,stmtDesc.smdEnd);         
       end;




       if stmtDesc.objType<>otNone then
       begin
         TmpCoord:=NextTokenPos(TmpCoord,stmtDesc.smdEnd);
         if TmpCoord.X<>0 then
          stmtDesc.objName:=GetToken(TmpCoord)
         else
          stmtDesc.objName:='';  
       end;
     end
    end;
    sGrant:
    begin
     TmpCoord:=NextTokenPos(stmtDesc.smdBegin,stmtDesc.smdEnd);
     SearchObjectType(stmtDesc,TmpCoord,True)
    end
    ;
    sBatch: // Temporary type
    begin
     TmpCoord:=NextTokenPos(stmtDesc.smdBegin,stmtDesc.smdEnd);
     CurStr:=FScript[TmpCoord.Y];
     if IsClause('START',CurStr,TmpCoord.X) then
     begin
      stmtDesc.smtType:=sBatchStart;
//      FInBatchCollect:=True;
     end
     else
     if IsClause('EXECUTE',CurStr,TmpCoord.X) then
     begin
      stmtDesc.smtType:=sBatchExecute;
//      FInBatchCollect:=False
     end
     else
      stmtDesc.smtType:=sInvalid;
    end;
    sDescribe,sComment:
    begin
     TmpCoord:=NextTokenPos(stmtDesc.smdBegin,stmtDesc.smdEnd);
     if stmtDesc.smtType=sComment then
      TmpCoord:=NextTokenPos(TmpCoord,stmtDesc.smdEnd);
     if TmpCoord.X<>0 then
     begin
       stmtDesc.objType:=TypeNameToObjectType(CurStr,TmpCoord.X);
       if stmtDesc.objType<>otNone then
       begin
         TmpCoord:=NextTokenPos(TmpCoord,stmtDesc.smdEnd);
         if TmpCoord.X<>0 then
           stmtDesc.objName:=GetToken(TmpCoord)
         else
           stmtDesc.objName:='';

         if stmtDesc.smtType=sDescribe then  
         case stmtDesc.objType of
          otField,otParameter:
          begin
           TmpCoord:=NextTokenPos(TmpCoord,stmtDesc.smdEnd); // Таблица или вьюха или процедура
           TmpCoord:=NextTokenPos(TmpCoord,stmtDesc.smdEnd); // Имя таблицы или вьюхи или процедуры
           if TmpCoord.X<>0 then
            stmtDesc.objName:=GetToken(TmpCoord)+'.'+stmtDesc.objName
           else
            stmtDesc.objName:='';
          end;
         end;
       end;
     end
    end;
   end;
end;


function TpFIBScriptParser.NextTokenPos(TokenPos: TStmtCoord;EndCoord:TStmtCoord): TStmtCoord;
var
  State:TParserState;
  i:Word;
  j:Integer;
  CurStr:string;
  lCurStr:integer;
  FirstChar:Char;
begin
  CurStr:=FScript[TokenPos.Y];
  lCurStr:=Length(CurStr);
  Result.X:=lCurStr;
  FirstChar:=CurStr[TokenPos.X];
  for i:=TokenPos.X to lCurStr do // Skip first Token
    if FirstChar in ['''','"'] then
    begin
      if i> TokenPos.X then
       if CurStr[i] =FirstChar then
       begin
        Result.X:=i+1;
        Break        
       end
    end
    else
    if CurStr[i] in [' ',#13,#9,#10,'/','-'] then
    begin
      Result.X:=i;
      Break
    end;
  if Result.X=lCurStr then
  begin
   i:=1;
   Inc(TokenPos.Y)
  end 
  else
   i:= Result.X;
  Result.X:=0;
  State:=psNormal;
  for j:=TokenPos.Y to EndCoord.Y do
  begin
   CurStr:=FScript[j];
   if TokenPos.Y<>EndCoord.Y then
    lCurStr:=Length(CurStr)
   else
    lCurStr:=EndCoord.X;
   while i<=lCurStr do
   begin
     case State of
      psNormal:
      case CurStr[i] of
       ' ',#13,#9,#10:; //Skip
       '-':if (i<lCurStr) and (CurStr[i+1]='-') then
                 Break; // FBComment
       '/':if (i<lCurStr) and (CurStr[i+1]='*') then
             State:=psInComment;
      else
       Result.Y:=j;
       Result.X:=i;
       Exit
      end;
      psInComment:
         case  CurStr[i] of
          '/': if (i>1) and (CurStr[i-1]='*') then
                 State:=psNormal;
         end;
     end;
     Inc(i)
   end;
   i:=1;
  end;
end;

function TpFIBScriptParser.GetToken(TokenPos: TStmtCoord;IgnoreQuote:boolean=True): string;
var
   CurStr:string;
   StartPosInStr:Word;
   EndPosInStr:Word;
begin
   CurStr:=FScript[TokenPos.Y];
   StartPosInStr:=TokenPos.X;
   if (CurStr[StartPosInStr] in ['''','"']) and IgnoreQuote then
   begin
    EndPosInStr:=PosCh1(CurStr[StartPosInStr],CurStr,StartPosInStr+1);
    if EndPosInStr=0 then
     raise
        Exception.Create('Can''t find end token');
    Inc(StartPosInStr);
   end
   else
   begin
    EndPosInStr:=StartPosInStr;
    while (EndPosInStr<=Length(CurStr)) and
     not (CurStr[EndPosInStr] in [#9,#13,#10,' ','-','/',',',';','('])
    do
     Inc(EndPosInStr);
   end;

    SetLength(Result,EndPosInStr-StartPosInStr);
    if Length(Result)>0 then
     Move(CurStr[StartPosInStr],Result[1],Length(Result))
   
end;

function TpFIBScriptParser.TypeNameToObjectType(
  const TestString:string; Position:integer): TObjectType;
begin
 Result:=otNone;
 case TestString[Position] of
  'C','c':
       if IsClause('CONSTRAINT',TestString,Position) then
         Result:=otConstraint
       else
       if IsClause('COLUMN',TestString,Position) then
         Result:=otField;
  'D','d':
       if IsClause('DATABASE',TestString,Position) then
          Result:=otDatabase
       else
       if IsClause('DOMAIN',TestString,Position) then
         Result:=otDomain;
  'E','e':
       if IsClause('EXCEPTION',TestString,Position) then
         Result:=otException;

  'F','f':
       if IsClause('FIELD',TestString,Position) then
         Result:=otField  
       else
       if IsClause('FUNCTION',TestString,Position) then
         Result:=otFunction
       else
       if IsClause('FILTER',TestString,Position) then
         Result:=otFilter;
   'G','g':
       if IsClause('GENERATOR',TestString,Position) then
         Result:=otGenerator;
   'I','i':
       if IsClause('INDEX',TestString,Position) then
         Result:=otIndex;
   'P','p':
       if IsClause('PROCEDURE',TestString,Position) then
         Result:=otProcedure
       else
       if IsClause('PARAMETER',TestString,Position) then
         Result:=otParameter;
   'R','r':
       if IsClause('ROLE',TestString,Position) then
         Result:=otRole;
   'T','t':
       if IsClause('TABLE',TestString,Position) then
          Result:=otTable
       else
       if IsClause('TRIGGER',TestString,Position) then
         Result:=otTrigger;
   'V','v':
       if IsClause('VIEW',TestString,Position) then
          Result:=otView;

 end;
end;

function TpFIBScriptParser.StmtTypeNameToType(
  const TestString: string; Position: integer): TStmtType;
begin
   Result:=sUnknown;
   case TestString[Position] of
    'A','a': // May be alter
         if IsClause('ALTER',TestString,Position) then
         begin
          Result:=sAlter;
         end;
    'B','b':
         if IsClause('BATCH',TestString,Position) then
         begin
           Result:=sBatch ;
         end;
    'C','c': // May be Create,Connect,Comment
         if IsClause('CREATE',TestString,Position) then
         begin
           Result:=sCreate ;
         end
         else
         if IsClause('COMMIT',TestString,Position) then
         begin
           Result:=sCommit;
         end
         else
         if IsClause('COMMENT',TestString,Position) then
         begin
          Result:=sComment;
         end
         else
         if IsClause('CONNECT',TestString,Position) then
         begin
          Result:=sConnect;
         end;
     'D','d':// May be drop,describe,declare
         if IsClause('DROP',TestString,Position) then
         begin
          Result:=sDrop;
         end
         else
         if IsClause('DECLARE',TestString,Position) then
         begin
          Result:=sDeclare;
         end
         else
         if IsClause('DESCRIBE',TestString,Position) then
         begin
          Result:=sDescribe;
         end
         else
         if IsClause('DELETE',TestString,Position) then
         begin
          Result:=sDML;
         end
         else
         if IsClause('DISCONNECT',TestString,Position) then
         begin
          Result:=sDisconnect;
         end;

     'E','e':
         if IsClause('EXECUTE',TestString,Position) then
         begin
          Result:=sExecute;
         end;
     'G','g':
         if IsClause('GRANT',TestString,Position) then
         begin
          Result:=sGrant;
         end;
     'I','i': // may be Insert;
         if IsClause('INSERT',TestString,Position) then
         begin
          Result:=sDML;
         end
         else
         if IsClause('INPUT',TestString,Position) then
         begin
          Result:=sRunFromFile;
         end;


     'M','m':
         if IsClause('MERGE',TestString,Position) then
         begin
          Result:=sDML;
         end;
     'U','u':
         if IsClause('UPDATE',TestString,Position) then
         begin
          Result:=sDML;
         end;
     'R','r':
      if IsClause('RECREATE',TestString,Position) then
      begin
        Result:=sRecreate;
      end
      else
      if IsClause('ROLLBACK',TestString,Position) then
      begin
        Result:=sRollBack;
      end
      else
      if IsClause('RECONNECT',TestString,Position) then
      begin
        Result:=sReconnect;
      end
      else
      if IsClause('REVOKE',TestString,Position) then
      begin
        Result:=sGrant;
      end;

     'S','s':
      if IsClause('SET',TestString,Position) then
      begin
        Result:=sSet;
      end;
   end;
end;

// Blob File Supports

procedure TpFIBScripter.TryFillBlobParams;
var
   i:Integer;
   pn:string;
   bPos,Len:Integer;
   m:TMemoryStream;
   p_:integer;
begin
  with FQuery do
  for i:=FQuery.ParamCount-1 downto 0 do
  begin
    pn:=FQuery.ParamName(i);
    if pn[1] in ['H','h'] then
    begin
     p_:= Pos('_', pn);
     bPos := HexStr2Int(Copy(pn, 2, p_-2));
     Len  := HexStr2Int(Copy(pn, p_+1, Length(pn)-p_));
     if Len=0 then
      FQuery.Params[i].Clear
     else
     begin
      if not Assigned(FBlobFileStream) then
       FBlobFileStream:=TFileStream.Create(FBlobFile,fmOpenRead{$IFDEF D6+},fmShareDenyWrite{$ENDIF});
      m := TMemoryStream.Create;
      try
       m.Size := Len;
       m.Position:=0;
       FBlobFileStream.Position:=bPos;
       FBlobFileStream.Read(m.Memory^,Len);
       FQuery.Params[i].LoadFromStream(m);
      finally
       m.Free;
      end
     end;
    end;
  end
end;

end.
