// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Paramlistprop.pas' rev: 21.00

#ifndef ParamlistpropHPP
#define ParamlistpropHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Toolwin.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Paramedit.hpp>	// Pascal unit
#include <Paramlabel.hpp>	// Pascal unit
#include <Paramlistbox.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Paramlistprop
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS Tparamlisteditor;
class PASCALIMPLEMENTATION Tparamlisteditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TToolBar* ToolBar1;
	Stdctrls::TComboBox* Fontname;
	Stdctrls::TComboBox* FontSize;
	Comctrls::TToolButton* BoldButton;
	Comctrls::TToolButton* ItalicButton;
	Comctrls::TToolButton* UnderlineButton;
	Comctrls::TToolButton* LeftAlign;
	Comctrls::TToolButton* CenterAlign;
	Comctrls::TToolButton* RightAlign;
	Comctrls::TToolButton* URLButton;
	Comctrls::TToolButton* ToolButton1;
	Comctrls::TToolButton* Superscript;
	Comctrls::TToolButton* Subscript;
	Comctrls::TToolButton* ToolButton2;
	Comctrls::TToolButton* ToolButton3;
	Controls::TImageList* ImageList1;
	Dialogs::TColorDialog* ColorDialog1;
	Comctrls::TStatusBar* StatusBar1;
	Comctrls::TToolButton* ToolButton4;
	Comctrls::TToolButton* ToolButton5;
	Comctrls::TToolButton* ToolButton6;
	Comctrls::TToolButton* ListButton;
	Comctrls::TToolButton* ToolButton8;
	Comctrls::TToolButton* dbfields;
	Menus::TPopupMenu* PopupMenu1;
	Menus::TMenuItem* Test1;
	Menus::TMenuItem* N11;
	Menus::TMenuItem* N21;
	Menus::TMenuItem* N31;
	Menus::TMenuItem* N441;
	Comctrls::TToolButton* ToolButton7;
	Comctrls::TToolButton* AcceptBtn;
	Comctrls::TToolButton* CancelBtn;
	Comctrls::TToolButton* ToolButton9;
	Comctrls::TToolButton* ToolButton12;
	Extctrls::TPanel* Panel1;
	Stdctrls::TMemo* Memo1;
	Paramlabel::TParamLabel* ParamLabel1;
	Extctrls::TSplitter* Splitter1;
	Extctrls::TPanel* Panel2;
	Paramlistbox::TParamListBox* ParamListBox1;
	Buttons::TSpeedButton* SpeedButton1;
	Buttons::TSpeedButton* SpeedButton2;
	Buttons::TSpeedButton* SpeedButton3;
	Buttons::TSpeedButton* SpeedButton4;
	void __fastcall Memo1Change(System::TObject* Sender);
	void __fastcall BoldButtonClick(System::TObject* Sender);
	void __fastcall ItalicButtonClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ToolButton1Click(System::TObject* Sender);
	void __fastcall UnderlineButtonClick(System::TObject* Sender);
	void __fastcall CenterAlignClick(System::TObject* Sender);
	void __fastcall RightAlignClick(System::TObject* Sender);
	void __fastcall FontnameChange(System::TObject* Sender);
	void __fastcall URLButtonClick(System::TObject* Sender);
	void __fastcall SuperscriptClick(System::TObject* Sender);
	void __fastcall SubscriptClick(System::TObject* Sender);
	void __fastcall Memo1KeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall ToolButton2Click(System::TObject* Sender);
	void __fastcall Memo1MouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall LeftAlignClick(System::TObject* Sender);
	void __fastcall FontSizeChange(System::TObject* Sender);
	void __fastcall ToolButton3Click(System::TObject* Sender);
	void __fastcall ToolButton5Click(System::TObject* Sender);
	void __fastcall ToolButton4Click(System::TObject* Sender);
	void __fastcall ToolButton6Click(System::TObject* Sender);
	void __fastcall ListButtonClick(System::TObject* Sender);
	void __fastcall ToolButton8Click(System::TObject* Sender);
	void __fastcall dbfieldsClick(System::TObject* Sender);
	void __fastcall PopupClick(System::TObject* Sender);
	void __fastcall AcceptBtnClick(System::TObject* Sender);
	void __fastcall CancelBtnClick(System::TObject* Sender);
	void __fastcall ToolButton9Click(System::TObject* Sender);
	void __fastcall ParamLabel1ParamEnter(System::TObject* Sender, System::UnicodeString href, System::UnicodeString value);
	void __fastcall ParamLabel1ParamExit(System::TObject* Sender, System::UnicodeString href, System::UnicodeString value);
	void __fastcall ToolButton12Click(System::TObject* Sender);
	void __fastcall ParamListBox1Click(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall SpeedButton3Click(System::TObject* Sender);
	void __fastcall SpeedButton4Click(System::TObject* Sender);
	
private:
	Classes::TStringList* fFieldNames;
	void __fastcall GetFontNames(void);
	void __fastcall SetFieldNames(const Classes::TStringList* Value);
	
public:
	__fastcall virtual Tparamlisteditor(Classes::TComponent* aOwner);
	__fastcall virtual ~Tparamlisteditor(void);
	void __fastcall InsertTags(System::UnicodeString starttag, System::UnicodeString endtag);
	bool __fastcall HasTags(System::UnicodeString starttag, System::UnicodeString endtag);
	void __fastcall RemoveTags(System::UnicodeString starttag, System::UnicodeString endtag);
	bool __fastcall ScanForward(System::UnicodeString starttag, System::UnicodeString endtag);
	bool __fastcall ScanBackward(System::UnicodeString starttag, System::UnicodeString endtag);
	void __fastcall ChangeTagProp(System::UnicodeString starttag, System::UnicodeString endtag, System::UnicodeString propname, System::UnicodeString propval);
	void __fastcall UpdateButtons(void);
	__property Classes::TStringList* FieldNames = {read=fFieldNames, write=SetFieldNames};
	System::UnicodeString __fastcall GetHTMLString(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual Tparamlisteditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall Tparamlisteditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Tparamlisteditor* paramlisteditor;

}	/* namespace Paramlistprop */
using namespace Paramlistprop;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ParamlistpropHPP
