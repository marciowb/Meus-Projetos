// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Pickdlg.pas' rev: 21.00

#ifndef PickdlgHPP
#define PickdlgHPP

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
#include <Comctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Pickdlg
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TButtonPosition { bpBottom, bpRight, bpNone };
#pragma option pop

#pragma option push -b-
enum TDialogPosition { fposCenter, fposAbsolute, fposDefault };
#pragma option pop

typedef void __fastcall (__closure *TClickItemEvent)(System::TObject* Sender, int index, System::UnicodeString itemstr);

typedef void __fastcall (__closure *TDblClickItemEvent)(System::TObject* Sender, int index, System::UnicodeString itemstr);

class DELPHICLASS TSelectForm;
class DELPHICLASS TPickDialog;
class PASCALIMPLEMENTATION TSelectForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TListBox* SelectList;
	Stdctrls::TButton* okbtn;
	Stdctrls::TButton* cancelbtn;
	Stdctrls::TLabel* title;
	void __fastcall okbtnClick(System::TObject* Sender);
	void __fastcall cancelbtnClick(System::TObject* Sender);
	void __fastcall SelectListDblClick(System::TObject* Sender);
	void __fastcall SelectListClick(System::TObject* Sender);
	
private:
	TPickDialog* fparentcontrol;
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TMessage &Message);
	MESSAGE void __fastcall WMMinMaxInfo(Messages::TMessage &Message);
	
public:
	int cresizex;
	int cresizey;
	TButtonPosition fbuttonpos;
	bool acceptdblclick;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSelectForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSelectForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSelectForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSelectForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TPickDialog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	System::UnicodeString fCaption;
	System::UnicodeString fTitle;
	Classes::TStringList* fPickList;
	int fSelectIndex;
	System::UnicodeString fSelectString;
	Classes::TStringList* fSelectList;
	TButtonPosition fbuttonpos;
	bool fmultisel;
	bool fsort;
	bool fshowtitle;
	TDialogPosition fDialogPosition;
	bool fDblClick;
	int fHeight;
	int fWidth;
	int fTopPosition;
	int fLeftPosition;
	System::UnicodeString fCancelCaption;
	System::UnicodeString fOkCaption;
	System::TObject* fSelectData;
	bool fSizeable;
	bool fToolWindow;
	TSelectForm* fSelectForm;
	int fCount;
	TClickItemEvent fOnClickItem;
	TDblClickItemEvent fOnDblClickItem;
	void __fastcall SetPickList(Classes::TStringList* value);
	void __fastcall SetHeight(int value);
	void __fastcall SetWidth(int value);
	void __fastcall CreateSelect(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TPickDialog(Classes::TComponent* aOwner);
	__fastcall virtual ~TPickDialog(void);
	int __fastcall Execute(void);
	void __fastcall Show(void);
	void __fastcall Hide(void);
	__property int SelectIndex = {read=fSelectIndex, write=fSelectIndex, nodefault};
	__property System::UnicodeString SelectString = {read=fSelectString};
	__property System::TObject* SelectData = {read=fSelectData};
	__property Classes::TStringList* SelectList = {read=fSelectList};
	
__published:
	__property Classes::TStringList* PickItems = {read=fPickList, write=SetPickList};
	__property System::UnicodeString Caption = {read=fCaption, write=fCaption};
	__property System::UnicodeString Title = {read=fTitle, write=fTitle};
	__property bool MultiSel = {read=fmultisel, write=fmultisel, nodefault};
	__property bool AcceptDblClick = {read=fDblClick, write=fDblClick, nodefault};
	__property bool Sort = {read=fsort, write=fsort, nodefault};
	__property bool ShowTitle = {read=fshowtitle, write=fshowtitle, nodefault};
	__property TButtonPosition ButtonPosition = {read=fbuttonpos, write=fbuttonpos, nodefault};
	__property int Width = {read=fWidth, write=SetWidth, nodefault};
	__property int Height = {read=fHeight, write=SetHeight, nodefault};
	__property int TopPosition = {read=fTopPosition, write=fTopPosition, nodefault};
	__property int LeftPosition = {read=fLeftPosition, write=fLeftPosition, nodefault};
	__property TDialogPosition DialogPosition = {read=fDialogPosition, write=fDialogPosition, nodefault};
	__property System::UnicodeString CancelCaption = {read=fCancelCaption, write=fCancelCaption};
	__property System::UnicodeString OkCaption = {read=fOkCaption, write=fOkCaption};
	__property bool Sizeable = {read=fSizeable, write=fSizeable, nodefault};
	__property bool ToolWindow = {read=fToolWindow, write=fToolWindow, nodefault};
	__property TClickItemEvent OnClickItem = {read=fOnClickItem, write=fOnClickItem};
	__property TDblClickItemEvent OnDblClickItem = {read=fOnDblClickItem, write=fOnDblClickItem};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Pickdlg */
using namespace Pickdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PickdlgHPP
