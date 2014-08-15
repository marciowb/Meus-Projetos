// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ueditgroupform.pas' rev: 21.00

#ifndef UeditgroupformHPP
#define UeditgroupformHPP

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
#include <Mask.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ueditgroupform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmEditGroup;
class PASCALIMPLEMENTATION TfrmEditGroup : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Buttons::TBitBtn* btnOK;
	Buttons::TBitBtn* btnCancel;
	Db::TDataSource* dsGroups;
	Stdctrls::TLabel* Label1;
	Stdctrls::TLabel* Label2;
	Dbctrls::TDBEdit* txtGroupName;
	Dbctrls::TDBEdit* txtGroupDescription;
	Extctrls::TImage* Image1;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmEditGroup(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmEditGroup(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmEditGroup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmEditGroup(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ueditgroupform */
using namespace Ueditgroupform;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UeditgroupformHPP
