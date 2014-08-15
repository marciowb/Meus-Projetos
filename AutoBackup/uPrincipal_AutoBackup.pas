unit uPrincipal_AutoBackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, DB, DBClient, StdCtrls, Buttons,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxPC,
  Mask, DBCtrls, LabelDBEdit, uLibBackup, VCLUnZip, VCLZip, cxContainer,
  cxProgressBar, Menus, WinSkinData, Registry, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter;

type
  TStatus = (tsLivre, tsIniciando,TsFazendoBackup,
             tsCompactando,tsCopiandoPastasLocais,
             tsCopiandoPastasFTP,tsTerminando);
  TfrmPrincipal_AutoBackup = class(TForm)
    CdsLocais: TClientDataSet;
    CdsHorarios: TClientDataSet;
    DataLocais: TDataSource;
    DataHorarios: TDataSource;
    CdsLocaisLocal: TStringField;
    CdsLocaisIsFTP: TBooleanField;
    CdsLocaisUsuario: TStringField;
    CdsLocaisSenha: TStringField;
    CdsLocaisHost: TStringField;
    PageControl: TcxPageControl;
    tsConfiguracoes: TcxTabSheet;
    Panel3: TPanel;
    Panel2: TPanel;
    tsLog: TcxTabSheet;
    Datalog: TDataSource;
    CdsLog: TClientDataSet;
    TvLog: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    CdsLogData: TDateField;
    CdsLogHora: TTimeField;
    CdsLogTexto: TStringField;
    cxLookAndFeelController1: TcxLookAndFeelController;
    cxStyleRepository1: TcxStyleRepository;
    FTP: TIdFTP;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrid3: TcxGrid;
    TvLocal: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    cxGridDBTableView1Hora: TcxGridDBColumn;
    cxGridDBTableView1DisplayDia: TcxGridDBColumn;
    Erro: TcxStyle;
    StFTP: TcxStyle;
    Aviso: TcxStyle;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Panel4: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Timer: TTimer;
    Panel5: TPanel;
    LabelDBEdit1: TLabelDBEdit;
    BitBtn1: TBitBtn;
    DataConfiguracoes: TDataSource;
    CdsConfiguracoes: TClientDataSet;
    Open: TOpenDialog;
    CdsConfiguracoesBanco: TStringField;
    CdsHorariosDiaSemana: TIntegerField;
    CdsHorariosHora: TTimeField;
    CdsHorariosDisplayDia: TStringField;
    Zip: TVCLZip;
    CdsHorariosFlagDone: TBooleanField;
    CdsLogFlagErro: TBooleanField;
    TvLogData: TcxGridDBColumn;
    TvLogHora: TcxGridDBColumn;
    TvLogTexto: TcxGridDBColumn;
    TvLogFlagErro: TcxGridDBColumn;
    ProgressBar: TcxProgressBar;
    TrayIcon: TTrayIcon;
    PopupMenu: TPopupMenu;
    Abrir1: TMenuItem;
    Fechar1: TMenuItem;
    TvLocalLocal: TcxGridDBColumn;
    TvLocalHost: TcxGridDBColumn;
    SkinData1: TSkinData;
    N1: TMenuItem;
    N2: TMenuItem;
    Pararagendador1: TMenuItem;
    CdsConfiguracoesIniciarJuntoComWindows: TBooleanField;
    chkIniciajunto: TCheckBox;
    Forarexecuo1: TMenuItem;
    Enviararquivoparasuporte1: TMenuItem;
    Resaurar1: TMenuItem;
    N3: TMenuItem;
    procedure SpeedButton1Click(Sender: TObject);
    procedure CdsHorariosAfterPost(DataSet: TDataSet);
    procedure CdsLogAfterPost(DataSet: TDataSet);
    procedure CdsLocaisAfterPost(DataSet: TDataSet);
    procedure SpeedButton2Click(Sender: TObject);
    procedure CdsHorariosAfterDelete(DataSet: TDataSet);
    procedure CdsLogAfterEdit(DataSet: TDataSet);
    procedure CdsLogAfterDelete(DataSet: TDataSet);
    procedure CdsLocaisAfterDelete(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure cxGridDBTableView1DblClick(Sender: TObject);
    procedure TvLocalDblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CdsConfiguracoesAfterPost(DataSet: TDataSet);
    procedure TimerTimer(Sender: TObject);
    procedure TvLogStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AStyle: TcxStyle);
    procedure FTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure FTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure FTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure Abrir1Click(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure cxGridDBTableView2StylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Pararagendador1Click(Sender: TObject);
    procedure chkIniciajuntoClick(Sender: TObject);
    procedure Forarexecuo1Click(Sender: TObject);
    procedure Enviararquivoparasuporte1Click(Sender: TObject);
    procedure Resaurar1Click(Sender: TObject);
  private
    { Private declarations }
    DiaAtual : integer;
    FStatus: TStatus;
    vOnExcept :TExceptionEvent;
    procedure SetStatus(const Value: TStatus);
    Procedure ClonaHorario;
    Procedure ExecutaBackup;
    Procedure OnExcept(Sender: TObject; E: Exception);
  public
    { Public declarations }
    Function GetCaminho: String;
    Function ConfirmaDel : Boolean;
    Procedure Save(DataSet: TClientDataSet; FileName : String);
    Procedure Load(DataSet: TClientDataSet; FileName : String);
    Procedure AddLog(Msg: String; pErro: Boolean = False);
    property Status : TStatus read FStatus write SetStatus;
  end;

var
  frmPrincipal_AutoBackup: TfrmPrincipal_AutoBackup;
  CdsHorarioClone : TClientDataSet;
const
  Horarios: String = 'horarios.xen';
  Locais  : String = 'locais.xen';
  Log: String = 'LogAutoBakup.xen';
  Conf: String = 'Conf.xen';
implementation
  uses
    Cad_Locais,Cad_Horario;
{$R *.dfm}

procedure TfrmPrincipal_AutoBackup.Abrir1Click(Sender: TObject);
begin
  Self.Show;
end;

procedure TfrmPrincipal_AutoBackup.AddLog(Msg: String; pErro: Boolean = False);
begin
  CdsLog.Append;
  CdsLogData.AsDateTime := now;
  CdsLogHora.AsDateTime := now;
  CdsLogTexto.AsString := Msg;
  CdsLogFlagErro.AsBoolean := pErro;
  CdsLog.Post;
end;

procedure TfrmPrincipal_AutoBackup.BitBtn1Click(Sender: TObject);
begin
  if Open.Execute then
  Begin
    if CdsConfiguracoes.RecordCount = 0 then
       CdsConfiguracoes.Append
    else
      CdsConfiguracoes.Edit;
    CdsConfiguracoesBanco.AsString := Open.FileName;
    CdsConfiguracoes.Post;
  End;
end;

procedure TfrmPrincipal_AutoBackup.CdsConfiguracoesAfterPost(DataSet: TDataSet);
begin
  Save(CdsConfiguracoes, Conf);
end;

procedure TfrmPrincipal_AutoBackup.CdsHorariosAfterDelete(DataSet: TDataSet);
begin
  Save(CdsHorarios, Horarios);
  ClonaHorario;
end;

procedure TfrmPrincipal_AutoBackup.CdsHorariosAfterPost(DataSet: TDataSet);
begin
  Save(CdsHorarios,Horarios);
  ClonaHorario;
end;

procedure TfrmPrincipal_AutoBackup.CdsLocaisAfterDelete(DataSet: TDataSet);
begin
  Save(CdsLocais, Locais);
end;

procedure TfrmPrincipal_AutoBackup.CdsLocaisAfterPost(DataSet: TDataSet);
begin
  Save(CdsLocais,Locais);
end;

procedure TfrmPrincipal_AutoBackup.CdsLogAfterDelete(DataSet: TDataSet);
begin
  Save(CdsLog, Log);
end;

procedure TfrmPrincipal_AutoBackup.CdsLogAfterEdit(DataSet: TDataSet);
begin
   Save(CdsLog, Log);
end;

procedure TfrmPrincipal_AutoBackup.CdsLogAfterPost(DataSet: TDataSet);
begin
  Save(CdsLog,Log);
end;

procedure TfrmPrincipal_AutoBackup.ClonaHorario;
begin
  Timer.Enabled := False;
  CdsHorarioClone.Close;
  CdsHorarioClone.Data := CdsHorarios.Data;
  CdsHorarioClone.Open;
  Timer.Enabled := True;
end;

function TfrmPrincipal_AutoBackup.ConfirmaDel: Boolean;
begin
  Result := Application.MessageBox('Confirma exclusão ? ','Atenção', 4) = 6 ;
end;

procedure TfrmPrincipal_AutoBackup.cxGridDBTableView1DblClick(Sender: TObject);
begin
  frmCad_Horario := TfrmCad_Horario.Create(Self);
  Try
    with frmCad_Horario do
    Begin
      Self.CdsHorarios.Edit;
      ShowModal;
    End;
  Finally
    FreeAndNil(frmCad_Horario);
  End;


end;

procedure TfrmPrincipal_AutoBackup.TvLocalDblClick(Sender: TObject);
begin
  frmCad_locais := TfrmCad_locais.Create(Self);
  Try
    with frmCad_locais do
    Begin
      CdsLocais.Edit;
      ShowModal;
    End;
  Finally
    FreeAndNil(frmCad_locais);
  End;
end;

procedure TfrmPrincipal_AutoBackup.cxGridDBTableView2StylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  with TvLocal.GetColumnByFieldName('HOST') do
  Begin
    if not VarIsNull(ARecord.Values[Index]) then
      AStyle := StFTP;
  End;
end;

procedure TfrmPrincipal_AutoBackup.Enviararquivoparasuporte1Click(
  Sender: TObject);
var
  pFTP: TIdFTP;
  Pasta, vFile: String;
begin
  Open.Filter := '*.*|*.*';
  if not Open.Execute then
    Exit;
  vFile := OPen.FileName;
  Try
    pFTP:= TIdFTP.Create(nil);
    pFTP.Host := 'ftp.hrm.kinghost.net';
    pFTP.Username := 'hrm';
    pFTP.Password := 'filipe';
    pFTP.Connect;
    Pasta := FormatDateTime('dd_mm_yyyy_hh_nn_ss',now);
    pFTP.MakeDir(Pasta);
    pFTP.ChangeDir(Pasta);
    pFTP.Put(vFile,ExtractFileName(vFile));
    ShowMessage('Terminado!');
  Finally
    FreeAndNil(pFTP);
  End;
end;

procedure TfrmPrincipal_AutoBackup.ExecutaBackup;
var
  Dir, vFileBKP, vFile: String;
begin
  Status := tsIniciando;
   Try
     Status := TsFazendoBackup;
     vFileBKP := ExtractFilePath(Application.ExeName)+'bkp.fbk';
     GeraBackup(CdsConfiguracoesBanco.AsString, vFileBKP);
     Status := tsCompactando;
     Zip.FilesList.Text := vFileBKP;
     Zip.RootDir := ExtractFilePath(Application.ExeName);
     Zip.DestDir := ExtractFilePath(Application.ExeName);
     vFile := ExtractFilePath(Application.ExeName)+ 'BKP.zip';
     Zip.ZipName := vFile ;
     Zip.Zip;
     Dir := FormatDateTime('DD_MM_YYYY_HH_NN_SS',now);
     Status := tsCopiandoPastasLocais;
     CdsLocais.First;
     while not CdsLocais.Eof do
     Begin
       if not DirectoryExists(CdsLocaisLocal.AsString+'\'+Dir) then
       Begin
         if not CdsLocaisIsFTP.AsBoolean then
         Begin
           AddLog('Copiando para '+CdsLocaisLocal.AsString);
           ForceDirectories(CdsLocaisLocal.AsString+'\'+Dir);
           CopyFile(PwideChar(vFile), PwideChar(CdsLocaisLocal.AsString+'\'+Dir+'\BKP.zip'), False);
         End else
         Begin
           Try
             AddLog('Copiando para FTP '+CdsLocaisHost.AsString+#13+
                    ' Na pasta '+ CdsLocaisLocal.AsString  );
             FTP.Disconnect;
             FTP.Username := CdsLocaisUsuario.AsString;
             FTP.Password := CdsLocaisSenha.AsString;
             FTP.Host := CdsLocaisHost.AsString;
             FTP.Connect;
             if FTP.Connected then
             Begin
               try
                 FTP.ChangeDir(CdsLocaisLocal.AsString+'/'+Dir);
               except
                 FTP.MakeDir(CdsLocaisLocal.AsString+'\'+Dir);
                 FTP.ChangeDir(CdsLocaisLocal.AsString+'/'+Dir);
               end;
               FTP.Put(vFile,CdsLocaisLocal.AsString+'/'+Dir+'/BKP.zip');
             End;
           Except
             on e: exception do
             Begin
               AddLog('Não foi possível copiar para FTP '+CdsLocaisHost.AsString+#13+
                      ' Na pasta '+ CdsLocaisLocal.AsString+'.'+#13+
                      E.Message,True  );

               CdsLocais.Next;
               Continue;
             End;
           End;

         End;
       End;
       CdsLocais.Next;
     End;
   Finally
     AddLog('Apagando arquivos temporários');
     DeleteFile(vFileBKP);
     DeleteFile(vFile);
     Status := tsTerminando;
     Status := tsLivre;
   End;
end;

procedure TfrmPrincipal_AutoBackup.chkIniciajuntoClick(Sender: TObject);
var
  Reg : TRegistry;
  Nome: String;
  I:Integer;
begin
  Try
    Reg := TRegistry.Create(KEY_WOW64_64KEY );
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run\', False);
    Nome :=ExtractFilePath(Application.ExeName);
    Nome := ExtractFileDir(Nome);
    for I := Length(Nome)-1 downto 1 do
      if Nome[i]= '\' then
        Break;
    Nome := 'AutoBackup_'+Trim(Copy(Nome,i+1,255));
    Try
      if chkIniciajunto.Checked then
        Reg.WriteString(Nome,Application.ExeName)
      else
        Reg.DeleteKey(Self.Caption);
    Except
      on e: Exception do
      begin
        raise;
      end;
    End;
    if not (CdsConfiguracoes.State in [dsEdit, dsInsert]) then
    Begin
      CdsConfiguracoes.Edit;
      CdsConfiguracoesIniciarJuntoComWindows.AsBoolean := chkIniciajunto.Checked;
      CdsConfiguracoes.Post;
    End;
  Finally
    FreeAndNil(Reg);
  End;

end;

procedure TfrmPrincipal_AutoBackup.Fechar1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal_AutoBackup.Forarexecuo1Click(Sender: TObject);
begin
  ExecutaBackup;
end;

procedure TfrmPrincipal_AutoBackup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caNone;
  Self.Hide;
end;

procedure TfrmPrincipal_AutoBackup.FormCreate(Sender: TObject);
begin
  Load(CdsLocais, Locais);
  Load(CdsHorarios, Horarios);
  Load(CdsConfiguracoes, Conf);
  CdsHorarioClone := TClientDataSet.Create(nil);
  ClonaHorario;
  Status := tsLivre;
  vOnExcept := Application.OnException;
  Application.OnException := Self.OnExcept;
  chkIniciajunto.Checked  := CdsConfiguracoesIniciarJuntoComWindows.AsBoolean ;
  if FileExists(Log) then
  Begin
    Load(CdsLog,Log);
    CdsLog.Last;
  End;
end;

procedure TfrmPrincipal_AutoBackup.FTPWork(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  ProgressBar.Position := AWorkCount;
  Application.ProcessMessages;
end;

procedure TfrmPrincipal_AutoBackup.FTPWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  ProgressBar.Properties.Max := AWorkCountMax;
  ProgressBar.Visible := True;
end;

procedure TfrmPrincipal_AutoBackup.FTPWorkEnd(ASender: TObject;
  AWorkMode: TWorkMode);
begin
  ProgressBar.Visible := False;
end;

function TfrmPrincipal_AutoBackup.GetCaminho: String;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

procedure TfrmPrincipal_AutoBackup.Load(DataSet: TClientDataSet;
  FileName: String);
begin
  if FileExists(GetCaminho+FileName) then
    DataSet.LoadFromFile(GetCaminho+FileName);
end;

procedure TfrmPrincipal_AutoBackup.OnExcept(Sender: TObject; E: Exception);
begin
  AddLog(E.Message, True);
end;

procedure TfrmPrincipal_AutoBackup.Pararagendador1Click(Sender: TObject);
begin
  if Pararagendador1.Tag = 0 then
  Begin
    Pararagendador1.Tag := 1;
    Pararagendador1.Caption := 'Iniciar agendador';
  End else
  Begin
    Pararagendador1.Tag := 0 ;
    Pararagendador1.Caption := 'Parar agendador';
  End;
  Timer.Enabled := Pararagendador1.Tag = 0;
end;

procedure TfrmPrincipal_AutoBackup.Resaurar1Click(Sender: TObject);
var
  vFilter, PastaTemp, vFile: String;
begin
  vFilter := Open.Filter;
  Open.Filter := 'Arquivo Compactado|*.zip';
  Try
    if not  Open.Execute then
      Exit;
    PastaTemp := ExtractFilePath(Open.FileName);
    AddLog('Lendo arquivo');
    Zip.FilesList.Clear;
    Zip.FilesList.Add(Open.FileName);
    Zip.DoAll := True;
    Zip.RootDir := PastaTemp;
    Zip.TempPath := PastaTemp;
    Zip.DestDir := PastaTemp;
    Zip.ZipName := Open.FileName;
    Zip.ReadZip;
    AddLog('Descompactando arquivo');
    Zip.UnZip;
    try
      vFile := CdsConfiguracoesBanco.AsString;
      vFile := ExtractFilePath(vFile)+FormatDateTime('dd_mm_yyyy_hh_nn_ss',Now)+ExtractFileName(vFile);
      AddLog('Renomeando arquivo original');
      RenameFile(CdsConfiguracoesBanco.AsString,vFile);
      AddLog('Restaurando backup');
      Restaura(PastaTemp+Zip.Filename[0], CdsConfiguracoesBanco.AsString);
      AddLog('Backup restaurado com sucesso');
    except
      on E: Exception do
        AddLog(E.Message,True);
    end;
  Finally
    Open.Filter :=  vFilter;
  End;

end;

procedure TfrmPrincipal_AutoBackup.Save(DataSet: TClientDataSet;
  FileName: String);
begin
  if FileExists(GetCaminho+FileName) then
    DeleteFile(GetCaminho+FileName);
  DataSet.SaveToFile(GetCaminho+FileName);
end;

procedure TfrmPrincipal_AutoBackup.SetStatus(const Value: TStatus);
begin
  FStatus := Value;
  case Value of
    tsLivre: ;
    tsIniciando:
      AddLog('Iniciando backup');
    TsFazendoBackup:
      AddLog('Gerando arquivo de  backup');
    tsCompactando:
      AddLog('Compactando arquivos');
    tsCopiandoPastasLocais:
      AddLog('Copiando para pastas locais');
    tsCopiandoPastasFTP:
      AddLog('Copiando para pastas FTP');
    tsTerminando:
      AddLog('Backup terminado');
  end;
end;

procedure TfrmPrincipal_AutoBackup.SpeedButton1Click(Sender: TObject);
begin
  frmCad_Horario := TfrmCad_Horario.Create(Self);
  Try
    with frmCad_Horario do
    Begin
      CdsHorarios.Append;
      ShowModal;
    End;
  Finally
    FreeAndNil(frmCad_Horario);
  End;

end;

procedure TfrmPrincipal_AutoBackup.SpeedButton2Click(Sender: TObject);
begin
  if ConfirmaDel then
    CdsHorarios.Delete;

end;

procedure TfrmPrincipal_AutoBackup.SpeedButton3Click(Sender: TObject);
begin
  frmCad_locais := TfrmCad_locais.Create(Self);
  Try
    Timer.Enabled := False;
    with frmCad_locais do
    Begin
      CdsLocais.Append;
      ShowModal;
    End;
  Finally
    FreeAndNil(frmCad_locais);
    Timer.Enabled := True;
  End;
end;

procedure TfrmPrincipal_AutoBackup.SpeedButton4Click(Sender: TObject);
begin
  if ConfirmaDel then
    CdsLocais.Delete;

end;

procedure TfrmPrincipal_AutoBackup.TimerTimer(Sender: TObject);
var
  pDia: Integer;
  vFilter: String;
begin
  if Status <> tsLivre then
    Exit;
  pDia := DayOfWeek(now);
  if pDia <> DiaAtual then
  Begin
    DiaAtual := pDia ;
    CdsHorarioClone.Filtered := False;
    CdsHorarioClone.Filter := 'DiaSemana = '+IntToStr(DiaAtual);
    CdsHorarioClone.Filtered := True;
    CdsHorarioClone.First;
    while not CdsHorarioClone.Eof do
    Begin
      CdsHorarioClone.Edit;
      CdsHorarioClone.FieldByName('FLAGDONE').AsBoolean := False;
      CdsHorarioClone.Post;
      CdsHorarioClone.Next;
    End;
  End;

  vFilter := CdsHorarioClone.Filter;
  CdsHorarioClone.Filtered := False;
  CdsHorarioClone.Filter := vFilter + ' AND HORA = '+QuotedStr(FormatDateTime('HH:NN', NOW));
  CdsHorarioClone.Filtered := True;
  Timer.Enabled := False;
  Try
    if CdsConfiguracoesBanco.AsString = '' then
      Exit;
    if (CdsHorarioClone.RecordCount > 0) and (CdsLocais.RecordCount > 0) and
       (not CdsHorarioClone.FieldByName('FLAGDONE').AsBoolean) then
    Begin
      ExecutaBackup;
    End;
  Finally
    CdsHorarioClone.Edit;
    CdsHorarioClone.FieldByName('FLAGDONE').AsBoolean := True;
    CdsHorarioClone.Post;
    CdsHorarioClone.Filtered := False;
    CdsHorarioClone.Filter := vFilter;
    CdsHorarioClone.Filtered := True;
    Timer.Enabled := True;
  End;

end;

procedure TfrmPrincipal_AutoBackup.TvLogStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  with TvLog.GetColumnByFieldName('FLAGERRO') do
  Begin
    if  (ARecord.Values[Index] = True) then
      AStyle := Erro;
  End;

end;

end.
