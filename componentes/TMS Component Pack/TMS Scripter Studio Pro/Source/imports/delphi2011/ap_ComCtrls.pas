{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_ComCtrls;

interface

uses
  Messages,
  Windows,
  SysUtils,
  CommCtrl,
  Classes,
  Forms,
  Controls,
  Menus,
  Graphics,
  StdCtrls,
  RichEdit,
  ToolWin,
  ImgList,
  ExtCtrls,
  ListActns,
  ShlObj,
  GraphUtil,
  ComCtrls,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatComCtrlsLibrary = class(TatScripterLibrary)
    procedure __TCustomTabControlCreate(AMachine: TatVirtualMachine);
    procedure __TCustomTabControlDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomTabControlIndexOfTabAt(AMachine: TatVirtualMachine);
    procedure __TCustomTabControlGetHitTestInfoAt(AMachine: TatVirtualMachine);
    procedure __TCustomTabControlTabRect(AMachine: TatVirtualMachine);
    procedure __TCustomTabControlRowCount(AMachine: TatVirtualMachine);
    procedure __TCustomTabControlScrollTabs(AMachine: TatVirtualMachine);
    procedure __GetTCustomTabControlCanvas(AMachine: TatVirtualMachine);
    procedure __TTabSheetCreate(AMachine: TatVirtualMachine);
    procedure __TTabSheetDestroy(AMachine: TatVirtualMachine);
    procedure __GetTTabSheetPageControl(AMachine: TatVirtualMachine);
    procedure __SetTTabSheetPageControl(AMachine: TatVirtualMachine);
    procedure __GetTTabSheetTabIndex(AMachine: TatVirtualMachine);
    procedure __TPageControlCreate(AMachine: TatVirtualMachine);
    procedure __TPageControlDestroy(AMachine: TatVirtualMachine);
    procedure __TPageControlFindNextPage(AMachine: TatVirtualMachine);
    procedure __TPageControlSelectNextPage(AMachine: TatVirtualMachine);
    procedure __GetTPageControlActivePageIndex(AMachine: TatVirtualMachine);
    procedure __SetTPageControlActivePageIndex(AMachine: TatVirtualMachine);
    procedure __GetTPageControlPageCount(AMachine: TatVirtualMachine);
    procedure __GetTPageControlPages(AMachine: TatVirtualMachine);
    procedure __TStatusPanelCreate(AMachine: TatVirtualMachine);
    procedure __TStatusPanelAssign(AMachine: TatVirtualMachine);
    procedure __TStatusPanelParentBiDiModeChanged(AMachine: TatVirtualMachine);
    procedure __TStatusPanelUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __TStatusPanelUseRightToLeftReading(AMachine: TatVirtualMachine);
    procedure __TStatusPanelsCreate(AMachine: TatVirtualMachine);
    procedure __TStatusPanelsAdd(AMachine: TatVirtualMachine);
    procedure __TStatusPanelsAddItem(AMachine: TatVirtualMachine);
    procedure __TStatusPanelsInsert(AMachine: TatVirtualMachine);
    procedure __GetTStatusPanelsItems(AMachine: TatVirtualMachine);
    procedure __SetTStatusPanelsItems(AMachine: TatVirtualMachine);
    procedure __TCustomStatusBarCreate(AMachine: TatVirtualMachine);
    procedure __TCustomStatusBarDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomStatusBarExecuteAction(AMachine: TatVirtualMachine);
    procedure __TCustomStatusBarFlipChildren(AMachine: TatVirtualMachine);
    procedure __TCustomStatusBarSetBounds(AMachine: TatVirtualMachine);
    procedure __GetTCustomStatusBarCanvas(AMachine: TatVirtualMachine);
    procedure __GetTCustomStatusBarAutoHint(AMachine: TatVirtualMachine);
    procedure __SetTCustomStatusBarAutoHint(AMachine: TatVirtualMachine);
    procedure __GetTCustomStatusBarPanels(AMachine: TatVirtualMachine);
    procedure __SetTCustomStatusBarPanels(AMachine: TatVirtualMachine);
    procedure __GetTCustomStatusBarSimplePanel(AMachine: TatVirtualMachine);
    procedure __SetTCustomStatusBarSimplePanel(AMachine: TatVirtualMachine);
    procedure __GetTCustomStatusBarSimpleText(AMachine: TatVirtualMachine);
    procedure __SetTCustomStatusBarSimpleText(AMachine: TatVirtualMachine);
    procedure __GetTCustomStatusBarSizeGrip(AMachine: TatVirtualMachine);
    procedure __SetTCustomStatusBarSizeGrip(AMachine: TatVirtualMachine);
    procedure __GetTCustomStatusBarUseSystemFont(AMachine: TatVirtualMachine);
    procedure __SetTCustomStatusBarUseSystemFont(AMachine: TatVirtualMachine);
    procedure __THeaderSectionCreate(AMachine: TatVirtualMachine);
    procedure __THeaderSectionAssign(AMachine: TatVirtualMachine);
    procedure __THeaderSectionParentBiDiModeChanged(AMachine: TatVirtualMachine);
    procedure __THeaderSectionUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __THeaderSectionUseRightToLeftReading(AMachine: TatVirtualMachine);
    procedure __GetTHeaderSectionLeft(AMachine: TatVirtualMachine);
    procedure __GetTHeaderSectionRight(AMachine: TatVirtualMachine);
    procedure __THeaderSectionsCreate(AMachine: TatVirtualMachine);
    procedure __THeaderSectionsAdd(AMachine: TatVirtualMachine);
    procedure __THeaderSectionsAddItem(AMachine: TatVirtualMachine);
    procedure __THeaderSectionsInsert(AMachine: TatVirtualMachine);
    procedure __GetTHeaderSectionsItems(AMachine: TatVirtualMachine);
    procedure __SetTHeaderSectionsItems(AMachine: TatVirtualMachine);
    procedure __TCustomHeaderControlCreate(AMachine: TatVirtualMachine);
    procedure __TCustomHeaderControlDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomHeaderControlFlipChildren(AMachine: TatVirtualMachine);
    procedure __GetTCustomHeaderControlCanvas(AMachine: TatVirtualMachine);
    procedure __TTreeNodeCreate(AMachine: TatVirtualMachine);
    procedure __TTreeNodeDestroy(AMachine: TatVirtualMachine);
    procedure __TTreeNodeAlphaSort(AMachine: TatVirtualMachine);
    procedure __TTreeNodeAssign(AMachine: TatVirtualMachine);
    procedure __TTreeNodeCollapse(AMachine: TatVirtualMachine);
    procedure __TTreeNodeDelete(AMachine: TatVirtualMachine);
    procedure __TTreeNodeDeleteChildren(AMachine: TatVirtualMachine);
    procedure __TTreeNodeDisplayRect(AMachine: TatVirtualMachine);
    procedure __TTreeNodeEditText(AMachine: TatVirtualMachine);
    procedure __TTreeNodeEndEdit(AMachine: TatVirtualMachine);
    procedure __TTreeNodeExpand(AMachine: TatVirtualMachine);
    procedure __TTreeNodegetFirstChild(AMachine: TatVirtualMachine);
    procedure __TTreeNodeGetHandle(AMachine: TatVirtualMachine);
    procedure __TTreeNodeGetLastChild(AMachine: TatVirtualMachine);
    procedure __TTreeNodeGetNext(AMachine: TatVirtualMachine);
    procedure __TTreeNodeGetNextChild(AMachine: TatVirtualMachine);
    procedure __TTreeNodegetNextSibling(AMachine: TatVirtualMachine);
    procedure __TTreeNodeGetNextVisible(AMachine: TatVirtualMachine);
    procedure __TTreeNodeGetPrev(AMachine: TatVirtualMachine);
    procedure __TTreeNodeGetPrevChild(AMachine: TatVirtualMachine);
    procedure __TTreeNodegetPrevSibling(AMachine: TatVirtualMachine);
    procedure __TTreeNodeGetPrevVisible(AMachine: TatVirtualMachine);
    procedure __TTreeNodeHasAsParent(AMachine: TatVirtualMachine);
    procedure __TTreeNodeIndexOf(AMachine: TatVirtualMachine);
    procedure __TTreeNodeMakeVisible(AMachine: TatVirtualMachine);
    procedure __TTreeNodeMoveTo(AMachine: TatVirtualMachine);
    procedure __TTreeNodeIsFirstNode(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeAbsoluteIndex(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeCount(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeCut(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeCut(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeDeleting(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeFocused(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeFocused(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeDropTarget(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeDropTarget(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeSelected(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeSelected(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeExpanded(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeExpanded(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeExpandedImageIndex(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeExpandedImageIndex(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeHandle(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeHasChildren(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeHasChildren(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeImageIndex(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeImageIndex(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeIndex(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeIsVisible(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeItem(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeItem(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeLevel(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeOverlayIndex(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeOverlayIndex(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeOwner(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeParent(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeSelectedIndex(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeSelectedIndex(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeEnabled(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeEnabled(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeStateIndex(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeStateIndex(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeText(AMachine: TatVirtualMachine);
    procedure __SetTTreeNodeText(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodeTreeView(AMachine: TatVirtualMachine);
    procedure __TTreeNodesEnumeratorCreate(AMachine: TatVirtualMachine);
    procedure __TTreeNodesEnumeratorGetCurrent(AMachine: TatVirtualMachine);
    procedure __TTreeNodesEnumeratorMoveNext(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodesEnumeratorCurrent(AMachine: TatVirtualMachine);
    procedure __TTreeNodesCreate(AMachine: TatVirtualMachine);
    procedure __TTreeNodesDestroy(AMachine: TatVirtualMachine);
    procedure __TTreeNodesAddChildFirst(AMachine: TatVirtualMachine);
    procedure __TTreeNodesAddChild(AMachine: TatVirtualMachine);
    procedure __TTreeNodesAddFirst(AMachine: TatVirtualMachine);
    procedure __TTreeNodesAdd(AMachine: TatVirtualMachine);
    procedure __TTreeNodesAlphaSort(AMachine: TatVirtualMachine);
    procedure __TTreeNodesAssign(AMachine: TatVirtualMachine);
    procedure __TTreeNodesBeginUpdate(AMachine: TatVirtualMachine);
    procedure __TTreeNodesClear(AMachine: TatVirtualMachine);
    procedure __TTreeNodesDelete(AMachine: TatVirtualMachine);
    procedure __TTreeNodesEndUpdate(AMachine: TatVirtualMachine);
    procedure __TTreeNodesGetFirstNode(AMachine: TatVirtualMachine);
    procedure __TTreeNodesGetEnumerator(AMachine: TatVirtualMachine);
    procedure __TTreeNodesInsert(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodesCount(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodesHandle(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodesItem(AMachine: TatVirtualMachine);
    procedure __GetTTreeNodesOwner(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewCreate(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewAlphaSort(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewFullCollapse(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewFullExpand(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewGetHitTestInfoAt(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewGetNodeAt(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewGetDragImages(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewIsEditing(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewSaveToFile(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewSaveToStream(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewSelect(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewDeselect(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewSubselect(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewClearSelection(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewGetSelections(AMachine: TatVirtualMachine);
    procedure __TCustomTreeViewFindNextToSelect(AMachine: TatVirtualMachine);
    procedure __GetTCustomTreeViewCanvas(AMachine: TatVirtualMachine);
    procedure __GetTCustomTreeViewDropTarget(AMachine: TatVirtualMachine);
    procedure __SetTCustomTreeViewDropTarget(AMachine: TatVirtualMachine);
    procedure __GetTCustomTreeViewSelected(AMachine: TatVirtualMachine);
    procedure __SetTCustomTreeViewSelected(AMachine: TatVirtualMachine);
    procedure __GetTCustomTreeViewTopItem(AMachine: TatVirtualMachine);
    procedure __SetTCustomTreeViewTopItem(AMachine: TatVirtualMachine);
    procedure __GetTCustomTreeViewSelectionCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomTreeViewSelections(AMachine: TatVirtualMachine);
    procedure __TTrackBarCreate(AMachine: TatVirtualMachine);
    procedure __TTrackBarSetTick(AMachine: TatVirtualMachine);
    procedure __TProgressBarCreate(AMachine: TatVirtualMachine);
    procedure __TProgressBarStepIt(AMachine: TatVirtualMachine);
    procedure __TProgressBarStepBy(AMachine: TatVirtualMachine);
    procedure __TTextAttributesCreate(AMachine: TatVirtualMachine);
    procedure __TTextAttributesAssign(AMachine: TatVirtualMachine);
    procedure __GetTTextAttributesCharset(AMachine: TatVirtualMachine);
    procedure __SetTTextAttributesCharset(AMachine: TatVirtualMachine);
    procedure __GetTTextAttributesColor(AMachine: TatVirtualMachine);
    procedure __SetTTextAttributesColor(AMachine: TatVirtualMachine);
    procedure __GetTTextAttributesConsistentAttributes(AMachine: TatVirtualMachine);
    procedure __GetTTextAttributesName(AMachine: TatVirtualMachine);
    procedure __SetTTextAttributesName(AMachine: TatVirtualMachine);
    procedure __GetTTextAttributesPitch(AMachine: TatVirtualMachine);
    procedure __SetTTextAttributesPitch(AMachine: TatVirtualMachine);
    procedure __GetTTextAttributesProtected(AMachine: TatVirtualMachine);
    procedure __SetTTextAttributesProtected(AMachine: TatVirtualMachine);
    procedure __GetTTextAttributesSize(AMachine: TatVirtualMachine);
    procedure __SetTTextAttributesSize(AMachine: TatVirtualMachine);
    procedure __GetTTextAttributesStyle(AMachine: TatVirtualMachine);
    procedure __SetTTextAttributesStyle(AMachine: TatVirtualMachine);
    procedure __GetTTextAttributesHeight(AMachine: TatVirtualMachine);
    procedure __SetTTextAttributesHeight(AMachine: TatVirtualMachine);
    procedure __TParaAttributesCreate(AMachine: TatVirtualMachine);
    procedure __TParaAttributesAssign(AMachine: TatVirtualMachine);
    procedure __GetTParaAttributesAlignment(AMachine: TatVirtualMachine);
    procedure __SetTParaAttributesAlignment(AMachine: TatVirtualMachine);
    procedure __GetTParaAttributesFirstIndent(AMachine: TatVirtualMachine);
    procedure __SetTParaAttributesFirstIndent(AMachine: TatVirtualMachine);
    procedure __GetTParaAttributesLeftIndent(AMachine: TatVirtualMachine);
    procedure __SetTParaAttributesLeftIndent(AMachine: TatVirtualMachine);
    procedure __GetTParaAttributesNumbering(AMachine: TatVirtualMachine);
    procedure __SetTParaAttributesNumbering(AMachine: TatVirtualMachine);
    procedure __GetTParaAttributesRightIndent(AMachine: TatVirtualMachine);
    procedure __SetTParaAttributesRightIndent(AMachine: TatVirtualMachine);
    procedure __GetTParaAttributesTab(AMachine: TatVirtualMachine);
    procedure __SetTParaAttributesTab(AMachine: TatVirtualMachine);
    procedure __GetTParaAttributesTabCount(AMachine: TatVirtualMachine);
    procedure __SetTParaAttributesTabCount(AMachine: TatVirtualMachine);
    procedure __TConversionCreate(AMachine: TatVirtualMachine);
    procedure __TConversionConvertReadStream(AMachine: TatVirtualMachine);
    procedure __TConversionConvertWriteStream(AMachine: TatVirtualMachine);
    procedure __TCustomRichEditCreate(AMachine: TatVirtualMachine);
    procedure __TCustomRichEditDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomRichEditClear(AMachine: TatVirtualMachine);
    procedure __TCustomRichEditFindText(AMachine: TatVirtualMachine);
    procedure __TCustomRichEditPrint(AMachine: TatVirtualMachine);
    procedure __TCustomRichEditGetSelTextBuf(AMachine: TatVirtualMachine);
    procedure __GetTCustomRichEditActiveLineNo(AMachine: TatVirtualMachine);
    procedure __GetTCustomRichEditDefAttributes(AMachine: TatVirtualMachine);
    procedure __SetTCustomRichEditDefAttributes(AMachine: TatVirtualMachine);
    procedure __GetTCustomRichEditSelAttributes(AMachine: TatVirtualMachine);
    procedure __SetTCustomRichEditSelAttributes(AMachine: TatVirtualMachine);
    procedure __GetTCustomRichEditPageRect(AMachine: TatVirtualMachine);
    procedure __SetTCustomRichEditPageRect(AMachine: TatVirtualMachine);
    procedure __GetTCustomRichEditParagraph(AMachine: TatVirtualMachine);
    procedure __TCustomUpDownCreate(AMachine: TatVirtualMachine);
    procedure __TCustomHotKeyCreate(AMachine: TatVirtualMachine);
    procedure __TListGroupCreate(AMachine: TatVirtualMachine);
    procedure __TListGroupDestroy(AMachine: TatVirtualMachine);
    procedure __TListGroupAssign(AMachine: TatVirtualMachine);
    procedure __TListGroupsCreate(AMachine: TatVirtualMachine);
    procedure __TListGroupsAdd(AMachine: TatVirtualMachine);
    procedure __TListGroupsOwner(AMachine: TatVirtualMachine);
    procedure __GetTListGroupsItems(AMachine: TatVirtualMachine);
    procedure __SetTListGroupsItems(AMachine: TatVirtualMachine);
    procedure __GetTListGroupsNextGroupID(AMachine: TatVirtualMachine);
    procedure __TListColumnCreate(AMachine: TatVirtualMachine);
    procedure __TListColumnDestroy(AMachine: TatVirtualMachine);
    procedure __TListColumnAssign(AMachine: TatVirtualMachine);
    procedure __GetTListColumnWidthType(AMachine: TatVirtualMachine);
    procedure __TListColumnsCreate(AMachine: TatVirtualMachine);
    procedure __TListColumnsAdd(AMachine: TatVirtualMachine);
    procedure __TListColumnsOwner(AMachine: TatVirtualMachine);
    procedure __GetTListColumnsItems(AMachine: TatVirtualMachine);
    procedure __SetTListColumnsItems(AMachine: TatVirtualMachine);
    procedure __TListItemCreate(AMachine: TatVirtualMachine);
    procedure __TListItemDestroy(AMachine: TatVirtualMachine);
    procedure __TListItemAssign(AMachine: TatVirtualMachine);
    procedure __TListItemCancelEdit(AMachine: TatVirtualMachine);
    procedure __TListItemDelete(AMachine: TatVirtualMachine);
    procedure __TListItemDisplayRect(AMachine: TatVirtualMachine);
    procedure __TListItemEditCaption(AMachine: TatVirtualMachine);
    procedure __TListItemGetPosition(AMachine: TatVirtualMachine);
    procedure __TListItemMakeVisible(AMachine: TatVirtualMachine);
    procedure __TListItemUpdate(AMachine: TatVirtualMachine);
    procedure __TListItemSetPosition(AMachine: TatVirtualMachine);
    procedure __TListItemWorkArea(AMachine: TatVirtualMachine);
    procedure __GetTListItemCaption(AMachine: TatVirtualMachine);
    procedure __SetTListItemCaption(AMachine: TatVirtualMachine);
    procedure __GetTListItemChecked(AMachine: TatVirtualMachine);
    procedure __SetTListItemChecked(AMachine: TatVirtualMachine);
    procedure __GetTListItemCut(AMachine: TatVirtualMachine);
    procedure __SetTListItemCut(AMachine: TatVirtualMachine);
    procedure __GetTListItemDeleting(AMachine: TatVirtualMachine);
    procedure __GetTListItemDropTarget(AMachine: TatVirtualMachine);
    procedure __SetTListItemDropTarget(AMachine: TatVirtualMachine);
    procedure __GetTListItemFocused(AMachine: TatVirtualMachine);
    procedure __SetTListItemFocused(AMachine: TatVirtualMachine);
    procedure __GetTListItemGroupID(AMachine: TatVirtualMachine);
    procedure __SetTListItemGroupID(AMachine: TatVirtualMachine);
    procedure __GetTListItemHandle(AMachine: TatVirtualMachine);
    procedure __GetTListItemImageIndex(AMachine: TatVirtualMachine);
    procedure __SetTListItemImageIndex(AMachine: TatVirtualMachine);
    procedure __GetTListItemIndent(AMachine: TatVirtualMachine);
    procedure __SetTListItemIndent(AMachine: TatVirtualMachine);
    procedure __GetTListItemIndex(AMachine: TatVirtualMachine);
    procedure __GetTListItemLeft(AMachine: TatVirtualMachine);
    procedure __SetTListItemLeft(AMachine: TatVirtualMachine);
    procedure __GetTListItemListView(AMachine: TatVirtualMachine);
    procedure __GetTListItemOwner(AMachine: TatVirtualMachine);
    procedure __GetTListItemOverlayIndex(AMachine: TatVirtualMachine);
    procedure __SetTListItemOverlayIndex(AMachine: TatVirtualMachine);
    procedure __GetTListItemPosition(AMachine: TatVirtualMachine);
    procedure __SetTListItemPosition(AMachine: TatVirtualMachine);
    procedure __GetTListItemSelected(AMachine: TatVirtualMachine);
    procedure __SetTListItemSelected(AMachine: TatVirtualMachine);
    procedure __GetTListItemStateIndex(AMachine: TatVirtualMachine);
    procedure __SetTListItemStateIndex(AMachine: TatVirtualMachine);
    procedure __GetTListItemSubItems(AMachine: TatVirtualMachine);
    procedure __SetTListItemSubItems(AMachine: TatVirtualMachine);
    procedure __GetTListItemSubItemImages(AMachine: TatVirtualMachine);
    procedure __SetTListItemSubItemImages(AMachine: TatVirtualMachine);
    procedure __GetTListItemTop(AMachine: TatVirtualMachine);
    procedure __SetTListItemTop(AMachine: TatVirtualMachine);
    procedure __TListItemsEnumeratorCreate(AMachine: TatVirtualMachine);
    procedure __TListItemsEnumeratorGetCurrent(AMachine: TatVirtualMachine);
    procedure __TListItemsEnumeratorMoveNext(AMachine: TatVirtualMachine);
    procedure __GetTListItemsEnumeratorCurrent(AMachine: TatVirtualMachine);
    procedure __TListItemsCreate(AMachine: TatVirtualMachine);
    procedure __TListItemsDestroy(AMachine: TatVirtualMachine);
    procedure __TListItemsAdd(AMachine: TatVirtualMachine);
    procedure __TListItemsAddItem(AMachine: TatVirtualMachine);
    procedure __TListItemsAssign(AMachine: TatVirtualMachine);
    procedure __TListItemsBeginUpdate(AMachine: TatVirtualMachine);
    procedure __TListItemsClear(AMachine: TatVirtualMachine);
    procedure __TListItemsDelete(AMachine: TatVirtualMachine);
    procedure __TListItemsEndUpdate(AMachine: TatVirtualMachine);
    procedure __TListItemsGetEnumerator(AMachine: TatVirtualMachine);
    procedure __TListItemsIndexOf(AMachine: TatVirtualMachine);
    procedure __TListItemsInsert(AMachine: TatVirtualMachine);
    procedure __GetTListItemsCount(AMachine: TatVirtualMachine);
    procedure __SetTListItemsCount(AMachine: TatVirtualMachine);
    procedure __GetTListItemsHandle(AMachine: TatVirtualMachine);
    procedure __GetTListItemsItem(AMachine: TatVirtualMachine);
    procedure __SetTListItemsItem(AMachine: TatVirtualMachine);
    procedure __GetTListItemsOwner(AMachine: TatVirtualMachine);
    procedure __TWorkAreaCreate(AMachine: TatVirtualMachine);
    procedure __TWorkAreaSetDisplayName(AMachine: TatVirtualMachine);
    procedure __TWorkAreaGetDisplayName(AMachine: TatVirtualMachine);
    procedure __GetTWorkAreaRect(AMachine: TatVirtualMachine);
    procedure __SetTWorkAreaRect(AMachine: TatVirtualMachine);
    procedure __GetTWorkAreaColor(AMachine: TatVirtualMachine);
    procedure __SetTWorkAreaColor(AMachine: TatVirtualMachine);
    procedure __TWorkAreasAdd(AMachine: TatVirtualMachine);
    procedure __TWorkAreasDelete(AMachine: TatVirtualMachine);
    procedure __TWorkAreasInsert(AMachine: TatVirtualMachine);
    procedure __GetTWorkAreasItems(AMachine: TatVirtualMachine);
    procedure __SetTWorkAreasItems(AMachine: TatVirtualMachine);
    procedure __TIconOptionsCreate(AMachine: TatVirtualMachine);
    procedure __TCustomListViewCreate(AMachine: TatVirtualMachine);
    procedure __TCustomListViewDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomListViewAddItem(AMachine: TatVirtualMachine);
    procedure __TCustomListViewAlphaSort(AMachine: TatVirtualMachine);
    procedure __TCustomListViewArrange(AMachine: TatVirtualMachine);
    procedure __TCustomListViewClear(AMachine: TatVirtualMachine);
    procedure __TCustomListViewClearSelection(AMachine: TatVirtualMachine);
    procedure __TCustomListViewCopySelection(AMachine: TatVirtualMachine);
    procedure __TCustomListViewDeleteSelected(AMachine: TatVirtualMachine);
    procedure __TCustomListViewFindCaption(AMachine: TatVirtualMachine);
    procedure __TCustomListViewGetCount(AMachine: TatVirtualMachine);
    procedure __TCustomListViewGetHitTestInfoAt(AMachine: TatVirtualMachine);
    procedure __TCustomListViewGetItemAt(AMachine: TatVirtualMachine);
    procedure __TCustomListViewGetNearestItem(AMachine: TatVirtualMachine);
    procedure __TCustomListViewGetNextItem(AMachine: TatVirtualMachine);
    procedure __TCustomListViewGetSearchString(AMachine: TatVirtualMachine);
    procedure __TCustomListViewIsEditing(AMachine: TatVirtualMachine);
    procedure __TCustomListViewSelectAll(AMachine: TatVirtualMachine);
    procedure __TCustomListViewScroll(AMachine: TatVirtualMachine);
    procedure __TCustomListViewGetDragImages(AMachine: TatVirtualMachine);
    procedure __TCustomListViewStringWidth(AMachine: TatVirtualMachine);
    procedure __TCustomListViewUpdateItems(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewCanvas(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewCheckboxes(AMachine: TatVirtualMachine);
    procedure __SetTCustomListViewCheckboxes(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewColumn(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewDropTarget(AMachine: TatVirtualMachine);
    procedure __SetTCustomListViewDropTarget(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewFlatScrollBars(AMachine: TatVirtualMachine);
    procedure __SetTCustomListViewFlatScrollBars(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewFullDrag(AMachine: TatVirtualMachine);
    procedure __SetTCustomListViewFullDrag(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewGridLines(AMachine: TatVirtualMachine);
    procedure __SetTCustomListViewGridLines(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewHotTrack(AMachine: TatVirtualMachine);
    procedure __SetTCustomListViewHotTrack(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewHotTrackStyles(AMachine: TatVirtualMachine);
    procedure __SetTCustomListViewHotTrackStyles(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewItemFocused(AMachine: TatVirtualMachine);
    procedure __SetTCustomListViewItemFocused(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewItems(AMachine: TatVirtualMachine);
    procedure __SetTCustomListViewItems(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewRowSelect(AMachine: TatVirtualMachine);
    procedure __SetTCustomListViewRowSelect(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewSelCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewSelected(AMachine: TatVirtualMachine);
    procedure __SetTCustomListViewSelected(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewTopItem(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewViewOrigin(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewVisibleRowCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewBoundingRect(AMachine: TatVirtualMachine);
    procedure __GetTCustomListViewWorkAreas(AMachine: TatVirtualMachine);
    procedure __TAnimateCreate(AMachine: TatVirtualMachine);
    procedure __TAnimatePlay(AMachine: TatVirtualMachine);
    procedure __TAnimateReset(AMachine: TatVirtualMachine);
    procedure __TAnimateSeek(AMachine: TatVirtualMachine);
    procedure __TAnimateStop(AMachine: TatVirtualMachine);
    procedure __GetTAnimateFrameCount(AMachine: TatVirtualMachine);
    procedure __GetTAnimateFrameHeight(AMachine: TatVirtualMachine);
    procedure __GetTAnimateFrameWidth(AMachine: TatVirtualMachine);
    procedure __GetTAnimateOpen(AMachine: TatVirtualMachine);
    procedure __SetTAnimateOpen(AMachine: TatVirtualMachine);
    procedure __GetTAnimateResHandle(AMachine: TatVirtualMachine);
    procedure __SetTAnimateResHandle(AMachine: TatVirtualMachine);
    procedure __GetTAnimateResId(AMachine: TatVirtualMachine);
    procedure __SetTAnimateResId(AMachine: TatVirtualMachine);
    procedure __GetTAnimateResName(AMachine: TatVirtualMachine);
    procedure __SetTAnimateResName(AMachine: TatVirtualMachine);
    procedure __TToolButtonCreate(AMachine: TatVirtualMachine);
    procedure __TToolButtonCheckMenuDropdown(AMachine: TatVirtualMachine);
    procedure __TToolButtonClick(AMachine: TatVirtualMachine);
    procedure __TToolButtonSetBounds(AMachine: TatVirtualMachine);
    procedure __GetTToolButtonIndex(AMachine: TatVirtualMachine);
    procedure __TToolBarEnumeratorCreate(AMachine: TatVirtualMachine);
    procedure __TToolBarEnumeratorGetCurrent(AMachine: TatVirtualMachine);
    procedure __TToolBarEnumeratorMoveNext(AMachine: TatVirtualMachine);
    procedure __GetTToolBarEnumeratorCurrent(AMachine: TatVirtualMachine);
    procedure __TToolBarCreate(AMachine: TatVirtualMachine);
    procedure __TToolBarDestroy(AMachine: TatVirtualMachine);
    procedure __TToolBarFlipChildren(AMachine: TatVirtualMachine);
    procedure __TToolBarGetEnumerator(AMachine: TatVirtualMachine);
    procedure __TToolBarTrackMenu(AMachine: TatVirtualMachine);
    procedure __GetTToolBarButtonCount(AMachine: TatVirtualMachine);
    procedure __GetTToolBarButtons(AMachine: TatVirtualMachine);
    procedure __GetTToolBarCanvas(AMachine: TatVirtualMachine);
    procedure __GetTToolBarCustomizeKeyName(AMachine: TatVirtualMachine);
    procedure __SetTToolBarCustomizeKeyName(AMachine: TatVirtualMachine);
    procedure __GetTToolBarCustomizeValueName(AMachine: TatVirtualMachine);
    procedure __SetTToolBarCustomizeValueName(AMachine: TatVirtualMachine);
    procedure __GetTToolBarRowCount(AMachine: TatVirtualMachine);
    procedure __TCoolBandCreate(AMachine: TatVirtualMachine);
    procedure __TCoolBandDestroy(AMachine: TatVirtualMachine);
    procedure __TCoolBandAssign(AMachine: TatVirtualMachine);
    procedure __GetTCoolBandHeight(AMachine: TatVirtualMachine);
    procedure __TCoolBandsCreate(AMachine: TatVirtualMachine);
    procedure __TCoolBandsDestroy(AMachine: TatVirtualMachine);
    procedure __TCoolBandsAdd(AMachine: TatVirtualMachine);
    procedure __TCoolBandsFindBand(AMachine: TatVirtualMachine);
    procedure __GetTCoolBandsCoolBar(AMachine: TatVirtualMachine);
    procedure __GetTCoolBandsItems(AMachine: TatVirtualMachine);
    procedure __SetTCoolBandsItems(AMachine: TatVirtualMachine);
    procedure __TCoolBarCreate(AMachine: TatVirtualMachine);
    procedure __TCoolBarDestroy(AMachine: TatVirtualMachine);
    procedure __TCoolBarFlipChildren(AMachine: TatVirtualMachine);
    procedure __TMonthCalColorsCreate(AMachine: TatVirtualMachine);
    procedure __TMonthCalColorsAssign(AMachine: TatVirtualMachine);
    procedure __TCommonCalendarCreate(AMachine: TatVirtualMachine);
    procedure __TCommonCalendarDestroy(AMachine: TatVirtualMachine);
    procedure __TMonthCalendarCreate(AMachine: TatVirtualMachine);
    procedure __TDateTimePickerCreate(AMachine: TatVirtualMachine);
    procedure __GetTDateTimePickerDroppedDown(AMachine: TatVirtualMachine);
    procedure __TPageScrollerCreate(AMachine: TatVirtualMachine);
    procedure __TPageScrollerGetButtonState(AMachine: TatVirtualMachine);
    procedure __TComboExItemAssign(AMachine: TatVirtualMachine);
    procedure __TComboExItemsAdd(AMachine: TatVirtualMachine);
    procedure __TComboExItemsInsert(AMachine: TatVirtualMachine);
    procedure __GetTComboExItemsComboItems(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsCreate(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsDestroy(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsAdd(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsAddObject(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsClear(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsDelete(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsExchange(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsGet(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsGetCapacity(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsGetCount(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsGetObject(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsIndexOf(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsIndexOfName(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsInsert(AMachine: TatVirtualMachine);
    procedure __TComboBoxExStringsMove(AMachine: TatVirtualMachine);
    procedure __GetTComboBoxExStringsSortType(AMachine: TatVirtualMachine);
    procedure __SetTComboBoxExStringsSortType(AMachine: TatVirtualMachine);
    procedure __GetTComboBoxExStringsItemsEx(AMachine: TatVirtualMachine);
    procedure __SetTComboBoxExStringsItemsEx(AMachine: TatVirtualMachine);
    procedure __TCustomComboBoxExCreate(AMachine: TatVirtualMachine);
    procedure __TCustomComboBoxExDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomComboBoxExFocused(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboBoxExAutoCompleteOptions(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboBoxExAutoCompleteOptions(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboBoxExDropDownCount(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboBoxExDropDownCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboBoxExImages(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboBoxExImages(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboBoxExItemsEx(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboBoxExItemsEx(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboBoxExSelText(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboBoxExSelText(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboBoxExStyle(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboBoxExStyle(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboBoxExStyleEx(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboBoxExStyleEx(AMachine: TatVirtualMachine);
    procedure __InitCommonControl(AMachine: TatVirtualMachine);
    procedure __CheckCommonControl(AMachine: TatVirtualMachine);
    procedure __GetComCtlVersion(AMachine: TatVirtualMachine);
    procedure __CheckToolMenuDropdown(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCustomTabControlClass = class of TCustomTabControl;
  TTabControlClass = class of TTabControl;
  TTabSheetClass = class of TTabSheet;
  TPageControlClass = class of TPageControl;
  TStatusPanelClass = class of TStatusPanel;
  TStatusPanelsClass = class of TStatusPanels;
  TCustomStatusBarClass = class of TCustomStatusBar;
  TStatusBarClass = class of TStatusBar;
  THeaderSectionClass = class of THeaderSection;
  THeaderSectionsClass = class of THeaderSections;
  TCustomHeaderControlClass = class of TCustomHeaderControl;
  THeaderControlClass = class of THeaderControl;
  TTreeNodeClass = class of TTreeNode;
  TTreeNodesEnumeratorClass = class of TTreeNodesEnumerator;
  TTreeNodesClass = class of TTreeNodes;
  ETreeViewErrorClass = class of ETreeViewError;
  TCustomTreeViewClass = class of TCustomTreeView;
  TTreeViewClass = class of TTreeView;
  TTrackBarClass = class of TTrackBar;
  TProgressBarClass = class of TProgressBar;
  TTextAttributesClass = class of TTextAttributes;
  TParaAttributesClass = class of TParaAttributes;
  TConversionClass = class of TConversion;
  TCustomRichEditClass = class of TCustomRichEdit;
  TRichEditClass = class of TRichEdit;
  TCustomUpDownClass = class of TCustomUpDown;
  TUpDownClass = class of TUpDown;
  TCustomHotKeyClass = class of TCustomHotKey;
  THotKeyClass = class of THotKey;
  TListGroupClass = class of TListGroup;
  TListGroupsClass = class of TListGroups;
  TListColumnClass = class of TListColumn;
  TListColumnsClass = class of TListColumns;
  TListItemClass = class of TListItem;
  TListItemsEnumeratorClass = class of TListItemsEnumerator;
  TListItemsClass = class of TListItems;
  TWorkAreaClass = class of TWorkArea;
  TWorkAreasClass = class of TWorkAreas;
  TIconOptionsClass = class of TIconOptions;
  TCustomListViewClass = class of TCustomListView;
  TListViewClass = class of TListView;
  TListViewActionLinkClass = class of TListViewActionLink;
  TAnimateClass = class of TAnimate;
  TToolButtonActionLinkClass = class of TToolButtonActionLink;
  TToolButtonClass = class of TToolButton;
  TToolBarEnumeratorClass = class of TToolBarEnumerator;
  TToolBarClass = class of TToolBar;
  TToolBarDockObjectClass = class of TToolBarDockObject;
  TCoolBandClass = class of TCoolBand;
  TCoolBandsClass = class of TCoolBands;
  TCoolBarClass = class of TCoolBar;
  ECommonCalendarErrorClass = class of ECommonCalendarError;
  TMonthCalColorsClass = class of TMonthCalColors;
  TCommonCalendarClass = class of TCommonCalendar;
  EMonthCalErrorClass = class of EMonthCalError;
  TMonthCalendarClass = class of TMonthCalendar;
  EDateTimeErrorClass = class of EDateTimeError;
  TDateTimeColorsClass = class of TDateTimeColors;
  TDateTimePickerClass = class of TDateTimePicker;
  TPageScrollerClass = class of TPageScroller;
  TComboExItemClass = class of TComboExItem;
  TComboExItemsClass = class of TComboExItems;
  TComboBoxExStringsClass = class of TComboBoxExStrings;
  TCustomComboBoxExClass = class of TCustomComboBoxEx;
  TComboBoxExClass = class of TComboBoxEx;
  TComboBoxExActionLinkClass = class of TComboBoxExActionLink;

  TatComCtrlsDispatcher = class(TatEventDispatcher)
  private
    procedure __TTabChangingEvent( Sender: TObject; var AllowChange: Boolean);
    procedure __TTabGetImageEvent( Sender: TObject;  TabIndex: Integer; var ImageIndex: Integer);
    procedure __TCustomSectionNotifyEvent( HeaderControl: TCustomHeaderControl;  Section: THeaderSection);
    procedure __TCustomSectionTrackEvent( HeaderControl: TCustomHeaderControl;  Section: THeaderSection;  Width: Integer;  State: TSectionTrackState);
    procedure __TSectionDragEvent( Sender: TObject;  FromSection: THeaderSection;  ToSection: THeaderSection; var AllowDrag: Boolean);
    procedure __TSectionNotifyEvent( HeaderControl: THeaderControl;  Section: THeaderSection);
    procedure __TSectionTrackEvent( HeaderControl: THeaderControl;  Section: THeaderSection;  Width: Integer;  State: TSectionTrackState);
    procedure __TTVChangingEvent( Sender: TObject;  Node: TTreeNode; var AllowChange: Boolean);
    procedure __TTVChangedEvent( Sender: TObject;  Node: TTreeNode);
    procedure __TTVEditingEvent( Sender: TObject;  Node: TTreeNode; var AllowEdit: Boolean);
    procedure __TTVEditedEvent( Sender: TObject;  Node: TTreeNode; var S: string);
    procedure __TTVExpandingEvent( Sender: TObject;  Node: TTreeNode; var AllowExpansion: Boolean);
    procedure __TTVCollapsingEvent( Sender: TObject;  Node: TTreeNode; var AllowCollapse: Boolean);
    procedure __TTVExpandedEvent( Sender: TObject;  Node: TTreeNode);
    procedure __TTVCompareEvent( Sender: TObject;  Node1: TTreeNode;  Node2: TTreeNode;  Data: Integer; var Compare: Integer);
    procedure __TTVHintEvent( Sender: TObject; const Node: TTreeNode; var Hint: String);
    procedure __TTVCustomDrawItemEvent( Sender: TCustomTreeView;  Node: TTreeNode;  State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure __TTVAdvancedCustomDrawItemEvent( Sender: TCustomTreeView;  Node: TTreeNode;  State: TCustomDrawState;  Stage: TCustomDrawStage; var PaintImages: Boolean; var DefaultDraw: Boolean);
    procedure __TRichEditProtectChange( Sender: TObject;  StartPos: Integer;  EndPos: Integer; var AllowChange: Boolean);
    procedure __TRichEditSaveClipboard( Sender: TObject;  NumObjects: Integer;  NumChars: Integer; var SaveClipboard: Boolean);
    procedure __TUDClickEvent( Sender: TObject;  Button: TUDBtnType);
    procedure __TUDChangingEvent( Sender: TObject; var AllowChange: Boolean);
    procedure __TUDChangingEventEx( Sender: TObject; var AllowChange: Boolean;  NewValue: SmallInt;  Direction: TUpDownDirection);
    procedure __TLVDeletedEvent( Sender: TObject;  Item: TListItem);
    procedure __TLVEditingEvent( Sender: TObject;  Item: TListItem; var AllowEdit: Boolean);
    procedure __TLVEditedEvent( Sender: TObject;  Item: TListItem; var S: string);
    procedure __TLVChangeEvent( Sender: TObject;  Item: TListItem;  Change: TItemChange);
    procedure __TLVChangingEvent( Sender: TObject;  Item: TListItem;  Change: TItemChange; var AllowChange: Boolean);
    procedure __TLVColumnClickEvent( Sender: TObject;  Column: TListColumn);
    procedure __TLVCompareEvent( Sender: TObject;  Item1: TListItem;  Item2: TListItem;  Data: Integer; var Compare: Integer);
    procedure __TLVDrawItemEvent(Sender: TCustomListView; Item: TListItem; Rect: TRect; State: TOwnerDrawState);
    procedure __TLVNotifyEvent( Sender: TObject;  Item: TListItem);
    procedure __TLVSelectItemEvent( Sender: TObject;  Item: TListItem;  Selected: Boolean);
    procedure __TLVCheckedItemEvent( Sender: TObject;  Item: TListItem);
    procedure __TLVCustomDrawItemEvent( Sender: TCustomListView;  Item: TListItem;  State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure __TLVCustomDrawSubItemEvent( Sender: TCustomListView;  Item: TListItem;  SubItem: Integer;  State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure __TLVAdvancedCustomDrawItemEvent( Sender: TCustomListView;  Item: TListItem;  State: TCustomDrawState;  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure __TLVAdvancedCustomDrawSubItemEvent( Sender: TCustomListView;  Item: TListItem;  SubItem: Integer;  State: TCustomDrawState;  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure __TLVOwnerDataEvent( Sender: TObject;  Item: TListItem);
    procedure __TLVOwnerDataHintEvent( Sender: TObject;  StartIndex: Integer;  EndIndex: Integer);
    procedure __TLVOwnerDataStateChangeEvent( Sender: TObject;  StartIndex: Integer;  EndIndex: Integer;  OldState: TItemStates;  NewState: TItemStates);
    procedure __TLVSubItemImageEvent( Sender: TObject;  Item: TListItem;  SubItem: Integer; var ImageIndex: Integer);
    procedure __TLVInfoTipEvent( Sender: TObject;  Item: TListItem; var InfoTip: string);
    procedure __TTBCustomDrawBtnEvent( Sender: TToolBar;  Button: TToolButton;  State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure __TTBAdvancedCustomDrawBtnEvent( Sender: TToolBar;  Button: TToolButton;  State: TCustomDrawState;  Stage: TCustomDrawStage; var Flags: TTBCustomDrawFlags; var DefaultDraw: Boolean);
    procedure __TTBCustomizeQueryEvent( Sender: TToolbar;  Index: Integer; var Allow: Boolean);
    procedure __TTBNewButtonEvent( Sender: TToolbar;  Index: Integer; var Button: TToolButton);
    procedure __TTBButtonEvent( Sender: TToolbar;  Button: TToolButton);
    procedure __TOnGetMonthInfoEvent( Sender: TObject;  Month: LongWord; var MonthBoldInfo: LongWord);
    procedure __TOnGetMonthBoldInfoEvent( Sender: TObject;  Month: LongWord;  Year: LongWord; var MonthBoldInfo: LongWord);
    procedure __TDTParseInputEvent( Sender: TObject; const UserString: string; var DateAndTime: TDateTime; var AllowChange: Boolean);
    procedure __TPageScrollEvent( Sender: TObject;  Shift: TShiftState;  X: Integer;  Y: Integer;  Orientation: TPageScrollerOrientation; var Delta: Integer);
  end;

  TNodeCacheWrapper = class(TatRecordWrapper)
  private
    FCacheNode: TTreeNode;
    FCacheIndex: Integer;
  public
    constructor Create(ARecord: TNodeCache);
    function ObjToRec: TNodeCache;
  published
    property CacheNode: TTreeNode read FCacheNode write FCacheNode;
    property CacheIndex: Integer read FCacheIndex write FCacheIndex;
  end;
  
  TConversionFormatWrapper = class(TatRecordWrapper)
  private
    FExtension: string;
  public
    constructor Create(ARecord: TConversionFormat);
    function ObjToRec: TConversionFormat;
  published
    property Extension: string read FExtension write FExtension;
  end;
  
  TRichEditStreamInfoWrapper = class(TatRecordWrapper)
  private
    FConverter: TConversion;
    FStream: TStream;
    FPlainText: Boolean;
    FEncoding: TEncoding;
  public
    constructor Create(ARecord: TRichEditStreamInfo);
    function ObjToRec: TRichEditStreamInfo;
  published
    property Converter: TConversion read FConverter write FConverter;
    property Stream: TStream read FStream write FStream;
    property PlainText: Boolean read FPlainText write FPlainText;
    property Encoding: TEncoding read FEncoding write FEncoding;
  end;
  
  TAnimateParamsWrapper = class(TatRecordWrapper)
  private
    FFileName: string;
    FCommonAVI: TCommonAVI;
    FResHandle: THandle;
    FResName: string;
    FResId: Integer;
  public
    constructor Create(ARecord: TAnimateParams);
    function ObjToRec: TAnimateParams;
  published
    property FileName: string read FFileName write FFileName;
    property CommonAVI: TCommonAVI read FCommonAVI write FCommonAVI;
    property ResHandle: THandle read FResHandle write FResHandle;
    property ResName: string read FResName write FResName;
    property ResId: Integer read FResId write FResId;
  end;
  

implementation

constructor TNodeCacheWrapper.Create(ARecord: TNodeCache);
begin
  inherited Create;
  FCacheNode := ARecord.CacheNode;
  FCacheIndex := ARecord.CacheIndex;
end;

function TNodeCacheWrapper.ObjToRec: TNodeCache;
begin
  result.CacheNode := FCacheNode;
  result.CacheIndex := FCacheIndex;
end;

constructor TConversionFormatWrapper.Create(ARecord: TConversionFormat);
begin
  inherited Create;
  FExtension := ARecord.Extension;
end;

function TConversionFormatWrapper.ObjToRec: TConversionFormat;
begin
  result.Extension := FExtension;
end;

constructor TRichEditStreamInfoWrapper.Create(ARecord: TRichEditStreamInfo);
begin
  inherited Create;
  FConverter := ARecord.Converter;
  FStream := ARecord.Stream;
  FPlainText := ARecord.PlainText;
  FEncoding := ARecord.Encoding;
end;

function TRichEditStreamInfoWrapper.ObjToRec: TRichEditStreamInfo;
begin
  result.Converter := FConverter;
  result.Stream := FStream;
  result.PlainText := FPlainText;
  result.Encoding := FEncoding;
end;

constructor TAnimateParamsWrapper.Create(ARecord: TAnimateParams);
begin
  inherited Create;
  FFileName := ARecord.FileName;
  FCommonAVI := ARecord.CommonAVI;
  FResHandle := ARecord.ResHandle;
  FResName := ARecord.ResName;
  FResId := ARecord.ResId;
end;

function TAnimateParamsWrapper.ObjToRec: TAnimateParams;
begin
  result.FileName := FFileName;
  result.CommonAVI := FCommonAVI;
  result.ResHandle := FResHandle;
  result.ResName := FResName;
  result.ResId := FResId;
end;



procedure TatComCtrlsLibrary.__TCustomTabControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomTabControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTabControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTabControl(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTabControlIndexOfTabAt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomTabControl(CurrentObject).IndexOfTabAt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTabControlGetHitTestInfoAt(AMachine: TatVirtualMachine);
  var
  AResultSet: THitTests;
  AResult: variant;
begin
  with AMachine do
  begin
AResultSet := TCustomTabControl(CurrentObject).GetHitTestInfoAt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
AResult := IntFromSet(AResultSet, SizeOf(AResultSet));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTabControlTabRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(TCustomTabControl(CurrentObject).TabRect(VarToInteger(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTabControlRowCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomTabControl(CurrentObject).RowCount);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTabControlScrollTabs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTabControl(CurrentObject).ScrollTabs(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomTabControlCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTabControl(CurrentObject).Canvas));
  end;
end;

procedure TatComCtrlsLibrary.__TTabSheetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTabSheetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTabSheetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabSheet(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__GetTTabSheetPageControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTabSheet(CurrentObject).PageControl));
  end;
end;

procedure TatComCtrlsLibrary.__SetTTabSheetPageControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabSheet(CurrentObject).PageControl:=TPageControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTabSheetTabIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTabSheet(CurrentObject).TabIndex));
  end;
end;

procedure TatComCtrlsLibrary.__TPageControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPageControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TPageControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPageControl(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TPageControlFindNextPage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPageControl(CurrentObject).FindNextPage(TTabSheet(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TPageControlSelectNextPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TPageControl(CurrentObject).SelectNextPage(GetInputArg(0));
      2: TPageControl(CurrentObject).SelectNextPage(GetInputArg(0),GetInputArg(1));
    end;
  end;
end;

procedure TatComCtrlsLibrary.__GetTPageControlActivePageIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPageControl(CurrentObject).ActivePageIndex));
  end;
end;

procedure TatComCtrlsLibrary.__SetTPageControlActivePageIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPageControl(CurrentObject).ActivePageIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTPageControlPageCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPageControl(CurrentObject).PageCount));
  end;
end;

procedure TatComCtrlsLibrary.__GetTPageControlPages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPageControl(CurrentObject).Pages[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__TStatusPanelCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStatusPanelClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TStatusPanelAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStatusPanel(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__TStatusPanelParentBiDiModeChanged(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStatusPanel(CurrentObject).ParentBiDiModeChanged;
  end;
end;

procedure TatComCtrlsLibrary.__TStatusPanelUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TStatusPanel(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TStatusPanelUseRightToLeftReading(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TStatusPanel(CurrentObject).UseRightToLeftReading;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TStatusPanelsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStatusPanelsClass(CurrentClass.ClassRef).Create(TCustomStatusBar(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TStatusPanelsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStatusPanels(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TStatusPanelsAddItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStatusPanels(CurrentObject).AddItem(TStatusPanel(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TStatusPanelsInsert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStatusPanels(CurrentObject).Insert(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTStatusPanelsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TStatusPanels(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__SetTStatusPanelsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStatusPanels(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TStatusPanel(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomStatusBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomStatusBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomStatusBarDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomStatusBar(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomStatusBarExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomStatusBar(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomStatusBarFlipChildren(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomStatusBar(CurrentObject).FlipChildren(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomStatusBarSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomStatusBar(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomStatusBarCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomStatusBar(CurrentObject).Canvas));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomStatusBarAutoHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomStatusBar(CurrentObject).AutoHint);
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomStatusBarAutoHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomStatusBar(CurrentObject).AutoHint:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomStatusBarPanels(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomStatusBar(CurrentObject).Panels));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomStatusBarPanels(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomStatusBar(CurrentObject).Panels:=TStatusPanels(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomStatusBarSimplePanel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomStatusBar(CurrentObject).SimplePanel);
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomStatusBarSimplePanel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomStatusBar(CurrentObject).SimplePanel:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomStatusBarSimpleText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomStatusBar(CurrentObject).SimpleText);
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomStatusBarSimpleText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomStatusBar(CurrentObject).SimpleText:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomStatusBarSizeGrip(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomStatusBar(CurrentObject).SizeGrip);
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomStatusBarSizeGrip(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomStatusBar(CurrentObject).SizeGrip:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomStatusBarUseSystemFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomStatusBar(CurrentObject).UseSystemFont);
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomStatusBarUseSystemFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomStatusBar(CurrentObject).UseSystemFont:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__THeaderSectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(THeaderSectionClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__THeaderSectionAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THeaderSection(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__THeaderSectionParentBiDiModeChanged(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THeaderSection(CurrentObject).ParentBiDiModeChanged;
  end;
end;

procedure TatComCtrlsLibrary.__THeaderSectionUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := THeaderSection(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__THeaderSectionUseRightToLeftReading(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := THeaderSection(CurrentObject).UseRightToLeftReading;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTHeaderSectionLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(THeaderSection(CurrentObject).Left));
  end;
end;

procedure TatComCtrlsLibrary.__GetTHeaderSectionRight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(THeaderSection(CurrentObject).Right));
  end;
end;

procedure TatComCtrlsLibrary.__THeaderSectionsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(THeaderSectionsClass(CurrentClass.ClassRef).Create(TCustomHeaderControl(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__THeaderSectionsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(THeaderSections(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__THeaderSectionsAddItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(THeaderSections(CurrentObject).AddItem(THeaderSection(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__THeaderSectionsInsert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(THeaderSections(CurrentObject).Insert(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTHeaderSectionsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(THeaderSections(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__SetTHeaderSectionsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THeaderSections(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=THeaderSection(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomHeaderControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomHeaderControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomHeaderControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomHeaderControl(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomHeaderControlFlipChildren(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomHeaderControl(CurrentObject).FlipChildren(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomHeaderControlCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomHeaderControl(CurrentObject).Canvas));
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNodeClass(CurrentClass.ClassRef).Create(TTreeNodes(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeAlphaSort(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := TTreeNode(CurrentObject).AlphaSort;
1: AResult := TTreeNode(CurrentObject).AlphaSort(GetInputArg(0));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeCollapse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).Collapse(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).Delete;
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeDeleteChildren(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).DeleteChildren;
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeDisplayRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(TTreeNode(CurrentObject).DisplayRect(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeEditText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TTreeNode(CurrentObject).EditText;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeEndEdit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).EndEdit(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeExpand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).Expand(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodegetFirstChild(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNode(CurrentObject).getFirstChild);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeGetHandle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNode(CurrentObject).GetHandle);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeGetLastChild(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNode(CurrentObject).GetLastChild);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeGetNext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNode(CurrentObject).GetNext);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeGetNextChild(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNode(CurrentObject).GetNextChild(TTreeNode(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodegetNextSibling(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNode(CurrentObject).getNextSibling);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeGetNextVisible(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNode(CurrentObject).GetNextVisible);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeGetPrev(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNode(CurrentObject).GetPrev);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeGetPrevChild(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNode(CurrentObject).GetPrevChild(TTreeNode(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodegetPrevSibling(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNode(CurrentObject).getPrevSibling);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeGetPrevVisible(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNode(CurrentObject).GetPrevVisible);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeHasAsParent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TTreeNode(CurrentObject).HasAsParent(TTreeNode(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNode(CurrentObject).IndexOf(TTreeNode(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeMakeVisible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).MakeVisible;
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeMoveTo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).MoveTo(TTreeNode(Integer(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodeIsFirstNode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TTreeNode(CurrentObject).IsFirstNode;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeAbsoluteIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).AbsoluteIndex));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).Count));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeCut(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTreeNode(CurrentObject).Cut);
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeCut(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).Cut:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeDeleting(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTreeNode(CurrentObject).Deleting);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeFocused(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTreeNode(CurrentObject).Focused);
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeFocused(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).Focused:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeDropTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTreeNode(CurrentObject).DropTarget);
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeDropTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).DropTarget:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTreeNode(CurrentObject).Selected);
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).Selected:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeExpanded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTreeNode(CurrentObject).Expanded);
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeExpanded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).Expanded:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeExpandedImageIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).ExpandedImageIndex));
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeExpandedImageIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).ExpandedImageIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).Handle));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeHasChildren(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTreeNode(CurrentObject).HasChildren);
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeHasChildren(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).HasChildren:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeImageIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).ImageIndex));
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeImageIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).ImageIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).Index));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeIsVisible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTreeNode(CurrentObject).IsVisible);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).Item[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).Item[VarToInteger(GetArrayIndex(0))]:=TTreeNode(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).Level));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeOverlayIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).OverlayIndex));
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeOverlayIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).OverlayIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeOwner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).Owner));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).Parent));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeSelectedIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).SelectedIndex));
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeSelectedIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).SelectedIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeEnabled(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTreeNode(CurrentObject).Enabled);
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeEnabled(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).Enabled:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeStateIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).StateIndex));
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeStateIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).StateIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTreeNode(CurrentObject).Text);
  end;
end;

procedure TatComCtrlsLibrary.__SetTTreeNodeText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNode(CurrentObject).Text:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodeTreeView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNode(CurrentObject).TreeView));
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesEnumeratorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNodesEnumeratorClass(CurrentClass.ClassRef).Create(TTreeNodes(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesEnumeratorGetCurrent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNodesEnumerator(CurrentObject).GetCurrent);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesEnumeratorMoveNext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TTreeNodesEnumerator(CurrentObject).MoveNext;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodesEnumeratorCurrent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNodesEnumerator(CurrentObject).Current));
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNodesClass(CurrentClass.ClassRef).Create(TCustomTreeView(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNodes(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesAddChildFirst(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNodes(CurrentObject).AddChildFirst(TTreeNode(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesAddChild(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNodes(CurrentObject).AddChild(TTreeNode(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesAddFirst(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNodes(CurrentObject).AddFirst(TTreeNode(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNodes(CurrentObject).Add(TTreeNode(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesAlphaSort(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := TTreeNodes(CurrentObject).AlphaSort;
1: AResult := TTreeNodes(CurrentObject).AlphaSort(GetInputArg(0));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNodes(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesBeginUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNodes(CurrentObject).BeginUpdate;
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNodes(CurrentObject).Clear;
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNodes(CurrentObject).Delete(TTreeNode(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesEndUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTreeNodes(CurrentObject).EndUpdate;
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesGetFirstNode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNodes(CurrentObject).GetFirstNode);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesGetEnumerator(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNodes(CurrentObject).GetEnumerator);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTreeNodesInsert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTreeNodes(CurrentObject).Insert(TTreeNode(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodesCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNodes(CurrentObject).Count));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodesHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNodes(CurrentObject).Handle));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodesItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNodes(CurrentObject).Item[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTreeNodesOwner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTreeNodes(CurrentObject).Owner));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomTreeViewClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTreeView(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewAlphaSort(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := TCustomTreeView(CurrentObject).AlphaSort;
1: AResult := TCustomTreeView(CurrentObject).AlphaSort(GetInputArg(0));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewFullCollapse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTreeView(CurrentObject).FullCollapse;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewFullExpand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTreeView(CurrentObject).FullExpand;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewGetHitTestInfoAt(AMachine: TatVirtualMachine);
  var
  AResultSet: THitTests;
  AResult: variant;
begin
  with AMachine do
  begin
AResultSet := TCustomTreeView(CurrentObject).GetHitTestInfoAt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
AResult := IntFromSet(AResultSet, SizeOf(AResultSet));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewGetNodeAt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomTreeView(CurrentObject).GetNodeAt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewGetDragImages(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomTreeView(CurrentObject).GetDragImages);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewIsEditing(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomTreeView(CurrentObject).IsEditing;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTreeView(CurrentObject).LoadFromFile(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTreeView(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewSaveToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTreeView(CurrentObject).SaveToFile(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTreeView(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewSelect(AMachine: TatVirtualMachine);
  var
  Param1: TShiftState;
begin
  with AMachine do
  begin
IntToSet(Param1, VarToInteger(GetInputArg(1)), SizeOf(Param1));
    Case InputArgCount of
      1: TCustomTreeView(CurrentObject).Select(TTreeNode(Integer(GetInputArg(0))));
      2: TCustomTreeView(CurrentObject).Select(TTreeNode(Integer(GetInputArg(0))),Param1);
    end;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewDeselect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTreeView(CurrentObject).Deselect(TTreeNode(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewSubselect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TCustomTreeView(CurrentObject).Subselect(TTreeNode(Integer(GetInputArg(0))));
      2: TCustomTreeView(CurrentObject).Subselect(TTreeNode(Integer(GetInputArg(0))),GetInputArg(1));
    end;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewClearSelection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TCustomTreeView(CurrentObject).ClearSelection;
      1: TCustomTreeView(CurrentObject).ClearSelection(GetInputArg(0));
    end;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewGetSelections(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomTreeView(CurrentObject).GetSelections(TList(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomTreeViewFindNextToSelect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomTreeView(CurrentObject).FindNextToSelect);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomTreeViewCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTreeView(CurrentObject).Canvas));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomTreeViewDropTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTreeView(CurrentObject).DropTarget));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomTreeViewDropTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTreeView(CurrentObject).DropTarget:=TTreeNode(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomTreeViewSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTreeView(CurrentObject).Selected));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomTreeViewSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTreeView(CurrentObject).Selected:=TTreeNode(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomTreeViewTopItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTreeView(CurrentObject).TopItem));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomTreeViewTopItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTreeView(CurrentObject).TopItem:=TTreeNode(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomTreeViewSelectionCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTreeView(CurrentObject).SelectionCount));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomTreeViewSelections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTreeView(CurrentObject).Selections[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__TTrackBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTrackBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTrackBarSetTick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTrackBar(CurrentObject).SetTick(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__TProgressBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TProgressBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TProgressBarStepIt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TProgressBar(CurrentObject).StepIt;
  end;
end;

procedure TatComCtrlsLibrary.__TProgressBarStepBy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TProgressBar(CurrentObject).StepBy(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__TTextAttributesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTextAttributesClass(CurrentClass.ClassRef).Create(TCustomRichEdit(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TTextAttributesAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTextAttributes(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTextAttributesCharset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTextAttributes(CurrentObject).Charset);
  end;
end;

procedure TatComCtrlsLibrary.__SetTTextAttributesCharset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTextAttributes(CurrentObject).Charset:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTextAttributesColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTextAttributes(CurrentObject).Color);
  end;
end;

procedure TatComCtrlsLibrary.__SetTTextAttributesColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTextAttributes(CurrentObject).Color:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTextAttributesConsistentAttributes(AMachine: TatVirtualMachine);
var
PropValueSet: TConsistentAttributes;
begin
  with AMachine do
  begin
    PropValueSet := TTextAttributes(CurrentObject).ConsistentAttributes;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTextAttributesName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTextAttributes(CurrentObject).Name);
  end;
end;

procedure TatComCtrlsLibrary.__SetTTextAttributesName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTextAttributes(CurrentObject).Name:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTextAttributesPitch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTextAttributes(CurrentObject).Pitch);
  end;
end;

procedure TatComCtrlsLibrary.__SetTTextAttributesPitch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTextAttributes(CurrentObject).Pitch:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTextAttributesProtected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTextAttributes(CurrentObject).Protected);
  end;
end;

procedure TatComCtrlsLibrary.__SetTTextAttributesProtected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTextAttributes(CurrentObject).Protected:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTTextAttributesSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTextAttributes(CurrentObject).Size));
  end;
end;

procedure TatComCtrlsLibrary.__SetTTextAttributesSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTextAttributes(CurrentObject).Size:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTTextAttributesStyle(AMachine: TatVirtualMachine);
var
PropValueSet: TFontStyles;
begin
  with AMachine do
  begin
    PropValueSet := TTextAttributes(CurrentObject).Style;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatComCtrlsLibrary.__SetTTextAttributesStyle(AMachine: TatVirtualMachine);
  var
  TempVar: TFontStyles;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TTextAttributes(CurrentObject).Style:=TempVar;
  end;
end;

procedure TatComCtrlsLibrary.__GetTTextAttributesHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTextAttributes(CurrentObject).Height));
  end;
end;

procedure TatComCtrlsLibrary.__SetTTextAttributesHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTextAttributes(CurrentObject).Height:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TParaAttributesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TParaAttributesClass(CurrentClass.ClassRef).Create(TCustomRichEdit(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TParaAttributesAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParaAttributes(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__GetTParaAttributesAlignment(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParaAttributes(CurrentObject).Alignment);
  end;
end;

procedure TatComCtrlsLibrary.__SetTParaAttributesAlignment(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParaAttributes(CurrentObject).Alignment:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTParaAttributesFirstIndent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TParaAttributes(CurrentObject).FirstIndent));
  end;
end;

procedure TatComCtrlsLibrary.__SetTParaAttributesFirstIndent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParaAttributes(CurrentObject).FirstIndent:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTParaAttributesLeftIndent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TParaAttributes(CurrentObject).LeftIndent));
  end;
end;

procedure TatComCtrlsLibrary.__SetTParaAttributesLeftIndent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParaAttributes(CurrentObject).LeftIndent:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTParaAttributesNumbering(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParaAttributes(CurrentObject).Numbering);
  end;
end;

procedure TatComCtrlsLibrary.__SetTParaAttributesNumbering(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParaAttributes(CurrentObject).Numbering:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTParaAttributesRightIndent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TParaAttributes(CurrentObject).RightIndent));
  end;
end;

procedure TatComCtrlsLibrary.__SetTParaAttributesRightIndent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParaAttributes(CurrentObject).RightIndent:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTParaAttributesTab(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TParaAttributes(CurrentObject).Tab[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__SetTParaAttributesTab(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParaAttributes(CurrentObject).Tab[VarToInteger(GetArrayIndex(0))]:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTParaAttributesTabCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TParaAttributes(CurrentObject).TabCount));
  end;
end;

procedure TatComCtrlsLibrary.__SetTParaAttributesTabCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParaAttributes(CurrentObject).TabCount:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TConversionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TConversionClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TConversionConvertReadStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TConversion(CurrentObject).ConvertReadStream(TStream(Integer(GetInputArg(0))),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TConversionConvertWriteStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TConversion(CurrentObject).ConvertWriteStream(TStream(Integer(GetInputArg(0))),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomRichEditCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomRichEditClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomRichEditDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomRichEdit(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomRichEditClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomRichEdit(CurrentObject).Clear;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomRichEditFindText(AMachine: TatVirtualMachine);
  var
  Param3: TSearchTypes;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param3, VarToInteger(GetInputArg(3)), SizeOf(Param3));
AResult := Integer(TCustomRichEdit(CurrentObject).FindText(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomRichEditPrint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomRichEdit(CurrentObject).Print(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomRichEditGetSelTextBuf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomRichEdit(CurrentObject).GetSelTextBuf(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomRichEditActiveLineNo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomRichEdit(CurrentObject).ActiveLineNo));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomRichEditDefAttributes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomRichEdit(CurrentObject).DefAttributes));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomRichEditDefAttributes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomRichEdit(CurrentObject).DefAttributes:=TTextAttributes(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomRichEditSelAttributes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomRichEdit(CurrentObject).SelAttributes));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomRichEditSelAttributes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomRichEdit(CurrentObject).SelAttributes:=TTextAttributes(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomRichEditPageRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TCustomRichEdit(CurrentObject).PageRect)));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomRichEditPageRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomRichEdit(CurrentObject).PageRect:=TRectWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomRichEditParagraph(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomRichEdit(CurrentObject).Paragraph));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomUpDownCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomUpDownClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomHotKeyCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomHotKeyClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListGroupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListGroupClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListGroupDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListGroup(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TListGroupAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListGroup(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__TListGroupsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListGroupsClass(CurrentClass.ClassRef).Create(TCustomListView(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListGroupsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListGroups(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListGroupsOwner(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListGroups(CurrentObject).Owner);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTListGroupsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListGroups(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListGroupsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListGroups(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TListGroup(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListGroupsNextGroupID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListGroups(CurrentObject).NextGroupID));
  end;
end;

procedure TatComCtrlsLibrary.__TListColumnCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListColumnClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListColumnDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListColumn(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TListColumnAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListColumn(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListColumnWidthType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TListColumn(CurrentObject).WidthType);
  end;
end;

procedure TatComCtrlsLibrary.__TListColumnsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListColumnsClass(CurrentClass.ClassRef).Create(TCustomListView(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListColumnsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListColumns(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListColumnsOwner(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListColumns(CurrentObject).Owner);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTListColumnsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListColumns(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListColumnsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListColumns(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TListColumn(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__TListItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListItemClass(CurrentClass.ClassRef).Create(TListItems(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListItemDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TListItemAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__TListItemCancelEdit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).CancelEdit;
  end;
end;

procedure TatComCtrlsLibrary.__TListItemDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).Delete;
  end;
end;

procedure TatComCtrlsLibrary.__TListItemDisplayRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(TListItem(CurrentObject).DisplayRect(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListItemEditCaption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TListItem(CurrentObject).EditCaption;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListItemGetPosition(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TPointWrapper.Create(TListItem(CurrentObject).GetPosition));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListItemMakeVisible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).MakeVisible(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TListItemUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).Update;
  end;
end;

procedure TatComCtrlsLibrary.__TListItemSetPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).SetPosition(TPointWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatComCtrlsLibrary.__TListItemWorkArea(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListItem(CurrentObject).WorkArea);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemCaption(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TListItem(CurrentObject).Caption);
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemCaption(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).Caption:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemChecked(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TListItem(CurrentObject).Checked);
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemChecked(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).Checked:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemCut(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TListItem(CurrentObject).Cut);
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemCut(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).Cut:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemDeleting(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TListItem(CurrentObject).Deleting);
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemDropTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TListItem(CurrentObject).DropTarget);
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemDropTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).DropTarget:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemFocused(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TListItem(CurrentObject).Focused);
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemFocused(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).Focused:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemGroupID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItem(CurrentObject).GroupID));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemGroupID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).GroupID:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItem(CurrentObject).Handle));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemImageIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItem(CurrentObject).ImageIndex));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemImageIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).ImageIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemIndent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItem(CurrentObject).Indent));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemIndent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).Indent:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItem(CurrentObject).Index));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItem(CurrentObject).Left));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).Left:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemListView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItem(CurrentObject).ListView));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemOwner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItem(CurrentObject).Owner));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemOverlayIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItem(CurrentObject).OverlayIndex));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemOverlayIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).OverlayIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TPointWrapper.Create(TListItem(CurrentObject).Position)));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).Position:=TPointWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TListItem(CurrentObject).Selected);
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).Selected:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemStateIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItem(CurrentObject).StateIndex));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemStateIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).StateIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemSubItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItem(CurrentObject).SubItems));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemSubItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).SubItems:=TStrings(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemSubItemImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItem(CurrentObject).SubItemImages[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemSubItemImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).SubItemImages[VarToInteger(GetArrayIndex(0))]:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItem(CurrentObject).Top));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItem(CurrentObject).Top:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsEnumeratorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListItemsEnumeratorClass(CurrentClass.ClassRef).Create(TListItems(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsEnumeratorGetCurrent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListItemsEnumerator(CurrentObject).GetCurrent);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsEnumeratorMoveNext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TListItemsEnumerator(CurrentObject).MoveNext;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemsEnumeratorCurrent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItemsEnumerator(CurrentObject).Current));
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListItemsClass(CurrentClass.ClassRef).Create(TCustomListView(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItems(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListItems(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsAddItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(TListItems(CurrentObject).AddItem(TListItem(Integer(GetInputArg(0)))));
2: AResult := Integer(TListItems(CurrentObject).AddItem(TListItem(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItems(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsBeginUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItems(CurrentObject).BeginUpdate;
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItems(CurrentObject).Clear;
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItems(CurrentObject).Delete(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsEndUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItems(CurrentObject).EndUpdate;
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsGetEnumerator(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListItems(CurrentObject).GetEnumerator);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListItems(CurrentObject).IndexOf(TListItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TListItemsInsert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListItems(CurrentObject).Insert(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemsCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItems(CurrentObject).Count));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemsCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItems(CurrentObject).Count:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemsHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItems(CurrentObject).Handle));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemsItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItems(CurrentObject).Item[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__SetTListItemsItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListItems(CurrentObject).Item[VarToInteger(GetArrayIndex(0))]:=TListItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTListItemsOwner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListItems(CurrentObject).Owner));
  end;
end;

procedure TatComCtrlsLibrary.__TWorkAreaCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TWorkAreaClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TWorkAreaSetDisplayName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWorkArea(CurrentObject).SetDisplayName(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TWorkAreaGetDisplayName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TWorkArea(CurrentObject).GetDisplayName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTWorkAreaRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TWorkArea(CurrentObject).Rect)));
  end;
end;

procedure TatComCtrlsLibrary.__SetTWorkAreaRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWorkArea(CurrentObject).Rect:=TRectWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatComCtrlsLibrary.__GetTWorkAreaColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TWorkArea(CurrentObject).Color);
  end;
end;

procedure TatComCtrlsLibrary.__SetTWorkAreaColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWorkArea(CurrentObject).Color:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__TWorkAreasAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TWorkAreas(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TWorkAreasDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWorkAreas(CurrentObject).Delete(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__TWorkAreasInsert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TWorkAreas(CurrentObject).Insert(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTWorkAreasItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TWorkAreas(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__SetTWorkAreasItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWorkAreas(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TWorkArea(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__TIconOptionsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIconOptionsClass(CurrentClass.ClassRef).Create(TCustomListView(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomListViewClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewAddItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).AddItem(GetInputArg(0),TObject(integer(GetInputArg(1))));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewAlphaSort(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomListView(CurrentObject).AlphaSort;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewArrange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).Arrange(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).Clear;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewClearSelection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).ClearSelection;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewCopySelection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).CopySelection(TCustomListControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewDeleteSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).DeleteSelected;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewFindCaption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomListView(CurrentObject).FindCaption(VarToInteger(GetInputArg(0)),GetInputArg(1),GetInputArg(2),GetInputArg(3),GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewGetCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomListView(CurrentObject).GetCount);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewGetHitTestInfoAt(AMachine: TatVirtualMachine);
  var
  AResultSet: THitTests;
  AResult: variant;
begin
  with AMachine do
  begin
AResultSet := TCustomListView(CurrentObject).GetHitTestInfoAt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
AResult := IntFromSet(AResultSet, SizeOf(AResultSet));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewGetItemAt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomListView(CurrentObject).GetItemAt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewGetNearestItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomListView(CurrentObject).GetNearestItem(TPointWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewGetNextItem(AMachine: TatVirtualMachine);
  var
  Param2: TItemStates;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := Integer(TCustomListView(CurrentObject).GetNextItem(TListItem(Integer(GetInputArg(0))),GetInputArg(1),Param2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewGetSearchString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomListView(CurrentObject).GetSearchString;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewIsEditing(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomListView(CurrentObject).IsEditing;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewSelectAll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).SelectAll;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewScroll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).Scroll(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewGetDragImages(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomListView(CurrentObject).GetDragImages);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewStringWidth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomListView(CurrentObject).StringWidth(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomListViewUpdateItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).UpdateItems(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListView(CurrentObject).Canvas));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewCheckboxes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomListView(CurrentObject).Checkboxes);
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomListViewCheckboxes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).Checkboxes:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewColumn(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListView(CurrentObject).Column[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewDropTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListView(CurrentObject).DropTarget));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomListViewDropTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).DropTarget:=TListItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewFlatScrollBars(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomListView(CurrentObject).FlatScrollBars);
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomListViewFlatScrollBars(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).FlatScrollBars:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewFullDrag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomListView(CurrentObject).FullDrag);
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomListViewFullDrag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).FullDrag:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewGridLines(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomListView(CurrentObject).GridLines);
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomListViewGridLines(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).GridLines:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewHotTrack(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomListView(CurrentObject).HotTrack);
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomListViewHotTrack(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).HotTrack:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewHotTrackStyles(AMachine: TatVirtualMachine);
var
PropValueSet: TListHotTrackStyles;
begin
  with AMachine do
  begin
    PropValueSet := TCustomListView(CurrentObject).HotTrackStyles;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomListViewHotTrackStyles(AMachine: TatVirtualMachine);
  var
  TempVar: TListHotTrackStyles;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TCustomListView(CurrentObject).HotTrackStyles:=TempVar;
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewItemFocused(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListView(CurrentObject).ItemFocused));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomListViewItemFocused(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).ItemFocused:=TListItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListView(CurrentObject).Items));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomListViewItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).Items:=TListItems(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewRowSelect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomListView(CurrentObject).RowSelect);
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomListViewRowSelect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).RowSelect:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewSelCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListView(CurrentObject).SelCount));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListView(CurrentObject).Selected));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomListViewSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListView(CurrentObject).Selected:=TListItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewTopItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListView(CurrentObject).TopItem));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewViewOrigin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TPointWrapper.Create(TCustomListView(CurrentObject).ViewOrigin)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewVisibleRowCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListView(CurrentObject).VisibleRowCount));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewBoundingRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TCustomListView(CurrentObject).BoundingRect)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomListViewWorkAreas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListView(CurrentObject).WorkAreas));
  end;
end;

procedure TatComCtrlsLibrary.__TAnimateCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAnimateClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TAnimatePlay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAnimate(CurrentObject).Play(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatComCtrlsLibrary.__TAnimateReset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAnimate(CurrentObject).Reset;
  end;
end;

procedure TatComCtrlsLibrary.__TAnimateSeek(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAnimate(CurrentObject).Seek(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__TAnimateStop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAnimate(CurrentObject).Stop;
  end;
end;

procedure TatComCtrlsLibrary.__GetTAnimateFrameCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAnimate(CurrentObject).FrameCount));
  end;
end;

procedure TatComCtrlsLibrary.__GetTAnimateFrameHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAnimate(CurrentObject).FrameHeight));
  end;
end;

procedure TatComCtrlsLibrary.__GetTAnimateFrameWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAnimate(CurrentObject).FrameWidth));
  end;
end;

procedure TatComCtrlsLibrary.__GetTAnimateOpen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TAnimate(CurrentObject).Open);
  end;
end;

procedure TatComCtrlsLibrary.__SetTAnimateOpen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAnimate(CurrentObject).Open:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTAnimateResHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TAnimate(CurrentObject).ResHandle);
  end;
end;

procedure TatComCtrlsLibrary.__SetTAnimateResHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAnimate(CurrentObject).ResHandle:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTAnimateResId(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAnimate(CurrentObject).ResId));
  end;
end;

procedure TatComCtrlsLibrary.__SetTAnimateResId(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAnimate(CurrentObject).ResId:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTAnimateResName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TAnimate(CurrentObject).ResName);
  end;
end;

procedure TatComCtrlsLibrary.__SetTAnimateResName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAnimate(CurrentObject).ResName:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__TToolButtonCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TToolButtonClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TToolButtonCheckMenuDropdown(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TToolButton(CurrentObject).CheckMenuDropdown;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TToolButtonClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TToolButton(CurrentObject).Click;
  end;
end;

procedure TatComCtrlsLibrary.__TToolButtonSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TToolButton(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTToolButtonIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TToolButton(CurrentObject).Index));
  end;
end;

procedure TatComCtrlsLibrary.__TToolBarEnumeratorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TToolBarEnumeratorClass(CurrentClass.ClassRef).Create(TToolBar(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TToolBarEnumeratorGetCurrent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TToolBarEnumerator(CurrentObject).GetCurrent);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TToolBarEnumeratorMoveNext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TToolBarEnumerator(CurrentObject).MoveNext;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTToolBarEnumeratorCurrent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TToolBarEnumerator(CurrentObject).Current));
  end;
end;

procedure TatComCtrlsLibrary.__TToolBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TToolBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TToolBarDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TToolBar(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TToolBarFlipChildren(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TToolBar(CurrentObject).FlipChildren(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TToolBarGetEnumerator(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TToolBar(CurrentObject).GetEnumerator);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TToolBarTrackMenu(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TToolBar(CurrentObject).TrackMenu(TToolButton(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTToolBarButtonCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TToolBar(CurrentObject).ButtonCount));
  end;
end;

procedure TatComCtrlsLibrary.__GetTToolBarButtons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TToolBar(CurrentObject).Buttons[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__GetTToolBarCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TToolBar(CurrentObject).Canvas));
  end;
end;

procedure TatComCtrlsLibrary.__GetTToolBarCustomizeKeyName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TToolBar(CurrentObject).CustomizeKeyName);
  end;
end;

procedure TatComCtrlsLibrary.__SetTToolBarCustomizeKeyName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TToolBar(CurrentObject).CustomizeKeyName:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTToolBarCustomizeValueName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TToolBar(CurrentObject).CustomizeValueName);
  end;
end;

procedure TatComCtrlsLibrary.__SetTToolBarCustomizeValueName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TToolBar(CurrentObject).CustomizeValueName:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTToolBarRowCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TToolBar(CurrentObject).RowCount));
  end;
end;

procedure TatComCtrlsLibrary.__TCoolBandCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCoolBandClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCoolBandDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCoolBand(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TCoolBandAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCoolBand(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCoolBandHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCoolBand(CurrentObject).Height));
  end;
end;

procedure TatComCtrlsLibrary.__TCoolBandsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCoolBandsClass(CurrentClass.ClassRef).Create(TCoolBar(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCoolBandsDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCoolBands(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TCoolBandsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCoolBands(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCoolBandsFindBand(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCoolBands(CurrentObject).FindBand(TControl(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCoolBandsCoolBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCoolBands(CurrentObject).CoolBar));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCoolBandsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCoolBands(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCoolBandsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCoolBands(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TCoolBand(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__TCoolBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCoolBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCoolBarDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCoolBar(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TCoolBarFlipChildren(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCoolBar(CurrentObject).FlipChildren(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__TMonthCalColorsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMonthCalColorsClass(CurrentClass.ClassRef).Create(TCommonCalendar(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TMonthCalColorsAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMonthCalColors(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__TCommonCalendarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCommonCalendarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCommonCalendarDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCommonCalendar(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TMonthCalendarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMonthCalendarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TDateTimePickerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDateTimePickerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTDateTimePickerDroppedDown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDateTimePicker(CurrentObject).DroppedDown);
  end;
end;

procedure TatComCtrlsLibrary.__TPageScrollerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPageScrollerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TPageScrollerGetButtonState(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPageScroller(CurrentObject).GetButtonState(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TComboExItemAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComboExItem(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.__TComboExItemsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComboExItems(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TComboExItemsInsert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComboExItems(CurrentObject).Insert(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTComboExItemsComboItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TComboExItems(CurrentObject).ComboItems[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComboBoxExStringsClass(CurrentClass.ClassRef).Create(TCustomComboBoxEx(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComboBoxExStrings(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComboBoxExStrings(CurrentObject).Add(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsAddObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComboBoxExStrings(CurrentObject).AddObject(GetInputArg(0),TObject(integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComboBoxExStrings(CurrentObject).Clear;
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComboBoxExStrings(CurrentObject).Delete(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsExchange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComboBoxExStrings(CurrentObject).Exchange(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsGet(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TComboBoxExStrings(CurrentObject).Get(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsGetCapacity(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComboBoxExStrings(CurrentObject).GetCapacity);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsGetCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComboBoxExStrings(CurrentObject).GetCount);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsGetObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TComboBoxExStrings(CurrentObject).GetObject(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComboBoxExStrings(CurrentObject).IndexOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsIndexOfName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComboBoxExStrings(CurrentObject).IndexOfName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsInsert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComboBoxExStrings(CurrentObject).Insert(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatComCtrlsLibrary.__TComboBoxExStringsMove(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComboBoxExStrings(CurrentObject).Move(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTComboBoxExStringsSortType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComboBoxExStrings(CurrentObject).SortType);
  end;
end;

procedure TatComCtrlsLibrary.__SetTComboBoxExStringsSortType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComboBoxExStrings(CurrentObject).SortType:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTComboBoxExStringsItemsEx(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TComboBoxExStrings(CurrentObject).ItemsEx));
  end;
end;

procedure TatComCtrlsLibrary.__SetTComboBoxExStringsItemsEx(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComboBoxExStrings(CurrentObject).ItemsEx:=TComboExItems(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__TCustomComboBoxExCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomComboBoxExClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__TCustomComboBoxExDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBoxEx(CurrentObject).Destroy;
  end;
end;

procedure TatComCtrlsLibrary.__TCustomComboBoxExFocused(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomComboBoxEx(CurrentObject).Focused;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomComboBoxExAutoCompleteOptions(AMachine: TatVirtualMachine);
var
PropValueSet: TAutoCompleteOptions;
begin
  with AMachine do
  begin
    PropValueSet := TCustomComboBoxEx(CurrentObject).AutoCompleteOptions;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomComboBoxExAutoCompleteOptions(AMachine: TatVirtualMachine);
  var
  TempVar: TAutoCompleteOptions;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TCustomComboBoxEx(CurrentObject).AutoCompleteOptions:=TempVar;
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomComboBoxExDropDownCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomComboBoxEx(CurrentObject).DropDownCount));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomComboBoxExDropDownCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBoxEx(CurrentObject).DropDownCount:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomComboBoxExImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomComboBoxEx(CurrentObject).Images));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomComboBoxExImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBoxEx(CurrentObject).Images:=TCustomImageList(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomComboBoxExItemsEx(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomComboBoxEx(CurrentObject).ItemsEx));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomComboBoxExItemsEx(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBoxEx(CurrentObject).ItemsEx:=TComboExItems(Integer(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomComboBoxExSelText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomComboBoxEx(CurrentObject).SelText);
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomComboBoxExSelText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBoxEx(CurrentObject).SelText:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomComboBoxExStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomComboBoxEx(CurrentObject).Style);
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomComboBoxExStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBoxEx(CurrentObject).Style:=GetInputArg(0);
  end;
end;

procedure TatComCtrlsLibrary.__GetTCustomComboBoxExStyleEx(AMachine: TatVirtualMachine);
var
PropValueSet: TComboBoxExStyles;
begin
  with AMachine do
  begin
    PropValueSet := TCustomComboBoxEx(CurrentObject).StyleEx;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatComCtrlsLibrary.__SetTCustomComboBoxExStyleEx(AMachine: TatVirtualMachine);
  var
  TempVar: TComboBoxExStyles;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TCustomComboBoxEx(CurrentObject).StyleEx:=TempVar;
  end;
end;

procedure TatComCtrlsDispatcher.__TTabChangingEvent( Sender: TObject; var AllowChange: Boolean);
var
  AllowChangeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTabChangingEvent(BeforeCall)(Sender,AllowChange);
    AllowChangeTemp := AllowChange;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,AllowChangeTemp]);
    AllowChange := AllowChangeTemp;
    if AssignedMethod(AfterCall) then
      TTabChangingEvent(AfterCall)(Sender,AllowChange);
  end;
end;

procedure TatComCtrlsDispatcher.__TTabGetImageEvent( Sender: TObject;  TabIndex: Integer; var ImageIndex: Integer);
var
  ImageIndexTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTabGetImageEvent(BeforeCall)(Sender,TabIndex,ImageIndex);
    ImageIndexTemp := Integer(ImageIndex);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,TabIndex,ImageIndexTemp]);
    ImageIndex := VarToInteger(ImageIndexTemp);
    if AssignedMethod(AfterCall) then
      TTabGetImageEvent(AfterCall)(Sender,TabIndex,ImageIndex);
  end;
end;

procedure TatComCtrlsDispatcher.__TCustomSectionNotifyEvent( HeaderControl: TCustomHeaderControl;  Section: THeaderSection);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCustomSectionNotifyEvent(BeforeCall)(HeaderControl,Section);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [HeaderControl,Section]);
    if AssignedMethod(AfterCall) then
      TCustomSectionNotifyEvent(AfterCall)(HeaderControl,Section);
  end;
end;

procedure TatComCtrlsDispatcher.__TCustomSectionTrackEvent( HeaderControl: TCustomHeaderControl;  Section: THeaderSection;  Width: Integer;  State: TSectionTrackState);
var
  StateTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCustomSectionTrackEvent(BeforeCall)(HeaderControl,Section,Width,State);
    StateTemp := State;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [HeaderControl,Section,Width,StateTemp]);
    if AssignedMethod(AfterCall) then
      TCustomSectionTrackEvent(AfterCall)(HeaderControl,Section,Width,State);
  end;
end;

procedure TatComCtrlsDispatcher.__TSectionDragEvent( Sender: TObject;  FromSection: THeaderSection;  ToSection: THeaderSection; var AllowDrag: Boolean);
var
  AllowDragTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSectionDragEvent(BeforeCall)(Sender,FromSection,ToSection,AllowDrag);
    AllowDragTemp := AllowDrag;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,FromSection,ToSection,AllowDragTemp]);
    AllowDrag := AllowDragTemp;
    if AssignedMethod(AfterCall) then
      TSectionDragEvent(AfterCall)(Sender,FromSection,ToSection,AllowDrag);
  end;
end;

procedure TatComCtrlsDispatcher.__TSectionNotifyEvent( HeaderControl: THeaderControl;  Section: THeaderSection);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSectionNotifyEvent(BeforeCall)(HeaderControl,Section);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [HeaderControl,Section]);
    if AssignedMethod(AfterCall) then
      TSectionNotifyEvent(AfterCall)(HeaderControl,Section);
  end;
end;

procedure TatComCtrlsDispatcher.__TSectionTrackEvent( HeaderControl: THeaderControl;  Section: THeaderSection;  Width: Integer;  State: TSectionTrackState);
var
  StateTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSectionTrackEvent(BeforeCall)(HeaderControl,Section,Width,State);
    StateTemp := State;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [HeaderControl,Section,Width,StateTemp]);
    if AssignedMethod(AfterCall) then
      TSectionTrackEvent(AfterCall)(HeaderControl,Section,Width,State);
  end;
end;

procedure TatComCtrlsDispatcher.__TTVChangingEvent( Sender: TObject;  Node: TTreeNode; var AllowChange: Boolean);
var
  AllowChangeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTVChangingEvent(BeforeCall)(Sender,Node,AllowChange);
    AllowChangeTemp := AllowChange;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Node,AllowChangeTemp]);
    AllowChange := AllowChangeTemp;
    if AssignedMethod(AfterCall) then
      TTVChangingEvent(AfterCall)(Sender,Node,AllowChange);
  end;
end;

procedure TatComCtrlsDispatcher.__TTVChangedEvent( Sender: TObject;  Node: TTreeNode);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTVChangedEvent(BeforeCall)(Sender,Node);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Node]);
    if AssignedMethod(AfterCall) then
      TTVChangedEvent(AfterCall)(Sender,Node);
  end;
end;

procedure TatComCtrlsDispatcher.__TTVEditingEvent( Sender: TObject;  Node: TTreeNode; var AllowEdit: Boolean);
var
  AllowEditTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTVEditingEvent(BeforeCall)(Sender,Node,AllowEdit);
    AllowEditTemp := AllowEdit;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Node,AllowEditTemp]);
    AllowEdit := AllowEditTemp;
    if AssignedMethod(AfterCall) then
      TTVEditingEvent(AfterCall)(Sender,Node,AllowEdit);
  end;
end;

procedure TatComCtrlsDispatcher.__TTVEditedEvent( Sender: TObject;  Node: TTreeNode; var S: string);
var
  STemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTVEditedEvent(BeforeCall)(Sender,Node,S);
    STemp := S;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Node,STemp]);
    S := STemp;
    if AssignedMethod(AfterCall) then
      TTVEditedEvent(AfterCall)(Sender,Node,S);
  end;
end;

procedure TatComCtrlsDispatcher.__TTVExpandingEvent( Sender: TObject;  Node: TTreeNode; var AllowExpansion: Boolean);
var
  AllowExpansionTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTVExpandingEvent(BeforeCall)(Sender,Node,AllowExpansion);
    AllowExpansionTemp := AllowExpansion;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Node,AllowExpansionTemp]);
    AllowExpansion := AllowExpansionTemp;
    if AssignedMethod(AfterCall) then
      TTVExpandingEvent(AfterCall)(Sender,Node,AllowExpansion);
  end;
end;

procedure TatComCtrlsDispatcher.__TTVCollapsingEvent( Sender: TObject;  Node: TTreeNode; var AllowCollapse: Boolean);
var
  AllowCollapseTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTVCollapsingEvent(BeforeCall)(Sender,Node,AllowCollapse);
    AllowCollapseTemp := AllowCollapse;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Node,AllowCollapseTemp]);
    AllowCollapse := AllowCollapseTemp;
    if AssignedMethod(AfterCall) then
      TTVCollapsingEvent(AfterCall)(Sender,Node,AllowCollapse);
  end;
end;

procedure TatComCtrlsDispatcher.__TTVExpandedEvent( Sender: TObject;  Node: TTreeNode);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTVExpandedEvent(BeforeCall)(Sender,Node);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Node]);
    if AssignedMethod(AfterCall) then
      TTVExpandedEvent(AfterCall)(Sender,Node);
  end;
end;

procedure TatComCtrlsDispatcher.__TTVCompareEvent( Sender: TObject;  Node1: TTreeNode;  Node2: TTreeNode;  Data: Integer; var Compare: Integer);
var
  CompareTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTVCompareEvent(BeforeCall)(Sender,Node1,Node2,Data,Compare);
    CompareTemp := Integer(Compare);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Node1,Node2,Data,CompareTemp]);
    Compare := VarToInteger(CompareTemp);
    if AssignedMethod(AfterCall) then
      TTVCompareEvent(AfterCall)(Sender,Node1,Node2,Data,Compare);
  end;
end;

procedure TatComCtrlsDispatcher.__TTVHintEvent( Sender: TObject; const Node: TTreeNode; var Hint: String);
var
  HintTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTVHintEvent(BeforeCall)(Sender,Node,Hint);
    HintTemp := Hint;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Node,HintTemp]);
    Hint := HintTemp;
    if AssignedMethod(AfterCall) then
      TTVHintEvent(AfterCall)(Sender,Node,Hint);
  end;
end;

procedure TatComCtrlsDispatcher.__TTVCustomDrawItemEvent( Sender: TCustomTreeView;  Node: TTreeNode;  State: TCustomDrawState; var DefaultDraw: Boolean);
var
  StateTempSet: TCustomDrawState;
  StateTemp: variant;
  DefaultDrawTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTVCustomDrawItemEvent(BeforeCall)(Sender,Node,State,DefaultDraw);
    StateTempSet := State;
    StateTemp := IntFromSet(StateTempSet, SizeOf(StateTempSet));
    DefaultDrawTemp := DefaultDraw;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Node,StateTemp,DefaultDrawTemp]);
    DefaultDraw := DefaultDrawTemp;
    if AssignedMethod(AfterCall) then
      TTVCustomDrawItemEvent(AfterCall)(Sender,Node,State,DefaultDraw);
  end;
end;

procedure TatComCtrlsDispatcher.__TTVAdvancedCustomDrawItemEvent( Sender: TCustomTreeView;  Node: TTreeNode;  State: TCustomDrawState;  Stage: TCustomDrawStage; var PaintImages: Boolean; var DefaultDraw: Boolean);
var
  StateTempSet: TCustomDrawState;
  StateTemp: variant;
  StageTemp: variant;
  PaintImagesTemp: variant;
  DefaultDrawTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTVAdvancedCustomDrawItemEvent(BeforeCall)(Sender,Node,State,Stage,PaintImages,DefaultDraw);
    StateTempSet := State;
    StateTemp := IntFromSet(StateTempSet, SizeOf(StateTempSet));
    StageTemp := Stage;
    PaintImagesTemp := PaintImages;
    DefaultDrawTemp := DefaultDraw;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Node,StateTemp,StageTemp,PaintImagesTemp,DefaultDrawTemp]);
    PaintImages := PaintImagesTemp;
    DefaultDraw := DefaultDrawTemp;
    if AssignedMethod(AfterCall) then
      TTVAdvancedCustomDrawItemEvent(AfterCall)(Sender,Node,State,Stage,PaintImages,DefaultDraw);
  end;
end;

procedure TatComCtrlsDispatcher.__TRichEditProtectChange( Sender: TObject;  StartPos: Integer;  EndPos: Integer; var AllowChange: Boolean);
var
  AllowChangeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TRichEditProtectChange(BeforeCall)(Sender,StartPos,EndPos,AllowChange);
    AllowChangeTemp := AllowChange;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,StartPos,EndPos,AllowChangeTemp]);
    AllowChange := AllowChangeTemp;
    if AssignedMethod(AfterCall) then
      TRichEditProtectChange(AfterCall)(Sender,StartPos,EndPos,AllowChange);
  end;
end;

procedure TatComCtrlsDispatcher.__TRichEditSaveClipboard( Sender: TObject;  NumObjects: Integer;  NumChars: Integer; var SaveClipboard: Boolean);
var
  SaveClipboardTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TRichEditSaveClipboard(BeforeCall)(Sender,NumObjects,NumChars,SaveClipboard);
    SaveClipboardTemp := SaveClipboard;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,NumObjects,NumChars,SaveClipboardTemp]);
    SaveClipboard := SaveClipboardTemp;
    if AssignedMethod(AfterCall) then
      TRichEditSaveClipboard(AfterCall)(Sender,NumObjects,NumChars,SaveClipboard);
  end;
end;

procedure TatComCtrlsDispatcher.__TUDClickEvent( Sender: TObject;  Button: TUDBtnType);
var
  ButtonTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TUDClickEvent(BeforeCall)(Sender,Button);
    ButtonTemp := Button;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ButtonTemp]);
    if AssignedMethod(AfterCall) then
      TUDClickEvent(AfterCall)(Sender,Button);
  end;
end;

procedure TatComCtrlsDispatcher.__TUDChangingEvent( Sender: TObject; var AllowChange: Boolean);
var
  AllowChangeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TUDChangingEvent(BeforeCall)(Sender,AllowChange);
    AllowChangeTemp := AllowChange;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,AllowChangeTemp]);
    AllowChange := AllowChangeTemp;
    if AssignedMethod(AfterCall) then
      TUDChangingEvent(AfterCall)(Sender,AllowChange);
  end;
end;

procedure TatComCtrlsDispatcher.__TUDChangingEventEx( Sender: TObject; var AllowChange: Boolean;  NewValue: SmallInt;  Direction: TUpDownDirection);
var
  AllowChangeTemp: variant;
  DirectionTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TUDChangingEventEx(BeforeCall)(Sender,AllowChange,NewValue,Direction);
    AllowChangeTemp := AllowChange;
    DirectionTemp := Direction;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,AllowChangeTemp,NewValue,DirectionTemp]);
    AllowChange := AllowChangeTemp;
    if AssignedMethod(AfterCall) then
      TUDChangingEventEx(AfterCall)(Sender,AllowChange,NewValue,Direction);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVDeletedEvent( Sender: TObject;  Item: TListItem);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVDeletedEvent(BeforeCall)(Sender,Item);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item]);
    if AssignedMethod(AfterCall) then
      TLVDeletedEvent(AfterCall)(Sender,Item);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVEditingEvent( Sender: TObject;  Item: TListItem; var AllowEdit: Boolean);
var
  AllowEditTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVEditingEvent(BeforeCall)(Sender,Item,AllowEdit);
    AllowEditTemp := AllowEdit;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item,AllowEditTemp]);
    AllowEdit := AllowEditTemp;
    if AssignedMethod(AfterCall) then
      TLVEditingEvent(AfterCall)(Sender,Item,AllowEdit);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVEditedEvent( Sender: TObject;  Item: TListItem; var S: string);
var
  STemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVEditedEvent(BeforeCall)(Sender,Item,S);
    STemp := S;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item,STemp]);
    S := STemp;
    if AssignedMethod(AfterCall) then
      TLVEditedEvent(AfterCall)(Sender,Item,S);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVChangeEvent( Sender: TObject;  Item: TListItem;  Change: TItemChange);
var
  ChangeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVChangeEvent(BeforeCall)(Sender,Item,Change);
    ChangeTemp := Change;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item,ChangeTemp]);
    if AssignedMethod(AfterCall) then
      TLVChangeEvent(AfterCall)(Sender,Item,Change);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVChangingEvent( Sender: TObject;  Item: TListItem;  Change: TItemChange; var AllowChange: Boolean);
var
  ChangeTemp: variant;
  AllowChangeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVChangingEvent(BeforeCall)(Sender,Item,Change,AllowChange);
    ChangeTemp := Change;
    AllowChangeTemp := AllowChange;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item,ChangeTemp,AllowChangeTemp]);
    AllowChange := AllowChangeTemp;
    if AssignedMethod(AfterCall) then
      TLVChangingEvent(AfterCall)(Sender,Item,Change,AllowChange);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVColumnClickEvent( Sender: TObject;  Column: TListColumn);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVColumnClickEvent(BeforeCall)(Sender,Column);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Column]);
    if AssignedMethod(AfterCall) then
      TLVColumnClickEvent(AfterCall)(Sender,Column);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVCompareEvent( Sender: TObject;  Item1: TListItem;  Item2: TListItem;  Data: Integer; var Compare: Integer);
var
  CompareTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVCompareEvent(BeforeCall)(Sender,Item1,Item2,Data,Compare);
    CompareTemp := Integer(Compare);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item1,Item2,Data,CompareTemp]);
    Compare := VarToInteger(CompareTemp);
    if AssignedMethod(AfterCall) then
      TLVCompareEvent(AfterCall)(Sender,Item1,Item2,Data,Compare);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVDrawItemEvent(Sender: TCustomListView; Item: TListItem; Rect: TRect; State: TOwnerDrawState);
var
  vState: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVDrawItemEvent(BeforeCall)(Sender, Item, Rect, State);
    if Assigned(Scripter) and (RoutineName > '') then
    begin
      vState := IntFromSet(State, SizeOf(State));
      Scripter.ExecuteSubroutine(RoutineName, [Sender, Item, TRectWrapper.Create(Rect), vState]);
    end;
    if AssignedMethod(AfterCall) then
      TLVDrawItemEvent(AfterCall)(Sender, Item, Rect, State);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVNotifyEvent( Sender: TObject;  Item: TListItem);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVNotifyEvent(BeforeCall)(Sender,Item);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item]);
    if AssignedMethod(AfterCall) then
      TLVNotifyEvent(AfterCall)(Sender,Item);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVSelectItemEvent( Sender: TObject;  Item: TListItem;  Selected: Boolean);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVSelectItemEvent(BeforeCall)(Sender,Item,Selected);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item,Selected]);
    if AssignedMethod(AfterCall) then
      TLVSelectItemEvent(AfterCall)(Sender,Item,Selected);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVCheckedItemEvent( Sender: TObject;  Item: TListItem);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVCheckedItemEvent(BeforeCall)(Sender,Item);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item]);
    if AssignedMethod(AfterCall) then
      TLVCheckedItemEvent(AfterCall)(Sender,Item);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVCustomDrawItemEvent( Sender: TCustomListView;  Item: TListItem;  State: TCustomDrawState; var DefaultDraw: Boolean);
var
  StateTempSet: TCustomDrawState;
  StateTemp: variant;
  DefaultDrawTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVCustomDrawItemEvent(BeforeCall)(Sender,Item,State,DefaultDraw);
    StateTempSet := State;
    StateTemp := IntFromSet(StateTempSet, SizeOf(StateTempSet));
    DefaultDrawTemp := DefaultDraw;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item,StateTemp,DefaultDrawTemp]);
    DefaultDraw := DefaultDrawTemp;
    if AssignedMethod(AfterCall) then
      TLVCustomDrawItemEvent(AfterCall)(Sender,Item,State,DefaultDraw);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVCustomDrawSubItemEvent( Sender: TCustomListView;  Item: TListItem;  SubItem: Integer;  State: TCustomDrawState; var DefaultDraw: Boolean);
var
  StateTempSet: TCustomDrawState;
  StateTemp: variant;
  DefaultDrawTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVCustomDrawSubItemEvent(BeforeCall)(Sender,Item,SubItem,State,DefaultDraw);
    StateTempSet := State;
    StateTemp := IntFromSet(StateTempSet, SizeOf(StateTempSet));
    DefaultDrawTemp := DefaultDraw;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item,SubItem,StateTemp,DefaultDrawTemp]);
    DefaultDraw := DefaultDrawTemp;
    if AssignedMethod(AfterCall) then
      TLVCustomDrawSubItemEvent(AfterCall)(Sender,Item,SubItem,State,DefaultDraw);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVAdvancedCustomDrawItemEvent( Sender: TCustomListView;  Item: TListItem;  State: TCustomDrawState;  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  StateTempSet: TCustomDrawState;
  StateTemp: variant;
  StageTemp: variant;
  DefaultDrawTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVAdvancedCustomDrawItemEvent(BeforeCall)(Sender,Item,State,Stage,DefaultDraw);
    StateTempSet := State;
    StateTemp := IntFromSet(StateTempSet, SizeOf(StateTempSet));
    StageTemp := Stage;
    DefaultDrawTemp := DefaultDraw;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item,StateTemp,StageTemp,DefaultDrawTemp]);
    DefaultDraw := DefaultDrawTemp;
    if AssignedMethod(AfterCall) then
      TLVAdvancedCustomDrawItemEvent(AfterCall)(Sender,Item,State,Stage,DefaultDraw);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVAdvancedCustomDrawSubItemEvent( Sender: TCustomListView;  Item: TListItem;  SubItem: Integer;  State: TCustomDrawState;  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  StateTempSet: TCustomDrawState;
  StateTemp: variant;
  StageTemp: variant;
  DefaultDrawTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVAdvancedCustomDrawSubItemEvent(BeforeCall)(Sender,Item,SubItem,State,Stage,DefaultDraw);
    StateTempSet := State;
    StateTemp := IntFromSet(StateTempSet, SizeOf(StateTempSet));
    StageTemp := Stage;
    DefaultDrawTemp := DefaultDraw;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item,SubItem,StateTemp,StageTemp,DefaultDrawTemp]);
    DefaultDraw := DefaultDrawTemp;
    if AssignedMethod(AfterCall) then
      TLVAdvancedCustomDrawSubItemEvent(AfterCall)(Sender,Item,SubItem,State,Stage,DefaultDraw);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVOwnerDataEvent( Sender: TObject;  Item: TListItem);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVOwnerDataEvent(BeforeCall)(Sender,Item);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item]);
    if AssignedMethod(AfterCall) then
      TLVOwnerDataEvent(AfterCall)(Sender,Item);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVOwnerDataHintEvent( Sender: TObject;  StartIndex: Integer;  EndIndex: Integer);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVOwnerDataHintEvent(BeforeCall)(Sender,StartIndex,EndIndex);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,StartIndex,EndIndex]);
    if AssignedMethod(AfterCall) then
      TLVOwnerDataHintEvent(AfterCall)(Sender,StartIndex,EndIndex);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVOwnerDataStateChangeEvent( Sender: TObject;  StartIndex: Integer;  EndIndex: Integer;  OldState: TItemStates;  NewState: TItemStates);
var
  OldStateTempSet: TItemStates;
  OldStateTemp: variant;
  NewStateTempSet: TItemStates;
  NewStateTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVOwnerDataStateChangeEvent(BeforeCall)(Sender,StartIndex,EndIndex,OldState,NewState);
    OldStateTempSet := OldState;
    OldStateTemp := IntFromSet(OldStateTempSet, SizeOf(OldStateTempSet));
    NewStateTempSet := NewState;
    NewStateTemp := IntFromSet(NewStateTempSet, SizeOf(NewStateTempSet));
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,StartIndex,EndIndex,OldStateTemp,NewStateTemp]);
    if AssignedMethod(AfterCall) then
      TLVOwnerDataStateChangeEvent(AfterCall)(Sender,StartIndex,EndIndex,OldState,NewState);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVSubItemImageEvent( Sender: TObject;  Item: TListItem;  SubItem: Integer; var ImageIndex: Integer);
var
  ImageIndexTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVSubItemImageEvent(BeforeCall)(Sender,Item,SubItem,ImageIndex);
    ImageIndexTemp := Integer(ImageIndex);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item,SubItem,ImageIndexTemp]);
    ImageIndex := VarToInteger(ImageIndexTemp);
    if AssignedMethod(AfterCall) then
      TLVSubItemImageEvent(AfterCall)(Sender,Item,SubItem,ImageIndex);
  end;
end;

procedure TatComCtrlsDispatcher.__TLVInfoTipEvent( Sender: TObject;  Item: TListItem; var InfoTip: string);
var
  InfoTipTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLVInfoTipEvent(BeforeCall)(Sender,Item,InfoTip);
    InfoTipTemp := InfoTip;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item,InfoTipTemp]);
    InfoTip := InfoTipTemp;
    if AssignedMethod(AfterCall) then
      TLVInfoTipEvent(AfterCall)(Sender,Item,InfoTip);
  end;
end;

procedure TatComCtrlsDispatcher.__TTBCustomDrawBtnEvent( Sender: TToolBar;  Button: TToolButton;  State: TCustomDrawState; var DefaultDraw: Boolean);
var
  StateTempSet: TCustomDrawState;
  StateTemp: variant;
  DefaultDrawTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTBCustomDrawBtnEvent(BeforeCall)(Sender,Button,State,DefaultDraw);
    StateTempSet := State;
    StateTemp := IntFromSet(StateTempSet, SizeOf(StateTempSet));
    DefaultDrawTemp := DefaultDraw;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Button,StateTemp,DefaultDrawTemp]);
    DefaultDraw := DefaultDrawTemp;
    if AssignedMethod(AfterCall) then
      TTBCustomDrawBtnEvent(AfterCall)(Sender,Button,State,DefaultDraw);
  end;
end;

procedure TatComCtrlsDispatcher.__TTBAdvancedCustomDrawBtnEvent( Sender: TToolBar;  Button: TToolButton;  State: TCustomDrawState;  Stage: TCustomDrawStage; var Flags: TTBCustomDrawFlags; var DefaultDraw: Boolean);
var
  StateTempSet: TCustomDrawState;
  StateTemp: variant;
  StageTemp: variant;
  FlagsTempSet: TTBCustomDrawFlags;
  FlagsTemp: variant;
  DefaultDrawTemp: variant;
  FlagsTemp2: TTBCustomDrawFlags;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTBAdvancedCustomDrawBtnEvent(BeforeCall)(Sender,Button,State,Stage,Flags,DefaultDraw);
    StateTempSet := State;
    StateTemp := IntFromSet(StateTempSet, SizeOf(StateTempSet));
    StageTemp := Stage;
    FlagsTempSet := Flags;
    FlagsTemp := IntFromSet(FlagsTempSet, SizeOf(FlagsTempSet));
    DefaultDrawTemp := DefaultDraw;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Button,StateTemp,StageTemp,FlagsTemp,DefaultDrawTemp]);
    IntToSet(FlagsTemp2, VarToInteger(FlagsTemp), SizeOf(FlagsTemp2));
    Flags := FlagsTemp2;
    DefaultDraw := DefaultDrawTemp;
    if AssignedMethod(AfterCall) then
      TTBAdvancedCustomDrawBtnEvent(AfterCall)(Sender,Button,State,Stage,Flags,DefaultDraw);
  end;
end;

procedure TatComCtrlsDispatcher.__TTBCustomizeQueryEvent( Sender: TToolbar;  Index: Integer; var Allow: Boolean);
var
  AllowTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTBCustomizeQueryEvent(BeforeCall)(Sender,Index,Allow);
    AllowTemp := Allow;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Index,AllowTemp]);
    Allow := AllowTemp;
    if AssignedMethod(AfterCall) then
      TTBCustomizeQueryEvent(AfterCall)(Sender,Index,Allow);
  end;
end;

procedure TatComCtrlsDispatcher.__TTBNewButtonEvent( Sender: TToolbar;  Index: Integer; var Button: TToolButton);
var
  ButtonTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTBNewButtonEvent(BeforeCall)(Sender,Index,Button);
    ButtonTemp := Integer(Button);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Index,ButtonTemp]);
    Button := TToolButton(Integer(ButtonTemp));
    if AssignedMethod(AfterCall) then
      TTBNewButtonEvent(AfterCall)(Sender,Index,Button);
  end;
end;

procedure TatComCtrlsDispatcher.__TTBButtonEvent( Sender: TToolbar;  Button: TToolButton);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTBButtonEvent(BeforeCall)(Sender,Button);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Button]);
    if AssignedMethod(AfterCall) then
      TTBButtonEvent(AfterCall)(Sender,Button);
  end;
end;

procedure TatComCtrlsDispatcher.__TOnGetMonthInfoEvent( Sender: TObject;  Month: LongWord; var MonthBoldInfo: LongWord);
var
  MonthBoldInfoTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TOnGetMonthInfoEvent(BeforeCall)(Sender,Month,MonthBoldInfo);
    MonthBoldInfoTemp := Integer(MonthBoldInfo);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Month,MonthBoldInfoTemp]);
    MonthBoldInfo := VarToInteger(MonthBoldInfoTemp);
    if AssignedMethod(AfterCall) then
      TOnGetMonthInfoEvent(AfterCall)(Sender,Month,MonthBoldInfo);
  end;
end;

procedure TatComCtrlsDispatcher.__TOnGetMonthBoldInfoEvent( Sender: TObject;  Month: LongWord;  Year: LongWord; var MonthBoldInfo: LongWord);
var
  MonthBoldInfoTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TOnGetMonthBoldInfoEvent(BeforeCall)(Sender,Month,Year,MonthBoldInfo);
    MonthBoldInfoTemp := Integer(MonthBoldInfo);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Month,Year,MonthBoldInfoTemp]);
    MonthBoldInfo := VarToInteger(MonthBoldInfoTemp);
    if AssignedMethod(AfterCall) then
      TOnGetMonthBoldInfoEvent(AfterCall)(Sender,Month,Year,MonthBoldInfo);
  end;
end;

procedure TatComCtrlsDispatcher.__TDTParseInputEvent( Sender: TObject; const UserString: string; var DateAndTime: TDateTime; var AllowChange: Boolean);
var
  DateAndTimeTemp: variant;
  AllowChangeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDTParseInputEvent(BeforeCall)(Sender,UserString,DateAndTime,AllowChange);
    DateAndTimeTemp := DateAndTime;
    AllowChangeTemp := AllowChange;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,UserString,DateAndTimeTemp,AllowChangeTemp]);
    DateAndTime := DateAndTimeTemp;
    AllowChange := AllowChangeTemp;
    if AssignedMethod(AfterCall) then
      TDTParseInputEvent(AfterCall)(Sender,UserString,DateAndTime,AllowChange);
  end;
end;

procedure TatComCtrlsDispatcher.__TPageScrollEvent( Sender: TObject;  Shift: TShiftState;  X: Integer;  Y: Integer;  Orientation: TPageScrollerOrientation; var Delta: Integer);
var
  ShiftTempSet: TShiftState;
  ShiftTemp: variant;
  OrientationTemp: variant;
  DeltaTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TPageScrollEvent(BeforeCall)(Sender,Shift,X,Y,Orientation,Delta);
    ShiftTempSet := Shift;
    ShiftTemp := IntFromSet(ShiftTempSet, SizeOf(ShiftTempSet));
    OrientationTemp := Orientation;
    DeltaTemp := Integer(Delta);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ShiftTemp,X,Y,OrientationTemp,DeltaTemp]);
    Delta := VarToInteger(DeltaTemp);
    if AssignedMethod(AfterCall) then
      TPageScrollEvent(AfterCall)(Sender,Shift,X,Y,Orientation,Delta);
  end;
end;

procedure TatComCtrlsLibrary.__InitCommonControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ComCtrls.InitCommonControl(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__CheckCommonControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ComCtrls.CheckCommonControl(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatComCtrlsLibrary.__GetComCtlVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ComCtrls.GetComCtlVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComCtrlsLibrary.__CheckToolMenuDropdown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ComCtrls.CheckToolMenuDropdown(TToolButton(Integer(GetInputArg(0))));
  end;
end;

procedure TatComCtrlsLibrary.Init;
begin
  With Scripter.DefineClass(TCustomTabControl) do
  begin
    DefineMethod('Create',1,tkClass,TCustomTabControl,__TCustomTabControlCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomTabControlDestroy,false,0);
    DefineMethod('IndexOfTabAt',2,tkInteger,nil,__TCustomTabControlIndexOfTabAt,false,0);
    DefineMethod('GetHitTestInfoAt',2,tkInteger,nil,__TCustomTabControlGetHitTestInfoAt,false,0);
    DefineMethod('TabRect',1,tkVariant,nil,__TCustomTabControlTabRect,false,0);
    DefineMethod('RowCount',0,tkInteger,nil,__TCustomTabControlRowCount,false,0);
    DefineMethod('ScrollTabs',1,tkNone,nil,__TCustomTabControlScrollTabs,false,0);
    DefineProp('Canvas',tkClass,__GetTCustomTabControlCanvas,nil,TCanvas,false,0);
    DefineProp('TabStop',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TTabControl) do
  begin
    DefineProp('DisplayRect',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TTabSheet) do
  begin
    DefineMethod('Create',1,tkClass,TTabSheet,__TTabSheetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TTabSheetDestroy,false,0);
    DefineProp('PageControl',tkClass,__GetTTabSheetPageControl,__SetTTabSheetPageControl,TPageControl,false,0);
    DefineProp('TabIndex',tkInteger,__GetTTabSheetTabIndex,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TPageControl) do
  begin
    DefineMethod('Create',1,tkClass,TPageControl,__TPageControlCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TPageControlDestroy,false,0);
    DefineMethod('FindNextPage',3,tkClass,TTabSheet,__TPageControlFindNextPage,false,0);
    DefineMethod('SelectNextPage',2,tkNone,nil,__TPageControlSelectNextPage,false,1);
    DefineProp('ActivePageIndex',tkInteger,__GetTPageControlActivePageIndex,__SetTPageControlActivePageIndex,nil,false,0);
    DefineProp('PageCount',tkInteger,__GetTPageControlPageCount,nil,nil,false,0);
    DefineProp('Pages',tkClass,__GetTPageControlPages,nil,TTabSheet,false,1);
  end;
  With Scripter.DefineClass(TStatusPanel) do
  begin
    DefineMethod('Create',1,tkClass,TStatusPanel,__TStatusPanelCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TStatusPanelAssign,false,0);
    DefineMethod('ParentBiDiModeChanged',0,tkNone,nil,__TStatusPanelParentBiDiModeChanged,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TStatusPanelUseRightToLeftAlignment,false,0);
    DefineMethod('UseRightToLeftReading',0,tkVariant,nil,__TStatusPanelUseRightToLeftReading,false,0);
  end;
  With Scripter.DefineClass(TStatusPanels) do
  begin
    DefineMethod('Create',1,tkClass,TStatusPanels,__TStatusPanelsCreate,true,0);
    DefineMethod('Add',0,tkClass,TStatusPanel,__TStatusPanelsAdd,false,0);
    DefineMethod('AddItem',2,tkClass,TStatusPanel,__TStatusPanelsAddItem,false,0);
    DefineMethod('Insert',1,tkClass,TStatusPanel,__TStatusPanelsInsert,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTStatusPanelsItems,__SetTStatusPanelsItems,TStatusPanel,false,1);
  end;
  With Scripter.DefineClass(TCustomStatusBar) do
  begin
    DefineMethod('Create',1,tkClass,TCustomStatusBar,__TCustomStatusBarCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomStatusBarDestroy,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TCustomStatusBarExecuteAction,false,0);
    DefineMethod('FlipChildren',1,tkNone,nil,__TCustomStatusBarFlipChildren,false,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TCustomStatusBarSetBounds,false,0);
    DefineProp('Canvas',tkClass,__GetTCustomStatusBarCanvas,nil,TCanvas,false,0);
    DefineProp('AutoHint',tkVariant,__GetTCustomStatusBarAutoHint,__SetTCustomStatusBarAutoHint,nil,false,0);
    DefineProp('Panels',tkClass,__GetTCustomStatusBarPanels,__SetTCustomStatusBarPanels,TStatusPanels,false,0);
    DefineProp('SimplePanel',tkVariant,__GetTCustomStatusBarSimplePanel,__SetTCustomStatusBarSimplePanel,nil,false,0);
    DefineProp('SimpleText',tkVariant,__GetTCustomStatusBarSimpleText,__SetTCustomStatusBarSimpleText,nil,false,0);
    DefineProp('SizeGrip',tkVariant,__GetTCustomStatusBarSizeGrip,__SetTCustomStatusBarSizeGrip,nil,false,0);
    DefineProp('UseSystemFont',tkVariant,__GetTCustomStatusBarUseSystemFont,__SetTCustomStatusBarUseSystemFont,nil,false,0);
  end;
  With Scripter.DefineClass(TStatusBar) do
  begin
  end;
  With Scripter.DefineClass(THeaderSection) do
  begin
    DefineMethod('Create',1,tkClass,THeaderSection,__THeaderSectionCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__THeaderSectionAssign,false,0);
    DefineMethod('ParentBiDiModeChanged',0,tkNone,nil,__THeaderSectionParentBiDiModeChanged,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__THeaderSectionUseRightToLeftAlignment,false,0);
    DefineMethod('UseRightToLeftReading',0,tkVariant,nil,__THeaderSectionUseRightToLeftReading,false,0);
    DefineProp('Left',tkInteger,__GetTHeaderSectionLeft,nil,nil,false,0);
    DefineProp('Right',tkInteger,__GetTHeaderSectionRight,nil,nil,false,0);
  end;
  With Scripter.DefineClass(THeaderSections) do
  begin
    DefineMethod('Create',1,tkClass,THeaderSections,__THeaderSectionsCreate,true,0);
    DefineMethod('Add',0,tkClass,THeaderSection,__THeaderSectionsAdd,false,0);
    DefineMethod('AddItem',2,tkClass,THeaderSection,__THeaderSectionsAddItem,false,0);
    DefineMethod('Insert',1,tkClass,THeaderSection,__THeaderSectionsInsert,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTHeaderSectionsItems,__SetTHeaderSectionsItems,THeaderSection,false,1);
  end;
  With Scripter.DefineClass(TCustomHeaderControl) do
  begin
    DefineMethod('Create',1,tkClass,TCustomHeaderControl,__TCustomHeaderControlCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomHeaderControlDestroy,false,0);
    DefineMethod('FlipChildren',1,tkNone,nil,__TCustomHeaderControlFlipChildren,false,0);
    DefineProp('Canvas',tkClass,__GetTCustomHeaderControlCanvas,nil,TCanvas,false,0);
  end;
  With Scripter.DefineClass(THeaderControl) do
  begin
  end;
  With Scripter.DefineClass(TTreeNode) do
  begin
    DefineMethod('Create',1,tkClass,TTreeNode,__TTreeNodeCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TTreeNodeDestroy,false,0);
    DefineMethod('AlphaSort',1,tkVariant,nil,__TTreeNodeAlphaSort,false,1);
    DefineMethod('Assign',1,tkNone,nil,__TTreeNodeAssign,false,0);
    DefineMethod('Collapse',1,tkNone,nil,__TTreeNodeCollapse,false,0);
    DefineMethod('Delete',0,tkNone,nil,__TTreeNodeDelete,false,0);
    DefineMethod('DeleteChildren',0,tkNone,nil,__TTreeNodeDeleteChildren,false,0);
    DefineMethod('DisplayRect',1,tkVariant,nil,__TTreeNodeDisplayRect,false,0);
    DefineMethod('EditText',0,tkVariant,nil,__TTreeNodeEditText,false,0);
    DefineMethod('EndEdit',1,tkNone,nil,__TTreeNodeEndEdit,false,0);
    DefineMethod('Expand',1,tkNone,nil,__TTreeNodeExpand,false,0);
    DefineMethod('getFirstChild',0,tkClass,TTreeNode,__TTreeNodegetFirstChild,false,0);
    DefineMethod('GetHandle',0,tkInteger,nil,__TTreeNodeGetHandle,false,0);
    DefineMethod('GetLastChild',0,tkClass,TTreeNode,__TTreeNodeGetLastChild,false,0);
    DefineMethod('GetNext',0,tkClass,TTreeNode,__TTreeNodeGetNext,false,0);
    DefineMethod('GetNextChild',1,tkClass,TTreeNode,__TTreeNodeGetNextChild,false,0);
    DefineMethod('getNextSibling',0,tkClass,TTreeNode,__TTreeNodegetNextSibling,false,0);
    DefineMethod('GetNextVisible',0,tkClass,TTreeNode,__TTreeNodeGetNextVisible,false,0);
    DefineMethod('GetPrev',0,tkClass,TTreeNode,__TTreeNodeGetPrev,false,0);
    DefineMethod('GetPrevChild',1,tkClass,TTreeNode,__TTreeNodeGetPrevChild,false,0);
    DefineMethod('getPrevSibling',0,tkClass,TTreeNode,__TTreeNodegetPrevSibling,false,0);
    DefineMethod('GetPrevVisible',0,tkClass,TTreeNode,__TTreeNodeGetPrevVisible,false,0);
    DefineMethod('HasAsParent',1,tkVariant,nil,__TTreeNodeHasAsParent,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TTreeNodeIndexOf,false,0);
    DefineMethod('MakeVisible',0,tkNone,nil,__TTreeNodeMakeVisible,false,0);
    DefineMethod('MoveTo',2,tkNone,nil,__TTreeNodeMoveTo,false,0);
    DefineMethod('IsFirstNode',0,tkVariant,nil,__TTreeNodeIsFirstNode,false,0);
    DefineProp('AbsoluteIndex',tkInteger,__GetTTreeNodeAbsoluteIndex,nil,nil,false,0);
    DefineProp('Count',tkInteger,__GetTTreeNodeCount,nil,nil,false,0);
    DefineProp('Cut',tkVariant,__GetTTreeNodeCut,__SetTTreeNodeCut,nil,false,0);
    DefineProp('Deleting',tkVariant,__GetTTreeNodeDeleting,nil,nil,false,0);
    DefineProp('Focused',tkVariant,__GetTTreeNodeFocused,__SetTTreeNodeFocused,nil,false,0);
    DefineProp('DropTarget',tkVariant,__GetTTreeNodeDropTarget,__SetTTreeNodeDropTarget,nil,false,0);
    DefineProp('Selected',tkVariant,__GetTTreeNodeSelected,__SetTTreeNodeSelected,nil,false,0);
    DefineProp('Expanded',tkVariant,__GetTTreeNodeExpanded,__SetTTreeNodeExpanded,nil,false,0);
    DefineProp('ExpandedImageIndex',tkInteger,__GetTTreeNodeExpandedImageIndex,__SetTTreeNodeExpandedImageIndex,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTTreeNodeHandle,nil,nil,false,0);
    DefineProp('HasChildren',tkVariant,__GetTTreeNodeHasChildren,__SetTTreeNodeHasChildren,nil,false,0);
    DefineProp('ImageIndex',tkInteger,__GetTTreeNodeImageIndex,__SetTTreeNodeImageIndex,nil,false,0);
    DefineProp('Index',tkInteger,__GetTTreeNodeIndex,nil,nil,false,0);
    DefineProp('IsVisible',tkVariant,__GetTTreeNodeIsVisible,nil,nil,false,0);
    DefaultProperty := DefineProp('Item',tkClass,__GetTTreeNodeItem,__SetTTreeNodeItem,TTreeNode,false,1);
    DefineProp('Level',tkInteger,__GetTTreeNodeLevel,nil,nil,false,0);
    DefineProp('OverlayIndex',tkInteger,__GetTTreeNodeOverlayIndex,__SetTTreeNodeOverlayIndex,nil,false,0);
    DefineProp('Owner',tkClass,__GetTTreeNodeOwner,nil,TTreeNodes,false,0);
    DefineProp('Parent',tkClass,__GetTTreeNodeParent,nil,TTreeNode,false,0);
    DefineProp('SelectedIndex',tkInteger,__GetTTreeNodeSelectedIndex,__SetTTreeNodeSelectedIndex,nil,false,0);
    DefineProp('Enabled',tkVariant,__GetTTreeNodeEnabled,__SetTTreeNodeEnabled,nil,false,0);
    DefineProp('StateIndex',tkInteger,__GetTTreeNodeStateIndex,__SetTTreeNodeStateIndex,nil,false,0);
    DefineProp('Text',tkVariant,__GetTTreeNodeText,__SetTTreeNodeText,nil,false,0);
    DefineProp('TreeView',tkClass,__GetTTreeNodeTreeView,nil,TCustomTreeView,false,0);
  end;
  With Scripter.DefineClass(TTreeNodesEnumerator) do
  begin
    DefineMethod('Create',1,tkClass,TTreeNodesEnumerator,__TTreeNodesEnumeratorCreate,true,0);
    DefineMethod('GetCurrent',0,tkClass,TTreeNode,__TTreeNodesEnumeratorGetCurrent,false,0);
    DefineMethod('MoveNext',0,tkVariant,nil,__TTreeNodesEnumeratorMoveNext,false,0);
    DefineProp('Current',tkClass,__GetTTreeNodesEnumeratorCurrent,nil,TTreeNode,false,0);
  end;
  With Scripter.DefineClass(TTreeNodes) do
  begin
    DefineMethod('Create',1,tkClass,TTreeNodes,__TTreeNodesCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TTreeNodesDestroy,false,0);
    DefineMethod('AddChildFirst',2,tkClass,TTreeNode,__TTreeNodesAddChildFirst,false,0);
    DefineMethod('AddChild',2,tkClass,TTreeNode,__TTreeNodesAddChild,false,0);
    DefineMethod('AddFirst',2,tkClass,TTreeNode,__TTreeNodesAddFirst,false,0);
    DefineMethod('Add',2,tkClass,TTreeNode,__TTreeNodesAdd,false,0);
    DefineMethod('AlphaSort',1,tkVariant,nil,__TTreeNodesAlphaSort,false,1);
    DefineMethod('Assign',1,tkNone,nil,__TTreeNodesAssign,false,0);
    DefineMethod('BeginUpdate',0,tkNone,nil,__TTreeNodesBeginUpdate,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TTreeNodesClear,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TTreeNodesDelete,false,0);
    DefineMethod('EndUpdate',0,tkNone,nil,__TTreeNodesEndUpdate,false,0);
    DefineMethod('GetFirstNode',0,tkClass,TTreeNode,__TTreeNodesGetFirstNode,false,0);
    DefineMethod('GetEnumerator',0,tkClass,TTreeNodesEnumerator,__TTreeNodesGetEnumerator,false,0);
    DefineMethod('Insert',2,tkClass,TTreeNode,__TTreeNodesInsert,false,0);
    DefineProp('Count',tkInteger,__GetTTreeNodesCount,nil,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTTreeNodesHandle,nil,nil,false,0);
    DefaultProperty := DefineProp('Item',tkClass,__GetTTreeNodesItem,nil,TTreeNode,false,1);
    DefineProp('Owner',tkClass,__GetTTreeNodesOwner,nil,TCustomTreeView,false,0);
  end;
  With Scripter.DefineClass(ETreeViewError) do
  begin
  end;
  With Scripter.DefineClass(TCustomTreeView) do
  begin
    DefineMethod('Create',1,tkClass,TCustomTreeView,__TCustomTreeViewCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomTreeViewDestroy,false,0);
    DefineMethod('AlphaSort',1,tkVariant,nil,__TCustomTreeViewAlphaSort,false,1);
    DefineMethod('FullCollapse',0,tkNone,nil,__TCustomTreeViewFullCollapse,false,0);
    DefineMethod('FullExpand',0,tkNone,nil,__TCustomTreeViewFullExpand,false,0);
    DefineMethod('GetHitTestInfoAt',2,tkInteger,nil,__TCustomTreeViewGetHitTestInfoAt,false,0);
    DefineMethod('GetNodeAt',2,tkClass,TTreeNode,__TCustomTreeViewGetNodeAt,false,0);
    DefineMethod('GetDragImages',0,tkClass,TDragImageList,__TCustomTreeViewGetDragImages,false,0);
    DefineMethod('IsEditing',0,tkVariant,nil,__TCustomTreeViewIsEditing,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TCustomTreeViewLoadFromFile,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TCustomTreeViewLoadFromStream,false,0);
    DefineMethod('SaveToFile',1,tkNone,nil,__TCustomTreeViewSaveToFile,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TCustomTreeViewSaveToStream,false,0);
    DefineMethod('Select',2,tkNone,nil,__TCustomTreeViewSelect,false,1);
    DefineMethod('Deselect',1,tkNone,nil,__TCustomTreeViewDeselect,false,0);
    DefineMethod('Subselect',2,tkNone,nil,__TCustomTreeViewSubselect,false,1);
    DefineMethod('ClearSelection',1,tkNone,nil,__TCustomTreeViewClearSelection,false,1);
    DefineMethod('GetSelections',1,tkClass,TTreeNode,__TCustomTreeViewGetSelections,false,0);
    DefineMethod('FindNextToSelect',0,tkClass,TTreeNode,__TCustomTreeViewFindNextToSelect,false,0);
    DefineProp('Canvas',tkClass,__GetTCustomTreeViewCanvas,nil,TCanvas,false,0);
    DefineProp('DropTarget',tkClass,__GetTCustomTreeViewDropTarget,__SetTCustomTreeViewDropTarget,TTreeNode,false,0);
    DefineProp('Selected',tkClass,__GetTCustomTreeViewSelected,__SetTCustomTreeViewSelected,TTreeNode,false,0);
    DefineProp('TopItem',tkClass,__GetTCustomTreeViewTopItem,__SetTCustomTreeViewTopItem,TTreeNode,false,0);
    DefineProp('SelectionCount',tkInteger,__GetTCustomTreeViewSelectionCount,nil,nil,false,0);
    DefineProp('Selections',tkClass,__GetTCustomTreeViewSelections,nil,TTreeNode,false,1);
  end;
  With Scripter.DefineClass(TTreeView) do
  begin
  end;
  With Scripter.DefineClass(TTrackBar) do
  begin
    DefineMethod('Create',1,tkClass,TTrackBar,__TTrackBarCreate,true,0);
    DefineMethod('SetTick',1,tkNone,nil,__TTrackBarSetTick,false,0);
  end;
  With Scripter.DefineClass(TProgressBar) do
  begin
    DefineMethod('Create',1,tkClass,TProgressBar,__TProgressBarCreate,true,0);
    DefineMethod('StepIt',0,tkNone,nil,__TProgressBarStepIt,false,0);
    DefineMethod('StepBy',1,tkNone,nil,__TProgressBarStepBy,false,0);
  end;
  With Scripter.DefineClass(TTextAttributes) do
  begin
    DefineMethod('Create',2,tkClass,TTextAttributes,__TTextAttributesCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TTextAttributesAssign,false,0);
    DefineProp('Charset',tkEnumeration,__GetTTextAttributesCharset,__SetTTextAttributesCharset,nil,false,0);
    DefineProp('Color',tkEnumeration,__GetTTextAttributesColor,__SetTTextAttributesColor,nil,false,0);
    DefineProp('ConsistentAttributes',tkInteger,__GetTTextAttributesConsistentAttributes,nil,nil,false,0);
    DefineProp('Name',tkVariant,__GetTTextAttributesName,__SetTTextAttributesName,nil,false,0);
    DefineProp('Pitch',tkEnumeration,__GetTTextAttributesPitch,__SetTTextAttributesPitch,nil,false,0);
    DefineProp('Protected',tkVariant,__GetTTextAttributesProtected,__SetTTextAttributesProtected,nil,false,0);
    DefineProp('Size',tkInteger,__GetTTextAttributesSize,__SetTTextAttributesSize,nil,false,0);
    DefineProp('Style',tkInteger,__GetTTextAttributesStyle,__SetTTextAttributesStyle,nil,false,0);
    DefineProp('Height',tkInteger,__GetTTextAttributesHeight,__SetTTextAttributesHeight,nil,false,0);
  end;
  With Scripter.DefineClass(TParaAttributes) do
  begin
    DefineMethod('Create',1,tkClass,TParaAttributes,__TParaAttributesCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TParaAttributesAssign,false,0);
    DefineProp('Alignment',tkEnumeration,__GetTParaAttributesAlignment,__SetTParaAttributesAlignment,nil,false,0);
    DefineProp('FirstIndent',tkInteger,__GetTParaAttributesFirstIndent,__SetTParaAttributesFirstIndent,nil,false,0);
    DefineProp('LeftIndent',tkInteger,__GetTParaAttributesLeftIndent,__SetTParaAttributesLeftIndent,nil,false,0);
    DefineProp('Numbering',tkEnumeration,__GetTParaAttributesNumbering,__SetTParaAttributesNumbering,nil,false,0);
    DefineProp('RightIndent',tkInteger,__GetTParaAttributesRightIndent,__SetTParaAttributesRightIndent,nil,false,0);
    DefineProp('Tab',tkInteger,__GetTParaAttributesTab,__SetTParaAttributesTab,nil,false,1);
    DefineProp('TabCount',tkInteger,__GetTParaAttributesTabCount,__SetTParaAttributesTabCount,nil,false,0);
  end;
  With Scripter.DefineClass(TConversion) do
  begin
    DefineMethod('Create',0,tkClass,TConversion,__TConversionCreate,true,0);
    DefineMethod('ConvertReadStream',3,tkInteger,nil,__TConversionConvertReadStream,false,0);
    DefineMethod('ConvertWriteStream',3,tkInteger,nil,__TConversionConvertWriteStream,false,0);
  end;
  With Scripter.DefineClass(TCustomRichEdit) do
  begin
    DefineMethod('Create',1,tkClass,TCustomRichEdit,__TCustomRichEditCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomRichEditDestroy,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TCustomRichEditClear,false,0);
    DefineMethod('FindText',4,tkInteger,nil,__TCustomRichEditFindText,false,0);
    DefineMethod('Print',1,tkNone,nil,__TCustomRichEditPrint,false,0);
    DefineMethod('GetSelTextBuf',2,tkInteger,nil,__TCustomRichEditGetSelTextBuf,false,0);
    DefineProp('ActiveLineNo',tkInteger,__GetTCustomRichEditActiveLineNo,nil,nil,false,0);
    DefineProp('DefAttributes',tkClass,__GetTCustomRichEditDefAttributes,__SetTCustomRichEditDefAttributes,TTextAttributes,false,0);
    DefineProp('SelAttributes',tkClass,__GetTCustomRichEditSelAttributes,__SetTCustomRichEditSelAttributes,TTextAttributes,false,0);
    DefineProp('PageRect',tkVariant,__GetTCustomRichEditPageRect,__SetTCustomRichEditPageRect,nil,false,0);
    DefineProp('Paragraph',tkClass,__GetTCustomRichEditParagraph,nil,TParaAttributes,false,0);
  end;
  With Scripter.DefineClass(TRichEdit) do
  begin
  end;
  With Scripter.DefineClass(TCustomUpDown) do
  begin
    DefineMethod('Create',1,tkClass,TCustomUpDown,__TCustomUpDownCreate,true,0);
  end;
  With Scripter.DefineClass(TUpDown) do
  begin
  end;
  With Scripter.DefineClass(TCustomHotKey) do
  begin
    DefineMethod('Create',1,tkClass,TCustomHotKey,__TCustomHotKeyCreate,true,0);
  end;
  With Scripter.DefineClass(THotKey) do
  begin
  end;
  With Scripter.DefineClass(TListGroup) do
  begin
    DefineMethod('Create',1,tkClass,TListGroup,__TListGroupCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TListGroupDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TListGroupAssign,false,0);
  end;
  With Scripter.DefineClass(TListGroups) do
  begin
    DefineMethod('Create',1,tkClass,TListGroups,__TListGroupsCreate,true,0);
    DefineMethod('Add',0,tkClass,TListGroup,__TListGroupsAdd,false,0);
    DefineMethod('Owner',0,tkClass,TCustomListView,__TListGroupsOwner,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTListGroupsItems,__SetTListGroupsItems,TListGroup,false,1);
    DefineProp('NextGroupID',tkInteger,__GetTListGroupsNextGroupID,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TListColumn) do
  begin
    DefineMethod('Create',1,tkClass,TListColumn,__TListColumnCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TListColumnDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TListColumnAssign,false,0);
    DefineProp('WidthType',tkEnumeration,__GetTListColumnWidthType,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TListColumns) do
  begin
    DefineMethod('Create',1,tkClass,TListColumns,__TListColumnsCreate,true,0);
    DefineMethod('Add',0,tkClass,TListColumn,__TListColumnsAdd,false,0);
    DefineMethod('Owner',0,tkClass,TCustomListView,__TListColumnsOwner,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTListColumnsItems,__SetTListColumnsItems,TListColumn,false,1);
  end;
  With Scripter.DefineClass(TListItem) do
  begin
    DefineMethod('Create',1,tkClass,TListItem,__TListItemCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TListItemDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TListItemAssign,false,0);
    DefineMethod('CancelEdit',0,tkNone,nil,__TListItemCancelEdit,false,0);
    DefineMethod('Delete',0,tkNone,nil,__TListItemDelete,false,0);
    DefineMethod('DisplayRect',1,tkVariant,nil,__TListItemDisplayRect,false,0);
    DefineMethod('EditCaption',0,tkVariant,nil,__TListItemEditCaption,false,0);
    DefineMethod('GetPosition',0,tkVariant,nil,__TListItemGetPosition,false,0);
    DefineMethod('MakeVisible',1,tkNone,nil,__TListItemMakeVisible,false,0);
    DefineMethod('Update',0,tkNone,nil,__TListItemUpdate,false,0);
    DefineMethod('SetPosition',1,tkNone,nil,__TListItemSetPosition,false,0);
    DefineMethod('WorkArea',0,tkInteger,nil,__TListItemWorkArea,false,0);
    DefineProp('Caption',tkVariant,__GetTListItemCaption,__SetTListItemCaption,nil,false,0);
    DefineProp('Checked',tkVariant,__GetTListItemChecked,__SetTListItemChecked,nil,false,0);
    DefineProp('Cut',tkVariant,__GetTListItemCut,__SetTListItemCut,nil,false,0);
    DefineProp('Deleting',tkVariant,__GetTListItemDeleting,nil,nil,false,0);
    DefineProp('DropTarget',tkVariant,__GetTListItemDropTarget,__SetTListItemDropTarget,nil,false,0);
    DefineProp('Focused',tkVariant,__GetTListItemFocused,__SetTListItemFocused,nil,false,0);
    DefineProp('GroupID',tkInteger,__GetTListItemGroupID,__SetTListItemGroupID,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTListItemHandle,nil,nil,false,0);
    DefineProp('ImageIndex',tkInteger,__GetTListItemImageIndex,__SetTListItemImageIndex,nil,false,0);
    DefineProp('Indent',tkInteger,__GetTListItemIndent,__SetTListItemIndent,nil,false,0);
    DefineProp('Index',tkInteger,__GetTListItemIndex,nil,nil,false,0);
    DefineProp('Left',tkInteger,__GetTListItemLeft,__SetTListItemLeft,nil,false,0);
    DefineProp('ListView',tkClass,__GetTListItemListView,nil,TCustomListView,false,0);
    DefineProp('Owner',tkClass,__GetTListItemOwner,nil,TListItems,false,0);
    DefineProp('OverlayIndex',tkInteger,__GetTListItemOverlayIndex,__SetTListItemOverlayIndex,nil,false,0);
    DefineProp('Position',tkVariant,__GetTListItemPosition,__SetTListItemPosition,nil,false,0);
    DefineProp('Selected',tkVariant,__GetTListItemSelected,__SetTListItemSelected,nil,false,0);
    DefineProp('StateIndex',tkInteger,__GetTListItemStateIndex,__SetTListItemStateIndex,nil,false,0);
    DefineProp('SubItems',tkClass,__GetTListItemSubItems,__SetTListItemSubItems,TStrings,false,0);
    DefineProp('SubItemImages',tkInteger,__GetTListItemSubItemImages,__SetTListItemSubItemImages,nil,false,1);
    DefineProp('Top',tkInteger,__GetTListItemTop,__SetTListItemTop,nil,false,0);
  end;
  With Scripter.DefineClass(TListItemsEnumerator) do
  begin
    DefineMethod('Create',1,tkClass,TListItemsEnumerator,__TListItemsEnumeratorCreate,true,0);
    DefineMethod('GetCurrent',0,tkClass,TListItem,__TListItemsEnumeratorGetCurrent,false,0);
    DefineMethod('MoveNext',0,tkVariant,nil,__TListItemsEnumeratorMoveNext,false,0);
    DefineProp('Current',tkClass,__GetTListItemsEnumeratorCurrent,nil,TListItem,false,0);
  end;
  With Scripter.DefineClass(TListItems) do
  begin
    DefineMethod('Create',1,tkClass,TListItems,__TListItemsCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TListItemsDestroy,false,0);
    DefineMethod('Add',0,tkClass,TListItem,__TListItemsAdd,false,0);
    DefineMethod('AddItem',2,tkClass,TListItem,__TListItemsAddItem,false,1);
    DefineMethod('Assign',1,tkNone,nil,__TListItemsAssign,false,0);
    DefineMethod('BeginUpdate',0,tkNone,nil,__TListItemsBeginUpdate,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TListItemsClear,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TListItemsDelete,false,0);
    DefineMethod('EndUpdate',0,tkNone,nil,__TListItemsEndUpdate,false,0);
    DefineMethod('GetEnumerator',0,tkClass,TListItemsEnumerator,__TListItemsGetEnumerator,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TListItemsIndexOf,false,0);
    DefineMethod('Insert',1,tkClass,TListItem,__TListItemsInsert,false,0);
    DefineProp('Count',tkInteger,__GetTListItemsCount,__SetTListItemsCount,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTListItemsHandle,nil,nil,false,0);
    DefaultProperty := DefineProp('Item',tkClass,__GetTListItemsItem,__SetTListItemsItem,TListItem,false,1);
    DefineProp('Owner',tkClass,__GetTListItemsOwner,nil,TCustomListView,false,0);
  end;
  With Scripter.DefineClass(TWorkArea) do
  begin
    DefineMethod('Create',1,tkClass,TWorkArea,__TWorkAreaCreate,true,0);
    DefineMethod('SetDisplayName',1,tkNone,nil,__TWorkAreaSetDisplayName,false,0);
    DefineMethod('GetDisplayName',0,tkVariant,nil,__TWorkAreaGetDisplayName,false,0);
    DefineProp('Rect',tkVariant,__GetTWorkAreaRect,__SetTWorkAreaRect,nil,false,0);
    DefineProp('Color',tkEnumeration,__GetTWorkAreaColor,__SetTWorkAreaColor,nil,false,0);
  end;
  With Scripter.DefineClass(TWorkAreas) do
  begin
    DefineMethod('Add',0,tkClass,TWorkArea,__TWorkAreasAdd,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TWorkAreasDelete,false,0);
    DefineMethod('Insert',1,tkClass,TWorkArea,__TWorkAreasInsert,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTWorkAreasItems,__SetTWorkAreasItems,TWorkArea,false,1);
  end;
  With Scripter.DefineClass(TIconOptions) do
  begin
    DefineMethod('Create',1,tkClass,TIconOptions,__TIconOptionsCreate,true,0);
  end;
  With Scripter.DefineClass(TCustomListView) do
  begin
    DefineMethod('Create',1,tkClass,TCustomListView,__TCustomListViewCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomListViewDestroy,false,0);
    DefineMethod('AddItem',2,tkNone,nil,__TCustomListViewAddItem,false,0);
    DefineMethod('AlphaSort',0,tkVariant,nil,__TCustomListViewAlphaSort,false,0);
    DefineMethod('Arrange',1,tkNone,nil,__TCustomListViewArrange,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TCustomListViewClear,false,0);
    DefineMethod('ClearSelection',0,tkNone,nil,__TCustomListViewClearSelection,false,0);
    DefineMethod('CopySelection',1,tkNone,nil,__TCustomListViewCopySelection,false,0);
    DefineMethod('DeleteSelected',0,tkNone,nil,__TCustomListViewDeleteSelected,false,0);
    DefineMethod('FindCaption',5,tkClass,TListItem,__TCustomListViewFindCaption,false,0);
    DefineMethod('GetCount',0,tkInteger,nil,__TCustomListViewGetCount,false,0);
    DefineMethod('GetHitTestInfoAt',2,tkInteger,nil,__TCustomListViewGetHitTestInfoAt,false,0);
    DefineMethod('GetItemAt',2,tkClass,TListItem,__TCustomListViewGetItemAt,false,0);
    DefineMethod('GetNearestItem',2,tkClass,TListItem,__TCustomListViewGetNearestItem,false,0);
    DefineMethod('GetNextItem',3,tkClass,TListItem,__TCustomListViewGetNextItem,false,0);
    DefineMethod('GetSearchString',0,tkVariant,nil,__TCustomListViewGetSearchString,false,0);
    DefineMethod('IsEditing',0,tkVariant,nil,__TCustomListViewIsEditing,false,0);
    DefineMethod('SelectAll',0,tkNone,nil,__TCustomListViewSelectAll,false,0);
    DefineMethod('Scroll',2,tkNone,nil,__TCustomListViewScroll,false,0);
    DefineMethod('GetDragImages',0,tkClass,TDragImageList,__TCustomListViewGetDragImages,false,0);
    DefineMethod('StringWidth',1,tkInteger,nil,__TCustomListViewStringWidth,false,0);
    DefineMethod('UpdateItems',2,tkNone,nil,__TCustomListViewUpdateItems,false,0);
    DefineProp('Canvas',tkClass,__GetTCustomListViewCanvas,nil,TCanvas,false,0);
    DefineProp('Checkboxes',tkVariant,__GetTCustomListViewCheckboxes,__SetTCustomListViewCheckboxes,nil,false,0);
    DefineProp('Column',tkClass,__GetTCustomListViewColumn,nil,TListColumn,false,1);
    DefineProp('DropTarget',tkClass,__GetTCustomListViewDropTarget,__SetTCustomListViewDropTarget,TListItem,false,0);
    DefineProp('FlatScrollBars',tkVariant,__GetTCustomListViewFlatScrollBars,__SetTCustomListViewFlatScrollBars,nil,false,0);
    DefineProp('FullDrag',tkVariant,__GetTCustomListViewFullDrag,__SetTCustomListViewFullDrag,nil,false,0);
    DefineProp('GridLines',tkVariant,__GetTCustomListViewGridLines,__SetTCustomListViewGridLines,nil,false,0);
    DefineProp('HotTrack',tkVariant,__GetTCustomListViewHotTrack,__SetTCustomListViewHotTrack,nil,false,0);
    DefineProp('HotTrackStyles',tkInteger,__GetTCustomListViewHotTrackStyles,__SetTCustomListViewHotTrackStyles,nil,false,0);
    DefineProp('ItemFocused',tkClass,__GetTCustomListViewItemFocused,__SetTCustomListViewItemFocused,TListItem,false,0);
    DefineProp('Items',tkClass,__GetTCustomListViewItems,__SetTCustomListViewItems,TListItems,false,0);
    DefineProp('RowSelect',tkVariant,__GetTCustomListViewRowSelect,__SetTCustomListViewRowSelect,nil,false,0);
    DefineProp('SelCount',tkInteger,__GetTCustomListViewSelCount,nil,nil,false,0);
    DefineProp('Selected',tkClass,__GetTCustomListViewSelected,__SetTCustomListViewSelected,TListItem,false,0);
    DefineProp('TopItem',tkClass,__GetTCustomListViewTopItem,nil,TListItem,false,0);
    DefineProp('ViewOrigin',tkVariant,__GetTCustomListViewViewOrigin,nil,nil,false,0);
    DefineProp('VisibleRowCount',tkInteger,__GetTCustomListViewVisibleRowCount,nil,nil,false,0);
    DefineProp('BoundingRect',tkVariant,__GetTCustomListViewBoundingRect,nil,nil,false,0);
    DefineProp('WorkAreas',tkClass,__GetTCustomListViewWorkAreas,nil,TWorkAreas,false,0);
  end;
  With Scripter.DefineClass(TListView) do
  begin
  end;
  With Scripter.DefineClass(TListViewActionLink) do
  begin
  end;
  With Scripter.DefineClass(TAnimate) do
  begin
    DefineMethod('Create',1,tkClass,TAnimate,__TAnimateCreate,true,0);
    DefineMethod('Play',3,tkNone,nil,__TAnimatePlay,false,0);
    DefineMethod('Reset',0,tkNone,nil,__TAnimateReset,false,0);
    DefineMethod('Seek',1,tkNone,nil,__TAnimateSeek,false,0);
    DefineMethod('Stop',0,tkNone,nil,__TAnimateStop,false,0);
    DefineProp('FrameCount',tkInteger,__GetTAnimateFrameCount,nil,nil,false,0);
    DefineProp('FrameHeight',tkInteger,__GetTAnimateFrameHeight,nil,nil,false,0);
    DefineProp('FrameWidth',tkInteger,__GetTAnimateFrameWidth,nil,nil,false,0);
    DefineProp('Open',tkVariant,__GetTAnimateOpen,__SetTAnimateOpen,nil,false,0);
    DefineProp('ResHandle',tkVariant,__GetTAnimateResHandle,__SetTAnimateResHandle,nil,false,0);
    DefineProp('ResId',tkInteger,__GetTAnimateResId,__SetTAnimateResId,nil,false,0);
    DefineProp('ResName',tkVariant,__GetTAnimateResName,__SetTAnimateResName,nil,false,0);
  end;
  With Scripter.DefineClass(TToolButtonActionLink) do
  begin
  end;
  With Scripter.DefineClass(TToolButton) do
  begin
    DefineMethod('Create',1,tkClass,TToolButton,__TToolButtonCreate,true,0);
    DefineMethod('CheckMenuDropdown',0,tkVariant,nil,__TToolButtonCheckMenuDropdown,false,0);
    DefineMethod('Click',0,tkNone,nil,__TToolButtonClick,false,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TToolButtonSetBounds,false,0);
    DefineProp('Index',tkInteger,__GetTToolButtonIndex,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TToolBarEnumerator) do
  begin
    DefineMethod('Create',1,tkClass,TToolBarEnumerator,__TToolBarEnumeratorCreate,true,0);
    DefineMethod('GetCurrent',0,tkClass,TToolButton,__TToolBarEnumeratorGetCurrent,false,0);
    DefineMethod('MoveNext',0,tkVariant,nil,__TToolBarEnumeratorMoveNext,false,0);
    DefineProp('Current',tkClass,__GetTToolBarEnumeratorCurrent,nil,TToolButton,false,0);
  end;
  With Scripter.DefineClass(TToolBar) do
  begin
    DefineMethod('Create',1,tkClass,TToolBar,__TToolBarCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TToolBarDestroy,false,0);
    DefineMethod('FlipChildren',1,tkNone,nil,__TToolBarFlipChildren,false,0);
    DefineMethod('GetEnumerator',0,tkClass,TToolBarEnumerator,__TToolBarGetEnumerator,false,0);
    DefineMethod('TrackMenu',1,tkVariant,nil,__TToolBarTrackMenu,false,0);
    DefineProp('ButtonCount',tkInteger,__GetTToolBarButtonCount,nil,nil,false,0);
    DefineProp('Buttons',tkClass,__GetTToolBarButtons,nil,TToolButton,false,1);
    DefineProp('Canvas',tkClass,__GetTToolBarCanvas,nil,TCanvas,false,0);
    DefineProp('CustomizeKeyName',tkVariant,__GetTToolBarCustomizeKeyName,__SetTToolBarCustomizeKeyName,nil,false,0);
    DefineProp('CustomizeValueName',tkVariant,__GetTToolBarCustomizeValueName,__SetTToolBarCustomizeValueName,nil,false,0);
    DefineProp('RowCount',tkInteger,__GetTToolBarRowCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TToolBarDockObject) do
  begin
  end;
  With Scripter.DefineClass(TCoolBand) do
  begin
    DefineMethod('Create',1,tkClass,TCoolBand,__TCoolBandCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCoolBandDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TCoolBandAssign,false,0);
    DefineProp('Height',tkInteger,__GetTCoolBandHeight,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCoolBands) do
  begin
    DefineMethod('Create',1,tkClass,TCoolBands,__TCoolBandsCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCoolBandsDestroy,false,0);
    DefineMethod('Add',0,tkClass,TCoolBand,__TCoolBandsAdd,false,0);
    DefineMethod('FindBand',1,tkClass,TCoolBand,__TCoolBandsFindBand,false,0);
    DefineProp('CoolBar',tkClass,__GetTCoolBandsCoolBar,nil,TCoolBar,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTCoolBandsItems,__SetTCoolBandsItems,TCoolBand,false,1);
  end;
  With Scripter.DefineClass(TCoolBar) do
  begin
    DefineMethod('Create',1,tkClass,TCoolBar,__TCoolBarCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCoolBarDestroy,false,0);
    DefineMethod('FlipChildren',1,tkNone,nil,__TCoolBarFlipChildren,false,0);
  end;
  With Scripter.DefineClass(ECommonCalendarError) do
  begin
  end;
  With Scripter.DefineClass(TMonthCalColors) do
  begin
    DefineMethod('Create',1,tkClass,TMonthCalColors,__TMonthCalColorsCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TMonthCalColorsAssign,false,0);
  end;
  With Scripter.DefineClass(TCommonCalendar) do
  begin
    DefineMethod('Create',1,tkClass,TCommonCalendar,__TCommonCalendarCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCommonCalendarDestroy,false,0);
  end;
  With Scripter.DefineClass(EMonthCalError) do
  begin
  end;
  With Scripter.DefineClass(TMonthCalendar) do
  begin
    DefineMethod('Create',1,tkClass,TMonthCalendar,__TMonthCalendarCreate,true,0);
  end;
  With Scripter.DefineClass(EDateTimeError) do
  begin
  end;
  With Scripter.DefineClass(TDateTimeColors) do
  begin
  end;
  With Scripter.DefineClass(TDateTimePicker) do
  begin
    DefineMethod('Create',1,tkClass,TDateTimePicker,__TDateTimePickerCreate,true,0);
    DefineProp('DateTime',tkVariant,nil,nil,nil,false,0);
    DefineProp('DroppedDown',tkVariant,__GetTDateTimePickerDroppedDown,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TPageScroller) do
  begin
    DefineMethod('Create',1,tkClass,TPageScroller,__TPageScrollerCreate,true,0);
    DefineMethod('GetButtonState',1,tkEnumeration,nil,__TPageScrollerGetButtonState,false,0);
  end;
  With Scripter.DefineClass(TComboExItem) do
  begin
    DefineMethod('Assign',1,tkNone,nil,__TComboExItemAssign,false,0);
  end;
  With Scripter.DefineClass(TComboExItems) do
  begin
    DefineMethod('Add',0,tkClass,TComboExItem,__TComboExItemsAdd,false,0);
    DefineMethod('Insert',1,tkClass,TComboExItem,__TComboExItemsInsert,false,0);
    DefineProp('ComboItems',tkClass,__GetTComboExItemsComboItems,nil,TComboExItem,false,1);
  end;
  With Scripter.DefineClass(TComboBoxExStrings) do
  begin
    DefineMethod('Create',1,tkClass,TComboBoxExStrings,__TComboBoxExStringsCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TComboBoxExStringsDestroy,false,0);
    DefineMethod('Add',1,tkInteger,nil,__TComboBoxExStringsAdd,false,0);
    DefineMethod('AddObject',2,tkInteger,nil,__TComboBoxExStringsAddObject,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TComboBoxExStringsClear,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TComboBoxExStringsDelete,false,0);
    DefineMethod('Exchange',2,tkNone,nil,__TComboBoxExStringsExchange,false,0);
    DefineMethod('Get',1,tkVariant,nil,__TComboBoxExStringsGet,false,0);
    DefineMethod('GetCapacity',0,tkInteger,nil,__TComboBoxExStringsGetCapacity,false,0);
    DefineMethod('GetCount',0,tkInteger,nil,__TComboBoxExStringsGetCount,false,0);
    DefineMethod('GetObject',1,tkVariant,nil,__TComboBoxExStringsGetObject,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TComboBoxExStringsIndexOf,false,0);
    DefineMethod('IndexOfName',1,tkInteger,nil,__TComboBoxExStringsIndexOfName,false,0);
    DefineMethod('Insert',2,tkNone,nil,__TComboBoxExStringsInsert,false,0);
    DefineMethod('Move',2,tkNone,nil,__TComboBoxExStringsMove,false,0);
    DefineProp('SortType',tkEnumeration,__GetTComboBoxExStringsSortType,__SetTComboBoxExStringsSortType,nil,false,0);
    DefineProp('ItemsEx',tkClass,__GetTComboBoxExStringsItemsEx,__SetTComboBoxExStringsItemsEx,TComboExItems,false,0);
  end;
  With Scripter.DefineClass(TCustomComboBoxEx) do
  begin
    DefineMethod('Create',1,tkClass,TCustomComboBoxEx,__TCustomComboBoxExCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomComboBoxExDestroy,false,0);
    DefineMethod('Focused',0,tkVariant,nil,__TCustomComboBoxExFocused,false,0);
    DefineProp('AutoCompleteOptions',tkInteger,__GetTCustomComboBoxExAutoCompleteOptions,__SetTCustomComboBoxExAutoCompleteOptions,nil,false,0);
    DefineProp('DropDownCount',tkInteger,__GetTCustomComboBoxExDropDownCount,__SetTCustomComboBoxExDropDownCount,nil,false,0);
    DefineProp('Images',tkClass,__GetTCustomComboBoxExImages,__SetTCustomComboBoxExImages,TCustomImageList,false,0);
    DefineProp('ItemsEx',tkClass,__GetTCustomComboBoxExItemsEx,__SetTCustomComboBoxExItemsEx,TComboExItems,false,0);
    DefineProp('SelText',tkVariant,__GetTCustomComboBoxExSelText,__SetTCustomComboBoxExSelText,nil,false,0);
    DefineProp('Style',tkEnumeration,__GetTCustomComboBoxExStyle,__SetTCustomComboBoxExStyle,nil,false,0);
    DefineProp('StyleEx',tkInteger,__GetTCustomComboBoxExStyleEx,__SetTCustomComboBoxExStyleEx,nil,false,0);
  end;
  With Scripter.DefineClass(TComboBoxEx) do
  begin
  end;
  With Scripter.DefineClass(TComboBoxExActionLink) do
  begin
  end;
  DefineEventAdapter(TypeInfo(TTabChangingEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTabChangingEvent);
  DefineEventAdapter(TypeInfo(TTabGetImageEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTabGetImageEvent);
  DefineEventAdapter(TypeInfo(TCustomSectionNotifyEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TCustomSectionNotifyEvent);
  DefineEventAdapter(TypeInfo(TCustomSectionTrackEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TCustomSectionTrackEvent);
  DefineEventAdapter(TypeInfo(TSectionDragEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TSectionDragEvent);
  DefineEventAdapter(TypeInfo(TSectionNotifyEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TSectionNotifyEvent);
  DefineEventAdapter(TypeInfo(TSectionTrackEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TSectionTrackEvent);
  DefineEventAdapter(TypeInfo(TTVChangingEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTVChangingEvent);
  DefineEventAdapter(TypeInfo(TTVChangedEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTVChangedEvent);
  DefineEventAdapter(TypeInfo(TTVEditingEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTVEditingEvent);
  DefineEventAdapter(TypeInfo(TTVEditedEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTVEditedEvent);
  DefineEventAdapter(TypeInfo(TTVExpandingEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTVExpandingEvent);
  DefineEventAdapter(TypeInfo(TTVCollapsingEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTVCollapsingEvent);
  DefineEventAdapter(TypeInfo(TTVExpandedEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTVExpandedEvent);
  DefineEventAdapter(TypeInfo(TTVCompareEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTVCompareEvent);
  DefineEventAdapter(TypeInfo(TTVHintEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTVHintEvent);
  DefineEventAdapter(TypeInfo(TTVCustomDrawItemEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTVCustomDrawItemEvent);
  DefineEventAdapter(TypeInfo(TTVAdvancedCustomDrawItemEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTVAdvancedCustomDrawItemEvent);
  DefineEventAdapter(TypeInfo(TRichEditProtectChange), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TRichEditProtectChange);
  DefineEventAdapter(TypeInfo(TRichEditSaveClipboard), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TRichEditSaveClipboard);
  DefineEventAdapter(TypeInfo(TUDClickEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TUDClickEvent);
  DefineEventAdapter(TypeInfo(TUDChangingEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TUDChangingEvent);
  DefineEventAdapter(TypeInfo(TUDChangingEventEx), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TUDChangingEventEx);
  DefineEventAdapter(TypeInfo(TLVDeletedEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVDeletedEvent);
  DefineEventAdapter(TypeInfo(TLVEditingEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVEditingEvent);
  DefineEventAdapter(TypeInfo(TLVEditedEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVEditedEvent);
  DefineEventAdapter(TypeInfo(TLVChangeEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVChangeEvent);
  DefineEventAdapter(TypeInfo(TLVChangingEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVChangingEvent);
  DefineEventAdapter(TypeInfo(TLVColumnClickEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVColumnClickEvent);
  DefineEventAdapter(TypeInfo(TLVCompareEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVCompareEvent);
  DefineEventAdapter(TypeInfo(TLVDrawItemEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVDrawItemEvent);
  DefineEventAdapter(TypeInfo(TLVNotifyEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVNotifyEvent);
  DefineEventAdapter(TypeInfo(TLVSelectItemEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVSelectItemEvent);
  DefineEventAdapter(TypeInfo(TLVCheckedItemEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVCheckedItemEvent);
  DefineEventAdapter(TypeInfo(TLVCustomDrawItemEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVCustomDrawItemEvent);
  DefineEventAdapter(TypeInfo(TLVCustomDrawSubItemEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVCustomDrawSubItemEvent);
  DefineEventAdapter(TypeInfo(TLVAdvancedCustomDrawItemEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVAdvancedCustomDrawItemEvent);
  DefineEventAdapter(TypeInfo(TLVAdvancedCustomDrawSubItemEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVAdvancedCustomDrawSubItemEvent);
  DefineEventAdapter(TypeInfo(TLVOwnerDataEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVOwnerDataEvent);
  DefineEventAdapter(TypeInfo(TLVOwnerDataHintEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVOwnerDataHintEvent);
  DefineEventAdapter(TypeInfo(TLVOwnerDataStateChangeEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVOwnerDataStateChangeEvent);
  DefineEventAdapter(TypeInfo(TLVSubItemImageEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVSubItemImageEvent);
  DefineEventAdapter(TypeInfo(TLVInfoTipEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TLVInfoTipEvent);
  DefineEventAdapter(TypeInfo(TTBCustomDrawBtnEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTBCustomDrawBtnEvent);
  DefineEventAdapter(TypeInfo(TTBAdvancedCustomDrawBtnEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTBAdvancedCustomDrawBtnEvent);
  DefineEventAdapter(TypeInfo(TTBCustomizeQueryEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTBCustomizeQueryEvent);
  DefineEventAdapter(TypeInfo(TTBNewButtonEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTBNewButtonEvent);
  DefineEventAdapter(TypeInfo(TTBButtonEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TTBButtonEvent);
  DefineEventAdapter(TypeInfo(TOnGetMonthInfoEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TOnGetMonthInfoEvent);
  DefineEventAdapter(TypeInfo(TOnGetMonthBoldInfoEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TOnGetMonthBoldInfoEvent);
  DefineEventAdapter(TypeInfo(TDTParseInputEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TDTParseInputEvent);
  DefineEventAdapter(TypeInfo(TPageScrollEvent), TatComCtrlsDispatcher, @TatComCtrlsDispatcher.__TPageScrollEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('InitCommonControl',1,tkVariant,nil,__InitCommonControl,false,0);
    DefineMethod('CheckCommonControl',1,tkNone,nil,__CheckCommonControl,false,0);
    DefineMethod('GetComCtlVersion',0,tkInteger,nil,__GetComCtlVersion,false,0);
    DefineMethod('CheckToolMenuDropdown',1,tkNone,nil,__CheckToolMenuDropdown,false,0);
    AddConstant('htAbove',htAbove);
    AddConstant('htBelow',htBelow);
    AddConstant('htNowhere',htNowhere);
    AddConstant('htOnItem',htOnItem);
    AddConstant('htOnButton',htOnButton);
    AddConstant('htOnIcon',htOnIcon);
    AddConstant('htOnIndent',htOnIndent);
    AddConstant('htOnLabel',htOnLabel);
    AddConstant('htOnRight',htOnRight);
    AddConstant('htOnStateIcon',htOnStateIcon);
    AddConstant('htToLeft',htToLeft);
    AddConstant('htToRight',htToRight);
    AddConstant('tpTop',tpTop);
    AddConstant('tpBottom',tpBottom);
    AddConstant('tpLeft',tpLeft);
    AddConstant('tpRight',tpRight);
    AddConstant('tsTabs',tsTabs);
    AddConstant('tsButtons',tsButtons);
    AddConstant('tsFlatButtons',tsFlatButtons);
    AddConstant('psText',psText);
    AddConstant('psOwnerDraw',psOwnerDraw);
    AddConstant('pbNone',pbNone);
    AddConstant('pbLowered',pbLowered);
    AddConstant('pbRaised',pbRaised);
    AddConstant('dtControl',dtControl);
    AddConstant('dtItem',dtItem);
    AddConstant('dtSubItem',dtSubItem);
    AddConstant('cdPrePaint',cdPrePaint);
    AddConstant('cdPostPaint',cdPostPaint);
    AddConstant('cdPreErase',cdPreErase);
    AddConstant('cdPostErase',cdPostErase);
    AddConstant('hsText',hsText);
    AddConstant('hsOwnerDraw',hsOwnerDraw);
    AddConstant('tsTrackBegin',tsTrackBegin);
    AddConstant('tsTrackMove',tsTrackMove);
    AddConstant('tsTrackEnd',tsTrackEnd);
    AddConstant('hsButtons',hsButtons);
    AddConstant('hsFlat',hsFlat);
    AddConstant('nsCut',nsCut);
    AddConstant('nsDropHilited',nsDropHilited);
    AddConstant('nsFocused',nsFocused);
    AddConstant('nsSelected',nsSelected);
    AddConstant('nsExpanded',nsExpanded);
    AddConstant('naAdd',naAdd);
    AddConstant('naAddFirst',naAddFirst);
    AddConstant('naAddChild',naAddChild);
    AddConstant('naAddChildFirst',naAddChildFirst);
    AddConstant('naInsert',naInsert);
    AddConstant('taAddFirst',taAddFirst);
    AddConstant('taAdd',taAdd);
    AddConstant('taInsert',taInsert);
    AddConstant('ndtDefault',ndtDefault);
    AddConstant('ndtDefault2',ndtDefault2);
    AddConstant('ndt32bit',ndt32bit);
    AddConstant('ndt64bit',ndt64bit);
    AddConstant('ndt232bit',ndt232bit);
    AddConstant('ndt264bit',ndt264bit);
    AddConstant('tviDisabled',tviDisabled);
    AddConstant('tviFlat',tviFlat);
    AddConstant('stNone',stNone);
    AddConstant('stData',stData);
    AddConstant('stText',stText);
    AddConstant('stBoth',stBoth);
    AddConstant('msControlSelect',msControlSelect);
    AddConstant('msShiftSelect',msShiftSelect);
    AddConstant('msVisibleOnly',msVisibleOnly);
    AddConstant('msSiblingOnly',msSiblingOnly);
    AddConstant('trHorizontal',trHorizontal);
    AddConstant('trVertical',trVertical);
    AddConstant('tmBottomRight',tmBottomRight);
    AddConstant('tmTopLeft',tmTopLeft);
    AddConstant('tmBoth',tmBoth);
    AddConstant('tsNone',tsNone);
    AddConstant('tsAuto',tsAuto);
    AddConstant('tsManual',tsManual);
    AddConstant('ptNone',ptNone);
    AddConstant('ptTop',ptTop);
    AddConstant('ptLeft',ptLeft);
    AddConstant('ptBottom',ptBottom);
    AddConstant('ptRight',ptRight);
    AddConstant('pbHorizontal',pbHorizontal);
    AddConstant('pbVertical',pbVertical);
    AddConstant('pbstNormal',pbstNormal);
    AddConstant('pbstMarquee',pbstMarquee);
    AddConstant('pbsNormal',pbsNormal);
    AddConstant('pbsError',pbsError);
    AddConstant('pbsPaused',pbsPaused);
    AddConstant('atSelected',atSelected);
    AddConstant('atDefaultText',atDefaultText);
    AddConstant('caBold',caBold);
    AddConstant('caColor',caColor);
    AddConstant('caFace',caFace);
    AddConstant('caItalic',caItalic);
    AddConstant('caSize',caSize);
    AddConstant('caStrikeOut',caStrikeOut);
    AddConstant('caUnderline',caUnderline);
    AddConstant('caProtected',caProtected);
    AddConstant('nsNone',nsNone);
    AddConstant('nsBullet',nsBullet);
    AddConstant('stWholeWord',stWholeWord);
    AddConstant('stMatchCase',stMatchCase);
    AddConstant('udLeft',udLeft);
    AddConstant('udRight',udRight);
    AddConstant('udHorizontal',udHorizontal);
    AddConstant('udVertical',udVertical);
    AddConstant('btNext',btNext);
    AddConstant('btPrev',btPrev);
    AddConstant('updNone',updNone);
    AddConstant('updUp',updUp);
    AddConstant('updDown',updDown);
    AddConstant('hkShift',hkShift);
    AddConstant('hkCtrl',hkCtrl);
    AddConstant('hkAlt',hkAlt);
    AddConstant('hkExt',hkExt);
    AddConstant('hcNone',hcNone);
    AddConstant('hcShift',hcShift);
    AddConstant('hcCtrl',hcCtrl);
    AddConstant('hcAlt',hcAlt);
    AddConstant('hcShiftCtrl',hcShiftCtrl);
    AddConstant('hcShiftAlt',hcShiftAlt);
    AddConstant('hcCtrlAlt',hcCtrlAlt);
    AddConstant('hcShiftCtrlAlt',hcShiftCtrlAlt);
    AddConstant('lgsNormal',lgsNormal);
    AddConstant('lgsHidden',lgsHidden);
    AddConstant('lgsCollapsed',lgsCollapsed);
    AddConstant('lgsNoHeader',lgsNoHeader);
    AddConstant('lgsCollapsible',lgsCollapsible);
    AddConstant('lgsFocused',lgsFocused);
    AddConstant('lgsSelected',lgsSelected);
    AddConstant('lgsSubseted',lgsSubseted);
    AddConstant('lgsSubSetLinkFocused',lgsSubSetLinkFocused);
    AddConstant('drBounds',drBounds);
    AddConstant('drIcon',drIcon);
    AddConstant('drLabel',drLabel);
    AddConstant('drSelectBounds',drSelectBounds);
    AddConstant('iaTop',iaTop);
    AddConstant('iaLeft',iaLeft);
    AddConstant('arAlignBottom',arAlignBottom);
    AddConstant('arAlignLeft',arAlignLeft);
    AddConstant('arAlignRight',arAlignRight);
    AddConstant('arAlignTop',arAlignTop);
    AddConstant('arDefault',arDefault);
    AddConstant('arSnapToGrid',arSnapToGrid);
    AddConstant('vsIcon',vsIcon);
    AddConstant('vsSmallIcon',vsSmallIcon);
    AddConstant('vsList',vsList);
    AddConstant('vsReport',vsReport);
    AddConstant('isNone',isNone);
    AddConstant('isCut',isCut);
    AddConstant('isDropHilited',isDropHilited);
    AddConstant('isFocused',isFocused);
    AddConstant('isSelected',isSelected);
    AddConstant('isActivating',isActivating);
    AddConstant('ctText',ctText);
    AddConstant('ctImage',ctImage);
    AddConstant('ctState',ctState);
    AddConstant('ifData',ifData);
    AddConstant('ifPartialString',ifPartialString);
    AddConstant('ifExactString',ifExactString);
    AddConstant('ifNearest',ifNearest);
    AddConstant('sdLeft',sdLeft);
    AddConstant('sdRight',sdRight);
    AddConstant('sdAbove',sdAbove);
    AddConstant('sdBelow',sdBelow);
    AddConstant('sdAll',sdAll);
    AddConstant('htHandPoint',htHandPoint);
    AddConstant('htUnderlineCold',htUnderlineCold);
    AddConstant('htUnderlineHot',htUnderlineHot);
    AddConstant('irText',irText);
    AddConstant('irImage',irImage);
    AddConstant('irParam',irParam);
    AddConstant('irState',irState);
    AddConstant('irIndent',irIndent);
    AddConstant('aviNone',aviNone);
    AddConstant('aviFindFolder',aviFindFolder);
    AddConstant('aviFindFile',aviFindFile);
    AddConstant('aviFindComputer',aviFindComputer);
    AddConstant('aviCopyFiles',aviCopyFiles);
    AddConstant('aviCopyFile',aviCopyFile);
    AddConstant('aviRecycleFile',aviRecycleFile);
    AddConstant('aviEmptyRecycle',aviEmptyRecycle);
    AddConstant('aviDeleteFile',aviDeleteFile);
    AddConstant('tbsButton',tbsButton);
    AddConstant('tbsCheck',tbsCheck);
    AddConstant('tbsDropDown',tbsDropDown);
    AddConstant('tbsSeparator',tbsSeparator);
    AddConstant('tbsDivider',tbsDivider);
    AddConstant('tbsTextButton',tbsTextButton);
    AddConstant('tbsChecked',tbsChecked);
    AddConstant('tbsPressed',tbsPressed);
    AddConstant('tbsEnabled',tbsEnabled);
    AddConstant('tbsHidden',tbsHidden);
    AddConstant('tbsIndeterminate',tbsIndeterminate);
    AddConstant('tbsWrap',tbsWrap);
    AddConstant('tbsEllipses',tbsEllipses);
    AddConstant('tbsMarked',tbsMarked);
    AddConstant('dsNormal',dsNormal);
    AddConstant('dsGradient',dsGradient);
    AddConstant('bmNone',bmNone);
    AddConstant('bmClick',bmClick);
    AddConstant('bmDblClick',bmDblClick);
    AddConstant('dowMonday',dowMonday);
    AddConstant('dowTuesday',dowTuesday);
    AddConstant('dowWednesday',dowWednesday);
    AddConstant('dowThursday',dowThursday);
    AddConstant('dowFriday',dowFriday);
    AddConstant('dowSaturday',dowSaturday);
    AddConstant('dowSunday',dowSunday);
    AddConstant('dowLocaleDefault',dowLocaleDefault);
    AddConstant('dtkDate',dtkDate);
    AddConstant('dtkTime',dtkTime);
    AddConstant('dmComboBox',dmComboBox);
    AddConstant('dmUpDown',dmUpDown);
    AddConstant('dfShort',dfShort);
    AddConstant('dfLong',dfLong);
    AddConstant('dtaLeft',dtaLeft);
    AddConstant('dtaRight',dtaRight);
    AddConstant('soHorizontal',soHorizontal);
    AddConstant('soVertical',soVertical);
    AddConstant('sbFirst',sbFirst);
    AddConstant('sbLast',sbLast);
    AddConstant('bsNormal',bsNormal);
    AddConstant('bsInvisible',bsInvisible);
    AddConstant('bsGrayed',bsGrayed);
    AddConstant('bsDepressed',bsDepressed);
    AddConstant('bsHot',bsHot);
    AddConstant('csExDropDown',csExDropDown);
    AddConstant('csExSimple',csExSimple);
    AddConstant('csExDropDownList',csExDropDownList);
    AddConstant('csExCaseSensitive',csExCaseSensitive);
    AddConstant('csExNoEditImage',csExNoEditImage);
    AddConstant('csExNoEditImageIndent',csExNoEditImageIndent);
    AddConstant('csExNoSizeLimit',csExNoSizeLimit);
    AddConstant('csExPathWordBreak',csExPathWordBreak);
    AddConstant('acoAutoSuggest',acoAutoSuggest);
    AddConstant('acoAutoAppend',acoAutoAppend);
    AddConstant('acoSearch',acoSearch);
    AddConstant('acoFilterPrefixes',acoFilterPrefixes);
    AddConstant('acoUseTab',acoUseTab);
    AddConstant('acoUpDownKeyDropsList',acoUpDownKeyDropsList);
    AddConstant('acoRtlReading',acoRtlReading);
    AddConstant('ColumnHeaderWidth',ColumnHeaderWidth);
    AddConstant('ColumnTextWidth',ColumnTextWidth);
    AddConstant('CN_DROPDOWNCLOSED',CN_DROPDOWNCLOSED);
    AddConstant('CN_BANDCHANGE',CN_BANDCHANGE);
    AddConstant('ComCtlVersionIE3',ComCtlVersionIE3);
    AddConstant('ComCtlVersionIE4',ComCtlVersionIE4);
    AddConstant('ComCtlVersionIE401',ComCtlVersionIE401);
    AddConstant('ComCtlVersionIE5',ComCtlVersionIE5);
    AddConstant('ComCtlVersionIE501',ComCtlVersionIE501);
    AddConstant('ComCtlVersionIE6',ComCtlVersionIE6);
  end;
end;

class function TatComCtrlsLibrary.LibraryName: string;
begin
  result := 'ComCtrls';
end;

initialization
  RegisterScripterLibrary(TatComCtrlsLibrary, True);

{$WARNINGS ON}

end.

