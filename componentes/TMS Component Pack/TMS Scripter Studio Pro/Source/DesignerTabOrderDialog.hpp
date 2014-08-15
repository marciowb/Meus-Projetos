// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'DesignerTabOrderDialog.pas' rev: 22.00

#ifndef DesignertaborderdialogHPP
#define DesignertaborderdialogHPP

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

//-- user supplied -----------------------------------------------------------

namespace Designertaborderdialog
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmTabOrder;
class PASCALIMPLEMENTATION TfrmTabOrder : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TLabel* lblControls;
	Stdctrls::TListBox* lsbControls;
	Buttons::TBitBtn* bbtMoveUp;
	Buttons::TBitBtn* bbtMoveDown;
	Stdctrls::TButton* btnOK;
	Stdctrls::TButton* btnCancel;
	void __fastcall bbtMoveUpClick(System::TObject* Sender);
	void __fastcall bbtMoveDownClick(System::TObject* Sender);
	void __fastcall lsbControlsDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall lsbControlsStartDrag(System::TObject* Sender, Controls::TDragObject* &DragObject);
	void __fastcall lsbControlsDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	
private:
	int FDragIndex;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmTabOrder(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmTabOrder(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmTabOrder(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmTabOrder(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Designertaborderdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Designertaborderdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DesignertaborderdialogHPP
