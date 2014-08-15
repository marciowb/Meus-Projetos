{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }


unit ppTB2Item;
                                                       
{
  Toolbar2000
  Copyright (C) 1998-2004 by Jordan Russell
  All rights reserved.

  The contents of this file are subject to the "Toolbar2000 License"; you may
  not use or distribute this file except in compliance with the
  "Toolbar2000 License". A copy of the "Toolbar2000 License" may be found in
  TB2k-LICENSE.txt or at:
    http://www.jrsoftware.org/files/tb2k/TB2k-LICENSE.txt

  Alternatively, the contents of this file may be used under the terms of the
  GNU General Public License (the "GPL"), in which case the provisions of the
  GPL are applicable instead of those in the "Toolbar2000 License". A copy of
  the GPL may be found in GPL-LICENSE.txt or at:
    http://www.jrsoftware.org/files/tb2k/GPL-LICENSE.txt
  If you wish to allow use of your version of this file only under the terms of
  the GPL and not to allow others to use your version of this file under the
  "Toolbar2000 License", indicate your decision by deleting the provisions
  above and replace them with the notice and other provisions required by the
  GPL. If you do not delete the provisions above, a recipient may use your
  version of this file under either the "Toolbar2000 License" or the GPL.

  $jrsoftware: tb2k/Source/TB2Item.pas,v 1.259 2004/05/05 08:43:18 jr Exp $
}

interface

{$I ppTB2Ver.inc}
{x$DEFINE TB2K_NO_ANIMATION}
  { Enabling the above define disables all menu animation. For debugging
    purpose only. }
{x$DEFINE TB2K_USE_STRICT_O2K_MENU_STYLE}
  { Enabling the above define forces it to use clBtnFace for the menu color
    instead of clMenu, and disables the use of flat menu borders on Windows
    XP with themes enabled. }

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CommCtrl, Menus, ActnList, ImgList,
  
  ppTB2Anim;

const
  WM_TB2K_POPUPSHOWING = WM_USER + 554;

  { Parameter in LParam of WM_TB2K_POPUPSHOWING }
  TPS_ANIMSTART     = 1;   // animation query: if Result <> 0, do not animate!
  TPS_ANIMFINISHED  = 2;   // only fired when animation thread is done
  TPS_NOANIM        = 3;   // fired when animation is done, or if showing with no animation

type
  TppTBCustomItem = class;
  TppTBCustomItemClass = class of TppTBCustomItem;
  TppTBCustomItemActionLink = class;
  TppTBCustomItemActionLinkClass = class of TppTBCustomItemActionLink;
  TppTBItemViewer = class;
  TppTBItemViewerClass = class of TppTBItemViewer;
  TppTBPopupWindow = class;
  TppTBPopupWindowClass = class of TppTBPopupWindow;
  TppTBView = class;

  TppTBDoneAction = (tbdaNone, tbdaCancel, tbdaClickItem, tbdaOpenSystemMenu,
    tbdaHelpContext);
  PTBDoneActionData = ^TppTBDoneActionData;
  TppTBDoneActionData = record
    DoneAction: TppTBDoneAction;
    case TppTBDoneAction of
      tbdaClickItem: (ClickItem: TppTBCustomItem; Sound: Boolean);
      tbdaOpenSystemMenu: (Wnd: HWND; Key: Cardinal);
      tbdaHelpContext: (ContextID: Integer);
  end;
  TppTBInsertItemProc = procedure(AParent: TComponent; AItem: TppTBCustomItem) of object;
  TppTBItemChangedAction = (tbicInserted, tbicDeleting, tbicSubitemsChanged,
    tbicSubitemsBeginUpdate, tbicSubitemsEndUpdate, tbicInvalidate,
    tbicInvalidateAndResize, tbicRecreateItemViewers, tbicNameChanged,
    tbicSubMenuImagesChanged);
  TppTBItemChangedProc = procedure(Sender: TppTBCustomItem; Relayed: Boolean;
    Action: TppTBItemChangedAction; Index: Integer; Item: TppTBCustomItem) of object;
  TppTBItemData = record
    Item: TppTBCustomItem;
  end;
  PTBItemDataArray = ^TppTBItemDataArray;
  TppTBItemDataArray = array[0..$7FFFFFFF div SizeOf(TppTBItemData)-1] of TppTBItemData;
  TppTBItemDisplayMode = (nbdmDefault, nbdmTextOnly, nbdmTextOnlyInMenus, nbdmImageAndText);
  TppTBItemOption = (tboDefault, tboDropdownArrow, tboImageAboveCaption,
    tboLongHintInMenuOnly, tboNoAutoHint, tboNoRotation, tboSameWidth,
    tboShowHint, tboToolbarStyle, tboToolbarSize);
  TppTBItemOptions = set of TppTBItemOption;
  TppTBItemStyle = set of (tbisSubmenu, tbisSelectable, tbisSeparator,
    tbisEmbeddedGroup, tbisClicksTransparent, tbisCombo, tbisNoAutoOpen,
    tbisSubitemsEditable, tbisNoLineBreak, tbisRightAlign, tbisDontSelectFirst,
    tbisRedrawOnSelChange, tbisRedrawOnMouseOverChange, tbisStretch);
  TppTBPopupAlignment = (tbpaLeft, tbpaRight, tbpaCenter);
  TppTBPopupEvent = procedure(Sender: TppTBCustomItem; FromLink: Boolean) of object;
  TppTBSelectEvent = procedure(Sender: TppTBCustomItem; Viewer: TppTBItemViewer;
    Selecting: Boolean) of object;

  ETBItemError = class(Exception);

  TppTBImageChangeLink = class(TChangeLink)
  private
    FLastWidth, FLastHeight: Integer;
  end;
  {$IFNDEF JR_D5}
  TImageIndex = type Integer;
  {$ENDIF}
  TppTBPopupPositionRec = record
    PositionAsSubmenu: Boolean;
    Alignment: TppTBPopupAlignment;
    Opposite: Boolean;
    MonitorRect: TRect;
    ParentItemRect: TRect;
    NCSizeX: Integer;
    NCSizeY: Integer;
    X, Y, W, H: Integer;
    AnimDir: TppTBAnimationDirection;
    PlaySound: Boolean;
  end;

  TppTBCustomItem = class(TComponent)
  private
    FActionLink: TppTBCustomItemActionLink;
    FAutoCheck: Boolean;
    FCaption: String;
    FChecked: Boolean;
    FDisplayMode: TppTBItemDisplayMode;
    FEnabled: Boolean;
    FEffectiveOptions: TppTBItemOptions;
    FGroupIndex: Integer;
    FHelpContext: THelpContext;
    FHint: String;
    FImageIndex: TImageIndex;
    FImages: TCustomImageList;
    FImagesChangeLink: TppTBImageChangeLink;
    FItems: PTBItemDataArray;
    FItemCount: Integer;
    FItemStyle: TppTBItemStyle;
    FLinkParents: TList;
    FMaskOptions: TppTBItemOptions;
    FOptions: TppTBItemOptions;
    FInheritOptions: Boolean;
    FNotifyList: TList;
    FOnClick: TNotifyEvent;
    FOnPopup: TppTBPopupEvent;
    FOnSelect: TppTBSelectEvent;
    FParent: TppTBCustomItem;
    FParentComponent: TComponent;
    FShortCut: TShortCut;
    FSubMenuImages: TCustomImageList;
    FSubMenuImagesChangeLink: TppTBImageChangeLink;
    FLinkSubitems: TppTBCustomItem;
    FVisible: Boolean;

    procedure DoActionChange(Sender: TObject);
    function ChangeImages(var AImages: TCustomImageList;
      const Value: TCustomImageList; var AChangeLink: TppTBImageChangeLink): Boolean;
    class procedure ClickWndProc(var Message: TMessage);
    function FindItemWithShortCut(AShortCut: TShortCut;
      var ATopmostParent: TppTBCustomItem): TppTBCustomItem;
    function FixOptions(const AOptions: TppTBItemOptions): TppTBItemOptions;
    function GetAction: TBasicAction;
    function GetItem(Index: Integer): TppTBCustomItem;
    procedure ImageListChangeHandler(Sender: TObject);
    procedure InternalNotify(Ancestor: TppTBCustomItem; NestingLevel: Integer;
      Action: TppTBItemChangedAction; Index: Integer; Item: TppTBCustomItem);
    {$IFDEF JR_D6}
    function IsAutoCheckStored: Boolean;
    {$ENDIF}
    function IsCaptionStored: Boolean;
    function IsCheckedStored: Boolean;
    function IsEnabledStored: Boolean;
    function IsHelpContextStored: Boolean;
    function IsHintStored: Boolean;
    function IsImageIndexStored: Boolean;
    function IsOnClickStored: Boolean;
    function IsShortCutStored: Boolean;
    function IsVisibleStored: Boolean;
    procedure Notify(Action: TppTBItemChangedAction; Index: Integer; Item: TppTBCustomItem);
    procedure RefreshOptions;
    procedure SetAction(Value: TBasicAction);
    procedure SetCaption(Value: String);
    procedure SetChecked(Value: Boolean);
    procedure SetDisplayMode(Value: TppTBItemDisplayMode);
    procedure SetEnabled(Value: Boolean);
    procedure SetGroupIndex(Value: Integer);
    procedure SetImageIndex(Value: TImageIndex);
    procedure SetImages(Value: TCustomImageList);
    procedure SetInheritOptions(Value: Boolean);
    procedure SetLinkSubitems(Value: TppTBCustomItem);
    procedure SetMaskOptions(Value: TppTBItemOptions);
    procedure SetOptions(Value: TppTBItemOptions);
    procedure SetSubMenuImages(Value: TCustomImageList);
    procedure SetVisible(Value: Boolean);
    procedure SubMenuImagesChanged;
    procedure TurnSiblingsOff;
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); dynamic;
    procedure Change(NeedResize: Boolean); virtual;
    function CreatePopup(const ParentView: TppTBView; const ParentViewer: TppTBItemViewer;
      const PositionAsSubmenu, SelectFirstItem, Customizing: Boolean;
      const APopupPoint: TPoint; const Alignment: TppTBPopupAlignment): TppTBPopupWindow; virtual;
    procedure DoPopup(Sender: TppTBCustomItem; FromLink: Boolean); virtual;
    procedure EnabledChanged; virtual;
    function GetActionLinkClass: TppTBCustomItemActionLinkClass; dynamic;
    function GetChevronParentView: TppTBView; virtual;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass; virtual;
    procedure GetPopupPosition(ParentView: TppTBView;
      PopupWindow: TppTBPopupWindow; var PopupPositionRec: TppTBPopupPositionRec); virtual;
    function GetPopupWindowClass: TppTBPopupWindowClass; virtual;
    procedure IndexError;
    procedure Loaded; override;
    function NeedToRecreateViewer(AViewer: TppTBItemViewer): Boolean; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure OpenPopup(const SelectFirstItem, TrackRightButton: Boolean;
      const PopupPoint: TPoint; const Alignment: TppTBPopupAlignment);
    procedure RecreateItemViewers;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParentComponent(Value: TComponent); override;

    property ActionLink: TppTBCustomItemActionLink read FActionLink write FActionLink;
    property ItemStyle: TppTBItemStyle read FItemStyle write FItemStyle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function HasParent: Boolean; override;
    function GetParentComponent: TComponent; override;

    procedure Add(AItem: TppTBCustomItem);
    procedure Clear;
    procedure Click; virtual;
    function ContainsItem(AItem: TppTBCustomItem): Boolean;
    procedure Delete(Index: Integer);
    function GetShortCutText: String;
    function IndexOf(AItem: TppTBCustomItem): Integer;
    procedure InitiateAction; virtual;
    procedure Insert(NewIndex: Integer; AItem: TppTBCustomItem);
    function IsShortCut(var Message: TWMKey): Boolean;
    procedure Move(CurIndex, NewIndex: Integer);
    procedure Popup(X, Y: Integer; TrackRightButton: Boolean;
      Alignment: TppTBPopupAlignment = tbpaLeft);
    procedure PostClick;
    procedure RegisterNotification(ANotify: TppTBItemChangedProc);
    procedure Remove(Item: TppTBCustomItem);
    procedure UnregisterNotification(ANotify: TppTBItemChangedProc);
    procedure ViewBeginUpdate;
    procedure ViewEndUpdate;

    property Action: TBasicAction read GetAction write SetAction;
    property AutoCheck: Boolean read FAutoCheck write FAutoCheck {$IFDEF JR_D6} stored IsAutoCheckStored {$ENDIF} default False;
    property Caption: String read FCaption write SetCaption stored IsCaptionStored;
    property Count: Integer read FItemCount;
    property Checked: Boolean read FChecked write SetChecked stored IsCheckedStored default False;
    property DisplayMode: TppTBItemDisplayMode read FDisplayMode write SetDisplayMode default nbdmDefault;
    property EffectiveOptions: TppTBItemOptions read FEffectiveOptions;
    property Enabled: Boolean read FEnabled write SetEnabled stored IsEnabledStored default True;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    property HelpContext: THelpContext read FHelpContext write FHelpContext stored IsHelpContextStored default 0;
    property Hint: String read FHint write FHint stored IsHintStored;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex stored IsImageIndexStored default -1;
    property Images: TCustomImageList read FImages write SetImages;
    property InheritOptions: Boolean read FInheritOptions write SetInheritOptions default True;
    property Items[Index: Integer]: TppTBCustomItem read GetItem; default;
    property LinkSubitems: TppTBCustomItem read FLinkSubitems write SetLinkSubitems;
    property MaskOptions: TppTBItemOptions read FMaskOptions write SetMaskOptions default [];
    property Options: TppTBItemOptions read FOptions write SetOptions default [];
    property Parent: TppTBCustomItem read FParent;
    property ParentComponent: TComponent read FParentComponent write FParentComponent;
    property ShortCut: TShortCut read FShortCut write FShortCut stored IsShortCutStored default 0;
    property SubMenuImages: TCustomImageList read FSubMenuImages write SetSubMenuImages;
    property Visible: Boolean read FVisible write SetVisible stored IsVisibleStored default True;
    property OnClick: TNotifyEvent read FOnClick write FOnClick stored IsOnClickStored;
    property OnPopup: TppTBPopupEvent read FOnPopup write FOnPopup;
    property OnSelect: TppTBSelectEvent read FOnSelect write FOnSelect;
  end;

  TppTBCustomItemActionLink = class(TActionLink)
  protected
    FClient: TppTBCustomItem;
    procedure AssignClient(AClient: TObject); override;
    {$IFDEF JR_D6}
    function IsAutoCheckLinked: Boolean; virtual;
    {$ENDIF}
    function IsCaptionLinked: Boolean; override;
    function IsCheckedLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsHelpContextLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    function IsShortCutLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    {$IFDEF JR_D6}
    procedure SetAutoCheck(Value: Boolean); override;
    {$ENDIF}
    procedure SetCaption(const Value: String); override;
    procedure SetChecked(Value: Boolean); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHelpContext(Value: THelpContext); override;
    procedure SetHint(const Value: String); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetShortCut(Value: TShortCut); override;
    procedure SetVisible(Value: Boolean); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
  end;

  TppTBBaseAccObject = class(TInterfacedObject, IDispatch)
  public
    procedure ClientIsDestroying; virtual; abstract;
    { IDispatch }
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  end;

  TppTBItemViewer = class
  private
    FBoundsRect: TRect;
    FClipped: Boolean;
    FGroupLevel: Integer;
    FItem: TppTBCustomItem;
    FOffEdge: Boolean;
    FShow: Boolean;
    FView: TppTBView;
    procedure AccSelect(const AExecute: Boolean);
    function GetIndex: Integer;
  protected
    FAccObjectInstance: TppTBBaseAccObject;
    procedure CalcSize(const Canvas: TCanvas; var AWidth, AHeight: Integer);
      virtual;
    function CaptionShown: Boolean; dynamic;
    function DoExecute: Boolean; virtual;
    procedure DrawItemCaption(const Canvas: TCanvas; ARect: TRect;
      const ACaption: String; ADrawDisabledShadow: Boolean; AFormat: UINT); virtual;
    procedure Entering(OldSelected: TppTBItemViewer); virtual;
    function GetAccRole: Integer; virtual;
    function GetAccValue(var Value: WideString): Boolean; virtual;
    function GetCaptionText: String; virtual;
    procedure GetCursor(const Pt: TPoint; var ACursor: HCURSOR); virtual;
    function GetImageList: TCustomImageList;
    function ImageShown: Boolean;
    function IsRotated: Boolean;
    function IsToolbarSize: Boolean; virtual;
    function IsPtInButtonPart(X, Y: Integer): Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure Leaving; virtual;
    procedure LosingCapture; virtual;
    procedure MouseDown(Shift: TShiftState; X, Y: Integer;
      var MouseDownOnMenu: Boolean); virtual;
    procedure MouseMove(X, Y: Integer); virtual;
    procedure MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean); virtual;
    procedure MouseWheel(WheelDelta: Integer; X, Y: Integer); virtual;
    procedure Paint(const Canvas: TCanvas; const ClientAreaRect: TRect;
      IsSelected, IsPushed, UseDisabledShadow: Boolean); virtual;
    procedure PostAccSelect(const AExecute: Boolean);
    function UsesSameWidth: Boolean; virtual;
  public
    State: set of (tbisInvalidated, tbisLineSep);
    property BoundsRect: TRect read FBoundsRect;
    property Clipped: Boolean read FClipped;
    property Index: Integer read GetIndex;
    property Item: TppTBCustomItem read FItem;
    property OffEdge: Boolean read FOffEdge;
    property Show: Boolean read FShow;
    property View: TppTBView read FView;
    constructor Create(AView: TppTBView; AItem: TppTBCustomItem; AGroupLevel: Integer); virtual;
    destructor Destroy; override;
    procedure Execute(AGivePriority: Boolean);
    function GetAccObject: IDispatch;
    function GetHintText: String;
    function IsAccessible: Boolean;
    function IsToolbarStyle: Boolean; virtual;
    function ScreenToClient(const P: TPoint): TPoint;
  end;
  PTBItemViewerArray = ^TppTBItemViewerArray;
  TppTBItemViewerArray = array[0..$7FFFFFFF div SizeOf(TppTBItemViewer)-1] of TppTBItemViewer;
  TppTBViewOrientation = (tbvoHorizontal, tbvoVertical, tbvoFloating);
  TppTBEnterToolbarLoopOptions = set of (tbetMouseDown, tbetExecuteSelected,
    tbetFromMSAA);
  TppTBViewState = set of (vsModal, vsMouseInWindow, vsDrawInOrder, vsOppositePopup,
    vsIgnoreFirstMouseUp, vsShowAccels, vsDropDownMenus, vsNoAnimation);
  TppTBViewStyle = set of (vsMenuBar, vsUseHiddenAccels, vsAlwaysShowHints);
  TppTBViewTimerID = (tiOpen, tiClose, tiScrollUp, tiScrollDown);

  TppTBViewClass = class of TppTBView;
  TppTBView = class(TComponent)
  private
    FActiveTimers: set of TppTBViewTimerID;
    FBackgroundColor: TColor;
    FBaseSize: TPoint;
    FCapture: Boolean;
    FCaptureWnd: HWND;
    FChevronOffset: Integer;
    FChevronParentView: TppTBView;
    FChevronSize: Integer;
    FCurParentItem: TppTBCustomItem;
    FCustomizing: Boolean;
    FDoneActionData: TppTBDoneActionData;
    FInternalViewersAtEnd: Integer;
    FInternalViewersAtFront: Integer;
    FIsPopup: Boolean;
    FIsToolbar: Boolean;
    FMaxHeight: Integer;
    FMonitorRect: TRect;
    FMouseOverSelected: Boolean;
    FNewViewersGetHighestPriority: Boolean;
    FOpenViewer: TppTBItemViewer;
    FOpenViewerView: TppTBView;
    FOpenViewerWindow: TppTBPopupWindow;
    FParentView: TppTBView;
    FParentItem: TppTBCustomItem;
    FPriorityList: TList;
    FOrientation: TppTBViewOrientation;
    FScrollOffset: Integer;
    FSelected: TppTBItemViewer;
    FSelectedViaMouse: Boolean;
    FShowDownArrow: Boolean;
    FShowUpArrow: Boolean;
    FState: TppTBViewState;
    FStyle: TppTBViewStyle;
    FUpdating: Integer;
    FUsePriorityList: Boolean;
    FValidated: Boolean;
    FViewerCount: Integer;
    FViewers: PTBItemViewerArray;
    FWindow: TWinControl;
    FWrapOffset: Integer;

    procedure DeletingViewer(Viewer: TppTBItemViewer);
    procedure DrawItem(Viewer: TppTBItemViewer; DrawTo: TCanvas; Offscreen: Boolean);
    procedure FreeViewers;
    procedure ImagesChanged;
    function InsertItemViewers(const NewIndex: Integer;
      const AItem: TppTBCustomItem; const AGroupLevel: Integer;
      const AddToPriorityList, TopOfPriorityList: Boolean): Integer;
    procedure ItemNotification(Ancestor: TppTBCustomItem; Relayed: Boolean;
      Action: TppTBItemChangedAction; Index: Integer; Item: TppTBCustomItem);
    procedure LinkNotification(Ancestor: TppTBCustomItem; Relayed: Boolean;
      Action: TppTBItemChangedAction; Index: Integer; Item: TppTBCustomItem);
    procedure RecreateItemViewer(const I: Integer);
    procedure Scroll(ADown: Boolean);
    procedure SetCustomizing(Value: Boolean);
    procedure SetSelected(Value: TppTBItemViewer);
    procedure SetUsePriorityList(Value: Boolean);
    procedure StartTimer(const ATimer: TppTBViewTimerID; const Interval: Integer);
    procedure StopAllTimers;
    procedure StopTimer(const ATimer: TppTBViewTimerID);
    procedure UpdateCurParentItem;
  protected
    FAccObjectInstance: TppTBBaseAccObject;
    procedure AutoSize(AWidth, AHeight: Integer); virtual;
    function CalculatePositions(const CanMoveControls: Boolean;
      const AOrientation: TppTBViewOrientation;
      AWrapOffset, AChevronOffset, AChevronSize: Integer;
      var ABaseSize, TotalSize: TPoint;
      var AWrappedLines: Integer): Boolean;
    procedure DoUpdatePositions(var ASize: TPoint); virtual;
    function GetChevronItem: TppTBCustomItem; virtual;
    procedure GetMargins(AOrientation: TppTBViewOrientation; var Margins: TRect);
      virtual;
    function GetMDIButtonsItem: TppTBCustomItem; virtual;
    function GetMDISystemMenuItem: TppTBCustomItem; virtual;
    function GetParentToolbarView: TppTBView;
    function GetRootView: TppTBView;
    function HandleWMGetObject(var Message: TMessage): Boolean;
    procedure InitiateActions;
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetAccelsVisibility(AShowAccels: Boolean);
    procedure SetState(AState: TppTBViewState);
    property DoneActionData: TppTBDoneActionData read FDoneActionData write FDoneActionData;
  public
    constructor CreateView(AOwner: TComponent; AParentView: TppTBView;
      AParentItem: TppTBCustomItem; AWindow: TWinControl;
      AIsToolbar, ACustomizing, AUsePriorityList: Boolean); virtual;
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure CancelCapture;
    procedure CancelChildPopups;
    procedure CloseChildPopups;
    function ContainsView(AView: TppTBView): Boolean;
    procedure DrawSubitems(ACanvas: TCanvas);
    procedure EndModal;
    procedure EndModalWithClick(AViewer: TppTBItemViewer);
    procedure EndModalWithHelp(AContextID: Integer);
    procedure EndModalWithSystemMenu(AWnd: HWND; AKey: Cardinal);
    procedure EndUpdate;
    procedure EnterToolbarLoop(Options: TppTBEnterToolbarLoopOptions);
    procedure ExecuteSelected(AGivePriority: Boolean);
    function Find(Item: TppTBCustomItem): TppTBItemViewer;
    function FirstSelectable: TppTBItemViewer;
    function GetAccObject: IDispatch;
    function GetCaptureWnd: HWND;
    function GetFont: TFont; virtual;
    procedure GetOffEdgeControlList(const List: TList);
    procedure GivePriority(AViewer: TppTBItemViewer);
    function HighestPriorityViewer: TppTBItemViewer;
    procedure Invalidate(AViewer: TppTBItemViewer);
    procedure InvalidatePositions; virtual;
    function IndexOf(AViewer: TppTBItemViewer): Integer;
    function NextSelectable(CurViewer: TppTBItemViewer; GoForward: Boolean): TppTBItemViewer;
    function NextSelectableWithAccel(CurViewer: TppTBItemViewer; Key: Char;
      RequirePrimaryAccel: Boolean; var IsOnlyItemWithAccel: Boolean): TppTBItemViewer;
    procedure NotifyFocusEvent;
    function OpenChildPopup(const SelectFirstItem: Boolean): Boolean;
    procedure RecreateAllViewers;
    procedure ScrollSelectedIntoView;
    procedure Select(Value: TppTBItemViewer; ViaMouse: Boolean);
    procedure SetCapture;
    procedure TryValidatePositions;
    procedure UpdateSelection(const P: PPoint; const AllowNewSelection: Boolean);
    function UpdatePositions: TPoint;
    procedure ValidatePositions;
    function ViewerFromPoint(const P: TPoint): TppTBItemViewer;

    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;
    property BaseSize: TPoint read FBaseSize;
    property Capture: Boolean read FCapture;
    property ChevronOffset: Integer read FChevronOffset write FChevronOffset;
    property ChevronSize: Integer read FChevronSize write FChevronSize;
    property Customizing: Boolean read FCustomizing write SetCustomizing;
    property IsPopup: Boolean read FIsPopup;
    property IsToolbar: Boolean read FIsToolbar;
    property MouseOverSelected: Boolean read FMouseOverSelected;
    property NewViewersGetHighestPriority: Boolean read FNewViewersGetHighestPriority
      write FNewViewersGetHighestPriority;
    property ParentView: TppTBView read FParentView;
    property ParentItem: TppTBCustomItem read FParentItem;
    property OpenViewer: TppTBItemViewer read FOpenViewer;
    property OpenViewerView: TppTBView read FOpenViewerView;
    property Orientation: TppTBViewOrientation read FOrientation write FOrientation;
    property Selected: TppTBItemViewer read FSelected write SetSelected;
    property SelectedViaMouse: Boolean read FSelectedViaMouse;
    property State: TppTBViewState read FState;
    property Style: TppTBViewStyle read FStyle write FStyle;
    property UsePriorityList: Boolean read FUsePriorityList write SetUsePriorityList;
    property Viewers: PTBItemViewerArray read FViewers;
    property ViewerCount: Integer read FViewerCount;
    property Window: TWinControl read FWindow;
    property WrapOffset: Integer read FWrapOffset write FWrapOffset;
  end;

  TppTBRootItemClass = class of TppTBRootItem;
  TppTBRootItem = class(TppTBCustomItem);
  { same as TppTBCustomItem, except there's a property editor for it }

  TppTBItem = class(TppTBCustomItem)
  published
    property Action;
    property AutoCheck;
    property Caption;
    property Checked;
    property DisplayMode;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property Hint;
    property ImageIndex;
    property Images;
    property InheritOptions;
    property MaskOptions;
    property Options;
    property ShortCut;
    property Visible;

    property OnClick;
    property OnSelect;
  end;

  TppTBGroupItem = class(TppTBCustomItem)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property InheritOptions;
    property LinkSubitems;
    property MaskOptions;
    property Options;
  end;

  TppTBSubmenuItem = class(TppTBCustomItem)
  private
    function GetDropdownCombo: Boolean;
    procedure SetDropdownCombo(Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Action;
    property AutoCheck;
    property Caption;
    property Checked;
    //property DisplayAsToolbar;
    property DisplayMode;
    property DropdownCombo: Boolean read GetDropdownCombo write SetDropdownCombo default False;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property Hint;
    property ImageIndex;
    property Images;
    property InheritOptions;
    property LinkSubitems;
    property MaskOptions;
    property Options;
    property ShortCut;
    property SubMenuImages;
    property Visible;

    property OnClick;
    property OnPopup;
    property OnSelect;
  end;

  TppTBSeparatorItem = class(TppTBCustomItem)
  private
    FBlank: Boolean;
    procedure SetBlank(Value: Boolean);
  protected
    function GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Blank: Boolean read FBlank write SetBlank default False;
    property Hint;
    property Visible;
  end;

  TppTBSeparatorItemViewer = class(TppTBItemViewer)
  protected
    procedure CalcSize(const Canvas: TCanvas;
      var AWidth, AHeight: Integer); override;
    procedure Paint(const Canvas: TCanvas; const ClientAreaRect: TRect;
      IsSelected, IsPushed, UseDisabledShadow: Boolean); override;
    function UsesSameWidth: Boolean; override;
  end;

  TppTBControlItem = class(TppTBCustomItem)
  private
    FControl: TControl;
    FDontFreeControl: Boolean;
    procedure SetControl(Value: TControl);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateControlItem(AOwner: TComponent; AControl: TControl);
    destructor Destroy; override;
    property DontFreeControl: Boolean read FDontFreeControl write FDontFreeControl;
  published
    property Control: TControl read FControl write SetControl;
  end;

  TppTBPopupView = class(TppTBView)
  protected
    procedure AutoSize(AWidth, AHeight: Integer); override;
  public
    function GetFont: TFont; override;
  end;

  TppTBPopupWindow = class(TCustomControl)
  private
    FAccelsVisibilitySet: Boolean;
    FAnimationDirection: TppTBAnimationDirection;
    FView: TppTBView;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure WMClose(var Message: TWMClose); message WM_CLOSE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetObject(var Message: TMessage); message WM_GETOBJECT;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMPrint(var Message: TMessage); message WM_PRINT;
    procedure WMPrintClient(var Message: TMessage); message WM_PRINTCLIENT;
    procedure WMTB2kStepAnimation(var Message: TMessage); message WM_TB2K_STEPANIMATION;
    procedure WMTB2kAnimationEnded (var Message: TMessage); message WM_TB2K_ANIMATIONENDED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWindowHandle; override;
    function GetNCSize: TPoint; dynamic;
    function GetViewClass: TppTBViewClass; dynamic;
    procedure Paint; override;
    procedure PaintScrollArrows; virtual;
  public
    constructor CreatePopupWindow(AOwner: TComponent; const AParentView: TppTBView;
      const AItem: TppTBCustomItem; const ACustomizing: Boolean); virtual;
    destructor Destroy; override;
    procedure BeforeDestruction; override;

    property View: TppTBView read FView;
  end;

  IppTBItems = interface
    ['{A5C0D7CC-3EC4-4090-A0F8-3D03271877EA}']
    function GetItems: TppTBCustomItem;
  end;

  TppTBItemContainer = class(TComponent, IppTBItems)
  private
    FItem: TppTBRootItem;
    function GetImages: TCustomImageList;
    function GetItems: TppTBCustomItem;
    procedure SetImages(Value: TCustomImageList);
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Items: TppTBRootItem read FItem;
  published
    property Images: TCustomImageList read GetImages write SetImages;
  end;

  TppTBPopupMenu = class(TPopupMenu, IppTBItems)
  private
    FItem: TppTBRootItem;
    //procedure SetItems(Value: TppTBCustomItem);
    function GetImages: TCustomImageList;
    function GetItems: TppTBCustomItem;
    function GetLinkSubitems: TppTBCustomItem;
    function GetOptions: TppTBItemOptions;
    procedure RootItemClick(Sender: TObject);
    procedure SetImages(Value: TCustomImageList);
    procedure SetLinkSubitems(Value: TppTBCustomItem);
    procedure SetOptions(Value: TppTBItemOptions);
  protected
    {$IFNDEF JR_D5}
    procedure DoPopup(Sender: TObject);
    {$ENDIF}
    function GetRootItemClass: TppTBRootItemClass; dynamic;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function IsShortCut(var Message: TWMKey): Boolean; override;
    procedure Popup(X, Y: Integer); override;
  published
    property Images: TCustomImageList read GetImages write SetImages;
    property Items: TppTBRootItem read FItem;
    property LinkSubitems: TppTBCustomItem read GetLinkSubitems write SetLinkSubitems;
    property Options: TppTBItemOptions read GetOptions write SetOptions default [];
  end;

  TppTBCustomImageList = class(TImageList)
  private
    FCheckedImages: TCustomImageList;
    FCheckedImagesChangeLink: TChangeLink;
    FDisabledImages: TCustomImageList;
    FDisabledImagesChangeLink: TChangeLink;
    FHotImages: TCustomImageList;
    FHotImagesChangeLink: TChangeLink;
    FImagesBitmap: TBitmap;
    FImagesBitmapMaskColor: TColor;
    procedure ChangeImages(var AImageList: TCustomImageList;
      Value: TCustomImageList; AChangeLink: TChangeLink);
    procedure ImageListChanged(Sender: TObject);
    procedure ImagesBitmapChanged(Sender: TObject);
    procedure SetCheckedImages(Value: TCustomImageList);
    procedure SetDisabledImages(Value: TCustomImageList);
    procedure SetHotImages(Value: TCustomImageList);
    procedure SetImagesBitmap(Value: TBitmap);
    procedure SetImagesBitmapMaskColor(Value: TColor);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property CheckedImages: TCustomImageList read FCheckedImages write SetCheckedImages;
    property DisabledImages: TCustomImageList read FDisabledImages write SetDisabledImages;
    property HotImages: TCustomImageList read FHotImages write SetHotImages;
    property ImagesBitmap: TBitmap read FImagesBitmap write SetImagesBitmap;
    property ImagesBitmapMaskColor: TColor read FImagesBitmapMaskColor
      write SetImagesBitmapMaskColor default clFuchsia;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DrawState(Canvas: TCanvas; X, Y, Index: Integer;
      Enabled, Selected, Checked: Boolean); virtual;
  end;

  TppTBImageList = class(TppTBCustomImageList)
  published
    property CheckedImages;
    property DisabledImages;
    property HotImages;
    property ImagesBitmap;
    property ImagesBitmapMaskColor;
  end;

const
  {$IFNDEF TB2K_USE_STRICT_O2K_MENU_STYLE}
  tbMenuBkColor = clMenu;
  tbMenuTextColor = clMenuText;
  {$ELSE}
  tbMenuBkColor = clBtnFace;
  tbMenuTextColor = clBtnText;
  {$ENDIF}

  tbMenuVerticalMargin = 4;
  tbMenuImageTextSpace = 1;
  tbMenuLeftTextMargin = 2;
  tbMenuRightTextMargin = 3;

  tbMenuSeparatorOffset = 12;

  tbMenuScrollArrowHeight = 19;

  tbDropdownArrowWidth = 8;
  tbDropdownArrowMargin = 3;
  tbDropdownComboArrowWidth = 11;
  tbDropdownComboMargin = 2;

  tbLineSpacing = 6;
  tbLineSepOffset = 1;
  tbDockedLineSepOffset = 4;

  WM_TB2K_CLICKITEM = WM_USER + $100;

procedure TBInitToolbarSystemFont;

var
  ToolbarFont: TFont;

type
  TppTBModalHandler = class
  private
    FCreatedWnd: Boolean;
    FInited: Boolean;
    FWnd: HWND;
  public
    constructor Create(AExistingWnd: HWND);
    destructor Destroy; override;
    procedure Loop(const RootView: TppTBView; const AMouseDown, AExecuteSelected,
      AFromMSAA, TrackRightButton: Boolean);
    property Wnd: HWND read FWnd;
  end;

procedure ProcessDoneAction(const DoneActionData: TppTBDoneActionData);

implementation

uses
  MMSYSTEM, IMM,
  ppTB2Acc,
  ppTB2Consts,
  ppTB2Common;

var
  LastPos: TPoint;

threadvar
  ClickWndRefCount: Integer;
  ClickWnd: HWND;
  ClickList: TList;

type
  PItemChangedNotificationData = ^TItemChangedNotificationData;
  TItemChangedNotificationData = record
    Proc: TppTBItemChangedProc;
    RefCount: Integer;
  end;

  TComponentAccess = class(TComponent);
  TControlAccess = class(TControl);

const
  ViewTimerBaseID = 9000;
  MaxGroupLevel = 10;


{ Misc. }

procedure DestroyClickWnd;
begin
  if ClickWnd <> 0 then begin
    {$IFDEF JR_D6}Classes.{$ENDIF} DeallocateHWnd(ClickWnd);
    ClickWnd := 0;
  end;
  FreeAndNil(ClickList);
end;

procedure ReferenceClickWnd;
begin
  Inc(ClickWndRefCount);
end;

procedure ReleaseClickWnd;
begin
  Dec(ClickWndRefCount);
  if ClickWndRefCount = 0 then
    DestroyClickWnd;
end;

procedure QueueClick(const AItem: TObject; const AArg: Integer);
{ Adds an item to ClickList and posts a message to handle it. AItem must be
  either a TppTBCustomItem or TppTBItemViewer. }
var
  I: Integer;
begin
  if ClickWnd = 0 then
    ClickWnd := {$IFDEF JR_D6}Classes.{$ENDIF} AllocateHWnd(TppTBCustomItem.ClickWndProc);
  if ClickList = nil then
    ClickList := TList.Create;

  { Add a new item to ClickList or replace an empty one }
  I := ClickList.IndexOf(nil);
  if I = -1 then
    I := ClickList.Add(AItem)
  else
    ClickList[I] := AItem;

  PostMessage(ClickWnd, WM_TB2K_CLICKITEM, AArg, I);
end;

procedure RemoveFromClickList(const AItem: TObject);
{ Any class that potentially calls QueueClick needs to call RemoveFromClickList
  before an instance is destroyed to ensure that any references to the
  instance still in ClickList are removed. }                                                                
var
  I: Integer;
begin
  if Assigned(ClickList) and Assigned(AItem) then
    for I := 0 to ClickList.Count-1 do
      if ClickList[I] = AItem then
        ClickList[I] := Pointer(1);
        { ^ The special value of Pointer(1) is assigned to the item instead of
          of nil because we want the index to stay reserved until the
          WM_TB2K_CLICKITEM message for the index is processed. We don't want
          the WM_TB2K_CLICKITEM message that's still in the queue to later
          refer to a different item; this would result in queued clicks being
          processed in the wrong order in a case like this:
            A.PostClick; B.PostClick; A.Free; C.PostClick;
          C's click would end up being processed before A's, because C would
          get A's index. }
end;

procedure ProcessDoneAction(const DoneActionData: TppTBDoneActionData);
begin
  case DoneActionData.DoneAction of
    tbdaNone: ;
    tbdaClickItem: begin
        if DoneActionData.Sound and NeedToPlaySound('MenuCommand') then
          PlaySound('MenuCommand', 0, SND_ALIAS or SND_ASYNC or SND_NODEFAULT or SND_NOSTOP);
        DoneActionData.ClickItem.PostClick;
      end;
    tbdaOpenSystemMenu: begin
        SendMessage(DoneActionData.Wnd, WM_SYSCOMMAND, SC_KEYMENU, DoneActionData.Key);
      end;
    tbdaHelpContext: begin
        { Based on code in TPopupList.WndProc: }
        if Assigned(Screen.ActiveForm) and
           (biHelp in Screen.ActiveForm.BorderIcons) then
          Application.HelpCommand(HELP_CONTEXTPOPUP, DoneActionData.ContextID)
        else
          Application.HelpContext(DoneActionData.ContextID);
      end;
  end;
end;


{ TppTBItemDataArray routines }

procedure InsertIntoItemArray(var AItems: PTBItemDataArray;
  var AItemCount: Integer; NewIndex: Integer; AItem: TppTBCustomItem);
begin
  ReallocMem(AItems, (AItemCount+1) * SizeOf(AItems[0]));
  if NewIndex < AItemCount then
    System.Move(AItems[NewIndex], AItems[NewIndex+1],
      (AItemCount-NewIndex) * SizeOf(AItems[0]));
  AItems[NewIndex].Item := AItem;
  Inc(AItemCount);
end;

procedure DeleteFromItemArray(var AItems: PTBItemDataArray;
  var AItemCount: Integer; Index: Integer);
begin
  Dec(AItemCount);
  if Index < AItemCount then
    System.Move(AItems[Index+1], AItems[Index],
      (AItemCount-Index) * SizeOf(AItems[0]));
  ReallocMem(AItems, AItemCount * SizeOf(AItems[0]));
end;

procedure InsertIntoViewerArray(var AItems: PTBItemViewerArray;
  var AItemCount: Integer; NewIndex: Integer; AItem: TppTBItemViewer);
begin
  ReallocMem(AItems, (AItemCount+1) * SizeOf(AItems[0]));
  if NewIndex < AItemCount then
    System.Move(AItems[NewIndex], AItems[NewIndex+1],
      (AItemCount-NewIndex) * SizeOf(AItems[0]));
  AItems[NewIndex] := AItem;
  Inc(AItemCount);
end;

procedure DeleteFromViewerArray(var AItems: PTBItemViewerArray;
  var AItemCount: Integer; Index: Integer);
begin
  Dec(AItemCount);
  if Index < AItemCount then
    System.Move(AItems[Index+1], AItems[Index],
      (AItemCount-Index) * SizeOf(AItems[0]));
  ReallocMem(AItems, AItemCount * SizeOf(AItems[0]));
end;


{ TppTBCustomItemActionLink }

procedure TppTBCustomItemActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TppTBCustomItem;
end;

{$IFDEF JR_D6}
function TppTBCustomItemActionLink.IsAutoCheckLinked: Boolean;
begin
  Result := (FClient.AutoCheck = (Action as TCustomAction).AutoCheck);
end;
{$ENDIF}

function TppTBCustomItemActionLink.IsCaptionLinked: Boolean;
begin
  Result := inherited IsCaptionLinked and
    (FClient.Caption = (Action as TCustomAction).Caption);
end;

function TppTBCustomItemActionLink.IsCheckedLinked: Boolean;
begin
  Result := inherited IsCheckedLinked and
    (FClient.Checked = (Action as TCustomAction).Checked);
end;

function TppTBCustomItemActionLink.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
    (FClient.Enabled = (Action as TCustomAction).Enabled);
end;

function TppTBCustomItemActionLink.IsHelpContextLinked: Boolean;
begin
  Result := inherited IsHelpContextLinked and
    (FClient.HelpContext = (Action as TCustomAction).HelpContext);
end;

function TppTBCustomItemActionLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and
    (FClient.Hint = (Action as TCustomAction).Hint);
end;

function TppTBCustomItemActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FClient.ImageIndex = (Action as TCustomAction).ImageIndex);
end;

function TppTBCustomItemActionLink.IsShortCutLinked: Boolean;
begin
  Result := inherited IsShortCutLinked and
    (FClient.ShortCut = (Action as TCustomAction).ShortCut);
end;

function TppTBCustomItemActionLink.IsVisibleLinked: Boolean;
begin
  Result := inherited IsVisibleLinked and
    (FClient.Visible = (Action as TCustomAction).Visible);
end;

function TppTBCustomItemActionLink.IsOnExecuteLinked: Boolean;
begin
  Result := inherited IsOnExecuteLinked and
    MethodsEqual(TMethod(FClient.OnClick), TMethod(Action.OnExecute));
end;

{$IFDEF JR_D6}
procedure TppTBCustomItemActionLink.SetAutoCheck(Value: Boolean);
begin
  if IsAutoCheckLinked then FClient.AutoCheck := Value;
end;
{$ENDIF}

procedure TppTBCustomItemActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FClient.Caption := Value;
end;

procedure TppTBCustomItemActionLink.SetChecked(Value: Boolean);
begin
  if IsCheckedLinked then FClient.Checked := Value;
end;

procedure TppTBCustomItemActionLink.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

procedure TppTBCustomItemActionLink.SetHelpContext(Value: THelpContext);
begin
  if IsHelpContextLinked then FClient.HelpContext := Value;
end;

procedure TppTBCustomItemActionLink.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

procedure TppTBCustomItemActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then FClient.ImageIndex := Value;
end;

procedure TppTBCustomItemActionLink.SetShortCut(Value: TShortCut);
begin
  if IsShortCutLinked then FClient.ShortCut := Value;
end;

procedure TppTBCustomItemActionLink.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := Value;
end;

procedure TppTBCustomItemActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then FClient.OnClick := Value;
end;


{ TppTBCustomItem }

{}function ItemContainingItems(const AItem: TppTBCustomItem): TppTBCustomItem;
begin
  if Assigned(AItem) and Assigned(AItem.FLinkSubitems) then
    Result := AItem.FLinkSubitems
  else
    Result := AItem;
end;

constructor TppTBCustomItem.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := True;
  FImageIndex := -1;
  FInheritOptions := True;
  FItemStyle := [tbisSelectable, tbisRedrawOnSelChange, tbisRedrawOnMouseOverChange];
  FVisible := True;
  ReferenceClickWnd;
end;

destructor TppTBCustomItem.Destroy;
var
  I: Integer;
begin
  Destroying;
  RemoveFromClickList(Self);
  { Changed in 0.33. Moved FParent.Remove call *after* the child items are
    deleted. }
  for I := Count-1 downto 0 do
    Items[I].Free;
  if Assigned(FParent) then
    FParent.Remove(Self);
  FreeMem(FItems);
  FActionLink.Free;
  FActionLink := nil;
  FreeAndNil(FSubMenuImagesChangeLink);
  FreeAndNil(FImagesChangeLink);
  inherited;
  if Assigned(FNotifyList) then begin
    for I := FNotifyList.Count-1 downto 0 do
      Dispose(PItemChangedNotificationData(FNotifyList[I]));
    FNotifyList.Free;
  end;
  FLinkParents.Free;
  ReleaseClickWnd;
end;

{$IFDEF JR_D6}
function TppTBCustomItem.IsAutoCheckStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsAutoCheckLinked;
end;
{$ENDIF}

function TppTBCustomItem.IsCaptionStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsCaptionLinked;
end;

function TppTBCustomItem.IsCheckedStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsCheckedLinked;
end;

function TppTBCustomItem.IsEnabledStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsEnabledLinked;
end;

function TppTBCustomItem.IsHintStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHintLinked;
end;

function TppTBCustomItem.IsHelpContextStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHelpContextLinked;
end;

function TppTBCustomItem.IsImageIndexStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsImageIndexLinked;
end;

function TppTBCustomItem.IsShortCutStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsShortCutLinked;
end;

function TppTBCustomItem.IsVisibleStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsVisibleLinked;
end;

function TppTBCustomItem.IsOnClickStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsOnExecuteLinked;
end;

function TppTBCustomItem.GetAction: TBasicAction;
begin
  if FActionLink <> nil then
    Result := FActionLink.Action
  else
    Result := nil;
end;

function TppTBCustomItem.GetActionLinkClass: TppTBCustomItemActionLinkClass;
begin
  Result := TppTBCustomItemActionLink;
end;

procedure TppTBCustomItem.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

procedure TppTBCustomItem.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  if Action is TCustomAction then
    with TCustomAction(Sender) do
    begin
      {$IFDEF JR_D6}
      if not CheckDefaults or (Self.AutoCheck = False) then
        Self.AutoCheck := AutoCheck;
      {$ENDIF}
      if not CheckDefaults or (Self.Caption = '') then
        Self.Caption := Caption;
      if not CheckDefaults or (Self.Checked = False) then
        Self.Checked := Checked;
      if not CheckDefaults or (Self.Enabled = True) then
        Self.Enabled := Enabled;
      if not CheckDefaults or (Self.HelpContext = 0) then
        Self.HelpContext := HelpContext;
      if not CheckDefaults or (Self.Hint = '') then
        Self.Hint := Hint;
      if not CheckDefaults or (Self.ImageIndex = -1) then
        Self.ImageIndex := ImageIndex;
      if not CheckDefaults or (Self.ShortCut = scNone) then
        Self.ShortCut := ShortCut;
      if not CheckDefaults or (Self.Visible = True) then
        Self.Visible := Visible;
      if not CheckDefaults or not Assigned(Self.OnClick) then
        Self.OnClick := OnExecute;
    end;
end;

procedure TppTBCustomItem.SetAction(Value: TBasicAction);
begin
  if Value = nil then begin
    FActionLink.Free;
    FActionLink := nil;
  end
  else begin
    if FActionLink = nil then
      FActionLink := GetActionLinkClass.Create(Self);
    FActionLink.Action := Value;
    FActionLink.OnChange := DoActionChange;
    ActionChange(Value, csLoading in Value.ComponentState);
    Value.FreeNotification(Self);
  end;
end;

procedure TppTBCustomItem.InitiateAction;
begin
  if FActionLink <> nil then FActionLink.Update;
end;

procedure TppTBCustomItem.Loaded;
begin
  inherited;
  if Action <> nil then ActionChange(Action, True);
end;

procedure TppTBCustomItem.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to FItemCount-1 do
    Proc(FItems[I].Item);
end;

procedure TppTBCustomItem.SetChildOrder(Child: TComponent; Order: Integer);
var
  I: Integer;
begin
  I := IndexOf(Child as TppTBCustomItem);
  if I <> -1 then
    Move(I, Order);
end;

function TppTBCustomItem.HasParent: Boolean;
begin
  Result := True;
end;

function TppTBCustomItem.GetParentComponent: TComponent;
begin
  if (FParent <> nil) and (FParent.FParentComponent <> nil) then
    Result := FParent.FParentComponent
  else
    Result := FParent;
end;

procedure TppTBCustomItem.SetName(const NewName: TComponentName);
begin
  if Name <> NewName then begin
    inherited;
    if Assigned(FParent) then
      FParent.Notify(tbicNameChanged, -1, Self);
  end;
end;

procedure TppTBCustomItem.SetParentComponent(Value: TComponent);
var
  Intf: IppTBItems;
begin
  if FParent <> nil then FParent.Remove(Self);
  if Value <> nil then begin
    if Value is TppTBCustomItem then
      TppTBCustomItem(Value).Add(Self)
    else if Value.GetInterface(IppTBItems, Intf) then
      Intf.GetItems.Add(Self);
  end;
end;

procedure TppTBCustomItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then begin
    RemoveFromList(FLinkParents, AComponent);
    if AComponent = Action then Action := nil;
    if AComponent = Images then Images := nil;
    if AComponent = SubMenuImages then SubMenuImages := nil;
    if AComponent = LinkSubitems then LinkSubitems := nil;
  end;
end;

procedure TppTBCustomItem.IndexError;
begin
  raise ETBItemError.Create(ppSTBToolbarIndexOutOfBounds);
end;

class procedure TppTBCustomItem.ClickWndProc(var Message: TMessage);
var
  List: TList;
  I: Integer;
  Item: TObject;
begin
  if Message.Msg = WM_TB2K_CLICKITEM then begin
    List := ClickList;  { optimization... }
    if Assigned(List) then begin
      I := Message.LParam;
      if (I >= 0) and (I < List.Count) then begin
        Item := List[I];
        List[I] := nil;
        if Item = Pointer(1) then  { is it a destroyed item? }
          Item := nil;
      end
      else
        Item := nil;

      { Remove trailing nil items from ClickList. This is not *necessary*, but
        it will make RemoveFromClickList faster if we clean out items that
        aren't used, and may never be used again. }
      for I := List.Count-1 downto 0 do begin
        if List[I] = nil then
          List.Delete(I)
        else
          Break;
      end;

      if Assigned(Item) then begin
        try
          if Item is TppTBCustomItem then
            TppTBCustomItem(Item).Click
          else if Item is TppTBItemViewer then
            TppTBItemViewer(Item).AccSelect(Message.WParam <> 0);
        except
          Application.HandleException(Item);
        end;
      end;
    end;
  end
  else
    with Message do
      Result := DefWindowProc(ClickWnd, Msg, wParam, lParam);
end;

procedure TppTBCustomItem.PostClick;
{ Posts a message to the message queue that causes the item's Click handler to
  be executed when control is returned to the message loop.
  This should be called instead of Click when a WM_SYSCOMMAND message is
  (possibly) currently being handled, because TApplication.WndProc's
  CM_APPSYSCOMMAND handler disables the VCL's processing of focus messages
  until the Perform(WM_SYSCOMMAND, ...) call returns. (An OnClick handler which
  calls TForm.ShowModal needs focus messages to be enabled or else the form
  will be shown with no initial focus.) }
begin
  QueueClick(Self, 0);
end;

procedure TppTBCustomItem.Click;
begin
  if Enabled then begin
    { Following code based on D6's TMenuItem.Click }
    {$IFDEF JR_D6}
    if (not Assigned(ActionLink) and AutoCheck) or
       (Assigned(ActionLink) and not ActionLink.IsAutoCheckLinked and AutoCheck) then
    {$ELSE}
    if AutoCheck then
    {$ENDIF}
      Checked := not Checked;
    { Following code based on D4's TControl.Click }
    { Call OnClick if assigned and not equal to associated action's OnExecute.
      If associated action's OnExecute assigned then call it, otherwise, call
      OnClick. }
    if Assigned(FOnClick) and (Action <> nil) and
       not MethodsEqual(TMethod(FOnClick), TMethod(Action.OnExecute)) then
      FOnClick(Self)
    else
    if not(csDesigning in ComponentState) and (ActionLink <> nil) then
      ActionLink.Execute {$IFDEF JR_D6}(Self){$ENDIF}
    else
    if Assigned(FOnClick) then
      FOnClick(Self);
  end;
end;

function TppTBCustomItem.GetItem(Index: Integer): TppTBCustomItem;
begin
  if (Index < 0) or (Index >= FItemCount) then IndexError;
  Result := FItems[Index].Item;
end;

procedure TppTBCustomItem.Add(AItem: TppTBCustomItem);
begin
  Insert(Count, AItem);
end;

procedure TppTBCustomItem.InternalNotify(Ancestor: TppTBCustomItem;
  NestingLevel: Integer; Action: TppTBItemChangedAction; Index: Integer;
  Item: TppTBCustomItem);
{ Note: Ancestor is Item's parent, or in the case of a group item relayed
  notification, it can also be a group item which *links* to Item's parent
  (i.e. ItemContainingItems(Ancestor) = Item.Parent). }

  procedure RelayToParentOf(const AItem: TppTBCustomItem);
  begin
    if NestingLevel > MaxGroupLevel then
      Exit;
    if (tbisEmbeddedGroup in AItem.ItemStyle) and Assigned(AItem.Parent) then begin
      if Ancestor = Self then
        AItem.Parent.InternalNotify(AItem, NestingLevel + 1, Action, Index, Item)
      else
        { Don't alter Ancestor on subsequent relays; only on the first. }
        AItem.Parent.InternalNotify(Ancestor, NestingLevel + 1, Action, Index, Item);
    end;
  end;

var
  I: Integer;
  P: TppTBCustomItem;
  SaveProc: TppTBItemChangedProc;
begin
  { If Self is a group item, relay the notification to the parent }
  RelayToParentOf(Self);
  { If any group items are linked to Self, relay the notification to
    those items' parents }
  if Assigned(FLinkParents) then
    for I := 0 to FLinkParents.Count-1 do begin
      P := FLinkParents[I];
      if P <> Parent then
        RelayToParentOf(P);
    end;
  if Assigned(FNotifyList) then begin
    I := 0;
    while I < FNotifyList.Count do begin
      with PItemChangedNotificationData(FNotifyList[I])^ do begin
        SaveProc := Proc;
        Proc(Ancestor, Ancestor <> Self, Action, Index, Item);
      end;
      { Is I now out of bounds? }
      if I >= FNotifyList.Count then
        Break;
      { Only proceed to the next index if the list didn't change }
      if MethodsEqual(TMethod(PItemChangedNotificationData(FNotifyList[I])^.Proc),
         TMethod(SaveProc)) then
        Inc(I);
    end;
  end;
end;

procedure TppTBCustomItem.Notify(Action: TppTBItemChangedAction; Index: Integer;
  Item: TppTBCustomItem);
begin
  InternalNotify(Self, 0, Action, Index, Item);
end;

procedure TppTBCustomItem.ViewBeginUpdate;
begin
  Notify(tbicSubitemsBeginUpdate, -1, nil);
end;

procedure TppTBCustomItem.ViewEndUpdate;
begin
  Notify(tbicSubitemsEndUpdate, -1, nil);
end;

procedure TppTBCustomItem.Insert(NewIndex: Integer; AItem: TppTBCustomItem);
begin
  if Assigned(AItem.FParent) then
    raise ETBItemError.Create(ppSTBToolbarItemReinserted);
  if (NewIndex < 0) or (NewIndex > FItemCount) then IndexError;
  InsertIntoItemArray(FItems, FItemCount, NewIndex, AItem);
  AItem.FParent := Self;
  ViewBeginUpdate;
  try
    Notify(tbicInserted, NewIndex, AItem);
    AItem.RefreshOptions;
  finally
    ViewEndUpdate;
  end;
end;

procedure TppTBCustomItem.Delete(Index: Integer);
begin
  if (Index < 0) or (Index >= FItemCount) then IndexError;
  Notify(tbicDeleting, Index, FItems[Index].Item);
  FItems[Index].Item.FParent := nil;
  DeleteFromItemArray(FItems, FItemCount, Index);
end;

function TppTBCustomItem.IndexOf(AItem: TppTBCustomItem): Integer;
var
  I: Integer;
begin
  for I := 0 to FItemCount-1 do
    if FItems[I].Item = AItem then begin
      Result := I;
      Exit;
    end;
  Result := -1;
end;

procedure TppTBCustomItem.Remove(Item: TppTBCustomItem);
var
  I: Integer;
begin
  I := IndexOf(Item);
  //if I = -1 then raise ETBItemError.Create(STBToolbarItemNotFound);
  if I <> -1 then
    Delete(I);
end;

procedure TppTBCustomItem.Clear;
var
  I: Integer;
begin
  for I := Count-1 downto 0 do
    Items[I].Free;
end;

procedure TppTBCustomItem.Move(CurIndex, NewIndex: Integer);
var
  Item: TppTBCustomItem;
begin
  if CurIndex <> NewIndex then begin
    if (NewIndex < 0) or (NewIndex >= FItemCount) then IndexError;
    Item := Items[CurIndex];
    ViewBeginUpdate;
    try
      Delete(CurIndex);
      Insert(NewIndex, Item);
    finally
      ViewEndUpdate;
    end;
  end;
end;

function TppTBCustomItem.ContainsItem(AItem: TppTBCustomItem): Boolean;
begin
  while Assigned(AItem) and (AItem <> Self) do
    AItem := AItem.Parent;
  Result := Assigned(AItem);
end;

procedure TppTBCustomItem.RegisterNotification(ANotify: TppTBItemChangedProc);
var
  I: Integer;
  Data: PItemChangedNotificationData;
begin
  if FNotifyList = nil then FNotifyList := TList.Create;
  for I := 0 to FNotifyList.Count-1 do
    with PItemChangedNotificationData(FNotifyList[I])^ do
      if MethodsEqual(TMethod(ANotify), TMethod(Proc)) then begin
        Inc(RefCount);
        Exit;
      end;
  FNotifyList.Expand;
  New(Data);
  Data.Proc := ANotify;
  Data.RefCount := 1;
  FNotifyList.Add(Data);
end;

procedure TppTBCustomItem.UnregisterNotification(ANotify: TppTBItemChangedProc);
var
  I: Integer;
  Data: PItemChangedNotificationData;
begin
  if Assigned(FNotifyList) then
    for I := 0 to FNotifyList.Count-1 do begin
      Data := FNotifyList[I];
      if MethodsEqual(TMethod(Data.Proc), TMethod(ANotify)) then begin
        Dec(Data.RefCount);
        if Data.RefCount = 0 then begin
          FNotifyList.Delete(I);
          Dispose(Data);
          if FNotifyList.Count = 0 then begin
            FNotifyList.Free;
            FNotifyList := nil;
          end;
        end;
        Break;
      end;
    end;
end;

function TppTBCustomItem.GetPopupWindowClass: TppTBPopupWindowClass;
begin
  Result := TppTBPopupWindow;
end;

procedure TppTBCustomItem.DoPopup(Sender: TppTBCustomItem; FromLink: Boolean);
begin
  if Assigned(FOnPopup) then
    FOnPopup(Sender, FromLink);
  if not(tbisCombo in ItemStyle) then
    Click;
end;

var
  PlayedSound: Boolean = False;

procedure TppTBCustomItem.GetPopupPosition(ParentView: TppTBView;
  PopupWindow: TppTBPopupWindow; var PopupPositionRec: TppTBPopupPositionRec);
var
  X2, Y2: Integer;
  RepeatCalcX: Boolean;

  function CountObscured(X, Y, W, H: Integer): Integer;
  var
    I: Integer;
    P: TPoint;
    V: TppTBItemViewer;
  begin
    Result := 0;
    if ParentView = nil then
      Exit;
    P := ParentView.FWindow.ClientToScreen(Point(0, 0));
    Dec(X, P.X);
    Dec(Y, P.Y);
    Inc(W, X);
    Inc(H, Y);
    for I := 0 to ParentView.FViewerCount-1 do begin
      V := ParentView.FViewers[I];
      if V.Show and (V.BoundsRect.Left >= X) and (V.BoundsRect.Right <= W) and
         (V.BoundsRect.Top >= Y) and (V.BoundsRect.Bottom <= H) then
        Inc(Result);
    end;
  end;

begin
  with PopupPositionRec do
  begin
    { Adjust the Y position of the popup window }
    { If the window is going off the bottom of the monitor, try placing it
      above the parent item }
    if (Y + H > MonitorRect.Bottom) and
       ((ParentView = nil) or (ParentView.FOrientation <> tbvoVertical)) then begin
      if not PositionAsSubmenu then
        Y2 := ParentItemRect.Top
      else
        Y2 := ParentItemRect.Bottom + NCSizeY;
      Dec(Y2, H);
      { Only place it above the parent item if it isn't going to go off the
        top of the monitor }
      if Y2 >= MonitorRect.Top then
        Y := Y2;
    end;
    { If it's still going off the bottom (which can be possible if a menu bar
      was off the screen to begin with), clip it to the bottom of the monitor }
    if Y + H > MonitorRect.Bottom then
      Y := MonitorRect.Bottom - H;
    if Y < MonitorRect.Top then
      Y := MonitorRect.Top;

    { Other adjustments to the position of the popup window }
    if not PositionAsSubmenu then begin
      if (ParentView = nil) and (Alignment = tbpaRight) and (X < MonitorRect.Left) then
        Inc(X, W);
      if X + W > MonitorRect.Right then begin
        if Assigned(ParentView) or (Alignment <> tbpaLeft) then
          X := MonitorRect.Right;
        Dec(X, W);
      end;
      if X < MonitorRect.Left then
        X := MonitorRect.Left;
      if (ParentView = nil) or (ParentView.FOrientation <> tbvoVertical) then begin
        Y2 := ParentItemRect.Top - H;
        if Y2 >= MonitorRect.Top then begin
          { Would the popup window obscure less items if it popped out to the
            top instead? }
          if (CountObscured(X, Y2, W, H) < CountObscured(X, Y, W, H)) or
             ((Y < ParentItemRect.Bottom) and (Y + H > ParentItemRect.Top) and
              (X < ParentItemRect.Right) and (X + W > ParentItemRect.Left)) then
            Y := Y2;
        end;
        { Make sure a tall popup window doesn't overlap the parent item }
        if (Y < ParentItemRect.Bottom) and (Y + H > ParentItemRect.Top) and
           (X < ParentItemRect.Right) and (X + W > ParentItemRect.Left) then begin
          if ParentItemRect.Right + W <= MonitorRect.Right then
            X := ParentItemRect.Right
          else
            X := ParentItemRect.Left - W;
          if X < MonitorRect.Top then
            X := MonitorRect.Top;
        end;
      end
      else begin
        X2 := ParentItemRect.Right;
        if X2 + W <= MonitorRect.Right then begin
          { Would the popup window obscure less items if it popped out to the
            right instead? }
          if (CountObscured(X2, Y, W, H) < CountObscured(X, Y, W, H)) or
             ((Y < ParentItemRect.Bottom) and (Y + H > ParentItemRect.Top) and
              (X < ParentItemRect.Right) and (X + W > ParentItemRect.Left)) then
            X := X2;
        end;
        { Make sure a wide popup window doesn't overlap the parent item }
        if (Y < ParentItemRect.Bottom) and (Y + H > ParentItemRect.Top) and
           (X < ParentItemRect.Right) and (X + W > ParentItemRect.Left) then begin
          if ParentItemRect.Bottom + H <= MonitorRect.Bottom then
            Y := ParentItemRect.Bottom
          else
            Y := ParentItemRect.Top - H;
          if Y < MonitorRect.Top then
            Y := MonitorRect.Top;
        end;
      end;
    end
    else begin
      { Make nested submenus go from left to right on the screen. Each it
        runs out of space on the screen, switch directions }
      repeat
        RepeatCalcX := False;
        X2 := X;
        if Opposite or (X2 + W > MonitorRect.Right) then begin
          if Assigned(ParentView) then
            X2 := ParentItemRect.Left + NCSizeX;
          Dec(X2, W);
          if not Opposite then
            Include(PopupWindow.View.FState, vsOppositePopup)
          else begin
            if X2 < MonitorRect.Left then begin
              Opposite := False;
              RepeatCalcX := True;
            end
            else
              Include(PopupWindow.View.FState, vsOppositePopup);
          end;
        end;
      until not RepeatCalcX;
      X := X2;
      if X < MonitorRect.Left then
        X := MonitorRect.Left;
    end;

    { Determine animation direction }
    AnimDir := [];
    if not PositionAsSubmenu then begin
      if Y >= ParentItemRect.Bottom then
        Include(AnimDir, tbadDown)
      else if Y + H <= ParentItemRect.Top then
        Include(AnimDir, tbadUp);
      if X >= ParentItemRect.Right then
        Include(AnimDir, tbadRight)
      else if X + W <= ParentItemRect.Left then
        Include(AnimDir, tbadLeft);
    end
    else begin
      if X + W div 2 >= ParentItemRect.Left + (ParentItemRect.Right - ParentItemRect.Left) div 2 then
        Include(AnimDir, tbadRight)
      else
        Include(AnimDir, tbadLeft);
    end;
  end;
end;

function TppTBCustomItem.CreatePopup(const ParentView: TppTBView;
  const ParentViewer: TppTBItemViewer; const PositionAsSubmenu, SelectFirstItem,
  Customizing: Boolean; const APopupPoint: TPoint;
  const Alignment: TppTBPopupAlignment): TppTBPopupWindow;
var
  EventItem, ParentItem: TppTBCustomItem;
  Opposite: Boolean;
  ChevronParentView: TppTBView;
  X, Y, W, H: Integer;
  P: TPoint;
  ParentItemRect: TRect;
  MonitorRect: TRect;
  PopupRec: TppTBPopupPositionRec;
  NCSize: TPoint;
begin
  EventItem := ItemContainingItems(Self);
  if EventItem <> Self then
    EventItem.DoPopup(Self, True);
  DoPopup(Self, False);

  ChevronParentView := GetChevronParentView;
  if ChevronParentView = nil then
    ParentItem := Self
  else
    ParentItem := ChevronParentView.FParentItem;

  Opposite := Assigned(ParentView) and (vsOppositePopup in ParentView.FState);
  Result := GetPopupWindowClass.CreatePopupWindow(nil, ParentView, ParentItem,
    Customizing);
  try
    if Assigned(ChevronParentView) then begin
      ChevronParentView.FreeNotification(Result.View);
      Result.View.FChevronParentView := ChevronParentView;
      Result.View.FIsToolbar := True;
      Result.View.Style := Result.View.Style +
        (ChevronParentView.Style * [vsAlwaysShowHints]);
      Result.Color := clBtnFace;
    end;

    { Calculate ParentItemRect, and MonitorRect (the rectangle of the monitor
      that the popup window will be confined to) }
    if Assigned(ParentView) then begin
      ParentView.ValidatePositions;
      ParentItemRect := ParentViewer.BoundsRect;
      P := ParentView.FWindow.ClientToScreen(Point(0, 0));
      OffsetRect(ParentItemRect, P.X, P.Y);
      if not IsRectEmpty(ParentView.FMonitorRect) then
        MonitorRect := ParentView.FMonitorRect
      else
        MonitorRect := GetRectOfMonitorContainingRect(ParentItemRect, False);
    end
    else begin
      ParentItemRect.TopLeft := APopupPoint;
      ParentItemRect.BottomRight := APopupPoint;
      MonitorRect := GetRectOfMonitorContainingPoint(APopupPoint, False);
    end;
    Result.View.FMonitorRect := MonitorRect;

    { Initialize item positions and size of the popup window }
    NCSize := Result.GetNCSize;
    if ChevronParentView = nil then
      Result.View.FMaxHeight := (MonitorRect.Bottom - MonitorRect.Top) -
        (NCSize.Y * 2)
    else
      Result.View.WrapOffset := (MonitorRect.Right - MonitorRect.Left) -
        (NCSize.X * 2);
    if SelectFirstItem then
      Result.View.Selected := Result.View.FirstSelectable;
    Result.View.UpdatePositions;
    W := Result.Width;
    H := Result.Height;

    { Calculate initial X,Y position of the popup window }
    if Assigned(ParentView) then begin
      if not PositionAsSubmenu then begin
        if ChevronParentView = nil then begin
          if (ParentView = nil) or (ParentView.FOrientation <> tbvoVertical) then begin
            if GetSystemMetrics(SM_MENUDROPALIGNMENT) = 0 then
              X := ParentItemRect.Left
            else
              X := ParentItemRect.Right - W;
            Y := ParentItemRect.Bottom;
          end
          else begin
            X := ParentItemRect.Left - W;
            Y := ParentItemRect.Top;
          end;
        end
        else begin
          if ChevronParentView.FOrientation <> tbvoVertical then begin
            X := ParentItemRect.Right - W;
            Y := ParentItemRect.Bottom;
          end
          else begin
            X := ParentItemRect.Left - W;
            Y := ParentItemRect.Top;
          end;
        end;
      end
      else begin
        X := ParentItemRect.Right - NCSize.X;
        Y := ParentItemRect.Top - NCSize.Y;
      end;
    end
    else begin
      X := APopupPoint.X;
      Y := APopupPoint.Y;
      case Alignment of
        tbpaRight: Dec(X, W);
        tbpaCenter: Dec(X, W div 2);
      end;
    end;

    PopupRec.PositionAsSubmenu := PositionAsSubmenu;
    PopupRec.Alignment := Alignment;
    PopupRec.Opposite := Opposite;
    PopupRec.MonitorRect := MonitorRect;
    PopupRec.ParentItemRect := ParentItemRect;
    PopupRec.NCSizeX := NCSize.X;
    PopupRec.NCSizeY := NCSize.Y;
    PopupRec.X := X;
    PopupRec.Y := Y;
    PopupRec.W := W;
    PopupRec.H := H;
    PopupRec.AnimDir := [];
    PopupRec.PlaySound := True;
    GetPopupPosition(ParentView, Result, PopupRec);
    X := PopupRec.X;
    Y := PopupRec.Y;
    W := PopupRec.W;
    H := PopupRec.H;
    Result.FAnimationDirection := PopupRec.AnimDir;
    Result.SetBounds(X, Y, W, H);
    if Assigned(ParentView) then begin
      Result.FreeNotification(ParentView);
      ParentView.FOpenViewerWindow := Result;
      ParentView.FOpenViewerView := Result.View;
      ParentView.FOpenViewer := ParentViewer;
      if ParentView.FIsToolbar then begin
        Include(ParentView.FState, vsDropDownMenus);
        ParentView.Invalidate(ParentViewer);
        ParentView.FWindow.Update;
      end;
    end;
    Include(Result.View.FState, vsDrawInOrder);
    if not PopupRec.PlaySound or not NeedToPlaySound('MenuPopup') then begin
      { Don't call PlaySound if we don't have to }
      Result.Visible := True;
    end
    else begin
      if not PlayedSound then begin
        { Work around Windows 2000 "bug" where there's a 1/3 second delay upon the
          first call to PlaySound (or sndPlaySound) by painting the window
          completely first. This way the delay isn't very noticable. }
        PlayedSound := True;
        Result.Visible := True;
        Result.Update;
        PlaySound('MenuPopup', 0, SND_ALIAS or SND_ASYNC or SND_NODEFAULT or SND_NOSTOP);
      end
      else begin
        PlaySound('MenuPopup', 0, SND_ALIAS or SND_ASYNC or SND_NODEFAULT or SND_NOSTOP);
        Result.Visible := True;
      end;
    end;
    CallNotifyWinEvent(EVENT_SYSTEM_MENUPOPUPSTART, Result.View.FWindow.Handle,
      OBJID_CLIENT, CHILDID_SELF);
    { Call NotifyFocusEvent now that the window is visible }
    if Assigned(Result.View.Selected) then
      Result.View.NotifyFocusEvent;
  except
    Result.Free;
    raise;
  end;
end;

procedure TppTBCustomItem.OpenPopup(const SelectFirstItem, TrackRightButton: Boolean;
  const PopupPoint: TPoint; const Alignment: TppTBPopupAlignment);
var
  ModalHandler: TppTBModalHandler;
  Popup: TppTBPopupWindow;
  DoneActionData: TppTBDoneActionData;
begin
  ModalHandler := TppTBModalHandler.Create(0);
  try
    Popup := CreatePopup(nil, nil, False, SelectFirstItem, False, PopupPoint,
      Alignment);
    try
      Include(Popup.View.FState, vsIgnoreFirstMouseUp);
      ModalHandler.Loop(Popup.View, False, False, False, TrackRightButton);
      DoneActionData := Popup.View.FDoneActionData;
    finally
      { Remove vsModal state from the root view before any TppTBView.Destroy
        methods get called, so that NotifyFocusEvent becomes a no-op }
      Exclude(Popup.View.FState, vsModal);
      Popup.Free;
    end;
  finally
    ModalHandler.Free;
  end;
  ProcessDoneAction(DoneActionData);
end;

procedure TppTBCustomItem.Popup(X, Y: Integer; TrackRightButton: Boolean;
  Alignment: TppTBPopupAlignment = tbpaLeft);
var
  P: TPoint;
begin
  P.X := X;
  P.Y := Y;
  OpenPopup(False, TrackRightButton, P, Alignment);
end;

function TppTBCustomItem.FindItemWithShortCut(AShortCut: TShortCut;
  var ATopmostParent: TppTBCustomItem): TppTBCustomItem;

  function DoItem(AParentItem: TppTBCustomItem; LinkDepth: Integer): TppTBCustomItem;
  var
    I: Integer;
    NewParentItem, Item: TppTBCustomItem;
  begin
    Result := nil;
    NewParentItem := AParentItem;
    if Assigned(NewParentItem.LinkSubitems) then begin
      NewParentItem := NewParentItem.LinkSubitems;
      Inc(LinkDepth);
      if LinkDepth > 25 then
        Exit;  { prevent infinite link recursion }
    end;
    for I := 0 to NewParentItem.Count-1 do begin
      Item := NewParentItem.Items[I];
      if Item.ShortCut = AShortCut then begin
        Result := Item;
        Exit;
      end;
      Result := DoItem(Item, LinkDepth);
      if Assigned(Result) then begin
        ATopmostParent := Item;
        Exit;
      end;
    end;
  end;

begin
  ATopmostParent := nil;
  Result := DoItem(Self, 0);
end;

function TppTBCustomItem.IsShortCut(var Message: TWMKey): Boolean;
var
  ShortCut: TShortCut;
  ShiftState: TShiftState;
  ShortCutItem, TopmostItem, Item, EventItem: TppTBCustomItem;
  I: Integer;
label 1;
begin
  Result := False;
  ShiftState := KeyDataToShiftState(Message.KeyData);
  ShortCut := Menus.ShortCut(Message.CharCode, ShiftState);
1:ShortCutItem := FindItemWithShortCut(ShortCut, TopmostItem);
  if Assigned(ShortCutItem) then begin
    { Send OnPopup/OnClick events to ShortCutItem's parents so that they can
      update the Enabled state of ShortCutItem if needed }
    Item := Self;
    repeat
      if not Item.Enabled then
        Exit;
      EventItem := ItemContainingItems(Item);
      if not(csDesigning in ComponentState) then begin
        for I := 0 to EventItem.Count-1 do
          EventItem.Items[I].InitiateAction; 
      end;
      if not(tbisEmbeddedGroup in Item.ItemStyle) then begin
        if EventItem <> Item then begin
          try
            EventItem.DoPopup(Item, True);
          except
            Application.HandleException(Self);
          end;
        end;
        try
          Item.DoPopup(Item, False);
        except
          Application.HandleException(Self);
        end;
      end;
      ShortCutItem := Item.FindItemWithShortCut(ShortCut, TopmostItem);
      if ShortCutItem = nil then
        { Can no longer find the shortcut inside TopmostItem. Start over
          because the shortcut might have moved. }
        goto 1;
      Item := TopmostItem;
    until Item = nil;
    if ShortCutItem.Enabled then begin
      try
        ShortCutItem.Click;
      except
        Application.HandleException(Self);
      end;
      Result := True;
    end;
  end;
end;

function TppTBCustomItem.GetChevronParentView: TppTBView;
begin
  Result := nil;
end;

function TppTBCustomItem.GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass;
begin
  Result := TppTBItemViewer;
end;

function TppTBCustomItem.NeedToRecreateViewer(AViewer: TppTBItemViewer): Boolean;
begin
  Result := False;
end;

function TppTBCustomItem.GetShortCutText: String;
var
  P: Integer;
begin
  P := Pos(#9, Caption);
  if P = 0 then begin
    if ShortCut <> 0 then
      Result := ShortCutToText(ShortCut)
    else
      Result := '';
  end
  else
    Result := Copy(Caption, P+1, Maxint);
end;

procedure TppTBCustomItem.Change(NeedResize: Boolean);
const
  ItemChangedActions: array[Boolean] of TppTBItemChangedAction =
    (tbicInvalidate, tbicInvalidateAndResize);
begin
  if Assigned(FParent) then
    FParent.Notify(ItemChangedActions[NeedResize], -1, Self);
end;

procedure TppTBCustomItem.RecreateItemViewers;
begin
  if Assigned(FParent) then
    FParent.Notify(tbicRecreateItemViewers, -1, Self);
end;

procedure TppTBCustomItem.ImageListChangeHandler(Sender: TObject);
var
  Resize: Boolean;
begin
  if Sender = FSubMenuImages then begin
    FSubMenuImagesChangeLink.FLastWidth := FSubMenuImages.Width;
    FSubMenuImagesChangeLink.FLastHeight := FSubMenuImages.Height;
    SubMenuImagesChanged;
  end
  else begin
    { Sender is FImages }
    Resize := False;
    if (FImagesChangeLink.FLastWidth <> FImages.Width) or
       (FImagesChangeLink.FLastHeight <> FImages.Height) then begin
      FImagesChangeLink.FLastWidth := FImages.Width;
      FImagesChangeLink.FLastHeight := FImages.Height;
      Resize := True;
    end;
    Change(Resize);
  end;
end;

procedure TppTBCustomItem.SubMenuImagesChanged;
begin
  Notify(tbicSubMenuImagesChanged, -1, nil);
end;

procedure TppTBCustomItem.TurnSiblingsOff;
var
  I: Integer;
  Item: TppTBCustomItem;
begin
  if (GroupIndex <> 0) and Assigned(FParent) then begin
    for I := 0 to FParent.Count-1 do begin
      Item := FParent[I];
      if (Item <> Self) and (Item.GroupIndex = GroupIndex) then
        Item.Checked := False;
    end;
  end;
end;

procedure TppTBCustomItem.SetCaption(Value: String);
begin
  if FCaption <> Value then begin
    FCaption := Value;
    Change(True);
  end;
end;

procedure TppTBCustomItem.SetChecked(Value: Boolean);
begin
  if FChecked <> Value then begin
    FChecked := Value;
    Change(False);
    if Value then
      TurnSiblingsOff;
  end;
end;

procedure TppTBCustomItem.SetDisplayMode(Value: TppTBItemDisplayMode);
begin
  if FDisplayMode <> Value then begin
    FDisplayMode := Value;
    Change(True);
  end;
end;

procedure TppTBCustomItem.EnabledChanged;
begin
  Change(False);
end;

procedure TppTBCustomItem.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then begin
    FEnabled := Value;
    EnabledChanged;
  end;
end;

procedure TppTBCustomItem.SetGroupIndex(Value: Integer);
begin
  if FGroupIndex <> Value then begin
    FGroupIndex := Value;
    if Checked then
      TurnSiblingsOff;
  end;
end;

procedure TppTBCustomItem.SetImageIndex(Value: TImageIndex);
var
  HadNoImage: Boolean;
begin
  if FImageIndex <> Value then begin
    HadNoImage := FImageIndex = -1;
    FImageIndex := Value;
    Change(HadNoImage xor (Value = -1));
  end;
end;

function TppTBCustomItem.ChangeImages(var AImages: TCustomImageList;
  const Value: TCustomImageList; var AChangeLink: TppTBImageChangeLink): Boolean;
{ Returns True if image list was resized }
var
  LastWidth, LastHeight: Integer;
begin
  Result := False;
  LastWidth := -1;
  LastHeight := -1;
  if Assigned(AImages) then begin
    LastWidth := AImages.Width;
    LastHeight := AImages.Height;
    AImages.UnregisterChanges(AChangeLink);
    if Value = nil then begin
      AChangeLink.Free;
      AChangeLink := nil;
      Result := True;
    end;
  end;
  AImages := Value;
  if Assigned(Value) then begin
    Result := (Value.Width <> LastWidth) or (Value.Height <> LastHeight);
    if AChangeLink = nil then begin
      AChangeLink := TppTBImageChangeLink.Create;
      AChangeLink.FLastWidth := Value.Width;
      AChangeLink.FLastHeight := Value.Height;
      AChangeLink.OnChange := ImageListChangeHandler;
    end;
    Value.RegisterChanges(AChangeLink);
    Value.FreeNotification(Self);
  end;
end;

procedure TppTBCustomItem.SetImages(Value: TCustomImageList);
begin
  if FImages <> Value then
    Change(ChangeImages(FImages, Value, FImagesChangeLink));
end;

procedure TppTBCustomItem.SetSubMenuImages(Value: TCustomImageList);
begin
  if FSubMenuImages <> Value then begin
    ChangeImages(FSubMenuImages, Value, FSubMenuImagesChangeLink);
    SubMenuImagesChanged;
  end;
end;

procedure TppTBCustomItem.SetInheritOptions(Value: Boolean);
begin
  if FInheritOptions <> Value then begin
    FInheritOptions := Value;
    RefreshOptions;
  end;
end;

procedure TppTBCustomItem.SetLinkSubitems(Value: TppTBCustomItem);
begin
  if Value = Self then
    Value := nil;
  if FLinkSubitems <> Value then begin
    if Assigned(FLinkSubitems) then
      RemoveFromList(FLinkSubitems.FLinkParents, Self);
    FLinkSubitems := Value;
    if Assigned(Value) then begin
      Value.FreeNotification(Self);
      AddToList(Value.FLinkParents, Self);
    end;
    Notify(tbicSubitemsChanged, -1, nil);
  end;
end;

function TppTBCustomItem.FixOptions(const AOptions: TppTBItemOptions): TppTBItemOptions;
begin
  Result := AOptions;
  if not(tboToolbarStyle in Result) then
    Exclude(Result, tboToolbarSize);
end;

procedure TppTBCustomItem.RefreshOptions;
const
  NonInheritedOptions = [tboDefault];
  ChangeOptions = [tboDefault, tboDropdownArrow, tboImageAboveCaption,
    tboNoRotation, tboSameWidth, tboToolbarStyle, tboToolbarSize];
var
  OldOptions, NewOptions: TppTBItemOptions;
  I: Integer;
  Item: TppTBCustomItem;
begin
  OldOptions := FEffectiveOptions;
  if FInheritOptions and Assigned(FParent) then
    NewOptions := FParent.FEffectiveOptions - NonInheritedOptions
  else
    NewOptions := [];
  NewOptions := FixOptions(NewOptions - FMaskOptions + FOptions);
  if FEffectiveOptions <> NewOptions then begin
    FEffectiveOptions := NewOptions;
    if (OldOptions * ChangeOptions) <> (NewOptions * ChangeOptions) then
      Change(True);
    for I := 0 to FItemCount-1 do begin
      Item := FItems[I].Item;
      if Item.FInheritOptions then
        Item.RefreshOptions;
    end;
  end;
end;

procedure TppTBCustomItem.SetMaskOptions(Value: TppTBItemOptions);
begin
  if FMaskOptions <> Value then begin
    FMaskOptions := Value;
    RefreshOptions;
  end;
end;

procedure TppTBCustomItem.SetOptions(Value: TppTBItemOptions);
begin
  Value := FixOptions(Value);
  if FOptions <> Value then begin
    FOptions := Value;
    RefreshOptions;
  end;
end;

procedure TppTBCustomItem.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then begin
    FVisible := Value;
    Change(True);
  end;
end;


{ TppTBGroupItem }

constructor TppTBGroupItem.Create(AOwner: TComponent);
begin
  inherited;
  ItemStyle := ItemStyle + [tbisEmbeddedGroup, tbisSubitemsEditable];
end;


{ TppTBSubmenuItem }

constructor TppTBSubmenuItem.Create(AOwner: TComponent);
begin
  inherited;
  ItemStyle := ItemStyle + [tbisSubMenu, tbisSubitemsEditable];
end;

function TppTBSubmenuItem.GetDropdownCombo: Boolean;
begin
  Result := tbisCombo in ItemStyle;
end;

procedure TppTBSubmenuItem.SetDropdownCombo(Value: Boolean);
begin
  if (tbisCombo in ItemStyle) <> Value then begin
    if Value then
      ItemStyle := ItemStyle + [tbisCombo]
    else
      ItemStyle := ItemStyle - [tbisCombo];
    Change(True);
  end;
end;


{ TppTBSeparatorItem }

constructor TppTBSeparatorItem.Create(AOwner: TComponent);
begin
  inherited;
  ItemStyle := ItemStyle - [tbisSelectable, tbisRedrawOnSelChange,
    tbisRedrawOnMouseOverChange] + [tbisSeparator, tbisClicksTransparent];
end;

function TppTBSeparatorItem.GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass;
begin
  Result := TppTBSeparatorItemViewer;
end;

procedure TppTBSeparatorItem.SetBlank(Value: Boolean);
begin
  if FBlank <> Value then begin
    FBlank := Value;
    Change(False);
  end;
end;


{ TppTBSeparatorItemViewer }

procedure TppTBSeparatorItemViewer.CalcSize(const Canvas: TCanvas;
  var AWidth, AHeight: Integer);
begin
  if not IsToolbarStyle then
    Inc(AHeight, DivRoundUp(GetTextHeight(Canvas.Handle) * 2, 3))
  else begin
    AWidth := 6;
    AHeight := 6;
  end;
end;

procedure TppTBSeparatorItemViewer.Paint(const Canvas: TCanvas;
  const ClientAreaRect: TRect; IsSelected, IsPushed, UseDisabledShadow: Boolean);
var
  DC: HDC;
  R: TRect;
  ToolbarStyle, Horiz, LineSep: Boolean;
begin
  DC := Canvas.Handle;
  if TppTBSeparatorItem(Item).FBlank then
    Exit;

  R := ClientAreaRect;
  ToolbarStyle := IsToolbarStyle;
  Horiz := not ToolbarStyle or (View.FOrientation = tbvoVertical);
  LineSep := tbisLineSep in State;
  if LineSep then
    Horiz := not Horiz;
  if Horiz then begin
    R.Top := R.Bottom div 2 - 1;
    if not ToolbarStyle then
      InflateRect(R, -tbMenuSeparatorOffset, 0)
    else if LineSep then begin
      if View.FOrientation = tbvoFloating then
        InflateRect(R, -tbLineSepOffset, 0)
      else
        InflateRect(R, -tbDockedLineSepOffset, 0);
    end;
    DrawEdge(DC, R, EDGE_ETCHED, BF_TOP);
  end
  else begin
    R.Left := R.Right div 2 - 1;
    if LineSep then
      InflateRect(R, 0, -tbDockedLineSepOffset);
    DrawEdge(DC, R, EDGE_ETCHED, BF_LEFT);
  end;
end;

function TppTBSeparatorItemViewer.UsesSameWidth: Boolean;
begin
  Result := False;
end;


{ TppTBControlItem }

constructor TppTBControlItem.Create(AOwner: TComponent);
begin
  inherited;
  ItemStyle := ItemStyle - [tbisSelectable] + [tbisClicksTransparent];
end;

constructor TppTBControlItem.CreateControlItem(AOwner: TComponent;
  AControl: TControl);
begin
  FControl := AControl;
  AControl.FreeNotification(Self);
  Create(AOwner);
end;

destructor TppTBControlItem.Destroy;
begin
  inherited;
  { Free the associated control *after* the item is completely destroyed }
  if not FDontFreeControl and Assigned(FControl) and
     not(csAncestor in FControl.ComponentState) then
    FControl.Free;
end;

procedure TppTBControlItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FControl) then
    Control := nil;
end;

procedure TppTBControlItem.SetControl(Value: TControl);
begin
  if FControl <> Value then begin
    FControl := Value;
    if Assigned(Value) then
      Value.FreeNotification(Self);
    Change(True);
  end;
end;


{ TppTBItemViewer }

constructor TppTBItemViewer.Create(AView: TppTBView; AItem: TppTBCustomItem;
  AGroupLevel: Integer);
begin
  FItem := AItem;
  FView := AView;
  FGroupLevel := AGroupLevel;
  ReferenceClickWnd;
end;

destructor TppTBItemViewer.Destroy;
begin
  RemoveFromClickList(Self);
  if Assigned(FAccObjectInstance) then begin
    FAccObjectInstance.ClientIsDestroying;
    FAccObjectInstance := nil;
  end;
  inherited;
  ReleaseClickWnd;
end;

function TppTBItemViewer.GetAccObject: IDispatch;
begin
  if FAccObjectInstance = nil then begin
    if not InitializeOleAcc then begin
      Result := nil;
      Exit;
    end;
    FAccObjectInstance := TppTBItemViewerAccObject.Create(Self);
  end;
  Result := FAccObjectInstance;
end;

procedure TppTBItemViewer.AccSelect(const AExecute: Boolean);
{ Called by ClickWndProc when an item of type TppTBItemViewer is in ClickList }
var
  Obj: IDispatch;
begin
  { Ensure FAccObjectInstance is created by calling GetAccObject }
  Obj := GetAccObject;
  if Assigned(Obj) then
    (FAccObjectInstance as TppTBItemViewerAccObject).HandleAccSelect(AExecute);
end;

procedure TppTBItemViewer.PostAccSelect(const AExecute: Boolean);
{ Internally called by TppTBItemViewerAccObject. Don't call directly. }
begin
  QueueClick(Self, Ord(AExecute));
end;

function TppTBItemViewer.IsAccessible: Boolean;
{ Returns True if MSAA clients should know about the viewer, specifically
  if it's either shown, off-edge, or clipped (in other words, not completely
  invisible/inaccessible). }
begin
  { Note: Can't simply check Item.Visible because the chevron item's Visible
    property is always True }
  Result := Show or OffEdge or Clipped;
end;

function TppTBItemViewer.GetCaptionText: String;
var
  P: Integer;
begin
  Result := Item.Caption;
  P := Pos(#9, Result);
  if P <> 0 then
    SetLength(Result, P-1);
end;

function TppTBItemViewer.GetHintText: String;
begin
  Result := GetShortHint(Item.Hint);
  { If there is no short hint, use the caption for the hint. Like Office,
    strip any trailing colon or ellipsis. }
  if (Result = '') and not(tboNoAutoHint in Item.EffectiveOptions) and
     (not(tbisSubmenu in Item.ItemStyle) or (tbisCombo in Item.ItemStyle) or
      not CaptionShown) then
    Result := StripAccelChars(StripTrailingPunctuation(GetCaptionText));
  { Call associated action's OnHint event handler to post-process the hint }
  if Assigned(Item.ActionLink) and
     (Item.ActionLink.Action is TCustomAction) then begin
    if not TCustomAction(Item.ActionLink.Action).DoHint(Result) then
      Result := '';
    { Note: TControlActionLink.DoShowHint actually misinterprets the result
      of DoHint, but we get it right... }
  end;
  { Add shortcut text }
  if (Result <> '') and Application.HintShortCuts and
     (Item.ShortCut <> scNone) then
    Result := Format('%s (%s)', [Result, ShortCutToText(Item.ShortCut)]);
end;

function TppTBItemViewer.CaptionShown: Boolean;
begin
  Result := (GetCaptionText <> '') and (not IsToolbarSize or
    (Item.ImageIndex < 0) or (Item.DisplayMode in [nbdmTextOnly, nbdmImageAndText])) or
    (tboImageAboveCaption in Item.EffectiveOptions);
end;

function TppTBItemViewer.ImageShown: Boolean;
begin
  {}{should also return false if Images=nil (use UsedImageList?)}
  ImageShown := (Item.ImageIndex >= 0) and
    ((Item.DisplayMode in [nbdmDefault, nbdmImageAndText]) or
     (IsToolbarStyle and (Item.DisplayMode = nbdmTextOnlyInMenus)));
end;

function TppTBItemViewer.GetImageList: TCustomImageList;
var
  V: TppTBView;
begin
  Result := Item.Images;
  if Assigned(Result) then
    Exit;
  V := View;
  repeat
    if Assigned(V.FCurParentItem) then begin
      Result := V.FCurParentItem.SubMenuImages;
      if Assigned(Result) then
        Break;
    end;
    if Assigned(V.FParentItem) then begin
      Result := V.FParentItem.SubMenuImages;
      if Assigned(Result) then
        Break;
    end;
    V := V.FParentView;
  until V = nil;
end;

function TppTBItemViewer.IsRotated: Boolean;
{ Returns True if the caption should be drawn with rotated (vertical) text,
  underneath the image }
begin
  Result := (View.Orientation = tbvoVertical) and
    not (tboNoRotation in Item.EffectiveOptions) and
    not (tboImageAboveCaption in Item.EffectiveOptions);
end;

procedure TppTBItemViewer.CalcSize(const Canvas: TCanvas;
  var AWidth, AHeight: Integer);
var
  ToolbarStyle: Boolean;
  DC: HDC;
  TextMetrics: TTextMetric;
  H, LeftMargin: Integer;
  ImgList: TCustomImageList;
  S: String;
  RotatedFont, SaveFont: HFONT;
begin
  ToolbarStyle := IsToolbarStyle;
  DC := Canvas.Handle;
  ImgList := GetImageList;
  if ToolbarStyle then begin
    AWidth := 6;
    AHeight := 6;
  end
  else begin
    AWidth := 0;
    AHeight := 0;
  end;
  if not ToolbarStyle or CaptionShown then begin
    if not IsRotated then begin
      GetTextMetrics(DC, TextMetrics);
      Inc(AHeight, TextMetrics.tmHeight);
      Inc(AWidth, GetTextWidth(DC, GetCaptionText, True));
      if ToolbarStyle then
        Inc(AWidth, 6);
    end
    else begin
      { Vertical text isn't always the same size as horizontal text, so we have
        to select the rotated font into the DC to get an accurate size }
      RotatedFont := CreateRotatedFont(DC);
      SaveFont := SelectObject(DC, RotatedFont);
      GetTextMetrics(DC, TextMetrics);
      Inc(AWidth, TextMetrics.tmHeight);
      Inc(AHeight, GetTextWidth(DC, GetCaptionText, True));
      if ToolbarStyle then
        Inc(AHeight, 6);
      SelectObject(DC, SaveFont);
      DeleteObject(RotatedFont);
    end;
  end;
  if ToolbarStyle and ImageShown and Assigned(ImgList) then begin
    if not IsRotated and not(tboImageAboveCaption in Item.EffectiveOptions) then begin
      Inc(AWidth, ImgList.Width + 1);
      if AHeight < ImgList.Height + 6 then
        AHeight := ImgList.Height + 6;
    end
    else begin
      Inc(AHeight, ImgList.Height);
      if AWidth < ImgList.Width + 7 then
        AWidth := ImgList.Width + 7;
    end;
  end;
  if ToolbarStyle and (tbisSubmenu in Item.ItemStyle) then begin
    if tbisCombo in Item.ItemStyle then
      Inc(AWidth, tbDropdownComboArrowWidth)
    else
    if tboDropdownArrow in Item.EffectiveOptions then begin
      if View.Orientation <> tbvoVertical then
        Inc(AWidth, tbDropdownArrowWidth)
      else
        Inc(AHeight, tbDropdownArrowWidth);
    end;
  end;
  if not ToolbarStyle then begin
    Inc(AHeight, TextMetrics.tmExternalLeading + tbMenuVerticalMargin);
    if Assigned(ImgList) then begin
      H := ImgList.Height + 3;
      if H > AHeight then
        AHeight := H;
      LeftMargin := MulDiv(ImgList.Width + 3, AHeight, H);
    end
    else
      LeftMargin := AHeight;
    Inc(AWidth, LeftMargin + tbMenuImageTextSpace + tbMenuLeftTextMargin +
      tbMenuRightTextMargin);
    S := Item.GetShortCutText;
    if S <> '' then
      Inc(AWidth, (AHeight - 6) + GetTextWidth(DC, S, True));
    Inc(AWidth, AHeight);
  end;
end;

procedure TppTBItemViewer.DrawItemCaption(const Canvas: TCanvas; ARect: TRect;
  const ACaption: String; ADrawDisabledShadow: Boolean; AFormat: UINT);
var
  DC: HDC;

  procedure Draw;
  begin
    if not IsRotated then
      DrawText(DC, PChar(ACaption), Length(ACaption), ARect, AFormat)
    else
      DrawRotatedText(DC, ACaption, ARect, AFormat);
  end;

var
  ShadowColor, HighlightColor, SaveTextColor: DWORD;
begin
  DC := Canvas.Handle;
  if not ADrawDisabledShadow then
    Draw
  else begin
    ShadowColor := GetSysColor(COLOR_BTNSHADOW);
    HighlightColor := GetSysColor(COLOR_BTNHIGHLIGHT);
    OffsetRect(ARect, 1, 1);
    SaveTextColor := SetTextColor(DC, HighlightColor);
    Draw;
    OffsetRect(ARect, -1, -1);
    SetTextColor(DC, ShadowColor);
    Draw;
    SetTextColor(DC, SaveTextColor);
  end;
end;

procedure TppTBItemViewer.Paint(const Canvas: TCanvas;
  const ClientAreaRect: TRect; IsSelected, IsPushed, UseDisabledShadow: Boolean);
var
  ShowEnabled, HasArrow: Boolean;
  MenuCheckWidth, MenuCheckHeight: Integer;

  function GetDrawTextFlags: UINT;
  begin
    Result := 0;
    if not AreKeyboardCuesEnabled and (vsUseHiddenAccels in View.FStyle) and
       not(vsShowAccels in View.FState) then
      Result := DT_HIDEPREFIX;
  end;

  procedure DrawSubmenuArrow;
  var
    BR: TRect;
    Bmp: TBitmap;

    procedure DrawWithColor(AColor: TColor);
    const
      ROP_DSPDxax = $00E20746;
    var
      DC: HDC;
      SaveTextColor, SaveBkColor: TColorRef;
    begin
      Canvas.Brush.Color := AColor;
      DC := Canvas.Handle;
      SaveTextColor := SetTextColor(DC, clWhite);
      SaveBkColor := SetBkColor(DC, clBlack);
      BitBlt(DC, BR.Left, BR.Top, MenuCheckWidth, MenuCheckHeight,
        Bmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
      SetBkColor(DC, SaveBkColor);
      SetTextColor(DC, SaveTextColor);
      Canvas.Brush.Style := bsClear;
    end;

  begin
    Bmp := TBitmap.Create;
    try
      Bmp.Monochrome := True;
      Bmp.Width := MenuCheckWidth;
      Bmp.Height := MenuCheckHeight;
      BR := Rect(0, 0, MenuCheckWidth, MenuCheckHeight);
      DrawFrameControl(Bmp.Canvas.Handle, BR, DFC_MENU, DFCS_MENUARROW);
      OffsetRect(BR, ClientAreaRect.Right - MenuCheckWidth,
        ClientAreaRect.Top + ((ClientAreaRect.Bottom - ClientAreaRect.Top) - MenuCheckHeight) div 2);
      if not UseDisabledShadow then begin
        if ShowEnabled and (tbisCombo in Item.ItemStyle) and IsSelected then begin
          OffsetRect(BR, 1, 1);
          DrawWithColor(clBtnText);
        end
        else
          DrawWithColor(Canvas.Font.Color);
      end
      else begin
        OffsetRect(BR, 1, 1);
        DrawWithColor(clBtnHighlight);
        OffsetRect(BR, -1, -1);
        DrawWithColor(clBtnShadow);
      end;
    finally
      Bmp.Free;
    end;
  end;

  procedure DrawDropdownArrow(R: TRect; Rotated: Boolean);

    procedure DrawWithColor(AColor: TColor);
    var
      X, Y: Integer;
      P: array[0..2] of TPoint;
    begin
      X := (R.Left + R.Right) div 2;
      Y := (R.Top + R.Bottom) div 2;
      if not Rotated then begin
        Dec(Y);
        P[0].X := X-2;
        P[0].Y := Y;
        P[1].X := X+2;
        P[1].Y := Y;
        P[2].X := X;
        P[2].Y := Y+2;
      end
      else begin
        Dec(X);
        P[0].X := X;
        P[0].Y := Y+2;
        P[1].X := X;
        P[1].Y := Y-2;
        P[2].X := X-2;
        P[2].Y := Y;
      end;
      Canvas.Pen.Color := AColor;
      Canvas.Brush.Color := AColor;
      Canvas.Polygon(P);
    end;

  begin
    if not UseDisabledShadow then
      DrawWithColor(Canvas.Font.Color)
    else begin
      OffsetRect(R, 1, 1);
      DrawWithColor(clBtnHighlight);
      OffsetRect(R, -1, -1);
      DrawWithColor(clBtnShadow);
    end;
  end;

  function GetDitherBitmap: TBitmap;
  begin
    Result := AllocPatternBitmap(clBtnFace, clBtnHighlight);
    Result.HandleType := bmDDB;  { needed for Win95, or else brush is solid white }
  end;

const
  EdgeStyles: array[Boolean] of UINT = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  CheckMarkPoints: array[0..11] of TPoint = (
    { Black }
    (X: -2; Y: -2), (X: 0; Y:  0), (X:  4; Y: -4),
    (X:  4; Y: -3), (X: 0; Y:  1), (X: -2; Y: -1),
    (X: -2; Y: -2),
    { White }
    (X: -3; Y: -2), (X: -3; Y: -1), (X: 0; Y: 2),
    (X:  5; Y: -3), (X:  5; Y: -5));
var
  ToolbarStyle, ImageIsShown: Boolean;
  R, RC, RD: TRect;
  S: String;
  ImgList: TCustomImageList;
  I, X, Y: Integer;
  Points: array[0..11] of TPoint;
  DrawTextFlags: UINT;
  LeftMargin: Integer;
  TextMetrics: TTextMetric;
begin
  ToolbarStyle := IsToolbarStyle;
  ShowEnabled := Item.Enabled or View.Customizing;
  HasArrow := (tbisSubmenu in Item.ItemStyle) and
    ((tbisCombo in Item.ItemStyle) or (tboDropdownArrow in Item.EffectiveOptions));
  MenuCheckWidth := GetSystemMetrics(SM_CXMENUCHECK);
  MenuCheckHeight := GetSystemMetrics(SM_CYMENUCHECK);
  ImgList := GetImageList;
  ImageIsShown := ImageShown and Assigned(ImgList);
  LeftMargin := 0;
  if not ToolbarStyle then begin
    if Assigned(ImgList) then
      LeftMargin := MulDiv(ImgList.Width + 3, ClientAreaRect.Bottom, ImgList.Height + 3)
    else
      LeftMargin := ClientAreaRect.Bottom;
  end;

  { Border }
  RC := ClientAreaRect;
  if ToolbarStyle then begin
    if HasArrow then begin
      if tbisCombo in Item.ItemStyle then begin
        Dec(RC.Right, tbDropdownComboMargin);
        RD := RC;
        Dec(RC.Right, tbDropdownComboArrowWidth - tbDropdownComboMargin);
        RD.Left := RC.Right;
      end
      else begin
        if View.Orientation <> tbvoVertical then
          RD := Rect(RC.Right - tbDropdownArrowWidth - tbDropdownArrowMargin, 0,
            RC.Right - tbDropdownArrowMargin, RC.Bottom)
        else
          RD := Rect(0, RC.Bottom - tbDropdownArrowWidth - tbDropdownArrowMargin,
            RC.Right, RC.Bottom - tbDropdownArrowMargin);
      end;
    end
    else
      SetRectEmpty(RD);
    if (IsSelected and ShowEnabled) or Item.Checked or
       (csDesigning in Item.ComponentState) then begin
      if not(tbisCombo in Item.ItemStyle) then
        DrawEdge(Canvas.Handle, RC, EdgeStyles[IsPushed or Item.Checked], BF_RECT)
      else begin
        DrawEdge(Canvas.Handle, RC, EdgeStyles[(IsPushed and View.FCapture) or Item.Checked], BF_RECT);
        if (IsSelected and ShowEnabled) or
           (csDesigning in Item.ComponentState) then
          DrawEdge(Canvas.Handle, RD, EdgeStyles[IsPushed and not View.FCapture], BF_RECT);
      end;
    end;
    if HasArrow then begin
      if not(tbisCombo in Item.ItemStyle) and IsPushed then
        OffsetRect(RD, 1, 1);
      DrawDropdownArrow(RD, not(tbisCombo in Item.ItemStyle) and
        (View.Orientation = tbvoVertical));
    end;
    InflateRect(RC, -1, -1);
    if Item.Checked and not (IsSelected and ShowEnabled) then begin
      Canvas.Brush.Bitmap := GetDitherBitmap;
      Canvas.FillRect(RC);
      Canvas.Brush.Style := bsClear;
    end;
    InflateRect(RC, -1, -1);
    if Item.Checked or
       ((IsSelected and IsPushed) and
        (not(tbisCombo in Item.ItemStyle) or View.FCapture)) then
      OffsetRect(RC, 1, 1);
    if HasArrow and not(tbisCombo in Item.ItemStyle) then begin
      if View.Orientation <> tbvoVertical then
        Dec(RC.Right, tbDropdownArrowWidth)
      else
        Dec(RC.Bottom, tbDropdownArrowWidth);
    end;
  end
  else begin
    { On selected menu items, fill the background with the selected color.
      Note: This assumes the brush color was not changed from the initial
      value. }
    if IsSelected then begin
      R := RC;
      if ImageIsShown or Item.Checked then
        Inc(R.Left, LeftMargin + tbMenuImageTextSpace);
      if (tbisCombo in Item.ItemStyle) and IsSelected and ShowEnabled then
        Dec(R.Right, MenuCheckWidth);
      Canvas.FillRect(R);
    end;
  end;

  { Adjust brush & font }
  Canvas.Brush.Style := bsClear;
  if tboDefault in Item.EffectiveOptions then
    with Canvas.Font do Style := Style + [fsBold];
  GetTextMetrics(Canvas.Handle, TextMetrics);

  { Caption }
  if CaptionShown then begin
    S := GetCaptionText;
    R := RC;
    DrawTextFlags := GetDrawTextFlags;
    if ToolbarStyle then begin
      if ImageIsShown then begin
        if not IsRotated and not(tboImageAboveCaption in Item.EffectiveOptions) then
          Inc(R.Left, ImgList.Width + 1)
        else
          Inc(R.Top, ImgList.Height + 1);
      end;
      DrawItemCaption(Canvas, R, S, UseDisabledShadow,
        DT_SINGLELINE or DT_CENTER or DT_VCENTER or DrawTextFlags)
    end
    else begin
      Inc(R.Left, LeftMargin + tbMenuImageTextSpace + tbMenuLeftTextMargin);
      { Like standard menus, shift the text up one pixel if the text height
        is 4 pixels less than the total item height. This is done so underlined
        characters aren't displayed too low. }
      if (R.Bottom - R.Top) - (TextMetrics.tmHeight + TextMetrics.tmExternalLeading) = tbMenuVerticalMargin then
        Dec(R.Bottom);
      Inc(R.Top, TextMetrics.tmExternalLeading);
      DrawItemCaption(Canvas, R, S, UseDisabledShadow,
        DT_SINGLELINE or DT_LEFT or DT_VCENTER or DrawTextFlags);
    end;
  end;

  { Shortcut and/or submenu arrow (menus only) }
  if not ToolbarStyle then begin
    S := Item.GetShortCutText;
    if S <> '' then begin
      R := RC;
      R.Left := R.Right - (R.Bottom - R.Top) - GetTextWidth(Canvas.Handle, S, True);
      { Like standard menus, shift the text up one pixel if the text height
        is 4 pixels less than the total item height. This is done so underlined
        characters aren't displayed too low. }
      if (R.Bottom - R.Top) - (TextMetrics.tmHeight + TextMetrics.tmExternalLeading) = tbMenuVerticalMargin then
        Dec(R.Bottom);
      Inc(R.Top, TextMetrics.tmExternalLeading);
      DrawItemCaption(Canvas, R, S, UseDisabledShadow,
        DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_NOPREFIX);
    end;
    if tbisSubmenu in Item.ItemStyle then begin
      if tbisCombo in Item.ItemStyle then begin
        R := RC;
        R.Left := R.Right - MenuCheckWidth;
        if IsSelected and ShowEnabled then
          DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_RECT or BF_MIDDLE)
        else begin
          Dec(R.Left);
          if not IsSelected then
            DrawEdge(Canvas.Handle, R, EDGE_ETCHED, BF_LEFT)
          else
            DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_LEFT);
        end;
      end;
      DrawSubmenuArrow;
    end;
  end;

  { Image, or check box }
  if ImageIsShown or (not ToolbarStyle and Item.Checked) then begin
    R := RC;
    if ToolbarStyle then begin
      if not IsRotated and not(tboImageAboveCaption in Item.EffectiveOptions) then
        R.Right := R.Left + ImgList.Width + 2
      else
        R.Bottom := R.Top + ImgList.Height + 2;
    end
    else begin
      R.Right := R.Left + LeftMargin;
      if (IsSelected and ShowEnabled) or Item.Checked then
        DrawEdge(Canvas.Handle, R, EdgeStyles[Item.Checked], BF_RECT or BF_MIDDLE);
      if Item.Checked and not IsSelected then begin
        InflateRect(R, -1, -1);
        Canvas.Brush.Bitmap := GetDitherBitmap;
        Canvas.FillRect(R);
        Canvas.Brush.Style := bsClear;
        InflateRect(R, 1, 1);
      end;
      if Item.Checked then
        OffsetRect(R, 1, 1);
    end;
    if ImageIsShown then begin
      X := R.Left + ((R.Right - R.Left) - ImgList.Width) div 2;
      Y := R.Top + ((R.Bottom - R.Top) - ImgList.Height) div 2;
      if ImgList is TppTBCustomImageList then
        TppTBCustomImageList(ImgList).DrawState(Canvas, X, Y, Item.ImageIndex,
          ShowEnabled, IsSelected, Item.Checked)
      else
        ImgList.Draw(Canvas, X, Y, Item.ImageIndex, ShowEnabled);
    end
    else
      if not ToolbarStyle and Item.Checked then begin
        { Draw check mark }
        X := (R.Left + R.Right) div 2 - 2;
        Y := (R.Top + R.Bottom) div 2 + 1;
        System.Move(CheckMarkPoints, Points, 12 * SizeOf(TPoint));
        for I := Low(Points) to High(Points) do begin
          Inc(Points[I].X, X);
          Inc(Points[I].Y, Y);
        end;
        Canvas.Pen.Color := clBtnText;
        Polyline(Canvas.Handle, Points[0], 7);
        Canvas.Pen.Color := clBtnHighlight;
        Polyline(Canvas.Handle, Points[7], 5);
      end;
  end;
end;

procedure TppTBItemViewer.GetCursor(const Pt: TPoint; var ACursor: HCURSOR);
begin
end;

function TppTBItemViewer.GetIndex: Integer;
begin
  Result := View.IndexOf(Self);
end;

function TppTBItemViewer.IsToolbarSize: Boolean;
begin
  Result := View.FIsToolbar or (tboToolbarSize in Item.FEffectiveOptions);
end;

function TppTBItemViewer.IsToolbarStyle: Boolean;
begin
  Result := View.FIsToolbar or (tboToolbarStyle in Item.FEffectiveOptions);
end;

function TppTBItemViewer.IsPtInButtonPart(X, Y: Integer): Boolean;
var
  W: Integer;
begin
  Result := not(tbisSubmenu in Item.ItemStyle);
  if tbisCombo in Item.ItemStyle then begin
    if IsToolbarStyle then
      W := tbDropdownComboArrowWidth
    else
      W := GetSystemMetrics(SM_CXMENUCHECK);
    Result := X < (BoundsRect.Right - BoundsRect.Left) - W;
  end;
end;

procedure TppTBItemViewer.MouseDown(Shift: TShiftState; X, Y: Integer;
  var MouseDownOnMenu: Boolean);

  procedure HandleDefaultDoubleClick(const View: TppTBView);
  { Looks for a tboDefault item in View and ends the modal loop if it finds
    one. }
  var
    I: Integer;
    Viewer: TppTBItemViewer;
    Item: TppTBCustomItem;
  begin
    for I := 0 to View.FViewerCount-1 do begin
      Viewer := View.FViewers[I];
      Item := Viewer.Item;
      if (Viewer.Show or Viewer.Clipped) and (tboDefault in Item.EffectiveOptions) and
         (tbisSelectable in Item.ItemStyle) and Item.Enabled and Item.Visible then begin
        Viewer.Execute(True);
        Break;
      end;
    end;
  end;

var
  WasAlreadyOpen: Boolean;
begin
  if not Item.Enabled then begin
    if (View.FParentView = nil) and not View.FIsPopup then
      View.EndModal;
    Exit;
  end;
  if IsPtInButtonPart(X, Y) then begin
    if IsToolbarStyle then begin
      View.CancelChildPopups;
      View.SetCapture;
      View.Invalidate(Self);
    end;
  end
  else begin
    WasAlreadyOpen := (View.FOpenViewer = Self);
    if View.OpenChildPopup(False) then begin
      if WasAlreadyOpen and ((View.FParentView = nil) and not View.FIsPopup) then
        MouseDownOnMenu := True;
      if (ssDouble in Shift) and not(tbisCombo in Item.ItemStyle) then
        HandleDefaultDoubleClick(View.FOpenViewerView);
    end;
  end;
end;

procedure TppTBItemViewer.MouseMove(X, Y: Integer);
begin
end;

procedure TppTBItemViewer.MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean);
var
  HadCapture, IsToolbarItem: Boolean;
begin
  HadCapture := View.FCapture;
  View.CancelCapture;
  IsToolbarItem := (View.FParentView = nil) and not View.FIsPopup;
  if not View.FMouseOverSelected or not Item.Enabled or
     (tbisClicksTransparent in Item.ItemStyle) then begin
    if IsToolbarItem then
      View.EndModal;
    Exit;
  end;
  if (tbisSubmenu in Item.ItemStyle) and not IsPtInButtonPart(X, Y) then begin
    if IsToolbarItem and MouseWasDownOnMenu then
      View.EndModal;
  end
  else begin
    { it's a 'normal' item }
    if not IsToolbarStyle or HadCapture then
      Execute(True);
  end;
end;

procedure TppTBItemViewer.MouseWheel(WheelDelta, X, Y: Integer);
begin
end;

procedure TppTBItemViewer.LosingCapture;
begin
  View.Invalidate(Self);
end;

procedure TppTBItemViewer.Entering(OldSelected: TppTBItemViewer);
begin
  if Assigned(Item.FOnSelect) then
    Item.FOnSelect(Item, Self, True);
end;

procedure TppTBItemViewer.Leaving;
begin
  if Assigned(Item.FOnSelect) then
    Item.FOnSelect(Item, Self, False);
end;

procedure TppTBItemViewer.KeyDown(var Key: Word; Shift: TShiftState);
begin
end;

function TppTBItemViewer.ScreenToClient(const P: TPoint): TPoint;
begin
  Result := View.FWindow.ScreenToClient(P);
  Dec(Result.X, BoundsRect.Left);
  Dec(Result.Y, BoundsRect.Top);
end;

function TppTBItemViewer.UsesSameWidth: Boolean;
{ If UsesSameWidth returns True, the item viewer's width will be expanded to
  match the widest item viewer on the same view whose UsesSameWidth method
  also returns True. }
begin
  Result := (tboImageAboveCaption in Item.FEffectiveOptions) and
    (tboSameWidth in Item.FEffectiveOptions) and IsToolbarSize;
end;

function TppTBItemViewer.DoExecute: Boolean;
{ Low-level 'execute' handler. Returns True if the caller should call
  GivePriority on the viewer (normally, if the 'execute' operation was a
  success and the modal loop is ending). }
begin
  View.EndModalWithClick(Self);
  Result := True;
end;

procedure TppTBItemViewer.Execute(AGivePriority: Boolean);
{ Calls DoExecute and, if applicable, View.GivePriority. Note that it is up to
  the caller to check the viewer's visibility and enabled state. }
begin
  if DoExecute and AGivePriority then
    View.GivePriority(Self);
end;

function TppTBItemViewer.GetAccRole: Integer;
{ Returns the MSAA "role" of the viewer. }
const
  { Constants from OleAcc.h }
  ROLE_SYSTEM_CLIENT = $a;
  ROLE_SYSTEM_MENUITEM = $c;
  ROLE_SYSTEM_SEPARATOR = $15;
  ROLE_SYSTEM_PUSHBUTTON = $2b;
  ROLE_SYSTEM_BUTTONMENU = $39;
begin
  if Item is TppTBControlItem then
    Result := ROLE_SYSTEM_CLIENT
  else if tbisSeparator in Item.ItemStyle then
    Result := ROLE_SYSTEM_SEPARATOR
  else if View.IsPopup or (vsMenuBar in View.Style) then
    Result := ROLE_SYSTEM_MENUITEM
  else if tbisSubmenu in Item.ItemStyle then
    Result := ROLE_SYSTEM_BUTTONMENU
  else
    Result := ROLE_SYSTEM_PUSHBUTTON;
end;

function TppTBItemViewer.GetAccValue(var Value: WideString): Boolean;
{ Gets the MSAA "value" text of the viewer. Returns True if something was
  assigned to Value, or False if the viewer does not possess a "value". } 
begin
  Result := False;
end;


{ TppTBView }

constructor TppTBView.CreateView(AOwner: TComponent; AParentView: TppTBView;
  AParentItem: TppTBCustomItem; AWindow: TWinControl;
  AIsToolbar, ACustomizing, AUsePriorityList: Boolean);
begin
  Create(AOwner);
  FBackgroundColor := clDefault;
  FCustomizing := ACustomizing;
  FIsPopup := not AIsToolbar;
  FIsToolbar := AIsToolbar;
  FNewViewersGetHighestPriority := True;
  FParentView := AParentView;
  FParentItem := AParentItem;
  if Assigned(FParentItem) then begin
    //FIsToolbar := FIsToolbar or FParentItem.FDisplayAsToolbar;
    FParentItem.RegisterNotification(LinkNotification);
    FParentItem.FreeNotification(Self);
  end;
  FUsePriorityList := AUsePriorityList;
  FWindow := AWindow;
  UpdateCurParentItem;
end;

destructor TppTBView.Destroy;
begin
  CloseChildPopups;
  if Assigned(FAccObjectInstance) then begin
    FAccObjectInstance.ClientIsDestroying;
    { Get rid of our own reference to FAccObjectInstance. Normally the
      reference count will be now be zero and FAccObjectInstance will be
      freed, unless MSAA still holds a reference. }
    FAccObjectInstance._Release;
    FAccObjectInstance := nil;
  end;
  { If parent view is a toolbar, invalidate the open item so that it's
    redrawn back in the "up" position }
  if Assigned(ParentView) and ParentView.FIsToolbar then begin
    Include(ParentView.FState, vsNoAnimation);
    if Assigned(ParentView.FOpenViewer) then
      ParentView.Invalidate(ParentView.FOpenViewer);
  end;
  if Assigned(FCurParentItem) then
    FCurParentItem.UnregisterNotification(ItemNotification);
  if Assigned(FParentItem) then
    FParentItem.UnregisterNotification(LinkNotification);
  inherited;
  FPriorityList.Free;
  FreeViewers;
  { Now that we're destroyed, "focus" the parent view }
  if Assigned(FParentView) then
    FParentView.NotifyFocusEvent;
end;

function TppTBView.GetAccObject: IDispatch;
begin
  if FAccObjectInstance = nil then begin
    if not InitializeOleAcc then begin
      Result := nil;
      Exit;
    end;
    FAccObjectInstance := TppTBViewAccObject.Create(Self);
    { Strictly as an optimization, take a reference for ourself and keep it
      for the lifetime of the view. (Destroy calls _Release.) }
    FAccObjectInstance._AddRef;
  end;
  Result := FAccObjectInstance;
end;

function TppTBView.HandleWMGetObject(var Message: TMessage): Boolean;
begin
  if (Message.LParam = Integer(OBJID_CLIENT)) and InitializeOleAcc then begin
    Message.Result := LresultFromObjectFunc(IppTBAccessible, Message.WParam, GetAccObject);
    Result := True;
  end
  else
    Result := False;
end;

procedure TppTBView.UpdateCurParentItem;
var
  Value: TppTBCustomItem;
begin
  Value := ItemContainingItems(FParentItem);
  if FCurParentItem <> Value then begin
    CloseChildPopups;
    if Assigned(FCurParentItem) then
      FCurParentItem.UnregisterNotification(ItemNotification);
    FCurParentItem := Value;
    if Assigned(Value) then
      Value.RegisterNotification(ItemNotification);
    RecreateAllViewers;
    if Assigned(Value) and not(csDesigning in Value.ComponentState) then
      InitiateActions;
  end;
end;

procedure TppTBView.InitiateActions;
var
  I: Integer;
begin
  { Use a 'while' instead of a 'for' since an InitiateAction implementation
    may add/delete items }
  I := 0;
  while I < FViewerCount do begin
    FViewers[I].Item.InitiateAction;
    Inc(I);
  end;
end;

procedure TppTBView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then begin
    if AComponent = FParentItem then begin
      FParentItem := nil;
      UpdateCurParentItem;
      if Assigned(FParentView) then
        FParentView.CloseChildPopups;
    end
    else if AComponent = FOpenViewerWindow then begin
      FOpenViewerWindow := nil;
      FOpenViewerView := nil;
      FOpenViewer := nil;
    end
    else if AComponent = FChevronParentView then
      FChevronParentView := nil;
  end
end;

function TppTBView.ContainsView(AView: TppTBView): Boolean;
begin
  while Assigned(AView) and (AView <> Self) do
    AView := AView.FParentView;
  Result := Assigned(AView);
end;

function TppTBView.GetRootView: TppTBView;
begin
  Result := Self;
  while Assigned(Result.FParentView) do
    Result := Result.FParentView;
end;

function TppTBView.GetParentToolbarView: TppTBView;
begin
  Result := Self;
  while Assigned(Result) and not Result.FIsToolbar do
    Result := Result.FParentView;
end;

procedure TppTBView.FreeViewers;
var
  VI: PTBItemViewerArray;
  I, C: Integer;
begin
  if Assigned(FViewers) then begin
    VI := FViewers;
    C := FViewerCount;
    FViewers := nil;
    FViewerCount := 0;
    for I := C-1 downto 0 do
      FreeAndNil(VI[I]);
    FreeMem(VI);
  end;
end;

procedure TppTBView.InvalidatePositions;
begin
  if FValidated then begin
    FValidated := False;
    if Assigned(FWindow) and FWindow.HandleAllocated then
      InvalidateRect(FWindow.Handle, nil, True);
  end;
end;

procedure TppTBView.ValidatePositions;
begin
  if not FValidated then
    UpdatePositions;
end;

procedure TppTBView.TryValidatePositions;
begin
  if (FUpdating = 0) and
     (not Assigned(FParentItem) or not(csLoading in FParentItem.ComponentState)) and
     (not Assigned(FParentItem.Owner) or not(csLoading in FParentItem.Owner.ComponentState)) then
    ValidatePositions;
end;

(*procedure TppTBView.TryRevalidatePositions;
begin
  if FValidated then begin
    if FUpdating = 0 then begin
      FreePositions;
      UpdatePositions;
    end
    else
      InvalidatePositions;
  end;
end;*)

function TppTBView.Find(Item: TppTBCustomItem): TppTBItemViewer;
var
  I: Integer;
begin
  for I := 0 to FViewerCount-1 do
    if FViewers[I].Item = Item then begin
      Result := FViewers[I];
      Exit;
    end;
  raise ETBItemError.Create(ppSTBViewerNotFound);
end;

function TppTBView.IndexOf(AViewer: TppTBItemViewer): Integer;
var
  I: Integer;
begin
  if Assigned(AViewer) then
    for I := 0 to FViewerCount-1 do
      if FViewers[I] = AViewer then begin
        Result := I;
        Exit;
      end;
  Result := -1;
end;


procedure TppTBView.DeletingViewer(Viewer: TppTBItemViewer);
begin
  if FSelected = Viewer then
    FSelected := nil;
  if FOpenViewer = Viewer then
    CloseChildPopups;
end;

procedure TppTBView.RecreateItemViewer(const I: Integer);
var
  OldViewer, NewViewer: TppTBItemViewer;
  J: Integer;
begin
  OldViewer := FViewers[I];
  DeletingViewer(OldViewer);
  NewViewer := OldViewer.Item.GetItemViewerClass(Self).Create(Self,
    OldViewer.Item, OldViewer.FGroupLevel);
  FViewers[I] := NewViewer;
  if Assigned(FPriorityList) then begin
    J := FPriorityList.IndexOf(OldViewer);
    if J <> -1 then
      FPriorityList[J] := NewViewer;
  end;
  OldViewer.Free;
end;

function TppTBView.InsertItemViewers(const NewIndex: Integer;
  const AItem: TppTBCustomItem; const AGroupLevel: Integer;
  const AddToPriorityList, TopOfPriorityList: Boolean): Integer;
var
  NewViewer: TppTBItemViewer;
  LinkItem: TppTBCustomItem;
  I: Integer;
begin
  if AGroupLevel > MaxGroupLevel then begin
    Result := 0;
    Exit;
  end;

  NewViewer := AItem.GetItemViewerClass(Self).Create(Self, AItem,
    AGroupLevel);
  InsertIntoViewerArray(FViewers, FViewerCount, NewIndex,
    NewViewer);
  if AddToPriorityList and FUsePriorityList then begin
    if not TopOfPriorityList then
      AddToList(FPriorityList, NewViewer)
    else
      { When new items are inserted programmatically at run-time, place
        them at the top of FPriorityList }
      AddToFrontOfList(FPriorityList, NewViewer);
  end;
  Result := 1;

  { If a new group item is being inserted, insert all its child items too }
  if not FCustomizing and (tbisEmbeddedGroup in AItem.ItemStyle) then begin
    LinkItem := ItemContainingItems(AItem);
    for I := 0 to LinkItem.Count-1 do begin
      Inc(Result, InsertItemViewers(NewIndex + Result, LinkItem.FItems[I].Item,
        AGroupLevel + 1, AddToPriorityList, TopOfPriorityList));
    end;
  end;
end;

procedure TppTBView.ItemNotification(Ancestor: TppTBCustomItem; Relayed: Boolean;
  Action: TppTBItemChangedAction; Index: Integer; Item: TppTBCustomItem);

  procedure ItemInserted;
  var
    NewLevel, Start, InsertPoint, Last: Integer;
    GroupItem, NextItem: TppTBCustomItem;
    Found, SearchAgain: Boolean;
  begin
    InvalidatePositions;
    NewLevel := 0;
    Start := 0;
    if Ancestor = FCurParentItem then
      InsertPoint := FViewerCount
    else begin
      { Ancestor <> FCurParentItem, so apparently an item has been inserted
        inside a group item }
      repeat
        Found := False;
        while Start < FViewerCount do begin
          GroupItem := FViewers[Start].Item;
          if (tbisEmbeddedGroup in GroupItem.ItemStyle) and (GroupItem = Ancestor) then begin
            NewLevel := FViewers[Start].FGroupLevel + 1;
            Inc(Start);
            Found := True;
            Break;
          end;
          Inc(Start);
        end;
        if not Found then
          { Couldn't find Ancestor; it shouldn't get here }
          Exit;
        InsertPoint := Start;
        SearchAgain := False;
        while (InsertPoint < FViewerCount) and
           (FViewers[InsertPoint].FGroupLevel >= NewLevel) do begin
          if (FViewers[InsertPoint].Item = Item) and
             (FViewers[InsertPoint].FGroupLevel = NewLevel) then begin
            { If the item we were going to insert already exists, then there
              must be multiple instances of the same group item. This can
              happen when are two group items on the same toolbar each
              linking to the same submenu item, with the submenu item
              containing a group item of its own, and an item is inserted
              inside that. }
            SearchAgain := True;
            Break;
          end;
          Inc(InsertPoint);
        end;
      until not SearchAgain;
    end;
    if InsertPoint = FViewerCount then begin
      { Don't add items after the chevron or MDI buttons item }
      Dec(InsertPoint, FInternalViewersAtEnd);
      if InsertPoint < 0 then
        InsertPoint := 0;  { just in case? }
    end;
    { If the new item wasn't placed at the end, adjust InsertPoint accordingly }
    if Index < Item.Parent.Count-1 then begin
      Last := InsertPoint;
      InsertPoint := Start;
      NextItem := Item.Parent.FItems[Index+1].Item;
      while (InsertPoint < Last) and
         ((FViewers[InsertPoint].Item <> NextItem) or
          (FViewers[InsertPoint].FGroupLevel <> NewLevel)) do
        Inc(InsertPoint);
    end;
    InsertItemViewers(InsertPoint, Item, NewLevel, True,
      not(csLoading in Item.ComponentState) and FNewViewersGetHighestPriority);
  end;

  procedure ItemDeleting;

    procedure DeleteItem(DeleteIndex: Integer);
    var
      Viewer: TppTBItemViewer;
    begin
      Viewer := FViewers[DeleteIndex];
      DeletingViewer(Viewer);
      RemoveFromList(FPriorityList, Viewer);
      FreeAndNil(Viewer);
      DeleteFromViewerArray(FViewers, FViewerCount, DeleteIndex);
    end;

  var
    I: Integer;
    DeleteLevel: Integer;
  begin
    InvalidatePositions;
    I := 0;
    DeleteLevel := 0;
    while I < FViewerCount do begin
      if DeleteLevel > 0 then begin
        if FViewers[I].FGroupLevel >= DeleteLevel then begin
          DeleteItem(I);
          Continue;
        end
        else
          DeleteLevel := 0;
      end;
      if FViewers[I].Item = Item then begin
        { Delete the item, and any group item children afterward }
        DeleteLevel := FViewers[I].FGroupLevel + 1;
        DeleteItem(I);
        Continue;
      end;
      Inc(I);
    end;
  end;

var
  I: Integer;
begin
  case Action of
    tbicInserted: ItemInserted;
    tbicDeleting: ItemDeleting;
    tbicSubitemsChanged: RecreateAllViewers;
    tbicSubitemsBeginUpdate: BeginUpdate;
    tbicSubitemsEndUpdate: EndUpdate;
    tbicInvalidate: begin
        for I := 0 to FViewerCount-1 do
          if FViewers[I].Item = Item then
            Invalidate(FViewers[I]);
      end;
    tbicInvalidateAndResize: InvalidatePositions;
    tbicRecreateItemViewers: begin
        InvalidatePositions;
        for I := 0 to FViewerCount-1 do
          if FViewers[I].Item = Item then
            RecreateItemViewer(I);
      end;
    tbicSubMenuImagesChanged: ImagesChanged;
  else
    { Prevent TryValidatePositions from being called below on Actions other than
      those listed above. Currently there are no other Actions, but for forward
      compatibility, we should ignore unknown Actions completely. }
    Exit;
  end;
  TryValidatePositions;
end;

procedure TppTBView.LinkNotification(Ancestor: TppTBCustomItem; Relayed: Boolean;
  Action: TppTBItemChangedAction; Index: Integer; Item: TppTBCustomItem);
{ This notification procedure watches for tbicSubitemsChanged notifications
  from FParentItem }
begin
  case Action of
    tbicSubitemsChanged: UpdateCurParentItem;
    tbicSubMenuImagesChanged: begin
        { In case the images were inherited from the actual parent instead of
          the linked parent... }
        if FParentItem <> FCurParentItem then
          ImagesChanged;
      end;
  end;
end;

procedure TppTBView.ImagesChanged;
begin
  InvalidatePositions;
  TryValidatePositions;
  if Assigned(FOpenViewerView) then
    FOpenViewerView.ImagesChanged;
end;

procedure TppTBView.GivePriority(AViewer: TppTBItemViewer);
{ Move item to top of priority list. Rearranges items if necessary. }
var
  I: Integer;
begin
  if Assigned(FChevronParentView) then begin
    I := AViewer.Index + FChevronParentView.FInternalViewersAtFront;
    if I < FChevronParentView.FViewerCount then  { range check just in case }
      FChevronParentView.GivePriority(FChevronParentView.FViewers[I]);
    Exit;
  end;
  if Assigned(FPriorityList) then begin
    I := FPriorityList.IndexOf(AViewer);
    if I <> -1 then begin
      FPriorityList.Move(I, 0);
      if not FValidated or AViewer.OffEdge then
        UpdatePositions;
    end;
  end;
  { Call GivePriority on parent view, so that if an item on a submenu is
    clicked, the parent item of the submenu gets priority. }
  if Assigned(FParentView) and Assigned(FParentView.FOpenViewer) then
    FParentView.GivePriority(FParentView.FOpenViewer);
end;

function TppTBView.HighestPriorityViewer: TppTBItemViewer;
{ Returns index of first visible, non-separator item at top of priority list,
  or -1 if there are no items found }
var
  I: Integer;
  J: TppTBItemViewer;
begin
  ValidatePositions;
  Result := nil;
  if Assigned(FPriorityList) then begin
    for I := 0 to FPriorityList.Count-1 do begin
      J := FPriorityList[I];
      if J.Show and not(tbisSeparator in J.Item.ItemStyle) then begin
        Result := J;
        Break;
      end;
    end;
  end
  else begin
    for I := 0 to FViewerCount-1 do begin
      J := FViewers[I];
      if J.Show and not(tbisSeparator in J.Item.ItemStyle) then begin
        Result := J;
        Break;
      end;
    end;
  end;
end;

procedure TppTBView.StartTimer(const ATimer: TppTBViewTimerID;
  const Interval: Integer);
{ Starts a timer. Stops any previously set timer of the same ID first.
  Note: WM_TIMER messages generated by timers set by the method are handled
  in PopupMessageLoop. }
begin
  StopTimer(ATimer);
  if (FWindow is TppTBPopupWindow) and FWindow.HandleAllocated then begin
    SetTimer(FWindow.Handle, ViewTimerBaseID + Ord(ATimer), Interval, nil);
    Include(FActiveTimers, ATimer);
  end;
end;

procedure TppTBView.StopAllTimers;
var
  I: TppTBViewTimerID;
begin
  for I := Low(I) to High(I) do
    StopTimer(I);
end;

procedure TppTBView.StopTimer(const ATimer: TppTBViewTimerID);
begin
  if ATimer in FActiveTimers then begin
    if (FWindow is TppTBPopupWindow) and FWindow.HandleAllocated then
      KillTimer(FWindow.Handle, ViewTimerBaseID + Ord(ATimer));
    Exclude(FActiveTimers, ATimer);
  end;
end;

function TppTBView.OpenChildPopup(const SelectFirstItem: Boolean): Boolean;
var
  Item: TppTBCustomItem;
begin
  StopTimer(tiClose);
  StopTimer(tiOpen);
  if FSelected <> FOpenViewer then begin
    CloseChildPopups;
    if Assigned(FSelected) then begin
      Item := FSelected.Item;
      if Item.Enabled and (tbisSubmenu in Item.ItemStyle) then
        Item.CreatePopup(Self, FSelected, not FIsToolbar, SelectFirstItem,
          False, Point(0, 0), tbpaLeft);
    end;
  end;
  Result := Assigned(FOpenViewer);
end;

procedure TppTBView.CloseChildPopups;
begin
  if Assigned(FOpenViewerView) then
    FOpenViewerView.CloseChildPopups;
  StopTimer(tiClose);
  FOpenViewerWindow.Free;
  FOpenViewerWindow := nil;
  FOpenViewerView := nil;
  FOpenViewer := nil;
end;

procedure TppTBView.CancelChildPopups;
begin
  if FIsToolbar then
    Exclude(FState, vsDropDownMenus);
  CloseChildPopups;
end;

function TppTBView.ViewerFromPoint(const P: TPoint): TppTBItemViewer;
var
  I: Integer;
begin
  ValidatePositions;
  for I := 0 to FViewerCount-1 do begin
    if FViewers[I].Show and
       PtInRect(FViewers[I].BoundsRect, P) then begin
      Result := FViewers[I];
      Exit;
    end;
  end;
  Result := nil;
end;

procedure TppTBView.NotifyFocusEvent;
{ Notifies Active Accessibility of a change in "focus". Has no effect if the
  view or the root view lacks the vsModal state. }
var
  I, ChildID, J: Integer;
begin
  { Note: We don't notify about windows not yet shown (e.g. a popup menu that
    is still initializing) because that would probably confuse screen readers.
    Also allocating a window handle at this point *might* not be a good idea. }
  if (vsModal in FState) and (vsModal in GetRootView.FState) and
     FWindow.HandleAllocated and IsWindowVisible(FWindow.Handle) then begin
    if Assigned(FSelected) and FSelected.IsAccessible then
      I := IndexOf(FSelected)
    else
      I := -1;
    if (I < 0) and Assigned(FParentView) then begin
      { If we have no selected item, report the the selected item on the parent
        view as having the "focus".
        Note: With standard menus, when you go from having a selection to no
        selection on a submenu, it sends two focus events - first with the
        client window as having the focus, then with the parent item. I
        figure that's probably a bug, so I don't try to emulate that behavior
        here. }
      FParentView.NotifyFocusEvent;
    end
    else begin
      if I >= 0 then begin
        { Convert viewer index into a one-based child index.
          (TppTBViewAccObject.get_accChild does the inverse.) }
        ChildID := 1;
        for J := 0 to I-1 do
          if FViewers[J].IsAccessible then
            Inc(ChildID);
      end
      else begin
        { If there is no (accessible) selection and no parent view, report
          the client window itself as being "focused". This is what happens
          when a standard context menu has no selection. }
        ChildID := CHILDID_SELF;
      end;
      CallNotifyWinEvent(EVENT_OBJECT_FOCUS, FWindow.Handle, OBJID_CLIENT, ChildID);
    end;
  end;
end;

procedure TppTBView.SetSelected(Value: TppTBItemViewer);
begin
  Select(Value, False);
end;

procedure TppTBView.Select(Value: TppTBItemViewer; ViaMouse: Boolean);
{ Sets the current selection.
  When the selection is changing it will also, if necessary, open/close child
  popups. How exactly this works depends on the setting of ViaMouse. If
  ViaMouse is True it will delay the opening/closing of popups using timers. }
var
  OldSelected: TppTBItemViewer;
  NewMouseOverSelected: Boolean;
  P: TPoint;
begin
  OldSelected := FSelected;
  if Value <> OldSelected then begin
    { If there's a new selection and the parent item on the parent view
      isn't currently selected, select it. Also stop any timer running on
      the parent view. }
    if Assigned(Value) and Assigned(FParentView) and
       Assigned(FParentView.FOpenViewer) and
       (FParentView.FSelected <> FParentView.FOpenViewer) then begin
      FParentView.Selected := FParentView.FOpenViewer;
      FParentView.StopTimer(tiClose);
      FParentView.StopTimer(tiOpen);
    end;

    { Handle automatic closing of child popups }
    if vsModal in FState then begin
      { If the view is a toolbar, or if the new selection didn't come from
        the mouse, close child popups immediately }
      if FIsToolbar or not ViaMouse then begin
        { Always stop any close timer because CloseChildPopups may not be
          called below }
        StopTimer(tiClose);
        if Value <> FOpenViewer then
          { ^ But don't close if selection is returning to the open item.
            Needed for the "FParentView.Selected := FParentView.FOpenViewer"
            line above to work. }
          CloseChildPopups;
      end
      else begin
        { Otherwise, delay-close any child popup }
        if Assigned(FOpenViewerView) and not(tiClose in FActiveTimers) then
          StartTimer(tiClose, GetMenuShowDelay);
      end;
    end;

    CancelCapture;
    if Assigned(OldSelected) then
      OldSelected.Leaving;
    FSelected := Value;
    FSelectedViaMouse := ViaMouse;
  end;

  NewMouseOverSelected := False;
  if Assigned(Value) and Assigned(FWindow) then begin
    P := SmallPointToPoint(TSmallPoint(GetMessagePos()));
    if FindDragTarget(P, True) = FWindow then begin
      P := FWindow.ScreenToClient(P);
      NewMouseOverSelected := (ViewerFromPoint(P) = Value);
      if NewMouseOverSelected and FCapture and
         not Value.IsPtInButtonPart(P.X - Value.BoundsRect.Left,
         P.Y - Value.BoundsRect.Top) then
        NewMouseOverSelected := False;
    end;
  end;

  if Value <> OldSelected then begin
    FMouseOverSelected := NewMouseOverSelected;
    if Assigned(OldSelected) and (tbisRedrawOnSelChange in OldSelected.Item.ItemStyle) then
      Invalidate(OldSelected);
    if Assigned(Value) then begin
      if tbisRedrawOnSelChange in Value.Item.ItemStyle then
        Invalidate(Value);
      Value.Entering(OldSelected);
    end;
    NotifyFocusEvent;

    { Handle automatic opening of a child popup }
    if vsModal in FState then begin
      { If the view is a toolbar, immediately open any child popup }
      if FIsToolbar then begin
        if Assigned(Value) then begin
          if ViaMouse and Assigned(FParentView) then begin
            { On chevron popups, always drop down menus when mouse passes
              over them, like Office 2000 }
            Include(FState, vsDropDownMenus);
          end;
          if (vsDropDownMenus in FState) and
             (ViaMouse or not(tbisNoAutoOpen in Value.Item.ItemStyle)) then
            OpenChildPopup(not ViaMouse);
        end;
      end
      else begin
        { Otherwise, delay-open any child popup if the selection came from
          the mouse }
        StopTimer(tiOpen);
        if ViaMouse and Assigned(Value) and (tbisSubmenu in Value.Item.ItemStyle) then
          StartTimer(tiOpen, GetMenuShowDelay);
      end;
    end;
  end
  else if FMouseOverSelected <> NewMouseOverSelected then begin
    FMouseOverSelected := NewMouseOverSelected;
    if Assigned(Value) and FCapture and (tbisRedrawOnMouseOverChange in Value.Item.ItemStyle) then
      Invalidate(Value);
  end;
end;

procedure TppTBView.UpdateSelection(const P: PPoint; const AllowNewSelection: Boolean);
{ Called in response to a mouse movement, this method updates the current
  selection, updates the vsMouseInWindow view state, and enables/disables
  scroll timers. }

  function IsPtInScrollArrow(ADownArrow: Boolean): Boolean;
  var
    P2: TPoint;
    R: TRect;
  begin
    Result := False;
    if (vsModal in FState) and (vsMouseInWindow in FState) and
       Assigned(P) then begin
      P2 := FWindow.ScreenToClient(P^);
      R := FWindow.ClientRect;
      if PtInRect(R, P2) then begin
        if ADownArrow then
          Result := FShowDownArrow and (P2.Y >= R.Bottom - tbMenuScrollArrowHeight)
        else
          Result := FShowUpArrow and (P2.Y < tbMenuScrollArrowHeight);
      end;
    end;
  end;

var
  NewSelected, ViewerAtPoint: TppTBItemViewer;
  P2: TPoint;
  MouseWasInWindow: Boolean;
begin
  ValidatePositions;

  { If modal, default to keeping the existing selection }
  if vsModal in FState then
    NewSelected := FSelected
  else
    NewSelected := nil;

  { Is the mouse inside the window? }
  MouseWasInWindow := vsMouseInWindow in FState;
  if Assigned(P) and Assigned(FWindow) and (FindDragTarget(P^, True) = FWindow) then begin
    { If we're a popup window and the mouse is inside, default to no selection }
    if FIsPopup then
      NewSelected := nil;
    Include(FState, vsMouseInWindow);
    if AllowNewSelection or Assigned(FSelected) then begin
      P2 := FWindow.ScreenToClient(P^);
      ViewerAtPoint := ViewerFromPoint(P2);
      if Assigned(ViewerAtPoint) then
        NewSelected := ViewerAtPoint;
    end;
  end
  else
    Exclude(FState, vsMouseInWindow);

  { If FCapture is True, don't allow the selection to change }
  if FCapture and (NewSelected <> FSelected) then
    NewSelected := FSelected;

  { If we're a popup window and there is a selection... }
  if FIsPopup and Assigned(NewSelected) then begin
    { If the mouse just moved out of the window and no submenu was open,
      remove the highlight }
    if not FCapture and MouseWasInWindow and not(vsMouseInWindow in FState) and
       (not Assigned(FOpenViewerView) or not(tbisSubmenu in NewSelected.Item.ItemStyle)) then
      NewSelected := nil;
  end;

  { Now we set the new Selected value }
  Select(NewSelected, True);

  { Update scroll arrow timers }
  if IsPtInScrollArrow(False) then begin
    StopTimer(tiScrollDown);
    if not(tiScrollUp in FActiveTimers) then
      StartTimer(tiScrollUp, 100);
  end
  else if IsPtInScrollArrow(True) then begin
    StopTimer(tiScrollUp);
    if not(tiScrollDown in FActiveTimers) then
      StartTimer(tiScrollDown, 100);
  end
  else begin
    StopTimer(tiScrollUp);
    StopTimer(tiScrollDown);
  end;
end;

procedure TppTBView.RecreateAllViewers;
var
  Item: TppTBCustomItem;
  I: Integer;
begin
  { Since the FViewers list is being rebuilt, FOpenViewer and FSelected
    will no longer be valid, so ensure they're set to nil. }
  CloseChildPopups;
  Selected := nil;

  InvalidatePositions;

  FreeAndNil(FPriorityList);
  FreeViewers;
  FInternalViewersAtFront := 0;
  FInternalViewersAtEnd := 0;

  { MDI system menu item }
  Item := GetMDISystemMenuItem;
  if Assigned(Item) then
    Inc(FInternalViewersAtFront, InsertItemViewers(FViewerCount, Item, 0,
      False, False));

  { Items }
  if Assigned(FCurParentItem) then begin
    for I := 0 to FCurParentItem.Count-1 do
      InsertItemViewers(FViewerCount, FCurParentItem.FItems[I].Item, 0,
        True, False);
  end;

  { MDI buttons item }
  Item := GetMDIButtonsItem;
  if Assigned(Item) then begin
    for I := 0 to Item.Count-1 do
      Inc(FInternalViewersAtEnd, InsertItemViewers(FViewerCount,
        Item.FItems[I].Item, 0, False, False));
  end;

  { Chevron item }
  Item := GetChevronItem;
  if Assigned(Item) then
    Inc(FInternalViewersAtEnd, InsertItemViewers(FViewerCount, Item, 0,
      False, False));
end;

function TppTBView.CalculatePositions(const CanMoveControls: Boolean;
  const AOrientation: TppTBViewOrientation;
  AWrapOffset, AChevronOffset, AChevronSize: Integer;
  var ABaseSize, TotalSize: TPoint;
  var AWrappedLines: Integer): Boolean;
{ Returns True if the positions have changed }
type
  PTempPosition = ^TTempPosition;
  TTempPosition = record
    BoundsRect: TRect;
    Show, OffEdge, LineSep, Clipped, SameWidth: Boolean;
  end;
  PTempPositionArray = ^TTempPositionArray;
  TTempPositionArray = array[0..$7FFFFFFF div SizeOf(TTempPosition)-1] of TTempPosition;
var
  DC: HDC;
  LeftX, TopY, CurX, CurY, I: Integer;
  NewPositions: PTempPositionArray;
  GroupSplit, DidWrap: Boolean;
  LineStart, HighestHeightOnLine, HighestWidthOnLine: Integer;

  function GetSizeOfGroup(const StartingIndex: Integer): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := StartingIndex to FViewerCount-1 do begin
      if not NewPositions[I].Show then
        Continue;
      if tbisSeparator in FViewers[I].Item.ItemStyle then
        Break;
      with NewPositions[I] do begin
        if AOrientation <> tbvoVertical then
          Inc(Result, BoundsRect.Right)
        else
          Inc(Result, BoundsRect.Bottom);
      end;
    end;
  end;

  procedure Mirror;
  { Reverses the horizontal ordering (i.e. first item becomes last) }
  var
    I, NewRight: Integer;
  begin
    for I := 0 to FViewerCount-1 do
      with NewPositions[I] do
        if Show then begin
          NewRight := TotalSize.X - BoundsRect.Left;
          BoundsRect.Left := TotalSize.X - BoundsRect.Right;
          BoundsRect.Right := NewRight;
        end;
  end;

  procedure HandleMaxHeight;
  { Decreases, if necessary, the height of the view to FMaxHeight, and adjusts
    the visibility of the scroll arrows }
  var
    MaxOffset, I, MaxTop, MaxBottom: Integer;
  begin
    FShowUpArrow := False;
    FShowDownArrow := False;
    if (FMaxHeight > 0) and (TotalSize.Y > FMaxHeight) then begin
      MaxOffset := TotalSize.Y - FMaxHeight;
      if FScrollOffset > MaxOffset then
        FScrollOffset := MaxOffset;
      if FScrollOffset < 0 then
        FScrollOffset := 0;
      FShowUpArrow := (FScrollOffset > 0);
      FShowDownArrow := (FScrollOffset < MaxOffset);
      MaxTop := 0;
      if FShowUpArrow then
        MaxTop := tbMenuScrollArrowHeight;
      MaxBottom := FMaxHeight;
      if FShowDownArrow then
        Dec(MaxBottom, tbMenuScrollArrowHeight);
      for I := 0 to FViewerCount-1 do begin
        if not IsRectEmpty(NewPositions[I].BoundsRect) then begin
          OffsetRect(NewPositions[I].BoundsRect, 0, -FScrollOffset);
          if NewPositions[I].Show and
             ((NewPositions[I].BoundsRect.Top < MaxTop) or
              (NewPositions[I].BoundsRect.Bottom > MaxBottom)) then begin
            NewPositions[I].Show := False;
            NewPositions[I].Clipped := True;
          end;
        end;
      end;
      TotalSize.Y := FMaxHeight;
    end
    else
      FScrollOffset := 0;
  end;

  procedure FinalizeLine(const LineEnd: Integer; const LastLine: Boolean);
  var
    I, RightAlignStart: Integer;
    Item: TppTBCustomItem;
    IsButton: Boolean;
    Pos: PTempPosition;
    Z: Integer;
  begin
    if LineStart <> -1 then begin
      if DidWrap and (FChevronParentView = nil) then begin
        { When wrapping on a docked toolbar, extend TotalSize.X/Y to
          AWrapOffset so that the toolbar always fills the whole row }
        if (AOrientation = tbvoHorizontal) and (TotalSize.X < AWrapOffset) then
          TotalSize.X := AWrapOffset
        else if (AOrientation = tbvoVertical) and (TotalSize.Y < AWrapOffset) then
          TotalSize.Y := AWrapOffset;
      end;
      RightAlignStart := -1;
      for I := LineStart to LineEnd do begin
        Pos := @NewPositions[I];
        if not Pos.Show then
          Continue;
        Item := FViewers[I].Item;
        if (RightAlignStart < 0) and (tbisRightAlign in Item.ItemStyle) then
          RightAlignStart := I;
        IsButton := FIsToolbar or (tboToolbarSize in Item.FEffectiveOptions);
        if FIsToolbar then begin
          if LastLine and not DidWrap and (AOrientation <> tbvoFloating) then begin
            { In case the toolbar is docked next to a taller/wider toolbar... }
            HighestWidthOnLine := TotalSize.X;
            HighestHeightOnLine := TotalSize.Y;
          end;
          { Make separators on toolbars as tall/wide as the tallest/widest item }
          if [tbisSeparator, tbisStretch] * Item.ItemStyle <> [] then begin
            if AOrientation <> tbvoVertical then
              Pos.BoundsRect.Bottom := Pos.BoundsRect.Top + HighestHeightOnLine
            else
              Pos.BoundsRect.Right := Pos.BoundsRect.Left + HighestWidthOnLine;
          end
          else begin
            { Center the item }
            if AOrientation <> tbvoVertical then begin
              Z := (HighestHeightOnLine - (Pos.BoundsRect.Bottom - Pos.BoundsRect.Top)) div 2;
              Inc(Pos.BoundsRect.Top, Z);
              Inc(Pos.BoundsRect.Bottom, Z);
            end
            else begin
              Z := (HighestWidthOnLine - (Pos.BoundsRect.Right - Pos.BoundsRect.Left)) div 2;
              Inc(Pos.BoundsRect.Left, Z);
              Inc(Pos.BoundsRect.Right, Z);
            end;
          end;
        end
        else begin
          { Make items in a menu as wide as the widest item }
          if not IsButton then begin
            with Pos.BoundsRect do Right := Left + HighestWidthOnLine;
          end;
        end;
      end;
      if RightAlignStart >= 0 then begin
        Z := 0;
        for I := LineEnd downto RightAlignStart do begin
          Pos := @NewPositions[I];
          if not Pos.Show then
            Continue;
          if AOrientation <> tbvoVertical then
            Z := Min(AWrapOffset, TotalSize.X) - Pos.BoundsRect.Right
          else
            Z := Min(AWrapOffset, TotalSize.Y) - Pos.BoundsRect.Bottom;
          Break;
        end;
        if Z > 0 then begin
          for I := RightAlignStart to LineEnd do begin
            Pos := @NewPositions[I];
            if not Pos.Show then
              Continue;
            if AOrientation <> tbvoVertical then begin
              Inc(Pos.BoundsRect.Left, Z);
              Inc(Pos.BoundsRect.Right, Z);
            end
            else begin
              Inc(Pos.BoundsRect.Top, Z);
              Inc(Pos.BoundsRect.Bottom, Z);
            end;
          end;
        end;
      end;
    end;
    LineStart := -1;
    HighestHeightOnLine := 0;
    HighestWidthOnLine := 0;
  end;

  procedure PositionItem(const CurIndex: Integer; var Pos: TTempPosition);
  var
    O, X, Y: Integer;
    IsLineSep, Vert: Boolean;
  begin
    if LineStart = -1 then begin
      LineStart := CurIndex;
      HighestHeightOnLine := 0;
      HighestWidthOnLine := 0;
    end;
    IsLineSep := False;
    Vert := (AOrientation = tbvoVertical);
    if not Vert then
      O := CurX
    else
      O := CurY;
    if (AWrapOffset > 0) and (O > 0) then begin
      if not Vert then
        Inc(O, Pos.BoundsRect.Right)
      else
        Inc(O, Pos.BoundsRect.Bottom);
      if (tbisSeparator in FViewers[CurIndex].Item.ItemStyle) and
         ((GroupSplit and not(tbisNoLineBreak in FViewers[CurIndex].Item.ItemStyle))
          or (O + GetSizeOfGroup(CurIndex+1) > AWrapOffset)) then begin
        DidWrap := True;
        Inc(AWrappedLines);
        if not Vert then begin
          CurX := 0;
          Inc(CurY, HighestHeightOnLine);
        end
        else begin
          CurY := 0;
          Inc(CurX, HighestWidthOnLine);
        end;
        FinalizeLine(CurIndex-1, False);
        LineStart := CurIndex+1;
        if not Vert then begin
          Pos.BoundsRect.Right := 0;
          Pos.BoundsRect.Bottom := tbLineSpacing;
        end
        else begin
          Pos.BoundsRect.Right := tbLineSpacing;
          Pos.BoundsRect.Bottom := 0;
        end;
        Pos.LineSep := True;
        IsLineSep := True;
      end
      else if O > AWrapOffset then begin
        { proceed to next row }
        DidWrap := True;
        Inc(AWrappedLines);
        if not Vert then begin
          CurX := LeftX;
          Inc(CurY, HighestHeightOnLine);
        end
        else begin
          CurY := TopY;
          Inc(CurX, HighestWidthOnLine);
        end;
        GroupSplit := True;
        FinalizeLine(CurIndex-1, False);
        LineStart := CurIndex;
      end;
    end;
    if Pos.BoundsRect.Bottom > HighestHeightOnLine then
      HighestHeightOnLine := Pos.BoundsRect.Bottom;
    if Pos.BoundsRect.Right > HighestWidthOnLine then
      HighestWidthOnLine := Pos.BoundsRect.Right;
    X := CurX;
    Y := CurY;
    if X < 0 then X := 0;
    if Y < 0 then Y := 0;
    OffsetRect(Pos.BoundsRect, X, Y);
    if IsLineSep then begin
      if not Vert then begin
        CurX := LeftX;
        Inc(CurY, tbLineSpacing);
      end
      else begin
        CurY := TopY;
        Inc(CurX, tbLineSpacing);
      end;
      GroupSplit := False;
    end;
  end;

var
  SaveOrientation: TppTBViewOrientation;
  ChevronItem: TppTBCustomItem;
  CalcCanvas: TCanvas;
  LastWasSep, LastWasButton, IsButton, IsControl: Boolean;
  Item: TppTBCustomItem;
  Ctl: TControl;
  ChangedBold: Boolean;
  HighestSameWidthViewerWidth, Total, J, TotalVisibleItems: Integer;
  IsFirst: Boolean;
  Viewer: TppTBItemViewer;
  UseChevron, NonControlsOffEdge, TempViewerCreated: Boolean;
  Margins: TRect;
label 1;
begin
  SaveOrientation := FOrientation;
  AWrappedLines := 1;
  ChevronItem := GetChevronItem;
  NewPositions := nil;
  DC := 0;
  CalcCanvas := nil;
  try
    FOrientation := AOrientation;

    CalcCanvas := TCanvas.Create;
    DC := GetDC(0);
    CalcCanvas.Handle := DC;
    CalcCanvas.Font.Assign(GetFont);

    NewPositions := AllocMem(FViewerCount * SizeOf(TTempPosition));

    { Figure out which items should be shown }
    LastWasSep := True;  { set to True initially so it won't show leading seps }
    for I := 0 to FViewerCount-1 do begin
      Item := FViewers[I].Item;
      IsControl := Item is TppTBControlItem;
      with NewPositions[I] do begin
        { Show is initially False since AllocMem initializes to zero }
        if Item = ChevronItem then
          Continue;
        if Assigned(FChevronParentView) then begin
          if IsControl then
            Continue;
          FChevronParentView.ValidatePositions;
          J := I + FChevronParentView.FInternalViewersAtFront;
          if J < FChevronParentView.FViewerCount then
            { range check just in case }
            Viewer := FChevronParentView.FViewers[J]
          else
            Viewer := nil;
          if (Viewer = nil) or (not Viewer.OffEdge and not(tbisSeparator in Item.ItemStyle)) then
            Continue;
        end;
        if not IsControl then begin
          if not(tbisEmbeddedGroup in Item.ItemStyle) or FCustomizing then begin
            Show := Item.Visible;
            { Don't display two consecutive separators }
            if Show then begin
              if (tbisSeparator in Item.ItemStyle) and LastWasSep then
                Show := False;
              LastWasSep := tbisSeparator in Item.ItemStyle;
            end;
          end;
        end
        else begin
          { Controls can only be rendered on a single Parent, so only
            include the control if its parent is currently equal to
            FWindow }
          Ctl := TppTBControlItem(Item).FControl;
          if Assigned(Ctl) and Assigned(FWindow) and (Ctl.Parent = FWindow) and
             (Ctl.Visible or (csDesigning in Ctl.ComponentState)) then begin
            Show := True;
            LastWasSep := False;
          end;
        end;
      end;
    end;

    { Hide any trailing separators, so that they aren't included in the
      base size }
    for I := FViewerCount-1 downto 0 do begin
      with NewPositions[I] do
        if Show then begin
          if not(tbisSeparator in FViewers[I].Item.ItemStyle) then
            Break;
          Show := False;
        end;
    end;

    { Calculate sizes of all the items }
    HighestSameWidthViewerWidth := 0;
    for I := 0 to FViewerCount-1 do begin
      Item := FViewers[I].Item;
      IsControl := Item is TppTBControlItem;
      with NewPositions[I] do begin
        { BoundsRect is currently empty since AllocMem initializes to zero }
        if not Show then
          Continue;
        if not IsControl then begin
          ChangedBold := False;
          if tboDefault in Item.EffectiveOptions then
            with CalcCanvas.Font do
              if not(fsBold in Style) then begin
                ChangedBold := True;
                Style := Style + [fsBold];
              end;
          Viewer := FViewers[I];
          TempViewerCreated := False;
          if Item.NeedToRecreateViewer(Viewer) then begin
            if CanMoveControls then begin
              RecreateItemViewer(I);
              Viewer := FViewers[I];
            end
            else begin
              Viewer := Item.GetItemViewerClass(Self).Create(Self, Item, 0);
              TempViewerCreated := True;
            end;
          end;
          try
            Viewer.CalcSize(CalcCanvas, BoundsRect.Right, BoundsRect.Bottom);
            if Viewer.UsesSameWidth then begin
              SameWidth := True;
              if (BoundsRect.Right > HighestSameWidthViewerWidth) then
                HighestSameWidthViewerWidth := BoundsRect.Right;
            end;
          finally
            if TempViewerCreated then
              Viewer.Free;
          end;
          if ChangedBold then
            with CalcCanvas.Font do
              Style := Style - [fsBold];
        end
        else begin
          Ctl := TppTBControlItem(Item).FControl;
          BoundsRect.Right := Ctl.Width;
          BoundsRect.Bottom := Ctl.Height;
        end;
      end;
    end;

    { Increase widths of SameWidth items if necessary. Also calculate
      ABaseSize.X (or Y). }
    ABaseSize.X := 0;
    ABaseSize.Y := 0;
    for I := 0 to FViewerCount-1 do begin
      with NewPositions[I] do begin
        if SameWidth and (BoundsRect.Right < HighestSameWidthViewerWidth) then
          BoundsRect.Right := HighestSameWidthViewerWidth;
        if AOrientation <> tbvoVertical then
          Inc(ABaseSize.X, BoundsRect.Right)
        else
          Inc(ABaseSize.Y, BoundsRect.Bottom);
      end;
    end;

    { Hide partially visible items, mark them as 'OffEdge' }
    if AOrientation <> tbvoVertical then
      Total := ABaseSize.X
    else
      Total := ABaseSize.Y;
    NonControlsOffEdge := False;
    UseChevron := Assigned(ChevronItem) and (AChevronOffset > 0) and
      (Total > AChevronOffset);
    if UseChevron then begin
      Dec(AChevronOffset, AChevronSize);
      while Total > AChevronOffset do begin
        { Count number of items. Stop loop if <= 1 }
        TotalVisibleItems := 0;
        for I := FViewerCount-1 downto 0 do begin
          if NewPositions[I].Show and not(tbisSeparator in FViewers[I].Item.ItemStyle) then
            Inc(TotalVisibleItems);
        end;
        if TotalVisibleItems <= 1 then
          Break;
        { Hide any trailing separators }
        for I := FViewerCount-1 downto 0 do begin
          with NewPositions[I] do
            if Show then begin
              if not(tbisSeparator in FViewers[I].Item.ItemStyle) then
                Break;
              Show := False;
              if AOrientation <> tbvoVertical then
                Dec(Total, BoundsRect.Right)
              else
                Dec(Total, BoundsRect.Bottom);
              goto 1;
            end;
        end;
        { Find an item to hide }
        if Assigned(FPriorityList) then
          I := FPriorityList.Count-1
        else
          I := FViewerCount-1;
        while I >= 0 do begin
          if Assigned(FPriorityList) then begin
            Viewer := FPriorityList[I];
            J := Viewer.Index;
          end
          else begin
            Viewer := FViewers[I];
            J := I;
          end;
          if NewPositions[J].Show and not(tbisSeparator in Viewer.Item.ItemStyle) then begin
            NewPositions[J].Show := False;
            NewPositions[J].OffEdge := True;
            if AOrientation <> tbvoVertical then
              Dec(Total, NewPositions[J].BoundsRect.Right)
            else
              Dec(Total, NewPositions[J].BoundsRect.Bottom);
            if not NonControlsOffEdge and not(Viewer.Item is TppTBControlItem) then
              NonControlsOffEdge := True;
            goto 1;
          end;
          Dec(I);
        end;
        Break;  { prevent endless loop }
        1:
        { Don't show two consecutive separators }
        LastWasSep := True;  { set to True initially so it won't show leading seps }
        for J := 0 to FViewerCount-1 do begin
          Item := FViewers[J].Item;
          with NewPositions[J] do begin
            if Show then begin
              if (tbisSeparator in Item.ItemStyle) and LastWasSep then begin
                Show := False;
                if AOrientation <> tbvoVertical then
                  Dec(Total, BoundsRect.Right)
                else
                  Dec(Total, BoundsRect.Bottom);
              end;
              LastWasSep := tbisSeparator in Item.ItemStyle;
            end;
          end;
        end;
      end;
    end;

    { Hide any trailing separators after items were hidden }
    for I := FViewerCount-1 downto 0 do begin
      with NewPositions[I] do
        if Show then begin
          if not(tbisSeparator in FViewers[I].Item.ItemStyle) then
            Break;
          Show := False;
        end;
    end;

    { Set the ABaseSize.Y (or X) *after* items were hidden }
    for I := 0 to FViewerCount-1 do begin
      with NewPositions[I] do
        if Show then begin
          if AOrientation <> tbvoVertical then begin
            if BoundsRect.Bottom > ABaseSize.Y then
              ABaseSize.Y := BoundsRect.Bottom;
          end
          else begin
            if BoundsRect.Right > ABaseSize.X then
              ABaseSize.X := BoundsRect.Right;
          end;
        end;
    end;

    { On menus, set all non-separator items to be as tall as the tallest item }
    {if not FIsToolbar then begin
      J := 0;
      for I := 0 to FViewerCount-1 do begin
        Item := FViewers[I].Item;
        with NewPositions[I] do
          if Show and not(tbisSeparator in Item.ItemStyle) and
             not(tboToolbarSize in Item.FEffectiveOptions) and
             (BoundsRect.Bottom - BoundsRect.Top > J) then
            J := BoundsRect.Bottom - BoundsRect.Top;
      end;
      for I := 0 to FViewerCount-1 do begin
        Item := FViewers[I].Item;
        with NewPositions[I] do
          if Show and not(tbisSeparator in Item.ItemStyle) and
             not(tboToolbarSize in Item.FEffectiveOptions) then
            BoundsRect.Bottom := BoundsRect.Top + J;
      end;
    end;}

    { Calculate the position of the items }
    GetMargins(AOrientation, Margins);
    LeftX := Margins.Left;
    TopY := Margins.Top;
    if AWrapOffset > 0 then begin
      Dec(AWrapOffset, Margins.Right);
      if AWrapOffset < 1 then AWrapOffset := 1;
    end;
    CurX := LeftX;
    CurY := TopY;
    GroupSplit := False;
    DidWrap := False;
    LastWasButton := FIsToolbar;
    LineStart := -1;
    for I := 0 to FViewerCount-1 do begin
      Item := FViewers[I].Item;
      with NewPositions[I] do begin
        if not Show then
          Continue;
        IsButton := FIsToolbar or (tboToolbarSize in Item.FEffectiveOptions);
        if LastWasButton and not IsButton then begin
          { On a menu, if last item was a button and the current item isn't,
            proceed to next row }
          CurX := LeftX;
          CurY := TotalSize.Y;
        end;
        LastWasButton := IsButton;
        PositionItem(I, NewPositions[I]);
        if IsButton and (AOrientation <> tbvoVertical) then
          Inc(CurX, BoundsRect.Right - BoundsRect.Left)
        else
          Inc(CurY, BoundsRect.Bottom - BoundsRect.Top);
        if BoundsRect.Right > TotalSize.X then
          TotalSize.X := BoundsRect.Right;
        if BoundsRect.Bottom > TotalSize.Y then
          TotalSize.Y := BoundsRect.Bottom;
      end;
    end;
    if FViewerCount <> 0 then
      FinalizeLine(FViewerCount-1, True);
    Inc(TotalSize.X, Margins.Right);
    Inc(TotalSize.Y, Margins.Bottom);
    if AOrientation = tbvoVertical then
      Mirror;
    HandleMaxHeight;
    if CanMoveControls then begin
      for I := 0 to FViewerCount-1 do begin
        Item := FViewers[I].Item;
        if Item is TppTBControlItem then begin
          if NewPositions[I].Show then begin
            Ctl := TppTBControlItem(Item).FControl;
            if not EqualRect(NewPositions[I].BoundsRect, Ctl.BoundsRect) then
              Ctl.BoundsRect := NewPositions[I].BoundsRect;
          end
          else if NewPositions[I].OffEdge or NewPositions[I].Clipped then begin
            { Simulate hiding of OddEdge controls by literally moving them
              off the edge. Do the same for Clipped controls. }
            Ctl := TppTBControlItem(Item).FControl;
            Ctl.SetBounds(FWindow.ClientWidth, FWindow.ClientHeight,
              Ctl.Width, Ctl.Height);
          end;
        end;
      end;
    end;
    { Set size of line separators }
    if FIsToolbar then
      for I := 0 to FViewerCount-1 do begin
        Item := FViewers[I].Item;
        with NewPositions[I] do
          if Show and (tbisSeparator in Item.ItemStyle) and
             LineSep then begin
            if AOrientation <> tbvoVertical then
              BoundsRect.Right := TotalSize.X
            else
              BoundsRect.Bottom := TotalSize.Y;
          end;
      end;

    { Position the chevron item }
    if UseChevron then begin
      if CanMoveControls then
        ChevronItem.Enabled := NonControlsOffEdge;
      NewPositions[FViewerCount-1].Show := True;
      I := AChevronOffset;
      if AOrientation <> tbvoVertical then begin
        if I < TotalSize.X then
          I := TotalSize.X;
        NewPositions[FViewerCount-1].BoundsRect := Bounds(I, 0,
          AChevronSize, TotalSize.Y);
      end
      else begin
        if I < TotalSize.Y then
          I := TotalSize.Y;
        NewPositions[FViewerCount-1].BoundsRect := Bounds(0, I,
          TotalSize.X, AChevronSize);
      end;
    end;

    { Commit changes }
    Result := False;
    if CanMoveControls then begin
      for I := 0 to FViewerCount-1 do begin
        if not Result and
           (not EqualRect(FViewers[I].BoundsRect, NewPositions[I].BoundsRect) or
            (FViewers[I].Show <> NewPositions[I].Show) or
            (tbisLineSep in FViewers[I].State <> NewPositions[I].LineSep)) then
          Result := True;
        FViewers[I].FBoundsRect := NewPositions[I].BoundsRect;
        FViewers[I].FShow := NewPositions[I].Show;
        FViewers[I].FOffEdge := NewPositions[I].OffEdge;
        FViewers[I].FClipped := NewPositions[I].Clipped;
        if NewPositions[I].LineSep then
          Include(FViewers[I].State, tbisLineSep)
        else
          Exclude(FViewers[I].State, tbisLineSep);
      end;
    end;
  finally
    FOrientation := SaveOrientation;
    if Assigned(CalcCanvas) then
      CalcCanvas.Handle := 0;
    if DC <> 0 then ReleaseDC(0, DC);
    CalcCanvas.Free;
    FreeMem(NewPositions);
  end;
  if (ABaseSize.X = 0) or (ABaseSize.Y = 0) then begin
    { If there are no visible items... }
    {}{scale this?}
    ABaseSize.X := 23;
    ABaseSize.Y := 22;
    if TotalSize.X < 23 then TotalSize.X := 23;
    if TotalSize.Y < 22 then TotalSize.Y := 22;
  end;
end;

procedure TppTBView.DoUpdatePositions(var ASize: TPoint);
{ This is called by UpdatePositions }
var
  Bmp: TBitmap;
  CtlCanvas: TControlCanvas;
  WrappedLines: Integer;
begin
  { Don't call InvalidatePositions before CalculatePositions so that
    endless recursion doesn't happen if an item's CalcSize uses a method that
    calls ValidatePositions }
  if not CalculatePositions(True, FOrientation, FWrapOffset, FChevronOffset,
     FChevronSize, FBaseSize, ASize, WrappedLines) then begin
    { If the new positions are identical to the previous ones, continue using
      the previous ones, and don't redraw }
    FValidated := True;
    { Just because the positions are the same doesn't mean the size hasn't
      changed. (If a shrunken toolbar moves between docks, the positions of
      the non-OffEdge items may be the same on the new dock as on the old
      dock.) }
    AutoSize(ASize.X, ASize.Y);
  end
  else begin
    if not(csDesigning in ComponentState) then begin
      FValidated := True;
      { Need to call ValidateRect before AutoSize, otherwise Windows will
        erase the client area during a resize }
      if FWindow.HandleAllocated then
        ValidateRect(FWindow.Handle, nil);
      AutoSize(ASize.X, ASize.Y);
      if Assigned(FWindow) and FWindow.HandleAllocated and
         IsWindowVisible(FWindow.Handle) and
         (FWindow.ClientWidth > 0) and (FWindow.ClientHeight > 0) then begin
        CtlCanvas := nil;
        Bmp := TBitmap.Create;
        try
          CtlCanvas := TControlCanvas.Create;
          CtlCanvas.Control := FWindow;
          Bmp.Width := FWindow.ClientWidth;
          Bmp.Height := FWindow.ClientHeight;

          SendMessage(FWindow.Handle, WM_ERASEBKGND, WPARAM(Bmp.Canvas.Handle), 0);
          SendMessage(FWindow.Handle, WM_PAINT, WPARAM(Bmp.Canvas.Handle), 0);
          BitBlt(CtlCanvas.Handle, 0, 0, Bmp.Width, Bmp.Height,
            Bmp.Canvas.Handle, 0, 0, SRCCOPY);
          ValidateRect(FWindow.Handle, nil);
        finally
          CtlCanvas.Free;
          Bmp.Free;
        end;
      end;
    end
    else begin
      { Delphi's handling of canvases is different at design time -- child
        controls aren't clipped from a parent control's canvas, so the above
        offscreen rendering code doesn't work right at design-time }
      InvalidatePositions;
      FValidated := True;
      AutoSize(ASize.X, ASize.Y);
    end;
  end;
end;

function TppTBView.UpdatePositions: TPoint;
{ Called whenever the size or orientation of a view changes. When items are
  added or removed from the view, InvalidatePositions must be called instead,
  otherwise the view may not be redrawn properly. }
begin
  Result.X := 0;
  Result.Y := 0;
  DoUpdatePositions(Result);
end;

procedure TppTBView.AutoSize(AWidth, AHeight: Integer);
begin
end;

function TppTBView.GetChevronItem: TppTBCustomItem;
begin
  Result := nil;
end;

procedure TppTBView.GetMargins(AOrientation: TppTBViewOrientation;
  var Margins: TRect);
begin
  if AOrientation = tbvoFloating then begin
    Margins.Left := 4;
    Margins.Top := 2;
    Margins.Right := 4;
    Margins.Bottom := 1;
  end
  else begin
    Margins.Left := 0;
    Margins.Top := 0;
    Margins.Right := 0;
    Margins.Bottom := 0;
  end;
end;

function TppTBView.GetMDIButtonsItem: TppTBCustomItem;
begin
  Result := nil;
end;

function TppTBView.GetMDISystemMenuItem: TppTBCustomItem;
begin
  Result := nil;
end;

function TppTBView.GetFont: TFont;
begin
  Result := ToolbarFont;
end;

procedure TppTBView.DrawItem(Viewer: TppTBItemViewer; DrawTo: TCanvas;
  Offscreen: Boolean);
const
  COLOR_MENUHILIGHT = 29;
  clMenuHighlight = TColor(COLOR_MENUHILIGHT or $80000000);
var
  Bmp: TBitmap;
  DrawToDC, BmpDC: HDC;
  DrawCanvas: TCanvas;
  R1, R2, R3: TRect;
  IsOpen, IsSelected, IsPushed: Boolean;
  ToolbarStyle: Boolean;
  UseDisabledShadow: Boolean;
  SaveIndex, SaveIndex2: Integer;
  BkColor: TColor;
begin
  ValidatePositions;

  if tbisInvalidated in Viewer.State then begin
    Offscreen := True;
    Exclude(Viewer.State, tbisInvalidated);
  end;

  R1 := Viewer.BoundsRect;
  if not Viewer.Show or IsRectEmpty(R1) or (Viewer.Item is TppTBControlItem) then
    Exit;
  R2 := R1;
  OffsetRect(R2, -R2.Left, -R2.Top);

  IsOpen := FOpenViewer = Viewer;
  IsSelected := (FSelected = Viewer);
  IsPushed := IsSelected and (IsOpen or (FMouseOverSelected and FCapture));
  ToolbarStyle := Viewer.IsToolbarStyle;

  DrawToDC := DrawTo.Handle;
  Bmp := nil;
  { Must deselect any currently selected handles before calling SaveDC, because
    if they are left selected and DeleteObject gets called on them after the
    SaveDC call, it will fail on Win9x/Me, and thus leak GDI resources. }
  DrawTo.Refresh;
  SaveIndex := SaveDC(DrawToDC);
  try
    IntersectClipRect(DrawToDC, R1.Left, R1.Top, R1.Right, R1.Bottom);
    GetClipBox(DrawToDC, R3);
    if IsRectEmpty(R3) then
      Exit;

    if not Offscreen then begin
      MoveWindowOrg(DrawToDC, R1.Left, R1.Top);
      { Tweak the brush origin so that the checked background drawn behind
        checked items always looks the same regardless of whether the item
        is positioned on an even or odd Left or Top coordinate. }
      SetBrushOrgEx(DrawToDC, R1.Left and 1, R1.Top and 1, nil);
      DrawCanvas := DrawTo;
    end
    else begin
      Bmp := TBitmap.Create;
      Bmp.Width := R2.Right;
      Bmp.Height := R2.Bottom;
      DrawCanvas := Bmp.Canvas;
      BmpDC := DrawCanvas.Handle;
      SaveIndex2 := SaveDC(BmpDC);
      SetWindowOrgEx(BmpDC, R1.Left, R1.Top, nil);
      FWindow.Perform(WM_ERASEBKGND, WPARAM(BmpDC), 0);
      RestoreDC(BmpDC, SaveIndex2);
    end;

    { Initialize brush }
    if not ToolbarStyle and IsSelected then begin
      {$IFNDEF TB2K_USE_STRICT_O2K_MENU_STYLE}
      if AreFlatMenusEnabled then
        { Windows XP uses a different fill color for selected menu items when
          flat menus are enabled }
        DrawCanvas.Brush.Color := clMenuHighlight
      else
      {$ENDIF}
        DrawCanvas.Brush.Color := clHighlight;
    end
    else
      DrawCanvas.Brush.Style := bsClear;

    { Initialize font }
    DrawCanvas.Font.Assign(GetFont);
    if Viewer.Item.Enabled then begin
      if not ToolbarStyle and IsSelected then
        DrawCanvas.Font.Color := clHighlightText
      else begin
        if ToolbarStyle then
          DrawCanvas.Font.Color := clBtnText
        else
          DrawCanvas.Font.Color := tbMenuTextColor;
      end;
      UseDisabledShadow := False;
    end
    else begin
      DrawCanvas.Font.Color := clGrayText;
      { Use the disabled shadow if either:
        1. The item is a toolbar-style item.
        2. The item is not selected, and the background color equals the
           button-face color.
        3. The gray-text color is the same as the background color.
           Note: Windows actually uses dithered text in this case. }
      BkColor := ColorToRGB(TControlAccess(FWindow).Color);
      UseDisabledShadow := ToolbarStyle or
        (not IsSelected and (BkColor = ColorToRGB(clBtnFace))) or
        (ColorToRGB(clGrayText) = BkColor);
    end;

    Viewer.Paint(DrawCanvas, R2, IsSelected, IsPushed, UseDisabledShadow);

    if Offscreen then
      BitBlt(DrawToDC, R1.Left, R1.Top, Bmp.Width, Bmp.Height, DrawCanvas.Handle,
        0, 0, SRCCOPY);
  finally
    DrawTo.Refresh;  { must do this before a RestoreDC }
    RestoreDC(DrawToDC, SaveIndex);
    Bmp.Free;
  end;
end;

procedure TppTBView.DrawSubitems(ACanvas: TCanvas);
var
  I: Integer;
begin
  for I := 0 to FViewerCount-1 do begin
    if (vsDrawInOrder in FState) or (FViewers[I] <> FSelected) then
      DrawItem(FViewers[I], ACanvas, False);
  end;
  if not(vsDrawInOrder in FState) and Assigned(FSelected) then
    DrawItem(FSelected, ACanvas, False);

  Exclude(FState, vsDrawInOrder);
end;

procedure TppTBView.Invalidate(AViewer: TppTBItemViewer);
begin
  if not FValidated or not Assigned(FWindow) or not FWindow.HandleAllocated then
    Exit;
  if AViewer.Show and not IsRectEmpty(AViewer.BoundsRect) and
     not(AViewer.Item is TppTBControlItem) then begin
    Include(AViewer.State, tbisInvalidated);
    InvalidateRect(FWindow.Handle, @AViewer.BoundsRect, False);
  end;
end;

procedure TppTBView.SetAccelsVisibility(AShowAccels: Boolean);
var
  I: Integer;
  Viewer: TppTBItemViewer;
begin
  { Always show accels when keyboard cues are enabled }
  AShowAccels := AShowAccels or not(vsUseHiddenAccels in FStyle) or
    AreKeyboardCuesEnabled;
  if AShowAccels <> (vsShowAccels in FState) then begin
    if AShowAccels then
      Include(FState, vsShowAccels)
    else
      Exclude(FState, vsShowAccels);
    if Assigned(FWindow) and FWindow.HandleAllocated and
       IsWindowVisible(FWindow.Handle) then
      { ^ the visibility check is just an optimization }
      for I := 0 to FViewerCount-1 do begin
        Viewer := FViewers[I];
        if Viewer.CaptionShown and
           (FindAccelChar(Viewer.GetCaptionText) <> #0) then
          Invalidate(Viewer);
      end;
  end;
end;

function TppTBView.FirstSelectable: TppTBItemViewer;
var
  FirstViewer: TppTBItemViewer;
begin
  Result := NextSelectable(nil, True);
  if Assigned(Result) then begin
    FirstViewer := Result;
    while tbisDontSelectFirst in Result.Item.ItemStyle do begin
      Result := NextSelectable(Result, True);
      if Result = FirstViewer then
        { don't loop endlessly if all items have the tbisDontSelectFirst style }
        Break;
    end;
  end;
end;

function TppTBView.NextSelectable(CurViewer: TppTBItemViewer;
  GoForward: Boolean): TppTBItemViewer;
var
  I, J: Integer;
begin
  ValidatePositions;
  Result := nil;
  if FViewerCount = 0 then Exit;
  J := -1;
  I := IndexOf(CurViewer);
  while True do begin
    if GoForward then begin
      Inc(I);
      if I >= FViewerCount then I := 0;
    end
    else begin
      Dec(I);
      if I < 0 then I := FViewerCount-1;
    end;
    if J = -1 then
      J := I
    else
      if I = J then
        Exit;
    if (FViewers[I].Show or FViewers[I].Clipped) and FViewers[I].Item.Visible and
       (tbisSelectable in FViewers[I].Item.ItemStyle) then
      Break;
  end;
  Result := FViewers[I];
end;

function TppTBView.NextSelectableWithAccel(CurViewer: TppTBItemViewer;
  Key: Char; RequirePrimaryAccel: Boolean; var IsOnlyItemWithAccel: Boolean): TppTBItemViewer;

  function IsAccelItem(const Index: Integer;
    const Primary, EnabledItems: Boolean): Boolean;
  var
    S: String;
    LastAccel: Char;
    Viewer: TppTBItemViewer;
    Item: TppTBCustomItem;
  begin
    Result := False;
    Viewer := FViewers[Index];
    Item := Viewer.Item;
    if (Viewer.Show or Viewer.Clipped) and (tbisSelectable in Item.ItemStyle) and
       (Item.Enabled = EnabledItems) and
       Item.Visible and Viewer.CaptionShown then begin
      S := Viewer.GetCaptionText;
      if S <> '' then begin
        LastAccel := FindAccelChar(S);
        if Primary then begin
          if LastAccel <> #0 then
            Result := AnsiCompareText(LastAccel, Key) = 0;
        end
        else
          if (LastAccel = #0) and (Key <> ' ') then
            Result := AnsiCompareText(S[1], Key) = 0;
      end;
    end;
  end;

  function FindAccel(I: Integer;
    const Primary, EnabledItems: Boolean): Integer;
  var
    J: Integer;
  begin
    Result := -1;
    J := -1;
    while True do begin
      Inc(I);
      if I >= FViewerCount then I := 0;
      if J = -1 then
        J := I
      else
        if I = J then
          Break;
      if IsAccelItem(I, Primary, EnabledItems) then begin
        Result := I;
        Break;
      end;
    end;
  end;

var
  Start, I: Integer;
  Primary, EnabledItems: Boolean;
begin
  ValidatePositions;
  Result := nil;
  IsOnlyItemWithAccel := False;
  if FViewerCount = 0 then Exit;

  Start := IndexOf(CurViewer);
  for Primary := True downto False do
    if not RequirePrimaryAccel or Primary then
      for EnabledItems := True downto False do begin
        I := FindAccel(Start, Primary, EnabledItems);
        if I <> -1 then begin
          Result := FViewers[I];
          IsOnlyItemWithAccel := not EnabledItems or
            (FindAccel(I, Primary, EnabledItems) = I);
          Exit;
        end;
      end;
end;

procedure TppTBView.EnterToolbarLoop(Options: TppTBEnterToolbarLoopOptions);
var
  ModalHandler: TppTBModalHandler;
  P: TPoint;
begin
  if vsModal in FState then Exit;
  ModalHandler := TppTBModalHandler.Create(FWindow.Handle);
  try
    { remove all states except... }
    FState := FState * [vsShowAccels];
    try
      Include(FState, vsModal);
      { Now that the vsModal state has been added, send an MSAA focus event }
      if Assigned(Selected) then
        NotifyFocusEvent;
      ModalHandler.Loop(Self, tbetMouseDown in Options,
        tbetExecuteSelected in Options, tbetFromMSAA in Options, False);
    finally
      { Remove vsModal state from the root view before any TppTBView.Destroy
        methods get called (as a result of the CloseChildPopups call below),
        so that NotifyFocusEvent becomes a no-op }
      Exclude(FState, vsModal);
      StopAllTimers;
      CloseChildPopups;
      GetCursorPos(P);
      UpdateSelection(@P, True);
    end;
  finally
    ModalHandler.Free;
  end;
  SetAccelsVisibility(False);
  Selected := nil;
  // caused flicker: FWindow.Update;
  ProcessDoneAction(FDoneActionData);
end;

procedure TppTBView.SetCustomizing(Value: Boolean);
begin
  if FCustomizing <> Value then begin
    FCustomizing := Value;
    RecreateAllViewers;
  end;
end;

procedure TppTBView.BeginUpdate;
begin
  Inc(FUpdating);
end;

procedure TppTBView.EndUpdate;
begin
  Dec(FUpdating);
  if FUpdating = 0 then
    TryValidatePositions;
end;

procedure TppTBView.GetOffEdgeControlList(const List: TList);
var
  I: Integer;
  Item: TppTBCustomItem;
begin
  for I := 0 to FViewerCount-1 do begin
    Item := FViewers[I].Item;
    if (Item is TppTBControlItem) and FViewers[I].OffEdge and
       (TppTBControlItem(Item).FControl is TWinControl) then
      List.Add(TppTBControlItem(Item).FControl);
  end;
end;

procedure TppTBView.SetCapture;
begin
  FCapture := True;
end;

procedure TppTBView.CancelCapture;
begin
  if FCapture then begin
    FCapture := False;
    LastPos.X := Low(LastPos.X);
    if Assigned(FSelected) then
      FSelected.LosingCapture;
  end;
end;

procedure TppTBView.KeyDown(var Key: Word; Shift: TShiftState);

  procedure SelNextItem(const ParentView: TppTBView; const GoForward: Boolean);
  begin
    ParentView.Selected := ParentView.NextSelectable(ParentView.FSelected,
      GoForward);
    ParentView.ScrollSelectedIntoView;
  end;

  procedure HelpKey;
  var
    V: TppTBView;
    ContextID: Integer;
  begin
    ContextID := 0;
    V := Self;
    while Assigned(V) do begin
      if Assigned(V.FSelected) then begin
        ContextID := V.FSelected.Item.HelpContext;
        if ContextID <> 0 then Break;
      end;
      V := V.FParentView;
    end;
    if ContextID <> 0 then
      EndModalWithHelp(ContextID);
  end;

var
  ParentTBView: TppTBView;
begin
  ParentTBView := GetParentToolbarView;
  case Key of
    VK_TAB: begin
        SelNextItem(Self, GetKeyState(VK_SHIFT) >= 0);
      end;
    VK_RETURN: begin
        ExecuteSelected(True);
      end;
    VK_MENU, VK_F10: begin
        EndModal;
      end;
    VK_ESCAPE: begin
        Key := 0;
        if FParentView = nil then
          EndModal
        else
          FParentView.CancelChildPopups;
      end;
    VK_LEFT, VK_RIGHT: begin
        if (Self = ParentTBView) and (Orientation = tbvoVertical) then
          OpenChildPopup(True)
        else if Key = VK_LEFT then begin
          if Assigned(ParentTBView) and (ParentTBView.Orientation <> tbvoVertical) then begin
            if (Self = ParentTBView) or
               (FParentView = ParentTBView) then
              SelNextItem(ParentTBView, False)
            else
              FParentView.CloseChildPopups;
          end
          else begin
            if Assigned(FParentView) then
              FParentView.CancelChildPopups;
          end;
        end
        else begin
          if ((Self = ParentTBView) or not OpenChildPopup(True)) and
             (Assigned(ParentTBView) and (ParentTBView.Orientation <> tbvoVertical)) then begin
            { If we're on ParentTBView, or if the selected item can't display
              a submenu, proceed to next item on ParentTBView }
            SelNextItem(ParentTBView, True);
          end;
        end;
      end;
    VK_UP, VK_DOWN: begin
        if (Self = ParentTBView) and (Orientation <> tbvoVertical) then
          OpenChildPopup(True)
        else
          SelNextItem(Self, Key = VK_DOWN);
      end;
    VK_HOME, VK_END: begin
        Selected := NextSelectable(nil, Key = VK_HOME);
        ScrollSelectedIntoView;
      end;
    VK_F1: HelpKey;
  else
    Exit;  { don't set Key to 0 for unprocessed keys }
  end;
  Key := 0;
end;

procedure TppTBView.EndModal;
var
  RootView: TppTBView;
begin
  RootView := GetRootView;
  RootView.FDoneActionData.DoneAction := tbdaCancel;
end;

procedure TppTBView.EndModalWithClick(AViewer: TppTBItemViewer);
var
  RootView: TppTBView;
begin
  RootView := GetRootView;
  RootView.FDoneActionData.ClickItem := AViewer.Item;
  RootView.FDoneActionData.Sound := AViewer.FView.FIsPopup;
  RootView.FDoneActionData.DoneAction := tbdaClickItem;
end;

procedure TppTBView.EndModalWithHelp(AContextID: Integer);
var
  RootView: TppTBView;
begin
  RootView := GetRootView;
  RootView.FDoneActionData.ContextID := AContextID;
  RootView.FDoneActionData.DoneAction := tbdaHelpContext;
end;

procedure TppTBView.EndModalWithSystemMenu(AWnd: HWND; AKey: Cardinal);
var
  RootView: TppTBView;
begin
  RootView := GetRootView;
  RootView.FDoneActionData.Wnd := AWnd;
  RootView.FDoneActionData.Key := AKey;
  RootView.FDoneActionData.DoneAction := tbdaOpenSystemMenu;
end;

procedure TppTBView.ExecuteSelected(AGivePriority: Boolean);
{ Normally called after an Enter or accelerator key press on the view, this
  method 'executes' or opens the selected item. It ends the modal loop, except
  when a submenu is opened. }
var
  Item: TppTBCustomItem;
begin
  if Assigned(FSelected) and FSelected.Item.Enabled then begin
    Item := FSelected.Item;
    if (tbisCombo in Item.ItemStyle) or not OpenChildPopup(True) then begin
      if tbisSelectable in Item.ItemStyle then
        FSelected.Execute(AGivePriority)
      else
        EndModal;
    end
  end
  else
    EndModal;
  Exit; asm db 0,'Toolbar2000 (C) 1998-2003 Jordan Russell',0 end;
end;

procedure TppTBView.Scroll(ADown: Boolean);
var
  CurPos, NewPos, I: Integer;
begin
  ValidatePositions;
  if ADown then begin
    NewPos := High(NewPos);
    CurPos := FMaxHeight - tbMenuScrollArrowHeight;
    for I := 0 to FViewerCount-1 do begin
      with FViewers[I] do
        if Clipped and not(tbisSeparator in Item.ItemStyle) and
          (BoundsRect.Bottom < NewPos) and (BoundsRect.Bottom > CurPos) then
          NewPos := BoundsRect.Bottom;
    end;
    if NewPos = High(NewPos) then
      Exit;
    Dec(NewPos, FMaxHeight - tbMenuScrollArrowHeight);
  end
  else begin
    NewPos := Low(NewPos);
    CurPos := tbMenuScrollArrowHeight;
    for I := 0 to FViewerCount-1 do begin
      with FViewers[I] do
        if Clipped and not(tbisSeparator in Item.ItemStyle) and
          (BoundsRect.Top > NewPos) and (BoundsRect.Top < CurPos) then
          NewPos := BoundsRect.Top;
    end;
    if NewPos = Low(NewPos) then
      Exit;
    Dec(NewPos, tbMenuScrollArrowHeight);
  end;
  Inc(FScrollOffset, NewPos);
  UpdatePositions;
end;

procedure TppTBView.ScrollSelectedIntoView;
begin
  ValidatePositions;
  if (FSelected = nil) or not FSelected.Clipped then
    Exit;

  if FSelected.BoundsRect.Top < tbMenuScrollArrowHeight then begin
    Dec(FScrollOffset, tbMenuScrollArrowHeight - FSelected.BoundsRect.Top);
    UpdatePositions;
  end
  else if FSelected.BoundsRect.Bottom > FMaxHeight - tbMenuScrollArrowHeight then begin
    Dec(FScrollOffset, (FMaxHeight - tbMenuScrollArrowHeight) -
      FSelected.BoundsRect.Bottom);
    UpdatePositions;
  end;
end;

procedure TppTBView.SetUsePriorityList(Value: Boolean);
begin
  if FUsePriorityList <> Value then begin
    FUsePriorityList := Value;
    RecreateAllViewers;
  end;
end;

function TppTBView.GetCaptureWnd: HWND;
begin
  Result := GetRootView.FCaptureWnd;
end;

procedure TppTBView.SetState(AState: TppTBViewState);
begin
  FState := AState;
end;


{ TppTBModalHandler }

const
  LSFW_LOCK = 1;
  LSFW_UNLOCK = 2;

var
  LockSetForegroundWindowInited: BOOL;
  LockSetForegroundWindow: function(uLockCode: UINT): BOOL; stdcall;

constructor TppTBModalHandler.Create(AExistingWnd: HWND);
begin
  inherited Create;
  if not LockSetForegroundWindowInited then begin
    LockSetForegroundWindow := GetProcAddress(GetModuleHandle(user32),
      'LockSetForegroundWindow');
    LockSetForegroundWindowInited := True;
  end;
  LastPos := SmallPointToPoint(TSmallPoint(GetMessagePos()));
  if AExistingWnd <> 0 then
    FWnd := AExistingWnd
  else begin
    FWnd := {$IFDEF JR_D6}Classes.{$ENDIF} AllocateHWnd(nil);
    FCreatedWnd := True;
  end;
  if Assigned(LockSetForegroundWindow) then begin
    { Like standard menus, don't allow other apps to steal the focus during
      our modal loop. This also prevents us from losing activation when
      "active window tracking" is enabled and the user moves the mouse over
      another application's window. }
    LockSetForegroundWindow(LSFW_LOCK);
  end;
  SetCapture(FWnd);
  SetCursor(LoadCursor(0, IDC_ARROW));
  CallNotifyWinEvent(EVENT_SYSTEM_MENUSTART, FWnd, OBJID_CLIENT, CHILDID_SELF);
  FInited := True;
end;

destructor TppTBModalHandler.Destroy;
begin
  if Assigned(LockSetForegroundWindow) then
    LockSetForegroundWindow(LSFW_UNLOCK);
  if FWnd <> 0 then begin
    if GetCapture = FWnd then
      ReleaseCapture;
    if FInited then
      CallNotifyWinEvent(EVENT_SYSTEM_MENUEND, FWnd, OBJID_CLIENT, CHILDID_SELF);
    if FCreatedWnd then
      {$IFDEF JR_D6}Classes.{$ENDIF} DeallocateHWnd(FWnd);
  end;
  inherited;
end;

procedure TppTBModalHandler.Loop(const RootView: TppTBView;
  const AMouseDown, AExecuteSelected, AFromMSAA, TrackRightButton: Boolean);

  function GetActiveView: TppTBView;
  begin
    Result := RootView;
    while Assigned(Result.FOpenViewerView) do
      Result := Result.FOpenViewerView;
  end;

  procedure UpdateAllSelections(const P: TPoint; const AllowNewSelection: Boolean);
  var
    View, CapView: TppTBView;
  begin
    View := GetActiveView;

    CapView := View;
    while Assigned(CapView) and not CapView.FCapture do
      CapView := CapView.FParentView;

    while Assigned(View) do begin
      if (CapView = nil) or (View = CapView) then
        View.UpdateSelection(@P, AllowNewSelection);
      View := View.FParentView;
    end;
  end;

  function GetSelectedViewer(var AView: TppTBView; var AViewer: TppTBItemViewer): Boolean;
  { Returns True if AViewer <> nil. }
  var
    View: TppTBView;
  begin
    AView := nil;
    AViewer := nil;
    { Look for a capture item first }
    View := RootView;
    repeat
      if View.FCapture then begin
        AView := View;
        AViewer := View.FSelected;
        Break;
      end;
      View := View.FOpenViewerView;
    until View = nil;
    if View = nil then begin
      View := RootView;
      repeat
        if Assigned(View.FSelected) and View.FMouseOverSelected then begin
          AView := View;
          AViewer := View.FSelected;
          Break;
        end;
        if vsMouseInWindow in View.FState then begin
          { ...there is no current selection, but the mouse is still in the
            window. This can happen if the mouse is over the non-client area
            of the toolbar or popup window, or in an area not containing an
            item. }
          AView := View;
          Break;
        end;
        View := View.FOpenViewerView;
      until View = nil;
    end;
    Result := Assigned(AViewer);
  end;

  function ContinueLoop: Boolean;
  begin
    Result := GetCapture = FWnd;
  end;

  function SendKeyEvent(const View: TppTBView; var Key: Word;
    const Shift: TShiftState): Boolean;
  begin
    Result := True;
    if Assigned(View.FSelected) then begin
      View.FSelected.KeyDown(Key, Shift);
      if RootView.FDoneActionData.DoneAction <> tbdaNone then
        Exit;
    end;
    if Key <> 0 then begin
      View.KeyDown(Key, Shift);
      if RootView.FDoneActionData.DoneAction <> tbdaNone then
        Exit;
    end;
    Result := False;
  end;

  procedure DoHintMouseMessage(const Ctl: TControl; const P: TPoint);
  var
    M: TWMMouseMove;
  begin
    M.Msg := WM_MOUSEMOVE;
    M.Keys := 0;
    M.Pos := PointToSmallPoint(P);
    Application.HintMouseMessage(Ctl, TMessage(M));
  end;

  procedure MouseMoved;
  var
    View: TppTBView;
    Cursor: HCURSOR;
    Item: TppTBCustomItem;
    P: TPoint;
    R: TRect;
  begin
    UpdateAllSelections(LastPos, True);
    View := GetActiveView;
    Cursor := 0;
    if Assigned(View.FSelected) and Assigned(View.FWindow) then begin
      Item := View.FSelected.Item;
      P := View.FWindow.ScreenToClient(LastPos);
      if ((vsAlwaysShowHints in View.FStyle) or
          (tboShowHint in Item.FEffectiveOptions)) and not View.FCapture then begin
        { Display popup hint for the item. Update is called
          first to minimize flicker caused by the hiding &
          showing of the hint window. }
        View.FWindow.Update;
        DoHintMouseMessage(View.FWindow, P);
      end
      else
        Application.CancelHint;
      R := View.FSelected.BoundsRect;
      Dec(P.X, R.Left);
      Dec(P.Y, R.Top);
      View.FSelected.GetCursor(P, Cursor);
    end
    else
      Application.CancelHint;
    if Cursor = 0 then
      Cursor := LoadCursor(0, IDC_ARROW);
    SetCursor(Cursor);
  end;

  procedure UpdateAppHint;
  var
    View: TppTBView;
  begin
    View := RootView;
    while Assigned(View.FOpenViewerView) and Assigned(View.FOpenViewerView.FSelected) do
      View := View.FOpenViewerView;
    if Assigned(View.FSelected) then
      Application.Hint := GetLongHint(View.FSelected.Item.Hint)
    else
      Application.Hint := '';
  end;

  procedure HandleTimer(const View: TppTBView; const ID: TppTBViewTimerID);
  begin
    case ID of
      tiOpen: begin
          { Similar to standard menus, always close child popups, even if
            Selected = OpenViewer.
            Note: CloseChildPopups and OpenChildPopup will stop the tiClose
            and tiOpen timers respectively. }
          View.CloseChildPopups;
          View.OpenChildPopup(False);
        end;
      tiClose: begin
          { Note: CloseChildPopups stops the tiClose timer. }
          View.CloseChildPopups;
        end;
      tiScrollUp: begin
          if View.FShowUpArrow then
            View.Scroll(False)
          else
            View.StopTimer(tiScrollUp);
        end;
      tiScrollDown: begin
          if View.FShowDownArrow then
            View.Scroll(True)
          else
            View.StopTimer(tiScrollDown);
        end;
    end;
  end;

var
  MouseDownOnMenu: Boolean;
  FirstLoop: Boolean;
  Msg: TMsg;
  P: TPoint;
  Ctl: TControl;
  View: TppTBView;
  IsOnlyItemWithAccel: Boolean;
  MouseIsDown: Boolean;
  Key: Word;
  Shift: TShiftState;
  Viewer: TppTBItemViewer;
begin
  FillChar(RootView.FDoneActionData, SizeOf(RootView.FDoneActionData), 0);
  RootView.ValidatePositions;
  try
  try
    RootView.FCaptureWnd := FWnd;
    MouseDownOnMenu := False;
    if AMouseDown then begin
      P := RootView.FSelected.ScreenToClient(SmallPointToPoint(TSmallPoint(GetMessagePos())));
      RootView.FSelected.MouseDown([], P.X, P.Y, MouseDownOnMenu);
      if RootView.FDoneActionData.DoneAction <> tbdaNone then
        Exit;
      MouseDownOnMenu := False;  { never set MouseDownOnMenu to True on first click }
    end
    else if AExecuteSelected then begin
      RootView.ExecuteSelected(not AFromMSAA);
      if RootView.FDoneActionData.DoneAction <> tbdaNone then
        Exit;
    end;
    FirstLoop := True;
    while ContinueLoop do begin
      if not FirstLoop then
        WaitMessage;
      FirstLoop := False;
      while ContinueLoop and PeekMessage(Msg, 0, 0, 0, PM_NOREMOVE) do begin
        case Msg.message of
          WM_LBUTTONDOWN, WM_RBUTTONDOWN: begin
              P := SmallPointToPoint(TSmallPoint(Msg.lParam));
              Windows.ClientToScreen(Msg.hwnd, P);
              Ctl := FindDragTarget(P, True);
              { Was the mouse not clicked on a popup, or was it clicked on a
                popup that is not a child of RootView?
                (The latter can happen when in customization mode, for example,
                if the user right-clicks a popup menu being customized and
                the context menu is displayed.) }
              if not(Ctl is TppTBPopupWindow) or
                 not RootView.ContainsView(TppTBPopupWindow(Ctl).View) then begin
                { If the root view is a popup, or if the root view is a toolbar
                  and the user clicked outside the toolbar or in its non-client
                  area (e.g. on its drag handle), exit }
                if RootView.FIsPopup or (Ctl <> RootView.FWindow) or
                   not PtInRect(RootView.FWindow.ClientRect, RootView.FWindow.ScreenToClient(P)) then
                  Exit
                else
                  if Msg.message = WM_LBUTTONDOWN then begin
                    { If the user clicked inside a toolbar on anything but an
                      item, exit }
                    UpdateAllSelections(P, True);
                    if (RootView.FSelected = nil) or not RootView.FMouseOverSelected or
                       (tbisClicksTransparent in RootView.FSelected.Item.ItemStyle) then
                      Exit;
                  end;
              end;
          end;
        end;
        if PeekMessage(Msg, 0, 0, 0, PM_REMOVE or PM_NOYIELD) then begin
          case Msg.message of
            $4D:
              { This undocumented message is sent to the focused window when
                F1 is pressed. Windows handles it by sending a WM_HELP message
                to the same window. We don't want this to happen while a menu
                is up, so swallow the message. }
              ;
            WM_CONTEXTMENU:
              { Windows still sends WM_CONTEXTMENU messages for "context menu"
                keystrokes even if WM_KEYUP messages are never dispatched,
                so it must specifically ignore this message }
              ;
            WM_KEYFIRST..WM_KEYLAST: begin
                Application.CancelHint;
                MouseIsDown := (GetKeyState(VK_LBUTTON) < 0) or
                  (TrackRightButton and (GetKeyState(VK_RBUTTON) < 0));
                case Msg.message of
                  WM_KEYDOWN, WM_SYSKEYDOWN:
                    begin
                      if Msg.wParam = VK_PROCESSKEY then
                        { Don't let IME process the key }
                        Msg.wParam := ImmGetVirtualKey(Msg.hwnd);
                      if not MouseIsDown or (Msg.wParam = VK_F1) then begin
                        Key := Word(Msg.wParam);
                        if SendKeyEvent(GetActiveView, Key,
                           KeyDataToShiftState(Msg.lParam)) then
                          Exit;
                        { If it's not handled by a KeyDown method, translate
                          it into a WM_*CHAR message }
                        if Key <> 0 then
                          TranslateMessage(Msg);
                      end;
                    end;
                  WM_CHAR, WM_SYSCHAR:
                    if not MouseIsDown then begin
                      View := GetActiveView;
                      Viewer := View.NextSelectableWithAccel(View.FSelected,
                        Chr(Msg.WParam), False, IsOnlyItemWithAccel);
                      if Viewer = nil then begin
                        if (Msg.WParam in [VK_SPACE, Ord('-')]) and
                           not RootView.FIsPopup and (View = RootView) and
                           (GetActiveWindow <> 0) then begin
                          RootView.EndModalWithSystemMenu(GetActiveWindow,
                            Msg.WParam);
                          Exit;
                        end
                        else
                          MessageBeep(0);
                      end
                      else begin
                        View.Selected := Viewer;
                        View.ScrollSelectedIntoView;
                        if IsOnlyItemWithAccel then
                          View.ExecuteSelected(True);
                      end;
                    end;
                end;
              end;
            WM_TIMER:
              begin
                Ctl := FindControl(Msg.hwnd);
                if Assigned(Ctl) and (Ctl is TppTBPopupWindow) and
                   (Msg.wParam >= ViewTimerBaseID + Ord(Low(TppTBViewTimerID))) and
                   (Msg.wParam <= ViewTimerBaseID + Ord(High(TppTBViewTimerID))) then begin
                  if Assigned(TppTBPopupWindow(Ctl).FView) then
                    HandleTimer(TppTBPopupWindow(Ctl).FView,
                      TppTBViewTimerID(WPARAM(Msg.wParam - ViewTimerBaseID)));
                end
                else
                  DispatchMessage(Msg);
              end;
            $118: ;
                { ^ Like standard menus, don't dispatch WM_SYSTIMER messages
                  (the internal Windows message used for things like caret
                  blink and list box scrolling). }
            WM_MOUSEFIRST..WM_MOUSELAST:
              case Msg.message of
                WM_MOUSEMOVE: begin
                    if (Msg.pt.X <> LastPos.X) or (Msg.pt.Y <> LastPos.Y) then begin
                      LastPos := Msg.pt;
                      MouseMoved;
                    end;
                    if GetSelectedViewer(View, Viewer) then begin
                      P := Viewer.ScreenToClient(Msg.pt);
                      Viewer.MouseMove(P.X, P.Y);
                    end;
                  end;
                WM_MOUSEWHEEL:
                  if GetSelectedViewer(View, Viewer) then begin
                    P := Viewer.ScreenToClient(Msg.pt);
                    Viewer.MouseWheel(Smallint(LongRec(Msg.wParam).Hi), P.X, P.Y);
                  end;
                WM_LBUTTONDOWN, WM_LBUTTONDBLCLK, WM_RBUTTONDOWN:
                  if (Msg.message <> WM_RBUTTONDOWN) or TrackRightButton then begin
                    Application.CancelHint;
                    MouseDownOnMenu := False;
                    Exclude(RootView.FState, vsIgnoreFirstMouseUp);
                    UpdateAllSelections(Msg.pt, True);
                    if GetSelectedViewer(View, Viewer) then begin
                      if Msg.message <> WM_LBUTTONDBLCLK then
                        Shift := []
                      else
                        Shift := [ssDouble];
                      P := Viewer.ScreenToClient(Msg.pt);
                      Viewer.MouseDown(Shift, P.X, P.Y, MouseDownOnMenu);
                      LastPos := SmallPointToPoint(TSmallPoint(GetMessagePos()));
                    end;
                  end;
                WM_LBUTTONUP, WM_RBUTTONUP:
                  if (Msg.message = WM_LBUTTONUP) or TrackRightButton then begin
                    UpdateAllSelections(Msg.pt, False);
                    { ^ False is used so that when a popup menu is
                      displayed with the cursor currently inside it, the item
                      under the cursor won't be accidentally selected when the
                      user releases the button. The user must move the mouse at
                      at least one pixel (generating a WM_MOUSEMOVE message),
                      and then release the button. }
                    if not GetSelectedViewer(View, Viewer) then begin
                      { Mouse was not released over any item. Cancel out of the
                        loop if it's outside all views, or is inside unused
                        space on a topmost toolbar }
                      if not Assigned(View) or
                         ((View = RootView) and RootView.FIsToolbar) then begin
                        if not(vsIgnoreFirstMouseUp in RootView.FState) then
                          Exit
                        else
                          Exclude(RootView.FState, vsIgnoreFirstMouseUp);
                      end;
                    end
                    else begin
                      P := Viewer.ScreenToClient(Msg.pt);
                      Viewer.MouseUp(P.X, P.Y, MouseDownOnMenu);
                    end;
                  end;
              end;
          else
            DispatchMessage(Msg);
          end;
          if RootView.FDoneActionData.DoneAction <> tbdaNone then
            Exit;
          if LastPos.X = Low(LastPos.X) then begin
            LastPos := SmallPointToPoint(TSmallPoint(GetMessagePos()));
            MouseMoved;
          end;
          UpdateAppHint;
        end;
      end;
    end;
  finally
    RootView.CancelCapture;
  end;
  finally
    RootView.FCaptureWnd := 0;
    Application.Hint := '';
    { Make sure there are no outstanding WM_*CHAR messages }
    RemoveMessages(WM_CHAR, WM_DEADCHAR);
    RemoveMessages(WM_SYSCHAR, WM_SYSDEADCHAR);
    { Nor any outstanding 'send WM_HELP' messages caused by an earlier press
      of the F1 key }
    RemoveMessages($4D, $4D);
  end;
end;


{ TppTBPopupView }

procedure TppTBPopupView.AutoSize(AWidth, AHeight: Integer);
begin
  with TppTBPopupWindow(FWindow) do
    with GetNCSize do
      SetBounds(Left, Top, AWidth + (X * 2),
        AHeight + (Y * 2));
end;

function TppTBPopupView.GetFont: TFont;
begin
  Result := (Owner as TppTBPopupWindow).Font;
end;


{ TppTBPopupWindow }

constructor TppTBPopupWindow.CreatePopupWindow(AOwner: TComponent;
  const AParentView: TppTBView; const AItem: TppTBCustomItem;
  const ACustomizing: Boolean);
begin
  inherited Create(AOwner);
  Visible := False;
  SetBounds(0, 0, 320, 240);
  ControlStyle := ControlStyle - [csCaptureMouse];
  ShowHint := True;
  Color := tbMenuBkColor;
  FView := GetViewClass.CreateView(Self, AParentView, AItem, Self, False,
    ACustomizing, False);
  Include(FView.FState, vsModal);

  { Inherit the font from the parent view, or use the system menu font if
    there is no parent view }
  if Assigned(AParentView) then
    Font.Assign(AParentView.GetFont)
  else
    Font.Assign(ToolbarFont);

  { Inherit the accelerator visibility state from the parent view. If there
    is no parent view (i.e. it's a standalone popup menu), then default to
    hiding accelerator keys, but change this in CreateWnd if the last input
    came from the keyboard. }
  if Assigned(AParentView) then begin
    if vsUseHiddenAccels in AParentView.FStyle then
      Include(FView.FStyle, vsUseHiddenAccels);
    if vsShowAccels in AParentView.FState then
      Include(FView.FState, vsShowAccels);
  end
  else
    Include(FView.FStyle, vsUseHiddenAccels);

  if Application.Handle <> 0 then
    { Use Application.Handle if possible so that the taskbar button for the app
      doesn't pop up when a TppTBEditItem on a popup menu is focused }
    ParentWindow := Application.Handle
  else
    { When Application.Handle is zero, use GetDesktopWindow() as the parent
      window, not zero, otherwise UpdateControlState won't show the window }
    ParentWindow := GetDesktopWindow;
end;

destructor TppTBPopupWindow.Destroy;
begin
  Destroying;
  { Ensure window handle is destroyed *before* FView is freed, since
    DestroyWindowHandle calls CallNotifyWinEvent which may result in
    FView.HandleWMObject being called }
  if HandleAllocated then
    DestroyWindowHandle;
  FreeAndNil(FView);
  inherited;
end;

procedure TppTBPopupWindow.BeforeDestruction;
begin
  { The inherited BeforeDestruction method hides the form. We need to close
    any child popups first, so that pixels behind the popups are properly
    restored without generating a WM_PAINT message. }
  if Assigned(FView) then
    FView.CloseChildPopups;
  inherited;
end;

function TppTBPopupWindow.GetNCSize: TPoint;
begin
  Result.X := PopupMenuWindowNCSize;
  Result.Y := PopupMenuWindowNCSize;
end;

function TppTBPopupWindow.GetViewClass: TppTBViewClass;
begin
  Result := TppTBPopupView;
end;

procedure TppTBPopupWindow.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited;
  with Params do begin
    Style := (Style and not (WS_CHILD or WS_GROUP or WS_TABSTOP)) or WS_POPUP;
    ExStyle := ExStyle or WS_EX_TOPMOST or WS_EX_TOOLWINDOW;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    { Enable drop shadow effect on Windows XP and later }
    if IsWindowsXP then
      WindowClass.Style := WindowClass.Style or CS_DROPSHADOW;
  end;
end;

procedure TppTBPopupWindow.CreateWnd;
const
  WM_CHANGEUISTATE = $0127;
  WM_QUERYUISTATE  = $0129;
  UIS_INITIALIZE = 3;
  UISF_HIDEACCEL = $2;
var
  B: Boolean;
begin
  inherited;
  { On a top-level popup window, send WM_CHANGEUISTATE & WM_QUERYUISTATE
    messages to the window to see if the last input came from the keyboard
    and if the accelerator keys should be shown }
  if (FView.ParentView = nil) and not FAccelsVisibilitySet then begin
    FAccelsVisibilitySet := True;
    SendMessage(Handle, WM_CHANGEUISTATE, UIS_INITIALIZE, 0);
    B := (SendMessage(Handle, WM_QUERYUISTATE, 0, 0) and UISF_HIDEACCEL = 0);
    FView.SetAccelsVisibility(B);
  end;
end;

procedure TppTBPopupWindow.DestroyWindowHandle;
begin
  { Before destroying the window handle, we must stop any animation, otherwise
    the animation thread will use an invalid handle }
  EndAnimation(WindowHandle);
  { Cleanly destroy any timers before the window handle is destroyed }
  if Assigned(FView) then
    FView.StopAllTimers;
  CallNotifyWinEvent(EVENT_SYSTEM_MENUPOPUPEND, WindowHandle, OBJID_CLIENT,
    CHILDID_SELF);
  inherited;
end;

procedure TppTBPopupWindow.WMGetObject(var Message: TMessage);
begin
  if not FView.HandleWMGetObject(Message) then
    inherited;
end;

procedure TppTBPopupWindow.CMShowingChanged(var Message: TMessage);
const
  ShowFlags: array[Boolean] of UINT = (
    SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_NOACTIVATE or SWP_HIDEWINDOW,
    SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_NOACTIVATE or SWP_SHOWWINDOW);
  SPI_GETMENUFADE = $1012;
var
  Animate: BOOL;
  Blend: Boolean;
begin
  { Must override TCustomForm/TForm's CM_SHOWINGCHANGED handler so that the
    form doesn't get activated when Visible is set to True. }

  { Handle animation. NOTE: I do not recommend trying to enable animation on
    Windows 95 and NT 4.0 because there's a difference in the way the
    SetWindowPos works on those versions. See the comment in the
    TBStartAnimation function of TB2Anim.pas. }
  {$IFNDEF TB2K_NO_ANIMATION}
  if ((FView.ParentView = nil) or not(vsNoAnimation in FView.FParentView.FState)) and
     Showing and (FView.Selected = nil) and not IsWindowVisible(WindowHandle) and
     SystemParametersInfo(SPI_GETMENUANIMATION, 0, @Animate, 0) and Animate then begin
    Blend := SystemParametersInfo(SPI_GETMENUFADE, 0, @Animate, 0) and Animate;
    if Blend or (FAnimationDirection <> []) then begin
      if SendMessage(WindowHandle, WM_TB2K_POPUPSHOWING, TPS_ANIMSTART, 0) = 0 then
      begin
        { Start animation only if WM_TB2K_POPUPSHOWING returns zero (or not handled) }
        StartAnimation(WindowHandle, 150, Blend, FAnimationDirection);
        Exit;
      end;
    end;
  end;
  {$ENDIF}

  { No animation... }
  if not Showing then begin
    { Call TBEndAnimation to ensure WS_EX_LAYERED style is removed before
      hiding, otherwise windows under the popup window aren't repainted
      properly. }
    EndAnimation(WindowHandle);
  end;
  SetWindowPos(WindowHandle, 0, 0, 0, 0, 0, ShowFlags[Showing]);
  if Showing then SendNotifyMessage(WindowHandle, WM_TB2K_POPUPSHOWING, TPS_NOANIM, 0);
end;

procedure TppTBPopupWindow.WMTB2kAnimationEnded(var Message: TMessage);
begin
  SendNotifyMessage(WindowHandle, WM_TB2K_POPUPSHOWING, TPS_ANIMFINISHED, 0);
end;

procedure TppTBPopupWindow.WMTB2kStepAnimation(var Message: TMessage);
begin
  StepAnimation(Message);
end;

procedure TppTBPopupWindow.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  { May be necessary in some cases... }
  EndAnimation(WindowHandle);
  inherited;
end;

procedure TppTBPopupWindow.WMPaint(var Message: TWMPaint);
begin
  { Must abort animation when a WM_PAINT message is received }
  EndAnimation(WindowHandle);
  inherited;
end;

procedure TppTBPopupWindow.Paint;
begin
  FView.DrawSubitems(Canvas);
  PaintScrollArrows;
end;

procedure TppTBPopupWindow.PaintScrollArrows;

  procedure DrawArrow(const R: TRect; ADown: Boolean);
  var
    X, Y: Integer;
    P: array[0..2] of TPoint;
  begin
    X := (R.Left + R.Right) div 2;
    Y := (R.Top + R.Bottom) div 2;
    Dec(Y);
    P[0].X := X-3;
    P[0].Y := Y;
    P[1].X := X+3;
    P[1].Y := Y;
    P[2].X := X;
    P[2].Y := Y;
    if ADown then
      Inc(P[2].Y, 3)
    else begin
      Inc(P[0].Y, 3);
      Inc(P[1].Y, 3);
    end;
    Canvas.Pen.Color := tbMenuTextColor;
    Canvas.Brush.Color := tbMenuTextColor;
    Canvas.Polygon(P);
  end;

begin
  if FView.FShowUpArrow then
    DrawArrow(Rect(0, 0, ClientWidth, tbMenuScrollArrowHeight), False);
  if FView.FShowDownArrow then
    DrawArrow(Bounds(0, ClientHeight - tbMenuScrollArrowHeight,
      ClientWidth, tbMenuScrollArrowHeight), True);
end;

procedure TppTBPopupWindow.WMClose(var Message: TWMClose);
begin
  { do nothing -- ignore Alt+F4 keypresses }
end;

procedure TppTBPopupWindow.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  with GetNCSize do
    InflateRect(Message.CalcSize_Params^.rgrc[0], -X, -Y);
  inherited;
end;

procedure PopupWindowNCPaintProc(Wnd: HWND; DC: HDC; AppData: Longint);
var
  R: TRect;
  {$IFNDEF TB2K_USE_STRICT_O2K_MENU_STYLE}
  Brush: HBRUSH;
  {$ENDIF}
begin
  GetWindowRect(Wnd, R);  OffsetRect(R, -R.Left, -R.Top);
  {$IFNDEF TB2K_USE_STRICT_O2K_MENU_STYLE}
  if not AreFlatMenusEnabled then begin
  {$ENDIF}
    DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_ADJUST);
    FrameRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
  {$IFNDEF TB2K_USE_STRICT_O2K_MENU_STYLE}
  end
  else begin
    FrameRect(DC, R, GetSysColorBrush(COLOR_BTNSHADOW));
    Brush := CreateSolidBrush(ColorToRGB(TppTBPopupWindow(AppData).Color));
    InflateRect(R, -1, -1);
    FrameRect(DC, R, Brush);
    InflateRect(R, -1, -1);
    FrameRect(DC, R, Brush);
    DeleteObject(Brush);
  end;
  {$ENDIF}
end;

procedure TppTBPopupWindow.WMNCPaint(var Message: TMessage);
var
  DC: HDC;
begin
  DC := GetWindowDC(Handle);
  try
    SelectNCUpdateRgn(Handle, DC, HRGN(Message.WParam));
    PopupWindowNCPaintProc(Handle, DC, Longint(Self));
  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TppTBPopupWindow.WMPrint(var Message: TMessage);
begin
  HandleWMPrint(Handle, Message, PopupWindowNCPaintProc, Longint(Self));
end;

procedure TppTBPopupWindow.WMPrintClient(var Message: TMessage);
begin
  HandleWMPrintClient(Self, Message);
end;

procedure TppTBPopupWindow.CMHintShow(var Message: TCMHintShow);
begin
  with Message.HintInfo^ do begin
    HintStr := '';
    if Assigned(FView.Selected) then begin
      CursorRect := FView.Selected.BoundsRect;
      HintStr := FView.FSelected.GetHintText;
    end;
  end;
end;


{ TppTBItemContainer }

constructor TppTBItemContainer.Create(AOwner: TComponent);
begin
  inherited;
  FItem := TppTBRootItem.Create(Self);
  FItem.ParentComponent := Self;
end;

destructor TppTBItemContainer.Destroy;
begin
  FItem.Free;
  inherited;
end;

function TppTBItemContainer.GetItems: TppTBCustomItem;
begin
  Result := FItem;
end;

procedure TppTBItemContainer.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  FItem.GetChildren(Proc, Root);
end;

function TppTBItemContainer.GetImages: TCustomImageList;
begin
  Result := FItem.SubMenuImages;
end;

procedure TppTBItemContainer.SetImages(Value: TCustomImageList);
begin
  FItem.SubMenuImages := Value;
end;


{ TppTBPopupMenu }

constructor TppTBPopupMenu.Create(AOwner: TComponent);
begin
  inherited;
  FItem := GetRootItemClass.Create(Self);
  FItem.ParentComponent := Self;
  FItem.OnClick := RootItemClick;
end;

destructor TppTBPopupMenu.Destroy;
begin
  FItem.Free;
  inherited;
end;

function TppTBPopupMenu.GetItems: TppTBCustomItem;
begin
  Result := FItem;
end;

procedure TppTBPopupMenu.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  FItem.GetChildren(Proc, Root);
end;

procedure TppTBPopupMenu.SetChildOrder(Child: TComponent; Order: Integer);
begin
  FItem.SetChildOrder(Child, Order);
end;

function TppTBPopupMenu.GetRootItemClass: TppTBRootItemClass;
begin
  Result := TppTBRootItem;
end;

function TppTBPopupMenu.GetImages: TCustomImageList;
begin
  Result := FItem.SubMenuImages;
end;

function TppTBPopupMenu.GetLinkSubitems: TppTBCustomItem;
begin
  Result := FItem.LinkSubitems;
end;

function TppTBPopupMenu.GetOptions: TppTBItemOptions;
begin
  Result := FItem.Options;
end;

procedure TppTBPopupMenu.SetImages(Value: TCustomImageList);
begin
  FItem.SubMenuImages := Value;
end;

procedure TppTBPopupMenu.SetLinkSubitems(Value: TppTBCustomItem);
begin
  FItem.LinkSubitems := Value;
end;

procedure TppTBPopupMenu.SetOptions(Value: TppTBItemOptions);
begin
  FItem.Options := Value;
end;

procedure TppTBPopupMenu.RootItemClick(Sender: TObject);
begin
  if Sender = FItem then
    Sender := Self;
  DoPopup(Sender);
end;

{$IFNDEF JR_D5}
procedure TppTBPopupMenu.DoPopup(Sender: TObject);
begin
  if Assigned(OnPopup) then OnPopup(Sender);
end;
{$ENDIF}

procedure TppTBPopupMenu.Popup(X, Y: Integer);
begin
  {$IFDEF JR_D5}
  PPoint(@PopupPoint)^ := Point(X, Y);
  {$ENDIF}
  FItem.Popup(X, Y, TrackButton = tbRightButton, TppTBPopupAlignment(Alignment));
end;

function TppTBPopupMenu.IsShortCut(var Message: TWMKey): Boolean;
begin
  Result := FItem.IsShortCut(Message);
end;


{ TppTBImageList }

constructor TppTBCustomImageList.Create(AOwner: TComponent);
begin
  inherited;
  FCheckedImagesChangeLink := TChangeLink.Create;
  FCheckedImagesChangeLink.OnChange := ImageListChanged;
  FDisabledImagesChangeLink := TChangeLink.Create;
  FDisabledImagesChangeLink.OnChange := ImageListChanged;
  FHotImagesChangeLink := TChangeLink.Create;
  FHotImagesChangeLink.OnChange := ImageListChanged;
  FImagesBitmap := TBitmap.Create;
  FImagesBitmap.OnChange := ImagesBitmapChanged;
  FImagesBitmapMaskColor := clFuchsia;
end;

destructor TppTBCustomImageList.Destroy;
begin
  FreeAndNil(FImagesBitmap);
  FreeAndNil(FHotImagesChangeLink);
  FreeAndNil(FDisabledImagesChangeLink);
  FreeAndNil(FCheckedImagesChangeLink);
  inherited;
end;

procedure TppTBCustomImageList.ImagesBitmapChanged(Sender: TObject);
begin
  if not ImagesBitmap.Empty then begin
    Clear;
    AddMasked(ImagesBitmap, FImagesBitmapMaskColor);
  end;
end;

procedure TppTBCustomImageList.ImageListChanged(Sender: TObject);
begin
  Change;
end;

procedure TppTBCustomImageList.DefineProperties(Filer: TFiler);
type
  TProc = procedure(ASelf: TObject; Filer: TFiler);
begin
  if (Filer is TReader) or FImagesBitmap.Empty then
    inherited
  else
    { Bypass TCustomImageList.DefineProperties when we've got an ImageBitmap }
    TProc(@TComponentAccess.DefineProperties)(Self, Filer);
end;

procedure TppTBCustomImageList.DrawState(Canvas: TCanvas; X, Y, Index: Integer;
  Enabled, Selected, Checked: Boolean);
begin
  if not Enabled and Assigned(DisabledImages) then
    DisabledImages.Draw(Canvas, X, Y, Index)
  else if Checked and Assigned(CheckedImages) then
    CheckedImages.Draw(Canvas, X, Y, Index, Enabled)
  else if Selected and Assigned(HotImages) then
    HotImages.Draw(Canvas, X, Y, Index, Enabled)
  else
    Draw(Canvas, X, Y, Index, Enabled);
end;

procedure TppTBCustomImageList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then begin
    if AComponent = CheckedImages then CheckedImages := nil;
    if AComponent = DisabledImages then DisabledImages := nil;
    if AComponent = HotImages then HotImages := nil;
  end;
end;

procedure TppTBCustomImageList.ChangeImages(var AImageList: TCustomImageList;
  Value: TCustomImageList; AChangeLink: TChangeLink);
begin
  if Value = Self then
    Value := nil;
  if AImageList <> Value then begin
    if Assigned(AImageList) then
      AImageList.UnregisterChanges(AChangeLink);
    AImageList := Value;
    if Assigned(Value) then begin
      Value.RegisterChanges(AChangeLink);
      Value.FreeNotification(Self);
    end;
    { Don't call Change while loading because it causes the Delphi IDE to
      think the form has been modified (?). Also, don't call Change while
      destroying since there's no reason to. }
    if not(csLoading in ComponentState) and
       not(csDestroying in ComponentState) then
      Change;
  end;
end;

procedure TppTBCustomImageList.SetCheckedImages(Value: TCustomImageList);
begin
  ChangeImages(FCheckedImages, Value, FCheckedImagesChangeLink);
end;

procedure TppTBCustomImageList.SetDisabledImages(Value: TCustomImageList);
begin
  ChangeImages(FDisabledImages, Value, FDisabledImagesChangeLink);
end;

procedure TppTBCustomImageList.SetHotImages(Value: TCustomImageList);
begin
  ChangeImages(FHotImages, Value, FHotImagesChangeLink);
end;

procedure TppTBCustomImageList.SetImagesBitmap(Value: TBitmap);
begin
  FImagesBitmap.Assign(Value);
end;

procedure TppTBCustomImageList.SetImagesBitmapMaskColor(Value: TColor);
begin
  if FImagesBitmapMaskColor <> Value then begin
    FImagesBitmapMaskColor := Value;
    ImagesBitmapChanged(nil);
  end;
end;


{ TppTBBaseAccObject }

{ According to the MSAA docs:
  "With Active Accessibility 2.0, servers can return E_NOTIMPL from IDispatch
  methods and Active Accessibility will implement the IAccessible interface
  for them."
  And there was much rejoicing. }

function TppTBBaseAccObject.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TppTBBaseAccObject.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TppTBBaseAccObject.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TppTBBaseAccObject.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;


{ Initialization & finalization }

procedure TBInitToolbarSystemFont;
var
  NonClientMetrics: TNonClientMetrics;
begin
  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    ToolbarFont.Handle := CreateFontIndirect(NonClientMetrics.lfMenuFont);
end;

initialization
  ToolbarFont := TFont.Create;
  TBInitToolbarSystemFont;
finalization
  DestroyClickWnd;
  ToolbarFont.Free;
  ToolbarFont := nil;
end.
