// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Formsize.pas' rev: 21.00

#ifndef FormsizeHPP
#define FormsizeHPP

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
#include <Forms.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Formsize
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EFormSizeError;
class PASCALIMPLEMENTATION EFormSizeError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EFormSizeError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EFormSizeError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EFormSizeError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EFormSizeError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EFormSizeError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EFormSizeError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EFormSizeError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EFormSizeError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EFormSizeError(void) { }
	
};


#pragma option push -b-
enum TPersistLocation { plIniFile, plRegistry };
#pragma option pop

class DELPHICLASS TFormSize;
class PASCALIMPLEMENTATION TFormSize : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	void *OldWndProc;
	void *NewWndProc;
	bool FSaveMachine;
	bool FSaveUser;
	bool FSavePosition;
	bool FSaveSize;
	System::UnicodeString FSaveName;
	System::UnicodeString FSaveKey;
	bool FDragAlways;
	bool FMagnet;
	bool FUnicode;
	int FMagnetDistance;
	TPersistLocation FLocation;
	System::UnicodeString __fastcall CreateKey(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	void __fastcall HookWndProc(Messages::TMessage &Msg);
	void __fastcall DoLoadPlacement(void);
	void __fastcall DoSavePlacement(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TFormSize(Classes::TComponent* AOwner);
	__fastcall virtual ~TFormSize(void);
	void __fastcall SaveFormSettings(void);
	void __fastcall LoadFormSettings(void);
	
__published:
	__property bool DragAlways = {read=FDragAlways, write=FDragAlways, default=0};
	__property TPersistLocation Location = {read=FLocation, write=FLocation, default=0};
	__property bool Magnet = {read=FMagnet, write=FMagnet, default=0};
	__property int MagnetDistance = {read=FMagnetDistance, write=FMagnetDistance, nodefault};
	__property bool SavePosition = {read=FSavePosition, write=FSavePosition, default=1};
	__property bool SaveSize = {read=FSaveSize, write=FSaveSize, default=1};
	__property bool SaveUser = {read=FSaveUser, write=FSaveUser, nodefault};
	__property bool SaveMachine = {read=FSaveMachine, write=FSaveMachine, nodefault};
	__property System::UnicodeString SaveName = {read=FSaveName, write=FSaveName};
	__property System::UnicodeString SaveKey = {read=FSaveKey, write=FSaveKey};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Formsize */
using namespace Formsize;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FormsizeHPP
