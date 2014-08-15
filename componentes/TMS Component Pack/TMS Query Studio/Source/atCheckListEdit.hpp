// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atCheckListEdit.pas' rev: 22.00

#ifndef AtchecklisteditHPP
#define AtchecklisteditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <CheckLst.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atchecklistedit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatDropForm;
class PASCALIMPLEMENTATION TatDropForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMClose(Messages::TMessage &Msg);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TatDropForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TatDropForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TatDropForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TatDropForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TatIntList;
class PASCALIMPLEMENTATION TatIntList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	int operator[](int index) { return Items[index]; }
	
private:
	void __fastcall SetInteger(int Index, int Value);
	int __fastcall GetInteger(int Index);
	
public:
	__fastcall TatIntList(void);
	__property int Items[int index] = {read=GetInteger, write=SetInteger/*, default*/};
	HIDESBASE void __fastcall Add(int Value);
	HIDESBASE void __fastcall Delete(int Index);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TatIntList(void) { }
	
};


class DELPHICLASS TatInplaceCheckListBox;
class DELPHICLASS TatCheckListEdit;
class PASCALIMPLEMENTATION TatInplaceCheckListBox : public Checklst::TCheckListBox
{
	typedef Checklst::TCheckListBox inherited;
	
private:
	TatCheckListEdit* fParentEdit;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	
protected:
	DYNAMIC void __fastcall DoExit(void);
	int __fastcall GetDropDownWidth(void);
	__property TatCheckListEdit* ParentEdit = {read=fParentEdit, write=fParentEdit};
public:
	/* TCheckListBox.Create */ inline __fastcall virtual TatInplaceCheckListBox(Classes::TComponent* AOwner) : Checklst::TCheckListBox(AOwner) { }
	/* TCheckListBox.Destroy */ inline __fastcall virtual ~TatInplaceCheckListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TatInplaceCheckListBox(HWND ParentWindow) : Checklst::TCheckListBox(ParentWindow) { }
	
};


class DELPHICLASS TatDropCheckListButton;
class PASCALIMPLEMENTATION TatDropCheckListButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	Controls::TWinControl* FFocusControl;
	Classes::TNotifyEvent FMouseClick;
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	DYNAMIC void __fastcall Click(void);
	__fastcall virtual TatDropCheckListButton(Classes::TComponent* AOwner);
	
__published:
	__property Controls::TWinControl* FocusControl = {read=FFocusControl, write=FFocusControl};
	__property Classes::TNotifyEvent MouseClick = {read=FMouseClick, write=FMouseClick};
public:
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TatDropCheckListButton(void) { }
	
};


typedef void __fastcall (__closure *TatCheckListItemToText)(System::TObject* sender, System::UnicodeString &aText);

typedef void __fastcall (__closure *TatTextToCheckListItem)(System::TObject* sender, System::UnicodeString &aItem);

#pragma option push -b-
enum TatDropDirection { ddDown, ddUp };
#pragma option pop

class PASCALIMPLEMENTATION TatCheckListEdit : public Stdctrls::TCustomEdit
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	TatDropCheckListButton* FButton;
	bool FEditorEnabled;
	Classes::TNotifyEvent FOnClickBtn;
	TatInplaceCheckListBox* FCheckListBox;
	Classes::TStringList* FItems;
	int FDropHeight;
	int FDropWidth;
	int FDropColumns;
	Graphics::TColor FDropColor;
	Graphics::TFont* FDropFont;
	bool FDropFlat;
	bool FDropSorted;
	TatDropDirection FDropDirection;
	bool FDroppedDown;
	bool CheckFlag;
	Forms::TForm* FChkForm;
	TatIntList* FIntList;
	bool FChkClosed;
	bool FCloseClick;
	System::UnicodeString FTextDelimiter;
	System::UnicodeString FTextStartChar;
	System::UnicodeString FTextEndChar;
	TatCheckListItemToText FOnCheckListItemToText;
	TatTextToCheckListItem FOnTextToCheckListItem;
	Classes::TNotifyEvent FOnClose;
	bool FAutoDropWidthSize;
	Classes::TNotifyEvent FAppNtfy;
	int __fastcall GetMinHeight(void);
	void __fastcall SetEditRect(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMPaste(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMCut(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSysKeyDown(Messages::TWMKey &Msg);
	void __fastcall ItemChange(System::TObject* Sender);
	void __fastcall CheckClick(System::TObject* Sender);
	void __fastcall CheckClickCheck(System::TObject* Sender);
	void __fastcall SetItems(Classes::TStringList* value);
	System::UnicodeString __fastcall CheckToString(void);
	void __fastcall StringToCheck(System::UnicodeString s);
	void __fastcall ShowCheckList(bool Focus);
	void __fastcall HideCheckList(void);
	bool __fastcall GetCheck(int i);
	void __fastcall SetCheck(int i, bool value);
	Stdctrls::TCheckBoxState __fastcall GetState(int i);
	void __fastcall SetState(int i, Stdctrls::TCheckBoxState value);
	void __fastcall FormDeactivate(System::TObject* Sender);
	void __fastcall AppDeactivate(System::TObject* Sender);
	void __fastcall SetTextDelimiter(const System::UnicodeString Value);
	void __fastcall SetTextEndChar(const System::UnicodeString Value);
	void __fastcall SetTextStartChar(const System::UnicodeString Value);
	void __fastcall MouseClick(System::TObject* Sender);
	void __fastcall DownClick(System::TObject* Sender);
	void __fastcall SetDropFont(const Graphics::TFont* Value);
	HIDESBASE System::UnicodeString __fastcall GetText(void);
	HIDESBASE void __fastcall SetText(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual Forms::TCustomForm* __fastcall GetParentForm(Controls::TControl* Control);
	
public:
	__fastcall virtual TatCheckListEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TatCheckListEdit(void);
	virtual void __fastcall Loaded(void);
	__property TatDropCheckListButton* Button = {read=FButton};
	__property bool Checked[int i] = {read=GetCheck, write=SetCheck};
	__property Stdctrls::TCheckBoxState State[int i] = {read=GetState, write=SetState};
	__property System::UnicodeString Text = {read=GetText, write=SetText};
	__property bool DroppedDown = {read=FDroppedDown, nodefault};
	
__published:
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property AutoSelect = {default=1};
	__property AutoSize = {default=1};
	__property bool AutoDropWidthSize = {read=FAutoDropWidthSize, write=FAutoDropWidthSize, nodefault};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property bool EditorEnabled = {read=FEditorEnabled, write=FEditorEnabled, default=1};
	__property Enabled = {default=1};
	__property Font;
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property Height;
	__property Width;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnEndDock;
	__property OnStartDock;
	__property Classes::TStringList* Items = {read=FItems, write=SetItems};
	__property int DropWidth = {read=FDropWidth, write=FDropWidth, nodefault};
	__property int DropHeight = {read=FDropHeight, write=FDropHeight, nodefault};
	__property int DropColumns = {read=FDropColumns, write=FDropColumns, nodefault};
	__property Graphics::TColor DropColor = {read=FDropColor, write=FDropColor, nodefault};
	__property bool DropFlat = {read=FDropFlat, write=FDropFlat, nodefault};
	__property Graphics::TFont* DropFont = {read=FDropFont, write=SetDropFont};
	__property TatDropDirection DropDirection = {read=FDropDirection, write=FDropDirection, nodefault};
	__property bool DropSorted = {read=FDropSorted, write=FDropSorted, nodefault};
	__property System::UnicodeString TextDelimiter = {read=FTextDelimiter, write=SetTextDelimiter};
	__property System::UnicodeString TextEndChar = {read=FTextEndChar, write=SetTextEndChar};
	__property System::UnicodeString TextStartChar = {read=FTextStartChar, write=SetTextStartChar};
	__property Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property Classes::TNotifyEvent OnClickBtn = {read=FOnClickBtn, write=FOnClickBtn};
	__property TatTextToCheckListItem OnTextToCheckListItem = {read=FOnTextToCheckListItem, write=FOnTextToCheckListItem};
	__property TatCheckListItemToText OnCheckListItemToText = {read=FOnCheckListItemToText, write=FOnCheckListItemToText};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TatCheckListEdit(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::ShortInt CL_CHECKED = 0x8;
static const System::ShortInt MAJ_VER = 0x1;
static const System::ShortInt MIN_VER = 0x2;
static const System::ShortInt REL_VER = 0x0;
static const System::ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Atchecklistedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atchecklistedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtchecklisteditHPP
