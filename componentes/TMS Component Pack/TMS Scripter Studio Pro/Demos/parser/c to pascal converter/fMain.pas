unit fMain;

{$I ASCRIPT.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, atParser, AdvMemo, ExtCtrls, Menus, Contnrs,
  ActnList, ImgList, ToolWin, AdvmPS;

type
  TForm1 = class(TForm)
    PopupMenu1: TPopupMenu;
    Collapseall1: TMenuItem;
    Expandall1: TMenuItem;
    Panel1: TPanel;
    Panel4: TPanel;
    mmResult: TMemo;
    PageControl1: TPageControl;
    tsSource: TTabSheet;
    Panel2: TPanel;
    AdvMemo1: TAdvMemo;
    tsInclude: TTabSheet;
    Panel3: TPanel;
    AdvMemo2: TAdvMemo;
    tsConverted: TTabSheet;
    Panel6: TPanel;
    mmPascal: TAdvMemo;
    tsTree: TTabSheet;
    Panel7: TPanel;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    ToolBar1: TToolBar;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    ImageList1: TImageList;
    acOpen: TAction;
    acConvert: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    File1: TMenuItem;
    Openfile1: TMenuItem;
    ools1: TMenuItem;
    ConvertCtoPascal1: TMenuItem;
    OpenDialog1: TOpenDialog;
    acSaveCPP: TAction;
    acSaveH: TAction;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    SaveCsourcecodefilecpp1: TMenuItem;
    SaveCincludefileh1: TMenuItem;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    tsGrammar: TTabSheet;
    mmGrammar: TAdvMemo;
    procedure Collapseall1Click(Sender: TObject);
    procedure Expandall1Click(Sender: TObject);
    procedure acOpenExecute(Sender: TObject);
    procedure acConvertExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acSaveCPPExecute(Sender: TObject);
    procedure acSaveHExecute(Sender: TObject);
  private
    FParser: TatSyntaxParser;
    FIncParser: TatSyntaxParser;
    FDeclareNodes: TObjectList;
    function IsStringMethod(datanode: TNoTerminalNode): boolean;
    function ReplaceAnsiStringParameter(id: string; str: string): string;
    function ReplaceAnsiStringCall(id: string): string;
    procedure InternalBuildSyntaxTree;
    function AcceptReservedWord(Node: TNoTerminalNode): boolean;
    function AcceptType(Node: TNoTerminalNode): boolean;
    function BlockChange(Node: TNoTerminalNode): string;
    function DeclareChange(Node: TNoTerminalNode): string;
    function ConvertType(AStr: string): string;
    procedure ExtractComment(AParser: TatSyntaxParser; AStartPos,
      AFinalPos: integer);
    function IncludeChange(Node: TNoTerminalNode): string;
    function DataRefChange(Node: TNoTerminalNode): string;
    function DataValChange(Node: TNoTerminalNode): string;
    function CallChange(Node: TNoTerminalNode): string;
    function IfChange(Node: TNoTerminalNode): string;
    function AssignChange(Node: TNoTerminalNode): string;
    procedure ChangeDataId(Node: TNoTerminalNode);
    function StringChange(Node: TNoTerminalNode): string;
    function DeclareVarChange(Node: TNoTerminalNode): string;
    function UnaryChange(Node: TNoTerminalNode): string;
    function ReturnChange(Node: TNoTerminalNode): string;
    function ForChange(Node: TNoTerminalNode): string;
    function FindEndOfParentesis(S: string): integer;
    function OperatorChange(Node: TNoTerminalNode): string;
    function GenericDataChange(Node: TNoTerminalNode): string;
    function DynamicCastChange(Node: TNoTerminalNode): string;
    function CatchChange(Node: TNoTerminalNode): string;
    function TryChange(Node: TNoTerminalNode): string;
    function ParameterChange(Node: TNoTerminalNode): string;
    function ParametersChange(Node: TNoTerminalNode): string;
    function WhileChange(Node: TNoTerminalNode): string;
    procedure PrepareParser(AParser: TatSyntaxParser);
    procedure AddResult(S: string);
    function EventTypeChange(Node: TNoTerminalNode): string;
    function TypeDefChange(Node: TNoTerminalNode): string;
    function ClassChange(Node: TNoTerminalNode): string;
    function ClassBodyChange(Node: TNoTerminalNode): string;
    function DeclareClassChange(Node: TNoTerminalNode): string;
    function ClassVisibilityChange(Node: TNoTerminalNode): string;
    function ClassFieldChange(Node: TNoTerminalNode): string;
    function ClassMethodChange(Node: TNoTerminalNode): string;
    function ClassPropertyChange(Node: TNoTerminalNode): string;
    function DoParse: boolean;
    procedure DoConvert;
    function RecordItemChange(Node: TNoTerminalNode): string;
    function RecordTypeChange(Node: TNoTerminalNode): string;
    function IgnoreTokenChange(Node: TNoTerminalNode): string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation
{$IFDEF DELPHI6_LVL}
uses StrUtils;
{$ENDIF}

{$R *.DFM}

procedure TForm1.InternalBuildSyntaxTree;
var
  ATreeView: TTreeView;

   procedure ShowNodes( ViewNode:TTreeNode; SyntaxNodes:TNoTerminalNodes; AParser: TatSyntaxParser );
   var c   : integer;
       aux : string;
   begin
      for c:=0 to SyntaxNodes.Count-1 do
         with SyntaxNodes[c] do
         begin
            if Nodes.Count=0 then aux:=': '+InputToken else aux:='';
            ShowNodes( ATreeView.Items.AddChildObject( ViewNode, AParser.NoTerminals[NoTerminalIndex].IdS+aux, SyntaxNodes[c] ),
                       SyntaxNodes[c].Nodes, AParser );
         end;
   end;

var
  CPPNode: TTreeNode;
  HNode: TTreeNode;
begin
   ATreeView := TreeView1;
   with ATreeView do
   begin
      Items.BeginUpDate;
      Items.Clear;
      Visible := false;
      CPPNode := Items.Add(nil, '.cpp source');
      HNode := Items.Add(CPPNode, '.h include');
      ShowNodes( Items.AddChildObject( CPPnode, FParser.NoTerminals[FParser.Node.NoTerminalIndex].IdS, FParser.Node ),
                 FParser.Node.Nodes, FParser );
      ShowNodes( Items.AddChildObject( HNode, FIncParser.NoTerminals[FIncParser.Node.NoTerminalIndex].IdS, FIncParser.Node ),
                 FIncParser.Node.Nodes, FIncParser );
      Items.EndUpDate;
      Visible := true;
   end;
end;

procedure TForm1.AddResult(S: string);
begin
  mmResult.Lines.Add(Format('%s - %s', [TimeToStr(Now), S]));
end;

function TForm1.DoParse: boolean;
var
  PResult: TParsingResults;
  row, col: integer;
begin
  result := false;
  mmResult.Lines.Clear;
  AddResult('parsing...');
  Application.ProcessMessages;

  {Parse .cpp}
  FParser.Strings := AdvMemo1.Lines;
  PResult := FParser.CheckLanguage;
  if PResult.Result <> srCorrect then
  begin
    GetRowColFromStrings(FParser.Strings, PResult.MaxInputPos - 1,row,col);
    AddResult(Format(
      'Error: cannot parse C++ source code (.cpp) on line %d, column %d.'#13#10, [row, col]));
    PageControl1.ActivePage := tsSource;
    AdvMemo1.SetCursor(col - 1, row - 1);
    AdvMemo1.SetFocus;
    Exit;
  end else
  begin
    AddResult('Source code (.cpp) parsed succesfully.');
  end;

  {parse .h}
  FIncParser.Strings := AdvMemo2.Lines;
  PResult := FIncParser.CheckLanguage;
  if PResult.Result <> srCorrect then
  begin
    GetRowColFromStrings(FIncParser.Strings, PResult.MaxInputPos - 1,row,col);
    AddResult(Format(
      'Error: cannot parse C++ include (.h) on line %d, column %d.'#13#10, [row, col]));
    PageControl1.ActivePage := tsInclude;
    AdvMemo2.SetCursor(col - 1, row - 1);
    AdvMemo2.SetFocus;
    Exit;
  end else
  begin
    AddResult('Include (.h) parsed succesfully.');
  end;

  result := true;
end;

procedure TForm1.ExtractComment(AParser: TatSyntaxParser; AStartPos, AFinalPos: integer );
var
  S: string;
begin
  S := AParser.Input;
  if Copy(S, AStartPos, 2) = '/*' then
  begin
    {$WARNINGS OFF}
    S[AStartPos] := '(';
    S[AFinalPos] := ')';
    {$WARNINGS ON}
    AParser.Input := S;
  end;
end;

const
  CPPGrammar =
    '<program>: [<incpragsect>] [({<declarevar>|<typedef>|<class>} ; )] [(<function> )] [<formextern> ;] [(<ifdefdirs> )]'#13#10+
    '<incpragsect>:({<include>|<pragma>|<define>|<ifdefdirs>} )'#13#10+
    '<include>:"#include" {<filename>|<string>}'#13#10+
    '<pragma>:"#pragma" {"package("<idlist>")"|<pragmatype> <string>|<id> [<id>]}'#13#10+
    '<define>:"#define" <id>'#13#10+
    '<ifdefdirs>:{"#ifdef" <id>|"#ifndef" <id>|"#endif"}'#13#10+ //just to avoid syntax errors. It does not handle conditional directives
    '<formextern>:extern [PACKAGE] <id> *<id>'#13#10+ //just to avoid syntax errors. This token is completely ignored
    '<pragmatype>:{link|resource}'#13#10+
    '<filename>:"<" <id>[.<id>] ">"'#13#10+
    '<typedef>:"typedef" {<eventtype>|<recordtype>}'#13#10+
    '<eventtype>:<returntype> [<directive>] "(" "__closure" "*" <id> ")" "(" <parameters> ")"'#13#10+
    '<recordtype>:"struct" <id> "{" (<recorditem> ";" ) "}" [<recordvar>]'#13#10+
    '<recorditem>:<type> <id> [(, <id> )]'#13#10+
    '<recordvar>:<id>'#13#10+
    '<class>:<declareclass> <classbody>'#13#10+
    '<declareclass>:"class" ["PACKAGE"] <classname> ":" <classdirective> <baseclass>'#13#10+
    '<baseclass>:<id>'#13#10+
    '<classdirective>:{public}'#13#10+
    '<classbody>:"{" (<classsection> ) "}"'#13#10+
    '<classsection>:<classvisibility> [(<classitem> ";" )]'#13#10+
    '<classvisibility>:{private|public|protected|__published} ":"'#13#10+
    '<classitem>:{<classmethod>|<classproperty>|<classfield>}'#13#10+
    '<classmethod>:[(<directive> )] {<returntype> [<directive>] ["~"]<functionname> "("|[<directive>] ["~"]<functionname> "("} [<parameters>] ")" '#13#10+
    '<classfield>:["::"] <itemtype> <id>[ "[" <indexcount> "]" ] [(, <id>[ "[" <indexcount> "]" ] )]'#13#10+
    '<classproperty>:"__property" ["::"] <itemtype> <id> "=" "{" <propertyparam> [( "," <propertyparam> )] "}"'#13#10+
    '<itemtype>:{<internaltype>~|<objecttype>|<deftype>~}'#13#10+
    '<deftype>:<id>'#13#10+
    '<propertyparam>:<propparamname> "=" <propparamvalue>'#13#10+
    '<propparamname>:<id>'#13#10+
    '<propparamvalue>:<id>'#13#10+
    '<function>: <declare> <block> [;] '#13#10+
    '<declare>:[(<directive> )] {<returntype> [<directive>] [<classname>"::"["~"]]<functionname> "("|[<directive>] [<classname>"::"["~"]]<functionname> "("} [<parameters>] ")" [":" <call>]'#13#10+
    '<returntype>:<type>'#13#10+
    '<type>:{<internaltype>|<objecttype>}'#13#10+
    '<internaltype>:{int|float|void|bool|char|AnsiString|PChar|String|Variant|TDateTime|double|Currency|word|extended|byte|'+
       'TSectionTrackState|TRect|TPoint|TOwnerDrawState|TCustomDrawState|TScrollCode|TShiftState|TCloseAction|TMouseButton|TWindowState}'#13#10+
    '<objecttype>:<id> "*"'#13#10+
    '<directive>:{__fastcall|__stdcall|inline|static|virtual}'#13#10+
    '<classname>:<id>'#13#10+
    '<functionname>:<id>'#13#10+
    '<parameters>:<parameter> [(, <parameter> )]'#13#10+
    '<parameter>:[<parammodifier>] <type> [<address>]<id>'#13#10+
    '<parammodifier>:{const}'#13#10+
    '<address>:"&"'#13#10+
    '<block>: "{" [({<block>|<statement>} )] "}" '#13#10+
    '<statement>:{<return>|<while>|<if>|<try>|<for>|<declarevar>|<multipleassign>|<assign>|<call>} [;] '#13#10+
    '<multipleassign>:<assign> (, <assign>)'#13#10+
    '<return>:"return" [<expression>]'#13#10+
    '<declarevar>:{<internaltype>~|<objecttype>} {<assign>|<id>[ "[" <indexcount> "]" ]} [(, ["*"] {<assign>|<id>[ "[" <indexcount> "]" ]})]'#13#10+
    '<indexcount>:<real>'#13#10+
    '<assign>R:[<datavalcast>] <data_ref> [<addoper>] <assignoper> <expression>'#13#10+
    '<assignoper>:{"="|"+="|"=+"|"|="|"-="|"=-"}'#13#10+
    '<call>:[<new>~]<id><arg_list><indexing><call_code>[{.| "->" |"::"}<call>][ <addoper>]'#13#10+
    '<new>:"new"'#13#10+
    '<call_code>:[ as <as_class>]'#13#10+
    '<dynamiccast>:"dynamic_cast<"<id> "*>" "(" <expression> ")"'#13#10+
    '<data_val>:[<new>~]<datavalcast><id><arg_list><indexing>[{.| "->" |"::"}<data_val>][<addoper>]'#13#10+
    '<datavalcast>:[ "(" <type> ["*"] ")" ]'#13#10+
    '<data_ref>:[<pointerset>]<id><arg_list><indexing>[{.| "->" }<data_ref>]'#13#10+
    '<pointerset>:"*"'#13#10+
    '<arg_list>:[ "(" [<expression> [(, <expression> )]]")"]'#13#10+
    '<indexing>:[( "[" <expression> [(, <expression> )]"]")]'#13#10+

    '<if>:"if" "(" <expression> ")" <then> [<else>]'#13#10+
    '<while>:"while" "(" <expression> ")" {<block>|<statement>} '#13#10+
    '<then>:{<block>|<statement>}'#13#10+
    '<else>:else {<block>|<statement>}'#13#10+

    '<try>:try <try_statements>{<finally>|<catch>} <try_upshot>'#13#10+
    '<finally>:finally'#13#10+
    '<catch>:catch "(" {<id> "&" <id>|"..."} ")" '#13#10+
    '<try_statements>:{<block>|<statement>} '#13#10+
    '<try_upshot>:{<block>|<statement>} '#13#10+

    '<for>:"for" "(" {<declarevar>|<assign>} ";" <expression> ";" <statement> ")" {<block>|<statement>}'#13#10+

    '<idlist>:<id> [(, <id> )]'#13#10+
    '<id>:@[({@|#})]'#13#10+

    '<expression>:<exprterm>[( <operator> <exprterm>)]'#13#10+
    '<exprterm>:{[<unary>]{<dynamiccast>|<data_val>|"(" <expression> ")"}|<hex>|<real>|<string>|<char>|<vector>}'#13#10+
    '<char>:"''"["\"]{%}"''"'#13#10+
    '<unary>:{"!" |-|+}'#13#10+
    '<operator>:{*|/|"&&"~|"<<"|"&"~|+|-|"||"~|"|"~|"!="|">="|"<="|"=="|">"|"<"|mod~|is~|"%"}'#13#10+
    '<addoper>:{"++"|"--"}'#13#10+
    '<hex>:"0x"({#|a|b|c|d|e|f})'#13#10+
    '<frac>:.(#)'#13#10+
    '<exp>:e[{-|+}](#)'#13#10+
    '<real>:[{-|+}](#)[<frac>][<exp>]'#13#10+
    '<string>:($)'#13#10+
    '<vector>:NOT YET IMPLEMENTED'#13#10+
    '';

procedure TForm1.PrepareParser(AParser: TatSyntaxParser);
begin
  AParser.Comments.Clear;
  AParser.Comments.Add('/*', '*/');
  AParser.Comments.Add('//', #13);
  AParser.StringDelimitter := '"';
  AParser.OnExtractRemark := ExtractComment;
  AParser.Grammar.Text := mmGrammar.Lines.Text;

  With AParser.NoTerminals do
  begin
    Items[ IndexOf('functionname') ].OnAcceptNode := AcceptReservedWord;
    Items[ IndexOf('type') ].OnAcceptNode := AcceptType;

    Items[ IndexOf('block') ].OnNodeStringChange := BlockChange;
    Items[ IndexOf('declare') ].OnNodeStringChange := DeclareChange;
    Items[ IndexOf('incpragsect') ].OnNodeStringChange := IncludeChange;
    Items[ IndexOf('data_val') ].OnNodeStringChange := DataValChange;
    Items[ IndexOf('data_ref') ].OnNodeStringChange := DataRefChange;
    Items[ IndexOf('call') ].OnNodeStringChange := CallChange;
    Items[ IndexOf('assign') ].OnNodeStringChange := AssignChange;
    Items[ IndexOf('string') ].OnNodeStringChange := StringChange;
    Items[ IndexOf('declarevar') ].OnNodeStringChange := DeclareVarChange;
    Items[ IndexOf('if') ].OnNodeStringChange := IfChange;
    Items[ IndexOf('while') ].OnNodeStringChange := WhileChange;
    Items[ IndexOf('unary') ].OnNodeStringChange := UnaryChange;
    Items[ IndexOf('return') ].OnNodeStringChange := ReturnChange;
    Items[ IndexOf('for') ].OnNodeStringChange := ForChange;
    Items[ IndexOf('operator') ].OnNodeStringChange := OperatorChange;
    Items[ IndexOf('dynamiccast') ].OnNodeStringChange := DynamicCastChange;
    Items[ IndexOf('catch') ].OnNodeStringChange := CatchChange;
    Items[ IndexOf('try') ].OnNodeStringChange := TryChange;
    Items[ IndexOf('parameter') ].OnNodeStringChange := ParameterChange;
    Items[ IndexOf('parameters') ].OnNodeStringChange := ParametersChange;
    Items[ IndexOf('eventtype') ].OnNodeStringChange := EventTypeChange;
    Items[ IndexOf('typedef') ].OnNodeStringChange := TypeDefChange;
    Items[ IndexOf('class') ].OnNodeStringChange := ClassChange;
    Items[ IndexOf('declareclass') ].OnNodeStringChange := DeclareClassChange;
    Items[ IndexOf('classbody') ].OnNodeStringChange := ClassBodyChange;
    Items[ IndexOf('classvisibility') ].OnNodeStringChange := ClassVisibilityChange;
    Items[ IndexOf('classfield') ].OnNodeStringChange := ClassFieldChange;
    Items[ IndexOf('classmethod') ].OnNodeStringChange := ClassMethodChange;
    Items[ IndexOf('classproperty') ].OnNodeStringChange := ClassPropertyChange;
    Items[ IndexOf('recordtype') ].OnNodeStringChange := RecordTypeChange;
    Items[ IndexOf('recorditem') ].OnNodeStringChange := RecordItemChange;
    Items[ IndexOf('ifdefdirs') ].OnNodeStringChange := IgnoreTokenChange;
    Items[ IndexOf('formextern') ].OnNodeStringChange := IgnoreTokenChange;
  end;
end;

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDeclareNodes := TObjectList.Create(false);
  FParser := TatSyntaxParser.Create(nil);
  FIncParser := TatSyntaxParser.Create(nil);
end;

function TForm1.IgnoreTokenChange(Node: TNoTerminalNode): string;
begin
  result := ''; //Does nothing. Ignore define directives
end;

function TForm1.RecordTypeChange(Node: TNoTerminalNode): string;
//        '<recordtype>:"struct" <id> "{" (<recorditem> ";" ) "}" [<recordvar>]'#13#10+
//    '<recordvar>:<id>'#13#10+
var
  idstr: string;
  recvarnode: TNoTerminalNode;
  recvarname: string;
  i: integer;
begin
  {Get the name of the record type}
  idstr := Node.Nodes.FindByNoTerminalName('id').InputToken;

  {Check if there are variables declared as record. If yes, then retrieve the variable name.
   In either case, remove the variable declaration (clears the <recordvar> node, because the
   variable names will be put after the string manually)}
  recvarnode := Node.Nodes.FindByNoTerminalName('recordvar');
  if recvarnode <> nil then
    recvarname := recvarnode.InputToken
  else
    recvarname := '';
  recvarnode.ChangeNodeString('');


  {Find the open brack and replace everything until the open brack by the record declaration}
  result := Node.InputToken;
  Delete(result, 1, Pos('{', result));
  result := Format('%s = record %s', [idstr, result]);

  {Remove the close bracket and add an "end;" at the end of declaration}
  i := Length(result);
  while (i > 1) and (result[i] <> '}') do
    dec(i);
  Delete(result, i, 1);
  Insert('end', result, i);

  {insert the variable declaration, if any, after the record}
  if recvarname <> '' then
  begin
    result := Format('%s; var %s: %s', [result, recvarname, idstr]);
  end;
end;

function TForm1.RecordItemChange(Node: TNoTerminalNode): string;
var
  typenode: TNoTerminalNode;
  strtype: string;
begin
  //<recorditem>:<type> <id> [(, <id> )]
  {Change <type> node to an empty string, convert the type and put it at the end of the string node}
  typenode := Node.Nodes.FindByNoTerminalName('type');
  strtype := ConvertType(typenode.InputToken);
  typenode.ChangeNodeString('');
  result := TrimLeft(Format('%s: %s', [Node.InputToken, strtype]));
end;

function TForm1.ClassPropertyChange(Node: TNoTerminalNode): string;
var
  strtype: string;
  paramid: TNoTerminalNode;
  paramvalue: TNoTerminalNode;
  paramidstr: string;
  c: integer;
  readstr: string;
  writestr: string;
  defaultstr: string;
  unknownparams: string;
begin
  (*
  <classproperty>:"__property" ["::"] <itemtype> <id> "=" "{" <propertyparam> [( "," <propertyparam> )] "}"
  <itemtype>:{<internaltype>|<objecttype>|<deftype>}
  <deftype>:<id>
  <propertyparam>:<propparamname> "=" <propparamvalue>
  <propparamname>:<id>
  <propparamvalue>:<id>
  *)
  strtype := ConvertType(Node.Nodes.FindByNoTerminalName('itemtype').InputToken);
  unknownparams := '';
  readstr := '';
  writestr := '';
  defaultstr := '';
  {iterate through all params and retrieve each known param}
  for c := 2 to Node.Nodes.Count - 1 do
  begin
    paramid := Node.Nodes[c].Nodes[0];
    paramvalue := Node.Nodes[c].Nodes[1];
    paramidstr := Trim(LowerCase(paramid.InputToken));

    if paramidstr = 'read' then
      readstr := 'read ' + paramvalue.InputToken
    else
    if paramidstr = 'write' then
      writestr := 'write ' + paramvalue.InputToken
    else
    if paramidstr = 'default' then
      defaultstr := ' default ' + paramvalue.InputToken
    else
    begin
      if unknownparams <> '' then
        unknownparams := ', ' + unknownparams;
      unknownparams := unknownparams + Node.Nodes[c].InputToken;
    end;
  end;

  result := Format('property %s: %s %s %s%s%s',
    [Node.Nodes.FindByNoTerminalName('id').InputToken,
     strtype, readstr, writestr, defaultstr,
     unknownparams]);
end;

function TForm1.ClassMethodChange(Node: TNoTerminalNode): string;
  //<classmethod>:[(<directive> )] {<returntype> [<directive>] ["~"]<functionname> "("|[<directive>] ["~"]<functionname> "("} [<parameters>] ")"
var
  rtype: TNoTerminalNode;
  funcname: TNoTerminalNode;
  params: TNoTerminalNode;

  strfunc: string;
  strname: string;
  strparams: string;
  strresult: string;
begin
  rtype := Node.Nodes.FindByNoTerminalName('returntype');
  funcname := Node.Nodes.FindByNoTerminalName('functionname');
  params := Node.Nodes.FindByNoTerminalName('parameters');

  if Pos('~', Node.InputToken) <> 0 then
  begin
    strfunc := 'destructor';
    strresult := '';
  end
  else
  if (rtype = nil) or (SameText('void', trim(rtype.InputToken))) then
  begin
    strfunc := 'procedure';
    strresult := '';
  end
  else
  begin
    strfunc := 'function';
    strresult := ': ' + ConvertType(rtype.InputToken)
  end;

  strname := funcname.InputToken;

  if params <> nil then
    strparams := params.InputToken
  else
    strparams := '';

  result := Format('%s %s(%s)%s',
    [strfunc, strname, strparams, strresult]);
end;

function TForm1.ClassFieldChange(Node: TNoTerminalNode): string;
var
  typenode: TNoTerminalNode;
  strtype: string;
  i: integer;
  strid: string;
  vartoken: string;
  indexstr: string;
begin
  //<classfield>:["::"] <itemtype> <id> [(, <id> )]
  typenode := Node.Nodes.FindByNoTerminalName('itemtype');
  strtype := ConvertType(typenode.InputToken);

  vartoken := '';

  {Get id list}
  i := 1;
  while i < Node.Nodes.Count do
  begin
    strid := Node.Nodes[i].InputToken;

    if (i + 1 < Node.Nodes.Count) and (SameText(Node.Nodes[i + 1].NoTerminal.Ids, 'indexcount')) then
    begin
      //Has index
      indexstr := Node.Nodes[i + 1].InputToken;
      strtype := Format('array[0..%s - 1] of %s', [indexstr, strtype]);
      inc(i);
    end;

    if vartoken <> '' then vartoken := vartoken + ', ';
    vartoken := vartoken + strid;
    inc(i);
  end;
  vartoken := Format('%s: %s', [vartoken, strtype]);
  result := vartoken;
end;

function TForm1.ClassVisibilityChange(Node: TNoTerminalNode): string;
begin
  {Remove the ":" character after the visibility directive}
  result := StringReplace(Node.InputToken, ':', '', []);
  result := StringReplace(result, '__published', 'published', []);
end;

function TForm1.DeclareClassChange(Node: TNoTerminalNode): string;
var
  classnamestr: string;
  baseclassstr: string;
begin
  //<declareclass>:"class" ["PACKAGE"] <classname> ":" <classdirective> <baseclass>
  classnamestr := Node.Nodes.FindByNoTerminalName('classname').InputToken;
  baseclassstr := Node.Nodes.FindByNoTerminalName('baseclass').InputToken;
  result := Format('%s = class(%s)', [classnamestr, baseclassstr]);
end;

function TForm1.ClassBodyChange(Node: TNoTerminalNode): string;
var
  i: integer;
begin
  {Remove the open and close brackets and add an "end;" at the end of declaration}
  result := Node.InputToken;
  result := StringReplace(result, '{', '', []);
  i := Length(result);
  while (i > 1) and (result[i] <> '}') do
    dec(i);
  Delete(result, i, 1);
  Insert('end', result, i);
end;

function TForm1.ClassChange(Node: TNoTerminalNode): string;
var
  i: integer;
begin
  {Include "type" word in the beginning. But first, check if the previous node of the list was also a class.
   If yes, then do not include, to avoid "type" keyword after each class is declared}
  result := Node.InputToken;
  i := Node.Index;
  if (i <= 0) or not SameText(Node.ParentNode.Nodes[i - 1].NoTerminal.Ids, 'class') then
    result := 'type '#13#10 + result;
end;

function TForm1.TypeDefChange(Node: TNoTerminalNode): string;
var
  i: integer;
begin
  {change "typedef" to "type". But first, check if the previous node of the list was also a typedef.
   If yes, then change "typedef" to an empty string, so to avoid "type" keyword after each type is declared}
  result := Node.InputToken;
  i := Node.Index;
  if (i > 0) and SameText(Node.ParentNode.Nodes[i - 1].NoTerminal.Ids, 'typedef') then
    result := TrimLeft(StringReplace(result, 'typedef', '', []))
  else
    result := StringReplace(result, 'typedef', 'type', []);
end;

function TForm1.EventTypeChange(Node: TNoTerminalNode): string;
var
  rtypestr: string;
  declstr: string;
begin
  //<eventtype>:<returntype> [<directive>] "(" "__closure" "*" <id> ")" "(" <parameters> ")"
  rtypestr := Node.Nodes.FindByNoTerminalName('returntype').InputToken;
  if (rtypestr = 'void') then
  begin
    declstr := 'procedure';
    rtypestr := '';
  end else
  begin
    declstr := 'function';
    rtypestr := ': ' + rtypestr;
  end;
  result := Format('%s = %s(%s)%s of object',
    [Node.Nodes.FindByNoTerminalName('id').InputToken,
     declstr,
     Node.Nodes.FindByNoTerminalName('parameters').InputToken,
     rtypestr]);


end;

function TForm1.ParametersChange(Node: TNoTerminalNode): string;
begin
  result := StringReplace(Node.InputToken, ',', ';', [rfReplaceAll]);
end;

function TForm1.ParameterChange(Node: TNoTerminalNode): string;
var
  modstr: string;
begin
  //<parameter>:[<parammodifier>] <type> [<address>]<id>
  modstr := '';

  {check if there is a parammodifier. For now, only "const" is available, so keep it as is}
  if Node.Nodes.FindByNoTerminalName('parammodifier') <> nil then
    modstr := Node.Nodes.FindByNoTerminalName('parammodifier').InputToken;
  modstr := LowerCase(Trim(modstr));

  {if there is an addressnode ("&" sign), then use "var" modifier}
  if Node.Nodes.FindByNoTerminalName('address') <> nil then
    modstr := 'var';

    result := Format('%s: %s',
      [Node.Nodes.FindByNoTerminalName('id').InputToken,
       ConvertType(Node.Nodes.FindByNoTerminalName('type').InputToken)]);
  if modstr <> '' then
    result := modstr + ' ' + result;
end;

function TForm1.TryChange(Node: TNoTerminalNode): string;
begin
  (*add an "end" to the try..finally or try..except block.
   in c++ -> try { } catch() { }
   in pascal -> try ... except .. end
  *)

  result := Node.InputToken + ' end;'#13#10;
end;

function TForm1.CatchChange(Node: TNoTerminalNode): string;
begin
  //<catch>:catch "(" {<id> "&"<id>|"..."} ")"
  {Check if there is an id for the exception. If yes, then turns it to the format
   "except on id: exceptionid do"
   otherwise, turns it in a simple "except"}
  if Node.Nodes.Count > 0 then
    result := Format('except on %s: %s do ', [Node.Nodes[1].InputToken, Node.Nodes[0].InputToken])
  else
    result := 'except ';
end;

function TForm1.DynamicCastChange(Node: TNoTerminalNode): string;
begin
  {Given this syntax:

   <dynamiccast>:"dynamic_cast<"<id> "*>" "(" <expression> ")"'#13#10+

   Convert a expression of format dynamic_cast<TQuery*>(MyDataset) to TQuery(MyDataset)
   using the two and only two nodes available in the syntax: id and expression}
  result := Format('%s(%s)', [Node.Nodes[0].InputToken {id}, Node.Nodes[1].InputToken {expression}]);
end;

function TForm1.OperatorChange(Node: TNoTerminalNode): string;
{*|/|"&&"~|"<<"|"&"~|+|-|"||"~|"|"~|"!="|">="|"<="|"=="|">"|"<"|mod~|is~|"%"}
const
  NumOpers = 8;
  SourceOpers: array[0..NumOpers - 1] of string =
    ('&&', '<<', '&', '||', '|', '!=', '==', '%');
  DestOpers: array[0..NumOpers - 1] of string =
    (' and ', ' shl ', ' and ', ' or ',  'or ', '<>', '=', ' mod ');
var
  c: integer;
begin
  result := Trim(Node.InputToken);
  for c := 0 to NumOpers - 1 do
    if lowercase(result) = SourceOpers[c] then
    begin
      result := DestOpers[c];
      break;
    end;
end;

function TForm1.ForChange(Node: TNoTerminalNode): string;
var
  startn: TNoTerminalNode;
  endn: TNoTerminalNode;
  incn: TNoTerminalNode;

  function CheckStandardFor(CompOper: string; AddOper: string; FinalOper: string; ToWord: string; Var StrResult: string): boolean;
  var
    operpos: integer;
    startstr: string;
    endstr: string;
    incstr: string;
    id: string;
    id2: string;
  begin
    result := false;
    startstr := startn.InputToken; // i := 0;
    endstr := endn.InputToken; //i <= Count
    incstr := incn.InputToken; //i++

    id := Trim(Copy(startstr, 1, Pos(':=', startstr) - 1));
    startstr := Trim(Copy(startstr, Pos(':=', startstr) + 2, MaxInt));

    operpos := Pos(CompOper, endn.InputToken);
    id2 := '';
    if operpos <> -1 then
      id2 := Trim(Copy(endstr, 1, operpos - 1));

    if SameText(id2, id) then
    begin
      endstr := Copy(endstr, operpos, MaxInt); // <= Count
      if endstr[2] <> '=' then
      begin
        endstr := endstr + FinalOper; //' - 1'
        endstr := Copy(endstr, 2, MaxInt); //Count - 1
      end else
        endstr := Copy(endstr, 3, MaxInt); //Count
    end;

    if SameText(Trim(StringReplace(incstr, ' ', '', [rfReplaceall])), Format('%s:=%s%s1', [id, id, AddOper])) then
      result := true;

    StrResult := Format('for %s := %s %s %s do %s',
      [id, startstr, ToWord, endstr, Copy(Node.InputToken, FindEndOfParentesis(Node.InputToken) + 1, MaxInt)]);
  end;

//    '<for>:"for" "(" {<declarevar>|<assign>} ";" <expression> ";" <statement> ")" {<block>|<statement>}'#13#10+
var
  StandardFor: boolean;
begin
  {Retrieve the name of the for variable}
  startn := Node.Nodes[0];
  endn := Node.Nodes[1];
  incn := Node.Nodes[2];


  StandardFor := false;
  {check if it's a normal for: for(id = bla; id <= bla; id++)}

  if CheckStandardFor('<', '+', ' - 1', 'to', result) then
    StandardFor := true
  else
  if CheckStandardFor('>', '-', ' + 1', 'downto', result) then
    StandardFor := true;

  if not StandardFor then
    result := Node.InputToken;
end;

function TForm1.ReturnChange(Node: TNoTerminalNode): string;
var
  expr: TNoTerminalNode;
begin
  expr := Node.Nodes.FindByNoTerminalName('expression');
  if expr <> nil then
    result := Format('begin result := %s; exit; end', [expr.InputToken])
  else
    result := 'exit';
end;

function TForm1.UnaryChange(Node: TNoTerminalNode): string;
begin
  result := Node.InputToken;
  if Trim(result) = '!' then
    result := 'not ';
end;

function TForm1.AcceptReservedWord(Node: TNoTerminalNode): boolean;
var
  S: string;
begin
  S := UpperCase(Node.InputToken);
  result :=
    (S <> 'WHILE') and
    (S <> 'IF');
end;

function TForm1.AcceptType(Node: TNoTerminalNode): boolean;
var
  S: string;
begin
  S := Trim(UpperCase(Node.InputToken));
  result :=
    (S <> '__FASTCALL');
end;

function TForm1.ConvertType(AStr: string): string;
const
  NumTypes = 5;
  SourceTypes: array[0..NumTypes - 1] of string =
    ('int', 'float', 'void', 'bool', 'ansistring');
  DestTypes: array[0..NumTypes - 1] of string =
    ('integer', 'single', '', 'boolean', 'string');
var
  c: integer;
begin
  result := AStr;
  for c := 0 to NumTypes - 1 do
    if lowercase(result) = SourceTypes[c] then
    begin
      result := DestTypes[c];
      break;
    end;
  result := Trim(StringReplace(result, '*', '', []));
end;

function TForm1.StringChange(Node: TNoTerminalNode): string;
begin
  result := Node.InputToken;
  if result = '""' then
    result := '''''' else
  begin
    result := StringReplace(result, '\\', '\', [rfReplaceAll]);
    result := StringReplace(result, '\n', '''#10''', [rfReplaceAll]);
    result := StringReplace(result, '\b', '''#8''', [rfReplaceAll]);
    result := StringReplace(result, '\f', '''#12''', [rfReplaceAll]);
    result := StringReplace(result, '\n', '''#10''', [rfReplaceAll]);
    result := StringReplace(result, '\r', '''#13''', [rfReplaceAll]);
    result := StringReplace(result, '\t', '''#9''', [rfReplaceAll]);
    result := StringReplace(result, '\''', '''', [rfReplaceAll]);
    result := StringReplace(result, '\"', '"', [rfReplaceAll]);
    result := StringReplace(result, '\?', '?', [rfReplaceAll]);
    result := AnsiQuotedStr(Copy(result, 2, Length(result) - 2), '''');
  end;
end;

function TForm1.FindEndOfParentesis(S: string): integer;
var
  PLevel: integer;
  c: integer;
  IsLiteral: boolean;
begin
  PLevel := -1;
  IsLiteral := false;
  for c := 1 to Length(S) do
  begin
    if S[c] = '''' then
      IsLiteral := not IsLiteral
    else
      if not IsLiteral then
      begin
        if S[c] = '(' then
        begin
          Inc(PLevel);
          if PLevel = 0 then PLevel := 1;
        end;
        if S[c] = ')' then
        begin
          Dec(PLevel);
          if PLevel = 0 then break;
        end;
      end;
  end;
  result := c;
end;

function TForm1.WhileChange(Node: TNoTerminalNode): string;
var
  c: integer;
  S: string;
begin
  //<while>:"while" "(" <expression> ")" {<block>|<statement>}

  {find the last parentesis of expression and put a "do" after it}
  S := Node.InputToken;
  c := FindEndOfParentesis(S);
  Insert(' do ', S, c + 1);
  result := S;
end;

function TForm1.IfChange(Node: TNoTerminalNode): string;
var
  c: integer;
  S: string;
  thennode: TNoTerminalNode;
begin
  //<if>:"if" "(" <expression> ")" <then> [<else>]

  {if there is an <else> node in the if, then remove a ";" after the <then> node}
  if Node.Nodes.FindByNoTerminalName('else') <> nil then
  begin
    thennode := Node.Nodes.FindByNoTerminalName('then');
    S := thennode.InputToken;
    c := Length(S);
    {ignore spaces and end of line to find the ";" character}
    while (c > 0) and ((S[c] = #13) or (S[c] = #10) or (S[c] = ' ')) do
      dec(c);
    if (c > 0) and (S[c] = ';') then
      Delete(S, c, 1);
    thennode.ChangeNodeString(S);
  end;

  {find the last parentesis of expression and put a "then" after it}
  S := Node.InputToken;
  c := FindEndOfParentesis(S);
  Insert(' then', S, c + 1);
  result := S;
end;

function TForm1.AssignChange(Node: TNoTerminalNode): string;
var
  aoper: TNoTerminalNode;
  expr: TNoTerminalNode;
  dataref: TNoTerminalNode;
  stroper: string;

  strdataref: string;
  strexpr: string;
begin
  aoper := Node.Nodes.FindByNoTerminalName('assignoper');
  expr := Node.Nodes.FindByNoTerminalName('expression');
  dataref := Node.Nodes.FindByNoTerminalName('data_ref');

  stroper := Trim(Aoper.InputToken);
  strdataref := dataref.InputToken;
  strexpr := expr.InputToken;
  if stroper = '=' then
    result := Format('%s := %s', [strdataref, strexpr])
  else
  if (stroper = '+=') or (stroper = '=+') then
    result := Format('%s := %s + (%s)', [strdataref, strdataref, strexpr])
  else
  if stroper = '|=' then
    result := Format('%s := %s or (%s)', [strdataref, strdataref, strexpr])
  else
  if (stroper = '-=') or (stroper = '=-') then
    result := Format('%s := %s - (%s)', [strdataref, strdataref, strexpr])
end;

procedure TForm1.ChangeDataId(Node: TNoTerminalNode);
var
  id: TNoTerminalNode;
  s: string;
begin
  id := Node.Nodes.FindByNoTerminalName('id');
  if id <> nil then
  begin
    s := id.InputToken;
    if s = 'NULL' then
      S := 'nil';
    if s = 'this' then
      s := 'Self';
    if s <> id.InputToken then
      id.ChangeNodeString(s);
  end;
end;

function TForm1.DataValChange(Node: TNoTerminalNode): string;
var
  datavalnode: TNoTerminalNode;
  castnode: TNoTerminalNode;
  newcaststr: string;
begin
  {Check if there is a cast for the dataval. If yes, then change the beginning of the cast.
  Example: from "(integer) expression" to "integer(expression"}
  datavalnode := Node.Nodes.FindByNoTerminalName('datavalcast');
  castnode := datavalnode.Nodes.FindByNoTerminalName('type');
  if castnode <> nil then
  begin
    newcaststr := ConvertType(castnode.InputToken) + '(';
    datavalnode.ChangeNodeString(newcaststr);
  end;

  {process generic stuff}
  result := GenericDataChange(Node);

  {now that all subnodes has been processed, put a close parentesis if there is a typecast in the expression}
  if castnode <> nil then
    result := result + ')';
end;

function TForm1.DataRefChange(Node: TNoTerminalNode): string;
begin
  result := GenericDataChange(Node);
end;

type
  TStrParamMode = (smFirst, smUnique, smLast);

const
  NumStrFunc = 7;
  StrFunc: array[0..NumStrFunc - 1] of string =
    ('Length', 'LowerCase', 'Pos', 'Trim', 'UpperCase', 'Substring', 'Delete');
  ParamFunc: array[0..NumStrFunc - 1] of TStrParamMode =
    (smUnique, smUnique, smLast, smUnique, smUnique, smFirst, smFirst);
  NewFuncName: array[0..NumStrFunc - 1] of string =
    ('Length', 'Lowercase', 'Pos', 'Trim', 'Uppercase', 'Copy', 'Delete');
  ParamCountFunc: array[0..NumStrFunc - 1] of integer =
    (0, 0, 1, 0, 0, 2, 2);

function TForm1.IsStringMethod(DataNode: TNoTerminalNode): boolean;
var
  c: integer;
  idstr: string;
  idnode: TNoTerminalNode;
  arglist: TNoTerminalNode;
  PCount: integer;
begin
  result := false;
  idnode := DataNode.Nodes.FindByNoTerminalName('id');
  if idnode <> nil then
  begin
    idstr := Lowercase(idnode.InputToken);
    for c := 0 to NumStrFunc - 1 do
      if (SameText(idstr, StrFunc[c])) then
      begin
        arglist := DataNode.Nodes.FindByNoTerminalName('arg_list');
        if arglist <> nil then
          PCount := argList.Nodes.Count
        else
          PCount := 0;
        result := PCount = ParamCountFunc[c];
        break;
      end;
  end;
end;

const
  SFlagStr = '##flag##';
  SParamStr = '##param##';

function TForm1.ReplaceAnsiStringCall(id: string): string;
var
  c: integer;
begin
  result := id;
  for c := 0 to NumStrFunc - 1 do
    if SameText(id, StrFunc[c]) then
    begin
      result := NewFuncName[c];
      break;
    end;
end;

{$IFNDEF DELPHI6_LVL}
function ReverseString(const AText: string): string;
var
  I: Integer;
  P: PChar;
begin
  SetLength(Result, Length(AText));
  P := PChar(Result);
  for I := Length(AText) downto 1 do
  begin
    P^ := AText[I];
    Inc(P);
  end;
end;
{$ENDIF}

function TForm1.ReplaceAnsiStringParameter(id: string; str: string): string;
var
  c: integer;
  ParamMode: TStrParamMode;
begin
  ParamMode := smUnique;
  for c := 0 to NumStrFunc - 1 do
    if SameText(id, StrFunc[c]) then
    begin
      ParamMode := ParamFunc[c];
      break;
    end;

  Case ParamMode of
    smUnique: result := StringReplace(str, '(', '(' + SParamStr, []);
    smFirst: result := StringReplace(str, '(', '(' + SParamStr + ', ', []);
    smLast:
      begin
        {Replace the last ")" with ", ##param##"}
        result := ReverseString(str);
        result := StringReplace(result, ')', ReverseString(', ' + SParamStr + ')'), []);
        result := ReverseString(result);
      end;
  end;
end;

function TForm1.GenericDataChange(Node: TNoTerminalNode): string;
var
  newnode: TNoTerminalNode;
  idnode: TNoTerminalNode;
  addoper: TNoTerminalNode;
  addoperstr: string;
  idstr: string;
  pflag: integer;
begin
  newnode := Node.Nodes.FindByNoTerminalName('new');
  idnode := Node.Nodes.FindByNoTerminalName('id');
  idstr := LowerCase(idnode.InputToken);
  ChangeDataId(Node);

  {Check if the function is a constructor: new TDataset(Owner);
   If yes, than change it to TDataset.Create(Owner)}
  if newnode <> nil then
  begin
    if idnode <> nil then
      idnode.ChangeNodeString(idnode.InputToken + '.Create');
    newnode.ChangeNodeString('');
  end;

  {Check if there is an addoper (++ or --) at the end. If yes, then change it to pascal equivalent}
  addoper := Node.Nodes.FindByNoTerminalName('addoper');
  if addoper <> nil then
  begin
    addoperstr := addoper.InputToken[1];
    {change the format something++ to something := something + 1,
     by replacing the "++" by " := something + 1 "}
    addoper.ChangeNodeString(Format(' := %s %s 1',
      [StringReplace(Node.InputToken, addoper.InputToken, '', [rfReplaceAll]), addoperstr]));
  end;

  {Check if the "function" called is the __classid (for example, __classid(TDataset).
   If yes, then remove the __classid call and the parentesis, leaving only the "parameters" (arg_list.expression)
   of the function (TDataset in this example}
  if idstr = '__classid' then
    Node.ChangeNodeString(Node.Nodes.FindByNoTerminalName('arg_list').Nodes[0].InputToken);

  {Check if the function is a call to ansistring method, and if there are dataval (or dataref or call) nodes
   owning this one. If yes, that the call is a method call for an ansistring class.
   The transformation should be from this (for example):

   Class->Objects[c]->Text.Pos("a");

   to this:

   Class->Objects[c]->Text.##flag##Pos('a', ##param##);
    }
  if IsStringMethod(Node) and SameText(Node.ParentNode.NoTerminal.Ids, Node.NoTerminal.Ids) then
  begin
    {Replace the name of the function. Must be before the Node.ChangeNodeString}
    idnode.ChangeNodeString(ReplaceAnsiStringCall(idstr));
    {Insert the parameter at the beginning or end of the parameter list, depending on the name of the function.
     Also, insert a stamp in the beginning of the text so it can be replaced after}
    Node.ChangeNodeString(SFlagStr + ReplaceAnsiStringParameter(idstr, Node.InputToken));
  end;

  result := StringReplace(Node.InputToken, '->', '.', [rfReplaceAll]);
  result := StringReplace(result, '::', '.', [rfReplaceAll]);

  {after all, if there is a flagstr in the text, and the datanode is the first onde (no datanodes above)
   then replace the param flag by the class until ##flag##. As an example, it should replace this:

   Class.Objects[c].Text.##flag##Pos('a', ##param##);

   by this:

   Pos('a', Class.Objects[c].Text);  }
   pflag := Pos(SFlagStr, result);
   if (pflag > 0) and not SameText(Node.ParentNode.NoTerminal.Ids, Node.NoTerminal.Ids) then
   begin
     {first, replace ##param## by the text. The string should look like this:

      Class.Objects[c].Text.##flag##Pos('a', Class.Objects[c].Text);}

     result := StringReplace(result, SParamStr,
       Copy(result, 1, pflag - 2), []);

     {Now remove everything until ##flag##, including it}
     Delete(result, 1, pflag + Length(SFlagStr) - 1);
   end;
end;

function TForm1.CallChange(Node: TNoTerminalNode): string;
begin
  result := GenericDataChange(Node);
end;

function TForm1.IncludeChange(Node: TNoTerminalNode): string;
var
  c: integer;
  S: string;
  ANode: TNoTerminalNode;
  ok: boolean;
begin
  S := 'uses'#13#10'  ';
  ok := false;
  for c := 0 to Node.Nodes.Count - 1 do
  begin
    ANode := Node.Nodes[c];
    if SameText(ANode.NoTerminal.IdS, 'include') then
    begin
      ok := true;
      if ANode.Nodes.FindByNoTerminalName('string') <> nil then
        ANode := ANode.Nodes.FindByNoTerminalName('string')
      else
        ANode := ANode.Nodes.FindByNoTerminalName('filename');
      if ANode <> nil then
        S := S + ChangeFileExt(Copy(ANode.InputToken, 2, Length(ANode.InputToken) - 2), '') + ', ';
    end;
  end;
  if ok and (Length(S) > 1) then
    S := Copy(S, 1, Length(S) - 2) + ';' + #13#10#13#10
  else
    S := '';
  result := S;
end;

function TForm1.DeclareChange(Node: TNoTerminalNode): string;
// <declare>:[(<directive> )] {<returntype> [<directive>] [<classname>"::"["~"]]<functionname> "("
//                                         |[<directive>] [<classname>"::"["~"]]<functionname> "("}
//                                         [<parameters>] ")" [":" <call>]
var
  rtype: TNoTerminalNode;
  classnode: TNoTerminalNode;
  nome: TNoTerminalNode;
  call: TNoTerminalNode;
  params: TNoTerminalNode;

  strfunc: string;
  strnome: string;
  strclass: string;
  strparams: string;
  strresult: string;
  strend: string;
  i: integer;
begin
  rtype := Node.Nodes.FindByNoTerminalName('returntype');
  classnode := Node.Nodes.FindByNoTerminalName('classname');
  nome := Node.Nodes.FindByNoTerminalName('functionname');
  call := Node.Nodes.FindByNoTerminalName('call');
  params := Node.Nodes.FindByNoTerminalName('parameters');

  if (call <> nil) then
  begin
    strfunc := 'constructor';
    strresult := '';
  end
  else
  if Pos('~', Node.InputToken) <> 0 then
  begin
    strfunc := 'destructor';
    strresult := '';
  end
  else
  if (rtype = nil) or (SameText('void', trim(rtype.InputToken))) then
  begin
    strfunc := 'procedure';
    strresult := '';
  end
  else
  begin
    strfunc := 'function';
    strresult := ': ' + ConvertType(rtype.InputToken)
  end;
  if classnode <> nil then
    strclass := classnode.InputToken + '.'
  else
    strclass := '';

  strnome := nome.InputToken;

  if params <> nil then
    strparams := params.InputToken
  else
    strparams := '';

  i := Length(Node.InputToken);
  strend := '';
  while (Node.InputToken[i] = #13) or (Node.InputToken[i] = #10) do
  begin
    strend := Node.InputToken[i] + strend;
    dec(i);
  end;

  result := Format('%s %s%s(%s)%s;%s',
    [strfunc, strclass, strnome, strparams, strresult, strend]);
end;

function TForm1.BlockChange(Node: TNoTerminalNode): string;
var
  i: integer;
  S2: string;
begin
  result := Node.InputToken;
  i := 1;
  while (i <= Length(result)) and (result[i] <> '{') do
    inc(i);
  Delete(result, i, 1);
  S2 := 'begin';
  if result[i] <> ' ' then
    S2 := 'begin ';
    
  Insert(S2, result, i);
  i := Length(result);
  while (i > 0) and (result[i] <> '}') do
    dec(i);
  Delete(result, i, 1);
  S2 := 'end;';
  if (result[i - 1] <> ' ') and (result[i - 1] <> #10) and (result[i - 1] <> #13) then
    S2 := ' end;';
  Insert(S2, result, i);
end;

function TForm1.DeclareVarChange(Node: TNoTerminalNode): string;
//    '<declarevar>:<type> {<assign>|<id>[ "[" <indexcount> "]" ]} [(, {<assign>|<id>[ "[" <indexcount> "]" ]})]'#13#10+
var
  typenode: TNoTerminalNode;
  strtype: string;
  i: integer;
  VarNode: TNoTerminalNode;

  strid: string;
  newtoken: string;
  vartoken: string;

  DeclareNode: TNoTerminalNode;
  indexstr: string;
begin
  //typenode := Node.Nodes.FindByNoTerminalName('type');
  typenode := Node.Nodes[0];
  strtype := ConvertType(typenode.InputToken);

  newtoken := '';
  vartoken := '';

  i := 1;
  while i < Node.Nodes.Count do
  begin
    VarNode := Node.Nodes[i];
    if SameText(VarNode.NoTerminal.IdS, 'assign') then
    begin
      strid := Trim(Copy(VarNode.InputToken, 1, Pos(':=', VarNode.InputToken) - 1));
      if newtoken <> '' then newtoken := newtoken + '; ';
      newtoken := newtoken + VarNode.InputToken;
    end else
    if SameText(VarNode.NoTerminal.Ids, 'id') then
    begin
      strid := VarNode.InputToken;
      if newtoken <> '' then newtoken := newtoken + '; ';
      newtoken := newtoken + '{' + VarNode.InputToken + '}';

      if (i + 1 < Node.Nodes.Count) and (SameText(Node.Nodes[i + 1].NoTerminal.Ids, 'indexcount')) then
      begin
        //Tem indice
        indexstr := Node.Nodes[i + 1].InputToken;
        strtype := Format('array[0..%s - 1] of %s', [indexstr, strtype]);
        inc(i);
      end;

    end else
      raise Exception.Create('Internal error: declarevar needs an "assign" or "id" node.');

    if vartoken <> '' then vartoken := vartoken + ', ';
    vartoken := vartoken + strid;

    inc(i);
  end;

  {now find the node that contains the function declaration, so that we put the variable declaration just below}
  DeclareNode := Node.ParentNode;
  while (DeclareNode <> nil) and not SameText('function', DeclareNode.NoTerminal.Ids) do
    DeclareNode := DeclareNode.ParentNode;

  {if it's not nil, then the variable is declared inside a function. Otherwise, it's a global declaration}
  if DeclareNode <> nil then
  begin
    vartoken := Format('  %s: %s;'#13#10, [vartoken, strtype]);

    {the declare node is the very first inside the function. Here we can call ChangeNodeString because
     the event of declare node has been already called when we reach this point}
    DeclareNode := DeclareNode.Nodes[0];
    if FDeclareNodes.IndexOf(DeclareNode) = -1 then
    begin
      {if Copy(DeclareNode.InputToken, Length(DeclareNode.InputToken) - 2, 2) <> #13#10 then
        vartoken := #13#10 + vartoken;}
      vartoken := 'var'#13#10 + vartoken;
      FDeclareNodes.Add(DeclareNode);
    end;

    DeclareNode.ChangeNodeString(DeclareNode.InputToken + vartoken);
    DeclareNode.DisplayName := '*';
  end else
  begin
    newtoken := Format('var %s: %s', [vartoken, strtype]);
  end;

  result := newtoken;
end;

destructor TForm1.Destroy;
begin
  FParser.Free;
  FIncParser.Free;
  FDeclareNodes.Free;
  inherited;
end;

procedure TForm1.Collapseall1Click(Sender: TObject);
begin
  TreeView1.FullCollapse;
end;

procedure TForm1.Expandall1Click(Sender: TObject);
begin
  TreeView1.FullExpand;
end;

procedure TForm1.DoConvert;
var
  AUnitName: string;
begin
  AddResult('converting .h include...');
  FDeclareNodes.Clear;
  mmPascal.BeginUpdate;
  try
    mmPascal.Lines.Clear;
    AUnitName := ExtractFileName(ChangeFileExt(OpenDialog1.FileName, ''));
    if AUnitName = '' then
      AUnitName := 'ConvertedSource';
    mmPascal.Lines.Add(Format('unit %s;', [AUnitName]));
    mmPascal.Lines.Add('');
    mmPascal.Lines.Add('interface');
    mmPascal.Lines.Add('');
    mmPascal.Lines.Text := mmPascal.Lines.Text + FIncParser.RebuildFromNodes;

    AddResult('.h include converted succesfully.');
    AddResult('converting .cpp source...');
    mmPascal.Lines.Add('');
    mmPascal.Lines.Add('implementation');
    mmPascal.Lines.Add('');
    mmPascal.Lines.Text := mmPascal.Lines.Text + FParser.RebuildFromNodes;

    mmPascal.Lines.Add('');
    mmPascal.Lines.Add('end.');

    AddResult('.cpp source converted succesfully.');
  finally
    mmPascal.EndUpdate;
  end;
  PageControl1.ActivePage := tsConverted;
end;

procedure TForm1.acOpenExecute(Sender: TObject);
var
  Ext: string;
  HFile, CPPFile: string;
begin
  if OpenDialog1.Execute then
  begin
    Ext := LowerCase(ExtractFileExt(OpenDialog1.FileName));
    if (Ext = '.h') or (Ext = '.hpp') then
    begin
      HFile := OpenDialog1.FileName;
      if FileExists(ChangeFileExt(HFile, '.cpp')) then
        CPPFile := ChangeFileExt(HFile, '.cpp');
    end
    else {.cpp}
    begin
      CPPFile := OpenDialog1.FileName;
      if FileExists(ChangeFileExt(CPPFile, '.hpp')) then
        HFile := ChangeFileExt(CPPFile, '.hpp')
      else
      if FileExists(ChangeFileExt(CPPFile, '.h')) then
        HFile := ChangeFileExt(CPPFile, '.h');
    end;

    if FileExists(CPPFile) then
    begin
      AdvMemo1.Lines.LoadFromFile(CPPFile);
      Pagecontrol1.ActivePage := tsSource;
    end;

    if FileExists(HFile) then
    begin
      AdvMemo2.Lines.LoadFromFile(HFile);
      if not FileExists(CPPFile) then
        PageControl1.ActivePage := tsInclude;
    end;
  end;
end;

procedure TForm1.acConvertExecute(Sender: TObject);
begin
  PrepareParser(FParser);
  PrepareParser(FIncParser);
  if DoParse then                                          
  begin
    InternalBuildSyntaxTree;
    DoConvert;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ForceCurrentDirectory := true;
  PageControl1.ActivePage := tsSource;
  mmGrammar.Lines.Text := CPPGrammar;
end;

procedure TForm1.acSaveCPPExecute(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    AdvMemo1.Lines.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TForm1.acSaveHExecute(Sender: TObject);
begin
  if SaveDialog2.Execute then
  begin
    AdvMemo2.Lines.SaveToFile(SaveDialog2.FileName);
  end;
end;

end.
