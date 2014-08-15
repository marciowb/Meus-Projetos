unit EGeneralData;

{$I Exceptions.inc}

interface

uses
  Classes, SysUtils, IniFiles, cxCustomData {$IFDEF Delphi6Up}, Variants{$ENDIF},
  cxGridCustomTableView;

type
  TGeneralDataSet = class;
  TGeneralDataRecord = packed record
    FieldsValue: array [0..15] of Variant;
    Master, Details: TGeneralDataSet;
  end;
  PGeneralDataRecord = ^TGeneralDataRecord;

  TGeneralDataSet = class(TList)
  private
    function GetItem(Index: Integer): PGeneralDataRecord;
  protected
  public
    function AddRow(FieldsValue: array of variant): PGeneralDataRecord;
    procedure Delete(Index: Integer);
    procedure Clear;
{$IFDEF Delphi4Up} override;
{$ENDIF}
    property Items[Index: Integer]: PGeneralDataRecord read GetItem; default;
  end;

  TUserDataSource = class(TcxCustomDataSource)
  private
    FGeneralDataSet: TGeneralDataSet;
  protected
    function GetRecordCount: Integer; override;
    function GetValue(ARecordHandle: TcxDataRecordHandle;
      AItemHandle: TcxDataItemHandle): Variant; override;
    procedure SetValue(ARecordHandle: TcxDataRecordHandle;
      AItemHandle: TcxDataItemHandle; const AValue: Variant); override;
  public
    constructor Create(AGeneralDataSet: TGeneralDataSet);
  end;

implementation

{ TUserDataSource }

constructor TUserDataSource.Create(AGeneralDataSet: TGeneralDataSet);
begin
  inherited Create;
  FGeneralDataSet := AGeneralDataSet;
end;

function TUserDataSource.GetRecordCount: Integer;
begin
  Result := FGeneralDataSet.Count;
end;

function TUserDataSource.GetValue(ARecordHandle: TcxDataRecordHandle;
  AItemHandle: TcxDataItemHandle): Variant;
var
  Row, Col: Integer;
begin
  Row := Integer(ARecordHandle);
  Col := GetDefaultItemID(Integer(AItemHandle));
  Result := FGeneralDataSet[Row]^.FieldsValue[Col];
end;

procedure TUserDataSource.SetValue(ARecordHandle: TcxDataRecordHandle;
  AItemHandle: TcxDataItemHandle; const AValue: Variant);
var
  Row, Col: Integer;
begin
  Row := Integer(ARecordHandle);
  Col := GetDefaultItemID(Integer(AItemHandle));
  FGeneralDataSet[Row]^.FieldsValue[Col] := AValue;
end;

{ TGeneralDataSet }

function TGeneralDataSet.AddRow(FieldsValue: array of variant): PGeneralDataRecord;
var
  n: Integer;
begin
  New(Result);
  for n := low(FieldsValue) to high(FieldsValue) do
    Result.FieldsValue[n] := FieldsValue[n];
  Result.Master := Self;
  Result.Details := TGeneralDataSet.Create;
  Add(Result);
end;

procedure TGeneralDataSet.Clear;
var
  i: integer;
begin
  for i := 0 to (Count - 1) do Delete(0);
  inherited;
end;

procedure TGeneralDataSet.Delete(Index: Integer);
var
  PRecord: PGeneralDataRecord;
  Ptr: Pointer;
begin
  Ptr := Items[Index];
  PRecord := PGeneralDataRecord(Ptr);
  PRecord^.Details.Free;
  Finalize(PRecord^.FieldsValue); // Free Variants allocated memory...
  Dispose(Ptr);
  inherited;
end;

function TGeneralDataSet.GetItem(Index: Integer): PGeneralDataRecord;
begin
  if (Index >=0 ) and (Index < Count) then
    Result := PGeneralDataRecord(TList(Self).Items[Index])
  else
    Result := nil;
end;

end.

