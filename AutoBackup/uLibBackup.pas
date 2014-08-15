unit uLibBackup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, Registry,
  IB_Services;
Procedure GeraBackup(DataBase, LocalDestino: String;
  ValidaAposGerarBakup: Boolean = False);
Procedure Restaura(ArquivoOrigem, ArquivoDestino: String);

var
  pBackup: TpFIBBackupService;
  pRestore: TpFIBRestoreService;

implementation

Procedure GeraBackup(DataBase, LocalDestino: String;
  ValidaAposGerarBakup: Boolean = False);
var
  Text: TextFile;
  pVerbose: String;
Begin
  Try
    pVerbose := ExtractFilePath(ParamStr(0)) + 'Verbose.txt';
    if FileExists(pVerbose) then
      DeleteFile(pVerbose);
    Assign(Text, pVerbose);
    Rewrite(Text);

    pBackup.BackupFile.Text := LocalDestino;
    pBackup.DatabaseName := DataBase;
    pBackup.Active := True;
    pBackup.ServiceStart;
    while pBackup.IsServiceRunning do
    Begin
      Writeln(Text, pBackup.GetNextLine);
    End;
  Finally
    CloseFile(Text);
  End;

End;

Procedure Restaura(ArquivoOrigem, ArquivoDestino: String);
var
  Text: TextFile;
  pVerbose: String;
Begin
  Try
    pVerbose := ExtractFilePath(ParamStr(0)) + 'VerboseRest.txt';
    if FileExists(pVerbose) then
      DeleteFile(pVerbose);
    Assign(Text, pVerbose);
    Rewrite(Text);
    pRestore.BackupFile.Text := ArquivoOrigem;
    pRestore.DatabaseName.Text := ArquivoDestino;
    pRestore.Active := True;
    pRestore.ServiceStart;
    while pRestore.IsServiceRunning do
    Begin
      Writeln(Text, pRestore.GetNextLine);
    End;
  Finally
    CloseFile(Text);
  End;

End;

initialization

pBackup := TpFIBBackupService.Create(nil);
pBackup.Verbose := True;
pBackup.LibraryName := 'fbClient.dll';
pBackup.ServerName := '127.0.0.1';
pBackup.Params.Clear;
pBackup.Params.Add('user_name=SYSDBA');
pBackup.Params.Add('password=masterkey');
pBackup.LoginPrompt := False;
pRestore := TpFIBRestoreService.Create(nil);
pRestore.Verbose := True;
pRestore.LibraryName := 'fbClient.dll';
pRestore.Params.Add('user_name=SYSDBA');
pRestore.Params.Add('password=masterkey');
pRestore.LoginPrompt := False;

end.
