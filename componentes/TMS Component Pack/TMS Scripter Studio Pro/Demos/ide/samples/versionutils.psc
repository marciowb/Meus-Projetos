var
  VersionNumberSeparator: string;

procedure CheckVersionNumberSeparator;
begin
  if VersionNumberSeparator = '' then
    VersionNumberSeparator := '.';
end;

function EncodeVersionNumber(A, B, C, D: integer): string;
begin
  CheckVersionNumberSeparator;
  result :=
    IntToStr(A) + VersionNumberSeparator +
    IntToStr(B) + VersionNumberSeparator +
    IntToStr(C) + VersionNumberSeparator +
    IntToStr(D);
end;

procedure DecodeVersionNumber(AVersion: string; var A, B, C, D: integer);
begin
  CheckVersionNumberSeparator;
  try
    P := Pos(VersionNumberSeparator, AVersion);
    A := StrToInt(Copy(AVersion, 1, P - 1));
    Delete(AVersion, 1, P);

    P := Pos(VersionNumberSeparator, AVersion);
    B := StrToInt(Copy(AVersion, 1, P - 1));
    Delete(AVersion, 1, P);

    P := Pos(VersionNumberSeparator, AVersion);
    C := StrToInt(Copy(AVersion, 1, P - 1));
    Delete(AVersion, 1, P);

    D := StrToInt(AVersion);
  except
    raise('Error while decoding version number: ' + LastExceptionMessage);
  end;
end;

