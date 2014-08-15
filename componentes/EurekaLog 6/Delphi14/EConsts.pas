{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{            Consts Unit - EConsts               }
{                                                }
{  Copyright (c) 2001 - 2008 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EConsts;

{$I Exceptions.inc}

interface

uses 
  ETypes;

type
  EMsgsRec = record
    Msg: AnsiString;
    No: Integer;
  end;

const
  // Number used to check EurekaLog information presents.
  // Before the 6.0.4 version was: $000FAB10 (changed for backward compatibility).
  MagicNumber6 = $100FAB10;
  MagicNumber5 = $000FAB10;

  EurekaLogCurrentVersion: Word = 6020;
{$IFNDEF BUILD_FOR_DOTNET}
  EurekaLogVersion = '6.0.21'; // String base version number.
{$ELSE}
  EurekaLogVersion = '6.0.17 RC 1'; // String base version number.
{$ENDIF}    

  EurekaLogViewerVersion = '3.0.8'; // EurekaLog Viewer String version number.

  ECopyrightCaption = 'Copyright (c) 2001 - ';
  EAuthorCaption = 'by Fabio Dell''Aria';

  EurekaIni = 'EurekaLog.ini';

  // SafeCall consts...
  SafeCallExceptionHandled = '[SafeCall Exception]: ';

  UnassignedPointer: Pointer = Pointer(-1);

  // Dialog colors const...
  color_DialogBack = $00C8D0D4;

  color_BackColorActive = $00C29B82; // Caption color.
  color_BorderColorActive = $00404040;
  color_BorderBackActive = $00808080;

  color_BackColorInactive = $00979797; // Caption color.
  color_BorderColorInactive = $00303030;
  color_BorderBackInactive = $00606060;

  color_CaptionActive = $00FFFFFF;
  color_CaptionShadow = $00222222;
  color_CaptionInactive = $00E0E0E0;

  color_Text = $00000000;
  color_Back = $00FFFFFF;

{$IFDEF EUREKALOG_DEMO}
  EBuyItem = 'Buy EurekaLog...';
  EurekaDemoString =
    'The "%s" program is compiled with EurekaLog ' + EurekaLogVersion +
    ' trial version.'#13#10 +
    'You can test this program for 30 days after its compilation.'#13#10#13#10 +
    'To buy the EurekaLog full version go to: http://www.eurekalog.com';

  EurekaTypeTRL = 'Trial';
{$ENDIF}
{$IFNDEF PROFESSIONAL}
  EurekaTypeSTD = 'Standard';
{$ELSE}
  EurekaTypePRO = 'Professional';
  EurekaTypeENT = 'Enterprise';
{$ENDIF}

  EurekaLogSection = 'Exception Log';

  EurekaLogFirstLine_XML = '<!-- EurekaLog First Line';
  EurekaLogLastLine_XML = 'EurekaLog Last Line -->';
  EurekaLogFirstLine_TXT = '';
  EurekaLogLastLine_TXT = '';

  EurekaNotRegisteredVersion = 'NOT REGISTERED VERSION';
  EurekaGoToUpdatesPage = 'Go to updates page';

  EurekaBUGString = 'Error: ''%s'''#13#10#13#10'This is a probably ' +
    'EurekaLog bug.'#13#10 + 'Do you want to send the bug information ' +
    'to EurekaLog author?';

  EurekaInternalBUGString = 'Error: ''%s'''#13#10#13#10'This is an internal ' +
    'EurekaLog bug.'#13#10 + 'Do you want to send the bug information ' +
    'to EurekaLog author?';

  EGeneralError = 'General Error.';
  EModule = 'Module: ';
  EDebugInfoNotActive = 'Options "Debug Information" or "Map File = ' +
    'Detailed" are not active or MapFile not found.'#13#10'MapFile: "%s".'#13#10 +
    'EurekaLog will be disabled into this project. Error code: %d';

  ENotReadMapFile = 'It is not possible to read the Map File.';
  ECorrupted = 'Corrupted Map File or unknown file format.';

  EInsertEmail = 'You must select a valid email address.';
  EInsertURL = 'You must select a valid URL.';
  EURLNoPrm = 'You cannot insert UserID/Password/Port parameters in URL.';
  EURLProtConf = 'You have insert a Protocol URL different from the selected Protocol Type.';
  EURLInvalidPort = 'You must select a valid "Web-Port" value.';  
  EInsertSMTPFrom = 'You must select a valid "SMTP-From" email address.';
  EInsertSMTPPort = 'You must select a valid "SMTP-Port" value.';
  EInsertSMTPHost = 'You must select a valid "SMTP-Host" value.';
  EInvalidTrakerField = 'You must insert a valid Web Bug-Traker "%s".';
  EMantisCategoryEmpty = 'Mantis 1.1.x need that the "Category" field is not empty!';
  EOptionsCaption = 'EurekaLog';
  EOptions = 'EurekaLog Options...';
  EOptions2 = 'EurekaLog IDE Options...';
  EOptions3 = 'EurekaLog Help';    
  EViewItem = 'View Exception Log...';
  EAboutItem = 'About EurekaLog...';
  ETutorialItem = 'EurekaLog Tutorial...';
  EFormCaption = 'EurekaLog Options';
  EActivateLog = '&Activate EurekaLog';
  EAttenction = 'Warning.';
  EInformation = 'Information';
  EInternalBUG = 'Probably internal bug';
  EInternalBUGSubject = 'Probably EurekaLog ' + EurekaLogVersion + ' bug.';
  EInternalCriticalBUGSubject = 'EurekaLog ' + EurekaLogVersion + ' critical bug.';
  EInternalBUGBody = 'See the attached log.';
  ENoConnectWithEClient = 'Cannot connect with your email client.'#13#10 +
    'Send manually the "%s" file to the support@eurekalog.com email address, ' +
    'after click on OK button to close this box.';
  EOK = '&OK';
  ECancel = '&Cancel';
  EHelp = '&Help';
  EExceptionToIgnore = 'Exceptions Filters';
  EDefault = 'Default';
  EAdd = 'A&dd...';
  ESub = '&Remove';
  ECapType = 'Type';
  ELabel_OutputPath = 'Log file output path';
  EExceptionDialog = 'Exception Dialog';
  ECapMsg = 'Message';
  EExceptionsTab = 'Exceptions';
  ESendTab = 'Send';
  ELogFileTab = 'Log File';
  EMessagesTab = 'Messages';
  EAdvancedTab = 'Advanced';
  ESelectOutputPath = 'Select output path...';
  EActivateHandle = 'Activate';
  ESaveLogFile = 'Save Log File';
  EErrorType = 'Error type';
  EAppendLogCaption = 'Append Logs in message text (no send file)';
  ESendEntireLog = 'Send entire Log file';
  ESendScreenshotCaption = 'Send a screenshot';
  EUseActiveWindow = 'Use only active window';
  EAppendReproduceCaption = 'Append ''Reproduce Text''';
  ESMTPShowDialog = 'Show the send dialog';
  ECommonSendOptions = 'Common Send Options';
  ECommonSaveOptions = 'Common Save options';
  ETerminateGroup = 'Terminate Button';
  ETerminateOperation = 'Operation';
  ENone = '(none)';
  ETerminate = 'Terminate';
  ERestart = 'Restart';
  EShowTerminateBtnLabel = 'Show';
  ETerminateLabel = 'Show';
  ELogShow = 'Show';
  EOptionsListType = 'Type';
  EOptionsListSubType = 'Sub-Type';
  EMessagesLabel = 'Messages';
  ELookAndFeel = 'Use EurekaLog ''Look and Feel''';
  EOptionsFiles = 'Options Files';
  ELoadOptionsBtn = '&Load Options...';
  ESaveOptionsBtn = '&Save current Options...';
  EOpenLogBtn = 'O&pen Log File';
  EFreezeCaption = 'Anti-Freeze Options';
  EFreezeActivate = 'Activate with Timeout';
  EFreezeTimeout = 'Timeout';
  EEmailSendOptions = 'Email Send Options';
  ESendNo = 'Do not send';
  ESendEmailClient = 'Use Email Client';
  ESendSMTPClient = 'Use SMTP Client';
  ESendSMTPServer = 'Use SMTP Server';
  EEmailAddresses = 'Addresses';
  EEmailObject = 'Subject';
  EEmailMessage = 'Message';
  ESMTPFromCaption = 'From';
  ESMTPHostCaption = 'Host';
  ESMTPPortCaption = 'Port';
  ESMTPUserIDCaption = 'UserID';
  ESMTPPasswordCaption = 'Password';
  ELogSave = 'Saving Options';
  ELogNumberLog = 'Number of errors to save';
  ELogNotDuplicate = 'Do not save duplicate errors';
  EAreYouSure = 'Are you sure?';
  EShowExceptionDialog = 'Show Exception Dialog';
  ELogNotFound = 'Exception Log file not found.';
  ENoProjectSelected = 'No one currently selected EurekaLog project.';
  EQuestion = 'Question.';
  EExtFileStr = 'EurekaLog options file (*.eof)|*.eof';
  EErrorCaption = 'Error.';
  EForegroundTitle = 'Foreground Tab';
  ERadioCPU = 'CPU';
  ERadioModulesList = 'Modules List';
  ERadioCallStack = 'Call Stack';
  ERadioGeneral = 'General';
  EInternalErrorCaption = 'WARNING';
  EInternalError = 'An exception has raised into the "%s" event.'#13#10
    + 'Please contact the assistance.';
  EInternalHookExceptionError = 'An internal error has occurred into the ' +
    '"ExceptNotify" procedure at line %d.'#13#10 +
    'Please contact the assistance.';

  EAboutCaption = 'About EurekaLog';
  EExpireTime = 'Every project compiled with EurekaLog'#13#10'expires after 30 days.';
  EOrder = '&Buy now';
  EWhatIs = '&What is it?';
  EWaitingCaption = 'EurekaLog processing...';
  ECommonOptions = 'Common Options';
  ESendInThread = 'Sent in a separated thread';
  ESendHTML = 'Send last HTML page';
  ESaveFailure = 'Save only for failure sent';
  EWebSendOptions = 'Web Send Options';
  EWebPort = 'Port';
  EWebUser = 'User';
  EWebPassword = 'Password';
  EWebURL = 'URL';
  EWebUseFTP = 'FTP';
  EWebUseHTTP = 'HTTP';
  EWebUseHTTPS = 'HTTPS';  
  EWebNoSend = 'No send';
  EAttachedFiles = 'Attached files';
  ECopyLogInCaseOfError = 'Copy Log Text in case of send error';
  ESaveFiles = 'Save a Zip Files copy in case of send failure';
  EUseMainModuleOptions = 'Use Main Module options';
  EAddDateInFileName = 'Add ''Date'' in sent file name';
  EAddComputerName = 'Add ''Computer name'' in Log file name';
  ESaveModulesAndProcessesSection = 'Save Modules and Processes Sections';
  ESaveAssemblerAndCPUSection = 'Save Assembler and CPU Sections';
  ESendXMLCopy = 'Send an XML Log''s copy';
  EDeleteLog = 'Delete the Log at version change';
  ECloseEveryDialog = 'Close every dialog after';
  ESeconds = 'seconds';
  ESupportURL = 'Support URL';
  EHTMLLayout = 'HTML Layout';
  EHTMLLayoutHELP = 'Help: use <%HTML_TAG%> tag';
  EShowDetailsButton = 'Show ''Details'' button';
  EShowInDetailedMode = 'Show dialog in ''Detailed'' mode';
  ESendEmailChecked = '''Send Error Report'' option checked';
  EAttachScreenshotChecked = '''Attach Screenshot'' option checked';
  EShowCopyToClipboard = 'Show ''Copy to clipboard'' option';
  EShowInTopMost = 'Show dialog in Top-Most mode';
  EEncryptPassword = 'Encryption password';
  EShowDlls = 'Show the DLLs functions';
  EShowBPLs = 'Show the BPLs functions';
  EShowBorladThreads = 'Show all Borland Threads call-stack';
  EShowWindowsThreads = 'Show all Windows Threads call-stack';
  EBehaviour = 'Behaviour Options';
  EAutoTerminateApplicationLabel1 = 'application after';
  EAutoTerminateApplicationLabel2 = 'errors in';
  EAutoTerminateApplicationLabel3 = 'minutes';
  EPauseBorlandThreads = 'Pause all Borland Threads';
  EDoNotPauseMainThread = 'Don''t pause Main Thread';
  EPauseWindowsthread = 'Pause all Windows Threads';
  EActivateAutoTerminateApplication = 'Activate auto Terminate/Restart';

  EMsgs: array[0..171] of EMsgsRec = (
    (Msg: 'Message captions'; No: -1), // Items
    (Msg: 'Information'; No: Integer(mtInformationMsgCaption)),
    (Msg: 'Question'; No: Integer(mtQuestionMsgCaption)),
    (Msg: 'Error'; No: Integer(mtErrorMsgCaption)),

    (Msg: 'Exception Dialog (EurekaLog type)'; No: -1), // Items
    (Msg: 'Caption (all types)'; No: Integer(mtDialog_Caption)),
    (Msg: 'Error message'; No: Integer(mtDialog_ErrorMsgCaption)),
    (Msg: 'General Caption'; No: Integer(mtDialog_GeneralCaption)),
    (Msg: 'General Header'; No: Integer(mtDialog_GeneralHeader)),
    (Msg: 'Call Stack Caption'; No: Integer(mtDialog_CallStackCaption)),
    (Msg: 'Call Stack Header'; No: Integer(mtDialog_CallStackHeader)),
    (Msg: 'Modules List Caption'; No: Integer(mtDialog_ModulesCaption)),
    (Msg: 'Modules List Header'; No: Integer(mtDialog_ModulesHeader)),
    (Msg: 'Processes List Caption'; No: Integer(mtDialog_ProcessesCaption)),
    (Msg: 'Processes List Header'; No: Integer(mtDialog_ProcessesHeader)),
    (Msg: 'Asembler Caption'; No: Integer(mtDialog_AsmCaption)),
    (Msg: 'Assembler Header'; No: Integer(mtDialog_AsmHeader)),
    (Msg: 'CPU Caption'; No: Integer(mtDialog_CPUCaption)),
    (Msg: 'CPU Header'; No: Integer(mtDialog_CPUHeader)),
    (Msg: 'OK Button'; No: Integer(mtDialog_OKButtonCaption)),
    (Msg: 'Terminate Button'; No: Integer(mtDialog_TerminateButtonCaption)),
    (Msg: 'Restart Button'; No: Integer(mtDialog_RestartButtonCaption)),
    (Msg: 'Details Button'; No: Integer(mtDialog_DetailsButtonCaption)),
    (Msg: 'Custom Button (all typed)'; No: Integer(mtDialog_CustomButtonCaption)),
    (Msg: 'Internet message'; No: Integer(mtDialog_SendMessage)),
    (Msg: 'Screenshot message'; No: Integer(mtDialog_ScreenshotMessage)),
    (Msg: 'Copy message'; No: Integer(mtDialog_CopyMessage)),
    (Msg: 'Support message'; No: Integer(mtDialog_SupportMessage)),

    (Msg: 'Exception Dialog (MS Classic type)'; No: -1), // Items
    (Msg: 'Error message'; No: Integer(mtMSDialog_ErrorMsgCaption)),
    (Msg: 'Restart message'; No: Integer(mtMSDialog_RestartCaption)),
    (Msg: 'Terminate message'; No: Integer(mtMSDialog_TerminateCaption)),
    (Msg: '"Please..." message'; No: Integer(mtMSDialog_PleaseCaption)),
    (Msg: 'Details message'; No: Integer(mtMSDialog_DescriptionCaption)),
    (Msg: '"To see..." message'; No: Integer(mtMSDialog_SeeDetailsCaption)),
    (Msg: '"click here" message'; No: Integer(mtMSDialog_SeeClickCaption)),
    (Msg: '"How to reproduce" message'; No: Integer(mtMSDialog_HowToReproduceCaption)),
    (Msg: '"Email address" text'; No: Integer(mtMSDialog_EmailCaption)),
    (Msg: 'Send Button'; No: Integer(mtMSDialog_SendButtonCaption)),
    (Msg: 'Don''t Send Button'; No: Integer(mtMSDialog_NoSendButtonCaption)),

    (Msg: 'Send Dialog'; No: -1), // Item
    (Msg: 'Caption'; No: Integer(mtSendDialog_Caption)),
    (Msg: 'Message'; No: Integer(mtSendDialog_Message)),
    (Msg: 'Resolving message'; No: Integer(mtSendDialog_Resolving)),
    (Msg: 'Login message'; No: Integer(mtSendDialog_Login)),
    (Msg: 'Connecting message'; No: Integer(mtSendDialog_Connecting)),
    (Msg: 'Connected message'; No: Integer(mtSendDialog_Connected)),
    (Msg: 'Sending message'; No: Integer(mtSendDialog_Sending)),
    (Msg: 'Sent message'; No: Integer(mtSendDialog_Sent)),
    (Msg: 'Select project message'; No: Integer(mtSendDialog_SelectProject)),
    (Msg: 'Searching message'; No: Integer(mtSendDialog_Searching)),
    (Msg: 'Modifying message'; No: Integer(mtSendDialog_Modifying)),
    (Msg: 'Disconnecting message'; No: Integer(mtSendDialog_Disconnecting)),
    (Msg: 'Disconnected message'; No: Integer(mtSendDialog_Disconnected)),

    (Msg: 'Reproduce Dialog'; No: -1), // Item
    (Msg: 'Caption'; No: Integer(mtReproduceDialog_Caption)),
    (Msg: 'Request message'; No: Integer(mtReproduceDialog_Request)),
    (Msg: 'OK Button'; No: Integer(mtReproduceDialog_OKButtonCaption)),

    (Msg: 'General Data'; No: -1), // Items
    (Msg: 'Application Header'; No: Integer(mtLog_AppHeader)),
    (Msg: '    Start Date'; No: Integer(mtLog_AppStartDate)),
    (Msg: '    Name/Description'; No: Integer(mtLog_AppName)),
    (Msg: '    Version Number'; No: Integer(mtLog_AppVersionNumber)),
    (Msg: '    Parameters'; No: Integer(mtLog_AppParameters)),
    (Msg: '    Compilation Date'; No: Integer(mtLog_AppCompilationDate)),
    (Msg: '    Up Time'; No: Integer(mtLog_AppUpTime)),
    (Msg: 'Exception Header'; No: Integer(mtLog_ExcHeader)),
    (Msg: '    Date'; No: Integer(mtLog_ExcDate)),
    (Msg: '    Address'; No: Integer(mtLog_ExcAddress)),
    (Msg: '    Module Name'; No: Integer(mtLog_ExcModuleName)),
    (Msg: '    Module Version'; No: Integer(mtLog_ExcModuleVersion)),
    (Msg: '    Type'; No: Integer(mtLog_ExcType)),
    (Msg: '    Message'; No: Integer(mtLog_ExcMessage)),
    (Msg: '    ID'; No: Integer(mtLog_ExcID)),
    (Msg: '    Count'; No: Integer(mtLog_ExcCount)),
    (Msg: '    Status'; No: Integer(mtLog_ExcStatus)),
    (Msg: '    Note'; No: Integer(mtLog_ExcNote)),
    (Msg: 'User Header'; No: Integer(mtLog_UserHeader)),
    (Msg: '    ID'; No: Integer(mtLog_UserID)),
    (Msg: '    Name'; No: Integer(mtLog_UserName)),
    (Msg: '    Email'; No: Integer(mtLog_UserEmail)),
    (Msg: '    Company'; No: Integer(mtLog_UserCompany)),
    (Msg: '    Privileges'; No: Integer(mtLog_UserPrivileges)),
    (Msg: 'Active Controls Header'; No: Integer(mtLog_ActCtrlsHeader)),
    (Msg: '    Form Class'; No: Integer(mtLog_ActCtrlsFormClass)),
    (Msg: '    Form Text'; No: Integer(mtLog_ActCtrlsFormText)),
    (Msg: '    Control Class'; No: Integer(mtLog_ActCtrlsControlClass)),
    (Msg: '    Control Text'; No: Integer(mtLog_ActCtrlsControlText)),
    (Msg: 'Computer Header'; No: Integer(mtLog_CmpHeader)),
    (Msg: '    Name'; No: Integer(mtLog_CmpName)),
    (Msg: '    Total Memory'; No: Integer(mtLog_CmpTotalMemory)),
    (Msg: '    Free Memory'; No: Integer(mtLog_CmpFreeMemory)),
    (Msg: '    Total Disk'; No: Integer(mtLog_CmpTotalDisk)),
    (Msg: '    Free Disk'; No: Integer(mtLog_CmpFreeDisk)),
    (Msg: '    System Up Time'; No: Integer(mtLog_CmpSystemUpTime)),
    (Msg: '    Processor'; No: Integer(mtLog_CmpProcessor)),
    (Msg: '    Display Mode'; No: Integer(mtLog_CmpDisplayMode)),
    (Msg: '    Display DPI'; No: Integer(mtLog_CmpDisplayDPI)),
    (Msg: '    Video Card'; No: Integer(mtLog_CmpVideoCard)),
    (Msg: '    Printer'; No: Integer(mtLog_CmpPrinter)),
    (Msg: 'Operating System Header'; No: Integer(mtLog_OSHeader)),
    (Msg: '    Type'; No: Integer(mtLog_OSType)),
    (Msg: '    Build #'; No: Integer(mtLog_OSBuildN)),
    (Msg: '    Update'; No: Integer(mtLog_OSUpdate)),
    (Msg: '    Language'; No: Integer(mtLog_OSLanguage)),
    (Msg: '    Charset'; No: Integer(mtLog_OSCharset)),
    (Msg: 'Network Header'; No: Integer(mtLog_NetHeader)),
    (Msg: '    IP Address'; No: Integer(mtLog_NetIP)),
    (Msg: '    Submask'; No: Integer(mtLog_NetSubmask)),
    (Msg: '    Gateway'; No: Integer(mtLog_NetGateway)),
    (Msg: '    DNS 1'; No: Integer(mtLog_NetDNS1)),
    (Msg: '    DNS 2'; No: Integer(mtLog_NetDNS2)),
    (Msg: '    DHCP'; No: Integer(mtLog_NetDHCP)),
    (Msg: 'Custom Information Header'; No: Integer(mtLog_CustInfoHeader)),

    (Msg: 'Call Stack'; No: -1), // Items
    (Msg: 'Address'; No: Integer(mtCallStack_Address)),
    (Msg: 'Module'; No: Integer(mtCallStack_Name)),
    (Msg: 'Unit'; No: Integer(mtCallStack_Unit)),
    (Msg: 'Class'; No: Integer(mtCallStack_Class)),
    (Msg: 'Procedure/Method'; No: Integer(mtCallStack_Procedure)),
    (Msg: 'Line'; No: Integer(mtCallStack_Line)),

    (Msg: 'Threads Data'; No: -1), // Items
    (Msg: 'Main Thread'; No: Integer(mtCallStack_MainThread)),
    (Msg: 'Exception Thread'; No: Integer(mtCallStack_ExceptionThread)),
    (Msg: 'Running Thread'; No: Integer(mtCallStack_RunningThread)),
    (Msg: 'Calling Thread'; No: Integer(mtCallStack_CallingThread)),
    (Msg: 'Thread ID'; No: Integer(mtCallStack_ThreadID)),
    (Msg: 'Thread Priority'; No: Integer(mtCallStack_ThreadPriority)),
    (Msg: 'Thread Class'; No: Integer(mtCallStack_ThreadClass)),

    (Msg: 'Leaks Data'; No: -1), // Items
    (Msg: 'Leak Caption'; No: Integer(mtCallStack_LeakCaption)),
    (Msg: 'Leak ''Data'''; No: Integer(mtCallStack_LeakData)),
    (Msg: 'Leak Type'; No: Integer(mtCallStack_LeakType)),
    (Msg: 'Leak Size'; No: Integer(mtCallStack_LeakSize)),
    (Msg: 'Leak Count'; No: Integer(mtCallStack_LeakCount)),

    (Msg: 'Modules List'; No: -1), // Items
    (Msg: 'Handle'; No: Integer(mtModules_Handle)),
    (Msg: 'Name'; No: Integer(mtModules_Name)),
    (Msg: 'Description'; No: Integer(mtModules_Description)),
    (Msg: 'Version'; No: Integer(mtModules_Version)),
    (Msg: 'Size'; No: Integer(mtModules_Size)),
    (Msg: 'Last Modified'; No: Integer(mtModules_LastModified)),
    (Msg: 'Path'; No: Integer(mtModules_Path)),

    (Msg: 'Processes List'; No: -1), // Items
    (Msg: 'ID'; No: Integer(mtProcesses_ID)),
    (Msg: 'Name'; No: Integer(mtProcesses_Name)),
    (Msg: 'Description'; No: Integer(mtProcesses_Description)),
    (Msg: 'Version'; No: Integer(mtProcesses_Version)),
    (Msg: 'Memory'; No: Integer(mtProcesses_Memory)),
    (Msg: 'Priority'; No: Integer(mtProcesses_Priority)),
    (Msg: 'Threads'; No: Integer(mtProcesses_Threads)),
    (Msg: 'Path'; No: Integer(mtProcesses_Path)),

    (Msg: 'CPU'; No: -1), // Items
    (Msg: 'Registers'; No: Integer(mtCPU_Registers)),
    (Msg: 'Stack'; No: Integer(mtCPU_Stack)),
    (Msg: 'Memory Dump'; No: Integer(mtCPU_MemoryDump)),

    (Msg: 'Send messages'; No: -1), // Items
    (Msg: 'Success'; No: Integer(mtSend_SuccessMsg)),
    (Msg: 'Failure'; No: Integer(mtSend_FailureMsg)),
    (Msg: 'Bug closed'; No: Integer(mtSend_BugClosedMsg)),
    (Msg: 'Unknown error'; No: Integer(mtSend_UnknownErrorMsg)),
    (Msg: 'Invalid login'; No: Integer(mtSend_InvalidLoginMsg)),
    (Msg: 'Invalid search'; No: Integer(mtSend_InvalidSearchMsg)),
    (Msg: 'Invalid selection'; No: Integer(mtSend_InvalidSelectionMsg)),
    (Msg: 'Invalid insert'; No: Integer(mtSend_InvalidInsertMsg)),
    (Msg: 'Invalid modify'; No: Integer(mtSend_InvalidModifyMsg)),

    (Msg: 'Other messages'; No: -1), // Items
    (Msg: 'File cracked'; No: Integer(mtFileCrackedMsg)),
    (Msg: 'Multi Free exception'; No: Integer(mtException_LeakMultiFree)),
    (Msg: 'Memory Overrun exception'; No: Integer(mtException_LeakMemoryOverrun)),
    (Msg: 'Anti Freeze exception'; No: Integer(mtException_AntiFreeze)),
    (Msg: 'Invalid email'; No: Integer(mtInvalidEmailMsg)));

  EText = 'Text';

  EVals: array[TMessageType] of AnsiString =
  ('Information.', // mtInformationMsgCaption
    'Question.', // mtQuestionMsgCaption
    'Error.', // mtErrorMsgCaption

    'Error occurred', // mtDialog_Caption
    'An error has occurred during program execution.'#13#10 + // mtDialog_ErrorMsgCaption
    'Please read the following information for further details.',
    'General', // mtDialog_GeneralCaption
    'General Information', // mtDialog_GeneralHeader
    'Call Stack', // mtDialog_CallStackCaption
    'Call Stack Information', // mtDialog_CallStackHeader
    'Modules', // mtDialog_ModulesCaption
    'Modules Information', // mtDialog_ModulesHeader
    'Processes', // mtDialog_ProcessesCaption
    'Processes Information', // mtDialog_ProcessesHeader
    'Assembler', // mtDialog_AsmCaption
    'Assembler Information', // mtDialog_AsmHeader
    'CPU', // mtDialog_CPUCaption
    'CPU Information', // mtDialog_CPUHeader
    '&OK', // mtDialog_OKButtonCaption
    '&Terminate', // mtDialog_TerminateButtonCaption
    '&Restart', // mtDialog_RestartButtonCaption
    '&Details', // mtDialog_DetailsButtonCaption
    '&Help', // mtDialog_CustomButtonCaption
    '&Send this error via Internet', // mtDialog_SendMessage
    '&Attach a Screenshot image', // mtDialog_ScreenshotMessage
    '&Copy to Clipboard', // mtDialog_CopyMessage
    'Go to the Support Page', // mtDialog_SupportMessage

    'The application has encountered a problem. ' +
      'We are sorry for the inconvenience.', // mtMSDialog_ErrorMsgCaption
    'Restart application.', // mtMSDialog_RestartCaption
    'Terminate application.', // mtMSDialog_TerminateCaption
    'Please tell us about this problem.', // mtMSDialog_PleaseCaption
    'We have created an error report that you can send to us. ' +
      'We will treat this report as confidential and anonymous.', // mtMSDialog_DescriptionCaption
    'To see what data the error report contains,', // mtMSDialog_SeeDetailsCaption
    'click here.', // mtMSDialog_SeeClickCaption
    'What were you doing when the problem happened (optional)?', // mtMSDialog_HowToReproduceCaption
    'Email address (optional):', // mtMSDialog_EmailCaption
    '&Send Error Report', // mtMSDialog_SendButtonCaption
    '&Don''t Send', // mtMSDialog_NoSendButtonCaption

    'Application', // mtLog_AppHeader
    'Start Date', // mtLog_AppStartingTime
    'Name/Description', // mtLog_AppName
    'Version Number', // mtLog_AppVersionNumber
    'Parameters', // mtLog_AppParameters
    'Compilation Date', // mtLog_AppCompilationDate
    'Up Time', // mtLog_AppUpTime

    'Exception', // mtLog_ExcHeader
    'Date', // mtLog_ExcTime
    'Address', // mtLog_ExcAddress
    'Module Name', // mtLog_ExcModuleName
    'Module Version', // mtLog_ExcModuleVersion
    'Type', // mtLog_ExcType
    'Message', // mtLog_ExcMessage
    'ID', // mtLog_ExcID
    'Count', // mtLog_ExcCount
    'Status', // mtLog_ExcStatus
    'Note', // mtLog_ExcNote

    'User', // mtLog_UserHeader
    'ID', // mtLog_UserID
    'Name', // mtLog_UserName
    'Email', // mtLog_UserEmail
    'Company', // mtLog_UserCompany
    'Privileges', // mtLog_UserPrivileges

    'Active Controls', // mtLog_ActCtrlsHeader
    'Form Class', // mtLog_ActCtrlsFormClass
    'Form Text', // mtLog_ActCtrlsFormText
    'Control Class', // mtLog_ActCtrlsControlClass
    'Control Text', // mtLog_ActCtrlsControlText

    'Computer', // mtLog_CmpHeader
    'Name', // mtLog_CmpName
    'Total Memory', // mtLog_CmpTotalMemory
    'Free Memory', // mtLog_CmpFreeMemory
    'Total Disk', // mtLog_CmpTotalDisk
    'Free Disk', // mtLog_CmpFreeDisk
    'System Up Time', // mtLog_CmpSystemUpTime
    'Processor', // mtLog_CmpProcessor
    'Display Mode', // mtLog_CmpDisplayMode
    'Display DPI', // mtLog_CmpDisplayDPI
    'Video Card', // mtLog_CmpVideoCard
    'Printer', // mtLog_CmpPrinter

    'Operating System', // mtLog_OSHeader
    'Type', // mtLog_OSType
    'Build #', // mtLog_OSBuildN
    'Update', // mtLog_OSUpdate
    'Language', // mtLog_OSLanguage
    'Charset', // mtLog_OSCharset    

    'Network', // mtLog_NetHeader
    'IP Address', // mtLog_NetIP
    'Submask', // mtLog_NetSubmask
    'Gateway', // mtLog_NetGateway
    'DNS 1', // mtLog_NetDNS1
    'DNS 2', // mtLog_NetDNS2
    'DHCP', // mtLog_NetDHCP

    'Custom Information', // mtLog_CustInfoHeader

    'Address', // mtCallStack_Address
    'Module', // mtCallStack_Name
    'Unit', // mtCallStack_Unit
    'Class', // mtCallStack_Class
    'Procedure/Method', // mtCallStack_Procedure
    'Line', // mtCallStack_Line

    // Call Stack Thread Data...
    'Main', // mtCallStack_MainThread
    'Exception Thread', // mtCallStack_ExceptionThread
    'Running Thread', // mtCallStack_RunningThread
    'Calling Thread', // mtCallStack_CallingThread
    'ID', // mtCallStack_ThreadID
    'Priority', // mtCallStack_ThreadPriority
    'Class', // mtCallStack_ThreadClass

    // Call Stack Leak Data...
    'Memory Leak', // mtCallStack_LeakCaption
    'Data', // mtCallStack_LeakData
    'Type', // mtCallStack_LeakType
    'Total size', // mtCallStack_LeakSize
    'Count', // mtCallStack_LeakCount

    'Send.', // mtSendDialog_Caption
    'Message', // mtSendDialog_Message
    'Resolving DNS...', // mtSendDialog_Resolving
    'Login...', // mtSendDialog_Login
    'Connecting with server...', // mtSendDialog_Connecting
    'Connected with server.', // mtSendDialog_Connected
    'Sending message...', // mtSendDialog_Sending
    'Message sent.', // mtSendDialog_Sent
    'Select project...', // mtSendDialog_SelectProject,
    'Searching...', // mtSendDialog_Searching,
    'Modifying...', // mtSendDialog_Modifying, 
    'Disconnecting...', // mtSendDialog_Disconnecting,
    'Disconnected.', // mtSendDialog_Disconnected,

    'Request', // mtReproduceDialog_Caption
    'Please describe the steps to reproduce the error:', // mtReproduceDialog_Request
    '&OK', // mtReproduceDialog_OKButtonCaption

    'Handle', // mtModules_Handle
    'Name', // mtModules_Name
    'Description', // mtModules_Description
    'Version', // mtModules_Version
    'Size', // mtModules_Size
    'Modified', // mtModules_DateModified
    'Path', // mtModules_Path

    'ID', // mtProcesses_ID
    'Name', // mtProcesses_Name
    'Description', // mtProcesses_Description
    'Version', // mtProcesses_Version
    'Memory', // mtProcesses_Memory
    'Priority', // mtProcesses_Priority
    'Threads', // mtProcesses_Threads
    'Path', // mtProcesses_Path

    'Registers', // mtCPU_Registers
    'Stack', // mtCPU_Stack
    'Memory Dump', // mtCPU_MemoryDump

    'The message was sent successfully.', // mtSend_SuccessMsg
    'Sorry, sending the message didn''t work.', // mtSend_FailureMsg
    'These BUG is just closed.'+ #13#10 +
      'Contact the program support to obtain an update.', // mtSend_BugClosedMsg
    'Unknown error.', // mtSend_UnknownErrorMsg
    'Invalid login request.', // mtSend_InvalidLoginMsg
    'Invalid search request.', // mtSend_InvalidSearchMsg
    'Invalid selection request.', // mtSend_InvalidSelectionMsg
    'Invalid insert request.', // mtSend_InvalidInsertMsg
    'Invalid modify request.',  // mtSend_InvalidModifyMsg

    // Other messages
    'This file is cracked.' + #13#10 +
      'The application will be closed.', // mtFileCrackedMsg
    'Multi Free memory leak.', // mtException_LeakMultiFree
    'Memory Overrun leak.', // mtExceptionLeakMemoryOverrun
    'The application seems to be frozen.', // mtExceptionLeakMemoryOverrun
    'Invalid email.'); // mtExceptionLeakMemoryOverrun

  EShowOptions: array[TShowOption] of AnsiString = (
    'Application|Start Date',
    'Application|Name',
    'Application|Version Number',
    'Application|Parameters',
    'Application|Compilation Date',
    'Application|Up Time',

    'Exception|Date',
    'Exception|Address',
    'Exception|Module Name',
    'Exception|Module Version',
    'Exception|Type',
    'Exception|Message',
    'Exception|ID',
    'Exception|Count',
    'Exception|Status',
    'Exception|Note',

    'User|ID',
    'User|Name',
    'User|Email',
    'User|Privileges',
    'User|Company',

    'Active Controls|Form Class',
    'Active Controls|Form Text',
    'Active Controls|Control Class',
    'Active Controls|Control Text',

    'Computer|Name',
    'Computer|Total Memory',
    'Computer|Free Memory',
    'Computer|Total Disk',
    'Computer|Free Disk',
    'Computer|System Up Time',
    'Computer|Processor',
    'Computer|Display Mode',
    'Computer|Display DPI',
    'Computer|Video Card',
    'Computer|Printer',

    'Operating System|Type',
    'Operating System|Build #',
    'Operating System|Update',
    'Operating System|Language',
    'Operating System|Charset',    

    'Network|IP Address',
    'Network|Submask',
    'Network|Gateway',
    'Network|DNS 1',
    'Network|DNS 2',
    'Network|DHCP',

    'Custom Data|All');

  EVariablesOptions: array[0..25] of AnsiString = (
    '_BugReport | Full EurekaLog bug report',
    '_ExceptModuleDesc | Description of the module that has raised the last exception',
    '_ExceptModuleName | Name of the module that has raised the last exception',
    '_ExceptModuleVer | Version of the module that has raised the last exception',
    '_ExceptMsg | Last exception message',
    '_LineBreak | Line break',
    '_MainModuleDesc | Description of the current running module',
    '_MainModuleName | Name of the current running module',
    '_MainModuleVer | Version of the current running module',
    'AllUsersProfile | \Documents and Settings\All Users',
    'AppData | \Documents and Settings\{username}\Application Data',
    'CD | Current directory with its full path',
    'ComputerName | {computername}',
    'Date | Current date in the format determined by OS',
    'HomeDrive | The drive containing the Home directory',
    'HomePath | \Documents and Settings\{username}',
    'ProgramFiles | Directory containing program files',
    'SystemDrive | The drive containing the Windows root directory',
    'SystemRoot | The Windows root directory',
    'Temp | Temporary directory',
    'Time | Current time in the format determined by OS',
    'Tmp | Temporary directory',
    'UserDomain | Current user domain name',
    'UserName | {username}',
    'UserProfile | \Documents and Settings\{username}',
    'WinDir | Windows directory');

implementation

end.

