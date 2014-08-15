// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fSimplifiedCode.pas' rev: 22.00

#ifndef FsimplifiedcodeHPP
#define FsimplifiedcodeHPP

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
#include <ComCtrls.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <atParser.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fsimplifiedcode
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmSimplifiedCode;
class PASCALIMPLEMENTATION TfmSimplifiedCode : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TListView* ListView1;
	void __fastcall FormKeyPress(System::TObject* Sender, System::WideChar &Key);
	
public:
	void __fastcall BuildSimplifiedCodeListView(Atscript::TatScript* AScript);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmSimplifiedCode(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmSimplifiedCode(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmSimplifiedCode(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmSimplifiedCode(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall pCodeViewDlg(Atscript::TatCustomScripter* AScripter);
extern PACKAGE void __fastcall CodeView(Atscript::TatScript* AScript);

}	/* namespace Fsimplifiedcode */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fsimplifiedcode;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FsimplifiedcodeHPP
