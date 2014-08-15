// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Cabfdi.pas' rev: 21.00

#ifndef CabfdiHPP
#define CabfdiHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Cabfdi
{
//-- type declarations -------------------------------------------------------
struct terf;
typedef terf *perf;

struct terf
{
	
public:
	int erfOper;
	int erfType;
	BOOL fError;
};


struct TFDICABINETINFO;
typedef TFDICABINETINFO *PFDICABINETINFO;

struct TFDICABINETINFO
{
	
public:
	int cbCabinet;
	short cFolders;
	short cFiles;
	short setID;
	short iCabinet;
	int fReserve;
	int hasprev;
	int hasnext;
};


struct TFDINOTIFICATION;
typedef TFDINOTIFICATION *PFDINOTIFICATION;

struct TFDINOTIFICATION
{
	
public:
	int cb;
	char *psz1;
	char *psz2;
	char *psz3;
	void *pv;
	unsigned hf;
	short date;
	short time;
	short attribs;
	short setID;
	short iCabinet;
	short iFolder;
	int FDIERROR;
};


//-- var, const, procedure ---------------------------------------------------
#define cabdll L"cabinet.dll"
static const ShortInt FDIERROR_NONE = 0x0;
static const ShortInt FDIERROR_CABINET_NOT_FOUND = 0x1;
static const ShortInt FDIERROR_NOT_A_CABINET = 0x2;
static const ShortInt FDIERROR_UNKNOWN_CABINET_VERSION = 0x3;
static const ShortInt FDIERROR_CORRUPT_CABINET = 0x4;
static const ShortInt FDIERROR_ALLOC_FAIL = 0x5;
static const ShortInt FDIERROR_BAD_COMPR_TYPE = 0x6;
static const ShortInt FDIERROR_MDI_FAIL = 0x7;
static const ShortInt FDIERROR_TARGET_FILE = 0x8;
static const ShortInt FDIERROR_RESERVE_MISMATCH = 0x9;
static const ShortInt FDIERROR_WRONG_CABINET = 0xa;
static const ShortInt FDIERROR_USER_ABORT = 0xb;
static const ShortInt fdintCABINET_INFO = 0x0;
static const ShortInt fdintPARTIAL_FILE = 0x1;
static const ShortInt fdintCOPY_FILE = 0x2;
static const ShortInt fdintCLOSE_FILE_INFO = 0x3;
static const ShortInt fdintNEXT_CABINET = 0x4;
static const ShortInt fdintENUMERATE = 0x5;
extern PACKAGE int __fastcall CabExtract(System::UnicodeString cabfile, System::UnicodeString targetdir);

}	/* namespace Cabfdi */
using namespace Cabfdi;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CabfdiHPP
