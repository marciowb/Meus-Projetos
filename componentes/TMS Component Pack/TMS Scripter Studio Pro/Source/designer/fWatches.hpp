// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Fwatches.pas' rev: 21.00

#ifndef FwatchesHPP
#define FwatchesHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Idemain.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fwatches
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmWatches;
class PASCALIMPLEMENTATION TfmWatches : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Idemain::TIDEWatchListView* IDEWatchListView;
	
private:
	Idemain::TIDEEngine* __fastcall GetEngine(void);
	void __fastcall SetEngine(const Idemain::TIDEEngine* Value);
	
public:
	__property Idemain::TIDEEngine* Engine = {read=GetEngine, write=SetEngine};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmWatches(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmWatches(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmWatches(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmWatches(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Fwatches */
using namespace Fwatches;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FwatchesHPP
