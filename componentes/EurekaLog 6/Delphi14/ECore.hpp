// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ecore.pas' rev: 21.00

#ifndef EcoreHPP
#define EcoreHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Etypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ecore
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EIgnoreException;
class PASCALIMPLEMENTATION EIgnoreException : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EIgnoreException(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EIgnoreException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EIgnoreException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EIgnoreException(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EIgnoreException(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EIgnoreException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EIgnoreException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EIgnoreException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EIgnoreException(void) { }
	
};


typedef void __fastcall (*TProc)(void);

typedef Set<char, 0, 255>  TCharSet;

#pragma option push -b-
enum TForegroundType { ftGeneral, ftCallStack, ftModules, ftProcesses, ftAssembler, ftCPU };
#pragma option pop

#pragma option push -b-
enum TLoadType { ltLoadModuleOptions, ltLoadDefaultOptions };
#pragma option pop

typedef Set<Etypes::TShowOption, soAppStartDate, soCustomData>  TShowOptions;

typedef StaticArray<System::AnsiString, 158> TCustomizedTexts;

#pragma option push -b-
enum TLogOption { loNoDuplicateErrors, loAppendReproduceText, loDeleteLogAtVersionChange, loAddComputerNameInLogFileName, loSaveModulesAndProcessesSections, loSaveAssemblerAndCPUSections };
#pragma option pop

typedef Set<TLogOption, loNoDuplicateErrors, loSaveAssemblerAndCPUSections>  TLogOptions;

#pragma option push -b-
enum TCommonSendOption { sndShowSendDialog, sndShowSuccessFailureMsg, sndSendEntireLog, sndSendXMLLogCopy, sndSendScreenshot, sndUseOnlyActiveWindow, sndSendLastHTMLPage, sndSendInSeparatedThread, sndAddDateInFileName, sndAddComputerNameInFileName };
#pragma option pop

typedef Set<TCommonSendOption, sndShowSendDialog, sndAddComputerNameInFileName>  TCommonSendOptions;

#pragma option push -b-
enum TExceptionDialogType { edtNone, edtMessageBox, edtMSClassic, edtEurekaLog };
#pragma option pop

#pragma option push -b-
enum TExceptionDialogOption { edoSendErrorReportChecked, edoAttachScreenshotChecked, edoShowCopyToClipOption, edoShowDetailsButton, edoShowInDetailedMode, edoShowInTopMostMode, edoUseEurekaLogLookAndFeel, edoShowSendErrorReportOption, edoShowAttachScreenshotOption, edoShowCustomButton };
#pragma option pop

typedef Set<TExceptionDialogOption, edoSendErrorReportChecked, edoShowCustomButton>  TExceptionDialogOptions;

#pragma option push -b-
enum TCallStackOption { csoShowDLLs, csoShowBPLs, csoShowBorlandThreads, csoShowWindowsThreads, csoDoNotStoreProcNames };
#pragma option pop

typedef Set<TCallStackOption, csoShowDLLs, csoDoNotStoreProcNames>  TCallStackOptions;

#pragma option push -b-
enum TBehaviourOption { boPauseBorlandThreads, boDoNotPauseMainThread, boPauseWindowsThreads, boUseMainModuleOptions, boCopyLogInCaseOfError, boSaveCompressedCopyInCaseOfError, boHandleSafeCallExceptions, boCallRTLExceptionEvent, boCatchHandledExceptions };
#pragma option pop

typedef Set<TBehaviourOption, boPauseBorlandThreads, boCatchHandledExceptions>  TBehaviourOptions;

#pragma option push -b-
enum TLeaksOption { loCatchLeaks, loGroupsSonLeaks, loHideBorlandLeaks, loFreeAllLeaks, loCatchLeaksExceptions };
#pragma option pop

typedef Set<TLeaksOption, loCatchLeaks, loCatchLeaksExceptions>  TLeaksOptions;

#pragma option push -b-
enum TCompiledFileOption { cfoReduceFileSize, cfoCheckFileCorruption };
#pragma option pop

typedef Set<TCompiledFileOption, cfoReduceFileSize, cfoCheckFileCorruption>  TCompiledFileOptions;

#pragma option push -b-
enum TEmailSendMode { esmNoSend, esmEmailClient, esmSMTPClient, esmSMTPServer };
#pragma option pop

#pragma option push -b-
enum TWebSendMode { wsmNoSend, wsmHTTP, wsmHTTPS, wsmFTP, wsmBugZilla, wsmFogBugz, wsmMantis };
#pragma option pop

#pragma option push -b-
enum TModuleType { mtUnknown, mtProgram, mtPackage, mtLibrary };
#pragma option pop

#pragma option push -b-
enum TTerminateBtnOperation { tbNone, tbTerminate, tbRestart };
#pragma option pop

#pragma option push -b-
enum TFilterDialogType { fdtNone, fdtUnchanged, fdtMessageBox, fdtMSClassic, fdtEurekaLog };
#pragma option pop

#pragma option push -b-
enum TFilterHandlerType { fhtNone, fhtRTL, fhtEurekaLog };
#pragma option pop

#pragma option push -b-
enum TFilterActionType { fatNone, fatTerminate, fatRestart };
#pragma option pop

#pragma option push -b-
enum TFilterExceptionType { fetAll, fetHandled, fetUnhandled };
#pragma option pop

#pragma pack(push,1)
struct TEurekaExceptionFilter
{
	
public:
	bool Active;
	System::AnsiString ExceptionClassName;
	System::AnsiString ExceptionMessage;
	TFilterExceptionType ExceptionType;
	TFilterDialogType DialogType;
	TFilterHandlerType HandlerType;
	TFilterActionType ActionType;
};
#pragma pack(pop)


typedef TEurekaExceptionFilter *PEurekaExceptionFilter;

class DELPHICLASS TEurekaExceptionsFilters;
class DELPHICLASS TEurekaModuleOptions;
class PASCALIMPLEMENTATION TEurekaExceptionsFilters : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	PEurekaExceptionFilter operator[](int Index) { return Items[Index]; }
	
private:
	PEurekaExceptionFilter __fastcall GetItem(int Index);
	
protected:
	TEurekaModuleOptions* FOwner;
	
public:
	__fastcall TEurekaExceptionsFilters(const TEurekaModuleOptions* Owner);
	__fastcall virtual ~TEurekaExceptionsFilters(void);
	HIDESBASE int __fastcall Add(void * Item);
	HIDESBASE void __fastcall Insert(int Index, void * Item);
	HIDESBASE void __fastcall Assign(const TEurekaExceptionsFilters* Source);
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall Clear(void);
	__property PEurekaExceptionFilter Items[int Index] = {read=GetItem/*, default*/};
};


class PASCALIMPLEMENTATION TEurekaModuleOptions : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::AnsiString __fastcall GetCustomizedTexts(Etypes::TMessageType Index);
	void __fastcall SetCustomizedTexts(Etypes::TMessageType Index, System::AnsiString Value);
	
private:
	void __fastcall SetExceptionDialogType(const TExceptionDialogType Value);
	void __fastcall SetExceptionsFilters(const TEurekaExceptionsFilters* Value);
	void __fastcall SetErrorsNumberToSave(const int Value);
	void __fastcall SetModuleName(const System::AnsiString Value);
	void __fastcall SetModuleHandle(const unsigned Value);
	void __fastcall SetActivateHandle(const bool Value);
	void __fastcall SetActivateLog(const bool Value);
	void __fastcall SetAppendLogs(const bool Value);
	void __fastcall SetEMailAddresses(const System::AnsiString Value);
	void __fastcall SetEMailMessage(const System::AnsiString Value);
	void __fastcall SetEMailSendMode(const TEmailSendMode Value);
	void __fastcall SetEMailSubject(const System::AnsiString Value);
	void __fastcall SetErrorsNumberToShowTerminateBtn(const int Value);
	void __fastcall SetForegroundTab(const TForegroundType Value);
	void __fastcall SetFreezeTimeout(const int Value);
	void __fastcall SetLogOptions(const TLogOptions Value);
	void __fastcall SetOutputPath(const System::AnsiString Value);
	void __fastcall SetSaveLogFile(const bool Value);
	void __fastcall SetShowOptions(const TShowOptions &Value);
	void __fastcall SetSMTPFrom(const System::AnsiString Value);
	void __fastcall SetSMTPHost(const System::AnsiString Value);
	void __fastcall SetSMTPPassword(const System::AnsiString Value);
	void __fastcall SetSMTPPort(const System::Word Value);
	void __fastcall SetSMTPUserID(const System::AnsiString Value);
	void __fastcall SetTerminateBtnOperation(const TTerminateBtnOperation Value);
	void __fastcall SaveToSharedData(void);
	void __fastcall SetWebSendMode(const TWebSendMode Value);
	void __fastcall SetWebURL(const System::AnsiString Value);
	void __fastcall SetWebPassword(const System::AnsiString Value);
	void __fastcall SetWebPort(const int Value);
	void __fastcall SetWebUserID(const System::AnsiString Value);
	void __fastcall SetCommonSendOptions(const TCommonSendOptions Value);
	void __fastcall SetAttachedFiles(const System::AnsiString Value);
	void __fastcall SetExceptionDialogOptions(const TExceptionDialogOptions Value);
	void __fastcall SetAutoCloseDialogSecs(const int Value);
	void __fastcall SetAutoCrashMinutes(const int Value);
	void __fastcall SetAutoCrashNumber(const int Value);
	void __fastcall SetAutoCrashOperation(const TTerminateBtnOperation Value);
	void __fastcall SetHTMLLayout(const System::AnsiString Value);
	void __fastcall SetSupportURL(const System::AnsiString Value);
	void __fastcall SetBehaviourOptions(const TBehaviourOptions Value);
	void __fastcall SetCallStackOptions(const TCallStackOptions Value);
	void __fastcall SetCompiledFileOptions(const TCompiledFileOptions Value);
	void __fastcall SetPostFailureBuildEvent(const System::AnsiString Value);
	void __fastcall SetPostSuccessfulBuildEvent(const System::AnsiString Value);
	void __fastcall SetPreBuildEvent(const System::AnsiString Value);
	void __fastcall SetProxyPassword(const System::AnsiString Value);
	void __fastcall SetProxyPort(const System::Word Value);
	void __fastcall SetProxyURL(const System::AnsiString Value);
	void __fastcall SetProxyUserID(const System::AnsiString Value);
	void __fastcall SetTrakerAssignTo(const System::AnsiString Value);
	void __fastcall SetTrakerCategory(const System::AnsiString Value);
	void __fastcall SetTrakerPassword(const System::AnsiString Value);
	void __fastcall SetTrakerProject(const System::AnsiString Value);
	void __fastcall SetTrakerTrialID(const System::AnsiString Value);
	void __fastcall SetTrakerUserID(const System::AnsiString Value);
	void __fastcall SetZipPassword(const System::AnsiString Value);
	void __fastcall SetTextsCollection(const System::AnsiString Value);
	System::AnsiString __fastcall GetCustomizedExpandedTexts(Etypes::TMessageType Index);
	void __fastcall SetReproduceText(const System::AnsiString Value);
	
protected:
	int FSharedData;
	System::AnsiString FSMTPFrom;
	System::AnsiString FSMTPHost;
	System::AnsiString FSMTPUserID;
	System::AnsiString FSMTPPassword;
	System::Word FSMTPPort;
	System::AnsiString FProxyURL;
	System::AnsiString FProxyUserID;
	System::AnsiString FProxyPassword;
	System::Word FProxyPort;
	System::AnsiString FTrakerUserID;
	System::AnsiString FTrakerPassword;
	System::AnsiString FTrakerAssignTo;
	System::AnsiString FTrakerProject;
	System::AnsiString FTrakerCategory;
	System::AnsiString FTrakerTrialID;
	System::AnsiString FZipPassword;
	System::AnsiString FPreBuildEvent;
	System::AnsiString FPostSuccessfulBuildEvent;
	System::AnsiString FPostFailureBuildEvent;
	TCompiledFileOptions FCompiledFileOptions;
	TTerminateBtnOperation FTerminateBtnOperation;
	bool FFreezeActivate;
	int FFreezeTimeout;
	System::AnsiString FModuleName;
	unsigned FModuleHandle;
	TShowOptions FShowOptions;
	TExceptionDialogType FExceptionDialogType;
	TEurekaExceptionsFilters* FExceptionsFilters;
	TCustomizedTexts FCustomizedTexts;
	System::AnsiString FTextsCollection;
	bool FActivateLog;
	bool FActivateHandle;
	bool FAppendLogs;
	bool FSaveLogFile;
	TLogOptions FLogOptions;
	TCommonSendOptions FCommonSendOptions;
	TForegroundType FForegroundTab;
	int FErrorsNumberToSave;
	int FErrorsNumberToShowTerminateBtn;
	System::AnsiString FOutputPath;
	System::AnsiString FEMailAddresses;
	System::AnsiString FEMailSubject;
	System::AnsiString FEMailMessage;
	TEmailSendMode FEMailSendMode;
	TWebSendMode FWebSendMode;
	System::AnsiString FAttachedFiles;
	TExceptionDialogOptions FExceptionDialogOptions;
	int FAutoCloseDialogSecs;
	System::AnsiString FSupportURL;
	System::AnsiString FHTMLLayout;
	TTerminateBtnOperation FAutoCrashOperation;
	int FAutoCrashNumber;
	int FAutoCrashMinutes;
	TCallStackOptions FCallStackOptions;
	TBehaviourOptions FBehaviourOptions;
	TLeaksOptions FLeaksOptions;
	System::AnsiString FWebURL;
	int FWebPort;
	System::AnsiString FWebPassword;
	System::AnsiString FWebUserID;
	System::AnsiString FReproduceText;
	bool FActive;
	virtual void __fastcall SetActive(const bool Value);
	virtual void __fastcall SetFreezeActivate(const bool Value);
	void __fastcall DisableSharedDataWrite(void);
	void __fastcall EnableSharedDataWrite(void);
	__property System::AnsiString PreBuildEvent = {read=FPreBuildEvent, write=SetPreBuildEvent};
	__property System::AnsiString PostSuccessfulBuildEvent = {read=FPostSuccessfulBuildEvent, write=SetPostSuccessfulBuildEvent};
	__property System::AnsiString PostFailureBuildEvent = {read=FPostFailureBuildEvent, write=SetPostFailureBuildEvent};
	
public:
	__fastcall TEurekaModuleOptions(System::AnsiString AModuleName);
	__fastcall virtual ~TEurekaModuleOptions(void);
	virtual void __fastcall Assign(TEurekaModuleOptions* Source);
	virtual void __fastcall SetToDefaultOptions(void);
	virtual void __fastcall SaveToStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToFile(const System::AnsiString Filename);
	virtual void __fastcall LoadFromStream(Classes::TStream* Stream);
	virtual void __fastcall LoadFromFile(const System::AnsiString FileName);
	System::AnsiString __fastcall OutputFile(System::AnsiString FileName);
	System::AnsiString __fastcall OutputLogFile(System::AnsiString BaseFile);
	void __fastcall SaveCustomizedTextsToFile(const System::AnsiString FileName);
	void __fastcall LoadCustomizedTextsFromFile(const System::AnsiString FileName);
	virtual void __fastcall StoreSharedData(void);
	virtual void __fastcall LoadSharedData(void);
	__property System::AnsiString ModuleName = {read=FModuleName, write=SetModuleName};
	__property unsigned ModuleHandle = {read=FModuleHandle, write=SetModuleHandle, nodefault};
	__property System::AnsiString SMTPFrom = {read=FSMTPFrom, write=SetSMTPFrom};
	__property System::AnsiString SMTPHost = {read=FSMTPHost, write=SetSMTPHost};
	__property System::Word SMTPPort = {read=FSMTPPort, write=SetSMTPPort, nodefault};
	__property System::AnsiString SMTPUserID = {read=FSMTPUserID, write=SetSMTPUserID};
	__property System::AnsiString SMTPPassword = {read=FSMTPPassword, write=SetSMTPPassword};
	__property bool FreezeActivate = {read=FFreezeActivate, write=SetFreezeActivate, nodefault};
	__property int FreezeTimeout = {read=FFreezeTimeout, write=SetFreezeTimeout, nodefault};
	__property TEurekaExceptionsFilters* ExceptionsFilters = {read=FExceptionsFilters, write=SetExceptionsFilters};
	__property System::AnsiString CustomizedTexts[Etypes::TMessageType Index] = {read=GetCustomizedTexts, write=SetCustomizedTexts};
	__property System::AnsiString TextsCollection = {read=FTextsCollection, write=SetTextsCollection};
	__property bool ActivateLog = {read=FActivateLog, write=SetActivateLog, nodefault};
	__property bool SaveLogFile = {read=FSaveLogFile, write=SetSaveLogFile, nodefault};
	__property bool ActivateHandle = {read=FActivateHandle, write=SetActivateHandle, nodefault};
	__property TForegroundType ForegroundTab = {read=FForegroundTab, write=SetForegroundTab, nodefault};
	__property bool AppendLogs = {read=FAppendLogs, write=SetAppendLogs, nodefault};
	__property TTerminateBtnOperation TerminateBtnOperation = {read=FTerminateBtnOperation, write=SetTerminateBtnOperation, nodefault};
	__property TLogOptions LogOptions = {read=FLogOptions, write=SetLogOptions, nodefault};
	__property TShowOptions ShowOptions = {read=FShowOptions, write=SetShowOptions};
	__property int ErrorsNumberToSave = {read=FErrorsNumberToSave, write=SetErrorsNumberToSave, nodefault};
	__property int ErrorsNumberToShowTerminateBtn = {read=FErrorsNumberToShowTerminateBtn, write=SetErrorsNumberToShowTerminateBtn, nodefault};
	__property System::AnsiString OutputPath = {read=FOutputPath, write=SetOutputPath};
	__property System::AnsiString EMailAddresses = {read=FEMailAddresses, write=SetEMailAddresses};
	__property System::AnsiString EMailSubject = {read=FEMailSubject, write=SetEMailSubject};
	__property System::AnsiString EMailMessage = {read=FEMailMessage, write=SetEMailMessage};
	__property TEmailSendMode EMailSendMode = {read=FEMailSendMode, write=SetEMailSendMode, nodefault};
	__property TWebSendMode WebSendMode = {read=FWebSendMode, write=SetWebSendMode, nodefault};
	__property System::AnsiString WebURL = {read=FWebURL, write=SetWebURL};
	__property System::AnsiString WebUserID = {read=FWebUserID, write=SetWebUserID};
	__property System::AnsiString WebPassword = {read=FWebPassword, write=SetWebPassword};
	__property int WebPort = {read=FWebPort, write=SetWebPort, nodefault};
	__property TCommonSendOptions CommonSendOptions = {read=FCommonSendOptions, write=SetCommonSendOptions, nodefault};
	__property System::AnsiString AttachedFiles = {read=FAttachedFiles, write=SetAttachedFiles};
	__property TExceptionDialogType ExceptionDialogType = {read=FExceptionDialogType, write=SetExceptionDialogType, nodefault};
	__property TExceptionDialogOptions ExceptionDialogOptions = {read=FExceptionDialogOptions, write=SetExceptionDialogOptions, nodefault};
	__property int AutoCloseDialogSecs = {read=FAutoCloseDialogSecs, write=SetAutoCloseDialogSecs, nodefault};
	__property System::AnsiString SupportURL = {read=FSupportURL, write=SetSupportURL};
	__property System::AnsiString HTMLLayout = {read=FHTMLLayout, write=SetHTMLLayout};
	__property TTerminateBtnOperation AutoCrashOperation = {read=FAutoCrashOperation, write=SetAutoCrashOperation, nodefault};
	__property int AutoCrashNumber = {read=FAutoCrashNumber, write=SetAutoCrashNumber, nodefault};
	__property int AutoCrashMinutes = {read=FAutoCrashMinutes, write=SetAutoCrashMinutes, nodefault};
	__property TCallStackOptions CallStackOptions = {read=FCallStackOptions, write=SetCallStackOptions, nodefault};
	__property TBehaviourOptions BehaviourOptions = {read=FBehaviourOptions, write=SetBehaviourOptions, nodefault};
	__property TLeaksOptions LeaksOptions = {read=FLeaksOptions, nodefault};
	__property System::AnsiString ProxyURL = {read=FProxyURL, write=SetProxyURL};
	__property System::AnsiString ProxyUserID = {read=FProxyUserID, write=SetProxyUserID};
	__property System::AnsiString ProxyPassword = {read=FProxyPassword, write=SetProxyPassword};
	__property System::Word ProxyPort = {read=FProxyPort, write=SetProxyPort, nodefault};
	__property System::AnsiString TrakerUserID = {read=FTrakerUserID, write=SetTrakerUserID};
	__property System::AnsiString TrakerPassword = {read=FTrakerPassword, write=SetTrakerPassword};
	__property System::AnsiString TrakerAssignTo = {read=FTrakerAssignTo, write=SetTrakerAssignTo};
	__property System::AnsiString TrakerProject = {read=FTrakerProject, write=SetTrakerProject};
	__property System::AnsiString TrakerCategory = {read=FTrakerCategory, write=SetTrakerCategory};
	__property System::AnsiString TrakerTrialID = {read=FTrakerTrialID, write=SetTrakerTrialID};
	__property System::AnsiString ZipPassword = {read=FZipPassword, write=SetZipPassword};
	__property TCompiledFileOptions CompiledFileOptions = {read=FCompiledFileOptions, write=SetCompiledFileOptions, nodefault};
	__property System::AnsiString ReproduceText = {read=FReproduceText, write=SetReproduceText};
	__property System::AnsiString CustomizedExpandedTexts[Etypes::TMessageType Index] = {read=GetCustomizedExpandedTexts};
	__property bool Active = {read=FActive, write=SetActive, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
#define _CompanyName L"CodeGear"
static const WideChar _BDSVer = (WideChar)(0x37);
#define _LanguageVer L"14"
#define RADVersionString L"7.0"
#define Real_RADVersionString L"14.0"
#define VCL L"VCL140.BPL"
#define CLX L""
#define INDY1 L"INDY140.BPL"
#define INDY2 L"INDYCORE140.BPL"
#define IniAppendLine L""
#define CreateFileA_Module L"RTL140.BPL"
#define LoadLibraryExA_Module L"COREIDE140.BPL"
#define RADRegKeyName L"BDS"
#define RADExeName L"BDS.EXE"
#define DEFINEDirName L"BDS"
#define DefaultSourceExt L".pas"
#define InstallDirName L"Delphi"
#define VCL_Const L"Forms.TApplication.HandleException"
#define VCL_Const2 L"Forms.TApplication.ShowException"
#define CLX_Const L"QForms.TApplication.HandleException"
#define CLX_Const2 L"QForms.TApplication.ShowException"
#define ISAPI_Const L"ISAPIApp.TISAPIApplication.ISAPIHandleException"
#define CGI_Const L"CGIApp.TCGIApplication.CGIHandleException"
#define IWebSrv_Const L"IWServerControllerBase.TIWServerControllerBase.Create"
#define IWebApp_Const L"IWApplication.TIWApplication.ShowMessage"
#define IWebRes_Const L"InHTTPWebBrokerBridge.TInHTTPAppResponse.SendResponse"
#define NTService_Const L"SvcMgr.TService.LogMessage"
#define IndyThread_Const L"IdThread.TIdThread.DoException"
#define ClassesInit_Const L"Classes.Classes"
#define ClassesFInit_Const L"Classes.Finalization"
#define VariantsFInit_Const L"Variants.Finalization"
#define SysUtilsInit_Const L"SysUtils.SysUtils"
#define SysUtilsFInit_Const L"SysUtils.Finalization"
#define SystemFInit_Const L"System.Finalization"
#define ELeaksFInit_Const L"ELeaks.Finalization"
#define ExceptionLogFInit_Const L"ExceptionLog.Finalization"
#define FastMM4FInit_Const L"FastMM4.Finalization"
static const ShortInt VCL1_ID = 0x0;
static const ShortInt VCL2_ID = 0x1;
static const ShortInt CLX1_ID = 0x2;
static const ShortInt CLX2_ID = 0x3;
static const ShortInt ISAPI_ID = 0x4;
static const ShortInt CGI_ID = 0x5;
static const ShortInt IWebSrv_ID = 0x6;
static const ShortInt IWebApp_ID = 0x7;
static const ShortInt IWebRes_ID = 0x8;
static const ShortInt NTService_ID = 0x9;
static const ShortInt IndyThread_ID = 0xa;
static const ShortInt ClassesInit_ID = 0xb;
static const ShortInt ClassesFInit_ID = 0xc;
static const ShortInt VariantsFInit_ID = 0xd;
static const ShortInt SysUtilsInit_ID = 0xe;
static const ShortInt SysUtilsFInit_ID = 0xf;
static const ShortInt SystemFInit_ID = 0x10;
static const ShortInt ELeaksFInit_ID = 0x11;
static const ShortInt ExceptionLogFInit_ID = 0x12;
static const ShortInt FastMM4FInit_ID = 0x13;
static const ShortInt SymbolsCount = 0x14;
#define RT_RCDATA (char *)(0xa)
extern PACKAGE System::Word LastEurekaVersion;
extern PACKAGE void __fastcall (*CriticalError)(const System::AnsiString Section);
extern PACKAGE bool __fastcall IsGreaterVersion(System::AnsiString MinorVer, System::AnsiString MajorVer);
extern PACKAGE System::AnsiString __fastcall Real_GetMainModuleFileName(void);
extern PACKAGE void __fastcall ExtractList(System::AnsiString Source, Classes::TStrings* List, const TCharSet &Separators, bool IncludeEmpty, bool IncludeSeparator);
extern PACKAGE System::AnsiString __fastcall StringToUtf8(const System::AnsiString S);
extern PACKAGE System::AnsiString __fastcall GetEnvVariable(const System::AnsiString Name);
extern PACKAGE System::AnsiString __fastcall ExpandEnvVars(const System::AnsiString Source);
extern PACKAGE System::AnsiString __fastcall DotNetHostedFile(const System::AnsiString FileName);
extern PACKAGE System::AnsiString __fastcall ReadString(System::AnsiString FileName, const System::AnsiString Section, const System::AnsiString Ident, const System::AnsiString Default);
extern PACKAGE int __fastcall ReadInteger(System::AnsiString FileName, const System::AnsiString Section, const System::AnsiString Ident, int Default);
extern PACKAGE bool __fastcall ReadBool(System::AnsiString FileName, const System::AnsiString Section, const System::AnsiString Ident, bool Default);
extern PACKAGE void __fastcall WriteString(System::AnsiString FileName, const System::AnsiString Section, const System::AnsiString Ident, const System::AnsiString Value);
extern PACKAGE void __fastcall WriteInteger(System::AnsiString FileName, const System::AnsiString Section, const System::AnsiString Ident, int Value);
extern PACKAGE void __fastcall WriteBool(System::AnsiString FileName, const System::AnsiString Section, const System::AnsiString Ident, bool Value);
extern PACKAGE System::AnsiString __fastcall OneString(const System::AnsiString s);
extern PACKAGE bool __fastcall SupportsEx(const System::_di_IInterface Instance, const GUID &Intf, /* out */ void *Inst);
extern PACKAGE bool __fastcall IsValidBlockAddr(unsigned Address, unsigned Size);
extern PACKAGE unsigned __fastcall ConvertAddress(unsigned Addr);
extern PACKAGE System::TDateTime __fastcall GetModifiedDate(System::AnsiString sFileName);
extern PACKAGE System::AnsiString __fastcall GetLongNameFromShort(System::AnsiString Path);
extern PACKAGE int __fastcall PosEx(const System::AnsiString SubStr, const System::AnsiString S, int Idx);
extern PACKAGE System::AnsiString __fastcall QuickStringReplace(const System::AnsiString S, const System::AnsiString OldPattern, const System::AnsiString NewPattern);
extern PACKAGE void __fastcall ExtractStringsEx(const TCharSet &Separators, System::AnsiString Content, Classes::TStrings* Strings);
extern PACKAGE System::AnsiString __fastcall ReadKey(HKEY Root, System::AnsiString Key, System::AnsiString Str);
extern PACKAGE bool __fastcall CheckKey(HKEY Root, System::AnsiString Key);
extern PACKAGE System::AnsiString __fastcall RADRegistryKey(void);
extern PACKAGE System::AnsiString __fastcall RADDir(void);
extern PACKAGE int __fastcall GetGMT(void);
extern PACKAGE System::TDateTime __fastcall GetGMTDateTime(System::TDateTime DateTime);
extern PACKAGE System::AnsiString __fastcall GetEurekaLogLabel(void);
extern PACKAGE bool __fastcall IntoIDE(void);
extern PACKAGE System::AnsiString __fastcall IncludeLastBackslash(System::AnsiString Source);
extern PACKAGE System::AnsiString __fastcall ExcludeLastBackslash(const System::AnsiString S);
extern PACKAGE bool __fastcall ForceDirectoriesEx(System::AnsiString Dir);
extern PACKAGE bool __fastcall IsWritableFile(const System::AnsiString FileName);
extern PACKAGE bool __fastcall IsReadableFile(const System::AnsiString FileName);
extern PACKAGE bool __fastcall GetWorkingFile(System::AnsiString &FileName, bool ProjectDir, bool ReadOnly);
extern PACKAGE bool __fastcall GetWorkingDir(System::AnsiString &DirName, bool ProjectDir, bool ReadOnly);
extern PACKAGE void __fastcall ReadRawStrings(const System::AnsiString Cnf, System::AnsiString Section, System::AnsiString CountName, System::AnsiString Prefix, System::AnsiString Default, System::AnsiString &Value);
extern PACKAGE void __fastcall WriteRawStrings(System::AnsiString Cnf, System::AnsiString Section, System::AnsiString CountName, System::AnsiString Prefix, System::AnsiString Value);
extern PACKAGE void __fastcall SafeExec(TProc Proc, System::AnsiString Section);

}	/* namespace Ecore */
using namespace Ecore;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EcoreHPP
