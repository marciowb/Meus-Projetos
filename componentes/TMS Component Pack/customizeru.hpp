// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Customizeru.pas' rev: 21.00

#ifndef CustomizeruHPP
#define CustomizeruHPP

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
#include <Extctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Advtoolbar.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advglowbutton.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Customizeru
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCustomizerForm;
class PASCALIMPLEMENTATION TCustomizerForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* BtnOk;
	Stdctrls::TButton* BtnCancel;
	Stdctrls::TGroupBox* GroupBox2;
	Stdctrls::TEdit* EdtCaption;
	Stdctrls::TLabel* LblCaption;
	Stdctrls::TComboBox* CmBxGlphPos;
	Stdctrls::TLabel* LblGlphPos;
	Stdctrls::TCheckBox* ChkLargeIcon;
	Stdctrls::TGroupBox* GroupBox1;
	Stdctrls::TLabel* LblCommands;
	Stdctrls::TLabel* LblToolbarItems;
	Buttons::TSpeedButton* TopButton;
	Buttons::TSpeedButton* UpButton;
	Buttons::TSpeedButton* DownButton;
	Buttons::TSpeedButton* BottomButton;
	Buttons::TSpeedButton* AddButton;
	Buttons::TSpeedButton* SeparatorButton;
	Buttons::TSpeedButton* DeleteButton;
	Buttons::TSpeedButton* ClearButton;
	Stdctrls::TListBox* LstBxCommand;
	Stdctrls::TListBox* LstBxToolBarItems;
	Stdctrls::TComboBox* CmBxIcon;
	Buttons::TSpeedButton* BtnEdit;
	Stdctrls::TButton* BtnReset;
	Buttons::TSpeedButton* AddGlowButton;
	void __fastcall LstBxToolBarItemsDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall TopButtonClick(System::TObject* Sender);
	void __fastcall UpButtonClick(System::TObject* Sender);
	void __fastcall DownButtonClick(System::TObject* Sender);
	void __fastcall BottomButtonClick(System::TObject* Sender);
	void __fastcall SeparatorButtonClick(System::TObject* Sender);
	void __fastcall CmBxIconDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall BtnEditClick(System::TObject* Sender);
	void __fastcall OkBitBtnClick(System::TObject* Sender);
	void __fastcall LstBxToolBarItemsDblClick(System::TObject* Sender);
	void __fastcall LstBxToolBarItemsMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall AddButtonClick(System::TObject* Sender);
	void __fastcall DeleteButtonClick(System::TObject* Sender);
	void __fastcall ClearButtonClick(System::TObject* Sender);
	void __fastcall LstBxCommandClick(System::TObject* Sender);
	void __fastcall LstBxToolBarItemsClick(System::TObject* Sender);
	void __fastcall CmBxGlphPosChange(System::TObject* Sender);
	void __fastcall LstBxToolBarItemsDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall LstBxToolBarItemsDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall EdtCaptionChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ChkLargeIconClick(System::TObject* Sender);
	void __fastcall AddGlowButtonClick(System::TObject* Sender);
	
private:
	bool FModified;
	bool FLoading;
	bool FCanEditBtn;
	
protected:
	void __fastcall SetModified(void);
	void __fastcall UpdateComponentPos(void);
	void __fastcall SetComponents(void);
	void __fastcall SaveChanges(void);
	
public:
	Advtoolbar::TAdvToolBarCustomizer* FToolBarCustomizer;
	void __fastcall LoadComponents(void);
	void __fastcall SetCaption(bool Value);
	void __fastcall SetGlyphPosition(bool Value);
	__property bool Modified = {read=FModified, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCustomizerForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCustomizerForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCustomizerForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomizerForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TProAdvToolBarButton;
class PASCALIMPLEMENTATION TProAdvToolBarButton : public Advtoolbar::TAdvToolBarButton
{
	typedef Advtoolbar::TAdvToolBarButton inherited;
	
public:
	/* TAdvCustomToolBarButton.Create */ inline __fastcall virtual TProAdvToolBarButton(Classes::TComponent* AOwner) : Advtoolbar::TAdvToolBarButton(AOwner) { }
	/* TAdvCustomToolBarButton.Destroy */ inline __fastcall virtual ~TProAdvToolBarButton(void) { }
	
};


class DELPHICLASS TProCustomGlowButton;
class PASCALIMPLEMENTATION TProCustomGlowButton : public Advglowbutton::TAdvCustomGlowButton
{
	typedef Advglowbutton::TAdvCustomGlowButton inherited;
	
public:
	/* TAdvCustomGlowButton.Create */ inline __fastcall virtual TProCustomGlowButton(Classes::TComponent* AOwner) : Advglowbutton::TAdvCustomGlowButton(AOwner) { }
	/* TAdvCustomGlowButton.Destroy */ inline __fastcall virtual ~TProCustomGlowButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TProCustomGlowButton(HWND ParentWindow) : Advglowbutton::TAdvCustomGlowButton(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TCustomizerForm* CustomizerForm;

}	/* namespace Customizeru */
using namespace Customizeru;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CustomizeruHPP
