unit atSQLDirDatabase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atDatabase, DB, SDEngine;

type
  TatSQLDirDatabase = class(TatDatabase)
  private
    FDatabaseName: string;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    function OpenQuery( ASql: string ): TDataset; override;
    procedure LoadTableNameList( AList: TStrings ); override;
    procedure LoadFieldNameList( ATableName: string; AList: TStrings ); override;
    function ReadSqlProperty(ADataset: TDataset): string; override;
    procedure WriteSqlProperty(ADataset: TDataset; ASql: string); override;
  published
    property DatabaseName: string read FDatabaseName write FDatabaseName;
  end;

implementation

uses
  qsRes;

{ TatSQLDirDatabase }

procedure TatSQLDirDatabase.LoadTableNameList(AList: TStrings);
var
  c: integer;
begin
  if FDatabaseName <> '' then
  begin
    AList.BeginUpdate;
    try
      AList.Clear;
      SDEngine.Session.GetTableNames(FDatabaseName, '', false, AList);
      {Remove the Owner of table name}
      for c := 0 to AList.Count - 1 do
        if Pos('.', AList[c]) > 0 then
          AList[c] := Copy(AList[c], Pos('.', AList[c]) + 1, MaxInt);
    finally
      AList.EndUpdate;
    end;
  end;
  inherited;
end;

procedure TatSQLDirDatabase.LoadFieldNameList(ATableName: string; AList: TStrings);
var table: TSDTable;
    c: integer;
begin
  AList.BeginUpdate;
  try
    AList.Clear;
    if (FDatabaseName <> '') and (ATableName>'') then
    begin
      table := TSDTable.Create(nil);
      try
        table.DatabaseName := FDatabaseName;
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

function TatSQLDirDatabase.OpenQuery(ASql: string): TDataset;
begin
  result := TSDQuery.Create(Self);
  with TSDQuery(result) do
  try
    if DatabaseName = '' then
      DatabaseName := FDatabaseName;
    Sql.Text := ASql;
    Open;
  except
    result.Free;
    raise;
  end;
end;

constructor TatSQLDirDatabase.Create(AOwner: TComponent);
begin
  inherited;
end;

function TatSQLDirDatabase.ReadSqlProperty(ADataset: TDataset): string;
begin
  if ADataset is TSDQuery then
    result := (ADataset as TSDQuery).Sql.Text
  else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

procedure TatSQLDirDatabase.WriteSqlProperty(ADataset: TDataset; ASql: string);
begin
  if ADataset is TSDQuery then
  begin
    with (ADataset as TSDQuery) do
    begin
      if DatabaseName = '' then
        DatabaseName := FDatabaseName;
      Sql.Text := ASql;
    end;
  end
  else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

end.

