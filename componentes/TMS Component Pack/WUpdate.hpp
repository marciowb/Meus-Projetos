// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wupdate.pas' rev: 21.00

#ifndef WupdateHPP
#define WupdateHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Wininet.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Lzexpand.hpp>	// Pascal unit
#include <Cabfdi.hpp>	// Pascal unit
#include <Wucrc32.hpp>	// Pascal unit
#include <Wubase64.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Shlobj.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Wulogin.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

#pragma link "wininet.lib"
#pragma link "urlmon.lib"


namespace Wupdate
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TWebUpdateAuthentication { waAlways, waAuto, waNever };
#pragma option pop

typedef void __fastcall (__closure *TWebUpdateEvent)(System::TObject* Sender);

typedef void __fastcall (__closure *TWebUpdateFileProgress)(System::TObject* Sender, System::UnicodeString FileName, int Pos, int Size);

typedef void __fastcall (__closure *TWebUpdateProgress)(System::TObject* Sender, System::UnicodeString Action);

typedef void __fastcall (__closure *TWebUpdateProgressCancel)(System::TObject* Sender, bool &Cancel);

typedef void __fastcall (__closure *TWebUpdateFileDownloaded)(System::TObject* Sender, System::UnicodeString FileName);

typedef void __fastcall (__closure *TWebUpdateBeforePost)(System::TObject* Sender, bool &AllowPost);

typedef void __fastcall (__closure *TWebUpdateProcessPostResult)(System::TObject* Sender, bool &AllowPostResult);

typedef void __fastcall (__closure *TWebUpdateStatus)(System::TObject* Sender, System::UnicodeString StatusStr, int StatusCode, int ErrCode);

typedef void __fastcall (__closure *TWebUpdateThreadDone)(System::TObject* Sender);

typedef void __fastcall (__closure *TWebUpdateRestart)(System::TObject* Sender, bool &Allow);

typedef void __fastcall (__closure *TWebUpdateCustomValidate)(System::TObject* Sender, System::UnicodeString Msg, System::UnicodeString Param, bool &Allow);

typedef void __fastcall (__closure *TWebUpdateCustomProcess)(System::TObject* Sender, System::UnicodeString Msg, System::UnicodeString Param);

typedef void __fastcall (__closure *TWebUpdateSetParams)(System::TObject* Sender, System::UnicodeString &AppParams);

typedef void __fastcall (__closure *TWebUpdateFileVersionCheck)(System::TObject* Sender, System::UnicodeString NewVersion, System::UnicodeString LocalVersion, bool &IsNew);

typedef void __fastcall (__closure *TWebUpdateConvertPrefix)(System::TObject* Sender, System::UnicodeString &Path);

typedef void __fastcall (__closure *TWebUpdateFileNameFromURL)(System::TObject* Sender, System::UnicodeString URL, System::UnicodeString &FName);

typedef void __fastcall (__closure *TWebUpdateBeforeDownload)(System::TObject* Sender, int FileIdx, System::UnicodeString FileDescription, System::UnicodeString &URL);

typedef void __fastcall (__closure *TWebUpdateFileList)(System::TObject* Sender, Classes::TStringList* List);

#pragma option push -b-
enum TWebUpdateConnect { wucNoConnect, wucConnectPrompt, wucConnectSilent, wucConnectPromptHangup, wucConnectSilentHangup, wucNone };
#pragma option pop

#pragma option push -b-
enum TWebUpdateUpdate { wuuPromptOnce, wuuPromptAll, wuuSilent };
#pragma option pop

#pragma option push -b-
enum TWebUpdateType { ftpUpdate, httpUpdate, fileUpdate };
#pragma option pop

typedef void __fastcall (__closure *TWebUpdateTextDownloaded)(System::TObject* Sender, Classes::TStrings* Text, int &Res);

#pragma option push -b-
enum TWebUpdateVersionCheck { vcUpdateOnly, vcAlways };
#pragma option pop

#pragma option push -b-
enum TLastURLReg { lurLOCALUSER, lurLOCALMACHINE };
#pragma option pop

class DELPHICLASS TLastURLEntry;
class PASCALIMPLEMENTATION TLastURLEntry : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FSave;
	System::UnicodeString FKey;
	System::UnicodeString FSection;
	TLastURLReg FRegRoot;
	
__published:
	__property bool Save = {read=FSave, write=FSave, default=0};
	__property System::UnicodeString Key = {read=FKey, write=FKey};
	__property System::UnicodeString Section = {read=FSection, write=FSection};
	__property TLastURLReg RegRoot = {read=FRegRoot, write=FRegRoot, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLastURLEntry(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TLastURLEntry(void) : Classes::TPersistent() { }
	
};


class DELPHICLASS TPostUpdateInfo;
class PASCALIMPLEMENTATION TPostUpdateInfo : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FServer;
	System::UnicodeString FAction;
	System::AnsiString FData;
	bool FEnabled;
	System::AnsiString FPostResult;
	
public:
	__property System::AnsiString PostResult = {read=FPostResult, write=FPostResult};
	
__published:
	__property System::UnicodeString Server = {read=FServer, write=FServer};
	__property System::UnicodeString Action = {read=FAction, write=FAction};
	__property System::AnsiString Data = {read=FData, write=FData};
	__property bool Enabled = {read=FEnabled, write=FEnabled, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPostUpdateInfo(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TPostUpdateInfo(void) : Classes::TPersistent() { }
	
};


class DELPHICLASS TInetThread;
class DELPHICLASS TWebUpdate;
class PASCALIMPLEMENTATION TInetThread : public Classes::TThread
{
	typedef Classes::TThread inherited;
	
private:
	TWebUpdate* WebUpdate;
	bool FInitPath;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TInetThread(TWebUpdate* AWebUpdate, bool InitPath);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TInetThread(void) { }
	
};


class DELPHICLASS TFileDescription;
class PASCALIMPLEMENTATION TFileDescription : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FCompressed;
	int FNewCheckSum;
	int FNewSize;
	System::UnicodeString FURL;
	System::UnicodeString FTargetDir;
	System::UnicodeString FLocalVersion;
	System::UnicodeString FNewVersion;
	System::UnicodeString FDescription;
	System::UnicodeString FNewCustomVer;
	int FFileSize;
	System::UnicodeString FNewDate;
	System::UnicodeString FNewTime;
	bool FMandatory;
	bool FPreselect;
	bool FHidden;
	bool FSelected;
	
__published:
	__property System::UnicodeString URL = {read=FURL, write=FURL};
	__property System::UnicodeString NewVersion = {read=FNewVersion, write=FNewVersion};
	__property int NewSize = {read=FNewSize, write=FNewSize, nodefault};
	__property int NewCheckSum = {read=FNewCheckSum, write=FNewCheckSum, nodefault};
	__property System::UnicodeString NewCustomVer = {read=FNewCustomVer, write=FNewCustomVer};
	__property System::UnicodeString NewDate = {read=FNewDate, write=FNewDate};
	__property System::UnicodeString NewTime = {read=FNewTime, write=FNewTime};
	__property System::UnicodeString LocalVersion = {read=FLocalVersion, write=FLocalVersion};
	__property System::UnicodeString Description = {read=FDescription, write=FDescription};
	__property System::UnicodeString TargetDir = {read=FTargetDir, write=FTargetDir};
	__property bool Compressed = {read=FCompressed, write=FCompressed, nodefault};
	__property int FileSize = {read=FFileSize, write=FFileSize, nodefault};
	__property bool Mandatory = {read=FMandatory, write=FMandatory, nodefault};
	__property bool Preselect = {read=FPreselect, write=FPreselect, nodefault};
	__property bool Hidden = {read=FHidden, write=FHidden, nodefault};
	__property bool Selected = {read=FSelected, write=FSelected, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TFileDescription(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TFileDescription(void) { }
	
};


class DELPHICLASS TFileList;
class PASCALIMPLEMENTATION TFileList : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TFileDescription* operator[](int Index) { return Items[Index]; }
	
private:
	int FActiveItem;
	HIDESBASE TFileDescription* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TFileDescription* Value);
	
public:
	virtual Classes::TCollectionItemClass __fastcall GetItemClass(void);
	HIDESBASE TFileDescription* __fastcall Add(void);
	HIDESBASE TFileDescription* __fastcall Insert(int index);
	__property TFileDescription* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property int ActiveItem = {read=FActiveItem, nodefault};
	int __fastcall TotalSize(void);
	int __fastcall CompletedSize(void);
public:
	/* TCollection.Create */ inline __fastcall TFileList(Classes::TCollectionItemClass ItemClass) : Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TFileList(void) { }
	
};


struct tfvi
{
	
public:
	int versionms;
	int versionls;
};


class DELPHICLASS TWebUpdateUtility;
class PASCALIMPLEMENTATION TWebUpdateUtility : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FShowAnimation;
	bool FShowWindow;
	System::UnicodeString FStatusMessage;
	System::UnicodeString FStatusCaption;
	
__published:
	__property bool ShowWindow = {read=FShowWindow, write=FShowWindow, nodefault};
	__property bool ShowAnimation = {read=FShowAnimation, write=FShowAnimation, nodefault};
	__property System::UnicodeString StatusMessage = {read=FStatusMessage, write=FStatusMessage};
	__property System::UnicodeString StatusCaption = {read=FStatusCaption, write=FStatusCaption};
public:
	/* TComponent.Create */ inline __fastcall virtual TWebUpdateUtility(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TWebUpdateUtility(void) { }
	
};


class DELPHICLASS TProgressForm;
class PASCALIMPLEMENTATION TProgressForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	Comctrls::TProgressBar* FProgressBar;
	Stdctrls::TLabel* FLabel;
	
public:
	__fastcall virtual TProgressForm(Classes::TComponent* AOwner, int Dummy);
	virtual void __fastcall CreateWnd(void);
	__property Comctrls::TProgressBar* ProgressBar = {read=FProgressBar};
	__property Stdctrls::TLabel* FileLabel = {read=FLabel};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TProgressForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TProgressForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TProgressForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TWebUpdate : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FForceUpdate;
	void *FHint;
	void *FHintConnect;
	bool FDialed;
	bool FSaveUpdate;
	System::UnicodeString FControlFileName;
	System::UnicodeString FFTPDirectory;
	bool FFTPPassive;
	System::UnicodeString FHost;
	System::UnicodeString FPassword;
	System::UnicodeString FSignature;
	bool FSignatureCheck;
	bool FExtractCAB;
	bool FApplyPatch;
	int FPort;
	System::UnicodeString FProxy;
	System::UnicodeString FProxyUserID;
	System::UnicodeString FProxyPassword;
	TWebUpdateConnect FUpdateConnect;
	TWebUpdateType FUpdateType;
	TWebUpdateUpdate FUpdateUpdate;
	System::UnicodeString FURL;
	System::UnicodeString FUserID;
	System::UnicodeString FDateFormat;
	System::UnicodeString FTimeFormat;
	System::WideChar FDateSeparator;
	System::WideChar FTimeSeparator;
	TPostUpdateInfo* FPostUpdateInfo;
	TLastURLEntry* FLastURLEntry;
	TWebUpdateFileProgress FWebUpdateFileProgress;
	TWebUpdateFileDownloaded FWebUpdateFileDownloaded;
	TWebUpdateFileVersionCheck FWebUpdateFileVersionCheck;
	TWebUpdateProgress FWebUpdateProgress;
	TWebUpdateProgressCancel FWebUpdateProgressCancel;
	TWebUpdateStatus FWebUpdateStatus;
	TWebUpdateThreadDone FThreadUpdateDone;
	TWebUpdateRestart FAppRestart;
	TWebUpdateEvent FAppDoClose;
	TWebUpdateCustomValidate FCustomValidate;
	TWebUpdateCustomProcess FCustomProcess;
	TWebUpdateProcessPostResult FProcessPostResult;
	TWebUpdateBeforePost FBeforePost;
	TWebUpdateFileList FFileNameList;
	bool FThreaded;
	System::UnicodeString FAppName;
	System::UnicodeString FAppParam;
	System::UnicodeString FAppComps;
	bool FAppCompsIncluded;
	bool FAppClose;
	bool FSilentRestart;
	TWebUpdateConvertPrefix FConvertPrefix;
	TWebUpdateSetParams FSetAppParams;
	bool FFTPDirSet;
	TWebUpdateTextDownloaded FOnDownloadedWhatsNew;
	TWebUpdateTextDownloaded FOnDownloadedEULA;
	TWebUpdateBeforeDownload FOnBeforeFileDownload;
	bool FUseCRC32;
	bool FUseWinTempDir;
	TWebUpdateUtility* FUtility;
	TWebUpdateFileNameFromURL FOnFileNameFromURL;
	System::UnicodeString FTempDirectory;
	bool FKeepAlive;
	bool FExistingConnection;
	System::UnicodeString FLocalFileDateCheck;
	System::TDateTime FNewVersionDate;
	System::TDateTime FCurVersionDate;
	System::UnicodeString FCurVersionInfo;
	System::UnicodeString FNewVersionInfo;
	TFileList* FFileList;
	System::UnicodeString FUpdateDescription;
	bool FLogging;
	bool FCancelled;
	TWebUpdateVersionCheck FVersionCheck;
	Classes::TNotifyEvent FOnSuccess;
	bool FInProgress;
	bool FKeepIntermediateFiles;
	System::UnicodeString FAgent;
	System::UnicodeString FLanguageID;
	System::UnicodeString FLogFileName;
	int FTimeOut;
	int FReceiveTimeOut;
	TWebUpdateAuthentication FAuthenticate;
	TProgressForm* FProgressForm;
	bool FShowDownloadProgress;
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall SetLogFileName(const System::UnicodeString Value);
	
protected:
	Classes::TStringList* __fastcall GetTextFile(System::UnicodeString URL);
	Classes::TMemoryStream* __fastcall GetStream(System::UnicodeString URL);
	System::UnicodeString __fastcall ExpandPath(System::UnicodeString tgt);
	bool __fastcall FileGetFile(System::UnicodeString url, System::UnicodeString tgt, bool uncompress);
	void __fastcall ThreadDone(System::TObject* Sender);
	bool __fastcall IsRTF(Classes::TMemoryStream* ms);
	virtual int __fastcall WhatsNewDialog(Classes::TMemoryStream* ms);
	virtual int __fastcall EULADialog(Classes::TMemoryStream* ms);
	virtual void __fastcall DoStatus(int id, System::UnicodeString param, int statuscode, int errorcode);
	virtual void __fastcall ExtractUpdateResource(void);
	virtual void __fastcall ExtractUtility(void);
	virtual bool __fastcall CheckVersions(System::UnicodeString &fvn, System::UnicodeString &fvl, int fvs, int fvc);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	System::TDateTime __fastcall ControlValueToDate(System::UnicodeString d, System::UnicodeString t);
	bool __fastcall ExecAndWait(System::UnicodeString sCommandLine, bool Show, bool Animate, System::UnicodeString Caption, System::UnicodeString Msg);
	bool __fastcall GetAppNeedsRestart(void);
	virtual void __fastcall HandleProgress(System::UnicodeString AFileName, int FilePos, int FileSize);
	virtual void __fastcall HandleCancel(bool &Cancel);
	void __fastcall SetTimeout(unsigned timeout);
	void __fastcall SetReceiveTimeOut(unsigned receivetimeout);
	
public:
	virtual void __fastcall CustomProcess(System::UnicodeString fn);
	System::UnicodeString __fastcall URLtoFile(System::UnicodeString url);
	System::UnicodeString __fastcall URLToDomain(System::UnicodeString url);
	bool __fastcall URLGetFile(void * hfile, System::UnicodeString url, System::UnicodeString tgt, bool uncompress);
	System::UnicodeString __fastcall MakeProxyUrl(System::UnicodeString url, System::UnicodeString proxyuser, System::UnicodeString proxypwd);
	void __fastcall ShowHTMLDialog(System::UnicodeString s);
	void __fastcall Error(void);
	void __fastcall Cancel(void);
	tfvi __fastcall GetFileVersion(System::UnicodeString FileName);
	void __fastcall AddToLog(System::UnicodeString s);
	__fastcall virtual TWebUpdate(Classes::TComponent* aOwner);
	__fastcall virtual ~TWebUpdate(void);
	void __fastcall DoUpdate(void)/* overload */;
	void __fastcall DoUpdate(bool InitPath)/* overload */;
	void __fastcall DoSuccess(void);
	void __fastcall DoThreadUpdate(void)/* overload */;
	void __fastcall DoThreadUpdate(bool InitPath)/* overload */;
	void __fastcall DoPostUpdateInfo(void);
	void __fastcall DoRestart(void);
	virtual int __fastcall StartConnection(void);
	virtual int __fastcall StopConnection(void);
	virtual int __fastcall FTPConnect(void);
	virtual System::UnicodeString __fastcall GetControlFileURL(void);
	virtual int __fastcall GetControlFile(void);
	virtual int __fastcall DoVersionCheck(void);
	virtual int __fastcall HandleActions(void);
	virtual Classes::TStringList* __fastcall GetWhatsNew(void);
	virtual Classes::TMemoryStream* __fastcall GetWhatsNewStream(void);
	virtual Classes::TStringList* __fastcall GetEULA(void);
	virtual Classes::TMemoryStream* __fastcall GetEULAStream(void);
	virtual System::UnicodeString __fastcall GetOSVersion(void);
	virtual System::UnicodeString __fastcall GetIDE(void);
	virtual System::UnicodeString __fastcall GetIEVersion(void);
	virtual System::UnicodeString __fastcall GetInstalledIDEs(void);
	virtual int __fastcall GetFileDetails(void);
	virtual int __fastcall ProcessFileDetails(void);
	virtual int __fastcall GetFileUpdates(void);
	int __fastcall UpdateActions(void);
	bool __fastcall Connected(void);
	int __fastcall ConnectionType(void);
	bool __fastcall NewVersionAvailable(bool InitPath = false);
	Classes::TStringList* __fastcall NewWhatsNew(bool showdialog = false);
	void __fastcall HangUp(void);
	void __fastcall URLPut(System::UnicodeString url);
	System::UnicodeString __fastcall URLGet(void);
	void __fastcall UpdateDatePut(System::TDateTime dt);
	System::TDateTime __fastcall UpdateDateGet(void);
	virtual void __fastcall ConvertPrefix(const System::UnicodeString prefix, System::UnicodeString &s);
	__property System::UnicodeString ControlFileName = {read=FControlFileName};
	__property System::TDateTime NewVersionDate = {read=FNewVersionDate};
	__property System::TDateTime CurVersionDate = {read=FCurVersionDate};
	__property System::UnicodeString CurVersionInfo = {read=FCurVersionInfo};
	__property System::UnicodeString NewVersionInfo = {read=FNewVersionInfo};
	__property System::UnicodeString UpdateDescription = {read=FUpdateDescription};
	__property TFileList* FileList = {read=FFileList};
	__property bool Cancelled = {read=FCancelled, nodefault};
	__property bool InProgress = {read=FInProgress, nodefault};
	__property bool AppNeedsRestart = {read=GetAppNeedsRestart, nodefault};
	__property bool AppSilentRestart = {read=FSilentRestart, nodefault};
	
__published:
	__property System::UnicodeString Agent = {read=FAgent, write=FAgent};
	__property bool ApplyPatch = {read=FApplyPatch, write=FApplyPatch, default=0};
	__property TWebUpdateAuthentication Authenticate = {read=FAuthenticate, write=FAuthenticate, default=2};
	__property System::UnicodeString DateFormat = {read=FDateFormat, write=FDateFormat};
	__property System::WideChar DateSeparator = {read=FDateSeparator, write=FDateSeparator, nodefault};
	__property bool ExtractCAB = {read=FExtractCAB, write=FExtractCAB, default=0};
	__property bool ExistingConnection = {read=FExistingConnection, write=FExistingConnection, default=0};
	__property bool ForceUpdate = {read=FForceUpdate, write=FForceUpdate, default=0};
	__property System::UnicodeString FTPDirectory = {read=FFTPDirectory, write=FFTPDirectory};
	__property bool FTPPassive = {read=FFTPPassive, write=FFTPPassive, default=0};
	__property System::UnicodeString Host = {read=FHost, write=FHost};
	__property bool HTTPKeepAliveAuthentication = {read=FKeepAlive, write=FKeepAlive, default=0};
	__property bool KeepIntermediateFiles = {read=FKeepIntermediateFiles, write=FKeepIntermediateFiles, default=0};
	__property System::UnicodeString LanguageID = {read=FLanguageID, write=FLanguageID};
	__property bool Logging = {read=FLogging, write=FLogging, default=0};
	__property System::UnicodeString LogFileName = {read=FLogFileName, write=SetLogFileName};
	__property TLastURLEntry* LastURLEntry = {read=FLastURLEntry, write=FLastURLEntry};
	__property System::UnicodeString Password = {read=FPassword, write=FPassword};
	__property int Port = {read=FPort, write=FPort, default=21};
	__property TPostUpdateInfo* PostUpdateInfo = {read=FPostUpdateInfo, write=FPostUpdateInfo};
	__property System::UnicodeString Proxy = {read=FProxy, write=FProxy};
	__property System::UnicodeString ProxyUserID = {read=FProxyUserID, write=FProxyUserID};
	__property System::UnicodeString ProxyPassword = {read=FProxyPassword, write=FProxyPassword};
	__property bool ShowDownloadProgress = {read=FShowDownloadProgress, write=FShowDownloadProgress, default=0};
	__property System::UnicodeString Signature = {read=FSignature, write=FSignature};
	__property bool SignatureCheck = {read=FSignatureCheck, write=FSignatureCheck, default=0};
	__property System::UnicodeString TempDirectory = {read=FTempDirectory, write=FTempDirectory};
	__property System::UnicodeString TimeFormat = {read=FTimeFormat, write=FTimeFormat};
	__property int TimeOut = {read=FTimeOut, write=FTimeOut, default=0};
	__property int ReceiveTimeOut = {read=FReceiveTimeOut, write=FReceiveTimeOut, default=0};
	__property System::WideChar TimeSeparator = {read=FTimeSeparator, write=FTimeSeparator, nodefault};
	__property TWebUpdateType UpdateType = {read=FUpdateType, write=FUpdateType, default=1};
	__property TWebUpdateConnect UpdateConnect = {read=FUpdateConnect, write=FUpdateConnect, default=0};
	__property TWebUpdateUpdate UpdateUpdate = {read=FUpdateUpdate, write=FUpdateUpdate, default=0};
	__property System::UnicodeString URL = {read=FURL, write=FURL};
	__property System::UnicodeString UserID = {read=FUserID, write=FUserID};
	__property bool UseCRC32 = {read=FUseCRC32, write=FUseCRC32, default=0};
	__property bool UseWinTempDir = {read=FUseWinTempDir, write=FUseWinTempDir, default=1};
	__property TWebUpdateUtility* Utility = {read=FUtility, write=FUtility};
	__property TWebUpdateVersionCheck VersionCheck = {read=FVersionCheck, write=FVersionCheck, default=0};
	__property TWebUpdateFileProgress OnFileProgress = {read=FWebUpdateFileProgress, write=FWebUpdateFileProgress};
	__property TWebUpdateFileDownloaded OnFileDownloaded = {read=FWebUpdateFileDownloaded, write=FWebUpdateFileDownloaded};
	__property TWebUpdateFileVersionCheck OnFileVersionCheck = {read=FWebUpdateFileVersionCheck, write=FWebUpdateFileVersionCheck};
	__property TWebUpdateProcessPostResult OnProcessPostResult = {read=FProcessPostResult, write=FProcessPostResult};
	__property TWebUpdateBeforePost OnBeforePost = {read=FBeforePost, write=FBeforePost};
	__property TWebUpdateProgress OnProgress = {read=FWebUpdateProgress, write=FWebUpdateProgress};
	__property TWebUpdateProgressCancel OnProgressCancel = {read=FWebUpdateProgressCancel, write=FWebUpdateProgressCancel};
	__property TWebUpdateStatus OnStatus = {read=FWebUpdateStatus, write=FWebUpdateStatus};
	__property TWebUpdateThreadDone OnThreadUpdateDone = {read=FThreadUpdateDone, write=FThreadUpdateDone};
	__property TWebUpdateRestart OnAppRestart = {read=FAppRestart, write=FAppRestart};
	__property TWebUpdateEvent OnAppDoClose = {read=FAppDoClose, write=FAppDoClose};
	__property TWebUpdateBeforeDownload OnBeforeFileDownload = {read=FOnBeforeFileDownload, write=FOnBeforeFileDownload};
	__property TWebUpdateCustomValidate OnCustomValidate = {read=FCustomValidate, write=FCustomValidate};
	__property TWebUpdateCustomProcess OnCustomProcess = {read=FCustomProcess, write=FCustomProcess};
	__property TWebUpdateFileList OnGetFileList = {read=FFileNameList, write=FFileNameList};
	__property TWebUpdateConvertPrefix OnConvertPrefix = {read=FConvertPrefix, write=FConvertPrefix};
	__property TWebUpdateSetParams OnSetAppParams = {read=FSetAppParams, write=FSetAppParams};
	__property TWebUpdateTextDownloaded OnDownloadedWhatsNew = {read=FOnDownloadedWhatsNew, write=FOnDownloadedWhatsNew};
	__property TWebUpdateTextDownloaded OnDownloadedEULA = {read=FOnDownloadedEULA, write=FOnDownloadedEULA};
	__property TWebUpdateFileNameFromURL OnFileNameFromURL = {read=FOnFileNameFromURL, write=FOnFileNameFromURL};
	__property Classes::TNotifyEvent OnSuccess = {read=FOnSuccess, write=FOnSuccess};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt WebUpdateSuccess = 0x0;
static const ShortInt WebUpdateAccessError = 0x1;
static const ShortInt WebUpdateNotFound = 0x2;
static const ShortInt WebUpdateInformation = 0x3;
static const ShortInt WebUpdateNoNewVersion = 0x4;
static const ShortInt WebUpdateNewVersion = 0x5;
static const ShortInt WebUpdateHTTPStatus = 0x6;
static const ShortInt WebUpdateHTMLDialog = 0x7;
static const ShortInt WebUpdateCABError = 0x8;
static const ShortInt WebUpdateSpawnFail = 0x9;
static const ShortInt WebUpdateWrongSource = 0xa;
static const ShortInt WebUpdateSignatureError = 0xb;
static const ShortInt WebUpdateWhatsNew = 0xc;
static const ShortInt WebUpdateEUL = 0xd;
static const ShortInt WebUpdateWhatsnewCancel = 0xe;
static const ShortInt WebUpdateEULACancel = 0xf;
static const ShortInt WebUpdatePostConnectFail = 0x10;
static const ShortInt WebUpdatePostPostFail = 0x11;
static const ShortInt WebUpdateExecAndWait = 0x12;
static const ShortInt WebUpdateReplaceError = 0x13;
static const ShortInt WebUpdateRenameError = 0x13;
static const Byte WebUpdateUndefined = 0xff;
static const ShortInt ErrControlFileNotFound = 0x0;
static const ShortInt ErrUpdateFileNotFound = 0x1;
static const ShortInt ErrUpdateFileZeroLen = 0x2;
static const ShortInt ErrUpdateTargetEqual = 0x3;
static const ShortInt ErrUpdateSignatureError = 0x4;
static const ShortInt ErrConnectError = 0x5;
static const ShortInt ErrCannotDeleteFile = 0x6;
static const ShortInt ErrCannotRenameFile = 0x7;
static const ShortInt ErrCannotChangeDir = 0x8;
static const Byte ErrUndefined = 0xff;
static const ShortInt WU_FAILED = -1;
static const ShortInt WU_SUCCESS = 0x0;
static const ShortInt WU_NOCONNECTION = 0x1;
static const ShortInt WU_INTERNETOPENFAILED = 0x2;
static const ShortInt WU_DIALUPFAILED = 0x3;
static const ShortInt WU_FILENOTFOUND = 0x4;
static const ShortInt WU_SIGNATUREFAILED = 0x5;
static const ShortInt WU_DATEBASEDNEWVERSION = 0x6;
static const ShortInt WU_NONEWVERSION = 0x7;
static const ShortInt WU_UNCONDITIONALNEWVERSION = 0x8;
static const ShortInt WU_FILESIZEBASEDNEWVERSION = 0x9;
static const ShortInt WU_CHECKSUMBASEDNEWVERSION = 0xa;
static const ShortInt WU_VERSIONINFOBASEDNEWVERSION = 0xb;
static const ShortInt WU_CUSTOMNEWVERSION = 0xc;
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x3;
static const ShortInt BLD_VER = 0x0;
#define winetdll L"wininet.dll"
#define D5 L"\\Software\\Borland\\Delphi\\5.0"
#define D6 L"\\Software\\Borland\\Delphi\\6.0"
#define D7 L"\\Software\\Borland\\Delphi\\7.0"
#define D2005 L"\\Software\\Borland\\BDS\\3.0"
#define D2006 L"\\Software\\Borland\\BDS\\4.0"
#define D2007 L"\\Software\\Borland\\BDS\\5.0"
#define D2009 L"\\Software\\CodeGear\\BDS\\6.0"
#define D2010 L"\\Software\\CodeGear\\BDS\\7.0"
#define D2011 L"\\Software\\Embarcadero\\BDS\\8.0"
#define C5 L"\\Software\\Borland\\C++Builder\\5.0"
#define C6 L"\\Software\\Borland\\C++Builder\\6.0"
extern PACKAGE System::UnicodeString __fastcall UserDocDir(void);
extern PACKAGE System::UnicodeString __fastcall WinTempDir(void);
extern PACKAGE void __fastcall HTMLDialog(unsigned pHandle, System::UnicodeString s);
extern PACKAGE int __fastcall GetSizeOfFile(System::UnicodeString fn);

}	/* namespace Wupdate */
using namespace Wupdate;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WupdateHPP
