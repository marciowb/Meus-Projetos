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
unit ap_Nb30;

interface

uses
  Windows,
  Nb30,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatNb30Library = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TNCBWrapper = class(TatRecordWrapper)
  private
    Fncb_command: Char;
    Fncb_retcode: Char;
    Fncb_lsn: Char;
    Fncb_num: Char;
    Fncb_length: Word;
    Fncb_rto: Char;
    Fncb_sto: Char;
    Fncb_lana_num: Char;
    Fncb_cmd_cplt: Char;
    Fncb_event: THandle;
  public
    constructor Create(ARecord: TNCB);
    function ObjToRec: TNCB;
  published
    property ncb_command: Char read Fncb_command write Fncb_command;
    property ncb_retcode: Char read Fncb_retcode write Fncb_retcode;
    property ncb_lsn: Char read Fncb_lsn write Fncb_lsn;
    property ncb_num: Char read Fncb_num write Fncb_num;
    property ncb_length: Word read Fncb_length write Fncb_length;
    property ncb_rto: Char read Fncb_rto write Fncb_rto;
    property ncb_sto: Char read Fncb_sto write Fncb_sto;
    property ncb_lana_num: Char read Fncb_lana_num write Fncb_lana_num;
    property ncb_cmd_cplt: Char read Fncb_cmd_cplt write Fncb_cmd_cplt;
    property ncb_event: THandle read Fncb_event write Fncb_event;
  end;
  
  TAdapterStatusWrapper = class(TatRecordWrapper)
  private
    Frev_major: Char;
    Freserved0: Char;
    Fadapter_type: Char;
    Frev_minor: Char;
    Fduration: Word;
    Ffrmr_recv: Word;
    Ffrmr_xmit: Word;
    Fiframe_recv_err: Word;
    Fxmit_aborts: Word;
    Fxmit_success: DWORD;
    Frecv_success: DWORD;
    Fiframe_xmit_err: Word;
    Frecv_buff_unavail: Word;
    Ft1_timeouts: Word;
    Fti_timeouts: Word;
    Freserved1: DWORD;
    Ffree_ncbs: Word;
    Fmax_cfg_ncbs: Word;
    Fmax_ncbs: Word;
    Fxmit_buf_unavail: Word;
    Fmax_dgram_size: Word;
    Fpending_sess: Word;
    Fmax_cfg_sess: Word;
    Fmax_sess: Word;
    Fmax_sess_pkt_size: Word;
    Fname_count: Word;
  public
    constructor Create(ARecord: TAdapterStatus);
    function ObjToRec: TAdapterStatus;
  published
    property rev_major: Char read Frev_major write Frev_major;
    property reserved0: Char read Freserved0 write Freserved0;
    property adapter_type: Char read Fadapter_type write Fadapter_type;
    property rev_minor: Char read Frev_minor write Frev_minor;
    property duration: Word read Fduration write Fduration;
    property frmr_recv: Word read Ffrmr_recv write Ffrmr_recv;
    property frmr_xmit: Word read Ffrmr_xmit write Ffrmr_xmit;
    property iframe_recv_err: Word read Fiframe_recv_err write Fiframe_recv_err;
    property xmit_aborts: Word read Fxmit_aborts write Fxmit_aborts;
    property xmit_success: DWORD read Fxmit_success write Fxmit_success;
    property recv_success: DWORD read Frecv_success write Frecv_success;
    property iframe_xmit_err: Word read Fiframe_xmit_err write Fiframe_xmit_err;
    property recv_buff_unavail: Word read Frecv_buff_unavail write Frecv_buff_unavail;
    property t1_timeouts: Word read Ft1_timeouts write Ft1_timeouts;
    property ti_timeouts: Word read Fti_timeouts write Fti_timeouts;
    property reserved1: DWORD read Freserved1 write Freserved1;
    property free_ncbs: Word read Ffree_ncbs write Ffree_ncbs;
    property max_cfg_ncbs: Word read Fmax_cfg_ncbs write Fmax_cfg_ncbs;
    property max_ncbs: Word read Fmax_ncbs write Fmax_ncbs;
    property xmit_buf_unavail: Word read Fxmit_buf_unavail write Fxmit_buf_unavail;
    property max_dgram_size: Word read Fmax_dgram_size write Fmax_dgram_size;
    property pending_sess: Word read Fpending_sess write Fpending_sess;
    property max_cfg_sess: Word read Fmax_cfg_sess write Fmax_cfg_sess;
    property max_sess: Word read Fmax_sess write Fmax_sess;
    property max_sess_pkt_size: Word read Fmax_sess_pkt_size write Fmax_sess_pkt_size;
    property name_count: Word read Fname_count write Fname_count;
  end;
  
  TNameBufferWrapper = class(TatRecordWrapper)
  private
    Fname_num: Char;
    Fname_flags: Char;
  public
    constructor Create(ARecord: TNameBuffer);
    function ObjToRec: TNameBuffer;
  published
    property name_num: Char read Fname_num write Fname_num;
    property name_flags: Char read Fname_flags write Fname_flags;
  end;
  
  TSessionHeaderWrapper = class(TatRecordWrapper)
  private
    Fsess_name: Char;
    Fnum_sess: Char;
    Frcv_dg_outstanding: Char;
    Frcv_any_outstanding: Char;
  public
    constructor Create(ARecord: TSessionHeader);
    function ObjToRec: TSessionHeader;
  published
    property sess_name: Char read Fsess_name write Fsess_name;
    property num_sess: Char read Fnum_sess write Fnum_sess;
    property rcv_dg_outstanding: Char read Frcv_dg_outstanding write Frcv_dg_outstanding;
    property rcv_any_outstanding: Char read Frcv_any_outstanding write Frcv_any_outstanding;
  end;
  
  TSessionBufferWrapper = class(TatRecordWrapper)
  private
    Flsn: Char;
    Fstate: Char;
    Frcvs_outstanding: Char;
    Fsends_outstanding: Char;
  public
    constructor Create(ARecord: TSessionBuffer);
    function ObjToRec: TSessionBuffer;
  published
    property lsn: Char read Flsn write Flsn;
    property state: Char read Fstate write Fstate;
    property rcvs_outstanding: Char read Frcvs_outstanding write Frcvs_outstanding;
    property sends_outstanding: Char read Fsends_outstanding write Fsends_outstanding;
  end;
  
  TLanaEnumWrapper = class(TatRecordWrapper)
  private
    Flength: Char;
  public
    constructor Create(ARecord: TLanaEnum);
    function ObjToRec: TLanaEnum;
  published
    property length: Char read Flength write Flength;
  end;
  
  TFindNameHeaderWrapper = class(TatRecordWrapper)
  private
    Fnode_count: Word;
    Freserved: Char;
    Funique_group: Char;
  public
    constructor Create(ARecord: TFindNameHeader);
    function ObjToRec: TFindNameHeader;
  published
    property node_count: Word read Fnode_count write Fnode_count;
    property reserved: Char read Freserved write Freserved;
    property unique_group: Char read Funique_group write Funique_group;
  end;
  
  TFindNameBufferWrapper = class(TatRecordWrapper)
  private
    Flength: Char;
    Faccess_control: Char;
    Fframe_control: Char;
  public
    constructor Create(ARecord: TFindNameBuffer);
    function ObjToRec: TFindNameBuffer;
  published
    property length: Char read Flength write Flength;
    property access_control: Char read Faccess_control write Faccess_control;
    property frame_control: Char read Fframe_control write Fframe_control;
  end;
  
  TActionHeaderWrapper = class(TatRecordWrapper)
  private
    Ftransport_id: Longint;
    Faction_code: Word;
    Freserved: Word;
  public
    constructor Create(ARecord: TActionHeader);
    function ObjToRec: TActionHeader;
  published
    property transport_id: Longint read Ftransport_id write Ftransport_id;
    property action_code: Word read Faction_code write Faction_code;
    property reserved: Word read Freserved write Freserved;
  end;
  

implementation

constructor TNCBWrapper.Create(ARecord: TNCB);
begin
  inherited Create;
  Fncb_command := ARecord.ncb_command;
  Fncb_retcode := ARecord.ncb_retcode;
  Fncb_lsn := ARecord.ncb_lsn;
  Fncb_num := ARecord.ncb_num;
  Fncb_length := ARecord.ncb_length;
  Fncb_rto := ARecord.ncb_rto;
  Fncb_sto := ARecord.ncb_sto;
  Fncb_lana_num := ARecord.ncb_lana_num;
  Fncb_cmd_cplt := ARecord.ncb_cmd_cplt;
  Fncb_event := ARecord.ncb_event;
end;

function TNCBWrapper.ObjToRec: TNCB;
begin
  result.ncb_command := Fncb_command;
  result.ncb_retcode := Fncb_retcode;
  result.ncb_lsn := Fncb_lsn;
  result.ncb_num := Fncb_num;
  result.ncb_length := Fncb_length;
  result.ncb_rto := Fncb_rto;
  result.ncb_sto := Fncb_sto;
  result.ncb_lana_num := Fncb_lana_num;
  result.ncb_cmd_cplt := Fncb_cmd_cplt;
  result.ncb_event := Fncb_event;
end;

constructor TAdapterStatusWrapper.Create(ARecord: TAdapterStatus);
begin
  inherited Create;
  Frev_major := ARecord.rev_major;
  Freserved0 := ARecord.reserved0;
  Fadapter_type := ARecord.adapter_type;
  Frev_minor := ARecord.rev_minor;
  Fduration := ARecord.duration;
  Ffrmr_recv := ARecord.frmr_recv;
  Ffrmr_xmit := ARecord.frmr_xmit;
  Fiframe_recv_err := ARecord.iframe_recv_err;
  Fxmit_aborts := ARecord.xmit_aborts;
  Fxmit_success := ARecord.xmit_success;
  Frecv_success := ARecord.recv_success;
  Fiframe_xmit_err := ARecord.iframe_xmit_err;
  Frecv_buff_unavail := ARecord.recv_buff_unavail;
  Ft1_timeouts := ARecord.t1_timeouts;
  Fti_timeouts := ARecord.ti_timeouts;
  Freserved1 := ARecord.reserved1;
  Ffree_ncbs := ARecord.free_ncbs;
  Fmax_cfg_ncbs := ARecord.max_cfg_ncbs;
  Fmax_ncbs := ARecord.max_ncbs;
  Fxmit_buf_unavail := ARecord.xmit_buf_unavail;
  Fmax_dgram_size := ARecord.max_dgram_size;
  Fpending_sess := ARecord.pending_sess;
  Fmax_cfg_sess := ARecord.max_cfg_sess;
  Fmax_sess := ARecord.max_sess;
  Fmax_sess_pkt_size := ARecord.max_sess_pkt_size;
  Fname_count := ARecord.name_count;
end;

function TAdapterStatusWrapper.ObjToRec: TAdapterStatus;
begin
  result.rev_major := Frev_major;
  result.reserved0 := Freserved0;
  result.adapter_type := Fadapter_type;
  result.rev_minor := Frev_minor;
  result.duration := Fduration;
  result.frmr_recv := Ffrmr_recv;
  result.frmr_xmit := Ffrmr_xmit;
  result.iframe_recv_err := Fiframe_recv_err;
  result.xmit_aborts := Fxmit_aborts;
  result.xmit_success := Fxmit_success;
  result.recv_success := Frecv_success;
  result.iframe_xmit_err := Fiframe_xmit_err;
  result.recv_buff_unavail := Frecv_buff_unavail;
  result.t1_timeouts := Ft1_timeouts;
  result.ti_timeouts := Fti_timeouts;
  result.reserved1 := Freserved1;
  result.free_ncbs := Ffree_ncbs;
  result.max_cfg_ncbs := Fmax_cfg_ncbs;
  result.max_ncbs := Fmax_ncbs;
  result.xmit_buf_unavail := Fxmit_buf_unavail;
  result.max_dgram_size := Fmax_dgram_size;
  result.pending_sess := Fpending_sess;
  result.max_cfg_sess := Fmax_cfg_sess;
  result.max_sess := Fmax_sess;
  result.max_sess_pkt_size := Fmax_sess_pkt_size;
  result.name_count := Fname_count;
end;

constructor TNameBufferWrapper.Create(ARecord: TNameBuffer);
begin
  inherited Create;
  Fname_num := ARecord.name_num;
  Fname_flags := ARecord.name_flags;
end;

function TNameBufferWrapper.ObjToRec: TNameBuffer;
begin
  result.name_num := Fname_num;
  result.name_flags := Fname_flags;
end;

constructor TSessionHeaderWrapper.Create(ARecord: TSessionHeader);
begin
  inherited Create;
  Fsess_name := ARecord.sess_name;
  Fnum_sess := ARecord.num_sess;
  Frcv_dg_outstanding := ARecord.rcv_dg_outstanding;
  Frcv_any_outstanding := ARecord.rcv_any_outstanding;
end;

function TSessionHeaderWrapper.ObjToRec: TSessionHeader;
begin
  result.sess_name := Fsess_name;
  result.num_sess := Fnum_sess;
  result.rcv_dg_outstanding := Frcv_dg_outstanding;
  result.rcv_any_outstanding := Frcv_any_outstanding;
end;

constructor TSessionBufferWrapper.Create(ARecord: TSessionBuffer);
begin
  inherited Create;
  Flsn := ARecord.lsn;
  Fstate := ARecord.state;
  Frcvs_outstanding := ARecord.rcvs_outstanding;
  Fsends_outstanding := ARecord.sends_outstanding;
end;

function TSessionBufferWrapper.ObjToRec: TSessionBuffer;
begin
  result.lsn := Flsn;
  result.state := Fstate;
  result.rcvs_outstanding := Frcvs_outstanding;
  result.sends_outstanding := Fsends_outstanding;
end;

constructor TLanaEnumWrapper.Create(ARecord: TLanaEnum);
begin
  inherited Create;
  Flength := ARecord.length;
end;

function TLanaEnumWrapper.ObjToRec: TLanaEnum;
begin
  result.length := Flength;
end;

constructor TFindNameHeaderWrapper.Create(ARecord: TFindNameHeader);
begin
  inherited Create;
  Fnode_count := ARecord.node_count;
  Freserved := ARecord.reserved;
  Funique_group := ARecord.unique_group;
end;

function TFindNameHeaderWrapper.ObjToRec: TFindNameHeader;
begin
  result.node_count := Fnode_count;
  result.reserved := Freserved;
  result.unique_group := Funique_group;
end;

constructor TFindNameBufferWrapper.Create(ARecord: TFindNameBuffer);
begin
  inherited Create;
  Flength := ARecord.length;
  Faccess_control := ARecord.access_control;
  Fframe_control := ARecord.frame_control;
end;

function TFindNameBufferWrapper.ObjToRec: TFindNameBuffer;
begin
  result.length := Flength;
  result.access_control := Faccess_control;
  result.frame_control := Fframe_control;
end;

constructor TActionHeaderWrapper.Create(ARecord: TActionHeader);
begin
  inherited Create;
  Ftransport_id := ARecord.transport_id;
  Faction_code := ARecord.action_code;
  Freserved := ARecord.reserved;
end;

function TActionHeaderWrapper.ObjToRec: TActionHeader;
begin
  result.transport_id := Ftransport_id;
  result.action_code := Faction_code;
  result.reserved := Freserved;
end;



procedure TatNb30Library.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('NCBNAMSZ',NCBNAMSZ);
    AddConstant('MAX_LANA',MAX_LANA);
    AddConstant('NAME_FLAGS_MASK',NAME_FLAGS_MASK);
    AddConstant('GROUP_NAME',GROUP_NAME);
    AddConstant('UNIQUE_NAME',UNIQUE_NAME);
    AddConstant('REGISTERING',REGISTERING);
    AddConstant('REGISTERED',REGISTERED);
    AddConstant('DEREGISTERED',DEREGISTERED);
    AddConstant('DUPLICATE',DUPLICATE);
    AddConstant('DUPLICATE_DEREG',DUPLICATE_DEREG);
    AddConstant('LISTEN_OUTSTANDING',LISTEN_OUTSTANDING);
    AddConstant('CALL_PENDING',CALL_PENDING);
    AddConstant('SESSION_ESTABLISHED',SESSION_ESTABLISHED);
    AddConstant('HANGUP_PENDING',HANGUP_PENDING);
    AddConstant('HANGUP_COMPLETE',HANGUP_COMPLETE);
    AddConstant('SESSION_ABORTED',SESSION_ABORTED);
    AddConstant('ALL_TRANSPORTS',ALL_TRANSPORTS);
    AddConstant('MS_NBF',MS_NBF);
    AddConstant('NCBCALL',NCBCALL);
    AddConstant('NCBLISTEN',NCBLISTEN);
    AddConstant('NCBHANGUP',NCBHANGUP);
    AddConstant('NCBSEND',NCBSEND);
    AddConstant('NCBRECV',NCBRECV);
    AddConstant('NCBRECVANY',NCBRECVANY);
    AddConstant('NCBCHAINSEND',NCBCHAINSEND);
    AddConstant('NCBDGSEND',NCBDGSEND);
    AddConstant('NCBDGRECV',NCBDGRECV);
    AddConstant('NCBDGSENDBC',NCBDGSENDBC);
    AddConstant('NCBDGRECVBC',NCBDGRECVBC);
    AddConstant('NCBADDNAME',NCBADDNAME);
    AddConstant('NCBDELNAME',NCBDELNAME);
    AddConstant('NCBRESET',NCBRESET);
    AddConstant('NCBASTAT',NCBASTAT);
    AddConstant('NCBSSTAT',NCBSSTAT);
    AddConstant('NCBCANCEL',NCBCANCEL);
    AddConstant('NCBADDGRNAME',NCBADDGRNAME);
    AddConstant('NCBENUM',NCBENUM);
    AddConstant('NCBUNLINK',NCBUNLINK);
    AddConstant('NCBSENDNA',NCBSENDNA);
    AddConstant('NCBCHAINSENDNA',NCBCHAINSENDNA);
    AddConstant('NCBLANSTALERT',NCBLANSTALERT);
    AddConstant('NCBACTION',NCBACTION);
    AddConstant('NCBFINDNAME',NCBFINDNAME);
    AddConstant('NCBTRACE',NCBTRACE);
    AddConstant('ASYNCH',ASYNCH);
    AddConstant('NRC_GOODRET',NRC_GOODRET);
    AddConstant('NRC_BUFLEN',NRC_BUFLEN);
    AddConstant('NRC_ILLCMD',NRC_ILLCMD);
    AddConstant('NRC_CMDTMO',NRC_CMDTMO);
    AddConstant('NRC_INCOMP',NRC_INCOMP);
    AddConstant('NRC_BADDR',NRC_BADDR);
    AddConstant('NRC_SNUMOUT',NRC_SNUMOUT);
    AddConstant('NRC_NORES',NRC_NORES);
    AddConstant('NRC_SCLOSED',NRC_SCLOSED);
    AddConstant('NRC_CMDCAN',NRC_CMDCAN);
    AddConstant('NRC_DUPNAME',NRC_DUPNAME);
    AddConstant('NRC_NAMTFUL',NRC_NAMTFUL);
    AddConstant('NRC_ACTSES',NRC_ACTSES);
    AddConstant('NRC_LOCTFUL',NRC_LOCTFUL);
    AddConstant('NRC_REMTFUL',NRC_REMTFUL);
    AddConstant('NRC_ILLNN',NRC_ILLNN);
    AddConstant('NRC_NOCALL',NRC_NOCALL);
    AddConstant('NRC_NOWILD',NRC_NOWILD);
    AddConstant('NRC_INUSE',NRC_INUSE);
    AddConstant('NRC_NAMERR',NRC_NAMERR);
    AddConstant('NRC_SABORT',NRC_SABORT);
    AddConstant('NRC_NAMCONF',NRC_NAMCONF);
    AddConstant('NRC_IFBUSY',NRC_IFBUSY);
    AddConstant('NRC_TOOMANY',NRC_TOOMANY);
    AddConstant('NRC_BRIDGE',NRC_BRIDGE);
    AddConstant('NRC_CANOCCR',NRC_CANOCCR);
    AddConstant('NRC_CANCEL',NRC_CANCEL);
    AddConstant('NRC_DUPENV',NRC_DUPENV);
    AddConstant('NRC_ENVNOTDEF',NRC_ENVNOTDEF);
    AddConstant('NRC_OSRESNOTAV',NRC_OSRESNOTAV);
    AddConstant('NRC_MAXAPPS',NRC_MAXAPPS);
    AddConstant('NRC_NOSAPS',NRC_NOSAPS);
    AddConstant('NRC_NORESOURCES',NRC_NORESOURCES);
    AddConstant('NRC_INVADDRESS',NRC_INVADDRESS);
    AddConstant('NRC_INVDDID',NRC_INVDDID);
    AddConstant('NRC_LOCKFAIL',NRC_LOCKFAIL);
    AddConstant('NRC_OPENERR',NRC_OPENERR);
    AddConstant('NRC_SYSTEM',NRC_SYSTEM);
    AddConstant('NRC_PENDING',NRC_PENDING);
  end;
end;

class function TatNb30Library.LibraryName: string;
begin
  result := 'Nb30';
end;

initialization
  RegisterScripterLibrary(TatNb30Library, True);

{$WARNINGS ON}

end.

