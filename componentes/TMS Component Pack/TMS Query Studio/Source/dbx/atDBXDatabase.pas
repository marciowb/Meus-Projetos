unit atDBXDatabase;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atDatabase, DB, SQLExpr,
  {$IFDEF DELPHI7_LVL}SimpleDS,{$ENDIF}
  Provider, DBClient;

type
  TatDBXDatabase = class(TatDatabase)
  private
    FSQLConnection : TSQLConnection;
    FSchemaName: string;
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetSQLConnection(const Value: TSQLConnection);
  public
    constructor Create(AOwner: TComponent); override;
    function OpenQuery( ASql: string ): TDataset; override;
    procedure LoadTableNameList( AList: TStrings ); override;
    procedure LoadFieldNameList( ATableName: string; AList: TStrings ); override;
    function ReadSqlProperty(ADataset: TDataset): string; override;
    procedure WriteSqlProperty(ADataset: TDataset; ASql: string); override;
  published
    property SQLConnection: TSQLConnection read FSQLConnection write SetSQLConnection;
    property SchemaName: string read FSchemaName write FSchemaName;
  end;

implementation

uses
  qsRes;

{ TatDBXDatabase }

procedure TatDBXDatabase.LoadTableNameList(AList: TStrings);
begin
  if FSQLConnection <> nil then
  begin
    AList.BeginUpdate;
    try
      AList.Clear;
      FSQLConnection.GetTableNames(AList, FSchemaName);
    finally
      AList.EndUpdate;
    end;
  end;
  inherited;
end;

procedure TatDBXDatabase.LoadFieldNameList(ATableName: string; AList: TStrings);
var
  table: TSQLTable;
  c: integer;
begin
  AList.BeginUpdate;
  try
    AList.Clear;
    if (FSQLConnection <> nil) and (ATableName>'') then
    begin
      table := TSQLTable.Create(nil);
      try
        table.SQLConnection := FSQLConnection;
        table.TableName := ATableName;
        table.FieldDefs.Update;
        for c:=0 to table.FieldDefs.Count-1 do
          AList.AddObject(
            table.FieldDefs[c].Name,                     // FieldName
            TObject(Ord(table.FieldDefs[c].DataType)) ); // DataType
      finally
        table.Free;
      end;
    end;
  finally
    AList.EndUpdate;
  end;
  inherited;
end;

function TatDBXDatabase.OpenQuery(ASql: string): TDataset;
const
  SProvName = '___QSInternalProvider___';
var
  Prov: TProvider;
  Qry: TSQLQuery;
begin
  Qry := TSQLQuery.Create(Self);
  Prov := TProvider.Create(Self);
  try
    result := TClientDataset.Create(Self);
    try
      Qry.SQLConnection := FSQLConnection;
      Qry.SQL.Text := ASQL;
      Qry.Open;
      Prov.DataSet := Qry;
      Prov.Name := SProvName;
      with TClientDataset(result) do
      begin
        ProviderName := SProvName;
        Open;
      end;
    except
      result.Free;
      raise;
    end;
  finally
    Qry.Free;
    Prov.Free;
  end;
end;

constructor TatDBXDatabase.Create(AOwner: TComponent);
begin
  inherited;
end;

function TatDBXDatabase.ReadSqlProperty(ADataset: TDataset): string;
var
  AProvComp: TProvider;
begin
  if ADataset is TSQLQuery then
    result := (ADataset as TSQLQuery).Sql.Text
  else
  {$IFDEF DELPHI7_LVL}
  if ADataset is TSimpleDataset then
    result := (ADataset as TSimpleDataset).Dataset.CommandText
  else
  {$ENDIF}
  if ADataset is TClientDataset then
    With TClientDataset(ADataset) do
    begin
      result := CommandText;
      if Owner.FindComponent(ProviderName) is TProvider then
        AProvComp := TProvider(Owner.FindComponent(ProviderName))
      else
        AProvComp := nil;
      if (AProvComp <> nil) and ((result = '') or not (poAllowCommandText in AProvComp.Options)) then
        if (AProvComp.Dataset <> nil) and (AProvComp.Dataset is TSQLQuery) then
          result := (AProvComp.Dataset as TSQLQuery).SQL.Text;
    end
  else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

procedure TatDBXDatabase.WriteSqlProperty(ADataset: TDataset; ASql: string);
var
  AProvComp: TProvider;
begin
  if ADataset is TSQLQuery then
    With TSQLQuery(ADataset) do
    begin
      if SQLConnection = nil then
        SQLConnection := FSQLConnection;
      SQL.Text := ASQL;
    end
  else
  {$IFDEF DELPHI7_LVL}
  if ADataset is TSimpleDataset then
    With TSimpleDataset(ADataset) do
    begin
      Connection := FSQLConnection;
      Dataset.CommandText := ASQL;
      Dataset.CommandType := ctQuery;
    end
  else
  {$ENDIF}
  if ADataset is TClientDataset then
    With TClientDataset(ADataset) do
    begin
      if Owner.FindComponent(ProviderName) is TProvider then
        AProvComp := TProvider(Owner.FindComponent(ProviderName))
      else
        AProvComp := nil;
      if (AProvComp <> nil) and not (poAllowCommandText in AProvComp.Options) then
      begin
        if (AProvComp.Dataset <> nil) and (AProvComp.Dataset is TSQLQuery) then
          (AProvComp.Dataset as TSQLQuery).SQL.Text := ASQL;
      end else
        CommandText := ASQL;
    end
  else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

procedure TatDBXDatabase.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = FSQLConnection then
      FSQLConnection := nil;
  end;
end;

procedure TatDBXDatabase.SetSQLConnection(const Value: TSQLConnection);
begin
  if FSQLConnection <> Value then
  begin
    FSQLConnection := Value;
    if FSQLConnection <> nil then
      FSQLConnection.FreeNotification(Value);
  end;
end;

end.

