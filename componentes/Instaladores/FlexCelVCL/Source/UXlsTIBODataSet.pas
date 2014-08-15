unit UXlsTIBODataset;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}

interface
{$IFDEF IBOBJECTS}
uses SysUtils, UXlsDB, IB_Components, UFlxMessages;
type
  TXlsTIBODataset=class(TInterfacedObject , IXlsDataSet)
  private
    FDataSet: TIB_Dataset;
    FUseDisplayNames: boolean;
    FUseHiddenFields: boolean;
    CacheFields: array of IXlsField;
  public
    constructor Create(const aDataSet: TIB_Dataset; const aUseDisplayNames, aUseHiddenFields: boolean);

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

  TXlsTIBOField = class (TInterfacedObject, IXlsField)
  private
    FFieldIndex: integer;
    FRealDataSet: TIB_Dataset;
  public
    constructor Create(const aField: TIB_Column; const aRealDataSet: TIB_DataSet);
    function Value: variant;
    function IsTDateTimeField: boolean;
    function IsTMemoField: boolean;
    function AsFloat: extended;

    function Visible: boolean;

    function DisplayName: string;
  end;
{$ENDIF}
implementation
{$IFDEF IBOBJECTS}

{ TXlsTIBODataset }

procedure TXlsTIBODataset.Close;
begin
  FDataSet.Close;
end;

constructor TXlsTIBODataset.Create(const aDataSet: TIB_Dataset; const aUseDisplayNames, aUseHiddenFields: boolean);
begin
  inherited Create;
  if aDataSet=nil then Raise Exception.CreateFmt(ErrNoDataSet,['']);
  FDataSet:=aDataSet;
  FUseDisplayNames:=aUseDisplayNames;
  FUseHiddenFields:=aUseHiddenFields;
end;

function TXlsTIBODataset.DsName: string;
begin
  Result:=FDataSet.Name;
end;

function TXlsTIBODataset.Eof: boolean;
begin
  Result:=FDataSet.Eof;
end;

function TXlsTIBODataset.FieldByName(const Name: string): IXlsField;
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

function TXlsTIBODataset.FieldCount: integer;
begin
  Result:= FDataSet.FieldCount;
end;

function TXlsTIBODataset.FieldVisibleCount: integer;
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

procedure TXlsTIBODataset.First;
begin
  FDataSet.First;
end;

function TXlsTIBODataset.GetActive: boolean;
begin
  Result:=FDataSet.Active;
end;

function TXlsTIBODataset.GetFields(index: integer): IXlsField;
begin
  if Length(CacheFields)=0 then SetLength(CacheFields, FieldCount);
  if CacheFields[index]=nil then
  begin
    Result:=TXlsTIBOField.Create(FDataSet.Fields[Index], FDataSet);
    CacheFields[index]:=Result;
  end else Result:=CacheFields[index];
end;

procedure TXlsTIBODataset.Last;
begin
  FDataSet.Last;
end;

procedure TXlsTIBODataset.Next;
begin
  FDataSet.Next;
end;

procedure TXlsTIBODataset.Open;
begin
  FDataSet.Open;
end;

function TXlsTIBODataset.RecordCount: integer;
begin
  Result:=FDataSet.RecordCount;
end;

{ TXlsTField }

function TXlsTIBOField.AsFloat: extended;
begin
  Result:=FRealDataSet.Fields[FFieldIndex].AsFloat;
end;

constructor TXlsTIBOField.Create(const aField: TIB_Column; const aRealDataSet: TIB_DataSet);
begin
  if aField=nil then raise Exception.Create(ErrFieldNil);
  FFieldIndex:=aField.Index;
  FRealDataSet:=aRealDataSet;
end;

function TXlsTIBOField.DisplayName: string;
begin
  Result:=FRealDataSet.Fields[FFieldIndex].DisplayName;
end;

function TXlsTIBOField.IsTDateTimeField: boolean;
begin
  Result:=FRealDataSet.Fields[FFieldIndex].IsDateTime;
end;

function TXlsTIBOField.IsTMemoField: boolean;
begin
  Result:=FRealDataSet.Fields[FFieldIndex].IsText;
end;

function TXlsTIBOField.Value: variant;
begin
  Result:=FRealDataSet.Fields[FFieldIndex].Value;
end;

function TXlsTIBOField.Visible: boolean;
begin
  Result:=FRealDataSet.Fields[FFieldIndex].Visible;
end;
{$ENDIF}

end.
