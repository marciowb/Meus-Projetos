unit qsadoreg;

{$I tmsdefs.inc}
{$I metasql.inc}

interface

procedure Register;

implementation

uses
  {$IFDEF DELPHI6_LVL} Variants, DesignEditors, DesignIntf, {$ELSE} DsgnIntf, {$ENDIF}
  Classes,
  atADODatabase;

const
  {$IFDEF TMSIWSQL}
  SMetaSQLPaletteName = 'IW Query Builder';
  {$ELSE}
  SMetaSQLPaletteName = 'TMS Query Studio';
  {$ENDIF}

procedure Register;
begin
  RegisterComponents(SMetaSQLPaletteName, [TatADODatabase] );
end;

end.
