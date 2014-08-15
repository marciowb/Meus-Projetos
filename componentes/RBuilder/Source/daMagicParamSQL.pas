{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit daMagicParamSQL;



interface

uses
  SysUtils,
  Classes,

  ppTypes,

  daSQL,
  daSQLBuilder,
  daSQLParser;

type

  {TdaMagicParamSQL

    Generates SQL that is submitted to the database by the QueryDataView. Adds
    parameterized links that enable the SQL to be bound to a master query.}
    
  TdaMagicParamSQL = class (TdaSQL)
  private
    FLinkingSQLText: TStrings;
    FRootSQL: TdaSQL;

    procedure GenerateParameterizedSQLObject;
    procedure GenerateParameterizedSQLText;
    procedure AddLinkedParametersToQueryExpression(aQueryExpression: TdaSQLQueryExpression);
    function IndexOfSelectItem(aFieldAlias: string): Integer;
    procedure Init;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    function GenerateLinkingSQL: Boolean; virtual;


    property LinkingSQLText: TStrings read FLinkingSQLText;

  end;


implementation

{*******************************************************************************
 *
 ** M A G I C   P A R A M E T E R I Z E D   S Q L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaMagicParamSQL.Create }

constructor TdaMagicParamSQL.Create(aOwner: TComponent);
begin

  if (aOwner <> nil) and not (aOwner is TdaSQL) then
    raise EDataError.Create('TdaMagicParamSQL.Create: Owner must be TdaSQL');

  inherited Create(aOwner);

  FRootSQL := TdaSQL(aOwner);

  FLinkingSQLText := TStringList.Create;


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaMagicParamSQL.Destroy }

destructor TdaMagicParamSQL.Destroy;
begin

  FLinkingSQLText.Free;
  FLinkingSQLText := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaMagicParamSQL.GenerateLinkingSQL }

function TdaMagicParamSQL.GenerateLinkingSQL: Boolean;
begin

  if (FRootSQL = nil) then
    Result := False
  else
    begin
      Init;

      if FRootSQL.EditSQLAsText then
        GenerateParameterizedSQLText
      else
        GenerateParameterizedSQLObject;

      Result := True;
    end;

end; {function, GenerateLinkingSQL}

{------------------------------------------------------------------------------}
{ TdaMagicParamSQL.GenerateParameterizedSQLObject }

procedure TdaMagicParamSQL.GenerateParameterizedSQLObject;
var
  lSQLBuilder: TdaSQLBuilder;
  lSQLLink: TdaSQLLink;
  liIndex: Integer;
begin


    // use SQLBuilder to add parameterized search criteria
    lSQLBuilder := TdaSQLBuilder.Create(Self);

    try

    // iterate over sql links
    for liIndex := 0 to FRootSQL.LinkCount - 1 do
      begin
        lSQLLink := FRootSQL.Links[liIndex];

        // search condition is (detailTable.fieldAias = :masterFieldAlias)
        lSQLBuilder.SearchCriteria.Add(lSQLLink.DetailField.TableAlias, lSQLLink.DetailField.SQLFieldName, '=', ':' + lSQLLink.MasterField.SQLFieldName);
      end;

    FLinkingSQLText.Assign(lSQLBuilder.SQL.SQLText);

  finally
    lSQLBuilder.Free;

  end;


end;

{------------------------------------------------------------------------------}
{ TdaMagicParamSQL.GenerateParameterizedSQLText }

procedure TdaMagicParamSQL.GenerateParameterizedSQLText;
var
  lQueryExpression: TdaSQLQueryExpression;
begin

  // parse SQL text into query expression
  lQueryExpression := TdaSQLQueryExpression.Create;

  try
    lQueryExpression.DatabaseType := FRootSQL.DatabaseType;
    lQueryExpression.Read(FRootSQL.GetSQLCommandText);

    if lQueryExpression.IsValid then
      AddLinkedParametersToQueryExpression(lQueryExpression);

    FLinkingSQLText.Text := lQueryExpression.Text;

  finally
    lQueryExpression.Free;

  end;


end;

{------------------------------------------------------------------------------}
{ TdaMagicParamSQL.GenerateParameterizedSQLText }

procedure TdaMagicParamSQL.AddLinkedParametersToQueryExpression(aQueryExpression: TdaSQLQueryExpression);
var
  liIndex: Integer;
  lSQLLink: TdaSQLLink;
  lsSearchCondition: String;
  liSelectItem: Integer;
  lsSelectItem: String;
  liSQLItem: Integer;
begin

  // iterate over sql links
  for liIndex := 0 to FRootSQL.LinkCount - 1 do
    begin
      lSQLLink := FRootSQL.Links[liIndex];

      // find the position of the detail field in the SelectFields[ ] array
      liSelectItem := IndexOfSelectItem(lSQLLink.DetailField.FieldAlias);

      // use liSelectItem to get query expression SelectItems[ ]
      if (liSelectItem >= 0) and (liSelectItem < aQueryExpression.SelectClause.SelectItems.Count) then
        lsSelectItem := aQueryExpression.SelectClause.SelectItems[liSelectItem].Expression
      else
        lsSelectItem := lSQLLink.DetailField.SQLFieldName;

      // add parameter to where clause
      lsSearchCondition := lsSelectItem + ' = :' + lSQLLink.MasterField.SQLFieldName;

      aQueryExpression.WhereClause.Add(lsSearchCondition);

      for liSQLItem := 0 to aQueryExpression.Unions.Count - 1 do
        aQueryExpression.Unions[liSQLItem].WhereClause.Add(lsSearchCondition);

    end;

end;

{------------------------------------------------------------------------------}
{ TdaMagicParamSQL.IndexOfSelectItem }

function TdaMagicParamSQL.IndexOfSelectItem(aFieldAlias: string): Integer;
var
  lField: TdaField;
begin

  lField := GetFieldForAlias(aFieldAlias);

  if (lField = nil) then
    lField := GetFieldForSQLFieldName(aFieldAlias);

  if (lField <> nil) then
    Result := lField.Index
  else
    Result := -1;

end;

{------------------------------------------------------------------------------}
{ TdaMagicParamSQL.Init }

procedure TdaMagicParamSQL.Init;
begin
  // clone the SQL object and remove the links
  Self.Assign(FRootSQL);
  Self.ClearSQLLinks;
  Self.MasterSQL := nil;
  Self.Modified := False;
end;

end.
