{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ InterBase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2007 Devrace Ltd.                       }
{    Written by Serge Buzadzhy (buzz@devrace.com)               }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page: http://www.fibplus.com/                 }
{    FIBPlus support  : http://www.devrace.com/support/         }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}

unit FIBConsts;

interface

ResourceString
  SCantFindApiProc     ='Can''t find procedure %s in %s';
  SCantLoadLibrary     ='Can''t load library %s ';
  SUnknownClientLibrary='Can''t perform operation %s. Unknown client library';
  STransactionForOtherLibrary='%s.'#13#10'Transaction can''t work with different client library.';

  SEdErrorPrefix = 'Error of record updating:';
  SEdDeadLockMess = 'Deadlock detected';
  SEdNotExistRecord = 'Record does not exist';
  SEdMultiplyRecord = 'Attempt to edit multiple records';
  SEdUnknownError = 'Unknown error';
  SCantSort = 'Can''t sort. Invalid parameter: Fields[';
  SCantGetInfo = 'Can''t get info for ';
  SDataBaseNotAssigned = 'Database is not assigned';

  SOKButton = '&OK';
  SCancelButton = '&Cancel';
  SGenSQLReplaceSelect='&Replace Select SQL ';
  SEdDataSetInfoCaption = 'Choose DataSet repository information';
  SEdDataSetInfoFields = 'Other fields';
  SEdDataSetInfoKeyField = 'Key field';
  SEdDataSetInfoGenerator = 'Generator';
  SEdDataSetInfoFilter = 'Filter';

  SDBEditCaption = 'Connection Properties';
  SDBEditServerGroup = ' Server ';
  SDBEditServer = '&Server';
  SDBEditNetProtocol = '&Network protocol';
  SDBEditDatabase = '&Database';
  SDBEditAlias = '&Alias name';
  SDBEditLocal = '&Local engine';
  SDBEditRemote = '&Remote server';
  SDBEditBrowse = '&Browse';
  SDBEditConnectParams = 'Connection Parameters';
  SDBEditUserName = '&User name';
  SDBEditPassword = '&Password';
  SDBEditSQLRole = 'Rol&e';
  SDBEditConnectCharSet = 'C&harSet';
  SDBEditSQLDialect = 'S&QL Dialect';
  SDBEditLoginPromt = 'Use lo&gin prompt';
  SDBEditTestButton = '&Test';
  SDBEditGDBFilter =
   'IB/FB Database Files (*.gdb;*.ib;*.fdb)|*.gdb;*.ib;*.fdb|'+
   'Interbase Database Files (*.gdb)|*.gdb|'+
   'Firebird Database Files (*.fdb)|*.fdb|'+
   'Interbase7 Database Files (*.ib)|*.ib|All files (*.*)|*.*';
  SDBEditSuccessConnection = 'Connection is successful';

  SGenSQLCaption = 'FIBPlus SQL Generator';
  SGenSQLOptions = 'Options';
  SGenSQLGetFieldsButton = 'Get &table fields';
  SGenSQLGenerateButton = '&Generate SQLs';
  SGenSQLClearButton = '&Clear SQLs';
  SGenSQLOnSaveGroup = 'On save SQLs';
  SGenSQLCheckSQLHint = 'Check SQLs before saving properties';
  SGenSQLCheckSQL = 'Check SQLs';
  SGenSQLFieldOriginHint = 'Save fields origin';
  SGenSQLFieldOrigin = 'Field origins';
  SGenSQLGeneratorOptions = 'Options of SQLs generation';
  SGenSQLPrimaryHint = 'Use only primary key in where clause';
  SGenSQLPrimary = 'Where by primary key';
  SGenSQLNonUpdatePrimaryHint = 'Not to change primary key in UpdateSQL';
  SGenSQLNonUpdatePrimary = 'Not to update primary key';
  SGenSQLDefaultSymbol = 'Use '#39'?'#39' for parameters';
  SGenSQLCheckButton = 'C&heck SQLs';
  SGenSQLKeyFields = 'Key fields';
  SGenSQLUpdateFields = 'Update fields';
  SGenSQL_SQLsTabs = 'SQLs';
  SGenSQLStatement = 'Statement &type';
  SGenSQLMakeSQLTab = 'Make SQL';
  SGenSQLFilterBy = 'Filter by';
  SGenSQLAlias = 'Table alias';
  SGenSQLTablesColumn = 'Tables';
  SGenSQLView1 = 'No Objects';
  SGenSQLView2 = 'Tables/Views';
  SGenSQLView3 = 'Stored Procedures';
  SGenSQLTargetMemo = 'Target memo';
  SGenSQLOutput1 = 'Add to buffer memo';
  SGenSQLOutput2 = 'Replace SelectSQL ';
  SGenSQLOutput3 = 'Add as JOIN to SelectSQL';
  SGenSQLSaveAllButton = 'Save &all';
  SGenSQLReplaceButton = 'Re&place "*"';
  SGenSQLCheckErrorButton = 'Check &error';
  SGenSQLSaveSQLButtonHint = 'Save current SQL';
  SReplaceSQL          = '&Replace Select SQL text';
  SGenSQLSaveSQLButton = '&Save SQL';
  SGenSQLErrorPreffix = 'Error in %s';
  SGenSQLEmpty = 'SQL is empty';
  SGenSQLCorrectSQL = 'SQL is correct';
  SGenSQLFromNotFound = 'Clause "FROM" is not found';

  SLoginDlgLoginCaption = 'Database login';
  SLoginDlgDatabase = 'Database:';

  SFieldInfoCaption = 'Developers Data Repositary';
  SFieldInfoCopyFieldsHint = 'Copy fields from current meta-object';
  SFieldInfoCopyFields = '&Copy fields';
  SFieldInfoFilter = '&Filter by current meta-object';
  SFieldInfoKindTables = 'Tables/Views';
  SFieldInfoProcedures = 'Stored Procedures';
  SFieldInfoFilterHint = 'Filter text';
  SFieldInfoGridHint = 'List of tables or stored procedures';

  SFieldInfoTablesItem = 'Tables';
  SFieldInfoProcedureItem = 'Procedures';
  SFieldInfoUserFormsItem = 'User forms';

  STransEditCaption = 'Transaction Editor';
  STransEditKind = 'Kind of transaction';
  STransEditSettings = '&Settings:';
  STransEditNewKind = '&New kind';
  STransEditSaveKindButton = '&Save kind';
  STransEditExportButton = '&Export to INI';
  STransEditImportButton = '&Import from INI';
  STransEditOpenFilter = 'Transaction kinds *.trk|*.trk|*.ini |*.ini';
  STransEditSaveFilter = 'Transaction kinds *.trk|*.trk';
  STransEditExportTitle = 'Export transaction settings to file';
  STransEditNewKindDialog = 'Input new kind of transaction';
  STransEditNewKindName = 'Name of kind';

  SCompEditInfoTableNotExist  = 'Table FIB$DATASETS_INFO does not exist. Would you like to create it?';
  SCompEditEditTransaction    = 'Edit transaction parameters';
  SCompEditInfoFieldsNotExist = 'Table FIB$FIELDS_INFO does not exist. Would you like to create it?';
  SCompEditInfoFieldsForbid   = 'Can''t use FIB$FIELDS_INFO.'#13#10+
   'urFieldsInfo not included into Database.UseRepositories.';

  SCompEditEditFieldInfo = 'Edit field information table';
  SCompEditErrorMessages = 'Edit error messages table';
  SCompEditErrorTableNotExist = 'Table FIB$ERROR_MESSAGES does not exist. Would you like to create it?';
  SCompEditErrorTableForbid  = 'Can''t use  FIB$ERROR_MESSAGES.'#13#10+
  'urErrorMessagesInfo not included into Database.UseRepositories.';

  SCompEditDBEditor = 'Database Editor';
  SCompEditSQLGenerator = 'SQL Generator';
  SCompSaveToDataSetInfo = 'Save to dataSets repository table';
  SCompChooseDataSetInfo = 'Choose from dataSets repository table';
  SCompEditDataSetInfo = 'Edit dataSets repository table';
  SCompEditDataSet_ID = '.DataSet_ID should be greater than 0';
  SCompEditSQLText          = '(SQL Text)';
  SCompEditStatTableExist   = 'Statistic table already exists.';
  SCompEditStatTableCreated = 'Statistic table has been created successfully.';
  SCompEditCreateStatTable  = 'Create statistic table';
  SCompEditDataSetInfoNotExists = 'Table FIB$DATASETS_INFO does not exist.';
  SCompEditDataSetInfoForbid    = 'Can''t use FIB$DATASETS_INFO.'#13#10+
   'urDataSetInfo not included into Database.UseRepositories.';
  SCompEditUnableInsertInfoRecord = 'Error of inserting new information record';
  SCompEditSaveDataSetProperty = 'Save FIBDataSet properties';
  SCompEditDataSetDesc = 'Set dataset description';
  SCompEditFieldInfoLoadError = 'Error of loading FieldInfo from stream';

  SFIBErrorCloneCursor = 'Unable to open cloned cursor %s from %s. Incompatible field types.';
  SFIBErrorBeforeDisconnectDetail = 'Error of %s.BeforeDisconnect. Probably you are trying to get access to destroyed components. %s';
  SFIBErrorBeforeDisconnect = 'Error of %s.BeforeDisconnect. %s';
  SFIBErrorAfterDisconnectDetail =  'Error of %s.AfterDisconnect. Probably you are trying to get access to destroyed components. %s';
  SFIBErrorAfterDisconnect =  'Error of %s.AfterDisconnect. %s';
  SFIBErrorNoDBLoginDialog = 'Unable to find Database login dialog. ';
  SFIBErrorInstallPropertyEditorPackage = 'Please, install package with property editors.';
  SFIBErrorIncludeDBLoginDialog =  'Please, add FIBDBLoginDlg into USES statement of your project.';
  SFIBErrorCircularLinks = 'Circular link is not allowed.';
  SFIBErrorParamNotExist = 'Parameter "%s" does not exist in %s';
  SFIBErrorWideStringValueTooLong = '%s. Value for WideString Parameter "%s" too long';  
  SFIBParamsCountNotEquelValuesCount= '%s. Parameters count is not equel count of parameter values';
  SFIBErrorEOFInComments = 'EOF in comment detected';
  SFIBErrorEOFInString = 'EOF in string detected';
  SFIBErrorParamNameExpected = 'Parameter name expected';
  SFIBErrorInvalidComp = 'Invalid comp value';
  SFIBErrorNotDataSet = '%s is not TpFIBDataSet';
  SFIBErrorNotDataSetDetail = 'Unable to apply %s because %s is not TpFIBDataSet';
  SFIBErrorNotifyEvent = 'Unable to add NotifyEvent';
  SFIBErrorNotifyEventIndexOut = 'EventList: Index out of range';
  SFIBErrorNotifyEventInvalid = 'EventList: Invalid typecast';
  SFIBErrorHandlerExists = 'Instance of TpFIBErroHandler already exists';
  SFIBErrorUnableStreamLoad = '%s: unable to load from stream';
  SFIBErrorAbortUpdates = 'User abort apply updates for %s %s';
  SFIBErrorUnableGetRecordCount = '%s unable to get number of records';
  SFIBErrorUnableLock = 'Unable to lock record. Update query is empty';
  SFIBErrorGenerationError = '%s: unable to generate %s because fields for "%s" do not exist in dataset.';

  SSuccess = 'Successful execution';
  SDelphiException = 'DelphiException %s';
  SNoOptionsSet = 'No Install Options selected';
  SNoDestinationDirectory = 'DestinationDirectory is not set';
  SNosourceDirectory = 'SourceDirectory is not set';
  SNoUninstallFile = 'Uninstall File Name is not set';
  SOptionNeedsClient = '%s component requires Client to function properly';
  SOptionNeedsServer = '%s component requires Server to function properly';
  SInvalidOption = 'Invalid option specified';
  SInvalidOnErrorResult = 'Unexpected onError return value';
  SInvalidOnStatusResult = 'Unexpected onStatus return value';

  reVarNotArray   = 'Variant is not an array.';
  reVarArrayBounds = 'Variant array index out of bounds.';
  reVarArrayCreate = 'Unable to create variant array.';

  ErrInstallMess = 'FIBPlusTools are not installed';
  FPFIBPlusMenu = 'FIBP&lus';
  FPPreferencesMenu = '&Preferences';
  FPSQLNavigator = 'SQL &Navigator';
  FPBuildMenu = 'FIBPlus %d.%d.%d';

  FPTPrefCaption = 'FIBPlus Preferences';
  FPTGeneratorPref = 'Prefix Generator name';
  FPTGeneratorSuf = 'Sufix Generator name';
  FPTCharSet = 'C&harSet';
  FPTSQLDialect = 'S&QL Dialect';
  FPTStoreConnected = 'Store Connected';
  FPTSyncTime = 'Synchronize Time ';
  FPTUpperOldNames = 'Upper Old Names';
  FPTUseLoginPromt = 'Use Login Prompt';
  FPTTimeoutAction = 'Timeout action';
  FPTTimeout = 'Timeout';
  FPTGotoFirstRecord = 'Go to First Record';
  FPTCheckParam = 'Check parameters';
  FPTAutoStartTrans = 'Autostart transaction';
  FPTAutoCommitTrans = 'Autocommit transaction';

  FPTNavCaption = 'FIBPlus SQL Navigator';
  FPTNavGetFormsButtonHint = 'Scan all forms from active project';
  FPTNavCloseFormsButtonHint = 'Close forms opened from SQLnavigator';
  FPTNavSaveSQLButtonHint = 'Save selected SQLs';
  FPTNavFindButtonHint = 'Find in SQLs';
  FPTNavCheckButtonHint = 'Check selected SQLs ';
  FPTNavSaveCallsHint = 'Save project calls to descriptions';
  FPTNavHideSearchButtonHint = 'Hide Search Result';
  FPTNavShowOIButtonHint = 'Show object inspector';
  FPTNavSearchResults = 'Search Result for ""';
  FPTNavSelectAllItem = 'Select All';
  FPTNavUnselectAllItem = 'Unselect All';
  FPTNavGotoCurrentItem = 'Goto current component';
  FPTNavShowResultsItem = 'Show Search Result';
  FPTNavHideResultsItem = 'Hide Search Result';
  FPTNavCopyToClipboardItem = 'Copy to Clipboard';
  FPTNavSaveAllItem = 'Save all SQLs';
  FPTNavSaveSelectSQlItem = 'Save only SelectSQL';
  FPTNavSaveCallsItem = 'Save project calls to descriptions';
  FPTNavClearCallsItem = 'Clear project calls from descriptions';
  FPTNavOptions = 'Options';
  FPTNavIncludeMachineItem = 'Include Machine Name into descriptions';
  FPTNavSQLFilter = 'SQL files (*.sql)|*.sql';
  FPTNavSearchResultCaption = 'Search Result for "%s"';
  FPTNavNotFound = '%s not found';
  FPTNavUnableToGoto = 'Unable to go to component';
  FPTNavProjectsNotExist = 'Table "FIB$PROJECTS" does not exist in %s';

  { 06/11/02 }
  SFIBStatNoSave = 'Unable to save statistics. Table "FIB$APP_STATISIC" does not exist.';
  SFIBStatNoSaveAppID = 'Unable to save statistics. ApplicationID is unknown.';
  SGenSQLSelectMain = 'Select main table:';

  { 09/25/02 }
  FPNewsgroups = 'Join FIBPlus newsgroups';
  FPNewsgroupsEnglish = 'English';
  FPNewsgroupsRussian = 'Russian';
  FPFeedback = 'Feedback';
  FPFeedbackBug = 'Bug-report';
  FPFeedbackSuggestions = 'Suggestions';
  FPFeedbackInformation = 'Information request';

  FPAutoOptEditorCaption = '%s - AutoUpdateOptions Editor';
  FPAutoOptEditorPrimaryKey = 'Primary key field(s):';
  FPAutoOptEditorModTable = 'Modifying table';
  FPAutoOptEditorSQL = ' SQL generation ';
  FPAutoOptEditorAutoGen = 'Auto generation of modifying queries after DataSet opening';
  FPAutoOptEditorModFields = 'Include in UpdateSQL only modified fields';
  FPAutoOptEditorAutoInc = ' Auto increment options ';
  FPAutoOptEditorGenName = 'Generator Name';
  FPAutoOptEditorWhenGet1 = 'Do not get generator value';
  FPAutoOptEditorWhenGet2 = 'Get new generator value when inserting of new record';
  FPAutoOptEditorWhenGet3 = 'Get new generator value before posting of new record';

  FPConditionsCaption = 'Edit Conditions';
  FPConditionsText = ' Condition text ';
  FPConditionsNames = ' Condition Names ';
  FPConditionsColumnConditions = 'Conditions';
  FPConditionsDelete = '&Delete';
  FPConditionsAdd = '&Add';
  FPConditionsClear = 'C&lear';

  FPOptionsCaption = '%s - Options, PrepareOptions';
  FPOptionsPage = 'Options';
  FPOptionsTrimChars = 'Trim char fields';
  FPOptionsRefresh = 'Refresh current record after posting';
  FPOptionsRefreshDelete = 'Delete non existing records from local buffer';
  FPOptionsAutoStart = 'Auto start transaction before opening';
  FPOptionsApplyFormats = 'Apply DefaultFormats to DisplayFormat and EditFormat';
  FPOptionsIdleUpdate = 'Execute idle update before record editing';
  FPOptionsKeepSort = 'Place modified record according to sorting order';
  FPOptionsRestoreSort = 'Restore local sorting after re-opening';

  FPOptionsPreparePage = 'PrepareOptions';
  FPOptionsSetRequired = 'Set Required property in TField components according to NOT NULL state';
  FPOptionsSetReadOnly = 'Set ReadOnly property in TField components for calculated fields';
  FPOptionsSetDefault = 'Set Default property of TField components according to table description';
  FPOptionsEmulateBoolean = 'Emulate boolean fields';
  FPOptionsCreateBCD = 'Create TBCDField instances for INT64 fields with any scale (SQLDialect 3)';
  FPOptionsApplyRepository = 'Apply FIBPlus Repository options to field propetries, queries, etc';
  FPOptionsSortFields = 'Fill SortFields property using ORDER BY clause';
  FPOptionsRecordCount = 'Get record count without fetching all records';
  FPVisibleRecno = 'Recno for visible records only';  

  // 07.11.2003
  SCompDatabaseNotConnected = 'Database component is not set properly or not connected';
//19.01.2004
  SCheckSQLs ='Check SQLs';
  SEditSQL   ='Edit SQL text';
  SNoErrors  ='No Errors';
  SErrorIn   ='Error in :';

  SNoTimers = 'Not enough timers available';  
implementation

end.











