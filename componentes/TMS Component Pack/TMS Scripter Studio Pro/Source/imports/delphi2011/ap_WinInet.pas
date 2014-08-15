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
unit ap_WinInet;

interface

uses
  Windows,
  WinInet,
  Variants,
  ap_Windows,
  atScript;

{$WARNINGS OFF}

type
  TatWinInetLibrary = class(TatScripterLibrary)
    procedure __InternetTimeFromSystemTime(AMachine: TatVirtualMachine);
    procedure __InternetCrackUrl(AMachine: TatVirtualMachine);
    procedure __InternetCrackUrlA(AMachine: TatVirtualMachine);
    procedure __InternetCrackUrlW(AMachine: TatVirtualMachine);
    procedure __InternetCreateUrl(AMachine: TatVirtualMachine);
    procedure __InternetCreateUrlA(AMachine: TatVirtualMachine);
    procedure __InternetCreateUrlW(AMachine: TatVirtualMachine);
    procedure __InternetCanonicalizeUrl(AMachine: TatVirtualMachine);
    procedure __InternetCanonicalizeUrlA(AMachine: TatVirtualMachine);
    procedure __InternetCanonicalizeUrlW(AMachine: TatVirtualMachine);
    procedure __InternetCombineUrl(AMachine: TatVirtualMachine);
    procedure __InternetCombineUrlA(AMachine: TatVirtualMachine);
    procedure __InternetCombineUrlW(AMachine: TatVirtualMachine);
    procedure __InternetUnlockRequestFile(AMachine: TatVirtualMachine);
    procedure __InternetGetLastResponseInfo(AMachine: TatVirtualMachine);
    procedure __InternetGetLastResponseInfoA(AMachine: TatVirtualMachine);
    procedure __InternetGetLastResponseInfoW(AMachine: TatVirtualMachine);
    procedure __IS_GOPHER_FILE(AMachine: TatVirtualMachine);
    procedure __IS_GOPHER_DIRECTORY(AMachine: TatVirtualMachine);
    procedure __IS_GOPHER_PHONE_SERVER(AMachine: TatVirtualMachine);
    procedure __IS_GOPHER_ERROR(AMachine: TatVirtualMachine);
    procedure __IS_GOPHER_INDEX_SERVER(AMachine: TatVirtualMachine);
    procedure __IS_GOPHER_TELNET_SESSION(AMachine: TatVirtualMachine);
    procedure __IS_GOPHER_BACKUP_SERVER(AMachine: TatVirtualMachine);
    procedure __IS_GOPHER_TN3270_SESSION(AMachine: TatVirtualMachine);
    procedure __IS_GOPHER_ASK(AMachine: TatVirtualMachine);
    procedure __IS_GOPHER_PLUS(AMachine: TatVirtualMachine);
    procedure __IS_GOPHER_TYPE_KNOWN(AMachine: TatVirtualMachine);
    procedure __GopherCreateLocator(AMachine: TatVirtualMachine);
    procedure __GopherCreateLocatorA(AMachine: TatVirtualMachine);
    procedure __GopherCreateLocatorW(AMachine: TatVirtualMachine);
    procedure __GopherGetLocatorType(AMachine: TatVirtualMachine);
    procedure __GopherGetLocatorTypeA(AMachine: TatVirtualMachine);
    procedure __GopherGetLocatorTypeW(AMachine: TatVirtualMachine);
    procedure __InternetSetCookie(AMachine: TatVirtualMachine);
    procedure __InternetSetCookieA(AMachine: TatVirtualMachine);
    procedure __InternetSetCookieW(AMachine: TatVirtualMachine);
    procedure __InternetGetCookie(AMachine: TatVirtualMachine);
    procedure __InternetGetCookieA(AMachine: TatVirtualMachine);
    procedure __InternetGetCookieW(AMachine: TatVirtualMachine);
    procedure __InternetAttemptConnect(AMachine: TatVirtualMachine);
    procedure __InternetCheckConnection(AMachine: TatVirtualMachine);
    procedure __InternetCheckConnectionA(AMachine: TatVirtualMachine);
    procedure __InternetCheckConnectionW(AMachine: TatVirtualMachine);
    procedure __InternetConfirmZoneCrossing(AMachine: TatVirtualMachine);
    procedure __CreateUrlCacheEntry(AMachine: TatVirtualMachine);
    procedure __CreateUrlCacheEntryA(AMachine: TatVirtualMachine);
    procedure __CreateUrlCacheEntryW(AMachine: TatVirtualMachine);
    procedure __RetrieveUrlCacheEntryFile(AMachine: TatVirtualMachine);
    procedure __RetrieveUrlCacheEntryFileA(AMachine: TatVirtualMachine);
    procedure __RetrieveUrlCacheEntryFileW(AMachine: TatVirtualMachine);
    procedure __UnlockUrlCacheEntryFile(AMachine: TatVirtualMachine);
    procedure __UnlockUrlCacheEntryFileA(AMachine: TatVirtualMachine);
    procedure __UnlockUrlCacheEntryFileW(AMachine: TatVirtualMachine);
    procedure __RetrieveUrlCacheEntryStream(AMachine: TatVirtualMachine);
    procedure __RetrieveUrlCacheEntryStreamA(AMachine: TatVirtualMachine);
    procedure __RetrieveUrlCacheEntryStreamW(AMachine: TatVirtualMachine);
    procedure __UnlockUrlCacheEntryStream(AMachine: TatVirtualMachine);
    procedure __GetUrlCacheEntryInfo(AMachine: TatVirtualMachine);
    procedure __GetUrlCacheEntryInfoA(AMachine: TatVirtualMachine);
    procedure __GetUrlCacheEntryInfoW(AMachine: TatVirtualMachine);
    procedure __SetUrlCacheEntryInfo(AMachine: TatVirtualMachine);
    procedure __SetUrlCacheEntryInfoA(AMachine: TatVirtualMachine);
    procedure __SetUrlCacheEntryInfoW(AMachine: TatVirtualMachine);
    procedure __FindFirstUrlCacheEntry(AMachine: TatVirtualMachine);
    procedure __FindFirstUrlCacheEntryA(AMachine: TatVirtualMachine);
    procedure __FindFirstUrlCacheEntryW(AMachine: TatVirtualMachine);
    procedure __FindNextUrlCacheEntry(AMachine: TatVirtualMachine);
    procedure __FindNextUrlCacheEntryA(AMachine: TatVirtualMachine);
    procedure __FindNextUrlCacheEntryW(AMachine: TatVirtualMachine);
    procedure __FindCloseUrlCache(AMachine: TatVirtualMachine);
    procedure __DeleteUrlCacheEntry(AMachine: TatVirtualMachine);
    procedure __DeleteUrlCacheEntryA(AMachine: TatVirtualMachine);
    procedure __DeleteUrlCacheEntryW(AMachine: TatVirtualMachine);
    procedure __InternetHangUp(AMachine: TatVirtualMachine);
    procedure __InternetGoOnline(AMachine: TatVirtualMachine);
    procedure __InternetAutodial(AMachine: TatVirtualMachine);
    procedure __InternetAutodialHangup(AMachine: TatVirtualMachine);
    procedure __InternetSetDialState(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TInternetAsyncResultWrapper = class(TatRecordWrapper)
  private
    FdwResult: DWORD;
    FdwError: DWORD;
  public
    constructor Create(ARecord: TInternetAsyncResult);
    function ObjToRec: TInternetAsyncResult;
  published
    property dwResult: DWORD read FdwResult write FdwResult;
    property dwError: DWORD read FdwError write FdwError;
  end;
  
  TInternetPrefetchStatusWrapper = class(TatRecordWrapper)
  private
    FdwStatus: DWORD;
    FdwSize: DWORD;
  public
    constructor Create(ARecord: TInternetPrefetchStatus);
    function ObjToRec: TInternetPrefetchStatus;
  published
    property dwStatus: DWORD read FdwStatus write FdwStatus;
    property dwSize: DWORD read FdwSize write FdwSize;
  end;
  
  INTERNET_PROXY_INFOWrapper = class(TatRecordWrapper)
  private
    FdwAccessType: DWORD;
  public
    constructor Create(ARecord: INTERNET_PROXY_INFO);
    function ObjToRec: INTERNET_PROXY_INFO;
  published
    property dwAccessType: DWORD read FdwAccessType write FdwAccessType;
  end;
  
  INTERNET_VERSION_INFOWrapper = class(TatRecordWrapper)
  private
    FdwMajorVersion: DWORD;
    FdwMinorVersion: DWORD;
  public
    constructor Create(ARecord: INTERNET_VERSION_INFO);
    function ObjToRec: INTERNET_VERSION_INFO;
  published
    property dwMajorVersion: DWORD read FdwMajorVersion write FdwMajorVersion;
    property dwMinorVersion: DWORD read FdwMinorVersion write FdwMinorVersion;
  end;
  
  HTTP_VERSION_INFOWrapper = class(TatRecordWrapper)
  private
    FdwMajorVersion: DWORD;
    FdwMinorVersion: DWORD;
  public
    constructor Create(ARecord: HTTP_VERSION_INFO);
    function ObjToRec: HTTP_VERSION_INFO;
  published
    property dwMajorVersion: DWORD read FdwMajorVersion write FdwMajorVersion;
    property dwMinorVersion: DWORD read FdwMinorVersion write FdwMinorVersion;
  end;
  
  INTERNET_CONNECTED_INFOWrapper = class(TatRecordWrapper)
  private
    FdwConnectedState: DWORD;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: INTERNET_CONNECTED_INFO);
    function ObjToRec: INTERNET_CONNECTED_INFO;
  published
    property dwConnectedState: DWORD read FdwConnectedState write FdwConnectedState;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  URL_COMPONENTSWrapper = class(TatRecordWrapper)
  private
    FdwStructSize: DWORD;
    FdwSchemeLength: DWORD;
    FnScheme: TInternetScheme;
    FdwHostNameLength: DWORD;
    FnPort: INTERNET_PORT;
    Fpad: WORD;
    FdwUserNameLength: DWORD;
    FdwPasswordLength: DWORD;
    FdwUrlPathLength: DWORD;
    FdwExtraInfoLength: DWORD;
  public
    constructor Create(ARecord: URL_COMPONENTS);
    function ObjToRec: URL_COMPONENTS;
  published
    property dwStructSize: DWORD read FdwStructSize write FdwStructSize;
    property dwSchemeLength: DWORD read FdwSchemeLength write FdwSchemeLength;
    property nScheme: TInternetScheme read FnScheme write FnScheme;
    property dwHostNameLength: DWORD read FdwHostNameLength write FdwHostNameLength;
    property nPort: INTERNET_PORT read FnPort write FnPort;
    property pad: WORD read Fpad write Fpad;
    property dwUserNameLength: DWORD read FdwUserNameLength write FdwUserNameLength;
    property dwPasswordLength: DWORD read FdwPasswordLength write FdwPasswordLength;
    property dwUrlPathLength: DWORD read FdwUrlPathLength write FdwUrlPathLength;
    property dwExtraInfoLength: DWORD read FdwExtraInfoLength write FdwExtraInfoLength;
  end;
  
  INTERNET_CERTIFICATE_INFOWrapper = class(TatRecordWrapper)
  private
    FdwKeySize: DWORD;
  public
    constructor Create(ARecord: INTERNET_CERTIFICATE_INFO);
    function ObjToRec: INTERNET_CERTIFICATE_INFO;
  published
    property dwKeySize: DWORD read FdwKeySize write FdwKeySize;
  end;
  
  INTERNET_BUFFERSAWrapper = class(TatRecordWrapper)
  private
    FdwStructSize: DWORD;
    FdwHeadersLength: DWORD;
    FdwHeadersTotal: DWORD;
    FdwBufferLength: DWORD;
    FdwBufferTotal: DWORD;
    FdwOffsetLow: DWORD;
    FdwOffsetHigh: DWORD;
  public
    constructor Create(ARecord: INTERNET_BUFFERSA);
    function ObjToRec: INTERNET_BUFFERSA;
  published
    property dwStructSize: DWORD read FdwStructSize write FdwStructSize;
    property dwHeadersLength: DWORD read FdwHeadersLength write FdwHeadersLength;
    property dwHeadersTotal: DWORD read FdwHeadersTotal write FdwHeadersTotal;
    property dwBufferLength: DWORD read FdwBufferLength write FdwBufferLength;
    property dwBufferTotal: DWORD read FdwBufferTotal write FdwBufferTotal;
    property dwOffsetLow: DWORD read FdwOffsetLow write FdwOffsetLow;
    property dwOffsetHigh: DWORD read FdwOffsetHigh write FdwOffsetHigh;
  end;
  
  INTERNET_BUFFERSWWrapper = class(TatRecordWrapper)
  private
    FdwStructSize: DWORD;
    FdwHeadersLength: DWORD;
    FdwHeadersTotal: DWORD;
    FdwBufferLength: DWORD;
    FdwBufferTotal: DWORD;
    FdwOffsetLow: DWORD;
    FdwOffsetHigh: DWORD;
  public
    constructor Create(ARecord: INTERNET_BUFFERSW);
    function ObjToRec: INTERNET_BUFFERSW;
  published
    property dwStructSize: DWORD read FdwStructSize write FdwStructSize;
    property dwHeadersLength: DWORD read FdwHeadersLength write FdwHeadersLength;
    property dwHeadersTotal: DWORD read FdwHeadersTotal write FdwHeadersTotal;
    property dwBufferLength: DWORD read FdwBufferLength write FdwBufferLength;
    property dwBufferTotal: DWORD read FdwBufferTotal write FdwBufferTotal;
    property dwOffsetLow: DWORD read FdwOffsetLow write FdwOffsetLow;
    property dwOffsetHigh: DWORD read FdwOffsetHigh write FdwOffsetHigh;
  end;
  
  GOPHER_FIND_DATAAWrapper = class(TatRecordWrapper)
  private
    FGopherType: DWORD;
    FSizeLow: DWORD;
    FSizeHigh: DWORD;
  public
    constructor Create(ARecord: GOPHER_FIND_DATAA);
    function ObjToRec: GOPHER_FIND_DATAA;
  published
    property GopherType: DWORD read FGopherType write FGopherType;
    property SizeLow: DWORD read FSizeLow write FSizeLow;
    property SizeHigh: DWORD read FSizeHigh write FSizeHigh;
  end;
  
  GOPHER_FIND_DATAWWrapper = class(TatRecordWrapper)
  private
    FGopherType: DWORD;
    FSizeLow: DWORD;
    FSizeHigh: DWORD;
  public
    constructor Create(ARecord: GOPHER_FIND_DATAW);
    function ObjToRec: GOPHER_FIND_DATAW;
  published
    property GopherType: DWORD read FGopherType write FGopherType;
    property SizeLow: DWORD read FSizeLow write FSizeLow;
    property SizeHigh: DWORD read FSizeHigh write FSizeHigh;
  end;
  
  GOPHER_ADMIN_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: GOPHER_ADMIN_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_ADMIN_ATTRIBUTE_TYPE;
  published
  end;
  
  GOPHER_MOD_DATE_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: GOPHER_MOD_DATE_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_MOD_DATE_ATTRIBUTE_TYPE;
  published
  end;
  
  GOPHER_TTL_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
    FTtl: DWORD;
  public
    constructor Create(ARecord: GOPHER_TTL_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_TTL_ATTRIBUTE_TYPE;
  published
    property Ttl: DWORD read FTtl write FTtl;
  end;
  
  GOPHER_SCORE_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
    FScore: Integer;
  public
    constructor Create(ARecord: GOPHER_SCORE_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_SCORE_ATTRIBUTE_TYPE;
  published
    property Score: Integer read FScore write FScore;
  end;
  
  GOPHER_SCORE_RANGE_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
    FLowerBound: Integer;
    FUpperBound: Integer;
  public
    constructor Create(ARecord: GOPHER_SCORE_RANGE_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_SCORE_RANGE_ATTRIBUTE_TYPE;
  published
    property LowerBound: Integer read FLowerBound write FLowerBound;
    property UpperBound: Integer read FUpperBound write FUpperBound;
  end;
  
  GOPHER_SITE_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: GOPHER_SITE_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_SITE_ATTRIBUTE_TYPE;
  published
  end;
  
  GOPHER_ORGANIZATION_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: GOPHER_ORGANIZATION_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_ORGANIZATION_ATTRIBUTE_TYPE;
  published
  end;
  
  GOPHER_LOCATION_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: GOPHER_LOCATION_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_LOCATION_ATTRIBUTE_TYPE;
  published
  end;
  
  GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
    FDegreesNorth: Integer;
    FMinutesNorth: Integer;
    FSecondsNorth: Integer;
    FDegreesEast: Integer;
    FMinutesEast: Integer;
    FSecondsEast: Integer;
  public
    constructor Create(ARecord: GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE;
  published
    property DegreesNorth: Integer read FDegreesNorth write FDegreesNorth;
    property MinutesNorth: Integer read FMinutesNorth write FMinutesNorth;
    property SecondsNorth: Integer read FSecondsNorth write FSecondsNorth;
    property DegreesEast: Integer read FDegreesEast write FDegreesEast;
    property MinutesEast: Integer read FMinutesEast write FMinutesEast;
    property SecondsEast: Integer read FSecondsEast write FSecondsEast;
  end;
  
  GOPHER_TIMEZONE_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
    FZone: Integer;
  public
    constructor Create(ARecord: GOPHER_TIMEZONE_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_TIMEZONE_ATTRIBUTE_TYPE;
  published
    property Zone: Integer read FZone write FZone;
  end;
  
  GOPHER_PROVIDER_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: GOPHER_PROVIDER_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_PROVIDER_ATTRIBUTE_TYPE;
  published
  end;
  
  GOPHER_VERSION_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: GOPHER_VERSION_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_VERSION_ATTRIBUTE_TYPE;
  published
  end;
  
  GOPHER_ABSTRACT_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: GOPHER_ABSTRACT_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_ABSTRACT_ATTRIBUTE_TYPE;
  published
  end;
  
  GOPHER_VIEW_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
    FSize: DWORD;
  public
    constructor Create(ARecord: GOPHER_VIEW_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_VIEW_ATTRIBUTE_TYPE;
  published
    property Size: DWORD read FSize write FSize;
  end;
  
  GOPHER_VERONICA_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
    FTreeWalk: BOOL;
  public
    constructor Create(ARecord: GOPHER_VERONICA_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_VERONICA_ATTRIBUTE_TYPE;
  published
    property TreeWalk: BOOL read FTreeWalk write FTreeWalk;
  end;
  
  GOPHER_ASK_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: GOPHER_ASK_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_ASK_ATTRIBUTE_TYPE;
  published
  end;
  
  GOPHER_UNKNOWN_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: GOPHER_UNKNOWN_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_UNKNOWN_ATTRIBUTE_TYPE;
  published
  end;
  
  GOPHER_ATTRIBUTE_TYPEWrapper = class(TatRecordWrapper)
  private
    FCategoryId: DWORD;
    FAttributeId: DWORD;
  public
    constructor Create(ARecord: GOPHER_ATTRIBUTE_TYPE);
    function ObjToRec: GOPHER_ATTRIBUTE_TYPE;
  published
    property CategoryId: DWORD read FCategoryId write FCategoryId;
    property AttributeId: DWORD read FAttributeId write FAttributeId;
  end;

  INTERNET_CACHE_ENTRY_INFOAWrapper = class(TatRecordWrapper)
  private
    FdwStructSize: DWORD;
    FCacheEntryType: DWORD;
    FdwUseCount: DWORD;
    FdwHitRate: DWORD;
    FdwSizeLow: DWORD;
    FdwSizeHigh: DWORD;
    FdwHeaderInfoSize: DWORD;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: INTERNET_CACHE_ENTRY_INFOA);
    function ObjToRec: INTERNET_CACHE_ENTRY_INFOA;
  published
    property dwStructSize: DWORD read FdwStructSize write FdwStructSize;
    property CacheEntryType: DWORD read FCacheEntryType write FCacheEntryType;
    property dwUseCount: DWORD read FdwUseCount write FdwUseCount;
    property dwHitRate: DWORD read FdwHitRate write FdwHitRate;
    property dwSizeLow: DWORD read FdwSizeLow write FdwSizeLow;
    property dwSizeHigh: DWORD read FdwSizeHigh write FdwSizeHigh;
    property dwHeaderInfoSize: DWORD read FdwHeaderInfoSize write FdwHeaderInfoSize;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  INTERNET_CACHE_ENTRY_INFOWWrapper = class(TatRecordWrapper)
  private
    FdwStructSize: DWORD;
    FCacheEntryType: DWORD;
    FdwUseCount: DWORD;
    FdwHitRate: DWORD;
    FdwSizeLow: DWORD;
    FdwSizeHigh: DWORD;
    FdwHeaderInfoSize: DWORD;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: INTERNET_CACHE_ENTRY_INFOW);
    function ObjToRec: INTERNET_CACHE_ENTRY_INFOW;
  published
    property dwStructSize: DWORD read FdwStructSize write FdwStructSize;
    property CacheEntryType: DWORD read FCacheEntryType write FCacheEntryType;
    property dwUseCount: DWORD read FdwUseCount write FdwUseCount;
    property dwHitRate: DWORD read FdwHitRate write FdwHitRate;
    property dwSizeLow: DWORD read FdwSizeLow write FdwSizeLow;
    property dwSizeHigh: DWORD read FdwSizeHigh write FdwSizeHigh;
    property dwHeaderInfoSize: DWORD read FdwHeaderInfoSize write FdwHeaderInfoSize;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  INTERNET_CACHE_GROUP_INFOAWrapper = class(TatRecordWrapper)
  private
    FdwGroupSize: DWORD;
    FdwGroupFlags: DWORD;
    FdwGroupType: DWORD;
    FdwDiskUsage: DWORD;
    FdwDiskQuota: DWORD;
  public
    constructor Create(ARecord: INTERNET_CACHE_GROUP_INFOA);
    function ObjToRec: INTERNET_CACHE_GROUP_INFOA;
  published
    property dwGroupSize: DWORD read FdwGroupSize write FdwGroupSize;
    property dwGroupFlags: DWORD read FdwGroupFlags write FdwGroupFlags;
    property dwGroupType: DWORD read FdwGroupType write FdwGroupType;
    property dwDiskUsage: DWORD read FdwDiskUsage write FdwDiskUsage;
    property dwDiskQuota: DWORD read FdwDiskQuota write FdwDiskQuota;
  end;
  
  INTERNET_CACHE_GROUP_INFOWWrapper = class(TatRecordWrapper)
  private
    FdwGroupSize: DWORD;
    FdwGroupFlags: DWORD;
    FdwGroupType: DWORD;
    FdwDiskUsage: DWORD;
    FdwDiskQuota: DWORD;
  public
    constructor Create(ARecord: INTERNET_CACHE_GROUP_INFOW);
    function ObjToRec: INTERNET_CACHE_GROUP_INFOW;
  published
    property dwGroupSize: DWORD read FdwGroupSize write FdwGroupSize;
    property dwGroupFlags: DWORD read FdwGroupFlags write FdwGroupFlags;
    property dwGroupType: DWORD read FdwGroupType write FdwGroupType;
    property dwDiskUsage: DWORD read FdwDiskUsage write FdwDiskUsage;
    property dwDiskQuota: DWORD read FdwDiskQuota write FdwDiskQuota;
  end;
  

implementation

constructor TInternetAsyncResultWrapper.Create(ARecord: TInternetAsyncResult);
begin
  inherited Create;
  FdwResult := ARecord.dwResult;
  FdwError := ARecord.dwError;
end;

function TInternetAsyncResultWrapper.ObjToRec: TInternetAsyncResult;
begin
  result.dwResult := FdwResult;
  result.dwError := FdwError;
end;

constructor TInternetPrefetchStatusWrapper.Create(ARecord: TInternetPrefetchStatus);
begin
  inherited Create;
  FdwStatus := ARecord.dwStatus;
  FdwSize := ARecord.dwSize;
end;

function TInternetPrefetchStatusWrapper.ObjToRec: TInternetPrefetchStatus;
begin
  result.dwStatus := FdwStatus;
  result.dwSize := FdwSize;
end;

constructor INTERNET_PROXY_INFOWrapper.Create(ARecord: INTERNET_PROXY_INFO);
begin
  inherited Create;
  FdwAccessType := ARecord.dwAccessType;
end;

function INTERNET_PROXY_INFOWrapper.ObjToRec: INTERNET_PROXY_INFO;
begin
  result.dwAccessType := FdwAccessType;
end;

constructor INTERNET_VERSION_INFOWrapper.Create(ARecord: INTERNET_VERSION_INFO);
begin
  inherited Create;
  FdwMajorVersion := ARecord.dwMajorVersion;
  FdwMinorVersion := ARecord.dwMinorVersion;
end;

function INTERNET_VERSION_INFOWrapper.ObjToRec: INTERNET_VERSION_INFO;
begin
  result.dwMajorVersion := FdwMajorVersion;
  result.dwMinorVersion := FdwMinorVersion;
end;

constructor HTTP_VERSION_INFOWrapper.Create(ARecord: HTTP_VERSION_INFO);
begin
  inherited Create;
  FdwMajorVersion := ARecord.dwMajorVersion;
  FdwMinorVersion := ARecord.dwMinorVersion;
end;

function HTTP_VERSION_INFOWrapper.ObjToRec: HTTP_VERSION_INFO;
begin
  result.dwMajorVersion := FdwMajorVersion;
  result.dwMinorVersion := FdwMinorVersion;
end;

constructor INTERNET_CONNECTED_INFOWrapper.Create(ARecord: INTERNET_CONNECTED_INFO);
begin
  inherited Create;
  FdwConnectedState := ARecord.dwConnectedState;
  FdwFlags := ARecord.dwFlags;
end;

function INTERNET_CONNECTED_INFOWrapper.ObjToRec: INTERNET_CONNECTED_INFO;
begin
  result.dwConnectedState := FdwConnectedState;
  result.dwFlags := FdwFlags;
end;

constructor URL_COMPONENTSWrapper.Create(ARecord: URL_COMPONENTS);
begin
  inherited Create;
  FdwStructSize := ARecord.dwStructSize;
  FdwSchemeLength := ARecord.dwSchemeLength;
  FnScheme := ARecord.nScheme;
  FdwHostNameLength := ARecord.dwHostNameLength;
  FnPort := ARecord.nPort;
  Fpad := ARecord.pad;
  FdwUserNameLength := ARecord.dwUserNameLength;
  FdwPasswordLength := ARecord.dwPasswordLength;
  FdwUrlPathLength := ARecord.dwUrlPathLength;
  FdwExtraInfoLength := ARecord.dwExtraInfoLength;
end;

function URL_COMPONENTSWrapper.ObjToRec: URL_COMPONENTS;
begin
  result.dwStructSize := FdwStructSize;
  result.dwSchemeLength := FdwSchemeLength;
  result.nScheme := FnScheme;
  result.dwHostNameLength := FdwHostNameLength;
  result.nPort := FnPort;
  result.pad := Fpad;
  result.dwUserNameLength := FdwUserNameLength;
  result.dwPasswordLength := FdwPasswordLength;
  result.dwUrlPathLength := FdwUrlPathLength;
  result.dwExtraInfoLength := FdwExtraInfoLength;
end;

constructor INTERNET_CERTIFICATE_INFOWrapper.Create(ARecord: INTERNET_CERTIFICATE_INFO);
begin
  inherited Create;
  FdwKeySize := ARecord.dwKeySize;
end;

function INTERNET_CERTIFICATE_INFOWrapper.ObjToRec: INTERNET_CERTIFICATE_INFO;
begin
  result.dwKeySize := FdwKeySize;
end;

constructor INTERNET_BUFFERSAWrapper.Create(ARecord: INTERNET_BUFFERSA);
begin
  inherited Create;
  FdwStructSize := ARecord.dwStructSize;
  FdwHeadersLength := ARecord.dwHeadersLength;
  FdwHeadersTotal := ARecord.dwHeadersTotal;
  FdwBufferLength := ARecord.dwBufferLength;
  FdwBufferTotal := ARecord.dwBufferTotal;
  FdwOffsetLow := ARecord.dwOffsetLow;
  FdwOffsetHigh := ARecord.dwOffsetHigh;
end;

function INTERNET_BUFFERSAWrapper.ObjToRec: INTERNET_BUFFERSA;
begin
  result.dwStructSize := FdwStructSize;
  result.dwHeadersLength := FdwHeadersLength;
  result.dwHeadersTotal := FdwHeadersTotal;
  result.dwBufferLength := FdwBufferLength;
  result.dwBufferTotal := FdwBufferTotal;
  result.dwOffsetLow := FdwOffsetLow;
  result.dwOffsetHigh := FdwOffsetHigh;
end;

constructor INTERNET_BUFFERSWWrapper.Create(ARecord: INTERNET_BUFFERSW);
begin
  inherited Create;
  FdwStructSize := ARecord.dwStructSize;
  FdwHeadersLength := ARecord.dwHeadersLength;
  FdwHeadersTotal := ARecord.dwHeadersTotal;
  FdwBufferLength := ARecord.dwBufferLength;
  FdwBufferTotal := ARecord.dwBufferTotal;
  FdwOffsetLow := ARecord.dwOffsetLow;
  FdwOffsetHigh := ARecord.dwOffsetHigh;
end;

function INTERNET_BUFFERSWWrapper.ObjToRec: INTERNET_BUFFERSW;
begin
  result.dwStructSize := FdwStructSize;
  result.dwHeadersLength := FdwHeadersLength;
  result.dwHeadersTotal := FdwHeadersTotal;
  result.dwBufferLength := FdwBufferLength;
  result.dwBufferTotal := FdwBufferTotal;
  result.dwOffsetLow := FdwOffsetLow;
  result.dwOffsetHigh := FdwOffsetHigh;
end;

constructor GOPHER_FIND_DATAAWrapper.Create(ARecord: GOPHER_FIND_DATAA);
begin
  inherited Create;
  FGopherType := ARecord.GopherType;
  FSizeLow := ARecord.SizeLow;
  FSizeHigh := ARecord.SizeHigh;
end;

function GOPHER_FIND_DATAAWrapper.ObjToRec: GOPHER_FIND_DATAA;
begin
  result.GopherType := FGopherType;
  result.SizeLow := FSizeLow;
  result.SizeHigh := FSizeHigh;
end;

constructor GOPHER_FIND_DATAWWrapper.Create(ARecord: GOPHER_FIND_DATAW);
begin
  inherited Create;
  FGopherType := ARecord.GopherType;
  FSizeLow := ARecord.SizeLow;
  FSizeHigh := ARecord.SizeHigh;
end;

function GOPHER_FIND_DATAWWrapper.ObjToRec: GOPHER_FIND_DATAW;
begin
  result.GopherType := FGopherType;
  result.SizeLow := FSizeLow;
  result.SizeHigh := FSizeHigh;
end;

constructor GOPHER_ADMIN_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_ADMIN_ATTRIBUTE_TYPE);
begin
  inherited Create;
end;

function GOPHER_ADMIN_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_ADMIN_ATTRIBUTE_TYPE;
begin
end;

constructor GOPHER_MOD_DATE_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_MOD_DATE_ATTRIBUTE_TYPE);
begin
  inherited Create;
end;

function GOPHER_MOD_DATE_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_MOD_DATE_ATTRIBUTE_TYPE;
begin
end;

constructor GOPHER_TTL_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_TTL_ATTRIBUTE_TYPE);
begin
  inherited Create;
  FTtl := ARecord.Ttl;
end;

function GOPHER_TTL_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_TTL_ATTRIBUTE_TYPE;
begin
  result.Ttl := FTtl;
end;

constructor GOPHER_SCORE_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_SCORE_ATTRIBUTE_TYPE);
begin
  inherited Create;
  FScore := ARecord.Score;
end;

function GOPHER_SCORE_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_SCORE_ATTRIBUTE_TYPE;
begin
  result.Score := FScore;
end;

constructor GOPHER_SCORE_RANGE_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_SCORE_RANGE_ATTRIBUTE_TYPE);
begin
  inherited Create;
  FLowerBound := ARecord.LowerBound;
  FUpperBound := ARecord.UpperBound;
end;

function GOPHER_SCORE_RANGE_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_SCORE_RANGE_ATTRIBUTE_TYPE;
begin
  result.LowerBound := FLowerBound;
  result.UpperBound := FUpperBound;
end;

constructor GOPHER_SITE_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_SITE_ATTRIBUTE_TYPE);
begin
  inherited Create;
end;

function GOPHER_SITE_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_SITE_ATTRIBUTE_TYPE;
begin
end;

constructor GOPHER_ORGANIZATION_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_ORGANIZATION_ATTRIBUTE_TYPE);
begin
  inherited Create;
end;

function GOPHER_ORGANIZATION_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_ORGANIZATION_ATTRIBUTE_TYPE;
begin
end;

constructor GOPHER_LOCATION_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_LOCATION_ATTRIBUTE_TYPE);
begin
  inherited Create;
end;

function GOPHER_LOCATION_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_LOCATION_ATTRIBUTE_TYPE;
begin
end;

constructor GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE);
begin
  inherited Create;
  FDegreesNorth := ARecord.DegreesNorth;
  FMinutesNorth := ARecord.MinutesNorth;
  FSecondsNorth := ARecord.SecondsNorth;
  FDegreesEast := ARecord.DegreesEast;
  FMinutesEast := ARecord.MinutesEast;
  FSecondsEast := ARecord.SecondsEast;
end;

function GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE;
begin
  result.DegreesNorth := FDegreesNorth;
  result.MinutesNorth := FMinutesNorth;
  result.SecondsNorth := FSecondsNorth;
  result.DegreesEast := FDegreesEast;
  result.MinutesEast := FMinutesEast;
  result.SecondsEast := FSecondsEast;
end;

constructor GOPHER_TIMEZONE_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_TIMEZONE_ATTRIBUTE_TYPE);
begin
  inherited Create;
  FZone := ARecord.Zone;
end;

function GOPHER_TIMEZONE_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_TIMEZONE_ATTRIBUTE_TYPE;
begin
  result.Zone := FZone;
end;

constructor GOPHER_PROVIDER_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_PROVIDER_ATTRIBUTE_TYPE);
begin
  inherited Create;
end;

function GOPHER_PROVIDER_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_PROVIDER_ATTRIBUTE_TYPE;
begin
end;

constructor GOPHER_VERSION_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_VERSION_ATTRIBUTE_TYPE);
begin
  inherited Create;
end;

function GOPHER_VERSION_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_VERSION_ATTRIBUTE_TYPE;
begin
end;

constructor GOPHER_ABSTRACT_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_ABSTRACT_ATTRIBUTE_TYPE);
begin
  inherited Create;
end;

function GOPHER_ABSTRACT_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_ABSTRACT_ATTRIBUTE_TYPE;
begin
end;

constructor GOPHER_VIEW_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_VIEW_ATTRIBUTE_TYPE);
begin
  inherited Create;
  FSize := ARecord.Size;
end;

function GOPHER_VIEW_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_VIEW_ATTRIBUTE_TYPE;
begin
  result.Size := FSize;
end;

constructor GOPHER_VERONICA_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_VERONICA_ATTRIBUTE_TYPE);
begin
  inherited Create;
  FTreeWalk := ARecord.TreeWalk;
end;

function GOPHER_VERONICA_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_VERONICA_ATTRIBUTE_TYPE;
begin
  result.TreeWalk := FTreeWalk;
end;

constructor GOPHER_ASK_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_ASK_ATTRIBUTE_TYPE);
begin
  inherited Create;
end;

function GOPHER_ASK_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_ASK_ATTRIBUTE_TYPE;
begin
end;

constructor GOPHER_UNKNOWN_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_UNKNOWN_ATTRIBUTE_TYPE);
begin
  inherited Create;
end;

function GOPHER_UNKNOWN_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_UNKNOWN_ATTRIBUTE_TYPE;
begin
end;

constructor GOPHER_ATTRIBUTE_TYPEWrapper.Create(ARecord: GOPHER_ATTRIBUTE_TYPE);
begin
  inherited Create;
  FCategoryId := ARecord.CategoryId;
  FAttributeId := ARecord.AttributeId;
end;

function GOPHER_ATTRIBUTE_TYPEWrapper.ObjToRec: GOPHER_ATTRIBUTE_TYPE;
begin
  result.CategoryId := FCategoryId;
  result.AttributeId := FAttributeId;
end;

constructor INTERNET_CACHE_ENTRY_INFOAWrapper.Create(ARecord: INTERNET_CACHE_ENTRY_INFOA);
begin
  inherited Create;
  FdwStructSize := ARecord.dwStructSize;
  FCacheEntryType := ARecord.CacheEntryType;
  FdwUseCount := ARecord.dwUseCount;
  FdwHitRate := ARecord.dwHitRate;
  FdwSizeLow := ARecord.dwSizeLow;
  FdwSizeHigh := ARecord.dwSizeHigh;
  FdwHeaderInfoSize := ARecord.dwHeaderInfoSize;
  FdwReserved := ARecord.dwReserved;
end;

function INTERNET_CACHE_ENTRY_INFOAWrapper.ObjToRec: INTERNET_CACHE_ENTRY_INFOA;
begin
  result.dwStructSize := FdwStructSize;
  result.CacheEntryType := FCacheEntryType;
  result.dwUseCount := FdwUseCount;
  result.dwHitRate := FdwHitRate;
  result.dwSizeLow := FdwSizeLow;
  result.dwSizeHigh := FdwSizeHigh;
  result.dwHeaderInfoSize := FdwHeaderInfoSize;
  result.dwReserved := FdwReserved;
end;

constructor INTERNET_CACHE_ENTRY_INFOWWrapper.Create(ARecord: INTERNET_CACHE_ENTRY_INFOW);
begin
  inherited Create;
  FdwStructSize := ARecord.dwStructSize;
  FCacheEntryType := ARecord.CacheEntryType;
  FdwUseCount := ARecord.dwUseCount;
  FdwHitRate := ARecord.dwHitRate;
  FdwSizeLow := ARecord.dwSizeLow;
  FdwSizeHigh := ARecord.dwSizeHigh;
  FdwHeaderInfoSize := ARecord.dwHeaderInfoSize;
  FdwReserved := ARecord.dwReserved;
end;

function INTERNET_CACHE_ENTRY_INFOWWrapper.ObjToRec: INTERNET_CACHE_ENTRY_INFOW;
begin
  result.dwStructSize := FdwStructSize;
  result.CacheEntryType := FCacheEntryType;
  result.dwUseCount := FdwUseCount;
  result.dwHitRate := FdwHitRate;
  result.dwSizeLow := FdwSizeLow;
  result.dwSizeHigh := FdwSizeHigh;
  result.dwHeaderInfoSize := FdwHeaderInfoSize;
  result.dwReserved := FdwReserved;
end;

constructor INTERNET_CACHE_GROUP_INFOAWrapper.Create(ARecord: INTERNET_CACHE_GROUP_INFOA);
begin
  inherited Create;
  FdwGroupSize := ARecord.dwGroupSize;
  FdwGroupFlags := ARecord.dwGroupFlags;
  FdwGroupType := ARecord.dwGroupType;
  FdwDiskUsage := ARecord.dwDiskUsage;
  FdwDiskQuota := ARecord.dwDiskQuota;
end;

function INTERNET_CACHE_GROUP_INFOAWrapper.ObjToRec: INTERNET_CACHE_GROUP_INFOA;
begin
  result.dwGroupSize := FdwGroupSize;
  result.dwGroupFlags := FdwGroupFlags;
  result.dwGroupType := FdwGroupType;
  result.dwDiskUsage := FdwDiskUsage;
  result.dwDiskQuota := FdwDiskQuota;
end;

constructor INTERNET_CACHE_GROUP_INFOWWrapper.Create(ARecord: INTERNET_CACHE_GROUP_INFOW);
begin
  inherited Create;
  FdwGroupSize := ARecord.dwGroupSize;
  FdwGroupFlags := ARecord.dwGroupFlags;
  FdwGroupType := ARecord.dwGroupType;
  FdwDiskUsage := ARecord.dwDiskUsage;
  FdwDiskQuota := ARecord.dwDiskQuota;
end;

function INTERNET_CACHE_GROUP_INFOWWrapper.ObjToRec: INTERNET_CACHE_GROUP_INFOW;
begin
  result.dwGroupSize := FdwGroupSize;
  result.dwGroupFlags := FdwGroupFlags;
  result.dwGroupType := FdwGroupType;
  result.dwDiskUsage := FdwDiskUsage;
  result.dwDiskQuota := FdwDiskQuota;
end;



procedure TatWinInetLibrary.__InternetTimeFromSystemTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.InternetTimeFromSystemTime(_SYSTEMTIMEWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetCrackUrl(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3Rec: TObject;
  Param3: TURLComponents;
  AResult: variant;
begin
  with AMachine do
  begin
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is URL_COMPONENTSWrapper) then 
  Param3Rec := URL_COMPONENTSWrapper.Create(Param3);
Param3 := URL_COMPONENTSWrapper(Param3Rec).ObjToRec;
AResult := WinInet.InternetCrackUrl(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,integer(URL_COMPONENTSWrapper.Create(Param3)));
  end;
end;

procedure TatWinInetLibrary.__InternetCrackUrlA(AMachine: TatVirtualMachine);
  var
  Param3Rec: TObject;
  Param3: TURLComponents;
  AResult: variant;
begin
  with AMachine do
  begin
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is URL_COMPONENTSWrapper) then 
  Param3Rec := URL_COMPONENTSWrapper.Create(Param3);
Param3 := URL_COMPONENTSWrapper(Param3Rec).ObjToRec;
AResult := WinInet.InternetCrackUrlA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,integer(URL_COMPONENTSWrapper.Create(Param3)));
  end;
end;

procedure TatWinInetLibrary.__InternetCrackUrlW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3Rec: TObject;
  Param3: TURLComponents;
  AResult: variant;
begin
  with AMachine do
  begin
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is URL_COMPONENTSWrapper) then 
  Param3Rec := URL_COMPONENTSWrapper.Create(Param3);
Param3 := URL_COMPONENTSWrapper(Param3Rec).ObjToRec;
AResult := WinInet.InternetCrackUrlW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,integer(URL_COMPONENTSWrapper.Create(Param3)));
  end;
end;

procedure TatWinInetLibrary.__InternetCreateUrl(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TURLComponents;
  Param2Buf: array[0..127] of WideChar;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is URL_COMPONENTSWrapper) then 
  Param0Rec := URL_COMPONENTSWrapper.Create(Param0);
Param0 := URL_COMPONENTSWrapper(Param0Rec).ObjToRec;
Param3 := VarToInteger(GetInputArg(3));
AResult := WinInet.InternetCreateUrl(Param0,VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(URL_COMPONENTSWrapper.Create(Param0)));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinInetLibrary.__InternetCreateUrlA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TURLComponents;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is URL_COMPONENTSWrapper) then 
  Param0Rec := URL_COMPONENTSWrapper.Create(Param0);
Param0 := URL_COMPONENTSWrapper(Param0Rec).ObjToRec;
Param3 := VarToInteger(GetInputArg(3));
AResult := WinInet.InternetCreateUrlA(Param0,VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(URL_COMPONENTSWrapper.Create(Param0)));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinInetLibrary.__InternetCreateUrlW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TURLComponents;
  Param2Buf: array[0..127] of WideChar;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is URL_COMPONENTSWrapper) then 
  Param0Rec := URL_COMPONENTSWrapper.Create(Param0);
Param0 := URL_COMPONENTSWrapper(Param0Rec).ObjToRec;
Param3 := VarToInteger(GetInputArg(3));
AResult := WinInet.InternetCreateUrlW(Param0,VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(URL_COMPONENTSWrapper.Create(Param0)));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinInetLibrary.__InternetCanonicalizeUrl(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.InternetCanonicalizeUrl(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2,VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__InternetCanonicalizeUrlA(AMachine: TatVirtualMachine);
  var
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.InternetCanonicalizeUrlA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),Param2,VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__InternetCanonicalizeUrlW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.InternetCanonicalizeUrlW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2,VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__InternetCombineUrl(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := WinInet.InternetCombineUrl(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3,VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinInetLibrary.__InternetCombineUrlA(AMachine: TatVirtualMachine);
  var
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := WinInet.InternetCombineUrlA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),Param3,VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinInetLibrary.__InternetCombineUrlW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := WinInet.InternetCombineUrlW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3,VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinInetLibrary.__InternetUnlockRequestFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.InternetUnlockRequestFile(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetGetLastResponseInfo(AMachine: TatVirtualMachine);
  var
  Param0: DWORD;
  Param1Buf: array[0..127] of WideChar;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.InternetGetLastResponseInfo(Param0,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__InternetGetLastResponseInfoA(AMachine: TatVirtualMachine);
  var
  Param0: DWORD;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.InternetGetLastResponseInfoA(Param0,PAnsiChar(VarToStr(GetInputArg(1))),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__InternetGetLastResponseInfoW(AMachine: TatVirtualMachine);
  var
  Param0: DWORD;
  Param1Buf: array[0..127] of WideChar;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.InternetGetLastResponseInfoW(Param0,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__IS_GOPHER_FILE(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.IS_GOPHER_FILE(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__IS_GOPHER_DIRECTORY(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.IS_GOPHER_DIRECTORY(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__IS_GOPHER_PHONE_SERVER(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.IS_GOPHER_PHONE_SERVER(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__IS_GOPHER_ERROR(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.IS_GOPHER_ERROR(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__IS_GOPHER_INDEX_SERVER(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.IS_GOPHER_INDEX_SERVER(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__IS_GOPHER_TELNET_SESSION(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.IS_GOPHER_TELNET_SESSION(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__IS_GOPHER_BACKUP_SERVER(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.IS_GOPHER_BACKUP_SERVER(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__IS_GOPHER_TN3270_SESSION(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.IS_GOPHER_TN3270_SESSION(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__IS_GOPHER_ASK(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.IS_GOPHER_ASK(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__IS_GOPHER_PLUS(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.IS_GOPHER_PLUS(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__IS_GOPHER_TYPE_KNOWN(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.IS_GOPHER_TYPE_KNOWN(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__GopherCreateLocator(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  Param5Buf: array[0..127] of WideChar;
  Param6: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param6 := VarToInteger(GetInputArg(6));
AResult := WinInet.GopherCreateLocator(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4)),StringToWideChar(VarToStr(GetInputArg(5)),Param5Buf,Length(VarToStr(GetInputArg(5)))),Param6);
    ReturnOutputArg(AResult);
    SetInputArg(6,Integer(Param6));
  end;
end;

procedure TatWinInetLibrary.__GopherCreateLocatorA(AMachine: TatVirtualMachine);
  var
  Param6: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param6 := VarToInteger(GetInputArg(6));
AResult := WinInet.GopherCreateLocatorA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4)),PAnsiChar(VarToStr(GetInputArg(5))),Param6);
    ReturnOutputArg(AResult);
    SetInputArg(6,Integer(Param6));
  end;
end;

procedure TatWinInetLibrary.__GopherCreateLocatorW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  Param5Buf: array[0..127] of WideChar;
  Param6: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param6 := VarToInteger(GetInputArg(6));
AResult := WinInet.GopherCreateLocatorW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4)),StringToWideChar(VarToStr(GetInputArg(5)),Param5Buf,Length(VarToStr(GetInputArg(5)))),Param6);
    ReturnOutputArg(AResult);
    SetInputArg(6,Integer(Param6));
  end;
end;

procedure TatWinInetLibrary.__GopherGetLocatorType(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := WinInet.GopherGetLocatorType(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatWinInetLibrary.__GopherGetLocatorTypeA(AMachine: TatVirtualMachine);
  var
  Param1: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := WinInet.GopherGetLocatorTypeA(PAnsiChar(VarToStr(GetInputArg(0))),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatWinInetLibrary.__GopherGetLocatorTypeW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := WinInet.GopherGetLocatorTypeW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatWinInetLibrary.__InternetSetCookie(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.InternetSetCookie(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetSetCookieA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.InternetSetCookieA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetSetCookieW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.InternetSetCookieW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetGetCookie(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := WinInet.InternetGetCookie(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinInetLibrary.__InternetGetCookieA(AMachine: TatVirtualMachine);
  var
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := WinInet.InternetGetCookieA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinInetLibrary.__InternetGetCookieW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := WinInet.InternetGetCookieW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinInetLibrary.__InternetAttemptConnect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinInet.InternetAttemptConnect(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetCheckConnection(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.InternetCheckConnection(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetCheckConnectionA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.InternetCheckConnectionA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetCheckConnectionW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.InternetCheckConnectionW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetConfirmZoneCrossing(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinInet.InternetConfirmZoneCrossing(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__CreateUrlCacheEntry(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.CreateUrlCacheEntry(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__CreateUrlCacheEntryA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.CreateUrlCacheEntryA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__CreateUrlCacheEntryW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.CreateUrlCacheEntryW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__RetrieveUrlCacheEntryFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.RetrieveUrlCacheEntryFile(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2,VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__RetrieveUrlCacheEntryFileA(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.RetrieveUrlCacheEntryFileA(PAnsiChar(VarToStr(GetInputArg(0))),Param1,Param2,VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__RetrieveUrlCacheEntryFileW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.RetrieveUrlCacheEntryFileW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2,VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__UnlockUrlCacheEntryFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.UnlockUrlCacheEntryFile(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__UnlockUrlCacheEntryFileA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.UnlockUrlCacheEntryFileA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__UnlockUrlCacheEntryFileW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.UnlockUrlCacheEntryFileW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__RetrieveUrlCacheEntryStream(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.RetrieveUrlCacheEntryStream(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2,GetInputArg(3),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__RetrieveUrlCacheEntryStreamA(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.RetrieveUrlCacheEntryStreamA(PAnsiChar(VarToStr(GetInputArg(0))),Param1,Param2,GetInputArg(3),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__RetrieveUrlCacheEntryStreamW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.RetrieveUrlCacheEntryStreamW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2,GetInputArg(3),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__UnlockUrlCacheEntryStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.UnlockUrlCacheEntryStream(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__GetUrlCacheEntryInfo(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.GetUrlCacheEntryInfo(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__GetUrlCacheEntryInfoA(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.GetUrlCacheEntryInfoA(PAnsiChar(VarToStr(GetInputArg(0))),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__GetUrlCacheEntryInfoW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.GetUrlCacheEntryInfoW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__SetUrlCacheEntryInfo(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
AResult := WinInet.SetUrlCacheEntryInfo(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
  end;
end;

procedure TatWinInetLibrary.__SetUrlCacheEntryInfoA(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
AResult := WinInet.SetUrlCacheEntryInfoA(PAnsiChar(VarToStr(GetInputArg(0))),Param1,VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
  end;
end;

procedure TatWinInetLibrary.__SetUrlCacheEntryInfoW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
AResult := WinInet.SetUrlCacheEntryInfoW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
  end;
end;

procedure TatWinInetLibrary.__FindFirstUrlCacheEntry(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.FindFirstUrlCacheEntry(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__FindFirstUrlCacheEntryA(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfoA;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOAWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOAWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOAWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.FindFirstUrlCacheEntryA(PAnsiChar(VarToStr(GetInputArg(0))),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOAWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__FindFirstUrlCacheEntryW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfoW;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.FindFirstUrlCacheEntryW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__FindNextUrlCacheEntry(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfo;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.FindNextUrlCacheEntry(GetInputArg(0),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__FindNextUrlCacheEntryA(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfoA;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOAWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOAWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOAWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.FindNextUrlCacheEntryA(GetInputArg(0),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOAWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__FindNextUrlCacheEntryW(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TInternetCacheEntryInfoW;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is INTERNET_CACHE_ENTRY_INFOWWrapper) then 
  Param1Rec := INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1);
Param1 := INTERNET_CACHE_ENTRY_INFOWWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := WinInet.FindNextUrlCacheEntryW(GetInputArg(0),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(INTERNET_CACHE_ENTRY_INFOWWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinInetLibrary.__FindCloseUrlCache(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.FindCloseUrlCache(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__DeleteUrlCacheEntry(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.DeleteUrlCacheEntry(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__DeleteUrlCacheEntryA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.DeleteUrlCacheEntryA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__DeleteUrlCacheEntryW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.DeleteUrlCacheEntryW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetHangUp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinInet.InternetHangUp(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetGoOnline(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.InternetGoOnline(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetAutodial(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.InternetAutodial(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetAutodialHangup(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.InternetAutodialHangup(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.__InternetSetDialState(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinInet.InternetSetDialState(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinInetLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('InternetTimeFromSystemTime',4,tkVariant,nil,__InternetTimeFromSystemTime,false,0);
    DefineMethod('InternetCrackUrl',4,tkVariant,nil,__InternetCrackUrl,false,0).SetVarArgs([3]);
    DefineMethod('InternetCrackUrlA',4,tkVariant,nil,__InternetCrackUrlA,false,0).SetVarArgs([3]);
    DefineMethod('InternetCrackUrlW',4,tkVariant,nil,__InternetCrackUrlW,false,0).SetVarArgs([3]);
    DefineMethod('InternetCreateUrl',4,tkVariant,nil,__InternetCreateUrl,false,0).SetVarArgs([0,3]);
    DefineMethod('InternetCreateUrlA',4,tkVariant,nil,__InternetCreateUrlA,false,0).SetVarArgs([0,3]);
    DefineMethod('InternetCreateUrlW',4,tkVariant,nil,__InternetCreateUrlW,false,0).SetVarArgs([0,3]);
    DefineMethod('InternetCanonicalizeUrl',4,tkVariant,nil,__InternetCanonicalizeUrl,false,0).SetVarArgs([2]);
    DefineMethod('InternetCanonicalizeUrlA',4,tkVariant,nil,__InternetCanonicalizeUrlA,false,0).SetVarArgs([2]);
    DefineMethod('InternetCanonicalizeUrlW',4,tkVariant,nil,__InternetCanonicalizeUrlW,false,0).SetVarArgs([2]);
    DefineMethod('InternetCombineUrl',5,tkVariant,nil,__InternetCombineUrl,false,0).SetVarArgs([3]);
    DefineMethod('InternetCombineUrlA',5,tkVariant,nil,__InternetCombineUrlA,false,0).SetVarArgs([3]);
    DefineMethod('InternetCombineUrlW',5,tkVariant,nil,__InternetCombineUrlW,false,0).SetVarArgs([3]);
    DefineMethod('InternetUnlockRequestFile',1,tkVariant,nil,__InternetUnlockRequestFile,false,0);
    DefineMethod('InternetGetLastResponseInfo',3,tkVariant,nil,__InternetGetLastResponseInfo,false,0).SetVarArgs([0,2]);
    DefineMethod('InternetGetLastResponseInfoA',3,tkVariant,nil,__InternetGetLastResponseInfoA,false,0).SetVarArgs([0,2]);
    DefineMethod('InternetGetLastResponseInfoW',3,tkVariant,nil,__InternetGetLastResponseInfoW,false,0).SetVarArgs([0,2]);
    DefineMethod('IS_GOPHER_FILE',1,tkVariant,nil,__IS_GOPHER_FILE,false,0);
    DefineMethod('IS_GOPHER_DIRECTORY',1,tkVariant,nil,__IS_GOPHER_DIRECTORY,false,0);
    DefineMethod('IS_GOPHER_PHONE_SERVER',1,tkVariant,nil,__IS_GOPHER_PHONE_SERVER,false,0);
    DefineMethod('IS_GOPHER_ERROR',1,tkVariant,nil,__IS_GOPHER_ERROR,false,0);
    DefineMethod('IS_GOPHER_INDEX_SERVER',1,tkVariant,nil,__IS_GOPHER_INDEX_SERVER,false,0);
    DefineMethod('IS_GOPHER_TELNET_SESSION',1,tkVariant,nil,__IS_GOPHER_TELNET_SESSION,false,0);
    DefineMethod('IS_GOPHER_BACKUP_SERVER',1,tkVariant,nil,__IS_GOPHER_BACKUP_SERVER,false,0);
    DefineMethod('IS_GOPHER_TN3270_SESSION',1,tkVariant,nil,__IS_GOPHER_TN3270_SESSION,false,0);
    DefineMethod('IS_GOPHER_ASK',1,tkVariant,nil,__IS_GOPHER_ASK,false,0);
    DefineMethod('IS_GOPHER_PLUS',1,tkVariant,nil,__IS_GOPHER_PLUS,false,0);
    DefineMethod('IS_GOPHER_TYPE_KNOWN',1,tkVariant,nil,__IS_GOPHER_TYPE_KNOWN,false,0);
    DefineMethod('GopherCreateLocator',7,tkVariant,nil,__GopherCreateLocator,false,0).SetVarArgs([6]);
    DefineMethod('GopherCreateLocatorA',7,tkVariant,nil,__GopherCreateLocatorA,false,0).SetVarArgs([6]);
    DefineMethod('GopherCreateLocatorW',7,tkVariant,nil,__GopherCreateLocatorW,false,0).SetVarArgs([6]);
    DefineMethod('GopherGetLocatorType',2,tkVariant,nil,__GopherGetLocatorType,false,0).SetVarArgs([1]);
    DefineMethod('GopherGetLocatorTypeA',2,tkVariant,nil,__GopherGetLocatorTypeA,false,0).SetVarArgs([1]);
    DefineMethod('GopherGetLocatorTypeW',2,tkVariant,nil,__GopherGetLocatorTypeW,false,0).SetVarArgs([1]);
    DefineMethod('InternetSetCookie',3,tkVariant,nil,__InternetSetCookie,false,0);
    DefineMethod('InternetSetCookieA',3,tkVariant,nil,__InternetSetCookieA,false,0);
    DefineMethod('InternetSetCookieW',3,tkVariant,nil,__InternetSetCookieW,false,0);
    DefineMethod('InternetGetCookie',4,tkVariant,nil,__InternetGetCookie,false,0).SetVarArgs([3]);
    DefineMethod('InternetGetCookieA',4,tkVariant,nil,__InternetGetCookieA,false,0).SetVarArgs([3]);
    DefineMethod('InternetGetCookieW',4,tkVariant,nil,__InternetGetCookieW,false,0).SetVarArgs([3]);
    DefineMethod('InternetAttemptConnect',1,tkInteger,nil,__InternetAttemptConnect,false,0);
    DefineMethod('InternetCheckConnection',3,tkVariant,nil,__InternetCheckConnection,false,0);
    DefineMethod('InternetCheckConnectionA',3,tkVariant,nil,__InternetCheckConnectionA,false,0);
    DefineMethod('InternetCheckConnectionW',3,tkVariant,nil,__InternetCheckConnectionW,false,0);
    DefineMethod('InternetConfirmZoneCrossing',4,tkInteger,nil,__InternetConfirmZoneCrossing,false,0);
    DefineMethod('CreateUrlCacheEntry',5,tkVariant,nil,__CreateUrlCacheEntry,false,0);
    DefineMethod('CreateUrlCacheEntryA',5,tkVariant,nil,__CreateUrlCacheEntryA,false,0);
    DefineMethod('CreateUrlCacheEntryW',5,tkVariant,nil,__CreateUrlCacheEntryW,false,0);
    DefineMethod('RetrieveUrlCacheEntryFile',4,tkVariant,nil,__RetrieveUrlCacheEntryFile,false,0).SetVarArgs([1,2]);
    DefineMethod('RetrieveUrlCacheEntryFileA',4,tkVariant,nil,__RetrieveUrlCacheEntryFileA,false,0).SetVarArgs([1,2]);
    DefineMethod('RetrieveUrlCacheEntryFileW',4,tkVariant,nil,__RetrieveUrlCacheEntryFileW,false,0).SetVarArgs([1,2]);
    DefineMethod('UnlockUrlCacheEntryFile',2,tkVariant,nil,__UnlockUrlCacheEntryFile,false,0);
    DefineMethod('UnlockUrlCacheEntryFileA',2,tkVariant,nil,__UnlockUrlCacheEntryFileA,false,0);
    DefineMethod('UnlockUrlCacheEntryFileW',2,tkVariant,nil,__UnlockUrlCacheEntryFileW,false,0);
    DefineMethod('RetrieveUrlCacheEntryStream',5,tkVariant,nil,__RetrieveUrlCacheEntryStream,false,0).SetVarArgs([1,2]);
    DefineMethod('RetrieveUrlCacheEntryStreamA',5,tkVariant,nil,__RetrieveUrlCacheEntryStreamA,false,0).SetVarArgs([1,2]);
    DefineMethod('RetrieveUrlCacheEntryStreamW',5,tkVariant,nil,__RetrieveUrlCacheEntryStreamW,false,0).SetVarArgs([1,2]);
    DefineMethod('UnlockUrlCacheEntryStream',2,tkVariant,nil,__UnlockUrlCacheEntryStream,false,0);
    DefineMethod('GetUrlCacheEntryInfo',3,tkVariant,nil,__GetUrlCacheEntryInfo,false,0).SetVarArgs([1,2]);
    DefineMethod('GetUrlCacheEntryInfoA',3,tkVariant,nil,__GetUrlCacheEntryInfoA,false,0).SetVarArgs([1,2]);
    DefineMethod('GetUrlCacheEntryInfoW',3,tkVariant,nil,__GetUrlCacheEntryInfoW,false,0).SetVarArgs([1,2]);
    DefineMethod('SetUrlCacheEntryInfo',3,tkVariant,nil,__SetUrlCacheEntryInfo,false,0).SetVarArgs([1]);
    DefineMethod('SetUrlCacheEntryInfoA',3,tkVariant,nil,__SetUrlCacheEntryInfoA,false,0).SetVarArgs([1]);
    DefineMethod('SetUrlCacheEntryInfoW',3,tkVariant,nil,__SetUrlCacheEntryInfoW,false,0).SetVarArgs([1]);
    DefineMethod('FindFirstUrlCacheEntry',3,tkVariant,nil,__FindFirstUrlCacheEntry,false,0).SetVarArgs([1,2]);
    DefineMethod('FindFirstUrlCacheEntryA',3,tkVariant,nil,__FindFirstUrlCacheEntryA,false,0).SetVarArgs([1,2]);
    DefineMethod('FindFirstUrlCacheEntryW',3,tkVariant,nil,__FindFirstUrlCacheEntryW,false,0).SetVarArgs([1,2]);
    DefineMethod('FindNextUrlCacheEntry',3,tkVariant,nil,__FindNextUrlCacheEntry,false,0).SetVarArgs([1,2]);
    DefineMethod('FindNextUrlCacheEntryA',3,tkVariant,nil,__FindNextUrlCacheEntryA,false,0).SetVarArgs([1,2]);
    DefineMethod('FindNextUrlCacheEntryW',3,tkVariant,nil,__FindNextUrlCacheEntryW,false,0).SetVarArgs([1,2]);
    DefineMethod('FindCloseUrlCache',1,tkVariant,nil,__FindCloseUrlCache,false,0);
    DefineMethod('DeleteUrlCacheEntry',1,tkVariant,nil,__DeleteUrlCacheEntry,false,0);
    DefineMethod('DeleteUrlCacheEntryA',1,tkVariant,nil,__DeleteUrlCacheEntryA,false,0);
    DefineMethod('DeleteUrlCacheEntryW',1,tkVariant,nil,__DeleteUrlCacheEntryW,false,0);
    DefineMethod('InternetHangUp',2,tkInteger,nil,__InternetHangUp,false,0);
    DefineMethod('InternetGoOnline',3,tkVariant,nil,__InternetGoOnline,false,0);
    DefineMethod('InternetAutodial',2,tkVariant,nil,__InternetAutodial,false,0);
    DefineMethod('InternetAutodialHangup',1,tkVariant,nil,__InternetAutodialHangup,false,0);
    DefineMethod('InternetSetDialState',3,tkVariant,nil,__InternetSetDialState,false,0);
    AddConstant('INTERNET_INVALID_PORT_NUMBER',INTERNET_INVALID_PORT_NUMBER);
    AddConstant('INTERNET_DEFAULT_FTP_PORT',INTERNET_DEFAULT_FTP_PORT);
    AddConstant('INTERNET_DEFAULT_GOPHER_PORT',INTERNET_DEFAULT_GOPHER_PORT);
    AddConstant('INTERNET_DEFAULT_HTTP_PORT',INTERNET_DEFAULT_HTTP_PORT);
    AddConstant('INTERNET_DEFAULT_HTTPS_PORT',INTERNET_DEFAULT_HTTPS_PORT);
    AddConstant('INTERNET_DEFAULT_SOCKS_PORT',INTERNET_DEFAULT_SOCKS_PORT);
    AddConstant('MAX_CACHE_ENTRY_INFO_SIZE',MAX_CACHE_ENTRY_INFO_SIZE);
    AddConstant('INTERNET_MAX_HOST_NAME_LENGTH',INTERNET_MAX_HOST_NAME_LENGTH);
    AddConstant('INTERNET_MAX_USER_NAME_LENGTH',INTERNET_MAX_USER_NAME_LENGTH);
    AddConstant('INTERNET_MAX_PASSWORD_LENGTH',INTERNET_MAX_PASSWORD_LENGTH);
    AddConstant('INTERNET_MAX_PORT_NUMBER_LENGTH',INTERNET_MAX_PORT_NUMBER_LENGTH);
    AddConstant('INTERNET_MAX_PORT_NUMBER_VALUE',INTERNET_MAX_PORT_NUMBER_VALUE);
    AddConstant('INTERNET_MAX_PATH_LENGTH',INTERNET_MAX_PATH_LENGTH);
    AddConstant('INTERNET_MAX_SCHEME_LENGTH',INTERNET_MAX_SCHEME_LENGTH);
    AddConstant('INTERNET_MAX_PROTOCOL_NAME',INTERNET_MAX_PROTOCOL_NAME);
    AddConstant('INTERNET_MAX_URL_LENGTH',INTERNET_MAX_URL_LENGTH);
    AddConstant('INTERNET_KEEP_ALIVE_UNKNOWN',INTERNET_KEEP_ALIVE_UNKNOWN);
    AddConstant('INTERNET_KEEP_ALIVE_ENABLED',INTERNET_KEEP_ALIVE_ENABLED);
    AddConstant('INTERNET_KEEP_ALIVE_DISABLED',INTERNET_KEEP_ALIVE_DISABLED);
    AddConstant('INTERNET_REQFLAG_FROM_CACHE',INTERNET_REQFLAG_FROM_CACHE);
    AddConstant('INTERNET_REQFLAG_ASYNC',INTERNET_REQFLAG_ASYNC);
    AddConstant('INTERNET_REQFLAG_VIA_PROXY',INTERNET_REQFLAG_VIA_PROXY);
    AddConstant('INTERNET_REQFLAG_NO_HEADERS',INTERNET_REQFLAG_NO_HEADERS);
    AddConstant('INTERNET_REQFLAG_PASSIVE',INTERNET_REQFLAG_PASSIVE);
    AddConstant('INTERNET_REQFLAG_CACHE_WRITE_DISABLED',INTERNET_REQFLAG_CACHE_WRITE_DISABLED);
    AddConstant('INTERNET_FLAG_RELOAD',INTERNET_FLAG_RELOAD);
    AddConstant('INTERNET_FLAG_RAW_DATA',INTERNET_FLAG_RAW_DATA);
    AddConstant('INTERNET_FLAG_EXISTING_CONNECT',INTERNET_FLAG_EXISTING_CONNECT);
    AddConstant('INTERNET_FLAG_ASYNC',INTERNET_FLAG_ASYNC);
    AddConstant('INTERNET_FLAG_PASSIVE',INTERNET_FLAG_PASSIVE);
    AddConstant('INTERNET_FLAG_NO_CACHE_WRITE',INTERNET_FLAG_NO_CACHE_WRITE);
    AddConstant('INTERNET_FLAG_DONT_CACHE',INTERNET_FLAG_DONT_CACHE);
    AddConstant('INTERNET_FLAG_MAKE_PERSISTENT',INTERNET_FLAG_MAKE_PERSISTENT);
    AddConstant('INTERNET_FLAG_FROM_CACHE',INTERNET_FLAG_FROM_CACHE);
    AddConstant('INTERNET_FLAG_OFFLINE',INTERNET_FLAG_OFFLINE);
    AddConstant('INTERNET_FLAG_SECURE',INTERNET_FLAG_SECURE);
    AddConstant('INTERNET_FLAG_KEEP_CONNECTION',INTERNET_FLAG_KEEP_CONNECTION);
    AddConstant('INTERNET_FLAG_NO_AUTO_REDIRECT',INTERNET_FLAG_NO_AUTO_REDIRECT);
    AddConstant('INTERNET_FLAG_READ_PREFETCH',INTERNET_FLAG_READ_PREFETCH);
    AddConstant('INTERNET_FLAG_NO_COOKIES',INTERNET_FLAG_NO_COOKIES);
    AddConstant('INTERNET_FLAG_NO_AUTH',INTERNET_FLAG_NO_AUTH);
    AddConstant('INTERNET_FLAG_CACHE_IF_NET_FAIL',INTERNET_FLAG_CACHE_IF_NET_FAIL);
    AddConstant('INTERNET_FLAG_IGNORE_CERT_CN_INVALID',INTERNET_FLAG_IGNORE_CERT_CN_INVALID);
    AddConstant('INTERNET_FLAG_IGNORE_CERT_DATE_INVALID',INTERNET_FLAG_IGNORE_CERT_DATE_INVALID);
    AddConstant('INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS',INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS);
    AddConstant('INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP',INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP);
    AddConstant('INTERNET_FLAG_RESYNCHRONIZE',INTERNET_FLAG_RESYNCHRONIZE);
    AddConstant('INTERNET_FLAG_HYPERLINK',INTERNET_FLAG_HYPERLINK);
    AddConstant('INTERNET_FLAG_NO_UI',INTERNET_FLAG_NO_UI);
    AddConstant('INTERNET_FLAG_PRAGMA_NOCACHE',INTERNET_FLAG_PRAGMA_NOCACHE);
    AddConstant('INTERNET_FLAG_CACHE_ASYNC',INTERNET_FLAG_CACHE_ASYNC);
    AddConstant('INTERNET_FLAG_FORMS_SUBMIT',INTERNET_FLAG_FORMS_SUBMIT);
    AddConstant('INTERNET_FLAG_NEED_FILE',INTERNET_FLAG_NEED_FILE);
    AddConstant('INTERNET_FLAG_MUST_CACHE_REQUEST',INTERNET_FLAG_MUST_CACHE_REQUEST);
    AddConstant('FTP_TRANSFER_TYPE_UNKNOWN',FTP_TRANSFER_TYPE_UNKNOWN);
    AddConstant('FTP_TRANSFER_TYPE_ASCII',FTP_TRANSFER_TYPE_ASCII);
    AddConstant('FTP_TRANSFER_TYPE_BINARY',FTP_TRANSFER_TYPE_BINARY);
    AddConstant('FTP_TRANSFER_TYPE_MASK',FTP_TRANSFER_TYPE_MASK);
    AddConstant('INTERNET_FLAG_TRANSFER_ASCII',INTERNET_FLAG_TRANSFER_ASCII);
    AddConstant('INTERNET_FLAG_TRANSFER_BINARY',INTERNET_FLAG_TRANSFER_BINARY);
    AddConstant('SECURITY_INTERNET_MASK',SECURITY_INTERNET_MASK);
    AddConstant('SECURITY_SET_MASK',SECURITY_SET_MASK);
    AddConstant('INTERNET_FLAGS_MASK',INTERNET_FLAGS_MASK);
    AddConstant('INTERNET_ERROR_MASK_INSERT_CDROM',INTERNET_ERROR_MASK_INSERT_CDROM);
    AddConstant('INTERNET_OPTIONS_MASK',INTERNET_OPTIONS_MASK);
    AddConstant('WININET_API_FLAG_ASYNC',WININET_API_FLAG_ASYNC);
    AddConstant('WININET_API_FLAG_SYNC',WININET_API_FLAG_SYNC);
    AddConstant('WININET_API_FLAG_USE_CONTEXT',WININET_API_FLAG_USE_CONTEXT);
    AddConstant('INTERNET_NO_CALLBACK',INTERNET_NO_CALLBACK);
    AddConstant('INTERNET_SCHEME_PARTIAL',INTERNET_SCHEME_PARTIAL);
    AddConstant('INTERNET_SCHEME_UNKNOWN',INTERNET_SCHEME_UNKNOWN);
    AddConstant('INTERNET_SCHEME_DEFAULT',INTERNET_SCHEME_DEFAULT);
    AddConstant('INTERNET_SCHEME_FTP',INTERNET_SCHEME_FTP);
    AddConstant('INTERNET_SCHEME_GOPHER',INTERNET_SCHEME_GOPHER);
    AddConstant('INTERNET_SCHEME_HTTP',INTERNET_SCHEME_HTTP);
    AddConstant('INTERNET_SCHEME_HTTPS',INTERNET_SCHEME_HTTPS);
    AddConstant('INTERNET_SCHEME_FILE',INTERNET_SCHEME_FILE);
    AddConstant('INTERNET_SCHEME_NEWS',INTERNET_SCHEME_NEWS);
    AddConstant('INTERNET_SCHEME_MAILTO',INTERNET_SCHEME_MAILTO);
    AddConstant('INTERNET_SCHEME_FIRST',INTERNET_SCHEME_FIRST);
    AddConstant('INTERNET_SCHEME_LAST',INTERNET_SCHEME_LAST);
    AddConstant('INTERNET_PREFETCH_PROGRESS',INTERNET_PREFETCH_PROGRESS);
    AddConstant('INTERNET_PREFETCH_COMPLETE',INTERNET_PREFETCH_COMPLETE);
    AddConstant('INTERNET_PREFETCH_ABORTED',INTERNET_PREFETCH_ABORTED);
    AddConstant('ISO_FORCE_DISCONNECTED',ISO_FORCE_DISCONNECTED);
    AddConstant('INTERNET_RFC1123_FORMAT',INTERNET_RFC1123_FORMAT);
    AddConstant('INTERNET_RFC1123_BUFSIZE',INTERNET_RFC1123_BUFSIZE);
    AddConstant('ICU_ESCAPE',ICU_ESCAPE);
    AddConstant('ICU_USERNAME',ICU_USERNAME);
    AddConstant('ICU_NO_ENCODE',ICU_NO_ENCODE);
    AddConstant('ICU_DECODE',ICU_DECODE);
    AddConstant('ICU_NO_META',ICU_NO_META);
    AddConstant('ICU_ENCODE_SPACES_ONLY',ICU_ENCODE_SPACES_ONLY);
    AddConstant('ICU_BROWSER_MODE',ICU_BROWSER_MODE);
    AddConstant('INTERNET_OPEN_TYPE_PRECONFIG',INTERNET_OPEN_TYPE_PRECONFIG);
    AddConstant('INTERNET_OPEN_TYPE_DIRECT',INTERNET_OPEN_TYPE_DIRECT);
    AddConstant('INTERNET_OPEN_TYPE_PROXY',INTERNET_OPEN_TYPE_PROXY);
    AddConstant('INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY',INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY);
    AddConstant('PRE_CONFIG_INTERNET_ACCESS',PRE_CONFIG_INTERNET_ACCESS);
    AddConstant('LOCAL_INTERNET_ACCESS',LOCAL_INTERNET_ACCESS);
    AddConstant('GATEWAY_INTERNET_ACCESS',GATEWAY_INTERNET_ACCESS);
    AddConstant('CERN_PROXY_INTERNET_ACCESS',CERN_PROXY_INTERNET_ACCESS);
    AddConstant('INTERNET_SERVICE_URL',INTERNET_SERVICE_URL);
    AddConstant('INTERNET_SERVICE_FTP',INTERNET_SERVICE_FTP);
    AddConstant('INTERNET_SERVICE_GOPHER',INTERNET_SERVICE_GOPHER);
    AddConstant('INTERNET_SERVICE_HTTP',INTERNET_SERVICE_HTTP);
    AddConstant('IRF_ASYNC',IRF_ASYNC);
    AddConstant('IRF_SYNC',IRF_SYNC);
    AddConstant('IRF_USE_CONTEXT',IRF_USE_CONTEXT);
    AddConstant('IRF_NO_WAIT',IRF_NO_WAIT);
    AddConstant('ISO_GLOBAL',ISO_GLOBAL);
    AddConstant('ISO_REGISTRY',ISO_REGISTRY);
    AddConstant('ISO_VALID_FLAGS',ISO_VALID_FLAGS);
    AddConstant('INTERNET_OPTION_CALLBACK',INTERNET_OPTION_CALLBACK);
    AddConstant('INTERNET_OPTION_CONNECT_TIMEOUT',INTERNET_OPTION_CONNECT_TIMEOUT);
    AddConstant('INTERNET_OPTION_CONNECT_RETRIES',INTERNET_OPTION_CONNECT_RETRIES);
    AddConstant('INTERNET_OPTION_CONNECT_BACKOFF',INTERNET_OPTION_CONNECT_BACKOFF);
    AddConstant('INTERNET_OPTION_SEND_TIMEOUT',INTERNET_OPTION_SEND_TIMEOUT);
    AddConstant('INTERNET_OPTION_CONTROL_SEND_TIMEOUT',INTERNET_OPTION_CONTROL_SEND_TIMEOUT);
    AddConstant('INTERNET_OPTION_RECEIVE_TIMEOUT',INTERNET_OPTION_RECEIVE_TIMEOUT);
    AddConstant('INTERNET_OPTION_CONTROL_RECEIVE_TIMEOUT',INTERNET_OPTION_CONTROL_RECEIVE_TIMEOUT);
    AddConstant('INTERNET_OPTION_DATA_SEND_TIMEOUT',INTERNET_OPTION_DATA_SEND_TIMEOUT);
    AddConstant('INTERNET_OPTION_DATA_RECEIVE_TIMEOUT',INTERNET_OPTION_DATA_RECEIVE_TIMEOUT);
    AddConstant('INTERNET_OPTION_HANDLE_TYPE',INTERNET_OPTION_HANDLE_TYPE);
    AddConstant('INTERNET_OPTION_READ_BUFFER_SIZE',INTERNET_OPTION_READ_BUFFER_SIZE);
    AddConstant('INTERNET_OPTION_WRITE_BUFFER_SIZE',INTERNET_OPTION_WRITE_BUFFER_SIZE);
    AddConstant('INTERNET_OPTION_ASYNC_ID',INTERNET_OPTION_ASYNC_ID);
    AddConstant('INTERNET_OPTION_ASYNC_PRIORITY',INTERNET_OPTION_ASYNC_PRIORITY);
    AddConstant('INTERNET_OPTION_PARENT_HANDLE',INTERNET_OPTION_PARENT_HANDLE);
    AddConstant('INTERNET_OPTION_KEEP_CONNECTION',INTERNET_OPTION_KEEP_CONNECTION);
    AddConstant('INTERNET_OPTION_REQUEST_FLAGS',INTERNET_OPTION_REQUEST_FLAGS);
    AddConstant('INTERNET_OPTION_EXTENDED_ERROR',INTERNET_OPTION_EXTENDED_ERROR);
    AddConstant('INTERNET_OPTION_OFFLINE_MODE',INTERNET_OPTION_OFFLINE_MODE);
    AddConstant('INTERNET_OPTION_CACHE_STREAM_HANDLE',INTERNET_OPTION_CACHE_STREAM_HANDLE);
    AddConstant('INTERNET_OPTION_USERNAME',INTERNET_OPTION_USERNAME);
    AddConstant('INTERNET_OPTION_PASSWORD',INTERNET_OPTION_PASSWORD);
    AddConstant('INTERNET_OPTION_ASYNC',INTERNET_OPTION_ASYNC);
    AddConstant('INTERNET_OPTION_SECURITY_FLAGS',INTERNET_OPTION_SECURITY_FLAGS);
    AddConstant('INTERNET_OPTION_SECURITY_CERTIFICATE_STRUCT',INTERNET_OPTION_SECURITY_CERTIFICATE_STRUCT);
    AddConstant('INTERNET_OPTION_DATAFILE_NAME',INTERNET_OPTION_DATAFILE_NAME);
    AddConstant('INTERNET_OPTION_URL',INTERNET_OPTION_URL);
    AddConstant('INTERNET_OPTION_SECURITY_CERTIFICATE',INTERNET_OPTION_SECURITY_CERTIFICATE);
    AddConstant('INTERNET_OPTION_SECURITY_KEY_BITNESS',INTERNET_OPTION_SECURITY_KEY_BITNESS);
    AddConstant('INTERNET_OPTION_REFRESH',INTERNET_OPTION_REFRESH);
    AddConstant('INTERNET_OPTION_PROXY',INTERNET_OPTION_PROXY);
    AddConstant('INTERNET_OPTION_SETTINGS_CHANGED',INTERNET_OPTION_SETTINGS_CHANGED);
    AddConstant('INTERNET_OPTION_VERSION',INTERNET_OPTION_VERSION);
    AddConstant('INTERNET_OPTION_USER_AGENT',INTERNET_OPTION_USER_AGENT);
    AddConstant('INTERNET_OPTION_END_BROWSER_SESSION',INTERNET_OPTION_END_BROWSER_SESSION);
    AddConstant('INTERNET_OPTION_PROXY_USERNAME',INTERNET_OPTION_PROXY_USERNAME);
    AddConstant('INTERNET_OPTION_PROXY_PASSWORD',INTERNET_OPTION_PROXY_PASSWORD);
    AddConstant('INTERNET_OPTION_CONTEXT_VALUE',INTERNET_OPTION_CONTEXT_VALUE);
    AddConstant('INTERNET_OPTION_CONNECT_LIMIT',INTERNET_OPTION_CONNECT_LIMIT);
    AddConstant('INTERNET_OPTION_SECURITY_SELECT_CLIENT_CERT',INTERNET_OPTION_SECURITY_SELECT_CLIENT_CERT);
    AddConstant('INTERNET_OPTION_POLICY',INTERNET_OPTION_POLICY);
    AddConstant('INTERNET_OPTION_DISCONNECTED_TIMEOUT',INTERNET_OPTION_DISCONNECTED_TIMEOUT);
    AddConstant('INTERNET_OPTION_CONNECTED_STATE',INTERNET_OPTION_CONNECTED_STATE);
    AddConstant('INTERNET_OPTION_IDLE_STATE',INTERNET_OPTION_IDLE_STATE);
    AddConstant('INTERNET_OPTION_OFFLINE_SEMANTICS',INTERNET_OPTION_OFFLINE_SEMANTICS);
    AddConstant('INTERNET_OPTION_SECONDARY_CACHE_KEY',INTERNET_OPTION_SECONDARY_CACHE_KEY);
    AddConstant('INTERNET_OPTION_CALLBACK_FILTER',INTERNET_OPTION_CALLBACK_FILTER);
    AddConstant('INTERNET_OPTION_CONNECT_TIME',INTERNET_OPTION_CONNECT_TIME);
    AddConstant('INTERNET_OPTION_SEND_THROUGHPUT',INTERNET_OPTION_SEND_THROUGHPUT);
    AddConstant('INTERNET_OPTION_RECEIVE_THROUGHPUT',INTERNET_OPTION_RECEIVE_THROUGHPUT);
    AddConstant('INTERNET_OPTION_REQUEST_PRIORITY',INTERNET_OPTION_REQUEST_PRIORITY);
    AddConstant('INTERNET_OPTION_HTTP_VERSION',INTERNET_OPTION_HTTP_VERSION);
    AddConstant('INTERNET_OPTION_RESET_URLCACHE_SESSION',INTERNET_OPTION_RESET_URLCACHE_SESSION);
    AddConstant('INTERNET_OPTION_ERROR_MASK',INTERNET_OPTION_ERROR_MASK);
    AddConstant('INTERNET_FIRST_OPTION',INTERNET_FIRST_OPTION);
    AddConstant('INTERNET_LAST_OPTION',INTERNET_LAST_OPTION);
    AddConstant('INTERNET_PRIORITY_FOREGROUND',INTERNET_PRIORITY_FOREGROUND);
    AddConstant('INTERNET_HANDLE_TYPE_INTERNET',INTERNET_HANDLE_TYPE_INTERNET);
    AddConstant('INTERNET_HANDLE_TYPE_CONNECT_FTP',INTERNET_HANDLE_TYPE_CONNECT_FTP);
    AddConstant('INTERNET_HANDLE_TYPE_CONNECT_GOPHER',INTERNET_HANDLE_TYPE_CONNECT_GOPHER);
    AddConstant('INTERNET_HANDLE_TYPE_CONNECT_HTTP',INTERNET_HANDLE_TYPE_CONNECT_HTTP);
    AddConstant('INTERNET_HANDLE_TYPE_FTP_FIND',INTERNET_HANDLE_TYPE_FTP_FIND);
    AddConstant('INTERNET_HANDLE_TYPE_FTP_FIND_HTML',INTERNET_HANDLE_TYPE_FTP_FIND_HTML);
    AddConstant('INTERNET_HANDLE_TYPE_FTP_FILE',INTERNET_HANDLE_TYPE_FTP_FILE);
    AddConstant('INTERNET_HANDLE_TYPE_FTP_FILE_HTML',INTERNET_HANDLE_TYPE_FTP_FILE_HTML);
    AddConstant('INTERNET_HANDLE_TYPE_GOPHER_FIND',INTERNET_HANDLE_TYPE_GOPHER_FIND);
    AddConstant('INTERNET_HANDLE_TYPE_GOPHER_FIND_HTML',INTERNET_HANDLE_TYPE_GOPHER_FIND_HTML);
    AddConstant('INTERNET_HANDLE_TYPE_GOPHER_FILE',INTERNET_HANDLE_TYPE_GOPHER_FILE);
    AddConstant('INTERNET_HANDLE_TYPE_GOPHER_FILE_HTML',INTERNET_HANDLE_TYPE_GOPHER_FILE_HTML);
    AddConstant('INTERNET_HANDLE_TYPE_HTTP_REQUEST',INTERNET_HANDLE_TYPE_HTTP_REQUEST);
    AddConstant('SECURITY_FLAG_SECURE',SECURITY_FLAG_SECURE);
    AddConstant('SECURITY_FLAG_SSL',SECURITY_FLAG_SSL);
    AddConstant('SECURITY_FLAG_SSL3',SECURITY_FLAG_SSL3);
    AddConstant('SECURITY_FLAG_PCT',SECURITY_FLAG_PCT);
    AddConstant('SECURITY_FLAG_PCT4',SECURITY_FLAG_PCT4);
    AddConstant('SECURITY_FLAG_IETFSSL4',SECURITY_FLAG_IETFSSL4);
    AddConstant('SECURITY_FLAG_STRENGTH_WEAK',SECURITY_FLAG_STRENGTH_WEAK);
    AddConstant('SECURITY_FLAG_STRENGTH_MEDIUM',SECURITY_FLAG_STRENGTH_MEDIUM);
    AddConstant('SECURITY_FLAG_STRENGTH_STRONG',SECURITY_FLAG_STRENGTH_STRONG);
    AddConstant('SECURITY_FLAG_40BIT',SECURITY_FLAG_40BIT);
    AddConstant('SECURITY_FLAG_128BIT',SECURITY_FLAG_128BIT);
    AddConstant('SECURITY_FLAG_56BIT',SECURITY_FLAG_56BIT);
    AddConstant('SECURITY_FLAG_UNKNOWNBIT',SECURITY_FLAG_UNKNOWNBIT);
    AddConstant('SECURITY_FLAG_NORMALBITNESS',SECURITY_FLAG_NORMALBITNESS);
    AddConstant('SECURITY_FLAG_IGNORE_REVOCATION',SECURITY_FLAG_IGNORE_REVOCATION);
    AddConstant('SECURITY_FLAG_IGNORE_UNKNOWN_CA',SECURITY_FLAG_IGNORE_UNKNOWN_CA);
    AddConstant('SECURITY_FLAG_IGNORE_WRONG_USAGE',SECURITY_FLAG_IGNORE_WRONG_USAGE);
    AddConstant('SECURITY_FLAG_IGNORE_CERT_CN_INVALID',SECURITY_FLAG_IGNORE_CERT_CN_INVALID);
    AddConstant('SECURITY_FLAG_IGNORE_CERT_DATE_INVALID',SECURITY_FLAG_IGNORE_CERT_DATE_INVALID);
    AddConstant('SECURITY_FLAG_IGNORE_REDIRECT_TO_HTTPS',SECURITY_FLAG_IGNORE_REDIRECT_TO_HTTPS);
    AddConstant('SECURITY_FLAG_IGNORE_REDIRECT_TO_HTTP',SECURITY_FLAG_IGNORE_REDIRECT_TO_HTTP);
    AddConstant('INTERNET_STATUS_RESOLVING_NAME',INTERNET_STATUS_RESOLVING_NAME);
    AddConstant('INTERNET_STATUS_NAME_RESOLVED',INTERNET_STATUS_NAME_RESOLVED);
    AddConstant('INTERNET_STATUS_CONNECTING_TO_SERVER',INTERNET_STATUS_CONNECTING_TO_SERVER);
    AddConstant('INTERNET_STATUS_CONNECTED_TO_SERVER',INTERNET_STATUS_CONNECTED_TO_SERVER);
    AddConstant('INTERNET_STATUS_SENDING_REQUEST',INTERNET_STATUS_SENDING_REQUEST);
    AddConstant('INTERNET_STATUS_REQUEST_SENT',INTERNET_STATUS_REQUEST_SENT);
    AddConstant('INTERNET_STATUS_RECEIVING_RESPONSE',INTERNET_STATUS_RECEIVING_RESPONSE);
    AddConstant('INTERNET_STATUS_RESPONSE_RECEIVED',INTERNET_STATUS_RESPONSE_RECEIVED);
    AddConstant('INTERNET_STATUS_CTL_RESPONSE_RECEIVED',INTERNET_STATUS_CTL_RESPONSE_RECEIVED);
    AddConstant('INTERNET_STATUS_PREFETCH',INTERNET_STATUS_PREFETCH);
    AddConstant('INTERNET_STATUS_CLOSING_CONNECTION',INTERNET_STATUS_CLOSING_CONNECTION);
    AddConstant('INTERNET_STATUS_CONNECTION_CLOSED',INTERNET_STATUS_CONNECTION_CLOSED);
    AddConstant('INTERNET_STATUS_HANDLE_CREATED',INTERNET_STATUS_HANDLE_CREATED);
    AddConstant('INTERNET_STATUS_HANDLE_CLOSING',INTERNET_STATUS_HANDLE_CLOSING);
    AddConstant('INTERNET_STATUS_REQUEST_COMPLETE',INTERNET_STATUS_REQUEST_COMPLETE);
    AddConstant('INTERNET_STATUS_REDIRECT',INTERNET_STATUS_REDIRECT);
    AddConstant('INTERNET_STATUS_INTERMEDIATE_RESPONSE',INTERNET_STATUS_INTERMEDIATE_RESPONSE);
    AddConstant('INTERNET_STATUS_STATE_CHANGE',INTERNET_STATUS_STATE_CHANGE);
    AddConstant('INTERNET_STATE_CONNECTED',INTERNET_STATE_CONNECTED);
    AddConstant('INTERNET_STATE_DISCONNECTED',INTERNET_STATE_DISCONNECTED);
    AddConstant('INTERNET_STATE_DISCONNECTED_BY_USER',INTERNET_STATE_DISCONNECTED_BY_USER);
    AddConstant('INTERNET_STATE_IDLE',INTERNET_STATE_IDLE);
    AddConstant('INTERNET_STATE_BUSY',INTERNET_STATE_BUSY);
    AddConstant('INTERNET_INVALID_STATUS_CALLBACK',INTERNET_INVALID_STATUS_CALLBACK);
    AddConstant('MAX_GOPHER_DISPLAY_TEXT',MAX_GOPHER_DISPLAY_TEXT);
    AddConstant('MAX_GOPHER_SELECTOR_TEXT',MAX_GOPHER_SELECTOR_TEXT);
    AddConstant('MAX_GOPHER_HOST_NAME',MAX_GOPHER_HOST_NAME);
    AddConstant('MAX_GOPHER_LOCATOR_LENGTH',MAX_GOPHER_LOCATOR_LENGTH);
    AddConstant('GOPHER_TYPE_TEXT_FILE',GOPHER_TYPE_TEXT_FILE);
    AddConstant('GOPHER_TYPE_DIRECTORY',GOPHER_TYPE_DIRECTORY);
    AddConstant('GOPHER_TYPE_CSO',GOPHER_TYPE_CSO);
    AddConstant('GOPHER_TYPE_ERROR',GOPHER_TYPE_ERROR);
    AddConstant('GOPHER_TYPE_MAC_BINHEX',GOPHER_TYPE_MAC_BINHEX);
    AddConstant('GOPHER_TYPE_DOS_ARCHIVE',GOPHER_TYPE_DOS_ARCHIVE);
    AddConstant('GOPHER_TYPE_UNIX_UUENCODED',GOPHER_TYPE_UNIX_UUENCODED);
    AddConstant('GOPHER_TYPE_INDEX_SERVER',GOPHER_TYPE_INDEX_SERVER);
    AddConstant('GOPHER_TYPE_TELNET',GOPHER_TYPE_TELNET);
    AddConstant('GOPHER_TYPE_BINARY',GOPHER_TYPE_BINARY);
    AddConstant('GOPHER_TYPE_REDUNDANT',GOPHER_TYPE_REDUNDANT);
    AddConstant('GOPHER_TYPE_TN3270',GOPHER_TYPE_TN3270);
    AddConstant('GOPHER_TYPE_GIF',GOPHER_TYPE_GIF);
    AddConstant('GOPHER_TYPE_IMAGE',GOPHER_TYPE_IMAGE);
    AddConstant('GOPHER_TYPE_BITMAP',GOPHER_TYPE_BITMAP);
    AddConstant('GOPHER_TYPE_MOVIE',GOPHER_TYPE_MOVIE);
    AddConstant('GOPHER_TYPE_SOUND',GOPHER_TYPE_SOUND);
    AddConstant('GOPHER_TYPE_HTML',GOPHER_TYPE_HTML);
    AddConstant('GOPHER_TYPE_PDF',GOPHER_TYPE_PDF);
    AddConstant('GOPHER_TYPE_CALENDAR',GOPHER_TYPE_CALENDAR);
    AddConstant('GOPHER_TYPE_INLINE',GOPHER_TYPE_INLINE);
    AddConstant('GOPHER_TYPE_UNKNOWN',GOPHER_TYPE_UNKNOWN);
    AddConstant('GOPHER_TYPE_ASK',GOPHER_TYPE_ASK);
    AddConstant('GOPHER_TYPE_GOPHER_PLUS',GOPHER_TYPE_GOPHER_PLUS);
    AddConstant('GOPHER_TYPE_FILE_MASK',GOPHER_TYPE_FILE_MASK);
    AddConstant('MAX_GOPHER_CATEGORY_NAME',MAX_GOPHER_CATEGORY_NAME);
    AddConstant('MAX_GOPHER_ATTRIBUTE_NAME',MAX_GOPHER_ATTRIBUTE_NAME);
    AddConstant('MIN_GOPHER_ATTRIBUTE_LENGTH',MIN_GOPHER_ATTRIBUTE_LENGTH);
    AddConstant('GOPHER_INFO_CATEGORY',GOPHER_INFO_CATEGORY);
    AddConstant('GOPHER_ADMIN_CATEGORY',GOPHER_ADMIN_CATEGORY);
    AddConstant('GOPHER_VIEWS_CATEGORY',GOPHER_VIEWS_CATEGORY);
    AddConstant('GOPHER_ABSTRACT_CATEGORY',GOPHER_ABSTRACT_CATEGORY);
    AddConstant('GOPHER_VERONICA_CATEGORY',GOPHER_VERONICA_CATEGORY);
    AddConstant('GOPHER_ADMIN_ATTRIBUTE',GOPHER_ADMIN_ATTRIBUTE);
    AddConstant('GOPHER_MOD_DATE_ATTRIBUTE',GOPHER_MOD_DATE_ATTRIBUTE);
    AddConstant('GOPHER_TTL_ATTRIBUTE',GOPHER_TTL_ATTRIBUTE);
    AddConstant('GOPHER_SCORE_ATTRIBUTE',GOPHER_SCORE_ATTRIBUTE);
    AddConstant('GOPHER_RANGE_ATTRIBUTE',GOPHER_RANGE_ATTRIBUTE);
    AddConstant('GOPHER_SITE_ATTRIBUTE',GOPHER_SITE_ATTRIBUTE);
    AddConstant('GOPHER_ORG_ATTRIBUTE',GOPHER_ORG_ATTRIBUTE);
    AddConstant('GOPHER_LOCATION_ATTRIBUTE',GOPHER_LOCATION_ATTRIBUTE);
    AddConstant('GOPHER_GEOG_ATTRIBUTE',GOPHER_GEOG_ATTRIBUTE);
    AddConstant('GOPHER_TIMEZONE_ATTRIBUTE',GOPHER_TIMEZONE_ATTRIBUTE);
    AddConstant('GOPHER_PROVIDER_ATTRIBUTE',GOPHER_PROVIDER_ATTRIBUTE);
    AddConstant('GOPHER_VERSION_ATTRIBUTE',GOPHER_VERSION_ATTRIBUTE);
    AddConstant('GOPHER_ABSTRACT_ATTRIBUTE',GOPHER_ABSTRACT_ATTRIBUTE);
    AddConstant('GOPHER_VIEW_ATTRIBUTE',GOPHER_VIEW_ATTRIBUTE);
    AddConstant('GOPHER_TREEWALK_ATTRIBUTE',GOPHER_TREEWALK_ATTRIBUTE);
    AddConstant('GOPHER_ATTRIBUTE_ID_BASE',GOPHER_ATTRIBUTE_ID_BASE);
    AddConstant('GOPHER_CATEGORY_ID_ALL',GOPHER_CATEGORY_ID_ALL);
    AddConstant('GOPHER_CATEGORY_ID_INFO',GOPHER_CATEGORY_ID_INFO);
    AddConstant('GOPHER_CATEGORY_ID_ADMIN',GOPHER_CATEGORY_ID_ADMIN);
    AddConstant('GOPHER_CATEGORY_ID_VIEWS',GOPHER_CATEGORY_ID_VIEWS);
    AddConstant('GOPHER_CATEGORY_ID_ABSTRACT',GOPHER_CATEGORY_ID_ABSTRACT);
    AddConstant('GOPHER_CATEGORY_ID_VERONICA',GOPHER_CATEGORY_ID_VERONICA);
    AddConstant('GOPHER_CATEGORY_ID_ASK',GOPHER_CATEGORY_ID_ASK);
    AddConstant('GOPHER_CATEGORY_ID_UNKNOWN',GOPHER_CATEGORY_ID_UNKNOWN);
    AddConstant('GOPHER_ATTRIBUTE_ID_ALL',GOPHER_ATTRIBUTE_ID_ALL);
    AddConstant('GOPHER_ATTRIBUTE_ID_ADMIN',GOPHER_ATTRIBUTE_ID_ADMIN);
    AddConstant('GOPHER_ATTRIBUTE_ID_MOD_DATE',GOPHER_ATTRIBUTE_ID_MOD_DATE);
    AddConstant('GOPHER_ATTRIBUTE_ID_TTL',GOPHER_ATTRIBUTE_ID_TTL);
    AddConstant('GOPHER_ATTRIBUTE_ID_SCORE',GOPHER_ATTRIBUTE_ID_SCORE);
    AddConstant('GOPHER_ATTRIBUTE_ID_RANGE',GOPHER_ATTRIBUTE_ID_RANGE);
    AddConstant('GOPHER_ATTRIBUTE_ID_SITE',GOPHER_ATTRIBUTE_ID_SITE);
    AddConstant('GOPHER_ATTRIBUTE_ID_ORG',GOPHER_ATTRIBUTE_ID_ORG);
    AddConstant('GOPHER_ATTRIBUTE_ID_LOCATION',GOPHER_ATTRIBUTE_ID_LOCATION);
    AddConstant('GOPHER_ATTRIBUTE_ID_GEOG',GOPHER_ATTRIBUTE_ID_GEOG);
    AddConstant('GOPHER_ATTRIBUTE_ID_TIMEZONE',GOPHER_ATTRIBUTE_ID_TIMEZONE);
    AddConstant('GOPHER_ATTRIBUTE_ID_PROVIDER',GOPHER_ATTRIBUTE_ID_PROVIDER);
    AddConstant('GOPHER_ATTRIBUTE_ID_VERSION',GOPHER_ATTRIBUTE_ID_VERSION);
    AddConstant('GOPHER_ATTRIBUTE_ID_ABSTRACT',GOPHER_ATTRIBUTE_ID_ABSTRACT);
    AddConstant('GOPHER_ATTRIBUTE_ID_VIEW',GOPHER_ATTRIBUTE_ID_VIEW);
    AddConstant('GOPHER_ATTRIBUTE_ID_TREEWALK',GOPHER_ATTRIBUTE_ID_TREEWALK);
    AddConstant('GOPHER_ATTRIBUTE_ID_UNKNOWN',GOPHER_ATTRIBUTE_ID_UNKNOWN);
    AddConstant('HTTP_MAJOR_VERSION',HTTP_MAJOR_VERSION);
    AddConstant('HTTP_MINOR_VERSION',HTTP_MINOR_VERSION);
    AddConstant('HTTP_VERSION',HTTP_VERSION);
    AddConstant('HTTP_QUERY_MIME_VERSION',HTTP_QUERY_MIME_VERSION);
    AddConstant('HTTP_QUERY_CONTENT_TYPE',HTTP_QUERY_CONTENT_TYPE);
    AddConstant('HTTP_QUERY_CONTENT_TRANSFER_ENCODING',HTTP_QUERY_CONTENT_TRANSFER_ENCODING);
    AddConstant('HTTP_QUERY_CONTENT_ID',HTTP_QUERY_CONTENT_ID);
    AddConstant('HTTP_QUERY_CONTENT_DESCRIPTION',HTTP_QUERY_CONTENT_DESCRIPTION);
    AddConstant('HTTP_QUERY_CONTENT_LENGTH',HTTP_QUERY_CONTENT_LENGTH);
    AddConstant('HTTP_QUERY_CONTENT_LANGUAGE',HTTP_QUERY_CONTENT_LANGUAGE);
    AddConstant('HTTP_QUERY_ALLOW',HTTP_QUERY_ALLOW);
    AddConstant('HTTP_QUERY_PUBLIC',HTTP_QUERY_PUBLIC);
    AddConstant('HTTP_QUERY_DATE',HTTP_QUERY_DATE);
    AddConstant('HTTP_QUERY_EXPIRES',HTTP_QUERY_EXPIRES);
    AddConstant('HTTP_QUERY_LAST_MODIFIED',HTTP_QUERY_LAST_MODIFIED);
    AddConstant('HTTP_QUERY_MESSAGE_ID',HTTP_QUERY_MESSAGE_ID);
    AddConstant('HTTP_QUERY_URI',HTTP_QUERY_URI);
    AddConstant('HTTP_QUERY_DERIVED_FROM',HTTP_QUERY_DERIVED_FROM);
    AddConstant('HTTP_QUERY_COST',HTTP_QUERY_COST);
    AddConstant('HTTP_QUERY_LINK',HTTP_QUERY_LINK);
    AddConstant('HTTP_QUERY_PRAGMA',HTTP_QUERY_PRAGMA);
    AddConstant('HTTP_QUERY_VERSION',HTTP_QUERY_VERSION);
    AddConstant('HTTP_QUERY_STATUS_CODE',HTTP_QUERY_STATUS_CODE);
    AddConstant('HTTP_QUERY_STATUS_TEXT',HTTP_QUERY_STATUS_TEXT);
    AddConstant('HTTP_QUERY_RAW_HEADERS',HTTP_QUERY_RAW_HEADERS);
    AddConstant('HTTP_QUERY_RAW_HEADERS_CRLF',HTTP_QUERY_RAW_HEADERS_CRLF);
    AddConstant('HTTP_QUERY_CONNECTION',HTTP_QUERY_CONNECTION);
    AddConstant('HTTP_QUERY_ACCEPT',HTTP_QUERY_ACCEPT);
    AddConstant('HTTP_QUERY_ACCEPT_CHARSET',HTTP_QUERY_ACCEPT_CHARSET);
    AddConstant('HTTP_QUERY_ACCEPT_ENCODING',HTTP_QUERY_ACCEPT_ENCODING);
    AddConstant('HTTP_QUERY_ACCEPT_LANGUAGE',HTTP_QUERY_ACCEPT_LANGUAGE);
    AddConstant('HTTP_QUERY_AUTHORIZATION',HTTP_QUERY_AUTHORIZATION);
    AddConstant('HTTP_QUERY_CONTENT_ENCODING',HTTP_QUERY_CONTENT_ENCODING);
    AddConstant('HTTP_QUERY_FORWARDED',HTTP_QUERY_FORWARDED);
    AddConstant('HTTP_QUERY_FROM',HTTP_QUERY_FROM);
    AddConstant('HTTP_QUERY_IF_MODIFIED_SINCE',HTTP_QUERY_IF_MODIFIED_SINCE);
    AddConstant('HTTP_QUERY_LOCATION',HTTP_QUERY_LOCATION);
    AddConstant('HTTP_QUERY_ORIG_URI',HTTP_QUERY_ORIG_URI);
    AddConstant('HTTP_QUERY_REFERER',HTTP_QUERY_REFERER);
    AddConstant('HTTP_QUERY_RETRY_AFTER',HTTP_QUERY_RETRY_AFTER);
    AddConstant('HTTP_QUERY_SERVER',HTTP_QUERY_SERVER);
    AddConstant('HTTP_QUERY_TITLE',HTTP_QUERY_TITLE);
    AddConstant('HTTP_QUERY_USER_AGENT',HTTP_QUERY_USER_AGENT);
    AddConstant('HTTP_QUERY_WWW_AUTHENTICATE',HTTP_QUERY_WWW_AUTHENTICATE);
    AddConstant('HTTP_QUERY_PROXY_AUTHENTICATE',HTTP_QUERY_PROXY_AUTHENTICATE);
    AddConstant('HTTP_QUERY_ACCEPT_RANGES',HTTP_QUERY_ACCEPT_RANGES);
    AddConstant('HTTP_QUERY_SET_COOKIE',HTTP_QUERY_SET_COOKIE);
    AddConstant('HTTP_QUERY_COOKIE',HTTP_QUERY_COOKIE);
    AddConstant('HTTP_QUERY_REQUEST_METHOD',HTTP_QUERY_REQUEST_METHOD);
    AddConstant('HTTP_QUERY_REFRESH',HTTP_QUERY_REFRESH);
    AddConstant('HTTP_QUERY_CONTENT_DISPOSITION',HTTP_QUERY_CONTENT_DISPOSITION);
    AddConstant('HTTP_QUERY_AGE',HTTP_QUERY_AGE);
    AddConstant('HTTP_QUERY_CACHE_CONTROL',HTTP_QUERY_CACHE_CONTROL);
    AddConstant('HTTP_QUERY_CONTENT_BASE',HTTP_QUERY_CONTENT_BASE);
    AddConstant('HTTP_QUERY_CONTENT_LOCATION',HTTP_QUERY_CONTENT_LOCATION);
    AddConstant('HTTP_QUERY_CONTENT_MD5',HTTP_QUERY_CONTENT_MD5);
    AddConstant('HTTP_QUERY_CONTENT_RANGE',HTTP_QUERY_CONTENT_RANGE);
    AddConstant('HTTP_QUERY_ETAG',HTTP_QUERY_ETAG);
    AddConstant('HTTP_QUERY_HOST',HTTP_QUERY_HOST);
    AddConstant('HTTP_QUERY_IF_MATCH',HTTP_QUERY_IF_MATCH);
    AddConstant('HTTP_QUERY_IF_NONE_MATCH',HTTP_QUERY_IF_NONE_MATCH);
    AddConstant('HTTP_QUERY_IF_RANGE',HTTP_QUERY_IF_RANGE);
    AddConstant('HTTP_QUERY_IF_UNMODIFIED_SINCE',HTTP_QUERY_IF_UNMODIFIED_SINCE);
    AddConstant('HTTP_QUERY_MAX_FORWARDS',HTTP_QUERY_MAX_FORWARDS);
    AddConstant('HTTP_QUERY_PROXY_AUTHORIZATION',HTTP_QUERY_PROXY_AUTHORIZATION);
    AddConstant('HTTP_QUERY_RANGE',HTTP_QUERY_RANGE);
    AddConstant('HTTP_QUERY_TRANSFER_ENCODING',HTTP_QUERY_TRANSFER_ENCODING);
    AddConstant('HTTP_QUERY_UPGRADE',HTTP_QUERY_UPGRADE);
    AddConstant('HTTP_QUERY_VARY',HTTP_QUERY_VARY);
    AddConstant('HTTP_QUERY_VIA',HTTP_QUERY_VIA);
    AddConstant('HTTP_QUERY_WARNING',HTTP_QUERY_WARNING);
    AddConstant('HTTP_QUERY_MAX',HTTP_QUERY_MAX);
    AddConstant('HTTP_QUERY_CUSTOM',HTTP_QUERY_CUSTOM);
    AddConstant('HTTP_QUERY_FLAG_REQUEST_HEADERS',HTTP_QUERY_FLAG_REQUEST_HEADERS);
    AddConstant('HTTP_QUERY_FLAG_SYSTEMTIME',HTTP_QUERY_FLAG_SYSTEMTIME);
    AddConstant('HTTP_QUERY_FLAG_NUMBER',HTTP_QUERY_FLAG_NUMBER);
    AddConstant('HTTP_QUERY_FLAG_COALESCE',HTTP_QUERY_FLAG_COALESCE);
    AddConstant('HTTP_QUERY_MODIFIER_FLAGS_MASK',HTTP_QUERY_MODIFIER_FLAGS_MASK);
    AddConstant('HTTP_QUERY_HEADER_MASK',HTTP_QUERY_HEADER_MASK);
    AddConstant('HTTP_STATUS_CONTINUE',HTTP_STATUS_CONTINUE);
    AddConstant('HTTP_STATUS_SWITCH_PROTOCOLS',HTTP_STATUS_SWITCH_PROTOCOLS);
    AddConstant('HTTP_STATUS_OK',HTTP_STATUS_OK);
    AddConstant('HTTP_STATUS_CREATED',HTTP_STATUS_CREATED);
    AddConstant('HTTP_STATUS_ACCEPTED',HTTP_STATUS_ACCEPTED);
    AddConstant('HTTP_STATUS_PARTIAL',HTTP_STATUS_PARTIAL);
    AddConstant('HTTP_STATUS_NO_CONTENT',HTTP_STATUS_NO_CONTENT);
    AddConstant('HTTP_STATUS_RESET_CONTENT',HTTP_STATUS_RESET_CONTENT);
    AddConstant('HTTP_STATUS_PARTIAL_CONTENT',HTTP_STATUS_PARTIAL_CONTENT);
    AddConstant('HTTP_STATUS_AMBIGUOUS',HTTP_STATUS_AMBIGUOUS);
    AddConstant('HTTP_STATUS_MOVED',HTTP_STATUS_MOVED);
    AddConstant('HTTP_STATUS_REDIRECT',HTTP_STATUS_REDIRECT);
    AddConstant('HTTP_STATUS_REDIRECT_METHOD',HTTP_STATUS_REDIRECT_METHOD);
    AddConstant('HTTP_STATUS_NOT_MODIFIED',HTTP_STATUS_NOT_MODIFIED);
    AddConstant('HTTP_STATUS_USE_PROXY',HTTP_STATUS_USE_PROXY);
    AddConstant('HTTP_STATUS_REDIRECT_KEEP_VERB',HTTP_STATUS_REDIRECT_KEEP_VERB);
    AddConstant('HTTP_STATUS_BAD_REQUEST',HTTP_STATUS_BAD_REQUEST);
    AddConstant('HTTP_STATUS_DENIED',HTTP_STATUS_DENIED);
    AddConstant('HTTP_STATUS_PAYMENT_REQ',HTTP_STATUS_PAYMENT_REQ);
    AddConstant('HTTP_STATUS_FORBIDDEN',HTTP_STATUS_FORBIDDEN);
    AddConstant('HTTP_STATUS_NOT_FOUND',HTTP_STATUS_NOT_FOUND);
    AddConstant('HTTP_STATUS_BAD_METHOD',HTTP_STATUS_BAD_METHOD);
    AddConstant('HTTP_STATUS_NONE_ACCEPTABLE',HTTP_STATUS_NONE_ACCEPTABLE);
    AddConstant('HTTP_STATUS_PROXY_AUTH_REQ',HTTP_STATUS_PROXY_AUTH_REQ);
    AddConstant('HTTP_STATUS_REQUEST_TIMEOUT',HTTP_STATUS_REQUEST_TIMEOUT);
    AddConstant('HTTP_STATUS_CONFLICT',HTTP_STATUS_CONFLICT);
    AddConstant('HTTP_STATUS_GONE',HTTP_STATUS_GONE);
    AddConstant('HTTP_STATUS_AUTH_REFUSED',HTTP_STATUS_AUTH_REFUSED);
    AddConstant('HTTP_STATUS_PRECOND_FAILED',HTTP_STATUS_PRECOND_FAILED);
    AddConstant('HTTP_STATUS_REQUEST_TOO_LARGE',HTTP_STATUS_REQUEST_TOO_LARGE);
    AddConstant('HTTP_STATUS_URI_TOO_LONG',HTTP_STATUS_URI_TOO_LONG);
    AddConstant('HTTP_STATUS_UNSUPPORTED_MEDIA',HTTP_STATUS_UNSUPPORTED_MEDIA);
    AddConstant('HTTP_STATUS_SERVER_ERROR',HTTP_STATUS_SERVER_ERROR);
    AddConstant('HTTP_STATUS_NOT_SUPPORTED',HTTP_STATUS_NOT_SUPPORTED);
    AddConstant('HTTP_STATUS_BAD_GATEWAY',HTTP_STATUS_BAD_GATEWAY);
    AddConstant('HTTP_STATUS_SERVICE_UNAVAIL',HTTP_STATUS_SERVICE_UNAVAIL);
    AddConstant('HTTP_STATUS_GATEWAY_TIMEOUT',HTTP_STATUS_GATEWAY_TIMEOUT);
    AddConstant('HTTP_STATUS_VERSION_NOT_SUP',HTTP_STATUS_VERSION_NOT_SUP);
    AddConstant('HTTP_STATUS_FIRST',HTTP_STATUS_FIRST);
    AddConstant('HTTP_STATUS_LAST',HTTP_STATUS_LAST);
    AddConstant('HTTP_ADDREQ_INDEX_MASK',HTTP_ADDREQ_INDEX_MASK);
    AddConstant('HTTP_ADDREQ_FLAGS_MASK',HTTP_ADDREQ_FLAGS_MASK);
    AddConstant('HTTP_ADDREQ_FLAG_ADD_IF_NEW',HTTP_ADDREQ_FLAG_ADD_IF_NEW);
    AddConstant('HTTP_ADDREQ_FLAG_ADD',HTTP_ADDREQ_FLAG_ADD);
    AddConstant('HTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA',HTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA);
    AddConstant('HTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON',HTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON);
    AddConstant('HTTP_ADDREQ_FLAG_COALESCE',HTTP_ADDREQ_FLAG_COALESCE);
    AddConstant('HTTP_ADDREQ_FLAG_REPLACE',HTTP_ADDREQ_FLAG_REPLACE);
    AddConstant('HSR_ASYNC',HSR_ASYNC);
    AddConstant('HSR_SYNC',HSR_SYNC);
    AddConstant('HSR_USE_CONTEXT',HSR_USE_CONTEXT);
    AddConstant('HSR_INITIATE',HSR_INITIATE);
    AddConstant('HSR_DOWNLOAD',HSR_DOWNLOAD);
    AddConstant('HSR_CHUNKED',HSR_CHUNKED);
    AddConstant('FLAGS_ERROR_UI_FILTER_FOR_ERRORS',FLAGS_ERROR_UI_FILTER_FOR_ERRORS);
    AddConstant('FLAGS_ERROR_UI_FLAGS_CHANGE_OPTIONS',FLAGS_ERROR_UI_FLAGS_CHANGE_OPTIONS);
    AddConstant('FLAGS_ERROR_UI_FLAGS_GENERATE_DATA',FLAGS_ERROR_UI_FLAGS_GENERATE_DATA);
    AddConstant('FLAGS_ERROR_UI_FLAGS_NO_UI',FLAGS_ERROR_UI_FLAGS_NO_UI);
    AddConstant('FLAGS_ERROR_UI_SERIALIZE_DIALOGS',FLAGS_ERROR_UI_SERIALIZE_DIALOGS);
    AddConstant('INTERNET_ERROR_BASE',INTERNET_ERROR_BASE);
    AddConstant('ERROR_INTERNET_OUT_OF_HANDLES',ERROR_INTERNET_OUT_OF_HANDLES);
    AddConstant('ERROR_INTERNET_TIMEOUT',ERROR_INTERNET_TIMEOUT);
    AddConstant('ERROR_INTERNET_EXTENDED_ERROR',ERROR_INTERNET_EXTENDED_ERROR);
    AddConstant('ERROR_INTERNET_INTERNAL_ERROR',ERROR_INTERNET_INTERNAL_ERROR);
    AddConstant('ERROR_INTERNET_INVALID_URL',ERROR_INTERNET_INVALID_URL);
    AddConstant('ERROR_INTERNET_UNRECOGNIZED_SCHEME',ERROR_INTERNET_UNRECOGNIZED_SCHEME);
    AddConstant('ERROR_INTERNET_NAME_NOT_RESOLVED',ERROR_INTERNET_NAME_NOT_RESOLVED);
    AddConstant('ERROR_INTERNET_PROTOCOL_NOT_FOUND',ERROR_INTERNET_PROTOCOL_NOT_FOUND);
    AddConstant('ERROR_INTERNET_INVALID_OPTION',ERROR_INTERNET_INVALID_OPTION);
    AddConstant('ERROR_INTERNET_BAD_OPTION_LENGTH',ERROR_INTERNET_BAD_OPTION_LENGTH);
    AddConstant('ERROR_INTERNET_OPTION_NOT_SETTABLE',ERROR_INTERNET_OPTION_NOT_SETTABLE);
    AddConstant('ERROR_INTERNET_SHUTDOWN',ERROR_INTERNET_SHUTDOWN);
    AddConstant('ERROR_INTERNET_INCORRECT_USER_NAME',ERROR_INTERNET_INCORRECT_USER_NAME);
    AddConstant('ERROR_INTERNET_INCORRECT_PASSWORD',ERROR_INTERNET_INCORRECT_PASSWORD);
    AddConstant('ERROR_INTERNET_LOGIN_FAILURE',ERROR_INTERNET_LOGIN_FAILURE);
    AddConstant('ERROR_INTERNET_INVALID_OPERATION',ERROR_INTERNET_INVALID_OPERATION);
    AddConstant('ERROR_INTERNET_OPERATION_CANCELLED',ERROR_INTERNET_OPERATION_CANCELLED);
    AddConstant('ERROR_INTERNET_INCORRECT_HANDLE_TYPE',ERROR_INTERNET_INCORRECT_HANDLE_TYPE);
    AddConstant('ERROR_INTERNET_INCORRECT_HANDLE_STATE',ERROR_INTERNET_INCORRECT_HANDLE_STATE);
    AddConstant('ERROR_INTERNET_NOT_PROXY_REQUEST',ERROR_INTERNET_NOT_PROXY_REQUEST);
    AddConstant('ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND',ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND);
    AddConstant('ERROR_INTERNET_BAD_REGISTRY_PARAMETER',ERROR_INTERNET_BAD_REGISTRY_PARAMETER);
    AddConstant('ERROR_INTERNET_NO_DIRECT_ACCESS',ERROR_INTERNET_NO_DIRECT_ACCESS);
    AddConstant('ERROR_INTERNET_NO_CONTEXT',ERROR_INTERNET_NO_CONTEXT);
    AddConstant('ERROR_INTERNET_NO_CALLBACK',ERROR_INTERNET_NO_CALLBACK);
    AddConstant('ERROR_INTERNET_REQUEST_PENDING',ERROR_INTERNET_REQUEST_PENDING);
    AddConstant('ERROR_INTERNET_INCORRECT_FORMAT',ERROR_INTERNET_INCORRECT_FORMAT);
    AddConstant('ERROR_INTERNET_ITEM_NOT_FOUND',ERROR_INTERNET_ITEM_NOT_FOUND);
    AddConstant('ERROR_INTERNET_CANNOT_CONNECT',ERROR_INTERNET_CANNOT_CONNECT);
    AddConstant('ERROR_INTERNET_CONNECTION_ABORTED',ERROR_INTERNET_CONNECTION_ABORTED);
    AddConstant('ERROR_INTERNET_CONNECTION_RESET',ERROR_INTERNET_CONNECTION_RESET);
    AddConstant('ERROR_INTERNET_FORCE_RETRY',ERROR_INTERNET_FORCE_RETRY);
    AddConstant('ERROR_INTERNET_INVALID_PROXY_REQUEST',ERROR_INTERNET_INVALID_PROXY_REQUEST);
    AddConstant('ERROR_INTERNET_HANDLE_EXISTS',ERROR_INTERNET_HANDLE_EXISTS);
    AddConstant('ERROR_INTERNET_SEC_CERT_DATE_INVALID',ERROR_INTERNET_SEC_CERT_DATE_INVALID);
    AddConstant('ERROR_INTERNET_SEC_CERT_CN_INVALID',ERROR_INTERNET_SEC_CERT_CN_INVALID);
    AddConstant('ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR',ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR);
    AddConstant('ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR',ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR);
    AddConstant('ERROR_INTERNET_MIXED_SECURITY',ERROR_INTERNET_MIXED_SECURITY);
    AddConstant('ERROR_INTERNET_CHG_POST_IS_NON_SECURE',ERROR_INTERNET_CHG_POST_IS_NON_SECURE);
    AddConstant('ERROR_INTERNET_POST_IS_NON_SECURE',ERROR_INTERNET_POST_IS_NON_SECURE);
    AddConstant('ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED',ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED);
    AddConstant('ERROR_INTERNET_INVALID_CA',ERROR_INTERNET_INVALID_CA);
    AddConstant('ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP',ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP);
    AddConstant('ERROR_INTERNET_ASYNC_THREAD_FAILED',ERROR_INTERNET_ASYNC_THREAD_FAILED);
    AddConstant('ERROR_INTERNET_REDIRECT_SCHEME_CHANGE',ERROR_INTERNET_REDIRECT_SCHEME_CHANGE);
    AddConstant('ERROR_INTERNET_DIALOG_PENDING',ERROR_INTERNET_DIALOG_PENDING);
    AddConstant('ERROR_INTERNET_RETRY_DIALOG',ERROR_INTERNET_RETRY_DIALOG);
    AddConstant('ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR',ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR);
    AddConstant('ERROR_INTERNET_INSERT_CDROM',ERROR_INTERNET_INSERT_CDROM);
    AddConstant('ERROR_INTERNET_SEC_CERT_REV_FAILED',ERROR_INTERNET_SEC_CERT_REV_FAILED);
    AddConstant('ERROR_FTP_TRANSFER_IN_PROGRESS',ERROR_FTP_TRANSFER_IN_PROGRESS);
    AddConstant('ERROR_FTP_DROPPED',ERROR_FTP_DROPPED);
    AddConstant('ERROR_FTP_NO_PASSIVE_MODE',ERROR_FTP_NO_PASSIVE_MODE);
    AddConstant('ERROR_GOPHER_PROTOCOL_ERROR',ERROR_GOPHER_PROTOCOL_ERROR);
    AddConstant('ERROR_GOPHER_NOT_FILE',ERROR_GOPHER_NOT_FILE);
    AddConstant('ERROR_GOPHER_DATA_ERROR',ERROR_GOPHER_DATA_ERROR);
    AddConstant('ERROR_GOPHER_END_OF_DATA',ERROR_GOPHER_END_OF_DATA);
    AddConstant('ERROR_GOPHER_INVALID_LOCATOR',ERROR_GOPHER_INVALID_LOCATOR);
    AddConstant('ERROR_GOPHER_INCORRECT_LOCATOR_TYPE',ERROR_GOPHER_INCORRECT_LOCATOR_TYPE);
    AddConstant('ERROR_GOPHER_NOT_GOPHER_PLUS',ERROR_GOPHER_NOT_GOPHER_PLUS);
    AddConstant('ERROR_GOPHER_ATTRIBUTE_NOT_FOUND',ERROR_GOPHER_ATTRIBUTE_NOT_FOUND);
    AddConstant('ERROR_GOPHER_UNKNOWN_LOCATOR',ERROR_GOPHER_UNKNOWN_LOCATOR);
    AddConstant('ERROR_HTTP_HEADER_NOT_FOUND',ERROR_HTTP_HEADER_NOT_FOUND);
    AddConstant('ERROR_HTTP_DOWNLEVEL_SERVER',ERROR_HTTP_DOWNLEVEL_SERVER);
    AddConstant('ERROR_HTTP_INVALID_SERVER_RESPONSE',ERROR_HTTP_INVALID_SERVER_RESPONSE);
    AddConstant('ERROR_HTTP_INVALID_HEADER',ERROR_HTTP_INVALID_HEADER);
    AddConstant('ERROR_HTTP_INVALID_QUERY_REQUEST',ERROR_HTTP_INVALID_QUERY_REQUEST);
    AddConstant('ERROR_HTTP_HEADER_ALREADY_EXISTS',ERROR_HTTP_HEADER_ALREADY_EXISTS);
    AddConstant('ERROR_HTTP_REDIRECT_FAILED',ERROR_HTTP_REDIRECT_FAILED);
    AddConstant('ERROR_HTTP_NOT_REDIRECTED',ERROR_HTTP_NOT_REDIRECTED);
    AddConstant('ERROR_HTTP_COOKIE_NEEDS_CONFIRMATION',ERROR_HTTP_COOKIE_NEEDS_CONFIRMATION);
    AddConstant('ERROR_HTTP_COOKIE_DECLINED',ERROR_HTTP_COOKIE_DECLINED);
    AddConstant('ERROR_HTTP_REDIRECT_NEEDS_CONFIRMATION',ERROR_HTTP_REDIRECT_NEEDS_CONFIRMATION);
    AddConstant('ERROR_INTERNET_SECURITY_CHANNEL_ERROR',ERROR_INTERNET_SECURITY_CHANNEL_ERROR);
    AddConstant('ERROR_INTERNET_UNABLE_TO_CACHE_FILE',ERROR_INTERNET_UNABLE_TO_CACHE_FILE);
    AddConstant('ERROR_INTERNET_TCPIP_NOT_INSTALLED',ERROR_INTERNET_TCPIP_NOT_INSTALLED);
    AddConstant('ERROR_INTERNET_DISCONNECTED',ERROR_INTERNET_DISCONNECTED);
    AddConstant('ERROR_INTERNET_SERVER_UNREACHABLE',ERROR_INTERNET_SERVER_UNREACHABLE);
    AddConstant('ERROR_INTERNET_PROXY_SERVER_UNREACHABLE',ERROR_INTERNET_PROXY_SERVER_UNREACHABLE);
    AddConstant('ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT',ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT);
    AddConstant('ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT',ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT);
    AddConstant('ERROR_INTERNET_SEC_INVALID_CERT',ERROR_INTERNET_SEC_INVALID_CERT);
    AddConstant('ERROR_INTERNET_SEC_CERT_REVOKED',ERROR_INTERNET_SEC_CERT_REVOKED);
    AddConstant('ERROR_INTERNET_FAILED_DUETOSECURITYCHECK',ERROR_INTERNET_FAILED_DUETOSECURITYCHECK);
    AddConstant('INTERNET_ERROR_LAST',INTERNET_ERROR_LAST);
    AddConstant('NORMAL_CACHE_ENTRY',NORMAL_CACHE_ENTRY);
    AddConstant('STABLE_CACHE_ENTRY',STABLE_CACHE_ENTRY);
    AddConstant('STICKY_CACHE_ENTRY',STICKY_CACHE_ENTRY);
    AddConstant('COOKIE_CACHE_ENTRY',COOKIE_CACHE_ENTRY);
    AddConstant('URLHISTORY_CACHE_ENTRY',URLHISTORY_CACHE_ENTRY);
    AddConstant('TRACK_OFFLINE_CACHE_ENTRY',TRACK_OFFLINE_CACHE_ENTRY);
    AddConstant('TRACK_ONLINE_CACHE_ENTRY',TRACK_ONLINE_CACHE_ENTRY);
    AddConstant('SPARSE_CACHE_ENTRY',SPARSE_CACHE_ENTRY);
    AddConstant('OCX_CACHE_ENTRY',OCX_CACHE_ENTRY);
    AddConstant('URLCACHE_FIND_DEFAULT_FILTER',URLCACHE_FIND_DEFAULT_FILTER);
    AddConstant('CACHE_ENTRY_ATTRIBUTE_FC',CACHE_ENTRY_ATTRIBUTE_FC);
    AddConstant('CACHE_ENTRY_HITRATE_FC',CACHE_ENTRY_HITRATE_FC);
    AddConstant('CACHE_ENTRY_MODTIME_FC',CACHE_ENTRY_MODTIME_FC);
    AddConstant('CACHE_ENTRY_EXPTIME_FC',CACHE_ENTRY_EXPTIME_FC);
    AddConstant('CACHE_ENTRY_ACCTIME_FC',CACHE_ENTRY_ACCTIME_FC);
    AddConstant('CACHE_ENTRY_SYNCTIME_FC',CACHE_ENTRY_SYNCTIME_FC);
    AddConstant('CACHE_ENTRY_HEADERINFO_FC',CACHE_ENTRY_HEADERINFO_FC);
    AddConstant('CACHE_ENTRY_EXEMPT_DELTA_FC',CACHE_ENTRY_EXEMPT_DELTA_FC);
    AddConstant('GROUPNAME_MAX_LENGTH',GROUPNAME_MAX_LENGTH);
    AddConstant('GROUP_OWNER_STORAGE_SIZE',GROUP_OWNER_STORAGE_SIZE);
    AddConstant('INTERNET_CACHE_GROUP_ADD',INTERNET_CACHE_GROUP_ADD);
    AddConstant('INTERNET_CACHE_GROUP_REMOVE',INTERNET_CACHE_GROUP_REMOVE);
    AddConstant('INTERNET_DIAL_UNATTENDED',INTERNET_DIAL_UNATTENDED);
    AddConstant('INTERENT_GOONLINE_REFRESH',INTERENT_GOONLINE_REFRESH);
    AddConstant('INTERENT_GOONLINE_MASK',INTERENT_GOONLINE_MASK);
    AddConstant('INTERNET_AUTODIAL_FORCE_ONLINE',INTERNET_AUTODIAL_FORCE_ONLINE);
    AddConstant('INTERNET_AUTODIAL_FORCE_UNATTENDED',INTERNET_AUTODIAL_FORCE_UNATTENDED);
    AddConstant('INTERNET_AUTODIAL_FAILIFSECURITYCHECK',INTERNET_AUTODIAL_FAILIFSECURITYCHECK);
    AddConstant('INTERNET_AUTODIAL_FLAGS_MASK',INTERNET_AUTODIAL_FLAGS_MASK);
    AddConstant('INTERNET_CONNECTION_MODEM',INTERNET_CONNECTION_MODEM);
    AddConstant('INTERNET_CONNECTION_LAN',INTERNET_CONNECTION_LAN);
    AddConstant('INTERNET_CONNECTION_PROXY',INTERNET_CONNECTION_PROXY);
    AddConstant('INTERNET_CONNECTION_MODEM_BUSY',INTERNET_CONNECTION_MODEM_BUSY);
    AddConstant('INTERNET_RAS_INSTALLED',INTERNET_RAS_INSTALLED);
    AddConstant('INTERNET_CONNECTION_OFFLINE',INTERNET_CONNECTION_OFFLINE);
    AddConstant('INTERNET_CONNECTION_CONFIGURED',INTERNET_CONNECTION_CONFIGURED);
    AddConstant('INTERNET_CUSTOMDIAL_CONNECT',INTERNET_CUSTOMDIAL_CONNECT);
    AddConstant('INTERNET_CUSTOMDIAL_UNATTENDED',INTERNET_CUSTOMDIAL_UNATTENDED);
    AddConstant('INTERNET_CUSTOMDIAL_DISCONNECT',INTERNET_CUSTOMDIAL_DISCONNECT);
    AddConstant('INTERNET_CUSTOMDIAL_SHOWOFFLINE',INTERNET_CUSTOMDIAL_SHOWOFFLINE);
    AddConstant('INTERNET_CUSTOMDIAL_SAFE_FOR_UNATTENDED',INTERNET_CUSTOMDIAL_SAFE_FOR_UNATTENDED);
    AddConstant('INTERNET_CUSTOMDIAL_WILL_SUPPLY_STATE',INTERNET_CUSTOMDIAL_WILL_SUPPLY_STATE);
    AddConstant('INTERNET_CUSTOMDIAL_CAN_HANGUP',INTERNET_CUSTOMDIAL_CAN_HANGUP);
  end;
end;

class function TatWinInetLibrary.LibraryName: string;
begin
  result := 'WinInet';
end;

initialization
  RegisterScripterLibrary(TatWinInetLibrary, True);

{$WARNINGS ON}

end.

