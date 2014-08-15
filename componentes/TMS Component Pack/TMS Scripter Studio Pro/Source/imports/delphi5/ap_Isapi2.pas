{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_Isapi2;

interface

uses
  Windows,
  Isapi2,
  atScript;

{$WARNINGS OFF}

type
  TatIsapi2Library = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  HSE_VERSION_INFOWrapper = class(TatRecordWrapper)
  private
    FdwExtensionVersion: DWORD;
  public
    constructor Create(ARecord: HSE_VERSION_INFO);
    function ObjToRec: HSE_VERSION_INFO;
  published
    property dwExtensionVersion: DWORD read FdwExtensionVersion write FdwExtensionVersion;
  end;
  
  TEXTENSION_CONTROL_BLOCKWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwVersion: DWORD;
    FConnID: HCONN;
    FdwHttpStatusCode: DWORD;
    FcbTotalBytes: DWORD;
    FcbAvailable: DWORD;
  public
    constructor Create(ARecord: TEXTENSION_CONTROL_BLOCK);
    function ObjToRec: TEXTENSION_CONTROL_BLOCK;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwVersion: DWORD read FdwVersion write FdwVersion;
    property ConnID: HCONN read FConnID write FConnID;
    property dwHttpStatusCode: DWORD read FdwHttpStatusCode write FdwHttpStatusCode;
    property cbTotalBytes: DWORD read FcbTotalBytes write FcbTotalBytes;
    property cbAvailable: DWORD read FcbAvailable write FcbAvailable;
  end;
  
  THSE_TF_INFOWrapper = class(TatRecordWrapper)
  private
    FhFile: THandle;
    FBytesToWrite: DWORD;
    FOffset: DWORD;
    FHeadLength: DWORD;
    FTailLength: DWORD;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: THSE_TF_INFO);
    function ObjToRec: THSE_TF_INFO;
  published
    property hFile: THandle read FhFile write FhFile;
    property BytesToWrite: DWORD read FBytesToWrite write FBytesToWrite;
    property Offset: DWORD read FOffset write FOffset;
    property HeadLength: DWORD read FHeadLength write FHeadLength;
    property TailLength: DWORD read FTailLength write FTailLength;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  THTTP_FILTER_CONTEXTWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FRevision: DWORD;
    FulReserved: DWORD;
    FfIsSecurePort: BOOL;
  public
    constructor Create(ARecord: THTTP_FILTER_CONTEXT);
    function ObjToRec: THTTP_FILTER_CONTEXT;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property Revision: DWORD read FRevision write FRevision;
    property ulReserved: DWORD read FulReserved write FulReserved;
    property fIsSecurePort: BOOL read FfIsSecurePort write FfIsSecurePort;
  end;
  
  HTTP_FILTER_RAW_DATAWrapper = class(TatRecordWrapper)
  private
    FcbInData: DWORD;
    FcbInBuffer: DWORD;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: HTTP_FILTER_RAW_DATA);
    function ObjToRec: HTTP_FILTER_RAW_DATA;
  published
    property cbInData: DWORD read FcbInData write FcbInData;
    property cbInBuffer: DWORD read FcbInBuffer write FcbInBuffer;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  THTTP_FILTER_PREPROC_HEADERSWrapper = class(TatRecordWrapper)
  private
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: THTTP_FILTER_PREPROC_HEADERS);
    function ObjToRec: THTTP_FILTER_PREPROC_HEADERS;
  published
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  HTTP_FILTER_AUTHENTWrapper = class(TatRecordWrapper)
  private
    FcbUserBuff: DWORD;
    FcbPasswordBuff: DWORD;
  public
    constructor Create(ARecord: HTTP_FILTER_AUTHENT);
    function ObjToRec: HTTP_FILTER_AUTHENT;
  published
    property cbUserBuff: DWORD read FcbUserBuff write FcbUserBuff;
    property cbPasswordBuff: DWORD read FcbPasswordBuff write FcbPasswordBuff;
  end;
  
  HTTP_FILTER_URL_MAPWrapper = class(TatRecordWrapper)
  private
    FcbPathBuff: DWORD;
  public
    constructor Create(ARecord: HTTP_FILTER_URL_MAP);
    function ObjToRec: HTTP_FILTER_URL_MAP;
  published
    property cbPathBuff: DWORD read FcbPathBuff write FcbPathBuff;
  end;
  
  HTTP_FILTER_ACCESS_DENIEDWrapper = class(TatRecordWrapper)
  private
    FdwReason: DWORD;
  public
    constructor Create(ARecord: HTTP_FILTER_ACCESS_DENIED);
    function ObjToRec: HTTP_FILTER_ACCESS_DENIED;
  published
    property dwReason: DWORD read FdwReason write FdwReason;
  end;
  
  HTTP_FILTER_LOGWrapper = class(TatRecordWrapper)
  private
    FdwHttpStatus: DWORD;
    FdwWin32Status: DWORD;
  public
    constructor Create(ARecord: HTTP_FILTER_LOG);
    function ObjToRec: HTTP_FILTER_LOG;
  published
    property dwHttpStatus: DWORD read FdwHttpStatus write FdwHttpStatus;
    property dwWin32Status: DWORD read FdwWin32Status write FdwWin32Status;
  end;
  
  HTTP_FILTER_VERSIONWrapper = class(TatRecordWrapper)
  private
    FdwServerFilterVersion: DWORD;
    FdwFilterVersion: DWORD;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: HTTP_FILTER_VERSION);
    function ObjToRec: HTTP_FILTER_VERSION;
  published
    property dwServerFilterVersion: DWORD read FdwServerFilterVersion write FdwServerFilterVersion;
    property dwFilterVersion: DWORD read FdwFilterVersion write FdwFilterVersion;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  

implementation

constructor HSE_VERSION_INFOWrapper.Create(ARecord: HSE_VERSION_INFO);
begin
  inherited Create;
  FdwExtensionVersion := ARecord.dwExtensionVersion;
end;

function HSE_VERSION_INFOWrapper.ObjToRec: HSE_VERSION_INFO;
begin
  result.dwExtensionVersion := FdwExtensionVersion;
end;

constructor TEXTENSION_CONTROL_BLOCKWrapper.Create(ARecord: TEXTENSION_CONTROL_BLOCK);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwVersion := ARecord.dwVersion;
  FConnID := ARecord.ConnID;
  FdwHttpStatusCode := ARecord.dwHttpStatusCode;
  FcbTotalBytes := ARecord.cbTotalBytes;
  FcbAvailable := ARecord.cbAvailable;
end;

function TEXTENSION_CONTROL_BLOCKWrapper.ObjToRec: TEXTENSION_CONTROL_BLOCK;
begin
  result.cbSize := FcbSize;
  result.dwVersion := FdwVersion;
  result.ConnID := FConnID;
  result.dwHttpStatusCode := FdwHttpStatusCode;
  result.cbTotalBytes := FcbTotalBytes;
  result.cbAvailable := FcbAvailable;
end;

constructor THSE_TF_INFOWrapper.Create(ARecord: THSE_TF_INFO);
begin
  inherited Create;
  FhFile := ARecord.hFile;
  FBytesToWrite := ARecord.BytesToWrite;
  FOffset := ARecord.Offset;
  FHeadLength := ARecord.HeadLength;
  FTailLength := ARecord.TailLength;
  FdwFlags := ARecord.dwFlags;
end;

function THSE_TF_INFOWrapper.ObjToRec: THSE_TF_INFO;
begin
  result.hFile := FhFile;
  result.BytesToWrite := FBytesToWrite;
  result.Offset := FOffset;
  result.HeadLength := FHeadLength;
  result.TailLength := FTailLength;
  result.dwFlags := FdwFlags;
end;

constructor THTTP_FILTER_CONTEXTWrapper.Create(ARecord: THTTP_FILTER_CONTEXT);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FRevision := ARecord.Revision;
  FulReserved := ARecord.ulReserved;
  FfIsSecurePort := ARecord.fIsSecurePort;
end;

function THTTP_FILTER_CONTEXTWrapper.ObjToRec: THTTP_FILTER_CONTEXT;
begin
  result.cbSize := FcbSize;
  result.Revision := FRevision;
  result.ulReserved := FulReserved;
  result.fIsSecurePort := FfIsSecurePort;
end;

constructor HTTP_FILTER_RAW_DATAWrapper.Create(ARecord: HTTP_FILTER_RAW_DATA);
begin
  inherited Create;
  FcbInData := ARecord.cbInData;
  FcbInBuffer := ARecord.cbInBuffer;
  FdwReserved := ARecord.dwReserved;
end;

function HTTP_FILTER_RAW_DATAWrapper.ObjToRec: HTTP_FILTER_RAW_DATA;
begin
  result.cbInData := FcbInData;
  result.cbInBuffer := FcbInBuffer;
  result.dwReserved := FdwReserved;
end;

constructor THTTP_FILTER_PREPROC_HEADERSWrapper.Create(ARecord: THTTP_FILTER_PREPROC_HEADERS);
begin
  inherited Create;
  FdwReserved := ARecord.dwReserved;
end;

function THTTP_FILTER_PREPROC_HEADERSWrapper.ObjToRec: THTTP_FILTER_PREPROC_HEADERS;
begin
  result.dwReserved := FdwReserved;
end;

constructor HTTP_FILTER_AUTHENTWrapper.Create(ARecord: HTTP_FILTER_AUTHENT);
begin
  inherited Create;
  FcbUserBuff := ARecord.cbUserBuff;
  FcbPasswordBuff := ARecord.cbPasswordBuff;
end;

function HTTP_FILTER_AUTHENTWrapper.ObjToRec: HTTP_FILTER_AUTHENT;
begin
  result.cbUserBuff := FcbUserBuff;
  result.cbPasswordBuff := FcbPasswordBuff;
end;

constructor HTTP_FILTER_URL_MAPWrapper.Create(ARecord: HTTP_FILTER_URL_MAP);
begin
  inherited Create;
  FcbPathBuff := ARecord.cbPathBuff;
end;

function HTTP_FILTER_URL_MAPWrapper.ObjToRec: HTTP_FILTER_URL_MAP;
begin
  result.cbPathBuff := FcbPathBuff;
end;

constructor HTTP_FILTER_ACCESS_DENIEDWrapper.Create(ARecord: HTTP_FILTER_ACCESS_DENIED);
begin
  inherited Create;
  FdwReason := ARecord.dwReason;
end;

function HTTP_FILTER_ACCESS_DENIEDWrapper.ObjToRec: HTTP_FILTER_ACCESS_DENIED;
begin
  result.dwReason := FdwReason;
end;

constructor HTTP_FILTER_LOGWrapper.Create(ARecord: HTTP_FILTER_LOG);
begin
  inherited Create;
  FdwHttpStatus := ARecord.dwHttpStatus;
  FdwWin32Status := ARecord.dwWin32Status;
end;

function HTTP_FILTER_LOGWrapper.ObjToRec: HTTP_FILTER_LOG;
begin
  result.dwHttpStatus := FdwHttpStatus;
  result.dwWin32Status := FdwWin32Status;
end;

constructor HTTP_FILTER_VERSIONWrapper.Create(ARecord: HTTP_FILTER_VERSION);
begin
  inherited Create;
  FdwServerFilterVersion := ARecord.dwServerFilterVersion;
  FdwFilterVersion := ARecord.dwFilterVersion;
  FdwFlags := ARecord.dwFlags;
end;

function HTTP_FILTER_VERSIONWrapper.ObjToRec: HTTP_FILTER_VERSION;
begin
  result.dwServerFilterVersion := FdwServerFilterVersion;
  result.dwFilterVersion := FdwFilterVersion;
  result.dwFlags := FdwFlags;
end;



procedure TatIsapi2Library.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('HSE_VERSION_MAJOR',HSE_VERSION_MAJOR);
    AddConstant('HSE_VERSION_MINOR',HSE_VERSION_MINOR);
    AddConstant('HSE_LOG_BUFFER_LEN',HSE_LOG_BUFFER_LEN);
    AddConstant('HSE_MAX_EXT_DLL_NAME_LEN',HSE_MAX_EXT_DLL_NAME_LEN);
    AddConstant('HSE_STATUS_SUCCESS',HSE_STATUS_SUCCESS);
    AddConstant('HSE_STATUS_SUCCESS_AND_KEEP_CONN',HSE_STATUS_SUCCESS_AND_KEEP_CONN);
    AddConstant('HSE_STATUS_PENDING',HSE_STATUS_PENDING);
    AddConstant('HSE_STATUS_ERROR',HSE_STATUS_ERROR);
    AddConstant('HSE_REQ_BASE',HSE_REQ_BASE);
    AddConstant('HSE_REQ_SEND_URL_REDIRECT_RESP',HSE_REQ_SEND_URL_REDIRECT_RESP);
    AddConstant('HSE_REQ_SEND_URL',HSE_REQ_SEND_URL);
    AddConstant('HSE_REQ_SEND_RESPONSE_HEADER',HSE_REQ_SEND_RESPONSE_HEADER);
    AddConstant('HSE_REQ_DONE_WITH_SESSION',HSE_REQ_DONE_WITH_SESSION);
    AddConstant('HSE_REQ_END_RESERVED',HSE_REQ_END_RESERVED);
    AddConstant('HSE_REQ_MAP_URL_TO_PATH',HSE_REQ_MAP_URL_TO_PATH);
    AddConstant('HSE_REQ_GET_SSPI_INFO',HSE_REQ_GET_SSPI_INFO);
    AddConstant('HSE_APPEND_LOG_PARAMETER',HSE_APPEND_LOG_PARAMETER);
    AddConstant('HSE_REQ_SEND_URL_EX',HSE_REQ_SEND_URL_EX);
    AddConstant('HSE_REQ_IO_COMPLETION',HSE_REQ_IO_COMPLETION);
    AddConstant('HSE_REQ_TRANSMIT_FILE',HSE_REQ_TRANSMIT_FILE);
    AddConstant('HSE_REQ_REFRESH_ISAPI_ACL',HSE_REQ_REFRESH_ISAPI_ACL);
    AddConstant('HSE_TERM_ADVISORY_UNLOAD',HSE_TERM_ADVISORY_UNLOAD);
    AddConstant('HSE_TERM_MUST_UNLOAD',HSE_TERM_MUST_UNLOAD);
    AddConstant('HTTP_FILTER_REVISION',HTTP_FILTER_REVISION);
    AddConstant('SF_MAX_USERNAME',SF_MAX_USERNAME);
    AddConstant('SF_MAX_PASSWORD',SF_MAX_PASSWORD);
    AddConstant('SF_MAX_FILTER_DESC_LEN',SF_MAX_FILTER_DESC_LEN);
    AddConstant('SF_REQ_SEND_RESPONSE_HEADER',SF_REQ_SEND_RESPONSE_HEADER);
    AddConstant('SF_REQ_ADD_HEADERS_ON_DENIAL',SF_REQ_ADD_HEADERS_ON_DENIAL);
    AddConstant('SF_REQ_SET_NEXT_READ_SIZE',SF_REQ_SET_NEXT_READ_SIZE);
    AddConstant('SF_REQ_SET_PROXY_INFO',SF_REQ_SET_PROXY_INFO);
    AddConstant('SF_STATUS_REQ_FINISHED',SF_STATUS_REQ_FINISHED);
    AddConstant('SF_STATUS_REQ_FINISHED_KEEP_CONN',SF_STATUS_REQ_FINISHED_KEEP_CONN);
    AddConstant('SF_STATUS_REQ_NEXT_NOTIFICATION',SF_STATUS_REQ_NEXT_NOTIFICATION);
    AddConstant('SF_STATUS_REQ_HANDLED_NOTIFICATION',SF_STATUS_REQ_HANDLED_NOTIFICATION);
    AddConstant('SF_STATUS_REQ_ERROR',SF_STATUS_REQ_ERROR);
    AddConstant('SF_STATUS_REQ_READ_NEXT',SF_STATUS_REQ_READ_NEXT);
    AddConstant('SF_DENIED_LOGON',SF_DENIED_LOGON);
    AddConstant('SF_DENIED_RESOURCE',SF_DENIED_RESOURCE);
    AddConstant('SF_DENIED_FILTER',SF_DENIED_FILTER);
    AddConstant('SF_DENIED_APPLICATION',SF_DENIED_APPLICATION);
    AddConstant('SF_DENIED_BY_CONFIG',SF_DENIED_BY_CONFIG);
    AddConstant('SF_NOTIFY_SECURE_PORT',SF_NOTIFY_SECURE_PORT);
    AddConstant('SF_NOTIFY_NONSECURE_PORT',SF_NOTIFY_NONSECURE_PORT);
    AddConstant('SF_NOTIFY_READ_RAW_DATA',SF_NOTIFY_READ_RAW_DATA);
    AddConstant('SF_NOTIFY_PREPROC_HEADERS',SF_NOTIFY_PREPROC_HEADERS);
    AddConstant('SF_NOTIFY_AUTHENTICATION',SF_NOTIFY_AUTHENTICATION);
    AddConstant('SF_NOTIFY_URL_MAP',SF_NOTIFY_URL_MAP);
    AddConstant('SF_NOTIFY_ACCESS_DENIED',SF_NOTIFY_ACCESS_DENIED);
    AddConstant('SF_NOTIFY_SEND_RAW_DATA',SF_NOTIFY_SEND_RAW_DATA);
    AddConstant('SF_NOTIFY_LOG',SF_NOTIFY_LOG);
    AddConstant('SF_NOTIFY_END_OF_NET_SESSION',SF_NOTIFY_END_OF_NET_SESSION);
    AddConstant('SF_NOTIFY_ORDER_HIGH',SF_NOTIFY_ORDER_HIGH);
    AddConstant('SF_NOTIFY_ORDER_MEDIUM',SF_NOTIFY_ORDER_MEDIUM);
    AddConstant('SF_NOTIFY_ORDER_LOW',SF_NOTIFY_ORDER_LOW);
    AddConstant('SF_NOTIFY_ORDER_DEFAULT',SF_NOTIFY_ORDER_DEFAULT);
    AddConstant('SF_NOTIFY_ORDER_MASK',SF_NOTIFY_ORDER_MASK);
  end;
end;

class function TatIsapi2Library.LibraryName: string;
begin
  result := 'Isapi2';
end;

initialization
  RegisterScripterLibrary(TatIsapi2Library, True);

{$WARNINGS ON}

end.

