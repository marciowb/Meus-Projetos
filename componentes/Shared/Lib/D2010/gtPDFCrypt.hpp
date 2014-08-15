// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtpdfcrypt.pas' rev: 21.00

#ifndef GtpdfcryptHPP
#define GtpdfcryptHPP

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
#include <Gtutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtpdfcrypt
{
//-- type declarations -------------------------------------------------------
typedef StaticArray<unsigned, 2> MD5Count;

typedef StaticArray<unsigned, 4> MD5State;

typedef StaticArray<unsigned, 16> MD5Block;

typedef StaticArray<System::Byte, 8> MD5CBits;

typedef StaticArray<System::Byte, 16> MD5Digest;

typedef StaticArray<System::Byte, 64> MD5Buffer;

struct MD5Context
{
	
public:
	MD5State State;
	MD5Count Count;
	MD5Buffer Buffer;
};


struct TRC4Data
{
	
public:
	StaticArray<System::Byte, 256> Key;
	StaticArray<System::Byte, 256> OrgKey;
};


#pragma option push -b-
enum TgtPDFEncryptionLevel { el40bit, el128bit };
#pragma option pop

#pragma option push -b-
enum TgtUserPermissionsType { AllowCopy, AllowModify, AllowPrint, AllowAnnotation, AllowFormFill, AllowAccessibility, AllowDocAssembly, AllowHighResPrint };
#pragma option pop

typedef Set<TgtUserPermissionsType, AllowCopy, AllowHighResPrint>  TgtUserPermissions;

typedef StaticArray<System::Byte, 4> TPermission;

class DELPHICLASS TgtPDFEncryptionSettings;
class PASCALIMPLEMENTATION TgtPDFEncryptionSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FIsOwner;
	bool FEnabled;
	TgtPDFEncryptionLevel FLevel;
	System::AnsiString FOwnerPassword;
	System::AnsiString FUserPassword;
	TgtUserPermissions FUserPermissions;
	void __fastcall SetLevel(const TgtPDFEncryptionLevel Value);
	void __fastcall SetOwnerPassword(const System::AnsiString Value);
	void __fastcall SetUserPassword(const System::AnsiString Value);
	void __fastcall SetUserPermissions(const TgtUserPermissions Value);
	void __fastcall SetEnabled(const bool Value);
	System::AnsiString __fastcall GetOwnerPassword(void);
	
public:
	__fastcall TgtPDFEncryptionSettings(void);
	__fastcall virtual ~TgtPDFEncryptionSettings(void);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property TgtPDFEncryptionLevel Level = {read=FLevel, write=SetLevel, default=1};
	__property System::AnsiString OwnerPassword = {read=GetOwnerPassword, write=SetOwnerPassword};
	__property System::AnsiString UserPassword = {read=FUserPassword, write=SetUserPassword};
	__property TgtUserPermissions UserPermissions = {read=FUserPermissions, write=SetUserPermissions, default=255};
};


class DELPHICLASS TgtBasePDFCrypt;
class PASCALIMPLEMENTATION TgtBasePDFCrypt : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TgtPDFEncryptionLevel FLevel;
	Gtutils::TgtByteArray FFileID;
	StaticArray<System::Byte, 32> FOwnerKey;
	StaticArray<System::Byte, 32> FUserKey;
	StaticArray<System::Byte, 16> FFileKey;
	TgtUserPermissions FUserPermissions;
	void __fastcall SetLevel(const TgtPDFEncryptionLevel Value);
	System::AnsiString __fastcall GetFileID(void);
	void __fastcall SetFileID(const System::AnsiString Value);
	System::AnsiString __fastcall GetOwnerKey(void);
	System::AnsiString __fastcall GetUserKey(void);
	void __fastcall SetUserKey(const System::AnsiString Value);
	void __fastcall SetOwnerKey(const System::AnsiString Value);
	
protected:
	void __fastcall PasswordPadding(const System::AnsiString AStr, System::Byte *ADest, const int ADest_Size);
	
public:
	__property TgtPDFEncryptionLevel Level = {read=FLevel, write=SetLevel, default=1};
	__property System::AnsiString FileID = {read=GetFileID, write=SetFileID};
	__property System::AnsiString OwnerKey = {read=GetOwnerKey, write=SetOwnerKey};
	__property System::AnsiString UserKey = {read=GetUserKey, write=SetUserKey};
	__property TgtUserPermissions UserPermissions = {read=FUserPermissions, default=255};
	__fastcall TgtBasePDFCrypt(void);
	__fastcall virtual ~TgtBasePDFCrypt(void);
};


class DELPHICLASS TgtPDFEncryption;
class PASCALIMPLEMENTATION TgtPDFEncryption : public TgtBasePDFCrypt
{
	typedef TgtBasePDFCrypt inherited;
	
private:
	System::AnsiString FOwnerPassword;
	System::AnsiString FUserPassword;
	StaticArray<System::Byte, 32> FOwnerPad;
	StaticArray<System::Byte, 32> FUserPad;
	TRC4Data __fastcall EncryptInit(int AObjNo, int AGenNo);
	void __fastcall MakeOwnerKey(void);
	int __fastcall GetPermissionValue(void);
	void __fastcall MakeUserKey(void);
	void __fastcall MakeFileID(System::AnsiString AFileName, System::AnsiString ACreationTime);
	void __fastcall MakeFileKey(void);
	
public:
	__fastcall TgtPDFEncryption(System::AnsiString AFileName, System::AnsiString ACreationTime, TgtPDFEncryptionSettings* Settings);
	void __fastcall EncryptBuffer(const void *ASrc, void *ADest, int ADataSize, int AObjNo, int AGenNo);
	void __fastcall EncryptStream(Classes::TMemoryStream* &AStream, int ADataSize, int AObjNo, int AGenNo);
	__property int PermissionValue = {read=GetPermissionValue, nodefault};
public:
	/* TgtBasePDFCrypt.Destroy */ inline __fastcall virtual ~TgtPDFEncryption(void) { }
	
};


class DELPHICLASS TgtPDFDecrypt;
class PASCALIMPLEMENTATION TgtPDFDecrypt : public TgtBasePDFCrypt
{
	typedef TgtBasePDFCrypt inherited;
	
private:
	StaticArray<System::Byte, 4> FPermissions;
	bool FIsOwner;
	int __fastcall CheckUserPassword(System::AnsiString AUserPassword);
	int __fastcall CheckOwnerPassword(System::AnsiString AOwnerPassword, System::AnsiString &AUserPassword);
	void __fastcall SetPermissions(const __int64 Value);
	void __fastcall SetUserPermissions(void);
	HIDESBASE void __fastcall SetUserKey(const System::AnsiString Value);
	HIDESBASE void __fastcall SetOwnerKey(const System::AnsiString Value);
	HIDESBASE void __fastcall SetFileID(const System::AnsiString Value);
	bool __fastcall IsHex(const System::AnsiString Value);
	
public:
	StaticArray<System::Byte, 16> FFileKey;
	__fastcall TgtPDFDecrypt(void);
	bool __fastcall CheckPassword(TgtPDFEncryptionSettings* &Settings, System::AnsiString Password);
	void __fastcall DecryptStream(Classes::TMemoryStream* &AStream, int ADataSize, int AObjNo, int AGenNo);
	void __fastcall DecryptString(const void *ASrc, void *ADest, int ADataSize, int AObjNo, int AGenNo);
	__property bool IsOwner = {read=FIsOwner, nodefault};
	__property __int64 Permissions = {write=SetPermissions};
	__property UserKey = {write=SetUserKey};
	__property OwnerKey = {write=SetOwnerKey};
	__property FileID = {write=SetFileID};
public:
	/* TgtBasePDFCrypt.Destroy */ inline __fastcall virtual ~TgtPDFDecrypt(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt CMaxPasswordStrLength = 0x20;
static const ShortInt Level40N = 0x5;
static const ShortInt Level128N = 0x10;
extern PACKAGE StaticArray<int, 2> EncryptLength;
extern PACKAGE StaticArray<System::Byte, 32> Padding;
extern PACKAGE void __fastcall MD5Init(MD5Context &AContext);
extern PACKAGE void __fastcall MD5Update(MD5Context &AContext, System::Byte *AInput, const int AInput_Size, unsigned ALength);
extern PACKAGE void __fastcall MD5Final(MD5Context &AContext, System::Byte *ADigest);
extern PACKAGE void __fastcall RC4Crypt(TRC4Data &AData, void * AInData, void * AOutData, int ALen);
extern PACKAGE void __fastcall RC4Init(TRC4Data &AData, void * AKey, int ALen);

}	/* namespace Gtpdfcrypt */
using namespace Gtpdfcrypt;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtpdfcryptHPP
