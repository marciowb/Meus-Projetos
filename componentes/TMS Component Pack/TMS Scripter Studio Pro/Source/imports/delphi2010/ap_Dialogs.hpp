// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ap_dialogs.pas' rev: 21.00

#ifndef Ap_dialogsHPP
#define Ap_dialogsHPP

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
#include <Commdlg.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Shlobj.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Ap_commdlg.hpp>	// Pascal unit
#include <Ap_types.hpp>	// Pascal unit
#include <Atscript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_dialogs
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatDialogsLibrary;
class PASCALIMPLEMENTATION TatDialogsLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __TCommonDialogCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCommonDialogDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCommonDialogExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCommonDialogDefaultHandler(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCommonDialogHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TOpenDialogCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TOpenDialogDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TOpenDialogExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTOpenDialogFileEditStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTOpenDialogFileEditStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTOpenDialogFiles(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTOpenDialogHistoryList(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTOpenDialogHistoryList(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TSaveDialogExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TColorDialogCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TColorDialogDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TColorDialogExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFontDialogCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFontDialogDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFontDialogExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPrinterSetupDialogExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPrintDialogExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPageSetupDialogCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPageSetupDialogExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPageSetupDialogGetDefaults(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPageSetupDialogPageSetupDlgRec(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFindDialogCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFindDialogDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFindDialogCloseDialog(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFindDialogExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFindDialogLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTFindDialogLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFindDialogPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTFindDialogPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFindDialogTop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTFindDialogTop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReplaceDialogCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFileTypeItemCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFileTypeItemDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFileTypeItemDisplayNameWStr(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFileTypeItemFileMaskWStr(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFileTypeItemsAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFileTypeItemsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTFileTypeItemsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFavoriteLinkItemsEnumeratorCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFavoriteLinkItemsEnumeratorGetCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFavoriteLinkItemsEnumeratorMoveNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFavoriteLinkItemsEnumeratorCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFavoriteLinkItemsAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFavoriteLinkItemsGetEnumerator(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFavoriteLinkItemsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTFavoriteLinkItemsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFileDialogCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFileDialogDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFileDialogExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFileDialogClientGuid(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFileDialogClientGuid(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFileDialogDefaultExtension(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFileDialogDefaultExtension(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFileDialogDefaultFolder(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFileDialogDefaultFolder(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFileDialogFavoriteLinks(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFileDialogFavoriteLinks(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFileDialogFileName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFileDialogFileName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFileDialogFileNameLabel(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFileDialogFileNameLabel(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFileDialogFiles(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFileDialogFileTypes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFileDialogFileTypes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFileDialogFileTypeIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFileDialogFileTypeIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFileDialogHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFileDialogOkButtonLabel(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFileDialogOkButtonLabel(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFileDialogOptions(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFileDialogOptions(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFileDialogTitle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFileDialogTitle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogProgressBarCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogProgressBarInitialize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogBaseButtonItemCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogBaseButtonItemDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogBaseButtonItemClick(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogBaseButtonItemSetInitialState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTaskDialogBaseButtonItemModalResult(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTaskDialogBaseButtonItemModalResult(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTaskDialogBaseButtonItemTextWStr(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogButtonItemCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogButtonItemSetInitialState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogRadioButtonItemCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogButtonsEnumeratorCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogButtonsEnumeratorGetCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogButtonsEnumeratorMoveNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTaskDialogButtonsEnumeratorCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogButtonsDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogButtonsAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogButtonsFindButton(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogButtonsGetEnumerator(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTaskDialogButtonsSetInitialState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTaskDialogButtonsDefaultButton(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTaskDialogButtonsDefaultButton(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTaskDialogButtonsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTaskDialogButtonsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTaskDialogCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTaskDialogDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTaskDialogExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogButton(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogButton(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogButtons(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogButtons(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogCaption(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogCaption(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogCommonButtons(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogCommonButtons(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogCustomFooterIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogCustomFooterIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogCustomMainIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogCustomMainIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogDefaultButton(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogDefaultButton(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogExpandButtonCaption(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogExpandButtonCaption(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogExpanded(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogExpandedText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogExpandedText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogFlags(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogFlags(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogFooterIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogFooterIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogFooterText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogFooterText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogHelpContext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogHelpContext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogMainIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogMainIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogModalResult(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogModalResult(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogProgressBar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogProgressBar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogRadioButton(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogRadioButtons(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogRadioButtons(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogTitle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogTitle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogURL(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTaskDialogVerificationText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTaskDialogVerificationText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CreateMessageDialog(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MessageDlg(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MessageDlgPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MessageDlgPosHelp(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TaskMessageDlg(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TaskMessageDlgPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TaskMessageDlgPosHelp(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ShowMessage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ShowMessagePos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __InputBox(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __InputQuery(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PromptForFileName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetForceCurrentDirectory(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetForceCurrentDirectory(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetUseLatestCommonDialogs(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetUseLatestCommonDialogs(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatDialogsLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatDialogsLibrary(void) { }
	
};


typedef TMetaClass* TCommonDialogClass;

typedef TMetaClass* TOpenDialogClass;

typedef TMetaClass* TSaveDialogClass;

typedef TMetaClass* TColorDialogClass;

typedef TMetaClass* TFontDialogClass;

typedef TMetaClass* TPrinterSetupDialogClass;

typedef TMetaClass* TPrintDialogClass;

typedef TMetaClass* TPageSetupDialogClass;

typedef TMetaClass* TFindDialogClass;

typedef TMetaClass* TReplaceDialogClass;

typedef TMetaClass* EPlatformVersionExceptionClass;

typedef TMetaClass* TFileTypeItemClass;

typedef TMetaClass* TFileTypeItemsClass;

typedef TMetaClass* TFavoriteLinkItemClass;

typedef TMetaClass* TFavoriteLinkItemsEnumeratorClass;

typedef TMetaClass* TFavoriteLinkItemsClass;

typedef TMetaClass* TCustomFileDialogClass;

typedef TMetaClass* TCustomFileOpenDialogClass;

typedef TMetaClass* TFileOpenDialogClass;

typedef TMetaClass* TCustomFileSaveDialogClass;

typedef TMetaClass* TFileSaveDialogClass;

typedef TMetaClass* TTaskDialogProgressBarClass;

typedef TMetaClass* TTaskDialogBaseButtonItemClass;

typedef TMetaClass* TTaskDialogButtonItemClass;

typedef TMetaClass* TTaskDialogRadioButtonItemClass;

typedef TMetaClass* TTaskDialogButtonsEnumeratorClass;

typedef TMetaClass* TTaskDialogButtonsClass;

typedef TMetaClass* TCustomTaskDialogClass;

typedef TMetaClass* TTaskDialogClass;

class DELPHICLASS TatDialogsDispatcher;
class PASCALIMPLEMENTATION TatDialogsDispatcher : public Atscript::TatEventDispatcher
{
	typedef Atscript::TatEventDispatcher inherited;
	
private:
	void __fastcall __TFDApplyEvent(System::TObject* Sender, HWND Wnd);
	void __fastcall __TPageSetupBeforePaintEvent(System::TObject* Sender, const short PaperSize, const Printers::TPrinterOrientation Orientation, const Dialogs::TPageType PageType, bool &DoneDrawing);
	void __fastcall __TFileDialogCloseEvent(System::TObject* Sender, bool &CanClose);
	void __fastcall __TFileDialogFolderChangingEvent(System::TObject* Sender, bool &CanChange);
	void __fastcall __TFileDialogOverwriteEvent(System::TObject* Sender, Dialogs::TFileDialogOverwriteResponse &Response);
	void __fastcall __TFileDialogShareViolationEvent(System::TObject* Sender, Dialogs::TFileDialogShareViolationResponse &Response);
	void __fastcall __TTaskDlgClickEvent(System::TObject* Sender, Controls::TModalResult ModalResult, bool &CanClose);
	void __fastcall __TTaskDlgTimerEvent(System::TObject* Sender, unsigned TickCount, bool &Reset);
public:
	/* TatEventDispatcher.Create */ inline __fastcall virtual TatDialogsDispatcher(Classes::TCollection* ACollection) : Atscript::TatEventDispatcher(ACollection) { }
	/* TatEventDispatcher.Destroy */ inline __fastcall virtual ~TatDialogsDispatcher(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_dialogs */
using namespace Ap_dialogs;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_dialogsHPP
