unit atIBODatabase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atDatabase, DB, IB_Components, IBODataset, IB_Schema;

type
  TatIBODatabase = class(TatDatabase)
  private
    FConnection: TIB_Connection;
    procedure SetConnection(Value: TIB_Connection);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    function OpenQuery( ASql: string ): TDataset; override;
    procedure LoadTableNameList( AList: TStrings ); override;
    procedure LoadFieldNameList( ATableName: string; AList: TStrings ); override;
    function ReadSqlProperty(ADataset: TDataset): string; override;
    procedure WriteSqlProperty(ADataset: TDataset; ASql: string); override;
  published
    property IB_Connection: TIB_Connection read FConnection write SetConnection;
  end;

implementation

uses
  qsRes;

{ TatIBODatabase }

procedure TatIBODatabase.LoadTableNameList(AList: TStrings);
begin
  if FConnection <> nil then
  begin
    AList.BeginUpdate;
    try
      AList.Clear;
      SchemaRelationNames(FConnection, nil, false, true, false, AList);
    finally
      AList.EndUpdate;
    end;
  end;
  inherited;
end;

procedure TatIBODatabase.LoadFieldNameList(ATableName: string; AList: TStrings);
var table: TIBOTable;
    c: integer;
begin
  AList.BeginUpdate;
  try
    AList.Clear;
    if (FConnection <> nil) and (ATableName>'') then
    begin
      table := TIBOTable.Create(nil);
      try
        table.IB_Connection := FConnection;
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

function TatIBODatabase.OpenQuery(ASql: string): TDataset;
begin
  result := TIBOQuery.Create(Self);
  with TIBOQuery(result) do
  try
    IB_Connection := FConnection;
    Sql.Text := ASql;
    Open;
  except
    result.Free;
    raise;
  end;
end;

procedure TatIBODatabase.SetConnection(Value: TIB_Connection);
begin
  if Value <> FConnection then
  begin
    FConnection := Value;
    if FConnection <> nil then
      FConnection.FreeNotification(Self);
  end;
end;

procedure TatIBODatabase.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (FConnection = AComponent) then
    FConnection := nil;
end;

constructor TatIBODatabase.Create(AOwner: TComponent);
begin
  inherited;
end;

function TatIBODatabase.ReadSqlProperty(ADataset: TDataset): string;
begin
  if ADataset is TIBOQuery then
    result := (ADataset as TIBOQuery).Sql.Text
  else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

procedure TatIBODatabase.WriteSqlProperty(ADataset: TDataset; ASql: string);
begin
  if ADataset is TIBOQuery then
  begin
    with (ADataset as TIBOQuery) do
    begin
      if IB_Connection = nil then
        IB_Connection := FConnection;
      Sql.Text := ASql;
    end;
  end else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

end.

