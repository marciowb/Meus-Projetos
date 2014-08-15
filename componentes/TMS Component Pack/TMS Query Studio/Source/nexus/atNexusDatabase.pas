unit atNexusDatabase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atDatabase, DB, nxDB, nxsdDataDictionary;

type
  TatNexusDatabase = class(TatDatabase)
  private
    FNexusDatabase: TnxDatabase;
    procedure SetNexusDatabase(const Value: TnxDatabase);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function OpenQuery( ASql: string ): TDataset; override;
    procedure LoadTableNameList( AList: TStrings ); override;
    procedure LoadFieldNameList( ATableName: string; AList: TStrings ); override;
    function ReadSqlProperty(ADataset: TDataset): string; override;
    procedure WriteSqlProperty(ADataset: TDataset; ASql: string); override;
  published
    { Published declarations }
    property NexusDatabase: TnxDatabase read FNexusDatabase write SetNexusDatabase;
  end;

implementation

uses
  qsRes;

{ TatNexusDatabase }

procedure TatNexusDatabase.LoadTableNameList(AList: TStrings);
begin
  AList.BeginUpdate;
  try
    AList.Clear;
    if assigned(FNexusDatabase) then
       FNexusDatabase.GetTableNames(AList);
  finally
    AList.EndUpdate;
  end;
  inherited;
end;

procedure TatNexusDatabase.LoadFieldNameList(ATableName: string; AList: TStrings);
var c: integer;
   table : TNxTable;
begin
  AList.BeginUpdate;
  try
    AList.Clear;
    if (assigned(FNexusDatabase)) and (ATableName>'') then
    begin
      table:=TnxTable.Create(nil);
      try
        table.Database := FNexusDatabase;
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

function TatNexusDatabase.OpenQuery(ASql: string): TDataset;
begin
  result := TnxQuery.Create(Self);
  with TnxQuery(result) do
  try
    Database := FNexusDatabase;
    Sql.Text := ASql;
    Open;
  except
    result.Free;
    raise;
  end;
end;

constructor TatNexusDatabase.Create(AOwner: TComponent);
begin
  inherited;
end;

function TatNexusDatabase.ReadSqlProperty(ADataset: TDataset): string;
begin
  if ADataset is TnxQuery then
    result := (ADataset as TnxQuery).Sql.Text
  else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

procedure TatNexusDatabase.WriteSqlProperty(ADataset: TDataset; ASql: string);
begin
  if ADataset is TnxQuery then
  begin
    with (ADataset as TnxQuery) do
    begin
      { também ajusta o Database se estiver em branco }
      if not Active then
      begin
        if Database = nil then
          Database := FNexusDatabase;
      end;
      Sql.Text := ASql;
    end;
  end else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

procedure TatNexusDatabase.SetNexusDatabase(const Value: TnxDatabase);
begin
  FNexusDatabase := Value;
end;

end.

