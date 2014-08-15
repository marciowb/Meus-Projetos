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
unit ap_Ole2;

interface

uses
  Windows,
  Ole2,
  Variants,
  ap_Windows,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatOle2Library = class(TatScripterLibrary)
    procedure __IUnknownQueryInterface(AMachine: TatVirtualMachine);
    procedure __IUnknownAddRef(AMachine: TatVirtualMachine);
    procedure __IUnknownRelease(AMachine: TatVirtualMachine);
    procedure __IClassFactoryCreateInstance(AMachine: TatVirtualMachine);
    procedure __IClassFactoryLockServer(AMachine: TatVirtualMachine);
    procedure __IMarshalUnmarshalInterface(AMachine: TatVirtualMachine);
    procedure __IMarshalReleaseMarshalData(AMachine: TatVirtualMachine);
    procedure __IMarshalDisconnectObject(AMachine: TatVirtualMachine);
    procedure __IMallocHeapMinimize(AMachine: TatVirtualMachine);
    procedure __IMallocSpyPreAlloc(AMachine: TatVirtualMachine);
    procedure __IMallocSpyPostFree(AMachine: TatVirtualMachine);
    procedure __IMallocSpyPreHeapMinimize(AMachine: TatVirtualMachine);
    procedure __IMallocSpyPostHeapMinimize(AMachine: TatVirtualMachine);
    procedure __IExternalConnectionAddConnection(AMachine: TatVirtualMachine);
    procedure __IExternalConnectionReleaseConnection(AMachine: TatVirtualMachine);
    procedure __IWeakRefChangeWeakCount(AMachine: TatVirtualMachine);
    procedure __IWeakRefReleaseKeepAlive(AMachine: TatVirtualMachine);
    procedure __IEnumUnknownSkip(AMachine: TatVirtualMachine);
    procedure __IEnumUnknownReset(AMachine: TatVirtualMachine);
    procedure __IEnumUnknownClone(AMachine: TatVirtualMachine);
    procedure __IBindCtxRegisterObjectBound(AMachine: TatVirtualMachine);
    procedure __IBindCtxRevokeObjectBound(AMachine: TatVirtualMachine);
    procedure __IBindCtxReleaseBoundObjects(AMachine: TatVirtualMachine);
    procedure __IBindCtxSetBindOptions(AMachine: TatVirtualMachine);
    procedure __IBindCtxGetBindOptions(AMachine: TatVirtualMachine);
    procedure __IBindCtxGetRunningObjectTable(AMachine: TatVirtualMachine);
    procedure __IBindCtxRegisterObjectParam(AMachine: TatVirtualMachine);
    procedure __IBindCtxGetObjectParam(AMachine: TatVirtualMachine);
    procedure __IBindCtxEnumObjectParam(AMachine: TatVirtualMachine);
    procedure __IBindCtxRevokeObjectParam(AMachine: TatVirtualMachine);
    procedure __IEnumMonikerSkip(AMachine: TatVirtualMachine);
    procedure __IEnumMonikerReset(AMachine: TatVirtualMachine);
    procedure __IEnumMonikerClone(AMachine: TatVirtualMachine);
    procedure __IRunnableObjectGetRunningClass(AMachine: TatVirtualMachine);
    procedure __IRunnableObjectRun(AMachine: TatVirtualMachine);
    procedure __IRunnableObjectIsRunning(AMachine: TatVirtualMachine);
    procedure __IRunnableObjectLockRunning(AMachine: TatVirtualMachine);
    procedure __IRunnableObjectSetContainedObject(AMachine: TatVirtualMachine);
    procedure __IRunningObjectTableRegister(AMachine: TatVirtualMachine);
    procedure __IRunningObjectTableRevoke(AMachine: TatVirtualMachine);
    procedure __IRunningObjectTableIsRunning(AMachine: TatVirtualMachine);
    procedure __IRunningObjectTableGetObject(AMachine: TatVirtualMachine);
    procedure __IRunningObjectTableNoteChangeTime(AMachine: TatVirtualMachine);
    procedure __IRunningObjectTableGetTimeOfLastChange(AMachine: TatVirtualMachine);
    procedure __IRunningObjectTableEnumRunning(AMachine: TatVirtualMachine);
    procedure __IPersistGetClassID(AMachine: TatVirtualMachine);
    procedure __IPersistStreamIsDirty(AMachine: TatVirtualMachine);
    procedure __IPersistStreamLoad(AMachine: TatVirtualMachine);
    procedure __IPersistStreamSave(AMachine: TatVirtualMachine);
    procedure __IPersistStreamGetSizeMax(AMachine: TatVirtualMachine);
    procedure __IMonikerBindToObject(AMachine: TatVirtualMachine);
    procedure __IMonikerBindToStorage(AMachine: TatVirtualMachine);
    procedure __IMonikerReduce(AMachine: TatVirtualMachine);
    procedure __IMonikerComposeWith(AMachine: TatVirtualMachine);
    procedure __IMonikerEnum(AMachine: TatVirtualMachine);
    procedure __IMonikerIsEqual(AMachine: TatVirtualMachine);
    procedure __IMonikerHash(AMachine: TatVirtualMachine);
    procedure __IMonikerIsRunning(AMachine: TatVirtualMachine);
    procedure __IMonikerGetTimeOfLastChange(AMachine: TatVirtualMachine);
    procedure __IMonikerInverse(AMachine: TatVirtualMachine);
    procedure __IMonikerCommonPrefixWith(AMachine: TatVirtualMachine);
    procedure __IMonikerRelativePathTo(AMachine: TatVirtualMachine);
    procedure __IMonikerGetDisplayName(AMachine: TatVirtualMachine);
    procedure __IMonikerParseDisplayName(AMachine: TatVirtualMachine);
    procedure __IMonikerIsSystemMoniker(AMachine: TatVirtualMachine);
    procedure __IEnumStringSkip(AMachine: TatVirtualMachine);
    procedure __IEnumStringReset(AMachine: TatVirtualMachine);
    procedure __IEnumStringClone(AMachine: TatVirtualMachine);
    procedure __IStreamSeek(AMachine: TatVirtualMachine);
    procedure __IStreamSetSize(AMachine: TatVirtualMachine);
    procedure __IStreamCopyTo(AMachine: TatVirtualMachine);
    procedure __IStreamCommit(AMachine: TatVirtualMachine);
    procedure __IStreamRevert(AMachine: TatVirtualMachine);
    procedure __IStreamLockRegion(AMachine: TatVirtualMachine);
    procedure __IStreamUnlockRegion(AMachine: TatVirtualMachine);
    procedure __IStreamStat(AMachine: TatVirtualMachine);
    procedure __IStreamClone(AMachine: TatVirtualMachine);
    procedure __IEnumStatStgSkip(AMachine: TatVirtualMachine);
    procedure __IEnumStatStgReset(AMachine: TatVirtualMachine);
    procedure __IEnumStatStgClone(AMachine: TatVirtualMachine);
    procedure __IStorageCreateStream(AMachine: TatVirtualMachine);
    procedure __IStorageCreateStorage(AMachine: TatVirtualMachine);
    procedure __IStorageMoveElementTo(AMachine: TatVirtualMachine);
    procedure __IStorageCommit(AMachine: TatVirtualMachine);
    procedure __IStorageRevert(AMachine: TatVirtualMachine);
    procedure __IStorageDestroyElement(AMachine: TatVirtualMachine);
    procedure __IStorageRenameElement(AMachine: TatVirtualMachine);
    procedure __IStorageSetElementTimes(AMachine: TatVirtualMachine);
    procedure __IStorageSetClass(AMachine: TatVirtualMachine);
    procedure __IStorageSetStateBits(AMachine: TatVirtualMachine);
    procedure __IStorageStat(AMachine: TatVirtualMachine);
    procedure __IPersistFileIsDirty(AMachine: TatVirtualMachine);
    procedure __IPersistFileLoad(AMachine: TatVirtualMachine);
    procedure __IPersistFileSave(AMachine: TatVirtualMachine);
    procedure __IPersistFileSaveCompleted(AMachine: TatVirtualMachine);
    procedure __IPersistFileGetCurFile(AMachine: TatVirtualMachine);
    procedure __IPersistStorageIsDirty(AMachine: TatVirtualMachine);
    procedure __IPersistStorageInitNew(AMachine: TatVirtualMachine);
    procedure __IPersistStorageLoad(AMachine: TatVirtualMachine);
    procedure __IPersistStorageSave(AMachine: TatVirtualMachine);
    procedure __IPersistStorageSaveCompleted(AMachine: TatVirtualMachine);
    procedure __IPersistStorageHandsOffStorage(AMachine: TatVirtualMachine);
    procedure __ILockBytesFlush(AMachine: TatVirtualMachine);
    procedure __ILockBytesSetSize(AMachine: TatVirtualMachine);
    procedure __ILockBytesLockRegion(AMachine: TatVirtualMachine);
    procedure __ILockBytesUnlockRegion(AMachine: TatVirtualMachine);
    procedure __ILockBytesStat(AMachine: TatVirtualMachine);
    procedure __IEnumFormatEtcSkip(AMachine: TatVirtualMachine);
    procedure __IEnumFormatEtcReset(AMachine: TatVirtualMachine);
    procedure __IEnumFormatEtcClone(AMachine: TatVirtualMachine);
    procedure __IEnumStatDataSkip(AMachine: TatVirtualMachine);
    procedure __IEnumStatDataReset(AMachine: TatVirtualMachine);
    procedure __IEnumStatDataClone(AMachine: TatVirtualMachine);
    procedure __IRootStorageSwitchToFile(AMachine: TatVirtualMachine);
    procedure __IAdviseSinkOnDataChange(AMachine: TatVirtualMachine);
    procedure __IAdviseSinkOnViewChange(AMachine: TatVirtualMachine);
    procedure __IAdviseSinkOnRename(AMachine: TatVirtualMachine);
    procedure __IAdviseSinkOnSave(AMachine: TatVirtualMachine);
    procedure __IAdviseSinkOnClose(AMachine: TatVirtualMachine);
    procedure __IAdviseSink2OnLinkSrcChange(AMachine: TatVirtualMachine);
    procedure __IDataObjectGetData(AMachine: TatVirtualMachine);
    procedure __IDataObjectGetDataHere(AMachine: TatVirtualMachine);
    procedure __IDataObjectQueryGetData(AMachine: TatVirtualMachine);
    procedure __IDataObjectGetCanonicalFormatEtc(AMachine: TatVirtualMachine);
    procedure __IDataObjectSetData(AMachine: TatVirtualMachine);
    procedure __IDataObjectEnumFormatEtc(AMachine: TatVirtualMachine);
    procedure __IDataObjectDAdvise(AMachine: TatVirtualMachine);
    procedure __IDataObjectDUnadvise(AMachine: TatVirtualMachine);
    procedure __IDataObjectEnumDAdvise(AMachine: TatVirtualMachine);
    procedure __IDataAdviseHolderAdvise(AMachine: TatVirtualMachine);
    procedure __IDataAdviseHolderUnadvise(AMachine: TatVirtualMachine);
    procedure __IDataAdviseHolderEnumAdvise(AMachine: TatVirtualMachine);
    procedure __IDataAdviseHolderSendOnDataChange(AMachine: TatVirtualMachine);
    procedure __IMessageFilterRetryRejectedCall(AMachine: TatVirtualMachine);
    procedure __IMessageFilterMessagePending(AMachine: TatVirtualMachine);
    procedure __IRpcChannelBufferGetBuffer(AMachine: TatVirtualMachine);
    procedure __IRpcChannelBufferSendReceive(AMachine: TatVirtualMachine);
    procedure __IRpcChannelBufferFreeBuffer(AMachine: TatVirtualMachine);
    procedure __IRpcChannelBufferGetDestCtx(AMachine: TatVirtualMachine);
    procedure __IRpcChannelBufferIsConnected(AMachine: TatVirtualMachine);
    procedure __IRpcProxyBufferConnect(AMachine: TatVirtualMachine);
    procedure __IRpcProxyBufferDisconnect(AMachine: TatVirtualMachine);
    procedure __IRpcStubBufferConnect(AMachine: TatVirtualMachine);
    procedure __IRpcStubBufferDisconnect(AMachine: TatVirtualMachine);
    procedure __IRpcStubBufferInvoke(AMachine: TatVirtualMachine);
    procedure __IRpcStubBufferIsIIDSupported(AMachine: TatVirtualMachine);
    procedure __IRpcStubBufferCountRefs(AMachine: TatVirtualMachine);
    procedure __IRpcStubBufferDebugServerQueryInterface(AMachine: TatVirtualMachine);
    procedure __IPSFactoryBufferCreateProxy(AMachine: TatVirtualMachine);
    procedure __IPSFactoryBufferCreateStub(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetGuid(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetTypeFlags(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetDocString(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetHelpContext(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetVersion(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoAddRefTypeInfo(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoAddFuncDesc(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoAddImplType(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetImplTypeFlags(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetAlignment(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetSchema(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoAddVarDesc(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetVarName(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetTypeDescAlias(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoDefineFuncAsDllEntry(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetFuncDocString(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetVarDocString(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetFuncHelpContext(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetVarHelpContext(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetMops(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoSetTypeIdldesc(AMachine: TatVirtualMachine);
    procedure __ICreateTypeInfoLayOut(AMachine: TatVirtualMachine);
    procedure __ICreateTypeLibCreateTypeInfo(AMachine: TatVirtualMachine);
    procedure __ICreateTypeLibSetName(AMachine: TatVirtualMachine);
    procedure __ICreateTypeLibSetVersion(AMachine: TatVirtualMachine);
    procedure __ICreateTypeLibSetGuid(AMachine: TatVirtualMachine);
    procedure __ICreateTypeLibSetDocString(AMachine: TatVirtualMachine);
    procedure __ICreateTypeLibSetHelpFileName(AMachine: TatVirtualMachine);
    procedure __ICreateTypeLibSetHelpContext(AMachine: TatVirtualMachine);
    procedure __ICreateTypeLibSetLcid(AMachine: TatVirtualMachine);
    procedure __ICreateTypeLibSetLibFlags(AMachine: TatVirtualMachine);
    procedure __ICreateTypeLibSaveAllChanges(AMachine: TatVirtualMachine);
    procedure __IDispatchGetTypeInfoCount(AMachine: TatVirtualMachine);
    procedure __IDispatchGetTypeInfo(AMachine: TatVirtualMachine);
    procedure __IEnumVariantNext(AMachine: TatVirtualMachine);
    procedure __IEnumVariantSkip(AMachine: TatVirtualMachine);
    procedure __IEnumVariantReset(AMachine: TatVirtualMachine);
    procedure __IEnumVariantClone(AMachine: TatVirtualMachine);
    procedure __ITypeCompBind(AMachine: TatVirtualMachine);
    procedure __ITypeCompBindType(AMachine: TatVirtualMachine);
    procedure __ITypeInfoGetTypeComp(AMachine: TatVirtualMachine);
    procedure __ITypeInfoGetRefTypeOfImplType(AMachine: TatVirtualMachine);
    procedure __ITypeInfoGetImplTypeFlags(AMachine: TatVirtualMachine);
    procedure __ITypeInfoGetDllEntry(AMachine: TatVirtualMachine);
    procedure __ITypeInfoGetRefTypeInfo(AMachine: TatVirtualMachine);
    procedure __ITypeInfoCreateInstance(AMachine: TatVirtualMachine);
    procedure __ITypeInfoGetMops(AMachine: TatVirtualMachine);
    procedure __ITypeInfoGetContainingTypeLib(AMachine: TatVirtualMachine);
    procedure __ITypeLibGetTypeInfoCount(AMachine: TatVirtualMachine);
    procedure __ITypeLibGetTypeInfo(AMachine: TatVirtualMachine);
    procedure __ITypeLibGetTypeInfoType(AMachine: TatVirtualMachine);
    procedure __ITypeLibGetTypeInfoOfGuid(AMachine: TatVirtualMachine);
    procedure __ITypeLibGetTypeComp(AMachine: TatVirtualMachine);
    procedure __ITypeLibIsName(AMachine: TatVirtualMachine);
    procedure __IErrorInfoGetGUID(AMachine: TatVirtualMachine);
    procedure __IErrorInfoGetSource(AMachine: TatVirtualMachine);
    procedure __IErrorInfoGetDescription(AMachine: TatVirtualMachine);
    procedure __IErrorInfoGetHelpFile(AMachine: TatVirtualMachine);
    procedure __IErrorInfoGetHelpContext(AMachine: TatVirtualMachine);
    procedure __ICreateErrorInfoSetGUID(AMachine: TatVirtualMachine);
    procedure __ICreateErrorInfoSetSource(AMachine: TatVirtualMachine);
    procedure __ICreateErrorInfoSetDescription(AMachine: TatVirtualMachine);
    procedure __ICreateErrorInfoSetHelpFile(AMachine: TatVirtualMachine);
    procedure __ICreateErrorInfoSetHelpContext(AMachine: TatVirtualMachine);
    procedure __ISupportErrorInfoInterfaceSupportsErrorInfo(AMachine: TatVirtualMachine);
    procedure __IOleAdviseHolderAdvise(AMachine: TatVirtualMachine);
    procedure __IOleAdviseHolderUnadvise(AMachine: TatVirtualMachine);
    procedure __IOleAdviseHolderEnumAdvise(AMachine: TatVirtualMachine);
    procedure __IOleAdviseHolderSendOnRename(AMachine: TatVirtualMachine);
    procedure __IOleAdviseHolderSendOnSave(AMachine: TatVirtualMachine);
    procedure __IOleAdviseHolderSendOnClose(AMachine: TatVirtualMachine);
    procedure __IOleCacheCache(AMachine: TatVirtualMachine);
    procedure __IOleCacheUncache(AMachine: TatVirtualMachine);
    procedure __IOleCacheEnumCache(AMachine: TatVirtualMachine);
    procedure __IOleCacheInitCache(AMachine: TatVirtualMachine);
    procedure __IOleCacheSetData(AMachine: TatVirtualMachine);
    procedure __IOleCache2DiscardCache(AMachine: TatVirtualMachine);
    procedure __IOleCacheControlOnRun(AMachine: TatVirtualMachine);
    procedure __IOleCacheControlOnStop(AMachine: TatVirtualMachine);
    procedure __IParseDisplayNameParseDisplayName(AMachine: TatVirtualMachine);
    procedure __IOleContainerEnumObjects(AMachine: TatVirtualMachine);
    procedure __IOleContainerLockContainer(AMachine: TatVirtualMachine);
    procedure __IOleClientSiteSaveObject(AMachine: TatVirtualMachine);
    procedure __IOleClientSiteGetMoniker(AMachine: TatVirtualMachine);
    procedure __IOleClientSiteGetContainer(AMachine: TatVirtualMachine);
    procedure __IOleClientSiteShowObject(AMachine: TatVirtualMachine);
    procedure __IOleClientSiteOnShowWindow(AMachine: TatVirtualMachine);
    procedure __IOleClientSiteRequestNewObjectLayout(AMachine: TatVirtualMachine);
    procedure __IOleObjectSetClientSite(AMachine: TatVirtualMachine);
    procedure __IOleObjectGetClientSite(AMachine: TatVirtualMachine);
    procedure __IOleObjectSetHostNames(AMachine: TatVirtualMachine);
    procedure __IOleObjectClose(AMachine: TatVirtualMachine);
    procedure __IOleObjectSetMoniker(AMachine: TatVirtualMachine);
    procedure __IOleObjectGetMoniker(AMachine: TatVirtualMachine);
    procedure __IOleObjectInitFromData(AMachine: TatVirtualMachine);
    procedure __IOleObjectGetClipboardData(AMachine: TatVirtualMachine);
    procedure __IOleObjectEnumVerbs(AMachine: TatVirtualMachine);
    procedure __IOleObjectUpdate(AMachine: TatVirtualMachine);
    procedure __IOleObjectIsUpToDate(AMachine: TatVirtualMachine);
    procedure __IOleObjectGetUserClassID(AMachine: TatVirtualMachine);
    procedure __IOleObjectGetUserType(AMachine: TatVirtualMachine);
    procedure __IOleObjectSetExtent(AMachine: TatVirtualMachine);
    procedure __IOleObjectGetExtent(AMachine: TatVirtualMachine);
    procedure __IOleObjectAdvise(AMachine: TatVirtualMachine);
    procedure __IOleObjectUnadvise(AMachine: TatVirtualMachine);
    procedure __IOleObjectEnumAdvise(AMachine: TatVirtualMachine);
    procedure __IOleObjectGetMiscStatus(AMachine: TatVirtualMachine);
    procedure __IOleObjectSetColorScheme(AMachine: TatVirtualMachine);
    procedure __IOleWindowGetWindow(AMachine: TatVirtualMachine);
    procedure __IOleWindowContextSensitiveHelp(AMachine: TatVirtualMachine);
    procedure __IOleLinkSetUpdateOptions(AMachine: TatVirtualMachine);
    procedure __IOleLinkGetUpdateOptions(AMachine: TatVirtualMachine);
    procedure __IOleLinkSetSourceMoniker(AMachine: TatVirtualMachine);
    procedure __IOleLinkGetSourceMoniker(AMachine: TatVirtualMachine);
    procedure __IOleLinkSetSourceDisplayName(AMachine: TatVirtualMachine);
    procedure __IOleLinkGetSourceDisplayName(AMachine: TatVirtualMachine);
    procedure __IOleLinkBindToSource(AMachine: TatVirtualMachine);
    procedure __IOleLinkBindIfRunning(AMachine: TatVirtualMachine);
    procedure __IOleLinkGetBoundSource(AMachine: TatVirtualMachine);
    procedure __IOleLinkUnbindSource(AMachine: TatVirtualMachine);
    procedure __IOleLinkUpdate(AMachine: TatVirtualMachine);
    procedure __IOleItemContainerGetObject(AMachine: TatVirtualMachine);
    procedure __IOleItemContainerGetObjectStorage(AMachine: TatVirtualMachine);
    procedure __IOleItemContainerIsRunning(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceUIWindowGetBorder(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceUIWindowRequestBorderSpace(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceUIWindowSetActiveObject(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceActiveObjectTranslateAccelerator(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceActiveObjectOnFrameWindowActivate(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceActiveObjectOnDocWindowActivate(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceActiveObjectResizeBorder(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceActiveObjectEnableModeless(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceFrameInsertMenus(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceFrameSetMenu(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceFrameRemoveMenus(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceFrameSetStatusText(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceFrameEnableModeless(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceFrameTranslateAccelerator(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceObjectInPlaceDeactivate(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceObjectUIDeactivate(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceObjectSetObjectRects(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceObjectReactivateAndUndo(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceSiteCanInPlaceActivate(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceSiteOnInPlaceActivate(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceSiteOnUIActivate(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceSiteGetWindowContext(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceSiteScroll(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceSiteOnUIDeactivate(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceSiteOnInPlaceDeactivate(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceSiteDiscardUndoState(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceSiteDeactivateAndUndo(AMachine: TatVirtualMachine);
    procedure __IOleInPlaceSiteOnPosRectChange(AMachine: TatVirtualMachine);
    procedure __IViewObjectUnfreeze(AMachine: TatVirtualMachine);
    procedure __IViewObjectSetAdvise(AMachine: TatVirtualMachine);
    procedure __IDropSourceQueryContinueDrag(AMachine: TatVirtualMachine);
    procedure __IDropSourceGiveFeedback(AMachine: TatVirtualMachine);
    procedure __IDropTargetDragEnter(AMachine: TatVirtualMachine);
    procedure __IDropTargetDragOver(AMachine: TatVirtualMachine);
    procedure __IDropTargetDragLeave(AMachine: TatVirtualMachine);
    procedure __IDropTargetDrop(AMachine: TatVirtualMachine);
    procedure __IEnumOleVerbSkip(AMachine: TatVirtualMachine);
    procedure __IEnumOleVerbReset(AMachine: TatVirtualMachine);
    procedure __IEnumOleVerbClone(AMachine: TatVirtualMachine);
    procedure __IOleDocumentViewSetInPlaceSite(AMachine: TatVirtualMachine);
    procedure __IOleDocumentViewGetInPlaceSite(AMachine: TatVirtualMachine);
    procedure __IOleDocumentViewGetDocument(AMachine: TatVirtualMachine);
    procedure __IOleDocumentViewSetRect(AMachine: TatVirtualMachine);
    procedure __IOleDocumentViewGetRect(AMachine: TatVirtualMachine);
    procedure __IOleDocumentViewSetRectComplex(AMachine: TatVirtualMachine);
    procedure __IOleDocumentViewShow(AMachine: TatVirtualMachine);
    procedure __IOleDocumentViewUIActivate(AMachine: TatVirtualMachine);
    procedure __IOleDocumentViewOpen(AMachine: TatVirtualMachine);
    procedure __IOleDocumentViewCloseView(AMachine: TatVirtualMachine);
    procedure __IOleDocumentViewSaveViewState(AMachine: TatVirtualMachine);
    procedure __IOleDocumentViewApplyViewState(AMachine: TatVirtualMachine);
    procedure __IOleDocumentViewClone(AMachine: TatVirtualMachine);
    procedure __IEnumOleDocumentViewsNext(AMachine: TatVirtualMachine);
    procedure __IEnumOleDocumentViewsSkip(AMachine: TatVirtualMachine);
    procedure __IEnumOleDocumentViewsReset(AMachine: TatVirtualMachine);
    procedure __IEnumOleDocumentViewsClone(AMachine: TatVirtualMachine);
    procedure __IOleDocumentCreateView(AMachine: TatVirtualMachine);
    procedure __IOleDocumentGetDocMiscStatus(AMachine: TatVirtualMachine);
    procedure __IOleDocumentEnumViews(AMachine: TatVirtualMachine);
    procedure __IOleDocumentSiteActivateMe(AMachine: TatVirtualMachine);
    procedure __Succeeded(AMachine: TatVirtualMachine);
    procedure __Failed(AMachine: TatVirtualMachine);
    procedure __ResultCode(AMachine: TatVirtualMachine);
    procedure __ResultFacility(AMachine: TatVirtualMachine);
    procedure __ResultSeverity(AMachine: TatVirtualMachine);
    procedure __MakeResult(AMachine: TatVirtualMachine);
    procedure __IsEqualGUID(AMachine: TatVirtualMachine);
    procedure __IsEqualIID(AMachine: TatVirtualMachine);
    procedure __IsEqualCLSID(AMachine: TatVirtualMachine);
    procedure __CoBuildVersion(AMachine: TatVirtualMachine);
    procedure __CoUninitialize(AMachine: TatVirtualMachine);
    procedure __CoGetMalloc(AMachine: TatVirtualMachine);
    procedure __CoGetCurrentProcess(AMachine: TatVirtualMachine);
    procedure __CoRegisterMallocSpy(AMachine: TatVirtualMachine);
    procedure __CoRevokeMallocSpy(AMachine: TatVirtualMachine);
    procedure __CoRegisterClassObject(AMachine: TatVirtualMachine);
    procedure __CoRevokeClassObject(AMachine: TatVirtualMachine);
    procedure __CoUnmarshalInterface(AMachine: TatVirtualMachine);
    procedure __CoReleaseMarshalData(AMachine: TatVirtualMachine);
    procedure __CoDisconnectObject(AMachine: TatVirtualMachine);
    procedure __CoLockObjectExternal(AMachine: TatVirtualMachine);
    procedure __CoIsHandlerConnected(AMachine: TatVirtualMachine);
    procedure __CoMarshalInterThreadInterfaceInStream(AMachine: TatVirtualMachine);
    procedure __CoGetInterfaceAndReleaseStream(AMachine: TatVirtualMachine);
    procedure __CoCreateFreeThreadedMarshaler(AMachine: TatVirtualMachine);
    procedure __CoLoadLibrary(AMachine: TatVirtualMachine);
    procedure __CoFreeLibrary(AMachine: TatVirtualMachine);
    procedure __CoFreeAllLibraries(AMachine: TatVirtualMachine);
    procedure __CoFreeUnusedLibraries(AMachine: TatVirtualMachine);
    procedure __CoCreateInstance(AMachine: TatVirtualMachine);
    procedure __StringFromCLSID(AMachine: TatVirtualMachine);
    procedure __CLSIDFromString(AMachine: TatVirtualMachine);
    procedure __StringFromIID(AMachine: TatVirtualMachine);
    procedure __IIDFromString(AMachine: TatVirtualMachine);
    procedure __CoIsOle1Class(AMachine: TatVirtualMachine);
    procedure __ProgIDFromCLSID(AMachine: TatVirtualMachine);
    procedure __CLSIDFromProgID(AMachine: TatVirtualMachine);
    procedure __StringFromGUID2(AMachine: TatVirtualMachine);
    procedure __CoCreateGuid(AMachine: TatVirtualMachine);
    procedure __CoFileTimeToDosDateTime(AMachine: TatVirtualMachine);
    procedure __CoDosDateTimeToFileTime(AMachine: TatVirtualMachine);
    procedure __CoFileTimeNow(AMachine: TatVirtualMachine);
    procedure __CoRegisterMessageFilter(AMachine: TatVirtualMachine);
    procedure __CoGetTreatAsClass(AMachine: TatVirtualMachine);
    procedure __CoTreatAsClass(AMachine: TatVirtualMachine);
    procedure __CreateDataAdviseHolder(AMachine: TatVirtualMachine);
    procedure __CreateDataCache(AMachine: TatVirtualMachine);
    procedure __StgCreateDocfile(AMachine: TatVirtualMachine);
    procedure __StgCreateDocfileOnILockBytes(AMachine: TatVirtualMachine);
    procedure __StgIsStorageFile(AMachine: TatVirtualMachine);
    procedure __StgIsStorageILockBytes(AMachine: TatVirtualMachine);
    procedure __StgSetTimes(AMachine: TatVirtualMachine);
    procedure __BindMoniker(AMachine: TatVirtualMachine);
    procedure __MkParseDisplayName(AMachine: TatVirtualMachine);
    procedure __MonikerRelativePathTo(AMachine: TatVirtualMachine);
    procedure __MonikerCommonPrefixWith(AMachine: TatVirtualMachine);
    procedure __CreateBindCtx(AMachine: TatVirtualMachine);
    procedure __CreateGenericComposite(AMachine: TatVirtualMachine);
    procedure __GetClassFile(AMachine: TatVirtualMachine);
    procedure __CreateFileMoniker(AMachine: TatVirtualMachine);
    procedure __CreateItemMoniker(AMachine: TatVirtualMachine);
    procedure __CreateAntiMoniker(AMachine: TatVirtualMachine);
    procedure __CreatePointerMoniker(AMachine: TatVirtualMachine);
    procedure __GetRunningObjectTable(AMachine: TatVirtualMachine);
    procedure __SysAllocString(AMachine: TatVirtualMachine);
    procedure __SysReAllocString(AMachine: TatVirtualMachine);
    procedure __SysAllocStringLen(AMachine: TatVirtualMachine);
    procedure __SysReAllocStringLen(AMachine: TatVirtualMachine);
    procedure __SysFreeString(AMachine: TatVirtualMachine);
    procedure __SysStringLen(AMachine: TatVirtualMachine);
    procedure __SysStringByteLen(AMachine: TatVirtualMachine);
    procedure __SysAllocStringByteLen(AMachine: TatVirtualMachine);
    procedure __DosDateTimeToVariantTime(AMachine: TatVirtualMachine);
    procedure __VariantTimeToDosDateTime(AMachine: TatVirtualMachine);
    procedure __VariantInit(AMachine: TatVirtualMachine);
    procedure __VariantClear(AMachine: TatVirtualMachine);
    procedure __VariantCopy(AMachine: TatVirtualMachine);
    procedure __VariantCopyInd(AMachine: TatVirtualMachine);
    procedure __VariantChangeType(AMachine: TatVirtualMachine);
    procedure __VariantChangeTypeEx(AMachine: TatVirtualMachine);
    procedure __VarUI1FromI2(AMachine: TatVirtualMachine);
    procedure __VarUI1FromI4(AMachine: TatVirtualMachine);
    procedure __VarUI1FromR4(AMachine: TatVirtualMachine);
    procedure __VarUI1FromR8(AMachine: TatVirtualMachine);
    procedure __VarUI1FromCy(AMachine: TatVirtualMachine);
    procedure __VarUI1FromDate(AMachine: TatVirtualMachine);
    procedure __VarUI1FromStr(AMachine: TatVirtualMachine);
    procedure __VarUI1FromDisp(AMachine: TatVirtualMachine);
    procedure __VarUI1FromBool(AMachine: TatVirtualMachine);
    procedure __VarI2FromUI1(AMachine: TatVirtualMachine);
    procedure __VarI2FromI4(AMachine: TatVirtualMachine);
    procedure __VarI2FromR4(AMachine: TatVirtualMachine);
    procedure __VarI2FromR8(AMachine: TatVirtualMachine);
    procedure __VarI2FromCy(AMachine: TatVirtualMachine);
    procedure __VarI2FromDate(AMachine: TatVirtualMachine);
    procedure __VarI2FromStr(AMachine: TatVirtualMachine);
    procedure __VarI2FromDisp(AMachine: TatVirtualMachine);
    procedure __VarI2FromBool(AMachine: TatVirtualMachine);
    procedure __VarI4FromUI1(AMachine: TatVirtualMachine);
    procedure __VarI4FromI2(AMachine: TatVirtualMachine);
    procedure __VarI4FromR4(AMachine: TatVirtualMachine);
    procedure __VarI4FromR8(AMachine: TatVirtualMachine);
    procedure __VarI4FromCy(AMachine: TatVirtualMachine);
    procedure __VarI4FromDate(AMachine: TatVirtualMachine);
    procedure __VarI4FromStr(AMachine: TatVirtualMachine);
    procedure __VarI4FromDisp(AMachine: TatVirtualMachine);
    procedure __VarI4FromBool(AMachine: TatVirtualMachine);
    procedure __VarR4FromUI1(AMachine: TatVirtualMachine);
    procedure __VarR4FromI2(AMachine: TatVirtualMachine);
    procedure __VarR4FromI4(AMachine: TatVirtualMachine);
    procedure __VarR4FromR8(AMachine: TatVirtualMachine);
    procedure __VarR4FromCy(AMachine: TatVirtualMachine);
    procedure __VarR4FromDate(AMachine: TatVirtualMachine);
    procedure __VarR4FromStr(AMachine: TatVirtualMachine);
    procedure __VarR4FromDisp(AMachine: TatVirtualMachine);
    procedure __VarR4FromBool(AMachine: TatVirtualMachine);
    procedure __VarR8FromUI1(AMachine: TatVirtualMachine);
    procedure __VarR8FromI2(AMachine: TatVirtualMachine);
    procedure __VarR8FromI4(AMachine: TatVirtualMachine);
    procedure __VarR8FromR4(AMachine: TatVirtualMachine);
    procedure __VarR8FromCy(AMachine: TatVirtualMachine);
    procedure __VarR8FromDate(AMachine: TatVirtualMachine);
    procedure __VarR8FromStr(AMachine: TatVirtualMachine);
    procedure __VarR8FromDisp(AMachine: TatVirtualMachine);
    procedure __VarR8FromBool(AMachine: TatVirtualMachine);
    procedure __VarDateFromUI1(AMachine: TatVirtualMachine);
    procedure __VarDateFromI2(AMachine: TatVirtualMachine);
    procedure __VarDateFromI4(AMachine: TatVirtualMachine);
    procedure __VarDateFromR4(AMachine: TatVirtualMachine);
    procedure __VarDateFromR8(AMachine: TatVirtualMachine);
    procedure __VarDateFromCy(AMachine: TatVirtualMachine);
    procedure __VarDateFromStr(AMachine: TatVirtualMachine);
    procedure __VarDateFromDisp(AMachine: TatVirtualMachine);
    procedure __VarDateFromBool(AMachine: TatVirtualMachine);
    procedure __VarCyFromUI1(AMachine: TatVirtualMachine);
    procedure __VarCyFromI2(AMachine: TatVirtualMachine);
    procedure __VarCyFromI4(AMachine: TatVirtualMachine);
    procedure __VarCyFromR4(AMachine: TatVirtualMachine);
    procedure __VarCyFromR8(AMachine: TatVirtualMachine);
    procedure __VarCyFromDate(AMachine: TatVirtualMachine);
    procedure __VarCyFromStr(AMachine: TatVirtualMachine);
    procedure __VarCyFromDisp(AMachine: TatVirtualMachine);
    procedure __VarCyFromBool(AMachine: TatVirtualMachine);
    procedure __VarBoolFromUI1(AMachine: TatVirtualMachine);
    procedure __VarBoolFromI2(AMachine: TatVirtualMachine);
    procedure __VarBoolFromI4(AMachine: TatVirtualMachine);
    procedure __VarBoolFromR4(AMachine: TatVirtualMachine);
    procedure __VarBoolFromR8(AMachine: TatVirtualMachine);
    procedure __VarBoolFromDate(AMachine: TatVirtualMachine);
    procedure __VarBoolFromCy(AMachine: TatVirtualMachine);
    procedure __VarBoolFromStr(AMachine: TatVirtualMachine);
    procedure __VarBoolFromDisp(AMachine: TatVirtualMachine);
    procedure __LHashValOfNameSys(AMachine: TatVirtualMachine);
    procedure __LHashValOfNameSysA(AMachine: TatVirtualMachine);
    procedure __LHashValOfName(AMachine: TatVirtualMachine);
    procedure __WHashValOfLHashVal(AMachine: TatVirtualMachine);
    procedure __IsHashValCompatible(AMachine: TatVirtualMachine);
    procedure __LoadTypeLib(AMachine: TatVirtualMachine);
    procedure __LoadRegTypeLib(AMachine: TatVirtualMachine);
    procedure __QueryPathOfRegTypeLib(AMachine: TatVirtualMachine);
    procedure __RegisterTypeLib(AMachine: TatVirtualMachine);
    procedure __CreateTypeLib(AMachine: TatVirtualMachine);
    procedure __DispGetParam(AMachine: TatVirtualMachine);
    procedure __DispGetIDsOfNames(AMachine: TatVirtualMachine);
    procedure __CreateDispTypeInfo(AMachine: TatVirtualMachine);
    procedure __RegisterActiveObject(AMachine: TatVirtualMachine);
    procedure __SetErrorInfo(AMachine: TatVirtualMachine);
    procedure __GetErrorInfo(AMachine: TatVirtualMachine);
    procedure __CreateErrorInfo(AMachine: TatVirtualMachine);
    procedure __OaBuildVersion(AMachine: TatVirtualMachine);
    procedure __OleBuildVersion(AMachine: TatVirtualMachine);
    procedure __ReadClassStg(AMachine: TatVirtualMachine);
    procedure __WriteClassStg(AMachine: TatVirtualMachine);
    procedure __ReadClassStm(AMachine: TatVirtualMachine);
    procedure __WriteClassStm(AMachine: TatVirtualMachine);
    procedure __WriteFmtUserTypeStg(AMachine: TatVirtualMachine);
    procedure __ReadFmtUserTypeStg(AMachine: TatVirtualMachine);
    procedure __OleUninitialize(AMachine: TatVirtualMachine);
    procedure __OleQueryLinkFromData(AMachine: TatVirtualMachine);
    procedure __OleQueryCreateFromData(AMachine: TatVirtualMachine);
    procedure __OleLoad(AMachine: TatVirtualMachine);
    procedure __OleSave(AMachine: TatVirtualMachine);
    procedure __OleLoadFromStream(AMachine: TatVirtualMachine);
    procedure __OleSaveToStream(AMachine: TatVirtualMachine);
    procedure __OleSetContainedObject(AMachine: TatVirtualMachine);
    procedure __OleNoteObjectVisible(AMachine: TatVirtualMachine);
    procedure __RegisterDragDrop(AMachine: TatVirtualMachine);
    procedure __RevokeDragDrop(AMachine: TatVirtualMachine);
    procedure __DoDragDrop(AMachine: TatVirtualMachine);
    procedure __OleSetClipboard(AMachine: TatVirtualMachine);
    procedure __OleGetClipboard(AMachine: TatVirtualMachine);
    procedure __OleFlushClipboard(AMachine: TatVirtualMachine);
    procedure __OleIsCurrentClipboard(AMachine: TatVirtualMachine);
    procedure __OleCreateMenuDescriptor(AMachine: TatVirtualMachine);
    procedure __OleSetMenuDescriptor(AMachine: TatVirtualMachine);
    procedure __OleDestroyMenuDescriptor(AMachine: TatVirtualMachine);
    procedure __OleDuplicateData(AMachine: TatVirtualMachine);
    procedure __OleDraw(AMachine: TatVirtualMachine);
    procedure __OleRun(AMachine: TatVirtualMachine);
    procedure __OleIsRunning(AMachine: TatVirtualMachine);
    procedure __OleLockRunning(AMachine: TatVirtualMachine);
    procedure __ReleaseStgMedium(AMachine: TatVirtualMachine);
    procedure __CreateOleAdviseHolder(AMachine: TatVirtualMachine);
    procedure __OleCreateDefaultHandler(AMachine: TatVirtualMachine);
    procedure __OleCreateEmbeddingHelper(AMachine: TatVirtualMachine);
    procedure __OleGetIconOfFile(AMachine: TatVirtualMachine);
    procedure __OleGetIconOfClass(AMachine: TatVirtualMachine);
    procedure __OleMetafilePictFromIconAndLabel(AMachine: TatVirtualMachine);
    procedure __OleRegGetUserType(AMachine: TatVirtualMachine);
    procedure __OleRegGetMiscStatus(AMachine: TatVirtualMachine);
    procedure __OleRegEnumFormatEtc(AMachine: TatVirtualMachine);
    procedure __OleRegEnumVerbs(AMachine: TatVirtualMachine);
    procedure __GetHGlobalFromILockBytes(AMachine: TatVirtualMachine);
    procedure __CreateILockBytesOnHGlobal(AMachine: TatVirtualMachine);
    procedure __GetHGlobalFromStream(AMachine: TatVirtualMachine);
    procedure __CreateStreamOnHGlobal(AMachine: TatVirtualMachine);
    procedure __OleDoAutoConvert(AMachine: TatVirtualMachine);
    procedure __OleGetAutoConvert(AMachine: TatVirtualMachine);
    procedure __OleSetAutoConvert(AMachine: TatVirtualMachine);
    procedure __GetConvertStg(AMachine: TatVirtualMachine);
    procedure __SetConvertStg(AMachine: TatVirtualMachine);
    procedure __GetGUID_NULL(AMachine: TatVirtualMachine);
    procedure __GetIID_IUnknown(AMachine: TatVirtualMachine);
    procedure __GetIID_IClassFactory(AMachine: TatVirtualMachine);
    procedure __GetIID_IMarshal(AMachine: TatVirtualMachine);
    procedure __GetIID_IMalloc(AMachine: TatVirtualMachine);
    procedure __GetIID_IStdMarshalInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IExternalConnection(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumUnknown(AMachine: TatVirtualMachine);
    procedure __GetIID_IBindCtx(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumMoniker(AMachine: TatVirtualMachine);
    procedure __GetIID_IRunnableObject(AMachine: TatVirtualMachine);
    procedure __GetIID_IRunningObjectTable(AMachine: TatVirtualMachine);
    procedure __GetIID_IPersist(AMachine: TatVirtualMachine);
    procedure __GetIID_IPersistStream(AMachine: TatVirtualMachine);
    procedure __GetIID_IMoniker(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumString(AMachine: TatVirtualMachine);
    procedure __GetIID_IStream(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumStatStg(AMachine: TatVirtualMachine);
    procedure __GetIID_IStorage(AMachine: TatVirtualMachine);
    procedure __GetIID_IPersistFile(AMachine: TatVirtualMachine);
    procedure __GetIID_IPersistStorage(AMachine: TatVirtualMachine);
    procedure __GetIID_ILockBytes(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumFormatEtc(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumStatData(AMachine: TatVirtualMachine);
    procedure __GetIID_IRootStorage(AMachine: TatVirtualMachine);
    procedure __GetIID_IAdviseSink(AMachine: TatVirtualMachine);
    procedure __GetIID_IAdviseSink2(AMachine: TatVirtualMachine);
    procedure __GetIID_IDataObject(AMachine: TatVirtualMachine);
    procedure __GetIID_IDataAdviseHolder(AMachine: TatVirtualMachine);
    procedure __GetIID_IMessageFilter(AMachine: TatVirtualMachine);
    procedure __GetIID_IRpcChannelBuffer(AMachine: TatVirtualMachine);
    procedure __GetIID_IRpcProxyBuffer(AMachine: TatVirtualMachine);
    procedure __GetIID_IRpcStubBuffer(AMachine: TatVirtualMachine);
    procedure __GetIID_IPSFactoryBuffer(AMachine: TatVirtualMachine);
    procedure __GetIID_ICreateTypeInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_ICreateTypeLib(AMachine: TatVirtualMachine);
    procedure __GetIID_IDispatch(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumVariant(AMachine: TatVirtualMachine);
    procedure __GetIID_ITypeComp(AMachine: TatVirtualMachine);
    procedure __GetIID_ITypeInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_ITypeLib(AMachine: TatVirtualMachine);
    procedure __GetIID_IErrorInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_ICreateErrorInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_ISupportErrorInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleAdviseHolder(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleCache(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleCache2(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleCacheControl(AMachine: TatVirtualMachine);
    procedure __GetIID_IParseDisplayName(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleContainer(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleClientSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleObject(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleWindow(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleLink(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleItemContainer(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleInPlaceUIWindow(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleInPlaceActiveObject(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleInPlaceFrame(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleInPlaceObject(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleInPlaceSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IViewObject(AMachine: TatVirtualMachine);
    procedure __GetIID_IViewObject2(AMachine: TatVirtualMachine);
    procedure __GetIID_IDropSource(AMachine: TatVirtualMachine);
    procedure __GetIID_IDropTarget(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumOleVerb(AMachine: TatVirtualMachine);
    procedure __GetIID_IRpcChannel(AMachine: TatVirtualMachine);
    procedure __GetIID_IRpcStub(AMachine: TatVirtualMachine);
    procedure __GetIID_IStubManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IRpcProxy(AMachine: TatVirtualMachine);
    procedure __GetIID_IProxyManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IPSFactory(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternalMoniker(AMachine: TatVirtualMachine);
    procedure __GetCLSID_StdMarshal(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumGeneric(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumHolder(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumCallback(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IOlePresObj(AMachine: TatVirtualMachine);
    procedure __GetIID_IDebug(AMachine: TatVirtualMachine);
    procedure __GetIID_IDebugStream(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleDocument(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleDocumentSite(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  IUnknownClass = class of IUnknown;
  IClassFactoryClass = class of IClassFactory;
  IMarshalClass = class of IMarshal;
  IMallocClass = class of IMalloc;
  IMallocSpyClass = class of IMallocSpy;
  IStdMarshalInfoClass = class of IStdMarshalInfo;
  IExternalConnectionClass = class of IExternalConnection;
  IWeakRefClass = class of IWeakRef;
  IEnumUnknownClass = class of IEnumUnknown;
  IBindCtxClass = class of IBindCtx;
  IEnumMonikerClass = class of IEnumMoniker;
  IRunnableObjectClass = class of IRunnableObject;
  IRunningObjectTableClass = class of IRunningObjectTable;
  IPersistClass = class of IPersist;
  IPersistStreamClass = class of IPersistStream;
  IMonikerClass = class of IMoniker;
  IEnumStringClass = class of IEnumString;
  IStreamClass = class of IStream;
  IEnumStatStgClass = class of IEnumStatStg;
  IStorageClass = class of IStorage;
  IPersistFileClass = class of IPersistFile;
  IPersistStorageClass = class of IPersistStorage;
  ILockBytesClass = class of ILockBytes;
  IEnumFormatEtcClass = class of IEnumFormatEtc;
  IEnumStatDataClass = class of IEnumStatData;
  IRootStorageClass = class of IRootStorage;
  IAdviseSinkClass = class of IAdviseSink;
  IAdviseSink2Class = class of IAdviseSink2;
  IDataObjectClass = class of IDataObject;
  IDataAdviseHolderClass = class of IDataAdviseHolder;
  IMessageFilterClass = class of IMessageFilter;
  IRpcChannelBufferClass = class of IRpcChannelBuffer;
  IRpcProxyBufferClass = class of IRpcProxyBuffer;
  IRpcStubBufferClass = class of IRpcStubBuffer;
  IPSFactoryBufferClass = class of IPSFactoryBuffer;
  ICreateTypeInfoClass = class of ICreateTypeInfo;
  ICreateTypeLibClass = class of ICreateTypeLib;
  IDispatchClass = class of IDispatch;
  IEnumVariantClass = class of IEnumVariant;
  ITypeCompClass = class of ITypeComp;
  ITypeInfoClass = class of ITypeInfo;
  ITypeLibClass = class of ITypeLib;
  IErrorInfoClass = class of IErrorInfo;
  ICreateErrorInfoClass = class of ICreateErrorInfo;
  ISupportErrorInfoClass = class of ISupportErrorInfo;
  IOleAdviseHolderClass = class of IOleAdviseHolder;
  IOleCacheClass = class of IOleCache;
  IOleCache2Class = class of IOleCache2;
  IOleCacheControlClass = class of IOleCacheControl;
  IParseDisplayNameClass = class of IParseDisplayName;
  IOleContainerClass = class of IOleContainer;
  IOleClientSiteClass = class of IOleClientSite;
  IOleObjectClass = class of IOleObject;
  IOleWindowClass = class of IOleWindow;
  IOleLinkClass = class of IOleLink;
  IOleItemContainerClass = class of IOleItemContainer;
  IOleInPlaceUIWindowClass = class of IOleInPlaceUIWindow;
  IOleInPlaceActiveObjectClass = class of IOleInPlaceActiveObject;
  IOleInPlaceFrameClass = class of IOleInPlaceFrame;
  IOleInPlaceObjectClass = class of IOleInPlaceObject;
  IOleInPlaceSiteClass = class of IOleInPlaceSite;
  IViewObjectClass = class of IViewObject;
  IViewObject2Class = class of IViewObject2;
  IDropSourceClass = class of IDropSource;
  IDropTargetClass = class of IDropTarget;
  IEnumOleVerbClass = class of IEnumOleVerb;
  IOleDocumentViewClass = class of IOleDocumentView;
  IEnumOleDocumentViewsClass = class of IEnumOleDocumentViews;
  IOleDocumentClass = class of IOleDocument;
  IOleDocumentSiteClass = class of IOleDocumentSite;


  TGUIDWrapper = class(TatRecordWrapper)
  private
    FD1: LongWord;
    FD2: Word;
    FD3: Word;
  public
    constructor Create(ARecord: TGUID);
    function ObjToRec: TGUID;
  published
    property D1: LongWord read FD1 write FD1;
    property D2: Word read FD2 write FD2;
    property D3: Word read FD3 write FD3;
  end;
  
  _OBJECTIDWrapper = class(TatRecordWrapper)
  private
    FUniquifier: Longint;
  public
    constructor Create(ARecord: _OBJECTID);
    function ObjToRec: _OBJECTID;
  published
    property Uniquifier: Longint read FUniquifier write FUniquifier;
  end;
  
  tagBIND_OPTSWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FgrfFlags: Longint;
    FgrfMode: Longint;
    FdwTickCountDeadline: Longint;
  public
    constructor Create(ARecord: tagBIND_OPTS);
    function ObjToRec: tagBIND_OPTS;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property grfFlags: Longint read FgrfFlags write FgrfFlags;
    property grfMode: Longint read FgrfMode write FgrfMode;
    property dwTickCountDeadline: Longint read FdwTickCountDeadline write FdwTickCountDeadline;
  end;
  
  tagSTATSTGWrapper = class(TatRecordWrapper)
  private
    FdwType: Longint;
    FcbSize: Largeint;
    FgrfMode: Longint;
    FgrfLocksSupported: Longint;
    FgrfStateBits: Longint;
    Freserved: Longint;
  public
    constructor Create(ARecord: tagSTATSTG);
    function ObjToRec: tagSTATSTG;
  published
    property dwType: Longint read FdwType write FdwType;
    property cbSize: Largeint read FcbSize write FcbSize;
    property grfMode: Longint read FgrfMode write FgrfMode;
    property grfLocksSupported: Longint read FgrfLocksSupported write FgrfLocksSupported;
    property grfStateBits: Longint read FgrfStateBits write FgrfStateBits;
    property reserved: Longint read Freserved write Freserved;
  end;
  
  tagDVTARGETDEVICEWrapper = class(TatRecordWrapper)
  private
    FtdSize: Longint;
    FtdDriverNameOffset: Word;
    FtdDeviceNameOffset: Word;
    FtdPortNameOffset: Word;
    FtdExtDevmodeOffset: Word;
  public
    constructor Create(ARecord: tagDVTARGETDEVICE);
    function ObjToRec: tagDVTARGETDEVICE;
  published
    property tdSize: Longint read FtdSize write FtdSize;
    property tdDriverNameOffset: Word read FtdDriverNameOffset write FtdDriverNameOffset;
    property tdDeviceNameOffset: Word read FtdDeviceNameOffset write FtdDeviceNameOffset;
    property tdPortNameOffset: Word read FtdPortNameOffset write FtdPortNameOffset;
    property tdExtDevmodeOffset: Word read FtdExtDevmodeOffset write FtdExtDevmodeOffset;
  end;
  
  tagFORMATETCWrapper = class(TatRecordWrapper)
  private
    FcfFormat: TClipFormat;
    FdwAspect: Longint;
    Flindex: Longint;
    Ftymed: Longint;
  public
    constructor Create(ARecord: tagFORMATETC);
    function ObjToRec: tagFORMATETC;
  published
    property cfFormat: TClipFormat read FcfFormat write FcfFormat;
    property dwAspect: Longint read FdwAspect write FdwAspect;
    property lindex: Longint read Flindex write Flindex;
    property tymed: Longint read Ftymed write Ftymed;
  end;
  
  tagSTATDATAWrapper = class(TatRecordWrapper)
  private
    Fadvf: Longint;
    FadvSink: IAdviseSink;
    FdwConnection: Longint;
  public
    constructor Create(ARecord: tagSTATDATA);
    function ObjToRec: tagSTATDATA;
  published
    property advf: Longint read Fadvf write Fadvf;
    property advSink: IAdviseSink read FadvSink write FadvSink;
    property dwConnection: Longint read FdwConnection write FdwConnection;
  end;
  
  tagRemSTGMEDIUMWrapper = class(TatRecordWrapper)
  private
    Ftymed: Longint;
    FdwHandleType: Longint;
    FpData: Longint;
    FpUnkForRelease: Longint;
    FcbData: Longint;
  public
    constructor Create(ARecord: tagRemSTGMEDIUM);
    function ObjToRec: tagRemSTGMEDIUM;
  published
    property tymed: Longint read Ftymed write Ftymed;
    property dwHandleType: Longint read FdwHandleType write FdwHandleType;
    property pData: Longint read FpData write FpData;
    property pUnkForRelease: Longint read FpUnkForRelease write FpUnkForRelease;
    property cbData: Longint read FcbData write FcbData;
  end;
  
  tagSTGMEDIUMWrapper = class(TatRecordWrapper)
  private
    Ftymed: Longint;
    FhBitmap: HBitmap;
    FunkForRelease: IUnknown;
    FhMetaFilePict: THandle;
    FhEnhMetaFile: THandle;
    FhGlobal: HGlobal;
    Fstm: IStream;
    Fstg: IStorage;
  public
    constructor Create(ARecord: tagSTGMEDIUM);
    function ObjToRec: tagSTGMEDIUM;
  published
    property tymed: Longint read Ftymed write Ftymed;
    property hBitmap: HBitmap read FhBitmap write FhBitmap;
    property unkForRelease: IUnknown read FunkForRelease write FunkForRelease;
    property hMetaFilePict: THandle read FhMetaFilePict write FhMetaFilePict;
    property hEnhMetaFile: THandle read FhEnhMetaFile write FhEnhMetaFile;
    property hGlobal: HGlobal read FhGlobal write FhGlobal;
    property stm: IStream read Fstm write Fstm;
    property stg: IStorage read Fstg write Fstg;
  end;
  
  tagINTERFACEINFOWrapper = class(TatRecordWrapper)
  private
    Funk: IUnknown;
    FwMethod: Word;
  public
    constructor Create(ARecord: tagINTERFACEINFO);
    function ObjToRec: tagINTERFACEINFO;
  published
    property unk: IUnknown read Funk write Funk;
    property wMethod: Word read FwMethod write FwMethod;
  end;
  
  tagRPCOLEMESSAGEWrapper = class(TatRecordWrapper)
  private
    FdataRepresentation: TRpcOleDataRep;
    FcbBuffer: Longint;
    FiMethod: Longint;
    FrpcFlags: Longint;
  public
    constructor Create(ARecord: tagRPCOLEMESSAGE);
    function ObjToRec: tagRPCOLEMESSAGE;
  published
    property dataRepresentation: TRpcOleDataRep read FdataRepresentation write FdataRepresentation;
    property cbBuffer: Longint read FcbBuffer write FcbBuffer;
    property iMethod: Longint read FiMethod write FiMethod;
    property rpcFlags: Longint read FrpcFlags write FrpcFlags;
  end;
  
  tagBLOBWrapper = class(TatRecordWrapper)
  private
    FcbSize: Longint;
  public
    constructor Create(ARecord: tagBLOB);
    function ObjToRec: tagBLOB;
  published
    property cbSize: Longint read FcbSize write FcbSize;
  end;
  
  tagCLIPDATAWrapper = class(TatRecordWrapper)
  private
    FcbSize: Longint;
    FulClipFmt: Longint;
  public
    constructor Create(ARecord: tagCLIPDATA);
    function ObjToRec: tagCLIPDATA;
  published
    property cbSize: Longint read FcbSize write FcbSize;
    property ulClipFmt: Longint read FulClipFmt write FulClipFmt;
  end;
  
  tagSAFEARRAYBOUNDWrapper = class(TatRecordWrapper)
  private
    FcElements: Longint;
    FlLbound: Longint;
  public
    constructor Create(ARecord: tagSAFEARRAYBOUND);
    function ObjToRec: tagSAFEARRAYBOUND;
  published
    property cElements: Longint read FcElements write FcElements;
    property lLbound: Longint read FlLbound write FlLbound;
  end;
  
  tagSAFEARRAYWrapper = class(TatRecordWrapper)
  private
    FcDims: Word;
    FfFeatures: Word;
    FcbElements: Longint;
    FcLocks: Longint;
  public
    constructor Create(ARecord: tagSAFEARRAY);
    function ObjToRec: tagSAFEARRAY;
  published
    property cDims: Word read FcDims write FcDims;
    property fFeatures: Word read FfFeatures write FfFeatures;
    property cbElements: Longint read FcbElements write FcbElements;
    property cLocks: Longint read FcLocks write FcLocks;
  end;
  
  tagVARIANTWrapper = class(TatRecordWrapper)
  private
    Fvt: TVarType;
    FwReserved1: Word;
    FwReserved2: Word;
    FwReserved3: Word;
    FbVal: Byte;
    FiVal: Smallint;
    FlVal: Longint;
    FfltVal: Single;
    FdblVal: Double;
    Fvbool: TOleBool;
    Fscode: HResult;
    FcyVal: TCurrency;
    Fdate: TOleDate;
    FunkVal: IUnknown;
    FdispVal: IDispatch;
  public
    constructor Create(ARecord: tagVARIANT);
    function ObjToRec: tagVARIANT;
  published
    property vt: TVarType read Fvt write Fvt;
    property wReserved1: Word read FwReserved1 write FwReserved1;
    property wReserved2: Word read FwReserved2 write FwReserved2;
    property wReserved3: Word read FwReserved3 write FwReserved3;
    property bVal: Byte read FbVal write FbVal;
    property iVal: Smallint read FiVal write FiVal;
    property lVal: Longint read FlVal write FlVal;
    property fltVal: Single read FfltVal write FfltVal;
    property dblVal: Double read FdblVal write FdblVal;
    property vbool: TOleBool read Fvbool write Fvbool;
    property scode: HResult read Fscode write Fscode;
    property cyVal: TCurrency read FcyVal write FcyVal;
    property date: TOleDate read Fdate write Fdate;
    property unkVal: IUnknown read FunkVal write FunkVal;
    property dispVal: IDispatch read FdispVal write FdispVal;
  end;
  
  tagTYPEDESCWrapper = class(TatRecordWrapper)
  private
    Fvt: TVarType;
    Fhreftype: HRefType;
  public
    constructor Create(ARecord: tagTYPEDESC);
    function ObjToRec: tagTYPEDESC;
  published
    property vt: TVarType read Fvt write Fvt;
    property hreftype: HRefType read Fhreftype write Fhreftype;
  end;
  
  tagARRAYDESCWrapper = class(TatRecordWrapper)
  private
    FcDims: Word;
  public
    constructor Create(ARecord: tagARRAYDESC);
    function ObjToRec: tagARRAYDESC;
  published
    property cDims: Word read FcDims write FcDims;
  end;
  
  tagIDLDESCWrapper = class(TatRecordWrapper)
  private
    FdwReserved: Longint;
    FwIDLFlags: Word;
  public
    constructor Create(ARecord: tagIDLDESC);
    function ObjToRec: tagIDLDESC;
  published
    property dwReserved: Longint read FdwReserved write FdwReserved;
    property wIDLFlags: Word read FwIDLFlags write FwIDLFlags;
  end;
  
  tagELEMDESCWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagELEMDESC);
    function ObjToRec: tagELEMDESC;
  published
  end;
  
  tagTYPEATTRWrapper = class(TatRecordWrapper)
  private
    Flcid: TLCID;
    FdwReserved: Longint;
    FmemidConstructor: TMemberID;
    FmemidDestructor: TMemberID;
    FcbSizeInstance: Longint;
    Ftypekind: TTypeKind;
    FcFuncs: Word;
    FcVars: Word;
    FcImplTypes: Word;
    FcbSizeVft: Word;
    FcbAlignment: Word;
    FwTypeFlags: Word;
    FwMajorVerNum: Word;
    FwMinorVerNum: Word;
  public
    constructor Create(ARecord: tagTYPEATTR);
    function ObjToRec: tagTYPEATTR;
  published
    property lcid: TLCID read Flcid write Flcid;
    property dwReserved: Longint read FdwReserved write FdwReserved;
    property memidConstructor: TMemberID read FmemidConstructor write FmemidConstructor;
    property memidDestructor: TMemberID read FmemidDestructor write FmemidDestructor;
    property cbSizeInstance: Longint read FcbSizeInstance write FcbSizeInstance;
    property typekind: TTypeKind read Ftypekind write Ftypekind;
    property cFuncs: Word read FcFuncs write FcFuncs;
    property cVars: Word read FcVars write FcVars;
    property cImplTypes: Word read FcImplTypes write FcImplTypes;
    property cbSizeVft: Word read FcbSizeVft write FcbSizeVft;
    property cbAlignment: Word read FcbAlignment write FcbAlignment;
    property wTypeFlags: Word read FwTypeFlags write FwTypeFlags;
    property wMajorVerNum: Word read FwMajorVerNum write FwMajorVerNum;
    property wMinorVerNum: Word read FwMinorVerNum write FwMinorVerNum;
  end;
  
  tagDISPPARAMSWrapper = class(TatRecordWrapper)
  private
    FcArgs: Longint;
    FcNamedArgs: Longint;
  public
    constructor Create(ARecord: tagDISPPARAMS);
    function ObjToRec: tagDISPPARAMS;
  published
    property cArgs: Longint read FcArgs write FcArgs;
    property cNamedArgs: Longint read FcNamedArgs write FcNamedArgs;
  end;
  
  tagEXCEPINFOWrapper = class(TatRecordWrapper)
  private
    FwCode: Word;
    FwReserved: Word;
    FdwHelpContext: Longint;
    Fscode: HResult;
  public
    constructor Create(ARecord: tagEXCEPINFO);
    function ObjToRec: tagEXCEPINFO;
  published
    property wCode: Word read FwCode write FwCode;
    property wReserved: Word read FwReserved write FwReserved;
    property dwHelpContext: Longint read FdwHelpContext write FdwHelpContext;
    property scode: HResult read Fscode write Fscode;
  end;
  
  tagFUNCDESCWrapper = class(TatRecordWrapper)
  private
    Fmemid: TMemberID;
    Ffunckind: TFuncKind;
    Finvkind: TInvokeKind;
    Fcallconv: TCallConv;
    FcParams: Smallint;
    FcParamsOpt: Smallint;
    FoVft: Smallint;
    FcScodes: Smallint;
    FwFuncFlags: Word;
  public
    constructor Create(ARecord: tagFUNCDESC);
    function ObjToRec: tagFUNCDESC;
  published
    property memid: TMemberID read Fmemid write Fmemid;
    property funckind: TFuncKind read Ffunckind write Ffunckind;
    property invkind: TInvokeKind read Finvkind write Finvkind;
    property callconv: TCallConv read Fcallconv write Fcallconv;
    property cParams: Smallint read FcParams write FcParams;
    property cParamsOpt: Smallint read FcParamsOpt write FcParamsOpt;
    property oVft: Smallint read FoVft write FoVft;
    property cScodes: Smallint read FcScodes write FcScodes;
    property wFuncFlags: Word read FwFuncFlags write FwFuncFlags;
  end;
  
  tagVARDESCWrapper = class(TatRecordWrapper)
  private
    Fmemid: TMemberID;
    FoInst: Longint;
    FwVarFlags: Word;
    Fvarkind: TVarKind;
  public
    constructor Create(ARecord: tagVARDESC);
    function ObjToRec: tagVARDESC;
  published
    property memid: TMemberID read Fmemid write Fmemid;
    property oInst: Longint read FoInst write FoInst;
    property wVarFlags: Word read FwVarFlags write FwVarFlags;
    property varkind: TVarKind read Fvarkind write Fvarkind;
  end;
  
  tagBINDPTRWrapper = class(TatRecordWrapper)
  private
    Flptcomp: ITypeComp;
  public
    constructor Create(ARecord: tagBINDPTR);
    function ObjToRec: tagBINDPTR;
  published
    property lptcomp: ITypeComp read Flptcomp write Flptcomp;
  end;
  
  tagTLIBATTRWrapper = class(TatRecordWrapper)
  private
    Flcid: TLCID;
    Fsyskind: TSysKind;
    FwMajorVerNum: Word;
    FwMinorVerNum: Word;
    FwLibFlags: Word;
  public
    constructor Create(ARecord: tagTLIBATTR);
    function ObjToRec: tagTLIBATTR;
  published
    property lcid: TLCID read Flcid write Flcid;
    property syskind: TSysKind read Fsyskind write Fsyskind;
    property wMajorVerNum: Word read FwMajorVerNum write FwMajorVerNum;
    property wMinorVerNum: Word read FwMinorVerNum write FwMinorVerNum;
    property wLibFlags: Word read FwLibFlags write FwLibFlags;
  end;
  
  tagPARAMDATAWrapper = class(TatRecordWrapper)
  private
    Fvt: TVarType;
  public
    constructor Create(ARecord: tagPARAMDATA);
    function ObjToRec: tagPARAMDATA;
  published
    property vt: TVarType read Fvt write Fvt;
  end;
  
  tagMETHODDATAWrapper = class(TatRecordWrapper)
  private
    Fdispid: TDispID;
    FiMeth: Integer;
    Fcc: TCallConv;
    FcArgs: Integer;
    FwFlags: Word;
    FvtReturn: TVarType;
  public
    constructor Create(ARecord: tagMETHODDATA);
    function ObjToRec: tagMETHODDATA;
  published
    property dispid: TDispID read Fdispid write Fdispid;
    property iMeth: Integer read FiMeth write FiMeth;
    property cc: TCallConv read Fcc write Fcc;
    property cArgs: Integer read FcArgs write FcArgs;
    property wFlags: Word read FwFlags write FwFlags;
    property vtReturn: TVarType read FvtReturn write FvtReturn;
  end;
  
  tagINTERFACEDATAWrapper = class(TatRecordWrapper)
  private
    FcMembers: Integer;
  public
    constructor Create(ARecord: tagINTERFACEDATA);
    function ObjToRec: tagINTERFACEDATA;
  published
    property cMembers: Integer read FcMembers write FcMembers;
  end;
  
  tagOBJECTDESCRIPTORWrapper = class(TatRecordWrapper)
  private
    FcbSize: Longint;
    FdwDrawAspect: Longint;
    FdwStatus: Longint;
    FdwFullUserTypeName: Longint;
    FdwSrcOfCopy: Longint;
  public
    constructor Create(ARecord: tagOBJECTDESCRIPTOR);
    function ObjToRec: tagOBJECTDESCRIPTOR;
  published
    property cbSize: Longint read FcbSize write FcbSize;
    property dwDrawAspect: Longint read FdwDrawAspect write FdwDrawAspect;
    property dwStatus: Longint read FdwStatus write FdwStatus;
    property dwFullUserTypeName: Longint read FdwFullUserTypeName write FdwFullUserTypeName;
    property dwSrcOfCopy: Longint read FdwSrcOfCopy write FdwSrcOfCopy;
  end;
  
  tagOIFIWrapper = class(TatRecordWrapper)
  private
    Fcb: Integer;
    FfMDIApp: BOOL;
    FhwndFrame: HWND;
    Fhaccel: HAccel;
    FcAccelEntries: Integer;
  public
    constructor Create(ARecord: tagOIFI);
    function ObjToRec: tagOIFI;
  published
    property cb: Integer read Fcb write Fcb;
    property fMDIApp: BOOL read FfMDIApp write FfMDIApp;
    property hwndFrame: HWND read FhwndFrame write FhwndFrame;
    property haccel: HAccel read Fhaccel write Fhaccel;
    property cAccelEntries: Integer read FcAccelEntries write FcAccelEntries;
  end;
  
  tagOleMenuGroupWidthsWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagOleMenuGroupWidths);
    function ObjToRec: tagOleMenuGroupWidths;
  published
  end;
  
  tagOLEVERBWrapper = class(TatRecordWrapper)
  private
    FlVerb: Longint;
    FfuFlags: Longint;
    FgrfAttribs: Longint;
  public
    constructor Create(ARecord: tagOLEVERB);
    function ObjToRec: tagOLEVERB;
  published
    property lVerb: Longint read FlVerb write FlVerb;
    property fuFlags: Longint read FfuFlags write FfuFlags;
    property grfAttribs: Longint read FgrfAttribs write FgrfAttribs;
  end;
  

implementation

constructor TGUIDWrapper.Create(ARecord: TGUID);
begin
  inherited Create;
  FD1 := ARecord.D1;
  FD2 := ARecord.D2;
  FD3 := ARecord.D3;
end;

function TGUIDWrapper.ObjToRec: TGUID;
begin
  result.D1 := FD1;
  result.D2 := FD2;
  result.D3 := FD3;
end;

constructor _OBJECTIDWrapper.Create(ARecord: _OBJECTID);
begin
  inherited Create;
  FUniquifier := ARecord.Uniquifier;
end;

function _OBJECTIDWrapper.ObjToRec: _OBJECTID;
begin
  result.Uniquifier := FUniquifier;
end;

constructor tagBIND_OPTSWrapper.Create(ARecord: tagBIND_OPTS);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FgrfFlags := ARecord.grfFlags;
  FgrfMode := ARecord.grfMode;
  FdwTickCountDeadline := ARecord.dwTickCountDeadline;
end;

function tagBIND_OPTSWrapper.ObjToRec: tagBIND_OPTS;
begin
  result.cbStruct := FcbStruct;
  result.grfFlags := FgrfFlags;
  result.grfMode := FgrfMode;
  result.dwTickCountDeadline := FdwTickCountDeadline;
end;

constructor tagSTATSTGWrapper.Create(ARecord: tagSTATSTG);
begin
  inherited Create;
  FdwType := ARecord.dwType;
  FcbSize := ARecord.cbSize;
  FgrfMode := ARecord.grfMode;
  FgrfLocksSupported := ARecord.grfLocksSupported;
  FgrfStateBits := ARecord.grfStateBits;
  Freserved := ARecord.reserved;
end;

function tagSTATSTGWrapper.ObjToRec: tagSTATSTG;
begin
  result.dwType := FdwType;
  result.cbSize := FcbSize;
  result.grfMode := FgrfMode;
  result.grfLocksSupported := FgrfLocksSupported;
  result.grfStateBits := FgrfStateBits;
  result.reserved := Freserved;
end;

constructor tagDVTARGETDEVICEWrapper.Create(ARecord: tagDVTARGETDEVICE);
begin
  inherited Create;
  FtdSize := ARecord.tdSize;
  FtdDriverNameOffset := ARecord.tdDriverNameOffset;
  FtdDeviceNameOffset := ARecord.tdDeviceNameOffset;
  FtdPortNameOffset := ARecord.tdPortNameOffset;
  FtdExtDevmodeOffset := ARecord.tdExtDevmodeOffset;
end;

function tagDVTARGETDEVICEWrapper.ObjToRec: tagDVTARGETDEVICE;
begin
  result.tdSize := FtdSize;
  result.tdDriverNameOffset := FtdDriverNameOffset;
  result.tdDeviceNameOffset := FtdDeviceNameOffset;
  result.tdPortNameOffset := FtdPortNameOffset;
  result.tdExtDevmodeOffset := FtdExtDevmodeOffset;
end;

constructor tagFORMATETCWrapper.Create(ARecord: tagFORMATETC);
begin
  inherited Create;
  FcfFormat := ARecord.cfFormat;
  FdwAspect := ARecord.dwAspect;
  Flindex := ARecord.lindex;
  Ftymed := ARecord.tymed;
end;

function tagFORMATETCWrapper.ObjToRec: tagFORMATETC;
begin
  result.cfFormat := FcfFormat;
  result.dwAspect := FdwAspect;
  result.lindex := Flindex;
  result.tymed := Ftymed;
end;

constructor tagSTATDATAWrapper.Create(ARecord: tagSTATDATA);
begin
  inherited Create;
  Fadvf := ARecord.advf;
  FadvSink := ARecord.advSink;
  FdwConnection := ARecord.dwConnection;
end;

function tagSTATDATAWrapper.ObjToRec: tagSTATDATA;
begin
  result.advf := Fadvf;
  result.advSink := FadvSink;
  result.dwConnection := FdwConnection;
end;

constructor tagRemSTGMEDIUMWrapper.Create(ARecord: tagRemSTGMEDIUM);
begin
  inherited Create;
  Ftymed := ARecord.tymed;
  FdwHandleType := ARecord.dwHandleType;
  FpData := ARecord.pData;
  FpUnkForRelease := ARecord.pUnkForRelease;
  FcbData := ARecord.cbData;
end;

function tagRemSTGMEDIUMWrapper.ObjToRec: tagRemSTGMEDIUM;
begin
  result.tymed := Ftymed;
  result.dwHandleType := FdwHandleType;
  result.pData := FpData;
  result.pUnkForRelease := FpUnkForRelease;
  result.cbData := FcbData;
end;

constructor tagSTGMEDIUMWrapper.Create(ARecord: tagSTGMEDIUM);
begin
  inherited Create;
  Ftymed := ARecord.tymed;
  FhBitmap := ARecord.hBitmap;
  FunkForRelease := ARecord.unkForRelease;
  FhMetaFilePict := ARecord.hMetaFilePict;
  FhEnhMetaFile := ARecord.hEnhMetaFile;
  FhGlobal := ARecord.hGlobal;
  Fstm := ARecord.stm;
  Fstg := ARecord.stg;
end;

function tagSTGMEDIUMWrapper.ObjToRec: tagSTGMEDIUM;
begin
  result.tymed := Ftymed;
  result.hBitmap := FhBitmap;
  result.unkForRelease := FunkForRelease;
  result.hMetaFilePict := FhMetaFilePict;
  result.hEnhMetaFile := FhEnhMetaFile;
  result.hGlobal := FhGlobal;
  result.stm := Fstm;
  result.stg := Fstg;
end;

constructor tagINTERFACEINFOWrapper.Create(ARecord: tagINTERFACEINFO);
begin
  inherited Create;
  Funk := ARecord.unk;
  FwMethod := ARecord.wMethod;
end;

function tagINTERFACEINFOWrapper.ObjToRec: tagINTERFACEINFO;
begin
  result.unk := Funk;
  result.wMethod := FwMethod;
end;

constructor tagRPCOLEMESSAGEWrapper.Create(ARecord: tagRPCOLEMESSAGE);
begin
  inherited Create;
  FdataRepresentation := ARecord.dataRepresentation;
  FcbBuffer := ARecord.cbBuffer;
  FiMethod := ARecord.iMethod;
  FrpcFlags := ARecord.rpcFlags;
end;

function tagRPCOLEMESSAGEWrapper.ObjToRec: tagRPCOLEMESSAGE;
begin
  result.dataRepresentation := FdataRepresentation;
  result.cbBuffer := FcbBuffer;
  result.iMethod := FiMethod;
  result.rpcFlags := FrpcFlags;
end;

constructor tagBLOBWrapper.Create(ARecord: tagBLOB);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
end;

function tagBLOBWrapper.ObjToRec: tagBLOB;
begin
  result.cbSize := FcbSize;
end;

constructor tagCLIPDATAWrapper.Create(ARecord: tagCLIPDATA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FulClipFmt := ARecord.ulClipFmt;
end;

function tagCLIPDATAWrapper.ObjToRec: tagCLIPDATA;
begin
  result.cbSize := FcbSize;
  result.ulClipFmt := FulClipFmt;
end;

constructor tagSAFEARRAYBOUNDWrapper.Create(ARecord: tagSAFEARRAYBOUND);
begin
  inherited Create;
  FcElements := ARecord.cElements;
  FlLbound := ARecord.lLbound;
end;

function tagSAFEARRAYBOUNDWrapper.ObjToRec: tagSAFEARRAYBOUND;
begin
  result.cElements := FcElements;
  result.lLbound := FlLbound;
end;

constructor tagSAFEARRAYWrapper.Create(ARecord: tagSAFEARRAY);
begin
  inherited Create;
  FcDims := ARecord.cDims;
  FfFeatures := ARecord.fFeatures;
  FcbElements := ARecord.cbElements;
  FcLocks := ARecord.cLocks;
end;

function tagSAFEARRAYWrapper.ObjToRec: tagSAFEARRAY;
begin
  result.cDims := FcDims;
  result.fFeatures := FfFeatures;
  result.cbElements := FcbElements;
  result.cLocks := FcLocks;
end;

constructor tagVARIANTWrapper.Create(ARecord: tagVARIANT);
begin
  inherited Create;
  Fvt := ARecord.vt;
  FwReserved1 := ARecord.wReserved1;
  FwReserved2 := ARecord.wReserved2;
  FwReserved3 := ARecord.wReserved3;
  FbVal := ARecord.bVal;
  FiVal := ARecord.iVal;
  FlVal := ARecord.lVal;
  FfltVal := ARecord.fltVal;
  FdblVal := ARecord.dblVal;
  Fvbool := ARecord.vbool;
  Fscode := ARecord.scode;
  FcyVal := ARecord.cyVal;
  Fdate := ARecord.date;
  FunkVal := ARecord.unkVal;
  FdispVal := ARecord.dispVal;
end;

function tagVARIANTWrapper.ObjToRec: tagVARIANT;
begin
  result.vt := Fvt;
  result.wReserved1 := FwReserved1;
  result.wReserved2 := FwReserved2;
  result.wReserved3 := FwReserved3;
  result.bVal := FbVal;
  result.iVal := FiVal;
  result.lVal := FlVal;
  result.fltVal := FfltVal;
  result.dblVal := FdblVal;
  result.vbool := Fvbool;
  result.scode := Fscode;
  result.cyVal := FcyVal;
  result.date := Fdate;
  result.unkVal := FunkVal;
  result.dispVal := FdispVal;
end;

constructor tagTYPEDESCWrapper.Create(ARecord: tagTYPEDESC);
begin
  inherited Create;
  Fvt := ARecord.vt;
  Fhreftype := ARecord.hreftype;
end;

function tagTYPEDESCWrapper.ObjToRec: tagTYPEDESC;
begin
  result.vt := Fvt;
  result.hreftype := Fhreftype;
end;

constructor tagARRAYDESCWrapper.Create(ARecord: tagARRAYDESC);
begin
  inherited Create;
  FcDims := ARecord.cDims;
end;

function tagARRAYDESCWrapper.ObjToRec: tagARRAYDESC;
begin
  result.cDims := FcDims;
end;

constructor tagIDLDESCWrapper.Create(ARecord: tagIDLDESC);
begin
  inherited Create;
  FdwReserved := ARecord.dwReserved;
  FwIDLFlags := ARecord.wIDLFlags;
end;

function tagIDLDESCWrapper.ObjToRec: tagIDLDESC;
begin
  result.dwReserved := FdwReserved;
  result.wIDLFlags := FwIDLFlags;
end;

constructor tagELEMDESCWrapper.Create(ARecord: tagELEMDESC);
begin
  inherited Create;
end;

function tagELEMDESCWrapper.ObjToRec: tagELEMDESC;
begin
end;

constructor tagTYPEATTRWrapper.Create(ARecord: tagTYPEATTR);
begin
  inherited Create;
  Flcid := ARecord.lcid;
  FdwReserved := ARecord.dwReserved;
  FmemidConstructor := ARecord.memidConstructor;
  FmemidDestructor := ARecord.memidDestructor;
  FcbSizeInstance := ARecord.cbSizeInstance;
  Ftypekind := ARecord.typekind;
  FcFuncs := ARecord.cFuncs;
  FcVars := ARecord.cVars;
  FcImplTypes := ARecord.cImplTypes;
  FcbSizeVft := ARecord.cbSizeVft;
  FcbAlignment := ARecord.cbAlignment;
  FwTypeFlags := ARecord.wTypeFlags;
  FwMajorVerNum := ARecord.wMajorVerNum;
  FwMinorVerNum := ARecord.wMinorVerNum;
end;

function tagTYPEATTRWrapper.ObjToRec: tagTYPEATTR;
begin
  result.lcid := Flcid;
  result.dwReserved := FdwReserved;
  result.memidConstructor := FmemidConstructor;
  result.memidDestructor := FmemidDestructor;
  result.cbSizeInstance := FcbSizeInstance;
  result.typekind := Ftypekind;
  result.cFuncs := FcFuncs;
  result.cVars := FcVars;
  result.cImplTypes := FcImplTypes;
  result.cbSizeVft := FcbSizeVft;
  result.cbAlignment := FcbAlignment;
  result.wTypeFlags := FwTypeFlags;
  result.wMajorVerNum := FwMajorVerNum;
  result.wMinorVerNum := FwMinorVerNum;
end;

constructor tagDISPPARAMSWrapper.Create(ARecord: tagDISPPARAMS);
begin
  inherited Create;
  FcArgs := ARecord.cArgs;
  FcNamedArgs := ARecord.cNamedArgs;
end;

function tagDISPPARAMSWrapper.ObjToRec: tagDISPPARAMS;
begin
  result.cArgs := FcArgs;
  result.cNamedArgs := FcNamedArgs;
end;

constructor tagEXCEPINFOWrapper.Create(ARecord: tagEXCEPINFO);
begin
  inherited Create;
  FwCode := ARecord.wCode;
  FwReserved := ARecord.wReserved;
  FdwHelpContext := ARecord.dwHelpContext;
  Fscode := ARecord.scode;
end;

function tagEXCEPINFOWrapper.ObjToRec: tagEXCEPINFO;
begin
  result.wCode := FwCode;
  result.wReserved := FwReserved;
  result.dwHelpContext := FdwHelpContext;
  result.scode := Fscode;
end;

constructor tagFUNCDESCWrapper.Create(ARecord: tagFUNCDESC);
begin
  inherited Create;
  Fmemid := ARecord.memid;
  Ffunckind := ARecord.funckind;
  Finvkind := ARecord.invkind;
  Fcallconv := ARecord.callconv;
  FcParams := ARecord.cParams;
  FcParamsOpt := ARecord.cParamsOpt;
  FoVft := ARecord.oVft;
  FcScodes := ARecord.cScodes;
  FwFuncFlags := ARecord.wFuncFlags;
end;

function tagFUNCDESCWrapper.ObjToRec: tagFUNCDESC;
begin
  result.memid := Fmemid;
  result.funckind := Ffunckind;
  result.invkind := Finvkind;
  result.callconv := Fcallconv;
  result.cParams := FcParams;
  result.cParamsOpt := FcParamsOpt;
  result.oVft := FoVft;
  result.cScodes := FcScodes;
  result.wFuncFlags := FwFuncFlags;
end;

constructor tagVARDESCWrapper.Create(ARecord: tagVARDESC);
begin
  inherited Create;
  Fmemid := ARecord.memid;
  FoInst := ARecord.oInst;
  FwVarFlags := ARecord.wVarFlags;
  Fvarkind := ARecord.varkind;
end;

function tagVARDESCWrapper.ObjToRec: tagVARDESC;
begin
  result.memid := Fmemid;
  result.oInst := FoInst;
  result.wVarFlags := FwVarFlags;
  result.varkind := Fvarkind;
end;

constructor tagBINDPTRWrapper.Create(ARecord: tagBINDPTR);
begin
  inherited Create;
  Flptcomp := ARecord.lptcomp;
end;

function tagBINDPTRWrapper.ObjToRec: tagBINDPTR;
begin
  result.lptcomp := Flptcomp;
end;

constructor tagTLIBATTRWrapper.Create(ARecord: tagTLIBATTR);
begin
  inherited Create;
  Flcid := ARecord.lcid;
  Fsyskind := ARecord.syskind;
  FwMajorVerNum := ARecord.wMajorVerNum;
  FwMinorVerNum := ARecord.wMinorVerNum;
  FwLibFlags := ARecord.wLibFlags;
end;

function tagTLIBATTRWrapper.ObjToRec: tagTLIBATTR;
begin
  result.lcid := Flcid;
  result.syskind := Fsyskind;
  result.wMajorVerNum := FwMajorVerNum;
  result.wMinorVerNum := FwMinorVerNum;
  result.wLibFlags := FwLibFlags;
end;

constructor tagPARAMDATAWrapper.Create(ARecord: tagPARAMDATA);
begin
  inherited Create;
  Fvt := ARecord.vt;
end;

function tagPARAMDATAWrapper.ObjToRec: tagPARAMDATA;
begin
  result.vt := Fvt;
end;

constructor tagMETHODDATAWrapper.Create(ARecord: tagMETHODDATA);
begin
  inherited Create;
  Fdispid := ARecord.dispid;
  FiMeth := ARecord.iMeth;
  Fcc := ARecord.cc;
  FcArgs := ARecord.cArgs;
  FwFlags := ARecord.wFlags;
  FvtReturn := ARecord.vtReturn;
end;

function tagMETHODDATAWrapper.ObjToRec: tagMETHODDATA;
begin
  result.dispid := Fdispid;
  result.iMeth := FiMeth;
  result.cc := Fcc;
  result.cArgs := FcArgs;
  result.wFlags := FwFlags;
  result.vtReturn := FvtReturn;
end;

constructor tagINTERFACEDATAWrapper.Create(ARecord: tagINTERFACEDATA);
begin
  inherited Create;
  FcMembers := ARecord.cMembers;
end;

function tagINTERFACEDATAWrapper.ObjToRec: tagINTERFACEDATA;
begin
  result.cMembers := FcMembers;
end;

constructor tagOBJECTDESCRIPTORWrapper.Create(ARecord: tagOBJECTDESCRIPTOR);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwDrawAspect := ARecord.dwDrawAspect;
  FdwStatus := ARecord.dwStatus;
  FdwFullUserTypeName := ARecord.dwFullUserTypeName;
  FdwSrcOfCopy := ARecord.dwSrcOfCopy;
end;

function tagOBJECTDESCRIPTORWrapper.ObjToRec: tagOBJECTDESCRIPTOR;
begin
  result.cbSize := FcbSize;
  result.dwDrawAspect := FdwDrawAspect;
  result.dwStatus := FdwStatus;
  result.dwFullUserTypeName := FdwFullUserTypeName;
  result.dwSrcOfCopy := FdwSrcOfCopy;
end;

constructor tagOIFIWrapper.Create(ARecord: tagOIFI);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FfMDIApp := ARecord.fMDIApp;
  FhwndFrame := ARecord.hwndFrame;
  Fhaccel := ARecord.haccel;
  FcAccelEntries := ARecord.cAccelEntries;
end;

function tagOIFIWrapper.ObjToRec: tagOIFI;
begin
  result.cb := Fcb;
  result.fMDIApp := FfMDIApp;
  result.hwndFrame := FhwndFrame;
  result.haccel := Fhaccel;
  result.cAccelEntries := FcAccelEntries;
end;

constructor tagOleMenuGroupWidthsWrapper.Create(ARecord: tagOleMenuGroupWidths);
begin
  inherited Create;
end;

function tagOleMenuGroupWidthsWrapper.ObjToRec: tagOleMenuGroupWidths;
begin
end;

constructor tagOLEVERBWrapper.Create(ARecord: tagOLEVERB);
begin
  inherited Create;
  FlVerb := ARecord.lVerb;
  FfuFlags := ARecord.fuFlags;
  FgrfAttribs := ARecord.grfAttribs;
end;

function tagOLEVERBWrapper.ObjToRec: tagOLEVERB;
begin
  result.lVerb := FlVerb;
  result.fuFlags := FfuFlags;
  result.grfAttribs := FgrfAttribs;
end;



procedure TatOle2Library.__IUnknownQueryInterface(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(IUnknown(CurrentObject).QueryInterface(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__IUnknownAddRef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IUnknown(CurrentObject).AddRef);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IUnknownRelease(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IUnknown(CurrentObject).Release);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IClassFactoryCreateInstance(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(IClassFactory(CurrentObject).CreateInstance(IUnknown(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__IClassFactoryLockServer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IClassFactory(CurrentObject).LockServer(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IMarshalUnmarshalInterface(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(IMarshal(CurrentObject).UnmarshalInterface(IStream(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__IMarshalReleaseMarshalData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IMarshal(CurrentObject).ReleaseMarshalData(IStream(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IMarshalDisconnectObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IMarshal(CurrentObject).DisconnectObject(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IMallocHeapMinimize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IMalloc(CurrentObject).HeapMinimize;
  end;
end;

procedure TatOle2Library.__IMallocSpyPreAlloc(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IMallocSpy(CurrentObject).PreAlloc(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IMallocSpyPostFree(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IMallocSpy(CurrentObject).PostFree(GetInputArg(0));
  end;
end;

procedure TatOle2Library.__IMallocSpyPreHeapMinimize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IMallocSpy(CurrentObject).PreHeapMinimize;
  end;
end;

procedure TatOle2Library.__IMallocSpyPostHeapMinimize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IMallocSpy(CurrentObject).PostHeapMinimize;
  end;
end;

procedure TatOle2Library.__IExternalConnectionAddConnection(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IExternalConnection(CurrentObject).AddConnection(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IExternalConnectionReleaseConnection(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IExternalConnection(CurrentObject).ReleaseConnection(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IWeakRefChangeWeakCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IWeakRef(CurrentObject).ChangeWeakCount(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IWeakRefReleaseKeepAlive(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IWeakRef(CurrentObject).ReleaseKeepAlive(IUnknown(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumUnknownSkip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumUnknown(CurrentObject).Skip(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumUnknownReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumUnknown(CurrentObject).Reset);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumUnknownClone(AMachine: TatVirtualMachine);
  var
  Param0: IEnumUnknown;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumUnknown(Integer(GetInputArg(0)));
AResult := Integer(IEnumUnknown(CurrentObject).Clone(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IBindCtxRegisterObjectBound(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IBindCtx(CurrentObject).RegisterObjectBound(IUnknown(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IBindCtxRevokeObjectBound(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IBindCtx(CurrentObject).RevokeObjectBound(IUnknown(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IBindCtxReleaseBoundObjects(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IBindCtx(CurrentObject).ReleaseBoundObjects);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IBindCtxSetBindOptions(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TBindOpts;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagBIND_OPTSWrapper) then 
  Param0Rec := tagBIND_OPTSWrapper.Create(Param0);
Param0 := tagBIND_OPTSWrapper(Param0Rec).ObjToRec;
AResult := Integer(IBindCtx(CurrentObject).SetBindOptions(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagBIND_OPTSWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IBindCtxGetBindOptions(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TBindOpts;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagBIND_OPTSWrapper) then 
  Param0Rec := tagBIND_OPTSWrapper.Create(Param0);
Param0 := tagBIND_OPTSWrapper(Param0Rec).ObjToRec;
AResult := Integer(IBindCtx(CurrentObject).GetBindOptions(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagBIND_OPTSWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IBindCtxGetRunningObjectTable(AMachine: TatVirtualMachine);
  var
  Param0: IRunningObjectTable;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IRunningObjectTable(Integer(GetInputArg(0)));
AResult := Integer(IBindCtx(CurrentObject).GetRunningObjectTable(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IBindCtxRegisterObjectParam(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IBindCtx(CurrentObject).RegisterObjectParam(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),IUnknown(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IBindCtxGetObjectParam(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1: IUnknown;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IUnknown(Integer(GetInputArg(1)));
AResult := Integer(IBindCtx(CurrentObject).GetObjectParam(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IBindCtxEnumObjectParam(AMachine: TatVirtualMachine);
  var
  Param0: IEnumString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumString(Integer(GetInputArg(0)));
AResult := Integer(IBindCtx(CurrentObject).EnumObjectParam(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IBindCtxRevokeObjectParam(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IBindCtx(CurrentObject).RevokeObjectParam(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumMonikerSkip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumMoniker(CurrentObject).Skip(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumMonikerReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumMoniker(CurrentObject).Reset);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumMonikerClone(AMachine: TatVirtualMachine);
  var
  Param0: IEnumMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumMoniker(Integer(GetInputArg(0)));
AResult := Integer(IEnumMoniker(CurrentObject).Clone(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IRunnableObjectGetRunningClass(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TGUIDWrapper) then 
  Param0Rec := TGUIDWrapper.Create(Param0);
Param0 := TGUIDWrapper(Param0Rec).ObjToRec;
AResult := Integer(IRunnableObject(CurrentObject).GetRunningClass(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TGUIDWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IRunnableObjectRun(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IRunnableObject(CurrentObject).Run(IBindCtx(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IRunnableObjectIsRunning(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := IRunnableObject(CurrentObject).IsRunning;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IRunnableObjectLockRunning(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IRunnableObject(CurrentObject).LockRunning(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IRunnableObjectSetContainedObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IRunnableObject(CurrentObject).SetContainedObject(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IRunningObjectTableRegister(AMachine: TatVirtualMachine);
  var
  Param1: IUnknown;
  Param3: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IUnknown(Integer(GetInputArg(1)));
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(IRunningObjectTable(CurrentObject).Register(VarToInteger(GetInputArg(0)),Param1,IMoniker(Integer(GetInputArg(2))),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__IRunningObjectTableRevoke(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IRunningObjectTable(CurrentObject).Revoke(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IRunningObjectTableIsRunning(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IRunningObjectTable(CurrentObject).IsRunning(IMoniker(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IRunningObjectTableGetObject(AMachine: TatVirtualMachine);
  var
  Param1: IUnknown;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IUnknown(Integer(GetInputArg(1)));
AResult := Integer(IRunningObjectTable(CurrentObject).GetObject(IMoniker(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IRunningObjectTableNoteChangeTime(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFileTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _FILETIMEWrapper) then 
  Param1Rec := _FILETIMEWrapper.Create(Param1);
Param1 := _FILETIMEWrapper(Param1Rec).ObjToRec;
AResult := Integer(IRunningObjectTable(CurrentObject).NoteChangeTime(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_FILETIMEWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__IRunningObjectTableGetTimeOfLastChange(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFileTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _FILETIMEWrapper) then 
  Param1Rec := _FILETIMEWrapper.Create(Param1);
Param1 := _FILETIMEWrapper(Param1Rec).ObjToRec;
AResult := Integer(IRunningObjectTable(CurrentObject).GetTimeOfLastChange(IMoniker(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_FILETIMEWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__IRunningObjectTableEnumRunning(AMachine: TatVirtualMachine);
  var
  Param0: IEnumMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumMoniker(Integer(GetInputArg(0)));
AResult := Integer(IRunningObjectTable(CurrentObject).EnumRunning(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IPersistGetClassID(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TGUIDWrapper) then 
  Param0Rec := TGUIDWrapper.Create(Param0);
Param0 := TGUIDWrapper(Param0Rec).ObjToRec;
AResult := Integer(IPersist(CurrentObject).GetClassID(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TGUIDWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IPersistStreamIsDirty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistStream(CurrentObject).IsDirty);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IPersistStreamLoad(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistStream(CurrentObject).Load(IStream(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IPersistStreamSave(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistStream(CurrentObject).Save(IStream(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IPersistStreamGetSizeMax(AMachine: TatVirtualMachine);
  var
  Param0: Largeint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(IPersistStream(CurrentObject).GetSizeMax(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOle2Library.__IMonikerBindToObject(AMachine: TatVirtualMachine);
  var
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(IMoniker(CurrentObject).BindToObject(IBindCtx(Integer(GetInputArg(0))),IMoniker(Integer(GetInputArg(1))),TGUIDWrapper(integer(GetInputArg(2))).ObjToRec,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__IMonikerBindToStorage(AMachine: TatVirtualMachine);
  var
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(IMoniker(CurrentObject).BindToStorage(IBindCtx(Integer(GetInputArg(0))),IMoniker(Integer(GetInputArg(1))),TGUIDWrapper(integer(GetInputArg(2))).ObjToRec,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__IMonikerReduce(AMachine: TatVirtualMachine);
  var
  Param2: IMoniker;
  Param3: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := IMoniker(Integer(GetInputArg(2)));
Param3 := IMoniker(Integer(GetInputArg(3)));
AResult := Integer(IMoniker(CurrentObject).Reduce(IBindCtx(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__IMonikerComposeWith(AMachine: TatVirtualMachine);
  var
  Param2: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := IMoniker(Integer(GetInputArg(2)));
AResult := Integer(IMoniker(CurrentObject).ComposeWith(IMoniker(Integer(GetInputArg(0))),GetInputArg(1),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__IMonikerEnum(AMachine: TatVirtualMachine);
  var
  Param1: IEnumMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IEnumMoniker(Integer(GetInputArg(1)));
AResult := Integer(IMoniker(CurrentObject).Enum(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IMonikerIsEqual(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IMoniker(CurrentObject).IsEqual(IMoniker(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IMonikerHash(AMachine: TatVirtualMachine);
  var
  Param0: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IMoniker(CurrentObject).Hash(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IMonikerIsRunning(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IMoniker(CurrentObject).IsRunning(IBindCtx(Integer(GetInputArg(0))),IMoniker(Integer(GetInputArg(1))),IMoniker(Integer(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IMonikerGetTimeOfLastChange(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TFileTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _FILETIMEWrapper) then 
  Param2Rec := _FILETIMEWrapper.Create(Param2);
Param2 := _FILETIMEWrapper(Param2Rec).ObjToRec;
AResult := Integer(IMoniker(CurrentObject).GetTimeOfLastChange(IBindCtx(Integer(GetInputArg(0))),IMoniker(Integer(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_FILETIMEWrapper.Create(Param2)));
  end;
end;

procedure TatOle2Library.__IMonikerInverse(AMachine: TatVirtualMachine);
  var
  Param0: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IMoniker(Integer(GetInputArg(0)));
AResult := Integer(IMoniker(CurrentObject).Inverse(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IMonikerCommonPrefixWith(AMachine: TatVirtualMachine);
  var
  Param1: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IMoniker(Integer(GetInputArg(1)));
AResult := Integer(IMoniker(CurrentObject).CommonPrefixWith(IMoniker(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IMonikerRelativePathTo(AMachine: TatVirtualMachine);
  var
  Param1: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IMoniker(Integer(GetInputArg(1)));
AResult := Integer(IMoniker(CurrentObject).RelativePathTo(IMoniker(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IMonikerGetDisplayName(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param2: POleStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))));
AResult := Integer(IMoniker(CurrentObject).GetDisplayName(IBindCtx(Integer(GetInputArg(0))),IMoniker(Integer(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,WideCharToString(Param2));
  end;
end;

procedure TatOle2Library.__IMonikerParseDisplayName(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param3: Longint;
  Param4: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
Param4 := IMoniker(Integer(GetInputArg(4)));
AResult := Integer(IMoniker(CurrentObject).ParseDisplayName(IBindCtx(Integer(GetInputArg(0))),IMoniker(Integer(GetInputArg(1))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3,Param4));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatOle2Library.__IMonikerIsSystemMoniker(AMachine: TatVirtualMachine);
  var
  Param0: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IMoniker(CurrentObject).IsSystemMoniker(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IEnumStringSkip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumString(CurrentObject).Skip(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumStringReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumString(CurrentObject).Reset);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumStringClone(AMachine: TatVirtualMachine);
  var
  Param0: IEnumString;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumString(Integer(GetInputArg(0)));
AResult := Integer(IEnumString(CurrentObject).Clone(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IStreamSeek(AMachine: TatVirtualMachine);
  var
  Param2: Largeint;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(IStream(CurrentObject).Seek(GetInputArg(0),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__IStreamSetSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IStream(CurrentObject).SetSize(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IStreamCopyTo(AMachine: TatVirtualMachine);
  var
  Param2: Largeint;
  Param3: Largeint;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
Param3 := GetInputArg(3);
AResult := Integer(IStream(CurrentObject).CopyTo(IStream(Integer(GetInputArg(0))),GetInputArg(1),Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__IStreamCommit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IStream(CurrentObject).Commit(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IStreamRevert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IStream(CurrentObject).Revert);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IStreamLockRegion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IStream(CurrentObject).LockRegion(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IStreamUnlockRegion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IStream(CurrentObject).UnlockRegion(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IStreamStat(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TStatStg;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagSTATSTGWrapper) then 
  Param0Rec := tagSTATSTGWrapper.Create(Param0);
Param0 := tagSTATSTGWrapper(Param0Rec).ObjToRec;
AResult := Integer(IStream(CurrentObject).Stat(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagSTATSTGWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IStreamClone(AMachine: TatVirtualMachine);
  var
  Param0: IStream;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IStream(Integer(GetInputArg(0)));
AResult := Integer(IStream(CurrentObject).Clone(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IEnumStatStgSkip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumStatStg(CurrentObject).Skip(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumStatStgReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumStatStg(CurrentObject).Reset);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumStatStgClone(AMachine: TatVirtualMachine);
  var
  Param0: IEnumStatStg;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumStatStg(Integer(GetInputArg(0)));
AResult := Integer(IEnumStatStg(CurrentObject).Clone(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IStorageCreateStream(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param4: IStream;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := IStream(Integer(GetInputArg(4)));
AResult := Integer(IStorage(CurrentObject).CreateStream(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatOle2Library.__IStorageCreateStorage(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param4: IStorage;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := IStorage(Integer(GetInputArg(4)));
AResult := Integer(IStorage(CurrentObject).CreateStorage(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatOle2Library.__IStorageMoveElementTo(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IStorage(CurrentObject).MoveElementTo(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),IStorage(Integer(GetInputArg(1))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IStorageCommit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IStorage(CurrentObject).Commit(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IStorageRevert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IStorage(CurrentObject).Revert);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IStorageDestroyElement(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IStorage(CurrentObject).DestroyElement(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IStorageRenameElement(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IStorage(CurrentObject).RenameElement(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IStorageSetElementTimes(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IStorage(CurrentObject).SetElementTimes(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),_FILETIMEWrapper(integer(GetInputArg(1))).ObjToRec,_FILETIMEWrapper(integer(GetInputArg(2))).ObjToRec,_FILETIMEWrapper(integer(GetInputArg(3))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IStorageSetClass(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IStorage(CurrentObject).SetClass(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IStorageSetStateBits(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IStorage(CurrentObject).SetStateBits(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IStorageStat(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TStatStg;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagSTATSTGWrapper) then 
  Param0Rec := tagSTATSTGWrapper.Create(Param0);
Param0 := tagSTATSTGWrapper(Param0Rec).ObjToRec;
AResult := Integer(IStorage(CurrentObject).Stat(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagSTATSTGWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IPersistFileIsDirty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistFile(CurrentObject).IsDirty);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IPersistFileLoad(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistFile(CurrentObject).Load(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IPersistFileSave(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistFile(CurrentObject).Save(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IPersistFileSaveCompleted(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistFile(CurrentObject).SaveCompleted(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IPersistFileGetCurFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param0: POleStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))));
AResult := Integer(IPersistFile(CurrentObject).GetCurFile(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,WideCharToString(Param0));
  end;
end;

procedure TatOle2Library.__IPersistStorageIsDirty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistStorage(CurrentObject).IsDirty);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IPersistStorageInitNew(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistStorage(CurrentObject).InitNew(IStorage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IPersistStorageLoad(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistStorage(CurrentObject).Load(IStorage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IPersistStorageSave(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistStorage(CurrentObject).Save(IStorage(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IPersistStorageSaveCompleted(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistStorage(CurrentObject).SaveCompleted(IStorage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IPersistStorageHandsOffStorage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistStorage(CurrentObject).HandsOffStorage);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ILockBytesFlush(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ILockBytes(CurrentObject).Flush);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ILockBytesSetSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ILockBytes(CurrentObject).SetSize(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ILockBytesLockRegion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ILockBytes(CurrentObject).LockRegion(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ILockBytesUnlockRegion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ILockBytes(CurrentObject).UnlockRegion(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ILockBytesStat(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TStatStg;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagSTATSTGWrapper) then 
  Param0Rec := tagSTATSTGWrapper.Create(Param0);
Param0 := tagSTATSTGWrapper(Param0Rec).ObjToRec;
AResult := Integer(ILockBytes(CurrentObject).Stat(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagSTATSTGWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IEnumFormatEtcSkip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumFormatEtc(CurrentObject).Skip(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumFormatEtcReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumFormatEtc(CurrentObject).Reset);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumFormatEtcClone(AMachine: TatVirtualMachine);
  var
  Param0: IEnumFormatEtc;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumFormatEtc(Integer(GetInputArg(0)));
AResult := Integer(IEnumFormatEtc(CurrentObject).Clone(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IEnumStatDataSkip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumStatData(CurrentObject).Skip(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumStatDataReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumStatData(CurrentObject).Reset);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumStatDataClone(AMachine: TatVirtualMachine);
  var
  Param0: IEnumStatData;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumStatData(Integer(GetInputArg(0)));
AResult := Integer(IEnumStatData(CurrentObject).Clone(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IRootStorageSwitchToFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IRootStorage(CurrentObject).SwitchToFile(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IAdviseSinkOnDataChange(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFormatEtc;
  Param1Rec: TObject;
  Param1: TStgMedium;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFORMATETCWrapper) then 
  Param0Rec := tagFORMATETCWrapper.Create(Param0);
Param0 := tagFORMATETCWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagSTGMEDIUMWrapper) then 
  Param1Rec := tagSTGMEDIUMWrapper.Create(Param1);
Param1 := tagSTGMEDIUMWrapper(Param1Rec).ObjToRec;
    IAdviseSink(CurrentObject).OnDataChange(Param0,Param1);
    SetInputArg(0,integer(tagFORMATETCWrapper.Create(Param0)));
    SetInputArg(1,integer(tagSTGMEDIUMWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__IAdviseSinkOnViewChange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IAdviseSink(CurrentObject).OnViewChange(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatOle2Library.__IAdviseSinkOnRename(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IAdviseSink(CurrentObject).OnRename(IMoniker(Integer(GetInputArg(0))));
  end;
end;

procedure TatOle2Library.__IAdviseSinkOnSave(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IAdviseSink(CurrentObject).OnSave;
  end;
end;

procedure TatOle2Library.__IAdviseSinkOnClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IAdviseSink(CurrentObject).OnClose;
  end;
end;

procedure TatOle2Library.__IAdviseSink2OnLinkSrcChange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IAdviseSink2(CurrentObject).OnLinkSrcChange(IMoniker(Integer(GetInputArg(0))));
  end;
end;

procedure TatOle2Library.__IDataObjectGetData(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFormatEtc;
  Param1Rec: TObject;
  Param1: TStgMedium;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFORMATETCWrapper) then 
  Param0Rec := tagFORMATETCWrapper.Create(Param0);
Param0 := tagFORMATETCWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagSTGMEDIUMWrapper) then 
  Param1Rec := tagSTGMEDIUMWrapper.Create(Param1);
Param1 := tagSTGMEDIUMWrapper(Param1Rec).ObjToRec;
AResult := Integer(IDataObject(CurrentObject).GetData(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFORMATETCWrapper.Create(Param0)));
    SetInputArg(1,integer(tagSTGMEDIUMWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__IDataObjectGetDataHere(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFormatEtc;
  Param1Rec: TObject;
  Param1: TStgMedium;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFORMATETCWrapper) then 
  Param0Rec := tagFORMATETCWrapper.Create(Param0);
Param0 := tagFORMATETCWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagSTGMEDIUMWrapper) then 
  Param1Rec := tagSTGMEDIUMWrapper.Create(Param1);
Param1 := tagSTGMEDIUMWrapper(Param1Rec).ObjToRec;
AResult := Integer(IDataObject(CurrentObject).GetDataHere(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFORMATETCWrapper.Create(Param0)));
    SetInputArg(1,integer(tagSTGMEDIUMWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__IDataObjectQueryGetData(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFormatEtc;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFORMATETCWrapper) then 
  Param0Rec := tagFORMATETCWrapper.Create(Param0);
Param0 := tagFORMATETCWrapper(Param0Rec).ObjToRec;
AResult := Integer(IDataObject(CurrentObject).QueryGetData(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFORMATETCWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IDataObjectGetCanonicalFormatEtc(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFormatEtc;
  Param1Rec: TObject;
  Param1: TFormatEtc;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFORMATETCWrapper) then 
  Param0Rec := tagFORMATETCWrapper.Create(Param0);
Param0 := tagFORMATETCWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagFORMATETCWrapper) then 
  Param1Rec := tagFORMATETCWrapper.Create(Param1);
Param1 := tagFORMATETCWrapper(Param1Rec).ObjToRec;
AResult := Integer(IDataObject(CurrentObject).GetCanonicalFormatEtc(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFORMATETCWrapper.Create(Param0)));
    SetInputArg(1,integer(tagFORMATETCWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__IDataObjectSetData(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFormatEtc;
  Param1Rec: TObject;
  Param1: TStgMedium;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFORMATETCWrapper) then 
  Param0Rec := tagFORMATETCWrapper.Create(Param0);
Param0 := tagFORMATETCWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagSTGMEDIUMWrapper) then 
  Param1Rec := tagSTGMEDIUMWrapper.Create(Param1);
Param1 := tagSTGMEDIUMWrapper(Param1Rec).ObjToRec;
AResult := Integer(IDataObject(CurrentObject).SetData(Param0,Param1,GetInputArg(2)));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFORMATETCWrapper.Create(Param0)));
    SetInputArg(1,integer(tagSTGMEDIUMWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__IDataObjectEnumFormatEtc(AMachine: TatVirtualMachine);
  var
  Param1: IEnumFormatEtc;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IEnumFormatEtc(Integer(GetInputArg(1)));
AResult := Integer(IDataObject(CurrentObject).EnumFormatEtc(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IDataObjectDAdvise(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFormatEtc;
  Param3: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFORMATETCWrapper) then 
  Param0Rec := tagFORMATETCWrapper.Create(Param0);
Param0 := tagFORMATETCWrapper(Param0Rec).ObjToRec;
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(IDataObject(CurrentObject).DAdvise(Param0,VarToInteger(GetInputArg(1)),IAdviseSink(Integer(GetInputArg(2))),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFORMATETCWrapper.Create(Param0)));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__IDataObjectDUnadvise(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IDataObject(CurrentObject).DUnadvise(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IDataObjectEnumDAdvise(AMachine: TatVirtualMachine);
  var
  Param0: IEnumStatData;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumStatData(Integer(GetInputArg(0)));
AResult := Integer(IDataObject(CurrentObject).EnumDAdvise(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IDataAdviseHolderAdvise(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFormatEtc;
  Param4: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagFORMATETCWrapper) then 
  Param1Rec := tagFORMATETCWrapper.Create(Param1);
Param1 := tagFORMATETCWrapper(Param1Rec).ObjToRec;
Param4 := VarToInteger(GetInputArg(4));
AResult := Integer(IDataAdviseHolder(CurrentObject).Advise(IDataObject(Integer(GetInputArg(0))),Param1,VarToInteger(GetInputArg(2)),IAdviseSink(Integer(GetInputArg(3))),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagFORMATETCWrapper.Create(Param1)));
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatOle2Library.__IDataAdviseHolderUnadvise(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IDataAdviseHolder(CurrentObject).Unadvise(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IDataAdviseHolderEnumAdvise(AMachine: TatVirtualMachine);
  var
  Param0: IEnumStatData;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumStatData(Integer(GetInputArg(0)));
AResult := Integer(IDataAdviseHolder(CurrentObject).EnumAdvise(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IDataAdviseHolderSendOnDataChange(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IDataAdviseHolder(CurrentObject).SendOnDataChange(IDataObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IMessageFilterRetryRejectedCall(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IMessageFilter(CurrentObject).RetryRejectedCall(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IMessageFilterMessagePending(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IMessageFilter(CurrentObject).MessagePending(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IRpcChannelBufferGetBuffer(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRpcOleMessage;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagRPCOLEMESSAGEWrapper) then 
  Param0Rec := tagRPCOLEMESSAGEWrapper.Create(Param0);
Param0 := tagRPCOLEMESSAGEWrapper(Param0Rec).ObjToRec;
AResult := Integer(IRpcChannelBuffer(CurrentObject).GetBuffer(Param0,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagRPCOLEMESSAGEWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IRpcChannelBufferSendReceive(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRpcOleMessage;
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagRPCOLEMESSAGEWrapper) then 
  Param0Rec := tagRPCOLEMESSAGEWrapper.Create(Param0);
Param0 := tagRPCOLEMESSAGEWrapper(Param0Rec).ObjToRec;
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(IRpcChannelBuffer(CurrentObject).SendReceive(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagRPCOLEMESSAGEWrapper.Create(Param0)));
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IRpcChannelBufferFreeBuffer(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRpcOleMessage;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagRPCOLEMESSAGEWrapper) then 
  Param0Rec := tagRPCOLEMESSAGEWrapper.Create(Param0);
Param0 := tagRPCOLEMESSAGEWrapper(Param0Rec).ObjToRec;
AResult := Integer(IRpcChannelBuffer(CurrentObject).FreeBuffer(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagRPCOLEMESSAGEWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IRpcChannelBufferGetDestCtx(AMachine: TatVirtualMachine);
  var
  Param0: Longint;
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
Param1 := GetInputArg(1);
AResult := Integer(IRpcChannelBuffer(CurrentObject).GetDestCtx(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__IRpcChannelBufferIsConnected(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IRpcChannelBuffer(CurrentObject).IsConnected);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IRpcProxyBufferConnect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IRpcProxyBuffer(CurrentObject).Connect(IRpcChannelBuffer(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IRpcProxyBufferDisconnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IRpcProxyBuffer(CurrentObject).Disconnect;
  end;
end;

procedure TatOle2Library.__IRpcStubBufferConnect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IRpcStubBuffer(CurrentObject).Connect(IUnknown(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IRpcStubBufferDisconnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IRpcStubBuffer(CurrentObject).Disconnect;
  end;
end;

procedure TatOle2Library.__IRpcStubBufferInvoke(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRpcOleMessage;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagRPCOLEMESSAGEWrapper) then 
  Param0Rec := tagRPCOLEMESSAGEWrapper.Create(Param0);
Param0 := tagRPCOLEMESSAGEWrapper(Param0Rec).ObjToRec;
AResult := Integer(IRpcStubBuffer(CurrentObject).Invoke(Param0,IRpcChannelBuffer(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagRPCOLEMESSAGEWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IRpcStubBufferIsIIDSupported(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IRpcStubBuffer(CurrentObject).IsIIDSupported(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IRpcStubBufferCountRefs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IRpcStubBuffer(CurrentObject).CountRefs);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IRpcStubBufferDebugServerQueryInterface(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(IRpcStubBuffer(CurrentObject).DebugServerQueryInterface(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOle2Library.__IPSFactoryBufferCreateProxy(AMachine: TatVirtualMachine);
  var
  Param2: IRpcProxyBuffer;
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := IRpcProxyBuffer(Integer(GetInputArg(2)));
Param3 := GetInputArg(3);
AResult := Integer(IPSFactoryBuffer(CurrentObject).CreateProxy(IUnknown(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__IPSFactoryBufferCreateStub(AMachine: TatVirtualMachine);
  var
  Param2: IRpcStubBuffer;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := IRpcStubBuffer(Integer(GetInputArg(2)));
AResult := Integer(IPSFactoryBuffer(CurrentObject).CreateStub(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,IUnknown(Integer(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetGuid(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetGuid(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetTypeFlags(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetTypeFlags(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetDocString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetDocString(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetHelpContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetHelpContext(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetVersion(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoAddRefTypeInfo(AMachine: TatVirtualMachine);
  var
  Param1: HRefType;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(ICreateTypeInfo(CurrentObject).AddRefTypeInfo(ITypeInfo(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoAddFuncDesc(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFuncDesc;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagFUNCDESCWrapper) then 
  Param1Rec := tagFUNCDESCWrapper.Create(Param1);
Param1 := tagFUNCDESCWrapper(Param1Rec).ObjToRec;
AResult := Integer(ICreateTypeInfo(CurrentObject).AddFuncDesc(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagFUNCDESCWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoAddImplType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).AddImplType(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetImplTypeFlags(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetImplTypeFlags(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetAlignment(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetSchema(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetSchema(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoAddVarDesc(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TVarDesc;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagVARDESCWrapper) then 
  Param1Rec := tagVARDESCWrapper.Create(Param1);
Param1 := tagVARDESCWrapper(Param1Rec).ObjToRec;
AResult := Integer(ICreateTypeInfo(CurrentObject).AddVarDesc(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagVARDESCWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetVarName(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetVarName(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetTypeDescAlias(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TTypeDesc;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagTYPEDESCWrapper) then 
  Param0Rec := tagTYPEDESCWrapper.Create(Param0);
Param0 := tagTYPEDESCWrapper(Param0Rec).ObjToRec;
AResult := Integer(ICreateTypeInfo(CurrentObject).SetTypeDescAlias(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagTYPEDESCWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoDefineFuncAsDllEntry(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).DefineFuncAsDllEntry(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetFuncDocString(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetFuncDocString(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetVarDocString(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetVarDocString(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetFuncHelpContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetFuncHelpContext(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetVarHelpContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetVarHelpContext(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetMops(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).SetMops(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoSetTypeIdldesc(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TIDLDesc;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagIDLDESCWrapper) then 
  Param0Rec := tagIDLDESCWrapper.Create(Param0);
Param0 := tagIDLDESCWrapper(Param0Rec).ObjToRec;
AResult := Integer(ICreateTypeInfo(CurrentObject).SetTypeIdldesc(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagIDLDESCWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__ICreateTypeInfoLayOut(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeInfo(CurrentObject).LayOut);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeLibCreateTypeInfo(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2: ICreateTypeInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := ICreateTypeInfo(Integer(GetInputArg(2)));
AResult := Integer(ICreateTypeLib(CurrentObject).CreateTypeInfo(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__ICreateTypeLibSetName(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeLib(CurrentObject).SetName(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeLibSetVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeLib(CurrentObject).SetVersion(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeLibSetGuid(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeLib(CurrentObject).SetGuid(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeLibSetDocString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeLib(CurrentObject).SetDocString(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeLibSetHelpFileName(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeLib(CurrentObject).SetHelpFileName(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeLibSetHelpContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeLib(CurrentObject).SetHelpContext(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeLibSetLcid(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeLib(CurrentObject).SetLcid(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeLibSetLibFlags(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeLib(CurrentObject).SetLibFlags(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateTypeLibSaveAllChanges(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateTypeLib(CurrentObject).SaveAllChanges);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IDispatchGetTypeInfoCount(AMachine: TatVirtualMachine);
  var
  Param0: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IDispatch(CurrentObject).GetTypeInfoCount(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IDispatchGetTypeInfo(AMachine: TatVirtualMachine);
  var
  Param2: ITypeInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := ITypeInfo(Integer(GetInputArg(2)));
AResult := Integer(IDispatch(CurrentObject).GetTypeInfo(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__IEnumVariantNext(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  Param2: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(IEnumVariant(CurrentObject).Next(VarToInteger(GetInputArg(0)),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__IEnumVariantSkip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumVariant(CurrentObject).Skip(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumVariantReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumVariant(CurrentObject).Reset);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumVariantClone(AMachine: TatVirtualMachine);
  var
  Param0: IEnumVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumVariant(Integer(GetInputArg(0)));
AResult := Integer(IEnumVariant(CurrentObject).Clone(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__ITypeCompBind(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3: ITypeInfo;
  Param4: TDescKind;
  Param5Rec: TObject;
  Param5: TBindPtr;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := ITypeInfo(Integer(GetInputArg(3)));
Param4 := VarToInteger(GetInputArg(4));
Param5Rec := TObject(integer(GetInputArg(5)));
if not Assigned(Param5Rec) or not (Param5Rec is tagBINDPTRWrapper) then 
  Param5Rec := tagBINDPTRWrapper.Create(Param5);
Param5 := tagBINDPTRWrapper(Param5Rec).ObjToRec;
AResult := Integer(ITypeComp(CurrentObject).Bind(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,Param4,Param5));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
    SetInputArg(5,integer(tagBINDPTRWrapper.Create(Param5)));
  end;
end;

procedure TatOle2Library.__ITypeCompBindType(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2: ITypeInfo;
  Param3: ITypeComp;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := ITypeInfo(Integer(GetInputArg(2)));
Param3 := ITypeComp(Integer(GetInputArg(3)));
AResult := Integer(ITypeComp(CurrentObject).BindType(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__ITypeInfoGetTypeComp(AMachine: TatVirtualMachine);
  var
  Param0: ITypeComp;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := ITypeComp(Integer(GetInputArg(0)));
AResult := Integer(ITypeInfo(CurrentObject).GetTypeComp(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__ITypeInfoGetRefTypeOfImplType(AMachine: TatVirtualMachine);
  var
  Param1: HRefType;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(ITypeInfo(CurrentObject).GetRefTypeOfImplType(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__ITypeInfoGetImplTypeFlags(AMachine: TatVirtualMachine);
  var
  Param1: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(ITypeInfo(CurrentObject).GetImplTypeFlags(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__ITypeInfoGetDllEntry(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param2: TBStr;
  Param3Buf: array[0..127] of WideChar;
  Param3: TBStr;
  Param4: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))));
Param3 := StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3))));
Param4 := VarToInteger(GetInputArg(4));
AResult := Integer(ITypeInfo(CurrentObject).GetDllEntry(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2,Param3,Param4));
    ReturnOutputArg(AResult);
    SetInputArg(2,WideCharToString(Param2));
    SetInputArg(3,WideCharToString(Param3));
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatOle2Library.__ITypeInfoGetRefTypeInfo(AMachine: TatVirtualMachine);
  var
  Param1: ITypeInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := ITypeInfo(Integer(GetInputArg(1)));
AResult := Integer(ITypeInfo(CurrentObject).GetRefTypeInfo(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__ITypeInfoCreateInstance(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(ITypeInfo(CurrentObject).CreateInstance(IUnknown(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__ITypeInfoGetMops(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param1: TBStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(ITypeInfo(CurrentObject).GetMops(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatOle2Library.__ITypeInfoGetContainingTypeLib(AMachine: TatVirtualMachine);
  var
  Param0: ITypeLib;
  Param1: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := ITypeLib(Integer(GetInputArg(0)));
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(ITypeInfo(CurrentObject).GetContainingTypeLib(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__ITypeLibGetTypeInfoCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ITypeLib(CurrentObject).GetTypeInfoCount);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ITypeLibGetTypeInfo(AMachine: TatVirtualMachine);
  var
  Param1: ITypeInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := ITypeInfo(Integer(GetInputArg(1)));
AResult := Integer(ITypeLib(CurrentObject).GetTypeInfo(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__ITypeLibGetTypeInfoType(AMachine: TatVirtualMachine);
  var
  Param1: TTypeKind;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(ITypeLib(CurrentObject).GetTypeInfoType(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__ITypeLibGetTypeInfoOfGuid(AMachine: TatVirtualMachine);
  var
  Param1: ITypeInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := ITypeInfo(Integer(GetInputArg(1)));
AResult := Integer(ITypeLib(CurrentObject).GetTypeInfoOfGuid(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__ITypeLibGetTypeComp(AMachine: TatVirtualMachine);
  var
  Param0: ITypeComp;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := ITypeComp(Integer(GetInputArg(0)));
AResult := Integer(ITypeLib(CurrentObject).GetTypeComp(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__ITypeLibIsName(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2: BOOL;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(ITypeLib(CurrentObject).IsName(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__IErrorInfoGetGUID(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TGUID;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TGUIDWrapper) then 
  Param0Rec := TGUIDWrapper.Create(Param0);
Param0 := TGUIDWrapper(Param0Rec).ObjToRec;
AResult := Integer(IErrorInfo(CurrentObject).GetGUID(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TGUIDWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IErrorInfoGetSource(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param0: TBStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))));
AResult := Integer(IErrorInfo(CurrentObject).GetSource(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,WideCharToString(Param0));
  end;
end;

procedure TatOle2Library.__IErrorInfoGetDescription(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param0: TBStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))));
AResult := Integer(IErrorInfo(CurrentObject).GetDescription(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,WideCharToString(Param0));
  end;
end;

procedure TatOle2Library.__IErrorInfoGetHelpFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param0: TBStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))));
AResult := Integer(IErrorInfo(CurrentObject).GetHelpFile(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,WideCharToString(Param0));
  end;
end;

procedure TatOle2Library.__IErrorInfoGetHelpContext(AMachine: TatVirtualMachine);
  var
  Param0: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IErrorInfo(CurrentObject).GetHelpContext(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__ICreateErrorInfoSetGUID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateErrorInfo(CurrentObject).SetGUID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateErrorInfoSetSource(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateErrorInfo(CurrentObject).SetSource(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateErrorInfoSetDescription(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateErrorInfo(CurrentObject).SetDescription(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateErrorInfoSetHelpFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateErrorInfo(CurrentObject).SetHelpFile(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ICreateErrorInfoSetHelpContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ICreateErrorInfo(CurrentObject).SetHelpContext(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ISupportErrorInfoInterfaceSupportsErrorInfo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ISupportErrorInfo(CurrentObject).InterfaceSupportsErrorInfo(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleAdviseHolderAdvise(AMachine: TatVirtualMachine);
  var
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(IOleAdviseHolder(CurrentObject).Advise(IAdviseSink(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IOleAdviseHolderUnadvise(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleAdviseHolder(CurrentObject).Unadvise(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleAdviseHolderEnumAdvise(AMachine: TatVirtualMachine);
  var
  Param0: IEnumStatData;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumStatData(Integer(GetInputArg(0)));
AResult := Integer(IOleAdviseHolder(CurrentObject).EnumAdvise(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleAdviseHolderSendOnRename(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleAdviseHolder(CurrentObject).SendOnRename(IMoniker(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleAdviseHolderSendOnSave(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleAdviseHolder(CurrentObject).SendOnSave);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleAdviseHolderSendOnClose(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleAdviseHolder(CurrentObject).SendOnClose);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleCacheCache(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFormatEtc;
  Param2: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFORMATETCWrapper) then 
  Param0Rec := tagFORMATETCWrapper.Create(Param0);
Param0 := tagFORMATETCWrapper(Param0Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(IOleCache(CurrentObject).Cache(Param0,VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFORMATETCWrapper.Create(Param0)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__IOleCacheUncache(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleCache(CurrentObject).Uncache(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleCacheEnumCache(AMachine: TatVirtualMachine);
  var
  Param0: IEnumStatData;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumStatData(Integer(GetInputArg(0)));
AResult := Integer(IOleCache(CurrentObject).EnumCache(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleCacheInitCache(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleCache(CurrentObject).InitCache(IDataObject(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleCacheSetData(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFormatEtc;
  Param1Rec: TObject;
  Param1: TStgMedium;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFORMATETCWrapper) then 
  Param0Rec := tagFORMATETCWrapper.Create(Param0);
Param0 := tagFORMATETCWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagSTGMEDIUMWrapper) then 
  Param1Rec := tagSTGMEDIUMWrapper.Create(Param1);
Param1 := tagSTGMEDIUMWrapper(Param1Rec).ObjToRec;
AResult := Integer(IOleCache(CurrentObject).SetData(Param0,Param1,GetInputArg(2)));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFORMATETCWrapper.Create(Param0)));
    SetInputArg(1,integer(tagSTGMEDIUMWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__IOleCache2DiscardCache(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleCache2(CurrentObject).DiscardCache(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleCacheControlOnRun(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleCacheControl(CurrentObject).OnRun(IDataObject(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleCacheControlOnStop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleCacheControl(CurrentObject).OnStop);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IParseDisplayNameParseDisplayName(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2: Longint;
  Param3: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param3 := IMoniker(Integer(GetInputArg(3)));
AResult := Integer(IParseDisplayName(CurrentObject).ParseDisplayName(IBindCtx(Integer(GetInputArg(0))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__IOleContainerEnumObjects(AMachine: TatVirtualMachine);
  var
  Param1: IEnumUnknown;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IEnumUnknown(Integer(GetInputArg(1)));
AResult := Integer(IOleContainer(CurrentObject).EnumObjects(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IOleContainerLockContainer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleContainer(CurrentObject).LockContainer(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleClientSiteSaveObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleClientSite(CurrentObject).SaveObject);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleClientSiteGetMoniker(AMachine: TatVirtualMachine);
  var
  Param2: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := IMoniker(Integer(GetInputArg(2)));
AResult := Integer(IOleClientSite(CurrentObject).GetMoniker(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__IOleClientSiteGetContainer(AMachine: TatVirtualMachine);
  var
  Param0: IOleContainer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IOleContainer(Integer(GetInputArg(0)));
AResult := Integer(IOleClientSite(CurrentObject).GetContainer(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleClientSiteShowObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleClientSite(CurrentObject).ShowObject);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleClientSiteOnShowWindow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleClientSite(CurrentObject).OnShowWindow(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleClientSiteRequestNewObjectLayout(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleClientSite(CurrentObject).RequestNewObjectLayout);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleObjectSetClientSite(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleObject(CurrentObject).SetClientSite(IOleClientSite(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleObjectGetClientSite(AMachine: TatVirtualMachine);
  var
  Param0: IOleClientSite;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IOleClientSite(Integer(GetInputArg(0)));
AResult := Integer(IOleObject(CurrentObject).GetClientSite(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleObjectSetHostNames(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleObject(CurrentObject).SetHostNames(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleObjectClose(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleObject(CurrentObject).Close(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleObjectSetMoniker(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleObject(CurrentObject).SetMoniker(VarToInteger(GetInputArg(0)),IMoniker(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleObjectGetMoniker(AMachine: TatVirtualMachine);
  var
  Param2: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := IMoniker(Integer(GetInputArg(2)));
AResult := Integer(IOleObject(CurrentObject).GetMoniker(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__IOleObjectInitFromData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleObject(CurrentObject).InitFromData(IDataObject(Integer(GetInputArg(0))),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleObjectGetClipboardData(AMachine: TatVirtualMachine);
  var
  Param1: IDataObject;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IDataObject(Integer(GetInputArg(1)));
AResult := Integer(IOleObject(CurrentObject).GetClipboardData(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IOleObjectEnumVerbs(AMachine: TatVirtualMachine);
  var
  Param0: IEnumOleVerb;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumOleVerb(Integer(GetInputArg(0)));
AResult := Integer(IOleObject(CurrentObject).EnumVerbs(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleObjectUpdate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleObject(CurrentObject).Update);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleObjectIsUpToDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleObject(CurrentObject).IsUpToDate);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleObjectGetUserClassID(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TGUIDWrapper) then 
  Param0Rec := TGUIDWrapper.Create(Param0);
Param0 := TGUIDWrapper(Param0Rec).ObjToRec;
AResult := Integer(IOleObject(CurrentObject).GetUserClassID(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TGUIDWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IOleObjectGetUserType(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param1: POleStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(IOleObject(CurrentObject).GetUserType(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatOle2Library.__IOleObjectSetExtent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleObject(CurrentObject).SetExtent(VarToInteger(GetInputArg(0)),TPointWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleObjectGetExtent(AMachine: TatVirtualMachine);
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
AResult := Integer(IOleObject(CurrentObject).GetExtent(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TPointWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__IOleObjectAdvise(AMachine: TatVirtualMachine);
  var
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(IOleObject(CurrentObject).Advise(IAdviseSink(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IOleObjectUnadvise(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleObject(CurrentObject).Unadvise(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleObjectEnumAdvise(AMachine: TatVirtualMachine);
  var
  Param0: IEnumStatData;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumStatData(Integer(GetInputArg(0)));
AResult := Integer(IOleObject(CurrentObject).EnumAdvise(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleObjectGetMiscStatus(AMachine: TatVirtualMachine);
  var
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(IOleObject(CurrentObject).GetMiscStatus(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IOleObjectSetColorScheme(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TLogPalette;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagLOGPALETTEWrapper) then 
  Param0Rec := tagLOGPALETTEWrapper.Create(Param0);
Param0 := tagLOGPALETTEWrapper(Param0Rec).ObjToRec;
AResult := Integer(IOleObject(CurrentObject).SetColorScheme(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagLOGPALETTEWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IOleWindowGetWindow(AMachine: TatVirtualMachine);
  var
  Param0: HWnd;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IOleWindow(CurrentObject).GetWindow(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleWindowContextSensitiveHelp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleWindow(CurrentObject).ContextSensitiveHelp(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleLinkSetUpdateOptions(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleLink(CurrentObject).SetUpdateOptions(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleLinkGetUpdateOptions(AMachine: TatVirtualMachine);
  var
  Param0: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IOleLink(CurrentObject).GetUpdateOptions(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleLinkSetSourceMoniker(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleLink(CurrentObject).SetSourceMoniker(IMoniker(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleLinkGetSourceMoniker(AMachine: TatVirtualMachine);
  var
  Param0: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IMoniker(Integer(GetInputArg(0)));
AResult := Integer(IOleLink(CurrentObject).GetSourceMoniker(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleLinkSetSourceDisplayName(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleLink(CurrentObject).SetSourceDisplayName(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleLinkGetSourceDisplayName(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param0: POleStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))));
AResult := Integer(IOleLink(CurrentObject).GetSourceDisplayName(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,WideCharToString(Param0));
  end;
end;

procedure TatOle2Library.__IOleLinkBindToSource(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleLink(CurrentObject).BindToSource(VarToInteger(GetInputArg(0)),IBindCtx(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleLinkBindIfRunning(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleLink(CurrentObject).BindIfRunning);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleLinkGetBoundSource(AMachine: TatVirtualMachine);
  var
  Param0: IUnknown;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IUnknown(Integer(GetInputArg(0)));
AResult := Integer(IOleLink(CurrentObject).GetBoundSource(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleLinkUnbindSource(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleLink(CurrentObject).UnbindSource);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleLinkUpdate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleLink(CurrentObject).Update(IBindCtx(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleItemContainerGetObject(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param4: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := GetInputArg(4);
AResult := Integer(IOleItemContainer(CurrentObject).GetObject(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),IBindCtx(Integer(GetInputArg(2))),TGUIDWrapper(integer(GetInputArg(3))).ObjToRec,Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Param4);
  end;
end;

procedure TatOle2Library.__IOleItemContainerGetObjectStorage(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(IOleItemContainer(CurrentObject).GetObjectStorage(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),IBindCtx(Integer(GetInputArg(1))),TGUIDWrapper(integer(GetInputArg(2))).ObjToRec,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__IOleItemContainerIsRunning(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleItemContainer(CurrentObject).IsRunning(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceUIWindowGetBorder(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRect;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TRectWrapper) then 
  Param0Rec := TRectWrapper.Create(Param0);
Param0 := TRectWrapper(Param0Rec).ObjToRec;
AResult := Integer(IOleInPlaceUIWindow(CurrentObject).GetBorder(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TRectWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IOleInPlaceUIWindowRequestBorderSpace(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceUIWindow(CurrentObject).RequestBorderSpace(TRectWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceUIWindowSetActiveObject(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceUIWindow(CurrentObject).SetActiveObject(IOleInPlaceActiveObject(Integer(GetInputArg(0))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceActiveObjectTranslateAccelerator(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TMsg;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagMSGWrapper) then 
  Param0Rec := tagMSGWrapper.Create(Param0);
Param0 := tagMSGWrapper(Param0Rec).ObjToRec;
AResult := Integer(IOleInPlaceActiveObject(CurrentObject).TranslateAccelerator(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagMSGWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IOleInPlaceActiveObjectOnFrameWindowActivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceActiveObject(CurrentObject).OnFrameWindowActivate(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceActiveObjectOnDocWindowActivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceActiveObject(CurrentObject).OnDocWindowActivate(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceActiveObjectResizeBorder(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceActiveObject(CurrentObject).ResizeBorder(TRectWrapper(integer(GetInputArg(0))).ObjToRec,IOleInPlaceUIWindow(Integer(GetInputArg(1))),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceActiveObjectEnableModeless(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceActiveObject(CurrentObject).EnableModeless(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceFrameInsertMenus(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TOleMenuGroupWidths;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagOleMenuGroupWidthsWrapper) then 
  Param1Rec := tagOleMenuGroupWidthsWrapper.Create(Param1);
Param1 := tagOleMenuGroupWidthsWrapper(Param1Rec).ObjToRec;
AResult := Integer(IOleInPlaceFrame(CurrentObject).InsertMenus(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagOleMenuGroupWidthsWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__IOleInPlaceFrameSetMenu(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceFrame(CurrentObject).SetMenu(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceFrameRemoveMenus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceFrame(CurrentObject).RemoveMenus(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceFrameSetStatusText(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceFrame(CurrentObject).SetStatusText(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceFrameEnableModeless(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceFrame(CurrentObject).EnableModeless(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceFrameTranslateAccelerator(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TMsg;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagMSGWrapper) then 
  Param0Rec := tagMSGWrapper.Create(Param0);
Param0 := tagMSGWrapper(Param0Rec).ObjToRec;
AResult := Integer(IOleInPlaceFrame(CurrentObject).TranslateAccelerator(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagMSGWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IOleInPlaceObjectInPlaceDeactivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceObject(CurrentObject).InPlaceDeactivate);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceObjectUIDeactivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceObject(CurrentObject).UIDeactivate);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceObjectSetObjectRects(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceObject(CurrentObject).SetObjectRects(TRectWrapper(integer(GetInputArg(0))).ObjToRec,TRectWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceObjectReactivateAndUndo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceObject(CurrentObject).ReactivateAndUndo);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceSiteCanInPlaceActivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceSite(CurrentObject).CanInPlaceActivate);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceSiteOnInPlaceActivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceSite(CurrentObject).OnInPlaceActivate);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceSiteOnUIActivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceSite(CurrentObject).OnUIActivate);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceSiteGetWindowContext(AMachine: TatVirtualMachine);
  var
  Param0: IOleInPlaceFrame;
  Param1: IOleInPlaceUIWindow;
  Param2Rec: TObject;
  Param2: TRect;
  Param3Rec: TObject;
  Param3: TRect;
  Param4Rec: TObject;
  Param4: TOleInPlaceFrameInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IOleInPlaceFrame(Integer(GetInputArg(0)));
Param1 := IOleInPlaceUIWindow(Integer(GetInputArg(1)));
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TRectWrapper) then 
  Param2Rec := TRectWrapper.Create(Param2);
Param2 := TRectWrapper(Param2Rec).ObjToRec;
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is TRectWrapper) then 
  Param3Rec := TRectWrapper.Create(Param3);
Param3 := TRectWrapper(Param3Rec).ObjToRec;
Param4Rec := TObject(integer(GetInputArg(4)));
if not Assigned(Param4Rec) or not (Param4Rec is tagOIFIWrapper) then 
  Param4Rec := tagOIFIWrapper.Create(Param4);
Param4 := tagOIFIWrapper(Param4Rec).ObjToRec;
AResult := Integer(IOleInPlaceSite(CurrentObject).GetWindowContext(Param0,Param1,Param2,Param3,Param4));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,integer(TRectWrapper.Create(Param2)));
    SetInputArg(3,integer(TRectWrapper.Create(Param3)));
    SetInputArg(4,integer(tagOIFIWrapper.Create(Param4)));
  end;
end;

procedure TatOle2Library.__IOleInPlaceSiteScroll(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceSite(CurrentObject).Scroll(TPointWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceSiteOnUIDeactivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceSite(CurrentObject).OnUIDeactivate(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceSiteOnInPlaceDeactivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceSite(CurrentObject).OnInPlaceDeactivate);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceSiteDiscardUndoState(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceSite(CurrentObject).DiscardUndoState);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceSiteDeactivateAndUndo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceSite(CurrentObject).DeactivateAndUndo);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleInPlaceSiteOnPosRectChange(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleInPlaceSite(CurrentObject).OnPosRectChange(TRectWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IViewObjectUnfreeze(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IViewObject(CurrentObject).Unfreeze(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IViewObjectSetAdvise(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IViewObject(CurrentObject).SetAdvise(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),IAdviseSink(Integer(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IDropSourceQueryContinueDrag(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IDropSource(CurrentObject).QueryContinueDrag(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IDropSourceGiveFeedback(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IDropSource(CurrentObject).GiveFeedback(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IDropTargetDragEnter(AMachine: TatVirtualMachine);
  var
  Param3: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(IDropTarget(CurrentObject).DragEnter(IDataObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),TPointWrapper(integer(GetInputArg(2))).ObjToRec,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__IDropTargetDragOver(AMachine: TatVirtualMachine);
  var
  Param2: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(IDropTarget(CurrentObject).DragOver(VarToInteger(GetInputArg(0)),TPointWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__IDropTargetDragLeave(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IDropTarget(CurrentObject).DragLeave);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IDropTargetDrop(AMachine: TatVirtualMachine);
  var
  Param3: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(IDropTarget(CurrentObject).Drop(IDataObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),TPointWrapper(integer(GetInputArg(2))).ObjToRec,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__IEnumOleVerbSkip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumOleVerb(CurrentObject).Skip(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumOleVerbReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumOleVerb(CurrentObject).Reset);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumOleVerbClone(AMachine: TatVirtualMachine);
  var
  Param0: IEnumOleVerb;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumOleVerb(Integer(GetInputArg(0)));
AResult := Integer(IEnumOleVerb(CurrentObject).Clone(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleDocumentViewSetInPlaceSite(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleDocumentView(CurrentObject).SetInPlaceSite(IOleInPlaceSite(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleDocumentViewGetInPlaceSite(AMachine: TatVirtualMachine);
  var
  Param0: IOleInPlaceSite;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IOleInPlaceSite(Integer(GetInputArg(0)));
AResult := Integer(IOleDocumentView(CurrentObject).GetInPlaceSite(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleDocumentViewGetDocument(AMachine: TatVirtualMachine);
  var
  Param0: IUnknown;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IUnknown(Integer(GetInputArg(0)));
AResult := Integer(IOleDocumentView(CurrentObject).GetDocument(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleDocumentViewSetRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleDocumentView(CurrentObject).SetRect(TRectWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleDocumentViewGetRect(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRECT;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TRectWrapper) then 
  Param0Rec := TRectWrapper.Create(Param0);
Param0 := TRectWrapper(Param0Rec).ObjToRec;
AResult := Integer(IOleDocumentView(CurrentObject).GetRect(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TRectWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__IOleDocumentViewSetRectComplex(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  Param1: Variant;
  Param2: Variant;
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
Param2 := GetInputArg(2);
Param3 := GetInputArg(3);
AResult := Integer(IOleDocumentView(CurrentObject).SetRectComplex(Param0,Param1,Param2,Param3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleDocumentViewShow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleDocumentView(CurrentObject).Show(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleDocumentViewUIActivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleDocumentView(CurrentObject).UIActivate(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleDocumentViewOpen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleDocumentView(CurrentObject).Open);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleDocumentViewCloseView(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleDocumentView(CurrentObject).CloseView(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleDocumentViewSaveViewState(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleDocumentView(CurrentObject).SaveViewState(IStream(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleDocumentViewApplyViewState(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleDocumentView(CurrentObject).ApplyViewState(IStream(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IOleDocumentViewClone(AMachine: TatVirtualMachine);
  var
  Param1: IOleDocumentView;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IOleDocumentView(Integer(GetInputArg(1)));
AResult := Integer(IOleDocumentView(CurrentObject).Clone(IOleInPlaceSite(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IEnumOleDocumentViewsNext(AMachine: TatVirtualMachine);
  var
  Param1: IOleDocumentView;
  Param2: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IOleDocumentView(Integer(GetInputArg(1)));
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(IEnumOleDocumentViews(CurrentObject).Next(VarToInteger(GetInputArg(0)),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__IEnumOleDocumentViewsSkip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumOleDocumentViews(CurrentObject).Skip(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumOleDocumentViewsReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumOleDocumentViews(CurrentObject).Reset);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IEnumOleDocumentViewsClone(AMachine: TatVirtualMachine);
  var
  Param0: IEnumOleDocumentViews;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumOleDocumentViews(Integer(GetInputArg(0)));
AResult := Integer(IEnumOleDocumentViews(CurrentObject).Clone(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleDocumentCreateView(AMachine: TatVirtualMachine);
  var
  Param3: IOleDocumentView;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := IOleDocumentView(Integer(GetInputArg(3)));
AResult := Integer(IOleDocument(CurrentObject).CreateView(IOleInPlaceSite(Integer(GetInputArg(0))),IStream(Integer(GetInputArg(1))),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__IOleDocumentGetDocMiscStatus(AMachine: TatVirtualMachine);
  var
  Param0: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IOleDocument(CurrentObject).GetDocMiscStatus(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__IOleDocumentEnumViews(AMachine: TatVirtualMachine);
  var
  Param0: IEnumOleDocumentViews;
  Param1: IOleDocumentView;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumOleDocumentViews(Integer(GetInputArg(0)));
Param1 := IOleDocumentView(Integer(GetInputArg(1)));
AResult := Integer(IOleDocument(CurrentObject).EnumViews(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__IOleDocumentSiteActivateMe(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleDocumentSite(CurrentObject).ActivateMe(IOleDocumentView(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__Succeeded(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Ole2.Succeeded(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__Failed(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Ole2.Failed(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ResultCode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.ResultCode(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ResultFacility(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.ResultFacility(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ResultSeverity(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.ResultSeverity(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__MakeResult(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.MakeResult(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IsEqualGUID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Ole2.IsEqualGUID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IsEqualIID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Ole2.IsEqualIID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IsEqualCLSID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Ole2.IsEqualCLSID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CoBuildVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.CoBuildVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CoUninitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Ole2.CoUninitialize;
  end;
end;

procedure TatOle2Library.__CoGetMalloc(AMachine: TatVirtualMachine);
  var
  Param1: IMalloc;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IMalloc(Integer(GetInputArg(1)));
AResult := Integer(Ole2.CoGetMalloc(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__CoGetCurrentProcess(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.CoGetCurrentProcess);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CoRegisterMallocSpy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.CoRegisterMallocSpy(IMallocSpy(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CoRevokeMallocSpy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.CoRevokeMallocSpy);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CoRegisterClassObject(AMachine: TatVirtualMachine);
  var
  Param4: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := VarToInteger(GetInputArg(4));
AResult := Integer(Ole2.CoRegisterClassObject(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,IUnknown(Integer(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatOle2Library.__CoRevokeClassObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.CoRevokeClassObject(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CoUnmarshalInterface(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(Ole2.CoUnmarshalInterface(IStream(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__CoReleaseMarshalData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.CoReleaseMarshalData(IStream(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CoDisconnectObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.CoDisconnectObject(IUnknown(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CoLockObjectExternal(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.CoLockObjectExternal(IUnknown(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CoIsHandlerConnected(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Ole2.CoIsHandlerConnected(IUnknown(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CoMarshalInterThreadInterfaceInStream(AMachine: TatVirtualMachine);
  var
  Param2: IStream;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := IStream(Integer(GetInputArg(2)));
AResult := Integer(Ole2.CoMarshalInterThreadInterfaceInStream(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,IUnknown(Integer(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__CoGetInterfaceAndReleaseStream(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(Ole2.CoGetInterfaceAndReleaseStream(IStream(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__CoCreateFreeThreadedMarshaler(AMachine: TatVirtualMachine);
  var
  Param1: IUnknown;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IUnknown(Integer(GetInputArg(1)));
AResult := Integer(Ole2.CoCreateFreeThreadedMarshaler(IUnknown(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__CoLoadLibrary(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.CoLoadLibrary(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CoFreeLibrary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Ole2.CoFreeLibrary(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOle2Library.__CoFreeAllLibraries(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Ole2.CoFreeAllLibraries;
  end;
end;

procedure TatOle2Library.__CoFreeUnusedLibraries(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Ole2.CoFreeUnusedLibraries;
  end;
end;

procedure TatOle2Library.__CoCreateInstance(AMachine: TatVirtualMachine);
  var
  Param4: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := GetInputArg(4);
AResult := Integer(Ole2.CoCreateInstance(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,IUnknown(Integer(GetInputArg(1))),VarToInteger(GetInputArg(2)),TGUIDWrapper(integer(GetInputArg(3))).ObjToRec,Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Param4);
  end;
end;

procedure TatOle2Library.__StringFromCLSID(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param1: POleStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(Ole2.StringFromCLSID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatOle2Library.__CLSIDFromString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(Ole2.CLSIDFromString(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__StringFromIID(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param1: POleStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(Ole2.StringFromIID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatOle2Library.__IIDFromString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TIID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(Ole2.IIDFromString(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__CoIsOle1Class(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Ole2.CoIsOle1Class(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ProgIDFromCLSID(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param1: POleStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(Ole2.ProgIDFromCLSID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatOle2Library.__CLSIDFromProgID(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(Ole2.CLSIDFromProgID(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__StringFromGUID2(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.StringFromGUID2(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CoCreateGuid(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TGUID;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TGUIDWrapper) then 
  Param0Rec := TGUIDWrapper.Create(Param0);
Param0 := TGUIDWrapper(Param0Rec).ObjToRec;
AResult := Integer(Ole2.CoCreateGuid(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TGUIDWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__CoFileTimeToDosDateTime(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFileTime;
  Param1: Word;
  Param2: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _FILETIMEWrapper) then 
  Param0Rec := _FILETIMEWrapper.Create(Param0);
Param0 := _FILETIMEWrapper(Param0Rec).ObjToRec;
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := Ole2.CoFileTimeToDosDateTime(Param0,Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_FILETIMEWrapper.Create(Param0)));
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__CoDosDateTimeToFileTime(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TFileTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _FILETIMEWrapper) then 
  Param2Rec := _FILETIMEWrapper.Create(Param2);
Param2 := _FILETIMEWrapper(Param2Rec).ObjToRec;
AResult := Ole2.CoDosDateTimeToFileTime(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_FILETIMEWrapper.Create(Param2)));
  end;
end;

procedure TatOle2Library.__CoFileTimeNow(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFileTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _FILETIMEWrapper) then 
  Param0Rec := _FILETIMEWrapper.Create(Param0);
Param0 := _FILETIMEWrapper(Param0Rec).ObjToRec;
AResult := Integer(Ole2.CoFileTimeNow(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_FILETIMEWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__CoRegisterMessageFilter(AMachine: TatVirtualMachine);
  var
  Param1: IMessageFilter;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IMessageFilter(Integer(GetInputArg(1)));
AResult := Integer(Ole2.CoRegisterMessageFilter(IMessageFilter(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__CoGetTreatAsClass(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(Ole2.CoGetTreatAsClass(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__CoTreatAsClass(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.CoTreatAsClass(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CreateDataAdviseHolder(AMachine: TatVirtualMachine);
  var
  Param0: IDataAdviseHolder;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IDataAdviseHolder(Integer(GetInputArg(0)));
AResult := Integer(Ole2.CreateDataAdviseHolder(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__CreateDataCache(AMachine: TatVirtualMachine);
  var
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(Ole2.CreateDataCache(IUnknown(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,TGUIDWrapper(integer(GetInputArg(2))).ObjToRec,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__StgCreateDocfile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3: IStorage;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := IStorage(Integer(GetInputArg(3)));
AResult := Integer(Ole2.StgCreateDocfile(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__StgCreateDocfileOnILockBytes(AMachine: TatVirtualMachine);
  var
  Param3: IStorage;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := IStorage(Integer(GetInputArg(3)));
AResult := Integer(Ole2.StgCreateDocfileOnILockBytes(ILockBytes(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__StgIsStorageFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.StgIsStorageFile(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__StgIsStorageILockBytes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.StgIsStorageILockBytes(ILockBytes(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__StgSetTimes(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.StgSetTimes(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),_FILETIMEWrapper(integer(GetInputArg(1))).ObjToRec,_FILETIMEWrapper(integer(GetInputArg(2))).ObjToRec,_FILETIMEWrapper(integer(GetInputArg(3))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__BindMoniker(AMachine: TatVirtualMachine);
  var
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(Ole2.BindMoniker(IMoniker(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),TGUIDWrapper(integer(GetInputArg(2))).ObjToRec,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__MkParseDisplayName(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2: Longint;
  Param3: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param3 := IMoniker(Integer(GetInputArg(3)));
AResult := Integer(Ole2.MkParseDisplayName(IBindCtx(Integer(GetInputArg(0))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__MonikerRelativePathTo(AMachine: TatVirtualMachine);
  var
  Param2: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := IMoniker(Integer(GetInputArg(2)));
AResult := Integer(Ole2.MonikerRelativePathTo(IMoniker(Integer(GetInputArg(0))),IMoniker(Integer(GetInputArg(1))),Param2,GetInputArg(3)));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__MonikerCommonPrefixWith(AMachine: TatVirtualMachine);
  var
  Param2: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := IMoniker(Integer(GetInputArg(2)));
AResult := Integer(Ole2.MonikerCommonPrefixWith(IMoniker(Integer(GetInputArg(0))),IMoniker(Integer(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__CreateBindCtx(AMachine: TatVirtualMachine);
  var
  Param1: IBindCtx;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IBindCtx(Integer(GetInputArg(1)));
AResult := Integer(Ole2.CreateBindCtx(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__CreateGenericComposite(AMachine: TatVirtualMachine);
  var
  Param2: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := IMoniker(Integer(GetInputArg(2)));
AResult := Integer(Ole2.CreateGenericComposite(IMoniker(Integer(GetInputArg(0))),IMoniker(Integer(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__GetClassFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(Ole2.GetClassFile(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__CreateFileMoniker(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IMoniker(Integer(GetInputArg(1)));
AResult := Integer(Ole2.CreateFileMoniker(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__CreateItemMoniker(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := IMoniker(Integer(GetInputArg(2)));
AResult := Integer(Ole2.CreateItemMoniker(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__CreateAntiMoniker(AMachine: TatVirtualMachine);
  var
  Param0: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IMoniker(Integer(GetInputArg(0)));
AResult := Integer(Ole2.CreateAntiMoniker(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__CreatePointerMoniker(AMachine: TatVirtualMachine);
  var
  Param1: IMoniker;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IMoniker(Integer(GetInputArg(1)));
AResult := Integer(Ole2.CreatePointerMoniker(IUnknown(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__GetRunningObjectTable(AMachine: TatVirtualMachine);
  var
  Param1: IRunningObjectTable;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IRunningObjectTable(Integer(GetInputArg(1)));
AResult := Integer(Ole2.GetRunningObjectTable(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__SysAllocString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(Ole2.SysAllocString(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__SysReAllocString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param0: TBStr;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))));
AResult := Integer(Ole2.SysReAllocString(Param0,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
    SetInputArg(0,WideCharToString(Param0));
  end;
end;

procedure TatOle2Library.__SysAllocStringLen(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(Ole2.SysAllocStringLen(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__SysReAllocStringLen(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param0: TBStr;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))));
AResult := Integer(Ole2.SysReAllocStringLen(Param0,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(0,WideCharToString(Param0));
  end;
end;

procedure TatOle2Library.__SysFreeString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    Ole2.SysFreeString(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatOle2Library.__SysStringLen(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.SysStringLen(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__SysStringByteLen(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.SysStringByteLen(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__SysAllocStringByteLen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(Ole2.SysAllocStringByteLen(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__DosDateTimeToVariantTime(AMachine: TatVirtualMachine);
  var
  Param2: TOleDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(Ole2.DosDateTimeToVariantTime(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__VariantTimeToDosDateTime(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Ole2.VariantTimeToDosDateTime(GetInputArg(0),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__VariantInit(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    Ole2.VariantInit(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOle2Library.__VariantClear(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(Ole2.VariantClear(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOle2Library.__VariantCopy(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(Ole2.VariantCopy(Param0,GetInputArg(1)));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOle2Library.__VariantCopyInd(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(Ole2.VariantCopyInd(Param0,GetInputArg(1)));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOle2Library.__VariantChangeType(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(Ole2.VariantChangeType(Param0,GetInputArg(1),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOle2Library.__VariantChangeTypeEx(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(Ole2.VariantChangeTypeEx(Param0,GetInputArg(1),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOle2Library.__VarUI1FromI2(AMachine: TatVirtualMachine);
  var
  Param1: Byte;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarUI1FromI2(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarUI1FromI4(AMachine: TatVirtualMachine);
  var
  Param1: Byte;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarUI1FromI4(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarUI1FromR4(AMachine: TatVirtualMachine);
  var
  Param1: Byte;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarUI1FromR4(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarUI1FromR8(AMachine: TatVirtualMachine);
  var
  Param1: Byte;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarUI1FromR8(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarUI1FromCy(AMachine: TatVirtualMachine);
  var
  Param1: Byte;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarUI1FromCy(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarUI1FromDate(AMachine: TatVirtualMachine);
  var
  Param1: Byte;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarUI1FromDate(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarUI1FromStr(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3: Byte;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(Ole2.VarUI1FromStr(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__VarUI1FromDisp(AMachine: TatVirtualMachine);
  var
  Param2: Byte;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Ole2.VarUI1FromDisp(IDispatch(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__VarUI1FromBool(AMachine: TatVirtualMachine);
  var
  Param1: Byte;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarUI1FromBool(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI2FromUI1(AMachine: TatVirtualMachine);
  var
  Param1: Smallint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI2FromUI1(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI2FromI4(AMachine: TatVirtualMachine);
  var
  Param1: Smallint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI2FromI4(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI2FromR4(AMachine: TatVirtualMachine);
  var
  Param1: Smallint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI2FromR4(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI2FromR8(AMachine: TatVirtualMachine);
  var
  Param1: Smallint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI2FromR8(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI2FromCy(AMachine: TatVirtualMachine);
  var
  Param1: Smallint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI2FromCy(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI2FromDate(AMachine: TatVirtualMachine);
  var
  Param1: Smallint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI2FromDate(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI2FromStr(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3: Smallint;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(Ole2.VarI2FromStr(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__VarI2FromDisp(AMachine: TatVirtualMachine);
  var
  Param2: Smallint;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Ole2.VarI2FromDisp(IDispatch(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__VarI2FromBool(AMachine: TatVirtualMachine);
  var
  Param1: Smallint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI2FromBool(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI4FromUI1(AMachine: TatVirtualMachine);
  var
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI4FromUI1(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI4FromI2(AMachine: TatVirtualMachine);
  var
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI4FromI2(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI4FromR4(AMachine: TatVirtualMachine);
  var
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI4FromR4(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI4FromR8(AMachine: TatVirtualMachine);
  var
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI4FromR8(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI4FromCy(AMachine: TatVirtualMachine);
  var
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI4FromCy(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI4FromDate(AMachine: TatVirtualMachine);
  var
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI4FromDate(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarI4FromStr(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(Ole2.VarI4FromStr(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__VarI4FromDisp(AMachine: TatVirtualMachine);
  var
  Param2: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Ole2.VarI4FromDisp(IDispatch(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__VarI4FromBool(AMachine: TatVirtualMachine);
  var
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.VarI4FromBool(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__VarR4FromUI1(AMachine: TatVirtualMachine);
  var
  Param1: Single;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR4FromUI1(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarR4FromI2(AMachine: TatVirtualMachine);
  var
  Param1: Single;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR4FromI2(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarR4FromI4(AMachine: TatVirtualMachine);
  var
  Param1: Single;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR4FromI4(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarR4FromR8(AMachine: TatVirtualMachine);
  var
  Param1: Single;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR4FromR8(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarR4FromCy(AMachine: TatVirtualMachine);
  var
  Param1: Single;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR4FromCy(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarR4FromDate(AMachine: TatVirtualMachine);
  var
  Param1: Single;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR4FromDate(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarR4FromStr(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3: Single;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(Ole2.VarR4FromStr(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__VarR4FromDisp(AMachine: TatVirtualMachine);
  var
  Param2: Single;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(Ole2.VarR4FromDisp(IDispatch(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__VarR4FromBool(AMachine: TatVirtualMachine);
  var
  Param1: Single;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR4FromBool(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarR8FromUI1(AMachine: TatVirtualMachine);
  var
  Param1: Double;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR8FromUI1(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarR8FromI2(AMachine: TatVirtualMachine);
  var
  Param1: Double;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR8FromI2(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarR8FromI4(AMachine: TatVirtualMachine);
  var
  Param1: Double;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR8FromI4(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarR8FromR4(AMachine: TatVirtualMachine);
  var
  Param1: Double;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR8FromR4(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarR8FromCy(AMachine: TatVirtualMachine);
  var
  Param1: Double;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR8FromCy(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarR8FromDate(AMachine: TatVirtualMachine);
  var
  Param1: Double;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR8FromDate(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarR8FromStr(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3: Double;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(Ole2.VarR8FromStr(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__VarR8FromDisp(AMachine: TatVirtualMachine);
  var
  Param2: Double;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(Ole2.VarR8FromDisp(IDispatch(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__VarR8FromBool(AMachine: TatVirtualMachine);
  var
  Param1: Double;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarR8FromBool(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarDateFromUI1(AMachine: TatVirtualMachine);
  var
  Param1: TOleDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarDateFromUI1(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarDateFromI2(AMachine: TatVirtualMachine);
  var
  Param1: TOleDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarDateFromI2(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarDateFromI4(AMachine: TatVirtualMachine);
  var
  Param1: TOleDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarDateFromI4(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarDateFromR4(AMachine: TatVirtualMachine);
  var
  Param1: TOleDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarDateFromR4(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarDateFromR8(AMachine: TatVirtualMachine);
  var
  Param1: TOleDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarDateFromR8(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarDateFromCy(AMachine: TatVirtualMachine);
  var
  Param1: TOleDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarDateFromCy(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarDateFromStr(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3: TOleDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(Ole2.VarDateFromStr(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__VarDateFromDisp(AMachine: TatVirtualMachine);
  var
  Param2: TOleDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(Ole2.VarDateFromDisp(IDispatch(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__VarDateFromBool(AMachine: TatVirtualMachine);
  var
  Param1: TOleDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarDateFromBool(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarCyFromUI1(AMachine: TatVirtualMachine);
  var
  Param1: TCurrency;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarCyFromUI1(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarCyFromI2(AMachine: TatVirtualMachine);
  var
  Param1: TCurrency;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarCyFromI2(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarCyFromI4(AMachine: TatVirtualMachine);
  var
  Param1: TCurrency;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarCyFromI4(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarCyFromR4(AMachine: TatVirtualMachine);
  var
  Param1: TCurrency;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarCyFromR4(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarCyFromR8(AMachine: TatVirtualMachine);
  var
  Param1: TCurrency;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarCyFromR8(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarCyFromDate(AMachine: TatVirtualMachine);
  var
  Param1: TCurrency;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarCyFromDate(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarCyFromStr(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3: TCurrency;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(Ole2.VarCyFromStr(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__VarCyFromDisp(AMachine: TatVirtualMachine);
  var
  Param2: TCurrency;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(Ole2.VarCyFromDisp(IDispatch(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__VarCyFromBool(AMachine: TatVirtualMachine);
  var
  Param1: TCurrency;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarCyFromBool(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarBoolFromUI1(AMachine: TatVirtualMachine);
  var
  Param1: TOleBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarBoolFromUI1(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarBoolFromI2(AMachine: TatVirtualMachine);
  var
  Param1: TOleBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarBoolFromI2(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarBoolFromI4(AMachine: TatVirtualMachine);
  var
  Param1: TOleBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarBoolFromI4(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarBoolFromR4(AMachine: TatVirtualMachine);
  var
  Param1: TOleBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarBoolFromR4(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarBoolFromR8(AMachine: TatVirtualMachine);
  var
  Param1: TOleBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarBoolFromR8(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarBoolFromDate(AMachine: TatVirtualMachine);
  var
  Param1: TOleBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarBoolFromDate(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarBoolFromCy(AMachine: TatVirtualMachine);
  var
  Param1: TOleBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Ole2.VarBoolFromCy(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatOle2Library.__VarBoolFromStr(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param3: TOleBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(Ole2.VarBoolFromStr(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__VarBoolFromDisp(AMachine: TatVirtualMachine);
  var
  Param2: TOleBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(Ole2.VarBoolFromDisp(IDispatch(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__LHashValOfNameSys(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.LHashValOfNameSys(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__LHashValOfNameSysA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.LHashValOfNameSysA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__LHashValOfName(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.LHashValOfName(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__WHashValOfLHashVal(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.WHashValOfLHashVal(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__IsHashValCompatible(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Ole2.IsHashValCompatible(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__LoadTypeLib(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1: ITypeLib;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := ITypeLib(Integer(GetInputArg(1)));
AResult := Integer(Ole2.LoadTypeLib(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__LoadRegTypeLib(AMachine: TatVirtualMachine);
  var
  Param4: ITypeLib;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := ITypeLib(Integer(GetInputArg(4)));
AResult := Integer(Ole2.LoadRegTypeLib(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatOle2Library.__QueryPathOfRegTypeLib(AMachine: TatVirtualMachine);
  var
  Param4Buf: array[0..127] of WideChar;
  Param4: TBStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4))));
AResult := Integer(Ole2.QueryPathOfRegTypeLib(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,WideCharToString(Param4));
  end;
end;

procedure TatOle2Library.__RegisterTypeLib(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.RegisterTypeLib(ITypeLib(Integer(GetInputArg(0))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__CreateTypeLib(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2: ICreateTypeLib;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := ICreateTypeLib(Integer(GetInputArg(2)));
AResult := Integer(Ole2.CreateTypeLib(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__DispGetParam(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TDispParams;
  Param3: Variant;
  Param4: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagDISPPARAMSWrapper) then 
  Param0Rec := tagDISPPARAMSWrapper.Create(Param0);
Param0 := tagDISPPARAMSWrapper(Param0Rec).ObjToRec;
Param3 := GetInputArg(3);
Param4 := VarToInteger(GetInputArg(4));
AResult := Integer(Ole2.DispGetParam(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,Param4));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagDISPPARAMSWrapper.Create(Param0)));
    SetInputArg(3,Param3);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatOle2Library.__DispGetIDsOfNames(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param3 := GetInputArg(3);
AResult := Integer(Ole2.DispGetIDsOfNames(ITypeInfo(Integer(GetInputArg(0))),Param1,VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__CreateDispTypeInfo(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TInterfaceData;
  Param2: ITypeInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagINTERFACEDATAWrapper) then 
  Param0Rec := tagINTERFACEDATAWrapper.Create(Param0);
Param0 := tagINTERFACEDATAWrapper(Param0Rec).ObjToRec;
Param2 := ITypeInfo(Integer(GetInputArg(2)));
AResult := Integer(Ole2.CreateDispTypeInfo(Param0,VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagINTERFACEDATAWrapper.Create(Param0)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__RegisterActiveObject(AMachine: TatVirtualMachine);
  var
  Param3: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(Ole2.RegisterActiveObject(IUnknown(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__SetErrorInfo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.SetErrorInfo(VarToInteger(GetInputArg(0)),IErrorInfo(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__GetErrorInfo(AMachine: TatVirtualMachine);
  var
  Param1: IErrorInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IErrorInfo(Integer(GetInputArg(1)));
AResult := Integer(Ole2.GetErrorInfo(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__CreateErrorInfo(AMachine: TatVirtualMachine);
  var
  Param0: ICreateErrorInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := ICreateErrorInfo(Integer(GetInputArg(0)));
AResult := Integer(Ole2.CreateErrorInfo(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__OaBuildVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OaBuildVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleBuildVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleBuildVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ReadClassStg(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(Ole2.ReadClassStg(IStorage(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__WriteClassStg(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.WriteClassStg(IStorage(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ReadClassStm(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(Ole2.ReadClassStm(IStream(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__WriteClassStm(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.WriteClassStm(IStream(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__WriteFmtUserTypeStg(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.WriteFmtUserTypeStg(IStorage(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ReadFmtUserTypeStg(AMachine: TatVirtualMachine);
  var
  Param1: TClipFormat;
  Param2Buf: array[0..127] of WideChar;
  Param2: POleStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))));
AResult := Integer(Ole2.ReadFmtUserTypeStg(IStorage(Integer(GetInputArg(0))),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,WideCharToString(Param2));
  end;
end;

procedure TatOle2Library.__OleUninitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Ole2.OleUninitialize;
  end;
end;

procedure TatOle2Library.__OleQueryLinkFromData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleQueryLinkFromData(IDataObject(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleQueryCreateFromData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleQueryCreateFromData(IDataObject(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleLoad(AMachine: TatVirtualMachine);
  var
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(Ole2.OleLoad(IStorage(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,IOleClientSite(Integer(GetInputArg(2))),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__OleSave(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleSave(IPersistStorage(Integer(GetInputArg(0))),IStorage(Integer(GetInputArg(1))),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleLoadFromStream(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(Ole2.OleLoadFromStream(IStream(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOle2Library.__OleSaveToStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleSaveToStream(IPersistStream(Integer(GetInputArg(0))),IStream(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleSetContainedObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleSetContainedObject(IUnknown(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleNoteObjectVisible(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleNoteObjectVisible(IUnknown(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__RegisterDragDrop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.RegisterDragDrop(VarToInteger(GetInputArg(0)),IDropTarget(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__RevokeDragDrop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.RevokeDragDrop(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__DoDragDrop(AMachine: TatVirtualMachine);
  var
  Param3: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(Ole2.DoDragDrop(IDataObject(Integer(GetInputArg(0))),IDropSource(Integer(GetInputArg(1))),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatOle2Library.__OleSetClipboard(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleSetClipboard(IDataObject(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleGetClipboard(AMachine: TatVirtualMachine);
  var
  Param0: IDataObject;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IDataObject(Integer(GetInputArg(0)));
AResult := Integer(Ole2.OleGetClipboard(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__OleFlushClipboard(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleFlushClipboard);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleIsCurrentClipboard(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleIsCurrentClipboard(IDataObject(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleCreateMenuDescriptor(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TOleMenuGroupWidths;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagOleMenuGroupWidthsWrapper) then 
  Param1Rec := tagOleMenuGroupWidthsWrapper.Create(Param1);
Param1 := tagOleMenuGroupWidthsWrapper(Param1Rec).ObjToRec;
AResult := Integer(Ole2.OleCreateMenuDescriptor(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagOleMenuGroupWidthsWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__OleSetMenuDescriptor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleSetMenuDescriptor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),IOleInPlaceFrame(Integer(GetInputArg(3))),IOleInPlaceActiveObject(Integer(GetInputArg(4)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleDestroyMenuDescriptor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleDestroyMenuDescriptor(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleDuplicateData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleDuplicateData(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleDraw(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleDraw(IUnknown(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),TRectWrapper(integer(GetInputArg(3))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleRun(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleRun(IUnknown(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleIsRunning(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Ole2.OleIsRunning(IOleObject(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleLockRunning(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleLockRunning(IUnknown(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__ReleaseStgMedium(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TStgMedium;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagSTGMEDIUMWrapper) then 
  Param0Rec := tagSTGMEDIUMWrapper.Create(Param0);
Param0 := tagSTGMEDIUMWrapper(Param0Rec).ObjToRec;
    Ole2.ReleaseStgMedium(Param0);
    SetInputArg(0,integer(tagSTGMEDIUMWrapper.Create(Param0)));
  end;
end;

procedure TatOle2Library.__CreateOleAdviseHolder(AMachine: TatVirtualMachine);
  var
  Param0: IOleAdviseHolder;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IOleAdviseHolder(Integer(GetInputArg(0)));
AResult := Integer(Ole2.CreateOleAdviseHolder(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOle2Library.__OleCreateDefaultHandler(AMachine: TatVirtualMachine);
  var
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(Ole2.OleCreateDefaultHandler(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,IUnknown(Integer(GetInputArg(1))),TGUIDWrapper(integer(GetInputArg(2))).ObjToRec,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatOle2Library.__OleCreateEmbeddingHelper(AMachine: TatVirtualMachine);
  var
  Param5: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param5 := GetInputArg(5);
AResult := Integer(Ole2.OleCreateEmbeddingHelper(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,IUnknown(Integer(GetInputArg(1))),VarToInteger(GetInputArg(2)),IClassFactory(Integer(GetInputArg(3))),TGUIDWrapper(integer(GetInputArg(4))).ObjToRec,Param5));
    ReturnOutputArg(AResult);
    SetInputArg(5,Param5);
  end;
end;

procedure TatOle2Library.__OleGetIconOfFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleGetIconOfFile(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleGetIconOfClass(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleGetIconOfClass(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleMetafilePictFromIconAndLabel(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleMetafilePictFromIconAndLabel(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__OleRegGetUserType(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param2: POleStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))));
AResult := Integer(Ole2.OleRegGetUserType(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,WideCharToString(Param2));
  end;
end;

procedure TatOle2Library.__OleRegGetMiscStatus(AMachine: TatVirtualMachine);
  var
  Param2: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Ole2.OleRegGetMiscStatus(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__OleRegEnumFormatEtc(AMachine: TatVirtualMachine);
  var
  Param2: IEnumFormatEtc;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := IEnumFormatEtc(Integer(GetInputArg(2)));
AResult := Integer(Ole2.OleRegEnumFormatEtc(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__OleRegEnumVerbs(AMachine: TatVirtualMachine);
  var
  Param1: IEnumOleVerb;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IEnumOleVerb(Integer(GetInputArg(1)));
AResult := Integer(Ole2.OleRegEnumVerbs(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__GetHGlobalFromILockBytes(AMachine: TatVirtualMachine);
  var
  Param1: HGlobal;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.GetHGlobalFromILockBytes(ILockBytes(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__CreateILockBytesOnHGlobal(AMachine: TatVirtualMachine);
  var
  Param2: ILockBytes;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := ILockBytes(Integer(GetInputArg(2)));
AResult := Integer(Ole2.CreateILockBytesOnHGlobal(VarToInteger(GetInputArg(0)),GetInputArg(1),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__GetHGlobalFromStream(AMachine: TatVirtualMachine);
  var
  Param1: HGlobal;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Ole2.GetHGlobalFromStream(IStream(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOle2Library.__CreateStreamOnHGlobal(AMachine: TatVirtualMachine);
  var
  Param2: IStream;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := IStream(Integer(GetInputArg(2)));
AResult := Integer(Ole2.CreateStreamOnHGlobal(VarToInteger(GetInputArg(0)),GetInputArg(1),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOle2Library.__OleDoAutoConvert(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(Ole2.OleDoAutoConvert(IStorage(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__OleGetAutoConvert(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(Ole2.OleGetAutoConvert(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatOle2Library.__OleSetAutoConvert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.OleSetAutoConvert(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__GetConvertStg(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.GetConvertStg(IStorage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__SetConvertStg(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Ole2.SetConvertStg(IStorage(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOle2Library.__GetGUID_NULL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.GUID_NULL)));
  end;
end;

procedure TatOle2Library.__GetIID_IUnknown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IUnknown)));
  end;
end;

procedure TatOle2Library.__GetIID_IClassFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IClassFactory)));
  end;
end;

procedure TatOle2Library.__GetIID_IMarshal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IMarshal)));
  end;
end;

procedure TatOle2Library.__GetIID_IMalloc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IMalloc)));
  end;
end;

procedure TatOle2Library.__GetIID_IStdMarshalInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IStdMarshalInfo)));
  end;
end;

procedure TatOle2Library.__GetIID_IExternalConnection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IExternalConnection)));
  end;
end;

procedure TatOle2Library.__GetIID_IEnumUnknown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IEnumUnknown)));
  end;
end;

procedure TatOle2Library.__GetIID_IBindCtx(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IBindCtx)));
  end;
end;

procedure TatOle2Library.__GetIID_IEnumMoniker(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IEnumMoniker)));
  end;
end;

procedure TatOle2Library.__GetIID_IRunnableObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IRunnableObject)));
  end;
end;

procedure TatOle2Library.__GetIID_IRunningObjectTable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IRunningObjectTable)));
  end;
end;

procedure TatOle2Library.__GetIID_IPersist(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IPersist)));
  end;
end;

procedure TatOle2Library.__GetIID_IPersistStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IPersistStream)));
  end;
end;

procedure TatOle2Library.__GetIID_IMoniker(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IMoniker)));
  end;
end;

procedure TatOle2Library.__GetIID_IEnumString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IEnumString)));
  end;
end;

procedure TatOle2Library.__GetIID_IStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IStream)));
  end;
end;

procedure TatOle2Library.__GetIID_IEnumStatStg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IEnumStatStg)));
  end;
end;

procedure TatOle2Library.__GetIID_IStorage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IStorage)));
  end;
end;

procedure TatOle2Library.__GetIID_IPersistFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IPersistFile)));
  end;
end;

procedure TatOle2Library.__GetIID_IPersistStorage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IPersistStorage)));
  end;
end;

procedure TatOle2Library.__GetIID_ILockBytes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_ILockBytes)));
  end;
end;

procedure TatOle2Library.__GetIID_IEnumFormatEtc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IEnumFormatEtc)));
  end;
end;

procedure TatOle2Library.__GetIID_IEnumStatData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IEnumStatData)));
  end;
end;

procedure TatOle2Library.__GetIID_IRootStorage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IRootStorage)));
  end;
end;

procedure TatOle2Library.__GetIID_IAdviseSink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IAdviseSink)));
  end;
end;

procedure TatOle2Library.__GetIID_IAdviseSink2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IAdviseSink2)));
  end;
end;

procedure TatOle2Library.__GetIID_IDataObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IDataObject)));
  end;
end;

procedure TatOle2Library.__GetIID_IDataAdviseHolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IDataAdviseHolder)));
  end;
end;

procedure TatOle2Library.__GetIID_IMessageFilter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IMessageFilter)));
  end;
end;

procedure TatOle2Library.__GetIID_IRpcChannelBuffer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IRpcChannelBuffer)));
  end;
end;

procedure TatOle2Library.__GetIID_IRpcProxyBuffer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IRpcProxyBuffer)));
  end;
end;

procedure TatOle2Library.__GetIID_IRpcStubBuffer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IRpcStubBuffer)));
  end;
end;

procedure TatOle2Library.__GetIID_IPSFactoryBuffer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IPSFactoryBuffer)));
  end;
end;

procedure TatOle2Library.__GetIID_ICreateTypeInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_ICreateTypeInfo)));
  end;
end;

procedure TatOle2Library.__GetIID_ICreateTypeLib(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_ICreateTypeLib)));
  end;
end;

procedure TatOle2Library.__GetIID_IDispatch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IDispatch)));
  end;
end;

procedure TatOle2Library.__GetIID_IEnumVariant(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IEnumVariant)));
  end;
end;

procedure TatOle2Library.__GetIID_ITypeComp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_ITypeComp)));
  end;
end;

procedure TatOle2Library.__GetIID_ITypeInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_ITypeInfo)));
  end;
end;

procedure TatOle2Library.__GetIID_ITypeLib(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_ITypeLib)));
  end;
end;

procedure TatOle2Library.__GetIID_IErrorInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IErrorInfo)));
  end;
end;

procedure TatOle2Library.__GetIID_ICreateErrorInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_ICreateErrorInfo)));
  end;
end;

procedure TatOle2Library.__GetIID_ISupportErrorInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_ISupportErrorInfo)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleAdviseHolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleAdviseHolder)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleCache(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleCache)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleCache2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleCache2)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleCacheControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleCacheControl)));
  end;
end;

procedure TatOle2Library.__GetIID_IParseDisplayName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IParseDisplayName)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleContainer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleContainer)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleClientSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleClientSite)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleObject)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleWindow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleWindow)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleLink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleLink)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleItemContainer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleItemContainer)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleInPlaceUIWindow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleInPlaceUIWindow)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleInPlaceActiveObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleInPlaceActiveObject)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleInPlaceFrame(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleInPlaceFrame)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleInPlaceObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleInPlaceObject)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleInPlaceSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleInPlaceSite)));
  end;
end;

procedure TatOle2Library.__GetIID_IViewObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IViewObject)));
  end;
end;

procedure TatOle2Library.__GetIID_IViewObject2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IViewObject2)));
  end;
end;

procedure TatOle2Library.__GetIID_IDropSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IDropSource)));
  end;
end;

procedure TatOle2Library.__GetIID_IDropTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IDropTarget)));
  end;
end;

procedure TatOle2Library.__GetIID_IEnumOleVerb(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IEnumOleVerb)));
  end;
end;

procedure TatOle2Library.__GetIID_IRpcChannel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IRpcChannel)));
  end;
end;

procedure TatOle2Library.__GetIID_IRpcStub(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IRpcStub)));
  end;
end;

procedure TatOle2Library.__GetIID_IStubManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IStubManager)));
  end;
end;

procedure TatOle2Library.__GetIID_IRpcProxy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IRpcProxy)));
  end;
end;

procedure TatOle2Library.__GetIID_IProxyManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IProxyManager)));
  end;
end;

procedure TatOle2Library.__GetIID_IPSFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IPSFactory)));
  end;
end;

procedure TatOle2Library.__GetIID_IInternalMoniker(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IInternalMoniker)));
  end;
end;

procedure TatOle2Library.__GetCLSID_StdMarshal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.CLSID_StdMarshal)));
  end;
end;

procedure TatOle2Library.__GetIID_IEnumGeneric(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IEnumGeneric)));
  end;
end;

procedure TatOle2Library.__GetIID_IEnumHolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IEnumHolder)));
  end;
end;

procedure TatOle2Library.__GetIID_IEnumCallback(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IEnumCallback)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleManager)));
  end;
end;

procedure TatOle2Library.__GetIID_IOlePresObj(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOlePresObj)));
  end;
end;

procedure TatOle2Library.__GetIID_IDebug(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IDebug)));
  end;
end;

procedure TatOle2Library.__GetIID_IDebugStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IDebugStream)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleDocument(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleDocument)));
  end;
end;

procedure TatOle2Library.__GetIID_IOleDocumentSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Ole2.IID_IOleDocumentSite)));
  end;
end;

procedure TatOle2Library.Init;
begin
  With Scripter.DefineClass(IUnknown) do
  begin
    DefineMethod('QueryInterface',2,tkInteger,nil,__IUnknownQueryInterface,false,0).SetVarArgs([1]);
    DefineMethod('AddRef',0,tkInteger,nil,__IUnknownAddRef,false,0);
    DefineMethod('Release',0,tkInteger,nil,__IUnknownRelease,false,0);
  end;
  With Scripter.DefineClass(IClassFactory) do
  begin
    DefineMethod('CreateInstance',3,tkInteger,nil,__IClassFactoryCreateInstance,false,0).SetVarArgs([2]);
    DefineMethod('LockServer',1,tkInteger,nil,__IClassFactoryLockServer,false,0);
  end;
  With Scripter.DefineClass(IMarshal) do
  begin
    DefineMethod('UnmarshalInterface',3,tkInteger,nil,__IMarshalUnmarshalInterface,false,0).SetVarArgs([2]);
    DefineMethod('ReleaseMarshalData',1,tkInteger,nil,__IMarshalReleaseMarshalData,false,0);
    DefineMethod('DisconnectObject',1,tkInteger,nil,__IMarshalDisconnectObject,false,0);
  end;
  With Scripter.DefineClass(IMalloc) do
  begin
    DefineMethod('HeapMinimize',0,tkNone,nil,__IMallocHeapMinimize,false,0);
  end;
  With Scripter.DefineClass(IMallocSpy) do
  begin
    DefineMethod('PreAlloc',1,tkInteger,nil,__IMallocSpyPreAlloc,false,0);
    DefineMethod('PostFree',1,tkNone,nil,__IMallocSpyPostFree,false,0);
    DefineMethod('PreHeapMinimize',0,tkNone,nil,__IMallocSpyPreHeapMinimize,false,0);
    DefineMethod('PostHeapMinimize',0,tkNone,nil,__IMallocSpyPostHeapMinimize,false,0);
  end;
  With Scripter.DefineClass(IStdMarshalInfo) do
  begin
  end;
  With Scripter.DefineClass(IExternalConnection) do
  begin
    DefineMethod('AddConnection',2,tkInteger,nil,__IExternalConnectionAddConnection,false,0);
    DefineMethod('ReleaseConnection',3,tkInteger,nil,__IExternalConnectionReleaseConnection,false,0);
  end;
  With Scripter.DefineClass(IWeakRef) do
  begin
    DefineMethod('ChangeWeakCount',1,tkInteger,nil,__IWeakRefChangeWeakCount,false,0);
    DefineMethod('ReleaseKeepAlive',2,tkInteger,nil,__IWeakRefReleaseKeepAlive,false,0);
  end;
  With Scripter.DefineClass(IEnumUnknown) do
  begin
    DefineMethod('Skip',1,tkInteger,nil,__IEnumUnknownSkip,false,0);
    DefineMethod('Reset',0,tkInteger,nil,__IEnumUnknownReset,false,0);
    DefineMethod('Clone',1,tkInteger,nil,__IEnumUnknownClone,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IBindCtx) do
  begin
    DefineMethod('RegisterObjectBound',1,tkInteger,nil,__IBindCtxRegisterObjectBound,false,0);
    DefineMethod('RevokeObjectBound',1,tkInteger,nil,__IBindCtxRevokeObjectBound,false,0);
    DefineMethod('ReleaseBoundObjects',0,tkInteger,nil,__IBindCtxReleaseBoundObjects,false,0);
    DefineMethod('SetBindOptions',1,tkInteger,nil,__IBindCtxSetBindOptions,false,0).SetVarArgs([0]);
    DefineMethod('GetBindOptions',1,tkInteger,nil,__IBindCtxGetBindOptions,false,0).SetVarArgs([0]);
    DefineMethod('GetRunningObjectTable',1,tkInteger,nil,__IBindCtxGetRunningObjectTable,false,0).SetVarArgs([0]);
    DefineMethod('RegisterObjectParam',2,tkInteger,nil,__IBindCtxRegisterObjectParam,false,0);
    DefineMethod('GetObjectParam',2,tkInteger,nil,__IBindCtxGetObjectParam,false,0).SetVarArgs([1]);
    DefineMethod('EnumObjectParam',1,tkInteger,nil,__IBindCtxEnumObjectParam,false,0).SetVarArgs([0]);
    DefineMethod('RevokeObjectParam',1,tkInteger,nil,__IBindCtxRevokeObjectParam,false,0);
  end;
  With Scripter.DefineClass(IEnumMoniker) do
  begin
    DefineMethod('Skip',1,tkInteger,nil,__IEnumMonikerSkip,false,0);
    DefineMethod('Reset',0,tkInteger,nil,__IEnumMonikerReset,false,0);
    DefineMethod('Clone',1,tkInteger,nil,__IEnumMonikerClone,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IRunnableObject) do
  begin
    DefineMethod('GetRunningClass',1,tkInteger,nil,__IRunnableObjectGetRunningClass,false,0).SetVarArgs([0]);
    DefineMethod('Run',1,tkInteger,nil,__IRunnableObjectRun,false,0);
    DefineMethod('IsRunning',0,tkVariant,nil,__IRunnableObjectIsRunning,false,0);
    DefineMethod('LockRunning',2,tkInteger,nil,__IRunnableObjectLockRunning,false,0);
    DefineMethod('SetContainedObject',1,tkInteger,nil,__IRunnableObjectSetContainedObject,false,0);
  end;
  With Scripter.DefineClass(IRunningObjectTable) do
  begin
    DefineMethod('Register',4,tkInteger,nil,__IRunningObjectTableRegister,false,0).SetVarArgs([1,3]);
    DefineMethod('Revoke',1,tkInteger,nil,__IRunningObjectTableRevoke,false,0);
    DefineMethod('IsRunning',1,tkInteger,nil,__IRunningObjectTableIsRunning,false,0);
    DefineMethod('GetObject',2,tkInteger,nil,__IRunningObjectTableGetObject,false,0).SetVarArgs([1]);
    DefineMethod('NoteChangeTime',2,tkInteger,nil,__IRunningObjectTableNoteChangeTime,false,0).SetVarArgs([1]);
    DefineMethod('GetTimeOfLastChange',2,tkInteger,nil,__IRunningObjectTableGetTimeOfLastChange,false,0).SetVarArgs([1]);
    DefineMethod('EnumRunning',1,tkInteger,nil,__IRunningObjectTableEnumRunning,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IPersist) do
  begin
    DefineMethod('GetClassID',1,tkInteger,nil,__IPersistGetClassID,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IPersistStream) do
  begin
    DefineMethod('IsDirty',0,tkInteger,nil,__IPersistStreamIsDirty,false,0);
    DefineMethod('Load',1,tkInteger,nil,__IPersistStreamLoad,false,0);
    DefineMethod('Save',2,tkInteger,nil,__IPersistStreamSave,false,0);
    DefineMethod('GetSizeMax',1,tkInteger,nil,__IPersistStreamGetSizeMax,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IMoniker) do
  begin
    DefineMethod('BindToObject',4,tkInteger,nil,__IMonikerBindToObject,false,0).SetVarArgs([3]);
    DefineMethod('BindToStorage',4,tkInteger,nil,__IMonikerBindToStorage,false,0).SetVarArgs([3]);
    DefineMethod('Reduce',4,tkInteger,nil,__IMonikerReduce,false,0).SetVarArgs([2,3]);
    DefineMethod('ComposeWith',3,tkInteger,nil,__IMonikerComposeWith,false,0).SetVarArgs([2]);
    DefineMethod('Enum',2,tkInteger,nil,__IMonikerEnum,false,0).SetVarArgs([1]);
    DefineMethod('IsEqual',1,tkInteger,nil,__IMonikerIsEqual,false,0);
    DefineMethod('Hash',1,tkInteger,nil,__IMonikerHash,false,0).SetVarArgs([0]);
    DefineMethod('IsRunning',3,tkInteger,nil,__IMonikerIsRunning,false,0);
    DefineMethod('GetTimeOfLastChange',3,tkInteger,nil,__IMonikerGetTimeOfLastChange,false,0).SetVarArgs([2]);
    DefineMethod('Inverse',1,tkInteger,nil,__IMonikerInverse,false,0).SetVarArgs([0]);
    DefineMethod('CommonPrefixWith',2,tkInteger,nil,__IMonikerCommonPrefixWith,false,0).SetVarArgs([1]);
    DefineMethod('RelativePathTo',2,tkInteger,nil,__IMonikerRelativePathTo,false,0).SetVarArgs([1]);
    DefineMethod('GetDisplayName',3,tkInteger,nil,__IMonikerGetDisplayName,false,0).SetVarArgs([2]);
    DefineMethod('ParseDisplayName',5,tkInteger,nil,__IMonikerParseDisplayName,false,0).SetVarArgs([3,4]);
    DefineMethod('IsSystemMoniker',1,tkInteger,nil,__IMonikerIsSystemMoniker,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IEnumString) do
  begin
    DefineMethod('Skip',1,tkInteger,nil,__IEnumStringSkip,false,0);
    DefineMethod('Reset',0,tkInteger,nil,__IEnumStringReset,false,0);
    DefineMethod('Clone',1,tkInteger,nil,__IEnumStringClone,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IStream) do
  begin
    DefineMethod('Seek',3,tkInteger,nil,__IStreamSeek,false,0).SetVarArgs([2]);
    DefineMethod('SetSize',1,tkInteger,nil,__IStreamSetSize,false,0);
    DefineMethod('CopyTo',4,tkInteger,nil,__IStreamCopyTo,false,0).SetVarArgs([2,3]);
    DefineMethod('Commit',1,tkInteger,nil,__IStreamCommit,false,0);
    DefineMethod('Revert',0,tkInteger,nil,__IStreamRevert,false,0);
    DefineMethod('LockRegion',3,tkInteger,nil,__IStreamLockRegion,false,0);
    DefineMethod('UnlockRegion',3,tkInteger,nil,__IStreamUnlockRegion,false,0);
    DefineMethod('Stat',2,tkInteger,nil,__IStreamStat,false,0).SetVarArgs([0]);
    DefineMethod('Clone',1,tkInteger,nil,__IStreamClone,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IEnumStatStg) do
  begin
    DefineMethod('Skip',1,tkInteger,nil,__IEnumStatStgSkip,false,0);
    DefineMethod('Reset',0,tkInteger,nil,__IEnumStatStgReset,false,0);
    DefineMethod('Clone',1,tkInteger,nil,__IEnumStatStgClone,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IStorage) do
  begin
    DefineMethod('CreateStream',5,tkInteger,nil,__IStorageCreateStream,false,0).SetVarArgs([4]);
    DefineMethod('CreateStorage',5,tkInteger,nil,__IStorageCreateStorage,false,0).SetVarArgs([4]);
    DefineMethod('MoveElementTo',4,tkInteger,nil,__IStorageMoveElementTo,false,0);
    DefineMethod('Commit',1,tkInteger,nil,__IStorageCommit,false,0);
    DefineMethod('Revert',0,tkInteger,nil,__IStorageRevert,false,0);
    DefineMethod('DestroyElement',1,tkInteger,nil,__IStorageDestroyElement,false,0);
    DefineMethod('RenameElement',2,tkInteger,nil,__IStorageRenameElement,false,0);
    DefineMethod('SetElementTimes',4,tkInteger,nil,__IStorageSetElementTimes,false,0);
    DefineMethod('SetClass',1,tkInteger,nil,__IStorageSetClass,false,0);
    DefineMethod('SetStateBits',2,tkInteger,nil,__IStorageSetStateBits,false,0);
    DefineMethod('Stat',2,tkInteger,nil,__IStorageStat,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IPersistFile) do
  begin
    DefineMethod('IsDirty',0,tkInteger,nil,__IPersistFileIsDirty,false,0);
    DefineMethod('Load',2,tkInteger,nil,__IPersistFileLoad,false,0);
    DefineMethod('Save',2,tkInteger,nil,__IPersistFileSave,false,0);
    DefineMethod('SaveCompleted',1,tkInteger,nil,__IPersistFileSaveCompleted,false,0);
    DefineMethod('GetCurFile',1,tkInteger,nil,__IPersistFileGetCurFile,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IPersistStorage) do
  begin
    DefineMethod('IsDirty',0,tkInteger,nil,__IPersistStorageIsDirty,false,0);
    DefineMethod('InitNew',1,tkInteger,nil,__IPersistStorageInitNew,false,0);
    DefineMethod('Load',1,tkInteger,nil,__IPersistStorageLoad,false,0);
    DefineMethod('Save',2,tkInteger,nil,__IPersistStorageSave,false,0);
    DefineMethod('SaveCompleted',1,tkInteger,nil,__IPersistStorageSaveCompleted,false,0);
    DefineMethod('HandsOffStorage',0,tkInteger,nil,__IPersistStorageHandsOffStorage,false,0);
  end;
  With Scripter.DefineClass(ILockBytes) do
  begin
    DefineMethod('Flush',0,tkInteger,nil,__ILockBytesFlush,false,0);
    DefineMethod('SetSize',1,tkInteger,nil,__ILockBytesSetSize,false,0);
    DefineMethod('LockRegion',3,tkInteger,nil,__ILockBytesLockRegion,false,0);
    DefineMethod('UnlockRegion',3,tkInteger,nil,__ILockBytesUnlockRegion,false,0);
    DefineMethod('Stat',2,tkInteger,nil,__ILockBytesStat,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IEnumFormatEtc) do
  begin
    DefineMethod('Skip',1,tkInteger,nil,__IEnumFormatEtcSkip,false,0);
    DefineMethod('Reset',0,tkInteger,nil,__IEnumFormatEtcReset,false,0);
    DefineMethod('Clone',1,tkInteger,nil,__IEnumFormatEtcClone,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IEnumStatData) do
  begin
    DefineMethod('Skip',1,tkInteger,nil,__IEnumStatDataSkip,false,0);
    DefineMethod('Reset',0,tkInteger,nil,__IEnumStatDataReset,false,0);
    DefineMethod('Clone',1,tkInteger,nil,__IEnumStatDataClone,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IRootStorage) do
  begin
    DefineMethod('SwitchToFile',1,tkInteger,nil,__IRootStorageSwitchToFile,false,0);
  end;
  With Scripter.DefineClass(IAdviseSink) do
  begin
    DefineMethod('OnDataChange',2,tkNone,nil,__IAdviseSinkOnDataChange,false,0).SetVarArgs([0,1]);
    DefineMethod('OnViewChange',2,tkNone,nil,__IAdviseSinkOnViewChange,false,0);
    DefineMethod('OnRename',1,tkNone,nil,__IAdviseSinkOnRename,false,0);
    DefineMethod('OnSave',0,tkNone,nil,__IAdviseSinkOnSave,false,0);
    DefineMethod('OnClose',0,tkNone,nil,__IAdviseSinkOnClose,false,0);
  end;
  With Scripter.DefineClass(IAdviseSink2) do
  begin
    DefineMethod('OnLinkSrcChange',1,tkNone,nil,__IAdviseSink2OnLinkSrcChange,false,0);
  end;
  With Scripter.DefineClass(IDataObject) do
  begin
    DefineMethod('GetData',2,tkInteger,nil,__IDataObjectGetData,false,0).SetVarArgs([0,1]);
    DefineMethod('GetDataHere',2,tkInteger,nil,__IDataObjectGetDataHere,false,0).SetVarArgs([0,1]);
    DefineMethod('QueryGetData',1,tkInteger,nil,__IDataObjectQueryGetData,false,0).SetVarArgs([0]);
    DefineMethod('GetCanonicalFormatEtc',2,tkInteger,nil,__IDataObjectGetCanonicalFormatEtc,false,0).SetVarArgs([0,1]);
    DefineMethod('SetData',3,tkInteger,nil,__IDataObjectSetData,false,0).SetVarArgs([0,1]);
    DefineMethod('EnumFormatEtc',2,tkInteger,nil,__IDataObjectEnumFormatEtc,false,0).SetVarArgs([1]);
    DefineMethod('DAdvise',4,tkInteger,nil,__IDataObjectDAdvise,false,0).SetVarArgs([0,3]);
    DefineMethod('DUnadvise',1,tkInteger,nil,__IDataObjectDUnadvise,false,0);
    DefineMethod('EnumDAdvise',1,tkInteger,nil,__IDataObjectEnumDAdvise,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IDataAdviseHolder) do
  begin
    DefineMethod('Advise',5,tkInteger,nil,__IDataAdviseHolderAdvise,false,0).SetVarArgs([1,4]);
    DefineMethod('Unadvise',1,tkInteger,nil,__IDataAdviseHolderUnadvise,false,0);
    DefineMethod('EnumAdvise',1,tkInteger,nil,__IDataAdviseHolderEnumAdvise,false,0).SetVarArgs([0]);
    DefineMethod('SendOnDataChange',3,tkInteger,nil,__IDataAdviseHolderSendOnDataChange,false,0);
  end;
  With Scripter.DefineClass(IMessageFilter) do
  begin
    DefineMethod('RetryRejectedCall',3,tkInteger,nil,__IMessageFilterRetryRejectedCall,false,0);
    DefineMethod('MessagePending',3,tkInteger,nil,__IMessageFilterMessagePending,false,0);
  end;
  With Scripter.DefineClass(IRpcChannelBuffer) do
  begin
    DefineMethod('GetBuffer',2,tkInteger,nil,__IRpcChannelBufferGetBuffer,false,0).SetVarArgs([0]);
    DefineMethod('SendReceive',2,tkInteger,nil,__IRpcChannelBufferSendReceive,false,0).SetVarArgs([0,1]);
    DefineMethod('FreeBuffer',1,tkInteger,nil,__IRpcChannelBufferFreeBuffer,false,0).SetVarArgs([0]);
    DefineMethod('GetDestCtx',2,tkInteger,nil,__IRpcChannelBufferGetDestCtx,false,0).SetVarArgs([0,1]);
    DefineMethod('IsConnected',0,tkInteger,nil,__IRpcChannelBufferIsConnected,false,0);
  end;
  With Scripter.DefineClass(IRpcProxyBuffer) do
  begin
    DefineMethod('Connect',1,tkInteger,nil,__IRpcProxyBufferConnect,false,0);
    DefineMethod('Disconnect',0,tkNone,nil,__IRpcProxyBufferDisconnect,false,0);
  end;
  With Scripter.DefineClass(IRpcStubBuffer) do
  begin
    DefineMethod('Connect',1,tkInteger,nil,__IRpcStubBufferConnect,false,0);
    DefineMethod('Disconnect',0,tkNone,nil,__IRpcStubBufferDisconnect,false,0);
    DefineMethod('Invoke',2,tkInteger,nil,__IRpcStubBufferInvoke,false,0).SetVarArgs([0]);
    DefineMethod('IsIIDSupported',1,tkClass,IRpcStubBuffer,__IRpcStubBufferIsIIDSupported,false,0);
    DefineMethod('CountRefs',0,tkInteger,nil,__IRpcStubBufferCountRefs,false,0);
    DefineMethod('DebugServerQueryInterface',1,tkInteger,nil,__IRpcStubBufferDebugServerQueryInterface,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IPSFactoryBuffer) do
  begin
    DefineMethod('CreateProxy',4,tkInteger,nil,__IPSFactoryBufferCreateProxy,false,0).SetVarArgs([2,3]);
    DefineMethod('CreateStub',3,tkInteger,nil,__IPSFactoryBufferCreateStub,false,0).SetVarArgs([2]);
  end;
  With Scripter.DefineClass(ICreateTypeInfo) do
  begin
    DefineMethod('SetGuid',1,tkInteger,nil,__ICreateTypeInfoSetGuid,false,0);
    DefineMethod('SetTypeFlags',1,tkInteger,nil,__ICreateTypeInfoSetTypeFlags,false,0);
    DefineMethod('SetDocString',1,tkInteger,nil,__ICreateTypeInfoSetDocString,false,0);
    DefineMethod('SetHelpContext',1,tkInteger,nil,__ICreateTypeInfoSetHelpContext,false,0);
    DefineMethod('SetVersion',2,tkInteger,nil,__ICreateTypeInfoSetVersion,false,0);
    DefineMethod('AddRefTypeInfo',2,tkInteger,nil,__ICreateTypeInfoAddRefTypeInfo,false,0).SetVarArgs([1]);
    DefineMethod('AddFuncDesc',2,tkInteger,nil,__ICreateTypeInfoAddFuncDesc,false,0).SetVarArgs([1]);
    DefineMethod('AddImplType',2,tkInteger,nil,__ICreateTypeInfoAddImplType,false,0);
    DefineMethod('SetImplTypeFlags',2,tkInteger,nil,__ICreateTypeInfoSetImplTypeFlags,false,0);
    DefineMethod('SetAlignment',1,tkInteger,nil,__ICreateTypeInfoSetAlignment,false,0);
    DefineMethod('SetSchema',1,tkInteger,nil,__ICreateTypeInfoSetSchema,false,0);
    DefineMethod('AddVarDesc',2,tkInteger,nil,__ICreateTypeInfoAddVarDesc,false,0).SetVarArgs([1]);
    DefineMethod('SetVarName',2,tkInteger,nil,__ICreateTypeInfoSetVarName,false,0);
    DefineMethod('SetTypeDescAlias',1,tkInteger,nil,__ICreateTypeInfoSetTypeDescAlias,false,0).SetVarArgs([0]);
    DefineMethod('DefineFuncAsDllEntry',3,tkInteger,nil,__ICreateTypeInfoDefineFuncAsDllEntry,false,0);
    DefineMethod('SetFuncDocString',2,tkInteger,nil,__ICreateTypeInfoSetFuncDocString,false,0);
    DefineMethod('SetVarDocString',2,tkInteger,nil,__ICreateTypeInfoSetVarDocString,false,0);
    DefineMethod('SetFuncHelpContext',2,tkInteger,nil,__ICreateTypeInfoSetFuncHelpContext,false,0);
    DefineMethod('SetVarHelpContext',2,tkInteger,nil,__ICreateTypeInfoSetVarHelpContext,false,0);
    DefineMethod('SetMops',2,tkInteger,nil,__ICreateTypeInfoSetMops,false,0);
    DefineMethod('SetTypeIdldesc',1,tkInteger,nil,__ICreateTypeInfoSetTypeIdldesc,false,0).SetVarArgs([0]);
    DefineMethod('LayOut',0,tkInteger,nil,__ICreateTypeInfoLayOut,false,0);
  end;
  With Scripter.DefineClass(ICreateTypeLib) do
  begin
    DefineMethod('CreateTypeInfo',3,tkInteger,nil,__ICreateTypeLibCreateTypeInfo,false,0).SetVarArgs([2]);
    DefineMethod('SetName',1,tkInteger,nil,__ICreateTypeLibSetName,false,0);
    DefineMethod('SetVersion',2,tkInteger,nil,__ICreateTypeLibSetVersion,false,0);
    DefineMethod('SetGuid',1,tkInteger,nil,__ICreateTypeLibSetGuid,false,0);
    DefineMethod('SetDocString',1,tkInteger,nil,__ICreateTypeLibSetDocString,false,0);
    DefineMethod('SetHelpFileName',1,tkInteger,nil,__ICreateTypeLibSetHelpFileName,false,0);
    DefineMethod('SetHelpContext',1,tkInteger,nil,__ICreateTypeLibSetHelpContext,false,0);
    DefineMethod('SetLcid',1,tkInteger,nil,__ICreateTypeLibSetLcid,false,0);
    DefineMethod('SetLibFlags',1,tkInteger,nil,__ICreateTypeLibSetLibFlags,false,0);
    DefineMethod('SaveAllChanges',0,tkInteger,nil,__ICreateTypeLibSaveAllChanges,false,0);
  end;
  With Scripter.DefineClass(IDispatch) do
  begin
    DefineMethod('GetTypeInfoCount',1,tkInteger,nil,__IDispatchGetTypeInfoCount,false,0).SetVarArgs([0]);
    DefineMethod('GetTypeInfo',3,tkInteger,nil,__IDispatchGetTypeInfo,false,0).SetVarArgs([2]);
  end;
  With Scripter.DefineClass(IEnumVariant) do
  begin
    DefineMethod('Next',3,tkInteger,nil,__IEnumVariantNext,false,0).SetVarArgs([1,2]);
    DefineMethod('Skip',1,tkInteger,nil,__IEnumVariantSkip,false,0);
    DefineMethod('Reset',0,tkInteger,nil,__IEnumVariantReset,false,0);
    DefineMethod('Clone',1,tkInteger,nil,__IEnumVariantClone,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(ITypeComp) do
  begin
    DefineMethod('Bind',6,tkInteger,nil,__ITypeCompBind,false,0).SetVarArgs([3,4,5]);
    DefineMethod('BindType',4,tkInteger,nil,__ITypeCompBindType,false,0).SetVarArgs([2,3]);
  end;
  With Scripter.DefineClass(ITypeInfo) do
  begin
    DefineMethod('GetTypeComp',1,tkInteger,nil,__ITypeInfoGetTypeComp,false,0).SetVarArgs([0]);
    DefineMethod('GetRefTypeOfImplType',2,tkInteger,nil,__ITypeInfoGetRefTypeOfImplType,false,0).SetVarArgs([1]);
    DefineMethod('GetImplTypeFlags',2,tkInteger,nil,__ITypeInfoGetImplTypeFlags,false,0).SetVarArgs([1]);
    DefineMethod('GetDllEntry',5,tkInteger,nil,__ITypeInfoGetDllEntry,false,0).SetVarArgs([2,3,4]);
    DefineMethod('GetRefTypeInfo',2,tkInteger,nil,__ITypeInfoGetRefTypeInfo,false,0).SetVarArgs([1]);
    DefineMethod('CreateInstance',3,tkInteger,nil,__ITypeInfoCreateInstance,false,0).SetVarArgs([2]);
    DefineMethod('GetMops',2,tkInteger,nil,__ITypeInfoGetMops,false,0).SetVarArgs([1]);
    DefineMethod('GetContainingTypeLib',2,tkInteger,nil,__ITypeInfoGetContainingTypeLib,false,0).SetVarArgs([0,1]);
  end;
  With Scripter.DefineClass(ITypeLib) do
  begin
    DefineMethod('GetTypeInfoCount',0,tkInteger,nil,__ITypeLibGetTypeInfoCount,false,0);
    DefineMethod('GetTypeInfo',2,tkInteger,nil,__ITypeLibGetTypeInfo,false,0).SetVarArgs([1]);
    DefineMethod('GetTypeInfoType',2,tkInteger,nil,__ITypeLibGetTypeInfoType,false,0).SetVarArgs([1]);
    DefineMethod('GetTypeInfoOfGuid',2,tkInteger,nil,__ITypeLibGetTypeInfoOfGuid,false,0).SetVarArgs([1]);
    DefineMethod('GetTypeComp',1,tkInteger,nil,__ITypeLibGetTypeComp,false,0).SetVarArgs([0]);
    DefineMethod('IsName',3,tkInteger,nil,__ITypeLibIsName,false,0).SetVarArgs([2]);
  end;
  With Scripter.DefineClass(IErrorInfo) do
  begin
    DefineMethod('GetGUID',1,tkInteger,nil,__IErrorInfoGetGUID,false,0).SetVarArgs([0]);
    DefineMethod('GetSource',1,tkInteger,nil,__IErrorInfoGetSource,false,0).SetVarArgs([0]);
    DefineMethod('GetDescription',1,tkInteger,nil,__IErrorInfoGetDescription,false,0).SetVarArgs([0]);
    DefineMethod('GetHelpFile',1,tkInteger,nil,__IErrorInfoGetHelpFile,false,0).SetVarArgs([0]);
    DefineMethod('GetHelpContext',1,tkInteger,nil,__IErrorInfoGetHelpContext,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(ICreateErrorInfo) do
  begin
    DefineMethod('SetGUID',1,tkInteger,nil,__ICreateErrorInfoSetGUID,false,0);
    DefineMethod('SetSource',1,tkInteger,nil,__ICreateErrorInfoSetSource,false,0);
    DefineMethod('SetDescription',1,tkInteger,nil,__ICreateErrorInfoSetDescription,false,0);
    DefineMethod('SetHelpFile',1,tkInteger,nil,__ICreateErrorInfoSetHelpFile,false,0);
    DefineMethod('SetHelpContext',1,tkInteger,nil,__ICreateErrorInfoSetHelpContext,false,0);
  end;
  With Scripter.DefineClass(ISupportErrorInfo) do
  begin
    DefineMethod('InterfaceSupportsErrorInfo',1,tkInteger,nil,__ISupportErrorInfoInterfaceSupportsErrorInfo,false,0);
  end;
  With Scripter.DefineClass(IOleAdviseHolder) do
  begin
    DefineMethod('Advise',2,tkInteger,nil,__IOleAdviseHolderAdvise,false,0).SetVarArgs([1]);
    DefineMethod('Unadvise',1,tkInteger,nil,__IOleAdviseHolderUnadvise,false,0);
    DefineMethod('EnumAdvise',1,tkInteger,nil,__IOleAdviseHolderEnumAdvise,false,0).SetVarArgs([0]);
    DefineMethod('SendOnRename',1,tkInteger,nil,__IOleAdviseHolderSendOnRename,false,0);
    DefineMethod('SendOnSave',0,tkInteger,nil,__IOleAdviseHolderSendOnSave,false,0);
    DefineMethod('SendOnClose',0,tkInteger,nil,__IOleAdviseHolderSendOnClose,false,0);
  end;
  With Scripter.DefineClass(IOleCache) do
  begin
    DefineMethod('Cache',3,tkInteger,nil,__IOleCacheCache,false,0).SetVarArgs([0,2]);
    DefineMethod('Uncache',1,tkInteger,nil,__IOleCacheUncache,false,0);
    DefineMethod('EnumCache',1,tkInteger,nil,__IOleCacheEnumCache,false,0).SetVarArgs([0]);
    DefineMethod('InitCache',1,tkInteger,nil,__IOleCacheInitCache,false,0);
    DefineMethod('SetData',3,tkInteger,nil,__IOleCacheSetData,false,0).SetVarArgs([0,1]);
  end;
  With Scripter.DefineClass(IOleCache2) do
  begin
    DefineMethod('DiscardCache',1,tkInteger,nil,__IOleCache2DiscardCache,false,0);
  end;
  With Scripter.DefineClass(IOleCacheControl) do
  begin
    DefineMethod('OnRun',1,tkInteger,nil,__IOleCacheControlOnRun,false,0);
    DefineMethod('OnStop',0,tkInteger,nil,__IOleCacheControlOnStop,false,0);
  end;
  With Scripter.DefineClass(IParseDisplayName) do
  begin
    DefineMethod('ParseDisplayName',4,tkInteger,nil,__IParseDisplayNameParseDisplayName,false,0).SetVarArgs([2,3]);
  end;
  With Scripter.DefineClass(IOleContainer) do
  begin
    DefineMethod('EnumObjects',2,tkInteger,nil,__IOleContainerEnumObjects,false,0).SetVarArgs([1]);
    DefineMethod('LockContainer',1,tkInteger,nil,__IOleContainerLockContainer,false,0);
  end;
  With Scripter.DefineClass(IOleClientSite) do
  begin
    DefineMethod('SaveObject',0,tkInteger,nil,__IOleClientSiteSaveObject,false,0);
    DefineMethod('GetMoniker',3,tkInteger,nil,__IOleClientSiteGetMoniker,false,0).SetVarArgs([2]);
    DefineMethod('GetContainer',1,tkInteger,nil,__IOleClientSiteGetContainer,false,0).SetVarArgs([0]);
    DefineMethod('ShowObject',0,tkInteger,nil,__IOleClientSiteShowObject,false,0);
    DefineMethod('OnShowWindow',1,tkInteger,nil,__IOleClientSiteOnShowWindow,false,0);
    DefineMethod('RequestNewObjectLayout',0,tkInteger,nil,__IOleClientSiteRequestNewObjectLayout,false,0);
  end;
  With Scripter.DefineClass(IOleObject) do
  begin
    DefineMethod('SetClientSite',1,tkInteger,nil,__IOleObjectSetClientSite,false,0);
    DefineMethod('GetClientSite',1,tkInteger,nil,__IOleObjectGetClientSite,false,0).SetVarArgs([0]);
    DefineMethod('SetHostNames',2,tkInteger,nil,__IOleObjectSetHostNames,false,0);
    DefineMethod('Close',1,tkInteger,nil,__IOleObjectClose,false,0);
    DefineMethod('SetMoniker',2,tkInteger,nil,__IOleObjectSetMoniker,false,0);
    DefineMethod('GetMoniker',3,tkInteger,nil,__IOleObjectGetMoniker,false,0).SetVarArgs([2]);
    DefineMethod('InitFromData',3,tkInteger,nil,__IOleObjectInitFromData,false,0);
    DefineMethod('GetClipboardData',2,tkInteger,nil,__IOleObjectGetClipboardData,false,0).SetVarArgs([1]);
    DefineMethod('EnumVerbs',1,tkInteger,nil,__IOleObjectEnumVerbs,false,0).SetVarArgs([0]);
    DefineMethod('Update',0,tkInteger,nil,__IOleObjectUpdate,false,0);
    DefineMethod('IsUpToDate',0,tkInteger,nil,__IOleObjectIsUpToDate,false,0);
    DefineMethod('GetUserClassID',1,tkInteger,nil,__IOleObjectGetUserClassID,false,0).SetVarArgs([0]);
    DefineMethod('GetUserType',2,tkInteger,nil,__IOleObjectGetUserType,false,0).SetVarArgs([1]);
    DefineMethod('SetExtent',2,tkInteger,nil,__IOleObjectSetExtent,false,0);
    DefineMethod('GetExtent',2,tkInteger,nil,__IOleObjectGetExtent,false,0).SetVarArgs([1]);
    DefineMethod('Advise',2,tkInteger,nil,__IOleObjectAdvise,false,0).SetVarArgs([1]);
    DefineMethod('Unadvise',1,tkInteger,nil,__IOleObjectUnadvise,false,0);
    DefineMethod('EnumAdvise',1,tkInteger,nil,__IOleObjectEnumAdvise,false,0).SetVarArgs([0]);
    DefineMethod('GetMiscStatus',2,tkInteger,nil,__IOleObjectGetMiscStatus,false,0).SetVarArgs([1]);
    DefineMethod('SetColorScheme',1,tkInteger,nil,__IOleObjectSetColorScheme,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IOleWindow) do
  begin
    DefineMethod('GetWindow',1,tkInteger,nil,__IOleWindowGetWindow,false,0).SetVarArgs([0]);
    DefineMethod('ContextSensitiveHelp',1,tkInteger,nil,__IOleWindowContextSensitiveHelp,false,0);
  end;
  With Scripter.DefineClass(IOleLink) do
  begin
    DefineMethod('SetUpdateOptions',1,tkInteger,nil,__IOleLinkSetUpdateOptions,false,0);
    DefineMethod('GetUpdateOptions',1,tkInteger,nil,__IOleLinkGetUpdateOptions,false,0).SetVarArgs([0]);
    DefineMethod('SetSourceMoniker',2,tkInteger,nil,__IOleLinkSetSourceMoniker,false,0);
    DefineMethod('GetSourceMoniker',1,tkInteger,nil,__IOleLinkGetSourceMoniker,false,0).SetVarArgs([0]);
    DefineMethod('SetSourceDisplayName',1,tkInteger,nil,__IOleLinkSetSourceDisplayName,false,0);
    DefineMethod('GetSourceDisplayName',1,tkInteger,nil,__IOleLinkGetSourceDisplayName,false,0).SetVarArgs([0]);
    DefineMethod('BindToSource',2,tkInteger,nil,__IOleLinkBindToSource,false,0);
    DefineMethod('BindIfRunning',0,tkInteger,nil,__IOleLinkBindIfRunning,false,0);
    DefineMethod('GetBoundSource',1,tkInteger,nil,__IOleLinkGetBoundSource,false,0).SetVarArgs([0]);
    DefineMethod('UnbindSource',0,tkInteger,nil,__IOleLinkUnbindSource,false,0);
    DefineMethod('Update',1,tkInteger,nil,__IOleLinkUpdate,false,0);
  end;
  With Scripter.DefineClass(IOleItemContainer) do
  begin
    DefineMethod('GetObject',5,tkInteger,nil,__IOleItemContainerGetObject,false,0).SetVarArgs([4]);
    DefineMethod('GetObjectStorage',4,tkInteger,nil,__IOleItemContainerGetObjectStorage,false,0).SetVarArgs([3]);
    DefineMethod('IsRunning',1,tkInteger,nil,__IOleItemContainerIsRunning,false,0);
  end;
  With Scripter.DefineClass(IOleInPlaceUIWindow) do
  begin
    DefineMethod('GetBorder',1,tkInteger,nil,__IOleInPlaceUIWindowGetBorder,false,0).SetVarArgs([0]);
    DefineMethod('RequestBorderSpace',1,tkInteger,nil,__IOleInPlaceUIWindowRequestBorderSpace,false,0);
    DefineMethod('SetActiveObject',2,tkInteger,nil,__IOleInPlaceUIWindowSetActiveObject,false,0);
  end;
  With Scripter.DefineClass(IOleInPlaceActiveObject) do
  begin
    DefineMethod('TranslateAccelerator',1,tkInteger,nil,__IOleInPlaceActiveObjectTranslateAccelerator,false,0).SetVarArgs([0]);
    DefineMethod('OnFrameWindowActivate',1,tkInteger,nil,__IOleInPlaceActiveObjectOnFrameWindowActivate,false,0);
    DefineMethod('OnDocWindowActivate',1,tkInteger,nil,__IOleInPlaceActiveObjectOnDocWindowActivate,false,0);
    DefineMethod('ResizeBorder',3,tkInteger,nil,__IOleInPlaceActiveObjectResizeBorder,false,0);
    DefineMethod('EnableModeless',1,tkInteger,nil,__IOleInPlaceActiveObjectEnableModeless,false,0);
  end;
  With Scripter.DefineClass(IOleInPlaceFrame) do
  begin
    DefineMethod('InsertMenus',2,tkInteger,nil,__IOleInPlaceFrameInsertMenus,false,0).SetVarArgs([1]);
    DefineMethod('SetMenu',3,tkInteger,nil,__IOleInPlaceFrameSetMenu,false,0);
    DefineMethod('RemoveMenus',1,tkInteger,nil,__IOleInPlaceFrameRemoveMenus,false,0);
    DefineMethod('SetStatusText',1,tkInteger,nil,__IOleInPlaceFrameSetStatusText,false,0);
    DefineMethod('EnableModeless',1,tkInteger,nil,__IOleInPlaceFrameEnableModeless,false,0);
    DefineMethod('TranslateAccelerator',2,tkInteger,nil,__IOleInPlaceFrameTranslateAccelerator,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IOleInPlaceObject) do
  begin
    DefineMethod('InPlaceDeactivate',0,tkInteger,nil,__IOleInPlaceObjectInPlaceDeactivate,false,0);
    DefineMethod('UIDeactivate',0,tkInteger,nil,__IOleInPlaceObjectUIDeactivate,false,0);
    DefineMethod('SetObjectRects',2,tkInteger,nil,__IOleInPlaceObjectSetObjectRects,false,0);
    DefineMethod('ReactivateAndUndo',0,tkInteger,nil,__IOleInPlaceObjectReactivateAndUndo,false,0);
  end;
  With Scripter.DefineClass(IOleInPlaceSite) do
  begin
    DefineMethod('CanInPlaceActivate',0,tkInteger,nil,__IOleInPlaceSiteCanInPlaceActivate,false,0);
    DefineMethod('OnInPlaceActivate',0,tkInteger,nil,__IOleInPlaceSiteOnInPlaceActivate,false,0);
    DefineMethod('OnUIActivate',0,tkInteger,nil,__IOleInPlaceSiteOnUIActivate,false,0);
    DefineMethod('GetWindowContext',5,tkInteger,nil,__IOleInPlaceSiteGetWindowContext,false,0).SetVarArgs([0,1,2,3,4]);
    DefineMethod('Scroll',1,tkInteger,nil,__IOleInPlaceSiteScroll,false,0);
    DefineMethod('OnUIDeactivate',1,tkInteger,nil,__IOleInPlaceSiteOnUIDeactivate,false,0);
    DefineMethod('OnInPlaceDeactivate',0,tkInteger,nil,__IOleInPlaceSiteOnInPlaceDeactivate,false,0);
    DefineMethod('DiscardUndoState',0,tkInteger,nil,__IOleInPlaceSiteDiscardUndoState,false,0);
    DefineMethod('DeactivateAndUndo',0,tkInteger,nil,__IOleInPlaceSiteDeactivateAndUndo,false,0);
    DefineMethod('OnPosRectChange',1,tkInteger,nil,__IOleInPlaceSiteOnPosRectChange,false,0);
  end;
  With Scripter.DefineClass(IViewObject) do
  begin
    DefineMethod('Unfreeze',1,tkInteger,nil,__IViewObjectUnfreeze,false,0);
    DefineMethod('SetAdvise',3,tkInteger,nil,__IViewObjectSetAdvise,false,0);
  end;
  With Scripter.DefineClass(IViewObject2) do
  begin
  end;
  With Scripter.DefineClass(IDropSource) do
  begin
    DefineMethod('QueryContinueDrag',2,tkInteger,nil,__IDropSourceQueryContinueDrag,false,0);
    DefineMethod('GiveFeedback',1,tkInteger,nil,__IDropSourceGiveFeedback,false,0);
  end;
  With Scripter.DefineClass(IDropTarget) do
  begin
    DefineMethod('DragEnter',4,tkInteger,nil,__IDropTargetDragEnter,false,0).SetVarArgs([3]);
    DefineMethod('DragOver',3,tkInteger,nil,__IDropTargetDragOver,false,0).SetVarArgs([2]);
    DefineMethod('DragLeave',0,tkInteger,nil,__IDropTargetDragLeave,false,0);
    DefineMethod('Drop',4,tkInteger,nil,__IDropTargetDrop,false,0).SetVarArgs([3]);
  end;
  With Scripter.DefineClass(IEnumOleVerb) do
  begin
    DefineMethod('Skip',1,tkInteger,nil,__IEnumOleVerbSkip,false,0);
    DefineMethod('Reset',0,tkInteger,nil,__IEnumOleVerbReset,false,0);
    DefineMethod('Clone',1,tkInteger,nil,__IEnumOleVerbClone,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IOleDocumentView) do
  begin
    DefineMethod('SetInPlaceSite',1,tkInteger,nil,__IOleDocumentViewSetInPlaceSite,false,0);
    DefineMethod('GetInPlaceSite',1,tkInteger,nil,__IOleDocumentViewGetInPlaceSite,false,0).SetVarArgs([0]);
    DefineMethod('GetDocument',1,tkInteger,nil,__IOleDocumentViewGetDocument,false,0).SetVarArgs([0]);
    DefineMethod('SetRect',1,tkInteger,nil,__IOleDocumentViewSetRect,false,0);
    DefineMethod('GetRect',1,tkInteger,nil,__IOleDocumentViewGetRect,false,0).SetVarArgs([0]);
    DefineMethod('SetRectComplex',4,tkInteger,nil,__IOleDocumentViewSetRectComplex,false,0);
    DefineMethod('Show',1,tkInteger,nil,__IOleDocumentViewShow,false,0);
    DefineMethod('UIActivate',1,tkInteger,nil,__IOleDocumentViewUIActivate,false,0);
    DefineMethod('Open',0,tkInteger,nil,__IOleDocumentViewOpen,false,0);
    DefineMethod('CloseView',1,tkInteger,nil,__IOleDocumentViewCloseView,false,0);
    DefineMethod('SaveViewState',1,tkInteger,nil,__IOleDocumentViewSaveViewState,false,0);
    DefineMethod('ApplyViewState',1,tkInteger,nil,__IOleDocumentViewApplyViewState,false,0);
    DefineMethod('Clone',2,tkInteger,nil,__IOleDocumentViewClone,false,0).SetVarArgs([1]);
  end;
  With Scripter.DefineClass(IEnumOleDocumentViews) do
  begin
    DefineMethod('Next',3,tkInteger,nil,__IEnumOleDocumentViewsNext,false,0).SetVarArgs([1,2]);
    DefineMethod('Skip',1,tkInteger,nil,__IEnumOleDocumentViewsSkip,false,0);
    DefineMethod('Reset',0,tkInteger,nil,__IEnumOleDocumentViewsReset,false,0);
    DefineMethod('Clone',1,tkInteger,nil,__IEnumOleDocumentViewsClone,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IOleDocument) do
  begin
    DefineMethod('CreateView',4,tkInteger,nil,__IOleDocumentCreateView,false,0).SetVarArgs([3]);
    DefineMethod('GetDocMiscStatus',1,tkInteger,nil,__IOleDocumentGetDocMiscStatus,false,0).SetVarArgs([0]);
    DefineMethod('EnumViews',2,tkInteger,nil,__IOleDocumentEnumViews,false,0).SetVarArgs([0,1]);
  end;
  With Scripter.DefineClass(IOleDocumentSite) do
  begin
    DefineMethod('ActivateMe',1,tkInteger,nil,__IOleDocumentSiteActivateMe,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('Succeeded',1,tkVariant,nil,__Succeeded,false,0);
    DefineMethod('Failed',1,tkVariant,nil,__Failed,false,0);
    DefineMethod('ResultCode',1,tkInteger,nil,__ResultCode,false,0);
    DefineMethod('ResultFacility',1,tkInteger,nil,__ResultFacility,false,0);
    DefineMethod('ResultSeverity',1,tkInteger,nil,__ResultSeverity,false,0);
    DefineMethod('MakeResult',3,tkInteger,nil,__MakeResult,false,0);
    DefineMethod('IsEqualGUID',2,tkVariant,nil,__IsEqualGUID,false,0);
    DefineMethod('IsEqualIID',2,tkVariant,nil,__IsEqualIID,false,0);
    DefineMethod('IsEqualCLSID',2,tkVariant,nil,__IsEqualCLSID,false,0);
    DefineMethod('CoBuildVersion',0,tkInteger,nil,__CoBuildVersion,false,0);
    DefineMethod('CoUninitialize',0,tkNone,nil,__CoUninitialize,false,0);
    DefineMethod('CoGetMalloc',2,tkInteger,nil,__CoGetMalloc,false,0).SetVarArgs([1]);
    DefineMethod('CoGetCurrentProcess',0,tkInteger,nil,__CoGetCurrentProcess,false,0);
    DefineMethod('CoRegisterMallocSpy',1,tkInteger,nil,__CoRegisterMallocSpy,false,0);
    DefineMethod('CoRevokeMallocSpy',0,tkInteger,nil,__CoRevokeMallocSpy,false,0);
    DefineMethod('CoRegisterClassObject',5,tkInteger,nil,__CoRegisterClassObject,false,0).SetVarArgs([4]);
    DefineMethod('CoRevokeClassObject',1,tkInteger,nil,__CoRevokeClassObject,false,0);
    DefineMethod('CoUnmarshalInterface',3,tkInteger,nil,__CoUnmarshalInterface,false,0).SetVarArgs([2]);
    DefineMethod('CoReleaseMarshalData',1,tkInteger,nil,__CoReleaseMarshalData,false,0);
    DefineMethod('CoDisconnectObject',2,tkInteger,nil,__CoDisconnectObject,false,0);
    DefineMethod('CoLockObjectExternal',3,tkInteger,nil,__CoLockObjectExternal,false,0);
    DefineMethod('CoIsHandlerConnected',1,tkVariant,nil,__CoIsHandlerConnected,false,0);
    DefineMethod('CoMarshalInterThreadInterfaceInStream',3,tkInteger,nil,__CoMarshalInterThreadInterfaceInStream,false,0).SetVarArgs([2]);
    DefineMethod('CoGetInterfaceAndReleaseStream',3,tkInteger,nil,__CoGetInterfaceAndReleaseStream,false,0).SetVarArgs([2]);
    DefineMethod('CoCreateFreeThreadedMarshaler',2,tkInteger,nil,__CoCreateFreeThreadedMarshaler,false,0).SetVarArgs([1]);
    DefineMethod('CoLoadLibrary',2,tkInteger,nil,__CoLoadLibrary,false,0);
    DefineMethod('CoFreeLibrary',1,tkNone,nil,__CoFreeLibrary,false,0);
    DefineMethod('CoFreeAllLibraries',0,tkNone,nil,__CoFreeAllLibraries,false,0);
    DefineMethod('CoFreeUnusedLibraries',0,tkNone,nil,__CoFreeUnusedLibraries,false,0);
    DefineMethod('CoCreateInstance',5,tkInteger,nil,__CoCreateInstance,false,0).SetVarArgs([4]);
    DefineMethod('StringFromCLSID',2,tkInteger,nil,__StringFromCLSID,false,0).SetVarArgs([1]);
    DefineMethod('CLSIDFromString',2,tkInteger,nil,__CLSIDFromString,false,0).SetVarArgs([1]);
    DefineMethod('StringFromIID',2,tkInteger,nil,__StringFromIID,false,0).SetVarArgs([1]);
    DefineMethod('IIDFromString',2,tkInteger,nil,__IIDFromString,false,0).SetVarArgs([1]);
    DefineMethod('CoIsOle1Class',1,tkVariant,nil,__CoIsOle1Class,false,0);
    DefineMethod('ProgIDFromCLSID',2,tkInteger,nil,__ProgIDFromCLSID,false,0).SetVarArgs([1]);
    DefineMethod('CLSIDFromProgID',2,tkInteger,nil,__CLSIDFromProgID,false,0).SetVarArgs([1]);
    DefineMethod('StringFromGUID2',3,tkInteger,nil,__StringFromGUID2,false,0);
    DefineMethod('CoCreateGuid',1,tkInteger,nil,__CoCreateGuid,false,0).SetVarArgs([0]);
    DefineMethod('CoFileTimeToDosDateTime',3,tkVariant,nil,__CoFileTimeToDosDateTime,false,0).SetVarArgs([0,1,2]);
    DefineMethod('CoDosDateTimeToFileTime',3,tkVariant,nil,__CoDosDateTimeToFileTime,false,0).SetVarArgs([2]);
    DefineMethod('CoFileTimeNow',1,tkInteger,nil,__CoFileTimeNow,false,0).SetVarArgs([0]);
    DefineMethod('CoRegisterMessageFilter',2,tkInteger,nil,__CoRegisterMessageFilter,false,0).SetVarArgs([1]);
    DefineMethod('CoGetTreatAsClass',2,tkInteger,nil,__CoGetTreatAsClass,false,0).SetVarArgs([1]);
    DefineMethod('CoTreatAsClass',2,tkInteger,nil,__CoTreatAsClass,false,0);
    DefineMethod('CreateDataAdviseHolder',1,tkInteger,nil,__CreateDataAdviseHolder,false,0).SetVarArgs([0]);
    DefineMethod('CreateDataCache',4,tkInteger,nil,__CreateDataCache,false,0).SetVarArgs([3]);
    DefineMethod('StgCreateDocfile',4,tkInteger,nil,__StgCreateDocfile,false,0).SetVarArgs([3]);
    DefineMethod('StgCreateDocfileOnILockBytes',4,tkInteger,nil,__StgCreateDocfileOnILockBytes,false,0).SetVarArgs([3]);
    DefineMethod('StgIsStorageFile',1,tkInteger,nil,__StgIsStorageFile,false,0);
    DefineMethod('StgIsStorageILockBytes',1,tkInteger,nil,__StgIsStorageILockBytes,false,0);
    DefineMethod('StgSetTimes',4,tkInteger,nil,__StgSetTimes,false,0);
    DefineMethod('BindMoniker',4,tkInteger,nil,__BindMoniker,false,0).SetVarArgs([3]);
    DefineMethod('MkParseDisplayName',4,tkInteger,nil,__MkParseDisplayName,false,0).SetVarArgs([2,3]);
    DefineMethod('MonikerRelativePathTo',4,tkInteger,nil,__MonikerRelativePathTo,false,0).SetVarArgs([2]);
    DefineMethod('MonikerCommonPrefixWith',3,tkInteger,nil,__MonikerCommonPrefixWith,false,0).SetVarArgs([2]);
    DefineMethod('CreateBindCtx',2,tkInteger,nil,__CreateBindCtx,false,0).SetVarArgs([1]);
    DefineMethod('CreateGenericComposite',3,tkInteger,nil,__CreateGenericComposite,false,0).SetVarArgs([2]);
    DefineMethod('GetClassFile',2,tkInteger,nil,__GetClassFile,false,0).SetVarArgs([1]);
    DefineMethod('CreateFileMoniker',2,tkInteger,nil,__CreateFileMoniker,false,0).SetVarArgs([1]);
    DefineMethod('CreateItemMoniker',3,tkInteger,nil,__CreateItemMoniker,false,0).SetVarArgs([2]);
    DefineMethod('CreateAntiMoniker',1,tkInteger,nil,__CreateAntiMoniker,false,0).SetVarArgs([0]);
    DefineMethod('CreatePointerMoniker',2,tkInteger,nil,__CreatePointerMoniker,false,0).SetVarArgs([1]);
    DefineMethod('GetRunningObjectTable',2,tkInteger,nil,__GetRunningObjectTable,false,0).SetVarArgs([1]);
    DefineMethod('SysAllocString',1,tkVariant,nil,__SysAllocString,false,0);
    DefineMethod('SysReAllocString',2,tkInteger,nil,__SysReAllocString,false,0).SetVarArgs([0]);
    DefineMethod('SysAllocStringLen',2,tkVariant,nil,__SysAllocStringLen,false,0);
    DefineMethod('SysReAllocStringLen',3,tkInteger,nil,__SysReAllocStringLen,false,0).SetVarArgs([0]);
    DefineMethod('SysFreeString',1,tkNone,nil,__SysFreeString,false,0);
    DefineMethod('SysStringLen',1,tkInteger,nil,__SysStringLen,false,0);
    DefineMethod('SysStringByteLen',1,tkInteger,nil,__SysStringByteLen,false,0);
    DefineMethod('SysAllocStringByteLen',2,tkVariant,nil,__SysAllocStringByteLen,false,0);
    DefineMethod('DosDateTimeToVariantTime',3,tkInteger,nil,__DosDateTimeToVariantTime,false,0).SetVarArgs([2]);
    DefineMethod('VariantTimeToDosDateTime',3,tkInteger,nil,__VariantTimeToDosDateTime,false,0).SetVarArgs([1,2]);
    DefineMethod('VariantInit',1,tkNone,nil,__VariantInit,false,0).SetVarArgs([0]);
    DefineMethod('VariantClear',1,tkInteger,nil,__VariantClear,false,0).SetVarArgs([0]);
    DefineMethod('VariantCopy',2,tkInteger,nil,__VariantCopy,false,0).SetVarArgs([0]);
    DefineMethod('VariantCopyInd',2,tkInteger,nil,__VariantCopyInd,false,0).SetVarArgs([0]);
    DefineMethod('VariantChangeType',4,tkInteger,nil,__VariantChangeType,false,0).SetVarArgs([0]);
    DefineMethod('VariantChangeTypeEx',5,tkInteger,nil,__VariantChangeTypeEx,false,0).SetVarArgs([0]);
    DefineMethod('VarUI1FromI2',2,tkInteger,nil,__VarUI1FromI2,false,0).SetVarArgs([1]);
    DefineMethod('VarUI1FromI4',2,tkInteger,nil,__VarUI1FromI4,false,0).SetVarArgs([1]);
    DefineMethod('VarUI1FromR4',2,tkInteger,nil,__VarUI1FromR4,false,0).SetVarArgs([1]);
    DefineMethod('VarUI1FromR8',2,tkInteger,nil,__VarUI1FromR8,false,0).SetVarArgs([1]);
    DefineMethod('VarUI1FromCy',2,tkInteger,nil,__VarUI1FromCy,false,0).SetVarArgs([1]);
    DefineMethod('VarUI1FromDate',2,tkInteger,nil,__VarUI1FromDate,false,0).SetVarArgs([1]);
    DefineMethod('VarUI1FromStr',4,tkInteger,nil,__VarUI1FromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarUI1FromDisp',3,tkInteger,nil,__VarUI1FromDisp,false,0).SetVarArgs([2]);
    DefineMethod('VarUI1FromBool',2,tkInteger,nil,__VarUI1FromBool,false,0).SetVarArgs([1]);
    DefineMethod('VarI2FromUI1',2,tkInteger,nil,__VarI2FromUI1,false,0).SetVarArgs([1]);
    DefineMethod('VarI2FromI4',2,tkInteger,nil,__VarI2FromI4,false,0).SetVarArgs([1]);
    DefineMethod('VarI2FromR4',2,tkInteger,nil,__VarI2FromR4,false,0).SetVarArgs([1]);
    DefineMethod('VarI2FromR8',2,tkInteger,nil,__VarI2FromR8,false,0).SetVarArgs([1]);
    DefineMethod('VarI2FromCy',2,tkInteger,nil,__VarI2FromCy,false,0).SetVarArgs([1]);
    DefineMethod('VarI2FromDate',2,tkInteger,nil,__VarI2FromDate,false,0).SetVarArgs([1]);
    DefineMethod('VarI2FromStr',4,tkInteger,nil,__VarI2FromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarI2FromDisp',3,tkInteger,nil,__VarI2FromDisp,false,0).SetVarArgs([2]);
    DefineMethod('VarI2FromBool',2,tkInteger,nil,__VarI2FromBool,false,0).SetVarArgs([1]);
    DefineMethod('VarI4FromUI1',2,tkInteger,nil,__VarI4FromUI1,false,0).SetVarArgs([1]);
    DefineMethod('VarI4FromI2',2,tkInteger,nil,__VarI4FromI2,false,0).SetVarArgs([1]);
    DefineMethod('VarI4FromR4',2,tkInteger,nil,__VarI4FromR4,false,0).SetVarArgs([1]);
    DefineMethod('VarI4FromR8',2,tkInteger,nil,__VarI4FromR8,false,0).SetVarArgs([1]);
    DefineMethod('VarI4FromCy',2,tkInteger,nil,__VarI4FromCy,false,0).SetVarArgs([1]);
    DefineMethod('VarI4FromDate',2,tkInteger,nil,__VarI4FromDate,false,0).SetVarArgs([1]);
    DefineMethod('VarI4FromStr',4,tkInteger,nil,__VarI4FromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarI4FromDisp',3,tkInteger,nil,__VarI4FromDisp,false,0).SetVarArgs([2]);
    DefineMethod('VarI4FromBool',2,tkInteger,nil,__VarI4FromBool,false,0).SetVarArgs([1]);
    DefineMethod('VarR4FromUI1',2,tkInteger,nil,__VarR4FromUI1,false,0).SetVarArgs([1]);
    DefineMethod('VarR4FromI2',2,tkInteger,nil,__VarR4FromI2,false,0).SetVarArgs([1]);
    DefineMethod('VarR4FromI4',2,tkInteger,nil,__VarR4FromI4,false,0).SetVarArgs([1]);
    DefineMethod('VarR4FromR8',2,tkInteger,nil,__VarR4FromR8,false,0).SetVarArgs([1]);
    DefineMethod('VarR4FromCy',2,tkInteger,nil,__VarR4FromCy,false,0).SetVarArgs([1]);
    DefineMethod('VarR4FromDate',2,tkInteger,nil,__VarR4FromDate,false,0).SetVarArgs([1]);
    DefineMethod('VarR4FromStr',4,tkInteger,nil,__VarR4FromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarR4FromDisp',3,tkInteger,nil,__VarR4FromDisp,false,0).SetVarArgs([2]);
    DefineMethod('VarR4FromBool',2,tkInteger,nil,__VarR4FromBool,false,0).SetVarArgs([1]);
    DefineMethod('VarR8FromUI1',2,tkInteger,nil,__VarR8FromUI1,false,0).SetVarArgs([1]);
    DefineMethod('VarR8FromI2',2,tkInteger,nil,__VarR8FromI2,false,0).SetVarArgs([1]);
    DefineMethod('VarR8FromI4',2,tkInteger,nil,__VarR8FromI4,false,0).SetVarArgs([1]);
    DefineMethod('VarR8FromR4',2,tkInteger,nil,__VarR8FromR4,false,0).SetVarArgs([1]);
    DefineMethod('VarR8FromCy',2,tkInteger,nil,__VarR8FromCy,false,0).SetVarArgs([1]);
    DefineMethod('VarR8FromDate',2,tkInteger,nil,__VarR8FromDate,false,0).SetVarArgs([1]);
    DefineMethod('VarR8FromStr',4,tkInteger,nil,__VarR8FromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarR8FromDisp',3,tkInteger,nil,__VarR8FromDisp,false,0).SetVarArgs([2]);
    DefineMethod('VarR8FromBool',2,tkInteger,nil,__VarR8FromBool,false,0).SetVarArgs([1]);
    DefineMethod('VarDateFromUI1',2,tkInteger,nil,__VarDateFromUI1,false,0).SetVarArgs([1]);
    DefineMethod('VarDateFromI2',2,tkInteger,nil,__VarDateFromI2,false,0).SetVarArgs([1]);
    DefineMethod('VarDateFromI4',2,tkInteger,nil,__VarDateFromI4,false,0).SetVarArgs([1]);
    DefineMethod('VarDateFromR4',2,tkInteger,nil,__VarDateFromR4,false,0).SetVarArgs([1]);
    DefineMethod('VarDateFromR8',2,tkInteger,nil,__VarDateFromR8,false,0).SetVarArgs([1]);
    DefineMethod('VarDateFromCy',2,tkInteger,nil,__VarDateFromCy,false,0).SetVarArgs([1]);
    DefineMethod('VarDateFromStr',4,tkInteger,nil,__VarDateFromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarDateFromDisp',3,tkInteger,nil,__VarDateFromDisp,false,0).SetVarArgs([2]);
    DefineMethod('VarDateFromBool',2,tkInteger,nil,__VarDateFromBool,false,0).SetVarArgs([1]);
    DefineMethod('VarCyFromUI1',2,tkInteger,nil,__VarCyFromUI1,false,0).SetVarArgs([1]);
    DefineMethod('VarCyFromI2',2,tkInteger,nil,__VarCyFromI2,false,0).SetVarArgs([1]);
    DefineMethod('VarCyFromI4',2,tkInteger,nil,__VarCyFromI4,false,0).SetVarArgs([1]);
    DefineMethod('VarCyFromR4',2,tkInteger,nil,__VarCyFromR4,false,0).SetVarArgs([1]);
    DefineMethod('VarCyFromR8',2,tkInteger,nil,__VarCyFromR8,false,0).SetVarArgs([1]);
    DefineMethod('VarCyFromDate',2,tkInteger,nil,__VarCyFromDate,false,0).SetVarArgs([1]);
    DefineMethod('VarCyFromStr',4,tkInteger,nil,__VarCyFromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarCyFromDisp',3,tkInteger,nil,__VarCyFromDisp,false,0).SetVarArgs([2]);
    DefineMethod('VarCyFromBool',2,tkInteger,nil,__VarCyFromBool,false,0).SetVarArgs([1]);
    DefineMethod('VarBoolFromUI1',2,tkInteger,nil,__VarBoolFromUI1,false,0).SetVarArgs([1]);
    DefineMethod('VarBoolFromI2',2,tkInteger,nil,__VarBoolFromI2,false,0).SetVarArgs([1]);
    DefineMethod('VarBoolFromI4',2,tkInteger,nil,__VarBoolFromI4,false,0).SetVarArgs([1]);
    DefineMethod('VarBoolFromR4',2,tkInteger,nil,__VarBoolFromR4,false,0).SetVarArgs([1]);
    DefineMethod('VarBoolFromR8',2,tkInteger,nil,__VarBoolFromR8,false,0).SetVarArgs([1]);
    DefineMethod('VarBoolFromDate',2,tkInteger,nil,__VarBoolFromDate,false,0).SetVarArgs([1]);
    DefineMethod('VarBoolFromCy',2,tkInteger,nil,__VarBoolFromCy,false,0).SetVarArgs([1]);
    DefineMethod('VarBoolFromStr',4,tkInteger,nil,__VarBoolFromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarBoolFromDisp',3,tkInteger,nil,__VarBoolFromDisp,false,0).SetVarArgs([2]);
    DefineMethod('LHashValOfNameSys',3,tkInteger,nil,__LHashValOfNameSys,false,0);
    DefineMethod('LHashValOfNameSysA',3,tkInteger,nil,__LHashValOfNameSysA,false,0);
    DefineMethod('LHashValOfName',2,tkInteger,nil,__LHashValOfName,false,0);
    DefineMethod('WHashValOfLHashVal',1,tkInteger,nil,__WHashValOfLHashVal,false,0);
    DefineMethod('IsHashValCompatible',2,tkVariant,nil,__IsHashValCompatible,false,0);
    DefineMethod('LoadTypeLib',2,tkInteger,nil,__LoadTypeLib,false,0).SetVarArgs([1]);
    DefineMethod('LoadRegTypeLib',5,tkInteger,nil,__LoadRegTypeLib,false,0).SetVarArgs([4]);
    DefineMethod('QueryPathOfRegTypeLib',5,tkInteger,nil,__QueryPathOfRegTypeLib,false,0).SetVarArgs([4]);
    DefineMethod('RegisterTypeLib',3,tkInteger,nil,__RegisterTypeLib,false,0);
    DefineMethod('CreateTypeLib',3,tkInteger,nil,__CreateTypeLib,false,0).SetVarArgs([2]);
    DefineMethod('DispGetParam',5,tkInteger,nil,__DispGetParam,false,0).SetVarArgs([0,3,4]);
    DefineMethod('DispGetIDsOfNames',4,tkInteger,nil,__DispGetIDsOfNames,false,0).SetVarArgs([1,3]);
    DefineMethod('CreateDispTypeInfo',3,tkInteger,nil,__CreateDispTypeInfo,false,0).SetVarArgs([0,2]);
    DefineMethod('RegisterActiveObject',4,tkInteger,nil,__RegisterActiveObject,false,0).SetVarArgs([3]);
    DefineMethod('SetErrorInfo',2,tkInteger,nil,__SetErrorInfo,false,0);
    DefineMethod('GetErrorInfo',2,tkInteger,nil,__GetErrorInfo,false,0).SetVarArgs([1]);
    DefineMethod('CreateErrorInfo',1,tkInteger,nil,__CreateErrorInfo,false,0).SetVarArgs([0]);
    DefineMethod('OaBuildVersion',0,tkInteger,nil,__OaBuildVersion,false,0);
    DefineMethod('OleBuildVersion',0,tkInteger,nil,__OleBuildVersion,false,0);
    DefineMethod('ReadClassStg',2,tkInteger,nil,__ReadClassStg,false,0).SetVarArgs([1]);
    DefineMethod('WriteClassStg',2,tkInteger,nil,__WriteClassStg,false,0);
    DefineMethod('ReadClassStm',2,tkInteger,nil,__ReadClassStm,false,0).SetVarArgs([1]);
    DefineMethod('WriteClassStm',2,tkInteger,nil,__WriteClassStm,false,0);
    DefineMethod('WriteFmtUserTypeStg',3,tkInteger,nil,__WriteFmtUserTypeStg,false,0);
    DefineMethod('ReadFmtUserTypeStg',3,tkInteger,nil,__ReadFmtUserTypeStg,false,0).SetVarArgs([1,2]);
    DefineMethod('OleUninitialize',0,tkNone,nil,__OleUninitialize,false,0);
    DefineMethod('OleQueryLinkFromData',1,tkInteger,nil,__OleQueryLinkFromData,false,0);
    DefineMethod('OleQueryCreateFromData',1,tkInteger,nil,__OleQueryCreateFromData,false,0);
    DefineMethod('OleLoad',4,tkInteger,nil,__OleLoad,false,0).SetVarArgs([3]);
    DefineMethod('OleSave',3,tkInteger,nil,__OleSave,false,0);
    DefineMethod('OleLoadFromStream',3,tkInteger,nil,__OleLoadFromStream,false,0).SetVarArgs([2]);
    DefineMethod('OleSaveToStream',2,tkInteger,nil,__OleSaveToStream,false,0);
    DefineMethod('OleSetContainedObject',2,tkInteger,nil,__OleSetContainedObject,false,0);
    DefineMethod('OleNoteObjectVisible',2,tkInteger,nil,__OleNoteObjectVisible,false,0);
    DefineMethod('RegisterDragDrop',2,tkInteger,nil,__RegisterDragDrop,false,0);
    DefineMethod('RevokeDragDrop',1,tkInteger,nil,__RevokeDragDrop,false,0);
    DefineMethod('DoDragDrop',4,tkInteger,nil,__DoDragDrop,false,0).SetVarArgs([3]);
    DefineMethod('OleSetClipboard',1,tkInteger,nil,__OleSetClipboard,false,0);
    DefineMethod('OleGetClipboard',1,tkInteger,nil,__OleGetClipboard,false,0).SetVarArgs([0]);
    DefineMethod('OleFlushClipboard',0,tkInteger,nil,__OleFlushClipboard,false,0);
    DefineMethod('OleIsCurrentClipboard',1,tkInteger,nil,__OleIsCurrentClipboard,false,0);
    DefineMethod('OleCreateMenuDescriptor',2,tkInteger,nil,__OleCreateMenuDescriptor,false,0).SetVarArgs([1]);
    DefineMethod('OleSetMenuDescriptor',5,tkInteger,nil,__OleSetMenuDescriptor,false,0);
    DefineMethod('OleDestroyMenuDescriptor',1,tkInteger,nil,__OleDestroyMenuDescriptor,false,0);
    DefineMethod('OleDuplicateData',3,tkInteger,nil,__OleDuplicateData,false,0);
    DefineMethod('OleDraw',4,tkInteger,nil,__OleDraw,false,0);
    DefineMethod('OleRun',1,tkInteger,nil,__OleRun,false,0);
    DefineMethod('OleIsRunning',1,tkVariant,nil,__OleIsRunning,false,0);
    DefineMethod('OleLockRunning',3,tkInteger,nil,__OleLockRunning,false,0);
    DefineMethod('ReleaseStgMedium',1,tkNone,nil,__ReleaseStgMedium,false,0).SetVarArgs([0]);
    DefineMethod('CreateOleAdviseHolder',1,tkInteger,nil,__CreateOleAdviseHolder,false,0).SetVarArgs([0]);
    DefineMethod('OleCreateDefaultHandler',4,tkInteger,nil,__OleCreateDefaultHandler,false,0).SetVarArgs([3]);
    DefineMethod('OleCreateEmbeddingHelper',6,tkInteger,nil,__OleCreateEmbeddingHelper,false,0).SetVarArgs([5]);
    DefineMethod('OleGetIconOfFile',2,tkInteger,nil,__OleGetIconOfFile,false,0);
    DefineMethod('OleGetIconOfClass',3,tkInteger,nil,__OleGetIconOfClass,false,0);
    DefineMethod('OleMetafilePictFromIconAndLabel',4,tkInteger,nil,__OleMetafilePictFromIconAndLabel,false,0);
    DefineMethod('OleRegGetUserType',3,tkInteger,nil,__OleRegGetUserType,false,0).SetVarArgs([2]);
    DefineMethod('OleRegGetMiscStatus',3,tkInteger,nil,__OleRegGetMiscStatus,false,0).SetVarArgs([2]);
    DefineMethod('OleRegEnumFormatEtc',3,tkInteger,nil,__OleRegEnumFormatEtc,false,0).SetVarArgs([2]);
    DefineMethod('OleRegEnumVerbs',2,tkInteger,nil,__OleRegEnumVerbs,false,0).SetVarArgs([1]);
    DefineMethod('GetHGlobalFromILockBytes',2,tkInteger,nil,__GetHGlobalFromILockBytes,false,0).SetVarArgs([1]);
    DefineMethod('CreateILockBytesOnHGlobal',3,tkInteger,nil,__CreateILockBytesOnHGlobal,false,0).SetVarArgs([2]);
    DefineMethod('GetHGlobalFromStream',2,tkInteger,nil,__GetHGlobalFromStream,false,0).SetVarArgs([1]);
    DefineMethod('CreateStreamOnHGlobal',3,tkInteger,nil,__CreateStreamOnHGlobal,false,0).SetVarArgs([2]);
    DefineMethod('OleDoAutoConvert',2,tkInteger,nil,__OleDoAutoConvert,false,0).SetVarArgs([1]);
    DefineMethod('OleGetAutoConvert',2,tkInteger,nil,__OleGetAutoConvert,false,0).SetVarArgs([1]);
    DefineMethod('OleSetAutoConvert',2,tkInteger,nil,__OleSetAutoConvert,false,0);
    DefineMethod('GetConvertStg',1,tkInteger,nil,__GetConvertStg,false,0);
    DefineMethod('SetConvertStg',2,tkInteger,nil,__SetConvertStg,false,0);
    DefineProp('GUID_NULL',tkVariant,__GetGUID_NULL,nil,nil,false,0);
    DefineProp('IID_IUnknown',tkVariant,__GetIID_IUnknown,nil,nil,false,0);
    DefineProp('IID_IClassFactory',tkVariant,__GetIID_IClassFactory,nil,nil,false,0);
    DefineProp('IID_IMarshal',tkVariant,__GetIID_IMarshal,nil,nil,false,0);
    DefineProp('IID_IMalloc',tkVariant,__GetIID_IMalloc,nil,nil,false,0);
    DefineProp('IID_IStdMarshalInfo',tkVariant,__GetIID_IStdMarshalInfo,nil,nil,false,0);
    DefineProp('IID_IExternalConnection',tkVariant,__GetIID_IExternalConnection,nil,nil,false,0);
    DefineProp('IID_IEnumUnknown',tkVariant,__GetIID_IEnumUnknown,nil,nil,false,0);
    DefineProp('IID_IBindCtx',tkVariant,__GetIID_IBindCtx,nil,nil,false,0);
    DefineProp('IID_IEnumMoniker',tkVariant,__GetIID_IEnumMoniker,nil,nil,false,0);
    DefineProp('IID_IRunnableObject',tkVariant,__GetIID_IRunnableObject,nil,nil,false,0);
    DefineProp('IID_IRunningObjectTable',tkVariant,__GetIID_IRunningObjectTable,nil,nil,false,0);
    DefineProp('IID_IPersist',tkVariant,__GetIID_IPersist,nil,nil,false,0);
    DefineProp('IID_IPersistStream',tkVariant,__GetIID_IPersistStream,nil,nil,false,0);
    DefineProp('IID_IMoniker',tkVariant,__GetIID_IMoniker,nil,nil,false,0);
    DefineProp('IID_IEnumString',tkVariant,__GetIID_IEnumString,nil,nil,false,0);
    DefineProp('IID_IStream',tkVariant,__GetIID_IStream,nil,nil,false,0);
    DefineProp('IID_IEnumStatStg',tkVariant,__GetIID_IEnumStatStg,nil,nil,false,0);
    DefineProp('IID_IStorage',tkVariant,__GetIID_IStorage,nil,nil,false,0);
    DefineProp('IID_IPersistFile',tkVariant,__GetIID_IPersistFile,nil,nil,false,0);
    DefineProp('IID_IPersistStorage',tkVariant,__GetIID_IPersistStorage,nil,nil,false,0);
    DefineProp('IID_ILockBytes',tkVariant,__GetIID_ILockBytes,nil,nil,false,0);
    DefineProp('IID_IEnumFormatEtc',tkVariant,__GetIID_IEnumFormatEtc,nil,nil,false,0);
    DefineProp('IID_IEnumStatData',tkVariant,__GetIID_IEnumStatData,nil,nil,false,0);
    DefineProp('IID_IRootStorage',tkVariant,__GetIID_IRootStorage,nil,nil,false,0);
    DefineProp('IID_IAdviseSink',tkVariant,__GetIID_IAdviseSink,nil,nil,false,0);
    DefineProp('IID_IAdviseSink2',tkVariant,__GetIID_IAdviseSink2,nil,nil,false,0);
    DefineProp('IID_IDataObject',tkVariant,__GetIID_IDataObject,nil,nil,false,0);
    DefineProp('IID_IDataAdviseHolder',tkVariant,__GetIID_IDataAdviseHolder,nil,nil,false,0);
    DefineProp('IID_IMessageFilter',tkVariant,__GetIID_IMessageFilter,nil,nil,false,0);
    DefineProp('IID_IRpcChannelBuffer',tkVariant,__GetIID_IRpcChannelBuffer,nil,nil,false,0);
    DefineProp('IID_IRpcProxyBuffer',tkVariant,__GetIID_IRpcProxyBuffer,nil,nil,false,0);
    DefineProp('IID_IRpcStubBuffer',tkVariant,__GetIID_IRpcStubBuffer,nil,nil,false,0);
    DefineProp('IID_IPSFactoryBuffer',tkVariant,__GetIID_IPSFactoryBuffer,nil,nil,false,0);
    DefineProp('IID_ICreateTypeInfo',tkVariant,__GetIID_ICreateTypeInfo,nil,nil,false,0);
    DefineProp('IID_ICreateTypeLib',tkVariant,__GetIID_ICreateTypeLib,nil,nil,false,0);
    DefineProp('IID_IDispatch',tkVariant,__GetIID_IDispatch,nil,nil,false,0);
    DefineProp('IID_IEnumVariant',tkVariant,__GetIID_IEnumVariant,nil,nil,false,0);
    DefineProp('IID_ITypeComp',tkVariant,__GetIID_ITypeComp,nil,nil,false,0);
    DefineProp('IID_ITypeInfo',tkVariant,__GetIID_ITypeInfo,nil,nil,false,0);
    DefineProp('IID_ITypeLib',tkVariant,__GetIID_ITypeLib,nil,nil,false,0);
    DefineProp('IID_IErrorInfo',tkVariant,__GetIID_IErrorInfo,nil,nil,false,0);
    DefineProp('IID_ICreateErrorInfo',tkVariant,__GetIID_ICreateErrorInfo,nil,nil,false,0);
    DefineProp('IID_ISupportErrorInfo',tkVariant,__GetIID_ISupportErrorInfo,nil,nil,false,0);
    DefineProp('IID_IOleAdviseHolder',tkVariant,__GetIID_IOleAdviseHolder,nil,nil,false,0);
    DefineProp('IID_IOleCache',tkVariant,__GetIID_IOleCache,nil,nil,false,0);
    DefineProp('IID_IOleCache2',tkVariant,__GetIID_IOleCache2,nil,nil,false,0);
    DefineProp('IID_IOleCacheControl',tkVariant,__GetIID_IOleCacheControl,nil,nil,false,0);
    DefineProp('IID_IParseDisplayName',tkVariant,__GetIID_IParseDisplayName,nil,nil,false,0);
    DefineProp('IID_IOleContainer',tkVariant,__GetIID_IOleContainer,nil,nil,false,0);
    DefineProp('IID_IOleClientSite',tkVariant,__GetIID_IOleClientSite,nil,nil,false,0);
    DefineProp('IID_IOleObject',tkVariant,__GetIID_IOleObject,nil,nil,false,0);
    DefineProp('IID_IOleWindow',tkVariant,__GetIID_IOleWindow,nil,nil,false,0);
    DefineProp('IID_IOleLink',tkVariant,__GetIID_IOleLink,nil,nil,false,0);
    DefineProp('IID_IOleItemContainer',tkVariant,__GetIID_IOleItemContainer,nil,nil,false,0);
    DefineProp('IID_IOleInPlaceUIWindow',tkVariant,__GetIID_IOleInPlaceUIWindow,nil,nil,false,0);
    DefineProp('IID_IOleInPlaceActiveObject',tkVariant,__GetIID_IOleInPlaceActiveObject,nil,nil,false,0);
    DefineProp('IID_IOleInPlaceFrame',tkVariant,__GetIID_IOleInPlaceFrame,nil,nil,false,0);
    DefineProp('IID_IOleInPlaceObject',tkVariant,__GetIID_IOleInPlaceObject,nil,nil,false,0);
    DefineProp('IID_IOleInPlaceSite',tkVariant,__GetIID_IOleInPlaceSite,nil,nil,false,0);
    DefineProp('IID_IViewObject',tkVariant,__GetIID_IViewObject,nil,nil,false,0);
    DefineProp('IID_IViewObject2',tkVariant,__GetIID_IViewObject2,nil,nil,false,0);
    DefineProp('IID_IDropSource',tkVariant,__GetIID_IDropSource,nil,nil,false,0);
    DefineProp('IID_IDropTarget',tkVariant,__GetIID_IDropTarget,nil,nil,false,0);
    DefineProp('IID_IEnumOleVerb',tkVariant,__GetIID_IEnumOleVerb,nil,nil,false,0);
    DefineProp('IID_IRpcChannel',tkVariant,__GetIID_IRpcChannel,nil,nil,false,0);
    DefineProp('IID_IRpcStub',tkVariant,__GetIID_IRpcStub,nil,nil,false,0);
    DefineProp('IID_IStubManager',tkVariant,__GetIID_IStubManager,nil,nil,false,0);
    DefineProp('IID_IRpcProxy',tkVariant,__GetIID_IRpcProxy,nil,nil,false,0);
    DefineProp('IID_IProxyManager',tkVariant,__GetIID_IProxyManager,nil,nil,false,0);
    DefineProp('IID_IPSFactory',tkVariant,__GetIID_IPSFactory,nil,nil,false,0);
    DefineProp('IID_IInternalMoniker',tkVariant,__GetIID_IInternalMoniker,nil,nil,false,0);
    DefineProp('CLSID_StdMarshal',tkVariant,__GetCLSID_StdMarshal,nil,nil,false,0);
    DefineProp('IID_IEnumGeneric',tkVariant,__GetIID_IEnumGeneric,nil,nil,false,0);
    DefineProp('IID_IEnumHolder',tkVariant,__GetIID_IEnumHolder,nil,nil,false,0);
    DefineProp('IID_IEnumCallback',tkVariant,__GetIID_IEnumCallback,nil,nil,false,0);
    DefineProp('IID_IOleManager',tkVariant,__GetIID_IOleManager,nil,nil,false,0);
    DefineProp('IID_IOlePresObj',tkVariant,__GetIID_IOlePresObj,nil,nil,false,0);
    DefineProp('IID_IDebug',tkVariant,__GetIID_IDebug,nil,nil,false,0);
    DefineProp('IID_IDebugStream',tkVariant,__GetIID_IDebugStream,nil,nil,false,0);
    DefineProp('IID_IOleDocument',tkVariant,__GetIID_IOleDocument,nil,nil,false,0);
    DefineProp('IID_IOleDocumentSite',tkVariant,__GetIID_IOleDocumentSite,nil,nil,false,0);
    AddConstant('MEMCTX_TASK',MEMCTX_TASK);
    AddConstant('MEMCTX_SHARED',MEMCTX_SHARED);
    AddConstant('MEMCTX_MACSYSTEM',MEMCTX_MACSYSTEM);
    AddConstant('MEMCTX_UNKNOWN',MEMCTX_UNKNOWN);
    AddConstant('MEMCTX_SAME',MEMCTX_SAME);
    AddConstant('ROTFLAGS_REGISTRATIONKEEPSALIVE',ROTFLAGS_REGISTRATIONKEEPSALIVE);
    AddConstant('CLSCTX_INPROC_SERVER',CLSCTX_INPROC_SERVER);
    AddConstant('CLSCTX_INPROC_HANDLER',CLSCTX_INPROC_HANDLER);
    AddConstant('CLSCTX_LOCAL_SERVER',CLSCTX_LOCAL_SERVER);
    AddConstant('CLSCTX_INPROC_SERVER16',CLSCTX_INPROC_SERVER16);
    AddConstant('CLSCTX_ALL',CLSCTX_ALL);
    AddConstant('CLSCTX_INPROC',CLSCTX_INPROC);
    AddConstant('CLSCTX_SERVER',CLSCTX_SERVER);
    AddConstant('MSHLFLAGS_NORMAL',MSHLFLAGS_NORMAL);
    AddConstant('MSHLFLAGS_TABLESTRONG',MSHLFLAGS_TABLESTRONG);
    AddConstant('MSHLFLAGS_TABLEWEAK',MSHLFLAGS_TABLEWEAK);
    AddConstant('MSHCTX_LOCAL',MSHCTX_LOCAL);
    AddConstant('MSHCTX_NOSHAREDMEM',MSHCTX_NOSHAREDMEM);
    AddConstant('MSHCTX_DIFFERENTMACHINE',MSHCTX_DIFFERENTMACHINE);
    AddConstant('MSHCTX_INPROC',MSHCTX_INPROC);
    AddConstant('DVASPECT_CONTENT',DVASPECT_CONTENT);
    AddConstant('DVASPECT_THUMBNAIL',DVASPECT_THUMBNAIL);
    AddConstant('DVASPECT_ICON',DVASPECT_ICON);
    AddConstant('DVASPECT_DOCPRINT',DVASPECT_DOCPRINT);
    AddConstant('STGC_DEFAULT',STGC_DEFAULT);
    AddConstant('STGC_OVERWRITE',STGC_OVERWRITE);
    AddConstant('STGC_ONLYIFCURRENT',STGC_ONLYIFCURRENT);
    AddConstant('STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE',STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE);
    AddConstant('STGMOVE_MOVE',STGMOVE_MOVE);
    AddConstant('STGMOVE_COPY',STGMOVE_COPY);
    AddConstant('STATFLAG_DEFAULT',STATFLAG_DEFAULT);
    AddConstant('STATFLAG_NONAME',STATFLAG_NONAME);
    AddConstant('BIND_MAYBOTHERUSER',BIND_MAYBOTHERUSER);
    AddConstant('BIND_JUSTTESTEXISTENCE',BIND_JUSTTESTEXISTENCE);
    AddConstant('MKSYS_NONE',MKSYS_NONE);
    AddConstant('MKSYS_GENERICCOMPOSITE',MKSYS_GENERICCOMPOSITE);
    AddConstant('MKSYS_FILEMONIKER',MKSYS_FILEMONIKER);
    AddConstant('MKSYS_ANTIMONIKER',MKSYS_ANTIMONIKER);
    AddConstant('MKSYS_ITEMMONIKER',MKSYS_ITEMMONIKER);
    AddConstant('MKSYS_POINTERMONIKER',MKSYS_POINTERMONIKER);
    AddConstant('MKRREDUCE_ONE',MKRREDUCE_ONE);
    AddConstant('MKRREDUCE_TOUSER',MKRREDUCE_TOUSER);
    AddConstant('MKRREDUCE_THROUGHUSER',MKRREDUCE_THROUGHUSER);
    AddConstant('MKRREDUCE_ALL',MKRREDUCE_ALL);
    AddConstant('STGTY_STORAGE',STGTY_STORAGE);
    AddConstant('STGTY_STREAM',STGTY_STREAM);
    AddConstant('STGTY_LOCKBYTES',STGTY_LOCKBYTES);
    AddConstant('STGTY_PROPERTY',STGTY_PROPERTY);
    AddConstant('STREAM_SEEK_SET',STREAM_SEEK_SET);
    AddConstant('STREAM_SEEK_CUR',STREAM_SEEK_CUR);
    AddConstant('STREAM_SEEK_END',STREAM_SEEK_END);
    AddConstant('LOCK_WRITE',LOCK_WRITE);
    AddConstant('LOCK_EXCLUSIVE',LOCK_EXCLUSIVE);
    AddConstant('LOCK_ONLYONCE',LOCK_ONLYONCE);
    AddConstant('ADVF_NODATA',ADVF_NODATA);
    AddConstant('ADVF_PRIMEFIRST',ADVF_PRIMEFIRST);
    AddConstant('ADVF_ONLYONCE',ADVF_ONLYONCE);
    AddConstant('ADVF_DATAONSTOP',ADVF_DATAONSTOP);
    AddConstant('ADVFCACHE_NOHANDLER',ADVFCACHE_NOHANDLER);
    AddConstant('ADVFCACHE_FORCEBUILTIN',ADVFCACHE_FORCEBUILTIN);
    AddConstant('ADVFCACHE_ONSAVE',ADVFCACHE_ONSAVE);
    AddConstant('TYMED_HGLOBAL',TYMED_HGLOBAL);
    AddConstant('TYMED_FILE',TYMED_FILE);
    AddConstant('TYMED_ISTREAM',TYMED_ISTREAM);
    AddConstant('TYMED_ISTORAGE',TYMED_ISTORAGE);
    AddConstant('TYMED_GDI',TYMED_GDI);
    AddConstant('TYMED_MFPICT',TYMED_MFPICT);
    AddConstant('TYMED_ENHMF',TYMED_ENHMF);
    AddConstant('TYMED_NULL',TYMED_NULL);
    AddConstant('DATADIR_GET',DATADIR_GET);
    AddConstant('DATADIR_SET',DATADIR_SET);
    AddConstant('CALLTYPE_TOPLEVEL',CALLTYPE_TOPLEVEL);
    AddConstant('CALLTYPE_NESTED',CALLTYPE_NESTED);
    AddConstant('CALLTYPE_ASYNC',CALLTYPE_ASYNC);
    AddConstant('CALLTYPE_TOPLEVEL_CALLPENDING',CALLTYPE_TOPLEVEL_CALLPENDING);
    AddConstant('CALLTYPE_ASYNC_CALLPENDING',CALLTYPE_ASYNC_CALLPENDING);
    AddConstant('SERVERCALL_ISHANDLED',SERVERCALL_ISHANDLED);
    AddConstant('SERVERCALL_REJECTED',SERVERCALL_REJECTED);
    AddConstant('SERVERCALL_RETRYLATER',SERVERCALL_RETRYLATER);
    AddConstant('PENDINGTYPE_TOPLEVEL',PENDINGTYPE_TOPLEVEL);
    AddConstant('PENDINGTYPE_NESTED',PENDINGTYPE_NESTED);
    AddConstant('PENDINGMSG_CANCELCALL',PENDINGMSG_CANCELCALL);
    AddConstant('PENDINGMSG_WAITNOPROCESS',PENDINGMSG_WAITNOPROCESS);
    AddConstant('PENDINGMSG_WAITDEFPROCESS',PENDINGMSG_WAITDEFPROCESS);
    AddConstant('REGCLS_SINGLEUSE',REGCLS_SINGLEUSE);
    AddConstant('REGCLS_MULTIPLEUSE',REGCLS_MULTIPLEUSE);
    AddConstant('REGCLS_MULTI_SEPARATE',REGCLS_MULTI_SEPARATE);
    AddConstant('MARSHALINTERFACE_MIN',MARSHALINTERFACE_MIN);
    AddConstant('CWCSTORAGENAME',CWCSTORAGENAME);
    AddConstant('STGM_DIRECT',STGM_DIRECT);
    AddConstant('STGM_TRANSACTED',STGM_TRANSACTED);
    AddConstant('STGM_SIMPLE',STGM_SIMPLE);
    AddConstant('STGM_READ',STGM_READ);
    AddConstant('STGM_WRITE',STGM_WRITE);
    AddConstant('STGM_READWRITE',STGM_READWRITE);
    AddConstant('STGM_SHARE_DENY_NONE',STGM_SHARE_DENY_NONE);
    AddConstant('STGM_SHARE_DENY_READ',STGM_SHARE_DENY_READ);
    AddConstant('STGM_SHARE_DENY_WRITE',STGM_SHARE_DENY_WRITE);
    AddConstant('STGM_SHARE_EXCLUSIVE',STGM_SHARE_EXCLUSIVE);
    AddConstant('STGM_PRIORITY',STGM_PRIORITY);
    AddConstant('STGM_DELETEONRELEASE',STGM_DELETEONRELEASE);
    AddConstant('STGM_CREATE',STGM_CREATE);
    AddConstant('STGM_CONVERT',STGM_CONVERT);
    AddConstant('STGM_FAILIFTHERE',STGM_FAILIFTHERE);
    AddConstant('FADF_AUTO',FADF_AUTO);
    AddConstant('FADF_STATIC',FADF_STATIC);
    AddConstant('FADF_EMBEDDED',FADF_EMBEDDED);
    AddConstant('FADF_FIXEDSIZE',FADF_FIXEDSIZE);
    AddConstant('FADF_BSTR',FADF_BSTR);
    AddConstant('FADF_UNKNOWN',FADF_UNKNOWN);
    AddConstant('FADF_DISPATCH',FADF_DISPATCH);
    AddConstant('FADF_VARIANT',FADF_VARIANT);
    AddConstant('FADF_RESERVED',FADF_RESERVED);
    AddConstant('VT_EMPTY',VT_EMPTY);
    AddConstant('VT_NULL',VT_NULL);
    AddConstant('VT_I2',VT_I2);
    AddConstant('VT_I4',VT_I4);
    AddConstant('VT_R4',VT_R4);
    AddConstant('VT_R8',VT_R8);
    AddConstant('VT_CY',VT_CY);
    AddConstant('VT_DATE',VT_DATE);
    AddConstant('VT_BSTR',VT_BSTR);
    AddConstant('VT_DISPATCH',VT_DISPATCH);
    AddConstant('VT_ERROR',VT_ERROR);
    AddConstant('VT_BOOL',VT_BOOL);
    AddConstant('VT_VARIANT',VT_VARIANT);
    AddConstant('VT_UNKNOWN',VT_UNKNOWN);
    AddConstant('VT_I1',VT_I1);
    AddConstant('VT_UI1',VT_UI1);
    AddConstant('VT_UI2',VT_UI2);
    AddConstant('VT_UI4',VT_UI4);
    AddConstant('VT_I8',VT_I8);
    AddConstant('VT_UI8',VT_UI8);
    AddConstant('VT_INT',VT_INT);
    AddConstant('VT_UINT',VT_UINT);
    AddConstant('VT_VOID',VT_VOID);
    AddConstant('VT_HRESULT',VT_HRESULT);
    AddConstant('VT_PTR',VT_PTR);
    AddConstant('VT_SAFEARRAY',VT_SAFEARRAY);
    AddConstant('VT_CARRAY',VT_CARRAY);
    AddConstant('VT_USERDEFINED',VT_USERDEFINED);
    AddConstant('VT_LPSTR',VT_LPSTR);
    AddConstant('VT_LPWSTR',VT_LPWSTR);
    AddConstant('VT_FILETIME',VT_FILETIME);
    AddConstant('VT_BLOB',VT_BLOB);
    AddConstant('VT_STREAM',VT_STREAM);
    AddConstant('VT_STORAGE',VT_STORAGE);
    AddConstant('VT_STREAMED_OBJECT',VT_STREAMED_OBJECT);
    AddConstant('VT_STORED_OBJECT',VT_STORED_OBJECT);
    AddConstant('VT_BLOB_OBJECT',VT_BLOB_OBJECT);
    AddConstant('VT_CF',VT_CF);
    AddConstant('VT_CLSID',VT_CLSID);
    AddConstant('VT_VECTOR',VT_VECTOR);
    AddConstant('VT_ARRAY',VT_ARRAY);
    AddConstant('VT_BYREF',VT_BYREF);
    AddConstant('VT_RESERVED',VT_RESERVED);
    AddConstant('TKIND_ENUM',TKIND_ENUM);
    AddConstant('TKIND_RECORD',TKIND_RECORD);
    AddConstant('TKIND_MODULE',TKIND_MODULE);
    AddConstant('TKIND_INTERFACE',TKIND_INTERFACE);
    AddConstant('TKIND_DISPATCH',TKIND_DISPATCH);
    AddConstant('TKIND_COCLASS',TKIND_COCLASS);
    AddConstant('TKIND_ALIAS',TKIND_ALIAS);
    AddConstant('TKIND_UNION',TKIND_UNION);
    AddConstant('TKIND_MAX',TKIND_MAX);
    AddConstant('CC_CDECL',CC_CDECL);
    AddConstant('CC_PASCAL',CC_PASCAL);
    AddConstant('CC_MACPASCAL',CC_MACPASCAL);
    AddConstant('CC_STDCALL',CC_STDCALL);
    AddConstant('CC_RESERVED',CC_RESERVED);
    AddConstant('CC_SYSCALL',CC_SYSCALL);
    AddConstant('CC_MPWCDECL',CC_MPWCDECL);
    AddConstant('CC_MPWPASCAL',CC_MPWPASCAL);
    AddConstant('CC_MAX',CC_MAX);
    AddConstant('FUNC_VIRTUAL',FUNC_VIRTUAL);
    AddConstant('FUNC_PUREVIRTUAL',FUNC_PUREVIRTUAL);
    AddConstant('FUNC_NONVIRTUAL',FUNC_NONVIRTUAL);
    AddConstant('FUNC_STATIC',FUNC_STATIC);
    AddConstant('FUNC_DISPATCH',FUNC_DISPATCH);
    AddConstant('INVOKE_FUNC',INVOKE_FUNC);
    AddConstant('INVOKE_PROPERTYGET',INVOKE_PROPERTYGET);
    AddConstant('INVOKE_PROPERTYPUT',INVOKE_PROPERTYPUT);
    AddConstant('INVOKE_PROPERTYPUTREF',INVOKE_PROPERTYPUTREF);
    AddConstant('VAR_PERINSTANCE',VAR_PERINSTANCE);
    AddConstant('VAR_STATIC',VAR_STATIC);
    AddConstant('VAR_CONST',VAR_CONST);
    AddConstant('VAR_DISPATCH',VAR_DISPATCH);
    AddConstant('IMPLTYPEFLAG_FDEFAULT',IMPLTYPEFLAG_FDEFAULT);
    AddConstant('IMPLTYPEFLAG_FSOURCE',IMPLTYPEFLAG_FSOURCE);
    AddConstant('IMPLTYPEFLAG_FRESTRICTED',IMPLTYPEFLAG_FRESTRICTED);
    AddConstant('TYPEFLAG_FAPPOBJECT',TYPEFLAG_FAPPOBJECT);
    AddConstant('TYPEFLAG_FCANCREATE',TYPEFLAG_FCANCREATE);
    AddConstant('TYPEFLAG_FLICENSED',TYPEFLAG_FLICENSED);
    AddConstant('TYPEFLAG_FPREDECLID',TYPEFLAG_FPREDECLID);
    AddConstant('TYPEFLAG_FHIDDEN',TYPEFLAG_FHIDDEN);
    AddConstant('TYPEFLAG_FCONTROL',TYPEFLAG_FCONTROL);
    AddConstant('TYPEFLAG_FDUAL',TYPEFLAG_FDUAL);
    AddConstant('TYPEFLAG_FNONEXTENSIBLE',TYPEFLAG_FNONEXTENSIBLE);
    AddConstant('TYPEFLAG_FOLEAUTOMATION',TYPEFLAG_FOLEAUTOMATION);
    AddConstant('FUNCFLAG_FRESTRICTED',FUNCFLAG_FRESTRICTED);
    AddConstant('FUNCFLAG_FSOURCE',FUNCFLAG_FSOURCE);
    AddConstant('FUNCFLAG_FBINDABLE',FUNCFLAG_FBINDABLE);
    AddConstant('FUNCFLAG_FREQUESTEDIT',FUNCFLAG_FREQUESTEDIT);
    AddConstant('FUNCFLAG_FDISPLAYBIND',FUNCFLAG_FDISPLAYBIND);
    AddConstant('FUNCFLAG_FDEFAULTBIND',FUNCFLAG_FDEFAULTBIND);
    AddConstant('FUNCFLAG_FHIDDEN',FUNCFLAG_FHIDDEN);
    AddConstant('VARFLAG_FREADONLY',VARFLAG_FREADONLY);
    AddConstant('VARFLAG_FSOURCE',VARFLAG_FSOURCE);
    AddConstant('VARFLAG_FBINDABLE',VARFLAG_FBINDABLE);
    AddConstant('VARFLAG_FREQUESTEDIT',VARFLAG_FREQUESTEDIT);
    AddConstant('VARFLAG_FDISPLAYBIND',VARFLAG_FDISPLAYBIND);
    AddConstant('VARFLAG_FDEFAULTBIND',VARFLAG_FDEFAULTBIND);
    AddConstant('VARFLAG_FHIDDEN',VARFLAG_FHIDDEN);
    AddConstant('DISPID_VALUE',DISPID_VALUE);
    AddConstant('DISPID_UNKNOWN',DISPID_UNKNOWN);
    AddConstant('DISPID_PROPERTYPUT',DISPID_PROPERTYPUT);
    AddConstant('DISPID_NEWENUM',DISPID_NEWENUM);
    AddConstant('DISPID_EVALUATE',DISPID_EVALUATE);
    AddConstant('DISPID_CONSTRUCTOR',DISPID_CONSTRUCTOR);
    AddConstant('DISPID_DESTRUCTOR',DISPID_DESTRUCTOR);
    AddConstant('DISPID_COLLECT',DISPID_COLLECT);
    AddConstant('DESCKIND_NONE',DESCKIND_NONE);
    AddConstant('DESCKIND_FUNCDESC',DESCKIND_FUNCDESC);
    AddConstant('DESCKIND_VARDESC',DESCKIND_VARDESC);
    AddConstant('DESCKIND_TYPECOMP',DESCKIND_TYPECOMP);
    AddConstant('DESCKIND_IMPLICITAPPOBJ',DESCKIND_IMPLICITAPPOBJ);
    AddConstant('DESCKIND_MAX',DESCKIND_MAX);
    AddConstant('SYS_WIN16',SYS_WIN16);
    AddConstant('SYS_WIN32',SYS_WIN32);
    AddConstant('SYS_MAC',SYS_MAC);
    AddConstant('LIBFLAG_FRESTRICTED',LIBFLAG_FRESTRICTED);
    AddConstant('LIBFLAG_FCONTROL',LIBFLAG_FCONTROL);
    AddConstant('LIBFLAG_FHIDDEN',LIBFLAG_FHIDDEN);
    AddConstant('STDOLE_MAJORVERNUM',STDOLE_MAJORVERNUM);
    AddConstant('STDOLE_MINORVERNUM',STDOLE_MINORVERNUM);
    AddConstant('STDOLE_LCID',STDOLE_LCID);
    AddConstant('VARIANT_NOVALUEPROP',VARIANT_NOVALUEPROP);
    AddConstant('VAR_TIMEVALUEONLY',VAR_TIMEVALUEONLY);
    AddConstant('VAR_DATEVALUEONLY',VAR_DATEVALUEONLY);
    AddConstant('MEMBERID_NIL',MEMBERID_NIL);
    AddConstant('ID_DEFAULTINST',ID_DEFAULTINST);
    AddConstant('IDLFLAG_NONE',IDLFLAG_NONE);
    AddConstant('IDLFLAG_FIN',IDLFLAG_FIN);
    AddConstant('IDLFLAG_FOUT',IDLFLAG_FOUT);
    AddConstant('IDLFLAG_FLCID',IDLFLAG_FLCID);
    AddConstant('IDLFLAG_FRETVAL',IDLFLAG_FRETVAL);
    AddConstant('DISPATCH_METHOD',DISPATCH_METHOD);
    AddConstant('DISPATCH_PROPERTYGET',DISPATCH_PROPERTYGET);
    AddConstant('DISPATCH_PROPERTYPUT',DISPATCH_PROPERTYPUT);
    AddConstant('DISPATCH_PROPERTYPUTREF',DISPATCH_PROPERTYPUTREF);
    AddConstant('OLEIVERB_PRIMARY',OLEIVERB_PRIMARY);
    AddConstant('OLEIVERB_SHOW',OLEIVERB_SHOW);
    AddConstant('OLEIVERB_OPEN',OLEIVERB_OPEN);
    AddConstant('OLEIVERB_HIDE',OLEIVERB_HIDE);
    AddConstant('OLEIVERB_UIACTIVATE',OLEIVERB_UIACTIVATE);
    AddConstant('OLEIVERB_INPLACEACTIVATE',OLEIVERB_INPLACEACTIVATE);
    AddConstant('OLEIVERB_DISCARDUNDOSTATE',OLEIVERB_DISCARDUNDOSTATE);
    AddConstant('EMBDHLP_INPROC_HANDLER',EMBDHLP_INPROC_HANDLER);
    AddConstant('EMBDHLP_INPROC_SERVER',EMBDHLP_INPROC_SERVER);
    AddConstant('EMBDHLP_CREATENOW',EMBDHLP_CREATENOW);
    AddConstant('EMBDHLP_DELAYCREATE',EMBDHLP_DELAYCREATE);
    AddConstant('UPDFCACHE_NODATACACHE',UPDFCACHE_NODATACACHE);
    AddConstant('UPDFCACHE_ONSAVECACHE',UPDFCACHE_ONSAVECACHE);
    AddConstant('UPDFCACHE_ONSTOPCACHE',UPDFCACHE_ONSTOPCACHE);
    AddConstant('UPDFCACHE_NORMALCACHE',UPDFCACHE_NORMALCACHE);
    AddConstant('UPDFCACHE_IFBLANK',UPDFCACHE_IFBLANK);
    AddConstant('UPDFCACHE_ONLYIFBLANK',UPDFCACHE_ONLYIFBLANK);
    AddConstant('UPDFCACHE_IFBLANKORONSAVECACHE',UPDFCACHE_IFBLANKORONSAVECACHE);
    AddConstant('UPDFCACHE_ALL',UPDFCACHE_ALL);
    AddConstant('UPDFCACHE_ALLBUTNODATACACHE',UPDFCACHE_ALLBUTNODATACACHE);
    AddConstant('DISCARDCACHE_SAVEIFDIRTY',DISCARDCACHE_SAVEIFDIRTY);
    AddConstant('DISCARDCACHE_NOSAVE',DISCARDCACHE_NOSAVE);
    AddConstant('OLEGETMONIKER_ONLYIFTHERE',OLEGETMONIKER_ONLYIFTHERE);
    AddConstant('OLEGETMONIKER_FORCEASSIGN',OLEGETMONIKER_FORCEASSIGN);
    AddConstant('OLEGETMONIKER_UNASSIGN',OLEGETMONIKER_UNASSIGN);
    AddConstant('OLEGETMONIKER_TEMPFORUSER',OLEGETMONIKER_TEMPFORUSER);
    AddConstant('OLEWHICHMK_CONTAINER',OLEWHICHMK_CONTAINER);
    AddConstant('OLEWHICHMK_OBJREL',OLEWHICHMK_OBJREL);
    AddConstant('OLEWHICHMK_OBJFULL',OLEWHICHMK_OBJFULL);
    AddConstant('USERCLASSTYPE_FULL',USERCLASSTYPE_FULL);
    AddConstant('USERCLASSTYPE_SHORT',USERCLASSTYPE_SHORT);
    AddConstant('USERCLASSTYPE_APPNAME',USERCLASSTYPE_APPNAME);
    AddConstant('OLEMISC_RECOMPOSEONRESIZE',OLEMISC_RECOMPOSEONRESIZE);
    AddConstant('OLEMISC_ONLYICONIC',OLEMISC_ONLYICONIC);
    AddConstant('OLEMISC_INSERTNOTREPLACE',OLEMISC_INSERTNOTREPLACE);
    AddConstant('OLEMISC_STATIC',OLEMISC_STATIC);
    AddConstant('OLEMISC_CANTLINKINSIDE',OLEMISC_CANTLINKINSIDE);
    AddConstant('OLEMISC_CANLINKBYOLE1',OLEMISC_CANLINKBYOLE1);
    AddConstant('OLEMISC_ISLINKOBJECT',OLEMISC_ISLINKOBJECT);
    AddConstant('OLEMISC_INSIDEOUT',OLEMISC_INSIDEOUT);
    AddConstant('OLEMISC_ACTIVATEWHENVISIBLE',OLEMISC_ACTIVATEWHENVISIBLE);
    AddConstant('OLEMISC_RENDERINGISDEVICEINDEPENDENT',OLEMISC_RENDERINGISDEVICEINDEPENDENT);
    AddConstant('OLECLOSE_SAVEIFDIRTY',OLECLOSE_SAVEIFDIRTY);
    AddConstant('OLECLOSE_NOSAVE',OLECLOSE_NOSAVE);
    AddConstant('OLECLOSE_PROMPTSAVE',OLECLOSE_PROMPTSAVE);
    AddConstant('OLERENDER_NONE',OLERENDER_NONE);
    AddConstant('OLERENDER_DRAW',OLERENDER_DRAW);
    AddConstant('OLERENDER_FORMAT',OLERENDER_FORMAT);
    AddConstant('OLERENDER_ASIS',OLERENDER_ASIS);
    AddConstant('OLEUPDATE_ALWAYS',OLEUPDATE_ALWAYS);
    AddConstant('OLEUPDATE_ONCALL',OLEUPDATE_ONCALL);
    AddConstant('OLELINKBIND_EVENIFCLASSDIFF',OLELINKBIND_EVENIFCLASSDIFF);
    AddConstant('BINDSPEED_INDEFINITE',BINDSPEED_INDEFINITE);
    AddConstant('BINDSPEED_MODERATE',BINDSPEED_MODERATE);
    AddConstant('BINDSPEED_IMMEDIATE',BINDSPEED_IMMEDIATE);
    AddConstant('OLECONTF_EMBEDDINGS',OLECONTF_EMBEDDINGS);
    AddConstant('OLECONTF_LINKS',OLECONTF_LINKS);
    AddConstant('OLECONTF_OTHERS',OLECONTF_OTHERS);
    AddConstant('OLECONTF_ONLYUSER',OLECONTF_ONLYUSER);
    AddConstant('OLECONTF_ONLYIFRUNNING',OLECONTF_ONLYIFRUNNING);
    AddConstant('DROPEFFECT_NONE',DROPEFFECT_NONE);
    AddConstant('DROPEFFECT_COPY',DROPEFFECT_COPY);
    AddConstant('DROPEFFECT_MOVE',DROPEFFECT_MOVE);
    AddConstant('DROPEFFECT_LINK',DROPEFFECT_LINK);
    AddConstant('DROPEFFECT_SCROLL',DROPEFFECT_SCROLL);
    AddConstant('DD_DEFSCROLLINSET',DD_DEFSCROLLINSET);
    AddConstant('DD_DEFSCROLLDELAY',DD_DEFSCROLLDELAY);
    AddConstant('DD_DEFSCROLLINTERVAL',DD_DEFSCROLLINTERVAL);
    AddConstant('DD_DEFDRAGDELAY',DD_DEFDRAGDELAY);
    AddConstant('DD_DEFDRAGMINDIST',DD_DEFDRAGMINDIST);
    AddConstant('OLEVERBATTRIB_NEVERDIRTIES',OLEVERBATTRIB_NEVERDIRTIES);
    AddConstant('OLEVERBATTRIB_ONCONTAINERMENU',OLEVERBATTRIB_ONCONTAINERMENU);
  end;
end;

class function TatOle2Library.LibraryName: string;
begin
  result := 'Ole2';
end;

initialization
  RegisterScripterLibrary(TatOle2Library, True);

{$WARNINGS ON}

end.

