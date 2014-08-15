// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ap_Buttons.pas' rev: 22.00

#ifndef Ap_buttonsHPP
#define Ap_buttonsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <CommCtrl.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <ap_Types.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_buttons
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatButtonsLibrary;
class PASCALIMPLEMENTATION TatButtonsLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __TSpeedButtonActionLinkCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TSpeedButtonCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TSpeedButtonDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TSpeedButtonClick(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitBtnActionLinkCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitBtnCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitBtnDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitBtnClick(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DrawButtonFace(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatButtonsLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatButtonsLibrary(void) { }
	
};


typedef TMetaClass* TSpeedButtonActionLinkClass;

typedef TMetaClass* TSpeedButtonClass;

typedef TMetaClass* TBitBtnActionLinkClass;

typedef TMetaClass* TBitBtnClass;

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_buttons */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Ap_buttons;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_buttonsHPP
