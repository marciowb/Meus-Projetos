{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
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

unit cxGridCustomView;

{$I cxVer.inc}

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, StdCtrls, Menus,
  cxClasses, cxControls, cxContainer, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxStorage, cxGridCommon, cxCustomData, cxData, cxListBox, cxPC;

const
  cxGridCustomizationFormDefaultWidth = 180;
  cxGridCustomizationFormDefaultHeight = 300;

  htError = -1;
  htNone = 0;
  htNavigator = 1;
  htCustomizationForm = 2;

  ckNone = 0;
  ckCustomizationForm = 1;

  bbCustomFirst = 0;
  bbBackground = bbCustomFirst;
  bbCustomLast = bbBackground;

  vsCustomFirst = 0;
  vsBackground = vsCustomFirst;
  vsCustomLast = vsBackground;

  StoringVersion = 1;

type
  TcxCustomGridDragAndDropObjectClass = class of TcxCustomGridDragAndDropObject;
  TcxCustomGridItemsListBox = class;
  TcxCustomGridCustomizationForm = class;
  TcxGridPopupListBox = class;
  TcxCustomGridController = class;
  TcxCustomGridPainter = class;
  TcxCustomGridViewData = class;
  TcxCustomGridCellViewInfo = class;
  TcxCustomGridViewCellViewInfo = class;
  TcxCustomGridViewInfo = class;
  TcxCustomGridViewInfoCache = class;
  TcxGridSite = class;
  TcxCustomGridView = class;

  IcxGridViewLayoutEditorSupport = interface  // it is here because of problem in CBuilder
    ['{9C5EC9C0-A912-4822-BBD0-87AB45FDCC78}']
    procedure BeforeEditLayout(ALayoutView: TcxCustomGridView);
    procedure DoAssignLayout(ALayoutView: TcxCustomGridView);
    function GetLayoutCustomizationFormButtonCaption: string;
    function HasLayoutCustomizationForm: Boolean;
    function IsLayoutChangeable: Boolean;
    procedure RunLayoutCustomizationForm;
  end;

  TcxGridViewDesignerMenuItemAction = (vmiaNone, vmiaSelectComponent);

  IcxGridViewDesignerMenu = interface
    ['{7A186AB1-361D-41D0-99C6-E9670383D223}']
    procedure DoMenuItemAction(AIndex: Integer; var AModified: Boolean);
    function GetMenuItemAction(AIndex: Integer): TcxGridViewDesignerMenuItemAction;
    function GetMenuItemCount: Integer;
    function GetMenuItemObject(AIndex: Integer): TObject;
    procedure PrepareMenuItem(AIndex: Integer; AMenuItem: TMenuItem);
  end;

  { change }

  TcxCustomGridViewChange = class(TcxCustomGridChange)
  private
    FGridView: TcxCustomGridView;
  public
    constructor Create(AGridView: TcxCustomGridView); virtual;
    property GridView: TcxCustomGridView read FGridView write FGridView;
    function IsEqual(AChange: TcxCustomGridChange): Boolean; override;
  end;

  TcxGridControlFocusChange = class(TcxCustomGridViewChange)
  public
    procedure Execute; override;
  end;

  { hit tests }

  TcxCustomGridHitTestClass = class of TcxCustomGridHitTest;

  TcxCustomGridHitTest = class
  private
    FPos: TPoint;
    FViewInfo: TcxCustomGridCellViewInfo;
    procedure SetViewInfo(Value: TcxCustomGridCellViewInfo);
  protected
    class function GetHitTestCode: Integer; virtual;
    procedure Init(const APos: TPoint);
  public
    destructor Destroy; override;
    function Cursor: TCursor; virtual;
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; virtual;
    class function HitTestCode: Integer;
    class function Instance(const APos: TPoint): TcxCustomGridHitTest;
    property Pos: TPoint read FPos;
    property ViewInfo: TcxCustomGridCellViewInfo read FViewInfo write SetViewInfo;
  end;

  TcxGridNoneHitTest = class(TcxCustomGridHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxCustomGridViewHitTest = class(TcxCustomGridHitTest)
  private
    FGridView: TcxCustomGridView;
  public
    property GridView: TcxCustomGridView read FGridView write FGridView;
  end;

  TcxGridViewNoneHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridNavigatorHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridCustomizationFormHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  { custom handler }

  TcxGridViewHandler = class(TcxInterfacedPersistent)
  private
    FGridView: TcxCustomGridView;
    function GetControl: TcxControl;
    function GetController: TcxCustomGridController;
    function GetDataController: TcxCustomDataController;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
    function GetPainter: TcxCustomGridPainter;
    function GetSite: TcxGridSite;
    function GetViewData: TcxCustomGridViewData;
    function GetViewInfo: TcxCustomGridViewInfo;
  protected
    property Control: TcxControl read GetControl;
    property Controller: TcxCustomGridController read GetController;
    property DataController: TcxCustomDataController read GetDataController;
    property ViewData: TcxCustomGridViewData read GetViewData;
  public
    constructor Create(AGridView: TcxCustomGridView); reintroduce; virtual;
    procedure BeginUpdate;
    procedure EndUpdate;
    property GridView: TcxCustomGridView read FGridView;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
    property Painter: TcxCustomGridPainter read GetPainter;
    property Site: TcxGridSite read GetSite;
    property ViewInfo: TcxCustomGridViewInfo read GetViewInfo;
  end;

  { contoller }

  // drag&drop objects

  TcxCustomGridDragAndDropObject = class(TcxDragAndDropObject)
  private
    function GetController: TcxCustomGridController;
    function GetGridView: TcxCustomGridView;
    function GetViewInfo: TcxCustomGridViewInfo;
  protected
    procedure AfterDragAndDrop(Accepted: Boolean); override;
    procedure AfterPaint; virtual;
    procedure BeforePaint; virtual;
    property Controller: TcxCustomGridController read GetController;
    property ViewInfo: TcxCustomGridViewInfo read GetViewInfo;
  public
    SourcePoint: TPoint;
    procedure AfterScrolling; virtual;
    procedure BeforeScrolling; virtual;
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); virtual;
    property GridView: TcxCustomGridView read GetGridView;
  end;

  TcxGridArrowNumber = (anFirst, anLast);
  TcxGridArrowPlace = (apLeft, apTop, apRight, apBottom);

  TcxCustomGridMovingObject = class(TcxCustomGridDragAndDropObject)
  private
    FArrowsVisible: Boolean;
    FDragImage: TBitmap;
    FDragImageCanvas: TcxCanvas;
    FDragImageOffset: TPoint;
    FDragImagePos: TPoint;
    FDragImageSavingBitmap: TBitmap;
    FDragImageSavingPos: TPoint;
    FDragImageVisible: Boolean;
    FSavingBitmap: TBitmap;
    FSourceItem: TObject;

    function GetArrowPlace(AArrowNumber: TcxGridArrowNumber): TcxGridArrowPlace;
    function GetCustomizationForm: TcxCustomGridCustomizationForm;
    function GetDragImageSavingCanvas: TCanvas;
    function GetSavingBitmap: TBitmap;
    function GetSavingCanvas: TCanvas;

    procedure CreateDragImage;
    procedure DestroyDragImage;
  protected
    procedure DirtyChanged; override;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; override;

    procedure ChangeArrowsVisibility(AVisible: Boolean);
    procedure ChangeDragImagePosition(AVisible: Boolean = True);

    function AreArrowsVertical: Boolean; virtual;
    function CalculateDragImageOffset: TPoint; virtual;
    function CanRemove: Boolean; virtual; abstract;
    function GetArrowAreaBounds(APlace: TcxGridArrowPlace): TRect; virtual; abstract;
    function GetArrowBounds(APlace: TcxGridArrowPlace): TRect; virtual;
    function GetArrowsClientRect: TRect; virtual;
    function GetCustomizationFormListBox: TcxCustomGridItemsListBox; virtual; abstract;
    function GetDragImageBounds(AMousePos: TPoint): TRect; virtual;
    function GetSourceItemBounds: TRect; virtual;
    function GetSourceItemViewInfo: TcxCustomGridCellViewInfo; virtual;
    procedure InitDragImage; virtual;
    procedure InitDragImageUsingCustomizationForm(ACanvas: TcxCanvas;
      const R: TRect; AItem: TObject); virtual;
    function IsSourceCustomizationForm: Boolean; virtual; abstract;
    function IsValidDestination: Boolean; virtual; abstract;

    procedure BeginDragAndDrop; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;

    property ArrowBounds[APlace: TcxGridArrowPlace]: TRect read GetArrowBounds;
    property ArrowPlaces[AArrowNumber: TcxGridArrowNumber]: TcxGridArrowPlace read GetArrowPlace;
    property ArrowsClientRect: TRect read GetArrowsClientRect;
    property CustomizationForm: TcxCustomGridCustomizationForm read GetCustomizationForm;
    property CustomizationFormListBox: TcxCustomGridItemsListBox read GetCustomizationFormListBox;
    property DragImage: TBitmap read FDragImage;
    property DragImageCanvas: TcxCanvas read FDragImageCanvas;
    property DragImageOffset: TPoint read FDragImageOffset;
    property DragImagePos: TPoint read FDragImagePos write FDragImagePos;
    property DragImageSavingBitmap: TBitmap read FDragImageSavingBitmap;
    property DragImageSavingCanvas: TCanvas read GetDragImageSavingCanvas;
    property DragImageSavingPos: TPoint read FDragImageSavingPos write FDragImageSavingPos;
    property DragImageVisible: Boolean read FDragImageVisible write FDragImageVisible;
    property SavingBitmap: TBitmap read GetSavingBitmap;
    property SavingCanvas: TCanvas read GetSavingCanvas;
    property SourceItem: TObject read FSourceItem write FSourceItem;
    property SourceItemBounds: TRect read GetSourceItemBounds;
    property SourceItemViewInfo: TcxCustomGridCellViewInfo read GetSourceItemViewInfo;
  public
    constructor Create(AControl: TcxControl); override;
    destructor Destroy; override;
    procedure AfterScrolling; override;
    procedure BeforeScrolling; override;
  end;

  // customization form

  TcxCustomGridItemsInnerListBox = class(TcxInnerListBox)
  private
    FDragAndDropItemIndex: Integer;
    FMouseDownPos: TPoint;
    function GetContainer: TcxCustomGridItemsListBox;
    function GetDragAndDropItem: TObject;
    function GetGridView: TcxCustomGridView;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure CalculateBorderStyle;
    procedure CalculateItemHeight;

    property Container: TcxCustomGridItemsListBox read GetContainer;
    property DragAndDropItem: TObject read GetDragAndDropItem;
    property DragAndDropItemIndex: Integer read FDragAndDropItemIndex;
    property GridView: TcxCustomGridView read GetGridView;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TcxCustomGridItemsListBoxClass = class of TcxCustomGridItemsListBox;

  TcxCustomGridItemsListBox = class(TcxListBox)
  private
    function GetDragAndDropItem: TObject;
    function GetGridView: TcxCustomGridView;
    function GetInnerListBox: TcxCustomGridItemsInnerListBox;
  protected
    function CalculateItemHeight: Integer; virtual; abstract;
    function GetInnerListBoxClass: TcxInnerListBoxClass; override;
    function GetDragAndDropParams: TcxCustomGridHitTest; virtual; abstract;
    property DragAndDropItem: TObject read GetDragAndDropItem;
    property GridView: TcxCustomGridView read GetGridView;
  public
    constructor Create(AOwner: TComponent); override;
    function IndexOfItem(AItem: TObject): Integer;
    procedure PaintDragAndDropItem(ACanvas: TcxCanvas; const R: TRect; AItem: TObject);
    procedure PaintItem(ACanvas: TcxCanvas; R: TRect; AIndex: Integer; AFocused: Boolean); virtual; abstract;
    procedure RefreshItems; virtual;
    property InnerListBox: TcxCustomGridItemsInnerListBox read GetInnerListBox;
  end;

  TcxCustomGridCustomizationFormClass = class of TcxCustomGridCustomizationForm;

  TcxCustomGridCustomizationForm = class(TForm)
  private
    FController: TcxCustomGridController;
    FHookTimer: TcxTimer;
    FOffset: Integer;
    FPageControl: TcxPageControl;
    function GetGridView: TcxCustomGridView;
    function GetViewInfo: TcxCustomGridViewInfo;
    procedure HookTimerHandler(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoClose(var Action: TCloseAction); override;
    procedure DoShow; override;

    procedure CalculateConsts; virtual;
    procedure CreateControls; virtual;
    function CreatePage(const ACaption: string; AVisible: Boolean): TcxTabSheet;
    procedure GridViewChanged; virtual;

    function GetContentBounds: TRect; virtual;
    function GetPageControlBounds: TRect; virtual;
    procedure InitPageControl; virtual;

    property ContentBounds: TRect read GetContentBounds;
    property GridView: TcxCustomGridView read GetGridView;
    property Offset: Integer read FOffset write FOffset;
    property PageControl: TcxPageControl read FPageControl;
    property ViewInfo: TcxCustomGridViewInfo read GetViewInfo;
  public
    constructor Create(AController: TcxCustomGridController); reintroduce; virtual;
    destructor Destroy; override;
    property Controller: TcxCustomGridController read FController;
    procedure ActivatePage(APage: TcxTabSheet);
    procedure RefreshData; virtual;
  end;

  // popup

  (*$HPPEMIT 'namespace Cxgridcustomview'}*)
  (*$HPPEMIT '{'}*)
  (*$HPPEMIT '__interface IcxCustomGridPopupOwner;'}*)
  (*$HPPEMIT '}'*)

  IcxCustomGridPopupOwner = interface
    ['{ACF62D23-6871-4735-A4CE-3B0888DB8FC3}']
    function ClosePopupWhenNilOwner: Boolean;
    function GetOwnerBounds: TRect;
    procedure PopupClosed;
  end;

  TcxCustomGridPopup = class(TcxCustomPopupWindow)
  private
    FGridView: TcxCustomGridView;
    FOwner: IcxCustomGridPopupOwner;
    procedure SetOwner(Value: IcxCustomGridPopupOwner);
  protected
    function CalculateOwnerBounds: TRect; virtual;
    function GetClientMinWidth: Integer; virtual;
    procedure InitPopup; override;
    procedure Paint; override;
    procedure VisibleChanged; override;
  public
    constructor Create(AGridView: TcxCustomGridView); reintroduce; virtual;
    procedure CloseUp; override;
    procedure Popup; reintroduce; virtual;
    property BorderWidths;
    property GridView: TcxCustomGridView read FGridView;
    property ClientMinWidth: Integer read GetClientMinWidth;
    property Owner: IcxCustomGridPopupOwner read FOwner write SetOwner;
  end;

  TcxGridPopupListBoxActionEvent = procedure(Sender: TcxGridPopupListBox;
    AItemIndex: Integer) of object;

  TcxGridPopupListBox = class(TcxListBox)
  private
    FItemTextOffsetLeft: Integer;
    FItemTextOffsetRight: Integer;
    FItemTextOffsetVert: Integer;
    FMinWidth: Integer;
    FPopup: TcxCustomGridPopup;
    FVisibleItemCount: Integer;
    FVisibleWidth: Integer;
    FOnAction: TcxGridPopupListBoxActionEvent;
    function GetGridView: TcxCustomGridView;
  protected
    function DrawItem(ACanvas: TcxCanvas; AIndex: Integer; const ARect: TRect;
      AState: TOwnerDrawState): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    function CalculateItemHeight: Integer; virtual;
    procedure DoAction(AItemIndex: Integer); virtual;
    procedure DrawItemContent(ACanvas: TcxCanvas; AIndex: Integer; ARect: TRect;
      AState: TOwnerDrawState); virtual;
    function GetVisibleItemCount(AItems: TStrings): Integer; virtual;
    procedure Init; virtual;
  public
    constructor Create(APopup: TcxCustomGridPopup); reintroduce; virtual;
    procedure AdjustBounds(AItems: TStrings = nil); virtual;

    property GridView: TcxCustomGridView read GetGridView;
    property ItemTextOffsetLeft: Integer read FItemTextOffsetLeft write FItemTextOffsetLeft;
    property ItemTextOffsetRight: Integer read FItemTextOffsetRight write FItemTextOffsetRight;
    property ItemTextOffsetVert: Integer read FItemTextOffsetVert write FItemTextOffsetVert;
    property MinWidth: Integer read FMinWidth write FMinWidth;
    property Popup: TcxCustomGridPopup read FPopup;
    property VisibleItemCount: Integer read FVisibleItemCount write FVisibleItemCount;
    property VisibleWidth: Integer read FVisibleWidth write FVisibleWidth;
    property OnAction: TcxGridPopupListBoxActionEvent read FOnAction write FOnAction;
  end;

  // controllers

  TcxGridDesignControllerClass = class of TcxGridDesignController;

  TcxGridDesignController = class
  private
    FController: TcxCustomGridController;
    function GetControl: TcxControl;
  protected
    function GetDesignObject(AObject: TPersistent): TPersistent;
  public
    constructor Create(AController: TcxCustomGridController); virtual;
    function IsObjectSelected(AObject: TPersistent): Boolean;
    procedure SelectObject(AObject: TPersistent; AClearSelection: Boolean);
    procedure UnselectObject(AObject: TPersistent);
    property Control: TcxControl read GetControl;
    property Controller: TcxCustomGridController read FController;
  end;

  TcxCustomGridControllerClass = class of TcxCustomGridController;

  TcxCustomGridController = class(TcxGridViewHandler, IcxMouseTrackingCaller,
    IcxMouseTrackingCaller2)
  private
    FCustomization: Boolean;
    FCustomizationForm: TcxCustomGridCustomizationForm;
    FCustomizationFormBounds: TRect;
    FDesignController: TcxGridDesignController;
    FHintAreaBounds: TRect;
    FHintCellViewInfo: TcxCustomGridViewCellViewInfo;
    FHintCheckerTimer: TcxTimer;
    FHintTextRect: TRect;
    FHintWindow: THintWindow;
    FIsCheckingCoordinates: Boolean;
    FIsDblClick: Boolean;
    FIsFocusing: Boolean;
    function GetDesignController: TcxGridDesignController;
    function GetDragAndDropObject: TcxCustomGridDragAndDropObject;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
    function GetDragImages: TcxDragImageList;
    function GetIsDragging: Boolean;
    function GetMouseCaptureViewInfo: TcxCustomGridCellViewInfo;
    procedure SetCustomization(Value: Boolean);
    procedure SetDragAndDropObjectClass(Value: TcxDragAndDropObjectClass);
    procedure SetMouseCaptureViewInfo(Value: TcxCustomGridCellViewInfo);
    procedure HintCheckerTimerHandler(Sender: TObject);
  protected
    { IcxMouseTrackingCaller2 }
    procedure MouseLeave; virtual;
    function PtInCaller(const P: TPoint): Boolean; virtual;

    procedure AfterPaint; virtual;
    procedure BeforeKillFocus; virtual;
    procedure BeforePaint; virtual;
    function CanFocusOnClick(X, Y: Integer): Boolean; virtual;
    function CanHandleHitTest(AHitTest: TcxCustomGridHitTest): Boolean; virtual;
    procedure CheckCoordinates; virtual;
    procedure DetailFocused(ADetail: TcxCustomGridView); virtual;
    procedure DoEnter; virtual;
    procedure DoExit; virtual;
    procedure DoSetFocus(ANotifyMaster: Boolean); virtual;
    function GetDesignControllerClass: TcxGridDesignControllerClass; virtual;
    function GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean; virtual;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; virtual;
    function GetPatternObject(AObject: TPersistent): TPersistent; virtual;
    procedure GridViewChanged; virtual;
    function IsPixelScrollBar(AKind: TScrollBarKind): Boolean; virtual;
    function MayFocus: Boolean; virtual;
    procedure RemoveFocus; virtual;
    procedure SetFocus(ANotifyMaster: Boolean); virtual;

    // customization
    procedure CheckCustomizationFormBounds(var R: TRect); virtual;
    procedure CustomizationChanged; virtual;
    function GetCustomizationFormClass: TcxCustomGridCustomizationFormClass; virtual;
    function GetRealCustomizationFormBounds: TRect;
    procedure HideCustomizationForm;
    procedure ShowCustomizationForm;

    property DragAndDropObject: TcxCustomGridDragAndDropObject read GetDragAndDropObject;
    property IsCheckingCoordinates: Boolean read FIsCheckingCoordinates;
    property IsDragging: Boolean read GetIsDragging;
    property IsFocusing: Boolean read FIsFocusing;
  public
    destructor Destroy; override;
    procedure ControlFocusChanged; virtual;
    procedure DesignerModified;
    procedure DoCancelMode; virtual;
    procedure DoCheckCoordinates;
    procedure DoControlFocusChanged;
    function GetCursor(X, Y: Integer): TCursor; virtual;
    function HasFocusedControls: Boolean; virtual;
    //function CanDrag(X, Y: Integer): Boolean; dynamic;
    //function GetDragObjectClass: TDragControlObjectClass; dynamic;

    procedure InitScrollBarsParameters; virtual;
    function IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean; virtual;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); virtual;
    procedure SetScrollBarInfo(AScrollBarKind: TScrollBarKind;
      AMin, AMax, AStep, APage, APos: Integer; AAllowShow, AAllowHide: Boolean);
    procedure UpdateScrollBars;

    procedure BeginDragAndDrop; virtual;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); virtual;
    procedure EndDragAndDrop(Accepted: Boolean); virtual;
    function StartDragAndDrop(const P: TPoint): Boolean; virtual;

    // delphi drag and drop
    procedure BeforeStartDrag; virtual;
    function CanDrag(X, Y: Integer): Boolean; virtual;
    procedure DragDrop(Source: TObject; X, Y: Integer); virtual;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); virtual;
    procedure DrawDragImage(ACanvas: TcxCanvas; R: TRect); virtual;
    procedure EndDrag(Target: TObject; X, Y: Integer); virtual;
    function GetDragImagesSize: TPoint; virtual;
    function HasDragImages: Boolean; virtual;
    procedure StartDrag(var DragObject: TDragObject); virtual;
    property DragImages: TcxDragImageList read GetDragImages;

    // hints
    function CanShowHint: Boolean; virtual;
    procedure HideHint;
    function GetHintWindowClass: THintWindowClass; virtual;
    procedure ShowHint(const AHintAreaBounds, ATextRect: TRect; const AText: string;
      AIsHintMultiLine: Boolean; AFont: TFont; AHintCellViewInfo: TcxCustomGridViewCellViewInfo);
    procedure StartHintCheckerTimer;
    procedure StopHintCheckerTimer;
    property HintCellViewInfo: TcxCustomGridViewCellViewInfo read FHintCellViewInfo;
    property HintWindow: THintWindow read FHintWindow;

    procedure DoKeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure KeyPress(var Key: Char); virtual;
    procedure KeyUp(var Key: Word; Shift: TShiftState); virtual;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;

    function ProcessDetailDialogChar(ADetail: TcxCustomGridView; ACharCode: Word): Boolean; virtual;
    function ProcessDialogChar(ACharCode: Word): Boolean; virtual;

    procedure WndProc(var Message: TMessage); virtual;

    procedure RefreshCustomizationForm;

    {procedure BeginCellMouseTracking(AViewInfo: TcxCustomGridCellViewInfo);
    procedure EndCellMouseTracking(AViewInfo: TcxCustomGridCellViewInfo);}

    property Customization: Boolean read FCustomization write SetCustomization;
    property CustomizationForm: TcxCustomGridCustomizationForm read FCustomizationForm;
    property CustomizationFormBounds: TRect read FCustomizationFormBounds
      write FCustomizationFormBounds;
    property DesignController: TcxGridDesignController read GetDesignController;
    property DragAndDropObjectClass: TcxDragAndDropObjectClass read GetDragAndDropObjectClass
      write SetDragAndDropObjectClass;
    property IsDblClick: Boolean read FIsDblClick;
    property MouseCaptureViewInfo: TcxCustomGridCellViewInfo read GetMouseCaptureViewInfo
      write SetMouseCaptureViewInfo;
  end;

  { datacontroller }

  IcxCustomGridDataController = interface
    ['{B9ABDC6B-1A4A-4F11-A629-09B6FB9FB4BA}']
    procedure AssignData(ADataController: TcxCustomDataController);
    procedure CreateAllItems;
    procedure DeleteAllItems;
    procedure GetFakeComponentLinks(AList: TList);
    function GetGridView: TcxCustomGridView;
    function IsDataChangeable: Boolean;
    function IsDataLinked: Boolean;
    function SupportsCreateAllItems: Boolean;
    property GridView: TcxCustomGridView read GetGridView;
  end;

  { painters }

  TcxCustomGridCellPainterClass = class of TcxCustomGridCellPainter;

  TcxCustomGridCellPainter = class
  private
    FCanvas: TcxCanvas;
    FViewInfo: TcxCustomGridCellViewInfo;
    function GetIsMainCanvasInUseValue: Boolean;
  protected
    procedure AfterPaint; virtual;
    procedure BeforePaint; virtual;
    function CanDrawDesignSelection: Boolean; virtual;
    procedure DoExcludeFromClipRect; virtual;
    procedure DrawBackground; overload; virtual;
    procedure DrawBackground(const R: TRect); overload; virtual;
    function DrawBackgroundHandler(ACanvas: TcxCanvas; const ABounds: TRect): Boolean; virtual;
    procedure DrawBorder(ABorder: TcxBorder); virtual;
    procedure DrawBorders; virtual;
    procedure DrawContent; virtual;
    class procedure DrawDesignSelection(ACanvas: TcxCanvas;
      AViewInfo: TcxCustomGridCellViewInfo); virtual;
    procedure DrawText; virtual;
    function ExcludeFromClipRect: Boolean; virtual;
    class function GetIsMainCanvasInUse(ACanvas: TcxCanvas; AViewInfo: TcxCustomGridCellViewInfo): Boolean;
    function NeedsPainting: Boolean; virtual;
    procedure Paint; virtual;
    procedure PrepareCanvasForDrawText; virtual;
    procedure UnprepareCanvasForDrawText; virtual;
    property Canvas: TcxCanvas read FCanvas;
    property IsMainCanvasInUse: Boolean read GetIsMainCanvasInUseValue;
    property ViewInfo: TcxCustomGridCellViewInfo read FViewInfo;
  public
    constructor Create(ACanvas: TcxCanvas; AViewInfo: TcxCustomGridCellViewInfo); virtual;
    class procedure DoDrawDesignSelection(ACanvas: TcxCanvas;
      AViewInfo: TcxCustomGridCellViewInfo); virtual;
    procedure MainPaint; virtual;
  end;

  TcxCustomGridPainterClass = class of TcxCustomGridPainter;

  TcxCustomGridPainter = class(TcxGridViewHandler)
  private
    FBackgroundRegion: TcxRegion;
    FBeforePaintClipRegion: TcxRegion;
    FCanvas: TcxCanvas;
    FViewInfo: TcxCustomGridViewInfo;
    function GetCanvas: TcxCanvas;
    function GetViewInfo: TcxCustomGridViewInfo;
  protected
    procedure DrawBackground; virtual;
    procedure PaintAfter; virtual;
    procedure PaintBefore; virtual;
    procedure PaintContent; virtual;
    property Canvas: TcxCanvas read GetCanvas write FCanvas;
    property ViewInfo: TcxCustomGridViewInfo read GetViewInfo write FViewInfo;
  public
    procedure DrawFocusRect(const R: TRect; AHideFocusRect: Boolean); virtual;
    procedure ExcludeFromBackground(const R: TRect);
    procedure Paint(ACanvas: TcxCanvas = nil; AViewInfo: TcxCustomGridViewInfo = nil);
    procedure Invalidate; overload;
    procedure Invalidate(const R: TRect); overload;
    procedure Invalidate(ARegion: TcxRegion); overload;
  end;

  { viewdata }

  TcxCustomGridViewDataClass = class of TcxCustomGridViewData;

  TcxCustomGridViewData = class(TcxGridViewHandler)
  public
    property DataController;
  end;

  { viewinfos }

  TcxGridSiteClass = class of TcxGridSite;

  TcxGridSite = class(TcxControl)
  private
    FBoundsChangedTimer: TcxTimer;
    FSize: TPoint;
    FViewInfo: TcxCustomGridViewInfo;
    function GetContainer: TcxControl;
    function GetController: TcxCustomGridController;
    function GetGridView: TcxCustomGridView;
    function GetPainter: TcxCustomGridPainter;
    procedure SendKeyDownNotification(var Message: TWMKeyDown);
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure CNSysKeyDown(var Message: TWMKeyDown); message CN_SYSKEYDOWN;
    procedure BoundsChangedTimerHandler(Sender: TObject);
  protected
    function AllowAutoDragAndDropAtDesignTime(X, Y: Integer;
      Shift: TShiftState): Boolean; override;
    function AllowDragAndDropWithoutFocus: Boolean; override;
    procedure BeforeMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure BoundsChanged; override;
    function CanDrag(X, Y: Integer): Boolean; override;
    function CanFocusOnClick(X, Y: Integer): Boolean; override;
    procedure DoCancelMode; override;
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure FocusChanged; override;
    function FocusWhenChildIsClicked(AChild: TControl): Boolean; override;
    function GetCursor(X, Y: Integer): TCursor; override;
    function GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean; override;
    function GetIsDesigning: Boolean; override;
    function GetIsFocused: Boolean; override;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; override;
    function IsPixelScrollBar(AKind: TScrollBarKind): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    function MayFocus: Boolean; override;
    procedure MouseLeave(AControl: TControl); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure RequestAlign; override;
    procedure SetParent(AParent: TWinControl); override;
    procedure WndProc(var Message: TMessage); override;

    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure DrawDragImage(ACanvas: TcxCanvas; const R: TRect); override;
    function GetDragImagesSize: TPoint; override;
    function HasDragImages: Boolean; override;

    function GetHScrollBarBounds: TRect; override;
    procedure InitScrollBarsParameters; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); override;
    procedure UpdateScrollBars; override;

    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    function StartDragAndDrop(const P: TPoint): Boolean; override;

    procedure CancelPostBoundsChanged;
    procedure InitTabStop(AParent: TWinControl);
    procedure PostBoundsChanged;
    procedure UpdateSize;

    property Controller: TcxCustomGridController read GetController;
    property Painter: TcxCustomGridPainter read GetPainter;
  public
    constructor Create(AViewInfo: TcxCustomGridViewInfo); reintroduce; virtual;
    destructor Destroy; override;
    procedure BeginDragAndDrop; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure SetFocus; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;

    property Container: TcxControl read GetContainer;
    property GridView: TcxCustomGridView read GetGridView;
    property Keys; //!!!
    property MouseCapture;
    property ViewInfo: TcxCustomGridViewInfo read FViewInfo;
  end;

  TcxCustomGridCellViewInfoClass = class of TcxCustomGridCellViewInfo;

  TcxCustomGridCellViewInfo = class(TObject, IUnknown,
    IcxMouseCaptureObject, IcxMouseTrackingCaller, IcxMouseTrackingCaller2,
    IcxCustomGridPopupOwner)
  private
    FCalculated: Boolean;
    FCalculatingParams: Boolean;
    FAlignmentHorz: TAlignment;
    FAlignmentVert: TcxAlignmentVert;
    FBorders: TcxBorders;
    FIsDestroying: Boolean;
    FLinkedHitTest: TcxCustomGridHitTest;
    FParamsCalculated: Boolean;
    FState: TcxGridCellState;
    FText: string;
    FVisible: Boolean;
    function GetBorderSize(AIndex: TcxBorder): Integer;
    function GetButtonState: TcxButtonState;
    function GetClientBounds: TRect;
    function GetContentBounds: TRect;
    function GetTextBounds: TRect;
    function GetTextHeight: Integer;
    function GetTextWidth: Integer;
    function GetTextHeightWithOffset: Integer;
    function GetTextWidthWithOffset: Integer;
    procedure SetLinkedHitTest(Value: TcxCustomGridHitTest);
    procedure SetState(Value: TcxGridCellState);
  protected
    FClientBounds: TRect;
    FContentBounds: TRect;

    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IcxMouseCaptureObject }
    procedure DoCancelMode; virtual;
    { IcxMouseTrackingCaller2 }
    procedure MouseLeave; virtual;
    function PtInCaller(const P: TPoint): Boolean; virtual;
    { IcxCustomGridPopupOwner }
    function ClosePopupWhenNilOwner: Boolean;
    function GetOwnerBounds: TRect;
    procedure PopupClosed;

    procedure AfterCalculateBounds(var ABounds: TRect); virtual;
    procedure AfterCustomDraw(ACanvas: TcxCanvas); virtual;
    procedure BeforeCustomDraw(ACanvas: TcxCanvas); virtual;
    procedure BeforeStateChange; virtual;
    function CalculateClientBounds: TRect; virtual;
    function CalculateContentBounds: TRect; virtual;
    function CalculateTextWidth(AAngle: Integer = 0): Integer;
    function CalculateTextHeight(AForPainting: Boolean; AAngle: Integer = 0): Integer;
    procedure CalculateParams;
    procedure CalculateParamsNeeded;
    function CalculateHeight: Integer; virtual;
    function CalculateWidth: Integer; virtual;
    function CaptureMouseOnPress: Boolean; virtual;
    procedure Click; virtual;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; virtual;
    function CustomDrawBackground(ACanvas: TcxCanvas): Boolean; virtual;
    procedure Destroying;
    procedure DoCalculateParams; virtual;
    procedure DoInvalidate; virtual;
    function DoCustomDraw(ACanvas: TcxCanvas): Boolean; virtual;
    function DoCustomDrawBackground(ACanvas: TcxCanvas): Boolean; virtual;
    function GetActualState: TcxGridCellState; virtual;
    function GetAlignmentHorz: TAlignment; virtual;
    function GetAlignmentVert: TcxAlignmentVert; virtual;
    function GetAreaBounds: TRect; virtual;
    function GetBackgroundBitmap: TBitmap; virtual;
    function GetBorderBounds(AIndex: TcxBorder): TRect; virtual;
    function GetBorderColor(AIndex: TcxBorder): TColor; virtual;
    function GetBorders: TcxBorders; virtual;
    function GetBorderWidth(AIndex: TcxBorder): Integer; virtual;
    function GetBounds: TRect;
    function GetCanvas: TcxCanvas; virtual; abstract;
    class function GetCellHeight(ATextHeight: Integer;
      ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer; virtual;
    function GetContentHeight: Integer; virtual;
    function GetContentWidth: Integer; virtual;
    function GetControl: TcxControl; virtual;
    function GetDesignSelectionBounds: TRect; virtual;
    function GetDesignSelectionWidth: Integer; virtual;
    function GetHeight: Integer; virtual;
    function GetHitTestClass: TcxCustomGridHitTestClass; virtual; abstract;
    function GetHotTrack: Boolean; virtual;
    function GetIsCheck: Boolean; virtual;
    function GetIsDesignSelected: Boolean; virtual;
    function GetIsVisibleForPainting: Boolean; virtual;
    function GetMouseCapture: Boolean; virtual;
    function GetMultiLine: Boolean; virtual;
    function GetMultiLinePainting: Boolean; virtual;
    function GetPainterClass: TcxCustomGridCellPainterClass; virtual;
    function GetShowEndEllipsis: Boolean; virtual;
    function GetText: string; virtual;
    function GetTextAreaBounds: TRect; virtual;
    function GetTextAttributes(AForPainting: Boolean): Integer; virtual;
    function GetTextCellHeight(AGridViewInfo: TcxCustomGridViewInfo;
      ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer; virtual;
    function GetTextForPainting: string; virtual;
    function GetTransparent: Boolean; virtual;
    procedure GetViewParams(var AParams: TcxViewParams); virtual;
    function GetVisible: Boolean; virtual;
    function GetVisibleForHitTest: Boolean; virtual;
    function GetWidth: Integer; virtual;
    function HasBackground: Boolean; virtual;
    function HasCustomDraw: Boolean; virtual;
    function HasCustomDrawBackground: Boolean; virtual;
    function HasHitTestPoint(const P: TPoint): Boolean; virtual;
    function HasMouse(AHitTest: TcxCustomGridHitTest): Boolean; virtual;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); virtual;
    function InvalidateOnStateChange: Boolean; virtual;
    procedure Offset(DX, DY: Integer); virtual;
    procedure RestoreParams(const AParams: TcxViewParams); virtual;
    procedure SaveParams(out AParams: TcxViewParams); virtual;
    procedure SetHeight(Value: Integer); virtual;
    procedure SetMouseCapture(Value: Boolean); virtual;
    procedure SetWidth(Value: Integer); virtual;
    procedure StateChanged; virtual;

    procedure DropDown; virtual;
    procedure CloseUp; virtual;
    function ClosePopupOnDestruction: Boolean; virtual;
    function DropDownWindowExists: Boolean; virtual;
    function GetDropDownWindow: TcxCustomGridPopup; virtual;
    function GetDropDownWindowOwnerBounds: TRect; virtual;
    property DropDownWindow: TcxCustomGridPopup read GetDropDownWindow;

    property BorderWidth[AIndex: TcxBorder]: Integer read GetBorderWidth;
    property CalculatingParams: Boolean read FCalculatingParams;
    property Canvas: TcxCanvas read GetCanvas;
    property Control: TcxControl read GetControl;
    property DesignSelectionBounds: TRect read GetDesignSelectionBounds;
    property DesignSelectionWidth: Integer read GetDesignSelectionWidth;
    property HotTrack: Boolean read GetHotTrack;
    property IsCheck: Boolean read GetIsCheck;
    property IsDesignSelected: Boolean read GetIsDesignSelected;
    property IsDestroying: Boolean read FIsDestroying;
    property IsVisibleForPainting: Boolean read GetIsVisibleForPainting;
    property LinkedHitTest: TcxCustomGridHitTest read FLinkedHitTest write SetLinkedHitTest;
    property ShowEndEllipsis: Boolean read GetShowEndEllipsis;
    property TextBounds: TRect read GetTextBounds;
  public
    Bounds: TRect;
    MultiLine: Boolean;
    MultiLinePainting: Boolean;
    Params: TcxViewParams;

    constructor Create;
    destructor Destroy; override;
    procedure AfterRecalculation; virtual;
    procedure BeforeDestruction; override;
    procedure BeforeRecalculation; virtual;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); overload; virtual;
    procedure Calculate(const ABounds: TRect); overload; virtual;
    function GetAreaBoundsForPainting: TRect; virtual;
    function GetBestFitWidth: Integer; virtual;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; virtual;
    function HasPoint(const P: TPoint): Boolean; virtual;
    procedure Invalidate; virtual;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; virtual;
    function MouseMove(AHitTest: TcxCustomGridHitTest; AShift: TShiftState): Boolean; virtual;
    function MouseUp(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; virtual;
    procedure DoOffset(DX, DY: Integer);
    procedure Paint(ACanvas: TcxCanvas = nil); virtual;
    procedure Recalculate;
    procedure ResetContentBounds;

    property ActualState: TcxGridCellState read GetActualState;
    property AlignmentHorz: TAlignment read FAlignmentHorz write FAlignmentHorz;
    property AlignmentVert: TcxAlignmentVert read FAlignmentVert write FAlignmentVert;
    property BackgroundBitmap: TBitmap read GetBackgroundBitmap;
    property BorderBounds[AIndex: TcxBorder]: TRect read GetBorderBounds;
    property BorderColor[AIndex: TcxBorder]: TColor read GetBorderColor;
    property BorderSize[AIndex: TcxBorder]: Integer read GetBorderSize;
    property Borders: TcxBorders read FBorders write FBorders;
    property ButtonState: TcxButtonState read GetButtonState;
    property Calculated: Boolean read FCalculated write FCalculated;
    property ClientBounds: TRect read GetClientBounds;
    property ContentBounds: TRect read GetContentBounds;
    property ContentHeight: Integer read GetContentHeight;
    property ContentWidth: Integer read GetContentWidth;
    property Height: Integer read GetHeight write SetHeight;
    property MouseCapture: Boolean read GetMouseCapture write SetMouseCapture;
    property State: TcxGridCellState read FState write SetState;
    property Text: string read FText write FText;
    property TextForPainting: string read GetTextForPainting;
    property TextHeightWithOffset: Integer read GetTextHeightWithOffset;
    property TextWidthWithOffset: Integer read GetTextWidthWithOffset;
    property TextHeight: Integer read GetTextHeight;
    property TextWidth: Integer read GetTextWidth;
    property TextAreaBounds: TRect read GetTextAreaBounds;
    property Transparent: Boolean read GetTransparent;
    property Visible: Boolean read GetVisible write FVisible;
    property VisibleForHitTest: Boolean read GetVisibleForHitTest;
    property Width: Integer read GetWidth write SetWidth;
  end;

  TcxCustomGridViewCellViewInfo = class(TcxCustomGridCellViewInfo)
  private
    FGridViewInfo: TcxCustomGridViewInfo;
    function GetController: TcxCustomGridController;
    function GetGridView: TcxCustomGridView;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
  protected
    procedure AfterCalculateBounds(var ABounds: TRect); override;
    procedure DoInvalidate; override;
    function EmulateMouseMoveAfterCalculate: Boolean; virtual;
    function GetCanvas: TcxCanvas; override;
    function GetControl: TcxControl; override;
    function HasMouse(AHitTest: TcxCustomGridHitTest): Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;

    function CanShowHint: Boolean; virtual;
    procedure CheckHint(AHitTest: TcxCustomGridHitTest);
    function GetAreaBoundsForHint: TRect; virtual;
    function GetBoundsForHint: TRect;
    function GetCellBoundsForHint: TRect; virtual;
    function GetHintText: string; virtual;
    function GetHintTextRect(const AMousePos: TPoint): TRect; virtual;
    function HasHintPoint(const P: TPoint): Boolean; virtual;
    procedure InitHint(const AMousePos: TPoint; out AHintText: TCaption;
      out AIsHintMultiLine: Boolean; out ATextRect: TRect); virtual;
    function IsHintForText: Boolean; virtual;
    function IsHintMultiLine: Boolean; virtual;
    function NeedShowHint(const AMousePos: TPoint; out AHintText: TCaption;
      out AIsHintMultiLine: Boolean; out ATextRect: TRect): Boolean; virtual;

    property Controller: TcxCustomGridController read GetController;
    property HintText: string read GetHintText;
  public
    constructor Create(AGridViewInfo: TcxCustomGridViewInfo); virtual;
    destructor Destroy; override;
    procedure Invalidate; override;
    function MouseMove(AHitTest: TcxCustomGridHitTest; AShift: TShiftState): Boolean; override;
    property GridView: TcxCustomGridView read GetGridView;
    property GridViewInfo: TcxCustomGridViewInfo read FGridViewInfo;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  end;

  TcxCustomGridViewInfoClass = class of TcxCustomGridViewInfo;

  TcxCustomGridViewInfo = class(TcxGridViewHandler)
  private
    FActiveViewInfos: TList;
    FAllowCheckCoordinates: Boolean;
    FAllowHideSite: Boolean;
    FBounds: TRect;
    FClientBounds: TRect;
    FClientBoundsAssigned: Boolean;
    FIsCalculating: Boolean;
    FIsInternalUse: Boolean;
    FLock: TRTLCriticalSection;
    FMousePos: TPoint;
    FSite: TcxGridSite;
    FSizeCalculating: Boolean;
    FVisibilityChanging: Boolean;

    function GetCalculated: Boolean;
    function GetCanvas: TcxCanvas;
    function GetClientBounds: TRect;
    function GetClientHeight: Integer;
    function GetClientWidth: Integer;
    //function GetIsCalculating: Boolean;
    function GetIsInternalUseValue: Boolean;
    procedure SetClientBounds(const Value: TRect);
  protected
    procedure CreateViewInfos; virtual;
    procedure DestroyViewInfos(AIsRecreating: Boolean); virtual;
    procedure RecreateViewInfos; virtual;

    function CanHideSite: Boolean; virtual;
    procedure CreateSite;
    procedure DestroySite;
    function GetSiteClass: TcxGridSiteClass; virtual;
    function GetSiteParent: TWinControl;

    procedure AddActiveViewInfo(AViewInfo: TObject);
    function IsViewInfoActive(AViewInfo: TObject): Boolean;
    procedure RemoveActiveViewInfo(AViewInfo: TObject; ARemoveAll: Boolean = False);

    procedure AddScrollBarHeight(var AHeight: Integer);
    procedure AfterCalculating; virtual;
    procedure BeforeCalculating; virtual;
    procedure Calculate; virtual;
    function CalculateClientBounds: TRect; virtual;
    procedure CalculateHeight(const AMaxSize: TPoint; var AHeight: Integer;
      var AFullyVisible: Boolean); virtual;
    procedure CalculateWidth(const AMaxSize: TPoint; var AWidth: Integer); virtual;
    function CanCheckCoordinates: Boolean; virtual;
    procedure ControlFocusChanged; virtual;
    function DoGetHitTest(const P: TPoint): TcxCustomGridHitTest; virtual;
    function GetAllowBoundsChangedNotification: Boolean; virtual;
    function GetBackgroundBitmap: TBitmap; virtual;
    function GetBackgroundColor: TColor; virtual;
    //function GetContentBounds: TRect; virtual;
    procedure GetHScrollBarBounds(var ABounds: TRect); virtual;
    function GetIsInternalUse: Boolean; virtual;
    function GetVisible: Boolean; virtual;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); virtual;
    procedure UpdateMousePos;
    procedure VisibilityChanged(AVisible: Boolean); virtual;

    property AllowBoundsChangedNotification: Boolean read GetAllowBoundsChangedNotification;
    property AllowCheckCoordinates: Boolean read FAllowCheckCoordinates write FAllowCheckCoordinates;
    property ClientBoundsAssigned: Boolean read FClientBoundsAssigned write FClientBoundsAssigned;
    property SizeCalculating: Boolean read FSizeCalculating;
    property VisibilityChanging: Boolean read FVisibilityChanging;
    property Visible: Boolean read GetVisible;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure DoVisibilityChanged(AVisible: Boolean);
    function GetFontHeight(AFont: TFont): Integer;
    procedure GetFontMetrics(AFont: TFont; out AMetrics: TTextMetric);
    procedure GetHeight(const AMaxSize: TPoint; var AHeight: Integer;
      var AFullyVisible: Boolean);                                      
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; overload; virtual;
    function GetHitTest(X, Y: Integer): TcxCustomGridHitTest; overload; virtual;
    procedure GetWidth(const AMaxSize: TPoint; var AWidth: Integer);
    procedure MainCalculate(const ABounds: TRect);
    procedure Recalculate;

    property AllowHideSite: Boolean read FAllowHideSite write FAllowHideSite;
    property BackgroundColor: TColor read GetBackgroundColor;
    property BackgroundBitmap: TBitmap read GetBackgroundBitmap;
    property Bounds: TRect read FBounds;
    property Calculated: Boolean read GetCalculated;
    property Canvas: TcxCanvas read GetCanvas;
    property ClientBounds: TRect read GetClientBounds write SetClientBounds;
    property ClientHeight: Integer read GetClientHeight;
    property ClientWidth: Integer read GetClientWidth;
    //property ContentBounds: TRect read GetContentBounds;
    property IsCalculating: Boolean read FIsCalculating;
    property IsInternalUse: Boolean read GetIsInternalUseValue write FIsInternalUse;
    property MousePos: TPoint read FMousePos;
    property Site: TcxGridSite read FSite;
  end;

  TcxCustomGridViewInfoCacheItemClass = class of TcxCustomGridViewInfoCacheItem;

  TcxCustomGridViewInfoCacheItem = class
  private
    FIndex: Integer;
    FOwner: TcxCustomGridViewInfoCache;
  protected
    property Index: Integer read FIndex;
    property Owner: TcxCustomGridViewInfoCache read FOwner;
  public
    constructor Create(AOwner: TcxCustomGridViewInfoCache; AIndex: Integer); virtual;
    procedure UnassignValues(AKeepMaster: Boolean); virtual;
  end;

  TcxCustomGridViewInfoCacheClass = class of TcxCustomGridViewInfoCache;

  TcxCustomGridViewInfoCache = class(TcxGridViewHandler)
  private
    FItems: TList;
    FUnassigningValues: Boolean;
    function GetCount: Integer;
    function GetInternalItem(Index: Integer): TcxCustomGridViewInfoCacheItem;
    function GetItem(Index: Integer): TcxCustomGridViewInfoCacheItem;
    procedure SetCount(Value: Integer);
    procedure DestroyItems;
  protected
    function GetItemClass(Index: Integer): TcxCustomGridViewInfoCacheItemClass; virtual; abstract;
    property InternalItems[Index: Integer]: TcxCustomGridViewInfoCacheItem read GetInternalItem;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure UnassignValues(AKeepMaster: Boolean = False); virtual;
    property Count: Integer read GetCount write SetCount;
    property Items[Index: Integer]: TcxCustomGridViewInfoCacheItem read GetItem; default;
  end;

  { custom view }

  TcxGridViewChangeKind = (vcProperty, vcLayout, vcSize);

  TcxCustomGridOptions = class(TcxInterfacedPersistent)
  private
    FGridView: TcxCustomGridView;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
  protected
    procedure Changed(AChangeKind: TcxGridViewChangeKind); virtual;
    function GetGridViewValue: TcxCustomGridView; virtual;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); virtual;

    procedure GetStoredProperties(AProperties: TStrings); virtual;
    procedure GetStoredPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetStoredPropertyValue(const AName: string; const AValue: Variant); virtual;

    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  public
    constructor Create(AGridView: TcxCustomGridView); reintroduce; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property GridView: TcxCustomGridView read GetGridViewValue;
  end;

  TcxCustomGridBackgroundBitmapsClass = class of TcxCustomGridBackgroundBitmaps;

  TcxCustomGridBackgroundBitmaps = class(TcxCustomGridOptions)
  private
    FItems: TList;
    function GetCount: Integer;
    procedure BitmapChanged(Sender: TObject);
  protected
    function GetBitmapStyleIndex(Index: Integer): Integer; virtual;
    function GetDefaultBitmap(Index: Integer): TBitmap; virtual;
    function GetValue(Index: Integer): TBitmap;
    procedure SetValue(Index: Integer; Value: TBitmap);
    property Count: Integer read GetCount;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetBitmap(Index: Integer): TBitmap; virtual;
    property Values[Index: Integer]: TBitmap read GetValue write SetValue; default;
  published
    property Background: TBitmap index bbBackground read GetValue write SetValue;
  end;

  TcxCustomGridOptionsBehaviorClass = class of TcxCustomGridOptionsBehavior;

  TcxCustomGridOptionsBehavior = class(TcxCustomGridOptions)
  private
    FPostponedSynchronization: Boolean;
    function GetPostponedSynchronization: Boolean;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
  published
    property PostponedSynchronization: Boolean read GetPostponedSynchronization
      write FPostponedSynchronization default True;  // should be published in all descendants
  end;

  TcxCustomGridOptionsDataClass = class of TcxCustomGridOptionsData;

  TcxCustomGridOptionsData = class(TcxCustomGridOptions);

  TcxCustomGridOptionsSelectionClass = class of TcxCustomGridOptionsSelection;

  TcxCustomGridOptionsSelection = class(TcxCustomGridOptions);

  TcxCustomGridOptionsViewClass = class of TcxCustomGridOptionsView;

  TcxCustomGridOptionsView = class(TcxCustomGridOptions)
  private
    function GetScrollBars: TScrollStyle;
    procedure SetScrollBars(Value: TScrollStyle);
  protected
    property ScrollBars: TScrollStyle read GetScrollBars write SetScrollBars default ssBoth;
  public
    procedure Assign(Source: TPersistent); override;
  end;

  TcxCustomGridStyles = class(TcxStyles)
  private
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
  protected
    procedure Changed(AIndex: Integer); override;
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    procedure GetFakeComponentLinks(AList: TList); virtual;
    function GetGridView: TcxCustomGridView; virtual; abstract;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  public
    property GridView: TcxCustomGridView read GetGridView;
  end;

  TcxCustomGridViewStylesClass = class of TcxCustomGridViewStyles;

  TcxCustomGridViewStyles = class(TcxCustomGridStyles)
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    function GetGridView: TcxCustomGridView; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Background: TcxStyle index vsBackground read GetValue write SetValue;
  end;

  TcxGridListenerLink = class
  private
    FGridView: TcxCustomGridView;
  public
    constructor Create(AGridView: TcxCustomGridView);
    destructor Destroy; override;
    procedure Clear;
    property GridView: TcxCustomGridView read FGridView;
  end;

  TcxGridStorageOption = (gsoUseFilter, gsoUseSummary);
  TcxGridStorageOptions = set of TcxGridStorageOption;
  TcxGridViewChangeNotificationKind = (vcnName{, vsRemoved});

  TcxGridInitStoredObjectEvent = procedure(Sender: TcxCustomGridView; AObject: TObject) of object;
  TcxGridViewGetStoredPropertiesEvent = procedure(Sender: TcxCustomGridView;
    AProperties: TStrings) of object;
  TcxGridViewGetStoredPropertyValueEvent = procedure(Sender: TcxCustomGridView;
    const AName: string; var AValue: Variant) of object;
  TcxGridViewSetStoredPropertyValueEvent = procedure(Sender: TcxCustomGridView;
    const AName: string; const AValue: Variant) of object;

  TcxCustomGridViewClass = class of TcxCustomGridView;

  TcxCustomGridView = class(TcxControlChildComponent, IcxStoredObject, IcxStoredParent,
    IcxGridViewLayoutEditorSupport, IcxGridViewDesignerMenu)
  private
    FAssigningPattern: Boolean;
    FBackgroundBitmaps: TcxCustomGridBackgroundBitmaps;
    FClones: TList;
    FController: TcxCustomGridController;
    FIsRestoring: Boolean;
    FIsSynchronizing: Boolean;
    FLevel: TComponent;
    FListenerLinks: TList;
    FOptionsList: TList;
    FOptionsBehavior: TcxCustomGridOptionsBehavior;
    FOptionsData: TcxCustomGridOptionsData;
    FOptionsSelection: TcxCustomGridOptionsSelection;
    FOptionsView: TcxCustomGridOptionsView;
    FPainter: TcxCustomGridPainter;
    FPatternGridView: TcxCustomGridView;
    FRepository: TComponent;
    FStorageControl: TcxControl;
    FStorageOptions: TcxGridStorageOptions;
    FStoredVersion: Integer;
    FStoringName: string;
    FStyles: TcxCustomGridStyles;
    FSynchronization: Boolean;
    FSynchronizationAssignNeeded: Boolean;
    FSynchronizationNeeded: Boolean;
    FUpdateLockCount: Integer;
    FViewData: TcxCustomGridViewData;
    FViewInfo: TcxCustomGridViewInfo;
    FViewInfoCache: TcxCustomGridViewInfoCache;
    FOnCustomization: TNotifyEvent;
    FOnGetStoredProperties: TcxGridViewGetStoredPropertiesEvent;
    FOnGetStoredPropertyValue: TcxGridViewGetStoredPropertyValueEvent;
    FOnInitStoredObject: TcxGridInitStoredObjectEvent;
    FOnSetStoredPropertyValue: TcxGridViewSetStoredPropertyValueEvent;

    function GetClone(Index: Integer): TcxCustomGridView;
    function GetCloneCount: Integer;
    function GetDragMode: TDragMode;
    function GetFocused: Boolean;
    function GetIsDetail: Boolean;
    function GetIsMaster: Boolean;
    function GetIsPattern: Boolean;
    function GetIsStoringNameMode: Boolean;
    function GetIsUpdating: Boolean;
    function GetLookAndFeel: TcxLookAndFeel;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
    function GetMasterGridView: TcxCustomGridView;
    function GetMasterGridRecordIndex: Integer;
    function GetMasterRecordIndex: Integer;
    function GetOnDblClick: TNotifyEvent;
    function GetOnDragDrop: TDragDropEvent;
    function GetOnDragOver: TDragOverEvent;
    function GetOnEndDrag: TEndDragEvent;
    function GetOnKeyDown: TKeyEvent;
    function GetOnKeyPress: TKeyPressEvent;
    function GetOnKeyUp: TKeyEvent;
    function GetOnMouseDown: TMouseEvent;
    function GetOnMouseEnter: TNotifyEvent;
    function GetOnMouseLeave: TNotifyEvent;
    function GetOnMouseMove: TMouseMoveEvent;
    function GetOnMouseUp: TMouseEvent;
    function GetOnMouseWheel: TMouseWheelEvent;
    function GetOnMouseWheelDown: TMouseWheelUpDownEvent;
    function GetOnMouseWheelUp: TMouseWheelUpDownEvent;
    function GetOnStartDrag: TStartDragEvent;
    function GetPatternGridView: TcxCustomGridView;
    function GetPopupMenu: TComponent;
    function GetSite: TcxGridSite;
    function GetSynchronization: Boolean;
    procedure SetBackgroundBitmaps(Value: TcxCustomGridBackgroundBitmaps);
    procedure SetDragMode(Value: TDragMode);
    procedure SetFocused(Value: Boolean);
    procedure SetIsRestoring(Value: Boolean);
    procedure SetSynchronization(Value: Boolean);
    procedure SetOnCustomization(Value: TNotifyEvent);
    procedure SetOnDblClick(Value: TNotifyEvent);
    procedure SetOnDragDrop(Value: TDragDropEvent);
    procedure SetOnDragOver(Value: TDragOverEvent);
    procedure SetOnEndDrag(Value: TEndDragEvent);
    procedure SetOnGetStoredProperties(Value: TcxGridViewGetStoredPropertiesEvent);
    procedure SetOnGetStoredPropertyValue(Value: TcxGridViewGetStoredPropertyValueEvent);
    procedure SetOnInitStoredObject(Value: TcxGridInitStoredObjectEvent);
    procedure SetOnKeyDown(Value: TKeyEvent);
    procedure SetOnKeyPress(Value: TKeyPressEvent);
    procedure SetOnKeyUp(Value: TKeyEvent);
    procedure SetOnMouseDown(Value: TMouseEvent);
    procedure SetOnMouseEnter(Value: TNotifyEvent);
    procedure SetOnMouseLeave(Value: TNotifyEvent);
    procedure SetOnMouseMove(Value: TMouseMoveEvent);
    procedure SetOnMouseUp(Value: TMouseEvent);
    procedure SetOnMouseWheel(Value: TMouseWheelEvent);
    procedure SetOnMouseWheelDown(Value: TMouseWheelUpDownEvent);
    procedure SetOnMouseWheelUp(Value: TMouseWheelUpDownEvent);
    procedure SetOnSetStoredPropertyValue(Value: TcxGridViewSetStoredPropertyValueEvent);
    procedure SetOnStartDrag(Value: TStartDragEvent);
    procedure SetOptionsBehavior(Value: TcxCustomGridOptionsBehavior);
    procedure SetOptionsData(Value: TcxCustomGridOptionsData);
    procedure SetOptionsSelection(Value: TcxCustomGridOptionsSelection);
    procedure SetOptionsView(Value: TcxCustomGridOptionsView);
    procedure SetPopupMenu(Value: TComponent);
    procedure SetStyles(Value: TcxCustomGridStyles);

    procedure ClearListenerLinks;
  protected
    FDataController: TcxCustomDataController;
    FSubClassEvents: TNotifyEvent;
    // IcxStoredObject
    function GetObjectName: string; virtual;
    function GetProperties(AProperties: TStrings): Boolean; virtual;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;
    // IcxStoredParent
    function CreateChild(const AObjectName, AClassName: string): TObject;
    function CreateStoredObject(const AObjectName, AClassName: string): TObject; virtual;
    procedure DeleteChild(const AObjectName: string; AObject: TObject); virtual;
    procedure IcxStoredParent.GetChildren = GetStoredChildren;
    procedure GetStoredChildren(AChildren: TStringList); virtual;
    // IcxGridViewLayoutEditorSupport - for design-time layout editor
    procedure AssignLayout(ALayoutView: TcxCustomGridView); virtual;
    procedure BeforeEditLayout(ALayoutView: TcxCustomGridView); virtual;
    procedure DoAssignLayout(ALayoutView: TcxCustomGridView);
    function GetLayoutCustomizationFormButtonCaption: string; virtual;
    function HasLayoutCustomizationForm: Boolean; virtual;
    function IsLayoutChangeable: Boolean; virtual;
    procedure RunLayoutCustomizationForm; virtual;
    // IcxGridViewDesignerMenu
    procedure DoMenuItemAction(AIndex: Integer; var AModified: Boolean); virtual;
    function GetMenuItemAction(AIndex: Integer): TcxGridViewDesignerMenuItemAction; virtual;
    function GetMenuItemCount: Integer; virtual;
    function GetMenuItemObject(AIndex: Integer): TObject; virtual;
    procedure PrepareMenuItem(AIndex: Integer; AMenuItem: TMenuItem); virtual;

    procedure GetFakeComponentLinks(AList: TList); override;
    function GetIsDestroying: Boolean; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetControl(Value: TcxControl); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure Updated; override;
    procedure Updating; override;

    procedure CreateHandlers; virtual;
    procedure DestroyHandlers; virtual;
    procedure InitDataController; virtual;

    procedure CreateOptions; virtual;
    procedure DestroyOptions; virtual;

    procedure AddOptions(AOptions: TcxCustomGridOptions);
    procedure RemoveOptions(AOptions: TcxCustomGridOptions);
    procedure NotifyOptions(AComponent: TComponent; AOperation: TOperation);

    procedure AddClone(AClone: TcxCustomGridView);
    procedure RemoveClone(AClone: TcxCustomGridView);

    function AddListenerLink: TcxGridListenerLink;
    procedure RemoveListenerLink(ALink: TcxGridListenerLink);

    procedure AssignPattern(APattern: TcxCustomGridView);

    procedure Synchronize(ACheckUpdateLock: Boolean = True); overload;
    procedure Synchronize(AView: TcxCustomGridView); overload;
    property SynchronizationAssignNeeded: Boolean read FSynchronizationAssignNeeded;
    property SynchronizationNeeded: Boolean read FSynchronizationNeeded;

    procedure BeforeAssign(ASource: TcxCustomGridView); virtual;
    procedure DoAssign(ASource: TcxCustomGridView); virtual;
    procedure AfterAssign(ASource: TcxCustomGridView); virtual;

    procedure BeforeRestoring; virtual;
    procedure AfterRestoring; virtual;
    property IsRestoring: Boolean read FIsRestoring write SetIsRestoring;

    //procedure BeforeLevelChange; virtual;
    function CanFocus: Boolean; virtual;
    function CanTabStop: Boolean; virtual;
    procedure DetailDataChanged(ADetail: TcxCustomGridView); virtual;
    procedure DetailVisibleChanged(ADetailLevel: TComponent;
      APrevVisibleDetailCount, AVisibleDetailCount: Integer); virtual;
    procedure DoChanged(AChangeKind: TcxGridViewChangeKind); virtual;
    function GetChangeable: Boolean; virtual;
    function GetCustomVisible(ALevelVisible: Boolean): Boolean; virtual;
    function GetIsControlFocused: Boolean; virtual;
    function GetResizeOnBoundsChange: Boolean; virtual;
    function GetVisible: Boolean; virtual;
    procedure Init; virtual;
    function IsDetailVisible(AGridView: TcxCustomGridView): Boolean; virtual;
    procedure FocusChanged(AFocused: Boolean); virtual;
    procedure LoadingComplete; virtual;
    procedure LookAndFeelChanged; virtual;
    procedure NotifyControl(AChangeKind: TcxGridViewChangeNotificationKind);
    procedure RestoringComplete; virtual;
    procedure SetLevel(Value: TComponent); virtual;
    procedure SetTabStop(Value: Boolean); virtual;
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); virtual;

    function GetControllerClass: TcxCustomGridControllerClass; virtual; abstract;
    function GetDataControllerClass: TcxCustomDataControllerClass; virtual; abstract;
    function GetPainterClass: TcxCustomGridPainterClass; virtual; abstract;
    function GetViewDataClass: TcxCustomGridViewDataClass; virtual; abstract;
    function GetViewInfoCacheClass: TcxCustomGridViewInfoCacheClass; virtual;
    function GetViewInfoClass: TcxCustomGridViewInfoClass; virtual; abstract;

    function GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass; virtual;
    function GetOptionsBehaviorClass: TcxCustomGridOptionsBehaviorClass; virtual;
    function GetOptionsDataClass: TcxCustomGridOptionsDataClass; virtual;
    function GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass; virtual;
    function GetOptionsViewClass: TcxCustomGridOptionsViewClass; virtual;
    function GetStylesClass: TcxCustomGridViewStylesClass; virtual;

    procedure Initialize; override;

    procedure RefreshCustomizationForm;

    procedure DoCustomization; virtual;
    procedure DoInitStoredObject(AObject: TObject); virtual;

    property AssigningPattern: Boolean read FAssigningPattern;
    property BackgroundBitmaps: TcxCustomGridBackgroundBitmaps read FBackgroundBitmaps
      write SetBackgroundBitmaps;  {4}
    property Changeable: Boolean read GetChangeable;
    property IsStoringNameMode: Boolean read GetIsStoringNameMode;
    property IsSynchronizing: Boolean read FIsSynchronizing;
    property IsUpdating: Boolean read GetIsUpdating;
    property OptionsBehavior: TcxCustomGridOptionsBehavior read FOptionsBehavior
      write SetOptionsBehavior;
    property OptionsData: TcxCustomGridOptionsData read FOptionsData write SetOptionsData;
    property OptionsSelection: TcxCustomGridOptionsSelection read FOptionsSelection
      write SetOptionsSelection;
    property OptionsView: TcxCustomGridOptionsView read FOptionsView write SetOptionsView;
    property ResizeOnBoundsChange: Boolean read GetResizeOnBoundsChange;
    property StoredVersion: Integer read FStoredVersion;
    property Styles: TcxCustomGridStyles read FStyles write SetStyles;
    property OnCustomization: TNotifyEvent read FOnCustomization write SetOnCustomization;
    property OnInitStoredObject: TcxGridInitStoredObjectEvent read FOnInitStoredObject write SetOnInitStoredObject;
  public
    constructor CreateCloned(AControl: TcxControl); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    function HasAsClone(AGridView: TcxCustomGridView): Boolean;
    function HasAsMaster(AGridView: TcxCustomGridView): Boolean;
    procedure Invalidate(AHardUpdate: Boolean = False);
    procedure RestoreDefaults; virtual;
    procedure SetParentComponent(Value: TComponent); override;

    procedure CheckSynchronizationAssignNeeded;
    function IsSynchronization: Boolean;

    procedure BeginUpdate;
    procedure CancelUpdate;
    function Changed(AGridChange: TObject): Boolean; overload; {$IFDEF BCB}virtual;{$ENDIF}
    procedure EndUpdate;
    function IsUpdateLocked: Boolean;

    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; overload; {$IFDEF BCB}virtual;{$ENDIF}
    function GetHitTest(X, Y: Integer): TcxCustomGridHitTest; overload; {$IFDEF BCB}virtual;{$ENDIF}

    procedure BoundsChanged(AUpdateSelfOnly: Boolean = False; AKeepMaster: Boolean = False); virtual;
    procedure Changed(AChangeKind: TcxGridViewChangeKind); overload; {$IFDEF BCB}virtual;{$ENDIF}
    procedure LayoutChanged(AUpdateSelfOnly: Boolean = True);
    function SizeChanged(AUpdateSelfOnly: Boolean = False; AKeepMaster: Boolean = False): Boolean;
    procedure ViewChanged; overload; {$IFDEF BCB}virtual;{$ENDIF}
    procedure ViewChanged(const AUpdateRect: TRect); overload; {$IFDEF BCB}virtual;{$ENDIF}
    procedure ViewChanged(ARegion: TcxRegion); overload; {$IFDEF BCB}virtual;{$ENDIF}

    procedure RestoreFromIniFile(const AStorageName: string; AChildrenCreating: Boolean = True{False};
      AChildrenDeleting: Boolean = False; AOptions: TcxGridStorageOptions = [gsoUseFilter, gsoUseSummary]{[]};
      const ARestoreViewName: string = '');
    procedure RestoreFromRegistry(const AStorageName: string; AChildrenCreating: Boolean = True{False};
      AChildrenDeleting: Boolean = False; AOptions: TcxGridStorageOptions = [gsoUseFilter, gsoUseSummary]{[]};
      const ARestoreViewName: string = '');
    procedure RestoreFromStream(AStream: TStream; AChildrenCreating: Boolean = True{False};
      AChildrenDeleting: Boolean = False; AOptions: TcxGridStorageOptions = [gsoUseFilter, gsoUseSummary]{[]};
      const ARestoreViewName: string = '');
    procedure StoreToIniFile(const AStorageName: string; AReCreate: Boolean = True;
      AOptions: TcxGridStorageOptions = []; const ASaveViewName: string = '');
    procedure StoreToRegistry(const AStorageName: string; AReCreate: Boolean = True;
      AOptions: TcxGridStorageOptions = []; const ASaveViewName: string = '');
    procedure StoreToStream(AStream: TStream; AOptions: TcxGridStorageOptions = [];
      const ASaveViewName: string = '');

    function CreateViewInfo: TcxCustomGridViewInfo;

    property Focused: Boolean read GetFocused write SetFocused;
    property StorageOptions: TcxGridStorageOptions read FStorageOptions write FStorageOptions;
    property StoringName: string read FStoringName write FStoringName;
    property TabStop: Boolean write SetTabStop;

    property CloneCount: Integer read GetCloneCount;
    property Clones[Index: Integer]: TcxCustomGridView read GetClone;
    property IsControlFocused: Boolean read GetIsControlFocused;
    property IsDetail: Boolean read GetIsDetail;
    property IsMaster: Boolean read GetIsMaster;
    property IsPattern: Boolean read GetIsPattern;
    property Level: TComponent read FLevel;  // TcxGridLevel
    property MasterGridView: TcxCustomGridView read GetMasterGridView;
    property MasterGridRecordIndex: Integer read GetMasterGridRecordIndex;
    property MasterRecordIndex: Integer read GetMasterRecordIndex;
    property PatternGridView: TcxCustomGridView read GetPatternGridView;
    property Repository: TComponent read FRepository write FRepository;  {5}

    property Controller: TcxCustomGridController read FController;
    property DataController: TcxCustomDataController read FDataController;
    property LookAndFeel: TcxLookAndFeel read GetLookAndFeel;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
    property Painter: TcxCustomGridPainter read FPainter;
    property Site: TcxGridSite read GetSite;
    property StorageControl: TcxControl read FStorageControl;
    property ViewData: TcxCustomGridViewData read FViewData;
    property ViewInfo: TcxCustomGridViewInfo read FViewInfo;
    property ViewInfoCache: TcxCustomGridViewInfoCache read FViewInfoCache;
    property Visible: Boolean read GetVisible;
  published
    property DataControllerEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;
    property DragMode: TDragMode read GetDragMode write SetDragMode default dmManual;
    property PopupMenu: TComponent read GetPopupMenu write SetPopupMenu;
    property StylesEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;
    property Synchronization: Boolean read GetSynchronization write SetSynchronization default True{False};

    property OnDblClick: TNotifyEvent read GetOnDblClick write SetOnDblClick;
    property OnDragDrop: TDragDropEvent read GetOnDragDrop write SetOnDragDrop;
    property OnDragOver: TDragOverEvent read GetOnDragOver write SetOnDragOver;
    property OnEndDrag: TEndDragEvent read GetOnEndDrag write SetOnEndDrag;
    property OnKeyDown: TKeyEvent read GetOnKeyDown write SetOnKeyDown;
    property OnKeyPress: TKeyPressEvent read GetOnKeyPress write SetOnKeyPress;
    property OnKeyUp: TKeyEvent read GetOnKeyUp write SetOnKeyUp;
    property OnMouseDown: TMouseEvent read GetOnMouseDown write SetOnMouseDown;
    property OnMouseEnter: TNotifyEvent read GetOnMouseEnter write SetOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read GetOnMouseLeave write SetOnMouseLeave;
    property OnMouseMove: TMouseMoveEvent read GetOnMouseMove write SetOnMouseMove;
    property OnMouseUp: TMouseEvent read GetOnMouseUp write SetOnMouseUp;
    property OnMouseWheel: TMouseWheelEvent read GetOnMouseWheel write SetOnMouseWheel;
    property OnMouseWheelDown: TMouseWheelUpDownEvent read GetOnMouseWheelDown write SetOnMouseWheelDown;
    property OnMouseWheelUp: TMouseWheelUpDownEvent read GetOnMouseWheelUp write SetOnMouseWheelUp;
    property OnStartDrag: TStartDragEvent read GetOnStartDrag write SetOnStartDrag;

    property OnGetStoredProperties: TcxGridViewGetStoredPropertiesEvent
      read FOnGetStoredProperties write SetOnGetStoredProperties;
    property OnGetStoredPropertyValue: TcxGridViewGetStoredPropertyValueEvent
      read FOnGetStoredPropertyValue write SetOnGetStoredPropertyValue;
    property OnSetStoredPropertyValue: TcxGridViewSetStoredPropertyValueEvent
      read FOnSetStoredPropertyValue write SetOnSetStoredPropertyValue;
  end;

function GetGridViewDataController(
  AView: TcxCustomGridView): TcxCustomDataController;
function GetParentGridView(AControl: TControl): TcxCustomGridView;

var
  cxGridRegisteredViews: TcxRegisteredClasses;

implementation

uses
  SysUtils, Math, cxScrollBar, cxLibraryConsts,
  cxGrid, cxGridLevel, cxGridStrs, ImgList;

const
  DragAndDropArrowWidth = 11;
  DragAndDropArrowHeight = 9;
  DragAndDropArrowBorderColor = clBlack;
  DragAndDropArrowColor = clLime;

type
  TCustomFormAccess = class(TCustomForm);
  TcxControlAccess = class(TcxControl);
  TcxCustomGridAccess = class(TcxCustomGrid);
  TcxGridViewRepositoryAccess = class(TcxGridViewRepository);

{ TGridHitTests }

type
  TGridHitTests = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetInstance(AClass: TcxCustomGridHitTestClass): TcxCustomGridHitTest;
    function GetItem(Index: Integer): TcxCustomGridHitTest;
  protected
    function GetObjectByClass(AClass: TcxCustomGridHitTestClass): TcxCustomGridHitTest;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxCustomGridHitTest read GetItem;
  public
    constructor Create;
    destructor Destroy; override;
    property Instances[AClass: TcxCustomGridHitTestClass]: TcxCustomGridHitTest read GetInstance; default;
  end;

var
  GridHitTests: TGridHitTests;

constructor TGridHitTests.Create;
begin
  inherited;
  FItems := TList.Create;
end;

destructor TGridHitTests.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Free;
  FItems.Free;
  inherited;
end;

function TGridHitTests.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TGridHitTests.GetInstance(AClass: TcxCustomGridHitTestClass): TcxCustomGridHitTest;
begin
  Result := GetObjectByClass(AClass);
  if Result = nil then
  begin
    Result := AClass.Create;
    FItems.Add(Result);
  end;  
end;

function TGridHitTests.GetItem(Index: Integer): TcxCustomGridHitTest;
begin
  Result := TcxCustomGridHitTest(FItems[Index]);
end;

function TGridHitTests.GetObjectByClass(AClass: TcxCustomGridHitTestClass): TcxCustomGridHitTest;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if Result.ClassType = AClass then Exit;
  end;
  Result := nil;
end;

{ TcxCustomGridViewChange }

constructor TcxCustomGridViewChange.Create(AGridView: TcxCustomGridView);
begin
  inherited Create;
  FGridView := AGridView;
end;

function TcxCustomGridViewChange.IsEqual(AChange: TcxCustomGridChange): Boolean;
begin
  Result := inherited IsEqual(AChange) and
    (FGridView = TcxCustomGridViewChange(AChange).GridView);
end;

{ TcxGridControlFocusChange }

procedure TcxGridControlFocusChange.Execute;
begin
  if GridView.Changeable then
    GridView.Controller.ControlFocusChanged;
end;

{ TcxCustomGridHitTest }

destructor TcxCustomGridHitTest.Destroy;
begin
  ViewInfo := nil;
  inherited;
end;

procedure TcxCustomGridHitTest.SetViewInfo(Value: TcxCustomGridCellViewInfo);
var
  APrevViewInfo: TcxCustomGridCellViewInfo;
begin
  if FViewInfo <> Value then
  begin
    APrevViewInfo := FViewInfo;
    FViewInfo := Value;
    if (APrevViewInfo <> nil) and (APrevViewInfo.LinkedHitTest = Self) then
      APrevViewInfo.LinkedHitTest := nil;
    if FViewInfo <> nil then
      FViewInfo.LinkedHitTest := Self;
  end;    
end;

class function TcxCustomGridHitTest.GetHitTestCode: Integer;
begin
  Result := htError;
end;

procedure TcxCustomGridHitTest.Init(const APos: TPoint);
begin
  FPos := APos;
end;

function TcxCustomGridHitTest.Cursor: TCursor;
begin
  Result := crDefault;
end;

function TcxCustomGridHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  Result := nil;
end;

class function TcxCustomGridHitTest.HitTestCode: Integer;
begin
  Result := GetHitTestCode;
end;

class function TcxCustomGridHitTest.Instance(const APos: TPoint): TcxCustomGridHitTest;
begin
  Result := GridHitTests.Instances[Self];
  Result.Init(APos);
end;

{ TcxGridHitTestNone }

class function TcxGridNoneHitTest.GetHitTestCode: Integer;
begin
  Result := htNone;
end;

{ TcxGridViewNoneHitTest }

class function TcxGridViewNoneHitTest.GetHitTestCode: Integer;
begin
  Result := htNone;
end;

{ TcxGridNavigatorHitTest }

class function TcxGridNavigatorHitTest.GetHitTestCode: Integer;
begin
  Result := htNavigator;
end;

{ TcxGridCustomizationFormHitTest }

class function TcxGridCustomizationFormHitTest.GetHitTestCode: Integer;
begin
  Result := htCustomizationForm;
end;

{ TcxGridViewHandler }

constructor TcxGridViewHandler.Create(AGridView: TcxCustomGridView);
begin
  inherited Create(nil);
  FGridView := AGridView;
end;

function TcxGridViewHandler.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := FGridView.LookAndFeelPainter;
end;

function TcxGridViewHandler.GetControl: TcxControl;
begin
  Result := FGridView.Control;
end;

function TcxGridViewHandler.GetController: TcxCustomGridController;
begin
  Result := FGridView.Controller;
end;

function TcxGridViewHandler.GetDataController: TcxCustomDataController;
begin
  Result := FGridView.DataController;
end;

function TcxGridViewHandler.GetPainter: TcxCustomGridPainter;
begin
  Result := FGridView.Painter;
end;

function TcxGridViewHandler.GetSite: TcxGridSite;
begin
  Result := FGridView.Site;
end;

function TcxGridViewHandler.GetViewData: TcxCustomGridViewData;
begin
  Result := FGridView.ViewData;
end;

function TcxGridViewHandler.GetViewInfo: TcxCustomGridViewInfo;
begin
  Result := FGridView.ViewInfo;
end;

procedure TcxGridViewHandler.BeginUpdate;
begin
  FGridView.BeginUpdate;
end;

procedure TcxGridViewHandler.EndUpdate;
begin
  FGridView.EndUpdate;
end;

{ TcxCustomGridDragAndDropObject }

function TcxCustomGridDragAndDropObject.GetController: TcxCustomGridController;
begin
  Result := GridView.Controller;
end;

function TcxCustomGridDragAndDropObject.GetGridView: TcxCustomGridView;
begin
  Result := TcxGridSite(Control).GridView;
end;

function TcxCustomGridDragAndDropObject.GetViewInfo: TcxCustomGridViewInfo;
begin
  Result := GridView.ViewInfo;
end;

procedure TcxCustomGridDragAndDropObject.AfterDragAndDrop(Accepted: Boolean);
begin
  inherited;
  if Accepted then Controller.DesignerModified;
end;

procedure TcxCustomGridDragAndDropObject.AfterPaint;
begin
  Dirty := False;
end;

procedure TcxCustomGridDragAndDropObject.BeforePaint;
begin
  Dirty := True;
end;

procedure TcxCustomGridDragAndDropObject.AfterScrolling;
begin
end;

procedure TcxCustomGridDragAndDropObject.BeforeScrolling;
begin
end;

procedure TcxCustomGridDragAndDropObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  SourcePoint := P;
end;

{ TcxCustomGridMovingObject }

constructor TcxCustomGridMovingObject.Create(AControl: TcxControl);
begin
  inherited;
  FDragImagePos := Point(-1, -1);
end;

destructor TcxCustomGridMovingObject.Destroy;
begin
  FSavingBitmap.Free;
  inherited;
end;

function TcxCustomGridMovingObject.GetArrowPlace(AArrowNumber: TcxGridArrowNumber): TcxGridArrowPlace;
begin
  Result := TcxGridArrowPlace(2 * Ord(AArrowNumber) + Ord(AreArrowsVertical));
{  if AreArrowsVertical then
    if AArrowNumber = anFirst then
      Result := apTop
    else
      Result := apBottom
  else
    if AArrowNumber = anFirst then
      Result := apLeft
    else
      Result := apRight;}
end;

function TcxCustomGridMovingObject.GetCustomizationForm: TcxCustomGridCustomizationForm;
begin
  Result := Controller.CustomizationForm;
end;

function TcxCustomGridMovingObject.GetDragImageSavingCanvas: TCanvas;
begin
  Result := DragImageSavingBitmap.Canvas;
end;

function TcxCustomGridMovingObject.GetSavingBitmap: TBitmap;
begin
  if FSavingBitmap = nil then
  begin
    FSavingBitmap := TBitmap.Create;
    with FSavingBitmap do
    begin
      Width := 2 * DragAndDropArrowWidth;
      Height := DragAndDropArrowWidth;
    end;
  end;
  Result := FSavingBitmap;
end;

function TcxCustomGridMovingObject.GetSavingCanvas: TCanvas;
begin
  Result := SavingBitmap.Canvas;
end;

procedure TcxCustomGridMovingObject.CreateDragImage;
begin
  FDragImage := TBitmap.Create;
  FDragImageCanvas := TcxCanvas.Create(FDragImage.Canvas);
  InitDragImage;
  FDragImageSavingBitmap := TBitmap.Create;
  with FDragImageSavingBitmap do
  begin
    Width := FDragImage.Width;
    Height := FDragImage.Height;
  end
end;

procedure TcxCustomGridMovingObject.DestroyDragImage;
begin
  FreeAndNil(FDragImageSavingBitmap);
  FreeAndNil(FDragImageCanvas);
  FreeAndNil(FDragImage);
end;

procedure TcxCustomGridMovingObject.DirtyChanged;
begin
  inherited;
  if Dirty then
    ChangeDragImagePosition(False);
  ChangeArrowsVisibility(not Dirty);
  if not Dirty then
    ChangeDragImagePosition(True);
end;

function TcxCustomGridMovingObject.GetDragAndDropCursor(Accepted: Boolean): TCursor;
begin
  if Accepted then
    Result := crArrow
  else
    if CanRemove then
      Result := crcxGridRemove
    else
      Result := crcxGridNoDrop;
end;

procedure TcxCustomGridMovingObject.ChangeArrowsVisibility(AVisible: Boolean);
var
  ACanvas: TcxScreenCanvas;

  procedure SaveBackground;
  var
    R: TRect;
  begin
    R := ArrowBounds[ArrowPlaces[anFirst]];
    OffsetRect(R, -R.Left, -R.Top);
    SavingCanvas.CopyRect(R, ACanvas.Canvas, ArrowBounds[ArrowPlaces[anFirst]]);
    OffsetRect(R, R.Right - R.Left, 0);
    SavingCanvas.CopyRect(R, ACanvas.Canvas, ArrowBounds[ArrowPlaces[anLast]]);
  end;

  procedure RestoreBackground;
  var
    R: TRect;
  begin
    R := ArrowBounds[ArrowPlaces[anFirst]];
    OffsetRect(R, -R.Left, -R.Top);
    ACanvas.CopyRect(ArrowBounds[ArrowPlaces[anFirst]], SavingCanvas, R);
    OffsetRect(R, R.Right - R.Left, 0);
    ACanvas.CopyRect(ArrowBounds[ArrowPlaces[anLast]], SavingCanvas, R);
  end;

  procedure DrawArrows;

    procedure DrawArrow(AArrowPlace: TcxGridArrowPlace);
    var
      R: TRect;
      P: array[1..7] of TPoint;

      procedure CalculatePointsForLeftArrow;
      begin
        with R do
        begin
          P[1] := Point(Left + 3, Top);
          P[2] := Point(Left + 3, Top + 3);
          P[3] := Point(Left, Top + 3);
          P[4] := Point(Left, Bottom - 4);
          P[5] := Point(Left + 3, Bottom - 4);
          P[6] := Point(Left + 3, Bottom - 1);
          P[7] := Point(Right - 1, Top + 5);
        end;
      end;

      procedure CalculatePointsForTopArrow;
      begin
        with R do
        begin
          P[1] := Point(Left + 3, Top);
          P[2] := Point(Right - 4, Top);
          P[3] := Point(Right - 4, Top + 3);
          P[4] := Point(Right - 1, Top + 3);
          P[5] := Point(Left + 5, Bottom - 1);
          P[6] := Point(Left, Top + 3);
          P[7] := Point(Left + 3, Top + 3);
        end;
      end;

      procedure CalculatePointsForRightArrow;
      begin
        with R do
        begin
          P[1] := Point(Right - 4, Top);
          P[2] := Point(Right - 4, Top + 3);
          P[3] := Point(Right - 1, Top + 3);
          P[4] := Point(Right - 1, Bottom - 4);
          P[5] := Point(Right - 4, Bottom - 4);
          P[6] := Point(Right - 4, Bottom - 1);
          P[7] := Point(Left, Top + 5);
        end;
      end;

      procedure CalculatePointsForBottomArrow;
      begin
        with R do
        begin
          P[1] := Point(Left + 3, Bottom - 1);
          P[2] := Point(Right - 4, Bottom - 1);
          P[3] := Point(Right - 4, Bottom - 4);
          P[4] := Point(Right - 1, Bottom - 4);
          P[5] := Point(Left + 5, Top);
          P[6] := Point(Left, Bottom - 4);
          P[7] := Point(Left + 3, Bottom - 4);
        end;
      end;

    begin
      R := ArrowBounds[AArrowPlace];
      case AArrowPlace of
        apLeft:
          CalculatePointsForLeftArrow;
        apTop:
          CalculatePointsForTopArrow;
        apRight:
          CalculatePointsForRightArrow;
        apBottom:
          CalculatePointsForBottomArrow;
      end;
      ACanvas.Brush.Color := DragAndDropArrowColor;
      ACanvas.Pen.Color := DragAndDropArrowBorderColor;
      ACanvas.Polygon(P);
    end;

  begin
    DrawArrow(ArrowPlaces[anFirst]);
    DrawArrow(ArrowPlaces[anLast]);
  end;

begin
  if AVisible and not IsValidDestination then AVisible := False;
  if FArrowsVisible <> AVisible then
  begin
    FArrowsVisible := AVisible;
    ACanvas := TcxScreenCanvas.Create;
    try
      if FArrowsVisible then
      begin
        SaveBackground;
        DrawArrows;
      end
      else
        RestoreBackground;
    finally
      ACanvas.Free;
    end;
  end;  
end;

procedure TcxCustomGridMovingObject.ChangeDragImagePosition(AVisible: Boolean = True);
var
  ACanvas: TcxScreenCanvas;

  procedure SaveBackground;
  var
    AScreenR, ASaveR: TRect;
  begin
    FDragImageSavingPos := CurMousePos;
    AScreenR := GetDragImageBounds(FDragImageSavingPos);
    ASaveR := AScreenR;
    OffsetRect(ASaveR, -ASaveR.Left, -ASaveR.Top);
    DragImageSavingCanvas.CopyRect(ASaveR, ACanvas.Canvas, AScreenR);
  end;

  procedure RestoreBackground;
  var
    AScreenR, ASaveR: TRect;
  begin
    AScreenR := GetDragImageBounds(FDragImageSavingPos);
    ASaveR := AScreenR;
    OffsetRect(ASaveR, -ASaveR.Left, -ASaveR.Top);
    ACanvas.CopyRect(AScreenR, DragImageSavingCanvas, ASaveR);
  end;

  procedure DrawImage;
  var
    AScreenR, AImageR: TRect;
  begin
    AScreenR := GetDragImageBounds(FDragImagePos);
    AImageR := AScreenR;
    OffsetRect(AImageR, -AImageR.Left, -AImageR.Top);
    ACanvas.CopyRect(AScreenR, FDragImage.Canvas, AImageR);
  end;

  procedure ShowImage;
  begin
    FDragImagePos := CurMousePos;
    SaveBackground;
    DrawImage;
  end;

  procedure HideImage;
  begin
    RestoreBackground;
  end;

  procedure MoveImage;
  var
    AOldBounds, ANewBounds: TRect;

    function GetChangeBounds(const AOldBounds, ANewBounds: TRect; ABorder: TcxBorder): TRect;
    begin
      Result := ANewBounds;
      case ABorder of
        bLeft:
          Result.Right := AOldBounds.Left;
        bTop:
          Result.Bottom := AOldBounds.Top;
        bRight:
          Result.Left := AOldBounds.Right;
        bBottom:
          Result.Top := AOldBounds.Bottom;
      end;
    end;

    procedure RestoreChanges;
    var
      R: TRect;
      I: TcxBorder;

      procedure RestoreChange(const R: TRect);
      var
        ASavingBitmapR: TRect;
      begin
        if IsRectEmpty(R) then Exit;
        ASavingBitmapR := R;
        with AOldBounds do
          OffsetRect(ASavingBitmapR, -Left, -Top);
        ACanvas.CopyRect(R, DragImageSavingCanvas, ASavingBitmapR);
      end;

    begin
      if IntersectRect(R, AOldBounds, ANewBounds) then
        for I := Low(I) to High(I) do
          RestoreChange(GetChangeBounds(ANewBounds, AOldBounds, I))
      else
        RestoreChange(AOldBounds);
    end;

    procedure OffsetSavingBitmap;
    var
      R1, R2: TRect;
    begin
      R1 := AOldBounds;
      with R1 do
        OffsetRect(R1, -Left, -Top);
      R2 := R1;
      OffsetRect(R2, AOldBounds.Left - ANewBounds.Left, AOldBounds.Top - ANewBounds.Top);
      DragImageSavingCanvas.CopyRect(R2, DragImageSavingCanvas, R1);
    end;

    procedure SaveChanges;
    var
      I: TcxBorder;

      procedure SaveChange(const R: TRect);
      var
        ASavingBitmapR: TRect;
      begin
        if IsRectEmpty(R) then Exit;
        ASavingBitmapR := R;
        with ANewBounds do
          OffsetRect(ASavingBitmapR, -Left, -Top);
        DragImageSavingCanvas.CopyRect(ASavingBitmapR, ACanvas.Canvas, R);
      end;

    begin
      for I := Low(I) to High(I) do
        SaveChange(GetChangeBounds(AOldBounds, ANewBounds, I));
    end;

  begin
    FDragImagePos := CurMousePos;
    AOldBounds := GetDragImageBounds(FDragImageSavingPos);
    ANewBounds := GetDragImageBounds(FDragImagePos);
    FDragImageSavingPos := FDragImagePos;

    RestoreChanges;
    OffsetSavingBitmap;
    SaveChanges;
    DrawImage;
  end;

begin
  ACanvas := TcxScreenCanvas.Create;
  try
    if FDragImageVisible <> AVisible then
    begin
      FDragImageVisible := AVisible;
      if AVisible then
        ShowImage
      else
        HideImage;
    end
    else
      if FDragImageVisible and
        ((FDragImagePos.X <> CurMousePos.X) or (DragImagePos.Y <> CurMousePos.Y)) then
        MoveImage;
  finally
    ACanvas.Free;
  end;
end;

function TcxCustomGridMovingObject.AreArrowsVertical: Boolean;
begin
  Result := True;
end;

function TcxCustomGridMovingObject.CalculateDragImageOffset: TPoint;
begin
  with SourceItemBounds do
  begin
    Result.X := MulDiv(SourcePoint.X - Left, FDragImage.Width, Right - Left);
    Result.Y := MulDiv(SourcePoint.Y - Top, FDragImage.Height, Bottom - Top);
  end;
end;

function TcxCustomGridMovingObject.GetArrowBounds(APlace: TcxGridArrowPlace): TRect;

  procedure CheckResult;
  begin
    with ArrowsClientRect do
    begin
      Result.Left := Max(Result.Left, Left);
      Result.Right := Max(Result.Right, Left);
      Result.Left := Min(Result.Left, Right - 1);
      Result.Right := Min(Result.Right, Right - 1);

      Result.Top := Max(Result.Top, Top);
      Result.Bottom := Max(Result.Bottom, Top);
      Result.Top := Min(Result.Top, Bottom - 1);
      Result.Bottom := Min(Result.Bottom, Bottom - 1);
    end;
  end;

  procedure CalculateHorizontalArrowBounds;
  begin
    Result.Bottom := Result.Top + 1;
    InflateRect(Result, 0, DragAndDropArrowWidth div 2);
    if APlace = apLeft then
    begin
      Result.Right := Result.Left;
      Dec(Result.Left, DragAndDropArrowHeight);
    end
    else
    begin
      Result.Left := Result.Right;
      Inc(Result.Right, DragAndDropArrowHeight);
    end;
  end;

  procedure CalculateVerticalArrowBounds;
  begin
    Result.Right := Result.Left + 1;
    InflateRect(Result, DragAndDropArrowWidth div 2, 0);
    if APlace = apTop then
    begin
      Result.Bottom := Result.Top;
      Dec(Result.Top, DragAndDropArrowHeight);
    end
    else
    begin
      Result.Top := Result.Bottom;
      Inc(Result.Bottom, DragAndDropArrowHeight);
    end;
  end;

  procedure ConvertToScreenCoordinates;
  begin
    with GridView.Site, Result do
    begin
      TopLeft := ClientToScreen(TopLeft);
      BottomRight := ClientToScreen(BottomRight);
    end;
  end;

begin
  Result := GetArrowAreaBounds(APlace);
  CheckResult;
  if APlace in [apLeft, apRight] then
    CalculateHorizontalArrowBounds
  else
    CalculateVerticalArrowBounds;
  ConvertToScreenCoordinates;
end;

function TcxCustomGridMovingObject.GetArrowsClientRect: TRect;
begin
  Result := ViewInfo.Bounds;
end;

function TcxCustomGridMovingObject.GetDragImageBounds(AMousePos: TPoint): TRect;
begin
  Result := Rect(0, 0, FDragImage.Width, FDragImage.Height);
  with Control.ClientToScreen(AMousePos) do
    OffsetRect(Result, X - FDragImageOffset.X, Y - FDragImageOffset.Y);
end;

function TcxCustomGridMovingObject.GetSourceItemBounds: TRect;
begin
  if SourceItemViewInfo <> nil then
    Result := SourceItemViewInfo.Bounds
  else
    if IsSourceCustomizationForm and (CustomizationFormListBox <> nil) then
      with CustomizationFormListBox do
      begin
        Result := ItemRect(IndexOfItem(SourceItem));
        MapWindowRect(Handle, Control.Handle, Result);
      end
    else
      Result := Rect(0, 0, 0, 0);
end;

function TcxCustomGridMovingObject.GetSourceItemViewInfo: TcxCustomGridCellViewInfo;
begin
  Result := nil;
end;

procedure TcxCustomGridMovingObject.InitDragImage;

  procedure InitUsingSourceItemViewInfo;
  var
    AViewInfo: TcxCustomGridCellViewInfo;
  begin
    AViewInfo := SourceItemViewInfo;
    with AViewInfo.Bounds.TopLeft do
      SetViewportOrgEx(DragImage.Canvas.Handle, -X, -Y, nil);
    AViewInfo.Paint(DragImageCanvas);
  end;

  procedure InitFromCustomizationForm;
  var
    R: TRect;
  begin
    R := SourceItemBounds;
    with R do
      OffsetRect(R, -Left, -Top);
    InitDragImageUsingCustomizationForm(DragImageCanvas, R, SourceItem);
  end;

begin
  with FDragImage, SourceItemBounds do
  begin
    Width := Right - Left;
    Height := Bottom - Top;
  end;
  if SourceItemViewInfo <> nil then
    InitUsingSourceItemViewInfo
  else
    if IsSourceCustomizationForm then
      InitFromCustomizationForm;
end;

procedure TcxCustomGridMovingObject.InitDragImageUsingCustomizationForm(ACanvas: TcxCanvas;
  const R: TRect; AItem: TObject);
begin
  if CustomizationFormListBox <> nil then
    CustomizationFormListBox.PaintDragAndDropItem(ACanvas, R, AItem);
end;

procedure TcxCustomGridMovingObject.BeginDragAndDrop;
begin
  CreateDragImage;
  FDragImageOffset := CalculateDragImageOffset;
  GridView.Control.UpdateWithChildren;
  inherited;
end;

procedure TcxCustomGridMovingObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  inherited;
  ChangeDragImagePosition;
end;

procedure TcxCustomGridMovingObject.EndDragAndDrop(Accepted: Boolean);
begin
  inherited;
  DestroyDragImage;
end;

procedure TcxCustomGridMovingObject.AfterScrolling;
begin
  ChangeArrowsVisibility(True);
  ChangeDragImagePosition(True);
  inherited;
end;

procedure TcxCustomGridMovingObject.BeforeScrolling;
begin
  inherited;
  ChangeDragImagePosition(False);
  ChangeArrowsVisibility(False);
end;

{ TcxCustomGridItemsInnerListBox }

constructor TcxCustomGridItemsInnerListBox.Create(AOwner: TComponent);
begin
  inherited;
  Sorted := True;
  Style := lbOwnerDrawFixed;
  CalculateBorderStyle;
  FDragAndDropItemIndex := -1;
end;

function TcxCustomGridItemsInnerListBox.GetContainer: TcxCustomGridItemsListBox;
begin
  Result := TcxCustomGridItemsListBox(inherited Container);
end;

function TcxCustomGridItemsInnerListBox.GetDragAndDropItem: TObject;
begin
  Result := Items.Objects[FDragAndDropItemIndex];
end;

function TcxCustomGridItemsInnerListBox.GetGridView: TcxCustomGridView;
begin
  Result := Container.GridView;
end;

function TcxCustomGridItemsInnerListBox.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := LookAndFeel.Painter;
end;

procedure TcxCustomGridItemsInnerListBox.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  FDragAndDropItemIndex := -1;
end;

procedure TcxCustomGridItemsInnerListBox.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  if BorderStyle = bsNone then
    InflateRect(Message.CalcSize_Params^.rgrc[0], -1, -1);
end;

procedure TcxCustomGridItemsInnerListBox.WMNCPaint(var Message: TWMNCPaint);
var
  R: TRect;
  DC: HDC;
begin
  inherited;
  if BorderStyle = bsNone then
  begin
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    DC := GetWindowDC(Handle);
    DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);
    ReleaseDC(Handle, DC);
  end;
end;

procedure TcxCustomGridItemsInnerListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    WindowClass.Style := WindowClass.Style or CS_HREDRAW;
end;

procedure TcxCustomGridItemsInnerListBox.CreateWnd;
begin
  inherited;
  CalculateItemHeight;
end;

procedure TcxCustomGridItemsInnerListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  Container.PaintItem(Canvas, Rect, Index, odFocused in State);
  if odFocused in State then Canvas.DrawFocusRect(Rect);
end;

procedure TcxCustomGridItemsInnerListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then
    GridView.Site.FinishDragAndDrop(False);
end;

procedure TcxCustomGridItemsInnerListBox.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  CalculateBorderStyle;
  CalculateItemHeight;
  inherited;
end;

procedure TcxCustomGridItemsInnerListBox.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AItemIndex: Integer;
begin
  inherited;
  if Button = mbLeft then
  begin
    AItemIndex := ItemAtPos(Point(X, Y), True);
    if AItemIndex <> -1 then
    begin
      FDragAndDropItemIndex := AItemIndex;
      FMouseDownPos := Point(X, Y);
    end;
  end;
end;

procedure TcxCustomGridItemsInnerListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  AParams: TcxCustomGridHitTest;
  P: TPoint;
begin
  inherited;
  if (FDragAndDropItemIndex <> -1) and
    (not IsPointInDragDetectArea(FMouseDownPos, X, Y) or
     (ItemAtPos(Point(X, Y), False) <> FDragAndDropItemIndex)) then
  begin
    ItemIndex := FDragAndDropItemIndex;
    AParams := Container.GetDragAndDropParams;
    with GridView do
    begin
      P := FMouseDownPos;
      P := Site.ScreenToClient(ClientToScreen(P));
      Controller.DragAndDropObjectClass := AParams.DragAndDropObjectClass;
      Controller.DragAndDropObject.Init(P, AParams);
      Site.BeginDragAndDrop;
    end;
    FDragAndDropItemIndex := -1;
  end;
end;

procedure TcxCustomGridItemsInnerListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  FDragAndDropItemIndex := -1;
end;

procedure TcxCustomGridItemsInnerListBox.CalculateBorderStyle;
begin
  if LookAndFeelPainter.HeaderBorderSize <= 1 then
    BorderStyle := bsNone
  else
    BorderStyle := bsSingle;
end;

procedure TcxCustomGridItemsInnerListBox.CalculateItemHeight;
begin
  if HandleAllocated then
    ItemHeight := Container.CalculateItemHeight;
end;

{ TcxCustomGridItemsListBox }

constructor TcxCustomGridItemsListBox.Create(AOwner: TComponent);
begin
  inherited;
  with Style do
  begin
    BorderStyle := cbsNone;
    HotTrack := False;
    LookAndFeel.MasterLookAndFeel := GridView.LookAndFeel;
    TransparentBorder := False;
  end;
  StyleFocused.BorderStyle := cbsNone;
  StyleHot.BorderStyle := cbsNone;
  ParentFont := True;
end;

function TcxCustomGridItemsListBox.GetDragAndDropItem: TObject;
begin
  Result := InnerListBox.DragAndDropItem;
end;

function TcxCustomGridItemsListBox.GetGridView: TcxCustomGridView;
begin
  Result := (Owner as TcxCustomGridCustomizationForm).GridView;
end;

function TcxCustomGridItemsListBox.GetInnerListBox: TcxCustomGridItemsInnerListBox;
begin
  Result := TcxCustomGridItemsInnerListBox(inherited InnerListBox);
end;

function TcxCustomGridItemsListBox.GetInnerListBoxClass: TcxInnerListBoxClass;
begin
  Result := TcxCustomGridItemsInnerListBox;
end;

function TcxCustomGridItemsListBox.IndexOfItem(AItem: TObject): Integer;
begin
  Result := Items.IndexOfObject(AItem);
end;

procedure TcxCustomGridItemsListBox.PaintDragAndDropItem(ACanvas: TcxCanvas;
  const R: TRect; AItem: TObject);
begin
  ACanvas.Brush.Color := Color;
  ACanvas.Font := Font;
  PaintItem(ACanvas, R, IndexOfItem(AItem), False);
end;

procedure TcxCustomGridItemsListBox.RefreshItems;
begin
  InnerListBox.CalculateItemHeight;
end;

{ TcxCustomGridCustomizationForm }

// TODO: system menu

constructor TcxCustomGridCustomizationForm.Create(AController: TcxCustomGridController);
begin
  inherited CreateNew(nil);
  FController := AController;
  Caption := cxGetResourceString(@scxGridCustomizationFormCaption);
  BorderStyle := bsSizeToolWin;
  Font := TcxControlAccess(Controller.Control).Font;
  CalculateConsts;
  CreateControls;
end;

destructor TcxCustomGridCustomizationForm.Destroy;
begin
  FHookTimer.Free;
  FController.Customization := False;
  inherited;
end;

function TcxCustomGridCustomizationForm.GetGridView: TcxCustomGridView;
begin
  Result := FController.GridView;
end;

function TcxCustomGridCustomizationForm.GetViewInfo: TcxCustomGridViewInfo;
begin
  Result := FController.ViewInfo;
end;

procedure TcxCustomGridCustomizationForm.HookTimerHandler(Sender: TObject);
begin
  if IsIconic(Application.Handle) then
    Visible := False
  else
    if not GridView.Visible or not IsWindowVisible(FController.Site.Handle) then
      FController.Customization := False
    else
      if not Visible then
      begin
        ShowWindow(Handle, SW_SHOWNOACTIVATE);
        Visible := True;
      end;
end;

procedure TcxCustomGridCustomizationForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := Style or WS_POPUP;
    WndParent := FController.Site.Handle;
  end;
end;

procedure TcxCustomGridCustomizationForm.DoClose(var Action: TCloseAction);
begin
  FreeAndNil(FHookTimer);
  Action := caFree;
end;

procedure TcxCustomGridCustomizationForm.DoShow;
begin
  if FHookTimer = nil then
  begin
    FHookTimer := TcxTimer.Create(nil);
    with FHookTimer do
    begin
      Interval := 100;
      OnTimer := HookTimerHandler;
    end;
  end;  
  inherited;
end;

procedure TcxCustomGridCustomizationForm.CalculateConsts;
begin
  FOffset := Canvas.TextHeight('Qq') div 6;
end;

procedure TcxCustomGridCustomizationForm.CreateControls;
begin
  FPageControl := TcxPageControl.Create(Self);
  with FPageControl do
  begin
    Anchors := [akTop, akLeft, akRight, akBottom];
    BoundsRect := GetPageControlBounds;
    Focusable := False;
    HotTrack := True;
    LookAndFeel.MasterLookAndFeel := GridView.LookAndFeel;
    Parent := Self;
    InitPageControl;
  end;
end;

function TcxCustomGridCustomizationForm.CreatePage(const ACaption: string;
  AVisible: Boolean): TcxTabSheet;
begin
  Result := TcxTabSheet.Create(FPageControl);
  with Result do
  begin
    Caption := ACaption;
    TabVisible := AVisible;
    PageControl := FPageControl;
  end;
end;

procedure TcxCustomGridCustomizationForm.GridViewChanged;
begin
end;

function TcxCustomGridCustomizationForm.GetContentBounds: TRect;
begin
  Result := ClientRect;
  InflateRect(Result, -Offset, -Offset);
end;

function TcxCustomGridCustomizationForm.GetPageControlBounds: TRect;
begin
  Result := ContentBounds;
end;

procedure TcxCustomGridCustomizationForm.InitPageControl;
begin
end;

procedure TcxCustomGridCustomizationForm.ActivatePage(APage: TcxTabSheet);
begin
  if APage.TabVisible then
    FPageControl.ActivePage := APage;
end;

procedure TcxCustomGridCustomizationForm.RefreshData;
begin
end;

{ TcxCustomGridPopup }

constructor TcxCustomGridPopup.Create(AGridView: TcxCustomGridView);
begin
  inherited Create(AGridView.Site);
  FGridView := AGridView;
  IsTopMost := True;
  OwnerParent := FGridView.Site;
end;

procedure TcxCustomGridPopup.SetOwner(Value: IcxCustomGridPopupOwner);
begin
  if FOwner <> Value then
  begin
    if (Value = nil) and Visible and FOwner.ClosePopupWhenNilOwner then
      CloseUp;
    FOwner := Value;
  end;
end;

function TcxCustomGridPopup.CalculateOwnerBounds: TRect;
begin
  Result := FOwner.GetOwnerBounds;
end;

function TcxCustomGridPopup.GetClientMinWidth: Integer;
begin
  with Owner.GetOwnerBounds do
    Result := Right - Left - NCWidth;
end;

procedure TcxCustomGridPopup.InitPopup;
begin
  inherited;
  BorderStyle := GridView.LookAndFeelPainter.PopupBorderStyle;
  Font := TcxControlAccess(FGridView.Control).Font;
  OwnerBounds := CalculateOwnerBounds;
end;

procedure TcxCustomGridPopup.Paint;
begin
  DrawFrame;
end;

procedure TcxCustomGridPopup.VisibleChanged;
begin
  inherited;
  if not Visible and (FOwner <> nil) then
  begin
    FOwner.PopupClosed;
  end;
end;

procedure TcxCustomGridPopup.CloseUp;
begin
  inherited;
  //TcxControlAccess(FGridView.Site).FocusChanged;
end;

procedure TcxCustomGridPopup.Popup;
begin
  SetCaptureControl(nil);
  inherited Popup(FindNextControl(nil, True, True, False));
end;

{ TcxGridPopupListBox }

constructor TcxGridPopupListBox.Create(APopup: TcxCustomGridPopup);
begin
  inherited Create(APopup);
  FItemTextOffsetLeft := cxGridCellTextOffset;
  FItemTextOffsetRight := cxGridCellTextOffset;
  FPopup := APopup;
  Init;
  Parent := FPopup;
end;

function TcxGridPopupListBox.GetGridView: TcxCustomGridView;
begin
  Result := FPopup.GridView;
end;

function TcxGridPopupListBox.DrawItem(ACanvas: TcxCanvas; AIndex: Integer;
  const ARect: TRect; AState: TOwnerDrawState): Boolean;
begin
  DrawItemContent(ACanvas, AIndex, ARect, AState);
  if odFocused in AState then ACanvas.DrawFocusRect(ARect);
  Result := True;
end;

procedure TcxGridPopupListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN:
      DoAction(ItemIndex);
    VK_ESCAPE:
      FPopup.CloseUp;
  end;
end;

procedure TcxGridPopupListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  ItemIndex := ItemAtPos(Point(X, Y), True);
  inherited;
end;

procedure TcxGridPopupListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  DoAction(ItemAtPos(Point(X, Y), True));
end;

function TcxGridPopupListBox.GetVisibleItemCount(AItems: TStrings): Integer;
begin
  Result := FVisibleItemCount;
  if (Result = 0) or (Result > AItems.Count) then
    Result := AItems.Count;
end;

function TcxGridPopupListBox.CalculateItemHeight: Integer;
begin
  Result := Canvas.TextHeight('Qq') + 2 * FItemTextOffsetVert;
end;

procedure TcxGridPopupListBox.DoAction(AItemIndex: Integer);
begin
  if AItemIndex = -1 then Exit;
  FPopup.CloseUp;
  if Assigned(FOnAction) then FOnAction(Self, AItemIndex);
end;

procedure TcxGridPopupListBox.DrawItemContent(ACanvas: TcxCanvas; AIndex: Integer;
  ARect: TRect; AState: TOwnerDrawState);
begin
  with ACanvas do
  begin
    FillRect(ARect);
    Inc(ARect.Left, FItemTextOffsetLeft);
    DrawText(Items[AIndex], ARect, cxSingleLine or cxAlignLeft or cxAlignVCenter);
  end;
end;

procedure TcxGridPopupListBox.Init;
begin
  Style.LookAndFeel.MasterLookAndFeel := GridView.LookAndFeel;
  ListStyle := lbOwnerDrawFixed;
  with Style do
  begin
    BorderStyle := cbsNone;
    HotTrack := False;
    TransparentBorder := False;
  end;
  StyleFocused.BorderStyle := cbsNone;
  StyleHot.BorderStyle := cbsNone;
  ParentFont := True;
end;

procedure TcxGridPopupListBox.AdjustBounds(AItems: TStrings = nil);

  function CalculateClientHeight: Integer;
  begin
    Result := GetVisibleItemCount(AItems) * ItemHeight;
  end;

  function CalculateClientWidth: Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to AItems.Count - 1 do
      Result := Max(Result, Canvas.TextWidth(AItems[I]));
    Inc(Result, FItemTextOffsetLeft + FItemTextOffsetRight);
    if FVisibleWidth <> 0 then
      Result := Min(Result, FVisibleWidth);
    if GetVisibleItemCount(AItems) < AItems.Count then
      Inc(Result, GetScrollBarSize.cx);
  end;

begin
  if AItems = nil then AItems := Items;
  Canvas.Font := Font;
  ItemHeight := CalculateItemHeight;
  ClientHeight := CalculateClientHeight;
  ClientWidth := CalculateClientWidth;
  MinWidth := FPopup.ClientMinWidth;
  if (FMinWidth <> 0) and (Width < FMinWidth) then
    Width := FMinWidth;
end;

{ TcxGridDesignController }

constructor TcxGridDesignController.Create(AController: TcxCustomGridController);
begin
  inherited Create;
  FController := AController;
end;

function TcxGridDesignController.GetControl: TcxControl;
begin
  Result := FController.Control;
end;

function TcxGridDesignController.GetDesignObject(AObject: TPersistent): TPersistent;
begin
  if FController.GridView.IsPattern then
    Result := AObject
  else
    Result := FController.GetPatternObject(AObject);
end;

function TcxGridDesignController.IsObjectSelected(AObject: TPersistent): Boolean;
begin
{$IFDEF DELPHI6}
  Result := TcxCustomGrid(Control).StructureNavigator.IsObjectSelected(GetDesignObject(AObject));
{$ELSE}
  Result := False;
{$ENDIF}
end;

procedure TcxGridDesignController.SelectObject(AObject: TPersistent; AClearSelection: Boolean);
begin
  TcxCustomGrid(Control).StructureNavigator.SelectObject(GetDesignObject(AObject), AClearSelection);
end;

procedure TcxGridDesignController.UnselectObject(AObject: TPersistent);
begin
  if Control <> nil then
    TcxCustomGrid(Control).StructureNavigator.UnselectObject(GetDesignObject(AObject));
end;

{ TcxCustomGridController }

destructor TcxCustomGridController.Destroy;
begin
  HideHint;
  FreeAndNil(FHintWindow);
  FreeAndNil(FDesignController);
  inherited;
end;

function TcxCustomGridController.GetDesignController: TcxGridDesignController;
begin
  if (FDesignController = nil) and GridView.IsDesigning then
    FDesignController := GetDesignControllerClass.Create(Self);
  Result := FDesignController;
end;

function TcxCustomGridController.GetDragAndDropObject: TcxCustomGridDragAndDropObject;
begin
  Result := Site.DragAndDropObject as TcxCustomGridDragAndDropObject;
end;

function TcxCustomGridController.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  Result := Site.DragAndDropObjectClass;
end;

function TcxCustomGridController.GetDragImages: TcxDragImageList;
begin
  Result := Site.DragImages;
end;

function TcxCustomGridController.GetIsDragging: Boolean;
begin
  Result := Site.DragAndDropState = ddsInProcess;
end;

function TcxCustomGridController.GetMouseCaptureViewInfo: TcxCustomGridCellViewInfo;
begin
  if Site.MouseCaptureObject is TcxCustomGridCellViewInfo then
    Result := TcxCustomGridCellViewInfo(Site.MouseCaptureObject)
  else
    Result := nil;
end;

procedure TcxCustomGridController.SetCustomization(Value: Boolean);
begin
  if Value and (GridView.IsPattern or not Site.HandleAllocated) then Exit;
  if FCustomization <> Value then
  begin
    FCustomization := Value;
    CustomizationChanged;
  end;
end;

procedure TcxCustomGridController.SetDragAndDropObjectClass(Value: TcxDragAndDropObjectClass);
begin
  Site.DragAndDropObjectClass := Value;
end;

procedure TcxCustomGridController.SetMouseCaptureViewInfo(Value: TcxCustomGridCellViewInfo);
begin
  Site.MouseCaptureObject := Value;
end;

procedure TcxCustomGridController.HintCheckerTimerHandler(Sender: TObject);
begin
  if not CanShowHint then HideHint;
end;

procedure TcxCustomGridController.MouseLeave;
begin
  HideHint;
end;

function TcxCustomGridController.PtInCaller(const P: TPoint): Boolean;
begin
  if FHintCellViewInfo = nil then
    if IsRectEmpty(FHintAreaBounds) then
      Result := PtInRect(Site.Bounds, P)
    else
      Result := PtInRect(FHintAreaBounds, P)
  else
    Result := FHintCellViewInfo.HasHintPoint(P);
end;

procedure TcxCustomGridController.AfterPaint;
begin
  if IsDragging then
    DragAndDropObject.AfterPaint;
end;

procedure TcxCustomGridController.BeforeKillFocus;
begin
end;

procedure TcxCustomGridController.BeforePaint;
begin
  if IsDragging then
    DragAndDropObject.BeforePaint;
end;

function TcxCustomGridController.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := True;
end;

function TcxCustomGridController.CanHandleHitTest(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := not (AHitTest is TcxCustomGridViewHitTest) or
    (TcxCustomGridViewHitTest(AHitTest).GridView = FGridView);
end;

procedure TcxCustomGridController.CheckCoordinates;
begin
end;

procedure TcxCustomGridController.DetailFocused(ADetail: TcxCustomGridView);
begin
end;

procedure TcxCustomGridController.DoEnter;
begin
end;

procedure TcxCustomGridController.DoExit;
begin
end;

procedure TcxCustomGridController.DoSetFocus(ANotifyMaster: Boolean);
begin
  FIsFocusing := True;
  try
    SetFocus(ANotifyMaster);
  finally
    FIsFocusing := False;
  end;
end;

function TcxCustomGridController.GetDesignControllerClass: TcxGridDesignControllerClass;
begin
  Result := TcxGridDesignController;
end;

function TcxCustomGridController.GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := AHitTest.DragAndDropObjectClass <> nil;
end;

function TcxCustomGridController.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  Result := mwskNone;
end;

function TcxCustomGridController.GetPatternObject(AObject: TPersistent): TPersistent;
begin
  Result := AObject;
end;

procedure TcxCustomGridController.GridViewChanged;
begin
  if CustomizationForm <> nil then
    CustomizationForm.GridViewChanged;
end;

function TcxCustomGridController.IsPixelScrollBar(AKind: TScrollBarKind): Boolean;
begin
  Result := False;
end;

function TcxCustomGridController.MayFocus: Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridController.RemoveFocus;
begin
  BeforeKillFocus;
  GridView.TabStop := False;
  if not GridView.Visible then
  begin
    Site.Parent := nil;
  end;
end;

procedure TcxCustomGridController.SetFocus(ANotifyMaster: Boolean);
begin
  GridView.TabStop := True;
  ViewInfo.DoVisibilityChanged(True);
  if Control.IsFocused and Site.CanFocusEx then
    Site.SetFocus;
  if ANotifyMaster and GridView.IsDetail then
    GridView.MasterGridView.Controller.DetailFocused(GridView);
end;

procedure TcxCustomGridController.CheckCustomizationFormBounds(var R: TRect);
begin
end;

procedure TcxCustomGridController.CustomizationChanged;
begin
  if Customization then
    ShowCustomizationForm
  else
    HideCustomizationForm;
  TcxCustomGrid(Control).SendNotifications(gnkCustomization);
  GridView.DoCustomization;
end;

function TcxCustomGridController.GetCustomizationFormClass: TcxCustomGridCustomizationFormClass;
begin
  Result := TcxCustomGridCustomizationForm;
end;

function TcxCustomGridController.GetRealCustomizationFormBounds: TRect;
begin
  if IsRectEmpty(FCustomizationFormBounds) then
  begin
    Result.BottomRight := Site.ClientToScreen(Site.ClientRect.BottomRight);
    Result.Left := Result.Right - cxGridCustomizationFormDefaultWidth;
    Result.Top := Result.Bottom - cxGridCustomizationFormDefaultHeight;
    CheckCustomizationFormBounds(Result);
  end
  else
    Result := FCustomizationFormBounds;
end;

procedure TcxCustomGridController.HideCustomizationForm;
begin
  if not (csDestroying in FCustomizationForm.ComponentState) then
    FCustomizationForm.Free;
  FCustomizationForm := nil;
end;

procedure TcxCustomGridController.ShowCustomizationForm;
begin
  FCustomizationForm := GetCustomizationFormClass.Create(Self);
  FCustomizationForm.BoundsRect := GetRealCustomizationFormBounds;
  FCustomizationForm.Show;
end;

procedure TcxCustomGridController.ControlFocusChanged;
begin
  ViewInfo.ControlFocusChanged;
end;

procedure TcxCustomGridController.DesignerModified;
begin
  Site.Modified;
end;

procedure TcxCustomGridController.DoCancelMode;
begin
end;

procedure TcxCustomGridController.DoCheckCoordinates;
var
  APrevIsCheckingCoordinates: Boolean;
begin
  APrevIsCheckingCoordinates := FIsCheckingCoordinates;
  FIsCheckingCoordinates := True;
  try
    CheckCoordinates;
  finally
    FIsCheckingCoordinates := APrevIsCheckingCoordinates;
  end;
end;

procedure TcxCustomGridController.DoControlFocusChanged;
begin
  GridView.Changed(TcxGridControlFocusChange.Create(GridView));
end;

function TcxCustomGridController.GetCursor(X, Y: Integer): TCursor;
var
  AHitTest: TcxCustomGridHitTest;
begin
  AHitTest := ViewInfo.GetHitTest(Point(X, Y));
  if CanHandleHitTest(AHitTest) then
    Result := AHitTest.Cursor
  else
    Result := crDefault;
end;

function TcxCustomGridController.HasFocusedControls: Boolean;
begin
  Result := False;
end;

{function TcxCustomGridController.CanDrag(X, Y: Integer): Boolean;
begin
  Result := False;
end;

function TcxCustomGridController.GetDragObjectClass: TDragControlObjectClass;
begin
  Result := TcxDragControlObject;
end;}

procedure TcxCustomGridController.InitScrollBarsParameters;
begin
end;

function TcxCustomGridController.IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridController.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
end;

procedure TcxCustomGridController.SetScrollBarInfo(AScrollBarKind: TScrollBarKind;
  AMin, AMax, AStep, APage, APos: Integer; AAllowShow, AAllowHide: Boolean);
begin
  Site.SetScrollBarInfo(AScrollBarKind, AMin, AMax, AStep, APage, APos, AAllowShow, AAllowHide);
end;

procedure TcxCustomGridController.UpdateScrollBars;
begin
  Site.UpdateScrollBars;
end;

procedure TcxCustomGridController.BeginDragAndDrop;
begin
end;

procedure TcxCustomGridController.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
end;

procedure TcxCustomGridController.EndDragAndDrop(Accepted: Boolean);
begin
end;

function TcxCustomGridController.StartDragAndDrop(const P: TPoint): Boolean;
var
  AHitTest: TcxCustomGridHitTest;
begin
  AHitTest := ViewInfo.GetHitTest(P);
  Result := CanHandleHitTest(AHitTest);
  if Result then
  begin
    Result := AHitTest.DragAndDropObjectClass <> nil;
    if Result then
    begin
      HideHint;
      DragAndDropObjectClass := AHitTest.DragAndDropObjectClass;
      DragAndDropObject.Init(P, AHitTest);
    end;
  end;
end;

procedure TcxCustomGridController.BeforeStartDrag;
begin
end;

function TcxCustomGridController.CanDrag(X, Y: Integer): Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridController.DragDrop(Source: TObject; X, Y: Integer);
begin
end;

procedure TcxCustomGridController.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
end;

procedure TcxCustomGridController.DrawDragImage(ACanvas: TcxCanvas; R: TRect);
begin
end;

procedure TcxCustomGridController.EndDrag(Target: TObject; X, Y: Integer);
begin
end;

function TcxCustomGridController.GetDragImagesSize: TPoint;
begin
  Result := Point(0, 0);
end;

function TcxCustomGridController.HasDragImages: Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridController.StartDrag(var DragObject: TDragObject);
begin
end;

function TcxCustomGridController.CanShowHint: Boolean;
var
  AForm: TCustomForm;
begin
  AForm := GetParentForm(Site);
  Result := (AForm = nil) or Application.Active and
    (AForm.Active or
     (TCustomFormAccess(AForm).FormStyle = fsMDIForm));
  if Result then
    Result := Site.HandleAllocated and IsWindowVisible(Site.Handle) and
      (FindVCLWindow(GetMouseCursorPos) = Site);
end;

procedure TcxCustomGridController.HideHint;
begin
  StopHintCheckerTimer;
  EndMouseTracking(Self);
  FHintCellViewInfo := nil;
  SetRectEmpty(FHintAreaBounds);
  if FHintWindow <> nil then
    ShowWindow(FHintWindow.Handle, SW_HIDE);
end;

function TcxCustomGridController.GetHintWindowClass: THintWindowClass;
begin
  Result := HintWindowClass;
end;

procedure TcxCustomGridController.ShowHint(const AHintAreaBounds, ATextRect: TRect;
  const AText: string; AIsHintMultiLine: Boolean; AFont: TFont;
  AHintCellViewInfo: TcxCustomGridViewCellViewInfo);

  function GetHintWindowRect: TRect;

    function GetMaxTextWidth: Integer;
    begin
      if AIsHintMultiLine then
        Result := ATextRect.Right - ATextRect.Left
      else
        Result := MaxInt div 20;
    end;

    function GetTextRectOffset: TPoint;
    const
      TextOffset: TPoint = (X: 2; Y: 2);
    begin
      with FHintWindow.ClientToScreen(Point(0, 0)) do
      begin
        Result.X := X - FHintWindow.Left + TextOffset.X;
        Result.Y := Y - FHintWindow.Top + TextOffset.Y;
      end;
    end;

  begin
    Result := FHintWindow.CalcHintRect(GetMaxTextWidth, AText, nil);
    with Result do
    begin
      Inc(Right, -6);
      Inc(Bottom, -2);
    end;
    with Site.ClientToScreen(ATextRect.TopLeft) do
      OffsetRect(Result, X, Y);
    with GetTextRectOffset do
      InflateRect(Result, X, Y);
    MakeVisibleOnDesktop(Result, Result.TopLeft);
    Dec(Result.Bottom, 4);
  end;

begin
  if not CanShowHint then Exit;
  if (FHintWindow = nil) or (FHintWindow.ClassType <> GetHintWindowClass) then
  begin
    FHintWindow.Free;
    FHintWindow := GetHintWindowClass.Create(nil);
    FHintWindow.Color := Application.HintColor;
  end
  else
    if IsWindowVisible(FHintWindow.Handle) then
    begin
      if (FHintWindow.Caption = AText) and EqualRect(FHintTextRect, ATextRect) then
        Exit;
      EndMouseTracking(Self);
    end;
  FHintTextRect := ATextRect;
  FHintWindow.Canvas.Font := AFont;
  FHintWindow.ActivateHint(GetHintWindowRect, AText);
  FHintAreaBounds := AHintAreaBounds;
  FHintCellViewInfo := AHintCellViewInfo;
  BeginMouseTracking(Site, FHintAreaBounds, Self);
  StartHintCheckerTimer;
end;

procedure TcxCustomGridController.StartHintCheckerTimer;
begin
  if FHintCheckerTimer <> nil then Exit;
  FHintCheckerTimer := TcxTimer.Create(nil);
  with FHintCheckerTimer do
  begin
    Interval := 100;
    OnTimer := HintCheckerTimerHandler;
  end;
end;

procedure TcxCustomGridController.StopHintCheckerTimer;
begin
  FreeAndNil(FHintCheckerTimer);
end;

procedure TcxCustomGridController.DoKeyDown(var Key: Word; Shift: TShiftState);
begin
  KeyDown(Key, Shift);
end;

procedure TcxCustomGridController.KeyDown(var Key: Word; Shift: TShiftState);
begin
end;

procedure TcxCustomGridController.KeyPress(var Key: Char);
begin
end;

procedure TcxCustomGridController.KeyUp(var Key: Word; Shift: TShiftState);
begin
end;

procedure TcxCustomGridController.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
begin
  FIsDblClick := ssDouble in Shift;
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if AHitTest.ViewInfo <> nil then
    AHitTest.ViewInfo.MouseDown(AHitTest, Button, Shift);
end;

procedure TcxCustomGridController.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
begin                      
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if MouseCaptureViewInfo <> nil then
    MouseCaptureViewInfo.MouseMove(AHitTest, Shift)
  else
    if AHitTest.ViewInfo <> nil then
      AHitTest.ViewInfo.MouseMove(AHitTest, Shift);
end;

procedure TcxCustomGridController.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
begin
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if MouseCaptureViewInfo <> nil then
    MouseCaptureViewInfo.MouseUp(AHitTest, Button, Shift)
  else
    if AHitTest.ViewInfo <> nil then
      AHitTest.ViewInfo.MouseUp(AHitTest, Button, Shift);
end;

function TcxCustomGridController.ProcessDetailDialogChar(ADetail: TcxCustomGridView;
  ACharCode: Word): Boolean;
begin
  Result := False;
end;

function TcxCustomGridController.ProcessDialogChar(ACharCode: Word): Boolean;
begin
  Result := (GridView.MasterGridView <> nil) and
    GridView.MasterGridView.Controller.ProcessDetailDialogChar(GridView, ACharCode);
end;

procedure TcxCustomGridController.WndProc(var Message: TMessage);
begin
  if (Message.Msg = CN_SYSCHAR) and ProcessDialogChar(Message.WParam) then
    Message.Msg := WM_NULL;
end;

procedure TcxCustomGridController.RefreshCustomizationForm;
begin
  if CustomizationForm <> nil then
    CustomizationForm.RefreshData;
end;

{procedure TcxCustomGridController.BeginCellMouseTracking(AViewInfo: TcxCustomGridCellViewInfo);
begin
  BeginMouseTracking(Site, AViewInfo.Bounds, AViewInfo);
end;

procedure TcxCustomGridController.EndCellMouseTracking(AViewInfo: TcxCustomGridCellViewInfo);
begin
  EndMouseTracking(AViewInfo);
end;}

{ TcxCustomGridCellPainter }

constructor TcxCustomGridCellPainter.Create(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridCellViewInfo);
begin
  inherited Create;
  FCanvas := ACanvas;
  FViewInfo := AViewInfo;
end;

function TcxCustomGridCellPainter.GetIsMainCanvasInUseValue: Boolean;
begin
  Result := GetIsMainCanvasInUse(FCanvas, FViewInfo);
end;

procedure TcxCustomGridCellPainter.AfterPaint;
begin
  if CanDrawDesignSelection then DoDrawDesignSelection(Canvas, ViewInfo);
end;

procedure TcxCustomGridCellPainter.BeforePaint;
begin
end;

function TcxCustomGridCellPainter.CanDrawDesignSelection: Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridCellPainter.DoExcludeFromClipRect;
begin
  Canvas.ExcludeClipRect(ViewInfo.Bounds);
end;

procedure TcxCustomGridCellPainter.DrawBackground;
begin
  DrawBackground(ViewInfo.ClientBounds);
end;

procedure TcxCustomGridCellPainter.DrawBackground(const R: TRect);
begin
  with Canvas, ViewInfo do
    if not Transparent then
    begin
      Brush.Color := Params.Color;
      FillRect(R);
    end
    else
      if BackgroundBitmap <> nil then
        FillRect(R, BackgroundBitmap);
end;

function TcxCustomGridCellPainter.DrawBackgroundHandler(ACanvas: TcxCanvas;
  const ABounds: TRect): Boolean;
begin  {4}
  Result := ViewInfo.BackgroundBitmap <> nil;
  if Result then
    ACanvas.FillRect(ABounds, ViewInfo.BackgroundBitmap);
end;

procedure TcxCustomGridCellPainter.DrawBorder(ABorder: TcxBorder);
begin
  with Canvas do
  begin
    SetBrushColor(ViewInfo.BorderColor[ABorder]);
    FillRect(ViewInfo.BorderBounds[ABorder]);
  end;
end;

procedure TcxCustomGridCellPainter.DrawBorders;
var
  ABorder: TcxBorder;
begin
  for ABorder := Low(ABorder) to High(ABorder) do
    if ABorder in ViewInfo.Borders then
      DrawBorder(ABorder);
end;

procedure TcxCustomGridCellPainter.DrawContent;
begin
  if ViewInfo.HasBackground and not ViewInfo.DoCustomDrawBackground(Canvas) then
    DrawBackground;
  DrawText;
end;

class procedure TcxCustomGridCellPainter.DrawDesignSelection(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridCellViewInfo);
var
  R: TRect;
  I: Integer;
begin
  R := AViewInfo.DesignSelectionBounds;
  for I := 0 to AViewInfo.DesignSelectionWidth - 1 do
  begin
    ACanvas.DrawFocusRect(R);
    InflateRect(R, -1, -1);
  end;
end;

procedure TcxCustomGridCellPainter.DrawText;
var
  R: TRect;
begin
  with Canvas, ViewInfo do
    if TextForPainting <> '' then
    begin
      R := TextAreaBounds;  // can call font change
      Font := Params.Font;
      Font.Color := Params.TextColor;
      Brush.Style := bsClear;
      PrepareCanvasForDrawText;
      DrawText(TextForPainting, R, GetTextAttributes(True));
      UnprepareCanvasForDrawText;
      Brush.Style := bsSolid;
    end;
end;

function TcxCustomGridCellPainter.ExcludeFromClipRect: Boolean;
begin
  Result := False;
end;

class function TcxCustomGridCellPainter.GetIsMainCanvasInUse(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridCellViewInfo): Boolean;
begin
  Result := ACanvas = AViewInfo.Canvas;
end;

function TcxCustomGridCellPainter.NeedsPainting: Boolean;
begin
  Result := Canvas.RectVisible(ViewInfo.GetAreaBoundsForPainting);
end;

procedure TcxCustomGridCellPainter.Paint;
var
  ASavedParams: TcxViewParams;
begin
  ViewInfo.SaveParams(ASavedParams);
  try
    if not ViewInfo.DoCustomDraw(Canvas) then
      DrawContent;
  finally
    ViewInfo.RestoreParams(ASavedParams);
  end;
  DrawBorders;
end;

procedure TcxCustomGridCellPainter.PrepareCanvasForDrawText;
begin
end;

procedure TcxCustomGridCellPainter.UnprepareCanvasForDrawText;
begin
end;

class procedure TcxCustomGridCellPainter.DoDrawDesignSelection(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridCellViewInfo);
begin
  if AViewInfo.IsDesignSelected and GetIsMainCanvasInUse(ACanvas, AViewInfo) then
    DrawDesignSelection(ACanvas, AViewInfo);
end;

procedure TcxCustomGridCellPainter.MainPaint;
begin
  if not NeedsPainting then Exit;
  BeforePaint;
  Paint;
  AfterPaint;
  if ExcludeFromClipRect then DoExcludeFromClipRect;
end;

{ TcxCustomGridPainter }

function TcxCustomGridPainter.GetCanvas: TcxCanvas;
begin
  if FCanvas = nil then
    Result := ViewInfo.Canvas
  else
    Result := FCanvas;
end;

function TcxCustomGridPainter.GetViewInfo: TcxCustomGridViewInfo;
begin
  if FViewInfo = nil then
    Result := inherited ViewInfo
  else
    Result := FViewInfo;
end;

procedure TcxCustomGridPainter.DrawBackground;

  procedure DrawBackgroundUsingBrush;
  begin
    with Canvas do
    begin
      Brush.Color := ViewInfo.BackgroundColor;
      FillRgn(Handle, FBackgroundRegion.Handle, Brush.Handle);
    end;
  end;

  procedure DrawBackgroundUsingBitmap;
  var
    AClipRegion: TcxRegion;
  begin
    with Canvas do
    begin
      AClipRegion := GetClipRegion;
      SetClipRegion(FBackgroundRegion, roIntersect, False);
      FillRect(ViewInfo.Bounds, ViewInfo.BackgroundBitmap);
      SetClipRegion(AClipRegion, roSet);
    end;
  end;

begin
  if ViewInfo.BackgroundBitmap = nil then
    DrawBackgroundUsingBrush
  else
    DrawBackgroundUsingBitmap;  {4}
  //Canvas.ExcludeClipRect(ViewInfo.Bounds);
end;

procedure TcxCustomGridPainter.PaintAfter;
begin
  DrawBackground;
  FreeAndNil(FBackgroundRegion);
  Canvas.SetClipRegion(FBeforePaintClipRegion, roSet);
end;

procedure TcxCustomGridPainter.PaintBefore;
begin
  FBeforePaintClipRegion := Canvas.GetClipRegion;
  FBackgroundRegion := TcxRegion.Create(ViewInfo.Bounds);
end;

procedure TcxCustomGridPainter.PaintContent;
begin
end;

procedure TcxCustomGridPainter.DrawFocusRect(const R: TRect; AHideFocusRect: Boolean);
begin
  if GridView.IsControlFocused then
    Canvas.DrawFocusRect(R)
  else
    if not AHideFocusRect then
      with Canvas, R do
      begin
        InvertRect(Rect(Left, Top, Right, Top + 1));
        InvertRect(Rect(Left, Bottom - 1, Right, Bottom));
        InvertRect(Rect(Left, Top + 1, Left + 1, Bottom - 1));
        InvertRect(Rect(Right - 1, Top + 1, Right, Bottom - 1));
      end;
end;

procedure TcxCustomGridPainter.ExcludeFromBackground(const R: TRect);
begin
  FBackgroundRegion.Combine(TcxRegion.Create(R), roSubtract);
end;

procedure TcxCustomGridPainter.Paint(ACanvas: TcxCanvas = nil;
  AViewInfo: TcxCustomGridViewInfo = nil);
{
var i,ft,lt:integer;
}
begin
{
  ft:=gettickcount;
  for i:=1 to 10 do
  begin
}
  ViewInfo := AViewInfo;
  Canvas := ACanvas;

  Controller.BeforePaint;
  PaintBefore;
  PaintContent;
  PaintAfter;
  Controller.AfterPaint;

  Canvas := nil;
  ViewInfo := nil;
{
  windows.SelectClipRgn(canvas.Handle, 0);
  end;
  lt:=gettickcount;
  application.MainForm.caption := inttostr(lt-ft);
}
end;

procedure TcxCustomGridPainter.Invalidate;
begin
  Site.Invalidate;
end;

procedure TcxCustomGridPainter.Invalidate(const R: TRect);
begin
  Site.InvalidateRect(R, False);
end;

procedure TcxCustomGridPainter.Invalidate(ARegion: TcxRegion);
begin
  Site.InvalidateRgn(ARegion, False);
end;

{ TcxGridSite }

constructor TcxGridSite.Create(AViewInfo: TcxCustomGridViewInfo);
begin
  FViewInfo := AViewInfo;
  inherited Create(nil);
  ControlStyle := ControlStyle + [csNoDesignVisible];
  Keys := [kArrows, kChars];
  ParentColor := False;
{$IFDEF USETCXSCROLLBAR}
  HScrollBar.UnlimitedTracking := True;
  VScrollBar.UnlimitedTracking := True;
{$ENDIF}
end;

destructor TcxGridSite.Destroy;
begin
  CancelPostBoundsChanged;
  //!!!!FViewInfo.FSite := nil; should always be nil here already;
  inherited;
end;

function TcxGridSite.GetContainer: TcxControl;
begin
  Result := GridView.Control;
end;

function TcxGridSite.GetController: TcxCustomGridController;
begin
  Result := GridView.Controller;
end;

function TcxGridSite.GetGridView: TcxCustomGridView;
begin
  Result := FViewInfo.GridView;
end;

function TcxGridSite.GetPainter: TcxCustomGridPainter;
begin
  Result := GridView.Painter;
end;

procedure TcxGridSite.SendKeyDownNotification(var Message: TWMKeyDown);
begin
  TcxCustomGrid(GridView.Control).SendNotifications(gnkKeyDown,
    @Message);
end;

procedure TcxGridSite.CNKeyDown(var Message: TWMKeyDown);
begin
  SendKeyDownNotification(Message);
  if Message.Result = 0 then
    inherited;
end;

procedure TcxGridSite.CNSysKeyDown(var Message: TWMKeyDown);
begin
  SendKeyDownNotification(Message);
  if Message.Result = 0 then
    inherited;
end;

procedure TcxGridSite.BoundsChangedTimerHandler(Sender: TObject);
begin
  CancelPostBoundsChanged;
  GridView.BoundsChanged;
end;

function TcxGridSite.AllowAutoDragAndDropAtDesignTime(X, Y: Integer;
  Shift: TShiftState): Boolean;
begin
  Result := False;
end;

function TcxGridSite.AllowDragAndDropWithoutFocus: Boolean;
begin
  if TcxCustomGridAccess(GridView.Control).IsPopupControl then  {8}
    Result := True
  else
    Result := inherited AllowDragAndDropWithoutFocus;
end;

procedure TcxGridSite.BeforeMouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if HandleAllocated then
    Controller.MouseDown(Button, Shift, X, Y);
end;

procedure TcxGridSite.BoundsChanged;
var
  APrevSize: TPoint;

  function AllowNotification: Boolean;
  var
    AGridView: TcxCustomGridView;
  begin
    AGridView := GridView;
    repeat
      Result := AGridView.ViewInfo.AllowBoundsChangedNotification;
      AGridView := AGridView.MasterGridView;
    until not Result or (AGridView = nil);
  end;

begin
  if CreatingWindow then Exit;
  APrevSize := FSize;
  UpdateSize;
  if ViewInfo.VisibilityChanging then Exit;
  if ((APrevSize.X <> 0) or (APrevSize.Y <> 0)) and
    ((APrevSize.X <> FSize.X) or (APrevSize.Y <> FSize.Y)) then
    if AllowNotification then
      GridView.BoundsChanged(True)
    else
      if UpdatingScrollBars then PostBoundsChanged;
  {if AllowNotification and
    ((APrevSize.X <> 0) or (APrevSize.Y <> 0)) and
    ((APrevSize.X <> FSize.X) or (APrevSize.Y <> FSize.Y)) then
    GridView.BoundsChanged(True);}
  inherited;
end;

function TcxGridSite.CanDrag(X, Y: Integer): Boolean;
begin
  Result := inherited CanDrag(X, Y) and Controller.CanDrag(X, Y);
end;

function TcxGridSite.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := inherited CanFocusOnClick(X, Y) and Controller.CanFocusOnClick(X, Y);
end;

procedure TcxGridSite.DoCancelMode;
begin
  inherited;
  Controller.DoCancelMode;
end;

procedure TcxGridSite.DoContextPopup(MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  if not Handled and (GridView.Control <> nil) then
    Handled := TcxCustomGrid(GridView.Control).SendNotifications(gnkContextMenu,
      TObject((MousePos.X = -1) and (MousePos.Y = -1)));
end;

procedure TcxGridSite.DoEnter;
begin
  inherited;
  Controller.DoEnter;
end;

procedure TcxGridSite.DoExit;
begin
  if not GridView.IsDestroying then
    Controller.DoExit;
  inherited;
end;

procedure TcxGridSite.FocusChanged;
var
  ALink: TcxObjectLink;
begin
  ALink := cxAddObjectLink(Self);
  try
    inherited;
    if IsFocused then
      GridView.Focused := True;
    if ALink.Ref = nil then Exit;
    TcxCustomGridAccess(Container).UpdateFocusing(GridView.IsControlFocused);
  finally
    cxRemoveObjectLink(ALink);
  end;
end;

function TcxGridSite.FocusWhenChildIsClicked(AChild: TControl): Boolean;
begin
  Result := inherited FocusWhenChildIsClicked(AChild) and not Container.IsFocused;
end;

function TcxGridSite.GetCursor(X, Y: Integer): TCursor;
begin
  Result := Controller.GetCursor(X, Y);
  if Result = crDefault then
    Result := inherited GetCursor(X, Y);
end;

function TcxGridSite.GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean;
var
  AHitTest: TcxCustomGridHitTest;
begin
  Result := inherited GetDesignHitTest(X, Y, Shift);
  if not Result {and (ssLeft in Shift) } and not TcxCustomGrid(Container).UpdateLocked then
  begin
    AHitTest := ViewInfo.GetHitTest(X, Y);
    Result := Controller.GetDesignHitTest(AHitTest);
  end;
end;

function TcxGridSite.GetIsDesigning: Boolean;
begin
  if Container = nil then
    Result := GridView.IsDesigning
  else
    Result := Container.IsDesigning;
end;

function TcxGridSite.GetIsFocused: Boolean;
begin
  Result := (GridView.Control <> nil) and
    TcxCustomGridAccess(GridView.Control).IsPopupControl or {8}
    inherited GetIsFocused or Controller.HasFocusedControls;
end;

function TcxGridSite.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  Result := Controller.GetMouseWheelScrollingKind;
end;

function TcxGridSite.IsPixelScrollBar(AKind: TScrollBarKind): Boolean;
begin
  Result := Controller.IsPixelScrollBar(AKind);
end;

procedure TcxGridSite.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  Controller.DoKeyDown(Key, Shift);
end;

procedure TcxGridSite.KeyPress(var Key: Char);
begin
  inherited;
  Controller.KeyPress(Key);
end;

procedure TcxGridSite.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  Controller.KeyUp(Key, Shift);
end;

function TcxGridSite.MayFocus: Boolean;
begin
  Result := inherited MayFocus and Controller.MayFocus;
end;

procedure TcxGridSite.MouseLeave(AControl: TControl);
begin
  inherited;
  Controller.MouseLeave;
end;

procedure TcxGridSite.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if DragAndDropState = ddsNone then
    Controller.MouseMove(Shift, X, Y);
end;

procedure TcxGridSite.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if DragAndDropState = ddsNone then
  begin
    Controller.MouseUp(Button, Shift, X, Y);
    inherited;
  end
  else
  begin
    inherited;
    Controller.MouseUp(Button, Shift, X, Y);
  end;
end;

procedure TcxGridSite.Paint;
begin
  if not FViewInfo.IsCalculating and (Left <> cxGridInvisibleCoordinate) then
  begin
    inherited;
    Painter.Paint;
  end;
end;

procedure TcxGridSite.RequestAlign;
begin
end;

procedure TcxGridSite.SetParent(AParent: TWinControl);
begin
  if Parent <> AParent then
  begin
    if AParent <> nil then
      LookAndFeel.MasterLookAndFeel := GridView.LookAndFeel;
    InitTabStop(AParent);
    if (AParent = nil) and GridView.Focused and
      not (csDestroying in Parent.ComponentState) and Parent.CanFocus then
      Parent.SetFocus;
  end;
  inherited;
end;

procedure TcxGridSite.WndProc(var Message: TMessage);
begin
  Controller.WndProc(Message);
  inherited WndProc(Message);
end;

procedure TcxGridSite.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  Controller.EndDrag(Target, X, Y);
  inherited;
end;

procedure TcxGridSite.DoStartDrag(var DragObject: TDragObject);
begin
  Controller.BeforeStartDrag;
  inherited;
  Controller.StartDrag(DragObject);
end;

procedure TcxGridSite.DragOver(Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  inherited;
  Controller.DragOver(Source, X, Y, State, Accept);
end;

procedure TcxGridSite.DrawDragImage(ACanvas: TcxCanvas; const R: TRect);
begin
  Controller.DrawDragImage(ACanvas, R);
end;

function TcxGridSite.GetDragImagesSize: TPoint;
begin
  Result := Controller.GetDragImagesSize;
end;

function TcxGridSite.HasDragImages: Boolean;
begin
  Result := Controller.HasDragImages;
end;

function TcxGridSite.GetHScrollBarBounds: TRect;
begin
  Result := inherited GetHScrollBarBounds;
  ViewInfo.GetHScrollBarBounds(Result);
end;

procedure TcxGridSite.InitScrollBarsParameters;
begin
  Controller.InitScrollBarsParameters;
end;

procedure TcxGridSite.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  Controller.Scroll(AScrollBarKind, AScrollCode, AScrollPos);
end;

procedure TcxGridSite.UpdateScrollBars;
begin
  if not FViewInfo.IsCalculating and GridView.Visible {and
    (Container <> nil) and not TcxCustomGrid(Container).UpdateLocked} then  // commented because of the locking in DoFinalChanges
    inherited;
end;

procedure TcxGridSite.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  inherited;
  Controller.DragAndDrop(P, Accepted);
end;

procedure TcxGridSite.EndDragAndDrop(Accepted: Boolean);
begin
  Controller.EndDragAndDrop(Accepted);
  inherited;
end;

function TcxGridSite.StartDragAndDrop(const P: TPoint): Boolean;
begin
  Result := Controller.StartDragAndDrop(P);
end;

procedure TcxGridSite.CancelPostBoundsChanged;
begin
  FreeAndNil(FBoundsChangedTimer);
end;

procedure TcxGridSite.InitTabStop(AParent: TWinControl);
begin
  if (AParent <> nil) and (GridView.Level <> nil) then
    GridView.TabStop := TcxGridLevel(GridView.Level).IsTop;
end;

procedure TcxGridSite.PostBoundsChanged;     
begin
  if FBoundsChangedTimer <> nil then Exit;
  FBoundsChangedTimer := TcxTimer.Create(nil);
  with FBoundsChangedTimer do
  begin
    Interval := 1;
    OnTimer := BoundsChangedTimerHandler;
  end;
end;

procedure TcxGridSite.UpdateSize;
begin
  FSize := ClientBounds.BottomRight;
end;

procedure TcxGridSite.BeginDragAndDrop;
begin
  Controller.BeginDragAndDrop;
  inherited;
end;

procedure TcxGridSite.DragDrop(Source: TObject; X, Y: Integer);
begin
  Controller.DragDrop(Source, X, Y);
  inherited;
end;

function TcxGridSite.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or
    GridView.Focused and GridView.DataController.ExecuteAction(Action);
end;

procedure TcxGridSite.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  APrevWidth, APrevHeight: Integer;
begin
  APrevWidth := Width;
  APrevHeight := Height;
  inherited;
  if (Width <> APrevWidth) or (Height <> APrevHeight) then
    UpdateSize;
end;

procedure TcxGridSite.SetFocus;
var
  ALink: TcxObjectLink;
begin
  ALink := cxAddObjectLink(Self);
  try
    if not GridView.Focused then
      TcxCustomGrid(Container).FocusedView.Controller.BeforeKillFocus;
    if ALink.Ref = nil then Exit;
    inherited;
  finally
    cxRemoveObjectLink(ALink);
  end;
end;

function TcxGridSite.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or
    GridView.Focused and GridView.DataController.UpdateAction(Action);
end;

{ TcxCustomGridCellViewInfo }

constructor TcxCustomGridCellViewInfo.Create;
begin
  inherited;
  FVisible := True;
end;

destructor TcxCustomGridCellViewInfo.Destroy;
begin
  LinkedHitTest := nil;
  if DropDownWindowExists and (DropDownWindow.Owner = IcxCustomGridPopupOwner(Self)) then
    DropDownWindow.Owner := nil;
  MouseCapture := False;
  State := gcsNone;
  inherited;
end;

function TcxCustomGridCellViewInfo.GetBorderSize(AIndex: TcxBorder): Integer;
begin
  if AIndex in Borders then
    Result := BorderWidth[AIndex]
  else
    Result := 0;
end;

function TcxCustomGridCellViewInfo.GetButtonState: TcxButtonState;
begin
  Result := GridCellStateToButtonState(ActualState);
end;

function TcxCustomGridCellViewInfo.GetClientBounds: TRect;
begin
  if IsRectEmpty(FClientBounds) then
    FClientBounds := CalculateClientBounds;
  Result := FClientBounds;
end;

function TcxCustomGridCellViewInfo.GetContentBounds: TRect;
begin
  if IsRectEmpty(FContentBounds) then
    FContentBounds := CalculateContentBounds;
  Result := FContentBounds;
end;

function TcxCustomGridCellViewInfo.GetTextBounds: TRect;
var
  ATextWidth, ATextHeight: Integer;
begin
  Result := TextAreaBounds;
  ATextWidth := TextWidth;
  with Result do
  begin
    if MultiLinePainting and (ATextWidth > Right - Left) then Exit;
    case AlignmentHorz of
      taLeftJustify:
        Right := Left + ATextWidth;
      taRightJustify:
        Left := Right - ATextWidth;
      taCenter:
        begin
          Left := (Left + Right - ATextWidth) div 2;
          Right := Left + ATextWidth;
        end;
    end;
    ATextHeight := TextHeight;
    case AlignmentVert of
      vaTop:
        Bottom := Top + ATextHeight;
      vaBottom:
        Top := Bottom - ATextHeight;
      vaCenter:
        begin
          Top := (Top + Bottom - ATextHeight) div 2;
          Bottom := Top + ATextHeight;
        end;
    end;
  end;
end;

function TcxCustomGridCellViewInfo.GetTextHeight: Integer;
begin
  Result := CalculateTextHeight(False);
end;

function TcxCustomGridCellViewInfo.GetTextWidth: Integer;
begin
  Result := CalculateTextWidth;
end;

function TcxCustomGridCellViewInfo.GetTextHeightWithOffset: Integer;
begin
  Result := TextHeight;
  GetCellTextAreaSize(Result);
end;

function TcxCustomGridCellViewInfo.GetTextWidthWithOffset: Integer;
begin
  Result := TextWidth;
  GetCellTextAreaSize(Result);
end;

procedure TcxCustomGridCellViewInfo.SetLinkedHitTest(Value: TcxCustomGridHitTest);
var
  APrevLinkedHitTest: TcxCustomGridHitTest;
begin
  if FLinkedHitTest <> Value then
  begin
    APrevLinkedHitTest := FLinkedHitTest;
    FLinkedHitTest := Value;
    if (APrevLinkedHitTest <> nil) and (APrevLinkedHitTest.ViewInfo = Self) then
      APrevLinkedHitTest.ViewInfo := nil;
    if FLinkedHitTest <> nil then
      FLinkedHitTest.ViewInfo := Self;
  end;    
end;

procedure TcxCustomGridCellViewInfo.SetState(Value: TcxGridCellState);
begin
  if FState <> Value then
  begin
    BeforeStateChange;
    FState := Value;
    StateChanged;
  end;
end;

function TcxCustomGridCellViewInfo.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TcxCustomGridCellViewInfo._AddRef: Integer;
begin
  Result := -1;
end;

function TcxCustomGridCellViewInfo._Release: Integer;
begin
  Result := -1;
end;

procedure TcxCustomGridCellViewInfo.DoCancelMode;
begin
  State := gcsNone;
end;

procedure TcxCustomGridCellViewInfo.MouseLeave;
begin
  if not MouseCapture and
    ((FState = gcsSelected) or not IsCheck and (FState = gcsPressed)) then
    State := gcsNone;
end;

function TcxCustomGridCellViewInfo.PtInCaller(const P: TPoint): Boolean;
begin
  Result := HasPoint(P);
end;

function TcxCustomGridCellViewInfo.ClosePopupWhenNilOwner: Boolean;
begin
  Result := ClosePopupOnDestruction;
end;

function TcxCustomGridCellViewInfo.GetOwnerBounds: TRect;
begin
  Result := GetDropDownWindowOwnerBounds;
end;

procedure TcxCustomGridCellViewInfo.PopupClosed;
begin
  CloseUp;
end;

procedure TcxCustomGridCellViewInfo.AfterCalculateBounds(var ABounds: TRect);
begin
  ResetContentBounds;
end;

procedure TcxCustomGridCellViewInfo.AfterCustomDraw(ACanvas: TcxCanvas);
begin
  ACanvas.GetParams(Params);
end;

procedure TcxCustomGridCellViewInfo.BeforeCustomDraw(ACanvas: TcxCanvas);
begin
  ACanvas.SetParams(Params);
end;

procedure TcxCustomGridCellViewInfo.BeforeStateChange;
begin
end;

function TcxCustomGridCellViewInfo.CalculateClientBounds: TRect;
var
  ABorder: TcxBorder;
  ABorderSize: Integer;
begin
  Result := Bounds;
  for ABorder := Low(ABorder) to High(ABorder) do
  begin
    ABorderSize := BorderSize[ABorder];
    with Result do
      case ABorder of
        bLeft:
          Inc(Left, ABorderSize);
        bTop:
          Inc(Top, ABorderSize);
        bRight:
          Dec(Right, ABorderSize);
        bBottom:
          Dec(Bottom, ABorderSize);
      end;
  end;
end;

function TcxCustomGridCellViewInfo.CalculateContentBounds: TRect;
begin
  Result := ClientBounds;
end;

function TcxCustomGridCellViewInfo.CalculateTextWidth(AAngle: Integer = 0): Integer;
begin
  CalculateParams;
  Canvas.Font := Params.Font;
  if AAngle <> 0 then
    Canvas.SetFontAngle(AAngle);
  Result := Canvas.TextWidth(Text);
  if AAngle <> 0 then
    Canvas.SetFontAngle(0);
end;

function TcxCustomGridCellViewInfo.CalculateTextHeight(AForPainting: Boolean;
  AAngle: Integer = 0): Integer;
var
  R: TRect;
begin
  CalculateParams;
  R := TextAreaBounds;
  Canvas.Font := Params.Font;
  if AAngle <> 0 then
    Canvas.SetFontAngle(AAngle);
  Canvas.TextExtent(Text, R,
    GetTextAttributes(AForPainting) and not (cxAlignBottom or cxAlignVCenter) or cxAlignTop);  {1}
  if AAngle <> 0 then
    Canvas.SetFontAngle(0);
  Result := R.Bottom - R.Top;
end;

procedure TcxCustomGridCellViewInfo.CalculateParams;
begin
  if FParamsCalculated or FCalculatingParams then Exit;
  FCalculatingParams := True;
  try
    DoCalculateParams;
  finally
    FCalculatingParams := False;
    FParamsCalculated := True;
  end;
end;

procedure TcxCustomGridCellViewInfo.CalculateParamsNeeded;
begin
  FParamsCalculated := False;
end;

function TcxCustomGridCellViewInfo.CalculateHeight: Integer;
begin
  Result := Bounds.Bottom - Bounds.Top;
end;

function TcxCustomGridCellViewInfo.CalculateWidth: Integer;
begin
  Result := Bounds.Right - Bounds.Left;
end;

function TcxCustomGridCellViewInfo.CaptureMouseOnPress: Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridCellViewInfo.Click;
begin
end;

function TcxCustomGridCellViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.CustomDrawBackground(ACanvas: TcxCanvas): Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridCellViewInfo.Destroying;
begin
  FIsDestroying := True;
end;

procedure TcxCustomGridCellViewInfo.DoCalculateParams;
begin
  AlignmentHorz := GetAlignmentHorz;
  AlignmentVert := GetAlignmentVert;
  GetViewParams(Params);
  Borders := GetBorders;
  Text := GetText;
  MultiLine := GetMultiLine;
  MultiLinePainting := GetMultiLinePainting;
  Width := CalculateWidth;
end;

procedure TcxCustomGridCellViewInfo.DoInvalidate;
begin
  if Control <> nil then
    Control.InvalidateRect(Bounds, False);
end;

function TcxCustomGridCellViewInfo.DoCustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := HasCustomDraw;
  if Result then
  begin
    BeforeCustomDraw(ACanvas);
    Result := CustomDraw(ACanvas);
    if not Result then
      AfterCustomDraw(ACanvas);
  end;
end;

function TcxCustomGridCellViewInfo.DoCustomDrawBackground(ACanvas: TcxCanvas): Boolean;
begin
  Result := HasCustomDrawBackground;
  if Result then
  begin
    BeforeCustomDraw(ACanvas);
    Result := CustomDrawBackground(ACanvas);
    if not Result then
      AfterCustomDraw(ACanvas);
  end;
end;

function TcxCustomGridCellViewInfo.GetActualState: TcxGridCellState;
begin
  Result := FState;
end;

function TcxCustomGridCellViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := taLeftJustify;
end;

function TcxCustomGridCellViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := vaTop;
end;

function TcxCustomGridCellViewInfo.GetAreaBounds: TRect;
begin
  SetRectEmpty(Result);
end;

function TcxCustomGridCellViewInfo.GetBackgroundBitmap: TBitmap;
begin  {4}
  Result := Params.Bitmap;
  //Result := nil;
end;

function TcxCustomGridCellViewInfo.GetBorderColor(AIndex: TcxBorder): TColor;
begin
  Result := clDefault;
end;

function TcxCustomGridCellViewInfo.GetBorderBounds(AIndex: TcxBorder): TRect;
begin
  Result := ClientBounds;
  with Result do
  begin
    case AIndex of
      bLeft:
        begin
          Right := Left;
          Dec(Left, BorderWidth[AIndex]);
        end;
      bTop:
        begin
          Bottom := Top;
          Dec(Top, BorderWidth[AIndex]);
        end;
      bRight:
        begin
          Left := Right;
          Inc(Right, BorderWidth[AIndex]);
        end;
      bBottom:
        begin
          Top := Bottom;
          Inc(Bottom, BorderWidth[AIndex]);
        end;
    end;
    if AIndex in [bLeft, bRight] then
    begin
      if bTop in Borders then
        Dec(Top, BorderWidth[bTop]);
      if bBottom in Borders then
        Inc(Bottom, BorderWidth[bBottom]);
    end;
  end;
end;

function TcxCustomGridCellViewInfo.GetBorders: TcxBorders;
begin
  Result := [];
end;

function TcxCustomGridCellViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := 0;
end;

function TcxCustomGridCellViewInfo.GetBounds: TRect;
var
  AArea: TRect;
begin
  Result := Bounds;
  AArea := GetAreaBounds;
  if not IsRectEmpty(AArea) then
    IntersectRect(Result, Result, AArea);
end;

class function TcxCustomGridCellViewInfo.GetCellHeight(ATextHeight: Integer;
  ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer;
begin
  Result := ATextHeight;
  GetCellTextAreaSize(Result);
end;

function TcxCustomGridCellViewInfo.GetContentHeight: Integer;
begin
  with ContentBounds do
    Result := Bottom - Top;
end;

function TcxCustomGridCellViewInfo.GetContentWidth: Integer;
begin
  with ContentBounds do
    Result := Right - Left;
end;

function TcxCustomGridCellViewInfo.GetControl: TcxControl;
begin
  if (Canvas.Canvas is TControlCanvas) and
    (TControlCanvas(Canvas.Canvas).Control is TcxControl) then
      Result := TControlCanvas(Canvas.Canvas).Control as TcxControl
  else
    Result := nil;
end;

function TcxCustomGridCellViewInfo.GetDesignSelectionBounds: TRect;
begin
  Result := Bounds;
  InflateRect(Result, -1, -1);
end;

function TcxCustomGridCellViewInfo.GetDesignSelectionWidth: Integer;
begin
  Result := 2;
end;

function TcxCustomGridCellViewInfo.GetHeight: Integer;
begin
  with Bounds do
    Result := Bottom - Top;
end;

function TcxCustomGridCellViewInfo.GetHotTrack: Boolean;
begin
  Result := IsCheck;
end;

function TcxCustomGridCellViewInfo.GetIsCheck: Boolean;
begin
  Result := DropDownWindow <> nil;
end;

function TcxCustomGridCellViewInfo.GetIsDesignSelected: Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.GetIsVisibleForPainting: Boolean;
begin
  Result := Visible;
end;

function TcxCustomGridCellViewInfo.GetMouseCapture: Boolean;
begin
  if Control = nil then
    Result := False
  else
    Result := Control.MouseCaptureObject = Self;
end;

function TcxCustomGridCellViewInfo.GetMultiLine: Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.GetMultiLinePainting: Boolean;
begin                 
  Result := MultiLine;
end;

function TcxCustomGridCellViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxCustomGridCellPainter;
end;

function TcxCustomGridCellViewInfo.GetShowEndEllipsis: Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.GetText: string;
begin
  Result := '';
end;

function TcxCustomGridCellViewInfo.GetTextAreaBounds: TRect;
begin
  Result := ContentBounds;
  InflateRect(Result, -cxGridCellTextOffset, -cxGridCellTextOffset);
end;

function TcxCustomGridCellViewInfo.GetTextAttributes(AForPainting: Boolean): Integer;
const
  AlignmentsHorz: array[TAlignment] of Integer =
    (cxAlignLeft, cxAlignRight, cxAlignHCenter);
  AlignmentsVert: array[TcxAlignmentVert] of Integer =
    (cxAlignTop, cxAlignBottom, cxAlignVCenter);
  MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
  ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);
begin
  Result :=
    AlignmentsHorz[AlignmentHorz] or AlignmentsVert[AlignmentVert] or
    MultiLines[AForPainting and MultiLinePainting or not AForPainting and MultiLine] or
    ShowEndEllipsises[ShowEndEllipsis];
end;

function TcxCustomGridCellViewInfo.GetTextCellHeight(AGridViewInfo: TcxCustomGridViewInfo;
  ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer;
begin
  CalculateParams;
  if MultiLine then
    Result := TextHeight
  else
    Result := AGridViewInfo.GetFontHeight(Params.Font);
  Result := GetCellHeight(Result, ALookAndFeelPainter);
end;

function TcxCustomGridCellViewInfo.GetTextForPainting: string;
begin
  Result := Text;
end;

function TcxCustomGridCellViewInfo.GetTransparent: Boolean;
begin                               {4}
  Result := BackgroundBitmap <> nil;
end;

procedure TcxCustomGridCellViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
end;

function TcxCustomGridCellViewInfo.GetVisible: Boolean;
begin
  Result := FVisible;
end;

function TcxCustomGridCellViewInfo.GetVisibleForHitTest: Boolean;
begin
  Result := Visible;
end;

function TcxCustomGridCellViewInfo.GetWidth: Integer;
begin
  with Bounds do
    Result := Right - Left;
end;

function TcxCustomGridCellViewInfo.HasBackground: Boolean;
begin
  Result := True;
end;

function TcxCustomGridCellViewInfo.HasCustomDraw: Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.HasCustomDrawBackground: Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.HasHitTestPoint(const P: TPoint): Boolean;
begin
  Result := HasPoint(P);
end;

function TcxCustomGridCellViewInfo.HasMouse(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := AHitTest is GetHitTestClass;
end;

procedure TcxCustomGridCellViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  AHitTest.ViewInfo := Self;
end;

function TcxCustomGridCellViewInfo.InvalidateOnStateChange: Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridCellViewInfo.Offset(DX, DY: Integer);
begin
  OffsetRect(Bounds, DX, DY);
  if not IsRectEmpty(FClientBounds) then
    OffsetRect(FClientBounds, DX, DY);
  if not IsRectEmpty(FContentBounds) then
    OffsetRect(FContentBounds, DX, DY);
end;

procedure TcxCustomGridCellViewInfo.RestoreParams(const AParams: TcxViewParams);
begin
  Params := AParams;
end;

procedure TcxCustomGridCellViewInfo.SaveParams(out AParams: TcxViewParams);
begin
  AParams := Params;
end;

procedure TcxCustomGridCellViewInfo.SetHeight(Value: Integer);
begin
  with Bounds do
    Bottom := Top + Value;
end;

procedure TcxCustomGridCellViewInfo.SetMouseCapture(Value: Boolean);
begin
  if (Control <> nil) and (MouseCapture <> Value) then
    if Value then
      Control.MouseCaptureObject := Self
    else
      Control.MouseCaptureObject := nil;
end;

procedure TcxCustomGridCellViewInfo.SetWidth(Value: Integer);
begin
  with Bounds do
    Right := Left + Value;
end;

procedure TcxCustomGridCellViewInfo.StateChanged;
begin
  if InvalidateOnStateChange then Invalidate;
  case State of
    gcsNone:
      EndMouseTracking(Self);
    gcsSelected:
      if Control <> nil then
        BeginMouseTracking(Control, Bounds, Self);
  end;
  if CaptureMouseOnPress then
    case State of
      gcsPressed:
        MouseCapture := True;
      {gcsNone:
        MouseCapture := False; - commented because of the Offset happening during drag&drop}
    end;
  if (State = gcsPressed) and (DropDownWindow <> nil) then
    DropDown;
end;

procedure TcxCustomGridCellViewInfo.DropDown;
begin
  if DropDownWindow.Visible then Exit;
  DropDownWindow.Owner := Self;
  DropDownWindow.Popup;
end;

procedure TcxCustomGridCellViewInfo.CloseUp;
begin
  State := gcsNone;
end;

function TcxCustomGridCellViewInfo.ClosePopupOnDestruction: Boolean;
begin
  Result := True;
end;

function TcxCustomGridCellViewInfo.DropDownWindowExists: Boolean;
begin
  Result := False;
end;

function TcxCustomGridCellViewInfo.GetDropDownWindow: TcxCustomGridPopup;
begin
  Result := nil;
end;

function TcxCustomGridCellViewInfo.GetDropDownWindowOwnerBounds: TRect;
begin
  Result := Bounds;
end;

procedure TcxCustomGridCellViewInfo.AfterRecalculation;
begin
end;

procedure TcxCustomGridCellViewInfo.BeforeDestruction;
begin
  Destroying;
  inherited;
end;

procedure TcxCustomGridCellViewInfo.BeforeRecalculation;
begin
  CalculateParamsNeeded;
  //ResetContentBounds;
end;

procedure TcxCustomGridCellViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  CalculateParams;
  if AWidth = -1 then AWidth := CalculateWidth;
  if AHeight = -1 then AHeight := CalculateHeight;
  with Bounds do
  begin
    Left := ALeftBound;
    Top := ATopBound;
    Right := Left + AWidth;
    Bottom := Top + AHeight;
  end;
  AfterCalculateBounds(Bounds);
  FCalculated := True;
end;

procedure TcxCustomGridCellViewInfo.Calculate(const ABounds: TRect);
begin
  with ABounds do
    Calculate(Left, Top, Max(0, Right - Left), Max(0, Bottom - Top));
end;

function TcxCustomGridCellViewInfo.GetAreaBoundsForPainting: TRect;
begin
  Result := Bounds;
end;

function TcxCustomGridCellViewInfo.GetBestFitWidth: Integer;
begin
  Result := BorderSize[bLeft] + TextWidthWithOffset + BorderSize[bRight];
end;

function TcxCustomGridCellViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  if VisibleForHitTest and HasHitTestPoint(P) and (GetHitTestClass <> nil) then
  begin
    Result := GetHitTestClass.Instance(P);
    InitHitTest(Result);
  end
  else
    Result := nil;
end;

function TcxCustomGridCellViewInfo.HasPoint(const P: TPoint): Boolean;
begin
  Result := PtInRect(GetBounds, P);
end;

procedure TcxCustomGridCellViewInfo.Invalidate;
begin
  DoInvalidate;
end;

function TcxCustomGridCellViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := False;
  if (AButton = mbLeft) and HotTrack and HasMouse(AHitTest) then
  begin
    if IsCheck then
      case FState of
        gcsSelected:
          State := gcsPressed;
        gcsPressed:
          State := gcsSelected;
      end
    else
      State := gcsPressed;
    Result := True;
  end;
end;

function TcxCustomGridCellViewInfo.MouseMove(AHitTest: TcxCustomGridHitTest;
  AShift: TShiftState): Boolean;
begin
  Result := False;
  if HotTrack then
    if IsCheck then
      if State <> gcsPressed then
      begin
        if HasMouse(AHitTest) then
          State := gcsSelected
        else
          State := gcsNone;
        Result := True;
      end
      else
    else
    begin
      if HasMouse(AHitTest) then
        if MouseCapture then
          State := gcsPressed
        else
          State := gcsSelected
      else
        if MouseCapture then
          State := gcsSelected
        else
          State := gcsNone;
      Result := True;
    end;
end;

function TcxCustomGridCellViewInfo.MouseUp(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := False;
  if (AButton = mbLeft) and not IsCheck then
  begin
    Result := State = gcsPressed;
    State := gcsNone;
    if Result then Click;
  end;
end;

procedure TcxCustomGridCellViewInfo.DoOffset(DX, DY: Integer);
begin
  Offset(DX, DY);
  State := gcsNone;
  MouseLeave;
end;

procedure TcxCustomGridCellViewInfo.Paint(ACanvas: TcxCanvas = nil);
begin
  {if ACanvas = nil then ACanvas := Canvas;
  if Visible and ACanvas.RectVisible(Bounds) and (GetPainterClass <> nil) then
  begin
    with GetPainterClass.Create(ACanvas, Self) do
      try
        MainPaint;
      finally
        Free;
      end;
  end;}
  if IsVisibleForPainting and (GetPainterClass <> nil) then
  begin
    if ACanvas = nil then ACanvas := Canvas;
    with GetPainterClass.Create(ACanvas, Self) do
      try
        MainPaint;
      finally
        Free;
      end;
  end;
end;

procedure TcxCustomGridCellViewInfo.Recalculate;
begin
  BeforeRecalculation;
  Calculate(Bounds);
end;

procedure TcxCustomGridCellViewInfo.ResetContentBounds;
begin
  SetRectEmpty(FClientBounds);
  SetRectEmpty(FContentBounds);
end;

{ TcxCustomGridViewCellViewInfo }

constructor TcxCustomGridViewCellViewInfo.Create(AGridViewInfo: TcxCustomGridViewInfo);
begin
  inherited Create;
  FGridViewInfo := AGridViewInfo;
end;

destructor TcxCustomGridViewCellViewInfo.Destroy;
begin
  FGridViewInfo.RemoveActiveViewInfo(Self, True);
  if Controller.HintCellViewInfo = Self then
    Controller.HideHint;
  inherited;
end;

function TcxCustomGridViewCellViewInfo.GetController: TcxCustomGridController;
begin
  Result := GridView.Controller;
end;

function TcxCustomGridViewCellViewInfo.GetGridView: TcxCustomGridView;
begin
  Result := FGridViewInfo.GridView;
end;

function TcxCustomGridViewCellViewInfo.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := FGridViewInfo.LookAndFeelPainter;
end;

function TcxCustomGridViewCellViewInfo.GetCanvas: TcxCanvas;
begin
  Result := FGridViewInfo.Canvas;
end;

procedure TcxCustomGridViewCellViewInfo.AfterCalculateBounds(var ABounds: TRect);
var
  AHitTest: TcxCustomGridHitTest;
begin
  inherited;
  if EmulateMouseMoveAfterCalculate and HotTrack and
    Control.HandleAllocated and GridViewInfo.Visible and
    PtInRect(Bounds, GridViewInfo.MousePos) then
  begin
    AHitTest := GetHitTestClass.Instance(GridViewInfo.MousePos);
    InitHitTest(AHitTest);
    MouseMove(AHitTest, []);
  end;
end;

procedure TcxCustomGridViewCellViewInfo.DoInvalidate;
begin
  GridView.ViewChanged(Bounds);
end;

function TcxCustomGridViewCellViewInfo.EmulateMouseMoveAfterCalculate: Boolean;
begin
  Result := False;
end;

function TcxCustomGridViewCellViewInfo.GetControl: TcxControl;
begin
  Result := GridView.Site;
end;

function TcxCustomGridViewCellViewInfo.HasMouse(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := inherited HasMouse(AHitTest) and
    (TcxCustomGridViewHitTest(AHitTest).GridView = GridView);
end;

procedure TcxCustomGridViewCellViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  GridViewInfo.InitHitTest(AHitTest);
end;

function TcxCustomGridViewCellViewInfo.CanShowHint: Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridViewCellViewInfo.CheckHint(AHitTest: TcxCustomGridHitTest);
var
  AHintText: TCaption;
  AIsHintMultiLine: Boolean;
  ATextRect, R: TRect;
begin
  if NeedShowHint(AHitTest.Pos, AHintText, AIsHintMultiLine, ATextRect) then
  begin
    R := GetAreaBoundsForHint;
    if not IsRectEmpty(R) then
    begin
      IntersectRect(R, ATextRect, R);
      if not IsRectEmpty(R) then ATextRect := R;
    end;
    Controller.ShowHint(GetBoundsForHint, ATextRect, AHintText, AIsHintMultiLine,
      Params.Font, Self);
  end
  else
    Controller.HideHint;
end;

function TcxCustomGridViewCellViewInfo.GetAreaBoundsForHint: TRect;
begin
  Result := GetAreaBounds;
end;

function TcxCustomGridViewCellViewInfo.GetBoundsForHint: TRect;
var
  R: TRect;
begin
  Result := GetCellBoundsForHint;
  R := GetAreaBoundsForHint;
  if not IsRectEmpty(R) then
    IntersectRect(Result, Result, R);
end;

function TcxCustomGridViewCellViewInfo.GetCellBoundsForHint: TRect;
begin
  Result := TextAreaBounds;
end;

function TcxCustomGridViewCellViewInfo.GetHintText: string;
begin
  Result := Text;
end;

function TcxCustomGridViewCellViewInfo.GetHintTextRect(const AMousePos: TPoint): TRect;
begin
  Result := TextAreaBounds;
end;

function TcxCustomGridViewCellViewInfo.HasHintPoint(const P: TPoint): Boolean;
begin
  Result := PtInRect(GetBoundsForHint, P);
end;

procedure TcxCustomGridViewCellViewInfo.InitHint(const AMousePos: TPoint;
  out AHintText: TCaption; out AIsHintMultiLine: Boolean; out ATextRect: TRect);
begin
  AHintText := HintText;
  AIsHintMultiLine := IsHintMultiLine;
  ATextRect := GetHintTextRect(AMousePos);
end;

function TcxCustomGridViewCellViewInfo.IsHintForText: Boolean;
begin
  Result := True;
end;

function TcxCustomGridViewCellViewInfo.IsHintMultiLine: Boolean;
begin
  Result := MultiLinePainting;
end;

function TcxCustomGridViewCellViewInfo.NeedShowHint(const AMousePos: TPoint;
  out AHintText: TCaption; out AIsHintMultiLine: Boolean; out ATextRect: TRect): Boolean;
var
  ATextBounds, R: TRect;
begin
  Result := (HintText <> '') and HasHintPoint(AMousePos);
  if Result then
  begin
    if IsHintForText then
    begin
      with TextAreaBounds do
        Result := (CalculateTextHeight(True) > Bottom - Top) or
          not MultiLinePainting and (TextWidth > Right - Left);
      if not Result then
      begin
        ATextBounds := TextBounds;
        IntersectRect(R, GetBoundsForHint, ATextBounds);
        Result := not EqualRect(R, ATextBounds);
      end;
    end;
    if Result then
      InitHint(AMousePos, AHintText, AIsHintMultiLine, ATextRect);
  end;
end;

procedure TcxCustomGridViewCellViewInfo.Invalidate;
begin
  if IsDestroying then Exit;
  CalculateParams;
  inherited;
end;

function TcxCustomGridViewCellViewInfo.MouseMove(AHitTest: TcxCustomGridHitTest;
  AShift: TShiftState): Boolean;
begin
  Result := inherited MouseMove(AHitTest, AShift);
  if Visible and CanShowHint then
    CheckHint(AHitTest);
end;

{ TcxCustomGridViewInfo }

constructor TcxCustomGridViewInfo.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  InitializeCriticalSection(FLock);
  FActiveViewInfos := TList.Create;
  FAllowCheckCoordinates := True;
  FAllowHideSite := True;
  CreateSite;
  CreateViewInfos;
end;

destructor TcxCustomGridViewInfo.Destroy;
begin
  DestroySite;
  FreeAndNil(FActiveViewInfos);
  DeleteCriticalSection(FLock);
  inherited;
end;

function TcxCustomGridViewInfo.GetCalculated: Boolean;
begin
  Result := not IsRectEmpty(Bounds);
end;

function TcxCustomGridViewInfo.GetCanvas: TcxCanvas;
begin
  Result := FSite.ActiveCanvas;
end;

function TcxCustomGridViewInfo.GetClientBounds: TRect;
begin
  if FClientBoundsAssigned then
    Result := FClientBounds
  else
    Result := CalculateClientBounds;
end;

function TcxCustomGridViewInfo.GetClientHeight: Integer;
begin
  with ClientBounds do
    Result := Bottom - Top;
end;

function TcxCustomGridViewInfo.GetClientWidth: Integer;
begin
  with ClientBounds do
    Result := Right - Left;
end;

{function TcxCustomGridViewInfo.GetIsCalculating: Boolean;
begin
  Result := FIsCalculating or
    GridView.IsDetail and GridView.MasterGridView.ViewInfo.IsCalculating;
end;}

function TcxCustomGridViewInfo.GetIsInternalUseValue: Boolean;
begin
  Result := GetIsInternalUse or
    GridView.IsDetail and
    (GridView.MasterGridView.ViewInfo <> nil) and
    GridView.MasterGridView.ViewInfo.IsInternalUse;
end;

procedure TcxCustomGridViewInfo.SetClientBounds(const Value: TRect);
begin
  FClientBounds := Value;
  FClientBoundsAssigned := True;
end;

procedure TcxCustomGridViewInfo.CreateViewInfos;
begin
end;

procedure TcxCustomGridViewInfo.DestroyViewInfos(AIsRecreating: Boolean);
begin
end;

procedure TcxCustomGridViewInfo.RecreateViewInfos;
begin
  FClientBoundsAssigned := False;
  DestroyViewInfos(True);
  CreateViewInfos;
end;

function TcxCustomGridViewInfo.CanHideSite: Boolean;
var
  AGrid: TcxCustomGrid;
begin
  AGrid := TcxCustomGrid(Control);
  Result := (Control = nil) or GridView.IsDestroying or
    FAllowHideSite and not FSite.IsFocused and
      ((AGrid.FocusedView = nil) or not FSite.ContainsControl(AGrid.FocusedView.Site));
end;

procedure TcxCustomGridViewInfo.CreateSite;
begin
  FSite := GetSiteClass.Create(Self);
end;

procedure TcxCustomGridViewInfo.DestroySite;
begin
  FreeAndNil(FSite);
end;

function TcxCustomGridViewInfo.GetSiteClass: TcxGridSiteClass;
begin
  Result := TcxGridSite;
end;

function TcxCustomGridViewInfo.GetSiteParent: TWinControl;
begin
  if GridView.IsDetail then
    Result := GridView.MasterGridView.Site
  else
    Result := Control;
end;

procedure TcxCustomGridViewInfo.AddActiveViewInfo(AViewInfo: TObject);
begin
  FActiveViewInfos.Add(AViewInfo);
end;

function TcxCustomGridViewInfo.IsViewInfoActive(AViewInfo: TObject): Boolean;
begin
  Result := FActiveViewInfos.IndexOf(AViewInfo) <> -1;
end;

procedure TcxCustomGridViewInfo.RemoveActiveViewInfo(AViewInfo: TObject;
  ARemoveAll: Boolean = False);
var
  AIndex: Integer;
begin
  repeat
    AIndex := FActiveViewInfos.IndexOf(AViewInfo);
    if AIndex = -1 then Break;
    FActiveViewInfos.Delete(AIndex);
    if not ARemoveAll then Break;
  until False;
end;

procedure TcxCustomGridViewInfo.AddScrollBarHeight(var AHeight: Integer);
begin
  if Site.HScrollBarVisible then
    Inc(AHeight, Site.HScrollBar.Height);
end;

procedure TcxCustomGridViewInfo.AfterCalculating;
begin
  if not IsInternalUse then Controller.UpdateScrollBars;
  if CanCheckCoordinates then Controller.DoCheckCoordinates;
end;

procedure TcxCustomGridViewInfo.BeforeCalculating;
begin
  UpdateMousePos;
end;

procedure TcxCustomGridViewInfo.Calculate;
begin
end;

function TcxCustomGridViewInfo.CalculateClientBounds: TRect;
begin
  Result := Bounds;
end;

procedure TcxCustomGridViewInfo.CalculateHeight(const AMaxSize: TPoint;
  var AHeight: Integer; var AFullyVisible: Boolean);
begin
  AddScrollBarHeight(AHeight);
end;

procedure TcxCustomGridViewInfo.CalculateWidth(const AMaxSize: TPoint; var AWidth: Integer);
begin
  if Site.VScrollBarVisible then
    Inc(AWidth, Site.VScrollBar.Width);
  if AWidth > AMaxSize.X then AWidth := AMaxSize.X;
end;

function TcxCustomGridViewInfo.CanCheckCoordinates: Boolean;
begin
  Result := not IsInternalUse and FAllowCheckCoordinates;
end;

procedure TcxCustomGridViewInfo.ControlFocusChanged;
begin
end;

function TcxCustomGridViewInfo.DoGetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := TcxGridViewNoneHitTest.Instance(P);
  InitHitTest(Result);
end;

function TcxCustomGridViewInfo.GetAllowBoundsChangedNotification: Boolean;
begin
  Result := not IsCalculating and not VisibilityChanging;
end;

function TcxCustomGridViewInfo.GetBackgroundBitmap: TBitmap;
begin       {4}
  Result := GridView.BackgroundBitmaps.GetBitmap(bbBackground);
end;

function TcxCustomGridViewInfo.GetBackgroundColor: TColor;
var
  AParams: TcxViewParams;
begin
  GridView.Styles.GetViewParams(vsBackground, nil, nil, AParams);
  Result := AParams.Color;
end;

procedure TcxCustomGridViewInfo.GetHScrollBarBounds(var ABounds: TRect);
begin
end;

function TcxCustomGridViewInfo.GetIsInternalUse: Boolean;
begin
  Result := FIsInternalUse;
end;

function TcxCustomGridViewInfo.GetVisible: Boolean;
begin
  Result := not IsInternalUse and not FSizeCalculating and
    not GridView.DataController.IsUpdatingItems;
end;

procedure TcxCustomGridViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  (AHitTest as TcxCustomGridViewHitTest).GridView := GridView;
end;

procedure TcxCustomGridViewInfo.UpdateMousePos;
begin
  if FSite.Left = cxGridInvisibleCoordinate then Exit;
  if FSite.HandleAllocated and not FSite.IsDesigning then
    FMousePos := FSite.ScreenToClient(GetMouseCursorPos)
  else
    FMousePos := Point(MaxInt, MaxInt);
end;

procedure TcxCustomGridViewInfo.VisibilityChanged(AVisible: Boolean);
begin
  UpdateMousePos;
  if AVisible then
  begin
    FSite.Parent := GetSiteParent;
  end
  else
    if CanHideSite then
    begin
      FSite.Parent := nil;
    end
    else
      FSite.Left := cxGridInvisibleCoordinate;
end;

procedure TcxCustomGridViewInfo.BeforeDestruction;
begin
  inherited;
  DestroyViewInfos(False);
end;

procedure TcxCustomGridViewInfo.DoVisibilityChanged(AVisible: Boolean);
begin
  if Visible then
  begin
    FVisibilityChanging := True;
    try
      VisibilityChanged(AVisible and GridView.Visible);
    finally
      FVisibilityChanging := False;
    end;
  end;
end;

function TcxCustomGridViewInfo.GetFontHeight(AFont: TFont): Integer;
begin
  Canvas.Font := AFont;
  Result := Canvas.TextHeight('Qq');
end;

procedure TcxCustomGridViewInfo.GetFontMetrics(AFont: TFont; out AMetrics: TTextMetric);
begin
  Canvas.Font := AFont;
  GetTextMetrics(Canvas.Handle, AMetrics);
end;

procedure TcxCustomGridViewInfo.GetHeight(const AMaxSize: TPoint; var AHeight: Integer;
  var AFullyVisible: Boolean);
begin
  FSizeCalculating := True;
  CalculateHeight(AMaxSize, AHeight, AFullyVisible);
  FSizeCalculating := False;
end;

function TcxCustomGridViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  if (Controller.CustomizationForm <> nil) and Site.HandleAllocated and
    PtInRect(Controller.CustomizationForm.BoundsRect, Site.ClientToScreen(P)) then
  begin
    Result := TcxGridCustomizationFormHitTest.Instance(P);
    InitHitTest(Result);
  end
  else
    Result := DoGetHitTest(P);
end;

function TcxCustomGridViewInfo.GetHitTest(X, Y: Integer): TcxCustomGridHitTest;
begin
  Result := GetHitTest(Point(X, Y));
end;

procedure TcxCustomGridViewInfo.GetWidth(const AMaxSize: TPoint; var AWidth: Integer);
begin
  FSizeCalculating := True;
  CalculateWidth(AMaxSize, AWidth);
  FSizeCalculating := False;
end;

procedure TcxCustomGridViewInfo.MainCalculate(const ABounds: TRect);
{
var ft,lt,i:integer;
}
begin
  if FIsCalculating {or GridView.IsPattern} then Exit;
{
  ft:=gettickcount;
  for i:=1 to 1 + 9 * ord(not isinternaluse) do
  begin
}
  BeforeCalculating;
  FIsCalculating := True;
  try
    FSite.BoundsRect := ABounds;
    FBounds := FSite.ClientBounds;
    Calculate;
  finally
    FIsCalculating := False;
    AfterCalculating;
    DoVisibilityChanged(True);
  end;
{
  end;
  lt:=gettickcount;
  if not isinternaluse then
  application.MainForm.Caption := inttostr(lt-ft);
}  
end;

procedure TcxCustomGridViewInfo.Recalculate;
begin
  MainCalculate(FSite.BoundsRect);
end;

{ TcxCustomGridViewInfoCacheItem }

constructor TcxCustomGridViewInfoCacheItem.Create(AOwner: TcxCustomGridViewInfoCache;
  AIndex: Integer);
begin
  inherited Create;
  FIndex := AIndex;
  FOwner := AOwner;
end;

procedure TcxCustomGridViewInfoCacheItem.UnassignValues(AKeepMaster: Boolean);
begin
end;

{ TcxCustomGridViewInfoCache }

constructor TcxCustomGridViewInfoCache.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FItems := TList.Create;
end;

destructor TcxCustomGridViewInfoCache.Destroy;
begin
  DestroyItems;
  FItems.Free;
  inherited;
end;

function TcxCustomGridViewInfoCache.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxCustomGridViewInfoCache.GetInternalItem(Index: Integer): TcxCustomGridViewInfoCacheItem;
begin
  Result := TcxCustomGridViewInfoCacheItem(FItems[Index]);
end;

function TcxCustomGridViewInfoCache.GetItem(Index: Integer): TcxCustomGridViewInfoCacheItem;
begin
  Result := InternalItems[Index];
  if Result = nil then
  begin
    Result := GetItemClass(Index).Create(Self, Index);
    FItems[Index] := Result;
  end;
end;

procedure TcxCustomGridViewInfoCache.SetCount(Value: Integer);
begin
  DestroyItems;
  FItems.Count := Value;
end;

procedure TcxCustomGridViewInfoCache.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do TObject(FItems[I]).Free;
  FItems.Clear;
end;

procedure TcxCustomGridViewInfoCache.UnassignValues(AKeepMaster: Boolean = False);

  procedure ProcessItems;
  var
    I: Integer;
    AItem: TcxCustomGridViewInfoCacheItem;
  begin
    for I := 0 to Count - 1 do
    begin
      AItem := InternalItems[I];
      if AItem <> nil then AItem.UnassignValues(AKeepMaster);
    end;
  end;

  procedure ProcessMasterItems;
  var
    AGridView: TcxCustomGridView;
    AGridRecordIndex: Integer;
  begin
    AGridView := GridView;
    while AGridView.IsDetail do
    begin
      AGridRecordIndex := AGridView.MasterGridRecordIndex;
      AGridView := AGridView.MasterGridView;
      if (AGridRecordIndex <> -1) and (AGridView.ViewInfoCache <> nil) then
        AGridView.ViewInfoCache[AGridRecordIndex].UnassignValues(False);
    end;
  end;

begin
  if FUnassigningValues then Exit;
  FUnassigningValues := True;
  try
    ProcessItems;
    if not AKeepMaster then ProcessMasterItems;
  finally
    FUnassigningValues := False;
  end;
end;

{ TcxCustomGridOptions }

constructor TcxCustomGridOptions.Create(AGridView: TcxCustomGridView);
begin
  inherited Create(nil);
  FGridView := AGridView;
  if GridView <> nil then GridView.AddOptions(Self);
end;

destructor TcxCustomGridOptions.Destroy;
begin
  if GridView <> nil then GridView.RemoveOptions(Self);
  inherited;
end;

function TcxCustomGridOptions.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := GridView.LookAndFeelPainter;
end;

procedure TcxCustomGridOptions.Changed(AChangeKind: TcxGridViewChangeKind);
begin
  GridView.Changed(AChangeKind);
end;

function TcxCustomGridOptions.GetGridViewValue: TcxCustomGridView;
begin
  Result := FGridView;
end;

procedure TcxCustomGridOptions.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
end;

procedure TcxCustomGridOptions.GetStoredProperties(AProperties: TStrings);
begin
end;

procedure TcxCustomGridOptions.GetStoredPropertyValue(const AName: string;
  var AValue: Variant);
begin
end;

procedure TcxCustomGridOptions.SetStoredPropertyValue(const AName: string;
  const AValue: Variant);
begin
end;

procedure TcxCustomGridOptions.Assign(Source: TPersistent);
begin
  if not (Source is TcxCustomGridOptions) then
    inherited;
end;

{ TcxCustomGridBackgroundBitmaps }

constructor TcxCustomGridBackgroundBitmaps.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FItems := TList.Create;
end;

destructor TcxCustomGridBackgroundBitmaps.Destroy;

  procedure ClearItems;
  var
    I: Integer;
  begin
    for I := 0 to Count - 1 do
      if FItems[I] <> nil then TBitmap(FItems[I]).Free;
  end;

begin
  ClearItems;
  FItems.Free;
  inherited;
end;

function TcxCustomGridBackgroundBitmaps.GetCount: Integer;
begin
  Result := FItems.Count;
end;

procedure TcxCustomGridBackgroundBitmaps.BitmapChanged(Sender: TObject);
begin
  Changed(vcLayout);
end;

function TcxCustomGridBackgroundBitmaps.GetBitmapStyleIndex(Index: Integer): Integer;
begin
  if Index = bbBackground then
    Result := vsBackground
  else
    Result := -1;
end;

function TcxCustomGridBackgroundBitmaps.GetDefaultBitmap(Index: Integer): TBitmap;
var
  AStyleIndex: Integer;
begin
  AStyleIndex := GetBitmapStyleIndex(Index);
  if AStyleIndex = -1 then
    Result := nil
  else
    Result := GridView.Styles.GetBitmap(AStyleIndex);
end;

function TcxCustomGridBackgroundBitmaps.GetValue(Index: Integer): TBitmap;
begin
  if Index >= Count then
    FItems.Count := Index + 1;
  if FItems[Index] = nil then
  begin
    FItems[Index] := TBitmap.Create;
    TBitmap(FItems[Index]).OnChange := BitmapChanged;
  end;
  Result := TBitmap(FItems[Index]);
end;

procedure TcxCustomGridBackgroundBitmaps.SetValue(Index: Integer; Value: TBitmap);
begin
  Values[Index].Assign(Value);
end;

procedure TcxCustomGridBackgroundBitmaps.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridBackgroundBitmaps then
    with TcxCustomGridBackgroundBitmaps(Source) do
      Self.Background := Background;
  inherited;
end;

function TcxCustomGridBackgroundBitmaps.GetBitmap(Index: Integer): TBitmap;
begin
  Result := Values[Index];
  if Result.Empty then
    Result := GetDefaultBitmap(Index);
end;

{ TcxCustomGridOptionsBehavior }

constructor TcxCustomGridOptionsBehavior.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FPostponedSynchronization := True;
end;

function TcxCustomGridOptionsBehavior.GetPostponedSynchronization: Boolean;
begin
  if GridView.PatternGridView = GridView then
    Result := FPostponedSynchronization
  else
    Result := GridView.PatternGridView.OptionsBehavior.PostponedSynchronization;
end;

procedure TcxCustomGridOptionsBehavior.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridOptionsBehavior then
    PostponedSynchronization := TcxCustomGridOptionsBehavior(Source).PostponedSynchronization;
  inherited;
end;

{ TcxCustomGridOptionsView }

function TcxCustomGridOptionsView.GetScrollBars: TScrollStyle;
begin
  Result := GridView.Site.ScrollBars;
end;

procedure TcxCustomGridOptionsView.SetScrollBars(Value: TScrollStyle);
begin
  if ScrollBars <> Value then
  begin
    GridView.Site.ScrollBars := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridOptionsView.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridOptionsView then
    with TcxCustomGridOptionsView(Source) do
      Self.ScrollBars := ScrollBars;
  inherited;
end;

{ TcxCustomGridStyles }

function TcxCustomGridStyles.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := GridView.LookAndFeelPainter;
end;

procedure TcxCustomGridStyles.Changed(AIndex: Integer);
begin
  inherited;
  if GridView <> nil then
  begin
    GridView.UpdateFakeLinks;
    GridView.Changed(vcSize);
  end;
end;

procedure TcxCustomGridStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
var
  AGrid: TcxCustomGrid;
begin
  inherited;
  AGrid := TcxCustomGrid(GridView.Control);
  if AGrid = nil then
    AParams.Font := GridView.Painter.Canvas.Font
  else
    AParams.Font := AGrid.Font;
end;

procedure TcxCustomGridStyles.GetFakeComponentLinks(AList: TList);
var
  I: Integer;
  AOwner: TComponent;
begin
  for I := 0 to Count - 1 do
  begin
    AOwner := Items[I].Item.Owner;
    if (AOwner <> GridView.Owner) and (AList.IndexOf(AOwner) = -1) then
      AList.Add(AOwner);
  end;
end;

{ TcxCustomGridViewStyles }

procedure TcxCustomGridViewStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
begin
  inherited;
  with AParams, LookAndFeelPainter do
    case Index of
      vsBackground:
        begin
          Color := DefaultContentColor;
          TextColor := clGrayText;
        end;  
    end;
end;

function TcxCustomGridViewStyles.GetGridView: TcxCustomGridView;
begin
  if GetOwner is TcxCustomGridView then
    Result := TcxCustomGridView(GetOwner)
  else
    Result := nil;
end;

procedure TcxCustomGridViewStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxCustomGridViewStyles then
    with TcxCustomGridViewStyles(Source) do
      Self.Background := Background;
end;

{ TcxGridListenerLink }

constructor TcxGridListenerLink.Create(AGridView: TcxCustomGridView);
begin
  inherited Create;
  FGridView := AGridView;
end;

destructor TcxGridListenerLink.Destroy;
begin
  if FGridView <> nil then
    FGridView.RemoveListenerLink(Self);
  inherited Destroy;
end;

procedure TcxGridListenerLink.Clear;
begin
  FGridView := nil;
end;

{ TcxCustomGridView }

constructor TcxCustomGridView.CreateCloned(AControl: TcxControl);
begin
  CreateEx(AControl);
{$IFDEF DELPHI6}
  FComponentStyle := FComponentStyle + [csTransient];
{$ENDIF}
end;

destructor TcxCustomGridView.Destroy;
begin
  Controller.Customization := False;
  Focused := False;
  if not IsPattern and (PatternGridView <> nil) then
    PatternGridView.RemoveClone(Self);
  if (FLevel <> nil) and (TcxGridLevel(FLevel).GridView = Self) then
    TcxGridLevel(FLevel).GridView := nil;
  if FRepository <> nil then
    TcxGridViewRepositoryAccess(FRepository).RemoveItem(Self);  {5}
  DestroyHandlers;
  DestroyOptions;
  FClones.Free;
  ClearListenerLinks;
  FListenerLinks.Free;
  inherited;
end;

function TcxCustomGridView.GetClone(Index: Integer): TcxCustomGridView;
begin
  Result := TcxCustomGridView(FClones[Index]);
end;

function TcxCustomGridView.GetCloneCount: Integer;
begin
  Result := FClones.Count;
end;

function TcxCustomGridView.GetDragMode: TDragMode;
begin
  Result := Site.DragMode;
end;

function TcxCustomGridView.GetFocused: Boolean;
begin
  Result := (Control <> nil){5} and (TcxCustomGrid(Control).FocusedView = Self);
end;

function TcxCustomGridView.GetIsDetail: Boolean;
begin
  Result := (DataController <> nil) and DataController.IsDetailMode;
end;

function TcxCustomGridView.GetIsMaster: Boolean;
begin
  Result := (FLevel <> nil) and TcxGridLevel(FLevel).IsMaster;
end;

function TcxCustomGridView.GetIsPattern: Boolean;
begin
  Result := {(Level = nil) or }DataController.IsPattern;
end;

function TcxCustomGridView.GetIsStoringNameMode: Boolean;
begin
  Result := FStoringName <> '';
end;

function TcxCustomGridView.GetIsUpdating: Boolean;
begin
  Result := csUpdating in ComponentState;
end;

function TcxCustomGridView.GetLookAndFeel: TcxLookAndFeel;
begin
  if Control = nil then
    Result := nil
  else
    Result := TcxCustomGrid(Control).LookAndFeel;
end;

function TcxCustomGridView.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  if Control = nil then
    Result := TcxStandardLookAndFeelPainter
  else
    Result := TcxCustomGrid(Control).LookAndFeelPainter;
end;

function TcxCustomGridView.GetMasterGridView: TcxCustomGridView;
begin
  if IsDetail then
    Result := (DataController.GetMasterDataController as IcxCustomGridDataController).GridView
  else
    Result := nil;
end;

function TcxCustomGridView.GetMasterGridRecordIndex: Integer;
begin
  if MasterRecordIndex <> -1 then
    Result := MasterGridView.DataController.GetRowIndexByRecordIndex(MasterRecordIndex, False)
  else
    Result := -1;
end;

function TcxCustomGridView.GetMasterRecordIndex: Integer;
begin
  Result := DataController.GetMasterRecordIndex;
end;

function TcxCustomGridView.GetOnDblClick: TNotifyEvent;
begin
  Result := Site.OnDblClick;
end;

function TcxCustomGridView.GetOnDragDrop: TDragDropEvent;
begin
  Result := Site.OnDragDrop;
end;

function TcxCustomGridView.GetOnDragOver: TDragOverEvent;
begin
  Result := Site.OnDragOver;
end;

function TcxCustomGridView.GetOnEndDrag: TEndDragEvent;
begin
  Result := Site.OnEndDrag;
end;

function TcxCustomGridView.GetOnKeyDown: TKeyEvent;
begin
  Result := Site.OnKeyDown;
end;

function TcxCustomGridView.GetOnKeyPress: TKeyPressEvent;
begin
  Result := Site.OnKeyPress;
end;

function TcxCustomGridView.GetOnKeyUp: TKeyEvent;
begin
  Result := Site.OnKeyUp;
end;

function TcxCustomGridView.GetOnMouseDown: TMouseEvent;
begin
  Result := Site.OnMouseDown;
end;

function TcxCustomGridView.GetOnMouseEnter: TNotifyEvent;
begin
  Result := Site.OnMouseEnter;
end;

function TcxCustomGridView.GetOnMouseLeave: TNotifyEvent;
begin
  Result := Site.OnMouseLeave;
end;

function TcxCustomGridView.GetOnMouseMove: TMouseMoveEvent;
begin
  Result := Site.OnMouseMove;
end;

function TcxCustomGridView.GetOnMouseUp: TMouseEvent;
begin
  Result := Site.OnMouseUp;
end;

function TcxCustomGridView.GetOnMouseWheel: TMouseWheelEvent;
begin
  Result := Site.OnMouseWheel;
end;

function TcxCustomGridView.GetOnMouseWheelDown: TMouseWheelUpDownEvent;
begin
  Result := Site.OnMouseWheelDown;
end;

function TcxCustomGridView.GetOnMouseWheelUp: TMouseWheelUpDownEvent;
begin
  Result := Site.OnMouseWheelUp;
end;

function TcxCustomGridView.GetOnStartDrag: TStartDragEvent;
begin
  Result := Site.OnStartDrag;
end;

function TcxCustomGridView.GetPatternGridView: TcxCustomGridView;
begin
  Result := FPatternGridView;
  if Result = nil then Result := Self;
end;

function TcxCustomGridView.GetPopupMenu: TComponent;
begin
  Result := Site.PopupMenu;
end;

function TcxCustomGridView.GetSite: TcxGridSite;
begin
  if FViewInfo = nil then
    Result := nil
  else
    Result := FViewInfo.Site;
end;

function TcxCustomGridView.GetSynchronization: Boolean;
begin
  if PatternGridView = Self then
    Result := FSynchronization
  else
    Result := PatternGridView.Synchronization;
end;

procedure TcxCustomGridView.SetBackgroundBitmaps(Value: TcxCustomGridBackgroundBitmaps);
begin
  FBackgroundBitmaps.Assign(Value);
end;

procedure TcxCustomGridView.SetDragMode(Value: TDragMode);
begin
  if DragMode <> Value then
  begin
    Site.DragMode := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetFocused(Value: Boolean);
begin
  if Focused <> Value then
    with TcxCustomGrid(Control) do
      if Value then
        FocusedView := Self
      else
        FocusedView := nil;
end;

procedure TcxCustomGridView.SetIsRestoring(Value: Boolean);
begin
  if FIsRestoring <> Value then
  begin
    FIsRestoring := Value;
    if FIsRestoring then
      BeforeRestoring
    else
      AfterRestoring;
  end;
end;

procedure TcxCustomGridView.SetSynchronization(Value: Boolean);
begin
  if not IsPattern then Exit;
  if FSynchronization <> Value then
  begin
    FSynchronization := Value;
    if Value then
      Synchronize
    else
      FSynchronizationNeeded := False;
  end;
end;

procedure TcxCustomGridView.SetOnCustomization(Value: TNotifyEvent);
begin
  if @FOnCustomization <> @Value then
  begin
    FOnCustomization := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnDblClick(Value: TNotifyEvent);
begin
  if @OnDblClick <> @Value then
  begin
    Site.OnDblClick := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnDragDrop(Value: TDragDropEvent);
begin
  if @OnDragDrop <> @Value then
  begin
    Site.OnDragDrop := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnDragOver(Value: TDragOverEvent);
begin
  if @OnDragOver <> @Value then
  begin
    Site.OnDragOver := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnEndDrag(Value: TEndDragEvent);
begin
  if @OnEndDrag <> @Value then
  begin
    Site.OnEndDrag := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnGetStoredProperties(Value: TcxGridViewGetStoredPropertiesEvent);
begin
  if @FOnGetStoredProperties <> @Value then
  begin
    FOnGetStoredProperties := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnGetStoredPropertyValue(Value: TcxGridViewGetStoredPropertyValueEvent);
begin
  if @FOnGetStoredPropertyValue <> @Value then
  begin
    FOnGetStoredPropertyValue := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnInitStoredObject(Value: TcxGridInitStoredObjectEvent);
begin
  if @FOnInitStoredObject <> @Value then
  begin
    FOnInitStoredObject := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnKeyDown(Value: TKeyEvent);
begin
  if @OnKeyDown <> @Value then
  begin
    Site.OnKeyDown := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnKeyPress(Value: TKeyPressEvent);
begin
  if @OnKeyPress <> @Value then
  begin
    Site.OnKeyPress := Value;
    Changed(vcProperty);
  end;  
end;

procedure TcxCustomGridView.SetOnKeyUp(Value: TKeyEvent);
begin
  if @OnKeyUp <> @Value then
  begin
    Site.OnKeyUp := Value;
    Changed(vcProperty);
  end;  
end;

procedure TcxCustomGridView.SetOnMouseDown(Value: TMouseEvent);
begin
  if @OnMouseDown <> @Value then
  begin
    Site.OnMouseDown := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnMouseEnter(Value: TNotifyEvent);
begin
  if @OnMouseEnter <> @Value then
  begin
    Site.OnMouseEnter := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnMouseLeave(Value: TNotifyEvent);
begin
  if @OnMouseLeave <> @Value then
  begin
    Site.OnMouseLeave := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnMouseMove(Value: TMouseMoveEvent);
begin
  if @OnMouseMove <> @Value then
  begin
    Site.OnMouseMove := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnMouseUp(Value: TMouseEvent);
begin
  if @OnMouseUp <> @Value then
  begin
    Site.OnMouseUp := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnMouseWheel(Value: TMouseWheelEvent);
begin
  if @OnMouseWheel <> @Value then
  begin
    Site.OnMouseWheel := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnMouseWheelDown(Value: TMouseWheelUpDownEvent);
begin
  if @OnMouseWheelDown <> @Value then
  begin
    Site.OnMouseWheelDown := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnMouseWheelUp(Value: TMouseWheelUpDownEvent);
begin
  if @OnMouseWheelUp <> @Value then
  begin
    Site.OnMouseWheelUp := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnSetStoredPropertyValue(Value: TcxGridViewSetStoredPropertyValueEvent);
begin
  if @FOnSetStoredPropertyValue <> @Value then
  begin
    FOnSetStoredPropertyValue := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOnStartDrag(Value: TStartDragEvent);
begin
  if @OnStartDrag <> @Value then
  begin
    Site.OnStartDrag := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridView.SetOptionsBehavior(Value: TcxCustomGridOptionsBehavior);
begin
  FOptionsBehavior.Assign(Value);
end;

procedure TcxCustomGridView.SetOptionsData(Value: TcxCustomGridOptionsData);
begin
  FOptionsData.Assign(Value);
end;

procedure TcxCustomGridView.SetOptionsSelection(Value: TcxCustomGridOptionsSelection);
begin
  FOptionsSelection.Assign(Value);
end;

procedure TcxCustomGridView.SetOptionsView(Value: TcxCustomGridOptionsView);
begin
  FOptionsView.Assign(Value);
end;

procedure TcxCustomGridView.SetPopupMenu(Value: TComponent);
begin
  if PopupMenu <> Value then
  begin
    Site.PopupMenu := Value;
    Changed(vcProperty)
  end;
end;

procedure TcxCustomGridView.SetStyles(Value: TcxCustomGridStyles);
begin
  FStyles.Assign(Value);
end;

procedure TcxCustomGridView.ClearListenerLinks;
var
  I: Integer;
begin
  for I := FListenerLinks.Count - 1 downto 0 do
    RemoveListenerLink(TcxGridListenerLink(FListenerLinks[I]));
end;

function TcxCustomGridView.GetObjectName: string;
begin
  if IsStoringNameMode then
    Result := FStoringName
  else
    Result := Name;
end;

function TcxCustomGridView.GetProperties(AProperties: TStrings): Boolean;
begin
  AProperties.Add('Version');
  if Assigned(FOnGetStoredProperties) then
    FOnGetStoredProperties(Self, AProperties);
  Result := True;
end;

procedure TcxCustomGridView.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'Version' then
    AValue := StoringVersion;
  if Assigned(FOnGetStoredPropertyValue) then
    FOnGetStoredPropertyValue(Self, AName, AValue);
end;

procedure TcxCustomGridView.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'Version' then
    FStoredVersion := AValue;
  if Assigned(FOnSetStoredPropertyValue) then
    FOnSetStoredPropertyValue(Self, AName, AValue);
end;

function TcxCustomGridView.CreateChild(const AObjectName, AClassName: string): TObject;
begin
  Result := CreateStoredObject(AObjectName, AClassName);
  if not IsStoringNameMode and (Result is TComponent) then
    TComponent(Result).Name := AObjectName;
  DoInitStoredObject(Result);
end;

function TcxCustomGridView.CreateStoredObject(const AObjectName, AClassName: string): TObject;
begin
  Result := nil;
end;

procedure TcxCustomGridView.DeleteChild(const AObjectName: string; AObject: TObject);
begin
  AObject.Free;
end;

procedure TcxCustomGridView.GetStoredChildren(AChildren: TStringList);
begin
end;

procedure TcxCustomGridView.AssignLayout(ALayoutView: TcxCustomGridView);
begin
end;

procedure TcxCustomGridView.BeforeEditLayout(ALayoutView: TcxCustomGridView);
begin
end;

procedure TcxCustomGridView.DoAssignLayout(ALayoutView: TcxCustomGridView);
begin
  BeginUpdate;
  try
    AssignLayout(ALayoutView);
  finally
    EndUpdate;
  end;
end;

function TcxCustomGridView.GetLayoutCustomizationFormButtonCaption: string;
begin
  Result := '';
end;

function TcxCustomGridView.HasLayoutCustomizationForm: Boolean;
begin
  Result := False;
end;

function TcxCustomGridView.IsLayoutChangeable: Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridView.RunLayoutCustomizationForm;
begin
  Controller.Customization := True;
end;

procedure TcxCustomGridView.DoMenuItemAction(AIndex: Integer; var AModified: Boolean);
begin
end;

function TcxCustomGridView.GetMenuItemAction(AIndex: Integer): TcxGridViewDesignerMenuItemAction;
begin
  Result := vmiaNone;
end;

function TcxCustomGridView.GetMenuItemCount: Integer;
begin
  Result := 0;
end;

function TcxCustomGridView.GetMenuItemObject(AIndex: Integer): TObject;
begin
  Result := nil;
end;

procedure TcxCustomGridView.PrepareMenuItem(AIndex: Integer; AMenuItem: TMenuItem);
begin
end;

procedure TcxCustomGridView.GetFakeComponentLinks(AList: TList);
begin
  inherited;
  (FDataController as IcxCustomGridDataController).GetFakeComponentLinks(AList);
  FStyles.GetFakeComponentLinks(AList);
end;

function TcxCustomGridView.GetIsDestroying: Boolean;
begin
  Result := inherited GetIsDestroying or
    IsDetail and MasterGridView.IsDestroying;
end;

procedure TcxCustomGridView.Loaded;
begin
  inherited;
  LoadingComplete;
  DataController.Loaded;
  Init;
end;

procedure TcxCustomGridView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  NotifyOptions(AComponent, Operation);
end;

procedure TcxCustomGridView.SetControl(Value: TcxControl);
begin
  if Control <> Value then
  begin
    if Control <> nil then
    begin
      TcxCustomGrid(Control).RemoveFontListener(FStyles);  {5}
      if Site <> nil then
        Control.RemoveComponent(Site);
    end;
    inherited;
    if Control <> nil then
    begin
      if (FStorageControl = nil) and (FRepository = nil) then
        FStorageControl := Value;
      Control.InsertComponent(Site);
      TcxCustomGrid(Control).AddFontListener(FStyles);
    end;
  end;  
end;

procedure TcxCustomGridView.SetName(const NewName: TComponentName);
begin
  inherited;
  NotifyControl(vcnName);
end;

procedure TcxCustomGridView.Updated;
begin
  inherited;
  EndUpdate;
end;

procedure TcxCustomGridView.Updating;
begin
  BeginUpdate;
  inherited;
end;

procedure TcxCustomGridView.CreateHandlers;
begin
  FController := GetControllerClass.Create(Self);
  FDataController := GetDataControllerClass.Create(Self);
  InitDataController;
  FPainter := GetPainterClass.Create(Self);
  FViewData := GetViewDataClass.Create(Self);
  FViewInfo := CreateViewInfo;
  if GetViewInfoCacheClass <> nil then
    FViewInfoCache := GetViewInfoCacheClass.Create(Self);
end;

procedure TcxCustomGridView.DestroyHandlers;
begin 
  FDataController.Free;
  FDataController := nil;
  FreeAndNil(FViewInfoCache);
  if Control <> nil then
    Control.RemoveComponent(Site);  {5}
  FViewInfo.Free;
  FViewInfo := nil;
  FreeAndNil(FViewData);
  FreeAndNil(FPainter);
  FreeAndNil(FController);
end;

procedure TcxCustomGridView.InitDataController;
begin
  FDataController.OnUpdateControl := UpdateControl;
end;

procedure TcxCustomGridView.CreateOptions;
begin
  FOptionsList := TList.Create;
  FBackgroundBitmaps := GetBackgroundBitmapsClass.Create(Self);
  FOptionsBehavior := GetOptionsBehaviorClass.Create(Self);
  FOptionsData := GetOptionsDataClass.Create(Self);
  FOptionsSelection := GetOptionsSelectionClass.Create(Self);
  FOptionsView := GetOptionsViewClass.Create(Self);
  FStyles := GetStylesClass.Create(Self);
end;

procedure TcxCustomGridView.DestroyOptions;
begin
  if Control <> nil then  {5}
    TcxCustomGrid(Control).RemoveFontListener(FStyles);
  FreeAndNil(FStyles);
  FreeAndNil(FOptionsView);
  FreeAndNil(FOptionsSelection);
  FreeAndNil(FOptionsData);
  FreeAndNil(FOptionsBehavior);
  FreeAndNil(FBackgroundBitmaps);
  FreeAndNil(FOptionsList);
end;

procedure TcxCustomGridView.AddOptions(AOptions: TcxCustomGridOptions);
begin
  FOptionsList.Add(AOptions);
end;

procedure TcxCustomGridView.RemoveOptions(AOptions: TcxCustomGridOptions);
begin
  FOptionsList.Remove(AOptions);
end;

procedure TcxCustomGridView.NotifyOptions(AComponent: TComponent;
  AOperation: TOperation);
var
  I: Integer;
begin
  if FOptionsList = nil then Exit;
  for I := 0 to FOptionsList.Count - 1 do
    TcxCustomGridOptions(FOptionsList[I]).Notification(AComponent, AOperation);
end;

procedure TcxCustomGridView.AddClone(AClone: TcxCustomGridView);
begin
  FClones.Add(AClone);
  AClone.FPatternGridView := Self;
end;

procedure TcxCustomGridView.RemoveClone(AClone: TcxCustomGridView);
begin
  FClones.Remove(AClone);
  AClone.FPatternGridView := nil;
end;

function TcxCustomGridView.AddListenerLink: TcxGridListenerLink;
begin
  Result := TcxGridListenerLink.Create(Self);
  FListenerLinks.Add(Result);
end;

procedure TcxCustomGridView.RemoveListenerLink(ALink: TcxGridListenerLink);
begin
  ALink.Clear;
  FListenerLinks.Remove(ALink);
end;

procedure TcxCustomGridView.AssignPattern(APattern: TcxCustomGridView);
begin
  FAssigningPattern := True;
  try
    Assign(APattern);
  finally
    FAssigningPattern := False;
  end;
end;

procedure TcxCustomGridView.Synchronize(ACheckUpdateLock: Boolean = True);
var
  I: Integer;
begin
  if IsLoading or IsDestroying or (Control = nil) or
    not IsSynchronization or FAssigningPattern or FSynchronizationAssignNeeded then
    Exit;
  if ACheckUpdateLock and IsUpdateLocked then
  begin
    FSynchronizationNeeded := True;
    Exit;
  end;
  FIsSynchronizing := True;
  try
    if IsPattern then
    begin
      BeginUpdate;
      try
        for I := 0 to CloneCount - 1 do
          Clones[I].Synchronize(Self);
      finally
        EndUpdate;
      end;
    end
    else
      PatternGridView.Synchronize(Self);
  finally
    FIsSynchronizing := False;
    FSynchronizationNeeded := False;
  end;
end;

procedure TcxCustomGridView.Synchronize(AView: TcxCustomGridView);
begin
  if not IsSynchronization or FIsSynchronizing or FAssigningPattern then Exit;
  if OptionsBehavior.PostponedSynchronization and not IsPattern and not Visible then
  begin
    FSynchronizationAssignNeeded := True;
    Exit;
  end;
  BeginUpdate;
  try
    AssignPattern(AView);
    if IsPattern then Synchronize;
  finally
    EndUpdate;
    FSynchronizationAssignNeeded := False;
  end;
end;

procedure TcxCustomGridView.BeforeAssign(ASource: TcxCustomGridView);
begin
  DataController.Assign(ASource.DataController);
end;

procedure TcxCustomGridView.DoAssign(ASource: TcxCustomGridView);
begin
  with ASource do
  begin
    Self.BackgroundBitmaps := BackgroundBitmaps;
    Self.DragMode := DragMode;
    Self.OptionsBehavior := OptionsBehavior;
    Self.OptionsData := OptionsData;
    Self.OptionsSelection := OptionsSelection;
    Self.OptionsView := OptionsView;
    Self.PopupMenu := PopupMenu;
    Self.Styles := Styles;
    Self.Synchronization := Synchronization;
    Self.OnCustomization := OnCustomization;
    Self.OnDblClick := OnDblClick;
    Self.OnDragDrop := OnDragDrop;
    Self.OnDragOver := OnDragOver;
    Self.OnEndDrag := OnEndDrag;
    Self.OnGetStoredProperties := OnGetStoredProperties;
    Self.OnGetStoredPropertyValue := OnGetStoredPropertyValue;
    Self.OnInitStoredObject := OnInitStoredObject;
    Self.OnKeyDown := OnKeyDown;
    Self.OnKeyPress := OnKeyPress;
    Self.OnKeyUp := OnKeyUp;
    Self.OnMouseDown := OnMouseDown;
    Self.OnMouseEnter := OnMouseEnter;
    Self.OnMouseLeave := OnMouseLeave;
    Self.OnMouseMove := OnMouseMove;
    Self.OnMouseUp := OnMouseUp;
    Self.OnMouseWheel := OnMouseWheel;
    Self.OnMouseWheelDown := OnMouseWheelDown;
    Self.OnMouseWheelUp := OnMouseWheelUp;
    Self.OnSetStoredPropertyValue := OnSetStoredPropertyValue;
    Self.OnStartDrag := OnStartDrag;
    Self.Init;
  end
end;

procedure TcxCustomGridView.AfterAssign(ASource: TcxCustomGridView);
begin
  DataController.Assign(ASource.DataController);
end;

procedure TcxCustomGridView.BeforeRestoring;
begin
end;

procedure TcxCustomGridView.AfterRestoring;
begin
  RestoringComplete;
end;

{procedure TcxCustomGridView.BeforeLevelChange;
begin
end;}

function TcxCustomGridView.CanTabStop: Boolean;
begin
  Result := TcxCustomGrid(Control).TabStop;
end;

procedure TcxCustomGridView.DetailDataChanged(ADetail: TcxCustomGridView);
begin
end;

procedure TcxCustomGridView.DetailVisibleChanged(ADetailLevel: TComponent;
  APrevVisibleDetailCount, AVisibleDetailCount: Integer);
begin
end;

procedure TcxCustomGridView.DoChanged(AChangeKind: TcxGridViewChangeKind);
begin
  if Controller <> nil then Controller.GridViewChanged;
end;

function TcxCustomGridView.GetChangeable: Boolean;
begin
  Result := (Visible or IsPattern) and (Control <> nil);
end;

function TcxCustomGridView.GetCustomVisible(ALevelVisible: Boolean): Boolean;
begin
  Result := ALevelVisible and not IsPattern and
    (not IsDetail or MasterGridView.Visible and MasterGridView.IsDetailVisible(Self));
end;

function TcxCustomGridView.GetIsControlFocused: Boolean;
begin
  Result := Control.IsFocused;
end;

function TcxCustomGridView.GetResizeOnBoundsChange: Boolean;
begin
  Result := False;
end;

function TcxCustomGridView.GetVisible: Boolean;
begin
  Result := not IsDestroying and
    GetCustomVisible((FLevel <> nil) and TcxGridLevel(FLevel).ActuallyVisible);
end;

procedure TcxCustomGridView.Init;
begin
end;

function TcxCustomGridView.IsDetailVisible(AGridView: TcxCustomGridView): Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridView.LoadingComplete;
begin
  SizeChanged;
end;

procedure TcxCustomGridView.NotifyControl(AChangeKind: TcxGridViewChangeNotificationKind);
begin
  if Control <> nil then
    TcxCustomGridAccess(Control).ViewChanged(Self, AChangeKind);
end;

procedure TcxCustomGridView.RestoringComplete;
begin
end;

procedure TcxCustomGridView.SetLevel(Value: TComponent);
begin
  if FLevel <> Value then
  begin
    //BeforeLevelChange;
    FLevel := Value;
    Site.InitTabStop(Site.Parent);
  end;
end;

procedure TcxCustomGridView.SetTabStop(Value: Boolean);
begin
  Site.TabStop := Value and CanTabStop;
end;

procedure TcxCustomGridView.UpdateControl(AInfo: TcxUpdateControlInfo);
begin
  if not (IsLoading or IsDestroying or IsPattern) and
    (AInfo is TcxDataChangedInfo) and
    (MasterGridView <> nil) and not MasterGridView.IsUpdateLocked and
    (MasterGridView.DataController.LockCount = 0) and
    (PatternGridView <> nil) and PatternGridView.HasAsClone(Self) then
    MasterGridView.DetailDataChanged(Self);
end;

function TcxCustomGridView.GetViewInfoCacheClass: TcxCustomGridViewInfoCacheClass;
begin
  Result := nil;
end;

function TcxCustomGridView.GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass;
begin
  Result := TcxCustomGridBackgroundBitmaps;
end;

function TcxCustomGridView.GetOptionsBehaviorClass: TcxCustomGridOptionsBehaviorClass;
begin
  Result := TcxCustomGridOptionsBehavior;
end;

function TcxCustomGridView.GetOptionsDataClass: TcxCustomGridOptionsDataClass;
begin
  Result := TcxCustomGridOptionsData;
end;

function TcxCustomGridView.GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass;
begin
  Result := TcxCustomGridOptionsSelection;
end;

function TcxCustomGridView.GetOptionsViewClass: TcxCustomGridOptionsViewClass;
begin
  Result := TcxCustomGridOptionsView;
end;

function TcxCustomGridView.GetStylesClass: TcxCustomGridViewStylesClass;
begin
  Result := TcxCustomGridViewStyles;
end;

procedure TcxCustomGridView.Initialize;
begin
  inherited Initialize;
  FListenerLinks := TList.Create;
  FClones := TList.Create;
  FSynchronization := True;
  CreateOptions;
  CreateHandlers;
end;

procedure TcxCustomGridView.RefreshCustomizationForm;
begin
  if Controller <> nil then
    Controller.RefreshCustomizationForm;
end;

procedure TcxCustomGridView.DoCustomization;
begin
  if Assigned(FOnCustomization) then FOnCustomization(Self);
end;

procedure TcxCustomGridView.DoInitStoredObject(AObject: TObject);
begin
  if (AObject <> nil) and Assigned(FOnInitStoredObject) then
    FOnInitStoredObject(Self, AObject);
end;

procedure TcxCustomGridView.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridView then
  begin
    BeginUpdate;
    try
      BeforeAssign(TcxCustomGridView(Source));
      DoAssign(TcxCustomGridView(Source));
      AfterAssign(TcxCustomGridView(Source));
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;

function TcxCustomGridView.CanFocus: Boolean;
begin
  Result := GetCustomVisible((FLevel <> nil) and TcxGridLevel(FLevel).CanBeVisible);
end;

function TcxCustomGridView.GetParentComponent: TComponent;
begin                     {5}
  Result := FStorageControl;
  if Result = nil then
    Result := FRepository;
end;

function TcxCustomGridView.HasParent: Boolean;
begin                     {5}
  Result := (FStorageControl <> nil) or (FRepository <> nil);
end;

function TcxCustomGridView.HasAsClone(AGridView: TcxCustomGridView): Boolean;
begin
  Result := FClones.IndexOf(AGridView) <> -1;
end;

function TcxCustomGridView.HasAsMaster(AGridView: TcxCustomGridView): Boolean;
begin
  Result := (MasterGridView = AGridView) or
    (MasterGridView <> nil) and MasterGridView.HasAsMaster(AGridView);
end;

procedure TcxCustomGridView.Invalidate(AHardUpdate: Boolean = False);
var
  I: Integer;
begin
  if IsPattern then
    for I := 0 to CloneCount - 1 do
      Clones[I].Invalidate(AHardUpdate)
  else
    if AHardUpdate then
      LayoutChanged
    else
      ViewChanged;
end;

procedure TcxCustomGridView.RestoreDefaults;
begin
end;

procedure TcxCustomGridView.SetParentComponent(Value: TComponent);
begin     {5}
  inherited;
  if Value is TcxGridViewRepository then
    TcxGridViewRepositoryAccess(Value).AddItem(Self);
end;

procedure TcxCustomGridView.CheckSynchronizationAssignNeeded;
begin
  if FSynchronizationAssignNeeded then
  begin
    BeginUpdate;
    try
      Synchronize(PatternGridView);
    finally
      CancelUpdate;
    end;
  end;
end;

function TcxCustomGridView.IsSynchronization: Boolean;
begin
  Result := Synchronization or IsDesigning;
end;

procedure TcxCustomGridView.BeginUpdate;
begin
  if Control <> nil then
    TcxCustomGrid(Control).BeginUpdate;
  Inc(FUpdateLockCount);
  if DataController <> nil then
    DataController.BeginUpdate;
end;

procedure TcxCustomGridView.CancelUpdate;
begin
  try
    if DataController <> nil then
      DataController.EndUpdate;
    if IsUpdateLocked then
    begin
      Dec(FUpdateLockCount);
      if not IsUpdateLocked then
        FSynchronizationNeeded := False;
    end;
  finally
    if Control <> nil then  {5}
      TcxCustomGrid(Control).CancelUpdate;
  end;
end;

function TcxCustomGridView.Changed(AGridChange: TObject): Boolean;
begin
  Result := True;
  if IsLoading or IsDestroying {or IsPattern} or
    (FViewInfo = nil) or FViewInfo.IsCalculating then
  begin
    AGridChange.Free;
    Result := False;
  end
  else
    if Control = nil{5} then
      try
        with AGridChange as TcxCustomGridChange do  {7}
        begin
          Control := nil;
          Execute;
        end
      finally
        AGridChange.Free;
      end
    else
      TcxCustomGrid(Control).Changed(AGridChange as TcxCustomGridChange);
end;

procedure TcxCustomGridView.EndUpdate;
begin
  try
    if DataController <> nil then
      DataController.EndUpdate;
    if IsUpdateLocked then
    begin
      if (FUpdateLockCount = 1) and FSynchronizationNeeded then
        Synchronize(False);
      Dec(FUpdateLockCount);
    end;
  finally
    if Control <> nil then
      TcxCustomGrid(Control).EndUpdate;
  end;
end;

function TcxCustomGridView.IsUpdateLocked: Boolean;
begin
  Result := FUpdateLockCount > 0;
end;

function TcxCustomGridView.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := ViewInfo.GetHitTest(P);
end;

function TcxCustomGridView.GetHitTest(X, Y: Integer): TcxCustomGridHitTest;
begin
  Result := ViewInfo.GetHitTest(X, Y);
end;

procedure TcxCustomGridView.BoundsChanged(AUpdateSelfOnly: Boolean = False;
  AKeepMaster: Boolean = False);
begin
  if ResizeOnBoundsChange then
    SizeChanged(AUpdateSelfOnly, AKeepMaster)
  else
    LayoutChanged(AUpdateSelfOnly);
end;

procedure TcxCustomGridView.Changed(AChangeKind: TcxGridViewChangeKind);
begin
  if (DataController <> nil) and DataController.IsDataLoading then Exit;
  BeginUpdate;
  try
    case AChangeKind of
      vcLayout:
        LayoutChanged;
      vcSize:
        SizeChanged;
    end;
    Synchronize;
  finally
    EndUpdate;
  end;
  DoChanged(AChangeKind);
end;

procedure TcxCustomGridView.FocusChanged(AFocused: Boolean);
begin
  if AFocused then
  begin
    DataController.SetFocus;
    Controller.DoSetFocus(True);
  end
  else
    Controller.RemoveFocus;
end;

procedure TcxCustomGridView.LayoutChanged(AUpdateSelfOnly: Boolean = True);

  function GetParameter: TcxCustomGridView;
  begin
    if AUpdateSelfOnly then
      Result := Self
    else
      Result := nil;
  end;

begin
  Changed(TcxGridLayoutChange.Create(GetParameter));
end;

procedure TcxCustomGridView.LookAndFeelChanged;
var
  I: Integer;
begin
  for I := 0 to CloneCount - 1 do
    Clones[I].LookAndFeelChanged;
end;

function TcxCustomGridView.SizeChanged(AUpdateSelfOnly: Boolean = False;
  AKeepMaster: Boolean = False): Boolean;
begin
  Result := Changed(TcxGridSizeChange.Create(Self,
    AUpdateSelfOnly or (Control = nil){7}, AKeepMaster));
end;

procedure TcxCustomGridView.ViewChanged;
begin
  Changed(TcxGridViewChange.Create(Self));
end;

procedure TcxCustomGridView.ViewChanged(const AUpdateRect: TRect);
begin
  if not IsRectEmpty(AUpdateRect) then
    Changed(TcxGridViewChange.Create(Self, AUpdateRect));
end;

procedure TcxCustomGridView.ViewChanged(ARegion: TcxRegion);
begin
  if (ARegion <> nil) and not ARegion.IsEmpty then
    Changed(TcxGridViewChange.Create(Self, ARegion));
end;

procedure TcxCustomGridView.RestoreFromIniFile(const AStorageName: string;
  AChildrenCreating, AChildrenDeleting: Boolean; AOptions: TcxGridStorageOptions;
  const ARestoreViewName: string);
var
  AStorage: TcxStorage;
  AModes: TcxStorageModes;
begin
  FStoringName := ARestoreViewName;
  AStorage := TcxStorage.Create(AStorageName);
  try
    if not IsStoringNameMode then
      AStorage.NamePrefix := Owner.Name;
    FStorageOptions := AOptions;
    AModes := [];
    if AChildrenCreating then
      Include(AModes, smChildrenCreating);
    if AChildrenDeleting then
      Include(AModes, smChildrenDeleting);
    AStorage.Modes := AModes;
    BeginUpdate;
    try
      IsRestoring := True;
      try
        AStorage.RestoreFromIni(Self);
      finally
        IsRestoring := False;
      end;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomGridView.RestoreFromRegistry(const AStorageName: string;
  AChildrenCreating, AChildrenDeleting: Boolean; AOptions: TcxGridStorageOptions;
  const ARestoreViewName: string);
var
  AStorage: TcxStorage;
  AModes: TcxStorageModes;
begin
  FStoringName := ARestoreViewName;
  AStorage := TcxStorage.Create(AStorageName);
  try
    if not IsStoringNameMode then
      AStorage.NamePrefix := Owner.Name;
    FStorageOptions := AOptions;
    AModes := [];
    if AChildrenCreating then
      Include(AModes, smChildrenCreating);
    if AChildrenDeleting then
      Include(AModes, smChildrenDeleting);
    AStorage.Modes := AModes;
    BeginUpdate;
    try
      IsRestoring := True;
      try
        AStorage.RestoreFromRegistry(Self);
      finally
        IsRestoring := False;
      end;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomGridView.RestoreFromStream(AStream: TStream;
  AChildrenCreating, AChildrenDeleting: Boolean; AOptions: TcxGridStorageOptions;
  const ARestoreViewName: string);
var
  AStorage: TcxStorage;
  AModes: TcxStorageModes;
begin
  FStoringName := ARestoreViewName;
  AStorage := TcxStorage.Create(AStream);
  try
    if not IsStoringNameMode then
      AStorage.NamePrefix := Owner.Name;
    FStorageOptions := AOptions;
    AModes := [];
    if AChildrenCreating then
      Include(AModes, smChildrenCreating);
    if AChildrenDeleting then
      Include(AModes, smChildrenDeleting);
    AStorage.Modes := AModes;
    BeginUpdate;
    try
      IsRestoring := True;
      try
        AStorage.RestoreFromStream(Self);
      finally
        IsRestoring := False;
      end;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomGridView.StoreToIniFile(const AStorageName: string; AReCreate: Boolean;
  AOptions: TcxGridStorageOptions; const ASaveViewName: string);
var
  AStorage: TcxStorage;
begin
  FStoringName := ASaveViewName;
  AStorage := TcxStorage.Create(AStorageName);
  try
    FStorageOptions := AOptions;
    if ASaveViewName = '' then
      AStorage.NamePrefix := Owner.Name;
    AStorage.ReCreate := AReCreate;
    AStorage.StoreToIni(Self);
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomGridView.StoreToRegistry(const AStorageName: string; AReCreate: Boolean;
  AOptions: TcxGridStorageOptions; const ASaveViewName: string);
var
  AStorage: TcxStorage;
begin
  FStoringName := ASaveViewName;
  AStorage := TcxStorage.Create(AStorageName);
  try
    FStorageOptions := AOptions;
    if ASaveViewName = '' then
      AStorage.NamePrefix := Owner.Name;
    AStorage.ReCreate := AReCreate;
    AStorage.StoreToRegistry(Self);
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomGridView.StoreToStream(AStream: TStream; AOptions: TcxGridStorageOptions;
  const ASaveViewName: string);
var
  AStorage: TcxStorage;
begin
  FStoringName := ASaveViewName;
  AStorage := TcxStorage.Create(AStream);
  try
    FStorageOptions := AOptions;
    if ASaveViewName = '' then
      AStorage.NamePrefix := Owner.Name;
    AStorage.StoreToStream(Self);
  finally
    AStorage.Free;
  end;
end;

function TcxCustomGridView.CreateViewInfo: TcxCustomGridViewInfo;
begin
  Result := GetViewInfoClass.Create(Self);
end;

{ functions }

function GetGridViewDataController(
  AView: TcxCustomGridView): TcxCustomDataController;
begin
  Result := AView.FDataController;
end;

function GetParentGridView(AControl: TControl): TcxCustomGridView;
begin
  while (AControl <> nil) and not (AControl is TcxGridSite) do
    AControl := AControl.Parent;
  if AControl = nil then
    Result := nil
  else
    Result := TcxGridSite(AControl).GridView;
end;

procedure AddGridViewClone(AView, AClone: TcxCustomGridView);
begin
  AView.AddClone(AClone);
end;

procedure AssignGridViewPattern(AView, APattern: TcxCustomGridView);
begin
  AView.AssignPattern(APattern);
end;

procedure SetGridViewLevel(AView: TcxCustomGridView; Value: TComponent);
begin
  AView.SetLevel(Value);
end;

procedure SiteFocusChanged(ASite: TcxGridSite);
begin
  ASite.FocusChanged;
end;

{ TcxGridRegisteredViews }

type
  TcxGridRegisteredViews = class(TcxRegisteredClasses)
  protected
    function CompareItems(AIndex1, AIndex2: Integer): Integer; override;
  public
    constructor Create;
  end;

constructor TcxGridRegisteredViews.Create;
begin
  inherited Create(True);
  Sorted := True;
end;

function TcxGridRegisteredViews.CompareItems(AIndex1, AIndex2: Integer): Integer;
var
  AIsDBView1, AIsDBView2: Boolean;
begin
  AIsDBView1 := Pos('DB', Descriptions[AIndex1]) = 1;
  AIsDBView2 := Pos('DB', Descriptions[AIndex2]) = 1;
  if not AIsDBView1 and AIsDBView2 then
    Result := -1
  else
    if AIsDBView1 and not AIsDBView2 then
      Result := 1
    else
      Result := inherited CompareItems(AIndex1, AIndex2);
end;

initialization
  GridHitTests := TGridHitTests.Create;
  cxGridRegisteredViews := TcxGridRegisteredViews.Create;

finalization
  FreeAndNil(cxGridRegisteredViews);
  FreeAndNil(GridHitTests);

end.
