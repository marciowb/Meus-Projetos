{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit daMagicSQL;

interface

{$I ppIfDef.pas}

uses
  Classes,
  SysUtils,

  ppTypes,
  ppUtils,
  ppParameter,

  daSQL,
  daLinkBroker;

type

  {forward declarations }
  TdaMagicSQL = class;

  {TdaMagicLink }
  TdaMagicLink = class
    private
      FAscending: Boolean;
      FIsOrderByFromMaster: Boolean;
      FMasterField: TdaField;
      FDetailField: TdaField;

    public
      constructor Create(aMasterField, aDetailField: TdaField; aAscending: Boolean; aIsOrderByFromMaster: Boolean); virtual;
      destructor Destroy; override;

      property Ascending: Boolean read FAscending;
      property DetailField: TdaField read FDetailField;
      property IsOrderByFromMaster: Boolean read FIsOrderByFromMaster;
      property MasterField: TdaField read FMasterField;

  end; {class, TdaMagicLink}

  {TdaMagicLinks }
  TdaMagicLinks = class
    private
      FItems: TList;
      FMagicSQL: TdaMagicSQL;

      function GetCount: Integer;
      function GetItem(aIndex: Integer): TdaMagicLink;

    public
      constructor Create(aMagicSQL: TdaMagicSQL); virtual;
      destructor Destroy; override;

      procedure Add(aMasterField, aDetailField: TdaField; aAscending: Boolean; aIsOrderByFromMaster: Boolean);
      procedure Clear;
      function GetMasterOrderByFields(aFields: TList): Boolean;
      procedure ValidateMasterSQLFieldNames;

      property Count: Integer read GetCount;
      property Items[Index: Integer]: TdaMagicLink read GetItem; default;

  end; {class, TdaMagicLinks}


  {@TdaMagicSQL

   Generates the SQL which is submitted to the database by the QueryDataView
   class. Linked dataviews require special SQL which takes into account the full
   chain of master dataviews. MagicSQL uses recursion to generate a set of child
   objects based on the master dataviews which appear in the chain. These
   objects (Tables, Fields, TableJoins, etc.) are then used to generate the
   SQL.}

  TdaMagicSQL = class (TdaSQL)
    private
      FMagicFieldCount: Integer;
      FMagicFields: TList;
      FMagicLinks: TdaMagicLinks;
      FMagicSQLText: TStrings;
      FRootSQL: TdaSQL;

      procedure AddMagicGroupByField(aField: TdaField; aSQLObject: TdaSQL);
      function AddMagicSelectField(aTable: TdaTable; aField: TdaField): TdaField;
      procedure AddMagicTableJoin(aMasterTable, aDetailTable: TdaTable; aMasterField, aDetailField: TdaField; aType: TdaJoinOperatorType); overload;
      procedure AddMagicTableJoin(aDetailTable: TdaTable; aDetailField: TdaField; aType: TdaJoinOperatorType; aExpression: String); overload;
      procedure AddMasterFieldsAsGroupByFields(aDetailSQL: TdaSQL);
      procedure AddMasterFieldsAsOrderByFields(aDetailSQL: TdaSQL; aLowestDetail: Boolean);
      procedure AddMasterFieldsAsSelectFields(aDetailSQL: TdaSQL);
      procedure AddDetailLinkFieldsAsMagicOrderBy(aSQL: TdaSQL);
      procedure AddMasterLinkFieldsAsMagicSelect(aSQL: TdaSQL; aChildsLinks: TList);
      procedure AssignCalcFieldsFrom(aSourceSQL: TdaSQL);
      procedure AssignCriteriaFieldsFrom(aSourceSQL: TdaSQL);
      procedure AssignGroupCriteriaFieldsFrom(aSourceSQL: TdaSQL);
//      procedure AssignGroupByFieldsFrom(aSourceSQL: TdaSQL);
      procedure AssignOrderByFieldsFrom(aSourceSQL: TdaSQL);
      procedure AssignSelectFieldsFrom(aSourceSQL: TdaSQL);
      function CloneFieldForTableJoin(aField: TdaField; aTable: TdaTable; aTableJoin: TdaTableJoin): TdaField;
      function FieldExistsInGroupBys(aField: TdaField): Boolean;
      function FieldExistsInOrderBys(aField: TdaField): Boolean;
      function FieldExistsInSelectFields(aField: TdaField): Boolean;
      function FieldNameInLinks(const aFieldName: String; aSQL: TdaSQL; aAsMaster: Boolean): Boolean;
      procedure FixupCalcExpressionTableReferences(aCalcField: TdaCalculation; aSQL: TdaSQL); overload;
      procedure FixupCalcExpressionTableReferences(aCalcField: TdaCalculation; aOldTableAlias, aNewTableAlias: String); overload;
      function GetSelectFieldForFieldName(const aTableSQLAlias, aFieldName: String): TdaField;
      function GetCalcFieldForFieldName(const aTableSQLAlias, aFieldName: String): TdaField;
      procedure GetGroupByFields(aSQL: TdaSQL; aChildsLinks: TList);
      procedure GetLinks(aSQL: TdaSQL);
      function GetLinksListForSQL(aSQL: TdaSQL): TList;
      function GetMagicLinks: TdaMagicLinks;
      function GetMagicLinkCount: Integer;
      procedure GetAllFields(aSQL: TdaSQL);
      procedure GetOrderByFields(aSQL: TdaSQL);
      procedure GetSearchCriteria(aSQL: TdaSQL; aChildsLinks: TList);
      procedure GetGroupSearchCriteria(aSQL: TdaSQL; aChildsLinks: TList);
      procedure GetSearchCriteriaFromMaster(aSQL: TdaSQL);
      procedure GetSelectFields(aSQL: TdaSQL; aChildsLinks: TList);
      procedure GetSelectFieldsFromDetail(aSQL: TdaSQL; aChildsLinks: TList);
      procedure GetSelectFieldsFromMaster(aSQL: TdaSQL; aChildsLinks: TList);
      procedure GetSelectTables(aSQL: TdaSQL; aChildsLinks: TList);
      procedure GetSQLInfo(aSQL: TdaSQL; aChildsLinks: TList);
      function HasMaster(aSQL: TdaSQL): Boolean;
      procedure Init(aSQL: TdaSQL);
      function ShouldGetTablesFromMaster(aSQL: TdaSQL): Boolean;
      procedure UpdateSQLFieldNames;

    protected
      function GetReportParameters: TppParameterList; override;
    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      function GenerateMagicSQL: Boolean; virtual;
      function GetLinkFieldNames(aIndex: Integer; var aMasterFieldName, aDetailFieldName: String; var aDetailAscending: Boolean): Boolean;

      property MagicLinkCount read GetMagicLinkCount;
      property MagicFieldCount: Integer read FMagicFieldCount write FMagicFieldCount;
      property MagicSQLText: TStrings read FMagicSQLText;

  end; {class, TdaMagicSQL}


implementation

uses
  ppReport;

{*******************************************************************************
 *
 ** M A G I C  L I N K
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaMagicLink.Create }

constructor TdaMagicLink.Create(aMasterField, aDetailField: TdaField; aAscending: Boolean; aIsOrderByFromMaster: Boolean);
begin
  inherited Create;

  FAscending := aAscending;
  FIsOrderByFromMaster := aIsOrderByFromMaster;

  {initialize reference to the DetailField}
  FDetailField := aDetailField;

  {make a copy of the MasterField}
  FMasterField := TdaField(TComponentClass(aMasterField.ClassType).Create(nil));
  FMasterField.Assign(aMasterField);

  {if master field is from a masterSQL OrderBy, do not use the SQLFieldName,
   this will be calculated by TdaMagicLinks.ValidateMasterSQLFieldName }
  if FIsOrderByFromMaster and not(aMasterField is TdaCalculation) then
    FMasterField.SQLFieldName := aMasterField.FieldName;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaMagicLink.Destroy }

destructor TdaMagicLink.Destroy;
begin
  FMasterField.Free;

  inherited Destroy;

end; {destructor, Destroy}

{*******************************************************************************
 *
 ** M A G I C  L I N K S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaMagicLinks.Create }

constructor TdaMagicLinks.Create(aMagicSQL: TdaMagicSQL);
begin
  inherited Create;

  FMagicSQL := aMagicSQL;
  FItems := TList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaMagicLinks.Destroy }

destructor TdaMagicLinks.Destroy;
begin
  Clear;

  FItems.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaMagicLinks.Clear }

procedure TdaMagicLinks.Clear;
var
  liIndex: Integer;
begin
  for liIndex := 0 to FItems.Count - 1 do
    TObject(FItems[liIndex]).Free;

  FItems.Clear;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TdaMagicLinks.Add }

procedure TdaMagicLinks.Add(aMasterField, aDetailField: TdaField; aAscending: Boolean; aIsOrderByFromMaster: Boolean);
var
  lMagicLink: TdaMagicLink;
begin
  lMagicLink := TdaMagicLink.Create(aMasterField, aDetailField, aAscending, aIsOrderByFromMaster);

  FItems.Add(lMagicLink);

end; {procedure, Add}

{------------------------------------------------------------------------------}
{ TdaMagicLinks.GetCount }

function TdaMagicLinks.GetCount: Integer;
begin
  Result := FItems.Count;

end; {function, GetCount}

{------------------------------------------------------------------------------}
{ TdaMagicLinks.GetItem }

function TdaMagicLinks.GetItem(aIndex: Integer): TdaMagicLink;
begin
  Result := TdaMagicLink(FItems[aIndex]);
  
end; {function, GetItem}

{------------------------------------------------------------------------------}
{ TdaMagicLinks.GetMasterOrderByFields }

function TdaMagicLinks.GetMasterOrderByFields(aFields: TList): Boolean;
var
  liIndex: Integer;
  lLink: TdaMagicLink;

begin
  liIndex := 0;
  Result := False;

  {add master fields for links that originated from a master SQL OrderBy}
  while (liIndex < FItems.Count) do
    begin
      lLink := GetItem(liIndex);
      if lLink.IsOrderByFromMaster then
        begin
          aFields.Add(lLink.MasterField);
          Result := True;
        end;

      Inc(liIndex);
    end;

end; {function, GetMasterOrderByFields}

{------------------------------------------------------------------------------}
{ TdaMagicLinks.ValidateMasterSQLFieldNames }

procedure TdaMagicLinks.ValidateMasterSQLFieldNames;
var
  liIndex: Integer;
  lOrderByFields: TList;
  lOrderByField: TdaField;
  lSelectField: TdaField;
  lTable: TdaTable;
  lTempSQL: TdaMagicSQL;
begin

  {if the link originated from the OrderBy of a higher level TdaSQL objects,
   then check whether the field name we are using needs to be re-aliased. This
   can occur if the immediate MasterSQL contains a different table with the
   same field in its Select fields.}

  lOrderByFields := TList.Create;

  try

    {get a list of the linked master order by fields}
    if GetMasterOrderByFields(lOrderByFields) then
      begin

        {create a tempSQL object that is a clone of the master SQL}
        lTempSQL := TdaMagicSQL.Create(FMagicSQL.MasterSQL);
        lTempSQL.Assign(FMagicSQL.MasterSQL);

        // generate magic sql for master sql
        lTempSQL.GenerateMagicSQL;

        try

          {augment TempSQL with master OrderBy fields, as needed. These need to
           be added in reverse order - therefore process the list last to first.}
          for liIndex := lOrderByFields.Count-1 downto 0  do
            begin
              lOrderByField := TdaField(lOrderByFields[liIndex]);

              if (lOrderByField is TdaCalculation) then
                lSelectField := lTempSQL.GetCalcFieldForSQLFieldName(lOrderByField.SQLFieldName)
              else
                lSelectField := lTempSQL.GetSelectFieldForFieldName(lOrderByField.TableSQLAlias, lOrderByField.FieldName);

              if (lSelectField = nil) then
                begin
                  {use FMagicSQL to get the table corresponding to this field}
                  lTable := FMagicSQL.GetTableForSQLAlias(lOrderByField.TableSQLAlias);

                  {Add the field to the SelectFields[] array, this will cause the
                  field to be assigned an appropriate SQLFieldName.
                     - the lTable parameter is used to pass the table name, it
                       is not necessary to add the Table to the SQL since we
                       are not trying to create a valid SQL text string.}

                  lSelectField := lTempSQL.AddSelectField(lTable, lOrderByField.FieldName);

                  {assign the properties to the linking field}

                end;

              lOrderByField.Assign(lSelectField);


            end;
        finally
          lTempSQL.Free;

        end;

      end;

  finally

    lOrderByFields.Free;
  end;

end; {procedure, ValidateMasterSQLFieldNames}


{*******************************************************************************
 *
 ** M A G I C   S Q L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.Create }

constructor TdaMagicSQL.Create(aOwner: TComponent);
begin
  if not (aOwner is TdaSQL) then
    raise EDataError.Create('TdaMagicSQL.Create: Owner must be TdaSQL');

  inherited Create(aOwner);

  FRootSQL := TdaSQL(aOwner);

  FMagicFieldCount := 0;

  FMagicFields := TList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.Destroy }

destructor TdaMagicSQL.Destroy;
begin

  FMagicSQLText.Free;
  FMagicLinks.Free;

  FMagicFields.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GenerateMagicSQL }

function TdaMagicSQL.GenerateMagicSQL: Boolean;
begin

  Init(FRootSQL);

  GetSQLInfo(FRootSQL, nil);

  if (MasterSQL <> nil) then
    FMagicLinks.ValidateMasterSQLFieldNames;

  if (GroupByFieldCount > 0) and not(HasAggregates)then
    begin
      {remove all group by fields and add Distinct}
      ClearGroupByFields;
      Distinct := True; 
    end;

  LinkingSQL := True;

  try
    FMagicSQLText.Assign(SQLText);

  finally
    LinkingSQL := False;
  end;

  Result := True;

end; {function, GenerateMagicSQL}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.ShouldGetTablesFromMaster }

function TdaMagicSQL.ShouldGetTablesFromMaster(aSQL: TdaSQL): Boolean;
var
  liIndex: Integer;
begin

  {if aSQL is Master, we only add its table(s) if it has OrderBy fields (which
     are not linking fields) or more than one SelectTable}

  Result := (aSQL.SelectTableCount > 1) or (aSQL.CriteriaCount > 0);

  liIndex := 0;

  while (not(Result)) and (liIndex < aSQL.OrderByFieldCount) do
    if not(FieldNameInLinks(aSQL.OrderByFields[liIndex].FieldName, aSQL, True)) then
      Result := True
    else
      Inc(liIndex);

end; {function, ShouldGetTablesFromMaster}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetMagicLinks }

function TdaMagicSQL.GetMagicLinks: TdaMagicLinks;
begin
  if (FMagicLinks = nil) then
    FMagicLinks := TdaMagicLinks.Create(Self);

  Result := FMagicLinks;

end; {function, GetMagicLinks}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetMagicLinkCount }

function TdaMagicSQL.GetMagicLinkCount;
begin
  if (FMagicLinks = nil) then
    Result := 0
  else
    Result := FMagicLinks.Count;

end; {function, GetMagicLinkCount}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetSearchCriteria }

procedure TdaMagicSQL.GetSearchCriteria(aSQL: TdaSQL; aChildsLinks: TList);
begin

  if (aChildsLinks = nil) then
    AssignCriteriaFieldsFrom(aSQL)

  else
    GetSearchCriteriaFromMaster(aSQL);

end; {function, GetSearchCriteria}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetOrderByFields }
{ Called internally to retrieve OrderBy fields from aSQL }

procedure TdaMagicSQL.GetOrderByFields(aSQL: TdaSQL);
var
  liIndex: Integer;
  lTable: TdaTable;
  lField: TdaField;
  lOrderByField: TdaField;
  lsTableSQLAlias: String;
begin

  {Add columns for any OrderBy fields which are not linking fields}
  for liIndex := 0 to aSQL.OrderByFieldCount - 1 do
    begin
      lOrderByField := aSQL.OrderByFields[liIndex];

      if not(FieldNameInLinks(lOrderByField.FieldName, aSQL, True)) then
        begin
          lField := nil;

          {Make sure we get the right table instance for this field}
          lsTableSQLAlias := TableAliasManager.GetNewAlias(aSQL.Name, lOrderByField.TableSQLAlias);

          lTable := GetTableForSQLAlias(lsTableSQLAlias);

          {look in Calc fields}
          if (lOrderByField is TdaCalculation) and (lTable <> nil) and (lField = nil) then
            lField := GetTableCalcFieldForSQLFieldName(lTable, lOrderByField.SQLFieldName);

          {look in Select fields}
          if (lTable <> nil) and (lField = nil) then
            lField := GetSelectFieldForFieldName(lTable.SQLAlias, lOrderByField.FieldName);

          if (lField = nil) then
            lField := AddMagicSelectField(lTable, lOrderByField);

          if (lField <> nil) and not(FieldExistsInOrderBys(lField)) then
            begin
              AddOrderByField(lField, lOrderByField.Ascending {Ascending});

              GetMagicLinks.Add(lField, lField, lOrderByField.Ascending {Ascending}, aSQL <> Owner {IsOrderByFromMaster});
            end;

        end;
    end;

end; {procedure, GetOrderByFields}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetGroupByFields }

procedure TdaMagicSQL.GetGroupByFields(aSQL: TdaSQL; aChildsLinks: TList);
var
  liIndex: Integer;
  lField: TdaField;
begin

  if (aChildsLinks <> nil) then Exit;

  // if there are no child links, then this is the lowest detail

  // check whether Group By clause is needed
  if aSQL.HasAggregates or (aSQL.GroupByFieldCount > 0)  then
    begin
      // add original group by fields
      for liIndex := 0 to aSQL.GroupByFieldCount - 1 do
        AddMagicGroupByField(aSQL.GroupByFields[liIndex], aSQL);

      // add select fields
      for liIndex := 0 to SelectFieldCount - 1 do
        AddMagicGroupByField(SelectFields[liIndex], aSQL);

      // add any linking calc fields
      for liIndex := 0 to FMagicFields.count - 1 do
        begin
          lField := TdaField(FMagicFields[liIndex]);
          if lField is TdaCalculation then
            AddMagicGroupByField(lField, aSQL);
        end;

{
      if (aSQL.DatabaseType in [dtInterbase]) then
         // do nothing
      else
        // add non-aggregate calc fields
        for liIndex := 0 to CalcFieldCount - 1 do
          if (not CalcFields[liIndex].IsAggregate) and (not(CalcFields[liIndex].IsSubSelect)) then
            AddMagicGroupByField(CalcFields[liIndex], aSQL);

}

    end;


end; {procedure, GetGroupByFields}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetSelectFields }
{ Called internally to retrieve Select fields from aSQL }

procedure TdaMagicSQL.GetSelectFields(aSQL: TdaSQL; aChildsLinks: TList);
begin

  if (aChildsLinks = nil) then
    GetAllFields(aSQL)

  else
    if (HasMaster(aSQL)) then
      GetSelectFieldsFromDetail(aSQL, aChildsLinks)
    else
      GetSelectFieldsFromMaster(aSQL, aChildsLinks);

end; {procedure, GetSelectFields}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.UpdateSQLFieldNames }

procedure TdaMagicSQL.UpdateSQLFieldNames;
var
  liIndex: Integer;
  lField: TdaField;
//  lCalcField: TdaCalculation;
begin

  for liIndex := 0 to FMagicFields.Count - 1 do
    begin
      lField := TdaField(FMagicFields[liIndex]);
      lField.SQLFieldName := GetMagicAlias(lField);
    end;

{  for liIndex := 0 to CalcFieldCount - 1 do
    begin
      lCalcField := CalcFields[liIndex];

//      if not(lCalcField.Calctype = dacaExpression) then
        lCalcField.SQLFieldName := GetMagicAlias(lCalcField);

    end;
}

end; {procedure, UpdateSQLFieldNames}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AssignSelectFieldsFrom }

procedure TdaMagicSQL.AssignSelectFieldsFrom(aSourceSQL: TdaSQL);
var
  liIndex: Integer;
  lField: TdaField;
  lNewField: TdaField;
begin

  for liIndex := 0 to aSourceSQL.SelectFieldCount - 1 do
    begin
      lField := aSourceSQL.SelectFields[liIndex];

      lNewField := lField.Clone(Self);

      { Make sure we point at correct table instance }
      lNewField.TableSQLAlias := TableAliasManager.GetNewAlias(aSourceSQL.Name, lNewField.TableSQLAlias);
      lNewField.Parent := Self;
    end;

end;  {procedure, AssignSelectFieldsFrom}


{------------------------------------------------------------------------------}
{ TdaMagicSQL.FixupCalcExpressionTableReferences }

procedure TdaMagicSQL.FixupCalcExpressionTableReferences(aCalcField: TdaCalculation; aSQL: TdaSQL);
var
  liIndex: Integer;
  lsOldTableAlias: String;
  lsNewTableAlias: String;
begin

  for liIndex := 0 to aSQL.SelectTableCount - 1 do
    begin
      lsOldTableAlias := aSQL.SelectTables[liIndex].SQLAlias;

      lsNewTableAlias := TableAliasManager.GetNewAlias(aSQL.Name, lsOldTableAlias);

      FixupCalcExpressionTableReferences(aCalcField, lsOldTableAlias, lsNewTableAlias);

    end;

end; {procedure, FixupExpressionCalcTableReferences}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.FixupCalcExpressionTableReferences }

procedure TdaMagicSQL.FixupCalcExpressionTableReferences(aCalcField: TdaCalculation; aOldTableAlias, aNewTableAlias: String);
var
  lsOldTableAlias: String;
  lsNewTableAlias: String;
  lsExpression: String;
  lsOldExpression: String;
begin

  lsOldExpression := aCalcField.Expression;

  lsOldTableAlias := aOldTableAlias + '.';
  lsNewTableAlias := aNewTableAlias + '.';

  lsExpression := StringReplace(aCalcField.Expression, lsOldTableAlias, lsNewTableAlias, [rfReplaceAll, rfIgnoreCase]);

  aCalcField.Expression := lsExpression;

  aCalcField.MagicallyTweaked := (lsOldExpression <> aCalcField.Expression);

end; {procedure, FixupCalcExpressionTableReferences}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AssignCalcFieldsFrom }

procedure TdaMagicSQL.AssignCalcFieldsFrom(aSourceSQL: TdaSQL);
var
  liIndex: Integer;
  lField: TdaCalculation;
  lNewField: TdaCalculation;
begin

  for liIndex := 0 to aSourceSQL.CalcFieldCount - 1 do
    begin
      lField := aSourceSQL.CalcFields[liIndex];

      lNewField := TdaCalculation(lField.Clone(Self));

      if (lNewField.CalcType = dacaExpression) then
        FixupCalcExpressionTableReferences(lNewField, aSourceSQL);

      { Make sure we point at correct table instance }
      lNewField.TableSQLAlias := TableAliasManager.GetNewAlias(aSourceSQL.Name, lNewField.TableSQLAlias);
      lNewField.Parent := Self;
    end;

end;  {procedure, AssignCalcFieldsFrom}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AssignOrderByFields }

procedure TdaMagicSQL.AssignOrderByFieldsFrom(aSourceSQL: TdaSQL);
var
  liIndex: Integer;
  lField: TdaField;
  lNewField: TdaField;
begin

  for liIndex := 0 to aSourceSQL.OrderByFieldCount - 1 do
    begin
      lField := aSourceSQL.OrderByFields[liIndex];

      lNewField := lField.Clone(Self);

      { Make sure we point at correct table instance }
      lNewField.TableSQLAlias := TableAliasManager.GetNewAlias(aSourceSQL.Name, lNewField.TableSQLAlias);

      if not(FieldExistsInOrderBys(lNewField)) then
        lNewField.Parent := Self
      else
        lNewField.Free;

    end;

end; {procedure, AssignOrderByFields}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AssignGroupByFieldsFrom }

{procedure TdaMagicSQL.AssignGroupByFieldsFrom(aSourceSQL: TdaSQL);
var
  liIndex: Integer;
  lField: TdaField;
  lNewField: TdaField;
  lCalcField: TdaCalculation;
begin

// this method no longer used

  for liIndex := 0 to aSourceSQL.GroupByFieldCount - 1 do
    begin
      lField := aSourceSQL.GroupByFields[liIndex];

      if not(FieldExistsInGroupBys(lField)) then
        begin
          lNewField := lField.Clone(Self);

          // Make sure we point at correct table instance
          lNewField.TableSQLAlias := TableAliasManager.GetNewAlias(aSourceSQL.Name, lNewField.TableSQLAlias);

          if (lNewField is TdaCalculation) then
            begin
              lCalcField := TdaCalculation(lNewField);

              if (lCalcField.CalcType = dacaExpression) then
                FixupCalcExpressionTableReferences(lCalcField, aSourceSQL);
            end;

          lNewField.Parent := Self;
        end;
    end;

end;}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetAllFields }

procedure TdaMagicSQL.GetAllFields(aSQL: TdaSQL);
begin

  if (aSQL <> nil) then
    begin
      AssignSelectFieldsFrom(aSQL);
      AssignCalcFieldsFrom(aSQL);

      {Now that all Select and Calc fields added, validate the SQLFieldNames}
      UpdateSQLFieldNames;

      // add master linking fields as group by
      AddMasterFieldsAsGroupByFields(aSQL);

      // skip processing group fields, they can be added at the very end
      // by simply adding all select fields and non-aggregate calc fields
//      AssignGroupByFieldsFrom(aSQL);

      {Faux orderby fields from the master should go before the detail's}
      AddMasterFieldsAsOrderByFields(aSQL, True);

      AddDetailLinkFieldsAsMagicOrderBy(aSQL);

      AssignOrderByFieldsFrom(aSQL);

    end;

end; {procedure, GetAllFields}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetSelectFieldsFromDetail }

procedure TdaMagicSQL.GetSelectFieldsFromDetail(aSQL: TdaSQL; aChildsLinks: TList);
var
  liIndex: Integer;
  lSQLLink: TdaSQLLink;
  lTable: TdaTable;
  lsTableSQLAlias: String;
begin

  {We need to add any fields that are involved in linking either as Master or as
   detail part of link.}

  AddMasterFieldsAsSelectFields(aSQL);

  AddMasterLinkFieldsAsMagicSelect(aSQL, aChildsLinks);

  AddMasterFieldsAsOrderByFields(aSQL, False);

  {using aSQL's links, add fields as Detail}
  for liIndex := 0 to aSQL.LinkCount - 1 do
    begin
      lSQLLink := TdaSQLLink(aSQL.Links[liIndex]);

      {Make sure we get the right table instance for this field}
      lsTableSQLAlias := TableAliasManager.GetNewAlias(aSQL.Name, lSQLLink.DetailField.TableSQLAlias);

      lTable := GetTableForSQLAlias(lsTableSQLAlias);

      AddMagicSelectField(lTable, lSQLLink.DetailField);
    end;

  AddDetailLinkFieldsAsMagicOrderBy(aSQL);

end; {procedure, GetSelectFieldsFromDetail}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetSelectFieldsFromMaster }

procedure TdaMagicSQL.GetSelectFieldsFromMaster(aSQL: TdaSQL; aChildsLinks: TList);
begin

  {if aChildsLinks is nil, then aSQL is the bottom detail}
  if (aChildsLinks = nil) then
    GetAllFields(aSQL)

  else
    {if we added tables from this master, then we should add its link fields}
    if (ShouldGetTablesFromMaster(aSQL)) then
      AddMasterLinkFieldsAsMagicSelect(aSQL, aChildsLinks);

end; {procedure, GetSelectFieldsFromMaster}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetSelectTables }
{ Called internally to retrieve Select tables from aSQL }

procedure TdaMagicSQL.GetSelectTables(aSQL: TdaSQL; aChildsLinks: TList);
var
  liIndex: Integer;
  liIndex2: Integer;
  lOldTable: TdaTable;
  lNewTable: TdaTable;
  lTableJoin: TdaTableJoin;
  lsTableSQLAlias: String;
  lLocalTable: TdaTable;
  lForeignTable: TdaTable;
  lSQLLink: TdaSQLLink;
  lMasterTable: TdaTable;
  lDetailTable: TdaTable;
begin

  {if not HasMaster, then aSQL is the Topmost master. If aChildsLinks is nil,
   then aSQL is the bottom most detail. If both, then aSQL is not linked}
  if not(HasMaster(aSQL)) then
    if (not(ShouldGetTablesFromMaster(aSQL)) and (aChildsLinks <> nil)) then Exit;

  {add tables}
  for liIndex := 0 to aSQL.SelectTableCount - 1 do
    begin
      lOldTable := aSQL.SelectTables[liIndex];

      lNewTable := AddTable(lOldTable.RawTableName);

      if (lNewTable = nil) then
        raise EDataError.Create('TdaMagicSQL.GetSelectTables: Unable to add table.');

      lNewTable.JoinType := lOldTable.JoinType;

      TableAliasManager.AddAlias(aSQL.Name, lOldTable.SQLAlias, lNewTable.SQLAlias, lNewTable);
    end;

  {add tablejoins}
  for liIndex := 0 to aSQL.SelectTableCount - 1 do
    begin
      lOldTable := aSQL.SelectTables[liIndex];

      for liIndex2 := 0 to lOldTable.TableJoinCount - 1 do
        begin
          lTableJoin := lOldTable.TableJoins[liIndex2];

          lsTableSQLAlias  := TableAliasManager.GetNewAlias(aSQL.Name, lTableJoin.LocalField.TableSQLAlias);
          lLocalTable := GetTableForSQLAlias(lsTableSQLAlias);

          if (lLocalTable = nil) then
            raise EDataError.Create('TdaMagicSQL.GetSelectTables: Unable to find local table: ' + lsTableSQLAlias);

          if (lTableJoin.ForeignField = nil) then
            AddMagicTableJoin(lLocalTable, lTableJoin.LocalField, lTableJoin.Operator, lTableJoin.Expression)
          else
           begin
              lsTableSQLAlias := TableAliasManager.GetNewAlias(aSQL.Name, lTableJoin.ForeignField.TableSQLAlias);
              lForeignTable := GetTableForSQLAlias(lsTableSQLAlias);

              if (lForeignTable = nil) then
                raise EDataError.Create('TdaMagicSQL.GetSelectTables: Unable to find foreign table: ' + lsTableSQLAlias);

              AddMagicTableJoin(lForeignTable, lLocalTable, lTableJoin.ForeignField, lTableJoin.LocalField, lTableJoin.Operator);
           end;
        end;
    end;

  {add links}
  for liIndex := 0 to aSQL.LinkCount - 1 do
    begin
      lSQLLink := TdaSQLLink(aSQL.Links[liIndex]);

      lsTableSQLAlias := TableAliasManager.GetNewAlias(lSQLLink.DetailSQLName, lSQLLink.DetailField.TableSQLAlias);
      lDetailTable := GetTableForSQLAlias(lsTableSQLAlias);

      if (lDetailTable = nil) then
        raise EDataError.Create('TdaMagicSQL.GetSelectTables: Unable to find detail table: ' + lsTableSQLAlias);

      if (lDetailTable.JoinType = dajtNone) then
        lDetailTable.JoinType := dajtInner;

      lsTableSQLAlias := TableAliasManager.GetNewAlias(lSQLLink.MasterSQLName, lSQLLink.MasterField.TableSQLAlias);
      lMasterTable := GetTableForSQLAlias(lsTableSQLAlias);

      {if table does not appear in SQL object, then we do not need to link the table into the query}
      if (lMasterTable <> nil) then
        AddMagicTableJoin(lMasterTable, lDetailTable, lSQLLink.MasterField, lSQLLink.DetailField, dajoEqual);
    end;


end; {procedure, GetSelectTables}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AddMagicTableJoin }

procedure TdaMagicSQL.AddMagicTableJoin(aMasterTable, aDetailTable: TdaTable; aMasterField, aDetailField: TdaField; aType: TdaJoinOperatorType);
var
  lTableJoin: TdaTableJoin;
  lMasterField: TdaField;
  lDetailField: TdaField;
begin

  if (aMasterTable = nil) then
    raise EDataError.Create('TdaMagicSQL.AddMagicTableJoin: aMasterTable cannot be nil.');

  if (aDetailTable = nil) then
    raise EDataError.Create('TdaMagicSQL.AddMagicTableJoin: aDetailTable cannot be nil.');

  if (aMasterField = nil) then
    raise EDataError.Create('TdaMagicSQL.AddMagicTableJoin: aMasterField cannot be nil.');

  if (aDetailField = nil) then
    raise EDataError.Create('TdaMagicSQL.AddMagicTableJoin: aDetailField cannot be nil.');

  lTableJoin := TdaTableJoin.Create(aDetailTable);
  lTableJoin.Operator := aType;

  if (aMasterTable <> nil) then
    begin
      lMasterField := CloneFieldForTableJoin(aMasterField, aMasterTable, lTableJoin);
      lMasterField.ChildType := Ord(dactForeignField);
    end;

  lDetailField := CloneFieldForTableJoin(aDetailField, aDetailTable, lTableJoin);
  lDetailField.ChildType := Ord(dactLocalField);

  lTableJoin.Parent := aDetailTable;

end; {function, AddMagicTableJoin}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AddMagicTableJoin }

procedure TdaMagicSQL.AddMagicTableJoin(aDetailTable: TdaTable; aDetailField: TdaField; aType: TdaJoinOperatorType; aExpression: String);
var
  lTableJoin: TdaTableJoin;
  lDetailField: TdaField;
begin

  if (aDetailTable = nil) then
    raise EDataError.Create('TdaMagicSQL.AddMagicTableJoin: aDetailTable cannot be nil.');

  if (aDetailField = nil) then
    raise EDataError.Create('TdaMagicSQL.AddMagicTableJoin: aDetailField cannot be nil.');

  lTableJoin := TdaTableJoin.Create(aDetailTable);
  lTableJoin.Operator := aType;

  lTableJoin.Expression := aExpression;

  lDetailField := CloneFieldForTableJoin(aDetailField, aDetailTable, lTableJoin);
  lDetailField.ChildType := Ord(dactLocalField);

  lTableJoin.Parent := aDetailTable;

end; {function, AddMagicTableJoin}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AddMasterFieldsAsSelectFields }
{ if the Master SQL does not add its tables to the MagicSQL, the 1st level detail
  needs to add its own linking fields to the Select in place of the Master's. i.e.,
  in Customer/Orders/Items, Orders needs to add its CustomerID field to the Magic Select }

procedure TdaMagicSQL.AddMasterFieldsAsSelectFields(aDetailSQL: TdaSQL);
var
  liIndex: Integer;
  lSQLLink: TdaSQLLink;
  lTable: TdaTable;
  lsTableSQLAlias: String;
begin

  if (aDetailSQL <> nil) and (aDetailSQL.MasterSQL <> nil) and
      not(HasMaster(aDetailSQL.MasterSQL)) and not(ShouldGetTablesFromMaster(aDetailSQL.MasterSQL)) then

    begin
      for liIndex := 0 to aDetailSQL.LinkCount - 1 do
        begin
          lSQLLink := TdaSQLLink(aDetailSQL.Links[liIndex]);

          {Make sure we get the right table instance for this field}
          lsTableSQLAlias := TableAliasManager.GetNewAlias(aDetailSQL.Name, lSQLLink.DetailField.TableSQLAlias);

          lTable := GetTableForSQLAlias(lsTableSQLAlias);

          AddMagicSelectField(lTable, lSQLLink.DetailField);
        end;
    end;

end; {function, AddMasterFieldsAsSelectFields}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AddMasterFieldsAsGroupByFields }

procedure TdaMagicSQL.AddMasterFieldsAsGroupByFields(aDetailSQL: TdaSQL);
var
  liIndex: Integer;
begin


   for liIndex := 0 to FMagicFields.count - 1 do
      AddMagicGroupByField(TdaField(FMagicFields[liIndex]), aDetailSQL);

    for liIndex := 0 to aDetailSQL.LinkCount - 1 do
      AddMagicGroupByField(aDetailSQL.Links[liIndex].MasterField, aDetailSQL);

end;

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AddMasterFieldsAsOrderByFields }
{ if the Master SQL does not add its tables to the MagicSQL, the 1st level detail
  needs to add its own linking fields to the OrderBys in place of the Master's. i.e.,
  in Customer/Orders/Items, Orders needs to add its CustomerID field to the Magic OrderBys }

procedure TdaMagicSQL.AddMasterFieldsAsOrderByFields(aDetailSQL: TdaSQL; aLowestDetail: Boolean);
var
  liIndex: Integer;
  lSQLLink: TdaSQLLink;
  lTable: TdaTable;
  lDetailField: TdaField;
  lMasterField: TdaField;
  lsTableSQLAlias: String;
begin

  if (aDetailSQL <> nil) and (aDetailSQL.MasterSQL <> nil) and
      not(HasMaster(aDetailSQL.MasterSQL)) and not(ShouldGetTablesFromMaster(aDetailSQL.MasterSQL)) then

    begin
      for liIndex := 0 to aDetailSQL.LinkCount - 1 do
        begin
          lSQLLink := TdaSQLLink(aDetailSQL.Links[liIndex]);

          {Make sure we get the right table instance for this field}
          lsTableSQLAlias := TableAliasManager.GetNewAlias(aDetailSQL.Name, lSQLLink.DetailField.TableSQLAlias);

          lTable := GetTableForSQLAlias(lsTableSQLAlias);

          lDetailField := GetSelectFieldForFieldName(lTable.SQLAlias, lSQLLink.DetailField.FieldName);

          if (aLowestDetail) then
            lMasterField := lSQLLink.MasterField
          else
            lMasterField := lSQLLink.DetailField;

          if (lDetailField <> nil) and not(FieldExistsInOrderBys(lDetailField)) then
            begin
              AddOrderByField(lDetailField, True {Ascending});

              GetMagicLinks.Add(lMasterField, lDetailField, True {Ascending}, False {IsOrderByFromMaster});
            end;


        end;
    end;

end; {function, AddMasterFieldsAsOrderByFields}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AddMasterLinkFieldsAsMagicSelect }

procedure TdaMagicSQL.AddMasterLinkFieldsAsMagicSelect(aSQL: TdaSQL; aChildsLinks: TList);
var
  liIndex: Integer;
  lSQLLink: TdaSQLLink;
  lTable: TdaTable;
  lsTableSQLAlias: String;
begin

  for liIndex := 0 to aChildsLinks.Count - 1 do
    begin
      lSQLLink := TdaSQLLink(aChildsLinks[liIndex]);

      {Make sure we get the right table instance for this field}
      lsTableSQLAlias := TableAliasManager.GetNewAlias(aSQL.Name, lSQLLink.MasterField.TableSQLAlias);

      lTable := GetTableForSQLAlias(lsTableSQLAlias);

      AddMagicSelectField(lTable, lSQLLink.MasterField);
    end; {for liIndex...}

end; {procedure, AddMasterLinkFieldsAsMagicSelect}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AddDetailLinkFieldsAsMagicOrderBy }

procedure TdaMagicSQL.AddDetailLinkFieldsAsMagicOrderBy(aSQL: TdaSQL);
var
  liIndex: Integer;
  lSQLLink: TdaSQLLink;
  lTable: TdaTable;
  lDetailField: TdaField;
  lLinks: TList;
  lsTableSQLAlias: String;
begin

  lLinks := GetLinksListForSQL(aSQL);

  if (lLinks <> nil) then
    try

      for liIndex := 0 to lLinks.Count - 1 do
        begin
          lSQLLink := TdaSQLLink(lLinks[liIndex]);

          {Make sure we get the right table instance for this field}
          lsTableSQLAlias := TableAliasManager.GetNewAlias(aSQL.Name, lSQLLink.DetailField.TableSQLAlias);

          lTable := GetTableForSQLAlias(lsTableSQLAlias);

          if (lSQLLink.DetailField is TdaCalculation) then
            lDetailField := GetCalcFieldForFieldName(lTable.SQLAlias, lSQLLink.DetailField.SQLFieldName)
          else
            lDetailField := GetSelectFieldForFieldName(lTable.SQLAlias, lSQLLink.DetailField.FieldName);

          if (lDetailField <> nil) and not(FieldExistsInOrderBys(lDetailField)) and
                                       not(FieldExistsInOrderBys(lSQLLink.MasterField)) then
            begin
              AddOrderByField(lDetailField, True {Ascending});

              GetMagicLinks.Add(lSQLLink.MasterField, lDetailField, True {Ascending}, aSQL <> Owner {IsOrderByFromMaster});
            end;

        end; {for liIndex...}

    finally
      lLinks.Free;
    end;

end; {procedure, AddDetailLinkFieldsAsMagicOrderBy}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AddMagicGroupByField }

procedure TdaMagicSQL.AddMagicGroupByField(aField: TdaField; aSQLObject: TdaSQL);
var
  lField: TdaField;
begin

  if not(FieldExistsInGroupBys(aField)) then
    begin
      lField := AddGroupByField(aField);

      if (lField <> nil) then
        lField.TableSQLAlias := aField.TableSQLAlias;
    end;

end; {procedure, AddMagicGroupByField}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AddMagicSelectField }

function TdaMagicSQL.AddMagicSelectField(aTable: TdaTable; aField: TdaField): TdaField;
var
  lField: TdaField;
begin

  if not(FieldExistsInSelectFields(aField)) then
    begin
      lField := aField.Clone(Self);

      // update the child type, aField.ChildType is not correct
      if (aField is TdaCalculation) then
        lField.ChildType := Ord(dactCalcField)
      else
        lField.ChildType := Ord(dactSelectField);

      lField.Parent := Self;

      {Assure magic field is renamed}
      lField.SQLFieldName := GetMagicAlias(lField);

      lField.TableName := aTable.TableName;
      lField.TableAlias := aTable.TableAlias;
      lField.TableSQLAlias := aTable.SQLAlias;

      FMagicFields.Add(lField);

      Inc(FMagicFieldCount);

      Result := lField;
    end
  else
    Result := GetSelectFieldForFieldName(aTable.SQLAlias, aField.FieldName);

end; {procedure, AddMagicSelectField}



{------------------------------------------------------------------------------}
{ TdaMagicSQL.FieldExistsInOrderBys }

function TdaMagicSQL.FieldExistsInOrderBys(aField: TdaField): Boolean;
var
  liIndex: Integer;
begin

  Result := False;
  liIndex := 0;

  if (OrderByFieldCount > 0) and (aField <> nil) then
    while (Result = False) and (liIndex < OrderByFieldCount) do
      begin
        if aField is TdaCalculation then
          begin
            {note: use SQLFieldName here because two calcs on the same field cause the field to appear twice}
            Result := ((CompareText(OrderByFields[liIndex].SQLFieldName, aField.SQLFieldName) = 0) and
                       (CompareText(OrderByFields[liIndex].TableName, aField.TableName) = 0){ and
                       (OrderByFields[liIndex].Ascending = aField.Ascending)});
          end
        else
          begin
            Result := ((CompareText(OrderByFields[liIndex].FieldName, aField.FieldName) = 0) and
                      (CompareText(OrderByFields[liIndex].TableName, aField.TableName) = 0) and

                       // added this check, for customers submitted case,
                       // SQL using multiple Left Outer Joins on same table
                       // with same field from each used in the Order By
                      (CompareText(OrderByFields[liIndex].TableSQLAlias, aField.TableSQLAlias) = 0){ and
                      (OrderByFields[liIndex].Ascending = aField.Ascending)});
          end;

        Inc(liIndex);
      end;

end; {function, FieldExistsInOrderBys}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.FieldExistsInSelectFields }

function TdaMagicSQL.FieldExistsInSelectFields(aField: TdaField): Boolean;
begin

  if aField is TdaCalculation then
    Result := GetCalcFieldForFieldName(aField.TableSQLAlias, aField.SQLFieldName) <> nil
  else
    Result := GetSelectFieldForFieldName(aField.TableSQLAlias, aField.FieldName) <> nil;

end; {function, FieldExistsInSelectFields}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetSQLInfo }
{ Recursive method called internally to get linking info from all SQL objects in chain }

procedure TdaMagicSQL.GetSQLInfo(aSQL: TdaSQL; aChildsLinks: TList);
var
  lLinks: TList;
begin

  if (HasMaster(aSQL)) then
    begin
      lLinks := GetLinksListForSQL(aSQL);

      try
        GetSQLInfo(aSQL.MasterSQL, lLinks);

      finally
        lLinks.Free;
      end;

    end;

  GetSelectTables(aSQL, aChildsLinks);
  GetSelectFields(aSQL, aChildsLinks);
  GetSearchCriteria(aSQL, aChildsLinks);
  GetOrderByFields(aSQL);
  GetGroupByFields(aSQL, aChildsLinks);

  if (aSQL = FRootSQL) then
    GetGroupSearchCriteria(aSQL, aChildsLinks);

end; {procedure, GetSQLInfo}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.HasMaster }

function TdaMagicSQL.HasMaster(aSQL: TdaSQL): Boolean;
begin

  Result := False;

  if (aSQL <> nil) then
    Result := (aSQL.MasterSQL <> nil);

end; {function, HasMaster}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.Init }

procedure TdaMagicSQL.Init(aSQL: TdaSQL);
begin

  if (aSQL <> nil) then
    begin
      Clear;
      ClearSQLLinks;


      TableAliasManager.Clear;

      if (FMagicSQLText = nil) then
        FMagicSQLText := TStringList.Create;

      DatabaseName := aSQL.DatabaseName;
      DatabaseType := aSQL.DatabaseType;
      CollationType := aSQL.CollationType;
      IsCaseSensitive := aSQL.IsCaseSensitive;
      SQLType := aSQL.SQLType;
      Session := aSQL.Session;
      DataDictionary := aSQL.DataDictionary;
      Distinct := aSQL.Distinct;
      MasterSQL := aSQL.MasterSQL;

      FMagicFields.Clear;
      FMagicFieldCount := 0;

      GetMagicLinks.Clear;

      GetLinks(aSQL);
    end;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetLinks }

procedure TdaMagicSQL.GetLinks(aSQL: TdaSQL);
begin

  TdaLinkBroker(LinkBroker).UpdateColors := False;
  TdaLinkBroker(LinkBroker).Assign(aSQL.LinkBroker);

end; {procedure, GetLinks}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetLinkFieldNames }
{ The MagicLinks list contains all the field info that is to be used in creating
  pipeline links. MagicLinks are added to the list as we add link fields and
  OrderBy fields from the linked SQL objects. }

function TdaMagicSQL.GetLinkFieldNames(aIndex: Integer; var aMasterFieldName, aDetailFieldName: String; var aDetailAscending: Boolean): Boolean;
var
  lMagicLink: TdaMagicLink;
begin

  if (FMagicLinks = nil) then
    raise EDataError.Create('TdaMagicSQL.GetLinkFieldNames: FMagicLinks cannot be nil.');

  lMagicLink := FMagicLinks[aIndex];

  aDetailFieldName := lMagicLink.DetailField.SQLFieldName;
  aDetailAscending := lMagicLink.Ascending;

  aMasterFieldName := lMagicLink.MasterField.SQLFieldName;

  Result := True;

end; {function, GetLinkFieldNames}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.FieldNameInLinks }

function TdaMagicSQL.FieldNameInLinks(const aFieldName: String; aSQL: TdaSQL; aAsMaster: Boolean): Boolean;
var
  liIndex: Integer;
  lSQLLink: TdaSQLLink;
  lsFieldName: String;
begin

  Result := False;

  if (aFieldName <> '') and (aSQL <> nil) then
    begin
      liIndex := 0;

      while (not(Result)) and (liIndex < aSQL.LinkCount) do
        begin
          lSQLLink := TdaSQLLink(aSQL.Links[liIndex]);

          if aAsMaster then
            lsFieldName := lSQLLink.MasterField.FieldName
          else
            lsFieldName := lSQLLink.DetailField.FieldName;

          if (aFieldName = lsFieldName) then
            Result := True
          else
            Inc(liIndex);

        end;

    end;

end;  {function, FieldNameInLinks}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.CloneFieldForTableJoin }

function TdaMagicSQL.CloneFieldForTableJoin(aField: TdaField; aTable: TdaTable; aTableJoin: TdaTableJoin): TdaField;
var
  lCalcField: TdaCalculation;
begin

  Result := nil;

  if (aField <> nil) and (aTable <> nil) and (aTableJoin <> nil) then
    begin
      Result := aField.Clone(Self);

      {Since we're cloning this field, get rid of any aliasing}
      if not(Result is TdaCalculation) then
        Result.SQLFieldName := Result.FieldName;

      Result.Parent := aTableJoin;

      Result.TableName := aTable.TableName;
      Result.TableAlias := aTable.TableAlias;
      Result.TableSQLAlias := aTable.SQLAlias;


      if (Result is TdaCalculation) then
        begin
          lCalcField := TdaCalculation(Result);

          if (lCalcField.CalcType = dacaExpression) then
            FixupCalcExpressionTableReferences(lCalcField, aField.TableSQLAlias, Result.TableSQLAlias);

        end;

    end;

end;  {function, CloneFieldForTableJoin}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetLinksListForSQL }

function TdaMagicSQL.GetLinksListForSQL(aSQL: TdaSQL): TList;
var
  liIndex: Integer;
begin

  Result := TList.Create;

  if (aSQL <> nil) then
    for liIndex := 0 to aSQL.LinkCount - 1 do
      Result.Add(aSQL.Links[liIndex]);

end;  {function, GetLinksListForSQL}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetSelectFieldForFieldName }

function TdaMagicSQL.GetSelectFieldForFieldName(const aTableSQLAlias, aFieldName: String): TdaField;
var
  liIndex: Integer;
begin

  Result := nil;

  liIndex := 0;

  while (Result = nil) and (liIndex < SelectFieldCount) do
    begin
      if (ppEqual(aTableSQLAlias, SelectFields[liIndex].TableSQLAlias) and
          ppEqual(aFieldName, SelectFields[liIndex].FieldName)) then
        Result := SelectFields[liIndex]
      else
        Inc(liIndex);
    end;

end; {function, GetSelectFieldForFieldName}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetCalcFieldForFieldName }

function TdaMagicSQL.GetCalcFieldForFieldName(const aTableSQLAlias, aFieldName: String): TdaField;
var
  liIndex: Integer;
begin

  Result := nil;

  liIndex := 0;

  while (Result = nil) and (liIndex < CalcFieldCount) do
    begin
      if (ppEqual(aTableSQLAlias, CalcFields[liIndex].TableSQLAlias) and
          ppEqual(aFieldName, CalcFields[liIndex].SQLFieldName)) then
        Result := CalcFields[liIndex]
      else
        Inc(liIndex);
    end;

end; {function, GetSelectFieldForFieldName}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.FieldExistsInGroupBys }

function TdaMagicSQL.FieldExistsInGroupBys(aField: TdaField): Boolean;
var
  liIndex: Integer;
begin

  Result := False;
  liIndex := 0;

  if (GroupByFieldCount > 0) and (aField <> nil) then
    while (Result = False) and (liIndex < GroupByFieldCount) do
      begin
        if aField is TdaCalculation then
          begin
            {note: use SQLFieldName here because two calcs on the same field cause the field to appear twice}
            Result := ((CompareText(GroupByFields[liIndex].SQLFieldName, aField.SQLFieldName) = 0) and
                       (CompareText(GroupByFields[liIndex].TableSQLAlias, aField.TableSQLAlias) = 0))
          end
        else
          begin
            Result := ((CompareText(GroupByFields[liIndex].FieldName, aField.FieldName) = 0) and
                       (CompareText(GroupByFields[liIndex].TableSQLAlias, aField.TableSQLAlias) = 0))
          end;

        Inc(liIndex);
      end;


end; {function, FieldExistsInGroupBys}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetSearchCriteriaFromMaster }

procedure TdaMagicSQL.GetSearchCriteriaFromMaster(aSQL: TdaSQL);
var
  liIndex: Integer;
  lCriteria: TdaCriteria;
  lNewCriteria: TdaCriteria;
begin

  for liIndex := 0 to aSQL.CriteriaCount - 1 do
    begin
      lCriteria := aSQL.Criteria[liIndex];

      lNewCriteria := TdaCriteria.Create(Self);
      lNewCriteria.ChildType := lCriteria.ChildType;
      lNewCriteria.Parent := Self;
      lNewCriteria.Assign(lCriteria);

      if (lNewCriteria.Field <> nil) then
        lNewCriteria.Field.TableSQLAlias := TableAliasManager.GetNewAlias(aSQL.Name, lCriteria.Field.TableSQLAlias);
        
    end;

end; {function, GetSearchCriteriaFromMaster}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AssignCriteriaFieldsFrom }

procedure TdaMagicSQL.AssignCriteriaFieldsFrom(aSourceSQL: TdaSQL);
var
  liIndex: Integer;
  lCriteria: TdaCriteria;
  lNewCriteria: TdaCriteria;
  lCalcField: TdaCalculation;
begin

  for liIndex := 0 to aSourceSQL.CriteriaCount - 1 do
    begin
      lCriteria := aSourceSQL.Criteria[liIndex];

      lNewCriteria := TdaCriteria.Create(Self);
      lNewCriteria.ChildType := lCriteria.ChildType;
      lNewCriteria.Assign(lCriteria);

      if (lNewCriteria.Field <> nil) then
        begin
          lNewCriteria.Field.TableSQLAlias := TableAliasManager.GetNewAlias(aSourceSQL.Name, lCriteria.Field.TableSQLAlias);

          if (lNewCriteria.Field is TdaCalculation) then
            begin
              lCalcField := TdaCalculation(lNewCriteria.Field);

              if (lCalcField.CalcType = dacaExpression) then
                FixupCalcExpressionTableReferences(lCalcField, aSourceSQL);
            end;

        end;

      lNewCriteria.Parent := Self;
    end;

end;  {procedure, AssignCriteriaFieldsFrom}

{------------------------------------------------------------------------------}
{ TdaMagicSQL.AssignGroupCriteriaFieldsFrom }

procedure TdaMagicSQL.AssignGroupCriteriaFieldsFrom(aSourceSQL: TdaSQL);
var
  liIndex: Integer;
  lCriteria: TdaCriteria;
  lNewCriteria: TdaCriteria;
  lCalcField: TdaCalculation;
begin

  for liIndex := 0 to aSourceSQL.GroupCriteriaCount - 1 do
    begin
      lCriteria := aSourceSQL.GroupCriteria[liIndex];

      lNewCriteria := TdaCriteria.Create(Self);
      lNewCriteria.ChildType := lCriteria.ChildType;
      lNewCriteria.Assign(lCriteria);

      if (lNewCriteria.Field <> nil) then
        begin
          lNewCriteria.Field.TableSQLAlias := TableAliasManager.GetNewAlias(aSourceSQL.Name, lCriteria.Field.TableSQLAlias);

          if (lNewCriteria.Field is TdaCalculation) then
            begin
              lCalcField := TdaCalculation(lNewCriteria.Field);

              if (lCalcField.CalcType = dacaExpression) then
                FixupCalcExpressionTableReferences(lCalcField, aSourceSQL);
            end;

        end;

      lNewCriteria.Parent := Self;
    end;

end;



{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetReportParameters }

function TdaMagicSQL.GetReportParameters: TppParameterList;
begin
  Result := FRootSQL.ReportParameters;
end;

{------------------------------------------------------------------------------}
{ TdaMagicSQL.GetGroupSearchCriteria }

procedure TdaMagicSQL.GetGroupSearchCriteria(aSQL: TdaSQL; aChildsLinks: TList);
begin

  AssignGroupCriteriaFieldsFrom(aSQL)

end;

end.
