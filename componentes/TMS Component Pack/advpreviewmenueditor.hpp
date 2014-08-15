// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advpreviewmenueditor.pas' rev: 21.00

#ifndef AdvpreviewmenueditorHPP
#define AdvpreviewmenueditorHPP

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
#include <Spin.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Advpreviewmenu.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Extdlgs.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advpreviewmenueditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPreviewMenuEditor;
class PASCALIMPLEMENTATION TPreviewMenuEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TGroupBox* gb_OfficeHint;
	Stdctrls::TMemo* mem_Notes;
	Stdctrls::TEdit* edt_HintTitle;
	Stdctrls::TLabel* lbl_HintTitle;
	Stdctrls::TButton* btn_HintPicture;
	Stdctrls::TCheckBox* chk_HintShowHelp;
	Stdctrls::TLabel* lbl_HintNotes;
	Stdctrls::TCheckBox* chk_CanSelect;
	Stdctrls::TCheckBox* chk_Visible;
	Stdctrls::TCheckBox* chk_Enabled;
	Stdctrls::TCheckBox* chk_Separator;
	Stdctrls::TEdit* edt_Caption;
	Stdctrls::TLabel* lbl_Caption;
	Stdctrls::TComboBox* cmb_ImageIndex;
	Stdctrls::TLabel* lbl_ImageIndex;
	Stdctrls::TButton* btn_Picture;
	Stdctrls::TButton* btn_DisabledPic;
	Stdctrls::TEdit* edt_SubMenuCaption;
	Stdctrls::TLabel* lbl_SubMenuCaption;
	Spin::TSpinEdit* spn_SubMenuSpacing;
	Stdctrls::TLabel* Label1;
	Stdctrls::TEdit* edt_ShortCutHint;
	Stdctrls::TLabel* lbl_ShortCutHint;
	Stdctrls::TEdit* edt_ShortCutSubHint;
	Stdctrls::TLabel* lbl_ShortCutSubHint;
	Spin::TSpinEdit* spn_Tag;
	Stdctrls::TLabel* lbl_Tag;
	Stdctrls::TLabel* lbl_Title;
	Stdctrls::TLabel* lbl_SubImageIndex;
	Stdctrls::TLabel* lbl_SubShortCutHint;
	Stdctrls::TLabel* lbl_SubTag;
	Stdctrls::TGroupBox* gb_SubOfficeHint;
	Stdctrls::TLabel* lbl_SubHintTile;
	Stdctrls::TLabel* lbl_SubHintNotes;
	Stdctrls::TMemo* mem_SubHintNotes;
	Stdctrls::TEdit* edt_SubHintTitle;
	Stdctrls::TButton* btn_SubHintPicture;
	Stdctrls::TCheckBox* chk_SubShowHelp;
	Stdctrls::TCheckBox* chk_SubVisible;
	Stdctrls::TCheckBox* chk_SubEnabled;
	Stdctrls::TCheckBox* chk_SubSeparator;
	Stdctrls::TEdit* edt_Title;
	Stdctrls::TComboBox* cmb_SubImageIndex;
	Stdctrls::TButton* btn_SubPicture;
	Stdctrls::TButton* btn_SubDisabledPic;
	Stdctrls::TEdit* edt_SubShortCutHint;
	Spin::TSpinEdit* spn_SubTag;
	Stdctrls::TMemo* mem_SubNotes;
	Stdctrls::TLabel* lbl_SubNotes;
	Stdctrls::TButton* btn_SubItemAdd;
	Stdctrls::TButton* btn_SubItemRemove;
	Stdctrls::TButton* btn_Add;
	Stdctrls::TButton* btn_Remove;
	Extctrls::TPanel* pnl_Items;
	Comctrls::TPageControl* pg_Items;
	Comctrls::TTabSheet* ts_MenuItems;
	Comctrls::TTabSheet* ts_SubMenuItems;
	Stdctrls::TButton* btn_RemoveDefault;
	Stdctrls::TButton* btn_AddDefault;
	Extdlgs::TOpenPictureDialog* OpenDialog;
	Stdctrls::TComboBox* cmb_Action;
	Stdctrls::TLabel* lbl_Action;
	Stdctrls::TComboBox* cmb_SubAction;
	Stdctrls::TLabel* lbl_SubAction;
	Stdctrls::TButton* btn_Ok;
	Stdctrls::TButton* Button1;
	Stdctrls::TComboBox* cmb_SubMenu;
	Stdctrls::TLabel* lbl_SubMenu;
	Spin::TSpinEdit* spn_SubMenuHeight;
	Stdctrls::TLabel* lbl_SubMenuHeight;
	Stdctrls::TLabel* Label2;
	Extctrls::TPanel* pnl_Left;
	Stdctrls::TButton* btn_Up;
	Stdctrls::TButton* btn_Down;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cmb_ImageIndexChange(System::TObject* Sender);
	void __fastcall spn_SubMenuSpacingChange(System::TObject* Sender);
	void __fastcall spn_TagChange(System::TObject* Sender);
	void __fastcall mem_NotesChange(System::TObject* Sender);
	void __fastcall chk_CanSelectClick(System::TObject* Sender);
	void __fastcall chk_VisibleClick(System::TObject* Sender);
	void __fastcall chk_EnabledClick(System::TObject* Sender);
	void __fastcall chk_SeparatorClick(System::TObject* Sender);
	void __fastcall chk_HintShowHelpClick(System::TObject* Sender);
	void __fastcall edt_CaptionKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall edt_SubMenuCaptionKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall edt_ShortCutHintKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall edt_ShortCutSubHintKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall edt_HintTitleKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall btn_AddClick(System::TObject* Sender);
	void __fastcall btn_RemoveClick(System::TObject* Sender);
	void __fastcall edt_TitleKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall edt_SubShortCutHintKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall cmb_SubImageIndexChange(System::TObject* Sender);
	void __fastcall spn_SubTagChange(System::TObject* Sender);
	void __fastcall chk_SubVisibleClick(System::TObject* Sender);
	void __fastcall chk_SubEnabledClick(System::TObject* Sender);
	void __fastcall chk_SubSeparatorClick(System::TObject* Sender);
	void __fastcall mem_SubNotesChange(System::TObject* Sender);
	void __fastcall edt_SubHintTitleKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall mem_SubHintNotesChange(System::TObject* Sender);
	void __fastcall chk_SubShowHelpClick(System::TObject* Sender);
	void __fastcall btn_SubItemAddClick(System::TObject* Sender);
	void __fastcall btn_SubItemRemoveClick(System::TObject* Sender);
	void __fastcall btn_AddDefaultClick(System::TObject* Sender);
	void __fastcall btn_RemoveDefaultClick(System::TObject* Sender);
	void __fastcall btn_PictureClick(System::TObject* Sender);
	void __fastcall btn_DisabledPicClick(System::TObject* Sender);
	void __fastcall btn_SubPictureClick(System::TObject* Sender);
	void __fastcall btn_SubDisabledPicClick(System::TObject* Sender);
	void __fastcall cmb_SubImageIndexDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall cmb_ImageIndexDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall cmb_ActionChange(System::TObject* Sender);
	void __fastcall cmb_SubActionChange(System::TObject* Sender);
	void __fastcall cmb_SubMenuChange(System::TObject* Sender);
	void __fastcall spn_SubMenuHeightChange(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall btn_UpClick(System::TObject* Sender);
	void __fastcall btn_DownClick(System::TObject* Sender);
	
private:
	Advpreviewmenu::TPreviewMenuControl* FPreviewMenuControl;
	bool FInternalItemChange;
	bool FInternalSubItemChange;
	void __fastcall OnMenuItemClick(System::TObject* Sender, int ItemIndex);
	void __fastcall OnSubMenuItemClick(System::TObject* Sender, int ItemIndex, int SubMenuItemIndex);
	void __fastcall OnPreviewMenuControlResize(System::TObject* Sender);
	void __fastcall UpdatePreview(void);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	virtual int __fastcall ShowModal(void);
	__property Advpreviewmenu::TPreviewMenuControl* PreviewMenuControl = {read=FPreviewMenuControl};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPreviewMenuEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPreviewMenuEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPreviewMenuEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPreviewMenuEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TPreviewMenuEditor* PreviewMenuEditor;

}	/* namespace Advpreviewmenueditor */
using namespace Advpreviewmenueditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvpreviewmenueditorHPP
