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
unit ap_IBHeader;

interface

uses
  IBExternals,
  IBHeader,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatIBHeaderLibrary = class(TatScripterLibrary)
    procedure __XSQLDA_LENGTH(AMachine: TatVirtualMachine);
    procedure __add_spb_length(AMachine: TatVirtualMachine);
    procedure __add_spb_numeric(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TISC_TIMESTAMPWrapper = class(TatRecordWrapper)
  private
    Ftimestamp_date: ISC_DATE;
    Ftimestamp_time: ISC_TIME;
  public
    constructor Create(ARecord: TISC_TIMESTAMP);
    function ObjToRec: TISC_TIMESTAMP;
  published
    property timestamp_date: ISC_DATE read Ftimestamp_date write Ftimestamp_date;
    property timestamp_time: ISC_TIME read Ftimestamp_time write Ftimestamp_time;
  end;
  
  TGDS_QUADWrapper = class(TatRecordWrapper)
  private
    Fgds_quad_high: ISC_LONG;
    Fgds_quad_low: UISC_LONG;
  public
    constructor Create(ARecord: TGDS_QUAD);
    function ObjToRec: TGDS_QUAD;
  published
    property gds_quad_high: ISC_LONG read Fgds_quad_high write Fgds_quad_high;
    property gds_quad_low: UISC_LONG read Fgds_quad_low write Fgds_quad_low;
  end;
  
  TISC_ARRAY_BOUNDWrapper = class(TatRecordWrapper)
  private
    Farray_bound_lower: Short;
    Farray_bound_upper: Short;
  public
    constructor Create(ARecord: TISC_ARRAY_BOUND);
    function ObjToRec: TISC_ARRAY_BOUND;
  published
    property array_bound_lower: Short read Farray_bound_lower write Farray_bound_lower;
    property array_bound_upper: Short read Farray_bound_upper write Farray_bound_upper;
  end;
  
  TISC_ARRAY_DESCWrapper = class(TatRecordWrapper)
  private
    Farray_desc_dtype: UChar;
    Farray_desc_scale: Char;
    Farray_desc_length: UShort;
    Farray_desc_dimensions: Short;
    Farray_desc_flags: Short;
  public
    constructor Create(ARecord: TISC_ARRAY_DESC);
    function ObjToRec: TISC_ARRAY_DESC;
  published
    property array_desc_dtype: UChar read Farray_desc_dtype write Farray_desc_dtype;
    property array_desc_scale: Char read Farray_desc_scale write Farray_desc_scale;
    property array_desc_length: UShort read Farray_desc_length write Farray_desc_length;
    property array_desc_dimensions: Short read Farray_desc_dimensions write Farray_desc_dimensions;
    property array_desc_flags: Short read Farray_desc_flags write Farray_desc_flags;
  end;
  
  TISC_BLOB_DESCWrapper = class(TatRecordWrapper)
  private
    Fblob_desc_subtype: Short;
    Fblob_desc_charset: Short;
    Fblob_desc_segment_size: Short;
  public
    constructor Create(ARecord: TISC_BLOB_DESC);
    function ObjToRec: TISC_BLOB_DESC;
  published
    property blob_desc_subtype: Short read Fblob_desc_subtype write Fblob_desc_subtype;
    property blob_desc_charset: Short read Fblob_desc_charset write Fblob_desc_charset;
    property blob_desc_segment_size: Short read Fblob_desc_segment_size write Fblob_desc_segment_size;
  end;
  
  TISC_BLOB_CTLWrapper = class(TatRecordWrapper)
  private
    Fctl_to_sub_type: Short;
    Fctl_from_sub_type: Short;
    Fctl_buffer_length: UShort;
    Fctl_segment_length: UShort;
    Fctl_bpb_length: UShort;
    Fctl_max_segment: ISC_LONG;
    Fctl_number_segments: ISC_LONG;
    Fctl_total_length: ISC_LONG;
  public
    constructor Create(ARecord: TISC_BLOB_CTL);
    function ObjToRec: TISC_BLOB_CTL;
  published
    property ctl_to_sub_type: Short read Fctl_to_sub_type write Fctl_to_sub_type;
    property ctl_from_sub_type: Short read Fctl_from_sub_type write Fctl_from_sub_type;
    property ctl_buffer_length: UShort read Fctl_buffer_length write Fctl_buffer_length;
    property ctl_segment_length: UShort read Fctl_segment_length write Fctl_segment_length;
    property ctl_bpb_length: UShort read Fctl_bpb_length write Fctl_bpb_length;
    property ctl_max_segment: ISC_LONG read Fctl_max_segment write Fctl_max_segment;
    property ctl_number_segments: ISC_LONG read Fctl_number_segments write Fctl_number_segments;
    property ctl_total_length: ISC_LONG read Fctl_total_length write Fctl_total_length;
  end;
  
  TBSTREAMWrapper = class(TatRecordWrapper)
  private
    Fbstr_length: Short;
    Fbstr_cnt: Short;
    Fbstr_mode: Char;
  public
    constructor Create(ARecord: TBSTREAM);
    function ObjToRec: TBSTREAM;
  published
    property bstr_length: Short read Fbstr_length write Fbstr_length;
    property bstr_cnt: Short read Fbstr_cnt write Fbstr_cnt;
    property bstr_mode: Char read Fbstr_mode write Fbstr_mode;
  end;
  
  TXSQLVARWrapper = class(TatRecordWrapper)
  private
    Fsqltype: Short;
    Fsqlscale: Short;
    Fsqlsubtype: Short;
    Fsqllen: Short;
    Fsqlname_length: Short;
    Frelname_length: Short;
    Fownname_length: Short;
    Faliasname_length: Short;
  public
    constructor Create(ARecord: TXSQLVAR);
    function ObjToRec: TXSQLVAR;
  published
    property sqltype: Short read Fsqltype write Fsqltype;
    property sqlscale: Short read Fsqlscale write Fsqlscale;
    property sqlsubtype: Short read Fsqlsubtype write Fsqlsubtype;
    property sqllen: Short read Fsqllen write Fsqllen;
    property sqlname_length: Short read Fsqlname_length write Fsqlname_length;
    property relname_length: Short read Frelname_length write Frelname_length;
    property ownname_length: Short read Fownname_length write Fownname_length;
    property aliasname_length: Short read Faliasname_length write Faliasname_length;
  end;
  
  TXSQLDAWrapper = class(TatRecordWrapper)
  private
    Fversion: Short;
    Fsqldabc: ISC_LONG;
    Fsqln: Short;
    Fsqld: Short;
  public
    constructor Create(ARecord: TXSQLDA);
    function ObjToRec: TXSQLDA;
  published
    property version: Short read Fversion write Fversion;
    property sqldabc: ISC_LONG read Fsqldabc write Fsqldabc;
    property sqln: Short read Fsqln write Fsqln;
    property sqld: Short read Fsqld write Fsqld;
  end;
  
  TISC_START_TRANSWrapper = class(TatRecordWrapper)
  private
    Ftpb_length: UShort;
  public
    constructor Create(ARecord: TISC_START_TRANS);
    function ObjToRec: TISC_START_TRANS;
  published
    property tpb_length: UShort read Ftpb_length write Ftpb_length;
  end;
  
  TISC_TEBWrapper = class(TatRecordWrapper)
  private
    Ftpb_length: Long;
  public
    constructor Create(ARecord: TISC_TEB);
    function ObjToRec: TISC_TEB;
  published
    property tpb_length: Long read Ftpb_length write Ftpb_length;
  end;
  
  TUserSecDataWrapper = class(TatRecordWrapper)
  private
    Fsec_flags: Short;
    Fuid: Int;
    Fgid: int;
    Fprotocol: Int;
  public
    constructor Create(ARecord: TUserSecData);
    function ObjToRec: TUserSecData;
  published
    property sec_flags: Short read Fsec_flags write Fsec_flags;
    property uid: Int read Fuid write Fuid;
    property gid: int read Fgid write Fgid;
    property protocol: Int read Fprotocol write Fprotocol;
  end;
  

implementation

constructor TISC_TIMESTAMPWrapper.Create(ARecord: TISC_TIMESTAMP);
begin
  inherited Create;
  Ftimestamp_date := ARecord.timestamp_date;
  Ftimestamp_time := ARecord.timestamp_time;
end;

function TISC_TIMESTAMPWrapper.ObjToRec: TISC_TIMESTAMP;
begin
  result.timestamp_date := Ftimestamp_date;
  result.timestamp_time := Ftimestamp_time;
end;

constructor TGDS_QUADWrapper.Create(ARecord: TGDS_QUAD);
begin
  inherited Create;
  Fgds_quad_high := ARecord.gds_quad_high;
  Fgds_quad_low := ARecord.gds_quad_low;
end;

function TGDS_QUADWrapper.ObjToRec: TGDS_QUAD;
begin
  result.gds_quad_high := Fgds_quad_high;
  result.gds_quad_low := Fgds_quad_low;
end;

constructor TISC_ARRAY_BOUNDWrapper.Create(ARecord: TISC_ARRAY_BOUND);
begin
  inherited Create;
  Farray_bound_lower := ARecord.array_bound_lower;
  Farray_bound_upper := ARecord.array_bound_upper;
end;

function TISC_ARRAY_BOUNDWrapper.ObjToRec: TISC_ARRAY_BOUND;
begin
  result.array_bound_lower := Farray_bound_lower;
  result.array_bound_upper := Farray_bound_upper;
end;

constructor TISC_ARRAY_DESCWrapper.Create(ARecord: TISC_ARRAY_DESC);
begin
  inherited Create;
  Farray_desc_dtype := ARecord.array_desc_dtype;
  Farray_desc_scale := ARecord.array_desc_scale;
  Farray_desc_length := ARecord.array_desc_length;
  Farray_desc_dimensions := ARecord.array_desc_dimensions;
  Farray_desc_flags := ARecord.array_desc_flags;
end;

function TISC_ARRAY_DESCWrapper.ObjToRec: TISC_ARRAY_DESC;
begin
  result.array_desc_dtype := Farray_desc_dtype;
  result.array_desc_scale := Farray_desc_scale;
  result.array_desc_length := Farray_desc_length;
  result.array_desc_dimensions := Farray_desc_dimensions;
  result.array_desc_flags := Farray_desc_flags;
end;

constructor TISC_BLOB_DESCWrapper.Create(ARecord: TISC_BLOB_DESC);
begin
  inherited Create;
  Fblob_desc_subtype := ARecord.blob_desc_subtype;
  Fblob_desc_charset := ARecord.blob_desc_charset;
  Fblob_desc_segment_size := ARecord.blob_desc_segment_size;
end;

function TISC_BLOB_DESCWrapper.ObjToRec: TISC_BLOB_DESC;
begin
  result.blob_desc_subtype := Fblob_desc_subtype;
  result.blob_desc_charset := Fblob_desc_charset;
  result.blob_desc_segment_size := Fblob_desc_segment_size;
end;

constructor TISC_BLOB_CTLWrapper.Create(ARecord: TISC_BLOB_CTL);
begin
  inherited Create;
  Fctl_to_sub_type := ARecord.ctl_to_sub_type;
  Fctl_from_sub_type := ARecord.ctl_from_sub_type;
  Fctl_buffer_length := ARecord.ctl_buffer_length;
  Fctl_segment_length := ARecord.ctl_segment_length;
  Fctl_bpb_length := ARecord.ctl_bpb_length;
  Fctl_max_segment := ARecord.ctl_max_segment;
  Fctl_number_segments := ARecord.ctl_number_segments;
  Fctl_total_length := ARecord.ctl_total_length;
end;

function TISC_BLOB_CTLWrapper.ObjToRec: TISC_BLOB_CTL;
begin
  result.ctl_to_sub_type := Fctl_to_sub_type;
  result.ctl_from_sub_type := Fctl_from_sub_type;
  result.ctl_buffer_length := Fctl_buffer_length;
  result.ctl_segment_length := Fctl_segment_length;
  result.ctl_bpb_length := Fctl_bpb_length;
  result.ctl_max_segment := Fctl_max_segment;
  result.ctl_number_segments := Fctl_number_segments;
  result.ctl_total_length := Fctl_total_length;
end;

constructor TBSTREAMWrapper.Create(ARecord: TBSTREAM);
begin
  inherited Create;
  Fbstr_length := ARecord.bstr_length;
  Fbstr_cnt := ARecord.bstr_cnt;
  Fbstr_mode := ARecord.bstr_mode;
end;

function TBSTREAMWrapper.ObjToRec: TBSTREAM;
begin
  result.bstr_length := Fbstr_length;
  result.bstr_cnt := Fbstr_cnt;
  result.bstr_mode := Fbstr_mode;
end;

constructor TXSQLVARWrapper.Create(ARecord: TXSQLVAR);
begin
  inherited Create;
  Fsqltype := ARecord.sqltype;
  Fsqlscale := ARecord.sqlscale;
  Fsqlsubtype := ARecord.sqlsubtype;
  Fsqllen := ARecord.sqllen;
  Fsqlname_length := ARecord.sqlname_length;
  Frelname_length := ARecord.relname_length;
  Fownname_length := ARecord.ownname_length;
  Faliasname_length := ARecord.aliasname_length;
end;

function TXSQLVARWrapper.ObjToRec: TXSQLVAR;
begin
  result.sqltype := Fsqltype;
  result.sqlscale := Fsqlscale;
  result.sqlsubtype := Fsqlsubtype;
  result.sqllen := Fsqllen;
  result.sqlname_length := Fsqlname_length;
  result.relname_length := Frelname_length;
  result.ownname_length := Fownname_length;
  result.aliasname_length := Faliasname_length;
end;

constructor TXSQLDAWrapper.Create(ARecord: TXSQLDA);
begin
  inherited Create;
  Fversion := ARecord.version;
  Fsqldabc := ARecord.sqldabc;
  Fsqln := ARecord.sqln;
  Fsqld := ARecord.sqld;
end;

function TXSQLDAWrapper.ObjToRec: TXSQLDA;
begin
  result.version := Fversion;
  result.sqldabc := Fsqldabc;
  result.sqln := Fsqln;
  result.sqld := Fsqld;
end;

constructor TISC_START_TRANSWrapper.Create(ARecord: TISC_START_TRANS);
begin
  inherited Create;
  Ftpb_length := ARecord.tpb_length;
end;

function TISC_START_TRANSWrapper.ObjToRec: TISC_START_TRANS;
begin
  result.tpb_length := Ftpb_length;
end;

constructor TISC_TEBWrapper.Create(ARecord: TISC_TEB);
begin
  inherited Create;
  Ftpb_length := ARecord.tpb_length;
end;

function TISC_TEBWrapper.ObjToRec: TISC_TEB;
begin
  result.tpb_length := Ftpb_length;
end;

constructor TUserSecDataWrapper.Create(ARecord: TUserSecData);
begin
  inherited Create;
  Fsec_flags := ARecord.sec_flags;
  Fuid := ARecord.uid;
  Fgid := ARecord.gid;
  Fprotocol := ARecord.protocol;
end;

function TUserSecDataWrapper.ObjToRec: TUserSecData;
begin
  result.sec_flags := Fsec_flags;
  result.uid := Fuid;
  result.gid := Fgid;
  result.protocol := Fprotocol;
end;



procedure TatIBHeaderLibrary.__XSQLDA_LENGTH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IBHeader.XSQLDA_LENGTH(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBHeaderLibrary.__add_spb_length(AMachine: TatVirtualMachine);
  var
  Param0: PChar;
begin
  with AMachine do
  begin
Param0 := PChar(VarToStr(GetInputArg(0)));
    IBHeader.add_spb_length(Param0,VarToInteger(GetInputArg(1)));
    SetInputArg(0,string(Param0));
  end;
end;

procedure TatIBHeaderLibrary.__add_spb_numeric(AMachine: TatVirtualMachine);
  var
  Param0: PChar;
begin
  with AMachine do
  begin
Param0 := PChar(VarToStr(GetInputArg(0)));
    IBHeader.add_spb_numeric(Param0,VarToInteger(GetInputArg(1)));
    SetInputArg(0,string(Param0));
  end;
end;

procedure TatIBHeaderLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('XSQLDA_LENGTH',1,tkInteger,nil,__XSQLDA_LENGTH,false,0);
    DefineMethod('add_spb_length',2,tkNone,nil,__add_spb_length,false,0).SetVarArgs([0]);
    DefineMethod('add_spb_numeric',2,tkNone,nil,__add_spb_numeric,false,0).SetVarArgs([0]);
    AddConstant('ISC_TRUE',ISC_TRUE);
    AddConstant('ISC_FALSE',ISC_FALSE);
    AddConstant('DSQL_close',DSQL_close);
    AddConstant('DSQL_drop',DSQL_drop);
    AddConstant('IBASE_DLL',IBASE_DLL);
    AddConstant('SQLDA_VERSION1',SQLDA_VERSION1);
    AddConstant('SQLDA_VERSION2',SQLDA_VERSION2);
    AddConstant('SQL_DIALECT_V5',SQL_DIALECT_V5);
    AddConstant('SQL_DIALECT_V6_TRANSITION',SQL_DIALECT_V6_TRANSITION);
    AddConstant('SQL_DIALECT_V6',SQL_DIALECT_V6);
    AddConstant('SQL_DIALECT_CURRENT',SQL_DIALECT_CURRENT);
    AddConstant('TIME_SECONDS_PRECISION',TIME_SECONDS_PRECISION);
    AddConstant('TIME_SECONDS_PRECISION_SCALE',TIME_SECONDS_PRECISION_SCALE);
    AddConstant('sec_uid_spec',sec_uid_spec);
    AddConstant('sec_gid_spec',sec_gid_spec);
    AddConstant('sec_server_spec',sec_server_spec);
    AddConstant('sec_password_spec',sec_password_spec);
    AddConstant('sec_group_name_spec',sec_group_name_spec);
    AddConstant('sec_first_name_spec',sec_first_name_spec);
    AddConstant('sec_middle_name_spec',sec_middle_name_spec);
    AddConstant('sec_last_name_spec',sec_last_name_spec);
    AddConstant('sec_dba_user_name_spec',sec_dba_user_name_spec);
    AddConstant('sec_dba_password_spec',sec_dba_password_spec);
    AddConstant('sec_protocol_tcpip',sec_protocol_tcpip);
    AddConstant('sec_protocol_netbeui',sec_protocol_netbeui);
    AddConstant('sec_protocol_spx',sec_protocol_spx);
    AddConstant('sec_protocol_local',sec_protocol_local);
    AddConstant('isc_blob_filter_open',isc_blob_filter_open);
    AddConstant('isc_blob_filter_get_segment',isc_blob_filter_get_segment);
    AddConstant('isc_blob_filter_close',isc_blob_filter_close);
    AddConstant('isc_blob_filter_create',isc_blob_filter_create);
    AddConstant('isc_blob_filter_put_segment',isc_blob_filter_put_segment);
    AddConstant('isc_blob_filter_alloc',isc_blob_filter_alloc);
    AddConstant('isc_blob_filter_free',isc_blob_filter_free);
    AddConstant('isc_blob_filter_seek',isc_blob_filter_seek);
    AddConstant('blr_text',blr_text);
    AddConstant('blr_text2',blr_text2);
    AddConstant('blr_short',blr_short);
    AddConstant('blr_long',blr_long);
    AddConstant('blr_quad',blr_quad);
    AddConstant('blr_float',blr_float);
    AddConstant('blr_double',blr_double);
    AddConstant('blr_d_float',blr_d_float);
    AddConstant('blr_timestamp',blr_timestamp);
    AddConstant('blr_varying',blr_varying);
    AddConstant('blr_varying2',blr_varying2);
    AddConstant('blr_blob',blr_blob);
    AddConstant('blr_cstring',blr_cstring);
    AddConstant('blr_cstring2',blr_cstring2);
    AddConstant('blr_blob_id',blr_blob_id);
    AddConstant('blr_sql_date',blr_sql_date);
    AddConstant('blr_sql_time',blr_sql_time);
    AddConstant('blr_int64',blr_int64);
    AddConstant('blr_date',blr_date);
    AddConstant('blr_inner',blr_inner);
    AddConstant('blr_left',blr_left);
    AddConstant('blr_right',blr_right);
    AddConstant('blr_full',blr_full);
    AddConstant('blr_gds_code',blr_gds_code);
    AddConstant('blr_sql_code',blr_sql_code);
    AddConstant('blr_exception',blr_exception);
    AddConstant('blr_trigger_code',blr_trigger_code);
    AddConstant('blr_default_code',blr_default_code);
    AddConstant('blr_version4',blr_version4);
    AddConstant('blr_version5',blr_version5);
    AddConstant('blr_eoc',blr_eoc);
    AddConstant('blr_end',blr_end);
    AddConstant('blr_assignment',blr_assignment);
    AddConstant('blr_begin',blr_begin);
    AddConstant('blr_dcl_variable',blr_dcl_variable);
    AddConstant('blr_message',blr_message);
    AddConstant('blr_erase',blr_erase);
    AddConstant('blr_fetch',blr_fetch);
    AddConstant('blr_for',blr_for);
    AddConstant('blr_if',blr_if);
    AddConstant('blr_loop',blr_loop);
    AddConstant('blr_modify',blr_modify);
    AddConstant('blr_handler',blr_handler);
    AddConstant('blr_receive',blr_receive);
    AddConstant('blr_select',blr_select);
    AddConstant('blr_send',blr_send);
    AddConstant('blr_store',blr_store);
    AddConstant('blr_label',blr_label);
    AddConstant('blr_leave',blr_leave);
    AddConstant('blr_store2',blr_store2);
    AddConstant('blr_post',blr_post);
    AddConstant('blr_literal',blr_literal);
    AddConstant('blr_dbkey',blr_dbkey);
    AddConstant('blr_field',blr_field);
    AddConstant('blr_fid',blr_fid);
    AddConstant('blr_parameter',blr_parameter);
    AddConstant('blr_variable',blr_variable);
    AddConstant('blr_average',blr_average);
    AddConstant('blr_count',blr_count);
    AddConstant('blr_maximum',blr_maximum);
    AddConstant('blr_minimum',blr_minimum);
    AddConstant('blr_total',blr_total);
    AddConstant('blr_add',blr_add);
    AddConstant('blr_subtract',blr_subtract);
    AddConstant('blr_multiply',blr_multiply);
    AddConstant('blr_divide',blr_divide);
    AddConstant('blr_negate',blr_negate);
    AddConstant('blr_concatenate',blr_concatenate);
    AddConstant('blr_substring',blr_substring);
    AddConstant('blr_parameter2',blr_parameter2);
    AddConstant('blr_from',blr_from);
    AddConstant('blr_via',blr_via);
    AddConstant('blr_user_name',blr_user_name);
    AddConstant('blr_null',blr_null);
    AddConstant('blr_eql',blr_eql);
    AddConstant('blr_neq',blr_neq);
    AddConstant('blr_gtr',blr_gtr);
    AddConstant('blr_geq',blr_geq);
    AddConstant('blr_lss',blr_lss);
    AddConstant('blr_leq',blr_leq);
    AddConstant('blr_containing',blr_containing);
    AddConstant('blr_matching',blr_matching);
    AddConstant('blr_starting',blr_starting);
    AddConstant('blr_between',blr_between);
    AddConstant('blr_or',blr_or);
    AddConstant('blr_and',blr_and);
    AddConstant('blr_not',blr_not);
    AddConstant('blr_any',blr_any);
    AddConstant('blr_missing',blr_missing);
    AddConstant('blr_unique',blr_unique);
    AddConstant('blr_like',blr_like);
    AddConstant('blr_stream',blr_stream);
    AddConstant('blr_set_index',blr_set_index);
    AddConstant('blr_rse',blr_rse);
    AddConstant('blr_first',blr_first);
    AddConstant('blr_project',blr_project);
    AddConstant('blr_sort',blr_sort);
    AddConstant('blr_boolean',blr_boolean);
    AddConstant('blr_ascending',blr_ascending);
    AddConstant('blr_descending',blr_descending);
    AddConstant('blr_relation',blr_relation);
    AddConstant('blr_rid',blr_rid);
    AddConstant('blr_union',blr_union);
    AddConstant('blr_map',blr_map);
    AddConstant('blr_group_by',blr_group_by);
    AddConstant('blr_aggregate',blr_aggregate);
    AddConstant('blr_join_type',blr_join_type);
    AddConstant('blr_agg_count',blr_agg_count);
    AddConstant('blr_agg_max',blr_agg_max);
    AddConstant('blr_agg_min',blr_agg_min);
    AddConstant('blr_agg_total',blr_agg_total);
    AddConstant('blr_agg_average',blr_agg_average);
    AddConstant('blr_parameter3',blr_parameter3);
    AddConstant('blr_run_count',blr_run_count);
    AddConstant('blr_run_max',blr_run_max);
    AddConstant('blr_run_min',blr_run_min);
    AddConstant('blr_run_total',blr_run_total);
    AddConstant('blr_run_average',blr_run_average);
    AddConstant('blr_agg_count2',blr_agg_count2);
    AddConstant('blr_agg_count_distinct',blr_agg_count_distinct);
    AddConstant('blr_agg_total_distinct',blr_agg_total_distinct);
    AddConstant('blr_agg_average_distinct',blr_agg_average_distinct);
    AddConstant('blr_function',blr_function);
    AddConstant('blr_gen_id',blr_gen_id);
    AddConstant('blr_prot_mask',blr_prot_mask);
    AddConstant('blr_upcase',blr_upcase);
    AddConstant('blr_lock_state',blr_lock_state);
    AddConstant('blr_value_if',blr_value_if);
    AddConstant('blr_matching2',blr_matching2);
    AddConstant('blr_index',blr_index);
    AddConstant('blr_ansi_like',blr_ansi_like);
    AddConstant('blr_bookmark',blr_bookmark);
    AddConstant('blr_crack',blr_crack);
    AddConstant('blr_force_crack',blr_force_crack);
    AddConstant('blr_seek',blr_seek);
    AddConstant('blr_find',blr_find);
    AddConstant('blr_continue',blr_continue);
    AddConstant('blr_forward',blr_forward);
    AddConstant('blr_backward',blr_backward);
    AddConstant('blr_bof_forward',blr_bof_forward);
    AddConstant('blr_eof_backward',blr_eof_backward);
    AddConstant('blr_lock_relation',blr_lock_relation);
    AddConstant('blr_lock_record',blr_lock_record);
    AddConstant('blr_set_bookmark',blr_set_bookmark);
    AddConstant('blr_get_bookmark',blr_get_bookmark);
    AddConstant('blr_rs_stream',blr_rs_stream);
    AddConstant('blr_exec_proc',blr_exec_proc);
    AddConstant('blr_begin_range',blr_begin_range);
    AddConstant('blr_end_range',blr_end_range);
    AddConstant('blr_delete_range',blr_delete_range);
    AddConstant('blr_procedure',blr_procedure);
    AddConstant('blr_pid',blr_pid);
    AddConstant('blr_exec_pid',blr_exec_pid);
    AddConstant('blr_singular',blr_singular);
    AddConstant('blr_abort',blr_abort);
    AddConstant('blr_block',blr_block);
    AddConstant('blr_error_handler',blr_error_handler);
    AddConstant('blr_cast',blr_cast);
    AddConstant('blr_release_lock',blr_release_lock);
    AddConstant('blr_release_locks',blr_release_locks);
    AddConstant('blr_start_savepoint',blr_start_savepoint);
    AddConstant('blr_end_savepoint',blr_end_savepoint);
    AddConstant('blr_find_dbkey',blr_find_dbkey);
    AddConstant('blr_range_relation',blr_range_relation);
    AddConstant('blr_delete_ranges',blr_delete_ranges);
    AddConstant('blr_plan',blr_plan);
    AddConstant('blr_merge',blr_merge);
    AddConstant('blr_join',blr_join);
    AddConstant('blr_sequential',blr_sequential);
    AddConstant('blr_navigational',blr_navigational);
    AddConstant('blr_indices',blr_indices);
    AddConstant('blr_retrieve',blr_retrieve);
    AddConstant('blr_relation2',blr_relation2);
    AddConstant('blr_rid2',blr_rid2);
    AddConstant('blr_reset_stream',blr_reset_stream);
    AddConstant('blr_release_bookmark',blr_release_bookmark);
    AddConstant('blr_set_generator',blr_set_generator);
    AddConstant('blr_ansi_any',blr_ansi_any);
    AddConstant('blr_exists',blr_exists);
    AddConstant('blr_cardinality',blr_cardinality);
    AddConstant('blr_record_version',blr_record_version);
    AddConstant('blr_stall',blr_stall);
    AddConstant('blr_seek_no_warn',blr_seek_no_warn);
    AddConstant('blr_find_dbkey_version',blr_find_dbkey_version);
    AddConstant('blr_ansi_all',blr_ansi_all);
    AddConstant('blr_extract',blr_extract);
    AddConstant('blr_extract_year',blr_extract_year);
    AddConstant('blr_extract_month',blr_extract_month);
    AddConstant('blr_extract_day',blr_extract_day);
    AddConstant('blr_extract_hour',blr_extract_hour);
    AddConstant('blr_extract_minute',blr_extract_minute);
    AddConstant('blr_extract_second',blr_extract_second);
    AddConstant('blr_extract_weekday',blr_extract_weekday);
    AddConstant('blr_extract_yearday',blr_extract_yearday);
    AddConstant('blr_current_date',blr_current_date);
    AddConstant('blr_current_timestamp',blr_current_timestamp);
    AddConstant('blr_current_time',blr_current_time);
    AddConstant('blr_add2',blr_add2);
    AddConstant('blr_subtract2',blr_subtract2);
    AddConstant('blr_multiply2',blr_multiply2);
    AddConstant('blr_divide2',blr_divide2);
    AddConstant('blr_agg_total2',blr_agg_total2);
    AddConstant('blr_agg_total_distinct2',blr_agg_total_distinct2);
    AddConstant('blr_agg_average2',blr_agg_average2);
    AddConstant('blr_agg_average_distinct2',blr_agg_average_distinct2);
    AddConstant('blr_average2',blr_average2);
    AddConstant('blr_gen_id2',blr_gen_id2);
    AddConstant('blr_set_generator2',blr_set_generator2);
    AddConstant('isc_dpb_version1',isc_dpb_version1);
    AddConstant('isc_dpb_cdd_pathname',isc_dpb_cdd_pathname);
    AddConstant('isc_dpb_allocation',isc_dpb_allocation);
    AddConstant('isc_dpb_journal',isc_dpb_journal);
    AddConstant('isc_dpb_page_size',isc_dpb_page_size);
    AddConstant('isc_dpb_num_buffers',isc_dpb_num_buffers);
    AddConstant('isc_dpb_buffer_length',isc_dpb_buffer_length);
    AddConstant('isc_dpb_debug',isc_dpb_debug);
    AddConstant('isc_dpb_garbage_collect',isc_dpb_garbage_collect);
    AddConstant('isc_dpb_verify',isc_dpb_verify);
    AddConstant('isc_dpb_sweep',isc_dpb_sweep);
    AddConstant('isc_dpb_enable_journal',isc_dpb_enable_journal);
    AddConstant('isc_dpb_disable_journal',isc_dpb_disable_journal);
    AddConstant('isc_dpb_dbkey_scope',isc_dpb_dbkey_scope);
    AddConstant('isc_dpb_number_of_users',isc_dpb_number_of_users);
    AddConstant('isc_dpb_trace',isc_dpb_trace);
    AddConstant('isc_dpb_no_garbage_collect',isc_dpb_no_garbage_collect);
    AddConstant('isc_dpb_damaged',isc_dpb_damaged);
    AddConstant('isc_dpb_license',isc_dpb_license);
    AddConstant('isc_dpb_sys_user_name',isc_dpb_sys_user_name);
    AddConstant('isc_dpb_encrypt_key',isc_dpb_encrypt_key);
    AddConstant('isc_dpb_activate_shadow',isc_dpb_activate_shadow);
    AddConstant('isc_dpb_sweep_interval',isc_dpb_sweep_interval);
    AddConstant('isc_dpb_delete_shadow',isc_dpb_delete_shadow);
    AddConstant('isc_dpb_force_write',isc_dpb_force_write);
    AddConstant('isc_dpb_begin_log',isc_dpb_begin_log);
    AddConstant('isc_dpb_quit_log',isc_dpb_quit_log);
    AddConstant('isc_dpb_no_reserve',isc_dpb_no_reserve);
    AddConstant('isc_dpb_user_name',isc_dpb_user_name);
    AddConstant('isc_dpb_password',isc_dpb_password);
    AddConstant('isc_dpb_password_enc',isc_dpb_password_enc);
    AddConstant('isc_dpb_sys_user_name_enc',isc_dpb_sys_user_name_enc);
    AddConstant('isc_dpb_interp',isc_dpb_interp);
    AddConstant('isc_dpb_online_dump',isc_dpb_online_dump);
    AddConstant('isc_dpb_old_file_size',isc_dpb_old_file_size);
    AddConstant('isc_dpb_old_num_files',isc_dpb_old_num_files);
    AddConstant('isc_dpb_old_file',isc_dpb_old_file);
    AddConstant('isc_dpb_old_start_page',isc_dpb_old_start_page);
    AddConstant('isc_dpb_old_start_seqno',isc_dpb_old_start_seqno);
    AddConstant('isc_dpb_old_start_file',isc_dpb_old_start_file);
    AddConstant('isc_dpb_drop_walfile',isc_dpb_drop_walfile);
    AddConstant('isc_dpb_old_dump_id',isc_dpb_old_dump_id);
    AddConstant('isc_dpb_wal_backup_dir',isc_dpb_wal_backup_dir);
    AddConstant('isc_dpb_wal_chkptlen',isc_dpb_wal_chkptlen);
    AddConstant('isc_dpb_wal_numbufs',isc_dpb_wal_numbufs);
    AddConstant('isc_dpb_wal_bufsize',isc_dpb_wal_bufsize);
    AddConstant('isc_dpb_wal_grp_cmt_wait',isc_dpb_wal_grp_cmt_wait);
    AddConstant('isc_dpb_lc_messages',isc_dpb_lc_messages);
    AddConstant('isc_dpb_lc_ctype',isc_dpb_lc_ctype);
    AddConstant('isc_dpb_cache_manager',isc_dpb_cache_manager);
    AddConstant('isc_dpb_shutdown',isc_dpb_shutdown);
    AddConstant('isc_dpb_online',isc_dpb_online);
    AddConstant('isc_dpb_shutdown_delay',isc_dpb_shutdown_delay);
    AddConstant('isc_dpb_reserved',isc_dpb_reserved);
    AddConstant('isc_dpb_overwrite',isc_dpb_overwrite);
    AddConstant('isc_dpb_sec_attach',isc_dpb_sec_attach);
    AddConstant('isc_dpb_disable_wal',isc_dpb_disable_wal);
    AddConstant('isc_dpb_connect_timeout',isc_dpb_connect_timeout);
    AddConstant('isc_dpb_dummy_packet_interval',isc_dpb_dummy_packet_interval);
    AddConstant('isc_dpb_gbak_attach',isc_dpb_gbak_attach);
    AddConstant('isc_dpb_sql_role_name',isc_dpb_sql_role_name);
    AddConstant('isc_dpb_set_page_buffers',isc_dpb_set_page_buffers);
    AddConstant('isc_dpb_working_directory',isc_dpb_working_directory);
    AddConstant('isc_dpb_SQL_dialect',isc_dpb_SQL_dialect);
    AddConstant('isc_dpb_set_db_readonly',isc_dpb_set_db_readonly);
    AddConstant('isc_dpb_set_db_SQL_dialect',isc_dpb_set_db_SQL_dialect);
    AddConstant('isc_dpb_gfix_attach',isc_dpb_gfix_attach);
    AddConstant('isc_dpb_gstat_attach',isc_dpb_gstat_attach);
    AddConstant('isc_dpb_last_dpb_constant',isc_dpb_last_dpb_constant);
    AddConstant('isc_dpb_pages',isc_dpb_pages);
    AddConstant('isc_dpb_records',isc_dpb_records);
    AddConstant('isc_dpb_indices',isc_dpb_indices);
    AddConstant('isc_dpb_transactions',isc_dpb_transactions);
    AddConstant('isc_dpb_no_update',isc_dpb_no_update);
    AddConstant('isc_dpb_repair',isc_dpb_repair);
    AddConstant('isc_dpb_ignore',isc_dpb_ignore);
    AddConstant('isc_dpb_shut_cache',isc_dpb_shut_cache);
    AddConstant('isc_dpb_shut_attachment',isc_dpb_shut_attachment);
    AddConstant('isc_dpb_shut_transaction',isc_dpb_shut_transaction);
    AddConstant('isc_dpb_shut_force',isc_dpb_shut_force);
    AddConstant('RDB_system',RDB_system);
    AddConstant('RDB_id_assigned',RDB_id_assigned);
    AddConstant('isc_tpb_version1',isc_tpb_version1);
    AddConstant('isc_tpb_version3',isc_tpb_version3);
    AddConstant('isc_tpb_consistency',isc_tpb_consistency);
    AddConstant('isc_tpb_concurrency',isc_tpb_concurrency);
    AddConstant('isc_tpb_shared',isc_tpb_shared);
    AddConstant('isc_tpb_protected',isc_tpb_protected);
    AddConstant('isc_tpb_exclusive',isc_tpb_exclusive);
    AddConstant('isc_tpb_wait',isc_tpb_wait);
    AddConstant('isc_tpb_nowait',isc_tpb_nowait);
    AddConstant('isc_tpb_read',isc_tpb_read);
    AddConstant('isc_tpb_write',isc_tpb_write);
    AddConstant('isc_tpb_lock_read',isc_tpb_lock_read);
    AddConstant('isc_tpb_lock_write',isc_tpb_lock_write);
    AddConstant('isc_tpb_verb_time',isc_tpb_verb_time);
    AddConstant('isc_tpb_commit_time',isc_tpb_commit_time);
    AddConstant('isc_tpb_ignore_limbo',isc_tpb_ignore_limbo);
    AddConstant('isc_tpb_read_committed',isc_tpb_read_committed);
    AddConstant('isc_tpb_autocommit',isc_tpb_autocommit);
    AddConstant('isc_tpb_rec_version',isc_tpb_rec_version);
    AddConstant('isc_tpb_no_rec_version',isc_tpb_no_rec_version);
    AddConstant('isc_tpb_restart_requests',isc_tpb_restart_requests);
    AddConstant('isc_tpb_no_auto_undo',isc_tpb_no_auto_undo);
    AddConstant('isc_tpb_last_tpb_constant',isc_tpb_last_tpb_constant);
    AddConstant('isc_bpb_version1',isc_bpb_version1);
    AddConstant('isc_bpb_source_type',isc_bpb_source_type);
    AddConstant('isc_bpb_target_type',isc_bpb_target_type);
    AddConstant('isc_bpb_type',isc_bpb_type);
    AddConstant('isc_bpb_source_interp',isc_bpb_source_interp);
    AddConstant('isc_bpb_target_interp',isc_bpb_target_interp);
    AddConstant('isc_bpb_filter_parameter',isc_bpb_filter_parameter);
    AddConstant('isc_bpb_type_segmented',isc_bpb_type_segmented);
    AddConstant('isc_bpb_type_stream',isc_bpb_type_stream);
    AddConstant('isc_spb_user_name',isc_spb_user_name);
    AddConstant('isc_spb_sys_user_name',isc_spb_sys_user_name);
    AddConstant('isc_spb_sys_user_name_enc',isc_spb_sys_user_name_enc);
    AddConstant('isc_spb_password',isc_spb_password);
    AddConstant('isc_spb_password_enc',isc_spb_password_enc);
    AddConstant('isc_spb_command_line',isc_spb_command_line);
    AddConstant('isc_spb_dbname',isc_spb_dbname);
    AddConstant('isc_spb_verbose',isc_spb_verbose);
    AddConstant('isc_spb_options',isc_spb_options);
    AddConstant('isc_spb_connect_timeout',isc_spb_connect_timeout);
    AddConstant('isc_spb_dummy_packet_interval',isc_spb_dummy_packet_interval);
    AddConstant('isc_spb_sql_role_name',isc_spb_sql_role_name);
    AddConstant('isc_spb_last_spb_constant',isc_spb_last_spb_constant);
    AddConstant('isc_spb_version1',isc_spb_version1);
    AddConstant('isc_spb_current_version',isc_spb_current_version);
    AddConstant('isc_spb_version',isc_spb_version);
    AddConstant('isc_spb_user_name_mapped_to_server',isc_spb_user_name_mapped_to_server);
    AddConstant('isc_spb_sys_user_name_mapped_to_server',isc_spb_sys_user_name_mapped_to_server);
    AddConstant('isc_spb_sys_user_name_enc_mapped_to_server',isc_spb_sys_user_name_enc_mapped_to_server);
    AddConstant('isc_spb_password_mapped_to_server',isc_spb_password_mapped_to_server);
    AddConstant('isc_spb_password_enc_mapped_to_server',isc_spb_password_enc_mapped_to_server);
    AddConstant('isc_spb_command_line_mapped_to_server',isc_spb_command_line_mapped_to_server);
    AddConstant('isc_spb_dbname_mapped_to_server',isc_spb_dbname_mapped_to_server);
    AddConstant('isc_spb_verbose_mapped_to_server',isc_spb_verbose_mapped_to_server);
    AddConstant('isc_spb_options_mapped_to_server',isc_spb_options_mapped_to_server);
    AddConstant('isc_spb_connect_timeout_mapped_to_server',isc_spb_connect_timeout_mapped_to_server);
    AddConstant('isc_spb_dummy_packet_interval_mapped_to_server',isc_spb_dummy_packet_interval_mapped_to_server);
    AddConstant('isc_spb_sql_role_name_mapped_to_server',isc_spb_sql_role_name_mapped_to_server);
    AddConstant('isc_info_end',isc_info_end);
    AddConstant('isc_info_truncated',isc_info_truncated);
    AddConstant('isc_info_error',isc_info_error);
    AddConstant('isc_info_data_not_ready',isc_info_data_not_ready);
    AddConstant('isc_info_flag_end',isc_info_flag_end);
    AddConstant('isc_info_db_id',isc_info_db_id);
    AddConstant('isc_info_reads',isc_info_reads);
    AddConstant('isc_info_writes',isc_info_writes);
    AddConstant('isc_info_fetches',isc_info_fetches);
    AddConstant('isc_info_marks',isc_info_marks);
    AddConstant('isc_info_implementation',isc_info_implementation);
    AddConstant('isc_info_version',isc_info_version);
    AddConstant('isc_info_base_level',isc_info_base_level);
    AddConstant('isc_info_page_size',isc_info_page_size);
    AddConstant('isc_info_num_buffers',isc_info_num_buffers);
    AddConstant('isc_info_limbo',isc_info_limbo);
    AddConstant('isc_info_current_memory',isc_info_current_memory);
    AddConstant('isc_info_max_memory',isc_info_max_memory);
    AddConstant('isc_info_window_turns',isc_info_window_turns);
    AddConstant('isc_info_license',isc_info_license);
    AddConstant('isc_info_allocation',isc_info_allocation);
    AddConstant('isc_info_attachment_id',isc_info_attachment_id);
    AddConstant('isc_info_read_seq_count',isc_info_read_seq_count);
    AddConstant('isc_info_read_idx_count',isc_info_read_idx_count);
    AddConstant('isc_info_insert_count',isc_info_insert_count);
    AddConstant('isc_info_update_count',isc_info_update_count);
    AddConstant('isc_info_delete_count',isc_info_delete_count);
    AddConstant('isc_info_backout_count',isc_info_backout_count);
    AddConstant('isc_info_purge_count',isc_info_purge_count);
    AddConstant('isc_info_expunge_count',isc_info_expunge_count);
    AddConstant('isc_info_sweep_interval',isc_info_sweep_interval);
    AddConstant('isc_info_ods_version',isc_info_ods_version);
    AddConstant('isc_info_ods_minor_version',isc_info_ods_minor_version);
    AddConstant('isc_info_no_reserve',isc_info_no_reserve);
    AddConstant('isc_info_logfile',isc_info_logfile);
    AddConstant('isc_info_cur_logfile_name',isc_info_cur_logfile_name);
    AddConstant('isc_info_cur_log_part_offset',isc_info_cur_log_part_offset);
    AddConstant('isc_info_num_wal_buffers',isc_info_num_wal_buffers);
    AddConstant('isc_info_wal_buffer_size',isc_info_wal_buffer_size);
    AddConstant('isc_info_wal_ckpt_length',isc_info_wal_ckpt_length);
    AddConstant('isc_info_wal_cur_ckpt_interval',isc_info_wal_cur_ckpt_interval);
    AddConstant('isc_info_wal_prv_ckpt_fname',isc_info_wal_prv_ckpt_fname);
    AddConstant('isc_info_wal_prv_ckpt_poffset',isc_info_wal_prv_ckpt_poffset);
    AddConstant('isc_info_wal_recv_ckpt_fname',isc_info_wal_recv_ckpt_fname);
    AddConstant('isc_info_wal_recv_ckpt_poffset',isc_info_wal_recv_ckpt_poffset);
    AddConstant('isc_info_wal_grpc_wait_usecs',isc_info_wal_grpc_wait_usecs);
    AddConstant('isc_info_wal_num_io',isc_info_wal_num_io);
    AddConstant('isc_info_wal_avg_io_size',isc_info_wal_avg_io_size);
    AddConstant('isc_info_wal_num_commits',isc_info_wal_num_commits);
    AddConstant('isc_info_wal_avg_grpc_size',isc_info_wal_avg_grpc_size);
    AddConstant('isc_info_forced_writes',isc_info_forced_writes);
    AddConstant('isc_info_user_names',isc_info_user_names);
    AddConstant('isc_info_page_errors',isc_info_page_errors);
    AddConstant('isc_info_record_errors',isc_info_record_errors);
    AddConstant('isc_info_bpage_errors',isc_info_bpage_errors);
    AddConstant('isc_info_dpage_errors',isc_info_dpage_errors);
    AddConstant('isc_info_ipage_errors',isc_info_ipage_errors);
    AddConstant('isc_info_ppage_errors',isc_info_ppage_errors);
    AddConstant('isc_info_tpage_errors',isc_info_tpage_errors);
    AddConstant('isc_info_set_page_buffers',isc_info_set_page_buffers);
    AddConstant('isc_info_db_SQL_dialect',isc_info_db_SQL_dialect);
    AddConstant('isc_info_db_read_only',isc_info_db_read_only);
    AddConstant('isc_info_db_size_in_pages',isc_info_db_size_in_pages);
    AddConstant('isc_info_db_impl_rdb_vms',isc_info_db_impl_rdb_vms);
    AddConstant('isc_info_db_impl_rdb_eln',isc_info_db_impl_rdb_eln);
    AddConstant('isc_info_db_impl_rdb_eln_dev',isc_info_db_impl_rdb_eln_dev);
    AddConstant('isc_info_db_impl_rdb_vms_y',isc_info_db_impl_rdb_vms_y);
    AddConstant('isc_info_db_impl_rdb_eln_y',isc_info_db_impl_rdb_eln_y);
    AddConstant('isc_info_db_impl_jri',isc_info_db_impl_jri);
    AddConstant('isc_info_db_impl_jsv',isc_info_db_impl_jsv);
    AddConstant('isc_info_db_impl_isc_a',isc_info_db_impl_isc_a);
    AddConstant('isc_info_db_impl_isc_u',isc_info_db_impl_isc_u);
    AddConstant('isc_info_db_impl_isc_v',isc_info_db_impl_isc_v);
    AddConstant('isc_info_db_impl_isc_s',isc_info_db_impl_isc_s);
    AddConstant('isc_info_db_impl_isc_apl_68K',isc_info_db_impl_isc_apl_68K);
    AddConstant('isc_info_db_impl_isc_vax_ultr',isc_info_db_impl_isc_vax_ultr);
    AddConstant('isc_info_db_impl_isc_vms',isc_info_db_impl_isc_vms);
    AddConstant('isc_info_db_impl_isc_sun_68k',isc_info_db_impl_isc_sun_68k);
    AddConstant('isc_info_db_impl_isc_os2',isc_info_db_impl_isc_os2);
    AddConstant('isc_info_db_impl_isc_sun4',isc_info_db_impl_isc_sun4);
    AddConstant('isc_info_db_impl_isc_hp_ux',isc_info_db_impl_isc_hp_ux);
    AddConstant('isc_info_db_impl_isc_sun_386i',isc_info_db_impl_isc_sun_386i);
    AddConstant('isc_info_db_impl_isc_vms_orcl',isc_info_db_impl_isc_vms_orcl);
    AddConstant('isc_info_db_impl_isc_mac_aux',isc_info_db_impl_isc_mac_aux);
    AddConstant('isc_info_db_impl_isc_rt_aix',isc_info_db_impl_isc_rt_aix);
    AddConstant('isc_info_db_impl_isc_mips_ult',isc_info_db_impl_isc_mips_ult);
    AddConstant('isc_info_db_impl_isc_xenix',isc_info_db_impl_isc_xenix);
    AddConstant('isc_info_db_impl_isc_dg',isc_info_db_impl_isc_dg);
    AddConstant('isc_info_db_impl_isc_hp_mpexl',isc_info_db_impl_isc_hp_mpexl);
    AddConstant('isc_info_db_impl_isc_hp_ux68K',isc_info_db_impl_isc_hp_ux68K);
    AddConstant('isc_info_db_impl_isc_sgi',isc_info_db_impl_isc_sgi);
    AddConstant('isc_info_db_impl_isc_sco_unix',isc_info_db_impl_isc_sco_unix);
    AddConstant('isc_info_db_impl_isc_cray',isc_info_db_impl_isc_cray);
    AddConstant('isc_info_db_impl_isc_imp',isc_info_db_impl_isc_imp);
    AddConstant('isc_info_db_impl_isc_delta',isc_info_db_impl_isc_delta);
    AddConstant('isc_info_db_impl_isc_next',isc_info_db_impl_isc_next);
    AddConstant('isc_info_db_impl_isc_dos',isc_info_db_impl_isc_dos);
    AddConstant('isc_info_db_impl_isc_winnt',isc_info_db_impl_isc_winnt);
    AddConstant('isc_info_db_impl_isc_epson',isc_info_db_impl_isc_epson);
    AddConstant('isc_info_db_class_access',isc_info_db_class_access);
    AddConstant('isc_info_db_class_y_valve',isc_info_db_class_y_valve);
    AddConstant('isc_info_db_class_rem_int',isc_info_db_class_rem_int);
    AddConstant('isc_info_db_class_rem_srvr',isc_info_db_class_rem_srvr);
    AddConstant('isc_info_db_class_pipe_int',isc_info_db_class_pipe_int);
    AddConstant('isc_info_db_class_pipe_srvr',isc_info_db_class_pipe_srvr);
    AddConstant('isc_info_db_class_sam_int',isc_info_db_class_sam_int);
    AddConstant('isc_info_db_class_sam_srvr',isc_info_db_class_sam_srvr);
    AddConstant('isc_info_db_class_gateway',isc_info_db_class_gateway);
    AddConstant('isc_info_db_class_cache',isc_info_db_class_cache);
    AddConstant('isc_info_number_messages',isc_info_number_messages);
    AddConstant('isc_info_max_message',isc_info_max_message);
    AddConstant('isc_info_max_send',isc_info_max_send);
    AddConstant('isc_info_max_receive',isc_info_max_receive);
    AddConstant('isc_info_state',isc_info_state);
    AddConstant('isc_info_message_number',isc_info_message_number);
    AddConstant('isc_info_message_size',isc_info_message_size);
    AddConstant('isc_info_request_cost',isc_info_request_cost);
    AddConstant('isc_info_access_path',isc_info_access_path);
    AddConstant('isc_info_req_select_count',isc_info_req_select_count);
    AddConstant('isc_info_req_insert_count',isc_info_req_insert_count);
    AddConstant('isc_info_req_update_count',isc_info_req_update_count);
    AddConstant('isc_info_req_delete_count',isc_info_req_delete_count);
    AddConstant('isc_info_rsb_end',isc_info_rsb_end);
    AddConstant('isc_info_rsb_begin',isc_info_rsb_begin);
    AddConstant('isc_info_rsb_type',isc_info_rsb_type);
    AddConstant('isc_info_rsb_relation',isc_info_rsb_relation);
    AddConstant('isc_info_rsb_plan',isc_info_rsb_plan);
    AddConstant('isc_info_rsb_unknown',isc_info_rsb_unknown);
    AddConstant('isc_info_rsb_indexed',isc_info_rsb_indexed);
    AddConstant('isc_info_rsb_navigate',isc_info_rsb_navigate);
    AddConstant('isc_info_rsb_sequential',isc_info_rsb_sequential);
    AddConstant('isc_info_rsb_cross',isc_info_rsb_cross);
    AddConstant('isc_info_rsb_sort',isc_info_rsb_sort);
    AddConstant('isc_info_rsb_first',isc_info_rsb_first);
    AddConstant('isc_info_rsb_boolean',isc_info_rsb_boolean);
    AddConstant('isc_info_rsb_union',isc_info_rsb_union);
    AddConstant('isc_info_rsb_aggregate',isc_info_rsb_aggregate);
    AddConstant('isc_info_rsb_merge',isc_info_rsb_merge);
    AddConstant('isc_info_rsb_ext_sequential',isc_info_rsb_ext_sequential);
    AddConstant('isc_info_rsb_ext_indexed',isc_info_rsb_ext_indexed);
    AddConstant('isc_info_rsb_ext_dbkey',isc_info_rsb_ext_dbkey);
    AddConstant('isc_info_rsb_left_cross',isc_info_rsb_left_cross);
    AddConstant('isc_info_rsb_select',isc_info_rsb_select);
    AddConstant('isc_info_rsb_sql_join',isc_info_rsb_sql_join);
    AddConstant('isc_info_rsb_simulate',isc_info_rsb_simulate);
    AddConstant('isc_info_rsb_sim_cross',isc_info_rsb_sim_cross);
    AddConstant('isc_info_rsb_once',isc_info_rsb_once);
    AddConstant('isc_info_rsb_procedure',isc_info_rsb_procedure);
    AddConstant('isc_info_rsb_and',isc_info_rsb_and);
    AddConstant('isc_info_rsb_or',isc_info_rsb_or);
    AddConstant('isc_info_rsb_dbkey',isc_info_rsb_dbkey);
    AddConstant('isc_info_rsb_index',isc_info_rsb_index);
    AddConstant('isc_info_req_active',isc_info_req_active);
    AddConstant('isc_info_req_inactive',isc_info_req_inactive);
    AddConstant('isc_info_req_send',isc_info_req_send);
    AddConstant('isc_info_req_receive',isc_info_req_receive);
    AddConstant('isc_info_req_select',isc_info_req_select);
    AddConstant('isc_info_req_sql_stall',isc_info_req_sql_stall);
    AddConstant('isc_info_blob_num_segments',isc_info_blob_num_segments);
    AddConstant('isc_info_blob_max_segment',isc_info_blob_max_segment);
    AddConstant('isc_info_blob_total_length',isc_info_blob_total_length);
    AddConstant('isc_info_blob_type',isc_info_blob_type);
    AddConstant('isc_info_tra_id',isc_info_tra_id);
    AddConstant('isc_action_svc_backup',isc_action_svc_backup);
    AddConstant('isc_action_svc_restore',isc_action_svc_restore);
    AddConstant('isc_action_svc_repair',isc_action_svc_repair);
    AddConstant('isc_action_svc_add_user',isc_action_svc_add_user);
    AddConstant('isc_action_svc_delete_user',isc_action_svc_delete_user);
    AddConstant('isc_action_svc_modify_user',isc_action_svc_modify_user);
    AddConstant('isc_action_svc_display_user',isc_action_svc_display_user);
    AddConstant('isc_action_svc_properties',isc_action_svc_properties);
    AddConstant('isc_action_svc_add_license',isc_action_svc_add_license);
    AddConstant('isc_action_svc_remove_license',isc_action_svc_remove_license);
    AddConstant('isc_action_svc_db_stats',isc_action_svc_db_stats);
    AddConstant('isc_action_svc_get_ib_log',isc_action_svc_get_ib_log);
    AddConstant('isc_info_svc_svr_db_info',isc_info_svc_svr_db_info);
    AddConstant('isc_info_svc_get_license',isc_info_svc_get_license);
    AddConstant('isc_info_svc_get_license_mask',isc_info_svc_get_license_mask);
    AddConstant('isc_info_svc_get_config',isc_info_svc_get_config);
    AddConstant('isc_info_svc_version',isc_info_svc_version);
    AddConstant('isc_info_svc_server_version',isc_info_svc_server_version);
    AddConstant('isc_info_svc_implementation',isc_info_svc_implementation);
    AddConstant('isc_info_svc_capabilities',isc_info_svc_capabilities);
    AddConstant('isc_info_svc_user_dbpath',isc_info_svc_user_dbpath);
    AddConstant('isc_info_svc_get_env',isc_info_svc_get_env);
    AddConstant('isc_info_svc_get_env_lock',isc_info_svc_get_env_lock);
    AddConstant('isc_info_svc_get_env_msg',isc_info_svc_get_env_msg);
    AddConstant('isc_info_svc_line',isc_info_svc_line);
    AddConstant('isc_info_svc_to_eof',isc_info_svc_to_eof);
    AddConstant('isc_info_svc_timeout',isc_info_svc_timeout);
    AddConstant('isc_info_svc_get_licensed_users',isc_info_svc_get_licensed_users);
    AddConstant('isc_info_svc_limbo_trans',isc_info_svc_limbo_trans);
    AddConstant('isc_info_svc_running',isc_info_svc_running);
    AddConstant('isc_info_svc_get_users',isc_info_svc_get_users);
    AddConstant('isc_spb_sec_userid',isc_spb_sec_userid);
    AddConstant('isc_spb_sec_groupid',isc_spb_sec_groupid);
    AddConstant('isc_spb_sec_username',isc_spb_sec_username);
    AddConstant('isc_spb_sec_password',isc_spb_sec_password);
    AddConstant('isc_spb_sec_groupname',isc_spb_sec_groupname);
    AddConstant('isc_spb_sec_firstname',isc_spb_sec_firstname);
    AddConstant('isc_spb_sec_middlename',isc_spb_sec_middlename);
    AddConstant('isc_spb_sec_lastname',isc_spb_sec_lastname);
    AddConstant('isc_spb_lic_key',isc_spb_lic_key);
    AddConstant('isc_spb_lic_id',isc_spb_lic_id);
    AddConstant('isc_spb_lic_desc',isc_spb_lic_desc);
    AddConstant('isc_spb_bkp_file',isc_spb_bkp_file);
    AddConstant('isc_spb_bkp_factor',isc_spb_bkp_factor);
    AddConstant('isc_spb_bkp_length',isc_spb_bkp_length);
    AddConstant('isc_spb_bkp_ignore_checksums',isc_spb_bkp_ignore_checksums);
    AddConstant('isc_spb_bkp_ignore_limbo',isc_spb_bkp_ignore_limbo);
    AddConstant('isc_spb_bkp_metadata_only',isc_spb_bkp_metadata_only);
    AddConstant('isc_spb_bkp_no_garbage_collect',isc_spb_bkp_no_garbage_collect);
    AddConstant('isc_spb_bkp_old_descriptions',isc_spb_bkp_old_descriptions);
    AddConstant('isc_spb_bkp_non_transportable',isc_spb_bkp_non_transportable);
    AddConstant('isc_spb_bkp_convert',isc_spb_bkp_convert);
    AddConstant('isc_spb_bkp_expand',isc_spb_bkp_expand);
    AddConstant('isc_spb_prp_page_buffers',isc_spb_prp_page_buffers);
    AddConstant('isc_spb_prp_sweep_interval',isc_spb_prp_sweep_interval);
    AddConstant('isc_spb_prp_shutdown_db',isc_spb_prp_shutdown_db);
    AddConstant('isc_spb_prp_deny_new_attachments',isc_spb_prp_deny_new_attachments);
    AddConstant('isc_spb_prp_deny_new_transactions',isc_spb_prp_deny_new_transactions);
    AddConstant('isc_spb_prp_reserve_space',isc_spb_prp_reserve_space);
    AddConstant('isc_spb_prp_write_mode',isc_spb_prp_write_mode);
    AddConstant('isc_spb_prp_access_mode',isc_spb_prp_access_mode);
    AddConstant('isc_spb_prp_set_sql_dialect',isc_spb_prp_set_sql_dialect);
    AddConstant('isc_spb_prp_activate',isc_spb_prp_activate);
    AddConstant('isc_spb_prp_db_online',isc_spb_prp_db_online);
    AddConstant('isc_spb_prp_res_use_full',isc_spb_prp_res_use_full);
    AddConstant('isc_spb_prp_res',isc_spb_prp_res);
    AddConstant('isc_spb_prp_wm_async',isc_spb_prp_wm_async);
    AddConstant('isc_spb_prp_wm_sync',isc_spb_prp_wm_sync);
    AddConstant('isc_spb_prp_am_readonly',isc_spb_prp_am_readonly);
    AddConstant('isc_spb_prp_am_readwrite',isc_spb_prp_am_readwrite);
    AddConstant('isc_spb_rpr_commit_trans',isc_spb_rpr_commit_trans);
    AddConstant('isc_spb_rpr_rollback_trans',isc_spb_rpr_rollback_trans);
    AddConstant('isc_spb_rpr_recover_two_phase',isc_spb_rpr_recover_two_phase);
    AddConstant('isc_spb_tra_id',isc_spb_tra_id);
    AddConstant('isc_spb_single_tra_id',isc_spb_single_tra_id);
    AddConstant('isc_spb_multi_tra_id',isc_spb_multi_tra_id);
    AddConstant('isc_spb_tra_state',isc_spb_tra_state);
    AddConstant('isc_spb_tra_state_limbo',isc_spb_tra_state_limbo);
    AddConstant('isc_spb_tra_state_commit',isc_spb_tra_state_commit);
    AddConstant('isc_spb_tra_state_rollback',isc_spb_tra_state_rollback);
    AddConstant('isc_spb_tra_state_unknown',isc_spb_tra_state_unknown);
    AddConstant('isc_spb_tra_host_site',isc_spb_tra_host_site);
    AddConstant('isc_spb_tra_remote_site',isc_spb_tra_remote_site);
    AddConstant('isc_spb_tra_db_path',isc_spb_tra_db_path);
    AddConstant('isc_spb_tra_advise',isc_spb_tra_advise);
    AddConstant('isc_spb_tra_advise_commit',isc_spb_tra_advise_commit);
    AddConstant('isc_spb_tra_advise_rollback',isc_spb_tra_advise_rollback);
    AddConstant('isc_spb_tra_advise_unknown',isc_spb_tra_advise_unknown);
    AddConstant('isc_spb_rpr_validate_db',isc_spb_rpr_validate_db);
    AddConstant('isc_spb_rpr_sweep_db',isc_spb_rpr_sweep_db);
    AddConstant('isc_spb_rpr_mend_db',isc_spb_rpr_mend_db);
    AddConstant('isc_spb_rpr_list_limbo_trans',isc_spb_rpr_list_limbo_trans);
    AddConstant('isc_spb_rpr_check_db',isc_spb_rpr_check_db);
    AddConstant('isc_spb_rpr_ignore_checksum',isc_spb_rpr_ignore_checksum);
    AddConstant('isc_spb_rpr_kill_shadows',isc_spb_rpr_kill_shadows);
    AddConstant('isc_spb_rpr_full',isc_spb_rpr_full);
    AddConstant('isc_spb_res_buffers',isc_spb_res_buffers);
    AddConstant('isc_spb_res_page_size',isc_spb_res_page_size);
    AddConstant('isc_spb_res_length',isc_spb_res_length);
    AddConstant('isc_spb_res_access_mode',isc_spb_res_access_mode);
    AddConstant('isc_spb_res_deactivate_idx',isc_spb_res_deactivate_idx);
    AddConstant('isc_spb_res_no_shadow',isc_spb_res_no_shadow);
    AddConstant('isc_spb_res_no_validity',isc_spb_res_no_validity);
    AddConstant('isc_spb_res_one_at_a_time',isc_spb_res_one_at_a_time);
    AddConstant('isc_spb_res_replace',isc_spb_res_replace);
    AddConstant('isc_spb_res_create',isc_spb_res_create);
    AddConstant('isc_spb_res_use_all_space',isc_spb_res_use_all_space);
    AddConstant('isc_spb_res_am_readonly',isc_spb_res_am_readonly);
    AddConstant('isc_spb_res_am_readwrite',isc_spb_res_am_readwrite);
    AddConstant('isc_spb_num_att',isc_spb_num_att);
    AddConstant('isc_spb_num_db',isc_spb_num_db);
    AddConstant('isc_spb_sts_data_pages',isc_spb_sts_data_pages);
    AddConstant('isc_spb_sts_db_log',isc_spb_sts_db_log);
    AddConstant('isc_spb_sts_hdr_pages',isc_spb_sts_hdr_pages);
    AddConstant('isc_spb_sts_idx_pages',isc_spb_sts_idx_pages);
    AddConstant('isc_spb_sts_sys_relations',isc_spb_sts_sys_relations);
    AddConstant('isc_info_sql_select',isc_info_sql_select);
    AddConstant('isc_info_sql_bind',isc_info_sql_bind);
    AddConstant('isc_info_sql_num_variables',isc_info_sql_num_variables);
    AddConstant('isc_info_sql_describe_vars',isc_info_sql_describe_vars);
    AddConstant('isc_info_sql_describe_end',isc_info_sql_describe_end);
    AddConstant('isc_info_sql_sqlda_seq',isc_info_sql_sqlda_seq);
    AddConstant('isc_info_sql_message_seq',isc_info_sql_message_seq);
    AddConstant('isc_info_sql_type',isc_info_sql_type);
    AddConstant('isc_info_sql_sub_type',isc_info_sql_sub_type);
    AddConstant('isc_info_sql_scale',isc_info_sql_scale);
    AddConstant('isc_info_sql_length',isc_info_sql_length);
    AddConstant('isc_info_sql_null_ind',isc_info_sql_null_ind);
    AddConstant('isc_info_sql_field',isc_info_sql_field);
    AddConstant('isc_info_sql_relation',isc_info_sql_relation);
    AddConstant('isc_info_sql_owner',isc_info_sql_owner);
    AddConstant('isc_info_sql_alias',isc_info_sql_alias);
    AddConstant('isc_info_sql_sqlda_start',isc_info_sql_sqlda_start);
    AddConstant('isc_info_sql_stmt_type',isc_info_sql_stmt_type);
    AddConstant('isc_info_sql_get_plan',isc_info_sql_get_plan);
    AddConstant('isc_info_sql_records',isc_info_sql_records);
    AddConstant('isc_info_sql_batch_fetch',isc_info_sql_batch_fetch);
    AddConstant('isc_info_sql_stmt_select',isc_info_sql_stmt_select);
    AddConstant('isc_info_sql_stmt_insert',isc_info_sql_stmt_insert);
    AddConstant('isc_info_sql_stmt_update',isc_info_sql_stmt_update);
    AddConstant('isc_info_sql_stmt_delete',isc_info_sql_stmt_delete);
    AddConstant('isc_info_sql_stmt_ddl',isc_info_sql_stmt_ddl);
    AddConstant('isc_info_sql_stmt_get_segment',isc_info_sql_stmt_get_segment);
    AddConstant('isc_info_sql_stmt_put_segment',isc_info_sql_stmt_put_segment);
    AddConstant('isc_info_sql_stmt_exec_procedure',isc_info_sql_stmt_exec_procedure);
    AddConstant('isc_info_sql_stmt_start_trans',isc_info_sql_stmt_start_trans);
    AddConstant('isc_info_sql_stmt_commit',isc_info_sql_stmt_commit);
    AddConstant('isc_info_sql_stmt_rollback',isc_info_sql_stmt_rollback);
    AddConstant('isc_info_sql_stmt_select_for_upd',isc_info_sql_stmt_select_for_upd);
    AddConstant('isc_info_sql_stmt_set_generator',isc_info_sql_stmt_set_generator);
    AddConstant('ISCCFG_LOCKMEM_KEY',ISCCFG_LOCKMEM_KEY);
    AddConstant('ISCCFG_LOCKSEM_KEY',ISCCFG_LOCKSEM_KEY);
    AddConstant('ISCCFG_LOCKSIG_KEY',ISCCFG_LOCKSIG_KEY);
    AddConstant('ISCCFG_EVNTMEM_KEY',ISCCFG_EVNTMEM_KEY);
    AddConstant('ISCCFG_DBCACHE_KEY',ISCCFG_DBCACHE_KEY);
    AddConstant('ISCCFG_PRIORITY_KEY',ISCCFG_PRIORITY_KEY);
    AddConstant('ISCCFG_IPCMAP_KEY',ISCCFG_IPCMAP_KEY);
    AddConstant('ISCCFG_MEMMIN_KEY',ISCCFG_MEMMIN_KEY);
    AddConstant('ISCCFG_MEMMAX_KEY',ISCCFG_MEMMAX_KEY);
    AddConstant('ISCCFG_LOCKORDER_KEY',ISCCFG_LOCKORDER_KEY);
    AddConstant('ISCCFG_ANYLOCKMEM_KEY',ISCCFG_ANYLOCKMEM_KEY);
    AddConstant('ISCCFG_ANYLOCKSEM_KEY',ISCCFG_ANYLOCKSEM_KEY);
    AddConstant('ISCCFG_ANYLOCKSIG_KEY',ISCCFG_ANYLOCKSIG_KEY);
    AddConstant('ISCCFG_ANYEVNTMEM_KEY',ISCCFG_ANYEVNTMEM_KEY);
    AddConstant('ISCCFG_LOCKHASH_KEY',ISCCFG_LOCKHASH_KEY);
    AddConstant('ISCCFG_DEADLOCK_KEY',ISCCFG_DEADLOCK_KEY);
    AddConstant('ISCCFG_LOCKSPIN_KEY',ISCCFG_LOCKSPIN_KEY);
    AddConstant('ISCCFG_CONN_TIMEOUT_KEY',ISCCFG_CONN_TIMEOUT_KEY);
    AddConstant('ISCCFG_DUMMY_INTRVL_KEY',ISCCFG_DUMMY_INTRVL_KEY);
    AddConstant('isc_facility',isc_facility);
    AddConstant('isc_err_base',isc_err_base);
    AddConstant('isc_err_factor',isc_err_factor);
    AddConstant('isc_arg_end',isc_arg_end);
    AddConstant('isc_arg_gds',isc_arg_gds);
    AddConstant('isc_arg_string',isc_arg_string);
    AddConstant('isc_arg_cstring',isc_arg_cstring);
    AddConstant('isc_arg_number',isc_arg_number);
    AddConstant('isc_arg_interpreted',isc_arg_interpreted);
    AddConstant('isc_arg_vms',isc_arg_vms);
    AddConstant('isc_arg_unix',isc_arg_unix);
    AddConstant('isc_arg_domain',isc_arg_domain);
    AddConstant('isc_arg_dos',isc_arg_dos);
    AddConstant('isc_arg_mpexl',isc_arg_mpexl);
    AddConstant('isc_arg_mpexl_ipc',isc_arg_mpexl_ipc);
    AddConstant('isc_arg_next_mach',isc_arg_next_mach);
    AddConstant('isc_arg_netware',isc_arg_netware);
    AddConstant('isc_arg_win32',isc_arg_win32);
    AddConstant('isc_arg_warning',isc_arg_warning);
    AddConstant('isc_dyn_version_1',isc_dyn_version_1);
    AddConstant('isc_dyn_eoc',isc_dyn_eoc);
    AddConstant('isc_dyn_begin',isc_dyn_begin);
    AddConstant('isc_dyn_end',isc_dyn_end);
    AddConstant('isc_dyn_if',isc_dyn_if);
    AddConstant('isc_dyn_def_database',isc_dyn_def_database);
    AddConstant('isc_dyn_def_global_fld',isc_dyn_def_global_fld);
    AddConstant('isc_dyn_def_local_fld',isc_dyn_def_local_fld);
    AddConstant('isc_dyn_def_idx',isc_dyn_def_idx);
    AddConstant('isc_dyn_def_rel',isc_dyn_def_rel);
    AddConstant('isc_dyn_def_sql_fld',isc_dyn_def_sql_fld);
    AddConstant('isc_dyn_def_view',isc_dyn_def_view);
    AddConstant('isc_dyn_def_trigger',isc_dyn_def_trigger);
    AddConstant('isc_dyn_def_security_class',isc_dyn_def_security_class);
    AddConstant('isc_dyn_def_dimension',isc_dyn_def_dimension);
    AddConstant('isc_dyn_def_generator',isc_dyn_def_generator);
    AddConstant('isc_dyn_def_function',isc_dyn_def_function);
    AddConstant('isc_dyn_def_filter',isc_dyn_def_filter);
    AddConstant('isc_dyn_def_function_arg',isc_dyn_def_function_arg);
    AddConstant('isc_dyn_def_shadow',isc_dyn_def_shadow);
    AddConstant('isc_dyn_def_trigger_msg',isc_dyn_def_trigger_msg);
    AddConstant('isc_dyn_def_file',isc_dyn_def_file);
    AddConstant('isc_dyn_mod_database',isc_dyn_mod_database);
    AddConstant('isc_dyn_mod_rel',isc_dyn_mod_rel);
    AddConstant('isc_dyn_mod_global_fld',isc_dyn_mod_global_fld);
    AddConstant('isc_dyn_mod_idx',isc_dyn_mod_idx);
    AddConstant('isc_dyn_mod_local_fld',isc_dyn_mod_local_fld);
    AddConstant('isc_dyn_mod_sql_fld',isc_dyn_mod_sql_fld);
    AddConstant('isc_dyn_mod_view',isc_dyn_mod_view);
    AddConstant('isc_dyn_mod_security_class',isc_dyn_mod_security_class);
    AddConstant('isc_dyn_mod_trigger',isc_dyn_mod_trigger);
    AddConstant('isc_dyn_mod_trigger_msg',isc_dyn_mod_trigger_msg);
    AddConstant('isc_dyn_delete_database',isc_dyn_delete_database);
    AddConstant('isc_dyn_delete_rel',isc_dyn_delete_rel);
    AddConstant('isc_dyn_delete_global_fld',isc_dyn_delete_global_fld);
    AddConstant('isc_dyn_delete_local_fld',isc_dyn_delete_local_fld);
    AddConstant('isc_dyn_delete_idx',isc_dyn_delete_idx);
    AddConstant('isc_dyn_delete_security_class',isc_dyn_delete_security_class);
    AddConstant('isc_dyn_delete_dimensions',isc_dyn_delete_dimensions);
    AddConstant('isc_dyn_delete_trigger',isc_dyn_delete_trigger);
    AddConstant('isc_dyn_delete_trigger_msg',isc_dyn_delete_trigger_msg);
    AddConstant('isc_dyn_delete_filter',isc_dyn_delete_filter);
    AddConstant('isc_dyn_delete_function',isc_dyn_delete_function);
    AddConstant('isc_dyn_delete_shadow',isc_dyn_delete_shadow);
    AddConstant('isc_dyn_grant',isc_dyn_grant);
    AddConstant('isc_dyn_revoke',isc_dyn_revoke);
    AddConstant('isc_dyn_def_primary_key',isc_dyn_def_primary_key);
    AddConstant('isc_dyn_def_foreign_key',isc_dyn_def_foreign_key);
    AddConstant('isc_dyn_def_unique',isc_dyn_def_unique);
    AddConstant('isc_dyn_def_procedure',isc_dyn_def_procedure);
    AddConstant('isc_dyn_delete_procedure',isc_dyn_delete_procedure);
    AddConstant('isc_dyn_def_parameter',isc_dyn_def_parameter);
    AddConstant('isc_dyn_delete_parameter',isc_dyn_delete_parameter);
    AddConstant('isc_dyn_mod_procedure',isc_dyn_mod_procedure);
    AddConstant('isc_dyn_def_log_file',isc_dyn_def_log_file);
    AddConstant('isc_dyn_def_cache_file',isc_dyn_def_cache_file);
    AddConstant('isc_dyn_def_exception',isc_dyn_def_exception);
    AddConstant('isc_dyn_mod_exception',isc_dyn_mod_exception);
    AddConstant('isc_dyn_del_exception',isc_dyn_del_exception);
    AddConstant('isc_dyn_drop_log',isc_dyn_drop_log);
    AddConstant('isc_dyn_drop_cache',isc_dyn_drop_cache);
    AddConstant('isc_dyn_def_default_log',isc_dyn_def_default_log);
    AddConstant('isc_dyn_view_blr',isc_dyn_view_blr);
    AddConstant('isc_dyn_view_source',isc_dyn_view_source);
    AddConstant('isc_dyn_view_relation',isc_dyn_view_relation);
    AddConstant('isc_dyn_view_context',isc_dyn_view_context);
    AddConstant('isc_dyn_view_context_name',isc_dyn_view_context_name);
    AddConstant('isc_dyn_rel_name',isc_dyn_rel_name);
    AddConstant('isc_dyn_fld_name',isc_dyn_fld_name);
    AddConstant('isc_dyn_new_fld_name',isc_dyn_new_fld_name);
    AddConstant('isc_dyn_idx_name',isc_dyn_idx_name);
    AddConstant('isc_dyn_description',isc_dyn_description);
    AddConstant('isc_dyn_security_class',isc_dyn_security_class);
    AddConstant('isc_dyn_system_flag',isc_dyn_system_flag);
    AddConstant('isc_dyn_update_flag',isc_dyn_update_flag);
    AddConstant('isc_dyn_prc_name',isc_dyn_prc_name);
    AddConstant('isc_dyn_prm_name',isc_dyn_prm_name);
    AddConstant('isc_dyn_sql_object',isc_dyn_sql_object);
    AddConstant('isc_dyn_fld_character_set_name',isc_dyn_fld_character_set_name);
    AddConstant('isc_dyn_rel_dbkey_length',isc_dyn_rel_dbkey_length);
    AddConstant('isc_dyn_rel_store_trig',isc_dyn_rel_store_trig);
    AddConstant('isc_dyn_rel_modify_trig',isc_dyn_rel_modify_trig);
    AddConstant('isc_dyn_rel_erase_trig',isc_dyn_rel_erase_trig);
    AddConstant('isc_dyn_rel_store_trig_source',isc_dyn_rel_store_trig_source);
    AddConstant('isc_dyn_rel_modify_trig_source',isc_dyn_rel_modify_trig_source);
    AddConstant('isc_dyn_rel_erase_trig_source',isc_dyn_rel_erase_trig_source);
    AddConstant('isc_dyn_rel_ext_file',isc_dyn_rel_ext_file);
    AddConstant('isc_dyn_rel_sql_protection',isc_dyn_rel_sql_protection);
    AddConstant('isc_dyn_rel_constraint',isc_dyn_rel_constraint);
    AddConstant('isc_dyn_delete_rel_constraint',isc_dyn_delete_rel_constraint);
    AddConstant('isc_dyn_fld_type',isc_dyn_fld_type);
    AddConstant('isc_dyn_fld_length',isc_dyn_fld_length);
    AddConstant('isc_dyn_fld_scale',isc_dyn_fld_scale);
    AddConstant('isc_dyn_fld_sub_type',isc_dyn_fld_sub_type);
    AddConstant('isc_dyn_fld_segment_length',isc_dyn_fld_segment_length);
    AddConstant('isc_dyn_fld_query_header',isc_dyn_fld_query_header);
    AddConstant('isc_dyn_fld_edit_string',isc_dyn_fld_edit_string);
    AddConstant('isc_dyn_fld_validation_blr',isc_dyn_fld_validation_blr);
    AddConstant('isc_dyn_fld_validation_source',isc_dyn_fld_validation_source);
    AddConstant('isc_dyn_fld_computed_blr',isc_dyn_fld_computed_blr);
    AddConstant('isc_dyn_fld_computed_source',isc_dyn_fld_computed_source);
    AddConstant('isc_dyn_fld_missing_value',isc_dyn_fld_missing_value);
    AddConstant('isc_dyn_fld_default_value',isc_dyn_fld_default_value);
    AddConstant('isc_dyn_fld_query_name',isc_dyn_fld_query_name);
    AddConstant('isc_dyn_fld_dimensions',isc_dyn_fld_dimensions);
    AddConstant('isc_dyn_fld_not_null',isc_dyn_fld_not_null);
    AddConstant('isc_dyn_fld_precision',isc_dyn_fld_precision);
    AddConstant('isc_dyn_fld_char_length',isc_dyn_fld_char_length);
    AddConstant('isc_dyn_fld_collation',isc_dyn_fld_collation);
    AddConstant('isc_dyn_fld_default_source',isc_dyn_fld_default_source);
    AddConstant('isc_dyn_del_default',isc_dyn_del_default);
    AddConstant('isc_dyn_del_validation',isc_dyn_del_validation);
    AddConstant('isc_dyn_single_validation',isc_dyn_single_validation);
    AddConstant('isc_dyn_fld_character_set',isc_dyn_fld_character_set);
    AddConstant('isc_dyn_fld_source',isc_dyn_fld_source);
    AddConstant('isc_dyn_fld_base_fld',isc_dyn_fld_base_fld);
    AddConstant('isc_dyn_fld_position',isc_dyn_fld_position);
    AddConstant('isc_dyn_fld_update_flag',isc_dyn_fld_update_flag);
    AddConstant('isc_dyn_idx_unique',isc_dyn_idx_unique);
    AddConstant('isc_dyn_idx_inactive',isc_dyn_idx_inactive);
    AddConstant('isc_dyn_idx_type',isc_dyn_idx_type);
    AddConstant('isc_dyn_idx_foreign_key',isc_dyn_idx_foreign_key);
    AddConstant('isc_dyn_idx_ref_column',isc_dyn_idx_ref_column);
    AddConstant('isc_dyn_idx_statistic',isc_dyn_idx_statistic);
    AddConstant('isc_dyn_trg_type',isc_dyn_trg_type);
    AddConstant('isc_dyn_trg_blr',isc_dyn_trg_blr);
    AddConstant('isc_dyn_trg_source',isc_dyn_trg_source);
    AddConstant('isc_dyn_trg_name',isc_dyn_trg_name);
    AddConstant('isc_dyn_trg_sequence',isc_dyn_trg_sequence);
    AddConstant('isc_dyn_trg_inactive',isc_dyn_trg_inactive);
    AddConstant('isc_dyn_trg_msg_number',isc_dyn_trg_msg_number);
    AddConstant('isc_dyn_trg_msg',isc_dyn_trg_msg);
    AddConstant('isc_dyn_scl_acl',isc_dyn_scl_acl);
    AddConstant('isc_dyn_grant_user',isc_dyn_grant_user);
    AddConstant('isc_dyn_grant_proc',isc_dyn_grant_proc);
    AddConstant('isc_dyn_grant_trig',isc_dyn_grant_trig);
    AddConstant('isc_dyn_grant_view',isc_dyn_grant_view);
    AddConstant('isc_dyn_grant_options',isc_dyn_grant_options);
    AddConstant('isc_dyn_grant_user_group',isc_dyn_grant_user_group);
    AddConstant('isc_dyn_dim_lower',isc_dyn_dim_lower);
    AddConstant('isc_dyn_dim_upper',isc_dyn_dim_upper);
    AddConstant('isc_dyn_file_name',isc_dyn_file_name);
    AddConstant('isc_dyn_file_start',isc_dyn_file_start);
    AddConstant('isc_dyn_file_length',isc_dyn_file_length);
    AddConstant('isc_dyn_shadow_number',isc_dyn_shadow_number);
    AddConstant('isc_dyn_shadow_man_auto',isc_dyn_shadow_man_auto);
    AddConstant('isc_dyn_shadow_conditional',isc_dyn_shadow_conditional);
    AddConstant('isc_dyn_log_file_sequence',isc_dyn_log_file_sequence);
    AddConstant('isc_dyn_log_file_partitions',isc_dyn_log_file_partitions);
    AddConstant('isc_dyn_log_file_serial',isc_dyn_log_file_serial);
    AddConstant('isc_dyn_log_file_overflow',isc_dyn_log_file_overflow);
    AddConstant('isc_dyn_log_file_raw',isc_dyn_log_file_raw);
    AddConstant('isc_dyn_log_group_commit_wait',isc_dyn_log_group_commit_wait);
    AddConstant('isc_dyn_log_buffer_size',isc_dyn_log_buffer_size);
    AddConstant('isc_dyn_log_check_point_length',isc_dyn_log_check_point_length);
    AddConstant('isc_dyn_log_num_of_buffers',isc_dyn_log_num_of_buffers);
    AddConstant('isc_dyn_function_name',isc_dyn_function_name);
    AddConstant('isc_dyn_function_type',isc_dyn_function_type);
    AddConstant('isc_dyn_func_module_name',isc_dyn_func_module_name);
    AddConstant('isc_dyn_func_entry_point',isc_dyn_func_entry_point);
    AddConstant('isc_dyn_func_return_argument',isc_dyn_func_return_argument);
    AddConstant('isc_dyn_func_arg_position',isc_dyn_func_arg_position);
    AddConstant('isc_dyn_func_mechanism',isc_dyn_func_mechanism);
    AddConstant('isc_dyn_filter_in_subtype',isc_dyn_filter_in_subtype);
    AddConstant('isc_dyn_filter_out_subtype',isc_dyn_filter_out_subtype);
    AddConstant('isc_dyn_description2',isc_dyn_description2);
    AddConstant('isc_dyn_fld_computed_source2',isc_dyn_fld_computed_source2);
    AddConstant('isc_dyn_fld_edit_string2',isc_dyn_fld_edit_string2);
    AddConstant('isc_dyn_fld_query_header2',isc_dyn_fld_query_header2);
    AddConstant('isc_dyn_fld_validation_source2',isc_dyn_fld_validation_source2);
    AddConstant('isc_dyn_trg_msg2',isc_dyn_trg_msg2);
    AddConstant('isc_dyn_trg_source2',isc_dyn_trg_source2);
    AddConstant('isc_dyn_view_source2',isc_dyn_view_source2);
    AddConstant('isc_dyn_xcp_msg2',isc_dyn_xcp_msg2);
    AddConstant('isc_dyn_generator_name',isc_dyn_generator_name);
    AddConstant('isc_dyn_generator_id',isc_dyn_generator_id);
    AddConstant('isc_dyn_prc_inputs',isc_dyn_prc_inputs);
    AddConstant('isc_dyn_prc_outputs',isc_dyn_prc_outputs);
    AddConstant('isc_dyn_prc_source',isc_dyn_prc_source);
    AddConstant('isc_dyn_prc_blr',isc_dyn_prc_blr);
    AddConstant('isc_dyn_prc_source2',isc_dyn_prc_source2);
    AddConstant('isc_dyn_prm_number',isc_dyn_prm_number);
    AddConstant('isc_dyn_prm_type',isc_dyn_prm_type);
    AddConstant('isc_dyn_xcp_msg',isc_dyn_xcp_msg);
    AddConstant('isc_dyn_foreign_key_update',isc_dyn_foreign_key_update);
    AddConstant('isc_dyn_foreign_key_delete',isc_dyn_foreign_key_delete);
    AddConstant('isc_dyn_foreign_key_cascade',isc_dyn_foreign_key_cascade);
    AddConstant('isc_dyn_foreign_key_default',isc_dyn_foreign_key_default);
    AddConstant('isc_dyn_foreign_key_null',isc_dyn_foreign_key_null);
    AddConstant('isc_dyn_foreign_key_none',isc_dyn_foreign_key_none);
    AddConstant('isc_dyn_def_sql_role',isc_dyn_def_sql_role);
    AddConstant('isc_dyn_sql_role_name',isc_dyn_sql_role_name);
    AddConstant('isc_dyn_grant_admin_options',isc_dyn_grant_admin_options);
    AddConstant('isc_dyn_del_sql_role',isc_dyn_del_sql_role);
    AddConstant('isc_dyn_last_dyn_value',isc_dyn_last_dyn_value);
    AddConstant('isc_sdl_version1',isc_sdl_version1);
    AddConstant('isc_sdl_eoc',isc_sdl_eoc);
    AddConstant('isc_sdl_relation',isc_sdl_relation);
    AddConstant('isc_sdl_rid',isc_sdl_rid);
    AddConstant('isc_sdl_field',isc_sdl_field);
    AddConstant('isc_sdl_fid',isc_sdl_fid);
    AddConstant('isc_sdl_struct',isc_sdl_struct);
    AddConstant('isc_sdl_variable',isc_sdl_variable);
    AddConstant('isc_sdl_scalar',isc_sdl_scalar);
    AddConstant('isc_sdl_tiny_integer',isc_sdl_tiny_integer);
    AddConstant('isc_sdl_short_integer',isc_sdl_short_integer);
    AddConstant('isc_sdl_long_integer',isc_sdl_long_integer);
    AddConstant('isc_sdl_literal',isc_sdl_literal);
    AddConstant('isc_sdl_add',isc_sdl_add);
    AddConstant('isc_sdl_subtract',isc_sdl_subtract);
    AddConstant('isc_sdl_multiply',isc_sdl_multiply);
    AddConstant('isc_sdl_divide',isc_sdl_divide);
    AddConstant('isc_sdl_negate',isc_sdl_negate);
    AddConstant('isc_sdl_eql',isc_sdl_eql);
    AddConstant('isc_sdl_neq',isc_sdl_neq);
    AddConstant('isc_sdl_gtr',isc_sdl_gtr);
    AddConstant('isc_sdl_geq',isc_sdl_geq);
    AddConstant('isc_sdl_lss',isc_sdl_lss);
    AddConstant('isc_sdl_leq',isc_sdl_leq);
    AddConstant('isc_sdl_and',isc_sdl_and);
    AddConstant('isc_sdl_or',isc_sdl_or);
    AddConstant('isc_sdl_not',isc_sdl_not);
    AddConstant('isc_sdl_while',isc_sdl_while);
    AddConstant('isc_sdl_assignment',isc_sdl_assignment);
    AddConstant('isc_sdl_label',isc_sdl_label);
    AddConstant('isc_sdl_leave',isc_sdl_leave);
    AddConstant('isc_sdl_begin',isc_sdl_begin);
    AddConstant('isc_sdl_end',isc_sdl_end);
    AddConstant('isc_sdl_do3',isc_sdl_do3);
    AddConstant('isc_sdl_do2',isc_sdl_do2);
    AddConstant('isc_sdl_do1',isc_sdl_do1);
    AddConstant('isc_sdl_element',isc_sdl_element);
    AddConstant('isc_interp_eng_ascii',isc_interp_eng_ascii);
    AddConstant('isc_interp_jpn_sjis',isc_interp_jpn_sjis);
    AddConstant('isc_interp_jpn_euc',isc_interp_jpn_euc);
    AddConstant('isc_fetch_next',isc_fetch_next);
    AddConstant('isc_fetch_prior',isc_fetch_prior);
    AddConstant('isc_fetch_first',isc_fetch_first);
    AddConstant('isc_fetch_last',isc_fetch_last);
    AddConstant('isc_fetch_absolute',isc_fetch_absolute);
    AddConstant('isc_fetch_relative',isc_fetch_relative);
    AddConstant('SQL_VARYING',SQL_VARYING);
    AddConstant('SQL_TEXT',SQL_TEXT);
    AddConstant('SQL_DOUBLE',SQL_DOUBLE);
    AddConstant('SQL_FLOAT',SQL_FLOAT);
    AddConstant('SQL_LONG',SQL_LONG);
    AddConstant('SQL_SHORT',SQL_SHORT);
    AddConstant('SQL_TIMESTAMP',SQL_TIMESTAMP);
    AddConstant('SQL_BLOB',SQL_BLOB);
    AddConstant('SQL_D_FLOAT',SQL_D_FLOAT);
    AddConstant('SQL_ARRAY',SQL_ARRAY);
    AddConstant('SQL_QUAD',SQL_QUAD);
    AddConstant('SQL_TYPE_TIME',SQL_TYPE_TIME);
    AddConstant('SQL_TYPE_DATE',SQL_TYPE_DATE);
    AddConstant('SQL_INT64',SQL_INT64);
    AddConstant('SQL_DATE',SQL_DATE);
    AddConstant('isc_blob_untyped',isc_blob_untyped);
    AddConstant('isc_blob_text',isc_blob_text);
    AddConstant('isc_blob_blr',isc_blob_blr);
    AddConstant('isc_blob_acl',isc_blob_acl);
    AddConstant('isc_blob_ranges',isc_blob_ranges);
    AddConstant('isc_blob_summary',isc_blob_summary);
    AddConstant('isc_blob_format',isc_blob_format);
    AddConstant('isc_blob_tra',isc_blob_tra);
    AddConstant('isc_blob_extfile',isc_blob_extfile);
    AddConstant('isc_blob_formatted_memo',isc_blob_formatted_memo);
    AddConstant('isc_blob_paradox_ole',isc_blob_paradox_ole);
    AddConstant('isc_blob_graphic',isc_blob_graphic);
    AddConstant('isc_blob_dbase_ole',isc_blob_dbase_ole);
    AddConstant('isc_blob_typed_binary',isc_blob_typed_binary);
  end;
end;

class function TatIBHeaderLibrary.LibraryName: string;
begin
  result := 'IBHeader';
end;

initialization
  RegisterScripterLibrary(TatIBHeaderLibrary, True);

{$WARNINGS ON}

end.

