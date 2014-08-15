// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ap_ComCtrls.pas' rev: 22.00

#ifndef Ap_comctrlsHPP
#define Ap_comctrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <CommCtrl.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <RichEdit.hpp>	// Pascal unit
#include <ToolWin.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ListActns.hpp>	// Pascal unit
#include <ShlObj.hpp>	// Pascal unit
#include <GraphUtil.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <ap_Types.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_comctrls
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatComCtrlsLibrary;
class PASCALIMPLEMENTATION TatComCtrlsLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __TCustomTabControlCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTabControlDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTabControlIndexOfTabAt(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTabControlGetHitTestInfoAt(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTabControlTabRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTabControlRowCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTabControlScrollTabs(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTabControlCanvas(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTabSheetCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTabSheetDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTabSheetPageControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTabSheetPageControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTabSheetTabIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPageControlCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPageControlDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPageControlFindNextPage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPageControlSelectNextPage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPageControlActivePageIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTPageControlActivePageIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPageControlPageCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTPageControlPages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStatusPanelCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStatusPanelAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStatusPanelParentBiDiModeChanged(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStatusPanelUseRightToLeftAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStatusPanelUseRightToLeftReading(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStatusPanelsCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStatusPanelsAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStatusPanelsAddItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStatusPanelsInsert(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStatusPanelsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStatusPanelsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomStatusBarCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomStatusBarDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomStatusBarExecuteAction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomStatusBarFlipChildren(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomStatusBarSetBounds(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomStatusBarCanvas(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomStatusBarAutoHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomStatusBarAutoHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomStatusBarPanels(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomStatusBarPanels(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomStatusBarSimplePanel(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomStatusBarSimplePanel(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomStatusBarSimpleText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomStatusBarSimpleText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomStatusBarSizeGrip(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomStatusBarSizeGrip(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomStatusBarUseSystemFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomStatusBarUseSystemFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THeaderSectionCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THeaderSectionAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THeaderSectionParentBiDiModeChanged(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THeaderSectionUseRightToLeftAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THeaderSectionUseRightToLeftReading(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTHeaderSectionLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTHeaderSectionRight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THeaderSectionsCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THeaderSectionsAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THeaderSectionsAddItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THeaderSectionsInsert(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTHeaderSectionsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTHeaderSectionsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHeaderControlCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHeaderControlDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHeaderControlFlipChildren(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomHeaderControlCanvas(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeAlphaSort(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeCollapse(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeDelete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeDeleteChildren(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeDisplayRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeEditText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeEndEdit(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeExpand(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodegetFirstChild(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeGetHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeGetLastChild(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeGetNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeGetNextChild(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodegetNextSibling(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeGetNextVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeGetPrev(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeGetPrevChild(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodegetPrevSibling(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeGetPrevVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeHasAsParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeIndexOf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeMakeVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeMoveTo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodeIsFirstNode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeAbsoluteIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeCut(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeCut(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeDeleting(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeFocused(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeFocused(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeDropTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeDropTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeExpanded(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeExpanded(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeExpandedImageIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeExpandedImageIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeHasChildren(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeHasChildren(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeImageIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeImageIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeIsVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeLevel(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeOverlayIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeOverlayIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeOwner(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeSelectedIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeSelectedIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeEnabled(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeEnabled(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeStateIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeStateIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTreeNodeText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodeTreeView(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesEnumeratorCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesEnumeratorGetCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesEnumeratorMoveNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodesEnumeratorCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesAddChildFirst(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesAddChild(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesAddFirst(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesAlphaSort(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesBeginUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesDelete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesEndUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesGetFirstNode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesGetEnumerator(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTreeNodesInsert(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodesCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodesHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodesItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTreeNodesOwner(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewAlphaSort(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewFullCollapse(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewFullExpand(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewGetHitTestInfoAt(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewGetNodeAt(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewGetDragImages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewIsEditing(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewLoadFromFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewLoadFromStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewSaveToFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewSaveToStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewSelect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewDeselect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewSubselect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewClearSelection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewGetSelections(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTreeViewFindNextToSelect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTreeViewCanvas(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTreeViewDropTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTreeViewDropTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTreeViewSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTreeViewSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTreeViewTopItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTreeViewTopItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTreeViewSelectionCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTreeViewSelections(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTrackBarCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTrackBarSetTick(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TProgressBarCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TProgressBarStepIt(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TProgressBarStepBy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTextAttributesCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTextAttributesAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTextAttributesCharset(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTextAttributesCharset(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTextAttributesColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTextAttributesColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTextAttributesConsistentAttributes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTextAttributesName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTextAttributesName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTextAttributesPitch(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTextAttributesPitch(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTextAttributesProtected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTextAttributesProtected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTextAttributesSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTextAttributesSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTextAttributesStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTextAttributesStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTTextAttributesHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTTextAttributesHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParaAttributesCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParaAttributesAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTParaAttributesAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTParaAttributesAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTParaAttributesFirstIndent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTParaAttributesFirstIndent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTParaAttributesLeftIndent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTParaAttributesLeftIndent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTParaAttributesNumbering(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTParaAttributesNumbering(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTParaAttributesRightIndent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTParaAttributesRightIndent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTParaAttributesTab(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTParaAttributesTab(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTParaAttributesTabCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTParaAttributesTabCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TConversionCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TConversionConvertReadStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TConversionConvertWriteStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomRichEditCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomRichEditDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomRichEditClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomRichEditFindText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomRichEditPrint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomRichEditGetSelTextBuf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomRichEditActiveLineNo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomRichEditDefAttributes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomRichEditDefAttributes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomRichEditSelAttributes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomRichEditSelAttributes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomRichEditPageRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomRichEditPageRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomRichEditParagraph(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomUpDownCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHotKeyCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListGroupCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListGroupDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListGroupAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListGroupsCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListGroupsAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListGroupsOwner(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListGroupsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListGroupsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListGroupsNextGroupID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListColumnCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListColumnDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListColumnAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListColumnWidthType(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListColumnsCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListColumnsAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListColumnsOwner(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListColumnsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListColumnsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemCancelEdit(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemDelete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemDisplayRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemEditCaption(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemGetPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemMakeVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemSetPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemWorkArea(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemCaption(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemCaption(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemChecked(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemChecked(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemCut(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemCut(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemDeleting(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemDropTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemDropTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemFocused(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemFocused(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemGroupID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemGroupID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemImageIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemImageIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemIndent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemIndent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemListView(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemOwner(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemOverlayIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemOverlayIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemStateIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemStateIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemSubItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemSubItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemSubItemImages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemSubItemImages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemTop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemTop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsEnumeratorCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsEnumeratorGetCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsEnumeratorMoveNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemsEnumeratorCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsAddItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsBeginUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsDelete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsEndUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsGetEnumerator(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsIndexOf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListItemsInsert(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemsCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemsCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemsHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemsItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListItemsItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListItemsOwner(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWorkAreaCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWorkAreaSetDisplayName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWorkAreaGetDisplayName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWorkAreaRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWorkAreaRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWorkAreaColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWorkAreaColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWorkAreasAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWorkAreasDelete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWorkAreasInsert(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWorkAreasItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWorkAreasItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TIconOptionsCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewAddItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewAlphaSort(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewArrange(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewClearSelection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewCopySelection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewDeleteSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewFindCaption(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewGetCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewGetHitTestInfoAt(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewGetItemAt(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewGetNearestItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewGetNextItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewGetSearchString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewIsEditing(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewSelectAll(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewScroll(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewGetDragImages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewStringWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListViewUpdateItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewCanvas(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewCheckboxes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListViewCheckboxes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewColumn(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewDropTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListViewDropTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewFlatScrollBars(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListViewFlatScrollBars(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewFullDrag(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListViewFullDrag(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewGridLines(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListViewGridLines(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewHotTrack(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListViewHotTrack(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewHotTrackStyles(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListViewHotTrackStyles(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewItemFocused(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListViewItemFocused(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListViewItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewRowSelect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListViewRowSelect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewSelCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListViewSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewTopItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewViewOrigin(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewVisibleRowCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewBoundingRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListViewWorkAreas(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TAnimateCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TAnimatePlay(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TAnimateReset(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TAnimateSeek(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TAnimateStop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTAnimateFrameCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTAnimateFrameHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTAnimateFrameWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTAnimateOpen(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTAnimateOpen(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTAnimateResHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTAnimateResHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTAnimateResId(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTAnimateResId(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTAnimateResName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTAnimateResName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TToolButtonCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TToolButtonCheckMenuDropdown(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TToolButtonClick(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TToolButtonSetBounds(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTToolButtonIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TToolBarEnumeratorCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TToolBarEnumeratorGetCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TToolBarEnumeratorMoveNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTToolBarEnumeratorCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TToolBarCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TToolBarDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TToolBarFlipChildren(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TToolBarGetEnumerator(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TToolBarTrackMenu(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTToolBarButtonCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTToolBarButtons(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTToolBarCanvas(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTToolBarCustomizeKeyName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTToolBarCustomizeKeyName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTToolBarCustomizeValueName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTToolBarCustomizeValueName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTToolBarRowCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCoolBandCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCoolBandDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCoolBandAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCoolBandHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCoolBandsCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCoolBandsDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCoolBandsAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCoolBandsFindBand(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCoolBandsCoolBar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCoolBandsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCoolBandsItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCoolBarCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCoolBarDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCoolBarFlipChildren(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMonthCalColorsCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMonthCalColorsAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCommonCalendarCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCommonCalendarDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMonthCalendarCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDateTimePickerCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDateTimePickerDroppedDown(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPageScrollerCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPageScrollerGetButtonState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboExItemAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboExItemsAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboExItemsInsert(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTComboExItemsComboItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsAddObject(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsDelete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsExchange(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsGet(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsGetCapacity(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsGetCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsGetObject(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsIndexOf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsIndexOfName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsInsert(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComboBoxExStringsMove(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTComboBoxExStringsSortType(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTComboBoxExStringsSortType(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTComboBoxExStringsItemsEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTComboBoxExStringsItemsEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboBoxExCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboBoxExDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomComboBoxExFocused(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxExAutoCompleteOptions(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxExAutoCompleteOptions(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxExDropDownCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxExDropDownCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxExImages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxExImages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxExItemsEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxExItemsEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxExSelText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxExSelText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxExStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxExStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomComboBoxExStyleEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomComboBoxExStyleEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __InitCommonControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CheckCommonControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetComCtlVersion(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CheckToolMenuDropdown(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatComCtrlsLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatComCtrlsLibrary(void) { }
	
};


typedef TMetaClass* TCustomTabControlClass;

typedef TMetaClass* TTabControlClass;

typedef TMetaClass* TTabSheetClass;

typedef TMetaClass* TPageControlClass;

typedef TMetaClass* TStatusPanelClass;

typedef TMetaClass* TStatusPanelsClass;

typedef TMetaClass* TCustomStatusBarClass;

typedef TMetaClass* TStatusBarClass;

typedef TMetaClass* THeaderSectionClass;

typedef TMetaClass* THeaderSectionsClass;

typedef TMetaClass* TCustomHeaderControlClass;

typedef TMetaClass* THeaderControlClass;

typedef TMetaClass* TTreeNodeClass;

typedef TMetaClass* TTreeNodesEnumeratorClass;

typedef TMetaClass* TTreeNodesClass;

typedef TMetaClass* ETreeViewErrorClass;

typedef TMetaClass* TCustomTreeViewClass;

typedef TMetaClass* TTreeViewClass;

typedef TMetaClass* TTrackBarClass;

typedef TMetaClass* TProgressBarClass;

typedef TMetaClass* TTextAttributesClass;

typedef TMetaClass* TParaAttributesClass;

typedef TMetaClass* TConversionClass;

typedef TMetaClass* TCustomRichEditClass;

typedef TMetaClass* TRichEditClass;

typedef TMetaClass* TCustomUpDownClass;

typedef TMetaClass* TUpDownClass;

typedef TMetaClass* TCustomHotKeyClass;

typedef TMetaClass* THotKeyClass;

typedef TMetaClass* TListGroupClass;

typedef TMetaClass* TListGroupsClass;

typedef TMetaClass* TListColumnClass;

typedef TMetaClass* TListColumnsClass;

typedef TMetaClass* TListItemClass;

typedef TMetaClass* TListItemsEnumeratorClass;

typedef TMetaClass* TListItemsClass;

typedef TMetaClass* TWorkAreaClass;

typedef TMetaClass* TWorkAreasClass;

typedef TMetaClass* TIconOptionsClass;

typedef TMetaClass* TCustomListViewClass;

typedef TMetaClass* TListViewClass;

typedef TMetaClass* TListViewActionLinkClass;

typedef TMetaClass* TAnimateClass;

typedef TMetaClass* TToolButtonActionLinkClass;

typedef TMetaClass* TToolButtonClass;

typedef TMetaClass* TToolBarEnumeratorClass;

typedef TMetaClass* TToolBarClass;

typedef TMetaClass* TToolBarDockObjectClass;

typedef TMetaClass* TCoolBandClass;

typedef TMetaClass* TCoolBandsClass;

typedef TMetaClass* TCoolBarClass;

typedef TMetaClass* ECommonCalendarErrorClass;

typedef TMetaClass* TMonthCalColorsClass;

typedef TMetaClass* TCommonCalendarClass;

typedef TMetaClass* EMonthCalErrorClass;

typedef TMetaClass* TMonthCalendarClass;

typedef TMetaClass* EDateTimeErrorClass;

typedef TMetaClass* TDateTimeColorsClass;

typedef TMetaClass* TDateTimePickerClass;

typedef TMetaClass* TPageScrollerClass;

typedef TMetaClass* TComboExItemClass;

typedef TMetaClass* TComboExItemsClass;

typedef TMetaClass* TComboBoxExStringsClass;

typedef TMetaClass* TCustomComboBoxExClass;

typedef TMetaClass* TComboBoxExClass;

typedef TMetaClass* TComboBoxExActionLinkClass;

class DELPHICLASS TatComCtrlsDispatcher;
class PASCALIMPLEMENTATION TatComCtrlsDispatcher : public Atscript::TatEventDispatcher
{
	typedef Atscript::TatEventDispatcher inherited;
	
private:
	void __fastcall __TTabChangingEvent(System::TObject* Sender, bool &AllowChange);
	void __fastcall __TTabGetImageEvent(System::TObject* Sender, int TabIndex, int &ImageIndex);
	void __fastcall __TCustomSectionNotifyEvent(Comctrls::TCustomHeaderControl* HeaderControl, Comctrls::THeaderSection* Section);
	void __fastcall __TCustomSectionTrackEvent(Comctrls::TCustomHeaderControl* HeaderControl, Comctrls::THeaderSection* Section, int Width, Comctrls::TSectionTrackState State);
	void __fastcall __TSectionDragEvent(System::TObject* Sender, Comctrls::THeaderSection* FromSection, Comctrls::THeaderSection* ToSection, bool &AllowDrag);
	void __fastcall __TSectionNotifyEvent(Comctrls::THeaderControl* HeaderControl, Comctrls::THeaderSection* Section);
	void __fastcall __TSectionTrackEvent(Comctrls::THeaderControl* HeaderControl, Comctrls::THeaderSection* Section, int Width, Comctrls::TSectionTrackState State);
	void __fastcall __TTVChangingEvent(System::TObject* Sender, Comctrls::TTreeNode* Node, bool &AllowChange);
	void __fastcall __TTVChangedEvent(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall __TTVEditingEvent(System::TObject* Sender, Comctrls::TTreeNode* Node, bool &AllowEdit);
	void __fastcall __TTVEditedEvent(System::TObject* Sender, Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall __TTVExpandingEvent(System::TObject* Sender, Comctrls::TTreeNode* Node, bool &AllowExpansion);
	void __fastcall __TTVCollapsingEvent(System::TObject* Sender, Comctrls::TTreeNode* Node, bool &AllowCollapse);
	void __fastcall __TTVExpandedEvent(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall __TTVCompareEvent(System::TObject* Sender, Comctrls::TTreeNode* Node1, Comctrls::TTreeNode* Node2, int Data, int &Compare);
	void __fastcall __TTVHintEvent(System::TObject* Sender, const Comctrls::TTreeNode* Node, System::UnicodeString &Hint);
	void __fastcall __TTVCustomDrawItemEvent(Comctrls::TCustomTreeView* Sender, Comctrls::TTreeNode* Node, Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall __TTVAdvancedCustomDrawItemEvent(Comctrls::TCustomTreeView* Sender, Comctrls::TTreeNode* Node, Comctrls::TCustomDrawState State, Comctrls::TCustomDrawStage Stage, bool &PaintImages, bool &DefaultDraw);
	void __fastcall __TRichEditProtectChange(System::TObject* Sender, int StartPos, int EndPos, bool &AllowChange);
	void __fastcall __TRichEditSaveClipboard(System::TObject* Sender, int NumObjects, int NumChars, bool &SaveClipboard);
	void __fastcall __TUDClickEvent(System::TObject* Sender, Comctrls::TUDBtnType Button);
	void __fastcall __TUDChangingEvent(System::TObject* Sender, bool &AllowChange);
	void __fastcall __TUDChangingEventEx(System::TObject* Sender, bool &AllowChange, short NewValue, Comctrls::TUpDownDirection Direction);
	void __fastcall __TLVDeletedEvent(System::TObject* Sender, Comctrls::TListItem* Item);
	void __fastcall __TLVEditingEvent(System::TObject* Sender, Comctrls::TListItem* Item, bool &AllowEdit);
	void __fastcall __TLVEditedEvent(System::TObject* Sender, Comctrls::TListItem* Item, System::UnicodeString &S);
	void __fastcall __TLVChangeEvent(System::TObject* Sender, Comctrls::TListItem* Item, Comctrls::TItemChange Change);
	void __fastcall __TLVChangingEvent(System::TObject* Sender, Comctrls::TListItem* Item, Comctrls::TItemChange Change, bool &AllowChange);
	void __fastcall __TLVColumnClickEvent(System::TObject* Sender, Comctrls::TListColumn* Column);
	void __fastcall __TLVCompareEvent(System::TObject* Sender, Comctrls::TListItem* Item1, Comctrls::TListItem* Item2, int Data, int &Compare);
	void __fastcall __TLVDrawItemEvent(Comctrls::TCustomListView* Sender, Comctrls::TListItem* Item, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall __TLVNotifyEvent(System::TObject* Sender, Comctrls::TListItem* Item);
	void __fastcall __TLVSelectItemEvent(System::TObject* Sender, Comctrls::TListItem* Item, bool Selected);
	void __fastcall __TLVCheckedItemEvent(System::TObject* Sender, Comctrls::TListItem* Item);
	void __fastcall __TLVCustomDrawItemEvent(Comctrls::TCustomListView* Sender, Comctrls::TListItem* Item, Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall __TLVCustomDrawSubItemEvent(Comctrls::TCustomListView* Sender, Comctrls::TListItem* Item, int SubItem, Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall __TLVAdvancedCustomDrawItemEvent(Comctrls::TCustomListView* Sender, Comctrls::TListItem* Item, Comctrls::TCustomDrawState State, Comctrls::TCustomDrawStage Stage, bool &DefaultDraw);
	void __fastcall __TLVAdvancedCustomDrawSubItemEvent(Comctrls::TCustomListView* Sender, Comctrls::TListItem* Item, int SubItem, Comctrls::TCustomDrawState State, Comctrls::TCustomDrawStage Stage, bool &DefaultDraw);
	void __fastcall __TLVOwnerDataEvent(System::TObject* Sender, Comctrls::TListItem* Item);
	void __fastcall __TLVOwnerDataHintEvent(System::TObject* Sender, int StartIndex, int EndIndex);
	void __fastcall __TLVOwnerDataStateChangeEvent(System::TObject* Sender, int StartIndex, int EndIndex, Comctrls::TItemStates OldState, Comctrls::TItemStates NewState);
	void __fastcall __TLVSubItemImageEvent(System::TObject* Sender, Comctrls::TListItem* Item, int SubItem, int &ImageIndex);
	void __fastcall __TLVInfoTipEvent(System::TObject* Sender, Comctrls::TListItem* Item, System::UnicodeString &InfoTip);
	void __fastcall __TTBCustomDrawBtnEvent(Comctrls::TToolBar* Sender, Comctrls::TToolButton* Button, Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall __TTBAdvancedCustomDrawBtnEvent(Comctrls::TToolBar* Sender, Comctrls::TToolButton* Button, Comctrls::TCustomDrawState State, Comctrls::TCustomDrawStage Stage, Comctrls::TTBCustomDrawFlags &Flags, bool &DefaultDraw);
	void __fastcall __TTBCustomizeQueryEvent(Comctrls::TToolBar* Sender, int Index, bool &Allow);
	void __fastcall __TTBNewButtonEvent(Comctrls::TToolBar* Sender, int Index, Comctrls::TToolButton* &Button);
	void __fastcall __TTBButtonEvent(Comctrls::TToolBar* Sender, Comctrls::TToolButton* Button);
	void __fastcall __TOnGetMonthInfoEvent(System::TObject* Sender, unsigned Month, unsigned &MonthBoldInfo);
	void __fastcall __TOnGetMonthBoldInfoEvent(System::TObject* Sender, unsigned Month, unsigned Year, unsigned &MonthBoldInfo);
	void __fastcall __TDTParseInputEvent(System::TObject* Sender, const System::UnicodeString UserString, System::TDateTime &DateAndTime, bool &AllowChange);
	void __fastcall __TPageScrollEvent(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y, Comctrls::TPageScrollerOrientation Orientation, int &Delta);
public:
	/* TatEventDispatcher.Create */ inline __fastcall virtual TatComCtrlsDispatcher(Classes::TCollection* ACollection) : Atscript::TatEventDispatcher(ACollection) { }
	/* TatEventDispatcher.Destroy */ inline __fastcall virtual ~TatComCtrlsDispatcher(void) { }
	
};


class DELPHICLASS TNodeCacheWrapper;
class PASCALIMPLEMENTATION TNodeCacheWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	Comctrls::TTreeNode* FCacheNode;
	int FCacheIndex;
	
public:
	__fastcall TNodeCacheWrapper(const Comctrls::TNodeCache &ARecord);
	Comctrls::TNodeCache __fastcall ObjToRec(void);
	
__published:
	__property Comctrls::TTreeNode* CacheNode = {read=FCacheNode, write=FCacheNode};
	__property int CacheIndex = {read=FCacheIndex, write=FCacheIndex, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TNodeCacheWrapper(void) { }
	
};


class DELPHICLASS TConversionFormatWrapper;
class PASCALIMPLEMENTATION TConversionFormatWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::UnicodeString FExtension;
	
public:
	__fastcall TConversionFormatWrapper(const Comctrls::TConversionFormat &ARecord);
	Comctrls::TConversionFormat __fastcall ObjToRec(void);
	
__published:
	__property System::UnicodeString Extension = {read=FExtension, write=FExtension};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TConversionFormatWrapper(void) { }
	
};


class DELPHICLASS TRichEditStreamInfoWrapper;
class PASCALIMPLEMENTATION TRichEditStreamInfoWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	Comctrls::TConversion* FConverter;
	Classes::TStream* FStream;
	bool FPlainText;
	Sysutils::TEncoding* FEncoding;
	
public:
	__fastcall TRichEditStreamInfoWrapper(const Comctrls::TRichEditStreamInfo &ARecord);
	Comctrls::TRichEditStreamInfo __fastcall ObjToRec(void);
	
__published:
	__property Comctrls::TConversion* Converter = {read=FConverter, write=FConverter};
	__property Classes::TStream* Stream = {read=FStream, write=FStream};
	__property bool PlainText = {read=FPlainText, write=FPlainText, nodefault};
	__property Sysutils::TEncoding* Encoding = {read=FEncoding, write=FEncoding};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TRichEditStreamInfoWrapper(void) { }
	
};


class DELPHICLASS TAnimateParamsWrapper;
class PASCALIMPLEMENTATION TAnimateParamsWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::UnicodeString FFileName;
	Comctrls::TCommonAVI FCommonAVI;
	unsigned FResHandle;
	System::UnicodeString FResName;
	int FResId;
	
public:
	__fastcall TAnimateParamsWrapper(const Comctrls::TAnimateParams &ARecord);
	Comctrls::TAnimateParams __fastcall ObjToRec(void);
	
__published:
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property Comctrls::TCommonAVI CommonAVI = {read=FCommonAVI, write=FCommonAVI, nodefault};
	__property unsigned ResHandle = {read=FResHandle, write=FResHandle, nodefault};
	__property System::UnicodeString ResName = {read=FResName, write=FResName};
	__property int ResId = {read=FResId, write=FResId, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TAnimateParamsWrapper(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_comctrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Ap_comctrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_comctrlsHPP
