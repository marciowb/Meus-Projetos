// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ezlib2.pas' rev: 21.00

#ifndef Ezlib2HPP
#define Ezlib2HPP

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

namespace Ezlib2
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct tm_zip
{
	
public:
	unsigned tm_sec;
	unsigned tm_min;
	unsigned tm_hour;
	unsigned tm_mday;
	unsigned tm_mon;
	unsigned tm_year;
};
#pragma pack(pop)


#pragma pack(push,1)
struct zip_fileinfo
{
	
public:
	tm_zip tmz_date;
	unsigned dosDate;
	unsigned internal_fa;
	unsigned external_fa;
};
#pragma pack(pop)


typedef zip_fileinfo *Pzip_fileinfo;

#pragma pack(push,1)
struct unz_file_info
{
	
public:
	unsigned version;
	unsigned version_needed;
	unsigned flag;
	unsigned compression_method;
	unsigned dosDate;
	unsigned crc;
	unsigned compressed_size;
	unsigned uncompressed_size;
	unsigned size_filename;
	unsigned size_file_extra;
	unsigned size_file_comment;
	unsigned disk_num_start;
	unsigned internal_fa;
	unsigned external_fa;
	tm_zip tmu_date;
};
#pragma pack(pop)


typedef unz_file_info *Punz_file_info;

#pragma pack(push,1)
struct unz_global_info
{
	
public:
	unsigned number_entry;
	unsigned size_comment;
};
#pragma pack(pop)


typedef unz_global_info *Punz_global_info;

typedef void * __fastcall (*TZAlloc)(void * opaque, int items, int size);

typedef void __fastcall (*TZFree)(void * opaque, void * block);

#pragma pack(push,1)
struct TZStreamRec
{
	
public:
	char *next_in;
	int avail_in;
	int total_in;
	char *next_out;
	int avail_out;
	int total_out;
	char *msg;
	void *state;
	TZAlloc zalloc;
	TZFree zfree;
	void *opaque;
	int data_type;
	int adler;
	int reserved;
};
#pragma pack(pop)


class DELPHICLASS EZLibError;
class PASCALIMPLEMENTATION EZLibError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EZLibError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EZLibError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EZLibError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EZLibError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EZLibError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EZLibError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EZLibError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EZLibError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EZLibError(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define ZLIB_VERSION L"1.2.3"
extern PACKAGE StaticArray<char *, 10> _z_errmsg;
static const int WRITEBUFFERSIZE = 0x10000;
static const ShortInt Z_NO_FLUSH = 0x0;
static const ShortInt Z_PARTIAL_FLUSH = 0x1;
static const ShortInt Z_SYNC_FLUSH = 0x2;
static const ShortInt Z_FULL_FLUSH = 0x3;
static const ShortInt Z_FINISH = 0x4;
static const ShortInt Z_OK = 0x0;
static const ShortInt Z_STREAM_END = 0x1;
static const ShortInt Z_NEED_DICT = 0x2;
static const ShortInt Z_ERRNO = -1;
static const ShortInt Z_STREAM_ERROR = -2;
static const ShortInt Z_DATA_ERROR = -3;
static const ShortInt Z_MEM_ERROR = -4;
static const ShortInt Z_BUF_ERROR = -5;
static const ShortInt Z_VERSION_ERROR = -6;
static const ShortInt Z_NO_COMPRESSION = 0x0;
static const ShortInt Z_BEST_SPEED = 0x1;
static const ShortInt Z_BEST_COMPRESSION = 0x9;
static const ShortInt Z_DEFAULT_COMPRESSION = -1;
static const ShortInt ZIP_OK = 0x0;
static const ShortInt UNZ_OK = 0x0;
static const ShortInt UNZ_END_OF_LIST_OF_FILE = -100;
static const ShortInt UNZ_ERRNO = -1;
static const ShortInt UNZ_EOF = 0x0;
static const ShortInt UNZ_PARAMERROR = -102;
static const ShortInt UNZ_BADZIPFILE = -103;
static const ShortInt UNZ_INTERNALERROR = -104;
static const ShortInt UNZ_CRCERROR = -105;
extern PACKAGE void __fastcall ZCompress(const void * inBuffer, int inSize, /* out */ void * &outBuffer, /* out */ int &outSize);
extern PACKAGE void __fastcall ZDecompress(const void * inBuffer, int inSize, /* out */ void * &outBuffer, /* out */ int &outSize);
extern PACKAGE unsigned __fastcall CreateZipFile(char * ZipFile);
extern PACKAGE bool __fastcall AddZipFile(unsigned ZipHandle, char * FileToZip, char * FileName, char * Password);
extern PACKAGE bool __fastcall CloseZipFile(unsigned ZipHandle);
extern PACKAGE bool __fastcall ExtractZipFiles(char * ZipFile, char * OutputDir, char * Password);
extern PACKAGE unsigned __fastcall zipOpen(const char * pathname, int append);
extern PACKAGE int __fastcall zipOpenNewFileInZip3(unsigned hFile, const char * filename, Pzip_fileinfo zipfi, const void * extrafield_local, unsigned size_extrafield_local, const void * extrafield_global, unsigned size_extrafield_global, const char * comment, int method, int level, int raw, int windowBits, int memLevel, int strategy, const char * password, unsigned crcForCrypting);
extern PACKAGE int __fastcall zipWriteInFileInZip(unsigned hFile, void *buf, unsigned len);
extern PACKAGE int __fastcall zipCloseFileInZip(unsigned hFile);
extern PACKAGE int __fastcall zipClose(unsigned hFile, const char * global_comment);
extern PACKAGE int __fastcall unzOpen(const char * path);
extern PACKAGE int __fastcall unzGetGlobalInfo(unsigned hFile, Punz_global_info pglobal_info);
extern PACKAGE int __fastcall unzGetCurrentFileInfo(unsigned hFile, Punz_file_info pfile_info, const char * szFileName, unsigned fileNameBufferSize, void * extraField, unsigned extraFieldBufferSize, const char * szComment, unsigned commentBufferSize);
extern PACKAGE int __fastcall unzGoToNextFile(unsigned hFile);
extern PACKAGE int __fastcall unzOpenCurrentFilePassword(unsigned hFile, const char * password);
extern PACKAGE int __fastcall unzReadCurrentFile(unsigned hFile, void *buf, unsigned len);
extern PACKAGE int __fastcall unzCloseCurrentFile(unsigned hFile);
extern PACKAGE int __fastcall adler32(int adler, const char * buf, int len);
extern PACKAGE int __fastcall compressBound(int sourceLen);
extern PACKAGE unsigned __fastcall crc32(unsigned crc, const void *buf, unsigned len);
extern PACKAGE int __fastcall deflateInit_(TZStreamRec &strm, int level, char * version, int recsize);
extern PACKAGE int __fastcall deflate(TZStreamRec &strm, int flush);
extern PACKAGE int __fastcall deflateEnd(TZStreamRec &strm);
extern PACKAGE int __fastcall inflateBackInit_(TZStreamRec &strm, int windowBits, void * window, char * version, int stream_size);
extern PACKAGE int __fastcall inflateBack(TZStreamRec &strm, void * infunc, void * in_desc, void * outfunc, void * out_desc);
extern PACKAGE int __fastcall inflateBackEnd(TZStreamRec &strm);
extern PACKAGE int __fastcall inflateReset(TZStreamRec &strm);
extern PACKAGE int __fastcall inflateInit_(TZStreamRec &strm, char * version, int recsize);
extern PACKAGE int __fastcall inflate(TZStreamRec &strm, int flush);
extern PACKAGE int __fastcall inflateEnd(TZStreamRec &strm);

}	/* namespace Ezlib2 */
using namespace Ezlib2;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ezlib2HPP
