// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Customeditor.pas' rev: 21.00

#ifndef CustomeditorHPP
#define CustomeditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Gdipbase.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Valedit.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Advsmoothfillpreview.hpp>	// Pascal unit
#include <Advsmoothfilleditor.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Advpolylist.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Customitemscontainer.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Customeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFrmCustomEditor;
class PASCALIMPLEMENTATION TFrmCustomEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TPageControl* PageControl1;
	Comctrls::TTabSheet* TabSheet1;
	Comctrls::TTabSheet* TabSheet2;
	Dialogs::TFontDialog* FontDialog1;
	Advpolylist::TAdvPolyList* AdvPolyList1;
	Advpolylist::TAdvPolyList* AdvPolyList2;
	Buttons::TSpeedButton* SpeedButton1;
	Buttons::TSpeedButton* SpeedButton2;
	Buttons::TSpeedButton* SpeedButton3;
	Buttons::TSpeedButton* SpeedButton4;
	Stdctrls::TLabel* Label22;
	Stdctrls::TLabel* Label23;
	Stdctrls::TGroupBox* GroupBox1;
	Extctrls::TPaintBox* PaintBox1;
	Stdctrls::TButton* Button3;
	Stdctrls::TLabel* Label1;
	Stdctrls::TButton* Button4;
	Extctrls::TPaintBox* PaintBox2;
	Stdctrls::TLabel* Label2;
	Stdctrls::TLabel* Label3;
	Stdctrls::TLabel* Label4;
	Stdctrls::TLabel* Label5;
	Stdctrls::TButton* Button7;
	Stdctrls::TButton* Button6;
	Stdctrls::TButton* Button5;
	Extctrls::TPaintBox* PaintBox3;
	Extctrls::TPaintBox* PaintBox4;
	Extctrls::TPaintBox* PaintBox5;
	Stdctrls::TGroupBox* GroupBox2;
	Stdctrls::TButton* Button13;
	Extctrls::TPaintBox* PaintBox7;
	Extctrls::TPaintBox* PaintBox6;
	Stdctrls::TButton* Button14;
	Stdctrls::TButton* Button17;
	Extctrls::TPaintBox* PaintBox8;
	Extctrls::TPaintBox* PaintBox9;
	Stdctrls::TButton* Button16;
	Extctrls::TPaintBox* PaintBox10;
	Stdctrls::TButton* Button15;
	Stdctrls::TLabel* Label16;
	Stdctrls::TLabel* Label17;
	Stdctrls::TLabel* Label18;
	Stdctrls::TLabel* Label19;
	Stdctrls::TLabel* Label20;
	Stdctrls::TGroupBox* GroupBox3;
	Stdctrls::TButton* Button12;
	Stdctrls::TStaticText* Label10;
	Stdctrls::TStaticText* Label9;
	Stdctrls::TButton* Button11;
	Stdctrls::TButton* Button8;
	Stdctrls::TButton* Button9;
	Stdctrls::TButton* Button10;
	Stdctrls::TStaticText* Label8;
	Stdctrls::TStaticText* Label7;
	Stdctrls::TStaticText* Label6;
	Stdctrls::TLabel* Label11;
	Stdctrls::TLabel* Label24;
	Stdctrls::TLabel* Label25;
	Stdctrls::TLabel* Label26;
	Stdctrls::TLabel* Label27;
	Stdctrls::TComboBox* ComboBox1;
	Stdctrls::TLabel* Label21;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall SuperList1MouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall SuperList1MouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall PaintBox1Paint(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall SuperList1MouseLeave(System::TObject* Sender);
	void __fastcall Button12Click(System::TObject* Sender);
	void __fastcall PaintBox7Paint(System::TObject* Sender);
	void __fastcall Button13Click(System::TObject* Sender);
	void __fastcall CustomItemsContainer1ListItemStartDraw(System::TObject* Sender, Advgdip::TGPGraphics* AGraphics, Gdipcustomitem::TCustomItem* Item, const Advgdip::TGPRectF &ARect);
	void __fastcall CustomItemsContainer2ListItemStartDraw(System::TObject* Sender, Advgdip::TGPGraphics* AGraphics, Gdipcustomitem::TCustomItem* Item, const Advgdip::TGPRectF &ARect);
	void __fastcall CustomItemsContainer2MouseLeave(System::TObject* Sender);
	void __fastcall CustomItemsContainer2MouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall CustomItemsContainer2MouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall CustomItemsContainer1DragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall CustomItemsContainer1DragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall SpeedButton3Click(System::TObject* Sender);
	void __fastcall SpeedButton4Click(System::TObject* Sender);
	void __fastcall ComboBox1Change(System::TObject* Sender);
	void __fastcall FormKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall AdvPolyList1KeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall AdvPolyList2DblClick(System::TObject* Sender);
	
private:
	Gdipbase::TCustomBaseList* FOriginalList;
	Designintf::_di_IDesigner FFormDesigner;
	int FHoveredItemIndex;
	int FListHoveredItemIndex;
	int FSelectedItemIndex;
	int FListSelectedItemIndex;
	Gdipcustomitem::TCustomItem* FDropItem;
	
protected:
	void __fastcall FillPreviewClicked(System::TObject* Sender);
	void __fastcall UpdateContainer(void);
	void __fastcall ContainerChanged(System::TObject* Sender);
	
public:
	void __fastcall ListChanged(System::TObject* Sender);
	void __fastcall ItemChange(System::TObject* Sender);
	void __fastcall ItemSelect(System::TObject* Sender, int Index);
	void __fastcall ItemDestroy(System::TObject* Sender);
	void __fastcall ListDestroy(System::TObject* Sender);
	void __fastcall RefreshList(void);
	void __fastcall Init(void);
	void __fastcall CorrectTop(Stdctrls::TStaticText* lbl);
	void __fastcall RefreshRegisteredClasses(void);
	__property Gdipbase::TCustomBaseList* OriginalList = {read=FOriginalList, write=FOriginalList};
	__property Designintf::_di_IDesigner FormDesigner = {read=FFormDesigner, write=FFormDesigner};
	void __fastcall AddNewItem(System::UnicodeString ItemClassString, int NewIndex, int X, int Y);
	void __fastcall DeleteItem(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFrmCustomEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFrmCustomEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFrmCustomEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFrmCustomEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TDesignerSelectionsList;
class PASCALIMPLEMENTATION TDesignerSelectionsList : public Designintf::TDesignerSelections
{
	typedef Designintf::TDesignerSelections inherited;
	
public:
	/* TDesignerSelections.Create */ inline __fastcall virtual TDesignerSelectionsList(void) : Designintf::TDesignerSelections() { }
	/* TDesignerSelections.Copy */ inline __fastcall TDesignerSelectionsList(const Designintf::_di_IDesignerSelections Selections) : Designintf::TDesignerSelections(Selections) { }
	/* TDesignerSelections.Destroy */ inline __fastcall virtual ~TDesignerSelectionsList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TFrmCustomEditor* FrmCustomEditor;

}	/* namespace Customeditor */
using namespace Customeditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CustomeditorHPP
