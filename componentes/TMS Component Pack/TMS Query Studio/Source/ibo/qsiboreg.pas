unit qsiboreg;

{$I tmsdefs.inc}
{$I metasql.inc}

interface

procedure Register;

implementation

uses
  {$IFDEF DELPHI6_LVL} Variants, DesignEditors, DesignIntf, {$ELSE} DsgnIntf, {$ENDIF}
  Classes,
  atIBODatabase;

const
  {$IFDEF TMSIWSQL}
  SMetaSQLPaletteName = 'IW Query Builder';
  {$ELSE}
  SMetaSQLPaletteName = 'TMS Query Studio';
  {$ENDIF}

procedure Register;
begin
  RegisterComponents(SMetaSQLPaletteName, [TatIBODatabase] );
end;

end.
