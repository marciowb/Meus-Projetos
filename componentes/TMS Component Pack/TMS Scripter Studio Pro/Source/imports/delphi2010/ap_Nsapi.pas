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
unit ap_Nsapi;

interface

uses
  Windows,
  WinSock,
  Nsapi,
  Variants,
  ap_WinSock,
  atScript;

{$WARNINGS OFF}

type
  TatNsapiLibrary = class(TatScripterLibrary)
    procedure __strcasecmp(AMachine: TatVirtualMachine);
    procedure __strncasecmp(AMachine: TatVirtualMachine);
    procedure __util_strcasecmp(AMachine: TatVirtualMachine);
    procedure __util_strncasecmp(AMachine: TatVirtualMachine);
    procedure __system_version(AMachine: TatVirtualMachine);
    procedure __MAGNUS_VERSION_STRING(AMachine: TatVirtualMachine);
    procedure __server_fasttrack(AMachine: TatVirtualMachine);
    procedure __server_enterprise(AMachine: TatVirtualMachine);
    procedure __system_version_set(AMachine: TatVirtualMachine);
    procedure __STRDUP(AMachine: TatVirtualMachine);
    procedure __system_strdup(AMachine: TatVirtualMachine);
    procedure __PERM_STRDUP(AMachine: TatVirtualMachine);
    procedure __system_strdup_perm(AMachine: TatVirtualMachine);
    procedure __pool_enabled(AMachine: TatVirtualMachine);
    procedure __sem_init(AMachine: TatVirtualMachine);
    procedure __sem_terminate(AMachine: TatVirtualMachine);
    procedure __sem_grab(AMachine: TatVirtualMachine);
    procedure __sem_tgrab(AMachine: TatVirtualMachine);
    procedure __sem_release(AMachine: TatVirtualMachine);
    procedure __CONVERT_TO_PRINTABLE_FORMAT(AMachine: TatVirtualMachine);
    procedure __CONVERT_TO_NATIVE_FS(AMachine: TatVirtualMachine);
    procedure __system_chdir(AMachine: TatVirtualMachine);
    procedure __system_stat(AMachine: TatVirtualMachine);
    procedure __system_rename(AMachine: TatVirtualMachine);
    procedure __system_unlink(AMachine: TatVirtualMachine);
    procedure __system_nocoredumps(AMachine: TatVirtualMachine);
    procedure __system_winsockerr(AMachine: TatVirtualMachine);
    procedure __system_winerr(AMachine: TatVirtualMachine);
    procedure __file_notfound(AMachine: TatVirtualMachine);
    procedure __system_errmsg(AMachine: TatVirtualMachine);
    procedure __system_errmsg_fn(AMachine: TatVirtualMachine);
    procedure __file_unix2local(AMachine: TatVirtualMachine);
    procedure __dir_create(AMachine: TatVirtualMachine);
    procedure __dir_remove(AMachine: TatVirtualMachine);
    procedure __dir_create_all(AMachine: TatVirtualMachine);
    procedure __net_socket(AMachine: TatVirtualMachine);
    procedure __net_listen(AMachine: TatVirtualMachine);
    procedure __net_create_listener(AMachine: TatVirtualMachine);
    procedure __net_getpeername(AMachine: TatVirtualMachine);
    procedure __net_close(AMachine: TatVirtualMachine);
    procedure __net_bind(AMachine: TatVirtualMachine);
    procedure __net_read(AMachine: TatVirtualMachine);
    procedure __net_write(AMachine: TatVirtualMachine);
    procedure __net_isalive(AMachine: TatVirtualMachine);
    procedure __net_ip2host(AMachine: TatVirtualMachine);
    procedure __CINFO_HASH(AMachine: TatVirtualMachine);
    procedure __cinfo_init(AMachine: TatVirtualMachine);
    procedure __cinfo_terminate(AMachine: TatVirtualMachine);
    procedure __cinfo_merge(AMachine: TatVirtualMachine);
    procedure __ereport_terminate(AMachine: TatVirtualMachine);
    procedure __shexp_valid(AMachine: TatVirtualMachine);
    procedure __shexp_match(AMachine: TatVirtualMachine);
    procedure __shexp_cmp(AMachine: TatVirtualMachine);
    procedure __shexp_casecmp(AMachine: TatVirtualMachine);
    procedure __systhread_yield(AMachine: TatVirtualMachine);
    procedure __systhread_sleep(AMachine: TatVirtualMachine);
    procedure __systhread_init(AMachine: TatVirtualMachine);
    procedure __systhread_timerset(AMachine: TatVirtualMachine);
    procedure __systhread_newkey(AMachine: TatVirtualMachine);
    procedure __child_fork(AMachine: TatVirtualMachine);
    procedure __util_env_str(AMachine: TatVirtualMachine);
    procedure __util_hostname(AMachine: TatVirtualMachine);
    procedure __util_chdir2path(AMachine: TatVirtualMachine);
    procedure __util_is_mozilla(AMachine: TatVirtualMachine);
    procedure __util_is_url(AMachine: TatVirtualMachine);
    procedure __util_later_than(AMachine: TatVirtualMachine);
    procedure __util_time_equal(AMachine: TatVirtualMachine);
    procedure __util_str_time_equal(AMachine: TatVirtualMachine);
    procedure __util_uri_is_evil(AMachine: TatVirtualMachine);
    procedure __util_uri_parse(AMachine: TatVirtualMachine);
    procedure __util_uri_unescape(AMachine: TatVirtualMachine);
    procedure __util_uri_escape(AMachine: TatVirtualMachine);
    procedure __util_url_escape(AMachine: TatVirtualMachine);
    procedure __util_sh_escape(AMachine: TatVirtualMachine);
    procedure __util_mime_separator(AMachine: TatVirtualMachine);
    procedure __util_itoa(AMachine: TatVirtualMachine);
    procedure __util_delete_directory(AMachine: TatVirtualMachine);
    procedure __util_strftime(AMachine: TatVirtualMachine);
    procedure ___ntverify_parameter(AMachine: TatVirtualMachine);
    procedure __ClearConfigurationParameters(AMachine: TatVirtualMachine);
    procedure __GetProductKey(AMachine: TatVirtualMachine);
    procedure __pool_max(AMachine: TatVirtualMachine);
    procedure __pool_min(AMachine: TatVirtualMachine);
    procedure __pool_life(AMachine: TatVirtualMachine);
    procedure __pool_maxthreads(AMachine: TatVirtualMachine);
    procedure __pool_minthreads(AMachine: TatVirtualMachine);
    procedure __server_hostname(AMachine: TatVirtualMachine);
    procedure __root_object(AMachine: TatVirtualMachine);
    procedure __master_error_log(AMachine: TatVirtualMachine);
    procedure __server_root(AMachine: TatVirtualMachine);
    procedure __server_id(AMachine: TatVirtualMachine);
    procedure __conf_init(AMachine: TatVirtualMachine);
    procedure __conf_terminate(AMachine: TatVirtualMachine);
    procedure __GetDomainAddresses(AMachine: TatVirtualMachine);
    procedure __protocol_uri2url(AMachine: TatVirtualMachine);
    procedure __http_uri2url(AMachine: TatVirtualMachine);
    procedure __protocol_set_keepalive_timeout(AMachine: TatVirtualMachine);
    procedure __http_set_keepalive_timeout(AMachine: TatVirtualMachine);
    procedure __func_init(AMachine: TatVirtualMachine);
    procedure __NSstr2String(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TFileWrapper = class(TatRecordWrapper)
  private
    Ffh: THandle;
    Fflsem: Semaphore;
  public
    constructor Create(ARecord: TFile);
    function ObjToRec: TFile;
  published
    property fh: THandle read Ffh write Ffh;
    property flsem: Semaphore read Fflsem write Fflsem;
  end;
  
  TStatWrapper = class(TatRecordWrapper)
  private
    Fst_dev: Word;
    Fst_ino: Word;
    Fst_mode: Word;
    Fst_nlink: SmallInt;
    Fst_uid: SmallInt;
    Fst_gid: SmallInt;
    Fst_rdev: Word;
    Fst_size: Longint;
    Fst_atime: Longint;
    Fst_mtime: Longint;
    Fst_ctime: Longint;
  public
    constructor Create(ARecord: TStat);
    function ObjToRec: TStat;
  published
    property st_dev: Word read Fst_dev write Fst_dev;
    property st_ino: Word read Fst_ino write Fst_ino;
    property st_mode: Word read Fst_mode write Fst_mode;
    property st_nlink: SmallInt read Fst_nlink write Fst_nlink;
    property st_uid: SmallInt read Fst_uid write Fst_uid;
    property st_gid: SmallInt read Fst_gid write Fst_gid;
    property st_rdev: Word read Fst_rdev write Fst_rdev;
    property st_size: Longint read Fst_size write Fst_size;
    property st_atime: Longint read Fst_atime write Fst_atime;
    property st_mtime: Longint read Fst_mtime write Fst_mtime;
    property st_ctime: Longint read Fst_ctime write Fst_ctime;
  end;
  
  TDirEntWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TDirEnt);
    function ObjToRec: TDirEnt;
  published
  end;
  
  TDirWrapper = class(TatRecordWrapper)
  private
    Fdp: THandle;
  public
    constructor Create(ARecord: TDir);
    function ObjToRec: TDir;
  published
    property dp: THandle read Fdp write Fdp;
  end;
  
  tmWrapper = class(TatRecordWrapper)
  private
    Ftm_sec: Integer;
    Ftm_min: Integer;
    Ftm_hour: Integer;
    Ftm_mday: Integer;
    Ftm_mon: Integer;
    Ftm_year: Integer;
    Ftm_wday: Integer;
    Ftm_yday: Integer;
    Ftm_isdst: Integer;
  public
    constructor Create(ARecord: tm);
    function ObjToRec: tm;
  published
    property tm_sec: Integer read Ftm_sec write Ftm_sec;
    property tm_min: Integer read Ftm_min write Ftm_min;
    property tm_hour: Integer read Ftm_hour write Ftm_hour;
    property tm_mday: Integer read Ftm_mday write Ftm_mday;
    property tm_mon: Integer read Ftm_mon write Ftm_mon;
    property tm_year: Integer read Ftm_year write Ftm_year;
    property tm_wday: Integer read Ftm_wday write Ftm_wday;
    property tm_yday: Integer read Ftm_yday write Ftm_yday;
    property tm_isdst: Integer read Ftm_isdst write Ftm_isdst;
  end;
  
  TPbParamWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TPbParam);
    function ObjToRec: TPbParam;
  published
  end;
  
  TPbEntryWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TPbEntry);
    function ObjToRec: TPbEntry;
  published
  end;
  
  TPblockWrapper = class(TatRecordWrapper)
  private
    Fhsize: Integer;
  public
    constructor Create(ARecord: TPblock);
    function ObjToRec: TPblock;
  published
    property hsize: Integer read Fhsize write Fhsize;
  end;
  
  TFileBufferWrapper = class(TatRecordWrapper)
  private
    Ffdmap: THandle;
    Flen: Integer;
    Fcursize: Integer;
    Fpos: Integer;
  public
    constructor Create(ARecord: TFileBuffer);
    function ObjToRec: TFileBuffer;
  published
    property fdmap: THandle read Ffdmap write Ffdmap;
    property len: Integer read Flen write Flen;
    property cursize: Integer read Fcursize write Fcursize;
    property pos: Integer read Fpos write Fpos;
  end;
  
  TNetBufWrapper = class(TatRecordWrapper)
  private
    Fsd: SYS_NETFD;
    Fpos: Integer;
    Fcursize: Integer;
    Fmaxsize: Integer;
    Frdtimeout: Integer;
  public
    constructor Create(ARecord: TNetBuf);
    function ObjToRec: TNetBuf;
  published
    property sd: SYS_NETFD read Fsd write Fsd;
    property pos: Integer read Fpos write Fpos;
    property cursize: Integer read Fcursize write Fcursize;
    property maxsize: Integer read Fmaxsize write Fmaxsize;
    property rdtimeout: Integer read Frdtimeout write Frdtimeout;
  end;
  
  TSessionWrapper = class(TatRecordWrapper)
  private
    Fcsd: SYS_NETFD;
    Fcsd_open: Integer;
  public
    constructor Create(ARecord: TSession);
    function ObjToRec: TSession;
  published
    property csd: SYS_NETFD read Fcsd write Fcsd;
    property csd_open: Integer read Fcsd_open write Fcsd_open;
  end;
  
  TCInfoWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TCInfo);
    function ObjToRec: TCInfo;
  published
  end;
  
  TShMemWrapper = class(TatRecordWrapper)
  private
    Ffdmap: THandle;
    Fsize: Integer;
  public
    constructor Create(ARecord: TShMem);
    function ObjToRec: TShMem;
  published
    property fdmap: THandle read Ffdmap write Ffdmap;
    property size: Integer read Fsize write Fsize;
  end;
  
  TMultipleDomainsWrapper = class(TatRecordWrapper)
  private
    Fsd: SYS_NETFD;
    Fthreads: Integer;
    FAddressNumber: Integer;
  public
    constructor Create(ARecord: TMultipleDomains);
    function ObjToRec: TMultipleDomains;
  published
    property sd: SYS_NETFD read Fsd write Fsd;
    property threads: Integer read Fthreads write Fthreads;
    property AddressNumber: Integer read FAddressNumber write FAddressNumber;
  end;
  
  TDaemonWrapper = class(TatRecordWrapper)
  private
    Fport: Integer;
    Fmaxprocs: Integer;
    Fminprocs: Integer;
    Fproclife: Integer;
    Fmaxthreads: Integer;
    Fminthreads: Integer;
  public
    constructor Create(ARecord: TDaemon);
    function ObjToRec: TDaemon;
  published
    property port: Integer read Fport write Fport;
    property maxprocs: Integer read Fmaxprocs write Fmaxprocs;
    property minprocs: Integer read Fminprocs write Fminprocs;
    property proclife: Integer read Fproclife write Fproclife;
    property maxthreads: Integer read Fmaxthreads write Fmaxthreads;
    property minthreads: Integer read Fminthreads write Fminthreads;
  end;
  
  TDirectiveWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TDirective);
    function ObjToRec: TDirective;
  published
  end;
  
  TDtableWrapper = class(TatRecordWrapper)
  private
    Fni: Integer;
  public
    constructor Create(ARecord: TDtable);
    function ObjToRec: TDtable;
  published
    property ni: Integer read Fni write Fni;
  end;
  
  THttpdObjectWrapper = class(TatRecordWrapper)
  private
    Fnd: Integer;
  public
    constructor Create(ARecord: THttpdObject);
    function ObjToRec: THttpdObject;
  published
    property nd: Integer read Fnd write Fnd;
  end;
  
  THttpdObjSetWrapper = class(TatRecordWrapper)
  private
    Fpos: Integer;
  public
    constructor Create(ARecord: THttpdObjSet);
    function ObjToRec: THttpdObjSet;
  published
    property pos: Integer read Fpos write Fpos;
  end;
  
  TConfGlobalVarsWrapper = class(TatRecordWrapper)
  private
    FVport: Integer;
    FVpool_max: Integer;
    FVpool_min: Integer;
    FVpool_life: Integer;
    FVpool_maxthreads: Integer;
    FVpool_minthreads: Integer;
  public
    constructor Create(ARecord: TConfGlobalVars);
    function ObjToRec: TConfGlobalVars;
  published
    property Vport: Integer read FVport write FVport;
    property Vpool_max: Integer read FVpool_max write FVpool_max;
    property Vpool_min: Integer read FVpool_min write FVpool_min;
    property Vpool_life: Integer read FVpool_life write FVpool_life;
    property Vpool_maxthreads: Integer read FVpool_maxthreads write FVpool_maxthreads;
    property Vpool_minthreads: Integer read FVpool_minthreads write FVpool_minthreads;
  end;
  
  TRequestWrapper = class(TatRecordWrapper)
  private
    Floadhdrs: Integer;
    Fsenthdrs: Integer;
    Faclstate: Integer;
    Facldirno: Integer;
    Frequest_is_cacheable: BOOL;
    Fdirective_is_cacheable: BOOL;
    Fcached_headers_len: Integer;
  public
    constructor Create(ARecord: TRequest);
    function ObjToRec: TRequest;
  published
    property loadhdrs: Integer read Floadhdrs write Floadhdrs;
    property senthdrs: Integer read Fsenthdrs write Fsenthdrs;
    property aclstate: Integer read Faclstate write Faclstate;
    property acldirno: Integer read Facldirno write Facldirno;
    property request_is_cacheable: BOOL read Frequest_is_cacheable write Frequest_is_cacheable;
    property directive_is_cacheable: BOOL read Fdirective_is_cacheable write Fdirective_is_cacheable;
    property cached_headers_len: Integer read Fcached_headers_len write Fcached_headers_len;
  end;
  
  TFuncStructWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TFuncStruct);
    function ObjToRec: TFuncStruct;
  published
  end;
  

implementation

constructor TFileWrapper.Create(ARecord: TFile);
begin
  inherited Create;
  Ffh := ARecord.fh;
  Fflsem := ARecord.flsem;
end;

function TFileWrapper.ObjToRec: TFile;
begin
  result.fh := Ffh;
  result.flsem := Fflsem;
end;

constructor TStatWrapper.Create(ARecord: TStat);
begin
  inherited Create;
  Fst_dev := ARecord.st_dev;
  Fst_ino := ARecord.st_ino;
  Fst_mode := ARecord.st_mode;
  Fst_nlink := ARecord.st_nlink;
  Fst_uid := ARecord.st_uid;
  Fst_gid := ARecord.st_gid;
  Fst_rdev := ARecord.st_rdev;
  Fst_size := ARecord.st_size;
  Fst_atime := ARecord.st_atime;
  Fst_mtime := ARecord.st_mtime;
  Fst_ctime := ARecord.st_ctime;
end;

function TStatWrapper.ObjToRec: TStat;
begin
  result.st_dev := Fst_dev;
  result.st_ino := Fst_ino;
  result.st_mode := Fst_mode;
  result.st_nlink := Fst_nlink;
  result.st_uid := Fst_uid;
  result.st_gid := Fst_gid;
  result.st_rdev := Fst_rdev;
  result.st_size := Fst_size;
  result.st_atime := Fst_atime;
  result.st_mtime := Fst_mtime;
  result.st_ctime := Fst_ctime;
end;

constructor TDirEntWrapper.Create(ARecord: TDirEnt);
begin
  inherited Create;
end;

function TDirEntWrapper.ObjToRec: TDirEnt;
begin
end;

constructor TDirWrapper.Create(ARecord: TDir);
begin
  inherited Create;
  Fdp := ARecord.dp;
end;

function TDirWrapper.ObjToRec: TDir;
begin
  result.dp := Fdp;
end;

constructor tmWrapper.Create(ARecord: tm);
begin
  inherited Create;
  Ftm_sec := ARecord.tm_sec;
  Ftm_min := ARecord.tm_min;
  Ftm_hour := ARecord.tm_hour;
  Ftm_mday := ARecord.tm_mday;
  Ftm_mon := ARecord.tm_mon;
  Ftm_year := ARecord.tm_year;
  Ftm_wday := ARecord.tm_wday;
  Ftm_yday := ARecord.tm_yday;
  Ftm_isdst := ARecord.tm_isdst;
end;

function tmWrapper.ObjToRec: tm;
begin
  result.tm_sec := Ftm_sec;
  result.tm_min := Ftm_min;
  result.tm_hour := Ftm_hour;
  result.tm_mday := Ftm_mday;
  result.tm_mon := Ftm_mon;
  result.tm_year := Ftm_year;
  result.tm_wday := Ftm_wday;
  result.tm_yday := Ftm_yday;
  result.tm_isdst := Ftm_isdst;
end;

constructor TPbParamWrapper.Create(ARecord: TPbParam);
begin
  inherited Create;
end;

function TPbParamWrapper.ObjToRec: TPbParam;
begin
end;

constructor TPbEntryWrapper.Create(ARecord: TPbEntry);
begin
  inherited Create;
end;

function TPbEntryWrapper.ObjToRec: TPbEntry;
begin
end;

constructor TPblockWrapper.Create(ARecord: TPblock);
begin
  inherited Create;
  Fhsize := ARecord.hsize;
end;

function TPblockWrapper.ObjToRec: TPblock;
begin
  result.hsize := Fhsize;
end;

constructor TFileBufferWrapper.Create(ARecord: TFileBuffer);
begin
  inherited Create;
  Ffdmap := ARecord.fdmap;
  Flen := ARecord.len;
  Fcursize := ARecord.cursize;
  Fpos := ARecord.pos;
end;

function TFileBufferWrapper.ObjToRec: TFileBuffer;
begin
  result.fdmap := Ffdmap;
  result.len := Flen;
  result.cursize := Fcursize;
  result.pos := Fpos;
end;

constructor TNetBufWrapper.Create(ARecord: TNetBuf);
begin
  inherited Create;
  Fsd := ARecord.sd;
  Fpos := ARecord.pos;
  Fcursize := ARecord.cursize;
  Fmaxsize := ARecord.maxsize;
  Frdtimeout := ARecord.rdtimeout;
end;

function TNetBufWrapper.ObjToRec: TNetBuf;
begin
  result.sd := Fsd;
  result.pos := Fpos;
  result.cursize := Fcursize;
  result.maxsize := Fmaxsize;
  result.rdtimeout := Frdtimeout;
end;

constructor TSessionWrapper.Create(ARecord: TSession);
begin
  inherited Create;
  Fcsd := ARecord.csd;
  Fcsd_open := ARecord.csd_open;
end;

function TSessionWrapper.ObjToRec: TSession;
begin
  result.csd := Fcsd;
  result.csd_open := Fcsd_open;
end;

constructor TCInfoWrapper.Create(ARecord: TCInfo);
begin
  inherited Create;
end;

function TCInfoWrapper.ObjToRec: TCInfo;
begin
end;

constructor TShMemWrapper.Create(ARecord: TShMem);
begin
  inherited Create;
  Ffdmap := ARecord.fdmap;
  Fsize := ARecord.size;
end;

function TShMemWrapper.ObjToRec: TShMem;
begin
  result.fdmap := Ffdmap;
  result.size := Fsize;
end;

constructor TMultipleDomainsWrapper.Create(ARecord: TMultipleDomains);
begin
  inherited Create;
  Fsd := ARecord.sd;
  Fthreads := ARecord.threads;
  FAddressNumber := ARecord.AddressNumber;
end;

function TMultipleDomainsWrapper.ObjToRec: TMultipleDomains;
begin
  result.sd := Fsd;
  result.threads := Fthreads;
  result.AddressNumber := FAddressNumber;
end;

constructor TDaemonWrapper.Create(ARecord: TDaemon);
begin
  inherited Create;
  Fport := ARecord.port;
  Fmaxprocs := ARecord.maxprocs;
  Fminprocs := ARecord.minprocs;
  Fproclife := ARecord.proclife;
  Fmaxthreads := ARecord.maxthreads;
  Fminthreads := ARecord.minthreads;
end;

function TDaemonWrapper.ObjToRec: TDaemon;
begin
  result.port := Fport;
  result.maxprocs := Fmaxprocs;
  result.minprocs := Fminprocs;
  result.proclife := Fproclife;
  result.maxthreads := Fmaxthreads;
  result.minthreads := Fminthreads;
end;

constructor TDirectiveWrapper.Create(ARecord: TDirective);
begin
  inherited Create;
end;

function TDirectiveWrapper.ObjToRec: TDirective;
begin
end;

constructor TDtableWrapper.Create(ARecord: TDtable);
begin
  inherited Create;
  Fni := ARecord.ni;
end;

function TDtableWrapper.ObjToRec: TDtable;
begin
  result.ni := Fni;
end;

constructor THttpdObjectWrapper.Create(ARecord: THttpdObject);
begin
  inherited Create;
  Fnd := ARecord.nd;
end;

function THttpdObjectWrapper.ObjToRec: THttpdObject;
begin
  result.nd := Fnd;
end;

constructor THttpdObjSetWrapper.Create(ARecord: THttpdObjSet);
begin
  inherited Create;
  Fpos := ARecord.pos;
end;

function THttpdObjSetWrapper.ObjToRec: THttpdObjSet;
begin
  result.pos := Fpos;
end;

constructor TConfGlobalVarsWrapper.Create(ARecord: TConfGlobalVars);
begin
  inherited Create;
  FVport := ARecord.Vport;
  FVpool_max := ARecord.Vpool_max;
  FVpool_min := ARecord.Vpool_min;
  FVpool_life := ARecord.Vpool_life;
  FVpool_maxthreads := ARecord.Vpool_maxthreads;
  FVpool_minthreads := ARecord.Vpool_minthreads;
end;

function TConfGlobalVarsWrapper.ObjToRec: TConfGlobalVars;
begin
  result.Vport := FVport;
  result.Vpool_max := FVpool_max;
  result.Vpool_min := FVpool_min;
  result.Vpool_life := FVpool_life;
  result.Vpool_maxthreads := FVpool_maxthreads;
  result.Vpool_minthreads := FVpool_minthreads;
end;

constructor TRequestWrapper.Create(ARecord: TRequest);
begin
  inherited Create;
  Floadhdrs := ARecord.loadhdrs;
  Fsenthdrs := ARecord.senthdrs;
  Faclstate := ARecord.aclstate;
  Facldirno := ARecord.acldirno;
  Frequest_is_cacheable := ARecord.request_is_cacheable;
  Fdirective_is_cacheable := ARecord.directive_is_cacheable;
  Fcached_headers_len := ARecord.cached_headers_len;
end;

function TRequestWrapper.ObjToRec: TRequest;
begin
  result.loadhdrs := Floadhdrs;
  result.senthdrs := Fsenthdrs;
  result.aclstate := Faclstate;
  result.acldirno := Facldirno;
  result.request_is_cacheable := Frequest_is_cacheable;
  result.directive_is_cacheable := Fdirective_is_cacheable;
  result.cached_headers_len := Fcached_headers_len;
end;

constructor TFuncStructWrapper.Create(ARecord: TFuncStruct);
begin
  inherited Create;
end;

function TFuncStructWrapper.ObjToRec: TFuncStruct;
begin
end;



procedure TatNsapiLibrary.__strcasecmp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.strcasecmp(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__strncasecmp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.strncasecmp(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_strcasecmp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.util_strcasecmp(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_strncasecmp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.util_strncasecmp(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__system_version(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.system_version);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__MAGNUS_VERSION_STRING(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.MAGNUS_VERSION_STRING);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__server_fasttrack(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.server_fasttrack;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__server_enterprise(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.server_enterprise;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__system_version_set(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.system_version_set(PAnsiChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatNsapiLibrary.__STRDUP(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.STRDUP(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__system_strdup(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.system_strdup(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__PERM_STRDUP(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.PERM_STRDUP(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__system_strdup_perm(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.system_strdup_perm(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__pool_enabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.pool_enabled;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__sem_init(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.sem_init(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__sem_terminate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.sem_terminate(GetInputArg(0));
  end;
end;

procedure TatNsapiLibrary.__sem_grab(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.sem_grab(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__sem_tgrab(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.sem_tgrab(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__sem_release(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.sem_release(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__CONVERT_TO_PRINTABLE_FORMAT(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.CONVERT_TO_PRINTABLE_FORMAT(PAnsiChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatNsapiLibrary.__CONVERT_TO_NATIVE_FS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.CONVERT_TO_NATIVE_FS(PAnsiChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatNsapiLibrary.__system_chdir(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.system_chdir(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__system_stat(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TStat;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TStatWrapper) then 
  Param1Rec := TStatWrapper.Create(Param1);
Param1 := TStatWrapper(Param1Rec).ObjToRec;
AResult := Integer(Nsapi.system_stat(PAnsiChar(VarToStr(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TStatWrapper.Create(Param1)));
  end;
end;

procedure TatNsapiLibrary.__system_rename(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.system_rename(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__system_unlink(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.system_unlink(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__system_nocoredumps(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.system_nocoredumps);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__system_winsockerr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.system_winsockerr);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__system_winerr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.system_winerr);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__file_notfound(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.file_notfound);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__system_errmsg(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.system_errmsg);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__system_errmsg_fn(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.system_errmsg_fn);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__file_unix2local(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.file_unix2local(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))));
  end;
end;

procedure TatNsapiLibrary.__dir_create(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.dir_create(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__dir_remove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.dir_remove(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__dir_create_all(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.dir_create_all(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__net_socket(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.net_socket(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__net_listen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.net_listen(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__net_create_listener(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.net_create_listener(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__net_getpeername(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSockAddr;
  Param2: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is sockaddr_inWrapper) then 
  Param1Rec := sockaddr_inWrapper.Create(Param1);
Param1 := sockaddr_inWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Nsapi.net_getpeername(VarToInteger(GetInputArg(0)),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(sockaddr_inWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatNsapiLibrary.__net_close(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.net_close(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__net_bind(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSockAddr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is sockaddr_inWrapper) then 
  Param1Rec := sockaddr_inWrapper.Create(Param1);
Param1 := sockaddr_inWrapper(Param1Rec).ObjToRec;
AResult := Integer(Nsapi.net_bind(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(sockaddr_inWrapper.Create(Param1)));
  end;
end;

procedure TatNsapiLibrary.__net_read(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.net_read(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__net_write(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.net_write(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__net_isalive(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.net_isalive(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__net_ip2host(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.net_ip2host(PAnsiChar(VarToStr(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__CINFO_HASH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.CINFO_HASH(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__cinfo_init(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.cinfo_init;
  end;
end;

procedure TatNsapiLibrary.__cinfo_terminate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.cinfo_terminate;
  end;
end;

procedure TatNsapiLibrary.__cinfo_merge(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.cinfo_merge(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__ereport_terminate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.ereport_terminate;
  end;
end;

procedure TatNsapiLibrary.__shexp_valid(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.shexp_valid(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__shexp_match(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.shexp_match(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__shexp_cmp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.shexp_cmp(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__shexp_casecmp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.shexp_casecmp(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__systhread_yield(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.systhread_yield;
  end;
end;

procedure TatNsapiLibrary.__systhread_sleep(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.systhread_sleep(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatNsapiLibrary.__systhread_init(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.systhread_init(PAnsiChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatNsapiLibrary.__systhread_timerset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.systhread_timerset(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatNsapiLibrary.__systhread_newkey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.systhread_newkey);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__child_fork(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.child_fork;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_env_str(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.util_env_str(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_hostname(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.util_hostname);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_chdir2path(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.util_chdir2path(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_is_mozilla(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.util_is_mozilla(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_is_url(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.util_is_url(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_later_than(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: tm;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tmWrapper) then 
  Param0Rec := tmWrapper.Create(Param0);
Param0 := tmWrapper(Param0Rec).ObjToRec;
AResult := Nsapi.util_later_than(Param0,PAnsiChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tmWrapper.Create(Param0)));
  end;
end;

procedure TatNsapiLibrary.__util_time_equal(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: tm;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tmWrapper) then 
  Param0Rec := tmWrapper.Create(Param0);
Param0 := tmWrapper(Param0Rec).ObjToRec;
AResult := Nsapi.util_time_equal(Param0,PAnsiChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tmWrapper.Create(Param0)));
  end;
end;

procedure TatNsapiLibrary.__util_str_time_equal(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.util_str_time_equal(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_uri_is_evil(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.util_uri_is_evil(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_uri_parse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.util_uri_parse(PAnsiChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatNsapiLibrary.__util_uri_unescape(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.util_uri_unescape(PAnsiChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatNsapiLibrary.__util_uri_escape(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.util_uri_escape(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_url_escape(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.util_url_escape(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_sh_escape(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.util_sh_escape(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_mime_separator(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.util_mime_separator(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_itoa(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.util_itoa(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__util_delete_directory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.util_delete_directory(PAnsiChar(VarToStr(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatNsapiLibrary.__util_strftime(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: tm;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is tmWrapper) then 
  Param2Rec := tmWrapper.Create(Param2);
Param2 := tmWrapper(Param2Rec).ObjToRec;
AResult := Integer(Nsapi.util_strftime(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(tmWrapper.Create(Param2)));
  end;
end;

procedure TatNsapiLibrary.___ntverify_parameter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi._ntverify_parameter(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__ClearConfigurationParameters(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.ClearConfigurationParameters(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__GetProductKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.GetProductKey);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__pool_max(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.pool_max);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__pool_min(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.pool_min);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__pool_life(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.pool_life);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__pool_maxthreads(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.pool_maxthreads);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__pool_minthreads(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Nsapi.pool_minthreads);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__server_hostname(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.server_hostname);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__root_object(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.root_object);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__master_error_log(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.master_error_log);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__server_root(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.server_root);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__server_id(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.server_id);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__conf_init(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.conf_init(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__conf_terminate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.conf_terminate;
  end;
end;

procedure TatNsapiLibrary.__GetDomainAddresses(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.GetDomainAddresses(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__protocol_uri2url(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.protocol_uri2url(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__http_uri2url(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Nsapi.http_uri2url(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.__protocol_set_keepalive_timeout(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.protocol_set_keepalive_timeout(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatNsapiLibrary.__http_set_keepalive_timeout(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.http_set_keepalive_timeout(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatNsapiLibrary.__func_init(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Nsapi.func_init;
  end;
end;

procedure TatNsapiLibrary.__NSstr2String(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Nsapi.NSstr2String(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatNsapiLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('strcasecmp',2,tkInteger,nil,__strcasecmp,false,0);
    DefineMethod('strncasecmp',3,tkInteger,nil,__strncasecmp,false,0);
    DefineMethod('util_strcasecmp',2,tkInteger,nil,__util_strcasecmp,false,0);
    DefineMethod('util_strncasecmp',3,tkInteger,nil,__util_strncasecmp,false,0);
    DefineMethod('system_version',0,tkVariant,nil,__system_version,false,0);
    DefineMethod('MAGNUS_VERSION_STRING',0,tkVariant,nil,__MAGNUS_VERSION_STRING,false,0);
    DefineMethod('server_fasttrack',0,tkVariant,nil,__server_fasttrack,false,0);
    DefineMethod('server_enterprise',0,tkVariant,nil,__server_enterprise,false,0);
    DefineMethod('system_version_set',1,tkNone,nil,__system_version_set,false,0);
    DefineMethod('STRDUP',1,tkVariant,nil,__STRDUP,false,0);
    DefineMethod('system_strdup',1,tkVariant,nil,__system_strdup,false,0);
    DefineMethod('PERM_STRDUP',1,tkVariant,nil,__PERM_STRDUP,false,0);
    DefineMethod('system_strdup_perm',1,tkVariant,nil,__system_strdup_perm,false,0);
    DefineMethod('pool_enabled',0,tkVariant,nil,__pool_enabled,false,0);
    DefineMethod('sem_init',2,tkVariant,nil,__sem_init,false,0);
    DefineMethod('sem_terminate',1,tkNone,nil,__sem_terminate,false,0);
    DefineMethod('sem_grab',1,tkInteger,nil,__sem_grab,false,0);
    DefineMethod('sem_tgrab',1,tkInteger,nil,__sem_tgrab,false,0);
    DefineMethod('sem_release',1,tkInteger,nil,__sem_release,false,0);
    DefineMethod('CONVERT_TO_PRINTABLE_FORMAT',1,tkNone,nil,__CONVERT_TO_PRINTABLE_FORMAT,false,0);
    DefineMethod('CONVERT_TO_NATIVE_FS',1,tkNone,nil,__CONVERT_TO_NATIVE_FS,false,0);
    DefineMethod('system_chdir',1,tkVariant,nil,__system_chdir,false,0);
    DefineMethod('system_stat',2,tkInteger,nil,__system_stat,false,0).SetVarArgs([1]);
    DefineMethod('system_rename',2,tkVariant,nil,__system_rename,false,0);
    DefineMethod('system_unlink',1,tkVariant,nil,__system_unlink,false,0);
    DefineMethod('system_nocoredumps',0,tkInteger,nil,__system_nocoredumps,false,0);
    DefineMethod('system_winsockerr',0,tkVariant,nil,__system_winsockerr,false,0);
    DefineMethod('system_winerr',0,tkVariant,nil,__system_winerr,false,0);
    DefineMethod('file_notfound',0,tkInteger,nil,__file_notfound,false,0);
    DefineMethod('system_errmsg',0,tkVariant,nil,__system_errmsg,false,0);
    DefineMethod('system_errmsg_fn',0,tkVariant,nil,__system_errmsg_fn,false,0);
    DefineMethod('file_unix2local',2,tkNone,nil,__file_unix2local,false,0);
    DefineMethod('dir_create',1,tkInteger,nil,__dir_create,false,0);
    DefineMethod('dir_remove',1,tkInteger,nil,__dir_remove,false,0);
    DefineMethod('dir_create_all',1,tkInteger,nil,__dir_create_all,false,0);
    DefineMethod('net_socket',3,tkInteger,nil,__net_socket,false,0);
    DefineMethod('net_listen',2,tkInteger,nil,__net_listen,false,0);
    DefineMethod('net_create_listener',2,tkInteger,nil,__net_create_listener,false,0);
    DefineMethod('net_getpeername',3,tkInteger,nil,__net_getpeername,false,0).SetVarArgs([1,2]);
    DefineMethod('net_close',1,tkInteger,nil,__net_close,false,0);
    DefineMethod('net_bind',3,tkInteger,nil,__net_bind,false,0).SetVarArgs([1]);
    DefineMethod('net_read',4,tkInteger,nil,__net_read,false,0);
    DefineMethod('net_write',3,tkInteger,nil,__net_write,false,0);
    DefineMethod('net_isalive',1,tkVariant,nil,__net_isalive,false,0);
    DefineMethod('net_ip2host',2,tkVariant,nil,__net_ip2host,false,0);
    DefineMethod('CINFO_HASH',1,tkVariant,nil,__CINFO_HASH,false,0);
    DefineMethod('cinfo_init',0,tkNone,nil,__cinfo_init,false,0);
    DefineMethod('cinfo_terminate',0,tkNone,nil,__cinfo_terminate,false,0);
    DefineMethod('cinfo_merge',1,tkVariant,nil,__cinfo_merge,false,0);
    DefineMethod('ereport_terminate',0,tkNone,nil,__ereport_terminate,false,0);
    DefineMethod('shexp_valid',1,tkInteger,nil,__shexp_valid,false,0);
    DefineMethod('shexp_match',2,tkInteger,nil,__shexp_match,false,0);
    DefineMethod('shexp_cmp',2,tkInteger,nil,__shexp_cmp,false,0);
    DefineMethod('shexp_casecmp',2,tkInteger,nil,__shexp_casecmp,false,0);
    DefineMethod('systhread_yield',0,tkNone,nil,__systhread_yield,false,0);
    DefineMethod('systhread_sleep',1,tkNone,nil,__systhread_sleep,false,0);
    DefineMethod('systhread_init',1,tkNone,nil,__systhread_init,false,0);
    DefineMethod('systhread_timerset',1,tkNone,nil,__systhread_timerset,false,0);
    DefineMethod('systhread_newkey',0,tkInteger,nil,__systhread_newkey,false,0);
    DefineMethod('child_fork',0,tkVariant,nil,__child_fork,false,0);
    DefineMethod('util_env_str',2,tkVariant,nil,__util_env_str,false,0);
    DefineMethod('util_hostname',0,tkVariant,nil,__util_hostname,false,0);
    DefineMethod('util_chdir2path',1,tkInteger,nil,__util_chdir2path,false,0);
    DefineMethod('util_is_mozilla',3,tkVariant,nil,__util_is_mozilla,false,0);
    DefineMethod('util_is_url',1,tkVariant,nil,__util_is_url,false,0);
    DefineMethod('util_later_than',2,tkVariant,nil,__util_later_than,false,0).SetVarArgs([0]);
    DefineMethod('util_time_equal',2,tkVariant,nil,__util_time_equal,false,0).SetVarArgs([0]);
    DefineMethod('util_str_time_equal',2,tkInteger,nil,__util_str_time_equal,false,0);
    DefineMethod('util_uri_is_evil',1,tkVariant,nil,__util_uri_is_evil,false,0);
    DefineMethod('util_uri_parse',1,tkNone,nil,__util_uri_parse,false,0);
    DefineMethod('util_uri_unescape',1,tkNone,nil,__util_uri_unescape,false,0);
    DefineMethod('util_uri_escape',2,tkVariant,nil,__util_uri_escape,false,0);
    DefineMethod('util_url_escape',2,tkVariant,nil,__util_url_escape,false,0);
    DefineMethod('util_sh_escape',1,tkVariant,nil,__util_sh_escape,false,0);
    DefineMethod('util_mime_separator',1,tkInteger,nil,__util_mime_separator,false,0);
    DefineMethod('util_itoa',2,tkInteger,nil,__util_itoa,false,0);
    DefineMethod('util_delete_directory',2,tkNone,nil,__util_delete_directory,false,0);
    DefineMethod('util_strftime',3,tkInteger,nil,__util_strftime,false,0).SetVarArgs([2]);
    DefineMethod('_ntverify_parameter',1,tkInteger,nil,___ntverify_parameter,false,0);
    DefineMethod('ClearConfigurationParameters',3,tkVariant,nil,__ClearConfigurationParameters,false,0);
    DefineMethod('GetProductKey',0,tkVariant,nil,__GetProductKey,false,0);
    DefineMethod('pool_max',0,tkInteger,nil,__pool_max,false,0);
    DefineMethod('pool_min',0,tkInteger,nil,__pool_min,false,0);
    DefineMethod('pool_life',0,tkInteger,nil,__pool_life,false,0);
    DefineMethod('pool_maxthreads',0,tkInteger,nil,__pool_maxthreads,false,0);
    DefineMethod('pool_minthreads',0,tkInteger,nil,__pool_minthreads,false,0);
    DefineMethod('server_hostname',0,tkVariant,nil,__server_hostname,false,0);
    DefineMethod('root_object',0,tkVariant,nil,__root_object,false,0);
    DefineMethod('master_error_log',0,tkVariant,nil,__master_error_log,false,0);
    DefineMethod('server_root',0,tkVariant,nil,__server_root,false,0);
    DefineMethod('server_id',0,tkVariant,nil,__server_id,false,0);
    DefineMethod('conf_init',1,tkVariant,nil,__conf_init,false,0);
    DefineMethod('conf_terminate',0,tkNone,nil,__conf_terminate,false,0);
    DefineMethod('GetDomainAddresses',1,tkVariant,nil,__GetDomainAddresses,false,0);
    DefineMethod('protocol_uri2url',2,tkVariant,nil,__protocol_uri2url,false,0);
    DefineMethod('http_uri2url',2,tkVariant,nil,__http_uri2url,false,0);
    DefineMethod('protocol_set_keepalive_timeout',1,tkNone,nil,__protocol_set_keepalive_timeout,false,0);
    DefineMethod('http_set_keepalive_timeout',1,tkNone,nil,__http_set_keepalive_timeout,false,0);
    DefineMethod('func_init',0,tkNone,nil,__func_init,false,0);
    DefineMethod('NSstr2String',1,tkVariant,nil,__NSstr2String,false,0);
    AddConstant('PROXY_VERSION_DEF',PROXY_VERSION_DEF);
    AddConstant('PROXY_VERSION_STRING',PROXY_VERSION_STRING);
    AddConstant('ADMSERV_VERSION_DEF',ADMSERV_VERSION_DEF);
    AddConstant('ADMSERV_VERSION_STRING',ADMSERV_VERSION_STRING);
    AddConstant('PERSONAL_VERSION_DEF',PERSONAL_VERSION_DEF);
    AddConstant('PERSONAL_VERSION_STRING',PERSONAL_VERSION_STRING);
    AddConstant('CATALOG_VERSION_DEF',CATALOG_VERSION_DEF);
    AddConstant('CATALOG_VERSION_STRING',CATALOG_VERSION_STRING);
    AddConstant('RDS_VERSION_DEF',RDS_VERSION_DEF);
    AddConstant('RDS_VERSION_STRING',RDS_VERSION_STRING);
    AddConstant('ENTERPRISE_VERSION_DEF',ENTERPRISE_VERSION_DEF);
    AddConstant('ENTERPRISE_VERSION_STRING',ENTERPRISE_VERSION_STRING);
    AddConstant('NEWS_VERSION_STRING',NEWS_VERSION_STRING);
    AddConstant('BATMAN_VERSION_DEF',BATMAN_VERSION_DEF);
    AddConstant('BATMAN_VERSION_STRING',BATMAN_VERSION_STRING);
    AddConstant('DAEMON_LISTEN_SIZE',DAEMON_LISTEN_SIZE);
    AddConstant('MAGNUS_ERROR_LEN',MAGNUS_ERROR_LEN);
    AddConstant('CR',CR);
    AddConstant('LF',LF);
    AddConstant('ENDLINE',ENDLINE);
    AddConstant('ENTERPRISE_VERSION',ENTERPRISE_VERSION);
    AddConstant('PERSONAL_VERSION',PERSONAL_VERSION);
    AddConstant('CATALOG_VERSION',CATALOG_VERSION);
    AddConstant('RDS_VERSION',RDS_VERSION);
    AddConstant('SEM_ERROR',SEM_ERROR);
    AddConstant('SEM_MAXVALUE',SEM_MAXVALUE);
    AddConstant('IO_OKAY',IO_OKAY);
    AddConstant('IO_ERROR',IO_ERROR);
    AddConstant('IO_EOF',IO_EOF);
    AddConstant('FILE_BUFFERSIZE',FILE_BUFFERSIZE);
    AddConstant('ERROR_PIPE',ERROR_PIPE);
    AddConstant('FILE_PATHSEP',FILE_PATHSEP);
    AddConstant('FILE_PARENT',FILE_PARENT);
    AddConstant('NET_BUFFERSIZE',NET_BUFFERSIZE);
    AddConstant('NET_READ_TIMEOUT',NET_READ_TIMEOUT);
    AddConstant('NET_WRITE_TIMEOUT',NET_WRITE_TIMEOUT);
    AddConstant('NET_INFINITE_TIMEOUT',NET_INFINITE_TIMEOUT);
    AddConstant('NET_ZERO_TIMEOUT',NET_ZERO_TIMEOUT);
    AddConstant('SSL_HANDSHAKE_TIMEOUT',SSL_HANDSHAKE_TIMEOUT);
    AddConstant('SYS_NET_ERRORFD',SYS_NET_ERRORFD);
    AddConstant('SESSION_HASHSIZE',SESSION_HASHSIZE);
    AddConstant('MCC_MT_MAGIC',MCC_MT_MAGIC);
    AddConstant('MCC_MT_MAGIC_LEN',MCC_MT_MAGIC_LEN);
    AddConstant('NCC_MT_MAGIC',NCC_MT_MAGIC);
    AddConstant('NCC_MT_MAGIC_LEN',NCC_MT_MAGIC_LEN);
    AddConstant('CINFO_SEPARATOR',CINFO_SEPARATOR);
    AddConstant('CINFO_MAX_LEN',CINFO_MAX_LEN);
    AddConstant('CINFO_HASHSIZE',CINFO_HASHSIZE);
    AddConstant('MAX_ERROR_LEN',MAX_ERROR_LEN);
    AddConstant('LOG_WARN',LOG_WARN);
    AddConstant('LOG_MISCONFIG',LOG_MISCONFIG);
    AddConstant('LOG_SECURITY',LOG_SECURITY);
    AddConstant('LOG_FAILURE',LOG_FAILURE);
    AddConstant('LOG_CATASTROPHE',LOG_CATASTROPHE);
    AddConstant('LOG_INFORM',LOG_INFORM);
    AddConstant('ERR_TIMEFMT',ERR_TIMEFMT);
    AddConstant('ERRORS_TO_SYSLOG',ERRORS_TO_SYSLOG);
    AddConstant('NON_SXP',NON_SXP);
    AddConstant('INVALID_SXP',INVALID_SXP);
    AddConstant('VALID_SXP',VALID_SXP);
    AddConstant('NON_WILDPAT',NON_WILDPAT);
    AddConstant('INVALID_WILDPAT',INVALID_WILDPAT);
    AddConstant('VALID_WILDPAT',VALID_WILDPAT);
    AddConstant('NON_REGEXP',NON_REGEXP);
    AddConstant('INVALID_REGEXP',INVALID_REGEXP);
    AddConstant('VALID_REGEXP',VALID_REGEXP);
    AddConstant('SYSTHREAD_DEFAULT_PRIORITY',SYSTHREAD_DEFAULT_PRIORITY);
    AddConstant('CHILD_EMPTY_SLOT',CHILD_EMPTY_SLOT);
    AddConstant('CHILD_AWAIT_CONNECT',CHILD_AWAIT_CONNECT);
    AddConstant('CHILD_PROCESSING',CHILD_PROCESSING);
    AddConstant('CHILD_READING',CHILD_READING);
    AddConstant('CHILD_WRITING',CHILD_WRITING);
    AddConstant('CHILD_RESOLVING',CHILD_RESOLVING);
    AddConstant('CHILD_DONE_PROCESSING',CHILD_DONE_PROCESSING);
    AddConstant('CHILD_DONE_READING',CHILD_DONE_READING);
    AddConstant('CHILD_DONE_WRITING',CHILD_DONE_WRITING);
    AddConstant('CHILD_DONE_RESOLVING',CHILD_DONE_RESOLVING);
    AddConstant('MAX_IP_DOMAINS',MAX_IP_DOMAINS);
    AddConstant('OBJSET_INCSIZE',OBJSET_INCSIZE);
    AddConstant('MAX_DIRECTIVE_LEN',MAX_DIRECTIVE_LEN);
    AddConstant('PARAMETER_HASH_SIZE',PARAMETER_HASH_SIZE);
    AddConstant('CONF_MAXLEN',CONF_MAXLEN);
    AddConstant('DEFAULT_PORT',DEFAULT_PORT);
    AddConstant('DEFAULT_POOL_MAX',DEFAULT_POOL_MAX);
    AddConstant('REQ_HASHSIZE',REQ_HASHSIZE);
    AddConstant('REQ_MAX_LINE',REQ_MAX_LINE);
    AddConstant('REQ_PROCEED',REQ_PROCEED);
    AddConstant('REQ_ABORTED',REQ_ABORTED);
    AddConstant('REQ_NOACTION',REQ_NOACTION);
    AddConstant('REQ_EXIT',REQ_EXIT);
    AddConstant('REQ_RESTART',REQ_RESTART);
    AddConstant('HTTP_DATE_LEN',HTTP_DATE_LEN);
    AddConstant('HTTP_DATE_FMT',HTTP_DATE_FMT);
    AddConstant('HTTP_DEFAULT_KEEPALIVE_TIMEOUT',HTTP_DEFAULT_KEEPALIVE_TIMEOUT);
    AddConstant('HTTP_MAX_HEADERS',HTTP_MAX_HEADERS);
    AddConstant('PROTOCOL_OK',PROTOCOL_OK);
    AddConstant('PROTOCOL_CREATED',PROTOCOL_CREATED);
    AddConstant('PROTOCOL_NO_RESPONSE',PROTOCOL_NO_RESPONSE);
    AddConstant('PROTOCOL_PARTIAL_CONTENT',PROTOCOL_PARTIAL_CONTENT);
    AddConstant('PROTOCOL_REDIRECT',PROTOCOL_REDIRECT);
    AddConstant('PROTOCOL_NOT_MODIFIED',PROTOCOL_NOT_MODIFIED);
    AddConstant('PROTOCOL_BAD_REQUEST',PROTOCOL_BAD_REQUEST);
    AddConstant('PROTOCOL_UNAUTHORIZED',PROTOCOL_UNAUTHORIZED);
    AddConstant('PROTOCOL_FORBIDDEN',PROTOCOL_FORBIDDEN);
    AddConstant('PROTOCOL_NOT_FOUND',PROTOCOL_NOT_FOUND);
    AddConstant('PROTOCOL_PROXY_UNAUTHORIZED',PROTOCOL_PROXY_UNAUTHORIZED);
    AddConstant('PROTOCOL_SERVER_ERROR',PROTOCOL_SERVER_ERROR);
    AddConstant('PROTOCOL_NOT_IMPLEMENTED',PROTOCOL_NOT_IMPLEMENTED);
    AddConstant('HTTP_PORT',HTTP_PORT);
    AddConstant('HTTP_URL',HTTP_URL);
    AddConstant('NUM_HASH',NUM_HASH);
  end;
end;

class function TatNsapiLibrary.LibraryName: string;
begin
  result := 'Nsapi';
end;

initialization
  RegisterScripterLibrary(TatNsapiLibrary, True);

{$WARNINGS ON}

end.

