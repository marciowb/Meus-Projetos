// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ap_extctrls.pas' rev: 21.00

#ifndef Ap_extctrlsHPP
#define Ap_extctrlsHPP

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
#include <Contnrs.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Graphutil.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Ap_types.hpp>	// Pascal unit
#include <Atscript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_extctrls
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatExtCtrlsLibrary;
class PASCALIMPLEMENTATION TatExtCtrlsLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __TShapeCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TShapeDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPaintBoxCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TImageCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TImageDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTImageCanvas(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBevelCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTimerCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTimerDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomPanelCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomPanelGetControlsAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFlowPanelCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFlowPanelDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFlowPanelGetControlIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFlowPanelSetControlIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFlowPanelAutoWrap(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFlowPanelAutoWrap(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFlowPanelFlowStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFlowPanelFlowStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCellItemCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCellCollectionOwner(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCellCollectionItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCellCollectionItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TRowCollectionCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TRowCollectionAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TColumnCollectionCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TColumnCollectionAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlItemCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlItemDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlItemSetLocation(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlCollectionCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlCollectionAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlCollectionAddControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlCollectionRemoveControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlCollectionIndexOf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlCollectionOwner(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlCollectionControls(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlCollectionControls(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlCollectionControlItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlCollectionItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlCollectionItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGridPanelCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGridPanelDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGridPanelIsColumnEmpty(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGridPanelIsRowEmpty(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGridPanelColumnSpanIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGridPanelCellCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGridPanelCellSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGridPanelCellRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGridPanelColumnCollection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomGridPanelColumnCollection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGridPanelControlCollection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomGridPanelControlCollection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGridPanelExpandStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomGridPanelExpandStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGridPanelRowCollection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomGridPanelRowCollection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGridPanelRowSpanIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPageCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TNotebookCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TNotebookDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THeaderCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THeaderDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTHeaderSectionWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTHeaderSectionWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomRadioGroupCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomRadioGroupDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomRadioGroupFlipChildren(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomRadioGroupButtons(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomRadioGroupWordWrap(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomRadioGroupWordWrap(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TSplitterCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TSplitterDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomControlBarCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomControlBarDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomControlBarFlipChildren(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomControlBarStickControls(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomControlBarPicture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomControlBarPicture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBoundLabelCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomLabeledEditCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomLabeledEditSetBounds(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomLabeledEditSetupInternalLabel(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomLabeledEditEditLabel(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomLabeledEditLabelPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomLabeledEditLabelPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomLabeledEditLabelSpacing(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomLabeledEditLabelSpacing(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomButtonedEditCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomButtonedEditDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomButtonedEditDefaultHandler(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomButtonedEditImages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomButtonedEditImages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomButtonedEditLeftButton(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomButtonedEditLeftButton(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomButtonedEditRightButton(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomButtonedEditRightButton(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomColorBoxCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomColorBoxStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomColorBoxStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomColorBoxColors(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomColorBoxColorNames(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomColorBoxSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomColorBoxSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomColorBoxDefaultColorColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomColorBoxDefaultColorColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomColorBoxNoneColorColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomColorBoxNoneColorColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomColorListBoxCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomColorListBoxStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomColorListBoxStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomColorListBoxColors(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomColorListBoxColorNames(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomColorListBoxSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomColorListBoxSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomColorListBoxDefaultColorColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomColorListBoxDefaultColorColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomColorListBoxNoneColorColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomColorListBoxNoneColorColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTrayIconCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTrayIconDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTrayIconRefresh(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTrayIconSetDefaultIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTrayIconShowBalloonHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTrayIconAnimate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTrayIconAnimate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTrayIconAnimateInterval(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTrayIconAnimateInterval(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTrayIconHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTrayIconHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTrayIconBalloonHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTrayIconBalloonHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTrayIconBalloonTitle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTrayIconBalloonTitle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTrayIconBalloonTimeout(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTrayIconBalloonTimeout(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTrayIconBalloonFlags(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTrayIconBalloonFlags(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTrayIconIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTrayIconIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTrayIconIcons(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTrayIconIcons(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTrayIconIconIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTrayIconIconIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTrayIconPopupMenu(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTrayIconPopupMenu(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTrayIconVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTrayIconVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCategoryPanelSurfaceCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Frame3D(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __NotebookHandlesNeeded(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatExtCtrlsLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatExtCtrlsLibrary(void) { }
	
};


typedef TMetaClass* TShapeClass;

typedef TMetaClass* TPaintBoxClass;

typedef TMetaClass* TImageClass;

typedef TMetaClass* TBevelClass;

typedef TMetaClass* TTimerClass;

typedef TMetaClass* TCustomPanelClass;

typedef TMetaClass* TPanelClass;

typedef TMetaClass* TCustomFlowPanelClass;

typedef TMetaClass* TFlowPanelClass;

typedef TMetaClass* EGridPanelExceptionClass;

typedef TMetaClass* TCellItemClass;

typedef TMetaClass* TRowItemClass;

typedef TMetaClass* TColumnItemClass;

typedef TMetaClass* TCellCollectionClass;

typedef TMetaClass* TRowCollectionClass;

typedef TMetaClass* TColumnCollectionClass;

typedef TMetaClass* TControlItemClass;

typedef TMetaClass* TControlCollectionClass;

typedef TMetaClass* TCustomGridPanelClass;

typedef TMetaClass* TGridPanelClass;

typedef TMetaClass* TPageClass;

typedef TMetaClass* TNotebookClass;

typedef TMetaClass* THeaderClass;

typedef TMetaClass* TCustomRadioGroupClass;

typedef TMetaClass* TRadioGroupClass;

typedef TMetaClass* TSplitterClass;

typedef TMetaClass* TCustomControlBarClass;

typedef TMetaClass* TControlBarClass;

typedef TMetaClass* TBoundLabelClass;

typedef TMetaClass* TCustomLabeledEditClass;

typedef TMetaClass* TLabeledEditClass;

typedef TMetaClass* TEditButtonClass;

typedef TMetaClass* TCustomButtonedEditClass;

typedef TMetaClass* TButtonedEditClass;

typedef TMetaClass* TCustomColorBoxClass;

typedef TMetaClass* TColorBoxClass;

typedef TMetaClass* TCustomColorListBoxClass;

typedef TMetaClass* TColorListBoxClass;

typedef TMetaClass* TCustomTrayIconClass;

typedef TMetaClass* TTrayIconClass;

typedef TMetaClass* TCategoryPanelSurfaceClass;

typedef TMetaClass* TCustomCategoryPanelClass;

typedef TMetaClass* TCategoryPanelClass;

typedef TMetaClass* TCustomCategoryPanelGroupClass;

typedef TMetaClass* TCategoryPanelGroupClass;

typedef TMetaClass* TCustomLinkLabelClass;

typedef TMetaClass* TLinkLabelClass;

class DELPHICLASS TatExtCtrlsDispatcher;
class PASCALIMPLEMENTATION TatExtCtrlsDispatcher : public Atscript::TatEventDispatcher
{
	typedef Atscript::TatEventDispatcher inherited;
	
private:
	void __fastcall __TSectionEvent(System::TObject* Sender, int ASection, int AWidth);
	void __fastcall __TSplitterCanResizeEvent(System::TObject* Sender, int &NewSize, bool &Accept);
	void __fastcall __TCanResizeEvent(System::TObject* Sender, int &NewSize, bool &Accept);
	void __fastcall __TBandDragEvent(System::TObject* Sender, Controls::TControl* Control, bool &Drag);
	void __fastcall __TBeginBandMoveEvent(System::TObject* Sender, Controls::TControl* Control, bool &AllowMove);
	void __fastcall __TEndBandMoveEvent(System::TObject* Sender, Controls::TControl* Control);
	void __fastcall __TGetColorsEvent(Extctrls::TCustomColorBox* Sender, Classes::TStrings* Items);
	void __fastcall __TLBGetColorsEvent(Extctrls::TCustomColorListBox* Sender, Classes::TStrings* Items);
	void __fastcall __TSysLinkEvent(System::TObject* Sender, const System::UnicodeString Link, Extctrls::TSysLinkType LinkType);
public:
	/* TatEventDispatcher.Create */ inline __fastcall virtual TatExtCtrlsDispatcher(Classes::TCollection* ACollection) : Atscript::TatEventDispatcher(ACollection) { }
	/* TatEventDispatcher.Destroy */ inline __fastcall virtual ~TatExtCtrlsDispatcher(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_extctrls */
using namespace Ap_extctrls;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_extctrlsHPP
