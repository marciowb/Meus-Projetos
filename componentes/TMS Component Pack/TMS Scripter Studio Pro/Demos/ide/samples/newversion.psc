uses versionutils;

var
  N1, N2, N3, N4: integer;
  VersionNumber, NewVersionNumber: string;
begin
  VersionNumber := '2.1.3.4';
  if InputQuery('Scripter Studio demo',
    'Please type a version number with four digits, separated by "."',
    VersionNumber) then
  begin
    VersionNumberSeparator := '.';
    DecodeVersionNumber(VersionNumber, N1, N2, N3, N4);

    VersionNumberSeparator := '-';
    NewVersionNumber := EncodeVersionNumber(N1, N2 + 1, 0, 0);
    ShowMessage('The version number of next release is ' + NewVersionNumber);
  end;
end;
