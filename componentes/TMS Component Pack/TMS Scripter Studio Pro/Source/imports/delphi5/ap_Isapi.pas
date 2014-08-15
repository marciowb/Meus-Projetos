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
unit ap_Isapi;

interface

uses
  Windows,
  Isapi,
  atScript;

{$WARNINGS OFF}

type
  TatIsapiLibrary = class(TatScripterLibrary)
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



procedure TatIsapiLibrary.Init;
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
  end;
end;

class function TatIsapiLibrary.LibraryName: string;
begin
  result := 'Isapi';
end;

initialization
  RegisterScripterLibrary(TatIsapiLibrary, True);

{$WARNINGS ON}

end.

