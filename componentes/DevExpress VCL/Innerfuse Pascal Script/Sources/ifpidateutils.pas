unit ifpidateutils;

interface
uses
  SysUtils, ifpscomp;

{

TDateTime = double;

function EncodeDate(Year, Month, Day: Word): TDateTime;
function EncodeTime(Hour, Min, Sec, MSec: Word): TDateTime;
function TryEncodeDate(Year, Month, Day: Word; out Date: TDateTime): Boolean;
function TryEncodeTime(Hour, Min, Sec, MSec: Word; out Time: TDateTime): Boolean;
procedure DecodeDate(const DateTime: TDateTime; var Year, Month, Day: Word);
procedure DecodeTime(const DateTime: TDateTime; var Hour, Min, Sec, MSec: Word);
function DayOfWeek(const DateTime: TDateTime): Word;
function Date: TDateTime;
function Time: TDateTime;
function Now: TDateTime;
function DateTimeToUnix(D: TDateTime): Int64;
function UnixToDateTime(U: Int64): TDateTime;
function DateToStr(D: TDateTime): string;
function StrToDate(const s: string): TDateTime;
function FormatDateTime(const fmt: string; D: TDateTime): string;
}

procedure RegisterDateTimeLibrary_C(S: TIFPSPascalCompiler);

implementation
uses
  ifpidelphi;

procedure RegisterDatetimeLibrary_C(S: TIFPSPascalCompiler);
begin
  s.AddTypeCopyN('TDateTime', 'Double');
  RegisterDelphiFunctionC2(S, 'function EncodeDate(Year, Month, Day: Word): TDateTime;');
  RegisterDelphiFunctionC2(S, 'function EncodeTime(Hour, Min, Sec, MSec: Word): TDateTime;');
  RegisterDelphiFunctionC2(S, 'function TryEncodeDate(Year, Month, Day: Word; var Date: TDateTime): Boolean;');
  RegisterDelphiFunctionC2(S, 'function TryEncodeTime(Hour, Min, Sec, MSec: Word; var Time: TDateTime): Boolean;');
  RegisterDelphiFunctionC2(S, 'procedure DecodeDate(const DateTime: TDateTime; var Year, Month, Day: Word);');
  RegisterDelphiFunctionC2(S, 'procedure DecodeTime(const DateTime: TDateTime; var Hour, Min, Sec, MSec: Word);');
  RegisterDelphiFunctionC2(S, 'function DayOfWeek(const DateTime: TDateTime): Word;');
  RegisterDelphiFunctionC2(S, 'function Date: TDateTime;');
  RegisterDelphiFunctionC2(S, 'function Time: TDateTime;');
  RegisterDelphiFunctionC2(S, 'function Now: TDateTime;');
  RegisterDelphiFunctionC2(S, 'function DateTimeToUnix(D: TDateTime): Int64;');
  RegisterDelphiFunctionC2(S, 'function UnixToDateTime(U: Int64): TDateTime;');

  RegisterDelphiFunctionC2(S, 'function DateToStr(D: TDateTime): string;');
  RegisterDelphiFunctionC2(S, 'function StrToDate(const s: string): TDateTime;');
  RegisterDelphiFunctionC2(S, 'function FormatDateTime(const fmt: string; D: TDateTime): string;');
end;

end.
