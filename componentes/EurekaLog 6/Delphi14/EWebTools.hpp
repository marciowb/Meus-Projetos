// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ewebtools.pas' rev: 21.00

#ifndef EwebtoolsHPP
#define EwebtoolsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ewebtools
{
//-- type declarations -------------------------------------------------------
typedef void * HINTERNET;

typedef System::Word INTERNET_PORT;

typedef char * LPSTR;

typedef char * *PLPSTR;

#pragma option push -b-
enum TConnectionType { ctConnection, ctConnected, ctSending };
#pragma option pop

#pragma option push -b-
enum TSendResult { srOK, srBugClosed, srUnknownError, srInvalidLogin, srInvalidSelection, srInvalidSearch, srInvalidInsert, srInvalidModify };
#pragma option pop

typedef void __fastcall (*TInternetProgressFunction)(TConnectionType ConnectionType, unsigned TotalSize, unsigned BytesSent);

#pragma pack(push,1)
struct TProxyRecord
{
	
public:
	System::AnsiString Server;
	System::Word Port;
	System::AnsiString UserName;
	System::AnsiString Password;
};
#pragma pack(pop)


typedef TProxyRecord *PProxyRecord;

class DELPHICLASS THTTPResponse;
class PASCALIMPLEMENTATION THTTPResponse : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int StatusCode;
	System::AnsiString StatusText;
	System::AnsiString Header;
	System::AnsiString HTML;
	System::AnsiString ReplayPage;
	int ErrorCode;
	System::AnsiString ErrorMessage;
	virtual void __fastcall Assign(THTTPResponse* Source);
	virtual void __fastcall Clear(void);
public:
	/* TObject.Create */ inline __fastcall THTTPResponse(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~THTTPResponse(void) { }
	
};


#pragma option push -b-
enum TSendState { ssConnecting, ssConnected, ssLogin, ssSelectProject, ssSearching, ssModifying, ssSending, ssSent, ssDisconnecting, ssDisconnected };
#pragma option pop

#pragma option push -b-
enum TRequestMethod { rmGET, rmPOST, rmBinaryPOST };
#pragma option pop

class DELPHICLASS THTTPConnectionBase;
class PASCALIMPLEMENTATION THTTPConnectionBase : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	void *hInternet;
	void *hConnect;
	System::AnsiString BasePath;
	THTTPResponse* FResponse;
	
protected:
	virtual bool __fastcall Open(void);
	virtual bool __fastcall Close(void);
	bool __fastcall GetBugCountField(const System::AnsiString FieldName);
	void __fastcall AddSearchText(const System::AnsiString FieldName, const System::AnsiString AVersion, const System::AnsiString AExceptionType, const System::AnsiString ABugID);
	void __fastcall AddBugSummary(const System::AnsiString FieldName, const System::AnsiString AVersion, const System::AnsiString AExceptionType, const System::AnsiString ABugID);
	
public:
	System::AnsiString Host;
	System::Word Port;
	System::AnsiString Path;
	bool UseHTTPS;
	System::AnsiString UserName;
	System::AnsiString Password;
	TRequestMethod RequestMethod;
	Classes::TStrings* Files;
	Classes::TStrings* Fields;
	bool UseProxy;
	TProxyRecord ProxySetting;
	__fastcall THTTPConnectionBase(const System::AnsiString URL, const System::AnsiString Proxy);
	__fastcall virtual ~THTTPConnectionBase(void);
	void __fastcall SetRequest(const System::AnsiString AWebPage, TRequestMethod AMethod);
	void __fastcall AddField(const System::AnsiString FieldName, const System::AnsiString FieldValue);
	void __fastcall AddFieldValue(const System::AnsiString FieldName);
	void __fastcall AddFieldByTextArea(const System::AnsiString FieldName);
	void __fastcall AddFieldByDefaultList(const System::AnsiString ListName);
	void __fastcall AddFieldByDefaultList2(const System::AnsiString ListName);
	void __fastcall AddFieldByListTitle(const System::AnsiString ListName, const System::AnsiString FieldTitle);
	void __fastcall AddCustomFields(Classes::TStrings* CustomFields);
	System::AnsiString __fastcall AddOptionalField(const System::AnsiString Source, const System::AnsiString Field);
	bool __fastcall IsSuccessfulSend(const System::AnsiString ReplyPage, const System::AnsiString HTMLIncludeCode, const System::AnsiString HTMLExcludeCode);
	bool __fastcall SendRequest(THTTPResponse* &Response, bool UpdateStatus);
	virtual void __fastcall SetSendState(TSendState ASendState, int APercent) = 0 ;
};


typedef TMetaClass* THTTPConnectionClass;

class DELPHICLASS THTTPSendReport;
class PASCALIMPLEMENTATION THTTPSendReport : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	THTTPConnectionClass FHTTPConnectionClass;
	
public:
	__fastcall THTTPSendReport(void);
	void __fastcall SetHTTPConnectionClass(THTTPConnectionClass ClassType);
	virtual TSendResult __fastcall PostBug(const System::AnsiString AVersion, const System::AnsiString ABugType, const System::AnsiString ABugText, const System::AnsiString ABugID, const System::AnsiString ABaseURL, const System::AnsiString AProxyURL, const System::AnsiString AUserName, const System::AnsiString APassword, const System::AnsiString AProjectName, const System::AnsiString ACategory, const System::AnsiString AAssignTo, const System::AnsiString AAttachedFile, Classes::TStrings* ACustomFields, THTTPResponse* &Response) = 0 ;
public:
	/* TObject.Destroy */ inline __fastcall virtual ~THTTPSendReport(void) { }
	
};


typedef TMetaClass* THTTPSendReportClass;

class DELPHICLASS THTTPMantisSendReport;
class PASCALIMPLEMENTATION THTTPMantisSendReport : public THTTPSendReport
{
	typedef THTTPSendReport inherited;
	
public:
	virtual TSendResult __fastcall PostBug(const System::AnsiString AVersion, const System::AnsiString ABugType, const System::AnsiString ABugText, const System::AnsiString ABugID, const System::AnsiString ABaseURL, const System::AnsiString AProxyURL, const System::AnsiString AUserName, const System::AnsiString APassword, const System::AnsiString AProjectName, const System::AnsiString ACategory, const System::AnsiString AAssignTo, const System::AnsiString AAttachedFile, Classes::TStrings* ACustomFields, THTTPResponse* &Response);
public:
	/* THTTPSendReport.Create */ inline __fastcall THTTPMantisSendReport(void) : THTTPSendReport() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~THTTPMantisSendReport(void) { }
	
};


class DELPHICLASS THTTPBugzillaSendReport;
class PASCALIMPLEMENTATION THTTPBugzillaSendReport : public THTTPSendReport
{
	typedef THTTPSendReport inherited;
	
public:
	virtual TSendResult __fastcall PostBug(const System::AnsiString AVersion, const System::AnsiString ABugType, const System::AnsiString ABugText, const System::AnsiString ABugID, const System::AnsiString ABaseURL, const System::AnsiString AProxyURL, const System::AnsiString AUserName, const System::AnsiString APassword, const System::AnsiString AProjectName, const System::AnsiString ACategory, const System::AnsiString AAssignTo, const System::AnsiString AAttachedFile, Classes::TStrings* ACustomFields, THTTPResponse* &Response);
public:
	/* THTTPSendReport.Create */ inline __fastcall THTTPBugzillaSendReport(void) : THTTPSendReport() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~THTTPBugzillaSendReport(void) { }
	
};


class DELPHICLASS THTTPFogBugzSendReport;
class PASCALIMPLEMENTATION THTTPFogBugzSendReport : public THTTPSendReport
{
	typedef THTTPSendReport inherited;
	
public:
	virtual TSendResult __fastcall PostBug(const System::AnsiString AVersion, const System::AnsiString ABugType, const System::AnsiString ABugText, const System::AnsiString ABugID, const System::AnsiString ABaseURL, const System::AnsiString AProxyURL, const System::AnsiString AUserName, const System::AnsiString APassword, const System::AnsiString AProjectName, const System::AnsiString ACategory, const System::AnsiString AAssignTo, const System::AnsiString AAttachedFile, Classes::TStrings* ACustomFields, THTTPResponse* &Response);
public:
	/* THTTPSendReport.Create */ inline __fastcall THTTPFogBugzSendReport(void) : THTTPSendReport() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~THTTPFogBugzSendReport(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt Error_NetLibNotFound = -1;
static const int GenericNetError = 0x7fffffff;
#define WinInetLib L"wininet.dll"
extern PACKAGE void __fastcall AddAuthenticationToURL(System::AnsiString &URL, const System::AnsiString User, const System::AnsiString Password, System::Word Port);
extern PACKAGE bool __fastcall ElaborateURL(System::AnsiString URL, System::AnsiString &Protocol, System::AnsiString &UserID, System::AnsiString &Password, System::AnsiString &Host, System::AnsiString &Path, System::Word &Port);
extern PACKAGE TSendResult __fastcall SendWebTrakerReport(THTTPConnectionClass HTTPConnectionClass, THTTPSendReportClass BugSenderClass, const System::AnsiString AVersion, const System::AnsiString ABugType, const System::AnsiString ABugText, const System::AnsiString ABugID, const System::AnsiString ABaseURL, const System::AnsiString AProxyURL, const System::AnsiString AUserName, const System::AnsiString APassword, const System::AnsiString AProjectName, const System::AnsiString ACategory, const System::AnsiString AAssignTo, const System::AnsiString AAttachedFile, Classes::TStrings* ACustomFields, THTTPResponse* &Response);
extern PACKAGE void __fastcall SetFTPPassiveMode(bool Activate);
extern PACKAGE void __fastcall SetProxyServer(const System::AnsiString Server, System::Word Port);
extern PACKAGE void __fastcall SetProxyAuthenticationData(const System::AnsiString UserID, const System::AnsiString Password);
extern PACKAGE bool __fastcall CheckInternetConnection(void);
extern PACKAGE int __fastcall HTTPUploadFiles(const System::AnsiString Host, const System::AnsiString Path, const System::AnsiString UserID, const System::AnsiString Password, System::Word Port, bool HTTPS, Classes::TStrings* LocalFiles, Classes::TStrings* RemoteFiles, Classes::TStrings* WebFields, TInternetProgressFunction ProgressProc, System::AnsiString &ResultMsg);
extern PACKAGE int __fastcall FTPUploadFiles(const System::AnsiString Host, const System::AnsiString Path, const System::AnsiString UserID, const System::AnsiString Password, System::Word Port, Classes::TStrings* LocalFiles, Classes::TStrings* RemoteFiles, TInternetProgressFunction ProgressProc, System::AnsiString &ResultMsg);
extern PACKAGE bool __fastcall GetHTMLPage(const System::AnsiString URL, System::AnsiString &HTML);

}	/* namespace Ewebtools */
using namespace Ewebtools;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EwebtoolsHPP
