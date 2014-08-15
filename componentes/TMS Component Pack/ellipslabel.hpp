// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ellipslabel.pas' rev: 21.00

#ifndef EllipslabelHPP
#define EllipslabelHPP

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
#include <Stdctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ellipslabel
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TEllipsType { etNone, etEndEllips, etPathEllips };
#pragma option pop

class DELPHICLASS TEllipsLabel;
class PASCALIMPLEMENTATION TEllipsLabel : public Stdctrls::TLabel
{
	typedef Stdctrls::TLabel inherited;
	
private:
	TEllipsType FEllipsType;
	void __fastcall SetEllipsType(const TEllipsType Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall Paint(void);
	
__published:
	__property TEllipsType EllipsType = {read=FEllipsType, write=SetEllipsType, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TCustomLabel.Create */ inline __fastcall virtual TEllipsLabel(Classes::TComponent* AOwner) : Stdctrls::TLabel(AOwner) { }
	
public:
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TEllipsLabel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Ellipslabel */
using namespace Ellipslabel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EllipslabelHPP
