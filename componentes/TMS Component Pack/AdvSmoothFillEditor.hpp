// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothfilleditor.pas' rev: 21.00

#ifndef AdvsmoothfilleditorHPP
#define AdvsmoothfilleditorHPP

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
#include <Gdipfill.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Advsmoothfillpreview.hpp>	// Pascal unit
#include <Advsmoothselectors.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Advsmoothspin.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothfilleditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvSmoothFillEditorForm;
class PASCALIMPLEMENTATION TAdvSmoothFillEditorForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* Button1;
	Stdctrls::TGroupBox* GroupBox1;
	Stdctrls::TLabel* Label2;
	Advsmoothselectors::TAdvSmoothColorSelector* AdvSmoothColorSelector1;
	Advsmoothselectors::TAdvSmoothColorSelector* AdvSmoothColorSelector2;
	Stdctrls::TLabel* Label3;
	Stdctrls::TLabel* Label4;
	Stdctrls::TLabel* Label5;
	Advsmoothselectors::TAdvSmoothColorSelector* AdvSmoothColorSelector3;
	Advsmoothselectors::TAdvSmoothColorSelector* AdvSmoothColorSelector4;
	Stdctrls::TLabel* Label6;
	Stdctrls::TComboBox* ComboBox1;
	Stdctrls::TComboBox* ComboBox2;
	Stdctrls::TLabel* Label7;
	Stdctrls::TLabel* Label8;
	Stdctrls::TComboBox* ComboBox3;
	Stdctrls::TComboBox* ComboBox4;
	Stdctrls::TLabel* Label9;
	Dialogs::TOpenDialog* OpenDialog1;
	Stdctrls::TLabel* Label10;
	Stdctrls::TButton* Button2;
	Stdctrls::TButton* Button3;
	Stdctrls::TButton* Button4;
	Dialogs::TColorDialog* ColorDialog1;
	Stdctrls::TLabel* Label11;
	Stdctrls::TComboBox* ComboBox5;
	Stdctrls::TLabel* Label12;
	Stdctrls::TLabel* Label13;
	Stdctrls::TLabel* Label14;
	Stdctrls::TLabel* Label15;
	Stdctrls::TLabel* Label16;
	Stdctrls::TLabel* Label17;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit5;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit6;
	Stdctrls::TGroupBox* GroupBox2;
	Stdctrls::TLabel* Label18;
	Stdctrls::TButton* Button5;
	Stdctrls::TButton* Button6;
	Stdctrls::TComboBox* ComboBox6;
	Stdctrls::TLabel* Label19;
	Stdctrls::TLabel* Label20;
	Stdctrls::TLabel* Label21;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit7;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit8;
	Stdctrls::TLabel* Label22;
	Stdctrls::TComboBox* ComboBox7;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit9;
	Stdctrls::TLabel* Label23;
	Stdctrls::TLabel* Label24;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit10;
	Stdctrls::TGroupBox* GroupBox3;
	Stdctrls::TLabel* Label25;
	Advsmoothselectors::TAdvSmoothColorSelector* AdvSmoothColorSelector5;
	Stdctrls::TLabel* Label26;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit11;
	Stdctrls::TLabel* Label27;
	Stdctrls::TComboBox* ComboBox8;
	Stdctrls::TLabel* Label28;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit12;
	Stdctrls::TGroupBox* GroupBox4;
	Stdctrls::TLabel* Label29;
	Stdctrls::TLabel* Label30;
	Advsmoothselectors::TAdvSmoothColorSelector* AdvSmoothColorSelector6;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit13;
	Stdctrls::TLabel* Label31;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit14;
	Comctrls::TTrackBar* TrackBar1;
	Comctrls::TTrackBar* TrackBar2;
	Comctrls::TTrackBar* TrackBar3;
	Comctrls::TTrackBar* TrackBar4;
	Stdctrls::TLabel* Label32;
	Stdctrls::TLabel* Label33;
	Stdctrls::TLabel* Label34;
	Stdctrls::TLabel* Label35;
	Stdctrls::TGroupBox* GroupBox5;
	Stdctrls::TLabel* Label1;
	Comctrls::TTrackBar* TrackBar5;
	Stdctrls::TLabel* Label36;
	Buttons::TSpeedButton* SpeedButton1;
	Buttons::TSpeedButton* SpeedButton2;
	Stdctrls::TComboBox* ComboBox9;
	Stdctrls::TLabel* Label37;
	Stdctrls::TGroupBox* GroupBox6;
	Stdctrls::TLabel* Label38;
	Advsmoothselectors::TAdvSmoothColorSelector* AdvSmoothColorSelector7;
	Stdctrls::TLabel* Label39;
	Advsmoothselectors::TAdvSmoothColorSelector* AdvSmoothColorSelector8;
	Stdctrls::TLabel* Label40;
	Stdctrls::TComboBox* ComboBox10;
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall AdvSmoothColorSelector1Select(System::TObject* Sender, int Index, Advsmoothselectors::TAdvSmoothSelectorItem* Item);
	void __fastcall AdvSmoothColorSelector3Select(System::TObject* Sender, int Index, Advsmoothselectors::TAdvSmoothSelectorItem* Item);
	void __fastcall AdvSmoothColorSelector2Select(System::TObject* Sender, int Index, Advsmoothselectors::TAdvSmoothSelectorItem* Item);
	void __fastcall AdvSmoothColorSelector4Select(System::TObject* Sender, int Index, Advsmoothselectors::TAdvSmoothSelectorItem* Item);
	void __fastcall AdvSmoothSpinEdit2Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit3Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit4Change(System::TObject* Sender);
	void __fastcall ComboBox1Change(System::TObject* Sender);
	void __fastcall ComboBox2Change(System::TObject* Sender);
	void __fastcall ComboBox3Change(System::TObject* Sender);
	void __fastcall ComboBox4Change(System::TObject* Sender);
	void __fastcall ComboBox5Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit5Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit6Change(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Button5Click(System::TObject* Sender);
	void __fastcall Button6Click(System::TObject* Sender);
	void __fastcall ComboBox7Change(System::TObject* Sender);
	void __fastcall ComboBox6Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit7Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit8Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit9Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit10Change(System::TObject* Sender);
	void __fastcall AdvSmoothColorSelector5Select(System::TObject* Sender, int Index, Advsmoothselectors::TAdvSmoothSelectorItem* Item);
	void __fastcall AdvSmoothSpinEdit11Change(System::TObject* Sender);
	void __fastcall ComboBox8Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit12Change(System::TObject* Sender);
	void __fastcall AdvSmoothColorSelector6Select(System::TObject* Sender, int Index, Advsmoothselectors::TAdvSmoothSelectorItem* Item);
	void __fastcall AdvSmoothSpinEdit13Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit14Change(System::TObject* Sender);
	void __fastcall TrackBar1Change(System::TObject* Sender);
	void __fastcall TrackBar2Change(System::TObject* Sender);
	void __fastcall TrackBar3Change(System::TObject* Sender);
	void __fastcall TrackBar4Change(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall TrackBar5Change(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall ComboBox9Change(System::TObject* Sender);
	void __fastcall ComboBox10Change(System::TObject* Sender);
	void __fastcall AdvSmoothColorSelector7Select(System::TObject* Sender, int Index, Advsmoothselectors::TAdvSmoothSelectorItem* Item);
	void __fastcall AdvSmoothColorSelector8Select(System::TObject* Sender, int Index, Advsmoothselectors::TAdvSmoothSelectorItem* Item);
	
private:
	Gdipfill::TGDIPFill* FFillPreview;
	Advsmoothfillpreview::TAdvSmoothFillPreview* AdvSmoothFillPreview1;
	Advsmoothfillpreview::TAdvSmoothFillPreview* AdvSmoothFillPreview2;
	Advsmoothfillpreview::TAdvSmoothFillPreview* AdvSmoothFillPreview3;
	
protected:
	void __fastcall FillChanged(System::TObject* Sender);
	
public:
	void __fastcall Init(bool Create);
	void __fastcall SaveChanges(void);
	
__published:
	__property Gdipfill::TGDIPFill* FillPreview = {read=FFillPreview, write=FFillPreview};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvSmoothFillEditorForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAdvSmoothFillEditorForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvSmoothFillEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothFillEditorForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TAdvSmoothFillEditorDialog;
class PASCALIMPLEMENTATION TAdvSmoothFillEditorDialog : public Dialogs::TCommonDialog
{
	typedef Dialogs::TCommonDialog inherited;
	
private:
	TAdvSmoothFillEditorForm* FForm;
	System::UnicodeString FCaption;
	Gdipfill::TGDIPFill* FFill;
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	
public:
	virtual bool __fastcall Execute(void)/* overload */;
	__property TAdvSmoothFillEditorForm* Form = {read=FForm};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
public:
	/* TCommonDialog.Create */ inline __fastcall virtual TAdvSmoothFillEditorDialog(Classes::TComponent* AOwner) : Dialogs::TCommonDialog(AOwner) { }
	/* TCommonDialog.Destroy */ inline __fastcall virtual ~TAdvSmoothFillEditorDialog(void) { }
	
	
/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Dialogs::TCommonDialog::Execute(ParentWnd); }
	
};


#pragma option push -b-
enum TSaveMode { mCancelled, mSaved, mNotSaved };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TAdvSmoothFillEditorForm* AdvSmoothFillEditorForm;
extern PACKAGE TSaveMode Mode;
extern PACKAGE Gdipfill::TGDIPFill* f;

}	/* namespace Advsmoothfilleditor */
using namespace Advsmoothfilleditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothfilleditorHPP
