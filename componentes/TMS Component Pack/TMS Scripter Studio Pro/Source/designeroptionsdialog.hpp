// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'DesignerOptionsDialog.pas' rev: 22.00

#ifndef DesigneroptionsdialogHPP
#define DesigneroptionsdialogHPP

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
#include <ExtCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <FormDesigner.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Designeroptionsdialog
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmDesignerOptions;
class PASCALIMPLEMENTATION TfrmDesignerOptions : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TLabel* lblGridStep;
	Stdctrls::TLabel* lblDesignerColor;
	Stdctrls::TLabel* lblGridColor;
	Stdctrls::TCheckBox* chbDisplayGrid;
	Stdctrls::TCheckBox* chbSnapToGrid;
	Stdctrls::TEdit* edtGridStep;
	Comctrls::TUpDown* udnGridStep;
	Extctrls::TPanel* pnlDesignerColor;
	Stdctrls::TButton* btnDesignerColor;
	Extctrls::TPanel* pnlGridColor;
	Stdctrls::TButton* btnGridColor;
	Stdctrls::TButton* btnOk;
	Stdctrls::TButton* btnCancel;
	Dialogs::TColorDialog* cldMain;
	Stdctrls::TGroupBox* grbNormalGrabs;
	Extctrls::TPanel* pnlNBorder;
	Stdctrls::TButton* btnNBorder;
	Stdctrls::TLabel* lblNBorder;
	Extctrls::TPanel* pnlNFill;
	Stdctrls::TButton* btnNFill;
	Stdctrls::TLabel* lblNFill;
	Stdctrls::TGroupBox* grbLockedGrabs;
	Stdctrls::TLabel* lblLBorder;
	Stdctrls::TLabel* lblLFill;
	Extctrls::TPanel* pnlLBorder;
	Stdctrls::TButton* btnLBorder;
	Extctrls::TPanel* pnlLFill;
	Stdctrls::TButton* btnLFill;
	Stdctrls::TLabel* lblGrabSize;
	Stdctrls::TEdit* edtGrabSize;
	Comctrls::TUpDown* udnGrabSize;
	Stdctrls::TCheckBox* chbShowHint;
	Stdctrls::TCheckBox* chbShowComponentHint;
	Stdctrls::TCheckBox* chbShowNonVisual;
	void __fastcall btnDesignerColorClick(System::TObject* Sender);
	void __fastcall btnGridColorClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall btnNBorderClick(System::TObject* Sender);
	void __fastcall btnNFillClick(System::TObject* Sender);
	void __fastcall btnLBorderClick(System::TObject* Sender);
	void __fastcall btnLFillClick(System::TObject* Sender);
	
private:
	Formdesigner::TAdvCustomFormDesigner* FDesigner;
	HIDESBASE void __fastcall SetDesigner(const Formdesigner::TAdvCustomFormDesigner* Value);
	void __fastcall DesignerToControls(void);
	
public:
	__property Formdesigner::TAdvCustomFormDesigner* Designer = {read=FDesigner, write=SetDesigner};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmDesignerOptions(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmDesignerOptions(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmDesignerOptions(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmDesignerOptions(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Designeroptionsdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Designeroptionsdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DesigneroptionsdialogHPP
