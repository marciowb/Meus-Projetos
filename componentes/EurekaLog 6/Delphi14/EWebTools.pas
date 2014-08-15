{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{          Web Tools Unit - EWebTools            }
{                                                }
{  Copyright (c) 2001 - 2008 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EWebTools;

{$I Exceptions.inc}

{.$DEFINE DEBUG_MODE}
{.$DEFINE DEBUG_DETAILS}

interface

uses Windows, SysUtils, Classes;

const
  Error_NetLibNotFound = -1;
  GenericNetError = $7FFFFFFF;
  WinInetLib = 'wininet.dll';

type
  HINTERNET = Pointer;
  INTERNET_PORT = Word;
  LPSTR = PAnsiChar;
  PLPSTR = ^LPSTR;

  TConnectionType = (ctConnection, ctConnected, ctSending);

  TSendResult = (srOK, srBugClosed, srUnknownError, srInvalidLogin,
    srInvalidSelection, srInvalidSearch, srInvalidInsert, srInvalidModify);

  TInternetProgressFunction = procedure(ConnectionType: TConnectionType;
    TotalSize, BytesSent: DWord);

  TProxyRecord = packed record
    Server: AnsiString;
    Port: Word;
    UserName, Password: AnsiString;
  end;
  PProxyRecord = ^TProxyRecord;

  THTTPResponse = class
  public
    StatusCode: Integer;
    StatusText: AnsiString;
    Header: AnsiString;
    HTML: AnsiString;
    ReplayPage: AnsiString;
    ErrorCode: Integer;
    ErrorMessage: AnsiString;

    procedure Assign(Source: THTTPResponse); virtual;
    procedure Clear; virtual;
  end;

  TSendState = (
    ssConnecting, ssConnected, ssLogin, ssSelectProject,
    ssSearching, ssModifying, ssSending, ssSent,
    ssDisconnecting, ssDisconnected);

  TRequestMethod = (rmGET, rmPOST, rmBinaryPOST);

  THTTPConnectionBase = class
  private
    hInternet, hConnect: HINTERNET;
    BasePath: AnsiString;
    FResponse: THTTPResponse;
{$IFDEF DEBUG_MODE}
    procedure OpenResponseHTMLPage;
{$ENDIF}
  protected
    function Open: Boolean; virtual;
    function Close: Boolean; virtual;
    function GetBugCountField(const FieldName: AnsiString): Boolean;
    procedure AddSearchText(const FieldName, AVersion, AExceptionType, ABugID: AnsiString);
    procedure AddBugSummary(const FieldName, AVersion, AExceptionType, ABugID: AnsiString);
  public
    Host: AnsiString;
    Port: Word;
    Path: AnsiString;
    UseHTTPS: Boolean;
    UserName, Password: AnsiString;
    RequestMethod: TRequestMethod;
    Files, Fields: TStrings;
    UseProxy: Boolean;
    ProxySetting: TProxyRecord;

    constructor Create(const URL, Proxy: AnsiString);
    destructor Destroy; override;

    procedure SetRequest(const AWebPage: AnsiString; AMethod: TRequestMethod);
    procedure AddField(const FieldName, FieldValue: AnsiString);
    procedure AddFieldValue(const FieldName: AnsiString);
    procedure AddFieldByTextArea(const FieldName: AnsiString);
    procedure AddFieldByDefaultList(const ListName: AnsiString);
    procedure AddFieldByDefaultList2(const ListName: AnsiString);
    procedure AddFieldByListTitle(const ListName, FieldTitle: AnsiString);
    procedure AddCustomFields(CustomFields: TStrings);
    function AddOptionalField(const Source, Field: AnsiString): AnsiString;

    function IsSuccessfulSend(const ReplyPage, HTMLIncludeCode, HTMLExcludeCode: AnsiString): Boolean;

    function SendRequest(var Response: THTTPResponse; UpdateStatus: Boolean): Boolean;
    procedure SetSendState(ASendState: TSendState; APercent: Integer); virtual; abstract;
  end;

  THTTPConnectionClass = class of THTTPConnectionBase;

  THTTPSendReport = class
  protected
    FHTTPConnectionClass: THTTPConnectionClass;
  public
    constructor Create;
    procedure SetHTTPConnectionClass(ClassType: THTTPConnectionClass);
    function PostBug(const AVersion, ABugType, ABugText, ABugID, ABaseURL, AProxyURL,
      AUserName, APassword, AProjectName, ACategory, AAssignTo, AAttachedFile: AnsiString;
      ACustomFields: TStrings; var Response: THTTPResponse): TSendResult; virtual; abstract;
  end;

  THTTPSendReportClass = class of THTTPSendReport;

  THTTPMantisSendReport = class(THTTPSendReport)
    function PostBug(const AVersion, ABugType, ABugText, ABugID, ABaseURL, AProxyURL,
      AUserName, APassword, AProjectName, ACategory, AAssignTo, AAttachedFile: AnsiString;
      ACustomFields: TStrings; var Response: THTTPResponse): TSendResult; override;
  end;

  THTTPBugzillaSendReport = class(THTTPSendReport)
    function PostBug(const AVersion, ABugType, ABugText, ABugID, ABaseURL, AProxyURL,
      AUserName, APassword, AProjectName, ACategory, AAssignTo, AAttachedFile: AnsiString;
      ACustomFields: TStrings; var Response: THTTPResponse): TSendResult; override;
  end;

  THTTPFogBugzSendReport = class(THTTPSendReport)
    function PostBug(const AVersion, ABugType, ABugText, ABugID, ABaseURL, AProxyURL,
      AUserName, APassword, AProjectName, ACategory, AAssignTo, AAttachedFile: AnsiString;
      ACustomFields: TStrings; var Response: THTTPResponse): TSendResult; override;
  end;

procedure SetFTPPassiveMode(Activate: Boolean);
procedure SetProxyServer(const Server: AnsiString; Port: Word);
procedure SetProxyAuthenticationData(const UserID, Password: AnsiString);
function ElaborateURL(URL: AnsiString; var Protocol, UserID, Password, Host,
  Path: AnsiString; var Port: Word): Boolean;
procedure AddAuthenticationToURL(var URL: AnsiString; const User, Password: AnsiString; Port: Word);
function CheckInternetConnection: Boolean;
function HTTPUploadFiles(const Host, Path, UserID, Password: AnsiString;
  Port: Word; HTTPS: Boolean; LocalFiles, RemoteFiles, WebFields: TStrings;
  ProgressProc: TInternetProgressFunction; var ResultMsg: AnsiString): Integer;
function FTPUploadFiles(const Host, Path, UserID, Password: AnsiString;
  Port: Word; LocalFiles, RemoteFiles: TStrings;
  ProgressProc: TInternetProgressFunction; var ResultMsg: AnsiString): Integer;
function GetHTMLPage(const URL: AnsiString; var HTML: AnsiString): Boolean;
function SendWebTrakerReport(HTTPConnectionClass: THTTPConnectionClass;
  BugSenderClass: THTTPSendReportClass; const AVersion, ABugType, ABugText,
  ABugID, ABaseURL, AProxyURL, AUserName, APassword, AProjectName, ACategory,
  AAssignTo, AAttachedFile: AnsiString; ACustomFields: TStrings;
  var Response: THTTPResponse): TSendResult;

implementation

uses
  ECore, EBase64 {$IFDEF DEBUG_MODE} ,ShellAPI {$ENDIF};

const
  BufferSize = 4096;

  MaxBugOccurrences: Integer = 9999;
  MaxBugOccurrencesLen = 0;

const
  INTERNET_OPEN_TYPE_PRECONFIG           = 0;         // use registry configuration
  INTERNET_OPEN_TYPE_DIRECT              = 1;         // direct to net
  INTERNET_OPEN_TYPE_PROXY               = 3;         // via named proxy
  INTERNET_SERVICE_FTP                   = 1;
  INTERNET_SERVICE_HTTP                  = 3;
  INTERNET_OPTION_SECURITY_FLAGS         = 31;  
  INTERNET_FLAG_PASSIVE                  = $08000000; // FTP Passive Mode flag.
  SECURITY_FLAG_IGNORE_UNKNOWN_CA        = $00000100;
  INTERNET_FLAG_IGNORE_CERT_CN_INVALID   = $00001000; // bad common name in X509 Cert.
  INTERNET_FLAG_IGNORE_CERT_DATE_INVALID = $00002000; // expired X509 Cert.
  INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS = $00004000; // ex: http:// to https://
  INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP  = $00008000; // ex: https:// to http://
  INTERNET_FLAG_SECURE                   = $00800000; // use PCT/SSL if applicable (HTTP)
  INTERNET_FLAG_KEEP_CONNECTION          = $00400000; // use keep-alive semantics
  INTERNET_FLAG_NO_AUTO_REDIRECT         = $00200000; // don't handle redirections automatically
  INTERNET_FLAG_READ_PREFETCH            = $00100000; // do background read prefetch
  INTERNET_FLAG_NO_COOKIES               = $00080000; // no automatic cookie handling
  INTERNET_FLAG_NO_AUTH                  = $00040000; // no automatic authentication handling
  INTERNET_FLAG_CACHE_IF_NET_FAIL        = $00010000; // return cache file if net request fails
  INTERNET_FLAG_RESYNCHRONIZE            = $00000800; // asking wininet to update an item if it is newer
  INTERNET_FLAG_HYPERLINK                = $00000400; // asking wininet to do hyperlinking semantic which works right for scripts
  INTERNET_FLAG_NO_UI                    = $00000200; // no cookie popup
  INTERNET_FLAG_PRAGMA_NOCACHE           = $00000100; // asking wininet to add "pragma: no-cache"
  INTERNET_FLAG_CACHE_ASYNC              = $00000080; // ok to perform lazy cache-write
  INTERNET_FLAG_FORMS_SUBMIT             = $00000040; // this is a forms submit
  INTERNET_FLAG_NEED_FILE                = $00000010; // need a file for this request
  INTERNET_FLAG_MUST_CACHE_REQUEST       = INTERNET_FLAG_NEED_FILE;
  INTERNET_FLAG_NO_CACHE_WRITE           = $04000000; // don't write this item to the cache
  INTERNET_FLAG_RELOAD                   = $80000000; // retrieve the original item
  INTERNET_CONNECTION_MODEM              = 1;
  INTERNET_CONNECTION_LAN                = 2;
  INTERNET_CONNECTION_PROXY              = 4;
  HTTP_ADDREQ_FLAG_ADD                   = $20000000;
  HSR_INITIATE                           = $00000008; // iterative operation (completed by HttpEndRequest)
  FTP_TRANSFER_TYPE_UNKNOWN              = $00000000;
  FTP_TRANSFER_TYPE_ASCII                = $00000001;
  FTP_TRANSFER_TYPE_BINARY               = $00000002;
  INTERNET_OPTION_PROXY_USERNAME         = 43;
  INTERNET_OPTION_PROXY_PASSWORD         = 44;
  HTTP_QUERY_FLAG_NUMBER                 = $20000000;
  HTTP_QUERY_CONTENT_LENGTH              = 5;
  HTTP_QUERY_STATUS_CODE                 = 19;        // special: part of status line
  HTTP_QUERY_STATUS_TEXT                 = 20;        // special: part of status line
  HTTP_QUERY_RAW_HEADERS                 = 21;        // special: all headers as ASCIIZ
  HTTP_QUERY_RAW_HEADERS_CRLF            = 22;        // special: all headers
  HTTP_QUERY_LOCATION                    = 33;
  HTTP_QUERY_REFRESH                     = 46;
  HTTP_QUERY_SET_COOKIE                  = 43;
  HTTP_QUERY_COOKIE                      = 44;
  HTTP_STATUS_DENIED                     = 401;       // access denied
  HTTP_STATUS_OK                         = 200;       // request completed
  HTTP_STATUS_MOVED                      = 301;       // object permanently moved
  HTTP_STATUS_REDIRECT                   = 302;       // object temporarily moved
  HTTP_STATUS_REDIRECT_METHOD            = 303;       // redirection w/ new access method
  HTTP_STATUS_PROXY_AUTH_REQ             = 407;       // proxy authentication required
  INTERNET_STATUS_REQUEST_SENT           = 31;
  INTERNET_STATUS_REDIRECT               = 110;

  WinInet_Error_Text: array [0..45] of string[128] =
    ('12002 The request has timed out.',
    '12003 An extended error was returned from the server.',
    '12004 An internal error has occurred.',
    '12005 The URL is invalid.',
    '12006 The URL scheme could not be recognized, or is not supported.',
    '12007 The server name could not be resolved.',
    '12013 User name incorrect.',
    '12014 Password incorrect.',
    '12015 Log on request failed.',
    '12016 The requested operation is invalid.',
    '12020 The request cannot be made via a proxy.',
    '12028 The requested item could not be located.',
    '12029 The attempt to connect to the server failed.',
    '12030 The connection with the server has been terminated.',
    '12031 The connection with the server has been reset.',
    '12033 The request to the proxy was invalid.',
    '12037 SSL certificate date is bad.',
    '12038 SSL certificate host name field is incorrect.',
    '12039 The application is moving from a non-SSL to an SSL connection because of a redirect.',
    '12040 The application is moving from an SSL to an non-SSL connection because of a redirect.',
    '12041 The content is not entirely secure.',
    '12042 The application is posting and attempting to change multiple lines of text on a server that is not secure.',
    '12043 The application is posting data to a server that is not secure.',
    '12044 The server is requesting client authentication.',
    '12045 The function is unfamiliar with the Certificate Authority that generated the server''s certificate.',
    '12052 The data being submitted to an SSL connection is being redirected to a non-SSL connection.',
    '12055 The SSL certificate contains errors.',
    '12111 FTP session aborted.',
    '12112 Passive mode is not available on the server.',
    '12133 The end of the data has been reached.',
    '12150 The requested header could not be located.',
    '12151 The server did not return any headers.',
    '12152 The server response could not be parsed.',
    '12153 The supplied header is invalid.',
    '12160 The HTTP request was not redirected.',
    '12161 The HTTP cookie requires confirmation.',
    '12162 The HTTP cookie was declined by the server.',
    '12163 The Internet connection has been lost.',
    '12164 The Web site or server indicated is unreachable.',
    '12165 The designated proxy server cannot be reached.',
    '12166 There was an error in the automatic proxy configuration script.',
    '12167 The automatic proxy configuration script could not be downloaded.',
    '12168 The redirection requires user confirmation.',
    '12169 SSL certificate is invalid.',
    '12170 SSL certificate was revoked.',
    '12171 The function failed due to a security check.');

type
  PInternetBuffers = ^INTERNET_BUFFERS;
  INTERNET_BUFFERS = packed record
    dwStructSize: DWORD;      { used for API versioning. Set to sizeof(INTERNET_BUFFERS) }
    Next: PInternetBuffers;   { chain of buffers }
    lpcszHeader: PAnsiChar;       { pointer to headers (may be NULL) }
    dwHeadersLength: DWORD;   { length of headers if not NULL }
    dwHeadersTotal: DWORD;    { size of headers if not enough buffer }
    lpvBuffer: Pointer;       { pointer to data buffer (may be NULL) }
    dwBufferLength: DWORD;    { length of data buffer if not NULL }
    dwBufferTotal: DWORD;     { total size of chunk, or content-length if not chunked }
    dwOffsetLow: DWORD;       { used for read-ranges (only used in HttpSendRequest2) }
    dwOffsetHigh: DWORD;
  end;

var
  NetLib: THandle = 0;

  InternetOpen: function(lpszAgent: PAnsiChar; dwAccessType: DWORD;
    lpszProxy, lpszProxyBypass: PAnsiChar; dwFlags: DWORD): HINTERNET; stdcall;

  InternetConnect: function(hInet: HINTERNET; lpszServerName: PAnsiChar;
    nServerPort: INTERNET_PORT; lpszUsername: PAnsiChar; lpszPassword: PAnsiChar;
    dwService: DWORD; dwFlags: DWORD; dwContext: DWORD): HINTERNET; stdcall;

  HttpOpenRequest:function(hConnect: HINTERNET; lpszVerb: PAnsiChar;
    lpszObjectName: PAnsiChar; lpszVersion: PAnsiChar; lpszReferrer: PAnsiChar;
    lplpszAcceptTypes: PLPSTR; dwFlags: DWORD;
    dwContext: Pointer): HINTERNET; stdcall;

  HttpAddRequestHeaders: function(hRequest: HINTERNET; lpszHeaders: PAnsiChar;
    dwHeadersLength: DWORD; dwModifiers: DWORD): BOOL; stdcall;

  HttpSendRequest: function(hRequest: HINTERNET; lpszHeaders: PAnsiChar;
    dwHeadersLength: DWORD; lpOptional: Pointer;
    dwOptionalLength: DWORD): BOOL; stdcall;

  HttpSendRequestEx: function(hRequest: HINTERNET; lpBuffersIn: PInternetBuffers;
    lpBuffersOut: PInternetBuffers;
    dwFlags: DWORD; dwContext: DWORD): BOOL; stdcall;

  InternetWriteFile: function(hFile: HINTERNET; lpBuffer: Pointer;
    dwNumberOfBytesToWrite: DWORD;
    var lpdwNumberOfBytesWritten: DWORD): BOOL; stdcall;

  HttpEndRequest:function(hRequest: HINTERNET;
    lpBuffersOut: PInternetBuffers; dwFlags: DWORD;
    dwContext: DWORD): BOOL; stdcall;

  HttpQueryInfo: function(hRequest: HINTERNET; dwInfoLevel: DWORD;
    lpvBuffer: Pointer; var lpdwBufferLength: DWORD;
    var lpdwReserved: DWORD): BOOL; stdcall;

  InternetCloseHandle: function(hInet: HINTERNET): BOOL; stdcall;

  InternetQueryOption: function (hInet: HINTERNET; dwOption: DWORD;
    lpBuffer: Pointer; var lpdwBufferLength: DWORD): BOOL; stdcall;

  InternetSetOption: function(hInet: HINTERNET; dwOption: DWORD;
    lpBuffer: Pointer; dwBufferLength: DWORD): BOOL; stdcall;

  FtpOpenFile: function(hConnect: HINTERNET; lpszFileName: PAnsiChar;
    dwAccess: DWORD; dwFlags: DWORD; dwContext: DWORD): HINTERNET; stdcall;

  InternetGetLastResponseInfo: function(var lpdwError: DWORD; lpszBuffer: PAnsiChar;
    var lpdwBufferLength: DWORD): BOOL; stdcall;

  InternetOpenUrl: function(hInet: HINTERNET; lpszUrl: PAnsiChar; lpszHeaders: PAnsiChar;
    dwHeadersLength: DWORD; dwFlags: DWORD; dwContext: DWORD): HINTERNET; stdcall;

  InternetReadFile: function(hFile: HINTERNET; lpBuffer: Pointer;
    dwNumberOfBytesToRead: DWORD; var lpdwNumberOfBytesRead: DWORD): BOOL; stdcall;

  InternetGetConnectedState: function(lpdwFlags: LPDWORD;
    dwReserved: DWORD): BOOL; stdcall;

var
  ProxyUserName: AnsiString = '';
  ProxyPassword: AnsiString = '';
  ProxyServer: AnsiString = '';
  PassiveMode: DWord = INTERNET_FLAG_PASSIVE;

//------------------------------------------------------------------------------
// HTML parses functions...
//------------------------------------------------------------------------------

const
  HTMLDelimiters: array [0..2] of ShortString = (' ', '>', '/>');

{$IFDEF DEBUG_MODE}
procedure SendToDebug(const S, Title: AnsiString);
begin
  with TStringList.Create do
  try
    Text := S;
    SaveToFile('C:\' + Title + '.html' {$IFDEF Delphi12Up}, TEncoding.ASCII {$ENDIF});
  finally
    Free;
  end;
end;
{$ENDIF}

procedure PurgeHTMLCode(var HTML: AnsiString);
var
  n: Integer;
begin
  for n := 1 to Length(HTML) do
    if (HTML[n] < #32) then HTML[n] := ' ';
end;

procedure ConvertSpecialHTMLChars(var HTML: string);
const
  HTMLChars: array [0..5, 0..1] of string[32] = (
    ('&', '&amp;'),  ('"', '&quot;'), ('<', '&lt;'), ('>', '&gt;'),
    (' ', '&nbsp;'), ('''', '&apos;'));
var
  n, Idx0, Idx1, Start, OrdVal, Code: Integer;
  ChOrd: AnsiString;
begin
  for n := low(HTMLChars) to high(HTMLChars) do
    HTML := QuickStringReplace(HTML, HTMLChars[n, 1], HTMLChars[n, 0]);

  Start := 1;
  repeat
    Idx0 := PosEx('&#', HTML, Start);
    if (Idx0 > 0) then
    begin
      Start := (Idx0 + 2);
      Idx1 := PosEx(';', HTML, Idx0 + 2);
      if (Idx1 > 0) then
      begin
        ChOrd := Copy(HTML, Idx0 + 2, Idx1 - Idx0 - 2);
        Val(ChOrd, OrdVal, Code);
        if (Code = 0) then
          HTML := (Copy(HTML, 1, Idx0 - 1) + Chr(OrdVal) + Copy(HTML, Idx1 + 1, Length(HTML)));
      end;
    end;
  until (Idx0 = 0);
end;

function GetTagValue(const Data, TagStart: string; const TagsEnd: array of ShortString; var Index: Integer): string;
var
  n, Start: Integer;
  PTag0, PTag1, PHTML: PChar;
  OpenTag, OpenQuote1, OpenQuote2: Boolean;

  function IsEnd(const Pt: PChar): Boolean;
  var
    i: Integer;
    S: AnsiString;
  begin
    Result := False;
    for i := low(TagsEnd) to high(TagsEnd) do
    begin
      SetString(S, Pt, Length(TagsEnd[i]));
      if (CompareText(S, TagsEnd[i]) = 0) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;

begin
  Result := '';
  OpenTag := True;
  OpenQuote1 := False;
  OpenQuote2 := False;
  PHTML := PChar(LowerCase(Data));
  PTag0 := StrPos((PHTML + Index), PChar(LowerCase(TagStart)));
  Start := (PTag0 - PHTML + 1 + Length(TagStart));
  if (PTag0 <> nil) then
  begin
    PTag0 := (PTag0 + Length(TagStart));
    PTag1 := PTag0;
    while (PTag1^ <> #0) and
      (((OpenQuote1 or OpenQuote2) and (OpenTag)) or (not IsEnd(PTag1))) do
    begin
      if (OpenTag) then
      begin
        if (PTag1^ = '"') then OpenQuote1 := (not OpenQuote1)
        else
          if (PTag1^ = '''') then OpenQuote2 := (not OpenQuote2)
          else
            if (not (OpenQuote1 or OpenQuote2)) and (PTag1^ = '>') then OpenTag := False;
      end
      else
        if (PTag1^ = '<') then OpenTag := True;
      Inc(PTag1);
    end;
    Index := (PTag1 - PHTML + 1);
    Result := Trim(Copy(Data, Start, Index - Start));
    n := 1;
    while (n <= Length(Result)) do
    begin
      if (Result[n] = '=') then
      begin
        while (Copy(Result, n - 1, 1) = ' ') do
        begin
          Delete(Result, n - 1, 1);
          Dec(n);
        end;
        while (Copy(Result, n + 1, 1) = ' ') do Delete(Result, n + 1, 1);
      end;
      Inc(n);
    end;
  end;
  ConvertSpecialHTMLChars(Result);
end;

function PurgeQuotes(const S: AnsiString): AnsiString;
var
  Idx0, Idx1: Integer;
begin
  if (S = '') then
  begin
    Result := '';
    Exit;
  end;

  Idx0 := 1;
  Idx1 := Length(S);
  if (S[1] in ['''', '"']) then Inc(Idx0);
  if (S[Length(S)] in ['''', '"']) then Dec(Idx1);
  Result := Copy(S, Idx0, Idx1 - Idx0 + 1);
end;

function GetFieldValue(const HTML, FieldName: AnsiString; var Value: AnsiString): boolean;
var
  Index, Idx: Integer;
  Tag, TagName, TagValue: AnsiString;
begin
  Result := False;
  Value := '';
  Index := 0;
  repeat
    Tag := GetTagValue(HTML, '<input ', ['>', '/>'], Index);
    if (Tag <> '') then
    begin
      If (Copy(Tag, Length(Tag), 1) = '/') then Delete(Tag, Length(Tag), 1);
      Idx := 0;
      TagName := PurgeQuotes(GetTagValue(Tag, 'name=', HTMLDelimiters, Idx));
      TagValue := PurgeQuotes(GetTagValue(Tag, 'value=', HTMLDelimiters, Idx));
      if ((CompareText(TagName, FieldName) = 0) and (TagValue <> '')) then
      begin
        Value := TagValue;
        Result := True;
        Exit;
      end;
    end;
  until (Tag = '');
end;

function GetTextAreaValue(const HTML, FieldName: AnsiString; var Value: AnsiString): boolean;
var
  Index, Idx: Integer;
  Tag, TagName: AnsiString;
begin
  Value := '';
  Result := False;
  Index := 0;
  repeat
    Tag := GetTagValue(HTML, '<textarea ', ['</textarea>', '/>'], Index);
    if (Tag <> '') then
    begin
      If (Copy(Tag, Length(Tag), 1) = '/') then Delete(Tag, Length(Tag), 1);
      Idx := 0;
      TagName := PurgeQuotes(GetTagValue(Tag, 'name=', HTMLDelimiters, Idx));
      if (CompareText(TagName, FieldName) = 0) then
      begin
        Idx := Pos('>', Tag);
        if (Idx > 0) then
        begin
          Value := Trim(Copy(Tag, Idx + 1, Length(Tag)));
          Result := True;
        end;
        Exit;
      end;
    end;
  until (Tag = '');
end;

function GetOptionsValue(const HTML, FieldTitle: AnsiString): AnsiString;
var
  Index, Idx, n: Integer;
  FullTag, SubTag, TagValue: AnsiString;
begin
  Result := '';
  Index := 0;
  repeat
    FullTag := GetTagValue(HTML, '<option ', ['</option>'], Index);
    if (FullTag <> '') then
    begin
      SubTag := FullTag;
      Idx := 0;
      TagValue := PurgeQuotes(GetTagValue(SubTag, 'value=', HTMLDelimiters, Idx));
      SubTag := Copy(SubTag, Idx + 1, Length(SubTag));
      n := 1;
      while (n <= Length(SubTag)) do
      begin
        if (SubTag[n]='&') then
          while (n <= Length(SubTag)) and (SubTag[n] <> ' ') do Delete(SubTag, n, 1);
        Inc(n);
      end;
      Idx := Pos('>', SubTag);
      if (Idx > 0) then SubTag := Copy(SubTag, Idx + 1, Length(SubTag));
      SubTag := Trim(SubTag);
      if (CompareText(SubTag, FieldTitle) = 0) then
      begin
        Result := TagValue;
        Exit;
      end;
    end;
  until (FullTag = '');
end;

function GetListValue(const HTML, ListName, FieldTitle: AnsiString; var Value: AnsiString): boolean;
var
  Index, Idx: Integer;
  Tag, TagName: AnsiString;
begin
  Value := '';
  Result := False;
  Index := 0;
  repeat
    Tag := GetTagValue(HTML, '<select ', ['</select>'], Index);
    if (Tag <> '') then
    begin
      Idx := 0;
      TagName := PurgeQuotes(GetTagValue(Tag, 'name=', HTMLDelimiters, Idx));
      if (CompareText(TagName, ListName) = 0) then
      begin
        Tag := Copy(Tag, Idx + 1, Length(Tag));
        Value := GetOptionsValue(Tag, FieldTitle);
        Result := True;
        Exit;
      end;
    end;
  until (Tag = '');
end;

function GetOptionsDefault(const HTML: AnsiString): AnsiString;
var
  Index, Idx: Integer;
  Tag, TagValue: AnsiString;

  function FindSelected(TagIn: AnsiString): Boolean;
  var
    OpenQuote1, OpenQuote2: Boolean;
    n: Integer;
  begin
   Result := False;
    TagIn := LowerCase(TagIn);
    OpenQuote1 := False;
    OpenQuote2 := False;
    n := 1;
    while (n <= Length(TagIn)) do
    begin
      if (TagIn[n] = '"') then OpenQuote1 := (not OpenQuote1)
      else
        if (TagIn[n] = '''') then OpenQuote2 := (not OpenQuote2);
      if (Copy(TagIn, n, 8) = 'selected') then
      begin
        Result := True;
        Exit;
      end;
      Inc(n);
    end;
  end;

begin
  Result := '';
  Index := 0;
  repeat
    Tag := GetTagValue(HTML, '<option ', ['</option>'], Index);
    if (Tag <> '') then
    begin
      if (FindSelected(Tag)) then
      begin
        Idx := 0;
        TagValue := PurgeQuotes(GetTagValue(Tag, 'value=', HTMLDelimiters, Idx));
        Result := TagValue;
        Exit;
      end;
    end;
  until (Tag = '');
end;

function GetListDefault(const HTML, ListName: AnsiString; var Value: AnsiString): boolean;
var
  Index, Idx: Integer;
  Tag, TagName: AnsiString;
begin
  Value := '';
  Result := False;
  Index := 0;
  repeat
    Tag := GetTagValue(HTML, '<select ', ['</select>'], Index);
    if (Tag <> '') then
    begin
      Idx := 0;
      TagName := PurgeQuotes(GetTagValue(Tag, 'name=', HTMLDelimiters, Idx));
      if (CompareText(TagName, ListName) = 0) then
      begin
        Tag := Copy(Tag, Idx + 1, Length(Tag));
        Value := GetOptionsDefault(Tag);
        Result := True;
        Exit;
      end;
    end;
  until (Tag = '');
end;

function ParserHTML(HTML, Tag: AnsiString; Num: Integer): AnsiString;
var
  Idx, n: Integer;
begin
  Result := '';
  Tag := LowerCase(Tag);
  HTML := LowerCase(HTML);
  Idx := 1;
  for n := 1 to Num do
  begin
    Idx := PosEx(Tag, HTML, Idx);
    if (Idx > 0) then Inc(Idx, Length(Tag));
  end;
  if (Idx > 0) then
  begin
    while ((Idx <= Length(HTML)) and (not (HTML[Idx] in [' ', '"', '''', '<', '>', '\','&']))) do
    begin
      Result := (Result + HTML[Idx]);
      Inc(Idx);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure DoneLib;
begin
  if (NetLib <> 0) then FreeLibrary(NetLib);
end;

function InitLib: Boolean;
begin
  Result := False;
  NetLib := LoadLibrary(WinInetLib);
  if (NetLib = 0) then Exit;

  @InternetOpen := GetProcAddress(NetLib, 'InternetOpenA');
  @InternetConnect := GetProcAddress(NetLib, 'InternetConnectA');
  @HttpOpenRequest := GetProcAddress(NetLib, 'HttpOpenRequestA');
  @HttpAddRequestHeaders := GetProcAddress(NetLib, 'HttpAddRequestHeadersA');
  @HttpSendRequest := GetProcAddress(NetLib, 'HttpSendRequestA');
  @HttpSendRequestEx := GetProcAddress(NetLib, 'HttpSendRequestExA');
  @InternetWriteFile := GetProcAddress(NetLib, 'InternetWriteFile');
  @HttpEndRequest := GetProcAddress(NetLib, 'HttpEndRequestA');
  @HttpQueryInfo := GetProcAddress(NetLib, 'HttpQueryInfoA');
  @InternetCloseHandle := GetProcAddress(NetLib, 'InternetCloseHandle');
  @InternetQueryOption := GetProcAddress(NetLib, 'InternetQueryOptionA');
  @InternetSetOption :=  GetProcAddress(NetLib, 'InternetSetOptionA');
  @FtpOpenFile := GetProcAddress(NetLib, 'FtpOpenFileA');
  @InternetGetLastResponseInfo := GetProcAddress(NetLib, 'InternetGetLastResponseInfoA');
  @InternetOpenUrl := GetProcAddress(NetLib, 'InternetOpenUrlA');
  @InternetReadFile := GetProcAddress(NetLib, 'InternetReadFile');
  @InternetGetConnectedState := GetProcAddress(NetLib, 'InternetGetConnectedState');

  Result := (Assigned(InternetOpen)) and (Assigned(InternetConnect)) and
    (Assigned(HttpOpenRequest)) and (Assigned(HttpAddRequestHeaders)) and
    (Assigned(HttpSendRequest)) and (Assigned(HttpSendRequestEx)) and
    (Assigned(InternetWriteFile)) and (Assigned(HttpEndRequest)) and
    (Assigned(HttpQueryInfo)) and (Assigned(InternetCloseHandle)) and
    (Assigned(InternetQueryOption)) and (Assigned(InternetSetOption)) and
    (Assigned(FtpOpenFile)) and (Assigned(InternetGetLastResponseInfo)) and
    (Assigned(InternetOpenUrl)) and (Assigned(InternetReadFile)) and
    (Assigned(InternetGetConnectedState));

  if (not Result) then DoneLib;
end;

//------------------------------------------------------------------------------

function IsRealFile(const FileName: AnsiString): Boolean;
begin
  Result := (FileName <> '') and (FileExists(FileName));
end;

function GetFileContents(const FileName: String): RawByteString;
var
  F: TMemoryStream;
begin
  F := TMemoryStream.Create;
  try
    F.LoadFromFile(FileName);
    SetString(Result, PAnsiChar(F.Memory), F.Size);
  finally
    F.Free;
  end;
end;

function FindErrorMessage(ErrorCode: Integer): AnsiString;
var
  n: Integer;
  StrCode: AnsiString;
  MsgSize, MsgError: DWord;
begin
  MsgError := GetLastError;
  MsgSize := 3000;
  SetLength(Result, MsgSize);
  if (InternetGetLastResponseInfo(MsgError, PAnsiChar(Result), MsgSize)) then
  begin
    SetLength(Result, MsgSize);
    if (Result <> '') then Exit;
  end;

  Result := '';
  StrCode := IntToStr(ErrorCode);
  for n := low(WinInet_Error_Text) to high(WinInet_Error_Text) do
  begin
    if (Copy(WinInet_Error_Text[n], 1, 5) = StrCode) then
      Result := Copy(WinInet_Error_Text[n], 7, Length(WinInet_Error_Text[n]));
  end;
end;
    
function CheckError(ErrorCondition: Boolean; var Response: THTTPResponse): Boolean;
begin
  if (ErrorCondition) then
  begin
    Response.ErrorCode := GetLastError;
    Response.ErrorMessage := FindErrorMessage(Response.ErrorCode);
    if (Response.ErrorMessage = '') then
      Response.ErrorMessage := SysErrorMessage(Response.ErrorCode);
    Result := True;
  end
  else Result := False;
end;

//------------------------------------------------------------------------------

procedure AddAuthenticationToURL(var URL: AnsiString; const User, Password: AnsiString; Port: Word);
var
  AutStr: AnsiString;
  Idx: Integer;
begin
  if (Port <> 0) then
    URL := (URL + ':' + IntToStr(Port));
  if (user <> '') or (Password <> '') then
  begin
    AutStr := (User + ':' + Password + '@');
    Idx := Pos('://', URL);
    if (Idx = 0) then URL := (AutStr + URL)
    else Insert(AutStr, URL, Idx + 3);
  end;
end;

function ElaborateURL(URL: AnsiString; var Protocol, UserID, Password, Host,
  Path: AnsiString; var Port: Word): Boolean;
var
  PortSTR: AnsiString;
  Code: Integer;

  procedure SearchWord(const Word: AnsiString; var URL, Value: AnsiString; DomainWord: Boolean);
  const
    ValidDomainChars: set of AnsiChar = ['0'..'9', 'a'..'z', 'A'..'Z', '-', '.'];
  var
    Idx, n, Len: Integer;
  begin
    Value := '';
    Idx := Pos(Word, URL);
    if (Idx <> 0) then
    begin
      if (DomainWord) then
      begin
        for n := 1 to (Idx - 1) do
          if not (URL[n] in ValidDomainChars) then Exit;
      end;
      Len := Length(Word);
      Value := Copy(URL, 1, (Idx - 1));
      URL := Copy(URL, (Idx + Len), Length(URL));
    end;
  end;

  function SearchPort(var URL: AnsiString): AnsiString;
  var
    n: Integer;
  begin
    Result := '';
    if (URL = '') then Exit;

    for n := (Length(URL) - 1) downto 1 do
      if not (URL[n] in ['0'..'9']) then Break;
    if (URL[n] = ':') then
    begin
      Result := Copy(URL, (n + 1), Length(URL) - n - 1);
      URL := (Copy(URL, 1, (n - 1)) + '/');
    end;
  end;

begin
  Result := True;
  URL := Trim(URL);
  if (URL <> '') and (URL[Length(URL)] <> '/') then URL := (URL + '/');
  Port := 0;
  PortStr := SearchPort(URL);
  If (PortStr <> '') then
  begin
    Val(PortStr, Port, Code);
    if (Code <> 0) then
    begin
      Result := False;
      Exit;
    end;
  end;

  SearchWord('://', URL, Protocol, True);
  SearchWord(':', URL, UserID, False);
  SearchWord('@', URL, Password, False);
  SearchWord('/', URL, Host, True);
  Path := Copy(URL, 1, (Length(URL) - 1));
end;

procedure ElaborateWebPage(const WebPage: AnsiString; var Path, Page, Parameters: AnsiString);
var
  Idx: Integer;
begin
  Path := '';
  Page := webPage;
  Parameters := '';

  Idx := Pos('?', WebPage);
  if (Idx > 0) then
  begin
    Parameters := Copy(WebPage, Idx, Length(WebPage));
    Page := Copy(WebPage, 1, Idx - 1);
  end;

  Idx := Length(WebPage);
  while (Idx >= 1) and (WebPage[Idx] <> '/') do Dec(Idx);
  if (Idx > 0) then
  begin
    Page := Copy(Page, Idx + 1, Length(Page));
    Path := Copy(WebPage, 1 , Idx);
  end;
end;

function GetHTTPResponse(hRequest: HINTERNET; Flag: DWord; var s: AnsiString): Boolean;
var
  dwInfoBufferLength, dwIndex: DWord;
  pInfoBuffer: PAnsiChar;
  Idx: Integer;
begin
  Result := True;
  dwInfoBufferLength := 10;
  dwIndex := 0;
  GetMem(pInfoBuffer, (dwInfoBufferLength + 1));
  try
    while (not HttpQueryInfo(hRequest, Flag, pInfoBuffer, dwInfoBufferLength, dwIndex)) do
    begin
      if (GetLastError = ERROR_INSUFFICIENT_BUFFER) then
      begin
        FreeMem(pInfoBuffer);
        GetMem(pInfoBuffer, (dwInfoBufferLength + 1));
      end
      else
      begin
        Result := False;
        Exit;
      end;
    end;
    SetString(s, pInfoBuffer, dwInfoBufferLength);
  finally
    FreeMem(pInfoBuffer);
  end;
  // Purge the refresh respose...
  if ((Result) and (Flag = HTTP_QUERY_REFRESH)) then
  begin
    Idx := Pos('url=', s);
    if (Idx > 0) then s := Trim(Copy(S, (Idx + 4), MaxInt));
  end;
end;

function URLEncode(const Data: AnsiString): AnsiString;
const
  AlphaNumerics: set of AnsiChar = ['0'..'9', 'a'..'z', 'A'..'Z'];
var
  n: Integer;
begin
  Result := '';
  for n := 1 to Length(Data) do
    if (Data[n] in AlphaNumerics) then Result := (Result + Data[n])
    else Result := (Result + '%' + IntToHex(Ord(Data[n]), 2));
end;

function GetValueFromIndex(Strings: TStrings; Index: Integer): AnsiString;
begin
  if (Index >= 0) then
    Result := Copy(Strings[Index], Length(Strings.Names[Index]) + 2, MaxInt)
  else
    Result := '';
end;

{ THTTPConnectionBase }

constructor THTTPConnectionBase.Create(const URL, Proxy: AnsiString);
var
  Protocol, Parameters, TempPath: AnsiString;
  Idx: Integer;
begin
  if (not InitLib) then Exit;

  FResponse := THTTPResponse.Create;

  Path := '';
  ElaborateURL(URL, Protocol, UserName, Password, Host, BasePath, Port);
  Idx := Pos('?', BasePath);
  if (Idx > 0) then
  begin
    Parameters := Copy(BasePath, Idx + 1, Length(BasePath));
    Delete(BasePath, Idx, Length(BasePath));
  end;
  if (Copy(BasePath, Length(BasePath), 1) <> '/') then BasePath := (BasePath + '/');
  if (CompareText(Protocol, 'https') = 0) then UseHTTPS := True
  else UseHTTPS := False;
  if (Port = 0) then
    Case UseHTTPS of
      False: Port := 80;
      True: Port := 443;
    end;

  // Empty Proxy URL (like ':8080' or '')...
  if ((Copy(Proxy, 1, 1) <> ':') and (Proxy <> '')) then
  begin
    ElaborateURL(Proxy, Protocol, ProxySetting.UserName, ProxySetting.Password,
      ProxySetting.Server, TempPath, ProxySetting.Port);
    if (ProxySetting.Port = 0) then ProxySetting.Port := 8080;
    UseProxy := True;
  end
  else UseProxy := False;

  Fields := TStringList.Create;
  Files := TStringList.Create;
  Open;
end;

destructor THTTPConnectionBase.Destroy;
begin
  Close;
  FResponse.Free;
  FResponse := nil;
  DoneLib;
  Fields.Free;
  Fields := nil;
  Files.Free;
  Files := nil;
  inherited;
end;

{$IFDEF DEBUG_MODE}
procedure THTTPConnectionBase.OpenResponseHTMLPage;
begin
  with TStringList.Create do
  try
    Text := FResponse.HTML;
    SaveToFile('c:\ResultPage.html' {$IFDEF Delphi12Up}, TEncoding.ASCII {$ENDIF});
  finally
    Free;
  end;
  ShellExecute(0, 'open', 'C:\ResultPage.html', nil, nil, SW_SHOWMAXIMIZED)
end;
{$ENDIF}

function THTTPConnectionBase.Open: Boolean;
begin
  SetSendState(ssConnecting, 0);

  Result := False;
  if (not InitLib) then Exit;

  if (not UseProxy) then
    hInternet := InternetOpen('EurekaLog', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0)
  else
    hInternet := InternetOpen('EurekaLog', INTERNET_OPEN_TYPE_PROXY, PAnsiChar(ProxySetting.Server), '<local>', 0);

  if (hInternet <> nil) then
  begin
    hConnect := InternetConnect(hInternet, PAnsiChar(Host), Port,
      PAnsiChar(UserName), PAnsiChar(Password), INTERNET_SERVICE_HTTP,
      INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_NO_CACHE_WRITE, 0);
    Result := (hConnect <> nil);
    if (Result) then SetSendState(ssConnected, 0);
  end;

  if (not Result) then
    raise Exception.CreateFmt('Cannot create an HTTP connection with the host: %s', [Host]);
end;

function THTTPConnectionBase.Close: Boolean;
begin
  SetSendState(ssDisconnecting, 0);
  Result :=
    ((NetLib <> 0) and InternetCloseHandle(hConnect) and InternetCloseHandle(hInternet));
  if (Result) then SetSendState(ssDisconnected, 0);

  if (not Result) then
    raise Exception.CreateFmt('Cannot close the HTTP connection with the host: %s', [Host]);
end;

function THTTPConnectionBase.SendRequest(
  var Response: THTTPResponse; UpdateStatus: Boolean): Boolean;
var
  dwOpenRequestFlags, dwBytesWritten: DWord;
  dwBuffLen, dwFlags: DWord;
  hRequest: Pointer;
  TempPath, BasicPath, Parameters, TempStr: AnsiString;
  SendVerb, Boundary, AuthorizationHeader, ContentTypeHeader, StrSend, RequestBody: RawByteString;
  bResult: Boolean;
  HTMLSize, Percent, TotalSize, Steps, Index, n: Integer;
  Buffer: array [0..BufferSize - 1] of AnsiChar;
  BufferLength: DWord;
  BufferIn: INTERNET_BUFFERS;

  function GenerateMultipartBoundary: RawByteString;
  begin
    Result := '---------------------------' + IntToHex(Random($FFFF), 4) +
      IntToHex(Random($FFFF), 4) + IntToHex(Random($FFFF), 4);
  end;

  function GenerateRequestBody(const Files, Fields: TStrings; Boundary: RawByteString): RawByteString;
  var
    n: integer;
  begin
    Result := '';

    if (Fields <> nil) then
    begin
      for n := 0 to (Fields.Count - 1) do
      begin
        Result := Result + '--' + Boundary + #13#10 +
          'Content-Disposition: form-data; name="' + RawByteString(Fields.Names[n]) + '";'#13#10#13#10 +
          RawByteString(GetValueFromIndex(Fields, n)) + #13#10;
      end;
    end;

    if (Files <> nil) then
    begin
      for n := 0 to (Files.Count - 1) do
      begin
        if (IsRealFile(GetValueFromIndex(Files, n))) then
          Result := Result + '--' + Boundary + #13#10 +
            'Content-Disposition: form-data; name="' + RawByteString(Files.Names[n]) + '"; filename="' + RawByteString(ExtractFileName(GetValueFromIndex(Files, n))) + '";'#13#10 +
            'Content-Type: application/octet-stream'#13#10#13#10 +
            GetFileContents(GetValueFromIndex(Files, n)) + #13#10
        else
          Result := Result + '--' + Boundary + #13#10 +
            'Content-Disposition: form-data; name="' + RawByteString(Files.Names[n]) + '"; filename="";'#13#10 +
            'Content-Type: application/octet-stream'#13#10#13#10#13#10;
      end;
    end;

    Result := (Result + '--' + boundary + '--'#13#10);
  end;

begin
  Result := False;
  if (not InitLib) then Exit;

  Response.Clear;
  ElaborateWebPage(Path, BasicPath, Response.ReplayPage, Parameters);

  dwOpenRequestFlags := (INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP or
    INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS or INTERNET_FLAG_KEEP_CONNECTION or
    INTERNET_FLAG_NO_AUTO_REDIRECT or INTERNET_FLAG_NO_UI or
    INTERNET_FLAG_RELOAD or INTERNET_FLAG_NO_CACHE_WRITE);
  if (UseHTTPS) then
    dwOpenRequestFlags := (dwOpenRequestFlags or INTERNET_FLAG_SECURE or
      INTERNET_FLAG_IGNORE_CERT_CN_INVALID or INTERNET_FLAG_IGNORE_CERT_DATE_INVALID);

  repeat
    case RequestMethod of
      rmGET:
        begin
          SendVerb := 'GET';
          ContentTypeHeader := '';
          RequestBody := '';
          if (Fields <> nil) then
            for n := 0 to (Fields.Count - 1) do
            begin
              if (Parameters <> '') then Parameters := (Parameters + '&')
              else Parameters := '?';
              Parameters := (Parameters + URLEncode(Fields.Names[n]) + '=' +
                URLEncode(GetValueFromIndex(Fields, n)));
            end;
        end;
      rmPOST:
        begin
          SendVerb := 'POST';
          RequestBody := '';
          ContentTypeHeader := 'Content-Type: application/x-www-form-urlencoded';
          if (Fields <> nil) then
            for n := 0 to (Fields.Count - 1) do
            begin
              if (n > 0) then RequestBody := (RequestBody + '&');
              RequestBody := (RequestBody +
                Fields.Names[n] + '=' + URLEncode(GetValueFromIndex(Fields, n)));
            end;
        end;
      rmBinaryPOST:
        begin
          SendVerb := 'POST';
          Boundary := GenerateMultipartBoundary;
          ContentTypeHeader := ('Content-Type: multipart/form-data; boundary=' + Boundary);
          RequestBody := GenerateRequestBody(Files, Fields, Boundary);
        end;
    end;

    hRequest := HttpOpenRequest(
      hConnect, PAnsiChar(SendVerb), PAnsiChar(BasicPath + Response.ReplayPage + Parameters),
      nil, nil, nil, dwOpenRequestFlags, Self);
    if CheckError(hRequest = nil, Response) then Exit;

    if (UseHTTPS) then
    begin
      dwBuffLen := SizeOf(dwFlags);
      InternetQueryOption(hRequest, INTERNET_OPTION_SECURITY_FLAGS, @dwFlags, dwBuffLen);
      dwFlags := (dwFlags or SECURITY_FLAG_IGNORE_UNKNOWN_CA);
      InternetSetOption(hRequest, INTERNET_OPTION_SECURITY_FLAGS, @dwFlags, SizeOf(dwFlags));
    end;

    if (ContentTypeHeader <> '') then
    begin
      bResult := HttpAddRequestHeaders(
        hRequest, PAnsiChar(ContentTypeHeader), DWord(-1), HTTP_ADDREQ_FLAG_ADD);
      if CheckError(not bResult, Response) then Exit;
    end;

    if ((UserName <> '') or (Password <> '')) then
    begin
      AuthorizationHeader :=
        ('Authorization: Basic ' + Base64EncodeString(UserName + ':' + Password));
      bResult :=
        HttpAddRequestHeaders(hRequest, PAnsiChar(AuthorizationHeader), DWord(-1), HTTP_ADDREQ_FLAG_ADD);
      if CheckError(not bResult, Response) then Exit;
    end;

    if (UseProxy) then
    begin
      bResult := InternetSetOption(hRequest, INTERNET_OPTION_PROXY_USERNAME,
        PAnsiChar(ProxySetting.UserName), Length(ProxySetting.UserName) + 1);
      if CheckError(not bResult, Response) then Exit;

      bResult := InternetSetOption(hRequest, INTERNET_OPTION_PROXY_PASSWORD,
        PAnsiChar(ProxySetting.Password), Length(ProxySetting.Password) + 1);
      if CheckError(not bResult, Response) then Exit;
    end;

{$IFDEF DEBUG_MODE}
    SendToDebug(RequestBody, 'RequestBody');
{$ENDIF}
    TotalSize := Length(RequestBody);
    FillChar(BufferIn, SizeOf(BufferIn), 0);
    BufferIn.dwStructSize := SizeOf(INTERNET_BUFFERS);
    BufferIn.dwBufferTotal := TotalSize;
    bResult := HttpSendRequestEx(hRequest, @BufferIn, nil, 0, 0);
    if CheckError(not bResult, Response) then Exit;
    try
      Steps := (TotalSize div BufferSize);
      if (TotalSize mod BufferSize > 0) then Inc(Steps);
      for n := 0 to (Steps - 1) do
      begin
        Index := (BufferSize * n);
        StrSend := Copy(RequestBody, (Index + 1), BufferSize);
        if CheckError(
          not InternetWriteFile(
            hRequest, PAnsiChar(StrSend), Length(StrSend), dwBytesWritten), Response) then Exit
        else
          if (UpdateStatus) then
          begin
            Percent := Round(((Index + BufferSize) / TotalSize) * 100);
            if (Percent > 50) then Percent := 50;
            SetSendState(ssSending, Percent);
          end;
      end;
    finally
      HttpEndRequest(hRequest, nil, 0, 0);
      if ((UpdateStatus) and (Response.ErrorCode = 0)) then
        SetSendState(ssSending, 50);
    end;

    // Obtain the Status Code...
    if (GetHTTPResponse(hRequest, HTTP_QUERY_STATUS_CODE, TempStr)) then
      Response.StatusCode := StrToInt(TempStr);

    // Obtain the Status Text...
    GetHTTPResponse(hRequest, HTTP_QUERY_STATUS_TEXT, Response.StatusText);

    // Download the Header...
    GetHTTPResponse(hRequest, HTTP_QUERY_RAW_HEADERS_CRLF, Response.Header);

    HTMLSize := 0;
    if GetHTTPResponse(hRequest, HTTP_QUERY_CONTENT_LENGTH, TempStr) then
      HTMLSize := StrToInt(TempStr);
    if (HTMLSize = 0) then HTMLSize := 1;

    // Download the HTML...
    repeat
      InternetReadFile(hRequest, @Buffer, BufferSize, BufferLength);
      if (BufferLength > 0) then
        Response.HTML := (Response.HTML + Copy(Buffer, 1, BufferLength));
      if (UpdateStatus) then
        SetSendState(ssSending, Round(50 + ((Length(Response.HTML) / HTMLSize) * 50)));
    until (BufferLength = 0);

    if (Response.StatusCode = HTTP_STATUS_MOVED) or
       (Response.StatusCode = HTTP_STATUS_REDIRECT) or
       (Response.StatusCode = HTTP_STATUS_REDIRECT_METHOD) then
    begin
      GetHTTPResponse(hRequest, HTTP_QUERY_LOCATION, Path);
      ElaborateWebPage(Path, TempPath, Response.ReplayPage, Parameters);
      if (TempPath <> '') then BasicPath := TempPath;
      RequestMethod := rmGET;
      Fields.Clear;
      Files.Clear;
    end
    else
      if (Response.StatusCode = HTTP_STATUS_OK) then
      begin
        if GetHTTPResponse(hRequest, HTTP_QUERY_REFRESH, Path) then
        begin
          ElaborateWebPage(Path, TempPath, Response.ReplayPage, Parameters);
          if (TempPath <> '') then BasicPath := TempPath;
          RequestMethod := rmGET;
          Fields.Clear;
          Files.Clear;
          Response.StatusCode := HTTP_STATUS_REDIRECT;
        end;
      end;

  until (Response.StatusCode <> HTTP_STATUS_REDIRECT);

  if (UpdateStatus) then SetSendState(ssSent, 0);

  PurgeHTMLCode(Response.HTML);
  FResponse.Assign(Response);

{$IFDEF DEBUG_MODE}
  SendToDebug(Response.HTML, 'ResponseHTML');
  {$IFDEF DEBUG_DETAILS}
    OpenResponseHTMLPage;
    MessageBoxA(0, 'Press ''OK'' to continue.', '', MB_OK or MB_TASKMODAL or MB_TOPMOST);
  {$ENDIF}
{$ENDIF}

  Result := True;
end;

procedure THTTPConnectionBase.SetRequest(const AWebPage: AnsiString; AMethod: TRequestMethod);
begin
  Path := (BasePath + AWebPage);
  RequestMethod := AMethod;
  Fields.Clear;
  Files.Clear;
end;

procedure THTTPConnectionBase.AddCustomFields(CustomFields: TStrings);
const
  FixEurekaLogFields = 4;
var
  n, Idx: Integer;
begin
  for n := 0 to (CustomFields.Count - FixEurekaLogFields - 1) do
  begin
    // Delete any old value...
    Idx := Fields.IndexOfName(CustomFields.Names[n]);
    if (Idx <> -1) then Fields.Delete(Idx);

    AddField(CustomFields.Names[n], GetValueFromIndex(CustomFields, n))
  end;
end;

procedure THTTPConnectionBase.AddField(const FieldName, FieldValue: AnsiString);
begin
  Fields.Add(FieldName + '=' + FieldValue);
end;

procedure THTTPConnectionBase.AddFieldValue(const FieldName: AnsiString);
var
  FieldValue: AnsiString;
begin
  if (GetFieldValue(FResponse.HTML, FieldName, FieldValue)) then
    Fields.Add(FieldName + '=' + FieldValue);
end;

function THTTPConnectionBase.AddOptionalField(const Source, Field: AnsiString): AnsiString;
begin
  if (Field <> '') then Result := (Source + #13#10#13#10 + '---' + #13#10#13#10 + Field)
  else Result := Source;
end;

procedure THTTPConnectionBase.AddFieldByTextArea(const FieldName: AnsiString);
var
  TextValue: AnsiString;
begin
  if (GetTextAreaValue(FResponse.HTML, FieldName, TextValue)) then
    Fields.Add(FieldName + '=' + TextValue);
end;

procedure THTTPConnectionBase.AddFieldByDefaultList(const ListName: AnsiString);
var
  ListValue: AnsiString;
begin
  if (GetListDefault(FResponse.HTML, ListName, ListValue)) then
    Fields.Add(ListName + '=' + ListValue)
  else
    AddFieldValue(ListName);
end;

procedure THTTPConnectionBase.AddFieldByDefaultList2(const ListName: AnsiString);
var
  ListValue: AnsiString;
begin
  if (GetListDefault(FResponse.HTML, ListName, ListValue)) then
  begin
    if (ListValue <> '') then
      Fields.Add(ListName + '=' + ListValue)
  end
  else
    AddFieldValue(ListName);
end;

procedure THTTPConnectionBase.AddFieldByListTitle(const ListName, FieldTitle: AnsiString);
var
  FieldValue, ListValue: AnsiString;
begin
  if (not GetListValue(FResponse.HTML, ListName, FieldTitle, FieldValue)) then
  begin
    if (GetListDefault(FResponse.HTML, ListName, ListValue)) then
      Fields.Add(ListName + '=' + ListValue);
  end
  else Fields.Add(ListName + '=' + FieldValue);
end;

function THTTPConnectionBase.GetBugCountField(const FieldName: AnsiString): Boolean;
const
  BugCountConst = ' - ';
var
  Idx0, Idx1, Number, Code: Integer;
  BugCountLen: Integer;
  S: AnsiString;

  function CompleteNumber(Num: Integer): AnsiString;
  var
    n, Len: Integer;
    s: AnsiString;
  begin
    Len := Length(IntToStr(MaxBugOccurrencesLen));
    s := IntToStr(Num);
    Result := s;
    for n := (Length(s) + 1) to Len do Result := ('0' + Result);
  end;

begin
  Result := True;
  GetFieldValue(FResponse.HTML, FieldName, S);
  Idx0 := Pos(BugCountConst, S);
  if (Idx0 > 0) then
  begin
    BugCountLen := Length(BugCountConst);
    Idx1 := PosEx(']', S, Idx0);
    if (Idx1 = 0) then Idx1 := (Length(S) + 1);
    Val(Copy(S, (Idx0 + BugCountLen), (Idx1 - Idx0 - BugCountLen)), Number, Code);
    if (Code = 0) then
    begin
      if (MaxBugOccurrences = 0) or (Number < MaxBugOccurrences) then
      begin
        Inc(Number);
        S := (Copy(S, 1, (Idx0 + BugCountLen - 1)) + CompleteNumber(Number) +
          Copy(S, Idx1, Length(S)));
      end
      else Result := False;
    end;
  end;
  if (Result) then AddField(FieldName, S);
end;

function THTTPConnectionBase.IsSuccessfulSend(const ReplyPage,
  HTMLIncludeCode, HTMLExcludeCode: AnsiString): Boolean;
begin
  Result := ((ReplyPage = '') or (CompareText(FResponse.ReplayPage, ReplyPage) = 0)) and
    ((HTMLIncludeCode = '') or (Pos(LowerCase(HTMLIncludeCode), LowerCase(FResponse.HTML)) <> 0)) and
    ((HTMLExcludeCode = '') or (Pos(LowerCase(HTMLExcludeCode), LowerCase(FResponse.HTML)) = 0));
end;

procedure THTTPConnectionBase.AddBugSummary(const FieldName, AVersion, AExceptionType, ABugID: AnsiString);
begin
  AddField(FieldName, Format('[v%s - 1]: %s (%s)', [AVersion, AExceptionType, ABugID]));
end;

procedure THTTPConnectionBase.AddSearchText(const FieldName, AVersion, AExceptionType, ABugID: AnsiString);
begin
  AddField(FieldName, Format('%s (%s)', [AExceptionType, ABugID]));
end;

//------------------------------------------------------------------------------

{ THTTPMantisSendReport }

function THTTPMantisSendReport.PostBug(const AVersion, ABugType, ABugText, ABugID,
  ABaseURL, AProxyURL, AUserName, APassword, AProjectName, ACategory, AAssignTo,
  AAttachedFile: AnsiString; ACustomFields: TStrings; var Response: THTTPResponse): TSendResult;
var
  Connection: THTTPConnectionBase;
  SendResult, BugClosed: Boolean;
  BugResult, BugNumber, BugStatus: AnsiString;
  UTF8ProjectName, UTF8Category, UTF8AssignTo: AnsiString;
begin
  UTF8ProjectName := StringToUtf8(AProjectName);
  UTF8Category := StringToUtf8(ACategory);
  UTF8AssignTo := StringToUtf8(AAssignTo);
  Connection := FHTTPConnectionClass.Create(ABaseURL, AProxyURL);
  try
    with Connection do
    begin
      SetSendState(ssLogin, 0);
      SetRequest('login.php', rmPOST);
      AddField('return', 'login_select_proj_page.php');
      AddField('username', AUserName);
      AddField('password', APassword);
      SendResult := SendRequest(Response, False);
      if (SendResult) and
        (IsSuccessfulSend('login_select_proj_page.php', 'name="project_id"', '')) then
      begin
        SetSendState(ssSelectProject, 0);
        SetRequest('set_project.php', rmPOST);
        AddFieldByListTitle('project_id', UTF8ProjectName);
        SendResult := SendRequest(Response, False);
        if (SendResult) and
          ((IsSuccessfulSend('my_view_page.php', '>' + UTF8ProjectName + '</option>', '')) or
          (IsSuccessfulSend('my_view_page.php', ' ' + UTF8ProjectName + '</option>', ''))) then
        begin
          SetSendState(ssSearching, 0);
          SetRequest('view_all_set.php?f=3', rmPOST);
          AddField('type', '1');
          AddField('page_number', '1');
          AddField('view_type', 'simple');
          AddSearchText('search', AVersion, ABugType, ABugID);
          SendResult := SendRequest(Response, False);
          // Check for the just entered BUG-ID...
          if (SendResult) and
            // Mantis 1.0.x...
            ((IsSuccessfulSend('view_all_bug_page.php', 'name="reset_query_button"', '')) or
            // Mantis 1.1.x...
            (IsSuccessfulSend('view_all_bug_page.php', 'name="source_query_id"', ''))) then
          begin
            if ((IsSuccessfulSend('', '', 'bug_update_page.php?bug_id=')) and
               (IsSuccessfulSend('', '', 'bug_update_advanced_page.php?bug_id='))) then
            begin
              SetRequest('bug_report_advanced_page.php', rmGET);
              SendResult := SendRequest(Response, False);
              if (SendResult) and
                (IsSuccessfulSend('bug_report_advanced_page.php', 'name="file" type="file"', '')) then
              begin
                SetRequest('bug_report.php', rmBinaryPOST);
                // Fields...
                AddFieldValue('m_id');
                AddFieldValue('project_id');
                AddFieldByListTitle('handler_id', UTF8AssignTo);
                AddFieldByListTitle('category', UTF8Category);
                AddField('reproducibility', '10');
                AddFieldByDefaultList('severity');
                AddFieldByDefaultList('priority');
                AddFieldValue('platform');
                AddField('os', ACustomFields.Values['EL_OSType']);
                AddField('os_build', ACustomFields.Values['EL_OSBuild']);
                AddField('build', AVersion);
                AddBugSummary('summary', AVersion, ABugType, ABugID);
                AddField('description', ABugText);
                AddField('steps_to_reproduce', ACustomFields.Values['EL_ReproduceText']);
                AddField('additional_info', '');
                AddField('view_state', '10');
                AddFieldValue('report_stay');

                // Mantis 1.1.5...
                AddFieldValue('bug_report_token');

                // Process custom fields...
                AddCustomFields(ACustomFields);

                // File to upload...
                if (AAttachedFile <> '') then Files.Add('file=' + AAttachedFile);
                SendResult := SendRequest(Response, True);
                if (SendResult) and
                  (IsSuccessfulSend('bug_report.php', 'href="view.php?id=', '')) then Result := srOK
                else Result := srInvalidInsert;
              end
              else Result := srInvalidInsert;
            end
            else
            begin
              SetSendState(ssModifying, 0);
              BugResult := ParserHTML(Response.HTML, '<td class="center"><u><a title="open">', 1);
              BugNumber := ParserHTML(Response.HTML, 'bug_update_page.php?bug_id=', 1);
              if (BugNumber = '') then
                BugNumber := ParserHTML(Response.HTML, 'bug_update_advanced_page.php?bug_id=', 1);
              SetRequest('bug_update_page.php', rmGET);
              AddField('bug_id', BugNumber);
              SendResult := SendRequest(Response, False);
              if (SendResult) and
                (IsSuccessfulSend('bug_update_page.php', 'name="severity"', '')) then
              begin
                SetRequest('bug_update.php', rmPOST);
                if GetBugCountField('summary') then
                begin
                  GetListDefault(Response.HTML, 'status', BugStatus);
                  BugClosed := ((BugStatus = '80') or (BugStatus = '90'));
                  if (BugClosed) then Result := srBugClosed
                  else
                  begin
                    // Fields...
                    AddField('bug_id', BugNumber);
                    AddFieldValue('update_mode');
                    AddFieldByDefaultList('category');
                    AddFieldByDefaultList('severity');
                    AddFieldByDefaultList('reproducibility');
                    AddFieldByDefaultList('reporter_id');
                    AddFieldByDefaultList('view_state');
                    AddFieldByDefaultList('handler_id');
                    AddFieldByDefaultList('priority');
                    AddFieldByDefaultList2('resolution');
                    AddFieldByTextArea('description');
                    AddFieldByTextArea('additional_information');
                    AddFieldByTextArea('bugnote_text');
                    AddField('build', AVersion);

                    // Mantis 1.1.5...
                    AddFieldValue('bug_update_token');

                    // Process custom fields...
                    AddCustomFields(ACustomFields);

                    SendResult := SendRequest(Response, True);
                    if (SendResult) and
                      ((IsSuccessfulSend('bug_update.php', 'href="view.php?id=', '')) or
                      (IsSuccessfulSend('view.php', 'href="view.php?id=', ''))) then Result := srOK
                    else Result := srInvalidModify;
                  end;
                end
                else Result := srOK;
              end
              else Result := srInvalidModify;
            end;
          end
          else Result := srInvalidSearch;
        end
        else Result := srInvalidSelection;
      end
      else Result := srInvalidLogin;
{$IFDEF DEBUG_MODE}
      if (Result <> srOK) then OpenResponseHTMLPage;
{$ENDIF}
    end;
  finally
    Connection.Free;
  end;
end;

//------------------------------------------------------------------------------

{ THTTPBugzillaSendReport }

function THTTPBugzillaSendReport.PostBug(const AVersion, ABugType, ABugText, ABugID,
  ABaseURL, AProxyURL, AUserName, APassword, AProjectName, ACategory, AAssignTo,
  AAttachedFile: AnsiString; ACustomFields: TStrings; var Response: THTTPResponse): TSendResult;
var
  Connection: THTTPConnectionBase;
  SendResult, BugClosed: Boolean;
  BugResult, BugNumber, BugID: AnsiString;
  Index: Integer;
begin
  Connection := FHTTPConnectionClass.Create(ABaseURL, AProxyURL);
  try
    with Connection do
    begin
      SetSendState(ssLogin, 0);
      SetRequest('enter_bug.cgi', rmPOST);
      AddField('project', AProjectName);
      AddField('Bugzilla_login', AUserName);
      AddField('Bugzilla_password', APassword);
      SendResult := SendRequest(Response, False);
      if (SendResult) and
        (IsSuccessfulSend('enter_bug.cgi', 'relogin.cgi', '')) then
      begin
        SetSendState(ssSearching, 0);
        SetRequest('buglist.cgi', rmGET);
        AddField('query_format', 'specific');
        AddField('order', 'relevance desc');
        AddField('bug_status', '__all__');
        AddField('product', AProjectName);
        AddSearchText('content', '', '', ABugID);
        SendResult := SendRequest(Response, False);
        // Check for the just entered BUG-ID...
        if (SendResult) and
          (IsSuccessfulSend('buglist.cgi', 'href="query.cgi?', '')) then
        begin
          if (IsSuccessfulSend('', '', 'show_bug.cgi?id=')) then
          begin
            SetSendState(ssSelectProject, 0);
            SetRequest('enter_bug.cgi', rmGET);
            AddField('product', AProjectName);
            SendResult := SendRequest(Response, False);
            if (SendResult) and
              (IsSuccessfulSend('enter_bug.cgi', 'action="post_bug.cgi"', '')) then
            begin
              SetRequest('post_bug.cgi', rmPOST);
              // Fields...
              AddFieldValue('product');
              if (Pos('<option value="' + AVersion + '">', FResponse.HTML) > 0) then
                AddField('version', AVersion)
              else
                AddFieldByDefaultList('version');
              AddFieldByDefaultList('component');
              if (Fields.Values['component'] = '') then
              begin
                Index := 0;
                Fields.Values['component'] :=
                  GetTagValue(FResponse.HTML, 'components[0] = "', ['"'], Index);
              end;
              AddFieldByDefaultList('rep_platform');
              AddFieldByDefaultList('op_sys');
              AddFieldByDefaultList('priority');
              AddFieldByDefaultList('bug_severity');
              AddFieldByDefaultList('target_milestone');
              AddFieldValue('bug_status');
              if (AAssignTo <> '') then
                AddField('assigned_to', AAssignTo)
              else
                AddField('assigned_to', AUserName);
              AddFieldValue('qa_contact');
              AddFieldValue('cc');
              AddFieldValue('estimated_time');
              AddFieldValue('deadline');
              AddFieldValue('bug_file_loc');
              AddBugSummary('short_desc', AVersion, ABugType, ABugID);
              AddField('comment', AddOptionalField(ABugText,
                ACustomFields.Values['EL_ReproduceText']));
              AddFieldValue('keywords');
              AddFieldValue('dependson');
              AddFieldValue('blocked');
              AddField('form_name', 'enter_bug');

              // BugZilla 3.x
              AddFieldByDefaultList('bug_status');

              // Process custom fields...
              AddCustomFields(ACustomFields);
              
              SendResult := SendRequest(Response, False);
              if (SendResult) and
                (IsSuccessfulSend('post_bug.cgi', 'show_bug.cgi?id=', '')) then
              begin
                SetRequest('attachment.cgi', rmBinaryPOST);
                // Fields...
                GetFieldValue(Response.HTML, 'id', BugID);
                AddField('bugid', BugID);
                AddField('action', 'insert');
                AddField('description', 'FILE');
                AddField('contenttypemethod', 'list');
                AddField('contenttypeselection', 'application/octet-stream');
                AddField('contenttypeentry', '');
                AddField('flag_type-1', 'X');
                AddField('flag_type-2', 'X');
                AddField('flag_type-3', 'X');
                AddField('flag_type-4', 'X');
                AddField('comment', '');
                // File to upload...
                if (AAttachedFile <> '') then Files.Add('data=' + AAttachedFile);
                SendResult := SendRequest(Response, True);
                if (SendResult) and
                  (IsSuccessfulSend('attachment.cgi', 'attachment.cgi', '')) then Result := srOK
                else Result := srInvalidInsert;
              end
              else Result := srInvalidInsert;
            end
            else Result := srInvalidSelection;
          end
          else
          begin
            SetSendState(ssModifying, 0);
            BugResult := ParserHTML(Response.HTML, '<td style="white-space: nowrap">', 5);
            BugNumber := ParserHTML(Response.HTML, 'show_bug.cgi?id=', 1);
            SetRequest('show_bug.cgi', rmGET);
            AddField('id', BugNumber);
            SendResult := SendRequest(Response, False);
            if (SendResult) and
               ((IsSuccessfulSend('show_bug.cgi', 'name="form_name"', '')) or
               // BugZilla 3.x
               (IsSuccessfulSend('show_bug.cgi', 'type="hidden" id="component"', '')) or
               (IsSuccessfulSend('show_bug.cgi', 'select id="component" name="component"', '')) or
               (IsSuccessfulSend('show_bug.cgi', '<label for="component" accesskey="', ''))) then
            begin
              SetRequest('process_bug.cgi', rmPOST);
              if (GetBugCountField('short_desc')) then
              begin
                BugClosed :=
                  ((Pos(LowerCase('value="reopen"'), LowerCase(Response.HTML)) > 0) or
                  // BugZilla 3.x
                  (Pos(LowerCase('value="reopened"'), LowerCase(Response.HTML)) > 0));
                if (BugClosed) then Result := srBugClosed
                else
                begin
                  // Fields...
                  AddFieldValue('delta_ts');
                  AddFieldValue('longdesclength');
                  AddFieldValue('id');
                  AddFieldValue('token');
                  AddFieldValue('alias');
                  AddFieldValue('bug_file_loc');
                  if (Fields.Values['bug_file_loc'] = '') then
                    AddField('bug_file_loc', '');
                  AddFieldByDefaultList('product');
                  AddFieldByDefaultList('component');
                  AddFieldByDefaultList('rep_platform');
                  AddFieldByDefaultList('op_sys');
                  if (Pos('<option value="' + AVersion + '">', FResponse.HTML) > 0) then
                    AddField('version', AVersion)
                  else
                    AddFieldByDefaultList('version');
                  AddFieldByDefaultList('priority');
                  AddFieldByDefaultList('bug_severity');
                  AddFieldByDefaultList('target_milestone');
                  AddFieldValue('newcc');
                  AddFieldValue('cc');
                  AddFieldValue('qa_contact');
                  AddFieldValue('bug_file_loc');
                  AddFieldValue('status_whiteboard');
                  AddFieldValue('keywords');
                  AddField('flag_type-6', 'X');
                  AddFieldValue('requestee_type-6');
                  AddFieldValue('dependson');
                  AddFieldValue('blocked');
                  AddFieldByTextArea('comment');
                  AddField('knob', 'none');
                  AddFieldByDefaultList2('resolution');
                  AddFieldValue('dup_id');
                  AddFieldValue('assigned_to');
                  AddFieldValue('form_name');

                  // Process custom fields...
                  AddCustomFields(ACustomFields);

                  SendResult := SendRequest(Response, True);
                  if (SendResult) and
                    (IsSuccessfulSend('process_bug.cgi', 'show_bug.cgi?id=', '')) then Result := srOK
                  else
                    Result := srInvalidModify;
                end;
              end
              else Result := srOK;
            end
            else Result := srInvalidModify;
          end;
        end
        else Result := srInvalidSearch;
      end
      else Result := srInvalidLogin;
{$IFDEF DEBUG_MODE}
      if (Result <> srOK) then OpenResponseHTMLPage;
{$ENDIF}
    end;
  finally
    Connection.Free;
  end;
end;

//------------------------------------------------------------------------------

{ THTTPFogBugzSendReport }

function THTTPFogBugzSendReport.PostBug(const AVersion, ABugType, ABugText, ABugID,
  ABaseURL, AProxyURL, AUserName, APassword, AProjectName, ACategory, AAssignTo,
  AAttachedFile: AnsiString; ACustomFields: TStrings; var Response: THTTPResponse): TSendResult;
var
  Connection: THTTPConnectionBase;
  SendResult, BugClosed: Boolean;
  BugResult, BugNumber, ActionToken: AnsiString;
  Idx: Integer;
begin
  Connection := FHTTPConnectionClass.Create(ABaseURL, AProxyURL);
  try
    with Connection do
    begin
      SetSendState(ssLogin, 0);
      SetRequest('default.asp', rmPOST);
      AddField('pre', 'preLogon');
      AddField('sPerson', AUserName);
      AddField('sPassword', APassword);
      AddField('fRememberPassword', '0');
      if (ACustomFields.Values['FogBugzTrialID'] <> '') then
        AddField('ID', ACustomFields.Values['FogBugzTrialID']);
      SendResult := SendRequest(Response, False);
      if (SendResult) and IsSuccessfulSend('default.asp', 'pre=preLogOff', '') then
      begin
        SetSendState(ssSearching, 0);
        SetRequest('default.asp', rmGET);
        AddField('pre', 'preSearch');
        AddField('pg', 'pgList');
        AddField('pgBack', 'pgSearch');
        AddField('search', '1');
        AddField('bAlsoSearchClosedBugs', 'ON');
        AddSearchText('searchFor', AVersion, ABugType, ABugID);
        SendResult := SendRequest(Response, False);
        // Check for the just entered BUG-ID...
        if (SendResult) and
          (IsSuccessfulSend('default.asp', 'searchFor=', '')) then
        begin
          // FogBugz 4.x ...
          if ((IsSuccessfulSend('', '', 'default.asp?pg=pgeditbug')) and
            // FogBugz 5.x ...
            (IsSuccessfulSend('', '', 'default.asp?pgx=EV&amp;ixBug='))) then
          begin
            SetSendState(ssSelectProject, 0);
            SetRequest('default.asp', rmGET);
            AddField('command', 'new');
            AddField('pg', 'pgEditBug');
            SendResult := SendRequest(Response, False);
            if (SendResult) and
              (CompareText(Response.ReplayPage, 'default.asp') = 0) then
            begin
              Idx := 0;
              ActionToken :=
                GetTagValue(Response.HTML, 'sActionToken=', ['"'], Idx);
              if (ActionToken <> '') then // FogBugz 6
                SetRequest('default.asp?pre=preSubmitBug&sActionToken=' +
                  ActionToken, rmBinaryPOST)
              else // FogBugz 4/5
                SetRequest('default.asp?pre=preSubmitBug', rmBinaryPOST);
              // Fields...
              AddFieldValue('command');
              AddFieldValue('dtTimeStamp');
              AddFieldValue('ixBug');
              AddFieldValue('ixBugEventLatest');
              AddFieldValue('ixPersonLastOwner');
              AddFieldValue('ixDiscussTopic');
              AddFieldValue('ixScreenshot');
              AddFieldValue('sOriginalTitle');
              AddBugSummary('sTitle', AVersion, ABugType, ABugID);
              AddField('sEvent', AddOptionalField(ABugText, 
                ACustomFields.Values['EL_ReproduceText']));
              AddFieldByListTitle('ixProject', AProjectName);
              AddFieldByListTitle('ixArea', AProjectName + ': ' + ACategory);
              if (AAssignTo = '') then AddFieldByDefaultList('ixPersonAssignedTo')
              else AddFieldByListTitle('ixPersonAssignedTo', AAssignTo);
              AddFieldByDefaultList('ixCategory');
              AddFieldByDefaultList('ixFixFor');
              AddField('ixPriority', '1');
              AddFieldValue('sDueDate');
              AddFieldValue('sDueTime');
              AddField('hrsCurrEstNew', '');
              AddFieldValue('hrsElapsedNew');
              AddFieldValue('omitAtt');
              AddFieldValue('fIEFileBrowse');
              AddField('sVersion', AVersion);
              AddFieldValue('sComputer');
              AddFieldValue('dblTimeStamp');

              // Process custom fields...
              AddCustomFields(ACustomFields);
              
              // File to upload...
              if (AAttachedFile <> '') then
              begin
                Fields.Add('nFileCount=1');
                Files.Add('File1=' + AAttachedFile);
              end
              else Fields.Add('nFileCount=0');
              SendResult := SendRequest(Response, True);
              if (SendResult) and
                (IsSuccessfulSend('default.asp', 'command=resolve', '')) then Result := srOK
              else Result := srInvalidInsert;
            end
            else Result := srInvalidInsert;
          end
          else
          begin
            SetSendState(ssModifying, 0);
            BugResult := ParserHTML(Response.HTML, '<td style="white-space: nowrap">', 5);
            BugNumber := ParserHTML(Response.HTML, 'ixBug=', 1);
            SetRequest('default.asp', rmGET);
            AddField('pg', 'pgEditBug');
            AddField('command', 'edit');
            AddField('ixBug', BugNumber);
            SendResult := SendRequest(Response, False);
            if (SendResult) and
              (IsSuccessfulSend('default.asp', 'name="OK"', '')) then
            begin
              Idx := 0;
              ActionToken :=
                GetTagValue(Response.HTML, 'sActionToken=', ['"'], Idx);
              if (ActionToken <> '') then // FogBugz 6
                SetRequest('default.asp?pre=preSubmitBug&sActionToken=' + ActionToken, rmBinaryPOST)
              else
                SetRequest('default.asp?pre=preSubmitBug', rmBinaryPOST);
              if (GetBugCountField('sTitle')) then
              begin
                BugClosed := (Pos(LowerCase('default.asp?pg=pgEditReleaseNotes'),
                  LowerCase(Response.HTML)) > 0);
                if (BugClosed) then Result := srBugClosed
                else
                begin
                  // Fields...
                  AddFieldValue('command');
                  AddFieldValue('dtTimeStamp');
                  AddField('ixBug', BugNumber);
                  AddFieldValue('ixBugEventLatest');
                  AddFieldValue('ixPersonLastOwner');
                  AddFieldValue('ixDiscussTopic');
                  AddFieldValue('ixScreenshot');
                  AddFieldValue('sOriginalTitle');
                  AddFieldValue('sEvent');
                  AddFieldByDefaultList('ixProject');
                  AddFieldByDefaultList('ixArea');
                  AddFieldByDefaultList('ixPersonAssignedTo');
                  AddFieldByDefaultList('ixCategory');
                  AddFieldByDefaultList('ixFixFor');
                  AddFieldByDefaultList('ixPriority');
                  AddFieldValue('sDueDate');
                  AddFieldValue('sDueTime');
                  AddFieldValue('hrsCurrEstNew');
                  AddFieldValue('hrsElapsedNew');

                  // FogBugz 6.x
                  AddFieldValue('dblTimeStamp');
                  AddFieldValue('fIEFileBrowse');
                  AddFieldValue('fIEFileBrowse');
                  AddFieldValue('hrsCurrEstNew');
                  AddFieldValue('idSubscriptionState');
                  AddFieldValue('ixDiscussTopic');
                  AddFieldValue('ixPersonLastOwner');
                  AddFieldValue('nFileCount');
                  AddFieldValue('omitAtt');
                  AddFieldValue('sComputer');
                  AddFieldByTextArea('sEvent');
                  AddFieldValue('sOriginalTitle');
                  AddField('sVersion', AVersion);

                  // Process custom fields...
                  AddCustomFields(ACustomFields);

                  SendResult := SendRequest(Response, True);
                  if (SendResult) and
                    (IsSuccessfulSend('default.asp', 'command=resolve', '')) then Result := srOK
                  else Result := srInvalidModify;
                end;
              end
              else Result := srOK;
            end
            else Result := srInvalidModify;
          end;
        end
        else Result := srInvalidSearch;
      end
      else Result := srInvalidLogin;
{$IFDEF DEBUG_MODE}
      if (Result <> srOK) then OpenResponseHTMLPage;
{$ENDIF}
    end;
  finally
    Connection.Free;
  end;
end;

//------------------------------------------------------------------------------

function SendWebTrakerReport(HTTPConnectionClass: THTTPConnectionClass;
  BugSenderClass: THTTPSendReportClass; const AVersion, ABugType, ABugText,
  ABugID, ABaseURL, AProxyURL, AUserName, APassword, AProjectName, ACategory,
  AAssignTo, AAttachedFile: AnsiString; ACustomFields: TStrings;
  var Response: THTTPResponse): TSendResult;
var
  BugSender: THTTPSendReport;
begin
  BugSender := BugSenderClass.Create;
  try
    BugSender.SetHTTPConnectionClass(HTTPConnectionClass);
    Result :=
      BugSender.PostBug(AVersion, ABugType, ABugText, ABugID, ABaseURL, AProxyURL,
        AUserName, APassword, AProjectName, ACategory,
        AAssignTo, AAttachedFile, ACustomFields, Response);
//    if (SendResult = srBugClosed) then
//      MessageBox(0, PChar('These BUG is just closed.'#13#10 +
//        'Contact the program support to obtain an update.'), '',
//        MB_ICONINFORMATION or MB_TASKMODAL)
//    else
//      if (SendResult <> srOK) then
//      begin
//        case SendResult of
//          srUnknownError: Error := 'Unknown error.';
//          srInvalidLogin: Error := 'Invalid login request.';
//          srInvalidSearch: Error := 'Invalid selection request.';
//          srInvalidSelection: Error := 'Invalid search request.';
//          srInvalidInsert: Error := 'Invalid insert request.';
//          srInvalidModify: Error := 'Invalid modify request.';
//        end;
//        MessageBox(0, PChar(Format('%s'#13#10#13#10'HTTP response: %s'#13#10'HTTP error: %s',
//          [Error, Response.StatusText, Response.ErrorMessage])), '',
//          MB_ICONERROR or MB_TASKMODAL);
//      end
//      else
//      MessageBoxA(0, 'Posted OK!', '', MB_ICONINFORMATION or MB_TASKMODAL);
  finally
    BugSender.Free;
  end;
end;

//------------------------------------------------------------------------------

function SimpleCheckError(ErrorCondition: Boolean; var TheResult: Integer): Boolean;
begin
  if (ErrorCondition) then
  begin
    TheResult := GetLastError;
    Result := True;
  end
  else Result := False;
end;

//------------------------------------------------------------------------------

procedure SetFTPPassiveMode(Activate: Boolean);
begin
  if (Activate) then PassiveMode := INTERNET_FLAG_PASSIVE
  else PassiveMode := 0;
end;

procedure SetProxyServer(const Server: AnsiString; Port: Word);
begin
  ProxyServer := (Server + ':' + IntToStr(Port));
end;

procedure SetProxyAuthenticationData(const UserID, Password: AnsiString);
begin
  ProxyUserName := UserID;
  ProxyPassword := Password;
end;

function CheckInternetConnection: Boolean;
var
  ConnectionType: DWord;
begin
  Result := False;
  if (not InitLib) then Exit;
  try
    Result := (InternetGetConnectedState(@ConnectionType, 0)) and
      (((ConnectionType and INTERNET_CONNECTION_LAN) > 0) or
      ((ConnectionType and INTERNET_CONNECTION_MODEM) > 0) or
      ((ConnectionType and INTERNET_CONNECTION_PROXY) > 0));
  finally
    DoneLib;
  end;
end;

function HTTPUploadFiles(const Host, Path, UserID, Password: AnsiString;
  Port: Word; HTTPS: Boolean; LocalFiles, RemoteFiles, WebFields: TStrings;
  ProgressProc: TInternetProgressFunction; var ResultMsg: AnsiString): Integer;
var
  boundary, Header, requestBody, StrSend: RawByteString;
  StatusStr: AnsiString;
  hInternet, hConnect, hRequest: Pointer;
  dwBytesWritten, n, Steps, TotalSize, Index, SendBytes, StatusCode: DWord;
  Code: Integer;
  bResult: Boolean;
  BufferIn: INTERNET_BUFFERS;

  function GenerateMultipartBoundary: RawByteString;
  begin
    Result := '---------------------------' + IntToHex(Random($FFFF), 4) +
      IntToHex(Random($FFFF), 4) + IntToHex(Random($FFFF), 4);
  end;

  function GetFileContents(const FileName: String): RawByteString;
  var
    F: TMemoryStream;
  begin
    F := TMemoryStream.Create;
    try
      F.LoadFromFile(FileName);
      SetString(Result, PAnsiChar(F.Memory), F.Size);
    finally
      F.Free;
    end;
  end;

  function GenerateRequestBody(const LocalFiles, RemoteFiles,
    WebFields: TStrings; Boundary: RawByteString): RawByteString;
  var
    n: integer;
  begin
    Result := '';

    if (WebFields <> nil) then
    begin
      for n := 0 to (WebFields.Count - 1) do
      begin
        Result := Result + '--' + boundary + #13#10 +
          'Content-Disposition: form-data; name="' + RawByteString(WebFields.Names[n]) + '";'#13#10#13#10 +
          RawByteString(WebFields.Values[WebFields.Names[n]]) + #13#10;
      end;
    end;

    if ((LocalFiles <> nil) and (RemoteFiles <> nil)) then
    begin
      for n := 0 to (LocalFiles.Count - 1) do
      begin
        if (IsRealFile(LocalFiles[n])) then
          Result := Result + '--' + boundary + #13#10 +
            'Content-Disposition: form-data; name="el_upload_file_' + RawByteString(IntToStr(n)) + '"; filename="' + RawByteString(RemoteFiles[n]) + '";'#13#10 +
            'Content-Type: application/octet-stream'#13#10#13#10 +
            GetFileContents(LocalFiles[n]) + #13#10;
      end;
    end;

    Result := (Result + '--' + boundary + '--'#13#10);
  end;

  procedure GetHTTPResponse(Flag: DWord; var s: AnsiString);
  var
    dwInfoBufferLength, dwIndex: DWord;
    pInfoBuffer: PAnsiChar;
  begin
    dwInfoBufferLength := 10;
    dwIndex := 0;
    GetMem(pInfoBuffer, (dwInfoBufferLength + 1));
    try
      while (not HttpQueryInfo(hRequest, Flag, pInfoBuffer, dwInfoBufferLength, dwIndex)) do
      begin
        if (GetLastError = ERROR_INSUFFICIENT_BUFFER) then
        begin
          FreeMem(pInfoBuffer);
          GetMem(pInfoBuffer, (dwInfoBufferLength + 1));
        end
        else
        begin
          SimpleCheckError(True, Result);
          Exit;
        end;
      end;
      SetString(s, pInfoBuffer, dwInfoBufferLength);
    finally
      FreeMem(pInfoBuffer);
    end;
  end;

  procedure OpenRequest;
  var
    dwOpenRequestFlags, dwBuffLen, dwFlags: DWord;
  begin
    dwOpenRequestFlags := (INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP or
      INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS or INTERNET_FLAG_KEEP_CONNECTION or
      INTERNET_FLAG_NO_AUTO_REDIRECT or INTERNET_FLAG_NO_COOKIES or
      INTERNET_FLAG_NO_UI or INTERNET_FLAG_RELOAD or INTERNET_FLAG_NO_CACHE_WRITE);

    if (HTTPS) then dwOpenRequestFlags := (dwOpenRequestFlags or INTERNET_FLAG_SECURE or
      INTERNET_FLAG_IGNORE_CERT_CN_INVALID or INTERNET_FLAG_IGNORE_CERT_DATE_INVALID);

    hRequest := HttpOpenRequest(hConnect, 'POST', PAnsiChar(Path),
      nil, nil, nil, dwOpenRequestFlags, nil);
    if SimpleCheckError(hRequest = nil, Result) then Exit;

    if (HTTPS) then
    begin
      dwBuffLen := SizeOf(dwFlags);
      InternetQueryOption(hRequest, INTERNET_OPTION_SECURITY_FLAGS, @dwFlags, dwBuffLen);
      dwFlags := (dwFlags or SECURITY_FLAG_IGNORE_UNKNOWN_CA);
      InternetSetOption(hRequest, INTERNET_OPTION_SECURITY_FLAGS, @dwFlags, SizeOf(dwFlags));
    end;

    bResult :=
      HttpAddRequestHeaders(hRequest, PAnsiChar(Header), DWord(-1), HTTP_ADDREQ_FLAG_ADD);
    if SimpleCheckError(not bResult, Result) then Exit;

    if ((UserID <> '') or (Password <> '')) then
    begin
      Header :=
        ('Authorization: Basic ' + Base64EncodeString(UserID + ':' + Password));
      bResult :=
        HttpAddRequestHeaders(hRequest, PAnsiChar(Header), DWord(-1), HTTP_ADDREQ_FLAG_ADD);
    end;

    if SimpleCheckError(not bResult, Result) then Exit;
  end;

begin
  Result := 0;
  ResultMsg := '';
  if (not InitLib) then
  begin
    Result := Error_NetLibNotFound;
    Exit;
  end;
  try
    boundary := GenerateMultipartBoundary;
    // application/x-www-form-urlencoded; Standard encoding type.
    Header := 'Content-Type: multipart/form-data; boundary=' + boundary;
    requestBody := GenerateRequestBody(LocalFiles, RemoteFiles, WebFields, boundary);
    TotalSize := Length(requestBody);

    if (Assigned(ProgressProc)) then ProgressProc(ctConnection, TotalSize, 0);

    if (ProxyServer = '') then
      hInternet := InternetOpen('EurekaLog', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0)
    else
      hInternet := InternetOpen('EurekaLog', INTERNET_OPEN_TYPE_PROXY,
        PAnsiChar(ProxyServer), '<local>', 0);
    if SimpleCheckError(hInternet = nil, Result) then Exit;
    try
      hConnect := InternetConnect(
        hInternet, PAnsiChar(Host), Port, nil, nil, INTERNET_SERVICE_HTTP, 0, 0);
      if SimpleCheckError(hConnect = nil, Result) then Exit;
      try
        if (Assigned(ProgressProc)) then ProgressProc(ctConnected, TotalSize, 0);

        OpenRequest;
        if (Result <> 0) then Exit;

        if ((ProxyUserName <> '') or (ProxyPassword <> '')) then
        begin
          bResult := InternetSetOption(hRequest, INTERNET_OPTION_PROXY_USERNAME,
            PAnsiChar(ProxyUserName), Length(ProxyUserName) + 1);
          if SimpleCheckError(not bResult, Result) then Exit;

          bResult := InternetSetOption(hRequest, INTERNET_OPTION_PROXY_PASSWORD,
            PAnsiChar(ProxyPassword), Length(ProxyPassword) + 1);
          if SimpleCheckError(not bResult, Result) then Exit;
        end;

        FillChar(BufferIn, SizeOf(BufferIn), 0);
        BufferIn.dwStructSize := SizeOf(INTERNET_BUFFERS);
        BufferIn.dwBufferTotal := TotalSize;
        bResult := HttpSendRequestEx(hRequest, @BufferIn, nil, 0, 0);
        if SimpleCheckError(not bResult, Result) then Exit;
        try
          Steps := (TotalSize div 1024);
          if (TotalSize mod 1024 > 0) then Inc(Steps);
          for n := 0 to (Steps - 1) do
          begin
            Index := (1024 * n);
            StrSend := Copy(requestBody, (Index + 1), 1024);
            InternetWriteFile(hRequest, PAnsiChar(StrSend), Length(StrSend), dwBytesWritten);
            if (Assigned(ProgressProc)) then
            begin
              SendBytes := (Index + 1024);
              if (SendBytes > TotalSize) then SendBytes := TotalSize;
              ProgressProc(ctSending, TotalSize, SendBytes);
            end;
          end;
        finally
          HttpEndRequest(hRequest, nil, 0, 0);
        end;

        GetHTTPResponse(HTTP_QUERY_STATUS_CODE, StatusStr);
        Val(StatusStr, StatusCode, Code);
        if (Code = 0) then
          if (StatusCode = HTTP_STATUS_OK) then Result := 0
          else Result := StatusCode
        else
          Result := GenericNetError;
        if (Result <> 0) then GetHTTPResponse(HTTP_QUERY_STATUS_TEXT, ResultMsg);

      finally
        InternetCloseHandle(hConnect);
      end;
    finally
      InternetCloseHandle(hInternet);
    end;
  finally
    if (Result <> 0) and (ResultMsg = '') then
      ResultMsg := FindErrorMessage(Result);
    DoneLib;
  end;
end;

function FTPUploadFiles(const Host, Path, UserID, Password: AnsiString;
  Port: Word; LocalFiles, RemoteFiles: TStrings;
  ProgressProc: TInternetProgressFunction; var ResultMsg: AnsiString): Integer;
var
  Data: TMemoryStream;
  hFile, hInternet, hConnect: Pointer;
  dwBytesWritten, n, i, Size, Steps, Len, Index, TotalSize: DWord;
  PathStr: AnsiString;

  function GetFileSize(const FileName: AnsiString): DWord;
  var
    FFD: TWin32FindDataA;
  begin
    if Windows.FindClose(Windows.FindFirstFileA(PAnsiChar(FileName), FFD)) then
      Result := FFD.nFileSizeLow
    else Result := 0;
  end;

begin
  Result := 0;
  ResultMsg := '';
  if (LocalFiles.Count = 0) then Exit;
  if (not InitLib) then
  begin
    Result := Error_NetLibNotFound;
    Exit;
  end;
  try
    TotalSize := 0;
    for i := 0 to (LocalFiles.Count - 1) do
      if (IsRealFile(LocalFiles[i])) then Inc(TotalSize, GetFileSize(LocalFiles[i]));

    if (Assigned(ProgressProc)) then ProgressProc(ctConnection, TotalSize, 0);

    if (ProxyServer = '') then
      hInternet := InternetOpen('EurekaLog', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0)
    else
      hInternet := InternetOpen('EurekaLog', INTERNET_OPEN_TYPE_PROXY,
        PAnsiChar(ProxyServer), '<local>', 0);
    if SimpleCheckError(hInternet = nil, Result) then Exit;
    try
      hConnect := InternetConnect(hInternet, PAnsiChar(Host), Port,
        PAnsiChar(UserID), PAnsiChar(Password), INTERNET_SERVICE_FTP,
        PassiveMode, 0);
      if SimpleCheckError(hConnect = nil, Result) then Exit;
      try
        if (Assigned(ProgressProc)) then ProgressProc(ctConnected, TotalSize, 0);

        Data := TMemoryStream.Create;
        try
          for i := 0 to (LocalFiles.Count - 1) do
            if (IsRealFile(LocalFiles[i])) then
            begin
              if (Path <> '') and (Path[Length(Path)] <> '/') then PathStr := (Path + '/')
              else PathStr := Path;
              hFile := FtpOpenFile(hConnect,
                PAnsiChar(PathStr + AnsiString(ExtractFileName(RemoteFiles[i]))),
                GENERIC_WRITE, FTP_TRANSFER_TYPE_BINARY, 0);
              if SimpleCheckError(hFile = nil, Result) then Exit;

              try
                Data.LoadFromFile(LocalFiles[i]);
                Size := Data.Size;
                Steps := (Size div 1024);
                if (Size mod 1024 > 0) then Inc(Steps);
                Index := 0;
                for n := 0 to (Steps - 1) do
                begin
                  Len := (Size - Index);
                  if (Len > 1024) then Len := 1024;
                  InternetWriteFile(hFile, PAnsiChar(DWord(Data.Memory) + Index), Len, dwBytesWritten);
                  Inc(Index, 1024);
                  if (Assigned(ProgressProc)) then ProgressProc(ctSending, TotalSize, Index);
                end;
              finally
                InternetCloseHandle(hFile);
              end;
            end;
        finally
          Data.Free;
        end;
      finally
        InternetCloseHandle(hConnect);
      end;
    finally
      InternetCloseHandle(hInternet);
    end;
  finally
    if (Result <> 0) and (ResultMsg = '') then
      ResultMsg := FindErrorMessage(Result);
    DoneLib;
  end;
end;

function GetHTMLPage(const URL: AnsiString; var HTML: AnsiString): Boolean;
const
  BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer: array [0..BufferSize - 1] of AnsiChar;
  BufferLength: DWord;
begin
  Result := False;
  if (not InitLib) then Exit;
  try
    HTML := '';
    if (ProxyServer = '') then
      hSession := InternetOpen('EurekaLog', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0)
    else
      hSession := InternetOpen('EurekaLog', INTERNET_OPEN_TYPE_PROXY,
        PAnsiChar(ProxyServer), '<local>', 0);
    try
      hURL := InternetOpenURL(hSession,PAnsiChar(URL), nil, 0, 0, 0);
      if Assigned(hURL) then
       try
         repeat
           InternetReadFile(hURL, @Buffer, BufferSize, BufferLength);
           if (BufferLength > 0) then HTML := (HTML + Copy(Buffer, 1, BufferLength));
         until (BufferLength = 0);
         Result := True;
       finally
         InternetCloseHandle(hURL);
       end;
    finally
      InternetCloseHandle(hSession);
    end;
  finally
    DoneLib;
  end;
end;

{ THTTPSendReport }

constructor THTTPSendReport.Create;
begin
  SetHTTPConnectionClass(THTTPConnectionBase);
end;

procedure THTTPSendReport.SetHTTPConnectionClass(ClassType: THTTPConnectionClass);
begin
  FHTTPConnectionClass := ClassType;
end;

{ THTTPResponse }

procedure THTTPResponse.Assign(Source: THTTPResponse);
begin
  Assert(Source <> nil, 'Cannot assign a THTTPResponse class to a NIL value.');
  StatusCode   := Source.StatusCode;
  StatusText   := Source.StatusText;
  Header       := Source.Header;
  HTML         := Source.HTML;
  ReplayPage   := Source.ReplayPage;
  ErrorCode    := Source.ErrorCode;
  ErrorMessage := Source.ErrorMessage;
end;

procedure THTTPResponse.Clear;
begin
  StatusCode   := 0;
  StatusText   := '';
  Header       := '';
  HTML         := '';
  ReplayPage   := '';
  ErrorCode    := 0;
  ErrorMessage := '';
end;

end.
