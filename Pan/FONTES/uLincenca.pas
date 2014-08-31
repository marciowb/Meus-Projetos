unit uLincenca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, JvComponentBase, JvComputerInfoEx,
  JvSerialMaker, Registry, JvWizard, JvExControls, ExtCtrls, IniFiles, cxPC,
  cxControls;

type
  TfrmLincenca = class(TForm)
    PageControl: TcxPageControl;
    tsBemVndo: TcxTabSheet;
    tsLicencas: TcxTabSheet;
    Computer: TJvComputerInfoEx;
    tsSerial: TcxTabSheet;
    tsFim: TcxTabSheet;
    Panel4: TPanel;
    grpLicenca: TRadioGroup;
    Panel2: TPanel;
    Label1: TLabel;
    edtSerial: TMaskEdit;
    edtString: TLabeledEdit;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Panel3: TPanel;
    btnVoltar: TBitBtn;
    btnAvancar: TBitBtn;
    btnCancelar: TBitBtn;
    Panel5: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAvancarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    Function VerificaTrial: Boolean;
  public
    { Public declarations }
    Procedure LicencaFull;
    Procedure LicencaTrial;
  end;

var
  frmLincenca: TfrmLincenca;

implementation

uses Comandos_Pan;

{$R *.dfm}

procedure TfrmLincenca.btnAvancarClick(Sender: TObject);
begin
  btnVoltar.Enabled := True;
  if PageControl.ActivePageIndex > 1 then
    if grpLicenca.ItemIndex < 0 then
    Begin
      AvisaErro('Selecione um tipo de licença.');
      PageControl.ActivePage := tsLicencas;
      grpLicenca.SetFocus;
      Exit;
    End;
  if (PageControl.ActivePage = tsLicencas) and (grpLicenca.ItemIndex = 0) then
  Begin
    PageControl.ActivePage := tsFim;
    btnAvancar.Caption := 'Finalizar';
    btnVoltar.Enabled := False;
    btnCancelar.Enabled := False;
    LicencaTrial;
    ModalResult := mrOk;
  End;
  if PageControl.ActivePage = tsSerial then
  Begin
    LicencaFull;
    ModalResult := mrOk;
  End;
  PageControl.ActivePageIndex := PageControl.ActivePageIndex + 1;
end;

procedure TfrmLincenca.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmLincenca.btnVoltarClick(Sender: TObject);
begin
  PageControl.ActivePageIndex := PageControl.ActivePageIndex - 1;
  btnVoltar.Enabled := PageControl.ActivePageIndex > 0;
end;

procedure TfrmLincenca.FormShow(Sender: TObject);
begin
  edtString.Text := GetNovoSerial;
  VerificaTrial;
  PageControl.HideTabs := True;
  PageControl.ActivePage := tsBemVndo;
end;

procedure TfrmLincenca.LicencaFull;
var
  Txt : TFileStream;
  Buffer : PChar ;
begin
 if  not VerificaSerial(edtSerial.Text) then
 Begin
   AvisaErro('Serial inválido. Entre em contato com o suporte. ');
   Abort;
 End else
 Begin
   Try
     if FileExists(Computer.Folders.System+'\XXX.t') then
        DeleteFile(Computer.Folders.System+'\XXX.t');
     Txt := TFileStream.Create(Computer.Folders.System+'\XXX.k', fmCreate);
     Buffer := StrAlloc(128);
     StrPCopy(Buffer, edtSerial.Text);
     Txt.Write(Buffer[0], StrLen(Buffer)); 
   Finally
     FreeAndNil(Txt);
   End;
 End;
  
end;

procedure TfrmLincenca.LicencaTrial;
var
  Arq : TIniFile;
  Filename : String ;
begin
   Filename := Computer.Folders.System+'\XXX.t';
   Arq := TIniFile.Create(Filename);
   Arq.WriteString('Datas', 'DataAtual', FormatDateTime('dd/mm/yyyy', now));
   Arq.WriteInteger('Trial', 'Conta', 0);
   Arq.Free;
   Avisa('Você está licenciado por 15 dias.');
end;

procedure TfrmLincenca.SpeedButton1Click(Sender: TObject);
begin
  edtString.SelectAll;
  edtString.CopyToClipboard;
end;

procedure TfrmLincenca.SpeedButton2Click(Sender: TObject);
begin
 edtSerial.PasteFromClipboard;
end;

function TfrmLincenca.VerificaTrial: Boolean;
var
  Arq : TIniFile;
  i : Integer;
begin
  if FileExists(Computer.Folders.System+'\XXX.t') then
  Begin
    Arq := TIniFile.Create(Computer.Folders.System+'\XXX.t');
    i := Arq.ReadInteger('Trial', 'Conta', 1) ;
    if  i >= 15 then
    Begin
       grpLicenca.ItemIndex := 1;
       grpLicenca.Enabled := False;

    End;
    FreeAndNil(Arq);
  End;
  
end;

end.
