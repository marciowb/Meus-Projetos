// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Designeraddcontrols.pas' rev: 21.00

#ifndef DesigneraddcontrolsHPP
#define DesigneraddcontrolsHPP

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
#include <Stdctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Designeraddcontrols
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmDesignerAddControls;
class PASCALIMPLEMENTATION TfrmDesignerAddControls : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* btnOk;
	Stdctrls::TButton* btnCancel;
	Stdctrls::TButton* btnSelectAll;
	Stdctrls::TListBox* lsbAddControls;
	void __fastcall lsvAddJobsEditing(System::TObject* Sender, Comctrls::TListItem* Item, bool &AllowEdit);
	void __fastcall btnSelectAllClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmDesignerAddControls(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmDesignerAddControls(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmDesignerAddControls(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmDesignerAddControls(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Designeraddcontrols */
using namespace Designeraddcontrols;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DesigneraddcontrolsHPP
