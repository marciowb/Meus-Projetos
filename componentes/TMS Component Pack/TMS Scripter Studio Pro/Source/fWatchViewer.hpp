// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fWatchViewer.pas' rev: 22.00

#ifndef FwatchviewerHPP
#define FwatchviewerHPP

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
#include <fWatchProperties.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fwatchviewer
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmWatchViewer;
class PASCALIMPLEMENTATION TfmWatchViewer : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TListBox* List;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ListKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall ListDblClick(System::TObject* Sender);
	
private:
	Atscript::TatCustomScripter* FScripter;
	void __fastcall CheckPlaceHolderItem(void);
	void __fastcall SetScripter(const Atscript::TatCustomScripter* Value);
	void __fastcall RefreshItem(int i);
	
public:
	void __fastcall DeleteWatch(void);
	void __fastcall EditWatch(void);
	void __fastcall AddWatch(void);
	int __fastcall AddDebugWatch(Atscript::TatDebugWatch* ADebugWatch);
	__property Atscript::TatCustomScripter* Scripter = {read=FScripter, write=SetScripter};
	HIDESBASE void __fastcall Refresh(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmWatchViewer(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmWatchViewer(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmWatchViewer(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmWatchViewer(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmWatchViewer* fmWatchViewer;

}	/* namespace Fwatchviewer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fwatchviewer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FwatchviewerHPP
