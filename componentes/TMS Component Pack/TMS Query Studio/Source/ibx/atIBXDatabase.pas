unit atIBXDatabase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atDatabase, DB, IBDatabase, IBTable, IBQuery;

type
  TatIBXDatabase = class(TatDatabase)
  private
    FDatabase: TIBDatabase;
    FTransaction: TIBTransaction;
    FUseViews: boolean;
    procedure SetDatabase(const Value: TIBDatabase);
    procedure SetTransaction(const Value: TIBTransaction);
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
    procedure GetViewNames(AList: TStrings);
  published
    property Database: TIBDatabase read FDatabase write SetDatabase;
    property Transaction: TIBTransaction read FTransaction write SetTransaction;
    property UseViews: boolean read FUseViews write FUseViews;
  end;

implementation

uses
  qsRes;

{ TatIBXDatabase }

procedure TatIBXDatabase.LoadTableNameList(AList: TStrings);
var
  AViewList: TStrings;
begin
  if FDatabase <> nil then
  begin
    AList.BeginUpdate;
    try
      AList.Clear;
      FDatabase.GetTableNames(AList);
      if FUseViews then
      begin
        AViewList := TStringList.Create;
        try
          GetViewNames(AViewList);
          AList.AddStrings(AViewList);
        finally
          AViewList.Free;
        end;
      end;
    finally
      AList.EndUpdate;
    end;
  end;
  inherited;
end;

procedure TatIBXDatabase.LoadFieldNameList(ATableName: string; AList: TStrings);
var table: TIBTable;
    c: integer;
begin
  AList.BeginUpdate;
  try
    AList.Clear;
    if (FDatabase <> nil) and (FTransaction <> nil) and (ATableName>'') then
    begin
      table := TIBTable.Create(nil);
      try
        table.Database := FDatabase;
        table.Transaction := FTransaction;
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

procedure TatIBXDatabase.GetViewNames(AList: TStrings);
begin
  AList.Clear;
  With OpenQuery('Select RDB$RELATION_NAME from RDB$RELATIONS '+
    'where RDB$VIEW_BLR is not NULL order by RDB$RELATION_NAME') do
  try
    First;
    while not EOF do
    begin
      AList.Add(Fields[0].AsString);
      Next;
    end;
  finally
  end;
end;

function TatIBXDatabase.OpenQuery(ASql: string): TDataset;
begin
  result := TIBQuery.Create(Self);
  with TIBQuery(result) do
  try
    if Database = nil then
      Database := FDatabase;
    if Transaction = nil then
      Transaction := FTransaction;
    Sql.Text := ASql;
    Open;
  except
    result.Free;
    raise;
  end;
end;

constructor TatIBXDatabase.Create(AOwner: TComponent);
begin
  inherited;
end;

function TatIBXDatabase.ReadSqlProperty(ADataset: TDataset): string;
begin
  if ADataset is TIBQuery then
    result := (ADataset as TIBQuery).Sql.Text
  else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

procedure TatIBXDatabase.WriteSqlProperty(ADataset: TDataset; ASql: string);
begin
  if ADataset is TIBQuery then
  begin
    with (ADataset as TIBQuery) do
    begin
      if Transaction = nil then
        Transaction := FTransaction;
      if Database = nil then
        Database := FDatabase;
      Sql.Text := ASql;
    end;
  end
  else
    raise Exception.Create(_str(STargetDatasetNotSupported));
end;

procedure TatIBXDatabase.SetDatabase(const Value: TIBDatabase);
begin
  if FDatabase <> Value then
  begin
    FDatabase := Value;
    if (FDatabase <> nil) and (FDatabase.DefaultTransaction <> nil) then
      Transaction := FDatabase.DefaultTransaction;
    if FDatabase <> nil then
      FDatabase.FreeNotification(Value);
  end;
end;

procedure TatIBXDatabase.SetTransaction(const Value: TIBTransaction);
begin
  if FTransaction <> Value then
  begin
    FTransaction := Value;
    if (FTransaction <> nil) and (FTransaction.DefaultDatabase <> nil) then
      Database := FTransaction.DefaultDatabase;
    if FTransaction <> nil then
      FTransaction.FreeNotification(Value);
  end;
end;

procedure TatIBXDatabase.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = FDatabase then
      FDatabase := nil;
    if AComponent = FTransaction then
      FTransaction := nil;
  end;
end;

end.

