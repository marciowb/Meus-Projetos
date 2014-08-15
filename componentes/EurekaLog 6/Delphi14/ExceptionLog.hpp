// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Exceptionlog.pas' rev: 21.00

#ifndef ExceptionlogHPP
#define ExceptionlogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Eleaks.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Ecore.hpp>	// Pascal unit
#include <Edebug.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Exceptionlog
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TEurekaDebugDetail { ddNone, ddModule, ddProcedure, ddUnitAndProcedure, ddSourceCode };
#pragma option pop

typedef Set<TEurekaDebugDetail, ddNone, ddSourceCode>  TEurekaDebugDetails;

#pragma option push -b-
enum TEurekaModuleType { mtUnknown, mtMainModule, mtBorlandPackage, mtOSLibrary };
#pragma option pop

#pragma pack(push,1)
struct TEurekaExtraInformation
{
	
public:
	System::Word EurekaVersion;
	System::TDateTime CompilationDate;
	Ecore::TEurekaModuleOptions* Options;
	Classes::TMemoryStream* DebugInformation;
};
#pragma pack(pop)


class DELPHICLASS TEurekaFunctionsList;
#pragma pack(push,1)
struct TEurekaModuleInfo
{
	
public:
	unsigned Handle;
	System::AnsiString Name;
	System::AnsiString Description;
	System::AnsiString Version;
	unsigned Size;
	TEurekaFunctionsList* FunctionsList;
	TEurekaModuleType ModuleType;
	TEurekaExtraInformation ExtraInformation;
	Edebug::TELDebugInfoSource* OtherDebugData;
	System::TDateTime LastModified;
	System::AnsiString EncryptPassword;
	bool IsValidEncryptPassword;
};
#pragma pack(pop)


typedef TEurekaModuleInfo *PEurekaModuleInfo;

#pragma pack(push,1)
struct TEurekaProcessInfo
{
	
public:
	unsigned ProcessID;
	System::AnsiString Name;
	System::AnsiString Description;
	System::AnsiString Version;
	unsigned Priority;
	unsigned Memory;
	unsigned Threads;
};
#pragma pack(pop)


typedef TEurekaProcessInfo *PEurekaProcessInfo;

typedef int __fastcall (*TBeginThreadFunc)(void * Parameter);

typedef int __stdcall (*TCreateThreadFunc)(void * Parameter);

#pragma pack(push,1)
struct TEurekaThreadInfo
{
	
public:
	unsigned ID;
	unsigned Handle;
	unsigned CallerID;
	int Priority;
	Classes::TThread* Thread;
	unsigned TopOfStack;
	void __fastcall (*ExecuteMethod)(Classes::TThread* Thread);
	TBeginThreadFunc BeginThreadFunction;
	TCreateThreadFunc CreateThreadFunction;
	void *Parameter;
	unsigned CallerStackSize;
	void *CallerStackDump;
	bool IsACopy;
};
#pragma pack(pop)


typedef TEurekaThreadInfo *PEurekaThreadInfo;

#pragma pack(push,1)
struct TEurekaDebugInfo
{
	
public:
	TEurekaDebugDetail DebugDetail;
	TEurekaModuleInfo *ModuleInfo;
	unsigned ThreadID;
	bool RunningThread;
	bool ErrorLine;
	bool IsALeak;
	SmallString<64>  LeakType;
	unsigned LeakSize;
	unsigned LeakCount;
	unsigned Addr;
	System::ShortString UnitName;
	System::ShortString ClassName;
	System::ShortString ProcedureName;
	unsigned Line;
	unsigned ProcOffsetLine;
	System::ShortString CustomMsg;
};
#pragma pack(pop)


typedef TEurekaDebugInfo *PEurekaDebugInfo;

#pragma pack(push,1)
struct TEurekaFunctionInfo
{
	
public:
	System::AnsiString Name;
	unsigned Addr;
	unsigned Size;
};
#pragma pack(pop)


typedef TEurekaFunctionInfo *PEurekaFunctionInfo;

class DELPHICLASS TEurekaStackList;
class PASCALIMPLEMENTATION TEurekaStackList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	PEurekaDebugInfo operator[](int Index) { return Items[Index]; }
	
private:
	PEurekaDebugInfo __fastcall GetItem(int Index);
	
public:
	__fastcall virtual ~TEurekaStackList(void);
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall Clear(void);
	void __fastcall AddFrom(PEurekaDebugInfo Source);
	__property PEurekaDebugInfo Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TObject.Create */ inline __fastcall TEurekaStackList(void) : Classes::TList() { }
	
};


class DELPHICLASS TEurekaModulesList;
class PASCALIMPLEMENTATION TEurekaModulesList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	PEurekaModuleInfo operator[](int Index) { return Items[Index]; }
	
private:
	PEurekaModuleInfo __fastcall GetItem(int Index);
	
public:
	__fastcall virtual ~TEurekaModulesList(void);
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall Clear(void);
	__property PEurekaModuleInfo Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TObject.Create */ inline __fastcall TEurekaModulesList(void) : Classes::TList() { }
	
};


class DELPHICLASS TEurekaProcessesList;
class PASCALIMPLEMENTATION TEurekaProcessesList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	PEurekaProcessInfo operator[](int Index) { return Items[Index]; }
	
private:
	PEurekaProcessInfo __fastcall GetItem(int Index);
	
public:
	__fastcall virtual ~TEurekaProcessesList(void);
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall Clear(void);
	__property PEurekaProcessInfo Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TObject.Create */ inline __fastcall TEurekaProcessesList(void) : Classes::TList() { }
	
};


class PASCALIMPLEMENTATION TEurekaFunctionsList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	PEurekaFunctionInfo operator[](int Index) { return Items[Index]; }
	
private:
	PEurekaFunctionInfo __fastcall GetItem(int Index);
	
public:
	__fastcall virtual ~TEurekaFunctionsList(void);
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall Clear(void);
	__property PEurekaFunctionInfo Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TObject.Create */ inline __fastcall TEurekaFunctionsList(void) : Classes::TList() { }
	
};


#pragma pack(push,1)
struct TEurekaExceptionRecord
{
	
public:
	System::TObject* ExceptionObject;
	void *ExceptionAddress;
	unsigned ExceptionThreadID;
	Sysutils::TExceptionRecord *Win32ExceptionRecord;
	_CONTEXT *Win32Context;
	System::AnsiString LogText;
	TEurekaModulesList* ModulesList;
	TEurekaStackList* CallStack;
	Ecore::TEurekaModuleOptions* CurrentModuleOptions;
};
#pragma pack(pop)


#pragma pack(push,1)
struct TModuleInfo
{
	
public:
	unsigned dwSize;
	unsigned th32ModuleID;
	unsigned th32ProcessID;
	unsigned GlblcntUsage;
	unsigned ProccntUsage;
	unsigned modBaseAddr;
	unsigned modBaseSize;
	unsigned hModule;
	StaticArray<char, 256> szModule;
	StaticArray<char, 260> szExePath;
};
#pragma pack(pop)


typedef void __fastcall (*TExceptionNotifyProc)(const TEurekaExceptionRecord &EurekaExceptionRecord, bool &Handled);

#pragma option push -b-
enum TEurekaActionType { atShowingExceptionInfo, atShowedExceptionInfo, atSavingLogFile, atSavedLogFile, atSendingEmail, atSentEmail, atSendingWebMessage, atSentWebMessage, atTerminating };
#pragma option pop

typedef void __fastcall (*TExceptionActionProc)(const TEurekaExceptionRecord &EurekaExceptionRecord, TEurekaActionType EurekaAction, bool &Execute);

typedef void __fastcall (*TExceptionErrorProc)(const TEurekaExceptionRecord &EurekaExceptionRecord, TEurekaActionType EurekaAction, bool &Retry);

typedef void __fastcall (*TPasswordRequestProc)(const TEurekaExceptionRecord &EurekaExceptionRecord, System::AnsiString &Password);

typedef void __fastcall (*TCustomDataRequestProc)(const TEurekaExceptionRecord &EurekaExceptionRecord, Classes::TStrings* DataFields);

typedef void __fastcall (*TAttachedFilesRequestProc)(const TEurekaExceptionRecord &EurekaExceptionRecord, Classes::TStrings* AttachedFiles);

typedef void __fastcall (*TCustomWebFieldsRequestProc)(const TEurekaExceptionRecord &EurekaExceptionRecord, Classes::TStrings* WebFields);

typedef void __fastcall (*TCustomButtonClickProc)(const TEurekaExceptionRecord &EurekaExceptionRecord, bool &CloseDialog);

class DELPHICLASS EFrozenApplication;
class PASCALIMPLEMENTATION EFrozenApplication : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EFrozenApplication(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EFrozenApplication(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EFrozenApplication(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EFrozenApplication(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EFrozenApplication(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EFrozenApplication(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EFrozenApplication(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EFrozenApplication(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EFrozenApplication(void) { }
	
};


class DELPHICLASS EMemoryLeak;
class PASCALIMPLEMENTATION EMemoryLeak : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EMemoryLeak(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EMemoryLeak(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EMemoryLeak(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EMemoryLeak(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EMemoryLeak(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EMemoryLeak(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EMemoryLeak(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EMemoryLeak(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EMemoryLeak(void) { }
	
};


class DELPHICLASS EMemoryOverrun;
class PASCALIMPLEMENTATION EMemoryOverrun : public EMemoryLeak
{
	typedef EMemoryLeak inherited;
	
public:
	/* Exception.Create */ inline __fastcall EMemoryOverrun(const System::UnicodeString Msg) : EMemoryLeak(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EMemoryOverrun(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : EMemoryLeak(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EMemoryOverrun(int Ident)/* overload */ : EMemoryLeak(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EMemoryOverrun(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : EMemoryLeak(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EMemoryOverrun(const System::UnicodeString Msg, int AHelpContext) : EMemoryLeak(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EMemoryOverrun(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : EMemoryLeak(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EMemoryOverrun(int Ident, int AHelpContext)/* overload */ : EMemoryLeak(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EMemoryOverrun(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : EMemoryLeak(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EMemoryOverrun(void) { }
	
};


class DELPHICLASS EMultiFree;
class PASCALIMPLEMENTATION EMultiFree : public EMemoryLeak
{
	typedef EMemoryLeak inherited;
	
public:
	/* Exception.Create */ inline __fastcall EMultiFree(const System::UnicodeString Msg) : EMemoryLeak(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EMultiFree(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : EMemoryLeak(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EMultiFree(int Ident)/* overload */ : EMemoryLeak(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EMultiFree(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : EMemoryLeak(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EMultiFree(const System::UnicodeString Msg, int AHelpContext) : EMemoryLeak(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EMultiFree(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : EMemoryLeak(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EMultiFree(int Ident, int AHelpContext)/* overload */ : EMemoryLeak(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EMultiFree(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : EMemoryLeak(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EMultiFree(void) { }
	
};


class DELPHICLASS EEurekaLogGeneralError;
class PASCALIMPLEMENTATION EEurekaLogGeneralError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EEurekaLogGeneralError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EEurekaLogGeneralError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EEurekaLogGeneralError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EEurekaLogGeneralError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EEurekaLogGeneralError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EEurekaLogGeneralError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EEurekaLogGeneralError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EEurekaLogGeneralError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EEurekaLogGeneralError(void) { }
	
};


#pragma option push -b-
enum TEurekaLogErrorCode { eeNone, eeShowError, eeLogError, eeEmailMAPIError, eeEmailShellError, eeEmailSMTPError, eeWebHTTPError, eeWebHTTPSError, eeWebFTPError, eeWebTrakerError };
#pragma option pop

typedef void __fastcall (__closure *TExceptionNotify)(const TEurekaExceptionRecord &EurekaExceptionRecord, bool &Handled);

typedef void __fastcall (__closure *TExceptionActionNotify)(const TEurekaExceptionRecord &EurekaExceptionRecord, TEurekaActionType EurekaAction, bool &Execute);

typedef void __fastcall (__closure *TExceptionErrorNotify)(const TEurekaExceptionRecord &EurekaExceptionRecord, TEurekaActionType EurekaAction, bool &Retry);

typedef void __fastcall (__closure *TPasswordRequestNotify)(const TEurekaExceptionRecord &EurekaExceptionRecord, System::AnsiString &Password);

typedef void __fastcall (__closure *TCustomDataRequestNotify)(const TEurekaExceptionRecord &EurekaExceptionRecord, Classes::TStrings* DataFields);

typedef void __fastcall (__closure *TAttachedFilesRequestNotify)(const TEurekaExceptionRecord &EurekaExceptionRecord, Classes::TStrings* AttachedFiles);

typedef void __fastcall (__closure *TCustomWebFieldsRequestNotify)(const TEurekaExceptionRecord &EurekaExceptionRecord, Classes::TStrings* WebFields);

typedef void __fastcall (__closure *TCustomButtonClickNotify)(const TEurekaExceptionRecord &EurekaExceptionRecord, bool &CloseDialog);

class DELPHICLASS TEurekaLog;
class PASCALIMPLEMENTATION TEurekaLog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TExceptionNotify FExceptionNotify;
	TExceptionNotify FHandledExceptionNotify;
	TExceptionActionNotify FExceptionActionNotify;
	TExceptionErrorNotify FExceptionErrorNotify;
	TPasswordRequestNotify FPasswordRequest;
	TCustomDataRequestNotify FCustomDataRequest;
	TAttachedFilesRequestNotify FAttachedFilesRequest;
	TCustomWebFieldsRequestNotify FCustomWebFieldsRequest;
	TCustomButtonClickNotify FCustomButtonClickNotify;
	
public:
	__fastcall virtual TEurekaLog(Classes::TComponent* AOwner);
	__fastcall virtual ~TEurekaLog(void);
	
__published:
	__property TExceptionNotify OnExceptionNotify = {read=FExceptionNotify, write=FExceptionNotify};
	__property TExceptionNotify OnHandledExceptionNotify = {read=FHandledExceptionNotify, write=FHandledExceptionNotify};
	__property TExceptionActionNotify OnExceptionActionNotify = {read=FExceptionActionNotify, write=FExceptionActionNotify};
	__property TExceptionErrorNotify OnExceptionErrorNotify = {read=FExceptionErrorNotify, write=FExceptionErrorNotify};
	__property TPasswordRequestNotify OnPasswordRequest = {read=FPasswordRequest, write=FPasswordRequest};
	__property TCustomDataRequestNotify OnCustomDataRequest = {read=FCustomDataRequest, write=FCustomDataRequest};
	__property TAttachedFilesRequestNotify OnAttachedFilesRequest = {read=FAttachedFilesRequest, write=FAttachedFilesRequest};
	__property TCustomWebFieldsRequestNotify OnCustomWebFieldsRequest = {read=FCustomWebFieldsRequest, write=FCustomWebFieldsRequest};
	__property TCustomButtonClickNotify OnCustomButtonClickNotify = {read=FCustomButtonClickNotify, write=FCustomButtonClickNotify};
};


class DELPHICLASS EurekaLogNotPresents;
class PASCALIMPLEMENTATION EurekaLogNotPresents : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EurekaLogNotPresents(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EurekaLogNotPresents(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EurekaLogNotPresents(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EurekaLogNotPresents(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EurekaLogNotPresents(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EurekaLogNotPresents(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EurekaLogNotPresents(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EurekaLogNotPresents(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EurekaLogNotPresents(void) { }
	
};


typedef unsigned *PCardinal;

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
static const Byte MAX_MODULE_NAME32 = 0xff;
extern PACKAGE TExceptionNotifyProc ExceptionNotify;
extern PACKAGE TExceptionNotifyProc HandledExceptionNotify;
extern PACKAGE TExceptionActionProc ExceptionActionNotify;
extern PACKAGE TExceptionErrorProc ExceptionErrorNotify;
extern PACKAGE TPasswordRequestProc PasswordRequest;
extern PACKAGE TCustomDataRequestProc CustomDataRequest;
extern PACKAGE TAttachedFilesRequestProc AttachedFilesRequest;
extern PACKAGE TCustomWebFieldsRequestProc CustomWebFieldsRequest;
extern PACKAGE TCustomButtonClickProc CustomButtonClickNotify;
extern PACKAGE bool ShowEurekaLogUnits;
extern PACKAGE bool CallFromCOMObject;
extern PACKAGE bool CallForGetLogText;
extern PACKAGE bool ShowInternalSendErrors;
extern PACKAGE System::AnsiString __fastcall GenerateHTML(const System::AnsiString Text, bool AddOKButton);
extern PACKAGE bool __fastcall GetSourceInfoByAddr(unsigned Addr, PEurekaDebugInfo DebugInfo);
extern PACKAGE void * __fastcall GetLastExceptionAddress(void);
extern PACKAGE System::TObject* __fastcall GetLastExceptionObject(void);
extern PACKAGE bool __fastcall IsEurekaLogModule(unsigned HModule);
extern PACKAGE System::Word __fastcall GetEurekaLogModuleVersion(unsigned HModule);
extern PACKAGE void __fastcall SetCustomErrorMessage(const System::AnsiString Value);
extern PACKAGE void __fastcall SaveScreenshot(const System::AnsiString Filename);
extern PACKAGE void __fastcall SaveScreenshotToStream(Classes::TStream* Stream);
extern PACKAGE bool __fastcall EurekaLogSendEmail(const System::AnsiString AMailTo, const System::AnsiString ASubject, const System::AnsiString ABody, const System::AnsiString AAttachments);
extern PACKAGE void __fastcall HookedRaise(void);
extern PACKAGE void __fastcall HookedRtlUnwind(void);
extern PACKAGE int __stdcall HookedWriteFile(int hFile, const void *Buffer, unsigned nNumberOfBytesToWrite, unsigned &lpNumberOfBytesWritten, void * lpOverlapped);
extern PACKAGE unsigned __stdcall HookedCreateThread(void * lpThreadAttributes, unsigned dwStackSize, void * lpStartAddress, void * lpParameter, unsigned dwCreationFlags, PDWORD lpThreadId);
extern PACKAGE unsigned __stdcall HookedResumeThread(unsigned hThread);
extern PACKAGE void __stdcall HookedExitThread(unsigned dwExitCode);
extern PACKAGE bool __fastcall IsEurekaLogInstalled(void);
extern PACKAGE Ecore::TEurekaModuleOptions* __fastcall CurrentEurekaLogOptions(void);
extern PACKAGE Ecore::TEurekaModuleOptions* __fastcall DotNetEurekaLogOptions(void);
extern PACKAGE bool __fastcall StandardEurekaNotify(System::TObject* Obj, void * Addr);
extern PACKAGE void __fastcall ShowLastExceptionData(void);
extern PACKAGE bool __fastcall StandardEurekaError(const System::AnsiString Error);
extern PACKAGE System::AnsiString __fastcall GetEurekaLogHTML(System::AnsiString ExceptionType, System::AnsiString ExceptionMessage, System::AnsiString CallStack);
extern PACKAGE void __fastcall SetMetadataFilePath(const System::AnsiString FileName);
extern PACKAGE bool __fastcall ForceApplicationTermination(Ecore::TTerminateBtnOperation TrmType);
extern PACKAGE TEurekaLogErrorCode __fastcall GetLastEurekaLogErrorCode(void);
extern PACKAGE System::AnsiString __fastcall GetLastEurekaLogErrorMsg(void);
extern PACKAGE TEurekaStackList* __fastcall GetCurrentCallStack(void);
extern PACKAGE TEurekaStackList* __fastcall GetLastExceptionCallStack(void);
extern PACKAGE TEurekaStackList* __fastcall GetCallStackByLevels(int StartLevel, int LevelsNumber);
extern PACKAGE void __fastcall CallStackToStrings(TEurekaStackList* CallStack, Classes::TStrings* Strings);
extern PACKAGE bool __fastcall IsEurekaLogActiveInThread(unsigned ThreadID);
extern PACKAGE void __fastcall SetEurekaLogInThread(unsigned ThreadID, bool Activate);
extern PACKAGE void __fastcall SetEurekaLogState(bool Activate);
extern PACKAGE bool __fastcall IsEurekaLogActive(void);
extern PACKAGE bool __fastcall GetCompilationDate(unsigned HModule, bool LocalTime, System::TDateTime &Date);
extern PACKAGE char * __fastcall FastMM_LogStackTrace(PCardinal AReturnAddresses, unsigned AMaxDepth, char * ABuffer, bool ShowDLLsFunctions, bool ShowBPLsFunctions, bool ShowProcLineOffset);

}	/* namespace Exceptionlog */
using namespace Exceptionlog;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ExceptionlogHPP
