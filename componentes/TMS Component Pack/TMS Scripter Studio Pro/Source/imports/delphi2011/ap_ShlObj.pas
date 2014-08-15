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
unit ap_ShlObj;

interface

uses
  Windows,
  ActiveX,
  CommCtrl,
  ShellAPI,
  RegStr,
  Messages,
  WinInet,
  UrlMon,
  ObjectArray,
  PropSys,
  StructuredQueryCondition,
  ShlObj,
  Variants,
  ap_Windows,
  ap_Types,
  ap_UrlMon,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatShlObjLibrary = class(TatScripterLibrary)
    procedure __SHCreateItemInKnownFolder(AMachine: TatVirtualMachine);
    procedure __SHGetItemFromObject(AMachine: TatVirtualMachine);
    procedure __SHCreateAssociationRegistration(AMachine: TatVirtualMachine);
    procedure __SHCreateDefaultExtractIcon(AMachine: TatVirtualMachine);
    procedure __SetCurrentProcessExplicitAppUserModelID(AMachine: TatVirtualMachine);
    procedure __GetCurrentProcessExplicitAppUserModelID(AMachine: TatVirtualMachine);
    procedure __SHFree(AMachine: TatVirtualMachine);
    procedure __SHGetIconOverlayIndex(AMachine: TatVirtualMachine);
    procedure __SHGetIconOverlayIndexA(AMachine: TatVirtualMachine);
    procedure __SHGetIconOverlayIndexW(AMachine: TatVirtualMachine);
    procedure __SHCreateDirectory(AMachine: TatVirtualMachine);
    procedure __SHCreateDirectoryEx(AMachine: TatVirtualMachine);
    procedure __SHCreateDirectoryExA(AMachine: TatVirtualMachine);
    procedure __SHCreateDirectoryExW(AMachine: TatVirtualMachine);
    procedure __SHGetSpecialFolderPath(AMachine: TatVirtualMachine);
    procedure __SHGetSpecialFolderPathA(AMachine: TatVirtualMachine);
    procedure __SHGetSpecialFolderPathW(AMachine: TatVirtualMachine);
    procedure __SHFlushSFCache(AMachine: TatVirtualMachine);
    procedure __SHGetFolderPathA(AMachine: TatVirtualMachine);
    procedure __SHGetFolderPathW(AMachine: TatVirtualMachine);
    procedure __SHGetFolderPath(AMachine: TatVirtualMachine);
    procedure __SHGetFolderPathAndSubDir(AMachine: TatVirtualMachine);
    procedure __SHGetFolderPathAndSubDirA(AMachine: TatVirtualMachine);
    procedure __SHGetFolderPathAndSubDirW(AMachine: TatVirtualMachine);
    procedure __SHSetKnownFolderPath(AMachine: TatVirtualMachine);
    procedure __SHGetKnownFolderPath(AMachine: TatVirtualMachine);
    procedure __SHLoadInProc(AMachine: TatVirtualMachine);
    procedure __SHUpdateImageA(AMachine: TatVirtualMachine);
    procedure __SHUpdateImageW(AMachine: TatVirtualMachine);
    procedure __SHUpdateImage(AMachine: TatVirtualMachine);
    procedure __SHChangeNotifyRegister(AMachine: TatVirtualMachine);
    procedure __SHChangeNotifyDeregister(AMachine: TatVirtualMachine);
    procedure __SHChangeNotification_Unlock(AMachine: TatVirtualMachine);
    procedure __SHGetInstanceExplorer(AMachine: TatVirtualMachine);
    procedure __RestartDialog(AMachine: TatVirtualMachine);
    procedure __RestartDialogEx(AMachine: TatVirtualMachine);
    procedure __DAD_SetDragImage(AMachine: TatVirtualMachine);
    procedure __DAD_DragEnterEx(AMachine: TatVirtualMachine);
    procedure __DAD_ShowDragImage(AMachine: TatVirtualMachine);
    procedure __DAD_DragMove(AMachine: TatVirtualMachine);
    procedure __DAD_DragLeave(AMachine: TatVirtualMachine);
    procedure __DAD_AutoScroll(AMachine: TatVirtualMachine);
    procedure __ReadCabinetState(AMachine: TatVirtualMachine);
    procedure __WriteCabinetState(AMachine: TatVirtualMachine);
    procedure __PathMakeUniqueName(AMachine: TatVirtualMachine);
    procedure __PathQualify(AMachine: TatVirtualMachine);
    procedure __PathIsExe(AMachine: TatVirtualMachine);
    procedure __PathIsSlow(AMachine: TatVirtualMachine);
    procedure __PathIsSlowA(AMachine: TatVirtualMachine);
    procedure __PathIsSlowW(AMachine: TatVirtualMachine);
    procedure __PathCleanupSpec(AMachine: TatVirtualMachine);
    procedure __PathResolve(AMachine: TatVirtualMachine);
    procedure __GetFileNameFromBrowse(AMachine: TatVirtualMachine);
    procedure __DriveType(AMachine: TatVirtualMachine);
    procedure __RealDriveType(AMachine: TatVirtualMachine);
    procedure __IsNetDrive(AMachine: TatVirtualMachine);
    procedure __Shell_MergeMenus(AMachine: TatVirtualMachine);
    procedure __SHObjectProperties(AMachine: TatVirtualMachine);
    procedure __SHFormatDrive(AMachine: TatVirtualMachine);
    procedure __SHCreatePropSheetExtArray(AMachine: TatVirtualMachine);
    procedure __SHDestroyPropSheetExtArray(AMachine: TatVirtualMachine);
    procedure __PathGetShortPath(AMachine: TatVirtualMachine);
    procedure __PathYetAnotherMakeUniqueName(AMachine: TatVirtualMachine);
    procedure __Win32DeleteFile(AMachine: TatVirtualMachine);
    procedure __PathProcessCommand(AMachine: TatVirtualMachine);
    procedure __SHRestricted(AMachine: TatVirtualMachine);
    procedure __SHLoadOLE(AMachine: TatVirtualMachine);
    procedure __SHDefExtractIconA(AMachine: TatVirtualMachine);
    procedure __SHDefExtractIconW(AMachine: TatVirtualMachine);
    procedure __SHDefExtractIcon(AMachine: TatVirtualMachine);
    procedure __SHOpenWithDialog(AMachine: TatVirtualMachine);
    procedure __Shell_GetImageLists(AMachine: TatVirtualMachine);
    procedure __SHValidateUNC(AMachine: TatVirtualMachine);
    procedure __PifMgr_OpenProperties(AMachine: TatVirtualMachine);
    procedure __PifMgr_CloseProperties(AMachine: TatVirtualMachine);
    procedure __SHSetInstanceExplorer(AMachine: TatVirtualMachine);
    procedure __IsUserAnAdmin(AMachine: TatVirtualMachine);
    procedure __SHShellFolderView_Message(AMachine: TatVirtualMachine);
    procedure __SHGetSetSettings(AMachine: TatVirtualMachine);
    procedure __SHGetSettings(AMachine: TatVirtualMachine);
    procedure __SHPathPrepareForWriteA(AMachine: TatVirtualMachine);
    procedure __SHPathPrepareForWriteW(AMachine: TatVirtualMachine);
    procedure __SHPathPrepareForWrite(AMachine: TatVirtualMachine);
    procedure __PerUserInit(AMachine: TatVirtualMachine);
    procedure __SHRunControlPanel(AMachine: TatVirtualMachine);
    procedure __PickIconDlg(AMachine: TatVirtualMachine);
    procedure __ImportPrivacySettings(AMachine: TatVirtualMachine);
    procedure __GetCLSID_NetworkDomain(AMachine: TatVirtualMachine);
    procedure __GetCLSID_NetworkServer(AMachine: TatVirtualMachine);
    procedure __GetCLSID_NetworkShare(AMachine: TatVirtualMachine);
    procedure __GetCLSID_MyComputer(AMachine: TatVirtualMachine);
    procedure __GetCLSID_Internet(AMachine: TatVirtualMachine);
    procedure __GetCLSID_RecycleBin(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ControlPanel(AMachine: TatVirtualMachine);
    procedure __GetCLSID_Printers(AMachine: TatVirtualMachine);
    procedure __GetCLSID_MyDocuments(AMachine: TatVirtualMachine);
    procedure __GetCATID_BrowsableShellExt(AMachine: TatVirtualMachine);
    procedure __GetCATID_BrowseInPlace(AMachine: TatVirtualMachine);
    procedure __GetCATID_DeskBand(AMachine: TatVirtualMachine);
    procedure __GetCATID_InfoBand(AMachine: TatVirtualMachine);
    procedure __GetCATID_CommBand(AMachine: TatVirtualMachine);
    procedure __GetFMTID_Intshcut(AMachine: TatVirtualMachine);
    procedure __GetFMTID_InternetSite(AMachine: TatVirtualMachine);
    procedure __GetCGID_Explorer(AMachine: TatVirtualMachine);
    procedure __GetCGID_ShellDocView(AMachine: TatVirtualMachine);
    procedure __GetCGID_ShellServiceObject(AMachine: TatVirtualMachine);
    procedure __GetCGID_ExplorerBarDoc(AMachine: TatVirtualMachine);
    procedure __GetIID_IBriefcaseStg(AMachine: TatVirtualMachine);
    procedure __GetIID_IDefViewID(AMachine: TatVirtualMachine);
    procedure __GetCLSID_FolderShortcut(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CFSIconOverlayManager(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellThumbnailDiskCache(AMachine: TatVirtualMachine);
    procedure __GetSID_DefView(AMachine: TatVirtualMachine);
    procedure __GetCGID_DefView(AMachine: TatVirtualMachine);
    procedure __GetCLSID_MenuBand(AMachine: TatVirtualMachine);
    procedure __GetVID_LargeIcons(AMachine: TatVirtualMachine);
    procedure __GetVID_SmallIcons(AMachine: TatVirtualMachine);
    procedure __GetVID_List(AMachine: TatVirtualMachine);
    procedure __GetVID_Details(AMachine: TatVirtualMachine);
    procedure __GetVID_Tile(AMachine: TatVirtualMachine);
    procedure __GetVID_Content(AMachine: TatVirtualMachine);
    procedure __GetVID_Thumbnails(AMachine: TatVirtualMachine);
    procedure __GetVID_ThumbStrip(AMachine: TatVirtualMachine);
    procedure __GetSID_SShellDesktop(AMachine: TatVirtualMachine);
    procedure __GetSID_SInPlaceBrowser(AMachine: TatVirtualMachine);
    procedure __GetSID_SSearchBoxInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IDiscardableBrowserProperty(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CUrlHistory(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CURLSearchHook(AMachine: TatVirtualMachine);
    procedure __GetSID_SInternetExplorer(AMachine: TatVirtualMachine);
    procedure __GetSID_SWebBrowserApp(AMachine: TatVirtualMachine);
    procedure __GetCLSID_AutoComplete(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ACLHistory(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ACListISF(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ACLMRU(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ACLMulti(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ACLCustomMRU(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ProgressDialog(AMachine: TatVirtualMachine);
    procedure __GetSID_SProgressUI(AMachine: TatVirtualMachine);
    procedure __GetSID_STopLevelBrowser(AMachine: TatVirtualMachine);
    procedure __GetCLSID_FileTypes(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ActiveDesktop(AMachine: TatVirtualMachine);
    procedure __GetIID_ISynchronizedCallBack(AMachine: TatVirtualMachine);
    procedure __GetIID_IQueryAssociations(AMachine: TatVirtualMachine);
    procedure __GetCLSID_QueryAssociations(AMachine: TatVirtualMachine);
    procedure __GetCLSID_LinkColumnProvider(AMachine: TatVirtualMachine);
    procedure __GetCGID_ShortCut(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InternetButtons(AMachine: TatVirtualMachine);
    procedure __GetCLSID_MSOButtons(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ToolbarExtButtons(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DarwinAppPublisher(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DocHostUIHandler(AMachine: TatVirtualMachine);
    procedure __GetFMTID_ShellDetails(AMachine: TatVirtualMachine);
    procedure __GetFMTID_Storage(AMachine: TatVirtualMachine);
    procedure __GetFMTID_ImageProperties(AMachine: TatVirtualMachine);
    procedure __GetFMTID_CustomImageProperties(AMachine: TatVirtualMachine);
    procedure __GetFMTID_LibraryProperties(AMachine: TatVirtualMachine);
    procedure __GetFMTID_Displaced(AMachine: TatVirtualMachine);
    procedure __GetFMTID_Briefcase(AMachine: TatVirtualMachine);
    procedure __GetFMTID_Misc(AMachine: TatVirtualMachine);
    procedure __GetFMTID_WebView(AMachine: TatVirtualMachine);
    procedure __GetFMTID_MUSIC(AMachine: TatVirtualMachine);
    procedure __GetFMTID_DRM(AMachine: TatVirtualMachine);
    procedure __GetFMTID_Volume(AMachine: TatVirtualMachine);
    procedure __GetFMTID_Query(AMachine: TatVirtualMachine);
    procedure __GetCLSID_HWShellExecute(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DragDropHelper(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CAnchorBrowsePropertyPage(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CImageBrowsePropertyPage(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CDocBrowsePropertyPage(AMachine: TatVirtualMachine);
    procedure __GetSID_STopWindow(AMachine: TatVirtualMachine);
    procedure __GetSID_SGetViewFromViewDual(AMachine: TatVirtualMachine);
    procedure __GetCLSID_FolderItem(AMachine: TatVirtualMachine);
    procedure __GetCLSID_FolderItemsMultiLevel(AMachine: TatVirtualMachine);
    procedure __GetCLSID_NewMenu(AMachine: TatVirtualMachine);
    procedure __GetBHID_SFObject(AMachine: TatVirtualMachine);
    procedure __GetBHID_SFUIObject(AMachine: TatVirtualMachine);
    procedure __GetBHID_SFViewObject(AMachine: TatVirtualMachine);
    procedure __GetBHID_Storage(AMachine: TatVirtualMachine);
    procedure __GetBHID_Stream(AMachine: TatVirtualMachine);
    procedure __GetBHID_LinkTargetItem(AMachine: TatVirtualMachine);
    procedure __GetBHID_StorageEnum(AMachine: TatVirtualMachine);
    procedure __GetBHID_Transfer(AMachine: TatVirtualMachine);
    procedure __GetBHID_PropertyStore(AMachine: TatVirtualMachine);
    procedure __GetBHID_ThumbnailHandler(AMachine: TatVirtualMachine);
    procedure __GetBHID_EnumItems(AMachine: TatVirtualMachine);
    procedure __GetBHID_DataObject(AMachine: TatVirtualMachine);
    procedure __GetBHID_AssociationArray(AMachine: TatVirtualMachine);
    procedure __GetBHID_Filter(AMachine: TatVirtualMachine);
    procedure __GetBHID_EnumAssocHandlers(AMachine: TatVirtualMachine);
    procedure __GetSID_CtxQueryAssociations(AMachine: TatVirtualMachine);
    procedure __GetCLSID_QuickLinks(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ISFBand(AMachine: TatVirtualMachine);
    procedure __GetIID_CDefView(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellFldSetExt(AMachine: TatVirtualMachine);
    procedure __GetSID_SMenuBandChild(AMachine: TatVirtualMachine);
    procedure __GetSID_SMenuBandParent(AMachine: TatVirtualMachine);
    procedure __GetSID_SMenuPopup(AMachine: TatVirtualMachine);
    procedure __GetSID_SMenuBandBottomSelected(AMachine: TatVirtualMachine);
    procedure __GetSID_SMenuBandBottom(AMachine: TatVirtualMachine);
    procedure __GetSID_MenuShellFolder(AMachine: TatVirtualMachine);
    procedure __GetSID_SMenuBandContextMenuModifier(AMachine: TatVirtualMachine);
    procedure __GetSID_SMenuBandBKContextMenu(AMachine: TatVirtualMachine);
    procedure __GetCGID_MENUDESKBAR(AMachine: TatVirtualMachine);
    procedure __GetSID_SMenuBandTop(AMachine: TatVirtualMachine);
    procedure __GetCLSID_MenuToolbarBase(AMachine: TatVirtualMachine);
    procedure __GetCLSID_MenuBandSite(AMachine: TatVirtualMachine);
    procedure __GetSID_SCommDlgBrowser(AMachine: TatVirtualMachine);
    procedure __GetCPFG_LOGON_USERNAME(AMachine: TatVirtualMachine);
    procedure __GetCPFG_LOGON_PASSWORD(AMachine: TatVirtualMachine);
    procedure __GetCPFG_SMARTCARD_USERNAME(AMachine: TatVirtualMachine);
    procedure __GetCPFG_SMARTCARD_PIN(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_Invalid(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_Generic(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_GenericSearchResults(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_GenericLibrary(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_Documents(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_Pictures(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_Music(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_Videos(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_UserFiles(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_UsersLibraries(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_OtherUsers(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_PublishedItems(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_Communications(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_Contacts(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_StartMenu(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_RecordedTV(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_SavedGames(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_OpenSearch(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_SearchConnector(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_Games(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_ControlPanelCategory(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_ControlPanelClassic(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_Printers(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_RecycleBin(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_SoftwareExplorer(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_CompressedFolder(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_NetworkExplorer(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_Searches(AMachine: TatVirtualMachine);
    procedure __GetFOLDERTYPEID_SearchHome(AMachine: TatVirtualMachine);
    procedure __GetSYNCMGR_OBJECTID_Icon(AMachine: TatVirtualMachine);
    procedure __GetSYNCMGR_OBJECTID_EventStore(AMachine: TatVirtualMachine);
    procedure __GetSYNCMGR_OBJECTID_ConflictStore(AMachine: TatVirtualMachine);
    procedure __GetSYNCMGR_OBJECTID_BrowseContent(AMachine: TatVirtualMachine);
    procedure __GetSYNCMGR_OBJECTID_ShowSchedule(AMachine: TatVirtualMachine);
    procedure __GetSYNCMGR_OBJECTID_QueryBeforeActivate(AMachine: TatVirtualMachine);
    procedure __GetSYNCMGR_OBJECTID_QueryBeforeDeactivate(AMachine: TatVirtualMachine);
    procedure __GetSYNCMGR_OBJECTID_QueryBeforeEnable(AMachine: TatVirtualMachine);
    procedure __GetSYNCMGR_OBJECTID_QueryBeforeDisable(AMachine: TatVirtualMachine);
    procedure __GetSYNCMGR_OBJECTID_QueryBeforeDelete(AMachine: TatVirtualMachine);
    procedure __GetSYNCMGR_OBJECTID_EventLinkClick(AMachine: TatVirtualMachine);
    procedure __GetEP_NavPane(AMachine: TatVirtualMachine);
    procedure __GetEP_Commands(AMachine: TatVirtualMachine);
    procedure __GetEP_Commands_Organize(AMachine: TatVirtualMachine);
    procedure __GetEP_Commands_View(AMachine: TatVirtualMachine);
    procedure __GetEP_DetailsPane(AMachine: TatVirtualMachine);
    procedure __GetEP_PreviewPane(AMachine: TatVirtualMachine);
    procedure __GetEP_QueryPane(AMachine: TatVirtualMachine);
    procedure __GetEP_AdvQueryPane(AMachine: TatVirtualMachine);
    procedure __GetCATID_LocationFactory(AMachine: TatVirtualMachine);
    procedure __GetCATID_LocationProvider(AMachine: TatVirtualMachine);
    procedure __GetItemCount_Property_GUID(AMachine: TatVirtualMachine);
    procedure __GetSelectedItemCount_Property_GUID(AMachine: TatVirtualMachine);
    procedure __GetItemIndex_Property_GUID(AMachine: TatVirtualMachine);
    procedure __GetIID_IContextMenu(AMachine: TatVirtualMachine);
    procedure __GetIID_IContextMenu2(AMachine: TatVirtualMachine);
    procedure __GetIID_IContextMenu3(AMachine: TatVirtualMachine);
    procedure __GetIID_IExecuteCommand(AMachine: TatVirtualMachine);
    procedure __GetIID_IPersistFolder(AMachine: TatVirtualMachine);
    procedure __GetIID_IRunnableTask(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellTaskScheduler(AMachine: TatVirtualMachine);
    procedure __GetIID_IQueryCodePage(AMachine: TatVirtualMachine);
    procedure __GetIID_IPersistFolder2(AMachine: TatVirtualMachine);
    procedure __GetIID_IPersistFolder3(AMachine: TatVirtualMachine);
    procedure __GetIID_IPersistIDList(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumIDList(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumFullIDList(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjectWithFolderEnumMode(AMachine: TatVirtualMachine);
    procedure __GetIID_IParseAndCreateItem(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellFolder(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumExtraSearch(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellFolder2(AMachine: TatVirtualMachine);
    procedure __GetIID_IFolderViewOptions(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellView(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellView2(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellView3(AMachine: TatVirtualMachine);
    procedure __GetIID_IFolderView(AMachine: TatVirtualMachine);
    procedure __GetIID_ISearchBoxInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IFolderView2(AMachine: TatVirtualMachine);
    procedure __GetIID_IFolderViewSettings(AMachine: TatVirtualMachine);
    procedure __GetIID_IPreviewHandlerVisuals(AMachine: TatVirtualMachine);
    procedure __GetIID_IVisualProperties(AMachine: TatVirtualMachine);
    procedure __GetIID_ICommDlgBrowser(AMachine: TatVirtualMachine);
    procedure __GetIID_ICommDlgBrowser2(AMachine: TatVirtualMachine);
    procedure __GetIID_ICommDlgBrowser3(AMachine: TatVirtualMachine);
    procedure __GetIID_IColumnManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IFolderFilterSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IFolderFilter(AMachine: TatVirtualMachine);
    procedure __GetIID_IInputObjectSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IInputObject(AMachine: TatVirtualMachine);
    procedure __GetIID_IInputObject2(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellIcon(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellBrowser(AMachine: TatVirtualMachine);
    procedure __GetIID_IProfferService(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellItem(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellItem2(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellItemImageFactory(AMachine: TatVirtualMachine);
    procedure __GetIID_IUserAccountChangeCallback(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumShellItems(AMachine: TatVirtualMachine);
    procedure __GetIID_ITransferAdviseSink(AMachine: TatVirtualMachine);
    procedure __GetIID_ITransferSource(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumResources(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellItemResources(AMachine: TatVirtualMachine);
    procedure __GetIID_ITransferDestination(AMachine: TatVirtualMachine);
    procedure __GetIID_IStreamAsync(AMachine: TatVirtualMachine);
    procedure __GetIID_IStreamUnbufferedInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileOperationProgressSink(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellItemArray(AMachine: TatVirtualMachine);
    procedure __GetIID_IInitializeWithItem(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjectWithSelection(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjectWithBackReferences(AMachine: TatVirtualMachine);
    procedure __GetIID_IPropertyUI(AMachine: TatVirtualMachine);
    procedure __GetIID_ICategoryProvider(AMachine: TatVirtualMachine);
    procedure __GetIID_ICategorizer(AMachine: TatVirtualMachine);
    procedure __GetIID_IDropTargetHelper(AMachine: TatVirtualMachine);
    procedure __GetIID_IDragSourceHelper(AMachine: TatVirtualMachine);
    procedure __GetIID_IDragSourceHelper2(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellLinkA(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellLinkW(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellLink(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellLinkDataList(AMachine: TatVirtualMachine);
    procedure __GetIID_IResolveShellLink(AMachine: TatVirtualMachine);
    procedure __GetIID_IActionProgressDialog(AMachine: TatVirtualMachine);
    procedure __GetIID_IHWEventHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_IHWEventHandler2(AMachine: TatVirtualMachine);
    procedure __GetIID_IQueryCancelAutoPlay(AMachine: TatVirtualMachine);
    procedure __GetIID_IDynamicHWHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_IActionProgress(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellExtInit(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellPropSheetExt(AMachine: TatVirtualMachine);
    procedure __GetIID_IRemoteComputer(AMachine: TatVirtualMachine);
    procedure __GetIID_IQueryContinue(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjectWithCancelEvent(AMachine: TatVirtualMachine);
    procedure __GetIID_IUserNotification(AMachine: TatVirtualMachine);
    procedure __GetIID_IUserNotificationCallback(AMachine: TatVirtualMachine);
    procedure __GetIID_IUserNotification2(AMachine: TatVirtualMachine);
    procedure __GetIID_IItemNameLimits(AMachine: TatVirtualMachine);
    procedure __GetIID_ISearchFolderItemFactory(AMachine: TatVirtualMachine);
    procedure __GetIID_IExtractImage(AMachine: TatVirtualMachine);
    procedure __GetIID_IExtractImage2(AMachine: TatVirtualMachine);
    procedure __GetIID_IThumbnailHandlerFactory(AMachine: TatVirtualMachine);
    procedure __GetIID_IParentAndItem(AMachine: TatVirtualMachine);
    procedure __GetIID_IDockingWindow(AMachine: TatVirtualMachine);
    procedure __GetIID_IDeskBand(AMachine: TatVirtualMachine);
    procedure __GetIID_IDeskBandInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IDeskBand2(AMachine: TatVirtualMachine);
    procedure __GetIID_ITaskbarList(AMachine: TatVirtualMachine);
    procedure __GetIID_ITaskbarList2(AMachine: TatVirtualMachine);
    procedure __GetIID_ITaskbarList3(AMachine: TatVirtualMachine);
    procedure __GetIID_ITaskbarList4(AMachine: TatVirtualMachine);
    procedure __GetIID_IStartMenuPinnedList(AMachine: TatVirtualMachine);
    procedure __GetIID_ICDBurn(AMachine: TatVirtualMachine);
    procedure __GetIID_IWizardSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IWizardExtension(AMachine: TatVirtualMachine);
    procedure __GetIID_IWebWizardExtension(AMachine: TatVirtualMachine);
    procedure __GetIID_IPublishingWizard(AMachine: TatVirtualMachine);
    procedure __GetIID_IFolderViewHost(AMachine: TatVirtualMachine);
    procedure __GetIID_IExplorerBrowserEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IExplorerBrowser(AMachine: TatVirtualMachine);
    procedure __GetIID_IAccessibleObject(AMachine: TatVirtualMachine);
    procedure __GetIID_IResultsFolder(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumObjects(AMachine: TatVirtualMachine);
    procedure __GetIID_IOperationsProgressDialog(AMachine: TatVirtualMachine);
    procedure __GetIID_IIOCancelInformation(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileOperation(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjectProvider(AMachine: TatVirtualMachine);
    procedure __GetIID_INamespaceWalkCB(AMachine: TatVirtualMachine);
    procedure __GetIID_INamespaceWalkCB2(AMachine: TatVirtualMachine);
    procedure __GetIID_INamespaceWalk(AMachine: TatVirtualMachine);
    procedure __GetIID_IAutoCompleteDropDown(AMachine: TatVirtualMachine);
    procedure __GetIID_IBandSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IModalWindow(AMachine: TatVirtualMachine);
    procedure __GetIID_ICDBurnExt(AMachine: TatVirtualMachine);
    procedure __GetIID_IContextMenuSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumReadyCallback(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumerableView(AMachine: TatVirtualMachine);
    procedure __GetIID_IInsertItem(AMachine: TatVirtualMachine);
    procedure __GetIID_IMenuBand(AMachine: TatVirtualMachine);
    procedure __GetIID_IFolderBandPriv(AMachine: TatVirtualMachine);
    procedure __GetIID_IRegTreeItem(AMachine: TatVirtualMachine);
    procedure __GetIID_IImageRecompress(AMachine: TatVirtualMachine);
    procedure __GetIID_IDeskBar(AMachine: TatVirtualMachine);
    procedure __GetIID_IMenuPopup(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileIsInUse(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileDialogEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileDialog(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileSaveDialog(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileOpenDialog(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileDialogCustomize(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileDialogControlEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileDialog2(AMachine: TatVirtualMachine);
    procedure __GetIID_IApplicationAssociationRegistration(AMachine: TatVirtualMachine);
    procedure __GetIID_IApplicationAssociationRegistrationUI(AMachine: TatVirtualMachine);
    procedure __GetIID_IDelegateFolder(AMachine: TatVirtualMachine);
    procedure __GetIID_IBrowserFrameOptions(AMachine: TatVirtualMachine);
    procedure __GetIID_INewWindowManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IAttachmentExecute(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellMenuCallback(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellMenu(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellRunDll(AMachine: TatVirtualMachine);
    procedure __GetIID_IKnownFolder(AMachine: TatVirtualMachine);
    procedure __GetIID_IKnownFolderManager(AMachine: TatVirtualMachine);
    procedure __GetIID_ISharingConfigurationManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IPreviousVersionsInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IRelatedItem(AMachine: TatVirtualMachine);
    procedure __GetIID_IIdentityName(AMachine: TatVirtualMachine);
    procedure __GetIID_IDelegateItem(AMachine: TatVirtualMachine);
    procedure __GetIID_ICurrentItem(AMachine: TatVirtualMachine);
    procedure __GetIID_ITransferMediumItem(AMachine: TatVirtualMachine);
    procedure __GetIID_IUseToBrowseItem(AMachine: TatVirtualMachine);
    procedure __GetIID_IDisplayItem(AMachine: TatVirtualMachine);
    procedure __GetIID_IViewStateIdentityItem(AMachine: TatVirtualMachine);
    procedure __GetIID_IPreviewItem(AMachine: TatVirtualMachine);
    procedure __GetIID_IDestinationStreamFactory(AMachine: TatVirtualMachine);
    procedure __GetIID_INewMenuClient(AMachine: TatVirtualMachine);
    procedure __GetIID_IInitializeWithBindCtx(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellItemFilter(AMachine: TatVirtualMachine);
    procedure __GetIID_INameSpaceTreeControl(AMachine: TatVirtualMachine);
    procedure __GetIID_INameSpaceTreeControl2(AMachine: TatVirtualMachine);
    procedure __GetIID_INameSpaceTreeControlEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_INameSpaceTreeControlDropHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_INameSpaceTreeAccessible(AMachine: TatVirtualMachine);
    procedure __GetIID_INameSpaceTreeControlCustomDraw(AMachine: TatVirtualMachine);
    procedure __GetIID_INameSpaceTreeControlFolderCapabilities(AMachine: TatVirtualMachine);
    procedure __GetIID_IPreviewHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_IPreviewHandlerFrame(AMachine: TatVirtualMachine);
    procedure __GetIID_ITrayDeskBand(AMachine: TatVirtualMachine);
    procedure __GetIID_IBandHost(AMachine: TatVirtualMachine);
    procedure __GetIID_IExplorerPaneVisibility(AMachine: TatVirtualMachine);
    procedure __GetIID_IContextMenuCB(AMachine: TatVirtualMachine);
    procedure __GetIID_IDefaultExtractIconInit(AMachine: TatVirtualMachine);
    procedure __GetIID_IExplorerCommand(AMachine: TatVirtualMachine);
    procedure __GetIID_IExplorerCommandState(AMachine: TatVirtualMachine);
    procedure __GetIID_IInitializeCommand(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumExplorerCommand(AMachine: TatVirtualMachine);
    procedure __GetIID_IExplorerCommandProvider(AMachine: TatVirtualMachine);
    procedure __GetIID_IMarkupCallback(AMachine: TatVirtualMachine);
    procedure __GetIID_IControlMarkup(AMachine: TatVirtualMachine);
    procedure __GetIID_IInitializeNetworkFolder(AMachine: TatVirtualMachine);
    procedure __GetIID_IOpenControlPanel(AMachine: TatVirtualMachine);
    procedure __GetIID_IComputerInfoChangeNotify(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileSystemBindData(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileSystemBindData2(AMachine: TatVirtualMachine);
    procedure __GetIID_ICustomDestinationList(AMachine: TatVirtualMachine);
    procedure __GetIID_IApplicationDestinations(AMachine: TatVirtualMachine);
    procedure __GetIID_IApplicationDocumentLists(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjectWithAppUserModelID(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjectWithProgID(AMachine: TatVirtualMachine);
    procedure __GetIID_IUpdateIDList(AMachine: TatVirtualMachine);
    procedure __GetIID_IDesktopGadget(AMachine: TatVirtualMachine);
    procedure __GetIID_IHomeGroup(AMachine: TatVirtualMachine);
    procedure __GetIID_IInitializeWithPropertyStore(AMachine: TatVirtualMachine);
    procedure __GetIID_IOpenSearchSource(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellLibrary(AMachine: TatVirtualMachine);
    procedure __GetIID_IAssocHandlerInvoker(AMachine: TatVirtualMachine);
    procedure __GetIID_IAssocHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumAssocHandlers(AMachine: TatVirtualMachine);
    procedure __GetSID_SFolderView(AMachine: TatVirtualMachine);
    procedure __GetSID_SExplorerBrowserFrame(AMachine: TatVirtualMachine);
    procedure __GetSID_SProfferService(AMachine: TatVirtualMachine);
    procedure __GetCGID_DeskBand(AMachine: TatVirtualMachine);
    procedure __GetSID_WizardSite(AMachine: TatVirtualMachine);
    procedure __GetSID_WebWizardHost(AMachine: TatVirtualMachine);
    procedure __GetSID_SBandSite(AMachine: TatVirtualMachine);
    procedure __GetCGID_BandSite(AMachine: TatVirtualMachine);
    procedure __GetSID_CDWizardHost(AMachine: TatVirtualMachine);
    procedure __GetSID_EnumerableView(AMachine: TatVirtualMachine);
    procedure __GetSID_SNewWindowManager(AMachine: TatVirtualMachine);
    procedure __GetSID_SNewMenuClient(AMachine: TatVirtualMachine);
    procedure __GetSID_SCommandBarState(AMachine: TatVirtualMachine);
    procedure __GetSID_SNavigationPane(AMachine: TatVirtualMachine);
    procedure __GetSID_SBandHost(AMachine: TatVirtualMachine);
    procedure __GetSID_ExplorerPaneVisibility(AMachine: TatVirtualMachine);
    procedure __GetSID_LinkSite(AMachine: TatVirtualMachine);
    procedure __GetSID_SShellBrowser(AMachine: TatVirtualMachine);
    procedure __GetTOID_NULL(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellDesktop(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellFSFolder(AMachine: TatVirtualMachine);
    procedure __GetCLSID_NetworkPlaces(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellLink(AMachine: TatVirtualMachine);
    procedure __GetCLSID_QueryCancelAutoPlay(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DriveSizeCategorizer(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DriveTypeCategorizer(AMachine: TatVirtualMachine);
    procedure __GetCLSID_FreeSpaceCategorizer(AMachine: TatVirtualMachine);
    procedure __GetCLSID_TimeCategorizer(AMachine: TatVirtualMachine);
    procedure __GetCLSID_SizeCategorizer(AMachine: TatVirtualMachine);
    procedure __GetCLSID_AlphabeticalCategorizer(AMachine: TatVirtualMachine);
    procedure __GetCLSID_MergedCategorizer(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ImageProperties(AMachine: TatVirtualMachine);
    procedure __GetCLSID_PropertiesUI(AMachine: TatVirtualMachine);
    procedure __GetCLSID_UserNotification(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CDBurn(AMachine: TatVirtualMachine);
    procedure __GetCLSID_TaskbarList(AMachine: TatVirtualMachine);
    procedure __GetCLSID_StartMenuPin(AMachine: TatVirtualMachine);
    procedure __GetCLSID_WebWizardHost(AMachine: TatVirtualMachine);
    procedure __GetCLSID_PublishDropTarget(AMachine: TatVirtualMachine);
    procedure __GetCLSID_PublishingWizard(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InternetPrintOrdering(AMachine: TatVirtualMachine);
    procedure __GetCLSID_FolderViewHost(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ExplorerBrowser(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ImageRecompress(AMachine: TatVirtualMachine);
    procedure __GetCLSID_TrayBandSiteService(AMachine: TatVirtualMachine);
    procedure __GetCLSID_TrayDeskBand(AMachine: TatVirtualMachine);
    procedure __GetCLSID_AttachmentServices(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DocPropShellExtension(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellItem(AMachine: TatVirtualMachine);
    procedure __GetCLSID_NamespaceWalker(AMachine: TatVirtualMachine);
    procedure __GetCLSID_FileOperation(AMachine: TatVirtualMachine);
    procedure __GetCLSID_FileOpenDialog(AMachine: TatVirtualMachine);
    procedure __GetCLSID_FileSaveDialog(AMachine: TatVirtualMachine);
    procedure __GetCLSID_KnownFolderManager(AMachine: TatVirtualMachine);
    procedure __GetCLSID_FSCopyHandler(AMachine: TatVirtualMachine);
    procedure __GetCLSID_SharingConfigurationManager(AMachine: TatVirtualMachine);
    procedure __GetCLSID_PreviousVersions(AMachine: TatVirtualMachine);
    procedure __GetCLSID_NetworkConnections(AMachine: TatVirtualMachine);
    procedure __GetCLSID_NamespaceTreeControl(AMachine: TatVirtualMachine);
    procedure __GetCLSID_IENamespaceTreeControl(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ScheduledTasks(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ApplicationAssociationRegistration(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ApplicationAssociationRegistrationUI(AMachine: TatVirtualMachine);
    procedure __GetCLSID_SearchFolderItemFactory(AMachine: TatVirtualMachine);
    procedure __GetCLSID_OpenControlPanel(AMachine: TatVirtualMachine);
    procedure __GetCLSID_MailRecipient(AMachine: TatVirtualMachine);
    procedure __GetCLSID_NetworkExplorerFolder(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DestinationList(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ApplicationDestinations(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ApplicationDocumentLists(AMachine: TatVirtualMachine);
    procedure __GetCLSID_HomeGroup(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellLibrary(AMachine: TatVirtualMachine);
    procedure __GetCLSID_AppStartupLink(AMachine: TatVirtualMachine);
    procedure __GetCLSID_EnumerableObjectCollection(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DesktopGadget(AMachine: TatVirtualMachine);
    procedure __GetIID_IExtractIconA(AMachine: TatVirtualMachine);
    procedure __GetIID_IExtractIconW(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellIconOverlayIdentifier(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellIconOverlayManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellIconOverlay(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellExecuteHookA(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellExecuteHookW(AMachine: TatVirtualMachine);
    procedure __GetIID_IURLSearchHook(AMachine: TatVirtualMachine);
    procedure __GetIID_ISearchContext(AMachine: TatVirtualMachine);
    procedure __GetIID_IURLSearchHook2(AMachine: TatVirtualMachine);
    procedure __GetIID_INewShortcutHookA(AMachine: TatVirtualMachine);
    procedure __GetIID_INewShortcutHookW(AMachine: TatVirtualMachine);
    procedure __GetIID_ICopyHookA(AMachine: TatVirtualMachine);
    procedure __GetIID_ICopyHookW(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileViewerSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileViewerA(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileViewerW(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellDetails(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjMgr(AMachine: TatVirtualMachine);
    procedure __GetIID_ICurrentWorkingDirectory(AMachine: TatVirtualMachine);
    procedure __GetIID_IACList(AMachine: TatVirtualMachine);
    procedure __GetIID_IACList2(AMachine: TatVirtualMachine);
    procedure __GetIID_IProgressDialog(AMachine: TatVirtualMachine);
    procedure __GetIID_IDockingWindowSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IDockingWindowFrame(AMachine: TatVirtualMachine);
    procedure __GetIID_IThumbnailCapture(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumShellImageStore(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellImageStore(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellFolderBand(AMachine: TatVirtualMachine);
    procedure __GetIID_IDeskBarClient(AMachine: TatVirtualMachine);
    procedure __GetIID_IActiveDesktop(AMachine: TatVirtualMachine);
    procedure __GetIID_IActiveDesktopP(AMachine: TatVirtualMachine);
    procedure __GetIID_IADesktopP2(AMachine: TatVirtualMachine);
    procedure __GetIID_IColumnProvider(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellChangeNotify(AMachine: TatVirtualMachine);
    procedure __GetIID_IQueryInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IDefViewFrame(AMachine: TatVirtualMachine);
    procedure __GetIID_IDocViewSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IInitializeObject(AMachine: TatVirtualMachine);
    procedure __GetIID_IBanneredBar(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellFolderViewCB(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellFolderView(AMachine: TatVirtualMachine);
    procedure __GetIID_INamedPropertyBag(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumPrivacyRecords(AMachine: TatVirtualMachine);
    procedure __GetIID_IFolderViewOC(AMachine: TatVirtualMachine);
    procedure __GetIID_DShellFolderViewEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_DFConstraint(AMachine: TatVirtualMachine);
    procedure __GetIID_FolderItem(AMachine: TatVirtualMachine);
    procedure __GetIID_FolderItems(AMachine: TatVirtualMachine);
    procedure __GetIID_FolderItemVerb(AMachine: TatVirtualMachine);
    procedure __GetIID_FolderItemVerbs(AMachine: TatVirtualMachine);
    procedure __GetIID_Folder(AMachine: TatVirtualMachine);
    procedure __GetIID_Folder2(AMachine: TatVirtualMachine);
    procedure __GetIID_Folder3(AMachine: TatVirtualMachine);
    procedure __GetIID_FolderItem2(AMachine: TatVirtualMachine);
    procedure __GetIID_FolderItems2(AMachine: TatVirtualMachine);
    procedure __GetIID_FolderItems3(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellLinkDual(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellLinkDual2(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellFolderViewDual(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellFolderViewDual2(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellFolderViewDual3(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellDispatch(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellDispatch2(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellDispatch3(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellDispatch4(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellDispatch5(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileSearchBand(AMachine: TatVirtualMachine);
    procedure __GetIID_IWebWizardHost(AMachine: TatVirtualMachine);
    procedure __GetIID_INewWDEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IAutoComplete(AMachine: TatVirtualMachine);
    procedure __GetIID_IAutoComplete2(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumACString(AMachine: TatVirtualMachine);
    procedure __GetIID_IAsyncOperation(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellFolderViewOC(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellFolderItem(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellLinkObject(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellFolderView(AMachine: TatVirtualMachine);
    procedure __GetCLSID_Shell(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellDispatchInproc(AMachine: TatVirtualMachine);
    procedure __GetCLSID_FileSearchBand(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _SHITEMIDWrapper = class(TatRecordWrapper)
  private
    Fcb: Word;
  public
    constructor Create(ARecord: _SHITEMID);
    function ObjToRec: _SHITEMID;
  published
    property cb: Word read Fcb write Fcb;
  end;
  
  _ITEMIDLISTWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _ITEMIDLIST);
    function ObjToRec: _ITEMIDLIST;
  published
  end;
  
  _STRRETWrapper = class(TatRecordWrapper)
  private
    FuType: UINT;
    FuOffset: UINT;
  public
    constructor Create(ARecord: _STRRET);
    function ObjToRec: _STRRET;
  published
    property uType: UINT read FuType write FuType;
    property uOffset: UINT read FuOffset write FuOffset;
  end;
  
  _SHELLDETAILSWrapper = class(TatRecordWrapper)
  private
    Ffmt: Integer;
    FcxChar: Integer;
  public
    constructor Create(ARecord: _SHELLDETAILS);
    function ObjToRec: _SHELLDETAILS;
  published
    property fmt: Integer read Ffmt write Ffmt;
    property cxChar: Integer read FcxChar write FcxChar;
  end;
  
  _COMDLG_FILTERSPECWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _COMDLG_FILTERSPEC);
    function ObjToRec: _COMDLG_FILTERSPEC;
  published
  end;
  
  SHCOLUMNIDWrapper = class(TatRecordWrapper)
  private
    Ffmtid: TGUID;
    Fpid: DWORD;
  public
    constructor Create(ARecord: SHCOLUMNID);
    function ObjToRec: SHCOLUMNID;
  published
    property fmtid: TGUID read Ffmtid write Ffmtid;
    property pid: DWORD read Fpid write Fpid;
  end;
  
  tagMACHINE_IDWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagMACHINE_ID);
    function ObjToRec: tagMACHINE_ID;
  published
  end;
  
  tagDOMAIN_RELATIVE_OBJECTIDWrapper = class(TatRecordWrapper)
  private
    FguidVolume: TGUID;
    FguidObject: TGUID;
  public
    constructor Create(ARecord: tagDOMAIN_RELATIVE_OBJECTID);
    function ObjToRec: tagDOMAIN_RELATIVE_OBJECTID;
  published
    property guidVolume: TGUID read FguidVolume write FguidVolume;
    property guidObject: TGUID read FguidObject write FguidObject;
  end;
  
  _CMINVOKECOMMANDINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FfMask: DWORD;
    Fhwnd: HWND;
    FnShow: Integer;
    FdwHotKey: DWORD;
    FhIcon: THandle;
  public
    constructor Create(ARecord: _CMINVOKECOMMANDINFO);
    function ObjToRec: _CMINVOKECOMMANDINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property fMask: DWORD read FfMask write FfMask;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property nShow: Integer read FnShow write FnShow;
    property dwHotKey: DWORD read FdwHotKey write FdwHotKey;
    property hIcon: THandle read FhIcon write FhIcon;
  end;
  
  _CMINVOKECOMMANDINFOEXWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FfMask: DWORD;
    Fhwnd: HWND;
    FnShow: Integer;
    FdwHotKey: DWORD;
    FhIcon: THandle;
  public
    constructor Create(ARecord: _CMINVOKECOMMANDINFOEX);
    function ObjToRec: _CMINVOKECOMMANDINFOEX;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property fMask: DWORD read FfMask write FfMask;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property nShow: Integer read FnShow write FnShow;
    property dwHotKey: DWORD read FdwHotKey write FdwHotKey;
    property hIcon: THandle read FhIcon write FhIcon;
  end;
  
  _PERSIST_FOLDER_TARGET_INFOWrapper = class(TatRecordWrapper)
  private
    FdwAttributes: DWORD;
    Fcsidl: Integer;
  public
    constructor Create(ARecord: _PERSIST_FOLDER_TARGET_INFO);
    function ObjToRec: _PERSIST_FOLDER_TARGET_INFO;
  published
    property dwAttributes: DWORD read FdwAttributes write FdwAttributes;
    property csidl: Integer read Fcsidl write Fcsidl;
  end;
  
  EXTRASEARCHWrapper = class(TatRecordWrapper)
  private
    FguidSearch: TGUID;
  public
    constructor Create(ARecord: EXTRASEARCH);
    function ObjToRec: EXTRASEARCH;
  published
    property guidSearch: TGUID read FguidSearch write FguidSearch;
  end;
  
  FOLDERSETTINGSWrapper = class(TatRecordWrapper)
  private
    FViewMode: UINT;
    FfFlags: UINT;
  public
    constructor Create(ARecord: FOLDERSETTINGS);
    function ObjToRec: FOLDERSETTINGS;
  published
    property ViewMode: UINT read FViewMode write FViewMode;
    property fFlags: UINT read FfFlags write FfFlags;
  end;
  
  _SV2CVW2_PARAMSWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FhwndView: HWND;
  public
    constructor Create(ARecord: _SV2CVW2_PARAMS);
    function ObjToRec: _SV2CVW2_PARAMS;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property hwndView: HWND read FhwndView write FhwndView;
  end;
  
  SORTCOLUMNWrapper = class(TatRecordWrapper)
  private
    Fdirection: TSortDirection;
  public
    constructor Create(ARecord: SORTCOLUMN);
    function ObjToRec: SORTCOLUMN;
  published
    property direction: TSortDirection read Fdirection write Fdirection;
  end;
  
  CM_COLUMNINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwMask: DWORD;
    FdwState: DWORD;
    FuWidth: UINT;
    FuDefaultWidth: UINT;
    FuIdealWidth: UINT;
  public
    constructor Create(ARecord: CM_COLUMNINFO);
    function ObjToRec: CM_COLUMNINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwMask: DWORD read FdwMask write FdwMask;
    property dwState: DWORD read FdwState write FdwState;
    property uWidth: UINT read FuWidth write FuWidth;
    property uDefaultWidth: UINT read FuDefaultWidth write FuDefaultWidth;
    property uIdealWidth: UINT read FuIdealWidth write FuIdealWidth;
  end;
  
  SHELL_ITEM_RESOURCEWrapper = class(TatRecordWrapper)
  private
    FguidType: TGUID;
  public
    constructor Create(ARecord: SHELL_ITEM_RESOURCE);
    function ObjToRec: SHELL_ITEM_RESOURCE;
  published
    property guidType: TGUID read FguidType write FguidType;
  end;
  
  CATEGORY_INFOWrapper = class(TatRecordWrapper)
  private
    Fcif: Integer;
  public
    constructor Create(ARecord: CATEGORY_INFO);
    function ObjToRec: CATEGORY_INFO;
  published
    property cif: Integer read Fcif write Fcif;
  end;
  
  SHDRAGIMAGEWrapper = class(TatRecordWrapper)
  private
    FhbmpDragImage: HBITMAP;
    FcrColorKey: COLORREF;
  public
    constructor Create(ARecord: SHDRAGIMAGE);
    function ObjToRec: SHDRAGIMAGE;
  published
    property hbmpDragImage: HBITMAP read FhbmpDragImage write FhbmpDragImage;
    property crColorKey: COLORREF read FcrColorKey write FcrColorKey;
  end;
  
  DESKBANDINFOWrapper = class(TatRecordWrapper)
  private
    FdwMask: DWORD;
    FdwModeFlags: DWORD;
    FcrBkgnd: TCOLORREF;
  public
    constructor Create(ARecord: DESKBANDINFO);
    function ObjToRec: DESKBANDINFO;
  published
    property dwMask: DWORD read FdwMask write FdwMask;
    property dwModeFlags: DWORD read FdwModeFlags write FdwModeFlags;
    property crBkgnd: TCOLORREF read FcrBkgnd write FcrBkgnd;
  end;
  
  THUMBBUTTONWrapper = class(TatRecordWrapper)
  private
    FdwMask: DWORD;
    FiId: UINT;
    FiBitmap: UINT;
    FhIcon: HICON;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: THUMBBUTTON);
    function ObjToRec: THUMBBUTTON;
  published
    property dwMask: DWORD read FdwMask write FdwMask;
    property iId: UINT read FiId write FiId;
    property iBitmap: UINT read FiBitmap write FiBitmap;
    property hIcon: HICON read FhIcon write FhIcon;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagBANDSITEINFOWrapper = class(TatRecordWrapper)
  private
    FdwMask: DWORD;
    FdwState: DWORD;
    FdwStyle: DWORD;
  public
    constructor Create(ARecord: tagBANDSITEINFO);
    function ObjToRec: tagBANDSITEINFO;
  published
    property dwMask: DWORD read FdwMask write FdwMask;
    property dwState: DWORD read FdwState write FdwState;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
  end;
  
  DELEGATEITEMIDWrapper = class(TatRecordWrapper)
  private
    FcbSize: Word;
    FwOuter: Word;
    FcbInner: Word;
  public
    constructor Create(ARecord: DELEGATEITEMID);
    function ObjToRec: DELEGATEITEMID;
  published
    property cbSize: Word read FcbSize write FcbSize;
    property wOuter: Word read FwOuter write FwOuter;
    property cbInner: Word read FcbInner write FcbInner;
  end;
  
  tagSMDATAWrapper = class(TatRecordWrapper)
  private
    FdwMask: DWORD;
    FdwFlags: DWORD;
    Fhmenu: HMENU;
    Fhwnd: HWND;
    FuId: UINT;
    FuIdParent: UINT;
    FuIdAncestor: UINT;
    Fpunk: IUnknown;
  public
    constructor Create(ARecord: tagSMDATA);
    function ObjToRec: tagSMDATA;
  published
    property dwMask: DWORD read FdwMask write FdwMask;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property hmenu: HMENU read Fhmenu write Fhmenu;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property uId: UINT read FuId write FuId;
    property uIdParent: UINT read FuIdParent write FuIdParent;
    property uIdAncestor: UINT read FuIdAncestor write FuIdAncestor;
    property punk: IUnknown read Fpunk write Fpunk;
  end;
  
  tagSMINFOWrapper = class(TatRecordWrapper)
  private
    FdwMask: DWORD;
    FdwType: DWORD;
    FdwFlags: DWORD;
    FiIcon: Integer;
  public
    constructor Create(ARecord: tagSMINFO);
    function ObjToRec: tagSMINFO;
  published
    property dwMask: DWORD read FdwMask write FdwMask;
    property dwType: DWORD read FdwType write FdwType;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property iIcon: Integer read FiIcon write FiIcon;
  end;
  
  SHCSCHANGENOTIFYSTRUCTWrapper = class(TatRecordWrapper)
  private
    FlEvent: Integer;
  public
    constructor Create(ARecord: SHCSCHANGENOTIFYSTRUCT);
    function ObjToRec: SHCSCHANGENOTIFYSTRUCT;
  published
    property lEvent: Integer read FlEvent write FlEvent;
  end;
  
  KNOWNFOLDER_DEFINITIONWrapper = class(TatRecordWrapper)
  private
    Fcategory: TKFCategory;
    FfidParent: TKnownFolderID;
    FdwAttributes: DWORD;
    FkfdFlags: TKFDefinitionFlags;
    FftidType: TFolderTypeID;
  public
    constructor Create(ARecord: KNOWNFOLDER_DEFINITION);
    function ObjToRec: KNOWNFOLDER_DEFINITION;
  published
    property category: TKFCategory read Fcategory write Fcategory;
    property fidParent: TKnownFolderID read FfidParent write FfidParent;
    property dwAttributes: DWORD read FdwAttributes write FdwAttributes;
    property kfdFlags: TKFDefinitionFlags read FkfdFlags write FkfdFlags;
    property ftidType: TFolderTypeID read FftidType write FftidType;
  end;
  
  NSTCCUSTOMDRAWWrapper = class(TatRecordWrapper)
  private
    FuItemState: UINT;
    Fnstcis: NSTCITEMSTATE;
    FiImage: Integer;
    Fhiml: HIMAGELIST;
    FiLevel: Integer;
    FiIndent: Integer;
  public
    constructor Create(ARecord: NSTCCUSTOMDRAW);
    function ObjToRec: NSTCCUSTOMDRAW;
  published
    property uItemState: UINT read FuItemState write FuItemState;
    property nstcis: NSTCITEMSTATE read Fnstcis write Fnstcis;
    property iImage: Integer read FiImage write FiImage;
    property himl: HIMAGELIST read Fhiml write Fhiml;
    property iLevel: Integer read FiLevel write FiLevel;
    property iIndent: Integer read FiIndent write FiIndent;
  end;
  
  __MIDL_IPreviewHandlerFrame_0001Wrapper = class(TatRecordWrapper)
  private
    Fhaccel: HACCEL;
    FcAccelEntries: UINT;
  public
    constructor Create(ARecord: __MIDL_IPreviewHandlerFrame_0001);
    function ObjToRec: __MIDL_IPreviewHandlerFrame_0001;
  published
    property haccel: HACCEL read Fhaccel write Fhaccel;
    property cAccelEntries: UINT read FcAccelEntries write FcAccelEntries;
  end;
  
  tagDATABLOCKHEADERWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwSignature: DWORD;
  public
    constructor Create(ARecord: tagDATABLOCKHEADER);
    function ObjToRec: tagDATABLOCKHEADER;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwSignature: DWORD read FdwSignature write FdwSignature;
  end;
  
  tagNT_CONSOLE_PROPSWrapper = class(TatRecordWrapper)
  private
    FwFillAttribute: Word;
    FwPopupFillAttribute: Word;
    FnFont: DWORD;
    FnInputBufferSize: DWORD;
    FuFontFamily: UINT;
    FuFontWeight: UINT;
    FuCursorSize: UINT;
    FbFullScreen: BOOL;
    FbQuickEdit: BOOL;
    FbInsertMode: BOOL;
    FbAutoPosition: BOOL;
    FuHistoryBufferSize: UINT;
    FuNumberOfHistoryBuffers: UINT;
    FbHistoryNoDup: BOOL;
  public
    constructor Create(ARecord: tagNT_CONSOLE_PROPS);
    function ObjToRec: tagNT_CONSOLE_PROPS;
  published
    property wFillAttribute: Word read FwFillAttribute write FwFillAttribute;
    property wPopupFillAttribute: Word read FwPopupFillAttribute write FwPopupFillAttribute;
    property nFont: DWORD read FnFont write FnFont;
    property nInputBufferSize: DWORD read FnInputBufferSize write FnInputBufferSize;
    property uFontFamily: UINT read FuFontFamily write FuFontFamily;
    property uFontWeight: UINT read FuFontWeight write FuFontWeight;
    property uCursorSize: UINT read FuCursorSize write FuCursorSize;
    property bFullScreen: BOOL read FbFullScreen write FbFullScreen;
    property bQuickEdit: BOOL read FbQuickEdit write FbQuickEdit;
    property bInsertMode: BOOL read FbInsertMode write FbInsertMode;
    property bAutoPosition: BOOL read FbAutoPosition write FbAutoPosition;
    property uHistoryBufferSize: UINT read FuHistoryBufferSize write FuHistoryBufferSize;
    property uNumberOfHistoryBuffers: UINT read FuNumberOfHistoryBuffers write FuNumberOfHistoryBuffers;
    property bHistoryNoDup: BOOL read FbHistoryNoDup write FbHistoryNoDup;
  end;
  
  tagNT_FE_CONSOLE_PROPSWrapper = class(TatRecordWrapper)
  private
    FuCodePage: UINT;
  public
    constructor Create(ARecord: tagNT_FE_CONSOLE_PROPS);
    function ObjToRec: tagNT_FE_CONSOLE_PROPS;
  published
    property uCodePage: UINT read FuCodePage write FuCodePage;
  end;
  
  tagEXP_DARWIN_LINKWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagEXP_DARWIN_LINK);
    function ObjToRec: tagEXP_DARWIN_LINK;
  published
  end;
  
  tagEXP_SPECIAL_FOLDERWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwSignature: DWORD;
    FidSpecialFolder: DWORD;
    FcbOffset: DWORD;
  public
    constructor Create(ARecord: tagEXP_SPECIAL_FOLDER);
    function ObjToRec: tagEXP_SPECIAL_FOLDER;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwSignature: DWORD read FdwSignature write FdwSignature;
    property idSpecialFolder: DWORD read FidSpecialFolder write FidSpecialFolder;
    property cbOffset: DWORD read FcbOffset write FcbOffset;
  end;
  
  tagEXP_SZ_LINKWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwSignature: DWORD;
  public
    constructor Create(ARecord: tagEXP_SZ_LINK);
    function ObjToRec: tagEXP_SZ_LINK;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwSignature: DWORD read FdwSignature write FdwSignature;
  end;
  
  tagEXP_PROPERTYSTORAGEWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwSignature: DWORD;
  public
    constructor Create(ARecord: tagEXP_PROPERTYSTORAGE);
    function ObjToRec: tagEXP_PROPERTYSTORAGE;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwSignature: DWORD read FdwSignature write FdwSignature;
  end;
  
  tagFVSHOWINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FhwndOwner: HWND;
    FiShow: Integer;
    FdwFlags: DWORD;
    FpunkRel: IUNKNOWN;
  public
    constructor Create(ARecord: tagFVSHOWINFO);
    function ObjToRec: tagFVSHOWINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property iShow: Integer read FiShow write FiShow;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property punkRel: IUNKNOWN read FpunkRel write FpunkRel;
  end;
  
  _browseinfoAWrapper = class(TatRecordWrapper)
  private
    FhwndOwner: HWND;
    FulFlags: UINT;
    FlParam: LPARAM;
    FiImage: Integer;
  public
    constructor Create(ARecord: _browseinfoA);
    function ObjToRec: _browseinfoA;
  published
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property ulFlags: UINT read FulFlags write FulFlags;
    property lParam: LPARAM read FlParam write FlParam;
    property iImage: Integer read FiImage write FiImage;
  end;
  
  _browseinfoWWrapper = class(TatRecordWrapper)
  private
    FhwndOwner: HWND;
    FulFlags: UINT;
    FlParam: LPARAM;
    FiImage: Integer;
  public
    constructor Create(ARecord: _browseinfoW);
    function ObjToRec: _browseinfoW;
  published
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property ulFlags: UINT read FulFlags write FulFlags;
    property lParam: LPARAM read FlParam write FlParam;
    property iImage: Integer read FiImage write FiImage;
  end;
  
  _EnumImageStoreDATAtagWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _EnumImageStoreDATAtag);
    function ObjToRec: _EnumImageStoreDATAtag;
  published
  end;
  
  tagBANDINFOSFBWrapper = class(TatRecordWrapper)
  private
    FdwMask: DWORD;
    FdwStateMask: DWORD;
    FdwState: DWORD;
    FcrBkgnd: COLORREF;
    FcrBtnLt: COLORREF;
    FcrBtnDk: COLORREF;
    FwViewMode: Word;
    FwAlign: Word;
  public
    constructor Create(ARecord: tagBANDINFOSFB);
    function ObjToRec: tagBANDINFOSFB;
  published
    property dwMask: DWORD read FdwMask write FdwMask;
    property dwStateMask: DWORD read FdwStateMask write FdwStateMask;
    property dwState: DWORD read FdwState write FdwState;
    property crBkgnd: COLORREF read FcrBkgnd write FcrBkgnd;
    property crBtnLt: COLORREF read FcrBtnLt write FcrBtnLt;
    property crBtnDk: COLORREF read FcrBtnDk write FcrBtnDk;
    property wViewMode: Word read FwViewMode write FwViewMode;
    property wAlign: Word read FwAlign write FwAlign;
  end;
  
  _tagWALLPAPEROPTWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FdwStyle: DWORD;
  public
    constructor Create(ARecord: _tagWALLPAPEROPT);
    function ObjToRec: _tagWALLPAPEROPT;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
  end;
  
  _tagCOMPONENTSOPTWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FfEnableComponents: BOOL;
    FfActiveDesktop: BOOL;
  public
    constructor Create(ARecord: _tagCOMPONENTSOPT);
    function ObjToRec: _tagCOMPONENTSOPT;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property fEnableComponents: BOOL read FfEnableComponents write FfEnableComponents;
    property fActiveDesktop: BOOL read FfActiveDesktop write FfActiveDesktop;
  end;
  
  _tagCOMPPOSWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FiLeft: Integer;
    FiTop: Integer;
    FdwWidth: DWORD;
    FdwHeight: DWORD;
    FizIndex: Integer;
    FfCanResize: BOOL;
    FfCanResizeX: BOOL;
    FfCanResizeY: BOOL;
    FiPreferredLeftPercent: Integer;
    FiPreferredTopPercent: Integer;
  public
    constructor Create(ARecord: _tagCOMPPOS);
    function ObjToRec: _tagCOMPPOS;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property iLeft: Integer read FiLeft write FiLeft;
    property iTop: Integer read FiTop write FiTop;
    property dwWidth: DWORD read FdwWidth write FdwWidth;
    property dwHeight: DWORD read FdwHeight write FdwHeight;
    property izIndex: Integer read FizIndex write FizIndex;
    property fCanResize: BOOL read FfCanResize write FfCanResize;
    property fCanResizeX: BOOL read FfCanResizeX write FfCanResizeX;
    property fCanResizeY: BOOL read FfCanResizeY write FfCanResizeY;
    property iPreferredLeftPercent: Integer read FiPreferredLeftPercent write FiPreferredLeftPercent;
    property iPreferredTopPercent: Integer read FiPreferredTopPercent write FiPreferredTopPercent;
  end;
  
  _tagCOMPSTATEINFOWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FiLeft: Integer;
    FiTop: Integer;
    FdwWidth: DWORD;
    FdwHeight: DWORD;
    FdwItemState: DWORD;
  public
    constructor Create(ARecord: _tagCOMPSTATEINFO);
    function ObjToRec: _tagCOMPSTATEINFO;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property iLeft: Integer read FiLeft write FiLeft;
    property iTop: Integer read FiTop write FiTop;
    property dwWidth: DWORD read FdwWidth write FdwWidth;
    property dwHeight: DWORD read FdwHeight write FdwHeight;
    property dwItemState: DWORD read FdwItemState write FdwItemState;
  end;
  
  _tagIE4COMPONENTWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FdwID: DWORD;
    FiComponentType: Integer;
    FfChecked: BOOL;
    FfDirty: BOOL;
    FfNoScroll: BOOL;
  public
    constructor Create(ARecord: _tagIE4COMPONENT);
    function ObjToRec: _tagIE4COMPONENT;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property dwID: DWORD read FdwID write FdwID;
    property iComponentType: Integer read FiComponentType write FiComponentType;
    property fChecked: BOOL read FfChecked write FfChecked;
    property fDirty: BOOL read FfDirty write FfDirty;
    property fNoScroll: BOOL read FfNoScroll write FfNoScroll;
  end;
  
  _tagCOMPONENTWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FdwID: DWORD;
    FiComponentType: Integer;
    FfChecked: BOOL;
    FfDirty: BOOL;
    FfNoScroll: BOOL;
    FdwCurItemState: DWORD;
  public
    constructor Create(ARecord: _tagCOMPONENT);
    function ObjToRec: _tagCOMPONENT;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property dwID: DWORD read FdwID write FdwID;
    property iComponentType: Integer read FiComponentType write FiComponentType;
    property fChecked: BOOL read FfChecked write FfChecked;
    property fDirty: BOOL read FfDirty write FfDirty;
    property fNoScroll: BOOL read FfNoScroll write FfNoScroll;
    property dwCurItemState: DWORD read FdwCurItemState write FdwCurItemState;
  end;
  
  tagSHCOLUMNINFOWrapper = class(TatRecordWrapper)
  private
    Fvt: TVarType;
    Ffmt: DWORD;
    FcChars: UINT;
    FcsFlags: DWORD;
  public
    constructor Create(ARecord: tagSHCOLUMNINFO);
    function ObjToRec: tagSHCOLUMNINFO;
  published
    property vt: TVarType read Fvt write Fvt;
    property fmt: DWORD read Ffmt write Ffmt;
    property cChars: UINT read FcChars write FcChars;
    property csFlags: DWORD read FcsFlags write FcsFlags;
  end;
  
  tagSHCOLUMNINITWrapper = class(TatRecordWrapper)
  private
    FdwFlags: Cardinal;
    FdwReserved: Cardinal;
  public
    constructor Create(ARecord: tagSHCOLUMNINIT);
    function ObjToRec: tagSHCOLUMNINIT;
  published
    property dwFlags: Cardinal read FdwFlags write FdwFlags;
    property dwReserved: Cardinal read FdwReserved write FdwReserved;
  end;
  
  tagSHCOLUMNDATAWrapper = class(TatRecordWrapper)
  private
    FdwFlags: Cardinal;
    FdwFileAttributes: DWORD;
    FdwReserved: Cardinal;
  public
    constructor Create(ARecord: tagSHCOLUMNDATA);
    function ObjToRec: tagSHCOLUMNDATA;
  published
    property dwFlags: Cardinal read FdwFlags write FdwFlags;
    property dwFileAttributes: DWORD read FdwFileAttributes write FdwFileAttributes;
    property dwReserved: Cardinal read FdwReserved write FdwReserved;
  end;
  
  _NRESARRAYWrapper = class(TatRecordWrapper)
  private
    FcItems: UINT;
  public
    constructor Create(ARecord: _NRESARRAY);
    function ObjToRec: _NRESARRAY;
  published
    property cItems: UINT read FcItems write FcItems;
  end;
  
  _IDAWrapper = class(TatRecordWrapper)
  private
    Fcidl: UINT;
  public
    constructor Create(ARecord: _IDA);
    function ObjToRec: _IDA;
  published
    property cidl: UINT read Fcidl write Fcidl;
  end;
  
  _FILEDESCRIPTORAWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    Fclsid: TCLSID;
    FdwFileAttributes: DWORD;
    FnFileSizeHigh: DWORD;
    FnFileSizeLow: DWORD;
  public
    constructor Create(ARecord: _FILEDESCRIPTORA);
    function ObjToRec: _FILEDESCRIPTORA;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property clsid: TCLSID read Fclsid write Fclsid;
    property dwFileAttributes: DWORD read FdwFileAttributes write FdwFileAttributes;
    property nFileSizeHigh: DWORD read FnFileSizeHigh write FnFileSizeHigh;
    property nFileSizeLow: DWORD read FnFileSizeLow write FnFileSizeLow;
  end;
  
  _FILEDESCRIPTORWWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    Fclsid: TCLSID;
    FdwFileAttributes: DWORD;
    FnFileSizeHigh: DWORD;
    FnFileSizeLow: DWORD;
  public
    constructor Create(ARecord: _FILEDESCRIPTORW);
    function ObjToRec: _FILEDESCRIPTORW;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property clsid: TCLSID read Fclsid write Fclsid;
    property dwFileAttributes: DWORD read FdwFileAttributes write FdwFileAttributes;
    property nFileSizeHigh: DWORD read FnFileSizeHigh write FnFileSizeHigh;
    property nFileSizeLow: DWORD read FnFileSizeLow write FnFileSizeLow;
  end;
  
  _FILEGROUPDESCRIPTORAWrapper = class(TatRecordWrapper)
  private
    FcItems: UINT;
  public
    constructor Create(ARecord: _FILEGROUPDESCRIPTORA);
    function ObjToRec: _FILEGROUPDESCRIPTORA;
  published
    property cItems: UINT read FcItems write FcItems;
  end;
  
  _FILEGROUPDESCRIPTORWWrapper = class(TatRecordWrapper)
  private
    FcItems: UINT;
  public
    constructor Create(ARecord: _FILEGROUPDESCRIPTORW);
    function ObjToRec: _FILEGROUPDESCRIPTORW;
  published
    property cItems: UINT read FcItems write FcItems;
  end;
  
  _DROPFILESWrapper = class(TatRecordWrapper)
  private
    FpFiles: DWORD;
    FfNC: BOOL;
    FfWide: BOOL;
  public
    constructor Create(ARecord: _DROPFILES);
    function ObjToRec: _DROPFILES;
  published
    property pFiles: DWORD read FpFiles write FpFiles;
    property fNC: BOOL read FfNC write FfNC;
    property fWide: BOOL read FfWide write FfWide;
  end;
  
  tagFILE_ATTRIBUTES_ARRAYWrapper = class(TatRecordWrapper)
  private
    FcItems: UINT;
    FdwSumFileAttributes: DWORD;
    FdwProductFileAttributes: DWORD;
  public
    constructor Create(ARecord: tagFILE_ATTRIBUTES_ARRAY);
    function ObjToRec: tagFILE_ATTRIBUTES_ARRAY;
  published
    property cItems: UINT read FcItems write FcItems;
    property dwSumFileAttributes: DWORD read FdwSumFileAttributes write FdwSumFileAttributes;
    property dwProductFileAttributes: DWORD read FdwProductFileAttributes write FdwProductFileAttributes;
  end;
  
  _SHChangeNotifyEntryWrapper = class(TatRecordWrapper)
  private
    FfRecursive: BOOL;
  public
    constructor Create(ARecord: _SHChangeNotifyEntry);
    function ObjToRec: _SHChangeNotifyEntry;
  published
    property fRecursive: BOOL read FfRecursive write FfRecursive;
  end;
  
  SHARDAPPIDINFOWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: SHARDAPPIDINFO);
    function ObjToRec: SHARDAPPIDINFO;
  published
  end;
  
  SHARDAPPIDINFOIDLISTWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: SHARDAPPIDINFOIDLIST);
    function ObjToRec: SHARDAPPIDINFOIDLIST;
  published
  end;
  
  SHARDAPPIDINFOLINKWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: SHARDAPPIDINFOLINK);
    function ObjToRec: SHARDAPPIDINFOLINK;
  published
  end;
  
  _SHChangeDWORDAsIDListWrapper = class(TatRecordWrapper)
  private
    Fcb: SHORT;
    FdwItem1: DWORD;
    FdwItem2: DWORD;
    FcbZero: SHORT;
  public
    constructor Create(ARecord: _SHChangeDWORDAsIDList);
    function ObjToRec: _SHChangeDWORDAsIDList;
  published
    property cb: SHORT read Fcb write Fcb;
    property dwItem1: DWORD read FdwItem1 write FdwItem1;
    property dwItem2: DWORD read FdwItem2 write FdwItem2;
    property cbZero: SHORT read FcbZero write FcbZero;
  end;
  
  _SHChangeUpdateImageIDListWrapper = class(TatRecordWrapper)
  private
    Fcb: SHORT;
    FiIconIndex: Integer;
    FiCurIndex: Integer;
    FuFlags: UINT;
    FdwProcessID: DWORD;
    FcbZero: SHORT;
  public
    constructor Create(ARecord: _SHChangeUpdateImageIDList);
    function ObjToRec: _SHChangeUpdateImageIDList;
  published
    property cb: SHORT read Fcb write Fcb;
    property iIconIndex: Integer read FiIconIndex write FiIconIndex;
    property iCurIndex: Integer read FiCurIndex write FiCurIndex;
    property uFlags: UINT read FuFlags write FuFlags;
    property dwProcessID: DWORD read FdwProcessID write FdwProcessID;
    property cbZero: SHORT read FcbZero write FcbZero;
  end;
  
  _SHChangeProductKeyAsIDListWrapper = class(TatRecordWrapper)
  private
    Fcb: SHORT;
    FcbZero: SHORT;
  public
    constructor Create(ARecord: _SHChangeProductKeyAsIDList);
    function ObjToRec: _SHChangeProductKeyAsIDList;
  published
    property cb: SHORT read Fcb write Fcb;
    property cbZero: SHORT read FcbZero write FcbZero;
  end;
  
  _SHDESCRIPTIONIDWrapper = class(TatRecordWrapper)
  private
    FdwDescriptionId: DWORD;
    FId: TCLSID;
  public
    constructor Create(ARecord: _SHDESCRIPTIONID);
    function ObjToRec: _SHDESCRIPTIONID;
  published
    property dwDescriptionId: DWORD read FdwDescriptionId write FdwDescriptionId;
    property Id: TCLSID read FId write FId;
  end;
  
  tagAUTO_SCROLL_DATAWrapper = class(TatRecordWrapper)
  private
    FiNextSample: Integer;
    FdwLastScroll: DWORD;
    FbFull: BOOL;
  public
    constructor Create(ARecord: tagAUTO_SCROLL_DATA);
    function ObjToRec: tagAUTO_SCROLL_DATA;
  published
    property iNextSample: Integer read FiNextSample write FiNextSample;
    property dwLastScroll: DWORD read FdwLastScroll write FdwLastScroll;
    property bFull: BOOL read FbFull write FbFull;
  end;
  
  tagCABINETSTATEWrapper = class(TatRecordWrapper)
  private
    FcLength: Word;
    FnVersion: Word;
    FfUnusedFlags: Word;
    FfMenuEnumFilter: UINT;
  public
    constructor Create(ARecord: tagCABINETSTATE);
    function ObjToRec: tagCABINETSTATE;
  published
    property cLength: Word read FcLength write FcLength;
    property nVersion: Word read FnVersion write FnVersion;
    property fUnusedFlags: Word read FfUnusedFlags write FfUnusedFlags;
    property fMenuEnumFilter: UINT read FfMenuEnumFilter write FfMenuEnumFilter;
  end;
  
  _openasinfoWrapper = class(TatRecordWrapper)
  private
    FoaifInFlags: TOpenAsInfoFlags;
  public
    constructor Create(ARecord: _openasinfo);
    function ObjToRec: _openasinfo;
  published
    property oaifInFlags: TOpenAsInfoFlags read FoaifInFlags write FoaifInFlags;
  end;
  
  PROPPRGWrapper = class(TatRecordWrapper)
  private
    FflPrg: Word;
    FflPrgInit: Word;
    FwHotKey: Word;
    FwIconIndex: Word;
    FdwEnhModeFlags: DWORD;
    FdwRealModeFlags: DWORD;
  public
    constructor Create(ARecord: PROPPRG);
    function ObjToRec: PROPPRG;
  published
    property flPrg: Word read FflPrg write FflPrg;
    property flPrgInit: Word read FflPrgInit write FflPrgInit;
    property wHotKey: Word read FwHotKey write FwHotKey;
    property wIconIndex: Word read FwIconIndex write FwIconIndex;
    property dwEnhModeFlags: DWORD read FdwEnhModeFlags write FdwEnhModeFlags;
    property dwRealModeFlags: DWORD read FdwRealModeFlags write FdwRealModeFlags;
  end;
  
  _QCMINFO_IDMAP_PLACEMENTWrapper = class(TatRecordWrapper)
  private
    Fid: UINT;
    FfFlags: UINT;
  public
    constructor Create(ARecord: _QCMINFO_IDMAP_PLACEMENT);
    function ObjToRec: _QCMINFO_IDMAP_PLACEMENT;
  published
    property id: UINT read Fid write Fid;
    property fFlags: UINT read FfFlags write FfFlags;
  end;
  
  _QCMINFO_IDMAPWrapper = class(TatRecordWrapper)
  private
    FnMaxIds: UINT;
  public
    constructor Create(ARecord: _QCMINFO_IDMAP);
    function ObjToRec: _QCMINFO_IDMAP;
  published
    property nMaxIds: UINT read FnMaxIds write FnMaxIds;
  end;
  
  _QCMINFOWrapper = class(TatRecordWrapper)
  private
    Fhmenu: HMENU;
    FindexMenu: UINT;
    FidCmdFirst: UINT;
    FidCmdLast: UINT;
  public
    constructor Create(ARecord: _QCMINFO);
    function ObjToRec: _QCMINFO;
  published
    property hmenu: HMENU read Fhmenu write Fhmenu;
    property indexMenu: UINT read FindexMenu write FindexMenu;
    property idCmdFirst: UINT read FidCmdFirst write FidCmdFirst;
    property idCmdLast: UINT read FidCmdLast write FidCmdLast;
  end;
  
  _TBINFOWrapper = class(TatRecordWrapper)
  private
    Fcbuttons: UINT;
    FuFlags: UINT;
  public
    constructor Create(ARecord: _TBINFO);
    function ObjToRec: _TBINFO;
  published
    property cbuttons: UINT read Fcbuttons write Fcbuttons;
    property uFlags: UINT read FuFlags write FuFlags;
  end;
  
  _DETAILSINFOWrapper = class(TatRecordWrapper)
  private
    Ffmt: Integer;
    FcxChar: Integer;
    FiImage: Integer;
  public
    constructor Create(ARecord: _DETAILSINFO);
    function ObjToRec: _DETAILSINFO;
  published
    property fmt: Integer read Ffmt write Ffmt;
    property cxChar: Integer read FcxChar write FcxChar;
    property iImage: Integer read FiImage write FiImage;
  end;
  
  _SFVM_PROPPAGE_DATAWrapper = class(TatRecordWrapper)
  private
    FdwReserved: DWORD;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: _SFVM_PROPPAGE_DATA);
    function ObjToRec: _SFVM_PROPPAGE_DATA;
  published
    property dwReserved: DWORD read FdwReserved write FdwReserved;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  _SFVM_HELPTOPIC_DATAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _SFVM_HELPTOPIC_DATA);
    function ObjToRec: _SFVM_HELPTOPIC_DATA;
  published
  end;
  
  _ITEMSPACINGWrapper = class(TatRecordWrapper)
  private
    FcxSmall: Integer;
    FcySmall: Integer;
    FcxLarge: Integer;
    FcyLarge: Integer;
  public
    constructor Create(ARecord: _ITEMSPACING);
    function ObjToRec: _ITEMSPACING;
  published
    property cxSmall: Integer read FcxSmall write FcxSmall;
    property cySmall: Integer read FcySmall write FcySmall;
    property cxLarge: Integer read FcxLarge write FcxLarge;
    property cyLarge: Integer read FcyLarge write FcyLarge;
  end;
  
  _SFV_CREATEWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
  public
    constructor Create(ARecord: _SFV_CREATE);
    function ObjToRec: _SFV_CREATE;
  published
    property cbSize: UINT read FcbSize write FcbSize;
  end;
  
  tagDEFCONTEXTMENUWrapper = class(TatRecordWrapper)
  private
    Fhwnd: HWND;
    Fcidl: UINT;
    FpunkAssociationInfo: IUnknown;
    FcKeys: UINT;
  public
    constructor Create(ARecord: tagDEFCONTEXTMENU);
    function ObjToRec: tagDEFCONTEXTMENU;
  published
    property hwnd: HWND read Fhwnd write Fhwnd;
    property cidl: UINT read Fcidl write Fcidl;
    property punkAssociationInfo: IUnknown read FpunkAssociationInfo write FpunkAssociationInfo;
    property cKeys: UINT read FcKeys write FcKeys;
  end;
  
  tagDFMICSWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FfMask: DWORD;
    FlParam: LPARAM;
    FidCmdFirst: UINT;
    FidDefMax: UINT;
    FpunkSite: IUnknown;
  public
    constructor Create(ARecord: tagDFMICS);
    function ObjToRec: tagDFMICS;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property fMask: DWORD read FfMask write FfMask;
    property lParam: LPARAM read FlParam write FlParam;
    property idCmdFirst: UINT read FidCmdFirst write FidCmdFirst;
    property idDefMax: UINT read FidDefMax write FidDefMax;
    property punkSite: IUnknown read FpunkSite write FpunkSite;
  end;
  
  _CSFVWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FlEvents: Integer;
    Ffvm: Integer;
  public
    constructor Create(ARecord: _CSFV);
    function ObjToRec: _CSFV;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property lEvents: Integer read FlEvents write FlEvents;
    property fvm: Integer read Ffvm write Ffvm;
  end;
  
  _SFV_SETITEMPOSWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _SFV_SETITEMPOS);
    function ObjToRec: _SFV_SETITEMPOS;
  published
  end;
  
  tagSHELLSTATEWWrapper = class(TatRecordWrapper)
  private
    FData: DWORD;
    FData2: UINT;
    FlParamSort: Integer;
    FiSortDirection: Integer;
    Fversion: UINT;
    FuNotUsed: UINT;
  public
    constructor Create(ARecord: tagSHELLSTATEW);
    function ObjToRec: tagSHELLSTATEW;
  published
    property Data: DWORD read FData write FData;
    property Data2: UINT read FData2 write FData2;
    property lParamSort: Integer read FlParamSort write FlParamSort;
    property iSortDirection: Integer read FiSortDirection write FiSortDirection;
    property version: UINT read Fversion write Fversion;
    property uNotUsed: UINT read FuNotUsed write FuNotUsed;
  end;
  
  tagSHELLFLAGSTATEWrapper = class(TatRecordWrapper)
  private
    FData: Word;
  public
    constructor Create(ARecord: tagSHELLFLAGSTATE);
    function ObjToRec: tagSHELLFLAGSTATE;
  published
    property Data: Word read FData write FData;
  end;
  
  tagAAMENUFILENAMEWrapper = class(TatRecordWrapper)
  private
    FcbTotal: Shortint;
  public
    constructor Create(ARecord: tagAAMENUFILENAME);
    function ObjToRec: tagAAMENUFILENAME;
  published
    property cbTotal: Shortint read FcbTotal write FcbTotal;
  end;
  
  tagAASHELLMENUITEMWrapper = class(TatRecordWrapper)
  private
    FiReserved: Integer;
    FuiReserved: UINT;
  public
    constructor Create(ARecord: tagAASHELLMENUITEM);
    function ObjToRec: tagAASHELLMENUITEM;
  published
    property iReserved: Integer read FiReserved write FiReserved;
    property uiReserved: UINT read FuiReserved write FuiReserved;
  end;
  

implementation

constructor _SHITEMIDWrapper.Create(ARecord: _SHITEMID);
begin
  inherited Create;
  Fcb := ARecord.cb;
end;

function _SHITEMIDWrapper.ObjToRec: _SHITEMID;
begin
  result.cb := Fcb;
end;

constructor _ITEMIDLISTWrapper.Create(ARecord: _ITEMIDLIST);
begin
  inherited Create;
end;

function _ITEMIDLISTWrapper.ObjToRec: _ITEMIDLIST;
begin
end;

constructor _STRRETWrapper.Create(ARecord: _STRRET);
begin
  inherited Create;
  FuType := ARecord.uType;
  FuOffset := ARecord.uOffset;
end;

function _STRRETWrapper.ObjToRec: _STRRET;
begin
  result.uType := FuType;
  result.uOffset := FuOffset;
end;

constructor _SHELLDETAILSWrapper.Create(ARecord: _SHELLDETAILS);
begin
  inherited Create;
  Ffmt := ARecord.fmt;
  FcxChar := ARecord.cxChar;
end;

function _SHELLDETAILSWrapper.ObjToRec: _SHELLDETAILS;
begin
  result.fmt := Ffmt;
  result.cxChar := FcxChar;
end;

constructor _COMDLG_FILTERSPECWrapper.Create(ARecord: _COMDLG_FILTERSPEC);
begin
  inherited Create;
end;

function _COMDLG_FILTERSPECWrapper.ObjToRec: _COMDLG_FILTERSPEC;
begin
end;

constructor SHCOLUMNIDWrapper.Create(ARecord: SHCOLUMNID);
begin
  inherited Create;
  Ffmtid := ARecord.fmtid;
  Fpid := ARecord.pid;
end;

function SHCOLUMNIDWrapper.ObjToRec: SHCOLUMNID;
begin
  result.fmtid := Ffmtid;
  result.pid := Fpid;
end;

constructor tagMACHINE_IDWrapper.Create(ARecord: tagMACHINE_ID);
begin
  inherited Create;
end;

function tagMACHINE_IDWrapper.ObjToRec: tagMACHINE_ID;
begin
end;

constructor tagDOMAIN_RELATIVE_OBJECTIDWrapper.Create(ARecord: tagDOMAIN_RELATIVE_OBJECTID);
begin
  inherited Create;
  FguidVolume := ARecord.guidVolume;
  FguidObject := ARecord.guidObject;
end;

function tagDOMAIN_RELATIVE_OBJECTIDWrapper.ObjToRec: tagDOMAIN_RELATIVE_OBJECTID;
begin
  result.guidVolume := FguidVolume;
  result.guidObject := FguidObject;
end;

constructor _CMINVOKECOMMANDINFOWrapper.Create(ARecord: _CMINVOKECOMMANDINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  Fhwnd := ARecord.hwnd;
  FnShow := ARecord.nShow;
  FdwHotKey := ARecord.dwHotKey;
  FhIcon := ARecord.hIcon;
end;

function _CMINVOKECOMMANDINFOWrapper.ObjToRec: _CMINVOKECOMMANDINFO;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.hwnd := Fhwnd;
  result.nShow := FnShow;
  result.dwHotKey := FdwHotKey;
  result.hIcon := FhIcon;
end;

constructor _CMINVOKECOMMANDINFOEXWrapper.Create(ARecord: _CMINVOKECOMMANDINFOEX);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  Fhwnd := ARecord.hwnd;
  FnShow := ARecord.nShow;
  FdwHotKey := ARecord.dwHotKey;
  FhIcon := ARecord.hIcon;
end;

function _CMINVOKECOMMANDINFOEXWrapper.ObjToRec: _CMINVOKECOMMANDINFOEX;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.hwnd := Fhwnd;
  result.nShow := FnShow;
  result.dwHotKey := FdwHotKey;
  result.hIcon := FhIcon;
end;

constructor _PERSIST_FOLDER_TARGET_INFOWrapper.Create(ARecord: _PERSIST_FOLDER_TARGET_INFO);
begin
  inherited Create;
  FdwAttributes := ARecord.dwAttributes;
  Fcsidl := ARecord.csidl;
end;

function _PERSIST_FOLDER_TARGET_INFOWrapper.ObjToRec: _PERSIST_FOLDER_TARGET_INFO;
begin
  result.dwAttributes := FdwAttributes;
  result.csidl := Fcsidl;
end;

constructor EXTRASEARCHWrapper.Create(ARecord: EXTRASEARCH);
begin
  inherited Create;
  FguidSearch := ARecord.guidSearch;
end;

function EXTRASEARCHWrapper.ObjToRec: EXTRASEARCH;
begin
  result.guidSearch := FguidSearch;
end;

constructor FOLDERSETTINGSWrapper.Create(ARecord: FOLDERSETTINGS);
begin
  inherited Create;
  FViewMode := ARecord.ViewMode;
  FfFlags := ARecord.fFlags;
end;

function FOLDERSETTINGSWrapper.ObjToRec: FOLDERSETTINGS;
begin
  result.ViewMode := FViewMode;
  result.fFlags := FfFlags;
end;

constructor _SV2CVW2_PARAMSWrapper.Create(ARecord: _SV2CVW2_PARAMS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FhwndView := ARecord.hwndView;
end;

function _SV2CVW2_PARAMSWrapper.ObjToRec: _SV2CVW2_PARAMS;
begin
  result.cbSize := FcbSize;
  result.hwndView := FhwndView;
end;

constructor SORTCOLUMNWrapper.Create(ARecord: SORTCOLUMN);
begin
  inherited Create;
  Fdirection := ARecord.direction;
end;

function SORTCOLUMNWrapper.ObjToRec: SORTCOLUMN;
begin
  result.direction := Fdirection;
end;

constructor CM_COLUMNINFOWrapper.Create(ARecord: CM_COLUMNINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwMask := ARecord.dwMask;
  FdwState := ARecord.dwState;
  FuWidth := ARecord.uWidth;
  FuDefaultWidth := ARecord.uDefaultWidth;
  FuIdealWidth := ARecord.uIdealWidth;
end;

function CM_COLUMNINFOWrapper.ObjToRec: CM_COLUMNINFO;
begin
  result.cbSize := FcbSize;
  result.dwMask := FdwMask;
  result.dwState := FdwState;
  result.uWidth := FuWidth;
  result.uDefaultWidth := FuDefaultWidth;
  result.uIdealWidth := FuIdealWidth;
end;

constructor SHELL_ITEM_RESOURCEWrapper.Create(ARecord: SHELL_ITEM_RESOURCE);
begin
  inherited Create;
  FguidType := ARecord.guidType;
end;

function SHELL_ITEM_RESOURCEWrapper.ObjToRec: SHELL_ITEM_RESOURCE;
begin
  result.guidType := FguidType;
end;

constructor CATEGORY_INFOWrapper.Create(ARecord: CATEGORY_INFO);
begin
  inherited Create;
  Fcif := ARecord.cif;
end;

function CATEGORY_INFOWrapper.ObjToRec: CATEGORY_INFO;
begin
  result.cif := Fcif;
end;

constructor SHDRAGIMAGEWrapper.Create(ARecord: SHDRAGIMAGE);
begin
  inherited Create;
  FhbmpDragImage := ARecord.hbmpDragImage;
  FcrColorKey := ARecord.crColorKey;
end;

function SHDRAGIMAGEWrapper.ObjToRec: SHDRAGIMAGE;
begin
  result.hbmpDragImage := FhbmpDragImage;
  result.crColorKey := FcrColorKey;
end;

constructor DESKBANDINFOWrapper.Create(ARecord: DESKBANDINFO);
begin
  inherited Create;
  FdwMask := ARecord.dwMask;
  FdwModeFlags := ARecord.dwModeFlags;
  FcrBkgnd := ARecord.crBkgnd;
end;

function DESKBANDINFOWrapper.ObjToRec: DESKBANDINFO;
begin
  result.dwMask := FdwMask;
  result.dwModeFlags := FdwModeFlags;
  result.crBkgnd := FcrBkgnd;
end;

constructor THUMBBUTTONWrapper.Create(ARecord: THUMBBUTTON);
begin
  inherited Create;
  FdwMask := ARecord.dwMask;
  FiId := ARecord.iId;
  FiBitmap := ARecord.iBitmap;
  FhIcon := ARecord.hIcon;
  FdwFlags := ARecord.dwFlags;
end;

function THUMBBUTTONWrapper.ObjToRec: THUMBBUTTON;
begin
  result.dwMask := FdwMask;
  result.iId := FiId;
  result.iBitmap := FiBitmap;
  result.hIcon := FhIcon;
  result.dwFlags := FdwFlags;
end;

constructor tagBANDSITEINFOWrapper.Create(ARecord: tagBANDSITEINFO);
begin
  inherited Create;
  FdwMask := ARecord.dwMask;
  FdwState := ARecord.dwState;
  FdwStyle := ARecord.dwStyle;
end;

function tagBANDSITEINFOWrapper.ObjToRec: tagBANDSITEINFO;
begin
  result.dwMask := FdwMask;
  result.dwState := FdwState;
  result.dwStyle := FdwStyle;
end;

constructor DELEGATEITEMIDWrapper.Create(ARecord: DELEGATEITEMID);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FwOuter := ARecord.wOuter;
  FcbInner := ARecord.cbInner;
end;

function DELEGATEITEMIDWrapper.ObjToRec: DELEGATEITEMID;
begin
  result.cbSize := FcbSize;
  result.wOuter := FwOuter;
  result.cbInner := FcbInner;
end;

constructor tagSMDATAWrapper.Create(ARecord: tagSMDATA);
begin
  inherited Create;
  FdwMask := ARecord.dwMask;
  FdwFlags := ARecord.dwFlags;
  Fhmenu := ARecord.hmenu;
  Fhwnd := ARecord.hwnd;
  FuId := ARecord.uId;
  FuIdParent := ARecord.uIdParent;
  FuIdAncestor := ARecord.uIdAncestor;
  Fpunk := ARecord.punk;
end;

function tagSMDATAWrapper.ObjToRec: tagSMDATA;
begin
  result.dwMask := FdwMask;
  result.dwFlags := FdwFlags;
  result.hmenu := Fhmenu;
  result.hwnd := Fhwnd;
  result.uId := FuId;
  result.uIdParent := FuIdParent;
  result.uIdAncestor := FuIdAncestor;
  result.punk := Fpunk;
end;

constructor tagSMINFOWrapper.Create(ARecord: tagSMINFO);
begin
  inherited Create;
  FdwMask := ARecord.dwMask;
  FdwType := ARecord.dwType;
  FdwFlags := ARecord.dwFlags;
  FiIcon := ARecord.iIcon;
end;

function tagSMINFOWrapper.ObjToRec: tagSMINFO;
begin
  result.dwMask := FdwMask;
  result.dwType := FdwType;
  result.dwFlags := FdwFlags;
  result.iIcon := FiIcon;
end;

constructor SHCSCHANGENOTIFYSTRUCTWrapper.Create(ARecord: SHCSCHANGENOTIFYSTRUCT);
begin
  inherited Create;
  FlEvent := ARecord.lEvent;
end;

function SHCSCHANGENOTIFYSTRUCTWrapper.ObjToRec: SHCSCHANGENOTIFYSTRUCT;
begin
  result.lEvent := FlEvent;
end;

constructor KNOWNFOLDER_DEFINITIONWrapper.Create(ARecord: KNOWNFOLDER_DEFINITION);
begin
  inherited Create;
  Fcategory := ARecord.category;
  FfidParent := ARecord.fidParent;
  FdwAttributes := ARecord.dwAttributes;
  FkfdFlags := ARecord.kfdFlags;
  FftidType := ARecord.ftidType;
end;

function KNOWNFOLDER_DEFINITIONWrapper.ObjToRec: KNOWNFOLDER_DEFINITION;
begin
  result.category := Fcategory;
  result.fidParent := FfidParent;
  result.dwAttributes := FdwAttributes;
  result.kfdFlags := FkfdFlags;
  result.ftidType := FftidType;
end;

constructor NSTCCUSTOMDRAWWrapper.Create(ARecord: NSTCCUSTOMDRAW);
begin
  inherited Create;
  FuItemState := ARecord.uItemState;
  Fnstcis := ARecord.nstcis;
  FiImage := ARecord.iImage;
  Fhiml := ARecord.himl;
  FiLevel := ARecord.iLevel;
  FiIndent := ARecord.iIndent;
end;

function NSTCCUSTOMDRAWWrapper.ObjToRec: NSTCCUSTOMDRAW;
begin
  result.uItemState := FuItemState;
  result.nstcis := Fnstcis;
  result.iImage := FiImage;
  result.himl := Fhiml;
  result.iLevel := FiLevel;
  result.iIndent := FiIndent;
end;

constructor __MIDL_IPreviewHandlerFrame_0001Wrapper.Create(ARecord: __MIDL_IPreviewHandlerFrame_0001);
begin
  inherited Create;
  Fhaccel := ARecord.haccel;
  FcAccelEntries := ARecord.cAccelEntries;
end;

function __MIDL_IPreviewHandlerFrame_0001Wrapper.ObjToRec: __MIDL_IPreviewHandlerFrame_0001;
begin
  result.haccel := Fhaccel;
  result.cAccelEntries := FcAccelEntries;
end;

constructor tagDATABLOCKHEADERWrapper.Create(ARecord: tagDATABLOCKHEADER);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwSignature := ARecord.dwSignature;
end;

function tagDATABLOCKHEADERWrapper.ObjToRec: tagDATABLOCKHEADER;
begin
  result.cbSize := FcbSize;
  result.dwSignature := FdwSignature;
end;

constructor tagNT_CONSOLE_PROPSWrapper.Create(ARecord: tagNT_CONSOLE_PROPS);
begin
  inherited Create;
  FwFillAttribute := ARecord.wFillAttribute;
  FwPopupFillAttribute := ARecord.wPopupFillAttribute;
  FnFont := ARecord.nFont;
  FnInputBufferSize := ARecord.nInputBufferSize;
  FuFontFamily := ARecord.uFontFamily;
  FuFontWeight := ARecord.uFontWeight;
  FuCursorSize := ARecord.uCursorSize;
  FbFullScreen := ARecord.bFullScreen;
  FbQuickEdit := ARecord.bQuickEdit;
  FbInsertMode := ARecord.bInsertMode;
  FbAutoPosition := ARecord.bAutoPosition;
  FuHistoryBufferSize := ARecord.uHistoryBufferSize;
  FuNumberOfHistoryBuffers := ARecord.uNumberOfHistoryBuffers;
  FbHistoryNoDup := ARecord.bHistoryNoDup;
end;

function tagNT_CONSOLE_PROPSWrapper.ObjToRec: tagNT_CONSOLE_PROPS;
begin
  result.wFillAttribute := FwFillAttribute;
  result.wPopupFillAttribute := FwPopupFillAttribute;
  result.nFont := FnFont;
  result.nInputBufferSize := FnInputBufferSize;
  result.uFontFamily := FuFontFamily;
  result.uFontWeight := FuFontWeight;
  result.uCursorSize := FuCursorSize;
  result.bFullScreen := FbFullScreen;
  result.bQuickEdit := FbQuickEdit;
  result.bInsertMode := FbInsertMode;
  result.bAutoPosition := FbAutoPosition;
  result.uHistoryBufferSize := FuHistoryBufferSize;
  result.uNumberOfHistoryBuffers := FuNumberOfHistoryBuffers;
  result.bHistoryNoDup := FbHistoryNoDup;
end;

constructor tagNT_FE_CONSOLE_PROPSWrapper.Create(ARecord: tagNT_FE_CONSOLE_PROPS);
begin
  inherited Create;
  FuCodePage := ARecord.uCodePage;
end;

function tagNT_FE_CONSOLE_PROPSWrapper.ObjToRec: tagNT_FE_CONSOLE_PROPS;
begin
  result.uCodePage := FuCodePage;
end;

constructor tagEXP_DARWIN_LINKWrapper.Create(ARecord: tagEXP_DARWIN_LINK);
begin
  inherited Create;
end;

function tagEXP_DARWIN_LINKWrapper.ObjToRec: tagEXP_DARWIN_LINK;
begin
end;

constructor tagEXP_SPECIAL_FOLDERWrapper.Create(ARecord: tagEXP_SPECIAL_FOLDER);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwSignature := ARecord.dwSignature;
  FidSpecialFolder := ARecord.idSpecialFolder;
  FcbOffset := ARecord.cbOffset;
end;

function tagEXP_SPECIAL_FOLDERWrapper.ObjToRec: tagEXP_SPECIAL_FOLDER;
begin
  result.cbSize := FcbSize;
  result.dwSignature := FdwSignature;
  result.idSpecialFolder := FidSpecialFolder;
  result.cbOffset := FcbOffset;
end;

constructor tagEXP_SZ_LINKWrapper.Create(ARecord: tagEXP_SZ_LINK);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwSignature := ARecord.dwSignature;
end;

function tagEXP_SZ_LINKWrapper.ObjToRec: tagEXP_SZ_LINK;
begin
  result.cbSize := FcbSize;
  result.dwSignature := FdwSignature;
end;

constructor tagEXP_PROPERTYSTORAGEWrapper.Create(ARecord: tagEXP_PROPERTYSTORAGE);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwSignature := ARecord.dwSignature;
end;

function tagEXP_PROPERTYSTORAGEWrapper.ObjToRec: tagEXP_PROPERTYSTORAGE;
begin
  result.cbSize := FcbSize;
  result.dwSignature := FdwSignature;
end;

constructor tagFVSHOWINFOWrapper.Create(ARecord: tagFVSHOWINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FhwndOwner := ARecord.hwndOwner;
  FiShow := ARecord.iShow;
  FdwFlags := ARecord.dwFlags;
  FpunkRel := ARecord.punkRel;
end;

function tagFVSHOWINFOWrapper.ObjToRec: tagFVSHOWINFO;
begin
  result.cbSize := FcbSize;
  result.hwndOwner := FhwndOwner;
  result.iShow := FiShow;
  result.dwFlags := FdwFlags;
  result.punkRel := FpunkRel;
end;

constructor _browseinfoAWrapper.Create(ARecord: _browseinfoA);
begin
  inherited Create;
  FhwndOwner := ARecord.hwndOwner;
  FulFlags := ARecord.ulFlags;
  FlParam := ARecord.lParam;
  FiImage := ARecord.iImage;
end;

function _browseinfoAWrapper.ObjToRec: _browseinfoA;
begin
  result.hwndOwner := FhwndOwner;
  result.ulFlags := FulFlags;
  result.lParam := FlParam;
  result.iImage := FiImage;
end;

constructor _browseinfoWWrapper.Create(ARecord: _browseinfoW);
begin
  inherited Create;
  FhwndOwner := ARecord.hwndOwner;
  FulFlags := ARecord.ulFlags;
  FlParam := ARecord.lParam;
  FiImage := ARecord.iImage;
end;

function _browseinfoWWrapper.ObjToRec: _browseinfoW;
begin
  result.hwndOwner := FhwndOwner;
  result.ulFlags := FulFlags;
  result.lParam := FlParam;
  result.iImage := FiImage;
end;

constructor _EnumImageStoreDATAtagWrapper.Create(ARecord: _EnumImageStoreDATAtag);
begin
  inherited Create;
end;

function _EnumImageStoreDATAtagWrapper.ObjToRec: _EnumImageStoreDATAtag;
begin
end;

constructor tagBANDINFOSFBWrapper.Create(ARecord: tagBANDINFOSFB);
begin
  inherited Create;
  FdwMask := ARecord.dwMask;
  FdwStateMask := ARecord.dwStateMask;
  FdwState := ARecord.dwState;
  FcrBkgnd := ARecord.crBkgnd;
  FcrBtnLt := ARecord.crBtnLt;
  FcrBtnDk := ARecord.crBtnDk;
  FwViewMode := ARecord.wViewMode;
  FwAlign := ARecord.wAlign;
end;

function tagBANDINFOSFBWrapper.ObjToRec: tagBANDINFOSFB;
begin
  result.dwMask := FdwMask;
  result.dwStateMask := FdwStateMask;
  result.dwState := FdwState;
  result.crBkgnd := FcrBkgnd;
  result.crBtnLt := FcrBtnLt;
  result.crBtnDk := FcrBtnDk;
  result.wViewMode := FwViewMode;
  result.wAlign := FwAlign;
end;

constructor _tagWALLPAPEROPTWrapper.Create(ARecord: _tagWALLPAPEROPT);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwStyle := ARecord.dwStyle;
end;

function _tagWALLPAPEROPTWrapper.ObjToRec: _tagWALLPAPEROPT;
begin
  result.dwSize := FdwSize;
  result.dwStyle := FdwStyle;
end;

constructor _tagCOMPONENTSOPTWrapper.Create(ARecord: _tagCOMPONENTSOPT);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FfEnableComponents := ARecord.fEnableComponents;
  FfActiveDesktop := ARecord.fActiveDesktop;
end;

function _tagCOMPONENTSOPTWrapper.ObjToRec: _tagCOMPONENTSOPT;
begin
  result.dwSize := FdwSize;
  result.fEnableComponents := FfEnableComponents;
  result.fActiveDesktop := FfActiveDesktop;
end;

constructor _tagCOMPPOSWrapper.Create(ARecord: _tagCOMPPOS);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FiLeft := ARecord.iLeft;
  FiTop := ARecord.iTop;
  FdwWidth := ARecord.dwWidth;
  FdwHeight := ARecord.dwHeight;
  FizIndex := ARecord.izIndex;
  FfCanResize := ARecord.fCanResize;
  FfCanResizeX := ARecord.fCanResizeX;
  FfCanResizeY := ARecord.fCanResizeY;
  FiPreferredLeftPercent := ARecord.iPreferredLeftPercent;
  FiPreferredTopPercent := ARecord.iPreferredTopPercent;
end;

function _tagCOMPPOSWrapper.ObjToRec: _tagCOMPPOS;
begin
  result.dwSize := FdwSize;
  result.iLeft := FiLeft;
  result.iTop := FiTop;
  result.dwWidth := FdwWidth;
  result.dwHeight := FdwHeight;
  result.izIndex := FizIndex;
  result.fCanResize := FfCanResize;
  result.fCanResizeX := FfCanResizeX;
  result.fCanResizeY := FfCanResizeY;
  result.iPreferredLeftPercent := FiPreferredLeftPercent;
  result.iPreferredTopPercent := FiPreferredTopPercent;
end;

constructor _tagCOMPSTATEINFOWrapper.Create(ARecord: _tagCOMPSTATEINFO);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FiLeft := ARecord.iLeft;
  FiTop := ARecord.iTop;
  FdwWidth := ARecord.dwWidth;
  FdwHeight := ARecord.dwHeight;
  FdwItemState := ARecord.dwItemState;
end;

function _tagCOMPSTATEINFOWrapper.ObjToRec: _tagCOMPSTATEINFO;
begin
  result.dwSize := FdwSize;
  result.iLeft := FiLeft;
  result.iTop := FiTop;
  result.dwWidth := FdwWidth;
  result.dwHeight := FdwHeight;
  result.dwItemState := FdwItemState;
end;

constructor _tagIE4COMPONENTWrapper.Create(ARecord: _tagIE4COMPONENT);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwID := ARecord.dwID;
  FiComponentType := ARecord.iComponentType;
  FfChecked := ARecord.fChecked;
  FfDirty := ARecord.fDirty;
  FfNoScroll := ARecord.fNoScroll;
end;

function _tagIE4COMPONENTWrapper.ObjToRec: _tagIE4COMPONENT;
begin
  result.dwSize := FdwSize;
  result.dwID := FdwID;
  result.iComponentType := FiComponentType;
  result.fChecked := FfChecked;
  result.fDirty := FfDirty;
  result.fNoScroll := FfNoScroll;
end;

constructor _tagCOMPONENTWrapper.Create(ARecord: _tagCOMPONENT);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwID := ARecord.dwID;
  FiComponentType := ARecord.iComponentType;
  FfChecked := ARecord.fChecked;
  FfDirty := ARecord.fDirty;
  FfNoScroll := ARecord.fNoScroll;
  FdwCurItemState := ARecord.dwCurItemState;
end;

function _tagCOMPONENTWrapper.ObjToRec: _tagCOMPONENT;
begin
  result.dwSize := FdwSize;
  result.dwID := FdwID;
  result.iComponentType := FiComponentType;
  result.fChecked := FfChecked;
  result.fDirty := FfDirty;
  result.fNoScroll := FfNoScroll;
  result.dwCurItemState := FdwCurItemState;
end;

constructor tagSHCOLUMNINFOWrapper.Create(ARecord: tagSHCOLUMNINFO);
begin
  inherited Create;
  Fvt := ARecord.vt;
  Ffmt := ARecord.fmt;
  FcChars := ARecord.cChars;
  FcsFlags := ARecord.csFlags;
end;

function tagSHCOLUMNINFOWrapper.ObjToRec: tagSHCOLUMNINFO;
begin
  result.vt := Fvt;
  result.fmt := Ffmt;
  result.cChars := FcChars;
  result.csFlags := FcsFlags;
end;

constructor tagSHCOLUMNINITWrapper.Create(ARecord: tagSHCOLUMNINIT);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FdwReserved := ARecord.dwReserved;
end;

function tagSHCOLUMNINITWrapper.ObjToRec: tagSHCOLUMNINIT;
begin
  result.dwFlags := FdwFlags;
  result.dwReserved := FdwReserved;
end;

constructor tagSHCOLUMNDATAWrapper.Create(ARecord: tagSHCOLUMNDATA);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FdwFileAttributes := ARecord.dwFileAttributes;
  FdwReserved := ARecord.dwReserved;
end;

function tagSHCOLUMNDATAWrapper.ObjToRec: tagSHCOLUMNDATA;
begin
  result.dwFlags := FdwFlags;
  result.dwFileAttributes := FdwFileAttributes;
  result.dwReserved := FdwReserved;
end;

constructor _NRESARRAYWrapper.Create(ARecord: _NRESARRAY);
begin
  inherited Create;
  FcItems := ARecord.cItems;
end;

function _NRESARRAYWrapper.ObjToRec: _NRESARRAY;
begin
  result.cItems := FcItems;
end;

constructor _IDAWrapper.Create(ARecord: _IDA);
begin
  inherited Create;
  Fcidl := ARecord.cidl;
end;

function _IDAWrapper.ObjToRec: _IDA;
begin
  result.cidl := Fcidl;
end;

constructor _FILEDESCRIPTORAWrapper.Create(ARecord: _FILEDESCRIPTORA);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  Fclsid := ARecord.clsid;
  FdwFileAttributes := ARecord.dwFileAttributes;
  FnFileSizeHigh := ARecord.nFileSizeHigh;
  FnFileSizeLow := ARecord.nFileSizeLow;
end;

function _FILEDESCRIPTORAWrapper.ObjToRec: _FILEDESCRIPTORA;
begin
  result.dwFlags := FdwFlags;
  result.clsid := Fclsid;
  result.dwFileAttributes := FdwFileAttributes;
  result.nFileSizeHigh := FnFileSizeHigh;
  result.nFileSizeLow := FnFileSizeLow;
end;

constructor _FILEDESCRIPTORWWrapper.Create(ARecord: _FILEDESCRIPTORW);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  Fclsid := ARecord.clsid;
  FdwFileAttributes := ARecord.dwFileAttributes;
  FnFileSizeHigh := ARecord.nFileSizeHigh;
  FnFileSizeLow := ARecord.nFileSizeLow;
end;

function _FILEDESCRIPTORWWrapper.ObjToRec: _FILEDESCRIPTORW;
begin
  result.dwFlags := FdwFlags;
  result.clsid := Fclsid;
  result.dwFileAttributes := FdwFileAttributes;
  result.nFileSizeHigh := FnFileSizeHigh;
  result.nFileSizeLow := FnFileSizeLow;
end;

constructor _FILEGROUPDESCRIPTORAWrapper.Create(ARecord: _FILEGROUPDESCRIPTORA);
begin
  inherited Create;
  FcItems := ARecord.cItems;
end;

function _FILEGROUPDESCRIPTORAWrapper.ObjToRec: _FILEGROUPDESCRIPTORA;
begin
  result.cItems := FcItems;
end;

constructor _FILEGROUPDESCRIPTORWWrapper.Create(ARecord: _FILEGROUPDESCRIPTORW);
begin
  inherited Create;
  FcItems := ARecord.cItems;
end;

function _FILEGROUPDESCRIPTORWWrapper.ObjToRec: _FILEGROUPDESCRIPTORW;
begin
  result.cItems := FcItems;
end;

constructor _DROPFILESWrapper.Create(ARecord: _DROPFILES);
begin
  inherited Create;
  FpFiles := ARecord.pFiles;
  FfNC := ARecord.fNC;
  FfWide := ARecord.fWide;
end;

function _DROPFILESWrapper.ObjToRec: _DROPFILES;
begin
  result.pFiles := FpFiles;
  result.fNC := FfNC;
  result.fWide := FfWide;
end;

constructor tagFILE_ATTRIBUTES_ARRAYWrapper.Create(ARecord: tagFILE_ATTRIBUTES_ARRAY);
begin
  inherited Create;
  FcItems := ARecord.cItems;
  FdwSumFileAttributes := ARecord.dwSumFileAttributes;
  FdwProductFileAttributes := ARecord.dwProductFileAttributes;
end;

function tagFILE_ATTRIBUTES_ARRAYWrapper.ObjToRec: tagFILE_ATTRIBUTES_ARRAY;
begin
  result.cItems := FcItems;
  result.dwSumFileAttributes := FdwSumFileAttributes;
  result.dwProductFileAttributes := FdwProductFileAttributes;
end;

constructor _SHChangeNotifyEntryWrapper.Create(ARecord: _SHChangeNotifyEntry);
begin
  inherited Create;
  FfRecursive := ARecord.fRecursive;
end;

function _SHChangeNotifyEntryWrapper.ObjToRec: _SHChangeNotifyEntry;
begin
  result.fRecursive := FfRecursive;
end;

constructor SHARDAPPIDINFOWrapper.Create(ARecord: SHARDAPPIDINFO);
begin
  inherited Create;
end;

function SHARDAPPIDINFOWrapper.ObjToRec: SHARDAPPIDINFO;
begin
end;

constructor SHARDAPPIDINFOIDLISTWrapper.Create(ARecord: SHARDAPPIDINFOIDLIST);
begin
  inherited Create;
end;

function SHARDAPPIDINFOIDLISTWrapper.ObjToRec: SHARDAPPIDINFOIDLIST;
begin
end;

constructor SHARDAPPIDINFOLINKWrapper.Create(ARecord: SHARDAPPIDINFOLINK);
begin
  inherited Create;
end;

function SHARDAPPIDINFOLINKWrapper.ObjToRec: SHARDAPPIDINFOLINK;
begin
end;

constructor _SHChangeDWORDAsIDListWrapper.Create(ARecord: _SHChangeDWORDAsIDList);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FdwItem1 := ARecord.dwItem1;
  FdwItem2 := ARecord.dwItem2;
  FcbZero := ARecord.cbZero;
end;

function _SHChangeDWORDAsIDListWrapper.ObjToRec: _SHChangeDWORDAsIDList;
begin
  result.cb := Fcb;
  result.dwItem1 := FdwItem1;
  result.dwItem2 := FdwItem2;
  result.cbZero := FcbZero;
end;

constructor _SHChangeUpdateImageIDListWrapper.Create(ARecord: _SHChangeUpdateImageIDList);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FiIconIndex := ARecord.iIconIndex;
  FiCurIndex := ARecord.iCurIndex;
  FuFlags := ARecord.uFlags;
  FdwProcessID := ARecord.dwProcessID;
  FcbZero := ARecord.cbZero;
end;

function _SHChangeUpdateImageIDListWrapper.ObjToRec: _SHChangeUpdateImageIDList;
begin
  result.cb := Fcb;
  result.iIconIndex := FiIconIndex;
  result.iCurIndex := FiCurIndex;
  result.uFlags := FuFlags;
  result.dwProcessID := FdwProcessID;
  result.cbZero := FcbZero;
end;

constructor _SHChangeProductKeyAsIDListWrapper.Create(ARecord: _SHChangeProductKeyAsIDList);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FcbZero := ARecord.cbZero;
end;

function _SHChangeProductKeyAsIDListWrapper.ObjToRec: _SHChangeProductKeyAsIDList;
begin
  result.cb := Fcb;
  result.cbZero := FcbZero;
end;

constructor _SHDESCRIPTIONIDWrapper.Create(ARecord: _SHDESCRIPTIONID);
begin
  inherited Create;
  FdwDescriptionId := ARecord.dwDescriptionId;
  FId := ARecord.Id;
end;

function _SHDESCRIPTIONIDWrapper.ObjToRec: _SHDESCRIPTIONID;
begin
  result.dwDescriptionId := FdwDescriptionId;
  result.Id := FId;
end;

constructor tagAUTO_SCROLL_DATAWrapper.Create(ARecord: tagAUTO_SCROLL_DATA);
begin
  inherited Create;
  FiNextSample := ARecord.iNextSample;
  FdwLastScroll := ARecord.dwLastScroll;
  FbFull := ARecord.bFull;
end;

function tagAUTO_SCROLL_DATAWrapper.ObjToRec: tagAUTO_SCROLL_DATA;
begin
  result.iNextSample := FiNextSample;
  result.dwLastScroll := FdwLastScroll;
  result.bFull := FbFull;
end;

constructor tagCABINETSTATEWrapper.Create(ARecord: tagCABINETSTATE);
begin
  inherited Create;
  FcLength := ARecord.cLength;
  FnVersion := ARecord.nVersion;
  FfUnusedFlags := ARecord.fUnusedFlags;
  FfMenuEnumFilter := ARecord.fMenuEnumFilter;
end;

function tagCABINETSTATEWrapper.ObjToRec: tagCABINETSTATE;
begin
  result.cLength := FcLength;
  result.nVersion := FnVersion;
  result.fUnusedFlags := FfUnusedFlags;
  result.fMenuEnumFilter := FfMenuEnumFilter;
end;

constructor _openasinfoWrapper.Create(ARecord: _openasinfo);
begin
  inherited Create;
  FoaifInFlags := ARecord.oaifInFlags;
end;

function _openasinfoWrapper.ObjToRec: _openasinfo;
begin
  result.oaifInFlags := FoaifInFlags;
end;

constructor PROPPRGWrapper.Create(ARecord: PROPPRG);
begin
  inherited Create;
  FflPrg := ARecord.flPrg;
  FflPrgInit := ARecord.flPrgInit;
  FwHotKey := ARecord.wHotKey;
  FwIconIndex := ARecord.wIconIndex;
  FdwEnhModeFlags := ARecord.dwEnhModeFlags;
  FdwRealModeFlags := ARecord.dwRealModeFlags;
end;

function PROPPRGWrapper.ObjToRec: PROPPRG;
begin
  result.flPrg := FflPrg;
  result.flPrgInit := FflPrgInit;
  result.wHotKey := FwHotKey;
  result.wIconIndex := FwIconIndex;
  result.dwEnhModeFlags := FdwEnhModeFlags;
  result.dwRealModeFlags := FdwRealModeFlags;
end;

constructor _QCMINFO_IDMAP_PLACEMENTWrapper.Create(ARecord: _QCMINFO_IDMAP_PLACEMENT);
begin
  inherited Create;
  Fid := ARecord.id;
  FfFlags := ARecord.fFlags;
end;

function _QCMINFO_IDMAP_PLACEMENTWrapper.ObjToRec: _QCMINFO_IDMAP_PLACEMENT;
begin
  result.id := Fid;
  result.fFlags := FfFlags;
end;

constructor _QCMINFO_IDMAPWrapper.Create(ARecord: _QCMINFO_IDMAP);
begin
  inherited Create;
  FnMaxIds := ARecord.nMaxIds;
end;

function _QCMINFO_IDMAPWrapper.ObjToRec: _QCMINFO_IDMAP;
begin
  result.nMaxIds := FnMaxIds;
end;

constructor _QCMINFOWrapper.Create(ARecord: _QCMINFO);
begin
  inherited Create;
  Fhmenu := ARecord.hmenu;
  FindexMenu := ARecord.indexMenu;
  FidCmdFirst := ARecord.idCmdFirst;
  FidCmdLast := ARecord.idCmdLast;
end;

function _QCMINFOWrapper.ObjToRec: _QCMINFO;
begin
  result.hmenu := Fhmenu;
  result.indexMenu := FindexMenu;
  result.idCmdFirst := FidCmdFirst;
  result.idCmdLast := FidCmdLast;
end;

constructor _TBINFOWrapper.Create(ARecord: _TBINFO);
begin
  inherited Create;
  Fcbuttons := ARecord.cbuttons;
  FuFlags := ARecord.uFlags;
end;

function _TBINFOWrapper.ObjToRec: _TBINFO;
begin
  result.cbuttons := Fcbuttons;
  result.uFlags := FuFlags;
end;

constructor _DETAILSINFOWrapper.Create(ARecord: _DETAILSINFO);
begin
  inherited Create;
  Ffmt := ARecord.fmt;
  FcxChar := ARecord.cxChar;
  FiImage := ARecord.iImage;
end;

function _DETAILSINFOWrapper.ObjToRec: _DETAILSINFO;
begin
  result.fmt := Ffmt;
  result.cxChar := FcxChar;
  result.iImage := FiImage;
end;

constructor _SFVM_PROPPAGE_DATAWrapper.Create(ARecord: _SFVM_PROPPAGE_DATA);
begin
  inherited Create;
  FdwReserved := ARecord.dwReserved;
  FlParam := ARecord.lParam;
end;

function _SFVM_PROPPAGE_DATAWrapper.ObjToRec: _SFVM_PROPPAGE_DATA;
begin
  result.dwReserved := FdwReserved;
  result.lParam := FlParam;
end;

constructor _SFVM_HELPTOPIC_DATAWrapper.Create(ARecord: _SFVM_HELPTOPIC_DATA);
begin
  inherited Create;
end;

function _SFVM_HELPTOPIC_DATAWrapper.ObjToRec: _SFVM_HELPTOPIC_DATA;
begin
end;

constructor _ITEMSPACINGWrapper.Create(ARecord: _ITEMSPACING);
begin
  inherited Create;
  FcxSmall := ARecord.cxSmall;
  FcySmall := ARecord.cySmall;
  FcxLarge := ARecord.cxLarge;
  FcyLarge := ARecord.cyLarge;
end;

function _ITEMSPACINGWrapper.ObjToRec: _ITEMSPACING;
begin
  result.cxSmall := FcxSmall;
  result.cySmall := FcySmall;
  result.cxLarge := FcxLarge;
  result.cyLarge := FcyLarge;
end;

constructor _SFV_CREATEWrapper.Create(ARecord: _SFV_CREATE);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
end;

function _SFV_CREATEWrapper.ObjToRec: _SFV_CREATE;
begin
  result.cbSize := FcbSize;
end;

constructor tagDEFCONTEXTMENUWrapper.Create(ARecord: tagDEFCONTEXTMENU);
begin
  inherited Create;
  Fhwnd := ARecord.hwnd;
  Fcidl := ARecord.cidl;
  FpunkAssociationInfo := ARecord.punkAssociationInfo;
  FcKeys := ARecord.cKeys;
end;

function tagDEFCONTEXTMENUWrapper.ObjToRec: tagDEFCONTEXTMENU;
begin
  result.hwnd := Fhwnd;
  result.cidl := Fcidl;
  result.punkAssociationInfo := FpunkAssociationInfo;
  result.cKeys := FcKeys;
end;

constructor tagDFMICSWrapper.Create(ARecord: tagDFMICS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  FlParam := ARecord.lParam;
  FidCmdFirst := ARecord.idCmdFirst;
  FidDefMax := ARecord.idDefMax;
  FpunkSite := ARecord.punkSite;
end;

function tagDFMICSWrapper.ObjToRec: tagDFMICS;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.lParam := FlParam;
  result.idCmdFirst := FidCmdFirst;
  result.idDefMax := FidDefMax;
  result.punkSite := FpunkSite;
end;

constructor _CSFVWrapper.Create(ARecord: _CSFV);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FlEvents := ARecord.lEvents;
  Ffvm := ARecord.fvm;
end;

function _CSFVWrapper.ObjToRec: _CSFV;
begin
  result.cbSize := FcbSize;
  result.lEvents := FlEvents;
  result.fvm := Ffvm;
end;

constructor _SFV_SETITEMPOSWrapper.Create(ARecord: _SFV_SETITEMPOS);
begin
  inherited Create;
end;

function _SFV_SETITEMPOSWrapper.ObjToRec: _SFV_SETITEMPOS;
begin
end;

constructor tagSHELLSTATEWWrapper.Create(ARecord: tagSHELLSTATEW);
begin
  inherited Create;
  FData := ARecord.Data;
  FData2 := ARecord.Data2;
  FlParamSort := ARecord.lParamSort;
  FiSortDirection := ARecord.iSortDirection;
  Fversion := ARecord.version;
  FuNotUsed := ARecord.uNotUsed;
end;

function tagSHELLSTATEWWrapper.ObjToRec: tagSHELLSTATEW;
begin
  result.Data := FData;
  result.Data2 := FData2;
  result.lParamSort := FlParamSort;
  result.iSortDirection := FiSortDirection;
  result.version := Fversion;
  result.uNotUsed := FuNotUsed;
end;

constructor tagSHELLFLAGSTATEWrapper.Create(ARecord: tagSHELLFLAGSTATE);
begin
  inherited Create;
  FData := ARecord.Data;
end;

function tagSHELLFLAGSTATEWrapper.ObjToRec: tagSHELLFLAGSTATE;
begin
  result.Data := FData;
end;

constructor tagAAMENUFILENAMEWrapper.Create(ARecord: tagAAMENUFILENAME);
begin
  inherited Create;
  FcbTotal := ARecord.cbTotal;
end;

function tagAAMENUFILENAMEWrapper.ObjToRec: tagAAMENUFILENAME;
begin
  result.cbTotal := FcbTotal;
end;

constructor tagAASHELLMENUITEMWrapper.Create(ARecord: tagAASHELLMENUITEM);
begin
  inherited Create;
  FiReserved := ARecord.iReserved;
  FuiReserved := ARecord.uiReserved;
end;

function tagAASHELLMENUITEMWrapper.ObjToRec: tagAASHELLMENUITEM;
begin
  result.iReserved := FiReserved;
  result.uiReserved := FuiReserved;
end;



procedure TatShlObjLibrary.__SHCreateItemInKnownFolder(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param4: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := GetInputArg(4);
AResult := ShlObj.SHCreateItemInKnownFolder(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),TGUIDWrapper(integer(GetInputArg(3))).ObjToRec,Param4);
    ReturnOutputArg(AResult);
    SetInputArg(4,Param4);
  end;
end;

procedure TatShlObjLibrary.__SHGetItemFromObject(AMachine: TatVirtualMachine);
  var
  Param0: IUnknown;
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param2 := GetInputArg(2);
AResult := ShlObj.SHGetItemFromObject(Param0,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(2,Param2);
  end;
end;

procedure TatShlObjLibrary.__SHCreateAssociationRegistration(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := ShlObj.SHCreateAssociationRegistration(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatShlObjLibrary.__SHCreateDefaultExtractIcon(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := ShlObj.SHCreateDefaultExtractIcon(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatShlObjLibrary.__SetCurrentProcessExplicitAppUserModelID(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SetCurrentProcessExplicitAppUserModelID(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__GetCurrentProcessExplicitAppUserModelID(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param0: LPWSTR;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))));
AResult := ShlObj.GetCurrentProcessExplicitAppUserModelID(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,WideCharToString(Param0));
  end;
end;

procedure TatShlObjLibrary.__SHFree(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    ShlObj.SHFree(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatShlObjLibrary.__SHGetIconOverlayIndex(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.SHGetIconOverlayIndex(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetIconOverlayIndexA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.SHGetIconOverlayIndexA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetIconOverlayIndexW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.SHGetIconOverlayIndexW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHCreateDirectory(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.SHCreateDirectory(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHCreateDirectoryEx(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Rec: TObject;
  Param2: SECURITY_ATTRIBUTES;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _SECURITY_ATTRIBUTESWrapper) then 
  Param2Rec := _SECURITY_ATTRIBUTESWrapper.Create(Param2);
Param2 := _SECURITY_ATTRIBUTESWrapper(Param2Rec).ObjToRec;
AResult := Integer(ShlObj.SHCreateDirectoryEx(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_SECURITY_ATTRIBUTESWrapper.Create(Param2)));
  end;
end;

procedure TatShlObjLibrary.__SHCreateDirectoryExA(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: SECURITY_ATTRIBUTES;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _SECURITY_ATTRIBUTESWrapper) then 
  Param2Rec := _SECURITY_ATTRIBUTESWrapper.Create(Param2);
Param2 := _SECURITY_ATTRIBUTESWrapper(Param2Rec).ObjToRec;
AResult := Integer(ShlObj.SHCreateDirectoryExA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_SECURITY_ATTRIBUTESWrapper.Create(Param2)));
  end;
end;

procedure TatShlObjLibrary.__SHCreateDirectoryExW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Rec: TObject;
  Param2: SECURITY_ATTRIBUTES;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _SECURITY_ATTRIBUTESWrapper) then 
  Param2Rec := _SECURITY_ATTRIBUTESWrapper.Create(Param2);
Param2 := _SECURITY_ATTRIBUTESWrapper(Param2Rec).ObjToRec;
AResult := Integer(ShlObj.SHCreateDirectoryExW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_SECURITY_ATTRIBUTESWrapper.Create(Param2)));
  end;
end;

procedure TatShlObjLibrary.__SHGetSpecialFolderPath(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHGetSpecialFolderPath(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetSpecialFolderPathA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHGetSpecialFolderPathA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetSpecialFolderPathW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHGetSpecialFolderPathW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHFlushSFCache(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShlObj.SHFlushSFCache;
  end;
end;

procedure TatShlObjLibrary.__SHGetFolderPathA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHGetFolderPathA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2),VarToInteger(GetInputArg(3)),PAnsiChar(VarToStr(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetFolderPathW(AMachine: TatVirtualMachine);
  var
  Param4Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHGetFolderPathW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2),VarToInteger(GetInputArg(3)),StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetFolderPath(AMachine: TatVirtualMachine);
  var
  Param4Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHGetFolderPath(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2),VarToInteger(GetInputArg(3)),StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetFolderPathAndSubDir(AMachine: TatVirtualMachine);
  var
  Param4Buf: array[0..127] of WideChar;
  Param5Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHGetFolderPathAndSubDir(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2),VarToInteger(GetInputArg(3)),StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4)))),StringToWideChar(VarToStr(GetInputArg(5)),Param5Buf,Length(VarToStr(GetInputArg(5)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetFolderPathAndSubDirA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHGetFolderPathAndSubDirA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2),VarToInteger(GetInputArg(3)),PAnsiChar(VarToStr(GetInputArg(4))),PAnsiChar(VarToStr(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetFolderPathAndSubDirW(AMachine: TatVirtualMachine);
  var
  Param4Buf: array[0..127] of WideChar;
  Param5Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHGetFolderPathAndSubDirW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2),VarToInteger(GetInputArg(3)),StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4)))),StringToWideChar(VarToStr(GetInputArg(5)),Param5Buf,Length(VarToStr(GetInputArg(5)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHSetKnownFolderPath(AMachine: TatVirtualMachine);
  var
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHSetKnownFolderPath(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),GetInputArg(2),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetKnownFolderPath(AMachine: TatVirtualMachine);
  var
  Param3Buf: array[0..127] of WideChar;
  Param3: LPWSTR;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3))));
AResult := ShlObj.SHGetKnownFolderPath(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),GetInputArg(2),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,WideCharToString(Param3));
  end;
end;

procedure TatShlObjLibrary.__SHLoadInProc(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHLoadInProc(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHUpdateImageA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShlObj.SHUpdateImageA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatShlObjLibrary.__SHUpdateImageW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShlObj.SHUpdateImageW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatShlObjLibrary.__SHUpdateImage(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShlObj.SHUpdateImage(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatShlObjLibrary.__SHChangeNotifyRegister(AMachine: TatVirtualMachine);
  var
  Param5Rec: TObject;
  Param5: TSHChangeNotifyEntry;
  AResult: variant;
begin
  with AMachine do
  begin
Param5Rec := TObject(integer(GetInputArg(5)));
if not Assigned(Param5Rec) or not (Param5Rec is _SHChangeNotifyEntryWrapper) then 
  Param5Rec := _SHChangeNotifyEntryWrapper.Create(Param5);
Param5 := _SHChangeNotifyEntryWrapper(Param5Rec).ObjToRec;
AResult := Integer(ShlObj.SHChangeNotifyRegister(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),Param5));
    ReturnOutputArg(AResult);
    SetInputArg(5,integer(_SHChangeNotifyEntryWrapper.Create(Param5)));
  end;
end;

procedure TatShlObjLibrary.__SHChangeNotifyDeregister(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHChangeNotifyDeregister(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHChangeNotification_Unlock(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHChangeNotification_Unlock(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetInstanceExplorer(AMachine: TatVirtualMachine);
  var
  Param0: IUnknown;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := ShlObj.SHGetInstanceExplorer(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatShlObjLibrary.__RestartDialog(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.RestartDialog(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__RestartDialogEx(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.RestartDialogEx(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__DAD_SetDragImage(AMachine: TatVirtualMachine);
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
AResult := ShlObj.DAD_SetDragImage(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TPointWrapper.Create(Param1)));
  end;
end;

procedure TatShlObjLibrary.__DAD_DragEnterEx(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.DAD_DragEnterEx(VarToInteger(GetInputArg(0)),TPointWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__DAD_ShowDragImage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.DAD_ShowDragImage(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__DAD_DragMove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.DAD_DragMove(TPointWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__DAD_DragLeave(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.DAD_DragLeave;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__DAD_AutoScroll(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TAutoScrollData;
  Param2Rec: TObject;
  Param2: TPoint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagAUTO_SCROLL_DATAWrapper) then 
  Param1Rec := tagAUTO_SCROLL_DATAWrapper.Create(Param1);
Param1 := tagAUTO_SCROLL_DATAWrapper(Param1Rec).ObjToRec;
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TPointWrapper) then 
  Param2Rec := TPointWrapper.Create(Param2);
Param2 := TPointWrapper(Param2Rec).ObjToRec;
AResult := ShlObj.DAD_AutoScroll(VarToInteger(GetInputArg(0)),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagAUTO_SCROLL_DATAWrapper.Create(Param1)));
    SetInputArg(2,integer(TPointWrapper.Create(Param2)));
  end;
end;

procedure TatShlObjLibrary.__ReadCabinetState(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TCabinetState;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagCABINETSTATEWrapper) then 
  Param0Rec := tagCABINETSTATEWrapper.Create(Param0);
Param0 := tagCABINETSTATEWrapper(Param0Rec).ObjToRec;
AResult := ShlObj.ReadCabinetState(Param0,VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagCABINETSTATEWrapper.Create(Param0)));
  end;
end;

procedure TatShlObjLibrary.__WriteCabinetState(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TCabinetState;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagCABINETSTATEWrapper) then 
  Param0Rec := tagCABINETSTATEWrapper.Create(Param0);
Param0 := tagCABINETSTATEWrapper(Param0Rec).ObjToRec;
AResult := ShlObj.WriteCabinetState(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagCABINETSTATEWrapper.Create(Param0)));
  end;
end;

procedure TatShlObjLibrary.__PathMakeUniqueName(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  Param4Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.PathMakeUniqueName(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__PathQualify(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShlObj.PathQualify(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShlObjLibrary.__PathIsExe(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.PathIsExe(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__PathIsSlow(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.PathIsSlow(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__PathIsSlowA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.PathIsSlowA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__PathIsSlowW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.PathIsSlowW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__PathCleanupSpec(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.PathCleanupSpec(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__PathResolve(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.PathResolve(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__GetFileNameFromBrowse(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  Param4Buf: array[0..127] of WideChar;
  Param5Buf: array[0..127] of WideChar;
  Param6Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.GetFileNameFromBrowse(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4)))),StringToWideChar(VarToStr(GetInputArg(5)),Param5Buf,Length(VarToStr(GetInputArg(5)))),StringToWideChar(VarToStr(GetInputArg(6)),Param6Buf,Length(VarToStr(GetInputArg(6)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__DriveType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.DriveType(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__RealDriveType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.RealDriveType(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__IsNetDrive(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.IsNetDrive(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__Shell_MergeMenus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.Shell_MergeMenus(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHObjectProperties(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHObjectProperties(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHFormatDrive(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.SHFormatDrive(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHCreatePropSheetExtArray(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHCreatePropSheetExtArray(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHDestroyPropSheetExtArray(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShlObj.SHDestroyPropSheetExtArray(GetInputArg(0));
  end;
end;

procedure TatShlObjLibrary.__PathGetShortPath(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShlObj.PathGetShortPath(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShlObjLibrary.__PathYetAnotherMakeUniqueName(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.PathYetAnotherMakeUniqueName(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__Win32DeleteFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.Win32DeleteFile(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__PathProcessCommand(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.PathProcessCommand(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHRestricted(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.SHRestricted(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHLoadOLE(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHLoadOLE(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHDefExtractIconA(AMachine: TatVirtualMachine);
  var
  Param3: HICON;
  Param4: HICON;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
AResult := ShlObj.SHDefExtractIconA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,Param4,VarToInteger(GetInputArg(5)));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatShlObjLibrary.__SHDefExtractIconW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3: HICON;
  Param4: HICON;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
AResult := ShlObj.SHDefExtractIconW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,Param4,VarToInteger(GetInputArg(5)));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatShlObjLibrary.__SHDefExtractIcon(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3: HICON;
  Param4: HICON;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
AResult := ShlObj.SHDefExtractIcon(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,Param4,VarToInteger(GetInputArg(5)));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatShlObjLibrary.__SHOpenWithDialog(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TOpenAsInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _openasinfoWrapper) then 
  Param1Rec := _openasinfoWrapper.Create(Param1);
Param1 := _openasinfoWrapper(Param1Rec).ObjToRec;
AResult := ShlObj.SHOpenWithDialog(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_openasinfoWrapper.Create(Param1)));
  end;
end;

procedure TatShlObjLibrary.__Shell_GetImageLists(AMachine: TatVirtualMachine);
  var
  Param0: HIMAGELIST;
  Param1: HIMAGELIST;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
AResult := ShlObj.Shell_GetImageLists(Param0,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
  end;
end;

procedure TatShlObjLibrary.__SHValidateUNC(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHValidateUNC(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__PifMgr_OpenProperties(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.PifMgr_OpenProperties(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__PifMgr_CloseProperties(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.PifMgr_CloseProperties(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHSetInstanceExplorer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShlObj.SHSetInstanceExplorer(GetInputArg(0));
  end;
end;

procedure TatShlObjLibrary.__IsUserAnAdmin(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.IsUserAnAdmin;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHShellFolderView_Message(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.SHShellFolderView_Message(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetSetSettings(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TShellState;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagSHELLSTATEWWrapper) then 
  Param0Rec := tagSHELLSTATEWWrapper.Create(Param0);
Param0 := tagSHELLSTATEWWrapper(Param0Rec).ObjToRec;
    ShlObj.SHGetSetSettings(Param0,VarToInteger(GetInputArg(1)),GetInputArg(2));
    SetInputArg(0,integer(tagSHELLSTATEWWrapper.Create(Param0)));
  end;
end;

procedure TatShlObjLibrary.__SHGetSettings(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TShellFlagState;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagSHELLFLAGSTATEWrapper) then 
  Param0Rec := tagSHELLFLAGSTATEWrapper.Create(Param0);
Param0 := tagSHELLFLAGSTATEWrapper(Param0Rec).ObjToRec;
    ShlObj.SHGetSettings(Param0,VarToInteger(GetInputArg(1)));
    SetInputArg(0,integer(tagSHELLFLAGSTATEWrapper.Create(Param0)));
  end;
end;

procedure TatShlObjLibrary.__SHPathPrepareForWriteA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHPathPrepareForWriteA(VarToInteger(GetInputArg(0)),GetInputArg(1),PAnsiChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHPathPrepareForWriteW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHPathPrepareForWriteW(VarToInteger(GetInputArg(0)),GetInputArg(1),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHPathPrepareForWrite(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHPathPrepareForWrite(VarToInteger(GetInputArg(0)),GetInputArg(1),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__PerUserInit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.PerUserInit;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHRunControlPanel(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHRunControlPanel(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__PickIconDlg(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param3: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(ShlObj.PickIconDlg(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShlObjLibrary.__ImportPrivacySettings(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1: BOOL;
  Param2: BOOL;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param2 := GetInputArg(2);
AResult := ShlObj.ImportPrivacySettings(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
    SetInputArg(2,Param2);
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_NetworkDomain(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_NetworkDomain)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_NetworkServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_NetworkServer)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_NetworkShare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_NetworkShare)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_MyComputer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_MyComputer)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_Internet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_Internet)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_RecycleBin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_RecycleBin)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ControlPanel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ControlPanel)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_Printers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_Printers)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_MyDocuments(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_MyDocuments)));
  end;
end;

procedure TatShlObjLibrary.__GetCATID_BrowsableShellExt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CATID_BrowsableShellExt)));
  end;
end;

procedure TatShlObjLibrary.__GetCATID_BrowseInPlace(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CATID_BrowseInPlace)));
  end;
end;

procedure TatShlObjLibrary.__GetCATID_DeskBand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CATID_DeskBand)));
  end;
end;

procedure TatShlObjLibrary.__GetCATID_InfoBand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CATID_InfoBand)));
  end;
end;

procedure TatShlObjLibrary.__GetCATID_CommBand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CATID_CommBand)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_Intshcut(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_Intshcut)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_InternetSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_InternetSite)));
  end;
end;

procedure TatShlObjLibrary.__GetCGID_Explorer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CGID_Explorer)));
  end;
end;

procedure TatShlObjLibrary.__GetCGID_ShellDocView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CGID_ShellDocView)));
  end;
end;

procedure TatShlObjLibrary.__GetCGID_ShellServiceObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CGID_ShellServiceObject)));
  end;
end;

procedure TatShlObjLibrary.__GetCGID_ExplorerBarDoc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CGID_ExplorerBarDoc)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IBriefcaseStg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IBriefcaseStg)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDefViewID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDefViewID)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_FolderShortcut(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_FolderShortcut)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_CFSIconOverlayManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_CFSIconOverlayManager)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellThumbnailDiskCache(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellThumbnailDiskCache)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_DefView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_DefView)));
  end;
end;

procedure TatShlObjLibrary.__GetCGID_DefView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CGID_DefView)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_MenuBand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_MenuBand)));
  end;
end;

procedure TatShlObjLibrary.__GetVID_LargeIcons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.VID_LargeIcons)));
  end;
end;

procedure TatShlObjLibrary.__GetVID_SmallIcons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.VID_SmallIcons)));
  end;
end;

procedure TatShlObjLibrary.__GetVID_List(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.VID_List)));
  end;
end;

procedure TatShlObjLibrary.__GetVID_Details(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.VID_Details)));
  end;
end;

procedure TatShlObjLibrary.__GetVID_Tile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.VID_Tile)));
  end;
end;

procedure TatShlObjLibrary.__GetVID_Content(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.VID_Content)));
  end;
end;

procedure TatShlObjLibrary.__GetVID_Thumbnails(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.VID_Thumbnails)));
  end;
end;

procedure TatShlObjLibrary.__GetVID_ThumbStrip(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.VID_ThumbStrip)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SShellDesktop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SShellDesktop)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SInPlaceBrowser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SInPlaceBrowser)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SSearchBoxInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SSearchBoxInfo)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDiscardableBrowserProperty(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDiscardableBrowserProperty)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_CUrlHistory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_CUrlHistory)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_CURLSearchHook(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_CURLSearchHook)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SInternetExplorer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SInternetExplorer)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SWebBrowserApp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SWebBrowserApp)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_AutoComplete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_AutoComplete)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ACLHistory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ACLHistory)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ACListISF(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ACListISF)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ACLMRU(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ACLMRU)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ACLMulti(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ACLMulti)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ACLCustomMRU(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ACLCustomMRU)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ProgressDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ProgressDialog)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SProgressUI(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SProgressUI)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_STopLevelBrowser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_STopLevelBrowser)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_FileTypes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_FileTypes)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ActiveDesktop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ActiveDesktop)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ISynchronizedCallBack(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ISynchronizedCallBack)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IQueryAssociations(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IQueryAssociations)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_QueryAssociations(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_QueryAssociations)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_LinkColumnProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_LinkColumnProvider)));
  end;
end;

procedure TatShlObjLibrary.__GetCGID_ShortCut(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CGID_ShortCut)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_InternetButtons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_InternetButtons)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_MSOButtons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_MSOButtons)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ToolbarExtButtons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ToolbarExtButtons)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_DarwinAppPublisher(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_DarwinAppPublisher)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_DocHostUIHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_DocHostUIHandler)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_ShellDetails(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_ShellDetails)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_Storage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_Storage)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_ImageProperties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_ImageProperties)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_CustomImageProperties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_CustomImageProperties)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_LibraryProperties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_LibraryProperties)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_Displaced(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_Displaced)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_Briefcase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_Briefcase)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_Misc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_Misc)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_WebView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_WebView)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_MUSIC(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_MUSIC)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_DRM(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_DRM)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_Volume(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_Volume)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_Query(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_Query)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_HWShellExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_HWShellExecute)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_DragDropHelper(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_DragDropHelper)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_CAnchorBrowsePropertyPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_CAnchorBrowsePropertyPage)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_CImageBrowsePropertyPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_CImageBrowsePropertyPage)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_CDocBrowsePropertyPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_CDocBrowsePropertyPage)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_STopWindow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_STopWindow)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SGetViewFromViewDual(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SGetViewFromViewDual)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_FolderItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_FolderItem)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_FolderItemsMultiLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_FolderItemsMultiLevel)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_NewMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_NewMenu)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_SFObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_SFObject)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_SFUIObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_SFUIObject)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_SFViewObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_SFViewObject)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_Storage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_Storage)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_Stream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_Stream)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_LinkTargetItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_LinkTargetItem)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_StorageEnum(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_StorageEnum)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_Transfer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_Transfer)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_PropertyStore(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_PropertyStore)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_ThumbnailHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_ThumbnailHandler)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_EnumItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_EnumItems)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_DataObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_DataObject)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_AssociationArray(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_AssociationArray)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_Filter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_Filter)));
  end;
end;

procedure TatShlObjLibrary.__GetBHID_EnumAssocHandlers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.BHID_EnumAssocHandlers)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_CtxQueryAssociations(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_CtxQueryAssociations)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_QuickLinks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_QuickLinks)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ISFBand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ISFBand)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_CDefView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_CDefView)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellFldSetExt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellFldSetExt)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SMenuBandChild(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SMenuBandChild)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SMenuBandParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SMenuBandParent)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SMenuPopup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SMenuPopup)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SMenuBandBottomSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SMenuBandBottomSelected)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SMenuBandBottom(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SMenuBandBottom)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_MenuShellFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_MenuShellFolder)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SMenuBandContextMenuModifier(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SMenuBandContextMenuModifier)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SMenuBandBKContextMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SMenuBandBKContextMenu)));
  end;
end;

procedure TatShlObjLibrary.__GetCGID_MENUDESKBAR(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CGID_MENUDESKBAR)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SMenuBandTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SMenuBandTop)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_MenuToolbarBase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_MenuToolbarBase)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_MenuBandSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_MenuBandSite)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SCommDlgBrowser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SCommDlgBrowser)));
  end;
end;

procedure TatShlObjLibrary.__GetCPFG_LOGON_USERNAME(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CPFG_LOGON_USERNAME)));
  end;
end;

procedure TatShlObjLibrary.__GetCPFG_LOGON_PASSWORD(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CPFG_LOGON_PASSWORD)));
  end;
end;

procedure TatShlObjLibrary.__GetCPFG_SMARTCARD_USERNAME(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CPFG_SMARTCARD_USERNAME)));
  end;
end;

procedure TatShlObjLibrary.__GetCPFG_SMARTCARD_PIN(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CPFG_SMARTCARD_PIN)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_Invalid(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_Invalid)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_Generic(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_Generic)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_GenericSearchResults(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_GenericSearchResults)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_GenericLibrary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_GenericLibrary)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_Documents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_Documents)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_Pictures(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_Pictures)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_Music(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_Music)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_Videos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_Videos)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_UserFiles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_UserFiles)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_UsersLibraries(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_UsersLibraries)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_OtherUsers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_OtherUsers)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_PublishedItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_PublishedItems)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_Communications(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_Communications)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_Contacts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_Contacts)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_StartMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_StartMenu)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_RecordedTV(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_RecordedTV)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_SavedGames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_SavedGames)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_OpenSearch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_OpenSearch)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_SearchConnector(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_SearchConnector)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_Games(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_Games)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_ControlPanelCategory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_ControlPanelCategory)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_ControlPanelClassic(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_ControlPanelClassic)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_Printers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_Printers)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_RecycleBin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_RecycleBin)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_SoftwareExplorer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_SoftwareExplorer)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_CompressedFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_CompressedFolder)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_NetworkExplorer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_NetworkExplorer)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_Searches(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_Searches)));
  end;
end;

procedure TatShlObjLibrary.__GetFOLDERTYPEID_SearchHome(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FOLDERTYPEID_SearchHome)));
  end;
end;

procedure TatShlObjLibrary.__GetSYNCMGR_OBJECTID_Icon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SYNCMGR_OBJECTID_Icon)));
  end;
end;

procedure TatShlObjLibrary.__GetSYNCMGR_OBJECTID_EventStore(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SYNCMGR_OBJECTID_EventStore)));
  end;
end;

procedure TatShlObjLibrary.__GetSYNCMGR_OBJECTID_ConflictStore(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SYNCMGR_OBJECTID_ConflictStore)));
  end;
end;

procedure TatShlObjLibrary.__GetSYNCMGR_OBJECTID_BrowseContent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SYNCMGR_OBJECTID_BrowseContent)));
  end;
end;

procedure TatShlObjLibrary.__GetSYNCMGR_OBJECTID_ShowSchedule(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SYNCMGR_OBJECTID_ShowSchedule)));
  end;
end;

procedure TatShlObjLibrary.__GetSYNCMGR_OBJECTID_QueryBeforeActivate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SYNCMGR_OBJECTID_QueryBeforeActivate)));
  end;
end;

procedure TatShlObjLibrary.__GetSYNCMGR_OBJECTID_QueryBeforeDeactivate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SYNCMGR_OBJECTID_QueryBeforeDeactivate)));
  end;
end;

procedure TatShlObjLibrary.__GetSYNCMGR_OBJECTID_QueryBeforeEnable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SYNCMGR_OBJECTID_QueryBeforeEnable)));
  end;
end;

procedure TatShlObjLibrary.__GetSYNCMGR_OBJECTID_QueryBeforeDisable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SYNCMGR_OBJECTID_QueryBeforeDisable)));
  end;
end;

procedure TatShlObjLibrary.__GetSYNCMGR_OBJECTID_QueryBeforeDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SYNCMGR_OBJECTID_QueryBeforeDelete)));
  end;
end;

procedure TatShlObjLibrary.__GetSYNCMGR_OBJECTID_EventLinkClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SYNCMGR_OBJECTID_EventLinkClick)));
  end;
end;

procedure TatShlObjLibrary.__GetEP_NavPane(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.EP_NavPane)));
  end;
end;

procedure TatShlObjLibrary.__GetEP_Commands(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.EP_Commands)));
  end;
end;

procedure TatShlObjLibrary.__GetEP_Commands_Organize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.EP_Commands_Organize)));
  end;
end;

procedure TatShlObjLibrary.__GetEP_Commands_View(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.EP_Commands_View)));
  end;
end;

procedure TatShlObjLibrary.__GetEP_DetailsPane(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.EP_DetailsPane)));
  end;
end;

procedure TatShlObjLibrary.__GetEP_PreviewPane(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.EP_PreviewPane)));
  end;
end;

procedure TatShlObjLibrary.__GetEP_QueryPane(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.EP_QueryPane)));
  end;
end;

procedure TatShlObjLibrary.__GetEP_AdvQueryPane(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.EP_AdvQueryPane)));
  end;
end;

procedure TatShlObjLibrary.__GetCATID_LocationFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CATID_LocationFactory)));
  end;
end;

procedure TatShlObjLibrary.__GetCATID_LocationProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CATID_LocationProvider)));
  end;
end;

procedure TatShlObjLibrary.__GetItemCount_Property_GUID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.ItemCount_Property_GUID)));
  end;
end;

procedure TatShlObjLibrary.__GetSelectedItemCount_Property_GUID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SelectedItemCount_Property_GUID)));
  end;
end;

procedure TatShlObjLibrary.__GetItemIndex_Property_GUID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.ItemIndex_Property_GUID)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IContextMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IContextMenu)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IContextMenu2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IContextMenu2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IContextMenu3(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IContextMenu3)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IExecuteCommand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IExecuteCommand)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IPersistFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IPersistFolder)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IRunnableTask(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IRunnableTask)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellTaskScheduler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellTaskScheduler)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IQueryCodePage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IQueryCodePage)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IPersistFolder2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IPersistFolder2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IPersistFolder3(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IPersistFolder3)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IPersistIDList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IPersistIDList)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumIDList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumIDList)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumFullIDList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumFullIDList)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IObjectWithFolderEnumMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IObjectWithFolderEnumMode)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IParseAndCreateItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IParseAndCreateItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellFolder)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumExtraSearch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumExtraSearch)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellFolder2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellFolder2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFolderViewOptions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFolderViewOptions)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellView)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellView2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellView2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellView3(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellView3)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFolderView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFolderView)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ISearchBoxInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ISearchBoxInfo)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFolderView2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFolderView2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFolderViewSettings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFolderViewSettings)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IPreviewHandlerVisuals(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IPreviewHandlerVisuals)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IVisualProperties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IVisualProperties)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ICommDlgBrowser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ICommDlgBrowser)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ICommDlgBrowser2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ICommDlgBrowser2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ICommDlgBrowser3(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ICommDlgBrowser3)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IColumnManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IColumnManager)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFolderFilterSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFolderFilterSite)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFolderFilter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFolderFilter)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IInputObjectSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IInputObjectSite)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IInputObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IInputObject)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IInputObject2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IInputObject2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellIcon)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellBrowser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellBrowser)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IProfferService(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IProfferService)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellItem2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellItem2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellItemImageFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellItemImageFactory)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IUserAccountChangeCallback(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IUserAccountChangeCallback)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumShellItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumShellItems)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ITransferAdviseSink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ITransferAdviseSink)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ITransferSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ITransferSource)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumResources(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumResources)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellItemResources(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellItemResources)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ITransferDestination(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ITransferDestination)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IStreamAsync(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IStreamAsync)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IStreamUnbufferedInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IStreamUnbufferedInfo)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileOperationProgressSink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileOperationProgressSink)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellItemArray(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellItemArray)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IInitializeWithItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IInitializeWithItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IObjectWithSelection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IObjectWithSelection)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IObjectWithBackReferences(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IObjectWithBackReferences)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IPropertyUI(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IPropertyUI)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ICategoryProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ICategoryProvider)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ICategorizer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ICategorizer)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDropTargetHelper(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDropTargetHelper)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDragSourceHelper(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDragSourceHelper)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDragSourceHelper2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDragSourceHelper2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellLinkA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellLinkA)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellLinkW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellLinkW)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellLink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellLink)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellLinkDataList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellLinkDataList)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IResolveShellLink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IResolveShellLink)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IActionProgressDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IActionProgressDialog)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IHWEventHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IHWEventHandler)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IHWEventHandler2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IHWEventHandler2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IQueryCancelAutoPlay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IQueryCancelAutoPlay)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDynamicHWHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDynamicHWHandler)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IActionProgress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IActionProgress)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellExtInit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellExtInit)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellPropSheetExt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellPropSheetExt)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IRemoteComputer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IRemoteComputer)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IQueryContinue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IQueryContinue)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IObjectWithCancelEvent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IObjectWithCancelEvent)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IUserNotification(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IUserNotification)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IUserNotificationCallback(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IUserNotificationCallback)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IUserNotification2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IUserNotification2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IItemNameLimits(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IItemNameLimits)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ISearchFolderItemFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ISearchFolderItemFactory)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IExtractImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IExtractImage)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IExtractImage2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IExtractImage2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IThumbnailHandlerFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IThumbnailHandlerFactory)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IParentAndItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IParentAndItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDockingWindow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDockingWindow)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDeskBand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDeskBand)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDeskBandInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDeskBandInfo)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDeskBand2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDeskBand2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ITaskbarList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ITaskbarList)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ITaskbarList2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ITaskbarList2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ITaskbarList3(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ITaskbarList3)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ITaskbarList4(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ITaskbarList4)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IStartMenuPinnedList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IStartMenuPinnedList)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ICDBurn(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ICDBurn)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IWizardSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IWizardSite)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IWizardExtension(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IWizardExtension)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IWebWizardExtension(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IWebWizardExtension)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IPublishingWizard(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IPublishingWizard)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFolderViewHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFolderViewHost)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IExplorerBrowserEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IExplorerBrowserEvents)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IExplorerBrowser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IExplorerBrowser)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IAccessibleObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IAccessibleObject)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IResultsFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IResultsFolder)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumObjects(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumObjects)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IOperationsProgressDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IOperationsProgressDialog)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IIOCancelInformation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IIOCancelInformation)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileOperation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileOperation)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IObjectProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IObjectProvider)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INamespaceWalkCB(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INamespaceWalkCB)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INamespaceWalkCB2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INamespaceWalkCB2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INamespaceWalk(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INamespaceWalk)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IAutoCompleteDropDown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IAutoCompleteDropDown)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IBandSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IBandSite)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IModalWindow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IModalWindow)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ICDBurnExt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ICDBurnExt)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IContextMenuSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IContextMenuSite)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumReadyCallback(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumReadyCallback)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumerableView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumerableView)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IInsertItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IInsertItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IMenuBand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IMenuBand)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFolderBandPriv(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFolderBandPriv)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IRegTreeItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IRegTreeItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IImageRecompress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IImageRecompress)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDeskBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDeskBar)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IMenuPopup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IMenuPopup)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileIsInUse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileIsInUse)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileDialogEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileDialogEvents)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileDialog)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileSaveDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileSaveDialog)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileOpenDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileOpenDialog)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileDialogCustomize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileDialogCustomize)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileDialogControlEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileDialogControlEvents)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileDialog2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileDialog2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IApplicationAssociationRegistration(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IApplicationAssociationRegistration)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IApplicationAssociationRegistrationUI(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IApplicationAssociationRegistrationUI)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDelegateFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDelegateFolder)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IBrowserFrameOptions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IBrowserFrameOptions)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INewWindowManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INewWindowManager)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IAttachmentExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IAttachmentExecute)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellMenuCallback(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellMenuCallback)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellMenu)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellRunDll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellRunDll)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IKnownFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IKnownFolder)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IKnownFolderManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IKnownFolderManager)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ISharingConfigurationManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ISharingConfigurationManager)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IPreviousVersionsInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IPreviousVersionsInfo)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IRelatedItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IRelatedItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IIdentityName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IIdentityName)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDelegateItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDelegateItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ICurrentItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ICurrentItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ITransferMediumItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ITransferMediumItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IUseToBrowseItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IUseToBrowseItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDisplayItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDisplayItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IViewStateIdentityItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IViewStateIdentityItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IPreviewItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IPreviewItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDestinationStreamFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDestinationStreamFactory)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INewMenuClient(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INewMenuClient)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IInitializeWithBindCtx(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IInitializeWithBindCtx)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellItemFilter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellItemFilter)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INameSpaceTreeControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INameSpaceTreeControl)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INameSpaceTreeControl2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INameSpaceTreeControl2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INameSpaceTreeControlEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INameSpaceTreeControlEvents)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INameSpaceTreeControlDropHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INameSpaceTreeControlDropHandler)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INameSpaceTreeAccessible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INameSpaceTreeAccessible)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INameSpaceTreeControlCustomDraw(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INameSpaceTreeControlCustomDraw)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INameSpaceTreeControlFolderCapabilities(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INameSpaceTreeControlFolderCapabilities)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IPreviewHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IPreviewHandler)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IPreviewHandlerFrame(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IPreviewHandlerFrame)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ITrayDeskBand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ITrayDeskBand)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IBandHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IBandHost)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IExplorerPaneVisibility(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IExplorerPaneVisibility)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IContextMenuCB(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IContextMenuCB)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDefaultExtractIconInit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDefaultExtractIconInit)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IExplorerCommand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IExplorerCommand)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IExplorerCommandState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IExplorerCommandState)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IInitializeCommand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IInitializeCommand)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumExplorerCommand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumExplorerCommand)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IExplorerCommandProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IExplorerCommandProvider)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IMarkupCallback(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IMarkupCallback)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IControlMarkup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IControlMarkup)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IInitializeNetworkFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IInitializeNetworkFolder)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IOpenControlPanel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IOpenControlPanel)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IComputerInfoChangeNotify(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IComputerInfoChangeNotify)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileSystemBindData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileSystemBindData)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileSystemBindData2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileSystemBindData2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ICustomDestinationList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ICustomDestinationList)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IApplicationDestinations(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IApplicationDestinations)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IApplicationDocumentLists(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IApplicationDocumentLists)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IObjectWithAppUserModelID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IObjectWithAppUserModelID)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IObjectWithProgID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IObjectWithProgID)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IUpdateIDList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IUpdateIDList)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDesktopGadget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDesktopGadget)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IHomeGroup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IHomeGroup)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IInitializeWithPropertyStore(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IInitializeWithPropertyStore)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IOpenSearchSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IOpenSearchSource)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellLibrary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellLibrary)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IAssocHandlerInvoker(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IAssocHandlerInvoker)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IAssocHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IAssocHandler)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumAssocHandlers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumAssocHandlers)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SFolderView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SFolderView)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SExplorerBrowserFrame(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SExplorerBrowserFrame)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SProfferService(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SProfferService)));
  end;
end;

procedure TatShlObjLibrary.__GetCGID_DeskBand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CGID_DeskBand)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_WizardSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_WizardSite)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_WebWizardHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_WebWizardHost)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SBandSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SBandSite)));
  end;
end;

procedure TatShlObjLibrary.__GetCGID_BandSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CGID_BandSite)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_CDWizardHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_CDWizardHost)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_EnumerableView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_EnumerableView)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SNewWindowManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SNewWindowManager)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SNewMenuClient(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SNewMenuClient)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SCommandBarState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SCommandBarState)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SNavigationPane(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SNavigationPane)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SBandHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SBandHost)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_ExplorerPaneVisibility(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_ExplorerPaneVisibility)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_LinkSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_LinkSite)));
  end;
end;

procedure TatShlObjLibrary.__GetSID_SShellBrowser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.SID_SShellBrowser)));
  end;
end;

procedure TatShlObjLibrary.__GetTOID_NULL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.TOID_NULL)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellDesktop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellDesktop)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellFSFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellFSFolder)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_NetworkPlaces(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_NetworkPlaces)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellLink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellLink)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_QueryCancelAutoPlay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_QueryCancelAutoPlay)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_DriveSizeCategorizer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_DriveSizeCategorizer)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_DriveTypeCategorizer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_DriveTypeCategorizer)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_FreeSpaceCategorizer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_FreeSpaceCategorizer)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_TimeCategorizer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_TimeCategorizer)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_SizeCategorizer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_SizeCategorizer)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_AlphabeticalCategorizer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_AlphabeticalCategorizer)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_MergedCategorizer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_MergedCategorizer)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ImageProperties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ImageProperties)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_PropertiesUI(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_PropertiesUI)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_UserNotification(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_UserNotification)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_CDBurn(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_CDBurn)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_TaskbarList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_TaskbarList)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_StartMenuPin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_StartMenuPin)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_WebWizardHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_WebWizardHost)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_PublishDropTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_PublishDropTarget)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_PublishingWizard(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_PublishingWizard)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_InternetPrintOrdering(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_InternetPrintOrdering)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_FolderViewHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_FolderViewHost)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ExplorerBrowser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ExplorerBrowser)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ImageRecompress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ImageRecompress)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_TrayBandSiteService(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_TrayBandSiteService)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_TrayDeskBand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_TrayDeskBand)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_AttachmentServices(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_AttachmentServices)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_DocPropShellExtension(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_DocPropShellExtension)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellItem)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_NamespaceWalker(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_NamespaceWalker)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_FileOperation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_FileOperation)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_FileOpenDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_FileOpenDialog)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_FileSaveDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_FileSaveDialog)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_KnownFolderManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_KnownFolderManager)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_FSCopyHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_FSCopyHandler)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_SharingConfigurationManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_SharingConfigurationManager)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_PreviousVersions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_PreviousVersions)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_NetworkConnections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_NetworkConnections)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_NamespaceTreeControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_NamespaceTreeControl)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_IENamespaceTreeControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_IENamespaceTreeControl)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ScheduledTasks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ScheduledTasks)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ApplicationAssociationRegistration(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ApplicationAssociationRegistration)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ApplicationAssociationRegistrationUI(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ApplicationAssociationRegistrationUI)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_SearchFolderItemFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_SearchFolderItemFactory)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_OpenControlPanel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_OpenControlPanel)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_MailRecipient(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_MailRecipient)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_NetworkExplorerFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_NetworkExplorerFolder)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_DestinationList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_DestinationList)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ApplicationDestinations(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ApplicationDestinations)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ApplicationDocumentLists(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ApplicationDocumentLists)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_HomeGroup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_HomeGroup)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellLibrary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellLibrary)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_AppStartupLink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_AppStartupLink)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_EnumerableObjectCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_EnumerableObjectCollection)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_DesktopGadget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_DesktopGadget)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IExtractIconA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IExtractIconA)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IExtractIconW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IExtractIconW)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellIconOverlayIdentifier(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellIconOverlayIdentifier)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellIconOverlayManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellIconOverlayManager)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellIconOverlay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellIconOverlay)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellExecuteHookA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellExecuteHookA)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellExecuteHookW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellExecuteHookW)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IURLSearchHook(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IURLSearchHook)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ISearchContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ISearchContext)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IURLSearchHook2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IURLSearchHook2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INewShortcutHookA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INewShortcutHookA)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INewShortcutHookW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INewShortcutHookW)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ICopyHookA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ICopyHookA)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ICopyHookW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ICopyHookW)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileViewerSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileViewerSite)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileViewerA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileViewerA)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileViewerW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileViewerW)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellDetails(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellDetails)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IObjMgr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IObjMgr)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ICurrentWorkingDirectory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ICurrentWorkingDirectory)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IACList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IACList)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IACList2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IACList2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IProgressDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IProgressDialog)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDockingWindowSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDockingWindowSite)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDockingWindowFrame(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDockingWindowFrame)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IThumbnailCapture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IThumbnailCapture)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumShellImageStore(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumShellImageStore)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellImageStore(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellImageStore)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellFolderBand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellFolderBand)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDeskBarClient(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDeskBarClient)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IActiveDesktop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IActiveDesktop)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IActiveDesktopP(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IActiveDesktopP)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IADesktopP2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IADesktopP2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IColumnProvider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IColumnProvider)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellChangeNotify(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellChangeNotify)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IQueryInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IQueryInfo)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDefViewFrame(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDefViewFrame)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDocViewSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDocViewSite)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IInitializeObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IInitializeObject)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IBanneredBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IBanneredBar)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellFolderViewCB(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellFolderViewCB)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellFolderView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellFolderView)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INamedPropertyBag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INamedPropertyBag)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumPrivacyRecords(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumPrivacyRecords)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFolderViewOC(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFolderViewOC)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_DShellFolderViewEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_DShellFolderViewEvents)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_DFConstraint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_DFConstraint)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_FolderItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_FolderItem)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_FolderItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_FolderItems)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_FolderItemVerb(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_FolderItemVerb)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_FolderItemVerbs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_FolderItemVerbs)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_Folder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_Folder)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_Folder2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_Folder2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_Folder3(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_Folder3)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_FolderItem2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_FolderItem2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_FolderItems2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_FolderItems2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_FolderItems3(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_FolderItems3)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellLinkDual(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellLinkDual)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellLinkDual2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellLinkDual2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellFolderViewDual(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellFolderViewDual)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellFolderViewDual2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellFolderViewDual2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellFolderViewDual3(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellFolderViewDual3)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellDispatch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellDispatch)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellDispatch2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellDispatch2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellDispatch3(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellDispatch3)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellDispatch4(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellDispatch4)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellDispatch5(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellDispatch5)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileSearchBand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileSearchBand)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IWebWizardHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IWebWizardHost)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INewWDEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INewWDEvents)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IAutoComplete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IAutoComplete)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IAutoComplete2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IAutoComplete2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumACString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumACString)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IAsyncOperation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IAsyncOperation)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellFolderViewOC(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellFolderViewOC)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellFolderItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellFolderItem)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellLinkObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellLinkObject)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellFolderView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellFolderView)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_Shell(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_Shell)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellDispatchInproc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellDispatchInproc)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_FileSearchBand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_FileSearchBand)));
  end;
end;

procedure TatShlObjLibrary.Init;

  procedure AddConsts1;
  begin
    with Scripter.DefineClass(ClassType) do
    begin
      AddConstant('SBSC_HIDE',SBSC_HIDE);
      AddConstant('SBSC_SHOW',SBSC_SHOW);
      AddConstant('SBSC_TOGGLE',SBSC_TOGGLE);
      AddConstant('SBSC_QUERY',SBSC_QUERY);
      AddConstant('SBO_DEFAULT',SBO_DEFAULT);
      AddConstant('SBO_NOBROWSERPAGES',SBO_NOBROWSERPAGES);
      AddConstant('SBCMDID_ENABLESHOWTREE',SBCMDID_ENABLESHOWTREE);
      AddConstant('SBCMDID_SHOWCONTROL',SBCMDID_SHOWCONTROL);
      AddConstant('SBCMDID_CANCELNAVIGATION',SBCMDID_CANCELNAVIGATION);
      AddConstant('SBCMDID_MAYSAVECHANGES',SBCMDID_MAYSAVECHANGES);
      AddConstant('SBCMDID_SETHLINKFRAME',SBCMDID_SETHLINKFRAME);
      AddConstant('SBCMDID_ENABLESTOP',SBCMDID_ENABLESTOP);
      AddConstant('SBCMDID_OPTIONS',SBCMDID_OPTIONS);
      AddConstant('SHDVID_SETPROGRESSPOS',SHDVID_SETPROGRESSPOS);
      AddConstant('SHDVID_SETPROGRESSRANGE',SHDVID_SETPROGRESSRANGE);
      AddConstant('SHDVID_SETSTATUSTEXT',SHDVID_SETSTATUSTEXT);
      AddConstant('SHDVID_REFRESH',SHDVID_REFRESH);
      AddConstant('SHDVID_STOP',SHDVID_STOP);
      AddConstant('SHDVID_UPDATECOMMANDS',SHDVID_UPDATECOMMANDS);
      AddConstant('SHDVID_SETTITLE',SHDVID_SETTITLE);
      AddConstant('SHDVID_FINALTITLEAVAIL',SHDVID_FINALTITLEAVAIL);
      AddConstant('SHDVID_STARTLOAD',SHDVID_STARTLOAD);
      AddConstant('SHDVID_STOPLOAD',SHDVID_STOPLOAD);
      AddConstant('SHDVID_CCALLBACK',SHDVID_CCALLBACK);
      AddConstant('SHDVID_MENUEXEC',SHDVID_MENUEXEC);
      AddConstant('SHDVID_MENUQS',SHDVID_MENUQS);
      AddConstant('STRRET_WSTR',STRRET_WSTR);
      AddConstant('STRRET_OFFSET',STRRET_OFFSET);
      AddConstant('STRRET_CSTR',STRRET_CSTR);
      AddConstant('PERCEIVED_TYPE_FIRST',PERCEIVED_TYPE_FIRST);
      AddConstant('PERCEIVED_TYPE_CUSTOM',PERCEIVED_TYPE_CUSTOM);
      AddConstant('PERCEIVED_TYPE_UNSPECIFIED',PERCEIVED_TYPE_UNSPECIFIED);
      AddConstant('PERCEIVED_TYPE_FOLDER',PERCEIVED_TYPE_FOLDER);
      AddConstant('PERCEIVED_TYPE_UNKNOWN',PERCEIVED_TYPE_UNKNOWN);
      AddConstant('PERCEIVED_TYPE_TEXT',PERCEIVED_TYPE_TEXT);
      AddConstant('PERCEIVED_TYPE_IMAGE',PERCEIVED_TYPE_IMAGE);
      AddConstant('PERCEIVED_TYPE_AUDIO',PERCEIVED_TYPE_AUDIO);
      AddConstant('PERCEIVED_TYPE_VIDEO',PERCEIVED_TYPE_VIDEO);
      AddConstant('PERCEIVED_TYPE_COMPRESSED',PERCEIVED_TYPE_COMPRESSED);
      AddConstant('PERCEIVED_TYPE_DOCUMENT',PERCEIVED_TYPE_DOCUMENT);
      AddConstant('PERCEIVED_TYPE_SYSTEM',PERCEIVED_TYPE_SYSTEM);
      AddConstant('PERCEIVED_TYPE_APPLICATION',PERCEIVED_TYPE_APPLICATION);
      AddConstant('PERCEIVED_TYPE_GAMEMEDIA',PERCEIVED_TYPE_GAMEMEDIA);
      AddConstant('PERCEIVED_TYPE_CONTACTS',PERCEIVED_TYPE_CONTACTS);
      AddConstant('PERCEIVED_TYPE_LAST',PERCEIVED_TYPE_LAST);
      AddConstant('PERCEIVEDFLAG_UNDEFINED',PERCEIVEDFLAG_UNDEFINED);
      AddConstant('PERCEIVEDFLAG_SOFTCODED',PERCEIVEDFLAG_SOFTCODED);
      AddConstant('PERCEIVEDFLAG_HARDCODED',PERCEIVEDFLAG_HARDCODED);
      AddConstant('PERCEIVEDFLAG_NATIVESUPPORT',PERCEIVEDFLAG_NATIVESUPPORT);
      AddConstant('PERCEIVEDFLAG_GDIPLUS',PERCEIVEDFLAG_GDIPLUS);
      AddConstant('PERCEIVEDFLAG_WMSDK',PERCEIVEDFLAG_WMSDK);
      AddConstant('PERCEIVEDFLAG_ZIPFOLDER',PERCEIVEDFLAG_ZIPFOLDER);
      AddConstant('SHCOLSTATE_DEFAULT',SHCOLSTATE_DEFAULT);
      AddConstant('SHCOLSTATE_TYPE_STR',SHCOLSTATE_TYPE_STR);
      AddConstant('SHCOLSTATE_TYPE_INT',SHCOLSTATE_TYPE_INT);
      AddConstant('SHCOLSTATE_TYPE_DATE',SHCOLSTATE_TYPE_DATE);
      AddConstant('SHCOLSTATE_TYPEMASK',SHCOLSTATE_TYPEMASK);
      AddConstant('SHCOLSTATE_ONBYDEFAULT',SHCOLSTATE_ONBYDEFAULT);
      AddConstant('SHCOLSTATE_SLOW',SHCOLSTATE_SLOW);
      AddConstant('SHCOLSTATE_EXTENDED',SHCOLSTATE_EXTENDED);
      AddConstant('SHCOLSTATE_SECONDARYUI',SHCOLSTATE_SECONDARYUI);
      AddConstant('SHCOLSTATE_HIDDEN',SHCOLSTATE_HIDDEN);
      AddConstant('SHCOLSTATE_PREFER_VARCMP',SHCOLSTATE_PREFER_VARCMP);
      AddConstant('SHCOLSTATE_PREFER_FMTCMP',SHCOLSTATE_PREFER_FMTCMP);
      AddConstant('SHCOLSTATE_NOSORTBYFOLDERNESS',SHCOLSTATE_NOSORTBYFOLDERNESS);
      AddConstant('SHCOLSTATE_VIEWONLY',SHCOLSTATE_VIEWONLY);
      AddConstant('SHCOLSTATE_BATCHREAD',SHCOLSTATE_BATCHREAD);
      AddConstant('SHCOLSTATE_NO_GROUPBY',SHCOLSTATE_NO_GROUPBY);
      AddConstant('SHCOLSTATE_FIXED_WIDTH',SHCOLSTATE_FIXED_WIDTH);
      AddConstant('SHCOLSTATE_NODPISCALE',SHCOLSTATE_NODPISCALE);
      AddConstant('SHCOLSTATE_FIXED_RATIO',SHCOLSTATE_FIXED_RATIO);
      AddConstant('SHCOLSTATE_DISPLAYMASK',SHCOLSTATE_DISPLAYMASK);
      AddConstant('SID_SUrlHistory',SID_SUrlHistory);
      AddConstant('SID_SWebBrowserEventsService',SID_SWebBrowserEventsService);
      AddConstant('PID_FINDDATA',PID_FINDDATA);
      AddConstant('PID_NETRESOURCE',PID_NETRESOURCE);
      AddConstant('PID_DESCRIPTIONID',PID_DESCRIPTIONID);
      AddConstant('PID_WHICHFOLDER',PID_WHICHFOLDER);
      AddConstant('PID_NETWORKLOCATION',PID_NETWORKLOCATION);
      AddConstant('PID_COMPUTERNAME',PID_COMPUTERNAME);
      AddConstant('PID_DISPLACED_FROM',PID_DISPLACED_FROM);
      AddConstant('PID_DISPLACED_DATE',PID_DISPLACED_DATE);
      AddConstant('PID_SYNC_COPY_IN',PID_SYNC_COPY_IN);
      AddConstant('PID_MISC_STATUS',PID_MISC_STATUS);
      AddConstant('PID_MISC_ACCESSCOUNT',PID_MISC_ACCESSCOUNT);
      AddConstant('PID_MISC_OWNER',PID_MISC_OWNER);
      AddConstant('PID_HTMLINFOTIPFILE',PID_HTMLINFOTIPFILE);
      AddConstant('PID_MISC_PICS',PID_MISC_PICS);
      AddConstant('PID_DISPLAY_PROPERTIES',PID_DISPLAY_PROPERTIES);
      AddConstant('PID_INTROTEXT',PID_INTROTEXT);
      AddConstant('PIDSI_ARTIST',PIDSI_ARTIST);
      AddConstant('PIDSI_SONGTITLE',PIDSI_SONGTITLE);
      AddConstant('PIDSI_ALBUM',PIDSI_ALBUM);
      AddConstant('PIDSI_YEAR',PIDSI_YEAR);
      AddConstant('PIDSI_COMMENT',PIDSI_COMMENT);
      AddConstant('PIDSI_TRACK',PIDSI_TRACK);
      AddConstant('PIDSI_GENRE',PIDSI_GENRE);
      AddConstant('PIDSI_LYRICS',PIDSI_LYRICS);
      AddConstant('PIDDRSI_PROTECTED',PIDDRSI_PROTECTED);
      AddConstant('PIDDRSI_DESCRIPTION',PIDDRSI_DESCRIPTION);
      AddConstant('PIDDRSI_PLAYCOUNT',PIDDRSI_PLAYCOUNT);
      AddConstant('PIDDRSI_PLAYSTARTS',PIDDRSI_PLAYSTARTS);
      AddConstant('PIDDRSI_PLAYEXPIRES',PIDDRSI_PLAYEXPIRES);
      AddConstant('PIDVSI_STREAM_NAME',PIDVSI_STREAM_NAME);
      AddConstant('PIDVSI_FRAME_WIDTH',PIDVSI_FRAME_WIDTH);
      AddConstant('PIDVSI_FRAME_HEIGHT',PIDVSI_FRAME_HEIGHT);
      AddConstant('PIDVSI_TIMELENGTH',PIDVSI_TIMELENGTH);
      AddConstant('PIDVSI_FRAME_COUNT',PIDVSI_FRAME_COUNT);
      AddConstant('PIDVSI_FRAME_RATE',PIDVSI_FRAME_RATE);
      AddConstant('PIDVSI_DATA_RATE',PIDVSI_DATA_RATE);
      AddConstant('PIDVSI_SAMPLE_SIZE',PIDVSI_SAMPLE_SIZE);
      AddConstant('PIDVSI_COMPRESSION',PIDVSI_COMPRESSION);
      AddConstant('PIDVSI_STREAM_NUMBER',PIDVSI_STREAM_NUMBER);
      AddConstant('PIDASI_FORMAT',PIDASI_FORMAT);
      AddConstant('PIDASI_TIMELENGTH',PIDASI_TIMELENGTH);
      AddConstant('PIDASI_AVG_DATA_RATE',PIDASI_AVG_DATA_RATE);
      AddConstant('PIDASI_SAMPLE_RATE',PIDASI_SAMPLE_RATE);
      AddConstant('PIDASI_SAMPLE_SIZE',PIDASI_SAMPLE_SIZE);
      AddConstant('PIDASI_CHANNEL_COUNT',PIDASI_CHANNEL_COUNT);
      AddConstant('PIDASI_STREAM_NUMBER',PIDASI_STREAM_NUMBER);
      AddConstant('PIDASI_STREAM_NAME',PIDASI_STREAM_NAME);
      AddConstant('PIDASI_COMPRESSION',PIDASI_COMPRESSION);
      AddConstant('PID_CONTROLPANEL_CATEGORY',PID_CONTROLPANEL_CATEGORY);
      AddConstant('PID_VOLUME_FREE',PID_VOLUME_FREE);
      AddConstant('PID_VOLUME_CAPACITY',PID_VOLUME_CAPACITY);
      AddConstant('PID_VOLUME_FILESYSTEM',PID_VOLUME_FILESYSTEM);
      AddConstant('PID_SHARE_CSC_STATUS',PID_SHARE_CSC_STATUS);
      AddConstant('PID_LINK_TARGET',PID_LINK_TARGET);
      AddConstant('PID_LINK_TARGET_TYPE',PID_LINK_TARGET_TYPE);
      AddConstant('PID_QUERY_RANK',PID_QUERY_RANK);
      AddConstant('SID_IPropertyStore',SID_IPropertyStore);
      AddConstant('SID_IPropertyDescriptionList',SID_IPropertyDescriptionList);
      AddConstant('GPS_DEFAULT',GPS_DEFAULT);
      AddConstant('GPS_HANDLERPROPERTIESONLY',GPS_HANDLERPROPERTIESONLY);
      AddConstant('GPS_READWRITE',GPS_READWRITE);
      AddConstant('GPS_TEMPORARY',GPS_TEMPORARY);
      AddConstant('GPS_FASTPROPERTIESONLY',GPS_FASTPROPERTIESONLY);
      AddConstant('GPS_OPENSLOWITEM',GPS_OPENSLOWITEM);
      AddConstant('GPS_DELAYCREATION',GPS_DELAYCREATION);
      AddConstant('GPS_BESTEFFORT',GPS_BESTEFFORT);
      AddConstant('GPS_MASK_VALID',GPS_MASK_VALID);
      AddConstant('SID_IContextMenu',SID_IContextMenu);
      AddConstant('SID_IContextMenu2',SID_IContextMenu2);
      AddConstant('SID_IContextMenu3',SID_IContextMenu3);
      AddConstant('SID_IExecuteCommand',SID_IExecuteCommand);
      AddConstant('SID_IPersistFolder',SID_IPersistFolder);
      AddConstant('SID_IRunnableTask',SID_IRunnableTask);
      AddConstant('SID_IShellTaskScheduler',SID_IShellTaskScheduler);
      AddConstant('SID_IQueryCodePage',SID_IQueryCodePage);
      AddConstant('SID_IPersistFolder2',SID_IPersistFolder2);
      AddConstant('SID_IPersistFolder3',SID_IPersistFolder3);
      AddConstant('SID_IPersistIDList',SID_IPersistIDList);
      AddConstant('SID_IEnumIDList',SID_IEnumIDList);
      AddConstant('SID_IEnumFullIDList',SID_IEnumFullIDList);
      AddConstant('SID_IObjectWithFolderEnumMode',SID_IObjectWithFolderEnumMode);
      AddConstant('SID_IParseAndCreateItem',SID_IParseAndCreateItem);
      AddConstant('SID_IShellFolder',SID_IShellFolder);
      AddConstant('SID_IEnumExtraSearch',SID_IEnumExtraSearch);
      AddConstant('SID_IShellFolder2',SID_IShellFolder2);
      AddConstant('SID_IFolderViewOptions',SID_IFolderViewOptions);
      AddConstant('SID_IShellView',SID_IShellView);
      AddConstant('SID_IShellView2',SID_IShellView2);
      AddConstant('SID_IShellView3',SID_IShellView3);
      AddConstant('SID_IFolderView',SID_IFolderView);
      AddConstant('SID_ISearchBoxInfo',SID_ISearchBoxInfo);
      AddConstant('SID_IFolderView2',SID_IFolderView2);
      AddConstant('SID_IFolderViewSettings',SID_IFolderViewSettings);
      AddConstant('SID_IPreviewHandlerVisuals',SID_IPreviewHandlerVisuals);
      AddConstant('SID_IVisualProperties',SID_IVisualProperties);
      AddConstant('SID_ICommDlgBrowser',SID_ICommDlgBrowser);
      AddConstant('SID_ICommDlgBrowser2',SID_ICommDlgBrowser2);
      AddConstant('SID_ICommDlgBrowser3',SID_ICommDlgBrowser3);
      AddConstant('SID_IColumnManager',SID_IColumnManager);
      AddConstant('SID_IFolderFilterSite',SID_IFolderFilterSite);
      AddConstant('SID_IFolderFilter',SID_IFolderFilter);
      AddConstant('SID_IInputObjectSite',SID_IInputObjectSite);
      AddConstant('SID_IInputObject',SID_IInputObject);
      AddConstant('SID_IInputObject2',SID_IInputObject2);
      AddConstant('SID_IShellIcon',SID_IShellIcon);
      AddConstant('SID_IShellBrowser',SID_IShellBrowser);
      AddConstant('SID_IProfferService',SID_IProfferService);
      AddConstant('SID_IShellItem',SID_IShellItem);
      AddConstant('SID_IShellItem2',SID_IShellItem2);
      AddConstant('SID_IShellItemImageFactory',SID_IShellItemImageFactory);
      AddConstant('SID_IUserAccountChangeCallback',SID_IUserAccountChangeCallback);
      AddConstant('SID_IEnumShellItems',SID_IEnumShellItems);
      AddConstant('SID_ITransferAdviseSink',SID_ITransferAdviseSink);
      AddConstant('SID_ITransferSource',SID_ITransferSource);
      AddConstant('SID_IEnumResources',SID_IEnumResources);
      AddConstant('SID_IShellItemResources',SID_IShellItemResources);
      AddConstant('SID_ITransferDestination',SID_ITransferDestination);
      AddConstant('SID_IStreamAsync',SID_IStreamAsync);
      AddConstant('SID_IStreamUnbufferedInfo',SID_IStreamUnbufferedInfo);
      AddConstant('SID_IFileOperationProgressSink',SID_IFileOperationProgressSink);
      AddConstant('SID_IShellItemArray',SID_IShellItemArray);
      AddConstant('SID_IInitializeWithItem',SID_IInitializeWithItem);
      AddConstant('SID_IObjectWithSelection',SID_IObjectWithSelection);
      AddConstant('SID_IObjectWithBackReferences',SID_IObjectWithBackReferences);
      AddConstant('SID_IPropertyUI',SID_IPropertyUI);
      AddConstant('SID_ICategoryProvider',SID_ICategoryProvider);
      AddConstant('SID_ICategorizer',SID_ICategorizer);
      AddConstant('SID_IDropTargetHelper',SID_IDropTargetHelper);
      AddConstant('SID_IDragSourceHelper',SID_IDragSourceHelper);
      AddConstant('SID_IDragSourceHelper2',SID_IDragSourceHelper2);
      AddConstant('SID_IShellLinkA',SID_IShellLinkA);
      AddConstant('SID_IShellLinkW',SID_IShellLinkW);
      AddConstant('SID_IShellLinkDataList',SID_IShellLinkDataList);
      AddConstant('SID_IResolveShellLink',SID_IResolveShellLink);
      AddConstant('SID_IActionProgressDialog',SID_IActionProgressDialog);
      AddConstant('SID_IHWEventHandler',SID_IHWEventHandler);
      AddConstant('SID_IHWEventHandler2',SID_IHWEventHandler2);
      AddConstant('SID_IQueryCancelAutoPlay',SID_IQueryCancelAutoPlay);
      AddConstant('SID_IDynamicHWHandler',SID_IDynamicHWHandler);
      AddConstant('SID_IActionProgress',SID_IActionProgress);
      AddConstant('SID_IShellExtInit',SID_IShellExtInit);
      AddConstant('SID_IShellPropSheetExt',SID_IShellPropSheetExt);
      AddConstant('SID_IRemoteComputer',SID_IRemoteComputer);
      AddConstant('SID_IQueryContinue',SID_IQueryContinue);
      AddConstant('SID_IObjectWithCancelEvent',SID_IObjectWithCancelEvent);
      AddConstant('SID_IUserNotification',SID_IUserNotification);
      AddConstant('SID_IUserNotificationCallback',SID_IUserNotificationCallback);
      AddConstant('SID_IUserNotification2',SID_IUserNotification2);
      AddConstant('SID_IItemNameLimits',SID_IItemNameLimits);
      AddConstant('SID_ISearchFolderItemFactory',SID_ISearchFolderItemFactory);
      AddConstant('SID_IExtractImage',SID_IExtractImage);
      AddConstant('SID_IExtractImage2',SID_IExtractImage2);
      AddConstant('SID_IThumbnailHandlerFactory',SID_IThumbnailHandlerFactory);
      AddConstant('SID_IParentAndItem',SID_IParentAndItem);
      AddConstant('SID_IDockingWindow',SID_IDockingWindow);
      AddConstant('SID_IDeskBand',SID_IDeskBand);
      AddConstant('SID_IDeskBandInfo',SID_IDeskBandInfo);
      AddConstant('SID_IDeskBand2',SID_IDeskBand2);
      AddConstant('SID_ITaskbarList',SID_ITaskbarList);
      AddConstant('SID_ITaskbarList2',SID_ITaskbarList2);
      AddConstant('SID_ITaskbarList3',SID_ITaskbarList3);
      AddConstant('SID_ITaskbarList4',SID_ITaskbarList4);
      AddConstant('SID_IStartMenuPinnedList',SID_IStartMenuPinnedList);
      AddConstant('SID_ICDBurn',SID_ICDBurn);
      AddConstant('SID_IWizardSite',SID_IWizardSite);
      AddConstant('SID_IWizardExtension',SID_IWizardExtension);
      AddConstant('SID_IWebWizardExtension',SID_IWebWizardExtension);
      AddConstant('SID_IPublishingWizard',SID_IPublishingWizard);
      AddConstant('SID_IFolderViewHost',SID_IFolderViewHost);
      AddConstant('SID_IExplorerBrowserEvents',SID_IExplorerBrowserEvents);
      AddConstant('SID_IExplorerBrowser',SID_IExplorerBrowser);
      AddConstant('SID_IAccessibleObject',SID_IAccessibleObject);
      AddConstant('SID_IResultsFolder',SID_IResultsFolder);
      AddConstant('SID_IEnumObjects',SID_IEnumObjects);
      AddConstant('SID_IOperationsProgressDialog',SID_IOperationsProgressDialog);
      AddConstant('SID_IIOCancelInformation',SID_IIOCancelInformation);
      AddConstant('SID_IFileOperation',SID_IFileOperation);
      AddConstant('SID_IObjectProvider',SID_IObjectProvider);
      AddConstant('SID_INamespaceWalkCB',SID_INamespaceWalkCB);
      AddConstant('SID_INamespaceWalkCB2',SID_INamespaceWalkCB2);
      AddConstant('SID_INamespaceWalk',SID_INamespaceWalk);
      AddConstant('SID_IAutoCompleteDropDown',SID_IAutoCompleteDropDown);
      AddConstant('SID_IBandSite',SID_IBandSite);
      AddConstant('SID_IModalWindow',SID_IModalWindow);
      AddConstant('SID_ICDBurnExt',SID_ICDBurnExt);
      AddConstant('SID_IContextMenuSite',SID_IContextMenuSite);
      AddConstant('SID_IEnumReadyCallback',SID_IEnumReadyCallback);
      AddConstant('SID_IEnumerableView',SID_IEnumerableView);
      AddConstant('SID_IInsertItem',SID_IInsertItem);
      AddConstant('SID_IMenuBand',SID_IMenuBand);
      AddConstant('SID_IFolderBandPriv',SID_IFolderBandPriv);
      AddConstant('SID_IRegTreeItem',SID_IRegTreeItem);
      AddConstant('SID_IImageRecompress',SID_IImageRecompress);
      AddConstant('SID_IDeskBar',SID_IDeskBar);
      AddConstant('SID_IMenuPopup',SID_IMenuPopup);
      AddConstant('SID_IFileIsInUse',SID_IFileIsInUse);
      AddConstant('SID_IFileDialogEvents',SID_IFileDialogEvents);
      AddConstant('SID_IFileDialog',SID_IFileDialog);
      AddConstant('SID_IFileSaveDialog',SID_IFileSaveDialog);
      AddConstant('SID_IFileOpenDialog',SID_IFileOpenDialog);
      AddConstant('SID_IFileDialogCustomize',SID_IFileDialogCustomize);
      AddConstant('SID_IFileDialogControlEvents',SID_IFileDialogControlEvents);
      AddConstant('SID_IFileDialog2',SID_IFileDialog2);
      AddConstant('SID_IApplicationAssociationRegistration',SID_IApplicationAssociationRegistration);
      AddConstant('SID_IApplicationAssociationRegistrationUI',SID_IApplicationAssociationRegistrationUI);
      AddConstant('SID_IDelegateFolder',SID_IDelegateFolder);
      AddConstant('SID_IBrowserFrameOptions',SID_IBrowserFrameOptions);
      AddConstant('SID_INewWindowManager',SID_INewWindowManager);
      AddConstant('SID_IAttachmentExecute',SID_IAttachmentExecute);
      AddConstant('SID_IShellMenuCallback',SID_IShellMenuCallback);
      AddConstant('SID_IShellMenu',SID_IShellMenu);
      AddConstant('SID_IShellRunDll',SID_IShellRunDll);
      AddConstant('SID_IKnownFolder',SID_IKnownFolder);
      AddConstant('SID_IKnownFolderManager',SID_IKnownFolderManager);
      AddConstant('SID_ISharingConfigurationManager',SID_ISharingConfigurationManager);
      AddConstant('SID_IPreviousVersionsInfo',SID_IPreviousVersionsInfo);
      AddConstant('SID_IRelatedItem',SID_IRelatedItem);
      AddConstant('SID_IIdentityName',SID_IIdentityName);
      AddConstant('SID_IDelegateItem',SID_IDelegateItem);
      AddConstant('SID_ICurrentItem',SID_ICurrentItem);
      AddConstant('SID_ITransferMediumItem',SID_ITransferMediumItem);
      AddConstant('SID_IUseToBrowseItem',SID_IUseToBrowseItem);
      AddConstant('SID_IDisplayItem',SID_IDisplayItem);
      AddConstant('SID_IViewStateIdentityItem',SID_IViewStateIdentityItem);
      AddConstant('SID_IPreviewItem',SID_IPreviewItem);
      AddConstant('SID_IDestinationStreamFactory',SID_IDestinationStreamFactory);
      AddConstant('SID_INewMenuClient',SID_INewMenuClient);
      AddConstant('SID_IInitializeWithBindCtx',SID_IInitializeWithBindCtx);
      AddConstant('SID_IShellItemFilter',SID_IShellItemFilter);
      AddConstant('SID_INameSpaceTreeControl',SID_INameSpaceTreeControl);
      AddConstant('SID_INameSpaceTreeControl2',SID_INameSpaceTreeControl2);
      AddConstant('SID_INameSpaceTreeControlEvents',SID_INameSpaceTreeControlEvents);
      AddConstant('SID_INameSpaceTreeControlDropHandler',SID_INameSpaceTreeControlDropHandler);
      AddConstant('SID_INameSpaceTreeAccessible',SID_INameSpaceTreeAccessible);
      AddConstant('SID_INameSpaceTreeControlCustomDraw',SID_INameSpaceTreeControlCustomDraw);
      AddConstant('SID_INameSpaceTreeControlFolderCapabilities',SID_INameSpaceTreeControlFolderCapabilities);
      AddConstant('SID_IPreviewHandler',SID_IPreviewHandler);
      AddConstant('SID_IPreviewHandlerFrame',SID_IPreviewHandlerFrame);
      AddConstant('SID_ITrayDeskBand',SID_ITrayDeskBand);
      AddConstant('SID_IBandHost',SID_IBandHost);
      AddConstant('SID_IExplorerPaneVisibility',SID_IExplorerPaneVisibility);
      AddConstant('SID_IContextMenuCB',SID_IContextMenuCB);
      AddConstant('SID_IDefaultExtractIconInit',SID_IDefaultExtractIconInit);
      AddConstant('SID_IExplorerCommand',SID_IExplorerCommand);
      AddConstant('SID_IExplorerCommandState',SID_IExplorerCommandState);
      AddConstant('SID_IInitializeCommand',SID_IInitializeCommand);
      AddConstant('SID_IEnumExplorerCommand',SID_IEnumExplorerCommand);
      AddConstant('SID_IExplorerCommandProvider',SID_IExplorerCommandProvider);
      AddConstant('SID_IMarkupCallback',SID_IMarkupCallback);
      AddConstant('SID_IControlMarkup',SID_IControlMarkup);
      AddConstant('SID_IInitializeNetworkFolder',SID_IInitializeNetworkFolder);
      AddConstant('SID_IOpenControlPanel',SID_IOpenControlPanel);
      AddConstant('SID_IComputerInfoChangeNotify',SID_IComputerInfoChangeNotify);
      AddConstant('SID_IFileSystemBindData',SID_IFileSystemBindData);
      AddConstant('SID_IFileSystemBindData2',SID_IFileSystemBindData2);
      AddConstant('SID_ICustomDestinationList',SID_ICustomDestinationList);
      AddConstant('SID_IApplicationDestinations',SID_IApplicationDestinations);
      AddConstant('SID_IApplicationDocumentLists',SID_IApplicationDocumentLists);
      AddConstant('SID_IObjectWithAppUserModelID',SID_IObjectWithAppUserModelID);
      AddConstant('SID_IObjectWithProgID',SID_IObjectWithProgID);
      AddConstant('SID_IUpdateIDList',SID_IUpdateIDList);
      AddConstant('SID_IDesktopGadget',SID_IDesktopGadget);
      AddConstant('SID_IHomeGroup',SID_IHomeGroup);
      AddConstant('SID_IInitializeWithPropertyStore',SID_IInitializeWithPropertyStore);
      AddConstant('SID_IOpenSearchSource',SID_IOpenSearchSource);
      AddConstant('SID_IShellLibrary',SID_IShellLibrary);
      AddConstant('SID_IAssocHandlerInvoker',SID_IAssocHandlerInvoker);
      AddConstant('SID_IAssocHandler',SID_IAssocHandler);
      AddConstant('SID_IEnumAssocHandlers',SID_IEnumAssocHandlers);
      AddConstant('CMF_NORMAL',CMF_NORMAL);
      AddConstant('CMF_DEFAULTONLY',CMF_DEFAULTONLY);
      AddConstant('CMF_VERBSONLY',CMF_VERBSONLY);
      AddConstant('CMF_EXPLORE',CMF_EXPLORE);
      AddConstant('CMF_NOVERBS',CMF_NOVERBS);
      AddConstant('CMF_CANRENAME',CMF_CANRENAME);
      AddConstant('CMF_NODEFAULT',CMF_NODEFAULT);
      AddConstant('CMF_INCLUDESTATIC',CMF_INCLUDESTATIC);
      AddConstant('CMF_ITEMMENU',CMF_ITEMMENU);
      AddConstant('CMF_EXTENDEDVERBS',CMF_EXTENDEDVERBS);
      AddConstant('CMF_DISABLEDVERBS',CMF_DISABLEDVERBS);
      AddConstant('CMF_ASYNCVERBSTATE',CMF_ASYNCVERBSTATE);
      AddConstant('CMF_OPTIMIZEFORINVOKE',CMF_OPTIMIZEFORINVOKE);
      AddConstant('CMF_SYNCCASCADEMENU',CMF_SYNCCASCADEMENU);
      AddConstant('CMF_DONOTPICKDEFAULT',CMF_DONOTPICKDEFAULT);
      AddConstant('CMF_RESERVED',CMF_RESERVED);
      AddConstant('GCS_VERBA',GCS_VERBA);
      AddConstant('GCS_HELPTEXTA',GCS_HELPTEXTA);
      AddConstant('GCS_VALIDATEA',GCS_VALIDATEA);
      AddConstant('GCS_VERBW',GCS_VERBW);
      AddConstant('GCS_HELPTEXTW',GCS_HELPTEXTW);
      AddConstant('GCS_VALIDATEW',GCS_VALIDATEW);
      AddConstant('GCS_VERBICONW',GCS_VERBICONW);
      AddConstant('GCS_UNICODE',GCS_UNICODE);
      AddConstant('GCS_VERB',GCS_VERB);
      AddConstant('GCS_HELPTEXT',GCS_HELPTEXT);
      AddConstant('GCS_VALIDATE',GCS_VALIDATE);
      AddConstant('CMDSTR_NEWFOLDERA',CMDSTR_NEWFOLDERA);
      AddConstant('CMDSTR_VIEWLISTA',CMDSTR_VIEWLISTA);
      AddConstant('CMDSTR_VIEWDETAILSA',CMDSTR_VIEWDETAILSA);
      AddConstant('CMDSTR_NEWFOLDERW',CMDSTR_NEWFOLDERW);
      AddConstant('CMDSTR_VIEWLISTW',CMDSTR_VIEWLISTW);
      AddConstant('CMDSTR_VIEWDETAILSW',CMDSTR_VIEWDETAILSW);
      AddConstant('CMDSTR_NEWFOLDER',CMDSTR_NEWFOLDER);
      AddConstant('CMDSTR_VIEWLIST',CMDSTR_VIEWLIST);
      AddConstant('CMDSTR_VIEWDETAILS',CMDSTR_VIEWDETAILS);
      AddConstant('CMIC_MASK_HOTKEY',CMIC_MASK_HOTKEY);
      AddConstant('CMIC_MASK_ICON',CMIC_MASK_ICON);
      AddConstant('CMIC_MASK_FLAG_NO_UI',CMIC_MASK_FLAG_NO_UI);
      AddConstant('CMIC_MASK_UNICODE',CMIC_MASK_UNICODE);
      AddConstant('CMIC_MASK_NO_CONSOLE',CMIC_MASK_NO_CONSOLE);
      AddConstant('CMIC_MASK_ASYNCOK',CMIC_MASK_ASYNCOK);
      AddConstant('CMIC_MASK_NOASYNC',CMIC_MASK_NOASYNC);
      AddConstant('CMIC_MASK_SHIFT_DOWN',CMIC_MASK_SHIFT_DOWN);
      AddConstant('CMIC_MASK_CONTROL_DOWN',CMIC_MASK_CONTROL_DOWN);
      AddConstant('CMIC_MASK_FLAG_LOG_USAGE',CMIC_MASK_FLAG_LOG_USAGE);
      AddConstant('CMIC_MASK_NOZONECHECKS',CMIC_MASK_NOZONECHECKS);
      AddConstant('CMIC_MASK_PTINVOKE',CMIC_MASK_PTINVOKE);
      AddConstant('IRTIR_TASK_NOT_RUNNING',IRTIR_TASK_NOT_RUNNING);
      AddConstant('IRTIR_TASK_RUNNING',IRTIR_TASK_RUNNING);
      AddConstant('IRTIR_TASK_SUSPENDED',IRTIR_TASK_SUSPENDED);
      AddConstant('IRTIR_TASK_PENDING',IRTIR_TASK_PENDING);
      AddConstant('IRTIR_TASK_FINISHED',IRTIR_TASK_FINISHED);
      AddConstant('ITSAT_DEFAULT_LPARAM',ITSAT_DEFAULT_LPARAM);
      AddConstant('ITSAT_DEFAULT_PRIORITY',ITSAT_DEFAULT_PRIORITY);
      AddConstant('ITSAT_MAX_PRIORITY',ITSAT_MAX_PRIORITY);
      AddConstant('ITSAT_MIN_PRIORITY',ITSAT_MIN_PRIORITY);
      AddConstant('ITSSFLAG_COMPLETE_ON_DESTROY',ITSSFLAG_COMPLETE_ON_DESTROY);
      AddConstant('ITSSFLAG_KILL_ON_DESTROY',ITSSFLAG_KILL_ON_DESTROY);
      AddConstant('ITSSFLAG_FLAGS_MASK',ITSSFLAG_FLAGS_MASK);
      AddConstant('ITSS_THREAD_DESTROY_DEFAULT_TIMEOUT',ITSS_THREAD_DESTROY_DEFAULT_TIMEOUT);
      AddConstant('ITSS_THREAD_TERMINATE_TIMEOUT',ITSS_THREAD_TERMINATE_TIMEOUT);
      AddConstant('ITSS_THREAD_TIMEOUT_NO_CHANGE',ITSS_THREAD_TIMEOUT_NO_CHANGE);
      AddConstant('CSIDL_FLAG_PFTI_TRACKTARGET',CSIDL_FLAG_PFTI_TRACKTARGET);
      AddConstant('SHGDN_NORMAL',SHGDN_NORMAL);
      AddConstant('SHGDN_INFOLDER',SHGDN_INFOLDER);
      AddConstant('SHGDN_FOREDITING',SHGDN_FOREDITING);
      AddConstant('SHGDN_INCLUDE_NONFILESYS',SHGDN_INCLUDE_NONFILESYS);
      AddConstant('SHGDN_FORADDRESSBAR',SHGDN_FORADDRESSBAR);
      AddConstant('SHGDN_FORPARSING',SHGDN_FORPARSING);
      AddConstant('SHCONTF_CHECKING_FOR_CHILDREN',SHCONTF_CHECKING_FOR_CHILDREN);
      AddConstant('SHCONTF_FOLDERS',SHCONTF_FOLDERS);
      AddConstant('SHCONTF_NONFOLDERS',SHCONTF_NONFOLDERS);
      AddConstant('SHCONTF_INCLUDEHIDDEN',SHCONTF_INCLUDEHIDDEN);
      AddConstant('SHCONTF_INIT_ON_FIRST_NEXT',SHCONTF_INIT_ON_FIRST_NEXT);
      AddConstant('SHCONTF_NETPRINTERSRCH',SHCONTF_NETPRINTERSRCH);
      AddConstant('SHCONTF_SHAREABLE',SHCONTF_SHAREABLE);
      AddConstant('SHCONTF_STORAGE',SHCONTF_STORAGE);
      AddConstant('SHCONTF_NAVIGATION_ENUM',SHCONTF_NAVIGATION_ENUM);
      AddConstant('SHCONTF_FASTITEMS',SHCONTF_FASTITEMS);
      AddConstant('SHCONTF_FLATLIST',SHCONTF_FLATLIST);
      AddConstant('SHCONTF_ENABLE_ASYNC',SHCONTF_ENABLE_ASYNC);
      AddConstant('SHCONTF_ENABLE_INCLUDESUPERHIDDEN',SHCONTF_ENABLE_INCLUDESUPERHIDDEN);
      AddConstant('SHCIDS_ALLFIELDS',SHCIDS_ALLFIELDS);
      AddConstant('SHCIDS_CANONICALONLY',SHCIDS_CANONICALONLY);
      AddConstant('SHCIDS_BITMASK',SHCIDS_BITMASK);
      AddConstant('SHCIDS_COLUMNMASK',SHCIDS_COLUMNMASK);
      AddConstant('SFGAO_CANCOPY',SFGAO_CANCOPY);
      AddConstant('SFGAO_CANMOVE',SFGAO_CANMOVE);
      AddConstant('SFGAO_CANLINK',SFGAO_CANLINK);
      AddConstant('SFGAO_STORAGE',SFGAO_STORAGE);
      AddConstant('SFGAO_CANRENAME',SFGAO_CANRENAME);
      AddConstant('SFGAO_CANDELETE',SFGAO_CANDELETE);
      AddConstant('SFGAO_HASPROPSHEET',SFGAO_HASPROPSHEET);
      AddConstant('SFGAO_DROPTARGET',SFGAO_DROPTARGET);
      AddConstant('SFGAO_CAPABILITYMASK',SFGAO_CAPABILITYMASK);
      AddConstant('SFGAO_SYSTEM',SFGAO_SYSTEM);
      AddConstant('SFGAO_ENCRYPTED',SFGAO_ENCRYPTED);
      AddConstant('SFGAO_ISSLOW',SFGAO_ISSLOW);
      AddConstant('SFGAO_GHOSTED',SFGAO_GHOSTED);
      AddConstant('SFGAO_LINK',SFGAO_LINK);
      AddConstant('SFGAO_SHARE',SFGAO_SHARE);
      AddConstant('SFGAO_READONLY',SFGAO_READONLY);
      AddConstant('SFGAO_HIDDEN',SFGAO_HIDDEN);
      AddConstant('SFGAO_DISPLAYATTRMASK',SFGAO_DISPLAYATTRMASK);
      AddConstant('SFGAO_FILESYSANCESTOR',SFGAO_FILESYSANCESTOR);
      AddConstant('SFGAO_FOLDER',SFGAO_FOLDER);
      AddConstant('SFGAO_FILESYSTEM',SFGAO_FILESYSTEM);
      AddConstant('SFGAO_HASSUBFOLDER',SFGAO_HASSUBFOLDER);
      AddConstant('SFGAO_CONTENTSMASK',SFGAO_CONTENTSMASK);
      AddConstant('SFGAO_VALIDATE',SFGAO_VALIDATE);
      AddConstant('SFGAO_REMOVABLE',SFGAO_REMOVABLE);
      AddConstant('SFGAO_COMPRESSED',SFGAO_COMPRESSED);
      AddConstant('SFGAO_BROWSABLE',SFGAO_BROWSABLE);
      AddConstant('SFGAO_NONENUMERATED',SFGAO_NONENUMERATED);
      AddConstant('SFGAO_NEWCONTENT',SFGAO_NEWCONTENT);
      AddConstant('SFGAO_CANMONIKER',SFGAO_CANMONIKER);
      AddConstant('SFGAO_HASSTORAGE',SFGAO_HASSTORAGE);
      AddConstant('SFGAO_STREAM',SFGAO_STREAM);
      AddConstant('SFGAO_STORAGEANCESTOR',SFGAO_STORAGEANCESTOR);
      AddConstant('SFGAO_STORAGECAPMASK',SFGAO_STORAGECAPMASK);
      AddConstant('SFGAO_PKEYSFGAOMASK',SFGAO_PKEYSFGAOMASK);
      AddConstant('STR_BIND_FORCE_FOLDER_SHORTCUT_RESOLVE',STR_BIND_FORCE_FOLDER_SHORTCUT_RESOLVE);
      AddConstant('STR_AVOID_DRIVE_RESTRICTION_POLICY',STR_AVOID_DRIVE_RESTRICTION_POLICY);
      AddConstant('STR_SKIP_BINDING_CLSID',STR_SKIP_BINDING_CLSID);
      AddConstant('STR_PARSE_PREFER_FOLDER_BROWSING',STR_PARSE_PREFER_FOLDER_BROWSING);
      AddConstant('STR_DONT_PARSE_RELATIVE',STR_DONT_PARSE_RELATIVE);
      AddConstant('STR_PARSE_TRANSLATE_ALIASES',STR_PARSE_TRANSLATE_ALIASES);
      AddConstant('STR_PARSE_SKIP_NET_CACHE',STR_PARSE_SKIP_NET_CACHE);
      AddConstant('STR_PARSE_SHELL_PROTOCOL_TO_FILE_OBJECTS',STR_PARSE_SHELL_PROTOCOL_TO_FILE_OBJECTS);
      AddConstant('STR_TRACK_CLSID',STR_TRACK_CLSID);
      AddConstant('STR_INTERNAL_NAVIGATE',STR_INTERNAL_NAVIGATE);
      AddConstant('STR_PARSE_PROPERTYSTORE',STR_PARSE_PROPERTYSTORE);
      AddConstant('STR_NO_VALIDATE_FILENAME_CHARS',STR_NO_VALIDATE_FILENAME_CHARS);
      AddConstant('STR_BIND_DELEGATE_CREATE_OBJECT',STR_BIND_DELEGATE_CREATE_OBJECT);
      AddConstant('STR_PARSE_ALLOW_INTERNET_SHELL_FOLDERS',STR_PARSE_ALLOW_INTERNET_SHELL_FOLDERS);
      AddConstant('STR_PARSE_PREFER_WEB_BROWSING',STR_PARSE_PREFER_WEB_BROWSING);
      AddConstant('STR_PARSE_SHOW_NET_DIAGNOSTICS_UI',STR_PARSE_SHOW_NET_DIAGNOSTICS_UI);
      AddConstant('STR_PARSE_DONT_REQUIRE_VALIDATED_URLS',STR_PARSE_DONT_REQUIRE_VALIDATED_URLS);
      AddConstant('STR_INTERNETFOLDER_PARSE_ONLY_URLMON_BINDABLE',STR_INTERNETFOLDER_PARSE_ONLY_URLMON_BINDABLE);
      AddConstant('STR_BIND_FOLDERS_READ_ONLY',STR_BIND_FOLDERS_READ_ONLY);
      AddConstant('STR_BIND_FOLDER_ENUM_MODE',STR_BIND_FOLDER_ENUM_MODE);
      AddConstant('STR_DONT_RESOLVE_LINK',STR_DONT_RESOLVE_LINK);
      AddConstant('STR_GET_ASYNC_HANDLER',STR_GET_ASYNC_HANDLER);
      AddConstant('SIGDN_NORMALDISPLAY',SIGDN_NORMALDISPLAY);
      AddConstant('SIGDN_PARENTRELATIVEPARSING',SIGDN_PARENTRELATIVEPARSING);
      AddConstant('SIGDN_DESKTOPABSOLUTEPARSING',SIGDN_DESKTOPABSOLUTEPARSING);
      AddConstant('SIGDN_PARENTRELATIVEEDITING',SIGDN_PARENTRELATIVEEDITING);
      AddConstant('SIGDN_DESKTOPABSOLUTEEDITING',SIGDN_DESKTOPABSOLUTEEDITING);
      AddConstant('SIGDN_FILESYSPATH',SIGDN_FILESYSPATH);
      AddConstant('SIGDN_URL',SIGDN_URL);
      AddConstant('SIGDN_PARENTRELATIVEFORADDRESSBAR',SIGDN_PARENTRELATIVEFORADDRESSBAR);
      AddConstant('SIGDN_PARENTRELATIVE',SIGDN_PARENTRELATIVE);
      AddConstant('SICHINT_DISPLAY',SICHINT_DISPLAY);
      AddConstant('SICHINT_ALLFIELDS',SICHINT_ALLFIELDS);
      AddConstant('SICHINT_CANONICAL',SICHINT_CANONICAL);
      AddConstant('SICHINT_TEST_FILESYSPATH_IF_NOT_EQUAL',SICHINT_TEST_FILESYSPATH_IF_NOT_EQUAL);
      AddConstant('FEM_VIEWRESULT',FEM_VIEWRESULT);
      AddConstant('FEM_NAVIGATION',FEM_NAVIGATION);
      AddConstant('STR_PARSE_WITH_EXPLICIT_PROGID',STR_PARSE_WITH_EXPLICIT_PROGID);
      AddConstant('STR_PARSE_WITH_EXPLICIT_ASSOCAPP',STR_PARSE_WITH_EXPLICIT_ASSOCAPP);
      AddConstant('STR_PARSE_EXPLICIT_ASSOCIATION_SUCCESSFUL',STR_PARSE_EXPLICIT_ASSOCIATION_SUCCESSFUL);
      AddConstant('STR_PARSE_AND_CREATE_ITEM',STR_PARSE_AND_CREATE_ITEM);
      AddConstant('STR_ITEM_CACHE_CONTEXT',STR_ITEM_CACHE_CONTEXT);
      AddConstant('FWF_NONE',FWF_NONE);
      AddConstant('FWF_AUTOARRANGE',FWF_AUTOARRANGE);
      AddConstant('FWF_ABBREVIATEDNAMES',FWF_ABBREVIATEDNAMES);
      AddConstant('FWF_SNAPTOGRID',FWF_SNAPTOGRID);
      AddConstant('FWF_OWNERDATA',FWF_OWNERDATA);
      AddConstant('FWF_BESTFITWINDOW',FWF_BESTFITWINDOW);
      AddConstant('FWF_DESKTOP',FWF_DESKTOP);
      AddConstant('FWF_SINGLESEL',FWF_SINGLESEL);
      AddConstant('FWF_NOSUBFOLDERS',FWF_NOSUBFOLDERS);
      AddConstant('FWF_TRANSPARENT',FWF_TRANSPARENT);
      AddConstant('FWF_NOCLIENTEDGE',FWF_NOCLIENTEDGE);
      AddConstant('FWF_NOSCROLL',FWF_NOSCROLL);
      AddConstant('FWF_ALIGNLEFT',FWF_ALIGNLEFT);
      AddConstant('FWF_NOICONS',FWF_NOICONS);
      AddConstant('FWF_SHOWSELALWAYS',FWF_SHOWSELALWAYS);
      AddConstant('FWF_NOVISIBLE',FWF_NOVISIBLE);
      AddConstant('FWF_SINGLECLICKACTIVATE',FWF_SINGLECLICKACTIVATE);
      AddConstant('FWF_NOWEBVIEW',FWF_NOWEBVIEW);
      AddConstant('FWF_HIDEFILENAMES',FWF_HIDEFILENAMES);
      AddConstant('FWF_CHECKSELECT',FWF_CHECKSELECT);
      AddConstant('FWF_NOENUMREFRESH',FWF_NOENUMREFRESH);
      AddConstant('FWF_NOGROUPING',FWF_NOGROUPING);
      AddConstant('FWF_FULLROWSELECT',FWF_FULLROWSELECT);
      AddConstant('FWF_NOFILTERS',FWF_NOFILTERS);
      AddConstant('FWF_NOCOLUMNHEADER',FWF_NOCOLUMNHEADER);
      AddConstant('FWF_NOHEADERINALLVIEWS',FWF_NOHEADERINALLVIEWS);
      AddConstant('FWF_EXTENDEDTILES',FWF_EXTENDEDTILES);
      AddConstant('FWF_TRICHECKSELECT',FWF_TRICHECKSELECT);
      AddConstant('FWF_AUTOCHECKSELECT',FWF_AUTOCHECKSELECT);
      AddConstant('FWF_NOBROWSERVIEWSTATE',FWF_NOBROWSERVIEWSTATE);
      AddConstant('FWF_SUBSETGROUPS',FWF_SUBSETGROUPS);
      AddConstant('FWF_USESEARCHFOLDER',FWF_USESEARCHFOLDER);
      AddConstant('FWF_ALLOWRTLREADING',FWF_ALLOWRTLREADING);
      AddConstant('FVM_AUTO',FVM_AUTO);
      AddConstant('FVM_FIRST',FVM_FIRST);
      AddConstant('FVM_ICON',FVM_ICON);
      AddConstant('FVM_SMALLICON',FVM_SMALLICON);
      AddConstant('FVM_LIST',FVM_LIST);
      AddConstant('FVM_DETAILS',FVM_DETAILS);
      AddConstant('FVM_THUMBNAIL',FVM_THUMBNAIL);
      AddConstant('FVM_TILE',FVM_TILE);
      AddConstant('FVM_THUMBSTRIP',FVM_THUMBSTRIP);
      AddConstant('FVM_CONTENT',FVM_CONTENT);
      AddConstant('FVM_LAST',FVM_LAST);
      AddConstant('FLVM_UNSPECIFIED',FLVM_UNSPECIFIED);
      AddConstant('FLVM_FIRST',FLVM_FIRST);
      AddConstant('FLVM_DETAILS',FLVM_DETAILS);
      AddConstant('FLVM_TILES',FLVM_TILES);
      AddConstant('FLVM_ICONS',FLVM_ICONS);
      AddConstant('FLVM_LIST',FLVM_LIST);
      AddConstant('FLVM_CONTENT',FLVM_CONTENT);
      AddConstant('FLVM_LAST',FLVM_LAST);
      AddConstant('FVO_DEFAULT',FVO_DEFAULT);
      AddConstant('FVO_VISTALAYOUT',FVO_VISTALAYOUT);
      AddConstant('FVO_CUSTOMPOSITION',FVO_CUSTOMPOSITION);
      AddConstant('FVO_CUSTOMORDERING',FVO_CUSTOMORDERING);
      AddConstant('FVO_SUPPORTHYPERLINKS',FVO_SUPPORTHYPERLINKS);
      AddConstant('FVO_NOANIMATIONS',FVO_NOANIMATIONS);
      AddConstant('FVO_NOSCROLLTIPS',FVO_NOSCROLLTIPS);
      AddConstant('SVSI_DESELECT',SVSI_DESELECT);
      AddConstant('SVSI_SELECT',SVSI_SELECT);
      AddConstant('SVSI_EDIT',SVSI_EDIT);
      AddConstant('SVSI_DESELECTOTHERS',SVSI_DESELECTOTHERS);
      AddConstant('SVSI_ENSUREVISIBLE',SVSI_ENSUREVISIBLE);
      AddConstant('SVSI_FOCUSED',SVSI_FOCUSED);
      AddConstant('SVSI_TRANSLATEPT',SVSI_TRANSLATEPT);
      AddConstant('SVSI_SELECTIONMARK',SVSI_SELECTIONMARK);
      AddConstant('SVSI_POSITIONITEM',SVSI_POSITIONITEM);
      AddConstant('SVSI_CHECK',SVSI_CHECK);
      AddConstant('SVSI_CHECK2',SVSI_CHECK2);
      AddConstant('SVSI_KEYBOARDSELECT',SVSI_KEYBOARDSELECT);
      AddConstant('SVSI_NOTAKEFOCUS',SVSI_NOTAKEFOCUS);
      AddConstant('SVSI_NOSTATECHANGE',SVSI_NOSTATECHANGE);
      AddConstant('SVGIO_BACKGROUND',SVGIO_BACKGROUND);
      AddConstant('SVGIO_SELECTION',SVGIO_SELECTION);
      AddConstant('SVGIO_ALLVIEW',SVGIO_ALLVIEW);
      AddConstant('SVGIO_CHECKED',SVGIO_CHECKED);
      AddConstant('SVGIO_TYPE_MASK',SVGIO_TYPE_MASK);
      AddConstant('SVGIO_FLAG_VIEWORDER',SVGIO_FLAG_VIEWORDER);
      AddConstant('SVUIA_DEACTIVATE',SVUIA_DEACTIVATE);
      AddConstant('SVUIA_ACTIVATE_NOFOCUS',SVUIA_ACTIVATE_NOFOCUS);
      AddConstant('SVUIA_ACTIVATE_FOCUS',SVUIA_ACTIVATE_FOCUS);
      AddConstant('SVUIA_INPLACEACTIVATE',SVUIA_INPLACEACTIVATE);
      AddConstant('SBSP_DEFBROWSER',SBSP_DEFBROWSER);
      AddConstant('SBSP_SAMEBROWSER',SBSP_SAMEBROWSER);
      AddConstant('SBSP_NEWBROWSER',SBSP_NEWBROWSER);
      AddConstant('SBSP_DEFMODE',SBSP_DEFMODE);
      AddConstant('SBSP_OPENMODE',SBSP_OPENMODE);
      AddConstant('SBSP_EXPLOREMODE',SBSP_EXPLOREMODE);
      AddConstant('SBSP_HELPMODE',SBSP_HELPMODE);
      AddConstant('SBSP_NOTRANSFERHIST',SBSP_NOTRANSFERHIST);
      AddConstant('SBSP_ABSOLUTE',SBSP_ABSOLUTE);
      AddConstant('SBSP_RELATIVE',SBSP_RELATIVE);
      AddConstant('SBSP_PARENT',SBSP_PARENT);
      AddConstant('SBSP_NAVIGATEBACK',SBSP_NAVIGATEBACK);
      AddConstant('SBSP_NAVIGATEFORWARD',SBSP_NAVIGATEFORWARD);
      AddConstant('SBSP_ALLOW_AUTONAVIGATE',SBSP_ALLOW_AUTONAVIGATE);
      AddConstant('SBSP_KEEPSAMETEMPLATE',SBSP_KEEPSAMETEMPLATE);
      AddConstant('SBSP_KEEPWORDWHEELTEXT',SBSP_KEEPWORDWHEELTEXT);
      AddConstant('SBSP_ACTIVATE_NOFOCUS',SBSP_ACTIVATE_NOFOCUS);
      AddConstant('SBSP_CREATENOHISTORY',SBSP_CREATENOHISTORY);
      AddConstant('SBSP_PLAYNOSOUND',SBSP_PLAYNOSOUND);
      AddConstant('SBSP_CALLERUNTRUSTED',SBSP_CALLERUNTRUSTED);
      AddConstant('SBSP_TRUSTFIRSTDOWNLOAD',SBSP_TRUSTFIRSTDOWNLOAD);
      AddConstant('SBSP_UNTRUSTEDFORDOWNLOAD',SBSP_UNTRUSTEDFORDOWNLOAD);
      AddConstant('SBSP_NOAUTOSELECT',SBSP_NOAUTOSELECT);
      AddConstant('SBSP_WRITENOHISTORY',SBSP_WRITENOHISTORY);
      AddConstant('SBSP_TRUSTEDFORACTIVEX',SBSP_TRUSTEDFORACTIVEX);
      AddConstant('SBSP_FEEDNAVIGATION',SBSP_FEEDNAVIGATION);
      AddConstant('SBSP_REDIRECT',SBSP_REDIRECT);
      AddConstant('SBSP_INITIATEDBYHLINKFRAME',SBSP_INITIATEDBYHLINKFRAME);
      AddConstant('FCW_STATUS',FCW_STATUS);
      AddConstant('FCW_TOOLBAR',FCW_TOOLBAR);
      AddConstant('FCW_TREE',FCW_TREE);
      AddConstant('FCW_INTERNETBAR',FCW_INTERNETBAR);
      AddConstant('FCW_PROGRESS',FCW_PROGRESS);
      AddConstant('FCT_MERGE',FCT_MERGE);
      AddConstant('FCT_CONFIGABLE',FCT_CONFIGABLE);
      AddConstant('FCT_ADDTOEND',FCT_ADDTOEND);
      AddConstant('SV2GV_CURRENTVIEW',SV2GV_CURRENTVIEW);
      AddConstant('SV2GV_DEFAULTVIEW',SV2GV_DEFAULTVIEW);
      AddConstant('SV3CVW3_DEFAULT',SV3CVW3_DEFAULT);
      AddConstant('SV3CVW3_NONINTERACTIVE',SV3CVW3_NONINTERACTIVE);
      AddConstant('SV3CVW3_FORCEVIEWMODE',SV3CVW3_FORCEVIEWMODE);
      AddConstant('SV3CVW3_FORCEFOLDERFLAGS',SV3CVW3_FORCEFOLDERFLAGS);
      AddConstant('SIATTRIBFLAGS_AND',SIATTRIBFLAGS_AND);
      AddConstant('SIATTRIBFLAGS_OR',SIATTRIBFLAGS_OR);
      AddConstant('SIATTRIBFLAGS_APPCOMPAT',SIATTRIBFLAGS_APPCOMPAT);
      AddConstant('SIATTRIBFLAGS_MASK',SIATTRIBFLAGS_MASK);
      AddConstant('SIATTRIBFLAGS_ALLITEMS',SIATTRIBFLAGS_ALLITEMS);
      AddConstant('SORT_DESCENDING',SORT_DESCENDING);
      AddConstant('SORT_ASCENDING',SORT_ASCENDING);
      AddConstant('FVST_EMPTYTEXT',FVST_EMPTYTEXT);
      AddConstant('VPWF_DEFAULT',VPWF_DEFAULT);
      AddConstant('VPWF_ALPHABLEND',VPWF_ALPHABLEND);
      AddConstant('VPCF_TEXT',VPCF_TEXT);
      AddConstant('VPCF_BACKGROUND',VPCF_BACKGROUND);
      AddConstant('VPCF_SORTCOLUMN',VPCF_SORTCOLUMN);
      AddConstant('VPCF_SUBTEXT',VPCF_SUBTEXT);
      AddConstant('VPCF_TEXTBACKGROUND',VPCF_TEXTBACKGROUND);
      AddConstant('CDBOSC_SETFOCUS',CDBOSC_SETFOCUS);
      AddConstant('CDBOSC_KILLFOCUS',CDBOSC_KILLFOCUS);
      AddConstant('CDBOSC_SELCHANGE',CDBOSC_SELCHANGE);
      AddConstant('CDBOSC_RENAME',CDBOSC_RENAME);
      AddConstant('CDBOSC_STATECHANGE',CDBOSC_STATECHANGE);
      AddConstant('CDB2N_CONTEXTMENU_DONE',CDB2N_CONTEXTMENU_DONE);
      AddConstant('CDB2N_CONTEXTMENU_START',CDB2N_CONTEXTMENU_START);
      AddConstant('CDB2GVF_SHOWALLFILES',CDB2GVF_SHOWALLFILES);
      AddConstant('CDB2GVF_ISFILESAVE',CDB2GVF_ISFILESAVE);
      AddConstant('CDB2GVF_ALLOWPREVIEWPANE',CDB2GVF_ALLOWPREVIEWPANE);
      AddConstant('CDB2GVF_NOSELECTVERB',CDB2GVF_NOSELECTVERB);
      AddConstant('CDB2GVF_NOINCLUDEITEM',CDB2GVF_NOINCLUDEITEM);
      AddConstant('CDB2GVF_ISFOLDERPICKER',CDB2GVF_ISFOLDERPICKER);
      AddConstant('CDB2GVF_ADDSHIELD',CDB2GVF_ADDSHIELD);
      AddConstant('CM_MASK_WIDTH',CM_MASK_WIDTH);
      AddConstant('CM_MASK_DEFAULTWIDTH',CM_MASK_DEFAULTWIDTH);
      AddConstant('CM_MASK_IDEALWIDTH',CM_MASK_IDEALWIDTH);
      AddConstant('CM_MASK_NAME',CM_MASK_NAME);
      AddConstant('CM_MASK_STATE',CM_MASK_STATE);
      AddConstant('CM_STATE_NONE',CM_STATE_NONE);
      AddConstant('CM_STATE_VISIBLE',CM_STATE_VISIBLE);
      AddConstant('CM_STATE_FIXEDWIDTH',CM_STATE_FIXEDWIDTH);
      AddConstant('CM_STATE_NOSORTBYFOLDERNESS',CM_STATE_NOSORTBYFOLDERNESS);
      AddConstant('CM_STATE_ALWAYSVISIBLE',CM_STATE_ALWAYSVISIBLE);
      AddConstant('CM_ENUM_ALL',CM_ENUM_ALL);
      AddConstant('CM_ENUM_VISIBLE',CM_ENUM_VISIBLE);
      AddConstant('CM_WIDTH_USEDEFAULT',CM_WIDTH_USEDEFAULT);
      AddConstant('CM_WIDTH_AUTOSIZE',CM_WIDTH_AUTOSIZE);
      AddConstant('DOGIF_DEFAULT',DOGIF_DEFAULT);
      AddConstant('DOGIF_TRAVERSE_LINK',DOGIF_TRAVERSE_LINK);
      AddConstant('DOGIF_NO_HDROP',DOGIF_NO_HDROP);
      AddConstant('DOGIF_NO_URL',DOGIF_NO_URL);
      AddConstant('DOGIF_ONLY_IF_ONE',DOGIF_ONLY_IF_ONE);
      AddConstant('STR_GPS_HANDLERPROPERTIESONLY',STR_GPS_HANDLERPROPERTIESONLY);
      AddConstant('STR_GPS_FASTPROPERTIESONLY',STR_GPS_FASTPROPERTIESONLY);
      AddConstant('STR_GPS_OPENSLOWITEM',STR_GPS_OPENSLOWITEM);
      AddConstant('STR_GPS_DELAYCREATION',STR_GPS_DELAYCREATION);
      AddConstant('STR_GPS_BESTEFFORT',STR_GPS_BESTEFFORT);
      AddConstant('STR_GPS_NO_OPLOCK',STR_GPS_NO_OPLOCK);
      AddConstant('SIIGBF_RESIZETOFIT',SIIGBF_RESIZETOFIT);
      AddConstant('SIIGBF_BIGGERSIZEOK',SIIGBF_BIGGERSIZEOK);
      AddConstant('SIIGBF_MEMORYONLY',SIIGBF_MEMORYONLY);
      AddConstant('SIIGBF_ICONONLY',SIIGBF_ICONONLY);
      AddConstant('SIIGBF_THUMBNAILONLY',SIIGBF_THUMBNAILONLY);
      AddConstant('SIIGBF_INCACHEONLY',SIIGBF_INCACHEONLY);
      AddConstant('STGOP_MOVE',STGOP_MOVE);
      AddConstant('STGOP_COPY',STGOP_COPY);
      AddConstant('STGOP_SYNC',STGOP_SYNC);
      AddConstant('STGOP_REMOVE',STGOP_REMOVE);
      AddConstant('STGOP_RENAME',STGOP_RENAME);
      AddConstant('STGOP_APPLYPROPERTIES',STGOP_APPLYPROPERTIES);
      AddConstant('STGOP_NEW',STGOP_NEW);
      AddConstant('TS_NONE',TS_NONE);
      AddConstant('TS_PERFORMING',TS_PERFORMING);
      AddConstant('TS_PREPARING',TS_PREPARING);
      AddConstant('TS_INDETERMINATE',TS_INDETERMINATE);
      AddConstant('TSF_NORMAL',TSF_NORMAL);
      AddConstant('TSF_FAIL_EXIST',TSF_FAIL_EXIST);
      AddConstant('TSF_RENAME_EXIST',TSF_RENAME_EXIST);
      AddConstant('TSF_OVERWRITE_EXIST',TSF_OVERWRITE_EXIST);
      AddConstant('TSF_ALLOW_DECRYPTION',TSF_ALLOW_DECRYPTION);
      AddConstant('TSF_NO_SECURITY',TSF_NO_SECURITY);
      AddConstant('TSF_COPY_CREATION_TIME',TSF_COPY_CREATION_TIME);
      AddConstant('TSF_COPY_WRITE_TIME',TSF_COPY_WRITE_TIME);
      AddConstant('TSF_USE_FULL_ACCESS',TSF_USE_FULL_ACCESS);
      AddConstant('TSF_DELETE_RECYCLE_IF_POSSIBLE',TSF_DELETE_RECYCLE_IF_POSSIBLE);
      AddConstant('TSF_COPY_HARD_LINK',TSF_COPY_HARD_LINK);
      AddConstant('TSF_COPY_LOCALIZED_NAME',TSF_COPY_LOCALIZED_NAME);
      AddConstant('TSF_MOVE_AS_COPY_DELETE',TSF_MOVE_AS_COPY_DELETE);
      AddConstant('TSF_SUSPEND_SHELLEVENTS',TSF_SUSPEND_SHELLEVENTS);
      AddConstant('PUIFNF_DEFAULT',PUIFNF_DEFAULT);
      AddConstant('PUIFNF_MNEMONIC',PUIFNF_MNEMONIC);
      AddConstant('PUIF_DEFAULT',PUIF_DEFAULT);
    end;
  end;

  procedure AddConsts2;
  begin
    with Scripter.DefineClass(ClassType) do
    begin
      AddConstant('PUIF_RIGHTALIGN',PUIF_RIGHTALIGN);
      AddConstant('PUIF_NOLABELININFOTIP',PUIF_NOLABELININFOTIP);
      AddConstant('PUIFFDF_DEFAULT',PUIFFDF_DEFAULT);
      AddConstant('PUIFFDF_RIGHTTOLEFT',PUIFFDF_RIGHTTOLEFT);
      AddConstant('PUIFFDF_SHORTFORMAT',PUIFFDF_SHORTFORMAT);
      AddConstant('PUIFFDF_NOTIME',PUIFFDF_NOTIME);
      AddConstant('PUIFFDF_FRIENDLYDATE',PUIFFDF_FRIENDLYDATE);
      AddConstant('CATINFO_NORMAL',CATINFO_NORMAL);
      AddConstant('CATINFO_COLLAPSED',CATINFO_COLLAPSED);
      AddConstant('CATINFO_HIDDEN',CATINFO_HIDDEN);
      AddConstant('CATINFO_EXPANDED',CATINFO_EXPANDED);
      AddConstant('CATINFO_NOHEADER',CATINFO_NOHEADER);
      AddConstant('CATINFO_NOTCOLLAPSIBLE',CATINFO_NOTCOLLAPSIBLE);
      AddConstant('CATINFO_NOHEADERCOUNT',CATINFO_NOHEADERCOUNT);
      AddConstant('CATINFO_SUBSETTED',CATINFO_SUBSETTED);
      AddConstant('CATSORT_DEFAULT',CATSORT_DEFAULT);
      AddConstant('CATSORT_NAME',CATSORT_NAME);
      AddConstant('DI_GETDRAGIMAGE',DI_GETDRAGIMAGE);
      AddConstant('DSH_ALLOWDROPDESCRIPTIONTEXT',DSH_ALLOWDROPDESCRIPTIONTEXT);
      AddConstant('SLR_NO_UI',SLR_NO_UI);
      AddConstant('SLR_ANY_MATCH',SLR_ANY_MATCH);
      AddConstant('SLR_UPDATE',SLR_UPDATE);
      AddConstant('SLR_NOUPDATE',SLR_NOUPDATE);
      AddConstant('SLR_NOSEARCH',SLR_NOSEARCH);
      AddConstant('SLR_NOTRACK',SLR_NOTRACK);
      AddConstant('SLR_NOLINKINFO',SLR_NOLINKINFO);
      AddConstant('SLR_INVOKE_MSI',SLR_INVOKE_MSI);
      AddConstant('SLR_NO_UI_WITH_MSG_PUMP',SLR_NO_UI_WITH_MSG_PUMP);
      AddConstant('SLR_OFFER_DELETE_WITHOUT_FILE',SLR_OFFER_DELETE_WITHOUT_FILE);
      AddConstant('SLR_KNOWNFOLDER',SLR_KNOWNFOLDER);
      AddConstant('SLR_MACHINE_IN_LOCAL_TARGET',SLR_MACHINE_IN_LOCAL_TARGET);
      AddConstant('SLR_UPDATE_MACHINE_AND_SID',SLR_UPDATE_MACHINE_AND_SID);
      AddConstant('SLGP_SHORTPATH',SLGP_SHORTPATH);
      AddConstant('SLGP_UNCPRIORITY',SLGP_UNCPRIORITY);
      AddConstant('SLGP_RAWPATH',SLGP_RAWPATH);
      AddConstant('SLGP_RELATIVEPRIORITY',SLGP_RELATIVEPRIORITY);
      AddConstant('SPINITF_NORMAL',SPINITF_NORMAL);
      AddConstant('SPINITF_MODAL',SPINITF_MODAL);
      AddConstant('SPINITF_NOMINIMIZE',SPINITF_NOMINIMIZE);
      AddConstant('ARCONTENT_AUTORUNINF',ARCONTENT_AUTORUNINF);
      AddConstant('ARCONTENT_AUDIOCD',ARCONTENT_AUDIOCD);
      AddConstant('ARCONTENT_DVDMOVIE',ARCONTENT_DVDMOVIE);
      AddConstant('ARCONTENT_BLANKCD',ARCONTENT_BLANKCD);
      AddConstant('ARCONTENT_BLANKDVD',ARCONTENT_BLANKDVD);
      AddConstant('ARCONTENT_UNKNOWNCONTENT',ARCONTENT_UNKNOWNCONTENT);
      AddConstant('ARCONTENT_AUTOPLAYPIX',ARCONTENT_AUTOPLAYPIX);
      AddConstant('ARCONTENT_AUTOPLAYMUSIC',ARCONTENT_AUTOPLAYMUSIC);
      AddConstant('ARCONTENT_AUTOPLAYVIDEO',ARCONTENT_AUTOPLAYVIDEO);
      AddConstant('ARCONTENT_VCD',ARCONTENT_VCD);
      AddConstant('ARCONTENT_SVCD',ARCONTENT_SVCD);
      AddConstant('ARCONTENT_DVDAUDIO',ARCONTENT_DVDAUDIO);
      AddConstant('ARCONTENT_BLANKED',ARCONTENT_BLANKED);
      AddConstant('ARCONTENT_BLURAY',ARCONTENT_BLURAY);
      AddConstant('ARCONTENT_NONE',ARCONTENT_NONE);
      AddConstant('ARCONTENT_MASK',ARCONTENT_MASK);
      AddConstant('ARCONTENT_PHASE_UNKNOWN',ARCONTENT_PHASE_UNKNOWN);
      AddConstant('ARCONTENT_PHASE_PRESNIFF',ARCONTENT_PHASE_PRESNIFF);
      AddConstant('ARCONTENT_PHASE_SNIFFING',ARCONTENT_PHASE_SNIFFING);
      AddConstant('ARCONTENT_PHASE_FINAL',ARCONTENT_PHASE_FINAL);
      AddConstant('ARCONTENT_PHASE_MASK',ARCONTENT_PHASE_MASK);
      AddConstant('SPBEGINF_NORMAL',SPBEGINF_NORMAL);
      AddConstant('SPBEGINF_AUTOTIME',SPBEGINF_AUTOTIME);
      AddConstant('SPBEGINF_NOPROGRESSBAR',SPBEGINF_NOPROGRESSBAR);
      AddConstant('SPBEGINF_MARQUEEPROGRESS',SPBEGINF_MARQUEEPROGRESS);
      AddConstant('SPBEGINF_NOCANCELBUTTON',SPBEGINF_NOCANCELBUTTON);
      AddConstant('SPACTION_NONE',SPACTION_NONE);
      AddConstant('SPACTION_MOVING',SPACTION_MOVING);
      AddConstant('SPACTION_COPYING',SPACTION_COPYING);
      AddConstant('SPACTION_RECYCLING',SPACTION_RECYCLING);
      AddConstant('SPACTION_APPLYINGATTRIBS',SPACTION_APPLYINGATTRIBS);
      AddConstant('SPACTION_DOWNLOADING',SPACTION_DOWNLOADING);
      AddConstant('SPACTION_SEARCHING_INTERNET',SPACTION_SEARCHING_INTERNET);
      AddConstant('SPACTION_CALCULATING',SPACTION_CALCULATING);
      AddConstant('SPACTION_UPLOADING',SPACTION_UPLOADING);
      AddConstant('SPACTION_SEARCHING_FILES',SPACTION_SEARCHING_FILES);
      AddConstant('SPACTION_DELETING',SPACTION_DELETING);
      AddConstant('SPACTION_RENAMING',SPACTION_RENAMING);
      AddConstant('SPACTION_FORMATTING',SPACTION_FORMATTING);
      AddConstant('SPACTION_COPY_MOVING',SPACTION_COPY_MOVING);
      AddConstant('SPTEXT_ACTIONDESCRIPTION',SPTEXT_ACTIONDESCRIPTION);
      AddConstant('SPTEXT_ACTIONDETAIL',SPTEXT_ACTIONDETAIL);
      AddConstant('EXPPS_FILETYPES',EXPPS_FILETYPES);
      AddConstant('IEI_PRIORITY_MAX',IEI_PRIORITY_MAX);
      AddConstant('IEI_PRIORITY_MIN',IEI_PRIORITY_MIN);
      AddConstant('IEIT_PRIORITY_NORMAL',IEIT_PRIORITY_NORMAL);
      AddConstant('IEIFLAG_ASYNC',IEIFLAG_ASYNC);
      AddConstant('IEIFLAG_CACHE',IEIFLAG_CACHE);
      AddConstant('IEIFLAG_ASPECT',IEIFLAG_ASPECT);
      AddConstant('IEIFLAG_OFFLINE',IEIFLAG_OFFLINE);
      AddConstant('IEIFLAG_GLEAM',IEIFLAG_GLEAM);
      AddConstant('IEIFLAG_SCREEN',IEIFLAG_SCREEN);
      AddConstant('IEIFLAG_ORIGSIZE',IEIFLAG_ORIGSIZE);
      AddConstant('IEIFLAG_NOSTAMP',IEIFLAG_NOSTAMP);
      AddConstant('IEIFLAG_NOBORDER',IEIFLAG_NOBORDER);
      AddConstant('IEIFLAG_QUALITY',IEIFLAG_QUALITY);
      AddConstant('IEIFLAG_REFRESH',IEIFLAG_REFRESH);
      AddConstant('DBIM_MINSIZE',DBIM_MINSIZE);
      AddConstant('DBIM_MAXSIZE',DBIM_MAXSIZE);
      AddConstant('DBIM_INTEGRAL',DBIM_INTEGRAL);
      AddConstant('DBIM_ACTUAL',DBIM_ACTUAL);
      AddConstant('DBIM_TITLE',DBIM_TITLE);
      AddConstant('DBIM_MODEFLAGS',DBIM_MODEFLAGS);
      AddConstant('DBIM_BKCOLOR',DBIM_BKCOLOR);
      AddConstant('DBIMF_NORMAL',DBIMF_NORMAL);
      AddConstant('DBIMF_FIXED',DBIMF_FIXED);
      AddConstant('DBIMF_FIXEDBMP',DBIMF_FIXEDBMP);
      AddConstant('DBIMF_VARIABLEHEIGHT',DBIMF_VARIABLEHEIGHT);
      AddConstant('DBIMF_UNDELETEABLE',DBIMF_UNDELETEABLE);
      AddConstant('DBIMF_DEBOSSED',DBIMF_DEBOSSED);
      AddConstant('DBIMF_BKCOLOR',DBIMF_BKCOLOR);
      AddConstant('DBIMF_USECHEVRON',DBIMF_USECHEVRON);
      AddConstant('DBIMF_BREAK',DBIMF_BREAK);
      AddConstant('DBIMF_ADDTOFRONT',DBIMF_ADDTOFRONT);
      AddConstant('DBIMF_TOPALIGN',DBIMF_TOPALIGN);
      AddConstant('DBIMF_NOGRIPPER',DBIMF_NOGRIPPER);
      AddConstant('DBIMF_ALWAYSGRIPPER',DBIMF_ALWAYSGRIPPER);
      AddConstant('DBIMF_NOMARGINS',DBIMF_NOMARGINS);
      AddConstant('DBIF_VIEWMODE_NORMAL',DBIF_VIEWMODE_NORMAL);
      AddConstant('DBIF_VIEWMODE_VERTICAL',DBIF_VIEWMODE_VERTICAL);
      AddConstant('DBIF_VIEWMODE_FLOATING',DBIF_VIEWMODE_FLOATING);
      AddConstant('DBIF_VIEWMODE_TRANSPARENT',DBIF_VIEWMODE_TRANSPARENT);
      AddConstant('DBID_BANDINFOCHANGED',DBID_BANDINFOCHANGED);
      AddConstant('DBID_SHOWONLY',DBID_SHOWONLY);
      AddConstant('DBID_MAXIMIZEBAND',DBID_MAXIMIZEBAND);
      AddConstant('DBID_PUSHCHEVRON',DBID_PUSHCHEVRON);
      AddConstant('DBID_DELAYINIT',DBID_DELAYINIT);
      AddConstant('DBID_FINISHINIT',DBID_FINISHINIT);
      AddConstant('DBID_SETWINDOWTHEME',DBID_SETWINDOWTHEME);
      AddConstant('DBID_PERMITAUTOHIDE',DBID_PERMITAUTOHIDE);
      AddConstant('DBPC_SELECTFIRST',DBPC_SELECTFIRST);
      AddConstant('DBPC_SELECTLAST',DBPC_SELECTLAST);
      AddConstant('THBF_ENABLED',THBF_ENABLED);
      AddConstant('THBF_DISABLED',THBF_DISABLED);
      AddConstant('THBF_DISMISSONCLICK',THBF_DISMISSONCLICK);
      AddConstant('THBF_NOBACKGROUND',THBF_NOBACKGROUND);
      AddConstant('THBF_HIDDEN',THBF_HIDDEN);
      AddConstant('THBF_NONINTERACTIVE',THBF_NONINTERACTIVE);
      AddConstant('THB_BITMAP',THB_BITMAP);
      AddConstant('THB_ICON',THB_ICON);
      AddConstant('THB_TOOLTIP',THB_TOOLTIP);
      AddConstant('THB_FLAGS',THB_FLAGS);
      AddConstant('THBN_CLICKED',THBN_CLICKED);
      AddConstant('TBPF_NOPROGRESS',TBPF_NOPROGRESS);
      AddConstant('TBPF_INDETERMINATE',TBPF_INDETERMINATE);
      AddConstant('TBPF_NORMAL',TBPF_NORMAL);
      AddConstant('TBPF_ERROR',TBPF_ERROR);
      AddConstant('TBPF_PAUSED',TBPF_PAUSED);
      AddConstant('TBATF_USEMDITHUMBNAIL',TBATF_USEMDITHUMBNAIL);
      AddConstant('TBATF_USEMDILIVEPREVIEW',TBATF_USEMDILIVEPREVIEW);
      AddConstant('STPF_NONE',STPF_NONE);
      AddConstant('STPF_USEAPPTHUMBNAILALWAYS',STPF_USEAPPTHUMBNAILALWAYS);
      AddConstant('STPF_USEAPPTHUMBNAILWHENACTIVE',STPF_USEAPPTHUMBNAILWHENACTIVE);
      AddConstant('STPF_USEAPPPEEKALWAYS',STPF_USEAPPPEEKALWAYS);
      AddConstant('STPF_USEAPPPEEKWHENACTIVE',STPF_USEAPPPEEKWHENACTIVE);
      AddConstant('IDD_WIZEXTN_FIRST',IDD_WIZEXTN_FIRST);
      AddConstant('IDD_WIZEXTN_LAST',IDD_WIZEXTN_LAST);
      AddConstant('SHPWHF_NORECOMPRESS',SHPWHF_NORECOMPRESS);
      AddConstant('SHPWHF_NONETPLACECREATE',SHPWHF_NONETPLACECREATE);
      AddConstant('SHPWHF_NOFILESELECTOR',SHPWHF_NOFILESELECTOR);
      AddConstant('SHPWHF_USEMRU',SHPWHF_USEMRU);
      AddConstant('SHPWHF_ANYLOCATION',SHPWHF_ANYLOCATION);
      AddConstant('SHPWHF_VALIDATEVIAWEBFOLDERS',SHPWHF_VALIDATEVIAWEBFOLDERS);
      AddConstant('EBO_NONE',EBO_NONE);
      AddConstant('EBO_NAVIGATEONCE',EBO_NAVIGATEONCE);
      AddConstant('EBO_SHOWFRAMES',EBO_SHOWFRAMES);
      AddConstant('EBO_ALWAYSNAVIGATE',EBO_ALWAYSNAVIGATE);
      AddConstant('EBO_NOTRAVELLOG',EBO_NOTRAVELLOG);
      AddConstant('EBO_NOWRAPPERWINDOW',EBO_NOWRAPPERWINDOW);
      AddConstant('EBO_HTMLSHAREPOINTVIEW',EBO_HTMLSHAREPOINTVIEW);
      AddConstant('EBF_NONE',EBF_NONE);
      AddConstant('EBF_SELECTFROMDATAOBJECT',EBF_SELECTFROMDATAOBJECT);
      AddConstant('EBF_NODROPTARGET',EBF_NODROPTARGET);
      AddConstant('OPPROGDLG_DEFAULT',OPPROGDLG_DEFAULT);
      AddConstant('OPPROGDLG_ENABLEPAUSE',OPPROGDLG_ENABLEPAUSE);
      AddConstant('OPPROGDLG_ALLOWUNDO',OPPROGDLG_ALLOWUNDO);
      AddConstant('OPPROGDLG_DONTDISPLAYSOURCEPATH',OPPROGDLG_DONTDISPLAYSOURCEPATH);
      AddConstant('OPPROGDLG_DONTDISPLAYDESTPATH',OPPROGDLG_DONTDISPLAYDESTPATH);
      AddConstant('OPPROGDLG_NOMULTIDAYESTIMATES',OPPROGDLG_NOMULTIDAYESTIMATES);
      AddConstant('OPPROGDLG_DONTDISPLAYLOCATIONS',OPPROGDLG_DONTDISPLAYLOCATIONS);
      AddConstant('PDM_DEFAULT',PDM_DEFAULT);
      AddConstant('PDM_RUN',PDM_RUN);
      AddConstant('PDM_PREFLIGHT',PDM_PREFLIGHT);
      AddConstant('PDM_UNDOING',PDM_UNDOING);
      AddConstant('PDM_ERRORSBLOCKING',PDM_ERRORSBLOCKING);
      AddConstant('PDM_INDETERMINATE',PDM_INDETERMINATE);
      AddConstant('PDOPS_RUNNING',PDOPS_RUNNING);
      AddConstant('PDOPS_PAUSED',PDOPS_PAUSED);
      AddConstant('PDOPS_CANCELLED',PDOPS_CANCELLED);
      AddConstant('PDOPS_STOPPED',PDOPS_STOPPED);
      AddConstant('PDOPS_ERRORS',PDOPS_ERRORS);
      AddConstant('FOFX_NOSKIPJUNCTIONS',FOFX_NOSKIPJUNCTIONS);
      AddConstant('FOFX_PREFERHARDLINK',FOFX_PREFERHARDLINK);
      AddConstant('FOFX_SHOWELEVATIONPROMPT',FOFX_SHOWELEVATIONPROMPT);
      AddConstant('FOFX_EARLYFAILURE',FOFX_EARLYFAILURE);
      AddConstant('FOFX_PRESERVEFILEEXTENSIONS',FOFX_PRESERVEFILEEXTENSIONS);
      AddConstant('FOFX_KEEPNEWERFILE',FOFX_KEEPNEWERFILE);
      AddConstant('FOFX_NOCOPYHOOKS',FOFX_NOCOPYHOOKS);
      AddConstant('FOFX_NOMINIMIZEBOX',FOFX_NOMINIMIZEBOX);
      AddConstant('FOFX_MOVEACLSACROSSVOLUMES',FOFX_MOVEACLSACROSSVOLUMES);
      AddConstant('FOFX_DONTDISPLAYSOURCEPATH',FOFX_DONTDISPLAYSOURCEPATH);
      AddConstant('FOFX_DONTDISPLAYDESTPATH',FOFX_DONTDISPLAYDESTPATH);
      AddConstant('FOFX_REQUIREELEVATION',FOFX_REQUIREELEVATION);
      AddConstant('FOFX_COPYASDOWNLOAD',FOFX_COPYASDOWNLOAD);
      AddConstant('FOFX_DONTDISPLAYLOCATIONS',FOFX_DONTDISPLAYLOCATIONS);
      AddConstant('NSWF_DEFAULT',NSWF_DEFAULT);
      AddConstant('NSWF_NONE_IMPLIES_ALL',NSWF_NONE_IMPLIES_ALL);
      AddConstant('NSWF_ONE_IMPLIES_ALL',NSWF_ONE_IMPLIES_ALL);
      AddConstant('NSWF_DONT_TRAVERSE_LINKS',NSWF_DONT_TRAVERSE_LINKS);
      AddConstant('NSWF_DONT_ACCUMULATE_RESULT',NSWF_DONT_ACCUMULATE_RESULT);
      AddConstant('NSWF_TRAVERSE_STREAM_JUNCTIONS',NSWF_TRAVERSE_STREAM_JUNCTIONS);
      AddConstant('NSWF_FILESYSTEM_ONLY',NSWF_FILESYSTEM_ONLY);
      AddConstant('NSWF_SHOW_PROGRESS',NSWF_SHOW_PROGRESS);
      AddConstant('NSWF_FLAG_VIEWORDER',NSWF_FLAG_VIEWORDER);
      AddConstant('NSWF_IGNORE_AUTOPLAY_HIDA',NSWF_IGNORE_AUTOPLAY_HIDA);
      AddConstant('NSWF_ASYNC',NSWF_ASYNC);
      AddConstant('NSWF_DONT_RESOLVE_LINKS',NSWF_DONT_RESOLVE_LINKS);
      AddConstant('NSWF_ACCUMULATE_FOLDERS',NSWF_ACCUMULATE_FOLDERS);
      AddConstant('NSWF_DONT_SORT',NSWF_DONT_SORT);
      AddConstant('NSWF_USE_TRANSFER_MEDIUM',NSWF_USE_TRANSFER_MEDIUM);
      AddConstant('NSWF_DONT_TRAVERSE_STREAM_JUNCTIONS',NSWF_DONT_TRAVERSE_STREAM_JUNCTIONS);
      AddConstant('ACDD_VISIBLE',ACDD_VISIBLE);
      AddConstant('BSID_BANDADDED',BSID_BANDADDED);
      AddConstant('BSID_BANDREMOVED',BSID_BANDREMOVED);
      AddConstant('BSIM_STATE',BSIM_STATE);
      AddConstant('BSIM_STYLE',BSIM_STYLE);
      AddConstant('BSSF_VISIBLE',BSSF_VISIBLE);
      AddConstant('BSSF_NOTITLE',BSSF_NOTITLE);
      AddConstant('BSSF_UNDELETEABLE',BSSF_UNDELETEABLE);
      AddConstant('BSIS_AUTOGRIPPER',BSIS_AUTOGRIPPER);
      AddConstant('BSIS_NOGRIPPER',BSIS_NOGRIPPER);
      AddConstant('BSIS_ALWAYSGRIPPER',BSIS_ALWAYSGRIPPER);
      AddConstant('BSIS_LEFTALIGN',BSIS_LEFTALIGN);
      AddConstant('BSIS_SINGLECLICK',BSIS_SINGLECLICK);
      AddConstant('BSIS_NOCONTEXTMENU',BSIS_NOCONTEXTMENU);
      AddConstant('BSIS_NODROPTARGET',BSIS_NODROPTARGET);
      AddConstant('BSIS_NOCAPTION',BSIS_NOCAPTION);
      AddConstant('BSIS_PREFERNOLINEBREAK',BSIS_PREFERNOLINEBREAK);
      AddConstant('BSIS_LOCKED',BSIS_LOCKED);
      AddConstant('BSIS_PRESERVEORDERDURINGLAYOUT',BSIS_PRESERVEORDERDURINGLAYOUT);
      AddConstant('BSIS_FIXEDORDER',BSIS_FIXEDORDER);
      AddConstant('PROPSTR_EXTENSIONCOMPLETIONSTATE',PROPSTR_EXTENSIONCOMPLETIONSTATE);
      AddConstant('CDBE_RET_DEFAULT',CDBE_RET_DEFAULT);
      AddConstant('CDBE_RET_DONTRUNOTHEREXTS',CDBE_RET_DONTRUNOTHEREXTS);
      AddConstant('CDBE_RET_STOPWIZARD',CDBE_RET_STOPWIZARD);
      AddConstant('CDBE_TYPE_MUSIC',CDBE_TYPE_MUSIC);
      AddConstant('CDBE_TYPE_DATA',CDBE_TYPE_DATA);
      AddConstant('CDBE_TYPE_ALL',CDBE_TYPE_ALL);
      AddConstant('MBHANDCID_PIDLSELECT',MBHANDCID_PIDLSELECT);
      AddConstant('MPOS_EXECUTE',MPOS_EXECUTE);
      AddConstant('MPOS_FULLCANCEL',MPOS_FULLCANCEL);
      AddConstant('MPOS_CANCELLEVEL',MPOS_CANCELLEVEL);
      AddConstant('MPOS_SELECTLEFT',MPOS_SELECTLEFT);
      AddConstant('MPOS_SELECTRIGHT',MPOS_SELECTRIGHT);
      AddConstant('MPOS_CHILDTRACKING',MPOS_CHILDTRACKING);
      AddConstant('MPPF_SETFOCUS',MPPF_SETFOCUS);
      AddConstant('MPPF_INITIALSELECT',MPPF_INITIALSELECT);
      AddConstant('MPPF_NOANIMATE',MPPF_NOANIMATE);
      AddConstant('MPPF_KEYBOARD',MPPF_KEYBOARD);
      AddConstant('MPPF_REPOSITION',MPPF_REPOSITION);
      AddConstant('MPPF_FORCEZORDER',MPPF_FORCEZORDER);
      AddConstant('MPPF_FINALSELECT',MPPF_FINALSELECT);
      AddConstant('MPPF_TOP',MPPF_TOP);
      AddConstant('MPPF_LEFT',MPPF_LEFT);
      AddConstant('MPPF_RIGHT',MPPF_RIGHT);
      AddConstant('MPPF_BOTTOM',MPPF_BOTTOM);
      AddConstant('MPPF_POS_MASK',MPPF_POS_MASK);
      AddConstant('MPPF_ALIGN_LEFT',MPPF_ALIGN_LEFT);
      AddConstant('MPPF_ALIGN_RIGHT',MPPF_ALIGN_RIGHT);
      AddConstant('FUT_PLAYING',FUT_PLAYING);
      AddConstant('FUT_EDITING',FUT_EDITING);
      AddConstant('FUT_GENERIC',FUT_GENERIC);
      AddConstant('OF_CAP_CANSWITCHTO',OF_CAP_CANSWITCHTO);
      AddConstant('OF_CAP_CANCLOSE',OF_CAP_CANCLOSE);
      AddConstant('FDEOR_DEFAULT',FDEOR_DEFAULT);
      AddConstant('FDEOR_ACCEPT',FDEOR_ACCEPT);
      AddConstant('FDEOR_REFUSE',FDEOR_REFUSE);
      AddConstant('FDESVR_DEFAULT',FDESVR_DEFAULT);
      AddConstant('FDESVR_ACCEPT',FDESVR_ACCEPT);
      AddConstant('FDESVR_REFUSE',FDESVR_REFUSE);
      AddConstant('FDAP_BOTTOM',FDAP_BOTTOM);
      AddConstant('FDAP_TOP',FDAP_TOP);
      AddConstant('FOS_OVERWRITEPROMPT',FOS_OVERWRITEPROMPT);
      AddConstant('FOS_STRICTFILETYPES',FOS_STRICTFILETYPES);
      AddConstant('FOS_NOCHANGEDIR',FOS_NOCHANGEDIR);
      AddConstant('FOS_PICKFOLDERS',FOS_PICKFOLDERS);
      AddConstant('FOS_FORCEFILESYSTEM',FOS_FORCEFILESYSTEM);
      AddConstant('FOS_ALLNONSTORAGEITEMS',FOS_ALLNONSTORAGEITEMS);
      AddConstant('FOS_NOVALIDATE',FOS_NOVALIDATE);
      AddConstant('FOS_ALLOWMULTISELECT',FOS_ALLOWMULTISELECT);
      AddConstant('FOS_PATHMUSTEXIST',FOS_PATHMUSTEXIST);
      AddConstant('FOS_FILEMUSTEXIST',FOS_FILEMUSTEXIST);
      AddConstant('FOS_CREATEPROMPT',FOS_CREATEPROMPT);
      AddConstant('FOS_SHAREAWARE',FOS_SHAREAWARE);
      AddConstant('FOS_NOREADONLYRETURN',FOS_NOREADONLYRETURN);
      AddConstant('FOS_NOTESTFILECREATE',FOS_NOTESTFILECREATE);
      AddConstant('FOS_HIDEMRUPLACES',FOS_HIDEMRUPLACES);
      AddConstant('FOS_HIDEPINNEDPLACES',FOS_HIDEPINNEDPLACES);
      AddConstant('FOS_NODEREFERENCELINKS',FOS_NODEREFERENCELINKS);
      AddConstant('FOS_DONTADDTORECENT',FOS_DONTADDTORECENT);
      AddConstant('FOS_FORCESHOWHIDDEN',FOS_FORCESHOWHIDDEN);
      AddConstant('FOS_DEFAULTNOMINIMODE',FOS_DEFAULTNOMINIMODE);
      AddConstant('FOS_FORCEPREVIEWPANEON',FOS_FORCEPREVIEWPANEON);
      AddConstant('CDCS_INACTIVE',CDCS_INACTIVE);
      AddConstant('CDCS_ENABLED',CDCS_ENABLED);
      AddConstant('CDCS_VISIBLE',CDCS_VISIBLE);
      AddConstant('CDCS_ENABLEDVISIBLE',CDCS_ENABLEDVISIBLE);
      AddConstant('AL_MACHINE',AL_MACHINE);
      AddConstant('AL_EFFECTIVE',AL_EFFECTIVE);
      AddConstant('AL_USER',AL_USER);
      AddConstant('AT_FILEEXTENSION',AT_FILEEXTENSION);
      AddConstant('AT_URLPROTOCOL',AT_URLPROTOCOL);
      AddConstant('AT_STARTMENUCLIENT',AT_STARTMENUCLIENT);
      AddConstant('AT_MIMETYPE',AT_MIMETYPE);
      AddConstant('BFO_NONE',BFO_NONE);
      AddConstant('BFO_BROWSER_PERSIST_SETTINGS',BFO_BROWSER_PERSIST_SETTINGS);
      AddConstant('BFO_RENAME_FOLDER_OPTIONS_TOINTERNET',BFO_RENAME_FOLDER_OPTIONS_TOINTERNET);
      AddConstant('BFO_BOTH_OPTIONS',BFO_BOTH_OPTIONS);
      AddConstant('BIF_PREFER_INTERNET_SHORTCUT',BIF_PREFER_INTERNET_SHORTCUT);
      AddConstant('BFO_BROWSE_NO_IN_NEW_PROCESS',BFO_BROWSE_NO_IN_NEW_PROCESS);
      AddConstant('BFO_ENABLE_HYPERLINK_TRACKING',BFO_ENABLE_HYPERLINK_TRACKING);
      AddConstant('BFO_USE_IE_OFFLINE_SUPPORT',BFO_USE_IE_OFFLINE_SUPPORT);
      AddConstant('BFO_SUBSTITUE_INTERNET_START_PAGE',BFO_SUBSTITUE_INTERNET_START_PAGE);
      AddConstant('BFO_USE_IE_LOGOBANDING',BFO_USE_IE_LOGOBANDING);
      AddConstant('BFO_ADD_IE_TOCAPTIONBAR',BFO_ADD_IE_TOCAPTIONBAR);
      AddConstant('BFO_USE_DIALUP_REF',BFO_USE_DIALUP_REF);
      AddConstant('BFO_USE_IE_TOOLBAR',BFO_USE_IE_TOOLBAR);
      AddConstant('BFO_NO_PARENT_FOLDER_SUPPORT',BFO_NO_PARENT_FOLDER_SUPPORT);
      AddConstant('BFO_NO_REOPEN_NEXT_RESTART',BFO_NO_REOPEN_NEXT_RESTART);
      AddConstant('BFO_GO_HOME_PAGE',BFO_GO_HOME_PAGE);
      AddConstant('BFO_PREFER_IEPROCESS',BFO_PREFER_IEPROCESS);
      AddConstant('BFO_SHOW_NAVIGATION_CANCELLED',BFO_SHOW_NAVIGATION_CANCELLED);
      AddConstant('BFO_USE_IE_STATUSBAR',BFO_USE_IE_STATUSBAR);
      AddConstant('BFO_QUERY_ALL',BFO_QUERY_ALL);
      AddConstant('NWMF_UNLOADING',NWMF_UNLOADING);
      AddConstant('NWMF_USERINITED',NWMF_USERINITED);
      AddConstant('NWMF_FIRST',NWMF_FIRST);
      AddConstant('NWMF_OVERRIDEKEY',NWMF_OVERRIDEKEY);
      AddConstant('NWMF_SHOWHELP',NWMF_SHOWHELP);
      AddConstant('NWMF_HTMLDIALOG',NWMF_HTMLDIALOG);
      AddConstant('NWMF_FROMDIALOGCHILD',NWMF_FROMDIALOGCHILD);
      AddConstant('NWMF_USERREQUESTED',NWMF_USERREQUESTED);
      AddConstant('NWMF_USERALLOWED',NWMF_USERALLOWED);
      AddConstant('NWMF_FORCEWINDOW',NWMF_FORCEWINDOW);
      AddConstant('NWMF_FORCETAB',NWMF_FORCETAB);
      AddConstant('NWMF_SUGGESTWINDOW',NWMF_SUGGESTWINDOW);
      AddConstant('NWMF_SUGGESTTAB',NWMF_SUGGESTTAB);
      AddConstant('NWMF_INACTIVETAB',NWMF_INACTIVETAB);
      AddConstant('ATTACHMENT_PROMPT_NONE',ATTACHMENT_PROMPT_NONE);
      AddConstant('ATTACHMENT_PROMPT_SAVE',ATTACHMENT_PROMPT_SAVE);
      AddConstant('ATTACHMENT_PROMPT_EXEC',ATTACHMENT_PROMPT_EXEC);
      AddConstant('ATTACHMENT_PROMPT_EXEC_OR_SAVE',ATTACHMENT_PROMPT_EXEC_OR_SAVE);
      AddConstant('ATTACHMENT_ACTION_CANCEL',ATTACHMENT_ACTION_CANCEL);
      AddConstant('ATTACHMENT_ACTION_SAVE',ATTACHMENT_ACTION_SAVE);
      AddConstant('ATTACHMENT_ACTION_EXEC',ATTACHMENT_ACTION_EXEC);
      AddConstant('SMDM_SHELLFOLDER',SMDM_SHELLFOLDER);
      AddConstant('SMDM_HMENU',SMDM_HMENU);
      AddConstant('SMDM_TOOLBAR',SMDM_TOOLBAR);
      AddConstant('SMIM_TYPE',SMIM_TYPE);
      AddConstant('SMIM_FLAGS',SMIM_FLAGS);
      AddConstant('SMIM_ICON',SMIM_ICON);
      AddConstant('SMIT_SEPARATOR',SMIT_SEPARATOR);
      AddConstant('SMIT_STRING',SMIT_STRING);
      AddConstant('SMIF_ICON',SMIF_ICON);
      AddConstant('SMIF_ACCELERATOR',SMIF_ACCELERATOR);
      AddConstant('SMIF_DROPTARGET',SMIF_DROPTARGET);
      AddConstant('SMIF_SUBMENU',SMIF_SUBMENU);
      AddConstant('SMIF_CHECKED',SMIF_CHECKED);
      AddConstant('SMIF_DROPCASCADE',SMIF_DROPCASCADE);
      AddConstant('SMIF_HIDDEN',SMIF_HIDDEN);
      AddConstant('SMIF_DISABLED',SMIF_DISABLED);
      AddConstant('SMIF_TRACKPOPUP',SMIF_TRACKPOPUP);
      AddConstant('SMIF_DEMOTED',SMIF_DEMOTED);
      AddConstant('SMIF_ALTSTATE',SMIF_ALTSTATE);
      AddConstant('SMIF_DRAGNDROP',SMIF_DRAGNDROP);
      AddConstant('SMIF_NEW',SMIF_NEW);
      AddConstant('SMC_INITMENU',SMC_INITMENU);
      AddConstant('SMC_CREATE',SMC_CREATE);
      AddConstant('SMC_EXITMENU',SMC_EXITMENU);
      AddConstant('SMC_GETINFO',SMC_GETINFO);
      AddConstant('SMC_GETSFINFO',SMC_GETSFINFO);
      AddConstant('SMC_GETOBJECT',SMC_GETOBJECT);
      AddConstant('SMC_GETSFOBJECT',SMC_GETSFOBJECT);
      AddConstant('SMC_SFEXEC',SMC_SFEXEC);
      AddConstant('SMC_SFSELECTITEM',SMC_SFSELECTITEM);
      AddConstant('SMC_REFRESH',SMC_REFRESH);
      AddConstant('SMC_DEMOTE',SMC_DEMOTE);
      AddConstant('SMC_PROMOTE',SMC_PROMOTE);
      AddConstant('SMC_DEFAULTICON',SMC_DEFAULTICON);
      AddConstant('SMC_NEWITEM',SMC_NEWITEM);
      AddConstant('SMC_CHEVRONEXPAND',SMC_CHEVRONEXPAND);
      AddConstant('SMC_DISPLAYCHEVRONTIP',SMC_DISPLAYCHEVRONTIP);
      AddConstant('SMC_SETSFOBJECT',SMC_SETSFOBJECT);
      AddConstant('SMC_SHCHANGENOTIFY',SMC_SHCHANGENOTIFY);
      AddConstant('SMC_CHEVRONGETTIP',SMC_CHEVRONGETTIP);
      AddConstant('SMC_SFDDRESTRICTED',SMC_SFDDRESTRICTED);
      AddConstant('SMC_SFEXEC_MIDDLE',SMC_SFEXEC_MIDDLE);
      AddConstant('SMC_GETAUTOEXPANDSTATE',SMC_GETAUTOEXPANDSTATE);
      AddConstant('SMC_AUTOEXPANDCHANGE',SMC_AUTOEXPANDCHANGE);
      AddConstant('SMC_GETCONTEXTMENUMODIFIER',SMC_GETCONTEXTMENUMODIFIER);
      AddConstant('SMC_GETBKCONTEXTMENU',SMC_GETBKCONTEXTMENU);
      AddConstant('SMC_OPEN',SMC_OPEN);
      AddConstant('SMAE_EXPANDED',SMAE_EXPANDED);
      AddConstant('SMAE_CONTRACTED',SMAE_CONTRACTED);
      AddConstant('SMAE_USER',SMAE_USER);
      AddConstant('SMAE_VALID',SMAE_VALID);
      AddConstant('SMINIT_DEFAULT',SMINIT_DEFAULT);
      AddConstant('SMINIT_RESTRICT_DRAGDROP',SMINIT_RESTRICT_DRAGDROP);
      AddConstant('SMINIT_TOPLEVEL',SMINIT_TOPLEVEL);
      AddConstant('SMINIT_CACHED',SMINIT_CACHED);
      AddConstant('SMINIT_AUTOEXPAND',SMINIT_AUTOEXPAND);
      AddConstant('SMINIT_AUTOTOOLTIP',SMINIT_AUTOTOOLTIP);
      AddConstant('SMINIT_DROPONCONTAINER',SMINIT_DROPONCONTAINER);
      AddConstant('SMINIT_VERTICAL',SMINIT_VERTICAL);
      AddConstant('SMINIT_HORIZONTAL',SMINIT_HORIZONTAL);
      AddConstant('ANCESTORDEFAULT',ANCESTORDEFAULT);
      AddConstant('SMSET_TOP',SMSET_TOP);
      AddConstant('SMSET_BOTTOM',SMSET_BOTTOM);
      AddConstant('SMSET_DONTOWN',SMSET_DONTOWN);
      AddConstant('SMINV_REFRESH',SMINV_REFRESH);
      AddConstant('SMINV_ID',SMINV_ID);
      AddConstant('KF_CATEGORY_VIRTUAL',KF_CATEGORY_VIRTUAL);
      AddConstant('KF_CATEGORY_FIXED',KF_CATEGORY_FIXED);
      AddConstant('KF_CATEGORY_COMMON',KF_CATEGORY_COMMON);
      AddConstant('KF_CATEGORY_PERUSER',KF_CATEGORY_PERUSER);
      AddConstant('KFDF_LOCAL_REDIRECT_ONLY',KFDF_LOCAL_REDIRECT_ONLY);
      AddConstant('KFDF_ROAMABLE',KFDF_ROAMABLE);
      AddConstant('KFDF_PRECREATE',KFDF_PRECREATE);
      AddConstant('KFDF_STREAM',KFDF_STREAM);
      AddConstant('KFDF_PUBLISHEXPANDEDPATH',KFDF_PUBLISHEXPANDEDPATH);
      AddConstant('KF_REDIRECT_USER_EXCLUSIVE',KF_REDIRECT_USER_EXCLUSIVE);
      AddConstant('KF_REDIRECT_COPY_SOURCE_DACL',KF_REDIRECT_COPY_SOURCE_DACL);
      AddConstant('KF_REDIRECT_OWNER_USER',KF_REDIRECT_OWNER_USER);
      AddConstant('KF_REDIRECT_SET_OWNER_EXPLICIT',KF_REDIRECT_SET_OWNER_EXPLICIT);
      AddConstant('KF_REDIRECT_CHECK_ONLY',KF_REDIRECT_CHECK_ONLY);
      AddConstant('KF_REDIRECT_WITH_UI',KF_REDIRECT_WITH_UI);
      AddConstant('KF_REDIRECT_UNPIN',KF_REDIRECT_UNPIN);
      AddConstant('KF_REDIRECT_PIN',KF_REDIRECT_PIN);
      AddConstant('KF_REDIRECT_COPY_CONTENTS',KF_REDIRECT_COPY_CONTENTS);
      AddConstant('KF_REDIRECT_DEL_SOURCE_CONTENTS',KF_REDIRECT_DEL_SOURCE_CONTENTS);
      AddConstant('KF_REDIRECT_EXCLUDE_ALL_KNOWN_SUBFOLDERS',KF_REDIRECT_EXCLUDE_ALL_KNOWN_SUBFOLDERS);
      AddConstant('KF_REDIRECTION_CAPABILITIES_ALLOW_ALL',KF_REDIRECTION_CAPABILITIES_ALLOW_ALL);
      AddConstant('KF_REDIRECTION_CAPABILITIES_REDIRECTABLE',KF_REDIRECTION_CAPABILITIES_REDIRECTABLE);
      AddConstant('KF_REDIRECTION_CAPABILITIES_DENY_ALL',KF_REDIRECTION_CAPABILITIES_DENY_ALL);
      AddConstant('KF_REDIRECTION_CAPABILITIES_DENY_POLICY_REDIRECTED',KF_REDIRECTION_CAPABILITIES_DENY_POLICY_REDIRECTED);
      AddConstant('KF_REDIRECTION_CAPABILITIES_DENY_POLICY',KF_REDIRECTION_CAPABILITIES_DENY_POLICY);
      AddConstant('KF_REDIRECTION_CAPABILITIES_DENY_PERMISSIONS',KF_REDIRECTION_CAPABILITIES_DENY_PERMISSIONS);
      AddConstant('FFFP_EXACTMATCH',FFFP_EXACTMATCH);
      AddConstant('FFFP_NEARESTPARENTMATCH',FFFP_NEARESTPARENTMATCH);
      AddConstant('SHARE_ROLE_INVALID',SHARE_ROLE_INVALID);
      AddConstant('SHARE_ROLE_READER',SHARE_ROLE_READER);
      AddConstant('SHARE_ROLE_CONTRIBUTOR',SHARE_ROLE_CONTRIBUTOR);
      AddConstant('SHARE_ROLE_CO_OWNER',SHARE_ROLE_CO_OWNER);
      AddConstant('SHARE_ROLE_OWNER',SHARE_ROLE_OWNER);
      AddConstant('SHARE_ROLE_CUSTOM',SHARE_ROLE_CUSTOM);
      AddConstant('SHARE_ROLE_MIXED',SHARE_ROLE_MIXED);
      AddConstant('DEFSHAREID_USERS',DEFSHAREID_USERS);
      AddConstant('DEFSHAREID_PUBLIC',DEFSHAREID_PUBLIC);
      AddConstant('NMCII_ITEMS',NMCII_ITEMS);
      AddConstant('NMCII_FOLDERS',NMCII_FOLDERS);
      AddConstant('NMCSAEI_SELECT',NMCSAEI_SELECT);
      AddConstant('NMCSAEI_EDIT',NMCSAEI_EDIT);
      AddConstant('NSTCS_HASEXPANDOS',NSTCS_HASEXPANDOS);
      AddConstant('NSTCS_HASLINES',NSTCS_HASLINES);
      AddConstant('NSTCS_SINGLECLICKEXPAND',NSTCS_SINGLECLICKEXPAND);
      AddConstant('NSTCS_FULLROWSELECT',NSTCS_FULLROWSELECT);
      AddConstant('NSTCS_SPRINGEXPAND',NSTCS_SPRINGEXPAND);
      AddConstant('NSTCS_HORIZONTALSCROLL',NSTCS_HORIZONTALSCROLL);
      AddConstant('NSTCS_ROOTHASEXPANDO',NSTCS_ROOTHASEXPANDO);
      AddConstant('NSTCS_SHOWSELECTIONALWAYS',NSTCS_SHOWSELECTIONALWAYS);
      AddConstant('NSTCS_NOINFOTIP',NSTCS_NOINFOTIP);
      AddConstant('NSTCS_EVENHEIGHT',NSTCS_EVENHEIGHT);
      AddConstant('NSTCS_NOREPLACEOPEN',NSTCS_NOREPLACEOPEN);
      AddConstant('NSTCS_DISABLEDRAGDROP',NSTCS_DISABLEDRAGDROP);
      AddConstant('NSTCS_NOORDERSTREAM',NSTCS_NOORDERSTREAM);
      AddConstant('NSTCS_RICHTOOLTIP',NSTCS_RICHTOOLTIP);
      AddConstant('NSTCS_BORDER',NSTCS_BORDER);
      AddConstant('NSTCS_NOEDITLABELS',NSTCS_NOEDITLABELS);
      AddConstant('NSTCS_TABSTOP',NSTCS_TABSTOP);
      AddConstant('NSTCS_FAVORITESMODE',NSTCS_FAVORITESMODE);
      AddConstant('NSTCS_AUTOHSCROLL',NSTCS_AUTOHSCROLL);
      AddConstant('NSTCS_FADEINOUTEXPANDOS',NSTCS_FADEINOUTEXPANDOS);
      AddConstant('NSTCS_EMPTYTEXT',NSTCS_EMPTYTEXT);
      AddConstant('NSTCS_CHECKBOXES',NSTCS_CHECKBOXES);
      AddConstant('NSTCS_PARTIALCHECKBOXES',NSTCS_PARTIALCHECKBOXES);
      AddConstant('NSTCS_EXCLUSIONCHECKBOXES',NSTCS_EXCLUSIONCHECKBOXES);
      AddConstant('NSTCS_DIMMEDCHECKBOXES',NSTCS_DIMMEDCHECKBOXES);
      AddConstant('NSTCS_NOINDENTCHECKS',NSTCS_NOINDENTCHECKS);
      AddConstant('NSTCS_ALLOWJUNCTIONS',NSTCS_ALLOWJUNCTIONS);
      AddConstant('NSTCS_SHOWTABSBUTTON',NSTCS_SHOWTABSBUTTON);
      AddConstant('NSTCS_SHOWDELETEBUTTON',NSTCS_SHOWDELETEBUTTON);
      AddConstant('NSTCS_SHOWREFRESHBUTTON',NSTCS_SHOWREFRESHBUTTON);
      AddConstant('NSTCRS_VISIBLE',NSTCRS_VISIBLE);
      AddConstant('NSTCRS_HIDDEN',NSTCRS_HIDDEN);
      AddConstant('NSTCRS_EXPANDED',NSTCRS_EXPANDED);
      AddConstant('NSTCIS_NONE',NSTCIS_NONE);
      AddConstant('NSTCIS_SELECTED',NSTCIS_SELECTED);
      AddConstant('NSTCIS_EXPANDED',NSTCIS_EXPANDED);
      AddConstant('NSTCIS_BOLD',NSTCIS_BOLD);
      AddConstant('NSTCIS_DISABLED',NSTCIS_DISABLED);
      AddConstant('NSTCIS_SELECTEDNOEXPAND',NSTCIS_SELECTEDNOEXPAND);
      AddConstant('NSTCGNI_NEXT',NSTCGNI_NEXT);
      AddConstant('NSTCGNI_NEXTVISIBLE',NSTCGNI_NEXTVISIBLE);
      AddConstant('NSTCGNI_PREV',NSTCGNI_PREV);
      AddConstant('NSTCGNI_PREVVISIBLE',NSTCGNI_PREVVISIBLE);
      AddConstant('NSTCGNI_PARENT',NSTCGNI_PARENT);
      AddConstant('NSTCGNI_CHILD',NSTCGNI_CHILD);
      AddConstant('NSTCGNI_FIRSTVISIBLE',NSTCGNI_FIRSTVISIBLE);
      AddConstant('NSTCGNI_LASTVISIBLE',NSTCGNI_LASTVISIBLE);
      AddConstant('NSTCS2_DEFAULT',NSTCS2_DEFAULT);
      AddConstant('NSTCS2_INTERRUPTNOTIFICATIONS',NSTCS2_INTERRUPTNOTIFICATIONS);
      AddConstant('NSTCS2_SHOWNULLSPACEMENU',NSTCS2_SHOWNULLSPACEMENU);
      AddConstant('NSTCS2_DISPLAYPADDING',NSTCS2_DISPLAYPADDING);
      AddConstant('NSTCS2_DISPLAYPINNEDONLY',NSTCS2_DISPLAYPINNEDONLY);
      AddConstant('NTSCS2_NOSINGLETONAUTOEXPAND',NTSCS2_NOSINGLETONAUTOEXPAND);
      AddConstant('NSTCS2_ALLMASK',NSTCS2_ALLMASK);
      AddConstant('NSTCEHT_NOWHERE',NSTCEHT_NOWHERE);
      AddConstant('NSTCEHT_ONITEMICON',NSTCEHT_ONITEMICON);
      AddConstant('NSTCEHT_ONITEMLABEL',NSTCEHT_ONITEMLABEL);
      AddConstant('NSTCEHT_ONITEMINDENT',NSTCEHT_ONITEMINDENT);
      AddConstant('NSTCEHT_ONITEMBUTTON',NSTCEHT_ONITEMBUTTON);
      AddConstant('NSTCEHT_ONITEMRIGHT',NSTCEHT_ONITEMRIGHT);
      AddConstant('NSTCEHT_ONITEMSTATEICON',NSTCEHT_ONITEMSTATEICON);
      AddConstant('NSTCEHT_ONITEM',NSTCEHT_ONITEM);
      AddConstant('NSTCEHT_ONITEMTABBUTTON',NSTCEHT_ONITEMTABBUTTON);
      AddConstant('NSTCECT_LBUTTON',NSTCECT_LBUTTON);
      AddConstant('NSTCECT_MBUTTON',NSTCECT_MBUTTON);
      AddConstant('NSTCECT_RBUTTON',NSTCECT_RBUTTON);
      AddConstant('NSTCECT_BUTTON',NSTCECT_BUTTON);
      AddConstant('NSTCECT_DBLCLICK',NSTCECT_DBLCLICK);
      AddConstant('NSTCDHPOS_ONTOP',NSTCDHPOS_ONTOP);
      AddConstant('NSTCFC_NONE',NSTCFC_NONE);
      AddConstant('NSTCFC_PINNEDITEMFILTERING',NSTCFC_PINNEDITEMFILTERING);
      AddConstant('NSTCFC_DELAY_REGISTER_NOTIFY',NSTCFC_DELAY_REGISTER_NOTIFY);
      AddConstant('E_PREVIEWHANDLER_DRM_FAIL',E_PREVIEWHANDLER_DRM_FAIL);
      AddConstant('E_PREVIEWHANDLER_NOAUTH',E_PREVIEWHANDLER_NOAUTH);
      AddConstant('E_PREVIEWHANDLER_NOTFOUND',E_PREVIEWHANDLER_NOTFOUND);
      AddConstant('E_PREVIEWHANDLER_CORRUPT',E_PREVIEWHANDLER_CORRUPT);
      AddConstant('EPS_DONTCARE',EPS_DONTCARE);
      AddConstant('EPS_DEFAULT_ON',EPS_DEFAULT_ON);
      AddConstant('EPS_DEFAULT_OFF',EPS_DEFAULT_OFF);
      AddConstant('EPS_STATEMASK',EPS_STATEMASK);
      AddConstant('EPS_INITIALSTATE',EPS_INITIALSTATE);
      AddConstant('EPS_FORCE',EPS_FORCE);
      AddConstant('ECS_ENABLED',ECS_ENABLED);
      AddConstant('ECS_DISABLED',ECS_DISABLED);
      AddConstant('ECS_HIDDEN',ECS_HIDDEN);
      AddConstant('ECS_CHECKBOX',ECS_CHECKBOX);
      AddConstant('ECS_CHECKED',ECS_CHECKED);
      AddConstant('ECS_RADIOCHECK',ECS_RADIOCHECK);
      AddConstant('ECF_DEFAULT',ECF_DEFAULT);
      AddConstant('ECF_HASSUBCOMMANDS',ECF_HASSUBCOMMANDS);
      AddConstant('ECF_HASSPLITBUTTON',ECF_HASSPLITBUTTON);
      AddConstant('ECF_HIDELABEL',ECF_HIDELABEL);
      AddConstant('ECF_ISSEPARATOR',ECF_ISSEPARATOR);
      AddConstant('ECF_HASLUASHIELD',ECF_HASLUASHIELD);
      AddConstant('ECF_SEPARATORBEFORE',ECF_SEPARATORBEFORE);
      AddConstant('ECF_SEPARATORAFTER',ECF_SEPARATORAFTER);
      AddConstant('ECF_ISDROPDOWN',ECF_ISDROPDOWN);
      AddConstant('MARKUPSIZE_CALCWIDTH',MARKUPSIZE_CALCWIDTH);
      AddConstant('MARKUPSIZE_CALCHEIGHT',MARKUPSIZE_CALCHEIGHT);
      AddConstant('MARKUPLINKTEXT_URL',MARKUPLINKTEXT_URL);
      AddConstant('MARKUPLINKTEXT_ID',MARKUPLINKTEXT_ID);
      AddConstant('MARKUPLINKTEXT_TEXT',MARKUPLINKTEXT_TEXT);
      AddConstant('MARKUPSTATE_FOCUSED',MARKUPSTATE_FOCUSED);
      AddConstant('MARKUPSTATE_ENABLED',MARKUPSTATE_ENABLED);
      AddConstant('MARKUPSTATE_VISITED',MARKUPSTATE_VISITED);
      AddConstant('MARKUPSTATE_HOT',MARKUPSTATE_HOT);
      AddConstant('MARKUPSTATE_DEFAULTCOLORS',MARKUPSTATE_DEFAULTCOLORS);
      AddConstant('MARKUPSTATE_ALLOWMARKUP',MARKUPSTATE_ALLOWMARKUP);
      AddConstant('MARKUPMESSAGE_KEYEXECUTE',MARKUPMESSAGE_KEYEXECUTE);
      AddConstant('MARKUPMESSAGE_CLICKEXECUTE',MARKUPMESSAGE_CLICKEXECUTE);
      AddConstant('MARKUPMESSAGE_WANTFOCUS',MARKUPMESSAGE_WANTFOCUS);
      AddConstant('CPVIEW_CLASSIC',CPVIEW_CLASSIC);
      AddConstant('CPVIEW_ALLITEMS',CPVIEW_ALLITEMS);
      AddConstant('CPVIEW_CATEGORY',CPVIEW_CATEGORY);
      AddConstant('CPVIEW_HOME',CPVIEW_HOME);
      AddConstant('STR_FILE_SYS_BIND_DATA',STR_FILE_SYS_BIND_DATA);
      AddConstant('KDC_FREQUENT',KDC_FREQUENT);
      AddConstant('KDC_RECENT',KDC_RECENT);
      AddConstant('ADLT_RECENT',ADLT_RECENT);
      AddConstant('ADLT_FREQUENT',ADLT_FREQUENT);
      AddConstant('HOMEGROUP_SECURITY_GROUP',HOMEGROUP_SECURITY_GROUP);
      AddConstant('HGSC_NONE',HGSC_NONE);
      AddConstant('HGSC_MUSICLIBRARY',HGSC_MUSICLIBRARY);
      AddConstant('HGSC_PICTURESLIBRARY',HGSC_PICTURESLIBRARY);
      AddConstant('HGSC_VIDEOSLIBRARY',HGSC_VIDEOSLIBRARY);
      AddConstant('HGSC_DOCUMENTSLIBRARY',HGSC_DOCUMENTSLIBRARY);
      AddConstant('HGSC_PRINTERS',HGSC_PRINTERS);
      AddConstant('LFF_FORCEFILESYSTEM',LFF_FORCEFILESYSTEM);
      AddConstant('LFF_STORAGEITEMS',LFF_STORAGEITEMS);
      AddConstant('LFF_ALLITEMS',LFF_ALLITEMS);
      AddConstant('LOF_DEFAULT',LOF_DEFAULT);
      AddConstant('LOF_PINNEDTONAVPANE',LOF_PINNEDTONAVPANE);
      AddConstant('LOF_MASK_ALL',LOF_MASK_ALL);
      AddConstant('DSFT_DETECT',DSFT_DETECT);
      AddConstant('DSFT_PRIVATE',DSFT_PRIVATE);
      AddConstant('DSFT_PUBLIC',DSFT_PUBLIC);
      AddConstant('LSF_FAILIFTHERE',LSF_FAILIFTHERE);
      AddConstant('LSF_OVERRIDEEXISTING',LSF_OVERRIDEEXISTING);
      AddConstant('LSF_MAKEUNIQUENAME',LSF_MAKEUNIQUENAME);
      AddConstant('LMD_DEFAULT',LMD_DEFAULT);
      AddConstant('LMD_ALLOWUNINDEXABLELOCATIONS',LMD_ALLOWUNINDEXABLELOCATIONS);
      AddConstant('ASSOC_FILTER_NONE',ASSOC_FILTER_NONE);
      AddConstant('ASSOC_FILTER_RECOMMENDED',ASSOC_FILTER_RECOMMENDED);
      AddConstant('SID_IExtractIconA',SID_IExtractIconA);
      AddConstant('SID_IExtractIconW',SID_IExtractIconW);
      AddConstant('SID_IShellIconOverlayIdentifier',SID_IShellIconOverlayIdentifier);
      AddConstant('SID_IShellIconOverlayManager',SID_IShellIconOverlayManager);
      AddConstant('SID_IShellIconOverlay',SID_IShellIconOverlay);
      AddConstant('SID_IShellExecuteHookA',SID_IShellExecuteHookA);
      AddConstant('SID_IShellExecuteHookW',SID_IShellExecuteHookW);
      AddConstant('SID_IURLSearchHook',SID_IURLSearchHook);
      AddConstant('SID_ISearchContext',SID_ISearchContext);
      AddConstant('SID_IURLSearchHook2',SID_IURLSearchHook2);
      AddConstant('SID_INewShortcutHookA',SID_INewShortcutHookA);
      AddConstant('SID_INewShortcutHookW',SID_INewShortcutHookW);
      AddConstant('SID_ICopyHookA',SID_ICopyHookA);
      AddConstant('SID_ICopyHookW',SID_ICopyHookW);
      AddConstant('SID_IShellCopyHookA',SID_IShellCopyHookA);
      AddConstant('SID_IShellCopyHookW',SID_IShellCopyHookW);
      AddConstant('SID_IFileViewerSite',SID_IFileViewerSite);
      AddConstant('SID_IFileViewerA',SID_IFileViewerA);
      AddConstant('SID_IFileViewerW',SID_IFileViewerW);
      AddConstant('SID_IShellDetails',SID_IShellDetails);
      AddConstant('SID_IObjMgr',SID_IObjMgr);
      AddConstant('SID_ICurrentWorkingDirectory',SID_ICurrentWorkingDirectory);
      AddConstant('SID_IACList',SID_IACList);
      AddConstant('SID_IACList2',SID_IACList2);
      AddConstant('SID_IProgressDialog',SID_IProgressDialog);
      AddConstant('SID_IDockingWindowSite',SID_IDockingWindowSite);
      AddConstant('SID_IDockingWindowFrame',SID_IDockingWindowFrame);
      AddConstant('SID_IThumbnailCapture',SID_IThumbnailCapture);
      AddConstant('SID_IEnumShellImageStore',SID_IEnumShellImageStore);
      AddConstant('SID_IShellImageStore',SID_IShellImageStore);
      AddConstant('SID_IShellFolderBand',SID_IShellFolderBand);
      AddConstant('SID_IDeskBarClient',SID_IDeskBarClient);
      AddConstant('SID_IActiveDesktop',SID_IActiveDesktop);
      AddConstant('SID_IActiveDesktopP',SID_IActiveDesktopP);
      AddConstant('SID_IADesktopP2',SID_IADesktopP2);
      AddConstant('SID_IColumnProvider',SID_IColumnProvider);
      AddConstant('SID_IShellChangeNotify',SID_IShellChangeNotify);
      AddConstant('SID_IQueryInfo',SID_IQueryInfo);
      AddConstant('SID_IDefViewFrame',SID_IDefViewFrame);
      AddConstant('SID_IDocViewSite',SID_IDocViewSite);
      AddConstant('SID_IInitializeObject',SID_IInitializeObject);
      AddConstant('SID_IBanneredBar',SID_IBanneredBar);
      AddConstant('SID_IShellFolderViewCB',SID_IShellFolderViewCB);
      AddConstant('SID_IShellFolderView',SID_IShellFolderView);
      AddConstant('SID_INamedPropertyBag',SID_INamedPropertyBag);
      AddConstant('SID_IEnumPrivacyRecords',SID_IEnumPrivacyRecords);
      AddConstant('GIL_OPENICON',GIL_OPENICON);
      AddConstant('GIL_FORSHELL',GIL_FORSHELL);
      AddConstant('GIL_ASYNC',GIL_ASYNC);
      AddConstant('GIL_DEFAULTICON',GIL_DEFAULTICON);
      AddConstant('GIL_FORSHORTCUT',GIL_FORSHORTCUT);
      AddConstant('GIL_CHECKSHIELD',GIL_CHECKSHIELD);
      AddConstant('GIL_SIMULATEDOC',GIL_SIMULATEDOC);
      AddConstant('GIL_PERINSTANCE',GIL_PERINSTANCE);
      AddConstant('GIL_PERCLASS',GIL_PERCLASS);
      AddConstant('GIL_NOTFILENAME',GIL_NOTFILENAME);
      AddConstant('GIL_DONTCACHE',GIL_DONTCACHE);
      AddConstant('GIL_SHIELD',GIL_SHIELD);
      AddConstant('GIL_FORCENOSHIELD',GIL_FORCENOSHIELD);
      AddConstant('ISIOI_ICONFILE',ISIOI_ICONFILE);
      AddConstant('ISIOI_ICONINDEX',ISIOI_ICONINDEX);
      AddConstant('ISIOI_SYSIMAGELISTINDEX',ISIOI_SYSIMAGELISTINDEX);
      AddConstant('SIOM_OVERLAYINDEX',SIOM_OVERLAYINDEX);
      AddConstant('SIOM_ICONINDEX',SIOM_ICONINDEX);
      AddConstant('SIOM_RESERVED_SHARED',SIOM_RESERVED_SHARED);
      AddConstant('SIOM_RESERVED_LINK',SIOM_RESERVED_LINK);
      AddConstant('SIOM_RESERVED_SLOWFILE',SIOM_RESERVED_SLOWFILE);
      AddConstant('SIOM_RESERVED_DEFAULT',SIOM_RESERVED_DEFAULT);
      AddConstant('OI_DEFAULT',OI_DEFAULT);
      AddConstant('OI_ASYNC',OI_ASYNC);
      AddConstant('IDO_SHGIOI_SHARE',IDO_SHGIOI_SHARE);
      AddConstant('IDO_SHGIOI_LINK',IDO_SHGIOI_LINK);
      AddConstant('IDO_SHGIOI_SLOWFILE',IDO_SHGIOI_SLOWFILE);
      AddConstant('IDO_SHGIOI_DEFAULT',IDO_SHGIOI_DEFAULT);
      AddConstant('SLDF_DEFAULT',SLDF_DEFAULT);
      AddConstant('SLDF_HAS_ID_LIST',SLDF_HAS_ID_LIST);
      AddConstant('SLDF_HAS_LINK_INFO',SLDF_HAS_LINK_INFO);
      AddConstant('SLDF_HAS_NAME',SLDF_HAS_NAME);
      AddConstant('SLDF_HAS_RELPATH',SLDF_HAS_RELPATH);
      AddConstant('SLDF_HAS_WORKINGDIR',SLDF_HAS_WORKINGDIR);
      AddConstant('SLDF_HAS_ARGS',SLDF_HAS_ARGS);
      AddConstant('SLDF_HAS_ICONLOCATION',SLDF_HAS_ICONLOCATION);
      AddConstant('SLDF_UNICODE',SLDF_UNICODE);
      AddConstant('SLDF_FORCE_NO_LINKINFO',SLDF_FORCE_NO_LINKINFO);
      AddConstant('SLDF_HAS_EXP_SZ',SLDF_HAS_EXP_SZ);
      AddConstant('SLDF_RUN_IN_SEPARATE',SLDF_RUN_IN_SEPARATE);
      AddConstant('SLDF_HAS_LOGO3ID',SLDF_HAS_LOGO3ID);
      AddConstant('SLDF_HAS_DARWINID',SLDF_HAS_DARWINID);
      AddConstant('SLDF_RUNAS_USER',SLDF_RUNAS_USER);
      AddConstant('SLDF_HAS_EXP_ICON_SZ',SLDF_HAS_EXP_ICON_SZ);
      AddConstant('SLDF_NO_PIDL_ALIAS',SLDF_NO_PIDL_ALIAS);
      AddConstant('SLDF_FORCE_UNCNAME',SLDF_FORCE_UNCNAME);
      AddConstant('SLDF_RUN_WITH_SHIMLAYER',SLDF_RUN_WITH_SHIMLAYER);
      AddConstant('SLDF_FORCE_NO_LINKTRACK',SLDF_FORCE_NO_LINKTRACK);
      AddConstant('SLDF_ENABLE_TARGET_METADATA',SLDF_ENABLE_TARGET_METADATA);
      AddConstant('SLDF_DISABLE_LINK_PATH_TRACKING',SLDF_DISABLE_LINK_PATH_TRACKING);
      AddConstant('SLDF_DISABLE_KNOWNFOLDER_RELATIVE_TRACKING',SLDF_DISABLE_KNOWNFOLDER_RELATIVE_TRACKING);
      AddConstant('SLDF_NO_KF_ALIAS',SLDF_NO_KF_ALIAS);
      AddConstant('SLDF_ALLOW_LINK_TO_LINK',SLDF_ALLOW_LINK_TO_LINK);
      AddConstant('SLDF_UNALIAS_ON_SAVE',SLDF_UNALIAS_ON_SAVE);
      AddConstant('SLDF_PREFER_ENVIRONMENT_PATH',SLDF_PREFER_ENVIRONMENT_PATH);
      AddConstant('SLDF_KEEP_LOCAL_IDLIST_FOR_UNC_TARGET',SLDF_KEEP_LOCAL_IDLIST_FOR_UNC_TARGET);
      AddConstant('SLDF_VALID',SLDF_VALID);
      AddConstant('SLDF_RESERVED',SLDF_RESERVED);
      AddConstant('NT_CONSOLE_PROPS_SIG',NT_CONSOLE_PROPS_SIG);
      AddConstant('NT_FE_CONSOLE_PROPS_SIG',NT_FE_CONSOLE_PROPS_SIG);
      AddConstant('EXP_DARWIN_ID_SIG',EXP_DARWIN_ID_SIG);
      AddConstant('EXP_SPECIAL_FOLDER_SIG',EXP_SPECIAL_FOLDER_SIG);
      AddConstant('EXP_SZ_LINK_SIG',EXP_SZ_LINK_SIG);
      AddConstant('EXP_SZ_ICON_SIG',EXP_SZ_ICON_SIG);
      AddConstant('EXP_PROPERTYSTORAGE_SIG',EXP_PROPERTYSTORAGE_SIG);
      AddConstant('FVSIF_RECT',FVSIF_RECT);
      AddConstant('FVSIF_PINNED',FVSIF_PINNED);
      AddConstant('FVSIF_NEWFAILED',FVSIF_NEWFAILED);
      AddConstant('FVSIF_NEWFILE',FVSIF_NEWFILE);
      AddConstant('FVSIF_CANVIEWIT',FVSIF_CANVIEWIT);
    end;
  end;

  procedure AddConsts3;
  begin
    with Scripter.DefineClass(ClassType) do
    begin
      AddConstant('FCIDM_SHVIEWFIRST',FCIDM_SHVIEWFIRST);
      AddConstant('FCIDM_SHVIEWLAST',FCIDM_SHVIEWLAST);
      AddConstant('FCIDM_BROWSERFIRST',FCIDM_BROWSERFIRST);
      AddConstant('FCIDM_BROWSERLAST',FCIDM_BROWSERLAST);
      AddConstant('FCIDM_GLOBALFIRST',FCIDM_GLOBALFIRST);
      AddConstant('FCIDM_GLOBALLAST',FCIDM_GLOBALLAST);
      AddConstant('FCIDM_MENU_FILE',FCIDM_MENU_FILE);
      AddConstant('FCIDM_MENU_EDIT',FCIDM_MENU_EDIT);
      AddConstant('FCIDM_MENU_VIEW',FCIDM_MENU_VIEW);
      AddConstant('FCIDM_MENU_VIEW_SEP_OPTIONS',FCIDM_MENU_VIEW_SEP_OPTIONS);
      AddConstant('FCIDM_MENU_TOOLS',FCIDM_MENU_TOOLS);
      AddConstant('FCIDM_MENU_TOOLS_SEP_GOTO',FCIDM_MENU_TOOLS_SEP_GOTO);
      AddConstant('FCIDM_MENU_HELP',FCIDM_MENU_HELP);
      AddConstant('FCIDM_MENU_FIND',FCIDM_MENU_FIND);
      AddConstant('FCIDM_MENU_EXPLORE',FCIDM_MENU_EXPLORE);
      AddConstant('FCIDM_MENU_FAVORITES',FCIDM_MENU_FAVORITES);
      AddConstant('FCIDM_TOOLBAR',FCIDM_TOOLBAR);
      AddConstant('FCIDM_STATUS',FCIDM_STATUS);
      AddConstant('IDC_OFFLINE_HAND',IDC_OFFLINE_HAND);
      AddConstant('IDC_PANTOOL_HAND_OPEN',IDC_PANTOOL_HAND_OPEN);
      AddConstant('IDC_PANTOOL_HAND_CLOSED',IDC_PANTOOL_HAND_CLOSED);
      AddConstant('PANE_NONE',PANE_NONE);
      AddConstant('PANE_ZONE',PANE_ZONE);
      AddConstant('PANE_OFFLINE',PANE_OFFLINE);
      AddConstant('PANE_PRINTER',PANE_PRINTER);
      AddConstant('PANE_SSL',PANE_SSL);
      AddConstant('PANE_NAVIGATION',PANE_NAVIGATION);
      AddConstant('PANE_PROGRESS',PANE_PROGRESS);
      AddConstant('PANE_PRIVACY',PANE_PRIVACY);
      AddConstant('GPFIDL_DEFAULT',GPFIDL_DEFAULT);
      AddConstant('GPFIDL_ALTNAME',GPFIDL_ALTNAME);
      AddConstant('GPFIDL_UNCPRINTER',GPFIDL_UNCPRINTER);
      AddConstant('OFASI_EDIT',OFASI_EDIT);
      AddConstant('OFASI_OPENDESKTOP',OFASI_OPENDESKTOP);
      AddConstant('REGSTR_PATH_SPECIAL_FOLDERS',REGSTR_PATH_SPECIAL_FOLDERS);
      AddConstant('CSIDL_DESKTOP',CSIDL_DESKTOP);
      AddConstant('CSIDL_INTERNET',CSIDL_INTERNET);
      AddConstant('CSIDL_PROGRAMS',CSIDL_PROGRAMS);
      AddConstant('CSIDL_CONTROLS',CSIDL_CONTROLS);
      AddConstant('CSIDL_PRINTERS',CSIDL_PRINTERS);
      AddConstant('CSIDL_PERSONAL',CSIDL_PERSONAL);
      AddConstant('CSIDL_FAVORITES',CSIDL_FAVORITES);
      AddConstant('CSIDL_STARTUP',CSIDL_STARTUP);
      AddConstant('CSIDL_RECENT',CSIDL_RECENT);
      AddConstant('CSIDL_SENDTO',CSIDL_SENDTO);
      AddConstant('CSIDL_BITBUCKET',CSIDL_BITBUCKET);
      AddConstant('CSIDL_STARTMENU',CSIDL_STARTMENU);
      AddConstant('CSIDL_MYDOCUMENTS',CSIDL_MYDOCUMENTS);
      AddConstant('CSIDL_MYMUSIC',CSIDL_MYMUSIC);
      AddConstant('CSIDL_MYVIDEO',CSIDL_MYVIDEO);
      AddConstant('CSIDL_DESKTOPDIRECTORY',CSIDL_DESKTOPDIRECTORY);
      AddConstant('CSIDL_DRIVES',CSIDL_DRIVES);
      AddConstant('CSIDL_NETWORK',CSIDL_NETWORK);
      AddConstant('CSIDL_NETHOOD',CSIDL_NETHOOD);
      AddConstant('CSIDL_FONTS',CSIDL_FONTS);
      AddConstant('CSIDL_TEMPLATES',CSIDL_TEMPLATES);
      AddConstant('CSIDL_COMMON_STARTMENU',CSIDL_COMMON_STARTMENU);
      AddConstant('CSIDL_COMMON_PROGRAMS',CSIDL_COMMON_PROGRAMS);
      AddConstant('CSIDL_COMMON_STARTUP',CSIDL_COMMON_STARTUP);
      AddConstant('CSIDL_COMMON_DESKTOPDIRECTORY',CSIDL_COMMON_DESKTOPDIRECTORY);
      AddConstant('CSIDL_APPDATA',CSIDL_APPDATA);
      AddConstant('CSIDL_PRINTHOOD',CSIDL_PRINTHOOD);
      AddConstant('CSIDL_LOCAL_APPDATA',CSIDL_LOCAL_APPDATA);
      AddConstant('CSIDL_ALTSTARTUP',CSIDL_ALTSTARTUP);
      AddConstant('CSIDL_COMMON_ALTSTARTUP',CSIDL_COMMON_ALTSTARTUP);
      AddConstant('CSIDL_COMMON_FAVORITES',CSIDL_COMMON_FAVORITES);
      AddConstant('CSIDL_INTERNET_CACHE',CSIDL_INTERNET_CACHE);
      AddConstant('CSIDL_COOKIES',CSIDL_COOKIES);
      AddConstant('CSIDL_HISTORY',CSIDL_HISTORY);
      AddConstant('CSIDL_COMMON_APPDATA',CSIDL_COMMON_APPDATA);
      AddConstant('CSIDL_WINDOWS',CSIDL_WINDOWS);
      AddConstant('CSIDL_SYSTEM',CSIDL_SYSTEM);
      AddConstant('CSIDL_PROGRAM_FILES',CSIDL_PROGRAM_FILES);
      AddConstant('CSIDL_MYPICTURES',CSIDL_MYPICTURES);
      AddConstant('CSIDL_PROFILE',CSIDL_PROFILE);
      AddConstant('CSIDL_SYSTEMX86',CSIDL_SYSTEMX86);
      AddConstant('CSIDL_PROGRAM_FILESX86',CSIDL_PROGRAM_FILESX86);
      AddConstant('CSIDL_PROGRAM_FILES_COMMON',CSIDL_PROGRAM_FILES_COMMON);
      AddConstant('CSIDL_PROGRAM_FILES_COMMONX86',CSIDL_PROGRAM_FILES_COMMONX86);
      AddConstant('CSIDL_COMMON_TEMPLATES',CSIDL_COMMON_TEMPLATES);
      AddConstant('CSIDL_COMMON_DOCUMENTS',CSIDL_COMMON_DOCUMENTS);
      AddConstant('CSIDL_COMMON_ADMINTOOLS',CSIDL_COMMON_ADMINTOOLS);
      AddConstant('CSIDL_ADMINTOOLS',CSIDL_ADMINTOOLS);
      AddConstant('CSIDL_CONNECTIONS',CSIDL_CONNECTIONS);
      AddConstant('CSIDL_COMMON_MUSIC',CSIDL_COMMON_MUSIC);
      AddConstant('CSIDL_COMMON_PICTURES',CSIDL_COMMON_PICTURES);
      AddConstant('CSIDL_COMMON_VIDEO',CSIDL_COMMON_VIDEO);
      AddConstant('CSIDL_RESOURCES',CSIDL_RESOURCES);
      AddConstant('CSIDL_RESOURCES_LOCALIZED',CSIDL_RESOURCES_LOCALIZED);
      AddConstant('CSIDL_COMMON_OEM_LINKS',CSIDL_COMMON_OEM_LINKS);
      AddConstant('CSIDL_CDBURN_AREA',CSIDL_CDBURN_AREA);
      AddConstant('CSIDL_COMPUTERSNEARME',CSIDL_COMPUTERSNEARME);
      AddConstant('CSIDL_FLAG_CREATE',CSIDL_FLAG_CREATE);
      AddConstant('CSIDL_FLAG_DONT_VERIFY',CSIDL_FLAG_DONT_VERIFY);
      AddConstant('CSIDL_FLAG_DONT_UNEXPAND',CSIDL_FLAG_DONT_UNEXPAND);
      AddConstant('CSIDL_FLAG_NO_ALIAS',CSIDL_FLAG_NO_ALIAS);
      AddConstant('CSIDL_FLAG_PER_USER_INIT',CSIDL_FLAG_PER_USER_INIT);
      AddConstant('CSIDL_FLAG_MASK',CSIDL_FLAG_MASK);
      AddConstant('CSIDL_PROFILES',CSIDL_PROFILES);
      AddConstant('SHGFP_TYPE_CURRENT',SHGFP_TYPE_CURRENT);
      AddConstant('SHGFP_TYPE_DEFAULT',SHGFP_TYPE_DEFAULT);
      AddConstant('KF_FLAG_DEFAULT',KF_FLAG_DEFAULT);
      AddConstant('KF_FLAG_CREATE',KF_FLAG_CREATE);
      AddConstant('KF_FLAG_DONT_VERIFY',KF_FLAG_DONT_VERIFY);
      AddConstant('KF_FLAG_DONT_UNEXPAND',KF_FLAG_DONT_UNEXPAND);
      AddConstant('KF_FLAG_NO_ALIAS',KF_FLAG_NO_ALIAS);
      AddConstant('KF_FLAG_INIT',KF_FLAG_INIT);
      AddConstant('KF_FLAG_DEFAULT_PATH',KF_FLAG_DEFAULT_PATH);
      AddConstant('KF_FLAG_NOT_PARENT_RELATIVE',KF_FLAG_NOT_PARENT_RELATIVE);
      AddConstant('KF_FLAG_SIMPLE_IDLIST',KF_FLAG_SIMPLE_IDLIST);
      AddConstant('KF_FLAG_ALIAS_ONLY',KF_FLAG_ALIAS_ONLY);
      AddConstant('FCS_READ',FCS_READ);
      AddConstant('FCS_FORCEWRITE',FCS_FORCEWRITE);
      AddConstant('FCS_WRITE',FCS_WRITE);
      AddConstant('FCS_FLAG_DRAGDROP',FCS_FLAG_DRAGDROP);
      AddConstant('FCSM_VIEWID',FCSM_VIEWID);
      AddConstant('FCSM_WEBVIEWTEMPLATE',FCSM_WEBVIEWTEMPLATE);
      AddConstant('FCSM_INFOTIP',FCSM_INFOTIP);
      AddConstant('FCSM_CLSID',FCSM_CLSID);
      AddConstant('FCSM_ICONFILE',FCSM_ICONFILE);
      AddConstant('FCSM_LOGO',FCSM_LOGO);
      AddConstant('FCSM_FLAGS',FCSM_FLAGS);
      AddConstant('BIF_RETURNONLYFSDIRS',BIF_RETURNONLYFSDIRS);
      AddConstant('BIF_DONTGOBELOWDOMAIN',BIF_DONTGOBELOWDOMAIN);
      AddConstant('BIF_STATUSTEXT',BIF_STATUSTEXT);
      AddConstant('BIF_RETURNFSANCESTORS',BIF_RETURNFSANCESTORS);
      AddConstant('BIF_EDITBOX',BIF_EDITBOX);
      AddConstant('BIF_VALIDATE',BIF_VALIDATE);
      AddConstant('BIF_NEWDIALOGSTYLE',BIF_NEWDIALOGSTYLE);
      AddConstant('BIF_USENEWUI',BIF_USENEWUI);
      AddConstant('BIF_BROWSEINCLUDEURLS',BIF_BROWSEINCLUDEURLS);
      AddConstant('BIF_UAHINT',BIF_UAHINT);
      AddConstant('BIF_NONEWFOLDERBUTTON',BIF_NONEWFOLDERBUTTON);
      AddConstant('BIF_NOTRANSLATETARGETS',BIF_NOTRANSLATETARGETS);
      AddConstant('BIF_BROWSEFORCOMPUTER',BIF_BROWSEFORCOMPUTER);
      AddConstant('BIF_BROWSEFORPRINTER',BIF_BROWSEFORPRINTER);
      AddConstant('BIF_BROWSEINCLUDEFILES',BIF_BROWSEINCLUDEFILES);
      AddConstant('BIF_SHAREABLE',BIF_SHAREABLE);
      AddConstant('BIF_BROWSEFILEJUNCTIONS',BIF_BROWSEFILEJUNCTIONS);
      AddConstant('BFFM_INITIALIZED',BFFM_INITIALIZED);
      AddConstant('BFFM_SELCHANGED',BFFM_SELCHANGED);
      AddConstant('BFFM_VALIDATEFAILEDA',BFFM_VALIDATEFAILEDA);
      AddConstant('BFFM_VALIDATEFAILEDW',BFFM_VALIDATEFAILEDW);
      AddConstant('BFFM_IUNKNOWN',BFFM_IUNKNOWN);
      AddConstant('BFFM_SETSTATUSTEXTA',BFFM_SETSTATUSTEXTA);
      AddConstant('BFFM_ENABLEOK',BFFM_ENABLEOK);
      AddConstant('BFFM_SETSELECTIONA',BFFM_SETSELECTIONA);
      AddConstant('BFFM_SETSELECTIONW',BFFM_SETSELECTIONW);
      AddConstant('BFFM_SETSTATUSTEXTW',BFFM_SETSTATUSTEXTW);
      AddConstant('BFFM_SETOKTEXT',BFFM_SETOKTEXT);
      AddConstant('BFFM_SETEXPANDED',BFFM_SETEXPANDED);
      AddConstant('BFFM_VALIDATEFAILED',BFFM_VALIDATEFAILED);
      AddConstant('BFFM_SETSTATUSTEXT',BFFM_SETSTATUSTEXT);
      AddConstant('BFFM_SETSELECTION',BFFM_SETSELECTION);
      AddConstant('ISHCUTCMDID_DOWNLOADICON',ISHCUTCMDID_DOWNLOADICON);
      AddConstant('ISHCUTCMDID_INTSHORTCUTCREATE',ISHCUTCMDID_INTSHORTCUTCREATE);
      AddConstant('ISHCUTCMDID_COMMITHISTORY',ISHCUTCMDID_COMMITHISTORY);
      AddConstant('ISHCUTCMDID_SETUSERAWURL',ISHCUTCMDID_SETUSERAWURL);
      AddConstant('CMDID_INTSHORTCUTCREATE',CMDID_INTSHORTCUTCREATE);
      AddConstant('STR_PARSE_WITH_PROPERTIES',STR_PARSE_WITH_PROPERTIES);
      AddConstant('STR_PARSE_PARTIAL_IDLIST',STR_PARSE_PARTIAL_IDLIST);
      AddConstant('ACLO_NONE',ACLO_NONE);
      AddConstant('ACLO_CURRENTDIR',ACLO_CURRENTDIR);
      AddConstant('ACLO_MYCOMPUTER',ACLO_MYCOMPUTER);
      AddConstant('ACLO_DESKTOP',ACLO_DESKTOP);
      AddConstant('ACLO_FAVORITES',ACLO_FAVORITES);
      AddConstant('ACLO_FILESYSONLY',ACLO_FILESYSONLY);
      AddConstant('ACLO_FILESYSDIRS',ACLO_FILESYSDIRS);
      AddConstant('ACLO_VIRTUALNAMESPACE',ACLO_VIRTUALNAMESPACE);
      AddConstant('PROGDLG_NORMAL',PROGDLG_NORMAL);
      AddConstant('PROGDLG_MODAL',PROGDLG_MODAL);
      AddConstant('PROGDLG_AUTOTIME',PROGDLG_AUTOTIME);
      AddConstant('PROGDLG_NOTIME',PROGDLG_NOTIME);
      AddConstant('PROGDLG_NOMINIMIZE',PROGDLG_NOMINIMIZE);
      AddConstant('PROGDLG_NOPROGRESSBAR',PROGDLG_NOPROGRESSBAR);
      AddConstant('PROGDLG_MARQUEEPROGRESS',PROGDLG_MARQUEEPROGRESS);
      AddConstant('PROGDLG_NOCANCEL',PROGDLG_NOCANCEL);
      AddConstant('PDTIMER_RESET',PDTIMER_RESET);
      AddConstant('PDTIMER_PAUSE',PDTIMER_PAUSE);
      AddConstant('PDTIMER_RESUME',PDTIMER_RESUME);
      AddConstant('DWFRF_NORMAL',DWFRF_NORMAL);
      AddConstant('DWFRF_DELETECONFIGDATA',DWFRF_DELETECONFIGDATA);
      AddConstant('DWFAF_HIDDEN',DWFAF_HIDDEN);
      AddConstant('DWFAF_GROUP1',DWFAF_GROUP1);
      AddConstant('DWFAF_GROUP2',DWFAF_GROUP2);
      AddConstant('DWFAF_AUTOHIDE',DWFAF_AUTOHIDE);
      AddConstant('SHIMSTCAPFLAG_LOCKABLE',SHIMSTCAPFLAG_LOCKABLE);
      AddConstant('SHIMSTCAPFLAG_PURGEABLE',SHIMSTCAPFLAG_PURGEABLE);
      AddConstant('ISFB_MASK_STATE',ISFB_MASK_STATE);
      AddConstant('ISFB_MASK_BKCOLOR',ISFB_MASK_BKCOLOR);
      AddConstant('ISFB_MASK_VIEWMODE',ISFB_MASK_VIEWMODE);
      AddConstant('ISFB_MASK_SHELLFOLDER',ISFB_MASK_SHELLFOLDER);
      AddConstant('ISFB_MASK_IDLIST',ISFB_MASK_IDLIST);
      AddConstant('ISFB_MASK_COLORS',ISFB_MASK_COLORS);
      AddConstant('ISFB_STATE_DEFAULT',ISFB_STATE_DEFAULT);
      AddConstant('ISFB_STATE_DEBOSSED',ISFB_STATE_DEBOSSED);
      AddConstant('ISFB_STATE_ALLOWRENAME',ISFB_STATE_ALLOWRENAME);
      AddConstant('ISFB_STATE_NOSHOWTEXT',ISFB_STATE_NOSHOWTEXT);
      AddConstant('ISFB_STATE_CHANNELBAR',ISFB_STATE_CHANNELBAR);
      AddConstant('ISFB_STATE_QLINKSMODE',ISFB_STATE_QLINKSMODE);
      AddConstant('ISFB_STATE_FULLOPEN',ISFB_STATE_FULLOPEN);
      AddConstant('ISFB_STATE_NONAMESORT',ISFB_STATE_NONAMESORT);
      AddConstant('ISFB_STATE_BTNMINSIZE',ISFB_STATE_BTNMINSIZE);
      AddConstant('ISFBVIEWMODE_SMALLICONS',ISFBVIEWMODE_SMALLICONS);
      AddConstant('ISFBVIEWMODE_LARGEICONS',ISFBVIEWMODE_LARGEICONS);
      AddConstant('ISFBVIEWMODE_LOGOS',ISFBVIEWMODE_LOGOS);
      AddConstant('SFBID_PIDLCHANGED',SFBID_PIDLCHANGED);
      AddConstant('DBC_GS_IDEAL',DBC_GS_IDEAL);
      AddConstant('DBC_GS_SIZEDOWN',DBC_GS_SIZEDOWN);
      AddConstant('DBC_HIDE',DBC_HIDE);
      AddConstant('DBC_SHOW',DBC_SHOW);
      AddConstant('DBC_SHOWOBSCURE',DBC_SHOWOBSCURE);
      AddConstant('DBCID_EMPTY',DBCID_EMPTY);
      AddConstant('DBCID_ONDRAG',DBCID_ONDRAG);
      AddConstant('DBCID_CLSIDOFBAR',DBCID_CLSIDOFBAR);
      AddConstant('DBCID_RESIZE',DBCID_RESIZE);
      AddConstant('DBCID_GETBAR',DBCID_GETBAR);
      AddConstant('COMPONENT_TOP',COMPONENT_TOP);
      AddConstant('COMP_TYPE_HTMLDOC',COMP_TYPE_HTMLDOC);
      AddConstant('COMP_TYPE_PICTURE',COMP_TYPE_PICTURE);
      AddConstant('COMP_TYPE_WEBSITE',COMP_TYPE_WEBSITE);
      AddConstant('COMP_TYPE_CONTROL',COMP_TYPE_CONTROL);
      AddConstant('COMP_TYPE_CFHTML',COMP_TYPE_CFHTML);
      AddConstant('COMP_TYPE_MAX',COMP_TYPE_MAX);
      AddConstant('IS_NORMAL',IS_NORMAL);
      AddConstant('IS_FULLSCREEN',IS_FULLSCREEN);
      AddConstant('IS_SPLIT',IS_SPLIT);
      AddConstant('IS_VALIDSIZESTATEBITS',IS_VALIDSIZESTATEBITS);
      AddConstant('IS_VALIDSTATEBITS',IS_VALIDSTATEBITS);
      AddConstant('AD_APPLY_SAVE',AD_APPLY_SAVE);
      AddConstant('AD_APPLY_HTMLGEN',AD_APPLY_HTMLGEN);
      AddConstant('AD_APPLY_REFRESH',AD_APPLY_REFRESH);
      AddConstant('AD_APPLY_ALL',AD_APPLY_ALL);
      AddConstant('AD_APPLY_FORCE',AD_APPLY_FORCE);
      AddConstant('AD_APPLY_BUFFERED_REFRESH',AD_APPLY_BUFFERED_REFRESH);
      AddConstant('AD_APPLY_DYNAMICREFRESH',AD_APPLY_DYNAMICREFRESH);
      AddConstant('AD_GETWP_BMP',AD_GETWP_BMP);
      AddConstant('AD_GETWP_IMAGE',AD_GETWP_IMAGE);
      AddConstant('AD_GETWP_LAST_APPLIED',AD_GETWP_LAST_APPLIED);
      AddConstant('WPSTYLE_CENTER',WPSTYLE_CENTER);
      AddConstant('WPSTYLE_TILE',WPSTYLE_TILE);
      AddConstant('WPSTYLE_STRETCH',WPSTYLE_STRETCH);
      AddConstant('WPSTYLE_KEEPASPECT',WPSTYLE_KEEPASPECT);
      AddConstant('WPSTYLE_CROPTOFIT',WPSTYLE_CROPTOFIT);
      AddConstant('WPSTYLE_MAX',WPSTYLE_MAX);
      AddConstant('COMP_ELEM_TYPE',COMP_ELEM_TYPE);
      AddConstant('COMP_ELEM_CHECKED',COMP_ELEM_CHECKED);
      AddConstant('COMP_ELEM_DIRTY',COMP_ELEM_DIRTY);
      AddConstant('COMP_ELEM_NOSCROLL',COMP_ELEM_NOSCROLL);
      AddConstant('COMP_ELEM_POS_LEFT',COMP_ELEM_POS_LEFT);
      AddConstant('COMP_ELEM_POS_TOP',COMP_ELEM_POS_TOP);
      AddConstant('COMP_ELEM_SIZE_WIDTH',COMP_ELEM_SIZE_WIDTH);
      AddConstant('COMP_ELEM_SIZE_HEIGHT',COMP_ELEM_SIZE_HEIGHT);
      AddConstant('COMP_ELEM_POS_ZINDEX',COMP_ELEM_POS_ZINDEX);
      AddConstant('COMP_ELEM_SOURCE',COMP_ELEM_SOURCE);
      AddConstant('COMP_ELEM_FRIENDLYNAME',COMP_ELEM_FRIENDLYNAME);
      AddConstant('COMP_ELEM_SUBSCRIBEDURL',COMP_ELEM_SUBSCRIBEDURL);
      AddConstant('COMP_ELEM_ORIGINAL_CSI',COMP_ELEM_ORIGINAL_CSI);
      AddConstant('COMP_ELEM_RESTORED_CSI',COMP_ELEM_RESTORED_CSI);
      AddConstant('COMP_ELEM_CURITEMSTATE',COMP_ELEM_CURITEMSTATE);
      AddConstant('COMP_ELEM_ALL',COMP_ELEM_ALL);
      AddConstant('DTI_ADDUI_DEFAULT',DTI_ADDUI_DEFAULT);
      AddConstant('DTI_ADDUI_DISPSUBWIZARD',DTI_ADDUI_DISPSUBWIZARD);
      AddConstant('DTI_ADDUI_POSITIONITEM',DTI_ADDUI_POSITIONITEM);
      AddConstant('ADDURL_SILENT',ADDURL_SILENT);
      AddConstant('COMPONENT_DEFAULT_LEFT',COMPONENT_DEFAULT_LEFT);
      AddConstant('COMPONENT_DEFAULT_TOP',COMPONENT_DEFAULT_TOP);
      AddConstant('SSM_CLEAR',SSM_CLEAR);
      AddConstant('SSM_SET',SSM_SET);
      AddConstant('SSM_REFRESH',SSM_REFRESH);
      AddConstant('SSM_UPDATE',SSM_UPDATE);
      AddConstant('SCHEME_DISPLAY',SCHEME_DISPLAY);
      AddConstant('SCHEME_EDIT',SCHEME_EDIT);
      AddConstant('SCHEME_LOCAL',SCHEME_LOCAL);
      AddConstant('SCHEME_GLOBAL',SCHEME_GLOBAL);
      AddConstant('SCHEME_REFRESH',SCHEME_REFRESH);
      AddConstant('SCHEME_UPDATE',SCHEME_UPDATE);
      AddConstant('SCHEME_DONOTUSE',SCHEME_DONOTUSE);
      AddConstant('SCHEME_CREATE',SCHEME_CREATE);
      AddConstant('GADOF_DIRTY',GADOF_DIRTY);
      AddConstant('MAX_COLUMN_NAME_LEN',MAX_COLUMN_NAME_LEN);
      AddConstant('MAX_COLUMN_DESC_LEN',MAX_COLUMN_DESC_LEN);
      AddConstant('SHCDF_UPDATEITEM',SHCDF_UPDATEITEM);
      AddConstant('CFSTR_SHELLIDLIST',CFSTR_SHELLIDLIST);
      AddConstant('CFSTR_SHELLIDLISTOFFSET',CFSTR_SHELLIDLISTOFFSET);
      AddConstant('CFSTR_NETRESOURCES',CFSTR_NETRESOURCES);
      AddConstant('CFSTR_FILEDESCRIPTORA',CFSTR_FILEDESCRIPTORA);
      AddConstant('CFSTR_FILEDESCRIPTORW',CFSTR_FILEDESCRIPTORW);
      AddConstant('CFSTR_FILECONTENTS',CFSTR_FILECONTENTS);
      AddConstant('CFSTR_FILENAMEA',CFSTR_FILENAMEA);
      AddConstant('CFSTR_FILENAMEW',CFSTR_FILENAMEW);
      AddConstant('CFSTR_PRINTERGROUP',CFSTR_PRINTERGROUP);
      AddConstant('CFSTR_FILENAMEMAPA',CFSTR_FILENAMEMAPA);
      AddConstant('CFSTR_FILENAMEMAPW',CFSTR_FILENAMEMAPW);
      AddConstant('CFSTR_SHELLURL',CFSTR_SHELLURL);
      AddConstant('CFSTR_INETURLA',CFSTR_INETURLA);
      AddConstant('CFSTR_INETURLW',CFSTR_INETURLW);
      AddConstant('CFSTR_PREFERREDDROPEFFECT',CFSTR_PREFERREDDROPEFFECT);
      AddConstant('CFSTR_PERFORMEDDROPEFFECT',CFSTR_PERFORMEDDROPEFFECT);
      AddConstant('CFSTR_PASTESUCCEEDED',CFSTR_PASTESUCCEEDED);
      AddConstant('CFSTR_INDRAGLOOP',CFSTR_INDRAGLOOP);
      AddConstant('CFSTR_MOUNTEDVOLUME',CFSTR_MOUNTEDVOLUME);
      AddConstant('CFSTR_PERSISTEDDATAOBJECT',CFSTR_PERSISTEDDATAOBJECT);
      AddConstant('CFSTR_TARGETCLSID',CFSTR_TARGETCLSID);
      AddConstant('CFSTR_LOGICALPERFORMEDDROPEFFECT',CFSTR_LOGICALPERFORMEDDROPEFFECT);
      AddConstant('CFSTR_AUTOPLAY_SHELLIDLISTS',CFSTR_AUTOPLAY_SHELLIDLISTS);
      AddConstant('CFSTR_UNTRUSTEDDRAGDROP',CFSTR_UNTRUSTEDDRAGDROP);
      AddConstant('CFSTR_FILE_ATTRIBUTES_ARRAY',CFSTR_FILE_ATTRIBUTES_ARRAY);
      AddConstant('CFSTR_INVOKECOMMAND_DROPPARAM',CFSTR_INVOKECOMMAND_DROPPARAM);
      AddConstant('CFSTR_SHELLDROPHANDLER',CFSTR_SHELLDROPHANDLER);
      AddConstant('CFSTR_DROPDESCRIPTION',CFSTR_DROPDESCRIPTION);
      AddConstant('CFSTR_FILEDESCRIPTOR',CFSTR_FILEDESCRIPTOR);
      AddConstant('CFSTR_FILENAME',CFSTR_FILENAME);
      AddConstant('CFSTR_FILENAMEMAP',CFSTR_FILENAMEMAP);
      AddConstant('CFSTR_INETURL',CFSTR_INETURL);
      AddConstant('DVASPECT_SHORTNAME',DVASPECT_SHORTNAME);
      AddConstant('DVASPECT_COPY',DVASPECT_COPY);
      AddConstant('DVASPECT_LINK',DVASPECT_LINK);
      AddConstant('FD_CLSID',FD_CLSID);
      AddConstant('FD_SIZEPOINT',FD_SIZEPOINT);
      AddConstant('FD_ATTRIBUTES',FD_ATTRIBUTES);
      AddConstant('FD_CREATETIME',FD_CREATETIME);
      AddConstant('FD_ACCESSTIME',FD_ACCESSTIME);
      AddConstant('FD_WRITESTIME',FD_WRITESTIME);
      AddConstant('FD_FILESIZE',FD_FILESIZE);
      AddConstant('FD_PROGRESSUI',FD_PROGRESSUI);
      AddConstant('FD_LINKUI',FD_LINKUI);
      AddConstant('FD_UNICODE',FD_UNICODE);
      AddConstant('DROPIMAGE_INVALID',DROPIMAGE_INVALID);
      AddConstant('DROPIMAGE_NONE',DROPIMAGE_NONE);
      AddConstant('DROPIMAGE_COPY',DROPIMAGE_COPY);
      AddConstant('DROPIMAGE_MOVE',DROPIMAGE_MOVE);
      AddConstant('DROPIMAGE_LINK',DROPIMAGE_LINK);
      AddConstant('DROPIMAGE_LABEL',DROPIMAGE_LABEL);
      AddConstant('DROPIMAGE_WARNING',DROPIMAGE_WARNING);
      AddConstant('DROPIMAGE_NOIMAGE',DROPIMAGE_NOIMAGE);
      AddConstant('SHCNRF_InterruptLevel',SHCNRF_InterruptLevel);
      AddConstant('SHCNRF_ShellLevel',SHCNRF_ShellLevel);
      AddConstant('SHCNRF_RecursiveInterrupt',SHCNRF_RecursiveInterrupt);
      AddConstant('SHCNRF_NewDelivery',SHCNRF_NewDelivery);
      AddConstant('SHCNE_RENAMEITEM',SHCNE_RENAMEITEM);
      AddConstant('SHCNE_CREATE',SHCNE_CREATE);
      AddConstant('SHCNE_DELETE',SHCNE_DELETE);
      AddConstant('SHCNE_MKDIR',SHCNE_MKDIR);
      AddConstant('SHCNE_RMDIR',SHCNE_RMDIR);
      AddConstant('SHCNE_MEDIAINSERTED',SHCNE_MEDIAINSERTED);
      AddConstant('SHCNE_MEDIAREMOVED',SHCNE_MEDIAREMOVED);
      AddConstant('SHCNE_DRIVEREMOVED',SHCNE_DRIVEREMOVED);
      AddConstant('SHCNE_DRIVEADD',SHCNE_DRIVEADD);
      AddConstant('SHCNE_NETSHARE',SHCNE_NETSHARE);
      AddConstant('SHCNE_NETUNSHARE',SHCNE_NETUNSHARE);
      AddConstant('SHCNE_ATTRIBUTES',SHCNE_ATTRIBUTES);
      AddConstant('SHCNE_UPDATEDIR',SHCNE_UPDATEDIR);
      AddConstant('SHCNE_UPDATEITEM',SHCNE_UPDATEITEM);
      AddConstant('SHCNE_SERVERDISCONNECT',SHCNE_SERVERDISCONNECT);
      AddConstant('SHCNE_UPDATEIMAGE',SHCNE_UPDATEIMAGE);
      AddConstant('SHCNE_DRIVEADDGUI',SHCNE_DRIVEADDGUI);
      AddConstant('SHCNE_RENAMEFOLDER',SHCNE_RENAMEFOLDER);
      AddConstant('SHCNE_FREESPACE',SHCNE_FREESPACE);
      AddConstant('SHCNE_EXTENDED_EVENT',SHCNE_EXTENDED_EVENT);
      AddConstant('SHCNE_EXTENDED_EVENT_PRE_IE4',SHCNE_EXTENDED_EVENT_PRE_IE4);
      AddConstant('SHCNE_ASSOCCHANGED',SHCNE_ASSOCCHANGED);
      AddConstant('SHCNE_DISKEVENTS',SHCNE_DISKEVENTS);
      AddConstant('SHCNE_GLOBALEVENTS',SHCNE_GLOBALEVENTS);
      AddConstant('SHCNE_ALLEVENTS',SHCNE_ALLEVENTS);
      AddConstant('SHCNE_INTERRUPT',SHCNE_INTERRUPT);
      AddConstant('SHCNEE_THEMECHANGED',SHCNEE_THEMECHANGED);
      AddConstant('SHCNEE_ORDERCHANGED',SHCNEE_ORDERCHANGED);
      AddConstant('SHCNEE_MSI_CHANGE',SHCNEE_MSI_CHANGE);
      AddConstant('SHCNEE_MSI_UNINSTALL',SHCNEE_MSI_UNINSTALL);
      AddConstant('SHCNF_IDLIST',SHCNF_IDLIST);
      AddConstant('SHCNF_PATHA',SHCNF_PATHA);
      AddConstant('SHCNF_PRINTERA',SHCNF_PRINTERA);
      AddConstant('SHCNF_DWORD',SHCNF_DWORD);
      AddConstant('SHCNF_PATHW',SHCNF_PATHW);
      AddConstant('SHCNF_PRINTERW',SHCNF_PRINTERW);
      AddConstant('SHCNF_TYPE',SHCNF_TYPE);
      AddConstant('SHCNF_FLUSH',SHCNF_FLUSH);
      AddConstant('SHCNF_FLUSHNOWAIT',SHCNF_FLUSHNOWAIT);
      AddConstant('SHCNF_NOTIFYRECURSIVE',SHCNF_NOTIFYRECURSIVE);
      AddConstant('SHCNF_PATH',SHCNF_PATH);
      AddConstant('SHCNF_PRINTER',SHCNF_PRINTER);
      AddConstant('QITIPF_DEFAULT',QITIPF_DEFAULT);
      AddConstant('QITIPF_USENAME',QITIPF_USENAME);
      AddConstant('QITIPF_LINKNOTARGET',QITIPF_LINKNOTARGET);
      AddConstant('QITIPF_LINKUSETARGET',QITIPF_LINKUSETARGET);
      AddConstant('QITIPF_USESLOWTIP',QITIPF_USESLOWTIP);
      AddConstant('QITIPF_SINGLELINE',QITIPF_SINGLELINE);
      AddConstant('QIF_CACHED',QIF_CACHED);
      AddConstant('QIF_DONTEXPANDFOLDER',QIF_DONTEXPANDFOLDER);
      AddConstant('SHARD_PIDL',SHARD_PIDL);
      AddConstant('SHARD_PATHA',SHARD_PATHA);
      AddConstant('SHARD_PATHW',SHARD_PATHW);
      AddConstant('SHARD_PATH',SHARD_PATH);
      AddConstant('SHARD_APPIDINFO',SHARD_APPIDINFO);
      AddConstant('SHARD_APPIDINFOIDLIST',SHARD_APPIDINFOIDLIST);
      AddConstant('SHARD_LINK',SHARD_LINK);
      AddConstant('SHARD_APPIDINFOLINK',SHARD_APPIDINFOLINK);
      AddConstant('SHARD_SHELLITEM',SHARD_SHELLITEM);
      AddConstant('SCNRT_ENABLE',SCNRT_ENABLE);
      AddConstant('SCNRT_DISABLE',SCNRT_DISABLE);
      AddConstant('SHGDFIL_FINDDATA',SHGDFIL_FINDDATA);
      AddConstant('SHGDFIL_NETRESOURCE',SHGDFIL_NETRESOURCE);
      AddConstant('SHGDFIL_DESCRIPTIONID',SHGDFIL_DESCRIPTIONID);
      AddConstant('SHDID_ROOT_REGITEM',SHDID_ROOT_REGITEM);
      AddConstant('SHDID_FS_FILE',SHDID_FS_FILE);
      AddConstant('SHDID_FS_DIRECTORY',SHDID_FS_DIRECTORY);
      AddConstant('SHDID_FS_OTHER',SHDID_FS_OTHER);
      AddConstant('SHDID_COMPUTER_DRIVE35',SHDID_COMPUTER_DRIVE35);
      AddConstant('SHDID_COMPUTER_DRIVE525',SHDID_COMPUTER_DRIVE525);
      AddConstant('SHDID_COMPUTER_REMOVABLE',SHDID_COMPUTER_REMOVABLE);
      AddConstant('SHDID_COMPUTER_FIXED',SHDID_COMPUTER_FIXED);
      AddConstant('SHDID_COMPUTER_NETDRIVE',SHDID_COMPUTER_NETDRIVE);
      AddConstant('SHDID_COMPUTER_CDROM',SHDID_COMPUTER_CDROM);
      AddConstant('SHDID_COMPUTER_RAMDISK',SHDID_COMPUTER_RAMDISK);
      AddConstant('SHDID_COMPUTER_OTHER',SHDID_COMPUTER_OTHER);
      AddConstant('SHDID_NET_DOMAIN',SHDID_NET_DOMAIN);
      AddConstant('SHDID_NET_SERVER',SHDID_NET_SERVER);
      AddConstant('SHDID_NET_SHARE',SHDID_NET_SHARE);
      AddConstant('SHDID_NET_RESTOFNET',SHDID_NET_RESTOFNET);
      AddConstant('SHDID_NET_OTHER',SHDID_NET_OTHER);
      AddConstant('SHDID_COMPUTER_IMAGING',SHDID_COMPUTER_IMAGING);
      AddConstant('SHDID_COMPUTER_AUDIO',SHDID_COMPUTER_AUDIO);
      AddConstant('SHDID_COMPUTER_SHAREDDOCS',SHDID_COMPUTER_SHAREDDOCS);
      AddConstant('SHDID_MOBILE_DEVICE',SHDID_MOBILE_DEVICE);
      AddConstant('PRF_VERIFYEXISTS',PRF_VERIFYEXISTS);
      AddConstant('PRF_TRYPROGRAMEXTENSIONS',PRF_TRYPROGRAMEXTENSIONS);
      AddConstant('PRF_FIRSTDIRDEF',PRF_FIRSTDIRDEF);
      AddConstant('PRF_DONTFINDLNK',PRF_DONTFINDLNK);
      AddConstant('PRF_REQUIREABSOLUTE',PRF_REQUIREABSOLUTE);
      AddConstant('NUM_POINTS',NUM_POINTS);
      AddConstant('CABINETSTATE_VERSION',CABINETSTATE_VERSION);
      AddConstant('PCS_FATAL',PCS_FATAL);
      AddConstant('PCS_REPLACEDCHAR',PCS_REPLACEDCHAR);
      AddConstant('PCS_REMOVEDCHAR',PCS_REMOVEDCHAR);
      AddConstant('PCS_TRUNCATED',PCS_TRUNCATED);
      AddConstant('PCS_PATHTOOLONG',PCS_PATHTOOLONG);
      AddConstant('MM_ADDSEPARATOR',MM_ADDSEPARATOR);
      AddConstant('MM_SUBMENUSHAVEIDS',MM_SUBMENUSHAVEIDS);
      AddConstant('MM_DONTREMOVESEPS',MM_DONTREMOVESEPS);
      AddConstant('SHOP_PRINTERNAME',SHOP_PRINTERNAME);
      AddConstant('SHOP_FILEPATH',SHOP_FILEPATH);
      AddConstant('SHOP_VOLUMEGUID',SHOP_VOLUMEGUID);
      AddConstant('SHFMT_ID_DEFAULT',SHFMT_ID_DEFAULT);
      AddConstant('SHFMT_OPT_FULL',SHFMT_OPT_FULL);
      AddConstant('SHFMT_OPT_SYSONLY',SHFMT_OPT_SYSONLY);
      AddConstant('SHFMT_ERROR',SHFMT_ERROR);
      AddConstant('SHFMT_CANCEL',SHFMT_CANCEL);
      AddConstant('SHFMT_NOFORMAT',SHFMT_NOFORMAT);
      AddConstant('REST_NONE',REST_NONE);
      AddConstant('REST_NORUN',REST_NORUN);
      AddConstant('REST_NOCLOSE',REST_NOCLOSE);
      AddConstant('REST_NOSAVESET',REST_NOSAVESET);
      AddConstant('REST_NOFILEMENU',REST_NOFILEMENU);
      AddConstant('REST_NOSETFOLDERS',REST_NOSETFOLDERS);
      AddConstant('REST_NOSETTASKBAR',REST_NOSETTASKBAR);
      AddConstant('REST_NODESKTOP',REST_NODESKTOP);
      AddConstant('REST_NOFIND',REST_NOFIND);
      AddConstant('REST_NODRIVES',REST_NODRIVES);
      AddConstant('REST_NODRIVEAUTORUN',REST_NODRIVEAUTORUN);
      AddConstant('REST_NODRIVETYPEAUTORUN',REST_NODRIVETYPEAUTORUN);
      AddConstant('REST_NONETHOOD',REST_NONETHOOD);
      AddConstant('REST_STARTBANNER',REST_STARTBANNER);
      AddConstant('REST_RESTRICTRUN',REST_RESTRICTRUN);
      AddConstant('REST_NOPRINTERTABS',REST_NOPRINTERTABS);
      AddConstant('REST_NOPRINTERDELETE',REST_NOPRINTERDELETE);
      AddConstant('REST_NOPRINTERADD',REST_NOPRINTERADD);
      AddConstant('REST_NOSTARTMENUSUBFOLDERS',REST_NOSTARTMENUSUBFOLDERS);
      AddConstant('REST_MYDOCSONNET',REST_MYDOCSONNET);
      AddConstant('REST_NOEXITTODOS',REST_NOEXITTODOS);
      AddConstant('REST_ENFORCESHELLEXTSECURITY',REST_ENFORCESHELLEXTSECURITY);
      AddConstant('REST_LINKRESOLVEIGNORELINKINFO',REST_LINKRESOLVEIGNORELINKINFO);
      AddConstant('REST_NOCOMMONGROUPS',REST_NOCOMMONGROUPS);
      AddConstant('REST_SEPARATEDESKTOPPROCESS',REST_SEPARATEDESKTOPPROCESS);
      AddConstant('REST_NOWEB',REST_NOWEB);
      AddConstant('REST_NOTRAYCONTEXTMENU',REST_NOTRAYCONTEXTMENU);
      AddConstant('REST_NOVIEWCONTEXTMENU',REST_NOVIEWCONTEXTMENU);
      AddConstant('REST_NONETCONNECTDISCONNECT',REST_NONETCONNECTDISCONNECT);
      AddConstant('REST_STARTMENULOGOFF',REST_STARTMENULOGOFF);
      AddConstant('REST_NOSETTINGSASSIST',REST_NOSETTINGSASSIST);
      AddConstant('REST_NOINTERNETICON',REST_NOINTERNETICON);
      AddConstant('REST_NORECENTDOCSHISTORY',REST_NORECENTDOCSHISTORY);
      AddConstant('REST_NORECENTDOCSMENU',REST_NORECENTDOCSMENU);
      AddConstant('REST_NOACTIVEDESKTOP',REST_NOACTIVEDESKTOP);
      AddConstant('REST_NOACTIVEDESKTOPCHANGES',REST_NOACTIVEDESKTOPCHANGES);
      AddConstant('REST_NOFAVORITESMENU',REST_NOFAVORITESMENU);
      AddConstant('REST_CLEARRECENTDOCSONEXIT',REST_CLEARRECENTDOCSONEXIT);
      AddConstant('REST_CLASSICSHELL',REST_CLASSICSHELL);
      AddConstant('REST_NOCUSTOMIZEWEBVIEW',REST_NOCUSTOMIZEWEBVIEW);
      AddConstant('REST_NOHTMLWALLPAPER',REST_NOHTMLWALLPAPER);
      AddConstant('REST_NOCHANGINGWALLPAPER',REST_NOCHANGINGWALLPAPER);
      AddConstant('REST_NODESKCOMP',REST_NODESKCOMP);
      AddConstant('REST_NOADDDESKCOMP',REST_NOADDDESKCOMP);
      AddConstant('REST_NODELDESKCOMP',REST_NODELDESKCOMP);
      AddConstant('REST_NOCLOSEDESKCOMP',REST_NOCLOSEDESKCOMP);
      AddConstant('REST_NOCLOSE_DRAGDROPBAND',REST_NOCLOSE_DRAGDROPBAND);
      AddConstant('REST_NOMOVINGBAND',REST_NOMOVINGBAND);
      AddConstant('REST_NOEDITDESKCOMP',REST_NOEDITDESKCOMP);
      AddConstant('REST_NORESOLVESEARCH',REST_NORESOLVESEARCH);
      AddConstant('REST_NORESOLVETRACK',REST_NORESOLVETRACK);
      AddConstant('REST_FORCECOPYACLWITHFILE',REST_FORCECOPYACLWITHFILE);
      AddConstant('REST_NOLOGO3CHANNELNOTIFY',REST_NOLOGO3CHANNELNOTIFY);
      AddConstant('REST_NOFORGETSOFTWAREUPDATE',REST_NOFORGETSOFTWAREUPDATE);
      AddConstant('REST_NOSETACTIVEDESKTOP',REST_NOSETACTIVEDESKTOP);
      AddConstant('REST_NOUPDATEWINDOWS',REST_NOUPDATEWINDOWS);
      AddConstant('REST_NOCHANGESTARMENU',REST_NOCHANGESTARMENU);
      AddConstant('REST_NOFOLDEROPTIONS',REST_NOFOLDEROPTIONS);
      AddConstant('REST_HASFINDCOMPUTERS',REST_HASFINDCOMPUTERS);
      AddConstant('REST_INTELLIMENUS',REST_INTELLIMENUS);
      AddConstant('REST_RUNDLGMEMCHECKBOX',REST_RUNDLGMEMCHECKBOX);
      AddConstant('REST_ARP_ShowPostSetup',REST_ARP_ShowPostSetup);
      AddConstant('REST_NOCSC',REST_NOCSC);
      AddConstant('REST_NOCONTROLPANEL',REST_NOCONTROLPANEL);
      AddConstant('REST_ENUMWORKGROUP',REST_ENUMWORKGROUP);
      AddConstant('REST_ARP_NOARP',REST_ARP_NOARP);
      AddConstant('REST_ARP_NOREMOVEPAGE',REST_ARP_NOREMOVEPAGE);
      AddConstant('REST_ARP_NOADDPAGE',REST_ARP_NOADDPAGE);
      AddConstant('REST_ARP_NOWINSETUPPAGE',REST_ARP_NOWINSETUPPAGE);
      AddConstant('REST_GREYMSIADS',REST_GREYMSIADS);
      AddConstant('REST_NOCHANGEMAPPEDDRIVELABEL',REST_NOCHANGEMAPPEDDRIVELABEL);
      AddConstant('REST_NOCHANGEMAPPEDDRIVECOMMENT',REST_NOCHANGEMAPPEDDRIVECOMMENT);
      AddConstant('REST_MaxRecentDocs',REST_MaxRecentDocs);
      AddConstant('REST_NONETWORKCONNECTIONS',REST_NONETWORKCONNECTIONS);
      AddConstant('REST_FORCESTARTMENULOGOFF',REST_FORCESTARTMENULOGOFF);
      AddConstant('REST_NOWEBVIEW',REST_NOWEBVIEW);
      AddConstant('REST_NOCUSTOMIZETHISFOLDER',REST_NOCUSTOMIZETHISFOLDER);
      AddConstant('REST_NOENCRYPTION',REST_NOENCRYPTION);
      AddConstant('REST_DONTSHOWSUPERHIDDEN',REST_DONTSHOWSUPERHIDDEN);
      AddConstant('REST_NOSHELLSEARCHBUTTON',REST_NOSHELLSEARCHBUTTON);
      AddConstant('REST_NOHARDWARETAB',REST_NOHARDWARETAB);
      AddConstant('REST_NORUNASINSTALLPROMPT',REST_NORUNASINSTALLPROMPT);
      AddConstant('REST_PROMPTRUNASINSTALLNETPATH',REST_PROMPTRUNASINSTALLNETPATH);
      AddConstant('REST_NOMANAGEMYCOMPUTERVERB',REST_NOMANAGEMYCOMPUTERVERB);
      AddConstant('REST_DISALLOWRUN',REST_DISALLOWRUN);
      AddConstant('REST_NOWELCOMESCREEN',REST_NOWELCOMESCREEN);
      AddConstant('REST_RESTRICTCPL',REST_RESTRICTCPL);
      AddConstant('REST_DISALLOWCPL',REST_DISALLOWCPL);
      AddConstant('REST_NOSMBALLOONTIP',REST_NOSMBALLOONTIP);
      AddConstant('REST_NOSMHELP',REST_NOSMHELP);
      AddConstant('REST_NOWINKEYS',REST_NOWINKEYS);
      AddConstant('REST_NOENCRYPTONMOVE',REST_NOENCRYPTONMOVE);
      AddConstant('REST_NOLOCALMACHINERUN',REST_NOLOCALMACHINERUN);
      AddConstant('REST_NOCURRENTUSERRUN',REST_NOCURRENTUSERRUN);
      AddConstant('REST_NOLOCALMACHINERUNONCE',REST_NOLOCALMACHINERUNONCE);
      AddConstant('REST_NOCURRENTUSERRUNONCE',REST_NOCURRENTUSERRUNONCE);
      AddConstant('REST_FORCEACTIVEDESKTOPON',REST_FORCEACTIVEDESKTOPON);
      AddConstant('REST_NOVIEWONDRIVE',REST_NOVIEWONDRIVE);
      AddConstant('REST_NONETCRAWL',REST_NONETCRAWL);
      AddConstant('REST_NOSHAREDDOCUMENTS',REST_NOSHAREDDOCUMENTS);
      AddConstant('REST_NOSMMYDOCS',REST_NOSMMYDOCS);
      AddConstant('REST_NOSMMYPICS',REST_NOSMMYPICS);
      AddConstant('REST_ALLOWBITBUCKDRIVES',REST_ALLOWBITBUCKDRIVES);
      AddConstant('REST_NONLEGACYSHELLMODE',REST_NONLEGACYSHELLMODE);
      AddConstant('REST_NOCONTROLPANELBARRICADE',REST_NOCONTROLPANELBARRICADE);
      AddConstant('REST_NOSTARTPAGE',REST_NOSTARTPAGE);
      AddConstant('REST_NOAUTOTRAYNOTIFY',REST_NOAUTOTRAYNOTIFY);
      AddConstant('REST_NOTASKGROUPING',REST_NOTASKGROUPING);
      AddConstant('REST_NOCDBURNING',REST_NOCDBURNING);
      AddConstant('REST_MYCOMPNOPROP',REST_MYCOMPNOPROP);
      AddConstant('REST_MYDOCSNOPROP',REST_MYDOCSNOPROP);
      AddConstant('REST_NOSTARTPANEL',REST_NOSTARTPANEL);
      AddConstant('REST_NODISPLAYAPPEARANCEPAGE',REST_NODISPLAYAPPEARANCEPAGE);
      AddConstant('REST_NOTHEMESTAB',REST_NOTHEMESTAB);
      AddConstant('REST_NOVISUALSTYLECHOICE',REST_NOVISUALSTYLECHOICE);
      AddConstant('REST_NOSIZECHOICE',REST_NOSIZECHOICE);
      AddConstant('REST_NOCOLORCHOICE',REST_NOCOLORCHOICE);
      AddConstant('REST_SETVISUALSTYLE',REST_SETVISUALSTYLE);
      AddConstant('REST_STARTRUNNOHOMEPATH',REST_STARTRUNNOHOMEPATH);
      AddConstant('REST_NOUSERNAMEINSTARTPANEL',REST_NOUSERNAMEINSTARTPANEL);
      AddConstant('REST_NOMYCOMPUTERICON',REST_NOMYCOMPUTERICON);
      AddConstant('REST_NOSMNETWORKPLACES',REST_NOSMNETWORKPLACES);
      AddConstant('REST_NOSMPINNEDLIST',REST_NOSMPINNEDLIST);
      AddConstant('REST_NOSMMYMUSIC',REST_NOSMMYMUSIC);
      AddConstant('REST_NOSMEJECTPC',REST_NOSMEJECTPC);
      AddConstant('REST_NOSMMOREPROGRAMS',REST_NOSMMOREPROGRAMS);
      AddConstant('REST_NOSMMFUPROGRAMS',REST_NOSMMFUPROGRAMS);
      AddConstant('REST_NOTRAYITEMSDISPLAY',REST_NOTRAYITEMSDISPLAY);
      AddConstant('REST_NOTOOLBARSONTASKBAR',REST_NOTOOLBARSONTASKBAR);
      AddConstant('REST_NOSMCONFIGUREPROGRAMS',REST_NOSMCONFIGUREPROGRAMS);
      AddConstant('REST_HIDECLOCK',REST_HIDECLOCK);
      AddConstant('REST_NOLOWDISKSPACECHECKS',REST_NOLOWDISKSPACECHECKS);
      AddConstant('REST_NOENTIRENETWORK',REST_NOENTIRENETWORK);
      AddConstant('REST_NODESKTOPCLEANUP',REST_NODESKTOPCLEANUP);
      AddConstant('REST_BITBUCKNUKEONDELETE',REST_BITBUCKNUKEONDELETE);
      AddConstant('REST_BITBUCKCONFIRMDELETE',REST_BITBUCKCONFIRMDELETE);
      AddConstant('REST_BITBUCKNOPROP',REST_BITBUCKNOPROP);
      AddConstant('REST_NODISPBACKGROUND',REST_NODISPBACKGROUND);
      AddConstant('REST_NODISPSCREENSAVEPG',REST_NODISPSCREENSAVEPG);
      AddConstant('REST_NODISPSETTINGSPG',REST_NODISPSETTINGSPG);
      AddConstant('REST_NODISPSCREENSAVEPREVIEW',REST_NODISPSCREENSAVEPREVIEW);
      AddConstant('REST_NODISPLAYCPL',REST_NODISPLAYCPL);
      AddConstant('REST_HIDERUNASVERB',REST_HIDERUNASVERB);
      AddConstant('REST_NOTHUMBNAILCACHE',REST_NOTHUMBNAILCACHE);
      AddConstant('REST_NOSTRCMPLOGICAL',REST_NOSTRCMPLOGICAL);
      AddConstant('REST_NOPUBLISHWIZARD',REST_NOPUBLISHWIZARD);
      AddConstant('REST_NOONLINEPRINTSWIZARD',REST_NOONLINEPRINTSWIZARD);
      AddConstant('REST_NOWEBSERVICES',REST_NOWEBSERVICES);
      AddConstant('REST_ALLOWUNHASHEDWEBVIEW',REST_ALLOWUNHASHEDWEBVIEW);
      AddConstant('REST_ALLOWLEGACYWEBVIEW',REST_ALLOWLEGACYWEBVIEW);
      AddConstant('REST_REVERTWEBVIEWSECURITY',REST_REVERTWEBVIEWSECURITY);
      AddConstant('REST_INHERITCONSOLEHANDLES',REST_INHERITCONSOLEHANDLES);
      AddConstant('REST_SORTMAXITEMCOUNT',REST_SORTMAXITEMCOUNT);
      AddConstant('REST_NOREMOTERECURSIVEEVENTS',REST_NOREMOTERECURSIVEEVENTS);
      AddConstant('REST_NOREMOTECHANGENOTIFY',REST_NOREMOTECHANGENOTIFY);
      AddConstant('REST_NOSIMPLENETIDLIST',REST_NOSIMPLENETIDLIST);
      AddConstant('REST_NOENUMENTIRENETWORK',REST_NOENUMENTIRENETWORK);
      AddConstant('REST_NODETAILSTHUMBNAILONNETWORK',REST_NODETAILSTHUMBNAILONNETWORK);
      AddConstant('REST_NOINTERNETOPENWITH',REST_NOINTERNETOPENWITH);
      AddConstant('REST_DONTRETRYBADNETNAME',REST_DONTRETRYBADNETNAME);
      AddConstant('REST_ALLOWFILECLSIDJUNCTIONS',REST_ALLOWFILECLSIDJUNCTIONS);
      AddConstant('REST_NOUPNPINSTALL',REST_NOUPNPINSTALL);
      AddConstant('REST_ARP_DONTGROUPPATCHES',REST_ARP_DONTGROUPPATCHES);
      AddConstant('REST_ARP_NOCHOOSEPROGRAMSPAGE',REST_ARP_NOCHOOSEPROGRAMSPAGE);
      AddConstant('REST_NODISCONNECT',REST_NODISCONNECT);
      AddConstant('REST_NOSECURITY',REST_NOSECURITY);
      AddConstant('REST_NOFILEASSOCIATE',REST_NOFILEASSOCIATE);
      AddConstant('REST_ALLOWCOMMENTTOGGLE',REST_ALLOWCOMMENTTOGGLE);
      AddConstant('REST_USEDESKTOPINICACHE',REST_USEDESKTOPINICACHE);
      AddConstant('PPCF_ADDQUOTES',PPCF_ADDQUOTES);
      AddConstant('PPCF_ADDARGUMENTS',PPCF_ADDARGUMENTS);
      AddConstant('PPCF_NODIRECTORIES',PPCF_NODIRECTORIES);
      AddConstant('PPCF_FORCEQUALIFY',PPCF_FORCEQUALIFY);
      AddConstant('PPCF_LONGESTPOSSIBLE',PPCF_LONGESTPOSSIBLE);
      AddConstant('OAIF_ALLOW_REGISTRATION',OAIF_ALLOW_REGISTRATION);
      AddConstant('OAIF_REGISTER_EXT',OAIF_REGISTER_EXT);
      AddConstant('OAIF_EXEC',OAIF_EXEC);
      AddConstant('OAIF_FORCE_REGISTRATION',OAIF_FORCE_REGISTRATION);
      AddConstant('OAIF_HIDE_REGISTRATION',OAIF_HIDE_REGISTRATION);
      AddConstant('OAIF_URL_PROTOCOL',OAIF_URL_PROTOCOL);
      AddConstant('VALIDATEUNC_CONNECT',VALIDATEUNC_CONNECT);
      AddConstant('VALIDATEUNC_NOUI',VALIDATEUNC_NOUI);
      AddConstant('VALIDATEUNC_PRINT',VALIDATEUNC_PRINT);
      AddConstant('VALIDATEUNC_PERSIST',VALIDATEUNC_PERSIST);
      AddConstant('VALIDATEUNC_VALID',VALIDATEUNC_VALID);
      AddConstant('VALIDATEUNC_VALID_PREVISTA',VALIDATEUNC_VALID_PREVISTA);
      AddConstant('OPENPROPS_NONE',OPENPROPS_NONE);
      AddConstant('OPENPROPS_INHIBITPIF',OPENPROPS_INHIBITPIF);
      AddConstant('GETPROPS_NONE',GETPROPS_NONE);
      AddConstant('SETPROPS_NONE',SETPROPS_NONE);
      AddConstant('CLOSEPROPS_NONE',CLOSEPROPS_NONE);
      AddConstant('CLOSEPROPS_DISCARD',CLOSEPROPS_DISCARD);
      AddConstant('PIFNAMESIZE',PIFNAMESIZE);
      AddConstant('PIFSTARTLOCSIZE',PIFSTARTLOCSIZE);
      AddConstant('PIFDEFPATHSIZE',PIFDEFPATHSIZE);
      AddConstant('PIFPARAMSSIZE',PIFPARAMSSIZE);
      AddConstant('PIFSHPROGSIZE',PIFSHPROGSIZE);
      AddConstant('PIFSHDATASIZE',PIFSHDATASIZE);
      AddConstant('PIFDEFFILESIZE',PIFDEFFILESIZE);
      AddConstant('PIFMAXFILEPATH',PIFMAXFILEPATH);
      AddConstant('BMICON_LARGE',BMICON_LARGE);
      AddConstant('BMICON_SMALL',BMICON_SMALL);
      AddConstant('QCMINFO_PLACE_BEFORE',QCMINFO_PLACE_BEFORE);
      AddConstant('QCMINFO_PLACE_AFTER',QCMINFO_PLACE_AFTER);
      AddConstant('TBIF_APPEND',TBIF_APPEND);
      AddConstant('TBIF_PREPEND',TBIF_PREPEND);
      AddConstant('TBIF_REPLACE',TBIF_REPLACE);
      AddConstant('TBIF_DEFAULT',TBIF_DEFAULT);
      AddConstant('TBIF_INTERNETBAR',TBIF_INTERNETBAR);
      AddConstant('TBIF_STANDARDTOOLBAR',TBIF_STANDARDTOOLBAR);
      AddConstant('TBIF_NOTOOLBAR',TBIF_NOTOOLBAR);
      AddConstant('SFVM_MERGEMENU',SFVM_MERGEMENU);
      AddConstant('SFVM_INVOKECOMMAND',SFVM_INVOKECOMMAND);
      AddConstant('SFVM_GETHELPTEXT',SFVM_GETHELPTEXT);
      AddConstant('SFVM_GETTOOLTIPTEXT',SFVM_GETTOOLTIPTEXT);
      AddConstant('SFVM_GETBUTTONINFO',SFVM_GETBUTTONINFO);
      AddConstant('SFVM_GETBUTTONS',SFVM_GETBUTTONS);
      AddConstant('SFVM_INITMENUPOPUP',SFVM_INITMENUPOPUP);
      AddConstant('SFVM_FSNOTIFY',SFVM_FSNOTIFY);
      AddConstant('SFVM_WINDOWCREATED',SFVM_WINDOWCREATED);
      AddConstant('SFVM_GETDETAILSOF',SFVM_GETDETAILSOF);
      AddConstant('SFVM_COLUMNCLICK',SFVM_COLUMNCLICK);
      AddConstant('SFVM_QUERYFSNOTIFY',SFVM_QUERYFSNOTIFY);
      AddConstant('SFVM_DEFITEMCOUNT',SFVM_DEFITEMCOUNT);
      AddConstant('SFVM_DEFVIEWMODE',SFVM_DEFVIEWMODE);
      AddConstant('SFVM_UNMERGEMENU',SFVM_UNMERGEMENU);
      AddConstant('SFVM_UPDATESTATUSBAR',SFVM_UPDATESTATUSBAR);
      AddConstant('SFVM_BACKGROUNDENUM',SFVM_BACKGROUNDENUM);
      AddConstant('SFVM_DIDDRAGDROP',SFVM_DIDDRAGDROP);
      AddConstant('SFVM_SETISFV',SFVM_SETISFV);
      AddConstant('SFVM_THISIDLIST',SFVM_THISIDLIST);
      AddConstant('SFVM_ADDPROPERTYPAGES',SFVM_ADDPROPERTYPAGES);
      AddConstant('SFVM_BACKGROUNDENUMDONE',SFVM_BACKGROUNDENUMDONE);
      AddConstant('SFVM_GETNOTIFY',SFVM_GETNOTIFY);
      AddConstant('SFVM_GETSORTDEFAULTS',SFVM_GETSORTDEFAULTS);
      AddConstant('SFVM_SIZE',SFVM_SIZE);
      AddConstant('SFVM_GETZONE',SFVM_GETZONE);
      AddConstant('SFVM_GETPANE',SFVM_GETPANE);
      AddConstant('SFVM_GETHELPTOPIC',SFVM_GETHELPTOPIC);
      AddConstant('SFVM_GETANIMATION',SFVM_GETANIMATION);
      AddConstant('SFVSOC_INVALIDATE_ALL',SFVSOC_INVALIDATE_ALL);
      AddConstant('SFVSOC_NOSCROLL',SFVSOC_NOSCROLL);
      AddConstant('SFVS_SELECT_NONE',SFVS_SELECT_NONE);
      AddConstant('SFVS_SELECT_ALLITEMS',SFVS_SELECT_ALLITEMS);
      AddConstant('SFVS_SELECT_INVERT',SFVS_SELECT_INVERT);
      AddConstant('DFM_MERGECONTEXTMENU',DFM_MERGECONTEXTMENU);
      AddConstant('DFM_INVOKECOMMAND',DFM_INVOKECOMMAND);
      AddConstant('DFM_GETHELPTEXT',DFM_GETHELPTEXT);
      AddConstant('DFM_WM_MEASUREITEM',DFM_WM_MEASUREITEM);
      AddConstant('DFM_WM_DRAWITEM',DFM_WM_DRAWITEM);
      AddConstant('DFM_WM_INITMENUPOPUP',DFM_WM_INITMENUPOPUP);
      AddConstant('DFM_VALIDATECMD',DFM_VALIDATECMD);
      AddConstant('DFM_MERGECONTEXTMENU_TOP',DFM_MERGECONTEXTMENU_TOP);
      AddConstant('DFM_GETHELPTEXTW',DFM_GETHELPTEXTW);
      AddConstant('DFM_INVOKECOMMANDEX',DFM_INVOKECOMMANDEX);
      AddConstant('DFM_MAPCOMMANDNAME',DFM_MAPCOMMANDNAME);
      AddConstant('DFM_GETDEFSTATICID',DFM_GETDEFSTATICID);
      AddConstant('DFM_GETVERBW',DFM_GETVERBW);
      AddConstant('DFM_GETVERBA',DFM_GETVERBA);
      AddConstant('DFM_MERGECONTEXTMENU_BOTTOM',DFM_MERGECONTEXTMENU_BOTTOM);
      AddConstant('DFM_MODIFYQCMFLAGS',DFM_MODIFYQCMFLAGS);
      AddConstant('DFM_CMD_DELETE',DFM_CMD_DELETE);
      AddConstant('DFM_CMD_MOVE',DFM_CMD_MOVE);
      AddConstant('DFM_CMD_COPY',DFM_CMD_COPY);
      AddConstant('DFM_CMD_LINK',DFM_CMD_LINK);
      AddConstant('DFM_CMD_PROPERTIES',DFM_CMD_PROPERTIES);
      AddConstant('DFM_CMD_NEWFOLDER',DFM_CMD_NEWFOLDER);
      AddConstant('DFM_CMD_PASTE',DFM_CMD_PASTE);
      AddConstant('DFM_CMD_VIEWLIST',DFM_CMD_VIEWLIST);
      AddConstant('DFM_CMD_VIEWDETAILS',DFM_CMD_VIEWDETAILS);
      AddConstant('DFM_CMD_PASTELINK',DFM_CMD_PASTELINK);
    end;
  end;

begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('SHCreateItemInKnownFolder',5,tkVariant,nil,__SHCreateItemInKnownFolder,false,0).SetVarArgs([4]);
    DefineMethod('SHGetItemFromObject',3,tkVariant,nil,__SHGetItemFromObject,false,0).SetVarArgs([0,2]);
    DefineMethod('SHCreateAssociationRegistration',2,tkVariant,nil,__SHCreateAssociationRegistration,false,0).SetVarArgs([1]);
    DefineMethod('SHCreateDefaultExtractIcon',2,tkVariant,nil,__SHCreateDefaultExtractIcon,false,0).SetVarArgs([1]);
    DefineMethod('SetCurrentProcessExplicitAppUserModelID',1,tkVariant,nil,__SetCurrentProcessExplicitAppUserModelID,false,0);
    DefineMethod('GetCurrentProcessExplicitAppUserModelID',1,tkVariant,nil,__GetCurrentProcessExplicitAppUserModelID,false,0).SetVarArgs([0]);
    DefineMethod('SHFree',1,tkNone,nil,__SHFree,false,0).SetVarArgs([0]);
    DefineMethod('SHGetIconOverlayIndex',2,tkInteger,nil,__SHGetIconOverlayIndex,false,0);
    DefineMethod('SHGetIconOverlayIndexA',2,tkInteger,nil,__SHGetIconOverlayIndexA,false,0);
    DefineMethod('SHGetIconOverlayIndexW',2,tkInteger,nil,__SHGetIconOverlayIndexW,false,0);
    DefineMethod('SHCreateDirectory',2,tkInteger,nil,__SHCreateDirectory,false,0);
    DefineMethod('SHCreateDirectoryEx',3,tkInteger,nil,__SHCreateDirectoryEx,false,0).SetVarArgs([2]);
    DefineMethod('SHCreateDirectoryExA',3,tkInteger,nil,__SHCreateDirectoryExA,false,0).SetVarArgs([2]);
    DefineMethod('SHCreateDirectoryExW',3,tkInteger,nil,__SHCreateDirectoryExW,false,0).SetVarArgs([2]);
    DefineMethod('SHGetSpecialFolderPath',4,tkVariant,nil,__SHGetSpecialFolderPath,false,0);
    DefineMethod('SHGetSpecialFolderPathA',4,tkVariant,nil,__SHGetSpecialFolderPathA,false,0);
    DefineMethod('SHGetSpecialFolderPathW',4,tkVariant,nil,__SHGetSpecialFolderPathW,false,0);
    DefineMethod('SHFlushSFCache',0,tkNone,nil,__SHFlushSFCache,false,0);
    DefineMethod('SHGetFolderPathA',5,tkVariant,nil,__SHGetFolderPathA,false,0);
    DefineMethod('SHGetFolderPathW',5,tkVariant,nil,__SHGetFolderPathW,false,0);
    DefineMethod('SHGetFolderPath',5,tkVariant,nil,__SHGetFolderPath,false,0);
    DefineMethod('SHGetFolderPathAndSubDir',6,tkVariant,nil,__SHGetFolderPathAndSubDir,false,0);
    DefineMethod('SHGetFolderPathAndSubDirA',6,tkVariant,nil,__SHGetFolderPathAndSubDirA,false,0);
    DefineMethod('SHGetFolderPathAndSubDirW',6,tkVariant,nil,__SHGetFolderPathAndSubDirW,false,0);
    DefineMethod('SHSetKnownFolderPath',4,tkVariant,nil,__SHSetKnownFolderPath,false,0);
    DefineMethod('SHGetKnownFolderPath',4,tkVariant,nil,__SHGetKnownFolderPath,false,0).SetVarArgs([3]);
    DefineMethod('SHLoadInProc',1,tkVariant,nil,__SHLoadInProc,false,0);
    DefineMethod('SHUpdateImageA',4,tkNone,nil,__SHUpdateImageA,false,0);
    DefineMethod('SHUpdateImageW',4,tkNone,nil,__SHUpdateImageW,false,0);
    DefineMethod('SHUpdateImage',4,tkNone,nil,__SHUpdateImage,false,0);
    DefineMethod('SHChangeNotifyRegister',6,tkInteger,nil,__SHChangeNotifyRegister,false,0).SetVarArgs([5]);
    DefineMethod('SHChangeNotifyDeregister',1,tkVariant,nil,__SHChangeNotifyDeregister,false,0);
    DefineMethod('SHChangeNotification_Unlock',1,tkVariant,nil,__SHChangeNotification_Unlock,false,0);
    DefineMethod('SHGetInstanceExplorer',1,tkVariant,nil,__SHGetInstanceExplorer,false,0).SetVarArgs([0]);
    DefineMethod('RestartDialog',3,tkInteger,nil,__RestartDialog,false,0);
    DefineMethod('RestartDialogEx',4,tkInteger,nil,__RestartDialogEx,false,0);
    DefineMethod('DAD_SetDragImage',2,tkVariant,nil,__DAD_SetDragImage,false,0).SetVarArgs([1]);
    DefineMethod('DAD_DragEnterEx',2,tkVariant,nil,__DAD_DragEnterEx,false,0);
    DefineMethod('DAD_ShowDragImage',1,tkVariant,nil,__DAD_ShowDragImage,false,0);
    DefineMethod('DAD_DragMove',1,tkVariant,nil,__DAD_DragMove,false,0);
    DefineMethod('DAD_DragLeave',0,tkVariant,nil,__DAD_DragLeave,false,0);
    DefineMethod('DAD_AutoScroll',3,tkVariant,nil,__DAD_AutoScroll,false,0).SetVarArgs([1,2]);
    DefineMethod('ReadCabinetState',2,tkVariant,nil,__ReadCabinetState,false,0).SetVarArgs([0]);
    DefineMethod('WriteCabinetState',1,tkVariant,nil,__WriteCabinetState,false,0).SetVarArgs([0]);
    DefineMethod('PathMakeUniqueName',5,tkVariant,nil,__PathMakeUniqueName,false,0);
    DefineMethod('PathQualify',1,tkNone,nil,__PathQualify,false,0);
    DefineMethod('PathIsExe',1,tkVariant,nil,__PathIsExe,false,0);
    DefineMethod('PathIsSlow',2,tkVariant,nil,__PathIsSlow,false,0);
    DefineMethod('PathIsSlowA',2,tkVariant,nil,__PathIsSlowA,false,0);
    DefineMethod('PathIsSlowW',2,tkVariant,nil,__PathIsSlowW,false,0);
    DefineMethod('PathCleanupSpec',2,tkInteger,nil,__PathCleanupSpec,false,0);
    DefineMethod('PathResolve',3,tkInteger,nil,__PathResolve,false,0);
    DefineMethod('GetFileNameFromBrowse',7,tkVariant,nil,__GetFileNameFromBrowse,false,0);
    DefineMethod('DriveType',1,tkInteger,nil,__DriveType,false,0);
    DefineMethod('RealDriveType',2,tkInteger,nil,__RealDriveType,false,0);
    DefineMethod('IsNetDrive',1,tkInteger,nil,__IsNetDrive,false,0);
    DefineMethod('Shell_MergeMenus',6,tkInteger,nil,__Shell_MergeMenus,false,0);
    DefineMethod('SHObjectProperties',4,tkVariant,nil,__SHObjectProperties,false,0);
    DefineMethod('SHFormatDrive',4,tkInteger,nil,__SHFormatDrive,false,0);
    DefineMethod('SHCreatePropSheetExtArray',3,tkVariant,nil,__SHCreatePropSheetExtArray,false,0);
    DefineMethod('SHDestroyPropSheetExtArray',1,tkNone,nil,__SHDestroyPropSheetExtArray,false,0);
    DefineMethod('PathGetShortPath',1,tkNone,nil,__PathGetShortPath,false,0);
    DefineMethod('PathYetAnotherMakeUniqueName',4,tkVariant,nil,__PathYetAnotherMakeUniqueName,false,0);
    DefineMethod('Win32DeleteFile',1,tkVariant,nil,__Win32DeleteFile,false,0);
    DefineMethod('PathProcessCommand',4,tkInteger,nil,__PathProcessCommand,false,0);
    DefineMethod('SHRestricted',1,tkInteger,nil,__SHRestricted,false,0);
    DefineMethod('SHLoadOLE',1,tkVariant,nil,__SHLoadOLE,false,0);
    DefineMethod('SHDefExtractIconA',6,tkVariant,nil,__SHDefExtractIconA,false,0).SetVarArgs([3,4]);
    DefineMethod('SHDefExtractIconW',6,tkVariant,nil,__SHDefExtractIconW,false,0).SetVarArgs([3,4]);
    DefineMethod('SHDefExtractIcon',6,tkVariant,nil,__SHDefExtractIcon,false,0).SetVarArgs([3,4]);
    DefineMethod('SHOpenWithDialog',2,tkVariant,nil,__SHOpenWithDialog,false,0).SetVarArgs([1]);
    DefineMethod('Shell_GetImageLists',2,tkVariant,nil,__Shell_GetImageLists,false,0).SetVarArgs([0,1]);
    DefineMethod('SHValidateUNC',3,tkVariant,nil,__SHValidateUNC,false,0);
    DefineMethod('PifMgr_OpenProperties',4,tkVariant,nil,__PifMgr_OpenProperties,false,0);
    DefineMethod('PifMgr_CloseProperties',2,tkVariant,nil,__PifMgr_CloseProperties,false,0);
    DefineMethod('SHSetInstanceExplorer',1,tkNone,nil,__SHSetInstanceExplorer,false,0);
    DefineMethod('IsUserAnAdmin',0,tkVariant,nil,__IsUserAnAdmin,false,0);
    DefineMethod('SHShellFolderView_Message',3,tkInteger,nil,__SHShellFolderView_Message,false,0);
    DefineMethod('SHGetSetSettings',3,tkNone,nil,__SHGetSetSettings,false,0).SetVarArgs([0]);
    DefineMethod('SHGetSettings',2,tkNone,nil,__SHGetSettings,false,0).SetVarArgs([0]);
    DefineMethod('SHPathPrepareForWriteA',4,tkVariant,nil,__SHPathPrepareForWriteA,false,0);
    DefineMethod('SHPathPrepareForWriteW',4,tkVariant,nil,__SHPathPrepareForWriteW,false,0);
    DefineMethod('SHPathPrepareForWrite',4,tkVariant,nil,__SHPathPrepareForWrite,false,0);
    DefineMethod('PerUserInit',0,tkVariant,nil,__PerUserInit,false,0);
    DefineMethod('SHRunControlPanel',2,tkVariant,nil,__SHRunControlPanel,false,0);
    DefineMethod('PickIconDlg',4,tkInteger,nil,__PickIconDlg,false,0).SetVarArgs([3]);
    DefineMethod('ImportPrivacySettings',3,tkVariant,nil,__ImportPrivacySettings,false,0).SetVarArgs([1,2]);
    DefineProp('CLSID_NetworkDomain',tkVariant,__GetCLSID_NetworkDomain,nil,nil,false,0);
    DefineProp('CLSID_NetworkServer',tkVariant,__GetCLSID_NetworkServer,nil,nil,false,0);
    DefineProp('CLSID_NetworkShare',tkVariant,__GetCLSID_NetworkShare,nil,nil,false,0);
    DefineProp('CLSID_MyComputer',tkVariant,__GetCLSID_MyComputer,nil,nil,false,0);
    DefineProp('CLSID_Internet',tkVariant,__GetCLSID_Internet,nil,nil,false,0);
    DefineProp('CLSID_RecycleBin',tkVariant,__GetCLSID_RecycleBin,nil,nil,false,0);
    DefineProp('CLSID_ControlPanel',tkVariant,__GetCLSID_ControlPanel,nil,nil,false,0);
    DefineProp('CLSID_Printers',tkVariant,__GetCLSID_Printers,nil,nil,false,0);
    DefineProp('CLSID_MyDocuments',tkVariant,__GetCLSID_MyDocuments,nil,nil,false,0);
    DefineProp('CATID_BrowsableShellExt',tkVariant,__GetCATID_BrowsableShellExt,nil,nil,false,0);
    DefineProp('CATID_BrowseInPlace',tkVariant,__GetCATID_BrowseInPlace,nil,nil,false,0);
    DefineProp('CATID_DeskBand',tkVariant,__GetCATID_DeskBand,nil,nil,false,0);
    DefineProp('CATID_InfoBand',tkVariant,__GetCATID_InfoBand,nil,nil,false,0);
    DefineProp('CATID_CommBand',tkVariant,__GetCATID_CommBand,nil,nil,false,0);
    DefineProp('FMTID_Intshcut',tkVariant,__GetFMTID_Intshcut,nil,nil,false,0);
    DefineProp('FMTID_InternetSite',tkVariant,__GetFMTID_InternetSite,nil,nil,false,0);
    DefineProp('CGID_Explorer',tkVariant,__GetCGID_Explorer,nil,nil,false,0);
    DefineProp('CGID_ShellDocView',tkVariant,__GetCGID_ShellDocView,nil,nil,false,0);
    DefineProp('CGID_ShellServiceObject',tkVariant,__GetCGID_ShellServiceObject,nil,nil,false,0);
    DefineProp('CGID_ExplorerBarDoc',tkVariant,__GetCGID_ExplorerBarDoc,nil,nil,false,0);
    DefineProp('IID_IBriefcaseStg',tkVariant,__GetIID_IBriefcaseStg,nil,nil,false,0);
    DefineProp('IID_IDefViewID',tkVariant,__GetIID_IDefViewID,nil,nil,false,0);
    DefineProp('CLSID_FolderShortcut',tkVariant,__GetCLSID_FolderShortcut,nil,nil,false,0);
    DefineProp('CLSID_CFSIconOverlayManager',tkVariant,__GetCLSID_CFSIconOverlayManager,nil,nil,false,0);
    DefineProp('CLSID_ShellThumbnailDiskCache',tkVariant,__GetCLSID_ShellThumbnailDiskCache,nil,nil,false,0);
    DefineProp('SID_DefView',tkVariant,__GetSID_DefView,nil,nil,false,0);
    DefineProp('CGID_DefView',tkVariant,__GetCGID_DefView,nil,nil,false,0);
    DefineProp('CLSID_MenuBand',tkVariant,__GetCLSID_MenuBand,nil,nil,false,0);
    DefineProp('VID_LargeIcons',tkVariant,__GetVID_LargeIcons,nil,nil,false,0);
    DefineProp('VID_SmallIcons',tkVariant,__GetVID_SmallIcons,nil,nil,false,0);
    DefineProp('VID_List',tkVariant,__GetVID_List,nil,nil,false,0);
    DefineProp('VID_Details',tkVariant,__GetVID_Details,nil,nil,false,0);
    DefineProp('VID_Tile',tkVariant,__GetVID_Tile,nil,nil,false,0);
    DefineProp('VID_Content',tkVariant,__GetVID_Content,nil,nil,false,0);
    DefineProp('VID_Thumbnails',tkVariant,__GetVID_Thumbnails,nil,nil,false,0);
    DefineProp('VID_ThumbStrip',tkVariant,__GetVID_ThumbStrip,nil,nil,false,0);
    DefineProp('SID_SShellDesktop',tkVariant,__GetSID_SShellDesktop,nil,nil,false,0);
    DefineProp('SID_SInPlaceBrowser',tkVariant,__GetSID_SInPlaceBrowser,nil,nil,false,0);
    DefineProp('SID_SSearchBoxInfo',tkVariant,__GetSID_SSearchBoxInfo,nil,nil,false,0);
    DefineProp('IID_IDiscardableBrowserProperty',tkVariant,__GetIID_IDiscardableBrowserProperty,nil,nil,false,0);
    DefineProp('CLSID_CUrlHistory',tkVariant,__GetCLSID_CUrlHistory,nil,nil,false,0);
    DefineProp('CLSID_CURLSearchHook',tkVariant,__GetCLSID_CURLSearchHook,nil,nil,false,0);
    DefineProp('SID_SInternetExplorer',tkVariant,__GetSID_SInternetExplorer,nil,nil,false,0);
    DefineProp('SID_SWebBrowserApp',tkVariant,__GetSID_SWebBrowserApp,nil,nil,false,0);
    DefineProp('CLSID_AutoComplete',tkVariant,__GetCLSID_AutoComplete,nil,nil,false,0);
    DefineProp('CLSID_ACLHistory',tkVariant,__GetCLSID_ACLHistory,nil,nil,false,0);
    DefineProp('CLSID_ACListISF',tkVariant,__GetCLSID_ACListISF,nil,nil,false,0);
    DefineProp('CLSID_ACLMRU',tkVariant,__GetCLSID_ACLMRU,nil,nil,false,0);
    DefineProp('CLSID_ACLMulti',tkVariant,__GetCLSID_ACLMulti,nil,nil,false,0);
    DefineProp('CLSID_ACLCustomMRU',tkVariant,__GetCLSID_ACLCustomMRU,nil,nil,false,0);
    DefineProp('CLSID_ProgressDialog',tkVariant,__GetCLSID_ProgressDialog,nil,nil,false,0);
    DefineProp('SID_SProgressUI',tkVariant,__GetSID_SProgressUI,nil,nil,false,0);
    DefineProp('SID_STopLevelBrowser',tkVariant,__GetSID_STopLevelBrowser,nil,nil,false,0);
    DefineProp('CLSID_FileTypes',tkVariant,__GetCLSID_FileTypes,nil,nil,false,0);
    DefineProp('CLSID_ActiveDesktop',tkVariant,__GetCLSID_ActiveDesktop,nil,nil,false,0);
    DefineProp('IID_ISynchronizedCallBack',tkVariant,__GetIID_ISynchronizedCallBack,nil,nil,false,0);
    DefineProp('IID_IQueryAssociations',tkVariant,__GetIID_IQueryAssociations,nil,nil,false,0);
    DefineProp('CLSID_QueryAssociations',tkVariant,__GetCLSID_QueryAssociations,nil,nil,false,0);
    DefineProp('CLSID_LinkColumnProvider',tkVariant,__GetCLSID_LinkColumnProvider,nil,nil,false,0);
    DefineProp('CGID_ShortCut',tkVariant,__GetCGID_ShortCut,nil,nil,false,0);
    DefineProp('CLSID_InternetButtons',tkVariant,__GetCLSID_InternetButtons,nil,nil,false,0);
    DefineProp('CLSID_MSOButtons',tkVariant,__GetCLSID_MSOButtons,nil,nil,false,0);
    DefineProp('CLSID_ToolbarExtButtons',tkVariant,__GetCLSID_ToolbarExtButtons,nil,nil,false,0);
    DefineProp('CLSID_DarwinAppPublisher',tkVariant,__GetCLSID_DarwinAppPublisher,nil,nil,false,0);
    DefineProp('CLSID_DocHostUIHandler',tkVariant,__GetCLSID_DocHostUIHandler,nil,nil,false,0);
    DefineProp('FMTID_ShellDetails',tkVariant,__GetFMTID_ShellDetails,nil,nil,false,0);
    DefineProp('FMTID_Storage',tkVariant,__GetFMTID_Storage,nil,nil,false,0);
    DefineProp('FMTID_ImageProperties',tkVariant,__GetFMTID_ImageProperties,nil,nil,false,0);
    DefineProp('FMTID_CustomImageProperties',tkVariant,__GetFMTID_CustomImageProperties,nil,nil,false,0);
    DefineProp('FMTID_LibraryProperties',tkVariant,__GetFMTID_LibraryProperties,nil,nil,false,0);
    DefineProp('FMTID_Displaced',tkVariant,__GetFMTID_Displaced,nil,nil,false,0);
    DefineProp('FMTID_Briefcase',tkVariant,__GetFMTID_Briefcase,nil,nil,false,0);
    DefineProp('FMTID_Misc',tkVariant,__GetFMTID_Misc,nil,nil,false,0);
    DefineProp('FMTID_WebView',tkVariant,__GetFMTID_WebView,nil,nil,false,0);
    DefineProp('FMTID_MUSIC',tkVariant,__GetFMTID_MUSIC,nil,nil,false,0);
    DefineProp('FMTID_DRM',tkVariant,__GetFMTID_DRM,nil,nil,false,0);
    DefineProp('FMTID_Volume',tkVariant,__GetFMTID_Volume,nil,nil,false,0);
    DefineProp('FMTID_Query',tkVariant,__GetFMTID_Query,nil,nil,false,0);
    DefineProp('CLSID_HWShellExecute',tkVariant,__GetCLSID_HWShellExecute,nil,nil,false,0);
    DefineProp('CLSID_DragDropHelper',tkVariant,__GetCLSID_DragDropHelper,nil,nil,false,0);
    DefineProp('CLSID_CAnchorBrowsePropertyPage',tkVariant,__GetCLSID_CAnchorBrowsePropertyPage,nil,nil,false,0);
    DefineProp('CLSID_CImageBrowsePropertyPage',tkVariant,__GetCLSID_CImageBrowsePropertyPage,nil,nil,false,0);
    DefineProp('CLSID_CDocBrowsePropertyPage',tkVariant,__GetCLSID_CDocBrowsePropertyPage,nil,nil,false,0);
    DefineProp('SID_STopWindow',tkVariant,__GetSID_STopWindow,nil,nil,false,0);
    DefineProp('SID_SGetViewFromViewDual',tkVariant,__GetSID_SGetViewFromViewDual,nil,nil,false,0);
    DefineProp('CLSID_FolderItem',tkVariant,__GetCLSID_FolderItem,nil,nil,false,0);
    DefineProp('CLSID_FolderItemsMultiLevel',tkVariant,__GetCLSID_FolderItemsMultiLevel,nil,nil,false,0);
    DefineProp('CLSID_NewMenu',tkVariant,__GetCLSID_NewMenu,nil,nil,false,0);
    DefineProp('BHID_SFObject',tkVariant,__GetBHID_SFObject,nil,nil,false,0);
    DefineProp('BHID_SFUIObject',tkVariant,__GetBHID_SFUIObject,nil,nil,false,0);
    DefineProp('BHID_SFViewObject',tkVariant,__GetBHID_SFViewObject,nil,nil,false,0);
    DefineProp('BHID_Storage',tkVariant,__GetBHID_Storage,nil,nil,false,0);
    DefineProp('BHID_Stream',tkVariant,__GetBHID_Stream,nil,nil,false,0);
    DefineProp('BHID_LinkTargetItem',tkVariant,__GetBHID_LinkTargetItem,nil,nil,false,0);
    DefineProp('BHID_StorageEnum',tkVariant,__GetBHID_StorageEnum,nil,nil,false,0);
    DefineProp('BHID_Transfer',tkVariant,__GetBHID_Transfer,nil,nil,false,0);
    DefineProp('BHID_PropertyStore',tkVariant,__GetBHID_PropertyStore,nil,nil,false,0);
    DefineProp('BHID_ThumbnailHandler',tkVariant,__GetBHID_ThumbnailHandler,nil,nil,false,0);
    DefineProp('BHID_EnumItems',tkVariant,__GetBHID_EnumItems,nil,nil,false,0);
    DefineProp('BHID_DataObject',tkVariant,__GetBHID_DataObject,nil,nil,false,0);
    DefineProp('BHID_AssociationArray',tkVariant,__GetBHID_AssociationArray,nil,nil,false,0);
    DefineProp('BHID_Filter',tkVariant,__GetBHID_Filter,nil,nil,false,0);
    DefineProp('BHID_EnumAssocHandlers',tkVariant,__GetBHID_EnumAssocHandlers,nil,nil,false,0);
    DefineProp('SID_CtxQueryAssociations',tkVariant,__GetSID_CtxQueryAssociations,nil,nil,false,0);
    DefineProp('CLSID_QuickLinks',tkVariant,__GetCLSID_QuickLinks,nil,nil,false,0);
    DefineProp('CLSID_ISFBand',tkVariant,__GetCLSID_ISFBand,nil,nil,false,0);
    DefineProp('IID_CDefView',tkVariant,__GetIID_CDefView,nil,nil,false,0);
    DefineProp('CLSID_ShellFldSetExt',tkVariant,__GetCLSID_ShellFldSetExt,nil,nil,false,0);
    DefineProp('SID_SMenuBandChild',tkVariant,__GetSID_SMenuBandChild,nil,nil,false,0);
    DefineProp('SID_SMenuBandParent',tkVariant,__GetSID_SMenuBandParent,nil,nil,false,0);
    DefineProp('SID_SMenuPopup',tkVariant,__GetSID_SMenuPopup,nil,nil,false,0);
    DefineProp('SID_SMenuBandBottomSelected',tkVariant,__GetSID_SMenuBandBottomSelected,nil,nil,false,0);
    DefineProp('SID_SMenuBandBottom',tkVariant,__GetSID_SMenuBandBottom,nil,nil,false,0);
    DefineProp('SID_MenuShellFolder',tkVariant,__GetSID_MenuShellFolder,nil,nil,false,0);
    DefineProp('SID_SMenuBandContextMenuModifier',tkVariant,__GetSID_SMenuBandContextMenuModifier,nil,nil,false,0);
    DefineProp('SID_SMenuBandBKContextMenu',tkVariant,__GetSID_SMenuBandBKContextMenu,nil,nil,false,0);
    DefineProp('CGID_MENUDESKBAR',tkVariant,__GetCGID_MENUDESKBAR,nil,nil,false,0);
    DefineProp('SID_SMenuBandTop',tkVariant,__GetSID_SMenuBandTop,nil,nil,false,0);
    DefineProp('CLSID_MenuToolbarBase',tkVariant,__GetCLSID_MenuToolbarBase,nil,nil,false,0);
    DefineProp('CLSID_MenuBandSite',tkVariant,__GetCLSID_MenuBandSite,nil,nil,false,0);
    DefineProp('SID_SCommDlgBrowser',tkVariant,__GetSID_SCommDlgBrowser,nil,nil,false,0);
    DefineProp('CPFG_LOGON_USERNAME',tkVariant,__GetCPFG_LOGON_USERNAME,nil,nil,false,0);
    DefineProp('CPFG_LOGON_PASSWORD',tkVariant,__GetCPFG_LOGON_PASSWORD,nil,nil,false,0);
    DefineProp('CPFG_SMARTCARD_USERNAME',tkVariant,__GetCPFG_SMARTCARD_USERNAME,nil,nil,false,0);
    DefineProp('CPFG_SMARTCARD_PIN',tkVariant,__GetCPFG_SMARTCARD_PIN,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_Invalid',tkVariant,__GetFOLDERTYPEID_Invalid,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_Generic',tkVariant,__GetFOLDERTYPEID_Generic,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_GenericSearchResults',tkVariant,__GetFOLDERTYPEID_GenericSearchResults,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_GenericLibrary',tkVariant,__GetFOLDERTYPEID_GenericLibrary,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_Documents',tkVariant,__GetFOLDERTYPEID_Documents,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_Pictures',tkVariant,__GetFOLDERTYPEID_Pictures,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_Music',tkVariant,__GetFOLDERTYPEID_Music,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_Videos',tkVariant,__GetFOLDERTYPEID_Videos,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_UserFiles',tkVariant,__GetFOLDERTYPEID_UserFiles,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_UsersLibraries',tkVariant,__GetFOLDERTYPEID_UsersLibraries,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_OtherUsers',tkVariant,__GetFOLDERTYPEID_OtherUsers,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_PublishedItems',tkVariant,__GetFOLDERTYPEID_PublishedItems,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_Communications',tkVariant,__GetFOLDERTYPEID_Communications,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_Contacts',tkVariant,__GetFOLDERTYPEID_Contacts,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_StartMenu',tkVariant,__GetFOLDERTYPEID_StartMenu,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_RecordedTV',tkVariant,__GetFOLDERTYPEID_RecordedTV,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_SavedGames',tkVariant,__GetFOLDERTYPEID_SavedGames,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_OpenSearch',tkVariant,__GetFOLDERTYPEID_OpenSearch,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_SearchConnector',tkVariant,__GetFOLDERTYPEID_SearchConnector,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_Games',tkVariant,__GetFOLDERTYPEID_Games,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_ControlPanelCategory',tkVariant,__GetFOLDERTYPEID_ControlPanelCategory,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_ControlPanelClassic',tkVariant,__GetFOLDERTYPEID_ControlPanelClassic,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_Printers',tkVariant,__GetFOLDERTYPEID_Printers,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_RecycleBin',tkVariant,__GetFOLDERTYPEID_RecycleBin,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_SoftwareExplorer',tkVariant,__GetFOLDERTYPEID_SoftwareExplorer,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_CompressedFolder',tkVariant,__GetFOLDERTYPEID_CompressedFolder,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_NetworkExplorer',tkVariant,__GetFOLDERTYPEID_NetworkExplorer,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_Searches',tkVariant,__GetFOLDERTYPEID_Searches,nil,nil,false,0);
    DefineProp('FOLDERTYPEID_SearchHome',tkVariant,__GetFOLDERTYPEID_SearchHome,nil,nil,false,0);
    DefineProp('SYNCMGR_OBJECTID_Icon',tkVariant,__GetSYNCMGR_OBJECTID_Icon,nil,nil,false,0);
    DefineProp('SYNCMGR_OBJECTID_EventStore',tkVariant,__GetSYNCMGR_OBJECTID_EventStore,nil,nil,false,0);
    DefineProp('SYNCMGR_OBJECTID_ConflictStore',tkVariant,__GetSYNCMGR_OBJECTID_ConflictStore,nil,nil,false,0);
    DefineProp('SYNCMGR_OBJECTID_BrowseContent',tkVariant,__GetSYNCMGR_OBJECTID_BrowseContent,nil,nil,false,0);
    DefineProp('SYNCMGR_OBJECTID_ShowSchedule',tkVariant,__GetSYNCMGR_OBJECTID_ShowSchedule,nil,nil,false,0);
    DefineProp('SYNCMGR_OBJECTID_QueryBeforeActivate',tkVariant,__GetSYNCMGR_OBJECTID_QueryBeforeActivate,nil,nil,false,0);
    DefineProp('SYNCMGR_OBJECTID_QueryBeforeDeactivate',tkVariant,__GetSYNCMGR_OBJECTID_QueryBeforeDeactivate,nil,nil,false,0);
    DefineProp('SYNCMGR_OBJECTID_QueryBeforeEnable',tkVariant,__GetSYNCMGR_OBJECTID_QueryBeforeEnable,nil,nil,false,0);
    DefineProp('SYNCMGR_OBJECTID_QueryBeforeDisable',tkVariant,__GetSYNCMGR_OBJECTID_QueryBeforeDisable,nil,nil,false,0);
    DefineProp('SYNCMGR_OBJECTID_QueryBeforeDelete',tkVariant,__GetSYNCMGR_OBJECTID_QueryBeforeDelete,nil,nil,false,0);
    DefineProp('SYNCMGR_OBJECTID_EventLinkClick',tkVariant,__GetSYNCMGR_OBJECTID_EventLinkClick,nil,nil,false,0);
    DefineProp('EP_NavPane',tkVariant,__GetEP_NavPane,nil,nil,false,0);
    DefineProp('EP_Commands',tkVariant,__GetEP_Commands,nil,nil,false,0);
    DefineProp('EP_Commands_Organize',tkVariant,__GetEP_Commands_Organize,nil,nil,false,0);
    DefineProp('EP_Commands_View',tkVariant,__GetEP_Commands_View,nil,nil,false,0);
    DefineProp('EP_DetailsPane',tkVariant,__GetEP_DetailsPane,nil,nil,false,0);
    DefineProp('EP_PreviewPane',tkVariant,__GetEP_PreviewPane,nil,nil,false,0);
    DefineProp('EP_QueryPane',tkVariant,__GetEP_QueryPane,nil,nil,false,0);
    DefineProp('EP_AdvQueryPane',tkVariant,__GetEP_AdvQueryPane,nil,nil,false,0);
    DefineProp('CATID_LocationFactory',tkVariant,__GetCATID_LocationFactory,nil,nil,false,0);
    DefineProp('CATID_LocationProvider',tkVariant,__GetCATID_LocationProvider,nil,nil,false,0);
    DefineProp('ItemCount_Property_GUID',tkVariant,__GetItemCount_Property_GUID,nil,nil,false,0);
    DefineProp('SelectedItemCount_Property_GUID',tkVariant,__GetSelectedItemCount_Property_GUID,nil,nil,false,0);
    DefineProp('ItemIndex_Property_GUID',tkVariant,__GetItemIndex_Property_GUID,nil,nil,false,0);
    DefineProp('IID_IContextMenu',tkVariant,__GetIID_IContextMenu,nil,nil,false,0);
    DefineProp('IID_IContextMenu2',tkVariant,__GetIID_IContextMenu2,nil,nil,false,0);
    DefineProp('IID_IContextMenu3',tkVariant,__GetIID_IContextMenu3,nil,nil,false,0);
    DefineProp('IID_IExecuteCommand',tkVariant,__GetIID_IExecuteCommand,nil,nil,false,0);
    DefineProp('IID_IPersistFolder',tkVariant,__GetIID_IPersistFolder,nil,nil,false,0);
    DefineProp('IID_IRunnableTask',tkVariant,__GetIID_IRunnableTask,nil,nil,false,0);
    DefineProp('IID_IShellTaskScheduler',tkVariant,__GetIID_IShellTaskScheduler,nil,nil,false,0);
    DefineProp('IID_IQueryCodePage',tkVariant,__GetIID_IQueryCodePage,nil,nil,false,0);
    DefineProp('IID_IPersistFolder2',tkVariant,__GetIID_IPersistFolder2,nil,nil,false,0);
    DefineProp('IID_IPersistFolder3',tkVariant,__GetIID_IPersistFolder3,nil,nil,false,0);
    DefineProp('IID_IPersistIDList',tkVariant,__GetIID_IPersistIDList,nil,nil,false,0);
    DefineProp('IID_IEnumIDList',tkVariant,__GetIID_IEnumIDList,nil,nil,false,0);
    DefineProp('IID_IEnumFullIDList',tkVariant,__GetIID_IEnumFullIDList,nil,nil,false,0);
    DefineProp('IID_IObjectWithFolderEnumMode',tkVariant,__GetIID_IObjectWithFolderEnumMode,nil,nil,false,0);
    DefineProp('IID_IParseAndCreateItem',tkVariant,__GetIID_IParseAndCreateItem,nil,nil,false,0);
    DefineProp('IID_IShellFolder',tkVariant,__GetIID_IShellFolder,nil,nil,false,0);
    DefineProp('IID_IEnumExtraSearch',tkVariant,__GetIID_IEnumExtraSearch,nil,nil,false,0);
    DefineProp('IID_IShellFolder2',tkVariant,__GetIID_IShellFolder2,nil,nil,false,0);
    DefineProp('IID_IFolderViewOptions',tkVariant,__GetIID_IFolderViewOptions,nil,nil,false,0);
    DefineProp('IID_IShellView',tkVariant,__GetIID_IShellView,nil,nil,false,0);
    DefineProp('IID_IShellView2',tkVariant,__GetIID_IShellView2,nil,nil,false,0);
    DefineProp('IID_IShellView3',tkVariant,__GetIID_IShellView3,nil,nil,false,0);
    DefineProp('IID_IFolderView',tkVariant,__GetIID_IFolderView,nil,nil,false,0);
    DefineProp('IID_ISearchBoxInfo',tkVariant,__GetIID_ISearchBoxInfo,nil,nil,false,0);
    DefineProp('IID_IFolderView2',tkVariant,__GetIID_IFolderView2,nil,nil,false,0);
    DefineProp('IID_IFolderViewSettings',tkVariant,__GetIID_IFolderViewSettings,nil,nil,false,0);
    DefineProp('IID_IPreviewHandlerVisuals',tkVariant,__GetIID_IPreviewHandlerVisuals,nil,nil,false,0);
    DefineProp('IID_IVisualProperties',tkVariant,__GetIID_IVisualProperties,nil,nil,false,0);
    DefineProp('IID_ICommDlgBrowser',tkVariant,__GetIID_ICommDlgBrowser,nil,nil,false,0);
    DefineProp('IID_ICommDlgBrowser2',tkVariant,__GetIID_ICommDlgBrowser2,nil,nil,false,0);
    DefineProp('IID_ICommDlgBrowser3',tkVariant,__GetIID_ICommDlgBrowser3,nil,nil,false,0);
    DefineProp('IID_IColumnManager',tkVariant,__GetIID_IColumnManager,nil,nil,false,0);
    DefineProp('IID_IFolderFilterSite',tkVariant,__GetIID_IFolderFilterSite,nil,nil,false,0);
    DefineProp('IID_IFolderFilter',tkVariant,__GetIID_IFolderFilter,nil,nil,false,0);
    DefineProp('IID_IInputObjectSite',tkVariant,__GetIID_IInputObjectSite,nil,nil,false,0);
    DefineProp('IID_IInputObject',tkVariant,__GetIID_IInputObject,nil,nil,false,0);
    DefineProp('IID_IInputObject2',tkVariant,__GetIID_IInputObject2,nil,nil,false,0);
    DefineProp('IID_IShellIcon',tkVariant,__GetIID_IShellIcon,nil,nil,false,0);
    DefineProp('IID_IShellBrowser',tkVariant,__GetIID_IShellBrowser,nil,nil,false,0);
    DefineProp('IID_IProfferService',tkVariant,__GetIID_IProfferService,nil,nil,false,0);
    DefineProp('IID_IShellItem',tkVariant,__GetIID_IShellItem,nil,nil,false,0);
    DefineProp('IID_IShellItem2',tkVariant,__GetIID_IShellItem2,nil,nil,false,0);
    DefineProp('IID_IShellItemImageFactory',tkVariant,__GetIID_IShellItemImageFactory,nil,nil,false,0);
    DefineProp('IID_IUserAccountChangeCallback',tkVariant,__GetIID_IUserAccountChangeCallback,nil,nil,false,0);
    DefineProp('IID_IEnumShellItems',tkVariant,__GetIID_IEnumShellItems,nil,nil,false,0);
    DefineProp('IID_ITransferAdviseSink',tkVariant,__GetIID_ITransferAdviseSink,nil,nil,false,0);
    DefineProp('IID_ITransferSource',tkVariant,__GetIID_ITransferSource,nil,nil,false,0);
    DefineProp('IID_IEnumResources',tkVariant,__GetIID_IEnumResources,nil,nil,false,0);
    DefineProp('IID_IShellItemResources',tkVariant,__GetIID_IShellItemResources,nil,nil,false,0);
    DefineProp('IID_ITransferDestination',tkVariant,__GetIID_ITransferDestination,nil,nil,false,0);
    DefineProp('IID_IStreamAsync',tkVariant,__GetIID_IStreamAsync,nil,nil,false,0);
    DefineProp('IID_IStreamUnbufferedInfo',tkVariant,__GetIID_IStreamUnbufferedInfo,nil,nil,false,0);
    DefineProp('IID_IFileOperationProgressSink',tkVariant,__GetIID_IFileOperationProgressSink,nil,nil,false,0);
    DefineProp('IID_IShellItemArray',tkVariant,__GetIID_IShellItemArray,nil,nil,false,0);
    DefineProp('IID_IInitializeWithItem',tkVariant,__GetIID_IInitializeWithItem,nil,nil,false,0);
    DefineProp('IID_IObjectWithSelection',tkVariant,__GetIID_IObjectWithSelection,nil,nil,false,0);
    DefineProp('IID_IObjectWithBackReferences',tkVariant,__GetIID_IObjectWithBackReferences,nil,nil,false,0);
    DefineProp('IID_IPropertyUI',tkVariant,__GetIID_IPropertyUI,nil,nil,false,0);
    DefineProp('IID_ICategoryProvider',tkVariant,__GetIID_ICategoryProvider,nil,nil,false,0);
    DefineProp('IID_ICategorizer',tkVariant,__GetIID_ICategorizer,nil,nil,false,0);
    DefineProp('IID_IDropTargetHelper',tkVariant,__GetIID_IDropTargetHelper,nil,nil,false,0);
    DefineProp('IID_IDragSourceHelper',tkVariant,__GetIID_IDragSourceHelper,nil,nil,false,0);
    DefineProp('IID_IDragSourceHelper2',tkVariant,__GetIID_IDragSourceHelper2,nil,nil,false,0);
    DefineProp('IID_IShellLinkA',tkVariant,__GetIID_IShellLinkA,nil,nil,false,0);
    DefineProp('IID_IShellLinkW',tkVariant,__GetIID_IShellLinkW,nil,nil,false,0);
    DefineProp('IID_IShellLink',tkVariant,__GetIID_IShellLink,nil,nil,false,0);
    DefineProp('IID_IShellLinkDataList',tkVariant,__GetIID_IShellLinkDataList,nil,nil,false,0);
    DefineProp('IID_IResolveShellLink',tkVariant,__GetIID_IResolveShellLink,nil,nil,false,0);
    DefineProp('IID_IActionProgressDialog',tkVariant,__GetIID_IActionProgressDialog,nil,nil,false,0);
    DefineProp('IID_IHWEventHandler',tkVariant,__GetIID_IHWEventHandler,nil,nil,false,0);
    DefineProp('IID_IHWEventHandler2',tkVariant,__GetIID_IHWEventHandler2,nil,nil,false,0);
    DefineProp('IID_IQueryCancelAutoPlay',tkVariant,__GetIID_IQueryCancelAutoPlay,nil,nil,false,0);
    DefineProp('IID_IDynamicHWHandler',tkVariant,__GetIID_IDynamicHWHandler,nil,nil,false,0);
    DefineProp('IID_IActionProgress',tkVariant,__GetIID_IActionProgress,nil,nil,false,0);
    DefineProp('IID_IShellExtInit',tkVariant,__GetIID_IShellExtInit,nil,nil,false,0);
    DefineProp('IID_IShellPropSheetExt',tkVariant,__GetIID_IShellPropSheetExt,nil,nil,false,0);
    DefineProp('IID_IRemoteComputer',tkVariant,__GetIID_IRemoteComputer,nil,nil,false,0);
    DefineProp('IID_IQueryContinue',tkVariant,__GetIID_IQueryContinue,nil,nil,false,0);
    DefineProp('IID_IObjectWithCancelEvent',tkVariant,__GetIID_IObjectWithCancelEvent,nil,nil,false,0);
    DefineProp('IID_IUserNotification',tkVariant,__GetIID_IUserNotification,nil,nil,false,0);
    DefineProp('IID_IUserNotificationCallback',tkVariant,__GetIID_IUserNotificationCallback,nil,nil,false,0);
    DefineProp('IID_IUserNotification2',tkVariant,__GetIID_IUserNotification2,nil,nil,false,0);
    DefineProp('IID_IItemNameLimits',tkVariant,__GetIID_IItemNameLimits,nil,nil,false,0);
    DefineProp('IID_ISearchFolderItemFactory',tkVariant,__GetIID_ISearchFolderItemFactory,nil,nil,false,0);
    DefineProp('IID_IExtractImage',tkVariant,__GetIID_IExtractImage,nil,nil,false,0);
    DefineProp('IID_IExtractImage2',tkVariant,__GetIID_IExtractImage2,nil,nil,false,0);
    DefineProp('IID_IThumbnailHandlerFactory',tkVariant,__GetIID_IThumbnailHandlerFactory,nil,nil,false,0);
    DefineProp('IID_IParentAndItem',tkVariant,__GetIID_IParentAndItem,nil,nil,false,0);
    DefineProp('IID_IDockingWindow',tkVariant,__GetIID_IDockingWindow,nil,nil,false,0);
    DefineProp('IID_IDeskBand',tkVariant,__GetIID_IDeskBand,nil,nil,false,0);
    DefineProp('IID_IDeskBandInfo',tkVariant,__GetIID_IDeskBandInfo,nil,nil,false,0);
    DefineProp('IID_IDeskBand2',tkVariant,__GetIID_IDeskBand2,nil,nil,false,0);
    DefineProp('IID_ITaskbarList',tkVariant,__GetIID_ITaskbarList,nil,nil,false,0);
    DefineProp('IID_ITaskbarList2',tkVariant,__GetIID_ITaskbarList2,nil,nil,false,0);
    DefineProp('IID_ITaskbarList3',tkVariant,__GetIID_ITaskbarList3,nil,nil,false,0);
    DefineProp('IID_ITaskbarList4',tkVariant,__GetIID_ITaskbarList4,nil,nil,false,0);
    DefineProp('IID_IStartMenuPinnedList',tkVariant,__GetIID_IStartMenuPinnedList,nil,nil,false,0);
    DefineProp('IID_ICDBurn',tkVariant,__GetIID_ICDBurn,nil,nil,false,0);
    DefineProp('IID_IWizardSite',tkVariant,__GetIID_IWizardSite,nil,nil,false,0);
    DefineProp('IID_IWizardExtension',tkVariant,__GetIID_IWizardExtension,nil,nil,false,0);
    DefineProp('IID_IWebWizardExtension',tkVariant,__GetIID_IWebWizardExtension,nil,nil,false,0);
    DefineProp('IID_IPublishingWizard',tkVariant,__GetIID_IPublishingWizard,nil,nil,false,0);
    DefineProp('IID_IFolderViewHost',tkVariant,__GetIID_IFolderViewHost,nil,nil,false,0);
    DefineProp('IID_IExplorerBrowserEvents',tkVariant,__GetIID_IExplorerBrowserEvents,nil,nil,false,0);
    DefineProp('IID_IExplorerBrowser',tkVariant,__GetIID_IExplorerBrowser,nil,nil,false,0);
    DefineProp('IID_IAccessibleObject',tkVariant,__GetIID_IAccessibleObject,nil,nil,false,0);
    DefineProp('IID_IResultsFolder',tkVariant,__GetIID_IResultsFolder,nil,nil,false,0);
    DefineProp('IID_IEnumObjects',tkVariant,__GetIID_IEnumObjects,nil,nil,false,0);
    DefineProp('IID_IOperationsProgressDialog',tkVariant,__GetIID_IOperationsProgressDialog,nil,nil,false,0);
    DefineProp('IID_IIOCancelInformation',tkVariant,__GetIID_IIOCancelInformation,nil,nil,false,0);
    DefineProp('IID_IFileOperation',tkVariant,__GetIID_IFileOperation,nil,nil,false,0);
    DefineProp('IID_IObjectProvider',tkVariant,__GetIID_IObjectProvider,nil,nil,false,0);
    DefineProp('IID_INamespaceWalkCB',tkVariant,__GetIID_INamespaceWalkCB,nil,nil,false,0);
    DefineProp('IID_INamespaceWalkCB2',tkVariant,__GetIID_INamespaceWalkCB2,nil,nil,false,0);
    DefineProp('IID_INamespaceWalk',tkVariant,__GetIID_INamespaceWalk,nil,nil,false,0);
    DefineProp('IID_IAutoCompleteDropDown',tkVariant,__GetIID_IAutoCompleteDropDown,nil,nil,false,0);
    DefineProp('IID_IBandSite',tkVariant,__GetIID_IBandSite,nil,nil,false,0);
    DefineProp('IID_IModalWindow',tkVariant,__GetIID_IModalWindow,nil,nil,false,0);
    DefineProp('IID_ICDBurnExt',tkVariant,__GetIID_ICDBurnExt,nil,nil,false,0);
    DefineProp('IID_IContextMenuSite',tkVariant,__GetIID_IContextMenuSite,nil,nil,false,0);
    DefineProp('IID_IEnumReadyCallback',tkVariant,__GetIID_IEnumReadyCallback,nil,nil,false,0);
    DefineProp('IID_IEnumerableView',tkVariant,__GetIID_IEnumerableView,nil,nil,false,0);
    DefineProp('IID_IInsertItem',tkVariant,__GetIID_IInsertItem,nil,nil,false,0);
    DefineProp('IID_IMenuBand',tkVariant,__GetIID_IMenuBand,nil,nil,false,0);
    DefineProp('IID_IFolderBandPriv',tkVariant,__GetIID_IFolderBandPriv,nil,nil,false,0);
    DefineProp('IID_IRegTreeItem',tkVariant,__GetIID_IRegTreeItem,nil,nil,false,0);
    DefineProp('IID_IImageRecompress',tkVariant,__GetIID_IImageRecompress,nil,nil,false,0);
    DefineProp('IID_IDeskBar',tkVariant,__GetIID_IDeskBar,nil,nil,false,0);
    DefineProp('IID_IMenuPopup',tkVariant,__GetIID_IMenuPopup,nil,nil,false,0);
    DefineProp('IID_IFileIsInUse',tkVariant,__GetIID_IFileIsInUse,nil,nil,false,0);
    DefineProp('IID_IFileDialogEvents',tkVariant,__GetIID_IFileDialogEvents,nil,nil,false,0);
    DefineProp('IID_IFileDialog',tkVariant,__GetIID_IFileDialog,nil,nil,false,0);
    DefineProp('IID_IFileSaveDialog',tkVariant,__GetIID_IFileSaveDialog,nil,nil,false,0);
    DefineProp('IID_IFileOpenDialog',tkVariant,__GetIID_IFileOpenDialog,nil,nil,false,0);
    DefineProp('IID_IFileDialogCustomize',tkVariant,__GetIID_IFileDialogCustomize,nil,nil,false,0);
    DefineProp('IID_IFileDialogControlEvents',tkVariant,__GetIID_IFileDialogControlEvents,nil,nil,false,0);
    DefineProp('IID_IFileDialog2',tkVariant,__GetIID_IFileDialog2,nil,nil,false,0);
    DefineProp('IID_IApplicationAssociationRegistration',tkVariant,__GetIID_IApplicationAssociationRegistration,nil,nil,false,0);
    DefineProp('IID_IApplicationAssociationRegistrationUI',tkVariant,__GetIID_IApplicationAssociationRegistrationUI,nil,nil,false,0);
    DefineProp('IID_IDelegateFolder',tkVariant,__GetIID_IDelegateFolder,nil,nil,false,0);
    DefineProp('IID_IBrowserFrameOptions',tkVariant,__GetIID_IBrowserFrameOptions,nil,nil,false,0);
    DefineProp('IID_INewWindowManager',tkVariant,__GetIID_INewWindowManager,nil,nil,false,0);
    DefineProp('IID_IAttachmentExecute',tkVariant,__GetIID_IAttachmentExecute,nil,nil,false,0);
    DefineProp('IID_IShellMenuCallback',tkVariant,__GetIID_IShellMenuCallback,nil,nil,false,0);
    DefineProp('IID_IShellMenu',tkVariant,__GetIID_IShellMenu,nil,nil,false,0);
    DefineProp('IID_IShellRunDll',tkVariant,__GetIID_IShellRunDll,nil,nil,false,0);
    DefineProp('IID_IKnownFolder',tkVariant,__GetIID_IKnownFolder,nil,nil,false,0);
    DefineProp('IID_IKnownFolderManager',tkVariant,__GetIID_IKnownFolderManager,nil,nil,false,0);
    DefineProp('IID_ISharingConfigurationManager',tkVariant,__GetIID_ISharingConfigurationManager,nil,nil,false,0);
    DefineProp('IID_IPreviousVersionsInfo',tkVariant,__GetIID_IPreviousVersionsInfo,nil,nil,false,0);
    DefineProp('IID_IRelatedItem',tkVariant,__GetIID_IRelatedItem,nil,nil,false,0);
    DefineProp('IID_IIdentityName',tkVariant,__GetIID_IIdentityName,nil,nil,false,0);
    DefineProp('IID_IDelegateItem',tkVariant,__GetIID_IDelegateItem,nil,nil,false,0);
    DefineProp('IID_ICurrentItem',tkVariant,__GetIID_ICurrentItem,nil,nil,false,0);
    DefineProp('IID_ITransferMediumItem',tkVariant,__GetIID_ITransferMediumItem,nil,nil,false,0);
    DefineProp('IID_IUseToBrowseItem',tkVariant,__GetIID_IUseToBrowseItem,nil,nil,false,0);
    DefineProp('IID_IDisplayItem',tkVariant,__GetIID_IDisplayItem,nil,nil,false,0);
    DefineProp('IID_IViewStateIdentityItem',tkVariant,__GetIID_IViewStateIdentityItem,nil,nil,false,0);
    DefineProp('IID_IPreviewItem',tkVariant,__GetIID_IPreviewItem,nil,nil,false,0);
    DefineProp('IID_IDestinationStreamFactory',tkVariant,__GetIID_IDestinationStreamFactory,nil,nil,false,0);
    DefineProp('IID_INewMenuClient',tkVariant,__GetIID_INewMenuClient,nil,nil,false,0);
    DefineProp('IID_IInitializeWithBindCtx',tkVariant,__GetIID_IInitializeWithBindCtx,nil,nil,false,0);
    DefineProp('IID_IShellItemFilter',tkVariant,__GetIID_IShellItemFilter,nil,nil,false,0);
    DefineProp('IID_INameSpaceTreeControl',tkVariant,__GetIID_INameSpaceTreeControl,nil,nil,false,0);
    DefineProp('IID_INameSpaceTreeControl2',tkVariant,__GetIID_INameSpaceTreeControl2,nil,nil,false,0);
    DefineProp('IID_INameSpaceTreeControlEvents',tkVariant,__GetIID_INameSpaceTreeControlEvents,nil,nil,false,0);
    DefineProp('IID_INameSpaceTreeControlDropHandler',tkVariant,__GetIID_INameSpaceTreeControlDropHandler,nil,nil,false,0);
    DefineProp('IID_INameSpaceTreeAccessible',tkVariant,__GetIID_INameSpaceTreeAccessible,nil,nil,false,0);
    DefineProp('IID_INameSpaceTreeControlCustomDraw',tkVariant,__GetIID_INameSpaceTreeControlCustomDraw,nil,nil,false,0);
    DefineProp('IID_INameSpaceTreeControlFolderCapabilities',tkVariant,__GetIID_INameSpaceTreeControlFolderCapabilities,nil,nil,false,0);
    DefineProp('IID_IPreviewHandler',tkVariant,__GetIID_IPreviewHandler,nil,nil,false,0);
    DefineProp('IID_IPreviewHandlerFrame',tkVariant,__GetIID_IPreviewHandlerFrame,nil,nil,false,0);
    DefineProp('IID_ITrayDeskBand',tkVariant,__GetIID_ITrayDeskBand,nil,nil,false,0);
    DefineProp('IID_IBandHost',tkVariant,__GetIID_IBandHost,nil,nil,false,0);
    DefineProp('IID_IExplorerPaneVisibility',tkVariant,__GetIID_IExplorerPaneVisibility,nil,nil,false,0);
    DefineProp('IID_IContextMenuCB',tkVariant,__GetIID_IContextMenuCB,nil,nil,false,0);
    DefineProp('IID_IDefaultExtractIconInit',tkVariant,__GetIID_IDefaultExtractIconInit,nil,nil,false,0);
    DefineProp('IID_IExplorerCommand',tkVariant,__GetIID_IExplorerCommand,nil,nil,false,0);
    DefineProp('IID_IExplorerCommandState',tkVariant,__GetIID_IExplorerCommandState,nil,nil,false,0);
    DefineProp('IID_IInitializeCommand',tkVariant,__GetIID_IInitializeCommand,nil,nil,false,0);
    DefineProp('IID_IEnumExplorerCommand',tkVariant,__GetIID_IEnumExplorerCommand,nil,nil,false,0);
    DefineProp('IID_IExplorerCommandProvider',tkVariant,__GetIID_IExplorerCommandProvider,nil,nil,false,0);
    DefineProp('IID_IMarkupCallback',tkVariant,__GetIID_IMarkupCallback,nil,nil,false,0);
    DefineProp('IID_IControlMarkup',tkVariant,__GetIID_IControlMarkup,nil,nil,false,0);
    DefineProp('IID_IInitializeNetworkFolder',tkVariant,__GetIID_IInitializeNetworkFolder,nil,nil,false,0);
    DefineProp('IID_IOpenControlPanel',tkVariant,__GetIID_IOpenControlPanel,nil,nil,false,0);
    DefineProp('IID_IComputerInfoChangeNotify',tkVariant,__GetIID_IComputerInfoChangeNotify,nil,nil,false,0);
    DefineProp('IID_IFileSystemBindData',tkVariant,__GetIID_IFileSystemBindData,nil,nil,false,0);
    DefineProp('IID_IFileSystemBindData2',tkVariant,__GetIID_IFileSystemBindData2,nil,nil,false,0);
    DefineProp('IID_ICustomDestinationList',tkVariant,__GetIID_ICustomDestinationList,nil,nil,false,0);
    DefineProp('IID_IApplicationDestinations',tkVariant,__GetIID_IApplicationDestinations,nil,nil,false,0);
    DefineProp('IID_IApplicationDocumentLists',tkVariant,__GetIID_IApplicationDocumentLists,nil,nil,false,0);
    DefineProp('IID_IObjectWithAppUserModelID',tkVariant,__GetIID_IObjectWithAppUserModelID,nil,nil,false,0);
    DefineProp('IID_IObjectWithProgID',tkVariant,__GetIID_IObjectWithProgID,nil,nil,false,0);
    DefineProp('IID_IUpdateIDList',tkVariant,__GetIID_IUpdateIDList,nil,nil,false,0);
    DefineProp('IID_IDesktopGadget',tkVariant,__GetIID_IDesktopGadget,nil,nil,false,0);
    DefineProp('IID_IHomeGroup',tkVariant,__GetIID_IHomeGroup,nil,nil,false,0);
    DefineProp('IID_IInitializeWithPropertyStore',tkVariant,__GetIID_IInitializeWithPropertyStore,nil,nil,false,0);
    DefineProp('IID_IOpenSearchSource',tkVariant,__GetIID_IOpenSearchSource,nil,nil,false,0);
    DefineProp('IID_IShellLibrary',tkVariant,__GetIID_IShellLibrary,nil,nil,false,0);
    DefineProp('IID_IAssocHandlerInvoker',tkVariant,__GetIID_IAssocHandlerInvoker,nil,nil,false,0);
    DefineProp('IID_IAssocHandler',tkVariant,__GetIID_IAssocHandler,nil,nil,false,0);
    DefineProp('IID_IEnumAssocHandlers',tkVariant,__GetIID_IEnumAssocHandlers,nil,nil,false,0);
    DefineProp('SID_SFolderView',tkVariant,__GetSID_SFolderView,nil,nil,false,0);
    DefineProp('SID_SExplorerBrowserFrame',tkVariant,__GetSID_SExplorerBrowserFrame,nil,nil,false,0);
    DefineProp('SID_SProfferService',tkVariant,__GetSID_SProfferService,nil,nil,false,0);
    DefineProp('CGID_DeskBand',tkVariant,__GetCGID_DeskBand,nil,nil,false,0);
    DefineProp('SID_WizardSite',tkVariant,__GetSID_WizardSite,nil,nil,false,0);
    DefineProp('SID_WebWizardHost',tkVariant,__GetSID_WebWizardHost,nil,nil,false,0);
    DefineProp('SID_SBandSite',tkVariant,__GetSID_SBandSite,nil,nil,false,0);
    DefineProp('CGID_BandSite',tkVariant,__GetCGID_BandSite,nil,nil,false,0);
    DefineProp('SID_CDWizardHost',tkVariant,__GetSID_CDWizardHost,nil,nil,false,0);
    DefineProp('SID_EnumerableView',tkVariant,__GetSID_EnumerableView,nil,nil,false,0);
    DefineProp('SID_SNewWindowManager',tkVariant,__GetSID_SNewWindowManager,nil,nil,false,0);
    DefineProp('SID_SNewMenuClient',tkVariant,__GetSID_SNewMenuClient,nil,nil,false,0);
    DefineProp('SID_SCommandBarState',tkVariant,__GetSID_SCommandBarState,nil,nil,false,0);
    DefineProp('SID_SNavigationPane',tkVariant,__GetSID_SNavigationPane,nil,nil,false,0);
    DefineProp('SID_SBandHost',tkVariant,__GetSID_SBandHost,nil,nil,false,0);
    DefineProp('SID_ExplorerPaneVisibility',tkVariant,__GetSID_ExplorerPaneVisibility,nil,nil,false,0);
    DefineProp('SID_LinkSite',tkVariant,__GetSID_LinkSite,nil,nil,false,0);
    DefineProp('SID_SShellBrowser',tkVariant,__GetSID_SShellBrowser,nil,nil,false,0);
    DefineProp('TOID_NULL',tkVariant,__GetTOID_NULL,nil,nil,false,0);
    DefineProp('CLSID_ShellDesktop',tkVariant,__GetCLSID_ShellDesktop,nil,nil,false,0);
    DefineProp('CLSID_ShellFSFolder',tkVariant,__GetCLSID_ShellFSFolder,nil,nil,false,0);
    DefineProp('CLSID_NetworkPlaces',tkVariant,__GetCLSID_NetworkPlaces,nil,nil,false,0);
    DefineProp('CLSID_ShellLink',tkVariant,__GetCLSID_ShellLink,nil,nil,false,0);
    DefineProp('CLSID_QueryCancelAutoPlay',tkVariant,__GetCLSID_QueryCancelAutoPlay,nil,nil,false,0);
    DefineProp('CLSID_DriveSizeCategorizer',tkVariant,__GetCLSID_DriveSizeCategorizer,nil,nil,false,0);
    DefineProp('CLSID_DriveTypeCategorizer',tkVariant,__GetCLSID_DriveTypeCategorizer,nil,nil,false,0);
    DefineProp('CLSID_FreeSpaceCategorizer',tkVariant,__GetCLSID_FreeSpaceCategorizer,nil,nil,false,0);
    DefineProp('CLSID_TimeCategorizer',tkVariant,__GetCLSID_TimeCategorizer,nil,nil,false,0);
    DefineProp('CLSID_SizeCategorizer',tkVariant,__GetCLSID_SizeCategorizer,nil,nil,false,0);
    DefineProp('CLSID_AlphabeticalCategorizer',tkVariant,__GetCLSID_AlphabeticalCategorizer,nil,nil,false,0);
    DefineProp('CLSID_MergedCategorizer',tkVariant,__GetCLSID_MergedCategorizer,nil,nil,false,0);
    DefineProp('CLSID_ImageProperties',tkVariant,__GetCLSID_ImageProperties,nil,nil,false,0);
    DefineProp('CLSID_PropertiesUI',tkVariant,__GetCLSID_PropertiesUI,nil,nil,false,0);
    DefineProp('CLSID_UserNotification',tkVariant,__GetCLSID_UserNotification,nil,nil,false,0);
    DefineProp('CLSID_CDBurn',tkVariant,__GetCLSID_CDBurn,nil,nil,false,0);
    DefineProp('CLSID_TaskbarList',tkVariant,__GetCLSID_TaskbarList,nil,nil,false,0);
    DefineProp('CLSID_StartMenuPin',tkVariant,__GetCLSID_StartMenuPin,nil,nil,false,0);
    DefineProp('CLSID_WebWizardHost',tkVariant,__GetCLSID_WebWizardHost,nil,nil,false,0);
    DefineProp('CLSID_PublishDropTarget',tkVariant,__GetCLSID_PublishDropTarget,nil,nil,false,0);
    DefineProp('CLSID_PublishingWizard',tkVariant,__GetCLSID_PublishingWizard,nil,nil,false,0);
    DefineProp('CLSID_InternetPrintOrdering',tkVariant,__GetCLSID_InternetPrintOrdering,nil,nil,false,0);
    DefineProp('CLSID_FolderViewHost',tkVariant,__GetCLSID_FolderViewHost,nil,nil,false,0);
    DefineProp('CLSID_ExplorerBrowser',tkVariant,__GetCLSID_ExplorerBrowser,nil,nil,false,0);
    DefineProp('CLSID_ImageRecompress',tkVariant,__GetCLSID_ImageRecompress,nil,nil,false,0);
    DefineProp('CLSID_TrayBandSiteService',tkVariant,__GetCLSID_TrayBandSiteService,nil,nil,false,0);
    DefineProp('CLSID_TrayDeskBand',tkVariant,__GetCLSID_TrayDeskBand,nil,nil,false,0);
    DefineProp('CLSID_AttachmentServices',tkVariant,__GetCLSID_AttachmentServices,nil,nil,false,0);
    DefineProp('CLSID_DocPropShellExtension',tkVariant,__GetCLSID_DocPropShellExtension,nil,nil,false,0);
    DefineProp('CLSID_ShellItem',tkVariant,__GetCLSID_ShellItem,nil,nil,false,0);
    DefineProp('CLSID_NamespaceWalker',tkVariant,__GetCLSID_NamespaceWalker,nil,nil,false,0);
    DefineProp('CLSID_FileOperation',tkVariant,__GetCLSID_FileOperation,nil,nil,false,0);
    DefineProp('CLSID_FileOpenDialog',tkVariant,__GetCLSID_FileOpenDialog,nil,nil,false,0);
    DefineProp('CLSID_FileSaveDialog',tkVariant,__GetCLSID_FileSaveDialog,nil,nil,false,0);
    DefineProp('CLSID_KnownFolderManager',tkVariant,__GetCLSID_KnownFolderManager,nil,nil,false,0);
    DefineProp('CLSID_FSCopyHandler',tkVariant,__GetCLSID_FSCopyHandler,nil,nil,false,0);
    DefineProp('CLSID_SharingConfigurationManager',tkVariant,__GetCLSID_SharingConfigurationManager,nil,nil,false,0);
    DefineProp('CLSID_PreviousVersions',tkVariant,__GetCLSID_PreviousVersions,nil,nil,false,0);
    DefineProp('CLSID_NetworkConnections',tkVariant,__GetCLSID_NetworkConnections,nil,nil,false,0);
    DefineProp('CLSID_NamespaceTreeControl',tkVariant,__GetCLSID_NamespaceTreeControl,nil,nil,false,0);
    DefineProp('CLSID_IENamespaceTreeControl',tkVariant,__GetCLSID_IENamespaceTreeControl,nil,nil,false,0);
    DefineProp('CLSID_ScheduledTasks',tkVariant,__GetCLSID_ScheduledTasks,nil,nil,false,0);
    DefineProp('CLSID_ApplicationAssociationRegistration',tkVariant,__GetCLSID_ApplicationAssociationRegistration,nil,nil,false,0);
    DefineProp('CLSID_ApplicationAssociationRegistrationUI',tkVariant,__GetCLSID_ApplicationAssociationRegistrationUI,nil,nil,false,0);
    DefineProp('CLSID_SearchFolderItemFactory',tkVariant,__GetCLSID_SearchFolderItemFactory,nil,nil,false,0);
    DefineProp('CLSID_OpenControlPanel',tkVariant,__GetCLSID_OpenControlPanel,nil,nil,false,0);
    DefineProp('CLSID_MailRecipient',tkVariant,__GetCLSID_MailRecipient,nil,nil,false,0);
    DefineProp('CLSID_NetworkExplorerFolder',tkVariant,__GetCLSID_NetworkExplorerFolder,nil,nil,false,0);
    DefineProp('CLSID_DestinationList',tkVariant,__GetCLSID_DestinationList,nil,nil,false,0);
    DefineProp('CLSID_ApplicationDestinations',tkVariant,__GetCLSID_ApplicationDestinations,nil,nil,false,0);
    DefineProp('CLSID_ApplicationDocumentLists',tkVariant,__GetCLSID_ApplicationDocumentLists,nil,nil,false,0);
    DefineProp('CLSID_HomeGroup',tkVariant,__GetCLSID_HomeGroup,nil,nil,false,0);
    DefineProp('CLSID_ShellLibrary',tkVariant,__GetCLSID_ShellLibrary,nil,nil,false,0);
    DefineProp('CLSID_AppStartupLink',tkVariant,__GetCLSID_AppStartupLink,nil,nil,false,0);
    DefineProp('CLSID_EnumerableObjectCollection',tkVariant,__GetCLSID_EnumerableObjectCollection,nil,nil,false,0);
    DefineProp('CLSID_DesktopGadget',tkVariant,__GetCLSID_DesktopGadget,nil,nil,false,0);
    DefineProp('IID_IExtractIconA',tkVariant,__GetIID_IExtractIconA,nil,nil,false,0);
    DefineProp('IID_IExtractIconW',tkVariant,__GetIID_IExtractIconW,nil,nil,false,0);
    DefineProp('IID_IShellIconOverlayIdentifier',tkVariant,__GetIID_IShellIconOverlayIdentifier,nil,nil,false,0);
    DefineProp('IID_IShellIconOverlayManager',tkVariant,__GetIID_IShellIconOverlayManager,nil,nil,false,0);
    DefineProp('IID_IShellIconOverlay',tkVariant,__GetIID_IShellIconOverlay,nil,nil,false,0);
    DefineProp('IID_IShellExecuteHookA',tkVariant,__GetIID_IShellExecuteHookA,nil,nil,false,0);
    DefineProp('IID_IShellExecuteHookW',tkVariant,__GetIID_IShellExecuteHookW,nil,nil,false,0);
    DefineProp('IID_IURLSearchHook',tkVariant,__GetIID_IURLSearchHook,nil,nil,false,0);
    DefineProp('IID_ISearchContext',tkVariant,__GetIID_ISearchContext,nil,nil,false,0);
    DefineProp('IID_IURLSearchHook2',tkVariant,__GetIID_IURLSearchHook2,nil,nil,false,0);
    DefineProp('IID_INewShortcutHookA',tkVariant,__GetIID_INewShortcutHookA,nil,nil,false,0);
    DefineProp('IID_INewShortcutHookW',tkVariant,__GetIID_INewShortcutHookW,nil,nil,false,0);
    DefineProp('IID_ICopyHookA',tkVariant,__GetIID_ICopyHookA,nil,nil,false,0);
    DefineProp('IID_ICopyHookW',tkVariant,__GetIID_ICopyHookW,nil,nil,false,0);
    DefineProp('IID_IFileViewerSite',tkVariant,__GetIID_IFileViewerSite,nil,nil,false,0);
    DefineProp('IID_IFileViewerA',tkVariant,__GetIID_IFileViewerA,nil,nil,false,0);
    DefineProp('IID_IFileViewerW',tkVariant,__GetIID_IFileViewerW,nil,nil,false,0);
    DefineProp('IID_IShellDetails',tkVariant,__GetIID_IShellDetails,nil,nil,false,0);
    DefineProp('IID_IObjMgr',tkVariant,__GetIID_IObjMgr,nil,nil,false,0);
    DefineProp('IID_ICurrentWorkingDirectory',tkVariant,__GetIID_ICurrentWorkingDirectory,nil,nil,false,0);
    DefineProp('IID_IACList',tkVariant,__GetIID_IACList,nil,nil,false,0);
    DefineProp('IID_IACList2',tkVariant,__GetIID_IACList2,nil,nil,false,0);
    DefineProp('IID_IProgressDialog',tkVariant,__GetIID_IProgressDialog,nil,nil,false,0);
    DefineProp('IID_IDockingWindowSite',tkVariant,__GetIID_IDockingWindowSite,nil,nil,false,0);
    DefineProp('IID_IDockingWindowFrame',tkVariant,__GetIID_IDockingWindowFrame,nil,nil,false,0);
    DefineProp('IID_IThumbnailCapture',tkVariant,__GetIID_IThumbnailCapture,nil,nil,false,0);
    DefineProp('IID_IEnumShellImageStore',tkVariant,__GetIID_IEnumShellImageStore,nil,nil,false,0);
    DefineProp('IID_IShellImageStore',tkVariant,__GetIID_IShellImageStore,nil,nil,false,0);
    DefineProp('IID_IShellFolderBand',tkVariant,__GetIID_IShellFolderBand,nil,nil,false,0);
    DefineProp('IID_IDeskBarClient',tkVariant,__GetIID_IDeskBarClient,nil,nil,false,0);
    DefineProp('IID_IActiveDesktop',tkVariant,__GetIID_IActiveDesktop,nil,nil,false,0);
    DefineProp('IID_IActiveDesktopP',tkVariant,__GetIID_IActiveDesktopP,nil,nil,false,0);
    DefineProp('IID_IADesktopP2',tkVariant,__GetIID_IADesktopP2,nil,nil,false,0);
    DefineProp('IID_IColumnProvider',tkVariant,__GetIID_IColumnProvider,nil,nil,false,0);
    DefineProp('IID_IShellChangeNotify',tkVariant,__GetIID_IShellChangeNotify,nil,nil,false,0);
    DefineProp('IID_IQueryInfo',tkVariant,__GetIID_IQueryInfo,nil,nil,false,0);
    DefineProp('IID_IDefViewFrame',tkVariant,__GetIID_IDefViewFrame,nil,nil,false,0);
    DefineProp('IID_IDocViewSite',tkVariant,__GetIID_IDocViewSite,nil,nil,false,0);
    DefineProp('IID_IInitializeObject',tkVariant,__GetIID_IInitializeObject,nil,nil,false,0);
    DefineProp('IID_IBanneredBar',tkVariant,__GetIID_IBanneredBar,nil,nil,false,0);
    DefineProp('IID_IShellFolderViewCB',tkVariant,__GetIID_IShellFolderViewCB,nil,nil,false,0);
    DefineProp('IID_IShellFolderView',tkVariant,__GetIID_IShellFolderView,nil,nil,false,0);
    DefineProp('IID_INamedPropertyBag',tkVariant,__GetIID_INamedPropertyBag,nil,nil,false,0);
    DefineProp('IID_IEnumPrivacyRecords',tkVariant,__GetIID_IEnumPrivacyRecords,nil,nil,false,0);
    DefineProp('IID_IFolderViewOC',tkVariant,__GetIID_IFolderViewOC,nil,nil,false,0);
    DefineProp('IID_DShellFolderViewEvents',tkVariant,__GetIID_DShellFolderViewEvents,nil,nil,false,0);
    DefineProp('IID_DFConstraint',tkVariant,__GetIID_DFConstraint,nil,nil,false,0);
    DefineProp('IID_FolderItem',tkVariant,__GetIID_FolderItem,nil,nil,false,0);
    DefineProp('IID_FolderItems',tkVariant,__GetIID_FolderItems,nil,nil,false,0);
    DefineProp('IID_FolderItemVerb',tkVariant,__GetIID_FolderItemVerb,nil,nil,false,0);
    DefineProp('IID_FolderItemVerbs',tkVariant,__GetIID_FolderItemVerbs,nil,nil,false,0);
    DefineProp('IID_Folder',tkVariant,__GetIID_Folder,nil,nil,false,0);
    DefineProp('IID_Folder2',tkVariant,__GetIID_Folder2,nil,nil,false,0);
    DefineProp('IID_Folder3',tkVariant,__GetIID_Folder3,nil,nil,false,0);
    DefineProp('IID_FolderItem2',tkVariant,__GetIID_FolderItem2,nil,nil,false,0);
    DefineProp('IID_FolderItems2',tkVariant,__GetIID_FolderItems2,nil,nil,false,0);
    DefineProp('IID_FolderItems3',tkVariant,__GetIID_FolderItems3,nil,nil,false,0);
    DefineProp('IID_IShellLinkDual',tkVariant,__GetIID_IShellLinkDual,nil,nil,false,0);
    DefineProp('IID_IShellLinkDual2',tkVariant,__GetIID_IShellLinkDual2,nil,nil,false,0);
    DefineProp('IID_IShellFolderViewDual',tkVariant,__GetIID_IShellFolderViewDual,nil,nil,false,0);
    DefineProp('IID_IShellFolderViewDual2',tkVariant,__GetIID_IShellFolderViewDual2,nil,nil,false,0);
    DefineProp('IID_IShellFolderViewDual3',tkVariant,__GetIID_IShellFolderViewDual3,nil,nil,false,0);
    DefineProp('IID_IShellDispatch',tkVariant,__GetIID_IShellDispatch,nil,nil,false,0);
    DefineProp('IID_IShellDispatch2',tkVariant,__GetIID_IShellDispatch2,nil,nil,false,0);
    DefineProp('IID_IShellDispatch3',tkVariant,__GetIID_IShellDispatch3,nil,nil,false,0);
    DefineProp('IID_IShellDispatch4',tkVariant,__GetIID_IShellDispatch4,nil,nil,false,0);
    DefineProp('IID_IShellDispatch5',tkVariant,__GetIID_IShellDispatch5,nil,nil,false,0);
    DefineProp('IID_IFileSearchBand',tkVariant,__GetIID_IFileSearchBand,nil,nil,false,0);
    DefineProp('IID_IWebWizardHost',tkVariant,__GetIID_IWebWizardHost,nil,nil,false,0);
    DefineProp('IID_INewWDEvents',tkVariant,__GetIID_INewWDEvents,nil,nil,false,0);
    DefineProp('IID_IAutoComplete',tkVariant,__GetIID_IAutoComplete,nil,nil,false,0);
    DefineProp('IID_IAutoComplete2',tkVariant,__GetIID_IAutoComplete2,nil,nil,false,0);
    DefineProp('IID_IEnumACString',tkVariant,__GetIID_IEnumACString,nil,nil,false,0);
    DefineProp('IID_IAsyncOperation',tkVariant,__GetIID_IAsyncOperation,nil,nil,false,0);
    DefineProp('CLSID_ShellFolderViewOC',tkVariant,__GetCLSID_ShellFolderViewOC,nil,nil,false,0);
    DefineProp('CLSID_ShellFolderItem',tkVariant,__GetCLSID_ShellFolderItem,nil,nil,false,0);
    DefineProp('CLSID_ShellLinkObject',tkVariant,__GetCLSID_ShellLinkObject,nil,nil,false,0);
    DefineProp('CLSID_ShellFolderView',tkVariant,__GetCLSID_ShellFolderView,nil,nil,false,0);
    DefineProp('CLSID_Shell',tkVariant,__GetCLSID_Shell,nil,nil,false,0);
    DefineProp('CLSID_ShellDispatchInproc',tkVariant,__GetCLSID_ShellDispatchInproc,nil,nil,false,0);
    DefineProp('CLSID_FileSearchBand',tkVariant,__GetCLSID_FileSearchBand,nil,nil,false,0);
    AddConsts1;
    AddConsts2;
    AddConsts3;
    AddConstant('DFM_CMD_PASTESPECIAL',DFM_CMD_PASTESPECIAL);
    AddConstant('DFM_CMD_MODALPROP',DFM_CMD_MODALPROP);
    AddConstant('DFM_CMD_RENAME',DFM_CMD_RENAME);
    AddConstant('SFVM_REARRANGE',SFVM_REARRANGE);
    AddConstant('SFVM_ADDOBJECT',SFVM_ADDOBJECT);
    AddConstant('SFVM_REMOVEOBJECT',SFVM_REMOVEOBJECT);
    AddConstant('SFVM_UPDATEOBJECT',SFVM_UPDATEOBJECT);
    AddConstant('SFVM_GETSELECTEDOBJECTS',SFVM_GETSELECTEDOBJECTS);
    AddConstant('SFVM_SETITEMPOS',SFVM_SETITEMPOS);
    AddConstant('SFVM_SETCLIPBOARD',SFVM_SETCLIPBOARD);
    AddConstant('SFVM_SETPOINTS',SFVM_SETPOINTS);
    AddConstant('PID_IS_URL',PID_IS_URL);
    AddConstant('PID_IS_NAME',PID_IS_NAME);
    AddConstant('PID_IS_WORKINGDIR',PID_IS_WORKINGDIR);
    AddConstant('PID_IS_HOTKEY',PID_IS_HOTKEY);
    AddConstant('PID_IS_SHOWCMD',PID_IS_SHOWCMD);
    AddConstant('PID_IS_ICONINDEX',PID_IS_ICONINDEX);
    AddConstant('PID_IS_ICONFILE',PID_IS_ICONFILE);
    AddConstant('PID_IS_WHATSNEW',PID_IS_WHATSNEW);
    AddConstant('PID_IS_AUTHOR',PID_IS_AUTHOR);
    AddConstant('PID_IS_DESCRIPTION',PID_IS_DESCRIPTION);
    AddConstant('PID_IS_COMMENT',PID_IS_COMMENT);
    AddConstant('PID_INTSITE_WHATSNEW',PID_INTSITE_WHATSNEW);
    AddConstant('PID_INTSITE_AUTHOR',PID_INTSITE_AUTHOR);
    AddConstant('PID_INTSITE_LASTVISIT',PID_INTSITE_LASTVISIT);
    AddConstant('PID_INTSITE_LASTMOD',PID_INTSITE_LASTMOD);
    AddConstant('PID_INTSITE_VISITCOUNT',PID_INTSITE_VISITCOUNT);
    AddConstant('PID_INTSITE_DESCRIPTION',PID_INTSITE_DESCRIPTION);
    AddConstant('PID_INTSITE_COMMENT',PID_INTSITE_COMMENT);
    AddConstant('PID_INTSITE_FLAGS',PID_INTSITE_FLAGS);
    AddConstant('PID_INTSITE_CONTENTLEN',PID_INTSITE_CONTENTLEN);
    AddConstant('PID_INTSITE_CONTENTCODE',PID_INTSITE_CONTENTCODE);
    AddConstant('PID_INTSITE_RECURSE',PID_INTSITE_RECURSE);
    AddConstant('PID_INTSITE_WATCH',PID_INTSITE_WATCH);
    AddConstant('PID_INTSITE_SUBSCRIPTION',PID_INTSITE_SUBSCRIPTION);
    AddConstant('PID_INTSITE_URL',PID_INTSITE_URL);
    AddConstant('PID_INTSITE_TITLE',PID_INTSITE_TITLE);
    AddConstant('PID_INTSITE_CODEPAGE',PID_INTSITE_CODEPAGE);
    AddConstant('PID_INTSITE_TRACKING',PID_INTSITE_TRACKING);
    AddConstant('PID_INTSITE_ICONINDEX',PID_INTSITE_ICONINDEX);
    AddConstant('PID_INTSITE_ICONFILE',PID_INTSITE_ICONFILE);
    AddConstant('PIDISF_RECENTLYCHANGED',PIDISF_RECENTLYCHANGED);
    AddConstant('PIDISF_CACHEDSTICKY',PIDISF_CACHEDSTICKY);
    AddConstant('PIDISF_CACHEIMAGES',PIDISF_CACHEIMAGES);
    AddConstant('PIDISF_FOLLOWALLLINKS',PIDISF_FOLLOWALLLINKS);
    AddConstant('PIDISM_GLOBAL',PIDISM_GLOBAL);
    AddConstant('PIDISM_WATCH',PIDISM_WATCH);
    AddConstant('PIDISM_DONTWATCH',PIDISM_DONTWATCH);
    AddConstant('SHELLSTATEVERSION_IE4',SHELLSTATEVERSION_IE4);
    AddConstant('SHELLSTATEVERSION_WIN2K',SHELLSTATEVERSION_WIN2K);
    AddConstant('SSF_SHOWALLOBJECTS',SSF_SHOWALLOBJECTS);
    AddConstant('SSF_SHOWEXTENSIONS',SSF_SHOWEXTENSIONS);
    AddConstant('SSF_HIDDENFILEEXTS',SSF_HIDDENFILEEXTS);
    AddConstant('SSF_SERVERADMINUI',SSF_SERVERADMINUI);
    AddConstant('SSF_SHOWCOMPCOLOR',SSF_SHOWCOMPCOLOR);
    AddConstant('SSF_SORTCOLUMNS',SSF_SORTCOLUMNS);
    AddConstant('SSF_SHOWSYSFILES',SSF_SHOWSYSFILES);
    AddConstant('SSF_DOUBLECLICKINWEBVIEW',SSF_DOUBLECLICKINWEBVIEW);
    AddConstant('SSF_SHOWATTRIBCOL',SSF_SHOWATTRIBCOL);
    AddConstant('SSF_DESKTOPHTML',SSF_DESKTOPHTML);
    AddConstant('SSF_WIN95CLASSIC',SSF_WIN95CLASSIC);
    AddConstant('SSF_DONTPRETTYPATH',SSF_DONTPRETTYPATH);
    AddConstant('SSF_SHOWINFOTIP',SSF_SHOWINFOTIP);
    AddConstant('SSF_MAPNETDRVBUTTON',SSF_MAPNETDRVBUTTON);
    AddConstant('SSF_NOCONFIRMRECYCLE',SSF_NOCONFIRMRECYCLE);
    AddConstant('SSF_HIDEICONS',SSF_HIDEICONS);
    AddConstant('SSF_FILTER',SSF_FILTER);
    AddConstant('SSF_WEBVIEW',SSF_WEBVIEW);
    AddConstant('SSF_SHOWSUPERHIDDEN',SSF_SHOWSUPERHIDDEN);
    AddConstant('SSF_SEPPROCESS',SSF_SEPPROCESS);
    AddConstant('SSF_NONETCRAWLING',SSF_NONETCRAWLING);
    AddConstant('SSF_STARTPANELON',SSF_STARTPANELON);
    AddConstant('SSF_SHOWSTARTPAGE',SSF_SHOWSTARTPAGE);
    AddConstant('SSF_AUTOCHECKSELECT',SSF_AUTOCHECKSELECT);
    AddConstant('SSF_ICONSONLY',SSF_ICONSONLY);
    AddConstant('SSF_SHOWTYPEOVERLAY',SSF_SHOWTYPEOVERLAY);
    AddConstant('SHPPFW_NONE',SHPPFW_NONE);
    AddConstant('SHPPFW_DIRCREATE',SHPPFW_DIRCREATE);
    AddConstant('SHPPFW_ASKDIRCREATE',SHPPFW_ASKDIRCREATE);
    AddConstant('SHPPFW_IGNOREFILENAME',SHPPFW_IGNOREFILENAME);
    AddConstant('SHPPFW_NOWRITECHECK',SHPPFW_NOWRITECHECK);
    AddConstant('SHPPFW_MEDIACHECKONLY',SHPPFW_MEDIACHECKONLY);
    AddConstant('SHPPFW_DEFAULT',SHPPFW_DEFAULT);
    AddConstant('IESHORTCUT_NEWBROWSER',IESHORTCUT_NEWBROWSER);
    AddConstant('IESHORTCUT_OPENNEWTAB',IESHORTCUT_OPENNEWTAB);
    AddConstant('IESHORTCUT_FORCENAVIGATE',IESHORTCUT_FORCENAVIGATE);
    AddConstant('IESHORTCUT_BACKGROUNDTAB',IESHORTCUT_BACKGROUNDTAB);
    AddConstant('SID_IFolderViewOC',SID_IFolderViewOC);
    AddConstant('SID_DShellFolderViewEvents',SID_DShellFolderViewEvents);
    AddConstant('SID_DFConstraint',SID_DFConstraint);
    AddConstant('SID_FolderItem',SID_FolderItem);
    AddConstant('SID_FolderItems',SID_FolderItems);
    AddConstant('SID_FolderItemVerb',SID_FolderItemVerb);
    AddConstant('SID_FolderItemVerbs',SID_FolderItemVerbs);
    AddConstant('SID_Folder',SID_Folder);
    AddConstant('SID_Folder2',SID_Folder2);
    AddConstant('SID_Folder3',SID_Folder3);
    AddConstant('SID_FolderItem2',SID_FolderItem2);
    AddConstant('SID_FolderItems2',SID_FolderItems2);
    AddConstant('SID_FolderItems3',SID_FolderItems3);
    AddConstant('SID_IShellLinkDual',SID_IShellLinkDual);
    AddConstant('SID_IShellLinkDual2',SID_IShellLinkDual2);
    AddConstant('SID_IShellFolderViewDual',SID_IShellFolderViewDual);
    AddConstant('SID_IShellFolderViewDual2',SID_IShellFolderViewDual2);
    AddConstant('SID_IShellFolderViewDual3',SID_IShellFolderViewDual3);
    AddConstant('SID_IShellDispatch',SID_IShellDispatch);
    AddConstant('SID_IShellDispatch2',SID_IShellDispatch2);
    AddConstant('SID_IShellDispatch3',SID_IShellDispatch3);
    AddConstant('SID_IShellDispatch4',SID_IShellDispatch4);
    AddConstant('SID_IShellDispatch5',SID_IShellDispatch5);
    AddConstant('SID_IFileSearchBand',SID_IFileSearchBand);
    AddConstant('SID_IWebWizardHost',SID_IWebWizardHost);
    AddConstant('SID_INewWDEvents',SID_INewWDEvents);
    AddConstant('SID_IAutoComplete',SID_IAutoComplete);
    AddConstant('SID_IAutoComplete2',SID_IAutoComplete2);
    AddConstant('SID_IEnumACString',SID_IEnumACString);
    AddConstant('SID_IAsyncOperation',SID_IAsyncOperation);
    AddConstant('OFS_INACTIVE',OFS_INACTIVE);
    AddConstant('OFS_ONLINE',OFS_ONLINE);
    AddConstant('OFS_OFFLINE',OFS_OFFLINE);
    AddConstant('OFS_SERVERBACK',OFS_SERVERBACK);
    AddConstant('OFS_DIRTYCACHE',OFS_DIRTYCACHE);
    AddConstant('SFVVO_SHOWALLOBJECTS',SFVVO_SHOWALLOBJECTS);
    AddConstant('SFVVO_SHOWEXTENSIONS',SFVVO_SHOWEXTENSIONS);
    AddConstant('SFVVO_SHOWCOMPCOLOR',SFVVO_SHOWCOMPCOLOR);
    AddConstant('SFVVO_SHOWSYSFILES',SFVVO_SHOWSYSFILES);
    AddConstant('SFVVO_WIN95CLASSIC',SFVVO_WIN95CLASSIC);
    AddConstant('SFVVO_DOUBLECLICKINWEBVIEW',SFVVO_DOUBLECLICKINWEBVIEW);
    AddConstant('SFVVO_DESKTOPHTML',SFVVO_DESKTOPHTML);
    AddConstant('ssfDESKTOP',ssfDESKTOP);
    AddConstant('ssfPROGRAMS',ssfPROGRAMS);
    AddConstant('ssfCONTROLS',ssfCONTROLS);
    AddConstant('ssfPRINTERS',ssfPRINTERS);
    AddConstant('ssfPERSONAL',ssfPERSONAL);
    AddConstant('ssfFAVORITES',ssfFAVORITES);
    AddConstant('ssfSTARTUP',ssfSTARTUP);
    AddConstant('ssfRECENT',ssfRECENT);
    AddConstant('ssfSENDTO',ssfSENDTO);
    AddConstant('ssfBITBUCKET',ssfBITBUCKET);
    AddConstant('ssfSTARTMENU',ssfSTARTMENU);
    AddConstant('ssfDESKTOPDIRECTORY',ssfDESKTOPDIRECTORY);
    AddConstant('ssfDRIVES',ssfDRIVES);
    AddConstant('ssfNETWORK',ssfNETWORK);
    AddConstant('ssfNETHOOD',ssfNETHOOD);
    AddConstant('ssfFONTS',ssfFONTS);
    AddConstant('ssfTEMPLATES',ssfTEMPLATES);
    AddConstant('ssfCOMMONSTARTMENU',ssfCOMMONSTARTMENU);
    AddConstant('ssfCOMMONPROGRAMS',ssfCOMMONPROGRAMS);
    AddConstant('ssfCOMMONSTARTUP',ssfCOMMONSTARTUP);
    AddConstant('ssfCOMMONDESKTOPDIR',ssfCOMMONDESKTOPDIR);
    AddConstant('ssfAPPDATA',ssfAPPDATA);
    AddConstant('ssfPRINTHOOD',ssfPRINTHOOD);
    AddConstant('ssfLOCALAPPDATA',ssfLOCALAPPDATA);
    AddConstant('ssfALTSTARTUP',ssfALTSTARTUP);
    AddConstant('ssfCOMMONALTSTARTUP',ssfCOMMONALTSTARTUP);
    AddConstant('ssfCOMMONFAVORITES',ssfCOMMONFAVORITES);
    AddConstant('ssfINTERNETCACHE',ssfINTERNETCACHE);
    AddConstant('ssfCOOKIES',ssfCOOKIES);
    AddConstant('ssfHISTORY',ssfHISTORY);
    AddConstant('ssfCOMMONAPPDATA',ssfCOMMONAPPDATA);
    AddConstant('ssfWINDOWS',ssfWINDOWS);
    AddConstant('ssfSYSTEM',ssfSYSTEM);
    AddConstant('ssfPROGRAMFILES',ssfPROGRAMFILES);
    AddConstant('ssfMYPICTURES',ssfMYPICTURES);
    AddConstant('ssfPROFILE',ssfPROFILE);
    AddConstant('ssfSYSTEMx86',ssfSYSTEMx86);
    AddConstant('ssfPROGRAMFILESx86',ssfPROGRAMFILESx86);
    AddConstant('ACO_NONE',ACO_NONE);
    AddConstant('ACO_AUTOSUGGEST',ACO_AUTOSUGGEST);
    AddConstant('ACO_AUTOAPPEND',ACO_AUTOAPPEND);
    AddConstant('ACO_SEARCH',ACO_SEARCH);
    AddConstant('ACO_FILTERPREFIXES',ACO_FILTERPREFIXES);
    AddConstant('ACO_USETAB',ACO_USETAB);
    AddConstant('ACO_UPDOWNKEYDROPSLIST',ACO_UPDOWNKEYDROPSLIST);
    AddConstant('ACO_RTLREADING',ACO_RTLREADING);
    AddConstant('ACO_WORD_FILTER',ACO_WORD_FILTER);
    AddConstant('ACO_NOPREFIXFILTERING',ACO_NOPREFIXFILTERING);
    AddConstant('ACEO_NONE',ACEO_NONE);
    AddConstant('ACEO_MOSTRECENTFIRST',ACEO_MOSTRECENTFIRST);
    AddConstant('ACEO_FIRSTUNUSED',ACEO_FIRSTUNUSED);
  end;
end;

class function TatShlObjLibrary.LibraryName: string;
begin
  result := 'ShlObj';
end;

initialization
  RegisterScripterLibrary(TatShlObjLibrary, True);

{$WARNINGS ON}

end.

