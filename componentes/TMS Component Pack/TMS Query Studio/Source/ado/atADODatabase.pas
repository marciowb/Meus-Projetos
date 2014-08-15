unit atADODatabase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atDatabase, DB, ADODB;

type
  TatADODatabase = class(TatDatabase)
  private
    FConnection: TADOConnection;
    procedure SetConnection(const Value: TADOConnection);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    function OpenQuery( ASql: string ): TDataset; override;
    procedure LoadTableNameList( AList: TStrings ); override;
    procedure LoadFieldNameList( ATableName: string; AList: TStrings ); override;
    function ReadSqlProperty(ADataset: TDataset): string; override;
    procedure WriteSqlProperty(ADataset: TDataset; ASql: string); override;
  published
    property Connection: TADOConnection read FConnection write SetConnection;
  end;

implementation

uses
  qsRes;

{ TatADODatabase }

procedure TatADODatabase.LoadTableNameList(AList: TStrings);
begin
  if FConnection <> nil then
  begin
    AList.BeginUpdate;
    try
      AList.Clear;
      FConnection.GetTableNames(AList);
    finally
      AList.EndUpdate;
    end;
  end;
  inherited;
end;

procedure TatADODatabase.LoadFieldNameList(ATableName: string; AList: TStrings);
var table: TADOTable;
    c: integer;
begin
  AList.BeginUpdate;
  try
    AList.Clear;
    if (FConnection <> nil) and (ATableName>'') then
    begin
      table := TADOTable.Create(nil);
      try
        table.Connection := FConnection;
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

function TatADODatabase.OpenQuery(ASql: string): TDataset;
begin
  result := TADOQuery.Create(Self);
  with TADOQuery(result) do
  try
    Connection := FConnection;
    Sql.Text := ASql;
    Open;
  except
    result.Free;
    raise;
  end;
end;

constructor TatADODatabase.Create(AOwner: TComponent);
begin
  inherited;
end;

function TatADODatabase.ReadSqlProperty(ADataset: TDataset): string;
begin
  if ADataset is TADOQuery then
    result := (ADataset as TADOQuery).Sql.Text
  else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

procedure TatADODatabase.WriteSqlProperty(ADataset: TDataset; ASql: string);
begin
  if ADataset is TADOQuery then
  begin
    with (ADataset as TADOQuery) do
    begin
      if Connection = nil then
        Connection := FConnection;
      Sql.Text := ASql;
    end;
  end
  else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

procedure TatADODatabase.SetConnection(const Value: TADOConnection);
begin
  if FConnection <> Value then
  begin
    FConnection := Value;
    if FConnection <> nil then
      FConnection.FreeNotification(Value);
  end;
end;

procedure TatADODatabase.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = FConnection then
      FConnection := nil;
  end;
end;

end.

