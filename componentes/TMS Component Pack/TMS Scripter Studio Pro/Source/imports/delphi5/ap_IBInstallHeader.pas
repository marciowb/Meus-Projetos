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
unit ap_IBInstallHeader;

interface

uses
  IBInstallHeader,
  atScript;

{$WARNINGS OFF}

type
  TatIBInstallHeaderLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatIBInstallHeaderLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('IB_INSTALL_DLL',IB_INSTALL_DLL);
    AddConstant('isc_install_fp_retry',isc_install_fp_retry);
    AddConstant('isc_install_fp_continue',isc_install_fp_continue);
    AddConstant('isc_install_fp_abort',isc_install_fp_abort);
    AddConstant('isc_install_info_destination',isc_install_info_destination);
    AddConstant('isc_install_info_opspace',isc_install_info_opspace);
    AddConstant('isc_install_info_opname',isc_install_info_opname);
    AddConstant('isc_install_info_opdescription',isc_install_info_opdescription);
    AddConstant('ISC_INSTALL_MAX_MESSAGE_LEN',ISC_INSTALL_MAX_MESSAGE_LEN);
    AddConstant('ISC_INSTALL_MAX_MESSAGES',ISC_INSTALL_MAX_MESSAGES);
    AddConstant('ISC_INSTALL_MAX_PATH',ISC_INSTALL_MAX_PATH);
    AddConstant('INTERBASE',INTERBASE);
    AddConstant('IB_SERVER',IB_SERVER);
    AddConstant('IB_CLIENT',IB_CLIENT);
    AddConstant('IB_CMD_TOOLS',IB_CMD_TOOLS);
    AddConstant('IB_CMD_TOOLS_DB_MGMT',IB_CMD_TOOLS_DB_MGMT);
    AddConstant('IB_CMD_TOOLS_USR_MGMT',IB_CMD_TOOLS_USR_MGMT);
    AddConstant('IB_CMD_TOOLS_DB_QUERY',IB_CMD_TOOLS_DB_QUERY);
    AddConstant('IB_GUI_TOOLS',IB_GUI_TOOLS);
    AddConstant('IB_DOC',IB_DOC);
    AddConstant('IB_EXAMPLES',IB_EXAMPLES);
    AddConstant('IB_EXAMPLE_API',IB_EXAMPLE_API);
    AddConstant('IB_EXAMPLE_DB',IB_EXAMPLE_DB);
    AddConstant('IB_DEV',IB_DEV);
    AddConstant('IB_CONNECTIVITY_SERVER',IB_CONNECTIVITY_SERVER);
    AddConstant('IB_CONNECTIVITY',IB_CONNECTIVITY);
    AddConstant('IB_ODBC_CLIENT',IB_ODBC_CLIENT);
    AddConstant('IB_JDBC_CLIENT',IB_JDBC_CLIENT);
    AddConstant('IB_OLEDB_CLIENT',IB_OLEDB_CLIENT);
    AddConstant('isc_install_optlist_empty',isc_install_optlist_empty);
    AddConstant('isc_install_actlist_empty',isc_install_actlist_empty);
    AddConstant('isc_install_fp_copy_delayed',isc_install_fp_copy_delayed);
    AddConstant('isc_install_fp_delete_delayed',isc_install_fp_delete_delayed);
    AddConstant('isc_install_option_not_found',isc_install_option_not_found);
    AddConstant('isc_install_msg_version',isc_install_msg_version);
    AddConstant('isc_install_cant_load_msg',isc_install_cant_load_msg);
    AddConstant('isc_install_invalid_msg',isc_install_invalid_msg);
    AddConstant('isc_install_invalid_tbl',isc_install_invalid_tbl);
    AddConstant('isc_install_cant_create_msg',isc_install_cant_create_msg);
    AddConstant('isc_install_handle_not_allocated',isc_install_handle_not_allocated);
    AddConstant('isc_install_odbc_comp_notfound',isc_install_odbc_comp_notfound);
    AddConstant('isc_install_cant_delete',isc_install_cant_delete);
    AddConstant('isc_install_cant_rmdir',isc_install_cant_rmdir);
    AddConstant('isc_install_key_nonempty',isc_install_key_nonempty);
    AddConstant('isc_install_success',isc_install_success);
    AddConstant('isc_install_file_error',isc_install_file_error);
    AddConstant('isc_install_path_not_valid',isc_install_path_not_valid);
    AddConstant('isc_install_path_not_exists',isc_install_path_not_exists);
    AddConstant('isc_install_cant_write',isc_install_cant_write);
    AddConstant('isc_install_type_unknown',isc_install_type_unknown);
    AddConstant('isc_install_cant_move_file',isc_install_cant_move_file);
    AddConstant('isc_install_device_not_valid',isc_install_device_not_valid);
    AddConstant('isc_install_data_truncated',isc_install_data_truncated);
    AddConstant('isc_install_cant_get_temp',isc_install_cant_get_temp);
    AddConstant('isc_install_no_file',isc_install_no_file);
    AddConstant('isc_install_cant_load_lib',isc_install_cant_load_lib);
    AddConstant('isc_install_cant_lookup_lib',isc_install_cant_lookup_lib);
    AddConstant('isc_install_file_exists',isc_install_file_exists);
    AddConstant('isc_install_cant_open_log',isc_install_cant_open_log);
    AddConstant('isc_install_write_error',isc_install_write_error);
    AddConstant('isc_install_read_error',isc_install_read_error);
    AddConstant('isc_install_invalid_log',isc_install_invalid_log);
    AddConstant('isc_install_cant_read',isc_install_cant_read);
    AddConstant('isc_install_no_diskspace',isc_install_no_diskspace);
    AddConstant('isc_install_cant_create_dir',isc_install_cant_create_dir);
    AddConstant('isc_install_msg_syntax',isc_install_msg_syntax);
    AddConstant('isc_install_fp_delete_error',isc_install_fp_delete_error);
    AddConstant('isc_install_fp_rename_error',isc_install_fp_rename_error);
    AddConstant('isc_install_fp_copy_error',isc_install_fp_copy_error);
    AddConstant('isc_install_precheck_error',isc_install_precheck_error);
    AddConstant('isc_install_system_not_supported',isc_install_system_not_supported);
    AddConstant('isc_install_server_running',isc_install_server_running);
    AddConstant('isc_install_classic_found',isc_install_classic_found);
    AddConstant('isc_install_no_privileges',isc_install_no_privileges);
    AddConstant('isc_install_cant_get_free_space',isc_install_cant_get_free_space);
    AddConstant('isc_install_guardian_running',isc_install_guardian_running);
    AddConstant('isc_install_invalid_option',isc_install_invalid_option);
    AddConstant('isc_install_invalid_handle',isc_install_invalid_handle);
    AddConstant('isc_install_message_not_found',isc_install_message_not_found);
    AddConstant('isc_install_ip_error',isc_install_ip_error);
    AddConstant('isc_install_no_stack',isc_install_no_stack);
    AddConstant('isc_install_cant_add_service',isc_install_cant_add_service);
    AddConstant('isc_install_invalid_port',isc_install_invalid_port);
    AddConstant('isc_install_invalid_service',isc_install_invalid_service);
    AddConstant('isc_install_no_proto',isc_install_no_proto);
    AddConstant('isc_install_no_services_entry',isc_install_no_services_entry);
    AddConstant('isc_install_sock_error',isc_install_sock_error);
    AddConstant('isc_install_conversion_error',isc_install_conversion_error);
    AddConstant('isc_install_op_error',isc_install_op_error);
    AddConstant('isc_install_cant_copy',isc_install_cant_copy);
    AddConstant('isc_install_no_mem',isc_install_no_mem);
    AddConstant('isc_install_queue_failed',isc_install_queue_failed);
    AddConstant('isc_install_invalid_param',isc_install_invalid_param);
    AddConstant('isc_install_fp_error_exception',isc_install_fp_error_exception);
    AddConstant('isc_install_fp_status_exception',isc_install_fp_status_exception);
    AddConstant('isc_install_user_aborted',isc_install_user_aborted);
    AddConstant('isc_install_reg_error',isc_install_reg_error);
    AddConstant('isc_install_key_exists',isc_install_key_exists);
    AddConstant('isc_install_cant_create_key',isc_install_cant_create_key);
    AddConstant('isc_install_cant_set_value',isc_install_cant_set_value);
    AddConstant('isc_install_cant_open_key',isc_install_cant_open_key);
    AddConstant('isc_install_cant_delete_key',isc_install_cant_delete_key);
    AddConstant('isc_install_cant_query_key',isc_install_cant_query_key);
    AddConstant('isc_install_cant_delete_value',isc_install_cant_delete_value);
    AddConstant('isc_install_serv_error',isc_install_serv_error);
    AddConstant('isc_install_service_existed',isc_install_service_existed);
    AddConstant('isc_install_cant_create_service',isc_install_cant_create_service);
    AddConstant('isc_install_cant_open_service',isc_install_cant_open_service);
    AddConstant('isc_install_cant_query_service',isc_install_cant_query_service);
    AddConstant('isc_install_service_running',isc_install_service_running);
    AddConstant('isc_install_cant_delete_service',isc_install_cant_delete_service);
    AddConstant('isc_install_cant_open_manager',isc_install_cant_open_manager);
    AddConstant('isc_install_system_error',isc_install_system_error);
    AddConstant('isc_install_com_regfail',isc_install_com_regfail);
    AddConstant('isc_install_dcom_required',isc_install_dcom_required);
    AddConstant('isc_install_odbc_error',isc_install_odbc_error);
    AddConstant('isc_install_odbc_general',isc_install_odbc_general);
    AddConstant('isc_install_core_version',isc_install_core_version);
    AddConstant('isc_install_drv_version',isc_install_drv_version);
    AddConstant('isc_install_tran_version',isc_install_tran_version);
  end;
end;

class function TatIBInstallHeaderLibrary.LibraryName: string;
begin
  result := 'IBInstallHeader';
end;

initialization
  RegisterScripterLibrary(TatIBInstallHeaderLibrary, True);

{$WARNINGS ON}

end.

