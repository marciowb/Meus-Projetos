
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressEditors                                               }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSEDITORS AND ALL                }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxShellControls;

{$I cxVer.inc}

interface

uses
  Windows, ActiveX, Classes, ComCtrls, CommCtrl, ComObj, Controls, Dialogs,
  Menus, Messages, ShellApi, ShlObj, SysUtils, dxCore, cxControls, cxShellCommon;

const
  cxShellNormalItemOverlayIndex = -1;
  cxShellSharedItemOverlayIndex = 0;
  cxShellShortcutItemOverlayIndex = 1;

type
  TcxCustomInnerShellListView = class;
  TcxCustomInnerShellTreeView = class;

  TcxListViewStyle=(lvsIcon, lvsSmallIcon, lvsList, lvsReport);
  // Custom listview styles added because D4 and D5 does not allow detect
  // the ViewStyle change. Also, we can add more styles to this component:
  // Tile/Thumbnails/Custom...

  TcxNavigationEvent = procedure (Sender: TcxCustomInnerShellListView; APIDL: PItemIDList;
    ADisplayName: WideString) of object;
  TcxShellExecuteItemEvent = procedure (Sender: TObject; APIDL: PItemIDList; var AHandled: Boolean) of object;
  TcxShellAddFolderEvent = procedure(Sender: TObject; AFolder: TcxShellFolder; var ACanAdd: Boolean) of object;
  TcxShellChangeEvent = procedure(Sender: TObject; AEventID: DWORD; APIDL1, APIDL2: PItemIDList) of object;
  TcxShellCompareEvent = procedure(Sender: TObject;
    AItem1, AItem2: TcxShellFolder; var ACompare: Integer) of object;

  TcxShellListViewProducer = class(TcxCustomItemProducer)
  private
    function GetListView: TcxCustomInnerShellListView;
  protected
    function AllowBackgroundProcessing: Boolean; override;
    function CanAddFolder(AFolder: TcxShellFolder): Boolean; override;
    function DoCompareItems(AItem1, AItem2: TcxShellFolder;
      out ACompare: Integer): Boolean; override;
    function GetEnumFlags: Cardinal; override;
    function GetItemsInfoGatherer: TcxShellItemsInfoGatherer; override;
    function GetShowToolTip: Boolean; override;
    property ListView: TcxCustomInnerShellListView read GetListView;
  public
    procedure NotifyUpdateItem(AItem: PcxRequestItem); override;
    procedure ProcessDetails(ShellFolder: IShellFolder; CharWidth: Integer); override;
  end;

  { TcxShellListRoot }

  TcxShellListRoot = class(TcxCustomShellRoot)
  protected
    procedure RootUpdated; override;
  end;

  TDropTargetType = (dttNone, dttOpenFolder, dttItem);

  IcxDropTarget = interface(IDropTarget)
  ['{F688E250-96A6-4222-AF9D-049EB6E7D05B}']
  end;

  { TcxShellListViewOptions }

  TcxShellListViewOptions = class(TcxShellOptions)
  private
    FAutoExecute: Boolean;
    FAutoNavigate: Boolean;
  public
    constructor Create(AOwner: TWinControl); override;
    procedure Assign(Source: TPersistent); override;
  published
    property AutoExecute: Boolean read FAutoExecute write FAutoExecute default True;
    property AutoNavigate: Boolean read FAutoNavigate write FAutoNavigate default True;
  end;

  IcxDataObject = interface(IDataObject)
  ['{9A9CDB78-150E-4469-A551-608EFF415145}']
  end;

  TcxShellChangeNotifierData = record
    Handle: THandle;
    PIDL: PItemIDList;
  end;

  { TcxCustomInnerShellListView }

  TcxCustomInnerShellListView = class(TCustomListView, IUnknown, IcxDropTarget)
  private
    FComboBoxControl: TWinControl;
    FCurrentDropTarget: IcxDropTarget;
    FDragDropSettings: TcxDragDropSettings;
    FDraggedObject: IcxDataObject;
    FDropTargetItemIndex: Integer;
    FFirstUpdateItem: Integer;
    FInternalLargeImages: THandle;
    FInternalSmallImages: THandle;
    FItemProducer: TcxShellListViewProducer;
    FItemsInfoGatherer: TcxShellItemsInfoGatherer;
    FLastUpdateItem: Integer;
    FListViewStyle: TcxListViewStyle;
    FNotificationLock: Boolean;
    FOptions: TcxShellListViewOptions;
    FRoot: TcxShellListRoot;
    FShellChangeNotifierData: TcxShellChangeNotifierData;
    FTreeViewControl: TWinControl;

    FAfterNavigation: TcxNavigationEvent;
    FBeforeNavigation: TcxNavigationEvent;
    FRootChanged: TcxRootChangedEvent;
    FOnAddFolder: TcxShellAddFolderEvent;
    FOnCompare: TcxShellCompareEvent;
    FOnExecuteItem: TcxShellExecuteItemEvent;
    FOnShellChange: TcxShellChangeEvent;
    function GetFolder(AIndex: Integer): TcxShellFolder;
    function GetFolderCount: Integer;
    procedure RootSettingsChanged(Sender: TObject);
    procedure SetListViewStyle(const Value: TcxListViewStyle);
    procedure SetDropTargetItemIndex(Value: Integer);
    procedure ShellChangeNotify(AEventID: Longint; APidl1, APidl2: PItemIDList);
    procedure DSMSynchronizeRoot(var Message: TMessage); message DSM_SYNCHRONIZEROOT;
    procedure DsmSystemShellChangeNotify(var Message: TMessage); message DSM_SYSTEMSHELLCHANGENOTIFY;
  protected
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    function OwnerDataFetch(Item: TListItem; Request: TItemRequest): Boolean; override;
    function OwnerDataFind(Find: TItemFind; const FindString: string;
      const FindPosition: TPoint; FindData: Pointer; StartIndex: Integer;
      Direction: TSearchDirection; Wrap: Boolean): Integer; override;
    procedure DblClick; override;
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); override;
    function CanEdit(Item: TListItem): Boolean; override;
    procedure Loaded;override;
    procedure Edit(const Item: TLVItem); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DisplayContextMenu(const APos: TPoint);
    procedure DoProcessDefaultCommand(Item:TcxShellItemInfo); virtual;
    procedure DoProcessNavigation(Item:TcxShellItemInfo);
    procedure DoBeforeNavigation(fqPidl:PItemIDList);
    function DoAddFolder(AFolder: TcxShellFolder): Boolean;
    procedure DoAfterNavigation;
    function DoCompare(AItem1, AItem2: TcxShellFolder;
      out ACompare: Integer): Boolean; virtual;
    procedure CreateColumns;
    procedure CreateDropTarget;
    procedure CreateChangeNotification;
    procedure RemoveColumns;
    procedure RemoveDropTarget;
    procedure RemoveChangeNotification;
    procedure CheckUpdateItems;
    procedure DoBeginDrag;
    procedure DoNavigateTreeView;
    procedure GetDropTarget(pt: TPoint; out New: Boolean);
    procedure Navigate(APIDL: PItemIDList); virtual;
    function TryReleaseDropTarget: HResult;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure DsmSetCount(var Message: TMessage); message DSM_SETCOUNT;
    procedure DsmNotifyUpdateItem(var Message: TMessage); message DSM_NOTIFYUPDATE;
    procedure DsmNotifyUpdateContents(var Message: TMessage); message DSM_NOTIFYUPDATECONTENTS;
    procedure DsmShellChangeNotify(var Message: TMessage); message DSM_SHELLCHANGENOTIFY;
    property ComboBoxControl: TWinControl read FComboBoxControl write FComboBoxControl;
    property FirstUpdateItem: Integer read FFirstUpdateItem write FFirstUpdateItem;
    property LastUpdateItem: Integer read FLastUpdateItem write FLastUpdateItem;
    property ItemProducer: TcxShellListViewProducer read FItemProducer;
    property CurrentDropTarget: IcxDropTarget read FCurrentDropTarget write FCurrentDropTarget;
    property DropTargetItemIndex: Integer read FDropTargetItemIndex write SetDropTargetItemIndex;
    property DraggedObject: IcxDataObject read FDraggedObject write FDraggedObject;
    property TreeViewControl: TWinControl read FTreeViewControl write FTreeViewControl;
    // IcxDropTarget methods
    function DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
      pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function IcxDropTarget.DragOver=IDropTargetDragOver;
    function IDropTargetDragOver(grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
    function DragLeave: HResult; stdcall;
    function Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
    property ItemsInfoGatherer: TcxShellItemsInfoGatherer read FItemsInfoGatherer;
    
    property OnAddFolder: TcxShellAddFolderEvent read FOnAddFolder write FOnAddFolder;
    property OnCompare: TcxShellCompareEvent read FOnCompare write FOnCompare;
    property OnExecuteItem: TcxShellExecuteItemEvent read FOnExecuteItem write FOnExecuteItem;
    property OnShellChange: TcxShellChangeEvent read FOnShellChange write FOnShellChange;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure BrowseParent;
    procedure SetTreeView(ATreeView:TWinControl);
    procedure ProcessTreeViewNavigate(APIDL: PItemIDList);
    procedure Sort;
    procedure UpdateContent;
    property DragDropSettings: TcxDragDropSettings read FDragDropSettings write FDragDropSettings;
    property FolderCount: Integer read GetFolderCount;
    property Folders[AIndex: Integer]: TcxShellFolder read GetFolder;
    property ListViewStyle: TcxListViewStyle read FListViewStyle write SetListViewStyle;
    property Options: TcxShellListViewOptions read FOptions write FOptions;
    property Root: TcxShellListRoot read FRoot write FRoot;

    property AfterNavigation: TcxNavigationEvent read FAfterNavigation write FAfterNavigation;
    property BeforeNavigation: TcxNavigationEvent read FBeforeNavigation write FBeforeNavigation;
    property OnRootChanged: TcxRootChangedEvent read FRootChanged write FRootChanged;
  end;

  TcxShellTreeRoot = class(TcxCustomShellRoot)
  protected
    procedure RootUpdated; override;
  end;

  TcxShellTreeItemProducer = class(TcxCustomItemProducer)
  private
    FNode: TTreeNode;
    FOnDestroy: TNotifyEvent;
    function GetTreeView: TcxCustomInnerShellTreeView;
  protected
    function AllowBackgroundProcessing: Boolean; override;
    function CanAddFolder(AFolder: TcxShellFolder): Boolean; override;
    function GetEnumFlags: Cardinal; override;
    function GetItemsInfoGatherer: TcxShellItemsInfoGatherer; override;
    function GetShowToolTip: Boolean; override;
    property Node: TTreeNode read FNode write FNode;
    procedure InitializeItem(Item: TcxShellItemInfo); override;
    procedure CheckForSubitems(AItem: TcxShellItemInfo); override;
    property TreeView: TcxCustomInnerShellTreeView read GetTreeView;
  public
    constructor Create(AOwner: TWinControl); override;
    destructor Destroy; override;
    procedure SetItemsCount(Count: Integer); override;
    procedure NotifyUpdateItem(AItem: PcxRequestItem); override;
    procedure NotifyRemoveItem(Index: Integer); override;
    procedure NotifyAddItem(Index: Integer); override;
    procedure ProcessItems(AIFolder: IShellFolder; APIDL: PItemIDList;
      ANode: TTreeNode; cPreloadItems: Integer); reintroduce; overload;
    function CheckUpdates: Boolean;
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
  end;

  PcxShellTreeItemProducer = ^TcxShellTreeItemProducer;

  { TcxShellTreeViewOptions }

  TcxShellTreeViewOptions = class(TcxShellOptions)
  end;

  TcxShellTreeViewStateData = record
    CurrentPath: PItemIDList;
    ExpandedNodeList: TList;
    TopItemIndex: Integer;
  end;

  TcxCustomInnerShellTreeView = class(TTreeView, IUnknown, IcxDropTarget)
  private
    FComboBoxControl: TWinControl;
    FContextPopupItemProducer: TcxShellTreeItemProducer;
    FCurrentDropTarget: IcxDropTarget;
    FDragDropSettings: TcxDragDropSettings;
    FDraggedObject: IcxDataObject;
    FInternalSmallImages: THandle;
    FIsChangeNotificationCreationLocked: Boolean;
    FIsDragging: Boolean;
    FIsUpdating: Boolean;
    FItemProducersList: TThreadList;
    FItemsInfoGatherer: TcxShellItemsInfoGatherer;
    FListView: TcxCustomInnerShellListView;
    FNavigation: Boolean;
    FOptions: TcxShellTreeViewOptions;
    FPrevTargetNode: TTreeNode;
    FRoot: TcxShellTreeRoot;
    FRootChanged: TcxRootChangedEvent;
    FShellChangeNotificationCreation: Boolean;
    FShellChangeNotifierData: TcxShellChangeNotifierData;
    FShowInfoTips: Boolean;
    FStateData: TcxShellTreeViewStateData;
    FOnAddFolder: TcxShellAddFolderEvent;
    FOnShellChange: TcxShellChangeEvent;
    procedure SetPrevTargetNode(const Value: TTreeNode);
    procedure ContextPopupItemProducerDestroyHandler(Sender: TObject);
    function GetFolder(AIndex: Integer): TcxShellFolder;
    function GetFolderCount: Integer;
    function GetNodeFromItem(const Item: TTVItem): TTreeNode;
    procedure RestoreTreeState;
    procedure SaveTreeState;
    procedure SetListView(Value: TcxCustomInnerShellListView);
    procedure RootSettingsChanged(Sender: TObject);
    procedure SetShowInfoTips(Value: Boolean);
    procedure ShellChangeNotify(AEventID: Longint; APidl1, APidl2: PItemIDList);
    procedure ShowToolTipChanged(Sender: TObject);

    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure DSMShellTreeChangeNotify(var Message: TMessage); message DSM_SHELLTREECHANGENOTIFY;
    procedure DSMShellTreeRestoreCurrentPath(var Message: TMessage);
      message DSM_SHELLTREERESTORECURRENTPATH;
    procedure DSMSynchronizeRoot(var Message: TMessage); message DSM_SYNCHRONIZEROOT;
    procedure DSMSystemShellChangeNotify(var Message: TMessage); message DSM_SYSTEMSHELLCHANGENOTIFY;

    property CurrentDropTarget: IcxDropTarget read FCurrentDropTarget write FCurrentDropTarget;
    property DraggedObject: IcxDataObject read FDraggedObject write FDraggedObject;
    property ItemProducersList: TThreadList read FItemProducersList;
    property Navigation: Boolean read FNavigation write FNavigation;
    property PrevTargetNode: TTreeNode read FPrevTargetNode write SetPrevTargetNode;
  protected
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure Change(Node: TTreeNode); override;
    function CanEdit(Node: TTreeNode): Boolean; override;
    procedure Edit(const Item: TTVItem); override;
    function CanExpand(Node: TTreeNode): Boolean; override;
    procedure Delete(Node: TTreeNode); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure AddItemProducer(Producer:TcxShellTreeItemProducer);
    procedure AdjustControlParams;
    procedure CreateChangeNotification(ANode: TTreeNode = nil);
    procedure CreateDropTarget;
    function DoAddFolder(AFolder: TcxShellFolder): Boolean;
    procedure DoBeginDrag;
    procedure DoNavigateListView;
    procedure DragDropSettingsChanged(Sender: TObject); virtual;
    procedure GetDropTarget(out ANew: Boolean; APoint: TPoint);
    function GetNodeByPIDL(APIDL: PItemIDList): TTreeNode;
    function IsLoading: Boolean; virtual;
    procedure RemoveChangeNotification;
    procedure RemoveDropTarget;
    procedure RemoveItemProducer(AProducer: TcxShellTreeItemProducer);
    function TryReleaseDropTarget: HResult;

    procedure DsmSetCount(var Message: TMessage); message DSM_SETCOUNT;
    procedure DsmNotifyUpdateItem(var Message: TMessage); message DSM_NOTIFYUPDATE;
    procedure DsmNotifyRemoveItem(var Message: TMessage); message DSM_NOTIFYREMOVEITEM;
    procedure DsmNotifyAddItem(var Message: TMessage); message DSM_NOTIFYADDITEM;
    procedure DsmNotifyUpdateContents(var Message: TMessage); message DSM_NOTIFYUPDATECONTENTS;
    procedure DsmShellChangeNotify(var Message: TMessage); message DSM_SHELLCHANGENOTIFY;
    procedure DsmDoNavigate(var Message: TMessage); message DSM_DONAVIGATE;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    // IcxDropTarget methods
    function DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
      pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function IcxDropTarget.DragOver = IDropTargetDragOver;
    function IDropTargetDragOver(grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
    function DragLeave: HResult; stdcall;
    function Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;

    property ComboBoxControl: TWinControl read FComboBoxControl write FComboBoxControl;
    property ItemsInfoGatherer: TcxShellItemsInfoGatherer read FItemsInfoGatherer;
    property OnAddFolder: TcxShellAddFolderEvent read FOnAddFolder
      write FOnAddFolder;
    property OnShellChange: TcxShellChangeEvent read FOnShellChange write FOnShellChange;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure UpdateContent;
    procedure UpdateNode(ANode: TTreeNode; AFast: Boolean);

    property DragDropSettings:TcxDragDropSettings read FDragDropSettings write FDragDropSettings;
    property FolderCount: Integer read GetFolderCount;
    property Folders[AIndex: Integer]: TcxShellFolder read GetFolder;
    property ListView:TcxCustomInnerShellListView read FListView write SetListView;
    property Options: TcxShellTreeViewOptions read FOptions write FOptions;
    property Root:TcxShellTreeRoot read FRoot write FRoot;
    property ShowInfoTips: Boolean read FShowInfoTips write SetShowInfoTips default False;
    property OnRootChanged:TcxRootChangedEvent read FRootChanged write FRootChanged;
  end;

implementation

uses
  Forms, ImgList, Math;

type
  TcxShellOptionsAccess = class(TcxShellOptions);
  PPItemIDList = ^PItemIDList;

procedure CheckDefaultDropEffect(grfKeyState: Integer; ADragDropSettings: TcxDragDropSettings; var dwEffect: Integer);
begin
  if grfKeyState and (MK_CONTROL or MK_SHIFT or MK_ALT) = 0 then
    dwEffect := ADragDropSettings.DefaultDropEffectAPI;
end;

procedure GetShellNotifyParams(Message: TMessage; out AEventID: Integer; out APidl1, APidl2: PItemIDList);
var
  APidls: PPidlList;
  ALock: Cardinal;
begin
  ALock := SHChangeNotification_Lock(Message.WParam, Message.LParam, APidls, AEventID);
  try
    APidl1 := GetPidlCopy(APidls^[0]);
    APidl2 := GetPidlCopy(APidls^[1]);
  finally
    SHChangeNotification_UnLock(ALock);
  end;
end;

function GetShellItemOverlayIndex(AItemData: TcxShellItemInfo): Integer;
const
  SHGFI_OVERLAYINDEX = $40;
var
  AFileInfo: TShFileInfo;
  AFlags: Cardinal;
begin
  if GetComCtlVersion >= ComCtlVersionIE5 then
  begin
    AFlags := SHGFI_PIDL or SHGFI_ICON or SHGFI_OVERLAYINDEX;
    ZeroMemory(@AFileInfo, SizeOf(AFileInfo));
    cxShellGetThreadSafeFileInfo(PChar(AItemData.FullPIDL), 0, AFileInfo, SizeOf(AFileInfo), AFlags);
    DestroyIcon(AFileInfo.hIcon);
    Result := AFileInfo.iIcon;
    Result := (Result shr ((SizeOf(Result) - 1) * 8)) and $FF - 1;
  end
  else
  begin
    if AItemData.IsLink then
      Result := cxShellShortcutItemOverlayIndex
    else
      if AItemData.IsShare then
        Result := cxShellSharedItemOverlayIndex
      else
        Result := cxShellNormalItemOverlayIndex;
  end;
end;

procedure UnregisterShellChangeNotifier(
  var ANotifierData: TcxShellChangeNotifierData);
begin
  if ANotifierData.Handle <> 0 then
  begin
    SHChangeNotifyUnregister(ANotifierData.Handle);
    ANotifierData.Handle := 0;
    DisposePidl(ANotifierData.PIDL);
    ANotifierData.PIDL := nil;
  end;
end;

procedure RegisterShellChangeNotifier(ANotifierPIDL: PItemIDList; AWnd: HWND;
  ANotificationMsg: Cardinal; AWatchSubtree: Boolean;
  var ANotifierData: TcxShellChangeNotifierData);
var
  AItems: PSHChangeNotifyEntry;
begin
  if EqualPIDLs(ANotifierData.PIDL, ANotifierPIDL) then
    Exit;
  UnregisterShellChangeNotifier(ANotifierData);
  ANotifierData.PIDL := GetPidlCopy(ANotifierPIDL);
  New(AItems);
  try
    AItems.pidlPath := ANotifierData.PIDL;
    AItems.bWatchSubtree := AWatchSubtree;
    ANotifierData.Handle := SHChangeNotifyRegister(AWnd,
      SHCNF_ACCEPT_INTERRUPTS or SHCNF_ACCEPT_NON_INTERRUPTS or SHCNF_NO_PROXY,
      SHCNE_RENAMEITEM or SHCNE_CREATE or SHCNE_DELETE or SHCNE_MKDIR or
      SHCNE_RMDIR or SHCNE_ATTRIBUTES or SHCNE_UPDATEDIR or SHCNE_UPDATEITEM or
      SHCNE_UPDATEIMAGE or SHCNE_RENAMEFOLDER, ANotificationMsg, 1, AItems);
  finally
    Dispose(AItems);
  end;
end;

{ TcxShellListViewOptions }

constructor TcxShellListViewOptions.Create(AOwner: TWinControl);
begin
  inherited Create(AOwner);
  FAutoNavigate := True;
  FAutoExecute := True;
end;

procedure TcxShellListViewOptions.Assign(Source: TPersistent);
begin
  if Source is TcxShellListViewOptions then
  begin
    AutoExecute := TcxShellListViewOptions(Source).AutoExecute;
    AutoNavigate := TcxShellListViewOptions(Source).AutoNavigate;
  end;
  inherited Assign(Source);
end;

{ TcxCustomInnerShellListView }

constructor TcxCustomInnerShellListView.Create(AOwner: TComponent);
var
  AFileInfo: TShFileInfo;
begin
  inherited Create(AOwner);
  FDragDropSettings := TcxDragDropSettings.Create;
  FDropTargetItemIndex := -1;
  FFirstUpdateItem := -1;
  FInternalLargeImages := SHGetFileInfo('C:\', 0, AFileInfo, SizeOf(AFileInfo),
    SHGFI_SYSICONINDEX or SHGFI_LARGEICON);
  FInternalSmallImages := SHGetFileInfo('C:\', 0, AFileInfo, SizeOf(AFileInfo),
    SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  FItemProducer := TcxShellListViewProducer.Create(Self);
  FItemsInfoGatherer := TcxShellItemsInfoGatherer.Create(Self);
  FLastUpdateItem := -1;
  FOptions := TcxShellListViewOptions.Create(Self);
  FRoot := TcxShellListRoot.Create(Self, 0);
  FRoot.OnSettingsChanged := RootSettingsChanged;
  DoubleBuffered := True;
  DragMode := dmManual;
  HideSelection := False;
  OwnerData := True;
end;

destructor TcxCustomInnerShellListView.Destroy;
begin
  RemoveChangeNotification;
  FreeAndNil(FDragDropSettings);
  FreeAndNil(FItemProducer);
  FreeAndNil(FItemsInfoGatherer);
  FreeAndNil(FOptions);
  FreeAndNil(FRoot);
  inherited Destroy;
end;

procedure TcxCustomInnerShellListView.BrowseParent;
var
  APIDL: PItemIDList;
begin
  APIDL := GetPidlParent(ItemProducer.FolderPidl);
  try
    Navigate(APIDL);
  finally
    DisposePidl(APIDL);
  end;
end;

function TcxCustomInnerShellListView.CanEdit(Item: TListItem): Boolean;
begin
  Result := True;
  if Item = nil then
     Exit;
  if Item.Index > ItemProducer.Items.Count - 1 then
  begin
    Result := False;
    Exit;
  end;
  Result := TcxShellItemInfo(ItemProducer.Items[Item.Index]).CanRename;
end;

procedure TcxCustomInnerShellListView.CheckUpdateItems;
begin
  ItemProducer.ClearItems;
  if IsWindow(WindowHandle) then
  begin
    if not Root.IsValid then
      Items.Clear
    else
      if ItemProducer.Items.Count = 0 then
        ItemProducer.ProcessItems(Root.ShellFolder, Root.Pidl,
          PRELOAD_ITEMS_COUNT);
    CreateChangeNotification;
    Refresh;
  end;
end;

procedure TcxCustomInnerShellListView.CNNotify(var Message: TWMNotify);

  function GetOverlayIndex: Integer;
  var
    AItemData: TcxShellItemInfo;
  begin
    AItemData := ItemProducer.Items[PLVDispInfo(Message.NMHdr)^.item.iItem];
    AItemData.CheckUpdate(ItemProducer.ShellFolder, ItemProducer.FolderPidl, False);
    Result := GetShellItemOverlayIndex(AItemData);
  end;

begin
  if csDestroying in ComponentState then
    Exit;
  case Message.NMHdr^.code of
    LVN_BEGINDRAG, LVN_BEGINRDRAG:
      begin
        if not DragDropSettings.AllowDragObjects then
        begin
          inherited;
          Exit;
        end;
        if SelCount <= 0 then
          Exit;
        DoBeginDrag;
      end;
    LVN_GETINFOTIP:
      ItemProducer.DoGetInfoTip(Handle, PNMLVGetInfoTip(Message.NMHdr)^.iItem,
        PNMLVGetInfoTip(Message.NMHdr)^.pszText,
        PNMLVGetInfoTip(Message.NMHdr)^.cchTextMax);
    LVN_GETDISPINFO:
      begin
        inherited;
        with PLVDispInfo(Message.NMHdr)^.item do
          if (mask and LVIF_IMAGE <> 0) and (iSubItem = 0) then
            if (iItem >= 0) and (iItem < ItemProducer.Items.Count) then
            begin
              state := IndexToOverlayMask(GetOverlayIndex + 1);
              stateMask := ILD_OVERLAYMASK;
              mask := mask or LVIF_STATE;
            end;
      end;
    LVN_ODFINDITEM:
      begin
        if (PNMLVFindItem(Message.NMHdr)^.lvfi.flags and $4) <> 0 then {LVFI_SUBSTRING}
          PNMLVFindItem(Message.NMHdr)^.lvfi.flags := PNMLVFindItem(Message.NMHdr)^.lvfi.flags or LVFI_PARTIAL;
        inherited;
      end;
    else
      inherited;
  end;
end;

procedure TcxCustomInnerShellListView.CreateChangeNotification;
begin
  if not Options.TrackShellChanges then
    RemoveChangeNotification
  else
    RegisterShellChangeNotifier(ItemProducer.FolderPidl, Handle,
      DSM_SYSTEMSHELLCHANGENOTIFY, False, FShellChangeNotifierData);
end;

procedure TcxCustomInnerShellListView.CreateColumns;
var
  i: Integer;
  Column: TListColumn;
begin
  if ListViewStyle <> lvsReport then
     Exit;
  Columns.BeginUpdate;
  try
    Columns.Clear;
    for i := 0 to ItemProducer.Details.Count - 1 do
    begin
      Column := Columns.Add;
      Column.Caption := ItemProducer.Details[i].Text;
      Column.Alignment := ItemProducer.Details[i].Alignment;
      Column.Width := ItemProducer.Details[i].Width;
    end;
  finally
    Columns.EndUpdate;
  end;
end;

procedure TcxCustomInnerShellListView.CreateDropTarget;
var
  AIDropTarget: IcxDropTarget;
begin
  GetInterface(IcxDropTarget, AIDropTarget);
  RegisterDragDrop(Handle, IDropTarget(AIDropTarget));
end;

procedure TcxCustomInnerShellListView.CreateWnd;
begin
  inherited CreateWnd;
  if HandleAllocated then
  begin
    if FInternalSmallImages <> 0 then
      SendMessage(Handle, LVM_SETIMAGELIST, LVSIL_SMALL, LParam(FInternalSmallImages));
    if FInternalLargeImages <> 0 then
      SendMessage(Handle, LVM_SETIMAGELIST, LVSIL_NORMAL, LParam(FInternalLargeImages));
    CreateDropTarget;
    if Root.Pidl = nil then
      Root.CheckRoot
    else
      CheckUpdateItems;
  end;
end;

procedure TcxCustomInnerShellListView.DblClick;
var
  AItem: TcxShellItemInfo;
begin
  if not Options.AutoNavigate or (Selected = nil) then
     Exit;
  ItemProducer.LockRead;
  try
    AItem := ItemProducer.Items[Selected.Index];
    if AItem.IsFolder then
      DoProcessNavigation(AItem)
    else
      if Options.AutoExecute then
        DoProcessDefaultCommand(AItem);
  finally
    ItemProducer.UnlockRead;
  end;
end;

procedure TcxCustomInnerShellListView.DestroyWnd;
begin
  RemoveChangeNotification;
  RemoveColumns;
  RemoveDropTarget;
  inherited DestroyWnd;
end;

function TcxCustomInnerShellListView.DoAddFolder(AFolder: TcxShellFolder): Boolean;
begin
  Result := True;
  if Assigned(FOnAddFolder) then
    FOnAddFolder(Self, AFolder, Result);
end;

procedure TcxCustomInnerShellListView.DoAfterNavigation;
begin
  if Assigned(AfterNavigation) then
     AfterNavigation(Self, Root.Pidl, Root.CurrentPath);
end;

function TcxCustomInnerShellListView.DoCompare(AItem1, AItem2: TcxShellFolder;
  out ACompare: Integer): Boolean;
begin
  Result := Assigned(FOnCompare);
  if Result then
    FOnCompare(Self, AItem1, AItem2, ACompare);
end;

procedure TcxCustomInnerShellListView.DoBeforeNavigation(fqPidl: PItemIDList);
var
  Desktop: IShellFolder;
  tempPath: WideString;
  StrName: TStrRet;
begin
  if Failed(SHGetDesktopFolder(Desktop)) then
     Exit;
  if Succeeded(Desktop.GetDisplayNameOf(fqPidl, SHGDN_NORMAL or SHGDN_FORPARSING, StrName)) then
     tempPath := GetTextFromStrRet(StrName, fqPidl)
  else
     tempPath := '';
  if Assigned(BeforeNavigation) then
     BeforeNavigation(Self, fqPidl, tempPath);
end;

procedure TcxCustomInnerShellListView.DoBeginDrag;
var
  i: Integer;
  tempList: TList;
  pidlList: PItemIDList;
  pDataObject: IDataObject;
  pDropSource: IcxDropSource;
  dwEffect: Integer;
  Item: TListItem;
begin
  tempList := TList.Create;
  try
    Item := Selected;
    while Item <> nil do
    begin
      tempList.Add(GetPidlCopy(TcxShellItemInfo(ItemProducer.Items[Item.Index]).pidl));
      Item := GetNextItem(Item, sdAll, [isSelected]);
    end;
    pidlList := CreatePidlListFromList(tempList);
    try
      if Failed(ItemProducer.ShellFolder.GetUIObjectOf(Handle, SelCount, PItemIDList(pidlList^), IDataObject, nil, Pointer(pDataObject))) then
         Exit;
      pDropSource := TcxDropSource.Create(Self);
      dwEffect := DragDropSettings.DropEffectAPI;
      DoDragDrop(pDataObject, pDropSource, dwEffect, dwEffect);
    finally
      DisposePidl(pidlList);
    end;
  finally
    try
      for i := 0 to tempList.Count - 1 do
          DisposePidl(tempList[i]);
    finally
      FreeAndNil(tempList);
    end;
  end;
end;

procedure TcxCustomInnerShellListView.DoContextPopup(MousePos: TPoint;
  var Handled: Boolean);
begin
  if Options.ContextMenus and (SelCount > 0) then
  begin
    Handled := True;
    ItemProducer.LockRead;
    try
      DisplayContextMenu(ClientToScreen(MousePos));
    finally
      ItemProducer.UnlockRead;
    end;
  end
  else
    inherited DoContextPopup(MousePos, Handled);
end;

procedure TcxCustomInnerShellListView.DoProcessDefaultCommand(
  Item: TcxShellItemInfo);
var
  fqPidl: PItemIDList;
  lpExecInfo: PShellExecuteInfo;
  AHandled: Boolean;
begin
  fqPidl := ConcatenatePidls(ItemProducer.FolderPidl, Item.pidl);
  AHandled := False;
  if Assigned(OnExecuteItem) then
    OnExecuteItem(Self, fqPidl, AHandled);
  if not AHandled then
    try
      New(lpExecInfo);
      try
        ZeroMemory(lpExecInfo, SizeOf(TShellExecuteInfo));
        lpExecInfo.cbSize := SizeOf(TShellExecuteInfo);
        lpExecInfo.fMask := SEE_MASK_INVOKEIDLIST;
        lpExecInfo.Wnd := Handle;
        lpExecInfo.lpIDList := fqPidl;
        lpExecInfo.nShow := SW_SHOW;
        ShellExecuteEx(lpExecInfo);
      finally
        Dispose(lpExecInfo);
      end;
    finally
      DisposePidl(fqPidl);
    end;
end;

procedure TcxCustomInnerShellListView.DoProcessNavigation(
  Item: TcxShellItemInfo);
var
  APIDL: PItemIDList;
begin
  if not Item.IsFolder then
    Exit;
  APIDL := ConcatenatePidls(ItemProducer.FolderPidl, Item.pidl);
  try
    Navigate(APIDL);
  finally
    DisposePidl(APIDL);
  end;
end;

function TcxCustomInnerShellListView.DragEnter(const dataObj: IDataObject;
  grfKeyState: Integer; pt: TPoint; var dwEffect: Integer): HResult;
var
  new: Boolean;
begin
  DraggedObject := IcxDataObject(dataObj);
  GetDropTarget(pt, new);
  if CurrentDropTarget = nil then
  begin
    dwEffect := DROPEFFECT_NONE;
    Result := S_OK;
  end
  else
  begin
    CheckDefaultDropEffect(grfKeyState, DragDropSettings, dwEffect);
    Result := CurrentDropTarget.DragEnter(dataObj, grfKeyState, pt, dwEffect);
  end;
end;

function TcxCustomInnerShellListView.DragLeave: HResult;
begin
  DraggedObject := nil;
  Result := TryReleaseDropTarget;
end;

function TcxCustomInnerShellListView.IDropTargetDragOver(grfKeyState: Integer; pt: TPoint;
  var dwEffect: Integer): HResult;
var
  New: Boolean;
begin
  GetDropTarget(pt, new);
  if CurrentDropTarget = nil then
  begin
    dwEffect := DROPEFFECT_NONE;
    Result := S_OK;
  end
  else
  begin
    CheckDefaultDropEffect(grfKeyState, DragDropSettings, dwEffect);
    if New then
      Result := CurrentDropTarget.DragEnter(DraggedObject, grfKeyState, pt, dwEffect)
    else
      Result := S_OK;
    if Succeeded(Result) then
      Result := CurrentDropTarget.DragOver(grfKeyState, pt, dwEffect);
  end;
end;

function TcxCustomInnerShellListView.Drop(const dataObj: IDataObject;
  grfKeyState: Integer; pt: TPoint; var dwEffect: Integer): HResult;
var
  New: Boolean;
begin
  GetDropTarget(pt, new);
  if CurrentDropTarget = nil then
  begin
    dwEffect := DROPEFFECT_NONE;
    Result := S_OK;
  end
  else
  begin
    CheckDefaultDropEffect(grfKeyState, DragDropSettings, dwEffect);
    if New then
       Result := CurrentDropTarget.DragEnter(dataObj, grfKeyState, pt, dwEffect)
    else
       Result := S_OK;
    if Succeeded(Result) then
       Result := CurrentDropTarget.Drop(dataObj, grfKeyState, pt, dwEffect);
  end;
  DraggedObject := nil;
  TryReleaseDropTarget;
end;

procedure TcxCustomInnerShellListView.DsmNotifyUpdateContents(
  var Message: TMessage);
begin
  if not (csLoading in ComponentState) then
    CheckUpdateItems;
end;

procedure TcxCustomInnerShellListView.DsmNotifyUpdateItem(
  var Message: TMessage);
begin
  UpdateItems(Message.WParam, Message.WParam);
end;

procedure TcxCustomInnerShellListView.DsmSetCount(var Message: TMessage);
begin
  Items.Count := Message.WParam;
  ItemFocused := nil;
  Selected := nil;
end;

procedure TcxCustomInnerShellListView.DsmShellChangeNotify(
  var Message: TMessage);
begin
  ShellChangeNotify(Message.LParam, PPItemIDList(Message.WParam)^,
    PPItemIDList(Message.WParam + SizeOf(Pointer))^);
end;

procedure TcxCustomInnerShellListView.Edit(const Item: TLVItem);
var
  ATempItem: TcxShellItemInfo;
  ANewName: WideString;
  ANewPidl: PItemIDList;
begin
  inherited Edit(Item);
  if (ItemProducer.Items.Count - 1) < Item.iItem then
    Exit;
  ATempItem := ItemProducer.Items[Item.iItem];
  ANewName := StrPas(Item.pszText);
  ItemProducer.ShellFolder.SetNameOf(Handle, ATempItem.pidl, PWideChar(ANewName),
    SHGDN_INFOLDER or SHGDN_FORPARSING, ANewPidl);
  try
    ATempItem.SetNewPidl(ItemProducer.ShellFolder, ItemProducer.FolderPidl, ANewPidl);
  finally
    DisposePidl(ANewPidl);
  end;
end;

procedure TcxCustomInnerShellListView.KeyDown(var Key: Word;
  Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if not IsEditing then
    case Key of
      VK_RETURN:
        DblClick;
      VK_BACK:
        if Options.AutoNavigate then
          BrowseParent;
      VK_F5:
        UpdateContent;
    end;
end;

procedure TcxCustomInnerShellListView.DisplayContextMenu(const APos: TPoint);

  function GetItemPIDLList: TList;
  var
    AItem: TListItem;
    AItemPIDL: PItemIDList;
  begin
    Result := TList.Create;
    AItem := Selected;
    while AItem <> nil do
    begin
      AItemPIDL := TcxShellItemInfo(ItemProducer.Items[AItem.Index]).pidl;
      if AItemPIDL <> nil then
        Result.Add(GetPidlCopy(AItemPIDL));
      AItem := GetNextItem(AItem, sdAll, [isSelected]);
    end;
  end;

var
  AItemPIDLList: TList;
  I: Integer;
begin
  if SelCount = 0 then
    Exit;

  AItemPIDLList := GetItemPIDLList;
  try
    cxShellCommon.DisplayContextMenu(Handle, ItemProducer.ShellFolder,
      AItemPIDLList, APos);
  finally
    for I := 0 to AItemPIDLList.Count - 1 do
      DisposePidl(AItemPIDLList[I]);
    AItemPIDLList.Free;
  end;
end;

procedure TcxCustomInnerShellListView.Loaded;
begin
  inherited Loaded;
  if csDesigning in ComponentState then
    Root.RootUpdated;
end;

procedure TcxCustomInnerShellListView.GetDropTarget(pt: TPoint;
  out New: Boolean);

  function GetDropTargetItemIndex: Integer;
  var
    AItem: TListItem;
    P: TPoint;
  begin
    Result := -1;
    P := ScreenToClient(pt);
    AItem := GetItemAt(P.X, P.Y);
    if AItem <> nil then
      Result := AItem.Index;
  end;

var
  AItemIndex: Integer;
  tempDropTarget: IcxDropTarget;
  tempPidl: PItemIDList;
begin
  AItemIndex := GetDropTargetItemIndex;
  if AItemIndex = -1 then
  begin // There are no items selected, so drop target is current opened folder
    if (DropTargetItemIndex = -1) and (CurrentDropTarget <> nil) then
    begin
      New := False;
      Exit;
    end;
    TryReleaseDropTarget;
    New := True;
    if Failed(ItemProducer.ShellFolder.CreateViewObject(Handle,IDropTarget, tempDropTarget)) then
       Exit;
    CurrentDropTarget := tempDropTarget;
  end
  else
  begin // Use one of Items as Drop Target
    if AItemIndex = DropTargetItemIndex then
    begin
      New := False;
      Exit;
    end;
    TryReleaseDropTarget;
    New := True;
    tempPidl := GetPidlCopy(TcxShellItemInfo(ItemProducer.Items[AItemIndex]).pidl);
    try
      if Failed(ItemProducer.ShellFolder.GetUIObjectOf(Handle, 1, tempPidl, IDropTarget, nil, tempDropTarget)) then
         Exit;
    finally
      DisposePidl(tempPidl);
    end;
    CurrentDropTarget := tempDropTarget;
    DropTargetItemIndex := AItemIndex;
  end;
end;

procedure TcxCustomInnerShellListView.Navigate(APIDL: PItemIDList);
begin
  if EqualPIDLs(APIDL, ItemProducer.FolderPidl) then
    Exit;
  Items.BeginUpdate;
  try
    DoBeforeNavigation(APIDL);
    Root.Pidl := APIDL;
    DoNavigateTreeView;
    DoAfterNavigation;
  finally
    Items.EndUpdate;
  end;
end;

function TcxCustomInnerShellListView.OwnerDataFetch(Item: TListItem;
  Request: TItemRequest): Boolean;
var
  AShellItem: TcxShellItemInfo;
  i: Integer;
begin
  Result := True;
  ItemProducer.LockRead;
  try
    if Item.Index >= ItemProducer.Items.Count then
       Exit;
    AShellItem := ItemProducer.Items[Item.Index];
    AShellItem.CheckUpdate(ItemProducer.ShellFolder, ItemProducer.FolderPidl, False);
    Item.Caption := dxWideStringToString(AShellItem.Name);
    Item.ImageIndex := AShellItem.IconIndex;
    if ListViewStyle = lvsReport then
    begin
      if AShellItem.Details.Count = 0 then
         AShellItem.FetchDetails(Handle, ItemProducer.ShellFolder, ItemProducer.Details);
      for i := 0 to AShellItem.Details.Count - 1 do
          Item.SubItems.Add(AShellItem.Details[i]);
    end;
    Item.Cut := AShellItem.IsGhosted;
    if not AShellItem.Updated then
      ItemProducer.FetchRequest(Item.Index, True);
  finally
    ItemProducer.UnlockRead;
  end;
  Result := inherited OwnerDataFetch(Item, Request);
end;

function TcxCustomInnerShellListView.OwnerDataFind(Find: TItemFind; const FindString: string;
  const FindPosition: TPoint; FindData: Pointer; StartIndex: Integer;
  Direction: TSearchDirection; Wrap: Boolean): Integer;

  function IsItemSuitable(AIndex: Integer; AFind: TItemFind;
    const AFindString: string): Boolean;
  var
    ACaption: string;
  begin
    ACaption := dxWideStringToString(TcxShellItemInfo(ItemProducer.Items[AIndex]).Name);
    if AFind = ifPartialString then
      ACaption := Copy(ACaption, 1, Length(FindString));
    Result := CompareText(FindString, ACaption) = 0;
  end;

  function FindItemByCaption(AFind: TItemFind; const AFindString: string;
    AStartIndex: Integer; AWrap: Boolean): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    AStartIndex := EnsureRange(AStartIndex, 0, ItemProducer.Items.Count - 1);
    for I := AStartIndex to ItemProducer.Items.Count - 1 do
      if IsItemSuitable(I, AFind, AFindString) then
      begin
        Result := I;
        Break;
      end;
    if AWrap and (Result = -1) then
      for I := 0 to AStartIndex - 1 do
        if IsItemSuitable(I, AFind, AFindString) then
          begin
            Result := I;
            Break;
          end;
  end;

begin
  Result := inherited OwnerDataFind(Find, FindString, FindPosition, FindData,
    StartIndex, Direction, Wrap);
  if (Result = -1) and (Find in [ifPartialString, ifExactString]) then
    Result := FindItemByCaption(Find, FindString, StartIndex, Wrap);
end;

procedure TcxCustomInnerShellListView.RemoveChangeNotification;
begin
  UnregisterShellChangeNotifier(FShellChangeNotifierData);
end;

procedure TcxCustomInnerShellListView.RemoveColumns;
begin
  Columns.Clear;
end;

procedure TcxCustomInnerShellListView.RemoveDropTarget;
begin
  RevokeDragDrop(Handle);
end;

procedure TcxCustomInnerShellListView.SetDropTargetItemIndex(Value: Integer);
begin
  if FDropTargetItemIndex <> -1 then
    Items[FDropTargetItemIndex].DropTarget := False;
  FDropTargetItemIndex := Value;
  if FDropTargetItemIndex <> -1 then
    Items[FDropTargetItemIndex].DropTarget := True;
end;

procedure TcxCustomInnerShellListView.ShellChangeNotify(AEventID: Longint; APidl1, APidl2: PItemIDList);
begin
  if FNotificationLock then
     Exit;
  FNotificationLock := True;
  try
    CheckUpdateItems;
  finally
    FNotificationLock := False;
  end;
  if Assigned(FOnShellChange) then
    FOnShellChange(Self, AEventID, APidl1, APidl2);
end;

procedure TcxCustomInnerShellListView.DSMSynchronizeRoot(var Message: TMessage);
begin
  if not((Parent <> nil) and (csLoading in Parent.ComponentState)) then
    Root.Update(TcxCustomShellRoot(Message.WParam));
end;

procedure TcxCustomInnerShellListView.DsmSystemShellChangeNotify(
  var Message: TMessage);
var
  AEventID: Integer;
  APidl1, APidl2: PItemIDList;
begin
  GetShellNotifyParams(Message, AEventID, APidl1, APidl2);
  try
    ShellChangeNotify(AEventID, APidl1, APidl2);
  finally
    DisposePidl(APidl1);
    DisposePidl(APidl2);
  end;
end;

function TcxCustomInnerShellListView.GetFolder(AIndex: Integer): TcxShellFolder;
begin
  Result := TcxShellItemInfo(ItemProducer.Items[AIndex]).Folder;
end;

function TcxCustomInnerShellListView.GetFolderCount: Integer;
begin
  Result := Items.Count;
end;

procedure TcxCustomInnerShellListView.RootSettingsChanged(Sender: TObject);
begin
  if (Parent <> nil) and (csLoading in Parent.ComponentState) then
    Exit;
  if (FTreeViewControl <> nil) and FTreeViewControl.HandleAllocated then
    SendMessage(FTreeViewControl.Handle, DSM_SYNCHRONIZEROOT, Integer(Root), 0);
  if (FComboBoxControl <> nil) and FComboBoxControl.HandleAllocated then
    SendMessage(FComboBoxControl.Handle, DSM_SYNCHRONIZEROOT, Integer(Root), 0);
end;

procedure TcxCustomInnerShellListView.SetListViewStyle(
  const Value: TcxListViewStyle);
begin
  if FListViewStyle <> Value then
  begin
    FListViewStyle := Value;
    case FListViewStyle of
      lvsIcon:          ViewStyle:=vsIcon;
      lvsSmallIcon:     ViewStyle:=vsSmallIcon;
      lvsList:          ViewStyle:=vsList;
      lvsReport:        ViewStyle:=vsReport;
    end;
    CheckUpdateItems;
  end;
end;

function TcxCustomInnerShellListView.TryReleaseDropTarget:HResult;
begin
  Result := S_OK;
  if CurrentDropTarget <> nil then
     Result := CurrentDropTarget.DragLeave;
  CurrentDropTarget := nil;
  DropTargetItemIndex := -1;
end;

procedure TcxCustomInnerShellListView.SetTreeView(ATreeView: TWinControl);
begin
  TreeViewControl := ATreeView;
end;

var
  NavigationLock: Boolean;

procedure TcxCustomInnerShellListView.DoNavigateTreeView;
var
  ATempPidl: PItemIDList;
begin
  if NavigationLock or (not Assigned(TreeViewControl) and not Assigned(ComboBoxControl)) then
     Exit;

  ATempPidl := GetPidlCopy(Root.Pidl);
  try
    if Assigned(TreeViewControl) and (TreeViewControl.Parent <> nil) then
    begin
      TreeViewControl.HandleNeeded;
      SendMessage(TreeViewControl.Handle, DSM_DONAVIGATE, WPARAM(ATempPidl), 0);
    end;
    if Assigned(ComboBoxControl) and (ComboBoxControl.Parent <> nil) then
    begin
      ComboBoxControl.HandleNeeded;
      SendMessage(ComboBoxControl.Handle, DSM_DONAVIGATE, WPARAM(ATempPidl), 0);
    end;
  finally
    DisposePidl(ATempPidl);
  end;
end;

procedure TcxCustomInnerShellListView.ProcessTreeViewNavigate(
  APIDL: PItemIDList);

  function IsFolder(APIDL: PItemIDList): Boolean;
  const
    SHGFI_ATTR_SPECIFIED = $20000;
  var
    ASHFileInfo: TSHFileInfo;
  begin
    ASHFileInfo.dwAttributes := SFGAO_FOLDER;
    cxShellGetThreadSafeFileInfo(Pointer(APIDL), 0, ASHFileInfo, SizeOf(ASHFileInfo),
      SHGFI_PIDL or SHGFI_ATTR_SPECIFIED or SHGFI_ATTRIBUTES);
    Result := ASHFileInfo.dwAttributes and SFGAO_FOLDER <> 0;
  end;

begin
  NavigationLock := True;
  try
    if IsFolder(APIDL) and not EqualPIDLs(APIDL, Root.Pidl) then
      Root.Pidl := APIDL;
  finally
    NavigationLock := False;
  end;
end;

procedure TcxCustomInnerShellListView.Sort;
begin
  ItemProducer.Sort;
end;

procedure TcxCustomInnerShellListView.UpdateContent;
var
  AItemIndex: Integer;
  ASelectedItemPID: PItemIDList;
begin
  ASelectedItemPID := nil;
  try
    if not MultiSelect and (Selected <> nil) then
      ASelectedItemPID := GetPidlCopy(
        TcxShellItemInfo(ItemProducer.Items[Selected.Index]).pidl);
    CheckUpdateItems;
    if ASelectedItemPID <> nil then
    begin
      AItemIndex := ItemProducer.GetItemIndexByPidl(ASelectedItemPID);
      if (AItemIndex >= 0) and (AItemIndex < Items.Count) then
        Items[AItemIndex].Selected := True;
    end;
  finally
    DisposePidl(ASelectedItemPID);
  end;
end;

{ TcxShellListRoot }

procedure TcxShellListRoot.RootUpdated;
begin
  inherited RootUpdated;
  (Owner as TcxCustomInnerShellListView).CheckUpdateItems;
  if Assigned(TcxCustomInnerShellListView(Owner).OnRootChanged) then
     TcxCustomInnerShellListView(Owner).OnRootChanged(Owner, Self);
end;

{ TcxShellListViewProducer }

function TcxShellListViewProducer.AllowBackgroundProcessing: Boolean;
begin
  Result := True;
end;

function TcxShellListViewProducer.CanAddFolder(AFolder: TcxShellFolder): Boolean;
begin
  Result := ListView.DoAddFolder(AFolder);
end;

function TcxShellListViewProducer.DoCompareItems(AItem1, AItem2: TcxShellFolder;
  out ACompare: Integer): Boolean;
begin
  Result := ListView.DoCompare(AItem1, AItem2, ACompare);
end;

function TcxShellListViewProducer.GetEnumFlags: Cardinal;
begin
  Result := ListView.Options.GetEnumFlags;
end;

function TcxShellListViewProducer.GetItemsInfoGatherer: TcxShellItemsInfoGatherer;
begin
  Result := ListView.ItemsInfoGatherer;
end;

function TcxShellListViewProducer.GetShowToolTip: Boolean;
begin
  Result := ListView.Options.ShowToolTip;
end;

function TcxShellListViewProducer.GetListView: TcxCustomInnerShellListView;
begin
  Result := TcxCustomInnerShellListView(Owner);
end;

procedure TcxShellListViewProducer.NotifyUpdateItem(AItem: PcxRequestItem);
begin
  if AItem.Priority and Owner.HandleAllocated and (AItem.ItemIndex >= 0) and
    (AItem.ItemIndex < Items.Count) then
      PostMessage(Owner.Handle, DSM_NOTIFYUPDATE, AItem.ItemIndex, 0);
end;

procedure TcxShellListViewProducer.ProcessDetails(ShellFolder: IShellFolder;
  CharWidth: Integer);
begin
  inherited ProcessDetails(ShellFolder, ListView.StringWidth('X'));
  ListView.CreateColumns;
end;

{ TcxShellTreeRoot }

procedure TcxShellTreeRoot.RootUpdated;
begin
  inherited RootUpdated;
//  TcxCustomInnerShellTreeView(Owner).ItemsInfoGatherer.ClearFetchQueue(nil);
  TcxCustomInnerShellTreeView(Owner).Items.Clear;
  TcxCustomInnerShellTreeView(Owner).UpdateNode(nil, False);
  if Assigned(TcxCustomInnerShellTreeView(Owner).OnRootChanged) then
     TcxCustomInnerShellTreeView(Owner).OnRootChanged(Owner, Self);
end;

{ TcxCustomInnerShellTreeView }

procedure TcxCustomInnerShellTreeView.AddItemProducer(
  Producer: TcxShellTreeItemProducer);
var
  tempList: TList;
begin
  tempList := ItemProducersList.LockList;
  try
    tempList.Add(Producer);
  finally
    ItemProducersList.UnlockList;
  end;
end;

procedure TcxCustomInnerShellTreeView.AdjustControlParams;
var
  AStyle: Longint;
begin
  if HandleAllocated then
  begin
    AStyle := GetWindowLong(Handle, GWL_STYLE) and not(TVS_INFOTIP) or TVS_NOTOOLTIPS;
    if ShowInfoTips or Options.ShowToolTip then
      AStyle := AStyle and not TVS_NOTOOLTIPS;
    if ShowInfoTips then
      AStyle := AStyle or TVS_INFOTIP;
    SetWindowLong(Handle, GWL_STYLE, AStyle);
  end;
end;

function TcxCustomInnerShellTreeView.CanEdit(Node: TTreeNode): Boolean;
var
  ItemProducer:TcxShellTreeItemProducer;
begin
  Result := False;
  if Node.Parent = nil then
     Exit;
  ItemProducer := TcxShellTreeItemProducer(Node.Parent.Data);
  ItemProducer.LockRead;
  try
    if (ItemProducer.Items.Count - 1) < Node.Index then
       Exit;
    Result := TcxShellItemInfo(ItemProducer.Items[Node.Index]).CanRename;
    Result := Result and inherited CanEdit(Node);
  finally
    ItemProducer.UnlockRead;
  end;
end;

function TcxCustomInnerShellTreeView.CanExpand(Node: TTreeNode): Boolean;

  function GetDataForProcessing(out AProcessingFolder: IShellFolder;
    out AProcessingPidl: PItemIDList): Boolean;
  var
    AItemProducer: TcxShellTreeItemProducer;
    AItemInfo: TcxShellItemInfo;
  begin
    if Node.Parent <> nil then
    begin
      AItemProducer := TcxShellTreeItemProducer(Node.Parent.Data);
      AItemInfo := TcxShellItemInfo(AItemProducer.Items[Node.Index]);
      Node.HasChildren := AItemInfo.IsFolder;
      Result := AItemInfo.IsFolder and (Node.Index < AItemProducer.Items.Count) and
        Succeeded(AItemProducer.ShellFolder.BindToObject(AItemInfo.pidl, nil,
          IID_IShellFolder, AProcessingFolder));
      if Result then
        AProcessingPidl := ConcatenatePidls(AItemProducer.FolderPidl, AItemInfo.pidl);
    end
    else
    begin
      Result := True;
      AProcessingFolder := Root.ShellFolder;
      AProcessingPidl := GetPidlCopy(Root.Pidl);
    end;
  end;

  function InternalCanExpand: Boolean;
  var
    AProcessingPidl: PItemIDList;
    AProcessingFolder: IShellFolder;
  begin
    Result := GetDataForProcessing(AProcessingFolder, AProcessingPidl);
    if Result then
      try
        TcxShellTreeItemProducer(Node.Data).ProcessItems(AProcessingFolder,
          AProcessingPidl, Node, 0);
      finally
        DisposePidl(AProcessingPidl);
      end;
  end;

begin
  Result := ((Node.GetFirstChild <> nil) or InternalCanExpand) and
    inherited CanExpand(Node);
end;

procedure TcxCustomInnerShellTreeView.CNNotify(var Message: TWMNotify);
var
  tempNode: TTreeNode;
  ItemProducer: TcxShellTreeItemProducer;
begin
  if (Message.NMHdr^.code = TVN_BEGINDRAG) or
     (Message.NMHdr^.code = TVN_BEGINRDRAG) then
  begin
    with PNMTreeView(Message.NMHdr)^ do
      Selected := GetNodeFromItem(ItemNew);
    DoBeginDrag;
  end
  else
  if Message.NMHdr^.code = TVN_GETINFOTIP then
  begin
     tempNode := Items.GetNode(PNMTVGetInfoTip(Message.NMHdr)^.hItem);
     if (tempNode <> nil) and (tempNode.Parent <> nil) then
     begin
       ItemProducer := TcxShellTreeItemProducer(tempNode.Parent.Data);
       ItemProducer.DoGetInfoTip(Handle,tempNode.Index,
         PNMTVGetInfoTip(Message.NMHdr)^.pszText,
         PNMTVGetInfoTip(Message.NMHdr)^.cchTextMax);
     end;
  end
  else
    inherited;
end;

constructor TcxCustomInnerShellTreeView.Create(AOwner: TComponent);
var
  FileInfo: TShFileInfo;
begin
  inherited;
  FItemsInfoGatherer := TcxShellItemsInfoGatherer.Create(Self);
  FRoot := TcxShellTreeRoot.Create(Self, 0);
  FRoot.OnSettingsChanged := RootSettingsChanged;
  FDragDropSettings := TcxDragDropSettings.Create;
  FDragDropSettings.OnChange := DragDropSettingsChanged;
  FOptions := TcxShellTreeViewOptions.Create(Self);
  TcxShellOptionsAccess(FOptions).OnShowToolTipChanged := ShowToolTipChanged;
  FItemProducersList := TThreadList.Create;
  FInternalSmallImages := SHGetFileInfo('C:\', 0, FileInfo, SizeOf(FileInfo),
    SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  ImageList_SetBkColor(FInternalSmallImages, CLR_NONE);
  DoubleBuffered := True;
  DragMode := dmAutomatic;
  RightClickSelect := True;
end;

procedure TcxCustomInnerShellTreeView.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if ShowInfoTips then
    Params.Style := (Params.Style or TVS_INFOTIP) and not TVS_NOTOOLTIPS;
end;

procedure TcxCustomInnerShellTreeView.CreateWnd;
begin
  inherited CreateWnd;
  if HandleAllocated then
  begin
    if FInternalSmallImages <> 0 then
       SendMessage(Handle, TVM_SETIMAGELIST, TVSIL_NORMAL, LParam(FInternalSmallImages));
    if not IsLoading and (Root.Pidl = nil) then
       Root.CheckRoot;
    UpdateNode(nil, False);
    CreateDropTarget;
  end;
end;

procedure TcxCustomInnerShellTreeView.Delete(Node: TTreeNode);
var
  ItemProducer: TcxShellTreeItemProducer;
begin
  ItemProducer := TcxShellTreeItemProducer(Node.Data);
  if ItemProducer <> nil then
  begin
    ItemProducer.Free;
    Node.Data := nil;
  end;
  inherited;
end;

destructor TcxCustomInnerShellTreeView.Destroy;
var
  AList: TList;
  I: Integer;
begin
  if FListView <> nil then
    FListView.SetTreeView(nil);

  RemoveChangeNotification;

  AList := FItemProducersList.LockList;
  try
    for I := 0 to AList.Count - 1 do
      TcxShellTreeItemProducer(AList[I]).ClearFetchQueue;
  finally
    FItemProducersList.UnlockList;
  end;

  Items.Clear;
  FreeAndNil(FItemProducersList);
  FreeAndNil(FOptions);
  FreeAndNil(FDragDropSettings);
  FreeAndNil(FRoot);
  FreeAndNil(FItemsInfoGatherer);
  inherited Destroy;
end;

procedure TcxCustomInnerShellTreeView.UpdateContent;
var
  APidls: TPidlList;
begin
  if HandleAllocated then
  begin
    if Root.ShellFolder = nil then
      Root.CheckRoot;
    APidls[0] := Root.Pidl;
    APidls[1] := nil;
    SendMessage(Handle, DSM_SHELLTREECHANGENOTIFY, WPARAM(@APidls), 0);
  end;
end;

procedure TcxCustomInnerShellTreeView.DestroyWnd;
begin
  RemoveChangeNotification;
  RemoveDropTarget;
  CreateWndRestores := False;
  inherited DestroyWnd;
end;

procedure TcxCustomInnerShellTreeView.DoBeginDrag;
var
  ASourceItemProducer: TcxShellTreeItemProducer;
  ATempPidl: PItemIDList;
  ADataObject: IDataObject;
  ADropSource: IcxDropSource;
  AEffect: Integer;
begin
  if Selected.Parent = nil then
    Exit;
  ASourceItemProducer := TcxShellTreeItemProducer(Selected.Parent.Data);
  FIsDragging := True;
  ASourceItemProducer.LockRead;
  try
    if Selected.Index < ASourceItemProducer.Items.Count then
    begin
      ATempPidl := GetPidlCopy(TcxShellItemInfo(ASourceItemProducer.Items[Selected.Index]).pidl);
      try
        if Succeeded(ASourceItemProducer.ShellFolder.GetUIObjectOf(Handle, 1, ATempPidl,
          IDataObject, nil, ADataObject)) then
        begin
          ADropSource := TcxDropSource.Create(Self);
          AEffect := DragDropSettings.DropEffectAPI;
          DoDragDrop(ADataObject, ADropSource, AEffect, AEffect);
          if not TcxShellTreeItemProducer(Selected.Parent.Data).CheckUpdates then
            UpdateNode(Selected.Parent, False);
        end;
      finally
        DisposePidl(ATempPidl);
      end;
    end;
  finally
    ASourceItemProducer.UnlockRead;
    FIsDragging := False;
  end;
end;

procedure TcxCustomInnerShellTreeView.DoContextPopup(MousePos: TPoint;
  var Handled: Boolean);
var
  AItem: TcxShellItemInfo;
  AItemPIDLList: TList;
  ANode: TTreeNode;
begin
  try
    ANode := GetNodeAt(MousePos.X, MousePos.Y);
    if not Options.ContextMenus or (ANode = nil) then
    begin
      inherited DoContextPopup(MousePos, Handled);
      Exit;
    end;
    Handled := True;
    if ANode.Parent = nil then
      Exit;

    FContextPopupItemProducer := TcxShellTreeItemProducer(ANode.Parent.Data);
    FContextPopupItemProducer.OnDestroy := ContextPopupItemProducerDestroyHandler;
    FContextPopupItemProducer.LockRead;
    try
      CreateChangeNotification(ANode);
      AItem := FContextPopupItemProducer.Items[ANode.Index];
      FIsChangeNotificationCreationLocked := True;
      if AItem.pidl <> nil then
      begin
        AItemPIDLList := TList.Create;
        try
          AItemPIDLList.Add(GetPidlCopy(AItem.pidl));
          cxShellCommon.DisplayContextMenu(Handle, FContextPopupItemProducer.ShellFolder,
            AItemPIDLList, ClientToScreen(MousePos));
        finally
          DisposePidl(AItemPIDLList[0]);
          AItemPIDLList.Free;
        end;
      end;
    finally
      if FContextPopupItemProducer <> nil then
        FContextPopupItemProducer.UnlockRead;
    end;
  finally
    FIsChangeNotificationCreationLocked := False;
    if FContextPopupItemProducer <> nil then
    begin
      FContextPopupItemProducer.OnDestroy := nil;
      FContextPopupItemProducer := nil;
    end;
  end;
end;

procedure TcxCustomInnerShellTreeView.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key = VK_F5 then
    UpdateContent;
end;

function TcxCustomInnerShellTreeView.DragEnter(const dataObj: IDataObject;
  grfKeyState: Integer; pt: TPoint; var dwEffect: Integer): HResult;
var
  ANew: Boolean;
begin
  DraggedObject := IcxDataObject(dataObj);
  GetDropTarget(ANew, pt);
  if CurrentDropTarget = nil then
  begin
    dwEffect := DROPEFFECT_NONE;
    Result := S_OK;
  end
  else
  begin
    CheckDefaultDropEffect(grfKeyState, DragDropSettings, dwEffect);
    Result := CurrentDropTarget.DragEnter(dataObj, grfKeyState, pt, dwEffect);
  end;
end;

function TcxCustomInnerShellTreeView.DragLeave: HResult;
begin
  DraggedObject := nil;
  Result := TryReleaseDropTarget;
end;

function TcxCustomInnerShellTreeView.IDropTargetDragOver(grfKeyState: Integer; pt: TPoint;
  var dwEffect: Integer): HResult;
var
  ANew: Boolean;
begin
  GetDropTarget(ANew, pt);
  if CurrentDropTarget = nil then
  begin
    dwEffect := DROPEFFECT_NONE;
    Result := S_OK;
  end
  else
  begin
    CheckDefaultDropEffect(grfKeyState, DragDropSettings, dwEffect);
    if ANew then
      Result := CurrentDropTarget.DragEnter(DraggedObject, grfKeyState, pt, dwEffect)
    else
      Result := S_OK;
    if Succeeded(Result) then
      Result := CurrentDropTarget.DragOver(grfKeyState, pt, dwEffect);
  end;
end;

function TcxCustomInnerShellTreeView.Drop(const dataObj: IDataObject;
  grfKeyState: Integer; pt: TPoint; var dwEffect: Integer): HResult;
var
  ANew: Boolean;
begin
  GetDropTarget(ANew, pt);
  if CurrentDropTarget = nil then
  begin
    dwEffect := DROPEFFECT_NONE;
    Result := S_OK;
  end
  else
  begin
    CheckDefaultDropEffect(grfKeyState, DragDropSettings, dwEffect);
    if ANew then
      Result := CurrentDropTarget.DragEnter(dataObj, grfKeyState, pt, dwEffect)
    else
      Result := S_OK;
    if Succeeded(Result) then
      Result := CurrentDropTarget.Drop(dataObj, grfKeyState, pt, dwEffect);
  end;
  PostMessage(Handle, DSM_SHELLCHANGENOTIFY, WPARAM(PrevTargetNode), 0);
  DraggedObject := nil;
  TryReleaseDropTarget;
end;

procedure TcxCustomInnerShellTreeView.DsmNotifyAddItem(var Message: TMessage);
var
  Node, NewNode: TTreeNode;
  ItemProducer: TcxShellTreeItemProducer;
  tempShellItem: TcxShellItemInfo;
begin
  Node := TTreeNode(Message.LParam);
  ItemProducer := TcxShellTreeItemProducer(Node.Data);
  ItemProducer.LockRead;
  try
    tempShellItem := ItemProducer.Items[Message.WParam];
    NewNode := Items.AddChild(Node, tempShellItem.Name);
    NewNode.Data := TcxShellTreeItemProducer.Create(Self);
    NewNode.ImageIndex := tempShellItem.IconIndex;
    NewNode.SelectedIndex := tempShellItem.OpenIconIndex;
    NewNode.HasChildren := tempShellItem.HasSubfolder;
  finally
    ItemProducer.UnlockRead;
  end;
end;

procedure TcxCustomInnerShellTreeView.DsmNotifyRemoveItem(
  var Message: TMessage);
var
  ANode: TTreeNode;
begin
  ANode := TTreeNode(Message.LParam);
  if Message.WParam < ANode.Count then
    ANode.Item[Message.WParam].Delete;
end;

procedure TcxCustomInnerShellTreeView.DsmNotifyUpdateContents(
  var Message: TMessage);
begin
  if not (csLoading in ComponentState) then
     UpdateNode(nil, False);
end;

procedure TcxCustomInnerShellTreeView.DsmNotifyUpdateItem(
  var Message: TMessage);

  function GetChildNode(ANode: TTreeNode; AIndex: Integer): TTreeNode;
  begin
    Result := ANode.getFirstChild;
    while (Result <> nil) and (AIndex > 0) do
    begin
      Result := ANode.GetNextChild(Result);
      Dec(AIndex);
    end;
  end;

var
  AItem: TcxShellItemInfo;
  AItemProducer: TcxShellTreeItemProducer;
  ANode, ATempNode: TTreeNode;
begin
  ANode := TTreeNode(Message.LParam);
  if ANode.getFirstChild = nil then
    Exit;
  ATempNode := GetChildNode(ANode, Message.WParam);
  if ATempNode = nil then
    Exit;

  AItemProducer := TcxShellTreeItemProducer(ANode.Data);
  AItemProducer.LockRead;
  try
    AItem := AItemProducer.Items[Message.WParam];
    ATempNode.ImageIndex := AItem.IconIndex;
    ATempNode.SelectedIndex := AItem.OpenIconIndex;
    ATempNode.Text := AItem.Name;
    ATempNode.HasChildren := AItem.HasSubfolder;
    ATempNode.Cut := AItem.IsGhosted;
    ATempNode.OverlayIndex := GetShellItemOverlayIndex(AItem);
  finally
    AItemProducer.UnlockRead;
  end;
end;

procedure TcxCustomInnerShellTreeView.DsmSetCount(var Message: TMessage);
var
  Node: TTreeNode;
  ItemProducer: TcxShellTreeItemProducer;
  i: Integer;
  NewNode: TTreeNode;
  tempShellItem: TcxShellItemInfo;
begin
  Node := TTreeNode(Message.LParam);
  if Message.WParam = 0 then
  begin
    Node.DeleteChildren;
    Node.HasChildren := False;
    Exit;
  end;
  ItemProducer := TcxShellTreeItemProducer(Node.Data);
  ItemProducer.LockRead;
  try
    Items.BeginUpdate;
    try
      for i := 0 to ItemProducer.Items.Count-1 do
      begin
        tempShellItem := ItemProducer.Items[i];
        if not tempShellItem.Updated then
          ItemProducer.FetchRequest(i, False);
        NewNode := Items.AddChild(Node, tempShellItem.Name);
        NewNode.Data := TcxShellTreeItemProducer.Create(Self);
        NewNode.ImageIndex := tempShellItem.IconIndex;
        NewNode.SelectedIndex := tempShellItem.OpenIconIndex;
        NewNode.HasChildren := tempShellItem.HasSubfolder;
        NewNode.Cut := tempShellItem.IsGhosted;
        NewNode.OverlayIndex := GetShellItemOverlayIndex(tempShellItem);
      end;
    finally
      Items.EndUpdate;
    end;
    if Node.GetFirstChild = nil then
       Node.HasChildren := False;
  finally
    ItemProducer.UnlockRead;
  end;
end;

procedure TcxCustomInnerShellTreeView.DsmShellChangeNotify(
  var Message: TMessage);
begin
  Sleep(100);
  if not TcxShellTreeItemProducer(TTreeNode(Message.WParam).Data).CheckUpdates then
    UpdateNode(TTreeNode(Message.WParam), False);
end;

procedure TcxCustomInnerShellTreeView.Edit(const Item: TTVItem);
var
  AItemInfo: TcxShellItemInfo;
  AItemProducer: TcxShellTreeItemProducer;
  ANode: TTreeNode;
  APIDL: PItemIDList;
  APrevNodeText: string;
begin
  ANode := GetNodeFromItem(Item);
  APrevNodeText := '';
  if ANode <> nil then
    APrevNodeText := ANode.Text;
  inherited Edit(Item);
  if (Item.pszText = nil) or (ANode = nil) or (ANode.Parent = nil) then
    Exit;
  AItemProducer := TcxShellTreeItemProducer(ANode.Parent.Data);
  AItemInfo := AItemProducer.Items[ANode.Index];
  RemoveChangeNotification;
  if AItemProducer.ShellFolder.SetNameOf(Handle, AItemInfo.pidl, PWideChar(WideString(ANode.Text)),
    SHGDN_INFOLDER or SHGDN_FORPARSING, APIDL) = S_OK then
    try
      AItemInfo.SetNewPidl(AItemProducer.ShellFolder, AItemProducer.FolderPidl, APIDL);
      UpdateNode(ANode, True);
    finally
      DisposePidl(APIDL);
    end
  else
    ANode.Text := APrevNodeText;
end;

procedure TcxCustomInnerShellTreeView.ContextPopupItemProducerDestroyHandler(
  Sender: TObject);
begin
  FContextPopupItemProducer.UnlockRead;
  FContextPopupItemProducer.OnDestroy := nil;
  FContextPopupItemProducer := nil;
end;

function TcxCustomInnerShellTreeView.GetFolder(AIndex: Integer): TcxShellFolder;
var
  ANode: TTreeNode;
begin
  ANode := Items[AIndex];
  if ANode.Parent = nil then
    Result := Root.Folder
  else
    Result := TcxShellItemInfo(TcxShellTreeItemProducer(ANode.Parent.Data).Items[ANode.Index]).Folder;
end;

function TcxCustomInnerShellTreeView.GetFolderCount: Integer;
begin
  Result := Items.Count;
end;

function TcxCustomInnerShellTreeView.GetNodeFromItem(
  const Item: TTVItem): TTreeNode;
begin
  Result := nil;
  if Items <> nil then
    with Item do
      if (state and TVIF_PARAM) <> 0 then
        Result := Pointer(lParam)
      else
        Result := Items.GetNode(hItem);
end;

procedure TcxCustomInnerShellTreeView.RestoreTreeState;

  procedure RestoreExpandedNodes;

    procedure ExpandNode(APIDL: PItemIDList);
    var
      ANode: TTreeNode;
    begin
      if Root.ShellFolder = nil then
        Root.CheckRoot;
      if APIDL = nil then
        APIDL := Root.Pidl;
      ANode := GetNodeByPIDL(APIDL);
      if ANode <> nil then
        ANode.Expand(False);
    end;

    procedure DestroyExpandedNodeList;
    var
      I: Integer;
    begin
      if FStateData.ExpandedNodeList = nil then
        Exit;
      for I := 0 to FStateData.ExpandedNodeList.Count - 1 do
        DisposePidl(PItemIDList(FStateData.ExpandedNodeList[I]));
      FreeAndNil(FStateData.ExpandedNodeList);
    end;

  var
    I: Integer;
  begin
    try
      for I := 0 to FStateData.ExpandedNodeList.Count - 1 do
        ExpandNode(PItemIDList(FStateData.ExpandedNodeList[I]));
    finally
      DestroyExpandedNodeList;
    end;
  end;

  procedure RestoreTopItemIndex;
  begin
    if (FStateData.TopItemIndex >= 0) and (FStateData.TopItemIndex < Items.Count) then
      TopItem := Items[FStateData.TopItemIndex];
  end;

  procedure RestoreCurrentPath;
  var
    ACurrentPath, ATempPIDL: PItemIDList;
  begin
    if FStateData.CurrentPath = nil then
      Exit;
    ACurrentPath := GetPidlCopy(FStateData.CurrentPath);
    try
      repeat
        if GetNodeByPIDL(ACurrentPath) <> nil then
        begin
          PostMessage(Handle, DSM_SHELLTREERESTORECURRENTPATH,
            WPARAM(GetPidlCopy(ACurrentPath)), 0);
          Break;
        end;
        ATempPIDL := ACurrentPath;
        ACurrentPath := GetPidlParent(ACurrentPath);
        DisposePidl(ATempPIDL);
      until False;
    finally
      DisposePidl(ACurrentPath);
    end;
  end;

begin
  try
    RestoreExpandedNodes;
    RestoreTopItemIndex;
    RestoreCurrentPath;
  finally
    DisposePidl(FStateData.CurrentPath);
    FStateData.CurrentPath := nil;
  end;
end;

procedure TcxCustomInnerShellTreeView.SaveTreeState;

  procedure SaveTopItemIndex;
  begin
    if TopItem <> nil then
      FStateData.TopItemIndex := TopItem.AbsoluteIndex
    else
      FStateData.TopItemIndex := -1;
  end;

  procedure SaveExpandedNodes;

    procedure SaveExpandedNode(ANode: TTreeNode);
    var
      AParentItemProducer: TcxShellTreeItemProducer;
    begin
      if ANode.Parent = nil then
        FStateData.ExpandedNodeList.Add(nil)
      else
      begin
        AParentItemProducer := TcxShellTreeItemProducer(ANode.Parent.Data);
        FStateData.ExpandedNodeList.Add(GetPidlCopy(
          TcxShellItemInfo(AParentItemProducer.Items[ANode.Index]).FullPIDL));
      end;
    end;

  var
    ANode: TTreeNode;
  begin
    FStateData.ExpandedNodeList := TList.Create;
    ANode := Items.GetFirstNode;
    while ANode <> nil do
    begin
      if ANode.Expanded then
        SaveExpandedNode(ANode);
      ANode := ANode.GetNext;
    end;
  end;

  procedure SaveCurrentPath;
  begin
    if Selected <> nil then
    begin
      if Selected.Parent = nil then
        FStateData.CurrentPath := Root.Pidl
      else
        FStateData.CurrentPath := TcxShellItemInfo(TcxShellTreeItemProducer(
          Selected.Parent.Data).Items[Selected.Index]).FullPIDL;
      FStateData.CurrentPath := GetPidlCopy(FStateData.CurrentPath);
    end
    else
      FStateData.CurrentPath := nil;
  end;

begin
  SaveTopItemIndex;
  SaveExpandedNodes;
  SaveCurrentPath;
end;

procedure TcxCustomInnerShellTreeView.Loaded;
begin
  if Root.Pidl = nil then
    Root.CheckRoot;
  UpdateNode(nil, False);
end;

procedure TcxCustomInnerShellTreeView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = FListView then
      FListView := nil
end;

procedure TcxCustomInnerShellTreeView.CreateChangeNotification(
  ANode: TTreeNode = nil);

  function GetShellChangeNotifierPIDL: PItemIDList;
  begin
    if Root.ShellFolder = nil then
      Root.CheckRoot;
    if ANode = nil then
      if Selected = nil then
        ANode := Items[0]
      else
        ANode := Selected;
    if ANode.Parent = nil then
      Result := Root.Pidl
    else
      Result := TcxShellItemInfo(TcxShellTreeItemProducer(
        ANode.Parent.Data).Items[ANode.Index]).FullPIDL;
  end;

begin
  if FIsChangeNotificationCreationLocked then
    Exit;
  FShellChangeNotificationCreation := True;
  try
    if not Options.TrackShellChanges or (Items.Count = 0) then
      RemoveChangeNotification
    else
      RegisterShellChangeNotifier(GetShellChangeNotifierPIDL, Handle,
        DSM_SYSTEMSHELLCHANGENOTIFY, True, FShellChangeNotifierData);
  finally
    FShellChangeNotificationCreation := False;
  end;
end;

procedure TcxCustomInnerShellTreeView.CreateDropTarget;
var
  AIDropTarget: IcxDropTarget;
begin
  GetInterface(IcxDropTarget, AIDropTarget);
  RegisterDragDrop(Handle, IDropTarget(AIDropTarget));
end;

function TcxCustomInnerShellTreeView.DoAddFolder(AFolder: TcxShellFolder): Boolean;
begin
  Result := True;
  if Assigned(FOnAddFolder) then
    FOnAddFolder(Self, AFolder, Result);
end;

procedure TcxCustomInnerShellTreeView.SetPrevTargetNode(const Value: TTreeNode);
begin
  if FPrevTargetNode <> nil then
    FPrevTargetNode.DropTarget := False;
  FPrevTargetNode := Value;
  if FPrevTargetNode <> nil then
    FPrevTargetNode.DropTarget := True;
end;

function TcxCustomInnerShellTreeView.TryReleaseDropTarget: HResult;
begin
  Result := S_OK;
  if CurrentDropTarget <> nil then
     Result := CurrentDropTarget.DragLeave;
  CurrentDropTarget := nil;
  PrevTargetNode := nil;
end;

(*procedure TcxCustomInnerShellTreeView.UpdateNode(ANode: TTreeNode);
var
  uNode:TTreeNode;
begin
  if csLoading in ComponentState then
     Exit;
  uNode:=nil;
  if IsWindow(Handle) and Root.IsValid then
  begin
    if ANode=nil then
    begin
      if (Items.Count > 0) and (Items[0].Data <> nil) then
        Items.Clear;
      if Items.Count=0 then
        uNode:=Items.AddFirst(nil,'')
      else
        uNode:=Items[0];
      uNode.Data:=TcxShellTreeItemProducer.Create(Self);
    end
    else
       uNode:=ANode;
    uNode.HasChildren:=True;
  end;
  if uNode<>nil then
     CanExpand(uNode);
end;*)

procedure TcxCustomInnerShellTreeView.UpdateNode(ANode: TTreeNode;
  AFast: Boolean);
var
  AFullPIDL: PITemIDList;
  AParentItemProducer: TcxShellTreeItemProducer;
  ATempNode: TTreeNode;
begin
  if csLoading in ComponentState then
    Exit;
  if IsWindow(WindowHandle) and Root.IsValid then
  begin
    if ANode = nil then
    begin
      if (Items.Count > 0) and (Items[0].Data <> nil) then
        Items.Clear;
      if Items.Count = 0 then
        ATempNode := Items.AddFirst(nil, '')
      else
        ATempNode := Items[0];
      ATempNode.Data := TcxShellTreeItemProducer.Create(Self);
    end
    else
      ATempNode := ANode;
    if not AFast or (ATempNode.Parent = nil) then
    begin
      ATempNode.HasChildren := True;
      CanExpand(ATempNode);
    end
    else
    begin
      AParentItemProducer := TcxShellTreeItemProducer(ATempNode.Parent.Data);
      AFullPIDL := ConcatenatePidls(AParentItemProducer.FolderPidl,
        TcxShellItemInfo(AParentItemProducer.Items[ATempNode.Index]).pidl);
      TcxShellTreeItemProducer(ATempNode.Data).FolderPidl := AFullPIDL;
      ATempNode.HasChildren := HasSubItems(AParentItemProducer.ShellFolder,
        AFullPIDL, AParentItemProducer.GetEnumFlags);
    end;
    CreateChangeNotification;
  end;
end;

procedure TcxCustomInnerShellTreeView.SetListView(
  Value: TcxCustomInnerShellListView);
begin
  if FListView = Value then
    Exit;
  if FListView <> nil then
  begin
    FListView.SetTreeView(nil);
    FListView.RemoveFreeNotification(Self);
  end;
  FListView := Value;
  if FListView <> nil then
  begin
    FListView.FreeNotification(Self);
    FListView.SetTreeView(Self);
  end;
  DoNavigateListView;
end;

procedure TcxCustomInnerShellTreeView.RootSettingsChanged(Sender: TObject);
begin
  if (Parent <> nil) and (csLoading in Parent.ComponentState) then
    Exit;
  if (FListView <> nil) and FListView.HandleAllocated then
    SendMessage(FListView.Handle, DSM_SYNCHRONIZEROOT, Integer(Root), 0);
  if (FComboBoxControl <> nil) and FComboBoxControl.HandleAllocated then
    SendMessage(FComboBoxControl.Handle, DSM_SYNCHRONIZEROOT, Integer(Root), 0);
end;

procedure TcxCustomInnerShellTreeView.SetShowInfoTips(Value: Boolean);
begin
  if Value <> FShowInfoTips then
  begin
    FShowInfoTips := Value;
    AdjustControlParams;
  end;
end;

procedure TcxCustomInnerShellTreeView.ShellChangeNotify(AEventID: Longint; APidl1, APidl2: PItemIDList);

  function NeedProcessMessage(AEventID: Longint; APidl1, APidl2: PItemIDList): Boolean; // TODO more detailed selection
  begin
    Result := (AEventID <> SHCNE_UPDATEITEM) or
      (GetNodeByPIDL(APidl1) <> nil);
  end;

  procedure DoShellTreeChange;
  begin
    if (DraggedObject <> nil) or FIsDragging then
      Exit;
    Items.BeginUpdate;
    FIsUpdating := True;
    try
      SendMessage(Parent.Handle, WM_SETREDRAW, 0, 0);
      try
        SaveTreeState;
        try
          Items.Clear;
          UpdateNode(nil, False);
        finally
          RestoreTreeState;
        end;
      finally
        SendMessage(Parent.Handle, WM_SETREDRAW, 1, 0);
        Parent.Update;
      end;
    finally
      FIsUpdating := False;
      Items.EndUpdate;
    end;
  end;

begin
  if not FShellChangeNotificationCreation and not FIsUpdating and NeedProcessMessage(AEventID, APidl1, APidl2) then
    try
      DoShellTreeChange;
    finally
      if Assigned(FOnShellChange) then
        FOnShellChange(Self, AEventID, APidl1, APidl2);
    end;
end;

procedure TcxCustomInnerShellTreeView.ShowToolTipChanged(Sender: TObject);
begin
  ToolTips := Options.ShowToolTip;
  AdjustControlParams;
end;

procedure TcxCustomInnerShellTreeView.CMColorChanged(var Message: TMessage);
begin
{$IFDEF DELPHI11}
  inherited;
{$ELSE}
  if HandleAllocated then
    inherited
  else
    Brush.Color := Color;
{$ENDIF}
end;

procedure TcxCustomInnerShellTreeView.CMFontChanged(var Message: TMessage);
begin
{$IFDEF DELPHI11}
  inherited;
{$ELSE}
  if HandleAllocated then
    inherited;
{$ENDIF}
end;

procedure TcxCustomInnerShellTreeView.DSMShellTreeChangeNotify(var Message: TMessage);
begin
  ShellChangeNotify(Message.LParam, PPItemIDList(Message.WParam)^,
    PPItemIDList(Message.WParam + SizeOf(Pointer))^);
end;

procedure TcxCustomInnerShellTreeView.DSMShellTreeRestoreCurrentPath(var Message: TMessage);
var
  APrevAutoExpand: Boolean;
begin
  if FIsChangeNotificationCreationLocked then
    PostMessage(Handle, DSM_SHELLTREERESTORECURRENTPATH, Message.WPARAM, 0)
  else
    try
      APrevAutoExpand := AutoExpand;
      AutoExpand := False;
      try
        SendMessage(Handle, DSM_DONAVIGATE, Message.WPARAM, 0);
        DoNavigateListView;
      finally
        AutoExpand := APrevAutoExpand;
      end;
    finally
      DisposePidl(PItemIDList(Message.WPARAM));
    end;
end;

procedure TcxCustomInnerShellTreeView.DSMSynchronizeRoot(var Message: TMessage);
begin
  if not((Parent <> nil) and (csLoading in Parent.ComponentState)) then
    Root.Update(TcxCustomShellRoot(Message.WParam));
end;

procedure TcxCustomInnerShellTreeView.DSMSystemShellChangeNotify(var Message: TMessage);
var
  AEventID: Integer;
  APidl1, APidl2: PItemIDList;
begin
  GetShellNotifyParams(Message, AEventID, APidl1, APidl2);
  try
    ShellChangeNotify(AEventID, APidl1, APidl2);
  finally
    DisposePidl(APidl1);
    DisposePidl(APidl2);
  end;
end;

procedure TcxCustomInnerShellTreeView.DoNavigateListView;
var
  ATempPIDL: PItemIDList;
begin
  if (Items.Count = 0) or (not Assigned(ListView) and not Assigned(ComboBoxControl)) then
    Exit;

  if Selected <> nil then
    ATempPIDL := TcxShellTreeItemProducer(Selected.Data).FolderPidl
  else
    ATempPIDL := TcxShellTreeItemProducer(Items[0].Data).FolderPidl;
  if Assigned(ListView) then
    ListView.ProcessTreeViewNavigate(ATempPIDL);

  if Assigned(ComboBoxControl) and (ComboBoxControl.Parent <> nil) then
  begin
    ComboBoxControl.HandleNeeded;
    SendMessage(ComboBoxControl.Handle, DSM_DONAVIGATE, Integer(ATempPIDL), 0);
  end;
end;

procedure TcxCustomInnerShellTreeView.DragDropSettingsChanged(Sender: TObject);
begin
  if DragDropSettings.AllowDragObjects then
    DragMode := dmAutomatic
  else
    DragMode := dmManual;
end;

procedure TcxCustomInnerShellTreeView.GetDropTarget(out ANew: Boolean; APoint: TPoint);

  function InternalGetDropTarget(ANode: TTreeNode; out ADropTarget: IcxDropTarget): Boolean;
  var
    AItemProducer: TcxShellTreeItemProducer;
    ATempShellItemInfo: TcxShellItemInfo;
    ATempPidl: PItemIDList;
    ATempShellFolder: IShellFolder;
  begin
    if ANode.Parent = nil then
    begin // Root object selected
      ATempShellFolder := TcxShellTreeItemProducer(ANode.Data).ShellFolder;
      Result := (ATempShellFolder <> nil) and
        Succeeded(ATempShellFolder.CreateViewObject(Handle, IDropTarget, ADropTarget));
    end
    else
    begin // Non-root object selected
      AItemProducer := TcxShellTreeItemProducer(ANode.Parent.Data);
      ATempShellItemInfo := AItemProducer.Items[ANode.Index];
      ATempPidl := GetPidlCopy(ATempShellItemInfo.pidl);
      try
        if ATempShellItemInfo.IsFolder then
          Result := Succeeded(AItemProducer.ShellFolder.BindToObject(ATempPidl,
            nil, IID_IShellFolder, ATempShellFolder)) and
            Succeeded(ATempShellFolder.CreateViewObject(Handle, IDropTarget, ADropTarget))
        else
          Result := Succeeded(AItemProducer.ShellFolder.GetUIObjectOf(Handle, 1,
            ATempPidl, IDropTarget, nil, ADropTarget));
      finally
        DisposePidl(ATempPidl);
      end;
    end;
  end;

var
  ANode: TTreeNode;
  ADropTarget: IcxDropTarget;
begin
  APoint := ScreenToClient(APoint);
  ANode := GetNodeAt(APoint.X, APoint.Y);
  if ANode = nil then
    TryReleaseDropTarget;
  ANew := (ANode <> nil) and ((ANode <> PrevTargetNode) or (CurrentDropTarget = nil));
  if ANew then
  begin
    TryReleaseDropTarget;
    if InternalGetDropTarget(ANode, ADropTarget) then
    begin
      PrevTargetNode := ANode;
      CurrentDropTarget := ADropTarget;
    end;
  end;
end;

function TcxCustomInnerShellTreeView.GetNodeByPIDL(APIDL: PItemIDList): TTreeNode;
var
  AItemIndex, I: Integer;
  APID: PItemIDList;
begin
  Result := nil;
  if APIDL = nil then
    Exit;

  if Root.ShellFolder = nil then
    Root.CheckRoot;
  if EqualPIDLs(Root.Pidl, APIDL) then
  begin
    Result := Items[0];
    Exit;
  end;

  if not IsSubPath(Root.Pidl, APIDL) then
    Exit;

  for I := 0 to GetPidlItemsCount(Root.Pidl) - 1 do
    APIDL := GetNextItemID(APIDL);
  Result := Items[0];
  for I := 0 to GetPidlItemsCount(APIDL) - 1 do
  begin
    APID := ExtractParticularPidl(APIDL);
    if APID = nil then
      Break;
    try
      AItemIndex := TcxShellTreeItemProducer(Result.Data).GetItemIndexByPidl(APID);
      if (AItemIndex = -1) or (AItemIndex >= Result.Count) then
      begin
        Result := nil;
        Break;
      end;
      Result := Result.Item[AItemIndex];
      APIDL := GetNextItemID(APIDL);
    finally
      DisposePidl(APID);
    end;
  end;
end;

function TcxCustomInnerShellTreeView.IsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

procedure TcxCustomInnerShellTreeView.RemoveChangeNotification;
begin
  UnregisterShellChangeNotifier(FShellChangeNotifierData);
end;

procedure TcxCustomInnerShellTreeView.RemoveDropTarget;
begin
  RevokeDragDrop(Handle);
end;

procedure TcxCustomInnerShellTreeView.RemoveItemProducer(
  AProducer: TcxShellTreeItemProducer);
var
  ATempList: TList;
begin
  ATempList := ItemProducersList.LockList;
  try
    ATempList.Remove(AProducer);
  finally
    ItemProducersList.UnlockList;
  end;
end;

procedure TcxCustomInnerShellTreeView.Change(Node: TTreeNode);
begin
  inherited Change(Node);
  UpdateNode(Selected, not Navigation);
  if not Navigation then
    DoNavigateListView;
end;

procedure TcxCustomInnerShellTreeView.DsmDoNavigate(var Message: TMessage);
var
  ASourcePidl, ADestPidl: PItemIDList;
  AShellFolder: IShellFolder;
  APartDstPidl: PItemIDList;
  I: Integer;
  ATempProducer: TcxShellTreeItemProducer;
  ATempIndex: Integer;
begin
  if Failed(SHGetDesktopFolder(AShellFolder)) then
    Exit;
  Navigation := True;
  Items.BeginUpdate;
  try
    ASourcePidl := Root.Pidl;
    ADestPidl := PItemIDList(Message.WParam);
    if GetPidlItemsCount(ASourcePidl) > GetPidlItemsCount(ADestPidl) then
    begin
      Root.Pidl := ADestPidl;
      Items[0].Selected := True;
      Exit;
    end;
    for I := 0 to GetPidlItemsCount(ASourcePidl) - 1 do
      ADestPidl := GetNextItemID(ADestPidl);
    Selected := Items[0];
    for I := 0 to GetPidlItemsCount(ADestPidl) - 1 do
    begin
      ATempProducer := Selected.Data;
      APartDstPidl := ExtractParticularPidl(ADestPidl);
      ADestPidl := GetNextItemID(ADestPidl);
      if APartDstPidl = nil then
        Break;
      try
        ATempIndex := ATempProducer.GetItemIndexByPidl(APartDstPidl);
        if ATempIndex = -1 then
          Break;
        Selected := Selected.Item[ATempIndex];
      finally
        DisposePidl(APartDstPidl);
      end;
    end;
  finally
    Items.EndUpdate;
    Navigation := False;
  end;

  if Selected <> nil then
    PostMessage(Handle, TVM_ENSUREVISIBLE, 0, LPARAM(Selected.ItemId));
end;

{ TcxShellTreeItemProducer }

function TcxShellTreeItemProducer.GetItemsInfoGatherer: TcxShellItemsInfoGatherer;
begin
  Result := TreeView.ItemsInfoGatherer;
end;

procedure TcxShellTreeItemProducer.CheckForSubitems(
  AItem: TcxShellItemInfo);
begin
  inherited CheckForSubitems(AItem);
  if (AItem <> nil) and (not AItem.IsRemovable) then
    AItem.CheckSubitems(ShellFolder, GetEnumFlags);
end;

function TcxShellTreeItemProducer.CheckUpdates: Boolean;

  procedure PopulateNewItemsList(pEnum: IEnumIDList; ANewItems: TList);
  var
    ACurrentCelt: Cardinal;
    APidl: PItemIDList;
    AItem: TcxShellItemInfo;
    AHResult: HRESULT;
  begin
    ACurrentCelt := 1;
    repeat
      AHResult := pEnum.Next(ACurrentCelt, APidl, ACurrentCelt);
      try
        if AHResult = E_INVALIDARG then
        begin
          ACurrentCelt := 1;
          AHResult := pEnum.Next(ACurrentCelt, APidl, ACurrentCelt);
        end;
        if Succeeded(AHResult) and (AHResult <> S_FALSE) and (ACurrentCelt <> 0) then
        begin
          AItem := TcxShellItemInfo.Create(Self, ShellFolder, FolderPidl, APidl, False);
          if AItem.Name <> '' then
            ANewItems.Add(AItem)
          else
            AItem.Free;
        end
        else
          AHResult := S_FALSE;
      finally
        DisposePidl(APidl);
      end;
    until (AHResult = S_FALSE);
  end;

  function ShellSortFunction(AItem1, AItem2: Pointer): Integer;
  var
    AItemInfo1, AItemInfo2: TcxShellItemInfo;
  begin
    Result := 0;
    if (AItem1 = nil) or (AItem2 = nil) then
       Exit;
    AItemInfo1 := TcxShellItemInfo(AItem1);
    AItemInfo2 := TcxShellItemInfo(AItem2);
    Result := Byte(AItemInfo2.IsFolder) - Byte(AItemInfo1.IsFolder);
    if Result = 0 then
      Result := SmallInt(TcxShellTreeItemProducer(
        AItemInfo1.ItemProducer).ShellFolder.CompareIDs(0, AItemInfo1.pidl, AItemInfo2.pidl));
  end;

  procedure MergeItems(AItems, ANewItems: TList);
  var
    I, J: Integer;
    AItem, ANewItem: TcxShellItemInfo;
    AFounded: Boolean;
  begin
    I := 0;
    while (I < AItems.Count) do
    begin
      AItem := AItems[I];
      AFounded := False;
      for J := 0 to ANewItems.Count - 1 do
      begin
        ANewItem := ANewItems[J];
        if SmallInt(ShellFolder.CompareIDs(0, AItem.pidl, ANewItem.pidl)) = 0 then
        begin
          AItem.Free;
          AItems[I] := ANewItem;
          ANewItems.Remove(ANewItem);
          AFounded := True;
          Break;
        end;
      end;
      if not AFounded then
      begin
        NotifyRemoveItem(I);
        AItems.Remove(AItem);
        AItem.Free;
      end
      else
        Inc(I);
    end;
    for I := 0 to ANewItems.Count - 1 do
      if CanAddFolder(TcxShellItemInfo(ANewItems[I]).Folder) then
      begin
        AItems.Add(ANewItems[I]);
        AItem := AItems.Last;
        AItem.CheckUpdate(ShellFolder, FolderPidl, False);
        NotifyAddItem(AItems.Count - 1);
      end
      else
        TcxShellItemInfo(ANewItems[I]).Free;
  end;

var
  pEnum: IEnumIDList;
  ANewItems: TList;
begin
  Result := False;
  if (ShellFolder <> nil) and Succeeded(ShellFolder.EnumObjects(Owner.ParentWindow,
    GetEnumFlags, pEnum)) and Assigned(pEnum) then
  begin
    ANewItems := TList.Create;
    ShowHourglassCursor;
    try
      PopulateNewItemsList(pEnum, ANewItems);
      ANewItems.Sort(@ShellSortFunction);
      LockWrite;
      try
        MergeItems(Items, ANewItems);
      finally
        UnlockWrite;
      end;
    finally
      HideHourglassCursor;
      FreeAndNil(ANewItems);
    end;
    Result := True;
  end;
end;

constructor TcxShellTreeItemProducer.Create(AOwner: TWinControl);
begin
  inherited Create(AOwner);
  TreeView.AddItemProducer(Self);
end;

destructor TcxShellTreeItemProducer.Destroy;
begin
  if Assigned(FOnDestroy) then
    FOnDestroy(Self);
  TreeView.RemoveItemProducer(Self);
  inherited Destroy;
end;

function TcxShellTreeItemProducer.AllowBackgroundProcessing: Boolean;
begin
  Result:= not TreeView.Navigation;
end;

function TcxShellTreeItemProducer.CanAddFolder(AFolder: TcxShellFolder): Boolean;
begin
  Result := TreeView.DoAddFolder(AFolder);
end;

function TcxShellTreeItemProducer.GetEnumFlags: Cardinal;
begin
  Result := TreeView.Options.GetEnumFlags;
end;

function TcxShellTreeItemProducer.GetShowToolTip: Boolean;
begin
  Result := TreeView.ShowInfoTips;
end;

procedure TcxShellTreeItemProducer.InitializeItem(Item: TcxShellItemInfo);
begin
  inherited;
  Item.CheckUpdate(ShellFolder, FolderPidl, False);
  CheckForSubitems(Item);
end;

procedure TcxShellTreeItemProducer.NotifyAddItem(Index: Integer);
begin
  if (Owner.HandleAllocated) and (Node <> nil) then
    SendMessage(Owner.Handle, DSM_NOTIFYADDITEM, Index, Integer(Node));
end;

procedure TcxShellTreeItemProducer.NotifyRemoveItem(Index: Integer);
begin
  if (Owner.HandleAllocated) and (Node <> nil) then
    SendMessage(Owner.Handle, DSM_NOTIFYREMOVEITEM, Index, Integer(Node));
end;

procedure TcxShellTreeItemProducer.NotifyUpdateItem(AItem: PcxRequestItem);
begin
  if (Owner.HandleAllocated) and (Node <> nil) then
    PostMessage(Owner.Handle, DSM_NOTIFYUPDATE, AItem.ItemIndex, Integer(Node));
end;

procedure TcxShellTreeItemProducer.ProcessItems(AIFolder: IShellFolder;
  APIDL: PItemIDList; ANode: TTreeNode; cPreloadItems: Integer);

  function SetNodeText: Boolean;
  var
    ATempPIDL: PItemIDList;
  begin
    Result := ANode.Parent <> nil;
    if not Result then
      Exit;
    ATempPIDL := GetLastPidlItem(APIDL);
    Node.Text := GetShellItemDisplayName(
      TcxShellTreeItemProducer(Node.Parent.Data).ShellFolder, ATempPIDL, True);
  end;

var
  AFileInfo: TShFileInfo;
begin
  Node := ANode;
  cxShellGetThreadSafeFileInfo(PChar(APIDL), 0, AFileInfo, SizeOf(AFileInfo),
    SHGFI_PIDL or SHGFI_DISPLAYNAME or SHGFI_SYSICONINDEX);
  if not SetNodeText then
    Node.Text := StrPas(AFileInfo.szDisplayName);
  ANode.ImageIndex := AFileInfo.iIcon;
  cxShellGetThreadSafeFileInfo(PChar(APIDL), 0, AFileInfo, SizeOf(AFileInfo),
    SHGFI_PIDL or SHGFI_SYSICONINDEX or SHGFI_OPENICON);
  Node.SelectedIndex := AFileInfo.iIcon;
  ProcessItems(AIFolder, APIDL, cPreloadItems);
end;

procedure TcxShellTreeItemProducer.SetItemsCount(Count: Integer);
begin
  if (Owner.HandleAllocated) and (Node <> nil) then
     SendMessage(Owner.Handle, DSM_SETCOUNT, Count, Integer(Node));
end;

function TcxShellTreeItemProducer.GetTreeView: TcxCustomInnerShellTreeView;
begin
  Result := TcxCustomInnerShellTreeView(Owner);
end;

initialization
  NavigationLock := False;

end.

