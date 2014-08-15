unit UXlsTDataSet;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}

interface
uses SysUtils, UXlsDB, DB, UFlxMessages;
type
  TRecordCountProc= function (const DB: TDataSet): integer of object;

  TXlsTDataSet=class(TInterfacedObject , IXlsDataSet)
  private
    FDataSet: TDataSet;
    FRecordCount: TRecordCountProc;
    FUseDisplayNames: boolean;
    FUseHiddenFields: boolean;
    CacheFields: array of IXlsField;
  public
    constructor Create(const aDataSet: TDataSet; const aRecordCount: TRecordCountProc; const aUseDisplayNames: boolean; const aUseHiddenFields: boolean);

    function GetFields(index: integer): IXlsField;
    function GetActive: boolean;

    procedure Open;
    procedure Close;
    property Active: boolean read GetActive;

    function RecordCount: integer;
    procedure First;
    procedure Next;
    procedure Last;
    function Eof: boolean;

    function DsName: string;

    function FieldByName(const Name: string): IXlsField;
    function FieldCount: integer;
    function FieldVisibleCount: integer;
  end;

  TXlsTField = class (TInterfacedObject, IXlsField)
  private
    FFieldIndex: integer;
    FRealDataSet: TDataSet;
  public
    constructor Create(const aField: TField);
    function Value: variant;
    function IsTDateTimeField: boolean;
    function IsTMemoField: boolean;
    function AsFloat: extended;

    function Visible: boolean;

    function DisplayName: string;
  end;

implementation

{ TXlsTDataSet }

procedure TXlsTDataSet.Close;
begin
  FDataSet.Close;
end;

constructor TXlsTDataSet.Create(const aDataSet: TDataSet; const aRecordCount: TRecordCountProc; const aUseDisplayNames, aUseHiddenFields: boolean);
begin
  inherited Create;
  if aDataSet=nil then Raise Exception.CreateFmt(ErrNoDataSet,['']);
  FDataSet:=aDataSet;
  FRecordCount:=aRecordCount;
  FUseDisplayNames:=aUseDisplayNames;
  FUseHiddenFields:=aUseHiddenFields;
end;

function TXlsTDataSet.DsName: string;
begin
  Result:=FDataSet.Name;
end;

function TXlsTDataSet.Eof: boolean;
begin
  Result:=FDataSet.Eof;
end;

function TXlsTDataSet.FieldByName(const Name: string): IXlsField;
var
  i, index: integer;
begin
  index:=-1;
  if FUseDisplayNames then
  begin
    for i:=0 to FDataSet.FieldCount-1 do
      if UpperCase(FDataSet.Fields[i].DisplayName)=UpperCase(Name) then
      begin
        index:=i;
        break;
      end;
  end else
    Index:= FDataSet.FieldByName(Name).Index;

  if (Index<0) or (not FUseHiddenFields and not FDataSet.Fields[Index].Visible) then raise Exception.CreateFmt(ErrFieldNotFound,[Name]);

  Result:=GetFields(Index);
end;

function TXlsTDataSet.FieldCount: integer;
begin
  Result:= FDataSet.FieldCount;
end;

function TXlsTDataSet.FieldVisibleCount: integer;
var
  i: integer;
begin
  if not FUseHiddenFields then
  begin
    Result:=0;
    for i:=0 to FDataSet.FieldCount-1 do
      if FDataSet.Fields[i].Visible then inc(Result);

    exit;
  end;
  Result:= FDataSet.FieldCount;
end;

procedure TXlsTDataSet.First;
begin
  FDataSet.First;
end;

function TXlsTDataSet.GetActive: boolean;
begin
  Result:=FDataSet.Active;
end;

function TXlsTDataSet.GetFields(index: integer): IXlsField;
begin
  if Length(CacheFields)=0 then SetLength(CacheFields, FieldCount);
  if CacheFields[index]=nil then
  begin
    Result:=TXlsTField.Create(FDataSet.Fields[Index]);
    CacheFields[index]:=Result;
  end else Result:=CacheFields[index];
end;

procedure TXlsTDataSet.Last;
begin
  FDataSet.Last;
end;

procedure TXlsTDataSet.Next;
begin
  FDataSet.Next;
end;

procedure TXlsTDataSet.Open;
begin
  FDataSet.Open;
end;

function TXlsTDataSet.RecordCount: integer;
begin
  Result:=FRecordCount(FDataSet);
end;

{ TXlsTField }

function TXlsTField.AsFloat: extended;
begin
  Result:=FRealDataSet.Fields[FFieldIndex].AsFloat;
end;

constructor TXlsTField.Create(const aField: TField);
begin
  inherited Create;
  if aField=nil then raise Exception.Create(ErrFieldNil);
  FFieldIndex:=aField.Index;
  FRealDataSet:=aField.DataSet;
end;

function TXlsTField.DisplayName: string;
begin
  Result:=FRealDataSet.Fields[FFieldIndex].DisplayName;
end;

function TXlsTField.IsTDateTimeField: boolean;
begin
  Result:=FRealDataSet.Fields[FFieldIndex] is TDateTimeField;
end;

function TXlsTField.IsTMemoField: boolean;
begin
  Result:=FRealDataSet.Fields[FFieldIndex] is TMemoField;
end;

function TXlsTField.Value: variant;
var
  f: TField;
  {$IFNDEF DELPHI2008UP}
  s: ansistring;
  b: array of byte;
  {$ENDIF}
begin
  f:=FRealDataSet.Fields[FFieldIndex];
  {$IFNDEF DELPHI2008UP}
  if f is TGraphicField then
  begin
    s := f.AsString;
    SetLength(b, Length(s));
    if Length(b) > 0 then System.Move(s[1], b[0], Length(b));
    Result := b;
    exit;
  end;
  {$ENDIF}

  Result := f.Value;
end;

function TXlsTField.Visible: boolean;
begin
  Result:=FRealDataSet.Fields[FFieldIndex].Visible;
end;

end.
