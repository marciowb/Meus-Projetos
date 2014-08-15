// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Exeinfo.pas' rev: 21.00

#ifndef ExeinfoHPP
#define ExeinfoHPP

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
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Exeinfo
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TExeInfo;
class PASCALIMPLEMENTATION TExeInfo : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	System::UnicodeString FCompanyName;
	System::UnicodeString FFileDescription;
	System::UnicodeString FFileVersion;
	System::UnicodeString FInternalName;
	System::UnicodeString FLegalCopyright;
	System::UnicodeString FLegalTradeMark;
	System::UnicodeString FOriginalFileName;
	System::UnicodeString FProductName;
	System::UnicodeString FProductVersion;
	System::UnicodeString FComments;
	System::UnicodeString FComputerName;
	System::UnicodeString FOsName;
	System::UnicodeString FWindowsDir;
	System::UnicodeString FSystemDir;
	System::UnicodeString FTempDir;
	int FFileFlags;
	int FFileOS;
	int FFileType;
	System::TDateTime FFileCreation;
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetFileVersionInt(void);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall GetVersionInfo(void);
	virtual System::UnicodeString __fastcall GetComputerName(void);
	virtual void __fastcall SetComputerName(System::UnicodeString Name);
	System::UnicodeString __fastcall GetWinDir(void);
	System::UnicodeString __fastcall GetSysDir(void);
	System::UnicodeString __fastcall GetTempDir(void);
	
public:
	void __fastcall GetVersionInfoOfApp(const System::UnicodeString AAppName);
	__fastcall virtual TExeInfo(Classes::TComponent* AOwner);
	__property int FileFlags = {read=FFileFlags, nodefault};
	__property int FileOS = {read=FFileOS, nodefault};
	__property int FileType = {read=FFileType, nodefault};
	__property System::TDateTime FileCreation = {read=FFileCreation};
	virtual System::UnicodeString __fastcall GetOperatingSystem(void);
	__property int FileVersionInt = {read=GetFileVersionInt, nodefault};
	
__published:
	__property System::UnicodeString CompanyName = {read=FCompanyName, write=FCompanyName, stored=false};
	__property System::UnicodeString FileDescription = {read=FFileDescription, write=FFileDescription, stored=false};
	__property System::UnicodeString FileVersion = {read=FFileVersion, write=FFileVersion, stored=false};
	__property System::UnicodeString InternalName = {read=FInternalName, write=FInternalName, stored=false};
	__property System::UnicodeString LegalCopyright = {read=FLegalCopyright, write=FLegalCopyright, stored=false};
	__property System::UnicodeString LegalTradeMark = {read=FLegalTradeMark, write=FLegalTradeMark, stored=false};
	__property System::UnicodeString OriginalFileName = {read=FOriginalFileName, write=FOriginalFileName, stored=false};
	__property System::UnicodeString ProductName = {read=FProductName, write=FProductName, stored=false};
	__property System::UnicodeString ProductVersion = {read=FProductVersion, write=FProductVersion, stored=false};
	__property System::UnicodeString Comments = {read=FComments, write=FComments, stored=false};
	__property System::UnicodeString ComputerName = {read=GetComputerName, write=SetComputerName, stored=false};
	__property System::UnicodeString OSName = {read=GetOperatingSystem, write=FOsName, stored=false};
	__property System::UnicodeString WindowsDir = {read=GetWinDir, write=FWindowsDir, stored=false};
	__property System::UnicodeString SystemDir = {read=GetSysDir, write=FSystemDir, stored=false};
	__property System::UnicodeString TempDir = {read=GetTempDir, write=FTempDir, stored=false};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TExeInfo(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Exeinfo */
using namespace Exeinfo;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ExeinfoHPP
