// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uwaitcursor.pas' rev: 21.00

#ifndef UwaitcursorHPP
#define UwaitcursorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uwaitcursor
{
//-- type declarations -------------------------------------------------------
__interface IWaitCursor;
typedef System::DelphiInterface<IWaitCursor> _di_IWaitCursor;
__interface IWaitCursor  : public System::IInterface 
{
	
};

class DELPHICLASS TWaitCursor;
class PASCALIMPLEMENTATION TWaitCursor : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	Controls::TCursor OldCursor;
	
public:
	__fastcall TWaitCursor(void);
	__fastcall virtual ~TWaitCursor(void);
private:
	void *__IWaitCursor;	/* IWaitCursor */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator _di_IWaitCursor()
	{
		_di_IWaitCursor intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IWaitCursor*(void) { return (IWaitCursor*)&__IWaitCursor; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uwaitcursor */
using namespace Uwaitcursor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UwaitcursorHPP
