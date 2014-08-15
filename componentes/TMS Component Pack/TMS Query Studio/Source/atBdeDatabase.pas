unit atBdeDatabase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atDatabase, DB, DBTables;

type
  TatBdeDatabase = class(TatDatabase)
  private
    { Private declarations }
    FDatabaseName : string;
    FSessionName : string;
    function CurrentSession: TSession;
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
    property DatabaseName: string read FDatabaseName write FDatabaseName;
    property SessionName: string read FSessionName write FSessionName;
  end;

implementation

uses
  qsRes;

{ TatBdeDatabase }

function TatBdeDatabase.CurrentSession: TSession;
begin
  result := Sessions.FindSession(SessionName);
end;

procedure TatBdeDatabase.LoadTableNameList(AList: TStrings);
begin
  if DatabaseName>'' then
  begin
    AList.BeginUpdate;
    try
      AList.Clear;
      CurrentSession.GetTableNames(DatabaseName,'',True,False,AList); // inclui extensão para permitir Paradox e DBase
    finally
      AList.EndUpdate;
    end;
  end;
  inherited;
end;

procedure TatBdeDatabase.LoadFieldNameList(ATableName: string; AList: TStrings);
var table: TTable;
    c: integer;
begin
  AList.BeginUpdate;
  try
    AList.Clear;
    if (DatabaseName>'') and (ATableName>'') then
    begin
      table:=TTable.Create(nil);
      try
        table.SessionName := SessionName;
        table.DatabaseName := DatabaseName;
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

function TatBdeDatabase.OpenQuery(ASql: string): TDataset;
begin
  result := TQuery.Create(Self);
  with TQuery(result) do
  try
    SessionName := FSessionName;
    DatabaseName := FDatabaseName;
    Sql.Text := ASql;
    Open;
  except
    result.Free;
    raise;
  end;
end;

constructor TatBdeDatabase.Create(AOwner: TComponent);
begin
  inherited;
  FSessionName := Session.SessionName;
end;

function TatBdeDatabase.ReadSqlProperty(ADataset: TDataset): string;
begin
  if ADataset is TQuery then
    result := (ADataset as TQuery).Sql.Text
  else
    raise Exception.Create(_str(STargetDatasetNotSupported)); 
end;

procedure TatBdeDatabase.WriteSqlProperty(ADataset: TDataset; ASql: string);
begin
  if ADataset is TQuery then
  begin
    with (ADataset as TQuery) do
    begin
      { também ajusta o DatabaseName e SessionName se estiverem em branco }
      if not Active then
      begin
        if DatabaseName = '' then
          DatabaseName := FDatabaseName;
        if (FSessionName <> '') and (SessionName = '') then
          SessionName := FSessionName;
      end;
      Sql.Text := ASql;
    end;
  end
  else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

end.

