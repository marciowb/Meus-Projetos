unit uDMConexao_Pan;

interface

uses
  SysUtils, Classes, DB, DBClient, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZConnection, IniFiles, WinSkinData, Forms, Registry, Windows,
  Controls,JvComponentBase, JvComputerInfoEx,  JvSerialMaker;

type

  TDMConexao = class(TDataModule)
    Conexao: TZConnection;
    Qry: TZQuery;
    SkinData1: TSkinData;
    Computer: TJvComputerInfoEx;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   Function GetHost : String;
   Function VerificaTrial : Boolean;
   Procedure AbreSplash ;
  end;

var
  DMConexao: TDMConexao;

implementation

uses uLincenca, Comandos_Pan, Dlg_Regiao, Classes_Pan, uSplash;

{$R *.dfm}

{ TDMConexao }

procedure TDMConexao.AbreSplash;
begin
   Try
     frmSplash := TfrmSplash.Create(nil);
     if frmSplash.ShowModal = mrOk then
       Exit;

   Finally
     FreeAndNil(frmSplash);
   End;
end;



procedure TDMConexao.DataModuleCreate(Sender: TObject);
var
  Txt : TFileStream;
  Filename : String;
begin
  Try
    Filename := Computer.Folders.System+'\XXX.k';
    if (not VerificaTrial) then
    Begin
      if  (not FileExists(Filename))  then
      Begin
        frmLincenca := TfrmLincenca.Create(nil);
        if frmLincenca.ShowModal = MrOk then
           AvisaOK('Serial registrado com sucesso.')
        else
          Application.Terminate;
      End ;
    End ;

    Conexao.Disconnect;
    Conexao.Protocol := 'mysql-5';
    Conexao.User := 'SYSDBA';
    Conexao.Password := 'masterkey';
    Conexao.Port := 3306;
    Conexao.Database := 'Pan';
    Conexao.HostName := GetHost;
    Conexao.Connect;
    AbreSplash;
  Finally
    FreeAndNil(frmLincenca);
  End;
end;

function TDMConexao.GetHost: String;
var
  Ini : TIniFile;
  FileName : String;
begin
  Try
    FileName := ExtractFilePath(Application.ExeName)+'Conexao.ini';
    ini := TIniFile.Create(FileName);
    if not FileExists(FileName) then
    Begin
       ini.WriteString('Geral', 'Host', 'localhost');
       ini.WriteInteger('Geral', 'TamanhoTexto', 100);
       ini.WriteString('Geral', 'Layout', 'Layout_Panamericana_1_0.rtm');
       ini.WriteString('Brasil', 'Decimal', ',');
       ini.WriteString('Brasil', 'DataSeparador', '/');
       ini.WriteString('Brasil', 'FormatoData', 'dd/mm/yyyy');
       ini.WriteString('USA', 'Decimal', '.');
       ini.WriteString('USA', 'DataSeparador', '-');
       ini.WriteString('USA', 'FormatoData', 'yyyy-mm-dd');
    End;
    Result := Ini.ReadString('Geral', 'Host', 'localhost');
  Finally
    FreeAndNil(ini);
  End;
end;

Function TDMConexao.VerificaTrial : Boolean;
var
  Arq : TIniFile;
  Filename : String ;
  Conta : Integer;
begin
  Result := False;
  Filename := Computer.Folders.System+'\XXX.t';
  if FileExists(Filename) then
  Begin
   Arq := TIniFile.Create(Filename);
   Result := True;
   if (FormatDateTime('dd/mm/yyyy', now) > Arq.ReadString('Datas', 'DataAtual',FormatDateTime('dd/mm/yyyy', now))) or
      (FormatDateTime('dd/mm/yyyy', now) < Arq.ReadString('Datas', 'DataAtual',FormatDateTime('dd/mm/yyyy', now)))  then
   Begin
     Conta := Arq.ReadInteger('Trial', 'Conta', 1);
     if Conta < 15 then
     Begin
       Conta := Conta + 1;
       Arq.WriteInteger('Trial', 'Conta', Conta);
       Arq.WriteString('Datas', 'DataAtual', FormatDateTime('dd/mm/yyyy', now));
       Avisa('Falta(m)  '+ IntToStr(15- Conta)+' dias para sua licença expirar.' );

     End else
     Begin
       Avisa('Sua licença expirou! Entre em contato com o suporte técnico.');
       Result := False;
     End;
   End;
   Arq.Free;

  End;
end;

end.
