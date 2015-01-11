{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Classe para Lazarus/Free Pascal e Delphi para requisições SOAP com suporte  }
{ certificados A1 e A3 usando as bibliotecas WinINet e CAPICOM                 }
{                                                                              }
{ Direitos Autorais Reservados (c) 2014 Jean Patrick Figueiredo dos Santos     }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                       Juliomar Marchetti                     }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 15/01/2014: Jean Patrick Figueiredo dos Santos
|*  - Contribuição da classe para o Projeto ACBr
******************************************************************************}

{$I ACBr.inc}

unit ACBrHTTPReqResp;

interface

uses
  Windows, Classes, SysUtils, wininet, Dialogs, ACBrCAPICOM_TLB;

type

  { TACBrHTTPReqResp }

  TACBrHTTPReqResp = class
  private
    FCertificate      : ICertificate2;
    FCertSerialNumber : AnsiString;
    FCertStoreName    : AnsiString;
    FSOAPAction       : AnsiString;
    FMimeType         : AnsiString; // (ex.: 'application/soap+xml' ou 'text/xml' - que é o Content-Type)
    FCharsets         : AnsiString; //  (ex.: 'ISO-8859-1,utf-8' - que é o Accept-Charset)
    FData             : AnsiString;
    FProxyHost        : AnsiString;
    FProxyPass        : AnsiString;
    FProxyPort        : AnsiString;
    FProxyUser        : AnsiString;
    FUrl              : AnsiString;
    FUseCertificate   : Boolean;
    FShowCertStore    : Boolean;
    FUseSSL           : Boolean;

    function GetWinInetError(ErrorCode:Cardinal): AnsiString;
    function OpenCertStore: AnsiString;

  protected

  public
    property SOAPAction     : AnsiString        read FSOAPAction     write FSOAPAction;
    property MimeType       : AnsiString        read FMimeType       write FMimeType;
    property Charsets       : AnsiString        read FCharsets       write FCharsets;
    property Url            : AnsiString        read FUrl            write FUrl;
    property Data           : AnsiString        read FData           write FData;
    property ProxyHost      : AnsiString        read FProxyHost      write FProxyHost;
    property ProxyPort      : AnsiString        read FProxyPort      write FProxyPort;
    property ProxyUser      : AnsiString        read FProxyUser      write FProxyUser;
    property ProxyPass      : AnsiString        read FProxyPass      write FProxyPass;
    property CertStoreName  : AnsiString        read FCertStoreName  write FCertStoreName;
    property UseCertificate : Boolean       read FUseCertificate write FUseCertificate;
    property UseSSL         : Boolean       read FUseSSL         write FUseSSL;
    property ShowCertStore  : Boolean       read FShowCertStore  write FShowCertStore;

    procedure SetCertificate (pCertSerialNumber: String); overload;
    procedure SetCertificate (pCertificate: ICertificate2); overload;
    function Execute: {$IFDEF FPC} String {$ELSE} AnsiString {$ENDIF};
    constructor Create;
end;

  {$EXTERNALSYM CERT_CONTEXT}
  _CERT_CONTEXT = record
    dwCertEncodingType: LongWord;
    pbCertEncoded: ^Byte;
    cbCertEncoded: LongWord;
    pCertInfo: Pointer;
    hCertStore: Pointer;
  end;

  {$EXTERNALSYM _CERT_CONTEXT}
  CERT_CONTEXT = _CERT_CONTEXT;

implementation

uses synautil, StrUtils;

{ TACBrHTTPReqResp }

function  TACBrHTTPReqResp.GetWinInetError(ErrorCode:Cardinal): AnsiString;
const
   winetdll = 'wininet.dll';
var
  Len: Integer;
  Buffer: PAnsiChar;
begin
  Len := FormatMessage(
  FORMAT_MESSAGE_FROM_HMODULE or FORMAT_MESSAGE_FROM_SYSTEM or
  FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_IGNORE_INSERTS or  FORMAT_MESSAGE_ARGUMENT_ARRAY,
  Pointer(GetModuleHandle(winetdll)), ErrorCode, 0, @Buffer, SizeOf(Buffer), nil);
  try
    while (Len > 0) and {$IFDEF UNICODE}{$IFDEF FPC} (Buffer[Len - 1] in [#0..#32, '.'])
      {$ELSE} (CharInSet(Buffer[Len - 1], [#0..#32, '.'])) {$ENDIF}
      {$ELSE}(Buffer[Len - 1] in [#0..#32, '.']) {$ENDIF} do Dec(Len);
    SetString(Result, Buffer, Len);
  finally
    LocalFree(HLOCAL(Buffer));
  end;
end;

function TACBrHTTPReqResp.OpenCertStore: AnsiString;
var
  Store: IStore3;
  Certs: ICertificates2;
  Certs2: ICertificates2;
  Cert: ICertificate2;
  FNumeroSerie: WideString;
begin
  Store := CoStore.Create;
  try
    Store.Open(CAPICOM_CURRENT_USER_STORE, FCertStoreName, CAPICOM_STORE_OPEN_READ_ONLY);

    Certs := Store.Certificates as ICertificates2;

    {$IFDEF FPC}
    Certs2 := Certs.Select(AnsiToUtf8('Certificado(s) Digital(is) disponível(is)'),
    {$ELSE}
    Certs2 := Certs.Select('Certificado(s) Digital(is) disponível(is)',
    {$ENDIF}
      'Selecione o Certificado Digital para uso no aplicativo', False);

    if not (Certs2.Count = 0) then
    begin
      Cert := IInterface(Certs2.Item[1]) as ICertificate2;
      FNumeroSerie := Cert.SerialNumber;
    end;
  finally
    FreeAndNil(Store);
  end;

  Result := FNumeroSerie;
end;

procedure TACBrHTTPReqResp.SetCertificate(pCertSerialNumber: String);
begin
  if FCertSerialNumber = pCertSerialNumber then Exit;
  FCertSerialNumber := pCertSerialNumber;
  FCertificate := nil;
end;

procedure TACBrHTTPReqResp.SetCertificate(pCertificate: ICertificate2);
begin
  if FCertificate = pCertificate then Exit;
  FCertificate := pCertificate;
  FCertSerialNumber := '';
end;

function TACBrHTTPReqResp.Execute: {$IFDEF FPC} String {$ELSE} AnsiString {$ENDIF};
var
  aBuffer: array[0..4096] of AnsiChar;
  Header: TStringStream;
  BufStream: TMemoryStream;
  BytesRead: cardinal;
  pSession: HINTERNET;
  pConnection: HINTERNET;
  pRequest: HINTERNET;
  flags: LongWord;

  Store: IStore;
  Certs: ICertificates;
  Cert: ICertificate2;
  Cert2: ICertificate2;
  CertContext: ICertContext;
  PCertContext: Pointer;

  port, i, AccessType, ErrorCode, PosError: integer;
  ANone, AHost, APage, pProxy, ErrorMsg: String;
begin

  if (FUseCertificate) then FUseSSL := True;

  ParseURL(FUrl, ANone, ANone, ANone, AHost, ANone, APage, ANone);

  if ((ShowCertStore) or ((FCertSerialNumber = '') and (FCertificate = nil))) then
  begin
    FCertSerialNumber := OpenCertStore;
    if FCertSerialNumber <> '' then
      FCertificate := nil;
  end;

  if FCertSerialNumber <> '' then
  begin
    Store := CoStore.Create;
		Store.Open(CAPICOM_CURRENT_USER_STORE, FCertStoreName, CAPICOM_STORE_OPEN_READ_ONLY);

		Certs := Store.Certificates as ICertificates2;

		if Certs.Count > 0 then
		begin

		  for i := 1 to Certs.Count do
		  begin
			Cert2 := IInterface(Certs.Item[i]) as ICertificate2;
			if Cert2.SerialNumber = FCertSerialNumber then
			begin
			  Cert := Cert2;
			  break;
			end;
		  end;

		  CertContext := Cert as ICertContext;
		  CertContext.Get_CertContext(integer(PCertContext));
		end;
  end
  else
  begin
    CertContext := FCertificate as ICertContext;
    CertContext.Get_CertContext(integer(PCertContext));
  end;

  Result := '';

  if FProxyHost <> '' then
  begin
    AccessType := INTERNET_OPEN_TYPE_PROXY;
    if (FProxyPort <> '') and (FProxyPort <> '0') then
      pProxy := FProxyHost + ':' + FProxyPort
    else
      pProxy := FProxyHost;
  end
  else
    AccessType := INTERNET_OPEN_TYPE_PRECONFIG;

  pSession := InternetOpen(PChar('Borland SOAP 1.2'), AccessType, PChar(pProxy), nil, 0);

  if not Assigned(pSession) then
    raise Exception.Create('Erro: Internet Open or Proxy')
  else
    try

      if (FUseSSL) then
        Port := INTERNET_DEFAULT_HTTPS_PORT
      else
        Port := INTERNET_DEFAULT_HTTP_PORT;

      pConnection := InternetConnect(pSession, PChar(AHost), Port,
        nil, nil, INTERNET_SERVICE_HTTP, 0, 0);

      if not Assigned(pConnection) then
        raise Exception.Create('Erro: Internet Connect or Host')
      else
        try

          if (FUseSSL) then
          begin
            flags := INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_NO_CACHE_WRITE;
            flags := flags or INTERNET_FLAG_SECURE;

            if (FUseCertificate) then
              flags := flags or (INTERNET_FLAG_IGNORE_CERT_CN_INVALID or
                INTERNET_FLAG_IGNORE_CERT_DATE_INVALID);
          end
          else
            flags := INTERNET_SERVICE_HTTP;

          pRequest := HttpOpenRequest(pConnection, PChar('POST'),
            PChar(APage), nil, nil, nil, flags, 0);

          if not Assigned(pRequest) then
            raise Exception.Create('Erro: Open Request')
          else
            try
              Header := TStringStream.Create('');
              try

                with Header do
                begin
                  WriteString('Host: ' + AHost + sLineBreak);
                  WriteString('Content-Type: ' + FMimeType + SLineBreak);
                  WriteString('Accept-Charset: ' + FCharsets + SLineBreak);
                  WriteString('SOAPAction: "' + FSOAPAction + '"' + SLineBreak);
                  WriteString(SLineBreak);
                end;

                if (FUseCertificate) then
                  if not InternetSetOption(pRequest, 84 {INTERNET_OPTION_CLIENT_CERT_CONTEXT},
                    PCertContext, SizeOf(CERT_CONTEXT)) then
                      raise Exception.Create('Erro: Problema ao inserir o certificado');

                if trim(FProxyUser) <> '' then
                  if not InternetSetOption(pRequest, INTERNET_OPTION_PROXY_USERNAME,
                    PAnsiChar(FProxyUser), Length(FProxyUser)) then
                      raise Exception.Create('Erro: Proxy User');

                if trim(FProxyPass) <> '' then
                  if not InternetSetOption(pRequest, INTERNET_OPTION_PROXY_PASSWORD,
                    PAnsiChar(FProxyPass), Length(FProxyPass)) then
                      raise Exception.Create('Erro: Proxy Password');


                HttpAddRequestHeaders(pRequest, PChar(Header.DataString),
                  Length(Header.DataString), HTTP_ADDREQ_FLAG_ADD);

             {   try
                   HTTPSendRequest(pRequest, nil, 0, Pointer(FData), Length(FData));
                except on E: Exception do
                   raise Exception.Create('Erro: '+E.Message);
                end;   }

                if HttpSendRequest(pRequest, nil, 0, Pointer(FData), Length(FData)) then
                 begin
                   BufStream := TMemoryStream.Create;
                   try
                     while InternetReadFile(pRequest, @aBuffer,
                         SizeOf(aBuffer), BytesRead) do
                      begin
                        if (BytesRead = 0) then
                          Break;
                        BufStream.Write(aBuffer, BytesRead);
                      end;

                     aBuffer[0] := #0;
                     BufStream.Write(aBuffer, 1);
                     Result := {$IFDEF FPC} AnsiToUtf8(PChar(BufStream.Memory)) {$ELSE} PAnsiChar(BufStream.Memory) {$ENDIF};
                     if Result = '' then
                      begin
                        ErrorCode := GetLastError;
                        {$IFDEF FPC}
                        raise Exception.Create(AnsiToUtf8('Erro: Requisição não enviada.'+sLineBreak+IntToStr(ErrorCode)+' - '+GetWinInetError(ErrorCode)));
                        {$ELSE}
                        raise Exception.Create('Erro: Requisição não enviada.'+sLineBreak+IntToStr(ErrorCode)+' - '+GetWinInetError(ErrorCode));
                        {$ENDIF}
                      end
                     else if Pos('<TITLE',UpperCase(Result)) > 0 then
                      begin
                        PosError := Pos('<TITLE>',UpperCase(Result))+7;
                        ErrorMsg := trim(copy(Result, PosError, (pos('</TITLE>', UpperCase(Result)) - PosError)));
                        {$IFDEF FPC}
                        raise Exception.Create(AnsiToUtf8('Erro: Requisição não enviada.'+sLineBreak+ErrorMsg));
                        {$ELSE}
                        raise Exception.Create('Erro: Requisição não enviada.'+sLineBreak+ErrorMsg);
                        {$ENDIF}
                      end;
                   finally
                     BufStream.Free;
                   end;
                 end
                else
                 begin
                    ErrorCode := GetLastError;
                    {$IFDEF FPC}
                    raise Exception.Create(AnsiToUtf8('Erro: Requisição não enviada.'+sLineBreak+IntToStr(ErrorCode)+' - '+GetWinInetError(ErrorCode)));
                    {$ELSE}
                    raise Exception.Create('Erro: Requisição não enviada.'+sLineBreak+IntToStr(ErrorCode)+' - '+GetWinInetError(ErrorCode));
                    {$ENDIF}
                 end;
              finally
                Header.Free;
              end;
            finally
              InternetCloseHandle(pRequest);
            end;
        finally
          InternetCloseHandle(pConnection);
        end;
    finally
      InternetCloseHandle(pSession);
    end;
end;

constructor TACBrHTTPReqResp.Create;
begin
  FMimeType         := 'application/soap+xml';
  FCharsets         := 'utf-8';
  FCertStoreName    := 'My';
  FCertSerialNumber := '';
  FCertificate      := nil;
  FUseCertificate   := True;
  FUseSSL           := True;
  FShowCertStore    := False;
end;

end.

