unit uScriptLib;

interface
uses atScript, ap_Buttons, ap_Classes, ap_ComCtrls, ap_Controls, ap_DB, ap_DBCtrls,
  ap_DBGrids, ap_DBTables, ap_Dialogs, ap_ExtCtrls, ap_Forms, ap_Graphics,
  ap_Grids, ap_IniFiles, ap_Menus, ap_Printers, ap_Registry, ap_StdCtrls,
  ap_SysUtils,
  {$IFNDEF VER130}
  ap_Types, ap_Variants,
  {$ENDIF} 
  ap_Windows, ap_CheckLst, ap_ShellApi;
                                      

procedure AddScripterLibraries(AScripter: TatCustomScripter);

implementation

procedure AddScripterLibraries(AScripter: TatCustomScripter);
begin
  {Dummy, for now}
end;

end.
