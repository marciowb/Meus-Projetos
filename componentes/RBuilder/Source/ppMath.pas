{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppMath;

interface

uses

  Math;

type

  {@TppMath }

  TppMath = class
    public

      class function Min(aFirstValue, aSecondValue: Integer): Integer;
      class function Max(aFirstValue, aSecondValue: Integer): Integer;
      class function Floor(aValue: Double): Integer;
      class function Ceiling(aValue: Double): Integer;

    end;

implementation


{@TppMath.Min }

class function TppMath.Min(aFirstValue, aSecondValue: Integer): Integer;
begin

  if (aFirstValue < aSecondValue) then
    Result := aFirstValue
  else
    Result := aSecondValue;

end;


{@TppMath.Max }

class function TppMath.Max(aFirstValue, aSecondValue: Integer): Integer;
begin

  if (aFirstValue > aSecondValue) then
    Result := aFirstValue
  else
    Result := aSecondValue;

end;


{@TppMath.Floor }

class function TppMath.Floor(aValue: Double): Integer;
begin

  Result := Trunc(aValue);

  if Abs(Frac(aValue)) > 0 then
    if (Result < 0) then
      Result := Result - 1;

end;


{@TppMath.Ceiling }

class function TppMath.Ceiling(aValue: Double): Integer;
begin

  Result := Trunc(aValue);

  if Abs(Frac(aValue)) > 0 then
    if (Result > 0) then
      Result := Result + 1;

end;


end.

