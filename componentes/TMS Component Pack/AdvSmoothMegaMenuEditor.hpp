// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothmegamenueditor.pas' rev: 21.00

#ifndef AdvsmoothmegamenueditorHPP
#define AdvsmoothmegamenueditorHPP

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
#include <Variants.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Gdipmenu.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advsmoothfilleditor.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Advsmoothspin.hpp>	// Pascal unit
#include <Advsmoothhtmleditor.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothmegamenueditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCustomPaintBox;
class PASCALIMPLEMENTATION TCustomPaintBox : public Extctrls::TPaintBox
{
	typedef Extctrls::TPaintBox inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
public:
	/* TPaintBox.Create */ inline __fastcall virtual TCustomPaintBox(Classes::TComponent* AOwner) : Extctrls::TPaintBox(AOwner) { }
	
public:
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TCustomPaintBox(void) { }
	
};


#pragma option push -b-
enum TMenuNodeType { ntRoot, ntItem, ntSection, ntTopLayerItem };
#pragma option pop

class DELPHICLASS TMenuNode;
class PASCALIMPLEMENTATION TMenuNode : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Gdipmenu::TGDIPMenu* root;
	Gdipmenu::TGDIPMenuSectionItem* item;
	Gdipmenu::TGDIPMenuSection* section;
	Gdipmenu::TGDIPMenuTopLayerItem* toplayeritem;
public:
	/* TObject.Create */ inline __fastcall TMenuNode(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TMenuNode(void) { }
	
};


class DELPHICLASS TAdvSmoothMegaMenuEditorForm;
class PASCALIMPLEMENTATION TAdvSmoothMegaMenuEditorForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* Panel1;
	Comctrls::TTreeView* TreeView1;
	Extctrls::TPanel* Panel2;
	Extctrls::TPanel* Panel3;
	Forms::TScrollBox* ScrollBox1;
	Extctrls::TPanel* Panel4;
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button4;
	Extctrls::TPanel* pnlRoot;
	Extctrls::TPanel* pnlSection;
	Extctrls::TPanel* pnlSectionItem;
	Extctrls::TPanel* pnlTop;
	Comctrls::TPageControl* PageControl1;
	Comctrls::TTabSheet* TabSheet1;
	Comctrls::TTabSheet* TabSheet2;
	Stdctrls::TStaticText* Label1;
	Stdctrls::TStaticText* Label2;
	Stdctrls::TStaticText* Label4;
	Stdctrls::TStaticText* Label3;
	Stdctrls::TStaticText* Label6;
	Stdctrls::TStaticText* Label5;
	Extctrls::TPaintBox* PaintBox6;
	Extctrls::TPaintBox* PaintBox7;
	Stdctrls::TButton* Button8;
	Stdctrls::TButton* Button7;
	Stdctrls::TButton* Button6;
	Extctrls::TPaintBox* PaintBox4;
	Extctrls::TPaintBox* PaintBox5;
	Stdctrls::TButton* Button5;
	Stdctrls::TButton* Button3;
	Extctrls::TPaintBox* PaintBox3;
	Extctrls::TPaintBox* PaintBox2;
	Stdctrls::TButton* Button2;
	Stdctrls::TStaticText* Label7;
	Extctrls::TPaintBox* PaintBox8;
	Stdctrls::TButton* Button9;
	Buttons::TSpeedButton* SpeedButton1;
	Buttons::TSpeedButton* SpeedButton2;
	Buttons::TSpeedButton* SpeedButton3;
	Buttons::TSpeedButton* SpeedButton4;
	Buttons::TSpeedButton* SpeedButton5;
	Buttons::TSpeedButton* SpeedButton6;
	Controls::TImageList* ImageList1;
	Extctrls::TPanel* pnlEmpty;
	Stdctrls::TStaticText* Label8;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit1;
	Stdctrls::TStaticText* Label9;
	Extctrls::TPaintBox* PaintBox9;
	Stdctrls::TButton* Button10;
	Stdctrls::TStaticText* Label10;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit2;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit3;
	Stdctrls::TStaticText* Label11;
	Stdctrls::TStaticText* Label13;
	Stdctrls::TButton* Button11;
	Stdctrls::TStaticText* Label14;
	Stdctrls::TButton* Button12;
	Stdctrls::TStaticText* Label15;
	Stdctrls::TButton* Button13;
	Stdctrls::TStaticText* Label16;
	Stdctrls::TButton* Button14;
	Dialogs::TFontDialog* FontDialog1;
	Stdctrls::TComboBox* ComboBox1;
	Stdctrls::TStaticText* Label22;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit8;
	Stdctrls::TStaticText* Label23;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit9;
	Stdctrls::TStaticText* Label24;
	Stdctrls::TCheckBox* CheckBox2;
	Comctrls::TPageControl* PageControl2;
	Comctrls::TTabSheet* TabSheet3;
	Stdctrls::TStaticText* Label33;
	Stdctrls::TStaticText* Label34;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit13;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit14;
	Stdctrls::TStaticText* Label35;
	Extctrls::TPaintBox* PaintBox11;
	Stdctrls::TButton* Button17;
	Comctrls::TTabSheet* TabSheet4;
	Stdctrls::TStaticText* Label26;
	Stdctrls::TEdit* Edit1;
	Stdctrls::TButton* Button15;
	Stdctrls::TComboBox* ComboBox3;
	Stdctrls::TStaticText* Label27;
	Stdctrls::TStaticText* Label28;
	Stdctrls::TStaticText* Label29;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit11;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit10;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit12;
	Stdctrls::TButton* Button16;
	Extctrls::TPaintBox* PaintBox10;
	Stdctrls::TStaticText* Label32;
	Stdctrls::TStaticText* Label31;
	Stdctrls::TStaticText* Label30;
	Stdctrls::TStaticText* Label36;
	Stdctrls::TStaticText* Label37;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit15;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit16;
	Stdctrls::TStaticText* Label38;
	Stdctrls::TStaticText* Label39;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit17;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit18;
	Stdctrls::TStaticText* Label40;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit19;
	Stdctrls::TStaticText* Label41;
	Comctrls::TPageControl* PageControl3;
	Comctrls::TTabSheet* TabSheet5;
	Stdctrls::TCheckBox* CheckBox3;
	Stdctrls::TStaticText* Label42;
	Stdctrls::TStaticText* Label43;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit20;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit21;
	Stdctrls::TStaticText* Label44;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit22;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit23;
	Stdctrls::TStaticText* Label45;
	Stdctrls::TStaticText* Label46;
	Extctrls::TPaintBox* PaintBox12;
	Stdctrls::TButton* Button18;
	Stdctrls::TComboBox* ComboBox4;
	Stdctrls::TStaticText* Label47;
	Comctrls::TTabSheet* TabSheet6;
	Stdctrls::TStaticText* Label48;
	Stdctrls::TStaticText* Label49;
	Stdctrls::TComboBox* ComboBox5;
	Stdctrls::TStaticText* Label50;
	Stdctrls::TButton* Button19;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit1;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit2;
	Stdctrls::TStaticText* Label51;
	Stdctrls::TStaticText* Label52;
	Comctrls::TPageControl* PageControl4;
	Comctrls::TTabSheet* TabSheet7;
	Stdctrls::TStaticText* Label53;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit3;
	Stdctrls::TCheckBox* CheckBox4;
	Stdctrls::TCheckBox* CheckBox5;
	Stdctrls::TCheckBox* CheckBox6;
	Comctrls::TTabSheet* TabSheet8;
	Stdctrls::TComboBox* ComboBox6;
	Stdctrls::TStaticText* Label54;
	Stdctrls::TComboBox* ComboBox7;
	Stdctrls::TStaticText* Label55;
	Stdctrls::TStaticText* Label56;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit4;
	Comctrls::TTabSheet* TabSheet9;
	Stdctrls::TStaticText* Label57;
	Stdctrls::TComboBox* ComboBox8;
	Stdctrls::TStaticText* Label12;
	Stdctrls::TButton* Button20;
	Stdctrls::TStaticText* Label58;
	Stdctrls::TButton* Button21;
	Stdctrls::TButton* Button22;
	Stdctrls::TStaticText* Label59;
	Stdctrls::TComboBox* ComboBox9;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit5;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit6;
	Stdctrls::TStaticText* Label61;
	Stdctrls::TStaticText* Label62;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit7;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit8;
	Stdctrls::TStaticText* Label64;
	Stdctrls::TStaticText* Label65;
	Stdctrls::TStaticText* Label66;
	Stdctrls::TStaticText* Label67;
	Comctrls::TTabSheet* TabSheet10;
	Stdctrls::TStaticText* Label25;
	Stdctrls::TCheckBox* CheckBox1;
	Stdctrls::TComboBox* ComboBox2;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit4;
	Stdctrls::TStaticText* Label18;
	Stdctrls::TStaticText* Label17;
	Stdctrls::TStaticText* Label19;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit5;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit6;
	Stdctrls::TStaticText* Label21;
	Advsmoothspin::TAdvSmoothSpinEdit* SpinEdit7;
	Stdctrls::TStaticText* Label20;
	Stdctrls::TStaticText* Label63;
	Stdctrls::TStaticText* Label68;
	Stdctrls::TComboBox* ComboBox10;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit9;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit10;
	Stdctrls::TStaticText* Label69;
	Dialogs::TColorDialog* ColorDialog1;
	Stdctrls::TComboBox* ComboBox11;
	Stdctrls::TComboBox* ComboBox12;
	Stdctrls::TStaticText* Label70;
	Stdctrls::TButton* Button24;
	Stdctrls::TStaticText* Label71;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit11;
	Stdctrls::TStaticText* Label72;
	Stdctrls::TStaticText* Label73;
	Extctrls::TPaintBox* PaintBox13;
	Stdctrls::TButton* Button25;
	Stdctrls::TStaticText* Label74;
	Extctrls::TPaintBox* PaintBox14;
	Stdctrls::TButton* Button26;
	Buttons::TSpeedButton* SpeedButton7;
	Buttons::TSpeedButton* SpeedButton8;
	Stdctrls::TStaticText* Label75;
	Stdctrls::TEdit* Edit2;
	Stdctrls::TCheckBox* CheckBox7;
	Stdctrls::TStaticText* StaticText1;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit12;
	Stdctrls::TStaticText* StaticText2;
	Stdctrls::TStaticText* StaticText3;
	Stdctrls::TStaticText* StaticText4;
	Stdctrls::TComboBox* ComboBox13;
	Stdctrls::TStaticText* StaticText5;
	Stdctrls::TStaticText* StaticText6;
	Stdctrls::TButton* Button27;
	Advsmoothspin::TAdvSmoothSpinEdit* AdvSmoothSpinEdit13;
	Stdctrls::TStaticText* StaticText7;
	Stdctrls::TCheckBox* CheckBox8;
	void __fastcall PaintBox1Paint(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall TreeView1Change(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall PaintBox1MouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall PaintBox1MouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CheckBox1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall PaintBox2Paint(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall PaintBox3Paint(System::TObject* Sender);
	void __fastcall Button5Click(System::TObject* Sender);
	void __fastcall Button6Click(System::TObject* Sender);
	void __fastcall Button7Click(System::TObject* Sender);
	void __fastcall Button8Click(System::TObject* Sender);
	void __fastcall PaintBox5Paint(System::TObject* Sender);
	void __fastcall PaintBox4Paint(System::TObject* Sender);
	void __fastcall PaintBox7Paint(System::TObject* Sender);
	void __fastcall PaintBox6Paint(System::TObject* Sender);
	void __fastcall Button9Click(System::TObject* Sender);
	void __fastcall PaintBox8Paint(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall SpeedButton6Click(System::TObject* Sender);
	void __fastcall SpeedButton4Click(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton5Click(System::TObject* Sender);
	void __fastcall SpeedButton3Click(System::TObject* Sender);
	void __fastcall SpinEdit1Change(System::TObject* Sender);
	void __fastcall PaintBox9Paint(System::TObject* Sender);
	void __fastcall Button10Click(System::TObject* Sender);
	void __fastcall SpinEdit2Change(System::TObject* Sender);
	void __fastcall SpinEdit3Change(System::TObject* Sender);
	void __fastcall Button11Click(System::TObject* Sender);
	void __fastcall Button12Click(System::TObject* Sender);
	void __fastcall Button13Click(System::TObject* Sender);
	void __fastcall Button14Click(System::TObject* Sender);
	void __fastcall SpinEdit4Change(System::TObject* Sender);
	void __fastcall SpinEdit5Change(System::TObject* Sender);
	void __fastcall SpinEdit6Change(System::TObject* Sender);
	void __fastcall SpinEdit7Change(System::TObject* Sender);
	void __fastcall ComboBox1Change(System::TObject* Sender);
	void __fastcall SpinEdit8Change(System::TObject* Sender);
	void __fastcall SpinEdit9Change(System::TObject* Sender);
	void __fastcall ComboBox2Change(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Button15Click(System::TObject* Sender);
	void __fastcall ComboBox3Change(System::TObject* Sender);
	void __fastcall SpinEdit11Change(System::TObject* Sender);
	void __fastcall SpinEdit10Change(System::TObject* Sender);
	void __fastcall SpinEdit12Change(System::TObject* Sender);
	void __fastcall Button16Click(System::TObject* Sender);
	void __fastcall PaintBox10Paint(System::TObject* Sender);
	void __fastcall SpinEdit14Change(System::TObject* Sender);
	void __fastcall SpinEdit13Change(System::TObject* Sender);
	void __fastcall Button17Click(System::TObject* Sender);
	void __fastcall PaintBox11Paint(System::TObject* Sender);
	void __fastcall SpinEdit15Change(System::TObject* Sender);
	void __fastcall SpinEdit16Change(System::TObject* Sender);
	void __fastcall SpinEdit17Change(System::TObject* Sender);
	void __fastcall SpinEdit18Change(System::TObject* Sender);
	void __fastcall SpinEdit19Change(System::TObject* Sender);
	void __fastcall CheckBox2Click(System::TObject* Sender);
	void __fastcall CheckBox3Click(System::TObject* Sender);
	void __fastcall SpinEdit20Change(System::TObject* Sender);
	void __fastcall SpinEdit21Change(System::TObject* Sender);
	void __fastcall SpinEdit23Change(System::TObject* Sender);
	void __fastcall SpinEdit22Change(System::TObject* Sender);
	void __fastcall Button18Click(System::TObject* Sender);
	void __fastcall PaintBox12Paint(System::TObject* Sender);
	void __fastcall ComboBox4Change(System::TObject* Sender);
	void __fastcall ComboBox5Change(System::TObject* Sender);
	void __fastcall Button19Click(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit1Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit2Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit3Change(System::TObject* Sender);
	void __fastcall CheckBox4Click(System::TObject* Sender);
	void __fastcall CheckBox5Click(System::TObject* Sender);
	void __fastcall CheckBox6Click(System::TObject* Sender);
	void __fastcall ComboBox6Change(System::TObject* Sender);
	void __fastcall ComboBox7Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit4Change(System::TObject* Sender);
	void __fastcall PaintBox1MouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall Button20Click(System::TObject* Sender);
	void __fastcall Button21Click(System::TObject* Sender);
	void __fastcall Button22Click(System::TObject* Sender);
	void __fastcall ComboBox9Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit5Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit6Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit8Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit7Change(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ComboBox10Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit9Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit10Change(System::TObject* Sender);
	void __fastcall ComboBox11Change(System::TObject* Sender);
	void __fastcall ComboBox12Change(System::TObject* Sender);
	void __fastcall Button24Click(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit11Change(System::TObject* Sender);
	void __fastcall Button25Click(System::TObject* Sender);
	void __fastcall Button26Click(System::TObject* Sender);
	void __fastcall PaintBox13Paint(System::TObject* Sender);
	void __fastcall PaintBox14Paint(System::TObject* Sender);
	void __fastcall SpeedButton7Click(System::TObject* Sender);
	void __fastcall SpeedButton8Click(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall CheckBox7Click(System::TObject* Sender);
	void __fastcall ComboBox8Change(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit12Change(System::TObject* Sender);
	void __fastcall ComboBox13Change(System::TObject* Sender);
	void __fastcall Button27Click(System::TObject* Sender);
	void __fastcall AdvSmoothSpinEdit13Change(System::TObject* Sender);
	void __fastcall Button23Click(System::TObject* Sender);
	void __fastcall TreeView1DragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall TreeView1DragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall CheckBox8Click(System::TObject* Sender);
	
private:
	TCustomPaintBox* PaintBox1;
	Gdipmenu::TGDIPMenuTopLayerItem* tl;
	int TLLeft;
	int TLTop;
	Gdipmenu::TGDIPMenu* FMenuPreview;
	Comctrls::TTreeNode* FSelectedNode;
	Comctrls::TTreeNode* FRootNode;
	void __fastcall SetSelectedNode(const Comctrls::TTreeNode* Value);
	void __fastcall SetRootNode(const Comctrls::TTreeNode* Value);
	
protected:
	void __fastcall MenuChanged(System::TObject* Sender);
	void __fastcall MenuItemCheckChanged(System::TObject* Sender, Gdipmenu::TGDIPMenuSectionItem* item);
	__property Comctrls::TTreeNode* SelectedNode = {read=FSelectedNode, write=SetSelectedNode};
	__property Comctrls::TTreeNode* RootNode = {read=FRootNode, write=SetRootNode};
	
public:
	void __fastcall Init(bool Create);
	void __fastcall CalculateSize(void);
	void __fastcall UpdateMenu(void);
	void __fastcall SaveChanges(void);
	void __fastcall CorrectTop(Stdctrls::TStaticText* lbl);
	void __fastcall ClearTreeView(void);
	void __fastcall InitTreeView(bool Expand, bool SelectRoot, int RootIndex = 0xffffffff, int RootTopIndex = 0xffffffff, int RootItemIndex = 0xffffffff, int RootSubItemIndex = 0xffffffff);
	void __fastcall HidePanels(void);
	void __fastcall StartFillEditor(Gdipfill::TGDIPFill* f);
	void __fastcall StartHTMLEditor(System::UnicodeString &str);
	void __fastcall PaintFill(Extctrls::TPaintBox* pb, Gdipfill::TGDIPFill* f);
	void __fastcall SelectItemTreeView(Gdipmenu::TGDIPMenuSectionItem* si);
	void __fastcall SelectTopLayerTreeView(Gdipmenu::TGDIPMenuTopLayerItem* tl);
	void __fastcall FillMenuProperties(Gdipmenu::TGDIPMenu* m, bool Hidepnl);
	void __fastcall DisableButtons(void);
	void __fastcall FillSectionProperties(Gdipmenu::TGDIPMenuSection* s, bool Hidepnl);
	void __fastcall FillSectionItemProperties(Gdipmenu::TGDIPMenuSectionItem* si, bool Hidepnl);
	void __fastcall FillTopLayerItemProperties(Gdipmenu::TGDIPMenuTopLayerItem* tl, bool Hidepnl);
	TMenuNodeType __fastcall GetMenuNodeType(TMenuNode* m);
	__property Gdipmenu::TGDIPMenu* MenuPreview = {read=FMenuPreview, write=FMenuPreview};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvSmoothMegaMenuEditorForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAdvSmoothMegaMenuEditorForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvSmoothMegaMenuEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothMegaMenuEditorForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TAdvSmoothMegaMenuEditorDialog;
class PASCALIMPLEMENTATION TAdvSmoothMegaMenuEditorDialog : public Dialogs::TCommonDialog
{
	typedef Dialogs::TCommonDialog inherited;
	
private:
	TAdvSmoothMegaMenuEditorForm* FForm;
	System::UnicodeString FCaption;
	Gdipmenu::TGDIPMenu* FMenu;
	void __fastcall SetMenu(const Gdipmenu::TGDIPMenu* Value);
	
public:
	virtual bool __fastcall Execute(void)/* overload */;
	__property TAdvSmoothMegaMenuEditorForm* Form = {read=FForm};
	__property Gdipmenu::TGDIPMenu* Menu = {read=FMenu, write=SetMenu};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
public:
	/* TCommonDialog.Create */ inline __fastcall virtual TAdvSmoothMegaMenuEditorDialog(Classes::TComponent* AOwner) : Dialogs::TCommonDialog(AOwner) { }
	/* TCommonDialog.Destroy */ inline __fastcall virtual ~TAdvSmoothMegaMenuEditorDialog(void) { }
	
	
/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Dialogs::TCommonDialog::Execute(ParentWnd); }
	
};


#pragma option push -b-
enum TSaveMode { mCancelled, mSaved, mNotSaved };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TAdvSmoothMegaMenuEditorForm* AdvSmoothMegaMenuEditorForm;
extern PACKAGE TSaveMode Mode;
extern PACKAGE Gdipmenu::TGDIPMenu* m;
extern PACKAGE bool DoTLDrag;
extern PACKAGE bool DoRefresh;
extern PACKAGE bool FMenuIsUpdated;
extern PACKAGE bool FAllowUpdate;

}	/* namespace Advsmoothmegamenueditor */
using namespace Advsmoothmegamenueditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothmegamenueditorHPP
