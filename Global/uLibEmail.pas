unit uLibEmail;

interface
   uses SysUtils, Classes, WideStrings, IdPOP3, IdMessageClient,
        IdSMTPBase, IdSMTP, IdMessage, IdExplicitTLSClientServerBase,
        IdAttachment, IdAttachmentFile;
   Type
     TTipoCriptografia = (tcNone, tcSSl, tcTLS);
     TEmail = Class
    private
      FPortaEntrada: Integer;
      FServidorEntrada: String;
      FSenha: String;
      FPortaSaida: Integer;
      FUserName: String;
      FServidorSaida: String;
      FUsarSSL: Boolean;
      FTipoCriptografia: TTipoCriptografia;
      FNomeExibicao: String;
      FEmail: String;
      FComCopia: TStringList;
      FPara: TStringList;
      FAnexos: TStringList;
      FMensagem: TWideStringList;
    FAssunto: String;
      procedure SetUsarSSL(const Value: Boolean);
      procedure SetTipoCriptografia(const Value: TTipoCriptografia);
      procedure SetEmail(const Value: String);
     public
       constructor Create;
       Procedure Enviar;
     published
       property Email: String read FEmail write SetEmail;
       property UserName: String read FUserName write FUserName;
       property Senha: String read FSenha write FSenha;
       property ServidorEntrada: String read FServidorEntrada write FServidorEntrada;
       property ServidorSaida : String read FServidorSaida write FServidorSaida;
       property PortaEntrada: Integer read FPortaEntrada write FPortaEntrada default 110;
       property PortaSaida : Integer read FPortaSaida  write FPortaSaida default 25;
       property UsarSSL : Boolean read FUsarSSL write SetUsarSSL;
       property TipoCriptografia: TTipoCriptografia read FTipoCriptografia write SetTipoCriptografia;
       property NomeExibicao: String read FNomeExibicao write FNomeExibicao;
       property Para: TStringList read FPara write FPara;
       property ComCopia: TStringList read FComCopia write FComCopia;
       property Anexos: TStringList read FAnexos write FAnexos;
       property Mensagem : TWideStringList read FMensagem write FMensagem;
       property Assunto : String read FAssunto write FAssunto;
     End;
implementation

{ TEmail }

constructor TEmail.Create;
begin
  FComCopia := TStringList.Create;
  FPara := TStringList.Create;
  FAnexos := TStringList.Create;
  FMensagem := TWideStringList.Create;

end;

procedure TEmail.Enviar;
var
  CorpoMsg: TIdMessage;
  SMTP: TIdSMTP;
  POP: TIdPOP3;
  I: Integer;
begin
  Try
    CorpoMsg := TIdMessage.Create(nil);
    SMTP := TIdSMTP.Create(nil);
    SMTP.Host := ServidorSaida;
    SMTP.Password := Senha;
    SMTP.Username := Self.UserName;
    SMTP.Port := PortaSaida;
    SMTP.AuthType := satDefault;
    SMTP.HeloName := NomeExibicao;      
    case TipoCriptografia of
      tcNone:
        SMTP.UseTLS := utNoTLSSupport;
      tcSSl:
        SMTP.UseTLS := utUseRequireTLS;
      tcTLS:
        SMTP.UseTLS := utUseImplicitTLS;
    end;
    try
      SMTP.Connect;
      CorpoMsg.Body.Text := Mensagem.Text;
      CorpoMsg.CCList.Assign(ComCopia);
      CorpoMsg.From.Text := Email;
      CorpoMsg.Date := now;
      CorpoMsg.Subject := Assunto;
      CorpoMsg.Recipients.EMailAddresses := Para.Text;
      if Anexos.Count <= 0 then
         CorpoMsg.MessageParts.Clear
      else   
        for I := 0 to Anexos.Count - 1 do
        Begin
          if FileExists(Anexos.Strings[i]) then
            TIdAttachmentFile.Create(CorpoMsg.MessageParts, Anexos.Strings[i]);
        End;
     SMTP.Send(CorpoMsg);
     
    except
      on E: Exception do
      Begin
        raise;
      End;
    end;


  Finally
    FreeAndNil(CorpoMsg);
    FreeAndNil(SMTP);
  End;
end;

procedure TEmail.SetEmail(const Value: String);
begin
  FEmail := Value;
  if FUserName =  '' then
    FUserName := FEmail;
end;

procedure TEmail.SetTipoCriptografia(const Value: TTipoCriptografia);
begin
  FTipoCriptografia := Value;
end;

procedure TEmail.SetUsarSSL(const Value: Boolean);
begin
  FUsarSSL := Value;
  FPortaEntrada := 995;
end;

end.
