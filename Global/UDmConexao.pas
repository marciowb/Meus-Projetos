unit UDmConexao;

interface

uses
  SysUtils, Classes, ImgList, Controls, cxGraphics,
  cxHint, cxTL, cxGridCardView,  cxClasses,
  cxStyles, cxGridTableView, cxLookAndFeels, DB, FIBDataSet, pFIBDataSet,
  DBClient, pFIBClientDataSet,
  Dialogs, JvComponentBase, JvPrint, dxPrnDev, dxPrnDlg, JvTFManager,
  FIBQuery, pFIBQuery, FIBDatabase, pFIBDatabase, Forms,
  WinSkinData, cxGridBandedTableView,IniFiles, JvComputerInfoEx, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue;

type

  TDMConexao= class(TDataModule)
    LookAndFeel: TcxLookAndFeelController;
    Style: TcxStyleRepository;
    Selecionado: TcxStyle;
    Inativo: TcxStyle;
    Grupo: TcxStyle;
    GroupByBox: TcxStyle;
    Atencao: TcxStyle;
    Alerta: TcxStyle;
    Morto: TcxStyle;
    StiloGrid: TcxGridTableViewStyleSheet;
    StiloBandled: TcxGridBandedTableViewStyleSheet;
    StiloCard: TcxGridCardViewStyleSheet;
    StiloTreeView: TcxTreeListStyleSheet;
    cxHintStyleController1: TcxHintStyleController;
    ImageList24_24: TcxImageList;
    ImageList16_16: TcxImageList;
    Total: TcxStyle;
    Gold: TcxStyle;
    Trans: TpFIBTransaction;
    SkinData: TSkinData;
    Conexao: TpFIBDatabase;
    pFIBDataSet1: TpFIBDataSet;
    InfoPC: TJvComputerInfoEx;
    Query: TpFIBQuery;
    pFIBDataSet2: TpFIBDataSet;
    DataSource1: TDataSource;
    pFIBDataSet3: TpFIBDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMCOnexao :TDMConexao;

implementation

uses Comandos, MinhasClasses, uLibLicenca, uCad_Licenca{, uCfg} {$IfDef ALPHA}, uLogin{$EndIf};

{$R *.dfm}




procedure TDMConexao.DataModuleCreate(Sender: TObject);
var
  Serial : AnsiString;
  Ini: TIniFile;
begin

  if InfoSistema.UsaBancoDados then
  Begin
    Try
      Ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+ 'Conexao.ini');
      InfoSistema.Host := Ini.ReadString('GERAL','HOST','127.0.0.1');
      InfoSistema.LocalBancoDados := Ini.ReadString('GERAL','LOCALBD',InfoSistema.LocalBancoDados);
      InfoSistema.UsuarioBanco := Ini.ReadString('GERAL','USUARIODB','SYSDBA');
      InfoSistema.SenhaBanco := Ini.ReadString('GERAL','SENHADB','2F4425843490357928A433A92D9028A43A24');//masterkey
      InfoSistema.SenhaBanco := DeKriptaStr(InfoSistema.SenhaBanco);
      InfoSistema.PortaBanco := Ini.ReadInteger('GERAL','PORTADB',3050);
      InfoSistema.NomeBanco:= ExtractFileName(InfoSistema.LocalBancoDados);
    Finally
      FreeAndNil(Ini);
    End;
    Conexao.Connected := False;
    Conexao.DBName := InfoSistema.Host+'/'+IntToStr(InfoSistema.PortaBanco )+':'+InfoSistema.LocalBancoDados;
    Conexao.ConnectParams.UserName := InfoSistema.UsuarioBanco ;
    Conexao.ConnectParams.Password := InfoSistema.SenhaBanco ;
    Conexao.Connected := True;
  End;
  if InfoSistema.Sistema in [sL_Kimera,sPet,sControleServico] then
  Begin
    InfoSistema.Serial := GetValorCds('SELECT VALOR FROM CONFIGURACOES WHERE NOMECONFIGURACAO = '+GetStr(cfgLKimeraSerial));
  End;
  {if InfoSistema.Sistema = sImoveis then
  Begin
    InfoSistema.Serial := MyCfgImovel.GetConfiguracao(tpImovSerial);
  End;
   }
  {$IfDef ALPHA}
    frmLogin := TfrmLogin.Create(nil);
    Try
      with frmLogin do
      Begin
        if showModal <> mrOk then
          Application.Terminate;
      End;
    Finally
      FreeAndNil(frmLogin);
    End;
  {$EndIf}
  if not InfoSistema.VerificaLicenca then
    Exit;
  Try
    if not GetComputadorLiberado(InfoSistema.Serial) then
    Begin
      Try
        frmCad_Licenca := TfrmCad_Licenca.Create(nil);
        if frmCad_Licenca.ShowModal <> mrok Then
          Application.Terminate;
      Finally
        FreeAndNil(frmCad_Licenca);
      End;
    End;
    if InfoSistema.UsuariosMax > 0 then
    begin
      if (GetTableCount('MON$ATTACHMENTS' )) > InfoSistema.UsuariosMax then
      begin
        Avisa('O número máximo de usuários conectados ultrapassou  o contratado de '+IntToStr(InfoSistema.UsuariosMax)+'. Entre em contato para aumentar o número de acessos.');
        Application.Terminate;
      end;
    end;

  Except
    AvisaErro('Erro ao validar usuário.', False);
    Application.Terminate;
  End;
  InfoSistema.Versao := GetVersaoAplicativo;

end;

end.
