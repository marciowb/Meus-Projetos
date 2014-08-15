// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ushldlg.pas' rev: 21.00

#ifndef UshldlgHPP
#define UshldlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ushldlg
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TFormatType { fmQuick, fmFull, fmSysOnly };
#pragma option pop

#pragma option push -b-
enum TFormatCapacity { fcDefault, fc360k, fc720k };
#pragma option pop

class DELPHICLASS TRunDialog;
class PASCALIMPLEMENTATION TRunDialog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	System::UnicodeString FTitle;
	System::UnicodeString FPrompt;
	bool FShowLast;
	
public:
	int __fastcall Execute(void);
	
__published:
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property System::UnicodeString Prompt = {read=FPrompt, write=FPrompt};
	__property bool ShowLastPrompt = {read=FShowLast, write=FShowLast, nodefault};
public:
	/* TComponent.Create */ inline __fastcall virtual TRunDialog(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TRunDialog(void) { }
	
};


class DELPHICLASS TShutDownDialog;
class PASCALIMPLEMENTATION TShutDownDialog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	int FDefaultShutDown;
	
public:
	int __fastcall Execute(void);
	
__published:
	__property int DefaultShutDown = {read=FDefaultShutDown, write=FDefaultShutDown, nodefault};
public:
	/* TComponent.Create */ inline __fastcall virtual TShutDownDialog(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TShutDownDialog(void) { }
	
};


class DELPHICLASS TChangeIconDialog;
class PASCALIMPLEMENTATION TChangeIconDialog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	System::UnicodeString Ffilename;
	int FIdx;
	unsigned __fastcall GetIconHandle(void);
	
public:
	int __fastcall Execute(void);
	__property unsigned IconHandle = {read=GetIconHandle, nodefault};
	
__published:
	__property System::UnicodeString FileName = {read=Ffilename, write=Ffilename};
	__property int IconIndex = {read=FIdx, write=FIdx, nodefault};
public:
	/* TComponent.Create */ inline __fastcall virtual TChangeIconDialog(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TChangeIconDialog(void) { }
	
};


class DELPHICLASS TFormatDialog;
class PASCALIMPLEMENTATION TFormatDialog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	int FDrive;
	TFormatCapacity FCapacity;
	TFormatType FType;
	
public:
	int __fastcall Execute(void);
	
__published:
	__property int Drive = {read=FDrive, write=FDrive, nodefault};
	__property TFormatCapacity Capacity = {read=FCapacity, write=FCapacity, nodefault};
	__property TFormatType FormatType = {read=FType, write=FType, nodefault};
public:
	/* TComponent.Create */ inline __fastcall virtual TFormatDialog(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TFormatDialog(void) { }
	
};


class DELPHICLASS TPropertyDialog;
class PASCALIMPLEMENTATION TPropertyDialog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	System::UnicodeString FFileName;
	
public:
	int __fastcall Execute(void);
	
__published:
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
public:
	/* TComponent.Create */ inline __fastcall virtual TPropertyDialog(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TPropertyDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt SHFD_CAPACITY_DEFAULT = 0x0;
static const ShortInt SHFD_CAPACITY_360 = 0x3;
static const ShortInt SHFD_CAPACITY_720 = 0x5;
static const ShortInt SHFD_FORMAT_FULL_NT = 0x0;
static const ShortInt SHFD_FORMAT_QUICK_NT = 0x1;
static const ShortInt SHFD_FORMAT_QUICK_95 = 0x0;
static const ShortInt SHFD_FORMAT_FULL_95 = 0x1;
static const ShortInt SHFD_FORMAT_SYSONLY_95 = 0x2;
extern PACKAGE int __stdcall SHShutDownDialog(int YourGuess);
extern PACKAGE int __stdcall SHRunDialog(unsigned hOwner, int Unknown1, void * Unknown2, System::WideChar * szTitle, System::WideChar * szPrompt, int uiFlags);
extern PACKAGE int __stdcall SHChangeIconDialog(unsigned hOwner, System::WideChar * szFileName, int reserved, int &lpIconIndex);
extern "C" int __stdcall SHFormatDrive(unsigned hOwner, int iDrive, int iCapacity, int iFormatType);

}	/* namespace Ushldlg */
using namespace Ushldlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UshldlgHPP
