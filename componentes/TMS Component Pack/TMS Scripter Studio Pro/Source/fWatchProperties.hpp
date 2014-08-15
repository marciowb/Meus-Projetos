// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fWatchProperties.pas' rev: 22.00

#ifndef FwatchpropertiesHPP
#define FwatchpropertiesHPP

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
#include <StdCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fwatchproperties
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TWatchDialogMode { wmDebug, wmScripter };
#pragma option pop

class DELPHICLASS TfmWatchProperties;
class PASCALIMPLEMENTATION TfmWatchProperties : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TLabel* Label1;
	Stdctrls::TEdit* edExpression;
	Stdctrls::TCheckBox* chEnabled;
	Buttons::TBitBtn* btOk;
	Buttons::TBitBtn* btCancel;
	void __fastcall btOkClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	TWatchDialogMode FWatchMode;
	Atscript::TatScripterWatch* FScripterWatch;
	Atscript::TatScripterWatches* FScripterWatches;
	Atscript::TatDebugWatch* FDebugWatch;
	Atscript::TatDebugWatches* FDebugWatches;
	void __fastcall SetScripterWatch(const Atscript::TatScripterWatch* Value);
	void __fastcall SetScripterWatches(const Atscript::TatScripterWatches* Value);
	void __fastcall SetDebugWatch(const Atscript::TatDebugWatch* Value);
	void __fastcall SetDebugWatches(const Atscript::TatDebugWatches* Value);
	
public:
	__property Atscript::TatScripterWatch* ScripterWatch = {read=FScripterWatch, write=SetScripterWatch};
	__property Atscript::TatScripterWatches* ScripterWatches = {read=FScripterWatches, write=SetScripterWatches};
	__property Atscript::TatDebugWatch* DebugWatch = {read=FDebugWatch, write=SetDebugWatch};
	__property Atscript::TatDebugWatches* DebugWatches = {read=FDebugWatches, write=SetDebugWatches};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmWatchProperties(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmWatchProperties(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmWatchProperties(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmWatchProperties(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmWatchProperties* fmWatchProperties;

}	/* namespace Fwatchproperties */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fwatchproperties;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FwatchpropertiesHPP
