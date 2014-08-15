{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB                              
  RR  RR                                                               BB   BB
  RR   RR                                                              BBBBB   }

{**************************************************************************************************}
{ This unit is a adapted from the JEDI Visible Component Library (J-VCL).                          }
{ The original header appears in the box below.                                                    }
{                                                                                                  }
{ original unit: JvInspector.pas                                                                   }
{                                                                                                  }
{ This unit is a subset of the original. It contains only types, classes and methods,              }
{ required to support the JvInspector and related classes. A prefix of pp has been added           }
{ to all classes and methods to differentiate them from the original. This has been done to        }
{ avoid conflicts for users that install ReportBuilder and the J-VCL.                              }
{                                                                                                  }
{**************************************************************************************************}

 {-----------------------------------------------------------------------------

 Project JEDI Visible Component Library (J-VCL)

 The contents of this file are subject to the Mozilla Public License Version
 1.1 (the "License"); you may not use this file except in compliance with the
 License. You may obtain a copy of the License at http://www.mozilla.org/MPL/

 Software distributed under the License is distributed on an "AS IS" basis,
 WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 the specific language governing rights and limitations under the License.

 The Initial Developer of the Original Code is Marcel Bestebroer
  <marcelb@zeelandnet.nl>.
 Portions created by Marcel Bestebroer are Copyright (C) 2000 - 2002 mbeSoft.
 All Rights Reserved.

 ******************************************************************************

 Object Inspector like control which can inspect not only published
 properties, but also variables, string lists (can be parsed as INI files)
 anything you can think of (e.g. DataSet based or event based).

 You may retrieve the latest version of this file at the Project JEDI home
 page, located at http://www.delphi-jedi.org
-----------------------------------------------------------------------------}

// (rom) these compiler options were set but missing in JVCL.INC}
{$D+,L+,Y+}

unit ppJvInspector;

interface

{$I ppIfDef.pas}

uses
  SysUtils, Windows, Classes, Contnrs, TypInfo, Controls, StdCtrls, Graphics,
  Messages, IniFiles,
  Types
  {,JvComponent, JvTypes};

resourcestring
  sppJvInspItemHasParent = 'Item already assigned to another parent.';
  sppJvInspItemValueException = 'Exception ';
  sppJvInspItemUnInitialized = '(uninitialized)';
  sppJvInspItemUnassigned = '(unassigned)';
  sppJvInspItemNoValue = '(no value)';
  sppJvInspItemNotAChild = 'Specified Item is not a child of this item.';
  sppJvInspItemColNotFound = 'Specified column does not belong to this compound item.';
  sppJvInspItemItemIsNotCol = 'Specified item is not a column of this compound item.';
  sppJvInspItemInvalidPropValue = 'Invalid property value %s.';
  sppJvInspDataNoAccessAs = 'Data cannot be accessed as %s.';
  sppJvInspDataNotInit = 'Data not initialized.';
  sppJvInspDataNotAssigned = 'Data not assigned.';
  sppJvInspDataNoValue = 'Data has no value.';
  sppJvInspDataStrTooLong = 'String too long.';
  sppJvInspRegNoCompare = 'Cannot compare %s to %s.';
  sppJvInspNoGenReg = 'Unable to create generic item registration list.';
  sppJvInspPaintNotActive = 'Painter is not the active painter of the specified inspector.';
  sppJvInspPaintOnlyUsedOnce = 'Inspector painter can only be linked to one inspector.';

  // (rom) converted assertions
  sppJvAssertSetTopIndex = 'TppJvCustomInspector.SetTopIndex: unexpected MaxIdx <= -1';
  sppJvAssertInspectorPainter = 'TppJvInspectorCustomCompoundItem.DivideRect: unexpected Inspector.Painter = nil';
  sppJvAssertDataParent = 'TppJvInspectorSetMemberData.New: unexpected ADataParent = nil';
  sppJvAssertParent = 'TppJvInspectorSetMemberData.New: unexpected AParent = nil';
  sppJvAssertPropInfo = 'TppJvInspectorPropData.New: unexpected PropInfo = nil';
  sppJvAssertINIFile = 'TppJvInspectorINIFileData.New: unexpected AINIFile = nil';

const
  { Inspector Row Size constants }
  irsNoReSize =     $00000000;
  irsNameHeight =   $10000000;
  irsValueHeight =  $20000000;
  irsItemHeight =   $40000000;
  irsValueMask =    $0FFFFFFF;

const
{$IFDEF Delphi12}
  cStringTypeKinds = [tkString, tkLString, tkWString, tkUString];
{$ELSE}
  cStringTypeKinds = [tkString, tkLString, tkWString];
{$ENDIF}

type
  TppJvCustomInspector = class;
  TppJvInspectorPainter = class;
  TppJvInspectorItemSizing = class;
  TppJvCustomInspectorItem = class;
  TppJvInspectorCompoundColumn = class;
  TppJvInspectorCustomCompoundItem = class;
  TppJvInspectorCustomCategoryItem = class;
  TppJvCustomInspectorData = class;
  TppJvInspectorRegister = class;
  TppJvCustomInspectorRegItem = class;
  TppJvInspectorEventData = class;

  TInspectorItemFlag = (iifReadonly, iifHidden, iifExpanded, iifVisible,
    iifQualifiedNames, iifAutoUpdate, iifMultiLine, iifValueList,
    iifAllowNonListValues, iifOwnerDrawListFixed, iifOwnerDrawListVariable,
    iifEditButton, iifEditFixed);
  TInspectorItemFlags = set of TInspectorItemFlag;
  TInspectorSetFlag = (isfEditString, isfCreateMemberItems);
  TInspectorSetFlags = set of TInspectorSetFlag;
  TInspectorClassFlag = (icfCreateMemberItems, icfShowClassName);
  TInspectorClassFlags = set of TInspectorClassFlag;
  TInspectorComponentFlag = (icfShowOwnerNames, icfNoShowFirstOwnerName, icfSortComponents,
    icfSortOwners, icfKeepFirstOwnerAsFirst);
  TInspectorComponentFlags = set of TInspectorComponentFlag;
  TInspectorCompoundItemFlag = (icifSingleName, icifSingleNameUseFirstCol);
  TInspectorCompoundItemFlags = set of TInspectorCompoundItemFlag;
  TInspectorTMethodFlag = (imfShowInstanceNames, imfNoShowFirstInstanceName, imfSortMethods,
    imfSortInstances, imfKeepFirstInstanceAsFirst);
  TInspectorTMethodFlags = set of TInspectorTMethodFlag;

  TInspectorPaintRect = (iprItem, iprButtonArea, iprBtnSrcRect, iprBtnDstRect,
    iprNameArea, iprName, iprValueArea, iprValue, iprEditValue, iprEditButton,
    iprUser1, iprUser2, iprUser3, iprUser4, iprUser5, iprUser6);

  TItemRowSizing = type Integer;

  TInspectorItemSortKind = (iskNone, iskName, iskManual, iskCustom);

  TppJvInspectorItemClass = class of TppJvCustomInspectorItem;
  TppJvInspectorDataClass = class of TppJvCustomInspectorData;
  TppJvInspectorPainterClass = class of TppJvInspectorPainter;

  TppJvInspectorItemInstances = array of TppJvCustomInspectorItem;
  TppJvInspectorDataInstances = array of TppJvCustomInspectorData;

  TInspectorItemEvent = procedure(Sender: TObject; const Item: TppJvCustomInspectorItem) of object;
  TInspectorItemBeforeCreateEvent = procedure(Sender: TObject; const Data: TppJvCustomInspectorData; var ItemClass: TppJvInspectorItemClass) of object;
  TInspectorItemBeforeSelectEvent = procedure(Sender: TObject; const NewItem: TppJvCustomInspectorItem; var Allow: Boolean) of object;
  TInspectorDataEvent = procedure(Sender: TObject; const Data: TppJvCustomInspectorData) of object;
  TInspectorItemGetValueListEvent = procedure(const Item: TppJvCustomInspectorItem; const Values: TStrings) of object;
  TInspectorItemSortCompare = function(const Item1, Item2: TppJvCustomInspectorItem): Integer of object;
  TppJvInspAsFloat = procedure(Sender: TppJvInspectorEventData; var Value: Extended) of object;
  TppJvInspAsInt64 = procedure(Sender: TppJvInspectorEventData; var Value: Int64) of object;
  TppJvInspAsMethod = procedure(Sender: TppJvInspectorEventData; var Value: TMethod) of object;
  TppJvInspAsString = procedure(Sender: TppJvInspectorEventData; var Value: string) of object;
  TppJvInspAsSet = procedure(Sender: TppJvInspectorEventData; var Value; var BufSize: Integer) of object;
  TppJvInspSupportsMethodPointers = procedure(Sender: TppJvInspectorEventData; var SupportsTMethod: Boolean) of object;
  TppJvInspConfSectionEvent = procedure(var SectionName: string; var Parse: Boolean) of object;
  TppJvInspConfKeyEvent = procedure(const SectionName: string; var ItemName: string; var ATypeInfo: PTypeInfo; var Allow: Boolean) of object;

//DFM  EppJvInspector = class(EJVCLException);
  EppJvInspector = class(Exception);
  EppJvInspectorItem = class(EppJvInspector);
  EppJvInspectorData = class(EppJvInspector);
  EppJvInspectorReg = class(EppJvInspector);

//DFM  TppJvCustomInspector = class(TppJvCustomControl)
  TppJvCustomInspector = class(TCustomControl)
  private
    FAfterDataCreate: TInspectorDataEvent;
    FAfterItemCreate: TInspectorItemEvent;
    FBandSizing: Boolean;
    FBandSizingBand: Integer;
    FBandStartsSB: TList;
    FBandStartsNoSB: TList;
    FBandWidth: Integer;                                                                   
    FBeforeItemCreate: TInspectorItemBeforeCreateEvent;
    FBeforeSelection: TInspectorItemBeforeSelectEvent;
    FCollapseButton: TBitmap;
    FDivider: Integer;
    FDraggingDivider: Boolean;
    FExpandButton: TBitmap;
    FImageHeight: Integer;
    FItemHeight: Integer;
    FLockCount: Integer;
    FNeedRebuild: Boolean;
    FNeedRedraw: Boolean;
    FSortNotificationList: TList;
    FOnDataValueChanged: TInspectorDataEvent;
    FOnItemSelected: TNotifyEvent;
    FOnItemValueChanged: TInspectorItemEvent;
    FPainter: TppJvInspectorPainter;
    FPaintGen: Integer;
    FReadOnly: Boolean;
    FRelativeDivider: Boolean;
    FRoot: TppJvCustomInspectorItem;
    FRowSizing: Boolean;
    FRowSizingItem: TppJvCustomInspectorItem;
    FSelectedIndex: Integer;
    FSelecting: Boolean;
    FTopIndex: Integer;
    FUseBands: Boolean;
    FVisible: TStrings;
    FWantTabs: Boolean;
  protected
    function CalcImageHeight: Integer; virtual;
    function CalcItemIndex(X, Y: Integer; var Rect: TRect): Integer; virtual;
    function CalcItemRect(const Item: TppJvCustomInspectorItem): TRect; virtual;
    procedure CMDeactivate(var Msg: TCMActivate); message CM_DEACTIVATE;
    procedure DoAfterDataCreate(const Data: TppJvCustomInspectorData); virtual;
    procedure DoAfterItemCreate(const Item: TppJvCustomInspectorItem); virtual;
    procedure DoBeforeItemCreate(const Data: TppJvCustomInspectorData;
      var ItemClass: TppJvInspectorItemClass); virtual;
    function DoBeforeItemSelect(const NewItem: TppJvCustomInspectorItem): Boolean; virtual;
    procedure DoDataValueChanged(const Data: TppJvCustomInspectorData); virtual;
    procedure DoItemSelected; virtual;
    procedure DoItemValueChanged(const Item: TppJvCustomInspectorItem); virtual;
    function GetAfterDataCreate: TInspectorDataEvent; virtual;
    function GetAfterItemCreate: TInspectorItemEvent; virtual;
    function GetBandFor(const ItemIdx: Integer): Integer; virtual;
    function GetBandStarts: TList; virtual;
    function GetBandWidth: Integer; virtual;
    function GetBeforeItemCreate: TInspectorItemBeforeCreateEvent; virtual;
    function GetBeforeSelection: TInspectorItemBeforeSelectEvent; virtual;
    function GetButtonRect(const ItemIndex: Integer): TRect; virtual;
    function GetCollapseButton: TBitmap; virtual;
    function GetDivider: Integer; virtual;
    function GetDividerAbs: Integer; virtual;
    function GetExpandButton: TBitmap; virtual;
    function GetImageHeight: Integer; virtual;
    function GetItemHeight: Integer; virtual;
    function GetLastFullVisible: Integer; virtual;
    function GetLockCount: Integer; virtual;
    function GetOnItemSelected: TNotifyEvent; virtual;
    function GetPainter: TppJvInspectorPainter; virtual;
    function GetReadOnly: Boolean; virtual;
    function GetRelativeDivider: Boolean; virtual;
    function GetRoot: TppJvCustomInspectorItem; virtual;
    function GetSelected: TppJvCustomInspectorItem; virtual;
    function GetSelectedIndex: Integer; virtual;
    function GetTopIndex: Integer; virtual;
    function GetUseBands: Boolean; virtual;
    function GetVisibleCount: Integer; virtual;
    function GetVisibleItems(const I: Integer): TppJvCustomInspectorItem; virtual;
    function GetWantTabs: Boolean; virtual;
    procedure HandleBandResize(X: Integer); virtual;
    function IdxToY(const Index: Integer): Integer; virtual;
    procedure IncPaintGeneration; virtual;
    procedure InvalidateHeight; virtual;
    procedure InvalidateItem; virtual;
    procedure InvalidateList; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure NotifySort(const Item: TppJvCustomInspectorItem); virtual;
    procedure Paint; override;
    procedure RebuildVisible; virtual;
    procedure RemoveNotifySort(const Item: TppJvCustomInspectorItem); virtual;
    procedure Resize; override;
    function ScrollfactorV: Extended; virtual;
    procedure SetAfterDataCreate(const Value: TInspectorDataEvent); virtual;
    procedure SetAfterItemCreate(const Value: TInspectorItemEvent); virtual;
    procedure SetBandWidth(Value: Integer); virtual;
    procedure SetBeforeItemCreate(const Value: TInspectorItemBeforeCreateEvent); virtual;
    procedure SetBeforeSelection(const Value: TInspectorItemBeforeSelectEvent); virtual;
    procedure SetCollapseButton(const Value: TBitmap); virtual;
    procedure SetDivider(Value: Integer); virtual;
    procedure SetDividerAbs(Value: Integer); virtual;
    procedure SetExpandButton(const Value: TBitmap); virtual;
    procedure SetItemHeight(Value: Integer); virtual;
    procedure SetLockCount(const Value: Integer); virtual;
    procedure SetOnItemSelected(const Value: TNotifyEvent); virtual;
    procedure SetPainter(const Value: TppJvInspectorPainter); virtual;
    procedure SetReadOnly(const Value: Boolean); virtual;
    procedure SetRelativeDivider(Value: Boolean); virtual;
    procedure SetSelected(const Value: TppJvCustomInspectorItem); virtual;
    procedure SetSelectedIndex(Value: Integer); virtual;
    procedure SetTopIndex(Value: Integer); virtual;
    procedure SetUseBands(Value: Boolean); virtual;
    procedure SetWantTabs(Value: Boolean); virtual;
    procedure UpdateScrollBars; virtual;
    function ViewHeight: Integer;
    function ViewRect: TRect; virtual;
    function ViewWidth: Integer;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMHScroll(var Msg: TWMScroll); message WM_HSCROLL;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMVScroll(var Msg: TWMScroll); message WM_VSCROLL;
    function YToIdx(const Y: Integer): Integer; virtual;
    property BandSizing: Boolean read FBandSizing write FBandSizing;
    property BandSizingBand: Integer read FBandSizingBand write FBandSizingBand;
    property BandStarts: TList read GetBandStarts;
    property BandWidth: Integer read GetBandWidth write SetBandWidth;
    property CollapseButton: TBitmap read GetCollapseButton write SetCollapseButton;
    property ExpandButton: TBitmap read GetExpandButton write SetExpandButton;
    property Divider: Integer read GetDivider write SetDivider;
    property DividerAbs: Integer read GetDividerAbs write SetDividerAbs;
    property DraggingDivider: Boolean read FDraggingDivider write FDraggingDivider;
    property ItemHeight: Integer read GetItemHeight write SetItemHeight;
    property ImageHeight: Integer read GetImageHeight;
    property LockCount: Integer read GetLockCount;
    property NeedRebuild: Boolean read FNeedRebuild write FNeedRebuild;
    property NeedRedraw: Boolean read FNeedRedraw write FNeedRedraw;
    property SortNotificationList: TList read FSortNotificationList;
    property OnDataValueChanged: TInspectorDataEvent read FOnDataValueChanged write FOnDataValueChanged;
    property OnItemSelected: TNotifyEvent read GetOnItemSelected write SetOnItemSelected;
    property OnItemValueChanged: TInspectorItemEvent read FOnItemValueChanged write FOnItemValueChanged;
    property AfterDataCreate: TInspectorDataEvent read GetAfterDataCreate
      write SetAfterDataCreate;
    property AfterItemCreate: TInspectorItemEvent read GetAfterItemCreate
      write SetAfterItemCreate;
    property BeforeItemCreate: TInspectorItemBeforeCreateEvent
      read GetBeforeItemCreate write SetBeforeItemCreate;
    property BeforeSelection: TInspectorItemBeforeSelectEvent read GetBeforeSelection write SetBeforeSelection;
    property Painter: TppJvInspectorPainter read GetPainter write SetPainter;
    property PaintGeneration: Integer read FPaintGen;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
    property RelativeDivider: Boolean read GetRelativeDivider write SetRelativeDivider;
    property Root: TppJvCustomInspectorItem read GetRoot;
    property RowSizing: Boolean read FRowSizing write FRowSizing;
    property RowSizingItem: TppJvCustomInspectorItem read FRowSizingItem write
      FRowSizingItem;
    property Selected: TppJvCustomInspectorItem read GetSelected;
    property SelectedIndex: Integer read GetSelectedIndex write SetSelectedIndex;
    property Selecting: Boolean read FSelecting write FSelecting;
    property TopIndex: Integer read GetTopIndex write SetTopIndex;
    property UseBands: Boolean read GetUseBands write SetUseBands;
    property VisibleCount: Integer read GetVisibleCount;
    property VisibleItems[const I: Integer]: TppJvCustomInspectorItem read GetVisibleItems;
    property WantTabs: Boolean read GetWantTabs write SetWantTabs;
  public
    constructor Create(AOwner: TComponent); override;
    procedure BeforeDestruction; override;
    function BeginUpdate: Integer; virtual;
    function EndUpdate: Integer; virtual;
    function Focused: Boolean; override;
    function FocusedItem: TppJvCustomInspectorItem; virtual;
    function VisibleIndex(const AItem: TppJvCustomInspectorItem): Integer; virtual;
  end;

  TppJvInspector = class(TppJvCustomInspector)
  public
    property LockCount;
    property Root;
    property Selected;
    property SelectedIndex;
    property TopIndex;
    property VisibleCount;
    property VisibleItems;
  published
    property Align;
    property Anchors;
    property BandWidth;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property CollapseButton;
    // (rom) this is usually handled in an overwritten Loaded
    property RelativeDivider; // Must be defined before Divider
    property Divider;
    property ExpandButton;
    property Font;
    property ItemHeight;
    property Painter;
    property ReadOnly;
    property UseBands;
    property WantTabs;
    property AfterDataCreate;
    property AfterItemCreate;
    property BeforeItemCreate;
    property BeforeSelection;
    property OnDataValueChanged;
    property OnItemSelected;
    property OnItemValueChanged;
  end;

//DFM  TppJvInspectorPainter = class(TppJvComponent)
  TppJvInspectorPainter = class(TComponent)
  private
    FBackgroundColor: TColor;
    FButtonImage: TBitmap;
    FCanvas: TCanvas;
    FCategoryColor: TColor;
    FCategoryTextColor: TColor;
    FDividerColor: TColor;
    FInitializing: Boolean;
    FInspector: TppJvCustomInspector;
    FInternalCollapseButton: TBitmap;
    FInternalExpandButton: TBitmap;
    FItem: TppJvCustomInspectorItem;
    FItemIndex: Integer;
    FNameColor: TColor;
    FPaintRect: TRect;
    FSelectedColor: TColor;
    FSelectedTextColor: TColor;
    FValueColor: TColor;
  protected
    procedure ApplyNameFont; virtual;
    procedure ApplyValueFont; virtual;
    procedure CalcButtonBasedRects; virtual;
    procedure CalcEditBasedRects; virtual;
    procedure CalcNameBasedRects; virtual;
    procedure CalcValueBasedRects; virtual;
    function DividerWidth: Integer; virtual;
    procedure DoPaint; virtual;
    function GetBackgroundColor: TColor; virtual;
    function GetCategoryColor: TColor; virtual;
    function GetCategoryTextColor: TColor; virtual;
    function GetCollapseImage: TBitmap; virtual;
    function GetDividerColor: TColor; virtual;
    function GetExpandImage: TBitmap; virtual;
    function GetNameColor: TColor; virtual;
    function GetNameHeight(const AItem: TppJvCustomInspectorItem): Integer; virtual;
    function GetRects(const Index: TInspectorPaintRect): TRect; virtual;
    function GetSelectedColor: TColor; virtual;
    function GetSelectedTextColor: TColor; virtual;
    function GetValueColor: TColor; virtual;
    function GetValueHeight(const AItem: TppJvCustomInspectorItem): Integer; virtual;
    procedure HideEditor; virtual;
    procedure InitializeColors; virtual;
    function Loading: Boolean;
    procedure Paint; virtual;
    procedure PaintDivider(const X, YTop, YBottom: Integer); virtual;
    procedure PaintItem(var ARect: TRect; const AItemIndex: Integer); overload; virtual;
    procedure PaintItem(const AItem: TppJvCustomInspectorItem); overload; virtual;
    procedure SetBackgroundColor(const Value: TColor); virtual;
    procedure SetCategoryColor(const Value: TColor); virtual;
    procedure SetCategoryTextColor(const Value: TColor); virtual;
    procedure SetDividerColor(const Value: TColor); virtual;
    procedure SetNameColor(const Value: TColor); virtual;
    procedure SetRects(const Index: TInspectorPaintRect; const ARect: TRect); virtual;
    procedure SetSelectedColor(const Value: TColor); virtual;
    procedure SetSelectedTextColor(const Value: TColor); virtual;
    procedure Setup(const ACanvas: TCanvas); virtual;
    procedure SetupItem; virtual;
    procedure SetupRects; virtual;
    procedure SetValueColor(const Value: TColor); virtual;
    procedure TeardownItem; virtual;
    property ButtonImage: TBitmap read FButtonImage write FButtonImage;
    property Canvas: TCanvas read FCanvas write FCanvas;
    property Initializing: Boolean read FInitializing write FInitializing;
    property Inspector: TppJvCustomInspector read FInspector;
    property InternalCollapseButton: TBitmap read FInternalCollapseButton;
    property InternalExpandButton: TBitmap read FInternalExpandButton;
    property Item: TppJvCustomInspectorItem read FItem write FItem;
    property ItemIndex: Integer read FItemIndex write FItemIndex;
    property PaintRect: TRect read FPaintRect write FPaintRect;
    property Rects[const Index: TInspectorPaintRect]: TRect read GetRects write SetRects;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetInspector(const AInspector: TppJvCustomInspector); virtual;
    property SelectedColor: TColor read GetSelectedColor write SetSelectedColor;
    property SelectedTextColor: TColor read GetSelectedTextColor write SetSelectedTextColor;
  published
    property BackgroundColor: TColor read GetBackgroundColor write SetBackgroundColor;
    property CategoryColor: TColor read GetCategoryColor write SetCategoryColor;
    property CategoryTextColor: TColor read GetCategoryTextColor write SetCategoryTextColor;
    property DividerColor: TColor read GetDividerColor write SetDividerColor;
    property NameColor: TColor read GetNameColor write SetNameColor;
    property ValueColor: TColor read GetValueColor write SetValueColor;
  end;

  TppJvInspectorBorlandNETBasePainter = class(TppJvInspectorPainter)
  protected
    procedure ApplyNameFont; override;
    procedure ApplyValueFont; override;
    procedure CalcButtonBasedRects; override;
    procedure CalcEditBasedRects; override;
    procedure CalcNameBasedRects; override;
    procedure CalcValueBasedRects; override;
    procedure SetupRects; override;
  published
    property BackgroundColor default clWindow;
    property CategoryColor default clBtnFace;
    property CategoryTextColor default clBtnText;
    property NameColor default clWindowText;
    property ValueColor default clWindowText;
  end;

  TppJvInspectorBorlandPainter = class(TppJvInspectorBorlandNETBasePainter)
  private
    FDividerLightColor: TColor;
  protected
    function DividerWidth: Integer; override;
    procedure DoPaint; override;
    function GetDividerLightColor: TColor; virtual;
    function GetSelectedColor: TColor; override;
    function GetSelectedTextColor: TColor; override;
    procedure InitializeColors; override;
    procedure PaintDivider(const X, YTop, YBottom: Integer); override;
    procedure SetDividerLightColor(const Value: TColor); virtual;
    procedure Setup(const ACanvas: TCanvas); override;
  published
    property BackgroundColor default clBtnFace;
    property DividerColor default clBtnShadow;
    property DividerLightColor: TColor read GetDividerLightColor write SetDividerLightColor default clBtnHighlight;
    property ValueColor default clNavy;
  end;

  TppJvInspectorDotNETPainter = class(TppJvInspectorBorlandNETBasePainter)
  private
  protected
    procedure ApplyNameFont; override;
    procedure DoPaint; override;
    procedure PaintDivider(const X, YTop, YBottom: Integer); override;
  published
    property DividerColor default clBtnFace;
    property SelectedColor default clHighlight;
    property SelectedTextColor default clHighlightText;
  end;

  TppJvInspectorItemSizing = class(TPersistent)
  private
    FMinHeight: TItemRowSizing;
    FSizable: Boolean;
    FSizingFactor: TItemRowSizing;
  protected
    Item: TppJvCustomInspectorItem;
    function GetMinHeight: TItemRowSizing;
    function GetSizable: Boolean;
    function GetSizingFactor: TItemRowSizing;
    procedure SetMinHeight(Value: TItemRowSizing);
    procedure SetSizable(Value: Boolean);
    procedure SetSizingFactor(Value: TItemRowSizing);
  public
    constructor Create(const AItem: TppJvCustomInspectorItem);
    procedure Assign(Source: TPersistent); override;
    property MinHeight: TItemRowSizing read GetMinHeight write SetMinHeight;
    property Sizable: Boolean read GetSizable write SetSizable;
    property SizingFactor: TItemRowSizing read GetSizingFactor write SetSizingFactor;
  published
  end;

  TppJvCustomInspectorItem = class(TPersistent)
  private
    FData: TppJvCustomInspectorData;
    FDisplayIndex: Integer;
    FDisplayName: string;
    FDroppedDown: Boolean;
    FEditCtrl: TCustomEdit;
    FEditWndPrc: TWndMethod;
    FEditing: Boolean;
    FFlags: TInspectorItemFlags;
    FHeight: Integer;
    FInspector: TppJvCustomInspector;
    FItems: TObjectList;
    FListBox: TCustomListBox;
    FOnCompare: TInspectorItemSortCompare;
    FOnGetValueList: TInspectorItemGetValueListEvent;
    FOnValueChanged: TNotifyEvent;
    FParent: TppJvCustomInspectorItem;
    FLastPaintGen: Integer;
    FPressed: Boolean;
    FRects: array [TInspectorPaintRect] of TRect;
    FRowSizing: TppJvInspectorItemSizing;
    FSortKind: TInspectorItemSortKind;
    FTracking: Boolean;
  protected
    procedure AlphaSort;
    procedure Apply; virtual;
    procedure ApplyDisplayIndices(const ItemList: TList); virtual;
    procedure BuildDisplayableList(const ItemList: TList); virtual;
    procedure ButtonClick(Sender: TObject); virtual;
    function CanEdit: Boolean; virtual;
    procedure CloseUp(Accept: Boolean); virtual;
    procedure DataSort;
    procedure Deactivate; dynamic;
    procedure DoAfterItemCreate; virtual;
    function DoCompare(const Item: TppJvCustomInspectorItem): Integer; virtual;
    procedure DoDrawListItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState); virtual;
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState); virtual;
    procedure DoGetValueList(const Strings: TStrings); virtual;
    procedure DoMeasureListItem(Control: TWinControl; Index: Integer;
      var Height: Integer); virtual;
    procedure DoMeasureListItemWidth(Control: TWinControl; Index: Integer;
      var Width: Integer); virtual;
    procedure DoValueChanged; virtual;
    procedure DropDown; dynamic;
    procedure Edit; virtual;
    procedure EditChange(Sender: TObject); virtual;
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      virtual;
    procedure EditMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;
    procedure EditMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
      virtual;
    procedure EditMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;
    procedure Edit_WndProc(var Message: TMessage); virtual;
    function GetAutoUpdate: Boolean; virtual;
    function GetBaseCategory: TppJvInspectorCustomCategoryItem; virtual;
    function GetCategory: TppJvInspectorCustomCategoryItem; virtual;
    function GetCount: Integer; virtual;
    function GetData: TppJvCustomInspectorData; virtual;
    function GetDisplayIndex: Integer; virtual;
    function GetDisplayName: string; virtual;
    function GetDisplayParent: TppJvCustomInspectorItem; virtual;
    function GetDisplayValue: string; virtual;
    function GetDroppedDown: Boolean; virtual;
    function GetEditCtrl: TCustomEdit; virtual;
    function GetEditing: Boolean; virtual;
    function GetExpanded: Boolean; virtual;
    function GetFlags: TInspectorItemFlags; virtual;
    function GetHeight: Integer; virtual;
    function GetHeightFactor: Integer; virtual;
    function GetHidden: Boolean; virtual;
    function GetInspector: TppJvCustomInspector; virtual;
    function GetInspectorPaintGeneration: Integer;
    function GetIsCompoundColumn: Boolean; virtual;
    function GetItems(const I: Integer): TppJvCustomInspectorItem; virtual;
    function GetLevel: Integer; virtual;
    function GetListBox: TCustomListBox; virtual;
    function GetMultiline: Boolean; virtual;
    function GetNextSibling: TppJvCustomInspectorItem; virtual;
    function GetParent: TppJvCustomInspectorItem; virtual;
    function GetQualifiedNames: Boolean; virtual;
    function GetReadOnly: Boolean; virtual;
    function GetRects(const RectKind: TInspectorPaintRect): TRect; virtual;
    function GetRowSizing: TppJvInspectorItemSizing; virtual;
    function GetSortKind: TInspectorItemSortKind; virtual;
    function GetSortName: string; virtual;
    procedure GetValueList(const Strings: TStrings); virtual;
    function GetVisible: Boolean; virtual;
    procedure InvalidateItem; virtual;
    procedure InvalidateList; virtual;
    procedure InvalidateSort; virtual;
    procedure InvalidateValue; virtual;
    procedure InvalidateMetaData; virtual;
    procedure ListExit(Sender: TObject); virtual;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure NaturalSort; 
    procedure SelectValue(const Delta: Integer); virtual;
    procedure SetAutoUpdate(const Value: Boolean); virtual;
    procedure SetDisplayIndex(const Value: Integer); virtual;
    procedure SetDisplayIndexValue(const Value: Integer); virtual;
    procedure SetDisplayName(Value: string); virtual;
    procedure SetDisplayValue(const Value: string); virtual;
    procedure SetEditCtrl(const Value: TCustomEdit); virtual;
    procedure SetEditing(const Value: Boolean); virtual;
    procedure SetExpanded(Value: Boolean); virtual;
    procedure SetFlags(const Value: TInspectorItemFlags); virtual;
    procedure SetFocus; virtual;
    procedure SetHeight(Value: Integer); virtual;
    procedure SetHeightFactor(Value: Integer); virtual;
    procedure SetHidden(Value: Boolean); virtual;
    procedure SetInspector(const AInspector: TppJvCustomInspector); virtual;
    procedure SetMultiline(const Value: Boolean); virtual;
    procedure SetOnCompare(const Value: TInspectorItemSortCompare); virtual;
    procedure SetParent(const Value: TppJvCustomInspectorItem); virtual;
    procedure SetQualifiedNames(const Value: Boolean); virtual;
    procedure SetReadOnly(const Value: Boolean); virtual;
    procedure SetRects(const RectKind: TInspectorPaintRect; Value: TRect); virtual;
    procedure SetRowSizing(Value: TppJvInspectorItemSizing); virtual;
    procedure SetSortKind(Value: TInspectorItemSortKind); virtual;
    procedure SetVisible(Value: Boolean); virtual;
    procedure StopTracking; dynamic;
    procedure TrackButton(X,Y: Integer); dynamic;
    procedure Undo; virtual;
    procedure UpdateDisplayOrder(const Item: TppJvCustomInspectorItem; const NewIndex: Integer); virtual;
    procedure UpdateLastPaintGeneration;
    property BaseCategory: TppJvInspectorCustomCategoryItem read GetBaseCategory;
    property Category: TppJvInspectorCustomCategoryItem read GetCategory;
    property DroppedDown: Boolean read GetDroppedDown;
    property EditCtrl: TCustomEdit read GetEditCtrl;
    property EditWndPrc: TWndMethod read FEditWndPrc;
    property IsCompoundColumn: Boolean read GetIsCompoundColumn;
    property LastPaintGeneration: Integer read FLastPaintGen;
    property ListBox: TCustomListBox read GetListBox;
    property OnGetValueList: TInspectorItemGetValueListEvent read FOnGetValueList write FOnGetValueList;
    property Pressed: Boolean read FPressed write FPressed;
    property Tracking: Boolean read FTracking write FTracking;
  public
    constructor Create(const AParent: TppJvCustomInspectorItem; const AData: TppJvCustomInspectorData); virtual;
    destructor Destroy; override;
    function Add(const Item: TppJvCustomInspectorItem): Integer; 
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure Clear;
    procedure Delete(const Index: Integer); overload; virtual;
    procedure Delete(const Item: TppJvCustomInspectorItem); overload; virtual;
    procedure Delete(const Data: TppJvCustomInspectorData); overload; virtual;
    procedure DrawEditor(const ACanvas: TCanvas); virtual;
    procedure DrawName(const ACanvas: TCanvas); virtual;
    procedure DrawValue(const ACanvas: TCanvas); virtual;
    function EditFocused: Boolean; dynamic;
    function HasViewableItems: Boolean; virtual;
    function IndexOf(const Item: TppJvCustomInspectorItem): Integer; overload; virtual;
    function IndexOf(const Data: TppJvCustomInspectorData): Integer; overload; virtual;
    procedure InitEdit; dynamic;
    procedure DoneEdit(const CancelEdits: Boolean = False); dynamic;
    procedure Insert(const Index: Integer; const Item: TppJvCustomInspectorItem);
    procedure ScrollInView;
    procedure Sort;
    property AutoUpdate: Boolean read GetAutoUpdate write SetAutoUpdate;
    property Count: Integer read GetCount;
    property Data: TppJvCustomInspectorData read GetData;
    property DisplayIndex: Integer read GetDisplayIndex write SetDisplayIndex;
    property DisplayName: string read GetDisplayName write SetDisplayName;
    property DisplayValue: string read GetDisplayValue write SetDisplayValue;
    property Editing: Boolean read GetEditing;
    property Expanded: Boolean read GetExpanded write SetExpanded;
    property Flags: TInspectorItemFlags read GetFlags write SetFlags;
    property Hidden: Boolean read GetHidden write SetHidden;
    property Height: Integer read GetHeight write SetHeight;
    property HeightFactor: Integer read GetHeightFactor write SetHeightFactor;
    property Inspector: TppJvCustomInspector read GetInspector;
    property Items[const I: Integer]: TppJvCustomInspectorItem read GetItems; default;
    property Level: Integer read GetLevel;
    property Multiline: Boolean read GetMultiline write SetMultiline;
    property Parent: TppJvCustomInspectorItem read GetParent;
    property QualifiedNames: Boolean read GetQualifiedNames write SetQualifiedNames;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
    property Rects[const RectKind: TInspectorPaintRect]: TRect read GetRects write SetRects;
    property RowSizing: TppJvInspectorItemSizing read GetRowSizing write SetRowSizing;
    property SortKind: TInspectorItemSortKind read GetSortKind write SetSortKind;
    property Visible: Boolean read GetVisible write SetVisible;
    property OnCompare: TInspectorItemSortCompare read FOnCompare write SetOnCompare;
    property OnValueChanged: TNotifyEvent read FOnValueChanged write FOnValueChanged;
  end;

  TppJvInspectorCustomCategoryItem = class(TppJvCustomInspectorItem)
  protected
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  end;

  TppJvInspectorCompoundColumn = class(TPersistent)
  private
    FItem: TppJvCustomInspectorItem;
    FParent: TppJvInspectorCustomCompoundItem;
    FWidth: Integer;
    FWidthSet: Integer;
  protected
    function GetItem: TppJvCustomInspectorItem;
    function GetWidth: Integer;
    function GetWidthSet: Integer;
    procedure SetItem(Value: TppJvCustomInspectorItem);
    procedure SetWidth(Value: Integer);
    procedure SetWidthExternal(Value: Integer);
    procedure SetWidthSet(Value: Integer);
    property Parent: TppJvInspectorCustomCompoundItem read FParent;
  public
    constructor Create(const AParent: TppJvInspectorCustomCompoundItem; const AItem: TppJvCustomInspectorItem);
    destructor Destroy; override;
    procedure BeforeDestruction; override;

    property Item: TppJvCustomInspectorItem read GetItem write SetItem;
    property Width: Integer read GetWidth write SetWidthExternal;
    property WidthSet: Integer read GetWidthSet;
  end;

  TppJvInspectorCustomCompoundItem = class(TppJvCustomInspectorItem)
  private
    FCompoundItemFlags: TInspectorCompoundItemFlags;
    FColumns: TObjectList;
    FSelectedColumnIdx: Integer;
  protected
    function AddColumnPrim(const Item: TppJvCustomInspectorItem): Integer; overload; virtual;
    function AddColumnPrim(const ItemIndex: Integer): Integer; overload; virtual;
    procedure DeleteColumnPrim(const Column: TppJvInspectorCompoundColumn); overload; virtual;
    procedure DeleteColumnPrim(const Index: Integer); overload; virtual;
    procedure DeleteColumnPrim(const Item: TppJvCustomInspectorItem); overload; virtual;
    procedure DivideRect(const RectKind: TInspectorPaintRect; const Value: TRect); virtual;
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    function GetColumnCount: Integer; virtual;
    function GetColumns(I: Integer): TppJvInspectorCompoundColumn; virtual;
    function GetDisplayName: string; override;
    function GetEditing: Boolean; override;
    function GetSelectedColumn: TppJvInspectorCompoundColumn; virtual;
    function GetSelectedColumnIndex: Integer; virtual;
    function GetSingleName: Boolean;
    function GetSingleNameUseFirstCol: Boolean;
    function IndexOfColumnPrim(const Col: TppJvInspectorCompoundColumn): Integer; overload; virtual;
    function IndexOfColumnPrim(const Item: TppJvCustomInspectorItem): Integer; overload; virtual;
    procedure InsertColumnPrim(const Index: Integer; const Item: TppJvCustomInspectorItem); overload; virtual;
    procedure InsertColumnPrim(const Index, ItemIndex: Integer); overload; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure RecalcColumnWidths(const SetColumn: TppJvInspectorCompoundColumn = nil); virtual;
    procedure SetCompoundItemFlags(Value: TInspectorCompoundItemFlags);
    procedure SetDisplayName(Value: string); override;
    procedure SetEditing(const Value: Boolean); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
    procedure SetFocus; override;
    procedure SetRects(const RectKind: TInspectorPaintRect; Value: TRect); override;
    procedure SetSelectedColumn(Value: TppJvInspectorCompoundColumn); virtual;
    procedure SetSelectedColumnIndex(Value: Integer); virtual;
    procedure SetSingleName(Value: Boolean);
    procedure SetSingleNameUseFirstCol(Value: Boolean);
    property ColumnCount: Integer read GetColumnCount;
    property Columns[I: Integer]: TppJvInspectorCompoundColumn read GetColumns;
    property CompoundItemFlags: TInspectorCompoundItemFlags read FCompoundItemFlags write SetCompoundItemFlags;
    property SelectedColumn: TppJvInspectorCompoundColumn read GetSelectedColumn write SetSelectedColumn;
    property SelectedColumnIndex: Integer read GetSelectedColumnIndex write SetSelectedColumnIndex;
    property SingleName: Boolean read GetSingleName write SetSingleName;
    property SingleNameUseFirstCol: Boolean read GetSingleNameUseFirstCol write SetSingleNameUseFirstCol;
  public
    constructor Create(const AParent: TppJvCustomInspectorItem; const AData: TppJvCustomInspectorData); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure DoneEdit(const CancelEdits: Boolean = False); override;
    procedure DrawEditor(const ACanvas: TCanvas); override;
    procedure DrawName(const ACanvas: TCanvas); override;
    procedure DrawValue(const ACanvas: TCanvas); override;
    function EditFocused: Boolean; override;
    procedure InitEdit; override;
  end;

  TppJvInspectorCompoundItem = class(TppJvInspectorCustomCompoundItem)
  public
    function AddColumn(const Item: TppJvCustomInspectorItem): Integer; overload;
    function AddColumn(const ItemIndex: Integer): Integer; overload;
    procedure DeleteColumn(const Column: TppJvInspectorCompoundColumn); overload;
    procedure DeleteColumn(const Index: Integer); overload;
    procedure DeleteColumn(const Item: TppJvCustomInspectorItem); overload;
    function IndexOfColumn(const Col: TppJvInspectorCompoundColumn): Integer; overload;
    function IndexOfColumn(const Item: TppJvCustomInspectorItem): Integer; overload;
    procedure InsertColumn(const Index: Integer; const Item: TppJvCustomInspectorItem); overload;
    procedure InsertColumn(const Index, ItemIndex: Integer); overload;
    property ColumnCount;
    property Columns;
    property CompoundItemFlags;
    property SelectedColumn;
    property SelectedColumnIndex;
    property SingleName;
    property SingleNameUseFirstCol;
  end;

  TppJvInspectorIntegerItem = class(TppJvCustomInspectorItem)
  protected
    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
  end;

  TppJvInspectorEnumItem = class(TppJvCustomInspectorItem)
  protected
    function GetDisplayValue: string; override;
    procedure GetValueList(const Strings: TStrings); override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  end;

  TppJvInspectorFloatItem = class(TppJvCustomInspectorItem)
  protected
    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
  end;

  TppJvInspectorSetItem = class(TppJvCustomInspectorItem)
  private
    FItemSetFlags: TInspectorSetFlags;
  protected
    function CanEdit: Boolean; override;
    procedure CreateMembers; virtual;
    procedure DeleteMembers; virtual;
    function GetCreateMemberItems: Boolean; virtual;
    function GetDisplayValue: string; override;
    function GetEditString: Boolean; virtual;
    function GetItemSetFlags: TInspectorSetFlags; virtual;
    procedure InvalidateMetaData; override;
    procedure SetCreateMemberItems(const Value: Boolean); virtual;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetEditString(const Value: Boolean); virtual;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
    procedure SetItemSetFlags(const Value: TInspectorSetFlags); virtual;
  public
    constructor Create(const AParent: TppJvCustomInspectorItem;
      const AData: TppJvCustomInspectorData); override;
  published
    property ItemSetFlags: TInspectorSetFlags read GetItemSetFlags
      write SetItemSetFlags;
    property CreateMemberItems: Boolean read GetCreateMemberItems
      write SetCreateMemberItems;
    property EditString: Boolean read GetEditString write SetEditString;
  end;

  TppJvInspectorCharItem = class(TppJvCustomInspectorItem)
  protected
    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
  end;

  TppJvInspectorInt64Item = class(TppJvCustomInspectorItem)
  protected
    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
  end;

  TppJvInspectorStringItem = class(TppJvCustomInspectorItem)
  protected
    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
  end;

  TppJvInspectorClassItem = class(TppJvCustomInspectorItem)
  private
    FItemClassFlags: TInspectorClassFlags;
    FLastMemberInstance: TObject;
  protected
    procedure CreateMembers; virtual;
    function CanEdit: Boolean; override;
    procedure DeleteMembers; virtual;
    function GetCreateMemberItems: Boolean; virtual;
    function GetDisplayValue: string; override;
    function GetItemClassFlags: TInspectorClassFlags; virtual;
    function GetShowClassName: Boolean; virtual;
    procedure InvalidateItem; override;
    procedure InvalidateMetaData; override;
    procedure SetCreateMemberItems(const Value: Boolean); virtual;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetItemClassFlags(Value: TInspectorClassFlags); virtual;
    procedure SetShowClassName(const Value: Boolean); virtual;

    property LastMemberInstance: TObject read FLastMemberInstance write FLastMemberInstance;
  public
    constructor Create(const AParent: TppJvCustomInspectorItem;
      const AData: TppJvCustomInspectorData); override;
    property CreateMemberItems: Boolean read GetCreateMemberItems
      write SetCreateMemberItems;
    property ItemClassFlags: TInspectorClassFlags read GetItemClassFlags
      write SetItemClassFlags;
    property OnGetValueList;
    property ShowClassName: Boolean read GetShowClassName write SetShowClassName;
  end;

  TppJvInspectorComponentItem = class(TppJvInspectorClassItem)
  private
    FItemComponentFlags: TInspectorComponentFlags;
    FOwners: TList;
  protected
    function GetItemComponentFlags: TInspectorComponentFlags;
    function GetKeepFirstOwnerAsFirst: Boolean;
    function GetNoShowFirstOwnerName: Boolean;
    function GetOwnerCount: Integer;
    function GetOwners(I: Integer): TComponent;
    function GetShowOwnerNames: Boolean;
    function GetSortComponents: Boolean;
    function GetSortOwners: Boolean;
    procedure GetValueList(const Strings: TStrings); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
    procedure SetItemClassFlags(Value: TInspectorClassFlags); override;
    procedure SetItemComponentFlags(Value: TInspectorComponentFlags); virtual;
    procedure SetKeepFirstOwnerAsFirst(Value: Boolean);
    procedure SetNoShowFirstOwnerName(Value: Boolean);
    procedure SetOwners(I: Integer; Value: TComponent);
    procedure SetShowOwnerNames(Value: Boolean);
    procedure SetSortComponents(Value: Boolean);
    procedure SetSortOwners(Value: Boolean);
  public
    constructor Create(const AParent: TppJvCustomInspectorItem;
      const AData: TppJvCustomInspectorData); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure AddOwner(const AOwner: TComponent);
    procedure DeleteOwner(const AOwner: TComponent); overload;
    procedure DeleteOwner(const Index: Integer); overload;
    property ItemComponentFlags: TInspectorComponentFlags read GetItemComponentFlags write SetItemComponentFlags;
    property KeepFirstOwnerAsFirst: Boolean read GetKeepFirstOwnerAsFirst write SetKeepFirstOwnerAsFirst;
    property NoShowFirstOwnerName: Boolean read GetNoShowFirstOwnerName write SetNoShowFirstOwnerName;
    property OwnerCount: Integer read GetOwnerCount;
    property Owners[I: Integer]: TComponent read GetOwners write SetOwners;
    property ShowOwnerNames: Boolean read GetShowOwnerNames write SetShowOwnerNames;
    property SortComponents: Boolean read GetSortComponents write SetSortComponents;
    property SortOwners: Boolean read GetSortOwners write SetSortOwners;
  end;

  TppJvInspectorFontItem = class(TppJvInspectorClassItem)
  protected
    procedure Edit; override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  end;

  TppJvInspectorFontNameItem = class(TppJvInspectorStringItem)
  protected
    procedure DoDrawListItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState); override;
    procedure DoMeasureListItem(Control: TWinControl; Index: Integer;
      var Height: Integer); override;
    procedure DoMeasureListItemWidth(Control: TWinControl; Index: Integer;
      var Width: Integer); override;
    procedure GetValueList(const Strings: TStrings); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  end;

  TppJvInspectorBooleanItem = class(TppJvInspectorEnumItem)
  private
    FCheckRect: TRect;
    FShowAsCheckbox: Boolean;
  protected
    function GetShowAsCheckbox: Boolean; virtual;
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure SetShowAsCheckbox(Value: Boolean); virtual;
  public
    procedure DoneEdit(const CancelEdits: Boolean = False); override;
    procedure DrawValue(const ACanvas: TCanvas); override;
    procedure InitEdit; override;
    property ShowAsCheckbox: Boolean read GetShowAsCheckBox
      write SetShowAsCheckBox;
  end;

  TppJvInspectorDateItem = class(TppJvInspectorFloatItem)
  private
    FFormat: string;
  protected
    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFormat(Value: string);
  public
    constructor Create(const AParent: TppJvCustomInspectorItem;
      const AData: TppJvCustomInspectorData); override;
  published
    property Format: string read FFormat write SetFormat;
  end;

  TppJvInspectorTimeItem = class(TppJvInspectorFloatItem)
  private
    FFormat: string;
    FShowAMPM: Boolean;
    FShowSeconds: Boolean;
  protected
    function GetDisplayValue: string; override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFormat;
    procedure SetShowAMPM(Value: Boolean);
    procedure SetShowSeconds(Value: Boolean);
    property Format: string read FFormat;
  public
    constructor Create(const AParent: TppJvCustomInspectorItem;
      const AData: TppJvCustomInspectorData); override;
  published
    property ShowAMPM: Boolean read FShowAMPM write SetShowAMPM;
    property ShowSeconds: Boolean read FShowSeconds write SetShowSeconds;
  end;

  TppJvInspectorDateTimeItem = class(TppJvInspectorCustomCompoundItem)
  private
    FDate: TppJvInspectorDateItem;
    FTime: TppJvInspectorTimeItem;
  protected
    function GetDateFormat: string;
    function GetTimeShowAMPM: Boolean;
    function GetTimeShowSeconds: Boolean;
    procedure SetDateFormat(Value: string);
    procedure SetTimeShowAMPM(Value: Boolean);
    procedure SetTimeShowSeconds(Value: Boolean);
  public
    constructor Create(const AParent: TppJvCustomInspectorItem;
      const AData: TppJvCustomInspectorData); override;
  published
    property DateFormat: string read GetDateFormat write SetDateFormat;
    property TimeShowAMPM: Boolean read GetTimeShowAMPM write SetTimeShowAMPM;
    property TimeShowSeconds: Boolean read GetTimeShowSeconds write SetTimeShowSeconds;
  end;

  TppJvInspectorTStringsItem = class(TppJvCustomInspectorItem)
  protected
    procedure ContentsChanged(Sender: TObject);
    function GetDisplayValue: string; override;
    procedure Edit; override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  public
    constructor Create(const AParent: TppJvCustomInspectorItem;
      const AData: TppJvCustomInspectorData); override;
  end;

  TppJvInspectorTMethodItem = class(TppJvCustomInspectorItem)
  private
    FList: TStrings; // list of object instances with list of methods attached.
    FItemTMethodFlags: TInspectorTMethodFlags;
  protected
    function GetInstanceCount: Integer;
    function GetInstances(I: Integer): TObject;
    function GetInstanceNames(I: Integer): string;
    function GetItemTMethodFlags: TInspectorTMethodFlags;
    function GetKeepFirstInstanceAsFirst: Boolean;
    function GetMethodCount(Instance: TObject): Integer;
    function GetMethods(Instance: TObject; I: Integer): TMethod;
    function GetMethodNames(Instance: TObject; I: Integer): string;
    function GetNoShowFirstInstanceName: Boolean;
    function GetShowInstanceNames: Boolean;
    function GetSortMethods: Boolean;
    function GetSortInstances: Boolean;
    procedure SetItemTMethodFlags(Value: TInspectorTMethodFlags);
    procedure SetKeepFirstInstanceAsFirst(Value: Boolean);
    procedure SetNoShowFirstInstanceName(Value: Boolean);
    procedure SetShowInstanceNames(Value: Boolean);
    procedure SetSortMethods(Value: Boolean);
    procedure SetSortInstances(Value: Boolean);
    procedure AddInstancePrim(const Instance: TObject; const InstanceName: string); virtual;
    procedure AddMethodPrim(const Instance: TObject; const MethodAddr: Pointer; const MethodName: string); virtual;
    function MethodFromName(const Name: string): TMethod;
    function MethodFromAbsIndex(const Idx: Integer): TMethod;
    function NameFromMethod(const Method: TMethod): string;
    function AbsIndexFromMethod(const Method: TMethod): Integer;
    function GetDisplayValue: string; override;
    procedure GetValueList(const Strings: TStrings); override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure AddInstance(const Instance: TObject; const InstanceName: string);
    procedure AddMethod(const Method: TMethod; const MethodName: string); overload;
    procedure AddMethod(const Instance: TObject; MethodAddr: Pointer; const MethodName: string); overload;
    procedure DeleteInstance(const Index: Integer); overload;
    procedure DeleteInstance(const Instance: TObject); overload;
    procedure DeleteInstance(const InstanceName: string); overload;
    procedure DeleteMethod(const Method: TMethod); overload;
    procedure DeleteMethod(const InstanceIndex: Integer; const Index: Integer); overload;
    procedure DeleteMethod(const Instance: TObject; const Index: Integer); overload;
    procedure DeleteMethod(const InstanceName: string; const Index: Integer); overload;
    procedure DeleteMethod(const InstanceIndex: Integer; const MethodName: string); overload;
    procedure DeleteMethod(const Instance: TObject; const MethodName: string); overload;
    procedure DeleteMethod(const InstanceName: string; const MethodName: string); overload;
    procedure ClearInstances;
    procedure ClearMethods(const InstanceIndex: Integer); overload;
    procedure ClearMethods(const Instance: TObject); overload;
    procedure ClearMethods(const InstanceName: string); overload;
    function IndexOfInstance(const Instance: TObject): Integer; overload;
    function IndexOfInstance(const InstanceName: string): Integer; overload;
    function IndexOfMethod(const Method: TMethod): Integer; overload;
    function IndexOfMethod(const InstanceIndex: Integer; const MethodName: string): Integer; overload;
    function IndexOfMethod(const Instance: TObject; const MethodName: string): Integer; overload;
    function IndexOfMethod(const InstanceName: string; const MethodName: string): Integer; overload;
    property InstanceCount: Integer read GetInstanceCount;
    property Instances[I: Integer]: TObject read GetInstances;
    property InstanceNames[I: Integer]: string read GetInstanceNames;
    property ItemTMethodFlags: TInspectorTMethodFlags read GetItemTMethodFlags write SetItemTMethodFlags;
    property KeepFirstInstanceAsFirst: Boolean read GetKeepFirstInstanceAsFirst write SetKeepFirstInstanceAsFirst;
    property MethodCount[Instance: TObject]: Integer read GetMethodCount;
    property Methods[Instance: TObject; I: Integer]: TMethod read GetMethods;
    property MethodNames[Instance: TObject; I: Integer]: string read GetMethodNames;
    property NoShowFirstInstanceName: Boolean read GetNoShowFirstInstanceName write SetNoShowFirstInstanceName;
    property ShowInstanceNames: Boolean read GetShowInstanceNames write SetShowInstanceNames;
    property SortInstances: Boolean read GetSortInstances write SetSortInstances;
    property SortMethods: Boolean read GetSortMethods write SetSortMethods;
  end;

  TppJvCustomInspectorData = class(TPersistent)
  private
    FTypeInfo: PTypeInfo;
    FItems: TppJvInspectorItemInstances;
    FName: string;
    FRegistered: Boolean;
    FOnValueChanged: TNotifyEvent;
  protected
    constructor CreatePrim(const AName: string; const ATypeInfo: PTypeInfo);
    procedure CheckReadAccess; virtual;
    procedure CheckWriteAccess; virtual;
    procedure DoDataChanged;
    procedure DoneEdits(const CancelEdits: Boolean = False);
    function GetAsFloat: Extended; virtual; abstract;
    function GetAsInt64: Int64; virtual; abstract;
    function GetAsMethod: TMethod; virtual; abstract;
    function GetAsOrdinal: Int64; virtual; abstract;
    function GetAsString: string; virtual; abstract;
    function GetItemCount: Integer;
    function GetItems(I: Integer): TppJvCustomInspectorItem;
    function GetName: string; virtual;
    function GetTypeInfo: PTypeInfo; virtual;
    procedure InitEdits;
    procedure Invalidate; virtual;
    function IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean; virtual;
    procedure NotifyRemoveData(const Instance: TppJvCustomInspectorData); virtual;
    procedure RefreshEdits;
    class function RegisterInstance(const Instance: TppJvCustomInspectorData): TppJvCustomInspectorData;
    procedure RemoveItem(const Item: TppJvCustomInspectorItem);
    procedure SetAsFloat(const Value: Extended); virtual; abstract;
    procedure SetAsInt64(const Value: Int64); virtual; abstract;
    procedure SetAsMethod(const Value: TMethod); virtual; abstract;
    procedure SetAsOrdinal(const Value: Int64); virtual; abstract;
    procedure SetAsString(const Value: string); virtual; abstract;
    procedure SetName(const Value: string); virtual;
    procedure SetTypeInfo(const Value: PTypeInfo); virtual;
    function SupportsMethodPointers: Boolean; virtual;
  public
    constructor Create;
    procedure BeforeDestruction; override;
    procedure GetAsSet(var Buf); virtual; abstract;
    function HasValue: Boolean; virtual; abstract;
    procedure InvalidateData; virtual;
    function IsAssigned: Boolean; virtual; abstract;
    function IsInitialized: Boolean; virtual; abstract;
    class function ItemRegister: TppJvInspectorRegister; virtual;
    class function New: TppJvCustomInspectorData;
    function NewItem(const AParent: TppJvCustomInspectorItem): TppJvCustomInspectorItem; virtual;
    procedure SetAsSet(const Buf); virtual; abstract;
    property AsFloat: Extended read GetAsFloat write SetAsFloat;
    property AsInt64: Int64 read GetAsInt64 write SetAsInt64;
    property AsMethod: TMethod read GetAsMethod write SetAsMethod;
    property AsOrdinal: Int64 read GetAsOrdinal write SetAsOrdinal;
    property AsString: string read GetAsString write SetAsString;
    property ItemCount: Integer read GetItemCount;
    property Items[I: Integer]: TppJvCustomInspectorItem read GetItems;
    property Name: string read GetName write SetName;
    property OnValueChanged: TNotifyEvent read FOnValueChanged write FOnValueChanged;
    property TypeInfo: PTypeInfo read GetTypeInfo write SetTypeInfo;
  end;

  TppJvInspectorSetMemberData = class(TppJvCustomInspectorData)
  private
    FBitOffset: Integer;
    FDataParent: TppJvCustomInspectorData;
  protected
    function GetAsFloat: Extended; override;
    function GetAsInt64: Int64; override;
    function GetAsMethod: TMethod; override;
    function GetAsOrdinal: Int64; override;
    function GetAsString: string; override;
    function IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean; override;
    procedure NotifyRemoveData(const Instance: TppJvCustomInspectorData); override;
    procedure SetAsFloat(const Value: Extended); override;
    procedure SetAsInt64(const Value: Int64); override;
    procedure SetAsMethod(const Value: TMethod); override;
    procedure SetAsOrdinal(const Value: Int64); override;
    procedure SetAsString(const Value: string); override;
  public
    procedure GetAsSet(var Buf); override;
    function HasValue: Boolean; override;
    function IsAssigned: Boolean; override;
    function IsInitialized: Boolean; override;
    class function New(const AParent: TppJvCustomInspectorItem; const Ordinal: Integer; const ADataParent: TppJvCustomInspectorData): TppJvCustomInspectorItem;
    procedure SetAsSet(const Buf); override;
    property BitOffset: Integer read FBitOffset;
    property DataParent: TppJvCustomInspectorData read FDataParent;
  end;

  TppJvInspectorVarData = class(TppJvCustomInspectorData)
  private
    FAddress: Pointer;
  protected
    function GetAddress: Pointer; virtual;
    function GetAsFloat: Extended; override;
    function GetAsInt64: Int64; override;
    function GetAsMethod: TMethod; override;
    function GetAsOrdinal: Int64; override;
    function GetAsString: string; override;
    function IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean; override;
    procedure SetAddress(const Value: Pointer); virtual;
    procedure SetAsFloat(const Value: Extended); override;
    procedure SetAsInt64(const Value: Int64); override;
    procedure SetAsMethod(const Value: TMethod); override;
    procedure SetAsOrdinal(const Value: Int64); override;
    procedure SetAsString(const Value: string); override;
    function SupportsMethodPointers: Boolean; override;
  public
    procedure GetAsSet(var Buf); override;
    function HasValue: Boolean; override;
    function IsAssigned: Boolean; override;
    function IsInitialized: Boolean; override;
    class function ItemRegister: TppJvInspectorRegister; override;
    class function New(const AParent: TppJvCustomInspectorItem; const AName: string; const ATypeInfo: PTypeInfo; const AAddress: Pointer): TppJvCustomInspectorItem; overload;
    class function New(const AParent: TppJvCustomInspectorItem; const AName: string; const ATypeInfo: PTypeInfo; const AVar): TppJvCustomInspectorItem; overload;
    procedure SetAsSet(const Buf); override;
    property Address: Pointer read GetAddress write SetAddress;
  end;

  TppJvInspectorPropData = class(TppJvCustomInspectorData)
  private
    FInstance: TObject;
    FProp: PPropInfo;
  protected
    function GetAsFloat: Extended; override;
    function GetAsInt64: Int64; override;
    function GetAsMethod: TMethod; override;
    function GetAsOrdinal: Int64; override;
    function GetAsString: string; override;
    function GetInstance: TObject; virtual;
    function GetProp: PPropInfo; virtual;
    function IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean; override;
    procedure NotifyRemoveData(const Instance: TppJvCustomInspectorData); override;
    procedure SetAsFloat(const Value: Extended); override;
    procedure SetAsInt64(const Value: Int64); override;
    procedure SetAsMethod(const Value: TMethod); override;
    procedure SetAsOrdinal(const Value: Int64); override;
    procedure SetAsString(const Value: string); override;
    procedure SetInstance(const Value: TObject); virtual;
    procedure SetProp(const Value: PPropInfo); virtual;
    function SupportsMethodPointers: Boolean; override;
  public
    procedure GetAsSet(var Buf); override;
    function HasValue: Boolean; override;
    function IsAssigned: Boolean; override;
    function IsInitialized: Boolean; override;
    class function ItemRegister: TppJvInspectorRegister; override;
    class function New(const AParent: TppJvCustomInspectorItem; const AInstance: TObject;
      const PropInfo: PPropInfo): TppJvCustomInspectorItem; overload;
    class function New(const AParent: TppJvCustomInspectorItem; const AInstance: TObject;
      const PropName: string): TppJvCustomInspectorItem; overload;
    class function New(const AParent: TppJvCustomInspectorItem; const AInstance: TObject;
      const TypeKinds: TTypeKinds = tkProperties): TppJvInspectorItemInstances; overload;
    class function NewByNames(const AParent: TppJvCustomInspectorItem; const AInstance: TObject;
      const NameList: array of string; const ExcludeList: Boolean = False;
      const TypeKinds: TTypeKinds = tkProperties): TppJvInspectorItemInstances;
    class function New(const AParent: TppJvCustomInspectorItem; const AInstance: TObject;
      const PropInfos: PPropList; const PropCount: Integer): TppJvInspectorItemInstances; overload;
    procedure SetAsSet(const Buf); override;
    property Instance: TObject read GetInstance write SetInstance;
    property Prop: PPropInfo read GetProp write SetProp;
  end;

  TppJvInspectorEventData  = class(TppJvCustomInspectorData)
  private
    FOnGetAsFloat: TppJvInspAsFloat;
    FOnGetAsInt64: TppJvInspAsInt64;
    FOnGetAsMethod: TppJvInspAsMethod;
    FOnGetAsOrdinal: TppJvInspAsInt64;
    FOnGetAsString: TppJvInspAsString;
    FOnGetAsSet: TppJvInspAsSet;
    FOnSetAsFloat: TppJvInspAsFloat;
    FOnSetAsInt64: TppJvInspAsInt64;
    FOnSetAsMethod: TppJvInspAsMethod;
    FOnSetAsOrdinal: TppJvInspAsInt64;
    FOnSetAsString: TppJvInspAsString;
    FOnSetAsSet: TppJvInspAsSet;
    FOnSupportsMethodPointers: TppJvInspSupportsMethodPointers;
  protected
    function DoGetAsFloat: Extended;
    function DoGetAsInt64: Int64;
    function DoGetAsMethod: TMethod;
    function DoGetAsOrdinal: Int64;
    function DoGetAsString: string;
    procedure DoGetAsSet(out Buf; var BufSize: Integer);
    procedure DoSetAsFloat(Value: Extended);
    procedure DoSetAsInt64(Value: Int64);
    procedure DoSetAsMethod(Value: TMethod);
    procedure DoSetAsOrdinal(Value: Int64);
    procedure DoSetAsString(Value: string);
    procedure DoSetAsSet(const Buf; var BufSize: Integer);
    function DoSupportsMethodPointers: Boolean; 
    function GetAsFloat: Extended; override;
    function GetAsInt64: Int64; override;
    function GetAsMethod: TMethod; override;
    function GetAsOrdinal: Int64; override;
    function GetAsString: string; override;
    function IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean; override;
    procedure SetAsFloat(const Value: Extended); override;
    procedure SetAsInt64(const Value: Int64); override;
    procedure SetAsMethod(const Value: TMethod); override;
    procedure SetAsOrdinal(const Value: Int64); override;
    procedure SetAsString(const Value: string); override;
    procedure SetOnGetAsFloat(Value: TppJvInspAsFloat);
    procedure SetOnGetAsInt64(Value: TppJvInspAsInt64);
    procedure SetOnGetAsMethod(Value: TppJvInspAsMethod);
    procedure SetOnGetAsOrdinal(Value: TppJvInspAsInt64);
    procedure SetOnGetAsString(Value: TppJvInspAsString);
    procedure SetOnGetAsSet(Value: TppJvInspAsSet);
    procedure SetOnSetAsFloat(Value: TppJvInspAsFloat);
    procedure SetOnSetAsInt64(Value: TppJvInspAsInt64);
    procedure SetOnSetAsMethod(Value: TppJvInspAsMethod);
    procedure SetOnSetAsOrdinal(Value: TppJvInspAsInt64);
    procedure SetOnSetAsString(Value: TppJvInspAsString);
    procedure SetOnSetAsSet(Value: TppJvInspAsSet);
    procedure SetOnSupportsMethodPointers(Value: TppJvInspSupportsMethodPointers);
    function SupportsMethodPointers: Boolean; override;
  public
    procedure GetAsSet(var Buf); override;
    function HasValue: Boolean; override;
    function IsAssigned: Boolean; override;
    function IsInitialized: Boolean; override;
    class function New(const AParent: TppJvCustomInspectorItem; const AName: string; const ATypeInfo: PTypeInfo): TppJvCustomInspectorItem;
    procedure SetAsSet(const Buf); override;
    property OnGetAsFloat: TppJvInspAsFloat read FOnGetAsFloat write SetOnGetAsFloat;
    property OnGetAsInt64: TppJvInspAsInt64 read FOnGetAsInt64 write SetOnGetAsInt64;
    property OnGetAsMethod: TppJvInspAsMethod read FOnGetAsMethod write SetOnGetAsMethod;
    property OnGetAsOrdinal: TppJvInspAsInt64 read FOnGetAsOrdinal write SetOnGetAsOrdinal;
    property OnGetAsString: TppJvInspAsString read FOnGetAsString write SetOnGetAsString;
    property OnGetAsSet: TppJvInspAsSet read FOnGetAsSet write SetOnGetAsSet;
    property OnSetAsFloat: TppJvInspAsFloat read FOnSetAsFloat write SetOnSetAsFloat;
    property OnSetAsInt64: TppJvInspAsInt64 read FOnSetAsInt64 write SetOnSetAsInt64;
    property OnSetAsMethod: TppJvInspAsMethod read FOnSetAsMethod write SetOnSetAsMethod;
    property OnSetAsOrdinal: TppJvInspAsInt64 read FOnSetAsOrdinal write SetOnSetAsOrdinal;
    property OnSetAsString: TppJvInspAsString read FOnSetAsString write SetOnSetAsString;
    property OnSetAsSet: TppJvInspAsSet read FOnSetAsSet write SetOnSetAsSet;
    property OnSupportsMethodPointers: TppJvInspSupportsMethodPointers read FOnSupportsMethodPointers write SetOnSupportsMethodPointers;
  end;

  TppJvInspectorCustomConfData = class(TppJvCustomInspectorData)
  private
    FKey: string;
    FSection: string;
  protected
    constructor CreatePrim(const AName, ASection, AKey: string; const ATypeInfo: PTypeInfo);
    function ExistingValue: Boolean; virtual; abstract;
    function GetAsFloat: Extended; override;
    function GetAsInt64: Int64; override;
    function GetAsMethod: TMethod; override;
    function GetAsOrdinal: Int64; override;
    function GetAsString: string; override;
    function ReadValue: string; virtual; abstract;
    function IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean; override;
    procedure SetAsFloat(const Value: Extended); override;
    procedure SetAsInt64(const Value: Int64); override;
    procedure SetAsMethod(const Value: TMethod); override;
    procedure SetAsOrdinal(const Value: Int64); override;
    procedure SetAsString(const Value: string); override;
    procedure SetKey(Value: string);
    procedure SetSection(Value: string);
    procedure WriteValue(Value: string); virtual; abstract;
  public
    procedure GetAsSet(var Buf); override;
    function HasValue: Boolean; override;
    function IsAssigned: Boolean; override;
    function IsInitialized: Boolean; override;
    procedure SetAsSet(const Buf); override;
    property Key: string read FKey write SetKey;
    property Section: string read FSection write SetSection;
  end;

  TppJvInspectorINIFileData = class(TppJvInspectorCustomConfData)
  private
    FINIFile: TCustomIniFile;
  protected
    function ExistingValue: Boolean; override;
    function IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean; override;
    function ReadValue: string; override;
    procedure WriteValue(Value: string); override;
  public
    class function New(const AParent: TppJvCustomInspectorItem; const AName, ASection, AKey: string;
      const ATypeInfo: PTypeInfo; const AINIFile: TCustomIniFile): TppJvCustomInspectorItem; overload;
    class function New(const AParent: TppJvCustomInspectorItem; const ASection: string;
      const AINIFile: TCustomIniFile; const AOnAddKey: TppJvInspConfKeyEvent): TppJvInspectorItemInstances; overload;
    class function New(const AParent: TppJvCustomInspectorItem; const AINIFile: TCustomIniFile;
      const AOnAddSection: TppJvInspConfSectionEvent;
      const AOnAddKey: TppJvInspConfKeyEvent): TppJvInspectorItemInstances; overload;
    property INIFile: TCustomIniFile read FINIFile;
  end;

  TppJvInspectorRegister = class(TPersistent)
  private
    FDataClass: TppJvInspectorDataClass;
    FItems: TObjectList;
  protected
    function Compare(const ADataObj: TppJvCustomInspectorData;
      const Item1, Item2: TppJvCustomInspectorRegItem): Integer;
    function GetCount: Integer;
    function GetItems(const I: Integer): TppJvCustomInspectorRegItem; virtual;
  public
    constructor Create(const ADataClass: TppJvInspectorDataClass);
    destructor Destroy; override;
    procedure Add(const RegItem: TppJvCustomInspectorRegItem);
    procedure Delete(const RegItem: TppJvCustomInspectorRegItem); overload;
    procedure Delete(const ItemClass: TppJvInspectorItemClass); overload;
    procedure Delete(const Index: Integer); overload;
    function FindMatch(
      const ADataObj: TppJvCustomInspectorData): TppJvCustomInspectorRegItem;
    function IndexOf(const RegItem: TppJvCustomInspectorRegItem): Integer; overload;
    function IndexOf(const ItemClass: TppJvInspectorItemClass): Integer; overload;
    property Count: Integer read GetCount;
    property DataClass: TppJvInspectorDataClass read FDataClass;
    property Items[const I: Integer]: TppJvCustomInspectorRegItem read GetItems;
  end;

  TppJvCustomInspectorRegItem = class(TPersistent)
  private
    FItemClass: TppJvInspectorItemClass;
  protected
    function CompareTo(const ADataObj: TppJvCustomInspectorData;
      const Item: TppJvCustomInspectorRegItem): Integer; virtual;
    function GetItemClass: TppJvInspectorItemClass; virtual;
    procedure SetItemClass(const Value: TppJvInspectorItemClass); virtual;
  public
    constructor Create(const AItemClass: TppJvInspectorItemClass);
    procedure ApplyDefaults(const Item: TppJvCustomInspectorItem); virtual;
    function Compare(const ADataObj: TppJvCustomInspectorData;
      const Item: TppJvCustomInspectorRegItem): Integer; virtual;
    function IsMatch(const ADataObj: TppJvCustomInspectorData): Boolean; virtual;
    function MatchValue(const ADataObj: TppJvCustomInspectorData): Integer;
      virtual; abstract;
    function MatchPercent(const ADataObj: TppJvCustomInspectorData): Integer; virtual; abstract;
    property ItemClass: TppJvInspectorItemClass read GetItemClass;
  end;

  TppJvInspectorTypeInfoRegItem = class(TppJvCustomInspectorRegItem)
  private
    FTypeInfo: PTypeInfo;
  protected
    function GetTypeInfo: PTypeInfo; virtual;
    procedure SetTypeInfo(const Value: PTypeInfo); virtual;
  public
    constructor Create(const AItemClass: TppJvInspectorItemClass; const ATypeInfo: PTypeInfo);
    function MatchValue(const ADataObj: TppJvCustomInspectorData): Integer; override;
    function MatchPercent(const ADataObj: TppJvCustomInspectorData): Integer; override;
    property TypeInfo: PTypeInfo read GetTypeInfo;
  end;

  TppJvInspectorTCaptionRegItem = class(TppJvInspectorTypeInfoRegItem)
  public
    procedure ApplyDefaults(const Item: TppJvCustomInspectorItem); override;
  end;

  TppJvInspectorTypeKindRegItem = class(TppJvCustomInspectorRegItem)
  private
    FTypeKind: TTypeKind;
  protected
    function CompareTo(const ADataObj: TppJvCustomInspectorData;
      const Item: TppJvCustomInspectorRegItem): Integer; override;
    function GetTypeKind: TTypeKind; virtual;
    procedure SetTypeKind(const Value: TTypeKind); virtual;
  public
    constructor Create(const AItemClass: TppJvInspectorItemClass;
      const ATypeKind: TTypeKind);
    function Compare(const ADataObj: TppJvCustomInspectorData;
      const Item: TppJvCustomInspectorRegItem): Integer; override;
    function MatchValue(const ADataObj: TppJvCustomInspectorData): Integer; override;
    function MatchPercent(const ADataObj: TppJvCustomInspectorData): Integer; override;
    property TypeKind: TTypeKind read GetTypeKind;
  end;

  TppJvInspectorPropRegItem = class(TppJvCustomInspectorRegItem)
  private
    FObjectClass: TClass;
    FName: string;
    FTypeInfo: PTypeInfo;
  protected
  public
    constructor Create(const AItemClass: TppJvInspectorItemClass; const AObjectClass: TClass;
      const AName: string; const ATypeInfo: PTypeInfo);
    function Compare(const ADataObj: TppJvCustomInspectorData;
      const Item: TppJvCustomInspectorRegItem): Integer; override;
    function MatchValue(const ADataObj: TppJvCustomInspectorData): Integer; override;
    function MatchPercent(const ADataObj: TppJvCustomInspectorData): Integer; override;
    property Name: string read FName;
    property ObjectClass: TClass read FObjectClass;
    property TypeInfo: PTypeInfo read FTypeInfo;
  end;

implementation

uses
  RTLConsts,
  Consts, Dialogs, ExtCtrls, Forms,

  ppUtils,
  ppJclRTTI,
  ppJclLogic;
//DFM  ,JclRTTI, JclLogic, JvWndProcHook;

type
  PMethod = ^TMethod;
  PComp = ^Comp;
  PPointer = ^Pointer;
  TOpenEdit = class(TCustomEdit);

var
  FGenItemReg: TppJvInspectorRegister;
  FVarItemReg: TppJvInspectorRegister;
  FPropItemReg: TppJvInspectorRegister;

//=== TppJvPopupListBox ========================================================

type
  TppJvPopupListBox = class(TCustomListBox)
  private
    FMouseOver: Boolean;
    FSearchText: string;
    FSearchTickCount: Longint;
    FMouseTimer: TTimer;
    FInspectorItem: TppJvCustomInspectorItem;

    procedure ehMouseTimer(Sender: TObject);
  protected
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyPress(var Key: Char); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    property InspectorItem: TppJvCustomInspectorItem read FInspectorItem write FInspectorItem;
  end;


// (rom) since RxLib is now part of JVCL, could the original be used?
{ TppJvPopupListBox - copied from RxLib }

constructor TppJvPopupListBox.Create(aOwner: TComponent);
begin

  inherited;

  FMouseTimer := TTimer.Create(nil);
  FMouseTimer.Interval := 1000;
  FMouseTimer.OnTimer := ehMouseTimer;
  FMouseTimer.Enabled := True;

end;

destructor TppJvPopupListBox.Destroy;
begin

  FMouseTimer.Free;

  inherited;

end;

procedure TppJvPopupListBox.ehMouseTimer(Sender: TObject);
begin
  if csDestroying in ComponentState then Exit;
  if Parent = nil then Exit;
  // if the mouse is not over the control and the parent edit box does not
  //   have focuse then close up the window
  if (InspectorItem <> nil) then
    if not FMouseOver and not Parent.Focused then
        InspectorItem.CloseUp(False);
end;

procedure TppJvPopupListBox.CMMouseEnter(var Message: TMessage);
begin

  FMouseOver := True;

  inherited;
end;

procedure TppJvPopupListBox.CMMouseLeave(var Message: TMessage);
begin
  FMouseOver := False;

  inherited;
end;



procedure TppJvPopupListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS;
  end; 
end;

procedure TppJvPopupListBox.CreateWnd;
begin
  inherited CreateWnd;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, WM_SETFOCUS, 0, 0);
end;



procedure TppJvPopupListBox.KeyPress(var Key: Char);
var
  TickCount: Integer;
begin
  case Key of
    #8, #27:
      FSearchText := '';
    #32..#255:
      begin
        TickCount := GetTickCount;
        if TickCount - FSearchTickCount > 4000 then
          FSearchText := '';
        FSearchTickCount := TickCount;
        if Length(FSearchText) < 32 then
          FSearchText := FSearchText + Key;
        SendMessage(Handle, LB_SELECTSTRING, WORD(-1),
          Longint(PChar(FSearchText)));
        Key := #0;
      end;
  end;
  inherited KeyPress(Key);
end;

//=== TCanvasStack ===========================================================

function HeightOf(const Rect: TRect): Integer;
begin
  Result := Rect.Bottom - Rect.Top;
end;

function WidthOf(const Rect: TRect): Integer;
begin
  Result := Rect.Right - Rect.Left;
end;

type
  TCanvasStack = class(TObjectList)
  private
    FTop: Integer;
  protected
    procedure ChangeCapacity(const Value: Integer);
  public
    constructor Create(const ACapacity: Integer);
    function Push(const Canvas: TCanvas): Integer;
    procedure Pop(const Canvas: TCanvas; Index: Integer = -2);
    procedure Peek(const Canvas: TCanvas; Index: Integer = -2);
    property Capacity write ChangeCapacity;
    property Top: Integer read FTop write FTop;
  end;

  TCanvasState = class(TPersistent)
  private
    FBrush: TBrush;
    FPen: TPen;
    FFont: TFont;
  public
    constructor Create(const Canvas: TCanvas);
    destructor Destroy; override;
    procedure ApplyTo(const Canvas: TCanvas);
    procedure SetState(const Canvas: TCanvas);
  end;

var
  CanvasStack: TCanvasStack;

procedure TCanvasStack.ChangeCapacity(const Value: Integer);
var
  I: Integer;
begin
  if Capacity <> Value then
  begin
    if Value < Capacity then
    begin
      inherited Capacity := Value;
      if FTop >= Capacity then
        FTop := Pred(Capacity);
    end
    else
    begin
      I := Capacity;
      inherited Capacity := Value;
      for I := I to Pred(Value) do
        Add(TCanvasState.Create(nil));
    end;                          
  end;
end;

constructor TCanvasStack.Create(const ACapacity: Integer);
begin
  inherited Create(True);
  FTop := -1;
  Capacity := ACapacity;
end;

function TCanvasStack.Push(const Canvas: TCanvas): Integer;
begin
  Inc(FTop);
  if FTop >= Capacity then
    Capacity := Capacity + 128;
  Result := FTop;
  TCanvasState(Items[Result]).SetState(Canvas);
end;

procedure TCanvasStack.Pop(const Canvas: TCanvas; Index: Integer = -2);
begin
  if Index = -1 then
    Index := FTop;
  TCanvasState(Items[Index]).ApplyTo(Canvas);
  FTop := Pred(Index);
end;

procedure TCanvasStack.Peek(const Canvas: TCanvas; Index: Integer = -2);
begin
  if Index = -1 then
    Index := FTop;
  TCanvasState(Items[Index]).ApplyTo(Canvas);
end;

//=== TCanvasState ===========================================================

constructor TCanvasState.Create(const Canvas: TCanvas);
begin
  inherited Create;
  FBrush := TBrush.Create;
  FPen := TPen.Create;
  FFont := TFont.Create;
  if Canvas <> nil then
    SetState(Canvas);
end;

destructor TCanvasState.Destroy;
begin
  FFont.Free;
  FPen.Free;
  FBrush.Free;
  // (rom) added inherited Destroy
  inherited Destroy;
end;

procedure TCanvasState.ApplyTo(const Canvas: TCanvas);
begin
  Canvas.Brush.Assign(FBrush);
  Canvas.Pen.Assign(FPen);
  Canvas.Font.Assign(FFont);
end;

procedure TCanvasState.SetState(const Canvas: TCanvas);
begin
  FBrush.Assign(Canvas.Brush);
  FPen.Assign(Canvas.Pen);
  FFont.Assign(Canvas.Font);
end;

function SaveCanvasState(const Canvas: TCanvas): Integer;
begin
  Result := CanvasStack.Push(Canvas);
end;

procedure ApplyCanvasState(const Canvas: TCanvas; const SavedIdx: Integer);
begin
  TCanvasState(CanvasStack[SavedIdx]).ApplyTo(Canvas);
end;

procedure RestoreCanvasState(const Canvas: TCanvas; const SavedIdx: Integer);
begin
  CanvasStack.Pop(Canvas, SavedIdx);
end;

procedure SetDefaultProp(const Instance: TObject; const PropName: string); overload;
var
  Prop: PPropInfo;
begin
  Prop := GetPropInfo(Instance, PropName);
  if (Prop <> nil) and (Prop.Default <> Low(Integer)) then
    SetOrdProp(Instance, Prop, Prop.Default);
end;

procedure SetDefaultProp(const Instance: TObject; const PropNames: array of string); overload;
var
  I: Integer;
begin
  for I := Low(PropNames) to High(PropNames) do
    SetDefaultProp(Instance, PropNames[I]);
end;

//=== TInspReg ===============================================================

type
  TInspReg = class(TObject)
  private
    FInspectors: array of TppJvCustomInspector;

  protected
    function ApplicationDeactivate(var Msg: TMessage): Boolean;
    function IndexOf(const Inspector: TppJvCustomInspector): Integer;
  public
    procedure RegInspector(const Inspector: TppJvCustomInspector);
    procedure UnRegInspector(const Inspector: TppJvCustomInspector);
  end;

var
  InspReg: TInspReg;

function TInspReg.ApplicationDeactivate(var Msg: TMessage): Boolean;
var
  I: Integer;
begin
  Result := False;
  if Msg.Msg = CM_DEACTIVATE then
    // Post the CM_DEACTIVATE message to all registered inspectors
    for I := High(FInspectors) downto 0 do
      PostMessage(FInspectors[I].Handle, CM_DEACTIVATE, 0, 0);
end;

function TInspReg.IndexOf(const Inspector: TppJvCustomInspector): Integer;
begin
  Result := High(FInspectors);
  while (Result >= 0) and (FInspectors[Result] <> Inspector) do
    Dec(Result);
end;

procedure TInspReg.RegInspector(const Inspector: TppJvCustomInspector);
begin
  if IndexOf(Inspector) = -1 then
  begin
    SetLength(FInspectors, Length(FInspectors) + 1);
    FInspectors[High(FInspectors)] := Inspector;
//    if Length(FInspectors) = 1 then
//      RegisterWndProcHook(Application.Handle, ApplicationDeactivate, hoBeforeMsg);
  end;
end;

procedure TInspReg.UnRegInspector(const Inspector: TppJvCustomInspector);
var
  I: Integer;
begin
  I := IndexOf(Inspector);
  if I <> -1 then
  begin
    if I < High(FInspectors) then
      Move(FInspectors[I + 1], FInspectors[I], (High(FInspectors) - I) * SizeOf(TppJvCustomInspector));
    SetLength(FInspectors, High(FInspectors));
//DFM    if Length(FInspectors) = 0 then
//      UnRegisterWndProcHook(Application.Handle, ApplicationDeactivate, hoBeforeMsg);
  end;
end;

//=== TppJvInspDataReg =========================================================

type
  TppJvInspDataReg = class(TPersistent)
  private
    FInstanceList: TppJvInspectorDataInstances;
    FClearing: Boolean;
  protected
    function GetCount: Integer;
    function GetItems(I: Integer): TppJvCustomInspectorData;
  public
    constructor Create;
    destructor Destroy; override;
    // Adds a new data instance. If an instance pointing to the same data exists the given instance is destroyed and the registered instance returned
    function Add(Instance: TppJvCustomInspectorData): TppJvCustomInspectorData;
    // Deletes a data instance and all items referencing it. All other data instances are notified.
    procedure Delete(Instance: TppJvCustomInspectorData);
    // Deletes all data instances and items referencing them. No notification is issued to the data instances as they will be removed also.
    procedure Clear;
    // Locates a data instance that references the same data as the given instance. The index is returned or -1 if no instance was found.
    function Locate(Instance: TppJvCustomInspectorData): Integer;
    // Removes a data instance from the list. All other data instances are notified.
    procedure Remove(Instance: TppJvCustomInspectorData);
    property Count: Integer read GetCount;
    property Items[I: Integer]: TppJvCustomInspectorData read GetItems;
  end;

constructor TppJvInspDataReg.Create;
begin
  inherited Create;
  SetLength(FInstanceList, 0);
end;

destructor TppJvInspDataReg.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TppJvInspDataReg.GetCount: Integer;
begin
  Result := Length(FInstanceList);
end;

function TppJvInspDataReg.GetItems(I: Integer): TppJvCustomInspectorData;
begin
  if (I < Low(FInstanceList)) or (I > High(FInstanceList)) then
    TList.Error(SListIndexError, I);
  Result := FInstanceList[I];
end;

function TppJvInspDataReg.Add(Instance: TppJvCustomInspectorData): TppJvCustomInspectorData;
var
  I: Integer;
begin
  I := Locate(Instance);
  if I = -1 then
  begin
    SetLength(FInstanceList, Count + 1);
    FInstanceList[High(FInstanceList)] := Instance;
    Result := Instance;
    Result.FRegistered := True;
  end
  else
  begin
    if Items[I] <> Instance then
      Instance.Free;
    Result := Items[I];
  end;
end;

procedure TppJvInspDataReg.Delete(Instance: TppJvCustomInspectorData);
begin
  Instance.Free;
end;

procedure TppJvInspDataReg.Clear;
var
  I: Integer;
begin
  FClearing := True;
  try
    for I := High(FInstanceList) downto Low(FInstanceList) do
      Items[I].Free;
  finally
    FClearing := False;
  end;
end;

function TppJvInspDataReg.Locate(Instance: TppJvCustomInspectorData): Integer;
begin
  Result := High(FInstanceList);
  while Result > -1 do
  begin
    if (Instance = Items[Result]) or Instance.IsEqualReference(Items[Result]) then
      Break;
    Dec(Result);
  end;
end;

procedure TppJvInspDataReg.Remove(Instance: TppJvCustomInspectorData);
var
  I: Integer;
begin
  I := Locate(Instance);
  if I > -1 then
  begin
    if Items[I] <> Instance then
      raise EppJvInspectorData.Create('Internal error: two data instances pointing to the same data are registered.');
    if I < High(FInstanceList) then
      Move(FInstanceList[I + 1], FInstanceList[I], (Length(FInstanceList) - I) * SizeOf(TppJvCustomInspectorData));
    SetLength(FInstanceList, High(FInstanceList));
    if not FClearing then
      for I := Low(FInstanceList) to High(FInstanceList) do
        Items[I].NotifyRemoveData(Instance);
  end;
end;

var
  DataRegister: TppJvInspDataReg;

//=== TppJvCustomInspector =====================================================

function TppJvCustomInspector.CalcImageHeight: Integer;
var
  BandHeightNoSB: Integer;
  BandHeightSB: Integer;
  ClHeightNoSB: Integer;
  ClHeightSB: Integer;
  WinStyle: Longint;
  I: Integer;
begin
  BandHeightNoSB := 0;
  BandHeightSB := 0;
  FImageHeight := 0;
  FBandStartsNoSB.Clear;
  FBandStartsNoSB.Add(Pointer(0));
  FBandStartsSB.Clear;
  FBandStartsSB.Add(Pointer(0));
  ClHeightNoSB := ClientHeight;
  WinStyle := GetWindowLong(Handle, GWL_STYLE);
  if (WinStyle and WS_HSCROLL) <> 0 then
  begin
    ClHeightSB := ClHeightNoSB;
    Inc(ClHeightNoSB, GetSystemMetrics(SM_CYHSCROLL));
  end
  else
  begin
    ClHeightSB := ClHeightNoSB;
    Dec(ClHeightSB, GetSystemMetrics(SM_CYHSCROLL));
  end;
  for I := 0 to Pred(VisibleCount) do
  begin
    Inc(FImageHeight, VisibleItems[I].Height);
    if UseBands then
    begin
      if ((BandHeightSB + VisibleItems[I].Height) > ClHeightSB) and (BandHeightSB > 0) then
      begin
        FBandStartsSB.Add(Pointer(I));
        BandHeightSB := 0;
      end;
      if ((BandHeightNoSB + VisibleItems[I].Height) > ClHeightNoSB) and (BandHeightNoSB > 0) then
      begin
        FBandStartsNoSB.Add(Pointer(I));
        BandHeightNoSB := 0;
      end;
    end;
    Inc(BandHeightNoSB, VisibleItems[I].Height);
    Inc(BandHeightSB, VisibleItems[I].Height);
  end;
  Result := FImageHeight;
end;

function TppJvCustomInspector.CalcItemIndex(X, Y: Integer; var Rect: TRect): Integer;
var
  BandIdx: Integer;
  MaxIdx: Integer;
begin
  if UseBands then
  begin
    BandIdx := X div BandWidth + BandStarts.IndexOf(Pointer(TopIndex));
    if BandIdx < BandStarts.Count then
      Result := Integer(BandStarts[BandIdx])
    else
      Result := -1;
  end
  else
    Result := TopIndex;
  MaxIdx := VisibleCount;
  while (Result <> -1) and (Result < MaxIdx) and not PtInRect(VisibleItems[Result].Rects[iprItem], Point(X, Y)) do
    Inc(Result);
  if Result >= MaxIdx then
    Result := -1;
  if Result > -1 then
    Rect := VisibleItems[Result].Rects[iprItem];
end;

function TppJvCustomInspector.CalcItemRect(const Item: TppJvCustomInspectorItem): TRect;
begin
  Result := Item.Rects[iprItem];
end;

procedure TppJvCustomInspector.CMDeactivate(var Msg: TCMActivate);
begin
  inherited;
  if Selected <> nil then
    Selected.Deactivate;
end;

procedure TppJvCustomInspector.DoAfterDataCreate(const Data: TppJvCustomInspectorData);
begin
  if Assigned(FAfterDataCreate) then
    FAfterDataCreate(Self, Data);
end;

procedure TppJvCustomInspector.DoAfterItemCreate(const Item: TppJvCustomInspectorItem);
begin
  if Assigned(FAfterItemCreate) then
    FAfterItemCreate(Self, Item);
end;

procedure TppJvCustomInspector.DoBeforeItemCreate(const Data: TppJvCustomInspectorData;
  var ItemClass: TppJvInspectorItemClass);
begin
  if Assigned(FBeforeItemCreate) then
    FBeforeItemCreate(Self, Data, ItemClass);
end;

function TppJvCustomInspector.DoBeforeItemSelect(const NewItem: TppJvCustomInspectorItem): Boolean;
begin
  Result := True;
  if Assigned(FBeforeSelection) then
    FBeforeSelection(Self, NewItem, Result);
end;

procedure TppJvCustomInspector.DoDataValueChanged(const Data: TppJvCustomInspectorData);
begin
  if Assigned(FOnDataValueChanged) then
    FOnDataValueChanged(Self, Data);
end;

procedure TppJvCustomInspector.DoItemSelected;
begin
  if Assigned(FOnItemSelected) then
    FOnItemSelected(Self);
end;

procedure TppJvCustomInspector.DoItemValueChanged(const Item: TppJvCustomInspectorItem);
begin
  if Assigned(FOnItemValueChanged) then
    FOnItemValueChanged(Self, Item);
end;

function TppJvCustomInspector.GetAfterDataCreate: TInspectorDataEvent;
begin
  Result := FAfterDataCreate;
end;

function TppJvCustomInspector.GetAfterItemCreate: TInspectorItemEvent;
begin
  Result := FAfterItemCreate;
end;

function TppJvCustomInspector.GetBandFor(const ItemIdx: Integer): Integer;
begin
  Result := Pred(BandStarts.Count);
  while (Result > -1) and (Integer(BandStarts[Result]) > ItemIdx) do
    Dec(Result);
end;

function TppJvCustomInspector.GetBandStarts: TList;
begin
  if FBandStartsNoSB.Count > (ClientWidth div BandWidth) then
    Result := FBandStartsSB
  else
    Result := FBandStartsNoSB;
end;

function TppJvCustomInspector.GetBandWidth: Integer;
begin
  Result := FBandWidth;
end;

function TppJvCustomInspector.GetBeforeItemCreate: TInspectorItemBeforeCreateEvent;
begin
  Result := FBeforeItemCreate;
end;

function TppJvCustomInspector.GetBeforeSelection: TInspectorItemBeforeSelectEvent;
begin
  Result := FBeforeSelection;
end;

function TppJvCustomInspector.GetButtonRect(const ItemIndex: Integer): TRect;
var
  Item: TppJvCustomInspectorItem;
begin
  // retrieve item
  Item := VisibleItems[ItemIndex];

  // retrieve button rectangle
  if Item.Expanded or Item.HasViewableItems then
    Result := Item.Rects[iprBtnDstRect]
  else
    Result := Rect(0, 0, 0, 0);
end;

function TppJvCustomInspector.GetCollapseButton: TBitmap;
begin
  Result := FCollapseButton;
end;

function TppJvCustomInspector.GetDivider: Integer;
begin
  Result := FDivider;
end;

function TppJvCustomInspector.GetDividerAbs: Integer;
begin
  if RelativeDivider then
  begin
    if UseBands then
      Result := (FDivider * BandWidth) div 100
    else
    if HandleAllocated then
      Result := (FDivider * ClientWidth) div 100
    else
      Result := (FDivider * Width) div 100;
  end
  else
    Result := FDivider;
end;

function TppJvCustomInspector.GetExpandButton: TBitmap;
begin
  Result := FExpandButton;
end;

function TppJvCustomInspector.GetImageHeight: Integer;
begin
  if FImageHeight = 0 then
    CalcImageHeight;
  Result := FImageHeight;
end;

function TppJvCustomInspector.GetItemHeight: Integer;
begin
  Result := FItemHeight;
end;

function TppJvCustomInspector.GetLastFullVisible: Integer;
begin
  Result := YToIdx (IdxToY(TopIndex) + Pred(ClientHeight));
  if Result < 0 then
    Result := Pred(VisibleCount)
  else
  begin
    while (IdxToY(Result) + VisibleItems[Result].Height) > ClientHeight do
      Dec(Result);
  end;
end;

function TppJvCustomInspector.GetLockCount: Integer;
begin
  Result := FLockCount;
end;

function TppJvCustomInspector.GetRelativeDivider: Boolean;
begin
  Result := FRelativeDivider;
end;

function TppJvCustomInspector.GetRoot: TppJvCustomInspectorItem;
begin
  Result := FRoot;
end;

function TppJvCustomInspector.GetOnItemSelected: TNotifyEvent;
begin
  Result := FOnItemSelected;
end;

function TppJvCustomInspector.GetPainter: TppJvInspectorPainter;
begin
  Result := FPainter;
end;

function TppJvCustomInspector.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

function TppJvCustomInspector.GetSelected: TppJvCustomInspectorItem;
begin
  if (SelectedIndex > -1) and (SelectedIndex < VisibleCount) then
    Result := VisibleItems[SelectedIndex]
  else
    Result := nil;
end;

function TppJvCustomInspector.GetSelectedIndex: Integer;
begin
  Result := FSelectedIndex;
end;

function TppJvCustomInspector.GetTopIndex: Integer;
begin
  Result := FTopIndex;
end;

function TppJvCustomInspector.GetUseBands: Boolean;
begin
  Result := FUseBands;
end;

function TppJvCustomInspector.GetVisibleCount: Integer;
begin
  Result := FVisible.Count;
end;

function TppJvCustomInspector.GetVisibleItems(const I: Integer): TppJvCustomInspectorItem;
begin
  if I < 0 then
    Result := nil
  else
    Result := TppJvCustomInspectorItem(FVisible.Objects[I]);
end;

function TppJvCustomInspector.GetWantTabs: Boolean;
begin
  Result := FWantTabs;
end;

procedure TppJvCustomInspector.HandleBandResize(X: Integer);
var
  BSize: Integer;
begin
  BSize := X div Succ(BandSizingBand);
  if BSize < 100 then
    BSize := 100;
  BandWidth := BSize;
end;

function TppJvCustomInspector.IdxToY(const Index: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Pred(Index) do
    if (I < VisibleCount) then
      Inc(Result, VisibleItems[I].Height);
end;

procedure TppJvCustomInspector.IncPaintGeneration;
begin
  Inc(FPaintGen);
end;

procedure TppJvCustomInspector.InvalidateHeight;
begin
  FImageHeight := 0;
  if not BandSizing then
    TopIndex := TopIndex; // Adapt position
end;

procedure TppJvCustomInspector.InvalidateItem;
begin
  if (LockCount = 0) and HandleAllocated then
    UpdateScrollbars
  else
  if not NeedRebuild then
    NeedRedraw := True;
end;

procedure TppJvCustomInspector.InvalidateList;
begin
  if not (csDestroying in ComponentState) and (LockCount = 0) then
  begin
    if HandleAllocated then
    begin
      RebuildVisible;
      UpdateScrollbars;
    end
    else
     begin
      FVisible.Clear; // DM - need to clear the visible list
      NeedRebuild := True;
     end;
  end
  else
    begin
      FVisible.Clear;  // DM - need to clear the visible list
      NeedRebuild := True;
    end;
end;

procedure TppJvCustomInspector.KeyDown(var Key: Word; Shift: TShiftState);
var
  Item: TppJvCustomInspectorItem;
  IgnoreKey: Boolean;
  TmpH: Integer;
  TmpIdx: Integer;
begin
  Item := Selected;
  if Shift = [] then
  begin
    IgnoreKey := True;
    case Key of
      VK_UP:
        if SelectedIndex > 0 then
          SelectedIndex := SelectedIndex - 1;
      VK_DOWN:
        if SelectedIndex < Pred(VisibleCount) then
          SelectedIndex := SelectedIndex + 1;
      VK_PRIOR:
        begin
          if SelectedIndex > TopIndex  then
            SelectedIndex := TopIndex
          else
          if SelectedIndex > 0 then
          begin
            TmpH := VisibleItems[Pred(SelectedIndex)].Height;
            TmpIdx := YToIdx(IdxToY(SelectedIndex) + TmpH - ClientHeight);
            if TmpIdx < 0 then
              TmpIdx := 0;
            SelectedIndex := TmpIdx;
          end;
        end;
      VK_NEXT:
        begin
          TmpIdx := GetLastFullVisible;
          if SelectedIndex < TmpIdx then
            SelectedIndex := TmpIdx
          else
          if SelectedIndex < Pred(VisibleCount) then
          begin
            TmpH := VisibleItems[SelectedIndex].Height;
            TmpIdx := YToIdx(IdxToY(SelectedIndex) + TmpH + ClientHeight);
            if TmpIdx < 0 then
              TmpIdx := Pred(VisibleCount);
            SelectedIndex := TmpIdx;
          end;
        end;
      VK_TAB:
        if WantTabs then
        begin
          if Item is TppJvInspectorCustomCompoundItem then
          with Item as TppJvInspectorCustomCompoundItem do
          begin
            if SelectedColumnIndex < Pred(ColumnCount) then
              SelectedColumnIndex := SelectedColumnIndex + 1
            else
            if SelectedIndex < Pred(VisibleCount) then
              SelectedIndex := SelectedIndex + 1;
          end
          else
          if SelectedIndex < Pred(VisibleCount) then
            SelectedIndex := SelectedIndex + 1;
          if Item <> Selected then
          begin
            if Selected is TppJvInspectorCustomCompoundItem then
              TppJvInspectorCustomCompoundItem(Selected).SelectedColumnIndex := 0;
          end;
        end;
      VK_ADD:
        if Item.HasViewableItems and not Item.Expanded then
          Item.Expanded := True;
      VK_SUBTRACT:
        if Item.Expanded then
          Item.Expanded := False;
      else
        IgnoreKey := False;
    end;
    if IgnoreKey then
      Key := 0;
  end
  else
  if Shift = [ssShift] then
  begin
    IgnoreKey := True;
    case Key of
      VK_TAB:
        if WantTabs then
        begin
          if Item is TppJvInspectorCustomCompoundItem then
          with Item as TppJvInspectorCustomCompoundItem do
          begin
            if SelectedColumnIndex > 0 then
              SelectedColumnIndex := SelectedColumnIndex - 1
            else
            if SelectedIndex > 0 then
              SelectedIndex := SelectedIndex - 1;
          end
          else
          if SelectedIndex > 0 then
            SelectedIndex := SelectedIndex - 1;
          if Item <> Selected then
          begin
            if Selected is TppJvInspectorCustomCompoundItem then
              TppJvInspectorCustomCompoundItem(Selected).SelectedColumnIndex :=
                TppJvInspectorCustomCompoundItem(Selected).ColumnCount - 1;
          end;
        end;
      else
        IgnoreKey := True;
    end;
    if IgnoreKey then
      Key := 0;
  end;
  inherited KeyDown(Key, Shift);
  if (SelectedIndex >= 0) and
    (SelectedIndex < VisibleCount) then
  begin
    Item := Selected;
    if (Item <> nil) and Item.Editing then
    begin
      Item.ScrollInView;
      Item.EditKeyDown(Self, Key, Shift);
    end;
  end;
end;

procedure TppJvCustomInspector.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if ((Shift = []) and ((Key = VK_DOWN) or (Key = VK_UP) or (Key = VK_ADD) or
    (Key = VK_SUBTRACT) or (Key = VK_PRIOR) or (Key = VK_NEXT))) or
    ((Key = VK_TAB) and WantTabs) then
    Key := 0;
end;

procedure TppJvCustomInspector.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  BWidth: Integer;
  BandIdx: Integer;
  XB: Integer;
  ItemIndex: Integer;
  ItemRect: TRect;
  Item: TppJvCustomInspectorItem;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if UseBands then
  begin
    BWidth := BandWidth;
    BandIdx := X div BWidth + BandStarts.IndexOf(Pointer(TopIndex));
  end
  else
  begin
    BWidth := ClientWidth;
    BandIdx := -1;
  end;
  XB := X mod BWidth;
  ItemIndex := CalcItemIndex(X, Y, ItemRect);
  if ItemIndex < VisibleCount then
    Item := VisibleItems[ItemIndex]
  else
    Item := nil;
  if not Focused and ((Item = nil) or (not Item.Editing)) then
    SetFocus
  else
  if (Item <> nil) and (Item.Editing) then
    Item.SetFocus;
  if Button = mbLeft then
  begin
    // Check divider dragging
    if (XB >= Pred(DividerAbs)) and (XB <= Succ(DividerAbs)) then
      DraggingDivider := True
    // Check row sizing
    else
    if (ItemIndex < VisibleCount) and (Y >= Pred(ItemRect.Bottom)) and
      (Y <= Succ(ItemRect.Bottom)) and (Item.RowSizing.SizingFactor <> irsNoReSize) and
      Item.RowSizing.Sizable then
    begin
      RowSizing := True;
      RowSizingItem := Item;
    end
    // Check band sizing
    else
    if (UseBands and (XB >= BWidth - 3)) and (not UseBands or
      (BandIdx < BandStarts.Count)) then
    begin
      BandSizing := True;
      BandSizingBand := BandIdx - BandStarts.IndexOf(Pointer(TopIndex));
    end
    // Check selecting
    else
    if (ItemIndex < VisibleCount) and (ItemIndex <> SelectedIndex) then
    begin
      SelectedIndex := ItemIndex;
      Item := VisibleItems[ItemIndex];
    end;
    if not DraggingDivider and not RowSizing and not BandSizing then
      Selecting := True;
    if (Item <> nil) and
      ((Item.HasViewableItems and not (iifExpanded in Item.Flags)) or
        (iifExpanded in Item.Flags)) then
    begin
      if PtInRect(Item.Rects[iprBtnDstRect], Point(X, Y)) or
        ((ssDouble in Shift) and (XB < Pred(DividerAbs))) then
      begin
        Item.Expanded := not Item.Expanded;
        Selecting := False;
      end;
    end;
    if (Item <> nil) and (PtInRect(Item.Rects[iprNameArea], Point(X, Y)) or
        PtInRect(Item.Rects[iprValueArea], Point(X, Y))) then
      Item.MouseDown(Button, Shift, X, Y);
  end;
end;

procedure TppJvCustomInspector.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  BWidth: Integer;
  BandIdx: Integer;
  XB: Integer;
  ItemIndex: Integer;
  ItemRect: TRect;
  Item: TppJvCustomInspectorItem;
begin
  inherited MouseMove(Shift, X, Y);
  if UseBands then
  begin
    BWidth := BandWidth;
    BandIdx := X div BWidth + BandStarts.IndexOf(Pointer(TopIndex));
  end
  else
  begin
    BWidth := ClientWidth;
    BandIdx := -1;
  end;
  XB := X mod BWidth;
  if DraggingDivider then
    DividerAbs := XB
  else
  if BandSizing then
    HandleBandResize(X)
  else
  if (((XB >= Pred(DividerAbs)) and (XB <= Succ(DividerAbs))) or
    (UseBands and (XB >= BWidth - 3))) and (not UseBands or
    (BandIdx < BandStarts.Count)) then
    Cursor := crHSplit
  else
  begin
    Cursor := crDefault;
    ItemIndex := CalcItemIndex(X, Y, ItemRect);
    if RowSizing then
    begin
      if RowSizingItem <> nil then
      begin
        ItemRect := CalcItemRect(RowSizingItem);
        RowSizingItem.Height := Y - ItemRect.Top
      end;
    end
    else
    if Selecting then
    begin
      if (ItemIndex < VisibleCount) and
        (ItemIndex <> SelectedIndex) then
      begin
        if ItemIndex < 0 then
          ItemIndex := SelectedIndex;
        SelectedIndex := ItemIndex;
      end;
      if ItemIndex < VisibleCount then
        Item := VisibleItems[ItemIndex]
      else
        Item := nil;
      if Item <> nil then
        Item.MouseMove(Shift, X, Y);
    end
    else
    begin
      if (ItemIndex < VisibleCount) and (ItemIndex > -1) then
        Item := VisibleItems[ItemIndex]
      else
        Item := nil;
      if (Item <> nil) and (Y >= Pred(ItemRect.Bottom)) and
          (Y <= Succ(ItemRect.Bottom)) and (Item.RowSizing.SizingFactor <> irsNoReSize) and
          Item.RowSizing.Sizable then
        Cursor := crVSplit
      else
        Cursor := crDefault;
    end;
  end
end;

procedure TppJvCustomInspector.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ItemIndex: Integer;
  ItemRect: TRect;
  Item: TppJvCustomInspectorItem;
begin
  inherited MouseUp(Button, Shift, X, Y);
  ItemIndex := CalcItemIndex(X, Y, ItemRect);
  if ItemIndex < VisibleCount then
    Item := VisibleItems[ItemIndex]
  else
    Item := nil;
  if Button = mbLeft then
  begin
    if DraggingDivider then
      DraggingDivider := False
    else
    if RowSizing then
      RowSizing := False
    else
    if BandSizing then
    begin
      BandSizing := False;
      TopIndex := TopIndex; // resync position
    end
    else
    if Selecting then
      Selecting := False;
  end;
  if (Item <> nil) and (PtInRect(Item.Rects[iprNameArea], Point(X, Y)) or
      PtInRect(Item.Rects[iprValueArea], Point(X, Y))) then
    Item.MouseUp(Button, Shift, X, Y);
end;

procedure TppJvCustomInspector.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (Operation = opRemove) and (AComponent = Painter) then
    FPainter := nil;
end;

procedure TppJvCustomInspector.NotifySort(const Item: TppJvCustomInspectorItem);
begin
  if LockCount = 0 then
    Item.Sort
  else
  if (Item <> nil) and (SortNotificationList.IndexOf(Item) = -1) then
    SortNotificationList.Add(Item);
end;

procedure TppJvCustomInspector.Paint;
begin
  if Painter <> nil then
  begin
    if NeedRebuild then
      InvalidateList;
    IncPaintGeneration;
    Painter.Setup(Canvas);
    Painter.Paint;
  end
  else 
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ClientRect);
  end;
end;

function ListCompare(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := CompareText(List[Index1], List[Index2]);
end;

procedure TppJvCustomInspector.RebuildVisible;
var
  OldSel: TppJvCustomInspectorItem;
  Item: TppJvCustomInspectorItem;
  ItemStack: TStack;
begin
  FImageHeight := 0;
  OldSel := Selected;
  FVisible.Clear;
  Item := Root;
  ItemStack := TStack.Create;
  try
    while (Item <> nil) do
    begin
      if not Item.Hidden then
        FVisible.AddObject(Item.GetSortName, Item);
      if Item.Visible and Item.Expanded and (Item.Count > 0) then
      begin
        ItemStack.Push(Item);
        Item := Item.Items[0];
      end
      else
      begin
        Item := Item.GetNextSibling;
        while (Item = nil) and (ItemStack.Count > 0) do
        begin
          Item := TppJvCustomInspectorItem(ItemStack.Pop);
          Item := Item.GetNextSibling;
        end;
      end;
    end;
  finally
    ItemStack.Free;
  end;
  TStringList(FVisible).CustomSort(ListCompare);
  if OldSel <> nil then
    SelectedIndex := FVisible.IndexOfObject(OldSel);
  CalcImageHeight;
  NeedRebuild := False;
end;

procedure TppJvCustomInspector.RemoveNotifySort(const Item: TppJvCustomInspectorItem);
begin
  SortNotificationList.Remove(Item);
end;

procedure TppJvCustomInspector.Resize;
begin
  inherited Resize;
  if not BandSizing then
  begin
    FImageHeight := 0; // Force recalculation of bands
    if (ImageHeight <= ClientHeight) and UseBands then
      TopIndex := 0
    else
      TopIndex := TopIndex;
  end;
  if HandleAllocated then
    UpdateScrollbars;
end;

function TppJvCustomInspector.ScrollfactorV: Extended;
begin
  if ClientHeight > 32767 then
    Result := ClientHeight / 32767
  else
    Result := 1;
end;

procedure TppJvCustomInspector.SetAfterDataCreate(const Value: TInspectorDataEvent);
begin
  FAfterDataCreate := Value;
end;

procedure TppJvCustomInspector.SetAfterItemCreate(const Value: TInspectorItemEvent);
begin
  FAfterItemCreate := Value;
end;

procedure TppJvCustomInspector.SetBandWidth(Value: Integer);
begin
  if Value <> BandWidth then
  begin
    FBandWidth := Value;
    if not RelativeDivider then
      DividerAbs := DividerAbs;
    if HandleAllocated then
    begin
      CalcImageHeight;
      UpdateScrollbars;
    end;
  end;
end;

procedure TppJvCustomInspector.SetBeforeItemCreate(
  const Value: TInspectorItemBeforeCreateEvent);
begin
  FBeforeItemCreate := Value;
end;

procedure TppJvCustomInspector.SetBeforeSelection(const Value: TInspectorItemBeforeSelectEvent);
begin
  FBeforeSelection := Value;
end;

procedure TppJvCustomInspector.SetCollapseButton(const Value: TBitmap);
begin
  if Value = nil then
    FreeAndNil(FCollapseButton)
  else
  if not Assigned(FCollapseButton) then
  begin
    FCollapseButton := TBitmap.Create;
    FCollapseButton.Assign(Value);
  end;
  if HandleAllocated then
    UpdateScrollbars;
end;

procedure TppJvCustomInspector.SetDivider(Value: Integer);
begin
  if FDivider <> Value then
  begin
    if RelativeDivider then
    begin
      if UseBands then
        DividerAbs := (Value * BandWidth) div 100
      else
      if HandleAllocated then
        DividerAbs := (Value * ClientWidth) div 100
      else
        DividerAbs := (Value * Width) div 100;
    end
    else
      DividerAbs := Value;
  end;
end;

procedure TppJvCustomInspector.SetDividerAbs(Value: Integer);
var
  W: Integer;
begin
  if UseBands then
    W := BandWidth
  else
  if HandleAllocated then
    W := ClientWidth
  else
    W := Width;
  if Value > (W - 2 * ItemHeight) then
    Value := W - 2 * ItemHeight;
  if Value < (2 * ItemHeight) then
    Value := 2 * ItemHeight;
{  if DividerAbs <> Value then
  begin}
    if RelativeDivider then
    begin
      if UseBands then
        FDivider := (Value * 100) div BandWidth
      else
      if HandleAllocated then
        FDivider := (Value * 100) div ClientWidth
      else
        FDivider := (Value * 100) div Width;
    end
    else
      FDivider := Value;
    if HandleAllocated then
      UpdateScrollbars;
//  end;
end;

procedure TppJvCustomInspector.SetExpandButton(const Value: TBitmap);
begin
  if Value = nil then
    FreeAndNil(FExpandButton)
  else
  if not Assigned(FExpandButton) then
  begin
    FExpandButton := TBitmap.Create;
    FExpandButton.Assign(Value);
  end;
  if HandleAllocated then
    UpdateScrollbars;
end;

procedure TppJvCustomInspector.SetItemHeight(Value: Integer);
begin
  if Value <> ItemHeight then
  begin
    FItemHeight := Value;
    if HandleAllocated then
      UpdateScrollbars;
  end;
end;

procedure TppJvCustomInspector.SetLockCount(const Value: Integer);
begin
  if Value <> LockCount then
  begin
    FLockCount := Value;
    if LockCount = 0 then
    begin
      if NeedRebuild then
        InvalidateList
      else
        InvalidateItem;
    end;
  end;
end;

procedure TppJvCustomInspector.SetOnItemSelected(const Value: TNotifyEvent);
begin
  FOnItemSelected := Value;
end;

procedure TppJvCustomInspector.SetPainter(const Value: TppJvInspectorPainter);
begin
  if (Value <> Painter) then
  begin
    if Value <> nil then
    begin
      if (Value.Inspector <> nil) and (Value.Inspector <> Self) then
        raise EppJvInspector.Create(sppJvInspPaintOnlyUsedOnce);
    end;
    if Painter <> nil then
    begin
      Painter.RemoveFreeNotification(Self);
      Painter.SetInspector(nil);
    end;
    FPainter := Value;
    if Painter <> nil then
    begin
      Painter.SetInspector(Self);
      Painter.FreeNotification(Self);
    end;
    if HandleAllocated then
      UpdateScrollbars;
  end;
end;

procedure TppJvCustomInspector.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TppJvCustomInspector.SetRelativeDivider(Value: Boolean);
var
  OrgPos: Integer;
begin
  if Value <> RelativeDivider then
  begin
    OrgPos := DividerAbs;
    FRelativeDivider := Value;
    DividerAbs := OrgPos;
  end;
end;

procedure TppJvCustomInspector.SetSelected(const Value: TppJvCustomInspectorItem);
var
  Idx: Integer;
begin
  Idx := FVisible.IndexOfObject(Value);
  if Idx > -1 then
    SelectedIndex := Idx;
end;

procedure TppJvCustomInspector.SetSelectedIndex(Value: Integer);
var
  NewItem: TppJvCustomInspectorItem;
begin
  if Value >= VisibleCount then
    Value := Pred(VisibleCount);
  if Value < -1 then
    Value := -1;
  if Value <> SelectedIndex then
  begin
    if Value > -1 then
      NewItem := VisibleItems[Value]
    else
      NewItem := nil;
    if DoBeforeItemSelect(NewItem) then
    begin
      if Selected <> nil then
        Selected.DoneEdit(False);
      FSelectedIndex := Value;
      if Selected <> nil then
      begin
        Selected.ScrollInView;
        Selected.InitEdit;
      end;
      DoItemSelected;
      InvalidateItem;
    end;
  end;
end;

procedure TppJvCustomInspector.SetTopIndex(Value: Integer);
var
  MaxIdx: Integer;
begin
  if UseBands then
  begin
    MaxIdx := BandStarts.Count - (ClientWidth div BandWidth);
    if MaxIdx < 0 then
      MaxIdx := 0;
    MaxIdx := Integer(BandStarts[MaxIdx]);
  end
  else
    MaxIdx := Succ(YToIdx(ImageHeight - ClientHeight));
  if MaxIdx < 0 then
    MaxIdx := 0;
  if Value > MaxIdx then
    Value := MaxIdx;
  if Value < 0 then
    Value := 0;
  if UseBands and (BandStarts.IndexOf(Pointer(Value)) > -1) then
  begin
    MaxIdx := Pred(BandStarts.Count);
    while (MaxIdx > -1) and (Integer(BandStarts[MaxIdx]) > Value) do
      Dec(MaxIdx);
    if MaxIdx <= -1 then
      raise EppJvInspector.Create(sppJvAssertSetTopIndex);
    Value := Integer(BandStarts[MaxIdx]);
  end;
  if TopIndex <> Value then
  begin
    FTopIndex := Value;
    if HandleAllocated then
      UpdateScrollbars;
  end;
end;

procedure TppJvCustomInspector.SetUseBands(Value: Boolean);
begin
  if UseBands <> Value then
  begin
    FUseBands := Value;
    if not RelativeDivider then
      DividerAbs := DividerAbs;
    FImageHeight := 0;
    if HandleAllocated then
      UpdateScrollbars;
  end;
end;

procedure TppJvCustomInspector.SetWantTabs(Value: Boolean);
begin
  if Value <> WantTabs then
  begin
    FWantTabs := Value;
    RecreateWnd;
  end;
end;

procedure TppJvCustomInspector.UpdateScrollBars;
var
  DrawHeight: Integer;
  ClHeight: Integer;
  ScFactor: Extended;
  ScrollInfo: TScrollInfo;
  BCount: Integer;
  BPerPage: Integer;
begin
  if not UseBands then
  begin
    ShowScrollBar(Handle, SB_HORZ, False);
    // Cache the image height, client height and scroll factor
    DrawHeight := ImageHeight;
    ClHeight := ClientHeight;
    ScFactor := ScrollfactorV;
    { Needed to redisplay the scrollbar after it's hidden in the CloseUp method
      of an enumerated item's combobox }
    ShowScrollBar(Handle, SB_VERT, Round((DrawHeight) / ScFactor) >= Round(ClHeight / ScFactor));
    with ScrollInfo do
    begin
      cbSize := SizeOf(ScrollInfo);
      fMask := SIF_ALL;
      nMin := 0;
      nMax := Round((DrawHeight) / ScFactor);
      nPage := Round(ClHeight / ScFactor);
      nPos := Round(IdxToY(TopIndex) / ScFactor);
      nTrackPos := 0;
    end;
    SetScrollInfo(Handle, SB_VERT, ScrollInfo, True);
  end
  else
  begin
    ShowScrollBar(Handle, SB_VERT, False);
    { Needed to redisplay the scrollbar after it's hidden in the CloseUp method
      of an enumerated item's combobox }
    BCount := BandStarts.Count;
    BPerPage := ClientWidth div BandWidth;
    ShowScrollBar(Handle, SB_HORZ, BCount > BPerPage);
    with ScrollInfo do
    begin
      cbSize := SizeOf(ScrollInfo);
      fMask := SIF_ALL;
      nMin := 0;
      nMax := BCount - 1;
      nPage := BPerPage;
      nPos := GetBandFor(TopIndex);
      nTrackPos := 0;
    end;
    SetScrollInfo(Handle, SB_HORZ, ScrollInfo, True);
  end;
  Invalidate;
end;

function TppJvCustomInspector.ViewHeight: Integer;
begin
  Result := HeightOf(ViewRect);
end;

function TppJvCustomInspector.ViewRect: TRect;
begin
  Result := ClientRect;
end;

function TppJvCustomInspector.ViewWidth: Integer;
begin
  Result := WidthOf(ViewRect);
end;

procedure TppJvCustomInspector.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  inherited;
  Msg.Result := DLGC_WANTARROWS;
  if WantTabs then
    Msg.Result := Msg.Result + DLGC_WANTTAB;
end;

procedure TppJvCustomInspector.WMHScroll(var Msg: TWMScroll);
var
  CurBand: Integer;
  Delta: Integer;
begin
  CurBand := BandStarts.IndexOf(Pointer(TopIndex));
  case Msg.ScrollCode of
    SB_BOTTOM:
      Delta := BandStarts.Count - 1 - CurBand;
    SB_ENDSCROLL:
      Delta := 0;
    SB_LINEDOWN:
      Delta := 1;
    SB_LINEUP:
      Delta := -1;
    SB_PAGEDOWN:
      Delta := ClientWidth div bandWidth;
    SB_PAGEUP:
      Delta := -ClientWidth div bandWidth;
    SB_THUMBPOSITION:
      Delta := Msg.Pos - CurBand;
    SB_THUMBTRACK:
      Delta := Msg.Pos - CurBand;
    SB_TOP:
      Delta := -CurBand;
  else
    Delta := 0;
  end;
  Curband := CurBand + Delta;
  if CurBand < 0 then
    CurBand := 0;
  if CurBand >= BandStarts.Count then
    CurBand := BandStarts.Count - 1;
  TopIndex := Integer(BandStarts[CurBand]);
end;

procedure TppJvCustomInspector.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if Selected <> nil then
    Selected.SetFocus;
end;

procedure TppJvCustomInspector.WMVScroll(var Msg: TWMScroll);
var
  Delta: Integer;
  ScFactor: Extended;
begin
  Delta := 0;
  ScFactor := ScrollfactorV;
  case Msg.ScrollCode of
    SB_BOTTOM:
      Delta := ImageHeight - ClientHeight - IdxToY(TopIndex);
    SB_ENDSCROLL:
      Delta := 0;
    SB_LINEDOWN:
      TopIndex := TopIndex + 1;
    SB_LINEUP:
      TopIndex := TopIndex - 1;
    SB_PAGEDOWN:
      Delta := ClientHeight;
    SB_PAGEUP:
      Delta := -ClientHeight;
    SB_THUMBPOSITION:
      Delta := Round(Msg.Pos * ScFactor) - IdxToY(TopIndex);
    SB_THUMBTRACK:
      Delta := Round(Msg.Pos * ScFactor) - IdxToY(TopIndex);
    SB_TOP:
      Delta := -IdxToY(TopIndex);
  else
    Delta := 0;
  end;
  if Delta <> 0 then
    TopIndex := YToIdx(IdxToY(TopIndex) + Delta);
end;

function TppJvCustomInspector.YToIdx(const Y: Integer): Integer;
var
  CurY: Integer;
begin
  Result := 0;
  CurY := 0;
  while (Result < VisibleCount) and (Y > (CurY + VisibleItems[Result].Height)) do
  begin
    Inc(CurY, VisibleItems[Result].Height);
    Inc(Result);
  end;
  if Result >= VisibleCount then
    Result := -1;
end;

constructor TppJvCustomInspector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBandStartsNoSB := TList.Create;
  FBandStartsSB := TList.Create;
  FSortNotificationList := TList.Create;
  FItemHeight := 16;
  DoubleBuffered := True;
  FVisible := TStringList.Create;
  FRoot := TppJvCustomInspectorItem.Create(nil, nil);
  Root.SetInspector(Self);
  Root.Flags := [iifHidden, iifExpanded, iifReadonly, iifVisible];
  FSelectedIndex := -1;
  BevelKind := bkTile;
  BevelInner := bvNone;
  BevelOuter := bvLowered;
  TabStop := True;
  Width := 300;
  Height := 100;
  Divider := 75;
  BandWidth := 150;
  if not (csDesigning in ComponentState) then
    InspReg.RegInspector(Self);
end;

procedure TppJvCustomInspector.BeforeDestruction;
begin
  if not (csDesigning in ComponentState) then
    InspReg.UnRegInspector(Self);
  Painter.Free;
  Painter := nil;
  FRoot.Free;
  FBandStartsSB.Free;
  FBandStartsNoSB.Free;
  FSortNotificationList.Free;
  FVisible.Free;
end;
 
function TppJvCustomInspector.BeginUpdate: Integer;
begin
  Inc(FLockCount);
  Result := FLockCount;
end;

function TppJvCustomInspector.EndUpdate: Integer;
var
  I: Integer;
begin
  if LockCount > 0 then
    Dec(FLockCount);
  Result := LockCount;
  if Result = 0 then
  begin
    I := 0;
    FLockCount := -1; // Keep InvalidateSort from calling InvalidateList
    try
      while I < SortNotificationList.Count do
      begin
        TppJvCustomInspectorItem(SortNotificationList[I]).InvalidateSort;
        Inc(I);
      end;
    finally
      FLockCount := 0;
      if SortNotificationList.Count > 0 then
        NeedRebuild := True;
      if NeedRebuild then
        InvalidateList
      else
        InvalidateItem;
      SortNotificationList.Clear;
    end;
  end;
end;

function TppJvCustomInspector.Focused: Boolean;
begin
  Result := inherited Focused or ((Selected <> nil) and Selected.EditFocused);
end;

function TppJvCustomInspector.FocusedItem: TppJvCustomInspectorItem;
begin
  Result := Selected;
  if (Result <> nil) and (Result is TppJvInspectorCustomCompoundItem) then
  begin
    with (Result as TppJvInspectorCustomCompoundItem) do
      if SelectedColumn <> nil then
        Result := SelectedColumn.Item;
  end;
end;

function TppJvCustomInspector.VisibleIndex(
  const AItem: TppJvCustomInspectorItem): Integer;
begin
  Result := FVisible.IndexOfObject(AItem);
end;

//=== TppJvInspectorPainter ====================================================

destructor TppJvInspectorPainter.Destroy;
begin
  FInternalCollapseButton.Free;
  FInternalExpandButton.Free;
  inherited Destroy;
end;

procedure TppJvInspectorPainter.ApplyNameFont;
begin
  Canvas.Font := Inspector.Font;
  if Item is TppJvInspectorCustomCategoryItem then
    Canvas.Font.Color := CategoryTextColor
  else
    Canvas.Font.Color := NameColor;
end;

procedure TppJvInspectorPainter.ApplyValueFont;
begin
  Canvas.Font := Inspector.Font;
  Canvas.Font.Color := ValueColor;
end;

procedure TppJvInspectorPainter.CalcButtonBasedRects;
begin
end;

procedure TppJvInspectorPainter.CalcEditBasedRects;
begin
end;

procedure TppJvInspectorPainter.CalcNameBasedRects;
begin
end;

procedure TppJvInspectorPainter.CalcValueBasedRects;
begin
end;

function TppJvInspectorPainter.DividerWidth: Integer;
begin
  Result := 1;
end;

procedure TppJvInspectorPainter.DoPaint;
begin
end;

function TppJvInspectorPainter.GetBackgroundColor: TColor;
begin
  Result := FBackgroundColor;
end;

function TppJvInspectorPainter.GetCategoryColor: TColor;
begin
  Result := FCategoryColor;
end;

function TppJvInspectorPainter.GetCategoryTextColor: TColor;
begin
  Result := FCategoryTextColor;
end;

function TppJvInspectorPainter.GetCollapseImage: TBitmap;
begin
  if Assigned(Inspector.CollapseButton) then
    Result := Inspector.CollapseButton
  else
    Result := FInternalCollapseButton;
end;

function TppJvInspectorPainter.GetDividerColor: TColor;
begin
  Result := FDividerColor;
end;

function TppJvInspectorPainter.GetExpandImage: TBitmap;
begin
  if Assigned(Inspector.ExpandButton) then
    Result := Inspector.ExpandButton
  else
    Result := FInternalExpandButton;
end;

function TppJvInspectorPainter.GetNameColor: TColor;
begin
  Result := FNameColor;
end;

function TppJvInspectorPainter.GetNameHeight(const AItem: TppJvCustomInspectorItem): Integer;
var
  TmpCanvas: TCanvas;
begin
  TmpCanvas := Canvas;
  try
    Canvas := TControlCanvas.Create;
    TControlCanvas(Canvas).Control := Inspector;
    ApplyNameFont;
    Result := Canvas.TextHeight('Wy');
  finally
    if TmpCanvas <> Canvas then
      Canvas.Free;
    Canvas := TmpCanvas;
  end;
end;

function TppJvInspectorPainter.GetRects(const Index: TInspectorPaintRect): TRect;
begin
  if Item <> nil then
    Result := Item.Rects[Index]
  else
    Result := Rect(0, 0, 0, 0);
end;

function TppJvInspectorPainter.GetSelectedColor: TColor;
begin
  Result := FSelectedColor;
end;

function TppJvInspectorPainter.GetSelectedTextColor: TColor;
begin
  Result := FSelectedTextColor;
end;

function TppJvInspectorPainter.GetValueColor: TColor;
begin
  Result := FValueColor;
end;

function TppJvInspectorPainter.GetValueHeight(const AItem: TppJvCustomInspectorItem): Integer;
var
  TmpCanvas: TCanvas;
begin
  TmpCanvas := Canvas;
  try
    Canvas := TControlCanvas.Create;
    TControlCanvas(Canvas).Control := Inspector;
    ApplyValueFont;
    Result := Canvas.TextHeight('Wy');
  finally
    if TmpCanvas <> Canvas then
      Canvas.Free;
    Canvas := TmpCanvas;
  end;
end;

procedure TppJvInspectorPainter.HideEditor;
begin
  Inspector.Selected.Rects[iprEditValue] := Rect(0, 0, 0, 0);
end;

procedure TppJvInspectorPainter.InitializeColors;
begin
  SetDefaultProp(Self,
    ['BackgroundColor', 'DividerColor', 'NameColor', 'ValueColor',
     'CategoryColor', 'CategoryTextColor', 'SelectedColor', 'SelectedTextColor']);
end;

function TppJvInspectorPainter.Loading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

procedure TppJvInspectorPainter.Paint;
var
  SelItemVisible: Boolean;
  Rect: TRect;
  ItemIdx: Integer;
  MaxItemIdx: Integer;
  BandIdx: Integer;
  MaxBandItemIdx: Integer;
begin

  if (Canvas = nil) then Exit;

  SelItemVisible := False;
  Rect := Inspector.ViewRect;
  Canvas.FillRect(Rect);
  ItemIdx := Inspector.TopIndex;
  MaxItemIdx := Inspector.VisibleCount;
  if not Inspector.UseBands then
  begin
    // Loop through the visible list
    while (Rect.Top < Rect.Bottom) and (ItemIdx < MaxItemIdx) do
    begin
      SelItemVisible := SelItemVisible or (ItemIdx = Inspector.SelectedIndex);
      PaintItem(Rect, ItemIdx);
      Inc(ItemIdx);
    end;
  end
  else // if UseBands
  begin
    BandIdx := Inspector.BandStarts.IndexOf(Pointer(ItemIdx));
    Rect.Right := Rect.Left + Inspector.BandWidth - 4;
    while (ItemIdx < MaxItemIdx) and (Rect.Left < Inspector.ClientWidth) do
    begin
      Inc(BandIdx);
      if BandIdx < Inspector.BandStarts.Count then
        MaxBandItemIdx := Integer(Inspector.BandStarts[BandIdx])
      else
        MaxBandItemIdx := MaxItemIdx;
      while (Rect.Top < Rect.Bottom) and (ItemIdx < MaxBandItemIdx) do
      begin
        SelItemVisible := SelItemVisible or (ItemIdx = Inspector.SelectedIndex);
        PaintItem(Rect, ItemIdx);
        Inc(ItemIdx);
      end;
      MaxBandItemIdx := Rect.Right + 4;
      Rect := Inspector.ClientRect;
      Rect.Left := MaxBandItemIdx;
      Rect.Right := Rect.Left + Inspector.BandWidth - 4;
      Canvas.Pen.Color := clBtnShadow;
      Canvas.MoveTo(Rect.Left - 3, Rect.Top);
      Canvas.LineTo(Rect.Left - 3, Rect.Bottom);
      Canvas.MoveTo(Rect.Left - 1, Rect.Top);
      Canvas.LineTo(Rect.Left - 1, Rect.Bottom);
    end;
  end;
  if not SelItemVisible and (Inspector.Selected <> nil) then
    HideEditor;
end;

procedure TppJvInspectorPainter.PaintDivider(const X, YTop, YBottom: Integer);
begin
end;

procedure TppJvInspectorPainter.PaintItem(var ARect: TRect;
  const AItemIndex: Integer);
var
  OrgState: Integer;
begin
  OrgState := SaveCanvasState(Canvas);
  try
    // Initialize painter variables
    PaintRect := ARect;
    ItemIndex := AItemIndex;
    SetupItem;

    // Do actual painting
    DoPaint;

    // Finalize painting
    TeardownItem;
    ARect := PaintRect;
  finally
    RestoreCanvasState(Canvas, OrgState);
  end;
end;

procedure TppJvInspectorPainter.PaintItem(const AItem: TppJvCustomInspectorItem);
var
  OrgState: Integer;
begin
  OrgState := SaveCanvasState(Canvas);
  try
    // Initialize painter variables
    ItemIndex := -1;
    Item := AItem;
    SetupItem;

    // Do actual painting
    DoPaint;

    // Finalize painting
    TeardownItem;
  finally
    RestoreCanvasState(Canvas, OrgState);
  end;
end;

procedure TppJvInspectorPainter.SetBackgroundColor(const Value: TColor);
begin
  if Value <> BackgroundColor then
  begin
    FBackgroundColor := Value;
    if not Initializing and not Loading then
      Inspector.Invalidate;
  end;
end;

procedure TppJvInspectorPainter.SetCategoryColor(const Value: TColor);
begin
  if Value <> CategoryColor then
  begin
    FCategoryColor := Value;
    if not Initializing and not Loading then
      Inspector.Invalidate;
  end;
end;

procedure TppJvInspectorPainter.SetCategoryTextColor(const Value: TColor);
begin
  if Value <> CategoryTextColor then
  begin
    FCategoryTextColor := Value;
    if not Initializing and not Loading then
      Inspector.Invalidate;
  end;
end;

procedure TppJvInspectorPainter.SetDividerColor(const Value: TColor);
begin
  if DividerColor <> Value then
  begin
    FDividerColor := Value;
    if not Initializing and not Loading then
      Inspector.Invalidate;
  end;
end;

procedure TppJvInspectorPainter.SetNameColor(const Value: TColor);
begin
  if Value <> NameColor then
  begin
    FNameColor := Value;
    if not Initializing and not Loading then
      Inspector.Invalidate;
  end;
end;

procedure TppJvInspectorPainter.SetRects(const Index: TInspectorPaintRect;
  const ARect: TRect);
begin
  if Item <> nil then
    Item.Rects[Index] := ARect;
end;

procedure TppJvInspectorPainter.SetSelectedColor(const Value: TColor);
begin
  if Value <> SelectedColor then
  begin
    FSelectedColor := Value;
    if not Initializing and not Loading then
      Inspector.Invalidate;
  end;
end;

procedure TppJvInspectorPainter.SetSelectedTextColor(const Value: TColor);
begin
  if Value <> SelectedTextColor then
  begin
    FSelectedTextColor := Value;
    if not Initializing and not Loading then
      Inspector.Invalidate;
  end;
end;

procedure TppJvInspectorPainter.Setup(const ACanvas: TCanvas);
begin
  Canvas := ACanvas;
  Canvas.Brush.Color := BackgroundColor;
end;

procedure TppJvInspectorPainter.SetupItem;
begin
  // retrieve item
  if ItemIndex > -1 then
    Item := Inspector.VisibleItems[ItemIndex];

  if Item <> nil then
  begin
    // retrieve button image
    if Item.Expanded then
      ButtonImage := GetCollapseImage
    else
    if Item.HasViewableItems then
      ButtonImage := GetExpandImage
    else
      ButtonImage := nil;
  end
  else
      ButtonImage := nil;

  // calculate rectangles
  if ItemIndex > -1 then
    SetupRects;
end;

procedure TppJvInspectorPainter.SetupRects;
begin
  Rects[iprItem] := Rect(PaintRect.Left, PaintRect.Top,
    PaintRect.Right, Pred(PaintRect.Top + Item.Height));
end;

procedure TppJvInspectorPainter.SetValueColor(const Value: TColor);
begin
  if Value <> ValueColor then
  begin
    FValueColor := Value;
    if not Initializing and not Loading then
      Inspector.Invalidate;
  end;
end;

procedure TppJvInspectorPainter.TeardownItem;
var
  TmpRect: TRect;
begin
  TmpRect := PaintRect;
  TmpRect.Top := Succ(Rects[iprItem].Bottom);
  PaintRect := TmpRect;
  Item := nil;
  ItemIndex := -1;
end;

constructor TppJvInspectorPainter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInspector := nil;
  FInternalCollapseButton := TBitmap.Create;
  FInternalExpandButton := TBitmap.Create;
  Initializing := True;
  try
    InitializeColors;
  finally
    Initializing := False;
  end;
  with FInternalCollapseButton do
  begin
    Width := 9;
    Height := 9;
    Canvas.Brush.Color := clWhite;
    Canvas.Pen.Color := clBlack;
    Canvas.Rectangle(0, 0, 9, 9);
    Canvas.MoveTo(2, 4);
    Canvas.LineTo(7, 4);
  end;
  with FInternalExpandButton do
  begin
    Width := 9;
    Height := 9;
    Canvas.Brush.Color := clWhite;
    Canvas.Pen.Color := clBlack;
    Canvas.Rectangle(0, 0, 9, 9);
    Canvas.MoveTo(2, 4);
    Canvas.LineTo(7, 4);
    Canvas.MoveTo(4, 2);
    Canvas.LineTo(4, 7);
  end;
end;

procedure TppJvInspectorPainter.SetInspector(const AInspector: TppJvCustomInspector);
begin
  if (AInspector <> nil) and (AInspector.Painter <> Self) then
    raise EppJvInspector.Create(sppJvInspPaintNotActive);
  if AInspector <> Inspector then
  begin
    if (Inspector <> nil) and (AInspector <> nil) then
      raise EppJvInspector.Create(sppJvInspPaintOnlyUsedOnce);
    FInspector := AInspector;
  end;
end;

//=== TppJvInspectorBorlandNETBasePainter ======================================

procedure TppJvInspectorBorlandNETBasePainter.ApplyNameFont;
begin
  inherited ApplyNameFont;
  if Item is TppJvInspectorCustomCategoryItem then
    Canvas.Font.Style := Canvas.Font.Style + [fsBold];
end;

procedure TppJvInspectorBorlandNETBasePainter.ApplyValueFont;
begin
  inherited ApplyValueFont;
  if Item is TppJvInspectorCustomCategoryItem then
    Canvas.Font.Style := Canvas.Font.Style + [fsBold];
end;

procedure TppJvInspectorBorlandNETBasePainter.CalcButtonBasedRects;
var
  BtnSrcRect: TRect;
  BtnDstRect: TRect;
  Y: Integer;
begin
  if ButtonImage <> nil then
  begin
    BtnSrcRect := Rect(0, 0, ButtonImage.Width, ButtonImage.Height);
    BtnDstRect := Rect(0, 0, WidthOf(Rects[iprButtonArea]),
      HeightOf(Rects[iprButtonArea]));
    if BtnSrcRect.Right > BtnDstRect.Right then
    begin
      BtnSrcRect.Left := (BtnDstRect.Right - BtnSrcRect.Right) div 2;
      BtnSrcRect.Right := BtnSrcRect.Left + BtnDstRect.Right;
    end;
    if BtnSrcRect.Bottom > BtnDstRect.Bottom then
    begin
      BtnSrcRect.Top := (BtnDstRect.Bottom - BtnSrcRect.Bottom) div 2;
      BtnSrcRect.Bottom := BtnSrcRect.Top + BtnDstRect.Bottom;
    end;
    if BtnDstRect.Right > WidthOf(BtnSrcRect) then
    begin
      BtnDstRect.Left := (BtnDstRect.Right - WidthOf(BtnSrcRect)) div 2;
      BtnDstRect.Right := BtnDstRect.Left + WidthOf(BtnSrcRect);
    end;
    if BtnDstRect.Bottom > HeightOf(BtnSrcRect) then
    begin
      if (HeightOf(BtnDstRect) div Inspector.ItemHeight) < 2 then
        Y := (HeightOf(BtnDstRect) - HeightOf(BtnSrcRect)) div 2
      else
        Y := (Inspector.ItemHeight - HeightOf(BtnSrcRect)) div 2;
      BtnDstRect.Top := Y;
      BtnDstRect.Bottom := BtnDstRect.Top + HeightOf(BtnSrcRect);
    end;
    OffsetRect(BtnDstRect, Rects[iprButtonArea].Left, Rects[iprButtonArea].Top);
  end
  else
  begin
    BtnSrcRect := Rect(0, 0, 0, 0);
    BtnDstRect := Rect(0, 0, 0, 0);
  end;
  Rects[iprBtnSrcRect] := BtnSrcRect;
  Rects[iprBtnDstRect] := BtnDstRect;
end;

procedure TppJvInspectorBorlandNETBasePainter.CalcEditBasedRects;
var
  TmpRect: TRect;
begin
  if [iifValueList, iifEditButton] * Item.Flags = [] then
  begin
    Rects[iprEditValue] := Rects[iprValue];
    Rects[iprEditButton] := Rect(0, 0, 0, 0);
  end
  else
  begin
    TmpRect := Rects[iprValue];
    Dec(TmpRect.Right, Inspector.ItemHeight);
    Rects[iprEditValue] := TmpRect;
    TmpRect := Rects[iprValueArea];
    TmpRect.Left := TmpRect.Right - Inspector.ItemHeight;
    Rects[iprEditButton] := TmpRect;
  end;
end;

procedure TppJvInspectorBorlandNETBasePainter.CalcNameBasedRects;
var
  CanvasState: Integer;
  RowHeight: Integer;
  TmpRect: TRect;
begin
  CanvasState := SaveCanvasState(Canvas);
  try
    ApplyNameFont;
    RowHeight := Canvas.TextHeight('Wy');
    TmpRect := Rects[iprNameArea];
    if HeightOf(TmpRect) div RowHeight < 2 then
      OffsetRect(TmpRect, 0, (HeightOf(TmpRect) - RowHeight) div 2)
    else
    begin
      Inc(TmpRect.Top, 1);
      Dec(TmpRect.Bottom, 1);
    end;
    IntersectRect(TmpRect, TmpRect, Rects[iprNameArea]);
    Rects[iprName] := TmpRect;
  finally
    RestoreCanvasState(Inspector.Canvas, CanvasState);
  end;
end;

procedure TppJvInspectorBorlandNETBasePainter.CalcValueBasedRects;
var
  CanvasState: Integer;
  RowHeight: Integer;
  TmpRect: TRect;
begin
  CanvasState := SaveCanvasState(Canvas);
  try
    ApplyValueFont;
    RowHeight := Canvas.TextHeight('Wy');
    TmpRect := Rects[iprValueArea];
    if HeightOf(TmpRect) div RowHeight < 2 then
    begin
      OffsetRect(TmpRect, 0, (HeightOf(TmpRect) - RowHeight) div 2);
      IntersectRect(TmpRect, TmpRect, Rects[iprValueArea]);
    end
    else
    begin
      Inc(TmpRect.Top, 1);
      Dec(TmpRect.Bottom, 1);
      IntersectRect(TmpRect, TmpRect, Rects[iprValueArea]);
    end;
    Rects[iprValue] := TmpRect;
  finally
    RestoreCanvasState(Inspector.Canvas, CanvasState);
  end;
  CalcEditBasedRects;
end;

procedure TppJvInspectorBorlandNETBasePainter.SetupRects;
var
  ItemRect2: TRect;
  TmpRect: TRect;
begin
  inherited SetupRects;
  ItemRect2 := Rects[iprItem];
  Rects[iprButtonArea] := Rect(ItemRect2.Left + (Item.Level *
    Inspector.ItemHeight), ItemRect2.Top, ItemRect2.Left +
    (Succ(Item.Level) * Inspector.ItemHeight), ItemRect2.Bottom);
  TmpRect := ItemRect2;
  TmpRect.Left := Rects[iprButtonArea].Right;
  Rects[iprNameArea] := TmpRect;
  if Item is TppJvInspectorCustomCategoryItem then
    Rects[iprValueArea] := Rect(0, 0, 0, 0)
  else
  begin
    TmpRect.Right := ItemRect2.Left + Pred(Inspector.DividerAbs);
    Rects[iprNameArea] := TmpRect;
    TmpRect := ItemRect2;
    TmpRect.Left := ItemRect2.Left + Inspector.DividerAbs + DividerWidth;
    Rects[iprValueArea] := TmpRect;
  end;
  CalcButtonBasedRects;
  CalcNameBasedRects;
  CalcValueBasedRects;
end;

//=== TppJvInspectorBorlandPainter =============================================

function TppJvInspectorBorlandPainter.DividerWidth: Integer;
begin
  Result := 2;
end;

procedure TppJvInspectorBorlandPainter.DoPaint;
var
  TmpRect: TRect;
  X: Integer;
  MaxX: Integer;
begin
  TmpRect := Rects[iprItem];
  if Item = Inspector.Selected then
  begin
    // Selected frame
    InflateRect(TmpRect, 0, 1);
    Dec(TmpRect.Top);
    Inc(TmpRect.Right);
    Frame3D(Canvas, TmpRect, clBlack, clWhite, 1);
    Frame3D(Canvas, TmpRect, clBlack, cl3DLight, 1);
  end
  else
  begin
    // Dotted line
    X := TmpRect.Left;
    MaxX := TmpRect.Right;
    Canvas.Pen.Color := clBlack;
    while X < MaxX do
    begin
      Canvas.Pixels[X, TmpRect.Bottom] := clBlack;
      Inc(X, 2);
    end;
  end;

  if not (Item is TppJvInspectorCustomCategoryItem) then
  begin
    // Draw divider line
    TmpRect := Rects[iprItem];
    PaintDivider(TmpRect.Left + Inspector.DividerAbs, Pred(TmpRect.Top), TmpRect.Bottom);
  end;

  ApplyNameFont;
  Item.DrawName(Canvas);
  ApplyValueFont;
  Item.DrawValue(Canvas);

  if ButtonImage <> nil then
    Canvas.CopyRect(Rects[iprBtnDstRect], ButtonImage.Canvas, Rects[iprBtnSrcRect]);
end;

function TppJvInspectorBorlandPainter.GetDividerLightColor: TColor;
begin
  Result := FDividerLightColor;
end;

function TppJvInspectorBorlandPainter.GetSelectedColor: TColor;
begin
  Result := BackgroundColor;
end;

function TppJvInspectorBorlandPainter.GetSelectedTextColor: TColor;
begin
  Result := NameColor;
end;

procedure TppJvInspectorBorlandPainter.InitializeColors;
begin
  inherited InitializeColors;
  SetDefaultProp(Self, 'DividerLightColor');
end;

procedure TppJvInspectorBorlandPainter.PaintDivider(const X, YTop, YBottom: Integer);
begin
  with Canvas do
  begin
    Canvas.Pen.Color := DividerColor;
    MoveTo(X, YTop);
    LineTo(X, YBottom);
    Pen.Color := DividerLightColor;
    MoveTo(Succ(X), YBottom);
    LineTo(Succ(X), YTop);
  end;
end;

procedure TppJvInspectorBorlandPainter.SetDividerLightColor(const Value: TColor);
begin
  if DividerLightColor <> Value then
  begin
    FDividerLightColor := Value;
    if not Initializing and not Loading then
      Inspector.Invalidate;
  end;
end;

procedure TppJvInspectorBorlandPainter.Setup(const ACanvas: TCanvas);
begin
  inherited Setup(ACanvas);
  Canvas.Brush.Color := clBtnFace;
end;

//=== TppJvInspectorDotNETPainter ==============================================

procedure TppJvInspectorDotNETPainter.ApplyNameFont;
begin
  inherited ApplyNameFont;
  if (Item = Inspector.Selected) and not (Item is TppJvInspectorCustomCompoundItem) then
  begin
    Canvas.Brush.Color := SelectedColor;
    Canvas.Font.Color := SelectedTextColor;
  end
  else
  if (Item is TppJvInspectorCustomCategoryItem) and (Item.Level = 0) then
    Canvas.Brush.Color := CategoryColor
  else
    Canvas.Brush.Color := BackgroundColor;
end;

procedure TppJvInspectorDotNETPainter.DoPaint;
var
  EndOfList: Boolean;
  NextItem: TppJvCustomInspectorItem;
  EndOfCat: Boolean;
  PreNameRect: TRect;
  CatRect: TRect;
  SaveIdx: Integer;
  LeftX: Integer;
begin
  SaveIdx := SaveCanvasState(Canvas);

  // Determine item type (end of list, end of a level 0 category)
  EndOfList := Succ(ItemIndex) >= Inspector.VisibleCount;
  if not EndOfList then
  begin
    NextItem := Inspector.VisibleItems[Succ(ItemIndex)];
    EndOfCat := (NextItem.BaseCategory <> Item.BaseCategory) and
      (Item.BaseCategory <> nil);
  end
  else
    EndOfCat := Item.BaseCategory <> nil;

  PreNameRect := Rects[iprButtonArea];
  PreNameRect.Left := Rects[iprItem].Left + WidthOf(Rects[iprButtonArea]);
  Inc(PreNameRect.Right);

  CatRect := Rects[iprItem];
  CatRect.Right := CatRect.Left + WidthOf(Rects[iprButtonArea]);
  Inc(CatRect.Bottom);
  if (Item.BaseCategory <> nil) then
  begin
    Canvas.Brush.Color := CategoryColor;
    Canvas.FillRect(CatRect);
    ApplyCanvasState(Canvas, SaveIdx);
  end;
  
  if not (Item is TppJvInspectorCustomCategoryItem) or (Item.Level > 0) then
    PaintDivider(Rects[iprItem].Left + Inspector.DividerAbs, Pred(Rects[iprItem].Top),
      Rects[iprItem].Bottom);

  if (Item is TppJvInspectorCustomCategoryItem) and (Item.Level = 0) then
    Canvas.Brush.Color := CategoryColor;
  if (Item = Inspector.Selected) and (not (Item is TppJvInspectorCustomCompoundItem) or (TppJvInspectorCustomCompoundItem(Item).SelectedColumnIndex = 0)) and ((Item.Level > 0) or
      not (Item is TppJvInspectorCustomCategoryItem)) then
    Canvas.Brush.Color := SelectedColor;
  Canvas.FillRect(PreNameRect);
  ApplyNameFont;
  Canvas.FillRect(Rects[iprNameArea]);
  Item.DrawName(Canvas);
  ApplyCanvasState(Canvas, SaveIdx);
  ApplyValueFont;
  Item.DrawValue(Canvas);
  RestoreCanvasState(Canvas, SaveIdx);

  if ButtonImage <> nil then
    Canvas.CopyRect(Rects[iprBtnDstRect], ButtonImage.Canvas, Rects[iprBtnSrcRect]);

  SaveIdx := SaveCanvasState(Canvas);
  if EndOfCat or ((Item is TppJvInspectorCustomCategoryItem) and
      (Item.Level = 0)) then
    Canvas.Pen.Color := clBtnShadow
  else
    Canvas.Pen.Color := clBtnFace;
  if not EndOfList and not EndOfCat then
    LeftX := Rects[iprItem].Left + WidthOf(Rects[iprButtonArea])
  else
    LeftX := Rects[iprItem].Left;
  Canvas.MoveTo(Rects[iprItem].Right, Rects[iprItem].Bottom);
  Canvas.LineTo(Pred(LeftX), Rects[iprItem].Bottom);

  if Item <> Item.BaseCategory then
  begin
    if Item.BaseCategory <> nil then
      Canvas.Pen.Color := clBtnShadow
    else
      Canvas.Pen.Color := CategoryColor;
    Canvas.MoveTo(Rects[iprItem].Left + WidthOf(Rects[iprButtonArea]), Rects[iprItem].Top);
    Canvas.LineTo(Rects[iprItem].Left + WidthOf(Rects[iprButtonArea]), Succ(Rects[iprItem].Bottom));
  end;
  RestoreCanvasState(Canvas, SaveIdx);
end;

procedure TppJvInspectorDotNETPainter.PaintDivider(const X, YTop, YBottom: Integer);
begin
  with Canvas do
  begin
    Pen.Color := DividerColor;
    MoveTo(X, YTop);
    LineTo(X, YBottom);
  end
end;

//=== TppJvInspectorItemSizing =================================================

function TppJvInspectorItemSizing.GetMinHeight: TItemRowSizing;
begin
  Result := FMinHeight;
end;

function TppJvInspectorItemSizing.GetSizable: Boolean;
begin
  Result := FSizable;
end;

function TppJvInspectorItemSizing.GetSizingFactor: TItemRowSizing;
begin
  Result := FSizingFactor;
end;

procedure TppJvInspectorItemSizing.SetMinHeight(Value: TItemRowSizing);
var
  CurHeight: Integer;
begin
  CurHeight := Item.Height;
  if Value = irsNoResize then
  begin
    if SizingFactor <> Value then
      SizingFactor := Value
    else
    if MinHeight <> irsItemHeight then
    begin
      FMinHeight := irsItemHeight;
      Item.Height := CurHeight;
    end;
  end
  else
  if MinHeight <> Value then
  begin
    if SizingFactor = irsNoResize then
      FSizingFactor := irsValueMask;
    FMinHeight := Value;
    Item.Height := CurHeight;
  end;
end;

procedure TppJvInspectorItemSizing.SetSizable(Value: Boolean);
begin
  if Sizable <> Value then
    FSizable := Value;
end;

procedure TppJvInspectorItemSizing.SetSizingFactor(Value: TItemRowSizing);
var
  CurHeight: Integer;
begin
  CurHeight := Item.Height;
  if SizingFactor <> Value then
  begin
    FSizingFactor := Value;
    if SizingFactor = irsNoReSize then
      FMinHeight := irsItemHeight
    else
      Item.Height := CurHeight;
  end;
end;

constructor TppJvInspectorItemSizing.Create(const AItem: TppJvCustomInspectorItem);
begin
  inherited Create;
  Item := AItem;
end;

procedure TppJvInspectorItemSizing.Assign(Source: TPersistent);
begin
  if Source is TppJvInspectorItemSizing then
  begin
    MinHeight := TppJvInspectorItemSizing(Source).MinHeight;
    SizingFactor := TppJvInspectorItemSizing(Source).SizingFactor;
  end
  else
    inherited Assign(Source);
end;

{ Item sorting functions }

function AlphaSortCompare(Item1, Item2: Pointer): Integer;
begin
  Result := CompareText(TppJvCustomInspectorItem(Item1).DisplayName,
    TppJvCustomInspectorItem(Item2).DisplayName); 
end;

var // maybe a threadvar would be better? OTOH, VCL is not threadsafe anyway so why bother?
  DataSortCompareEvent: TInspectorItemSortCompare;

function DataSortCompare(Item1, Item2: Pointer): Integer;
begin
  if Assigned(DataSortCompareEvent) then
    Result := DataSortCompareEvent(Item1, Item2)
  else
    Result := 0;
end;

function DisplayIndexSortCompare(Item1, Item2: Pointer): Integer;
var
  Idx1: Integer;
  Idx2: Integer;
begin
  Idx1 := TppJvCustomInspectorItem(Item1).DisplayIndex;
  Idx2 := TppJvCustomInspectorItem(Item2).DisplayIndex;
  if (Idx1 <> -1) and (Idx2 <> -1) then
    Result := Idx1 - Idx2
  else
  begin
    if Idx1 = -1 then
      if Idx2 = -1 then
        Result := 0
      else
        Result := 1
    else
      Result := -1;
  end;
end;

//=== TppJvCustomInspectorItem =================================================

procedure TppJvCustomInspectorItem.AlphaSort;
var
  ItemList: TList;
begin
  ItemList := TList.Create;
  try
    BuildDisplayableList(ItemList);
    ItemList.Sort(AlphaSortCompare);
    ApplyDisplayIndices(ItemList);
  finally
    ItemList.Free;
  end;
end;

procedure TppJvCustomInspectorItem.Apply;
var
  TmpOnChange: TNotifyEvent;
begin
  if Editing and (EditCtrl <> nil) and (not Data.IsAssigned or (DisplayValue <> EditCtrl.Text)) then
  begin
    try
      DisplayValue := EditCtrl.Text;
    except
      on E: Exception do
        MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
    InvalidateItem;
    if EditCtrl <> nil then
    begin
      TmpOnChange := TOpenEdit(EditCtrl).OnChange;
      TOpenEdit(EditCtrl).OnChange := nil;
      try
        EditCtrl.Text := DisplayValue;
      finally
        TOpenEdit(EditCtrl).OnChange := TmpOnChange;
      end;
    end;
  end;
  if Editing and (EditCtrl <> nil) then
  begin
    EditCtrl.SelectAll;
    EditCtrl.Modified := False;
    EditCtrl.ClearUndo;
  end;
end;

procedure TppJvCustomInspectorItem.ApplyDisplayIndices(const ItemList: TList);
var
  I: Integer;
begin
  for I := ItemList.Count -1 downto 0 do
    TppJvCustomInspectorItem(ItemList[I]).SetDisplayIndexValue(I);
end;

procedure TppJvCustomInspectorItem.BuildDisplayableList(const ItemList: TList);
var
  TempList: TList;
  I: Integer;
  Item: TppJvCustomInspectorItem;
  {$IFNDEF COMPILER6_UP}
  J: Integer;
  {$ENDIF}
begin
  TempList := TList.Create;
  try
    if ItemList.Capacity < 64 then
      ItemList.Capacity := 64; // Avoid small growth steps
    I := 0;
    while I < Count do
    begin
      Item := Items[I];
      if not Item.Hidden then
        ItemList.Add(Item)
      else
      begin
        Item.BuildDisplayableList(TempList);
        {$IFNDEF COMPILER6_UP}
        for J := 0 to TempList.Count - 1 do
          if ItemList.IndexOf(TempList[J]) = -1 then
            ItemList.Add(TempList[J]);
        {$ELSE}
        ItemList.Assign(TempList, laOr);
        {$ENDIF}
        TempList.Clear;
      end;
      Inc(I);
    end;
  finally
    TempList.Free;
  end;
end;

procedure TppJvCustomInspectorItem.ButtonClick(Sender: TObject);
begin
  Edit;
end;

function TppJvCustomInspectorItem.CanEdit: Boolean;
begin
  Result := not ReadOnly and not Inspector.ReadOnly and Data.IsInitialized and Data.HasValue;
end;

procedure TppJvCustomInspectorItem.CloseUp(Accept: Boolean);
var
  ListValue: string;
begin
  if DroppedDown then
  begin
//dfm    ShowScrollBar(Inspector.Handle, SB_BOTH, False);
    if GetCapture <> 0 then
      SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if ListBox.ItemIndex > -1 then
      ListValue := ListBox.Items[ListBox.ItemIndex];
    TppJvPopupListBox(ListBox).InspectorItem := nil;
    SetWindowPos(ListBox.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FDroppedDown := False;
    InvalidateItem;
    if Accept then
    begin
      EditCtrl.Text := ListValue;
      Apply;
    end;
  end;
end;

procedure TppJvCustomInspectorItem.DataSort;
var
  ItemList: TList;
begin
  ItemList := TList.Create;
  try
    BuildDisplayableList(ItemList);
    DataSortCompareEvent := OnCompare;
    ItemList.Sort(DataSortCompare);
    ApplyDisplayIndices(ItemList);
  finally
    ItemList.Free;
  end;
end;

procedure TppJvCustomInspectorItem.Deactivate;
begin
  if DroppedDown then
    CloseUp(False);
end;

procedure TppJvCustomInspectorItem.DoAfterItemCreate;
begin
  if Inspector <> nil then
    Inspector.DoAfterItemCreate(Self);
end;

function TppJvCustomInspectorItem.DoCompare(const Item: TppJvCustomInspectorItem): Integer;
begin
  if Assigned(FOnCompare) then
    Result := OnCompare(Self, Item)
  else
    Result := 0;
end;

procedure TppJvCustomInspectorItem.DoDrawListItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with (Control as TListBox) do
    Canvas.TextOut(Rect.Left, Rect.Top, Items[Index]);
end;

procedure TppJvCustomInspectorItem.DoDropDownKeys(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
      begin
        if DroppedDown then
          CloseUp(True)
        else
          DropDown;
        Key := 0;
      end;
    VK_RETURN, VK_ESCAPE:
      if DroppedDown and not (ssAlt in Shift) then
      begin
        CloseUp(Key = VK_RETURN);
        Key := 0;
      end;
  end;
end;

procedure TppJvCustomInspectorItem.DoGetValueList(const Strings: TStrings);
begin
  if Assigned(FOnGetValueList) then
    FOnGetValueList(Self, Strings);
end;

procedure TppJvCustomInspectorItem.DoMeasureListItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
end;

procedure TppJvCustomInspectorItem.DoMeasureListItemWidth(Control: TWinControl;
  Index: Integer; var Width: Integer);
begin
end;

procedure TppJvCustomInspectorItem.DoValueChanged;
begin
  if Assigned(FOnValueChanged) then
    FOnValueChanged(Self);
end;

procedure TppJvCustomInspectorItem.DropDown;
const
  MaxListCount = 8;
var
  ListCount: Integer;
  P: TPoint;
  Y: Integer;
  J: Integer;
  I: Integer;
begin
  if not DroppedDown then
  begin
    ListBox.Width := WidthOf(Rects[iprValueArea]);
    TListBox(ListBox).Font := TOpenEdit(EditCtrl).Font;
    if TListBox(ListBox).IntegralHeight then
    begin
      ListBox.Canvas.Font := TListBox(ListBox).Font;
      TListBox(ListBox).ItemHeight := ListBox.Canvas.TextHeight('Wy');
    end;
    ListBox.Items.Clear;
    GetValueList(ListBox.Items);
    if ListBox.Items.Count < MaxListCount then
      ListCount := ListBox.Items.Count
    else
      ListCount := MaxListCount;
    if ListCount = 0 then
      ListCount := 1;
    TListBox(ListBox).Height := ListCount * TListBox(ListBox).ItemHeight + 4;
    ListBox.ItemIndex := ListBox.Items.IndexOf(EditCtrl.Text);
    J := ListBox.ClientWidth;
    if ListBox.Items.Count > ListCount then
      Dec(J, GetSystemMetrics(SM_CXVSCROLL));
    for I := 0 to ListBox.Items.Count - 1 do
    begin
      Y := ListBox.Canvas.TextWidth(ListBox.Items[I]);
      if TListBox(ListBox).Style <> lbStandard then
        DoMeasureListItemWidth(ListBox, I, Y);
      if Y > J then J := Y;
    end;
    if ListBox.Items.Count > ListCount then
      Inc(J, GetSystemMetrics(SM_CXVSCROLL));
    ListBox.ClientWidth := J;
    P := Inspector.ClientToScreen(Point(Rects[iprValueArea].Left, EditCtrl.Top));
    Y := P.Y + HeightOf(Rects[iprValueArea]);
    if Y + ListBox.Height > Screen.Height then
      Y := P.Y - TListBox(ListBox).Height;
    SetWindowPos(ListBox.Handle, HWND_TOP, P.X, Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);

    FDroppedDown := True;
    InvalidateItem;
    Windows.SetFocus(EditCtrl.Handle);
  end;
end;

procedure TppJvCustomInspectorItem.Edit;
begin
end;

procedure TppJvCustomInspectorItem.EditChange(Sender: TObject);
begin
  if AutoUpdate then
  begin
    try
      DisplayValue := EditCtrl.Text;
    except
      on E: Exception do
        MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
    InvalidateItem;
  end;
end;

procedure TppJvCustomInspectorItem.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Sender <> Inspector then
    { OnKeyDown event from the edit control. Pass control to the inspector.
      When the inspector finishes it will pass control to EditKeyDown method
      with the Sender parameter pointing to itself. }
    Inspector.KeyDown(Key, Shift)
  else
  begin
    { OnKeyDown event called from the inspector. Handle item keys }
    if Shift = [] then
    begin
      case Key of
        VK_RETURN:
          Apply;
        VK_ESCAPE:
          Undo;
      end;
      if (Key = VK_RETURN) or (Key = VK_ESCAPE) then
        Key := 0;
    end
    else
    if Shift = [ssCtrl] then
      case Key of
        VK_UP:
          if iifValueList in Flags then
          begin
            SelectValue(-1);
            Key := 0;
          end;
        VK_DOWN:
          if iifValueList in Flags then
          begin
            SelectValue(1);
            Key := 0;
          end;
        VK_RETURN:
          if iifValueList in Flags then
          begin
            SelectValue(1);
            Key := 0;
          end
          else
          if iifEditButton in Flags then
          begin
            Key := 0;
            ButtonClick(Sender);
          end;
      end;
  end;
end;

procedure TppJvCustomInspectorItem.EditMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (ssDouble in Shift) and (iifValueList in Flags) then
    SelectValue(1);
end;

procedure TppJvCustomInspectorItem.EditMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TppJvCustomInspectorItem.EditMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  InspCoord: TPoint;
begin
  InspCoord := Inspector.ScreenToClient(EditCtrl.ClientToScreen(Point(X, Y)));
  Inspector.MouseUp(Button, Shift, InspCoord.X, InspCoord.Y);
end;

procedure TppJvCustomInspectorItem.Edit_WndProc(var Message: TMessage);
var
  ExecInherited: Boolean;
begin
  ExecInherited := True;
  case Message.Msg of
    WM_KEYDOWN, WM_SYSKEYDOWN, WM_CHAR:
      begin
        if iifValueList in Flags then
          with TWMKey(Message) do
          begin
            DoDropDownKeys(CharCode, KeyDataToShiftState(KeyData));
            if (CharCode <> 0) and DroppedDown then
            begin
              with TMessage(Message) do
                SendMessage(ListBox.Handle, Msg, WParam, LParam);
              if not (iifAllowNonListValues in Flags) or
                ((Msg = WM_KEYDOWN) and
                (TWMKeyDown(Message).CharCode in [VK_UP, VK_DOWN])) then
                ExecInherited := False;
            end;
          end;
          if (Message.Msg = WM_KEYDOWN) and (KeyDataToShiftState(Message.LParam) = []) and
            (Message.WParam in [VK_DOWN, VK_UP, VK_NEXT, VK_PRIOR]) then
          begin
            PostMessage(Inspector.Handle, Message.Msg, Message.WParam, Message.LParam);
            Message.Result := 1;
            ExecInherited := False;
          end;
      end;
  end;
  if ExecInherited then
    EditWndPrc(Message);
  case Message.Msg of
    WM_GETDLGCODE:
      begin
        if Inspector.WantTabs then
          Message.Result := Message.Result or DLGC_WANTTAB;
      end;
  end;
end;

function TppJvCustomInspectorItem.GetAutoUpdate: Boolean;
begin
  Result := (iifAutoUpdate in Flags);
end;

function TppJvCustomInspectorItem.GetBaseCategory: TppJvInspectorCustomCategoryItem;
begin
  if (Self is TppJvInspectorCustomCategoryItem) and (Level = 0) then
    Result := Self as TppJvInspectorCustomCategoryItem
  else
  begin
    Result := Category;
    while (Result <> nil) and (Result.Level > 0) do
      Result := Result.Category;
  end;
end;

function TppJvCustomInspectorItem.GetCategory: TppJvInspectorCustomCategoryItem;
var
  ParItem: TppJvCustomInspectorItem;
begin
  ParItem := Parent;
  while (ParItem <> nil) and not (ParItem is TppJvInspectorCustomCategoryItem) do
    ParItem := ParItem.Parent;
  if ParItem is TppJvInspectorCustomCategoryItem then
    Result := ParItem as TppJvInspectorCustomCategoryItem
  else
    Result := nil;
end;

function TppJvCustomInspectorItem.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TppJvCustomInspectorItem.GetData: TppJvCustomInspectorData;
begin
  Result := FData;
end;

function TppJvCustomInspectorItem.GetDisplayIndex: Integer;
begin
  Result := FDisplayIndex;
end;

function TppJvCustomInspectorItem.GetDisplayName: string;
begin
  Result := FDisplayName;
  if (Parent <> nil) and (iifQualifiedNames in Parent.Flags) then
    Result := Parent.DisplayName + '.' + Result;
end;

function TppJvCustomInspectorItem.GetDisplayParent: TppJvCustomInspectorItem;
begin
  Result := Parent;
  while (Result <> nil) and Result.Hidden do
    Result := Result.Parent;
  if Result = nil then
    Result := Inspector.Root;
end;

function TppJvCustomInspectorItem.GetDisplayValue: string;
begin
  Result := '';
end;

function TppJvCustomInspectorItem.GetDroppedDown: Boolean;
begin
  Result := FDroppedDown;
end;

function TppJvCustomInspectorItem.GetEditCtrl: TCustomEdit;
begin
  Result := FEditCtrl;
end;

function TppJvCustomInspectorItem.GetEditing: Boolean;
begin
  Result := FEditing;
end;

function TppJvCustomInspectorItem.GetExpanded: Boolean;
begin
  Result := iifExpanded in Flags;
end;

function TppJvCustomInspectorItem.GetFlags: TInspectorItemFlags;
begin
  Result := FFlags;
end;

function TppJvCustomInspectorItem.GetHeight: Integer;
begin
  if RowSizing.SizingFactor = irsNoReSize then
    Result := Inspector.ItemHeight
  else
  begin
    case RowSizing.MinHeight of
      irsNameHeight:
        Result := Inspector.Painter.GetNameHeight(Self);
      irsValueHeight:
        Result := Inspector.Painter.GetValueHeight(Self);
      irsItemHeight:
        Result := Inspector.ItemHeight;
    else
      Result := RowSizing.MinHeight;
    end;
    case RowSizing.SizingFactor of
      irsNameHeight:
        Result := Result + HeightFactor * Inspector.Painter.GetNameHeight(Self);
      irsValueHeight:
        Result := Result + HeightFactor * Inspector.Painter.GetValueHeight(Self);
      irsItemHeight:
        Result := Result + HeightFactor * Inspector.ItemHeight;
    else
      Result := Result + HeightFactor * RowSizing.SizingFactor;
    end;
  end;
end;

function TppJvCustomInspectorItem.GetHeightFactor: Integer;
begin
  Result := FHeight;
end;

function TppJvCustomInspectorItem.GetHidden: Boolean;
begin
  Result := iifHidden in Flags;
end;

function TppJvCustomInspectorItem.GetInspector: TppJvCustomInspector;
begin
  Result := FInspector;
end;

function TppJvCustomInspectorItem.GetInspectorPaintGeneration: Integer;
begin
  Result := Inspector.PaintGeneration;
end;

function TppJvCustomInspectorItem.GetIsCompoundColumn: Boolean;
begin
  Result := (Parent <> nil) and (Parent is TppJvInspectorCustomCompoundItem) and (Parent.IndexOf(Self) < 0);
end;

function TppJvCustomInspectorItem.GetItems(const I: Integer): TppJvCustomInspectorItem;
begin
  Result := TppJvCustomInspectorItem(FItems[I]);
end;

function TppJvCustomInspectorItem.GetLevel: Integer;
var
  Item: TppJvCustomInspectorItem;
begin
  Item := Self;
  Result := -1;
  while Item <> nil do
  begin
    if not (iifHidden in Item.Flags) then
      Inc(Result);
    Item := Item.Parent;
  end;
end;

function TppJvCustomInspectorItem.GetListBox: TCustomListBox;
begin
  Result := FListBox;
end;

function TppJvCustomInspectorItem.GetMultiline: Boolean;
begin
  Result := (iifMultiline in Flags);
end;

function TppJvCustomInspectorItem.GetNextSibling: TppJvCustomInspectorItem;
var
  I: Integer;
begin
  Result := Parent;
  if Result <> nil then
  begin
    I := Succ(Result.IndexOf(Self));
    if (I = 0) or (I >= Result.Count) then
      Result := nil
    else
      Result := Result.Items[I];
  end;
end;

function TppJvCustomInspectorItem.GetParent: TppJvCustomInspectorItem;
begin
  Result := FParent;
end;

function TppJvCustomInspectorItem.GetQualifiedNames: Boolean;
begin
  Result := (iifQualifiedNames in Flags);
end;

function TppJvCustomInspectorItem.GetReadOnly: Boolean;
begin
  Result := (iifReadonly in Flags);
end;

function TppJvCustomInspectorItem.GetRects(const RectKind: TInspectorPaintRect): TRect;
begin
  if LastPaintGeneration = GetInspectorPaintGeneration then
    Result := FRects[RectKind]
  else
    Result := Rect(0, 0, 0, 0);
end;

function TppJvCustomInspectorItem.GetRowSizing: TppJvInspectorItemSizing;
begin
  Result := FRowSizing;
end;

function TppJvCustomInspectorItem.GetSortKind: TInspectorItemSortKind;
begin
  Result := FSortKind;
end;

function TppJvCustomInspectorItem.GetSortName: string;
var
  DisplayParent: TppJvCustomInspectorItem;
begin
  Result := Format('%.7d', [DisplayIndex]);
  DisplayParent := GetDisplayParent;
  if (DisplayParent <> nil) and (DisplayParent <> Inspector.Root) then
    Result := DisplayParent.GetSortName + #31 + Result;
end;

procedure TppJvCustomInspectorItem.GetValueList(const Strings: TStrings);
begin
  DoGetValueList(Strings);
end;

function TppJvCustomInspectorItem.GetVisible: Boolean;
begin
  Result := iifVisible in Flags;
end;

procedure TppJvCustomInspectorItem.InvalidateItem;
begin
  if Inspector <> nil then
    Inspector.InvalidateItem;
end;

procedure TppJvCustomInspectorItem.InvalidateList;
begin
  if Inspector <> nil then
    Inspector.InvalidateList;
end;

procedure TppJvCustomInspectorItem.InvalidateSort;
begin
  if Inspector.LockCount > 0 then
    Inspector.NotifySort(Self)
  else
  begin
    if SortKind in [iskNone, iskName, iskCustom] then
      Sort;
    if Inspector.LockCount = 0 then // LockCount will be -1 if called from EndUpdate
      InvalidateList;
  end;
end;

procedure TppJvCustomInspectorItem.InvalidateMetaData;
begin
  InvalidateItem;
end;

procedure TppJvCustomInspectorItem.InvalidateValue;
begin
  DoValueChanged;
  { Removed: InvalidateValue will be called from the data instance which will already notify
    each inspector involved once.
  if Inspector <> nil then
    Inspector.DoItemValueChanged(Self); }
end;

procedure TppJvCustomInspectorItem.ListExit(Sender: TObject);
begin
  if DroppedDown then
    CloseUp(False);
end;

procedure TppJvCustomInspectorItem.ListMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(ListBox.ClientRect, Point(X, Y)));
end;

procedure TppJvCustomInspectorItem.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and PtInRect(Rects[iprEditButton], Point(X,Y)) then
  begin
    if DroppedDown then
      CloseUp(False)
    else
    begin
      Inspector.MouseCapture := True;
      Tracking := True;
      TrackButton(X, Y);
      if (iifValueList in Flags) then
        DropDown;
    end;
  end
  else
  if (Button = mbLeft) and (ssDouble in Shift) and
    (iifValueList in Flags) and
    (PtInRect(Rects[iprValueArea], Point(X, Y))) then
    SelectValue(1);
end;

procedure TppJvCustomInspectorItem.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  if Tracking then
  begin
    TrackButton(X, Y);
    if DroppedDown then
    begin
      ListPos := ListBox.ScreenToClient(Inspector.ClientToScreen(Point(X, Y)));
      if PtInRect(ListBox.ClientRect, ListPos) then
      begin
        StopTracking;
        MousePos := PointToSmallPoint(ListPos);
        SendMessage(ListBox.Handle, WM_LBUTTONDOWN, 0, Integer(MousePos));
        Exit;
      end;
    end;
  end;
end;

procedure TppJvCustomInspectorItem.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  WasPressed: Boolean;
begin
  WasPressed := FPressed;
  StopTracking;
  if (Button = mbLeft) and WasPressed and (iifEditButton in Flags) then
    ButtonClick(Self);
end;

procedure TppJvCustomInspectorItem.NaturalSort;
var
  ItemList: TList;
begin
  ItemList := TList.Create;
  try
    BuildDisplayableList(ItemList);
    ApplyDisplayIndices(ItemList);
  finally
    ItemList.Free;
  end;
end;

procedure TppJvCustomInspectorItem.SelectValue(const Delta: Integer);
var
  SL: TStrings;
  I: Integer;
begin
  SL := TStringList.Create;
  try
    GetValueList(SL);
    if SL.Count>0 then
    begin
      I := SL.IndexOf(DisplayValue);
      Inc(I, Delta);
      while I < 0 do
        I := I + SL.Count;
      while I >= SL.Count do
        I := I - SL.Count;
      EditCtrl.Text := SL[I];
      Apply;
    end;
  finally
    SL.Free;
  end;
end;

procedure TppJvCustomInspectorItem.SetAutoUpdate(const Value: Boolean);
begin
  if Value <> AutoUpdate then
  begin
    if Value then
      Flags := Flags + [iifAutoUpdate]
    else
      Flags := Flags - [iifAutoUpdate];
  end;
end;

procedure TppJvCustomInspectorItem.SetDisplayIndex(const Value: Integer);
var
  DisplayParent: TppJvCustomInspectorItem;
begin
  if Value <> DisplayIndex then
  begin
    DisplayParent := GetDisplayParent;
    if DisplayParent <> nil then
      DisplayParent.UpdateDisplayOrder(Self, Value);
  end;
  SortKind := iskManual;
end;

procedure TppJvCustomInspectorItem.SetDisplayIndexValue(const Value: Integer);
begin
  FDisplayIndex := Value;
end;

procedure TppJvCustomInspectorItem.SetDisplayName(Value: string);
var
  S: string;
begin
  if (Parent <> nil) and (iifQualifiedNames in Parent.Flags) then
    S := Parent.DisplayName + '.';
  if S <> Copy(Value, 1, Length(S)) then
    System.Delete(Value, 1, Length(S));
  if Value <> FDisplayName then
  begin
    FDisplayName := Value;
    InvalidateItem;
  end;
end;

procedure TppJvCustomInspectorItem.SetDisplayValue(const Value: string);
begin
end;

procedure TppJvCustomInspectorItem.SetEditCtrl(const Value: TCustomEdit);
begin
  if EditCtrl <> Value then
  begin
    if EditCtrl <> nil then
    begin
      EditCtrl.WindowProc := Edit_WndProc;
      EditCtrl.Free;
    end;
    FEditCtrl := Value;
    if EditCtrl <> nil then
      with TOpenEdit(EditCtrl) do
      begin
        Ctl3D := False;
        BorderStyle := bsNone;
        Parent := TWinControl(Owner);
      end;
  end;
end;

procedure TppJvCustomInspectorItem.SetEditing(const Value: Boolean);
begin
  FEditing := Value;
end;

procedure TppJvCustomInspectorItem.SetExpanded(Value: Boolean);
begin
  if Value <> Expanded then
  begin
    if Value then
      Flags := Flags + [iifExpanded]
    else
      Flags := Flags - [iifExpanded];
  end;
end;

procedure TppJvCustomInspectorItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewFlags: TInspectorItemFlags;
  OldFlags: TInspectorItemFlags;
begin
  NewFlags := Value;
  if (iifOwnerDrawListFixed in NewFlags) and (iifOwnerDrawListVariable in NewFlags) then
    Exclude(NewFlags, iifOwnerDrawListFixed);
  if (iifAllowNonListValues in NewFlags) or (iifOwnerDrawListFixed in NewFlags) or
      (iifOwnerDrawListVariable in NewFlags) then
    Include(NewFlags, iifValueList);
  if Flags <> NewFlags then
  begin
    OldFlags := Flags;
    FFlags := NewFlags;
    OldFlags := OldFlags * [iifExpanded, iifHidden, iifVisible];
    NewFlags := NewFlags * [iifExpanded, iifHidden, iifVisible];
    if NewFlags <> OldFlags then
      InvalidateList
    else
      InvalidateItem;
  end;
end;

procedure TppJvCustomInspectorItem.SetFocus;
begin
  if (EditCtrl <> nil) and EditCtrl.CanFocus then
    EditCtrl.SetFocus
  else
    Inspector.SetFocus;
end;

procedure TppJvCustomInspectorItem.SetHeight(Value: Integer);
var
  Factor: Integer;
begin
  case RowSizing.MinHeight of
    irsNameHeight:
      Dec(Value, Inspector.Painter.GetNameHeight(Self));
    irsValueHeight:
      Dec(Value, Inspector.Painter.GetValueHeight(Self));
    irsItemHeight:
      Dec(Value, Inspector.ItemHeight);
  else
    Dec(Value, RowSizing.MinHeight);
  end;
  if Value < 0 then
    Value := 0;
  case RowSizing.SizingFactor of
    irsNoReSize:
      Factor := 0;
    irsNameHeight:
      Factor := Value div Inspector.Painter.GetNameHeight(Self);
    irsValueHeight:
      Factor := Value div Inspector.Painter.GetValueHeight(Self);
    irsItemHeight:
      Factor := Value div Inspector.ItemHeight;
  else
    Factor := Value div RowSizing.SizingFactor;
  end;

  if Factor <> HeightFactor then
  begin
    HeightFactor := Factor;
    InvalidateItem;
    Inspector.CalcImageHeight;
  end;
end;

procedure TppJvCustomInspectorItem.SetHeightFactor(Value: Integer);
begin
  FHeight := Value;
  Inspector.InvalidateHeight;
  InvalidateItem;
end;

procedure TppJvCustomInspectorItem.SetHidden(Value: Boolean);
begin
  if Value <> Hidden then
  begin
    if Value then
      Flags := Flags + [iifHidden]
    else
      Flags := Flags - [iifHidden];
  end;
end;

procedure TppJvCustomInspectorItem.SetInspector(const AInspector: TppJvCustomInspector);
begin
  if Parent = nil then
    FInspector := AInspector;
end;

procedure TppJvCustomInspectorItem.SetMultiline(const Value: Boolean);
begin
  if Value <> Multiline then
  begin
    if Value then
      Flags := Flags + [iifMultiline]
    else
      Flags := Flags - [iifMultiline];
  end;
end;

procedure TppJvCustomInspectorItem.SetOnCompare(const Value: TInspectorItemSortCompare);
begin
  if @Value <> @OnCompare then
  begin
    FOnCompare := Value;
    if @Value = nil then
      SortKind := iskNone;
    InvalidateSort;
  end;
end;

procedure TppJvCustomInspectorItem.SetParent(const Value: TppJvCustomInspectorItem);
begin
  if Parent <> Value then
    if Parent = nil then
      FParent := Value
    else
      raise EppJvInspectorItem.Create(sppJvInspItemHasParent);
end;

procedure TppJvCustomInspectorItem.SetQualifiedNames(const Value: Boolean);
begin
  if Value <> QualifiedNames then
    if Value then
      Flags := Flags + [iifQualifiedNames]
    else
      Flags := Flags - [iifQualifiedNames];
end;

procedure TppJvCustomInspectorItem.SetReadOnly(const Value: Boolean);
begin
  if Value <> ReadOnly then
    if Value then
      Flags := Flags + [iifReadonly]
    else
      Flags := Flags - [iifReadonly];
end;

procedure TppJvCustomInspectorItem.SetRects(const RectKind: TInspectorPaintRect;
  Value: TRect);
begin
  UpdateLastPaintGeneration;
  if not EqualRect(Rects[RectKind], Value) then
  begin
    FRects[RectKind] := Value;
    if (RectKind = iprEditValue) and (EditCtrl <> nil) then
    begin
      EditCtrl.BoundsRect := Rects[iprEditValue];
      if DroppedDown then
        CloseUp(False);
    end;
  end;
end;

procedure TppJvCustomInspectorItem.SetRowSizing(Value: TppJvInspectorItemSizing);
begin
  if (Value <> nil) and (Value <> RowSizing) then
    RowSizing.Assign(Value);
end;

procedure TppJvCustomInspectorItem.SetSortKind(Value: TInspectorItemSortKind);
begin
  if (Value = iskCustom) and (@OnCompare = nil) then
    Value := iskNone;
  if Value <> SortKind then
  begin
    FSortKind := Value;
    InvalidateSort;
  end;
end;

procedure TppJvCustomInspectorItem.SetVisible(Value: Boolean);
begin
  if Value <> Visible then
    if Value then
      Flags := Flags + [iifVisible]
    else
      Flags := Flags - [iifVisible];
end;

procedure TppJvCustomInspectorItem.StopTracking;
begin
  if Tracking then
  begin
    TrackButton(-1, -1);
    Tracking := False;
    Inspector.MouseCapture := False;
  end;
end;

procedure TppJvCustomInspectorItem.TrackButton(X, Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
  R := Rects[iprEditButton];
  NewState := PtInRect(R, Point(X, Y));
  if Pressed <> NewState then
  begin
    Pressed := NewState;
    InvalidateRect(Inspector.Handle, @R, False);
  end;
end;

procedure TppJvCustomInspectorItem.Undo;
begin
  if Editing then
  begin
    EditCtrl.Undo;
    EditCtrl.SelectAll;
  end;
end;

procedure TppJvCustomInspectorItem.UpdateDisplayOrder(const Item: TppJvCustomInspectorItem;
  const NewIndex: Integer);
var
  L: TList;
begin
  L := TList.Create;
  try
    BuildDisplayableList(L);
    L.Sort(DisplayIndexSortCompare);
    L.Remove(Item);
    L.Insert(NewIndex, Item);
    ApplyDisplayIndices(L);
  finally
    L.Free;
  end;
end;

procedure TppJvCustomInspectorItem.UpdateLastPaintGeneration;
begin
  FLastPaintGen := GetInspectorPaintGeneration;
end;

constructor TppJvCustomInspectorItem.Create(const AParent: TppJvCustomInspectorItem;
  const AData: TppJvCustomInspectorData);
begin
  inherited Create;
  FData := nil;
  FItems := TObjectList.Create(True);
  Flags := [iifVisible];
  FRowSizing := TppJvInspectorItemSizing.Create(Self);
  FSortKind := iskName;
  FDisplayIndex := -1;
  if AData <> nil then
    FDisplayName := AData.Name;
  if AParent <> nil then
  begin
    FInspector := AParent.Inspector;
    AParent.Add(Self)
  end;
  FData := AData;
end;

destructor TppJvCustomInspectorItem.Destroy;
begin
  inherited Destroy;
end;

function TppJvCustomInspectorItem.Add(const Item: TppJvCustomInspectorItem): Integer;
begin
  Result := Count;
  Insert(Result, Item);
end;

procedure TppJvCustomInspectorItem.AfterConstruction;
begin
  inherited AfterConstruction;
  InvalidateMetaData;
  DoAfterItemCreate;
end;

procedure TppJvCustomInspectorItem.BeforeDestruction;
begin
  inherited BeforeDestruction;
  if Parent <> nil then
    Parent.FItems.Extract(Self); // DFM - added 1/16/2005
  if (Inspector <> nil) and (Inspector.Root <> Self) then
    DoneEdit(True);
  if Inspector <> nil then
  begin
    Inspector.RemoveNotifySort(Self);
    if Inspector.RowSizingItem = Self then
    begin
      Inspector.RowSizing := False;
      Inspector.RowSizingItem := nil;
    end;
  end;
  FItems.Free;
  if Data <> nil then
  begin
    FData.RemoveItem(Self);
  end;
  FRowSizing.Free;
end;

procedure TppJvCustomInspectorItem.Clear;
begin
  Inspector.BeginUpdate;
  try
    while Count > 0 do
      Delete(Count - 1);
  finally
    Inspector.EndUpdate;
  end;
end;

procedure TppJvCustomInspectorItem.Delete(const Index: Integer);
var
  Disp: TppJvCustomInspectorItem;
begin
  Disp := Items[Index].GetDisplayParent;
  if Inspector.Selected = Items[Index] then
  begin
    Inspector.SetSelected(Disp);
    if Inspector.Selected = Items[Index] then
      Inspector.SelectedIndex := -1;
  end;
  FItems.Delete(Index);
  if Disp <> nil then
    Disp.InvalidateSort
  else
    InvalidateSort;
end;

procedure TppJvCustomInspectorItem.Delete(const Item: TppJvCustomInspectorItem);
var
  Idx: Integer;
begin
  Idx := IndexOf(Item);
  if Idx > -1 then
    Delete(Idx);
end;

procedure TppJvCustomInspectorItem.Delete(const Data: TppJvCustomInspectorData);
var
  Idx: Integer;
begin
  Idx := IndexOf(Data);
  if Idx > -1 then
    Delete(Idx);
end;

procedure TppJvCustomInspectorItem.DrawEditor(const ACanvas: TCanvas);
const
  LeftOffs = 3;
var
  R: TRect;
  BFlags: Integer;
  W, G, I: Integer;
begin
  // This reduces the flickering when dragging the divider bar
  if EditCtrl <> nil then
  begin
    ACanvas.Lock;
    try
      EditCtrl.PaintTo(ACanvas.Handle, EditCtrl.Left, EditCtrl.Top);
    finally
      ACanvas.Unlock;
    end;
  end;
  R := Rects[iprEditButton];
  if not IsRectEmpty(R) then
  begin
    BFlags := 0;
    if iifValueList in Flags then
    begin
      if not EditCtrl.Enabled then
        BFlags := DFCS_INACTIVE
      else
      if Pressed then
        BFlags := DFCS_FLAT or DFCS_PUSHED;
      DrawFrameControl(ACanvas.Handle, R, DFC_SCROLL, BFlags or DFCS_SCROLLCOMBOBOX);
    end
    else
    if iifEditButton in Flags then
    begin
      if Pressed then
        BFlags := BF_FLAT;
      DrawEdge(ACanvas.Handle, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or BFlags);
      W := 2;
      G := (WidthOf(R) - 2 * Ord(Pressed) - (3 * W)) div 4;
      if G < 1 then
      begin
        W := 1;
        G := (WidthOf(R) - 2 * Ord(Pressed) - (3 * W)) div 4;
      end;
      if G < 1 then
        G := 1;
      if G > 3 then
        G := 3;

      BFlags := R.Left + (WidthOf(R) - 3 * W -2 * G) div 2 + Ord(Pressed);
      I := R.Top + (HeightOf(R) - W) div 2;
      PatBlt(ACanvas.handle, BFlags, I, W, W, BLACKNESS);
      PatBlt(ACanvas.handle, BFlags + G + W, I, W, W, BLACKNESS);
      PatBlt(ACanvas.handle, BFlags + 2 * G + 2 * W, I, W, W, BLACKNESS);
    end;
  end;
end;

procedure TppJvCustomInspectorItem.DrawName(const ACanvas: TCanvas);
var
  ARect: TRect;
begin
  ARect := Rects[iprName];
  ACanvas.TextRect(ARect, ARect.Left, ARect.Top, DisplayName);
end;

procedure TppJvCustomInspectorItem.DrawValue(const ACanvas: TCanvas);
var
  S: string;
  ARect: TRect;
  SafeColor: TColor;
begin
  if Data = nil then
    S := sppJvInspItemUnInitialized
  else
  try
    if not Data.IsInitialized then
      S := sppJvInspItemUnInitialized
    else
    if not Data.HasValue then
      S := sppJvInspItemNoValue
    else
    if not Data.IsAssigned then
      S := sppJvInspItemUnassigned
    else
      S := DisplayValue;
  except
    S := sppJvInspItemValueException + ExceptObject.ClassName + ': ' +
      Exception(ExceptObject).Message;
  end;
  ARect := Rects[iprValue];
  SafeColor := ACanvas.Brush.Color;
  if Editing then
    ACanvas.Brush.Color := clWindow;
  try
    if not Editing then
    begin
      if not (iifMultiLine in Flags) then
        ACanvas.TextRect(ARect, ARect.Left, ARect.Top, S)
      else
        DrawTextEx(ACanvas.Handle, PChar(S), Length(S), ARect, DT_EDITCONTROL or
          DT_WORDBREAK, nil)
    end
    else
    begin
      ARect := Rects[iprValueArea];
      Inc(ARect.Top);
      ACanvas.FillRect(ARect);
      DrawEditor(ACanvas);
    end;
  finally
    if Editing then
      ACanvas.Brush.Color := SafeColor;
  end;
end;

function TppJvCustomInspectorItem.EditFocused: Boolean;
begin
  Result := (EditCtrl <> nil) and EditCtrl.Focused;
end;

function TppJvCustomInspectorItem.HasViewableItems: Boolean;
var
  I: Integer;

begin
  Result := False;
  I := 0;
  while (I < Count) and not Result do
  begin
    Result := (iifVisible in Items[I].Flags) and (not (iifHidden in Items[I].Flags) or
      ((iifExpanded in Items[I].Flags) and Items[I].HasViewableItems));
    Inc(I);
  end;
end;

function TppJvCustomInspectorItem.IndexOf(const Item: TppJvCustomInspectorItem): Integer;
begin
  Result := Pred(Count);
  while (Result > -1) and (Items[Result] <> Item) do
    Dec(Result);
end;

function TppJvCustomInspectorItem.IndexOf(const Data: TppJvCustomInspectorData): Integer;
begin
  Result := Pred(Count);
  while (Result > -1) and (Items[Result].Data <> Data) do
    Dec(Result);
end;

procedure TppJvCustomInspectorItem.InitEdit;
begin
  SetEditing(CanEdit);
  if Editing then
  begin
    if Multiline then
    begin
      SetEditCtrl(TMemo.Create(Inspector));
      TMemo(EditCtrl).WordWrap := True;
      TMemo(EditCtrl).WantReturns := False;
      TMemo(EditCtrl).ScrollBars := ssVertical;
    end
    else
      SetEditCtrl(TEdit.Create(Inspector));
    if iifEditFixed in Flags then
    begin
      TOpenEdit(EditCtrl).ReadOnly := True;
      TOpenEdit(EditCtrl).TabStop := False;
      TOpenEdit(EditCtrl).Color := Inspector.Canvas.Brush.Color;
    end
    else
    begin
      TOpenEdit(EditCtrl).Color := clWindow;
    end;
    FEditWndPrc := EditCtrl.WindowProc;
    EditCtrl.WindowProc := Edit_WndProc;
    TOpenEdit(EditCtrl).AutoSize := False;
    if iifValueList in Flags then
    begin
      FListBox := TppJvPopupListBox.Create(Inspector);
      ListBox.Visible := False;
      ListBox.Parent := EditCtrl;
      TppJvPopupListBox(ListBox).InspectorItem := Self;
     TListBox(ListBox).OnMouseUp := ListMouseUp;
      TListBox(ListBox).IntegralHeight := not (iifOwnerDrawListVariable in
        Flags);
      TListBox(ListBox).ItemHeight := 11;
      if iifOwnerDrawListFixed in Flags then
        TListBox(ListBox).Style := lbOwnerDrawFixed
      else
      if iifOwnerDrawListVariable in Flags then
        TListBox(ListBox).Style := lbOwnerDrawVariable;
      TListBox(ListBox).OnDrawItem := DoDrawListItem;
      TListBox(ListBox).OnMeasureItem := DoMeasureListItem;
      TListBox(ListBox).OnExit := ListExit;
    end;
    TOpenEdit(EditCtrl).Font.Assign(Inspector.Font);
    EditCtrl.BoundsRect := Rects[iprEditValue];
    TOpenEdit(EditCtrl).OnKeyDown := EditKeyDown;
    TOpenEdit(EditCtrl).OnMouseDown := EditMouseDown;
    TOpenEdit(EditCtrl).OnMouseMove := EditMouseMove;
    TOpenEdit(EditCtrl).OnMouseUp := EditMouseUp;
    TOpenEdit(EditCtrl).OnChange := EditChange;
    EditCtrl.Visible := True;
    if Data.IsAssigned then
      EditCtrl.Text := DisplayValue
    else
      EditCtrl.Text := '';
    EditCtrl.Modified := False;
    EditCtrl.SelectAll;
    if EditCtrl.CanFocus and Inspector.Focused then
      EditCtrl.SetFocus;
  end;
end;

procedure TppJvCustomInspectorItem.DoneEdit(const CancelEdits: Boolean);
var
  HadFocus: Boolean;
begin
  if Editing then
  begin
    HadFocus := EditFocused;
    if DroppedDown then
      CloseUp(False);
    if not CancelEdits and EditCtrl.Modified and (not Data.IsAssigned or (DisplayValue <> EditCtrl.Text)) then
      try
        DisplayValue := EditCtrl.Text;
      except
        on E: Exception do
          MessageDlg(E.Message, mtError, [mbOK], 0);
      end;
    FreeAndNil(FListBox);
    SetEditCtrl(nil);
    if HadFocus then
      SetFocus;
  end;
  FEditing := False;
end;

procedure TppJvCustomInspectorItem.Insert(const Index: Integer; const Item: TppJvCustomInspectorItem);
var
  Disp: TppJvCustomInspectorItem;
begin
  Item.SetParent(Self);
  FItems.Insert(Index, Item);
  Disp := Item.GetDisplayParent;
  if Disp <> nil then
    Disp.InvalidateSort
  else
    InvalidateSort;
end;

procedure TppJvCustomInspectorItem.ScrollInView;
var
  ViewIdx: Integer;
  Item: TppJvCustomInspectorItem;
  YDelta: Integer;
  BandIdx: Integer;
  FirstBand: Integer;
  BandsVisible: Integer;
begin
  ViewIdx := Inspector.VisibleIndex(Self);
  if ViewIdx < 0 then
  begin
    { Find visible parent }
    Item := Parent;
    while (Item <> nil) and (ViewIdx < 0) do
    begin
      ViewIdx := Inspector.VisibleIndex(Item);
      if ViewIdx < 0 then
        Item := Item.Parent;
    end;
  end;
  if ViewIdx > -1 then
  begin
    if not Inspector.UseBands then
    begin
      if Inspector.TopIndex > ViewIdx then
        Inspector.TopIndex := ViewIdx
      else
      if (Inspector.IdxToY(ViewIdx) - Inspector.IdxToY(Inspector.TopIndex) +
        Height) > Inspector.ClientHeight then
      begin
        YDelta := (Inspector.IdxToY(ViewIdx) + Height - Inspector.ClientHeight -
          Inspector.IdxToY(Inspector.TopIndex));
        ViewIdx := Inspector.TopIndex;
        while (YDelta > 0) and (ViewIdx < Inspector.VisibleCount) do
        begin
          Dec(YDelta, Inspector.VisibleItems[ViewIdx].Height);
          Inc(ViewIdx);
        end;
        if ViewIdx < Inspector.VisibleCount then
          Inspector.TopIndex := ViewIdx;
      end;
    end
    else
    begin
      // Find band and scroll that band into the view
      BandIdx := Inspector.GetBandFor(ViewIdx);
      FirstBand := Inspector.GetBandFor(Inspector.TopIndex);
      BandsVisible := Inspector.ClientWidth div Inspector.BandWidth;
      if (BandIdx < FirstBand) or (BandIdx >= (FirstBand + BandsVisible)) then
      begin
        if BandIdx < FirstBand then
          Inspector.TopIndex := Integer(Inspector.BandStarts[BandIdx])
        else
        begin
          FirstBand := BandIdx - BandsVisible + 1;
          if (FirstBand > -1) and (FirstBand < Inspector.BandStarts.Count) then
            Inspector.TopIndex := Integer(Inspector.BandStarts[FirstBand]);
        end;
      end;
    end;
  end;
end;

procedure TppJvCustomInspectorItem.Sort;
begin
  case SortKind of
    iskNone:
      NaturalSort;
    iskName:
      AlphaSort;
    iskCustom:
      DataSort;
  end;
end;

//=== TppJvInspectorCustomCategoryItem =========================================

procedure TppJvInspectorCustomCategoryItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewFlags: TInspectorItemFlags;
begin
  NewFlags := Value - [iifAutoUpdate, iifMultiLine, iifValueList,
    iifAllowNonListValues, iifOwnerDrawListFixed, iifOwnerDrawListVariable,
    iifEditButton] + [iifReadonly, iifEditFixed];
  inherited SetFlags(NewFlags);
end;

//=== TppJvInspectorCompoundColumn =============================================

constructor TppJvInspectorCompoundColumn.Create(const AParent: TppJvInspectorCustomCompoundItem;
  const AItem: TppJvCustomInspectorItem);
begin
  inherited Create;
  FParent := AParent;
  Item := AItem;
end;

destructor TppJvInspectorCompoundColumn.Destroy;
begin
  inherited Destroy;
end;

function TppJvInspectorCompoundColumn.GetItem: TppJvCustomInspectorItem;
begin
  Result := FItem;
end;

function TppJvInspectorCompoundColumn.GetWidth: Integer;
begin
  Result := FWidth;
end;

function TppJvInspectorCompoundColumn.GetWidthSet: Integer;
begin
  Result := FWidthSet;
end;

procedure TppJvInspectorCompoundColumn.SetItem(Value: TppJvCustomInspectorItem);
begin
  if Item <> Value then
  begin
    if (Value <> nil) and (Value.Parent <> Parent) then
      raise EppJvInspectorItem.Create(sppJvInspItemNotAChild);
    if Item <> nil then
      Parent.Add(Item);
    FItem := Value;
    if Item <> nil then
      Parent.FItems.Extract(Item);
    FWidthSet := 0;
    FWidth := -1;
    Parent.InvalidateList;
  end;
end;

procedure TppJvInspectorCompoundColumn.SetWidth(Value: Integer);
begin
  if Value <> Width then
    FWidth := Value;
end;

procedure TppJvInspectorCompoundColumn.SetWidthExternal(Value: Integer);
begin
  if Value <> WidthSet then
  begin
    SetWidthSet(Value);
    TppJvInspectorCustomCompoundItem(Item.Parent).RecalcColumnWidths(Self);
  end;
end;

procedure TppJvInspectorCompoundColumn.SetWidthSet(Value: Integer);
begin
  if Value <> WidthSet then
  begin
    FWidthSet := Value;
    FWidth := -1;
  end;
end;

procedure TppJvInspectorCompoundColumn.BeforeDestruction;
begin
  Item := nil;
  inherited BeforeDestruction;
end;

//=== TppJvInspectorCustomCompoundItem =========================================

function TppJvInspectorCustomCompoundItem.AddColumnPrim(const Item: TppJvCustomInspectorItem): Integer;
begin
  Result := ColumnCount;
  InsertColumnPrim(Result, Item);
end;

function TppJvInspectorCustomCompoundItem.AddColumnPrim(const ItemIndex: Integer): Integer;
begin
  Result := ColumnCount;
  InsertColumnPrim(Result, Items[ItemIndex]);
end;

procedure TppJvInspectorCustomCompoundItem.DeleteColumnPrim(const Column: TppJvInspectorCompoundColumn);
var
  Idx: Integer;
begin
  Idx := IndexOfColumnPrim(Column);
  if Idx > -1 then
    DeleteColumnPrim(Idx)
  else
    raise EppJvInspectorItem.Create(sppJvInspItemColNotFound);
end;

procedure TppJvInspectorCustomCompoundItem.DeleteColumnPrim(const Index: Integer);
begin
  FColumns.Delete(Index);
  if SelectedColumnIndex > ColumnCount then
    SelectedColumnIndex := ColumnCount - 1;
end;

procedure TppJvInspectorCustomCompoundItem.DeleteColumnPrim(const Item: TppJvCustomInspectorItem);
var
  Idx: Integer;
begin
  Idx := IndexOfColumnPrim(Item);
  if Idx > -1 then
    DeleteColumnPrim(Idx)
  else
    raise EppJvInspectorItem.Create(sppJvInspItemItemIsNotCol);
end;

procedure TppJvInspectorCustomCompoundItem.DivideRect(const RectKind: TInspectorPaintRect; const Value: TRect);
var
  VisibleColCount: Integer;
  I: Integer;
  WidthAvail: Integer;
  CurRect: TRect;
  WidthUsedInt: Integer;
  WidthUsedDbl: Double;
  ColWidth: Double;
  SaveItem: TppJvCustomInspectorItem;
begin
  if Inspector.Painter = nil then
    raise EppJvInspectorItem.Create(sppJvAssertInspectorPainter);
  VisibleColCount := 0;
  for I := 0 to ColumnCount - 1 do
    if Columns[I].Width > 0 then
      Inc(VisibleColCount);
  WidthAvail := WidthOf(Value);
  if VisibleColCount > 1 then
    Dec(WidthAvail, Pred(VisibleColCount) * Inspector.Painter.DividerWidth);
  CurRect := Value;
  WidthUsedInt := 0;
  WidthUsedDbl := 0;
  for I := 0 to ColumnCount - 1 do
  begin
    ColWidth := (Columns[I].Width / 100) * WidthAvail;
    WidthUsedDbl := WidthUsedDbl + ColWidth;
    Inc(WidthUsedInt, Trunc(ColWidth));
    if WidthUsedDbl - WidthUsedInt > 1 then
    begin
      Inc(WidthUsedInt);
      ColWidth := ColWidth + 1;
    end;
    CurRect.Right := CurRect.Left + Trunc(ColWidth);
    Columns[I].Item.SetRects(RectKind, CurRect);
    if RectKind = iprValue then
    begin
      SaveItem := Inspector.Painter.Item;
      try
        Inspector.Painter.Item := Columns[I].Item;
        Inspector.Painter.CalcEditBasedRects;
      finally
        Inspector.Painter.Item := SaveItem;
      end;
    end;
    CurRect.Left := CurRect.Right + Inspector.Painter.DividerWidth;
  end;
end;

procedure TppJvInspectorCustomCompoundItem.EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (SelectedColumn <> nil) and SelectedColumn.Item.Editing then
    SelectedColumn.Item.EditKeyDown(Sender, Key, Shift)
  else
    inherited EditKeyDown(Sender, Key, Shift);
end;

function TppJvInspectorCustomCompoundItem.GetColumnCount: Integer;
begin
  if FColumns <> nil then
    Result := FColumns.Count
  else
    Result := 0;
end;

function TppJvInspectorCustomCompoundItem.GetColumns(I: Integer): TppJvInspectorCompoundColumn;
begin
  Result := TppJvInspectorCompoundColumn(FColumns[I]);
end;

function TppJvInspectorCustomCompoundItem.GetDisplayName: string;
begin
  if SingleName then
  begin
    if SingleNameUseFirstCol then
    begin
      if ColumnCount > 0 then
        Result := Columns[0].Item.DisplayName
      else
        Result := '';
      if (Parent <> nil) and (iifQualifiedNames in Parent.Flags) then
        Result := Parent.DisplayName + '.' + Result;
    end
    else
      Result := inherited GetDisplayName;
  end;
end;

function TppJvInspectorCustomCompoundItem.GetEditing: Boolean;
begin
  Result := (SelectedColumn <> nil) and SelectedColumn.Item.Editing;
end;

function TppJvInspectorCustomCompoundItem.GetSelectedColumn: TppJvInspectorCompoundColumn;
begin
  if SelectedColumnIndex > -1 then
    Result := Columns[SelectedColumnIndex]
  else
    Result := nil;
end;

function TppJvInspectorCustomCompoundItem.GetSelectedColumnIndex: Integer;
begin
  Result := FSelectedColumnIdx;
end;

function TppJvInspectorCustomCompoundItem.GetSingleName: Boolean;
begin
  Result := icifSingleName in CompoundItemFlags;
end;

function TppJvInspectorCustomCompoundItem.GetSingleNameUseFirstCol: Boolean;
begin
  Result := icifSingleNameUseFirstCol in CompoundItemFlags;
end;

function TppJvInspectorCustomCompoundItem.IndexOfColumnPrim(const Col: TppJvInspectorCompoundColumn): Integer;
begin
  Result := ColumnCount -1;
  while (Result >= 0) and (Columns[Result] <> Col) do
    Dec(Result);
end;

function TppJvInspectorCustomCompoundItem.IndexOfColumnPrim(const Item: TppJvCustomInspectorItem): Integer;
begin
  Result := ColumnCount -1;
  while (Result >= 0) and (Columns[Result].Item <> Item) do
    Dec(Result);
end;

procedure TppJvInspectorCustomCompoundItem.InsertColumnPrim(const Index: Integer; const Item: TppJvCustomInspectorItem);
var
  Col: TppJvInspectorCompoundColumn;
begin
  Col := TppJvInspectorCompoundColumn.Create(Self, Item);
  try
    FColumns.Insert(Index, Col);
    RecalcColumnWidths(Col);
  except
    Col.Free;
    raise;
  end;
end;

procedure TppJvInspectorCustomCompoundItem.InsertColumnPrim(const Index, ItemIndex: Integer);
begin
  InsertColumnPrim(Index, Items[ItemIndex]);
end;

procedure TppJvInspectorCustomCompoundItem.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  for I := ColumnCount - 1 downto 0 do
  begin
    if PtInRect(Columns[I].Item.Rects[iprName], Point(X, Y)) or
      PtInRect(Columns[I].Item.Rects[iprValue], Point(X, Y)) then
    begin
      SelectedColumnIndex := I;
      Columns[I].Item.MouseDown(Button, Shift, X, Y);
      Break;
    end;
  end;
end;

procedure TppJvInspectorCustomCompoundItem.RecalcColumnWidths(const SetColumn: TppJvInspectorCompoundColumn = nil);
var
  Idx: Integer;
  PercentLeft: Integer;
  I: Integer;
  DivideOver: array of Integer;

  procedure AddDivide(const DivideIndex: Integer);
  begin
    SetLength(DivideOver, Length(DivideOver) + 1);
    DivideOver[High(DivideOver)] := DivideIndex;
  end;

begin
  if SetColumn <> nil then
  begin
    Idx := IndexOfColumnPrim(SetColumn);
    PercentLeft := 100 - SetColumn.WidthSet;
    if SetColumn.WidthSet > 0 then
      SetColumn.SetWidth(SetColumn.WidthSet)
    else
      AddDivide(Idx);
  end
  else
  begin
    Idx := -1;
    PercentLeft := 100;
  end;
  for I := 0 to ColumnCount - 1 do
  begin
    if I <> Idx then
    begin
      if Columns[I].WidthSet <> 0 then
      begin
        if Columns[I].WidthSet <= PercentLeft then
        begin
          Columns[I].SetWidth(Columns[I].WidthSet);
          Dec(PercentLeft, Columns[I].WidthSet);
        end
        else
        begin
          Columns[I].SetWidth(PercentLeft);
          PercentLeft := 0;
        end;
      end
      else
        AddDivide(I);
    end;
  end;
  if Length(DivideOver) > 0 then
  begin
    Idx := PercentLeft mod Length(DivideOver);
    PercentLeft := PercentLeft div Length(DivideOver);
    for I := 0 to High(DivideOver) do
    begin
      if I <> 0 then
        Columns[DivideOver[I]].SetWidth(PercentLeft)
      else
        Columns[DivideOver[I]].SetWidth(PercentLeft + Idx);
    end;
  end;
end;

procedure TppJvInspectorCustomCompoundItem.SetCompoundItemFlags(Value: TInspectorCompoundItemFlags);
begin
  // Check the difference: if icifSingleName is removed, remove icifSingleNameUseFirstCol as well
  if ((CompoundItemFlags - Value) * [icifSingleName]) <> [] then
    Exclude(Value, icifSingleNameUseFirstCol)
  else
  if Value = [icifSingleNameUseFirstCol] then
    Include(Value, icifSingleName);
  if Value <> CompoundItemFlags then
  begin
    FCompoundItemFlags := Value;
    InvalidateItem;
  end;
end;

procedure TppJvInspectorCustomCompoundItem.SetDisplayName(Value: string);
var
  S: string;
begin
  if SingleName then
  begin
    if SingleNameUseFirstCol then
    begin
      if (Parent <> nil) and (iifQualifiedNames in Parent.Flags) then
        S := Parent.DisplayName + '.';
      if S <> Copy(Value, 1, Length(S)) then
        System.Delete(Value, 1, Length(S));
      if (ColumnCount > 0) and (Columns[0].Item.DisplayName <> Value) then
        Columns[0].Item.DisplayName := Value;
    end
    else
      inherited SetDisplayName(Value);
  end;
end;

procedure TppJvInspectorCustomCompoundItem.SetEditing(const Value: Boolean);
begin
  if SelectedColumn <> nil then
    SelectedColumn.Item.SetEditing(Value);
end;

procedure TppJvInspectorCustomCompoundItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewFlags: TInspectorItemFlags;
begin
  NewFlags := Value - [iifQualifiedNames, iifAutoUpdate, iifMultiLine,
    iifValueList, iifAllowNonListValues, iifOwnerDrawListFixed,
    iifOwnerDrawListVariable, iifEditButton] + [iifReadonly,
    iifEditFixed];
  inherited SetFlags(NewFlags);
end;

procedure TppJvInspectorCustomCompoundItem.SetFocus;
begin
  if SelectedColumn <> nil then
    SelectedColumn.Item.SetFocus;
end;

procedure TppJvInspectorCustomCompoundItem.SetRects(const RectKind: TInspectorPaintRect; Value: TRect);
begin
  inherited SetRects(RectKind, Value);
  case RectKind of
    iprName, iprValue:
      DivideRect(RectKind, Value);
  end;
end;

procedure TppJvInspectorCustomCompoundItem.SetSelectedColumn(Value: TppJvInspectorCompoundColumn);
begin
  SelectedColumnIndex := IndexOfColumnPrim(Value);
end;

procedure TppJvInspectorCustomCompoundItem.SetSelectedColumnIndex(Value: Integer);
begin
  if Value <> SelectedColumnIndex then
  begin
    DoneEdit(False);
    FSelectedColumnIdx := Value;
    InitEdit;
    InvalidateItem;
  end;
end;

procedure TppJvInspectorCustomCompoundItem.SetSingleName(Value: Boolean);
begin
  if Value <> SingleName then
    if Value then
      CompoundItemFlags := CompoundItemFlags + [icifSingleName]
    else
      CompoundItemFlags := CompoundItemFlags - [icifSingleName];
end;

procedure TppJvInspectorCustomCompoundItem.SetSingleNameUseFirstCol(Value: Boolean);
begin
  if Value <> SingleNameUseFirstCol then
    if Value then
      CompoundItemFlags := CompoundItemFlags + [icifSingleNameUseFirstCol]
    else
      CompoundItemFlags := CompoundItemFlags - [icifSingleNameUseFirstCol];
end;

constructor TppJvInspectorCustomCompoundItem.Create(const AParent: TppJvCustomInspectorItem;
  const AData: TppJvCustomInspectorData);
begin
  inherited Create(AParent, AData);
  FColumns := TObjectList.Create;
end;

destructor TppJvInspectorCustomCompoundItem.Destroy;
begin
  inherited Destroy;
end;

procedure TppJvInspectorCustomCompoundItem.BeforeDestruction;
begin
  FreeAndNil(FColumns);
  FSelectedColumnIdx := -1;
  inherited BeforeDestruction;
end;

procedure TppJvInspectorCustomCompoundItem.DoneEdit(const CancelEdits: Boolean);
begin
  if SelectedColumn <> nil then
    SelectedColumn.Item.DoneEdit(CancelEdits);
end;
 
procedure TppJvInspectorCustomCompoundItem.DrawEditor(const ACanvas: TCanvas);
begin
end;

procedure TppJvInspectorCustomCompoundItem.DrawName(const ACanvas: TCanvas);
var
  RTop: Integer;
  RBottom: Integer;
  LastI: Integer;
  I: Integer;
  Col: TppJvInspectorCompoundColumn;
begin
  if SingleName then
    inherited DrawName(ACanvas)
  else
  begin
    with Rects[iprNameArea] do
    begin
      RTop := Top;
      RBottom := Bottom;
    end;
    LastI := ColumnCount - 1;
    while (LastI > 0) and (Columns[LastI].Width < 1) do
      Dec(LastI);
    for I := 0 to LastI do
    begin
      Col := Columns[I];
      if Col.Width >= 0 then
      begin
        if (Inspector.Selected = Self) and (I = SelectedColumnIndex) then
        begin
          ACanvas.Brush.Color := Inspector.Painter.SelectedColor;
          ACanvas.Font.Color := Inspector.Painter.SelectedTextColor;
          with Col.Item.Rects[iprName] do
            ACanvas.FillRect(Rect(Left, RTop, Right, RBottom));
        end
        else
        begin
          ACanvas.Brush.Color := Inspector.Painter.BackgroundColor;
          ACanvas.Font.Color := Inspector.Painter.NameColor;
        end;
        Col.Item.DrawName(ACanvas);
        if I <> LastI then
          with Col.Item.Rects[iprName] do
            Inspector.Painter.PaintDivider(Right - 1, Top + 1, Bottom - 2);
      end;
    end;
  end;
end;

procedure TppJvInspectorCustomCompoundItem.DrawValue(const ACanvas: TCanvas);
var
  LastI: Integer;
  I: Integer;
  Col: TppJvInspectorCompoundColumn;
begin
  LastI := ColumnCount - 1;
  while (LastI > 0) and (Columns[LastI].Width < 1) do
    Dec(LastI);
  for I := 0 to LastI do
  begin
    Col := Columns[I];
    if Col.Width >= 0 then
    begin
      Col.Item.DrawValue(ACanvas);
      if I <> LastI then
        with Col.Item.Rects[iprValue] do
          Inspector.Painter.PaintDivider(Right - 1, Top + 1, Bottom - 2);
    end;
  end;
end;

function TppJvInspectorCustomCompoundItem.EditFocused: Boolean;
begin
  Result := (SelectedColumn <> nil) and (SelectedColumn.Item.EditCtrl <> nil) and
    SelectedColumn.Item.EditCtrl.Focused;
end;

procedure TppJvInspectorCustomCompoundItem.InitEdit;
begin
  if SelectedColumn <> nil then
    SelectedColumn.Item.InitEdit;
end;

//=== TppJvInspectorCompoundItem ===============================================

function TppJvInspectorCompoundItem.AddColumn(const Item: TppJvCustomInspectorItem): Integer;
begin
  Result := AddColumnPrim(Item);
end;

function TppJvInspectorCompoundItem.AddColumn(const ItemIndex: Integer): Integer;
begin
  Result := AddColumnPrim(ItemIndex);
end;

procedure TppJvInspectorCompoundItem.DeleteColumn(const Column: TppJvInspectorCompoundColumn);
begin
  DeleteColumnPrim(Column);
end;

procedure TppJvInspectorCompoundItem.DeleteColumn(const Index: Integer);
begin
  DeleteColumnPrim(Index);
end;

procedure TppJvInspectorCompoundItem.DeleteColumn(const Item: TppJvCustomInspectorItem);
begin
  DeleteColumnPrim(Item);
end;

function TppJvInspectorCompoundItem.IndexOfColumn(const Col: TppJvInspectorCompoundColumn): Integer;
begin
  Result := IndexOfColumnPrim(Col);
end;

function TppJvInspectorCompoundItem.IndexOfColumn(const Item: TppJvCustomInspectorItem): Integer;
begin
  Result := IndexOfColumnPrim(Item);
end;

procedure TppJvInspectorCompoundItem.InsertColumn(const Index: Integer; const Item: TppJvCustomInspectorItem);
begin
  InsertColumnPrim(Index, Item);
end;

procedure TppJvInspectorCompoundItem.InsertColumn(const Index, ItemIndex: Integer);
begin
  InsertColumnPrim(Index, ItemIndex);
end;

//=== TppJvInspectorIntegerItem ================================================

function TppJvInspectorIntegerItem.GetDisplayValue: string;
begin
  Result := ppJclTypedIntToStr(Integer(Data.AsOrdinal), Data.TypeInfo)
end;

procedure TppJvInspectorIntegerItem.SetDisplayValue(const Value: string);
var
  TmpOrd: Integer;
begin
  TmpOrd := ppJclStrToTypedInt(Value, Data.TypeInfo);
  if (JclTypeInfo(Data.TypeInfo) as IppJclOrdinalRangeTypeInfo).OrdinalType = otULong then
    Data.AsOrdinal := Cardinal(TmpOrd)
  else
    Data.AsOrdinal := TmpOrd;

end;

//=== TppJvInspectorEnumItem ===================================================

function TppJvInspectorEnumItem.GetDisplayValue: string;
begin
  Result := GetEnumName(Data.TypeInfo, Ord(Data.AsOrdinal));
end;

procedure TppJvInspectorEnumItem.GetValueList(const Strings: TStrings);
var
  EnumInfo: IppJclEnumerationTypeInfo;
  I: Integer;
begin

 EnumInfo := JclTypeInfo(Data.TypeInfo) as IppJclEnumerationTypeInfo;
  for I := EnumInfo.MinValue to EnumInfo.MaxValue do
    if Trim(EnumInfo.Names[I]) <> '' then
      Strings.Add(EnumInfo.Names[I]);
end;

procedure TppJvInspectorEnumItem.SetDisplayValue(const Value: string);
var
  OrdVal: Integer;
begin
  OrdVal := GetEnumValue(Data.TypeInfo, Value);
  if OrdVal <> -1 then
    Data.AsOrdinal := GetEnumValue(Data.TypeInfo, Value)
  else
    raise EppJvInspectorItem.CreateFmt(sppJvInspItemInvalidPropValue, [AnsiQuotedStr(Value, '''')]);
end;

procedure TppJvInspectorEnumItem.SetFlags(const Value: TInspectorItemFlags);
var
  TmpFlags: TInspectorItemFlags;
begin
  TmpFlags := Value;
  Include(TmpFlags, iifValueList);
  inherited SetFlags(TmpFlags);
end;

//=== TppJvInspectorFloatItem ==================================================

function TppJvInspectorFloatItem.GetDisplayValue: string;
begin
  Result := FloatToStr(Data.AsFloat);
end;

procedure TppJvInspectorFloatItem.SetDisplayValue(const Value: string);
begin
  Data.AsFloat := StrToFloat(Value);
end;

//=== TppJvInspectorSetMemberData ==============================================

function TppJvInspectorSetMemberData.GetAsFloat: Extended;
begin
  CheckReadAccess;
  raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Float']);
end;

function TppJvInspectorSetMemberData.GetAsInt64: Int64;
begin
  CheckReadAccess;
  raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Int64']);
end;

function TppJvInspectorSetMemberData.GetAsMethod: TMethod;
begin
  CheckReadAccess;
  raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['TMethod']);
end;

function TppJvInspectorSetMemberData.GetAsOrdinal: Int64;
var
  Buf: array [0..31] of Byte;
begin
  CheckReadAccess;
  DataParent.GetAsSet(Buf);
  Result := Ord(ppJclTestBitBuffer(Buf, BitOffset));
end;

function TppJvInspectorSetMemberData.GetAsString: string;
begin
  CheckReadAccess;
  raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['String']);
end;

function TppJvInspectorSetMemberData.IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean;
begin
  Result := (Ref is TppJvInspectorSetMemberData) and (TppJvInspectorSetMemberData(Ref).DataParent = DataParent) and (TppJvInspectorSetMemberData(Ref).BitOffset = BitOffset)
end;

procedure TppJvInspectorSetMemberData.NotifyRemoveData(const Instance: TppJvCustomInspectorData);
begin
  // if the instance to be removed is the data parent of this instance, free this instance as well.
  if Instance = DataParent then
    Free;
end;

procedure TppJvInspectorSetMemberData.SetAsFloat(const Value: Extended);
begin
  CheckWriteAccess;
  raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Float']);
end;

procedure TppJvInspectorSetMemberData.SetAsInt64(const Value: Int64);
begin
  CheckWriteAccess;
  raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Int64']);
end;

procedure TppJvInspectorSetMemberData.SetAsMethod(const Value: TMethod);
begin
  CheckWriteAccess;
  raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Method']);
end;

procedure TppJvInspectorSetMemberData.SetAsOrdinal(const Value: Int64);
var
  Buf: array [0..31] of Byte;
begin
  CheckWriteAccess;
  DataParent.GetAsSet(Buf);
  if Value <> 0 then
    ppJclSetBitBuffer(Buf, BitOffset)
  else
    ppJclClearBitBuffer(Buf, BitOffset);
  DataParent.SetAsSet(Buf);
end;

procedure TppJvInspectorSetMemberData.SetAsString(const Value: string);
begin
  CheckWriteAccess;
  raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['String']);
end;

procedure TppJvInspectorSetMemberData.GetAsSet(var Buf);
begin
  CheckReadAccess;
  raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Set']);
end;

function TppJvInspectorSetMemberData.HasValue: Boolean;
begin
  Result := IsInitialized;
end;

function TppJvInspectorSetMemberData.IsAssigned: Boolean;
begin
  Result := IsInitialized;
end;

function TppJvInspectorSetMemberData.IsInitialized: Boolean;
begin
  Result := True;
end;

class function TppJvInspectorSetMemberData.New(const AParent: TppJvCustomInspectorItem;
  const Ordinal: Integer; const ADataParent: TppJvCustomInspectorData): TppJvCustomInspectorItem;
var
  BaseInfo: IppJclOrdinalRangeTypeInfo;
  Data: TppJvInspectorSetMemberData;
begin
  if ADataParent = nil then
    raise EppJvInspectorData.Create(sppJvAssertDataParent);
  if AParent = nil then
    raise EppJvInspectorData.Create(sppJvAssertParent);
  BaseInfo := ((JclTypeInfo(ADataParent.TypeInfo) as IppJclSetTypeInfo).
    BaseType as  IppJclOrdinalRangeTypeInfo);
  if BaseInfo.TypeKind = tkEnumeration then
    Data := CreatePrim(GetEnumName(BaseInfo.TypeInfo, Ordinal), System.TypeInfo(Boolean))
  else
    Data := CreatePrim(IntToStr(Ordinal), System.TypeInfo(Boolean));
  Data.FBitOffset := Ordinal mod 8 + 8 * ((Ordinal div 8) - (BaseInfo.MinValue div 8));
  Data.FDataParent := ADataParent;
  Data := TppJvInspectorSetMemberData(DataRegister.Add(Data));
  if Data <> nil then
    Result := Data.NewItem(AParent)
  else
    Result := nil;
end;

procedure TppJvInspectorSetMemberData.SetAsSet(const Buf);
begin
  CheckWriteAccess;
  raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Set']);
end;

//=== TppJvInspectorSetItem ====================================================

constructor TppJvInspectorSetItem.Create(const AParent: TppJvCustomInspectorItem;
  const AData: TppJvCustomInspectorData);
begin
  inherited Create(AParent, AData);
  ItemSetFlags := [isfCreateMemberItems];
end;

function TppJvInspectorSetItem.CanEdit: Boolean;
begin
  Result := inherited CanEdit and (isfEditString in ItemSetFlags);
end;

procedure TppJvInspectorSetItem.CreateMembers;
var
  SetInfo:  IppJclSetTypeInfo;
  BaseInfo:  IppJclOrdinalRangeTypeInfo;
  OrdVal: Integer;
begin
  Inspector.BeginUpdate;
  try
    DeleteMembers;
    JclTypeInfo(Data.TypeInfo).QueryInterface(IppJclSetTypeInfo, SetInfo);
    SetInfo.BaseType.QueryInterface(IppJclOrdinalRangeTypeInfo, BaseInfo);
    for OrdVal := Integer(BaseInfo.MinValue) to Integer(BaseInfo.MaxValue) do
      TppJvInspectorSetMemberData.New(Self, OrdVal, Data);
  finally
    Inspector.EndUpdate;
  end;
end;

procedure TppJvInspectorSetItem.DeleteMembers;
var
  I: Integer;
begin
  Inspector.BeginUpdate;
  try
    I := Pred(Count);
    while (I >= 0) do
    begin
      if Items[I].Data is TppJvInspectorSetMemberData then
        Delete(I);
      Dec(I);
    end;
  finally
    Inspector.EndUpdate;
  end;
end;

function TppJvInspectorSetItem.GetCreateMemberItems: Boolean;
begin
  Result := (isfCreateMemberItems in ItemSetFlags);
end;

function TppJvInspectorSetItem.GetDisplayValue: string;
var
  SetBuf: array [0..31] of Byte;
begin
  Data.GetAsSet(SetBuf);
  Result := ppJclSetToStr(Data.TypeInfo, SetBuf, True, False);
end;

function TppJvInspectorSetItem.GetEditString: Boolean;
begin
  Result := (isfEditString in ItemSetFlags);
end;

function TppJvInspectorSetItem.GetItemSetFlags: TInspectorSetFlags;
begin
  Result := FItemSetFlags;
end;

procedure TppJvInspectorSetItem.InvalidateMetaData;
begin
  if CreateMemberItems then
    CreateMembers
  else
    DeleteMembers;
end;

procedure TppJvInspectorSetItem.SetCreateMemberItems(const Value: Boolean);
begin
  if Value <> CreateMemberItems then
  begin
    if Value then
      ItemSetFlags := ItemSetFlags + [isfCreateMemberItems]
    else
      ItemSetFlags := ItemSetFlags - [isfCreateMemberItems];
  end;
end;

procedure TppJvInspectorSetItem.SetDisplayValue(const Value: string);
var
  SetBuf: array [0..31] of Byte;
begin
  ppJclStrToSet(Data.TypeInfo, SetBuf[0], Value);
  Data.SetAsSet(SetBuf[0]);
end;

procedure TppJvInspectorSetItem.SetEditString(const Value: Boolean);
begin
  if Value <> EditString then
  begin
    if Value then
      ItemSetFlags := ItemSetFlags + [isfEditString]
    else
      ItemSetFlags := ItemSetFlags - [isfEditString];
  end;
end;

procedure TppJvInspectorSetItem.SetFlags(const Value: TInspectorItemFlags);
var
  OldReadOnly: Boolean;
  I: Integer;
begin
  OldReadOnly := ReadOnly;
  inherited SetFlags(Value);
  if (OldReadOnly <> ReadOnly) and CreateMemberItems then
    for I := 0 to Pred(Count) do
      Items[I].ReadOnly := ReadOnly;
end;

procedure TppJvInspectorSetItem.SetItemSetFlags(const Value: TInspectorSetFlags);
begin
  if ItemSetFlags <> Value then
  begin
    FItemSetFlags := Value;
    InvalidateMetaData;
  end;
end;

//=== TppJvInspectorCharItem ===================================================

function TppJvInspectorCharItem.GetDisplayValue: string;
var
  I: Integer;
begin
  I := Data.AsOrdinal;
  if (I <= Ord(' ')) or (I > Ord('~')) then
    Result := '#' + IntToStr(I)
  else
    Result := Chr(Byte(I));
end;

procedure TppJvInspectorCharItem.SetDisplayValue(const Value: string);
var
  I: Integer;
begin
  if Length(Value) > 1 then
    I := StrToInt(Copy(Value, 2, Length(Value)))
  else
  if Length(Value) = 1 then
    I := Ord(Value[1])
  else
    I := 0;
  Data.AsOrdinal := I;
end;

//=== TppJvInspectorInt64Item ==================================================

function TppJvInspectorInt64Item.GetDisplayValue: string;
begin
  Result := IntToStr(Data.AsInt64);
end;

procedure TppJvInspectorInt64Item.SetDisplayValue(const Value: string);
begin
  Data.AsInt64 := StrToInt64(Value);
end;

//=== TppJvInspectorStringItem =================================================

function TppJvInspectorStringItem.GetDisplayValue: string;
begin
  Result := Data.AsString;
end;

procedure TppJvInspectorStringItem.SetDisplayValue(const Value: string);
begin
  Data.AsString := Value;
end;

//=== TppJvInspectorClassItem ==================================================

constructor TppJvInspectorClassItem.Create(const AParent: TppJvCustomInspectorItem;
  const AData: TppJvCustomInspectorData);
begin
  inherited Create(AParent, AData);
  if GetTypeData(Data.TypeInfo).ClassType.InheritsFrom(Classes.TComponent) then
  begin
    ItemClassFlags := [icfCreateMemberItems];
    Flags := Flags + [iifValueList];
  end
  else
  if GetTypeData(Data.TypeInfo).ClassType.InheritsFrom(TPersistent) then
    ItemClassFlags := [icfCreateMemberItems, icfShowClassName]
  else
    ItemClassFlags := [icfShowClassName];
end;

procedure TppJvInspectorClassItem.CreateMembers;
begin
  if Data.IsInitialized and (Data.AsOrdinal <> 0) then
  begin
    Inspector.BeginUpdate;
    try
      DeleteMembers;
      TppJvInspectorPropData.New(Self, TObject(Data.AsOrdinal));
      FLastMemberInstance := TObject(Data.AsOrdinal);
    finally
      Inspector.EndUpdate;
    end;
  end;
end;

function TppJvInspectorClassItem.CanEdit: Boolean;
begin
  Result := inherited CanEdit and ((iifEditButton in Flags) or
    (iifValueList in Flags));
end;

procedure TppJvInspectorClassItem.DeleteMembers;
var
  I: Integer;
begin
  if Data.IsInitialized then
  begin
    Inspector.BeginUpdate;
    try
      for I := Pred(Count) downto 0 do
        if (Items[I].Data is TppJvInspectorPropData) and (Items[I].Data.IsInitialized) and
            (TppJvInspectorPropData(Items[I].Data).Instance = FLastMemberInstance) then
          Delete(I);
      FLastMemberInstance := nil;
    finally
      Inspector.EndUpdate;
    end;
  end;
end;

function TppJvInspectorClassItem.GetCreateMemberItems: Boolean;
begin
  Result := (icfCreateMemberItems in ItemClassFlags);
end;

function TppJvInspectorClassItem.GetDisplayValue: string;
var
  Obj: TObject;
  SL: TStrings;
  I: Integer;
begin
  Obj := TObject(Data.AsOrdinal);
  if ShowClassName then
  begin
    if Obj <> nil then
      Result := Result + '('+ Obj.ClassName + ')'
    else
      Result := Result + '(' + GetTypeData(Data.TypeInfo).ClassType.ClassName + ')';
  end
  else
  begin
    if Obj <> nil then
    begin
      SL := TStringList.Create;
      try
        GetValueList(SL);
        I := SL.IndexOfObject(Obj);
        if I > -1 then
          Result := SL[I]
        else
          Result := '';
      finally
        SL.Free;
      end;
    end
    else
      Result := '';
  end;
end;

function TppJvInspectorClassItem.GetItemClassFlags: TInspectorClassFlags;
begin
  Result := FItemClassFlags;
end;

function TppJvInspectorClassItem.GetShowClassName: Boolean;
begin
  Result := (icfShowClassName in ItemClassFlags);
end;

procedure TppJvInspectorClassItem.InvalidateItem;
begin
  inherited InvalidateItem;
  if icfCreateMemberItems in ItemClassFlags then
    CreateMembers;
end;

procedure TppJvInspectorClassItem.InvalidateMetaData;
begin
  if icfCreateMemberItems in ItemClassFlags then
    CreateMembers
  else
    DeleteMembers;
end;

procedure TppJvInspectorClassItem.SetCreateMemberItems(const Value: Boolean);
begin
  if Value <> CreateMemberItems then
    if Value then
      ItemClassFlags := ItemClassFlags + [icfCreateMemberItems]
    else
      ItemClassFlags := ItemClassFlags - [icfCreateMemberItems];
end;

procedure TppJvInspectorClassItem.SetDisplayValue(const Value: string);
var
  SL: TStrings;
  I: Integer;
begin
  if Value = '' then
    Data.AsOrdinal := 0
  else
  begin
    SL := TStringList.Create;
    try
      GetValueList(SL);
      I := SL.IndexOf(Value);
      if I > -1 then
        Data.AsOrdinal := Integer(SL.Objects[I])
      else
        raise EppJvInspectorItem.CreateFmt(sppJvInspItemInvalidPropValue,
          [AnsiQuotedStr(Value, '''')]);
    finally
      SL.Free;
    end;
  end;
end;

procedure TppJvInspectorClassItem.SetItemClassFlags(Value: TInspectorClassFlags);
begin
  if Value <> ItemClassFlags then
  begin
    FItemClassFlags := Value;
    InvalidateMetaData;
  end;
end;

procedure TppJvInspectorClassItem.SetShowClassName(const Value: Boolean);
begin
  if Value <> ShowClassName then
  begin
    if Value then
      ItemClassFlags := ItemClassFlags + [icfShowClassName]
    else
      ItemClassFlags := ItemClassFlags - [icfShowClassName];
  end;
end;

//=== TppJvInspectorComponentItem ==============================================

function TppJvInspectorComponentItem.GetItemComponentFlags: TInspectorComponentFlags;
begin
  Result := FItemComponentFlags;
end;

function TppJvInspectorComponentItem.GetKeepFirstOwnerAsFirst: Boolean;
begin
  Result := icfKeepFirstOwnerAsFirst in ItemComponentFlags;
end;

function TppJvInspectorComponentItem.GetNoShowFirstOwnerName: Boolean;
begin
  Result := icfNoShowFirstOwnerName in ItemComponentFlags;
end;

function TppJvInspectorComponentItem.GetOwnerCount: Integer;
begin
  Result := FOwners.Count;
end;

function TppJvInspectorComponentItem.GetOwners(I: Integer): TComponent;
begin
  Result := TComponent(FOwners[I]);
end;

function TppJvInspectorComponentItem.GetShowOwnerNames: Boolean;
begin
  Result := icfShowOwnerNames in ItemComponentFlags;
end;

function TppJvInspectorComponentItem.GetSortComponents: Boolean;
begin
  Result := icfSortComponents in ItemComponentFlags;
end;

function TppJvInspectorComponentItem.GetSortOwners: Boolean;
begin
  Result := icfSortOwners in ItemComponentFlags;
end;

procedure TppJvInspectorComponentItem.GetValueList(const Strings: TStrings);
var
  MinClass: TClass;
  SL: TStringList;
  OwnerList: TStringList;
  I: Integer;
  CurOwner: TComponent;
  PrefixWithOwner: string;
  J: Integer;
begin
  MinClass := GetTypeData(Data.TypeInfo).ClassType;
  SL := TStringList.Create;
  try
    OwnerList := TStringList.Create;
    try
      for I := 0 to OwnerCount - 1 do
        OwnerList.AddObject(Owners[I].Name, Owners[I]);
      if SortOwners then
        OwnerList.Sort;
      if (OwnerCount > 0) and KeepFirstOwnerAsFirst then
      begin
        I := OwnerList.IndexOfObject(Owners[0]);
        if I > 0 then
        begin
          OwnerList.Delete(I);
          OwnerList.InsertObject(0, Owners[0].Name, Owners[0]);
        end;
      end;
      for I := 0 to OwnerCount - 1 do
      begin
        SL.Clear;
        CurOwner := TComponent(OwnerList.Objects[I]);
        if ShowOwnerNames then
        begin
          if (I > 0) or not NoShowFirstOwnerName then
            PrefixWithOwner := CurOwner.Name + '.';
        end
        else
          PrefixWithOwner := '';
        for J := 0 to CurOwner.ComponentCount - 1 do
          if CurOwner.Components[J] is MinClass then
            SL.AddObject(PrefixWithOwner + CurOwner.Components[J].Name, CurOwner.Components[J]);
        if SL.Count > 0 then
        begin
          if SortComponents then
            SL.Sort;
          Strings.AddStrings(SL);
        end;
      end;
      SL.Clear;
      inherited GetValueList(SL);
      if SortComponents then
        SL.Sort;
      if SL.Count > 0 then
        Strings.AddStrings(SL);
    finally
      OwnerList.Free;
    end;
  finally
    SL.Free;
  end;
end;

procedure TppJvInspectorComponentItem.SetFlags(const Value: TInspectorItemFlags);
begin
  inherited SetFlags(Value + [iifValueList]);
end;

procedure TppJvInspectorComponentItem.SetItemClassFlags(Value: TInspectorClassFlags);
begin
  inherited SetItemClassFlags(Value - [icfShowClassName]);
end;

procedure TppJvInspectorComponentItem.SetItemComponentFlags(Value: TInspectorComponentFlags);
begin
  if ItemComponentFlags <> Value then
  begin
    FItemComponentFlags := Value;
    InvalidateMetaData;
  end;
end;

procedure TppJvInspectorComponentItem.SetKeepFirstOwnerAsFirst(Value: Boolean);
begin
  if Value <> KeepFirstOwnerAsFirst then
    if Value then
      ItemComponentFlags := ItemComponentFlags + [icfKeepFirstOwnerAsFirst]
    else
      ItemComponentFlags := ItemComponentFlags - [icfKeepFirstOwnerAsFirst];
end;

procedure TppJvInspectorComponentItem.SetNoShowFirstOwnerName(Value: Boolean);
begin
  if Value <> NoShowFirstOwnerName then
    if Value then
      ItemComponentFlags := ItemComponentFlags + [icfNoShowFirstOwnerName]
    else
      ItemComponentFlags := ItemComponentFlags - [icfNoShowFirstOwnerName];
end;

procedure TppJvInspectorComponentItem.SetOwners(I: Integer; Value: TComponent);
begin
  FOwners[I] := Value;
end;

procedure TppJvInspectorComponentItem.SetShowOwnerNames(Value: Boolean);
begin
  if Value <> ShowOwnerNames then
    if Value then
      ItemComponentFlags := ItemComponentFlags + [icfShowOwnerNames]
    else
      ItemComponentFlags := ItemComponentFlags - [icfShowOwnerNames];
end;

procedure TppJvInspectorComponentItem.SetSortComponents(Value: Boolean);
begin
  if Value <> SortComponents then
    if Value then
      ItemComponentFlags := ItemComponentFlags + [icfSortComponents]
    else
      ItemComponentFlags := ItemComponentFlags - [icfSortComponents];
end;

procedure TppJvInspectorComponentItem.SetSortOwners(Value: Boolean);
begin
  if Value <> SortOwners then
    if Value then
      ItemComponentFlags := ItemComponentFlags + [icfSortOwners]
    else
      ItemComponentFlags := ItemComponentFlags - [icfSortOwners];
end;

constructor TppJvInspectorComponentItem.Create(const AParent: TppJvCustomInspectorItem;
  const AData: TppJvCustomInspectorData);
begin
  inherited Create(AParent, AData);
  FOwners := TList.Create;
end;

destructor TppJvInspectorComponentItem.Destroy;
begin
  inherited Destroy;
end;

procedure TppJvInspectorComponentItem.BeforeDestruction;
begin
  FOwners.Free;
  inherited BeforeDestruction;
end;

procedure TppJvInspectorComponentItem.AddOwner(const AOwner: TComponent);
begin
  if FOwners.IndexOf(Aowner) < 0 then
    FOwners.Add(AOwner);
end;

procedure TppJvInspectorComponentItem.DeleteOwner(const AOwner: TComponent);
begin
  FOwners.Remove(AOwner);
end;

procedure TppJvInspectorComponentItem.DeleteOwner(const Index: Integer);
begin
  FOwners.Delete(Index);
end;

//=== TppJvInspectorFontItem ===================================================

procedure TppJvInspectorFontItem.Edit;
begin
  with TFontDialog.Create(GetParentForm(Inspector)) do
  try
    Font.Assign(TFont(Data.AsOrdinal));
    Device := fdScreen;
    if Execute then
    begin
      TFont(Data.AsOrdinal).Assign(Font);
      Data.InvalidateData;
    end;
  finally
    Free;
    ShowScrollBar(Inspector.Handle, SB_BOTH, False);
  end;
end;

procedure TppJvInspectorFontItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewValue: TInspectorItemFlags;
begin
  NewValue := Value + [iifEditButton, iifEditFixed];
  inherited SetFlags(NewValue);
end;

//=== TppJvInspectorFontNameItem ===============================================

procedure TppJvInspectorFontNameItem.DoDrawListItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  FontName: string;
begin
  with TListBox(Control) do
  begin
    FontName := Items[Index];
    Canvas.Font.Name := FontName;
    Canvas.TextRect(Rect, Rect.Left, Rect.Top, Items[Index]);
  end;
end;

procedure TppJvInspectorFontNameItem.DoMeasureListItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
var
  FontName: string;
begin
  with TListBox(Control) do
  begin
    FontName := Items[Index];
    Canvas.Font.Name := FontName;
  end;
  Height := TListBox(Control).Canvas.TextHeight('Wy');
end;

procedure TppJvInspectorFontNameItem.DoMeasureListItemWidth(Control: TWinControl;
  Index: Integer; var Width: Integer);
var
  FontName: string;
begin
  with TListBox(Control) do
  begin
    FontName := Items[Index];
    Canvas.Font.Name := FontName;
  end;
  Width := TListBox(Control).Canvas.TextWidth(FontName);
end;

procedure TppJvInspectorFontNameItem.GetValueList(const Strings: TStrings);
begin
  Strings.Assign(Screen.Fonts);
end;

procedure TppJvInspectorFontNameItem.SetFlags(const Value: TInspectorItemFlags);
var
  NewValue: TInspectorItemFlags;
begin
  NewValue := Value + [iifValueList, iifOwnerDrawListVariable];
  inherited SetFlags(NewValue);
end;

//=== TppJvInspectorBooleanItem ================================================

function TppJvInspectorBooleanItem.GetShowAsCheckbox: Boolean;
begin
  Result := FShowAsCheckbox;
end;

procedure TppJvInspectorBooleanItem.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Bool: Boolean;
begin
  if ShowAsCheckbox then
  begin
    Bool := not (Data.AsOrdinal <> Ord(False));
    if Editing and (Shift = []) and (Key = VK_SPACE) then
    begin
      Data.AsOrdinal := Ord(Bool);
      InvalidateItem;
    end;
  end
  else
    inherited EditKeyDown(Sender, Key, Shift)
end;

procedure TppJvInspectorBooleanItem.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Bool: Boolean;
begin
  if Data.IsAssigned then
    Bool := not (Data.AsOrdinal <> Ord(False))
  else
    Bool := True;
  if PtInRect(FCheckRect, Point(X, Y)) and (Shift = [ssLeft]) and
    Editing and ShowAsCheckbox then
  begin
    Data.AsOrdinal := Ord(Bool);
    InvalidateItem;
  end
  else
  begin
    if (ssDouble in Shift) and ShowAsCheckbox then
      Shift := Shift - [ssDouble];
    if not ShowAsCheckBox then
      inherited MouseDown(Button, Shift, X, Y);
  end;
end;

procedure TppJvInspectorBooleanItem.SetShowAsCheckbox(Value: Boolean);
var
  WasEditing: Boolean;
begin
  if Value <> ShowAsCheckbox then
  begin
    WasEditing := Editing;
    DoneEdit(False);
    FShowAsCheckbox := Value;
    InvalidateMetaData;
    if WasEditing then
      InitEdit;
  end;
end;

procedure TppJvInspectorBooleanItem.DoneEdit(const CancelEdits: Boolean = False);
begin
  if ShowAsCheckbox then
    SetEditing(False)
  else
    inherited DoneEdit(CancelEdits);
end;

procedure TppJvInspectorBooleanItem.DrawValue(const ACanvas: TCanvas);
var
  Bool: Boolean;
  ARect: TRect;
  SaveRgn: HRGN;
  HasRgn: Boolean;
  ClipRect: TRect;
  Rgn: HRGN;
begin
  if not ShowAsCheckbox then
    inherited DrawValue(ACanvas)
  else
  begin
    if Data.IsInitialized and Data.IsAssigned and Data.HasValue then
      Bool := Data.AsOrdinal <> Ord(False)
    else
      Bool := False;

    if Editing and Data.IsAssigned then
      ACanvas.Brush.Color := clWindow;
    ACanvas.FillRect(Rects[iprValueArea]);
    ARect := Rects[iprValue];
    OffsetRect(ARect, 2, 0);
    ARect.Right := ARect.Left + 13;
    ARect.Bottom := ARect.Top + 13;
    { Remember current clipping region }
    SaveRgn := CreateRectRgn(0,0,0,0);
    HasRgn := GetClipRgn(ACanvas.Handle, SaveRgn) > 0;
    { Clip all outside of the item rectangle }
    IntersectRect(ClipRect, ARect, Rects[iprValue]);
    FCheckRect := ClipRect;
    with ClipRect do
      Rgn := CreateRectRgn(Left, Top, Right, Bottom);
    SelectClipRgn(ACanvas.Handle, Rgn);
    DeleteObject(Rgn);
    try
      { Paint the 3d checkbox: Frame }
      Frame3D(ACanvas, ARect, clBlack, clWhite, 1);
      Frame3D(ACanvas, ARect, clBlack, cl3DLight, 1);

      if Bool then
        with ACanvas do
        begin
        { Paint the 3d checkbox: Draw the checkmark }
          Pen.Color := clWindowText;
          Pen.Width := 1;
          MoveTo(ARect.Left + 1, ARect.Top + 3);
          LineTo(ARect.Left + 3, ARect.Top + 5);
          LineTo(ARect.Left + 8, ARect.Top);
          MoveTo(ARect.Left + 1, ARect.Top + 4);
          LineTo(ARect.Left + 3, ARect.Top + 6);
          LineTo(ARect.Left + 8, ARect.Top + 1);
          MoveTo(ARect.Left + 1, ARect.Top + 5);
          LineTo(ARect.Left + 3, ARect.Top + 7);
          LineTo(ARect.Left + 8, ARect.Top + 2);
        end;
    finally
      { restore previous clipping region }
      if HasRgn then
        SelectClipRgn(ACanvas.Handle, SaveRgn)
      else
        SelectClipRgn(ACanvas.Handle, 0);
      DeleteObject(SaveRgn);
    end;
  end;
end;

procedure TppJvInspectorBooleanItem.InitEdit;
begin
  if ShowAsCheckbox then
    SetEditing(CanEdit)
  else
    inherited InitEdit;
end;

//=== TppJvInspectorDateItem ===================================================

constructor TppJvInspectorDateItem.Create(const AParent: TppJvCustomInspectorItem;
  const AData: TppJvCustomInspectorData);
begin
  inherited Create(AParent, AData);
  FFormat := ShortDateFormat;
end;

function TppJvInspectorDateItem.GetDisplayValue: string;
begin
  Result := FormatDateTime(Format, Data.AsFloat);
end;

procedure TppJvInspectorDateItem.SetDisplayValue(const Value: string);
begin
  if Data.IsAssigned then
    Data.AsFloat := Trunc(StrToDate(Value)) + Frac(Data.AsFloat)
  else
    Data.AsFloat := Trunc(StrToDate(Value));
end;

procedure TppJvInspectorDateItem.SetFormat(Value: string);
var
  I: Integer;
  MCount: Integer;
  DCount: Integer;
  YCount: Integer;
  SepCount: Integer;
  WasEditing: Boolean;
begin
  // Only allow d, dd, m, mm, yy, yyyy and the date separator characters to ease parsing
  I := 1;
  MCount := 0;
  DCount := 0;
  YCount := 0;
  SepCount := 0;
  while I < Length(Value) do
  begin
    case Value[I] of
      'd':
        begin
          if (DCount = 0) and (I > 1) and (Value[I - 1] <>  DateSeparator) then
            raise EppJvInspectorData.Create('A specifier should be placed before and after a separator.');
          if (DCount = 1) and (Value[I - 1] <> 'd') then
            raise EppJvInspectorData.Create('''d'' or ''dd'' should appear only once.');
          if (DCount = 2) then
            raise EppJvInspectorData.Create('Only ''d'' or ''dd'' are allowed.');
          Inc(DCount);
        end;
      'm':
        begin
          if (MCount = 0) and (I > 1) and (Value[I - 1] <>  DateSeparator) then
            raise EppJvInspectorData.Create('A specifier should be placed before and after a separator.');
          if (MCount = 1) and (Value[I - 1] <> 'm') then
            raise EppJvInspectorData.Create('''m'' or ''mm'' should appear only once.');
          if (MCount = 2) then
            raise EppJvInspectorData.Create('Only ''m'' or ''mm'' are allowed.');
          Inc(MCount);
        end;
      'y':
        begin
          if (MCount = 0) and (I > 1) and (Value[I - 1] <>  DateSeparator) then
            raise EppJvInspectorData.Create('A specifier should be placed before and after a separator.');
          if (YCount > 1) and (YCount < 4) and (Value[I - 1] <> 'y') then
            raise EppJvInspectorData.Create('''yy'' or ''yyyy'' should appear only once.');
          if (YCount = 4) then
            raise EppJvInspectorData.Create('Only ''yy'' or ''yyyy'' are allowed.');
          Inc(YCount);
        end;
      else
        if Value[I] = DateSeparator then
        begin
          if ((SepCount = 0) and (I = 1)) or
              ((SepCount = 1) and ((Value[I - 1]) = DateSeparator) or (I = Length(Value))) then
            raise EppJvInspectorData.Create('A specifier should be placed before and after a separator.');
          if SepCount = 2 then
            raise EppJvInspectorData.Create('Only two separators are allowed.');
          Inc(SepCount);
        end
        else
          raise EppJvInspectorData.CreateFmt('Only ''d'', ''m'', ''y'' and ''%s'' are allowed', [DateSeparator]);
    end;
    Inc(I);
  end;
  if DCount = 0 then
    raise EppJvInspectorData.Create('''d'' or ''dd'' are required.');
  if MCount = 0 then
    raise EppJvInspectorData.Create('''m'' or ''mm'' are required.');
  if YCount = 0 then
    raise EppJvInspectorData.Create('''yy'' or ''yyyy'' are required.');
  if (YCount = 1) or (YCount = 3) then
    raise EppJvInspectorData.Create('Only ''yy'' or ''yyyy'' are allowed.');
  if Value <> FFormat then
  begin
    WasEditing := Editing;
    if Editing then
      DoneEdit;
    FFormat := Value;
    if WasEditing then
      InitEdit;
  end;
end;

//=== TppJvInspectorTimeItem ===================================================

constructor TppJvInspectorTimeItem.Create(const AParent: TppJvCustomInspectorItem;
  const AData: TppJvCustomInspectorData);
begin
  inherited Create(AParent, AData);
  FShowSeconds := True;
  FShowAMPM := False;
  SetFormat;
end;

function TppJvInspectorTimeItem.GetDisplayValue: string;
begin
  Result := FormatDateTime(Format, Data.AsFloat);
end;

procedure TppJvInspectorTimeItem.SetDisplayValue(const Value: string);
begin
  if Data.IsAssigned then
    Data.AsFloat := Frac(StrToTime(Value)) + Trunc(Data.AsFloat)
  else
    Data.AsFloat := Frac(StrToTime(Value)) + Trunc(Data.AsFloat);
end;

procedure TppJvInspectorTimeItem.SetFormat;
begin
  FFormat := 'hh:nn';
  if ShowSeconds then
    FFormat := FFormat + ':ss';
  if ShowAMPM then
    FFormat := FFormat + ' ampm';
end;

procedure TppJvInspectorTimeItem.SetShowAMPM(Value: Boolean);
var
  WasEditing: Boolean;
begin
  if Value <> ShowAMPM then
  begin
    WasEditing := Editing;
    DoneEdit;
    FShowAMPM := Value;
    SetFormat;
    if WasEditing then
      InitEdit;
  end;
end;

procedure TppJvInspectorTimeItem.SetShowSeconds(Value: Boolean);
var
  WasEditing: Boolean;
begin
  if Value <> ShowSeconds then
  begin
    WasEditing := Editing;
    DoneEdit;
    FShowSeconds := Value;
    SetFormat;
    if WasEditing then
      InitEdit;
  end;
end;

//=== TppJvInspectorDateTimeItem ===============================================

constructor TppJvInspectorDateTimeItem.Create(const AParent: TppJvCustomInspectorItem;
  const AData: TppJvCustomInspectorData);
begin
  inherited Create(AParent, AData);
  SingleNameUseFirstCol := True;
  FDate := TppJvInspectorDateItem.Create(Self, AData);
  FTime := TppJvInspectorTimeItem.Create(Self, AData);
  AddColumnPrim(FDate);
  AddColumnPrim(FTime);
end;

function TppJvInspectorDateTimeItem.GetDateFormat: string;
begin
  Result := FDate.Format;
end;

function TppJvInspectorDateTimeItem.GetTimeShowAMPM: Boolean;
begin
  Result := FTime.ShowAMPM;
end;

function TppJvInspectorDateTimeItem.GetTimeShowSeconds: Boolean;
begin
  Result := FTime.ShowSeconds;
end;

procedure TppJvInspectorDateTimeItem.SetDateFormat(Value: string);
begin
  FDate.Format := Value;
end;

procedure TppJvInspectorDateTimeItem.SetTimeShowAMPM(Value: Boolean);
begin
  FTime.ShowAMPM := Value;
end;

procedure TppJvInspectorDateTimeItem.SetTimeShowSeconds(Value: Boolean);
begin
  FTime.ShowSeconds := Value;
end;

//=== TSLEditorForm ==========================================================

type
  TSLEditorForm = class(TCustomForm)
  public
    grp: TGroupBox;
    lbl: TLabel;
    mm: TMemo;
    btnOK: TButton;
    btnCancel: TButton;
    OnContentsChanged: TNotifyEvent;
    constructor CreateNew(AOwner: TComponent); reintroduce;
    procedure MemoChanged(Sender: TObject);
  end;

constructor TSLEditorForm.CreateNew(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  Caption := 'String list editor';
  Width := 435;
  Height := 305;
  BorderIcons := [biSystemMenu];
  grp := TGroupBox.Create(Self);
  grp.Parent := Self;
  grp.Left := 10;
  grp.Top := 10;
  grp.Width := ClientWidth - 20;
  grp.Height := 230;
  grp.Anchors := [akTop, akLeft, akRight, akBottom];
  lbl := TLabel.Create(Self);
  lbl.Parent := grp;
  lbl.Caption := '';
  lbl.AutoSize := False;
  lbl.Left := 10;
  lbl.Top := 10;
  lbl.Width := grp.ClientWidth - 20;
  lbl.Anchors := [akTop, akLeft, akRight];
  mm := TMemo.Create(Self);
  mm.Parent := grp;
  mm.Left := 10;
  mm.Top := 30;
  mm.Width := grp.ClientWidth - 20;
  mm.Height := grp.ClientHeight - 40;
  mm.Anchors := [akTop, akLeft, akRight, akBottom];
  mm.ScrollBars := ssBoth;
  mm.WordWrap := False;
  mm.WantReturns := True;
  mm.WantTabs := False;
  mm.OnChange := MemoChanged;
  btnOK := TButton.Create(Self);
  btnOK.Parent := Self;
  btnOK.ModalResult := mrOK;
  btnOK.Default := True;
  btnOK.Caption := '&OK';
  btnOK.Left := ClientWidth - 15 - 2 * btnOK.Width;
  btnOK.Top := ClientHeight - 5 - btnOK.Height;
  btnOK.Anchors := [akRight, akBottom];
  btnCancel := TButton.Create(Self);
  btnCancel.Parent := Self;
  btnCancel.ModalResult := mrCancel;
  btnCancel.Cancel := True;
  btnCancel.Caption := 'Cancel';
  btnCancel.Left := ClientWidth - 10 - btnCancel.Width;
  btnCancel.Top := ClientHeight - 5 - btnCancel.Height;
  btnCancel.Anchors := [akRight, akBottom];
  Constraints.MinWidth := 2 * btnOK.Width + 25 + (Width - ClientWidth);
  Constraints.MinHeight := (ClientHeight - mm.ClientHeight) + 43 + (Height - ClientHeight);
end;

procedure TSLEditorForm.MemoChanged(Sender: TObject);
var
  I: Integer;
begin
  I := mm.Lines.Count;
  if I <> 1 then
    lbl.Caption := IntToStr(I) + ' lines'
  else
    lbl.Caption := '1 line';
  if Assigned(OnContentsChanged) then
    OnContentsChanged(Sender);
end;

//=== TppJvInspectorTStringsItem ===============================================

constructor TppJvInspectorTStringsItem.Create(const AParent: TppJvCustomInspectorItem; const AData: TppJvCustomInspectorData);
begin
  inherited Create(AParent, AData);
  RowSizing.MinHeight := irsItemHeight;
  Flags := Flags + [iifEditButton];
end;

procedure TppJvInspectorTStringsItem.ContentsChanged(Sender: TObject);
var
  Obj: TStrings;
begin
  Obj := TStrings(Data.AsOrdinal);
  Obj.Text := TMemo(Sender).Lines.Text;
end;

function TppJvInspectorTStringsItem.GetDisplayValue: string;
var
  Obj: TObject;
begin
  Obj := TObject(Data.AsOrdinal);
  if not Multiline then
  begin
    if Obj <> nil then
      Result := Result + '('+ Obj.ClassName + ')'
    else
      Result := Result + '(' + GetTypeData(Data.TypeInfo).ClassType.ClassName + ')';
  end
  else
    Result := TStrings(Obj).Text
end;

procedure TppJvInspectorTStringsItem.Edit;
var
  SL: TStrings;
begin
  with TSLEditorForm.CreateNew(Inspector) do
  try
    Position := poScreenCenter; // DM - center the dialog
    SL := TStrings(Data.AsOrdinal);
    mm.Lines.Assign(SL);
    if AutoUpdate then
      OnContentsChanged := ContentsChanged;
    if ShowModal = mrOK then
      SL.Assign(mm.Lines)
  finally
    Free;
  end;
end;

procedure TppJvInspectorTStringsItem.SetDisplayValue(const Value: string);
var
  Obj: TObject;
begin
  if Multiline then
  begin
    Obj := TObject(Data.AsOrdinal);
    TStrings(Obj).Text := Value;
  end;
end;

procedure TppJvInspectorTStringsItem.SetFlags(const Value: TInspectorItemFlags);
var
  OldMask: TInspectorItemFlags;
  NewMask: TInspectorItemFlags;
begin
  { The item has either an edit button or is multiline. If one of them is set, the otherone will
    removed }
  OldMask := Flags * [iifEditButton, iifMultiLine];
  NewMask := Value * [iifEditButton, iifMultiLine];
  if OldMask <> NewMask then
  begin
    if Multiline and not (iifEditButton in OldMask) and (iifEditButton in NewMask) then
      inherited SetFlags(Value - [iifMultiline]) // iifEditButton has changed
    else
    if not Multiline and (iifEditButton in OldMask) and (iifMultiline in NewMask) then
      inherited SetFlags(Value - [iifEditButton]) // iifMultiline has changed
    else
      inherited SetFlags(Value);                  // Neither flag has changed. Should never occur.
  end
  else                                            // Flags have not changed
    inherited SetFlags(Value);
  if RowSizing <> nil then
  begin
    RowSizing.Sizable := Multiline;               // Update sizable state
    if not Multiline then
      RowSizing.SizingFactor := irsNoReSize
    else
      RowSizing.SizingFactor := irsValueHeight;
  end;
end;

//=== TInstanceItem ==========================================================

type
  TInstanceItem = class(TObject)
  public
    Instance: TObject;
    Methods: TStrings;
    MethodStartIdx: Integer;
    Item: TppJvInspectorTMethodItem;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure AddMethod(const Name: string; const MethodAddr: Pointer);
    procedure DeleteMethod(const Name: string); overload;
    procedure DeleteMethod(const MethodAddr: Pointer); overload;
    procedure DeleteMethod(const Index: Integer); overload;
    procedure Clear;
    function IndexOf(const Name: string): Integer; overload;
    function IndexOf(const MethodAddr: Pointer): Integer; overload;
  end;

procedure TInstanceItem.AfterConstruction;
begin
  inherited AfterConstruction;
  Methods := TStringList.Create;
end;

procedure TInstanceItem.BeforeDestruction;
begin
  Methods.Free;
  inherited BeforeDestruction; 
end;

procedure TInstanceItem.AddMethod(const Name: string; const MethodAddr: Pointer);
var
  I: Integer;
begin
  I := Methods.IndexOf(Name);
  if I = -1 then
  begin
    I := Methods.IndexOfObject(TObject(MethodAddr));
    if I = -1 then
    begin
      Methods.AddObject(Name, TObject(MethodAddr));
      I := Item.FList.IndexOfObject(Self) + 1;
      while I < Item.InstanceCount do
      begin
        Inc(TInstanceItem(Item.FList.Objects[I]).MethodStartIdx);
        Inc(I);
      end;
    end
    else
      Methods[I] := Name;
  end
  else
    Methods.Objects[I] := TObject(MethodAddr);
end;

procedure TInstanceItem.DeleteMethod(const Name: string);
var
  I: Integer;
begin
  I := Methods.IndexOf(Name);
  if I <> -1 then
    DeleteMethod(I); 
end;

procedure TInstanceItem.DeleteMethod(const MethodAddr: Pointer);
var
  I: Integer;
begin
  I := Methods.IndexOfObject(TObject(MethodAddr));
  if I <> -1 then
    DeleteMethod(I);
end;

procedure TInstanceItem.DeleteMethod(const Index: Integer);
begin
  Methods.Delete(Index);
end;

procedure TInstanceItem.Clear;
begin
  Methods.Clear;
end;

function TInstanceItem.IndexOf(const Name: string): Integer;
begin
  Result := Methods.IndexOf(Name);
end;

function TInstanceItem.IndexOf(const MethodAddr: Pointer): Integer;
begin
  Result := Methods.IndexOfObject(TObject(MethodAddr));
end;

//=== TppJvInspectorTMethodItem ================================================

function TppJvInspectorTMethodItem.GetInstanceCount: Integer;
begin
  Result := FList.Count;
end;

function TppJvInspectorTMethodItem.GetInstances(I: Integer): TObject;
begin
  Result := TInstanceItem(FList.Objects[I]).Instance;
end;

function TppJvInspectorTMethodItem.GetInstanceNames(I: Integer): string;
begin
  Result := FList[I];
end;

function TppJvInspectorTMethodItem.GetItemTMethodFlags: TInspectorTMethodFlags;
begin
  Result := FItemTMethodFlags;
end;

function TppJvInspectorTMethodItem.GetKeepFirstInstanceAsFirst: Boolean;
begin
  Result := imfKeepFirstInstanceAsFirst in FItemTMethodFlags;
end;

function TppJvInspectorTMethodItem.GetMethodCount(Instance: TObject): Integer;
begin
  Result := IndexOfInstance(Instance);
  if Result > -1 then
    Result := TInstanceItem(FList.Objects[Result]).Methods.Count
  else
    Result := 0;
end;

function TppJvInspectorTMethodItem.GetMethods(Instance: TObject; I: Integer): TMethod;
var
  Idx: Integer;
begin
  Idx := IndexOfInstance(Instance);
  if Idx > -1 then
  begin
    Result.Data := Instance;
    Result.COde := TInstanceItem(FList.Objects[Idx]).Methods.Objects[I];
  end;
end;

function TppJvInspectorTMethodItem.GetMethodNames(Instance: TObject; I: Integer): string;
var
  Idx: Integer;
begin
  Idx := IndexOfInstance(Instance);
  if Idx > -1 then
    Result := TInstanceItem(FList.Objects[Idx]).Methods[I];
end;

function TppJvInspectorTMethodItem.GetNoShowFirstInstanceName: Boolean;
begin
  Result := imfNoShowFirstInstanceName in FItemTMethodFlags;
end;

function TppJvInspectorTMethodItem.GetShowInstanceNames: Boolean;
begin
  Result := imfShowInstanceNames in FItemTMethodFlags;
end;

function TppJvInspectorTMethodItem.GetSortMethods: Boolean;
begin
  Result := imfSortMethods in FItemTMethodFlags;
end;

function TppJvInspectorTMethodItem.GetSortInstances: Boolean;
begin
  Result := imfSortInstances in FItemTMethodFlags;
end;

procedure TppJvInspectorTMethodItem.SetItemTMethodFlags(Value: TInspectorTMethodFlags);
begin
  if ItemTMethodFlags <> Value then
  begin
    FItemTMethodFlags := Value;
    InvalidateMetaData;
  end;
end;

procedure TppJvInspectorTMethodItem.SetKeepFirstInstanceAsFirst(Value: Boolean);
begin
  if Value then
    ItemTMethodFlags := ItemTMethodFlags + [imfKeepFirstInstanceAsFirst]
  else
    ItemTMethodFlags := ItemTMethodFlags - [imfKeepFirstInstanceAsFirst];
end;

procedure TppJvInspectorTMethodItem.SetNoShowFirstInstanceName(Value: Boolean);
begin
  if Value then
    ItemTMethodFlags := ItemTMethodFlags + [imfNoShowFirstInstanceName]
  else
    ItemTMethodFlags := ItemTMethodFlags - [imfNoShowFirstInstanceName];
end;

procedure TppJvInspectorTMethodItem.SetShowInstanceNames(Value: Boolean);
begin
  if Value then
    ItemTMethodFlags := ItemTMethodFlags + [imfShowInstanceNames]
  else
    ItemTMethodFlags := ItemTMethodFlags - [imfShowInstanceNames];
end;

procedure TppJvInspectorTMethodItem.SetSortMethods(Value: Boolean);
begin
  if Value then
    ItemTMethodFlags := ItemTMethodFlags + [imfSortMethods]
  else
    ItemTMethodFlags := ItemTMethodFlags - [imfSortMethods];
end;

procedure TppJvInspectorTMethodItem.SetSortInstances(Value: Boolean);
begin
  if Value then
    ItemTMethodFlags := ItemTMethodFlags + [imfSortInstances]
  else
    ItemTMethodFlags := ItemTMethodFlags - [imfSortInstances];
end;

procedure TppJvInspectorTMethodItem.AddInstancePrim(const Instance: TObject; const InstanceName: string);
var
  IdxInst: Integer;
  IdxName: Integer;
begin
  IdxInst := IndexOfInstance(Instance);
  IdxName := IndexOfInstance(InstanceName);
  if (IdxInst <> -1) and (IdxInst <> IdxName) then
    raise EppJvInspectorItem.Create('Instance already exists with another name.');
  if (IdxName <> -1) and (IdxInst <> IdxName) then
    raise EppJvInspectorItem.Create('Name already exists for another instance.');
  if IdxInst = -1 then
  begin
    IdxInst := FList.AddObject(InstanceName, TInstanceItem.Create);
    TInstanceItem(FList.Objects[IdxInst]).Instance := Instance;
    TInstanceItem(FList.Objects[IdxInst]).Item := Self;
  end;
end;

procedure TppJvInspectorTMethodItem.AddMethodPrim(const Instance: TObject; const MethodAddr: Pointer; const MethodName: string);
var
  InstIdx: Integer;
  InstItem: TInstanceItem;
  MethodIdx: Integer;
  MethodNameIdx: Integer;
begin
  InstIdx := IndexOfInstance(Instance);
  if InstIdx = -1 then
    raise EppJvInspectorItem.Create('Instance does not exist.');
  InstItem := TInstanceItem(FList.Objects[InstIdx]);
  MethodIdx := InstItem.IndexOf(MethodAddr);
  MethodNameIdx := InstItem.IndexOf(MethodName);
  if (MethodIdx <> -1) and (MethodNameIdx <> MethodIdx) then
    raise EppJvInspectorItem.Create('Method already exists with another name.');
  if (MethodNameIdx <> -1) and (MethodNameIdx <> MethodIdx) then
    raise EppJvInspectorItem.Create('Name already exists for another method.');
  if MethodIdx = -1 then
    InstItem.AddMethod(MethodName, MethodAddr);
end;

function TppJvInspectorTMethodItem.MethodFromName(const Name: string): TMethod;
var
  IPeriod: Integer;
  InstIdx: Integer;
  MethodIdx: Integer;
begin
  IPeriod := Pos('.', Name);
  if IPeriod > 0 then
    InstIdx := IndexOfInstance(Copy(Name, 1, IPeriod - 1))
  else
    InstIdx := 0;
  if InstIdx < 0 then
  begin
    Result.Data := nil;
    Result.Code := nil;
  end
  else
  begin
    MethodIdx := IndexOfMethod(InstIdx, Copy(Name, IPeriod + 1, Length(Name) - IPeriod));
    if MethodIdx < 0 then
    begin
      Result.Data := nil;
      Result.Code := nil;
    end
    else
      Result := Methods[Instances[InstIdx], MethodIdx];
  end;
end;

function TppJvInspectorTMethodItem.MethodFromAbsIndex(const Idx: Integer): TMethod;
var
  InstIdx: Integer;
  InstItem: TInstanceItem;
begin
  Result.Data := nil;
  Result.Code := nil;
  InstIdx := InstanceCount - 1;
  repeat
    InstItem := TInstanceItem(FList.Objects[InstIdx]);
    if InstItem.MethodStartIdx <= Idx then
    begin
      Result.Data := InstItem.Instance;
      Result.Code := InstItem.Methods.Objects[Idx - InstItem.MethodStartIdx];
      Break;
    end;
  until False;
end;

function TppJvInspectorTMethodItem.NameFromMethod(const Method: TMethod): string;
var
  Instance: TObject;
  InstanceIdx: Integer;
  MethodIdx: Integer;
begin
  Instance := Method.Data;
  InstanceIdx := IndexOfInstance(Instance);
  MethodIdx :=IndexOfMethod(Method);
  Result := '';
  if (InstanceIdx <> -1) and (MethodIdx <> -1) then
  begin
    if ShowInstanceNames and ((InstanceIdx > 0) or not NoShowFirstInstanceName) then
      Result := InstanceNames[InstanceIdx] + '.';
    Result := Result + MethodNames[Instance, MethodIdx];
  end;
end;

function TppJvInspectorTMethodItem.AbsIndexFromMethod(const Method: TMethod): Integer;
var
  InstIdx: Integer;
  MethodIdx: Integer;
begin
  InstIdx := IndexOfInstance(TObject(Method.Data));
  if InstIdx > -1 then
  begin
    MethodIdx := TInstanceItem(FList.Objects[InstIdx]).IndexOf(Method.Code);
    if MethodIdx > -1 then
      Result := TInstanceItem(FList.Objects[InstIdx]).MethodStartIdx + MethodIdx
    else
      Result := -1;
  end
  else
    Result := -1;
end;

function TppJvInspectorTMethodItem.GetDisplayValue: string;
begin
  if Data.SupportsMethodPointers then
    Result := NameFromMethod(Data.AsMethod)
  else
    Result := Data.GetAsString;
end;

procedure TppJvInspectorTMethodItem.GetValueList(const Strings: TStrings);
var
  SL: TStringList;
  InstanceList: TStringList;
  I: Integer;
  CurInstance: TInstanceItem;
  PrefixWithInstance: string;
  J: Integer;
begin
  SL := TStringList.Create;
  try
    InstanceList := TStringList.Create;
    try
      for I := 0 to InstanceCount - 1 do
        InstanceList.AddObject(InstanceNames[I], FList.Objects[I]);
      if SortInstances then
        InstanceList.Sort;
      if (InstanceCount > 0) and KeepFirstInstanceAsFirst then
      begin
        I := InstanceList.IndexOfObject(FList.Objects[0]);
        if I > 0 then
        begin
          InstanceList.Delete(I);
          InstanceList.InsertObject(0, InstanceNames[0], FList.Objects[0]);
        end;
      end;
      for I := 0 to InstanceCount - 1 do
      begin
        SL.Clear;
        CurInstance := TInstanceItem(InstanceList.Objects[I]);
        if ShowInstanceNames and ((I > 0) or not NoShowFirstInstanceName) then
          PrefixWithInstance := InstanceList[I] + '.'
        else
          PrefixWithInstance := '';
        for J := 0 to CurInstance.Methods.Count - 1 do
          SL.AddObject(PrefixWithInstance + CurInstance.Methods[J], TObject(CurInstance.MethodStartIdx + J));
        if SL.Count > 0 then
        begin
          if SortMethods then
            SL.Sort;
          Strings.AddStrings(SL);
        end;
      end;
      SL.Clear;
      inherited GetValueList(SL);
      if SortMethods then
        SL.Sort;
      if SL.Count > 0 then
        Strings.AddStrings(SL);
    finally
      InstanceList.Free;
    end;
  finally
    SL.Free;
  end;
end;

procedure TppJvInspectorTMethodItem.SetDisplayValue(const Value: string);
var
  M: TMethod;
begin
  M := MethodFromName(Value);
  if Data.SupportsMethodPointers then
    Data.AsMethod := M
  else
    Data.AsString := NameFromMethod(M);
end;

procedure TppJvInspectorTMethodItem.SetFlags(const Value: TInspectorItemFlags);
begin
  inherited SetFlags(Value + [iifValueList]);
end;

procedure TppJvInspectorTMethodItem.AfterConstruction;
begin
  inherited AfterConstruction;
  FList := TStringList.Create;
  ItemTMethodFlags := [imfShowInstanceNames, imfNoShowFirstInstanceName,
    imfKeepFirstInstanceAsFirst, imfSortInstances, imfSortMethods];
end;

procedure TppJvInspectorTMethodItem.BeforeDestruction;
begin
  ClearInstances;
  FreeAndNil(FList);
  inherited BeforeDestruction;
end;

procedure TppJvInspectorTMethodItem.AddInstance(const Instance: TObject; const InstanceName: string);
begin
  AddInstancePrim(Instance, InstanceName);
end;

procedure TppJvInspectorTMethodItem.AddMethod(const Method: TMethod; const MethodName: string);
begin
  AddMethodPrim(TObject(Method.Data), Method.Code, MethodName);
end;

procedure TppJvInspectorTMethodItem.AddMethod(const Instance: TObject; MethodAddr: Pointer;
  const MethodName: string);
begin
  AddMethodPrim(Instance, MethodAddr, MethodName);
end;

procedure TppJvInspectorTMethodItem.DeleteInstance(const Index: Integer);
var
  InstItem: TInstanceItem;
begin
  InstItem := TInstanceItem(FList.Objects[Index]);
  InstItem.Free;
  FList.Delete(Index);
end;

procedure TppJvInspectorTMethodItem.DeleteInstance(const Instance: TObject);
var
  Idx: Integer;
begin
  Idx := IndexOfInstance(Instance);
  if Idx > -1 then
    DeleteInstance(Idx)
  else
    raise EppJvInspectorItem.Create('Instance does not exist.');
end;

procedure TppJvInspectorTMethodItem.DeleteInstance(const InstanceName: string);
var
  Idx: Integer;
begin
  Idx := IndexOfInstance(InstanceName);
  if Idx > -1 then
    DeleteInstance(Idx)
  else
    raise EppJvInspectorItem.CreateFmt('Instance named ''%s'' does not exist.', [InstanceName]);
end;

procedure TppJvInspectorTMethodItem.DeleteMethod(const Method: TMethod);
var
  InstIdx: Integer;
  InstItem: TInstanceItem;
  MethodIdx: Integer;
begin
  InstIdx := IndexOfInstance(TObject(Method.Data));
  if InstIdx > -1 then
  begin
    InstItem := TInstanceItem(FList.Objects[InstIdx]);
    MethodIdx := InstItem.IndexOf(Method.Code);
    if MethodIdx > -1 then
      InstItem.DeleteMethod(MethodIdx)
    else
      raise EppJvInspectorItem.Create('Method does not exist.');
  end
  else
    raise EppJvInspectorItem.Create('Instance does not exist.');
end;

procedure TppJvInspectorTMethodItem.DeleteMethod(const InstanceIndex: Integer; const Index: Integer);
begin
  TInstanceItem(FList.Objects[InstanceIndex]).DeleteMethod(Index);
end;

procedure TppJvInspectorTMethodItem.DeleteMethod(const Instance: TObject; const Index: Integer);
var
  InstIdx: Integer;
begin
  InstIdx := IndexOfInstance(Instance);
  if InstIdx > -1 then
    DeleteMethod(InstIdx, Index)
  else
    raise EppJvInspectorItem.Create('Instance does not exist.');
end;

procedure TppJvInspectorTMethodItem.DeleteMethod(const InstanceName: string; const Index: Integer);
var
  InstIdx: Integer;
begin
  InstIdx := IndexOfInstance(InstanceName);
  if InstIdx > -1 then
    DeleteMethod(InstIdx, Index)
  else
    raise EppJvInspectorItem.CreateFmt('Instance named ''%s'' does not exist.', [InstanceName]);
end;

procedure TppJvInspectorTMethodItem.DeleteMethod(const InstanceIndex: Integer; const MethodName: string);
var
  MethodIdx: Integer;
begin
  MethodIdx := TInstanceItem(FList.Objects[InstanceIndex]).IndexOf(MethodName);
  if MethodIdx > -1 then
    DeleteMethod(InstanceIndex, MethodIdx)
  else
    raise EppJvInspectorItem.CreateFmt('Method named ''%s'' does not exist.', [MethodName]);
end;

procedure TppJvInspectorTMethodItem.DeleteMethod(const Instance: TObject; const MethodName: string);
var
  InstIdx: Integer;
begin
  InstIdx := IndexOfInstance(Instance);
  if InstIdx > -1 then
    DeleteMethod(InstIdx, MethodName)
  else
    raise EppJvInspectorItem.Create('Instance does not exist.');
end;

procedure TppJvInspectorTMethodItem.DeleteMethod(const InstanceName: string; const MethodName: string);
var
  InstIdx: Integer;
begin
  InstIdx := IndexOfInstance(InstanceName);
  if InstIdx > -1 then
    DeleteMethod(InstIdx, MethodName)
  else
    raise EppJvInspectorItem.CreateFmt('Instance named ''%s'' does not exist.', [InstanceName]);
end;

procedure TppJvInspectorTMethodItem.ClearInstances;
var
  I: Integer;
begin
  for I := InstanceCount - 1 downto 0 do
    DeleteInstance(I);
end;

procedure TppJvInspectorTMethodItem.ClearMethods(const InstanceIndex: Integer);
begin
  TInstanceItem(FList.Objects[InstanceIndex]).Clear;
end;

procedure TppJvInspectorTMethodItem.ClearMethods(const Instance: TObject);
var
  InstIdx: Integer;
begin
  InstIdx := IndexOfInstance(Instance);
  if InstIdx > -1 then
    ClearMethods(InstIdx)
  else
    raise EppJvInspectorItem.Create('Instance does not exist.');
end;

procedure TppJvInspectorTMethodItem.ClearMethods(const InstanceName: string);
var
  InstIdx: Integer;
begin
  InstIdx := IndexOfInstance(InstanceName);
  if InstIdx > -1 then
    ClearMethods(InstIdx)
  else
    raise EppJvInspectorItem.CreateFmt('Instance named ''%s'' does not exist.', [InstanceName]);
end;

function TppJvInspectorTMethodItem.IndexOfInstance(const Instance: TObject): Integer;
begin
  Result := InstanceCount - 1;
  while (Result >= 0) and (TInstanceItem(FList.Objects[Result]).Instance <> Instance) do
    Dec(Result);
end;

function TppJvInspectorTMethodItem.IndexOfInstance(const InstanceName: string): Integer;
begin
  Result := InstanceCount - 1;
  while (Result >= 0) and not AnsiSameText(FList[Result], InstanceName) do
    Dec(Result);
end;

function TppJvInspectorTMethodItem.IndexOfMethod(const Method: TMethod): Integer;
begin
  Result := IndexOfInstance(TObject(Method.Data));
  if Result > -1 then
    Result := TInstanceItem(FList.Objects[Result]).IndexOf(Method.Code);
end;

function TppJvInspectorTMethodItem.IndexOfMethod(const InstanceIndex: Integer; const MethodName: string): Integer;
begin
  Result := TInstanceItem(FList.Objects[InstanceIndex]).IndexOf(MethodName);
end;

function TppJvInspectorTMethodItem.IndexOfMethod(const Instance: TObject; const MethodName: string): Integer;
begin
  Result := IndexOfInstance(Instance);
  if Result > -1 then
    Result := IndexOfMethod(Result, MethodName);
end;

function TppJvInspectorTMethodItem.IndexOfMethod(const InstanceName: string; const MethodName: string): Integer;
begin
  Result := IndexOfInstance(InstanceName);
  if Result > -1 then
    Result := IndexOfMethod(Result, MethodName);
end;

//=== TppJvCustomInspectorData =================================================

constructor TppJvCustomInspectorData.CreatePrim(const AName: string;
  const ATypeInfo: PTypeInfo);
begin
  inherited Create;
  Name := AName;
  TypeInfo := ATypeInfo;
end;

procedure TppJvCustomInspectorData.CheckReadAccess;
begin
  if not IsInitialized then
    raise EppJvInspectorData.Create(sppJvInspDataNotInit);
  if not IsAssigned then
    raise EppJvInspectorData.Create(sppJvInspDataNotAssigned);
  if not HasValue then
    raise EppJvInspectorData.Create(sppJvInspDataNoValue);
end;

procedure TppJvCustomInspectorData.CheckWriteAccess;
begin
  if not IsInitialized then
    raise EppJvInspectorData.Create(sppJvInspDataNotInit);
  if not HasValue then
    raise EppJvInspectorData.Create(sppJvInspDataNoValue);
end;

procedure TppJvCustomInspectorData.DoDataChanged;
begin
  if Assigned(FOnValueChanged) then
    FOnValueChanged(Self);
end;

procedure TppJvCustomInspectorData.DoneEdits(const CancelEdits: Boolean = False);
var
  I: Integer;
begin
  for I := Low(FItems) to High(FItems) do
    if Items[I].Editing then
      Items[I].DoneEdit(CancelEdits);
end;

function TppJvCustomInspectorData.GetItemCount: Integer;
begin
  Result := Length(FItems);
end;

function TppJvCustomInspectorData.GetItems(I: Integer): TppJvCustomInspectorItem;
begin
  if (I < Low(FItems)) or (I > High(FItems)) then
    TList.Error(SListIndexError, I);
  Result := FItems[I];
end;

function TppJvCustomInspectorData.GetName: string;
begin
  Result := FName;
end;

function TppJvCustomInspectorData.GetTypeInfo: PTypeInfo;
begin
  Result := FTypeInfo;
end;

procedure TppJvCustomInspectorData.InitEdits;
var
  I: Integer;
begin
  for I := Low(FItems) to High(FItems) do
    if Items[I].Inspector.FocusedItem = Items[I] then
      Items[I].InitEdit;
end;

procedure TppJvCustomInspectorData.Invalidate;
var
  I: Integer;
begin
  for I := High(FItems) downto Low(FItems) do
    FItems[I].InvalidateItem;
end;

procedure TppJvCustomInspectorData.InvalidateData;
var
  InspList: TList;
  I: Integer;
begin
  InspList := TList.Create;
  try
    // Fill list with unique inspector instances for this data instance
    for I := Low(FItems) to High(FItems) do
      if (FItems[I].Inspector <> nil) and (InspList.IndexOf(FItems[I].Inspector) = -1) then
        InspList.Add(FItems[I].Inspector);
    // Generate data changed event on this data instance
    DoDataChanged;
    // Generate data changed events on the inspectors that have a link to this data instance
    for I := 0 to InspList.Count - 1 do
      TppJvCustomInspector(InspList[I]).DoDataValueChanged(Self);

    // Generate item changed events for all items for this data instance
    for I := Low(FItems) to High(FItems) do
      FItems[I].InvalidateValue;
  finally
    InspList.Free;
  end;
end;

function TppJvCustomInspectorData.IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean;
begin
  Result := False;
end;

procedure TppJvCustomInspectorData.NotifyRemoveData(const Instance: TppJvCustomInspectorData);
begin
end;

procedure TppJvCustomInspectorData.RefreshEdits;
var
  I: Integer;
begin
  for I := High(FItems) downto Low(FItems) do
    if Items[I].Editing then
    begin
      Items[I].DoneEdit(True);
      Items[I].InitEdit;
    end;
end;

class function TppJvCustomInspectorData.RegisterInstance(const Instance: TppJvCustomInspectorData): TppJvCustomInspectorData;
begin
  Result := DataRegister.Add(Instance);
end;

procedure TppJvCustomInspectorData.RemoveItem(const Item: TppJvCustomInspectorItem);
var
  I: Integer;
begin
  I := High(FItems);
  while (I >= 0) do
  begin
    if Items[I] = Item then
      Break;
    Dec(I);
  end;
  if I >= 0 then
  begin
    if I <> High(FItems) then
      Move(FItems[I + 1], FITems[I], (Length(FItems) - I) * SizeOf(TppJvCustomInspectorItem));
    SetLength(FItems, High(FItems));
  end;
end;

procedure TppJvCustomInspectorData.SetName(const Value: string);
begin
  if Value <> Name then
  begin
    FName := Value;
    Invalidate;
  end;
end;

procedure TppJvCustomInspectorData.SetTypeInfo(const Value: PTypeInfo);
begin
  if Value <> TypeInfo then
  begin
    FTypeInfo := Value;
    Invalidate;
  end;
end;

function TppJvCustomInspectorData.SupportsMethodPointers: Boolean;
begin
  Result := False;
end;

constructor TppJvCustomInspectorData.Create;
begin
  raise EppJvInspectorData.Create(ClassName + ' cannot be created separately.');
end;

procedure TppJvCustomInspectorData.BeforeDestruction;
var
  I: Integer;
begin
  for I := High(FItems) downto Low(FItems) do
    Items[I].Free;
  if FRegistered then
    DataRegister.Remove(Self);
end;

class function TppJvCustomInspectorData.ItemRegister: TppJvInspectorRegister;
begin
  if FGenItemReg = nil then
    FGenItemReg := TppJvInspectorRegister.Create(TppJvCustomInspectorData);
  Result := FGenItemReg;
end;

class function TppJvCustomInspectorData.New: TppJvCustomInspectorData;
begin
  raise EppJvInspectorData.Create(ClassName + ' does not allow a new instance to be created.');
end;

function TppJvCustomInspectorData.NewItem(
  const AParent: TppJvCustomInspectorItem): TppJvCustomInspectorItem;
var
  ItemClass: TppJvInspectorItemClass;
  RegItem: TppJvCustomInspectorRegItem;
begin
  Result := nil;
  RegItem := ItemRegister.FindMatch(Self);
  if RegItem <> nil then
  begin
    ItemClass := RegItem.ItemClass;
    AParent.Inspector.DoBeforeItemCreate(Self, ItemClass);
    if ItemClass <> nil then
    begin
      Result := ItemClass.Create(AParent, Self);
      if Result <> nil then
      begin
        RegItem.ApplyDefaults(Result);
        SetLength(FItems, Length(FItems) + 1);
        FItems[High(FItems)] := Result;
      end;
    end;
  end;
end;

//=== TppJvInspectorVarData ====================================================

function TppJvInspectorVarData.GetAddress: Pointer;
begin
  Result := FAddress;
end;

function TppJvInspectorVarData.GetAsFloat: Extended;
begin
  CheckReadAccess;
  if TypeInfo.Kind = tkFloat then
    case GetTypeData(TypeInfo).FloatType of
      ftSingle:
        Result := PSingle(Address)^;
      ftDouble:
        Result := PDouble(Address)^;
      ftExtended:
        Result := PExtended(Address)^;
      ftComp:
        Result := PComp(Address)^;
      ftCurr:
        Result := PCurrency(Address)^;
    else
      Result := 0;
    end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Float']);
end;

function TppJvInspectorVarData.GetAsInt64: Int64;
begin
  CheckReadAccess;
  if TypeInfo.Kind = tkInt64 then
    Result := PInt64(Address)^
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Int64']);
end;

function TppJvInspectorVarData.GetAsMethod: TMethod;
begin
  CheckReadAccess;
  if TypeInfo.Kind = tkMethod then
    Result := PMethod(Address)^
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['TMethod']);
end;

function TppJvInspectorVarData.GetAsOrdinal: Int64;
begin
  CheckReadAccess;
  if TypeInfo.Kind in [tkInteger, tkChar, tkEnumeration, tkSet, tkWChar] then
  begin
    case GetTypeData(TypeInfo).OrdType of
      otSByte:
        Result := PShortint(Address)^;
      otUByte:
        Result := PByte(Address)^;
      otSWord:
        Result := PSmallint(Address)^;
      otUWord:
        Result := PWord(Address)^;
      otSLong:
        Result := PLongint(Address)^;
      otULong:
        Result := PLongword(Address)^;
    else
      Result := 0;
    end;
  end
  else
  if TypeInfo.Kind = tkClass then
    Result := PLongword(Address)^
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Ordinal']);
end;

function TppJvInspectorVarData.GetAsString: string;
begin
  CheckReadAccess;
  if TypeInfo.Kind in cStringTypeKinds then
  begin
    case TypeInfo.Kind of
{$IFDEF Delphi12}
      tkLString, tkUString:
{$ELSE}
       tkLString:
{$ENDIF}
        Result := PString(Address)^;
      tkWString:
        Result := PWideString(Address)^;
      tkString:
        Result := String(PShortString(Address)^);
    else
      Result := '';
    end;
  end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['String']);
end;

function TppJvInspectorVarData.IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean;
begin
  Result := (Ref is TppJvInspectorVarData) and (TppJvInspectorVarData(Ref).Address = Address);
end;
 
procedure TppJvInspectorVarData.SetAddress(const Value: Pointer);
begin
  if Value <> Address then
  begin
    FAddress := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorVarData.SetAsFloat(const Value: Extended);
begin
  CheckWriteAccess;
  if TypeInfo.Kind = tkFloat then
  begin
    case GetTypeData(TypeInfo).FloatType of
      ftSingle:
        PSingle(Address)^ := Value;
      ftDouble:
        PDouble(Address)^ := Value;
      ftExtended:
        PExtended(Address)^ := Value;
      ftComp:
        PComp(Address)^ := Value;
      ftCurr:
        PCurrency(Address)^ := Value;
    end;
    InvalidateData;
    Invalidate;
  end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Float']);
end;

procedure TppJvInspectorVarData.SetAsInt64(const Value: Int64);
begin
  CheckWriteAccess;
  if TypeInfo.Kind = tkInt64 then
  begin
    if (Value < GetTypeData(TypeInfo).MinInt64Value) or
        (Value > GetTypeData(TypeInfo).MaxInt64Value) then
      raise ERangeError.CreateFmt(SOutOfRange, [GetTypeData(TypeInfo).MinValue,
        GetTypeData(TypeInfo).MaxValue]);
    PInt64(Address)^ := Value;
    InvalidateData;
    Invalidate;
  end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Int64']);
end;

procedure TppJvInspectorVarData.SetAsMethod(const Value: TMethod);
begin
  CheckWriteAccess;
  if TypeInfo.Kind = tkMethod then
    PMethod(Address)^ := Value
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['TMethod']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorVarData.SetAsOrdinal(const Value: Int64);
var
  MinValue: Int64;
  MaxValue: Int64;
begin
  CheckWriteAccess;
  if TypeInfo.Kind in [tkInteger, tkChar, tkEnumeration, tkWChar] then
  begin
    case GetTypeData(TypeInfo).OrdType of
      otSByte:
        begin
          MinValue := GetTypeData(TypeInfo).MinValue;
          MaxValue := GetTypeData(TypeInfo).MaxValue;
          if (Value < MinValue) or (Value > MaxValue) then
            raise ERangeError.CreateFmt(SOutOfRange, [MinValue, MaxValue]);
          PShortint(Address)^ := Value;
        end;
      otUByte:
        begin
          MinValue := GetTypeData(TypeInfo).MinValue;
          MaxValue := GetTypeData(TypeInfo).MaxValue;
          if (Value < MinValue) or (Value > MaxValue) then
            raise ERangeError.CreateFmt(SOutOfRange, [MinValue, MaxValue]);
          PByte(Address)^ := Value;
        end;
      otSWord:
        begin
          MinValue := GetTypeData(TypeInfo).MinValue;
          MaxValue := GetTypeData(TypeInfo).MaxValue;
          if (Value < MinValue) or (Value > MaxValue) then
            raise ERangeError.CreateFmt(SOutOfRange, [MinValue, MaxValue]);
          PSmallint(Address)^ := Value;
        end;
      otUWord:
        begin
          MinValue := GetTypeData(TypeInfo).MinValue;
          MaxValue := GetTypeData(TypeInfo).MaxValue;
          if (Value < MinValue) or (Value > MaxValue) then
            raise ERangeError.CreateFmt(SOutOfRange, [MinValue, MaxValue]);
          PWord(Address)^ := Value;
        end;
      otSLong:
        begin
          MinValue := GetTypeData(TypeInfo).MinValue;
          MaxValue := GetTypeData(TypeInfo).MaxValue;
          if (Value < MinValue) or (Value > MaxValue) then
            raise ERangeError.CreateFmt(SOutOfRange, [MinValue, MaxValue]);
          PLongint(Address)^ := Value;
        end;
      otULong:
        begin
          MinValue := Longword(GetTypeData(TypeInfo).MinValue);
          MaxValue := Longword(GetTypeData(TypeInfo).MaxValue);
          if (Value < MinValue) or (Value > MaxValue) then
            raise ERangeError.CreateFmt(SOutOfRange, [MinValue, MaxValue]);
          PLongword(Address)^ := Value;
        end;
    end;
  end
  else
  if TypeInfo.Kind = tkClass then
    PLongword(Address)^ := Value
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Ordinal']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorVarData.SetAsString(const Value: string);
begin
  CheckWriteAccess;
  if TypeInfo.Kind in cStringTypeKinds then
  begin
    case TypeInfo.Kind of
{$IFDEF Delphi12}
      tkLString, tkUString:
{$ELSE}
       tkLString:
{$ENDIF}
        PString(Address)^ := Value;
      tkWString:
        PWideString(Address)^ := Value;
      tkString:
        if Length(Value) < GetTypeData(TypeInfo).MaxLength then
          PShortString(Address)^ := ShortString(Value)
        else
          raise EppJvInspectorData.Create(sppJVInspDataStrTooLong);
    end;
    InvalidateData;
    Invalidate;
  end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['String']);
end;

function TppJvInspectorVarData.SupportsMethodPointers: Boolean;
begin
  Result := True;
end;

procedure TppJvInspectorVarData.GetAsSet(var Buf);
var
  CompType: PTypeInfo;
  EnumMin: Integer;
  EnumMax: Integer;
  ResBytes: Integer;
begin
  CheckReadAccess;
  if TypeInfo.Kind = tkSet then
  begin
    CompType := GetTypeData(TypeInfo).CompType^;
    EnumMin := GetTypeData(CompType).MinValue;
    EnumMax := GetTypeData(CompType).MaxValue;
    ResBytes := (EnumMax div 8) - (EnumMin div 8) + 1;
    Move(PChar(Address)[0], Buf, ResBytes);
  end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Set']);
end;

function TppJvInspectorVarData.HasValue: Boolean;
begin
  Result := IsInitialized;
end;

function TppJvInspectorVarData.IsAssigned: Boolean;
begin
  Result := IsInitialized;
end;

function TppJvInspectorVarData.IsInitialized: Boolean;
begin
  Result := (TypeInfo <> nil) and (Address <> nil);
end;

class function TppJvInspectorVarData.ItemRegister: TppJvInspectorRegister;
begin
  if FVarItemReg = nil then
    FVarItemReg := TppJvInspectorRegister.Create(TppJvInspectorVarData);
  Result := FVarItemReg;
end;

class function TppJvInspectorVarData.New(const AParent: TppJvCustomInspectorItem; const AName: string; const ATypeInfo: PTypeInfo; const AAddress: Pointer): TppJvCustomInspectorItem;
var
  Data: TppJvInspectorVarData;
begin
  Data := CreatePrim(AName, ATypeInfo);
  Data.FAddress := AAddress;
  Data := TppJvInspectorVarData(DataRegister.Add(Data));
  if Data <> nil then
    Result := Data.NewItem(AParent)
  else
    Result := nil;
end;

class function TppJvInspectorVarData.New(const AParent: TppJvCustomInspectorItem; const AName: string; const ATypeInfo: PTypeInfo; const AVar): TppJvCustomInspectorItem;
begin
  Result := New(AParent, AName, ATypeInfo, Addr(AVar));
end;

procedure TppJvInspectorVarData.SetAsSet(const Buf);
var
  CompType: PTypeInfo;
  EnumMin: Integer;
  EnumMax: Integer;
  ResBytes: Integer;
begin
  CheckWriteAccess;
  if TypeInfo.Kind = tkSet then
  begin
    CompType := GetTypeData(TypeInfo).CompType^;
    EnumMin := GetTypeData(CompType).MinValue;
    EnumMax := GetTypeData(CompType).MaxValue;
    ResBytes := (EnumMax div 8) - (EnumMin div 8) + 1;
    Move(Buf, PChar(Address)[0], ResBytes);
    InvalidateData;
    Invalidate;
  end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Set']);
end;

//=== TppJvInspectorPropData ===================================================

function TppJvInspectorPropData.GetAsFloat: Extended;
begin
  CheckReadAccess;
  if Prop.PropType^.Kind = tkFloat then
    Result := GetFloatProp(Instance, Prop)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Float']);
end;

function TppJvInspectorPropData.GetAsInt64: Int64;
begin
  CheckReadAccess;
  if Prop.PropType^.Kind = tkInt64 then
    Result := GetInt64Prop(Instance, Prop)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Int64']);
end;

function TppJvInspectorPropData.GetAsMethod: TMethod;
begin
  CheckReadAccess;
  if Prop.PropType^.Kind = tkMethod then
    Result := GetMethodProp(Instance, Prop)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Method']);
end;

function TppJvInspectorPropData.GetAsOrdinal: Int64;
begin
  CheckReadAccess;
  if Prop.PropType^.Kind in [tkInteger, tkChar, tkEnumeration, tkSet,
    tkWChar, tkClass] then
  begin
    if GetTypeData(Prop.PropType^).OrdType = otULong then
      Result := Cardinal(GetOrdProp(Instance, Prop))
    else
      Result := GetOrdProp(Instance, Prop);
  end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Ordinal']);
end;

function TppJvInspectorPropData.GetAsString: string;
begin
  CheckReadAccess;
  if Prop.PropType^.Kind in cStringTypeKinds then
    Result := GetStrProp(Instance, Prop)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['String']);
end;

function TppJvInspectorPropData.GetInstance: TObject;
begin
  Result := FInstance;
end;

function TppJvInspectorPropData.GetProp: PPropInfo;
begin
  Result := FProp;
end;

function TppJvInspectorPropData.IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean;
begin
  Result := (Ref is TppJvInspectorPropData) and (TppJvInspectorPropData(Ref).Instance = Instance) and
    (TppJvInspectorPropData(Ref).Prop = Prop);
end;

procedure TppJvInspectorPropData.NotifyRemoveData(const Instance: TppJvCustomInspectorData);
begin
  if (Instance <> Self) and (Instance.TypeInfo.Kind = tkClass) and
      (TObject(Instance.AsOrdinal) = Self.Instance) then
    Free;
end;

procedure TppJvInspectorPropData.SetAsFloat(const Value: Extended);
begin
  CheckWriteAccess;
  if Prop.PropType^.Kind = tkFloat then
    SetFloatProp(Instance, Prop, Value)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Float']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorPropData.SetAsInt64(const Value: Int64);
begin
  CheckWriteAccess;
  if Prop.PropType^.Kind = tkInt64 then
    SetInt64Prop(Instance, Prop, Value)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Int64']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorPropData.SetAsMethod(const Value: TMethod);
begin
  CheckWriteAccess;
  if Prop.PropType^.Kind = tkMethod then
    SetMethodProp(Instance, Prop, Value)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Method']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorPropData.SetAsOrdinal(const Value: Int64);
begin
  CheckWriteAccess;
  if Prop.PropType^.Kind in [tkInteger, tkChar, tkEnumeration, tkSet,
    tkWChar, tkClass] then
  begin
    if GetTypeData(Prop.PropType^).OrdType = otULong then
      SetOrdProp(Instance, Prop, Cardinal(Value))
    else
      SetOrdProp(Instance, Prop, Value);
  end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Ordinal']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorPropData.SetAsString(const Value: string);
begin
  CheckWriteAccess;
  if Prop.PropType^.Kind in cStringTypeKinds then
    SetStrProp(Instance, Prop, Value)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['String']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorPropData.SetInstance(const Value: TObject);
begin
  if Instance <> Value then
  begin
    FInstance := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorPropData.SetProp(const Value: PPropInfo);
begin
  if Prop <> Value then
  begin
    FProp := Value;
    TypeInfo := Value.PropType^;
    Invalidate;
  end;
end;

function TppJvInspectorPropData.SupportsMethodPointers: Boolean;
begin
  Result := True;
end;

procedure TppJvInspectorPropData.GetAsSet(var Buf);
var
  I: Integer;
  CompType: PTypeInfo;
  EnumMin: Integer;
  EnumMax: Integer;
  ResBytes: Integer;
begin
  I := AsOrdinal;
  CompType := GetTypeData(TypeInfo).CompType^;
  EnumMin := GetTypeData(CompType).MinValue;
  EnumMax := GetTypeData(CompType).MaxValue;
  ResBytes := (EnumMax div 8) - (EnumMin div 8) + 1;
  Move(I, Buf, ResBytes);
end;

function TppJvInspectorPropData.HasValue: Boolean;
begin
  Result := IsInitialized;
end;

function TppJvInspectorPropData.IsAssigned: Boolean;
begin
  Result := IsInitialized;
end;

function TppJvInspectorPropData.IsInitialized: Boolean;
begin
  Result := (Instance <> nil) and (Prop <> nil);
end;

class function TppJvInspectorPropData.ItemRegister: TppJvInspectorRegister;
begin
  if FPropItemReg = nil then
    FPropItemReg := TppJvInspectorRegister.Create(TppJvInspectorPropData);
  Result := FPropItemReg;
end;

class function TppJvInspectorPropData.New(const AParent: TppJvCustomInspectorItem;
  const AInstance: TObject; const PropInfo: PPropInfo): TppJvCustomInspectorItem;
var
  Data: TppJvInspectorPropData;
begin
  if PropInfo = nil then
    raise EppJvInspectorData.Create(sppJvAssertPropInfo);
  Data := CreatePrim(String(PropInfo.Name), PropInfo.PropType^);
  Data.Instance := AInstance;
  Data.Prop := PropInfo;
  Data := TppJvInspectorPropData(DataRegister.Add(Data));
  if Data <> nil then
    Result := Data.NewItem(AParent)
  else
    Result := nil;
end;

class function TppJvInspectorPropData.New(const AParent: TppJvCustomInspectorItem;
  const AInstance: TObject; const PropName: string): TppJvCustomInspectorItem;
var
  PI: PPropInfo;
begin
  PI := GetPropInfo(AInstance, PropName, tkAny);
  if PI <> nil then
    Result := New(AParent, AInstance, PI)
  else
    Result := nil;
end;

class function TppJvInspectorPropData.New(const AParent: TppJvCustomInspectorItem;
  const AInstance: TObject; const TypeKinds: TTypeKinds): TppJvInspectorItemInstances;
var
  PropCount: Integer;
  PropList: PPropList;
begin
  SetLength(Result, 0);
  PropCount := GetPropList(AInstance.ClassInfo, TypeKinds, nil);
  GetMem(PropList, PropCount * SizeOf(PPropInfo));
  try
    GetPropList(AInstance.ClassInfo, TypeKinds, PropList);
    Result := New(AParent, AInstance, PropList, PropCount);
  finally
    FreeMem(PropList);
  end;
end;

class function TppJvInspectorPropData.NewByNames(const AParent: TppJvCustomInspectorItem;
  const AInstance: TObject; const NameList: array of string;
  const ExcludeList: Boolean; const TypeKinds: TTypeKinds): TppJvInspectorItemInstances;
var
  PropCount: Integer;
  PropList: PPropList;
  I: Integer;
  PropInfo: PPropInfo;
  NameIdx: Integer;
begin
  SetLength(Result, 0);
  PropCount := GetPropList(AInstance.ClassInfo, TypeKinds, nil);
  GetMem(PropList, PropCount * SizeOf(PPropInfo));
  try
    GetPropList(AInstance.ClassInfo, TypeKinds, PropList);
    for I := 0 to Pred(PropCount) do
    begin
      PropInfo := PropList[I];
      NameIdx := High(NameList);
      while (NameIdx >= 0) and not SameText(NameList[NameIdx], String(PropInfo.Name)) do
        Dec(NameIdx);
      if ((NameIdx < 0) and ExcludeList) or ((NameIdx > -1) and not ExcludeList) then
      begin
        SetLength(Result, Length(Result) + 1);
        Result[High(Result)] := New(AParent, AInstance, PropInfo);
      end;
    end;
  finally
    FreeMem(PropList);
  end;
end;

class function TppJvInspectorPropData.New(const AParent: TppJvCustomInspectorItem;
  const AInstance: TObject; const PropInfos: PPropList;
  const PropCount: Integer): TppJvInspectorItemInstances;
var
  I: Integer;
begin
  SetLength(Result, PropCount);
  for I := 0 to Pred(PropCount) do
    Result[I] := New(AParent, AInstance, PropInfos[I]);
end;

procedure TppJvInspectorPropData.SetAsSet(const Buf);
begin
  AsOrdinal := Integer(Buf);
end;

//=== TppJvInspectorEventData ==================================================

function TppJvInspectorEventData.DoGetAsFloat: Extended;
begin
  if Assigned(FOnGetAsFloat) then
    OnGetAsFloat(Self, Result)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Float']);
end;

function TppJvInspectorEventData.DoGetAsInt64: Int64;
begin
  if Assigned(FOnGetAsInt64) then
    OnGetAsInt64(Self, Result)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Int64']);
end;

function TppJvInspectorEventData.DoGetAsMethod: TMethod;
begin
  if Assigned(FOnGetAsMethod) then
    OnGetAsMethod(Self, Result)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['TMethod']);
end;

function TppJvInspectorEventData.DoGetAsOrdinal: Int64;
begin
  if Assigned(FOnGetAsOrdinal) then
    OnGetAsOrdinal(Self, Result)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['ordinal']);
end;

function TppJvInspectorEventData.DoGetAsString: string;
begin
  if Assigned(FOnGetAsString) then
    OnGetAsString(Self, Result)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['string']);
end;

procedure TppJvInspectorEventData.DoGetAsSet(out Buf; var BufSize: Integer);
begin
  if Assigned(FOnGetAsSet) then
    OnGetAsSet(Self, Buf, BufSize)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['set']);
end;

procedure TppJvInspectorEventData.DoSetAsFloat(Value: Extended);
begin
  if Assigned(FOnSetAsFloat) then
    OnSetAsFloat(Self, Value)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Float']);
end;

procedure TppJvInspectorEventData.DoSetAsInt64(Value: Int64);
begin
  if Assigned(FOnSetAsInt64) then
    OnSetAsInt64(Self, Value)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Int64']);
end;

procedure TppJvInspectorEventData.DoSetAsMethod(Value: TMethod);
begin
  if Assigned(FOnSetAsMethod) then
    OnSetAsMethod(Self, Value)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['TMethod']);
end;

procedure TppJvInspectorEventData.DoSetAsOrdinal(Value: Int64);
begin
  if Assigned(FOnSetAsOrdinal) then
    OnSetAsOrdinal(Self, Value)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['ordinal']);
end;

procedure TppJvInspectorEventData.DoSetAsString(Value: string);
begin
  if Assigned(FOnSetAsString) then
    OnSetAsString(Self, Value)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['string']);
end;

function TppJvInspectorEventData.DoSupportsMethodPointers: Boolean;
begin
  Result := False;
  if Assigned(FOnSupportsMethodPointers) then
    OnSupportsMethodPointers(Self, Result);
end;

procedure TppJvInspectorEventData.DoSetAsSet(const Buf; var BufSize: Integer);
var
  TmpBuf: PChar;
begin
  TmpBuf := @Buf;
  if Assigned(FOnSetAsSet) then
    OnSetAsSet(Self, TmpBuf[0], BufSize)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['set']);
end;

function TppJvInspectorEventData.GetAsFloat: Extended;
begin
  CheckReadAccess;
  if TypeInfo.Kind = tkFloat then
    Result := DoGetAsFloat
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Float']);
end;

function TppJvInspectorEventData.GetAsInt64: Int64;
begin
  CheckReadAccess;
  if TypeInfo.Kind = tkInt64 then
    Result := DoGetAsInt64
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Int64']);
end;

function TppJvInspectorEventData.GetAsMethod: TMethod;
begin
  CheckReadAccess;
  if TypeInfo.Kind = tkMethod then
    Result := DoGetAsMethod
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['TMethod']);
end;

function TppJvInspectorEventData.GetAsOrdinal: Int64;
begin
  CheckReadAccess;
  if TypeInfo.Kind in [tkInteger, tkChar, tkEnumeration, tkSet, tkWChar] then
  begin
    case GetTypeData(TypeInfo).OrdType of
      otSByte:
        Result := Shortint(DoGetAsOrdinal);
      otUByte:
        Result := Byte(DoGetAsOrdinal);
      otSWord:
        Result := Smallint(DoGetAsOrdinal);
      otUWord:
        Result := Word(DoGetAsOrdinal);
      otSLong:
        Result := Longint(DoGetAsOrdinal);
      otULong:
        Result := Longword(DoGetAsOrdinal);
    else
      Result := 0;
    end;
  end
  else
  if TypeInfo.Kind = tkClass then
    Result := Longword(DoGetAsOrdinal)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['ordinal']);
end;

function TppJvInspectorEventData.GetAsString: string;
begin
  CheckReadAccess;
  if TypeInfo.Kind in cStringTypeKinds then
    Result := DoGetAsString
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['string']);
end;

function TppJvInspectorEventData.IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean;
begin
  Result := (Ref is TppJvInspectorEventData) and (TppJvInspectorEventData(Ref).Name = Name) and
    (TppJvInspectorEventData(Ref).TypeInfo = TypeInfo);
end;

procedure TppJvInspectorEventData.SetAsFloat(const Value: Extended);
begin
  CheckWriteAccess;
  if TypeInfo.Kind = tkFloat then
    DoSetAsFloat(Value)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Float']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorEventData.SetAsInt64(const Value: Int64);
begin
  CheckWriteAccess;
  if TypeInfo.Kind = tkInt64 then
  begin
    if (Value < GetTypeData(TypeInfo).MinInt64Value) or
        (Value > GetTypeData(TypeInfo).MaxInt64Value) then
      raise ERangeError.CreateFmt(SOutOfRange, [GetTypeData(TypeInfo).MinValue,
        GetTypeData(TypeInfo).MaxValue]);
    DoSetAsInt64(Value);
  end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Int64']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorEventData.SetAsMethod(const Value: TMethod);
begin
  CheckWriteAccess;
  if TypeInfo.Kind = tkMethod then
    DoSetAsMethod(Value)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['TMethod']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorEventData.SetAsOrdinal(const Value: Int64);
var
  MinValue: Int64;
  MaxValue: Int64;
begin
  CheckWriteAccess;
  if TypeInfo.Kind in [tkInteger, tkChar, tkEnumeration, tkWChar] then
  begin
    if GetTypeData(TypeInfo).OrdType <> otULong then
    begin
      MinValue := GetTypeData(TypeInfo).MinValue;
      MaxValue := GetTypeData(TypeInfo).MaxValue;
    end
    else
    begin
      MinValue := Longword(GetTypeData(TypeInfo).MinValue);
      MaxValue := Longword(GetTypeData(TypeInfo).MaxValue);
    end;
    if (Value < MinValue) or (Value > MaxValue) then
      raise ERangeError.CreateFmt(SOutOfRange, [MinValue, MaxValue]);
    case GetTypeData(TypeInfo).OrdType of
      otSByte:
        DoSetAsOrdinal(Shortint(Value));
      otUByte:
        DoSetAsOrdinal(Byte(Value));
      otSWord:
        DoSetAsOrdinal(Smallint(Value));
      otUWord:
        DoSetAsOrdinal(Word(Value));
      otSLong:
        DoSetAsOrdinal(Longint(Value));
      otULong:
        DoSetAsOrdinal(Longword(Value));
    end;
  end
  else
  if TypeInfo.Kind = tkClass then
    DoSetAsOrdinal(Longword(Value))
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['ordinal']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorEventData.SetAsString(const Value: string);
begin
  CheckWriteAccess;
  if TypeInfo.Kind in cStringTypeKinds then
  begin
    case TypeInfo.Kind of
{$IFDEF Delphi12}
      tkLString, tkUString:
{$ELSE}
      tkLString:
{$ENDIF}
        DoSetAsString(Value);
      tkWString:
        DoSetAsString(Value);
      tkString:
        if Length(Value) < GetTypeData(TypeInfo).MaxLength then
          DoSetAsString(Value)
        else
          raise EppJvInspectorData.Create(sppJVInspDataStrTooLong);
    end;
  end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['string']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorEventData.SetOnGetAsFloat(Value: TppJvInspAsFloat);
begin
  if @FOnGetAsFloat <> @Value then
  begin
    FOnGetAsFloat := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorEventData.SetOnGetAsInt64(Value: TppJvInspAsInt64);
begin
  if @FOnGetAsInt64 <> @Value then
  begin
    FOnGetAsInt64 := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorEventData.SetOnGetAsMethod(Value: TppJvInspAsMethod);
begin
  if @FOnGetAsMethod <> @Value then
  begin
    FOnGetAsMethod := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorEventData.SetOnGetAsOrdinal(Value: TppJvInspAsInt64);
begin
  if @FOnGetAsOrdinal <> @Value then
  begin
    FOnGetAsOrdinal := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorEventData.SetOnGetAsString(Value: TppJvInspAsString);
begin
  if @FOnGetAsString <> @Value then
  begin
    FOnGetAsString := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorEventData.SetOnGetAsSet(Value: TppJvInspAsSet);
begin
  if @FOnGetAsSet <> @Value then
  begin
    FOnGetAsSet := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorEventData.SetOnSetAsFloat(Value: TppJvInspAsFloat);
begin
  if @FOnSetAsFloat <> @Value then
  begin
    FOnSetAsFloat := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorEventData.SetOnSetAsInt64(Value: TppJvInspAsInt64);
begin
  if @FOnSetAsInt64 <> @Value then
  begin
    FOnSetAsInt64 := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorEventData.SetOnSetAsMethod(Value: TppJvInspAsMethod);
begin
  if @FOnSetAsMethod <> @Value then
  begin
    FOnSetAsMethod := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorEventData.SetOnSetAsOrdinal(Value: TppJvInspAsInt64);
begin
  if @FOnSetAsOrdinal <> @Value then
  begin
    FOnSetAsOrdinal := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorEventData.SetOnSetAsString(Value: TppJvInspAsString);
begin
  if @FOnSetAsString <> @Value then
  begin
    FOnSetAsString := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorEventData.SetOnSetAsSet(Value: TppJvInspAsSet);
begin
  if @FOnSetAsSet <> @Value then
  begin
    FOnSetAsSet := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorEventData.SetOnSupportsMethodPointers(Value: TppJvInspSupportsMethodPointers);
begin
  if @FOnSupportsMethodPointers <> @Value then
  begin
    FOnSupportsMethodPointers := Value;
    Invalidate;
  end;
end;

function TppJvInspectorEventData.SupportsMethodPointers: Boolean;
begin
  Result := DoSupportsMethodPointers;
end;

procedure TppJvInspectorEventData.GetAsSet(var Buf);
var
  CompType: PTypeInfo;
  EnumMin: Integer;
  EnumMax: Integer;
  ResBytes: Integer;
begin
  CheckReadAccess;
  if TypeInfo.Kind = tkSet then
  begin
    CompType := GetTypeData(TypeInfo).CompType^;
    EnumMin := GetTypeData(CompType).MinValue;
    EnumMax := GetTypeData(CompType).MaxValue;
    ResBytes := (EnumMax div 8) - (EnumMin div 8) + 1;
    DoGetAsSet(Buf, ResBytes);
  end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['set']);
end;

function TppJvInspectorEventData.HasValue: Boolean;
begin
  Result := IsInitialized;
end;

function TppJvInspectorEventData.IsAssigned: Boolean;
begin
  Result := IsInitialized;
end;

function TppJvInspectorEventData.IsInitialized: Boolean;
begin
  Result := (TypeInfo <> nil) and (Assigned(OnGetAsFloat) or Assigned(OnGetAsInt64) or
    Assigned(OnGetAsMethod) or Assigned(OnGetAsOrdinal) or Assigned(OnGetAsString) or
    Assigned(OnGetAsSet));
end;

class function TppJvInspectorEventData.New(const AParent: TppJvCustomInspectorItem; const AName: string;
  const ATypeInfo: PTypeInfo): TppJvCustomInspectorItem;
var
  Data: TppJvInspectorEventData;
begin
  Data := TppJvInspectorEventData(DataRegister.Add(CreatePrim(AName, ATypeInfo)));
  if Data <> nil then
    Result := Data.NewItem(AParent)
  else
    Result := nil;
end;

procedure TppJvInspectorEventData.SetAsSet(const Buf);
var
  CompType: PTypeInfo;
  EnumMin: Integer;
  EnumMax: Integer;
  ResBytes: Integer;
begin
  CheckWriteAccess;
  if TypeInfo.Kind = tkSet then
  begin
    CompType := GetTypeData(TypeInfo).CompType^;
    EnumMin := GetTypeData(CompType).MinValue;
    EnumMax := GetTypeData(CompType).MaxValue;
    ResBytes := (EnumMax div 8) - (EnumMin div 8) + 1;
    DoSetAsSet(Buf, ResBytes);
  end
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['set']);
  InvalidateData;
  Invalidate;
end;

//=== TppJvInspectorCustomConfData =============================================

constructor TppJvInspectorCustomConfData.CreatePrim(const AName, ASection, AKey: string;
  const ATypeInfo: PTypeInfo);
begin
  inherited CreatePrim(AName, ATypeInfo);
  FKey := AKey;
  FSection := ASection;
end;

function TppJvInspectorCustomConfData.GetAsFloat: Extended;
begin
  CheckReadAccess;
  if TypeInfo.Kind = tkFloat then
    Result := StrToFloat(Trim(StringReplace(ReadValue, ThousandSeparator, DecimalSeparator, [rfReplaceAll, rfIgnoreCase])))
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Float']);
end;

function TppJvInspectorCustomConfData.GetAsInt64: Int64;
begin
  CheckReadAccess;
  if TypeInfo.Kind = tkInt64 then
    Result := StrToInt64(ReadValue)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Int64']);
end;

function TppJvInspectorCustomConfData.GetAsMethod: TMethod;
begin
  CheckReadAccess;
  raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['TMethod']);
end;

function TppJvInspectorCustomConfData.GetAsOrdinal: Int64;
var
  S: string;
begin
  CheckReadAccess;
  S := ReadValue;
  case TypeInfo.Kind of
    tkInteger:
      begin
        case GetTypeData(TypeInfo).OrdType of
          otSByte:
            Result := Shortint(StrToInt(S));
          otUByte:
            Result := Byte(StrToInt(S));
          otSWord:
            Result := Smallint(StrToInt(S));
          otUWord:
            Result := Word(StrToInt(S));
          otSLong:
            Result := Longint(StrToInt(S));
          otULong:
            Result := Longword(StrToInt(S));
        else
          Result := 0;
        end;
      end;
    tkChar, tkWChar:
      begin
        if Length(S) > 1 then
          Result := StrToInt(Copy(S, 2, Length(S)))
        else
        if Length(S) = 1 then
          Result := Ord(S[1])
        else
          Result := 0;
      end;
    tkEnumeration:
      Result := GetEnumValue(TypeInfo, S);
    tkSet:
      GetAsSet(Result);
    else
      raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['ordinal']);
  end;
end;

function TppJvInspectorCustomConfData.GetAsString: string;
begin
  CheckReadAccess;

  if TypeInfo.Kind in cStringTypeKinds then
    Result := ReadValue
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['string']);
end;

function TppJvInspectorCustomConfData.IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean;
begin
  Result := (Ref is TppJvInspectorCustomConfData) and
    AnsiSameText(TppJvInspectorCustomConfData(Ref).Section, Section) and
    AnsiSameText(TppJvInspectorCustomConfData(Ref).Key, Key);
end;

procedure TppJvInspectorCustomConfData.SetAsFloat(const Value: Extended);
begin
  CheckWriteAccess;
  if TypeInfo.Kind = tkFloat then
    WriteValue(FloatToStr(Value))
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Float']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorCustomConfData.SetAsInt64(const Value: Int64);
begin
  CheckWriteAccess;
  if TypeInfo.Kind = tkInt64 then
    WriteValue(IntToStr(Value))
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['Int64']);
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorCustomConfData.SetAsMethod(const Value: TMethod);
begin
  CheckWriteAccess;
  raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['TMethod']);
end;

procedure TppJvInspectorCustomConfData.SetAsOrdinal(const Value: Int64);
begin
  CheckWriteAccess;
  case TypeInfo.Kind of
    tkInteger:
      WriteValue(IntToStr(Value));
    tkChar, tkWChar:
      begin
        if (Value <= Ord(' ')) or (Value > Ord('~')) then
          WriteValue('#' + IntToStr(Value))
        else
          WriteValue(Chr(Byte(Value)));
      end;
    tkEnumeration:
      WriteValue(GetEnumName(TypeInfo, Value));
    tkSet:
      SetAsSet(Value);
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['ordinal']);
  end;
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorCustomConfData.SetAsString(const Value: string);
begin
  CheckWriteAccess;
  case TypeInfo.Kind of
    tkString:
      begin
        if Length(Value) < GetTypeData(TypeInfo).MaxLength then
          WriteValue(Value)
        else
          raise EppJvInspectorData.Create(sppJVInspDataStrTooLong);
      end;
{$IFDEF Delphi12}
    tkLString, tkWString, tkUString:
{$ELSE}
    tkLString, tkWString:
{$ENDIF}
      WriteValue(Value)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['string']);
  end;
  InvalidateData;
  Invalidate;
end;

procedure TppJvInspectorCustomConfData.SetKey(Value: string);
begin
  if Value <> Key then
  begin
    FKey := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorCustomConfData.SetSection(Value: string);
begin
  if Value <> Section then
  begin
    FSection := Value;
    Invalidate;
  end;
end;

procedure TppJvInspectorCustomConfData.GetAsSet(var Buf);
begin
  CheckReadAccess;
  if TypeInfo.Kind = tkSet then
    ppJclStrToSet(TypeInfo, Buf, ReadValue)
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['set']); 
end;

function TppJvInspectorCustomConfData.HasValue: Boolean;
begin
  Result := IsInitialized;
end;

function TppJvInspectorCustomConfData.IsAssigned: Boolean;
begin
  Result := IsInitialized and ExistingValue;
end;

function TppJvInspectorCustomConfData.IsInitialized: Boolean;
begin
  Result := (Key <> '') and (Section <> '');
end;

procedure TppJvInspectorCustomConfData.SetAsSet(const Buf);
begin
  CheckWriteAccess;
  if TypeInfo.Kind = tkSet then
    WriteValue(ppJclSetToStr(TypeInfo, Buf, True, False))
  else
    raise EppJvInspectorData.CreateFmt(sppJvInspDataNoAccessAs, ['set']);
  InvalidateData;
  Invalidate;
end;

//=== TppJvInspectorINIFileData ================================================

function TppJvInspectorINIFileData.ExistingValue: Boolean;
begin
  Result := IsInitialized and INIFile.SectionExists(Section) and INIFile.ValueExists(Section, Key);
end;

function TppJvInspectorINIFileData.IsEqualReference(const Ref: TppJvCustomInspectorData): Boolean;
begin
  Result := (Ref is TppJvInspectorINIFileData) and
    (TppJvInspectorINIFileData(Ref).INIFile = INIFile) and inherited IsEqualReference(Ref);
end;

function TppJvInspectorINIFileData.ReadValue: string;
begin
  Result := INIFile.ReadString(Section, Key, '');
end;

procedure TppJvInspectorINIFileData.WriteValue(Value: string);
begin
  INIFile.WriteString(Section, Key, Value);
end;

class function TppJvInspectorINIFileData.New(const AParent: TppJvCustomInspectorItem; const AName,
  ASection, AKey: string; const ATypeInfo: PTypeInfo;
  const AINIFile: TCustomIniFile): TppJvCustomInspectorItem;
var
  Data: TppJvInspectorINIFileData;
begin
  if AINIFile = nil then
    raise EppJvInspectorData.Create(sppJvAssertINIFile);
  Data := CreatePrim(AName, ASection, AKey, ATypeInfo);
  Data.FINIFile := AINIFile;
  Data := TppJvInspectorINIFileData(DataRegister.Add(Data));
  if Data <> nil then
    Result := Data.NewItem(AParent)
  else
    Result := nil;
end;

class function TppJvInspectorINIFileData.New(const AParent: TppJvCustomInspectorItem;
  const ASection: string; const AINIFile: TCustomIniFile;
  const AOnAddKey: TppJvInspConfKeyEvent): TppJvInspectorItemInstances;
var
  SL: TStrings;
  I: Integer;
  KeyName: string;
  KeyTypeInfo: PTypeInfo;
  TmpItem: TppJvCustomInspectorItem;

  function AllowAddKey: Boolean;
  begin
    KeyName := SL[I];
    KeyTypeInfo := System.TypeInfo(string);
    Result := True;
    if Assigned(AOnAddKey) then
      AOnAddKey(ASection, KeyName, KeyTypeInfo, Result);
  end;

begin
  if AINIFile = nil then
    raise EppJvInspectorData.Create(sppJvAssertINIFile);
  SetLength(Result, 0);
  SL := TStringList.Create;
  try
    AINIFile.ReadSection(ASection, SL);
    for I := 0 to SL.Count - 1 do
    begin
      if AllowAddKey then
      begin
        TmpItem := TppJvInspectorINIFileData.New(AParent, KeyName, ASection, SL[I], KeyTypeInfo,
          AINIFile);
        if TmpItem <> nil then
        begin
          SetLength(Result, Length(Result) + 1);
          Result[High(Result)] := TmpItem;
        end;
      end;
    end;
  finally
    SL.Free;
  end;
end;

class function TppJvInspectorINIFileData.New(const AParent: TppJvCustomInspectorItem;
  const AINIFile: TCustomIniFile; const AOnAddSection: TppJvInspConfSectionEvent;
  const AOnAddKey: TppJvInspConfKeyEvent): TppJvInspectorItemInstances;
var
  TmpLst: TppJvInspectorItemInstances;
  SL: TStrings;
  I: Integer;
  CatName: string;
  CatItem: TppJvInspectorCustomCategoryItem;

  function AllowAddSection: Boolean;
  begin
    CatName := SL[I];
    Result := True;
    if Assigned(AOnAddSection) then
      AOnAddSection(CatName, Result);
  end;

begin
  SetLength(TmpLst, 0);
  if AINIFile = nil then
    raise EppJvInspectorData.Create(sppJvAssertINIFile);
  SL := TStringList.Create;
  try
    AINIFile.ReadSections(SL);
    for I := 0 to SL.Count - 1 do
    begin
      if AllowAddSection then
      begin
        CatItem := TppJvInspectorCustomCategoryItem.Create(AParent, nil);
        CatItem.DisplayName := CatName;
        TmpLst := TppJvInspectorINIFileData.New(CatItem, SL[I], AINIFile, AOnAddKey);
        SetLength(Result, Length(Result) + Length(TmpLst));
        Move(TmpLst[0], Result[Length(Result) - Length(TmpLst)], Length(TmpLst));
        if CatItem.Count = 0 then
          CatItem.Parent.Delete(CatItem);
      end;
    end;
  finally
    SL.Free;
  end;
end;

//=== TppJvInspectorRegister ===================================================

function TppJvInspectorRegister.Compare(const ADataObj: TppJvCustomInspectorData;
  const Item1, Item2: TppJvCustomInspectorRegItem): Integer;
begin
  Result := Item1.Compare(ADataObj, Item2);
end;

function TppJvInspectorRegister.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TppJvInspectorRegister.GetItems(const I: Integer): TppJvCustomInspectorRegItem;
begin
  Result := TppJvCustomInspectorRegItem(FItems[I]);
end;

constructor TppJvInspectorRegister.Create(const ADataClass: TppJvInspectorDataClass);
begin
  inherited Create;
  FDataClass := ADataClass;
  FItems := TObjectList.Create(True);
end;

destructor TppJvInspectorRegister.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TppJvInspectorRegister.Add(const RegItem: TppJvCustomInspectorRegItem);
begin
  FItems.Add(RegItem);
end;

procedure TppJvInspectorRegister.Delete(const RegItem: TppJvCustomInspectorRegItem);
begin
  FItems.Remove(RegItem);
end;

procedure TppJvInspectorRegister.Delete(const ItemClass: TppJvInspectorItemClass);
var
  Idx: Integer;
begin
  Idx := IndexOf(ItemClass);
  if Idx > -1 then
    Delete(Idx);
end;

procedure TppJvInspectorRegister.Delete(const Index: Integer);
begin
  FItems.Delete(Index);
end;

function TppJvInspectorRegister.FindMatch(
  const ADataObj: TppJvCustomInspectorData): TppJvCustomInspectorRegItem;
var
  I: Integer;
  ParDataClass: TppJvInspectorDataClass;
  ParResult: TppJvCustomInspectorRegItem;
begin
  Result := nil;
  for I := Pred(Count) downto 0 do
  begin
    if Items[I].IsMatch(ADataObj) then
    begin
      if Result = nil then
        Result := Items[I]
      else
      if Compare(ADataObj, Result, Items[I]) < 0 then
        Result := Items[I];
    end;
  end;
  if (Result = nil) or (Result.MatchPercent(ADataObj) <> 100) then
  begin
    ParDataClass := TppJvInspectorDataClass(DataClass.ClassParent);
    while (ParDataClass <> nil) and
        ParDataClass.InheritsFrom(TppJvCustomInspectorData) and
        (ParDataClass.ItemRegister = Self) do
      ParDataClass := TppJvInspectorDataClass(ParDataClass.ClassParent);
    if (ParDataClass <> nil) and
      ParDataClass.InheritsFrom(TppJvCustomInspectorData) and
      (ParDataClass.ItemRegister <> Self) then
    begin
      ParResult := ParDataClass.ItemRegister.FindMatch(ADataObj);
      if (ParResult <> nil) and (((Result <> nil) and
          (Result.Compare(ADataObj, ParResult) < 0)) or (Result = nil)) then
        Result := ParResult;
    end;
  end;
end;

function TppJvInspectorRegister.IndexOf(const RegItem: TppJvCustomInspectorRegItem): Integer;
begin
  Result := FItems.IndexOf(RegItem);
end;

function TppJvInspectorRegister.IndexOf(const ItemClass: TppJvInspectorItemClass): Integer;
begin
  Result := FItems.Count - 1;
  while (Result > -1) and (Items[Result].ItemClass <> ItemClass) do
    Dec(Result);
end;

//=== TppJvCustomInspectorRegItem ==============================================

function TppJvCustomInspectorRegItem.CompareTo(const ADataObj: TppJvCustomInspectorData;
  const Item: TppJvCustomInspectorRegItem): Integer;
begin
  if MatchPercent(ADataObj) > Item.MatchPercent(ADataObj) then
    Result := MatchPercent(ADataObj)
  else
    Result := -Item.MatchPercent(ADataObj)
end;

function TppJvCustomInspectorRegItem.GetItemClass: TppJvInspectorItemClass;
begin
  Result := FItemClass;
end;

procedure TppJvCustomInspectorRegItem.SetItemClass(
  const Value: TppJvInspectorItemClass);
begin
  FItemClass := Value;
end;

constructor TppJvCustomInspectorRegItem.Create(const AItemClass: TppJvInspectorItemClass);
begin
  inherited Create;
  FItemClass := AItemClass;
end;

procedure TppJvCustomInspectorRegItem.ApplyDefaults(const Item: TppJvCustomInspectorItem);
begin
  { Override in descendants to apply special defaults }
end;

function TppJvCustomInspectorRegItem.Compare(const ADataObj: TppJvCustomInspectorData;
  const Item: TppJvCustomInspectorRegItem): Integer;
begin
  if ClassType = Item.ClassType then
  begin
    if MatchValue(ADataObj) >= Item.MatchValue(ADataObj) then
      Result := MatchValue(ADataObj)
    else
      Result := -Item.MatchValue(ADataObj);
  end
  else
    Result := -Item.CompareTo(ADataObj, Self);
end;

function TppJvCustomInspectorRegItem.IsMatch(
  const ADataObj: TppJvCustomInspectorData): Boolean;
begin
  Result := MatchValue(ADataObj) <> 0;
end;

//=== TppJvInspectorTypeInfoRegItem ============================================

function TppJvInspectorTypeInfoRegItem.GetTypeInfo: PTypeInfo;
begin
  Result := FTypeInfo;
end;

procedure TppJvInspectorTypeInfoRegItem.SetTypeInfo(const Value: PTypeInfo);
begin
  FTypeInfo := Value;
end;

constructor TppJvInspectorTypeInfoRegItem.Create(const AItemClass: TppJvInspectorItemClass;
  const ATypeInfo: PTypeInfo);
begin
  inherited Create(AItemClass);
  FTypeInfo := ATypeInfo;
end;

function TppJvInspectorTypeInfoRegItem.MatchValue(const ADataObj: TppJvCustomInspectorData): Integer;
begin
  if ADataObj.TypeInfo = TypeInfo then
    Result := 100
  else
  if (TypeInfo.Kind = tkClass) and (ADataObj.TypeInfo.Kind = tkClass) and
    (GetTypeData(ADataObj.TypeInfo).ClassType.InheritsFrom(GetTypeData(TypeInfo).ClassType)) then
    Result := 50
  else
    Result := 0;
end;

function TppJvInspectorTypeInfoRegItem.MatchPercent(const ADataObj: TppJvCustomInspectorData): Integer;
begin
  { Matching TypeInfo is a perfect match. Since MatchValue already returns a
    percentage, just return that value. }
  Result := MatchValue(ADataObj);
end;

//=== TppJvInspectorTCaptionRegItem ============================================

procedure TppJvInspectorTCaptionRegItem.ApplyDefaults(const Item: TppJvCustomInspectorItem);
begin
  if Item <> nil then
    with Item do
    begin
      AutoUpdate := True;
      Flags := Item.Flags + [iifMultiLine];
      RowSizing.SizingFactor := irsValueHeight;
      RowSizing.MinHeight := irsItemHeight;
      RowSizing.Sizable := True;
    end;
end;

//=== TppJvInspectorTypeKindRegItem ============================================

function TppJvInspectorTypeKindRegItem.CompareTo(const ADataObj: TppJvCustomInspectorData;
  const Item: TppJvCustomInspectorRegItem): Integer;
begin
  if Item is TppJvInspectorTypeInfoRegItem then
    Result := -Item.MatchValue(ADataObj)
  else
    Result := inherited CompareTo(ADataObj, Item);
end;

function TppJvInspectorTypeKindRegItem.GetTypeKind: TTypeKind;
begin
  Result := FTypeKind;
end;

procedure TppJvInspectorTypeKindRegItem.SetTypeKind(const Value: TTypeKind);
begin
  FTypeKind := Value;
end;

constructor TppJvInspectorTypeKindRegItem.Create(const AItemClass: TppJvInspectorItemClass;
  const ATypeKind: TTypeKind);
begin
  inherited Create(AItemClass);
  FTypeKind := ATypeKind;
end;

function TppJvInspectorTypeKindRegItem.Compare(const ADataObj: TppJvCustomInspectorData;
  const Item: TppJvCustomInspectorRegItem): Integer;
begin
  if Item is TppJvInspectorTypeInfoRegItem then
  begin
    if MatchValue(ADataObj) >= Item.MatchValue(ADataObj) then
      Result := MatchValue(ADataObj)
    else
      Result := -Item.MatchValue(ADataObj);
  end
  else
    Result := inherited Compare(ADataObj, Item);
end;

function TppJvInspectorTypeKindRegItem.MatchValue(const ADataObj: TppJvCustomInspectorData): Integer;
begin
  if ADataObj.TypeInfo.Kind = TypeKind then
    Result := 100
  else
    Result := 0;
end;

function TppJvInspectorTypeKindRegItem.MatchPercent(const ADataObj: TppJvCustomInspectorData): Integer;
begin
  { Matching TypeKind is 50% match. Since MatchValue returns either 0 or 100,
    devide it by two to get 0 or 50. }
  Result := MatchValue(ADataObj) div 2;
end;

//=== TppJvInspectorPropRegItem ================================================

function TppJvInspectorPropRegItem.Compare(const ADataObj: TppJvCustomInspectorData;
  const Item: TppJvCustomInspectorRegItem): Integer;
begin
  if not (Item is TppJvInspectorPropRegItem) then
    Result := MatchValue(ADataObj)
  else
    Result := inherited Compare(ADataObj, Item);
end;

constructor TppJvInspectorPropRegItem.Create(const AItemClass: TppJvInspectorItemClass;
  const AObjectClass: TClass; const AName: string; const ATypeInfo: PTypeInfo);
begin
  inherited Create(AItemClass);
  FObjectClass := AObjectClass;
  FName := AName;
  FTypeInfo := ATypeInfo;
end;

function TppJvInspectorPropRegItem.MatchValue(const ADataObj: TppJvCustomInspectorData): Integer;
var
  GoOn: Boolean;
  ObjParentClass: TClass;
begin
  { Match value will be based on the all set items according to the following
    table:

    Base value is 0
    * ClassType known
      * class type equal:           add 32
      * class type inherits:        add 16
      * class does not match:       return 0
    * Name known
      * Name exact match:           add  8
      * Name matches by mask:       add  4
      * Name does not match:        return 0
    * Type info known
      * Typeinfo exact match:       add  2
      * Typeinfo typekind matches:  add  1
      * Typeinfo does not match:    return 0
     }
  Result := 0;
  GoOn := True;
  if TypeInfo <> nil then
  begin
    if TypeInfo = ADataObj.TypeInfo then
      Result := Result or 2
    else
    if TypeInfo.Kind = ADataObj.TypeInfo.Kind then
    begin
      if (TypeInfo.Kind <> tkClass) or (GetTypeData(ADataObj.TypeInfo).ClassType.InheritsFrom(
        GetTypeData(TypeInfo).ClassType)) then
        Result := Result or 1
      else
        GoOn := False;
    end
    else
      GoOn := False;
  end;

  if GoOn and (Name <> '') then
  begin
    if SameText(Name, ADataObj.Name) then
      Result := Result or 8
    { Match by mask }
    else
      GoOn := False;
  end;

  if GoOn and (ObjectClass <> nil) then
  begin
    { Class type based on the parent object }
    ObjParentClass := TppJvInspectorPropData(ADataObj).Instance.ClassType;
    if ObjParentClass = ObjectClass then
      Result := Result or 32
    else
    if (ObjParentClass <> nil) and ObjParentClass.InheritsFrom(ObjectClass) then
      Result := Result or 16
    else
      GoOn := False;
  end;

  if not GoOn then
    Result := 0;
end;

function TppJvInspectorPropRegItem.MatchPercent(const ADataObj: TppJvCustomInspectorData): Integer;
var
  MV: Integer;
begin
  { A 100% score would mean that Class, Name and TypeInfo all were a perfect
    match. }
  Result := 100;
  MV := MatchValue(ADataObj);
  if MV = 0 then
    Result := 0
  else
  begin
    if ObjectClass <> nil then
    begin
      if (MV and 16) <> 0 then
        Result := Result div 2;
    end
    else
      Dec(Result, 8);

    if Name <> '' then
    begin
      if (MV and 4) <> 0 then
        Result := Result div 2;
    end
    else
      Dec(Result, 4);

    if TypeInfo <> nil then
    begin
      if (MV and 1) <> 0 then
        Result := Result div 2;
    end
    else
      Dec(Result, 8);
  end;
end;

procedure RegisterTypeKinds;
begin
  if TppJvCustomInspectorData.ItemRegister = nil then
    raise EppJvInspectorReg.Create(sppJvInspNoGenReg);
  with TppJvCustomInspectorData.ItemRegister do
  begin
{$IFDEF Delphi12}
    Add(TppJvInspectorTypeKindRegItem.Create(TppJvInspectorStringItem, tkUString));
{$ENDIF}
    Add(TppJvInspectorTypeKindRegItem.Create(TppJvInspectorStringItem, tkLString));
    Add(TppJvInspectorTypeKindRegItem.Create(TppJvInspectorStringItem, tkWString));
    Add(TppJvInspectorTypeKindRegItem.Create(TppJvInspectorStringItem, tkString));
    Add(TppJvInspectorTypeKindRegItem.Create(TppJvInspectorIntegerItem, tkInteger));
    Add(TppJvInspectorTypeKindRegItem.Create(TppJvInspectorEnumItem, tkEnumeration));
    Add(TppJvInspectorTypeKindRegItem.Create(TppJvInspectorFloatItem, tkFloat));
    Add(TppJvInspectorTypeKindRegItem.Create(TppJvInspectorSetItem, tkSet));
    Add(TppJvInspectorTypeKindRegItem.Create(TppJvInspectorCharItem, tkChar));
    Add(TppJvInspectorTypeKindRegItem.Create(TppJvInspectorCharItem, tkWChar));
    Add(TppJvInspectorTypeKindRegItem.Create(TppJvInspectorInt64Item, tkInt64));
    Add(TppJvInspectorTypeKindRegItem.Create(TppJvInspectorClassItem, tkClass));
    Add(TppJvInspectorTypeKindRegItem.Create(TppJvInspectorTMethodItem, tkMethod));
    Add(TppJvInspectorTCaptionRegItem.Create(TppJvInspectorStringItem, TypeInfo(TCaption)));
    Add(TppJvInspectorTypeInfoRegItem.Create(TppJvInspectorFontItem, TypeInfo(TFont)));
    Add(TppJvInspectorTypeInfoRegItem.Create(TppJvInspectorBooleanItem, TypeInfo(Boolean)));
    Add(TppJvInspectorTypeInfoRegItem.Create(TppJvInspectorBooleanItem, TypeInfo(BYTEBOOL)));
    Add(TppJvInspectorTypeInfoRegItem.Create(TppJvInspectorBooleanItem, TypeInfo(WORDBOOL)));
    Add(TppJvInspectorTypeInfoRegItem.Create(TppJvInspectorBooleanItem, TypeInfo(LONGBOOL)));
    Add(TppJvInspectorTypeInfoRegItem.Create(TppJvInspectorTStringsItem, TypeInfo(TStrings)));
    Add(TppJvInspectorTypeInfoRegItem.Create(TppJvInspectorComponentItem, TypeInfo(TComponent)));
    Add(TppJvInspectorTypeInfoRegItem.Create(TppJvInspectorDateItem, TypeInfo(TDate)));
    Add(TppJvInspectorTypeInfoRegItem.Create(TppJvInspectorTimeItem, TypeInfo(TTime)));
    Add(TppJvInspectorTypeInfoRegItem.Create(TppJvInspectorDateTimeItem, TypeInfo(TDateTime)));
  end;
  with TppJvInspectorPropData.ItemRegister do
    Add(TppJvInspectorPropRegItem.Create(TppJvInspectorFontNameItem, TFont, 'Name', nil));
end;

const
  SizingConsts: array [0..3] of TIdentMapEntry =
   ((Value: irsNoReSize; Name: 'irsNoReSize'),
    (Value: irsNameHeight; Name: 'irsNameHeight'),
    (Value: irsValueHeight; Name: 'irsValueHeight'),
    (Value: irsItemHeight; Name: 'irsItemHeight'));

function irsToInt(const Ident: string; var Int: Longint): Boolean;
begin
  Result := IdentToInt(Ident, Int, SizingConsts);
end;

function IntToirs(Int: Longint; var Ident: string): Boolean;
begin
  Result := IntToIdent(Int, Ident, SizingConsts);
end;

procedure RegisterConsts;
begin
  RegisterIntegerConsts(TypeInfo(TItemRowSizing), irsToInt, IntToirs);
end;







initialization
  CanvasStack := TCanvasStack.Create(512);
  InspReg := TInspReg.Create;
  RegisterTypeKinds;
  RegisterConsts;
  DataRegister := TppJvInspDataReg.Create;

finalization
  DataRegister.Free; // Can't use FreeAndNil as it will set DataRegister to nil before it's destroyed.
  DataRegister := nil;
  TppJvCustomInspectorData.ItemRegister.Free;
  TppJvInspectorPropData.ItemRegister.Free;
  TppJvInspectorVarData.ItemRegister.Free;
  InspReg.Free;
  CanvasStack.Free;

end.
