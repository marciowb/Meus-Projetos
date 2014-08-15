// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wupdatewiz.pas' rev: 21.00

#ifndef WupdatewizHPP
#define WupdatewizHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Wupdate.hpp>	// Pascal unit
#include <Wuwizform.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wupdatewiz
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TWebUpdateWizardLanguage;
class PASCALIMPLEMENTATION TWebUpdateWizardLanguage : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	System::UnicodeString FStartButton;
	System::UnicodeString FWelcome;
	System::UnicodeString FGetUpdateButton;
	System::UnicodeString FRestartButton;
	System::UnicodeString FNewVersion;
	System::UnicodeString FNextButton;
	System::UnicodeString FNewVersionFound;
	System::UnicodeString FExitButton;
	System::UnicodeString FCurrentVersion;
	System::UnicodeString FNoNewVersionAvail;
	System::UnicodeString FNoFilesFound;
	System::UnicodeString FCannotConnect;
	System::UnicodeString FNoUpdateOnServer;
	System::UnicodeString FNewVersionAvail;
	System::UnicodeString FWhatsNew;
	System::UnicodeString FComponentsAvail;
	System::UnicodeString FRestartInfo;
	System::UnicodeString FDownLoadingFiles;
	System::UnicodeString FCurrentProgress;
	System::UnicodeString FNotAcceptLicense;
	System::UnicodeString FTotalProgress;
	System::UnicodeString FUpdateComplete;
	System::UnicodeString FLicense;
	System::UnicodeString FAcceptLicense;
	System::UnicodeString FCancelButton;
	System::UnicodeString FFailedDownload;
	System::UnicodeString FWhatsNewPopup;
	System::UnicodeString FLicensePopup;
	
public:
	__fastcall virtual TWebUpdateWizardLanguage(Classes::TComponent* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Welcome = {read=FWelcome, write=FWelcome};
	__property System::UnicodeString StartButton = {read=FStartButton, write=FStartButton};
	__property System::UnicodeString NextButton = {read=FNextButton, write=FNextButton};
	__property System::UnicodeString ExitButton = {read=FExitButton, write=FExitButton};
	__property System::UnicodeString RestartButton = {read=FRestartButton, write=FRestartButton};
	__property System::UnicodeString CancelButton = {read=FCancelButton, write=FCancelButton};
	__property System::UnicodeString FailedDownload = {read=FFailedDownload, write=FFailedDownload};
	__property System::UnicodeString GetUpdateButton = {read=FGetUpdateButton, write=FGetUpdateButton};
	__property System::UnicodeString NewVersionFound = {read=FNewVersionFound, write=FNewVersionFound};
	__property System::UnicodeString NewVersion = {read=FNewVersion, write=FNewVersion};
	__property System::UnicodeString NoNewVersionAvail = {read=FNoNewVersionAvail, write=FNoNewVersionAvail};
	__property System::UnicodeString NewVersionAvail = {read=FNewVersionAvail, write=FNewVersionAvail};
	__property System::UnicodeString CurrentVersion = {read=FCurrentVersion, write=FCurrentVersion};
	__property System::UnicodeString NoFilesFound = {read=FNoFilesFound, write=FNoFilesFound};
	__property System::UnicodeString NoUpdateOnServer = {read=FNoUpdateOnServer, write=FNoUpdateOnServer};
	__property System::UnicodeString CannotConnect = {read=FCannotConnect, write=FCannotConnect};
	__property System::UnicodeString WhatsNew = {read=FWhatsNew, write=FWhatsNew};
	__property System::UnicodeString License = {read=FLicense, write=FLicense};
	__property System::UnicodeString AcceptLicense = {read=FAcceptLicense, write=FAcceptLicense};
	__property System::UnicodeString NotAcceptLicense = {read=FNotAcceptLicense, write=FNotAcceptLicense};
	__property System::UnicodeString ComponentsAvail = {read=FComponentsAvail, write=FComponentsAvail};
	__property System::UnicodeString DownloadingFiles = {read=FDownLoadingFiles, write=FDownLoadingFiles};
	__property System::UnicodeString CurrentProgress = {read=FCurrentProgress, write=FCurrentProgress};
	__property System::UnicodeString TotalProgress = {read=FTotalProgress, write=FTotalProgress};
	__property System::UnicodeString UpdateComplete = {read=FUpdateComplete, write=FUpdateComplete};
	__property System::UnicodeString RestartInfo = {read=FRestartInfo, write=FRestartInfo};
	__property System::UnicodeString WhatsNewPopup = {read=FWhatsNewPopup, write=FWhatsNewPopup};
	__property System::UnicodeString LicensePopup = {read=FLicensePopup, write=FLicensePopup};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TWebUpdateWizardLanguage(void) { }
	
};


class DELPHICLASS TWebUpdateWizard;
class PASCALIMPLEMENTATION TWebUpdateWizard : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Wuwizform::TWUWIZ* FWuWiz;
	Wupdate::TWebUpdate* FWebUpdate;
	System::UnicodeString FCaption;
	Forms::TPosition FPosition;
	Forms::TFormBorderStyle FBorderStyle;
	bool FAutoRun;
	bool FAutoStart;
	Graphics::TBitmap* FBillBoard;
	Graphics::TFont* FFont;
	TWebUpdateWizardLanguage* FWizardLanguage;
	bool FBillBoardStretch;
	bool FBillBoardCenter;
	int FBillBoardTop;
	int FBillBoardLeft;
	int FBillBoardHeight;
	int FBillBoardWidth;
	void __fastcall SetBillboard(const Graphics::TBitmap* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	__fastcall virtual TWebUpdateWizard(Classes::TComponent* AOwner);
	__fastcall virtual ~TWebUpdateWizard(void);
	void __fastcall Execute(bool InitPath = true);
	void __fastcall InitLanguage(Wuwizform::TWUWIZ* AWizard, TWebUpdateWizardLanguage* ALanguage);
	void __fastcall CloseWizard(void);
	
__published:
	__property bool AutoStart = {read=FAutoStart, write=FAutoStart, default=0};
	__property bool AutoRun = {read=FAutoRun, write=FAutoRun, default=0};
	__property Graphics::TBitmap* BillBoard = {read=FBillBoard, write=SetBillboard};
	__property bool BillBoardStretch = {read=FBillBoardStretch, write=FBillBoardStretch, default=0};
	__property bool BillBoardCenter = {read=FBillBoardCenter, write=FBillBoardCenter, default=0};
	__property int BillBoardTop = {read=FBillBoardTop, write=FBillBoardTop, default=27};
	__property int BillBoardLeft = {read=FBillBoardLeft, write=FBillBoardLeft, default=9};
	__property int BillBoardHeight = {read=FBillBoardHeight, write=FBillBoardHeight, default=201};
	__property int BillBoardWidth = {read=FBillBoardWidth, write=FBillBoardWidth, default=116};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TWebUpdateWizardLanguage* Language = {read=FWizardLanguage, write=FWizardLanguage};
	__property Forms::TPosition Position = {read=FPosition, write=FPosition, default=4};
	__property Wupdate::TWebUpdate* WebUpdate = {read=FWebUpdate, write=FWebUpdate};
	__property Forms::TFormBorderStyle BorderStyle = {read=FBorderStyle, write=FBorderStyle, default=3};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Wupdatewiz */
using namespace Wupdatewiz;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WupdatewizHPP
