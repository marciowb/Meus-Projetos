unit ifpidateutilsr;

interface
uses
  SysUtils, ifps3;

procedure RegisterDateTimeLibrary_R(S: TIFPSExec);

implementation

uses
  ifpidelphiruntime;

function TryEncodeDate(Year, Month, Day: Word; var Date: TDateTime): Boolean;
begin
  try
    Date := EncodeDate(Year, Month, Day);
    Result := true;
  except
    Result := false;
  end;
end;

function TryEncodeTime(Hour, Min, Sec, MSec: Word; var Time: TDateTime): Boolean;
begin
  try
    Time := EncodeTime(hour, Min, Sec, MSec);
    Result := true;
  except
    Result := false;
  end;
end;

function DateTimeToUnix(D: TDateTime): Int64;
begin
  Result := Round((D - 25569) * 86400);
end;

function UnixToDateTime(U: Int64): TDateTime;
begin
  Result := U / 86400 + 25569;
end;

procedure RegisterDateTimeLibrary_R(S: TIFPSExec);
begin
  RegisterDelphiFunctionR(S, @EncodeDate, 'ENCODEDATE', cdRegister);
  RegisterDelphiFunctionR(S, @EncodeTime, 'ENCODETIME', cdRegister);
  RegisterDelphiFunctionR(S, @TryEncodeDate, 'TRYENCODEDATE', cdRegister);
  RegisterDelphiFunctionR(S, @TryEncodeTime, 'TRYENCODETIME', cdRegister);
  RegisterDelphiFunctionR(S, @DecodeDate, 'DECODEDATE', cdRegister);
  RegisterDelphiFunctionR(S, @DecodeTime, 'DECODETIME', cdRegister);
  RegisterDelphiFunctionR(S, @DayOfWeek, 'DAYOFWEEK', cdRegister);
  RegisterDelphiFunctionR(S, @Date, 'DATE', cdRegister);
  RegisterDelphiFunctionR(S, @Time, 'TIME', cdRegister);
  RegisterDelphiFunctionR(S, @Now, 'NOW', cdRegister);
  RegisterDelphiFunctionR(S, @DateTimeToUnix, 'DATETIMETOUNIX', cdRegister);
  RegisterDelphiFunctionR(S, @UnixToDateTime, 'UNIXTODATETIME', cdRegister);

  RegisterDelphiFunctionR(S, @DateToStr, 'DATETOSTR', cdRegister);
  RegisterDelphiFunctionR(S, @FormatDateTime, 'FORMATDATETIME', cdRegister);
  RegisterDelphiFunctionR(S, @StrToDate, 'STRTODATE', cdRegister);
end;

end.
