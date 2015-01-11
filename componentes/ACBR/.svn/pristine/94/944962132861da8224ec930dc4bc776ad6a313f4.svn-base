{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                             }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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

{*******************************************************************************
|* Historico
|*
|* 19/03/2013: André Ferreira de Moraes
|*  - Versão inicial da classe ACBrCertificado
|* 20/03/2013: Rafael Batiati
|*  - Inclusão do comando SelecionarCertificado
*******************************************************************************}

{$I ACBr.inc}

unit ACBrCertificado;

interface

uses
  Classes, Windows, SysUtils, Variants,
  WinCrypt, ACBrUtil, ACBrDFeUtil, pcnLeitor,
  libxml2, libxslt, libxmlsec;

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


type

  TACBrCertificado = class
  private
    FCertContext: PCCERT_CONTEXT;
    FEmitidoPara: String;
    FEmitidoPor: String;
    FNomeAmigavel: String;
    FEmail: String;
    FValidoDe: TDateTime;
    FValidoAte: TDateTime;
    FNumeroSerial: String;
    FPrivateKey: String;
    FPublicKey: String;

    function GetDigestValue(const AXml: String): String;
    function GetSignatureValue(const AXml: String): String;
    function CreateSignedInfo(AXML : String): String;
    function CreateSignature(ASignedInfo: String): String;
    function CreateSecuredKeyInfo(ASignature: String): String;
    function AdicionarKeyInfo(Axml: String): String;
  public
    constructor Create(ACertContext: PCCERT_CONTEXT);
    destructor Destroy; override;
    function Assinar(const Axml: PAnsiChar) : String;
    function AssinarLibXML(const Axml: PAnsiChar) : String;

    property CertContext: PCCERT_CONTEXT read FCertContext;
    property EmitidoPara: String         read FEmitidoPara;
    property EmitidoPor: String          read FEmitidoPor;
    property NomeAmigavel: String        read FNomeAmigavel;
    property Email: String               read FEmail;
    property ValidoDe: TDateTime         read FValidoDe;
    property ValidoAte: TDateTime        read FValidoAte;
    property NumeroSerial: String        read FNumeroSerial;
  end;

  TACBrStore = class(TComponent)
  private
    FStore: HCERTSTORE;
    FStoreName: String;
    FCertificados: TList;

    function GetCount: Integer;
    function GetItem(Index: Integer): TACBrCertificado;
    procedure CarregaCertificados(hStore: HCERTSTORE);
    procedure InitXmlSec;
    procedure ShutDownXmlSec;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Add(Certificado: TACBrCertificado);
    procedure AbrirCertificados(const AStoreName: String);

    property Items[Index: Integer]: TACBrCertificado read GetItem; default;
    property Count: Integer                          read GetCount;

    function SelecionarCertificado: String;
  published
    property StoreName: String read FStoreName write FStoreName;
  end;

implementation

{Declarações das chamadas da libxmlsec-mscrypto.dll }
function xmlSecMSCryptoCertAdopt(pCert : PCCERT_CONTEXT; type_: xmlSecKeyDataType):xmlSecKeyDataPtr; cdecl; external 'libxmlsec-mscrypto.dll';
function xmlSecMSCryptoAppKeyLoadMemory(const data: xmlSecBytePtr; dataSize: xmlSecSize; format: xmlSecKeyDataFormat; const pwd: PAnsiChar; pwdCallback: Pointer; pwdCallbackCtx: Pointer) : xmlSecKeyPtr; cdecl; external 'libxmlsec-mscrypto.dll';
{Declarações das chamadas da cryptui.dll }
function CryptUIDlgSelectCertificateFromStore(hCertStore: HCERTSTORE; hwnd: HWND; pwszTitle, pwszDisplayString: LPCWSTR; dwDontUseColumn, dwFlags: DWORD; pvReserved: Pointer):PCCERT_CONTEXT; stdcall; external 'cryptui.dll';

function ByteArrayToStr(pbData: PByte; cbData: DWORD): String;
var
  I, J: Integer;
  S: String;
begin
  Result := '';
  if not Assigned(pbData) or (cbData <= 0) then
    Exit;
  for I := 0 to cbData - 1 do
  begin
    J := PByteArray(pbData)^[I];
    S := IntToHex(J, 2);
    if (I > 0) and (I and 1 = 0) then
      S := S + ' ';
    Result := S + Result;
  end;
end;

function BynaryToString( Valor : String ):String;
var
  chString : DWORD;
  szString : String;
begin
  chString := 0;
  szString := '';
  CryptBinaryToString(pointer(Valor), length(Valor), CRYPT_String_BASE64, nil, chString);
  SetLength(szString, chString-1);
  CryptBinaryToString(pointer(Valor), length(Valor), CRYPT_String_BASE64, PAnsiChar(szString), chString);
  Result := szString;
end;

{ TACBrCertificado }

//Baseado no exemplo disponível em http://www.clevercomponents.com/articles/article022/soapsecurity.asp
function TACBrCertificado.AdicionarKeyInfo(Axml: String): String;
var
  keyinfo, certValue, encodedCertValue : String;
begin
  SetLength(certValue, CertContext.cbCertEncoded);
  system.Move(CertContext.pbCertEncoded^, Pointer(certValue)^, CertContext.cbCertEncoded);

  encodedCertValue := BynaryToString(certValue);
  encodedCertValue := StringReplace( encodedCertValue, #10, '', [rfReplaceAll] ) ;
  encodedCertValue := StringReplace( encodedCertValue, #13, '', [rfReplaceAll] ) ;

  keyinfo :='<KeyInfo>'+
              '<X509Data>'+
                '<X509Certificate>'+encodedCertValue+'</X509Certificate>'+
              '</X509Data>'+
            '</KeyInfo>';

  Axml := StringReplace(Axml,'<KeyInfo/>',keyinfo,[rfIgnoreCase]);

  Result := Axml;
end;

function TACBrCertificado.Assinar(const Axml: PAnsiChar): String;
var
  signedInfo, signature, security, assinado : String;
begin
  Result := Axml;
  try
    signedInfo := CreateSignedInfo(Axml);
    signature := CreateSignature(signedInfo);
    security := CreateSecuredKeyInfo(signature);

    assinado := copy(Axml,1,Pos('</infNFe>',Axml)+length('/infNFe>'));
    assinado := assinado + security;
    assinado := assinado + copy(Axml,Pos('</NFe>',Axml),length(Axml));

  finally
  end;

  Result := assinado;
end;

function TACBrCertificado.AssinarLibXML(const Axml: PAnsiChar): String;
var
  doc: xmlDocPtr;
  node: xmlNodePtr;
  dsigCtx: xmlSecDSigCtxPtr;
  buffer: PAnsiChar;
  bufSize: integer;

  keyPriv: xmlSecKeyPtr;
  size : integer;
  keyName : PAnsiChar;
  erro : integer;

  hCryptProvider : HCRYPTPROV;
  FSenhaCert: AnsiString;

  arquivo: TextFile;
begin
    doc := nil;
    dsigCtx := nil;
    result := '';

    if (Axml = nil) then Exit;

    try
       { load template }
       doc := xmlParseDoc(Axml);
       if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
         raise Exception.Create('Error: unable to parse');

       { find start node }
       node := xmlSecFindNode(xmlDocGetRootElement(doc), PAnsiChar(xmlSecNodeSignature), PAnsiChar(xmlSecDSigNs));
       if (node = nil) then
         raise Exception.Create('Error: start node not found');

         FSenhaCert := '1234';

            try
               CryptSetProvParam( hCryptProvider , PP_SIGNATURE_PIN,  LPBYTE(FSenhaCert), 0 );
            finally
              CryptReleaseContext(hCryptProvider, 0);
            end;

       AssignFile(arquivo, 'c:\temp\cert.txt');
       Rewrite(arquivo);
       CloseFile(arquivo);

       AssignFile(arquivo, 'c:\temp\cert.txt');

       keyPriv := xmlSecKeyCreate;
       xmlSecKeySetValue(keyPriv,xmlSecMSCryptoCertAdopt(CertContext, $0002));

       xmlSecKeyDataBinaryValueDebugDump(keypriv.value,@arquivo);



       size := CertGetNameString(certContext, CERT_NAME_FRIENDLY_DISPLAY_TYPE, 0, nil,	nil,	0);
       GetMem(keyName,size);
       CertGetNameString(certContext, CERT_NAME_FRIENDLY_DISPLAY_TYPE, 0,	nil, keyName, size);

       if (xmlSecKeySetName(keyPriv, keyName) < 0) then
         raise Exception.Create('Error: failed to set key name for key from "' + keyName + '"');

       dsigCtx := xmlSecDSigCtxCreate(nil);
       if (dsigCtx = nil) then
         raise Exception.Create('Error :failed to create signature context');

       dsigCtx^.signKey := keyPriv;

       if (dsigCtx^.signKey = nil) then
          raise Exception.Create('Error: failed to load private pem key from "' + keyName + '"');

       { set key name to the file name, this is just an example! }
       if (xmlSecKeySetName(dsigCtx^.signKey, keyName) < 0) then
         raise Exception.Create('Error: failed to set key name for key from "' + keyName + '"');

       { sign the template }
       erro := xmlSecDSigCtxSign(dsigCtx, node);
       if ( erro < 0) then
         raise Exception.Create('Error: signature failed');

       buffer := nil;
       xmlDocDumpMemory(doc, @buffer, @bufSize);
       if (buffer <> nil) then
        begin
          result := AdicionarKeyInfo(buffer);
        end;
   finally
       { cleanup }
       if (dsigCtx <> nil) then
         xmlSecDSigCtxDestroy(dsigCtx);

       if (doc <> nil) then
         xmlFreeDoc(doc);

   end;
end;

constructor TACBrCertificado.Create(ACertContext: PCCERT_CONTEXT);
var
  Valor: array[0..255] of Char;
  chString: DWORD;
  szString: PWideChar;
  systemTime: TSystemTime;
begin
{  if not FunctionDetect( 'libxmlsec-mscrypto.dll', 'xmlSecMSCryptoCertAdopt', @xmlSecMSCryptoCertAdopt) then
   begin
     xmlSecMSCryptoCertAdopt := NIL ;
     raise Exception.Create( ACBrStr( 'Erro ao carregar a função xmlSecMSCryptoCertAdopt de: libxmlsec-mscrypto.dll' ) ) ;
   end ;

  if not FunctionDetect( 'libxmlsec-mscrypto.dll', 'xmlSecMSCryptoAppKeyLoadMemory', @xmlSecMSCryptoAppKeyLoadMemory) then
   begin
     xmlSecMSCryptoAppKeyLoadMemory := NIL ;
     raise Exception.Create( ACBrStr( 'Erro ao carregar a função xmlSecMSCryptoAppKeyLoadMemory de: libxmlsec-mscrypto.dll' ) ) ;
   end ;
 }
  FCertContext := CertDuplicateCertificateContext(ACertContext);
  CertGetNameString(CertContext, CERT_NAME_SIMPLE_DISPLAY_TYPE, 0, nil, Valor, 256);
  FEmitidoPara := Valor;
  CertGetNameString(CertContext, CERT_NAME_SIMPLE_DISPLAY_TYPE, CERT_NAME_ISSUER_FLAG, nil, Valor, 256);
  FEmitidoPor := Valor;

  chString := 0;
  CertGetCertificateContextProperty(CertContext, CERT_FRIENDLY_NAME_PROP_ID, nil, chString);
  GetMem(szString, chString);
  CertGetCertificateContextProperty(CertContext, CERT_FRIENDLY_NAME_PROP_ID, PAnsiChar(szString), chString);
  FNomeAmigavel := String(system.Copy(szString, 1, chString));

  CertGetNameString(CertContext, CERT_NAME_EMAIL_TYPE, 0, nil, Valor, 256);
  FEmail := Valor;

  FileTimeToSystemTime(CertContext.pCertInfo.NotBefore, systemTime);
  FValidoDe  := SystemTimeToDateTime(systemTime) ;
  FileTimeToSystemTime(CertContext.pCertInfo.NotAfter, systemTime);
  FValidoAte := SystemTimeToDateTime(systemTime) ;

  FNumeroSerial := RemoveString(' ',ByteArrayToStr(CertContext.pCertInfo.SerialNumber.pbData,CertContext.pCertInfo.SerialNumber.cbData));

  chString := 0;
  CertGetCertificateContextProperty(CertContext, CERT_KEY_PROV_INFO_PROP_ID, nil, chString);
  GetMem(szString, chString);
  CertGetCertificateContextProperty(CertContext, CERT_KEY_PROV_INFO_PROP_ID, PAnsiChar(szString), chString);
  FPrivateKey := String(system.Copy(szString, 1, chString));
  FPrivateKey := BynaryToString(FPrivateKey);
end;

function TACBrCertificado.CreateSecuredKeyInfo(ASignature: String): String;
var
  certValue, encodedCertValue : String;
begin
  try
    SetLength(certValue, CertContext.cbCertEncoded);
    system.Move(CertContext.pbCertEncoded^, Pointer(certValue)^, CertContext.cbCertEncoded);

    encodedCertValue := BynaryToString(certValue);
    encodedCertValue := StringReplace( encodedCertValue, #10, '', [rfReplaceAll] ) ;
    encodedCertValue := StringReplace( encodedCertValue, #13, '', [rfReplaceAll] ) ;

    ASignature := ASignature +
                '<KeyInfo>'+
                '<X509Data>'+
                  '<X509Certificate>'+encodedCertValue+'</X509Certificate>'+
                '</X509Data>'+
              '</KeyInfo>'+
            '</Signature>';
  finally
  end;
  Result := ASignature;
end;

function TACBrCertificado.CreateSignature(ASignedInfo: String): String;
var
  sigValue, encSigValue, Signature, SignatureOrig: String;
begin
  try
    ASignedInfo :=  '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">'+
                    ASignedInfo +
                    '<SignatureValue></SignatureValue>';

{   ASignedInfo := '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">'+
                  '<SignedInfo><CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>'+
                  '<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/>'+
                  '<Reference URI="#NFe35130302192772000106550010000001231000001239"><Transforms>'+
                  '<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>'+
                  '<Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/></Transforms>'+
                  '<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>'+
                  '<DigestValue>5pSYV581jBmjq8h93NC+T96NyNw=</DigestValue>'+
                  '</Reference></SignedInfo><SignatureValue></SignatureValue>';}

    sigValue := GetSignatureValue(ASignedInfo);

    encSigValue := trim(BynaryToString(sigValue));

    encSigValue := StringReplace( encSigValue, #10, '', [rfReplaceAll] ) ;
    encSigValue := StringReplace( encSigValue, #13, '', [rfReplaceAll] ) ;

    SignatureOrig := ASignedInfo;

    Signature := copy(SignatureOrig,1,Pos('<SignatureValue>',SignatureOrig)+length('SignatureValue>'));
    Signature := Signature + encSigValue;
    Signature := Signature + copy(SignatureOrig,Pos('</SignatureValue>',SignatureOrig),length(SignatureOrig));

    Result := Signature;

  finally

  end;
end;

function TACBrCertificado.CreateSignedInfo(AXML : String): String;
var
  Leitor: TLeitor;
  I, J: Integer;
  Tipo: Integer;
  data, SignedInfoOrig, SignedInfo: String;
  digestValue: String;
  URI: String;
begin
  Leitor := TLeitor.Create;
  try
    Leitor.Arquivo := AXML;
    Tipo := 1 ;//NotaUtil.IdentificaTipoSchema(AXML,I);

    I := DFeUtil.PosEx('Id=',AXML,6) ;
    if I = 0 then
       raise Exception.Create('Não encontrei inicio do URI: Id=') ;
    I := DFeUtil.PosEx('"',AXML,I+2) ;
    if I = 0 then
       raise Exception.Create('Não encontrei inicio do URI: aspas inicial') ;
    J := DFeUtil.PosEx('"',AXML,I+1) ;
    if J = 0 then
       raise Exception.Create('Não encontrei inicio do URI: aspas final') ;

    URI := copy(AXML,I+1,J-I-1) ;

    data := Leitor.rExtrai(1, 'infNFe')+'</infNFe>';
    if (data = '') then
      raise Exception.Create('XML Inválido');

    digestValue := trim(BynaryToString(GetDigestValue(data)))  ;

  //  digestValue := '5pSYV581jBmjq8h93NC+T96NyNw=';

    SignedInfoOrig := Leitor.rExtrai(1, 'SignedInfo')+'</SignedInfo>';

    SignedInfo := copy(SignedInfoOrig,1,Pos('<DigestValue>',SignedInfoOrig)+length('DigestValue>'));
    SignedInfo := SignedInfo + digestValue;
    SignedInfo := SignedInfo + copy(SignedInfoOrig,Pos('</DigestValue>',SignedInfoOrig),length(SignedInfoOrig));

    Result := SignedInfo;
  finally
    Leitor.Free;
  end;
end;

destructor TACBrCertificado.Destroy;
begin
  if FCertContext <> nil then
     CertFreeCertificateContext(FCertContext);
  inherited;
end;

{ TACBrStore }

procedure TACBrStore.Add(Certificado: TACBrCertificado);
begin
  FCertificados.Add(Certificado);
end;

procedure TACBrStore.CarregaCertificados(hStore: HCERTSTORE);
var
  CertContext: PCCERT_CONTEXT;
begin
  CertContext := nil;
  CertContext := CertEnumCertificatesInStore(hStore, CertContext);
  while CertContext <> nil do
   begin
     if (CertContext <> nil) then
      begin
        Add(TACBrCertificado.Create(CertContext));
      end;
     CertContext := CertEnumCertificatesInStore(hStore, CertContext);
   end;
end;

constructor TACBrStore.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InitXmlSec;
  FCertificados := TList.Create();
  FStoreName := '';

{  if not FunctionDetect( 'cryptui.dll', 'CryptUIDlgSelectCertificateFromStore', @xCryptUIDlgSelectCertificateFromStore) then
   begin
     xCryptUIDlgSelectCertificateFromStore := NIL ;
     raise Exception.Create( ACBrStr( 'Erro ao carregar a função CryptUIDlgSelectCertificateFromStore de: cryptui.dll' ) ) ;
   end ;}
end;

destructor TACBrStore.Destroy;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;

  FCertificados.Clear;

  if (FStore <> nil) then
  begin
    CertCloseStore(FStore, 0);
    FStore := nil;
  end;

  FCertificados.Free;
  ShutDownXmlSec;
  inherited Destroy;
end;

function TACBrStore.GetCount: Integer;
begin
  Result := FCertificados.Count;
end;

function TACBrStore.GetItem(Index: Integer): TACBrCertificado;
begin
  Result := TACBrCertificado(FCertificados[Index]);
end;

procedure TACBrStore.AbrirCertificados(const AStoreName: String);
begin
  FStoreName := AStoreName;
  FStore := CertOpenSystemStore(0, PChar(StoreName));
  if FStore <> nil then
    CarregaCertificados(FStore);
end;

function TACBrStore.SelecionarCertificado: String;
var
  hCtx: PCCERT_CONTEXT;
  Titulo, Pergunta : PWideChar;
begin
  if FStore = nil then
    raise Exception.Create( ACBrStr( 'Execute o comando AbrirCertificados' ) ) ;
    
  try
    begin
      Titulo   := PWideChar(WideString('Certificado(s) Digital(is) disponível(is)'));
      Pergunta := PWideChar(WideString('Selecione o Certificado Digital para uso no aplicativo'));
      hCtx := CryptUIDlgSelectCertificateFromStore(FStore, 0, Titulo, Pergunta, $000000010, 0, nil);

      if (Assigned(hCtx)) then
        Result := RemoveString(' ',ByteArrayToStr(hCtx^.pCertInfo^.serialNumber.pbData,hCtx^.pCertInfo^.serialNumber.cbData));
    end;
  finally
      if (Assigned(hCtx)) then
         CertFreeCertificateContext(hCtx);
  end;
end;

function TACBrCertificado.GetDigestValue(const AXml: String): String;
{var
   context: HCRYPTPROV;
   hash: HCRYPTHASH;
   data: PByte;
   hashSize, dwordSize: DWORD; 
begin 
   CryptAcquireContext(context, nil, nil, PROV_RSA_FULL, 0);
   try 
      CryptCreateHash(context, CALG_SHA1, 0, 0, hash);
      CryptHashData(hash, Pointer(AXml), Length(AXml), 0);
      dwordSize := SizeOf(DWORD); 
      CryptGetHashParam(hash, HP_HASHSIZE, @hashSize, dwordSize, 0);
      GetMem(data, hashSize);
      try
         CryptGetHashParam(hash, HP_HASHVAL, data, hashSize, 0);
         SetLength(Result, hashSize); 
         system.Move(data^, Pointer(Result)^, hashSize); 
      finally 
         FreeMem(data); 
         CryptDestroyHash(hash); 
      end; 
   finally 
      CryptReleaseContext(context, 0); 
   end; 
end;   }
var
  context: HCRYPTPROV;
  hash: HCRYPTHASH;
  hashSize, dwordSize: DWORD;
  keySpec: DWORD;
  callerFree: BOOL;
  szString: PByte;
begin
  if not CryptAcquireContext(context, nil, nil, PROV_RSA_FULL, 0) then
  begin
    if not CryptAcquireContext(context, nil, nil, PROV_RSA_FULL, CRYPT_NEWKEYSET) then
    begin
      raise Exception.Create('CryptAcquireContext');
    end;
  end;

{  if (not CryptAcquireCertificatePrivateKey(CertContext,
    CRYPT_ACQUIRE_COMPARE_KEY_FLAG, nil, context, keySpec, callerFree)) or (not callerFree) then
    raise Exception.Create('CryptAcquireCertificatePrivateKey');    }
  try
    if not CryptCreateHash(context, CALG_SHA1, 0, 0, hash) then
    begin
      raise Exception.Create('CryptCreateHash');
    end;

    try
      if not CryptHashData(hash, Pointer(AXml), Length(AXml), 0) then
      begin
        raise Exception.Create('CryptHashData');
      end;
      dwordSize := SizeOf(DWORD);
      if not CryptGetHashParam(hash, HP_HASHSIZE, @hashSize, dwordSize, 0) then
      begin
        raise Exception.Create('CryptGetHashParam');
      end;
      GetMem(szString, hashSize);
      if not CryptGetHashParam(hash, HP_HASHVAL, szString, hashSize, 0) then
      begin
        raise Exception.Create('CryptGetHashParam');
      end;
      SetLength(Result, hashSize);
      system.Move(szString^, Pointer(Result)^, hashSize);
    finally
      CryptDestroyHash(hash);
    end;
  finally
    CryptReleaseContext(context, 0);
  end;
end;

function TACBrCertificado.GetSignatureValue(const AXml: String): String;
{var
   xmlData, signature: PByte; data: array[0..0] of PByte;
   msgCert: array[0..0] of PCCERT_CONTEXT;
   dwDataSizeArray: array[0..0] of DWORD; 
   sigParams: CRYPT_SIGN_MESSAGE_PARA; 
   cbSignedBlob: DWORD; 
begin 
   GetMem(xmlData, Length(AXml));
   try 
      system.Move(Pointer(AXml)^, xmlData^, Length(AXml)); 
      ZeroMemory(@sigParams, SizeOf(CRYPT_SIGN_MESSAGE_PARA)); 
      sigParams.cbSize := SizeOf(CRYPT_SIGN_MESSAGE_PARA); 
      sigParams.dwMsgEncodingType := (X509_ASN_ENCODING or PKCS_7_ASN_ENCODING); 
      sigParams.pSigningCert := certContext; 
      sigParams.HashAlgorithm.pszObjId := szOID_RSA_MD5;
      data[0] := xmlData; 
      dwDataSizeArray[0] := Length(AXml); 
      cbSignedBlob := 0; 

      CryptSignMessage(@sigParams, True, 1, @data[0], @dwDataSizeArray[0], nil, cbSignedBlob);

      GetMem(signature, cbSignedBlob);
      try 
         CryptSignMessage(@sigParams, True, 1, @data[0], @dwDataSizeArray[0], signature, cbSignedBlob); 
         SetLength(Result, cbSignedBlob); 
         system.Move(signature^, Pointer(Result)^, cbSignedBlob); 
      finally 
         FreeMem(signature); 
      end; 
   finally 
      FreeMem(xmlData); 
   end;
end; }
var
  context: HCRYPTPROV;
  hash: HCRYPTHASH;
  sigSize, keySpec: DWORD;
  callerFree: BOOL;
  szString: PByte;
begin
  if (not CryptAcquireCertificatePrivateKey(CertContext,
    CRYPT_ACQUIRE_COMPARE_KEY_FLAG, nil, context, keySpec, callerFree)) or (not callerFree) then
    raise Exception.Create('CryptAcquireCertificatePrivateKey');

  try
    if not CryptCreateHash(context, CALG_SHA1, 0, 0, hash) then
      raise Exception.Create('CryptCreateHash');

    try
      if not CryptHashData(hash, Pointer(AXml), Length(AXml), 0) then
        raise Exception.Create('CryptHashData');

      if not CryptSignHash(hash, AT_KEYEXCHANGE, nil, 0, nil, sigSize) then
        raise Exception.Create('CryptSignHash');

      GetMem(szString, sigSize);
      if not CryptSignHash(hash, AT_KEYEXCHANGE, nil, 0, szString, sigSize) then
        raise Exception.Create('CryptSignHash');

      SetLength(Result, sigSize);
      system.Move(szString^, Pointer(Result)^, sigSize);
    finally
      CryptDestroyHash(hash);
    end;
  finally
    CryptReleaseContext(context, 0);
  end;
end;

procedure TACBrStore.InitXmlSec;
begin
    { Init libxml and libxslt libraries }
    xmlInitParser();
    __xmlLoadExtDtdDefaultValue^ := XML_DETECT_IDS or XML_COMPLETE_ATTRS;
    xmlSubstituteEntitiesDefault(1);
    __xmlIndentTreeOutput^ := 1;

    { Init xmlsec library }
    if (xmlSecInit() < 0) then
       raise Exception.Create('Error: xmlsec initialization failed.');

    { Check loaded library version }
{    if (xmlSecCheckVersionExt(1, 2, 8, xmlSecCheckVersionABICompatible) <> 1) then
       raise Exception.Create('Error: loaded xmlsec library version is not compatible.');    }

    (* Load default crypto engine if we are supporting dynamic
     * loading for xmlsec-crypto libraries. Use the crypto library
     * name ("openssl", "nss", etc.) to load corresponding
     * xmlsec-crypto library.
     *)
    if (xmlSecCryptoDLLoadLibrary('mscrypto') < 0) then
       raise Exception.Create( 'Error: unable to load default xmlsec-crypto library. Make sure'#10 +
                          			'that you have it installed and check shared libraries path'#10 +
                          			'(LD_LIBRARY_PATH) environment variable.');

{    if (xmlSecCryptoDLLoadLibrary('openssl') < 0) then
       raise Exception.Create( 'Error: unable to load default xmlsec-crypto library. Make sure'#10 +
                          			'that you have it installed and check shared libraries path'#10 +
                          			'(LD_LIBRARY_PATH) environment variable.');    }

    { Init crypto library }
    if (xmlSecCryptoAppInit(nil) < 0) then
       raise Exception.Create('Error: crypto initialization failed.');

    { Init xmlsec-crypto library }
    if (xmlSecCryptoInit() < 0) then
       raise Exception.Create('Error: xmlsec-crypto initialization failed.');
end;

procedure TACBrStore.ShutDownXmlSec;
begin
    { Shutdown xmlsec-crypto library }
    xmlSecCryptoShutdown();

    { Shutdown crypto library }
    xmlSecCryptoAppShutdown();

    { Shutdown xmlsec library }
    xmlSecShutdown();

    { Shutdown libxslt/libxml }
    xsltCleanupGlobals();
    xmlCleanupParser();
end;

end.
