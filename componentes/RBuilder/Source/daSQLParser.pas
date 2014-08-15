{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit daSQLParser;

interface

uses
  SysUtils,
  Classes,

  ppCollectionBase,
  ppUtils,
  ppParameter,
  ppTypes,

  {$IFDEF UniCode}
  daSynUHighlighterSQL,
  ppSynUEdit;
{$ELSE}
  daSynHighlighterSQL,
  ppSynEdit;
{$ENDIF}


type

  {  SQLText --> SQLParser --> SQLTokens --> SQLTokenReader --> SQLQueryExpression

     parse sql text into tokens
     use token reader to process a token collection

     use query expression to read tokens...

       lQueryExpression := TdaSQLQueryExpression.Create();
       lQueryExpression.Read(aSQLText: String);

     and build a model like this..

       QueryExpression
         SelectClause
         FromClause
         ...

         SQLTokens[ ]
         Text: String

     The SQLText can contain parameters that look like, :ParamName.

         GetCommandText(aParameterList: TppParameterList);

  }

  {TdaSQLToken

    Represents a single token of a SQL statement. Tokens are created by
    TdaSQLParser. }

  TdaSQLToken = class
  private
    FAbsolutePos: Integer;
    FLineNo: Integer;
    FPos: Integer;
    FTokenKind: TtkTokenKind;
    FValue: string;

    function GetDescription: String;

  public
    procedure Assign(aToken: TdaSQLToken);

    function Clone: TdaSQLToken;
    
    function IsKeyWord(aKeyWord: String): Boolean;
    function IsOpenParen: Boolean;
    function IsCloseParen: Boolean;
    function IsComment: Boolean;
    function IsEqualTo(aToken: TdaSQLToken): Boolean;
    function IsSymbol(aSymbol: String): Boolean;
    function IsParameter: Boolean;
    function IsSpace: Boolean;

    property AbsolutePos: Integer read FAbsolutePos write FAbsolutePos;
    property Description: String read GetDescription;
    property LineNo: Integer read FLineNo write FLineNo;
    property Pos: Integer read FPos write FPos;
    property TokenKind: TtkTokenKind read FTokenKind write FTokenKind;
    property Value: string read FValue write FValue;
    
  end;

  {TdaSQLTokenCollection}
  TdaSQLTokenCollection = class(TppCollectionBase)
  private
    function GetDescription: string;
    function GetItems(Index: Integer): TdaSQLToken;
    function GetText: string;
  public
    procedure Add(aToken: TdaSQLToken);  overload;
    procedure Add(aTokens: TdaSQLTokenCollection); overload;
    function Clone: TdaSQLTokenCollection;
    property Description: string read GetDescription;
    property Items[Index: Integer]: TdaSQLToken read GetItems; default;
    property Text: string read GetText;

  end;

  {TdaSQLTokenReader

    Used to navigate over a token collection. }

  TdaSQLTokenReader = class
  private
    FBOF: Boolean;
    FEOF: Boolean;
    FIndex: Integer;
    FIndexEnd: Integer;
    FIndexStart: Integer;
    FTokens: TdaSQLTokenCollection;
    function GetCurrentToken: TdaSQLToken;
    function GetPriorToken: TdaSQLToken;
    function GetNextToken: TdaSQLToken;
    procedure SetIndex(aIndex: Integer);

  public
    constructor Create(aTokens: TdaSQLTokenCollection);

    function CheckForKeyWordPair(aKeyWord1, aKeyWord2: String): Boolean;
    function CheckForKeyWord(aKeyWord: String): Boolean;
    function CheckForKeyWords(aKeyWords: array of string): Boolean;
    function CheckForOperator: Boolean;
    function CheckForSymbol(aSymbol: String): Boolean;
    function CheckForSymbolPair(aSymbol1, aSymbol2: String): Boolean;
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
    function ReadOperator: String;
    procedure SkipSpaces;
    procedure SkipPriorSpaces;

    property BOF: Boolean read FBOF;
    property CurrentToken: TdaSQLToken read GetCurrentToken;
    property PriorToken: TdaSQLToken read GetPriorToken;
    property EOF: Boolean read FEOF;
    property Index: Integer read FIndex write SetIndex;
    property IndexEnd: Integer read FIndexEnd write FIndexEnd;
    property IndexStart: Integer read FIndexStart write FIndexStart;
    property NextToken: TdaSQLToken read GetNextToken;
    property Tokens: TdaSQLTokenCollection read FTokens;
  end;

  {TdaSQLParser

    Tokenizes a SQL statement. Does not check syntax, simply breaks the
    SQL text into tokens that represent key words, literals, identifiers,
    operators, variables, etc.}

  TdaSQLParser = class
  private
    FAbsolutePos: Integer;
    FSQLText: TStrings;
    FTokenParser: TdaSynHighlighterSQL;
    FTokens: TdaSQLTokenCollection;

    procedure FreeTokens;
    function GetTokens: TdaSQLTokenCollection;

  protected
    procedure TokenizeLine(aLineNo: Integer);
  public

    constructor Create; virtual;
    destructor Destroy; override;

    procedure Tokenize(aSQLText: TStrings; aDatabaseType: TppDatabaseType = dtOther);

    property Tokens: TdaSQLTokenCollection read GetTokens;

  end;


  TdaSQLQueryItem = class;

  {TdaSQLExpressionBase,

    Abstract base class. Represents an expression. If the expression starts
    with an open paren, then it must end with a matching close paren.}

  TdaSQLExpressionBase = class
  private
    FDatabaseType: TppDatabaseType;
    FEndIndex: Integer;
    FEndOfExpression: Boolean;
    FErrorDescr: string;
    FIsValid: Boolean;
    FParenCount: Integer;
    FSQLParser: TdaSQLParser;
    FStartIndex: Integer;
    FStartsWithParen: Boolean;
    FTokens: TdaSQLTokenCollection;

    function GetTokens: TdaSQLTokenCollection;

  protected
    function GetText: String; virtual;
    procedure ReadInitialize(aReader: TdaSQLTokenReader); virtual;
    procedure ReadFinalize(aReader: TdaSQLTokenReader); virtual;
    procedure ReadTokens(aReader: TdaSQLTokenReader); virtual;
    procedure ReadToken(aReader: TdaSQLTokenReader); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean; virtual;
    function CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean; virtual;
    function Read(aReader: TdaSQLTokenReader): Boolean; overload; virtual;
    function Read(aSQLTokens: TdaSQLTokenCollection): Boolean; overload;
    function Read(aSQLText: TStrings): Boolean; overload;
    function Read(aSQLText: string): Boolean; overload;
    property DatabaseType: TppDatabaseType read FDatabaseType write FDatabaseType;
    property ErrorDescr: string read FErrorDescr write FErrorDescr;
    property ParenCount: Integer read FParenCount write FParenCount;
    property StartsWithParen: Boolean read FStartsWithParen write FStartsWithParen;
    property Tokens: TdaSQLTokenCollection read GetTokens;

//  published
    property IsValid: Boolean read FIsValid write FIsValid;
    property Text: String read GetText;

  end;

//  TdaSQLKeyWordTokens = (kwSelect, kwAll, kwDistinct, kwFrom, kwWhere,

  TdaSQLSelectTokenState = (tsSelect, tsAll, tsDistinct, tsStar, tsSelectItemList);

  TdaSQLSelectItemReadState = (rsColumnRef, rsExpression, rsAliasPrefix, rsAlias);

  {TdaSQLSelectItem

    Represents a single item in a Select clause.

       Expression [As] [Alias]
  }

  TdaSQLSelectItem = class(TdaSQLExpressionBase)
  private
    FAlias: string;
    FAliasPrefix: string;
    FExpression: String;
    FItemReadState: TdaSQLSelectItemReadState;
  protected
    function CheckEndOfSelectItem(aReader: TdaSQLTokenReader): Boolean;
    procedure ReadInitialize(aReader: TdaSQLTokenReader); override;
    procedure ReadToken(aReader: TdaSQLTokenReader); override;
  public
    function CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
    property Alias: string read FAlias write FAlias;
    property AliasPrefix: string read FAliasPrefix write FAliasPrefix;
    property Expression: String read FExpression write FExpression;
  end;



  TdaSQLSelectItemCollection = class(TppCollectionBase)
  private
    function GetDescription: string;
    function GetItems(Index: Integer): TdaSQLSelectItem;
  public
    constructor Create; override;

    procedure Add(aItem: TdaSQLSelectItem);
    property Description: string read GetDescription;
    property Items[Index: Integer]: TdaSQLSelectItem read GetItems; default;
  end;

  {TdaSQLSelectClause

    Represents the Select clause of a SQL Query Expression

  }
  TdaSQLSelectClause = class(TdaSQLExpressionBase)
  private
    FAll: Boolean;
    FWildcard: Boolean;
    FDistinct: Boolean;
    FSelectItems: TdaSQLSelectItemCollection;
  protected
    procedure ReadInitialize(aReader: TdaSQLTokenReader); override;
    procedure ReadSelectItems(aReader: TdaSQLTokenReader);
    procedure ReadToken(aReader: TdaSQLTokenReader); override;
    procedure ReadTokens(aReader: TdaSQLTokenReader); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
    function CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
    property All: Boolean read FAll write FAll;
    property Wildcard: Boolean read FWildcard write FWildcard;
    property Distinct: Boolean read FDistinct write FDistinct;
    property SelectItems: TdaSQLSelectItemCollection read FSelectItems;
  end;


  { 1. parse into search items
          - find separators: AND/OR keywords

    2. determine search item type:

         ?? - TdaCriteriaType = (dacrField, dacrOR, dacrNOT, dacrBegin, dacrEnd);

         TdaCriteriaOperatorType = (dacoEqual, dacoNotEqual,
                             dacoLessThan, dacoLessThanOrEqualTo,
                             dacoGreaterThan, dacoGreaterThanOrEqualTo,
                             dacoLike, dacoNotLike,
                             dacoBetween, dacoNotBetween,
                             dacoInList, dacoNotInList,
                             dacoBlank, dacoNotBlank);

    3. parse search item into Expr Operator Expr

    4. Determine whether Expr is a ColumnRef

    5. Identify Variables

  }

  TdaSQLSearcItemReadState = (rsPrefix, rsExpression1, rsOperator, rsExpression2, rsSuffix);

  {TdaSQLSearchItem

    Represents a single item in a SQL Where clause}
  TdaSQLSearchItem = class(TdaSQLExpressionBase)
    //Prefix: (Not)
    // Expression1
    // SearchOperator
    // Expression2
    // Suffix: And/Or
    // ContainsParameter

    // ParamValue
    // AutoSearch
    // Mandatory
    // ShowAll
  private
    FAutoSearch: Boolean;
    FContainsParameter: Boolean;
    FExpression1: string;
    FExpression2: string;
    FExprStartingParenCount: Integer;
    FItemReadState: TdaSQLSearcItemReadState;
    FOperator: string;
    FParamName: string;
    FPrefix: string;
    FSuffix: string;
  protected
    function CheckEndOfSearchItem(aReader: TdaSQLTokenReader): Boolean;
    function CheckEndOfWhere(aReader: TdaSQLTokenReader): Boolean;
    procedure ReadInitialize(aReader: TdaSQLTokenReader); override;
    procedure ReadToken(aReader: TdaSQLTokenReader); override;
  public
    function CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
    function GenerateText: String;

    property Suffix: string read FSuffix write FSuffix;
    property Prefix: string read FPrefix write FPrefix;
    property Expression1: string read FExpression1 write FExpression1;
    property Operator: string read FOperator write FOperator;
    property AutoSearch: Boolean read FAutoSearch write FAutoSearch;
    property ContainsParameter: Boolean read FContainsParameter write FContainsParameter;
    property Expression2: string read FExpression2 write FExpression2;
    property ParamName: string read FParamName write FParamName;
  end;

  TdaSQLSearchItemCollection = class(TppCollectionBase)
  private
    function GetDescription: string;
    function GetItems(Index: Integer): TdaSQLSearchItem;
  public
    constructor Create; override;
    procedure Add(aItem: TdaSQLSearchItem);
    property Description: string read GetDescription;
    property Items[Index: Integer]: TdaSQLSearchItem read GetItems; default;
  end;

  {TdaSQLFromClause

    Represents the From clause of a SQL Query Expression}
  TdaSQLFromClause = class(TdaSQLExpressionBase)
  private
  protected
    procedure ReadInitialize(aReader: TdaSQLTokenReader); override;
    procedure ReadToken(aReader: TdaSQLTokenReader); override;
  public
    function CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
    function CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
  end;

  {TdaSQLWhereClause

    Represents the Where clause of a SQL Query Expression}

  TdaSQLWhereClause = class(TdaSQLExpressionBase)
  private
    FParenPairs: Integer;
    FSearchItems: TdaSQLSearchItemCollection;
  protected
    function CheckEndOfWhere(aReader: TdaSQLTokenReader): Boolean;
    procedure ReadSearchItems(aReader: TdaSQLTokenReader);
    procedure ReadInitialize(aReader: TdaSQLTokenReader); override;
    procedure ReadToken(aReader: TdaSQLTokenReader); override;
    procedure ReadTokens(aReader: TdaSQLTokenReader); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Add(aSearchExpressionText: string);
    function CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
    function CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
    property SearchItems: TdaSQLSearchItemCollection read FSearchItems;
  end;


  {TdaSQLGroupByClause

    Represents the Group By clause of a SQL Query Expression}

  TdaSQLGroupByClause = class(TdaSQLExpressionBase)
  private
  protected
    procedure ReadInitialize(aReader: TdaSQLTokenReader); override;
    procedure ReadToken(aReader: TdaSQLTokenReader); override;
  public
    function CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
    function CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
  end;


  {TdaSQLHavingClause

    Represents the Having clause of a SQL Query Expression}
 TdaSQLHavingClause = class(TdaSQLWhereClause)
  private
  protected
    function CheckEndOfHaving(aReader: TdaSQLTokenReader): Boolean;
  public
    function CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
    function CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
  end;


  {TdaSQLOrderByClause

    Represents the Order By clause of a SQL Query Expression}
  TdaSQLOrderByClause = class(TdaSQLExpressionBase)
  private
  protected
    procedure ReadInitialize(aReader: TdaSQLTokenReader); override;
    procedure ReadToken(aReader: TdaSQLTokenReader); override;
  public
    function CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
    function CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
  end;

  {TdaSQLUnionClause

    Represents the From clause of a SQL Query Expression}
  TdaSQLUnionClause = class(TdaSQLExpressionBase)
  private
  protected
    procedure ReadInitialize(aReader: TdaSQLTokenReader); override;
    procedure ReadToken(aReader: TdaSQLTokenReader); override;
  public
    function CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
    function CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean; override;
  end;


  TdaSQLClauseType = (ctSelect, ctFrom, ctWhere, ctGroupBy, ctHaving, ctUnion, ctOrderBy, ctOther);

  {TdaSQLQueryItem

    Represents a SQL query item that can participate in a union. Basically
    includes everthing but the Order By clause.

    TdaSQLQueryExpression descends from TdaSQLQueryItem and represents a full
    SQL query expression that can include unions and order by.


    TdaSQLQueryItem
      Select
      From
      Where
      GroupBy
      Having
    end;
  }

  TdaSQLQueryItem = class
  private
    FDatabaseType: TppDatabaseType;
    FErrorClauseType: TdaSQLClauseType;
    FErrorDescr: string;
    FFromClause: TdaSQLFromClause;
    FGroupByClause: TdaSQLGroupByClause;
    FHavingClause: TdaSQLHavingClause;
    FIsSubQuery: Boolean;
    FIsValid: Boolean;
    FSelectClause: TdaSQLSelectClause;
    FSQLParser: TdaSQLParser;
    FUnionClause: TdaSQLUnionClause;
    FUnionPrefix: string;
    FWhereClause: TdaSQLWhereClause;
    function GetSQLTokens: TdaSQLTokenCollection;
  protected
    function CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean;
    function CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean;
    function CheckIsSubQuery(aReader: TdaSQLTokenReader): Boolean;
    function GetText: String; virtual;
    procedure SetDatabaseType(const Value: TppDatabaseType); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function Read(aReader: TdaSQLTokenReader): Boolean; overload; virtual;
    function Read(aSQLText: TStrings): Boolean; overload; virtual;
    function Read(aSQLTokens: TdaSQLTokenCollection): Boolean; overload; virtual;

    property DatabaseType: TppDatabaseType read FDatabaseType write SetDatabaseType;
    property ErrorClauseType: TdaSQLClauseType read FErrorClauseType write FErrorClauseType;
    property ErrorDescr: string read FErrorDescr write FErrorDescr;
    property IsSubQuery: Boolean read FIsSubQuery;

    property SelectClause: TdaSQLSelectClause read FSelectClause;
    property FromClause: TdaSQLFromClause read FFromClause;
    property WhereClause: TdaSQLWhereClause read FWhereClause;
    property GroupByClause: TdaSQLGroupByClause read FGroupByClause;
    property HavingClause: TdaSQLHavingClause read FHavingClause;
    property IsValid: Boolean read FIsValid write FIsValid;
    property SQLTokens: TdaSQLTokenCollection read GetSQLTokens;
    property Text: String read GetText;
    property UnionClause: TdaSQLUnionClause read FUnionClause;
    property UnionPrefix: string read FUnionPrefix write FUnionPrefix;

  end;

  {TdaSQLQueryItemCollection}
  TdaSQLQueryItemCollection = class(TppCollectionBase)
  private
    function GetText: string;
    function GetItems(Index: Integer): TdaSQLQueryItem;

  public
    constructor Create; override;

    procedure Add(aItem: TdaSQLQueryItem);
    property Text: string read GetText;
    property Items[Index: Integer]: TdaSQLQueryItem read GetItems; default;
  end;


  {TdaSQLQueryExpression

    Represents a SQL query expression that consists of a main query and optional
    unions and Order By clause.

    TdaSQLQueryExpression descends from TdaSQLQueryItem and represents a full
    SQL query expression that can include unions and order by.


    TdaSQLQueryExpression = class(TdaSQLQueryItem)
      Select
      From
      Where
      GroupBy
      Having
      Unions: TdaSQLQueryItem
      OrderBy

      Parameters[ ]
    end;

  }
  TdaSQLQueryExpression = class(TdaSQLQueryItem)
  private
    FOrderByClause: TdaSQLOrderByClause;
    FParameters: TppParameterList;
    FUnions: TdaSQLQueryItemCollection;
    procedure ReadParameters(aReader: TdaSQLTokenReader);

  protected
    function GetText: String; override;
    procedure SetDatabaseType(const Value: TppDatabaseType); override;

  public
    constructor Create; override;
    destructor Destroy; override;
    function GetCommandText: string;

    function Read(aReader: TdaSQLTokenReader): Boolean; overload; override;

    property Unions: TdaSQLQueryItemCollection read FUnions;
    property OrderByClause: TdaSQLOrderByClause read FOrderByClause;
    property Parameters: TppParameterList read FParameters;
  end;


  {TdaSQLParams

    *** currently not used ***

    Represents a collection of Params associated with a QueryExpression.

    For cases in which the QueryExpression can be fully parsed, the Params
    can be extracted from the SearchItems associated with the Where and Having
    clause.

    For cases in which the QueryExpression cannot be fully parsed, the
    SQL Tokens can be parsed into a Params collection.


    In this latter case, TdaSQLParams looks for tkVariable tokens - which denote
    occurrences of :ParamName    - Parameter

    note: Rather than define ParamItem and ParamItemCollection classes, the
          SearchItem, SearchItemCollection classes are used.
  }

 {$IFDEF notused}
  TdaSQLParams = class(TdaSQLSearchItemCollection)
  private
    procedure ReadParam(aReader: TdaSQLTokenReader);

  protected
    procedure ExtractFromQueryItem(aQueryItem: TdaSQLQueryItem); virtual;
    procedure ExtractFromSearchItems(aSearchItems: TdaSQLSearchItemCollection);


  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Read(aSQLTokens: TdaSQLTokenCollection); overload;
    procedure Read(aReader: TdaSQLTokenReader); overload; virtual;
    procedure Read(aQueryExpression: TdaSQLQueryExpression); overload; virtual;
  end;

 {$ENDIF}

  function ppDatabaseTypeToSQLDialect(aDatabaseType: TppDatabaseType): TSQLDialect;

implementation

function ppDatabaseTypeToSQLDialect(aDatabaseType: TppDatabaseType): TSQLDialect;
begin

//  TppDatabaseType = (dtAdvantage, dtInterBase, dtMSAccess, dtMSSQLServer,
//                     dtSybaseASE, dtSybaseASA, dtOracle, dtParadox, dtElevateDB, dtDBISAM, dtFlashFiler, dtMySQL, dtApollo, dtPostgreSQL, dtNexusDB, dtOther);

//  TSQLDialect = (sqlStandard, sqlInterbase6, sqlMSSQL7, sqlMySQL, sqlOracle,
//    sqlSybase, sqlIngres, sqlMSSQL2K);


  case aDatabaseType of
    dtMSSQLServer:
      Result := sqlMSSQL2K;
    dtInterbase, dtFirebird:
      Result := sqlInterbase6;
    dtOracle:
      Result := sqlOracle;
    dtMySQL:
      Result := sqlMySQL;
    dtSybaseASE:
      Result := sqlSybase;
  else
    Result := sqlStandard;

  end;

end;


procedure TdaSQLTokenCollection.Add(aToken: TdaSQLToken);
begin
  InnerList.Add(aToken);
end;

procedure TdaSQLTokenCollection.Add(aTokens: TdaSQLTokenCollection);
var
  liIndex: Integer;
begin

  for liIndex := 0 to aTokens.Count - 1 do
    Add(aTokens[liIndex]);
    
end;

function TdaSQLTokenCollection.Clone: TdaSQLTokenCollection;
var
  lCollection: TdaSQLTokenCollection;
  lToken: TdaSQLToken;
  liIndex: Integer;
begin
  lCollection := TdaSQLTokenCollection.Create;

  for liIndex := 0 to Self.Count - 1 do
    begin
      lToken :=  Self[liIndex].Clone();
      lCollection.Add(lToken);
    end;

  Result := lCollection;

end;

function TdaSQLTokenCollection.GetDescription: string;
var
  liIndex: Integer;
begin

  Result := '';

  for liIndex := 0 to Count - 1 do
    begin
      if liIndex > 0 then
        Result := Result + #13#10;

       Result := Result + Items[liIndex].Description;
    end;

end;

function TdaSQLTokenCollection.GetItems(Index: Integer): TdaSQLToken;
begin
  Result := TdaSQLToken(InnerList[Index]);
end;

function TdaSQLTokenCollection.GetText: string;
var
  liIndex: Integer;
  liLineNo: Integer;
begin

  if Count = 0 then
    Result := ''
  else
    begin
      liLineNo := Items[0].LineNo;

      for liIndex := 0 to Count - 1 do
        begin
          // add line breaks when LineNo changes
          if liLineNo <> Items[liIndex].LineNo then
            begin
//              Result := Result + #13#10;
              liLineNo := Items[liIndex].LineNo;
            end;

          // build text string
          Result := Result + Items[liIndex].Value;

        end;
      
    end;


end;

constructor TdaSQLParser.Create;
begin

  inherited;

  FTokens := TdaSQLTokenCollection.Create;
  FSQLText := TStringList.Create;

end;

destructor TdaSQLParser.Destroy;
begin

  FreeTokens();

  FTokens.Free;
  FTokens := nil;

  FSQLText.Free;
  FSQLText := nil;

  inherited;

end;

procedure TdaSQLParser.FreeTokens;
var
  liIndex: Integer;
begin

  for liIndex := FTokens.Count-1 downto 0 do
    FTokens[liIndex].Free;

  FTokens.Clear();

end;

function TdaSQLParser.GetTokens: TdaSQLTokenCollection;
begin
   Result := FTokens;
end;

procedure TdaSQLParser.Tokenize(aSQLText: TStrings; aDatabaseType: TppDatabaseType = dtOther);
var
  liLineNo: Integer;
begin
  FAbsolutePos := 0;
  FreeTokens();

  FSQLText.Assign(aSQLText);

  FTokenParser := TdaSynHighlighterSQL.Create(nil);
  FTokenParser.SQLDialect := ppDatabaseTypeToSQLDialect(aDatabaseType);

  try

    for liLineNo := 0 to FSQLText.Count - 1 do
      TokenizeLine(liLineNo);
      
  finally
    FTokenParser.Free;
    FTokenParser := nil;
  end;

end;

procedure TdaSQLParser.TokenizeLine(aLineNo: Integer);
var
  lToken: TdaSQLToken;
  liStartPos: Integer;
begin

  // pars the line, including the line break chars
  FTokenParser.SetLine(FSQLText[aLineNo] + #13#10, aLineNo);

  liStartPos := FAbsolutePos;

  while not FTokenParser.GetEol do
    begin
      lToken := TdaSQLToken.Create;
      lToken.TokenKind := FTokenParser.GetTokenID;
      lToken.Value := FTokenParser.GetToken;
      lToken.LineNo := aLineNo;
      lToken.Pos := FTokenParser.GetTokenPos;
      lToken.AbsolutePos := liStartPos + lToken.Pos;

      FAbsolutePos := liStartPos + lToken.Pos;

      FTokens.Add(lToken);

      FTokenParser.Next;
    end;

    FAbsolutePos := FAbsolutePos + 1;

end;

constructor TdaSQLTokenReader.Create(aTokens: TdaSQLTokenCollection);
begin
  inherited Create;

  FTokens := aTokens;

  if (FTokens.Count > 0) then
    begin
      FIndexStart := 0;
      FIndexEnd := FTokens.Count-1;
    end
  else
    begin
      FIndexStart := -1;
      FIndexEnd := -1;
      FBOF := True;
      FEOF := True;
    end;

end;

function TdaSQLTokenReader.CheckForKeyWordPair(aKeyWord1, aKeyWord2: String): Boolean;
var
  liSaveIndex: Integer;
begin
  liSaveIndex := Index;

  //SkipSpaces;

  Result := not FEof and CurrentToken.IsKeyWord(aKeyWord1);

  if Result then
    begin
      Next;
      SkipSpaces;
    end;

  Result := Result and CurrentToken.IsKeyWord(aKeyWord2);

  SetIndex(liSaveIndex);

end;

function TdaSQLTokenReader.CheckForKeyWord(aKeyWord: String): Boolean;
var
  liSaveIndex: Integer;
begin
  liSaveIndex := Index;

//  SkipSpaces;

  Result := not FEof and CurrentToken.IsKeyWord(aKeyWord);

  SetIndex(liSaveIndex);

end;

function TdaSQLTokenReader.CheckForKeyWords(aKeyWords: array of string): Boolean;
var
  liSaveIndex: Integer;
  liCount: Integer;
  liIndex: Integer;
  lbFound: Boolean;
begin
  liSaveIndex := Index;

  liCount := Length(aKeyWords);
  liIndex := 0;
  lbFound := True;

  while lbFound and (liIndex < liCount) do
    begin
      lbFound := CurrentToken.IsKeyWord(aKeyWords[liIndex]);
      Inc(liIndex);
      Next;
      SkipSpaces;
    end;

  Result := lbFound;

  SetIndex(liSaveIndex);

end;

function TdaSQLTokenReader.CheckForOperator: Boolean;
begin
// TODO - add checks for outer join operators such as '(*) ='
  Result := CheckForSymbolPair('<' , '>') or

            CheckForSymbol('<') or CheckForSymbol('=') or
            CheckForSymbol('>')  or CheckForSymbol('!=') or
            CheckForSymbol('>=') or  CheckForSymbol('<=') or

            CheckForKeyWords(['Not', 'Like']) or CheckForKeyWords(['Not', 'Between']) or
            CheckForKeyWords(['Not', 'In']) or CheckForKeyWords(['Is', 'Null']) or
            CheckForKeyWords(['Is', 'Not', 'Null']) or

            CheckForKeyWord('Like') or CheckForKeyWord('In') or
            CheckForKeyWord('Between');

end;

function TdaSQLTokenReader.CheckForSymbol(aSymbol: String): Boolean;
var
  liSaveIndex: Integer;
begin
  liSaveIndex := Index;

  Result := not FEof and CurrentToken.IsSymbol(aSymbol);

  SetIndex(liSaveIndex);

end;

function TdaSQLTokenReader.CheckForSymbolPair(aSymbol1, aSymbol2: String): Boolean;
var
  liSaveIndex: Integer;
begin
  liSaveIndex := Index;

  Result := not FEof and CurrentToken.IsSymbol(aSymbol1);

  Next;

  Result := Result and CurrentToken.IsSymbol(aSymbol2);

  SetIndex(liSaveIndex);

end;

procedure TdaSQLTokenReader.First;
begin
  SetIndex(FIndexStart);
end;

function TdaSQLTokenReader.GetCurrentToken: TdaSQLToken;
begin
  if (FIndex >= FIndexStart) and (FIndex <= FIndexEnd) then
    Result := FTokens[FIndex]
  else
    Result := nil;
end;

function TdaSQLTokenReader.GetPriorToken: TdaSQLToken;
begin
  if FIndex > FIndexStart then
    Result := FTokens[FIndex-1]
  else
    Result := nil;
end;

function TdaSQLTokenReader.GetNextToken: TdaSQLToken;
begin
  if (FIndex < (FIndexEnd)) then
    Result := FTokens[FIndex+1]
  else
    Result := nil;
end;

procedure TdaSQLTokenReader.Last;
begin
  SetIndex(FIndexEnd);
end;

procedure TdaSQLTokenReader.Next;
begin
  SetIndex(FIndex+1);
end;

procedure TdaSQLTokenReader.Prior;
begin
  SetIndex(FIndex-1);
end;

function TdaSQLTokenReader.ReadOperator: String;
var
  liLength: Integer;
  liIndex: Integer;
begin

  if CheckForSymbolPair('<' , '>') then

     liLength := 2

  else if CheckForSymbol('<') or CheckForSymbol('=') or
          CheckForSymbol('>') or CheckForSymbol('!=') or
          CheckForSymbol('>=') or  CheckForSymbol('<=')  then
     liLength := 1

  else if CheckForKeyWords(['Is', 'Not', 'Null']) then
     liLength := 5

  else if CheckForKeyWords(['Not', 'Like']) or CheckForKeyWords(['Not', 'Between']) or
            CheckForKeyWords(['Not', 'In']) or CheckForKeyWords(['Is', 'Null']) then
     liLength := 3

  else if CheckForKeyWord('Like') or CheckForKeyWord('In') or
            CheckForKeyWord('Between') then
     liLength := 1
  else
    liLength := 0;

  Result := '';

  for liIndex := 0 to liLength-1 do
    begin
      Result := Result + CurrentToken.Value;
      Next;
    end;


end;

procedure TdaSQLTokenReader.SetIndex(aIndex: Integer);
begin
  if (FTokens.Count = 0) then Exit;
  
  FIndex := aIndex;

  FBOF := FIndex < FIndexStart;

  FEOF := FIndex > FIndexEnd;
  
end;

procedure TdaSQLTokenReader.SkipSpaces;
begin

//  if not(Eof) and (CurrentToken.TokenKind <> tkSpace) then
//    Next();

  while not(EOF) and ((CurrentToken.IsSpace) or  (CurrentToken.IsComment)) do
    Next();

end;

procedure TdaSQLTokenReader.SkipPriorSpaces;
begin
//  if not(Bof) and (CurrentToken.TokenKind <> tkSpace) then
//    Prior();

  while not(BOF) and ((CurrentToken.IsSpace) or  (CurrentToken.IsComment)) do
    Prior();

end;

constructor TdaSQLQueryItem.Create;
begin

  inherited Create;

  FDatabaseType := dtOther;

  FSelectClause := TdaSQLSelectClause.Create;
  FFromClause := TdaSQLFromClause.Create;
  FWhereClause := TdaSQLWhereClause.Create;
  FGroupByClause := TdaSQLGroupByClause.Create;
  FHavingClause := TdaSQLHavingClause.Create;
  FUnionclause := TdaSQLUnionclause.Create;
  FSQLParser := TdaSQLParser.Create;


end;

destructor TdaSQLQueryItem.Destroy;
begin

  FSelectClause.Free;
  FSelectClause := nil;

  FFromClause.Free;
  FFromClause := nil;

  FWhereClause.Free;
  FWhereClause := nil;

  FGroupByClause.Free;
  FGroupByClause := nil;

  FHavingClause.Free;
  FHavingClause := nil;

  FUnionclause.Free;
  FUnionclause := nil;
 
  FSQLParser.Free;
  FSQLParser := nil;

  inherited;

end;

function TdaSQLQueryItem.CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  Result := aReader.CurrentToken.IsKeyWord('Select');

end;

function TdaSQLQueryItem.CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  Result := aReader.EOF;

//  if not Result and FIsSubQuery then

end;

function TdaSQLQueryItem.CheckIsSubQuery(aReader: TdaSQLTokenReader): Boolean;
var
  liIndex: Integer;
begin

  // look for an open paren '('
  liIndex := aReader.Index;

  aReader.SkipPriorSpaces;

  Result := (aReader.CurrentToken.TokenKind = tkSymbol) and (aReader.CurrentToken.Value = '(');

  aReader.Index := liIndex;

end;

function TdaSQLQueryItem.GetSQLTokens: TdaSQLTokenCollection;
begin
  Result := FSQLParser.Tokens;
end;

function TdaSQLQueryItem.GetText: String;
begin

  Result := FUnionClause.Text +
            FSelectClause.Text +
            FFromClause.Text +
            FWhereClause.Text +
            FGroupByClause.Text +
            FHavingClause.Text;

end;

function TdaSQLQueryItem.Read(aReader: TdaSQLTokenReader): Boolean;
begin

  FIsValid := True;

  if aReader.CheckForKeyWord('Union') and not FUnionClause.Read(aReader) then
    begin
      FIsValid := False;
      FErrorClauseType := ctUnion;
      FErrorDescr := FUnionClause.ErrorDescr;
    end;

  if not FSelectClause.Read(aReader) then
    begin
      FIsValid := False;
      FErrorClauseType := ctSelect;
      FErrorDescr := FSelectClause.ErrorDescr;
    end;

  if FIsValid and not FFromClause.Read(aReader) then
    begin
      FIsValid := False;
      FErrorClauseType := ctFrom;
      FErrorDescr := FFromClause.ErrorDescr;
    end;

  if FIsValid and aReader.CheckForKeyWord('Where') and not FWhereClause.Read(aReader) then
    begin
      FIsValid := False;
      FErrorClauseType := ctWhere;
      FErrorDescr := FWhereClause.ErrorDescr;
    end;

  if FIsValid and aReader.CheckForKeyWord('Group') and not FGroupByClause.Read(aReader) then
    begin
      FIsValid := False;
      FErrorClauseType := ctGroupBy;
      FErrorDescr := FGroupByClause.ErrorDescr;
    end;

  if FIsValid and aReader.CheckForKeyWord('Having') and not FHavingClause.Read(aReader) then
    begin
      FIsValid := False;
      FErrorClauseType := ctHaving;
      FErrorDescr := FHavingClause.ErrorDescr;
    end;

  Result := FIsValid;

end;

function TdaSQLQueryItem.Read(aSQLText: TStrings): Boolean;
begin

  FSQLParser.Tokenize(aSQLText, FDatabaseType);

  Result := Read(FSQLParser.Tokens);

end;

function TdaSQLQueryItem.Read(aSQLTokens: TdaSQLTokenCollection): Boolean;
var
  lTokenReader: TdaSQLTokenReader;
begin

  lTokenReader := TdaSQLTokenReader.Create(aSQLTokens);

  try
    Result := Read(lTokenReader);

  finally
    lTokenReader.Free;

  end;

end;

procedure TdaSQLQueryItem.SetDatabaseType(const Value: TppDatabaseType);
begin

  FDatabaseType := Value;

  FSelectClause.DatabaseType :=  FDatabaseType;
  FFromClause.DatabaseType := FDatabaseType;
  FWhereClause.DatabaseType := FDatabaseType;
  FGroupByClause.DatabaseType := FDatabaseType;
  FHavingClause.DatabaseType := FDatabaseType;
  FUnionClause.DatabaseType := FDatabaseType;

end;

procedure TdaSQLToken.Assign(aToken: TdaSQLToken);
begin
  FAbsolutePos := aToken.AbsolutePos;
  FLineNo := aToken.LineNo;
  FPos := aToken.Pos;
  FTokenKind := aToken.TokenKind;
  FValue := aToken.Value;
end;

function TdaSQLToken.Clone: TdaSQLToken;
begin
  Result := TdaSQLToken.Create;
  Result.Assign(Self);
end;

function TdaSQLToken.GetDescription: String;
var
  lsTokenKind: String;
begin
  lsTokenKind := ppGetEnumName(TypeInfo(TtkTokenKind), Ord(TokenKind));

  Result := IntToStr(AbsolutePos) + ' ' + lsTokenKind + ': ' + Value;

end;

function TdaSQLToken.IsKeyWord(aKeyWord: String): Boolean;
begin

  Result := (FTokenKind = tkKey) and (CompareText(FValue, aKeyWord) = 0);

end;

function TdaSQLToken.IsOpenParen: Boolean;
begin
  Result := (FTokenKind = tkSymbol) and (FValue = '(');
end;

function TdaSQLToken.IsCloseParen: Boolean;
begin
  Result := (FTokenKind = tkSymbol) and (FValue = ')');
end;

function TdaSQLToken.IsEqualTo(aToken: TdaSQLToken): Boolean;
begin
  Result := (Value = aToken.Value) and
            (AbsolutePos = aToken.AbsolutePos) and
            (LineNo = aToken.LineNo) and
            (Pos = aToken.pos) and
            (Tokenkind = aToken.TokenKind);

end;

function TdaSQLToken.IsSymbol(aSymbol: String): Boolean;
begin

  Result := (FTokenKind = tkSymbol) and (CompareText(FValue, aSymbol) = 0);

end;

function TdaSQLToken.IsParameter: Boolean;
begin

  Result := (FTokenKind = tkVariable) and (Length(Value) > 0) and (Value[1] = ':');

end;

function TdaSQLToken.IsSpace: Boolean;
begin

  Result := (FTokenKind = tkSpace);

end;

function TdaSQLToken.IsComment: Boolean;
begin

  Result := (FTokenKind = tkComment);

end;

constructor TdaSQLExpressionBase.Create;
begin
  inherited;

  FDatabaseType := dtOther;

  FTokens := TdaSQLTokenCollection.Create;
  FTokens.InnerList.OwnsObjects := False;


end;

destructor TdaSQLExpressionBase.Destroy;
begin

  FTokens.Free;
  FTokens := nil;

  FSQLParser.Free;
  FSQLParser := nil;

  inherited;

end;

function TdaSQLExpressionBase.CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  Result := True;

end;

function TdaSQLExpressionBase.CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin
  Result := aReader.Eof;

  if not aReader.Eof and FStartsWithParen then
    begin
      if (FParenCount = 1) and aReader.CurrentToken.IsCloseParen then
        begin
          Result := True;
          FParenCount := 0;
          aReader.Next;
        end;
    end;

end;

function TdaSQLExpressionBase.GetText: String;
begin
  if FTokens.Count = 0 then
    Result := ''
  else
    Result := FTokens.Text;

end;

function TdaSQLExpressionBase.GetTokens: TdaSQLTokenCollection;
begin
   Result := FTokens;
end;

function TdaSQLExpressionBase.Read(aReader: TdaSQLTokenReader): Boolean;
begin

  ReadInitialize(aReader);

  ReadTokens(aReader);

  ReadFinalize(aReader);

  Result := FIsValid;

end;

function TdaSQLExpressionBase.Read(aSQLTokens: TdaSQLTokenCollection): Boolean;
var
  lTokenReader: TdaSQLTokenReader;
begin

  lTokenReader := TdaSQLTokenReader.Create(aSQLTokens);

  try
    Result := Read(lTokenReader);

  finally
    lTokenReader.Free;

  end;

end;

function TdaSQLExpressionBase.Read(aSQLText: TStrings): Boolean;
begin

  if (FSQLParser = nil) then
    FSQLParser := TdaSQLParser.Create;

  FSQLParser.Tokenize(aSQLText, FDatabaseType);

  Result := Read(FSQLParser.Tokens);

end;

function TdaSQLExpressionBase.Read(aSQLText: string): Boolean;
var
  lStrings: TStringList;
begin

  lStrings := TStringList.Create;

  try
    lStrings.Text := aSQLText;
    Result := Read(lStrings);

  finally
    lStrings.Free;

  end;

end;


procedure TdaSQLExpressionBase.ReadInitialize(aReader: TdaSQLTokenReader);
begin

  FTokens.Clear;
  FIsValid := True;
  FEndOfExpression := False;
  FStartIndex := aReader.Index;
  FEndIndex := -1;

  aReader.SkipSpaces;

  FStartsWithParen := not aReader.Eof and aReader.CurrentToken.IsOpenParen;

  if FStartsWithParen then
    begin
      ParenCount := 1;
      aReader.Next;
    end;

end;

procedure TdaSQLExpressionBase.ReadFinalize(aReader: TdaSQLTokenReader);
var
  liIndex: Integer;
begin

  FEndIndex := aReader.Index-1;

  // add tokens
  for liIndex := FStartIndex to FEndIndex do
    FTokens.Add(aReader.Tokens[liIndex]);

  if FIsValid then
  
    if (FParenCount < 0) then
      begin
        FIsValid := False;
        FErrorDescr := 'missing ''(''';
      end
    else if (FParenCount > 0) then
      begin
        FIsValid := False;
        FErrorDescr := 'missing '')''';
      end
    else if not FEndOfExpression then
      begin
        FIsValid := False;
        FErrorDescr := 'end of expression not found';
      end

end;

procedure TdaSQLExpressionBase.ReadTokens(aReader: TdaSQLTokenReader);
begin

  // check for start of expression
  while not aReader.EOF and not CheckBeginOfExpression(aReader) do
   aReader.Next;

  if not CheckBeginOfExpression(aReader) then
    begin
      FIsValid := False;
      FErrorDescr := 'beginning of expression not found';
    end
  else
    begin

      // read tokens
      while not aReader.EOF and not FEndOfExpression and FIsValid do
        begin

          // count parens
          if aReader.CurrentToken.IsOpenParen then
            Inc(FParenCount)
          else if aReader.CurrentToken.IsCloseParen then
            Dec(FParenCount);

          // process token
          ReadToken(aReader);

          aReader.Next;

          FEndOfExpression := CheckEndOfExpression(aReader);
        end;

    end;

end;

procedure TdaSQLExpressionBase.ReadToken(aReader: TdaSQLTokenReader);
begin


end;

constructor TdaSQLSelectClause.Create;
begin

  inherited;

  FSelectItems := TdaSQLSelectItemCollection.Create;

end;

destructor TdaSQLSelectClause.Destroy;
begin

  FSelectItems.Free;
  FSelectItems := nil;

  inherited;

end;

function TdaSQLSelectClause.CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin
  // check for Select
  Result := not aReader.Eof and aReader.CurrentToken.IsKeyWord('Select');

end;

function TdaSQLSelectClause.CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for From
  Result := (FParenCount = 0) and (aReader.Eof or aReader.CurrentToken.IsKeyWord('From'));

end;

procedure TdaSQLSelectClause.ReadInitialize(aReader: TdaSQLTokenReader);
begin

  FSelectItems.Clear;

  inherited;

end;

procedure TdaSQLSelectClause.ReadSelectItems(aReader: TdaSQLTokenReader);
var
  lSelectItem: TdaSQLSelectItem;
begin

  aReader.SkipSpaces;

  // ommit Select
  if not aReader.Eof and aReader.CurrentToken.IsKeyWord('Select') then
    aReader.Next;

  aReader.SkipSpaces;

  // check for Distinct
  if not aReader.Eof and aReader.CurrentToken.IsKeyWord('All') then
    begin
      FAll := True;
      aReader.Next;
    end;

  // check for Distinct
  if not aReader.Eof and aReader.CurrentToken.IsKeyWord('Distinct') then
    begin
      FDistinct := True;
      aReader.Next;
    end;

  aReader.SkipSpaces;

  // check for Wildcard
  if not aReader.Eof and aReader.CurrentToken.IsSymbol('*') then
    begin
      FWildcard := True;
      aReader.Next;
    end;

  aReader.SkipSpaces;

  aReader.IndexStart := aReader.Index;
  aReader.First;

  while not aReader.Eof do
    begin
      lSelectItem := TdaSQLSelectItem.Create;
      lSelectItem.Read(aReader);
      FSelectItems.Add(lSelectItem);
    end;

end;

procedure TdaSQLSelectClause.ReadToken(aReader: TdaSQLTokenReader);
begin

// add code to parse each select item -> [columnref | expression]

end;

procedure TdaSQLSelectClause.ReadTokens(aReader: TdaSQLTokenReader);
var
  lReader: TdaSQLTokenReader;
begin

  inherited ReadTokens(aReader);

  // process tokens into search items
  lReader := TdaSQLTokenReader.Create(Tokens);

  ReadSelectItems(lReader);

  lReader.Free;

end;

function TdaSQLFromClause.CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for Select
  Result := not aReader.Eof and aReader.CurrentToken.IsKeyWord('From');

end;

function TdaSQLFromClause.CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for From
  Result := (FParenCount = 0) and (aReader.Eof or
                                   aReader.CurrentToken.IsKeyWord('Where') or
                                   aReader.CurrentToken.IsKeyWord('Group') or
                                   aReader.CurrentToken.IsKeyWord('Having') or
                                   aReader.CurrentToken.IsKeyWord('Union') or
                                   aReader.CurrentToken.IsKeyWord('Order') );

end;

procedure TdaSQLFromClause.ReadInitialize(aReader: TdaSQLTokenReader);
begin

  inherited;

end;

procedure TdaSQLFromClause.ReadToken(aReader: TdaSQLTokenReader);
begin


end;

constructor TdaSQLWhereClause.Create;
begin

  inherited;

  FSearchItems := TdaSQLSearchItemCollection.Create;

end;

destructor TdaSQLWhereClause.Destroy;
begin

  FSearchItems.Free;
  FSearchItems := nil;

  inherited;

end;

procedure TdaSQLWhereClause.Add(aSearchExpressionText: string);
var
  lSQLSearchItem: TdaSQLSearchItem;
  lSQLToken: TdaSQLToken;
begin

  aSearchExpressionText := '(' + aSearchExpressionText + ')';

  if SearchItems.Count > 0 then
    begin
      // add a space token to the last search condition
      lSQLToken := TdaSQLToken.Create;
      lSQLToken.TokenKind := tkSpace;
      lSQLToken.Value := ' ';
      SearchItems[SearchItems.Count-1].Tokens.Add(lSQLToken);

      // add an 'and '
      aSearchExpressionText := 'and ' + aSearchExpressionText + #13#10;
    end
  else
    begin
      // add a 'Where '
      aSearchExpressionText := ' Where ' + aSearchExpressionText + #13#10;
    end;

  lSQLSearchItem := TdaSQLSearchItem.Create;
  lSQLSearchItem.DatabaseType := DatabaseType;
  lSQLSearchItem.Read(aSearchExpressionText);

  Self.Tokens.Add(lSQLSearchItem.Tokens);

  SearchItems.Add(lSQLSearchItem);


end;

function TdaSQLWhereClause.CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for Where
  Result := not aReader.Eof and aReader.CurrentToken.IsKeyWord('Where');

end;

function TdaSQLWhereClause.CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  if inherited CheckEndOfExpression(aReader) then
    Result := True
  else
    Result := CheckEndOfWhere(aReader);


end;

function TdaSQLWhereClause.CheckEndOfWhere(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for end of Where
  Result := (FParenCount = 0) and (aReader.Eof or
                                   aReader.CurrentToken.IsKeyWord('Group') or
                                   aReader.CurrentToken.IsKeyWord('Having') or
                                   aReader.CurrentToken.IsKeyWord('Union') or
                                   aReader.CurrentToken.IsKeyWord('Order') );
end;

procedure TdaSQLWhereClause.ReadSearchItems(aReader: TdaSQLTokenReader);
var
  lSearchItem: TdaSQLSearchItem;
  liParenCount: Integer;
  lbDone: Boolean;
  lbOpenParen: Boolean;
  liLastParen: Integer;
begin

  aReader.SkipSpaces;

  // ommit Where
  if not aReader.Eof and aReader.CurrentToken.IsKeyWord('Where') then
    aReader.Next;

   aReader.IndexStart := aReader.Index;

   FParenPairs := 0;

  repeat

    // ommit beginning spaces
    aReader.First;
    aReader.SkipSpaces;
    aReader.IndexStart := aReader.Index;

    // ommit trailing spaces
    aReader.Last;
    aReader.SkipPriorSpaces;
    aReader.IndexEnd := aReader.Index;

    // ommit surrounding parens
    aReader.First;
    lbDone := True;

    lbOpenParen := not aReader.Eof and aReader.CurrentToken.IsOpenParen;

    // if open paren, then count parens
    //     - if last character is the matching close paren, then shrink the index
    if lbOpenParen then
      begin

        liParenCount := 1;
        aReader.Next;
        liLastParen := -1;

        // count matching parens
        while not aReader.Eof and (liParenCount > 0) do
          begin

            if aReader.CurrentToken.IsOpenParen then
              Inc(liParenCount)
            else if aReader.CurrentToken.IsCloseParen then
              Dec(liParenCount);

            if (liParenCount = 0) then
              liLastParen := aReader.Index;

            aReader.Next;

          end;

        // if last paren matches the first, then ommit it
        if liLastParen = aReader.IndexEnd then
          begin
            Inc(FParenPairs);
            aReader.IndexStart := aReader.IndexStart + 1;
            aReader.IndexEnd := aReader.IndexEnd - 1;
            lbDone := False;
          end;

      end;

  until lbDone;


  aReader.First;
  while not aReader.Eof do
    begin
      lSearchItem := TdaSQLSearchItem.Create;
      lSearchItem.DatabaseType := FDatabaseType;
      lSearchItem.Read(aReader);
      FSearchItems.Add(lSearchItem);
    end;

end;

procedure TdaSQLWhereClause.ReadInitialize(aReader: TdaSQLTokenReader);
begin

  FSearchItems.Clear;

  inherited;

end;

procedure TdaSQLWhereClause.ReadToken(aReader: TdaSQLTokenReader);
begin


end;

procedure TdaSQLWhereClause.ReadTokens(aReader: TdaSQLTokenReader);
var
  lReader: TdaSQLTokenReader;
begin

  inherited ReadTokens(aReader);

  // process tokens into search items
  lReader := TdaSQLTokenReader.Create(Tokens);

  ReadSearchItems(lReader);

  lReader.Free;

end;

function TdaSQLGroupByClause.CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for Group By
  Result := not aReader.Eof and aReader.CurrentToken.IsKeyWord('Group') and aReader.CheckForKeyWordPair('Group', 'By');

end;

function TdaSQLGroupByClause.CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for end of Group
  Result := (FParenCount = 0) and (aReader.Eof or
                                   aReader.CurrentToken.IsKeyWord('Having') or
                                   aReader.CurrentToken.IsKeyWord('Union') or
                                   aReader.CurrentToken.IsKeyWord('Order') );

end;

procedure TdaSQLGroupByClause.ReadInitialize(aReader: TdaSQLTokenReader);
begin

  inherited;

end;

procedure TdaSQLGroupByClause.ReadToken(aReader: TdaSQLTokenReader);
begin

 // add code here to parse each column ref

end;

function TdaSQLHavingClause.CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for Having
  Result := not aReader.Eof and aReader.CurrentToken.IsKeyWord('Having');

end;

function TdaSQLHavingClause.CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  if inherited CheckEndOfExpression(aReader) then
    Result := True
  else
    Result := CheckEndOfHaving(aReader);

end;

function TdaSQLHavingClause.CheckEndOfHaving(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for end of Having
  Result := (FParenCount = 0) and (aReader.Eof or
                                   aReader.CurrentToken.IsKeyWord('Union') or
                                   aReader.CurrentToken.IsKeyWord('Order') );
end;

function TdaSQLOrderByClause.CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for Order
  Result := not aReader.Eof and aReader.CurrentToken.IsKeyWord('Order') and aReader.CheckForKeyWordPair('Order', 'By');

end;

function TdaSQLOrderByClause.CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for end of Order By
  Result := (FParenCount = 0) and (aReader.Eof);

end;

procedure TdaSQLOrderByClause.ReadInitialize(aReader: TdaSQLTokenReader);
begin

  inherited;

end;

procedure TdaSQLOrderByClause.ReadToken(aReader: TdaSQLTokenReader);
begin
 // add code to parse into order items

end;

constructor TdaSQLSearchItemCollection.Create;
begin
  inherited;

  InnerList.OwnsObjects := True;
end;

procedure TdaSQLSearchItemCollection.Add(aItem: TdaSQLSearchItem);
begin
  InnerList.Add(aItem);
end;

function TdaSQLSearchItemCollection.GetDescription: string;
var
  liIndex: Integer;
begin

  Result := '';

  for liIndex := 0 to Count - 1 do
    begin
      if liIndex > 0 then
        Result := Result + #13#10;

       Result := Result + Items[liIndex].Tokens.Description;
    end;

end;

function TdaSQLSearchItemCollection.GetItems(Index: Integer): TdaSQLSearchItem;
begin
  Result := TdaSQLSearchItem(InnerList[Index]);
end;

function TdaSQLSearchItem.CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  if CheckEndOfWhere(aReader) then
    Result := True
  else
    Result := CheckEndOfSearchItem(aReader);

end;

function TdaSQLSearchItem.CheckEndOfSearchItem(aReader: TdaSQLTokenReader): Boolean;
begin
  //(ParenCount = 0) and
  if not aReader.EOF and  (aReader.CurrentToken.IsKeyWord('And') or aReader.CurrentToken.IsKeyWord('Or')) then
    begin
      Result := True;
      Suffix := aReader.CurrentToken.Value;
      Tokens.Add(aReader.CurrentToken);
      aReader.Next;
    end
  else
    Result := False;

end;

function TdaSQLSearchItem.CheckEndOfWhere(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for end of Where
  Result := (FParenCount = 0) and (aReader.Eof or
                                   aReader.CurrentToken.IsKeyWord('Group') or
                                   aReader.CurrentToken.IsKeyWord('Having') or
                                   aReader.CurrentToken.IsKeyWord('Union') or
                                   aReader.CurrentToken.IsKeyWord('Order') );
end;

function TdaSQLSearchItem.GenerateText: String;
begin

  Result := ' ( ' + Expression1 + ' ) ' + Operator + ' (' + Expression2 + ') ';
  Result := ' ( ' + Prefix + Result + ' ) ' + Suffix + ' ';

end;

procedure TdaSQLSearchItem.ReadInitialize(aReader: TdaSQLTokenReader);
begin
  inherited;

  FItemReadState := rsPrefix;

end;

{
   [(] [Not] [(] Expression1 [)] Operator  [(] Expression2 [)]  [)]
}

procedure TdaSQLSearchItem.ReadToken(aReader: TdaSQLTokenReader);
begin

  inherited;

  // prefix can consist of OpenParen, Not, or Space
  if (FItemReadState = rsPrefix) then
    begin
      if aReader.CurrentToken.IsOpenParen then
//       nothing
      else if aReader.CurrentToken.IsKeyWord('Not') then
        FPrefix := aReader.CurrentToken.Value
      else if aReader.CurrentToken.IsSpace then
        // nothing
      else
        begin
          FItemReadState := rsExpression1;
          FExprStartingParenCount  := ParenCount;
        end;
    end;

  // Expression1 - everything up until the operator or closing paren
  if (FItemReadState = rsExpression1) then
    begin

      if aReader.CheckForOperator() then
        FItemReadState := rsOperator
      else if aReader.CurrentToken.IsSpace and (FExpression1 = '')  then
        // nothing, skip leading spaces
      else if (FExprStartingParenCount > ParenCount) then
        // nothing, skip closing parens
//        FItemReadState := rsOperator
      else
        FExpression1 := FExpression1 + aReader.CurrentToken.Value;

    end;

  // Operator
  if (FItemReadState = rsOperator) then
    begin
      if aReader.CheckForOperator() then
        FOperator :=  aReader.ReadOperator
      else if aReader.CurrentToken.IsSpace then
        // nothing
      else
        begin
          FItemReadState := rsExpression2;

          FExprStartingParenCount := ParenCount;
        end;

    end;

  // Expression2 - everything up until the logical suffix or closing paren
  if (FItemReadState = rsExpression2) then
    begin
      if (aReader.CurrentToken.IsKeyWord('And') or aReader.CurrentToken.IsKeyWord('Or')) then
        FItemReadState := rsSuffix
      else if aReader.CurrentToken.IsSpace and (FExpression2 = '')  then
        // nothing, skip leading spaces
      else if aReader.CurrentToken.IsOpenParen and (FExpression2 = '') then
          FExprStartingParenCount := ParenCount
      else if FExprStartingParenCount > ParenCount then
        // nothing, skip closing parens
        FItemReadState := rsSuffix
      else if aReader.CurrentToken.IsParameter then
        begin
          // strip off the ':'
          FParamName := StringReplace(aReader.CurrentToken.Value, ':', '', []);
          FContainsParameter := Length(FParamName) > 0;
        end
      else if aReader.CurrentToken.IsSymbol('?') then
        FAutoSearch := True
      else
        FExpression2 := FExpression2 + aReader.CurrentToken.Value;
    end;

  if (FItemReadState = rsSuffix) then
    begin
      if aReader.CurrentToken.IsCloseParen then
//        nothing
      else if (aReader.CurrentToken.IsKeyWord('And') or aReader.CurrentToken.IsKeyWord('Or')) then
        FSuffix := aReader.CurrentToken.Value
      else if aReader.CurrentToken.IsSpace then
        // nothing
    end;


end;

constructor TdaSQLSelectItemCollection.Create;
begin
  inherited;

  InnerList.OwnsObjects := True;
end;

procedure TdaSQLSelectItemCollection.Add(aItem: TdaSQLSelectItem);
begin
  InnerList.Add(aItem);
end;

function TdaSQLSelectItemCollection.GetDescription: string;
var
  liIndex: Integer;
begin

  Result := '';

  for liIndex := 0 to Count - 1 do
    begin
      if liIndex > 0 then
        Result := Result + ',' + #13#10;

       Result := Result + Items[liIndex].Tokens.Description;
    end;

end;

function TdaSQLSelectItemCollection.GetItems(Index: Integer): TdaSQLSelectItem;
begin
  Result := TdaSQLSelectItem(InnerList[Index]);
end;

function TdaSQLSelectItem.CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin
  if not aReader.Eof and (ParenCount = 0) and aReader.CurrentToken.IsKeyWord('From') then
    Result := True
  else
    Result := CheckEndOfSelectItem(aReader);

end;

function TdaSQLSelectItem.CheckEndOfSelectItem(aReader: TdaSQLTokenReader): Boolean;
begin

  if aReader.EOF and (ParenCount = 0) then
    Result := True

  else if not aReader.EOF and (ParenCount = 0) and (aReader.CurrentToken.IsSymbol(',')) then
    begin
      aReader.Next;
      Result := True
    end
  else
    Result := False;

end;

procedure TdaSQLSelectItem.ReadInitialize(aReader: TdaSQLTokenReader);
begin
  inherited;

  FItemReadState := rsExpression;

end;

{
   Expression [AS] [Alias] 
}

procedure TdaSQLSelectItem.ReadToken(aReader: TdaSQLTokenReader);
begin

  inherited;

{  if (FItemReadState = rsColumnRef) then
    begin
       if aReader.CurrentToken.IsSpace and (FColumnRef = '') then
        // nothing, skip leading spaces
       else if aReader.CurrentToken.TokenKind = tkIdentifier then
         FColumnRef := aReader.CurrentToken.Value


    end;
}

  if (FItemReadState = rsExpression) then
    begin
      if aReader.CurrentToken.IsKeyWord('As') then
        FItemReadState := rsAliasPrefix
      else if aReader.CurrentToken.IsSpace and (FExpression = '') then
        // nothing, skip leading spaces
      else if aReader.CurrentToken.IsSpace and (ParenCount = 0) then
        FItemReadState := rsAliasPrefix
      else
        FExpression := FExpression + aReader.CurrentToken.Value;

    end;

  if (FItemReadState = rsAliasPrefix) then
    begin
      if aReader.CurrentToken.IsKeyWord('As') then
        FAliasPrefix :=  aReader.CurrentToken.Value
      else if aReader.CurrentToken.IsSpace and (FAliasPrefix = '') then
        // nothing, skip leading spaces
      else
        FItemReadState := rsAlias;
    end;

  if (FItemReadState = rsAlias) then
    begin
      if aReader.CurrentToken.IsSpace and (FAlias = '') then
        // nothing, skip leading spaces
      else
        FAlias := aReader.CurrentToken.Value;
    end;

end;

constructor TdaSQLQueryItemCollection.Create;
begin
  inherited;

  InnerList.OwnsObjects := True;
end;

procedure TdaSQLQueryItemCollection.Add(aItem: TdaSQLQueryItem);
begin
  InnerList.Add(aItem);
end;

function TdaSQLQueryItemCollection.GetText: string;
var
  liIndex: Integer;
begin

  Result := '';

  for liIndex := 0 to Count - 1 do
    Result := Result + Items[liIndex].Text;

end;

function TdaSQLQueryItemCollection.GetItems(Index: Integer): TdaSQLQueryItem;
begin
  Result := TdaSQLQueryItem(InnerList[Index]);
end;

constructor TdaSQLQueryExpression.Create;
begin

  inherited;

  FOrderByClause := TdaSQLOrderByClause.Create;

  FUnions := TdaSQLQueryItemCollection.Create;

  FParameters := TppParameterList.Create(nil);


end;

destructor TdaSQLQueryExpression.Destroy;
begin

  FOrderByClause.Free;
  FOrderByClause := nil;

  FUnions.Free;
  FUnions := nil;

  FParameters.Free;
  FParameters := nil;

  inherited;

end;

function TdaSQLQueryExpression.GetCommandText: string;
var
  liIndex: Integer;
  lToken: TdaSQLToken;
  lsValue: String;
  lsParamName: String;
begin

  Result := '';

  for liIndex := 0 to SQLTokens.Count - 1 do
    begin
      lToken := SQLTokens[liIndex];

      if lToken.IsParameter then
        begin
          lsParamName := StringReplace(lToken.Value, ':', '', []);
          lsValue := FParameters.Values[lsParamName];
        end
      else
        lsValue := lToken.Value;

      Result := Result + lsValue;

    end;

end;

function TdaSQLQueryExpression.GetText: String;
begin

  Result := FSelectClause.Text +
            FFromClause.Text +
            FWhereClause.Text +
            FGroupByClause.Text +
            FHavingClause.Text +
            FUnions.Text +
            FOrderByClause.Text;

end;

function TdaSQLQueryExpression.Read(aReader: TdaSQLTokenReader): Boolean;
var
  lQueryItem: TdaSQLQueryItem;
begin

  FUnions.Clear;


  // read main query item
  IsValid := inherited Read(aReader);

  // read Unions query items
  while FIsValid and (aReader.CheckForKeyWord('Unions')) and not(aReader.EOF) do
    begin

      lQueryItem := TdaSQLQueryItem.Create;
      lQueryItem.DatabaseType := FDatabaseType;
      FUnions.Add(lQueryItem);

      if not lQueryItem.Read(aReader) then
        begin
          FIsValid := False;
          ErrorClauseType := lQueryItem.ErrorClauseType;
          ErrorDescr := lQueryItem.ErrorDescr;
        end;

    end;

  // read order by
  if FIsValid and aReader.CheckForKeyWord('Order') and not FOrderByClause.Read(aReader) then
    begin
      FIsValid := False;
      FErrorClauseType := ctOrderBy;
      FErrorDescr := FOrderByClause.ErrorDescr;
    end;

{  if FIsValid and not(aReader.Eof) then
    begin
      FIsValid := False;
      FErrorClauseType := ctOther;
      FErrorDescr := 'End of expression encountered, addition text ignored.';
    end;
}

  // read parameters
  ReadParameters(aReader);


  Result := FIsValid;

end;

procedure TdaSQLQueryExpression.ReadParameters(aReader: TdaSQLTokenReader);
var
  lParameter: TppParameter;
begin

  aReader.First;

  while not aReader.Eof do
    begin
    
      if aReader.CurrentToken.IsParameter then
        begin
          lParameter := TppParameter.Create(nil);
          lParameter.Name := StringReplace(aReader.CurrentToken.Value, ':', '', []);
          lParameter.UserName := lParameter.Name;
          lParameter.Parent := FParameters;
        end;

      aReader.Next;

    end;

end;

procedure TdaSQLQueryExpression.SetDatabaseType(const Value: TppDatabaseType);
var
  liIndex: Integer;
begin

  inherited;

  for liIndex := 0 to FUnions.Count - 1 do
    FUnions[liIndex].DatabaseType := Value;

end;



{$IFDEF notused}

constructor TdaSQLParams.Create;
begin
  inherited;

end;

destructor TdaSQLParams.Destroy;
begin

  inherited;

end;

procedure TdaSQLParams.Read(aSQLTokens: TdaSQLTokenCollection);
var
  lTokenReader: TdaSQLTokenReader;
begin

  lTokenReader := TdaSQLTokenReader.Create(aSQLTokens);

  try
    Read(lTokenReader);

  finally
    lTokenReader.Free;

  end;

end;

procedure TdaSQLParams.Read(aReader: TdaSQLTokenReader);
begin

  InnerList.Clear;
  InnerList.OwnsObjects := True;

  aReader.First;

  while not aReader.Eof do
    begin

      if aReader.CurrentToken.IsVariable then
        ReadParam(aReader);

      aReader.Next;

    end;

end;

procedure TdaSQLParams.Read(aQueryExpression: TdaSQLQueryExpression);
//var
//  liIndex: Integer;
begin


{  if (aQueryExpression.IsValid) then
    begin

      InnerList.Clear;
      InnerList.OwnsObjects := False;

      ExtractFromQueryItem(aQueryExpression);

      for liIndex := 0 to aQueryExpression.Union.Count - 1 do
        ExtractFromQueryItem(aQueryExpression.Union[liIndex]);

    end
  else}
    Read(aQueryExpression.SQLTokens);

end;

procedure TdaSQLParams.ExtractFromQueryItem(aQueryItem: TdaSQLQueryItem);
begin

  ExtractFromSearchItems(aQueryItem.WhereClause.SearchItems);

  ExtractFromSearchItems(aQueryItem.HavingClause.SearchItems);

end;

procedure TdaSQLParams.ExtractFromSearchItems(aSearchItems: TdaSQLSearchItemCollection);
var
  liIndex: Integer;
  lSearchItem: TdaSQLSearchItem;
begin
  for liIndex := 0 to aSearchItems.Count - 1 do
    begin
      lSearchItem := aSearchItems[liIndex];

      if lSearchItem.ContainsParameter {or lSearchItem.AutoSearch} then
        InnerList.Add(lSearchItem);
      
    end;
end;

procedure TdaSQLParams.ReadParam(aReader: TdaSQLTokenReader);
var
  lParam: TdaSQLSearchItem;
  liSavePos: Integer;
begin

  // save position
  liSavePos := aReader.Index;

  lParam := TdaSQLSearchItem.Create;

  // read ParamName - strip ':' from the :ParamName
  lParam.ParamName := StringReplace(aReader.CurrentToken.Value, ':', '', []);

  // use ParamName as the Expression for now
  lParam.Expression1 := lParam.ParamName;

  // read AutoSearch - a '?' before or after the :ParamName denotes AutoSearch
  lParam.AutoSearch := aReader.NextToken.IsSymbol('?') or
                           aReader.PriorToken.IsSymbol('?');

  if aReader.PriorToken.IsSymbol('?') then
    aReader.Prior;

  // read the operator
  aReader.SkipPriorSpaces;

  if aReader.CheckForOperator then
    begin
      lParam.Operator := aReader.ReadOperator;

      aReader.SkipPriorSpaces;

  //              if aReader. then

    end;

   // restore position
  aReader.Index := liSavePos;
  
  //           aReader.Next;

  //           if aReader.NextToken.IsSymbol('?') then
  //             aReader.Next;

  InnerList.Add(lParam);
   
end;
{$ENDIF}

function TdaSQLUnionClause.CheckBeginOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for Union
  Result := not aReader.Eof and aReader.CurrentToken.IsKeyWord('Union');

end;

function TdaSQLUnionClause.CheckEndOfExpression(aReader: TdaSQLTokenReader): Boolean;
begin

  // check for Select
  Result := (FParenCount = 0) and (aReader.Eof or
                                   aReader.CurrentToken.IsKeyWord('Select') or
                                   aReader.CurrentToken.IsKeyWord('Order'));

end;

procedure TdaSQLUnionClause.ReadInitialize(aReader: TdaSQLTokenReader);
begin

  inherited;

end;

procedure TdaSQLUnionClause.ReadToken(aReader: TdaSQLTokenReader);
begin


end;


end.
