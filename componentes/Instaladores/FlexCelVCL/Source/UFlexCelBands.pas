unit UFlexCelBands;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}

interface
uses UFlxMessages, UXlsDB, typinfo, Contnrs, Classes, SysUtils;
type
  TFlxValueType=(flv_Const, flv_Value, flv_Field, flv_Property, flv_Method, flv_FullDataSet);

  TExcelBandList= class;
  TDataSetArray=array of IXlsDataSet;

  TOneBandValue= record
    //It's not a variant record because it has variant and pointer values
    ColOffset: integer;
    CellValue: UTF16String;

    ValueType: TFlxValueType;
    Value: TXlsCellValue;
    RTFRuns: TRTFRunList;
    Field: IXlsField;
    DataSet: IXlsDataSet;
    PropInfo: PPropInfo;
    PropIndex: string;
    MethodInfo: pointer;
    VarName: string;
  end;

  TBandValue= array of TOneBandValue;  // it can have many values in one cell.
  TRowBandValue= record
    XF: integer;
    Height: integer;
    AutoHeight: boolean;
    Hidden: boolean;
    Cols:array of TBandValue;
  end;

  TBandValueList=array of TRowBandValue;

  WideStringArray= array of UTF16String;

  TExcelBand= class
    StartRow, EndRow: integer;
    RangePos: integer;
    SubBands: TExcelBandList;
    DataSet: TDataSetArray;
    constructor Create;
    destructor Destroy;override;
  end;

  TExcelBandList= class (TObjectList) //Items are TExcelBand
  {$Include TExcelBandListHdr.inc}
  end;

  TExcelDbList=class(TInterfaceList) //Items are IXlsDataSet
  {$Include TExcelDbListHdr.inc}
    procedure Check(const DataSet: IXlsDataSet);
    destructor Destroy; override;
  end;


implementation
{$Include TExcelBandListImp.inc}
{$Include TExcelDbListImp.inc}

{ TExcelBand }

constructor TExcelBand.Create;
begin
  inherited;
end;

destructor TExcelBand.Destroy;
begin
  FreeAndNil(SubBands);
  DataSet:=nil;
  inherited;
end;

{ TExcelDbList }

procedure TExcelDbList.Check(const DataSet: IXlsDataSet);
begin
  if (DataSet<>nil) and not DataSet.Active then
  begin
    DataSet.Open;
    Add(DataSet);
  end;
end;

destructor TExcelDbList.Destroy;
var
  i: integer;
begin
  for i:=0 to Count -1 do Items[i].Close;
  inherited;
end;

end.
