unit IDERegAdoPalette;

interface

uses IDEMain, DB, ADODB, ap_ADODB;

procedure IDERegisterADOTab(AEngine: TIDEEngine);

implementation

{$R ADOIcons.res}

procedure IDERegisterADOTab(AEngine: TIDEEngine);
begin
  With AEngine do
  begin
    BeginRegisterComponents;
    try
      RegisterComponent('ADO',     TADOConnection, 'DB,ADODB');
      RegisterComponent('ADO',     TADOCommand,    'DB,ADODB');
      RegisterComponent('ADO',     TADODataset,    'DB,ADODB');
      RegisterComponent('ADO',     TADOTable,      'DB,ADODB');
      RegisterComponent('ADO',     TADOQuery,      'DB,ADODB');
      RegisterComponent('ADO',     TADOStoredProc, 'DB,ADODB');
    finally
      EndRegisterComponents;
    end;
  end;
end;

end.

