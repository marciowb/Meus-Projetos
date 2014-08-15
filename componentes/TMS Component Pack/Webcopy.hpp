// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Webcopy.pas' rev: 21.00

#ifndef WebcopyHPP
#define WebcopyHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Wininet.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Wcbase64.hpp>	// Pascal unit
#include <Wclogin.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

#pragma link "wininet.lib"


namespace Webcopy
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TWebCopyAuthentication { waNever, waAlways, waAuto };
#pragma option pop

class DELPHICLASS TWCopyThread;
class DELPHICLASS TWebCopy;
class PASCALIMPLEMENTATION TWCopyThread : public Classes::TThread
{
	typedef Classes::TThread inherited;
	
private:
	TWebCopy* webcopy;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TWCopyThread(TWebCopy* AWebCopy);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TWCopyThread(void) { }
	
};


typedef void __fastcall (__closure *TWebCopyURLNotFound)(System::TObject* Sender, System::UnicodeString url);

typedef void __fastcall (__closure *TWebCopyError)(System::TObject* Sender, int ErrorCode);

typedef void __fastcall (__closure *TWebCopyErrorInfo)(System::TObject* Sender, int ErrorCode, System::UnicodeString ErrorInfo);

typedef void __fastcall (__closure *TWebCopyThreadDone)(System::TObject* Sender);

typedef void __fastcall (__closure *TWebCopyCancel)(System::TObject* Sender);

typedef void __fastcall (__closure *TWebCopyFileDone)(System::TObject* Sender, int idx);

typedef void __fastcall (__closure *TWebCopyMultiFTPFileDone)(System::TObject* Sender, System::UnicodeString Filename);

typedef void __fastcall (__closure *TWebCopyFileStart)(System::TObject* Sender, int idx);

typedef void __fastcall (__closure *TWebRemoveFileDone)(System::TObject* Sender, int idx);

typedef void __fastcall (__closure *TWebRemoveFileFailed)(System::TObject* Sender, int idx);

typedef void __fastcall (__closure *TWebCopyFileDateCheck)(System::TObject* Sender, int idx, System::TDateTime newdate, bool &allow);

typedef void __fastcall (__closure *TWebCopyConnectError)(System::TObject* Sender);

#pragma option push -b-
enum TWebCopyProtocol { wpHttp, wpFtp, wpFile, wpFtpUpload, wpHttpUpload, wpMultiFtp, wpMultiFtpUpload, wpFtpDelete, wpFtpList, wpFtpTest };
#pragma option pop

#pragma option push -b-
enum TWebCopyHTTPCommand { hcPost, hcPut };
#pragma option pop

typedef void __fastcall (__closure *TWebCopyOverwrite)(System::TObject* Sender, System::UnicodeString tgtfile, bool &allow);

typedef void __fastcall (__closure *TWebCopyProgress)(System::TObject* Sender, int fileidx, unsigned size, unsigned totsize);

typedef void __fastcall (__closure *TWebCopyNoNewFile)(System::TObject* Sender, System::UnicodeString tgtfile, System::TDateTime curdate, System::TDateTime newdate);

typedef void __fastcall (__closure *TWebCopyBeforeDialogShow)(System::TObject* Sender, Forms::TForm* ADialog);

class DELPHICLASS TFileDetailItem;
class PASCALIMPLEMENTATION TFileDetailItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	unsigned FFileAttributes;
	System::UnicodeString FFilename;
	unsigned FFileSizeLow;
	unsigned FFileSizeHigh;
	_FILETIME FFileDate;
	
public:
	__property unsigned FileAttributes = {read=FFileAttributes, write=FFileAttributes, nodefault};
	__property System::UnicodeString Filename = {read=FFilename, write=FFilename};
	__property unsigned FileSizeLow = {read=FFileSizeLow, write=FFileSizeLow, nodefault};
	__property unsigned FileSizeHigh = {read=FFileSizeHigh, write=FFileSizeHigh, nodefault};
	__property _FILETIME FileDate = {read=FFileDate, write=FFileDate};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TFileDetailItem(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TFileDetailItem(void) { }
	
};


class DELPHICLASS TFileDetailItems;
class PASCALIMPLEMENTATION TFileDetailItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TFileDetailItem* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TFileDetailItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TFileDetailItem* Value);
	
public:
	__fastcall TFileDetailItems(void);
	HIDESBASE TFileDetailItem* __fastcall Add(void);
	HIDESBASE TFileDetailItem* __fastcall Insert(int Index);
	__property TFileDetailItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TFileDetailItems(void) { }
	
};


class DELPHICLASS TWebCopyItem;
class PASCALIMPLEMENTATION TWebCopyItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FURL;
	System::UnicodeString FTargetDir;
	System::UnicodeString FTargetFilename;
	TWebCopyProtocol FProtocol;
	TWebCopyHTTPCommand FHTTPCommand;
	System::UnicodeString FFTPHost;
	System::UnicodeString FFTPUserID;
	System::UnicodeString FFTPPassword;
	int FFTPPort;
	bool FActive;
	bool FSuccess;
	bool FCopyNewerOnly;
	System::TDateTime FFileDate;
	bool FNoNewVersion;
	System::TDateTime FNewFileDate;
	TWebCopyAuthentication FAuthenticate;
	System::UnicodeString FHTTPUserID;
	System::UnicodeString FDisplayURL;
	System::UnicodeString FHTTPPassword;
	unsigned FFileSize;
	bool FCancelled;
	Classes::TStringList* FFileList;
	TFileDetailItems* FFileDetailList;
	
public:
	__fastcall virtual TWebCopyItem(Classes::TCollection* Collection);
	__fastcall virtual ~TWebCopyItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property bool Success = {read=FSuccess, nodefault};
	__property bool Cancelled = {read=FCancelled, nodefault};
	__property bool NoNewVersion = {read=FNoNewVersion, nodefault};
	__property System::TDateTime NewFileDate = {read=FNewFileDate, write=FNewFileDate};
	__property Classes::TStringList* FileList = {read=FFileList};
	__property unsigned FileSize = {read=FFileSize, write=FFileSize, nodefault};
	__property TFileDetailItems* FileDetails = {read=FFileDetailList};
	
__published:
	__property bool Active = {read=FActive, write=FActive, default=1};
	__property TWebCopyAuthentication Authenticate = {read=FAuthenticate, write=FAuthenticate, default=0};
	__property bool CopyNewerOnly = {read=FCopyNewerOnly, write=FCopyNewerOnly, default=0};
	__property System::UnicodeString DisplayURL = {read=FDisplayURL, write=FDisplayURL};
	__property System::TDateTime FileDate = {read=FFileDate, write=FFileDate};
	__property System::UnicodeString FTPHost = {read=FFTPHost, write=FFTPHost};
	__property System::UnicodeString FTPUserID = {read=FFTPUserID, write=FFTPUserID};
	__property System::UnicodeString FTPPassword = {read=FFTPPassword, write=FFTPPassword};
	__property int FTPPort = {read=FFTPPort, write=FFTPPort, nodefault};
	__property TWebCopyHTTPCommand HTTPCommand = {read=FHTTPCommand, write=FHTTPCommand, nodefault};
	__property TWebCopyProtocol Protocol = {read=FProtocol, write=FProtocol, nodefault};
	__property System::UnicodeString TargetDir = {read=FTargetDir, write=FTargetDir};
	__property System::UnicodeString TargetFilename = {read=FTargetFilename, write=FTargetFilename};
	__property System::UnicodeString URL = {read=FURL, write=FURL};
	__property System::UnicodeString HTTPUserID = {read=FHTTPUserID, write=FHTTPUserID};
	__property System::UnicodeString HTTPPassword = {read=FHTTPPassword, write=FHTTPPassword};
};


class DELPHICLASS TWebCopyItems;
class PASCALIMPLEMENTATION TWebCopyItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TWebCopyItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TComponent* FOwner;
	HIDESBASE TWebCopyItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TWebCopyItem* Value);
	int __fastcall GetActiveItems(void);
	int __fastcall GetSuccessCount(void);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TWebCopyItems(Classes::TComponent* AOwner);
	HIDESBASE TWebCopyItem* __fastcall Add(void);
	HIDESBASE TWebCopyItem* __fastcall Insert(int Index);
	__property TWebCopyItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property int ActiveItems = {read=GetActiveItems, nodefault};
	__property int SuccessCount = {read=GetSuccessCount, nodefault};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TWebCopyItems(void) { }
	
};


class PASCALIMPLEMENTATION TWebCopy : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FAlwaysOnTop;
	int FFileNum;
	bool FCancelled;
	Forms::TForm* FForm;
	bool FFormClosed;
	Comctrls::TProgressBar* FProgress;
	Stdctrls::TLabel* FFileLbl;
	Stdctrls::TLabel* FSizeLbl;
	Stdctrls::TLabel* FRateLbl;
	Stdctrls::TLabel* FTimeLbl;
	Stdctrls::TLabel* FElapsedTimeLbl;
	Stdctrls::TButton* FCancelBtn;
	Stdctrls::TButton* FBtnShowFile;
	Stdctrls::TButton* FBtnShowFolder;
	Comctrls::TAnimate* FAnim;
	System::UnicodeString FLastFile;
	System::UnicodeString FLastDir;
	System::UnicodeString FDlgCaption;
	System::UnicodeString FDlgUpload;
	System::UnicodeString FFileLabel;
	System::UnicodeString FProgressLabel;
	System::UnicodeString FRateLabel;
	System::UnicodeString FTimeLabel;
	System::UnicodeString FElapsedTimeLabel;
	System::UnicodeString FProxy;
	System::UnicodeString FProxyUserID;
	System::UnicodeString FProxyPassword;
	TWebCopyItems* FItems;
	void *FHinternet;
	TWebCopyError FOnError;
	TWebCopyErrorInfo FOnErrorInfo;
	TWebCopyThreadDone FOnCopyDone;
	TWebCopyFileDone FOnFileDone;
	TWebCopyFileStart FOnFileStart;
	TWebCopyConnectError FOnConnectError;
	TWebCopyURLNotFound FOnURLNotFound;
	TWebCopyCancel FOnCopyCancel;
	TWebCopyOverwrite FOnCopyOverwrite;
	TWebCopyProgress FOnCopyProgress;
	TWebCopyMultiFTPFileDone FOnMultiFTPFileDone;
	TWebCopyBeforeDialogShow FOnBeforeDialogShow;
	bool FShowDialog;
	System::UnicodeString FFileOfLabel;
	System::UnicodeString FFromServerLabel;
	System::UnicodeString FToServerLabel;
	bool FShowOpenFolder;
	bool FShowOpenFile;
	bool FFTPPassive;
	bool FShowTime;
	bool FShowElapsedTime;
	bool FShowCompletion;
	bool FShowServer;
	System::UnicodeString FDlgCompleted;
	System::UnicodeString FDlgDwnload;
	System::UnicodeString FDlgCopying;
	bool FCopyCompleted;
	TWebCopyNoNewFile FOnNoNewFile;
	System::UnicodeString FDlgCancel;
	System::UnicodeString FDlgClose;
	System::UnicodeString FDlgOpenFolder;
	System::UnicodeString FDlgOpenFile;
	bool FDlgShowCancel;
	bool FDlgShowCloseBtn;
	bool FCancelIsClose;
	bool FKeepAlive;
	TWebCopyFileDateCheck FOnFileDateCheck;
	bool FShowFileName;
	void *FFTPconnect;
	System::UnicodeString FPrevConnect;
	System::UnicodeString FPrevTarget;
	System::UnicodeString FAgent;
	System::UnicodeString FRateStr;
	System::UnicodeString FTimeLeftStr;
	System::UnicodeString FElapsedTimeStr;
	bool FCreateUniqueFilenames;
	bool FShowDialogOnTop;
	TWebRemoveFileDone FOnRemovedFile;
	TWebRemoveFileFailed FOnRemovedFileFailed;
	bool __fastcall HttpGetFile(int idx, System::UnicodeString url, System::UnicodeString displayurl, System::UnicodeString tgtdir, System::UnicodeString tgtfn, bool UseDate, System::TDateTime &FileDate, bool &NoNew, TWebCopyAuthentication Auth, System::UnicodeString UserId, System::UnicodeString Password);
	bool __fastcall HttpPutFile(System::UnicodeString url, System::UnicodeString tgtdir, System::UnicodeString tgtfn, TWebCopyHTTPCommand HttpCommand);
	bool __fastcall FileGetFile(int idx, System::UnicodeString FUserid, System::UnicodeString FPassword, System::UnicodeString FHost, int FPort, System::UnicodeString url, System::UnicodeString tgtdir, System::UnicodeString tgtfn, bool UseDate, System::TDateTime &FileDate, bool &NoNew);
	bool __fastcall FtpGetFile(int idx, System::UnicodeString FUserid, System::UnicodeString FPassword, System::UnicodeString FHost, int FPort, System::UnicodeString URL, System::UnicodeString TgtDir, System::UnicodeString TgtFn, bool UseDate, System::TDateTime &FileDate, bool &NoNew, bool KeepConnect, bool ShowFileInfo);
	bool __fastcall MultiFtpGetList(int idx, System::UnicodeString FUserid, System::UnicodeString FPassword, System::UnicodeString FHost, int FPort, System::UnicodeString URL, System::UnicodeString TgtDir, System::UnicodeString TgtFn, bool UseDate, System::TDateTime &FileDate, bool &NoNew, bool KeepConnect);
	bool __fastcall MultiFtpGetFile(int idx, System::UnicodeString FUserid, System::UnicodeString FPassword, System::UnicodeString FHost, int FPort, System::UnicodeString URL, System::UnicodeString TgtDir, System::UnicodeString TgtFn, bool UseDate, System::TDateTime &FileDate, bool &NoNew, bool KeepConnect);
	bool __fastcall MultiFtpPutFile(int idx, System::UnicodeString fuserid, System::UnicodeString fpassword, System::UnicodeString FHost, int FPort, System::UnicodeString URL, System::UnicodeString TgtDir, System::UnicodeString TgtFn, bool UseDate, System::TDateTime &FileDate, bool &NoNew, bool KeepConnect);
	bool __fastcall FtpPutFile(int idx, System::UnicodeString fuserid, System::UnicodeString fpassword, System::UnicodeString FHost, int FPort, System::UnicodeString URL, System::UnicodeString TgtDir, System::UnicodeString TgtFn, bool UseDate, System::TDateTime &FileDate, bool &NoNew, bool KeepConnect);
	bool __fastcall FtpRemoveFile(int idx, System::UnicodeString FUserid, System::UnicodeString FPassword, System::UnicodeString FHost, int FPort, System::UnicodeString URL, System::UnicodeString TgtDir, System::UnicodeString TgtFn, bool KeepConnect);
	bool __fastcall FtpTest(int idx, System::UnicodeString FUserid, System::UnicodeString FPassword, System::UnicodeString FHost, int FPort);
	System::UnicodeString __fastcall MakeProxyUrl(System::UnicodeString url);
	System::UnicodeString __fastcall ExtractServer(System::UnicodeString url);
	System::UnicodeString __fastcall RemoveServer(System::UnicodeString url);
	void __fastcall CreateForm(void);
	void __fastcall DestroyForm(void);
	void __fastcall ThreadDone(System::TObject* Sender);
	int __fastcall NumInetItems(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
protected:
	void __fastcall CancelClick(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall OpenFile(System::TObject* Sender);
	void __fastcall OpenFolder(System::TObject* Sender);
	
public:
	void __fastcall Execute(void);
	void __fastcall ThreadExecute(void);
	void __fastcall ThreadExecAndWait(void);
	void __fastcall DoCopy(void);
	void __fastcall CancelCopy(void);
	__fastcall virtual TWebCopy(Classes::TComponent* AOwner);
	__fastcall virtual ~TWebCopy(void);
	__property Forms::TForm* ProgressForm = {read=FForm};
	__property Comctrls::TProgressBar* ProgressBar = {read=FProgress};
	__property Stdctrls::TLabel* ProgressFileLabel = {read=FFileLbl};
	__property Stdctrls::TLabel* ProgressSizeLabel = {read=FSizeLbl};
	__property Stdctrls::TLabel* ProgressRateLabel = {read=FRateLbl};
	__property System::UnicodeString ElapsedTimeStr = {read=FElapsedTimeStr};
	__property System::UnicodeString TimeLeftStr = {read=FTimeLeftStr};
	__property System::UnicodeString RateStr = {read=FRateStr};
	__property bool FormClosed = {read=FFormClosed, write=FFormClosed, nodefault};
	
__published:
	__property System::UnicodeString Agent = {read=FAgent, write=FAgent};
	__property bool AlwaysOnTop = {read=FAlwaysOnTop, write=FAlwaysOnTop, default=0};
	__property bool CreateUniqueFilenames = {read=FCreateUniqueFilenames, write=FCreateUniqueFilenames, default=0};
	__property System::UnicodeString DlgCancel = {read=FDlgCancel, write=FDlgCancel};
	__property System::UnicodeString DlgCaption = {read=FDlgCaption, write=FDlgCaption};
	__property System::UnicodeString DlgCompleted = {read=FDlgCompleted, write=FDlgCompleted};
	__property System::UnicodeString DlgClose = {read=FDlgClose, write=FDlgClose};
	__property System::UnicodeString DlgFileLabel = {read=FFileLabel, write=FFileLabel};
	__property System::UnicodeString DlgFileOfLabel = {read=FFileOfLabel, write=FFileOfLabel};
	__property System::UnicodeString DlgFromServerLabel = {read=FFromServerLabel, write=FFromServerLabel};
	__property System::UnicodeString DlgToServerLabel = {read=FToServerLabel, write=FToServerLabel};
	__property System::UnicodeString DlgProgressLabel = {read=FProgressLabel, write=FProgressLabel};
	__property System::UnicodeString DlgRateLabel = {read=FRateLabel, write=FRateLabel};
	__property System::UnicodeString DlgTimeLabel = {read=FTimeLabel, write=FTimeLabel};
	__property System::UnicodeString DlgElapsedTimeLabel = {read=FElapsedTimeLabel, write=FElapsedTimeLabel};
	__property System::UnicodeString DlgCopying = {read=FDlgCopying, write=FDlgCopying};
	__property System::UnicodeString DlgDwnload = {read=FDlgDwnload, write=FDlgDwnload};
	__property System::UnicodeString DlgUpload = {read=FDlgUpload, write=FDlgUpload};
	__property System::UnicodeString DlgOpenFile = {read=FDlgOpenFile, write=FDlgOpenFile};
	__property System::UnicodeString DlgOpenFolder = {read=FDlgOpenFolder, write=FDlgOpenFolder};
	__property bool FTPPassive = {read=FFTPPassive, write=FFTPPassive, nodefault};
	__property bool HTTPKeepAliveAuthentication = {read=FKeepAlive, write=FKeepAlive, default=0};
	__property TWebCopyItems* Items = {read=FItems, write=FItems};
	__property System::UnicodeString Proxy = {read=FProxy, write=FProxy};
	__property System::UnicodeString ProxyUserID = {read=FProxyUserID, write=FProxyUserID};
	__property System::UnicodeString ProxyPassword = {read=FProxyPassword, write=FProxyPassword};
	__property bool DlgShowCancel = {read=FDlgShowCancel, write=FDlgShowCancel, default=1};
	__property bool DlgShowCloseBtn = {read=FDlgShowCloseBtn, write=FDlgShowCloseBtn, default=0};
	__property bool ShowDialog = {read=FShowDialog, write=FShowDialog, default=1};
	__property bool ShowDialogOnTop = {read=FShowDialogOnTop, write=FShowDialogOnTop, default=1};
	__property bool ShowOpenFile = {read=FShowOpenFile, write=FShowOpenFile, default=0};
	__property bool ShowOpenFolder = {read=FShowOpenFolder, write=FShowOpenFolder, default=0};
	__property bool ShowCompletion = {read=FShowCompletion, write=FShowCompletion, default=0};
	__property bool ShowElapsedTime = {read=FShowElapsedTime, write=FShowElapsedTime, default=0};
	__property bool ShowFileName = {read=FShowFileName, write=FShowFileName, default=1};
	__property bool ShowServer = {read=FShowServer, write=FShowServer, default=1};
	__property bool ShowTime = {read=FShowTime, write=FShowTime, default=0};
	__property TWebCopyBeforeDialogShow OnBeforeDialogShow = {read=FOnBeforeDialogShow, write=FOnBeforeDialogShow};
	__property TWebCopyConnectError OnConnectError = {read=FOnConnectError, write=FOnConnectError};
	__property TWebCopyCancel OnCopyCancel = {read=FOnCopyCancel, write=FOnCopyCancel};
	__property TWebCopyThreadDone OnCopyDone = {read=FOnCopyDone, write=FOnCopyDone};
	__property TWebCopyOverwrite OnCopyOverWrite = {read=FOnCopyOverwrite, write=FOnCopyOverwrite};
	__property TWebCopyProgress OnCopyProgress = {read=FOnCopyProgress, write=FOnCopyProgress};
	__property TWebCopyError OnError = {read=FOnError, write=FOnError};
	__property TWebCopyErrorInfo OnErrorInfo = {read=FOnErrorInfo, write=FOnErrorInfo};
	__property TWebCopyFileDone OnFileDone = {read=FOnFileDone, write=FOnFileDone};
	__property TWebCopyFileStart OnFileStart = {read=FOnFileStart, write=FOnFileStart};
	__property TWebCopyFileDateCheck OnFileDateCheck = {read=FOnFileDateCheck, write=FOnFileDateCheck};
	__property TWebCopyMultiFTPFileDone OnMultiFTPFileDone = {read=FOnMultiFTPFileDone, write=FOnMultiFTPFileDone};
	__property TWebCopyURLNotFound OnURLNotFound = {read=FOnURLNotFound, write=FOnURLNotFound};
	__property TWebCopyNoNewFile OnNoNewFileFound = {read=FOnNoNewFile, write=FOnNoNewFile};
	__property TWebRemoveFileDone OnRemovedFile = {read=FOnRemovedFile, write=FOnRemovedFile};
	__property TWebRemoveFileFailed OnRemovedFileFailed = {read=FOnRemovedFileFailed, write=FOnRemovedFileFailed};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt errFilesIdentical = 0x0;
static const ShortInt errCannotOpenSourceFile = 0x1;
static const ShortInt errSourceFileZeroLength = 0x2;
static const ShortInt errCannotCreateTargetFile = 0x3;
static const ShortInt errCopyReadFailure = 0x4;
static const ShortInt errCopyWriteFailure = 0x5;
static const ShortInt errCannotConnect = 0x6;
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE System::UnicodeString __fastcall FileSizeFmt(unsigned Size);
extern PACKAGE System::UnicodeString __fastcall FileSizeFmtSpeed(int Size);
extern PACKAGE System::UnicodeString __fastcall TimeFmt(unsigned ticks, unsigned cursize, unsigned totsize);

}	/* namespace Webcopy */
using namespace Webcopy;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WebcopyHPP
