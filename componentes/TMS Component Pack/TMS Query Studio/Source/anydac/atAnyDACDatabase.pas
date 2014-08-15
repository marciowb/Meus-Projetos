unit atAnyDACDatabase;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atDatabase, DB, SQLExpr,
  {$IFDEF DELPHI7_LVL}SimpleDS,{$ENDIF}
  uADCompClient;

type
  TatAnyDACDatabase = class(TatDatabase)
  private
    FConnection: TADConnection;
    FSchemaName: string;
    FCatalogName: string;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetConnection(const Value: TADConnection);
  public
    constructor Create(AOwner: TComponent); override;
    function OpenQuery(ASQL: string): TDataset; override;
    procedure LoadTableNameList(AList: TStrings); override;
    procedure LoadFieldNameList(ATableName: string; AList: TStrings); override;
    function ReadSqlProperty(ADataset: TDataset): string; override;
    procedure WriteSqlProperty(ADataset: TDataset; ASQL: string); override;
  published
    property Connection: TADConnection read FConnection write SetConnection;
    property CatalogName: string read FCatalogName write FCatalogName;
    property SchemaName: string read FSchemaName write FSchemaName;
  end;

implementation

uses
  qsRes;

{ TatAnyDACDatabase }

procedure TatAnyDACDatabase.LoadTableNameList(AList: TStrings);
begin
  if FConnection <> nil then
  begin
    AList.BeginUpdate;
    try
      AList.Clear;
      FConnection.GetTableNames(FCatalogName, FSchemaName, '*', AList);
    finally
      AList.EndUpdate;
    end;
  end;
  inherited;
end;

procedure TatAnyDACDatabase.LoadFieldNameList(ATableName: string; AList: TStrings);
var
  table: TADTable;
  c: integer;
begin
  AList.BeginUpdate;
  try
    AList.Clear;
    if (FConnection <> nil) and (ATableName > '') then
    begin
      table := TADTable.Create(nil);
      try
        table.Connection := FConnection;
        table.TableName := ATableName;
        table.FieldDefs.Update;
        for c:=0 to table.FieldDefs.Count-1 do
          AList.AddObject(
            table.FieldDefs[c].Name,                    // FieldName
            TObject(Ord(table.FieldDefs[c].DataType))); // DataType
      finally
        table.Free;
      end;
    end;
  finally
    AList.EndUpdate;
  end;
  inherited;
end;

function TatAnyDACDatabase.OpenQuery(ASQL: string): TDataset;
begin
  result := TADQuery.Create(Self);
  with TADQuery(result) do
  try
    Connection := FConnection;
    SQL.Text := ASQL;
    Open;
  except
    result.Free;
    raise;
  end;
end;

constructor TatAnyDACDatabase.Create(AOwner: TComponent);
begin
  inherited;
end;

function TatAnyDACDatabase.ReadSqlProperty(ADataset: TDataset): string;
begin
  if ADataset is TADQuery then
    result := (ADataset as TADQuery).SQL.Text
  else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

procedure TatAnyDACDatabase.WriteSqlProperty(ADataset: TDataset; ASQL: string);
begin
  if ADataset is TADQuery then
  begin
    with (ADataset as TADQuery) do
    begin
      if Connection = nil then
        Connection := FConnection;
      SQL.Text := ASQL;
    end;
  end
  else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

procedure TatAnyDACDatabase.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = FConnection then
      FConnection := nil;
  end;
end;

procedure TatAnyDACDatabase.SetConnection(const Value: TADConnection);
begin
  if FConnection <> Value then
  begin
    FConnection := Value;
    if FConnection <> nil then
      FConnection.FreeNotification(Value);
  end;
end;

end.

