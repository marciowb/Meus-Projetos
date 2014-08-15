unit dxlocate;

interface
{$I cxVer.inc}
uses DB{$IFDEF DELPHI6}, Variants{$ENDIF};

function DBTrDataSetLocate(DataSet: TDataSet; AFieldName: string; AValue: Variant; AOptions: TLocateOptions): Boolean;

implementation

function DBTrDataSetLocate(DataSet: TDataSet; AFieldName: string; AValue: Variant; AOptions: TLocateOptions): Boolean;
begin
  Result := DataSet.Locate(AFieldName, AValue, AOptions);
end;

end.
