// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Asgprev.pas' rev: 21.00

#ifndef AsgprevHPP
#define AsgprevHPP

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
#include <Extctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Asgprev
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvPreviewForm;
class PASCALIMPLEMENTATION TAdvPreviewForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* Panel1;
	Extctrls::TPanel* Panel2;
	Stdctrls::TButton* Next;
	Stdctrls::TButton* Previous;
	Stdctrls::TButton* Button3;
	Stdctrls::TButton* Button4;
	Extctrls::TPaintBox* PreviewPaintBox;
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall PreviewPaintBoxPaint(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall PreviousClick(System::TObject* Sender);
	void __fastcall NextClick(System::TObject* Sender);
	
private:
	MESSAGE void __fastcall WMMinMaxInfo(Messages::TMessage &Msg);
	
public:
	Advgrid::TAdvStringGrid* Grid;
	bool PrintSelectedRows;
	bool PrintSelectedCols;
	bool PrintSelection;
	bool PrinterSetupDialog;
	bool CloseOnPrint;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvPreviewForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAdvPreviewForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvPreviewForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvPreviewForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TAdvPreviewDialog;
class PASCALIMPLEMENTATION TAdvPreviewDialog : public Dialogs::TCommonDialog
{
	typedef Dialogs::TCommonDialog inherited;
	
private:
	int FPreviewWidth;
	int FPreviewHeight;
	int FPreviewTop;
	int FPreviewLeft;
	bool FPreviewCenter;
	bool FPreviewFast;
	TAdvPreviewForm* FForm;
	Advgrid::TAdvStringGrid* FGrid;
	bool FCloseOnPrint;
	bool FPrintSelectedRows;
	System::UnicodeString FDlgNext;
	System::UnicodeString FDlgCaption;
	System::UnicodeString FDlgPrev;
	System::UnicodeString FDlgPrint;
	System::UnicodeString FDlgClose;
	bool FPrinterSetupDialog;
	bool FPrintSelection;
	bool FPrintSelectedCols;
	bool FShowMaximized;
	void __fastcall SetPreviewWidth(int value);
	void __fastcall SetPreviewHeight(int value);
	void __fastcall SetPrintSelectedRows(const bool Value);
	void __fastcall SetPrintSelection(const bool Value);
	void __fastcall SetPrintSelectedCols(const bool Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	__fastcall virtual TAdvPreviewDialog(Classes::TComponent* AOwner);
	virtual bool __fastcall Execute(void)/* overload */;
	__property TAdvPreviewForm* Form = {read=FForm};
	
__published:
	__property bool CloseAfterPrint = {read=FCloseOnPrint, write=FCloseOnPrint, nodefault};
	__property System::UnicodeString DialogCaption = {read=FDlgCaption, write=FDlgCaption};
	__property System::UnicodeString DialogPrevBtn = {read=FDlgPrev, write=FDlgPrev};
	__property System::UnicodeString DialogNextBtn = {read=FDlgNext, write=FDlgNext};
	__property System::UnicodeString DialogPrintBtn = {read=FDlgPrint, write=FDlgPrint};
	__property System::UnicodeString DialogCloseBtn = {read=FDlgClose, write=FDlgClose};
	__property Advgrid::TAdvStringGrid* Grid = {read=FGrid, write=FGrid};
	__property bool PreviewFast = {read=FPreviewFast, write=FPreviewFast, nodefault};
	__property int PreviewWidth = {read=FPreviewWidth, write=SetPreviewWidth, nodefault};
	__property int PreviewHeight = {read=FPreviewHeight, write=SetPreviewHeight, nodefault};
	__property int PreviewLeft = {read=FPreviewLeft, write=FPreviewLeft, nodefault};
	__property int PreviewTop = {read=FPreviewTop, write=FPreviewTop, nodefault};
	__property bool PreviewCenter = {read=FPreviewCenter, write=FPreviewCenter, nodefault};
	__property bool PrinterSetupDialog = {read=FPrinterSetupDialog, write=FPrinterSetupDialog, default=0};
	__property bool PrintSelectedRows = {read=FPrintSelectedRows, write=SetPrintSelectedRows, default=0};
	__property bool PrintSelectedCols = {read=FPrintSelectedCols, write=SetPrintSelectedCols, default=0};
	__property bool PrintSelection = {read=FPrintSelection, write=SetPrintSelection, default=0};
	__property bool ShowMaximized = {read=FShowMaximized, write=FShowMaximized, default=0};
public:
	/* TCommonDialog.Destroy */ inline __fastcall virtual ~TAdvPreviewDialog(void) { }
	
	
/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Dialogs::TCommonDialog::Execute(ParentWnd); }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TAdvPreviewForm* AdvPreviewForm;

}	/* namespace Asgprev */
using namespace Asgprev;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AsgprevHPP
