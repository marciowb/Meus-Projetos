// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Etypes.pas' rev: 21.00

#ifndef EtypesHPP
#define EtypesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Etypes
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TShowOption { soAppStartDate, soAppName, soAppVersionNumber, soAppParameters, soAppCompilationDate, soAppUpTime, soExcDate, soExcAddress, soExcModuleName, soExcModuleVersion, soExcType, soExcMessage, soExcID, soExcCount, soExcStatus, soExcNote, soUserID, soUserName, soUserEmail, soUserPrivileges, soUserCompany, soActCtlsFormClass, soActCtlsFormText, soActCtlsControlClass, soActCtlsControlText, soCmpName, soCmpTotalMemory, soCmpFreeMemory, soCmpTotalDisk, soCmpFreeDisk, soCmpSysUpTime, soCmpProcessor, soCmpDisplayMode, soCmpDisplayDPI, soCmpVideoCard, soCmpPrinter, soOSType, soOSBuildN, soOSUpdate, soOSLanguage, soOSCharset, soNetIP, soNetSubmask, soNetGateway, soNetDNS1, soNetDNS2, soNetDHCP, soCustomData };
#pragma option pop

#pragma option push -b-
enum TMessageType { mtInformationMsgCaption, mtQuestionMsgCaption, mtErrorMsgCaption, mtDialog_Caption, mtDialog_ErrorMsgCaption, mtDialog_GeneralCaption, mtDialog_GeneralHeader, mtDialog_CallStackCaption, mtDialog_CallStackHeader, mtDialog_ModulesCaption, mtDialog_ModulesHeader, mtDialog_ProcessesCaption, mtDialog_ProcessesHeader, mtDialog_AsmCaption, mtDialog_AsmHeader, mtDialog_CPUCaption, mtDialog_CPUHeader, mtDialog_OKButtonCaption, mtDialog_TerminateButtonCaption, mtDialog_RestartButtonCaption, mtDialog_DetailsButtonCaption, mtDialog_CustomButtonCaption, mtDialog_SendMessage, mtDialog_ScreenshotMessage, mtDialog_CopyMessage, mtDialog_SupportMessage, mtMSDialog_ErrorMsgCaption, mtMSDialog_RestartCaption, mtMSDialog_TerminateCaption, mtMSDialog_PleaseCaption, mtMSDialog_DescriptionCaption, mtMSDialog_SeeDetailsCaption, mtMSDialog_SeeClickCaption, mtMSDialog_HowToReproduceCaption, mtMSDialog_EmailCaption, mtMSDialog_SendButtonCaption, mtMSDialog_NoSendButtonCaption, mtLog_AppHeader, mtLog_AppStartDate, 
	mtLog_AppName, mtLog_AppVersionNumber, mtLog_AppParameters, mtLog_AppCompilationDate, mtLog_AppUpTime, mtLog_ExcHeader, mtLog_ExcDate, mtLog_ExcAddress, mtLog_ExcModuleName, mtLog_ExcModuleVersion, mtLog_ExcType, mtLog_ExcMessage, mtLog_ExcID, mtLog_ExcCount, mtLog_ExcStatus, mtLog_ExcNote, mtLog_UserHeader, mtLog_UserID, mtLog_UserName, mtLog_UserEmail, mtLog_UserCompany, mtLog_UserPrivileges, mtLog_ActCtrlsHeader, mtLog_ActCtrlsFormClass, mtLog_ActCtrlsFormText, mtLog_ActCtrlsControlClass, mtLog_ActCtrlsControlText, mtLog_CmpHeader, mtLog_CmpName, mtLog_CmpTotalMemory, mtLog_CmpFreeMemory, mtLog_CmpTotalDisk, mtLog_CmpFreeDisk, mtLog_CmpSystemUpTime, mtLog_CmpProcessor, mtLog_CmpDisplayMode, mtLog_CmpDisplayDPI, mtLog_CmpVideoCard, mtLog_CmpPrinter, mtLog_OSHeader, mtLog_OSType, mtLog_OSBuildN, mtLog_OSUpdate, mtLog_OSLanguage, mtLog_OSCharset, mtLog_NetHeader, mtLog_NetIP, mtLog_NetSubmask, mtLog_NetGateway, mtLog_NetDNS1, mtLog_NetDNS2, mtLog_NetDHCP, mtLog_CustInfoHeader, mtCallStack_Address, mtCallStack_Name, 
	mtCallStack_Unit, mtCallStack_Class, mtCallStack_Procedure, mtCallStack_Line, mtCallStack_MainThread, mtCallStack_ExceptionThread, mtCallStack_RunningThread, mtCallStack_CallingThread, mtCallStack_ThreadID, mtCallStack_ThreadPriority, mtCallStack_ThreadClass, mtCallStack_LeakCaption, mtCallStack_LeakData, mtCallStack_LeakType, mtCallStack_LeakSize, mtCallStack_LeakCount, mtSendDialog_Caption, mtSendDialog_Message, mtSendDialog_Resolving, mtSendDialog_Login, mtSendDialog_Connecting, mtSendDialog_Connected, mtSendDialog_Sending, mtSendDialog_Sent, mtSendDialog_SelectProject, mtSendDialog_Searching, mtSendDialog_Modifying, mtSendDialog_Disconnecting, mtSendDialog_Disconnected, mtReproduceDialog_Caption, mtReproduceDialog_Request, mtReproduceDialog_OKButtonCaption, mtModules_Handle, mtModules_Name, mtModules_Description, mtModules_Version, mtModules_Size, mtModules_LastModified, mtModules_Path, mtProcesses_ID, mtProcesses_Name, mtProcesses_Description, mtProcesses_Version, mtProcesses_Memory, mtProcesses_Priority, 
	mtProcesses_Threads, mtProcesses_Path, mtCPU_Registers, mtCPU_Stack, mtCPU_MemoryDump, mtSend_SuccessMsg, mtSend_FailureMsg, mtSend_BugClosedMsg, mtSend_UnknownErrorMsg, mtSend_InvalidLoginMsg, mtSend_InvalidSearchMsg, mtSend_InvalidSelectionMsg, mtSend_InvalidInsertMsg, mtSend_InvalidModifyMsg, mtFileCrackedMsg, mtException_LeakMultiFree, mtException_LeakMemoryOverrun, mtException_AntiFreeze, mtInvalidEmailMsg };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Etypes */
using namespace Etypes;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EtypesHPP
