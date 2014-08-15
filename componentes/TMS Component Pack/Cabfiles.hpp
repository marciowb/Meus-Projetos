// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Cabfiles.pas' rev: 21.00

#ifndef CabfilesHPP
#define CabfilesHPP

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

//-- user supplied -----------------------------------------------------------

namespace Cabfiles
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS ECABFileError;
class PASCALIMPLEMENTATION ECABFileError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ECABFileError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ECABFileError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ECABFileError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall ECABFileError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ECABFileError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ECABFileError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ECABFileError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ECABFileError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ECABFileError(void) { }
	
};


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
	int hf;
	short date;
	short time;
	short attribs;
	short setID;
	short iCabinet;
	short iFolder;
	int FDIERROR;
};


struct TCCAB;
typedef TCCAB *PCCAB;

struct TCCAB
{
	
public:
	int cb;
	int cbFolderThresh;
	int cbReserveCFHeader;
	int cbReserveCFFolder;
	int cbReserveCFData;
	int iCab;
	int iDisk;
	BOOL fFailOnIncompressible;
	short setID;
	StaticArray<char, 256> szDisk;
	StaticArray<char, 256> szCab;
	StaticArray<char, 256> szCabPath;
};


#pragma option push -b-
enum TProcessMode { pmContents, pmExtractAll, pmExtractFile, pmExtractSelected };
#pragma option pop

class DELPHICLASS TCABFileEntry;
class PASCALIMPLEMENTATION TCABFileEntry : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	__int64 FSize;
	System::TDateTime FDate;
	bool FSelected;
	System::UnicodeString FRelPath;
	bool FDateCorrect;
	
public:
	__fastcall virtual TCABFileEntry(Classes::TCollection* Collection);
	__fastcall virtual ~TCABFileEntry(void);
	__property __int64 Size = {read=FSize, write=FSize};
	__property System::TDateTime Date = {read=FDate, write=FDate};
	__property bool DateCorrect = {read=FDateCorrect, write=FDateCorrect, nodefault};
	__property bool Selected = {read=FSelected, write=FSelected, nodefault};
	
__published:
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property System::UnicodeString RelPath = {read=FRelPath, write=FRelPath};
};


class DELPHICLASS TCABFileContents;
class DELPHICLASS TCABFile;
class PASCALIMPLEMENTATION TCABFileContents : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
private:
	TCABFile* FOwner;
	HIDESBASE TCABFileEntry* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TCABFileEntry* Value);
	
public:
	__fastcall TCABFileContents(TCABFile* AOwner);
	void __fastcall AddFolder(System::UnicodeString FileSpec);
	void __fastcall AddRelFolder(System::UnicodeString FileSpec, System::UnicodeString RelativePath);
	void __fastcall AddFiles(System::UnicodeString FileSpec, System::UnicodeString RelativePath, bool SubDirectory = false);
	HIDESBASE TCABFileEntry* __fastcall Add(void);
	HIDESBASE TCABFileEntry* __fastcall Insert(int index);
	__property TCABFileEntry* Items[int Index] = {read=GetItem, write=SetItem};
	bool __fastcall IsInList(System::AnsiString s);
	bool __fastcall IsSelected(System::AnsiString s);
	void __fastcall SelectAll(void);
	void __fastcall SelectNone(void);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TCABFileContents(void) { }
	
};


#pragma option push -b-
enum TCompressionType { typNone, typMSZIP, typLZX };
#pragma option pop

typedef void __fastcall (__closure *TCompressProgress)(System::TObject* Sender, __int64 pos, __int64 tot);

typedef void __fastcall (__closure *TDeCompressProgress)(System::TObject* Sender, System::UnicodeString FileName, __int64 pos, __int64 tot);

typedef void __fastcall (__closure *TOverWriteFile)(System::TObject* Sender, System::UnicodeString FileName, bool &Allow);

#pragma option push -b-
enum TLZXMemory { lzxLowest, lzxLower, lzxLow, lzxMedium, lzxHigh, lzxHigher, lzxHighest };
#pragma option pop

class PASCALIMPLEMENTATION TCABFile : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TCABFileContents* FCABFileContents;
	System::UnicodeString FCABFile;
	System::UnicodeString FExtractFile;
	System::UnicodeString FTargetPath;
	__int64 FTotSizeFiles;
	__int64 FTotSizeCompress;
	__int64 FTotSizeProgress;
	__int64 FTotFileSizeDecompress;
	__int64 FCurFileSizeDecompress;
	System::UnicodeString FCurFileNameDecompress;
	TProcessMode FProcessMode;
	TCompressionType FCompressionType;
	TLZXMemory FLZXMemory;
	TCompressProgress FOnCompressProgress;
	TDeCompressProgress FOnDeCompressProgress;
	TOverWriteFile FOnOverWriteFile;
	double __fastcall GetCompressionRatio(void);
	int __fastcall DecompressCABFile(void);
	int __fastcall CompressCABFile(void);
	void __fastcall Error(int err, int errt);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	int __fastcall GetVersionNr(void);
	void __fastcall CompressProgress(__int64 pos, __int64 tot);
	
public:
	__fastcall virtual TCABFile(Classes::TComponent* AOwner);
	__fastcall virtual ~TCABFile(void);
	void __fastcall GetContents(void);
	bool __fastcall ExtractAll(void);
	bool __fastcall ExtractSelected(void);
	bool __fastcall ExtractFile(const System::UnicodeString FName);
	bool __fastcall Compress(void);
	bool __fastcall MakeSFX(void);
	bool __fastcall ConvertToSFX(void);
	__property double CompressionRatio = {read=GetCompressionRatio};
	__property __int64 CompressedSize = {read=FTotSizeCompress};
	__property __int64 OriginalSize = {read=FTotSizeFiles};
	
__published:
	__property TCABFileContents* CABFileContents = {read=FCABFileContents, write=FCABFileContents};
	__property System::UnicodeString CABFile = {read=FCABFile, write=FCABFile};
	__property TCompressionType CompressionType = {read=FCompressionType, write=FCompressionType, nodefault};
	__property TLZXMemory LZXMemory = {read=FLZXMemory, write=FLZXMemory, nodefault};
	__property System::UnicodeString TargetPath = {read=FTargetPath, write=FTargetPath};
	__property TCompressProgress OnCompressProgress = {read=FOnCompressProgress, write=FOnCompressProgress};
	__property TDeCompressProgress OnDecompressProgress = {read=FOnDeCompressProgress, write=FOnDeCompressProgress};
	__property TOverWriteFile OnOverWriteFile = {read=FOnOverWriteFile, write=FOnOverWriteFile};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
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
static const ShortInt FCIERR_NONE = 0x0;
static const ShortInt FCIERR_OPEN_SRC = 0x1;
static const ShortInt FCIERR_READ_SRC = 0x2;
static const ShortInt FCIERR_ALLOC_FAIL = 0x3;
static const ShortInt FCIERR_TEMP_FILE = 0x4;
static const ShortInt FCIERR_BAD_COMPR_TYPE = 0x5;
static const ShortInt FCIERR_CAB_FILE = 0x6;
static const ShortInt FCIERR_USER_ABORT = 0x7;
static const ShortInt FCIERR_MCI_FAIL = 0x8;
static const ShortInt fdintCABINET_INFO = 0x0;
static const ShortInt fdintPARTIAL_FILE = 0x1;
static const ShortInt fdintCOPY_FILE = 0x2;
static const ShortInt fdintCLOSE_FILE_INFO = 0x3;
static const ShortInt fdintNEXT_CABINET = 0x4;
static const ShortInt fdintENUMERATE = 0x5;
static const Word CB_MAX_CHUNK = 0x8000;
static const int CB_MAX_DISK = 0x7fffffff;
static const Word CB_MAX_FILENAME = 0x100;
static const Word CB_MAX_CABINET_NAME = 0x100;
static const Word CB_MAX_CAB_PATH = 0x100;
static const Word CB_MAX_DISK_NAME = 0x100;
static const int FOLDER_THRESHOLD = 0xdbba0;
static const ShortInt statusFile = 0x0;
static const ShortInt statusFolder = 0x1;
static const ShortInt statusCabinet = 0x2;
static const Word O_CREAT = 0x100;
static const Word O_TRUNC = 0x200;
static const Word O_EXCL = 0x400;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x3;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Cabfiles */
using namespace Cabfiles;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CabfilesHPP
