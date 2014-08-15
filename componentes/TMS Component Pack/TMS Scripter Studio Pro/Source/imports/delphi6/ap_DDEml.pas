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
unit ap_DDEml;

interface

uses
  Windows,
  DDEml,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDDEmlLibrary = class(TatScripterLibrary)
    procedure __DdeUninitialize(AMachine: TatVirtualMachine);
    procedure __DdeQueryNextServer(AMachine: TatVirtualMachine);
    procedure __DdeDisconnectList(AMachine: TatVirtualMachine);
    procedure __DdeDisconnect(AMachine: TatVirtualMachine);
    procedure __DdeReconnect(AMachine: TatVirtualMachine);
    procedure __DdeSetUserHandle(AMachine: TatVirtualMachine);
    procedure __DdeAbandonTransaction(AMachine: TatVirtualMachine);
    procedure __DdePostAdvise(AMachine: TatVirtualMachine);
    procedure __DdeEnableCallback(AMachine: TatVirtualMachine);
    procedure __DdeNameService(AMachine: TatVirtualMachine);
    procedure __DdeUnaccessData(AMachine: TatVirtualMachine);
    procedure __DdeFreeDataHandle(AMachine: TatVirtualMachine);
    procedure __DdeGetLastError(AMachine: TatVirtualMachine);
    procedure __DdeCreateStringHandleA(AMachine: TatVirtualMachine);
    procedure __DdeCreateStringHandleW(AMachine: TatVirtualMachine);
    procedure __DdeCreateStringHandle(AMachine: TatVirtualMachine);
    procedure __DdeQueryStringA(AMachine: TatVirtualMachine);
    procedure __DdeQueryStringW(AMachine: TatVirtualMachine);
    procedure __DdeQueryString(AMachine: TatVirtualMachine);
    procedure __DdeFreeStringHandle(AMachine: TatVirtualMachine);
    procedure __DdeKeepStringHandle(AMachine: TatVirtualMachine);
    procedure __DdeCmpStringHandles(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  tagHSZPAIRWrapper = class(TatRecordWrapper)
  private
    FhszSvc: HSZ;
    FhszTopic: HSZ;
  public
    constructor Create(ARecord: tagHSZPAIR);
    function ObjToRec: tagHSZPAIR;
  published
    property hszSvc: HSZ read FhszSvc write FhszSvc;
    property hszTopic: HSZ read FhszTopic write FhszTopic;
  end;
  
  tagCONVCONTEXTWrapper = class(TatRecordWrapper)
  private
    Fcb: UINT;
    FwFlags: UINT;
    FwCountryID: UINT;
    FiCodePage: Integer;
    FdwLangID: DWORD;
    FdwSecurity: DWORD;
  public
    constructor Create(ARecord: tagCONVCONTEXT);
    function ObjToRec: tagCONVCONTEXT;
  published
    property cb: UINT read Fcb write Fcb;
    property wFlags: UINT read FwFlags write FwFlags;
    property wCountryID: UINT read FwCountryID write FwCountryID;
    property iCodePage: Integer read FiCodePage write FiCodePage;
    property dwLangID: DWORD read FdwLangID write FdwLangID;
    property dwSecurity: DWORD read FdwSecurity write FdwSecurity;
  end;
  
  tagCONVINFOWrapper = class(TatRecordWrapper)
  private
    Fcb: DWORD;
    FhUser: DWORD;
    FhConvPartner: HConv;
    FhszSvcPartner: HSz;
    FhszServiceReq: HSz;
    FhszTopic: HSz;
    FhszItem: HSz;
    FwFmt: UINT;
    FwType: UINT;
    FwStatus: UINT;
    FwConvst: UINT;
    FwLastError: UINT;
    FhConvList: HConvList;
    Fhwnd: HWND;
    FhwndPartner: HWND;
  public
    constructor Create(ARecord: tagCONVINFO);
    function ObjToRec: tagCONVINFO;
  published
    property cb: DWORD read Fcb write Fcb;
    property hUser: DWORD read FhUser write FhUser;
    property hConvPartner: HConv read FhConvPartner write FhConvPartner;
    property hszSvcPartner: HSz read FhszSvcPartner write FhszSvcPartner;
    property hszServiceReq: HSz read FhszServiceReq write FhszServiceReq;
    property hszTopic: HSz read FhszTopic write FhszTopic;
    property hszItem: HSz read FhszItem write FhszItem;
    property wFmt: UINT read FwFmt write FwFmt;
    property wType: UINT read FwType write FwType;
    property wStatus: UINT read FwStatus write FwStatus;
    property wConvst: UINT read FwConvst write FwConvst;
    property wLastError: UINT read FwLastError write FwLastError;
    property hConvList: HConvList read FhConvList write FhConvList;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property hwndPartner: HWND read FhwndPartner write FhwndPartner;
  end;
  
  tagDDEML_MSG_HOOK_DATAWrapper = class(TatRecordWrapper)
  private
    FuiLo: UINT;
    FuiHi: UINT;
    FcbData: DWORD;
  public
    constructor Create(ARecord: tagDDEML_MSG_HOOK_DATA);
    function ObjToRec: tagDDEML_MSG_HOOK_DATA;
  published
    property uiLo: UINT read FuiLo write FuiLo;
    property uiHi: UINT read FuiHi write FuiHi;
    property cbData: DWORD read FcbData write FcbData;
  end;
  
  tagMONMSGSTRUCTWrapper = class(TatRecordWrapper)
  private
    Fcb: UINT;
    FhWndTo: HWND;
    FdwTime: DWORD;
    FhTask: THandle;
    FwMsg: UINT;
    FwParam: WPARAM;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagMONMSGSTRUCT);
    function ObjToRec: tagMONMSGSTRUCT;
  published
    property cb: UINT read Fcb write Fcb;
    property hWndTo: HWND read FhWndTo write FhWndTo;
    property dwTime: DWORD read FdwTime write FdwTime;
    property hTask: THandle read FhTask write FhTask;
    property wMsg: UINT read FwMsg write FwMsg;
    property wParam: WPARAM read FwParam write FwParam;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagMONCBSTRUCTWrapper = class(TatRecordWrapper)
  private
    Fcb: UINT;
    FdwTime: DWORD;
    FhTask: THandle;
    FdwRet: DWORD;
    FwType: UINT;
    FwFmt: UINT;
    FhConv: HConv;
    Fhsz1: HSZ;
    Fhsz2: HSZ;
    FhData: HDDEData;
    FdwData1: DWORD;
    FdwData2: DWORD;
    FcbData: DWORD;
  public
    constructor Create(ARecord: tagMONCBSTRUCT);
    function ObjToRec: tagMONCBSTRUCT;
  published
    property cb: UINT read Fcb write Fcb;
    property dwTime: DWORD read FdwTime write FdwTime;
    property hTask: THandle read FhTask write FhTask;
    property dwRet: DWORD read FdwRet write FdwRet;
    property wType: UINT read FwType write FwType;
    property wFmt: UINT read FwFmt write FwFmt;
    property hConv: HConv read FhConv write FhConv;
    property hsz1: HSZ read Fhsz1 write Fhsz1;
    property hsz2: HSZ read Fhsz2 write Fhsz2;
    property hData: HDDEData read FhData write FhData;
    property dwData1: DWORD read FdwData1 write FdwData1;
    property dwData2: DWORD read FdwData2 write FdwData2;
    property cbData: DWORD read FcbData write FcbData;
  end;
  
  tagMONHSZSTRUCTAWrapper = class(TatRecordWrapper)
  private
    Fcb: UINT;
    FfsAction: BOOL;
    FdwTime: DWORD;
    FHSZ: HSZ;
    FhTask: THandle;
    FwReserved: UINT;
  public
    constructor Create(ARecord: tagMONHSZSTRUCTA);
    function ObjToRec: tagMONHSZSTRUCTA;
  published
    property cb: UINT read Fcb write Fcb;
    property fsAction: BOOL read FfsAction write FfsAction;
    property dwTime: DWORD read FdwTime write FdwTime;
    property HSZ: HSZ read FHSZ write FHSZ;
    property hTask: THandle read FhTask write FhTask;
    property wReserved: UINT read FwReserved write FwReserved;
  end;
  
  tagMONHSZSTRUCTWWrapper = class(TatRecordWrapper)
  private
    Fcb: UINT;
    FfsAction: BOOL;
    FdwTime: DWORD;
    FHSZ: HSZ;
    FhTask: THandle;
    FwReserved: UINT;
  public
    constructor Create(ARecord: tagMONHSZSTRUCTW);
    function ObjToRec: tagMONHSZSTRUCTW;
  published
    property cb: UINT read Fcb write Fcb;
    property fsAction: BOOL read FfsAction write FfsAction;
    property dwTime: DWORD read FdwTime write FdwTime;
    property HSZ: HSZ read FHSZ write FHSZ;
    property hTask: THandle read FhTask write FhTask;
    property wReserved: UINT read FwReserved write FwReserved;
  end;
  
  tagMONERRSTRUCTWrapper = class(TatRecordWrapper)
  private
    Fcb: UINT;
    FwLastError: UINT;
    FdwTime: DWORD;
    FhTask: THandle;
  public
    constructor Create(ARecord: tagMONERRSTRUCT);
    function ObjToRec: tagMONERRSTRUCT;
  published
    property cb: UINT read Fcb write Fcb;
    property wLastError: UINT read FwLastError write FwLastError;
    property dwTime: DWORD read FdwTime write FdwTime;
    property hTask: THandle read FhTask write FhTask;
  end;
  
  tagMONLINKSTRUCTWrapper = class(TatRecordWrapper)
  private
    Fcb: UINT;
    FdwTime: DWORD;
    FhTask: THandle;
    FfEstablished: BOOL;
    FfNoData: BOOL;
    FhszSvc: HSz;
    FhszTopic: HSz;
    FhszItem: HSz;
    FwFmt: UINT;
    FfServer: BOOL;
    FhConvServer: HConv;
    FhConvClient: HConv;
  public
    constructor Create(ARecord: tagMONLINKSTRUCT);
    function ObjToRec: tagMONLINKSTRUCT;
  published
    property cb: UINT read Fcb write Fcb;
    property dwTime: DWORD read FdwTime write FdwTime;
    property hTask: THandle read FhTask write FhTask;
    property fEstablished: BOOL read FfEstablished write FfEstablished;
    property fNoData: BOOL read FfNoData write FfNoData;
    property hszSvc: HSz read FhszSvc write FhszSvc;
    property hszTopic: HSz read FhszTopic write FhszTopic;
    property hszItem: HSz read FhszItem write FhszItem;
    property wFmt: UINT read FwFmt write FwFmt;
    property fServer: BOOL read FfServer write FfServer;
    property hConvServer: HConv read FhConvServer write FhConvServer;
    property hConvClient: HConv read FhConvClient write FhConvClient;
  end;
  
  tagMONCONVSTRUCTWrapper = class(TatRecordWrapper)
  private
    Fcb: UINT;
    FfConnect: BOOL;
    FdwTime: DWORD;
    FhTask: THandle;
    FhszSvc: HSz;
    FhszTopic: HSz;
    FhConvClient: HConv;
    FhConvServer: HConv;
  public
    constructor Create(ARecord: tagMONCONVSTRUCT);
    function ObjToRec: tagMONCONVSTRUCT;
  published
    property cb: UINT read Fcb write Fcb;
    property fConnect: BOOL read FfConnect write FfConnect;
    property dwTime: DWORD read FdwTime write FdwTime;
    property hTask: THandle read FhTask write FhTask;
    property hszSvc: HSz read FhszSvc write FhszSvc;
    property hszTopic: HSz read FhszTopic write FhszTopic;
    property hConvClient: HConv read FhConvClient write FhConvClient;
    property hConvServer: HConv read FhConvServer write FhConvServer;
  end;
  

implementation

constructor tagHSZPAIRWrapper.Create(ARecord: tagHSZPAIR);
begin
  inherited Create;
  FhszSvc := ARecord.hszSvc;
  FhszTopic := ARecord.hszTopic;
end;

function tagHSZPAIRWrapper.ObjToRec: tagHSZPAIR;
begin
  result.hszSvc := FhszSvc;
  result.hszTopic := FhszTopic;
end;

constructor tagCONVCONTEXTWrapper.Create(ARecord: tagCONVCONTEXT);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FwFlags := ARecord.wFlags;
  FwCountryID := ARecord.wCountryID;
  FiCodePage := ARecord.iCodePage;
  FdwLangID := ARecord.dwLangID;
  FdwSecurity := ARecord.dwSecurity;
end;

function tagCONVCONTEXTWrapper.ObjToRec: tagCONVCONTEXT;
begin
  result.cb := Fcb;
  result.wFlags := FwFlags;
  result.wCountryID := FwCountryID;
  result.iCodePage := FiCodePage;
  result.dwLangID := FdwLangID;
  result.dwSecurity := FdwSecurity;
end;

constructor tagCONVINFOWrapper.Create(ARecord: tagCONVINFO);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FhUser := ARecord.hUser;
  FhConvPartner := ARecord.hConvPartner;
  FhszSvcPartner := ARecord.hszSvcPartner;
  FhszServiceReq := ARecord.hszServiceReq;
  FhszTopic := ARecord.hszTopic;
  FhszItem := ARecord.hszItem;
  FwFmt := ARecord.wFmt;
  FwType := ARecord.wType;
  FwStatus := ARecord.wStatus;
  FwConvst := ARecord.wConvst;
  FwLastError := ARecord.wLastError;
  FhConvList := ARecord.hConvList;
  Fhwnd := ARecord.hwnd;
  FhwndPartner := ARecord.hwndPartner;
end;

function tagCONVINFOWrapper.ObjToRec: tagCONVINFO;
begin
  result.cb := Fcb;
  result.hUser := FhUser;
  result.hConvPartner := FhConvPartner;
  result.hszSvcPartner := FhszSvcPartner;
  result.hszServiceReq := FhszServiceReq;
  result.hszTopic := FhszTopic;
  result.hszItem := FhszItem;
  result.wFmt := FwFmt;
  result.wType := FwType;
  result.wStatus := FwStatus;
  result.wConvst := FwConvst;
  result.wLastError := FwLastError;
  result.hConvList := FhConvList;
  result.hwnd := Fhwnd;
  result.hwndPartner := FhwndPartner;
end;

constructor tagDDEML_MSG_HOOK_DATAWrapper.Create(ARecord: tagDDEML_MSG_HOOK_DATA);
begin
  inherited Create;
  FuiLo := ARecord.uiLo;
  FuiHi := ARecord.uiHi;
  FcbData := ARecord.cbData;
end;

function tagDDEML_MSG_HOOK_DATAWrapper.ObjToRec: tagDDEML_MSG_HOOK_DATA;
begin
  result.uiLo := FuiLo;
  result.uiHi := FuiHi;
  result.cbData := FcbData;
end;

constructor tagMONMSGSTRUCTWrapper.Create(ARecord: tagMONMSGSTRUCT);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FhWndTo := ARecord.hWndTo;
  FdwTime := ARecord.dwTime;
  FhTask := ARecord.hTask;
  FwMsg := ARecord.wMsg;
  FwParam := ARecord.wParam;
  FlParam := ARecord.lParam;
end;

function tagMONMSGSTRUCTWrapper.ObjToRec: tagMONMSGSTRUCT;
begin
  result.cb := Fcb;
  result.hWndTo := FhWndTo;
  result.dwTime := FdwTime;
  result.hTask := FhTask;
  result.wMsg := FwMsg;
  result.wParam := FwParam;
  result.lParam := FlParam;
end;

constructor tagMONCBSTRUCTWrapper.Create(ARecord: tagMONCBSTRUCT);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FdwTime := ARecord.dwTime;
  FhTask := ARecord.hTask;
  FdwRet := ARecord.dwRet;
  FwType := ARecord.wType;
  FwFmt := ARecord.wFmt;
  FhConv := ARecord.hConv;
  Fhsz1 := ARecord.hsz1;
  Fhsz2 := ARecord.hsz2;
  FhData := ARecord.hData;
  FdwData1 := ARecord.dwData1;
  FdwData2 := ARecord.dwData2;
  FcbData := ARecord.cbData;
end;

function tagMONCBSTRUCTWrapper.ObjToRec: tagMONCBSTRUCT;
begin
  result.cb := Fcb;
  result.dwTime := FdwTime;
  result.hTask := FhTask;
  result.dwRet := FdwRet;
  result.wType := FwType;
  result.wFmt := FwFmt;
  result.hConv := FhConv;
  result.hsz1 := Fhsz1;
  result.hsz2 := Fhsz2;
  result.hData := FhData;
  result.dwData1 := FdwData1;
  result.dwData2 := FdwData2;
  result.cbData := FcbData;
end;

constructor tagMONHSZSTRUCTAWrapper.Create(ARecord: tagMONHSZSTRUCTA);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FfsAction := ARecord.fsAction;
  FdwTime := ARecord.dwTime;
  FHSZ := ARecord.HSZ;
  FhTask := ARecord.hTask;
  FwReserved := ARecord.wReserved;
end;

function tagMONHSZSTRUCTAWrapper.ObjToRec: tagMONHSZSTRUCTA;
begin
  result.cb := Fcb;
  result.fsAction := FfsAction;
  result.dwTime := FdwTime;
  result.HSZ := FHSZ;
  result.hTask := FhTask;
  result.wReserved := FwReserved;
end;

constructor tagMONHSZSTRUCTWWrapper.Create(ARecord: tagMONHSZSTRUCTW);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FfsAction := ARecord.fsAction;
  FdwTime := ARecord.dwTime;
  FHSZ := ARecord.HSZ;
  FhTask := ARecord.hTask;
  FwReserved := ARecord.wReserved;
end;

function tagMONHSZSTRUCTWWrapper.ObjToRec: tagMONHSZSTRUCTW;
begin
  result.cb := Fcb;
  result.fsAction := FfsAction;
  result.dwTime := FdwTime;
  result.HSZ := FHSZ;
  result.hTask := FhTask;
  result.wReserved := FwReserved;
end;

constructor tagMONERRSTRUCTWrapper.Create(ARecord: tagMONERRSTRUCT);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FwLastError := ARecord.wLastError;
  FdwTime := ARecord.dwTime;
  FhTask := ARecord.hTask;
end;

function tagMONERRSTRUCTWrapper.ObjToRec: tagMONERRSTRUCT;
begin
  result.cb := Fcb;
  result.wLastError := FwLastError;
  result.dwTime := FdwTime;
  result.hTask := FhTask;
end;

constructor tagMONLINKSTRUCTWrapper.Create(ARecord: tagMONLINKSTRUCT);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FdwTime := ARecord.dwTime;
  FhTask := ARecord.hTask;
  FfEstablished := ARecord.fEstablished;
  FfNoData := ARecord.fNoData;
  FhszSvc := ARecord.hszSvc;
  FhszTopic := ARecord.hszTopic;
  FhszItem := ARecord.hszItem;
  FwFmt := ARecord.wFmt;
  FfServer := ARecord.fServer;
  FhConvServer := ARecord.hConvServer;
  FhConvClient := ARecord.hConvClient;
end;

function tagMONLINKSTRUCTWrapper.ObjToRec: tagMONLINKSTRUCT;
begin
  result.cb := Fcb;
  result.dwTime := FdwTime;
  result.hTask := FhTask;
  result.fEstablished := FfEstablished;
  result.fNoData := FfNoData;
  result.hszSvc := FhszSvc;
  result.hszTopic := FhszTopic;
  result.hszItem := FhszItem;
  result.wFmt := FwFmt;
  result.fServer := FfServer;
  result.hConvServer := FhConvServer;
  result.hConvClient := FhConvClient;
end;

constructor tagMONCONVSTRUCTWrapper.Create(ARecord: tagMONCONVSTRUCT);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FfConnect := ARecord.fConnect;
  FdwTime := ARecord.dwTime;
  FhTask := ARecord.hTask;
  FhszSvc := ARecord.hszSvc;
  FhszTopic := ARecord.hszTopic;
  FhConvClient := ARecord.hConvClient;
  FhConvServer := ARecord.hConvServer;
end;

function tagMONCONVSTRUCTWrapper.ObjToRec: tagMONCONVSTRUCT;
begin
  result.cb := Fcb;
  result.fConnect := FfConnect;
  result.dwTime := FdwTime;
  result.hTask := FhTask;
  result.hszSvc := FhszSvc;
  result.hszTopic := FhszTopic;
  result.hConvClient := FhConvClient;
  result.hConvServer := FhConvServer;
end;



procedure TatDDEmlLibrary.__DdeUninitialize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DDEml.DdeUninitialize(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeQueryNextServer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DDEml.DdeQueryNextServer(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeDisconnectList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DDEml.DdeDisconnectList(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeDisconnect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DDEml.DdeDisconnect(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeReconnect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DDEml.DdeReconnect(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeSetUserHandle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DDEml.DdeSetUserHandle(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeAbandonTransaction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DDEml.DdeAbandonTransaction(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdePostAdvise(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DDEml.DdePostAdvise(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeEnableCallback(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DDEml.DdeEnableCallback(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeNameService(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DDEml.DdeNameService(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeUnaccessData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DDEml.DdeUnaccessData(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeFreeDataHandle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DDEml.DdeFreeDataHandle(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeGetLastError(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DDEml.DdeGetLastError(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeCreateStringHandleA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DDEml.DdeCreateStringHandleA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeCreateStringHandleW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DDEml.DdeCreateStringHandleW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeCreateStringHandle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DDEml.DdeCreateStringHandle(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeQueryStringA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DDEml.DdeQueryStringA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeQueryStringW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DDEml.DdeQueryStringW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeQueryString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DDEml.DdeQueryString(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeFreeStringHandle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DDEml.DdeFreeStringHandle(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeKeepStringHandle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DDEml.DdeKeepStringHandle(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.__DdeCmpStringHandles(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DDEml.DdeCmpStringHandles(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDDEmlLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('DdeUninitialize',1,tkVariant,nil,__DdeUninitialize,false,0);
    DefineMethod('DdeQueryNextServer',2,tkInteger,nil,__DdeQueryNextServer,false,0);
    DefineMethod('DdeDisconnectList',1,tkVariant,nil,__DdeDisconnectList,false,0);
    DefineMethod('DdeDisconnect',1,tkVariant,nil,__DdeDisconnect,false,0);
    DefineMethod('DdeReconnect',1,tkInteger,nil,__DdeReconnect,false,0);
    DefineMethod('DdeSetUserHandle',3,tkVariant,nil,__DdeSetUserHandle,false,0);
    DefineMethod('DdeAbandonTransaction',3,tkVariant,nil,__DdeAbandonTransaction,false,0);
    DefineMethod('DdePostAdvise',3,tkVariant,nil,__DdePostAdvise,false,0);
    DefineMethod('DdeEnableCallback',3,tkVariant,nil,__DdeEnableCallback,false,0);
    DefineMethod('DdeNameService',4,tkInteger,nil,__DdeNameService,false,0);
    DefineMethod('DdeUnaccessData',1,tkVariant,nil,__DdeUnaccessData,false,0);
    DefineMethod('DdeFreeDataHandle',1,tkVariant,nil,__DdeFreeDataHandle,false,0);
    DefineMethod('DdeGetLastError',1,tkInteger,nil,__DdeGetLastError,false,0);
    DefineMethod('DdeCreateStringHandleA',3,tkInteger,nil,__DdeCreateStringHandleA,false,0);
    DefineMethod('DdeCreateStringHandleW',3,tkInteger,nil,__DdeCreateStringHandleW,false,0);
    DefineMethod('DdeCreateStringHandle',3,tkInteger,nil,__DdeCreateStringHandle,false,0);
    DefineMethod('DdeQueryStringA',5,tkInteger,nil,__DdeQueryStringA,false,0);
    DefineMethod('DdeQueryStringW',5,tkInteger,nil,__DdeQueryStringW,false,0);
    DefineMethod('DdeQueryString',5,tkInteger,nil,__DdeQueryString,false,0);
    DefineMethod('DdeFreeStringHandle',2,tkVariant,nil,__DdeFreeStringHandle,false,0);
    DefineMethod('DdeKeepStringHandle',2,tkVariant,nil,__DdeKeepStringHandle,false,0);
    DefineMethod('DdeCmpStringHandles',2,tkInteger,nil,__DdeCmpStringHandles,false,0);
    AddConstant('XST_NULL',XST_NULL);
    AddConstant('XST_INCOMPLETE',XST_INCOMPLETE);
    AddConstant('XST_CONNECTED',XST_CONNECTED);
    AddConstant('XST_INIT1',XST_INIT1);
    AddConstant('XST_INIT2',XST_INIT2);
    AddConstant('XST_REQSENT',XST_REQSENT);
    AddConstant('XST_DATARCVD',XST_DATARCVD);
    AddConstant('XST_POKESENT',XST_POKESENT);
    AddConstant('XST_POKEACKRCVD',XST_POKEACKRCVD);
    AddConstant('XST_EXECSENT',XST_EXECSENT);
    AddConstant('XST_EXECACKRCVD',XST_EXECACKRCVD);
    AddConstant('XST_ADVSENT',XST_ADVSENT);
    AddConstant('XST_UNADVSENT',XST_UNADVSENT);
    AddConstant('XST_ADVACKRCVD',XST_ADVACKRCVD);
    AddConstant('XST_UNADVACKRCVD',XST_UNADVACKRCVD);
    AddConstant('XST_ADVDATASENT',XST_ADVDATASENT);
    AddConstant('XST_ADVDATAACKRCVD',XST_ADVDATAACKRCVD);
    AddConstant('CADV_LATEACK',CADV_LATEACK);
    AddConstant('ST_CONNECTED',ST_CONNECTED);
    AddConstant('ST_ADVISE',ST_ADVISE);
    AddConstant('ST_ISLOCAL',ST_ISLOCAL);
    AddConstant('ST_BLOCKED',ST_BLOCKED);
    AddConstant('ST_CLIENT',ST_CLIENT);
    AddConstant('ST_TERMINATED',ST_TERMINATED);
    AddConstant('ST_INLIST',ST_INLIST);
    AddConstant('ST_BLOCKNEXT',ST_BLOCKNEXT);
    AddConstant('ST_ISSELF',ST_ISSELF);
    AddConstant('DDE_FACK',DDE_FACK);
    AddConstant('DDE_FBUSY',DDE_FBUSY);
    AddConstant('DDE_FDEFERUPD',DDE_FDEFERUPD);
    AddConstant('DDE_FACKREQ',DDE_FACKREQ);
    AddConstant('DDE_FRELEASE',DDE_FRELEASE);
    AddConstant('DDE_FREQUESTED',DDE_FREQUESTED);
    AddConstant('DDE_FAPPSTATUS',DDE_FAPPSTATUS);
    AddConstant('DDE_FNOTPROCESSED',DDE_FNOTPROCESSED);
    AddConstant('DDE_FACKRESERVED',DDE_FACKRESERVED);
    AddConstant('DDE_FADVRESERVED',DDE_FADVRESERVED);
    AddConstant('DDE_FDATRESERVED',DDE_FDATRESERVED);
    AddConstant('DDE_FPOKRESERVED',DDE_FPOKRESERVED);
    AddConstant('MSGF_DDEMGR',MSGF_DDEMGR);
    AddConstant('CP_WINANSI',CP_WINANSI);
    AddConstant('CP_WINUNICODE',CP_WINUNICODE);
    AddConstant('CP_WINNEUTRAL',CP_WINNEUTRAL);
    AddConstant('XTYPF_NOBLOCK',XTYPF_NOBLOCK);
    AddConstant('XTYPF_NODATA',XTYPF_NODATA);
    AddConstant('XTYPF_ACKREQ',XTYPF_ACKREQ);
    AddConstant('XCLASS_MASK',XCLASS_MASK);
    AddConstant('XCLASS_BOOL',XCLASS_BOOL);
    AddConstant('XCLASS_DATA',XCLASS_DATA);
    AddConstant('XCLASS_FLAGS',XCLASS_FLAGS);
    AddConstant('XCLASS_NOTIFICATION',XCLASS_NOTIFICATION);
    AddConstant('XTYP_ERROR',XTYP_ERROR);
    AddConstant('XTYP_ADVDATA',XTYP_ADVDATA);
    AddConstant('XTYP_ADVREQ',XTYP_ADVREQ);
    AddConstant('XTYP_ADVSTART',XTYP_ADVSTART);
    AddConstant('XTYP_ADVSTOP',XTYP_ADVSTOP);
    AddConstant('XTYP_EXECUTE',XTYP_EXECUTE);
    AddConstant('XTYP_CONNECT',XTYP_CONNECT);
    AddConstant('XTYP_CONNECT_CONFIRM',XTYP_CONNECT_CONFIRM);
    AddConstant('XTYP_XACT_COMPLETE',XTYP_XACT_COMPLETE);
    AddConstant('XTYP_POKE',XTYP_POKE);
    AddConstant('XTYP_REGISTER',XTYP_REGISTER);
    AddConstant('XTYP_REQUEST',XTYP_REQUEST);
    AddConstant('XTYP_DISCONNECT',XTYP_DISCONNECT);
    AddConstant('XTYP_UNREGISTER',XTYP_UNREGISTER);
    AddConstant('XTYP_WILDCONNECT',XTYP_WILDCONNECT);
    AddConstant('XTYP_MASK',XTYP_MASK);
    AddConstant('XTYP_SHIFT',XTYP_SHIFT);
    AddConstant('TIMEOUT_ASYNC',TIMEOUT_ASYNC);
    AddConstant('QID_SYNC',QID_SYNC);
    AddConstant('SZDDESYS_TOPIC',SZDDESYS_TOPIC);
    AddConstant('SZDDESYS_ITEM_TOPICS',SZDDESYS_ITEM_TOPICS);
    AddConstant('SZDDESYS_ITEM_SYSITEMS',SZDDESYS_ITEM_SYSITEMS);
    AddConstant('SZDDESYS_ITEM_RTNMSG',SZDDESYS_ITEM_RTNMSG);
    AddConstant('SZDDESYS_ITEM_STATUS',SZDDESYS_ITEM_STATUS);
    AddConstant('SZDDESYS_ITEM_FORMATS',SZDDESYS_ITEM_FORMATS);
    AddConstant('SZDDESYS_ITEM_HELP',SZDDESYS_ITEM_HELP);
    AddConstant('SZDDE_ITEM_ITEMLIST',SZDDE_ITEM_ITEMLIST);
    AddConstant('CBR_BLOCK',CBR_BLOCK);
    AddConstant('CBF_FAIL_SELFCONNECTIONS',CBF_FAIL_SELFCONNECTIONS);
    AddConstant('CBF_FAIL_CONNECTIONS',CBF_FAIL_CONNECTIONS);
    AddConstant('CBF_FAIL_ADVISES',CBF_FAIL_ADVISES);
    AddConstant('CBF_FAIL_EXECUTES',CBF_FAIL_EXECUTES);
    AddConstant('CBF_FAIL_POKES',CBF_FAIL_POKES);
    AddConstant('CBF_FAIL_REQUESTS',CBF_FAIL_REQUESTS);
    AddConstant('CBF_FAIL_ALLSVRXACTIONS',CBF_FAIL_ALLSVRXACTIONS);
    AddConstant('CBF_SKIP_CONNECT_CONFIRMS',CBF_SKIP_CONNECT_CONFIRMS);
    AddConstant('CBF_SKIP_REGISTRATIONS',CBF_SKIP_REGISTRATIONS);
    AddConstant('CBF_SKIP_UNREGISTRATIONS',CBF_SKIP_UNREGISTRATIONS);
    AddConstant('CBF_SKIP_DISCONNECTS',CBF_SKIP_DISCONNECTS);
    AddConstant('CBF_SKIP_ALLNOTIFICATIONS',CBF_SKIP_ALLNOTIFICATIONS);
    AddConstant('APPCMD_CLIENTONLY',APPCMD_CLIENTONLY);
    AddConstant('APPCMD_FILTERINITS',APPCMD_FILTERINITS);
    AddConstant('APPCMD_MASK',APPCMD_MASK);
    AddConstant('APPCLASS_STANDARD',APPCLASS_STANDARD);
    AddConstant('APPCLASS_MASK',APPCLASS_MASK);
    AddConstant('EC_ENABLEALL',EC_ENABLEALL);
    AddConstant('EC_ENABLEONE',EC_ENABLEONE);
    AddConstant('EC_DISABLE',EC_DISABLE);
    AddConstant('EC_QUERYWAITING',EC_QUERYWAITING);
    AddConstant('DNS_REGISTER',DNS_REGISTER);
    AddConstant('DNS_UNREGISTER',DNS_UNREGISTER);
    AddConstant('DNS_FILTERON',DNS_FILTERON);
    AddConstant('DNS_FILTEROFF',DNS_FILTEROFF);
    AddConstant('HDATA_APPOWNED',HDATA_APPOWNED);
    AddConstant('DMLERR_NO_ERROR',DMLERR_NO_ERROR);
    AddConstant('DMLERR_FIRST',DMLERR_FIRST);
    AddConstant('DMLERR_ADVACKTIMEOUT',DMLERR_ADVACKTIMEOUT);
    AddConstant('DMLERR_BUSY',DMLERR_BUSY);
    AddConstant('DMLERR_DATAACKTIMEOUT',DMLERR_DATAACKTIMEOUT);
    AddConstant('DMLERR_DLL_NOT_INITIALIZED',DMLERR_DLL_NOT_INITIALIZED);
    AddConstant('DMLERR_DLL_USAGE',DMLERR_DLL_USAGE);
    AddConstant('DMLERR_EXECACKTIMEOUT',DMLERR_EXECACKTIMEOUT);
    AddConstant('DMLERR_INVALIDPARAMETER',DMLERR_INVALIDPARAMETER);
    AddConstant('DMLERR_LOW_MEMORY',DMLERR_LOW_MEMORY);
    AddConstant('DMLERR_MEMORY_ERROR',DMLERR_MEMORY_ERROR);
    AddConstant('DMLERR_NOTPROCESSED',DMLERR_NOTPROCESSED);
    AddConstant('DMLERR_NO_CONV_ESTABLISHED',DMLERR_NO_CONV_ESTABLISHED);
    AddConstant('DMLERR_POKEACKTIMEOUT',DMLERR_POKEACKTIMEOUT);
    AddConstant('DMLERR_POSTMSG_FAILED',DMLERR_POSTMSG_FAILED);
    AddConstant('DMLERR_REENTRANCY',DMLERR_REENTRANCY);
    AddConstant('DMLERR_SERVER_DIED',DMLERR_SERVER_DIED);
    AddConstant('DMLERR_SYS_ERROR',DMLERR_SYS_ERROR);
    AddConstant('DMLERR_UNADVACKTIMEOUT',DMLERR_UNADVACKTIMEOUT);
    AddConstant('DMLERR_UNFOUND_QUEUE_ID',DMLERR_UNFOUND_QUEUE_ID);
    AddConstant('DMLERR_LAST',DMLERR_LAST);
    AddConstant('MH_CREATE',MH_CREATE);
    AddConstant('MH_KEEP',MH_KEEP);
    AddConstant('MH_DELETE',MH_DELETE);
    AddConstant('MH_CLEANUP',MH_CLEANUP);
    AddConstant('MAX_MONITORS',MAX_MONITORS);
    AddConstant('APPCLASS_MONITOR',APPCLASS_MONITOR);
    AddConstant('XTYP_MONITOR',XTYP_MONITOR);
    AddConstant('MF_HSZ_INFO',MF_HSZ_INFO);
    AddConstant('MF_SENDMSGS',MF_SENDMSGS);
    AddConstant('MF_POSTMSGS',MF_POSTMSGS);
    AddConstant('MF_CALLBACKS',MF_CALLBACKS);
    AddConstant('MF_ERRORS',MF_ERRORS);
    AddConstant('MF_LINKS',MF_LINKS);
    AddConstant('MF_CONV',MF_CONV);
    AddConstant('ddelib',ddelib);
  end;
end;

class function TatDDEmlLibrary.LibraryName: string;
begin
  result := 'DDEml';
end;

initialization
  RegisterScripterLibrary(TatDDEmlLibrary, True);

{$WARNINGS ON}

end.

