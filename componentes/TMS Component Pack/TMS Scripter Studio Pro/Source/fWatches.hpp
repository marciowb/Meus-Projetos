// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fWatches.pas' rev: 22.00

#ifndef FwatchesHPP
#define FwatchesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <IDEMain.hpp>	// Pascal unit

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
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fwatches;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FwatchesHPP
