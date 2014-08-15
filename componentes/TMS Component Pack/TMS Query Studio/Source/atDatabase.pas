unit atDatabase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, TypInfo;

type
  /// Description:
  ///   Use this event to provide the names of tables which can be selected from. Fill the AList parameter with
  ///   the table names. Example:
  ///   <code>
  ///   AList.Add(‘Customer’);
  ///   AList.Add(‘Orders’);
  ///   </code>
  TatRetrieveTablenameListEvent = procedure (const AList: TStrings ) of object;

  /// Description:
  ///   Use this event to provide the names and types of fields which can be selected in the table specified by
  ///   ATableName parameter. Fill the AList parameter with the field names. The field type must be typecasted
  ///   to a TObject and inserted in the Objects property of the list. Example:
  ///   <code>
  ///   If UpperCase(ATableName) = ‘CUSTOMER’ then
  ///   begin
  ///     AList.AddObject(‘CustNo’, TObject(Ord(ftInteger)));
  ///     AList.AddObject(‘Company’, TObject(Ord(ftString)));
  ///     //And so on...
  ///   end;
  ///   </code>
  TatRetrieveFieldNameListEvent = procedure (const ATableName: string; const AList: TStrings ) of object;

  TatDatabase = class(TComponent)
  private
    FOnRetrieveFieldNameListEvent: TatRetrieveFieldNameListEvent;
    FOnRetrieveTablenameListEvent: TatRetrieveTablenameListEvent;
  public
    procedure RetrieveTables(ATables: TStrings);
    procedure RetrieveFields(ATableName: string; AFields: TStrings);
    function OpenQuery( ASql: string ): TDataset; virtual;
    procedure LoadTableNameList( AList: TStrings ); virtual;
    procedure LoadFieldNameList( ATableName: string; AList: TStrings ); virtual;
    function ReadSqlProperty(ADataset: TDataset): string; virtual;
    procedure WriteSqlProperty(ADataset: TDataset; ASql: string); virtual;
    procedure LoadLookupQuery( ASql: string; AList: TStrings );
  published
    /// LinkedTo:
    ///   atDatabase.TatRetrieveTablenameListEvent
    property OnRetrieveTablenameListEvent : TatRetrieveTablenameListEvent read FOnRetrieveTablenameListEvent write FOnRetrieveTablenameListEvent;

    /// LinkedTo:
    ///   atDatabase.TatRetrieveFieldNameListEvent
    property OnRetrieveFieldNameListEvent : TatRetrieveFieldNameListEvent read FOnRetrieveFieldNameListEvent write FOnRetrieveFieldNameListEvent;
  end;

procedure WriteSqlProperty( ADataset: TDataset; ADatabase: TComponent; ASql: string);
function ReadSqlProperty( ADataset: TDataset; ADatabase: TComponent ): string;

implementation

(*function ValidateProperty(AInstance:TComponent; APropName,AExpectedClass: string): PPropInfo;
var typeInfo:PTypeInfo;
begin
  typeInfo := AInstance.ClassInfo;
  result := GetPropInfo(typeInfo,APropName);
  if (result=nil) or not SameText(result^.PropType^^.Name,AExpectedClass) then
    raise Exception.CreateFmt('Property %s.%s is not of expected type (%s)',[AInstance.Name,APropName,AExpectedClass]);
end;*)

procedure WriteSqlProperty( ADataset: TDataset; ADatabase: TComponent; ASql: string);
begin
  if Assigned(ADatabase) and (ADatabase is TatDatabase) then
    TatDatabase(ADatabase).WriteSqlProperty( ADataset, ASql );

  { ajusta, de forma genérica, a SQL do dataset associado ao visual-query }
  { se a propriedade DatabaseName não estiver definida, também a define automaticamente }
//case FTargetDatasetEngine of
//  deBDE:
//    begin
//      if GetStrProp(FTargetDataset,'DatabaseName') = '' then
//         SetStrProp(FTargetDataset,'DatabaseName',FDatabaseName);
//      TStrings(GetOrdProp(FTargetDataset,ValidateProperty(FTargetDataset,'SQL','TStrings'))).Text := sql;
//    end;
//else
//  raise Exception.Create('Target dataset engine not supported yet');
//end;
end;

function ReadSqlProperty( ADataset: TDataset; ADatabase: TComponent ): string;
begin
  if Assigned(ADatabase) and (ADatabase is TatDatabase) then
    result := TatDatabase(ADatabase).ReadSqlProperty( ADataset )
  else
    result := '';

//  deBDE:
//    result := TStrings( GetOrdProp(
//      FTargetDataset,
//      ValidateProperty( FTargetDataset, 'SQL', 'TStrings' ) )).Text;
end;

{ TatDatabase }

procedure TatDatabase.LoadFieldNameList(ATableName: string; AList: TStrings);
begin
  if Assigned(FOnRetrieveFieldNameListEvent) then
    FOnRetrieveFieldNameListEvent(ATableName, AList);
end;

procedure TatDatabase.LoadLookupQuery(ASql: string; AList: TStrings);
var
  c: integer;
  Q: TDataset;
begin
  Q := OpenQuery(ASql);
  AList.BeginUpdate;
  try
    c := 0;
    while not Q.Eof do
    begin
      Inc(c);
      { se o primeiro campo é inteiro então usa-o como chave exclusiva
        senão usa um contador como chave exclusiva }
      if (Q.Fields[0].DataType in [ftInteger,ftAutoInc,ftFloat]) then
        AList.AddObject(Q.Fields[1].AsString, TObject(Q.Fields[0].AsInteger) )
      else
        AList.AddObject(Q.Fields[0].AsString, TObject(c) );
      Q.Next;
    end;
  finally
    Q.Free;
    AList.EndUpdate;
  end;
end;

procedure TatDatabase.LoadTableNameList(AList: TStrings);
begin
  if Assigned(FOnRetrieveTablenameListEvent) then
    FOnRetrieveTablenameListEvent(AList);
end;

function TatDatabase.OpenQuery(ASql: string): TDataset;
begin
  result := nil;
end;

procedure TatDatabase.WriteSqlProperty( ADataset: TDataset; ASql: string);
begin
end;

function TatDatabase.ReadSqlProperty( ADataset: TDataset ): string;
begin
  result := '';
end;

procedure TatDatabase.RetrieveFields(ATableName: string;
  AFields: TStrings);
begin
  LoadFieldNameList(ATableName, AFields);
end;

procedure TatDatabase.RetrieveTables(ATables: TStrings);
begin
  LoadTableNameList(ATables);
end;

end.
