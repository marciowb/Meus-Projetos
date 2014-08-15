// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uexceledit.pas' rev: 21.00

#ifndef UexceleditHPP
#define UexceleditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Uoledrag.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Uxlsdb.hpp>	// Pascal unit
#include <Ucustomflexcelreport.hpp>	// Pascal unit
#include <Uchecktemplate.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Toolwin.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uexceledit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TExcelEdit;
class PASCALIMPLEMENTATION TExcelEdit : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* PanelFields;
	Comctrls::TTreeView* edFields;
	Controls::TImageList* TreeImageList;
	Menus::TMainMenu* MainMenu1;
	Controls::TImageList* ImageList1;
	Controls::TImageList* ImageList2;
	Controls::TImageList* ImageList3;
	Comctrls::TToolBar* ToolBar1;
	Comctrls::TToolButton* btnCancel;
	Menus::TMenuItem* File1;
	Menus::TMenuItem* Exit1;
	Actnlist::TActionList* ActionList1;
	Actnlist::TAction* ActionClose;
	Dialogs::TSaveDialog* SaveDialog;
	Comctrls::TToolButton* ToolButton4;
	Extctrls::TPanel* FormCaption;
	Extctrls::TSplitter* Splitter1;
	Menus::TPopupMenu* PopupMenu1;
	Menus::TMenuItem* New1;
	Menus::TMenuItem* Delete1;
	Menus::TMenuItem* Refresh1;
	Actnlist::TAction* ActionCheckTemplate;
	Comctrls::TToolButton* ToolButton9;
	Menus::TMenuItem* N1;
	Menus::TMenuItem* CheckTemplate1;
	void __fastcall edFieldsMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ActionCloseExecute(System::TObject* Sender);
	void __fastcall ActionCheckTemplateExecute(System::TObject* Sender);
	
private:
	Sysutils::TFileName FileName;
	bool FUseDisplayNames;
	bool FUseHiddenFields;
	System::UnicodeString FProjName;
	Classes::TComponent* FDataModule;
	Ucustomflexcelreport::TCustomFlexCelReport* FFlexCelReport;
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	void __fastcall LoadData(const Ucustomflexcelreport::TCustomFlexCelReport* aFlexCelReport, const System::UnicodeString aFileName, const System::UnicodeString aProjName);
	__fastcall virtual TExcelEdit(Classes::TComponent* AOwner);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TExcelEdit(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TExcelEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TExcelEdit(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall InvokeExcelEditor(const Ucustomflexcelreport::TCustomFlexCelReport* aFlexCelReport, const System::UnicodeString ProjName = L"");

}	/* namespace Uexceledit */
using namespace Uexceledit;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UexceleditHPP
