// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Econsts.pas' rev: 21.00

#ifndef EconstsHPP
#define EconstsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Etypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Econsts
{
//-- type declarations -------------------------------------------------------
struct EMsgsRec
{
	
public:
	System::AnsiString Msg;
	int No;
};


typedef StaticArray<EMsgsRec, 172> Econsts__1;

typedef StaticArray<System::AnsiString, 158> Econsts__2;

typedef StaticArray<System::AnsiString, 48> Econsts__3;

typedef StaticArray<System::AnsiString, 26> Econsts__4;

//-- var, const, procedure ---------------------------------------------------
static const int MagicNumber6 = 0x100fab10;
static const int MagicNumber5 = 0xfab10;
extern PACKAGE System::Word EurekaLogCurrentVersion;
#define EurekaLogVersion L"6.0.21"
#define EurekaLogViewerVersion L"3.0.8"
#define ECopyrightCaption L"Copyright (c) 2001 - "
#define EAuthorCaption L"by Fabio Dell'Aria"
#define EurekaIni L"EurekaLog.ini"
#define SafeCallExceptionHandled L"[SafeCall Exception]: "
extern PACKAGE void *UnassignedPointer;
static const int color_DialogBack = 0xc8d0d4;
static const int color_BackColorActive = 0xc29b82;
static const int color_BorderColorActive = 0x404040;
static const int color_BorderBackActive = 0x808080;
static const int color_BackColorInactive = 0x979797;
static const int color_BorderColorInactive = 0x303030;
static const int color_BorderBackInactive = 0x606060;
static const int color_CaptionActive = 0xffffff;
static const int color_CaptionShadow = 0x222222;
static const int color_CaptionInactive = 0xe0e0e0;
static const ShortInt color_Text = 0x0;
static const int color_Back = 0xffffff;
#define EurekaTypePRO L"Professional"
#define EurekaTypeENT L"Enterprise"
#define EurekaLogSection L"Exception Log"
#define EurekaLogFirstLine_XML L"<!-- EurekaLog First Line"
#define EurekaLogLastLine_XML L"EurekaLog Last Line -->"
#define EurekaLogFirstLine_TXT L""
#define EurekaLogLastLine_TXT L""
#define EurekaNotRegisteredVersion L"NOT REGISTERED VERSION"
#define EurekaGoToUpdatesPage L"Go to updates page"
#define EurekaBUGString L"Error: '%s'\r\n\r\nThis is a probably EurekaLog bug.\r\nDo"\
	L" you want to send the bug information to EurekaLog author?"
#define EurekaInternalBUGString L"Error: '%s'\r\n\r\nThis is an internal EurekaLog bug.\r\nD"\
	L"o you want to send the bug information to EurekaLog author"\
	L"?"
#define EGeneralError L"General Error."
#define EModule L"Module: "
#define EDebugInfoNotActive L"Options \"Debug Information\" or \"Map File = Detailed\" a"\
	L"re not active or MapFile not found.\r\nMapFile: \"%s\".\r\n"\
	L"EurekaLog will be disabled into this project. Error code: "\
	L"%d"
#define ENotReadMapFile L"It is not possible to read the Map File."
#define ECorrupted L"Corrupted Map File or unknown file format."
#define EInsertEmail L"You must select a valid email address."
#define EInsertURL L"You must select a valid URL."
#define EURLNoPrm L"You cannot insert UserID/Password/Port parameters in URL."
#define EURLProtConf L"You have insert a Protocol URL different from the selected"\
	L" Protocol Type."
#define EURLInvalidPort L"You must select a valid \"Web-Port\" value."
#define EInsertSMTPFrom L"You must select a valid \"SMTP-From\" email address."
#define EInsertSMTPPort L"You must select a valid \"SMTP-Port\" value."
#define EInsertSMTPHost L"You must select a valid \"SMTP-Host\" value."
#define EInvalidTrakerField L"You must insert a valid Web Bug-Traker \"%s\"."
#define EMantisCategoryEmpty L"Mantis 1.1.x need that the \"Category\" field is not empty"\
	L"!"
#define EOptionsCaption L"EurekaLog"
#define EOptions L"EurekaLog Options..."
#define EOptions2 L"EurekaLog IDE Options..."
#define EOptions3 L"EurekaLog Help"
#define EViewItem L"View Exception Log..."
#define EAboutItem L"About EurekaLog..."
#define ETutorialItem L"EurekaLog Tutorial..."
#define EFormCaption L"EurekaLog Options"
#define EActivateLog L"&Activate EurekaLog"
#define EAttenction L"Warning."
#define EInformation L"Information"
#define EInternalBUG L"Probably internal bug"
#define EInternalBUGSubject L"Probably EurekaLog 6.0.21 bug."
#define EInternalCriticalBUGSubject L"EurekaLog 6.0.21 critical bug."
#define EInternalBUGBody L"See the attached log."
#define ENoConnectWithEClient L"Cannot connect with your email client.\r\nSend manually th"\
	L"e \"%s\" file to the support@eurekalog.com email address, "\
	L"after click on OK button to close this box."
#define EOK L"&OK"
#define ECancel L"&Cancel"
#define EHelp L"&Help"
#define EExceptionToIgnore L"Exceptions Filters"
#define EDefault L"Default"
#define EAdd L"A&dd..."
#define ESub L"&Remove"
#define ECapType L"Type"
#define ELabel_OutputPath L"Log file output path"
#define EExceptionDialog L"Exception Dialog"
#define ECapMsg L"Message"
#define EExceptionsTab L"Exceptions"
#define ESendTab L"Send"
#define ELogFileTab L"Log File"
#define EMessagesTab L"Messages"
#define EAdvancedTab L"Advanced"
#define ESelectOutputPath L"Select output path..."
#define EActivateHandle L"Activate"
#define ESaveLogFile L"Save Log File"
#define EErrorType L"Error type"
#define EAppendLogCaption L"Append Logs in message text (no send file)"
#define ESendEntireLog L"Send entire Log file"
#define ESendScreenshotCaption L"Send a screenshot"
#define EUseActiveWindow L"Use only active window"
#define EAppendReproduceCaption L"Append 'Reproduce Text'"
#define ESMTPShowDialog L"Show the send dialog"
#define ECommonSendOptions L"Common Send Options"
#define ECommonSaveOptions L"Common Save options"
#define ETerminateGroup L"Terminate Button"
#define ETerminateOperation L"Operation"
#define ENone L"(none)"
#define ETerminate L"Terminate"
#define ERestart L"Restart"
#define EShowTerminateBtnLabel L"Show"
#define ETerminateLabel L"Show"
#define ELogShow L"Show"
#define EOptionsListType L"Type"
#define EOptionsListSubType L"Sub-Type"
#define EMessagesLabel L"Messages"
#define ELookAndFeel L"Use EurekaLog 'Look and Feel'"
#define EOptionsFiles L"Options Files"
#define ELoadOptionsBtn L"&Load Options..."
#define ESaveOptionsBtn L"&Save current Options..."
#define EOpenLogBtn L"O&pen Log File"
#define EFreezeCaption L"Anti-Freeze Options"
#define EFreezeActivate L"Activate with Timeout"
#define EFreezeTimeout L"Timeout"
#define EEmailSendOptions L"Email Send Options"
#define ESendNo L"Do not send"
#define ESendEmailClient L"Use Email Client"
#define ESendSMTPClient L"Use SMTP Client"
#define ESendSMTPServer L"Use SMTP Server"
#define EEmailAddresses L"Addresses"
#define EEmailObject L"Subject"
#define EEmailMessage L"Message"
#define ESMTPFromCaption L"From"
#define ESMTPHostCaption L"Host"
#define ESMTPPortCaption L"Port"
#define ESMTPUserIDCaption L"UserID"
#define ESMTPPasswordCaption L"Password"
#define ELogSave L"Saving Options"
#define ELogNumberLog L"Number of errors to save"
#define ELogNotDuplicate L"Do not save duplicate errors"
#define EAreYouSure L"Are you sure?"
#define EShowExceptionDialog L"Show Exception Dialog"
#define ELogNotFound L"Exception Log file not found."
#define ENoProjectSelected L"No one currently selected EurekaLog project."
#define EQuestion L"Question."
#define EExtFileStr L"EurekaLog options file (*.eof)|*.eof"
#define EErrorCaption L"Error."
#define EForegroundTitle L"Foreground Tab"
#define ERadioCPU L"CPU"
#define ERadioModulesList L"Modules List"
#define ERadioCallStack L"Call Stack"
#define ERadioGeneral L"General"
#define EInternalErrorCaption L"WARNING"
#define EInternalError L"An exception has raised into the \"%s\" event.\r\nPlease c"\
	L"ontact the assistance."
#define EInternalHookExceptionError L"An internal error has occurred into the \"ExceptNotify\" p"\
	L"rocedure at line %d.\r\nPlease contact the assistance."
#define EAboutCaption L"About EurekaLog"
#define EExpireTime L"Every project compiled with EurekaLog\r\nexpires after 30 "\
	L"days."
#define EOrder L"&Buy now"
#define EWhatIs L"&What is it?"
#define EWaitingCaption L"EurekaLog processing..."
#define ECommonOptions L"Common Options"
#define ESendInThread L"Sent in a separated thread"
#define ESendHTML L"Send last HTML page"
#define ESaveFailure L"Save only for failure sent"
#define EWebSendOptions L"Web Send Options"
#define EWebPort L"Port"
#define EWebUser L"User"
#define EWebPassword L"Password"
#define EWebURL L"URL"
#define EWebUseFTP L"FTP"
#define EWebUseHTTP L"HTTP"
#define EWebUseHTTPS L"HTTPS"
#define EWebNoSend L"No send"
#define EAttachedFiles L"Attached files"
#define ECopyLogInCaseOfError L"Copy Log Text in case of send error"
#define ESaveFiles L"Save a Zip Files copy in case of send failure"
#define EUseMainModuleOptions L"Use Main Module options"
#define EAddDateInFileName L"Add 'Date' in sent file name"
#define EAddComputerName L"Add 'Computer name' in Log file name"
#define ESaveModulesAndProcessesSection L"Save Modules and Processes Sections"
#define ESaveAssemblerAndCPUSection L"Save Assembler and CPU Sections"
#define ESendXMLCopy L"Send an XML Log's copy"
#define EDeleteLog L"Delete the Log at version change"
#define ECloseEveryDialog L"Close every dialog after"
#define ESeconds L"seconds"
#define ESupportURL L"Support URL"
#define EHTMLLayout L"HTML Layout"
#define EHTMLLayoutHELP L"Help: use <%HTML_TAG%> tag"
#define EShowDetailsButton L"Show 'Details' button"
#define EShowInDetailedMode L"Show dialog in 'Detailed' mode"
#define ESendEmailChecked L"'Send Error Report' option checked"
#define EAttachScreenshotChecked L"'Attach Screenshot' option checked"
#define EShowCopyToClipboard L"Show 'Copy to clipboard' option"
#define EShowInTopMost L"Show dialog in Top-Most mode"
#define EEncryptPassword L"Encryption password"
#define EShowDlls L"Show the DLLs functions"
#define EShowBPLs L"Show the BPLs functions"
#define EShowBorladThreads L"Show all Borland Threads call-stack"
#define EShowWindowsThreads L"Show all Windows Threads call-stack"
#define EBehaviour L"Behaviour Options"
#define EAutoTerminateApplicationLabel1 L"application after"
#define EAutoTerminateApplicationLabel2 L"errors in"
#define EAutoTerminateApplicationLabel3 L"minutes"
#define EPauseBorlandThreads L"Pause all Borland Threads"
#define EDoNotPauseMainThread L"Don't pause Main Thread"
#define EPauseWindowsthread L"Pause all Windows Threads"
#define EActivateAutoTerminateApplication L"Activate auto Terminate/Restart"
extern PACKAGE Econsts__1 EMsgs;
#define EText L"Text"
extern PACKAGE Econsts__2 EVals;
extern PACKAGE Econsts__3 EShowOptions;
extern PACKAGE Econsts__4 EVariablesOptions;

}	/* namespace Econsts */
using namespace Econsts;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EconstsHPP
