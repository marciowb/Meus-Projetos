// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uproxy.pas' rev: 21.00

#ifndef UproxyHPP
#define UproxyHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uproxy
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TuilProxy;
class PASCALIMPLEMENTATION TuilProxy : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FVisible;
	bool FEnabled;
	Classes::TNotifyEvent FSetVisible;
	Classes::TNotifyEvent FSetEnabled;
	bool FReadOnly;
	Classes::TNotifyEvent FSetReadOnly;
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetReadOnly(const bool Value);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property Classes::TNotifyEvent OnSetEnabled = {read=FSetEnabled, write=FSetEnabled};
	__property Classes::TNotifyEvent OnSetVisible = {read=FSetVisible, write=FSetVisible};
	__property Classes::TNotifyEvent OnSetReadOnly = {read=FSetReadOnly, write=FSetReadOnly};
public:
	/* TComponent.Create */ inline __fastcall virtual TuilProxy(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TuilProxy(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uproxy */
using namespace Uproxy;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UproxyHPP
