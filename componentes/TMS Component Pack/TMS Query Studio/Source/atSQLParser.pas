unit atSqlParser;

interface

uses
  Classes, Forms, DB, DBTables, SysUtils, Windows, Messages,
  Dialogs, Controls, atBaseParser, TypInfo;

type
  TSqlNoTerminal = (
     ntSql,
     ntSelect,
     ntFldlst_slc,
     ntallfieldsexp,
     ntFielddef,
     ntDistinct,
     ntWhere,
     ntGroupby,
     ntUnion,
     ntOrderby,
     ntInsert,
     ntValues,
     ntUpdate,
     ntSettings,
     ntSetting,
     ntDelete,
     ntFldlst_grp,
     ntFldlst_ord,
     ntFldlst_ins,
     ntDescending,
     ntSource,
     ntListed_src,
     ntJoined_src,
     ntLeft_join,
     ntRight_join,
     ntInner_join,
     ntTable,
     ntTablename,
     ntTablealias,
     ntField,
     ntFieldname,
     ntFieldalias,
     ntLogic_expr,
     ntLogic_expr1,
     ntNot,
     ntExists,
     ntIn,
     ntRelational,
     ntRelat_oper,
     ntExpression,
     ntArit_oper,
     ntConcat_oper,
     ntParam,
     ntNumber,
     ntString,
     ntLogic,
     ntNull,
     ntMacro,
     ntFunction,
     ntUpper,
     ntLower,
     ntYear,
     ntMonth,
     ntDay,
     ntSum,
     ntMax,
     ntMin,
     ntAvg,
     ntCount,
     ntCountAllExpr,
     ntANY, { any node  (placeholder) }
     ntUnknownFunc );

const
  ntOuter_join = [ntLeft_join, ntRight_join, ntInner_join];
  ValidFieldChars =
    '0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' +
    'šžŸÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöùúûüýþÿ';
  FieldDelimOpenChars = '"[';
  FieldDelimCloseChars = '"]';


type
  TatSqlParser = class;

  TConvertSqlProc = procedure(AMetaSql:TatSqlParser) of object;

  TatSqlParser = class
  private
    FOwner        : TPersistent;
    FParser       : TatBaseParser;
    FMetaSql      : string;
    FErrorRow     : integer;
    FErrorCol     : integer;
    FCorrect      : boolean;
    FResultSql    : string;
    FErrorMsg     : string;
    FOnConvertSql : TConvertSqlProc;
    procedure SeTatSqlParser(const Value: string);
    function AcceptAliasNode(Node: TNoTerminalNode): boolean;
    function GetNoTerminalNodes: TNoTerminalNodes;
    function GetNoTerminals: TNoTerminals;
    procedure SetOnConvertSql(const Value: TConvertSqlProc);
  public
    constructor Create(AOwner:TPersistent);
    destructor Destroy; override;

    { métodos para análise da árvore sintática }
    { desassocia todos os procedimentos para análise da árvore sintática }
    procedure ClearScanProcs;
    { ajusta um procedimento para pré-análise do não-terminal especificado }
    procedure SetBeforeNoTerminalScanProc(NoTerm:TSqlNoTerminal;AProc:TNodeScanProc);
    { ajusta um procedimento para pós-análise do não-terminal especificado }
    procedure SetAfterNoTerminalScanProc(NoTerm:TSqlNoTerminal;AProc:TNodeScanProc);
    { executa a análise da árvore sintática, chamando os procedimentos
      previamente associados }
    procedure ScanNodes;
    { analisa o FMetaSql, montando a árvore sintática no FParser }
    procedure ParseMetaSQL;

    { propriedades públicas }
    property Correct:boolean read FCorrect write FCorrect;
    property ErrorCol:integer read FErrorCol write FErrorCol;
    property ErrorRow:integer read FErrorRow write FErrorRow;
    property ErrorMsg:string read FErrorMsg write FErrorMsg;
    property MetaSql:string read FMetaSql write SeTatSqlParser;
    property NoTerminals:TNoTerminals read GetNoTerminals;
    property Nodes:TNoTerminalNodes read GetNoTerminalNodes;
    property ResultSql: string read FResultSql write FResultSql;
    property Parser: TatBaseParser read FParser;
    property OnConvertSql : TConvertSqlProc read FOnConvertSql write SetOnConvertSql;
  end;

procedure BuildSqlList(var list:string;element:string);
procedure BuildSqlExpr(var expr:string;cond:string);
function ExtractInvolvedTables(const ASql:string):TStringList;
function NodeCast(ANode:TNoTerminalNode;i:array of integer;nt:array of TSqlNoTerminal):TNoTerminalNode;
function NodeMatch(ANode:TNoTerminalNode;i:array of integer;nt:array of TSqlNoTerminal): boolean;
function NodeType(ANode:TNoTerminalNode):TSqlNoTerminal;

implementation

uses
  qsREs;

const
  META_SQL_GRAMMAR =
     '<sql>: [{<select>|<insert>|<update>|<delete>}] '#13#10+
     '<select>:SELECT <fldlst_slc> FROM <source><where><groupby><union><orderby>'#13#10+
     '<fldlst_slc>:[<distinct>] {<allfieldsexp>|<fielddef>} [( , <fielddef>)]'#13#10+
     '<allfieldsexp>:"*"'#13#10+
     '<fielddef>:<expression> [[AS] <fieldalias>]'#13#10+
     '<distinct>:DISTINCT'#13#10+
     '<where>:[ WHERE <logic_expr>]'#13#10+
     '<groupby>:[ GROUP BY <fldlst_grp> [HAVING <logic_expr>]]'#13#10+
     '<union>:[ UNION <select>]'#13#10+
     '<orderby>:[ ORDER BY <fldlst_ord>]'#13#10+
     '<insert>:INSERT INTO <tablename> ["(" <fldlst_ins> ")"] {VALUES "(" <values> ")"|<select>}'#13#10+
     '<values>:{<param>|<number>|<string>|<logic>|<macro>|<null>} [( , {<param>|<number>|<string>|<logic>|<macro>|<null>})]'#13#10+
     '<update>:UPDATE <tablename> SET <settings> [<where>]'#13#10+
     '<settings>:<setting> [( , <setting>)]'#13#10+
     '<setting>:<field> "=" <expression>'#13#10+
     '<delete>:DELETE FROM <table> [<where>]'#13#10+
     '<fldlst_grp>:<expression> [( , <expression>)]'#13#10+
     '<fldlst_ord>:<expression> [<descending>] [( , <expression> [<descending>])]'#13#10+
     '<fldlst_ins>:<expression> [( , <expression>)]'#13#10+
     '<descending>:DESC'#13#10+
     '<source>:{<joined_src>|<listed_src>}'#13#10+
     '<listed_src>:<table> [( , <table>)]'#13#10+
     '<joined_src>:{"(" <joined_src> ")"[( {<left_join>|<inner_join>|<right_join>})]|<table> {<left_join>|<inner_join>|<right_join>}[( {<left_join>|<inner_join>|<right_join>})]}'#13#10+
     '<left_join>:LEFT JOIN <table> ON <logic_expr>'#13#10+
     '<right_join>:RIGHT JOIN <table> ON <logic_expr>'#13#10+
     '<inner_join>:INNER JOIN <table> ON <logic_expr>'#13#10+
     '<table>:<tablename> [[AS] <tablealias>]'#13#10+
     '<tablename>:{<macro>|@[({@|#})][.(@)]|<spacedname>}'#13#10+
     '<tablealias>:{@[({@|#})]|<spacedname>}'#13#10+
     '<field>:[<tablealias>.]<fieldname>'#13#10+
     '<fieldname>:{"!"|<macro>|@[({@|#})]|<spacedname>}'#13#10+
     '<fieldalias>:{@[({@|#})]|<spacedname>}'#13#10+
     '<logic_expr>:{"(" <logic_expr> ")"|<logic_expr1>}[( OR~ {"(" <logic_expr> ")"|<logic_expr1>})]'#13#10+
     '<logic_expr1>:{<not>|<exists>|<logic>|<in>|<relational>|<field>}[( AND~ {"(" <logic_expr> ")"|<not>|<exists>|<logic>|<in>|<relational>|<field>})]'#13#10+
     '<not>:NOT {<exists>|<logic>|<in>|<relational>|<field>|"(" <logic_expr> ")"}'#13#10+
     '<exists>:EXISTS "(" <select> ")"'#13#10+
     '<in>:<field> {IN|NOT IN} "(" {<select>|<values>} ")"'#13#10+
     '<relational>:<expression> <relat_oper> {"(" <select> ")"|<expression>}'#13#10+
     '<relat_oper>:{"="|"<>"|">="|"<="|">"|"<"|LIKE~|IS~NOT~|IS~}[ {ALL~|SOME~|ANY~}]'#13#10+
     '<expression>:{<param>|<number>|<string>|<logic>|<null>|<macro>|<function>|<field>|"(" <expression> ")"} [( {<arit_oper>|<concat_oper>} {<param>|<number>|<string>|<logic>|<null>|<macro>|<function>|<field>|"(" <expression> ")"})]'#13#10+
     '<arit_oper>:{*|/|+|-}'#13#10+
     '<concat_oper>:"||"'#13#10+
     '<param>:":"@[({@|#})]'#13#10+
     '<number>:[{-|+}](#)[.(#)][e[{-|+}](#)]'#13#10+
     '<string>:$'#13#10+
     '<logic>:{TRUE|FALSE}'#13#10+
     '<null>:NULL'#13#10+
     '<macro>:"%"@[({@|#})]'#13#10+
     '<function>:{<upper>|<lower>|<year>|<month>|<day>|<sum>|<max>|<min>|<avg>|<count>|<unknownfunc>}'#13#10+
     '<upper>:UPPER"(" <expression> ")"'#13#10+
     '<lower>:LOWER"(" <expression> ")"'#13#10+
     '<year>:YEAR"(" <field> ")"'#13#10+
     '<month>:MONTH"(" <field> ")"'#13#10+
     '<day>:DAY"(" <expression> ")"'#13#10+
     '<sum>:SUM"(" <expression> ")"'#13#10+
     '<max>:MAX"(" <expression> ")"'#13#10+
     '<min>:MIN"(" <expression> ")"'#13#10+
     '<avg>:AVG"(" <expression> ")"'#13#10+
     '<count>:COUNT"(" {<expression>|<countallexpr>} ")"'#13#10+
     '<countallexpr>:<allfieldsexp>'#13#10+
     '<spacedname>:&1&0[({" "|&0})]&2'#13#10+
     '<unknownfunc>:(@)"(" <expression> [("," <expression>)] ")"';

{ helper functions }

function NodeCast(ANode:TNoTerminalNode;i:array of integer;nt:array of TSqlNoTerminal):TNoTerminalNode;
var c: integer;
begin
   if not Assigned(ANode) then
      raise Exception.Create(_str(SNullNode));
   result:=ANode;
   for c:=0 to high(i) do
   begin
      if (i[c]<0) or (i[c]>=result.Nodes.Count) then
         raise Exception.CreateFmt(_str(STokenDoesNotContainSubnode),[ result.InputToken, i[c] ]);
      if result[i[c]].NoTerminalIndex<>ord(nt[c]) then
         raise Exception.CreateFmt(_str(STokenIsNotNode),[result.InputToken,GetEnumName(TypeInfo(TSqlNoTerminal),ord(nt[c]))]);
      result:=result[i[c]];
   end;
end;

function NodeMatch(ANode:TNoTerminalNode;i:array of integer;nt:array of TSqlNoTerminal): boolean;
var c: integer;
begin
   result := false;
   if not Assigned(ANode) then Exit;
   for c:=0 to high(i) do
   begin
      if (i[c]<0) or (i[c]>=ANode.Nodes.Count) then Exit;
      if (nt[c]<>ntANY) and (ANode[i[c]].NoTerminalIndex<>ord(nt[c])) then Exit;
      ANode := ANode[i[c]];
   end;
   result := true;
end;

function NodeType(ANode:TNoTerminalNode):TSqlNoTerminal;
begin
   result:=TSqlNoTerminal(ANode.NoTerminalIndex);
end;

procedure BuildSqlList(var list:string;element:string);
begin
   { concatena uma lista com o elemento, usando uma vírgula como separador }
   if length(list)>0 then
      list:=list+','+Trim(element)
   else
      list:=Trim(element);
end;

procedure BuildSqlExpr(var expr:string;cond:string);
begin
   { concatena uma lista com o elemento, usando uma vírgula como separador }
   if length(expr)>0 then
      expr:=expr+' AND '+Trim(cond)
   else
      expr:=Trim(cond);
end;

function ExtractInvolvedTables(const ASql:string):TStringList;

   procedure branch(node:TNoTerminalNode);
   var c: integer;
   begin
      with node do
      begin
         { explore os sub-nós recursivamente }
         for c:=0 to Nodes.Count-1 do
            branch(Nodes[c]);
         { verifica se o nó corresponden a uma definição de tabela }
         if node.NoTerminalIndex=ord(ntTablename) then
            result.Add(node.InputToken);
      end;

   end;

var metasql : TatSqlParser;
begin
   { desmonta a SQL para montar uma lista com o nome de todas as tabelas envolvidas }
   result:=TStringList.Create;
   try
      metasql := TatSqlParser.Create(Application);
      with metasql do
      try
         MetaSql:=ASql;
         { desmonta a sql em uma árvore sintática }
         ParseMetaSql;
         { explora a árvore sintática recursivamente
           para encontrar os tokens que representam tabelas }
         branch(Parser.Node);
      finally
         Free;
      end;
   except
      result.Free;
      result:=nil;
      raise;
   end;
end;

{ TatSqlParser }

constructor TatSqlParser.Create(AOwner:TPersistent);
begin
   inherited Create;
   FOwner:=AOwner;

   { Cria e prepara um parser para processar o meta-sql }
   FParser:=TatBaseParser.Create(nil);
   FParser.Grammar.Text:=META_SQL_GRAMMAR;
   { customização de não-terminais }
   with FParser.NoTerminals do
   begin
      { Não deixa o apelido de campos e tabelas ser uma palavra reservada }
      Items[ IndexOf('FieldAlias') ].OnAcceptNode:=AcceptAliasNode;
      Items[ IndexOf('TableAlias') ].OnAcceptNode:=AcceptAliasNode;
   end;
   FParser.CustomLexemes[0] := ValidFieldChars;
   FParser.CustomLexemes[1] := FieldDelimOpenChars;
   FParser.CustomLexemes[2] := FieldDelimCloseChars;
end;

destructor TatSqlParser.Destroy;
begin
   if Assigned(FParser) then
      FParser.Free;  
   inherited;
end;

// comentado para não exibir o Hint durante a compilação
function TatSqlParser.AcceptAliasNode( Node:TNoTerminalNode ):boolean;
var id:string;
begin
   { não aceita identificadores que forem palavras reservadas da liguagem }
   id:=UpperCase(Node.InputToken);
   result := (id<>'FROM') and
             (id<>'ON') and
             (id<>'WHERE') and
             (id<>'ORDER') and
             (id<>'GROUP') and
             (id<>'HAVING') and
             (id<>'UNION') and
             (id<>'LEFT') and
             (id<>'RIGHT') and
             (id<>'INNER') and
             (id<>'JOIN');
end;
                                                         
procedure TatSqlParser.SeTatSqlParser(const Value: string);
begin
   if FMetaSql<>Value then
   begin
      { ajusta as propriedades básicas de entrada e saída }
      FMetaSql   := Value; // entrada
      FResultSql := Value; // valor default de saída
      FCorrect   := true; // valor default de saída
      FErrorCol  := -1;
      FErrorRow  := -1;
      FErrorMsg  := '';
      { se houver um conversor de sql atachado então o executa ao alterar a string do meta-sql } 
      if Assigned(FOnConvertSql) then
         FOnConvertSql(self);
   end;
end;

procedure TatSqlParser.ParseMetaSQL;
var row,col : integer;
begin
   FCorrect:=false;
   with FParser do
   begin
      Strings.Text:=FMetaSQL;
      with CheckLanguage do
      begin
         if Result<>srCorrect then
         begin
            GetRowColFromStrings(Strings,MaxInputPos-1,row,col);
            FErrorRow:=row;
            FErrorCol:=col;
            ErrorMsg:=Format(
               _str(SErroSintaxeLinhaColuna) + #13#10 +
               '"%s"',[FErrorRow,FErrorCol,FMetaSQL]);
         end
         else
         begin
            FErrorRow:=-1;
            FErrorCol:=-1;
            FCorrect:=true;
            FErrorMsg:='';
         end;
      end;
   end;
   
// for debug
// SyntaxTreeViewDlg(FParser);
end;

function TatSqlParser.GetNoTerminalNodes: TNoTerminalNodes;
begin
   result:=FParser.Node.Nodes;
end;

function TatSqlParser.GetNoTerminals: TNoTerminals;
begin
   result:=FParser.NoTerminals;
end;

procedure TatSqlParser.ScanNodes;
begin
   { percorre toda a árvore sintática executando os métodos associados a cada
     não-terminal pelos procedimentos SetAfterNoTerminalScanProc e
     SetBeforeNoTerminalScanProc }
   FParser.ScanSyntaxTree;
end;

procedure TatSqlParser.ClearScanProcs;
var c: integer;
begin
   with FParser.NoTerminals do
      for c:=0 to Count-1 do
      begin
         Items[c].OnBeforeNodeScan:=nil;
         Items[c].OnAfterNodeScan:=nil;
      end;
end;

procedure TatSqlParser.SetAfterNoTerminalScanProc(NoTerm: TSqlNoTerminal;AProc: TNodeScanProc);
begin
   with FParser.NoTerminals do
      Items[ ord(NoTerm) ].OnAfterNodeScan:=AProc;
end;

procedure TatSqlParser.SetBeforeNoTerminalScanProc(NoTerm: TSqlNoTerminal;AProc: TNodeScanProc);
begin
   with FParser.NoTerminals do
      Items[ ord(NoTerm) ].OnBeforeNodeScan:=AProc;
end;

procedure TatSqlParser.SetOnConvertSql(const Value: TConvertSqlProc);
begin
   FOnConvertSql := Value;
end;

end.

