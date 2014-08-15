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
unit ap_Commctrl;

interface

uses
  Messages,
  Windows,
  ActiveX,
  Commctrl,
  ap_Windows,
  atScript;

{$WARNINGS OFF}

type
  TatCommctrlLibrary = class(TatScripterLibrary)
    procedure __PropertySheetA(AMachine: TatVirtualMachine);
    procedure __PropertySheetW(AMachine: TatVirtualMachine);
    procedure __PropertySheet(AMachine: TatVirtualMachine);
    procedure __InitCommonControls(AMachine: TatVirtualMachine);
    procedure __InitCommonControlsEx(AMachine: TatVirtualMachine);
    procedure __ImageList_Create(AMachine: TatVirtualMachine);
    procedure __ImageList_Destroy(AMachine: TatVirtualMachine);
    procedure __ImageList_GetImageCount(AMachine: TatVirtualMachine);
    procedure __ImageList_SetImageCount(AMachine: TatVirtualMachine);
    procedure __ImageList_Add(AMachine: TatVirtualMachine);
    procedure __ImageList_ReplaceIcon(AMachine: TatVirtualMachine);
    procedure __ImageList_SetBkColor(AMachine: TatVirtualMachine);
    procedure __ImageList_GetBkColor(AMachine: TatVirtualMachine);
    procedure __ImageList_SetOverlayImage(AMachine: TatVirtualMachine);
    procedure __ImageList_AddIcon(AMachine: TatVirtualMachine);
    procedure __IndexToOverlayMask(AMachine: TatVirtualMachine);
    procedure __ImageList_Draw(AMachine: TatVirtualMachine);
    procedure __ImageList_Replace(AMachine: TatVirtualMachine);
    procedure __ImageList_AddMasked(AMachine: TatVirtualMachine);
    procedure __ImageList_DrawEx(AMachine: TatVirtualMachine);
    procedure __ImageList_Remove(AMachine: TatVirtualMachine);
    procedure __ImageList_GetIcon(AMachine: TatVirtualMachine);
    procedure __ImageList_LoadImageA(AMachine: TatVirtualMachine);
    procedure __ImageList_LoadImageW(AMachine: TatVirtualMachine);
    procedure __ImageList_LoadImage(AMachine: TatVirtualMachine);
    procedure __ImageList_Copy(AMachine: TatVirtualMachine);
    procedure __ImageList_BeginDrag(AMachine: TatVirtualMachine);
    procedure __ImageList_EndDrag(AMachine: TatVirtualMachine);
    procedure __ImageList_DragEnter(AMachine: TatVirtualMachine);
    procedure __ImageList_DragLeave(AMachine: TatVirtualMachine);
    procedure __ImageList_DragMove(AMachine: TatVirtualMachine);
    procedure __ImageList_SetDragCursorImage(AMachine: TatVirtualMachine);
    procedure __ImageList_DragShowNolock(AMachine: TatVirtualMachine);
    procedure __ImageList_RemoveAll(AMachine: TatVirtualMachine);
    procedure __ImageList_ExtractIcon(AMachine: TatVirtualMachine);
    procedure __ImageList_LoadBitmap(AMachine: TatVirtualMachine);
    procedure __ImageList_GetIconSize(AMachine: TatVirtualMachine);
    procedure __ImageList_SetIconSize(AMachine: TatVirtualMachine);
    procedure __ImageList_GetImageInfo(AMachine: TatVirtualMachine);
    procedure __ImageList_Merge(AMachine: TatVirtualMachine);
    procedure __ImageList_Duplicate(AMachine: TatVirtualMachine);
    procedure __Header_GetItemCount(AMachine: TatVirtualMachine);
    procedure __Header_InsertItem(AMachine: TatVirtualMachine);
    procedure __Header_DeleteItem(AMachine: TatVirtualMachine);
    procedure __Header_GetItem(AMachine: TatVirtualMachine);
    procedure __Header_SetItem(AMachine: TatVirtualMachine);
    procedure __Header_SetImageList(AMachine: TatVirtualMachine);
    procedure __Header_GetImageList(AMachine: TatVirtualMachine);
    procedure __Header_OrderToIndex(AMachine: TatVirtualMachine);
    procedure __Header_CreateDragImage(AMachine: TatVirtualMachine);
    procedure __Header_SetHotDivider(AMachine: TatVirtualMachine);
    procedure __Header_SetUnicodeFormat(AMachine: TatVirtualMachine);
    procedure __Header_GetUnicodeFormat(AMachine: TatVirtualMachine);
    procedure __CreateStatusWindowA(AMachine: TatVirtualMachine);
    procedure __CreateStatusWindowW(AMachine: TatVirtualMachine);
    procedure __CreateStatusWindow(AMachine: TatVirtualMachine);
    procedure __MakeDragList(AMachine: TatVirtualMachine);
    procedure __DrawInsert(AMachine: TatVirtualMachine);
    procedure __LBItemFromPt(AMachine: TatVirtualMachine);
    procedure __CreateUpDownControl(AMachine: TatVirtualMachine);
    procedure __ListView_SetUnicodeFormat(AMachine: TatVirtualMachine);
    procedure __ListView_GetUnicodeFormat(AMachine: TatVirtualMachine);
    procedure __ListView_GetBkColor(AMachine: TatVirtualMachine);
    procedure __ListView_SetBkColor(AMachine: TatVirtualMachine);
    procedure __ListView_GetImageList(AMachine: TatVirtualMachine);
    procedure __ListView_SetImageList(AMachine: TatVirtualMachine);
    procedure __ListView_GetItemCount(AMachine: TatVirtualMachine);
    procedure __IndexToStateImageMask(AMachine: TatVirtualMachine);
    procedure __ListView_GetItemA(AMachine: TatVirtualMachine);
    procedure __ListView_GetItemW(AMachine: TatVirtualMachine);
    procedure __ListView_GetItem(AMachine: TatVirtualMachine);
    procedure __ListView_SetItemA(AMachine: TatVirtualMachine);
    procedure __ListView_SetItemW(AMachine: TatVirtualMachine);
    procedure __ListView_SetItem(AMachine: TatVirtualMachine);
    procedure __ListView_InsertItemA(AMachine: TatVirtualMachine);
    procedure __ListView_InsertItemW(AMachine: TatVirtualMachine);
    procedure __ListView_InsertItem(AMachine: TatVirtualMachine);
    procedure __ListView_DeleteItem(AMachine: TatVirtualMachine);
    procedure __ListView_DeleteAllItems(AMachine: TatVirtualMachine);
    procedure __ListView_GetCallbackMask(AMachine: TatVirtualMachine);
    procedure __ListView_SetCallbackMask(AMachine: TatVirtualMachine);
    procedure __ListView_GetNextItem(AMachine: TatVirtualMachine);
    procedure __ListView_FindItemA(AMachine: TatVirtualMachine);
    procedure __ListView_FindItemW(AMachine: TatVirtualMachine);
    procedure __ListView_FindItem(AMachine: TatVirtualMachine);
    procedure __ListView_GetItemRect(AMachine: TatVirtualMachine);
    procedure __ListView_SetItemPosition(AMachine: TatVirtualMachine);
    procedure __ListView_GetItemPosition(AMachine: TatVirtualMachine);
    procedure __ListView_GetStringWidthA(AMachine: TatVirtualMachine);
    procedure __ListView_GetStringWidthW(AMachine: TatVirtualMachine);
    procedure __ListView_GetStringWidth(AMachine: TatVirtualMachine);
    procedure __ListView_HitTest(AMachine: TatVirtualMachine);
    procedure __ListView_EnsureVisible(AMachine: TatVirtualMachine);
    procedure __ListView_Scroll(AMachine: TatVirtualMachine);
    procedure __ListView_RedrawItems(AMachine: TatVirtualMachine);
    procedure __ListView_Arrange(AMachine: TatVirtualMachine);
    procedure __ListView_EditLabelA(AMachine: TatVirtualMachine);
    procedure __ListView_EditLabelW(AMachine: TatVirtualMachine);
    procedure __ListView_EditLabel(AMachine: TatVirtualMachine);
    procedure __ListView_GetEditControl(AMachine: TatVirtualMachine);
    procedure __ListView_GetColumnA(AMachine: TatVirtualMachine);
    procedure __ListView_GetColumnW(AMachine: TatVirtualMachine);
    procedure __ListView_GetColumn(AMachine: TatVirtualMachine);
    procedure __ListView_SetColumnA(AMachine: TatVirtualMachine);
    procedure __ListView_SetColumnW(AMachine: TatVirtualMachine);
    procedure __ListView_SetColumn(AMachine: TatVirtualMachine);
    procedure __ListView_InsertColumnA(AMachine: TatVirtualMachine);
    procedure __ListView_InsertColumnW(AMachine: TatVirtualMachine);
    procedure __ListView_InsertColumn(AMachine: TatVirtualMachine);
    procedure __ListView_DeleteColumn(AMachine: TatVirtualMachine);
    procedure __ListView_GetColumnWidth(AMachine: TatVirtualMachine);
    procedure __ListView_SetColumnWidth(AMachine: TatVirtualMachine);
    procedure __ListView_GetHeader(AMachine: TatVirtualMachine);
    procedure __ListView_CreateDragImage(AMachine: TatVirtualMachine);
    procedure __ListView_GetViewRect(AMachine: TatVirtualMachine);
    procedure __ListView_GetTextColor(AMachine: TatVirtualMachine);
    procedure __ListView_SetTextColor(AMachine: TatVirtualMachine);
    procedure __ListView_GetTextBkColor(AMachine: TatVirtualMachine);
    procedure __ListView_SetTextBkColor(AMachine: TatVirtualMachine);
    procedure __ListView_GetTopIndex(AMachine: TatVirtualMachine);
    procedure __ListView_GetCountPerPage(AMachine: TatVirtualMachine);
    procedure __ListView_GetOrigin(AMachine: TatVirtualMachine);
    procedure __ListView_Update(AMachine: TatVirtualMachine);
    procedure __ListView_SetItemState(AMachine: TatVirtualMachine);
    procedure __ListView_GetItemState(AMachine: TatVirtualMachine);
    procedure __ListView_GetCheckState(AMachine: TatVirtualMachine);
    procedure __ListView_SetCheckState(AMachine: TatVirtualMachine);
    procedure __ListView_GetItemTextA(AMachine: TatVirtualMachine);
    procedure __ListView_GetItemTextW(AMachine: TatVirtualMachine);
    procedure __ListView_GetItemText(AMachine: TatVirtualMachine);
    procedure __ListView_SetItemTextA(AMachine: TatVirtualMachine);
    procedure __ListView_SetItemTextW(AMachine: TatVirtualMachine);
    procedure __ListView_SetItemText(AMachine: TatVirtualMachine);
    procedure __ListView_SetItemCount(AMachine: TatVirtualMachine);
    procedure __ListView_SetItemCountEx(AMachine: TatVirtualMachine);
    procedure __ListView_SetItemPosition32(AMachine: TatVirtualMachine);
    procedure __ListView_GetSelectedCount(AMachine: TatVirtualMachine);
    procedure __ListView_GetItemSpacing(AMachine: TatVirtualMachine);
    procedure __ListView_GetISearchStringA(AMachine: TatVirtualMachine);
    procedure __ListView_GetISearchStringW(AMachine: TatVirtualMachine);
    procedure __ListView_GetISearchString(AMachine: TatVirtualMachine);
    procedure __ListView_SetIconSpacing(AMachine: TatVirtualMachine);
    procedure __ListView_SetExtendedListViewStyle(AMachine: TatVirtualMachine);
    procedure __ListView_GetExtendedListViewStyle(AMachine: TatVirtualMachine);
    procedure __ListView_SetHotItem(AMachine: TatVirtualMachine);
    procedure __ListView_GetHotItem(AMachine: TatVirtualMachine);
    procedure __ListView_SetHotCursor(AMachine: TatVirtualMachine);
    procedure __ListView_GetHotCursor(AMachine: TatVirtualMachine);
    procedure __ListView_ApproximateViewRect(AMachine: TatVirtualMachine);
    procedure __ListView_GetSelectionMark(AMachine: TatVirtualMachine);
    procedure __ListView_SetSelectionMark(AMachine: TatVirtualMachine);
    procedure __ListView_SetHoverTime(AMachine: TatVirtualMachine);
    procedure __ListView_GetHoverTime(AMachine: TatVirtualMachine);
    procedure __ListView_SetToolTips(AMachine: TatVirtualMachine);
    procedure __ListView_GetToolTips(AMachine: TatVirtualMachine);
    procedure __TreeView_DeleteAllItems(AMachine: TatVirtualMachine);
    procedure __TreeView_GetCount(AMachine: TatVirtualMachine);
    procedure __TreeView_GetIndent(AMachine: TatVirtualMachine);
    procedure __TreeView_SetIndent(AMachine: TatVirtualMachine);
    procedure __TreeView_GetImageList(AMachine: TatVirtualMachine);
    procedure __TreeView_SetImageList(AMachine: TatVirtualMachine);
    procedure __TreeView_GetItemA(AMachine: TatVirtualMachine);
    procedure __TreeView_GetItemW(AMachine: TatVirtualMachine);
    procedure __TreeView_GetItem(AMachine: TatVirtualMachine);
    procedure __TreeView_SetItemA(AMachine: TatVirtualMachine);
    procedure __TreeView_SetItemW(AMachine: TatVirtualMachine);
    procedure __TreeView_SetItem(AMachine: TatVirtualMachine);
    procedure __TreeView_GetEditControl(AMachine: TatVirtualMachine);
    procedure __TreeView_GetVisibleCount(AMachine: TatVirtualMachine);
    procedure __TreeView_SortChildrenCB(AMachine: TatVirtualMachine);
    procedure __TreeView_EndEditLabelNow(AMachine: TatVirtualMachine);
    procedure __TreeView_GetISearchStringA(AMachine: TatVirtualMachine);
    procedure __TreeView_GetISearchStringW(AMachine: TatVirtualMachine);
    procedure __TreeView_GetISearchString(AMachine: TatVirtualMachine);
    procedure __TreeView_SetToolTips(AMachine: TatVirtualMachine);
    procedure __TreeView_GetToolTips(AMachine: TatVirtualMachine);
    procedure __TreeView_SetInsertMark(AMachine: TatVirtualMachine);
    procedure __TreeView_SetUnicodeFormat(AMachine: TatVirtualMachine);
    procedure __TreeView_GetUnicodeFormat(AMachine: TatVirtualMachine);
    procedure __TreeView_SetItemHeight(AMachine: TatVirtualMachine);
    procedure __TreeView_GetItemHeight(AMachine: TatVirtualMachine);
    procedure __TreeView_SetBkColor(AMachine: TatVirtualMachine);
    procedure __TreeView_SetTextColor(AMachine: TatVirtualMachine);
    procedure __TreeView_GetBkColor(AMachine: TatVirtualMachine);
    procedure __TreeView_GetTextColor(AMachine: TatVirtualMachine);
    procedure __TreeView_SetScrollTime(AMachine: TatVirtualMachine);
    procedure __TreeView_GetScrollTime(AMachine: TatVirtualMachine);
    procedure __TreeView_SetInsertMarkColor(AMachine: TatVirtualMachine);
    procedure __TreeView_GetInsertMarkColor(AMachine: TatVirtualMachine);
    procedure __TabCtrl_SetItemExtra(AMachine: TatVirtualMachine);
    procedure __TabCtrl_SetItemSize(AMachine: TatVirtualMachine);
    procedure __TabCtrl_RemoveImage(AMachine: TatVirtualMachine);
    procedure __TabCtrl_SetPadding(AMachine: TatVirtualMachine);
    procedure __TabCtrl_GetRowCount(AMachine: TatVirtualMachine);
    procedure __TabCtrl_GetToolTips(AMachine: TatVirtualMachine);
    procedure __TabCtrl_SetToolTips(AMachine: TatVirtualMachine);
    procedure __TabCtrl_GetCurFocus(AMachine: TatVirtualMachine);
    procedure __TabCtrl_SetCurFocus(AMachine: TatVirtualMachine);
    procedure __TabCtrl_SetMinTabWidth(AMachine: TatVirtualMachine);
    procedure __TabCtrl_DeselectAll(AMachine: TatVirtualMachine);
    procedure __TabCtrl_HighlightItem(AMachine: TatVirtualMachine);
    procedure __TabCtrl_SetExtendedStyle(AMachine: TatVirtualMachine);
    procedure __TabCtrl_GetExtendedStyle(AMachine: TatVirtualMachine);
    procedure __TabCtrl_SetUnicodeFormat(AMachine: TatVirtualMachine);
    procedure __TabCtrl_GetUnicodeFormat(AMachine: TatVirtualMachine);
    procedure __TabCtrl_GetItemRect(AMachine: TatVirtualMachine);
    procedure __Animate_Create(AMachine: TatVirtualMachine);
    procedure __Animate_Open(AMachine: TatVirtualMachine);
    procedure __Animate_OpenEx(AMachine: TatVirtualMachine);
    procedure __Animate_Play(AMachine: TatVirtualMachine);
    procedure __Animate_Stop(AMachine: TatVirtualMachine);
    procedure __Animate_Close(AMachine: TatVirtualMachine);
    procedure __Animate_Seek(AMachine: TatVirtualMachine);
    procedure __MonthCal_GetCurSel(AMachine: TatVirtualMachine);
    procedure __MonthCal_SetCurSel(AMachine: TatVirtualMachine);
    procedure __MonthCal_GetMaxSelCount(AMachine: TatVirtualMachine);
    procedure __MonthCal_SetMaxSelCount(AMachine: TatVirtualMachine);
    procedure __MonthCal_SetDayState(AMachine: TatVirtualMachine);
    procedure __MonthCal_GetMinReqRect(AMachine: TatVirtualMachine);
    procedure __MonthCal_SetToday(AMachine: TatVirtualMachine);
    procedure __MonthCal_GetToday(AMachine: TatVirtualMachine);
    procedure __MonthCal_HitTest(AMachine: TatVirtualMachine);
    procedure __MonthCal_SetColor(AMachine: TatVirtualMachine);
    procedure __MonthCal_GetColor(AMachine: TatVirtualMachine);
    procedure __MonthCal_SetFirstDayOfWeek(AMachine: TatVirtualMachine);
    procedure __MonthCal_GetFirstDayOfWeek(AMachine: TatVirtualMachine);
    procedure __MonthCal_GetMonthDelta(AMachine: TatVirtualMachine);
    procedure __MonthCal_SetMonthDelta(AMachine: TatVirtualMachine);
    procedure __MonthCal_GetMaxTodayWidth(AMachine: TatVirtualMachine);
    procedure __MonthCal_SetUnicodeFormat(AMachine: TatVirtualMachine);
    procedure __MonthCal_GetUnicodeFormat(AMachine: TatVirtualMachine);
    procedure __DateTime_GetSystemTime(AMachine: TatVirtualMachine);
    procedure __DateTime_SetSystemTime(AMachine: TatVirtualMachine);
    procedure __DateTime_SetFormatA(AMachine: TatVirtualMachine);
    procedure __DateTime_SetFormatW(AMachine: TatVirtualMachine);
    procedure __DateTime_SetFormat(AMachine: TatVirtualMachine);
    procedure __DateTime_SetMonthCalColor(AMachine: TatVirtualMachine);
    procedure __DateTime_GetMonthCalColor(AMachine: TatVirtualMachine);
    procedure __DateTime_GetMonthCal(AMachine: TatVirtualMachine);
    procedure __DateTime_SetMonthCalFont(AMachine: TatVirtualMachine);
    procedure __DateTime_GetMonthCalFont(AMachine: TatVirtualMachine);
    procedure __MAKEIPRANGE(AMachine: TatVirtualMachine);
    procedure __MAKEIPADDRESS(AMachine: TatVirtualMachine);
    procedure __FIRST_IPADDRESS(AMachine: TatVirtualMachine);
    procedure __SECOND_IPADDRESS(AMachine: TatVirtualMachine);
    procedure __THIRD_IPADDRESS(AMachine: TatVirtualMachine);
    procedure __FOURTH_IPADDRESS(AMachine: TatVirtualMachine);
    procedure __Pager_SetChild(AMachine: TatVirtualMachine);
    procedure __Pager_RecalcSize(AMachine: TatVirtualMachine);
    procedure __Pager_ForwardMouse(AMachine: TatVirtualMachine);
    procedure __Pager_SetBkColor(AMachine: TatVirtualMachine);
    procedure __Pager_GetBkColor(AMachine: TatVirtualMachine);
    procedure __Pager_SetBorder(AMachine: TatVirtualMachine);
    procedure __Pager_GetBorder(AMachine: TatVirtualMachine);
    procedure __Pager_SetPos(AMachine: TatVirtualMachine);
    procedure __Pager_GetPos(AMachine: TatVirtualMachine);
    procedure __Pager_SetButtonSize(AMachine: TatVirtualMachine);
    procedure __Pager_GetButtonSize(AMachine: TatVirtualMachine);
    procedure __Pager_GetButtonState(AMachine: TatVirtualMachine);
    procedure __FlatSB_EnableScrollBar(AMachine: TatVirtualMachine);
    procedure __FlatSB_ShowScrollBar(AMachine: TatVirtualMachine);
    procedure __FlatSB_GetScrollRange(AMachine: TatVirtualMachine);
    procedure __FlatSB_GetScrollInfo(AMachine: TatVirtualMachine);
    procedure __FlatSB_GetScrollPos(AMachine: TatVirtualMachine);
    procedure __FlatSB_SetScrollPos(AMachine: TatVirtualMachine);
    procedure __FlatSB_SetScrollInfo(AMachine: TatVirtualMachine);
    procedure __FlatSB_SetScrollRange(AMachine: TatVirtualMachine);
    procedure __FlatSB_SetScrollProp(AMachine: TatVirtualMachine);
    procedure __InitializeFlatSB(AMachine: TatVirtualMachine);
    procedure __UninitializeFlatSB(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _PROPSHEETPAGEAWrapper = class(TatRecordWrapper)
  private
    FdwSize: Longint;
    FdwFlags: Longint;
    FhInstance: THandle;
    FhIcon: THandle;
    FlParam: Longint;
  public
    constructor Create(ARecord: _PROPSHEETPAGEA);
    function ObjToRec: _PROPSHEETPAGEA;
  published
    property dwSize: Longint read FdwSize write FdwSize;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hInstance: THandle read FhInstance write FhInstance;
    property hIcon: THandle read FhIcon write FhIcon;
    property lParam: Longint read FlParam write FlParam;
  end;
  
  _PROPSHEETPAGEWWrapper = class(TatRecordWrapper)
  private
    FdwSize: Longint;
    FdwFlags: Longint;
    FhInstance: THandle;
    FhIcon: THandle;
    FlParam: Longint;
  public
    constructor Create(ARecord: _PROPSHEETPAGEW);
    function ObjToRec: _PROPSHEETPAGEW;
  published
    property dwSize: Longint read FdwSize write FdwSize;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hInstance: THandle read FhInstance write FhInstance;
    property hIcon: THandle read FhIcon write FhIcon;
    property lParam: Longint read FlParam write FlParam;
  end;
  
  _PROPSHEETHEADERAWrapper = class(TatRecordWrapper)
  private
    FdwSize: Longint;
    FdwFlags: Longint;
    FhwndParent: HWnd;
    FhInstance: THandle;
    FhIcon: THandle;
    FnPages: Integer;
    FnStartPage: Integer;
    FhbmWatermark: HBITMAP;
    FhplWatermark: HPALETTE;
    FhbmHeader: HBITMAP;
  public
    constructor Create(ARecord: _PROPSHEETHEADERA);
    function ObjToRec: _PROPSHEETHEADERA;
  published
    property dwSize: Longint read FdwSize write FdwSize;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hwndParent: HWnd read FhwndParent write FhwndParent;
    property hInstance: THandle read FhInstance write FhInstance;
    property hIcon: THandle read FhIcon write FhIcon;
    property nPages: Integer read FnPages write FnPages;
    property nStartPage: Integer read FnStartPage write FnStartPage;
    property hbmWatermark: HBITMAP read FhbmWatermark write FhbmWatermark;
    property hplWatermark: HPALETTE read FhplWatermark write FhplWatermark;
    property hbmHeader: HBITMAP read FhbmHeader write FhbmHeader;
  end;
  
  _PROPSHEETHEADERWWrapper = class(TatRecordWrapper)
  private
    FdwSize: Longint;
    FdwFlags: Longint;
    FhwndParent: HWnd;
    FhInstance: THandle;
    FhIcon: THandle;
    FnPages: Integer;
    FnStartPage: Integer;
    FhbmWatermark: HBITMAP;
    FhplWatermark: HPALETTE;
    FhbmHeader: HBITMAP;
  public
    constructor Create(ARecord: _PROPSHEETHEADERW);
    function ObjToRec: _PROPSHEETHEADERW;
  published
    property dwSize: Longint read FdwSize write FdwSize;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hwndParent: HWnd read FhwndParent write FhwndParent;
    property hInstance: THandle read FhInstance write FhInstance;
    property hIcon: THandle read FhIcon write FhIcon;
    property nPages: Integer read FnPages write FnPages;
    property nStartPage: Integer read FnStartPage write FnStartPage;
    property hbmWatermark: HBITMAP read FhbmWatermark write FhbmWatermark;
    property hplWatermark: HPALETTE read FhplWatermark write FhplWatermark;
    property hbmHeader: HBITMAP read FhbmHeader write FhbmHeader;
  end;
  
  tagINITCOMMONCONTROLSEXWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FdwICC: DWORD;
  public
    constructor Create(ARecord: tagINITCOMMONCONTROLSEX);
    function ObjToRec: tagINITCOMMONCONTROLSEX;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property dwICC: DWORD read FdwICC write FdwICC;
  end;
  
  tagCOLORSCHEMEWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FclrBtnHighlight: COLORREF;
    FclrBtnShadow: COLORREF;
  public
    constructor Create(ARecord: tagCOLORSCHEME);
    function ObjToRec: tagCOLORSCHEME;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property clrBtnHighlight: COLORREF read FclrBtnHighlight write FclrBtnHighlight;
    property clrBtnShadow: COLORREF read FclrBtnShadow write FclrBtnShadow;
  end;
  
  tagNMMOUSEWrapper = class(TatRecordWrapper)
  private
    FdwItemSpec: DWORD;
    FdwItemData: DWORD;
    FdwHitInfo: DWORD;
  public
    constructor Create(ARecord: tagNMMOUSE);
    function ObjToRec: tagNMMOUSE;
  published
    property dwItemSpec: DWORD read FdwItemSpec write FdwItemSpec;
    property dwItemData: DWORD read FdwItemData write FdwItemData;
    property dwHitInfo: DWORD read FdwHitInfo write FdwHitInfo;
  end;
  
  tagNMOBJECTNOTIFYWrapper = class(TatRecordWrapper)
  private
    FiItem: Integer;
    FhResult: HRESULT;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagNMOBJECTNOTIFY);
    function ObjToRec: tagNMOBJECTNOTIFY;
  published
    property iItem: Integer read FiItem write FiItem;
    property hResult: HRESULT read FhResult write FhResult;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagNMKEYWrapper = class(TatRecordWrapper)
  private
    FnVKey: UINT;
    FuFlags: UINT;
  public
    constructor Create(ARecord: tagNMKEY);
    function ObjToRec: tagNMKEY;
  published
    property nVKey: UINT read FnVKey write FnVKey;
    property uFlags: UINT read FuFlags write FuFlags;
  end;
  
  tagNMCHARWrapper = class(TatRecordWrapper)
  private
    Fch: UINT;
    FdwItemPrev: DWORD;
    FdwItemNext: DWORD;
  public
    constructor Create(ARecord: tagNMCHAR);
    function ObjToRec: tagNMCHAR;
  published
    property ch: UINT read Fch write Fch;
    property dwItemPrev: DWORD read FdwItemPrev write FdwItemPrev;
    property dwItemNext: DWORD read FdwItemNext write FdwItemNext;
  end;
  
  tagNMCUSTOMDRAWINFOWrapper = class(TatRecordWrapper)
  private
    FdwDrawStage: DWORD;
    Fhdc: HDC;
    FdwItemSpec: DWORD;
    FuItemState: UINT;
    FlItemlParam: LPARAM;
  public
    constructor Create(ARecord: tagNMCUSTOMDRAWINFO);
    function ObjToRec: tagNMCUSTOMDRAWINFO;
  published
    property dwDrawStage: DWORD read FdwDrawStage write FdwDrawStage;
    property hdc: HDC read Fhdc write Fhdc;
    property dwItemSpec: DWORD read FdwItemSpec write FdwItemSpec;
    property uItemState: UINT read FuItemState write FuItemState;
    property lItemlParam: LPARAM read FlItemlParam write FlItemlParam;
  end;
  
  tagNMTTCUSTOMDRAWWrapper = class(TatRecordWrapper)
  private
    FuDrawFlags: UINT;
  public
    constructor Create(ARecord: tagNMTTCUSTOMDRAW);
    function ObjToRec: tagNMTTCUSTOMDRAW;
  published
    property uDrawFlags: UINT read FuDrawFlags write FuDrawFlags;
  end;
  
  _IMAGELISTDRAWPARAMSWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    Fhiml: HIMAGELIST;
    Fi: Integer;
    FhdcDst: HDC;
    Fx: Integer;
    Fy: Integer;
    Fcx: Integer;
    Fcy: Integer;
    FxBitmap: Integer;
    FyBitmap: Integer;
    FrgbBk: COLORREF;
    FrgbFg: COLORREF;
    FfStyle: UINT;
    FdwRop: DWORD;
  public
    constructor Create(ARecord: _IMAGELISTDRAWPARAMS);
    function ObjToRec: _IMAGELISTDRAWPARAMS;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property himl: HIMAGELIST read Fhiml write Fhiml;
    property i: Integer read Fi write Fi;
    property hdcDst: HDC read FhdcDst write FhdcDst;
    property x: Integer read Fx write Fx;
    property y: Integer read Fy write Fy;
    property cx: Integer read Fcx write Fcx;
    property cy: Integer read Fcy write Fcy;
    property xBitmap: Integer read FxBitmap write FxBitmap;
    property yBitmap: Integer read FyBitmap write FyBitmap;
    property rgbBk: COLORREF read FrgbBk write FrgbBk;
    property rgbFg: COLORREF read FrgbFg write FrgbFg;
    property fStyle: UINT read FfStyle write FfStyle;
    property dwRop: DWORD read FdwRop write FdwRop;
  end;
  
  _IMAGEINFOWrapper = class(TatRecordWrapper)
  private
    FhbmImage: HBitmap;
    FhbmMask: HBitmap;
    FUnused1: Integer;
    FUnused2: Integer;
  public
    constructor Create(ARecord: _IMAGEINFO);
    function ObjToRec: _IMAGEINFO;
  published
    property hbmImage: HBitmap read FhbmImage write FhbmImage;
    property hbmMask: HBitmap read FhbmMask write FhbmMask;
    property Unused1: Integer read FUnused1 write FUnused1;
    property Unused2: Integer read FUnused2 write FUnused2;
  end;
  
  _HD_ITEMAWrapper = class(TatRecordWrapper)
  private
    FMask: Cardinal;
    Fcxy: Integer;
    Fhbm: HBITMAP;
    FcchTextMax: Integer;
    Ffmt: Integer;
    FlParam: LPARAM;
    FiImage: Integer;
    FiOrder: Integer;
  public
    constructor Create(ARecord: _HD_ITEMA);
    function ObjToRec: _HD_ITEMA;
  published
    property Mask: Cardinal read FMask write FMask;
    property cxy: Integer read Fcxy write Fcxy;
    property hbm: HBITMAP read Fhbm write Fhbm;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property fmt: Integer read Ffmt write Ffmt;
    property lParam: LPARAM read FlParam write FlParam;
    property iImage: Integer read FiImage write FiImage;
    property iOrder: Integer read FiOrder write FiOrder;
  end;
  
  _HD_ITEMWWrapper = class(TatRecordWrapper)
  private
    FMask: Cardinal;
    Fcxy: Integer;
    Fhbm: HBITMAP;
    FcchTextMax: Integer;
    Ffmt: Integer;
    FlParam: LPARAM;
    FiImage: Integer;
    FiOrder: Integer;
  public
    constructor Create(ARecord: _HD_ITEMW);
    function ObjToRec: _HD_ITEMW;
  published
    property Mask: Cardinal read FMask write FMask;
    property cxy: Integer read Fcxy write Fcxy;
    property hbm: HBITMAP read Fhbm write Fhbm;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property fmt: Integer read Ffmt write Ffmt;
    property lParam: LPARAM read FlParam write FlParam;
    property iImage: Integer read FiImage write FiImage;
    property iOrder: Integer read FiOrder write FiOrder;
  end;
  
  _HD_LAYOUTWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _HD_LAYOUT);
    function ObjToRec: _HD_LAYOUT;
  published
  end;
  
  _HD_HITTESTINFOWrapper = class(TatRecordWrapper)
  private
    FFlags: Cardinal;
    FItem: Integer;
  public
    constructor Create(ARecord: _HD_HITTESTINFO);
    function ObjToRec: _HD_HITTESTINFO;
  published
    property Flags: Cardinal read FFlags write FFlags;
    property Item: Integer read FItem write FItem;
  end;
  
  tagNMHEADERAWrapper = class(TatRecordWrapper)
  private
    FItem: Integer;
    FButton: Integer;
  public
    constructor Create(ARecord: tagNMHEADERA);
    function ObjToRec: tagNMHEADERA;
  published
    property Item: Integer read FItem write FItem;
    property Button: Integer read FButton write FButton;
  end;
  
  tagNMHEADERWWrapper = class(TatRecordWrapper)
  private
    FItem: Integer;
    FButton: Integer;
  public
    constructor Create(ARecord: tagNMHEADERW);
    function ObjToRec: tagNMHEADERW;
  published
    property Item: Integer read FItem write FItem;
    property Button: Integer read FButton write FButton;
  end;
  
  tagNMHDDISPINFOAWrapper = class(TatRecordWrapper)
  private
    FiItem: Integer;
    Fmask: UINT;
    FcchTextMax: Integer;
    FiImage: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagNMHDDISPINFOA);
    function ObjToRec: tagNMHDDISPINFOA;
  published
    property iItem: Integer read FiItem write FiItem;
    property mask: UINT read Fmask write Fmask;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagNMHDDISPINFOWWrapper = class(TatRecordWrapper)
  private
    FiItem: Integer;
    Fmask: UINT;
    FcchTextMax: Integer;
    FiImage: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagNMHDDISPINFOW);
    function ObjToRec: tagNMHDDISPINFOW;
  published
    property iItem: Integer read FiItem write FiItem;
    property mask: UINT read Fmask write Fmask;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  _TBBUTTONWrapper = class(TatRecordWrapper)
  private
    FiBitmap: Integer;
    FidCommand: Integer;
    FfsState: Byte;
    FfsStyle: Byte;
    FdwData: Longint;
    FiString: Integer;
  public
    constructor Create(ARecord: _TBBUTTON);
    function ObjToRec: _TBBUTTON;
  published
    property iBitmap: Integer read FiBitmap write FiBitmap;
    property idCommand: Integer read FidCommand write FidCommand;
    property fsState: Byte read FfsState write FfsState;
    property fsStyle: Byte read FfsStyle write FfsStyle;
    property dwData: Longint read FdwData write FdwData;
    property iString: Integer read FiString write FiString;
  end;
  
  _COLORMAPWrapper = class(TatRecordWrapper)
  private
    FcFrom: TColorRef;
    FcTo: TColorRef;
  public
    constructor Create(ARecord: _COLORMAP);
    function ObjToRec: _COLORMAP;
  published
    property cFrom: TColorRef read FcFrom write FcFrom;
    property cTo: TColorRef read FcTo write FcTo;
  end;
  
  _NMTBCUSTOMDRAWWrapper = class(TatRecordWrapper)
  private
    FhbrMonoDither: HBRUSH;
    FhbrLines: HBRUSH;
    FhpenLines: HPEN;
    FclrText: COLORREF;
    FclrMark: COLORREF;
    FclrTextHighlight: COLORREF;
    FclrBtnFace: COLORREF;
    FclrBtnHighlight: COLORREF;
    FclrHighlightHotTrack: COLORREF;
    FnStringBkMode: Integer;
    FnHLStringBkMode: Integer;
  public
    constructor Create(ARecord: _NMTBCUSTOMDRAW);
    function ObjToRec: _NMTBCUSTOMDRAW;
  published
    property hbrMonoDither: HBRUSH read FhbrMonoDither write FhbrMonoDither;
    property hbrLines: HBRUSH read FhbrLines write FhbrLines;
    property hpenLines: HPEN read FhpenLines write FhpenLines;
    property clrText: COLORREF read FclrText write FclrText;
    property clrMark: COLORREF read FclrMark write FclrMark;
    property clrTextHighlight: COLORREF read FclrTextHighlight write FclrTextHighlight;
    property clrBtnFace: COLORREF read FclrBtnFace write FclrBtnFace;
    property clrBtnHighlight: COLORREF read FclrBtnHighlight write FclrBtnHighlight;
    property clrHighlightHotTrack: COLORREF read FclrHighlightHotTrack write FclrHighlightHotTrack;
    property nStringBkMode: Integer read FnStringBkMode write FnStringBkMode;
    property nHLStringBkMode: Integer read FnHLStringBkMode write FnHLStringBkMode;
  end;
  
  tagTBADDBITMAPWrapper = class(TatRecordWrapper)
  private
    FhInst: THandle;
    FnID: UINT;
  public
    constructor Create(ARecord: tagTBADDBITMAP);
    function ObjToRec: tagTBADDBITMAP;
  published
    property hInst: THandle read FhInst write FhInst;
    property nID: UINT read FnID write FnID;
  end;
  
  tagTBSAVEPARAMSAWrapper = class(TatRecordWrapper)
  private
    Fhkr: THandle;
  public
    constructor Create(ARecord: tagTBSAVEPARAMSA);
    function ObjToRec: tagTBSAVEPARAMSA;
  published
    property hkr: THandle read Fhkr write Fhkr;
  end;
  
  tagTBSAVEPARAMSWWrapper = class(TatRecordWrapper)
  private
    Fhkr: THandle;
  public
    constructor Create(ARecord: tagTBSAVEPARAMSW);
    function ObjToRec: tagTBSAVEPARAMSW;
  published
    property hkr: THandle read Fhkr write Fhkr;
  end;
  
  TBINSERTMARKWrapper = class(TatRecordWrapper)
  private
    FiButton: Integer;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: TBINSERTMARK);
    function ObjToRec: TBINSERTMARK;
  published
    property iButton: Integer read FiButton write FiButton;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  TBREPLACEBITMAPWrapper = class(TatRecordWrapper)
  private
    FhInstOld: THandle;
    FnIDOld: Cardinal;
    FhInstNew: THandle;
    FnIDNew: Cardinal;
    FnButtons: Integer;
  public
    constructor Create(ARecord: TBREPLACEBITMAP);
    function ObjToRec: TBREPLACEBITMAP;
  published
    property hInstOld: THandle read FhInstOld write FhInstOld;
    property nIDOld: Cardinal read FnIDOld write FnIDOld;
    property hInstNew: THandle read FhInstNew write FhInstNew;
    property nIDNew: Cardinal read FnIDNew write FnIDNew;
    property nButtons: Integer read FnButtons write FnButtons;
  end;
  
  TBBUTTONINFOAWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwMask: DWORD;
    FidCommand: Integer;
    FiImage: Integer;
    FfsState: Byte;
    FfsStyle: Byte;
    Fcx: Word;
    FlParam: DWORD;
    FcchText: Integer;
  public
    constructor Create(ARecord: TBBUTTONINFOA);
    function ObjToRec: TBBUTTONINFOA;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwMask: DWORD read FdwMask write FdwMask;
    property idCommand: Integer read FidCommand write FidCommand;
    property iImage: Integer read FiImage write FiImage;
    property fsState: Byte read FfsState write FfsState;
    property fsStyle: Byte read FfsStyle write FfsStyle;
    property cx: Word read Fcx write Fcx;
    property lParam: DWORD read FlParam write FlParam;
    property cchText: Integer read FcchText write FcchText;
  end;
  
  TBBUTTONINFOWWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwMask: DWORD;
    FidCommand: Integer;
    FiImage: Integer;
    FfsState: Byte;
    FfsStyle: Byte;
    Fcx: Word;
    FlParam: DWORD;
    FcchText: Integer;
  public
    constructor Create(ARecord: TBBUTTONINFOW);
    function ObjToRec: TBBUTTONINFOW;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwMask: DWORD read FdwMask write FdwMask;
    property idCommand: Integer read FidCommand write FidCommand;
    property iImage: Integer read FiImage write FiImage;
    property fsState: Byte read FfsState write FfsState;
    property fsStyle: Byte read FfsStyle write FfsStyle;
    property cx: Word read Fcx write Fcx;
    property lParam: DWORD read FlParam write FlParam;
    property cchText: Integer read FcchText write FcchText;
  end;
  
  tagNMTBHOTITEMWrapper = class(TatRecordWrapper)
  private
    FidOld: Integer;
    FidNew: Integer;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagNMTBHOTITEM);
    function ObjToRec: tagNMTBHOTITEM;
  published
    property idOld: Integer read FidOld write FidOld;
    property idNew: Integer read FidNew write FidNew;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagNMTBGETINFOTIPAWrapper = class(TatRecordWrapper)
  private
    FcchTextMax: Integer;
    FiItem: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagNMTBGETINFOTIPA);
    function ObjToRec: tagNMTBGETINFOTIPA;
  published
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iItem: Integer read FiItem write FiItem;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagNMTBGETINFOTIPWWrapper = class(TatRecordWrapper)
  private
    FcchTextMax: Integer;
    FiItem: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagNMTBGETINFOTIPW);
    function ObjToRec: tagNMTBGETINFOTIPW;
  published
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iItem: Integer read FiItem write FiItem;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  NMTBDISPINFOAWrapper = class(TatRecordWrapper)
  private
    FdwMask: DWORD;
    FidCommand: Integer;
    FlParam: DWORD;
    FiImage: Integer;
    FcchText: Integer;
  public
    constructor Create(ARecord: NMTBDISPINFOA);
    function ObjToRec: NMTBDISPINFOA;
  published
    property dwMask: DWORD read FdwMask write FdwMask;
    property idCommand: Integer read FidCommand write FidCommand;
    property lParam: DWORD read FlParam write FlParam;
    property iImage: Integer read FiImage write FiImage;
    property cchText: Integer read FcchText write FcchText;
  end;
  
  NMTBDISPINFOWWrapper = class(TatRecordWrapper)
  private
    FdwMask: DWORD;
    FidCommand: Integer;
    FlParam: DWORD;
    FiImage: Integer;
    FcchText: Integer;
  public
    constructor Create(ARecord: NMTBDISPINFOW);
    function ObjToRec: NMTBDISPINFOW;
  published
    property dwMask: DWORD read FdwMask write FdwMask;
    property idCommand: Integer read FidCommand write FidCommand;
    property lParam: DWORD read FlParam write FlParam;
    property iImage: Integer read FiImage write FiImage;
    property cchText: Integer read FcchText write FcchText;
  end;
  
  tagNMTOOLBARAWrapper = class(TatRecordWrapper)
  private
    FiItem: Integer;
    FcchText: Integer;
  public
    constructor Create(ARecord: tagNMTOOLBARA);
    function ObjToRec: tagNMTOOLBARA;
  published
    property iItem: Integer read FiItem write FiItem;
    property cchText: Integer read FcchText write FcchText;
  end;
  
  tagNMTOOLBARWWrapper = class(TatRecordWrapper)
  private
    FiItem: Integer;
    FcchText: Integer;
  public
    constructor Create(ARecord: tagNMTOOLBARW);
    function ObjToRec: tagNMTOOLBARW;
  published
    property iItem: Integer read FiItem write FiItem;
    property cchText: Integer read FcchText write FcchText;
  end;
  
  tagREBARINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FfMask: UINT;
    Fhiml: HIMAGELIST;
  public
    constructor Create(ARecord: tagREBARINFO);
    function ObjToRec: tagREBARINFO;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property fMask: UINT read FfMask write FfMask;
    property himl: HIMAGELIST read Fhiml write Fhiml;
  end;
  
  tagREBARBANDINFOAWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FfMask: UINT;
    FfStyle: UINT;
    FclrFore: TColorRef;
    FclrBack: TColorRef;
    Fcch: UINT;
    FiImage: Integer;
    FhwndChild: HWnd;
    FcxMinChild: UINT;
    FcyMinChild: UINT;
    Fcx: UINT;
    FhbmBack: HBitmap;
    FwID: UINT;
    FcyChild: UINT;
    FcyMaxChild: UINT;
    FcyIntegral: UINT;
    FcxIdeal: UINT;
    FlParam: LPARAM;
    FcxHeader: UINT;
  public
    constructor Create(ARecord: tagREBARBANDINFOA);
    function ObjToRec: tagREBARBANDINFOA;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property fMask: UINT read FfMask write FfMask;
    property fStyle: UINT read FfStyle write FfStyle;
    property clrFore: TColorRef read FclrFore write FclrFore;
    property clrBack: TColorRef read FclrBack write FclrBack;
    property cch: UINT read Fcch write Fcch;
    property iImage: Integer read FiImage write FiImage;
    property hwndChild: HWnd read FhwndChild write FhwndChild;
    property cxMinChild: UINT read FcxMinChild write FcxMinChild;
    property cyMinChild: UINT read FcyMinChild write FcyMinChild;
    property cx: UINT read Fcx write Fcx;
    property hbmBack: HBitmap read FhbmBack write FhbmBack;
    property wID: UINT read FwID write FwID;
    property cyChild: UINT read FcyChild write FcyChild;
    property cyMaxChild: UINT read FcyMaxChild write FcyMaxChild;
    property cyIntegral: UINT read FcyIntegral write FcyIntegral;
    property cxIdeal: UINT read FcxIdeal write FcxIdeal;
    property lParam: LPARAM read FlParam write FlParam;
    property cxHeader: UINT read FcxHeader write FcxHeader;
  end;
  
  tagREBARBANDINFOWWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FfMask: UINT;
    FfStyle: UINT;
    FclrFore: TColorRef;
    FclrBack: TColorRef;
    Fcch: UINT;
    FiImage: Integer;
    FhwndChild: HWnd;
    FcxMinChild: UINT;
    FcyMinChild: UINT;
    Fcx: UINT;
    FhbmBack: HBitmap;
    FwID: UINT;
    FcyChild: UINT;
    FcyMaxChild: UINT;
    FcyIntegral: UINT;
    FcxIdeal: UINT;
    FlParam: LPARAM;
    FcxHeader: UINT;
  public
    constructor Create(ARecord: tagREBARBANDINFOW);
    function ObjToRec: tagREBARBANDINFOW;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property fMask: UINT read FfMask write FfMask;
    property fStyle: UINT read FfStyle write FfStyle;
    property clrFore: TColorRef read FclrFore write FclrFore;
    property clrBack: TColorRef read FclrBack write FclrBack;
    property cch: UINT read Fcch write Fcch;
    property iImage: Integer read FiImage write FiImage;
    property hwndChild: HWnd read FhwndChild write FhwndChild;
    property cxMinChild: UINT read FcxMinChild write FcxMinChild;
    property cyMinChild: UINT read FcyMinChild write FcyMinChild;
    property cx: UINT read Fcx write Fcx;
    property hbmBack: HBitmap read FhbmBack write FhbmBack;
    property wID: UINT read FwID write FwID;
    property cyChild: UINT read FcyChild write FcyChild;
    property cyMaxChild: UINT read FcyMaxChild write FcyMaxChild;
    property cyIntegral: UINT read FcyIntegral write FcyIntegral;
    property cxIdeal: UINT read FcxIdeal write FcxIdeal;
    property lParam: LPARAM read FlParam write FlParam;
    property cxHeader: UINT read FcxHeader write FcxHeader;
  end;
  
  tagNMREBARCHILDSIZEWrapper = class(TatRecordWrapper)
  private
    FuBand: UINT;
    FwID: UINT;
  public
    constructor Create(ARecord: tagNMREBARCHILDSIZE);
    function ObjToRec: tagNMREBARCHILDSIZE;
  published
    property uBand: UINT read FuBand write FuBand;
    property wID: UINT read FwID write FwID;
  end;
  
  tagNMREBARWrapper = class(TatRecordWrapper)
  private
    FdwMask: DWORD;
    FuBand: UINT;
    FfStyle: UINT;
    FwID: UINT;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagNMREBAR);
    function ObjToRec: tagNMREBAR;
  published
    property dwMask: DWORD read FdwMask write FdwMask;
    property uBand: UINT read FuBand write FuBand;
    property fStyle: UINT read FfStyle write FfStyle;
    property wID: UINT read FwID write FwID;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagNMRBAUTOSIZEWrapper = class(TatRecordWrapper)
  private
    FfChanged: BOOL;
  public
    constructor Create(ARecord: tagNMRBAUTOSIZE);
    function ObjToRec: tagNMRBAUTOSIZE;
  published
    property fChanged: BOOL read FfChanged write FfChanged;
  end;
  
  _RB_HITTESTINFOWrapper = class(TatRecordWrapper)
  private
    Fflags: UINT;
    FiBand: Integer;
  public
    constructor Create(ARecord: _RB_HITTESTINFO);
    function ObjToRec: _RB_HITTESTINFO;
  published
    property flags: UINT read Fflags write Fflags;
    property iBand: Integer read FiBand write FiBand;
  end;
  
  tagTOOLINFOAWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FuFlags: UINT;
    Fhwnd: HWND;
    FuId: UINT;
    FhInst: THandle;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagTOOLINFOA);
    function ObjToRec: tagTOOLINFOA;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property uFlags: UINT read FuFlags write FuFlags;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property uId: UINT read FuId write FuId;
    property hInst: THandle read FhInst write FhInst;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagTOOLINFOWWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FuFlags: UINT;
    Fhwnd: HWND;
    FuId: UINT;
    FhInst: THandle;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagTOOLINFOW);
    function ObjToRec: tagTOOLINFOW;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property uFlags: UINT read FuFlags write FuFlags;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property uId: UINT read FuId write FuId;
    property hInst: THandle read FhInst write FhInst;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  _TT_HITTESTINFOAWrapper = class(TatRecordWrapper)
  private
    Fhwnd: HWND;
  public
    constructor Create(ARecord: _TT_HITTESTINFOA);
    function ObjToRec: _TT_HITTESTINFOA;
  published
    property hwnd: HWND read Fhwnd write Fhwnd;
  end;
  
  _TT_HITTESTINFOWWrapper = class(TatRecordWrapper)
  private
    Fhwnd: HWND;
  public
    constructor Create(ARecord: _TT_HITTESTINFOW);
    function ObjToRec: _TT_HITTESTINFOW;
  published
    property hwnd: HWND read Fhwnd write Fhwnd;
  end;
  
  tagNMTTDISPINFOAWrapper = class(TatRecordWrapper)
  private
    Fhinst: HINST;
    FuFlags: UINT;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagNMTTDISPINFOA);
    function ObjToRec: tagNMTTDISPINFOA;
  published
    property hinst: HINST read Fhinst write Fhinst;
    property uFlags: UINT read FuFlags write FuFlags;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagNMTTDISPINFOWWrapper = class(TatRecordWrapper)
  private
    Fhinst: HINST;
    FuFlags: UINT;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagNMTTDISPINFOW);
    function ObjToRec: tagNMTTDISPINFOW;
  published
    property hinst: HINST read Fhinst write Fhinst;
    property uFlags: UINT read FuFlags write FuFlags;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagDRAGLISTINFOWrapper = class(TatRecordWrapper)
  private
    FuNotification: UINT;
    FhWnd: HWND;
  public
    constructor Create(ARecord: tagDRAGLISTINFO);
    function ObjToRec: tagDRAGLISTINFO;
  published
    property uNotification: UINT read FuNotification write FuNotification;
    property hWnd: HWND read FhWnd write FhWnd;
  end;
  
  _UDACCELWrapper = class(TatRecordWrapper)
  private
    FnSec: UINT;
    FnInc: UINT;
  public
    constructor Create(ARecord: _UDACCEL);
    function ObjToRec: _UDACCEL;
  published
    property nSec: UINT read FnSec write FnSec;
    property nInc: UINT read FnInc write FnInc;
  end;
  
  _NM_UPDOWNWrapper = class(TatRecordWrapper)
  private
    FiPos: Integer;
    FiDelta: Integer;
  public
    constructor Create(ARecord: _NM_UPDOWN);
    function ObjToRec: _NM_UPDOWN;
  published
    property iPos: Integer read FiPos write FiPos;
    property iDelta: Integer read FiDelta write FiDelta;
  end;
  
  PBRANGEWrapper = class(TatRecordWrapper)
  private
    FiLow: Integer;
    FiHigh: Integer;
  public
    constructor Create(ARecord: PBRANGE);
    function ObjToRec: PBRANGE;
  published
    property iLow: Integer read FiLow write FiLow;
    property iHigh: Integer read FiHigh write FiHigh;
  end;
  
  tagLVITEMAWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    FiItem: Integer;
    FiSubItem: Integer;
    Fstate: UINT;
    FstateMask: UINT;
    FcchTextMax: Integer;
    FiImage: Integer;
    FlParam: LPARAM;
    FiIndent: Integer;
  public
    constructor Create(ARecord: tagLVITEMA);
    function ObjToRec: tagLVITEMA;
  published
    property mask: UINT read Fmask write Fmask;
    property iItem: Integer read FiItem write FiItem;
    property iSubItem: Integer read FiSubItem write FiSubItem;
    property state: UINT read Fstate write Fstate;
    property stateMask: UINT read FstateMask write FstateMask;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
    property lParam: LPARAM read FlParam write FlParam;
    property iIndent: Integer read FiIndent write FiIndent;
  end;
  
  tagLVITEMWWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    FiItem: Integer;
    FiSubItem: Integer;
    Fstate: UINT;
    FstateMask: UINT;
    FcchTextMax: Integer;
    FiImage: Integer;
    FlParam: LPARAM;
    FiIndent: Integer;
  public
    constructor Create(ARecord: tagLVITEMW);
    function ObjToRec: tagLVITEMW;
  published
    property mask: UINT read Fmask write Fmask;
    property iItem: Integer read FiItem write FiItem;
    property iSubItem: Integer read FiSubItem write FiSubItem;
    property state: UINT read Fstate write Fstate;
    property stateMask: UINT read FstateMask write FstateMask;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
    property lParam: LPARAM read FlParam write FlParam;
    property iIndent: Integer read FiIndent write FiIndent;
  end;
  
  tagLVFINDINFOAWrapper = class(TatRecordWrapper)
  private
    Fflags: UINT;
    FlParam: LPARAM;
    FvkDirection: UINT;
  public
    constructor Create(ARecord: tagLVFINDINFOA);
    function ObjToRec: tagLVFINDINFOA;
  published
    property flags: UINT read Fflags write Fflags;
    property lParam: LPARAM read FlParam write FlParam;
    property vkDirection: UINT read FvkDirection write FvkDirection;
  end;
  
  tagLVFINDINFOWWrapper = class(TatRecordWrapper)
  private
    Fflags: UINT;
    FlParam: LPARAM;
    FvkDirection: UINT;
  public
    constructor Create(ARecord: tagLVFINDINFOW);
    function ObjToRec: tagLVFINDINFOW;
  published
    property flags: UINT read Fflags write Fflags;
    property lParam: LPARAM read FlParam write FlParam;
    property vkDirection: UINT read FvkDirection write FvkDirection;
  end;
  
  tagLVHITTESTINFOWrapper = class(TatRecordWrapper)
  private
    Fflags: UINT;
    FiItem: Integer;
    FiSubItem: Integer;
  public
    constructor Create(ARecord: tagLVHITTESTINFO);
    function ObjToRec: tagLVHITTESTINFO;
  published
    property flags: UINT read Fflags write Fflags;
    property iItem: Integer read FiItem write FiItem;
    property iSubItem: Integer read FiSubItem write FiSubItem;
  end;
  
  tagLVCOLUMNAWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    Ffmt: Integer;
    Fcx: Integer;
    FcchTextMax: Integer;
    FiSubItem: Integer;
    FiImage: Integer;
    FiOrder: Integer;
  public
    constructor Create(ARecord: tagLVCOLUMNA);
    function ObjToRec: tagLVCOLUMNA;
  published
    property mask: UINT read Fmask write Fmask;
    property fmt: Integer read Ffmt write Ffmt;
    property cx: Integer read Fcx write Fcx;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iSubItem: Integer read FiSubItem write FiSubItem;
    property iImage: Integer read FiImage write FiImage;
    property iOrder: Integer read FiOrder write FiOrder;
  end;
  
  tagLVCOLUMNWWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    Ffmt: Integer;
    Fcx: Integer;
    FcchTextMax: Integer;
    FiSubItem: Integer;
    FiImage: Integer;
    FiOrder: Integer;
  public
    constructor Create(ARecord: tagLVCOLUMNW);
    function ObjToRec: tagLVCOLUMNW;
  published
    property mask: UINT read Fmask write Fmask;
    property fmt: Integer read Ffmt write Ffmt;
    property cx: Integer read Fcx write Fcx;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iSubItem: Integer read FiSubItem write FiSubItem;
    property iImage: Integer read FiImage write FiImage;
    property iOrder: Integer read FiOrder write FiOrder;
  end;
  
  tagLVBKIMAGEAWrapper = class(TatRecordWrapper)
  private
    FulFlags: ULONG;
    Fhbm: HBITMAP;
    FcchImageMax: UINT;
    FxOffsetPercent: Integer;
    FyOffsetPercent: Integer;
  public
    constructor Create(ARecord: tagLVBKIMAGEA);
    function ObjToRec: tagLVBKIMAGEA;
  published
    property ulFlags: ULONG read FulFlags write FulFlags;
    property hbm: HBITMAP read Fhbm write Fhbm;
    property cchImageMax: UINT read FcchImageMax write FcchImageMax;
    property xOffsetPercent: Integer read FxOffsetPercent write FxOffsetPercent;
    property yOffsetPercent: Integer read FyOffsetPercent write FyOffsetPercent;
  end;
  
  tagLVBKIMAGEWWrapper = class(TatRecordWrapper)
  private
    FulFlags: ULONG;
    Fhbm: HBITMAP;
    FcchImageMax: UINT;
    FxOffsetPercent: Integer;
    FyOffsetPercent: Integer;
  public
    constructor Create(ARecord: tagLVBKIMAGEW);
    function ObjToRec: tagLVBKIMAGEW;
  published
    property ulFlags: ULONG read FulFlags write FulFlags;
    property hbm: HBITMAP read Fhbm write Fhbm;
    property cchImageMax: UINT read FcchImageMax write FcchImageMax;
    property xOffsetPercent: Integer read FxOffsetPercent write FxOffsetPercent;
    property yOffsetPercent: Integer read FyOffsetPercent write FyOffsetPercent;
  end;
  
  tagNMLISTVIEWWrapper = class(TatRecordWrapper)
  private
    FiItem: Integer;
    FiSubItem: Integer;
    FuNewState: UINT;
    FuOldState: UINT;
    FuChanged: UINT;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagNMLISTVIEW);
    function ObjToRec: tagNMLISTVIEW;
  published
    property iItem: Integer read FiItem write FiItem;
    property iSubItem: Integer read FiSubItem write FiSubItem;
    property uNewState: UINT read FuNewState write FuNewState;
    property uOldState: UINT read FuOldState write FuOldState;
    property uChanged: UINT read FuChanged write FuChanged;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagNMITEMACTIVATEWrapper = class(TatRecordWrapper)
  private
    FiItem: Integer;
    FiSubItem: Integer;
    FuNewState: UINT;
    FuOldState: UINT;
    FuChanged: UINT;
    FlParam: LPARAM;
    FuKeyFlags: UINT;
  public
    constructor Create(ARecord: tagNMITEMACTIVATE);
    function ObjToRec: tagNMITEMACTIVATE;
  published
    property iItem: Integer read FiItem write FiItem;
    property iSubItem: Integer read FiSubItem write FiSubItem;
    property uNewState: UINT read FuNewState write FuNewState;
    property uOldState: UINT read FuOldState write FuOldState;
    property uChanged: UINT read FuChanged write FuChanged;
    property lParam: LPARAM read FlParam write FlParam;
    property uKeyFlags: UINT read FuKeyFlags write FuKeyFlags;
  end;
  
  tagNMLVCUSTOMDRAWWrapper = class(TatRecordWrapper)
  private
    FclrText: COLORREF;
    FclrTextBk: COLORREF;
    FiSubItem: Integer;
  public
    constructor Create(ARecord: tagNMLVCUSTOMDRAW);
    function ObjToRec: tagNMLVCUSTOMDRAW;
  published
    property clrText: COLORREF read FclrText write FclrText;
    property clrTextBk: COLORREF read FclrTextBk write FclrTextBk;
    property iSubItem: Integer read FiSubItem write FiSubItem;
  end;
  
  tagNMLVCACHEHINTWrapper = class(TatRecordWrapper)
  private
    FiFrom: Integer;
    FiTo: Integer;
  public
    constructor Create(ARecord: tagNMLVCACHEHINT);
    function ObjToRec: tagNMLVCACHEHINT;
  published
    property iFrom: Integer read FiFrom write FiFrom;
    property iTo: Integer read FiTo write FiTo;
  end;
  
  tagNMLVFINDITEMAWrapper = class(TatRecordWrapper)
  private
    FiStart: Integer;
  public
    constructor Create(ARecord: tagNMLVFINDITEMA);
    function ObjToRec: tagNMLVFINDITEMA;
  published
    property iStart: Integer read FiStart write FiStart;
  end;
  
  tagNMLVODSTATECHANGEWrapper = class(TatRecordWrapper)
  private
    FiFrom: Integer;
    FiTo: Integer;
    FuNewState: UINT;
    FuOldState: UINT;
  public
    constructor Create(ARecord: tagNMLVODSTATECHANGE);
    function ObjToRec: tagNMLVODSTATECHANGE;
  published
    property iFrom: Integer read FiFrom write FiFrom;
    property iTo: Integer read FiTo write FiTo;
    property uNewState: UINT read FuNewState write FuNewState;
    property uOldState: UINT read FuOldState write FuOldState;
  end;
  
  tagLVDISPINFOWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagLVDISPINFO);
    function ObjToRec: tagLVDISPINFO;
  published
  end;
  
  tagLVDISPINFOWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagLVDISPINFOW);
    function ObjToRec: tagLVDISPINFOW;
  published
  end;
  
  tagLVKEYDOWNWrapper = class(TatRecordWrapper)
  private
    FwVKey: Word;
    Fflags: UINT;
  public
    constructor Create(ARecord: tagLVKEYDOWN);
    function ObjToRec: tagLVKEYDOWN;
  published
    property wVKey: Word read FwVKey write FwVKey;
    property flags: UINT read Fflags write Fflags;
  end;
  
  tagNMLVGETINFOTIPAWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    FcchTextMax: Integer;
    FiItem: Integer;
    FiSubItem: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagNMLVGETINFOTIPA);
    function ObjToRec: tagNMLVGETINFOTIPA;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iItem: Integer read FiItem write FiItem;
    property iSubItem: Integer read FiSubItem write FiSubItem;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagNMLVGETINFOTIPWWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    FcchTextMax: Integer;
    FiItem: Integer;
    FiSubItem: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagNMLVGETINFOTIPW);
    function ObjToRec: tagNMLVGETINFOTIPW;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iItem: Integer read FiItem write FiItem;
    property iSubItem: Integer read FiSubItem write FiSubItem;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  _TREEITEMWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _TREEITEM);
    function ObjToRec: _TREEITEM;
  published
  end;
  
  tagTVITEMAWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    Fstate: UINT;
    FstateMask: UINT;
    FcchTextMax: Integer;
    FiImage: Integer;
    FiSelectedImage: Integer;
    FcChildren: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagTVITEMA);
    function ObjToRec: tagTVITEMA;
  published
    property mask: UINT read Fmask write Fmask;
    property state: UINT read Fstate write Fstate;
    property stateMask: UINT read FstateMask write FstateMask;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
    property iSelectedImage: Integer read FiSelectedImage write FiSelectedImage;
    property cChildren: Integer read FcChildren write FcChildren;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagTVITEMWWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    Fstate: UINT;
    FstateMask: UINT;
    FcchTextMax: Integer;
    FiImage: Integer;
    FiSelectedImage: Integer;
    FcChildren: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagTVITEMW);
    function ObjToRec: tagTVITEMW;
  published
    property mask: UINT read Fmask write Fmask;
    property state: UINT read Fstate write Fstate;
    property stateMask: UINT read FstateMask write FstateMask;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
    property iSelectedImage: Integer read FiSelectedImage write FiSelectedImage;
    property cChildren: Integer read FcChildren write FcChildren;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagTVITEMEXAWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    Fstate: UINT;
    FstateMask: UINT;
    FcchTextMax: Integer;
    FiImage: Integer;
    FiSelectedImage: Integer;
    FcChildren: Integer;
    FlParam: LPARAM;
    FiIntegral: Integer;
  public
    constructor Create(ARecord: tagTVITEMEXA);
    function ObjToRec: tagTVITEMEXA;
  published
    property mask: UINT read Fmask write Fmask;
    property state: UINT read Fstate write Fstate;
    property stateMask: UINT read FstateMask write FstateMask;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
    property iSelectedImage: Integer read FiSelectedImage write FiSelectedImage;
    property cChildren: Integer read FcChildren write FcChildren;
    property lParam: LPARAM read FlParam write FlParam;
    property iIntegral: Integer read FiIntegral write FiIntegral;
  end;
  
  tagTVITEMEXWWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    Fstate: UINT;
    FstateMask: UINT;
    FcchTextMax: Integer;
    FiImage: Integer;
    FiSelectedImage: Integer;
    FcChildren: Integer;
    FlParam: LPARAM;
    FiIntegral: Integer;
  public
    constructor Create(ARecord: tagTVITEMEXW);
    function ObjToRec: tagTVITEMEXW;
  published
    property mask: UINT read Fmask write Fmask;
    property state: UINT read Fstate write Fstate;
    property stateMask: UINT read FstateMask write FstateMask;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
    property iSelectedImage: Integer read FiSelectedImage write FiSelectedImage;
    property cChildren: Integer read FcChildren write FcChildren;
    property lParam: LPARAM read FlParam write FlParam;
    property iIntegral: Integer read FiIntegral write FiIntegral;
  end;
  
  tagTVINSERTSTRUCTAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagTVINSERTSTRUCTA);
    function ObjToRec: tagTVINSERTSTRUCTA;
  published
  end;
  
  tagTVINSERTSTRUCTWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagTVINSERTSTRUCTW);
    function ObjToRec: tagTVINSERTSTRUCTW;
  published
  end;
  
  tagTVHITTESTINFOWrapper = class(TatRecordWrapper)
  private
    Fflags: UINT;
  public
    constructor Create(ARecord: tagTVHITTESTINFO);
    function ObjToRec: tagTVHITTESTINFO;
  published
    property flags: UINT read Fflags write Fflags;
  end;
  
  tagTVSORTCBWrapper = class(TatRecordWrapper)
  private
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagTVSORTCB);
    function ObjToRec: tagTVSORTCB;
  published
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagNMTREEVIEWAWrapper = class(TatRecordWrapper)
  private
    Faction: UINT;
  public
    constructor Create(ARecord: tagNMTREEVIEWA);
    function ObjToRec: tagNMTREEVIEWA;
  published
    property action: UINT read Faction write Faction;
  end;
  
  tagNMTREEVIEWWWrapper = class(TatRecordWrapper)
  private
    Faction: UINT;
  public
    constructor Create(ARecord: tagNMTREEVIEWW);
    function ObjToRec: tagNMTREEVIEWW;
  published
    property action: UINT read Faction write Faction;
  end;
  
  tagTVDISPINFOAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagTVDISPINFOA);
    function ObjToRec: tagTVDISPINFOA;
  published
  end;
  
  tagTVDISPINFOWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagTVDISPINFOW);
    function ObjToRec: tagTVDISPINFOW;
  published
  end;
  
  tagTVKEYDOWNWrapper = class(TatRecordWrapper)
  private
    FwVKey: Word;
    Fflags: UINT;
  public
    constructor Create(ARecord: tagTVKEYDOWN);
    function ObjToRec: tagTVKEYDOWN;
  published
    property wVKey: Word read FwVKey write FwVKey;
    property flags: UINT read Fflags write Fflags;
  end;
  
  tagNMTVCUSTOMDRAWWrapper = class(TatRecordWrapper)
  private
    FclrText: COLORREF;
    FclrTextBk: COLORREF;
    FiLevel: Integer;
  public
    constructor Create(ARecord: tagNMTVCUSTOMDRAW);
    function ObjToRec: tagNMTVCUSTOMDRAW;
  published
    property clrText: COLORREF read FclrText write FclrText;
    property clrTextBk: COLORREF read FclrTextBk write FclrTextBk;
    property iLevel: Integer read FiLevel write FiLevel;
  end;
  
  tagNMTVGETINFOTIPAWrapper = class(TatRecordWrapper)
  private
    FcchTextMax: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagNMTVGETINFOTIPA);
    function ObjToRec: tagNMTVGETINFOTIPA;
  published
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagNMTVGETINFOTIPWWrapper = class(TatRecordWrapper)
  private
    FcchTextMax: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagNMTVGETINFOTIPW);
    function ObjToRec: tagNMTVGETINFOTIPW;
  published
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagCOMBOBOXEXITEMAWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    FiItem: Integer;
    FcchTextMax: Integer;
    FiImage: Integer;
    FiSelectedImage: Integer;
    FiOverlay: Integer;
    FiIndent: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagCOMBOBOXEXITEMA);
    function ObjToRec: tagCOMBOBOXEXITEMA;
  published
    property mask: UINT read Fmask write Fmask;
    property iItem: Integer read FiItem write FiItem;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
    property iSelectedImage: Integer read FiSelectedImage write FiSelectedImage;
    property iOverlay: Integer read FiOverlay write FiOverlay;
    property iIndent: Integer read FiIndent write FiIndent;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagCOMBOBOXEXITEMWWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    FiItem: Integer;
    FcchTextMax: Integer;
    FiImage: Integer;
    FiSelectedImage: Integer;
    FiOverlay: Integer;
    FiIndent: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagCOMBOBOXEXITEMW);
    function ObjToRec: tagCOMBOBOXEXITEMW;
  published
    property mask: UINT read Fmask write Fmask;
    property iItem: Integer read FiItem write FiItem;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
    property iSelectedImage: Integer read FiSelectedImage write FiSelectedImage;
    property iOverlay: Integer read FiOverlay write FiOverlay;
    property iIndent: Integer read FiIndent write FiIndent;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  NMCOMBOBOXEXAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: NMCOMBOBOXEXA);
    function ObjToRec: NMCOMBOBOXEXA;
  published
  end;
  
  NMCOMBOBOXEXWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: NMCOMBOBOXEXW);
    function ObjToRec: NMCOMBOBOXEXW;
  published
  end;
  
  NMCBEDRAGBEGINAWrapper = class(TatRecordWrapper)
  private
    FiItemid: Integer;
  public
    constructor Create(ARecord: NMCBEDRAGBEGINA);
    function ObjToRec: NMCBEDRAGBEGINA;
  published
    property iItemid: Integer read FiItemid write FiItemid;
  end;
  
  NMCBEDRAGBEGINWWrapper = class(TatRecordWrapper)
  private
    FiItemid: Integer;
  public
    constructor Create(ARecord: NMCBEDRAGBEGINW);
    function ObjToRec: NMCBEDRAGBEGINW;
  published
    property iItemid: Integer read FiItemid write FiItemid;
  end;
  
  NMCBEENDEDITAWrapper = class(TatRecordWrapper)
  private
    FfChanged: BOOL;
    FiNewSelection: Integer;
    FiWhy: Integer;
  public
    constructor Create(ARecord: NMCBEENDEDITA);
    function ObjToRec: NMCBEENDEDITA;
  published
    property fChanged: BOOL read FfChanged write FfChanged;
    property iNewSelection: Integer read FiNewSelection write FiNewSelection;
    property iWhy: Integer read FiWhy write FiWhy;
  end;
  
  NMCBEENDEDITWWrapper = class(TatRecordWrapper)
  private
    FfChanged: BOOL;
    FiNewSelection: Integer;
    FiWhy: Integer;
  public
    constructor Create(ARecord: NMCBEENDEDITW);
    function ObjToRec: NMCBEENDEDITW;
  published
    property fChanged: BOOL read FfChanged write FfChanged;
    property iNewSelection: Integer read FiNewSelection write FiNewSelection;
    property iWhy: Integer read FiWhy write FiWhy;
  end;
  
  tagTCITEMHEADERAWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    FlpReserved1: UINT;
    FlpReserved2: UINT;
    FcchTextMax: Integer;
    FiImage: Integer;
  public
    constructor Create(ARecord: tagTCITEMHEADERA);
    function ObjToRec: tagTCITEMHEADERA;
  published
    property mask: UINT read Fmask write Fmask;
    property lpReserved1: UINT read FlpReserved1 write FlpReserved1;
    property lpReserved2: UINT read FlpReserved2 write FlpReserved2;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
  end;
  
  tagTCITEMHEADERWWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    FlpReserved1: UINT;
    FlpReserved2: UINT;
    FcchTextMax: Integer;
    FiImage: Integer;
  public
    constructor Create(ARecord: tagTCITEMHEADERW);
    function ObjToRec: tagTCITEMHEADERW;
  published
    property mask: UINT read Fmask write Fmask;
    property lpReserved1: UINT read FlpReserved1 write FlpReserved1;
    property lpReserved2: UINT read FlpReserved2 write FlpReserved2;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
  end;
  
  tagTCITEMAWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    FdwState: UINT;
    FdwStateMask: UINT;
    FcchTextMax: Integer;
    FiImage: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagTCITEMA);
    function ObjToRec: tagTCITEMA;
  published
    property mask: UINT read Fmask write Fmask;
    property dwState: UINT read FdwState write FdwState;
    property dwStateMask: UINT read FdwStateMask write FdwStateMask;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagTCITEMWWrapper = class(TatRecordWrapper)
  private
    Fmask: UINT;
    FdwState: UINT;
    FdwStateMask: UINT;
    FcchTextMax: Integer;
    FiImage: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagTCITEMW);
    function ObjToRec: tagTCITEMW;
  published
    property mask: UINT read Fmask write Fmask;
    property dwState: UINT read FdwState write FdwState;
    property dwStateMask: UINT read FdwStateMask write FdwStateMask;
    property cchTextMax: Integer read FcchTextMax write FcchTextMax;
    property iImage: Integer read FiImage write FiImage;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagTCHITTESTINFOWrapper = class(TatRecordWrapper)
  private
    Fflags: UINT;
  public
    constructor Create(ARecord: tagTCHITTESTINFO);
    function ObjToRec: tagTCHITTESTINFO;
  published
    property flags: UINT read Fflags write Fflags;
  end;
  
  tagTCKEYDOWNWrapper = class(TatRecordWrapper)
  private
    FwVKey: Word;
    Fflags: UINT;
  public
    constructor Create(ARecord: tagTCKEYDOWN);
    function ObjToRec: tagTCKEYDOWN;
  published
    property wVKey: Word read FwVKey write FwVKey;
    property flags: UINT read Fflags write Fflags;
  end;
  
  MCHITTESTINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FuHit: UINT;
  public
    constructor Create(ARecord: MCHITTESTINFO);
    function ObjToRec: MCHITTESTINFO;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property uHit: UINT read FuHit write FuHit;
  end;
  
  tagNMSELCHANGEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagNMSELCHANGE);
    function ObjToRec: tagNMSELCHANGE;
  published
  end;
  
  tagNMDAYSTATEWrapper = class(TatRecordWrapper)
  private
    FcDayState: Integer;
  public
    constructor Create(ARecord: tagNMDAYSTATE);
    function ObjToRec: tagNMDAYSTATE;
  published
    property cDayState: Integer read FcDayState write FcDayState;
  end;
  
  tagNMDATETIMECHANGEWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagNMDATETIMECHANGE);
    function ObjToRec: tagNMDATETIMECHANGE;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagNMDATETIMESTRINGAWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagNMDATETIMESTRINGA);
    function ObjToRec: tagNMDATETIMESTRINGA;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagNMDATETIMESTRINGWWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagNMDATETIMESTRINGW);
    function ObjToRec: tagNMDATETIMESTRINGW;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagNMDATETIMEWMKEYDOWNAWrapper = class(TatRecordWrapper)
  private
    FnVirtKey: Integer;
  public
    constructor Create(ARecord: tagNMDATETIMEWMKEYDOWNA);
    function ObjToRec: tagNMDATETIMEWMKEYDOWNA;
  published
    property nVirtKey: Integer read FnVirtKey write FnVirtKey;
  end;
  
  tagNMDATETIMEWMKEYDOWNWWrapper = class(TatRecordWrapper)
  private
    FnVirtKey: Integer;
  public
    constructor Create(ARecord: tagNMDATETIMEWMKEYDOWNW);
    function ObjToRec: tagNMDATETIMEWMKEYDOWNW;
  published
    property nVirtKey: Integer read FnVirtKey write FnVirtKey;
  end;
  
  tagNMDATETIMEFORMATAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagNMDATETIMEFORMATA);
    function ObjToRec: tagNMDATETIMEFORMATA;
  published
  end;
  
  tagNMDATETIMEFORMATWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagNMDATETIMEFORMATW);
    function ObjToRec: tagNMDATETIMEFORMATW;
  published
  end;
  
  tagNMDATETIMEFORMATQUERYAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagNMDATETIMEFORMATQUERYA);
    function ObjToRec: tagNMDATETIMEFORMATQUERYA;
  published
  end;
  
  tagNMDATETIMEFORMATQUERYWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagNMDATETIMEFORMATQUERYW);
    function ObjToRec: tagNMDATETIMEFORMATQUERYW;
  published
  end;
  
  tagNMIPADDRESSWrapper = class(TatRecordWrapper)
  private
    FiField: Integer;
    FiValue: Integer;
  public
    constructor Create(ARecord: tagNMIPADDRESS);
    function ObjToRec: tagNMIPADDRESS;
  published
    property iField: Integer read FiField write FiField;
    property iValue: Integer read FiValue write FiValue;
  end;
  
  NMPGSCROLLWrapper = class(TatRecordWrapper)
  private
    FfwKeys: Word;
    FiDir: Integer;
    FiXpos: Integer;
    FiYpos: Integer;
    FiScroll: Integer;
  public
    constructor Create(ARecord: NMPGSCROLL);
    function ObjToRec: NMPGSCROLL;
  published
    property fwKeys: Word read FfwKeys write FfwKeys;
    property iDir: Integer read FiDir write FiDir;
    property iXpos: Integer read FiXpos write FiXpos;
    property iYpos: Integer read FiYpos write FiYpos;
    property iScroll: Integer read FiScroll write FiScroll;
  end;
  
  NMPGCALCSIZEWrapper = class(TatRecordWrapper)
  private
    FdwFlag: DWORD;
    FiWidth: Integer;
    FiHeight: Integer;
  public
    constructor Create(ARecord: NMPGCALCSIZE);
    function ObjToRec: NMPGCALCSIZE;
  published
    property dwFlag: DWORD read FdwFlag write FdwFlag;
    property iWidth: Integer read FiWidth write FiWidth;
    property iHeight: Integer read FiHeight write FiHeight;
  end;
  
  tagTRACKMOUSEEVENTWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwFlags: DWORD;
    FhwndTrack: HWND;
    FdwHoverTime: DWORD;
  public
    constructor Create(ARecord: tagTRACKMOUSEEVENT);
    function ObjToRec: tagTRACKMOUSEEVENT;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property hwndTrack: HWND read FhwndTrack write FhwndTrack;
    property dwHoverTime: DWORD read FdwHoverTime write FdwHoverTime;
  end;
  

implementation

constructor _PROPSHEETPAGEAWrapper.Create(ARecord: _PROPSHEETPAGEA);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwFlags := ARecord.dwFlags;
  FhInstance := ARecord.hInstance;
  FhIcon := ARecord.hIcon;
  FlParam := ARecord.lParam;
end;

function _PROPSHEETPAGEAWrapper.ObjToRec: _PROPSHEETPAGEA;
begin
  result.dwSize := FdwSize;
  result.dwFlags := FdwFlags;
  result.hInstance := FhInstance;
  result.hIcon := FhIcon;
  result.lParam := FlParam;
end;

constructor _PROPSHEETPAGEWWrapper.Create(ARecord: _PROPSHEETPAGEW);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwFlags := ARecord.dwFlags;
  FhInstance := ARecord.hInstance;
  FhIcon := ARecord.hIcon;
  FlParam := ARecord.lParam;
end;

function _PROPSHEETPAGEWWrapper.ObjToRec: _PROPSHEETPAGEW;
begin
  result.dwSize := FdwSize;
  result.dwFlags := FdwFlags;
  result.hInstance := FhInstance;
  result.hIcon := FhIcon;
  result.lParam := FlParam;
end;

constructor _PROPSHEETHEADERAWrapper.Create(ARecord: _PROPSHEETHEADERA);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwFlags := ARecord.dwFlags;
  FhwndParent := ARecord.hwndParent;
  FhInstance := ARecord.hInstance;
  FhIcon := ARecord.hIcon;
  FnPages := ARecord.nPages;
  FnStartPage := ARecord.nStartPage;
  FhbmWatermark := ARecord.hbmWatermark;
  FhplWatermark := ARecord.hplWatermark;
  FhbmHeader := ARecord.hbmHeader;
end;

function _PROPSHEETHEADERAWrapper.ObjToRec: _PROPSHEETHEADERA;
begin
  result.dwSize := FdwSize;
  result.dwFlags := FdwFlags;
  result.hwndParent := FhwndParent;
  result.hInstance := FhInstance;
  result.hIcon := FhIcon;
  result.nPages := FnPages;
  result.nStartPage := FnStartPage;
  result.hbmWatermark := FhbmWatermark;
  result.hplWatermark := FhplWatermark;
  result.hbmHeader := FhbmHeader;
end;

constructor _PROPSHEETHEADERWWrapper.Create(ARecord: _PROPSHEETHEADERW);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwFlags := ARecord.dwFlags;
  FhwndParent := ARecord.hwndParent;
  FhInstance := ARecord.hInstance;
  FhIcon := ARecord.hIcon;
  FnPages := ARecord.nPages;
  FnStartPage := ARecord.nStartPage;
  FhbmWatermark := ARecord.hbmWatermark;
  FhplWatermark := ARecord.hplWatermark;
  FhbmHeader := ARecord.hbmHeader;
end;

function _PROPSHEETHEADERWWrapper.ObjToRec: _PROPSHEETHEADERW;
begin
  result.dwSize := FdwSize;
  result.dwFlags := FdwFlags;
  result.hwndParent := FhwndParent;
  result.hInstance := FhInstance;
  result.hIcon := FhIcon;
  result.nPages := FnPages;
  result.nStartPage := FnStartPage;
  result.hbmWatermark := FhbmWatermark;
  result.hplWatermark := FhplWatermark;
  result.hbmHeader := FhbmHeader;
end;

constructor tagINITCOMMONCONTROLSEXWrapper.Create(ARecord: tagINITCOMMONCONTROLSEX);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwICC := ARecord.dwICC;
end;

function tagINITCOMMONCONTROLSEXWrapper.ObjToRec: tagINITCOMMONCONTROLSEX;
begin
  result.dwSize := FdwSize;
  result.dwICC := FdwICC;
end;

constructor tagCOLORSCHEMEWrapper.Create(ARecord: tagCOLORSCHEME);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FclrBtnHighlight := ARecord.clrBtnHighlight;
  FclrBtnShadow := ARecord.clrBtnShadow;
end;

function tagCOLORSCHEMEWrapper.ObjToRec: tagCOLORSCHEME;
begin
  result.dwSize := FdwSize;
  result.clrBtnHighlight := FclrBtnHighlight;
  result.clrBtnShadow := FclrBtnShadow;
end;

constructor tagNMMOUSEWrapper.Create(ARecord: tagNMMOUSE);
begin
  inherited Create;
  FdwItemSpec := ARecord.dwItemSpec;
  FdwItemData := ARecord.dwItemData;
  FdwHitInfo := ARecord.dwHitInfo;
end;

function tagNMMOUSEWrapper.ObjToRec: tagNMMOUSE;
begin
  result.dwItemSpec := FdwItemSpec;
  result.dwItemData := FdwItemData;
  result.dwHitInfo := FdwHitInfo;
end;

constructor tagNMOBJECTNOTIFYWrapper.Create(ARecord: tagNMOBJECTNOTIFY);
begin
  inherited Create;
  FiItem := ARecord.iItem;
  FhResult := ARecord.hResult;
  FdwFlags := ARecord.dwFlags;
end;

function tagNMOBJECTNOTIFYWrapper.ObjToRec: tagNMOBJECTNOTIFY;
begin
  result.iItem := FiItem;
  result.hResult := FhResult;
  result.dwFlags := FdwFlags;
end;

constructor tagNMKEYWrapper.Create(ARecord: tagNMKEY);
begin
  inherited Create;
  FnVKey := ARecord.nVKey;
  FuFlags := ARecord.uFlags;
end;

function tagNMKEYWrapper.ObjToRec: tagNMKEY;
begin
  result.nVKey := FnVKey;
  result.uFlags := FuFlags;
end;

constructor tagNMCHARWrapper.Create(ARecord: tagNMCHAR);
begin
  inherited Create;
  Fch := ARecord.ch;
  FdwItemPrev := ARecord.dwItemPrev;
  FdwItemNext := ARecord.dwItemNext;
end;

function tagNMCHARWrapper.ObjToRec: tagNMCHAR;
begin
  result.ch := Fch;
  result.dwItemPrev := FdwItemPrev;
  result.dwItemNext := FdwItemNext;
end;

constructor tagNMCUSTOMDRAWINFOWrapper.Create(ARecord: tagNMCUSTOMDRAWINFO);
begin
  inherited Create;
  FdwDrawStage := ARecord.dwDrawStage;
  Fhdc := ARecord.hdc;
  FdwItemSpec := ARecord.dwItemSpec;
  FuItemState := ARecord.uItemState;
  FlItemlParam := ARecord.lItemlParam;
end;

function tagNMCUSTOMDRAWINFOWrapper.ObjToRec: tagNMCUSTOMDRAWINFO;
begin
  result.dwDrawStage := FdwDrawStage;
  result.hdc := Fhdc;
  result.dwItemSpec := FdwItemSpec;
  result.uItemState := FuItemState;
  result.lItemlParam := FlItemlParam;
end;

constructor tagNMTTCUSTOMDRAWWrapper.Create(ARecord: tagNMTTCUSTOMDRAW);
begin
  inherited Create;
  FuDrawFlags := ARecord.uDrawFlags;
end;

function tagNMTTCUSTOMDRAWWrapper.ObjToRec: tagNMTTCUSTOMDRAW;
begin
  result.uDrawFlags := FuDrawFlags;
end;

constructor _IMAGELISTDRAWPARAMSWrapper.Create(ARecord: _IMAGELISTDRAWPARAMS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  Fhiml := ARecord.himl;
  Fi := ARecord.i;
  FhdcDst := ARecord.hdcDst;
  Fx := ARecord.x;
  Fy := ARecord.y;
  Fcx := ARecord.cx;
  Fcy := ARecord.cy;
  FxBitmap := ARecord.xBitmap;
  FyBitmap := ARecord.yBitmap;
  FrgbBk := ARecord.rgbBk;
  FrgbFg := ARecord.rgbFg;
  FfStyle := ARecord.fStyle;
  FdwRop := ARecord.dwRop;
end;

function _IMAGELISTDRAWPARAMSWrapper.ObjToRec: _IMAGELISTDRAWPARAMS;
begin
  result.cbSize := FcbSize;
  result.himl := Fhiml;
  result.i := Fi;
  result.hdcDst := FhdcDst;
  result.x := Fx;
  result.y := Fy;
  result.cx := Fcx;
  result.cy := Fcy;
  result.xBitmap := FxBitmap;
  result.yBitmap := FyBitmap;
  result.rgbBk := FrgbBk;
  result.rgbFg := FrgbFg;
  result.fStyle := FfStyle;
  result.dwRop := FdwRop;
end;

constructor _IMAGEINFOWrapper.Create(ARecord: _IMAGEINFO);
begin
  inherited Create;
  FhbmImage := ARecord.hbmImage;
  FhbmMask := ARecord.hbmMask;
  FUnused1 := ARecord.Unused1;
  FUnused2 := ARecord.Unused2;
end;

function _IMAGEINFOWrapper.ObjToRec: _IMAGEINFO;
begin
  result.hbmImage := FhbmImage;
  result.hbmMask := FhbmMask;
  result.Unused1 := FUnused1;
  result.Unused2 := FUnused2;
end;

constructor _HD_ITEMAWrapper.Create(ARecord: _HD_ITEMA);
begin
  inherited Create;
  FMask := ARecord.Mask;
  Fcxy := ARecord.cxy;
  Fhbm := ARecord.hbm;
  FcchTextMax := ARecord.cchTextMax;
  Ffmt := ARecord.fmt;
  FlParam := ARecord.lParam;
  FiImage := ARecord.iImage;
  FiOrder := ARecord.iOrder;
end;

function _HD_ITEMAWrapper.ObjToRec: _HD_ITEMA;
begin
  result.Mask := FMask;
  result.cxy := Fcxy;
  result.hbm := Fhbm;
  result.cchTextMax := FcchTextMax;
  result.fmt := Ffmt;
  result.lParam := FlParam;
  result.iImage := FiImage;
  result.iOrder := FiOrder;
end;

constructor _HD_ITEMWWrapper.Create(ARecord: _HD_ITEMW);
begin
  inherited Create;
  FMask := ARecord.Mask;
  Fcxy := ARecord.cxy;
  Fhbm := ARecord.hbm;
  FcchTextMax := ARecord.cchTextMax;
  Ffmt := ARecord.fmt;
  FlParam := ARecord.lParam;
  FiImage := ARecord.iImage;
  FiOrder := ARecord.iOrder;
end;

function _HD_ITEMWWrapper.ObjToRec: _HD_ITEMW;
begin
  result.Mask := FMask;
  result.cxy := Fcxy;
  result.hbm := Fhbm;
  result.cchTextMax := FcchTextMax;
  result.fmt := Ffmt;
  result.lParam := FlParam;
  result.iImage := FiImage;
  result.iOrder := FiOrder;
end;

constructor _HD_LAYOUTWrapper.Create(ARecord: _HD_LAYOUT);
begin
  inherited Create;
end;

function _HD_LAYOUTWrapper.ObjToRec: _HD_LAYOUT;
begin
end;

constructor _HD_HITTESTINFOWrapper.Create(ARecord: _HD_HITTESTINFO);
begin
  inherited Create;
  FFlags := ARecord.Flags;
  FItem := ARecord.Item;
end;

function _HD_HITTESTINFOWrapper.ObjToRec: _HD_HITTESTINFO;
begin
  result.Flags := FFlags;
  result.Item := FItem;
end;

constructor tagNMHEADERAWrapper.Create(ARecord: tagNMHEADERA);
begin
  inherited Create;
  FItem := ARecord.Item;
  FButton := ARecord.Button;
end;

function tagNMHEADERAWrapper.ObjToRec: tagNMHEADERA;
begin
  result.Item := FItem;
  result.Button := FButton;
end;

constructor tagNMHEADERWWrapper.Create(ARecord: tagNMHEADERW);
begin
  inherited Create;
  FItem := ARecord.Item;
  FButton := ARecord.Button;
end;

function tagNMHEADERWWrapper.ObjToRec: tagNMHEADERW;
begin
  result.Item := FItem;
  result.Button := FButton;
end;

constructor tagNMHDDISPINFOAWrapper.Create(ARecord: tagNMHDDISPINFOA);
begin
  inherited Create;
  FiItem := ARecord.iItem;
  Fmask := ARecord.mask;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
  FlParam := ARecord.lParam;
end;

function tagNMHDDISPINFOAWrapper.ObjToRec: tagNMHDDISPINFOA;
begin
  result.iItem := FiItem;
  result.mask := Fmask;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
  result.lParam := FlParam;
end;

constructor tagNMHDDISPINFOWWrapper.Create(ARecord: tagNMHDDISPINFOW);
begin
  inherited Create;
  FiItem := ARecord.iItem;
  Fmask := ARecord.mask;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
  FlParam := ARecord.lParam;
end;

function tagNMHDDISPINFOWWrapper.ObjToRec: tagNMHDDISPINFOW;
begin
  result.iItem := FiItem;
  result.mask := Fmask;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
  result.lParam := FlParam;
end;

constructor _TBBUTTONWrapper.Create(ARecord: _TBBUTTON);
begin
  inherited Create;
  FiBitmap := ARecord.iBitmap;
  FidCommand := ARecord.idCommand;
  FfsState := ARecord.fsState;
  FfsStyle := ARecord.fsStyle;
  FdwData := ARecord.dwData;
  FiString := ARecord.iString;
end;

function _TBBUTTONWrapper.ObjToRec: _TBBUTTON;
begin
  result.iBitmap := FiBitmap;
  result.idCommand := FidCommand;
  result.fsState := FfsState;
  result.fsStyle := FfsStyle;
  result.dwData := FdwData;
  result.iString := FiString;
end;

constructor _COLORMAPWrapper.Create(ARecord: _COLORMAP);
begin
  inherited Create;
  FcFrom := ARecord.cFrom;
  FcTo := ARecord.cTo;
end;

function _COLORMAPWrapper.ObjToRec: _COLORMAP;
begin
  result.cFrom := FcFrom;
  result.cTo := FcTo;
end;

constructor _NMTBCUSTOMDRAWWrapper.Create(ARecord: _NMTBCUSTOMDRAW);
begin
  inherited Create;
  FhbrMonoDither := ARecord.hbrMonoDither;
  FhbrLines := ARecord.hbrLines;
  FhpenLines := ARecord.hpenLines;
  FclrText := ARecord.clrText;
  FclrMark := ARecord.clrMark;
  FclrTextHighlight := ARecord.clrTextHighlight;
  FclrBtnFace := ARecord.clrBtnFace;
  FclrBtnHighlight := ARecord.clrBtnHighlight;
  FclrHighlightHotTrack := ARecord.clrHighlightHotTrack;
  FnStringBkMode := ARecord.nStringBkMode;
  FnHLStringBkMode := ARecord.nHLStringBkMode;
end;

function _NMTBCUSTOMDRAWWrapper.ObjToRec: _NMTBCUSTOMDRAW;
begin
  result.hbrMonoDither := FhbrMonoDither;
  result.hbrLines := FhbrLines;
  result.hpenLines := FhpenLines;
  result.clrText := FclrText;
  result.clrMark := FclrMark;
  result.clrTextHighlight := FclrTextHighlight;
  result.clrBtnFace := FclrBtnFace;
  result.clrBtnHighlight := FclrBtnHighlight;
  result.clrHighlightHotTrack := FclrHighlightHotTrack;
  result.nStringBkMode := FnStringBkMode;
  result.nHLStringBkMode := FnHLStringBkMode;
end;

constructor tagTBADDBITMAPWrapper.Create(ARecord: tagTBADDBITMAP);
begin
  inherited Create;
  FhInst := ARecord.hInst;
  FnID := ARecord.nID;
end;

function tagTBADDBITMAPWrapper.ObjToRec: tagTBADDBITMAP;
begin
  result.hInst := FhInst;
  result.nID := FnID;
end;

constructor tagTBSAVEPARAMSAWrapper.Create(ARecord: tagTBSAVEPARAMSA);
begin
  inherited Create;
  Fhkr := ARecord.hkr;
end;

function tagTBSAVEPARAMSAWrapper.ObjToRec: tagTBSAVEPARAMSA;
begin
  result.hkr := Fhkr;
end;

constructor tagTBSAVEPARAMSWWrapper.Create(ARecord: tagTBSAVEPARAMSW);
begin
  inherited Create;
  Fhkr := ARecord.hkr;
end;

function tagTBSAVEPARAMSWWrapper.ObjToRec: tagTBSAVEPARAMSW;
begin
  result.hkr := Fhkr;
end;

constructor TBINSERTMARKWrapper.Create(ARecord: TBINSERTMARK);
begin
  inherited Create;
  FiButton := ARecord.iButton;
  FdwFlags := ARecord.dwFlags;
end;

function TBINSERTMARKWrapper.ObjToRec: TBINSERTMARK;
begin
  result.iButton := FiButton;
  result.dwFlags := FdwFlags;
end;

constructor TBREPLACEBITMAPWrapper.Create(ARecord: TBREPLACEBITMAP);
begin
  inherited Create;
  FhInstOld := ARecord.hInstOld;
  FnIDOld := ARecord.nIDOld;
  FhInstNew := ARecord.hInstNew;
  FnIDNew := ARecord.nIDNew;
  FnButtons := ARecord.nButtons;
end;

function TBREPLACEBITMAPWrapper.ObjToRec: TBREPLACEBITMAP;
begin
  result.hInstOld := FhInstOld;
  result.nIDOld := FnIDOld;
  result.hInstNew := FhInstNew;
  result.nIDNew := FnIDNew;
  result.nButtons := FnButtons;
end;

constructor TBBUTTONINFOAWrapper.Create(ARecord: TBBUTTONINFOA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwMask := ARecord.dwMask;
  FidCommand := ARecord.idCommand;
  FiImage := ARecord.iImage;
  FfsState := ARecord.fsState;
  FfsStyle := ARecord.fsStyle;
  Fcx := ARecord.cx;
  FlParam := ARecord.lParam;
  FcchText := ARecord.cchText;
end;

function TBBUTTONINFOAWrapper.ObjToRec: TBBUTTONINFOA;
begin
  result.cbSize := FcbSize;
  result.dwMask := FdwMask;
  result.idCommand := FidCommand;
  result.iImage := FiImage;
  result.fsState := FfsState;
  result.fsStyle := FfsStyle;
  result.cx := Fcx;
  result.lParam := FlParam;
  result.cchText := FcchText;
end;

constructor TBBUTTONINFOWWrapper.Create(ARecord: TBBUTTONINFOW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwMask := ARecord.dwMask;
  FidCommand := ARecord.idCommand;
  FiImage := ARecord.iImage;
  FfsState := ARecord.fsState;
  FfsStyle := ARecord.fsStyle;
  Fcx := ARecord.cx;
  FlParam := ARecord.lParam;
  FcchText := ARecord.cchText;
end;

function TBBUTTONINFOWWrapper.ObjToRec: TBBUTTONINFOW;
begin
  result.cbSize := FcbSize;
  result.dwMask := FdwMask;
  result.idCommand := FidCommand;
  result.iImage := FiImage;
  result.fsState := FfsState;
  result.fsStyle := FfsStyle;
  result.cx := Fcx;
  result.lParam := FlParam;
  result.cchText := FcchText;
end;

constructor tagNMTBHOTITEMWrapper.Create(ARecord: tagNMTBHOTITEM);
begin
  inherited Create;
  FidOld := ARecord.idOld;
  FidNew := ARecord.idNew;
  FdwFlags := ARecord.dwFlags;
end;

function tagNMTBHOTITEMWrapper.ObjToRec: tagNMTBHOTITEM;
begin
  result.idOld := FidOld;
  result.idNew := FidNew;
  result.dwFlags := FdwFlags;
end;

constructor tagNMTBGETINFOTIPAWrapper.Create(ARecord: tagNMTBGETINFOTIPA);
begin
  inherited Create;
  FcchTextMax := ARecord.cchTextMax;
  FiItem := ARecord.iItem;
  FlParam := ARecord.lParam;
end;

function tagNMTBGETINFOTIPAWrapper.ObjToRec: tagNMTBGETINFOTIPA;
begin
  result.cchTextMax := FcchTextMax;
  result.iItem := FiItem;
  result.lParam := FlParam;
end;

constructor tagNMTBGETINFOTIPWWrapper.Create(ARecord: tagNMTBGETINFOTIPW);
begin
  inherited Create;
  FcchTextMax := ARecord.cchTextMax;
  FiItem := ARecord.iItem;
  FlParam := ARecord.lParam;
end;

function tagNMTBGETINFOTIPWWrapper.ObjToRec: tagNMTBGETINFOTIPW;
begin
  result.cchTextMax := FcchTextMax;
  result.iItem := FiItem;
  result.lParam := FlParam;
end;

constructor NMTBDISPINFOAWrapper.Create(ARecord: NMTBDISPINFOA);
begin
  inherited Create;
  FdwMask := ARecord.dwMask;
  FidCommand := ARecord.idCommand;
  FlParam := ARecord.lParam;
  FiImage := ARecord.iImage;
  FcchText := ARecord.cchText;
end;

function NMTBDISPINFOAWrapper.ObjToRec: NMTBDISPINFOA;
begin
  result.dwMask := FdwMask;
  result.idCommand := FidCommand;
  result.lParam := FlParam;
  result.iImage := FiImage;
  result.cchText := FcchText;
end;

constructor NMTBDISPINFOWWrapper.Create(ARecord: NMTBDISPINFOW);
begin
  inherited Create;
  FdwMask := ARecord.dwMask;
  FidCommand := ARecord.idCommand;
  FlParam := ARecord.lParam;
  FiImage := ARecord.iImage;
  FcchText := ARecord.cchText;
end;

function NMTBDISPINFOWWrapper.ObjToRec: NMTBDISPINFOW;
begin
  result.dwMask := FdwMask;
  result.idCommand := FidCommand;
  result.lParam := FlParam;
  result.iImage := FiImage;
  result.cchText := FcchText;
end;

constructor tagNMTOOLBARAWrapper.Create(ARecord: tagNMTOOLBARA);
begin
  inherited Create;
  FiItem := ARecord.iItem;
  FcchText := ARecord.cchText;
end;

function tagNMTOOLBARAWrapper.ObjToRec: tagNMTOOLBARA;
begin
  result.iItem := FiItem;
  result.cchText := FcchText;
end;

constructor tagNMTOOLBARWWrapper.Create(ARecord: tagNMTOOLBARW);
begin
  inherited Create;
  FiItem := ARecord.iItem;
  FcchText := ARecord.cchText;
end;

function tagNMTOOLBARWWrapper.ObjToRec: tagNMTOOLBARW;
begin
  result.iItem := FiItem;
  result.cchText := FcchText;
end;

constructor tagREBARINFOWrapper.Create(ARecord: tagREBARINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  Fhiml := ARecord.himl;
end;

function tagREBARINFOWrapper.ObjToRec: tagREBARINFO;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.himl := Fhiml;
end;

constructor tagREBARBANDINFOAWrapper.Create(ARecord: tagREBARBANDINFOA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  FfStyle := ARecord.fStyle;
  FclrFore := ARecord.clrFore;
  FclrBack := ARecord.clrBack;
  Fcch := ARecord.cch;
  FiImage := ARecord.iImage;
  FhwndChild := ARecord.hwndChild;
  FcxMinChild := ARecord.cxMinChild;
  FcyMinChild := ARecord.cyMinChild;
  Fcx := ARecord.cx;
  FhbmBack := ARecord.hbmBack;
  FwID := ARecord.wID;
  FcyChild := ARecord.cyChild;
  FcyMaxChild := ARecord.cyMaxChild;
  FcyIntegral := ARecord.cyIntegral;
  FcxIdeal := ARecord.cxIdeal;
  FlParam := ARecord.lParam;
  FcxHeader := ARecord.cxHeader;
end;

function tagREBARBANDINFOAWrapper.ObjToRec: tagREBARBANDINFOA;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.fStyle := FfStyle;
  result.clrFore := FclrFore;
  result.clrBack := FclrBack;
  result.cch := Fcch;
  result.iImage := FiImage;
  result.hwndChild := FhwndChild;
  result.cxMinChild := FcxMinChild;
  result.cyMinChild := FcyMinChild;
  result.cx := Fcx;
  result.hbmBack := FhbmBack;
  result.wID := FwID;
  result.cyChild := FcyChild;
  result.cyMaxChild := FcyMaxChild;
  result.cyIntegral := FcyIntegral;
  result.cxIdeal := FcxIdeal;
  result.lParam := FlParam;
  result.cxHeader := FcxHeader;
end;

constructor tagREBARBANDINFOWWrapper.Create(ARecord: tagREBARBANDINFOW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  FfStyle := ARecord.fStyle;
  FclrFore := ARecord.clrFore;
  FclrBack := ARecord.clrBack;
  Fcch := ARecord.cch;
  FiImage := ARecord.iImage;
  FhwndChild := ARecord.hwndChild;
  FcxMinChild := ARecord.cxMinChild;
  FcyMinChild := ARecord.cyMinChild;
  Fcx := ARecord.cx;
  FhbmBack := ARecord.hbmBack;
  FwID := ARecord.wID;
  FcyChild := ARecord.cyChild;
  FcyMaxChild := ARecord.cyMaxChild;
  FcyIntegral := ARecord.cyIntegral;
  FcxIdeal := ARecord.cxIdeal;
  FlParam := ARecord.lParam;
  FcxHeader := ARecord.cxHeader;
end;

function tagREBARBANDINFOWWrapper.ObjToRec: tagREBARBANDINFOW;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.fStyle := FfStyle;
  result.clrFore := FclrFore;
  result.clrBack := FclrBack;
  result.cch := Fcch;
  result.iImage := FiImage;
  result.hwndChild := FhwndChild;
  result.cxMinChild := FcxMinChild;
  result.cyMinChild := FcyMinChild;
  result.cx := Fcx;
  result.hbmBack := FhbmBack;
  result.wID := FwID;
  result.cyChild := FcyChild;
  result.cyMaxChild := FcyMaxChild;
  result.cyIntegral := FcyIntegral;
  result.cxIdeal := FcxIdeal;
  result.lParam := FlParam;
  result.cxHeader := FcxHeader;
end;

constructor tagNMREBARCHILDSIZEWrapper.Create(ARecord: tagNMREBARCHILDSIZE);
begin
  inherited Create;
  FuBand := ARecord.uBand;
  FwID := ARecord.wID;
end;

function tagNMREBARCHILDSIZEWrapper.ObjToRec: tagNMREBARCHILDSIZE;
begin
  result.uBand := FuBand;
  result.wID := FwID;
end;

constructor tagNMREBARWrapper.Create(ARecord: tagNMREBAR);
begin
  inherited Create;
  FdwMask := ARecord.dwMask;
  FuBand := ARecord.uBand;
  FfStyle := ARecord.fStyle;
  FwID := ARecord.wID;
  FlParam := ARecord.lParam;
end;

function tagNMREBARWrapper.ObjToRec: tagNMREBAR;
begin
  result.dwMask := FdwMask;
  result.uBand := FuBand;
  result.fStyle := FfStyle;
  result.wID := FwID;
  result.lParam := FlParam;
end;

constructor tagNMRBAUTOSIZEWrapper.Create(ARecord: tagNMRBAUTOSIZE);
begin
  inherited Create;
  FfChanged := ARecord.fChanged;
end;

function tagNMRBAUTOSIZEWrapper.ObjToRec: tagNMRBAUTOSIZE;
begin
  result.fChanged := FfChanged;
end;

constructor _RB_HITTESTINFOWrapper.Create(ARecord: _RB_HITTESTINFO);
begin
  inherited Create;
  Fflags := ARecord.flags;
  FiBand := ARecord.iBand;
end;

function _RB_HITTESTINFOWrapper.ObjToRec: _RB_HITTESTINFO;
begin
  result.flags := Fflags;
  result.iBand := FiBand;
end;

constructor tagTOOLINFOAWrapper.Create(ARecord: tagTOOLINFOA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FuFlags := ARecord.uFlags;
  Fhwnd := ARecord.hwnd;
  FuId := ARecord.uId;
  FhInst := ARecord.hInst;
  FlParam := ARecord.lParam;
end;

function tagTOOLINFOAWrapper.ObjToRec: tagTOOLINFOA;
begin
  result.cbSize := FcbSize;
  result.uFlags := FuFlags;
  result.hwnd := Fhwnd;
  result.uId := FuId;
  result.hInst := FhInst;
  result.lParam := FlParam;
end;

constructor tagTOOLINFOWWrapper.Create(ARecord: tagTOOLINFOW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FuFlags := ARecord.uFlags;
  Fhwnd := ARecord.hwnd;
  FuId := ARecord.uId;
  FhInst := ARecord.hInst;
  FlParam := ARecord.lParam;
end;

function tagTOOLINFOWWrapper.ObjToRec: tagTOOLINFOW;
begin
  result.cbSize := FcbSize;
  result.uFlags := FuFlags;
  result.hwnd := Fhwnd;
  result.uId := FuId;
  result.hInst := FhInst;
  result.lParam := FlParam;
end;

constructor _TT_HITTESTINFOAWrapper.Create(ARecord: _TT_HITTESTINFOA);
begin
  inherited Create;
  Fhwnd := ARecord.hwnd;
end;

function _TT_HITTESTINFOAWrapper.ObjToRec: _TT_HITTESTINFOA;
begin
  result.hwnd := Fhwnd;
end;

constructor _TT_HITTESTINFOWWrapper.Create(ARecord: _TT_HITTESTINFOW);
begin
  inherited Create;
  Fhwnd := ARecord.hwnd;
end;

function _TT_HITTESTINFOWWrapper.ObjToRec: _TT_HITTESTINFOW;
begin
  result.hwnd := Fhwnd;
end;

constructor tagNMTTDISPINFOAWrapper.Create(ARecord: tagNMTTDISPINFOA);
begin
  inherited Create;
  Fhinst := ARecord.hinst;
  FuFlags := ARecord.uFlags;
  FlParam := ARecord.lParam;
end;

function tagNMTTDISPINFOAWrapper.ObjToRec: tagNMTTDISPINFOA;
begin
  result.hinst := Fhinst;
  result.uFlags := FuFlags;
  result.lParam := FlParam;
end;

constructor tagNMTTDISPINFOWWrapper.Create(ARecord: tagNMTTDISPINFOW);
begin
  inherited Create;
  Fhinst := ARecord.hinst;
  FuFlags := ARecord.uFlags;
  FlParam := ARecord.lParam;
end;

function tagNMTTDISPINFOWWrapper.ObjToRec: tagNMTTDISPINFOW;
begin
  result.hinst := Fhinst;
  result.uFlags := FuFlags;
  result.lParam := FlParam;
end;

constructor tagDRAGLISTINFOWrapper.Create(ARecord: tagDRAGLISTINFO);
begin
  inherited Create;
  FuNotification := ARecord.uNotification;
  FhWnd := ARecord.hWnd;
end;

function tagDRAGLISTINFOWrapper.ObjToRec: tagDRAGLISTINFO;
begin
  result.uNotification := FuNotification;
  result.hWnd := FhWnd;
end;

constructor _UDACCELWrapper.Create(ARecord: _UDACCEL);
begin
  inherited Create;
  FnSec := ARecord.nSec;
  FnInc := ARecord.nInc;
end;

function _UDACCELWrapper.ObjToRec: _UDACCEL;
begin
  result.nSec := FnSec;
  result.nInc := FnInc;
end;

constructor _NM_UPDOWNWrapper.Create(ARecord: _NM_UPDOWN);
begin
  inherited Create;
  FiPos := ARecord.iPos;
  FiDelta := ARecord.iDelta;
end;

function _NM_UPDOWNWrapper.ObjToRec: _NM_UPDOWN;
begin
  result.iPos := FiPos;
  result.iDelta := FiDelta;
end;

constructor PBRANGEWrapper.Create(ARecord: PBRANGE);
begin
  inherited Create;
  FiLow := ARecord.iLow;
  FiHigh := ARecord.iHigh;
end;

function PBRANGEWrapper.ObjToRec: PBRANGE;
begin
  result.iLow := FiLow;
  result.iHigh := FiHigh;
end;

constructor tagLVITEMAWrapper.Create(ARecord: tagLVITEMA);
begin
  inherited Create;
  Fmask := ARecord.mask;
  FiItem := ARecord.iItem;
  FiSubItem := ARecord.iSubItem;
  Fstate := ARecord.state;
  FstateMask := ARecord.stateMask;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
  FlParam := ARecord.lParam;
  FiIndent := ARecord.iIndent;
end;

function tagLVITEMAWrapper.ObjToRec: tagLVITEMA;
begin
  result.mask := Fmask;
  result.iItem := FiItem;
  result.iSubItem := FiSubItem;
  result.state := Fstate;
  result.stateMask := FstateMask;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
  result.lParam := FlParam;
  result.iIndent := FiIndent;
end;

constructor tagLVITEMWWrapper.Create(ARecord: tagLVITEMW);
begin
  inherited Create;
  Fmask := ARecord.mask;
  FiItem := ARecord.iItem;
  FiSubItem := ARecord.iSubItem;
  Fstate := ARecord.state;
  FstateMask := ARecord.stateMask;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
  FlParam := ARecord.lParam;
  FiIndent := ARecord.iIndent;
end;

function tagLVITEMWWrapper.ObjToRec: tagLVITEMW;
begin
  result.mask := Fmask;
  result.iItem := FiItem;
  result.iSubItem := FiSubItem;
  result.state := Fstate;
  result.stateMask := FstateMask;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
  result.lParam := FlParam;
  result.iIndent := FiIndent;
end;

constructor tagLVFINDINFOAWrapper.Create(ARecord: tagLVFINDINFOA);
begin
  inherited Create;
  Fflags := ARecord.flags;
  FlParam := ARecord.lParam;
  FvkDirection := ARecord.vkDirection;
end;

function tagLVFINDINFOAWrapper.ObjToRec: tagLVFINDINFOA;
begin
  result.flags := Fflags;
  result.lParam := FlParam;
  result.vkDirection := FvkDirection;
end;

constructor tagLVFINDINFOWWrapper.Create(ARecord: tagLVFINDINFOW);
begin
  inherited Create;
  Fflags := ARecord.flags;
  FlParam := ARecord.lParam;
  FvkDirection := ARecord.vkDirection;
end;

function tagLVFINDINFOWWrapper.ObjToRec: tagLVFINDINFOW;
begin
  result.flags := Fflags;
  result.lParam := FlParam;
  result.vkDirection := FvkDirection;
end;

constructor tagLVHITTESTINFOWrapper.Create(ARecord: tagLVHITTESTINFO);
begin
  inherited Create;
  Fflags := ARecord.flags;
  FiItem := ARecord.iItem;
  FiSubItem := ARecord.iSubItem;
end;

function tagLVHITTESTINFOWrapper.ObjToRec: tagLVHITTESTINFO;
begin
  result.flags := Fflags;
  result.iItem := FiItem;
  result.iSubItem := FiSubItem;
end;

constructor tagLVCOLUMNAWrapper.Create(ARecord: tagLVCOLUMNA);
begin
  inherited Create;
  Fmask := ARecord.mask;
  Ffmt := ARecord.fmt;
  Fcx := ARecord.cx;
  FcchTextMax := ARecord.cchTextMax;
  FiSubItem := ARecord.iSubItem;
  FiImage := ARecord.iImage;
  FiOrder := ARecord.iOrder;
end;

function tagLVCOLUMNAWrapper.ObjToRec: tagLVCOLUMNA;
begin
  result.mask := Fmask;
  result.fmt := Ffmt;
  result.cx := Fcx;
  result.cchTextMax := FcchTextMax;
  result.iSubItem := FiSubItem;
  result.iImage := FiImage;
  result.iOrder := FiOrder;
end;

constructor tagLVCOLUMNWWrapper.Create(ARecord: tagLVCOLUMNW);
begin
  inherited Create;
  Fmask := ARecord.mask;
  Ffmt := ARecord.fmt;
  Fcx := ARecord.cx;
  FcchTextMax := ARecord.cchTextMax;
  FiSubItem := ARecord.iSubItem;
  FiImage := ARecord.iImage;
  FiOrder := ARecord.iOrder;
end;

function tagLVCOLUMNWWrapper.ObjToRec: tagLVCOLUMNW;
begin
  result.mask := Fmask;
  result.fmt := Ffmt;
  result.cx := Fcx;
  result.cchTextMax := FcchTextMax;
  result.iSubItem := FiSubItem;
  result.iImage := FiImage;
  result.iOrder := FiOrder;
end;

constructor tagLVBKIMAGEAWrapper.Create(ARecord: tagLVBKIMAGEA);
begin
  inherited Create;
  FulFlags := ARecord.ulFlags;
  Fhbm := ARecord.hbm;
  FcchImageMax := ARecord.cchImageMax;
  FxOffsetPercent := ARecord.xOffsetPercent;
  FyOffsetPercent := ARecord.yOffsetPercent;
end;

function tagLVBKIMAGEAWrapper.ObjToRec: tagLVBKIMAGEA;
begin
  result.ulFlags := FulFlags;
  result.hbm := Fhbm;
  result.cchImageMax := FcchImageMax;
  result.xOffsetPercent := FxOffsetPercent;
  result.yOffsetPercent := FyOffsetPercent;
end;

constructor tagLVBKIMAGEWWrapper.Create(ARecord: tagLVBKIMAGEW);
begin
  inherited Create;
  FulFlags := ARecord.ulFlags;
  Fhbm := ARecord.hbm;
  FcchImageMax := ARecord.cchImageMax;
  FxOffsetPercent := ARecord.xOffsetPercent;
  FyOffsetPercent := ARecord.yOffsetPercent;
end;

function tagLVBKIMAGEWWrapper.ObjToRec: tagLVBKIMAGEW;
begin
  result.ulFlags := FulFlags;
  result.hbm := Fhbm;
  result.cchImageMax := FcchImageMax;
  result.xOffsetPercent := FxOffsetPercent;
  result.yOffsetPercent := FyOffsetPercent;
end;

constructor tagNMLISTVIEWWrapper.Create(ARecord: tagNMLISTVIEW);
begin
  inherited Create;
  FiItem := ARecord.iItem;
  FiSubItem := ARecord.iSubItem;
  FuNewState := ARecord.uNewState;
  FuOldState := ARecord.uOldState;
  FuChanged := ARecord.uChanged;
  FlParam := ARecord.lParam;
end;

function tagNMLISTVIEWWrapper.ObjToRec: tagNMLISTVIEW;
begin
  result.iItem := FiItem;
  result.iSubItem := FiSubItem;
  result.uNewState := FuNewState;
  result.uOldState := FuOldState;
  result.uChanged := FuChanged;
  result.lParam := FlParam;
end;

constructor tagNMITEMACTIVATEWrapper.Create(ARecord: tagNMITEMACTIVATE);
begin
  inherited Create;
  FiItem := ARecord.iItem;
  FiSubItem := ARecord.iSubItem;
  FuNewState := ARecord.uNewState;
  FuOldState := ARecord.uOldState;
  FuChanged := ARecord.uChanged;
  FlParam := ARecord.lParam;
  FuKeyFlags := ARecord.uKeyFlags;
end;

function tagNMITEMACTIVATEWrapper.ObjToRec: tagNMITEMACTIVATE;
begin
  result.iItem := FiItem;
  result.iSubItem := FiSubItem;
  result.uNewState := FuNewState;
  result.uOldState := FuOldState;
  result.uChanged := FuChanged;
  result.lParam := FlParam;
  result.uKeyFlags := FuKeyFlags;
end;

constructor tagNMLVCUSTOMDRAWWrapper.Create(ARecord: tagNMLVCUSTOMDRAW);
begin
  inherited Create;
  FclrText := ARecord.clrText;
  FclrTextBk := ARecord.clrTextBk;
  FiSubItem := ARecord.iSubItem;
end;

function tagNMLVCUSTOMDRAWWrapper.ObjToRec: tagNMLVCUSTOMDRAW;
begin
  result.clrText := FclrText;
  result.clrTextBk := FclrTextBk;
  result.iSubItem := FiSubItem;
end;

constructor tagNMLVCACHEHINTWrapper.Create(ARecord: tagNMLVCACHEHINT);
begin
  inherited Create;
  FiFrom := ARecord.iFrom;
  FiTo := ARecord.iTo;
end;

function tagNMLVCACHEHINTWrapper.ObjToRec: tagNMLVCACHEHINT;
begin
  result.iFrom := FiFrom;
  result.iTo := FiTo;
end;

constructor tagNMLVFINDITEMAWrapper.Create(ARecord: tagNMLVFINDITEMA);
begin
  inherited Create;
  FiStart := ARecord.iStart;
end;

function tagNMLVFINDITEMAWrapper.ObjToRec: tagNMLVFINDITEMA;
begin
  result.iStart := FiStart;
end;

constructor tagNMLVODSTATECHANGEWrapper.Create(ARecord: tagNMLVODSTATECHANGE);
begin
  inherited Create;
  FiFrom := ARecord.iFrom;
  FiTo := ARecord.iTo;
  FuNewState := ARecord.uNewState;
  FuOldState := ARecord.uOldState;
end;

function tagNMLVODSTATECHANGEWrapper.ObjToRec: tagNMLVODSTATECHANGE;
begin
  result.iFrom := FiFrom;
  result.iTo := FiTo;
  result.uNewState := FuNewState;
  result.uOldState := FuOldState;
end;

constructor tagLVDISPINFOWrapper.Create(ARecord: tagLVDISPINFO);
begin
  inherited Create;
end;

function tagLVDISPINFOWrapper.ObjToRec: tagLVDISPINFO;
begin
end;

constructor tagLVDISPINFOWWrapper.Create(ARecord: tagLVDISPINFOW);
begin
  inherited Create;
end;

function tagLVDISPINFOWWrapper.ObjToRec: tagLVDISPINFOW;
begin
end;

constructor tagLVKEYDOWNWrapper.Create(ARecord: tagLVKEYDOWN);
begin
  inherited Create;
  FwVKey := ARecord.wVKey;
  Fflags := ARecord.flags;
end;

function tagLVKEYDOWNWrapper.ObjToRec: tagLVKEYDOWN;
begin
  result.wVKey := FwVKey;
  result.flags := Fflags;
end;

constructor tagNMLVGETINFOTIPAWrapper.Create(ARecord: tagNMLVGETINFOTIPA);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FcchTextMax := ARecord.cchTextMax;
  FiItem := ARecord.iItem;
  FiSubItem := ARecord.iSubItem;
  FlParam := ARecord.lParam;
end;

function tagNMLVGETINFOTIPAWrapper.ObjToRec: tagNMLVGETINFOTIPA;
begin
  result.dwFlags := FdwFlags;
  result.cchTextMax := FcchTextMax;
  result.iItem := FiItem;
  result.iSubItem := FiSubItem;
  result.lParam := FlParam;
end;

constructor tagNMLVGETINFOTIPWWrapper.Create(ARecord: tagNMLVGETINFOTIPW);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FcchTextMax := ARecord.cchTextMax;
  FiItem := ARecord.iItem;
  FiSubItem := ARecord.iSubItem;
  FlParam := ARecord.lParam;
end;

function tagNMLVGETINFOTIPWWrapper.ObjToRec: tagNMLVGETINFOTIPW;
begin
  result.dwFlags := FdwFlags;
  result.cchTextMax := FcchTextMax;
  result.iItem := FiItem;
  result.iSubItem := FiSubItem;
  result.lParam := FlParam;
end;

constructor _TREEITEMWrapper.Create(ARecord: _TREEITEM);
begin
  inherited Create;
end;

function _TREEITEMWrapper.ObjToRec: _TREEITEM;
begin
end;

constructor tagTVITEMAWrapper.Create(ARecord: tagTVITEMA);
begin
  inherited Create;
  Fmask := ARecord.mask;
  Fstate := ARecord.state;
  FstateMask := ARecord.stateMask;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
  FiSelectedImage := ARecord.iSelectedImage;
  FcChildren := ARecord.cChildren;
  FlParam := ARecord.lParam;
end;

function tagTVITEMAWrapper.ObjToRec: tagTVITEMA;
begin
  result.mask := Fmask;
  result.state := Fstate;
  result.stateMask := FstateMask;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
  result.iSelectedImage := FiSelectedImage;
  result.cChildren := FcChildren;
  result.lParam := FlParam;
end;

constructor tagTVITEMWWrapper.Create(ARecord: tagTVITEMW);
begin
  inherited Create;
  Fmask := ARecord.mask;
  Fstate := ARecord.state;
  FstateMask := ARecord.stateMask;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
  FiSelectedImage := ARecord.iSelectedImage;
  FcChildren := ARecord.cChildren;
  FlParam := ARecord.lParam;
end;

function tagTVITEMWWrapper.ObjToRec: tagTVITEMW;
begin
  result.mask := Fmask;
  result.state := Fstate;
  result.stateMask := FstateMask;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
  result.iSelectedImage := FiSelectedImage;
  result.cChildren := FcChildren;
  result.lParam := FlParam;
end;

constructor tagTVITEMEXAWrapper.Create(ARecord: tagTVITEMEXA);
begin
  inherited Create;
  Fmask := ARecord.mask;
  Fstate := ARecord.state;
  FstateMask := ARecord.stateMask;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
  FiSelectedImage := ARecord.iSelectedImage;
  FcChildren := ARecord.cChildren;
  FlParam := ARecord.lParam;
  FiIntegral := ARecord.iIntegral;
end;

function tagTVITEMEXAWrapper.ObjToRec: tagTVITEMEXA;
begin
  result.mask := Fmask;
  result.state := Fstate;
  result.stateMask := FstateMask;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
  result.iSelectedImage := FiSelectedImage;
  result.cChildren := FcChildren;
  result.lParam := FlParam;
  result.iIntegral := FiIntegral;
end;

constructor tagTVITEMEXWWrapper.Create(ARecord: tagTVITEMEXW);
begin
  inherited Create;
  Fmask := ARecord.mask;
  Fstate := ARecord.state;
  FstateMask := ARecord.stateMask;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
  FiSelectedImage := ARecord.iSelectedImage;
  FcChildren := ARecord.cChildren;
  FlParam := ARecord.lParam;
  FiIntegral := ARecord.iIntegral;
end;

function tagTVITEMEXWWrapper.ObjToRec: tagTVITEMEXW;
begin
  result.mask := Fmask;
  result.state := Fstate;
  result.stateMask := FstateMask;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
  result.iSelectedImage := FiSelectedImage;
  result.cChildren := FcChildren;
  result.lParam := FlParam;
  result.iIntegral := FiIntegral;
end;

constructor tagTVINSERTSTRUCTAWrapper.Create(ARecord: tagTVINSERTSTRUCTA);
begin
  inherited Create;
end;

function tagTVINSERTSTRUCTAWrapper.ObjToRec: tagTVINSERTSTRUCTA;
begin
end;

constructor tagTVINSERTSTRUCTWWrapper.Create(ARecord: tagTVINSERTSTRUCTW);
begin
  inherited Create;
end;

function tagTVINSERTSTRUCTWWrapper.ObjToRec: tagTVINSERTSTRUCTW;
begin
end;

constructor tagTVHITTESTINFOWrapper.Create(ARecord: tagTVHITTESTINFO);
begin
  inherited Create;
  Fflags := ARecord.flags;
end;

function tagTVHITTESTINFOWrapper.ObjToRec: tagTVHITTESTINFO;
begin
  result.flags := Fflags;
end;

constructor tagTVSORTCBWrapper.Create(ARecord: tagTVSORTCB);
begin
  inherited Create;
  FlParam := ARecord.lParam;
end;

function tagTVSORTCBWrapper.ObjToRec: tagTVSORTCB;
begin
  result.lParam := FlParam;
end;

constructor tagNMTREEVIEWAWrapper.Create(ARecord: tagNMTREEVIEWA);
begin
  inherited Create;
  Faction := ARecord.action;
end;

function tagNMTREEVIEWAWrapper.ObjToRec: tagNMTREEVIEWA;
begin
  result.action := Faction;
end;

constructor tagNMTREEVIEWWWrapper.Create(ARecord: tagNMTREEVIEWW);
begin
  inherited Create;
  Faction := ARecord.action;
end;

function tagNMTREEVIEWWWrapper.ObjToRec: tagNMTREEVIEWW;
begin
  result.action := Faction;
end;

constructor tagTVDISPINFOAWrapper.Create(ARecord: tagTVDISPINFOA);
begin
  inherited Create;
end;

function tagTVDISPINFOAWrapper.ObjToRec: tagTVDISPINFOA;
begin
end;

constructor tagTVDISPINFOWWrapper.Create(ARecord: tagTVDISPINFOW);
begin
  inherited Create;
end;

function tagTVDISPINFOWWrapper.ObjToRec: tagTVDISPINFOW;
begin
end;

constructor tagTVKEYDOWNWrapper.Create(ARecord: tagTVKEYDOWN);
begin
  inherited Create;
  FwVKey := ARecord.wVKey;
  Fflags := ARecord.flags;
end;

function tagTVKEYDOWNWrapper.ObjToRec: tagTVKEYDOWN;
begin
  result.wVKey := FwVKey;
  result.flags := Fflags;
end;

constructor tagNMTVCUSTOMDRAWWrapper.Create(ARecord: tagNMTVCUSTOMDRAW);
begin
  inherited Create;
  FclrText := ARecord.clrText;
  FclrTextBk := ARecord.clrTextBk;
  FiLevel := ARecord.iLevel;
end;

function tagNMTVCUSTOMDRAWWrapper.ObjToRec: tagNMTVCUSTOMDRAW;
begin
  result.clrText := FclrText;
  result.clrTextBk := FclrTextBk;
  result.iLevel := FiLevel;
end;

constructor tagNMTVGETINFOTIPAWrapper.Create(ARecord: tagNMTVGETINFOTIPA);
begin
  inherited Create;
  FcchTextMax := ARecord.cchTextMax;
  FlParam := ARecord.lParam;
end;

function tagNMTVGETINFOTIPAWrapper.ObjToRec: tagNMTVGETINFOTIPA;
begin
  result.cchTextMax := FcchTextMax;
  result.lParam := FlParam;
end;

constructor tagNMTVGETINFOTIPWWrapper.Create(ARecord: tagNMTVGETINFOTIPW);
begin
  inherited Create;
  FcchTextMax := ARecord.cchTextMax;
  FlParam := ARecord.lParam;
end;

function tagNMTVGETINFOTIPWWrapper.ObjToRec: tagNMTVGETINFOTIPW;
begin
  result.cchTextMax := FcchTextMax;
  result.lParam := FlParam;
end;

constructor tagCOMBOBOXEXITEMAWrapper.Create(ARecord: tagCOMBOBOXEXITEMA);
begin
  inherited Create;
  Fmask := ARecord.mask;
  FiItem := ARecord.iItem;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
  FiSelectedImage := ARecord.iSelectedImage;
  FiOverlay := ARecord.iOverlay;
  FiIndent := ARecord.iIndent;
  FlParam := ARecord.lParam;
end;

function tagCOMBOBOXEXITEMAWrapper.ObjToRec: tagCOMBOBOXEXITEMA;
begin
  result.mask := Fmask;
  result.iItem := FiItem;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
  result.iSelectedImage := FiSelectedImage;
  result.iOverlay := FiOverlay;
  result.iIndent := FiIndent;
  result.lParam := FlParam;
end;

constructor tagCOMBOBOXEXITEMWWrapper.Create(ARecord: tagCOMBOBOXEXITEMW);
begin
  inherited Create;
  Fmask := ARecord.mask;
  FiItem := ARecord.iItem;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
  FiSelectedImage := ARecord.iSelectedImage;
  FiOverlay := ARecord.iOverlay;
  FiIndent := ARecord.iIndent;
  FlParam := ARecord.lParam;
end;

function tagCOMBOBOXEXITEMWWrapper.ObjToRec: tagCOMBOBOXEXITEMW;
begin
  result.mask := Fmask;
  result.iItem := FiItem;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
  result.iSelectedImage := FiSelectedImage;
  result.iOverlay := FiOverlay;
  result.iIndent := FiIndent;
  result.lParam := FlParam;
end;

constructor NMCOMBOBOXEXAWrapper.Create(ARecord: NMCOMBOBOXEXA);
begin
  inherited Create;
end;

function NMCOMBOBOXEXAWrapper.ObjToRec: NMCOMBOBOXEXA;
begin
end;

constructor NMCOMBOBOXEXWWrapper.Create(ARecord: NMCOMBOBOXEXW);
begin
  inherited Create;
end;

function NMCOMBOBOXEXWWrapper.ObjToRec: NMCOMBOBOXEXW;
begin
end;

constructor NMCBEDRAGBEGINAWrapper.Create(ARecord: NMCBEDRAGBEGINA);
begin
  inherited Create;
  FiItemid := ARecord.iItemid;
end;

function NMCBEDRAGBEGINAWrapper.ObjToRec: NMCBEDRAGBEGINA;
begin
  result.iItemid := FiItemid;
end;

constructor NMCBEDRAGBEGINWWrapper.Create(ARecord: NMCBEDRAGBEGINW);
begin
  inherited Create;
  FiItemid := ARecord.iItemid;
end;

function NMCBEDRAGBEGINWWrapper.ObjToRec: NMCBEDRAGBEGINW;
begin
  result.iItemid := FiItemid;
end;

constructor NMCBEENDEDITAWrapper.Create(ARecord: NMCBEENDEDITA);
begin
  inherited Create;
  FfChanged := ARecord.fChanged;
  FiNewSelection := ARecord.iNewSelection;
  FiWhy := ARecord.iWhy;
end;

function NMCBEENDEDITAWrapper.ObjToRec: NMCBEENDEDITA;
begin
  result.fChanged := FfChanged;
  result.iNewSelection := FiNewSelection;
  result.iWhy := FiWhy;
end;

constructor NMCBEENDEDITWWrapper.Create(ARecord: NMCBEENDEDITW);
begin
  inherited Create;
  FfChanged := ARecord.fChanged;
  FiNewSelection := ARecord.iNewSelection;
  FiWhy := ARecord.iWhy;
end;

function NMCBEENDEDITWWrapper.ObjToRec: NMCBEENDEDITW;
begin
  result.fChanged := FfChanged;
  result.iNewSelection := FiNewSelection;
  result.iWhy := FiWhy;
end;

constructor tagTCITEMHEADERAWrapper.Create(ARecord: tagTCITEMHEADERA);
begin
  inherited Create;
  Fmask := ARecord.mask;
  FlpReserved1 := ARecord.lpReserved1;
  FlpReserved2 := ARecord.lpReserved2;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
end;

function tagTCITEMHEADERAWrapper.ObjToRec: tagTCITEMHEADERA;
begin
  result.mask := Fmask;
  result.lpReserved1 := FlpReserved1;
  result.lpReserved2 := FlpReserved2;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
end;

constructor tagTCITEMHEADERWWrapper.Create(ARecord: tagTCITEMHEADERW);
begin
  inherited Create;
  Fmask := ARecord.mask;
  FlpReserved1 := ARecord.lpReserved1;
  FlpReserved2 := ARecord.lpReserved2;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
end;

function tagTCITEMHEADERWWrapper.ObjToRec: tagTCITEMHEADERW;
begin
  result.mask := Fmask;
  result.lpReserved1 := FlpReserved1;
  result.lpReserved2 := FlpReserved2;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
end;

constructor tagTCITEMAWrapper.Create(ARecord: tagTCITEMA);
begin
  inherited Create;
  Fmask := ARecord.mask;
  FdwState := ARecord.dwState;
  FdwStateMask := ARecord.dwStateMask;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
  FlParam := ARecord.lParam;
end;

function tagTCITEMAWrapper.ObjToRec: tagTCITEMA;
begin
  result.mask := Fmask;
  result.dwState := FdwState;
  result.dwStateMask := FdwStateMask;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
  result.lParam := FlParam;
end;

constructor tagTCITEMWWrapper.Create(ARecord: tagTCITEMW);
begin
  inherited Create;
  Fmask := ARecord.mask;
  FdwState := ARecord.dwState;
  FdwStateMask := ARecord.dwStateMask;
  FcchTextMax := ARecord.cchTextMax;
  FiImage := ARecord.iImage;
  FlParam := ARecord.lParam;
end;

function tagTCITEMWWrapper.ObjToRec: tagTCITEMW;
begin
  result.mask := Fmask;
  result.dwState := FdwState;
  result.dwStateMask := FdwStateMask;
  result.cchTextMax := FcchTextMax;
  result.iImage := FiImage;
  result.lParam := FlParam;
end;

constructor tagTCHITTESTINFOWrapper.Create(ARecord: tagTCHITTESTINFO);
begin
  inherited Create;
  Fflags := ARecord.flags;
end;

function tagTCHITTESTINFOWrapper.ObjToRec: tagTCHITTESTINFO;
begin
  result.flags := Fflags;
end;

constructor tagTCKEYDOWNWrapper.Create(ARecord: tagTCKEYDOWN);
begin
  inherited Create;
  FwVKey := ARecord.wVKey;
  Fflags := ARecord.flags;
end;

function tagTCKEYDOWNWrapper.ObjToRec: tagTCKEYDOWN;
begin
  result.wVKey := FwVKey;
  result.flags := Fflags;
end;

constructor MCHITTESTINFOWrapper.Create(ARecord: MCHITTESTINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FuHit := ARecord.uHit;
end;

function MCHITTESTINFOWrapper.ObjToRec: MCHITTESTINFO;
begin
  result.cbSize := FcbSize;
  result.uHit := FuHit;
end;

constructor tagNMSELCHANGEWrapper.Create(ARecord: tagNMSELCHANGE);
begin
  inherited Create;
end;

function tagNMSELCHANGEWrapper.ObjToRec: tagNMSELCHANGE;
begin
end;

constructor tagNMDAYSTATEWrapper.Create(ARecord: tagNMDAYSTATE);
begin
  inherited Create;
  FcDayState := ARecord.cDayState;
end;

function tagNMDAYSTATEWrapper.ObjToRec: tagNMDAYSTATE;
begin
  result.cDayState := FcDayState;
end;

constructor tagNMDATETIMECHANGEWrapper.Create(ARecord: tagNMDATETIMECHANGE);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
end;

function tagNMDATETIMECHANGEWrapper.ObjToRec: tagNMDATETIMECHANGE;
begin
  result.dwFlags := FdwFlags;
end;

constructor tagNMDATETIMESTRINGAWrapper.Create(ARecord: tagNMDATETIMESTRINGA);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
end;

function tagNMDATETIMESTRINGAWrapper.ObjToRec: tagNMDATETIMESTRINGA;
begin
  result.dwFlags := FdwFlags;
end;

constructor tagNMDATETIMESTRINGWWrapper.Create(ARecord: tagNMDATETIMESTRINGW);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
end;

function tagNMDATETIMESTRINGWWrapper.ObjToRec: tagNMDATETIMESTRINGW;
begin
  result.dwFlags := FdwFlags;
end;

constructor tagNMDATETIMEWMKEYDOWNAWrapper.Create(ARecord: tagNMDATETIMEWMKEYDOWNA);
begin
  inherited Create;
  FnVirtKey := ARecord.nVirtKey;
end;

function tagNMDATETIMEWMKEYDOWNAWrapper.ObjToRec: tagNMDATETIMEWMKEYDOWNA;
begin
  result.nVirtKey := FnVirtKey;
end;

constructor tagNMDATETIMEWMKEYDOWNWWrapper.Create(ARecord: tagNMDATETIMEWMKEYDOWNW);
begin
  inherited Create;
  FnVirtKey := ARecord.nVirtKey;
end;

function tagNMDATETIMEWMKEYDOWNWWrapper.ObjToRec: tagNMDATETIMEWMKEYDOWNW;
begin
  result.nVirtKey := FnVirtKey;
end;

constructor tagNMDATETIMEFORMATAWrapper.Create(ARecord: tagNMDATETIMEFORMATA);
begin
  inherited Create;
end;

function tagNMDATETIMEFORMATAWrapper.ObjToRec: tagNMDATETIMEFORMATA;
begin
end;

constructor tagNMDATETIMEFORMATWWrapper.Create(ARecord: tagNMDATETIMEFORMATW);
begin
  inherited Create;
end;

function tagNMDATETIMEFORMATWWrapper.ObjToRec: tagNMDATETIMEFORMATW;
begin
end;

constructor tagNMDATETIMEFORMATQUERYAWrapper.Create(ARecord: tagNMDATETIMEFORMATQUERYA);
begin
  inherited Create;
end;

function tagNMDATETIMEFORMATQUERYAWrapper.ObjToRec: tagNMDATETIMEFORMATQUERYA;
begin
end;

constructor tagNMDATETIMEFORMATQUERYWWrapper.Create(ARecord: tagNMDATETIMEFORMATQUERYW);
begin
  inherited Create;
end;

function tagNMDATETIMEFORMATQUERYWWrapper.ObjToRec: tagNMDATETIMEFORMATQUERYW;
begin
end;

constructor tagNMIPADDRESSWrapper.Create(ARecord: tagNMIPADDRESS);
begin
  inherited Create;
  FiField := ARecord.iField;
  FiValue := ARecord.iValue;
end;

function tagNMIPADDRESSWrapper.ObjToRec: tagNMIPADDRESS;
begin
  result.iField := FiField;
  result.iValue := FiValue;
end;

constructor NMPGSCROLLWrapper.Create(ARecord: NMPGSCROLL);
begin
  inherited Create;
  FfwKeys := ARecord.fwKeys;
  FiDir := ARecord.iDir;
  FiXpos := ARecord.iXpos;
  FiYpos := ARecord.iYpos;
  FiScroll := ARecord.iScroll;
end;

function NMPGSCROLLWrapper.ObjToRec: NMPGSCROLL;
begin
  result.fwKeys := FfwKeys;
  result.iDir := FiDir;
  result.iXpos := FiXpos;
  result.iYpos := FiYpos;
  result.iScroll := FiScroll;
end;

constructor NMPGCALCSIZEWrapper.Create(ARecord: NMPGCALCSIZE);
begin
  inherited Create;
  FdwFlag := ARecord.dwFlag;
  FiWidth := ARecord.iWidth;
  FiHeight := ARecord.iHeight;
end;

function NMPGCALCSIZEWrapper.ObjToRec: NMPGCALCSIZE;
begin
  result.dwFlag := FdwFlag;
  result.iWidth := FiWidth;
  result.iHeight := FiHeight;
end;

constructor tagTRACKMOUSEEVENTWrapper.Create(ARecord: tagTRACKMOUSEEVENT);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
  FhwndTrack := ARecord.hwndTrack;
  FdwHoverTime := ARecord.dwHoverTime;
end;

function tagTRACKMOUSEEVENTWrapper.ObjToRec: tagTRACKMOUSEEVENT;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
  result.hwndTrack := FhwndTrack;
  result.dwHoverTime := FdwHoverTime;
end;



procedure TatCommctrlLibrary.__PropertySheetA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TPropSheetHeaderA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _PROPSHEETHEADERAWrapper) then 
  Param0Rec := _PROPSHEETHEADERAWrapper.Create(Param0);
Param0 := _PROPSHEETHEADERAWrapper(Param0Rec).ObjToRec;
AResult := Integer(Commctrl.PropertySheetA(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_PROPSHEETHEADERAWrapper.Create(Param0)));
  end;
end;

procedure TatCommctrlLibrary.__PropertySheetW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TPropSheetHeaderW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _PROPSHEETHEADERWWrapper) then 
  Param0Rec := _PROPSHEETHEADERWWrapper.Create(Param0);
Param0 := _PROPSHEETHEADERWWrapper(Param0Rec).ObjToRec;
AResult := Integer(Commctrl.PropertySheetW(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_PROPSHEETHEADERWWrapper.Create(Param0)));
  end;
end;

procedure TatCommctrlLibrary.__PropertySheet(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TPropSheetHeader;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _PROPSHEETHEADERAWrapper) then 
  Param0Rec := _PROPSHEETHEADERAWrapper.Create(Param0);
Param0 := _PROPSHEETHEADERAWrapper(Param0Rec).ObjToRec;
AResult := Integer(Commctrl.PropertySheet(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_PROPSHEETHEADERAWrapper.Create(Param0)));
  end;
end;

procedure TatCommctrlLibrary.__InitCommonControls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.InitCommonControls;
  end;
end;

procedure TatCommctrlLibrary.__InitCommonControlsEx(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TInitCommonControlsEx;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagINITCOMMONCONTROLSEXWrapper) then 
  Param0Rec := tagINITCOMMONCONTROLSEXWrapper.Create(Param0);
Param0 := tagINITCOMMONCONTROLSEXWrapper(Param0Rec).ObjToRec;
AResult := Commctrl.InitCommonControlsEx(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagINITCOMMONCONTROLSEXWrapper.Create(Param0)));
  end;
end;

procedure TatCommctrlLibrary.__ImageList_Create(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_Create(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_Destroy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_Destroy(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_GetImageCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_GetImageCount(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_SetImageCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_SetImageCount(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_Add(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_Add(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_ReplaceIcon(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_ReplaceIcon(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_SetBkColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_SetBkColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_GetBkColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_GetBkColor(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_SetOverlayImage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_SetOverlayImage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_AddIcon(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_AddIcon(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__IndexToOverlayMask(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.IndexToOverlayMask(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_Draw(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_Draw(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_Replace(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_Replace(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_AddMasked(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_AddMasked(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_DrawEx(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_DrawEx(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6)),VarToInteger(GetInputArg(7)),VarToInteger(GetInputArg(8)),VarToInteger(GetInputArg(9)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_Remove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_Remove(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_GetIcon(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_GetIcon(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_LoadImageA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_LoadImageA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_LoadImageW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_LoadImageW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_LoadImage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_LoadImage(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_Copy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_Copy(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_BeginDrag(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_BeginDrag(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_EndDrag(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_EndDrag;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_DragEnter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_DragEnter(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_DragLeave(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_DragLeave(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_DragMove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_DragMove(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_SetDragCursorImage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_SetDragCursorImage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_DragShowNolock(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_DragShowNolock(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_RemoveAll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.ImageList_RemoveAll(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatCommctrlLibrary.__ImageList_ExtractIcon(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_ExtractIcon(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_LoadBitmap(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_LoadBitmap(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_GetIconSize(AMachine: TatVirtualMachine);
  var
  Param1: Integer;
  Param2: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := Commctrl.ImageList_GetIconSize(VarToInteger(GetInputArg(0)),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatCommctrlLibrary.__ImageList_SetIconSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ImageList_SetIconSize(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_GetImageInfo(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TImageInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _IMAGEINFOWrapper) then 
  Param2Rec := _IMAGEINFOWrapper.Create(Param2);
Param2 := _IMAGEINFOWrapper(Param2Rec).ObjToRec;
AResult := Commctrl.ImageList_GetImageInfo(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_IMAGEINFOWrapper.Create(Param2)));
  end;
end;

procedure TatCommctrlLibrary.__ImageList_Merge(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_Merge(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ImageList_Duplicate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ImageList_Duplicate(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Header_GetItemCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Header_GetItemCount(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Header_InsertItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Header_InsertItem(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),_HD_ITEMAWrapper(integer(GetInputArg(2))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Header_DeleteItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.Header_DeleteItem(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Header_GetItem(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: THDItem;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _HD_ITEMAWrapper) then 
  Param2Rec := _HD_ITEMAWrapper.Create(Param2);
Param2 := _HD_ITEMAWrapper(Param2Rec).ObjToRec;
AResult := Commctrl.Header_GetItem(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_HD_ITEMAWrapper.Create(Param2)));
  end;
end;

procedure TatCommctrlLibrary.__Header_SetItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.Header_SetItem(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),_HD_ITEMAWrapper(integer(GetInputArg(2))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Header_SetImageList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Header_SetImageList(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Header_GetImageList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Header_GetImageList(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Header_OrderToIndex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Header_OrderToIndex(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Header_CreateDragImage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Header_CreateDragImage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Header_SetHotDivider(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Header_SetHotDivider(VarToInteger(GetInputArg(0)),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Header_SetUnicodeFormat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Header_SetUnicodeFormat(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Header_GetUnicodeFormat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Header_GetUnicodeFormat(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__CreateStatusWindowA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.CreateStatusWindowA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__CreateStatusWindowW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.CreateStatusWindowW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__CreateStatusWindow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.CreateStatusWindow(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MakeDragList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.MakeDragList(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatCommctrlLibrary.__DrawInsert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.DrawInsert(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatCommctrlLibrary.__LBItemFromPt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.LBItemFromPt(VarToInteger(GetInputArg(0)),TPointWrapper(integer(GetInputArg(1))).ObjToRec,GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__CreateUpDownControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.CreateUpDownControl(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6)),VarToInteger(GetInputArg(7)),VarToInteger(GetInputArg(8)),VarToInteger(GetInputArg(9)),VarToInteger(GetInputArg(10)),VarToInteger(GetInputArg(11))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetUnicodeFormat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_SetUnicodeFormat(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetUnicodeFormat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_GetUnicodeFormat(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetBkColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetBkColor(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetBkColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetBkColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetImageList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetImageList(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetImageList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_SetImageList(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetItemCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetItemCount(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__IndexToStateImageMask(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.IndexToStateImageMask(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetItemA(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TLVItemA;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagLVITEMAWrapper) then 
  Param1Rec := tagLVITEMAWrapper.Create(Param1);
Param1 := tagLVITEMAWrapper(Param1Rec).ObjToRec;
AResult := Commctrl.ListView_GetItemA(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagLVITEMAWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetItemW(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TLVItemW;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagLVITEMWWrapper) then 
  Param1Rec := tagLVITEMWWrapper.Create(Param1);
Param1 := tagLVITEMWWrapper(Param1Rec).ObjToRec;
AResult := Commctrl.ListView_GetItemW(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagLVITEMWWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetItem(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TLVItem;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagLVITEMAWrapper) then 
  Param1Rec := tagLVITEMAWrapper.Create(Param1);
Param1 := tagLVITEMAWrapper(Param1Rec).ObjToRec;
AResult := Commctrl.ListView_GetItem(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagLVITEMAWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetItemA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetItemA(VarToInteger(GetInputArg(0)),tagLVITEMAWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetItemW(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetItemW(VarToInteger(GetInputArg(0)),tagLVITEMWWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetItem(VarToInteger(GetInputArg(0)),tagLVITEMAWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_InsertItemA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_InsertItemA(VarToInteger(GetInputArg(0)),tagLVITEMAWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_InsertItemW(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_InsertItemW(VarToInteger(GetInputArg(0)),tagLVITEMWWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_InsertItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_InsertItem(VarToInteger(GetInputArg(0)),tagLVITEMAWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_DeleteItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_DeleteItem(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_DeleteAllItems(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_DeleteAllItems(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetCallbackMask(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetCallbackMask(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetCallbackMask(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetCallbackMask(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetNextItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetNextItem(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_FindItemA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_FindItemA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),tagLVFINDINFOAWrapper(integer(GetInputArg(2))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_FindItemW(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_FindItemW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),tagLVFINDINFOWWrapper(integer(GetInputArg(2))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_FindItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_FindItem(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),tagLVFINDINFOAWrapper(integer(GetInputArg(2))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetItemRect(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TRect;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TRectWrapper) then 
  Param2Rec := TRectWrapper.Create(Param2);
Param2 := TRectWrapper(Param2Rec).ObjToRec;
AResult := Commctrl.ListView_GetItemRect(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2,VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TRectWrapper.Create(Param2)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetItemPosition(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetItemPosition(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetItemPosition(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TPoint;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TPointWrapper) then 
  Param2Rec := TPointWrapper.Create(Param2);
Param2 := TPointWrapper(Param2Rec).ObjToRec;
AResult := Commctrl.ListView_GetItemPosition(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TPointWrapper.Create(Param2)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetStringWidthA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetStringWidthA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetStringWidthW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetStringWidthW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetStringWidth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetStringWidth(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_HitTest(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TLVHitTestInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagLVHITTESTINFOWrapper) then 
  Param1Rec := tagLVHITTESTINFOWrapper.Create(Param1);
Param1 := tagLVHITTESTINFOWrapper(Param1Rec).ObjToRec;
AResult := Integer(Commctrl.ListView_HitTest(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagLVHITTESTINFOWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_EnsureVisible(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_EnsureVisible(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_Scroll(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_Scroll(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_RedrawItems(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_RedrawItems(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_Arrange(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_Arrange(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_EditLabelA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_EditLabelA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_EditLabelW(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_EditLabelW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_EditLabel(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_EditLabel(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetEditControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetEditControl(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetColumnA(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TLVColumnA;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is tagLVCOLUMNAWrapper) then 
  Param2Rec := tagLVCOLUMNAWrapper.Create(Param2);
Param2 := tagLVCOLUMNAWrapper(Param2Rec).ObjToRec;
AResult := Commctrl.ListView_GetColumnA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(tagLVCOLUMNAWrapper.Create(Param2)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetColumnW(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TLVColumnW;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is tagLVCOLUMNWWrapper) then 
  Param2Rec := tagLVCOLUMNWWrapper.Create(Param2);
Param2 := tagLVCOLUMNWWrapper(Param2Rec).ObjToRec;
AResult := Commctrl.ListView_GetColumnW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(tagLVCOLUMNWWrapper.Create(Param2)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetColumn(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TLVColumn;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is tagLVCOLUMNAWrapper) then 
  Param2Rec := tagLVCOLUMNAWrapper.Create(Param2);
Param2 := tagLVCOLUMNAWrapper(Param2Rec).ObjToRec;
AResult := Commctrl.ListView_GetColumn(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(tagLVCOLUMNAWrapper.Create(Param2)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetColumnA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetColumnA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),tagLVCOLUMNAWrapper(integer(GetInputArg(2))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetColumnW(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetColumnW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),tagLVCOLUMNWWrapper(integer(GetInputArg(2))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetColumn(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetColumn(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),tagLVCOLUMNAWrapper(integer(GetInputArg(2))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_InsertColumnA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_InsertColumnA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),tagLVCOLUMNAWrapper(integer(GetInputArg(2))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_InsertColumnW(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_InsertColumnW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),tagLVCOLUMNWWrapper(integer(GetInputArg(2))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_InsertColumn(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_InsertColumn(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),tagLVCOLUMNAWrapper(integer(GetInputArg(2))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_DeleteColumn(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_DeleteColumn(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetColumnWidth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetColumnWidth(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetColumnWidth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetColumnWidth(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetHeader(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetHeader(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_CreateDragImage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_CreateDragImage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),TPointWrapper(integer(GetInputArg(2))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetViewRect(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TRect;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TRectWrapper) then 
  Param1Rec := TRectWrapper.Create(Param1);
Param1 := TRectWrapper(Param1Rec).ObjToRec;
AResult := Commctrl.ListView_GetViewRect(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TRectWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetTextColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetTextColor(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetTextColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetTextColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetTextBkColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetTextBkColor(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetTextBkColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetTextBkColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetTopIndex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetTopIndex(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetCountPerPage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetCountPerPage(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetOrigin(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TPoint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TPointWrapper) then 
  Param1Rec := TPointWrapper.Create(Param1);
Param1 := TPointWrapper(Param1Rec).ObjToRec;
AResult := Commctrl.ListView_GetOrigin(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TPointWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_Update(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_Update(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetItemState(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetItemState(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetItemState(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetItemState(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetCheckState(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetCheckState(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetCheckState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.ListView_SetCheckState(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetItemTextA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetItemTextA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetItemTextW(AMachine: TatVirtualMachine);
  var
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetItemTextW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetItemText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetItemText(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetItemTextA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetItemTextA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PChar(VarToStr(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetItemTextW(AMachine: TatVirtualMachine);
  var
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetItemTextW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetItemText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetItemText(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PChar(VarToStr(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetItemCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.ListView_SetItemCount(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetItemCountEx(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.ListView_SetItemCountEx(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetItemPosition32(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.ListView_SetItemPosition32(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetSelectedCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetSelectedCount(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetItemSpacing(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetItemSpacing(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetISearchStringA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_GetISearchStringA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetISearchStringW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_GetISearchStringW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetISearchString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_GetISearchString(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetIconSpacing(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_SetIconSpacing(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetExtendedListViewStyle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.ListView_SetExtendedListViewStyle(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetExtendedListViewStyle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetExtendedListViewStyle(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetHotItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_SetHotItem(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetHotItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetHotItem(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetHotCursor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_SetHotCursor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetHotCursor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetHotCursor(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_ApproximateViewRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_ApproximateViewRect(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetSelectionMark(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetSelectionMark(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetSelectionMark(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_SetSelectionMark(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetHoverTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_SetHoverTime(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetHoverTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetHoverTime(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_SetToolTips(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_SetToolTips(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__ListView_GetToolTips(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.ListView_GetToolTips(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_DeleteAllItems(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TreeView_DeleteAllItems(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_GetCount(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetIndent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_GetIndent(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SetIndent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TreeView_SetIndent(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetImageList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_GetImageList(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SetImageList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_SetImageList(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetItemA(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TTVItemA;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagTVITEMAWrapper) then 
  Param1Rec := tagTVITEMAWrapper.Create(Param1);
Param1 := tagTVITEMAWrapper(Param1Rec).ObjToRec;
AResult := Commctrl.TreeView_GetItemA(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagTVITEMAWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetItemW(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TTVItemW;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagTVITEMWWrapper) then 
  Param1Rec := tagTVITEMWWrapper.Create(Param1);
Param1 := tagTVITEMWWrapper(Param1Rec).ObjToRec;
AResult := Commctrl.TreeView_GetItemW(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagTVITEMWWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetItem(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TTVItem;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagTVITEMAWrapper) then 
  Param1Rec := tagTVITEMAWrapper.Create(Param1);
Param1 := tagTVITEMAWrapper(Param1Rec).ObjToRec;
AResult := Commctrl.TreeView_GetItem(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagTVITEMAWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SetItemA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TreeView_SetItemA(VarToInteger(GetInputArg(0)),tagTVITEMAWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SetItemW(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TreeView_SetItemW(VarToInteger(GetInputArg(0)),tagTVITEMWWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SetItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TreeView_SetItem(VarToInteger(GetInputArg(0)),tagTVITEMAWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetEditControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_GetEditControl(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetVisibleCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_GetVisibleCount(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SortChildrenCB(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TreeView_SortChildrenCB(VarToInteger(GetInputArg(0)),tagTVSORTCBWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_EndEditLabelNow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TreeView_EndEditLabelNow(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetISearchStringA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TreeView_GetISearchStringA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetISearchStringW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TreeView_GetISearchStringW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetISearchString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TreeView_GetISearchString(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SetToolTips(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_SetToolTips(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetToolTips(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_GetToolTips(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SetInsertMark(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TreeView_SetInsertMark(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SetUnicodeFormat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TreeView_SetUnicodeFormat(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetUnicodeFormat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TreeView_GetUnicodeFormat(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SetItemHeight(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_SetItemHeight(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetItemHeight(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_GetItemHeight(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SetBkColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_SetBkColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SetTextColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_SetTextColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetBkColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_GetBkColor(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetTextColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_GetTextColor(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SetScrollTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_SetScrollTime(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetScrollTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_GetScrollTime(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_SetInsertMarkColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_SetInsertMarkColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TreeView_GetInsertMarkColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TreeView_GetInsertMarkColor(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_SetItemExtra(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TabCtrl_SetItemExtra(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_SetItemSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TabCtrl_SetItemSize(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_RemoveImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.TabCtrl_RemoveImage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_SetPadding(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.TabCtrl_SetPadding(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_GetRowCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TabCtrl_GetRowCount(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_GetToolTips(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TabCtrl_GetToolTips(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_SetToolTips(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.TabCtrl_SetToolTips(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_GetCurFocus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TabCtrl_GetCurFocus(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_SetCurFocus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.TabCtrl_SetCurFocus(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_SetMinTabWidth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TabCtrl_SetMinTabWidth(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_DeselectAll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.TabCtrl_DeselectAll(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_HighlightItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TabCtrl_HighlightItem(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_SetExtendedStyle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TabCtrl_SetExtendedStyle(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_GetExtendedStyle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.TabCtrl_GetExtendedStyle(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_SetUnicodeFormat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TabCtrl_SetUnicodeFormat(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_GetUnicodeFormat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.TabCtrl_GetUnicodeFormat(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__TabCtrl_GetItemRect(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TRect;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TRectWrapper) then 
  Param2Rec := TRectWrapper.Create(Param2);
Param2 := TRectWrapper(Param2Rec).ObjToRec;
AResult := Commctrl.TabCtrl_GetItemRect(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TRectWrapper.Create(Param2)));
  end;
end;

procedure TatCommctrlLibrary.__Animate_Create(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Animate_Create(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Animate_Open(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.Animate_Open(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Animate_OpenEx(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.Animate_OpenEx(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Animate_Play(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.Animate_Play(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Animate_Stop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.Animate_Stop(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Animate_Close(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.Animate_Close(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Animate_Seek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.Animate_Seek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_GetCurSel(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSystemTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _SYSTEMTIMEWrapper) then 
  Param1Rec := _SYSTEMTIMEWrapper.Create(Param1);
Param1 := _SYSTEMTIMEWrapper(Param1Rec).ObjToRec;
AResult := Commctrl.MonthCal_GetCurSel(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_SYSTEMTIMEWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_SetCurSel(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.MonthCal_SetCurSel(VarToInteger(GetInputArg(0)),_SYSTEMTIMEWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_GetMaxSelCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.MonthCal_GetMaxSelCount(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_SetMaxSelCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.MonthCal_SetMaxSelCount(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_SetDayState(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.MonthCal_SetDayState(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),tagNMDAYSTATEWrapper(integer(GetInputArg(2))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_GetMinReqRect(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TRect;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TRectWrapper) then 
  Param1Rec := TRectWrapper.Create(Param1);
Param1 := TRectWrapper(Param1Rec).ObjToRec;
AResult := Commctrl.MonthCal_GetMinReqRect(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TRectWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_SetToday(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.MonthCal_SetToday(VarToInteger(GetInputArg(0)),_SYSTEMTIMEWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_GetToday(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSystemTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _SYSTEMTIMEWrapper) then 
  Param1Rec := _SYSTEMTIMEWrapper.Create(Param1);
Param1 := _SYSTEMTIMEWrapper(Param1Rec).ObjToRec;
AResult := Commctrl.MonthCal_GetToday(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_SYSTEMTIMEWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_HitTest(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TMCHitTestInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is MCHITTESTINFOWrapper) then 
  Param1Rec := MCHITTESTINFOWrapper.Create(Param1);
Param1 := MCHITTESTINFOWrapper(Param1Rec).ObjToRec;
AResult := Integer(Commctrl.MonthCal_HitTest(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(MCHITTESTINFOWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_SetColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.MonthCal_SetColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_GetColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.MonthCal_GetColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_SetFirstDayOfWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.MonthCal_SetFirstDayOfWeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_GetFirstDayOfWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.MonthCal_GetFirstDayOfWeek(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_GetMonthDelta(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.MonthCal_GetMonthDelta(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_SetMonthDelta(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.MonthCal_SetMonthDelta(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_GetMaxTodayWidth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.MonthCal_GetMaxTodayWidth(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_SetUnicodeFormat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.MonthCal_SetUnicodeFormat(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MonthCal_GetUnicodeFormat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.MonthCal_GetUnicodeFormat(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__DateTime_GetSystemTime(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSystemTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _SYSTEMTIMEWrapper) then 
  Param1Rec := _SYSTEMTIMEWrapper.Create(Param1);
Param1 := _SYSTEMTIMEWrapper(Param1Rec).ObjToRec;
AResult := Integer(Commctrl.DateTime_GetSystemTime(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_SYSTEMTIMEWrapper.Create(Param1)));
  end;
end;

procedure TatCommctrlLibrary.__DateTime_SetSystemTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.DateTime_SetSystemTime(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),_SYSTEMTIMEWrapper(integer(GetInputArg(2))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__DateTime_SetFormatA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.DateTime_SetFormatA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__DateTime_SetFormatW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.DateTime_SetFormatW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__DateTime_SetFormat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.DateTime_SetFormat(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__DateTime_SetMonthCalColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.DateTime_SetMonthCalColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__DateTime_GetMonthCalColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.DateTime_GetMonthCalColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__DateTime_GetMonthCal(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.DateTime_GetMonthCal(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__DateTime_SetMonthCalFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.DateTime_SetMonthCalFont(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatCommctrlLibrary.__DateTime_GetMonthCalFont(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.DateTime_GetMonthCalFont(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MAKEIPRANGE(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.MAKEIPRANGE(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__MAKEIPADDRESS(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.MAKEIPADDRESS(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__FIRST_IPADDRESS(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.FIRST_IPADDRESS(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__SECOND_IPADDRESS(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.SECOND_IPADDRESS(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__THIRD_IPADDRESS(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.THIRD_IPADDRESS(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__FOURTH_IPADDRESS(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.FOURTH_IPADDRESS(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Pager_SetChild(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.Pager_SetChild(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatCommctrlLibrary.__Pager_RecalcSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.Pager_RecalcSize(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatCommctrlLibrary.__Pager_ForwardMouse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.Pager_ForwardMouse(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatCommctrlLibrary.__Pager_SetBkColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Pager_SetBkColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Pager_GetBkColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Pager_GetBkColor(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Pager_SetBorder(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Pager_SetBorder(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Pager_GetBorder(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Pager_GetBorder(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Pager_SetPos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Pager_SetPos(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Pager_GetPos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Pager_GetPos(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Pager_SetButtonSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Pager_SetButtonSize(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Pager_GetButtonSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Pager_GetButtonSize(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__Pager_GetButtonState(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.Pager_GetButtonState(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__FlatSB_EnableScrollBar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.FlatSB_EnableScrollBar(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__FlatSB_ShowScrollBar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.FlatSB_ShowScrollBar(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__FlatSB_GetScrollRange(AMachine: TatVirtualMachine);
  var
  Param2: Integer;
  Param3: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
AResult := Commctrl.FlatSB_GetScrollRange(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2,Param3);
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatCommctrlLibrary.__FlatSB_GetScrollInfo(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TScrollInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is tagSCROLLINFOWrapper) then 
  Param2Rec := tagSCROLLINFOWrapper.Create(Param2);
Param2 := tagSCROLLINFOWrapper(Param2Rec).ObjToRec;
AResult := Commctrl.FlatSB_GetScrollInfo(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(tagSCROLLINFOWrapper.Create(Param2)));
  end;
end;

procedure TatCommctrlLibrary.__FlatSB_GetScrollPos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.FlatSB_GetScrollPos(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__FlatSB_SetScrollPos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.FlatSB_SetScrollPos(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__FlatSB_SetScrollInfo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Commctrl.FlatSB_SetScrollInfo(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),tagSCROLLINFOWrapper(integer(GetInputArg(2))).ObjToRec,GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__FlatSB_SetScrollRange(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.FlatSB_SetScrollRange(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),GetInputArg(4));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__FlatSB_SetScrollProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.FlatSB_SetScrollProp(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__InitializeFlatSB(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Commctrl.InitializeFlatSB(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommctrlLibrary.__UninitializeFlatSB(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Commctrl.UninitializeFlatSB(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatCommctrlLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('PropertySheetA',1,tkInteger,nil,__PropertySheetA,false,0).SetVarArgs([0]);
    DefineMethod('PropertySheetW',1,tkInteger,nil,__PropertySheetW,false,0).SetVarArgs([0]);
    DefineMethod('PropertySheet',1,tkInteger,nil,__PropertySheet,false,0).SetVarArgs([0]);
    DefineMethod('InitCommonControls',0,tkNone,nil,__InitCommonControls,false,0);
    DefineMethod('InitCommonControlsEx',1,tkVariant,nil,__InitCommonControlsEx,false,0).SetVarArgs([0]);
    DefineMethod('ImageList_Create',5,tkInteger,nil,__ImageList_Create,false,0);
    DefineMethod('ImageList_Destroy',1,tkVariant,nil,__ImageList_Destroy,false,0);
    DefineMethod('ImageList_GetImageCount',1,tkInteger,nil,__ImageList_GetImageCount,false,0);
    DefineMethod('ImageList_SetImageCount',2,tkInteger,nil,__ImageList_SetImageCount,false,0);
    DefineMethod('ImageList_Add',3,tkInteger,nil,__ImageList_Add,false,0);
    DefineMethod('ImageList_ReplaceIcon',3,tkInteger,nil,__ImageList_ReplaceIcon,false,0);
    DefineMethod('ImageList_SetBkColor',2,tkInteger,nil,__ImageList_SetBkColor,false,0);
    DefineMethod('ImageList_GetBkColor',1,tkInteger,nil,__ImageList_GetBkColor,false,0);
    DefineMethod('ImageList_SetOverlayImage',3,tkVariant,nil,__ImageList_SetOverlayImage,false,0);
    DefineMethod('ImageList_AddIcon',2,tkInteger,nil,__ImageList_AddIcon,false,0);
    DefineMethod('IndexToOverlayMask',1,tkInteger,nil,__IndexToOverlayMask,false,0);
    DefineMethod('ImageList_Draw',6,tkVariant,nil,__ImageList_Draw,false,0);
    DefineMethod('ImageList_Replace',4,tkVariant,nil,__ImageList_Replace,false,0);
    DefineMethod('ImageList_AddMasked',3,tkInteger,nil,__ImageList_AddMasked,false,0);
    DefineMethod('ImageList_DrawEx',10,tkVariant,nil,__ImageList_DrawEx,false,0);
    DefineMethod('ImageList_Remove',2,tkVariant,nil,__ImageList_Remove,false,0);
    DefineMethod('ImageList_GetIcon',3,tkInteger,nil,__ImageList_GetIcon,false,0);
    DefineMethod('ImageList_LoadImageA',7,tkInteger,nil,__ImageList_LoadImageA,false,0);
    DefineMethod('ImageList_LoadImageW',7,tkInteger,nil,__ImageList_LoadImageW,false,0);
    DefineMethod('ImageList_LoadImage',7,tkInteger,nil,__ImageList_LoadImage,false,0);
    DefineMethod('ImageList_Copy',5,tkInteger,nil,__ImageList_Copy,false,0);
    DefineMethod('ImageList_BeginDrag',4,tkVariant,nil,__ImageList_BeginDrag,false,0);
    DefineMethod('ImageList_EndDrag',0,tkVariant,nil,__ImageList_EndDrag,false,0);
    DefineMethod('ImageList_DragEnter',3,tkVariant,nil,__ImageList_DragEnter,false,0);
    DefineMethod('ImageList_DragLeave',1,tkVariant,nil,__ImageList_DragLeave,false,0);
    DefineMethod('ImageList_DragMove',2,tkVariant,nil,__ImageList_DragMove,false,0);
    DefineMethod('ImageList_SetDragCursorImage',4,tkVariant,nil,__ImageList_SetDragCursorImage,false,0);
    DefineMethod('ImageList_DragShowNolock',1,tkVariant,nil,__ImageList_DragShowNolock,false,0);
    DefineMethod('ImageList_RemoveAll',1,tkNone,nil,__ImageList_RemoveAll,false,0);
    DefineMethod('ImageList_ExtractIcon',3,tkInteger,nil,__ImageList_ExtractIcon,false,0);
    DefineMethod('ImageList_LoadBitmap',5,tkInteger,nil,__ImageList_LoadBitmap,false,0);
    DefineMethod('ImageList_GetIconSize',3,tkVariant,nil,__ImageList_GetIconSize,false,0).SetVarArgs([1,2]);
    DefineMethod('ImageList_SetIconSize',3,tkVariant,nil,__ImageList_SetIconSize,false,0);
    DefineMethod('ImageList_GetImageInfo',3,tkVariant,nil,__ImageList_GetImageInfo,false,0).SetVarArgs([2]);
    DefineMethod('ImageList_Merge',6,tkInteger,nil,__ImageList_Merge,false,0);
    DefineMethod('ImageList_Duplicate',1,tkInteger,nil,__ImageList_Duplicate,false,0);
    DefineMethod('Header_GetItemCount',1,tkInteger,nil,__Header_GetItemCount,false,0);
    DefineMethod('Header_InsertItem',3,tkInteger,nil,__Header_InsertItem,false,0);
    DefineMethod('Header_DeleteItem',2,tkVariant,nil,__Header_DeleteItem,false,0);
    DefineMethod('Header_GetItem',3,tkVariant,nil,__Header_GetItem,false,0).SetVarArgs([2]);
    DefineMethod('Header_SetItem',3,tkVariant,nil,__Header_SetItem,false,0);
    DefineMethod('Header_SetImageList',2,tkInteger,nil,__Header_SetImageList,false,0);
    DefineMethod('Header_GetImageList',1,tkInteger,nil,__Header_GetImageList,false,0);
    DefineMethod('Header_OrderToIndex',2,tkInteger,nil,__Header_OrderToIndex,false,0);
    DefineMethod('Header_CreateDragImage',2,tkInteger,nil,__Header_CreateDragImage,false,0);
    DefineMethod('Header_SetHotDivider',3,tkInteger,nil,__Header_SetHotDivider,false,0);
    DefineMethod('Header_SetUnicodeFormat',2,tkInteger,nil,__Header_SetUnicodeFormat,false,0);
    DefineMethod('Header_GetUnicodeFormat',1,tkInteger,nil,__Header_GetUnicodeFormat,false,0);
    DefineMethod('CreateStatusWindowA',4,tkInteger,nil,__CreateStatusWindowA,false,0);
    DefineMethod('CreateStatusWindowW',4,tkInteger,nil,__CreateStatusWindowW,false,0);
    DefineMethod('CreateStatusWindow',4,tkInteger,nil,__CreateStatusWindow,false,0);
    DefineMethod('MakeDragList',1,tkNone,nil,__MakeDragList,false,0);
    DefineMethod('DrawInsert',3,tkNone,nil,__DrawInsert,false,0);
    DefineMethod('LBItemFromPt',3,tkInteger,nil,__LBItemFromPt,false,0);
    DefineMethod('CreateUpDownControl',12,tkInteger,nil,__CreateUpDownControl,false,0);
    DefineMethod('ListView_SetUnicodeFormat',2,tkInteger,nil,__ListView_SetUnicodeFormat,false,0);
    DefineMethod('ListView_GetUnicodeFormat',1,tkVariant,nil,__ListView_GetUnicodeFormat,false,0);
    DefineMethod('ListView_GetBkColor',1,tkInteger,nil,__ListView_GetBkColor,false,0);
    DefineMethod('ListView_SetBkColor',2,tkVariant,nil,__ListView_SetBkColor,false,0);
    DefineMethod('ListView_GetImageList',2,tkInteger,nil,__ListView_GetImageList,false,0);
    DefineMethod('ListView_SetImageList',3,tkInteger,nil,__ListView_SetImageList,false,0);
    DefineMethod('ListView_GetItemCount',1,tkInteger,nil,__ListView_GetItemCount,false,0);
    DefineMethod('IndexToStateImageMask',1,tkInteger,nil,__IndexToStateImageMask,false,0);
    DefineMethod('ListView_GetItemA',2,tkVariant,nil,__ListView_GetItemA,false,0).SetVarArgs([1]);
    DefineMethod('ListView_GetItemW',2,tkVariant,nil,__ListView_GetItemW,false,0).SetVarArgs([1]);
    DefineMethod('ListView_GetItem',2,tkVariant,nil,__ListView_GetItem,false,0).SetVarArgs([1]);
    DefineMethod('ListView_SetItemA',2,tkVariant,nil,__ListView_SetItemA,false,0);
    DefineMethod('ListView_SetItemW',2,tkVariant,nil,__ListView_SetItemW,false,0);
    DefineMethod('ListView_SetItem',2,tkVariant,nil,__ListView_SetItem,false,0);
    DefineMethod('ListView_InsertItemA',2,tkInteger,nil,__ListView_InsertItemA,false,0);
    DefineMethod('ListView_InsertItemW',2,tkInteger,nil,__ListView_InsertItemW,false,0);
    DefineMethod('ListView_InsertItem',2,tkInteger,nil,__ListView_InsertItem,false,0);
    DefineMethod('ListView_DeleteItem',2,tkVariant,nil,__ListView_DeleteItem,false,0);
    DefineMethod('ListView_DeleteAllItems',1,tkVariant,nil,__ListView_DeleteAllItems,false,0);
    DefineMethod('ListView_GetCallbackMask',1,tkInteger,nil,__ListView_GetCallbackMask,false,0);
    DefineMethod('ListView_SetCallbackMask',2,tkVariant,nil,__ListView_SetCallbackMask,false,0);
    DefineMethod('ListView_GetNextItem',3,tkInteger,nil,__ListView_GetNextItem,false,0);
    DefineMethod('ListView_FindItemA',3,tkInteger,nil,__ListView_FindItemA,false,0);
    DefineMethod('ListView_FindItemW',3,tkInteger,nil,__ListView_FindItemW,false,0);
    DefineMethod('ListView_FindItem',3,tkInteger,nil,__ListView_FindItem,false,0);
    DefineMethod('ListView_GetItemRect',4,tkVariant,nil,__ListView_GetItemRect,false,0).SetVarArgs([2]);
    DefineMethod('ListView_SetItemPosition',4,tkVariant,nil,__ListView_SetItemPosition,false,0);
    DefineMethod('ListView_GetItemPosition',3,tkVariant,nil,__ListView_GetItemPosition,false,0).SetVarArgs([2]);
    DefineMethod('ListView_GetStringWidthA',2,tkInteger,nil,__ListView_GetStringWidthA,false,0);
    DefineMethod('ListView_GetStringWidthW',2,tkInteger,nil,__ListView_GetStringWidthW,false,0);
    DefineMethod('ListView_GetStringWidth',2,tkInteger,nil,__ListView_GetStringWidth,false,0);
    DefineMethod('ListView_HitTest',2,tkInteger,nil,__ListView_HitTest,false,0).SetVarArgs([1]);
    DefineMethod('ListView_EnsureVisible',3,tkVariant,nil,__ListView_EnsureVisible,false,0);
    DefineMethod('ListView_Scroll',3,tkVariant,nil,__ListView_Scroll,false,0);
    DefineMethod('ListView_RedrawItems',3,tkVariant,nil,__ListView_RedrawItems,false,0);
    DefineMethod('ListView_Arrange',2,tkVariant,nil,__ListView_Arrange,false,0);
    DefineMethod('ListView_EditLabelA',2,tkInteger,nil,__ListView_EditLabelA,false,0);
    DefineMethod('ListView_EditLabelW',2,tkInteger,nil,__ListView_EditLabelW,false,0);
    DefineMethod('ListView_EditLabel',2,tkInteger,nil,__ListView_EditLabel,false,0);
    DefineMethod('ListView_GetEditControl',1,tkInteger,nil,__ListView_GetEditControl,false,0);
    DefineMethod('ListView_GetColumnA',3,tkVariant,nil,__ListView_GetColumnA,false,0).SetVarArgs([2]);
    DefineMethod('ListView_GetColumnW',3,tkVariant,nil,__ListView_GetColumnW,false,0).SetVarArgs([2]);
    DefineMethod('ListView_GetColumn',3,tkVariant,nil,__ListView_GetColumn,false,0).SetVarArgs([2]);
    DefineMethod('ListView_SetColumnA',3,tkVariant,nil,__ListView_SetColumnA,false,0);
    DefineMethod('ListView_SetColumnW',3,tkVariant,nil,__ListView_SetColumnW,false,0);
    DefineMethod('ListView_SetColumn',3,tkVariant,nil,__ListView_SetColumn,false,0);
    DefineMethod('ListView_InsertColumnA',3,tkInteger,nil,__ListView_InsertColumnA,false,0);
    DefineMethod('ListView_InsertColumnW',3,tkInteger,nil,__ListView_InsertColumnW,false,0);
    DefineMethod('ListView_InsertColumn',3,tkInteger,nil,__ListView_InsertColumn,false,0);
    DefineMethod('ListView_DeleteColumn',2,tkVariant,nil,__ListView_DeleteColumn,false,0);
    DefineMethod('ListView_GetColumnWidth',2,tkInteger,nil,__ListView_GetColumnWidth,false,0);
    DefineMethod('ListView_SetColumnWidth',3,tkVariant,nil,__ListView_SetColumnWidth,false,0);
    DefineMethod('ListView_GetHeader',1,tkInteger,nil,__ListView_GetHeader,false,0);
    DefineMethod('ListView_CreateDragImage',3,tkInteger,nil,__ListView_CreateDragImage,false,0);
    DefineMethod('ListView_GetViewRect',2,tkVariant,nil,__ListView_GetViewRect,false,0).SetVarArgs([1]);
    DefineMethod('ListView_GetTextColor',1,tkInteger,nil,__ListView_GetTextColor,false,0);
    DefineMethod('ListView_SetTextColor',2,tkVariant,nil,__ListView_SetTextColor,false,0);
    DefineMethod('ListView_GetTextBkColor',1,tkInteger,nil,__ListView_GetTextBkColor,false,0);
    DefineMethod('ListView_SetTextBkColor',2,tkVariant,nil,__ListView_SetTextBkColor,false,0);
    DefineMethod('ListView_GetTopIndex',1,tkInteger,nil,__ListView_GetTopIndex,false,0);
    DefineMethod('ListView_GetCountPerPage',1,tkInteger,nil,__ListView_GetCountPerPage,false,0);
    DefineMethod('ListView_GetOrigin',2,tkVariant,nil,__ListView_GetOrigin,false,0).SetVarArgs([1]);
    DefineMethod('ListView_Update',2,tkVariant,nil,__ListView_Update,false,0);
    DefineMethod('ListView_SetItemState',4,tkVariant,nil,__ListView_SetItemState,false,0);
    DefineMethod('ListView_GetItemState',3,tkInteger,nil,__ListView_GetItemState,false,0);
    DefineMethod('ListView_GetCheckState',2,tkInteger,nil,__ListView_GetCheckState,false,0);
    DefineMethod('ListView_SetCheckState',3,tkNone,nil,__ListView_SetCheckState,false,0);
    DefineMethod('ListView_GetItemTextA',5,tkInteger,nil,__ListView_GetItemTextA,false,0);
    DefineMethod('ListView_GetItemTextW',5,tkInteger,nil,__ListView_GetItemTextW,false,0);
    DefineMethod('ListView_GetItemText',5,tkInteger,nil,__ListView_GetItemText,false,0);
    DefineMethod('ListView_SetItemTextA',4,tkVariant,nil,__ListView_SetItemTextA,false,0);
    DefineMethod('ListView_SetItemTextW',4,tkVariant,nil,__ListView_SetItemTextW,false,0);
    DefineMethod('ListView_SetItemText',4,tkVariant,nil,__ListView_SetItemText,false,0);
    DefineMethod('ListView_SetItemCount',2,tkNone,nil,__ListView_SetItemCount,false,0);
    DefineMethod('ListView_SetItemCountEx',3,tkNone,nil,__ListView_SetItemCountEx,false,0);
    DefineMethod('ListView_SetItemPosition32',4,tkNone,nil,__ListView_SetItemPosition32,false,0);
    DefineMethod('ListView_GetSelectedCount',1,tkInteger,nil,__ListView_GetSelectedCount,false,0);
    DefineMethod('ListView_GetItemSpacing',2,tkInteger,nil,__ListView_GetItemSpacing,false,0);
    DefineMethod('ListView_GetISearchStringA',2,tkVariant,nil,__ListView_GetISearchStringA,false,0);
    DefineMethod('ListView_GetISearchStringW',2,tkVariant,nil,__ListView_GetISearchStringW,false,0);
    DefineMethod('ListView_GetISearchString',2,tkVariant,nil,__ListView_GetISearchString,false,0);
    DefineMethod('ListView_SetIconSpacing',3,tkInteger,nil,__ListView_SetIconSpacing,false,0);
    DefineMethod('ListView_SetExtendedListViewStyle',2,tkVariant,nil,__ListView_SetExtendedListViewStyle,false,0);
    DefineMethod('ListView_GetExtendedListViewStyle',1,tkInteger,nil,__ListView_GetExtendedListViewStyle,false,0);
    DefineMethod('ListView_SetHotItem',2,tkInteger,nil,__ListView_SetHotItem,false,0);
    DefineMethod('ListView_GetHotItem',1,tkInteger,nil,__ListView_GetHotItem,false,0);
    DefineMethod('ListView_SetHotCursor',2,tkInteger,nil,__ListView_SetHotCursor,false,0);
    DefineMethod('ListView_GetHotCursor',1,tkInteger,nil,__ListView_GetHotCursor,false,0);
    DefineMethod('ListView_ApproximateViewRect',4,tkInteger,nil,__ListView_ApproximateViewRect,false,0);
    DefineMethod('ListView_GetSelectionMark',1,tkInteger,nil,__ListView_GetSelectionMark,false,0);
    DefineMethod('ListView_SetSelectionMark',2,tkInteger,nil,__ListView_SetSelectionMark,false,0);
    DefineMethod('ListView_SetHoverTime',2,tkInteger,nil,__ListView_SetHoverTime,false,0);
    DefineMethod('ListView_GetHoverTime',1,tkInteger,nil,__ListView_GetHoverTime,false,0);
    DefineMethod('ListView_SetToolTips',2,tkInteger,nil,__ListView_SetToolTips,false,0);
    DefineMethod('ListView_GetToolTips',1,tkInteger,nil,__ListView_GetToolTips,false,0);
    DefineMethod('TreeView_DeleteAllItems',1,tkVariant,nil,__TreeView_DeleteAllItems,false,0);
    DefineMethod('TreeView_GetCount',1,tkInteger,nil,__TreeView_GetCount,false,0);
    DefineMethod('TreeView_GetIndent',1,tkInteger,nil,__TreeView_GetIndent,false,0);
    DefineMethod('TreeView_SetIndent',2,tkVariant,nil,__TreeView_SetIndent,false,0);
    DefineMethod('TreeView_GetImageList',2,tkInteger,nil,__TreeView_GetImageList,false,0);
    DefineMethod('TreeView_SetImageList',3,tkInteger,nil,__TreeView_SetImageList,false,0);
    DefineMethod('TreeView_GetItemA',2,tkVariant,nil,__TreeView_GetItemA,false,0).SetVarArgs([1]);
    DefineMethod('TreeView_GetItemW',2,tkVariant,nil,__TreeView_GetItemW,false,0).SetVarArgs([1]);
    DefineMethod('TreeView_GetItem',2,tkVariant,nil,__TreeView_GetItem,false,0).SetVarArgs([1]);
    DefineMethod('TreeView_SetItemA',2,tkVariant,nil,__TreeView_SetItemA,false,0);
    DefineMethod('TreeView_SetItemW',2,tkVariant,nil,__TreeView_SetItemW,false,0);
    DefineMethod('TreeView_SetItem',2,tkVariant,nil,__TreeView_SetItem,false,0);
    DefineMethod('TreeView_GetEditControl',1,tkInteger,nil,__TreeView_GetEditControl,false,0);
    DefineMethod('TreeView_GetVisibleCount',1,tkInteger,nil,__TreeView_GetVisibleCount,false,0);
    DefineMethod('TreeView_SortChildrenCB',3,tkVariant,nil,__TreeView_SortChildrenCB,false,0);
    DefineMethod('TreeView_EndEditLabelNow',2,tkVariant,nil,__TreeView_EndEditLabelNow,false,0);
    DefineMethod('TreeView_GetISearchStringA',2,tkVariant,nil,__TreeView_GetISearchStringA,false,0);
    DefineMethod('TreeView_GetISearchStringW',2,tkVariant,nil,__TreeView_GetISearchStringW,false,0);
    DefineMethod('TreeView_GetISearchString',2,tkVariant,nil,__TreeView_GetISearchString,false,0);
    DefineMethod('TreeView_SetToolTips',2,tkInteger,nil,__TreeView_SetToolTips,false,0);
    DefineMethod('TreeView_GetToolTips',1,tkInteger,nil,__TreeView_GetToolTips,false,0);
    DefineMethod('TreeView_SetInsertMark',3,tkVariant,nil,__TreeView_SetInsertMark,false,0);
    DefineMethod('TreeView_SetUnicodeFormat',2,tkVariant,nil,__TreeView_SetUnicodeFormat,false,0);
    DefineMethod('TreeView_GetUnicodeFormat',1,tkVariant,nil,__TreeView_GetUnicodeFormat,false,0);
    DefineMethod('TreeView_SetItemHeight',2,tkInteger,nil,__TreeView_SetItemHeight,false,0);
    DefineMethod('TreeView_GetItemHeight',1,tkInteger,nil,__TreeView_GetItemHeight,false,0);
    DefineMethod('TreeView_SetBkColor',2,tkInteger,nil,__TreeView_SetBkColor,false,0);
    DefineMethod('TreeView_SetTextColor',2,tkInteger,nil,__TreeView_SetTextColor,false,0);
    DefineMethod('TreeView_GetBkColor',1,tkInteger,nil,__TreeView_GetBkColor,false,0);
    DefineMethod('TreeView_GetTextColor',1,tkInteger,nil,__TreeView_GetTextColor,false,0);
    DefineMethod('TreeView_SetScrollTime',2,tkInteger,nil,__TreeView_SetScrollTime,false,0);
    DefineMethod('TreeView_GetScrollTime',1,tkInteger,nil,__TreeView_GetScrollTime,false,0);
    DefineMethod('TreeView_SetInsertMarkColor',2,tkInteger,nil,__TreeView_SetInsertMarkColor,false,0);
    DefineMethod('TreeView_GetInsertMarkColor',1,tkInteger,nil,__TreeView_GetInsertMarkColor,false,0);
    DefineMethod('TabCtrl_SetItemExtra',2,tkVariant,nil,__TabCtrl_SetItemExtra,false,0);
    DefineMethod('TabCtrl_SetItemSize',3,tkInteger,nil,__TabCtrl_SetItemSize,false,0);
    DefineMethod('TabCtrl_RemoveImage',2,tkNone,nil,__TabCtrl_RemoveImage,false,0);
    DefineMethod('TabCtrl_SetPadding',3,tkNone,nil,__TabCtrl_SetPadding,false,0);
    DefineMethod('TabCtrl_GetRowCount',1,tkInteger,nil,__TabCtrl_GetRowCount,false,0);
    DefineMethod('TabCtrl_GetToolTips',1,tkInteger,nil,__TabCtrl_GetToolTips,false,0);
    DefineMethod('TabCtrl_SetToolTips',2,tkNone,nil,__TabCtrl_SetToolTips,false,0);
    DefineMethod('TabCtrl_GetCurFocus',1,tkInteger,nil,__TabCtrl_GetCurFocus,false,0);
    DefineMethod('TabCtrl_SetCurFocus',2,tkNone,nil,__TabCtrl_SetCurFocus,false,0);
    DefineMethod('TabCtrl_SetMinTabWidth',2,tkInteger,nil,__TabCtrl_SetMinTabWidth,false,0);
    DefineMethod('TabCtrl_DeselectAll',2,tkNone,nil,__TabCtrl_DeselectAll,false,0);
    DefineMethod('TabCtrl_HighlightItem',3,tkVariant,nil,__TabCtrl_HighlightItem,false,0);
    DefineMethod('TabCtrl_SetExtendedStyle',2,tkInteger,nil,__TabCtrl_SetExtendedStyle,false,0);
    DefineMethod('TabCtrl_GetExtendedStyle',1,tkInteger,nil,__TabCtrl_GetExtendedStyle,false,0);
    DefineMethod('TabCtrl_SetUnicodeFormat',2,tkVariant,nil,__TabCtrl_SetUnicodeFormat,false,0);
    DefineMethod('TabCtrl_GetUnicodeFormat',1,tkVariant,nil,__TabCtrl_GetUnicodeFormat,false,0);
    DefineMethod('TabCtrl_GetItemRect',3,tkVariant,nil,__TabCtrl_GetItemRect,false,0).SetVarArgs([2]);
    DefineMethod('Animate_Create',4,tkInteger,nil,__Animate_Create,false,0);
    DefineMethod('Animate_Open',2,tkVariant,nil,__Animate_Open,false,0);
    DefineMethod('Animate_OpenEx',3,tkVariant,nil,__Animate_OpenEx,false,0);
    DefineMethod('Animate_Play',4,tkVariant,nil,__Animate_Play,false,0);
    DefineMethod('Animate_Stop',1,tkVariant,nil,__Animate_Stop,false,0);
    DefineMethod('Animate_Close',1,tkVariant,nil,__Animate_Close,false,0);
    DefineMethod('Animate_Seek',2,tkVariant,nil,__Animate_Seek,false,0);
    DefineMethod('MonthCal_GetCurSel',2,tkVariant,nil,__MonthCal_GetCurSel,false,0).SetVarArgs([1]);
    DefineMethod('MonthCal_SetCurSel',2,tkVariant,nil,__MonthCal_SetCurSel,false,0);
    DefineMethod('MonthCal_GetMaxSelCount',1,tkInteger,nil,__MonthCal_GetMaxSelCount,false,0);
    DefineMethod('MonthCal_SetMaxSelCount',2,tkVariant,nil,__MonthCal_SetMaxSelCount,false,0);
    DefineMethod('MonthCal_SetDayState',3,tkVariant,nil,__MonthCal_SetDayState,false,0);
    DefineMethod('MonthCal_GetMinReqRect',2,tkVariant,nil,__MonthCal_GetMinReqRect,false,0).SetVarArgs([1]);
    DefineMethod('MonthCal_SetToday',2,tkVariant,nil,__MonthCal_SetToday,false,0);
    DefineMethod('MonthCal_GetToday',2,tkVariant,nil,__MonthCal_GetToday,false,0).SetVarArgs([1]);
    DefineMethod('MonthCal_HitTest',2,tkInteger,nil,__MonthCal_HitTest,false,0).SetVarArgs([1]);
    DefineMethod('MonthCal_SetColor',3,tkInteger,nil,__MonthCal_SetColor,false,0);
    DefineMethod('MonthCal_GetColor',2,tkInteger,nil,__MonthCal_GetColor,false,0);
    DefineMethod('MonthCal_SetFirstDayOfWeek',2,tkInteger,nil,__MonthCal_SetFirstDayOfWeek,false,0);
    DefineMethod('MonthCal_GetFirstDayOfWeek',1,tkInteger,nil,__MonthCal_GetFirstDayOfWeek,false,0);
    DefineMethod('MonthCal_GetMonthDelta',1,tkInteger,nil,__MonthCal_GetMonthDelta,false,0);
    DefineMethod('MonthCal_SetMonthDelta',2,tkInteger,nil,__MonthCal_SetMonthDelta,false,0);
    DefineMethod('MonthCal_GetMaxTodayWidth',1,tkInteger,nil,__MonthCal_GetMaxTodayWidth,false,0);
    DefineMethod('MonthCal_SetUnicodeFormat',2,tkVariant,nil,__MonthCal_SetUnicodeFormat,false,0);
    DefineMethod('MonthCal_GetUnicodeFormat',1,tkVariant,nil,__MonthCal_GetUnicodeFormat,false,0);
    DefineMethod('DateTime_GetSystemTime',2,tkInteger,nil,__DateTime_GetSystemTime,false,0).SetVarArgs([1]);
    DefineMethod('DateTime_SetSystemTime',3,tkVariant,nil,__DateTime_SetSystemTime,false,0);
    DefineMethod('DateTime_SetFormatA',2,tkVariant,nil,__DateTime_SetFormatA,false,0);
    DefineMethod('DateTime_SetFormatW',2,tkVariant,nil,__DateTime_SetFormatW,false,0);
    DefineMethod('DateTime_SetFormat',2,tkVariant,nil,__DateTime_SetFormat,false,0);
    DefineMethod('DateTime_SetMonthCalColor',3,tkInteger,nil,__DateTime_SetMonthCalColor,false,0);
    DefineMethod('DateTime_GetMonthCalColor',2,tkInteger,nil,__DateTime_GetMonthCalColor,false,0);
    DefineMethod('DateTime_GetMonthCal',1,tkInteger,nil,__DateTime_GetMonthCal,false,0);
    DefineMethod('DateTime_SetMonthCalFont',3,tkNone,nil,__DateTime_SetMonthCalFont,false,0);
    DefineMethod('DateTime_GetMonthCalFont',1,tkInteger,nil,__DateTime_GetMonthCalFont,false,0);
    DefineMethod('MAKEIPRANGE',2,tkInteger,nil,__MAKEIPRANGE,false,0);
    DefineMethod('MAKEIPADDRESS',4,tkInteger,nil,__MAKEIPADDRESS,false,0);
    DefineMethod('FIRST_IPADDRESS',1,tkInteger,nil,__FIRST_IPADDRESS,false,0);
    DefineMethod('SECOND_IPADDRESS',1,tkInteger,nil,__SECOND_IPADDRESS,false,0);
    DefineMethod('THIRD_IPADDRESS',1,tkInteger,nil,__THIRD_IPADDRESS,false,0);
    DefineMethod('FOURTH_IPADDRESS',1,tkInteger,nil,__FOURTH_IPADDRESS,false,0);
    DefineMethod('Pager_SetChild',2,tkNone,nil,__Pager_SetChild,false,0);
    DefineMethod('Pager_RecalcSize',1,tkNone,nil,__Pager_RecalcSize,false,0);
    DefineMethod('Pager_ForwardMouse',2,tkNone,nil,__Pager_ForwardMouse,false,0);
    DefineMethod('Pager_SetBkColor',2,tkInteger,nil,__Pager_SetBkColor,false,0);
    DefineMethod('Pager_GetBkColor',1,tkInteger,nil,__Pager_GetBkColor,false,0);
    DefineMethod('Pager_SetBorder',2,tkInteger,nil,__Pager_SetBorder,false,0);
    DefineMethod('Pager_GetBorder',1,tkInteger,nil,__Pager_GetBorder,false,0);
    DefineMethod('Pager_SetPos',2,tkInteger,nil,__Pager_SetPos,false,0);
    DefineMethod('Pager_GetPos',1,tkInteger,nil,__Pager_GetPos,false,0);
    DefineMethod('Pager_SetButtonSize',2,tkInteger,nil,__Pager_SetButtonSize,false,0);
    DefineMethod('Pager_GetButtonSize',1,tkInteger,nil,__Pager_GetButtonSize,false,0);
    DefineMethod('Pager_GetButtonState',2,tkInteger,nil,__Pager_GetButtonState,false,0);
    DefineMethod('FlatSB_EnableScrollBar',3,tkVariant,nil,__FlatSB_EnableScrollBar,false,0);
    DefineMethod('FlatSB_ShowScrollBar',3,tkVariant,nil,__FlatSB_ShowScrollBar,false,0);
    DefineMethod('FlatSB_GetScrollRange',4,tkVariant,nil,__FlatSB_GetScrollRange,false,0).SetVarArgs([2,3]);
    DefineMethod('FlatSB_GetScrollInfo',3,tkVariant,nil,__FlatSB_GetScrollInfo,false,0).SetVarArgs([2]);
    DefineMethod('FlatSB_GetScrollPos',2,tkInteger,nil,__FlatSB_GetScrollPos,false,0);
    DefineMethod('FlatSB_SetScrollPos',4,tkInteger,nil,__FlatSB_SetScrollPos,false,0);
    DefineMethod('FlatSB_SetScrollInfo',4,tkInteger,nil,__FlatSB_SetScrollInfo,false,0);
    DefineMethod('FlatSB_SetScrollRange',5,tkVariant,nil,__FlatSB_SetScrollRange,false,0);
    DefineMethod('FlatSB_SetScrollProp',4,tkVariant,nil,__FlatSB_SetScrollProp,false,0);
    DefineMethod('InitializeFlatSB',1,tkVariant,nil,__InitializeFlatSB,false,0);
    DefineMethod('UninitializeFlatSB',1,tkNone,nil,__UninitializeFlatSB,false,0);
    AddConstant('MAXPROPPAGES',MAXPROPPAGES);
    AddConstant('PSP_DEFAULT',PSP_DEFAULT);
    AddConstant('PSP_DLGINDIRECT',PSP_DLGINDIRECT);
    AddConstant('PSP_USEHICON',PSP_USEHICON);
    AddConstant('PSP_USEICONID',PSP_USEICONID);
    AddConstant('PSP_USETITLE',PSP_USETITLE);
    AddConstant('PSP_RTLREADING',PSP_RTLREADING);
    AddConstant('PSP_HASHELP',PSP_HASHELP);
    AddConstant('PSP_USEREFPARENT',PSP_USEREFPARENT);
    AddConstant('PSP_USECALLBACK',PSP_USECALLBACK);
    AddConstant('PSP_PREMATURE',PSP_PREMATURE);
    AddConstant('PSP_HIDEHEADER',PSP_HIDEHEADER);
    AddConstant('PSP_USEHEADERTITLE',PSP_USEHEADERTITLE);
    AddConstant('PSP_USEHEADERSUBTITLE',PSP_USEHEADERSUBTITLE);
    AddConstant('PSPCB_RELEASE',PSPCB_RELEASE);
    AddConstant('PSPCB_CREATE',PSPCB_CREATE);
    AddConstant('PSH_DEFAULT',PSH_DEFAULT);
    AddConstant('PSH_PROPTITLE',PSH_PROPTITLE);
    AddConstant('PSH_USEHICON',PSH_USEHICON);
    AddConstant('PSH_USEICONID',PSH_USEICONID);
    AddConstant('PSH_PROPSHEETPAGE',PSH_PROPSHEETPAGE);
    AddConstant('PSH_WIZARDHASFINISH',PSH_WIZARDHASFINISH);
    AddConstant('PSH_MULTILINETABS',PSH_MULTILINETABS);
    AddConstant('PSH_WIZARD',PSH_WIZARD);
    AddConstant('PSH_USEPSTARTPAGE',PSH_USEPSTARTPAGE);
    AddConstant('PSH_NOAPPLYNOW',PSH_NOAPPLYNOW);
    AddConstant('PSH_USECALLBACK',PSH_USECALLBACK);
    AddConstant('PSH_HASHELP',PSH_HASHELP);
    AddConstant('PSH_MODELESS',PSH_MODELESS);
    AddConstant('PSH_RTLREADING',PSH_RTLREADING);
    AddConstant('PSH_WIZARDCONTEXTHELP',PSH_WIZARDCONTEXTHELP);
    AddConstant('PSH_WIZARD97',PSH_WIZARD97);
    AddConstant('PSH_WATERMARK',PSH_WATERMARK);
    AddConstant('PSH_USEHBMWATERMARK',PSH_USEHBMWATERMARK);
    AddConstant('PSH_USEHPLWATERMARK',PSH_USEHPLWATERMARK);
    AddConstant('PSH_STRETCHWATERMARK',PSH_STRETCHWATERMARK);
    AddConstant('PSH_HEADER',PSH_HEADER);
    AddConstant('PSH_USEHBMHEADER',PSH_USEHBMHEADER);
    AddConstant('PSH_USEPAGELANG',PSH_USEPAGELANG);
    AddConstant('PSCB_INITIALIZED',PSCB_INITIALIZED);
    AddConstant('PSCB_PRECREATE',PSCB_PRECREATE);
    AddConstant('PSN_FIRST',PSN_FIRST);
    AddConstant('PSN_LAST',PSN_LAST);
    AddConstant('PSN_SETACTIVE',PSN_SETACTIVE);
    AddConstant('PSN_KILLACTIVE',PSN_KILLACTIVE);
    AddConstant('PSN_APPLY',PSN_APPLY);
    AddConstant('PSN_RESET',PSN_RESET);
    AddConstant('PSN_HELP',PSN_HELP);
    AddConstant('PSN_WIZBACK',PSN_WIZBACK);
    AddConstant('PSN_WIZNEXT',PSN_WIZNEXT);
    AddConstant('PSN_WIZFINISH',PSN_WIZFINISH);
    AddConstant('PSN_QUERYCANCEL',PSN_QUERYCANCEL);
    AddConstant('PSN_GETOBJECT',PSN_GETOBJECT);
    AddConstant('PSNRET_NOERROR',PSNRET_NOERROR);
    AddConstant('PSNRET_INVALID',PSNRET_INVALID);
    AddConstant('PSNRET_INVALID_NOCHANGEPAGE',PSNRET_INVALID_NOCHANGEPAGE);
    AddConstant('PSM_SETCURSEL',PSM_SETCURSEL);
    AddConstant('PSM_REMOVEPAGE',PSM_REMOVEPAGE);
    AddConstant('PSM_ADDPAGE',PSM_ADDPAGE);
    AddConstant('PSM_CHANGED',PSM_CHANGED);
    AddConstant('PSM_RESTARTWINDOWS',PSM_RESTARTWINDOWS);
    AddConstant('PSM_REBOOTSYSTEM',PSM_REBOOTSYSTEM);
    AddConstant('PSM_CANCELTOCLOSE',PSM_CANCELTOCLOSE);
    AddConstant('PSM_QUERYSIBLINGS',PSM_QUERYSIBLINGS);
    AddConstant('PSM_UNCHANGED',PSM_UNCHANGED);
    AddConstant('PSM_APPLY',PSM_APPLY);
    AddConstant('PSM_SETTITLE',PSM_SETTITLE);
    AddConstant('PSM_SETTITLEW',PSM_SETTITLEW);
    AddConstant('PSM_SETWIZBUTTONS',PSM_SETWIZBUTTONS);
    AddConstant('PSM_PRESSBUTTON',PSM_PRESSBUTTON);
    AddConstant('PSM_SETCURSELID',PSM_SETCURSELID);
    AddConstant('PSM_SETFINISHTEXT',PSM_SETFINISHTEXT);
    AddConstant('PSM_SETFINISHTEXTW',PSM_SETFINISHTEXTW);
    AddConstant('PSM_GETTABCONTROL',PSM_GETTABCONTROL);
    AddConstant('PSM_ISDIALOGMESSAGE',PSM_ISDIALOGMESSAGE);
    AddConstant('PSWIZB_BACK',PSWIZB_BACK);
    AddConstant('PSWIZB_NEXT',PSWIZB_NEXT);
    AddConstant('PSWIZB_FINISH',PSWIZB_FINISH);
    AddConstant('PSWIZB_DISABLEDFINISH',PSWIZB_DISABLEDFINISH);
    AddConstant('PSBTN_BACK',PSBTN_BACK);
    AddConstant('PSBTN_NEXT',PSBTN_NEXT);
    AddConstant('PSBTN_FINISH',PSBTN_FINISH);
    AddConstant('PSBTN_OK',PSBTN_OK);
    AddConstant('PSBTN_APPLYNOW',PSBTN_APPLYNOW);
    AddConstant('PSBTN_CANCEL',PSBTN_CANCEL);
    AddConstant('PSBTN_HELP',PSBTN_HELP);
    AddConstant('PSBTN_MAX',PSBTN_MAX);
    AddConstant('ID_PSRESTARTWINDOWS',ID_PSRESTARTWINDOWS);
    AddConstant('ID_PSREBOOTSYSTEM',ID_PSREBOOTSYSTEM);
    AddConstant('WIZ_CXDLG',WIZ_CXDLG);
    AddConstant('WIZ_CYDLG',WIZ_CYDLG);
    AddConstant('WIZ_CXBMP',WIZ_CXBMP);
    AddConstant('WIZ_BODYX',WIZ_BODYX);
    AddConstant('WIZ_BODYCX',WIZ_BODYCX);
    AddConstant('PROP_SM_CXDLG',PROP_SM_CXDLG);
    AddConstant('PROP_SM_CYDLG',PROP_SM_CYDLG);
    AddConstant('PROP_MED_CXDLG',PROP_MED_CXDLG);
    AddConstant('PROP_MED_CYDLG',PROP_MED_CYDLG);
    AddConstant('PROP_LG_CXDLG',PROP_LG_CXDLG);
    AddConstant('PROP_LG_CYDLG',PROP_LG_CYDLG);
    AddConstant('ICC_LISTVIEW_CLASSES',ICC_LISTVIEW_CLASSES);
    AddConstant('ICC_TREEVIEW_CLASSES',ICC_TREEVIEW_CLASSES);
    AddConstant('ICC_BAR_CLASSES',ICC_BAR_CLASSES);
    AddConstant('ICC_TAB_CLASSES',ICC_TAB_CLASSES);
    AddConstant('ICC_UPDOWN_CLASS',ICC_UPDOWN_CLASS);
    AddConstant('ICC_PROGRESS_CLASS',ICC_PROGRESS_CLASS);
    AddConstant('ICC_HOTKEY_CLASS',ICC_HOTKEY_CLASS);
    AddConstant('ICC_ANIMATE_CLASS',ICC_ANIMATE_CLASS);
    AddConstant('ICC_WIN95_CLASSES',ICC_WIN95_CLASSES);
    AddConstant('ICC_DATE_CLASSES',ICC_DATE_CLASSES);
    AddConstant('ICC_USEREX_CLASSES',ICC_USEREX_CLASSES);
    AddConstant('ICC_COOL_CLASSES',ICC_COOL_CLASSES);
    AddConstant('ICC_INTERNET_CLASSES',ICC_INTERNET_CLASSES);
    AddConstant('ICC_PAGESCROLLER_CLASS',ICC_PAGESCROLLER_CLASS);
    AddConstant('ICC_NATIVEFNTCTL_CLASS',ICC_NATIVEFNTCTL_CLASS);
    AddConstant('IMAGE_BITMAP',IMAGE_BITMAP);
    AddConstant('ODT_HEADER',ODT_HEADER);
    AddConstant('ODT_TAB',ODT_TAB);
    AddConstant('ODT_LISTVIEW',ODT_LISTVIEW);
    AddConstant('LVM_FIRST',LVM_FIRST);
    AddConstant('TV_FIRST',TV_FIRST);
    AddConstant('HDM_FIRST',HDM_FIRST);
    AddConstant('TCM_FIRST',TCM_FIRST);
    AddConstant('PGM_FIRST',PGM_FIRST);
    AddConstant('CCM_FIRST',CCM_FIRST);
    AddConstant('CCM_SETBKCOLOR',CCM_SETBKCOLOR);
    AddConstant('CCM_SETCOLORSCHEME',CCM_SETCOLORSCHEME);
    AddConstant('CCM_GETCOLORSCHEME',CCM_GETCOLORSCHEME);
    AddConstant('CCM_GETDROPTARGET',CCM_GETDROPTARGET);
    AddConstant('CCM_SETUNICODEFORMAT',CCM_SETUNICODEFORMAT);
    AddConstant('CCM_GETUNICODEFORMAT',CCM_GETUNICODEFORMAT);
    AddConstant('INFOTIPSIZE',INFOTIPSIZE);
    AddConstant('NM_FIRST',NM_FIRST);
    AddConstant('NM_LAST',NM_LAST);
    AddConstant('LVN_FIRST',LVN_FIRST);
    AddConstant('LVN_LAST',LVN_LAST);
    AddConstant('HDN_FIRST',HDN_FIRST);
    AddConstant('HDN_LAST',HDN_LAST);
    AddConstant('TVN_FIRST',TVN_FIRST);
    AddConstant('TVN_LAST',TVN_LAST);
    AddConstant('TTN_FIRST',TTN_FIRST);
    AddConstant('TTN_LAST',TTN_LAST);
    AddConstant('TCN_FIRST',TCN_FIRST);
    AddConstant('TCN_LAST',TCN_LAST);
    AddConstant('CDN_FIRST',CDN_FIRST);
    AddConstant('CDN_LAST',CDN_LAST);
    AddConstant('TBN_FIRST',TBN_FIRST);
    AddConstant('TBN_LAST',TBN_LAST);
    AddConstant('UDN_FIRST',UDN_FIRST);
    AddConstant('UDN_LAST',UDN_LAST);
    AddConstant('MCN_FIRST',MCN_FIRST);
    AddConstant('MCN_LAST',MCN_LAST);
    AddConstant('DTN_FIRST',DTN_FIRST);
    AddConstant('DTN_LAST',DTN_LAST);
    AddConstant('CBEN_FIRST',CBEN_FIRST);
    AddConstant('CBEN_LAST',CBEN_LAST);
    AddConstant('RBN_FIRST',RBN_FIRST);
    AddConstant('RBN_LAST',RBN_LAST);
    AddConstant('IPN_FIRST',IPN_FIRST);
    AddConstant('IPN_LAST',IPN_LAST);
    AddConstant('SBN_FIRST',SBN_FIRST);
    AddConstant('SBN_LAST',SBN_LAST);
    AddConstant('PGN_FIRST',PGN_FIRST);
    AddConstant('PGN_LAST',PGN_LAST);
    AddConstant('MSGF_COMMCTRL_BEGINDRAG',MSGF_COMMCTRL_BEGINDRAG);
    AddConstant('MSGF_COMMCTRL_SIZEHEADER',MSGF_COMMCTRL_SIZEHEADER);
    AddConstant('MSGF_COMMCTRL_DRAGSELECT',MSGF_COMMCTRL_DRAGSELECT);
    AddConstant('MSGF_COMMCTRL_TOOLBARCUST',MSGF_COMMCTRL_TOOLBARCUST);
    AddConstant('NM_OUTOFMEMORY',NM_OUTOFMEMORY);
    AddConstant('NM_CLICK',NM_CLICK);
    AddConstant('NM_DBLCLK',NM_DBLCLK);
    AddConstant('NM_RETURN',NM_RETURN);
    AddConstant('NM_RCLICK',NM_RCLICK);
    AddConstant('NM_RDBLCLK',NM_RDBLCLK);
    AddConstant('NM_SETFOCUS',NM_SETFOCUS);
    AddConstant('NM_KILLFOCUS',NM_KILLFOCUS);
    AddConstant('NM_CUSTOMDRAW',NM_CUSTOMDRAW);
    AddConstant('NM_HOVER',NM_HOVER);
    AddConstant('NM_NCHITTEST',NM_NCHITTEST);
    AddConstant('NM_KEYDOWN',NM_KEYDOWN);
    AddConstant('NM_RELEASEDCAPTURE',NM_RELEASEDCAPTURE);
    AddConstant('NM_SETCURSOR',NM_SETCURSOR);
    AddConstant('NM_CHAR',NM_CHAR);
    AddConstant('CDRF_DODEFAULT',CDRF_DODEFAULT);
    AddConstant('CDRF_NEWFONT',CDRF_NEWFONT);
    AddConstant('CDRF_SKIPDEFAULT',CDRF_SKIPDEFAULT);
    AddConstant('CDRF_NOTIFYPOSTPAINT',CDRF_NOTIFYPOSTPAINT);
    AddConstant('CDRF_NOTIFYITEMDRAW',CDRF_NOTIFYITEMDRAW);
    AddConstant('CDRF_NOTIFYSUBITEMDRAW',CDRF_NOTIFYSUBITEMDRAW);
    AddConstant('CDRF_NOTIFYPOSTERASE',CDRF_NOTIFYPOSTERASE);
    AddConstant('CDDS_PREPAINT',CDDS_PREPAINT);
    AddConstant('CDDS_POSTPAINT',CDDS_POSTPAINT);
    AddConstant('CDDS_PREERASE',CDDS_PREERASE);
    AddConstant('CDDS_POSTERASE',CDDS_POSTERASE);
    AddConstant('CDDS_ITEM',CDDS_ITEM);
    AddConstant('CDDS_ITEMPREPAINT',CDDS_ITEMPREPAINT);
    AddConstant('CDDS_ITEMPOSTPAINT',CDDS_ITEMPOSTPAINT);
    AddConstant('CDDS_ITEMPREERASE',CDDS_ITEMPREERASE);
    AddConstant('CDDS_ITEMPOSTERASE',CDDS_ITEMPOSTERASE);
    AddConstant('CDDS_SUBITEM',CDDS_SUBITEM);
    AddConstant('CDIS_SELECTED',CDIS_SELECTED);
    AddConstant('CDIS_GRAYED',CDIS_GRAYED);
    AddConstant('CDIS_DISABLED',CDIS_DISABLED);
    AddConstant('CDIS_CHECKED',CDIS_CHECKED);
    AddConstant('CDIS_FOCUS',CDIS_FOCUS);
    AddConstant('CDIS_DEFAULT',CDIS_DEFAULT);
    AddConstant('CDIS_HOT',CDIS_HOT);
    AddConstant('CDIS_MARKED',CDIS_MARKED);
    AddConstant('CDIS_INDETERMINATE',CDIS_INDETERMINATE);
    AddConstant('CLR_NONE',CLR_NONE);
    AddConstant('CLR_DEFAULT',CLR_DEFAULT);
    AddConstant('ILC_MASK',ILC_MASK);
    AddConstant('ILC_COLOR',ILC_COLOR);
    AddConstant('ILC_COLORDDB',ILC_COLORDDB);
    AddConstant('ILC_COLOR4',ILC_COLOR4);
    AddConstant('ILC_COLOR8',ILC_COLOR8);
    AddConstant('ILC_COLOR16',ILC_COLOR16);
    AddConstant('ILC_COLOR24',ILC_COLOR24);
    AddConstant('ILC_COLOR32',ILC_COLOR32);
    AddConstant('ILC_PALETTE',ILC_PALETTE);
    AddConstant('ILD_NORMAL',ILD_NORMAL);
    AddConstant('ILD_TRANSPARENT',ILD_TRANSPARENT);
    AddConstant('ILD_MASK',ILD_MASK);
    AddConstant('ILD_IMAGE',ILD_IMAGE);
    AddConstant('ILD_ROP',ILD_ROP);
    AddConstant('ILD_BLEND25',ILD_BLEND25);
    AddConstant('ILD_BLEND50',ILD_BLEND50);
    AddConstant('ILD_OVERLAYMASK',ILD_OVERLAYMASK);
    AddConstant('ILD_SELECTED',ILD_SELECTED);
    AddConstant('ILD_FOCUS',ILD_FOCUS);
    AddConstant('ILD_BLEND',ILD_BLEND);
    AddConstant('CLR_HILIGHT',CLR_HILIGHT);
    AddConstant('ILCF_MOVE',ILCF_MOVE);
    AddConstant('ILCF_SWAP',ILCF_SWAP);
    AddConstant('WC_HEADER',WC_HEADER);
    AddConstant('HDS_HORZ',HDS_HORZ);
    AddConstant('HDS_BUTTONS',HDS_BUTTONS);
    AddConstant('HDS_HOTTRACK',HDS_HOTTRACK);
    AddConstant('HDS_HIDDEN',HDS_HIDDEN);
    AddConstant('HDS_DRAGDROP',HDS_DRAGDROP);
    AddConstant('HDS_FULLDRAG',HDS_FULLDRAG);
    AddConstant('HDI_WIDTH',HDI_WIDTH);
    AddConstant('HDI_HEIGHT',HDI_HEIGHT);
    AddConstant('HDI_TEXT',HDI_TEXT);
    AddConstant('HDI_FORMAT',HDI_FORMAT);
    AddConstant('HDI_LPARAM',HDI_LPARAM);
    AddConstant('HDI_BITMAP',HDI_BITMAP);
    AddConstant('HDI_IMAGE',HDI_IMAGE);
    AddConstant('HDI_DI_SETITEM',HDI_DI_SETITEM);
    AddConstant('HDI_ORDER',HDI_ORDER);
    AddConstant('HDF_LEFT',HDF_LEFT);
    AddConstant('HDF_RIGHT',HDF_RIGHT);
    AddConstant('HDF_CENTER',HDF_CENTER);
    AddConstant('HDF_JUSTIFYMASK',HDF_JUSTIFYMASK);
    AddConstant('HDF_RTLREADING',HDF_RTLREADING);
    AddConstant('HDF_OWNERDRAW',HDF_OWNERDRAW);
    AddConstant('HDF_STRING',HDF_STRING);
    AddConstant('HDF_BITMAP',HDF_BITMAP);
    AddConstant('HDF_BITMAP_ON_RIGHT',HDF_BITMAP_ON_RIGHT);
    AddConstant('HDF_IMAGE',HDF_IMAGE);
    AddConstant('HDM_GETITEMCOUNT',HDM_GETITEMCOUNT);
    AddConstant('HDM_INSERTITEMW',HDM_INSERTITEMW);
    AddConstant('HDM_INSERTITEMA',HDM_INSERTITEMA);
    AddConstant('HDM_INSERTITEM',HDM_INSERTITEM);
    AddConstant('HDM_DELETEITEM',HDM_DELETEITEM);
    AddConstant('HDM_GETITEMW',HDM_GETITEMW);
    AddConstant('HDM_GETITEMA',HDM_GETITEMA);
    AddConstant('HDM_GETITEM',HDM_GETITEM);
    AddConstant('HDM_SETITEMA',HDM_SETITEMA);
    AddConstant('HDM_SETITEMW',HDM_SETITEMW);
    AddConstant('HDM_SETITEM',HDM_SETITEM);
    AddConstant('HDM_LAYOUT',HDM_LAYOUT);
    AddConstant('HHT_NOWHERE',HHT_NOWHERE);
    AddConstant('HHT_ONHEADER',HHT_ONHEADER);
    AddConstant('HHT_ONDIVIDER',HHT_ONDIVIDER);
    AddConstant('HHT_ONDIVOPEN',HHT_ONDIVOPEN);
    AddConstant('HHT_ABOVE',HHT_ABOVE);
    AddConstant('HHT_BELOW',HHT_BELOW);
    AddConstant('HHT_TORIGHT',HHT_TORIGHT);
    AddConstant('HHT_TOLEFT',HHT_TOLEFT);
    AddConstant('HDM_HITTEST',HDM_HITTEST);
    AddConstant('HDM_GETITEMRECT',HDM_GETITEMRECT);
    AddConstant('HDM_SETIMAGELIST',HDM_SETIMAGELIST);
    AddConstant('HDM_GETIMAGELIST',HDM_GETIMAGELIST);
    AddConstant('HDM_ORDERTOINDEX',HDM_ORDERTOINDEX);
    AddConstant('HDM_CREATEDRAGIMAGE',HDM_CREATEDRAGIMAGE);
    AddConstant('HDM_GETORDERARRAY',HDM_GETORDERARRAY);
    AddConstant('HDM_SETORDERARRAY',HDM_SETORDERARRAY);
    AddConstant('HDM_SETHOTDIVIDER',HDM_SETHOTDIVIDER);
    AddConstant('HDM_SETUNICODEFORMAT',HDM_SETUNICODEFORMAT);
    AddConstant('HDM_GETUNICODEFORMAT',HDM_GETUNICODEFORMAT);
    AddConstant('HDN_ITEMCHANGINGA',HDN_ITEMCHANGINGA);
    AddConstant('HDN_ITEMCHANGEDA',HDN_ITEMCHANGEDA);
    AddConstant('HDN_ITEMCLICKA',HDN_ITEMCLICKA);
    AddConstant('HDN_ITEMDBLCLICKA',HDN_ITEMDBLCLICKA);
    AddConstant('HDN_DIVIDERDBLCLICKA',HDN_DIVIDERDBLCLICKA);
    AddConstant('HDN_BEGINTRACKA',HDN_BEGINTRACKA);
    AddConstant('HDN_ENDTRACKA',HDN_ENDTRACKA);
    AddConstant('HDN_TRACKA',HDN_TRACKA);
    AddConstant('HDN_GETDISPINFOA',HDN_GETDISPINFOA);
    AddConstant('HDN_BEGINDRAG',HDN_BEGINDRAG);
    AddConstant('HDN_ENDDRAG',HDN_ENDDRAG);
    AddConstant('HDN_ITEMCHANGINGW',HDN_ITEMCHANGINGW);
    AddConstant('HDN_ITEMCHANGEDW',HDN_ITEMCHANGEDW);
    AddConstant('HDN_ITEMCLICKW',HDN_ITEMCLICKW);
    AddConstant('HDN_ITEMDBLCLICKW',HDN_ITEMDBLCLICKW);
    AddConstant('HDN_DIVIDERDBLCLICKW',HDN_DIVIDERDBLCLICKW);
    AddConstant('HDN_BEGINTRACKW',HDN_BEGINTRACKW);
    AddConstant('HDN_ENDTRACKW',HDN_ENDTRACKW);
    AddConstant('HDN_TRACKW',HDN_TRACKW);
    AddConstant('HDN_GETDISPINFOW',HDN_GETDISPINFOW);
    AddConstant('HDN_ITEMCHANGING',HDN_ITEMCHANGING);
    AddConstant('HDN_ITEMCHANGED',HDN_ITEMCHANGED);
    AddConstant('HDN_ITEMCLICK',HDN_ITEMCLICK);
    AddConstant('HDN_ITEMDBLCLICK',HDN_ITEMDBLCLICK);
    AddConstant('HDN_DIVIDERDBLCLICK',HDN_DIVIDERDBLCLICK);
    AddConstant('HDN_BEGINTRACK',HDN_BEGINTRACK);
    AddConstant('HDN_ENDTRACK',HDN_ENDTRACK);
    AddConstant('HDN_TRACK',HDN_TRACK);
    AddConstant('HDN_GETDISPINFO',HDN_GETDISPINFO);
    AddConstant('TOOLBARCLASSNAME',TOOLBARCLASSNAME);
    AddConstant('CMB_MASKED',CMB_MASKED);
    AddConstant('TBSTATE_CHECKED',TBSTATE_CHECKED);
    AddConstant('TBSTATE_PRESSED',TBSTATE_PRESSED);
    AddConstant('TBSTATE_ENABLED',TBSTATE_ENABLED);
    AddConstant('TBSTATE_HIDDEN',TBSTATE_HIDDEN);
    AddConstant('TBSTATE_INDETERMINATE',TBSTATE_INDETERMINATE);
    AddConstant('TBSTATE_WRAP',TBSTATE_WRAP);
    AddConstant('TBSTATE_ELLIPSES',TBSTATE_ELLIPSES);
    AddConstant('TBSTATE_MARKED',TBSTATE_MARKED);
    AddConstant('TBSTYLE_BUTTON',TBSTYLE_BUTTON);
    AddConstant('TBSTYLE_SEP',TBSTYLE_SEP);
    AddConstant('TBSTYLE_CHECK',TBSTYLE_CHECK);
    AddConstant('TBSTYLE_GROUP',TBSTYLE_GROUP);
    AddConstant('TBSTYLE_CHECKGROUP',TBSTYLE_CHECKGROUP);
    AddConstant('TBSTYLE_DROPDOWN',TBSTYLE_DROPDOWN);
    AddConstant('TBSTYLE_AUTOSIZE',TBSTYLE_AUTOSIZE);
    AddConstant('TBSTYLE_NOPREFIX',TBSTYLE_NOPREFIX);
    AddConstant('TBSTYLE_TOOLTIPS',TBSTYLE_TOOLTIPS);
    AddConstant('TBSTYLE_WRAPABLE',TBSTYLE_WRAPABLE);
    AddConstant('TBSTYLE_ALTDRAG',TBSTYLE_ALTDRAG);
    AddConstant('TBSTYLE_FLAT',TBSTYLE_FLAT);
    AddConstant('TBSTYLE_LIST',TBSTYLE_LIST);
    AddConstant('TBSTYLE_CUSTOMERASE',TBSTYLE_CUSTOMERASE);
    AddConstant('TBSTYLE_REGISTERDROP',TBSTYLE_REGISTERDROP);
    AddConstant('TBSTYLE_TRANSPARENT',TBSTYLE_TRANSPARENT);
    AddConstant('TBSTYLE_EX_DRAWDDARROWS',TBSTYLE_EX_DRAWDDARROWS);
    AddConstant('TBCDRF_NOEDGES',TBCDRF_NOEDGES);
    AddConstant('TBCDRF_HILITEHOTTRACK',TBCDRF_HILITEHOTTRACK);
    AddConstant('TBCDRF_NOOFFSET',TBCDRF_NOOFFSET);
    AddConstant('TBCDRF_NOMARK',TBCDRF_NOMARK);
    AddConstant('TBCDRF_NOETCHEDEFFECT',TBCDRF_NOETCHEDEFFECT);
    AddConstant('TB_ENABLEBUTTON',TB_ENABLEBUTTON);
    AddConstant('TB_CHECKBUTTON',TB_CHECKBUTTON);
    AddConstant('TB_PRESSBUTTON',TB_PRESSBUTTON);
    AddConstant('TB_HIDEBUTTON',TB_HIDEBUTTON);
    AddConstant('TB_INDETERMINATE',TB_INDETERMINATE);
    AddConstant('TB_MARKBUTTON',TB_MARKBUTTON);
    AddConstant('TB_ISBUTTONENABLED',TB_ISBUTTONENABLED);
    AddConstant('TB_ISBUTTONCHECKED',TB_ISBUTTONCHECKED);
    AddConstant('TB_ISBUTTONPRESSED',TB_ISBUTTONPRESSED);
    AddConstant('TB_ISBUTTONHIDDEN',TB_ISBUTTONHIDDEN);
    AddConstant('TB_ISBUTTONINDETERMINATE',TB_ISBUTTONINDETERMINATE);
    AddConstant('TB_ISBUTTONHIGHLIGHTED',TB_ISBUTTONHIGHLIGHTED);
    AddConstant('TB_SETSTATE',TB_SETSTATE);
    AddConstant('TB_GETSTATE',TB_GETSTATE);
    AddConstant('TB_ADDBITMAP',TB_ADDBITMAP);
    AddConstant('HINST_COMMCTRL',HINST_COMMCTRL);
    AddConstant('IDB_STD_SMALL_COLOR',IDB_STD_SMALL_COLOR);
    AddConstant('IDB_STD_LARGE_COLOR',IDB_STD_LARGE_COLOR);
    AddConstant('IDB_VIEW_SMALL_COLOR',IDB_VIEW_SMALL_COLOR);
    AddConstant('IDB_VIEW_LARGE_COLOR',IDB_VIEW_LARGE_COLOR);
    AddConstant('IDB_HIST_SMALL_COLOR',IDB_HIST_SMALL_COLOR);
    AddConstant('IDB_HIST_LARGE_COLOR',IDB_HIST_LARGE_COLOR);
    AddConstant('STD_CUT',STD_CUT);
    AddConstant('STD_COPY',STD_COPY);
    AddConstant('STD_PASTE',STD_PASTE);
    AddConstant('STD_UNDO',STD_UNDO);
    AddConstant('STD_REDOW',STD_REDOW);
    AddConstant('STD_DELETE',STD_DELETE);
    AddConstant('STD_FILENEW',STD_FILENEW);
    AddConstant('STD_FILEOPEN',STD_FILEOPEN);
    AddConstant('STD_FILESAVE',STD_FILESAVE);
    AddConstant('STD_PRINTPRE',STD_PRINTPRE);
    AddConstant('STD_PROPERTIES',STD_PROPERTIES);
    AddConstant('STD_HELP',STD_HELP);
    AddConstant('STD_FIND',STD_FIND);
    AddConstant('STD_REPLACE',STD_REPLACE);
    AddConstant('STD_PRINT',STD_PRINT);
    AddConstant('VIEW_LARGEICONS',VIEW_LARGEICONS);
    AddConstant('VIEW_SMALLICONS',VIEW_SMALLICONS);
    AddConstant('VIEW_LIST',VIEW_LIST);
    AddConstant('VIEW_DETAILS',VIEW_DETAILS);
    AddConstant('VIEW_SORTNAME',VIEW_SORTNAME);
    AddConstant('VIEW_SORTSIZE',VIEW_SORTSIZE);
    AddConstant('VIEW_SORTDATE',VIEW_SORTDATE);
    AddConstant('VIEW_SORTTYPE',VIEW_SORTTYPE);
    AddConstant('VIEW_PARENTFOLDER',VIEW_PARENTFOLDER);
    AddConstant('VIEW_NETCONNECT',VIEW_NETCONNECT);
    AddConstant('VIEW_NETDISCONNECT',VIEW_NETDISCONNECT);
    AddConstant('VIEW_NEWFOLDER',VIEW_NEWFOLDER);
    AddConstant('VIEW_VIEWMENU',VIEW_VIEWMENU);
    AddConstant('HIST_BACK',HIST_BACK);
    AddConstant('HIST_FORWARD',HIST_FORWARD);
    AddConstant('HIST_FAVORITES',HIST_FAVORITES);
    AddConstant('HIST_ADDTOFAVORITES',HIST_ADDTOFAVORITES);
    AddConstant('HIST_VIEWTREE',HIST_VIEWTREE);
    AddConstant('TB_ADDBUTTONSA',TB_ADDBUTTONSA);
    AddConstant('TB_INSERTBUTTONA',TB_INSERTBUTTONA);
    AddConstant('TB_DELETEBUTTON',TB_DELETEBUTTON);
    AddConstant('TB_GETBUTTON',TB_GETBUTTON);
    AddConstant('TB_BUTTONCOUNT',TB_BUTTONCOUNT);
    AddConstant('TB_COMMANDTOINDEX',TB_COMMANDTOINDEX);
    AddConstant('TB_SAVERESTOREA',TB_SAVERESTOREA);
    AddConstant('TB_ADDSTRINGA',TB_ADDSTRINGA);
    AddConstant('TB_GETBUTTONTEXTA',TB_GETBUTTONTEXTA);
    AddConstant('TBN_GETBUTTONINFOA',TBN_GETBUTTONINFOA);
    AddConstant('TB_SAVERESTOREW',TB_SAVERESTOREW);
    AddConstant('TB_ADDSTRINGW',TB_ADDSTRINGW);
    AddConstant('TB_GETBUTTONTEXTW',TB_GETBUTTONTEXTW);
    AddConstant('TBN_GETBUTTONINFOW',TBN_GETBUTTONINFOW);
    AddConstant('TB_SAVERESTORE',TB_SAVERESTORE);
    AddConstant('TB_ADDSTRING',TB_ADDSTRING);
    AddConstant('TB_GETBUTTONTEXT',TB_GETBUTTONTEXT);
    AddConstant('TBN_GETBUTTONINFO',TBN_GETBUTTONINFO);
    AddConstant('TB_CUSTOMIZE',TB_CUSTOMIZE);
    AddConstant('TB_GETITEMRECT',TB_GETITEMRECT);
    AddConstant('TB_BUTTONSTRUCTSIZE',TB_BUTTONSTRUCTSIZE);
    AddConstant('TB_SETBUTTONSIZE',TB_SETBUTTONSIZE);
    AddConstant('TB_SETBITMAPSIZE',TB_SETBITMAPSIZE);
    AddConstant('TB_AUTOSIZE',TB_AUTOSIZE);
    AddConstant('TB_GETTOOLTIPS',TB_GETTOOLTIPS);
    AddConstant('TB_SETTOOLTIPS',TB_SETTOOLTIPS);
    AddConstant('TB_SETPARENT',TB_SETPARENT);
    AddConstant('TB_SETROWS',TB_SETROWS);
    AddConstant('TB_GETROWS',TB_GETROWS);
    AddConstant('TB_SETCMDID',TB_SETCMDID);
    AddConstant('TB_CHANGEBITMAP',TB_CHANGEBITMAP);
    AddConstant('TB_GETBITMAP',TB_GETBITMAP);
    AddConstant('TB_REPLACEBITMAP',TB_REPLACEBITMAP);
    AddConstant('TB_SETINDENT',TB_SETINDENT);
    AddConstant('TB_SETIMAGELIST',TB_SETIMAGELIST);
    AddConstant('TB_GETIMAGELIST',TB_GETIMAGELIST);
    AddConstant('TB_LOADIMAGES',TB_LOADIMAGES);
    AddConstant('TB_GETRECT',TB_GETRECT);
    AddConstant('TB_SETHOTIMAGELIST',TB_SETHOTIMAGELIST);
    AddConstant('TB_GETHOTIMAGELIST',TB_GETHOTIMAGELIST);
    AddConstant('TB_SETDISABLEDIMAGELIST',TB_SETDISABLEDIMAGELIST);
    AddConstant('TB_GETDISABLEDIMAGELIST',TB_GETDISABLEDIMAGELIST);
    AddConstant('TB_SETSTYLE',TB_SETSTYLE);
    AddConstant('TB_GETSTYLE',TB_GETSTYLE);
    AddConstant('TB_GETBUTTONSIZE',TB_GETBUTTONSIZE);
    AddConstant('TB_SETBUTTONWIDTH',TB_SETBUTTONWIDTH);
    AddConstant('TB_SETMAXTEXTROWS',TB_SETMAXTEXTROWS);
    AddConstant('TB_GETTEXTROWS',TB_GETTEXTROWS);
    AddConstant('TB_GETOBJECT',TB_GETOBJECT);
    AddConstant('TB_GETHOTITEM',TB_GETHOTITEM);
    AddConstant('TB_SETHOTITEM',TB_SETHOTITEM);
    AddConstant('TB_SETANCHORHIGHLIGHT',TB_SETANCHORHIGHLIGHT);
    AddConstant('TB_GETANCHORHIGHLIGHT',TB_GETANCHORHIGHLIGHT);
    AddConstant('TB_MAPACCELERATORA',TB_MAPACCELERATORA);
    AddConstant('TBIMHT_AFTER',TBIMHT_AFTER);
    AddConstant('TBIMHT_BACKGROUND',TBIMHT_BACKGROUND);
    AddConstant('TB_GETINSERTMARK',TB_GETINSERTMARK);
    AddConstant('TB_SETINSERTMARK',TB_SETINSERTMARK);
    AddConstant('TB_INSERTMARKHITTEST',TB_INSERTMARKHITTEST);
    AddConstant('TB_MOVEBUTTON',TB_MOVEBUTTON);
    AddConstant('TB_GETMAXSIZE',TB_GETMAXSIZE);
    AddConstant('TB_SETEXTENDEDSTYLE',TB_SETEXTENDEDSTYLE);
    AddConstant('TB_GETEXTENDEDSTYLE',TB_GETEXTENDEDSTYLE);
    AddConstant('TB_GETPADDING',TB_GETPADDING);
    AddConstant('TB_SETPADDING',TB_SETPADDING);
    AddConstant('TB_SETINSERTMARKCOLOR',TB_SETINSERTMARKCOLOR);
    AddConstant('TB_GETINSERTMARKCOLOR',TB_GETINSERTMARKCOLOR);
    AddConstant('TB_SETCOLORSCHEME',TB_SETCOLORSCHEME);
    AddConstant('TB_GETCOLORSCHEME',TB_GETCOLORSCHEME);
    AddConstant('TB_SETUNICODEFORMAT',TB_SETUNICODEFORMAT);
    AddConstant('TB_GETUNICODEFORMAT',TB_GETUNICODEFORMAT);
    AddConstant('TB_MAPACCELERATORW',TB_MAPACCELERATORW);
    AddConstant('TB_MAPACCELERATOR',TB_MAPACCELERATOR);
    AddConstant('TBBF_LARGE',TBBF_LARGE);
    AddConstant('TB_GETBITMAPFLAGS',TB_GETBITMAPFLAGS);
    AddConstant('TBIF_IMAGE',TBIF_IMAGE);
    AddConstant('TBIF_TEXT',TBIF_TEXT);
    AddConstant('TBIF_STATE',TBIF_STATE);
    AddConstant('TBIF_STYLE',TBIF_STYLE);
    AddConstant('TBIF_LPARAM',TBIF_LPARAM);
    AddConstant('TBIF_COMMAND',TBIF_COMMAND);
    AddConstant('TBIF_SIZE',TBIF_SIZE);
    AddConstant('TB_GETBUTTONINFOW',TB_GETBUTTONINFOW);
    AddConstant('TB_SETBUTTONINFOW',TB_SETBUTTONINFOW);
    AddConstant('TB_GETBUTTONINFOA',TB_GETBUTTONINFOA);
    AddConstant('TB_SETBUTTONINFOA',TB_SETBUTTONINFOA);
    AddConstant('TB_GETBUTTONINFO',TB_GETBUTTONINFO);
    AddConstant('TB_SETBUTTONINFO',TB_SETBUTTONINFO);
    AddConstant('TB_INSERTBUTTONW',TB_INSERTBUTTONW);
    AddConstant('TB_ADDBUTTONSW',TB_ADDBUTTONSW);
    AddConstant('TB_HITTEST',TB_HITTEST);
    AddConstant('TB_INSERTBUTTON',TB_INSERTBUTTON);
    AddConstant('TB_ADDBUTTONS',TB_ADDBUTTONS);
    AddConstant('TB_SETDRAWTEXTFLAGS',TB_SETDRAWTEXTFLAGS);
    AddConstant('TBN_BEGINDRAG',TBN_BEGINDRAG);
    AddConstant('TBN_ENDDRAG',TBN_ENDDRAG);
    AddConstant('TBN_BEGINADJUST',TBN_BEGINADJUST);
    AddConstant('TBN_ENDADJUST',TBN_ENDADJUST);
    AddConstant('TBN_RESET',TBN_RESET);
    AddConstant('TBN_QUERYINSERT',TBN_QUERYINSERT);
    AddConstant('TBN_QUERYDELETE',TBN_QUERYDELETE);
    AddConstant('TBN_TOOLBARCHANGE',TBN_TOOLBARCHANGE);
    AddConstant('TBN_CUSTHELP',TBN_CUSTHELP);
    AddConstant('TBN_DROPDOWN',TBN_DROPDOWN);
    AddConstant('TBN_CLOSEUP',TBN_CLOSEUP);
    AddConstant('TBN_GETOBJECT',TBN_GETOBJECT);
    AddConstant('HICF_OTHER',HICF_OTHER);
    AddConstant('HICF_MOUSE',HICF_MOUSE);
    AddConstant('HICF_ARROWKEYS',HICF_ARROWKEYS);
    AddConstant('HICF_ACCELERATOR',HICF_ACCELERATOR);
    AddConstant('HICF_DUPACCEL',HICF_DUPACCEL);
    AddConstant('HICF_ENTERING',HICF_ENTERING);
    AddConstant('HICF_LEAVING',HICF_LEAVING);
    AddConstant('HICF_RESELECT',HICF_RESELECT);
    AddConstant('TBN_HOTITEMCHANGE',TBN_HOTITEMCHANGE);
    AddConstant('TBN_DRAGOUT',TBN_DRAGOUT);
    AddConstant('TBN_DELETINGBUTTON',TBN_DELETINGBUTTON);
    AddConstant('TBN_GETDISPINFOA',TBN_GETDISPINFOA);
    AddConstant('TBN_GETDISPINFOW',TBN_GETDISPINFOW);
    AddConstant('TBN_GETINFOTIPA',TBN_GETINFOTIPA);
    AddConstant('TBN_GETINFOTIPW',TBN_GETINFOTIPW);
    AddConstant('TBNF_IMAGE',TBNF_IMAGE);
    AddConstant('TBNF_TEXT',TBNF_TEXT);
    AddConstant('TBNF_DI_SETITEM',TBNF_DI_SETITEM);
    AddConstant('TBDDRET_DEFAULT',TBDDRET_DEFAULT);
    AddConstant('TBDDRET_NODEFAULT',TBDDRET_NODEFAULT);
    AddConstant('TBDDRET_TREATPRESSED',TBDDRET_TREATPRESSED);
    AddConstant('REBARCLASSNAME',REBARCLASSNAME);
    AddConstant('RBIM_IMAGELIST',RBIM_IMAGELIST);
    AddConstant('RBS_TOOLTIPS',RBS_TOOLTIPS);
    AddConstant('RBS_VARHEIGHT',RBS_VARHEIGHT);
    AddConstant('RBS_BANDBORDERS',RBS_BANDBORDERS);
    AddConstant('RBS_FIXEDORDER',RBS_FIXEDORDER);
    AddConstant('RBS_REGISTERDROP',RBS_REGISTERDROP);
    AddConstant('RBS_AUTOSIZE',RBS_AUTOSIZE);
    AddConstant('RBS_VERTICALGRIPPER',RBS_VERTICALGRIPPER);
    AddConstant('RBS_DBLCLKTOGGLE',RBS_DBLCLKTOGGLE);
    AddConstant('RBBS_BREAK',RBBS_BREAK);
    AddConstant('RBBS_FIXEDSIZE',RBBS_FIXEDSIZE);
    AddConstant('RBBS_CHILDEDGE',RBBS_CHILDEDGE);
    AddConstant('RBBS_HIDDEN',RBBS_HIDDEN);
    AddConstant('RBBS_NOVERT',RBBS_NOVERT);
    AddConstant('RBBS_FIXEDBMP',RBBS_FIXEDBMP);
    AddConstant('RBBS_VARIABLEHEIGHT',RBBS_VARIABLEHEIGHT);
    AddConstant('RBBS_GRIPPERALWAYS',RBBS_GRIPPERALWAYS);
    AddConstant('RBBS_NOGRIPPER',RBBS_NOGRIPPER);
    AddConstant('RBBIM_STYLE',RBBIM_STYLE);
    AddConstant('RBBIM_COLORS',RBBIM_COLORS);
    AddConstant('RBBIM_TEXT',RBBIM_TEXT);
    AddConstant('RBBIM_IMAGE',RBBIM_IMAGE);
    AddConstant('RBBIM_CHILD',RBBIM_CHILD);
    AddConstant('RBBIM_CHILDSIZE',RBBIM_CHILDSIZE);
    AddConstant('RBBIM_SIZE',RBBIM_SIZE);
    AddConstant('RBBIM_BACKGROUND',RBBIM_BACKGROUND);
    AddConstant('RBBIM_ID',RBBIM_ID);
    AddConstant('RBBIM_IDEALSIZE',RBBIM_IDEALSIZE);
    AddConstant('RBBIM_LPARAM',RBBIM_LPARAM);
    AddConstant('RBBIM_HEADERSIZE',RBBIM_HEADERSIZE);
    AddConstant('RB_INSERTBANDA',RB_INSERTBANDA);
    AddConstant('RB_DELETEBAND',RB_DELETEBAND);
    AddConstant('RB_GETBARINFO',RB_GETBARINFO);
    AddConstant('RB_SETBARINFO',RB_SETBARINFO);
    AddConstant('RB_GETBANDINFO_PRE_IE4',RB_GETBANDINFO_PRE_IE4);
    AddConstant('RB_SETBANDINFOA',RB_SETBANDINFOA);
    AddConstant('RB_SETPARENT',RB_SETPARENT);
    AddConstant('RB_HITTEST',RB_HITTEST);
    AddConstant('RB_GETRECT',RB_GETRECT);
    AddConstant('RB_INSERTBANDW',RB_INSERTBANDW);
    AddConstant('RB_SETBANDINFOW',RB_SETBANDINFOW);
    AddConstant('RB_GETBANDCOUNT',RB_GETBANDCOUNT);
    AddConstant('RB_GETROWCOUNT',RB_GETROWCOUNT);
    AddConstant('RB_GETROWHEIGHT',RB_GETROWHEIGHT);
    AddConstant('RB_IDTOINDEX',RB_IDTOINDEX);
    AddConstant('RB_GETTOOLTIPS',RB_GETTOOLTIPS);
    AddConstant('RB_SETTOOLTIPS',RB_SETTOOLTIPS);
    AddConstant('RB_SETBKCOLOR',RB_SETBKCOLOR);
    AddConstant('RB_GETBKCOLOR',RB_GETBKCOLOR);
    AddConstant('RB_SETTEXTCOLOR',RB_SETTEXTCOLOR);
    AddConstant('RB_GETTEXTCOLOR',RB_GETTEXTCOLOR);
    AddConstant('RB_SIZETORECT',RB_SIZETORECT);
    AddConstant('RB_BEGINDRAG',RB_BEGINDRAG);
    AddConstant('RB_ENDDRAG',RB_ENDDRAG);
    AddConstant('RB_DRAGMOVE',RB_DRAGMOVE);
    AddConstant('RB_GETBARHEIGHT',RB_GETBARHEIGHT);
    AddConstant('RB_GETBANDINFOW',RB_GETBANDINFOW);
    AddConstant('RB_GETBANDINFOA',RB_GETBANDINFOA);
    AddConstant('RB_MINIMIZEBAND',RB_MINIMIZEBAND);
    AddConstant('RB_MAXIMIZEBAND',RB_MAXIMIZEBAND);
    AddConstant('RB_GETDROPTARGET',RB_GETDROPTARGET);
    AddConstant('RB_GETBANDBORDERS',RB_GETBANDBORDERS);
    AddConstant('RB_SHOWBAND',RB_SHOWBAND);
    AddConstant('RB_SETPALETTE',RB_SETPALETTE);
    AddConstant('RB_GETPALETTE',RB_GETPALETTE);
    AddConstant('RB_MOVEBAND',RB_MOVEBAND);
    AddConstant('RB_SETUNICODEFORMAT',RB_SETUNICODEFORMAT);
    AddConstant('RB_GETUNICODEFORMAT',RB_GETUNICODEFORMAT);
    AddConstant('RB_INSERTBAND',RB_INSERTBAND);
    AddConstant('RB_SETBANDINFO',RB_SETBANDINFO);
    AddConstant('RB_GETBANDINFO',RB_GETBANDINFO);
    AddConstant('RBN_HEIGHTCHANGE',RBN_HEIGHTCHANGE);
    AddConstant('RBN_GETOBJECT',RBN_GETOBJECT);
    AddConstant('RBN_LAYOUTCHANGED',RBN_LAYOUTCHANGED);
    AddConstant('RBN_AUTOSIZE',RBN_AUTOSIZE);
    AddConstant('RBN_BEGINDRAG',RBN_BEGINDRAG);
    AddConstant('RBN_ENDDRAG',RBN_ENDDRAG);
    AddConstant('RBN_DELETINGBAND',RBN_DELETINGBAND);
    AddConstant('RBN_DELETEDBAND',RBN_DELETEDBAND);
    AddConstant('RBN_CHILDSIZE',RBN_CHILDSIZE);
    AddConstant('RBNM_ID',RBNM_ID);
    AddConstant('RBNM_STYLE',RBNM_STYLE);
    AddConstant('RBNM_LPARAM',RBNM_LPARAM);
    AddConstant('RBHT_NOWHERE',RBHT_NOWHERE);
    AddConstant('RBHT_CAPTION',RBHT_CAPTION);
    AddConstant('RBHT_CLIENT',RBHT_CLIENT);
    AddConstant('RBHT_GRABBER',RBHT_GRABBER);
    AddConstant('TOOLTIPS_CLASS',TOOLTIPS_CLASS);
    AddConstant('TTS_ALWAYSTIP',TTS_ALWAYSTIP);
    AddConstant('TTS_NOPREFIX',TTS_NOPREFIX);
    AddConstant('TTF_IDISHWND',TTF_IDISHWND);
    AddConstant('TTF_CENTERTIP',TTF_CENTERTIP);
    AddConstant('TTF_RTLREADING',TTF_RTLREADING);
    AddConstant('TTF_SUBCLASS',TTF_SUBCLASS);
    AddConstant('TTF_TRACK',TTF_TRACK);
    AddConstant('TTF_ABSOLUTE',TTF_ABSOLUTE);
    AddConstant('TTF_TRANSPARENT',TTF_TRANSPARENT);
    AddConstant('TTF_DI_SETITEM',TTF_DI_SETITEM);
    AddConstant('TTDT_AUTOMATIC',TTDT_AUTOMATIC);
    AddConstant('TTDT_RESHOW',TTDT_RESHOW);
    AddConstant('TTDT_AUTOPOP',TTDT_AUTOPOP);
    AddConstant('TTDT_INITIAL',TTDT_INITIAL);
    AddConstant('TTM_ACTIVATE',TTM_ACTIVATE);
    AddConstant('TTM_SETDELAYTIME',TTM_SETDELAYTIME);
    AddConstant('TTM_ADDTOOLA',TTM_ADDTOOLA);
    AddConstant('TTM_DELTOOLA',TTM_DELTOOLA);
    AddConstant('TTM_NEWTOOLRECTA',TTM_NEWTOOLRECTA);
    AddConstant('TTM_GETTOOLINFOA',TTM_GETTOOLINFOA);
    AddConstant('TTM_SETTOOLINFOA',TTM_SETTOOLINFOA);
    AddConstant('TTM_HITTESTA',TTM_HITTESTA);
    AddConstant('TTM_GETTEXTA',TTM_GETTEXTA);
    AddConstant('TTM_UPDATETIPTEXTA',TTM_UPDATETIPTEXTA);
    AddConstant('TTM_ENUMTOOLSA',TTM_ENUMTOOLSA);
    AddConstant('TTM_GETCURRENTTOOLA',TTM_GETCURRENTTOOLA);
    AddConstant('TTM_ADDTOOLW',TTM_ADDTOOLW);
    AddConstant('TTM_DELTOOLW',TTM_DELTOOLW);
    AddConstant('TTM_NEWTOOLRECTW',TTM_NEWTOOLRECTW);
    AddConstant('TTM_GETTOOLINFOW',TTM_GETTOOLINFOW);
    AddConstant('TTM_SETTOOLINFOW',TTM_SETTOOLINFOW);
    AddConstant('TTM_HITTESTW',TTM_HITTESTW);
    AddConstant('TTM_GETTEXTW',TTM_GETTEXTW);
    AddConstant('TTM_UPDATETIPTEXTW',TTM_UPDATETIPTEXTW);
    AddConstant('TTM_ENUMTOOLSW',TTM_ENUMTOOLSW);
    AddConstant('TTM_GETCURRENTTOOLW',TTM_GETCURRENTTOOLW);
    AddConstant('TTM_WINDOWFROMPOINT',TTM_WINDOWFROMPOINT);
    AddConstant('TTM_TRACKACTIVATE',TTM_TRACKACTIVATE);
    AddConstant('TTM_TRACKPOSITION',TTM_TRACKPOSITION);
    AddConstant('TTM_SETTIPBKCOLOR',TTM_SETTIPBKCOLOR);
    AddConstant('TTM_SETTIPTEXTCOLOR',TTM_SETTIPTEXTCOLOR);
    AddConstant('TTM_GETDELAYTIME',TTM_GETDELAYTIME);
    AddConstant('TTM_GETTIPBKCOLOR',TTM_GETTIPBKCOLOR);
    AddConstant('TTM_GETTIPTEXTCOLOR',TTM_GETTIPTEXTCOLOR);
    AddConstant('TTM_SETMAXTIPWIDTH',TTM_SETMAXTIPWIDTH);
    AddConstant('TTM_GETMAXTIPWIDTH',TTM_GETMAXTIPWIDTH);
    AddConstant('TTM_SETMARGIN',TTM_SETMARGIN);
    AddConstant('TTM_GETMARGIN',TTM_GETMARGIN);
    AddConstant('TTM_POP',TTM_POP);
    AddConstant('TTM_UPDATE',TTM_UPDATE);
    AddConstant('TTM_ADDTOOL',TTM_ADDTOOL);
    AddConstant('TTM_DELTOOL',TTM_DELTOOL);
    AddConstant('TTM_NEWTOOLRECT',TTM_NEWTOOLRECT);
    AddConstant('TTM_GETTOOLINFO',TTM_GETTOOLINFO);
    AddConstant('TTM_SETTOOLINFO',TTM_SETTOOLINFO);
    AddConstant('TTM_HITTEST',TTM_HITTEST);
    AddConstant('TTM_GETTEXT',TTM_GETTEXT);
    AddConstant('TTM_UPDATETIPTEXT',TTM_UPDATETIPTEXT);
    AddConstant('TTM_ENUMTOOLS',TTM_ENUMTOOLS);
    AddConstant('TTM_GETCURRENTTOOL',TTM_GETCURRENTTOOL);
    AddConstant('TTM_RELAYEVENT',TTM_RELAYEVENT);
    AddConstant('TTM_GETTOOLCOUNT',TTM_GETTOOLCOUNT);
    AddConstant('TTN_NEEDTEXTA',TTN_NEEDTEXTA);
    AddConstant('TTN_NEEDTEXTW',TTN_NEEDTEXTW);
    AddConstant('TTN_NEEDTEXT',TTN_NEEDTEXT);
    AddConstant('TTN_SHOW',TTN_SHOW);
    AddConstant('TTN_POP',TTN_POP);
    AddConstant('SBARS_SIZEGRIP',SBARS_SIZEGRIP);
    AddConstant('STATUSCLASSNAME',STATUSCLASSNAME);
    AddConstant('SB_SETTEXTA',SB_SETTEXTA);
    AddConstant('SB_GETTEXTA',SB_GETTEXTA);
    AddConstant('SB_GETTEXTLENGTHA',SB_GETTEXTLENGTHA);
    AddConstant('SB_SETTIPTEXTA',SB_SETTIPTEXTA);
    AddConstant('SB_GETTIPTEXTA',SB_GETTIPTEXTA);
    AddConstant('SB_SETTEXTW',SB_SETTEXTW);
    AddConstant('SB_GETTEXTW',SB_GETTEXTW);
    AddConstant('SB_GETTEXTLENGTHW',SB_GETTEXTLENGTHW);
    AddConstant('SB_SETTIPTEXTW',SB_SETTIPTEXTW);
    AddConstant('SB_GETTIPTEXTW',SB_GETTIPTEXTW);
    AddConstant('SB_SETTEXT',SB_SETTEXT);
    AddConstant('SB_GETTEXT',SB_GETTEXT);
    AddConstant('SB_GETTEXTLENGTH',SB_GETTEXTLENGTH);
    AddConstant('SB_SETTIPTEXT',SB_SETTIPTEXT);
    AddConstant('SB_GETTIPTEXT',SB_GETTIPTEXT);
    AddConstant('SB_SETPARTS',SB_SETPARTS);
    AddConstant('SB_GETPARTS',SB_GETPARTS);
    AddConstant('SB_GETBORDERS',SB_GETBORDERS);
    AddConstant('SB_SETMINHEIGHT',SB_SETMINHEIGHT);
    AddConstant('SB_SIMPLE',SB_SIMPLE);
    AddConstant('SB_GETRECT',SB_GETRECT);
    AddConstant('SB_ISSIMPLE',SB_ISSIMPLE);
    AddConstant('SB_SETICON',SB_SETICON);
    AddConstant('SB_GETICON',SB_GETICON);
    AddConstant('SB_SETUNICODEFORMAT',SB_SETUNICODEFORMAT);
    AddConstant('SB_GETUNICODEFORMAT',SB_GETUNICODEFORMAT);
    AddConstant('SBT_OWNERDRAW',SBT_OWNERDRAW);
    AddConstant('SBT_NOBORDERS',SBT_NOBORDERS);
    AddConstant('SBT_POPOUT',SBT_POPOUT);
    AddConstant('SBT_RTLREADING',SBT_RTLREADING);
    AddConstant('SBT_TOOLTIPS',SBT_TOOLTIPS);
    AddConstant('SB_SETBKCOLOR',SB_SETBKCOLOR);
    AddConstant('SBN_SIMPLEMODECHANGE',SBN_SIMPLEMODECHANGE);
    AddConstant('MINSYSCOMMAND',MINSYSCOMMAND);
    AddConstant('TRACKBAR_CLASS',TRACKBAR_CLASS);
    AddConstant('TBS_AUTOTICKS',TBS_AUTOTICKS);
    AddConstant('TBS_VERT',TBS_VERT);
    AddConstant('TBS_HORZ',TBS_HORZ);
    AddConstant('TBS_TOP',TBS_TOP);
    AddConstant('TBS_BOTTOM',TBS_BOTTOM);
    AddConstant('TBS_LEFT',TBS_LEFT);
    AddConstant('TBS_RIGHT',TBS_RIGHT);
    AddConstant('TBS_BOTH',TBS_BOTH);
    AddConstant('TBS_NOTICKS',TBS_NOTICKS);
    AddConstant('TBS_ENABLESELRANGE',TBS_ENABLESELRANGE);
    AddConstant('TBS_FIXEDLENGTH',TBS_FIXEDLENGTH);
    AddConstant('TBS_NOTHUMB',TBS_NOTHUMB);
    AddConstant('TBS_TOOLTIPS',TBS_TOOLTIPS);
    AddConstant('TBM_GETPOS',TBM_GETPOS);
    AddConstant('TBM_GETRANGEMIN',TBM_GETRANGEMIN);
    AddConstant('TBM_GETRANGEMAX',TBM_GETRANGEMAX);
    AddConstant('TBM_GETTIC',TBM_GETTIC);
    AddConstant('TBM_SETTIC',TBM_SETTIC);
    AddConstant('TBM_SETPOS',TBM_SETPOS);
    AddConstant('TBM_SETRANGE',TBM_SETRANGE);
    AddConstant('TBM_SETRANGEMIN',TBM_SETRANGEMIN);
    AddConstant('TBM_SETRANGEMAX',TBM_SETRANGEMAX);
    AddConstant('TBM_CLEARTICS',TBM_CLEARTICS);
    AddConstant('TBM_SETSEL',TBM_SETSEL);
    AddConstant('TBM_SETSELSTART',TBM_SETSELSTART);
    AddConstant('TBM_SETSELEND',TBM_SETSELEND);
    AddConstant('TBM_GETPTICS',TBM_GETPTICS);
    AddConstant('TBM_GETTICPOS',TBM_GETTICPOS);
    AddConstant('TBM_GETNUMTICS',TBM_GETNUMTICS);
    AddConstant('TBM_GETSELSTART',TBM_GETSELSTART);
    AddConstant('TBM_GETSELEND',TBM_GETSELEND);
    AddConstant('TBM_CLEARSEL',TBM_CLEARSEL);
    AddConstant('TBM_SETTICFREQ',TBM_SETTICFREQ);
    AddConstant('TBM_SETPAGESIZE',TBM_SETPAGESIZE);
    AddConstant('TBM_GETPAGESIZE',TBM_GETPAGESIZE);
    AddConstant('TBM_SETLINESIZE',TBM_SETLINESIZE);
    AddConstant('TBM_GETLINESIZE',TBM_GETLINESIZE);
    AddConstant('TBM_GETTHUMBRECT',TBM_GETTHUMBRECT);
    AddConstant('TBM_GETCHANNELRECT',TBM_GETCHANNELRECT);
    AddConstant('TBM_SETTHUMBLENGTH',TBM_SETTHUMBLENGTH);
    AddConstant('TBM_GETTHUMBLENGTH',TBM_GETTHUMBLENGTH);
    AddConstant('TBM_SETTOOLTIPS',TBM_SETTOOLTIPS);
    AddConstant('TBM_GETTOOLTIPS',TBM_GETTOOLTIPS);
    AddConstant('TBM_SETTIPSIDE',TBM_SETTIPSIDE);
    AddConstant('TBTS_TOP',TBTS_TOP);
    AddConstant('TBTS_LEFT',TBTS_LEFT);
    AddConstant('TBTS_BOTTOM',TBTS_BOTTOM);
    AddConstant('TBTS_RIGHT',TBTS_RIGHT);
    AddConstant('TBM_SETBUDDY',TBM_SETBUDDY);
    AddConstant('TBM_GETBUDDY',TBM_GETBUDDY);
    AddConstant('TBM_SETUNICODEFORMAT',TBM_SETUNICODEFORMAT);
    AddConstant('TBM_GETUNICODEFORMAT',TBM_GETUNICODEFORMAT);
    AddConstant('TB_LINEUP',TB_LINEUP);
    AddConstant('TB_LINEDOWN',TB_LINEDOWN);
    AddConstant('TB_PAGEUP',TB_PAGEUP);
    AddConstant('TB_PAGEDOWN',TB_PAGEDOWN);
    AddConstant('TB_THUMBPOSITION',TB_THUMBPOSITION);
    AddConstant('TB_THUMBTRACK',TB_THUMBTRACK);
    AddConstant('TB_TOP',TB_TOP);
    AddConstant('TB_BOTTOM',TB_BOTTOM);
    AddConstant('TB_ENDTRACK',TB_ENDTRACK);
    AddConstant('TBCD_TICS',TBCD_TICS);
    AddConstant('TBCD_THUMB',TBCD_THUMB);
    AddConstant('TBCD_CHANNEL',TBCD_CHANNEL);
    AddConstant('DL_BEGINDRAG',DL_BEGINDRAG);
    AddConstant('DL_DRAGGING',DL_DRAGGING);
    AddConstant('DL_DROPPED',DL_DROPPED);
    AddConstant('DL_CANCELDRAG',DL_CANCELDRAG);
    AddConstant('DL_CURSORSET',DL_CURSORSET);
    AddConstant('DL_STOPCURSOR',DL_STOPCURSOR);
    AddConstant('DL_COPYCURSOR',DL_COPYCURSOR);
    AddConstant('DL_MOVECURSOR',DL_MOVECURSOR);
    AddConstant('DRAGLISTMSGSTRING',DRAGLISTMSGSTRING);
    AddConstant('UPDOWN_CLASS',UPDOWN_CLASS);
    AddConstant('UD_MAXVAL',UD_MAXVAL);
    AddConstant('UD_MINVAL',UD_MINVAL);
    AddConstant('UDS_WRAP',UDS_WRAP);
    AddConstant('UDS_SETBUDDYINT',UDS_SETBUDDYINT);
    AddConstant('UDS_ALIGNRIGHT',UDS_ALIGNRIGHT);
    AddConstant('UDS_ALIGNLEFT',UDS_ALIGNLEFT);
    AddConstant('UDS_AUTOBUDDY',UDS_AUTOBUDDY);
    AddConstant('UDS_ARROWKEYS',UDS_ARROWKEYS);
    AddConstant('UDS_HORZ',UDS_HORZ);
    AddConstant('UDS_NOTHOUSANDS',UDS_NOTHOUSANDS);
    AddConstant('UDS_HOTTRACK',UDS_HOTTRACK);
    AddConstant('UDM_SETRANGE',UDM_SETRANGE);
    AddConstant('UDM_GETRANGE',UDM_GETRANGE);
    AddConstant('UDM_SETPOS',UDM_SETPOS);
    AddConstant('UDM_GETPOS',UDM_GETPOS);
    AddConstant('UDM_SETBUDDY',UDM_SETBUDDY);
    AddConstant('UDM_GETBUDDY',UDM_GETBUDDY);
    AddConstant('UDM_SETACCEL',UDM_SETACCEL);
    AddConstant('UDM_GETACCEL',UDM_GETACCEL);
    AddConstant('UDM_SETBASE',UDM_SETBASE);
    AddConstant('UDM_GETBASE',UDM_GETBASE);
    AddConstant('UDM_SETRANGE32',UDM_SETRANGE32);
    AddConstant('UDM_GETRANGE32',UDM_GETRANGE32);
    AddConstant('UDM_SETUNICODEFORMAT',UDM_SETUNICODEFORMAT);
    AddConstant('UDM_GETUNICODEFORMAT',UDM_GETUNICODEFORMAT);
    AddConstant('UDN_DELTAPOS',UDN_DELTAPOS);
    AddConstant('PROGRESS_CLASS',PROGRESS_CLASS);
    AddConstant('PBS_SMOOTH',PBS_SMOOTH);
    AddConstant('PBS_VERTICAL',PBS_VERTICAL);
    AddConstant('PBM_SETRANGE',PBM_SETRANGE);
    AddConstant('PBM_SETPOS',PBM_SETPOS);
    AddConstant('PBM_DELTAPOS',PBM_DELTAPOS);
    AddConstant('PBM_SETSTEP',PBM_SETSTEP);
    AddConstant('PBM_STEPIT',PBM_STEPIT);
    AddConstant('PBM_SETRANGE32',PBM_SETRANGE32);
    AddConstant('PBM_GETRANGE',PBM_GETRANGE);
    AddConstant('PBM_GETPOS',PBM_GETPOS);
    AddConstant('PBM_SETBARCOLOR',PBM_SETBARCOLOR);
    AddConstant('PBM_SETBKCOLOR',PBM_SETBKCOLOR);
    AddConstant('HOTKEYF_SHIFT',HOTKEYF_SHIFT);
    AddConstant('HOTKEYF_CONTROL',HOTKEYF_CONTROL);
    AddConstant('HOTKEYF_ALT',HOTKEYF_ALT);
    AddConstant('HOTKEYF_EXT',HOTKEYF_EXT);
    AddConstant('HKCOMB_NONE',HKCOMB_NONE);
    AddConstant('HKCOMB_S',HKCOMB_S);
    AddConstant('HKCOMB_C',HKCOMB_C);
    AddConstant('HKCOMB_A',HKCOMB_A);
    AddConstant('HKCOMB_SC',HKCOMB_SC);
    AddConstant('HKCOMB_SA',HKCOMB_SA);
    AddConstant('HKCOMB_CA',HKCOMB_CA);
    AddConstant('HKCOMB_SCA',HKCOMB_SCA);
    AddConstant('HKM_SETHOTKEY',HKM_SETHOTKEY);
    AddConstant('HKM_GETHOTKEY',HKM_GETHOTKEY);
    AddConstant('HKM_SETRULES',HKM_SETRULES);
    AddConstant('HOTKEYCLASS',HOTKEYCLASS);
    AddConstant('CCS_TOP',CCS_TOP);
    AddConstant('CCS_NOMOVEY',CCS_NOMOVEY);
    AddConstant('CCS_BOTTOM',CCS_BOTTOM);
    AddConstant('CCS_NORESIZE',CCS_NORESIZE);
    AddConstant('CCS_NOPARENTALIGN',CCS_NOPARENTALIGN);
    AddConstant('CCS_ADJUSTABLE',CCS_ADJUSTABLE);
    AddConstant('CCS_NODIVIDER',CCS_NODIVIDER);
    AddConstant('CCS_VERT',CCS_VERT);
    AddConstant('CCS_LEFT',CCS_LEFT);
    AddConstant('CCS_RIGHT',CCS_RIGHT);
    AddConstant('CCS_NOMOVEX',CCS_NOMOVEX);
    AddConstant('WC_LISTVIEW',WC_LISTVIEW);
    AddConstant('LVS_ICON',LVS_ICON);
    AddConstant('LVS_REPORT',LVS_REPORT);
    AddConstant('LVS_SMALLICON',LVS_SMALLICON);
    AddConstant('LVS_LIST',LVS_LIST);
    AddConstant('LVS_TYPEMASK',LVS_TYPEMASK);
    AddConstant('LVS_SINGLESEL',LVS_SINGLESEL);
    AddConstant('LVS_SHOWSELALWAYS',LVS_SHOWSELALWAYS);
    AddConstant('LVS_SORTASCENDING',LVS_SORTASCENDING);
    AddConstant('LVS_SORTDESCENDING',LVS_SORTDESCENDING);
    AddConstant('LVS_SHAREIMAGELISTS',LVS_SHAREIMAGELISTS);
    AddConstant('LVS_NOLABELWRAP',LVS_NOLABELWRAP);
    AddConstant('LVS_AUTOARRANGE',LVS_AUTOARRANGE);
    AddConstant('LVS_EDITLABELS',LVS_EDITLABELS);
    AddConstant('LVS_OWNERDATA',LVS_OWNERDATA);
    AddConstant('LVS_NOSCROLL',LVS_NOSCROLL);
    AddConstant('LVS_TYPESTYLEMASK',LVS_TYPESTYLEMASK);
    AddConstant('LVS_ALIGNTOP',LVS_ALIGNTOP);
    AddConstant('LVS_ALIGNLEFT',LVS_ALIGNLEFT);
    AddConstant('LVS_ALIGNMASK',LVS_ALIGNMASK);
    AddConstant('LVS_OWNERDRAWFIXED',LVS_OWNERDRAWFIXED);
    AddConstant('LVS_NOCOLUMNHEADER',LVS_NOCOLUMNHEADER);
    AddConstant('LVS_NOSORTHEADER',LVS_NOSORTHEADER);
    AddConstant('LVS_EX_GRIDLINES',LVS_EX_GRIDLINES);
    AddConstant('LVS_EX_SUBITEMIMAGES',LVS_EX_SUBITEMIMAGES);
    AddConstant('LVS_EX_CHECKBOXES',LVS_EX_CHECKBOXES);
    AddConstant('LVS_EX_TRACKSELECT',LVS_EX_TRACKSELECT);
    AddConstant('LVS_EX_HEADERDRAGDROP',LVS_EX_HEADERDRAGDROP);
    AddConstant('LVS_EX_FULLROWSELECT',LVS_EX_FULLROWSELECT);
    AddConstant('LVS_EX_ONECLICKACTIVATE',LVS_EX_ONECLICKACTIVATE);
    AddConstant('LVS_EX_TWOCLICKACTIVATE',LVS_EX_TWOCLICKACTIVATE);
    AddConstant('LVS_EX_FLATSB',LVS_EX_FLATSB);
    AddConstant('LVS_EX_REGIONAL',LVS_EX_REGIONAL);
    AddConstant('LVS_EX_INFOTIP',LVS_EX_INFOTIP);
    AddConstant('LVS_EX_UNDERLINEHOT',LVS_EX_UNDERLINEHOT);
    AddConstant('LVS_EX_UNDERLINECOLD',LVS_EX_UNDERLINECOLD);
    AddConstant('LVS_EX_MULTIWORKAREAS',LVS_EX_MULTIWORKAREAS);
    AddConstant('LVM_SETUNICODEFORMAT',LVM_SETUNICODEFORMAT);
    AddConstant('LVM_GETUNICODEFORMAT',LVM_GETUNICODEFORMAT);
    AddConstant('LVM_GETBKCOLOR',LVM_GETBKCOLOR);
    AddConstant('LVM_SETBKCOLOR',LVM_SETBKCOLOR);
    AddConstant('LVM_GETIMAGELIST',LVM_GETIMAGELIST);
    AddConstant('LVSIL_NORMAL',LVSIL_NORMAL);
    AddConstant('LVSIL_SMALL',LVSIL_SMALL);
    AddConstant('LVSIL_STATE',LVSIL_STATE);
    AddConstant('LVM_SETIMAGELIST',LVM_SETIMAGELIST);
    AddConstant('LVM_GETITEMCOUNT',LVM_GETITEMCOUNT);
    AddConstant('LVIF_TEXT',LVIF_TEXT);
    AddConstant('LVIF_IMAGE',LVIF_IMAGE);
    AddConstant('LVIF_PARAM',LVIF_PARAM);
    AddConstant('LVIF_STATE',LVIF_STATE);
    AddConstant('LVIF_INDENT',LVIF_INDENT);
    AddConstant('LVIF_NORECOMPUTE',LVIF_NORECOMPUTE);
    AddConstant('LVIS_FOCUSED',LVIS_FOCUSED);
    AddConstant('LVIS_SELECTED',LVIS_SELECTED);
    AddConstant('LVIS_CUT',LVIS_CUT);
    AddConstant('LVIS_DROPHILITED',LVIS_DROPHILITED);
    AddConstant('LVIS_ACTIVATING',LVIS_ACTIVATING);
    AddConstant('LVIS_OVERLAYMASK',LVIS_OVERLAYMASK);
    AddConstant('LVIS_STATEIMAGEMASK',LVIS_STATEIMAGEMASK);
    AddConstant('I_INDENTCALLBACK',I_INDENTCALLBACK);
    AddConstant('I_IMAGECALLBACK',I_IMAGECALLBACK);
    AddConstant('LVM_GETITEMA',LVM_GETITEMA);
    AddConstant('LVM_SETITEMA',LVM_SETITEMA);
    AddConstant('LVM_INSERTITEMA',LVM_INSERTITEMA);
    AddConstant('LVM_GETITEMW',LVM_GETITEMW);
    AddConstant('LVM_SETITEMW',LVM_SETITEMW);
    AddConstant('LVM_INSERTITEMW',LVM_INSERTITEMW);
    AddConstant('LVM_GETITEM',LVM_GETITEM);
    AddConstant('LVM_SETITEM',LVM_SETITEM);
    AddConstant('LVM_INSERTITEM',LVM_INSERTITEM);
    AddConstant('LVM_DELETEITEM',LVM_DELETEITEM);
    AddConstant('LVM_DELETEALLITEMS',LVM_DELETEALLITEMS);
    AddConstant('LVM_GETCALLBACKMASK',LVM_GETCALLBACKMASK);
    AddConstant('LVM_SETCALLBACKMASK',LVM_SETCALLBACKMASK);
    AddConstant('LVNI_ALL',LVNI_ALL);
    AddConstant('LVNI_FOCUSED',LVNI_FOCUSED);
    AddConstant('LVNI_SELECTED',LVNI_SELECTED);
    AddConstant('LVNI_CUT',LVNI_CUT);
    AddConstant('LVNI_DROPHILITED',LVNI_DROPHILITED);
    AddConstant('LVNI_ABOVE',LVNI_ABOVE);
    AddConstant('LVNI_BELOW',LVNI_BELOW);
    AddConstant('LVNI_TOLEFT',LVNI_TOLEFT);
    AddConstant('LVNI_TORIGHT',LVNI_TORIGHT);
    AddConstant('LVM_GETNEXTITEM',LVM_GETNEXTITEM);
    AddConstant('LVFI_PARAM',LVFI_PARAM);
    AddConstant('LVFI_STRING',LVFI_STRING);
    AddConstant('LVFI_PARTIAL',LVFI_PARTIAL);
    AddConstant('LVFI_WRAP',LVFI_WRAP);
    AddConstant('LVFI_NEARESTXY',LVFI_NEARESTXY);
    AddConstant('LVM_FINDITEMA',LVM_FINDITEMA);
    AddConstant('LVM_FINDITEMW',LVM_FINDITEMW);
    AddConstant('LVM_FINDITEM',LVM_FINDITEM);
    AddConstant('LVIR_BOUNDS',LVIR_BOUNDS);
    AddConstant('LVIR_ICON',LVIR_ICON);
    AddConstant('LVIR_LABEL',LVIR_LABEL);
    AddConstant('LVIR_SELECTBOUNDS',LVIR_SELECTBOUNDS);
    AddConstant('LVM_GETITEMRECT',LVM_GETITEMRECT);
    AddConstant('LVM_SETITEMPOSITION',LVM_SETITEMPOSITION);
    AddConstant('LVM_GETITEMPOSITION',LVM_GETITEMPOSITION);
    AddConstant('LVM_GETSTRINGWIDTHA',LVM_GETSTRINGWIDTHA);
    AddConstant('LVM_GETSTRINGWIDTHW',LVM_GETSTRINGWIDTHW);
    AddConstant('LVM_GETSTRINGWIDTH',LVM_GETSTRINGWIDTH);
    AddConstant('LVHT_NOWHERE',LVHT_NOWHERE);
    AddConstant('LVHT_ONITEMICON',LVHT_ONITEMICON);
    AddConstant('LVHT_ONITEMLABEL',LVHT_ONITEMLABEL);
    AddConstant('LVHT_ONITEMSTATEICON',LVHT_ONITEMSTATEICON);
    AddConstant('LVHT_ONITEM',LVHT_ONITEM);
    AddConstant('LVHT_ABOVE',LVHT_ABOVE);
    AddConstant('LVHT_BELOW',LVHT_BELOW);
    AddConstant('LVHT_TORIGHT',LVHT_TORIGHT);
    AddConstant('LVHT_TOLEFT',LVHT_TOLEFT);
    AddConstant('LVM_HITTEST',LVM_HITTEST);
    AddConstant('LVM_ENSUREVISIBLE',LVM_ENSUREVISIBLE);
    AddConstant('LVM_SCROLL',LVM_SCROLL);
    AddConstant('LVM_REDRAWITEMS',LVM_REDRAWITEMS);
    AddConstant('LVA_DEFAULT',LVA_DEFAULT);
    AddConstant('LVA_ALIGNLEFT',LVA_ALIGNLEFT);
    AddConstant('LVA_ALIGNTOP',LVA_ALIGNTOP);
    AddConstant('LVA_ALIGNRIGHT',LVA_ALIGNRIGHT);
    AddConstant('LVA_ALIGNBOTTOM',LVA_ALIGNBOTTOM);
    AddConstant('LVA_SNAPTOGRID',LVA_SNAPTOGRID);
    AddConstant('LVA_SORTASCENDING',LVA_SORTASCENDING);
    AddConstant('LVA_SORTDESCENDING',LVA_SORTDESCENDING);
    AddConstant('LVM_ARRANGE',LVM_ARRANGE);
    AddConstant('LVM_EDITLABELA',LVM_EDITLABELA);
    AddConstant('LVM_EDITLABELW',LVM_EDITLABELW);
    AddConstant('LVM_EDITLABEL',LVM_EDITLABEL);
    AddConstant('LVM_GETEDITCONTROL',LVM_GETEDITCONTROL);
    AddConstant('LVCF_FMT',LVCF_FMT);
    AddConstant('LVCF_WIDTH',LVCF_WIDTH);
    AddConstant('LVCF_TEXT',LVCF_TEXT);
    AddConstant('LVCF_SUBITEM',LVCF_SUBITEM);
    AddConstant('LVCF_IMAGE',LVCF_IMAGE);
    AddConstant('LVCF_ORDER',LVCF_ORDER);
    AddConstant('LVCFMT_LEFT',LVCFMT_LEFT);
    AddConstant('LVCFMT_RIGHT',LVCFMT_RIGHT);
    AddConstant('LVCFMT_CENTER',LVCFMT_CENTER);
    AddConstant('LVCFMT_JUSTIFYMASK',LVCFMT_JUSTIFYMASK);
    AddConstant('LVCFMT_IMAGE',LVCFMT_IMAGE);
    AddConstant('LVCFMT_BITMAP_ON_RIGHT',LVCFMT_BITMAP_ON_RIGHT);
    AddConstant('LVCFMT_COL_HAS_IMAGES',LVCFMT_COL_HAS_IMAGES);
    AddConstant('LVM_GETCOLUMNA',LVM_GETCOLUMNA);
    AddConstant('LVM_GETCOLUMNW',LVM_GETCOLUMNW);
    AddConstant('LVM_GETCOLUMN',LVM_GETCOLUMN);
    AddConstant('LVM_SETCOLUMNA',LVM_SETCOLUMNA);
    AddConstant('LVM_SETCOLUMNW',LVM_SETCOLUMNW);
    AddConstant('LVM_SETCOLUMN',LVM_SETCOLUMN);
    AddConstant('LVM_INSERTCOLUMNA',LVM_INSERTCOLUMNA);
    AddConstant('LVM_INSERTCOLUMNW',LVM_INSERTCOLUMNW);
    AddConstant('LVM_INSERTCOLUMN',LVM_INSERTCOLUMN);
    AddConstant('LVM_DELETECOLUMN',LVM_DELETECOLUMN);
    AddConstant('LVM_GETCOLUMNWIDTH',LVM_GETCOLUMNWIDTH);
    AddConstant('LVSCW_AUTOSIZE',LVSCW_AUTOSIZE);
    AddConstant('LVSCW_AUTOSIZE_USEHEADER',LVSCW_AUTOSIZE_USEHEADER);
    AddConstant('LVM_SETCOLUMNWIDTH',LVM_SETCOLUMNWIDTH);
    AddConstant('LVM_GETHEADER',LVM_GETHEADER);
    AddConstant('LVM_CREATEDRAGIMAGE',LVM_CREATEDRAGIMAGE);
    AddConstant('LVM_GETVIEWRECT',LVM_GETVIEWRECT);
    AddConstant('LVM_GETTEXTCOLOR',LVM_GETTEXTCOLOR);
    AddConstant('LVM_SETTEXTCOLOR',LVM_SETTEXTCOLOR);
    AddConstant('LVM_GETTEXTBKCOLOR',LVM_GETTEXTBKCOLOR);
    AddConstant('LVM_SETTEXTBKCOLOR',LVM_SETTEXTBKCOLOR);
    AddConstant('LVM_GETTOPINDEX',LVM_GETTOPINDEX);
    AddConstant('LVM_GETCOUNTPERPAGE',LVM_GETCOUNTPERPAGE);
    AddConstant('LVM_GETORIGIN',LVM_GETORIGIN);
    AddConstant('LVM_UPDATE',LVM_UPDATE);
    AddConstant('LVM_SETITEMSTATE',LVM_SETITEMSTATE);
    AddConstant('LVM_GETITEMSTATE',LVM_GETITEMSTATE);
    AddConstant('LVM_GETITEMTEXTA',LVM_GETITEMTEXTA);
    AddConstant('LVM_GETITEMTEXTW',LVM_GETITEMTEXTW);
    AddConstant('LVM_GETITEMTEXT',LVM_GETITEMTEXT);
    AddConstant('LVM_SETITEMTEXTA',LVM_SETITEMTEXTA);
    AddConstant('LVM_SETITEMTEXTW',LVM_SETITEMTEXTW);
    AddConstant('LVM_SETITEMTEXT',LVM_SETITEMTEXT);
    AddConstant('LVSICF_NOINVALIDATEALL',LVSICF_NOINVALIDATEALL);
    AddConstant('LVSICF_NOSCROLL',LVSICF_NOSCROLL);
    AddConstant('LVM_SETITEMCOUNT',LVM_SETITEMCOUNT);
    AddConstant('LVM_SORTITEMS',LVM_SORTITEMS);
    AddConstant('LVM_SETITEMPOSITION32',LVM_SETITEMPOSITION32);
    AddConstant('LVM_GETSELECTEDCOUNT',LVM_GETSELECTEDCOUNT);
    AddConstant('LVM_GETITEMSPACING',LVM_GETITEMSPACING);
    AddConstant('LVM_GETISEARCHSTRINGA',LVM_GETISEARCHSTRINGA);
    AddConstant('LVM_GETISEARCHSTRINGW',LVM_GETISEARCHSTRINGW);
    AddConstant('LVM_GETISEARCHSTRING',LVM_GETISEARCHSTRING);
    AddConstant('LVM_SETICONSPACING',LVM_SETICONSPACING);
    AddConstant('LVM_SETEXTENDEDLISTVIEWSTYLE',LVM_SETEXTENDEDLISTVIEWSTYLE);
    AddConstant('LVM_GETEXTENDEDLISTVIEWSTYLE',LVM_GETEXTENDEDLISTVIEWSTYLE);
    AddConstant('LVM_GETSUBITEMRECT',LVM_GETSUBITEMRECT);
    AddConstant('LVM_SUBITEMHITTEST',LVM_SUBITEMHITTEST);
    AddConstant('LVM_SETCOLUMNORDERARRAY',LVM_SETCOLUMNORDERARRAY);
    AddConstant('LVM_GETCOLUMNORDERARRAY',LVM_GETCOLUMNORDERARRAY);
    AddConstant('LVM_SETHOTITEM',LVM_SETHOTITEM);
    AddConstant('LVM_GETHOTITEM',LVM_GETHOTITEM);
    AddConstant('LVM_SETHOTCURSOR',LVM_SETHOTCURSOR);
    AddConstant('LVM_GETHOTCURSOR',LVM_GETHOTCURSOR);
    AddConstant('LVM_APPROXIMATEVIEWRECT',LVM_APPROXIMATEVIEWRECT);
    AddConstant('LV_MAX_WORKAREAS',LV_MAX_WORKAREAS);
    AddConstant('LVM_SETWORKAREA',LVM_SETWORKAREA);
    AddConstant('LVM_GETSELECTIONMARK',LVM_GETSELECTIONMARK);
    AddConstant('LVM_SETSELECTIONMARK',LVM_SETSELECTIONMARK);
    AddConstant('LVM_GETWORKAREAS',LVM_GETWORKAREAS);
    AddConstant('LVM_SETHOVERTIME',LVM_SETHOVERTIME);
    AddConstant('LVM_GETHOVERTIME',LVM_GETHOVERTIME);
    AddConstant('LVM_GETNUMBEROFWORKAREAS',LVM_GETNUMBEROFWORKAREAS);
    AddConstant('LVM_SETTOOLTIPS',LVM_SETTOOLTIPS);
    AddConstant('LVM_GETTOOLTIPS',LVM_GETTOOLTIPS);
    AddConstant('LVBKIF_SOURCE_NONE',LVBKIF_SOURCE_NONE);
    AddConstant('LVBKIF_SOURCE_HBITMAP',LVBKIF_SOURCE_HBITMAP);
    AddConstant('LVBKIF_SOURCE_URL',LVBKIF_SOURCE_URL);
    AddConstant('LVBKIF_SOURCE_MASK',LVBKIF_SOURCE_MASK);
    AddConstant('LVBKIF_STYLE_NORMAL',LVBKIF_STYLE_NORMAL);
    AddConstant('LVBKIF_STYLE_TILE',LVBKIF_STYLE_TILE);
    AddConstant('LVBKIF_STYLE_MASK',LVBKIF_STYLE_MASK);
    AddConstant('LVM_SETBKIMAGEA',LVM_SETBKIMAGEA);
    AddConstant('LVM_SETBKIMAGEW',LVM_SETBKIMAGEW);
    AddConstant('LVM_GETBKIMAGEA',LVM_GETBKIMAGEA);
    AddConstant('LVM_GETBKIMAGEW',LVM_GETBKIMAGEW);
    AddConstant('LVM_SETBKIMAGE',LVM_SETBKIMAGE);
    AddConstant('LVM_GETBKIMAGE',LVM_GETBKIMAGE);
    AddConstant('LVKF_ALT',LVKF_ALT);
    AddConstant('LVKF_CONTROL',LVKF_CONTROL);
    AddConstant('LVKF_SHIFT',LVKF_SHIFT);
    AddConstant('LVN_ITEMCHANGING',LVN_ITEMCHANGING);
    AddConstant('LVN_ITEMCHANGED',LVN_ITEMCHANGED);
    AddConstant('LVN_INSERTITEM',LVN_INSERTITEM);
    AddConstant('LVN_DELETEITEM',LVN_DELETEITEM);
    AddConstant('LVN_DELETEALLITEMS',LVN_DELETEALLITEMS);
    AddConstant('LVN_COLUMNCLICK',LVN_COLUMNCLICK);
    AddConstant('LVN_BEGINDRAG',LVN_BEGINDRAG);
    AddConstant('LVN_BEGINRDRAG',LVN_BEGINRDRAG);
    AddConstant('LVN_ODCACHEHINT',LVN_ODCACHEHINT);
    AddConstant('LVN_ODFINDITEMA',LVN_ODFINDITEMA);
    AddConstant('LVN_ODFINDITEMW',LVN_ODFINDITEMW);
    AddConstant('LVN_ITEMACTIVATE',LVN_ITEMACTIVATE);
    AddConstant('LVN_ODSTATECHANGED',LVN_ODSTATECHANGED);
    AddConstant('LVN_ODFINDITEM',LVN_ODFINDITEM);
    AddConstant('LVN_BEGINLABELEDITA',LVN_BEGINLABELEDITA);
    AddConstant('LVN_ENDLABELEDITA',LVN_ENDLABELEDITA);
    AddConstant('LVN_BEGINLABELEDITW',LVN_BEGINLABELEDITW);
    AddConstant('LVN_ENDLABELEDITW',LVN_ENDLABELEDITW);
    AddConstant('LVN_BEGINLABELEDIT',LVN_BEGINLABELEDIT);
    AddConstant('LVN_ENDLABELEDIT',LVN_ENDLABELEDIT);
    AddConstant('LVN_HOTTRACK',LVN_HOTTRACK);
    AddConstant('LVN_GETDISPINFOA',LVN_GETDISPINFOA);
    AddConstant('LVN_SETDISPINFOA',LVN_SETDISPINFOA);
    AddConstant('LVN_GETDISPINFOW',LVN_GETDISPINFOW);
    AddConstant('LVN_SETDISPINFOW',LVN_SETDISPINFOW);
    AddConstant('LVN_GETDISPINFO',LVN_GETDISPINFO);
    AddConstant('LVN_SETDISPINFO',LVN_SETDISPINFO);
    AddConstant('LVIF_DI_SETITEM',LVIF_DI_SETITEM);
    AddConstant('LVN_KEYDOWN',LVN_KEYDOWN);
    AddConstant('LVN_MARQUEEBEGIN',LVN_MARQUEEBEGIN);
    AddConstant('LVGIT_UNFOLDED',LVGIT_UNFOLDED);
    AddConstant('LVN_GETINFOTIPA',LVN_GETINFOTIPA);
    AddConstant('LVN_GETINFOTIPW',LVN_GETINFOTIPW);
    AddConstant('LVN_GETINFOTIP',LVN_GETINFOTIP);
    AddConstant('WC_TREEVIEW',WC_TREEVIEW);
    AddConstant('TVS_HASBUTTONS',TVS_HASBUTTONS);
    AddConstant('TVS_HASLINES',TVS_HASLINES);
    AddConstant('TVS_LINESATROOT',TVS_LINESATROOT);
    AddConstant('TVS_EDITLABELS',TVS_EDITLABELS);
    AddConstant('TVS_DISABLEDRAGDROP',TVS_DISABLEDRAGDROP);
    AddConstant('TVS_SHOWSELALWAYS',TVS_SHOWSELALWAYS);
    AddConstant('TVS_RTLREADING',TVS_RTLREADING);
    AddConstant('TVS_NOTOOLTIPS',TVS_NOTOOLTIPS);
    AddConstant('TVS_CHECKBOXES',TVS_CHECKBOXES);
    AddConstant('TVS_TRACKSELECT',TVS_TRACKSELECT);
    AddConstant('TVS_SINGLEEXPAND',TVS_SINGLEEXPAND);
    AddConstant('TVS_INFOTIP',TVS_INFOTIP);
    AddConstant('TVS_FULLROWSELECT',TVS_FULLROWSELECT);
    AddConstant('TVS_NOSCROLL',TVS_NOSCROLL);
    AddConstant('TVS_NONEVENHEIGHT',TVS_NONEVENHEIGHT);
    AddConstant('TVIF_TEXT',TVIF_TEXT);
    AddConstant('TVIF_IMAGE',TVIF_IMAGE);
    AddConstant('TVIF_PARAM',TVIF_PARAM);
    AddConstant('TVIF_STATE',TVIF_STATE);
    AddConstant('TVIF_HANDLE',TVIF_HANDLE);
    AddConstant('TVIF_SELECTEDIMAGE',TVIF_SELECTEDIMAGE);
    AddConstant('TVIF_CHILDREN',TVIF_CHILDREN);
    AddConstant('TVIF_INTEGRAL',TVIF_INTEGRAL);
    AddConstant('TVIS_FOCUSED',TVIS_FOCUSED);
    AddConstant('TVIS_SELECTED',TVIS_SELECTED);
    AddConstant('TVIS_CUT',TVIS_CUT);
    AddConstant('TVIS_DROPHILITED',TVIS_DROPHILITED);
    AddConstant('TVIS_BOLD',TVIS_BOLD);
    AddConstant('TVIS_EXPANDED',TVIS_EXPANDED);
    AddConstant('TVIS_EXPANDEDONCE',TVIS_EXPANDEDONCE);
    AddConstant('TVIS_EXPANDPARTIAL',TVIS_EXPANDPARTIAL);
    AddConstant('TVIS_OVERLAYMASK',TVIS_OVERLAYMASK);
    AddConstant('TVIS_STATEIMAGEMASK',TVIS_STATEIMAGEMASK);
    AddConstant('TVIS_USERMASK',TVIS_USERMASK);
    AddConstant('I_CHILDRENCALLBACK',I_CHILDRENCALLBACK);
    AddConstant('TVM_INSERTITEMA',TVM_INSERTITEMA);
    AddConstant('TVM_INSERTITEMW',TVM_INSERTITEMW);
    AddConstant('TVM_INSERTITEM',TVM_INSERTITEM);
    AddConstant('TVM_DELETEITEM',TVM_DELETEITEM);
    AddConstant('TVM_EXPAND',TVM_EXPAND);
    AddConstant('TVE_COLLAPSE',TVE_COLLAPSE);
    AddConstant('TVE_EXPAND',TVE_EXPAND);
    AddConstant('TVE_TOGGLE',TVE_TOGGLE);
    AddConstant('TVE_EXPANDPARTIAL',TVE_EXPANDPARTIAL);
    AddConstant('TVE_COLLAPSERESET',TVE_COLLAPSERESET);
    AddConstant('TVM_GETITEMRECT',TVM_GETITEMRECT);
    AddConstant('TVM_GETCOUNT',TVM_GETCOUNT);
    AddConstant('TVM_GETINDENT',TVM_GETINDENT);
    AddConstant('TVM_SETINDENT',TVM_SETINDENT);
    AddConstant('TVM_GETIMAGELIST',TVM_GETIMAGELIST);
    AddConstant('TVSIL_NORMAL',TVSIL_NORMAL);
    AddConstant('TVSIL_STATE',TVSIL_STATE);
    AddConstant('TVM_SETIMAGELIST',TVM_SETIMAGELIST);
    AddConstant('TVM_GETNEXTITEM',TVM_GETNEXTITEM);
    AddConstant('TVGN_ROOT',TVGN_ROOT);
    AddConstant('TVGN_NEXT',TVGN_NEXT);
    AddConstant('TVGN_PREVIOUS',TVGN_PREVIOUS);
    AddConstant('TVGN_PARENT',TVGN_PARENT);
    AddConstant('TVGN_CHILD',TVGN_CHILD);
    AddConstant('TVGN_FIRSTVISIBLE',TVGN_FIRSTVISIBLE);
    AddConstant('TVGN_NEXTVISIBLE',TVGN_NEXTVISIBLE);
    AddConstant('TVGN_PREVIOUSVISIBLE',TVGN_PREVIOUSVISIBLE);
    AddConstant('TVGN_DROPHILITE',TVGN_DROPHILITE);
    AddConstant('TVGN_CARET',TVGN_CARET);
    AddConstant('TVGN_LASTVISIBLE',TVGN_LASTVISIBLE);
    AddConstant('TVM_SELECTITEM',TVM_SELECTITEM);
    AddConstant('TVM_GETITEMA',TVM_GETITEMA);
    AddConstant('TVM_GETITEMW',TVM_GETITEMW);
    AddConstant('TVM_GETITEM',TVM_GETITEM);
    AddConstant('TVM_SETITEMA',TVM_SETITEMA);
    AddConstant('TVM_SETITEMW',TVM_SETITEMW);
    AddConstant('TVM_SETITEM',TVM_SETITEM);
    AddConstant('TVM_EDITLABELA',TVM_EDITLABELA);
    AddConstant('TVM_EDITLABELW',TVM_EDITLABELW);
    AddConstant('TVM_EDITLABEL',TVM_EDITLABEL);
    AddConstant('TVM_GETEDITCONTROL',TVM_GETEDITCONTROL);
    AddConstant('TVM_GETVISIBLECOUNT',TVM_GETVISIBLECOUNT);
    AddConstant('TVM_HITTEST',TVM_HITTEST);
    AddConstant('TVHT_NOWHERE',TVHT_NOWHERE);
    AddConstant('TVHT_ONITEMICON',TVHT_ONITEMICON);
    AddConstant('TVHT_ONITEMLABEL',TVHT_ONITEMLABEL);
    AddConstant('TVHT_ONITEMINDENT',TVHT_ONITEMINDENT);
    AddConstant('TVHT_ONITEMBUTTON',TVHT_ONITEMBUTTON);
    AddConstant('TVHT_ONITEMRIGHT',TVHT_ONITEMRIGHT);
    AddConstant('TVHT_ONITEMSTATEICON',TVHT_ONITEMSTATEICON);
    AddConstant('TVHT_ONITEM',TVHT_ONITEM);
    AddConstant('TVHT_ABOVE',TVHT_ABOVE);
    AddConstant('TVHT_BELOW',TVHT_BELOW);
    AddConstant('TVHT_TORIGHT',TVHT_TORIGHT);
    AddConstant('TVHT_TOLEFT',TVHT_TOLEFT);
    AddConstant('TVM_CREATEDRAGIMAGE',TVM_CREATEDRAGIMAGE);
    AddConstant('TVM_SORTCHILDREN',TVM_SORTCHILDREN);
    AddConstant('TVM_ENSUREVISIBLE',TVM_ENSUREVISIBLE);
    AddConstant('TVM_SORTCHILDRENCB',TVM_SORTCHILDRENCB);
    AddConstant('TVM_ENDEDITLABELNOW',TVM_ENDEDITLABELNOW);
    AddConstant('TVM_GETISEARCHSTRINGA',TVM_GETISEARCHSTRINGA);
    AddConstant('TVM_GETISEARCHSTRINGW',TVM_GETISEARCHSTRINGW);
    AddConstant('TVM_GETISEARCHSTRING',TVM_GETISEARCHSTRING);
    AddConstant('TVM_SETTOOLTIPS',TVM_SETTOOLTIPS);
    AddConstant('TVM_GETTOOLTIPS',TVM_GETTOOLTIPS);
    AddConstant('TVM_SETINSERTMARK',TVM_SETINSERTMARK);
    AddConstant('TVM_SETUNICODEFORMAT',TVM_SETUNICODEFORMAT);
    AddConstant('TVM_GETUNICODEFORMAT',TVM_GETUNICODEFORMAT);
    AddConstant('TVM_SETITEMHEIGHT',TVM_SETITEMHEIGHT);
    AddConstant('TVM_GETITEMHEIGHT',TVM_GETITEMHEIGHT);
    AddConstant('TVM_SETBKCOLOR',TVM_SETBKCOLOR);
    AddConstant('TVM_SETTEXTCOLOR',TVM_SETTEXTCOLOR);
    AddConstant('TVM_GETBKCOLOR',TVM_GETBKCOLOR);
    AddConstant('TVM_GETTEXTCOLOR',TVM_GETTEXTCOLOR);
    AddConstant('TVM_SETSCROLLTIME',TVM_SETSCROLLTIME);
    AddConstant('TVM_GETSCROLLTIME',TVM_GETSCROLLTIME);
    AddConstant('TVM_SETINSERTMARKCOLOR',TVM_SETINSERTMARKCOLOR);
    AddConstant('TVM_GETINSERTMARKCOLOR',TVM_GETINSERTMARKCOLOR);
    AddConstant('TVN_SELCHANGINGA',TVN_SELCHANGINGA);
    AddConstant('TVN_SELCHANGEDA',TVN_SELCHANGEDA);
    AddConstant('TVN_SELCHANGINGW',TVN_SELCHANGINGW);
    AddConstant('TVN_SELCHANGEDW',TVN_SELCHANGEDW);
    AddConstant('TVN_SELCHANGING',TVN_SELCHANGING);
    AddConstant('TVN_SELCHANGED',TVN_SELCHANGED);
    AddConstant('TVC_UNKNOWN',TVC_UNKNOWN);
    AddConstant('TVC_BYMOUSE',TVC_BYMOUSE);
    AddConstant('TVC_BYKEYBOARD',TVC_BYKEYBOARD);
    AddConstant('TVN_GETDISPINFOA',TVN_GETDISPINFOA);
    AddConstant('TVN_SETDISPINFOA',TVN_SETDISPINFOA);
    AddConstant('TVN_GETDISPINFOW',TVN_GETDISPINFOW);
    AddConstant('TVN_SETDISPINFOW',TVN_SETDISPINFOW);
    AddConstant('TVN_GETDISPINFO',TVN_GETDISPINFO);
    AddConstant('TVN_SETDISPINFO',TVN_SETDISPINFO);
    AddConstant('TVIF_DI_SETITEM',TVIF_DI_SETITEM);
    AddConstant('TVN_ITEMEXPANDINGA',TVN_ITEMEXPANDINGA);
    AddConstant('TVN_ITEMEXPANDEDA',TVN_ITEMEXPANDEDA);
    AddConstant('TVN_BEGINDRAGA',TVN_BEGINDRAGA);
    AddConstant('TVN_BEGINRDRAGA',TVN_BEGINRDRAGA);
    AddConstant('TVN_DELETEITEMA',TVN_DELETEITEMA);
    AddConstant('TVN_BEGINLABELEDITA',TVN_BEGINLABELEDITA);
    AddConstant('TVN_ENDLABELEDITA',TVN_ENDLABELEDITA);
    AddConstant('TVN_GETINFOTIPA',TVN_GETINFOTIPA);
    AddConstant('TVN_ITEMEXPANDINGW',TVN_ITEMEXPANDINGW);
    AddConstant('TVN_ITEMEXPANDEDW',TVN_ITEMEXPANDEDW);
    AddConstant('TVN_BEGINDRAGW',TVN_BEGINDRAGW);
    AddConstant('TVN_BEGINRDRAGW',TVN_BEGINRDRAGW);
    AddConstant('TVN_DELETEITEMW',TVN_DELETEITEMW);
    AddConstant('TVN_BEGINLABELEDITW',TVN_BEGINLABELEDITW);
    AddConstant('TVN_ENDLABELEDITW',TVN_ENDLABELEDITW);
    AddConstant('TVN_GETINFOTIPW',TVN_GETINFOTIPW);
    AddConstant('TVN_ITEMEXPANDING',TVN_ITEMEXPANDING);
    AddConstant('TVN_ITEMEXPANDED',TVN_ITEMEXPANDED);
    AddConstant('TVN_BEGINDRAG',TVN_BEGINDRAG);
    AddConstant('TVN_BEGINRDRAG',TVN_BEGINRDRAG);
    AddConstant('TVN_DELETEITEM',TVN_DELETEITEM);
    AddConstant('TVN_BEGINLABELEDIT',TVN_BEGINLABELEDIT);
    AddConstant('TVN_ENDLABELEDIT',TVN_ENDLABELEDIT);
    AddConstant('TVN_GETINFOTIP',TVN_GETINFOTIP);
    AddConstant('TVN_KEYDOWN',TVN_KEYDOWN);
    AddConstant('TVN_SINGLEEXPAND',TVN_SINGLEEXPAND);
    AddConstant('TVCDRF_NOIMAGES',TVCDRF_NOIMAGES);
    AddConstant('WC_COMBOBOXEX',WC_COMBOBOXEX);
    AddConstant('CBEIF_TEXT',CBEIF_TEXT);
    AddConstant('CBEIF_IMAGE',CBEIF_IMAGE);
    AddConstant('CBEIF_SELECTEDIMAGE',CBEIF_SELECTEDIMAGE);
    AddConstant('CBEIF_OVERLAY',CBEIF_OVERLAY);
    AddConstant('CBEIF_INDENT',CBEIF_INDENT);
    AddConstant('CBEIF_LPARAM',CBEIF_LPARAM);
    AddConstant('CBEIF_DI_SETITEM',CBEIF_DI_SETITEM);
    AddConstant('CBEM_INSERTITEMA',CBEM_INSERTITEMA);
    AddConstant('CBEM_SETIMAGELIST',CBEM_SETIMAGELIST);
    AddConstant('CBEM_GETIMAGELIST',CBEM_GETIMAGELIST);
    AddConstant('CBEM_GETITEMA',CBEM_GETITEMA);
    AddConstant('CBEM_SETITEMA',CBEM_SETITEMA);
    AddConstant('CBEM_DELETEITEM',CBEM_DELETEITEM);
    AddConstant('CBEM_GETCOMBOCONTROL',CBEM_GETCOMBOCONTROL);
    AddConstant('CBEM_GETEDITCONTROL',CBEM_GETEDITCONTROL);
    AddConstant('CBEM_SETEXSTYLE',CBEM_SETEXSTYLE);
    AddConstant('CBEM_GETEXSTYLE',CBEM_GETEXSTYLE);
    AddConstant('CBEM_GETEXTENDEDSTYLE',CBEM_GETEXTENDEDSTYLE);
    AddConstant('CBEM_HASEDITCHANGED',CBEM_HASEDITCHANGED);
    AddConstant('CBEM_INSERTITEMW',CBEM_INSERTITEMW);
    AddConstant('CBEM_SETITEMW',CBEM_SETITEMW);
    AddConstant('CBEM_GETITEMW',CBEM_GETITEMW);
    AddConstant('CBEM_SETEXTENDEDSTYLE',CBEM_SETEXTENDEDSTYLE);
    AddConstant('CBEM_SETUNICODEFORMAT',CBEM_SETUNICODEFORMAT);
    AddConstant('CBEM_GETUNICODEFORMAT',CBEM_GETUNICODEFORMAT);
    AddConstant('CBEM_INSERTITEM',CBEM_INSERTITEM);
    AddConstant('CBEM_SETITEM',CBEM_SETITEM);
    AddConstant('CBEM_GETITEM',CBEM_GETITEM);
    AddConstant('CBES_EX_NOEDITIMAGE',CBES_EX_NOEDITIMAGE);
    AddConstant('CBES_EX_NOEDITIMAGEINDENT',CBES_EX_NOEDITIMAGEINDENT);
    AddConstant('CBES_EX_PATHWORDBREAKPROC',CBES_EX_PATHWORDBREAKPROC);
    AddConstant('CBES_EX_NOSIZELIMIT',CBES_EX_NOSIZELIMIT);
    AddConstant('CBES_EX_CASESENSITIVE',CBES_EX_CASESENSITIVE);
    AddConstant('CBEN_GETDISPINFOA',CBEN_GETDISPINFOA);
    AddConstant('CBEN_INSERTITEM',CBEN_INSERTITEM);
    AddConstant('CBEN_DELETEITEM',CBEN_DELETEITEM);
    AddConstant('CBEN_BEGINEDIT',CBEN_BEGINEDIT);
    AddConstant('CBEN_ENDEDITA',CBEN_ENDEDITA);
    AddConstant('CBEN_ENDEDITW',CBEN_ENDEDITW);
    AddConstant('CBEN_GETDISPINFOW',CBEN_GETDISPINFOW);
    AddConstant('CBEN_DRAGBEGINA',CBEN_DRAGBEGINA);
    AddConstant('CBEN_DRAGBEGINW',CBEN_DRAGBEGINW);
    AddConstant('CBEN_ENDEDIT',CBEN_ENDEDIT);
    AddConstant('CBEN_GETDISPINFO',CBEN_GETDISPINFO);
    AddConstant('CBEN_DRAGBEGIN',CBEN_DRAGBEGIN);
    AddConstant('CBENF_KILLFOCUS',CBENF_KILLFOCUS);
    AddConstant('CBENF_RETURN',CBENF_RETURN);
    AddConstant('CBENF_ESCAPE',CBENF_ESCAPE);
    AddConstant('CBENF_DROPDOWN',CBENF_DROPDOWN);
    AddConstant('CBEMAXSTRLEN',CBEMAXSTRLEN);
    AddConstant('WC_TABCONTROL',WC_TABCONTROL);
    AddConstant('TCS_SCROLLOPPOSITE',TCS_SCROLLOPPOSITE);
    AddConstant('TCS_BOTTOM',TCS_BOTTOM);
    AddConstant('TCS_RIGHT',TCS_RIGHT);
    AddConstant('TCS_MULTISELECT',TCS_MULTISELECT);
    AddConstant('TCS_FLATBUTTONS',TCS_FLATBUTTONS);
    AddConstant('TCS_FORCEICONLEFT',TCS_FORCEICONLEFT);
    AddConstant('TCS_FORCELABELLEFT',TCS_FORCELABELLEFT);
    AddConstant('TCS_HOTTRACK',TCS_HOTTRACK);
    AddConstant('TCS_VERTICAL',TCS_VERTICAL);
    AddConstant('TCS_TABS',TCS_TABS);
    AddConstant('TCS_BUTTONS',TCS_BUTTONS);
    AddConstant('TCS_SINGLELINE',TCS_SINGLELINE);
    AddConstant('TCS_MULTILINE',TCS_MULTILINE);
    AddConstant('TCS_RIGHTJUSTIFY',TCS_RIGHTJUSTIFY);
    AddConstant('TCS_FIXEDWIDTH',TCS_FIXEDWIDTH);
    AddConstant('TCS_RAGGEDRIGHT',TCS_RAGGEDRIGHT);
    AddConstant('TCS_FOCUSONBUTTONDOWN',TCS_FOCUSONBUTTONDOWN);
    AddConstant('TCS_OWNERDRAWFIXED',TCS_OWNERDRAWFIXED);
    AddConstant('TCS_TOOLTIPS',TCS_TOOLTIPS);
    AddConstant('TCS_FOCUSNEVER',TCS_FOCUSNEVER);
    AddConstant('TCS_EX_FLATSEPARATORS',TCS_EX_FLATSEPARATORS);
    AddConstant('TCS_EX_REGISTERDROP',TCS_EX_REGISTERDROP);
    AddConstant('TCM_GETIMAGELIST',TCM_GETIMAGELIST);
    AddConstant('TCM_SETIMAGELIST',TCM_SETIMAGELIST);
    AddConstant('TCM_GETITEMCOUNT',TCM_GETITEMCOUNT);
    AddConstant('TCM_DELETEITEM',TCM_DELETEITEM);
    AddConstant('TCM_DELETEALLITEMS',TCM_DELETEALLITEMS);
    AddConstant('TCM_GETITEMRECT',TCM_GETITEMRECT);
    AddConstant('TCM_GETCURSEL',TCM_GETCURSEL);
    AddConstant('TCM_SETCURSEL',TCM_SETCURSEL);
    AddConstant('TCM_HITTEST',TCM_HITTEST);
    AddConstant('TCM_SETITEMEXTRA',TCM_SETITEMEXTRA);
    AddConstant('TCM_ADJUSTRECT',TCM_ADJUSTRECT);
    AddConstant('TCM_SETITEMSIZE',TCM_SETITEMSIZE);
    AddConstant('TCM_REMOVEIMAGE',TCM_REMOVEIMAGE);
    AddConstant('TCM_SETPADDING',TCM_SETPADDING);
    AddConstant('TCM_GETROWCOUNT',TCM_GETROWCOUNT);
    AddConstant('TCM_GETTOOLTIPS',TCM_GETTOOLTIPS);
    AddConstant('TCM_SETTOOLTIPS',TCM_SETTOOLTIPS);
    AddConstant('TCM_GETCURFOCUS',TCM_GETCURFOCUS);
    AddConstant('TCM_SETCURFOCUS',TCM_SETCURFOCUS);
    AddConstant('TCM_SETMINTABWIDTH',TCM_SETMINTABWIDTH);
    AddConstant('TCM_DESELECTALL',TCM_DESELECTALL);
    AddConstant('TCM_HIGHLIGHTITEM',TCM_HIGHLIGHTITEM);
    AddConstant('TCM_SETEXTENDEDSTYLE',TCM_SETEXTENDEDSTYLE);
    AddConstant('TCM_GETEXTENDEDSTYLE',TCM_GETEXTENDEDSTYLE);
    AddConstant('TCM_SETUNICODEFORMAT',TCM_SETUNICODEFORMAT);
    AddConstant('TCM_GETUNICODEFORMAT',TCM_GETUNICODEFORMAT);
    AddConstant('TCIF_TEXT',TCIF_TEXT);
    AddConstant('TCIF_IMAGE',TCIF_IMAGE);
    AddConstant('TCIF_RTLREADING',TCIF_RTLREADING);
    AddConstant('TCIF_PARAM',TCIF_PARAM);
    AddConstant('TCIF_STATE',TCIF_STATE);
    AddConstant('TCIS_BUTTONPRESSED',TCIS_BUTTONPRESSED);
    AddConstant('TCIS_HIGHLIGHTED',TCIS_HIGHLIGHTED);
    AddConstant('TCM_GETITEMA',TCM_GETITEMA);
    AddConstant('TCM_SETITEMA',TCM_SETITEMA);
    AddConstant('TCM_INSERTITEMA',TCM_INSERTITEMA);
    AddConstant('TCM_GETITEMW',TCM_GETITEMW);
    AddConstant('TCM_SETITEMW',TCM_SETITEMW);
    AddConstant('TCM_INSERTITEMW',TCM_INSERTITEMW);
    AddConstant('TCM_GETITEM',TCM_GETITEM);
    AddConstant('TCM_SETITEM',TCM_SETITEM);
    AddConstant('TCM_INSERTITEM',TCM_INSERTITEM);
    AddConstant('TCHT_NOWHERE',TCHT_NOWHERE);
    AddConstant('TCHT_ONITEMICON',TCHT_ONITEMICON);
    AddConstant('TCHT_ONITEMLABEL',TCHT_ONITEMLABEL);
    AddConstant('TCHT_ONITEM',TCHT_ONITEM);
    AddConstant('TCN_KEYDOWN',TCN_KEYDOWN);
    AddConstant('TCN_SELCHANGE',TCN_SELCHANGE);
    AddConstant('TCN_SELCHANGING',TCN_SELCHANGING);
    AddConstant('TCN_GETOBJECT',TCN_GETOBJECT);
    AddConstant('ANIMATE_CLASS',ANIMATE_CLASS);
    AddConstant('ACS_CENTER',ACS_CENTER);
    AddConstant('ACS_TRANSPARENT',ACS_TRANSPARENT);
    AddConstant('ACS_AUTOPLAY',ACS_AUTOPLAY);
    AddConstant('ACS_TIMER',ACS_TIMER);
    AddConstant('ACM_OPENA',ACM_OPENA);
    AddConstant('ACM_OPENW',ACM_OPENW);
    AddConstant('ACM_OPEN',ACM_OPEN);
    AddConstant('ACM_PLAY',ACM_PLAY);
    AddConstant('ACM_STOP',ACM_STOP);
    AddConstant('ACN_START',ACN_START);
    AddConstant('ACN_STOP',ACN_STOP);
    AddConstant('MONTHCAL_CLASS',MONTHCAL_CLASS);
    AddConstant('MCM_FIRST',MCM_FIRST);
    AddConstant('MCM_GETCURSEL',MCM_GETCURSEL);
    AddConstant('MCM_SETCURSEL',MCM_SETCURSEL);
    AddConstant('MCM_GETMAXSELCOUNT',MCM_GETMAXSELCOUNT);
    AddConstant('MCM_SETMAXSELCOUNT',MCM_SETMAXSELCOUNT);
    AddConstant('MCM_GETSELRANGE',MCM_GETSELRANGE);
    AddConstant('MCM_SETSELRANGE',MCM_SETSELRANGE);
    AddConstant('MCM_GETMONTHRANGE',MCM_GETMONTHRANGE);
    AddConstant('MCM_SETDAYSTATE',MCM_SETDAYSTATE);
    AddConstant('MCM_GETMINREQRECT',MCM_GETMINREQRECT);
    AddConstant('MCM_SETCOLOR',MCM_SETCOLOR);
    AddConstant('MCM_GETCOLOR',MCM_GETCOLOR);
    AddConstant('MCM_SETTODAY',MCM_SETTODAY);
    AddConstant('MCM_GETTODAY',MCM_GETTODAY);
    AddConstant('MCM_HITTEST',MCM_HITTEST);
    AddConstant('MCM_SETFIRSTDAYOFWEEK',MCM_SETFIRSTDAYOFWEEK);
    AddConstant('MCM_GETFIRSTDAYOFWEEK',MCM_GETFIRSTDAYOFWEEK);
    AddConstant('MCM_GETRANGE',MCM_GETRANGE);
    AddConstant('MCM_SETRANGE',MCM_SETRANGE);
    AddConstant('MCM_GETMONTHDELTA',MCM_GETMONTHDELTA);
    AddConstant('MCM_SETMONTHDELTA',MCM_SETMONTHDELTA);
    AddConstant('MCM_GETMAXTODAYWIDTH',MCM_GETMAXTODAYWIDTH);
    AddConstant('MCM_SETUNICODEFORMAT',MCM_SETUNICODEFORMAT);
    AddConstant('MCM_GETUNICODEFORMAT',MCM_GETUNICODEFORMAT);
    AddConstant('MCHT_TITLE',MCHT_TITLE);
    AddConstant('MCHT_CALENDAR',MCHT_CALENDAR);
    AddConstant('MCHT_TODAYLINK',MCHT_TODAYLINK);
    AddConstant('MCHT_NEXT',MCHT_NEXT);
    AddConstant('MCHT_PREV',MCHT_PREV);
    AddConstant('MCHT_NOWHERE',MCHT_NOWHERE);
    AddConstant('MCHT_TITLEBK',MCHT_TITLEBK);
    AddConstant('MCHT_TITLEMONTH',MCHT_TITLEMONTH);
    AddConstant('MCHT_TITLEYEAR',MCHT_TITLEYEAR);
    AddConstant('MCHT_TITLEBTNNEXT',MCHT_TITLEBTNNEXT);
    AddConstant('MCHT_TITLEBTNPREV',MCHT_TITLEBTNPREV);
    AddConstant('MCHT_CALENDARBK',MCHT_CALENDARBK);
    AddConstant('MCHT_CALENDARDATE',MCHT_CALENDARDATE);
    AddConstant('MCHT_CALENDARDATENEXT',MCHT_CALENDARDATENEXT);
    AddConstant('MCHT_CALENDARDATEPREV',MCHT_CALENDARDATEPREV);
    AddConstant('MCHT_CALENDARDAY',MCHT_CALENDARDAY);
    AddConstant('MCHT_CALENDARWEEKNUM',MCHT_CALENDARWEEKNUM);
    AddConstant('MCSC_BACKGROUND',MCSC_BACKGROUND);
    AddConstant('MCSC_TEXT',MCSC_TEXT);
    AddConstant('MCSC_TITLEBK',MCSC_TITLEBK);
    AddConstant('MCSC_TITLETEXT',MCSC_TITLETEXT);
    AddConstant('MCSC_MONTHBK',MCSC_MONTHBK);
    AddConstant('MCSC_TRAILINGTEXT',MCSC_TRAILINGTEXT);
    AddConstant('MCN_SELCHANGE',MCN_SELCHANGE);
    AddConstant('MCN_GETDAYSTATE',MCN_GETDAYSTATE);
    AddConstant('MCN_SELECT',MCN_SELECT);
    AddConstant('MCS_DAYSTATE',MCS_DAYSTATE);
    AddConstant('MCS_MULTISELECT',MCS_MULTISELECT);
    AddConstant('MCS_WEEKNUMBERS',MCS_WEEKNUMBERS);
    AddConstant('MCS_NOTODAY_PRE_IE4',MCS_NOTODAY_PRE_IE4);
    AddConstant('MCS_NOTODAYCIRCLE',MCS_NOTODAYCIRCLE);
    AddConstant('MCS_NOTODAY',MCS_NOTODAY);
    AddConstant('GMR_VISIBLE',GMR_VISIBLE);
    AddConstant('GMR_DAYSTATE',GMR_DAYSTATE);
    AddConstant('DATETIMEPICK_CLASS',DATETIMEPICK_CLASS);
    AddConstant('DTM_FIRST',DTM_FIRST);
    AddConstant('DTM_GETSYSTEMTIME',DTM_GETSYSTEMTIME);
    AddConstant('DTM_SETSYSTEMTIME',DTM_SETSYSTEMTIME);
    AddConstant('DTM_GETRANGE',DTM_GETRANGE);
    AddConstant('DTM_SETRANGE',DTM_SETRANGE);
    AddConstant('DTM_SETFORMATA',DTM_SETFORMATA);
    AddConstant('DTM_SETMCCOLOR',DTM_SETMCCOLOR);
    AddConstant('DTM_GETMCCOLOR',DTM_GETMCCOLOR);
    AddConstant('DTM_GETMONTHCAL',DTM_GETMONTHCAL);
    AddConstant('DTM_SETMCFONT',DTM_SETMCFONT);
    AddConstant('DTM_GETMCFONT',DTM_GETMCFONT);
    AddConstant('DTM_SETFORMATW',DTM_SETFORMATW);
    AddConstant('DTM_SETFORMAT',DTM_SETFORMAT);
    AddConstant('DTS_UPDOWN',DTS_UPDOWN);
    AddConstant('DTS_SHOWNONE',DTS_SHOWNONE);
    AddConstant('DTS_SHORTDATEFORMAT',DTS_SHORTDATEFORMAT);
    AddConstant('DTS_LONGDATEFORMAT',DTS_LONGDATEFORMAT);
    AddConstant('DTS_TIMEFORMAT',DTS_TIMEFORMAT);
    AddConstant('DTS_APPCANPARSE',DTS_APPCANPARSE);
    AddConstant('DTS_RIGHTALIGN',DTS_RIGHTALIGN);
    AddConstant('DTN_DATETIMECHANGE',DTN_DATETIMECHANGE);
    AddConstant('DTN_USERSTRINGA',DTN_USERSTRINGA);
    AddConstant('DTN_USERSTRINGW',DTN_USERSTRINGW);
    AddConstant('DTN_WMKEYDOWNA',DTN_WMKEYDOWNA);
    AddConstant('DTN_WMKEYDOWNW',DTN_WMKEYDOWNW);
    AddConstant('DTN_FORMATA',DTN_FORMATA);
    AddConstant('DTN_FORMATW',DTN_FORMATW);
    AddConstant('DTN_FORMATQUERYA',DTN_FORMATQUERYA);
    AddConstant('DTN_FORMATQUERYW',DTN_FORMATQUERYW);
    AddConstant('DTN_DROPDOWN',DTN_DROPDOWN);
    AddConstant('DTN_CLOSEUP',DTN_CLOSEUP);
    AddConstant('DTN_USERSTRING',DTN_USERSTRING);
    AddConstant('DTN_WMKEYDOWN',DTN_WMKEYDOWN);
    AddConstant('DTN_FORMAT',DTN_FORMAT);
    AddConstant('DTN_FORMATQUERY',DTN_FORMATQUERY);
    AddConstant('GDTR_MIN',GDTR_MIN);
    AddConstant('GDTR_MAX',GDTR_MAX);
    AddConstant('GDT_ERROR',GDT_ERROR);
    AddConstant('GDT_VALID',GDT_VALID);
    AddConstant('GDT_NONE',GDT_NONE);
    AddConstant('WC_IPADDRESS',WC_IPADDRESS);
    AddConstant('IPM_CLEARADDRESS',IPM_CLEARADDRESS);
    AddConstant('IPM_SETADDRESS',IPM_SETADDRESS);
    AddConstant('IPM_GETADDRESS',IPM_GETADDRESS);
    AddConstant('IPM_SETRANGE',IPM_SETRANGE);
    AddConstant('IPM_SETFOCUS',IPM_SETFOCUS);
    AddConstant('IPM_ISBLANK',IPM_ISBLANK);
    AddConstant('IPN_FIELDCHANGED',IPN_FIELDCHANGED);
    AddConstant('WC_PAGESCROLLER',WC_PAGESCROLLER);
    AddConstant('PGS_VERT',PGS_VERT);
    AddConstant('PGS_HORZ',PGS_HORZ);
    AddConstant('PGS_AUTOSCROLL',PGS_AUTOSCROLL);
    AddConstant('PGS_DRAGNDROP',PGS_DRAGNDROP);
    AddConstant('PGF_INVISIBLE',PGF_INVISIBLE);
    AddConstant('PGF_NORMAL',PGF_NORMAL);
    AddConstant('PGF_GRAYED',PGF_GRAYED);
    AddConstant('PGF_DEPRESSED',PGF_DEPRESSED);
    AddConstant('PGF_HOT',PGF_HOT);
    AddConstant('PGB_TOPORLEFT',PGB_TOPORLEFT);
    AddConstant('PGB_BOTTOMORRIGHT',PGB_BOTTOMORRIGHT);
    AddConstant('PGM_SETCHILD',PGM_SETCHILD);
    AddConstant('PGM_RECALCSIZE',PGM_RECALCSIZE);
    AddConstant('PGM_FORWARDMOUSE',PGM_FORWARDMOUSE);
    AddConstant('PGM_SETBKCOLOR',PGM_SETBKCOLOR);
    AddConstant('PGM_GETBKCOLOR',PGM_GETBKCOLOR);
    AddConstant('PGM_SETBORDER',PGM_SETBORDER);
    AddConstant('PGM_GETBORDER',PGM_GETBORDER);
    AddConstant('PGM_SETPOS',PGM_SETPOS);
    AddConstant('PGM_GETPOS',PGM_GETPOS);
    AddConstant('PGM_SETBUTTONSIZE',PGM_SETBUTTONSIZE);
    AddConstant('PGM_GETBUTTONSIZE',PGM_GETBUTTONSIZE);
    AddConstant('PGM_GETBUTTONSTATE',PGM_GETBUTTONSTATE);
    AddConstant('PGM_GETDROPTARGET',PGM_GETDROPTARGET);
    AddConstant('PGN_SCROLL',PGN_SCROLL);
    AddConstant('PGF_SCROLLUP',PGF_SCROLLUP);
    AddConstant('PGF_SCROLLDOWN',PGF_SCROLLDOWN);
    AddConstant('PGF_SCROLLLEFT',PGF_SCROLLLEFT);
    AddConstant('PGF_SCROLLRIGHT',PGF_SCROLLRIGHT);
    AddConstant('PGK_SHIFT',PGK_SHIFT);
    AddConstant('PGK_CONTROL',PGK_CONTROL);
    AddConstant('PGK_MENU',PGK_MENU);
    AddConstant('PGN_CALCSIZE',PGN_CALCSIZE);
    AddConstant('PGF_CALCWIDTH',PGF_CALCWIDTH);
    AddConstant('PGF_CALCHEIGHT',PGF_CALCHEIGHT);
    AddConstant('WC_NATIVEFONTCTL',WC_NATIVEFONTCTL);
    AddConstant('NFS_EDIT',NFS_EDIT);
    AddConstant('NFS_STATIC',NFS_STATIC);
    AddConstant('NFS_LISTCOMBO',NFS_LISTCOMBO);
    AddConstant('NFS_BUTTON',NFS_BUTTON);
    AddConstant('NFS_ALL',NFS_ALL);
    AddConstant('WM_MOUSEHOVER',WM_MOUSEHOVER);
    AddConstant('WM_MOUSELEAVE',WM_MOUSELEAVE);
    AddConstant('TME_HOVER',TME_HOVER);
    AddConstant('TME_LEAVE',TME_LEAVE);
    AddConstant('TME_QUERY',TME_QUERY);
    AddConstant('TME_CANCEL',TME_CANCEL);
    AddConstant('HOVER_DEFAULT',HOVER_DEFAULT);
    AddConstant('WSB_PROP_CYVSCROLL',WSB_PROP_CYVSCROLL);
    AddConstant('WSB_PROP_CXHSCROLL',WSB_PROP_CXHSCROLL);
    AddConstant('WSB_PROP_CYHSCROLL',WSB_PROP_CYHSCROLL);
    AddConstant('WSB_PROP_CXVSCROLL',WSB_PROP_CXVSCROLL);
    AddConstant('WSB_PROP_CXHTHUMB',WSB_PROP_CXHTHUMB);
    AddConstant('WSB_PROP_CYVTHUMB',WSB_PROP_CYVTHUMB);
    AddConstant('WSB_PROP_VBKGCOLOR',WSB_PROP_VBKGCOLOR);
    AddConstant('WSB_PROP_HBKGCOLOR',WSB_PROP_HBKGCOLOR);
    AddConstant('WSB_PROP_VSTYLE',WSB_PROP_VSTYLE);
    AddConstant('WSB_PROP_HSTYLE',WSB_PROP_HSTYLE);
    AddConstant('WSB_PROP_WINSTYLE',WSB_PROP_WINSTYLE);
    AddConstant('WSB_PROP_PALETTE',WSB_PROP_PALETTE);
    AddConstant('WSB_PROP_MASK',WSB_PROP_MASK);
    AddConstant('FSB_FLAT_MODE',FSB_FLAT_MODE);
    AddConstant('FSB_ENCARTA_MODE',FSB_ENCARTA_MODE);
    AddConstant('FSB_REGULAR_MODE',FSB_REGULAR_MODE);
  end;
end;

class function TatCommctrlLibrary.LibraryName: string;
begin
  result := 'Commctrl';
end;

initialization
  RegisterScripterLibrary(TatCommctrlLibrary, True);

{$WARNINGS ON}

end.

