// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Mswheel.pas' rev: 21.00

#ifndef MswheelHPP
#define MswheelHPP

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
#include <Grids.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Mswheel
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TMouseWheelEvent)(int zdelta, int xpos, int ypos, int ScrollLines);

typedef void __fastcall (__closure *TOnIntelliEvent)(int zdelta, int xpos, int ypos, int ScrollLines);

class DELPHICLASS EMSWheelError;
class PASCALIMPLEMENTATION EMSWheelError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EMSWheelError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EMSWheelError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EMSWheelError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EMSWheelError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EMSWheelError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EMSWheelError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EMSWheelError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EMSWheelError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EMSWheelError(void) { }
	
};


class DELPHICLASS TMSWheel;
class PASCALIMPLEMENTATION TMSWheel : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	int wheelscrl;
	unsigned wheelmsg;
	int __fastcall ScrollLines(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	void *OldWndProc;
	void *NewWndProc;
	TMouseWheelEvent FOnWheelEvent;
	TOnIntelliEvent FOnIntelliScroll;
	TOnIntelliEvent FOnIntelliZoom;
	TOnIntelliEvent FOnIntelliPan;
	TOnIntelliEvent FOnIntelliDataZoom;
	TOnIntelliEvent FOnIntelliAutoScroll;
	bool FAuto;
	void __fastcall HookWndProc(Messages::TMessage &Msg);
	virtual int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TMSWheel(Classes::TComponent* AOwner);
	__fastcall virtual ~TMSWheel(void);
	
__published:
	__property bool Auto = {read=FAuto, write=FAuto, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TMouseWheelEvent OnWheelEvent = {read=FOnWheelEvent, write=FOnWheelEvent};
	__property TOnIntelliEvent OnIntelliScroll = {read=FOnIntelliScroll, write=FOnIntelliScroll};
	__property TOnIntelliEvent OnIntelliZoom = {read=FOnIntelliZoom, write=FOnIntelliZoom};
	__property TOnIntelliEvent OnIntelliDataZoom = {read=FOnIntelliDataZoom, write=FOnIntelliDataZoom};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Mswheel */
using namespace Mswheel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// MswheelHPP
