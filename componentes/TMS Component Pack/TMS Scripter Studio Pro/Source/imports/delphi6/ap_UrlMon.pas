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
unit ap_UrlMon;

interface

uses
  Windows,
  ActiveX,
  UrlMon,
  Variants,
  ap_System,
  ap_ActiveX,
  atScript;

{$WARNINGS OFF}

type
  TatUrlMonLibrary = class(TatScripterLibrary)
    procedure __GetClassURL(AMachine: TatVirtualMachine);
    procedure __RegisterMediaTypes(AMachine: TatVirtualMachine);
    procedure __ObtainUserAgentString(AMachine: TatVirtualMachine);
    procedure __CoInternetParseUrl(AMachine: TatVirtualMachine);
    procedure __CoInternetCombineUrl(AMachine: TatVirtualMachine);
    procedure __CoInternetCompareUrl(AMachine: TatVirtualMachine);
    procedure __CoInternetGetProtocolFlags(AMachine: TatVirtualMachine);
    procedure __CoInternetGetSecurityUrl(AMachine: TatVirtualMachine);
    procedure __OInetParseUrl(AMachine: TatVirtualMachine);
    procedure __OInetCombineUrl(AMachine: TatVirtualMachine);
    procedure __OInetCompareUrl(AMachine: TatVirtualMachine);
    procedure __CopyStgMedium(AMachine: TatVirtualMachine);
    procedure __CopyBindInfo(AMachine: TatVirtualMachine);
    procedure __ReleaseBindInfo(AMachine: TatVirtualMachine);
    procedure __GetUrlPolicyPermissions(AMachine: TatVirtualMachine);
    procedure __SetUrlPolicyPermissions(AMachine: TatVirtualMachine);
    procedure __GetSoftwareUpdateInfo(AMachine: TatVirtualMachine);
    procedure __SetSoftwareUpdateAdvertisementState(AMachine: TatVirtualMachine);
    procedure __IsLoggingEnabled(AMachine: TatVirtualMachine);
    procedure __IsLoggingEnabledA(AMachine: TatVirtualMachine);
    procedure __IsLoggingEnabledW(AMachine: TatVirtualMachine);
    procedure __WriteHitLogging(AMachine: TatVirtualMachine);
    procedure __GetSZ_URLCONTEXT(AMachine: TatVirtualMachine);
    procedure __GetSZ_ASYNC_CALLEE(AMachine: TatVirtualMachine);
    procedure __GetIID_IPersistMoniker(AMachine: TatVirtualMachine);
    procedure __GetIID_IBinding(AMachine: TatVirtualMachine);
    procedure __GetIID_IBindStatusCallback(AMachine: TatVirtualMachine);
    procedure __GetIID_IAuthenticate(AMachine: TatVirtualMachine);
    procedure __GetIID_IHttpNegotiate(AMachine: TatVirtualMachine);
    procedure __GetIID_IWindowForBindingUI(AMachine: TatVirtualMachine);
    procedure __GetIID_ICodeInstall(AMachine: TatVirtualMachine);
    procedure __GetIID_IWinInetInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IHttpSecurity(AMachine: TatVirtualMachine);
    procedure __GetIID_IWinInetHttpInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IBindHost(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternet(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternetBindInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternetProtocolRoot(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternetProtocol(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternetProtocolSink(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternetSession(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternetThreadSwitch(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternetPriority(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternetProtocolInfo(AMachine: TatVirtualMachine);
    procedure __GetSID_IBindHost(AMachine: TatVirtualMachine);
    procedure __GetSID_SBindHost(AMachine: TatVirtualMachine);
    procedure __GetIID_IOInet(AMachine: TatVirtualMachine);
    procedure __GetIID_IOInetBindInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IOInetProtocolRoot(AMachine: TatVirtualMachine);
    procedure __GetIID_IOInetProtocol(AMachine: TatVirtualMachine);
    procedure __GetIID_IOInetProtocolSink(AMachine: TatVirtualMachine);
    procedure __GetIID_IOInetProtocolInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IOInetSession(AMachine: TatVirtualMachine);
    procedure __GetIID_IOInetPriority(AMachine: TatVirtualMachine);
    procedure __GetIID_IOInetThreadSwitch(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternetSecurityMgrSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternetSecurityManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternetHostSecurityManager(AMachine: TatVirtualMachine);
    procedure __GetSID_IInternetSecurityManager(AMachine: TatVirtualMachine);
    procedure __GetSID_IInternetHostSecurityManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternetZoneManager(AMachine: TatVirtualMachine);
    procedure __GetIID_ISoftDistExt(AMachine: TatVirtualMachine);
    procedure __GetIID_IDataFilter(AMachine: TatVirtualMachine);
    procedure __GetIID_IEncodingFilterFactory(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _tagBINDINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: ULONG;
    FgrfBindInfoF: DWORD;
    FdwBindVerb: DWORD;
    FcbstgmedData: DWORD;
    FdwOptions: DWORD;
    FdwOptionsFlags: DWORD;
    FdwCodePage: DWORD;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: _tagBINDINFO);
    function ObjToRec: _tagBINDINFO;
  published
    property cbSize: ULONG read FcbSize write FcbSize;
    property grfBindInfoF: DWORD read FgrfBindInfoF write FgrfBindInfoF;
    property dwBindVerb: DWORD read FdwBindVerb write FdwBindVerb;
    property cbstgmedData: DWORD read FcbstgmedData write FcbstgmedData;
    property dwOptions: DWORD read FdwOptions write FdwOptions;
    property dwOptionsFlags: DWORD read FdwOptionsFlags write FdwOptionsFlags;
    property dwCodePage: DWORD read FdwCodePage write FdwCodePage;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  _REMSECURITY_ATTRIBUTESWrapper = class(TatRecordWrapper)
  private
    FnLength: DWORD;
    FlpSecurityDescriptor: DWORD;
    FbInheritHandle: BOOL;
  public
    constructor Create(ARecord: _REMSECURITY_ATTRIBUTES);
    function ObjToRec: _REMSECURITY_ATTRIBUTES;
  published
    property nLength: DWORD read FnLength write FnLength;
    property lpSecurityDescriptor: DWORD read FlpSecurityDescriptor write FlpSecurityDescriptor;
    property bInheritHandle: BOOL read FbInheritHandle write FbInheritHandle;
  end;
  
  _tagRemBINDINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: ULONG;
    FgrfBindInfoF: DWORD;
    FdwBindVerb: DWORD;
    FcbstgmedData: DWORD;
    FdwOptions: DWORD;
    FdwOptionsFlags: DWORD;
    FdwCodePage: DWORD;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: _tagRemBINDINFO);
    function ObjToRec: _tagRemBINDINFO;
  published
    property cbSize: ULONG read FcbSize write FcbSize;
    property grfBindInfoF: DWORD read FgrfBindInfoF write FgrfBindInfoF;
    property dwBindVerb: DWORD read FdwBindVerb write FdwBindVerb;
    property cbstgmedData: DWORD read FcbstgmedData write FcbstgmedData;
    property dwOptions: DWORD read FdwOptions write FdwOptions;
    property dwOptionsFlags: DWORD read FdwOptionsFlags write FdwOptionsFlags;
    property dwCodePage: DWORD read FdwCodePage write FdwCodePage;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  tagRemFORMATETCWrapper = class(TatRecordWrapper)
  private
    FcfFormat: DWORD;
    Fptd: DWORD;
    FdwAspect: DWORD;
    Flindex: Longint;
    Ftymed: DWORD;
  public
    constructor Create(ARecord: tagRemFORMATETC);
    function ObjToRec: tagRemFORMATETC;
  published
    property cfFormat: DWORD read FcfFormat write FcfFormat;
    property ptd: DWORD read Fptd write Fptd;
    property dwAspect: DWORD read FdwAspect write FdwAspect;
    property lindex: Longint read Flindex write Flindex;
    property tymed: DWORD read Ftymed write Ftymed;
  end;
  
  _tagPROTOCOLDATAWrapper = class(TatRecordWrapper)
  private
    FgrfFlags: DWORD;
    FdwState: DWORD;
    FcbData: ULONG;
  public
    constructor Create(ARecord: _tagPROTOCOLDATA);
    function ObjToRec: _tagPROTOCOLDATA;
  published
    property grfFlags: DWORD read FgrfFlags write FgrfFlags;
    property dwState: DWORD read FdwState write FdwState;
    property cbData: ULONG read FcbData write FcbData;
  end;
  
  _ZONEATTRIBUTESWrapper = class(TatRecordWrapper)
  private
    FcbSize: ULONG;
    FdwTemplateMinLevel: DWORD;
    FdwTemplateRecommended: DWORD;
    FdwTemplateCurrentLevel: DWORD;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: _ZONEATTRIBUTES);
    function ObjToRec: _ZONEATTRIBUTES;
  published
    property cbSize: ULONG read FcbSize write FcbSize;
    property dwTemplateMinLevel: DWORD read FdwTemplateMinLevel write FdwTemplateMinLevel;
    property dwTemplateRecommended: DWORD read FdwTemplateRecommended write FdwTemplateRecommended;
    property dwTemplateCurrentLevel: DWORD read FdwTemplateCurrentLevel write FdwTemplateCurrentLevel;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  _tagCODEBASEHOLDWrapper = class(TatRecordWrapper)
  private
    FcbSize: ULONG;
    FdwVersionMS: DWORD;
    FdwVersionLS: DWORD;
    FdwStyle: DWORD;
  public
    constructor Create(ARecord: _tagCODEBASEHOLD);
    function ObjToRec: _tagCODEBASEHOLD;
  published
    property cbSize: ULONG read FcbSize write FcbSize;
    property dwVersionMS: DWORD read FdwVersionMS write FdwVersionMS;
    property dwVersionLS: DWORD read FdwVersionLS write FdwVersionLS;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
  end;
  
  _tagSOFTDISTINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: ULONG;
    FdwFlags: DWORD;
    FdwAdState: DWORD;
    FdwInstalledVersionMS: DWORD;
    FdwInstalledVersionLS: DWORD;
    FdwUpdateVersionMS: DWORD;
    FdwUpdateVersionLS: DWORD;
    FdwAdvertisedVersionMS: DWORD;
    FdwAdvertisedVersionLS: DWORD;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: _tagSOFTDISTINFO);
    function ObjToRec: _tagSOFTDISTINFO;
  published
    property cbSize: ULONG read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwAdState: DWORD read FdwAdState write FdwAdState;
    property dwInstalledVersionMS: DWORD read FdwInstalledVersionMS write FdwInstalledVersionMS;
    property dwInstalledVersionLS: DWORD read FdwInstalledVersionLS write FdwInstalledVersionLS;
    property dwUpdateVersionMS: DWORD read FdwUpdateVersionMS write FdwUpdateVersionMS;
    property dwUpdateVersionLS: DWORD read FdwUpdateVersionLS write FdwUpdateVersionLS;
    property dwAdvertisedVersionMS: DWORD read FdwAdvertisedVersionMS write FdwAdvertisedVersionMS;
    property dwAdvertisedVersionLS: DWORD read FdwAdvertisedVersionLS write FdwAdvertisedVersionLS;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  _tagPROTOCOLFILTERDATAWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwFilterFlags: DWORD;
  public
    constructor Create(ARecord: _tagPROTOCOLFILTERDATA);
    function ObjToRec: _tagPROTOCOLFILTERDATA;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwFilterFlags: DWORD read FdwFilterFlags write FdwFilterFlags;
  end;
  
  _tagDATAINFOWrapper = class(TatRecordWrapper)
  private
    FulTotalSize: ULONG;
    FulavrPacketSize: ULONG;
    FulConnectSpeed: ULONG;
    FulProcessorSpeed: ULONG;
  public
    constructor Create(ARecord: _tagDATAINFO);
    function ObjToRec: _tagDATAINFO;
  published
    property ulTotalSize: ULONG read FulTotalSize write FulTotalSize;
    property ulavrPacketSize: ULONG read FulavrPacketSize write FulavrPacketSize;
    property ulConnectSpeed: ULONG read FulConnectSpeed write FulConnectSpeed;
    property ulProcessorSpeed: ULONG read FulProcessorSpeed write FulProcessorSpeed;
  end;
  
  _tagHIT_LOGGING_INFOWrapper = class(TatRecordWrapper)
  private
    FdwStructSize: DWORD;
  public
    constructor Create(ARecord: _tagHIT_LOGGING_INFO);
    function ObjToRec: _tagHIT_LOGGING_INFO;
  published
    property dwStructSize: DWORD read FdwStructSize write FdwStructSize;
  end;
  

implementation

constructor _tagBINDINFOWrapper.Create(ARecord: _tagBINDINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FgrfBindInfoF := ARecord.grfBindInfoF;
  FdwBindVerb := ARecord.dwBindVerb;
  FcbstgmedData := ARecord.cbstgmedData;
  FdwOptions := ARecord.dwOptions;
  FdwOptionsFlags := ARecord.dwOptionsFlags;
  FdwCodePage := ARecord.dwCodePage;
  FdwReserved := ARecord.dwReserved;
end;

function _tagBINDINFOWrapper.ObjToRec: _tagBINDINFO;
begin
  result.cbSize := FcbSize;
  result.grfBindInfoF := FgrfBindInfoF;
  result.dwBindVerb := FdwBindVerb;
  result.cbstgmedData := FcbstgmedData;
  result.dwOptions := FdwOptions;
  result.dwOptionsFlags := FdwOptionsFlags;
  result.dwCodePage := FdwCodePage;
  result.dwReserved := FdwReserved;
end;

constructor _REMSECURITY_ATTRIBUTESWrapper.Create(ARecord: _REMSECURITY_ATTRIBUTES);
begin
  inherited Create;
  FnLength := ARecord.nLength;
  FlpSecurityDescriptor := ARecord.lpSecurityDescriptor;
  FbInheritHandle := ARecord.bInheritHandle;
end;

function _REMSECURITY_ATTRIBUTESWrapper.ObjToRec: _REMSECURITY_ATTRIBUTES;
begin
  result.nLength := FnLength;
  result.lpSecurityDescriptor := FlpSecurityDescriptor;
  result.bInheritHandle := FbInheritHandle;
end;

constructor _tagRemBINDINFOWrapper.Create(ARecord: _tagRemBINDINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FgrfBindInfoF := ARecord.grfBindInfoF;
  FdwBindVerb := ARecord.dwBindVerb;
  FcbstgmedData := ARecord.cbstgmedData;
  FdwOptions := ARecord.dwOptions;
  FdwOptionsFlags := ARecord.dwOptionsFlags;
  FdwCodePage := ARecord.dwCodePage;
  FdwReserved := ARecord.dwReserved;
end;

function _tagRemBINDINFOWrapper.ObjToRec: _tagRemBINDINFO;
begin
  result.cbSize := FcbSize;
  result.grfBindInfoF := FgrfBindInfoF;
  result.dwBindVerb := FdwBindVerb;
  result.cbstgmedData := FcbstgmedData;
  result.dwOptions := FdwOptions;
  result.dwOptionsFlags := FdwOptionsFlags;
  result.dwCodePage := FdwCodePage;
  result.dwReserved := FdwReserved;
end;

constructor tagRemFORMATETCWrapper.Create(ARecord: tagRemFORMATETC);
begin
  inherited Create;
  FcfFormat := ARecord.cfFormat;
  Fptd := ARecord.ptd;
  FdwAspect := ARecord.dwAspect;
  Flindex := ARecord.lindex;
  Ftymed := ARecord.tymed;
end;

function tagRemFORMATETCWrapper.ObjToRec: tagRemFORMATETC;
begin
  result.cfFormat := FcfFormat;
  result.ptd := Fptd;
  result.dwAspect := FdwAspect;
  result.lindex := Flindex;
  result.tymed := Ftymed;
end;

constructor _tagPROTOCOLDATAWrapper.Create(ARecord: _tagPROTOCOLDATA);
begin
  inherited Create;
  FgrfFlags := ARecord.grfFlags;
  FdwState := ARecord.dwState;
  FcbData := ARecord.cbData;
end;

function _tagPROTOCOLDATAWrapper.ObjToRec: _tagPROTOCOLDATA;
begin
  result.grfFlags := FgrfFlags;
  result.dwState := FdwState;
  result.cbData := FcbData;
end;

constructor _ZONEATTRIBUTESWrapper.Create(ARecord: _ZONEATTRIBUTES);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwTemplateMinLevel := ARecord.dwTemplateMinLevel;
  FdwTemplateRecommended := ARecord.dwTemplateRecommended;
  FdwTemplateCurrentLevel := ARecord.dwTemplateCurrentLevel;
  FdwFlags := ARecord.dwFlags;
end;

function _ZONEATTRIBUTESWrapper.ObjToRec: _ZONEATTRIBUTES;
begin
  result.cbSize := FcbSize;
  result.dwTemplateMinLevel := FdwTemplateMinLevel;
  result.dwTemplateRecommended := FdwTemplateRecommended;
  result.dwTemplateCurrentLevel := FdwTemplateCurrentLevel;
  result.dwFlags := FdwFlags;
end;

constructor _tagCODEBASEHOLDWrapper.Create(ARecord: _tagCODEBASEHOLD);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwVersionMS := ARecord.dwVersionMS;
  FdwVersionLS := ARecord.dwVersionLS;
  FdwStyle := ARecord.dwStyle;
end;

function _tagCODEBASEHOLDWrapper.ObjToRec: _tagCODEBASEHOLD;
begin
  result.cbSize := FcbSize;
  result.dwVersionMS := FdwVersionMS;
  result.dwVersionLS := FdwVersionLS;
  result.dwStyle := FdwStyle;
end;

constructor _tagSOFTDISTINFOWrapper.Create(ARecord: _tagSOFTDISTINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
  FdwAdState := ARecord.dwAdState;
  FdwInstalledVersionMS := ARecord.dwInstalledVersionMS;
  FdwInstalledVersionLS := ARecord.dwInstalledVersionLS;
  FdwUpdateVersionMS := ARecord.dwUpdateVersionMS;
  FdwUpdateVersionLS := ARecord.dwUpdateVersionLS;
  FdwAdvertisedVersionMS := ARecord.dwAdvertisedVersionMS;
  FdwAdvertisedVersionLS := ARecord.dwAdvertisedVersionLS;
  FdwReserved := ARecord.dwReserved;
end;

function _tagSOFTDISTINFOWrapper.ObjToRec: _tagSOFTDISTINFO;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
  result.dwAdState := FdwAdState;
  result.dwInstalledVersionMS := FdwInstalledVersionMS;
  result.dwInstalledVersionLS := FdwInstalledVersionLS;
  result.dwUpdateVersionMS := FdwUpdateVersionMS;
  result.dwUpdateVersionLS := FdwUpdateVersionLS;
  result.dwAdvertisedVersionMS := FdwAdvertisedVersionMS;
  result.dwAdvertisedVersionLS := FdwAdvertisedVersionLS;
  result.dwReserved := FdwReserved;
end;

constructor _tagPROTOCOLFILTERDATAWrapper.Create(ARecord: _tagPROTOCOLFILTERDATA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFilterFlags := ARecord.dwFilterFlags;
end;

function _tagPROTOCOLFILTERDATAWrapper.ObjToRec: _tagPROTOCOLFILTERDATA;
begin
  result.cbSize := FcbSize;
  result.dwFilterFlags := FdwFilterFlags;
end;

constructor _tagDATAINFOWrapper.Create(ARecord: _tagDATAINFO);
begin
  inherited Create;
  FulTotalSize := ARecord.ulTotalSize;
  FulavrPacketSize := ARecord.ulavrPacketSize;
  FulConnectSpeed := ARecord.ulConnectSpeed;
  FulProcessorSpeed := ARecord.ulProcessorSpeed;
end;

function _tagDATAINFOWrapper.ObjToRec: _tagDATAINFO;
begin
  result.ulTotalSize := FulTotalSize;
  result.ulavrPacketSize := FulavrPacketSize;
  result.ulConnectSpeed := FulConnectSpeed;
  result.ulProcessorSpeed := FulProcessorSpeed;
end;

constructor _tagHIT_LOGGING_INFOWrapper.Create(ARecord: _tagHIT_LOGGING_INFO);
begin
  inherited Create;
  FdwStructSize := ARecord.dwStructSize;
end;

function _tagHIT_LOGGING_INFOWrapper.ObjToRec: _tagHIT_LOGGING_INFO;
begin
  result.dwStructSize := FdwStructSize;
end;



procedure TatUrlMonLibrary.__GetClassURL(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UrlMon.GetClassURL(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUrlMonLibrary.__RegisterMediaTypes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UrlMon.RegisterMediaTypes(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUrlMonLibrary.__ObtainUserAgentString(AMachine: TatVirtualMachine);
  var
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(UrlMon.ObtainUserAgentString(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatUrlMonLibrary.__CoInternetParseUrl(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  Param5: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(UrlMon.CoInternetParseUrl(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4)),Param5,VarToInteger(GetInputArg(6))));
    ReturnOutputArg(AResult);
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatUrlMonLibrary.__CoInternetCombineUrl(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  Param5: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(UrlMon.CoInternetCombineUrl(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4)),Param5,VarToInteger(GetInputArg(6))));
    ReturnOutputArg(AResult);
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatUrlMonLibrary.__CoInternetCompareUrl(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UrlMon.CoInternetCompareUrl(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUrlMonLibrary.__CoInternetGetProtocolFlags(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(UrlMon.CoInternetGetProtocolFlags(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatUrlMonLibrary.__CoInternetGetSecurityUrl(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param1: LPWSTR;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(UrlMon.CoInternetGetSecurityUrl(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatUrlMonLibrary.__OInetParseUrl(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  Param5: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(UrlMon.OInetParseUrl(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4)),Param5,VarToInteger(GetInputArg(6))));
    ReturnOutputArg(AResult);
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatUrlMonLibrary.__OInetCombineUrl(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  Param5: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(UrlMon.OInetCombineUrl(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4)),Param5,VarToInteger(GetInputArg(6))));
    ReturnOutputArg(AResult);
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatUrlMonLibrary.__OInetCompareUrl(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UrlMon.OInetCompareUrl(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUrlMonLibrary.__CopyStgMedium(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TStgMedium;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagSTGMEDIUMWrapper) then 
  Param1Rec := tagSTGMEDIUMWrapper.Create(Param1);
Param1 := tagSTGMEDIUMWrapper(Param1Rec).ObjToRec;
AResult := Integer(UrlMon.CopyStgMedium(tagSTGMEDIUMWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagSTGMEDIUMWrapper.Create(Param1)));
  end;
end;

procedure TatUrlMonLibrary.__CopyBindInfo(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TBindInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _tagBINDINFOWrapper) then 
  Param1Rec := _tagBINDINFOWrapper.Create(Param1);
Param1 := _tagBINDINFOWrapper(Param1Rec).ObjToRec;
AResult := Integer(UrlMon.CopyBindInfo(_tagBINDINFOWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_tagBINDINFOWrapper.Create(Param1)));
  end;
end;

procedure TatUrlMonLibrary.__ReleaseBindInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    UrlMon.ReleaseBindInfo(_tagBINDINFOWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatUrlMonLibrary.__GetUrlPolicyPermissions(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UrlMon.GetUrlPolicyPermissions(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUrlMonLibrary.__SetUrlPolicyPermissions(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UrlMon.SetUrlPolicyPermissions(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUrlMonLibrary.__GetSoftwareUpdateInfo(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TSoftDistInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _tagSOFTDISTINFOWrapper) then 
  Param1Rec := _tagSOFTDISTINFOWrapper.Create(Param1);
Param1 := _tagSOFTDISTINFOWrapper(Param1Rec).ObjToRec;
AResult := Integer(UrlMon.GetSoftwareUpdateInfo(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_tagSOFTDISTINFOWrapper.Create(Param1)));
  end;
end;

procedure TatUrlMonLibrary.__SetSoftwareUpdateAdvertisementState(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UrlMon.SetSoftwareUpdateAdvertisementState(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUrlMonLibrary.__IsLoggingEnabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := UrlMon.IsLoggingEnabled(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUrlMonLibrary.__IsLoggingEnabledA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := UrlMon.IsLoggingEnabledA(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUrlMonLibrary.__IsLoggingEnabledW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := UrlMon.IsLoggingEnabledW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUrlMonLibrary.__WriteHitLogging(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := UrlMon.WriteHitLogging(_tagHIT_LOGGING_INFOWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUrlMonLibrary.__GetSZ_URLCONTEXT(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(WideCharToString(UrlMon.SZ_URLCONTEXT));
  end;
end;

procedure TatUrlMonLibrary.__GetSZ_ASYNC_CALLEE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(WideCharToString(UrlMon.SZ_ASYNC_CALLEE));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IPersistMoniker(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IPersistMoniker)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IBinding(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IBinding)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IBindStatusCallback(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IBindStatusCallback)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IAuthenticate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IAuthenticate)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IHttpNegotiate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IHttpNegotiate)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IWindowForBindingUI(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IWindowForBindingUI)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_ICodeInstall(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_ICodeInstall)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IWinInetInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IWinInetInfo)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IHttpSecurity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IHttpSecurity)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IWinInetHttpInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IWinInetHttpInfo)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IBindHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IBindHost)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IInternet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IInternet)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IInternetBindInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IInternetBindInfo)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IInternetProtocolRoot(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IInternetProtocolRoot)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IInternetProtocol(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IInternetProtocol)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IInternetProtocolSink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IInternetProtocolSink)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IInternetSession(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IInternetSession)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IInternetThreadSwitch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IInternetThreadSwitch)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IInternetPriority(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IInternetPriority)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IInternetProtocolInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IInternetProtocolInfo)));
  end;
end;

procedure TatUrlMonLibrary.__GetSID_IBindHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.SID_IBindHost)));
  end;
end;

procedure TatUrlMonLibrary.__GetSID_SBindHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.SID_SBindHost)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IOInet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IOInet)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IOInetBindInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IOInetBindInfo)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IOInetProtocolRoot(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IOInetProtocolRoot)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IOInetProtocol(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IOInetProtocol)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IOInetProtocolSink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IOInetProtocolSink)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IOInetProtocolInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IOInetProtocolInfo)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IOInetSession(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IOInetSession)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IOInetPriority(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IOInetPriority)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IOInetThreadSwitch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IOInetThreadSwitch)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IInternetSecurityMgrSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IInternetSecurityMgrSite)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IInternetSecurityManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IInternetSecurityManager)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IInternetHostSecurityManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IInternetHostSecurityManager)));
  end;
end;

procedure TatUrlMonLibrary.__GetSID_IInternetSecurityManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.SID_IInternetSecurityManager)));
  end;
end;

procedure TatUrlMonLibrary.__GetSID_IInternetHostSecurityManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.SID_IInternetHostSecurityManager)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IInternetZoneManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IInternetZoneManager)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_ISoftDistExt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_ISoftDistExt)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IDataFilter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IDataFilter)));
  end;
end;

procedure TatUrlMonLibrary.__GetIID_IEncodingFilterFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(UrlMon.IID_IEncodingFilterFactory)));
  end;
end;

procedure TatUrlMonLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetClassURL',2,tkInteger,nil,__GetClassURL,false,0);
    DefineMethod('RegisterMediaTypes',3,tkInteger,nil,__RegisterMediaTypes,false,0);
    DefineMethod('ObtainUserAgentString',3,tkInteger,nil,__ObtainUserAgentString,false,0).SetVarArgs([2]);
    DefineMethod('CoInternetParseUrl',7,tkInteger,nil,__CoInternetParseUrl,false,0).SetVarArgs([5]);
    DefineMethod('CoInternetCombineUrl',7,tkInteger,nil,__CoInternetCombineUrl,false,0).SetVarArgs([5]);
    DefineMethod('CoInternetCompareUrl',3,tkInteger,nil,__CoInternetCompareUrl,false,0);
    DefineMethod('CoInternetGetProtocolFlags',3,tkInteger,nil,__CoInternetGetProtocolFlags,false,0).SetVarArgs([1]);
    DefineMethod('CoInternetGetSecurityUrl',4,tkInteger,nil,__CoInternetGetSecurityUrl,false,0).SetVarArgs([1]);
    DefineMethod('OInetParseUrl',7,tkInteger,nil,__OInetParseUrl,false,0).SetVarArgs([5]);
    DefineMethod('OInetCombineUrl',7,tkInteger,nil,__OInetCombineUrl,false,0).SetVarArgs([5]);
    DefineMethod('OInetCompareUrl',3,tkInteger,nil,__OInetCompareUrl,false,0);
    DefineMethod('CopyStgMedium',2,tkInteger,nil,__CopyStgMedium,false,0).SetVarArgs([1]);
    DefineMethod('CopyBindInfo',2,tkInteger,nil,__CopyBindInfo,false,0).SetVarArgs([1]);
    DefineMethod('ReleaseBindInfo',1,tkNone,nil,__ReleaseBindInfo,false,0);
    DefineMethod('GetUrlPolicyPermissions',1,tkInteger,nil,__GetUrlPolicyPermissions,false,0);
    DefineMethod('SetUrlPolicyPermissions',2,tkInteger,nil,__SetUrlPolicyPermissions,false,0);
    DefineMethod('GetSoftwareUpdateInfo',2,tkInteger,nil,__GetSoftwareUpdateInfo,false,0).SetVarArgs([1]);
    DefineMethod('SetSoftwareUpdateAdvertisementState',4,tkInteger,nil,__SetSoftwareUpdateAdvertisementState,false,0);
    DefineMethod('IsLoggingEnabled',1,tkVariant,nil,__IsLoggingEnabled,false,0);
    DefineMethod('IsLoggingEnabledA',1,tkVariant,nil,__IsLoggingEnabledA,false,0);
    DefineMethod('IsLoggingEnabledW',1,tkVariant,nil,__IsLoggingEnabledW,false,0);
    DefineMethod('WriteHitLogging',1,tkVariant,nil,__WriteHitLogging,false,0);
    DefineProp('SZ_URLCONTEXT',tkVariant,__GetSZ_URLCONTEXT,nil,nil,false,0);
    DefineProp('SZ_ASYNC_CALLEE',tkVariant,__GetSZ_ASYNC_CALLEE,nil,nil,false,0);
    DefineProp('IID_IPersistMoniker',tkVariant,__GetIID_IPersistMoniker,nil,nil,false,0);
    DefineProp('IID_IBinding',tkVariant,__GetIID_IBinding,nil,nil,false,0);
    DefineProp('IID_IBindStatusCallback',tkVariant,__GetIID_IBindStatusCallback,nil,nil,false,0);
    DefineProp('IID_IAuthenticate',tkVariant,__GetIID_IAuthenticate,nil,nil,false,0);
    DefineProp('IID_IHttpNegotiate',tkVariant,__GetIID_IHttpNegotiate,nil,nil,false,0);
    DefineProp('IID_IWindowForBindingUI',tkVariant,__GetIID_IWindowForBindingUI,nil,nil,false,0);
    DefineProp('IID_ICodeInstall',tkVariant,__GetIID_ICodeInstall,nil,nil,false,0);
    DefineProp('IID_IWinInetInfo',tkVariant,__GetIID_IWinInetInfo,nil,nil,false,0);
    DefineProp('IID_IHttpSecurity',tkVariant,__GetIID_IHttpSecurity,nil,nil,false,0);
    DefineProp('IID_IWinInetHttpInfo',tkVariant,__GetIID_IWinInetHttpInfo,nil,nil,false,0);
    DefineProp('IID_IBindHost',tkVariant,__GetIID_IBindHost,nil,nil,false,0);
    DefineProp('IID_IInternet',tkVariant,__GetIID_IInternet,nil,nil,false,0);
    DefineProp('IID_IInternetBindInfo',tkVariant,__GetIID_IInternetBindInfo,nil,nil,false,0);
    DefineProp('IID_IInternetProtocolRoot',tkVariant,__GetIID_IInternetProtocolRoot,nil,nil,false,0);
    DefineProp('IID_IInternetProtocol',tkVariant,__GetIID_IInternetProtocol,nil,nil,false,0);
    DefineProp('IID_IInternetProtocolSink',tkVariant,__GetIID_IInternetProtocolSink,nil,nil,false,0);
    DefineProp('IID_IInternetSession',tkVariant,__GetIID_IInternetSession,nil,nil,false,0);
    DefineProp('IID_IInternetThreadSwitch',tkVariant,__GetIID_IInternetThreadSwitch,nil,nil,false,0);
    DefineProp('IID_IInternetPriority',tkVariant,__GetIID_IInternetPriority,nil,nil,false,0);
    DefineProp('IID_IInternetProtocolInfo',tkVariant,__GetIID_IInternetProtocolInfo,nil,nil,false,0);
    DefineProp('SID_IBindHost',tkVariant,__GetSID_IBindHost,nil,nil,false,0);
    DefineProp('SID_SBindHost',tkVariant,__GetSID_SBindHost,nil,nil,false,0);
    DefineProp('IID_IOInet',tkVariant,__GetIID_IOInet,nil,nil,false,0);
    DefineProp('IID_IOInetBindInfo',tkVariant,__GetIID_IOInetBindInfo,nil,nil,false,0);
    DefineProp('IID_IOInetProtocolRoot',tkVariant,__GetIID_IOInetProtocolRoot,nil,nil,false,0);
    DefineProp('IID_IOInetProtocol',tkVariant,__GetIID_IOInetProtocol,nil,nil,false,0);
    DefineProp('IID_IOInetProtocolSink',tkVariant,__GetIID_IOInetProtocolSink,nil,nil,false,0);
    DefineProp('IID_IOInetProtocolInfo',tkVariant,__GetIID_IOInetProtocolInfo,nil,nil,false,0);
    DefineProp('IID_IOInetSession',tkVariant,__GetIID_IOInetSession,nil,nil,false,0);
    DefineProp('IID_IOInetPriority',tkVariant,__GetIID_IOInetPriority,nil,nil,false,0);
    DefineProp('IID_IOInetThreadSwitch',tkVariant,__GetIID_IOInetThreadSwitch,nil,nil,false,0);
    DefineProp('IID_IInternetSecurityMgrSite',tkVariant,__GetIID_IInternetSecurityMgrSite,nil,nil,false,0);
    DefineProp('IID_IInternetSecurityManager',tkVariant,__GetIID_IInternetSecurityManager,nil,nil,false,0);
    DefineProp('IID_IInternetHostSecurityManager',tkVariant,__GetIID_IInternetHostSecurityManager,nil,nil,false,0);
    DefineProp('SID_IInternetSecurityManager',tkVariant,__GetSID_IInternetSecurityManager,nil,nil,false,0);
    DefineProp('SID_IInternetHostSecurityManager',tkVariant,__GetSID_IInternetHostSecurityManager,nil,nil,false,0);
    DefineProp('IID_IInternetZoneManager',tkVariant,__GetIID_IInternetZoneManager,nil,nil,false,0);
    DefineProp('IID_ISoftDistExt',tkVariant,__GetIID_ISoftDistExt,nil,nil,false,0);
    DefineProp('IID_IDataFilter',tkVariant,__GetIID_IDataFilter,nil,nil,false,0);
    DefineProp('IID_IEncodingFilterFactory',tkVariant,__GetIID_IEncodingFilterFactory,nil,nil,false,0);
    AddConstant('MKSYS_URLMONIKER',MKSYS_URLMONIKER);
    AddConstant('URLMON_OPTION_USERAGENT',URLMON_OPTION_USERAGENT);
    AddConstant('URLMON_OPTION_USERAGENT_REFRESH',URLMON_OPTION_USERAGENT_REFRESH);
    AddConstant('CF_NULL',CF_NULL);
    AddConstant('CFSTR_MIME_NULL',CFSTR_MIME_NULL);
    AddConstant('CFSTR_MIME_TEXT',CFSTR_MIME_TEXT);
    AddConstant('CFSTR_MIME_RICHTEXT',CFSTR_MIME_RICHTEXT);
    AddConstant('CFSTR_MIME_X_BITMAP',CFSTR_MIME_X_BITMAP);
    AddConstant('CFSTR_MIME_POSTSCRIPT',CFSTR_MIME_POSTSCRIPT);
    AddConstant('CFSTR_MIME_AIFF',CFSTR_MIME_AIFF);
    AddConstant('CFSTR_MIME_BASICAUDIO',CFSTR_MIME_BASICAUDIO);
    AddConstant('CFSTR_MIME_WAV',CFSTR_MIME_WAV);
    AddConstant('CFSTR_MIME_X_WAV',CFSTR_MIME_X_WAV);
    AddConstant('CFSTR_MIME_GIF',CFSTR_MIME_GIF);
    AddConstant('CFSTR_MIME_PJPEG',CFSTR_MIME_PJPEG);
    AddConstant('CFSTR_MIME_JPEG',CFSTR_MIME_JPEG);
    AddConstant('CFSTR_MIME_TIFF',CFSTR_MIME_TIFF);
    AddConstant('CFSTR_MIME_X_PNG',CFSTR_MIME_X_PNG);
    AddConstant('CFSTR_MIME_BMP',CFSTR_MIME_BMP);
    AddConstant('CFSTR_MIME_X_ART',CFSTR_MIME_X_ART);
    AddConstant('CFSTR_MIME_X_EMF',CFSTR_MIME_X_EMF);
    AddConstant('CFSTR_MIME_X_WMF',CFSTR_MIME_X_WMF);
    AddConstant('CFSTR_MIME_AVI',CFSTR_MIME_AVI);
    AddConstant('CFSTR_MIME_MPEG',CFSTR_MIME_MPEG);
    AddConstant('CFSTR_MIME_FRACTALS',CFSTR_MIME_FRACTALS);
    AddConstant('CFSTR_MIME_RAWDATA',CFSTR_MIME_RAWDATA);
    AddConstant('CFSTR_MIME_RAWDATASTRM',CFSTR_MIME_RAWDATASTRM);
    AddConstant('CFSTR_MIME_PDF',CFSTR_MIME_PDF);
    AddConstant('CFSTR_MIME_X_AIFF',CFSTR_MIME_X_AIFF);
    AddConstant('CFSTR_MIME_X_REALAUDIO',CFSTR_MIME_X_REALAUDIO);
    AddConstant('CFSTR_MIME_XBM',CFSTR_MIME_XBM);
    AddConstant('CFSTR_MIME_QUICKTIME',CFSTR_MIME_QUICKTIME);
    AddConstant('CFSTR_MIME_X_MSVIDEO',CFSTR_MIME_X_MSVIDEO);
    AddConstant('CFSTR_MIME_X_SGI_MOVIE',CFSTR_MIME_X_SGI_MOVIE);
    AddConstant('CFSTR_MIME_HTML',CFSTR_MIME_HTML);
    AddConstant('MK_S_ASYNCHRONOUS',MK_S_ASYNCHRONOUS);
    AddConstant('S_ASYNCHRONOUS',S_ASYNCHRONOUS);
    AddConstant('E_PENDING',E_PENDING);
    AddConstant('INET_E_INVALID_URL',INET_E_INVALID_URL);
    AddConstant('INET_E_NO_SESSION',INET_E_NO_SESSION);
    AddConstant('INET_E_CANNOT_CONNECT',INET_E_CANNOT_CONNECT);
    AddConstant('INET_E_RESOURCE_NOT_FOUND',INET_E_RESOURCE_NOT_FOUND);
    AddConstant('INET_E_OBJECT_NOT_FOUND',INET_E_OBJECT_NOT_FOUND);
    AddConstant('INET_E_DATA_NOT_AVAILABLE',INET_E_DATA_NOT_AVAILABLE);
    AddConstant('INET_E_DOWNLOAD_FAILURE',INET_E_DOWNLOAD_FAILURE);
    AddConstant('INET_E_AUTHENTICATION_REQUIRED',INET_E_AUTHENTICATION_REQUIRED);
    AddConstant('INET_E_NO_VALID_MEDIA',INET_E_NO_VALID_MEDIA);
    AddConstant('INET_E_CONNECTION_TIMEOUT',INET_E_CONNECTION_TIMEOUT);
    AddConstant('INET_E_INVALID_REQUEST',INET_E_INVALID_REQUEST);
    AddConstant('INET_E_UNKNOWN_PROTOCOL',INET_E_UNKNOWN_PROTOCOL);
    AddConstant('INET_E_SECURITY_PROBLEM',INET_E_SECURITY_PROBLEM);
    AddConstant('INET_E_CANNOT_LOAD_DATA',INET_E_CANNOT_LOAD_DATA);
    AddConstant('INET_E_CANNOT_INSTANTIATE_OBJECT',INET_E_CANNOT_INSTANTIATE_OBJECT);
    AddConstant('INET_E_REDIRECT_FAILED',INET_E_REDIRECT_FAILED);
    AddConstant('INET_E_REDIRECT_TO_DIR',INET_E_REDIRECT_TO_DIR);
    AddConstant('INET_E_CANNOT_LOCK_REQUEST',INET_E_CANNOT_LOCK_REQUEST);
    AddConstant('INET_E_ERROR_FIRST',INET_E_ERROR_FIRST);
    AddConstant('INET_E_ERROR_LAST',INET_E_ERROR_LAST);
    AddConstant('BINDVERB_GET',BINDVERB_GET);
    AddConstant('BINDVERB_POST',BINDVERB_POST);
    AddConstant('BINDVERB_PUT',BINDVERB_PUT);
    AddConstant('BINDVERB_CUSTOM',BINDVERB_CUSTOM);
    AddConstant('BINDINFOF_URLENCODESTGMEDDATA',BINDINFOF_URLENCODESTGMEDDATA);
    AddConstant('BINDINFOF_URLENCODEDEXTRAINFO',BINDINFOF_URLENCODEDEXTRAINFO);
    AddConstant('BINDF_ASYNCHRONOUS',BINDF_ASYNCHRONOUS);
    AddConstant('BINDF_ASYNCSTORAGE',BINDF_ASYNCSTORAGE);
    AddConstant('BINDF_NOPROGRESSIVERENDERING',BINDF_NOPROGRESSIVERENDERING);
    AddConstant('BINDF_OFFLINEOPERATION',BINDF_OFFLINEOPERATION);
    AddConstant('BINDF_GETNEWESTVERSION',BINDF_GETNEWESTVERSION);
    AddConstant('BINDF_NOWRITECACHE',BINDF_NOWRITECACHE);
    AddConstant('BINDF_NEEDFILE',BINDF_NEEDFILE);
    AddConstant('BINDF_PULLDATA',BINDF_PULLDATA);
    AddConstant('BINDF_IGNORESECURITYPROBLEM',BINDF_IGNORESECURITYPROBLEM);
    AddConstant('BINDF_RESYNCHRONIZE',BINDF_RESYNCHRONIZE);
    AddConstant('BINDF_HYPERLINK',BINDF_HYPERLINK);
    AddConstant('BINDF_NO_UI',BINDF_NO_UI);
    AddConstant('BINDF_SILENTOPERATION',BINDF_SILENTOPERATION);
    AddConstant('BINDF_PRAGMA_NO_CACHE',BINDF_PRAGMA_NO_CACHE);
    AddConstant('BINDF_FREE_THREADED',BINDF_FREE_THREADED);
    AddConstant('BINDF_DIRECT_READ',BINDF_DIRECT_READ);
    AddConstant('BINDF_FORMS_SUBMIT',BINDF_FORMS_SUBMIT);
    AddConstant('BINDF_GETFROMCACHE_IF_NET_FAIL',BINDF_GETFROMCACHE_IF_NET_FAIL);
    AddConstant('BINDF_DONTUSECACHE',BINDF_DONTUSECACHE);
    AddConstant('BINDF_DONTPUTINCACHE',BINDF_DONTPUTINCACHE);
    AddConstant('BINDF_NOCOPYDATA',BINDF_NOCOPYDATA);
    AddConstant('BSCF_FIRSTDATANOTIFICATION',BSCF_FIRSTDATANOTIFICATION);
    AddConstant('BSCF_INTERMEDIATEDATANOTIFICATION',BSCF_INTERMEDIATEDATANOTIFICATION);
    AddConstant('BSCF_LASTDATANOTIFICATION',BSCF_LASTDATANOTIFICATION);
    AddConstant('BSCF_DATAFULLYAVAILABLE',BSCF_DATAFULLYAVAILABLE);
    AddConstant('BSCF_AVAILABLEDATASIZEUNKNOWN',BSCF_AVAILABLEDATASIZEUNKNOWN);
    AddConstant('BINDSTATUS_FINDINGRESOURCE',BINDSTATUS_FINDINGRESOURCE);
    AddConstant('BINDSTATUS_CONNECTING',BINDSTATUS_CONNECTING);
    AddConstant('BINDSTATUS_REDIRECTING',BINDSTATUS_REDIRECTING);
    AddConstant('BINDSTATUS_BEGINDOWNLOADDATA',BINDSTATUS_BEGINDOWNLOADDATA);
    AddConstant('BINDSTATUS_DOWNLOADINGDATA',BINDSTATUS_DOWNLOADINGDATA);
    AddConstant('BINDSTATUS_ENDDOWNLOADDATA',BINDSTATUS_ENDDOWNLOADDATA);
    AddConstant('BINDSTATUS_BEGINDOWNLOADCOMPONENTS',BINDSTATUS_BEGINDOWNLOADCOMPONENTS);
    AddConstant('BINDSTATUS_INSTALLINGCOMPONENTS',BINDSTATUS_INSTALLINGCOMPONENTS);
    AddConstant('BINDSTATUS_ENDDOWNLOADCOMPONENTS',BINDSTATUS_ENDDOWNLOADCOMPONENTS);
    AddConstant('BINDSTATUS_USINGCACHEDCOPY',BINDSTATUS_USINGCACHEDCOPY);
    AddConstant('BINDSTATUS_SENDINGREQUEST',BINDSTATUS_SENDINGREQUEST);
    AddConstant('BINDSTATUS_CLASSIDAVAILABLE',BINDSTATUS_CLASSIDAVAILABLE);
    AddConstant('BINDSTATUS_MIMETYPEAVAILABLE',BINDSTATUS_MIMETYPEAVAILABLE);
    AddConstant('BINDSTATUS_CACHEFILENAMEAVAILABLE',BINDSTATUS_CACHEFILENAMEAVAILABLE);
    AddConstant('BINDSTATUS_BEGINSYNCOPERATION',BINDSTATUS_BEGINSYNCOPERATION);
    AddConstant('BINDSTATUS_ENDSYNCOPERATION',BINDSTATUS_ENDSYNCOPERATION);
    AddConstant('BINDSTATUS_BEGINUPLOADDATA',BINDSTATUS_BEGINUPLOADDATA);
    AddConstant('BINDSTATUS_UPLOADINGDATA',BINDSTATUS_UPLOADINGDATA);
    AddConstant('BINDSTATUS_ENDUPLOADDATA',BINDSTATUS_ENDUPLOADDATA);
    AddConstant('BINDSTATUS_PROTOCOLCLASSID',BINDSTATUS_PROTOCOLCLASSID);
    AddConstant('BINDSTATUS_ENCODING',BINDSTATUS_ENCODING);
    AddConstant('BINDSTATUS_VERIFIEDMIMETYPEAVAILABLE',BINDSTATUS_VERIFIEDMIMETYPEAVAILABLE);
    AddConstant('BINDSTATUS_CLASSINSTALLLOCATION',BINDSTATUS_CLASSINSTALLLOCATION);
    AddConstant('BINDSTATUS_DECODING',BINDSTATUS_DECODING);
    AddConstant('BINDSTATUS_LOADINGMIMEHANDLER',BINDSTATUS_LOADINGMIMEHANDLER);
    AddConstant('CIP_DISK_FULL',CIP_DISK_FULL);
    AddConstant('CIP_ACCESS_DENIED',CIP_ACCESS_DENIED);
    AddConstant('CIP_NEWER_VERSION_EXISTS',CIP_NEWER_VERSION_EXISTS);
    AddConstant('CIP_OLDER_VERSION_EXISTS',CIP_OLDER_VERSION_EXISTS);
    AddConstant('CIP_NAME_CONFLICT',CIP_NAME_CONFLICT);
    AddConstant('CIP_TRUST_VERIFICATION_COMPONENT_MISSING',CIP_TRUST_VERIFICATION_COMPONENT_MISSING);
    AddConstant('CIP_EXE_SELF_REGISTERATION_TIMEOUT',CIP_EXE_SELF_REGISTERATION_TIMEOUT);
    AddConstant('CIP_UNSAFE_TO_ABORT',CIP_UNSAFE_TO_ABORT);
    AddConstant('CIP_NEED_REBOOT',CIP_NEED_REBOOT);
    AddConstant('WININETINFO_OPTION_LOCK_HANDLE',WININETINFO_OPTION_LOCK_HANDLE);
    AddConstant('URLOSTRM_USECACHEDCOPY_ONLY',URLOSTRM_USECACHEDCOPY_ONLY);
    AddConstant('URLOSTRM_USECACHEDCOPY',URLOSTRM_USECACHEDCOPY);
    AddConstant('URLOSTRM_GETNEWESTVERSION',URLOSTRM_GETNEWESTVERSION);
    AddConstant('BINDSTRING_HEADERS',BINDSTRING_HEADERS);
    AddConstant('BINDSTRING_ACCEPT_MIMES',BINDSTRING_ACCEPT_MIMES);
    AddConstant('BINDSTRING_EXTRA_URL',BINDSTRING_EXTRA_URL);
    AddConstant('BINDSTRING_LANGUAGE',BINDSTRING_LANGUAGE);
    AddConstant('BINDSTRING_USERNAME',BINDSTRING_USERNAME);
    AddConstant('BINDSTRING_PASSWORD',BINDSTRING_PASSWORD);
    AddConstant('BINDSTRING_UA_PIXELS',BINDSTRING_UA_PIXELS);
    AddConstant('BINDSTRING_UA_COLOR',BINDSTRING_UA_COLOR);
    AddConstant('BINDSTRING_OS',BINDSTRING_OS);
    AddConstant('BINDSTRING_USER_AGENT',BINDSTRING_USER_AGENT);
    AddConstant('BINDSTRING_ACCEPT_ENCODINGS',BINDSTRING_ACCEPT_ENCODINGS);
    AddConstant('BINDSTRING_POST_COOKIE',BINDSTRING_POST_COOKIE);
    AddConstant('BINDSTRING_POST_DATA_MIME',BINDSTRING_POST_DATA_MIME);
    AddConstant('BINDSTRING_URL',BINDSTRING_URL);
    AddConstant('PI_PARSE_URL',PI_PARSE_URL);
    AddConstant('PI_FILTER_MODE',PI_FILTER_MODE);
    AddConstant('PI_FORCE_ASYNC',PI_FORCE_ASYNC);
    AddConstant('PI_USE_WORKERTHREAD',PI_USE_WORKERTHREAD);
    AddConstant('PI_MIMEVERIFICATION',PI_MIMEVERIFICATION);
    AddConstant('PI_CLSIDLOOKUP',PI_CLSIDLOOKUP);
    AddConstant('PI_DATAPROGRESS',PI_DATAPROGRESS);
    AddConstant('PI_SYNCHRONOUS',PI_SYNCHRONOUS);
    AddConstant('PI_APARTMENTTHREADED',PI_APARTMENTTHREADED);
    AddConstant('PI_CLASSINSTALL',PI_CLASSINSTALL);
    AddConstant('PD_FORCE_SWITCH',PD_FORCE_SWITCH);
    AddConstant('PI_DOCFILECLSIDLOOKUP',PI_DOCFILECLSIDLOOKUP);
    AddConstant('OIBDG_APARTMENTTHREADED',OIBDG_APARTMENTTHREADED);
    AddConstant('PARSE_CANONICALIZE',PARSE_CANONICALIZE);
    AddConstant('PARSE_FRIENDLY',PARSE_FRIENDLY);
    AddConstant('PARSE_SECURITY_URL',PARSE_SECURITY_URL);
    AddConstant('PARSE_ROOTDOCUMENT',PARSE_ROOTDOCUMENT);
    AddConstant('PARSE_DOCUMENT',PARSE_DOCUMENT);
    AddConstant('PARSE_ANCHOR',PARSE_ANCHOR);
    AddConstant('PARSE_ENCODE',PARSE_ENCODE);
    AddConstant('PARSE_DECODE',PARSE_DECODE);
    AddConstant('PARSE_PATH_FROM_URL',PARSE_PATH_FROM_URL);
    AddConstant('PARSE_URL_FROM_PATH',PARSE_URL_FROM_PATH);
    AddConstant('PARSE_MIME',PARSE_MIME);
    AddConstant('PARSE_SERVER',PARSE_SERVER);
    AddConstant('PARSE_SCHEMA',PARSE_SCHEMA);
    AddConstant('PARSE_SITE',PARSE_SITE);
    AddConstant('PARSE_DOMAIN',PARSE_DOMAIN);
    AddConstant('PARSE_LOCATION',PARSE_LOCATION);
    AddConstant('PARSE_SECURITY_DOMAIN',PARSE_SECURITY_DOMAIN);
    AddConstant('PSU_DEFAULT',PSU_DEFAULT);
    AddConstant('PSU_SECURITY_URL_ONLY',PSU_SECURITY_URL_ONLY);
    AddConstant('QUERY_EXPIRATION_DATE',QUERY_EXPIRATION_DATE);
    AddConstant('QUERY_TIME_OF_LAST_CHANGE',QUERY_TIME_OF_LAST_CHANGE);
    AddConstant('QUERY_CONTENT_ENCODING',QUERY_CONTENT_ENCODING);
    AddConstant('QUERY_CONTENT_TYPE',QUERY_CONTENT_TYPE);
    AddConstant('QUERY_REFRESH',QUERY_REFRESH);
    AddConstant('QUERY_RECOMBINE',QUERY_RECOMBINE);
    AddConstant('QUERY_CAN_NAVIGATE',QUERY_CAN_NAVIGATE);
    AddConstant('QUERY_USES_NETWORK',QUERY_USES_NETWORK);
    AddConstant('QUERY_IS_CACHED',QUERY_IS_CACHED);
    AddConstant('QUERY_IS_INSTALLEDENTRY',QUERY_IS_INSTALLEDENTRY);
    AddConstant('QUERY_IS_CACHED_OR_MAPPED',QUERY_IS_CACHED_OR_MAPPED);
    AddConstant('QUERY_USES_CACHE',QUERY_USES_CACHE);
    AddConstant('INET_E_USE_DEFAULT_PROTOCOLHANDLER',INET_E_USE_DEFAULT_PROTOCOLHANDLER);
    AddConstant('INET_E_USE_DEFAULT_SETTING',INET_E_USE_DEFAULT_SETTING);
    AddConstant('INET_E_DEFAULT_ACTION',INET_E_DEFAULT_ACTION);
    AddConstant('INET_E_QUERYOPTION_UNKNOWN',INET_E_QUERYOPTION_UNKNOWN);
    AddConstant('INET_E_REDIRECTING',INET_E_REDIRECTING);
    AddConstant('PROTOCOLFLAG_NO_PICS_CHECK',PROTOCOLFLAG_NO_PICS_CHECK);
    AddConstant('MAX_SIZE_SECURITY_ID',MAX_SIZE_SECURITY_ID);
    AddConstant('PUAF_DEFAULT',PUAF_DEFAULT);
    AddConstant('PUAF_NOUI',PUAF_NOUI);
    AddConstant('PUAF_ISFILE',PUAF_ISFILE);
    AddConstant('PUAF_WARN_IF_DENIED',PUAF_WARN_IF_DENIED);
    AddConstant('PUAF_FORCEUI_FOREGROUND',PUAF_FORCEUI_FOREGROUND);
    AddConstant('PUAF_CHECK_TIFS',PUAF_CHECK_TIFS);
    AddConstant('SZM_CREATE',SZM_CREATE);
    AddConstant('SZM_DELETE',SZM_DELETE);
    AddConstant('URLACTION_MIN',URLACTION_MIN);
    AddConstant('URLACTION_DOWNLOAD_MIN',URLACTION_DOWNLOAD_MIN);
    AddConstant('URLACTION_DOWNLOAD_SIGNED_ACTIVEX',URLACTION_DOWNLOAD_SIGNED_ACTIVEX);
    AddConstant('URLACTION_DOWNLOAD_UNSIGNED_ACTIVEX',URLACTION_DOWNLOAD_UNSIGNED_ACTIVEX);
    AddConstant('URLACTION_DOWNLOAD_CURR_MAX',URLACTION_DOWNLOAD_CURR_MAX);
    AddConstant('URLACTION_DOWNLOAD_MAX',URLACTION_DOWNLOAD_MAX);
    AddConstant('URLACTION_ACTIVEX_MIN',URLACTION_ACTIVEX_MIN);
    AddConstant('URLACTION_ACTIVEX_RUN',URLACTION_ACTIVEX_RUN);
    AddConstant('URLACTION_ACTIVEX_OVERRIDE_OBJECT_SAFETY',URLACTION_ACTIVEX_OVERRIDE_OBJECT_SAFETY);
    AddConstant('URLACTION_ACTIVEX_OVERRIDE_DATA_SAFETY',URLACTION_ACTIVEX_OVERRIDE_DATA_SAFETY);
    AddConstant('URLACTION_ACTIVEX_OVERRIDE_SCRIPT_SAFETY',URLACTION_ACTIVEX_OVERRIDE_SCRIPT_SAFETY);
    AddConstant('URLACTION_SCRIPT_OVERRIDE_SAFETY',URLACTION_SCRIPT_OVERRIDE_SAFETY);
    AddConstant('URLACTION_ACTIVEX_CONFIRM_NOOBJECTSAFETY',URLACTION_ACTIVEX_CONFIRM_NOOBJECTSAFETY);
    AddConstant('URLACTION_ACTIVEX_TREATASUNTRUSTED',URLACTION_ACTIVEX_TREATASUNTRUSTED);
    AddConstant('URLACTION_ACTIVEX_CURR_MAX',URLACTION_ACTIVEX_CURR_MAX);
    AddConstant('URLACTION_ACTIVEX_MAX',URLACTION_ACTIVEX_MAX);
    AddConstant('URLACTION_SCRIPT_MIN',URLACTION_SCRIPT_MIN);
    AddConstant('URLACTION_SCRIPT_RUN',URLACTION_SCRIPT_RUN);
    AddConstant('URLACTION_SCRIPT_JAVA_USE',URLACTION_SCRIPT_JAVA_USE);
    AddConstant('URLACTION_SCRIPT_SAFE_ACTIVEX',URLACTION_SCRIPT_SAFE_ACTIVEX);
    AddConstant('URLACTION_SCRIPT_CURR_MAX',URLACTION_SCRIPT_CURR_MAX);
    AddConstant('URLACTION_SCRIPT_MAX',URLACTION_SCRIPT_MAX);
    AddConstant('URLACTION_HTML_MIN',URLACTION_HTML_MIN);
    AddConstant('URLACTION_HTML_SUBMIT_FORMS',URLACTION_HTML_SUBMIT_FORMS);
    AddConstant('URLACTION_HTML_SUBMIT_FORMS_FROM',URLACTION_HTML_SUBMIT_FORMS_FROM);
    AddConstant('URLACTION_HTML_SUBMIT_FORMS_TO',URLACTION_HTML_SUBMIT_FORMS_TO);
    AddConstant('URLACTION_HTML_FONT_DOWNLOAD',URLACTION_HTML_FONT_DOWNLOAD);
    AddConstant('URLACTION_HTML_JAVA_RUN',URLACTION_HTML_JAVA_RUN);
    AddConstant('URLACTION_HTML_CURR_MAX',URLACTION_HTML_CURR_MAX);
    AddConstant('URLACTION_HTML_MAX',URLACTION_HTML_MAX);
    AddConstant('URLACTION_SHELL_MIN',URLACTION_SHELL_MIN);
    AddConstant('URLACTION_SHELL_INSTALL_DTITEMS',URLACTION_SHELL_INSTALL_DTITEMS);
    AddConstant('URLACTION_SHELL_MOVE_OR_COPY',URLACTION_SHELL_MOVE_OR_COPY);
    AddConstant('URLACTION_SHELL_FILE_DOWNLOAD',URLACTION_SHELL_FILE_DOWNLOAD);
    AddConstant('URLACTION_SHELL_VERB',URLACTION_SHELL_VERB);
    AddConstant('URLACTION_SHELL_WEBVIEW_VERB',URLACTION_SHELL_WEBVIEW_VERB);
    AddConstant('URLACTION_SHELL_CURR_MAX',URLACTION_SHELL_CURR_MAX);
    AddConstant('URLACTION_SHELL_MAX',URLACTION_SHELL_MAX);
    AddConstant('URLACTION_NETWORK_MIN',URLACTION_NETWORK_MIN);
    AddConstant('URLACTION_CREDENTIALS_USE',URLACTION_CREDENTIALS_USE);
    AddConstant('URLPOLICY_CREDENTIALS_SILENT_LOGON_OK',URLPOLICY_CREDENTIALS_SILENT_LOGON_OK);
    AddConstant('URLPOLICY_CREDENTIALS_MUST_PROMPT_USER',URLPOLICY_CREDENTIALS_MUST_PROMPT_USER);
    AddConstant('URLPOLICY_CREDENTIALS_CONDITIONAL_PROMPT',URLPOLICY_CREDENTIALS_CONDITIONAL_PROMPT);
    AddConstant('URLPOLICY_CREDENTIALS_ANONYMOUS_ONLY',URLPOLICY_CREDENTIALS_ANONYMOUS_ONLY);
    AddConstant('URLACTION_AUTHENTICATE_CLIENT',URLACTION_AUTHENTICATE_CLIENT);
    AddConstant('URLPOLICY_AUTHENTICATE_CLEARTEXT_OK',URLPOLICY_AUTHENTICATE_CLEARTEXT_OK);
    AddConstant('URLPOLICY_AUTHENTICATE_CHALLENGE_RESPONSE',URLPOLICY_AUTHENTICATE_CHALLENGE_RESPONSE);
    AddConstant('URLPOLICY_AUTHENTICATE_MUTUAL_ONLY',URLPOLICY_AUTHENTICATE_MUTUAL_ONLY);
    AddConstant('URLACTION_NETWORK_CURR_MAX',URLACTION_NETWORK_CURR_MAX);
    AddConstant('URLACTION_NETWORK_MAX',URLACTION_NETWORK_MAX);
    AddConstant('URLACTION_JAVA_MIN',URLACTION_JAVA_MIN);
    AddConstant('URLACTION_JAVA_PERMISSIONS',URLACTION_JAVA_PERMISSIONS);
    AddConstant('URLPOLICY_JAVA_PROHIBIT',URLPOLICY_JAVA_PROHIBIT);
    AddConstant('URLPOLICY_JAVA_HIGH',URLPOLICY_JAVA_HIGH);
    AddConstant('URLPOLICY_JAVA_MEDIUM',URLPOLICY_JAVA_MEDIUM);
    AddConstant('URLPOLICY_JAVA_LOW',URLPOLICY_JAVA_LOW);
    AddConstant('URLPOLICY_JAVA_CUSTOM',URLPOLICY_JAVA_CUSTOM);
    AddConstant('URLACTION_JAVA_CURR_MAX',URLACTION_JAVA_CURR_MAX);
    AddConstant('URLACTION_JAVA_MAX',URLACTION_JAVA_MAX);
    AddConstant('URLACTION_INFODELIVERY_MIN',URLACTION_INFODELIVERY_MIN);
    AddConstant('URLACTION_INFODELIVERY_NO_ADDING_CHANNELS',URLACTION_INFODELIVERY_NO_ADDING_CHANNELS);
    AddConstant('URLACTION_INFODELIVERY_NO_EDITING_CHANNELS',URLACTION_INFODELIVERY_NO_EDITING_CHANNELS);
    AddConstant('URLACTION_INFODELIVERY_NO_REMOVING_CHANNELS',URLACTION_INFODELIVERY_NO_REMOVING_CHANNELS);
    AddConstant('URLACTION_INFODELIVERY_NO_ADDING_SUBSCRIPTIONS',URLACTION_INFODELIVERY_NO_ADDING_SUBSCRIPTIONS);
    AddConstant('URLACTION_INFODELIVERY_NO_EDITING_SUBSCRIPTIONS',URLACTION_INFODELIVERY_NO_EDITING_SUBSCRIPTIONS);
    AddConstant('URLACTION_INFODELIVERY_NO_REMOVING_SUBSCRIPTIONS',URLACTION_INFODELIVERY_NO_REMOVING_SUBSCRIPTIONS);
    AddConstant('URLACTION_INFODELIVERY_NO_CHANNEL_LOGGING',URLACTION_INFODELIVERY_NO_CHANNEL_LOGGING);
    AddConstant('URLACTION_INFODELIVERY_CURR_MAX',URLACTION_INFODELIVERY_CURR_MAX);
    AddConstant('URLACTION_INFODELIVERY_MAX',URLACTION_INFODELIVERY_MAX);
    AddConstant('URLACTION_CHANNEL_SOFTDIST_MIN',URLACTION_CHANNEL_SOFTDIST_MIN);
    AddConstant('URLACTION_CHANNEL_SOFTDIST_PERMISSIONS',URLACTION_CHANNEL_SOFTDIST_PERMISSIONS);
    AddConstant('URLPOLICY_CHANNEL_SOFTDIST_PROHIBIT',URLPOLICY_CHANNEL_SOFTDIST_PROHIBIT);
    AddConstant('URLPOLICY_CHANNEL_SOFTDIST_PRECACHE',URLPOLICY_CHANNEL_SOFTDIST_PRECACHE);
    AddConstant('URLPOLICY_CHANNEL_SOFTDIST_AUTOINSTALL',URLPOLICY_CHANNEL_SOFTDIST_AUTOINSTALL);
    AddConstant('URLACTION_CHANNEL_SOFTDIST_MAX',URLACTION_CHANNEL_SOFTDIST_MAX);
    AddConstant('URLPOLICY_ALLOW',URLPOLICY_ALLOW);
    AddConstant('URLPOLICY_QUERY',URLPOLICY_QUERY);
    AddConstant('URLPOLICY_DISALLOW',URLPOLICY_DISALLOW);
    AddConstant('URLPOLICY_NOTIFY_ON_ALLOW',URLPOLICY_NOTIFY_ON_ALLOW);
    AddConstant('URLPOLICY_NOTIFY_ON_DISALLOW',URLPOLICY_NOTIFY_ON_DISALLOW);
    AddConstant('URLPOLICY_LOG_ON_ALLOW',URLPOLICY_LOG_ON_ALLOW);
    AddConstant('URLPOLICY_LOG_ON_DISALLOW',URLPOLICY_LOG_ON_DISALLOW);
    AddConstant('URLPOLICY_MASK_PERMISSIONS',URLPOLICY_MASK_PERMISSIONS);
    AddConstant('URLZONE_PREDEFINED_MIN',URLZONE_PREDEFINED_MIN);
    AddConstant('URLZONE_LOCAL_MACHINE',URLZONE_LOCAL_MACHINE);
    AddConstant('URLZONE_INTRANET',URLZONE_INTRANET);
    AddConstant('URLZONE_TRUSTED',URLZONE_TRUSTED);
    AddConstant('URLZONE_INTERNET',URLZONE_INTERNET);
    AddConstant('URLZONE_UNTRUSTED',URLZONE_UNTRUSTED);
    AddConstant('URLZONE_PREDEFINED_MAX',URLZONE_PREDEFINED_MAX);
    AddConstant('URLZONE_USER_MIN',URLZONE_USER_MIN);
    AddConstant('URLZONE_USER_MAX',URLZONE_USER_MAX);
    AddConstant('URLTEMPLATE_CUSTOM',URLTEMPLATE_CUSTOM);
    AddConstant('URLTEMPLATE_PREDEFINED_MIN',URLTEMPLATE_PREDEFINED_MIN);
    AddConstant('URLTEMPLATE_LOW',URLTEMPLATE_LOW);
    AddConstant('URLTEMPLATE_MEDIUM',URLTEMPLATE_MEDIUM);
    AddConstant('URLTEMPLATE_HIGH',URLTEMPLATE_HIGH);
    AddConstant('URLTEMPLATE_PREDEFINED_MAX',URLTEMPLATE_PREDEFINED_MAX);
    AddConstant('MAX_ZONE_PATH',MAX_ZONE_PATH);
    AddConstant('MAX_ZONE_DESCRIPTION',MAX_ZONE_DESCRIPTION);
    AddConstant('ZAFLAGS_CUSTOM_EDIT',ZAFLAGS_CUSTOM_EDIT);
    AddConstant('ZAFLAGS_ADD_SITES',ZAFLAGS_ADD_SITES);
    AddConstant('ZAFLAGS_REQUIRE_VERIFICATION',ZAFLAGS_REQUIRE_VERIFICATION);
    AddConstant('ZAFLAGS_INCLUDE_PROXY_OVERRIDE',ZAFLAGS_INCLUDE_PROXY_OVERRIDE);
    AddConstant('ZAFLAGS_INCLUDE_INTRANET_SITES',ZAFLAGS_INCLUDE_INTRANET_SITES);
    AddConstant('ZAFLAGS_NO_UI',ZAFLAGS_NO_UI);
    AddConstant('ZAFLAGS_SUPPORTS_VERIFICATION',ZAFLAGS_SUPPORTS_VERIFICATION);
    AddConstant('ZAFLAGS_UNC_AS_INTRANET',ZAFLAGS_UNC_AS_INTRANET);
    AddConstant('URLZONEREG_DEFAULT',URLZONEREG_DEFAULT);
    AddConstant('URLZONEREG_HKLM',URLZONEREG_HKLM);
    AddConstant('URLZONEREG_HKCU',URLZONEREG_HKCU);
    AddConstant('SOFTDIST_FLAG_USAGE_EMAIL',SOFTDIST_FLAG_USAGE_EMAIL);
    AddConstant('SOFTDIST_FLAG_USAGE_PRECACHE',SOFTDIST_FLAG_USAGE_PRECACHE);
    AddConstant('SOFTDIST_FLAG_USAGE_AUTOINSTALL',SOFTDIST_FLAG_USAGE_AUTOINSTALL);
    AddConstant('SOFTDIST_FLAG_DELETE_SUBSCRIPTION',SOFTDIST_FLAG_DELETE_SUBSCRIPTION);
    AddConstant('SOFTDIST_ADSTATE_NONE',SOFTDIST_ADSTATE_NONE);
    AddConstant('SOFTDIST_ADSTATE_AVAILABLE',SOFTDIST_ADSTATE_AVAILABLE);
    AddConstant('SOFTDIST_ADSTATE_DOWNLOADED',SOFTDIST_ADSTATE_DOWNLOADED);
    AddConstant('SOFTDIST_ADSTATE_INSTALLED',SOFTDIST_ADSTATE_INSTALLED);
  end;
end;

class function TatUrlMonLibrary.LibraryName: string;
begin
  result := 'UrlMon';
end;

initialization
  RegisterScripterLibrary(TatUrlMonLibrary, True);

{$WARNINGS ON}

end.

