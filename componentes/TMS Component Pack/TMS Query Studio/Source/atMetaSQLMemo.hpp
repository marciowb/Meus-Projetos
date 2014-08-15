// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atMetaSQLMemo.pas' rev: 22.00

#ifndef AtmetasqlmemoHPP
#define AtmetasqlmemoHPP

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
#include <atMetaSQLAbstractEditor.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atmetasqlmemo
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmMetaSQLMemo;
class PASCALIMPLEMENTATION TfmMetaSQLMemo : public Atmetasqlabstracteditor::TfmMetaSQLAbstractEditor
{
	typedef Atmetasqlabstracteditor::TfmMetaSQLAbstractEditor inherited;
	
__published:
	Stdctrls::TMemo* mmSQL;
	
public:
	virtual void __fastcall ActivateEditor(void);
public:
	/* TCustomFrame.Create */ inline __fastcall virtual TfmMetaSQLMemo(Classes::TComponent* AOwner) : Atmetasqlabstracteditor::TfmMetaSQLAbstractEditor(AOwner) { }
	
public:
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TfmMetaSQLMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmMetaSQLMemo(HWND ParentWindow) : Atmetasqlabstracteditor::TfmMetaSQLAbstractEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atmetasqlmemo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atmetasqlmemo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtmetasqlmemoHPP
