unit uVerificaUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, ExtCtrls, Grids, JvgStringGrid, ComCtrls, StdCtrls,
  Buttons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  JvComponentBase, JvPropertyStore, JvProgramVersionCheck, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdFTP, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DBClient, pFIBClientDataSet,
  VCLUnZip, cxContainer, cxProgressBar, uAtualizadorBD, {$IfNDef Alpha} uCfg, {$EndIf} MinhasClasses;

type
  TfrmVerificaUpdate = class(TfrmPadrao)
    pnlGeral: TPanel;
    Panel2: TPanel;
    btnVerificar: TBitBtn;
    BitBtn2: TBitBtn;
    DataArquivos: TDataSource;
    CdsArquivos: TpFIBClientDataSet;
    TvArquivos: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    FTP: TIdFTP;
    TvArquivosNomeArquivo: TcxGridDBColumn;
    TvArquivosTamanho: TcxGridDBColumn;
    UnZip: TVCLUnZip;
    pnlStatus: TPanel;
    Panel4: TPanel;
    ProgressBar: TcxProgressBar;
    lblStatus: TLabel;
    btnInstalar: TBitBtn;
    CdsArquivosEndereco: TStringField;
    CdsArquivosNomeArquivo: TStringField;
    CdsArquivosTamanho: TIntegerField;
    CdsArquivosFlagDownload: TBooleanField;
    CdsArquivosTamanhoReal: TIntegerField;
    procedure BitBtn2Click(Sender: TObject);
    procedure btnVerificarClick(Sender: TObject);
    procedure btnInstalarClick(Sender: TObject);
    procedure FTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure UnZipStartUnZip(Sender: TObject; FileIndex: Integer;
      var FName: string; var Skip: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure AfterInstall;
    Procedure BeforeInstall;
  end;

var
  frmVerificaUpdate: TfrmVerificaUpdate;

implementation

uses Comandos;

{$R *.dfm}

procedure TfrmVerificaUpdate.AfterInstall;
var
  StrSQL : String;
begin
  MyCfgImovel.SetConfiguracao(tpImovEmManutencao, 'Y');
end;

procedure TfrmVerificaUpdate.BeforeInstall;
begin
  if FileExists(ExtractFilePath(Application.ExeName)+'Aquarios.aq') then
    DeleteFile(ExtractFilePath(Application.ExeName)+'Aquarios.aq');
end;

procedure TfrmVerificaUpdate.BitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmVerificaUpdate.btnInstalarClick(Sender: TObject);
begin
  inherited;
  CdsArquivos.First;
  pnlStatus.Visible := True;
  //Try
    Try
      pnlGeral.Enabled := False;
      BeforeInstall;
      while not CdsArquivos.Eof do
      Begin
        ProgressBar.Properties.Max := CdsArquivosTamanhoReal.AsInteger;
        FTP.Get(CdsArquivosEndereco.AsString,ExtractFilePath(Application.ExeName)+CdsArquivosNomeArquivo.AsString, True);
        UnZip.ClearZip;
        UnZip.ZipName := CdsArquivosNomeArquivo.AsString;
        UnZip.DestDir := ExtractFilePath(Application.ExeName);
        UnZip.RootDir := ExtractFilePath(Application.ExeName);
        UnZip.DoAll := True;
        UnZip.ReadZip;
        UnZip.UnZip;
        FTP.Rename(CdsArquivosNomeArquivo.AsString, CdsArquivosNomeArquivo.AsString+'.ok');
        DeleteFile(CdsArquivosNomeArquivo.AsString);
        CdsArquivos.Next;
      End;
      AfterInstall;
      Avisa('Terminado. Saia do sistema e entre novamente.');
      Application.Terminate;
    //Except
      //raise;
    //End;
  Finally
    pnlGeral.Enabled := True;
    pnlStatus.Visible := False;
  End;
end;

procedure TfrmVerificaUpdate.btnVerificarClick(Sender: TObject);
var
  ListaFile : TStringList;
  I: Integer;
  Tamanho : Currency;
  StrTamanho : AnsiString;
begin
  inherited;
  Try
    btnInstalar.Visible := False;
    pnlStatus.Visible := True;
    lblStatus.Caption := 'Verificando atualizações';
    ProgressBar.Position := 20;
    Application.ProcessMessages;
    ListaFile := TStringList.Create;
    Ftp.Disconnect;
    CdsArquivos.EmptyDataSet;
    Ftp.Host := 'ftp.hrm.kinghost.net';
    ftp.Username := 'hrm';
    ftp.Password := 'filipe';
    Ftp.Connect;
    ftp.ChangeDir('/www/download/Aquarios');
    ftp.List(ListaFile, '*.aq',True);
    if ListaFile.Count = 0  then
    Begin
      Avisa('Não foi encontrado nenhum arquivo.');
      Exit;
    End;
    lblStatus.Caption := 'Obtendo detalhes';
    ProgressBar.Position := 50;
    Application.ProcessMessages;
    for I := 0 to ListaFile.Count - 1 do
    Begin
      CdsArquivos.Append;
      CdsArquivosNomeArquivo.AsString :=Trim(Copy(ListaFile[i], 40,300));
      CdsArquivosEndereco.AsString := '/www/download/Aquarios/'+Copy(ListaFile[i], 40,300);
      StrTamanho := Trim(Copy(ListaFile[i], 18,22));
      Tamanho := StrToIntDef(StrTamanho, -1);
      CdsArquivosTamanhoReal.AsInteger := Round(Tamanho);
      Tamanho := (Tamanho / 1024) / 1024;
      CdsArquivosTamanho.AsInteger := Round(Tamanho);
      CdsArquivos.Post;
    End;
    btnInstalar.Visible := True;
    if Pergunta('Deseja instalar as atualizações?') then
       btnInstalarClick(nil);
  Finally
    pnlStatus.Visible := False;
    FreeAndNil(ListaFile);
  End;
end;

procedure TfrmVerificaUpdate.FTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  inherited;
  ProgressBar.Position :=AWorkCount;
  lblStatus.Caption := 'Baixando atualizações';
  Application.ProcessMessages;
end;

procedure TfrmVerificaUpdate.UnZipStartUnZip(Sender: TObject;
  FileIndex: Integer; var FName: string; var Skip: Boolean);
begin
  inherited;
  lblStatus.Caption := 'Instalando arquivo '+Fname;
  if ExtractFileName(Fname) = ExtractFileName(Application.ExeName) then
    RenameFile(Application.ExeName, ExtractFilePath(Application.ExeName)+FormatDateTime('dd-mm-yyyy_HH-nn', now)+'_'+ExtractFileName(Application.ExeName));
  Application.ProcessMessages;
end;

end.
