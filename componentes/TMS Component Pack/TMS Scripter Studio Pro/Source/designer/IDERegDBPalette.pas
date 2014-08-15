unit IDERegDBPalette;

interface

uses
  IDEMain, ComCtrls, ExtCtrls, Grids, DB, DBTables, DBCtrls, DBGrids,
  ap_DB, ap_DBTables, ap_Grids, ap_DBGrids, ap_ComCtrls, ap_ExtCtrls,
  ap_DBCtrls, ap_Mask;

procedure IDERegisterDataAccessTab(AEngine: TIDEEngine);
procedure IDERegisterDataControlsTab(AEngine: TIDEEngine);

implementation

{$R DBIcons.res}

procedure IDERegisterDataAccessTab(AEngine: TIDEEngine);
begin
  With AEngine do
  begin
    BeginRegisterComponents;
    try
      RegisterComponent('Data Access',     TDatasource,    'DB,DBTables');
      RegisterComponent('Data Access',     TTable,         'DB,DBTables');
      RegisterComponent('Data Access',     TQuery,         'DB,DBTables');
      RegisterComponent('Data Access',     TStoredProc,    'DB,DBTables');
      RegisterComponent('Data Access',     TDatabase,      'DB,DBTables');
      RegisterComponent('Data Access',     TSession,       'DB,DBTables');
      RegisterComponent('Data Access',     TBatchMove,     'DB,DBTables');
      RegisterComponent('Data Access',     TUpdateSQL,     'DB,DBTables');
      RegisterComponent('Data Access',     TNestedTable,   'DB,DBTables');
    finally
      EndRegisterComponents;
    end;
  end;
end;

procedure IDERegisterDataControlsTab(AEngine: TIDEEngine);
begin
  With AEngine do
  begin
    BeginRegisterComponents;
    try
      RegisterComponent('Data Controls',     TDBGrid,           'Grids,DBGrids');
      RegisterComponent('Data Controls',     TDBNavigator,      'ExtCtrls,DBCtrls');
      RegisterComponent('Data Controls',     TDBText,           'DBCtrls');
      RegisterComponent('Data Controls',     TDBEdit,           'Mask,DBCtrls');
      RegisterComponent('Data Controls',     TDBMemo,           'DBCtrls');
      RegisterComponent('Data Controls',     TDBImage,          'DBCtrls');
      RegisterComponent('Data Controls',     TDBListBox,        'DBCtrls');
      RegisterComponent('Data Controls',     TDBComboBox,       'DBCtrls');
      RegisterComponent('Data Controls',     TDBCheckBox,       'DBCtrls');
      RegisterComponent('Data Controls',     TDBRadioGroup,     'ExtCtrls,DBCtrls');
      RegisterComponent('Data Controls',     TDBLookupListBox,  'DBCtrls');
      RegisterComponent('Data Controls',     TDBLookupComboBox, 'DBCtrls');
      RegisterComponent('Data Controls',     TDBRichEdit,       'ComCtrls,DBCtrls');
    finally
      EndRegisterComponents;
    end;
  end;
end;

end.
