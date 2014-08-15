// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ap_stdctrls.pas' rev: 21.00

#ifndef Ap_stdctrlsHPP
#define Ap_stdctrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Ap_types.hpp>	// Pascal unit
#include <Atscript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_stdctrls
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatStdCtrlsLibrary;
class PASCALIMPLEMENTATION TatStdCtrlsLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __TCustomGroupBoxCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomLabelCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomLabelGlowSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomLabelGlowSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditClearSelection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditCopyToClipboard(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditCutToClipboard(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditDefaultHandler(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditGetControlsAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditPasteFromClipboard(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditUndo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditClearUndo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditSetSelText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditSelectAll(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomEditAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomEditAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomEditCanUndo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomEditModified(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomEditModified(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomEditReadOnly(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomEditReadOnly(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomEditSelLength(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomEditSelLength(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomEditSelStart(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomEditSelStart(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomEditSelText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomEditSelText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomEditTextHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomEditTextHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomMemoCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomMemoDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomMemoCaretPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomMemoCaretPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomMemoLines(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomMemoLines(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboBoxStringsCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboBoxStringsDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboBoxStringsClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboBoxStringsDelete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboBoxStringsIndexOf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboAddItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboClearSelection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboCopySelection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboDeleteSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboFocused(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboGetCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboSelectAll(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboCanvas(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboDroppedDown(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboDroppedDown(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboSelLength(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboSelLength(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboSelStart(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboSelStart(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboBoxCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboBoxDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxAutoCompleteDelay(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxAutoCompleteDelay(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxAutoComplete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxAutoComplete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxAutoCloseUp(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxAutoCloseUp(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxAutoDropDown(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxAutoDropDown(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxCharCase(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxCharCase(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxSelText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxSelText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxTextHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxTextHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TButtonControlCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TImageMarginsAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCheckBoxCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomCheckBoxGetControlsAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TRadioButtonCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TRadioButtonGetControlsAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListBoxCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListBoxDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListBoxAddItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListBoxClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListBoxClearSelection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListBoxCopySelection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListBoxDeleteSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListBoxGetCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListBoxItemAtPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListBoxItemRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListBoxSelectAll(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListBoxAutoCompleteDelay(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListBoxAutoCompleteDelay(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListBoxAutoComplete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListBoxAutoComplete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListBoxCanvas(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListBoxCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListBoxCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListBoxItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListBoxItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListBoxSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListBoxSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListBoxScrollWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListBoxScrollWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListBoxTopIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListBoxTopIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScrollBarCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScrollBarSetParams(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomStaticTextCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditGetSelTextBuf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomEditSetSelTextBuf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomMemoGetControlsAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TButtonCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TButtonClick(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TButtonUseRightToLeftAlignment(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatStdCtrlsLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatStdCtrlsLibrary(void) { }
	
};


typedef TMetaClass* TCustomGroupBoxClass;

typedef TMetaClass* TGroupBoxClass;

typedef TMetaClass* TCustomLabelClass;

typedef TMetaClass* TLabelClass;

typedef TMetaClass* TCustomEditClass;

typedef TMetaClass* TEditClass;

typedef TMetaClass* TCustomMemoClass;

typedef TMetaClass* TMemoClass;

typedef TMetaClass* TCustomComboBoxStringsClass;

typedef TMetaClass* TCustomComboClass;

typedef TMetaClass* TCustomComboBoxClass;

typedef TMetaClass* TComboBoxClass;

typedef TMetaClass* TButtonActionLinkClass;

typedef TMetaClass* TButtonControlClass;

typedef TMetaClass* TImageMarginsClass;

typedef TMetaClass* TPushButtonActionLinkClass;

typedef TMetaClass* TCustomButtonClass;

typedef TMetaClass* TButtonClass;

typedef TMetaClass* TCustomCheckBoxClass;

typedef TMetaClass* TCheckBoxClass;

typedef TMetaClass* TRadioButtonClass;

typedef TMetaClass* TCustomListBoxClass;

typedef TMetaClass* TListBoxClass;

typedef TMetaClass* TScrollBarClass;

typedef TMetaClass* TCustomStaticTextClass;

typedef TMetaClass* TStaticTextClass;

class DELPHICLASS TatStdCtrlsDispatcher;
class PASCALIMPLEMENTATION TatStdCtrlsDispatcher : public Atscript::TatEventDispatcher
{
	typedef Atscript::TatEventDispatcher inherited;
	
private:
	void __fastcall __TMeasureItemEvent(Controls::TWinControl* Control, int Index, int &Height);
	void __fastcall __TLBGetDataEvent(Controls::TWinControl* Control, int Index, System::UnicodeString &Data);
	void __fastcall __TLBGetDataObjectEvent(Controls::TWinControl* Control, int Index, System::TObject* &DataObject);
	int __fastcall __TLBFindDataEvent(Controls::TWinControl* Control, System::UnicodeString FindString);
	void __fastcall __TScrollEvent(System::TObject* Sender, Stdctrls::TScrollCode ScrollCode, int &ScrollPos);
public:
	/* TatEventDispatcher.Create */ inline __fastcall virtual TatStdCtrlsDispatcher(Classes::TCollection* ACollection) : Atscript::TatEventDispatcher(ACollection) { }
	/* TatEventDispatcher.Destroy */ inline __fastcall virtual ~TatStdCtrlsDispatcher(void) { }
	
};


class DELPHICLASS TSelectionWrapper;
class PASCALIMPLEMENTATION TSelectionWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FStartPos;
	int FEndPos;
	
public:
	__fastcall TSelectionWrapper(const Stdctrls::TSelection &ARecord);
	Stdctrls::TSelection __fastcall ObjToRec(void);
	
__published:
	__property int StartPos = {read=FStartPos, write=FStartPos, nodefault};
	__property int EndPos = {read=FEndPos, write=FEndPos, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TSelectionWrapper(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_stdctrls */
using namespace Ap_stdctrls;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_stdctrlsHPP
