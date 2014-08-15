unit UXlsTDOADataset;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}

interface
{$IFDEF FLEXCELDOA}
uses SysUtils, UXlsDB, Oracle, UFlxMessages;
type
  TXlsTDOADataset=class(TInterfacedObject , IXlsDataSet)
  private
    FDataSet: TOracleQuery;
    FUseDisplayNames: boolean;
    FUseHiddenFields: boolean;
    RecordCountQuery: TOracleQuery;
    CacheFields: array of IXLSField;

    DestroyRecordCount: boolean;
    function GenerateRecordCount(const SQL: string): string;
  public
    constructor Create(const aDataSet: TOracleQuery; const aUseDisplayNames, aUseHiddenFields: boolean; const aRecordCountQuery: TOracleQuery);
    destructor Destroy; override;

    function GetFields(index: integer): IXlsField;
    function GetActive: boolean;

    procedure Open;
    procedure Close;
    property Active: boolean read GetActive;

    procedure First;
    procedure Next;
    procedure Last;
    function Eof: boolean;




    function DsName: string;

    function RecordCount: integer;

    function FieldByName(const Name: string): IXlsField;
    function FieldCount: integer;
    function FieldVisibleCount: integer;
  end;

  TXlsTDOAField = class (TInterfacedObject, IXlsField)
  private
    FFieldIndex: integer;
    FRealDataSet: TOracleQuery;
  public
    constructor Create(const aField: integer; const aRealDataSet: TOracleQuery);
    function Value: variant;
    function IsTDateTimeField: boolean;
    function IsTMemoField: boolean;
    function AsFloat: extended;

    function Visible: boolean;

    function DisplayName: string;
  end;
{$ENDIF}
implementation

uses Classes;
{$IFDEF FLEXCELDOA}

{ TXlsTDOADataset }

procedure TXlsTDOADataset.Close;
begin
  FDataSet.Close;
end;

function TXlsTDOADataset.GenerateRecordCount(const SQL: string): string;
begin
  Result:=copy(SQL,1,pos('SELECT', UpperCase(SQL))+Length('SELECT'))+
          ' count(*) ' + copy(SQL, pos(' FROM ', UpperCase(SQL)), Length(SQL));
end;

constructor TXlsTDOADataset.Create(const aDataSet: TOracleQuery; const aUseDisplayNames, aUseHiddenFields: boolean; const aRecordCountQuery: TOracleQuery);
begin
  inherited Create;
  if aDataSet=nil then Raise Exception.CreateFmt(ErrNoDataSet,['']);
  FDataSet:=aDataSet;
  FUseDisplayNames:=aUseDisplayNames;
  FUseHiddenFields:=aUseHiddenFields;
  DestroyRecordCount:= aRecordCountQuery=nil;
  if DestroyRecordCount then
  begin
    RecordCountQuery:=TOracleQuery.Create(nil);
    RecordCountQuery.Session:=aDataSet.Session;
    RecordCountQuery.SQL.Text:=GenerateRecordCount(aDataSet.SQL.Text);
  end
  else RecordCountQuery:=aRecordCountQuery;
end;

destructor TXlsTDOADataset.Destroy;
begin
  if DestroyRecordCount then FreeAndNil(RecordCountQuery);
  inherited;
end;

function TXlsTDOADataset.DsName: string;
begin
  Result:=FDataSet.Name;
end;

function TXlsTDOADataset.Eof: boolean;
begin
  Result:=FDataSet.Eof;
end;

function TXlsTDOADataset.FieldByName(const Name: string): IXlsField;
begin
  Result:= GetFields(FDataSet.FieldIndex(Name))
end;

function TXlsTDOADataset.FieldCount: integer;
begin
  Result:= FDataSet.FieldCount;
end;

function TXlsTDOADataset.FieldVisibleCount: integer;
begin
  Result:= FDataSet.FieldCount;
end;

procedure TXlsTDOADataset.First;
begin
  if FDataSet.RowCount<>1 then FDataSet.Execute;
end;

function TXlsTDOADataset.GetActive: boolean;
begin
  Result:=FDataSet.RowCount>0;
end;

function TXlsTDOADataset.GetFields(index: integer): IXlsField;
begin
  if Length(CacheFields)=0 then SetLength(CacheFields, FieldCount);
  if CacheFields[index]=nil then
  begin
    Result:=TXlsTDOAField.Create(index, FDataSet);
    CacheFields[index]:=Result;
  end else Result:=CacheFields[index];
end;

procedure TXlsTDOADataset.Last;
begin
  while not FDataSet.Eof do FDataSet.Next;
end;

procedure TXlsTDOADataset.Next;
begin
  FDataSet.Next;
end;

procedure TXlsTDOADataset.Open;
begin
  FDataSet.Execute;
end;

function TXlsTDOADataset.RecordCount: integer;
begin
  RecordCountQuery.Execute;
  Result:=RecordCountQuery.FieldAsInteger(0);
end;

{ TXlsTField }

function TXlsTDOAField.AsFloat: extended;
begin
  Result:=FRealDataSet.FieldAsFloat(FFieldIndex);
end;

constructor TXlsTDOAField.Create(const aField: integer; const aRealDataSet: TOracleQuery);
begin
  if (aField<0)or(aField>=aRealDataSet.FieldCount) then raise Exception.Create(ErrFieldNil);
  FFieldIndex:=aField;
  FRealDataSet:=aRealDataSet;
end;

function TXlsTDOAField.DisplayName: string;
begin
  Result:=FRealDataSet.FieldName(FFieldIndex);
end;

function TXlsTDOAField.IsTDateTimeField: boolean;
begin
  Result:=
  {$IFDEF FLX_NOVARDATEFROMSTRING}
          (FRealDataSet.FieldType(FFieldIndex)=otTimestamp)or
          (FRealDataSet.FieldType(FFieldIndex)=otTimestampTZ)or
          (FRealDataSet.FieldType(FFieldIndex)=otTimestampLTZ)or
  {$ENDIF}
          (FRealDataSet.FieldType(FFieldIndex)=otDate);
end;

function TXlsTDOAField.IsTMemoField: boolean;
begin
  Result:=FRealDataSet.FieldType(FFieldIndex)=otLong;
end;

function TXlsTDOAField.Value: variant;
begin
  Result:=FRealDataSet.Field(FFieldIndex);
end;

function TXlsTDOAField.Visible: boolean;
begin
  Result:=true;
end;
{$ENDIF}

end.
