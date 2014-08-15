{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressLayoutControl main components                     }
{                                                                    }
{           Copyright (c) 2001-2010 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSLAYOUTCONTROL AND ALL          }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
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

unit dxLayoutContainer;

{$I cxVer.inc}

interface

uses
  Messages, Windows, SysUtils, Classes, Menus, Graphics,
  Forms, Controls {after Forms for D12},
  StdCtrls, ExtCtrls, IniFiles, Contnrs, ImgList,
  dxCore, dxMessages, cxClasses, cxGeometry, cxGraphics, cxControls,
  cxLookAndFeels, cxLibraryConsts, cxLookAndFeelPainters,
  dxLayoutLookAndFeels, dxLayoutCommon, dxLayoutSelection, cxPC;

const
  htError = -1;
  htNone = 0;
  htCustomizeForm = 1;
  htItem = 10;
  htGroup = 20;
  htClientArea = 30;

  dxLayoutItemControlDefaultMinHeight = 20;
  dxLayoutItemControlDefaultMinWidth = 20;

  dxLayoutItemMinSize = 5;
  dxLayoutVersion = 3;

type
  //Base
  TdxCustomLayoutItem = class;
  TdxCustomLayoutItemClass = class of TdxCustomLayoutItem;
  TdxLayoutItem = class;
  TdxLayoutGroup = class;
  TdxLayoutGroupClass = class of TdxLayoutGroup;
  TdxLayoutEmptySpaceItem = class;
  TdxLayoutEmptySpaceItemClass = class of TdxLayoutEmptySpaceItem;
  TdxLayoutLabeledItem = class;
  TdxLayoutLabeledItemClass = class of TdxLayoutLabeledItem;
  TdxLayoutSeparatorItem = class;
  TdxLayoutSeparatorItemClass = class of TdxLayoutSeparatorItem;
  TdxLayoutSplitterItem = class;

  //Secondary
  TdxLayoutContainer = class;
  TdxLayoutAlignmentConstraint = class;
  TdxCustomLayoutHitTest = class;
  TdxLayoutGroupHelper = class;
  TdxLayoutGroupHelperClass = class of TdxLayoutGroupHelper;
  TdxLayoutCloneDataList = class;

  //Painter
  TdxLayoutContainerPainter = class;
  TdxLayoutContainerPainterClass = class of TdxLayoutContainerPainter;
  TdxCustomLayoutItemPainter = class;
  TdxCustomLayoutItemPainterClass = class of TdxCustomLayoutItemPainter;
  TdxLayoutBasicItemPainter = class;
  TdxLayoutBasicItemPainterClass = class of TdxLayoutBasicItemPainter;
  TdxLayoutItemPainter = class;
  TdxLayoutItemPainterClass = class of TdxLayoutItemPainter;
  TdxLayoutGroupPainter = class;
  TdxLayoutGroupPainterClass = class of TdxLayoutGroupPainter;
  TdxLayoutControlItemControlPainter = class;
  TdxLayoutControlItemControlPainterClass = class of TdxLayoutControlItemControlPainter;
  TdxLayoutItemControlPainter = class;
  TdxLayoutItemControlPainterClass = class of TdxLayoutItemControlPainter;
  TdxCustomLayoutItemCaptionPainter = class;
  TdxCustomLayoutItemCaptionPainterClass = class of TdxCustomLayoutItemCaptionPainter;
  TdxLayoutGroupButtonPainter = class;
  TdxLayoutGroupButtonPainterClass = class of TdxLayoutGroupButtonPainter;
  TdxLayoutEmptySpaceItemPainter = class;
  TdxLayoutEmptySpaceItemPainterClass = class of TdxLayoutEmptySpaceItemPainter;
  TdxLayoutDirectionalItemPainter = class;
  TdxLayoutDirectionalItemPainterClass = class of TdxLayoutDirectionalItemPainter;
  TdxLayoutSeparatorItemPainter = class;
  TdxLayoutSeparatorItemPainterClass = class of TdxLayoutSeparatorItemPainter;
  TdxLayoutSplitterItemPainter = class;
  TdxLayoutSplitterItemPainterClass = class of TdxLayoutSplitterItemPainter;

  // ViewInfo
  TdxLayoutContainerViewInfo = class;
  TdxLayoutContainerViewInfoClass = class of TdxLayoutContainerViewInfo;
  TdxCustomLayoutElementViewInfo = class;
  TdxCustomLayoutItemElementViewInfo = class;
  TdxCustomLayoutItemCaptionViewInfo = class;
  TdxCustomLayoutItemViewInfo = class;
  TdxCustomLayoutItemViewInfoClass = class of TdxCustomLayoutItemViewInfo;
  TdxLayoutItemCaptionViewInfo = class;
  TdxLayoutControlItemControlViewInfo = class;
  TdxLayoutItemControlViewInfo = class;
  TdxLayoutItemControlViewInfoClass = class of TdxLayoutItemControlViewInfo;
  TdxLayoutLabeledItemViewInfo = class;
  TdxLayoutControlItemViewInfo = class;
  TdxLayoutItemViewInfo = class;
  TdxLayoutItemViewInfoClass = class of TdxLayoutItemViewInfo;
  TdxLayoutGroupViewInfo = class;
  TdxLayoutGroupViewInfoClass = class of TdxLayoutGroupViewInfo;
  TdxLayoutGroupButtonViewInfo = class;
  TdxLayoutGroupButtonViewInfoClass = class of TdxLayoutGroupButtonViewInfo;
  TdxLayoutEmptySpaceItemViewInfo = class;
  TdxLayoutEmptySpaceItemViewInfoClass = class of TdxLayoutEmptySpaceItemViewInfo;
  TdxLayoutSeparatorItemViewInfo = class;
  TdxLayoutSeparatorItemViewInfoClass = class of TdxLayoutSeparatorItemViewInfo;
  TdxLayoutSplitterItemViewInfo = class;
  TdxLayoutSplitterItemViewInfoClass = class of TdxLayoutSplitterItemViewInfo;

  TdxLayoutGroupViewInfoSpecific = class;
  TdxLayoutGroupViewInfoSpecificClass = class of TdxLayoutGroupViewInfoSpecific;
  TdxLayoutGroupViewInfoTabbedSpecific = class;

  // custom item

  TdxLayoutAlignHorz = (ahLeft, ahCenter, ahRight, ahClient, ahParentManaged);
  TdxLayoutAlignVert = (avTop, avCenter, avBottom, avClient, avParentManaged);
  TdxLayoutItemControlAlignHorz = ahLeft..ahClient;
  TdxLayoutItemControlAlignVert = avTop..avClient;
  TdxLayoutAutoAlign = (aaHorizontal, aaVertical);
  TdxLayoutAutoAligns = set of TdxLayoutAutoAlign;
  TdxLayoutDirection = (ldHorizontal, ldVertical, ldTabbed);
  TdxLayoutAreaPart = (apNone, apLeft, apTop, apRight, apBottom, apCenter,
    apBefore, apAfter, apBeforeContent, apAfterContent, apFirstChild, apLastChild);
  TdxLayoutActionType = (atNone, atInsert, atCreateGroup, atContentInsert);

  TdxLayoutCustomizeFormUpdateType = (cfutCaption, cfutAvailableItems, cfutVisibleItems, cfutSelection, cfutView, cfutDragAndDropState);
  TdxLayoutCustomizeFormUpdateTypes = set of TdxLayoutCustomizeFormUpdateType;

  TdxLayoutAvailableItemsViewKind = (aivkList, aivkTree);
  TdxLayoutItemChangedEvent = procedure(AItem: TdxCustomLayoutItem) of object;

  TdxLayoutCustomizeFormMenuItem = (cfmiAlignHorz, cfmiAlignVert, cfmiDirection, cfmiCaptionLayout, cfmiCaptionAlignHorz,
    cfmiCaptionAlignVert, cfmiCaption, cfmiBorder, cfmiExpandButton);
  TdxLayoutCustomizeFormMenuItems = set of TdxLayoutCustomizeFormMenuItem;

  IdxLayoutContainer = interface
  ['{85310BD8-3D7A-454F-A54B-9898C0AA55A2}']
    function GetContainer: TdxLayoutContainer;
  end;

  IdxLayoutDragAndDropHelper = interface
  ['{A5971298-2944-4D83-AD9B-78AD33DCE2DE}']
    procedure BeginDragAndDrop;
    function CanDragAndDrop: Boolean;
    procedure FinishDragAndDrop(Accepted: Boolean);
  end;

  IdxLayoutItemsHelper = interface
  ['{B179615D-271F-4EFE-B87D-FBBF7F870EA7}']
    procedure AddAvailableItem(AItem: TdxCustomLayoutItem);
    procedure ExtractAvailableItem(AItem: TdxCustomLayoutItem);
    function GetRoot: TdxLayoutGroup;
    procedure SetRootGroup(Value: TdxLayoutGroup);
  end;

  IdxLayoutControl = interface
  ['{DBE31AB0-D70F-4AF3-A2C7-6402163415E4}']
    function CanGetHitTest(const P: TPoint): Boolean;
    function CanProcessKeyboard: Boolean;
    function CanUpdate: Boolean;
    function CreateCustomizationControlHelper(AItem: TdxLayoutItem): TdxControlsDesignSelectorHelper;
    function GetAutoControlAlignment: Boolean;
    function GetAutoControlTabOrders: Boolean;
    function GetCanvas: TcxCanvas;
    function GetClientBounds: TRect;
    function GetClientRect: TRect;
    function GetDisabledImages: TCustomImageList;
    function GetImages: TCustomImageList;
    function GetIsFocusControlOnItemCaptionClick: Boolean;
    function GetIsSizableHorz: Boolean;
    function GetIsSizableVert: Boolean;
    function GetItemsOwner: TComponent;
    function GetItemsParent: TcxControl;
    function GetItemsParentComponent: TComponent;
    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
    function GetScrollOffset: TPoint;
    function GetShowLockedGroupChildren: Boolean;
    function GetSelectionHelperClass: TdxLayoutRunTimeSelectionHelperClass;
    function HasBackground: Boolean;

    function CanRestore: Boolean;
    function StoringSupports: Boolean;
    procedure Restore;
    procedure Store;

    procedure CustomizeFormPostUpdate(AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes);
    procedure CustomizationChanged;
    procedure MakeVisible(AItem: TdxCustomLayoutItem);
    procedure Modified;
    procedure PostBuildSelectionLayer;
    procedure PostInvalidateSelectionLayer(const R: TRect);
    procedure PostPlaceControls;
    procedure SizeAdjustment;
  end;

  { TdxUndoRedoManager }

  TdxUndoRedoManager = class(TPersistent)
  private
    FContainer: TdxLayoutContainer;
    FCurrentLayout: TMemIniFile;
    FIndex: Integer;
    FLockCount: Integer;
    FUndoList: TObjectList;
    procedure AddUndo(ALayout: TMemIniFile);
    function GetRedoCount: Integer;
    function GetUndoCount: Integer;
  protected
    procedure CancelLastUndo;

    function IsLocked: Boolean;
    property RedoCount: Integer read GetRedoCount;
    property UndoCount: Integer read GetUndoCount;
  public
    constructor Create(AContainer: TdxLayoutContainer); virtual;
    destructor Destroy; override;
    function CanRedo: Boolean;
    function CanUndo: Boolean;
    procedure Clear;
    procedure Redo;
    procedure SaveLayout;
    procedure Undo;

    property Container: TdxLayoutContainer read FContainer;
  end;

  TdxCustomLayoutItemOptions = class(TPersistent)
  private
    FItem: TdxCustomLayoutItem;
  protected
    procedure BeginUpdate;
    procedure EndUpdate;

    procedure Changed; virtual;
    property Item: TdxCustomLayoutItem read FItem;
  public
    constructor Create(AItem: TdxCustomLayoutItem); virtual;
  end;

  { CustomizeForm }

  TdxLayoutControlCustomCustomizeForm = class(TForm)
  private
    FContainer: TdxLayoutContainer;
    procedure SetContainer(AValue: TdxLayoutContainer);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function CanModify: Boolean; virtual;
    function CanShowItem(AItem: TdxCustomLayoutItem): Boolean; virtual;
    function CanShowMenuItem(AMenuItem: TdxLayoutCustomizeFormMenuItem): Boolean;
    function GetWndParent: THandle; virtual;
    procedure ItemChanged(AItem: TdxCustomLayoutItem); virtual;
    function GetLayoutPopupMenu: TPopupMenu; virtual;
    procedure InitializeControl; virtual;
  public
    destructor Destroy; override;

    function GetHitTest(const P: TPoint): TdxCustomLayoutHitTest; virtual;
    procedure ToggleHotTrackState(AItem: TdxCustomLayoutItem); virtual;

    procedure UpdateAvailableItems; virtual;
    procedure UpdateCaption; virtual;
    procedure UpdateContent; virtual;
    procedure UpdateDragAndDropState; virtual;
    procedure UpdateSelection; virtual;
    procedure UpdateView; virtual;
    procedure UpdateVisibleItems; virtual;

    property Container: TdxLayoutContainer read FContainer write SetContainer;
    property LayoutPopupMenu: TPopupMenu read GetLayoutPopupMenu;
  end;
  TdxLayoutControlCustomCustomizeFormClass = class of TdxLayoutControlCustomCustomizeForm;

  { TdxLayoutItemImageOptions }

  TdxCustomLayoutItemImageOptions = class(TdxCustomLayoutItemOptions)
  private
    FGlyph: TBitmap;
    FImageIndex: Integer;
    procedure SetGlyph(AValue: TBitmap);
    procedure SetImageIndex(AValue: Integer);

    procedure GlyphChanged(Sender: TObject);
  protected
    function GetCurrentImage(out AGlyph: TBitmap; out AImages: TCustomImageList; out AImageIndex: Integer): Boolean;
    function GetImageList(AEnabled: Boolean): TCustomImageList;
    function GetImageSize: TSize;
    function IsImageAssigned: Boolean;
  public
    constructor Create(AItem: TdxCustomLayoutItem); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
  end;

  TdxAlignmentVert = (tavTop, tavCenter, tavBottom);
  TdxCaptionLayout = (clLeft, clTop, clRight, clBottom);
  TdxLayoutItemCaptionVisibleElement = (cveImage, cveText);
  TdxLayoutItemCaptionVisibleElements = set of TdxLayoutItemCaptionVisibleElement;

  TdxCustomLayoutItemCaptionOptions = class(TdxCustomLayoutItemOptions)
  private
    FAlignHorz: TAlignment;
    FAlignVert: TdxAlignmentVert;
    FImageOptions: TdxCustomLayoutItemImageOptions;
    FLayout: TdxCaptionLayout;
    FShowAccelChar: Boolean;
    FText: string;
    FVisibleElements: TdxLayoutItemCaptionVisibleElements;
    FVisible: Boolean;
    function GetGlyph: TBitmap;
    function GetImageIndex: Integer;
    procedure SetAlignHorz(Value: TAlignment);
    procedure SetAlignVert(Value: TdxAlignmentVert);
    procedure SetGlyph(AValue: TBitmap);
    procedure SetImageIndex(AValue: Integer);
    procedure SetImageOptions(Value: TdxCustomLayoutItemImageOptions);
    procedure SetLayout(Value: TdxCaptionLayout);
    procedure SetShowAccelChar(Value: Boolean);
    procedure SetVisibleElements(Value: TdxLayoutItemCaptionVisibleElements);
    procedure SetVisible(Value: Boolean);
  protected
    function IsTextStored: Boolean; virtual;
    function GetText: string; virtual;
    procedure SetText(const Value: string); virtual;

    property AlignVert: TdxAlignmentVert read FAlignVert write SetAlignVert;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property ImageIndex: Integer read GetImageIndex write SetImageIndex default -1;
    property ImageOptions: TdxCustomLayoutItemImageOptions read FImageOptions write SetImageOptions;
    property Layout: TdxCaptionLayout read FLayout write SetLayout;
    property VisibleElements: TdxLayoutItemCaptionVisibleElements read FVisibleElements write SetVisibleElements default [cveImage, cveText];
  public
    constructor Create(AItem: TdxCustomLayoutItem); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property AlignHorz: TAlignment read FAlignHorz write SetAlignHorz default taLeftJustify;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar default True;
    property Text: string read GetText write SetText stored IsTextStored;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;
  TdxCustomLayoutItemCaptionOptionsClass = class of TdxCustomLayoutItemCaptionOptions;

  TdxLayoutSizeOptionsValue = (sovSizableHorz, sovSizableVert);
  TdxLayoutSizeOptionsValues = set of TdxLayoutSizeOptionsValue;

  TdxLayoutSizeOptions = class(TdxCustomLayoutItemOptions)
  private
    FAssignedValues: TdxLayoutSizeOptionsValues;
    FSizableHorz: Boolean;
    FSizableVert: Boolean;
    FWidth: Integer;
    FHeight: Integer;
    function GetSizableHorz: Boolean;
    function GetSizableVert: Boolean;
    procedure SetAssignedValues(Value: TdxLayoutSizeOptionsValues);
    procedure SetSizableHorz(Value: Boolean);
    procedure SetSizableVert(Value: Boolean);
    procedure SetHeight(Value: Integer);
    procedure SetWidth(Value: Integer);

    function IsSizableHorzStored: Boolean;
    function IsSizableVertStored: Boolean;
  protected
    procedure Changed; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property AssignedValues: TdxLayoutSizeOptionsValues read FAssignedValues write SetAssignedValues default [];
    property SizableHorz: Boolean read GetSizableHorz write SetSizableHorz stored IsSizableHorzStored;
    property SizableVert: Boolean read GetSizableVert write SetSizableVert stored IsSizableVertStored;
    property Height: Integer read FHeight write SetHeight default 0;
    property Width: Integer read FWidth write SetWidth default 0;
  end;

  TdxLayoutOffsets = class(TdxCustomLayoutItemOptions)
  private
    FBottom: Integer;
    FLeft: Integer;
    FRight: Integer;
    FTop: Integer;
  protected
    function GetValue(Index: Integer): Integer; virtual;
    procedure SetValue(Index: Integer; Value: Integer); virtual;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Bottom: Integer index 1 read GetValue write SetValue default 0;
    property Left: Integer index 2 read GetValue write SetValue default 0;
    property Right: Integer index 3 read GetValue write SetValue default 0;
    property Top: Integer index 4 read GetValue write SetValue default 0;
  end;

  TdxLayoutPadding = class(TdxLayoutOffsets)
  private
    FAssignedValues: TdxLayoutPaddingAssignedValues;
    function IsValueStored(Index: Integer): Boolean;
    procedure SetAssignedValues(Value: TdxLayoutPaddingAssignedValues);
  protected
    function GetValue(Index: Integer): Integer; override;
    procedure SetValue(Index: Integer; Value: Integer); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property AssignedValues: TdxLayoutPaddingAssignedValues read FAssignedValues write SetAssignedValues default [];
    property Bottom stored IsValueStored;
    property Left stored IsValueStored;
    property Right stored IsValueStored;
    property Top stored IsValueStored;
  end;

  TdxLayoutItemChangeType = (ictHard, ictMedium, ictLight, ictComplex);

  TdxCustomLayoutItemAssignedValue = (liavEnabled);
  TdxCustomLayoutItemAssignedValues = set of TdxCustomLayoutItemAssignedValue;

  TdxCustomLayoutItem = class(TComponent, IdxLayoutLookAndFeelUser, IdxLayoutSelectableItem)
  private
    FAlignHorz: TdxLayoutAlignHorz;
    FAlignmentConstraint: TdxLayoutAlignmentConstraint;
    FAlignVert: TdxLayoutAlignVert;
    FAllowRemove: Boolean;
    FAssignedValues: TdxCustomLayoutItemAssignedValues;
    FCachedTextHeight: Integer;
    FContainer: TdxLayoutContainer;
    FCustomization: Boolean;
    FData: Pointer;
    FEnabled: Boolean;
    FIsUserDefined: Boolean;
    FLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
    FLoadedIndex: Integer;
    FOffsets: TdxLayoutOffsets;
    FPadding: TdxLayoutPadding;
    FParent: TdxLayoutGroup;
    FVisible: Boolean;

    FCaptionOptions: TdxCustomLayoutItemCaptionOptions;
    FSizeOptions: TdxLayoutSizeOptions;

    FOnCaptionClick: TNotifyEvent;

    function GetRealAlignHorz: TdxLayoutAlignHorz;
    function GetRealAlignVert: TdxLayoutAlignVert;

    function GetActuallyVisible: Boolean;
    function GetAutoAligns: TdxLayoutAutoAligns;
    function GetAlignHorz: TdxLayoutAlignHorz;
    function GetAlignVert: TdxLayoutAlignVert;
    function GetCaption: string;
    function GetCaptionForCustomizeForm: string;
    function GetEnabled: Boolean;
    function GetIndex: Integer;
    function GetIsRoot: Boolean;
    function GetViewInfo: TdxCustomLayoutItemViewInfo;
    function GetVisibleIndex: Integer;
    procedure SetAlignHorz(Value: TdxLayoutAlignHorz);
    procedure SetAlignmentConstraint(Value: TdxLayoutAlignmentConstraint);
    procedure SetAlignVert(Value: TdxLayoutAlignVert);
    procedure SetAutoAligns(Value: TdxLayoutAutoAligns);
    procedure SetCaption(const Value: string);
    procedure SetCaptionOptions(const Value: TdxCustomLayoutItemCaptionOptions);
    procedure SetContainer(Value: TdxLayoutContainer);
    procedure SetCustomization(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetLayoutLookAndFeel(Value: TdxCustomLayoutLookAndFeel);
    procedure SetIndex(Value: Integer);
    procedure SetOffsets(const Value: TdxLayoutOffsets);
    procedure SetPadding(const Value: TdxLayoutPadding);
    procedure SetParent(Value: TdxLayoutGroup);
    procedure SetShowCaption(Value: Boolean);
    procedure SetVisible(Value: Boolean);
    procedure SetVisibleIndex(Value: Integer);
    procedure SetSizeOptions(Value: TdxLayoutSizeOptions);

    function GetHeight: Integer;
    function GetWidth: Integer;
    procedure SetHeight(Value: Integer);
    procedure SetWidth(Value: Integer);

    procedure ReadIndex(Reader: TReader);
    procedure WriteIndex(Writer: TWriter);

    function IsAlignHorzStored: Boolean;
    function IsAlignVertStored: Boolean;
    function IsEnabledStored: Boolean;
  protected
    // IdxLayoutLookAndFeelUser
    procedure IdxLayoutLookAndFeelUser.BeginLookAndFeelDestroying = BeginLayoutLookAndFeelUserDestroying;
    procedure IdxLayoutLookAndFeelUser.EndLookAndFeelDestroying = EndLayoutLookAndFeelUserDestroying;
    procedure IdxLayoutLookAndFeelUser.LookAndFeelChanged = LayoutLookAndFeelUserChanged;
    procedure IdxLayoutLookAndFeelUser.LookAndFeelDestroyed = LayoutLookAndFeelUserDestroyed;
    procedure BeginLayoutLookAndFeelUserDestroying; stdcall;
    procedure EndLayoutLookAndFeelUserDestroying; stdcall;
    procedure LayoutLookAndFeelUserChanged; stdcall;
    procedure LayoutLookAndFeelUserDestroyed; stdcall;
    //IdxLayoutSelectableItem
    function CanDelete: Boolean; virtual;
    function IsOwner(AOwner: TComponent): Boolean; virtual;
    procedure SelectComponent(AShift: TShiftState = []); virtual;
    procedure SelectParent; virtual;
    procedure SelectionChanged; virtual;
    function IdxLayoutSelectableItem.IsVisible = IsSelectableItemVisible;
    function IsSelectableItemVisible: Boolean; virtual;
    procedure IdxLayoutSelectableItem.MakeVisible = SelectableItemMakeVisible;
    procedure SelectableItemMakeVisible; virtual;

    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;
    procedure SetName(const Value: TComponentName); override;
    procedure SetParentComponent(Value: TComponent); override;

    // LayoutLookAndFeel
    procedure LayoutLookAndFeelChanged; virtual;
    procedure LayoutLookAndFeelChanging; virtual;
    function CanBeAlone: Boolean; virtual;
    function CanDragAndDrop: Boolean; virtual;
    function CanProcessAccel(out AItem: TdxCustomLayoutItem): Boolean; virtual;
    function CanRemove: Boolean; virtual;
    function CanResizeHorz: Boolean; virtual;
    function CanResizeVert: Boolean; virtual;
    function HasControl: Boolean; virtual;
    function HasCaption: Boolean; virtual; // #DG !!!

    procedure DoGetTabOrderList(List: TList); virtual;
    procedure GetTabOrderList(List: TList);

    //inplace renaming
    function GetInplaceRenameCaption: string; virtual;
    procedure SetInplaceRenameCaption(const ACaption: string); virtual;

    procedure DoCaptionDown; dynamic;
    procedure DoCaptionClick; dynamic;
    procedure DoPack; virtual;
    function DoProcessAccel: Boolean; dynamic;

    function GetParentManagedAlignHorz: TdxLayoutAlignHorz; virtual;
    function GetParentManagedAlignVert: TdxLayoutAlignVert; virtual;
    function GetBaseName: string; virtual;
    function GetCursor(X, Y: Integer): TCursor; virtual;
    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel; virtual;
    function GetShowCaption: Boolean; virtual; // #DG !!!
    function GetVisible: Boolean;
    function GetOptions: TdxCustomLayoutLookAndFeelOptions; virtual; abstract;

    procedure BeforeCalculateViewInfo; virtual;
    procedure AfterCalculateViewInfo; virtual;
    procedure ApplyCalculatedChanges; virtual;

    procedure CheckIndex; virtual;
    procedure PopulateItems(AList: TList); virtual;

    function IsExpanded: Boolean; virtual;

    function IsParentGroup(AParentGroup: TdxLayoutGroup): Boolean;
    function IsChildItem(AChildItem: TdxCustomLayoutItem): Boolean;

    function CanInit: Boolean; virtual;
    procedure DoInit; virtual;
    procedure Init;

    function IsAvailable: Boolean;
    function IsDesigning: Boolean;
    function IsDestroying: Boolean;
    function IsDragged: Boolean;
    function IsImageVisible: Boolean;
    function IsLoading: Boolean;
    function IsLocked: Boolean; virtual;
    function IsParentLocked: Boolean; virtual;
    function IsSelected: Boolean;
    function IsTextVisible: Boolean;
    function IsVisibleForCustomization: Boolean; virtual;

    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure ProcessAccel; dynamic;
    function ProcessDialogChar(ACharCode: Word): Boolean; virtual;
    function ProcessDialogKey(ACharCode: Word; AKeyData: Integer; AFocusedItem: TdxLayoutItem): Boolean; virtual;
    procedure RestoreItemControlSize; virtual;
    procedure ResetCachedTextHeight;

    class function GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass; virtual;
    class function GetItemClassKind: Integer; virtual;
    function GetParentHelperClass: TdxLayoutGroupHelperClass;
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; virtual; abstract;

    procedure LoadFromIni(AIniFile: TCustomIniFile; const ASection: string; AVersion: Integer); virtual;
    procedure SaveToIni(AIniFile: TCustomIniFile; const ASection: string); virtual;

    function Focused: Boolean; virtual;

    //Notification
    procedure DoItemChanged;

    // Changing
    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate(ANeedPack: Boolean = True);
    procedure Changed(AType: TdxLayoutItemChangeType = ictHard);
    procedure DoChanged(AType: TdxLayoutItemChangeType); virtual;
    procedure ParentChanged(AType: TdxLayoutItemChangeType);
    procedure ContainerChanged; virtual;
    procedure CustomizationChanged; virtual;
    procedure EnabledChanged; virtual;

    procedure CreateOptions; virtual;
    procedure DestroyOptions; virtual;

    function CanFocus: Boolean; virtual;
    function IsFocused: Boolean; virtual;

    property CachedTextHeight: Integer read FCachedTextHeight write FCachedTextHeight;
    property Customization: Boolean read FCustomization write SetCustomization;
    property IsUserDefined: Boolean read FIsUserDefined;
//    property UserWidth: Integer read FUserWidth write FUserWidth;
    property Padding: TdxLayoutPadding read FPadding write SetPadding;
    property OnCaptionClick: TNotifyEvent read FOnCaptionClick write FOnCaptionClick;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure BeforeDestruction; override;
    destructor Destroy; override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    function CanMoveTo(AParent: TdxCustomLayoutItem): Boolean; virtual;
    procedure MakeVisible;
    function Move(AParent: TdxLayoutGroup; AIndex: Integer; APack: Boolean = False): Boolean;
    function MoveTo(AParent: TdxLayoutGroup; AVisibleIndex: Integer; APack: Boolean = False): Boolean;
    procedure Pack;
    function PutIntoHiddenGroup(ALayoutDirection: TdxLayoutDirection): TdxLayoutGroup;

    procedure ToggleHotTrackState;

    property ActuallyVisible: Boolean read GetActuallyVisible;
    property CaptionForCustomizeForm: string read GetCaptionForCustomizeForm;
    property Container: TdxLayoutContainer read FContainer write SetContainer;
    property Data: Pointer read FData write FData;
    property Index: Integer read GetIndex write SetIndex;
    property IsRoot: Boolean read GetIsRoot;
    property ViewInfo: TdxCustomLayoutItemViewInfo read GetViewInfo;
    property VisibleIndex: Integer read GetVisibleIndex write SetVisibleIndex;

    property Width: Integer read GetWidth write SetWidth;
    property Height: Integer read GetHeight write SetHeight;
  published
    property AutoAligns: TdxLayoutAutoAligns read GetAutoAligns write SetAutoAligns stored False; // obsolete
    property AlignHorz: TdxLayoutAlignHorz read GetAlignHorz write SetAlignHorz stored IsAlignHorzStored;
    property AlignVert: TdxLayoutAlignVert read GetAlignVert write SetAlignVert stored IsAlignVertStored;
    property AlignmentConstraint: TdxLayoutAlignmentConstraint read FAlignmentConstraint
      write SetAlignmentConstraint;

    property AllowRemove: Boolean read FAllowRemove write FAllowRemove default True;
    property Caption: string read GetCaption write SetCaption stored False; // obsolete
    property CaptionOptions: TdxCustomLayoutItemCaptionOptions read FCaptionOptions write SetCaptionOptions;
    property Enabled: Boolean read GetEnabled write SetEnabled stored IsEnabledStored;
    property LookAndFeel: TdxCustomLayoutLookAndFeel read FLayoutLookAndFeel write SetLayoutLookAndFeel stored False; // osolette
    property LayoutLookAndFeel: TdxCustomLayoutLookAndFeel read FLayoutLookAndFeel write SetLayoutLookAndFeel;
    property Offsets: TdxLayoutOffsets read FOffsets write SetOffsets;
    property Parent: TdxLayoutGroup read FParent write SetParent;
    property ShowCaption: Boolean read GetShowCaption write SetShowCaption stored False; // obsolete
    property Visible: Boolean read FVisible write SetVisible default True;
    property SizeOptions: TdxLayoutSizeOptions read FSizeOptions write SetSizeOptions;
  end;

  TdxLayoutBasicItem = class(TdxCustomLayoutItem)
  protected
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; override;
  end;

  TdxLayoutEmptySpaceItem = class(TdxLayoutBasicItem)
  protected
    class function GetItemClassKind: Integer; override;
    function GetBaseName: string; override;
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; override;

    function CanBeAlone: Boolean; override;
  end;

  TdxLayoutDirectionalItem = class(TdxLayoutBasicItem)
  private
    function GetIsVertical: Boolean;
  protected
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; override;

    function CanBeAlone: Boolean; override;
    function GetOptions: TdxCustomLayoutLookAndFeelOptions; override;
  public
    constructor Create(AOwner: TComponent); override;

    property IsVertical: Boolean read GetIsVertical;
  end;

  TdxLayoutSeparatorItem = class(TdxLayoutDirectionalItem)
  protected
    class function GetItemClassKind: Integer; override;
    function GetBaseName: string; override;
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; override;
  end;

  TdxLayoutSplitterItem = class(TdxLayoutDirectionalItem)
  protected
    class function GetItemClassKind: Integer; override;
    function GetBaseName: string; override;
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; override;
  end;

  TdxLayoutLabeledItemCaptionOptions = class(TdxCustomLayoutItemCaptionOptions)
  private
    FCursor: TCursor;
    FWidth: Integer;
    procedure SetWidth(Value: Integer);
  public
    constructor Create(AItem: TdxCustomLayoutItem); override;
    procedure Assign(Source: TPersistent); override;
  published
    property AlignVert default tavCenter;
    property Cursor: TCursor read FCursor write FCursor default crDefault;
    property Glyph;
    property ImageIndex;
    property VisibleElements;
    property Width: Integer read FWidth write SetWidth default 0;
  end;

  TdxLayoutCustomLabeledItem = class(TdxLayoutBasicItem)
  private
    function GetCaptionOptions: TdxLayoutLabeledItemCaptionOptions;
    procedure SetCaptionOptions(Value: TdxLayoutLabeledItemCaptionOptions);
  protected
    function GetParentManagedAlignVert: TdxLayoutAlignVert; override;

    class function GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass; override;
    function GetOptions: TdxCustomLayoutLookAndFeelOptions; override;
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; override;

    property CaptionOptions: TdxLayoutLabeledItemCaptionOptions read GetCaptionOptions write SetCaptionOptions;
  published
    property Padding;
  end;

  TdxLayoutLabeledItem = class(TdxLayoutCustomLabeledItem)
  protected
    class function GetItemClassKind: Integer; override;
    function GetBaseName: string; override;
  published
    property CaptionOptions;
    property OnCaptionClick;
  end;

  // item
  TdxCustomLayoutControlAdapter = class(TPersistent)
  private
    FItem: TdxLayoutItem;
    function GetControl: TControl;
    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
  protected
    function AllowCheckSize: Boolean; virtual;
    procedure HideControlBorder; virtual;
    procedure Init; virtual;
    procedure InternalLayoutLookAndFeelChanged; virtual;
    function NeedBorder: Boolean; virtual;
    function HasBorderProperty: Boolean;
    function ShowItemCaption: Boolean; virtual;
    function UseItemColor: Boolean; virtual;
    //Customization
    procedure EndCustomization; virtual;
    procedure StartCustomization; virtual;

    property Control: TControl read GetControl;
    property Item: TdxLayoutItem read FItem;
    property LayoutLookAndFeel: TdxCustomLayoutLookAndFeel read GetLayoutLookAndFeel;
  public
    constructor Create(AItem: TdxLayoutItem); virtual;
    procedure LayoutLookAndFeelChanging; virtual;
    class procedure Register(AControlClass: TControlClass);
    class procedure Unregister(AControlClass: TControlClass);
  end;
  TdxCustomLayoutControlAdapterClass = class of TdxCustomLayoutControlAdapter;

  TdxLayoutItemCaptionOptions = class(TdxLayoutLabeledItemCaptionOptions)
  published
    property Layout default clLeft;
  end;

  TdxLayoutItemControlOptions = class(TdxCustomLayoutItemOptions)
  private
    FAlignHorz: TdxLayoutItemControlAlignHorz;
    FAlignVert: TdxLayoutItemControlAlignVert;
    FAutoControlAreaAlignment: Boolean;
    FAutoColor: Boolean;
    FMinHeight: Integer;
    FMinWidth: Integer;
    FOpaque: Boolean;
    FShowBorder: Boolean;
    function GetFixedSize: Boolean;
    function GetItem: TdxLayoutItem;
    procedure SetAlignHorz(Value: TdxLayoutItemControlAlignHorz);
    procedure SetAlignVert(Value: TdxLayoutItemControlAlignVert);
    procedure SetAutoControlAreaAlignment(Value: Boolean);
    procedure SetAutoColor(Value: Boolean);
    procedure SetFixedSize(Value: Boolean);
    procedure SetMinHeight(Value: Integer);
    procedure SetMinWidth(Value: Integer);
    procedure SetOpaque(Value: Boolean);
    procedure SetShowBorder(Value: Boolean);
  protected
    property Item: TdxLayoutItem read GetItem;
  public
    constructor Create(AItem: TdxCustomLayoutItem); override;

    function IsHeightFixed: Boolean;
    function IsWidthFixed: Boolean;
  published
    property AlignHorz: TdxLayoutItemControlAlignHorz read FAlignHorz write SetAlignHorz default ahClient;
    property AlignVert: TdxLayoutItemControlAlignVert read FAlignVert write SetAlignVert default avClient;
    property AutoAlignment: Boolean read FAutoControlAreaAlignment write SetAutoControlAreaAlignment stored False; // obsolete
    property AutoControlAreaAlignment: Boolean read FAutoControlAreaAlignment write SetAutoControlAreaAlignment default True;
    property AutoColor: Boolean read FAutoColor write SetAutoColor default False;
    property FixedSize: Boolean read GetFixedSize write SetFixedSize stored False; // deprecated 'Use AlignHorz and AlignVert';
    property MinHeight: Integer read FMinHeight write SetMinHeight default dxLayoutItemControlDefaultMinHeight;
    property MinWidth: Integer read FMinWidth write SetMinWidth default dxLayoutItemControlDefaultMinWidth;
    property Opaque: Boolean read FOpaque write SetOpaque default False;
    property ShowBorder: Boolean read FShowBorder write SetShowBorder default True;
  end;
  TdxLayoutItemControlOptionsClass = class of TdxLayoutItemControlOptions;

  TdxLayoutControlItem = class(TdxLayoutCustomLabeledItem)
  private
    FControlOptions: TdxLayoutItemControlOptions;
    FOriginalControlSize: TPoint;
    function GetCaptionOptions: TdxLayoutItemCaptionOptions;
    function GetViewInfo: TdxLayoutControlItemViewInfo;
    procedure SetCaptionOptions(Value: TdxLayoutItemCaptionOptions);
    procedure SetControlOptions(Value: TdxLayoutItemControlOptions);
  protected
    procedure DoInit; override;
    class function GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass; override;
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; override;

    procedure CreateOptions; override;
    procedure DestroyOptions; override;

    function CanFocusControl: Boolean; virtual;
    function GetControlOptionsClass: TdxLayoutItemControlOptionsClass; virtual;
  public
    property OriginalControlSize: TPoint read FOriginalControlSize write FOriginalControlSize;
    property ViewInfo: TdxLayoutControlItemViewInfo read GetViewInfo;
  published
    property CaptionOptions: TdxLayoutItemCaptionOptions read GetCaptionOptions write SetCaptionOptions;
    property ControlOptions: TdxLayoutItemControlOptions read FControlOptions  write SetControlOptions;
  end;

  TdxLayoutItem = class(TdxLayoutControlItem)
  private
    FControl: TControl;
    FControlLocked: Boolean;
    FControlAdapter: TdxCustomLayoutControlAdapter;
    FControlSizeBeforeDestruction: TPoint;

    FIsNewControlSizeAssigned: Boolean;
    FNewControlSize: TPoint;
    FControlSizeChanged: Boolean;

    FCustomizeControlHelper: TdxControlsDesignSelectorHelper;
    FWindowProcObject: TcxWindowProcLinkedObject;

    function GetCaptionOptions: TdxLayoutItemCaptionOptions;
    function GetDesignSelectorRect: TRect;
    function GetViewInfo: TdxLayoutItemViewInfo;
    function GetWinControl: TWinControl;
    procedure SetCaptionOptions(Value: TdxLayoutItemCaptionOptions);
    procedure SetControl(Value: TControl);

    function CanFocusControlOnCaptionClick: Boolean;
    procedure CreateControlAdapter;
  protected
    class function GetItemClassKind: Integer; override;

    // CustomItem
    function CanDelete: Boolean; override;
    function CanProcessAccel(out AItem: TdxCustomLayoutItem): Boolean; override;
    procedure ContainerChanged; override;
    procedure CustomizationChanged; override;
    procedure DoCaptionDown; override;
    procedure DoGetTabOrderList(List: TList); override;
    function GetBaseName: string; override;
    procedure ProcessAccel; override;
    procedure RestoreItemControlSize; override;

    procedure BeforeCalculateViewInfo; override;
    procedure ApplyCalculatedChanges; override;
    procedure LayoutLookAndFeelChanging; override;

    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; override;

    function CanFocusControl: Boolean; override;
    procedure ControlWndProc(var Message: TMessage); virtual;
    function IsDesignSelectorVisible: Boolean;
    function HasControl: Boolean; override;
    function HasWinControl: Boolean;
    procedure SaveControlSizeBeforeDestruction;
    procedure SaveOriginalControlSize;
    procedure SetControlEnablement;
    procedure SetControlFocus;
    procedure SetControlVisibility;
    procedure UpdateDesignSelectors;

    property ControlAdapter: TdxCustomLayoutControlAdapter read FControlAdapter;
    property ControlLocked: Boolean read FControlLocked;
    property ControlSizeBeforeDestruction: TPoint read FControlSizeBeforeDestruction;
    property DesignSelectorRect: TRect read GetDesignSelectorRect;
    property WinControl: TWinControl read GetWinControl;
  public
    destructor Destroy; override;

    property ViewInfo: TdxLayoutItemViewInfo read GetViewInfo;
  published
    property CaptionOptions: TdxLayoutItemCaptionOptions read GetCaptionOptions write SetCaptionOptions;
    property Control: TControl read FControl write SetControl;
    property OnCaptionClick;
  end;
  TdxLayoutItemClass = class of TdxLayoutItem;

  // group

  TdxLayoutGroupHelper = class
  public
    class function GetChildItemsAlignHorz: TdxLayoutAlignHorz; virtual;
    class function GetChildItemsAlignVert: TdxLayoutAlignVert; virtual;
    class function GetOrthogonalDirection: TdxLayoutDirection; virtual;
    class function GetSpecificClass: TdxLayoutGroupViewInfoSpecificClass; virtual;
  end;

  TdxLayoutHorizontalGroupHelper = class(TdxLayoutGroupHelper)
  public
    class function GetChildItemsAlignHorz: TdxLayoutAlignHorz; override;
    class function GetChildItemsAlignVert: TdxLayoutAlignVert; override;
    class function GetOrthogonalDirection: TdxLayoutDirection; override;
    class function GetSpecificClass: TdxLayoutGroupViewInfoSpecificClass; override;
  end;

  TdxLayoutVerticalGroupHelper = class(TdxLayoutGroupHelper)
  public
    class function GetChildItemsAlignHorz: TdxLayoutAlignHorz; override;
    class function GetChildItemsAlignVert: TdxLayoutAlignVert; override;
    class function GetOrthogonalDirection: TdxLayoutDirection; override;
    class function GetSpecificClass: TdxLayoutGroupViewInfoSpecificClass; override;
  end;

  TdxLayoutTabbedGroupHelper = class(TdxLayoutHorizontalGroupHelper)
  public
    class function GetChildItemsAlignHorz: TdxLayoutAlignHorz; override;
    class function GetChildItemsAlignVert: TdxLayoutAlignVert; override;
    class function GetOrthogonalDirection: TdxLayoutDirection; override;
    class function GetSpecificClass: TdxLayoutGroupViewInfoSpecificClass; override;
  end;

  TdxLayoutTabbedOptions = class(TcxCustomTabControlProperties)
  private
    FImages: TcxImageList;
    function GetGroup: TdxLayoutGroup;
    function GetItemCaption(AItem: TdxCustomLayoutItem): string;
  protected
    procedure CheckTabs;
    procedure DeleteTab(AItem: TdxCustomLayoutItem);
    function GetItem(AIndex: Integer): TdxCustomLayoutItem;
    procedure InsertTab(AItem: TdxCustomLayoutItem);
    procedure RefreshImages;
    procedure RefreshTabsCaption;
    procedure RefreshTabsEnabled;
    procedure RefreshTabsVisible;
    property Group: TdxLayoutGroup read GetGroup;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
  published
    property CloseButtonMode;
    property HideTabs;
    property HotTrack;
    property ImageBorder;
    property MultiLine;
    property NavigatorPosition;
    property Options;
    property RaggedRight;
    property Rotate;
    property RotatedTabsMaxWidth;
    property ScrollOpposite;
    property ShowFrame;
    property TabCaptionAlignment;
    property TabHeight;
    property TabPosition;
    property TabWidth;
  end;

  TdxLayoutGroupButtons = class;
  TdxLayoutGroupButtonOptions = class;

  TdxLayoutGroupButton = class(TCollectionItem)
  private
    FEnabled: Boolean;
    FGlyph: TBitmap;
    FHeight: Cardinal;
    FHint: string;
    FTag: Integer;
    FVisible: Boolean;
    FWidth: Cardinal;
    FOnClick: TNotifyEvent;
    FOnExpandButtonClick: TNotifyEvent;
    function GetButtons: TdxLayoutGroupButtons;
    procedure SetEnabled(AValue: Boolean);
    procedure SetGlyph(AValue: TBitmap);
    procedure SetHeight(AValue: Cardinal);
    procedure SetVisible(AValue: Boolean);
    procedure SetWidth(AValue: Cardinal);
  protected
    function GetHeight: Integer;
    function GetWidth: Integer;
    procedure DoClick;
    function IsExpandButton: Boolean;

    property Buttons: TdxLayoutGroupButtons read GetButtons;
    property OnExpandButtonClick: TNotifyEvent read FOnExpandButtonClick write FOnExpandButtonClick;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetNamePath: string; override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property Height: Cardinal read FHeight write SetHeight default 0;
    property Hint: string read FHint write FHint;
    property Tag: Integer read FTag write FTag default 0;
    property Visible: Boolean read FVisible write SetVisible default True;
    property Width: Cardinal read FWidth write SetWidth default 0;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TdxLayoutGroupButtons = class(TCollection)
  private
    FOptions: TdxLayoutGroupButtonOptions;
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TdxLayoutGroupButton;
    function GetOptions: TdxLayoutGroupButtonOptions;
    procedure SetItem(Index: Integer; const AValue: TdxLayoutGroupButton);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;

    property Options: TdxLayoutGroupButtonOptions read GetOptions;
  public
    constructor Create(AOptions: TdxLayoutGroupButtonOptions);

    property Items[Index: Integer]: TdxLayoutGroupButton read GetItem write SetItem; default;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TdxLayoutGroupButtonsAlignment = (gbaLeft, gbaRight);

  TdxLayoutGroupButtonOptions = class(TPersistent)
  private
    FAlignment: TdxLayoutGroupButtonsAlignment;
    FButtons: TdxLayoutGroupButtons;
    FDefaultHeight: Cardinal;
    FDefaultWidth: Cardinal;
    FExpandButton: TdxLayoutGroupButton;
    FGroup: TdxLayoutGroup;
    FInternalButtons: TdxLayoutGroupButtons;
    FVisible: Boolean;
    procedure ChangeCollectionHandler(Sender: TObject);
    procedure ExpandButtonClickHandler(Sender: TObject);
    function GetShowExpandButton: Boolean;
    function GetVisibleCount: Integer;
    procedure SetAlignment(AValue: TdxLayoutGroupButtonsAlignment);
    procedure SetButtons(AValue: TdxLayoutGroupButtons);
    procedure SetDefaultHeight(AValue: Cardinal);
    procedure SetDefaultWidth(AValue: Cardinal);
    procedure SetShowExpandButton(AValue: Boolean);
    procedure SetVisible(AValue: Boolean);
  protected
    function GetOwner: TPersistent; override;
    procedure Changed;
    function IsAnyButtonVisible: Boolean;
  public
    constructor Create(AGroup: TdxLayoutGroup);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property ExpandButton: TdxLayoutGroupButton read FExpandButton;
    property Group: TdxLayoutGroup read FGroup;
    property VisibleCount: Integer read GetVisibleCount;
  published
    property Alignment: TdxLayoutGroupButtonsAlignment read FAlignment write SetAlignment default gbaRight;
    property Buttons: TdxLayoutGroupButtons read FButtons write SetButtons;
    property DefaultHeight: Cardinal read FDefaultHeight write SetDefaultHeight default 16;
    property DefaultWidth: Cardinal read FDefaultWidth write SetDefaultWidth default 16;
    property ShowExpandButton: Boolean read GetShowExpandButton write SetShowExpandButton default False;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TdxLayoutGroupCaptionOptions = class(TdxCustomLayoutItemCaptionOptions)
  public
    constructor Create(AItem: TdxCustomLayoutItem); override;
  published
    property AlignVert default tavTop;
    property Glyph;
    property ImageIndex;
    property Layout default clTop;
    property VisibleElements;
  end;

  TdxLayoutItemControlAreaAlignment = (catDefault, catNone, catAuto, catOwn);

  TdxLayoutGroup = class(TdxCustomLayoutItem, IcxControlComponentState)
  private
    FButtonOptions: TdxLayoutGroupButtonOptions;
    FExpanded: Boolean;
    FHidden: Boolean;
    FItems: TcxComponentList;
    FItemIndex: Integer;
    FVisibleItems: TcxComponentList;
    FLayoutDirection: TdxLayoutDirection;
    FItemControlAreaAlignment: TdxLayoutItemControlAreaAlignment;
    FLocked: Boolean;
    FLayoutLookAndFeelException: Boolean;
    FShowBorder: Boolean;
    FTabbedChangesCount: Integer;
    FTabbedOptions: TdxLayoutTabbedOptions;
    FUseIndent: Boolean;

    FOnCollapsed: TNotifyEvent;
    FOnExpanded: TNotifyEvent;
    FOnTabChanged: TNotifyEvent;

    procedure TabbedOptionsChangedHandler(Sender: TObject; AType: TcxCustomTabControlPropertiesChangedType);
    procedure TabbedOptionsChangeHandler(Sender: TObject);
    procedure TabCanCloseHandler(Sender: TObject; ATabIndex: Integer; var ACanClose: Boolean);
    procedure TabCloseHandler(Sender: TObject; ATabIndex: Integer);

    function GetCaptionOptions: TdxLayoutGroupCaptionOptions;
    function GetCount: Integer;
    function GetItem(Index: Integer): TdxCustomLayoutItem;
    function GetShowBorder: Boolean;
    function GetViewInfo: TdxLayoutGroupViewInfo;
    function GetVisibleCount: Integer;
    function GetVisibleItem(Index: Integer): TdxCustomLayoutItem;
    procedure SetButtonOptions(Value: TdxLayoutGroupButtonOptions);
    procedure SetCaptionOptions(Value: TdxLayoutGroupCaptionOptions);
    procedure SetExpanded(Value: Boolean);
    procedure SetHidden(Value: Boolean);
    procedure SetItemIndex(Value: Integer);
    procedure SetItemControlAreaAlignment(Value: TdxLayoutItemControlAreaAlignment);
    procedure SetLayoutDirection(Value: TdxLayoutDirection);
    procedure SetLocked(Value: Boolean);
    procedure SetLayoutLookAndFeelException(Value: Boolean);
    procedure SetShowBorder(Value: Boolean);
    procedure SetTabbedOptions(Value: TdxLayoutTabbedOptions);
    procedure SetUseIndent(Value: Boolean);

    procedure AddItem(AItem: TdxCustomLayoutItem);
    procedure ExtractItem(AItem: TdxCustomLayoutItem);
    procedure ItemListChanged(Sender: TObject; AComponent: TComponent; AAction: TcxComponentCollectionNotification);

    procedure ReadSpecial(Reader: TReader);
    procedure WriteSpecial(Writer: TWriter);

    function IsItemIndexStored: Boolean;
    function GetChildLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    class function GetItemClassKind: Integer; override;
    procedure SetParentComponent(Value: TComponent); override;

    procedure CheckIndex; override;
    procedure PopulateItems(AList: TList); override;

    // TdxCustomLayoutItem
    function CanDelete: Boolean; override;
    function CanProcessAccel(out AItem: TdxCustomLayoutItem): Boolean; override;
    function CanRemove: Boolean; override;
    procedure ContainerChanged; override;
    procedure DoChanged(AType: TdxLayoutItemChangeType); override;
    procedure DoGetTabOrderList(List: TList); override;
    procedure DoPack; override;
    class function GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass; override;
    function GetBaseName: string; override;
    function GetShowCaption: Boolean; override;
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; override;
    procedure LoadFromIni(AIniFile: TCustomIniFile; const ASection: string; AVersion: Integer); override;
    procedure SaveToIni(AIniFile: TCustomIniFile; const ASection: string); override;
    function ProcessDialogChar(ACharCode: Word): Boolean; override;
    function ProcessDialogKey(ACharCode: Word; AKeyData: Integer; AFocusedItem: TdxLayoutItem): Boolean; override;
    procedure RestoreItemControlSize; override;

    procedure LayoutLookAndFeelChanged; override;
    procedure LayoutLookAndFeelChanging; override;
    procedure BeforeCalculateViewInfo; override;
    procedure AfterCalculateViewInfo; override;
    procedure ApplyCalculatedChanges; override;

    function GetOptions: TdxCustomLayoutLookAndFeelOptions; override;

    function IsExpanded: Boolean; override;
    function IsLocked: Boolean; override;

    procedure ClearTabbedChanges;
    function HasTabbedChanges: Boolean;

    procedure CreateOptions; override;
    procedure DestroyOptions; override;

    // Events
    procedure DoCollapsed; virtual;
    procedure DoExpanded; virtual;
    procedure DoTabChanged; virtual;

    procedure BuildVisibleItemsList;
    function GetMaxChildImageSize: TSize;
    function GetHelperClass: TdxLayoutGroupHelperClass;

    function CanFocus: Boolean; override;
    
    function AllowShowChild(AChild: TdxCustomLayoutItem): Boolean; virtual;
    function IsAnyButtonVisible: Boolean;

    procedure ChangeItemIndex(AItem: TdxCustomLayoutItem; Value: Integer);
    procedure ChangeItemVisibleIndex(AItem: TdxCustomLayoutItem; Value: Integer);
    function GetItemIndex(AItemVisibleIndex: Integer): Integer;
    function IndexOf(AItem: TdxCustomLayoutItem): Integer;
    function IsSuperfluous: Boolean;
    function VisibleIndexOf(AItem: TdxCustomLayoutItem): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function CreateGroup(AGroupClass: TdxLayoutGroupClass = nil): TdxLayoutGroup;
    function CreateItem(AItemClass: TdxCustomLayoutItemClass = nil): TdxCustomLayoutItem;
    function CreateItemForControl(AControl: TControl): TdxLayoutItem;

    function CanMoveTo(AParent: TdxCustomLayoutItem): Boolean; override;
    procedure MoveChildrenToParent;
    function PutChildrenIntoHiddenGroup: TdxLayoutGroup;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TdxCustomLayoutItem read GetItem; default;
    property IsUserDefined;
    property ViewInfo: TdxLayoutGroupViewInfo read GetViewInfo;
    property VisibleCount: Integer read GetVisibleCount;
    property VisibleItems[Index: Integer]: TdxCustomLayoutItem read GetVisibleItem;
  published
    property ButtonOptions: TdxLayoutGroupButtonOptions read FButtonOptions write SetButtonOptions;
    property CaptionOptions: TdxLayoutGroupCaptionOptions read GetCaptionOptions write SetCaptionOptions;
    property Expanded: Boolean read FExpanded write SetExpanded default True;
    property Hidden: Boolean read FHidden write SetHidden default False;
    property ItemControlAreaAlignment: TdxLayoutItemControlAreaAlignment read FItemControlAreaAlignment write SetItemControlAreaAlignment default catDefault;
    property ItemIndex: Integer read FItemIndex write SetItemIndex stored IsItemIndexStored;
    property LayoutDirection: TdxLayoutDirection read FLayoutDirection write SetLayoutDirection default ldVertical;
    property Locked: Boolean read FLocked write SetLocked default False;
    property LookAndFeelException: Boolean read FLayoutLookAndFeelException write SetLayoutLookAndFeelException stored False; // obsolete
    property LayoutLookAndFeelException: Boolean read FLayoutLookAndFeelException write SetLayoutLookAndFeelException default False;
    property Padding;
    property ShowBorder: Boolean read GetShowBorder write SetShowBorder default True;
    property TabbedOptions: TdxLayoutTabbedOptions read FTabbedOptions write SetTabbedOptions;
    property UseIndent: Boolean read FUseIndent write SetUseIndent default True;
    property OnCaptionClick;
    property OnCollapsed: TNotifyEvent read FOnCollapsed write FOnCollapsed;
    property OnExpanded: TNotifyEvent read FOnExpanded write FOnExpanded;
    property OnTabChanged: TNotifyEvent read FOnTabChanged write FOnTabChanged;
  end;

  // alignment constraint

  TdxLayoutAlignmentConstraintKind = (ackLeft, ackTop, ackRight, ackBottom);

  TdxLayoutAlignmentConstraint = class(TComponent)
  private
    FContainer: TdxLayoutContainer;
    FItems: TList;
    FKind: TdxLayoutAlignmentConstraintKind;
    function GetCount: Integer;
    function GetItem(Index: Integer): TdxCustomLayoutItem;
    procedure SetKind(Value: TdxLayoutAlignmentConstraintKind);
    procedure CreateItems;
    procedure DestroyItems;

    procedure InternalAddItem(AItem: TdxCustomLayoutItem);
    procedure InternalRemoveItem(AItem: TdxCustomLayoutItem);
  protected
    procedure SetParentComponent(Value: TComponent); override;

    procedure BeginUpdate;
    function CanAddItem(AItem: TdxCustomLayoutItem): Boolean; virtual;
    procedure Changed; virtual;
    procedure EndUpdate;

    property Container: TdxLayoutContainer read FContainer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    procedure AddItem(AItem: TdxCustomLayoutItem);
    procedure RemoveItem(AItem: TdxCustomLayoutItem);

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TdxCustomLayoutItem read GetItem;
  published
    property Kind: TdxLayoutAlignmentConstraintKind read FKind write SetKind default ackLeft;
  end;
  TdxLayoutAlignmentConstraintClass = class of TdxLayoutAlignmentConstraint;

  { TdxLayoutContainerFocusedController }

  TdxLayoutContainerFocusedController = class(TPersistent)
  private
    FContainer: TdxLayoutContainer;
    FCurrentTabOrderIndex: Integer;
    procedure SetCurrentTabOrderIndex(Value: Integer);
  protected
    function GetFocusedItem: TdxCustomLayoutItem;
    function GetMaxTabOrderIndex: Integer;
    function FindNextFocusControl(ACurControl: TWinControl; AGoForward: Boolean; out AIndex: Integer): TWinControl;
    function IsFocused(AItem: TdxCustomLayoutItem): Boolean; virtual;

    function LayoutIndexOf(AList: TList; ACurrentIndex: Integer): Integer;

    procedure SetFocus;
    procedure KillFocus;

    procedure SetItemFocus(AItem: TdxCustomLayoutItem);

    property CurrentTabOrderIndex: Integer read FCurrentTabOrderIndex write SetCurrentTabOrderIndex;
  public
    constructor Create(AContainer: TdxLayoutContainer); virtual;

    function SetNextFocusControl(AFocusedControl: TWinControl): Boolean;

    property Container: TdxLayoutContainer read FContainer;
  end;
  TdxLayoutContainerFocusedControllerClass = class of TdxLayoutContainerFocusedController;

  { TdxLayoutContainer }

  TdxLayoutContainerAssignLayoutMode = (almNone, almToParent, almFromParent);

  TdxLayoutContainer = class(TComponent,
    IdxLayoutItemsHelper,
    IdxLayoutDesignerHelper,
    IdxSelectionChanged
  )
  private
    FAlignmentConstraints: TComponentList;
    FAssignLayoutMode: TdxLayoutContainerAssignLayoutMode;
    FFocusedController: TdxLayoutContainerFocusedController;
    FIsPlaceControlsNeeded: Boolean;
    FIsPlacingControls: Boolean;
    FLoadingCount: Integer;
    FMenuItems: TdxLayoutCustomizeFormMenuItems;
    FPainter: TdxLayoutContainerPainter;
    FPattern: TdxLayoutContainer;
    FPlaceControlsLockCount: Integer;
    FSelectionHelper: IdxLayoutDesignerHelper;
    FUpdateLockCount: Integer;
    FViewInfo: TdxLayoutContainerViewInfo;
    // Items
    FAbsoluteItems: TcxComponentList;
    FAvailableItems: TcxComponentList;
    FRoot: TdxLayoutGroup;
    FSpecialItems: TcxComponentList;

    // UndoRedo
    FUndoRedoManager: TdxUndoRedoManager;

    // Customize
    FCustomization: Boolean;
    FCustomizeAvailableItemsViewKind: TdxLayoutAvailableItemsViewKind;
    FCustomizeForm: TdxLayoutControlCustomCustomizeForm;
    FCustomizeFormBounds: TRect;
    FCustomizeFormClass: TdxLayoutControlCustomCustomizeFormClass;
    FCustomizeFormTabbedView: Boolean;
    FCustomizeFormUpdateTypes: TdxLayoutCustomizeFormUpdateTypes;
    FRenamingItem: TdxCustomLayoutItem;

    FHighlightRoot: Boolean;
    FShowDesignSelectors: Boolean;

    FOnChanged: TNotifyEvent;
    FOnItemChanged: TdxLayoutItemChangedEvent;
    FOnSelectionChanged: TNotifyEvent;

    procedure AvailableItemListChanged(Sender: TObject; AComponent: TComponent; AAction: TcxComponentCollectionNotification);
    function GetAlignmentConstraint(Index: Integer): TdxLayoutAlignmentConstraint;
    function GetAlignmentConstraintCount: Integer;
    function GetClientRect: TRect;
    function GetILayout: IdxLayoutControl;
    function GetILayoutFontHelper: IdxLayoutFontHelper;
    function GetIsDesignSelectorsVisible: Boolean;
    //Items
    function GetAbsoluteItem(Index: Integer): TdxCustomLayoutItem;
    function GetAbsoluteItemCount: Integer;
    function GetAvailableItem(Index: Integer): TdxCustomLayoutItem;
    function GetAvailableItemCount: Integer;

    procedure SetCustomization(AValue: Boolean);
    procedure SetCustomizeAvailableItemsViewKind(Value: TdxLayoutAvailableItemsViewKind);
    procedure SetCustomizeFormTabbedView(AValue: Boolean);
    procedure SetHighlightRoot(AValue: Boolean);
    procedure SetRenamingItem(AValue: TdxCustomLayoutItem);
    procedure SetShowDesignSelectors(Value: Boolean);
  protected
    //IdxLayoutItemsHelper
    procedure AddAvailableItem(AItem: TdxCustomLayoutItem);
    procedure AddSpecialGroup(AGroup: TdxLayoutGroup);
    function GetNewHiddenGroup: TdxLayoutGroup;
    procedure CheckDestroySuperfluousGroup(AGroup: TdxLayoutGroup);
    procedure CreateRootGroup;
    procedure DestroyRootGroup;
    procedure ExtractAvailableItem(AItem: TdxCustomLayoutItem);
    function GetRoot: TdxLayoutGroup;
    procedure SetRootGroup(Value: TdxLayoutGroup);
    //IdxSelectionChanged
    procedure SelectionChanged(ASelection: TList; AAction: TdxSelectionAction);
    //IdxLayoutDesignerHelper
    procedure AddSelectionChangedListener(AListener: TPersistent);
    function IsActive: Boolean;
    function CanDeleteComponent(AComponent: TComponent): Boolean;
    function CanModify: Boolean;
    function CanProcessKeyboard: Boolean;
    procedure ClearSelection;
    procedure DeleteSelection;
    procedure GetSelection(AList: TList);
    function IsComponentSelected(AComponent: TPersistent): Boolean;
    procedure RemoveSelectionChangedListener(AListener: TPersistent);
    procedure SelectComponent(AComponent: TPersistent; AShift: TShiftState = []);
    procedure SetSelection(AList: TList);
    function UniqueName(const BaseName: string): string;

  {$IFNDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ToggleHotTrackState(AItem: TdxCustomLayoutItem);

    function ShowHint(var AHintInfo: THintInfo; X, Y: Integer): Boolean;

    // Mouse
    function CanFocusOnClick(X, Y: Integer): Boolean; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseLeave(AControl: TControl); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    function IsChildKey(ACharCode: Word): Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;

    function CalculateCustomizeFormBounds(const AFormBounds: TRect): TRect; virtual;
    procedure CreateCustomizeForm; virtual;
    function GetCustomizeForm: TdxLayoutControlCustomCustomizeForm; virtual;
    procedure DestroyCustomizeForm; virtual;
    procedure ShowCustomizeForm; virtual;

    function GetAlignmentConstraintClass: TdxLayoutAlignmentConstraintClass; virtual;
    function GetDefaultGroupClass: TdxLayoutGroupClass; virtual;
    function GetDefaultItemClass: TdxLayoutItemClass; virtual;
    function GetDefaultRootGroupClass: TdxLayoutGroupClass; virtual;
    function GetFocusedControllerClass: TdxLayoutContainerFocusedControllerClass; virtual;
    function GetLookAndFeel: TdxCustomLayoutLookAndFeel; virtual;
    function GetPainterClass: TdxLayoutContainerPainterClass; virtual;
    function GetSelectionHelperClass: TdxLayoutRunTimeSelectionHelperClass; virtual;
    function GetViewInfoClass: TdxLayoutContainerViewInfoClass; virtual;

    procedure CreateHandlers; virtual;
    procedure DestroyHandlers; virtual;

    procedure CreateItems;
    procedure DestroyItems;

    procedure DoCalculateRoot(ANeedPack: Boolean); virtual;
    procedure DoChanged; virtual;
    procedure DoSelectionChanged; virtual;
    procedure InvalidateWithChildren;
    procedure LayoutChanged(ANeedPack: Boolean = True); virtual;

    // Customize
    procedure BuildSelectionLayer;
    procedure CustomizeFormPostUpdate(AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes);
    procedure CustomizeFormUpdateList(AItem: TdxCustomLayoutItem);
    function GetItemsParent: TcxControl; virtual;
    procedure InvalidateSelectionLayer(const R: TRect);
    function IsCustomization: Boolean; virtual;
    procedure PostBuildSelectionLayer; virtual;
    procedure PostInvalidateSelectionLayer(const R: TRect);
    procedure SelectItemParent;

    procedure BeginRename(AItem: TdxCustomLayoutItem; const ABounds: TRect; const AFont: TFont); virtual;
    procedure CancelRename; virtual;
    procedure EndRename(const AText: string); virtual;

    procedure UpdateItemsCustomization;

    // PlaceControls
    procedure BeginPlaceControls;
    procedure CancelPlaceControls;
    procedure EndPlaceControls;
    function IsPlacingControls: Boolean;
    procedure PlaceControls(AItemViewInfo: TdxCustomLayoutItemViewInfo = nil);
    procedure PostPlaceControls;
    procedure PrepareControl(AControl: TControl);
    procedure UnprepareControl(AControl: TControl);
    procedure StartPlacingControls;
    procedure StopPlacingControls;

    // Load & Save
    procedure CheckIndexes;
    function GetRootSectionName(AIniFile: TCustomIniFile): string;
    procedure InternalLoadFromCustomIniFile(AIniFile: TCustomIniFile; ADestroyNonLoadedItems: Boolean); virtual;
    procedure InternalSaveToCustomIniFile(AIniFile: TCustomIniFile); virtual;
    procedure StoreChildren(Proc: TGetChildProc);

    // Constraints
    procedure AddAlignmentConstraint(AConstraint: TdxLayoutAlignmentConstraint);
    procedure CreateConstraints;
    procedure DestroyConstraints;
    procedure RemoveAlignmentConstraint(AConstraint: TdxLayoutAlignmentConstraint);

    procedure AddAbsoluteItem(AItem: TdxCustomLayoutItem);
    procedure DoItemChanged(AItem: TdxCustomLayoutItem); virtual;
    procedure ExtractAbsoluteItem(AItem: TdxCustomLayoutItem);
    function IsRoot(AItem: TdxCustomLayoutItem): Boolean;
    function IsSizableHorz: Boolean;
    function IsSizableVert: Boolean;

    function GetAutoControlAlignment: Boolean;
    function GetAutoControlTabOrders: Boolean;
    function GetIsFocusControlOnItemCaptionClick: Boolean;

    procedure SetFocus;
    function GetMaxTabOrderIndex: Integer;
    procedure KillFocus;

    procedure DoEnter; virtual;
    procedure DoExit; virtual;

    function IsEditorMode: Boolean;
    procedure MakeVisible(AItem: TdxCustomLayoutItem);

    procedure AssignStructureFromPattern; virtual;
    procedure AssignStructureToPattern; virtual;
    procedure CopyStructure(ASource: TdxLayoutContainer);

    property FocusedController: TdxLayoutContainerFocusedController read FFocusedController;
    property IsDesignSelectorsVisible: Boolean read GetIsDesignSelectorsVisible;
    property MenuItems: TdxLayoutCustomizeFormMenuItems read FMenuItems write FMenuItems;
    property Painter: TdxLayoutContainerPainter read FPainter;
    property Pattern: TdxLayoutContainer read FPattern;
    property RenamingItem: TdxCustomLayoutItem read FRenamingItem write SetRenamingItem;
    property SelectionHelper: IdxLayoutDesignerHelper read FSelectionHelper;
    property OnItemChanged: TdxLayoutItemChangedEvent read FOnItemChanged write FOnItemChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate(ANeedPack: Boolean = True);

    function GetHitTest: TdxCustomLayoutHitTest; overload;
    function GetHitTest(const P: TPoint): TdxCustomLayoutHitTest; overload;
    function GetHitTest(X, Y: Integer): TdxCustomLayoutHitTest; overload;

    procedure BeginDragAndDrop;
    function CanDragAndDrop: Boolean;
    procedure FinishDragAndDrop(Accepted: Boolean);

    function FindItem(AControl: TControl): TdxLayoutItem; overload;
    function FindItem(AControlHandle: THandle): TdxLayoutItem; overload;
    function FindItem(const AName: string): TdxCustomLayoutItem; overload;

    function ClientToScreen(const Point: TPoint): TPoint;
    function ScreenToClient(const Point: TPoint): TPoint;

    procedure GetTabOrderList(List: TList);

    procedure CancelLastUndo;
    procedure SaveToUndo;

    procedure InvalidateRect(const R: TRect; EraseBackground: Boolean);
    function IsDesigning: Boolean;
    function IsDestroying: Boolean;
    function IsLayoutLoading: Boolean;
    function IsLoading: Boolean;
    function IsUpdateLocked: Boolean;
    procedure Modified;
    procedure Update;

    procedure Clear;
    function CloneItem(AItem: TdxCustomLayoutItem; AParent: TdxLayoutGroup = nil): TdxCustomLayoutItem;
    function CreateAlignmentConstraint: TdxLayoutAlignmentConstraint;
    function CreateGroup(AGroupClass: TdxLayoutGroupClass = nil; AParent: TdxLayoutGroup = nil): TdxLayoutGroup;
    function CreateItem(AItemClass: TdxCustomLayoutItemClass = nil; AParent: TdxLayoutGroup = nil): TdxCustomLayoutItem;
    function CreateItemForControl(AControl: TControl; AParent: TdxLayoutGroup = nil): TdxLayoutItem;

    procedure CustomizeFormUpdate(AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes);

    procedure CheckItemNames(const AOldName, ANewName: string); virtual;

    property Customization: Boolean read FCustomization write SetCustomization;
    property CustomizeAvailableItemsViewKind: TdxLayoutAvailableItemsViewKind read FCustomizeAvailableItemsViewKind write SetCustomizeAvailableItemsViewKind;
    property CustomizeForm: TdxLayoutControlCustomCustomizeForm read GetCustomizeForm;
    property CustomizeFormBounds: TRect read FCustomizeFormBounds write FCustomizeFormBounds;
    property CustomizeFormClass: TdxLayoutControlCustomCustomizeFormClass read FCustomizeFormClass write FCustomizeFormClass;
    property CustomizeFormTabbedView: Boolean read FCustomizeFormTabbedView write SetCustomizeFormTabbedView;
    property HighlightRoot: Boolean read FHighlightRoot write SetHighlightRoot;
    property ShowDesignSelectors: Boolean read FShowDesignSelectors write SetShowDesignSelectors;

    property ClientRect: TRect read GetClientRect;
    property ILayout: IdxLayoutControl read GetILayout;
    property ILayoutFontHelper: IdxLayoutFontHelper read GetILayoutFontHelper;
    property ItemsParent: TcxControl read GetItemsParent;
    property UndoRedoManager: TdxUndoRedoManager read FUndoRedoManager;
    property ViewInfo: TdxLayoutContainerViewInfo read FViewInfo;

    // Constraint
    property AlignmentConstraintCount: Integer read GetAlignmentConstraintCount;
    property AlignmentConstraints[Index: Integer]: TdxLayoutAlignmentConstraint read GetAlignmentConstraint;
    // Items
    property AbsoluteItemCount: Integer read GetAbsoluteItemCount;
    property AbsoluteItems[Index: Integer]: TdxCustomLayoutItem read GetAbsoluteItem;
    property AssignLayoutMode: TdxLayoutContainerAssignLayoutMode read FAssignLayoutMode;
    property AvailableItemCount: Integer read GetAvailableItemCount;
    property AvailableItems[Index: Integer]: TdxCustomLayoutItem read GetAvailableItem;
    property Root: TdxLayoutGroup read FRoot;

    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
  end;
  TdxLayoutContainerClass = class of TdxLayoutContainer;

  { hit tests }

  TdxCustomLayoutHitTestClass = class of TdxCustomLayoutHitTest;

  TdxCustomLayoutHitTest = class
  private
    FItem: TdxCustomLayoutItem;
    FPos: TPoint;
  public
    function CanDragAndDrop: Boolean; virtual;
    function GetCursor: TCursor; dynamic;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; virtual;
    class function HitTestCode: Integer; virtual;
    class function Instance: TdxCustomLayoutHitTest;
    function IsDeterminedAreaPart: Boolean; virtual;
    function GetAreaPart: TdxLayoutAreaPart; virtual;
    function GetGroupForInsert: TdxLayoutGroup; virtual;

    function GetDestinationItem: TdxCustomLayoutItem; virtual;
    function GetSourceItem: TdxCustomLayoutItem; virtual;

    property Item: TdxCustomLayoutItem read FItem write FItem;
    property Pos: TPoint read FPos write FPos;
  end;

  TdxCustomLayoutItemHitTest = class(TdxCustomLayoutHitTest);

  TdxLayoutNoneHitTest = class(TdxCustomLayoutHitTest)
  public
    class function HitTestCode: Integer; override;
  end;

  TdxCustomLayoutItemHitTestClass = class of TdxCustomLayoutItemHitTest;

  TdxLayoutItemHitTest = class(TdxCustomLayoutItemHitTest)
  private
    function GetItem: TdxLayoutItem;
  public
    class function HitTestCode: Integer; override;
    function GetGroupForInsert: TdxLayoutGroup; override;

    property Item: TdxLayoutItem read GetItem;
  end;

  TdxLayoutGroupHitTest = class(TdxCustomLayoutItemHitTest)
  private
    function GetItem: TdxLayoutGroup;
  public
    class function HitTestCode: Integer; override;
    function GetGroupForInsert: TdxLayoutGroup; override;

    property Item: TdxLayoutGroup read GetItem;
  end;

  TdxLayoutTabbedGroupHitTest = class(TdxLayoutGroupHitTest)
  private
    function GetSpecific: TdxLayoutGroupViewInfoTabbedSpecific;
  protected
    property Specific: TdxLayoutGroupViewInfoTabbedSpecific read GetSpecific;
  public
    function GetDestinationItem: TdxCustomLayoutItem; override;
    function GetSourceItem: TdxCustomLayoutItem; override;
  end;

  TdxLayoutClientAreaHitTest = class(TdxCustomLayoutHitTest)
  private
    FContainer: TdxLayoutContainer;
  public
    class function HitTestCode: Integer; override;
    function GetGroupForInsert: TdxLayoutGroup; override;
    function GetDestinationItem: TdxCustomLayoutItem; override;

    property Container: TdxLayoutContainer read FContainer write FContainer;
  end;

  TdxLayoutSizeHitTest = class(TdxCustomLayoutItemHitTest)
  private
    FCursor: TCursor;
  protected
    property Cursor: TCursor read FCursor write FCursor;
  public
    function GetCursor: TCursor; override;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; override;
  end;

  TdxLayoutSplitterHitTest = class(TdxCustomLayoutItemHitTest)
  public
    function CanDragAndDrop: Boolean; override;
    function GetCursor: TCursor; override;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; override;
  end;

  TdxLayoutCustomizeFormHitTest = class(TdxCustomLayoutHitTest)
  private
    FAreaPart: TdxLayoutAreaPart;
    FContainer: TdxLayoutContainer;
  public
    class function HitTestCode: Integer; override;
    function IsDeterminedAreaPart: Boolean; override;
    function GetAreaPart: TdxLayoutAreaPart; override;
    function GetDestinationItem: TdxCustomLayoutItem; override;

    property AreaPart: TdxLayoutAreaPart read FAreaPart write FAreaPart;
    property Container: TdxLayoutContainer read FContainer write FContainer;
  end;

  { Painters }

  { TdxCustomLayoutElementPainter }

  TdxCustomLayoutElementPainter = class
  private
    FCanvas: TcxCanvas;
    FViewInfo: TdxCustomLayoutElementViewInfo;
  protected
    property Canvas: TcxCanvas read FCanvas;
    property ViewInfo: TdxCustomLayoutElementViewInfo read FViewInfo;
  public
    constructor Create(ACanvas: TcxCanvas; AViewInfo: TdxCustomLayoutElementViewInfo); virtual;
    procedure Paint; virtual;
  end;

  { TdxCustomLayoutItemElementPainter }

  TdxCustomLayoutItemElementPainter = class(TdxCustomLayoutElementPainter)
  private
    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
    function GetViewInfo: TdxCustomLayoutItemElementViewInfo;
  protected
    property LayoutLookAndFeel: TdxCustomLayoutLookAndFeel read GetLayoutLookAndFeel;
    property ViewInfo: TdxCustomLayoutItemElementViewInfo read GetViewInfo;
  end;

  TdxCustomLayoutItemCaptionPainter = class(TdxCustomLayoutItemElementPainter)
  private
    function GetViewInfo: TdxCustomLayoutItemCaptionViewInfo;
  protected
    procedure DoDrawText; virtual;
    procedure DoDrawGlyph; virtual;

    procedure DoPaint; virtual;

    procedure DrawBackground; virtual;
    procedure DrawGlyph;
    procedure DrawText;
    property ViewInfo: TdxCustomLayoutItemCaptionViewInfo read GetViewInfo;
  public
    procedure Paint; override;
  end;

  TdxLayoutGroupCaptionPainter = class(TdxCustomLayoutItemCaptionPainter);
  TdxLayoutControlItemCaptionPainter = class(TdxCustomLayoutItemCaptionPainter);
  TdxLayoutItemCaptionPainter = class(TdxLayoutControlItemCaptionPainter);

  TdxCustomLayoutItemPainter = class(TdxCustomLayoutElementPainter)
  private
    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
    function GetViewInfo: TdxCustomLayoutItemViewInfo;
  protected
    function GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass; virtual; abstract;

    procedure DoDrawBackground; virtual;
    procedure DoDrawCaption; virtual;
    procedure DoDrawSpecificPart; virtual;
    procedure DoDrawSelectionFrame; virtual;

    procedure DrawBackground; virtual;
    procedure DrawCaption; virtual;
    procedure DrawContent; virtual;
    procedure DrawItem;

    procedure DrawSpecificPart; virtual;
    procedure DrawDesignFeatures; virtual;

    function CanDrawBackground: Boolean; virtual;
    function CanDrawCaption: Boolean; virtual;
    function CanDrawSpecificPart: Boolean; virtual;

    function CanPaint: Boolean; virtual;

    property LayoutLookAndFeel: TdxCustomLayoutLookAndFeel read GetLayoutLookAndFeel;
    property ViewInfo: TdxCustomLayoutItemViewInfo read GetViewInfo;
  public
    procedure Paint; override;
    procedure PaintDragImage;
  end;

  { TdxLayoutControlItemControlPainter }

  TdxLayoutControlItemControlPainter = class(TdxCustomLayoutItemElementPainter)
  private
    function GetViewInfo: TdxLayoutControlItemControlViewInfo;
  protected
    procedure DrawBorders; virtual;
    property ViewInfo: TdxLayoutControlItemControlViewInfo read GetViewInfo;
  public
    procedure Paint; override;
  end;

  TdxLayoutItemControlPainter = class(TdxLayoutControlItemControlPainter);

  TdxLayoutBasicItemPainter = class(TdxCustomLayoutItemPainter);

  TdxLayoutEmptySpaceItemPainter = class(TdxLayoutBasicItemPainter)
  protected
    procedure DrawContent; override;
  end;

  TdxLayoutDirectionalItemPainter = class(TdxLayoutBasicItemPainter)
  protected
    procedure DrawContent; override;
    procedure DoDrawContent; virtual;
  end;

  TdxLayoutSeparatorItemPainter = class(TdxLayoutDirectionalItemPainter)
  private
    function GetViewInfo: TdxLayoutSeparatorItemViewInfo;
  protected
    procedure DoDrawContent; override;
    property ViewInfo: TdxLayoutSeparatorItemViewInfo read GetViewInfo;
  end;

  TdxLayoutSplitterItemPainter = class(TdxLayoutDirectionalItemPainter)
  private
    function GetViewInfo: TdxLayoutSplitterItemViewInfo;
  protected
    procedure DoDrawContent; override;
    property ViewInfo: TdxLayoutSplitterItemViewInfo read GetViewInfo;
  end;

  TdxLayoutLabeledItemPainter = class(TdxLayoutBasicItemPainter)
  protected
    function CanDrawCaption: Boolean; override;

    function GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass; override;
  end;

  TdxLayoutControlItemPainter = class(TdxLayoutLabeledItemPainter)
  private
    function GetViewInfo: TdxLayoutControlItemViewInfo;
  protected
    function CanDrawSpecificPart: Boolean; override;

    function GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass; override;
    function GetControlPainterClass: TdxLayoutControlItemControlPainterClass; virtual;

    procedure DoDrawControlBorder; virtual;

    procedure DrawContent; override;
    procedure DrawControlBorder; virtual;

    property ViewInfo: TdxLayoutControlItemViewInfo read GetViewInfo;
  end;

  TdxLayoutItemPainter = class(TdxLayoutControlItemPainter)
  private
    function GetViewInfo: TdxLayoutItemViewInfo;
  protected
    function GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass; override;
    function GetControlPainterClass: TdxLayoutControlItemControlPainterClass; override;

    procedure DoDrawSpecificPart; override;

    property ViewInfo: TdxLayoutItemViewInfo read GetViewInfo;
  end;

  { TdxLayoutGroupButtonPainter }

  TdxLayoutGroupButtonPainter = class(TdxCustomLayoutItemElementPainter)
  private
    function GetViewInfo: TdxLayoutGroupButtonViewInfo;
  protected
    property ViewInfo: TdxLayoutGroupButtonViewInfo read GetViewInfo;
  public
    procedure Paint; override;
  end;

  { TdxLayoutGroupPainter }

  TdxLayoutGroupPainter = class(TdxCustomLayoutItemPainter)
  private
    function GetViewInfo: TdxLayoutGroupViewInfo;
  protected
    function GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass; override;

    procedure DrawContent; override;

    function CanDrawSpecificControls: Boolean; virtual;
    function HasCaptionBackground: Boolean; virtual;

    procedure DoDrawBorders; virtual;
    procedure DoDrawButtons; virtual;
    procedure DoDrawSpecificControls; virtual;

    procedure DrawBorders; virtual;
    procedure DrawButtons; virtual;
    procedure DrawItems; virtual;
    procedure DrawItemsArea; virtual;
    procedure DrawSpecificControls;
    procedure DrawSpecificPart; override;
    procedure DrawDesignFeatures; override;

    property ViewInfo: TdxLayoutGroupViewInfo read GetViewInfo;
  end;

  { TdxLayoutContainerPainter }

  TdxLayoutContainerPainter = class
  private
    FViewInfo: TdxLayoutContainerViewInfo;
    function GetContainer: TdxLayoutContainer;
  protected
    procedure DrawDesignFeatures(ACanvas: TcxCanvas); virtual;
    procedure PlaceControls(AItemViewInfo: TdxCustomLayoutItemViewInfo);

    property Container: TdxLayoutContainer read GetContainer;
  public
    constructor Create(AViewInfo: TdxLayoutContainerViewInfo); virtual;
    procedure DrawItems(ACanvas: TcxCanvas); virtual;

    property ViewInfo: TdxLayoutContainerViewInfo read FViewInfo;
  end;

  { ViewInfos }

  { TdxCustomLayoutElementViewInfo }

  TdxLayoutElementViewInfoState = (levsHot, levsPressed);
  TdxLayoutElementViewInfoStates = set of TdxLayoutElementViewInfoState;

  TdxCustomLayoutElementViewInfo = class
  private
    FBounds: TRect;
    FOriginalBounds: TRect;
    FState: TdxLayoutElementViewInfoStates;
    procedure SetState(AValue: TdxLayoutElementViewInfoStates);
  protected
    FOffset: TPoint;
    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel; virtual; abstract;

    function GetEnabled: Boolean; virtual;
    function GetIsCustomization: Boolean; virtual;
    function GetPadding: TRect; virtual;

    // Mouse
    function CanFocusOnClick(X, Y: Integer): Boolean; virtual;
    procedure MouseEnter; virtual;
    procedure MouseLeave; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;

    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;

    procedure DoSetOffset(const Value: TPoint); virtual;
    procedure SetOffset(const Value: TPoint);
    procedure StateChanged; virtual;
    function IsHotTrackable: Boolean; virtual;

    property IsCustomization: Boolean read GetIsCustomization;
    property OriginalBounds: TRect read FOriginalBounds;
    property Offset: TPoint read FOffset write SetOffset;
    property Padding: TRect read GetPadding;
    property State: TdxLayoutElementViewInfoStates read FState write SetState;
  public
    procedure Calculate(const ABounds: TRect); virtual;

    property Bounds: TRect read FBounds;
    property Enabled: Boolean read GetEnabled;
    property LayoutLookAndFeel: TdxCustomLayoutLookAndFeel read GetLayoutLookAndFeel;
  end;

  { TdxCustomLayoutItemElementViewInfo }

  TdxCustomLayoutItemElementViewInfo = class(TdxCustomLayoutElementViewInfo)
  private
    FItemViewInfo: TdxCustomLayoutItemViewInfo;
    FHeight: Integer;
    FWidth: Integer;
    function GetItem: TdxCustomLayoutItem;
    function GetHeight: Integer;
    function GetWidth: Integer;
    procedure SetHeight(Value: Integer);
    procedure SetWidth(Value: Integer);
  protected
    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel; override;

    function GetEnabled: Boolean; override;
    function GetIsCustomization: Boolean; override;
    function GetCursor(X, Y: Integer): TCursor; virtual;
    function GetVisible: Boolean; virtual;
    procedure Invalidate(const ABounds: TRect); virtual;
    function WantsMouse(X, Y: Integer): Boolean;

    // Hint
    function ShowHint(var AHintInfo: THintInfo): Boolean; virtual;

    property Item: TdxCustomLayoutItem read GetItem;
    property ItemViewInfo: TdxCustomLayoutItemViewInfo read FItemViewInfo;
    property Visible: Boolean read GetVisible;
  public
    constructor Create(AItemViewInfo: TdxCustomLayoutItemViewInfo); virtual;
    destructor Destroy; override;

    function CalculateMinHeight: Integer; virtual;
    function CalculateMinWidth: Integer; virtual;
    function CalculateHeight: Integer; virtual;
    function CalculateWidth: Integer; virtual;

    property Height: Integer read GetHeight write SetHeight;
    property Width: Integer read GetWidth write SetWidth;
  end;

  TdxCustomLayoutItemCaptionViewInfo = class(TdxCustomLayoutItemElementViewInfo)
  private
    FHotTracked: Boolean;
    function GetCanvas: TcxCanvas;
    procedure SetHotTracked(Value: Boolean);
  protected
    function GetCursor(X, Y: Integer): TCursor; override;
    function GetVisible: Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseLeave; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure StateChanged; override;
    function IsHotTrackable: Boolean; override;

    function CalculateTextFlags: Integer; virtual;
    procedure PrepareCanvas(ACanvas: TcxCanvas); virtual;

    // Getters
    // Image
    function GetImageAreaBounds: TRect; virtual;
    function GetImageBounds: TRect; virtual;
    function GetImageHeight: Integer; virtual;
    function GetImageWidth: Integer; virtual;
    // Text
    function GetColor: TColor; virtual;
    function GetFont: TFont; virtual;
    function GetHotTrackBounds: TRect; virtual;
    function GetHotTrackStyles: TdxLayoutHotTrackStyles; virtual;
    function GetText: string; virtual;
    function GetTextAreaBounds: TRect; virtual;
    function GetTextColor: TColor; virtual;
    function GetTextDisabledColor: TColor; virtual;
    function GetTextHotColor: TColor; virtual;
    function GetTextNormalColor: TColor; virtual;
    function GetTextHeight: Integer; virtual;
    function GetTextWidth: Integer; virtual;
    function GetVisibleText: string; virtual;
    // Common
    function GetAlignHorz: TAlignment; virtual;
    function GetAlignVert: TdxAlignmentVert; virtual;
    function GetOptions: TdxLayoutLookAndFeelCaptionOptions; virtual;
    function GetRotationAngle: TcxRotationAngle; virtual;
    function GetSpaceBetweenImageText: Integer; virtual;

    function GetAvailableHeight: Integer; virtual;
    function GetAvailableWidth: Integer; virtual;
    function GetAvailableTextHeight: Integer; virtual;
    function GetAvailableTextWidth: Integer; virtual;
    function GetContentOffsets: TRect; virtual;

    // Conditions
    function CanDoCaptionClick(X, Y: Integer): Boolean; virtual;
    function IsDefaultColor: Boolean; virtual;
    function IsImageVisible: Boolean;
    function IsMultiLine: Boolean; virtual;
    function IsNeedSpaceBetweenImageText: Boolean;
    function IsPointInHotTrackBounds(const P: TPoint): Boolean; virtual;
    function IsTextUnderlined: Boolean; virtual;
    function IsTextVisible: Boolean;
    function IsTransparent: Boolean; virtual;
    function IsVerticalCaption: Boolean; virtual;

    property AlignHorz: TAlignment read GetAlignHorz;
    property AlignVert: TdxAlignmentVert read GetAlignVert;
    property Canvas: TcxCanvas read GetCanvas;
    property HotTrackBounds: TRect read GetHotTrackBounds;
    property HotTrackStyles: TdxLayoutHotTrackStyles read GetHotTrackStyles;
    property ImageBounds: TRect read GetImageBounds;
    property Options: TdxLayoutLookAndFeelCaptionOptions read GetOptions;
  public
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;

    property Color: TColor read GetColor;
    property Font: TFont read GetFont;
    property HotTracked: Boolean read FHotTracked write SetHotTracked;
    property ImageAreaBounds: TRect read GetImageAreaBounds;
    property ImageHeight: Integer read GetImageHeight;
    property ImageWidth: Integer read GetImageWidth;
    property Text: string read GetText;
    property TextAreaBounds: TRect read GetTextAreaBounds;
    property TextHeight: Integer read GetTextHeight;
    property TextWidth: Integer read GetTextWidth;
    property TextColor: TColor read GetTextColor;
    property VisibleText: string read GetVisibleText;
  end;
  TdxCustomLayoutItemCaptionViewInfoClass = class of TdxCustomLayoutItemCaptionViewInfo;

  TdxCustomLayoutItemViewInfoCloneData = class
  private
    FItem: TdxCustomLayoutItem;
    FNotifyComponent: TcxFreeNotificator;
    FOwner: TdxLayoutCloneDataList;
    procedure FreeNotification(AComponent: TComponent);
  protected
    procedure Changed;
    function ReadBoolean(AStream: TStream): Boolean;
    procedure WriteBoolean(AStream: TStream; AValue: Boolean);
  public
    constructor Create(AOwner: TdxLayoutCloneDataList; AItem: TdxCustomLayoutItem); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TdxCustomLayoutItemViewInfoCloneData); virtual;

    procedure Calculate; virtual;

    procedure Load(AStream: TStream); virtual;
    procedure Save(AStream: TStream); virtual;

    property Item: TdxCustomLayoutItem read FItem;
    property Owner: TdxLayoutCloneDataList read FOwner;
  end;
  TdxCustomLayoutItemViewInfoCloneDataClass = class of TdxCustomLayoutItemViewInfoCloneData;

  { TdxLayoutCloneDataList }

  TdxLayoutCloneDataList = class(TObjectList)
  private
    FOnChanged: TNotifyEvent;
    function GetItem(Index: Integer): TdxCustomLayoutItemViewInfoCloneData;
    procedure SetItem(Index: Integer; Value: TdxCustomLayoutItemViewInfoCloneData);
  protected
    procedure Changed;
  public
    property Items[Index: Integer]: TdxCustomLayoutItemViewInfoCloneData read GetItem write SetItem; default;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  end;

  TdxCustomLayoutItemViewInfo = class(TdxCustomLayoutElementViewInfo)
  private
    FOffsets: array[TdxLayoutSide] of Integer;
    FCaptionViewInfo: TdxCustomLayoutItemCaptionViewInfo;
    FCloneData: TdxCustomLayoutItemViewInfoCloneData;
    FContainerViewInfo: TdxLayoutContainerViewInfo;
    FParentViewInfo: TdxLayoutGroupViewInfo;
    FElements: TObjectList;
    FElementWithMouse: TdxCustomLayoutItemElementViewInfo;
    FItem: TdxCustomLayoutItem;
    FNotifyComponent: TcxFreeNotificator;
    FTabOrderIndex: Integer;

    function GetMinHeight: Integer;
    function GetMinWidth: Integer;
    function GetUsualHeight: Integer;
    function GetUsualWidth: Integer;

    function GetAlignHorz: TdxLayoutAlignHorz;
    function GetAlignVert: TdxLayoutAlignVert;
    function GetBackgroundBounds: TRect;
    function GetCanPaint: Boolean;
    function GetHasMouse: Boolean;
    function GetOffset(ASide: TdxLayoutSide): Integer;
    function GetOffsetsHeight: Integer;
    function GetOffsetsWidth: Integer;
    function GetSelected: Boolean;
    function GetSelectionArea: TRect;
    function GetSelectionBorderRect: TRect;
    function GetSelectableMarkers: TRects;
    procedure GetSelectionMarkers(out ASelectable, ANonSelectable: TRects);
    procedure SetElementWithMouse(Value: TdxCustomLayoutItemElementViewInfo);
    procedure SetHasMouse(Value: Boolean);
    procedure SetOffset(ASide: TdxLayoutSide; Value: Integer);

    function CreateHitTest(AHitTestClass: TdxCustomLayoutItemHitTestClass; const P: TPoint): TdxCustomLayoutItemHitTest;
  protected
    function GetIsCustomization: Boolean; override;

    procedure AutoAlignControls; virtual;
    procedure DoCreateViewInfos; virtual;
    procedure CreateViewInfos;
    procedure DestroyViewInfos; virtual;
    procedure FreeNotification(AComponent: TComponent); virtual;
    procedure PopulateAutoAlignControlList(AList: TList); virtual;
    procedure PopulateControlViewInfoList(AControls, AWinControls: TList); virtual;

    function CanDrawBackground: Boolean; virtual;
    function CanDrawSpecificBackground: Boolean; virtual;
    function GetBackgroundColor: TColor; virtual;

    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; virtual; abstract;
    function GetCloneDataClass: TdxCustomLayoutItemViewInfoCloneDataClass; virtual;
    function GetHitTestClass: TdxCustomLayoutItemHitTestClass; virtual; abstract;
    function GetPainterClass: TdxCustomLayoutItemPainterClass; virtual; abstract;

    function CalculateMinHeight: Integer;
    function CalculateMinWidth: Integer;
    function CalculateHeight: Integer; virtual;
    function CalculateWidth: Integer; virtual;
    function DoCalculateHeight(AIsMinHeight: Boolean): Integer; virtual;
    function DoCalculateWidth(AIsMinWidth: Boolean): Integer; virtual;

    function CalculateOffset(ASide: TdxLayoutSide): Integer; virtual;
    function GetAreaPart(const P: TPoint): TdxLayoutAreaPart; virtual;
    function GetActuallyVisible: Boolean; virtual;
    function GetColor: TColor; virtual; abstract;
    function GetCursor(X, Y: Integer): TCursor; virtual;
    function GetElement(AIndex: Integer): TdxCustomLayoutItemElementViewInfo;
    function GetElementCount: Integer;
    function GetEnabled: Boolean; override;
    function GetHitTestBounds: TRect; virtual;
    function GetOptions: TdxCustomLayoutLookAndFeelOptions;
    function GetMarkerIndex(AMarkers: TRects; const P: TPoint): Integer; overload;
    function GetMarkerIndex(const P: TPoint): Integer; overload;

    function HasBackground: Boolean;
    function HasCaption: Boolean; virtual;  // #DG !!!
    function HasBorder: Boolean; virtual;

    procedure CustomizationMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseLeave; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel; override;

    procedure DoSetOffset(const Value: TPoint); override;

    procedure Invalidate(const ABounds: TRect); virtual;

    // selections
    procedure PaintSelectionLayer(ABitmap: TcxAlphaBitmap); virtual;

    // Hint
    function ShowHint(var AHintInfo: THintInfo): Boolean;

    // TabOrders
    function GetMaxTabOrderIndex: Integer; virtual;

    // inplace rename
    function CanInplaceRename: Boolean; virtual;
    procedure DoInplaceRename; virtual;
    procedure InplaceRename;
    function GetInplaceRenameBounds: TRect; virtual;

    // conditions
    function IsAvailable: Boolean;
    function IsExpanded: Boolean; virtual;
    function IsParentExpanded: Boolean;
    function IsParentLocked: Boolean;
    function IsParentSelected: Boolean;
    function IsDefaultColor: Boolean; virtual; abstract;
    function IsTransparent: Boolean; virtual;
    function IsDragged: Boolean;
    function IsDraggedWithParent: Boolean;
    function IsDragImagePainted: Boolean;

    function IsClone: Boolean;
    procedure LoadCloneData(AStream: TStream); virtual;
    procedure SaveCloneData(AStream: TStream); virtual;
    procedure PrepareCloneData;

    property ActuallyVisible: Boolean read GetActuallyVisible;
    property BackgroundBounds: TRect read GetBackgroundBounds;
    property CanPaint: Boolean read GetCanPaint; // todo: rename
    property CloneData: TdxCustomLayoutItemViewInfoCloneData read FCloneData;
    property HasMouse: Boolean read GetHasMouse write SetHasMouse;
    property ElementCount: Integer read GetElementCount;
    property Elements[Index: Integer]: TdxCustomLayoutItemElementViewInfo read GetElement;
    property ElementWithMouse: TdxCustomLayoutItemElementViewInfo read FElementWithMouse write SetElementWithMouse;
    property Item: TdxCustomLayoutItem read FItem;
    property OffsetsHeight: Integer read GetOffsetsHeight;
    property OffsetsWidth: Integer read GetOffsetsWidth;
    property Options: TdxCustomLayoutLookAndFeelOptions read GetOptions;
    property TabOrderIndex: Integer read FTabOrderIndex write FTabOrderIndex;
  public
    constructor Create(AContainerViewInfo: TdxLayoutContainerViewInfo; AParentViewInfo: TdxLayoutGroupViewInfo;
      AItem: TdxCustomLayoutItem); virtual;
    destructor Destroy; override;
    procedure Calculate(const ABounds: TRect); override;

    procedure CalculateInternalTabOrders(var AAvailTabOrder: Integer); virtual;
    procedure CalculateTabOrders(var AAvailTabOrder: Integer); virtual;
    function GetHitTest(const P: TPoint): TdxCustomLayoutHitTest; virtual;
    function GetItemWithMouse(const P: TPoint): TdxCustomLayoutItem; virtual;
    procedure ResetOffset(ASide: TdxLayoutSide);

    property AlignHorz: TdxLayoutAlignHorz read GetAlignHorz;
    property AlignVert: TdxLayoutAlignVert read GetAlignVert;
    property CaptionViewInfo: TdxCustomLayoutItemCaptionViewInfo read FCaptionViewInfo;
    property Color: TColor read GetColor;
    property ContainerViewInfo: TdxLayoutContainerViewInfo read FContainerViewInfo;
    property ParentViewInfo: TdxLayoutGroupViewInfo read FParentViewInfo;

    property MinWidth: Integer read GetMinWidth;
    property MinHeight: Integer read GetMinHeight;
    property UsualWidth: Integer read GetUsualWidth;
    property UsualHeight: Integer read GetUsualHeight;

    property Offsets[ASide: TdxLayoutSide]: Integer read GetOffset write SetOffset;
    property Selected: Boolean read GetSelected;
    property SelectionBorderRect: TRect read GetSelectionBorderRect;
    property SelectionArea: TRect read GetSelectionArea;
  end;

  { ItemViewInfos }

  TdxLayoutBasicItemCaptionViewInfo = class(TdxCustomLayoutItemCaptionViewInfo);

  TdxLayoutEmptySpaceItemCaptionViewInfo = class(TdxLayoutBasicItemCaptionViewInfo)
  protected
    function CanDoCaptionClick(X, Y: Integer): Boolean; override;
    procedure PrepareCanvas(ACanvas: TcxCanvas); override;
    function IsHotTrackable: Boolean; override;
  end;

  { TdxLayoutLabeledItemCaptionViewInfo }

  TdxLayoutLabeledItemCaptionViewInfo = class(TdxLayoutBasicItemCaptionViewInfo)
  private
    function GetItem: TdxLayoutCustomLabeledItem;
    function GetItemViewInfo: TdxLayoutLabeledItemViewInfo;
  protected
    function GetCursor(X, Y: Integer): TCursor; override;
    function GetIsFixedWidth: Boolean; virtual;
    function GetSpaceBetweenImageText: Integer; override;
    function GetImageAreaBounds: TRect; override;
    function GetTextAreaBounds: TRect; override;
    function GetTextWidth: Integer; override;
    function IsMultiLine: Boolean; override;

    property IsFixedWidth: Boolean read GetIsFixedWidth;
    property Item: TdxLayoutCustomLabeledItem read GetItem;
    property ItemViewInfo: TdxLayoutLabeledItemViewInfo read GetItemViewInfo;
  public
    function CalculateMinWidth: Integer; override;
  end;

  { TdxLayoutControlItemCaptionViewInfo }

  TdxLayoutControlItemCaptionViewInfo = class(TdxLayoutLabeledItemCaptionViewInfo)
  private
    function GetItem: TdxLayoutControlItem;
    function GetItemViewInfo: TdxLayoutControlItemViewInfo;
  protected
    property Item: TdxLayoutControlItem read GetItem;
    property ItemViewInfo: TdxLayoutControlItemViewInfo read GetItemViewInfo;
  end;

  { TdxLayoutItemCaptionViewInfo }

  TdxLayoutItemCaptionViewInfo = class(TdxLayoutControlItemCaptionViewInfo)
  private
    function GetItem: TdxLayoutItem;
    function GetItemViewInfo: TdxLayoutItemViewInfo;
  protected
    property Item: TdxLayoutItem read GetItem;
    property ItemViewInfo: TdxLayoutItemViewInfo read GetItemViewInfo;
  end;

  TdxLayoutControlItemControlViewInfo = class(TdxCustomLayoutItemElementViewInfo)
  private
    FPrevControlSize: TSize;
    FControlBounds: TRect;
    function GetBorderColor: TColor;
    function GetBorderStyle: TdxLayoutBorderStyle;
    function GetItem: TdxLayoutControlItem;
    function GetItemViewInfo: TdxLayoutControlItemViewInfo;
    function GetOpaqueControl: Boolean;
  protected
    function GetVisible: Boolean; override;

    function CalculateControlBounds: TRect; virtual;
    function GetBorderWidth(ASide: TdxLayoutSide): Integer; virtual;
    function GetControlAreaHeight(AControlHeight: Integer): Integer; virtual;
    function GetControlAreaWidth(AControlWidth: Integer): Integer; virtual;
    function GetOriginalControlSize: TSize; virtual;

    function HasBorder: Boolean; virtual;

    property BorderWidths[ASide: TdxLayoutSide]: Integer read GetBorderWidth;
    property Item: TdxLayoutControlItem read GetItem;
    property ItemViewInfo: TdxLayoutControlItemViewInfo read GetItemViewInfo;
  public
    procedure Calculate(const ABounds: TRect); override;
    procedure CalculateInternalTabOrder(var AAvailTabOrder: Integer); virtual;
    procedure CalculateTabOrder(var AAvailTabOrder: Integer); virtual;

    function CalculateMinHeight: Integer; override;
    function CalculateMinWidth: Integer; override;
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;

    property BorderColor: TColor read GetBorderColor;
    property BorderStyle: TdxLayoutBorderStyle read GetBorderStyle;
    property ControlBounds: TRect read FControlBounds;
    property OpaqueControl: Boolean read GetOpaqueControl;
  end;
  TdxLayoutControlItemControlViewInfoClass = class of TdxLayoutControlItemControlViewInfo;

  { TdxLayoutItemControlViewInfo }

  TdxLayoutItemControlViewInfo = class(TdxLayoutControlItemControlViewInfo)
  private
    function GetControl: TControl;
    function GetItem: TdxLayoutItem;
  protected
    property Item: TdxLayoutItem read GetItem;
  public
    procedure CalculateTabOrder(var AAvailTabOrder: Integer); override;
    property Control: TControl read GetControl;
  end;

  TdxLayoutBasicItemViewInfo = class(TdxCustomLayoutItemViewInfo)
  protected
    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
    function GetHitTestClass: TdxCustomLayoutItemHitTestClass; override;
    function GetPainterClass: TdxCustomLayoutItemPainterClass; override;

    function GetColor: TColor; override;
    function IsDefaultColor: Boolean; override;
    function IsTransparent: Boolean; override;
  end;

  TdxLayoutEmptySpaceItemViewInfo = class(TdxLayoutBasicItemViewInfo)
  protected
    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
    function GetPainterClass: TdxCustomLayoutItemPainterClass; override;

    function DoCalculateHeight(AIsMinHeight: Boolean): Integer; override;
    function DoCalculateWidth(AIsMinWidth: Boolean): Integer; override;
  public
    procedure Calculate(const ABounds: TRect); override;
  end;

  TdxLayoutDirectionalItemViewInfo = class(TdxLayoutBasicItemViewInfo)
  private
    function GetItem: TdxLayoutDirectionalItem;
  protected
    function DoCalculateHeight(AIsMinHeight: Boolean): Integer; override;
    function DoCalculateWidth(AIsMinWidth: Boolean): Integer; override;

    function GetItemMinHeight: Integer; virtual;
    function GetItemMinWidth: Integer; virtual;

    function IsVertical: Boolean;
  public
    procedure Calculate(const ABounds: TRect); override;

    property Item: TdxLayoutDirectionalItem read GetItem;
  end;

  TdxLayoutSeparatorItemViewInfo = class(TdxLayoutDirectionalItemViewInfo)
  private
    function GetSeparator: TdxLayoutSeparatorItem;
  protected
    function GetItemMinHeight: Integer; override;
    function GetItemMinWidth: Integer; override;
    function GetPainterClass: TdxCustomLayoutItemPainterClass; override;
  public
    property Separator: TdxLayoutSeparatorItem read GetSeparator;
  end;

  TdxLayoutSplitterItemViewInfo = class(TdxLayoutDirectionalItemViewInfo)
  private
    function GetSplitter: TdxLayoutSplitterItem;
  protected
    function GetHitTestBounds: TRect; override;
    function GetHitTestClass: TdxCustomLayoutItemHitTestClass; override;
    function GetPainterClass: TdxCustomLayoutItemPainterClass; override;
    function GetItemMinHeight: Integer; override;
    function GetItemMinWidth: Integer; override;
    procedure StateChanged; override;
    function IsHotTrackable: Boolean; override;
  public
    property Splitter: TdxLayoutSplitterItem read GetSplitter;
  end;

  TdxLayoutLabeledItemViewInfo = class(TdxLayoutBasicItemViewInfo)
  protected
    FCaptionViewInfoBounds: TRect;

    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
    function GetPainterClass: TdxCustomLayoutItemPainterClass; override;

    procedure InitViewInfoBounds(AElementViewInfo: TdxCustomLayoutItemElementViewInfo;
      out ABounds: TRect; out ASize: TPoint; out AVisible: Boolean);
    procedure CalculateViewInfoBounds; virtual;

    function GetContentBounds: TRect; virtual;
    function GetContentHeight(AIsMinHeight: Boolean): Integer; virtual;
    function GetContentWidth(AIsMinWidth: Boolean): Integer; virtual;
    function GetPadding: TRect; override;
    function DoCalculateHeight(AIsMinHeight: Boolean): Integer; override;
    function DoCalculateWidth(AIsMinWidth: Boolean): Integer; override;

    procedure DoSetOffset(const Value: TPoint); override;

    function GetElementOffsetHorz: Integer; virtual;
    function GetElementOffsetVert: Integer; virtual;

    property ElementOffsetHorz: Integer read GetElementOffsetHorz;
    property ElementOffsetVert: Integer read GetElementOffsetVert;
  public
    procedure Calculate(const ABounds: TRect); override;

    property ContentBounds: TRect read GetContentBounds;
  end;

  { TdxLayoutControlItemViewInfo }

  TdxLayoutControlItemViewInfo = class(TdxLayoutLabeledItemViewInfo)
  private
    FControlViewInfo: TdxLayoutControlItemControlViewInfo;
    function GetCaptionViewInfo: TdxLayoutControlItemCaptionViewInfo;
    function GetItem: TdxLayoutControlItem;
    function GetOptionsEx: TdxLayoutLookAndFeelItemOptions;
  protected
    FControlViewInfoBounds: TRect;

    procedure DoCreateViewInfos; override;
    procedure PopulateAutoAlignControlList(AList: TList); override;

    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
    function GetControlViewInfoClass: TdxLayoutControlItemControlViewInfoClass; virtual;
    function GetHitTestClass: TdxCustomLayoutItemHitTestClass; override;
    function GetPainterClass: TdxCustomLayoutItemPainterClass; override;

    procedure CalculateViewInfoBounds; override;

    function GetContentHeight(AIsMinHeight: Boolean): Integer; override;
    function GetContentWidth(AIsMinWidth: Boolean): Integer; override;

    procedure DoSetOffset(const Value: TPoint); override;

    function GetAutoControlAreaAlignment: Boolean; virtual;
    function GetCaptionLayout: TdxCaptionLayout; virtual;
    function HasControl: Boolean; virtual;

    // selections
    procedure PaintSelectionLayer(ABitmap: TcxAlphaBitmap); override;

    property Item: TdxLayoutControlItem read GetItem;
    property Options: TdxLayoutLookAndFeelItemOptions read GetOptionsEx;
  public
    procedure Calculate(const ABounds: TRect); override;
    procedure CalculateInternalTabOrders(var AAvailTabOrder: Integer); override;
    procedure CalculateTabOrders(var AAvailTabOrder: Integer); override;

    property AutoControlAreaAlignment: Boolean read GetAutoControlAreaAlignment;
    property CaptionLayout: TdxCaptionLayout read GetCaptionLayout;
    property CaptionViewInfo: TdxLayoutControlItemCaptionViewInfo read GetCaptionViewInfo;
    property ControlViewInfo: TdxLayoutControlItemControlViewInfo read FControlViewInfo;
  end;

  { TdxLayoutItemViewInfo }

  TdxLayoutItemViewInfo = class(TdxLayoutControlItemViewInfo)
  private
    function GetCaptionViewInfo: TdxLayoutItemCaptionViewInfo;
    function GetControlViewInfo: TdxLayoutItemControlViewInfo;
    function GetItem: TdxLayoutItem;
  protected
    function CanFocusOnClick(X, Y: Integer): Boolean; override;
    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
    function GetControlViewInfoClass: TdxLayoutControlItemControlViewInfoClass; override;
    function GetPainterClass: TdxCustomLayoutItemPainterClass; override;
    procedure PopulateControlViewInfoList(AControls, AWinControls: TList); override;

    procedure CustomizationMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    function PtInDesignSelectorRect(const P: TPoint): Boolean;
    property Item: TdxLayoutItem read GetItem;
  public
    property CaptionViewInfo: TdxLayoutItemCaptionViewInfo read GetCaptionViewInfo;
    property ControlViewInfo: TdxLayoutItemControlViewInfo read GetControlViewInfo;
  end;

  { GroupViewInfos }

  { TdxLayoutGroupCaptionViewInfo }

  TdxLayoutGroupCaptionViewInfo = class(TdxCustomLayoutItemCaptionViewInfo)
  private
    function GetCaptionSide: TdxLayoutSide;
    function GetGroupViewInfo: TdxLayoutGroupViewInfo;
  protected
    function GetAlignHorz: TAlignment; override;
    function GetAlignVert: TdxAlignmentVert; override;
    function GetAvailableTextHeight: Integer; override;
    function GetAvailableTextWidth: Integer; override;
    function GetImageAreaBounds: TRect; override;
    function GetTextHeight: Integer; override;
    function GetTextWidth: Integer; override;

    function GetRotationAngle: TcxRotationAngle; override;
    function IsVerticalCaption: Boolean; override;

    property CaptionSide: TdxLayoutSide read GetCaptionSide;
    property GroupViewInfo: TdxLayoutGroupViewInfo read GetGroupViewInfo;
  public
    function CalculateHeight: Integer; override;
    function CalculateMinHeight: Integer; override;
    function CalculateMinWidth: Integer; override;
    function CalculateWidth: Integer; override;
  end;

  TItemInfo = record
    ViewInfo: TdxCustomLayoutItemViewInfo;
    AlignHorz: TdxLayoutAlignHorz;
    UsualWidth, MinWidth, RealWidth: Integer;
    Height: Integer;
    Bounds: TRect;
    Calculated: Boolean;
  end;
  TItemInfos = array of TItemInfo;

  TdxLayoutGroupViewInfoSpecific = class(TObject, IUnknown)
  private
    FGroupViewInfo: TdxLayoutGroupViewInfo;
    FItemInfos: TItemInfos;

    procedure PrepareItemInfos;
    procedure CalculateItemViewInfos;

    function GetContainer: TdxLayoutContainer;
    function GetItemOffset: Integer;
    function GetItemViewInfo(Index: Integer): TdxCustomLayoutItemViewInfo;
    function GetItemViewInfoCount: Integer;
    function GetLayoutDirection: TdxLayoutDirection;
  protected
    // Drawing
    function CanDrawSpecificControls: Boolean; virtual;
    procedure DrawSpecificControls(ACanvas: TcxCanvas); virtual;

    // Calculating
    procedure CalculateItemsAreaBounds(var AItemsAreaBounds: TRect); virtual;
    procedure CalculateItemsHorizontalBounds(const AItemsAreaBounds: TRect); virtual;
    procedure CalculateItemsVerticalBounds(const AItemsAreaBounds: TRect); virtual;
    procedure CalculateInternalTabOrders(var ATabOrder: Integer); virtual;
    procedure CorrectItemsAreaBounds(var AItemsAreaBounds: TRect); virtual;

    // Dragging
    procedure CorrectAreaPart(var AAreaPart: TdxLayoutAreaPart); virtual;
    function GetActionType(AAreaPart: TdxLayoutAreaPart): TdxLayoutActionType; virtual; abstract;
    function GetAreaPart(const P: TPoint): TdxLayoutAreaPart; virtual;
    function GetAreaPartBounds(AAreaPart: TdxLayoutAreaPart; AItemViewInfo: TdxCustomLayoutItemViewInfo): TRect; virtual;

    // Sizes
    procedure ConvertCoords(var R: TRect); virtual;
    function GetCustomHeight(AIsMinHeight: Boolean): Integer; virtual;
    function GetCustomWidth(AIsMinWidth: Boolean): Integer; virtual;
    function GetItemAlignHorz(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignHorz; virtual; abstract;
    function GetItemAlignVert(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignVert; virtual; abstract;

    function GetItemUsualHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; virtual; abstract;
    function GetItemUsualWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; virtual; abstract;
    function GetItemMinHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; virtual; abstract;
    function GetItemMinWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; virtual; abstract;
    function IsViewInfoFixedWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Boolean; virtual; abstract;
    function IsViewInfoFixedHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Boolean; virtual; abstract;

    function GetItemsAreaOffset(ASide: TdxLayoutSide): Integer; virtual;

    // Selection
    procedure AddSelectionControls; virtual;
    procedure RemoveSelectionControls; virtual;

    function CanFocus: Boolean; virtual;
    function CanFocusOnClick(X, Y: Integer): Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;

    // Specific Objects
    procedure CreateSpecificControls; virtual;
    procedure DestroySpecificControls; virtual;
    procedure CreateViewInfos; virtual;
    procedure DestroyViewInfos; virtual;

    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    property Container: TdxLayoutContainer read GetContainer;
    property GroupViewInfo: TdxLayoutGroupViewInfo read FGroupViewInfo;
    property ItemOffset: Integer read GetItemOffset;
    property ItemViewInfoCount: Integer read GetItemViewInfoCount;
    property ItemViewInfos[Index: Integer]: TdxCustomLayoutItemViewInfo read GetItemViewInfo;
    property LayoutDirection: TdxLayoutDirection read GetLayoutDirection;
  public
    constructor Create(AGroupViewInfo: TdxLayoutGroupViewInfo); virtual;
    destructor Destroy; override;

    procedure Calculate(const AItemsAreaBounds: TRect); virtual;
    procedure CalculateItemsBounds(AItemsAreaBounds: TRect);
    function GetItemsAreaHeight(AIsMinHeight: Boolean): Integer; virtual;
    function GetItemsAreaWidth(AIsMinWidth: Boolean): Integer; virtual;
    function IsAtInsertionPos(const R: TRect; const P: TPoint): Boolean; virtual; abstract;

    function AllowDrawChild(AChildViewInfo: TdxCustomLayoutItemViewInfo): Boolean; virtual;
    function AllowChildHasBorder: Boolean; virtual;
    function GetChildInplaceRenameBounds(AChildViewInfo: TdxCustomLayoutItemViewInfo): TRect; virtual;
    function GetDefaultItemControlAreaAlignment: TdxLayoutItemControlAreaAlignment; virtual;
    function ProcessDialogKey(ACharCode: Word; AKeyData: Integer; AFocusedItem: TdxLayoutItem): Boolean; virtual;
  end;

  TdxLayoutGroupViewInfoHorizontalSpecific = class(TdxLayoutGroupViewInfoSpecific)
  protected
    function GetActionType(AAreaPart: TdxLayoutAreaPart): TdxLayoutActionType; override;
    function GetAreaPartBounds(AAreaPart: TdxLayoutAreaPart; AItemViewInfo: TdxCustomLayoutItemViewInfo): TRect; override;
    function GetItemAlignHorz(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignHorz; override;
    function GetItemAlignVert(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignVert; override;
    function GetItemUsualHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; override;
    function GetItemUsualWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; override;
    function GetItemMinHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; override;
    function GetItemMinWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; override;
    function IsViewInfoFixedWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Boolean; override;
    function IsViewInfoFixedHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Boolean; override;
  public
    function IsAtInsertionPos(const R: TRect; const P: TPoint): Boolean; override;
  end;

  TdxLayoutGroupViewInfoVerticalSpecific = class(TdxLayoutGroupViewInfoSpecific)
  protected
    procedure ConvertCoords(var R: TRect); override;
    function GetActionType(AAreaPart: TdxLayoutAreaPart): TdxLayoutActionType; override;
    function GetAreaPartBounds(AAreaPart: TdxLayoutAreaPart; AItemViewInfo: TdxCustomLayoutItemViewInfo): TRect; override;
    function GetItemAlignHorz(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignHorz; override;
    function GetItemAlignVert(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignVert; override;
    function GetItemUsualHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; override;
    function GetItemUsualWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; override;
    function GetItemMinHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; override;
    function GetItemMinWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; override;
    function IsViewInfoFixedWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Boolean; override;
    function IsViewInfoFixedHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Boolean; override;
  public
    function GetItemsAreaHeight(AIsMinHeight: Boolean): Integer; override;
    function GetItemsAreaWidth(AIsMinWidth: Boolean): Integer; override;
    function IsAtInsertionPos(const R: TRect; const P: TPoint): Boolean; override;
  end;

  { TdxLayoutTabbedController }

  TdxLayoutTabbedController = class(TcxCustomTabControlController)
  private
    FOnTabClick: TcxTabChangedEvent;
  protected
    function GetClientToScreen(const APoint: TPoint): TPoint; override;
    function GetScreenToClient(const APoint: TPoint): TPoint; override;
    procedure DoTabClick(ATabVisibleIndex: Integer; AShift: TShiftState); override;

    property OnTabClick: TcxTabChangedEvent read FOnTabClick write FOnTabClick;
  end;

  { TdxLayoutTabbedViewInfo }

  TdxLayoutTabbedViewInfo = class(TcxCustomTabControlViewInfo)
  private
    function GetGroupViewInfo: TdxLayoutGroupViewInfo;
  protected
    function GetTabIndex: Integer; override;
    procedure SetTabIndex(Value: Integer); override;

    property GroupViewInfo: TdxLayoutGroupViewInfo read GetGroupViewInfo;
  end;

  TdxTabControlElementViewInfo = class(TdxCustomLayoutItemElementViewInfo)
  private
    FTabController: TdxLayoutTabbedController;
    FTabViewInfo: TdxLayoutTabbedViewInfo;
    function GetGroup: TdxLayoutGroup;
  protected
    function GetVisible: Boolean; override;
    procedure MouseLeave; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    property Group: TdxLayoutGroup read GetGroup;
  end;

  TdxLayoutGroupViewInfoTabbedSpecific = class(TdxLayoutGroupViewInfoHorizontalSpecific, IcxTabControl, IcxControlComponentState)
  private
    FTabControlBounds: TRect;
    FTabControlElementViewInfo: TdxTabControlElementViewInfo;
    FTabControlElementViewInfoOpposite: TdxTabControlElementViewInfo;

    FTabController: TdxLayoutTabbedController;
    FTabPainter: TcxPCCustomPainter;
    FTabViewInfo: TdxLayoutTabbedViewInfo;

    procedure DrawTabControl(ACanvas: TcxCanvas);
    function GetTabbedOptions: TdxLayoutTabbedOptions;
    procedure TabClick(ASender: TObject; ATabIndex: Integer);
  protected
    // Drawing
    function CanDrawSpecificControls: Boolean; override;
    procedure DrawSpecificControls(ACanvas: TcxCanvas); override;

    // Calculating
    procedure CalculateItemsAreaBounds(var AItemsAreaBounds: TRect); override;
    procedure CalculateItemsHorizontalBounds(const AItemsAreaBounds: TRect); override;
    procedure CalculateInternalTabOrders(var ATabOrder: Integer); override;
    procedure CalculateTabControl; virtual;

    // Dragging
    function GetActionType(AAreaPart: TdxLayoutAreaPart): TdxLayoutActionType; override;
    procedure CorrectAreaPart(var AAreaPart: TdxLayoutAreaPart); override;
    function GetAreaPart(const P: TPoint): TdxLayoutAreaPart; override;
    function GetAreaPartBounds(AAreaPart: TdxLayoutAreaPart; AItemViewInfo: TdxCustomLayoutItemViewInfo): TRect; override;

    // Sizes
    function GetCustomHeight(AIsMinHeight: Boolean): Integer; override;
    function GetCustomWidth(AIsMinWidth: Boolean): Integer; override;

    function GetItemsAreaOffset(ASide: TdxLayoutSide): Integer; override;
    function GetHitTabIndex(const P: TPoint): Integer;

    function CanFocus: Boolean; override;
    function CanFocusOnClick(X, Y: Integer): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    // Specific Objects
    procedure CreateSpecificControls; override;
    procedure DestroySpecificControls; override;
    procedure CreateViewInfos; override;
    procedure DestroyViewInfos; override;

    procedure CreateTabControl;
    procedure DestroyTabControl;
    function HasTabControl: Boolean;

    // IcxTabControl
    function IcxTabControl.GetController = GetTabController;
    function GetTabController: TcxCustomTabControlController;
    function IcxTabControl.GetPainter = GetTabPainter;
    function GetTabPainter: TcxPCCustomPainter;
    function IcxTabControl.GetProperties = GetTabProperties;
    function GetTabProperties: TcxCustomTabControlProperties;
    function IcxTabControl.GetViewInfo = GetTabViewInfo;
    function GetTabViewInfo: TcxCustomTabControlViewInfo;
    function IcxTabControl.CanDrawParentBackground = CanDrawTabParentBackground;
    function CanDrawTabParentBackground: Boolean;
    function IcxTabControl.GetBoundsRect = GetTabBoundsRect;
    function GetTabBoundsRect: TRect;
    function GetCanvas: TcxCanvas;
    function GetControl: TWinControl;
    function IcxTabControl.GetColor = GetTabColor;
    function GetTabColor: TColor;
    function GetDragAndDropObject: TcxDragAndDropObject;
    function GetDragAndDropState: TcxDragAndDropState;
    function GetFont: TFont;
    function GetLookAndFeel: TcxLookAndFeel;

    procedure IcxTabControl.InvalidateRect = InvalidateTabRect;
    procedure InvalidateTabRect(const R: TRect; AEraseBackground: Boolean);
    procedure SetModified;
    function IsEnabled: Boolean;
    function IsDesigning: Boolean;
    function IsDestroying: Boolean;
    function IsFocused: Boolean;
    function IsLoading: Boolean;
    function IsParentBackground: Boolean;
    procedure RequestLayout;

    property TabbedOptions: TdxLayoutTabbedOptions read GetTabbedOptions;
  public
    constructor Create(AGroupViewInfo: TdxLayoutGroupViewInfo); override;
    destructor Destroy; override;

    function AllowDrawChild(AChildViewInfo: TdxCustomLayoutItemViewInfo): Boolean; override;
    function AllowChildHasBorder: Boolean; override;
    function GetChildInplaceRenameBounds(AChildViewInfo: TdxCustomLayoutItemViewInfo): TRect; override;
    function GetDefaultItemControlAreaAlignment: TdxLayoutItemControlAreaAlignment; override;
    function ProcessDialogKey(ACharCode: Word; AKeyData: Integer; AFocusedItem: TdxLayoutItem): Boolean; override;
  end;

  TdxLayoutGroupButtonsViewInfo = class;

  TdxLayoutGroupButtonViewInfo = class(TdxCustomLayoutItemElementViewInfo)
  private
    FButton: TdxLayoutGroupButton;
    FButtonsViewInfo: TdxLayoutGroupButtonsViewInfo;
    function GetGlyph: TBitmap;
    function GetIsEnabled: Boolean;
    function GetVisibleIndex: Integer;
  protected
    // Mouse
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DoClick; virtual;

    procedure StateChanged; override;
    function IsHotTrackable: Boolean; override;

    // Hint
    function ShowHint(var AHintInfo: THintInfo): Boolean; override;

    function GetVisible: Boolean; override;
    function GetPainterClass: TdxLayoutGroupButtonPainterClass; virtual;
    function GetState: TcxButtonState; virtual;

    function IsGroupExpanded: Boolean;
    function IsExpandButton: Boolean;

    property Glyph: TBitmap read GetGlyph;
    property IsEnabled: Boolean read GetIsEnabled;
  public
    constructor Create(AButtonsViewInfo: TdxLayoutGroupButtonsViewInfo; AButton: TdxLayoutGroupButton); reintroduce; virtual;

    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;

    property Button: TdxLayoutGroupButton read FButton;
    property ButtonsViewInfo: TdxLayoutGroupButtonsViewInfo read FButtonsViewInfo;
    property VisibleIndex: Integer read GetVisibleIndex;
  end;

  TdxLayoutGroupButtonsViewInfo = class(TdxCustomLayoutItemElementViewInfo)
  private
    FButtonViewInfos: TcxObjectList;
    function GetButtonViewInfos(Index: Integer): TdxLayoutGroupButtonViewInfo;
    function GetButtonViewInfoCount: Integer;
    function GetExpandButton: TdxLayoutGroupButton;
    function GetGroupViewInfo: TdxLayoutGroupViewInfo;
    function GetOptions: TdxLayoutGroupButtonOptions;
  protected
    function GetVisible: Boolean; override;

    procedure CalculateHorizontalLayout;
    procedure CalculateVerticalLayout;

    procedure CalculateButtonViewInfos;
    procedure CreateButtonViewInfos;
    procedure RecreateButtonViewInfos;
    procedure DestroyButtonViewInfos;

    function InternalCalculateHeight: Integer; virtual;
    function InternalCalculateWidth: Integer; virtual;

    procedure DoSetOffset(const Value: TPoint); override;

    function IsLeftAlignment: Boolean; virtual;

    property ExpandButton: TdxLayoutGroupButton read GetExpandButton;
    property Options: TdxLayoutGroupButtonOptions read GetOptions;
  public
    constructor Create(AItemViewInfo: TdxCustomLayoutItemViewInfo); override;
    destructor Destroy; override;

    procedure Calculate(const ABounds: TRect); override;
    function CalculateHeight: Integer; override;
    function CalculateMinHeight: Integer; override;
    function CalculateMinWidth: Integer; override;
    function CalculateWidth: Integer; override;

    property ButtonViewInfoCount: Integer read GetButtonViewInfoCount;
    property ButtonViewInfos[Index: Integer]: TdxLayoutGroupButtonViewInfo read GetButtonViewInfos;
    property GroupViewInfo: TdxLayoutGroupViewInfo read GetGroupViewInfo;
  end;

  TdxLayoutGroupViewInfoCloneData = class(TdxCustomLayoutItemViewInfoCloneData)
  private
    FIsExpanded: Boolean;
    FItemIndex: Integer;
    procedure SetIsExpanded(Value: Boolean);
    procedure SetItemIndex(Value: Integer);
  public
    procedure Assign(Source: TdxCustomLayoutItemViewInfoCloneData); override;
    procedure Calculate; override;
    procedure Load(AStream: TStream); override;
    procedure Save(AStream: TStream); override;
    property IsExpanded: Boolean read FIsExpanded write SetIsExpanded;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
  end;

  TdxLayoutGroupViewInfo = class(TdxCustomLayoutItemViewInfo)
  private
    FButtonsViewInfo: TdxLayoutGroupButtonsViewInfo;
    FOffsetsCalculated: Boolean;
    FItemOffset: Integer;
    FItemsAreaOffsetHorz: Integer;
    FItemsAreaOffsetVert: Integer;
    FItemViewInfos: TObjectList;
    FSpecific: TdxLayoutGroupViewInfoSpecific;

    function GetBorderBounds(ASide: TdxLayoutSide): TRect;
    function GetBorderRestSpaceBounds(ASide: TdxLayoutSide): TRect;
    function GetBordersHeight: Integer;
    function GetBordersWidth: Integer;
    function GetCaptionSide: TdxLayoutSide;
    function GetCaptionViewInfo: TdxLayoutGroupCaptionViewInfo;
    function GetCloneData: TdxLayoutGroupViewInfoCloneData;
    function GetGroup: TdxLayoutGroup;
    function GetItemViewInfo(Index: Integer): TdxCustomLayoutItemViewInfo;
    function GetItemViewInfoCount: Integer;
    function GetLayoutDirection: TdxLayoutDirection;
    function GetOptionsEx: TdxLayoutLookAndFeelGroupOptions;
    function GetRealItemControlAreaAlignment: TdxLayoutItemControlAreaAlignment;

    function GetItemIndex: Integer;
    function GetOffset(Index: Integer): Integer;

    procedure CreateItemViewInfos;
    procedure CreateSpecific;
    procedure DestroyItemViewInfos;
    procedure DestroySpecific;
  protected
    FCaptionAreaBounds: TRect;
    FButtonsAreaBounds: TRect;
    FClientAreaBounds: TRect;
    FItemsAreaBounds: TRect;

    procedure DoCreateViewInfos; override;
    procedure DestroyViewInfos; override;
    procedure PopulateAutoAlignControlList(AList: TList); override;
    procedure PopulateControlViewInfoList(AControls, AWinControls: TList); override;

    // Classes
    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
    function GetCloneDataClass: TdxCustomLayoutItemViewInfoCloneDataClass; override;
    function GetHitTestClass: TdxCustomLayoutItemHitTestClass; override;
    function GetPainterClass: TdxCustomLayoutItemPainterClass; override;

    // Drawing attributes
    function CanDrawSpecificControls: Boolean; virtual;
    function GetBackgroundColor: TColor; override;
    function GetColor: TColor; override;

    // Calculating
    procedure AutoAlignControls; override;
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function DoCalculateHeight(AIsMinHeight: Boolean = False): Integer; override;
    function DoCalculateWidth(AIsMinWidth: Boolean = False): Integer; override;

    // Dragging
    procedure CorrectAreaPart(var AAreaPart: TdxLayoutAreaPart);
    function GetActionType(AAreaPart: TdxLayoutAreaPart): TdxLayoutActionType;
    function GetAreaPart(const P: TPoint): TdxLayoutAreaPart; override;
    function GetAreaPartBounds(AAreaPart: TdxLayoutAreaPart; AItemViewInfo: TdxCustomLayoutItemViewInfo): TRect;
    function GetPadding: TRect; override;

    function CanFocusOnClick(X, Y: Integer): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure LoadCloneData(AStream: TStream); override;
    procedure SaveCloneData(AStream: TStream); override;

    // Conditions
    function HasCaption: Boolean; override;
    function HasBorder: Boolean; override;
    function HasButtons: Boolean;
    function HasExpandButton: Boolean;
    function IsDefaultColor: Boolean; override;
    function IsSkinPainterUsed: Boolean;
    function IsTransparent: Boolean; override;

    // TdxLayoutGroupViewInfo methods
    // Calculating
    procedure CalculateButtonsViewInfoBounds; virtual;
    procedure CalculateCaptionViewInfoBounds; virtual;
    procedure CalculateClientBounds; virtual;
    procedure CalculateItemsAreaBounds; virtual;
    procedure CalculateOffsets;
    procedure CalculateViewInfosBounds;
    function GetButtonsViewInfoOffset: Integer; virtual;
    function GetButtonsViewInfoSpace: Integer; virtual;
    function GetCaptionViewInfoOffset: Integer; virtual;
    function GetSpaceBetweenButtons: Integer;

    // Sizes
    function GetClientAreaBounds(const ABounds: TRect): TRect;
    function GetItemAreaBounds(const AClientRect: TRect): TRect;
    function GetBorderWidth(ASide: TdxLayoutSide): Integer; virtual;
    function GetHeight(AItemsAreaHeight: Integer): Integer; virtual;
    function GetWidth(AItemsAreaWidth: Integer): Integer; virtual;
    function GetMinVisibleHeight: Integer; virtual;
    function GetMinVisibleWidth: Integer; virtual;
    function GetRestSpaceBounds: TRect; virtual;

    procedure DoSetOffset(const Value: TPoint); override;

    // Conditions
    function AllowChildHasBorder: Boolean;
    function AllowCollapsedHeight: Boolean; virtual;
    function AllowCollapsedWidth: Boolean; virtual;
    function AllowDrawChild(AChildViewInfo: TdxCustomLayoutItemViewInfo): Boolean; virtual;
    function GetChildInplaceRenameBounds(AChildViewInfo: TdxCustomLayoutItemViewInfo): TRect; virtual;
    function GetRotationAngle: TcxRotationAngle;
    function IsChildActuallyVisible(AChildViewInfo: TdxCustomLayoutItemViewInfo): Boolean;
    function IsExpanded: Boolean; override;
    function IsVerticalCaption: Boolean;
    function UseItemOffset: Boolean; virtual;
    function UseItemsAreaOffsets: Boolean; virtual;

    // Classes
    function GetItemViewInfoClass(AItem: TdxCustomLayoutItem): TdxCustomLayoutItemViewInfoClass; virtual;
    function GetSpecificClass: TdxLayoutGroupViewInfoSpecificClass; virtual;

    // Selections
    procedure PaintSelectionLayer(ABitmap: TcxAlphaBitmap); override;

    // TabOrders
    function GetMaxTabOrderIndex: Integer; override;

    procedure DoButtonClick(AViewInfo: TdxLayoutGroupButtonViewInfo); virtual;

    property ButtonsViewInfoOffset: Integer read GetButtonsViewInfoOffset;
    property CaptionViewInfoOffset: Integer read GetCaptionViewInfoOffset;
    property ItemIndex: Integer read GetItemIndex;
    property ItemOffset: Integer index 0 read GetOffset write FItemOffset;
    property ItemsAreaOffsetHorz: Integer index 1 read GetOffset write FItemsAreaOffsetHorz;
    property ItemsAreaOffsetVert: Integer index 2 read GetOffset write FItemsAreaOffsetVert;
    property MinVisibleHeight: Integer read GetMinVisibleHeight;
    property MinVisibleWidth: Integer read GetMinVisibleWidth;
    property RestSpaceBounds: TRect read GetRestSpaceBounds;

    property CaptionSide: TdxLayoutSide read GetCaptionSide;
    property CloneData: TdxLayoutGroupViewInfoCloneData read GetCloneData;
    property Group: TdxLayoutGroup read GetGroup;
    property LayoutDirection: TdxLayoutDirection read GetLayoutDirection;
    property Options: TdxLayoutLookAndFeelGroupOptions read GetOptionsEx;
    property Specific: TdxLayoutGroupViewInfoSpecific read FSpecific;
  public
    procedure Calculate(const ABounds: TRect); override;
    procedure CalculateInternalTabOrders(var AAvailTabOrder: Integer); override;
    procedure CalculateTabOrders(var AAvailTabOrder: Integer); override;
    function FindItemViewInfo(AItem: TdxCustomLayoutItem): TdxCustomLayoutItemViewInfo;
    function GetHitTest(const P: TPoint): TdxCustomLayoutHitTest; override;
    function GetItemWithMouse(const P: TPoint): TdxCustomLayoutItem; override;
    function GetInsertionPos(const P: TPoint): Integer; virtual;

    property BorderBounds[ASide: TdxLayoutSide]: TRect read GetBorderBounds;
    property BorderRestSpaceBounds[ASide: TdxLayoutSide]: TRect read GetBorderRestSpaceBounds;
    property BorderWidths[ASide: TdxLayoutSide]: Integer read GetBorderWidth;
    property BordersHeight: Integer read GetBordersHeight;
    property BordersWidth: Integer read GetBordersWidth;
    property ButtonsViewInfo: TdxLayoutGroupButtonsViewInfo read FButtonsViewInfo;
    property CaptionViewInfo: TdxLayoutGroupCaptionViewInfo read GetCaptionViewInfo;
    property ClientBounds: TRect read FClientAreaBounds;
    property ItemsAreaBounds: TRect read FItemsAreaBounds;
    property ItemViewInfoCount: Integer read GetItemViewInfoCount;
    property ItemViewInfos[Index: Integer]: TdxCustomLayoutItemViewInfo read GetItemViewInfo;
  end;

  // control

  { TdxLayoutContainerViewInfo }

  TdxLayoutContainerViewInfo = class
  private
    FContainer: TdxLayoutContainer;
    FContentBounds: TRect;
    FIsDragImagePainted: Boolean;
    FItemCloneDataList: TdxLayoutCloneDataList;
    FItemsViewInfo: TdxLayoutGroupViewInfo;
    FItemWithMouse: TdxCustomLayoutItem;
    FOffset: TPoint;
    FSelectionLayer: TdxSelectionLayer;
    FOnCloneDataChanged: TNotifyEvent;
    procedure BuildSelectionLayer;
    procedure CreateSelectionLayer;
    function GetCanvas: TcxCanvas;
    function GetClientBounds: TRect;
    function GetContentBounds: TRect;
    function GetContentHeight: Integer;
    function GetContentWidth: Integer;
    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
    function GetSelectionLayer: TdxSelectionLayer;
    procedure SelectionLayerHitTest(ASender: TObject; var AIsTransparent: Boolean);
    procedure SelectionLayerUpdate(Sender: TObject);
    procedure SelectionLayerEndRename(ASender: TObject; const AText: string; AAccept: Boolean);
    procedure SetItemWithMouse(Value: TdxCustomLayoutItem);
    procedure SetOffset(const Value: TPoint);
  protected
    procedure CreateViewInfos; virtual;
    procedure DestroyViewInfos; virtual;
    function GetItemsViewInfoClass: TdxLayoutGroupViewInfoClass; virtual;
    procedure PrepareData; virtual;
    procedure RecreateViewInfos;

    procedure AlignItemsByConstraint; virtual;
    procedure AutoAlignControls; virtual;
    procedure CalculateItemsViewInfo; virtual;
    procedure DoCalculate; virtual;
    procedure DoCalculateInternalTabOrders; virtual;
    procedure DoCalculateTabOrders; virtual;

    function ShowHint(var AHintInfo: THintInfo; X, Y: Integer): Boolean;

    function HasBackground: Boolean;
    function NeedHighlightRoot: Boolean;

    function GetScrollOffset: TPoint;
    function IsDragImagePainted: Boolean; virtual;

    function GetCloneData(AViewInfo: TdxCustomLayoutItemViewInfo): TdxCustomLayoutItemViewInfoCloneData;
    function FindCloneData(AItem: TdxCustomLayoutItem; out ACloneData: TdxCustomLayoutItemViewInfoCloneData): Boolean;
    function IsClone: Boolean; virtual;
    procedure ItemCloneDataListChangedHandler(Sender: TObject);
    procedure LoadCloneData(AStream: TStream); virtual;
    procedure RecalculateCloneDataList;
    procedure SaveCloneData(AStream: TStream); virtual;

    procedure ResetContentBounds;

    property Canvas: TcxCanvas read GetCanvas;
    property ItemWithMouse: TdxCustomLayoutItem read FItemWithMouse write SetItemWithMouse;
    property SelectionLayer: TdxSelectionLayer read GetSelectionLayer;
    property OnCloneDataChanged: TNotifyEvent read FOnCloneDataChanged write FOnCloneDataChanged;
  public
    constructor Create(AContainer: TdxLayoutContainer); virtual;
    destructor Destroy; override;

    procedure Calculate; virtual;
    procedure CalculateTabOrders; virtual;
    function FindItemViewInfo(AItem: TdxCustomLayoutItem; out AViewInfo: TdxCustomLayoutItemViewInfo): Boolean; overload;
    function FindItemViewInfo(AItem: TdxCustomLayoutItem): TdxCustomLayoutItemViewInfo; overload;
    function GetHitTest(const P: TPoint): TdxCustomLayoutHitTest; virtual;
    function GetItemWithMouse(const P: TPoint): TdxCustomLayoutItem;

    procedure AssignItemWithMouse(X, Y: Integer);
    function CanFocusOnClick(X, Y: Integer): Boolean; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseLeave(AControl: TControl); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;

    procedure StartDragImagePainted;
    procedure StopDragImagePainted;

    property ClientBounds: TRect read GetClientBounds;
    property Container: TdxLayoutContainer read FContainer;
    property ContentBounds: TRect read GetContentBounds;
    property ContentHeight: Integer read GetContentHeight;
    property ContentWidth: Integer read GetContentWidth;
    property ItemsViewInfo: TdxLayoutGroupViewInfo read FItemsViewInfo;
    property LayoutLookAndFeel: TdxCustomLayoutLookAndFeel read GetLayoutLookAndFeel;
    property Offset: TPoint read FOffset write SetOffset;
  end;

procedure dxDrawItemGlyph(ACanvas: TcxCanvas; AItem: TdxCustomLayoutItem; R: TRect; ARotationAngle: TcxRotationAngle);

const
  dxDefaultLayoutCustomizeFormMenuItems = [cfmiAlignHorz, cfmiAlignVert, cfmiDirection, cfmiCaptionLayout, cfmiCaptionAlignHorz,
    cfmiCaptionAlignVert, cfmiCaption, cfmiBorder, cfmiExpandButton];

var
  dxLayoutRunTimeSelectionHelperClass: TdxLayoutRunTimeSelectionHelperClass;

implementation

uses
  Types, TypInfo, Registry, Math, Variants,
  UxTheme, Themes, cxPCPaintersFactory,
  cxContainer, dxOffice11, cxButtons, dxLayoutControlAdapters, dxLayoutCustomizeForm,
  dxLayoutStrs, dxLayoutDragAndDrop, cxStorage;

type
  TControlAccess = class(TControl);
  TWinControlAccess = class(TWinControl);
  TcxControlAccess = class(TcxControl);
  TdxCustomLayoutLookAndFeelAccess = class(TdxCustomLayoutLookAndFeel);
  TcxPCCustomPainterAccess = class(TcxPCCustomPainter);
  TdxSelectionLayerAccess = class(TdxSelectionLayer);
  TcxCustomTabControlControllerAccess = class(TcxCustomTabControlController);

const
  dxLayoutHiddenGroupBackgroundDefaultColor: TColor = $F0E3D1;
  dxLayoutSelectionOffset = 2;
  dxLayoutGlyphSpace = 4;
  dxLayoutSelectionMarkerWidth = 5;
  dxLayoutThinPartWidth = 2;

  dxLayoutNoActiveItem = -1;
  dxLayoutPseudoActiveItem = -2;

function dxGetSelectionMarker(const P: TPoint; AMarkerWidth: Integer): TRect;
begin
  Result := cxRectInflate(cxRect(P, P), (AMarkerWidth - 1) div 2, (AMarkerWidth - 1) div 2);
  Inc(Result.Bottom);
  Inc(Result.Right);
end;

function dxGetSelectionMarkers(const ABorderBounds: TRect; AMarkerWidth: Integer): TRects;
var
  AMiddleX, AMiddleY: Integer;
begin
  SetLength(Result, 8);
  with ABorderBounds do
  begin
    AMiddleX := (Left + Right - 1) div 2;
    AMiddleY := (Top + Bottom - 1) div 2;
    Result[0] := dxGetSelectionMarker(TopLeft, AMarkerWidth);
    Result[1] := dxGetSelectionMarker(Point(AMiddleX, Top), AMarkerWidth);
    Result[2] := dxGetSelectionMarker(Point(Right - 1, Top), AMarkerWidth);
    Result[3] := dxGetSelectionMarker(Point(Right - 1, AMiddleY), AMarkerWidth);
    Result[4] := dxGetSelectionMarker(Point(Right - 1, Bottom - 1), AMarkerWidth);
    Result[5] := dxGetSelectionMarker(Point(AMiddleX, Bottom - 1), AMarkerWidth);
    Result[6] := dxGetSelectionMarker(Point(Left, Bottom - 1), AMarkerWidth);
    Result[7] := dxGetSelectionMarker(Point(Left, AMiddleY), AMarkerWidth);
  end;
end;

procedure dxDrawSelectionMarkers(ACanvas: TcxCanvas; AMarkers: TRects;
  ABorderColor, ABorderMarkerInnerColor: TColor);

  procedure DrawSelectionBorderMarker(const R: TRect);
  begin
    ACanvas.Brush.Color := ABorderMarkerInnerColor;
    ACanvas.Pen.Color := ABorderColor;
    ACanvas.Canvas.Rectangle(R);
    ACanvas.ExcludeClipRect(R);
  end;

var
  I: Integer;
begin
  for I := Low(AMarkers) to High(AMarkers) do
    DrawSelectionBorderMarker(AMarkers[I]);
end;

procedure dxDrawItemGlyph(ACanvas: TcxCanvas; AItem: TdxCustomLayoutItem; R: TRect; ARotationAngle: TcxRotationAngle);

  function GetDrawMode(AGlyph: TBitmap; AImages: TCustomImageList): TcxImageDrawMode;
  var
    ADrawEnabled: Boolean;
  begin
    ADrawEnabled := AItem.Enabled or (not IsGlyphAssigned(AGlyph) and (AImages = AItem.Container.ILayout.GetDisabledImages));
    Result := EnabledImageDrawModeMap[ADrawEnabled];
  end;

var
  AGlyph: TBitmap;
  AImages: TCustomImageList;
  AImageIndex: Integer;
  ABitmap: TcxAlphaBitmap;
begin
  if AItem.CaptionOptions.ImageOptions.GetCurrentImage(AGlyph, AImages, AImageIndex) then
  begin
    if ARotationAngle = ra0 then
      cxDrawImage(ACanvas.Handle, R, R, AGlyph, AImages, AImageIndex, GetDrawMode(AGlyph, AImages))
    else
    begin
      ABitmap := TcxAlphaBitmap.CreateSize(R, True);
      try
        cxDrawImage(ABitmap.cxCanvas.Handle, ABitmap.ClientRect, ABitmap.ClientRect, AGlyph, AImages, AImageIndex, GetDrawMode(AGlyph, AImages));
        ABitmap.Rotate(ARotationAngle);
        cxDrawImage(ACanvas.Handle, R, R, ABitmap, nil, -1, idmNormal);
      finally
        ABitmap.Free;
      end;
    end;
  end;
end;

type
  { TdxLayoutControlAdapterDefs }

  PControlAdapterRecord = ^TControlAdapterRecord;
  TControlAdapterRecord = record
    ControlClass: TControlClass;
    AdapterClass: TdxCustomLayoutControlAdapterClass;
  end;

  TdxLayoutControlAdapterDefs = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TControlAdapterRecord;
    procedure ClearItems;
  protected
    procedure Delete(AIndex: Integer);
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TControlAdapterRecord read GetItem;
  public
    constructor Create;
    destructor Destroy; override;
    function GetAdapterClass(AControl: TControl): TdxCustomLayoutControlAdapterClass;
    procedure Register(AControlClass: TControlClass;
      AAdapterClass: TdxCustomLayoutControlAdapterClass);
    procedure Unregister(AControlClass: TControlClass;
      AAdapterClass: TdxCustomLayoutControlAdapterClass);
  end;

var
  FdxLayoutControlAdapterDefs: TdxLayoutControlAdapterDefs;

function dxLayoutControlAdapterDefs: TdxLayoutControlAdapterDefs;
begin
  if FdxLayoutControlAdapterDefs = nil then
    FdxLayoutControlAdapterDefs := TdxLayoutControlAdapterDefs.Create;
  Result := FdxLayoutControlAdapterDefs;
end;

function dxGetCenterAreaBounds(const AItemBounds: TRect): TRect;
begin
  Result := AItemBounds;
  with Result do
    InflateRect(Result, -(Right - Left) div 4, -(Bottom - Top) div 4);
end;

{ TdxLayoutControlAdapterDefs }

constructor TdxLayoutControlAdapterDefs.Create;
begin
  inherited;
  FItems := TList.Create;
end;

destructor TdxLayoutControlAdapterDefs.Destroy;
begin
  ClearItems;
  FItems.Free;
  inherited;
end;

function TdxLayoutControlAdapterDefs.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxLayoutControlAdapterDefs.GetItem(Index: Integer): TControlAdapterRecord;
begin
  Result := PControlAdapterRecord(FItems[Index])^;
end;

procedure TdxLayoutControlAdapterDefs.ClearItems;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Delete(I);
end;

procedure TdxLayoutControlAdapterDefs.Delete(AIndex: Integer);
begin
  Dispose(PControlAdapterRecord(FItems[AIndex]));
  FItems.Delete(AIndex);
end;

function TdxLayoutControlAdapterDefs.GetAdapterClass(AControl: TControl): TdxCustomLayoutControlAdapterClass;
var
  I: Integer;
  AControlAdapterRecord: TControlAdapterRecord;
begin
  for I := Count - 1 downto 0 do
  begin
    AControlAdapterRecord := Items[I];
    if AControl.InheritsFrom(AControlAdapterRecord.ControlClass) then
    begin
      Result := AControlAdapterRecord.AdapterClass;
      Exit;
    end;
  end;
  Result := TdxCustomLayoutControlAdapter;
end;

procedure TdxLayoutControlAdapterDefs.Register(AControlClass: TControlClass;
  AAdapterClass: TdxCustomLayoutControlAdapterClass);
var
  AControlAdapterRecord: PControlAdapterRecord;
begin
  New(AControlAdapterRecord);
  with AControlAdapterRecord^ do
  begin
    ControlClass := AControlClass;
    AdapterClass := AAdapterClass;
  end;
  FItems.Add(AControlAdapterRecord);
end;

procedure TdxLayoutControlAdapterDefs.Unregister(AControlClass: TControlClass;
  AAdapterClass: TdxCustomLayoutControlAdapterClass);
var
  I: Integer;
  AControlAdapterRecord: TControlAdapterRecord;
begin
  for I := 0 to Count - 1 do
  begin
    AControlAdapterRecord := Items[I];
    with AControlAdapterRecord do
      if (ControlClass = AControlClass) and (AdapterClass = AAdapterClass) then
      begin
        Delete(I);
        Break;
      end;
  end;
  if Count = 0 then
    FreeAndNil(FdxLayoutControlAdapterDefs);
end;

{ TdxUndoRedoManager }

constructor TdxUndoRedoManager.Create(AContainer: TdxLayoutContainer);
begin
  inherited Create;
  FContainer := AContainer;
  FUndoList := TObjectList.Create;
end;

destructor TdxUndoRedoManager.Destroy;
begin
  FreeAndNil(FUndoList);
  FreeAndNil(FCurrentLayout);
  inherited;
end;

function TdxUndoRedoManager.CanRedo: Boolean;
begin
  Result := RedoCount > 0;
end;

function TdxUndoRedoManager.CanUndo: Boolean;
begin
  Result := UndoCount > 0;
end;

procedure TdxUndoRedoManager.Redo;
var
  AIni: TMemIniFile;
begin
  if CanRedo then
  begin
    Inc(FLockCount);
    try
      Inc(FIndex);
      if FIndex = FUndoList.Count then
        AIni := FCurrentLayout
      else
        AIni := TMemIniFile(FUndoList[FIndex]);
      Container.InternalLoadFromCustomIniFile(AIni, True);
    finally
      Dec(FLockCount);
    end;
  end;
end;

procedure TdxUndoRedoManager.Undo;
var
  AIni: TMemIniFile;
begin
  if CanUndo then
  begin
    if FCurrentLayout = nil then
    begin
      FCurrentLayout := TMemIniFile.Create('');
      Container.InternalSaveToCustomIniFile(FCurrentLayout);
    end;
    Inc(FLockCount);
    try
      Dec(FIndex);
      AIni := TMemIniFile(FUndoList[FIndex]);
      Container.InternalLoadFromCustomIniFile(AIni, True);
    finally
      Dec(FLockCount);
    end;
  end;
end;

procedure TdxUndoRedoManager.CancelLastUndo;
begin
  if not (IsLocked or Container.IsDesigning) then
  begin
    Undo;
    FreeAndNil(FCurrentLayout);
    FUndoList.Delete(FUndoList.Count - 1);
  end;
end;

procedure TdxUndoRedoManager.SaveLayout;
var
  AIni: TMemIniFile;
begin
  if not (IsLocked or Container.IsDesigning) then
  begin
    AIni := TMemIniFile.Create('');
    Container.InternalSaveToCustomIniFile(AIni);
    AddUndo(AIni);
  end;
end;

function TdxUndoRedoManager.IsLocked: Boolean;
begin
  Result := FLockCount > 0;
end;

procedure TdxUndoRedoManager.Clear;
begin
  FUndoList.Clear;
  FreeAndNil(FCurrentLayout);
  FIndex := 0;
end;

procedure TdxUndoRedoManager.AddUndo(ALayout: TMemIniFile);
begin
  while FIndex < FUndoList.Count do
    FUndoList.Delete(FIndex);
  FreeAndNil(FCurrentLayout);
  FUndoList.Add(ALayout);
  FIndex := FUndoList.Count;
end;

function TdxUndoRedoManager.GetRedoCount: Integer;
begin
  Result := FUndoList.Count - UndoCount;
end;

function TdxUndoRedoManager.GetUndoCount: Integer;
begin
  Result := FIndex;
end;

{ TdxCustomLayoutItemOptions }

constructor TdxCustomLayoutItemOptions.Create(AItem: TdxCustomLayoutItem);
begin
  inherited Create;
  FItem := AItem;
end;

procedure TdxCustomLayoutItemOptions.BeginUpdate;
begin
  Item.BeginUpdate;
end;

procedure TdxCustomLayoutItemOptions.EndUpdate;
begin
  Item.CancelUpdate;
  Changed;
end;

procedure TdxCustomLayoutItemOptions.Changed;
begin
  FItem.Changed;
end;

{ TdxLayoutControlCustomCustomizeForm }

destructor TdxLayoutControlCustomCustomizeForm.Destroy;
begin
  Container := nil;
  inherited Destroy;
end;

function TdxLayoutControlCustomCustomizeForm.GetHitTest(const P: TPoint): TdxCustomLayoutHitTest;
begin
  Result := TdxLayoutCustomizeFormHitTest.Instance;
  TdxLayoutCustomizeFormHitTest(Result).Item := nil;
end;

procedure TdxLayoutControlCustomCustomizeForm.ToggleHotTrackState(AItem: TdxCustomLayoutItem);
begin
end;

procedure TdxLayoutControlCustomCustomizeForm.UpdateAvailableItems;
begin
end;

procedure TdxLayoutControlCustomCustomizeForm.UpdateCaption;
begin
end;

procedure TdxLayoutControlCustomCustomizeForm.UpdateContent;
begin
end;

procedure TdxLayoutControlCustomCustomizeForm.UpdateDragAndDropState;
begin
end;

procedure TdxLayoutControlCustomCustomizeForm.UpdateSelection;
begin
end;

procedure TdxLayoutControlCustomCustomizeForm.UpdateView;
begin
end;

procedure TdxLayoutControlCustomCustomizeForm.UpdateVisibleItems;
begin
end;

procedure TdxLayoutControlCustomCustomizeForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := GetWndParent;
end;

procedure TdxLayoutControlCustomCustomizeForm.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Container) then
    Free;
end;

function TdxLayoutControlCustomCustomizeForm.CanModify: Boolean;
begin
  Result := (Container <> nil) and Container.CanModify;
end;

function TdxLayoutControlCustomCustomizeForm.CanShowItem(AItem: TdxCustomLayoutItem): Boolean;
begin
  Result := AItem.IsVisibleForCustomization;
end;

function TdxLayoutControlCustomCustomizeForm.CanShowMenuItem(AMenuItem: TdxLayoutCustomizeFormMenuItem): Boolean;
begin
  Result := (Container <> nil) and (Container.IsDesigning or (AMenuItem in Container.MenuItems));
end;

function TdxLayoutControlCustomCustomizeForm.GetWndParent: THandle;
begin
  if (Container <> nil) and (Container.ItemsParent <> nil) and Container.ItemsParent.HandleAllocated then
    Result := Container.ItemsParent.Handle
  else
    Result := 0;
end;

function TdxLayoutControlCustomCustomizeForm.GetLayoutPopupMenu: TPopupMenu;
begin
  Result := nil;
end;

procedure TdxLayoutControlCustomCustomizeForm.InitializeControl;
begin
  UpdateCaption;
  UpdateDragAndDropState;
  UpdateContent;
  UpdateSelection;
  UpdateView;
  Container.OnItemChanged := ItemChanged;
end;

procedure TdxLayoutControlCustomCustomizeForm.ItemChanged(AItem: TdxCustomLayoutItem);
begin
end;

procedure TdxLayoutControlCustomCustomizeForm.SetContainer(AValue: TdxLayoutContainer);

  procedure StoreMetrics;
  begin
    cxDialogsMetricsStore.StoreMetrics(Self);
  end;

  procedure RestoreMetrics;
  begin
    if Container <> nil then
    begin
      if EqualRect(Container.CustomizeFormBounds, cxNullRect) then
        BoundsRect := Container.CalculateCustomizeFormBounds(BoundsRect)
      else
        BoundsRect := Container.CustomizeFormBounds;
    end;
    cxDialogsMetricsStore.InitDialog(Self);
    Position := poDesigned;
  end;

begin
  if Container <> AValue then
  begin
    if Container <> nil then
    begin
      Container.Customization := False;
      Container.OnItemChanged := nil;
      StoreMetrics;
    end;
    FContainer := AValue;
    if Container <> nil then
    begin
      RecreateWnd;
      RestoreMetrics;
      InitializeControl;
    end;
  end;
end;

{ TdxCustomLayoutItemImageOptions }

constructor TdxCustomLayoutItemImageOptions.Create(AItem: TdxCustomLayoutItem);
begin
  inherited Create(AItem);
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := GlyphChanged;
  FImageIndex := -1;
end;

destructor TdxCustomLayoutItemImageOptions.Destroy;
begin
  FreeAndNil(FGlyph);
  inherited Destroy;
end;

procedure TdxCustomLayoutItemImageOptions.Assign(Source: TPersistent);
begin
  if Source is TdxCustomLayoutItemImageOptions then
    with Source as TdxCustomLayoutItemImageOptions do
    begin
      Self.BeginUpdate;
      try
        Self.Glyph := Glyph;
        Self.ImageIndex := ImageIndex;
      finally
        Self.EndUpdate;
      end;
    end
  else
    inherited Assign(Source);
end;

function TdxCustomLayoutItemImageOptions.GetCurrentImage(out AGlyph: TBitmap; out AImages: TCustomImageList; out AImageIndex: Integer): Boolean;
begin
  AGlyph := nil;
  AImages := nil;
  AImageIndex := -1;
  
  Result := not Glyph.Empty;
  if Result then
    AGlyph := Glyph
  else
  begin
    Result := cxGraphics.IsImageAssigned(GetImageList(Item.Enabled), ImageIndex);
    if Result then
    begin
      AImages := GetImageList(Item.Enabled);
      AImageIndex := ImageIndex;
    end;
  end;
end;

function TdxCustomLayoutItemImageOptions.GetImageList(AEnabled: Boolean): TCustomImageList;
var
  ADisabledImages: TCustomImageList;
begin
  ADisabledImages := Item.Container.ILayout.GetDisabledImages;
  if AEnabled or not Assigned(ADisabledImages) then
    Result := Item.Container.ILayout.GetImages
  else
    Result := ADisabledImages;
end;

function TdxCustomLayoutItemImageOptions.GetImageSize: TSize;
var
  AGlyph: TBitmap;
  AImages: TCustomImageList;
  AImageIndex: Integer;
begin
  Result := cxNullSize;
  if GetCurrentImage(AGlyph, AImages, AImageIndex) then
    if AGlyph <> nil then
      Result := cxClasses.Size(AGlyph.Width, AGlyph.Height)
    else
      Result := cxClasses.Size(AImages.Width, AImages.Height);
end;

function TdxCustomLayoutItemImageOptions.IsImageAssigned: Boolean;
var
  AImage: TBitmap;
  AImages: TCustomImageList;
  AImageIndex: Integer;
begin
  Result := GetCurrentImage(AImage, AImages, AImageIndex);
end;

procedure TdxCustomLayoutItemImageOptions.SetGlyph(AValue: TBitmap);
begin
  FGlyph.Assign(AValue);
end;

procedure TdxCustomLayoutItemImageOptions.SetImageIndex(AValue: Integer);
begin
  if FImageIndex <> AValue then
  begin
    FImageIndex := AValue;
    Changed;
  end;
end;

procedure TdxCustomLayoutItemImageOptions.GlyphChanged(Sender: TObject);
begin
  Changed;
end;

{ TdxCustomLayoutItemCaptionOptions }

constructor TdxCustomLayoutItemCaptionOptions.Create(AItem: TdxCustomLayoutItem);
begin
  inherited;
  FImageOptions := TdxCustomLayoutItemImageOptions.Create(AItem);
  FShowAccelChar := True;
  FVisibleElements := [cveImage, cveText];
  FVisible := True;
end;

destructor TdxCustomLayoutItemCaptionOptions.Destroy;
begin
  FreeAndNil(FImageOptions);
  inherited Destroy;
end;

procedure TdxCustomLayoutItemCaptionOptions.Assign(Source: TPersistent);
begin
  if Source is TdxCustomLayoutItemCaptionOptions then
  begin
    BeginUpdate;
    try
      ImageOptions := TdxCustomLayoutItemCaptionOptions(Source).ImageOptions;
      VisibleElements := TdxCustomLayoutItemCaptionOptions(Source).VisibleElements;
      AlignHorz := TdxCustomLayoutItemCaptionOptions(Source).AlignHorz;
      AlignVert := TdxLayoutLabeledItemCaptionOptions(Source).AlignVert;
      Layout := TdxLayoutLabeledItemCaptionOptions(Source).Layout;      
      ShowAccelChar := TdxCustomLayoutItemCaptionOptions(Source).ShowAccelChar;
      Text := TdxCustomLayoutItemCaptionOptions(Source).Text;
      Visible := TdxCustomLayoutItemCaptionOptions(Source).Visible;
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;

function TdxCustomLayoutItemCaptionOptions.GetGlyph: TBitmap;
begin
  Result := ImageOptions.Glyph;
end;

function TdxCustomLayoutItemCaptionOptions.GetImageIndex: Integer;
begin
  Result := ImageOptions.ImageIndex;
end;

function TdxCustomLayoutItemCaptionOptions.GetText: string;
begin
  Result := FText;
end;

function TdxCustomLayoutItemCaptionOptions.IsTextStored: Boolean;
begin
  Result := FText <> '';
end;

procedure TdxCustomLayoutItemCaptionOptions.SetAlignHorz(Value: TAlignment);
begin
  if FAlignHorz <> Value then
  begin
    FAlignHorz := Value;
    Changed;
  end;
end;

procedure TdxCustomLayoutItemCaptionOptions.SetAlignVert(Value: TdxAlignmentVert);
begin
  if FAlignVert <> Value then
  begin
    FAlignVert := Value;
    Changed;
  end;
end;

procedure TdxCustomLayoutItemCaptionOptions.SetGlyph(AValue: TBitmap);
begin
  ImageOptions.Glyph := AValue;
end;

procedure TdxCustomLayoutItemCaptionOptions.SetImageIndex(AValue: Integer);
begin
  ImageOptions.ImageIndex := AValue;
end;

procedure TdxCustomLayoutItemCaptionOptions.SetImageOptions(Value: TdxCustomLayoutItemImageOptions);
begin
  FImageOptions.Assign(Value);
end;

procedure TdxCustomLayoutItemCaptionOptions.SetLayout(Value: TdxCaptionLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Changed;
  end;
end;

procedure TdxCustomLayoutItemCaptionOptions.SetShowAccelChar(Value: Boolean);
begin
  if FShowAccelChar <> Value then
  begin
    FShowAccelChar := Value;
    Changed;
  end;
end;

procedure TdxCustomLayoutItemCaptionOptions.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Item.ResetCachedTextHeight;
    Changed;
  end;
end;

procedure TdxCustomLayoutItemCaptionOptions.SetVisibleElements(Value: TdxLayoutItemCaptionVisibleElements);
begin
  if FVisibleElements <> Value then
  begin
    FVisibleElements := Value;
    Changed;
  end;
end;

procedure TdxCustomLayoutItemCaptionOptions.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TdxLayoutSizeOptions }

procedure TdxLayoutSizeOptions.Assign(Source: TPersistent);
begin
  if Source is TdxLayoutSizeOptions then
  begin
    BeginUpdate;
    try
      Height := TdxLayoutSizeOptions(Source).Height;
      Width := TdxLayoutSizeOptions(Source).Width;
      SizableHorz := TdxLayoutSizeOptions(Source).SizableHorz;
      SizableVert := TdxLayoutSizeOptions(Source).SizableVert;
      AssignedValues := TdxLayoutSizeOptions(Source).AssignedValues;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxLayoutSizeOptions.Changed;
begin
  Item.Changed(ictComplex);
end;

function TdxLayoutSizeOptions.GetSizableHorz: Boolean;
begin
  if (sovSizableHorz in AssignedValues) then
    Result := FSizableHorz
  else
    if Item.Container <> nil then
      Result := Item.Container.IsSizableHorz
    else
      Result := False;
end;

function TdxLayoutSizeOptions.GetSizableVert: Boolean;
begin
  if (sovSizableVert in AssignedValues) then
    Result := FSizableVert
  else
    if Item.Container <> nil then
      Result := Item.Container.IsSizableVert
    else
      Result := False;
end;

procedure TdxLayoutSizeOptions.SetAssignedValues(Value: TdxLayoutSizeOptionsValues);
var
  FPrevValues: TdxLayoutSizeOptionsValues;
begin
  if FAssignedValues <> Value then
  begin
    FPrevValues := FAssignedValues;
    FAssignedValues := Value;
    BeginUpdate;
    try
      FHeight := Height;
      FWidth := Width;
      FSizableHorz := SizableHorz;
      FSizableVert := SizableVert;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxLayoutSizeOptions.SetSizableHorz(Value: Boolean);
begin
  if FSizableHorz <> Value then
  begin
    FSizableHorz := Value;
    Include(FAssignedValues, sovSizableHorz);
    Changed;
  end;
end;

procedure TdxLayoutSizeOptions.SetSizableVert(Value: Boolean);
begin
  if FSizableVert <> Value then
  begin
    FSizableVert := Value;
    Include(FAssignedValues, sovSizableVert);
    Changed;
  end;
end;

procedure TdxLayoutSizeOptions.SetHeight(Value: Integer);
begin
  if (FHeight <> Value) and (Value >= 0) then
  begin
    FHeight := Value;
    Changed;
  end;
end;

procedure TdxLayoutSizeOptions.SetWidth(Value: Integer);
begin
  if (FWidth <> Value) and (Value >= 0) then
  begin
    FWidth := Value;
    Changed;
  end;
end;

function TdxLayoutSizeOptions.IsSizableHorzStored: Boolean;
begin
  Result := sovSizableHorz in FAssignedValues;
end;

function TdxLayoutSizeOptions.IsSizableVertStored: Boolean;
begin
  Result := sovSizableVert in FAssignedValues;
end;

{ TdxLayoutOffsets }

procedure TdxLayoutOffsets.Assign(Source: TPersistent);
begin
  if Source is TdxLayoutOffsets then
  begin
    BeginUpdate;
    try
      FLeft := TdxLayoutOffsets(Source).Left;
      FTop := TdxLayoutOffsets(Source).Top;
      FRight := TdxLayoutOffsets(Source).Right;
      FBottom := TdxLayoutOffsets(Source).Bottom;
    finally
      EndUpdate;
    end;
  end;
end;

function TdxLayoutOffsets.GetValue(Index: Integer): Integer;
begin
  case Index of
    1: Result := FBottom;
    2: Result := FLeft;
    3: Result := FRight;
    4: Result := FTop;
  else
    Result := 0;
  end;
end;

procedure TdxLayoutOffsets.SetValue(Index: Integer; Value: Integer);
begin
  if Value < 0 then Value := 0;
  if GetValue(Index) <> Value then
  begin
    case Index of
      1: FBottom := Value;
      2: FLeft := Value;
      3: FRight := Value;
      4: FTop := Value;
    end;
    Changed;
  end;
end;

{ TdxLayoutPadding }

procedure TdxLayoutPadding.Assign(Source: TPersistent);
begin
  BeginUpdate;
  try
    if Source is TdxLayoutPadding then
      with Source as TdxLayoutPadding do
        Self.AssignedValues := AssignedValues;
    inherited;
  finally
    EndUpdate;
  end;
end;

function TdxLayoutPadding.GetValue(Index: Integer): Integer;
begin
  if TdxLayoutPaddingAssignedValue(Index - 1) in AssignedValues then
    Result := inherited GetValue(Index)
  else
  case Index of
    1: Result := Item.GetOptions.Padding.Bottom;
    2: Result := Item.GetOptions.Padding.Left;
    3: Result := Item.GetOptions.Padding.Right;
    4: Result := Item.GetOptions.Padding.Top;
  else
    Result := 0;
  end;
end;

procedure TdxLayoutPadding.SetValue(Index: Integer; Value: Integer);
begin
  Include(FAssignedValues, TdxLayoutPaddingAssignedValue(Index - 1));
  inherited;
end;

function TdxLayoutPadding.IsValueStored(Index: Integer): Boolean;
begin
  Result := TdxLayoutPaddingAssignedValue(Index - 1) in AssignedValues;
end;

procedure TdxLayoutPadding.SetAssignedValues(Value: TdxLayoutPaddingAssignedValues);
begin
  if FAssignedValues <> Value then
  begin
    FAssignedValues := Value;
    Changed;
  end;
end;

type
  TdxLayoutBasicItemReader = class
  protected
    class procedure LoadCaption(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string); virtual;
  public
    class procedure LoadFromIni(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string); virtual;
  end;
  TdxLayoutBasicItemReader2 = class(TdxLayoutBasicItemReader)
  public
    class procedure LoadFromIni(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string); override;
  end;
  TdxLayoutBasicItemReader3 = class(TdxLayoutBasicItemReader2)
  protected
    class procedure LoadCaption(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string); override;
  public
    class procedure LoadFromIni(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string); override;
  end;
  TdxLayoutBasicItemReaderClass = class of TdxLayoutBasicItemReader;

  TdxLayoutGroupReader = class
  public
    class procedure LoadFromIni(AGroup: TdxLayoutGroup; AIniFile: TCustomIniFile; const ASection: string); virtual;
  end;
  TdxLayoutGroupReader2 = class(TdxLayoutGroupReader)
  public
    class procedure LoadFromIni(AGroup: TdxLayoutGroup; AIniFile: TCustomIniFile; const ASection: string); override;
  end;
  TdxLayoutGroupReader3 = class(TdxLayoutGroupReader2)
  public
    class procedure LoadFromIni(AGroup: TdxLayoutGroup; AIniFile: TCustomIniFile; const ASection: string); override;
  end;
  TdxLayoutGroupReaderClass = class of TdxLayoutGroupReader;

  TdxLayoutBasicItemWriter = class
  protected
    class procedure SaveCaption(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string); virtual;
  public
    class procedure SaveToIni(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string);
  end;

  TdxLayoutGroupWriter = class
  public
    class procedure SaveToIni(AGroup: TdxLayoutGroup; AIniFile: TCustomIniFile; const ASection: string);
  end;

{ TdxLayouItemsReader }

class procedure TdxLayoutBasicItemReader.LoadCaption(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string);
begin
  AItem.Caption := AIniFile.ReadString(ASection, 'Caption', AItem.Caption);
end;

class procedure TdxLayoutBasicItemReader3.LoadCaption(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string);
var
  ACaption: string;
begin
  ACaption := AIniFile.ReadString(ASection, 'Caption', AItem.Caption);
  if cxIsQuotedStr(ACaption) then
    AItem.Caption := cxDequotedStr(ACaption)
  else
    AItem.Caption := ACaption;
end;

class procedure TdxLayoutBasicItemReader.LoadFromIni(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string);
begin
  LoadCaption(AItem, AIniFile, ASection);
end;

class procedure TdxLayoutBasicItemReader2.LoadFromIni(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string);
begin
  inherited;
  AItem.AlignHorz := TdxLayoutAlignHorz(AIniFile.ReadInteger(ASection, 'AlignHorz', Integer(AItem.AlignHorz)));
  AItem.AlignVert := TdxLayoutAlignVert(AIniFile.ReadInteger(ASection, 'AlignVert', Integer(AItem.AlignVert)));
  AItem.Width := AIniFile.ReadInteger(ASection, 'Width', AItem.Width);
  AItem.Height := AIniFile.ReadInteger(ASection, 'Height', AItem.Height);

  AItem.CaptionOptions.AlignHorz := TAlignment(AIniFile.ReadInteger(ASection, 'CaptionAlignHorz', Integer(AItem.CaptionOptions.AlignHorz)));
  AItem.CaptionOptions.AlignVert := TdxAlignmentVert(AIniFile.ReadInteger(ASection, 'CaptionAlignVert', Integer(AItem.CaptionOptions.AlignVert)));
  AItem.CaptionOptions.Layout := TdxCaptionLayout(AIniFile.ReadInteger(ASection, 'CaptionLayout', Integer(AItem.CaptionOptions.Layout)));
end;

class procedure TdxLayoutBasicItemReader3.LoadFromIni(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string);
begin
  inherited;
  AItem.CaptionOptions.Visible := AIniFile.ReadBool(ASection, 'ShowCaption', AItem.CaptionOptions.Visible);
end;

class procedure TdxLayoutGroupReader.LoadFromIni(AGroup: TdxLayoutGroup; AIniFile: TCustomIniFile; const ASection: string);
begin
  AGroup.Hidden := AIniFile.ReadBool(ASection, 'Hidden', AGroup.Hidden);
  AGroup.LayoutDirection := TdxLayoutDirection(AIniFile.ReadInteger(ASection, 'LayoutDirection', Integer(AGroup.LayoutDirection)));
end;

class procedure TdxLayoutGroupReader2.LoadFromIni(AGroup: TdxLayoutGroup; AIniFile: TCustomIniFile; const ASection: string);
begin
  inherited;
  AGroup.ItemIndex := AIniFile.ReadInteger(ASection, 'ItemIndex', AGroup.ItemIndex);
  AGroup.Expanded := AIniFile.ReadBool(ASection, 'Expanded', AGroup.Expanded);
  AGroup.ShowBorder := AIniFile.ReadBool(ASection, 'ShowBorder', AGroup.ShowBorder);
end;

class procedure TdxLayoutGroupReader3.LoadFromIni(AGroup: TdxLayoutGroup; AIniFile: TCustomIniFile; const ASection: string);
begin
  inherited;
  AGroup.ButtonOptions.ShowExpandButton := AIniFile.ReadBool(ASection, 'ShowExpandButton', False);
end;

class procedure TdxLayoutBasicItemWriter.SaveCaption(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string);
begin
  AIniFile.WriteString(ASection, 'Caption', cxQuotedStr(AItem.Caption));
end;

class procedure TdxLayoutBasicItemWriter.SaveToIni(AItem: TdxCustomLayoutItem; AIniFile: TCustomIniFile; const ASection: string);

  function GetParentName: string;
  begin
    if AItem.Parent <> nil then
      Result := AItem.Parent.Name
    else
      Result := '';
  end;

begin
  SaveCaption(AItem, AIniFile, ASection);

  AIniFile.WriteString(ASection, 'Name', AItem.Name);
  AIniFile.WriteBool(ASection, 'IsUserDefined', AItem.IsUserDefined);
  AIniFile.WriteString(ASection, 'ParentName', GetParentName);
  AIniFile.WriteInteger(ASection, 'Index', AItem.Index);
  AIniFile.WriteInteger(ASection, 'AlignHorz', Integer(AItem.AlignHorz));
  AIniFile.WriteInteger(ASection, 'AlignVert', Integer(AItem.AlignVert));
  AIniFile.WriteInteger(ASection, 'Width', AItem.Width);
  AIniFile.WriteInteger(ASection, 'Height', AItem.Height);
  AIniFile.WriteInteger(ASection, 'ItemClassKind', AItem.GetItemClassKind);

  if (AItem.CaptionOptions is TdxLayoutLabeledItemCaptionOptions) or (AItem.CaptionOptions is TdxLayoutGroupCaptionOptions) then
  begin
    AIniFile.WriteBool(ASection, 'ShowCaption', AItem.CaptionOptions.Visible);
    AIniFile.WriteInteger(ASection, 'CaptionAlignHorz', Integer(AItem.CaptionOptions.AlignHorz));
    AIniFile.WriteInteger(ASection, 'CaptionAlignVert', Integer(AItem.CaptionOptions.AlignVert));
    AIniFile.WriteInteger(ASection, 'CaptionLayout', Integer(AItem.CaptionOptions.Layout));
  end;
end;

class procedure TdxLayoutGroupWriter.SaveToIni(AGroup: TdxLayoutGroup; AIniFile: TCustomIniFile; const ASection: string);
begin
  AIniFile.WriteBool(ASection, 'Hidden', AGroup.Hidden);
  AIniFile.WriteInteger(ASection, 'LayoutDirection', Integer(AGroup.LayoutDirection));
  AIniFile.WriteInteger(ASection, 'ItemIndex', AGroup.ItemIndex);
  AIniFile.WriteBool(ASection, 'Expanded', AGroup.Expanded);
  AIniFile.WriteBool(ASection, 'ShowBorder', AGroup.ShowBorder);
  AIniFile.WriteBool(ASection, 'ShowExpandButton', AGroup.ButtonOptions.ShowExpandButton);
end;

{ TdxCustomLayoutItem }

constructor TdxCustomLayoutItem.Create(AOwner: TComponent);
begin
  inherited;
  CreateOptions;
  FIsUserDefined := True;
  FAllowRemove := True;
  FAlignHorz := ahParentManaged;
  FAlignVert := avParentManaged;
  FEnabled := True;
  FOffsets := TdxLayoutOffsets.Create(Self);
  FPadding := TdxLayoutPadding.Create(Self);
  FVisible := True;
  FLoadedIndex := -2;
end;

procedure TdxCustomLayoutItem.BeforeDestruction;
begin
  Container.BeginUpdate;
  Customization := False;
  inherited BeforeDestruction;
  Container.FinishDragAndDrop(False);
  AlignmentConstraint := nil;
end;

destructor TdxCustomLayoutItem.Destroy;
var
  AContainer: TdxLayoutContainer;
begin
  LayoutLookAndFeel := nil;
  FreeAndNil(FPadding);
  FreeAndNil(FOffsets);
  DestroyOptions;
  AContainer := Container;
  if Parent <> nil then
    Parent.ExtractItem(Self);
  cxClearObjectLinks(Self);
  inherited Destroy;
  AContainer.EndUpdate;
end;

procedure TdxCustomLayoutItem.Assign(Source: TPersistent);
begin
  if Source is TdxCustomLayoutItem then
  begin
    AlignHorz := TdxCustomLayoutItem(Source).AlignHorz;
    AlignVert := TdxCustomLayoutItem(Source).AlignVert;
    AlignmentConstraint := TdxCustomLayoutItem(Source).AlignmentConstraint;
    AllowRemove := TdxCustomLayoutItem(Source).AllowRemove;
    CaptionOptions := TdxCustomLayoutItem(Source).CaptionOptions;
    Enabled := TdxCustomLayoutItem(Source).Enabled;
    LayoutLookAndFeel := TdxCustomLayoutItem(Source).LayoutLookAndFeel;
    Offsets := TdxCustomLayoutItem(Source).Offsets;
    Visible := TdxCustomLayoutItem(Source).Visible;
    SizeOptions := TdxCustomLayoutItem(Source).SizeOptions;
    Index := TdxCustomLayoutItem(Source).Index;
    FIsUserDefined := (IsDesigning xor TdxCustomLayoutItem(Source).IsDesigning) or TdxCustomLayoutItem(Source).IsUserDefined;
  end
  else
    inherited;
end;

function TdxCustomLayoutItem.GetRealAlignHorz: TdxLayoutAlignHorz;
begin
  if AlignHorz = ahParentManaged then
    Result := GetParentManagedAlignHorz
  else
    Result := AlignHorz;
end;

function TdxCustomLayoutItem.GetRealAlignVert: TdxLayoutAlignVert;
begin
  if AlignVert = avParentManaged then
    Result := GetParentManagedAlignVert
  else
    Result := AlignVert;
end;

function TdxCustomLayoutItem.GetActuallyVisible: Boolean;
begin
  Result := (ViewInfo <> nil) and ViewInfo.ActuallyVisible;
end;

function TdxCustomLayoutItem.GetAlignHorz: TdxLayoutAlignHorz;
begin
  Result := FAlignHorz;
end;

function TdxCustomLayoutItem.GetAlignVert: TdxLayoutAlignVert;
begin
  Result := FAlignVert;
end;

function TdxCustomLayoutItem.GetCaption: string;
begin
  Result := CaptionOptions.Text;
end;

function TdxCustomLayoutItem.GetAutoAligns: TdxLayoutAutoAligns;
begin
  Result := [];
  if AlignHorz = ahParentManaged then
    Include(Result, aaHorizontal);
  if AlignVert = avParentManaged then
    Include(Result, aaVertical);
end;

function TdxCustomLayoutItem.GetCaptionForCustomizeForm: string;
begin
  if (csDesigning in ComponentState) or (Caption = '') then
    Result := Name
  else
    Result := StripHotKey(Caption);
end;

function TdxCustomLayoutItem.GetEnabled: Boolean;
begin
  if not (liavEnabled in FAssignedValues) and (Parent <> nil) then
    Result := Parent.Enabled
  else
    Result := FEnabled;
end;

function TdxCustomLayoutItem.GetIndex: Integer;
begin
  if FParent = nil then
    Result := -1
  else
    Result := FParent.IndexOf(Self);
end;

function TdxCustomLayoutItem.IsAvailable: Boolean;
begin
  Result := not IsRoot and ((Parent = nil) or Parent.IsAvailable); 
end;

function TdxCustomLayoutItem.IsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TdxCustomLayoutItem.IsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TdxCustomLayoutItem.IsDragged: Boolean;
{
var
  ADragObject: TdxLayoutDragAndDropObject;
begin
  Result := Container.DragAndDropState <> ddsNone;
  if Result then
  begin
    ADragObject := Container.DragAndDropObject as TdxLayoutControlDragAndDropObject;
    Result := ADragObject.SourceItem = Self;
  end;
}
begin
  Result := (dxLayoutDragAndDropObject <> nil) and (dxLayoutDragAndDropObject.SourceItem = Self);
end;

function TdxCustomLayoutItem.IsImageVisible: Boolean;
begin
  Result := (cveImage in CaptionOptions.VisibleElements) and CaptionOptions.ImageOptions.IsImageAssigned;
end;

function TdxCustomLayoutItem.IsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

function TdxCustomLayoutItem.IsSelected: Boolean;
begin
  Result := Container.IsComponentSelected(Self);
end;

function TdxCustomLayoutItem.IsTextVisible: Boolean;
begin
  Result := (cveText in CaptionOptions.VisibleElements) and (Caption <> '')
end;

function TdxCustomLayoutItem.IsVisibleForCustomization: Boolean;
begin
  Result := IsDesigning or (Parent = nil) or not IsParentLocked or Container.ILayout.GetShowLockedGroupChildren;
end;

function TdxCustomLayoutItem.GetIsRoot: Boolean;
begin
  Result := (Container <> nil) and Container.IsRoot(Self);
end;

function TdxCustomLayoutItem.GetViewInfo: TdxCustomLayoutItemViewInfo;
begin
  if Container.ViewInfo <> nil then
    Result := Container.ViewInfo.FindItemViewInfo(Self)
  else
    Result := nil;
end;

function TdxCustomLayoutItem.GetVisibleIndex: Integer;
begin
  if FParent = nil then
    Result := -1
  else
    Result := FParent.VisibleIndexOf(Self);
end;

procedure TdxCustomLayoutItem.SetAlignHorz(Value: TdxLayoutAlignHorz);
begin
  if AlignHorz <> Value then
  begin
    FAlignHorz := Value;
    Changed;
  end;
end;

procedure TdxCustomLayoutItem.SetAlignmentConstraint(Value: TdxLayoutAlignmentConstraint);
begin
  if FAlignmentConstraint <> Value then
  begin
    BeginUpdate;
    try
      if FAlignmentConstraint <> nil then
        FAlignmentConstraint.InternalRemoveItem(Self);
      FAlignmentConstraint := Value;
      if FAlignmentConstraint <> nil then
        FAlignmentConstraint.InternalAddItem(Self);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxCustomLayoutItem.SetAlignVert(Value: TdxLayoutAlignVert);
begin
  if AlignVert <> Value then
  begin
    FAlignVert := Value;
    Changed;
  end;
end;

procedure TdxCustomLayoutItem.SetAutoAligns(Value: TdxLayoutAutoAligns);

  function GetLoadedAlignHorz: TdxLayoutAlignHorz;
  begin
    if AlignHorz = ahParentManaged then
      Result := ahLeft
    else
      Result := AlignHorz;
  end;

  function GetLoadedAlignVert: TdxLayoutAlignVert;
  begin
    if AlignVert = avParentManaged then
      Result := avTop
    else
      Result := AlignVert;
  end;

begin
  if AutoAligns <> Value then
  begin
    BeginUpdate;
    try
      if aaHorizontal in Value then
        AlignHorz := ahParentManaged
      else
        AlignHorz := GetLoadedAlignHorz;
      if aaVertical in Value then
        AlignVert := avParentManaged
      else
        AlignVert := GetLoadedAlignVert;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxCustomLayoutItem.SetCaption(const Value: string);
begin
  CaptionOptions.Text := Value;
end;

procedure TdxCustomLayoutItem.SetCaptionOptions(
  const Value: TdxCustomLayoutItemCaptionOptions);
begin
  FCaptionOptions.Assign(Value);
end;

procedure TdxCustomLayoutItem.SetContainer(Value: TdxLayoutContainer);
begin
  if Container <> Value then
  begin
    if not IsRoot and (Container <> nil) then
      FContainer.ExtractAbsoluteItem(Self);
    FContainer := Value;
    if not IsRoot then
    begin
      if Container <> nil then
        FContainer.AddAbsoluteItem(Self);
      if Self.Name = '' then
        SetComponentName(Self, GetBaseName, IsDesigning, IsLoading);
    end
    else
      Name := GetValidName(Self, GetBaseName + '_Root');
    ContainerChanged;
  end;
end;

procedure TdxCustomLayoutItem.SetCustomization(Value: Boolean);
begin
  if FCustomization <> Value then
  begin
    FCustomization := Value;
    CustomizationChanged;
  end;
end;

procedure TdxCustomLayoutItem.SetEnabled(Value: Boolean);
begin
  if Enabled <> Value then
  begin
    FEnabled := Value;
    if FEnabled then
      Exclude(FAssignedValues, liavEnabled)
    else
      Include(FAssignedValues, liavEnabled);
    EnabledChanged;
  end;
end;

procedure TdxCustomLayoutItem.SetLayoutLookAndFeel(Value: TdxCustomLayoutLookAndFeel);
begin
  if FLayoutLookAndFeel <> Value then
  begin
    if FLayoutLookAndFeel <> nil then
      FLayoutLookAndFeel.RemoveUser(Self);
    FLayoutLookAndFeel := Value;
    if FLayoutLookAndFeel <> nil then
      FLayoutLookAndFeel.AddUser(Self);
    LayoutLookAndFeelUserChanged;
  end;
end;

procedure TdxCustomLayoutItem.SetIndex(Value: Integer);
begin
  if FParent <> nil then
    FParent.ChangeItemIndex(Self, Value);
end;

procedure TdxCustomLayoutItem.SetParent(Value: TdxLayoutGroup);
var
  APrevParent: TdxLayoutGroup;
begin
  if (FParent <> Value) and CanMoveTo(Value) then
  begin
    APrevParent := FParent;
    if FParent <> nil then
      FParent.ExtractItem(Self)
    else
      if Container <> nil then
        Container.ExtractAvailableItem(Self);
    if Value <> nil then
      Value.AddItem(Self)
    else
      if (APrevParent <> nil) and not APrevParent.IsDestroying then
        Container.AddAvailableItem(Self);
    Changed;
  end;
end;

procedure TdxCustomLayoutItem.SetShowCaption(Value: Boolean);
begin
  CaptionOptions.Visible := Value;
end;

procedure TdxCustomLayoutItem.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TdxCustomLayoutItem.SetVisibleIndex(Value: Integer);
begin
  if FParent <> nil then
    FParent.ChangeItemVisibleIndex(Self, Value);
end;

procedure TdxCustomLayoutItem.SetSizeOptions(Value: TdxLayoutSizeOptions);
begin
  FSizeOptions.Assign(Value);
end;

function TdxCustomLayoutItem.GetHeight: Integer;
begin
  Result := SizeOptions.Height;
end;

function TdxCustomLayoutItem.GetWidth: Integer;
begin
  Result := SizeOptions.Width;
end;

procedure TdxCustomLayoutItem.SetHeight(Value: Integer);
begin
  SizeOptions.Height := Value;
end;

procedure TdxCustomLayoutItem.SetWidth(Value: Integer);
begin
  SizeOptions.Width := Value;
end;

procedure TdxCustomLayoutItem.ReadIndex(Reader: TReader);
begin
  FLoadedIndex := Reader.ReadInteger;
end;

procedure TdxCustomLayoutItem.WriteIndex(Writer: TWriter);
begin
  Writer.WriteInteger(Index);
end;

function TdxCustomLayoutItem.IsAlignHorzStored: Boolean;
begin
  Result := IsRoot or (AlignHorz <> ahParentManaged);
end;

function TdxCustomLayoutItem.IsAlignVertStored: Boolean;
begin
  Result := IsRoot or (AlignVert <> avParentManaged);
end;

function TdxCustomLayoutItem.IsEnabledStored: Boolean;
begin
  Result := liavEnabled in FAssignedValues; 
end;

procedure TdxCustomLayoutItem.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Index', ReadIndex, WriteIndex, True);
end;

procedure TdxCustomLayoutItem.Loaded;
begin
  inherited Loaded;
  FIsUserDefined := False;
end;

procedure TdxCustomLayoutItem.SetName(const Value: TComponentName);
begin
  inherited;
  if IsDesigning then
    DoItemChanged;
end;

procedure TdxCustomLayoutItem.SetOffsets(const Value: TdxLayoutOffsets);
begin
  FOffsets.Assign(Value);
end;

procedure TdxCustomLayoutItem.SetPadding(const Value: TdxLayoutPadding);
begin
  FPadding.Assign(Value);
end;

procedure TdxCustomLayoutItem.SetParentComponent(Value: TComponent);
var
  AIntf: IdxLayoutItemsHelper;
begin
  inherited;
  if Value is TdxLayoutGroup then
    Parent := TdxLayoutGroup(Value)
  else
    if Supports(Value, IdxLayoutItemsHelper, AIntf) then
      AIntf.AddAvailableItem(Self);
end;

procedure TdxCustomLayoutItem.CustomizationChanged;
begin
// do nothing
end;

procedure TdxCustomLayoutItem.LayoutLookAndFeelChanged;
begin
// do nothing
end;

procedure TdxCustomLayoutItem.LayoutLookAndFeelChanging;
begin
  ResetCachedTextHeight;
end;

procedure TdxCustomLayoutItem.BeginLayoutLookAndFeelUserDestroying;
begin
  BeginUpdate;
end;

procedure TdxCustomLayoutItem.EndLayoutLookAndFeelUserDestroying;
begin
  EndUpdate;
end;

procedure TdxCustomLayoutItem.LayoutLookAndFeelUserChanged;
begin
  if IsDestroying or IsLoading then Exit;
  LayoutLookAndFeelChanging;
  Changed;
  LayoutLookAndFeelChanged;
end;

procedure TdxCustomLayoutItem.LayoutLookAndFeelUserDestroyed;
begin
  LayoutLookAndFeel := nil;
end;

function TdxCustomLayoutItem.CanBeAlone: Boolean;
begin
  Result := True;
end;

function TdxCustomLayoutItem.CanDragAndDrop: Boolean;
begin
  Result := not IsRoot and not IsParentLocked;
end;

function TdxCustomLayoutItem.CanProcessAccel(out AItem: TdxCustomLayoutItem): Boolean;
begin
  Result := False;
end;

function TdxCustomLayoutItem.CanRemove: Boolean;
begin
  Result := FAllowRemove;
end;

function TdxCustomLayoutItem.CanResizeHorz: Boolean;
begin
  Result := not IsRoot and not IsParentLocked and SizeOptions.SizableHorz;
end;

function TdxCustomLayoutItem.CanResizeVert: Boolean;
begin
  Result := not IsRoot and not IsParentLocked and SizeOptions.SizableVert;
end;

procedure TdxCustomLayoutItem.ContainerChanged;
begin
// do nothing
end;

procedure TdxCustomLayoutItem.DoCaptionDown;
begin
// do nothing
end;

procedure TdxCustomLayoutItem.DoCaptionClick;
begin
  CallNotify(FOnCaptionClick, Self);
end;

procedure TdxCustomLayoutItem.DoPack;
begin
// do nothing
end;

function TdxCustomLayoutItem.DoProcessAccel: Boolean;
var
  AItem: TdxCustomLayoutItem;
begin
  Result := CanProcessAccel(AItem);
  if Result then
    AItem.ProcessAccel;
end;

procedure TdxCustomLayoutItem.EnabledChanged;
begin
  ParentChanged(ictMedium);
end;

procedure TdxCustomLayoutItem.CreateOptions;
begin
  FCaptionOptions := GetCaptionOptionsClass.Create(Self);
  FSizeOptions := TdxLayoutSizeOptions.Create(Self);
end;

procedure TdxCustomLayoutItem.DestroyOptions;
begin
  FreeAndNil(FSizeOptions);
  FreeAndNil(FCaptionOptions);
end;

function TdxCustomLayoutItem.GetParentManagedAlignHorz: TdxLayoutAlignHorz;
begin
  Result := GetParentHelperClass.GetChildItemsAlignHorz;
end;

function TdxCustomLayoutItem.GetParentManagedAlignVert: TdxLayoutAlignVert;
begin
  Result := GetParentHelperClass.GetChildItemsAlignVert;
end;

function TdxCustomLayoutItem.GetBaseName: string;
begin
  Result := Container.ILayout.GetItemsParentComponent.Name;
end;

function TdxCustomLayoutItem.GetCursor(X, Y: Integer): TCursor;
begin
  if ViewInfo <> nil then
    Result := ViewInfo.GetCursor(X, Y)
  else
    Result := crDefault;
end;

function TdxCustomLayoutItem.IsLocked: Boolean;
begin
  Result := IsParentLocked;
end;

function TdxCustomLayoutItem.IsParentLocked: Boolean;
begin
  Result := not IsDesigning and Container.IsCustomization and
    (Parent <> nil) and (Parent.Locked or Parent.IsParentLocked);
end;

class function TdxCustomLayoutItem.GetItemClassKind: Integer;
begin
  Result := -1;
end;

function TdxCustomLayoutItem.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := FLayoutLookAndFeel;
  if Result = nil then
    if FParent <> nil then
      Result := FParent.GetChildLayoutLookAndFeel
    else
      Result := Container.GetLookAndFeel;
end;

function TdxCustomLayoutItem.GetParentHelperClass: TdxLayoutGroupHelperClass;
begin
  if Parent <> nil then
    Result := Parent.GetHelperClass
  else
    Result := TdxLayoutGroupHelper;
end;

procedure TdxCustomLayoutItem.LoadFromIni(AIniFile: TCustomIniFile; const ASection: string; AVersion: Integer);
var
  AReader: TdxLayoutBasicItemReaderClass;
begin
  case AVersion of
    3: AReader := TdxLayoutBasicItemReader3;
    2: AReader := TdxLayoutBasicItemReader2;
  else
    AReader := TdxLayoutBasicItemReader;
  end;

  AReader.LoadFromIni(Self, AIniFile, ASection);
end;

procedure TdxCustomLayoutItem.SaveToIni(AIniFile: TCustomIniFile; const ASection: string);
begin
  TdxLayoutBasicItemWriter.SaveToIni(Self, AIniFile, ASection);
end;

function TdxCustomLayoutItem.Focused: Boolean;
begin
  Result := False;
end;

procedure TdxCustomLayoutItem.DoItemChanged;
begin
  Container.DoItemChanged(Self);
end;

function TdxCustomLayoutItem.GetShowCaption: Boolean;
begin
  Result := CaptionOptions.Visible;
end;

function TdxCustomLayoutItem.GetVisible: Boolean;
begin
  Result := (FVisible or IsDesigning) and
    ((Parent = nil) or Parent.AllowShowChild(Self));
end;

function TdxCustomLayoutItem.HasControl: Boolean;
begin
  Result := False;
end;

procedure TdxCustomLayoutItem.BeforeCalculateViewInfo;
begin
// do nothing
end;

procedure TdxCustomLayoutItem.AfterCalculateViewInfo;
begin
// do nothing
end;

procedure TdxCustomLayoutItem.ApplyCalculatedChanges;
begin
// do nothing
end;

procedure TdxCustomLayoutItem.CheckIndex;
begin
// do nothing
end;

procedure TdxCustomLayoutItem.PopulateItems(AList: TList);
begin
  AList.Add(Self);
end;

function TdxCustomLayoutItem.IsExpanded: Boolean;
begin
  Result := True;
end;

function TdxCustomLayoutItem.IsParentGroup(AParentGroup: TdxLayoutGroup): Boolean;
begin
  Result := AParentGroup.IsChildItem(Self);
end;

function TdxCustomLayoutItem.IsChildItem(AChildItem: TdxCustomLayoutItem): Boolean;
begin
  while (AChildItem <> nil) and (AChildItem <> Self) do
    AChildItem := AChildItem.Parent;
  Result := AChildItem = Self;
end;

function TdxCustomLayoutItem.HasCaption: Boolean;
begin
  Result := ShowCaption and (IsTextVisible or IsImageVisible);
end;

procedure TdxCustomLayoutItem.DoGetTabOrderList(List: TList);
begin
// do nothing
end;

procedure TdxCustomLayoutItem.GetTabOrderList(List: TList);
begin
  if ActuallyVisible then
    DoGetTabOrderList(List);
end;

function TdxCustomLayoutItem.GetInplaceRenameCaption: string;
begin
  Result := Caption;
end;

procedure TdxCustomLayoutItem.SetInplaceRenameCaption(const ACaption: string);
begin
  if Caption <> ACaption then
  begin
    Container.UndoRedoManager.SaveLayout;
    Caption := ACaption;
  end;
end;

function TdxCustomLayoutItem.CanInit: Boolean;
begin
  Result := not (IsLoading or Container.IsLayoutLoading);
end;

procedure TdxCustomLayoutItem.DoInit;
begin
  if GetLayoutLookAndFeel <> nil then
    LayoutLookAndFeelChanging;
end;

procedure TdxCustomLayoutItem.Init;
begin
  if CanInit then
    DoInit;
end;

procedure TdxCustomLayoutItem.KeyDown(var Key: Word; Shift: TShiftState);
begin
  ViewInfo.KeyDown(Key, Shift);
end;

procedure TdxCustomLayoutItem.ProcessAccel;
begin
end;

function TdxCustomLayoutItem.ProcessDialogChar(ACharCode: Word): Boolean;
begin
  Result := HasCaption and FCaptionOptions.ShowAccelChar and
    IsAccel(ACharCode, Caption) and DoProcessAccel;
end;

function TdxCustomLayoutItem.ProcessDialogKey(ACharCode: Word; AKeyData: Integer; AFocusedItem: TdxLayoutItem): Boolean;
begin
  Result := False;
end;

procedure TdxCustomLayoutItem.RestoreItemControlSize;
begin
// do nothing
end;

class function TdxCustomLayoutItem.GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass;
begin
  Result := TdxCustomLayoutItemCaptionOptions;
end;

procedure TdxCustomLayoutItem.ResetCachedTextHeight;
begin
  FCachedTextHeight := 0;
end;

//IdxLayoutSelectableItem
function TdxCustomLayoutItem.CanDelete: Boolean;
begin
  Result := (IsDesigning and not (csAncestor in ComponentState)) or IsUserDefined;
end;

function TdxCustomLayoutItem.IsOwner(AOwner: TComponent): Boolean;
begin
  Result := AOwner = Container;
end;

procedure TdxCustomLayoutItem.SelectComponent(AShift: TShiftState = []);
begin
  Container.SelectComponent(Self, AShift);
end;

procedure TdxCustomLayoutItem.SelectParent;
begin
  Container.SelectComponent(GetParentComponent);
end;

procedure TdxCustomLayoutItem.SelectionChanged;
begin
// do nothing
end;

function TdxCustomLayoutItem.IsSelectableItemVisible: Boolean;
begin
  Result := ActuallyVisible;
end;

procedure TdxCustomLayoutItem.SelectableItemMakeVisible;
begin
  MakeVisible;
end;

function TdxCustomLayoutItem.GetParentComponent: TComponent;
begin
  if FParent = nil then
    Result := Container.ILayout.GetItemsParentComponent
  else
    Result := FParent;
end;

function TdxCustomLayoutItem.HasParent: Boolean;
begin
  Result := True;
end;

procedure TdxCustomLayoutItem.BeginUpdate;
begin
  Container.BeginUpdate;
end;

procedure TdxCustomLayoutItem.CancelUpdate;
begin
  Container.CancelUpdate;
end;

procedure TdxCustomLayoutItem.EndUpdate(ANeedPack: Boolean = True);
begin
  Container.EndUpdate(ANeedPack);
end;

procedure TdxCustomLayoutItem.Changed(AType: TdxLayoutItemChangeType);
begin
  if IsDestroying or (Container = nil) or Container.IsLoading or Container.IsDestroying or Container.IsUpdateLocked then Exit;
  DoChanged(AType);
end;

procedure TdxCustomLayoutItem.DoChanged(AType: TdxLayoutItemChangeType);

  procedure ComplexLayoutChanged(AItem: TdxCustomLayoutItem);

    function GetPrevBounds(AGroup: TdxLayoutGroup): TRects;
    var
      ALength: Integer;
    begin
      ALength := 0;
      while AGroup <> nil do
      begin
        Inc(ALength);
        SetLength(Result, ALength);
        Result[ALength-1] := AGroup.ViewInfo.Bounds;
        AGroup := AGroup.Parent;
      end;
    end;

    function GetChangedGroup(AGroup: TdxLayoutGroup; APrevBounds: TRects): TdxLayoutGroup;
    var
      I: Integer;
    begin
      I := 0;
      repeat
        Result := AGroup;
        if cxRectIsEqual(APrevBounds[I], AGroup.ViewInfo.Bounds) then
          Break;
        Inc(I);
        AGroup := AGroup.Parent;
      until AGroup = nil;
    end;

  var
    APrevBounds: TRects;
    AChangedGroup: TdxLayoutGroup;
  begin
    APrevBounds := nil;
    if (AItem.Parent <> nil) and (AItem.ViewInfo <> nil) then
    begin
      APrevBounds := GetPrevBounds(AItem.Parent);
      BeginUpdate;
      Container.BeginPlaceControls;
      try
        Container.DoCalculateRoot(False);
      finally
        Container.CancelPlaceControls;
        CancelUpdate;
      end;

      AChangedGroup := GetChangedGroup(AItem.Parent, APrevBounds);
      if AChangedGroup.IsRoot then
        Container.LayoutChanged(False)
      else
      begin
        Container.PlaceControls(AChangedGroup.ViewInfo);
        Container.InvalidateRect(AChangedGroup.ViewInfo.ClientBounds, False);
        Container.PostBuildSelectionLayer;
      end;
    end;
  end;

  procedure MediumLayoutChanged(AItem: TdxCustomLayoutItem);
  var
    AViewInfo: TdxCustomLayoutItemViewInfo;
  begin
    AViewInfo := AItem.ViewInfo;
    if AViewInfo <> nil then
    begin
      BeginUpdate;
      try
        BeforeCalculateViewInfo;
        AViewInfo.Calculate(AViewInfo.OriginalBounds);
        AfterCalculateViewInfo;
      finally
        CancelUpdate;
      end;
      ApplyCalculatedChanges;

      Container.InvalidateRect(AViewInfo.OriginalBounds, False);
      Container.PostBuildSelectionLayer;
    end;
  end;

  procedure LightLayoutChanged(AItem: TdxCustomLayoutItem);
  begin
    if AItem.ViewInfo <> nil then
      Container.InvalidateRect(AItem.ViewInfo.Bounds, False);
  end;

begin
  case AType of
    ictHard: Container.LayoutChanged(False);
    ictMedium: MediumLayoutChanged(Self);
    ictLight: LightLayoutChanged(Self);
    ictComplex: ComplexLayoutChanged(Self);
  end;
  DoItemChanged;
end;

procedure TdxCustomLayoutItem.ParentChanged(AType: TdxLayoutItemChangeType);
begin
  if Parent <> nil then
    Parent.Changed(AType)
  else
    Changed(AType);
end;

function TdxCustomLayoutItem.CanFocus: Boolean;
begin
  Result := False;
end;

function TdxCustomLayoutItem.IsFocused: Boolean;
begin
  Result := Container.FocusedController.IsFocused(Self);
end;

function TdxCustomLayoutItem.CanMoveTo(AParent: TdxCustomLayoutItem): Boolean;
begin
  Result := AParent <> Self;
end;

procedure TdxCustomLayoutItem.MakeVisible;
begin
  Container.MakeVisible(Self);
end;

function TdxCustomLayoutItem.Move(AParent: TdxLayoutGroup; AIndex: Integer;
  APack: Boolean = False): Boolean;
var
  ASourceContainer, ADestinationContainer: TdxLayoutContainer;
begin
  Result := CanMoveTo(AParent) and (APack or (AParent <> Parent) or (Index <> AIndex));
  if not Result then Exit;
  ASourceContainer := Container;
  if AParent = nil then
    ADestinationContainer := Container
  else
    ADestinationContainer := AParent.Container;
  ADestinationContainer.BeginUpdate;
  ASourceContainer.BeginUpdate;
  try
    Parent := AParent;
    Index := AIndex;
  finally
    ASourceContainer.EndUpdate(APack);
    ADestinationContainer.EndUpdate(APack);
  end;
end;

function TdxCustomLayoutItem.MoveTo(AParent: TdxLayoutGroup; AVisibleIndex: Integer;
  APack: Boolean = False): Boolean;
var
  AIndex: Integer;
begin
  if AParent = nil then
    AIndex := -1
  else
    AIndex := AParent.GetItemIndex(AVisibleIndex);
  Result := Move(AParent, AIndex, APack);
end;

procedure TdxCustomLayoutItem.Pack;
var
  AContainer: TdxLayoutContainer;
begin
  AContainer := Container;
  AContainer.BeginUpdate;
  try
    DoPack;
  finally
    AContainer.EndUpdate(False);
  end;
end;

function TdxCustomLayoutItem.PutIntoHiddenGroup(ALayoutDirection: TdxLayoutDirection): TdxLayoutGroup;
var
  AIndex: Integer;
begin
  if FParent = nil then
    Result := nil
  else
  begin
    AIndex := Index;
    Result := Container.GetNewHiddenGroup;
    Result.Parent := Parent;
    Result.LayoutDirection := ALayoutDirection;
    case ALayoutDirection of
      ldHorizontal: Result.AlignVert := AlignVert;
      ldVertical: Result.AlignHorz := AlignHorz;
    end;
    Result.Index := AIndex;

    Move(Result, 0);
  end;
end;

procedure TdxCustomLayoutItem.ToggleHotTrackState;
begin
  Container.ToggleHotTrackState(Self);
end;

{ TdxLayoutBasicItem }

function TdxLayoutBasicItem.GetViewInfoClass: TdxCustomLayoutItemViewInfoClass;
begin
  Result := TdxLayoutBasicItemViewInfo;
end;

{ TdxLayoutEmptySpaceItem }

function TdxLayoutEmptySpaceItem.GetBaseName: string;
begin
  Result := inherited GetBaseName + 'SpaceItem';
end;

class function TdxLayoutEmptySpaceItem.GetItemClassKind: Integer;
begin
  Result := 2;
end;

function TdxLayoutEmptySpaceItem.GetViewInfoClass: TdxCustomLayoutItemViewInfoClass;
begin
  Result := TdxLayoutEmptySpaceItemViewInfo;
end;

function TdxLayoutEmptySpaceItem.CanBeAlone: Boolean;
begin
  Result := False;
end;

{ TdxLayoutNonResizeItem }

constructor TdxLayoutDirectionalItem.Create(AOwner: TComponent);
begin
  inherited;
  SizeOptions.FAssignedValues := [sovSizableHorz, sovSizableVert]; 
end;

function TdxLayoutDirectionalItem.GetViewInfoClass: TdxCustomLayoutItemViewInfoClass;
begin
  Result := TdxLayoutDirectionalItemViewInfo;
end;

function TdxLayoutDirectionalItem.CanBeAlone: Boolean;
begin
  Result := False;
end;

function TdxLayoutDirectionalItem.GetOptions: TdxCustomLayoutLookAndFeelOptions;
begin
  Result := GetLayoutLookAndFeel.ItemOptions;
end;

function TdxLayoutDirectionalItem.GetIsVertical: Boolean;
begin
  Result := (Parent = nil) or (Parent.LayoutDirection = ldHorizontal);
end;

{ TdxLayoutSeparatorItem }

function TdxLayoutSeparatorItem.GetBaseName: string;
begin
  Result := inherited GetBaseName + 'SeparatorItem';
end;

class function TdxLayoutSeparatorItem.GetItemClassKind: Integer;
begin
  Result := 3;
end;

function TdxLayoutSeparatorItem.GetViewInfoClass: TdxCustomLayoutItemViewInfoClass;
begin
  Result := TdxLayoutSeparatorItemViewInfo;
end;

{ TdxLayoutSplitterItem }

function TdxLayoutSplitterItem.GetBaseName: string;
begin
  Result := inherited GetBaseName + 'SplitterItem';
end;

class function TdxLayoutSplitterItem.GetItemClassKind: Integer;
begin
  Result := 4;
end;

function TdxLayoutSplitterItem.GetViewInfoClass: TdxCustomLayoutItemViewInfoClass;
begin
  Result := TdxLayoutSplitterItemViewInfo;
end;

{ TdxLayoutLabeledItemCaptionOptions }

constructor TdxLayoutLabeledItemCaptionOptions.Create(AItem: TdxCustomLayoutItem);
begin
  inherited;
  AlignVert := tavCenter;
  FCursor := crDefault;
end;

procedure TdxLayoutLabeledItemCaptionOptions.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TdxLayoutLabeledItemCaptionOptions then
  begin
    BeginUpdate;
    try
      Width := TdxLayoutLabeledItemCaptionOptions(Source).Width;
      Cursor := TdxLayoutLabeledItemCaptionOptions(Source).Cursor;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxLayoutLabeledItemCaptionOptions.SetWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FWidth <> Value then
  begin
    FWidth := Value;
    Item.ResetCachedTextHeight;
    Changed;
  end;
end;

{ TdxLayoutCustomLabeledItem }

function TdxLayoutCustomLabeledItem.GetParentManagedAlignVert: TdxLayoutAlignVert;
begin
  Result := avTop;
end;

class function TdxLayoutCustomLabeledItem.GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass;
begin
  Result := TdxLayoutLabeledItemCaptionOptions;
end;

function TdxLayoutCustomLabeledItem.GetOptions: TdxCustomLayoutLookAndFeelOptions;
begin
  Result := GetLayoutLookAndFeel.ItemOptions;
end;

function TdxLayoutCustomLabeledItem.GetViewInfoClass: TdxCustomLayoutItemViewInfoClass;
begin
  Result := TdxLayoutLabeledItemViewInfo;
end;

function TdxLayoutCustomLabeledItem.GetCaptionOptions: TdxLayoutLabeledItemCaptionOptions;
begin
  Result := inherited CaptionOptions as TdxLayoutLabeledItemCaptionOptions;
end;

procedure TdxLayoutCustomLabeledItem.SetCaptionOptions(Value: TdxLayoutLabeledItemCaptionOptions);
begin
  inherited CaptionOptions := Value;
end;

{ TdxLayoutLabeledItem }

function TdxLayoutLabeledItem.GetBaseName: string;
begin
  Result := inherited GetBaseName + 'LabeledItem';
end;

class function TdxLayoutLabeledItem.GetItemClassKind: Integer;
begin
  Result := 5;
end;

{ TdxCustomLayoutControlAdapter }

constructor TdxCustomLayoutControlAdapter.Create(AItem: TdxLayoutItem);
begin
  inherited Create;
  FItem := AItem;
  if not FItem.IsLoading then
  begin
    Init;
    LayoutLookAndFeelChanging;
  end;
end;

procedure TdxCustomLayoutControlAdapter.EndCustomization;
begin
end;

function TdxCustomLayoutControlAdapter.GetControl: TControl;
begin
  Result := FItem.Control;
end;

function TdxCustomLayoutControlAdapter.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := FItem.GetLayoutLookAndFeel;
end;

function TdxCustomLayoutControlAdapter.AllowCheckSize: Boolean;
begin
  Result := True;
end;

procedure TdxCustomLayoutControlAdapter.HideControlBorder;
begin
  SetEnumProp(Control, 'BorderStyle', 'bsNone');
end;

procedure TdxCustomLayoutControlAdapter.Init;
var
  AHeight: Integer;
begin
  FItem.ControlOptions.AutoColor := UseItemColor;
  if FItem.IsDesigning and (FItem.Caption = '') then
    FItem.Caption := Control.Name;//GetPlainString(TControlAccess(Control).Caption);
  if FItem.IsDesigning then
    FItem.ShowCaption := ShowItemCaption;
  FItem.ControlOptions.ShowBorder := NeedBorder;
  if NeedBorder then
  begin
    AHeight := Control.ClientHeight;
    HideControlBorder;
    Control.Height := AHeight;
  end;
end;

procedure TdxCustomLayoutControlAdapter.InternalLayoutLookAndFeelChanged;
begin
  if Item.ControlOptions.AutoColor and (Item.ViewInfo <> nil) then
    TControlAccess(Control).Color := Item.ViewInfo.Color;
end;

function TdxCustomLayoutControlAdapter.NeedBorder: Boolean;
begin
  Result := HasBorderProperty;
end;

function TdxCustomLayoutControlAdapter.HasBorderProperty: Boolean;
begin
  Result :=
    IsPublishedProp(Control, 'BorderStyle') and
    (GetPropInfo(Control, 'BorderStyle').PropType^ = TypeInfo(Forms.TBorderStyle));
end;

function TdxCustomLayoutControlAdapter.ShowItemCaption: Boolean;
begin
  Result := not IsPublishedProp(Control, 'Caption');
end;

procedure TdxCustomLayoutControlAdapter.StartCustomization;
begin
end;

function TdxCustomLayoutControlAdapter.UseItemColor: Boolean;
begin
  Result :=
    TControlAccess(Control).ParentColor and IsPublishedProp(Control, 'Color');
end;

procedure TdxCustomLayoutControlAdapter.LayoutLookAndFeelChanging;
var
  ALookAndFeelContainer: IcxLookAndFeelContainer;
begin
  InternalLayoutLookAndFeelChanged;
  if Supports(Control, IcxLookAndFeelContainer, ALookAndFeelContainer) then
  begin
    Item.RestoreItemControlSize;
    LayoutLookAndFeel.InitializeSubControlCxLookAndFeel(ALookAndFeelContainer.GetLookAndFeel);
  end;
end;

class procedure TdxCustomLayoutControlAdapter.Register(AControlClass: TControlClass);
begin
  dxLayoutControlAdapterDefs.Register(AControlClass, Self);
end;

class procedure TdxCustomLayoutControlAdapter.Unregister(AControlClass: TControlClass);
begin
  dxLayoutControlAdapterDefs.Unregister(AControlClass, Self);
end;

{ TdxLayoutItemControlOptions }

constructor TdxLayoutItemControlOptions.Create(AItem: TdxCustomLayoutItem);
begin
  inherited;
  FAutoControlAreaAlignment := True;
  FMinHeight := dxLayoutItemControlDefaultMinHeight;
  FMinWidth := dxLayoutItemControlDefaultMinWidth;
  FShowBorder := True;
  FAlignHorz := ahClient;
  FAlignVert := avClient;
end;

function TdxLayoutItemControlOptions.IsHeightFixed: Boolean;
begin
  Result := AlignVert <> avClient;
end;

function TdxLayoutItemControlOptions.IsWidthFixed: Boolean;
begin
  Result := AlignHorz <> ahClient;
end;

function TdxLayoutItemControlOptions.GetFixedSize: Boolean;
begin
  Result := ((Item.CaptionOptions.Layout in [clLeft, clRight]) and IsWidthFixed) or
    ((Item.CaptionOptions.Layout in [clTop, clBottom]) and IsHeightFixed);
end;

function TdxLayoutItemControlOptions.GetItem: TdxLayoutItem;
begin
  Result := inherited Item as TdxLayoutItem;
end;

procedure TdxLayoutItemControlOptions.SetAlignHorz(Value: TdxLayoutItemControlAlignHorz);
begin
  if FAlignHorz <> Value then
  begin
    FAlignHorz := Value;
    Changed;
  end;
end;

procedure TdxLayoutItemControlOptions.SetAlignVert(Value: TdxLayoutItemControlAlignVert);
begin
  if FAlignVert <> Value then
  begin
    FAlignVert := Value;
    Changed;
  end;
end;

procedure TdxLayoutItemControlOptions.SetAutoControlAreaAlignment(Value: Boolean);
begin
  if FAutoControlAreaAlignment <> Value then
  begin
    FAutoControlAreaAlignment := Value;
    Changed;
  end;
end;

procedure TdxLayoutItemControlOptions.SetAutoColor(Value: Boolean);
begin
  if FAutoColor <> Value then
  begin
    FAutoColor := Value;
    Item.LayoutLookAndFeelUserChanged;
  end;
end;

procedure TdxLayoutItemControlOptions.SetFixedSize(Value: Boolean);
begin
  if FixedSize <> Value then
    if Value then
      case Item.CaptionOptions.Layout of
        clLeft:
          AlignHorz := ahRight;
        clTop:
          AlignVert := avBottom;
        clRight:
          AlignHorz := ahLeft;
        clBottom:
          AlignVert := avTop;
      end
    else
    begin
      AlignHorz := ahClient;
      AlignVert := avClient;
    end;
end;

procedure TdxLayoutItemControlOptions.SetMinHeight(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMinHeight <> Value then
  begin
    FMinHeight := Value;
    Changed;
  end;
end;

procedure TdxLayoutItemControlOptions.SetMinWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMinWidth <> Value then
  begin
    FMinWidth := Value;
    Changed;
  end;
end;

procedure TdxLayoutItemControlOptions.SetOpaque(Value: Boolean);
begin
  if FOpaque <> Value then
  begin
    FOpaque := Value;
    Changed;
  end;
end;

procedure TdxLayoutItemControlOptions.SetShowBorder(Value: Boolean);
begin
  if FShowBorder <> Value then
  begin
    FShowBorder := Value;
    Changed;
  end;
end;

{ TdxLayoutControlItem }

class function TdxLayoutControlItem.GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass;
begin
  Result := TdxLayoutItemCaptionOptions;
end;

function TdxLayoutControlItem.GetViewInfoClass: TdxCustomLayoutItemViewInfoClass;
begin
  Result := TdxLayoutControlItemViewInfo;
end;

procedure TdxLayoutControlItem.CreateOptions;
begin
  inherited;
  FControlOptions := GetControlOptionsClass.Create(Self);
end;

procedure TdxLayoutControlItem.DestroyOptions;
begin
  FreeAndNil(FControlOptions);
  inherited;
end;

function TdxLayoutControlItem.GetControlOptionsClass: TdxLayoutItemControlOptionsClass;
begin
  Result := TdxLayoutItemControlOptions;
end;

function TdxLayoutControlItem.CanFocusControl: Boolean;
begin
  Result := HasControl and Enabled;
end;

procedure TdxLayoutControlItem.DoInit;
var
  ACommonValue: Variant;

  function IsCommonValue(AValueIndex: Integer; var ACommonValue: Variant): Boolean;
  var
    I: Integer;
    AValue: Variant;

    function CheckValue(AItem: TdxCustomLayoutItem): Boolean;
    begin
      if AItem <> Self then
        case AValueIndex of
          0..2: Result := AItem is TdxLayoutItem;
        else
          Result := False;
        end
      else
        Result := False;
    end;

    function GetValue(AItem: TdxCustomLayoutItem): Variant;
    begin
      case AValueIndex of
        0: Result := TdxLayoutItem(AItem).CaptionOptions.Layout;
        1: Result := TdxLayoutItem(AItem).CaptionOptions.AlignHorz;
        2: Result := TdxLayoutItem(AItem).CaptionOptions.AlignVert;
      else
        Result := Null;
      end;
    end;

  begin
    Result := (Parent <> nil) and not Parent.Hidden;
    if not Result then Exit;
    Result := False;
    ACommonValue := Unassigned;
    for I := 0 to Parent.VisibleCount - 1 do
      if CheckValue(Parent.VisibleItems[I]) then
      begin
        AValue := GetValue(Parent.VisibleItems[I]);
        if VarIsEmpty(ACommonValue) then
          ACommonValue := AValue;
        Result := AValue = ACommonValue;
        if not Result then Break;
      end;
  end;

begin
  inherited;
  if IsCommonValue(0, ACommonValue) then
    CaptionOptions.FLayout := ACommonValue;
  if IsCommonValue(1, ACommonValue) then
    CaptionOptions.FAlignHorz := ACommonValue;
  if IsCommonValue(2, ACommonValue) then
    CaptionOptions.FAlignVert := ACommonValue;
end;

function TdxLayoutControlItem.GetCaptionOptions: TdxLayoutItemCaptionOptions;
begin
  Result := TdxLayoutItemCaptionOptions(inherited CaptionOptions);
end;

function TdxLayoutControlItem.GetViewInfo: TdxLayoutControlItemViewInfo;
begin
  Result := TdxLayoutControlItemViewInfo(inherited ViewInfo);
end;

procedure TdxLayoutControlItem.SetCaptionOptions(Value: TdxLayoutItemCaptionOptions);
begin
  inherited CaptionOptions := Value;
end;

procedure TdxLayoutControlItem.SetControlOptions(Value: TdxLayoutItemControlOptions);
begin
  FControlOptions.Assign(Value);
end;

{ TdxLayoutItem }

destructor TdxLayoutItem.Destroy;
begin
  Control := nil;
  inherited Destroy;
end;

function TdxLayoutItem.GetCaptionOptions: TdxLayoutItemCaptionOptions;
begin
  Result := inherited CaptionOptions as TdxLayoutItemCaptionOptions;
end;

function TdxLayoutItem.GetDesignSelectorRect: TRect;
const
  SelectorRectOffset = 3;
  SelectorRectWidth = 10;
var
  ASelectorRectOffsetX, ASelectorRectOffsetY: Integer; 
begin
  Result := Control.ClientRect;
  Result.Left := Result.Right - SelectorRectWidth;
  Result.Top := Result.Bottom - SelectorRectWidth;
  ASelectorRectOffsetX := SelectorRectOffset;
  ASelectorRectOffsetY := SelectorRectOffset;
  if ViewInfo <> nil then
  begin
    Dec(ASelectorRectOffsetX, ViewInfo.ControlViewInfo.BorderWidths[sdRight]);
    Dec(ASelectorRectOffsetY, ViewInfo.ControlViewInfo.BorderWidths[sdBottom]);
  end;
  OffsetRect(Result, -ASelectorRectOffsetX, -ASelectorRectOffsetY);
end;

function TdxLayoutItem.GetViewInfo: TdxLayoutItemViewInfo;
begin
  Result := inherited ViewInfo as TdxLayoutItemViewInfo;
end;

function TdxLayoutItem.GetWinControl: TWinControl;
begin
  Result := Control as TWinControl;
end;

procedure TdxLayoutItem.SetCaptionOptions(Value: TdxLayoutItemCaptionOptions);
begin
  inherited CaptionOptions := Value;
end;

procedure TdxLayoutItem.SetControl(Value: TControl);

  procedure CheckValue;
  var
    AItem: TdxLayoutItem;
  begin
    if Value <> nil then
    begin
      if Value = Container.ILayout.GetItemsParent then
        raise EdxException.Create(sdxLayoutControlContainerCannotBeControl);
      AItem := Container.FindItem(Value);
      if AItem <> nil then
        raise EdxException.Create(Format(sdxLayoutControlControlIsUsed, [Value.Name, AItem.Name]))
    end;
  end;

  procedure UnprepareControl;
  begin
    if IsDesigning then
      with Control do
        ControlStyle := ControlStyle - [csNoDesignVisible];

    FreeAndNil(FCustomizeControlHelper);
    cxWindowProcController.Remove(FWindowProcObject);

    FreeAndNil(FControlAdapter);
    Container.UnprepareControl(Control);
  end;

  procedure PrepareControl;
  begin
    Control.Enabled := Enabled;
    FWindowProcObject := cxWindowProcController.Add(Control, ControlWndProc);
    if IsDesigning then
      with FControl do
        ControlStyle := ControlStyle + [csNoDesignVisible];
    Container.PrepareControl(Control);
    SaveOriginalControlSize;
    CreateControlAdapter;
    SaveOriginalControlSize;
    if HasWinControl and not WinControl.HandleAllocated then
      SaveControlSizeBeforeDestruction;

    if IsDesigning then
    begin
      FCustomizeControlHelper := Container.ILayout.CreateCustomizationControlHelper(Self);
      UpdateDesignSelectors;
    end;
  end;

begin
  if FControl <> Value then
  begin
    CheckValue;
    BeginUpdate;
    FControlLocked := True;
    try
      if FControl <> nil then
        UnprepareControl;
      FControl := Value;
      if Value <> nil then
        PrepareControl;
    finally
      FControlLocked := False;
      EndUpdate;
    end;
  end;
end;

function TdxLayoutItem.CanFocusControlOnCaptionClick: Boolean;
begin
  Result := not Container.IsCustomization and Container.GetIsFocusControlOnItemCaptionClick and CanFocusControl;
end;

procedure TdxLayoutItem.CreateControlAdapter;
begin
  FControlAdapter :=
    dxLayoutControlAdapterDefs.GetAdapterClass(FControl).Create(Self);
end;

function TdxLayoutItem.CanDelete: Boolean;
begin
  Result := IsDesigning;
end;

function TdxLayoutItem.CanProcessAccel(out AItem: TdxCustomLayoutItem): Boolean;
begin
  Result := CanFocusControl;
  if Result then
    AItem := Self;
end;

procedure TdxLayoutItem.ContainerChanged;

  procedure ResetControlParent;
  var
    ASavedControl: TControl;
  begin
    if Control.Parent <> Container.ILayout.GetItemsParent then
    begin
      ASavedControl := Control;
      Control := nil;
      Control := ASavedControl;
    end;
  end;

begin
  if HasControl and (Container <> nil) then
    ResetControlParent;
end;

procedure TdxLayoutItem.CustomizationChanged;
begin
  if FControlAdapter <> nil then
  begin
    if Customization then
      FControlAdapter.StartCustomization
    else
      if not (csDestroying in FControlAdapter.Control.ComponentState) then
        FControlAdapter.EndCustomization;
  end;
end;

procedure TdxLayoutItem.DoCaptionDown;
begin
  if CanFocusControlOnCaptionClick then
    SetControlFocus;
end;

procedure TdxLayoutItem.DoGetTabOrderList(List: TList);
begin
  inherited;
  if CanFocusControl then
  begin
    List.Add(Control);
    WinControl.GetTabOrderList(List);
  end;
end;

function TdxLayoutItem.GetBaseName: string;
begin
  Result := inherited GetBaseName + 'Item';
end;

class function TdxLayoutItem.GetItemClassKind: Integer;
begin
  Result := 0;
end;

function TdxLayoutItem.GetViewInfoClass: TdxCustomLayoutItemViewInfoClass;
begin
  Result := TdxCustomLayoutItemViewInfoClass(GetLayoutLookAndFeel.GetItemViewInfoClass);
end;

procedure TdxLayoutItem.LayoutLookAndFeelChanging;
begin
  inherited;
  if FControlAdapter <> nil then
    FControlAdapter.LayoutLookAndFeelChanging;
end;

procedure TdxLayoutItem.UpdateDesignSelectors;
begin
  if HasControl and not (csDestroying in Control.ComponentState) and
      (FCustomizeControlHelper <> nil) and Control.Parent.HandleAllocated then
    FCustomizeControlHelper.SelectorBounds := DesignSelectorRect;
end;

procedure TdxLayoutItem.ProcessAccel;
begin
  SetControlFocus;
end;

procedure TdxLayoutItem.RestoreItemControlSize;
begin
  if HasControl and FControlSizeChanged then
  begin
    Container.StartPlacingControls;
    try
      Control.SetBounds(Control.Left, Control.Top, FOriginalControlSize.X, FOriginalControlSize.Y);
      FControlSizeChanged := False;
    finally
      Container.StopPlacingControls;
    end;
  end;
end;

procedure TdxLayoutItem.BeforeCalculateViewInfo;
begin
  if HasWinControl and not WinControl.HandleAllocated then
    SaveOriginalControlSize;
  inherited;
end;

procedure TdxLayoutItem.ApplyCalculatedChanges;
begin
  SetControlVisibility;
  SetControlEnablement;
  inherited;
end;

function TdxLayoutItem.CanFocusControl: Boolean;
begin
  Result := HasWinControl and WinControl.CanFocus;
end;

procedure TdxLayoutItem.ControlWndProc(var Message: TMessage);

  function IsControlMoved: Boolean;
  begin
    Result := (Message.LParam = 0) or (PWindowPos(Message.LParam)^.flags and SWP_NOMOVE = 0);
  end;

  function IsControlResized: Boolean;
  begin
    Result := (Message.LParam = 0) or (PWindowPos(Message.LParam)^.flags and SWP_NOSIZE = 0);
  end;

  function ControlSizeChanged: Boolean;
  begin
    Result := not cxPointIsEqual(Point(Control.Width, Control.Height), FOriginalControlSize);
  end;

  function NeedSaveOriginalControlSize: Boolean;
  begin
    Result := IsControlResized and FControlAdapter.AllowCheckSize and ControlSizeChanged;
  end;

begin
  FWindowProcObject.DefaultProc(Message);

  if not FControlLocked then
    case Message.Msg of
      WM_CREATE:
        if (Control.Width <> ControlSizeBeforeDestruction.X) or
          (Control.Height <> ControlSizeBeforeDestruction.Y) then
        begin
          SaveOriginalControlSize;
          Changed;
        end;
      WM_DESTROY:
        SaveControlSizeBeforeDestruction;
      WM_SETFOCUS, DXM_CONTAINERSETFOCUS:
        MakeVisible;
      WM_WINDOWPOSCHANGING:
        begin
          if not Container.IsPlacingControls and IsControlResized then
          begin
            FNewControlSize := Point(PWindowPos(Message.LParam)^.cx, PWindowPos(Message.LParam)^.cy);
            if FNewControlSize.X = Control.Width then
              FNewControlSize.X := -1;
            if FNewControlSize.Y = Control.Height then
              FNewControlSize.Y := -1;
            FIsNewControlSizeAssigned := (FNewControlSize.Y <> -1) or (FNewControlSize.X <> -1);
          end;
        end;
      WM_WINDOWPOSCHANGED:
        begin
          if not Container.IsPlacingControls and (IsControlMoved or
            (IsControlResized and FControlAdapter.AllowCheckSize)) then
          begin
            if NeedSaveOriginalControlSize then
            begin
              if FIsNewControlSizeAssigned then
              begin
                if FNewControlSize.X <> -1 then
                  FOriginalControlSize.X := FNewControlSize.X;
                if FNewControlSize.Y <> -1 then
                  FOriginalControlSize.Y := FNewControlSize.Y;
              end
              else
                SaveOriginalControlSize;
            end;
            Changed;
          end;
          UpdateDesignSelectors;
          FIsNewControlSizeAssigned := False;
        end;
      CM_TABSTOPCHANGED:
        if not Container.IsUpdateLocked then
          Container.ViewInfo.CalculateTabOrders;
      CM_ENABLEDCHANGED:
        Enabled := Control.Enabled;
    end;
end;

function TdxLayoutItem.IsDesignSelectorVisible: Boolean;
var
  R: TRect;
  ADesignSelector: TRect;
begin
  Result := HasControl and Container.IsDesignSelectorsVisible;
  if Result then
  begin
    R := Control.ClientRect;
    ADesignSelector := DesignSelectorRect;
    Result := not cxRectIsInvalid(ADesignSelector) and cxRectContain(R, ADesignSelector);
  end;
end;

function TdxLayoutItem.HasControl: Boolean;
begin
  Result := FControl <> nil;
end;

function TdxLayoutItem.HasWinControl: Boolean;
begin
  Result := HasControl and (FControl is TWinControl);
end;

procedure TdxLayoutItem.SaveControlSizeBeforeDestruction;
begin
  FControlSizeBeforeDestruction := Point(Control.Width, Control.Height);
end;

procedure TdxLayoutItem.SaveOriginalControlSize;
begin
  if HasWinControl and Control.Parent.HandleAllocated and CanAllocateHandle(WinControl) then
    WinControl.HandleNeeded;  // for cxEditors
  FOriginalControlSize := Point(FControl.Width, FControl.Height);
end;

procedure TdxLayoutItem.SetControlEnablement;
begin
  if HasControl then
    Control.Enabled := Enabled;
end;

procedure TdxLayoutItem.SetControlFocus;
begin
  WinControl.SetFocus;
end;

procedure TdxLayoutItem.SetControlVisibility;

  procedure InternalSetControlVisibility(AValue: Boolean);
  begin
    if Control.Visible <> AValue then
    begin
      Container.StartPlacingControls;
      try
        Control.Visible := AValue;
        // to make the control invisible on showing
        if not AValue then
          Control.SetBounds(10000, 10000, FOriginalControlSize.X, FOriginalControlSize.Y)
        else
          Control.BoundsRect := ViewInfo.FControlViewInfo.ControlBounds;
      finally
        Container.StopPlacingControls;
      end;
    end;
  end;

begin
  if HasControl then
     InternalSetControlVisibility(ActuallyVisible and ViewInfo.ActuallyVisible);
end;

{ TdxLayoutGroupHelper }

class function TdxLayoutGroupHelper.GetChildItemsAlignHorz: TdxLayoutAlignHorz;
begin
  Result := ahClient;
end;

class function TdxLayoutGroupHelper.GetChildItemsAlignVert: TdxLayoutAlignVert;
begin
  Result := avClient;
end;

class function TdxLayoutGroupHelper.GetOrthogonalDirection: TdxLayoutDirection;
begin
  Result := ldVertical;
end;

class function TdxLayoutGroupHelper.GetSpecificClass: TdxLayoutGroupViewInfoSpecificClass;
begin
  Result := TdxLayoutGroupViewInfoSpecific;
end;

{ TdxLayoutHorizontalGroupHelper }

class function TdxLayoutHorizontalGroupHelper.GetChildItemsAlignHorz: TdxLayoutAlignHorz;
begin
  Result := ahLeft;
end;

class function TdxLayoutHorizontalGroupHelper.GetChildItemsAlignVert: TdxLayoutAlignVert;
begin
  Result := avClient;
end;

class function TdxLayoutHorizontalGroupHelper.GetOrthogonalDirection: TdxLayoutDirection;
begin
  Result := ldVertical;
end;

class function TdxLayoutHorizontalGroupHelper.GetSpecificClass: TdxLayoutGroupViewInfoSpecificClass;
begin
  Result := TdxLayoutGroupViewInfoHorizontalSpecific;
end;

{ TdxLayoutVerticalGroupHelper }

class function TdxLayoutVerticalGroupHelper.GetChildItemsAlignHorz: TdxLayoutAlignHorz;
begin
  Result := ahClient;
end;

class function TdxLayoutVerticalGroupHelper.GetChildItemsAlignVert: TdxLayoutAlignVert;
begin
  Result := avTop;
end;

class function TdxLayoutVerticalGroupHelper.GetOrthogonalDirection: TdxLayoutDirection;
begin
  Result := ldHorizontal;
end;

class function TdxLayoutVerticalGroupHelper.GetSpecificClass: TdxLayoutGroupViewInfoSpecificClass;
begin
  Result := TdxLayoutGroupViewInfoVerticalSpecific;
end;

{ TdxLayoutTabbedGroupHelper }

class function TdxLayoutTabbedGroupHelper.GetChildItemsAlignHorz: TdxLayoutAlignHorz;
begin
  Result := ahClient;
end;

class function TdxLayoutTabbedGroupHelper.GetChildItemsAlignVert: TdxLayoutAlignVert;
begin
  Result := avClient;
end;

class function TdxLayoutTabbedGroupHelper.GetOrthogonalDirection: TdxLayoutDirection;
begin
  Result := ldTabbed;
end;

class function TdxLayoutTabbedGroupHelper.GetSpecificClass: TdxLayoutGroupViewInfoSpecificClass;
begin
  Result := TdxLayoutGroupViewInfoTabbedSpecific;
end;

{ TdxLayoutTabbedOptions }

constructor TdxLayoutTabbedOptions.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FImages := TcxImageList.Create(nil);
end;

destructor TdxLayoutTabbedOptions.Destroy;
begin
  FreeAndNil(FImages);
  inherited Destroy;
end;

procedure TdxLayoutTabbedOptions.InsertTab(AItem: TdxCustomLayoutItem);
begin
  BeginUpdate;
  try
    Tabs.InsertObject(AItem.Index, GetItemCaption(AItem), AItem);
  finally
    CancelUpdate;
  end;
end;

procedure TdxLayoutTabbedOptions.CheckTabs;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Group.Count - 1 do
      Tabs.Move(Tabs.IndexOfObject(Group[I]), I);
  finally
    CancelUpdate;
  end;
end;

procedure TdxLayoutTabbedOptions.DeleteTab(AItem: TdxCustomLayoutItem);
var
  AIndex: Integer;
begin
  BeginUpdate;
  try
    AIndex := Tabs.IndexOfObject(AItem);
    if AIndex >= 0 then
      Tabs.Delete(AIndex);
  finally
    CancelUpdate;
  end;
end;

function TdxLayoutTabbedOptions.GetItem(AIndex: Integer): TdxCustomLayoutItem;
begin
  Result := Tabs.Objects[AIndex] as TdxCustomLayoutItem;
end;

procedure TdxLayoutTabbedOptions.RefreshImages;

  function AddImage(AItem: TdxCustomLayoutItem): Integer;
  var
    AAlphaBitmap: TcxAlphaBitmap;
  begin
    AAlphaBitmap := TcxAlphaBitmap.CreateSize(FImages.Width, FImages.Height);
    try
      AAlphaBitmap.Clear;
      dxDrawItemGlyph(AAlphaBitmap.cxCanvas, AItem, AAlphaBitmap.ClientRect, ra0);
      Result := FImages.Add(AAlphaBitmap, nil);
    finally
      AAlphaBitmap.Free;
    end;
  end;

var
  I: Integer;
  AItem: TdxCustomLayoutItem;
begin
  BeginUpdate;
  try
    FImages.Clear;
    with Group.GetMaxChildImageSize do
    begin
      FImages.Width := cx;
      FImages.Height := cy;
    end;
    for I := 0 to Tabs.Count - 1 do
    begin
      AItem := GetItem(I);
      if AItem.IsImageVisible and AItem.CaptionOptions.ImageOptions.IsImageAssigned then
        Tabs[I].ImageIndex := AddImage(AItem)
      else
        Tabs[I].ImageIndex := -1;
    end;
    if FImages.Count = 0 then
      Images := nil
    else
      Images := FImages;
  finally
    CancelUpdate;
  end;
end;

procedure TdxLayoutTabbedOptions.RefreshTabsCaption;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Tabs.Count - 1 do
      Tabs[I].Caption := GetItemCaption(GetItem(I));
  finally
    CancelUpdate;
  end;
end;

procedure TdxLayoutTabbedOptions.RefreshTabsEnabled;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Tabs.Count - 1 do
      Tabs[I].Enabled := GetItem(I).GetEnabled;
  finally
    CancelUpdate;
  end;
end;

procedure TdxLayoutTabbedOptions.RefreshTabsVisible;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Tabs.Count - 1 do
      Tabs[I].Visible := GetItem(I).GetVisible;
  finally
    CancelUpdate;
  end;
end;

function TdxLayoutTabbedOptions.GetGroup: TdxLayoutGroup;
begin
  Result := GetOwner as TdxLayoutGroup;
end;

function TdxLayoutTabbedOptions.GetItemCaption(AItem: TdxCustomLayoutItem): string;
begin
  if AItem.IsTextVisible then
    Result := AItem.Caption
  else
    Result := '';
end;

{ TdxLayoutGroupButtons }

constructor TdxLayoutGroupButtons.Create(AOptions: TdxLayoutGroupButtonOptions);
begin
  inherited Create(TdxLayoutGroupButton);
  FOptions := AOptions;
  PropName := 'Buttons';
end;

function TdxLayoutGroupButtons.GetOwner: TPersistent;
begin
  Result := FOptions;
end;

procedure TdxLayoutGroupButtons.Update(Item: TCollectionItem);
begin
  CallNotify(FOnChange, Self);
end;

function TdxLayoutGroupButtons.GetItem(Index: Integer): TdxLayoutGroupButton;
begin
  Result := inherited Items[Index] as TdxLayoutGroupButton;
end;

function TdxLayoutGroupButtons.GetOptions: TdxLayoutGroupButtonOptions;
begin
  Result := FOptions;
end;

procedure TdxLayoutGroupButtons.SetItem(Index: Integer; const AValue: TdxLayoutGroupButton);
begin
  inherited Items[Index] := AValue;
end;

{ TdxLayoutGroupButtonOptions }

constructor TdxLayoutGroupButtonOptions.Create(AGroup: TdxLayoutGroup);
begin
  inherited Create;
  FGroup := AGroup;
  FInternalButtons := TdxLayoutGroupButtons.Create(Self);
  FExpandButton := FInternalButtons.Add as TdxLayoutGroupButton;
  FExpandButton.Visible := False;
  FExpandButton.OnExpandButtonClick := ExpandButtonClickHandler;
  FInternalButtons.OnChange := ChangeCollectionHandler;
  FButtons := TdxLayoutGroupButtons.Create(Self);
  FButtons.OnChange := ChangeCollectionHandler;
  FVisible := True;
  FDefaultHeight := 16;
  FDefaultWidth := 16;
  FAlignment := gbaRight;
end;

destructor TdxLayoutGroupButtonOptions.Destroy;
begin
  FreeAndNil(FButtons);
  FreeAndNil(FInternalButtons);
  inherited Destroy;
end;

procedure TdxLayoutGroupButtonOptions.Assign(Source: TPersistent);
var
  AOptions: TdxLayoutGroupButtonOptions;
begin
  if Source is TdxLayoutGroupButtonOptions then
  begin
    AOptions := Source as TdxLayoutGroupButtonOptions;
    Alignment := AOptions.Alignment;
    Buttons := AOptions.Buttons;
    ShowExpandButton := AOptions.ShowExpandButton;
    Visible := AOptions.Visible;
  end
  else
    inherited Assign(Source);
end;

function TdxLayoutGroupButtonOptions.GetOwner: TPersistent;
begin
  Result := FGroup;
end;

procedure TdxLayoutGroupButtonOptions.Changed;
begin
  Group.Changed;
end;

function TdxLayoutGroupButtonOptions.IsAnyButtonVisible: Boolean;
begin
  Result := Visible and ((VisibleCount > 0) or ShowExpandButton);
end;

procedure TdxLayoutGroupButtonOptions.ChangeCollectionHandler(Sender: TObject);
begin
  Changed;
end;

procedure TdxLayoutGroupButtonOptions.ExpandButtonClickHandler(Sender: TObject);
begin
  Group.Expanded := not Group.Expanded;
end;

function TdxLayoutGroupButtonOptions.GetShowExpandButton: Boolean;
begin
  Result := ExpandButton.Visible;
end;

function TdxLayoutGroupButtonOptions.GetVisibleCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Buttons.Count - 1 do
    if Buttons[I].Visible then
      Inc(Result);
end;

procedure TdxLayoutGroupButtonOptions.SetButtons(AValue: TdxLayoutGroupButtons);
begin
  Buttons.Assign(AValue);
end;

procedure TdxLayoutGroupButtonOptions.SetDefaultHeight(AValue: Cardinal);
begin
  if FDefaultHeight <> AValue then
  begin
    FDefaultHeight := AValue;
    Changed;
  end;
end;

procedure TdxLayoutGroupButtonOptions.SetDefaultWidth(AValue: Cardinal);
begin
  if FDefaultWidth <> AValue then
  begin
    FDefaultWidth := AValue;
    Changed;
  end;
end;

procedure TdxLayoutGroupButtonOptions.SetAlignment(AValue: TdxLayoutGroupButtonsAlignment);
begin
  if FAlignment <> AValue then
  begin
    FAlignment := AValue;
    Changed;
  end;
end;

procedure TdxLayoutGroupButtonOptions.SetShowExpandButton(AValue: Boolean);
begin
  FExpandButton.Visible := AValue
end;

procedure TdxLayoutGroupButtonOptions.SetVisible(AValue: Boolean);
begin
  if FVisible <> AValue then
  begin
    FVisible := AValue;
    Changed;
  end;
end;

{ TdxLayoutGroupButton }

constructor TdxLayoutGroupButton.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FGlyph := TBitmap.Create;
  FVisible := True;
  FEnabled := True;
end;

destructor TdxLayoutGroupButton.Destroy;
begin
  FreeAndNil(FGlyph);
  inherited Destroy;
end;

procedure TdxLayoutGroupButton.Assign(Source: TPersistent);
var
  AButton: TdxLayoutGroupButton;
begin
  if Source is TdxLayoutGroupButton then
  begin
    AButton := Source as TdxLayoutGroupButton;
    Glyph := AButton.Glyph;
    Height := AButton.Height;
    Hint := AButton.Hint;
    Tag := AButton.Tag;
    Width := AButton.Width;
    Visible := AButton.Visible;
  end
  else
    inherited Assign(Source);
end;

function TdxLayoutGroupButton.GetNamePath: string;
begin
  Result := Buttons.Options.Group.GetNamePath + '.' + Format('Button[%d]',[Index]);
end;

function TdxLayoutGroupButton.GetHeight: Integer;
begin
  if Height = 0 then
    Result := Buttons.Options.DefaultHeight
  else
    Result := Height;
end;

function TdxLayoutGroupButton.GetWidth: Integer;
begin
  if Width = 0 then
    Result := Buttons.Options.DefaultWidth
  else
    Result := Width;
end;

procedure TdxLayoutGroupButton.DoClick;
begin
  if IsExpandButton then
    CallNotify(FOnExpandButtonClick, Self);
  CallNotify(FOnClick, Self);
end;

function TdxLayoutGroupButton.IsExpandButton: Boolean;
begin
  Result := Self = Buttons.Options.ExpandButton;
end;

function TdxLayoutGroupButton.GetButtons: TdxLayoutGroupButtons;
begin
  Result := Collection as TdxLayoutGroupButtons;
end;

procedure TdxLayoutGroupButton.SetEnabled(AValue: Boolean);
begin
  if FEnabled <> AValue then
  begin
    FEnabled := AValue;
    Changed(False);
  end;
end;

procedure TdxLayoutGroupButton.SetGlyph(AValue: TBitmap);
begin
  FGlyph.Assign(AValue);
  Changed(False);
end;

procedure TdxLayoutGroupButton.SetHeight(AValue: Cardinal);
begin
  if FHeight <> AValue then
  begin
    FHeight := AValue;
    Changed(False);
  end;
end;

procedure TdxLayoutGroupButton.SetVisible(AValue: Boolean);
begin
  if FVisible <> AValue then
  begin
    FVisible := AValue;
    Changed(False);
  end;
end;

procedure TdxLayoutGroupButton.SetWidth(AValue: Cardinal);
begin
  if FWidth <> AValue then
  begin
    FWidth := AValue;
    Changed(False);
  end;
end;

{ TdxLayoutGroupCaptionOptions }

constructor TdxLayoutGroupCaptionOptions.Create(AItem: TdxCustomLayoutItem);
begin
  inherited;
  Layout := clTop;
end;

{ TdxLayoutGroup }

constructor TdxLayoutGroup.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TcxComponentList.Create(True);
  FItems.OnComponentListChanged := ItemListChanged;
  FVisibleItems := TcxComponentList.Create;
  FLayoutDirection := ldVertical;
  FShowBorder := True;
  FUseIndent := True;
  FExpanded := True;
  FItemIndex := dxLayoutPseudoActiveItem;
end;

destructor TdxLayoutGroup.Destroy;
begin
  FreeAndNil(FVisibleItems);
  FreeAndNil(FItems);
  inherited;
end;

procedure TdxLayoutGroup.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TdxLayoutGroup then
  begin
    ButtonOptions := TdxLayoutGroup(Source).ButtonOptions;
    Expanded := TdxLayoutGroup(Source).Expanded;
    Hidden := TdxLayoutGroup(Source).Hidden;
    ItemControlAreaAlignment := TdxLayoutGroup(Source).ItemControlAreaAlignment;
    ItemIndex := TdxLayoutGroup(Source).ItemIndex;
    LayoutDirection := TdxLayoutGroup(Source).LayoutDirection;
    Locked := TdxLayoutGroup(Source).Locked;
    LayoutLookAndFeelException := TdxLayoutGroup(Source).LayoutLookAndFeelException;
    ShowBorder := TdxLayoutGroup(Source).ShowBorder;
    TabbedOptions := TdxLayoutGroup(Source).TabbedOptions;
    UseIndent := TdxLayoutGroup(Source).UseIndent;
  end;
end;

function TdxLayoutGroup.GetCaptionOptions: TdxLayoutGroupCaptionOptions;
begin
  Result := TdxLayoutGroupCaptionOptions(inherited CaptionOptions);
end;

function TdxLayoutGroup.GetCount: Integer;
begin
  Result := FItems.Count;
end;

procedure TdxLayoutGroup.TabbedOptionsChangedHandler(Sender: TObject; AType: TcxCustomTabControlPropertiesChangedType);
begin
  Inc(FTabbedChangesCount);
  if IsDestroying or IsLoading or Container.IsUpdateLocked then
    Exit;
  case AType of
    pctLight:
      Changed(ictLight);
    pctMedium:
      Changed(ictMedium);
  else
    if ItemIndex = TabbedOptions.TabIndex then
      Changed(ictHard);
  end;
end;

procedure TdxLayoutGroup.TabbedOptionsChangeHandler(Sender: TObject);
begin
  if IsDestroying then
    Exit;
  ItemIndex := TabbedOptions.TabIndex;
  Container.Modified;
end;

procedure TdxLayoutGroup.TabCanCloseHandler(Sender: TObject; ATabIndex: Integer; var ACanClose: Boolean);
begin
  ACanClose := not Container.IsCustomization;
end;

procedure TdxLayoutGroup.TabCloseHandler(Sender: TObject; ATabIndex: Integer);
begin
  Inc(FTabbedChangesCount);
  Items[ATabIndex].Parent := nil;
end;

function TdxLayoutGroup.GetItem(Index: Integer): TdxCustomLayoutItem;
begin
  Result := TdxCustomLayoutItem(FItems[Index]);
end;

function TdxLayoutGroup.GetShowBorder: Boolean;
begin
  Result := not FHidden and FShowBorder;
end;

function TdxLayoutGroup.GetViewInfo: TdxLayoutGroupViewInfo;
begin
  Result := TdxLayoutGroupViewInfo(inherited ViewInfo);
end;

function TdxLayoutGroup.GetVisibleCount: Integer;
begin
  Result := FVisibleItems.Count;
end;

function TdxLayoutGroup.GetVisibleItem(Index: Integer): TdxCustomLayoutItem;
begin
  if (Index >=0) and (Index < VisibleCount) then
    Result := TdxCustomLayoutItem(FVisibleItems[Index])
  else
    Result := nil;
end;

procedure TdxLayoutGroup.SetButtonOptions(Value: TdxLayoutGroupButtonOptions);
begin
  FButtonOptions.Assign(Value);
end;

procedure TdxLayoutGroup.SetCaptionOptions(Value: TdxLayoutGroupCaptionOptions);
begin
  inherited CaptionOptions := Value;
end;

procedure TdxLayoutGroup.SetExpanded(Value: Boolean);

  procedure ExpandedChanged;
  begin
    if FExpanded then
      DoExpanded
    else
      DoCollapsed;
  end;

begin
  if FExpanded <> Value then
  begin
    FExpanded := Value;
    ExpandedChanged;
    Changed;
  end;
end;

procedure TdxLayoutGroup.SetHidden(Value: Boolean);
begin
  if FHidden <> Value then
  begin
    FHidden := Value;
    if not IsRoot then
      Changed;
  end;
end;

procedure TdxLayoutGroup.SetItemIndex(Value: Integer);
begin
  if FItemindex <> Value then
  begin
    FItemindex := Value;
    Changed(ictMedium);
    DoTabChanged;
  end;
end;

procedure TdxLayoutGroup.SetItemControlAreaAlignment(Value: TdxLayoutItemControlAreaAlignment);
begin
  if FItemControlAreaAlignment <> Value then
  begin
    FItemControlAreaAlignment := Value;
    Changed;
  end;
end;

procedure TdxLayoutGroup.SetLayoutDirection(Value: TdxLayoutDirection);
begin
  if FLayoutDirection <> Value then
  begin
    FLayoutDirection := Value;
    Changed;
  end;
end;

procedure TdxLayoutGroup.SetLocked(Value: Boolean);
begin
  if FLocked <> Value then
  begin
    FLocked := Value;
    Container.CustomizeFormUpdateList(Self);
  end;
end;

procedure TdxLayoutGroup.SetLayoutLookAndFeelException(Value: Boolean);
begin
  if FLayoutLookAndFeelException <> Value then
  begin
    FLayoutLookAndFeelException := Value;
    LayoutLookAndFeelUserChanged;
  end;
end;

procedure TdxLayoutGroup.SetShowBorder(Value: Boolean);
begin
  if FShowBorder <> Value then
  begin
    FShowBorder := Value;
    Changed;
  end;
end;

procedure TdxLayoutGroup.SetTabbedOptions(Value: TdxLayoutTabbedOptions);
begin
  FTabbedOptions.Assign(Value);
end;

procedure TdxLayoutGroup.SetUseIndent(Value: Boolean);
begin
  if FUseIndent <> Value then
  begin
    FUseIndent := Value;
    Changed; 
  end;
end;

procedure TdxLayoutGroup.AddItem(AItem: TdxCustomLayoutItem);
begin
  FItems.Add(AItem);
  AItem.FParent := Self;
  AItem.Container := FContainer;
  AItem.Init;
  TabbedOptions.InsertTab(AItem);
end;

procedure TdxLayoutGroup.ExtractItem(AItem: TdxCustomLayoutItem);
begin
  if not (csDestroying in ComponentState) then
  begin
    TabbedOptions.DeleteTab(AItem);
    FItems.Extract(AItem);
    AItem.FParent := nil;
    Changed;
  end;
end;

procedure TdxLayoutGroup.ItemListChanged(Sender: TObject; AComponent: TComponent; AAction: TcxComponentCollectionNotification);
begin
  Container.CustomizeFormUpdateList(Self);
end;

procedure TdxLayoutGroup.ReadSpecial(Reader: TReader);
begin
  Reader.ReadBoolean;
  Container.AddSpecialGroup(Self);
end;

procedure TdxLayoutGroup.WriteSpecial(Writer: TWriter);
begin
  Writer.WriteBoolean(True);
end;

function TdxLayoutGroup.IsItemIndexStored: Boolean;
begin
  Result := (VisibleCount > 0) and (ItemIndex <> 0);
end;

function TdxLayoutGroup.GetChildLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  if LayoutLookAndFeelException and (Parent <> nil) then
    Result := Parent.GetChildLayoutLookAndFeel
  else
    Result := GetLayoutLookAndFeel;
end;

function TdxLayoutGroup.CanDelete: Boolean;
var
  I: Integer;
begin
  Result := IsDesigning or (not IsRoot and not Locked and IsUserDefined);
  if Result then
    for I := 0 to Count - 1 do
    begin
      Result := Items[I].CanDelete;
      if not Result then
        Break;
    end;
end;

function TdxLayoutGroup.CanProcessAccel(out AItem: TdxCustomLayoutItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to VisibleCount - 1 do
  begin
    AItem := VisibleItems[I];
    Result := AItem.CanProcessAccel(AItem);
    if Result then Break;
  end;
end;

function TdxLayoutGroup.CanRemove: Boolean;
var
  I: Integer;
begin
  Result := inherited CanRemove;
  if Result then
    for I := 0 to Count - 1 do
    begin
      Result := Items[I].CanRemove;
      if not Result then Break;
    end;
end;

procedure TdxLayoutGroup.ContainerChanged;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Container := Container;
end;

procedure TdxLayoutGroup.DoChanged(AType: TdxLayoutItemChangeType);
begin
  ClearTabbedChanges;
  inherited;
end;

procedure TdxLayoutGroup.DoGetTabOrderList(List: TList);
var
  I: Integer;
begin
  inherited;
  if CanFocus then
    List.Add(Container.ItemsParent);
  for I := 0 to VisibleCount - 1 do
    VisibleItems[I].GetTabOrderList(List);
end;

procedure TdxLayoutGroup.DoPack;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Items[I].Pack;
  if IsSuperfluous then
  begin
    if (Parent <> nil) and (Parent.Count = 1) and (Count > 0) then
      Parent.LayoutDirection := LayoutDirection;
    MoveChildrenToParent;
    Container.CheckDestroySuperfluousGroup(Self)
  end;
end;

class function TdxLayoutGroup.GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass;
begin
  Result := TdxLayoutGroupCaptionOptions;
end;

function TdxLayoutGroup.IsLocked: Boolean;
begin
  Result := inherited IsLocked or (not IsDesigning and Locked and Container.IsCustomization);
end;

procedure TdxLayoutGroup.ClearTabbedChanges;
begin
  FTabbedChangesCount := 0;
end;

function TdxLayoutGroup.HasTabbedChanges: Boolean;
begin
  Result := FTabbedChangesCount > 0;
end;

procedure TdxLayoutGroup.CreateOptions;
begin
  inherited;
  FButtonOptions := TdxLayoutGroupButtonOptions.Create(Self);
  FTabbedOptions := TdxLayoutTabbedOptions.Create(Self);
  FTabbedOptions.OnChanged := TabbedOptionsChangedHandler;
  FTabbedOptions.OnChange := TabbedOptionsChangeHandler;
  FTabbedOptions.OnClose := TabCloseHandler;
  FTabbedOptions.OnCanClose := TabCanCloseHandler;
end;

procedure TdxLayoutGroup.DestroyOptions;
begin
  FreeAndNil(FTabbedOptions);
  FreeAndNil(FButtonOptions);
  inherited;
end;

procedure TdxLayoutGroup.DefineProperties(Filer: TFiler);

  function IsSpecialStored: Boolean;
  begin
    Result := Container.FSpecialItems.IndexOf(Self) >= 0;
  end;

begin
  inherited;
  Filer.DefineProperty('Special', ReadSpecial, WriteSpecial, IsSpecialStored);
end;

class function TdxLayoutGroup.GetItemClassKind: Integer;
begin
  Result := 1;
end;

function TdxLayoutGroup.GetBaseName: string;
begin
  Result := inherited GetBaseName + 'Group';
end;

function TdxLayoutGroup.GetShowCaption: Boolean;
begin
  Result := ShowBorder and inherited GetShowCaption;
end;

function TdxLayoutGroup.GetViewInfoClass: TdxCustomLayoutItemViewInfoClass;
begin
  Result := TdxCustomLayoutItemViewInfoClass(GetLayoutLookAndFeel.GetGroupViewInfoClass);
end;

procedure TdxLayoutGroup.LoadFromIni(AIniFile: TCustomIniFile; const ASection: string; AVersion: Integer);
var
  AReader: TdxLayoutGroupReaderClass;
begin
  inherited;
  case AVersion of
    3: AReader := TdxLayoutGroupReader3;
    2: AReader := TdxLayoutGroupReader2;
  else
    AReader := TdxLayoutGroupReader;
  end;

  AReader.LoadFromIni(Self, AIniFile, ASection);
end;

procedure TdxLayoutGroup.SaveToIni(AIniFile: TCustomIniFile; const ASection: string);
begin
  inherited;
  TdxLayoutGroupWriter.SaveToIni(Self, AIniFile, ASection);
end;

procedure TdxLayoutGroup.LayoutLookAndFeelChanged;
var
  I: Integer;
begin
  inherited;
  for I := 0 to Count - 1 do
    Items[I].LayoutLookAndFeelChanged;
end;

procedure TdxLayoutGroup.LayoutLookAndFeelChanging;
var
  I: Integer;
begin
  inherited;
  for I := 0 to Count - 1 do
    Items[I].LayoutLookAndFeelChanging;
end;

function TdxLayoutGroup.ProcessDialogChar(ACharCode: Word): Boolean;
var
  I: Integer;
begin
  Result := inherited ProcessDialogChar(ACharCode);
  if not Result then
    for I := 0 to VisibleCount - 1 do
    begin
      Result := VisibleItems[I].ProcessDialogChar(ACharCode);
      if Result then Break;
    end;
end;

function TdxLayoutGroup.ProcessDialogKey(ACharCode: Word; AKeyData: Integer; AFocusedItem: TdxLayoutItem): Boolean;
var
  I: Integer;
begin
  Result := ViewInfo.Specific.ProcessDialogKey(ACharCode, AKeyData, AFocusedItem);
  if not Result then
    for I := 0 to VisibleCount - 1 do
    begin
      Result := VisibleItems[I].ProcessDialogKey(ACharCode, AKeyData, AFocusedItem);
      if Result then Break;
    end;
end;

procedure TdxLayoutGroup.RestoreItemControlSize;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].RestoreItemControlSize;
end;

procedure TdxLayoutGroup.SetParentComponent(Value: TComponent);
var
  AIntf: IdxLayoutItemsHelper;
begin
  if Supports(Value, IdxLayoutItemsHelper, AIntf) and
    not AIntf.GetRoot.IsLoading and
    not (csAncestor in ComponentState) then
    AIntf.SetRootGroup(Self)
  else
    inherited;
end;

function CompareItemsByLoadedIndex(AItem1, AItem2: Pointer): Integer;
begin
  Result := TdxCustomLayoutItem(AItem1).FLoadedIndex - TdxCustomLayoutItem(AItem2).FLoadedIndex;
  if Result = 0 then
    Result := TdxCustomLayoutItem(AItem1).Index - TdxCustomLayoutItem(AItem2).Index;
end;

procedure TdxLayoutGroup.CheckIndex;
var
  I: Integer;
begin
  inherited;
  FItems.Sort(CompareItemsByLoadedIndex);
  TabbedOptions.CheckTabs;
  for I := 0 to Count - 1 do
    Items[I].CheckIndex;
end;

procedure TdxLayoutGroup.PopulateItems(AList: TList);
var
  I: Integer;
begin
  inherited;
  for I := 0 to Count - 1 do
    Items[I].PopulateItems(AList);
end;

procedure TdxLayoutGroup.BeforeCalculateViewInfo;
var
  I: Integer;
begin
  BuildVisibleItemsList;
  for I := 0 to Count - 1 do
    Items[I].BeforeCalculateViewInfo;
end;

procedure TdxLayoutGroup.AfterCalculateViewInfo;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].AfterCalculateViewInfo;
  inherited;
end;

procedure TdxLayoutGroup.ApplyCalculatedChanges;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].ApplyCalculatedChanges;
  inherited;
end;

function TdxLayoutGroup.GetOptions: TdxCustomLayoutLookAndFeelOptions;
begin
  Result := GetLayoutLookAndFeel.GroupOptions;
end;

function TdxLayoutGroup.IsExpanded: Boolean;
begin
  Result := Expanded;
end;

procedure TdxLayoutGroup.DoCollapsed;
begin
  CallNotify(FOnCollapsed, Self);
end;

procedure TdxLayoutGroup.DoExpanded;
begin
  CallNotify(FOnExpanded, Self);
end;

procedure TdxLayoutGroup.DoTabChanged;
begin
  if not Container.IsCustomization and (LayoutDirection = ldTabbed) then
    CallNotify(FOnTabChanged, Self);
end;

procedure TdxLayoutGroup.BuildVisibleItemsList;
var
  I: Integer;
begin
  FVisibleItems.Clear;
  for I := 0 to Count - 1 do
    if Items[I].GetVisible then
      FVisibleItems.Add(Items[I]);

  TabbedOptions.RefreshTabsVisible;

  if (ItemIndex = dxLayoutPseudoActiveItem) and (VisibleCount > 0) then
    FItemIndex := VisibleItems[0].Index
  else
    if (VisibleCount = 0) and (ItemIndex >= 0) then
      ItemIndex := dxLayoutPseudoActiveItem
    else
      if VisibleCount > 0 then
      begin
        if (ItemIndex > Count - 1) then
          FItemIndex := VisibleItems[VisibleCount - 1].Index;
        while (FItemIndex >= 0) and not Items[ItemIndex].GetVisible do
          Dec(FItemIndex);
      end;
end;

function TdxLayoutGroup.GetMaxChildImageSize: TSize;
var
  I: Integer;
begin
  Result := cxNullSize;
  for I := 0 to VisibleCount - 1 do
    with VisibleItems[I].CaptionOptions.ImageOptions.GetImageSize do
    begin
      Result.cx := Max(Result.cx, cx);
      Result.cy := Max(Result.cy, cy);
    end;
end;

function TdxLayoutGroup.GetHelperClass: TdxLayoutGroupHelperClass;
begin
  case LayoutDirection of
    ldHorizontal: Result := TdxLayoutHorizontalGroupHelper;
    ldVertical: Result := TdxLayoutVerticalGroupHelper;
    ldTabbed: Result := TdxLayoutTabbedGroupHelper;
  else
    raise EdxException.Create('TdxLayoutGroup.GetHelperClass fails');
  end;
end;

function TdxLayoutGroup.CanFocus: Boolean;
begin
  Result := GetEnabled and ActuallyVisible and ViewInfo.Specific.CanFocus;
end;

function TdxLayoutGroup.AllowShowChild(AChild: TdxCustomLayoutItem): Boolean;
begin
  Result := (LayoutDirection <> ldTabbed) or AChild.CanBeAlone;
end;

function TdxLayoutGroup.IsAnyButtonVisible: Boolean;
begin
  Result := ButtonOptions.IsAnyButtonVisible;
end;

procedure TdxLayoutGroup.ChangeItemIndex(AItem: TdxCustomLayoutItem;
  Value: Integer);
begin
  if AItem.Index <> Value then
  begin
    FItems.Move(AItem.Index, Value);
    TabbedOptions.CheckTabs;
    Container.CustomizeFormUpdateList(Self);
    if AItem.GetVisible then
    begin
      BuildVisibleItemsList;
      Changed;
    end;
  end;
end;

procedure TdxLayoutGroup.ChangeItemVisibleIndex(AItem: TdxCustomLayoutItem;
  Value: Integer);
begin
  ChangeItemIndex(AItem, GetItemIndex(Value));
end;

function TdxLayoutGroup.GetItemIndex(AItemVisibleIndex: Integer): Integer;
begin
  if (0 <= AItemVisibleIndex) and (AItemVisibleIndex < VisibleCount) then
    Result := VisibleItems[AItemVisibleIndex].Index
  else
    Result := Count;
end;

function TdxLayoutGroup.IndexOf(AItem: TdxCustomLayoutItem): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

function TdxLayoutGroup.IsSuperfluous: Boolean;

  function IsSameAlign(AItem1, AItem2: TdxCustomLayoutItem): Boolean;
  begin
    Result := (AItem1.AlignHorz = AItem2.AlignHorz) and (AItem1.AlignVert = AItem2.AlignVert);
  end;

begin
  Result := not IsRoot and not Locked and Hidden and
    ((Count = 0) or (Count = 1) and IsSameAlign(Self, Items[0]) or (Parent <> nil) and (Parent.Count = 1) and IsSameAlign(Self, Parent));
end;

function TdxLayoutGroup.VisibleIndexOf(AItem: TdxCustomLayoutItem): Integer;
begin
  Result := FVisibleItems.IndexOf(AItem);
end;

function TdxLayoutGroup.CreateGroup(AGroupClass: TdxLayoutGroupClass = nil): TdxLayoutGroup;
begin
  Result := Container.CreateGroup(AGroupClass, Self);
end;

function TdxLayoutGroup.CreateItem(AItemClass: TdxCustomLayoutItemClass = nil): TdxCustomLayoutItem;
begin
  Result := Container.CreateItem(AItemClass, Self);
end;

function TdxLayoutGroup.CreateItemForControl(AControl: TControl): TdxLayoutItem;
begin
  Result := Container.CreateItemForControl(AControl, Self);
end;

function TdxLayoutGroup.CanMoveTo(AParent: TdxCustomLayoutItem): Boolean;
begin
  Result := (AParent = nil) or inherited CanMoveTo(AParent) and not IsChildItem(AParent);
end;

procedure TdxLayoutGroup.MoveChildrenToParent;
var
  AInsertionIndex, I: Integer;
begin
  AInsertionIndex := Index;
  for I := Count - 1 downto 0 do
    Items[I].Move(Parent, AInsertionIndex);
end;

function TdxLayoutGroup.PutChildrenIntoHiddenGroup: TdxLayoutGroup;
var
  I: Integer;
begin
  Result := Container.GetNewHiddenGroup;
  Result.Parent := Self;
  Result.Caption := cxGetResourceString(@sdxLayoutControlNewHiddenGroup);
  Result.LayoutDirection := LayoutDirection;
  for I := Count - 2 downto 0 do
    Items[I].Move(Result, 0);
end;

{ TdxLayoutAlignmentConstraint }

constructor TdxLayoutAlignmentConstraint.Create(AOwner: TComponent);
begin
  inherited;
  CreateItems;
end;

destructor TdxLayoutAlignmentConstraint.Destroy;
begin
  DestroyItems;
  inherited;
end;

function TdxLayoutAlignmentConstraint.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxLayoutAlignmentConstraint.GetItem(Index: Integer): TdxCustomLayoutItem;
begin
  Result := FItems[Index];
end;

procedure TdxLayoutAlignmentConstraint.SetKind(Value: TdxLayoutAlignmentConstraintKind);
begin
  if FKind <> Value then
  begin
    FKind := Value;
    Changed;
  end;
end;

procedure TdxLayoutAlignmentConstraint.CreateItems;
begin
  FItems := TList.Create;
end;

procedure TdxLayoutAlignmentConstraint.DestroyItems;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := Count - 1 downto 0 do
      RemoveItem(Items[I]);
  finally
    EndUpdate;
  end;
  FreeAndNil(FItems);
end;

procedure TdxLayoutAlignmentConstraint.InternalAddItem(AItem: TdxCustomLayoutItem);
begin
  FItems.Add(AItem);
end;

procedure TdxLayoutAlignmentConstraint.InternalRemoveItem(AItem: TdxCustomLayoutItem);
begin
  FItems.Remove(AItem);
  if not (csDestroying in ComponentState) and (Count < 2) then
    Free;
end;

procedure TdxLayoutAlignmentConstraint.SetParentComponent(Value: TComponent);
var
  AContainer: IdxLayoutContainer;
begin
  inherited;
  if Supports(Value, IdxLayoutContainer, AContainer) then
    AContainer.GetContainer.AddAlignmentConstraint(Self);
end;

procedure TdxLayoutAlignmentConstraint.BeginUpdate;
begin
  Container.BeginUpdate;
end;

function TdxLayoutAlignmentConstraint.CanAddItem(AItem: TdxCustomLayoutItem): Boolean;
begin
  Result := (AItem <> nil) and (AItem.Container = Container);
end;

procedure TdxLayoutAlignmentConstraint.Changed;
begin
  Container.LayoutChanged;
end;

procedure TdxLayoutAlignmentConstraint.EndUpdate;
begin
  Container.EndUpdate;
end;

function TdxLayoutAlignmentConstraint.GetParentComponent: TComponent;
begin
  Result := Container.ILayout.GetItemsOwner;
end;

function TdxLayoutAlignmentConstraint.HasParent: Boolean;
begin
  Result := Container.ILayout.GetItemsParent <> nil;
end;

procedure TdxLayoutAlignmentConstraint.AddItem(AItem: TdxCustomLayoutItem);
begin
  if CanAddItem(AItem) then
    AItem.AlignmentConstraint := Self;
end;

procedure TdxLayoutAlignmentConstraint.RemoveItem(AItem: TdxCustomLayoutItem);
begin
  if FItems.IndexOf(AItem) <> -1 then
    AItem.AlignmentConstraint := nil;
end;

{ TdxLayoutContainerFocusedController }

constructor TdxLayoutContainerFocusedController.Create(AContainer: TdxLayoutContainer);
begin
  inherited Create;
  FContainer := AContainer;
  FCurrentTabOrderIndex := -1;
end;

function TdxLayoutContainerFocusedController.SetNextFocusControl(AFocusedControl: TWinControl): Boolean;

  function CheckCurrentTabOrderIndex(AGoForward: Boolean): Boolean;
  var
    AParentForm: TCustomForm;
    AList: TList;
    ACurrentTabOrderIndex: Integer;
    I: Integer;
  begin
    AParentForm := GetParentForm(Container.ItemsParent);
    if TWinControlAccess(AParentForm).FindNextControl(AFocusedControl, AGoForward, True, False) = Container.ItemsParent then
    begin
      AList := TList.Create;
      try
        AParentForm.GetTabOrderList(AList);
        I := AList.IndexOf(Container.ItemsParent);
        if I > AList.IndexOf(AFocusedControl) then
          CurrentTabOrderIndex := 0
        else
        begin
          ACurrentTabOrderIndex := -1;
          while (I < AList.Count) and (AList[I] <> AFocusedControl) do
          begin
            if AList[I] = Container.ItemsParent then
              Inc(ACurrentTabOrderIndex);
            Inc(I);
          end;
          if AGoForward then
            Inc(ACurrentTabOrderIndex);
          CurrentTabOrderIndex := ACurrentTabOrderIndex;
        end;
      finally
        AList.Free;
      end;
    end;
    Result := CurrentTabOrderIndex <> -1;
    if Result then
      Container.ItemsParent.SetFocus;
  end;

var
  AGoForward: Boolean;
  ANextControl: TWinControl;
  AIndex: Integer;
begin
  AGoForward := GetKeyState(VK_SHIFT) >= 0;
  if AFocusedControl = Container.ItemsParent then
  begin
    Result := (GetMaxTabOrderIndex > -1) and (AGoForward or (FCurrentTabOrderIndex > -1));
    if Result then
    begin
      ANextControl := FindNextFocusControl(AFocusedControl, AGoForward, AIndex);
      Result := ANextControl <> nil;
      if Result then
        if ANextControl = Container.ItemsParent then
        begin
          if AGoForward then
            CurrentTabOrderIndex := CurrentTabOrderIndex + 1
          else
            CurrentTabOrderIndex := CurrentTabOrderIndex - 1;
          Result := CurrentTabOrderIndex <> -1;
        end
        else
        begin
          CurrentTabOrderIndex := -1;
          ANextControl.SetFocus;
        end;
    end;
  end
  else
    Result := CheckCurrentTabOrderIndex(AGoForward);
end;

function TdxLayoutContainerFocusedController.LayoutIndexOf(AList: TList; ACurrentIndex: Integer): Integer;
var
  I: Integer;
  AStartIndex: Integer;
begin
  AStartIndex := AList.IndexOf(Container.ItemsParent);
  I := 0;
  for Result := AStartIndex to AList.Count - 1 do
    if AList[Result] = Container.ItemsParent then
    begin
      if I = ACurrentIndex then
        Break;
      Inc(I);
    end;
end;

function TdxLayoutContainerFocusedController.GetFocusedItem: TdxCustomLayoutItem;
var
  I: Integer;
begin
  Result := nil;
  if CurrentTabOrderIndex <> -1 then
  begin
    if Container.Root.IsFocused then
      Result := Container.Root;
    if Result = nil then
      for I := 0 to Container.AbsoluteItemCount - 1 do
        if Container.AbsoluteItems[I].IsFocused then
        begin
          Result := Container.AbsoluteItems[I];
          Break;
        end;
  end;
end;

function TdxLayoutContainerFocusedController.GetMaxTabOrderIndex: Integer;
begin
  Result := Container.GetMaxTabOrderIndex;
end;

function TdxLayoutContainerFocusedController.FindNextFocusControl(ACurControl: TWinControl;
  AGoForward: Boolean; out AIndex: Integer): TWinControl;

  function GetStartIndex(AList: TList): Integer;
  var
    AChildren: TList;
  begin
    Result := -1;
    if ACurControl <> Container.ItemsParent then
      Result := AList.IndexOf(ACurControl);
    if Result = -1 then
    begin
      if CurrentTabOrderIndex <> -1 then
        Result := LayoutIndexOf(AList, FCurrentTabOrderIndex)
      else
      begin
        AChildren := TList.Create;
        try
          Container.ItemsParent.GetTabOrderList(AChildren);
          if AChildren.Count > 0 then
          begin
            Result := AList.IndexOf(AChildren[0]);
            if Result >= 0 then
              Dec(Result);
          end
          else
            Result := -1;
        finally
          AChildren.Free;
        end;
      end;
    end;
  end;

var
  I, AStartIndex: Integer;
  AList: TList;
  AParentForm: TCustomForm;
begin
  Result := nil;
  AList := TList.Create;
  try
    AParentForm := GetParentForm(Container.ItemsParent);
    AParentForm.GetTabOrderList(AList);
    if AList.Count > 0 then
    begin
      AStartIndex := GetStartIndex(AList);
      if AStartIndex = -1 then
        if AGoForward then
          AStartIndex := AList.Count - 1
        else
          AStartIndex := 0;

      I := AStartIndex;
      repeat
        if AGoForward then
        begin
          Inc(I);
          if I = AList.Count then I := 0;
        end
        else
        begin
          if I = 0 then I := AList.Count;
          Dec(I);
        end;
        Result := AList[I];
        if not Result.CanFocus then
          Result := nil;
      until (Result <> nil) or (I = AStartIndex);
      AIndex := I;
    end;
  finally
    AList.Free;
  end;
end;

function TdxLayoutContainerFocusedController.IsFocused(AItem: TdxCustomLayoutItem): Boolean;
begin
  Result := Container.ItemsParent.Focused and not Container.IsCustomization and AItem.CanFocus and
    (AItem.ViewInfo <> nil) and (AItem.ViewInfo.TabOrderIndex = CurrentTabOrderIndex);
end;

procedure TdxLayoutContainerFocusedController.SetFocus;
var
  AGoForward: Boolean;
begin
  if (CurrentTabOrderIndex = -1) and (GetMaxTabOrderIndex > -1) and
    (GetCaptureControl <> Container.ItemsParent) then
  begin
    AGoForward := GetKeyState(VK_SHIFT) >= 0;
    if AGoForward then
      CurrentTabOrderIndex := 0
    else
      CurrentTabOrderIndex := GetMaxTabOrderIndex;
  end;
end;

procedure TdxLayoutContainerFocusedController.KillFocus;
var
  AParentForm: TCustomForm;
begin
  AParentForm := GetParentForm(Container.ItemsParent);
  if not AParentForm.Active then
    Exit;
  CurrentTabOrderIndex := -1
end;

procedure TdxLayoutContainerFocusedController.SetItemFocus(AItem: TdxCustomLayoutItem);
begin
  CurrentTabOrderIndex := AItem.ViewInfo.TabOrderIndex;
  Container.ItemsParent.SetFocus;
end;

procedure TdxLayoutContainerFocusedController.SetCurrentTabOrderIndex(Value: Integer);
begin
  if FCurrentTabOrderIndex <> Value then
  begin
    FCurrentTabOrderIndex := Value;
    Container.ItemsParent.Invalidate;
  end;
end;

{ TdxLayoutContainer }

constructor TdxLayoutContainer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CreateItems;
  FSelectionHelper := GetSelectionHelperClass.Create(Self);
  FSelectionHelper.AddSelectionChangedListener(Self);
  FUndoRedoManager := TdxUndoRedoManager.Create(Self);
  FFocusedController := GetFocusedControllerClass.Create(Self);

  FCustomizeAvailableItemsViewKind := aivkTree;
  FCustomizeFormClass := TdxLayoutControlCustomizeForm;
  FShowDesignSelectors := True;
  FHighlightRoot := True;
  FMenuItems := dxDefaultLayoutCustomizeFormMenuItems;
end;

destructor TdxLayoutContainer.Destroy;
begin
  FreeAndNil(FFocusedController);
  FreeAndNil(FUndoRedoManager);
  FSelectionHelper.RemoveSelectionChangedListener(Self);
  FSelectionHelper := nil;
  DestroyItems;
  inherited Destroy;
end;

function TdxLayoutContainer.CloneItem(AItem: TdxCustomLayoutItem; AParent: TdxLayoutGroup = nil): TdxCustomLayoutItem;
begin
  if AItem = nil then
    Result := nil
  else
  begin
    Result := CreateItem(TdxCustomLayoutItemClass(AItem.ClassType), AParent);
    Result.Assign(AItem);
  end;
end;

function TdxLayoutContainer.CreateAlignmentConstraint: TdxLayoutAlignmentConstraint;
begin
  Result := GetAlignmentConstraintClass.Create(ILayout.GetItemsOwner);
  AddAlignmentConstraint(Result);
end;

procedure TdxLayoutContainer.BeginUpdate;
begin
  Inc(FUpdateLockCount);
end;

procedure TdxLayoutContainer.CancelUpdate;
begin
  Dec(FUpdateLockCount);
end;

procedure TdxLayoutContainer.EndUpdate(ANeedPack: Boolean = True);
begin
  Dec(FUpdateLockCount);
  LayoutChanged(ANeedPack);
end;

procedure TdxLayoutContainer.BeginDragAndDrop;
var
  AIntf: IdxLayoutDragAndDropHelper;
begin
  if Supports(Owner, IdxLayoutDragAndDropHelper, AIntf) then
    AIntf.BeginDragAndDrop;
end;

function TdxLayoutContainer.CanDragAndDrop: Boolean;
var
  AIntf: IdxLayoutDragAndDropHelper;
begin
  Result := Supports(Owner, IdxLayoutDragAndDropHelper, AIntf) and AIntf.CanDragAndDrop;
end;

procedure TdxLayoutContainer.FinishDragAndDrop(Accepted: Boolean);
var
  AIntf: IdxLayoutDragAndDropHelper;
begin
  if Supports(Owner, IdxLayoutDragAndDropHelper, AIntf) then
    AIntf.FinishDragAndDrop(Accepted);
end;

function TdxLayoutContainer.GetHitTest: TdxCustomLayoutHitTest;
begin
  if ItemsParent = nil then
    Result := TdxLayoutNoneHitTest.Instance
  else
    Result := GetHitTest(ScreenToClient(GetMouseCursorPos));
end;

function TdxLayoutContainer.GetHitTest(const P: TPoint): TdxCustomLayoutHitTest;

  function InternalGetParentForm(AControl: TWinControl): TCustomForm;
  var
    AWnd: HWND;
    AParent: TWinControl;
  begin
    Result := nil;
    if (AControl = nil) then
      Exit;
    AWnd := AControl.Handle;
    repeat
      AWnd := GetAncestor(AWnd, GA_PARENT);
      AParent := FindControl(AWnd);
      if (AParent <> nil) and (AParent is TCustomForm) then
        Result := TCustomForm(AParent);
    until (Result <> nil) or (AWnd = 0);
  end;

  function IsCustomizeFormHitTest(const AScreenPos: TPoint;
    var AHitCustomizeForm: TdxLayoutControlCustomCustomizeForm; out AClientPos: TPoint): Boolean;

    function Check(AControl: TWinControl): Boolean;
    begin
      Result := (AControl <> nil) and (AControl is TdxLayoutControlCustomCustomizeForm);
      if Result then
      begin
        AHitCustomizeForm := AControl as TdxLayoutControlCustomCustomizeForm;
        if not IsDesigning then
          Result := AHitCustomizeForm.Container = Self;
      end;
      if Result then
        AClientPos := AControl.ScreenToClient(AScreenPos);
    end;

  var
    AWnd: HWND;
    AControl: TWinControl;
  begin
    AWnd := cxWindowFromPoint(AScreenPos);
    AControl := FindControl(AWnd);
    AClientPos := cxInvalidPoint;
    Result := Check(AControl) or Check(InternalGetParentForm(AControl));
  end;

var
   ACustomizeForm: TdxLayoutControlCustomCustomizeForm;
  AClientPos: TPoint;
begin
  Result := nil;
  if IsCustomizeFormHitTest(ClientToScreen(P), ACustomizeForm, AClientPos) then
    Result := ACustomizeForm.GetHitTest(AClientPos);
  if Result = nil then
    Result := ViewInfo.GetHitTest(P);
end;

function TdxLayoutContainer.GetHitTest(X, Y: Integer): TdxCustomLayoutHitTest;
begin
  Result := GetHitTest(Point(X, Y));
end;

function TdxLayoutContainer.ClientToScreen(const Point: TPoint): TPoint;
begin
  if ItemsParent = nil then
    Result := Point
  else
    Result := ItemsParent.ClientToScreen(Point);
end;

function TdxLayoutContainer.ScreenToClient(const Point: TPoint): TPoint;
begin
  if ItemsParent = nil then
    Result := Point
  else
    Result := ItemsParent.ScreenToClient(Point);
end;

procedure TdxLayoutContainer.GetTabOrderList(List: TList);
begin
  if IsCustomization then
    Exit;
  Root.GetTabOrderList(List);
end;

procedure TdxLayoutContainer.CancelLastUndo;
begin
  if ([csLoading, csReading, csDestroying] * ComponentState = []) and not IsUpdateLocked then
    UndoRedoManager.CancelLastUndo;
  CustomizeFormPostUpdate([cfutView]);
end;

procedure TdxLayoutContainer.SaveToUndo;
begin
  if ([csLoading, csReading, csDestroying] * ComponentState = []) and not IsUpdateLocked then
    UndoRedoManager.SaveLayout;
  CustomizeFormPostUpdate([cfutView]);
end;

procedure TdxLayoutContainer.DoEnter;
begin
//do nothing
end;

procedure TdxLayoutContainer.DoExit;
begin
  RenamingItem := nil;
end;

procedure TdxLayoutContainer.CustomizeFormUpdate(AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes);
begin
  if not Customization or (csDestroying in CustomizeForm.ComponentState) then
    Exit;
  FCustomizeFormUpdateTypes := FCustomizeFormUpdateTypes + AUpdateTypes;
  if IsUpdateLocked then
    Exit;
  if cfutCaption in FCustomizeFormUpdateTypes then
    CustomizeForm.UpdateCaption;
  if [cfutAvailableItems, cfutVisibleItems] * FCustomizeFormUpdateTypes = [cfutAvailableItems, cfutVisibleItems] then
    CustomizeForm.UpdateContent
  else
  begin
    if cfutAvailableItems in FCustomizeFormUpdateTypes then
      CustomizeForm.UpdateAvailableItems;
    if cfutVisibleItems in FCustomizeFormUpdateTypes then
      CustomizeForm.UpdateVisibleItems;
  end;
  if FCustomizeFormUpdateTypes * [cfutSelection, cfutAvailableItems, cfutVisibleItems] <> [] then
    CustomizeForm.UpdateSelection;
  if cfutView in FCustomizeFormUpdateTypes then
    CustomizeForm.UpdateView;
  if cfutDragAndDropState in FCustomizeFormUpdateTypes then
    CustomizeForm.UpdateDragAndDropState;
  FCustomizeFormUpdateTypes := [];
end;

procedure TdxLayoutContainer.CheckItemNames(const AOldName, ANewName: string);

  function GetItem(ACaller: TComponent; Index: Integer): TComponent;
  begin
    if Index = 0 then
      Result := TdxLayoutContainer(ACaller).Root
    else
      Result := TdxLayoutContainer(ACaller).AbsoluteItems[Index - 1];
  end;

  function GetAlignmentConstraint(ACaller: TComponent; Index: Integer): TComponent;
  begin
    Result := TdxLayoutContainer(ACaller).AlignmentConstraints[Index];
  end;

begin
  RenameComponents(Self, ILayout.GetItemsParentComponent.Owner, ANewName, AOldName, 1 + AbsoluteItemCount, @GetItem);
  RenameComponents(Self, ILayout.GetItemsParentComponent.Owner, ANewName, AOldName,  AlignmentConstraintCount, @GetAlignmentConstraint);
  CustomizeFormPostUpdate([cfutCaption]);
end;

procedure TdxLayoutContainer.InvalidateRect(const R: TRect; EraseBackground: Boolean);
begin
  if ItemsParent <> nil then
    ItemsParent.InvalidateRect(R, EraseBackground);
end;

{$IFNDEF DELPHI12}
  procedure TdxLayoutContainer.GetChildren(Proc: TGetChildProc; Root: TComponent);
  begin
    inherited;
    if Owner = Root then
      StoreChildren(Proc);
  end;
{$ENDIF}

procedure TdxLayoutContainer.Loaded;
begin
  inherited;
  CheckIndexes;
end;

procedure TdxLayoutContainer.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FPattern then
    begin
      FPattern := nil;
      for I := 0 to AbsoluteItemCount - 1 do
        AbsoluteItems[I].Data := nil;
    end;
    if AComponent = Root then
    begin
      DestroyHandlers;
      FRoot := nil;
      if not IsDestroying then
        CreateRootGroup;
    end;
  end;
end;

procedure TdxLayoutContainer.ToggleHotTrackState(AItem: TdxCustomLayoutItem);
begin
  if CustomizeForm <> nil then
    CustomizeForm.ToggleHotTrackState(AItem);
end;

function TdxLayoutContainer.ShowHint(var AHintInfo: THintInfo; X, Y: Integer): Boolean;
begin
  Result := ViewInfo.ShowHint(AHintInfo, X, Y);
end;

procedure TdxLayoutContainer.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ViewInfo.MouseDown(Button, Shift, X, Y);
end;

procedure TdxLayoutContainer.MouseLeave(AControl: TControl);
begin
  ViewInfo.MouseLeave(AControl);
end;

procedure TdxLayoutContainer.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  ViewInfo.MouseMove(Shift, X, Y);
end;

procedure TdxLayoutContainer.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ViewInfo.MouseUp(Button, Shift, X, Y);
end;

function TdxLayoutContainer.GetViewInfoClass: TdxLayoutContainerViewInfoClass;
begin
  Result := TdxLayoutContainerViewInfo;
end;

function TdxLayoutContainer.CalculateCustomizeFormBounds(const AFormBounds: TRect): TRect;
var
  AControlBounds, ADesktopBounds: TRect;
begin
  AControlBounds := ItemsParent.BoundsRect;
  MapWindowPoints(ItemsParent.Parent.Handle, 0, AControlBounds, 2);
  ADesktopBounds := GetDesktopWorkArea(AControlBounds.TopLeft);
  Result := AFormBounds;
  with AControlBounds do
  begin
    if (ADesktopBounds.Right - Right >= Result.Right - Result.Left) or
      (ADesktopBounds.Right - Right >= Left - ADesktopBounds.Left)
    then
      OffsetRect(Result, Right - Result.Left, 0)
    else
      OffsetRect(Result, Left - Result.Right, 0);
    OffsetRect(Result, 0, (Top + Bottom - (Result.Bottom - Result.Top)) div 2 - Result.Top);
  end;
  with ADesktopBounds do
  begin
    if Result.Left < Left then
      OffsetRect(Result, Left - Result.Left, 0);
    if Result.Right > Right then
      OffsetRect(Result, Right - Result.Right, 0);
    if Result.Top < Top then
      OffsetRect(Result, 0, Top - Result.Top);
  end;
end;

procedure TdxLayoutContainer.CreateCustomizeForm;
begin
  FCustomizeForm := CustomizeFormClass.Create(nil);
  FCustomizeForm.Container := Self;
end;

function TdxLayoutContainer.GetCustomizeForm: TdxLayoutControlCustomCustomizeForm;
begin
  Result := FCustomizeForm;
end;

procedure TdxLayoutContainer.DestroyCustomizeForm;
begin
  with FCustomizeForm do
  begin
    if not (csDestroying in ComponentState) then
      Free;
  end;
end;

procedure TdxLayoutContainer.ShowCustomizeForm;
begin
  CustomizeForm.Show;
end;

function TdxLayoutContainer.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := ViewInfo.CanFocusOnClick(X, Y);
end;

function TdxLayoutContainer.IsChildKey(ACharCode: Word): Boolean;
begin
  Result := (ACharCode = VK_TAB) and (GetKeyState(VK_CONTROL) >= 0);
end;

procedure TdxLayoutContainer.KeyDown(var Key: Word; Shift: TShiftState);
var
  AItem: TdxCustomLayoutItem;
begin
  if not IsCustomization and (FocusedController.CurrentTabOrderIndex <> - 1) then
  begin
    AItem := FocusedController.GetFocusedItem;
    if AItem <> nil then
      AItem.KeyDown(Key, Shift);
  end;
  if (Key = VK_ESCAPE) and (Shift * [ssCtrl, ssAlt, ssShift] = []) then
    SelectItemParent;
end;

function TdxLayoutContainer.GetAlignmentConstraintClass: TdxLayoutAlignmentConstraintClass;
begin
  Result := TdxLayoutAlignmentConstraint;
end;

function TdxLayoutContainer.GetDefaultGroupClass: TdxLayoutGroupClass;
begin
  Result := TdxLayoutGroup;
end;

function TdxLayoutContainer.GetDefaultItemClass: TdxLayoutItemClass;
begin
  Result := TdxLayoutItem;
end;

function TdxLayoutContainer.GetDefaultRootGroupClass: TdxLayoutGroupClass;
begin
  Result := GetDefaultGroupClass;
end;

function TdxLayoutContainer.GetFocusedControllerClass: TdxLayoutContainerFocusedControllerClass;
begin
  Result := TdxLayoutContainerFocusedController;
end;

function TdxLayoutContainer.GetLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := ILayout.GetLayoutLookAndFeel;
end;

function TdxLayoutContainer.GetPainterClass: TdxLayoutContainerPainterClass;
begin
  Result := TdxLayoutContainerPainter;
end;

function TdxLayoutContainer.GetSelectionHelperClass: TdxLayoutRunTimeSelectionHelperClass;
begin
  Result := ILayout.GetSelectionHelperClass;
  if Result = nil then
    Result := TdxLayoutRunTimeSelectionHelper;
end;

procedure TdxLayoutContainer.CreateHandlers;
begin
  FViewInfo := GetViewInfoClass.Create(Self);
  FPainter := GetPainterClass.Create(FViewInfo); 
end;

procedure TdxLayoutContainer.DestroyHandlers;
begin
  FreeAndNil(FPainter);
  FreeAndNil(FViewInfo);
end;

procedure TdxLayoutContainer.CreateItems;
begin
  FAbsoluteItems := TcxComponentList.Create;
  FAbsoluteItems.OwnsObjects := True;
  FAvailableItems := TcxComponentList.Create;
  FAvailableItems.OwnsObjects := True;
  FAvailableItems.OnComponentListChanged := AvailableItemListChanged;
  FSpecialItems := TcxComponentList.Create;
  FSpecialItems.OwnsObjects := True;
  CreateConstraints;
  CreateRootGroup;
end;

procedure TdxLayoutContainer.DestroyItems;
begin
  DestroyRootGroup;
  DestroyConstraints;
  FreeAndNil(FSpecialItems);
  FreeAndNil(FAvailableItems);
  FreeAndNil(FAbsoluteItems);
end;

procedure TdxLayoutContainer.DoCalculateRoot(ANeedPack: Boolean);

  procedure BeforeCalculateViewInfo;
  var
    I: Integer;
  begin
    Root.BeforeCalculateViewInfo;
    for I := 0 to AvailableItemCount - 1 do
      AvailableItems[I].BeforeCalculateViewInfo;
  end;

  procedure AfterCalculateViewInfo;
  var
    I: Integer;
  begin
    Root.AfterCalculateViewInfo;
    for I := 0 to AvailableItemCount - 1 do
      AvailableItems[I].AfterCalculateViewInfo;
  end;

  procedure ApplyCalculatedChanges;
  var
    I: Integer;
  begin
    Root.ApplyCalculatedChanges;
    for I := 0 to AvailableItemCount - 1 do
      AvailableItems[I].ApplyCalculatedChanges;
  end;

begin
  BeginUpdate;
  try
    if ANeedPack then
      Root.Pack;
    BeforeCalculateViewInfo;
    ViewInfo.Calculate;
    AfterCalculateViewInfo;
  finally
    CancelUpdate;
  end;
  ApplyCalculatedChanges;
end;

procedure TdxLayoutContainer.DoChanged;
begin
  CallNotify(FOnChanged, Self);
end;

procedure TdxLayoutContainer.DoSelectionChanged;
begin
  CallNotify(FOnSelectionChanged, Self);
end;

procedure TdxLayoutContainer.InvalidateWithChildren;
begin
  if ItemsParent <> nil then
    ItemsParent.InvalidateWithChildren;
end;

procedure TdxLayoutContainer.LayoutChanged(ANeedPack: Boolean = True);
begin
  if not (IsDestroying or IsLoading or IsUpdateLocked) and ILayout.CanUpdate then
  begin
    BeginPlaceControls;
    try
      DoCalculateRoot(ANeedPack);
      ILayout.SizeAdjustment;
    finally
      EndPlaceControls;
    end;
    DoChanged;
  end;
end;

procedure TdxLayoutContainer.Modified;
begin
  ILayout.Modified;
end;

procedure TdxLayoutContainer.BuildSelectionLayer;
begin
  if not IsUpdateLocked and (ViewInfo <> nil) then
    ViewInfo.BuildSelectionLayer;
end;

procedure TdxLayoutContainer.CustomizeFormPostUpdate(AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes);
begin
  ILayout.CustomizeFormPostUpdate(AUpdateTypes);
end;

procedure TdxLayoutContainer.CustomizeFormUpdateList(AItem: TdxCustomLayoutItem);
const
  UpdateTypeMap: array[Boolean] of TdxLayoutCustomizeFormUpdateType = (cfutVisibleItems, cfutAvailableItems);
begin
  CustomizeFormPostUpdate([UpdateTypeMap[AItem.IsAvailable]]);
end;

procedure TdxLayoutContainer.InvalidateSelectionLayer(const R: TRect);
begin
  if (ViewInfo <> nil) and (ViewInfo.SelectionLayer <> nil) then
    ViewInfo.SelectionLayer.InvalidateRect(R);
end;

function TdxLayoutContainer.IsCustomization: Boolean;
begin
  Result := Customization or IsDesigning;
end;

procedure TdxLayoutContainer.PostBuildSelectionLayer;
begin
  ILayout.PostBuildSelectionLayer;
end;

procedure TdxLayoutContainer.PostInvalidateSelectionLayer(const R: TRect);
begin
  ILayout.PostInvalidateSelectionLayer(R);
end;

procedure TdxLayoutContainer.SelectItemParent;
var
  AList: TcxComponentList;
  AIntf: IdxLayoutSelectableItem;
begin
  AList := TcxComponentList.Create;
  try
    GetSelection(AList);
    if (AList.Count > 0) and Supports(AList[0], IdxLayoutSelectableItem, AIntf) then
      AIntf.SelectParent;
  finally
    AList.Free;
  end;
end;

procedure TdxLayoutContainer.BeginRename(AItem: TdxCustomLayoutItem; const ABounds: TRect; const AFont: TFont);
begin
  RenamingItem := AItem;
  ViewInfo.SelectionLayer.BeginRename(ABounds, FRenamingItem.GetInplaceRenameCaption, AFont);
end;

procedure TdxLayoutContainer.CancelRename;
begin
  RenamingItem := nil;
end;

procedure TdxLayoutContainer.EndRename(const AText: string);
begin
  if RenamingItem <> nil then
    RenamingItem.SetInplaceRenameCaption(AText);
  RenamingItem := nil;
end;

procedure TdxLayoutContainer.UpdateItemsCustomization;
var
  I: Integer;
begin
  for I := 0 to AbsoluteItemCount - 1 do
    AbsoluteItems[I].Customization := Customization;
end;

procedure TdxLayoutContainer.PostPlaceControls;
begin
  ILayout.PostPlaceControls;
end;

procedure TdxLayoutContainer.PlaceControls(AItemViewInfo: TdxCustomLayoutItemViewInfo = nil);
begin
  if FPlaceControlsLockCount > 0 then
    FIsPlaceControlsNeeded := True
  else
  begin
    if AItemViewInfo <> nil then
      Painter.PlaceControls(AItemViewInfo)
    else
      if IsDesigning then
        PostPlaceControls
      else
        Painter.PlaceControls(ViewInfo.ItemsViewInfo);
  end;
end;

procedure TdxLayoutContainer.BeginPlaceControls;
begin
  Inc(FPlaceControlsLockCount);
end;

procedure TdxLayoutContainer.CancelPlaceControls;
begin
  Dec(FPlaceControlsLockCount);
  FIsPlaceControlsNeeded := False;
end;

procedure TdxLayoutContainer.EndPlaceControls;
begin
  Dec(FPlaceControlsLockCount);
  if (FPlaceControlsLockCount = 0) and FIsPlaceControlsNeeded then
    PlaceControls;
end;

function TdxLayoutContainer.IsPlacingControls: Boolean;
begin
  Result := FIsPlacingControls;
end;

procedure TdxLayoutContainer.PrepareControl(AControl: TControl);
begin
  AControl.Parent := ILayout.GetItemsParent;
end;

procedure TdxLayoutContainer.UnprepareControl(AControl: TControl);

    function GetControlWithTopPos(AWinControl: TWinControl; APos: Integer): Integer;
    var
      I: Integer;
    begin
      Result := -1;
      for I := 0 to AWinControl.ControlCount - 1 do
        if AWinControl.Controls[I].Top = APos then
        begin
          Result := I;
          Break
        end;
    end;

    function GetFreeTopPos(AWinControl: TWinControl): Integer;
    var
      Aindex: Integer;
    begin
      Result := 0;
      repeat
        AIndex := GetControlWithTopPos(AWinControl, Result);
        if AIndex > -1 then
          Result := AWinControl.Controls[AIndex].Top + cxGetValueCurrentDPI(21, False) + 1;
      until AIndex = -1
    end;

    function GetAllowedParent(var AParent: TWinControl): Boolean;
    begin
      Result := (AParent <> nil);
      if Result then
      begin
        if csDestroying in AParent.ComponentState then
        begin
          AParent := AParent.Parent;
          Result := GetAllowedParent(AParent);
        end;
      end;
    end;

var
  AParent: TWinControl;
begin
  AParent := ILayout.GetItemsParent.Parent;
  if IsDesigning and not (csDestroying in AControl.ComponentState) and GetAllowedParent(AParent) then
  begin
    AControl.Parent := AParent;
    AControl.Left := 0;
    AControl.Top := GetFreeTopPos(AParent);
  end;
end;

procedure TdxLayoutContainer.StartPlacingControls;
begin
  FIsPlacingControls := True;
end;

procedure TdxLayoutContainer.StopPlacingControls;
begin
  FIsPlacingControls := False;
end;

function TdxLayoutContainer.IsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TdxLayoutContainer.IsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TdxLayoutContainer.IsLayoutLoading: Boolean;
begin
  Result := FLoadingCount > 0;
end;

function TdxLayoutContainer.IsLoading: Boolean;
begin
  Result := (csLoading in ComponentState) or (ILayout.GetItemsParentComponent <> nil) and
    (csLoading in ILayout.GetItemsParentComponent.ComponentState);
end;

function TdxLayoutContainer.IsUpdateLocked: Boolean;
begin
  Result := FUpdateLockCount > 0;
end;

procedure TdxLayoutContainer.Update;
begin
  if ItemsParent <> nil then
    ItemsParent.Update;
end;

procedure TdxLayoutContainer.CheckIndexes;
var
  I: Integer;
begin
  Root.CheckIndex;
  for I := 0 to AvailableItemCount - 1 do
    AvailableItems[I].CheckIndex;
end;

function TdxLayoutContainer.GetRootSectionName(AIniFile: TCustomIniFile): string;
begin
  if AIniFile.SectionExists(Owner.Name) then
    Result := Owner.Name
  else
    Result := '';
end;

type
  PdxLayoutItemPosition = ^TdxLayoutItemPosition;
  TdxLayoutItemPosition = record
    Item: TdxCustomLayoutItem;
    ParentName: string;
    Index: Integer;
  end;

function ComparePositions(Item1, Item2: Pointer): Integer;
begin
  Result := PdxLayoutItemPosition(Item1).Index - PdxLayoutItemPosition(Item2).Index;
end;

procedure TdxLayoutContainer.InternalLoadFromCustomIniFile(AIniFile: TCustomIniFile; ADestroyNonLoadedItems: Boolean);
var
  AItems, ASuperfluousItems: TObjectList;
  APositions: TList;
  AItemCount, I: Integer;
  ARootSection: string;
  AVersion: Integer;

  procedure CreateAuxiliaryItemsLists;
  begin
    AItems := TObjectList.Create(False);
    if ADestroyNonLoadedItems then
      AItems.Assign(FAbsoluteItems);

    ASuperfluousItems := TObjectList.Create;
  end;

  procedure DestroyAuxiliaryItemsLists;
  begin
    AItems.Free;
    ASuperfluousItems.Free;
  end;

  procedure PrepareItems;
  var
    I: Integer;
  begin
    for I := 0 to AbsoluteItemCount - 1 do
      AbsoluteItems[I].Parent := nil;
  end;

  function GetItemSection(AIndex: Integer): string;
  begin
    Result := 'Item' + IntToStr(AIndex);
    if ARootSection <> '' then
      Result := ARootSection + '\' + Result;
  end;

  procedure AddPosition(AItem: TdxCustomLayoutItem; const AParentName: string;
    AIndex: Integer);
  var
    APosition: PdxLayoutItemPosition;
  begin
    New(APosition);
    with APosition^ do
    begin
      Item := AItem;
      ParentName := AParentName;
      Index := AIndex;
    end;
    APositions.Add(APosition);
  end;

  procedure LoadItem(const ASection: string);

    function GetItemClass(AItemClassKind: Integer): TdxCustomLayoutItemClass;
    const
      AClasses: array[0..5] of TdxCustomLayoutItemClass = (TdxLayoutItem, TdxLayoutGroup, TdxLayoutEmptySpaceItem, TdxLayoutSeparatorItem,
        TdxLayoutSplitterItem, TdxLayoutLabeledItem);
    var
      I: Integer;
    begin
      Result := TdxLayoutGroup;
      for I := Low(AClasses) to High(AClasses) do
        if AClasses[I].GetItemClassKind = AItemClassKind then
        begin
          Result := AClasses[I];
          Break;
        end;
    end;

  var
    AName, AParentName: string;
    AItem: TdxCustomLayoutItem;
    AIndex: Integer;
    AIsUserDefined: Boolean;
    AItemClassKind: Integer;
  begin
    AName := AIniFile.ReadString(ASection, 'Name', '');
    if AName = '' then Exit;

    AItem := FindItem(AName);
    if AItem = nil then
    begin
      AIsUserDefined := AIniFile.ReadBool(ASection, 'IsUserDefined', True);
      AItemClassKind := AIniFile.ReadInteger(ASection, 'ItemClassKind', TdxLayoutGroup.GetItemClassKind);
      AItem := CreateItem(GetItemClass(AItemClassKind));
      AItem.Name := AName;
      if not AIsUserDefined or ((AVersion < 3) and (AItemClassKind = 0)) then
        ASuperfluousItems.Add(AItem);
    end
    else
      AItems.Remove(AItem);

    AParentName := AIniFile.ReadString(ASection, 'ParentName', '');
    AIndex := AIniFile.ReadInteger(ASection, 'Index', -1);
    AddPosition(AItem, AParentName, AIndex);

    AItem.LoadFromIni(AIniFile, ASection, AVersion);
  end;

  procedure DestroyUselessItems;
  var
    I: Integer;
  begin
    for I := 0 to AItems.Count - 1 do
      if TdxCustomLayoutItem(AItems[I]).CanDelete then
        AItems[I].Free;
        
    ASuperfluousItems.Clear;
  end;

  procedure UpdatePositions;
  var
    I: Integer;
    APosition: PdxLayoutItemPosition;
  begin
    APositions.Sort(ComparePositions);
    for I := 0 to APositions.Count - 1 do
    begin
      APosition := PdxLayoutItemPosition(APositions[I]);
      APosition.Item.Parent := FindItem(APosition.ParentName) as TdxLayoutGroup;
      APosition.Item.Index := APosition.Index;
    end;
  end;

begin
  CreateAuxiliaryItemsLists;
  APositions := TList.Create;
  try
    ARootSection := GetRootSectionName(AIniFile);
    AVersion := AIniFile.ReadInteger(ARootSection, 'Version', 1);
    AItemCount := AIniFile.ReadInteger(ARootSection, 'ItemCount', -1);
    if AItemCount = -1 then Exit;
    BeginUpdate;
    Inc(FLoadingCount);
    try
      PrepareItems;
      for I := 0 to AItemCount - 1 do
        LoadItem(GetItemSection(I));
      UpdatePositions;
      DestroyUselessItems;
    finally
      Dec(FLoadingCount);
      EndUpdate;
    end;
  finally
    for I := 0 to APositions.Count - 1 do
      Dispose(PdxLayoutItemPosition(APositions[I]));
    APositions.Free;
    DestroyAuxiliaryItemsLists;
  end;
end;

function CompareItems(Item1, Item2: Pointer): Integer;

  function GetLevel(AItem: TdxCustomLayoutItem): Integer;
  begin
    if AItem.Parent <> nil then
      Result := GetLevel(AItem.Parent) + 1
    else
      Result := 0;
  end;

var
  AItem1, AItem2: TdxCustomLayoutItem;
begin
  AItem1 := TdxCustomLayoutItem(Item1);
  AItem2 := TdxCustomLayoutItem(Item2);
  Result := GetLevel(AItem1) - GetLevel(AItem2);
  if Result = 0 then
    if (AItem1.Parent = AItem2.Parent) and (AItem1.Parent <> nil) then
      Result := AItem1.Index - AItem2.Index
    else
      Result := Integer(AItem1.Parent = nil) - Integer(AItem2.Parent = nil);

  if (Result = 0) and (AItem1.Parent <> nil) then
    Result := CompareItems(AItem1.Parent, AItem2.Parent);

  if Result = 0 then
    Result := Ord(AItem2.IsUserDefined) - Ord(AItem1.IsUserDefined);
  if Result = 0 then
    Result := Integer(Item1) - Integer(Item2);
end;

procedure TdxLayoutContainer.InternalSaveToCustomIniFile(AIniFile: TCustomIniFile);
var
  AItems: TList;
  I: Integer;
  ARootSection: string;

  function CreateItemsList: TList;
  begin
    Result := TList.Create;
    Result.Assign(FAbsoluteItems);
    Result.Sort(CompareItems);
    Result.Insert(0, Root);
  end;

  function GetItemSection(AIndex: Integer): string;
  begin
    Result := 'Item' + IntToStr(AIndex);
    if ARootSection <> '' then
      Result := ARootSection + '\' + Result;
  end;

  procedure DeletePrevSettings;
  var
    ABaseSectionName: string;
    ASections: TStringList;
    I: Integer;
  begin
    ABaseSectionName := ARootSection;
    if ABaseSectionName <> '' then
      ABaseSectionName := ABaseSectionName + '\';
    ASections := TStringList.Create;
    try
      AIniFile.ReadSections(ASections);
      for I := 0 to ASections.Count - 1 do
        if Copy(ASections[I], 1, Length(ABaseSectionName)) = ABaseSectionName then
          AIniFile.EraseSection(ASections[I]);
    finally
      ASections.Free;
    end;
  end;

  procedure SaveItem(const ASection: string; AItem: TdxCustomLayoutItem);
  begin
    AItem.SaveToIni(AIniFile, ASection);
  end;

begin
  ARootSection := Owner.Name;
  DeletePrevSettings;
  AItems := CreateItemsList;
  try
    AIniFile.WriteInteger(ARootSection, 'Version', dxLayoutVersion);
    AIniFile.WriteInteger(ARootSection, 'ItemCount', AItems.Count);
    for I := 0 to AItems.Count - 1 do
      SaveItem(GetItemSection(I), AItems[I]);
  finally
    AItems.Free;
  end;
end;

procedure TdxLayoutContainer.StoreChildren(Proc: TGetChildProc);
var
  AList: TComponentList;
  I: Integer;
begin
  AList := TComponentList.Create(False);
  try
    Proc(Root);
    for I := 0 to AbsoluteItemCount - 1 do
      Proc(AbsoluteItems[I]);
  finally
    AList.Free;
  end;
  for I := 0 to AlignmentConstraintCount - 1 do
    Proc(AlignmentConstraints[I]);
end;

procedure TdxLayoutContainer.AddAbsoluteItem(AItem: TdxCustomLayoutItem);
begin
  FAbsoluteItems.Add(AItem);
end;

procedure TdxLayoutContainer.AddAvailableItem(AItem: TdxCustomLayoutItem);
begin
  FAvailableItems.Add(AItem);
  AItem.Container := Self;
end;

procedure TdxLayoutContainer.DoItemChanged(AItem: TdxCustomLayoutItem);
begin
  if Assigned(FOnItemChanged) then
    FOnItemChanged(AItem);
end;

procedure TdxLayoutContainer.ExtractAbsoluteItem(AItem: TdxCustomLayoutItem);
begin
  FAbsoluteItems.Extract(AItem);
end;

procedure TdxLayoutContainer.ExtractAvailableItem(AItem: TdxCustomLayoutItem);
begin
  FAvailableItems.Extract(AItem);
end;

function TdxLayoutContainer.IsRoot(AItem: TdxCustomLayoutItem): Boolean;
begin
  Result := AItem = Root;
end;

function TdxLayoutContainer.IsSizableHorz: Boolean;
begin
  Result := ILayout.GetIsSizableHorz;
end;

function TdxLayoutContainer.IsSizableVert: Boolean;
begin
  Result := ILayout.GetIsSizableVert;
end;

function TdxLayoutContainer.FindItem(AControl: TControl): TdxLayoutItem;
var
  I: Integer;
  AItem: TdxCustomLayoutItem;
begin
  Result := nil;
  for I := 0 to AbsoluteItemCount - 1 do
  begin
    AItem := AbsoluteItems[I];
    if (AItem is TdxLayoutItem) and (TdxLayoutItem(AItem).Control = AControl) then
    begin
      Result := TdxLayoutItem(AItem);
      Break;
    end;
  end;
end;

function TdxLayoutContainer.FindItem(AControlHandle: THandle): TdxLayoutItem;
var
  I: Integer;
  AItem: TdxCustomLayoutItem;
begin
  Result := nil;
  for I := 0 to AbsoluteItemCount - 1 do
  begin
    AItem := AbsoluteItems[I];
    if (AItem is TdxLayoutItem) and TdxLayoutItem(AItem).HasWinControl and
      TdxLayoutItem(AItem).WinControl.HandleAllocated and
      (TdxLayoutItem(AItem).WinControl.Handle = AControlHandle) then
    begin
      Result := TdxLayoutItem(AItem);
      Break;
    end;
  end;
end;

function TdxLayoutContainer.FindItem(const AName: string): TdxCustomLayoutItem;
var
  I: Integer;
begin
  if AName <> '' then
  begin
    Result := Root;
    if SameText(Result.Name, AName) then Exit;
    for I := 0 to AbsoluteItemCount - 1 do
    begin
      Result := AbsoluteItems[I];
      if SameText(Result.Name, AName) then Exit;
    end;
  end;
  Result := nil;
end;

function TdxLayoutContainer.GetAutoControlTabOrders: Boolean;
begin
  Result := ILayout.GetAutoControlTabOrders;
end;

function TdxLayoutContainer.GetAutoControlAlignment: Boolean;
begin
  Result := ILayout.GetAutoControlAlignment;
end;

function TdxLayoutContainer.GetIsFocusControlOnItemCaptionClick: Boolean;
begin
  Result := ILayout.GetIsFocusControlOnItemCaptionClick;
end;

procedure TdxLayoutContainer.CreateRootGroup;
begin
  SetRootGroup(GetDefaultRootGroupClass.Create(ILayout.GetItemsOwner));
end;

procedure TdxLayoutContainer.DestroyRootGroup;
begin
  SetRootGroup(nil);
end;

procedure TdxLayoutContainer.SelectionChanged(ASelection: TList; AAction: TdxSelectionAction);

  procedure TryMakeVisibleSelection;
  var
    AList: TList;
    AIntf: IdxLayoutSelectableItem;
  begin
    AList := TList.Create;
    try
      GetSelection(AList);
      if (AList.Count > 0) and Supports(TObject(AList.Last), IdxLayoutSelectableItem, AIntf) then
      begin
        AIntf.MakeVisible;
        AIntf := nil;
      end;
    finally
      AList.Free;
    end;
  end;

begin
  RenamingItem := nil;
  if not IsDestroying and (AAction in [saAdded, saChanged]) and not IsUpdateLocked then
  begin
    TryMakeVisibleSelection;
    BuildSelectionLayer;
    CustomizeFormPostUpdate([cfutSelection]);
  end;
  DoSelectionChanged;
end;

procedure TdxLayoutContainer.AddSelectionChangedListener(AListener: TPersistent);
begin
  if (SelectionHelper <> nil) then
    SelectionHelper.AddSelectionChangedListener(AListener);
end;

function TdxLayoutContainer.IsActive: Boolean;
begin
  Result := (SelectionHelper <> nil) and SelectionHelper.IsActive;
end;

function TdxLayoutContainer.CanDeleteComponent(AComponent: TComponent): Boolean;
begin
  Result := (SelectionHelper <> nil) and SelectionHelper.CanDeleteComponent(AComponent);
end;

function TdxLayoutContainer.CanModify: Boolean;
begin
  Result := (SelectionHelper <> nil) and SelectionHelper.CanModify;
end;

function TdxLayoutContainer.CanProcessKeyboard: Boolean;
begin
  Result := ILayout.CanProcessKeyboard;
end;

procedure TdxLayoutContainer.ClearSelection;
begin
  if (SelectionHelper <> nil) then
    SelectionHelper.ClearSelection;
end;

procedure TdxLayoutContainer.DeleteSelection;
begin
  if (SelectionHelper <> nil) then
    SelectionHelper.DeleteSelection;
end;

procedure TdxLayoutContainer.GetSelection(AList: TList);
begin
  if (SelectionHelper <> nil) then
    SelectionHelper.GetSelection(AList);
end;

function TdxLayoutContainer.IsComponentSelected(AComponent: TPersistent): Boolean;
begin
  Result := (SelectionHelper <> nil) and SelectionHelper.IsComponentSelected(AComponent);
end;

procedure TdxLayoutContainer.RemoveSelectionChangedListener(AListener: TPersistent);
begin
  if SelectionHelper <> nil then
    SelectionHelper.RemoveSelectionChangedListener(AListener);
end;

procedure TdxLayoutContainer.SelectComponent(AComponent: TPersistent; AShift: TShiftState = []);
begin
  if SelectionHelper <> nil then
    SelectionHelper.SelectComponent(AComponent, AShift);
end;

procedure TdxLayoutContainer.SetSelection(AList: TList);
begin
  if SelectionHelper <> nil then
    SelectionHelper.SetSelection(AList);
end;

function TdxLayoutContainer.IsEditorMode: Boolean;
begin
  Result := ViewInfo.SelectionLayer.EditorMode;
end;

function TdxLayoutContainer.UniqueName(const BaseName: string): string;
begin
  if SelectionHelper <> nil then
    Result := SelectionHelper.UniqueName(BaseName);
end;

procedure TdxLayoutContainer.SetFocus;
begin
  FocusedController.SetFocus;
end;

function TdxLayoutContainer.GetMaxTabOrderIndex: Integer;
begin
  Result := ViewInfo.ItemsViewInfo.GetMaxTabOrderIndex;
end;

procedure TdxLayoutContainer.KillFocus;
begin
  FocusedController.KillFocus;
end;

procedure TdxLayoutContainer.MakeVisible(AItem: TdxCustomLayoutItem);
begin
  ILayout.MakeVisible(AItem);
end;

procedure TdxLayoutContainer.AssignStructureFromPattern;
var
  I: Integer;
  AItem: TdxCustomLayoutItem;
  AParent: TdxLayoutGroup;

  function FindParent(AParent: TdxLayoutGroup): TdxLayoutGroup;
  var
    I: Integer;
    AItem: TdxCustomLayoutItem;
  begin
    Result := nil;
    for I := 0 to AbsoluteItemCount - 1 do
    begin
      AItem := AbsoluteItems[I];
      if AItem.Data = AParent then
      begin
        Result := TdxLayoutGroup(AItem);
        Break;
      end;
    end;
  end;

begin
  BeginUpdate;
  try
    Clear;
    for I := 0 to FPattern.AbsoluteItemCount - 1 do
    begin
      AItem := CloneItem(FPattern.AbsoluteItems[I]);
      AItem.Data := FPattern.AbsoluteItems[I];
    end;
    for I := 0 to AbsoluteItemCount - 1 do
    begin
      AItem := AbsoluteItems[I];
      AParent := TdxCustomLayoutItem(AItem.Data).Parent;
      if FPattern.AbsoluteItems[I].Parent = nil then Continue;
      if AParent.IsRoot then
        AItem.Parent := Root
      else
        AItem.Parent := FindParent(AParent);
    end;

    for I := 0 to AbsoluteItemCount - 1 do
      AbsoluteItems[I].FLoadedIndex := FPattern.AbsoluteItems[I].Index;
    CheckIndexes;
    
    Root.Assign(FPattern.Root);
  finally
    EndUpdate;
  end;
end;

procedure TdxLayoutContainer.AssignStructureToPattern;
var
  I: Integer;
  AItem: TdxCustomLayoutItem;

  function FindDestinationItem(AItem: TdxCustomLayoutItem): TdxCustomLayoutItem;
  var
    I: Integer;
    ADestinationItem: TdxCustomLayoutItem;
  begin
    Result := nil;
    for I := 0 to FPattern.AbsoluteItemCount - 1 do
    begin
      ADestinationItem := FPattern.AbsoluteItems[I];
      if ADestinationItem = AItem.Data then
      begin
        Result := ADestinationItem;
        Break;
      end;
    end;
  end;

  function FindSourceItem(AItem: TdxCustomLayoutItem): TdxCustomLayoutItem;
  var
    I: Integer;
    ASourceItem: TdxCustomLayoutItem;
  begin
    Result := nil;
    for I := 0 to AbsoluteItemCount - 1 do
    begin
      ASourceItem := AbsoluteItems[I];
      if ASourceItem.Data = AItem then
      begin
        Result := ASourceItem;
        Break;
      end;
    end;
  end;

begin
  FPattern.BeginUpdate;
  try
    for I := 0 to FPattern.AbsoluteItemCount - 1 do
      FPattern.AbsoluteItems[I].Parent := nil;

    for I := 0 to AbsoluteItemCount - 1 do
    begin
      AItem := AbsoluteItems[I];
      if AItem.Data = nil then
      begin
        AItem := FPattern.CloneItem(AbsoluteItems[I]);
        AbsoluteItems[I].Data := AItem;
      end;
    end;

    for I := FPattern.AbsoluteItemCount - 1 downto 0 do
    begin
      AItem := FPattern.AbsoluteItems[I];
      if FindSourceItem(AItem) = nil then
        AItem.Free;
    end;
    for I := 0 to AbsoluteItemCount - 1 do
    begin
      AItem := FindDestinationItem(AbsoluteItems[I]);
      if AbsoluteItems[I].Parent <> nil then
      begin
        if AbsoluteItems[I].Parent.IsRoot then
          AItem.Parent := FPattern.Root
        else
          AItem.Parent := TdxLayoutGroup(FindDestinationItem(AbsoluteItems[I].Parent));
      end;
    end;

    for I := 0 to AbsoluteItemCount - 1 do
    begin
      AItem := FindDestinationItem(AbsoluteItems[I]);
      AItem.Assign(AbsoluteItems[I]);
      AItem.FLoadedIndex := AbsoluteItems[I].Index;
    end;
    FPattern.CheckIndexes;
    FPattern.Root.Assign(Root);
  finally
    FPattern.EndUpdate;
  end;
end;

procedure TdxLayoutContainer.CopyStructure(ASource: TdxLayoutContainer);
begin
  try
    if Self = ASource.FPattern then
    begin
      FAssignLayoutMode := almToParent;
      ASource.AssignStructureToPattern;
    end
    else
    begin
      FAssignLayoutMode := almFromParent;
      FPattern := ASource;
      FPattern.FreeNotification(Self);
      AssignStructureFromPattern;
    end;
  finally
    FAssignLayoutMode := almNone;
  end;
end;

procedure TdxLayoutContainer.Clear;
var
  I: Integer;
  AItem: TdxCustomLayoutItem;
begin
  BeginUpdate;
  try
    for I := AbsoluteItemCount - 1 downto 0 do
    begin
      AItem := AbsoluteItems[I];
      if (AItem is TdxLayoutItem) and (TdxLayoutItem(AItem).Control <> nil) then
        TdxLayoutItem(AItem).Control.Free;
    end;     
    while AbsoluteItemCount <> 0 do
      AbsoluteItems[0].Free;
  finally
    EndUpdate;
  end;
end;

function TdxLayoutContainer.CreateGroup(AGroupClass: TdxLayoutGroupClass = nil; AParent: TdxLayoutGroup = nil): TdxLayoutGroup;
begin
  if AGroupClass = nil then
    AGroupClass := GetDefaultGroupClass;
  Result := TdxLayoutGroup(CreateItem(AGroupClass, AParent));
end;

function TdxLayoutContainer.CreateItem(AItemClass: TdxCustomLayoutItemClass = nil; AParent: TdxLayoutGroup = nil): TdxCustomLayoutItem;
begin
  if AItemClass = nil then
    AItemClass := GetDefaultItemClass;
  Result := AItemClass.Create(ILayout.GetItemsOwner);
  AddAvailableItem(Result);
  Result.Parent := AParent;
  Modified;
end;

function TdxLayoutContainer.CreateItemForControl(AControl: TControl; AParent: TdxLayoutGroup = nil): TdxLayoutItem;
begin
  Result := TdxLayoutItem(CreateItem(GetDefaultItemClass, AParent));
  Result.Control := AControl;
end;

function TdxLayoutContainer.GetRoot: TdxLayoutGroup;
begin
  Result := FRoot;
end;

procedure TdxLayoutContainer.SetRootGroup(Value: TdxLayoutGroup);
begin
  BeginUpdate;
  try
    if Value <> nil then
    begin
      if FRoot <> nil then
      begin
        Value.FAlignHorz := FRoot.AlignHorz;
        Value.FAlignVert := FRoot.AlignVert;
      end
      else
      begin
        Value.FAlignHorz := ahLeft;
        Value.FAlignVert := avTop;
      end;
    end;
    if FRoot <> nil then
    begin
      DestroyHandlers;
      FRoot.RemoveFreeNotification(Self);
      FreeAndNil(FRoot);
    end;
    FRoot := Value;
    if FRoot <> nil then
    begin
      FRoot.FreeNotification(Self);
      FRoot.Container := Self;
      FRoot.Hidden := True;
      CreateHandlers;
    end;
  finally
    EndUpdate(not IsDestroying);
  end;
end;

procedure TdxLayoutContainer.AddSpecialGroup(AGroup: TdxLayoutGroup);
begin
  AGroup.Parent := nil;
  ExtractAvailableItem(AGroup);
  FSpecialItems.Add(AGroup);
end;

procedure TdxLayoutContainer.CheckDestroySuperfluousGroup(AGroup: TdxLayoutGroup);
begin
  if csAncestor in AGroup.ComponentState then
    AddSpecialGroup(AGroup)
  else
    AGroup.Free;
end;

function TdxLayoutContainer.GetNewHiddenGroup: TdxLayoutGroup;
begin
  if FSpecialItems.Count > 0 then
  begin
    Result := FSpecialItems.First as TdxLayoutGroup;
    FSpecialItems.Extract(Result);
    AddAvailableItem(Result);
  end
  else
    Result := CreateGroup;
  Result.Hidden := True;
end;

procedure TdxLayoutContainer.AvailableItemListChanged(
  Sender: TObject; AComponent: TComponent; AAction: TcxComponentCollectionNotification);
begin
  CustomizeFormPostUpdate([cfutAvailableItems]);
end;

function TdxLayoutContainer.GetClientRect: TRect;
begin
  Result := ILayout.GetClientRect;
end;

function TdxLayoutContainer.GetILayout: IdxLayoutControl;
begin
  Supports(Owner, IdxLayoutControl, Result);
end;

function TdxLayoutContainer.GetILayoutFontHelper: IdxLayoutFontHelper;
begin
  Supports(Owner, IdxLayoutFontHelper, Result);
end;

function TdxLayoutContainer.GetIsDesignSelectorsVisible: Boolean;
begin
  Result := IsDesigning and ShowDesignSelectors;
end;

function TdxLayoutContainer.GetItemsParent: TcxControl;
begin
  Result := ILayout.GetItemsParent;
end;

procedure TdxLayoutContainer.CreateConstraints;
begin
  FAlignmentConstraints := TComponentList.Create;
end;

procedure TdxLayoutContainer.DestroyConstraints;
begin
  FAlignmentConstraints.OwnsObjects := True;
  FreeAndNil(FAlignmentConstraints);
end;

function TdxLayoutContainer.GetAlignmentConstraint(Index: Integer): TdxLayoutAlignmentConstraint;
begin
  Result := TdxLayoutAlignmentConstraint(FAlignmentConstraints[Index]);
end;

function TdxLayoutContainer.GetAlignmentConstraintCount: Integer;
begin
  Result := FAlignmentConstraints.Count;
end;

procedure TdxLayoutContainer.AddAlignmentConstraint(AConstraint: TdxLayoutAlignmentConstraint);
begin
  FAlignmentConstraints.Add(AConstraint);
  AConstraint.FContainer := Self;
  SetComponentName(AConstraint, Name + 'AlignmentConstraint', IsDesigning, IsLoading);
end;

procedure TdxLayoutContainer.RemoveAlignmentConstraint(AConstraint: TdxLayoutAlignmentConstraint);
begin
  FAlignmentConstraints.Remove(AConstraint);
  AConstraint.FContainer := nil;
end;

function TdxLayoutContainer.GetAbsoluteItem(Index: Integer): TdxCustomLayoutItem;
begin
  Result := TdxCustomLayoutItem(FAbsoluteItems[Index]);
end;

function TdxLayoutContainer.GetAbsoluteItemCount: Integer;
begin
  Result := FAbsoluteItems.Count;
end;

function TdxLayoutContainer.GetAvailableItem(Index: Integer): TdxCustomLayoutItem;
begin
  Result := TdxCustomLayoutItem(FAvailableItems[Index]);
end;

function TdxLayoutContainer.GetAvailableItemCount: Integer;
begin
  Result := FAvailableItems.Count;
end;

procedure TdxLayoutContainer.SetCustomization(AValue: Boolean);
var
  AParentForm: TCustomForm;
begin
  if (FCustomization <> AValue) and (not AValue or CanAllocateHandle(ItemsParent)) then
  begin
    if AValue then
    begin
      if not (IsDestroying or IsDesigning) and IsChildWindow(ItemsParent, GetFocus) then
      begin
        AParentForm := GetParentForm(ItemsParent);
        if (AParentForm <> nil) and ItemsParent.Visible then
          AParentForm.ActiveControl := ItemsParent;
      end;
      CreateCustomizeForm;
      FCustomization := True;
      ShowCustomizeForm;
    end
    else
    begin
      FCustomization := False;
      DestroyCustomizeForm;
      if not IsDesigning then
        ClearSelection;
    end;
    ILayout.CustomizationChanged;
    UpdateItemsCustomization;
  end
  else
    if FCustomization and Assigned(ItemsParent) and ItemsParent.HandleAllocated then
      CustomizeForm.BringToFront;
end;

procedure TdxLayoutContainer.SetCustomizeAvailableItemsViewKind(
  Value: TdxLayoutAvailableItemsViewKind);
begin
  if FCustomizeAvailableItemsViewKind <> Value then
  begin
    FCustomizeAvailableItemsViewKind := Value;
    CustomizeFormPostUpdate([cfutAvailableItems, cfutSelection, cfutView]);
  end;
end;

procedure TdxLayoutContainer.SetCustomizeFormTabbedView(AValue: Boolean);
begin
  if FCustomizeFormTabbedView <> AValue then
  begin
    FCustomizeFormTabbedView := AValue;
    CustomizeFormPostUpdate([cfutView]);
    Modified;
  end;
end;

procedure TdxLayoutContainer.SetHighlightRoot(AValue: Boolean);
begin
  if FHighlightRoot <> AValue then
  begin
    FHighlightRoot := AValue;
    LayoutChanged(False);
    CustomizeFormPostUpdate([cfutView]);
    Modified;
  end;
end;

procedure TdxLayoutContainer.SetRenamingItem(AValue: TdxCustomLayoutItem);
begin
  if FRenamingItem <> AValue then
  begin
    if (FRenamingItem <> nil) and ViewInfo.SelectionLayer.EditorMode then
      ViewInfo.SelectionLayer.EndRename(not IsDestroying);
    FRenamingItem := AValue;
  end;
end;

procedure TdxLayoutContainer.SetShowDesignSelectors(Value: Boolean);
begin
  if FShowDesignSelectors <> Value then
  begin
    FShowDesignSelectors := Value;
    InvalidateWithChildren;
    CustomizeFormPostUpdate([cfutView]);
    Modified;
  end;
end;

{ THitTests }

type
  THitTests = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetInstance(AClass: TdxCustomLayoutHitTestClass): TdxCustomLayoutHitTest;
    function GetItem(Index: Integer): TdxCustomLayoutHitTest;
  protected
    function GetObjectByClass(AClass: TdxCustomLayoutHitTestClass): TdxCustomLayoutHitTest;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TdxCustomLayoutHitTest read GetItem;
  public
    constructor Create;
    destructor Destroy; override;
    property Instances[AClass: TdxCustomLayoutHitTestClass]: TdxCustomLayoutHitTest read GetInstance; default;
  end;

var  
  HitTests: THitTests;

constructor THitTests.Create;
begin
  inherited;
  FItems := TList.Create;
end;

destructor THitTests.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Free;
  FItems.Free;
  inherited;
end;

function THitTests.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function THitTests.GetInstance(AClass: TdxCustomLayoutHitTestClass): TdxCustomLayoutHitTest;
begin
  Result := GetObjectByClass(AClass);
  if Result = nil then
  begin
    Result := AClass.Create;
    FItems.Add(Result);
  end;  
end;

function THitTests.GetItem(Index: Integer): TdxCustomLayoutHitTest;
begin
  Result := FItems[Index];
end;

function THitTests.GetObjectByClass(AClass: TdxCustomLayoutHitTestClass): TdxCustomLayoutHitTest;
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

{ TdxCustomLayoutHitTest }

function TdxCustomLayoutHitTest.CanDragAndDrop: Boolean;
begin
  Result := (Item <> nil) and Item.Container.IsCustomization;
end;

function TdxCustomLayoutHitTest.GetCursor: TCursor;
begin
  Result := crDefault;
end;

function TdxCustomLayoutHitTest.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  Result := TdxLayoutDragAndDropObject;
end;

class function TdxCustomLayoutHitTest.HitTestCode: Integer;
begin
  Result := htError;
end;

class function TdxCustomLayoutHitTest.Instance: TdxCustomLayoutHitTest;
begin
  Result := HitTests.Instances[Self];
end;

function TdxCustomLayoutHitTest.IsDeterminedAreaPart: Boolean;
begin
  Result := False;
end;

function TdxCustomLayoutHitTest.GetAreaPart: TdxLayoutAreaPart;
begin
  Result := apNone;
end;

function TdxCustomLayoutHitTest.GetGroupForInsert: TdxLayoutGroup;
begin
  Result := nil;
end;

function TdxCustomLayoutHitTest.GetDestinationItem: TdxCustomLayoutItem;
begin
  Result := Item;
end;

function TdxCustomLayoutHitTest.GetSourceItem: TdxCustomLayoutItem;
begin
  Result := Item;
end;

{ TdxLayoutNoneHitTest }

class function TdxLayoutNoneHitTest.HitTestCode: Integer;
begin
  Result := htNone;
end;

{ TdxLayoutItemHitTest }

function TdxLayoutItemHitTest.GetItem: TdxLayoutItem;
begin
  Result := inherited Item as TdxLayoutItem;
end;

class function TdxLayoutItemHitTest.HitTestCode: Integer;
begin
  Result := htItem;
end;

function TdxLayoutItemHitTest.GetGroupForInsert: TdxLayoutGroup;
begin
  Result := Item.Parent;
end;

{ TdxLayoutGroupHitTest }

function TdxLayoutGroupHitTest.GetItem: TdxLayoutGroup;
begin
  Result := TdxLayoutGroup(inherited Item);
end;

class function TdxLayoutGroupHitTest.HitTestCode: Integer;
begin
  Result := htGroup;
end;

function TdxLayoutGroupHitTest.GetGroupForInsert: TdxLayoutGroup;
begin
  Result := Item;
end;

{ TdxLayoutTabbedGroupHitTest }

function TdxLayoutTabbedGroupHitTest.GetDestinationItem: TdxCustomLayoutItem;
var
  AVisibleTabIndex: Integer;
begin
  if Specific.HasTabControl then
  begin
    AVisibleTabIndex := Specific.GetHitTabIndex(FPos);
    if AVisibleTabIndex <> -1 then
      Result := Item.ViewInfo.ItemViewInfos[AVisibleTabIndex].Item
    else
      Result := inherited GetDestinationItem;
  end
  else
    Result := inherited GetDestinationItem;
end;

function TdxLayoutTabbedGroupHitTest.GetSourceItem: TdxCustomLayoutItem;
var
  AVisibleTabIndex: Integer;
begin
  if Specific.HasTabControl then
  begin
    AVisibleTabIndex := Specific.GetHitTabIndex(FPos);
    if AVisibleTabIndex <> -1 then
      Result := Item.ViewInfo.ItemViewInfos[AVisibleTabIndex].Item
    else
      Result := inherited GetSourceItem;
  end
  else
    Result := inherited GetSourceItem;
end;

function TdxLayoutTabbedGroupHitTest.GetSpecific: TdxLayoutGroupViewInfoTabbedSpecific;
begin
  Result := Item.ViewInfo.Specific as TdxLayoutGroupViewInfoTabbedSpecific;
end;

{ TdxLayoutClientAreaHitTest }

class function TdxLayoutClientAreaHitTest.HitTestCode: Integer;
begin
  Result := htClientArea;
end;

function TdxLayoutClientAreaHitTest.GetGroupForInsert: TdxLayoutGroup;
begin
  Result := Container.Root;
end;

function TdxLayoutClientAreaHitTest.GetDestinationItem: TdxCustomLayoutItem;
begin
  Result := Container.Root;
end;

{ TdxLayoutSizeHitTest }

function TdxLayoutSizeHitTest.GetCursor: TCursor;
begin
  Result := Cursor;
end;

function TdxLayoutSizeHitTest.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  Result := TdxLayoutSizingDragAndDropObject;
end;

{ TdxLayoutSplitterHitTest }

function TdxLayoutSplitterHitTest.CanDragAndDrop: Boolean;
begin
  Result := not Item.Container.IsCustomization; 
end;

function TdxLayoutSplitterHitTest.GetCursor: TCursor;
begin
  if (Item as TdxLayoutSplitterItem).IsVertical then
    Result := crHSplit
  else
    Result := crVSplit;
end;

function TdxLayoutSplitterHitTest.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  if (Item as TdxLayoutSplitterItem).IsVertical then
    Result := TdxLayoutHSplitterDragAndDropObject
  else
    Result := TdxLayoutVSplitterDragAndDropObject;
end;

{ TdxLayoutCustomizeFormHitTest }

class function TdxLayoutCustomizeFormHitTest.HitTestCode: Integer;
begin
  Result := htCustomizeForm;
end;

function TdxLayoutCustomizeFormHitTest.IsDeterminedAreaPart: Boolean;
begin
  Result := True;
end;

function TdxLayoutCustomizeFormHitTest.GetAreaPart: TdxLayoutAreaPart;
begin
  Result := AreaPart;
end;

function TdxLayoutCustomizeFormHitTest.GetDestinationItem: TdxCustomLayoutItem;
begin
  Result := Item;
end;

{ TdxCustomLayoutElementPainter }

constructor TdxCustomLayoutElementPainter.Create(ACanvas: TcxCanvas; AViewInfo: TdxCustomLayoutElementViewInfo);
begin
  inherited Create;
  FCanvas := ACanvas;
  FViewInfo := AViewInfo;
end;

procedure TdxCustomLayoutElementPainter.Paint;
begin
end;

{ TdxCustomLayoutItemElementPainter }

function TdxCustomLayoutItemElementPainter.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := ViewInfo.LayoutLookAndFeel;
end;

function TdxCustomLayoutItemElementPainter.GetViewInfo: TdxCustomLayoutItemElementViewInfo;
begin
  Result := inherited ViewInfo as TdxCustomLayoutItemElementViewInfo;
end;

{ TdxCustomLayoutItemCaptionPainter }

function TdxCustomLayoutItemCaptionPainter.GetViewInfo: TdxCustomLayoutItemCaptionViewInfo;
begin
  Result := TdxCustomLayoutItemCaptionViewInfo(inherited ViewInfo);
end;

procedure TdxCustomLayoutItemCaptionPainter.DoPaint;
begin
  DrawBackground;
  DrawText;
  DrawGlyph;
end;

procedure TdxCustomLayoutItemCaptionPainter.DrawBackground;
begin
end;

procedure TdxCustomLayoutItemCaptionPainter.DrawGlyph;
begin
  if ViewInfo.IsImageVisible then
    DoDrawGlyph;
end;

procedure TdxCustomLayoutItemCaptionPainter.DrawText;
begin
  if ViewInfo.IsTextVisible then
  begin
    Canvas.SaveState;
    try
      Canvas.Brush.Style := bsClear;
      ViewInfo.PrepareCanvas(Canvas);
      DoDrawText;
    finally
      Canvas.RestoreState;
    end;
  end;
end;

procedure TdxCustomLayoutItemCaptionPainter.DoDrawText;
begin
  with ViewInfo do
    Self.Canvas.DrawText(Text, TextAreaBounds, CalculateTextFlags, Enabled or (TextColor <> clDefault), GetRotationAngle);
end;

procedure TdxCustomLayoutItemCaptionPainter.DoDrawGlyph;
begin
  dxDrawItemGlyph(Canvas, ViewInfo.Item, ViewInfo.ImageBounds, ViewInfo.GetRotationAngle);
end;

procedure TdxCustomLayoutItemCaptionPainter.Paint;
begin
  inherited;
  if RectVisible(Canvas.Handle, ViewInfo.Bounds) then
    DoPaint;
end;

{ TdxCustomLayoutItemPainter }

function TdxCustomLayoutItemPainter.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := ViewInfo.LayoutLookAndFeel;
end;

function TdxCustomLayoutItemPainter.GetViewInfo: TdxCustomLayoutItemViewInfo;
begin
  Result := inherited ViewInfo as TdxCustomLayoutItemViewInfo;
end;

procedure TdxCustomLayoutItemPainter.DoDrawBackground;
begin
  Canvas.FillRect(ViewInfo.BackgroundBounds, ViewInfo.GetBackgroundColor);
end;

procedure TdxCustomLayoutItemPainter.DoDrawCaption;
begin
  with GetCaptionPainterClass.Create(Canvas, ViewInfo.CaptionViewInfo) do
    try
      Paint;
    finally
      Free;
    end;
end;

procedure TdxCustomLayoutItemPainter.DoDrawSpecificPart;
begin
// do nothing
end;

procedure TdxCustomLayoutItemPainter.DoDrawSelectionFrame;
begin
  FrameRectByColor(Canvas.Handle, ViewInfo.SelectionBorderRect, dxLayoutSelectionBorderDefaultColor);
end;

procedure TdxCustomLayoutItemPainter.DrawBackground;
begin
  if CanDrawBackground then
    DoDrawBackground;
end;

procedure TdxCustomLayoutItemPainter.DrawCaption;
begin
  if CanDrawCaption then
    DoDrawCaption;
end;

procedure TdxCustomLayoutItemPainter.DrawItem;
begin
  DrawBackground;
  DrawContent;
end;

procedure TdxCustomLayoutItemPainter.DrawContent;
begin
  DrawCaption;
end;

function TdxCustomLayoutItemPainter.CanDrawBackground: Boolean;
begin
  Result := ViewInfo.CanDrawBackground;
end;

function TdxCustomLayoutItemPainter.CanDrawCaption: Boolean;
begin
  Result := ViewInfo.HasCaption;
end;

function TdxCustomLayoutItemPainter.CanPaint: Boolean;
begin
  Result := ViewInfo.CanPaint;
end;

function TdxCustomLayoutItemPainter.CanDrawSpecificPart: Boolean;
begin
  Result := CanPaint and ViewInfo.IsDragImagePainted;
end;

procedure TdxCustomLayoutItemPainter.PaintDragImage;
begin
  Paint;
  DoDrawSelectionFrame;
  DrawSpecificPart;
end;

procedure TdxCustomLayoutItemPainter.DrawSpecificPart;
begin
  if CanDrawSpecificPart then
    DoDrawSpecificPart;
end;

procedure TdxCustomLayoutItemPainter.DrawDesignFeatures;
begin
// do nothing
end;

procedure TdxCustomLayoutItemPainter.Paint;
begin
  inherited;
  if CanPaint and RectVisible(Canvas.Handle, ViewInfo.Bounds) then
  begin
    DrawItem;
//#DG selection breaks    Canvas.ExcludeClipRect(ViewInfo.Bounds);
  end;
end;

{ TdxLayoutItemControlPainter }

function TdxLayoutControlItemControlPainter.GetViewInfo: TdxLayoutControlItemControlViewInfo;
begin
  Result := inherited ViewInfo as TdxLayoutControlItemControlViewInfo;
end;

procedure TdxLayoutControlItemControlPainter.DrawBorders;
begin
  LayoutLookAndFeel.DrawItemControlBorder(Canvas, ViewInfo.ItemViewInfo.Options, ViewInfo.Bounds);
end;

procedure TdxLayoutControlItemControlPainter.Paint;
begin
  inherited;
  if ViewInfo.HasBorder and RectVisible(Canvas.Handle, ViewInfo.Bounds) then
    DrawBorders;
end;

{ TdxLayoutEmptySpaceItemPainter }

procedure TdxLayoutEmptySpaceItemPainter.DrawContent;
begin
  if ViewInfo.IsDragged and ViewInfo.IsAvailable then
    with ViewInfo.CaptionViewInfo do
      Self.Canvas.DrawText(Text, TextAreaBounds, 0, True)
  else
    ; //do nothing
end;

{ TdxLayoutDirectionalItemPainter }

procedure TdxLayoutDirectionalItemPainter.DrawContent;
begin
  if ViewInfo.IsDragged and ViewInfo.IsAvailable then
    with ViewInfo.CaptionViewInfo do
      Self.Canvas.DrawText(Text, TextAreaBounds, 0, True)
  else
    DoDrawContent;
end;

procedure TdxLayoutDirectionalItemPainter.DoDrawContent;
begin
end;

{ TdxLayoutSeparatorItemPainter }

procedure TdxLayoutSeparatorItemPainter.DoDrawContent;
var
  AcxLookAndFeel: TcxLookAndFeel;
begin
  AcxLookAndFeel := TcxLookAndFeel.Create(nil);
  try
    LayoutLookAndFeel.InitializeSubControlCxLookAndFeel(AcxLookAndFeel);
    AcxLookAndFeel.Painter.DrawSeparator(Canvas, ViewInfo.Bounds, ViewInfo.IsVertical);
  finally
    AcxLookAndFeel.Free;
  end;
end;

function TdxLayoutSeparatorItemPainter.GetViewInfo: TdxLayoutSeparatorItemViewInfo;
begin
  Result := inherited ViewInfo as TdxLayoutSeparatorItemViewInfo;
end;

procedure TdxLayoutSplitterItemPainter.DoDrawContent;
var
  AcxLookAndFeel: TcxLookAndFeel;
begin
  AcxLookAndFeel := TcxLookAndFeel.Create(nil);
  try
    LayoutLookAndFeel.InitializeSubControlCxLookAndFeel(AcxLookAndFeel);
    AcxLookAndFeel.Painter.DrawSplitter(Canvas, ViewInfo.Bounds, levsHot in ViewInfo.State, levsPressed in ViewInfo.State, not ViewInfo.IsVertical);
  finally
    AcxLookAndFeel.Free;
  end;
end;

function TdxLayoutSplitterItemPainter.GetViewInfo: TdxLayoutSplitterItemViewInfo;
begin
  Result := inherited ViewInfo as TdxLayoutSplitterItemViewInfo;
end;

{ TdxLayoutLabeledItemPainter }

function TdxLayoutLabeledItemPainter.CanDrawCaption: Boolean;
begin
  Result := inherited CanDrawCaption or (ViewInfo.IsDragImagePainted and not ViewInfo.ActuallyVisible);
end;

function TdxLayoutLabeledItemPainter.GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass;
begin
  Result := TdxLayoutItemCaptionPainter;
end;

{ TdxLayoutControlItemPainter }

function TdxLayoutControlItemPainter.GetViewInfo: TdxLayoutControlItemViewInfo;
begin
  Result := inherited ViewInfo as TdxLayoutControlItemViewInfo;
end;

function TdxLayoutControlItemPainter.CanDrawSpecificPart: Boolean;
begin
  Result := CanPaint and ViewInfo.ActuallyVisible and ViewInfo.HasControl;
end;

function TdxLayoutControlItemPainter.GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass;
begin
  Result := TdxLayoutControlItemCaptionPainter;
end;

function TdxLayoutControlItemPainter.GetControlPainterClass: TdxLayoutControlItemControlPainterClass;
begin
  Result := TdxLayoutControlItemControlPainter;
end;

procedure TdxLayoutControlItemPainter.DoDrawControlBorder;
begin
  with GetControlPainterClass.Create(Canvas, ViewInfo.ControlViewInfo) do
    try
      Paint;
    finally
      Free;
    end;
end;

procedure TdxLayoutControlItemPainter.DrawContent;
begin
  DrawControlBorder;
  inherited;
end;

procedure TdxLayoutControlItemPainter.DrawControlBorder;
begin
  if ViewInfo.HasControl then
    DoDrawControlBorder;
end;

{ TdxLayoutItemPainter }

function TdxLayoutItemPainter.GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass;
begin
  Result := TdxLayoutItemCaptionPainter;
end;

function TdxLayoutItemPainter.GetControlPainterClass: TdxLayoutControlItemControlPainterClass;
begin
  Result := TdxLayoutItemControlPainter;
end;

procedure TdxLayoutItemPainter.DoDrawSpecificPart;

  function GetControlRect(AControl: TControl): TRect; // copy from cxPC
  begin
    Result := Rect(0, 0, AControl.Width, AControl.Height);
  end;

begin
  Canvas.SaveState;
  try
    if ViewInfo.Item.HasWinControl then
    begin
      with ViewInfo.Item.Control.BoundsRect.TopLeft do
        ViewInfo.Item.WinControl.PaintTo(Canvas.Canvas, X, Y);
    end
    else
    begin
      with ViewInfo.Item.Control.BoundsRect.TopLeft do
        MoveWindowOrg(Canvas.Handle, X, Y);
      Canvas.IntersectClipRect(GetControlRect(ViewInfo.Item.Control));
      ViewInfo.Item.Control.Perform(WM_ERASEBKGND, Canvas.Handle, Canvas.Handle);
      ViewInfo.Item.Control.Perform(WM_PAINT, Canvas.Handle, 0);
    end;
  finally
    Canvas.RestoreState;
  end;
end;

function TdxLayoutItemPainter.GetViewInfo: TdxLayoutItemViewInfo;
begin
  Result := TdxLayoutItemViewInfo(inherited ViewInfo);
end;

{ TdxLayoutGroupButtonPainter }

procedure TdxLayoutGroupButtonPainter.Paint;
var
  R: TRect;
  ABitmap: TcxAlphaBitmap;
  ARotationAngle: TcxRotationAngle;
  ARect: TRect;
  AcxLookAndFeel: TcxLookAndFeel;
  APainter: TcxCustomLookAndFeelPainterClass;
begin
  inherited;
  ARotationAngle := ViewInfo.ButtonsViewInfo.GroupViewInfo.GetRotationAngle;
  R := ViewInfo.Bounds;

  AcxLookAndFeel := TcxLookAndFeel.Create(nil);
  try
    LayoutLookAndFeel.InitializeSubControlCxLookAndFeel(AcxLookAndFeel);
    APainter := GetButtonPainterClass(AcxLookAndFeel);
    if ViewInfo.IsExpandButton and not IsGlyphAssigned(ViewInfo.Glyph) then
      APainter.DrawGroupBoxExpandButton(Canvas, R, ViewInfo.GetState, ViewInfo.IsGroupExpanded, ARotationAngle)
    else
    begin
      APainter.DrawButton(Canvas, R, '', ViewInfo.GetState);
      if ViewInfo.Glyph <> nil then
      begin
        ABitmap := TcxAlphaBitmap.CreateSize(ViewInfo.Glyph.Width, ViewInfo.Glyph.Height);
        try
          ABitmap.Clear;
          cxDrawImage(ABitmap.cxCanvas.Handle, ABitmap.ClientRect, ABitmap.ClientRect, ViewInfo.Glyph, nil, -1, EnabledImageDrawModeMap[ViewInfo.IsEnabled]);
          Canvas.RotateBitmap(ABitmap, ARotationAngle);
          ARect := cxRectCenter(R, ABitmap.Width, ABitmap.Height);
          cxDrawImage(Canvas.Handle, ARect, ARect, ABitmap, nil, -1, EnabledImageDrawModeMap[ViewInfo.IsEnabled]);
        finally
          ABitmap.Free;
        end;
      end;
    end;
  finally
    AcxLookAndFeel.Free;
  end;
end;

function TdxLayoutGroupButtonPainter.GetViewInfo: TdxLayoutGroupButtonViewInfo;
begin
  Result := inherited ViewInfo as TdxLayoutGroupButtonViewInfo;
end;

{ TdxLayoutGroupPainter }

procedure TdxLayoutGroupPainter.DrawSpecificPart;
var
  I: Integer;
  AViewInfo: TdxCustomLayoutItemViewInfo;
begin
  inherited;
  for I := 0 to ViewInfo.ItemViewInfoCount - 1 do
  begin
    AViewInfo := ViewInfo.ItemViewInfos[I];
    with AViewInfo.GetPainterClass.Create(Canvas, AViewInfo) do
      try
        DrawSpecificPart;
      finally
        Free;
      end;
    end;
end;

procedure TdxLayoutGroupPainter.DrawDesignFeatures;
var
  I: Integer;
  AViewInfo: TdxCustomLayoutItemViewInfo;
begin
  inherited;

  for I := 0 to ViewInfo.ItemViewInfoCount - 1 do
  begin
    AViewInfo := ViewInfo.ItemViewInfos[I];
    with AViewInfo.GetPainterClass.Create(Canvas, AViewInfo) do
      try
        DrawDesignFeatures;
      finally
        Free;
      end;
    end;
end;

function TdxLayoutGroupPainter.GetViewInfo: TdxLayoutGroupViewInfo;
begin
  Result := TdxLayoutGroupViewInfo(inherited ViewInfo);
end;

function TdxLayoutGroupPainter.GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass;
begin
  Result := TdxLayoutGroupCaptionPainter;
end;

procedure TdxLayoutGroupPainter.DrawContent;
begin
  DrawBorders;
  DrawSpecificControls;
  DrawItemsArea;
  inherited;
  DrawButtons;
end;

function TdxLayoutGroupPainter.CanDrawSpecificControls: Boolean;
begin
  Result := ViewInfo.CanDrawSpecificControls;
end;

function TdxLayoutGroupPainter.HasCaptionBackground: Boolean;
begin
  Result := True;
end;

procedure TdxLayoutGroupPainter.DoDrawBorders;
begin
end;

procedure TdxLayoutGroupPainter.DoDrawButtons;
var
  I: Integer;
  AButtonViewInfo: TdxLayoutGroupButtonViewInfo;
begin
  for I := 0 to ViewInfo.ButtonsViewInfo.ButtonViewInfoCount - 1 do
  begin
    AButtonViewInfo := ViewInfo.ButtonsViewInfo.ButtonViewInfos[I];
    if AButtonViewInfo.Visible then
      with AButtonViewInfo.GetPainterClass.Create(Canvas, AButtonViewInfo) do
      try
        Paint;
      finally
        Free;
      end;
  end;
end;

procedure TdxLayoutGroupPainter.DoDrawSpecificControls;
begin
  ViewInfo.Specific.DrawSpecificControls(Canvas);
end;

procedure TdxLayoutGroupPainter.DrawBorders;
begin
  if ViewInfo.HasBorder then
  begin
    Canvas.SaveClipRegion;
    try
      if HasCaptionBackground then
      begin
        Canvas.ExcludeClipRect(ViewInfo.CaptionViewInfo.Bounds);
        Canvas.ExcludeClipRect(ViewInfo.ButtonsViewInfo.Bounds);
      end;
      DoDrawBorders;
    finally
      Canvas.RestoreClipRegion;
    end;
  end;
end;

procedure TdxLayoutGroupPainter.DrawButtons;
begin
  if ViewInfo.ButtonsViewInfo.Visible then
    DoDrawButtons;
end;

procedure TdxLayoutGroupPainter.DrawItems;
var
  I: Integer;
  AItemViewInfo: TdxCustomLayoutItemViewInfo;
begin
  for I := 0 to ViewInfo.ItemViewInfoCount - 1 do
  begin
    AItemViewInfo := ViewInfo.ItemViewInfos[I];
    if AItemViewInfo.CanPaint then
      with AItemViewInfo.GetPainterClass.Create(Canvas, AItemViewInfo) do
        try
          Paint;
        finally
          Free;
        end;
  end;
end;

procedure TdxLayoutGroupPainter.DrawItemsArea;
begin
  DrawItems;
end;

procedure TdxLayoutGroupPainter.DrawSpecificControls;
begin
  if CanDrawSpecificControls then
    DoDrawSpecificControls;
end;

{ TdxLayoutContainerPainter }

constructor TdxLayoutContainerPainter.Create(AViewInfo: TdxLayoutContainerViewInfo);
begin
  inherited Create;
  FViewInfo := AViewInfo;
end;

procedure TdxLayoutContainerPainter.DrawDesignFeatures(ACanvas: TcxCanvas);
var
  AItemsViewInfo: TdxLayoutGroupViewInfo;
begin
  AItemsViewInfo := ViewInfo.ItemsViewInfo;
  with AItemsViewInfo.GetPainterClass.Create(ACanvas, AItemsViewInfo) do
    try
      DrawDesignFeatures;
    finally
      Free;
    end;
end;

procedure TdxLayoutContainerPainter.DrawItems(ACanvas: TcxCanvas);
var
  AItemsViewInfo: TdxLayoutGroupViewInfo;
begin
  AItemsViewInfo := ViewInfo.ItemsViewInfo;
  with AItemsViewInfo.GetPainterClass.Create(ACanvas, AItemsViewInfo) do
    try
      Paint;
    finally
      Free;
    end;
end;

procedure TdxLayoutContainerPainter.PlaceControls(AItemViewInfo: TdxCustomLayoutItemViewInfo);
var
  AControlViewInfos, AWinControlViewInfos: TList;

  function CheckControlSize(AControlViewInfo: TdxLayoutItemControlViewInfo): Boolean;
  begin
    Result := True;
    if not cxSizeIsEqual(cxSize(AControlViewInfo.ControlBounds), cxSize(AControlViewInfo.Control.BoundsRect)) then
    begin
      if cxSizeIsEqual(AControlViewInfo.FPrevControlSize, cxSize(AControlViewInfo.Control.BoundsRect)) then
        AControlViewInfo.FControlBounds := AControlViewInfo.Control.BoundsRect
      else
      begin
        AControlViewInfo.Item.SaveOriginalControlSize;
        Result := False;
      end;
    end;
  end;

  function CheckControlSizes(AControlViewInfos: TList): Boolean;
  var
    I: Integer;
    AControlViewInfo: TdxLayoutItemControlViewInfo;
  begin
    Result := True;
    for I := 0 to AControlViewInfos.Count - 1 do
    begin
      AControlViewInfo := TdxLayoutItemControlViewInfo(AControlViewInfos[I]);
      Result := CheckControlSize(AControlViewInfo);
      if not Result then
        Break;
    end;
  end;

  procedure ProcessControls;
  var
    I: Integer;
    AControlViewInfo: TdxLayoutItemControlViewInfo;
  begin
    for I := 0 to AControlViewInfos.Count - 1 do
    begin
      AControlViewInfo := TObject(AControlViewInfos[I]) as TdxLayoutItemControlViewInfo;
      AControlViewInfo.FPrevControlSize := cxSize(AControlViewInfo.Control.BoundsRect);
      AControlViewInfo.Control.BoundsRect := AControlViewInfo.ControlBounds;
      AControlViewInfo.Item.FControlSizeChanged := True;
    end;
  end;

  procedure ProcessWinControls;
  var
    AWindowsStruct: HDWP;
    I: Integer;
    AControlViewInfo: TdxLayoutItemControlViewInfo;
    R: TRect;
  begin
    AWindowsStruct := BeginDeferWindowPos(AWinControlViewInfos.Count);
    try
      for I := 0 to AWinControlViewInfos.Count - 1 do
      begin
        AControlViewInfo := TObject(AWinControlViewInfos[I]) as TdxLayoutItemControlViewInfo;
        AControlViewInfo.FPrevControlSize := cxSize(AControlViewInfo.Control.BoundsRect);
        R := AControlViewInfo.ControlBounds;
        DeferWindowPos(AWindowsStruct, (AControlViewInfo.Control as TWinControl).Handle, 0,
          R.Left, R.Top, cxRectWidth(R), cxRectHeight(R), SWP_NOZORDER or SWP_NOACTIVATE);
        AControlViewInfo.Item.FControlSizeChanged := True;
      end;
    finally
      EndDeferWindowPos(AWindowsStruct);
    end;
  end;

begin
  Container.FIsPlaceControlsNeeded := False;

  AControlViewInfos := TList.Create;
  AWinControlViewInfos := TList.Create;
  try
    Container.StartPlacingControls;
    try
      AItemViewInfo.PopulateControlViewInfoList(AControlViewInfos, AWinControlViewInfos);
      ProcessControls;
      ProcessWinControls;
    finally
      Container.StopPlacingControls;
    end;
    if not CheckControlSizes(AControlViewInfos) or not CheckControlSizes(AWinControlViewInfos) then
      Container.LayoutChanged;
  finally
    AWinControlViewInfos.Free;
    AControlViewInfos.Free;
  end;
end;

function TdxLayoutContainerPainter.GetContainer: TdxLayoutContainer;
begin
  Result := ViewInfo.Container;
end;

{ TdxCustomLayoutElementViewInfo }

procedure TdxCustomLayoutElementViewInfo.Calculate(const ABounds: TRect);
begin
  FBounds := ABounds;
  FOriginalBounds := ABounds;
end;

function TdxCustomLayoutElementViewInfo.GetEnabled: Boolean;
begin
  Result := False;
end;

function TdxCustomLayoutElementViewInfo.GetIsCustomization: Boolean;
begin
  Result := False;
end;

function TdxCustomLayoutElementViewInfo.GetPadding: TRect;
begin
  Result := cxNullRect;
end;


function TdxCustomLayoutElementViewInfo.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := True;
end;

procedure TdxCustomLayoutElementViewInfo.MouseEnter;
begin
  if IsHotTrackable then
    State := State + [levsHot];
end;

procedure TdxCustomLayoutElementViewInfo.MouseLeave;
begin
  State := State - [levsHot, levsPressed];
end;

procedure TdxCustomLayoutElementViewInfo.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  State := State + [levsPressed];
end;

procedure TdxCustomLayoutElementViewInfo.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TdxCustomLayoutElementViewInfo.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  State := State - [levsPressed];
end;

procedure TdxCustomLayoutElementViewInfo.KeyDown(var Key: Word; Shift: TShiftState);
begin
// do nothing
end;

procedure TdxCustomLayoutElementViewInfo.DoSetOffset(const Value: TPoint);
var
  AOffset: TPoint;
begin
  AOffset := cxPointOffset(Value, Offset, False);
  FOffset := Value;
  FOriginalBounds := cxRectOffset(FOriginalBounds, AOffset);
  FBounds := cxRectOffset(FBounds, AOffset);
end;

procedure TdxCustomLayoutElementViewInfo.SetOffset(const Value: TPoint);
begin
  if not cxPointIsEqual(Offset, Value) then
    DoSetOffset(Value);
end;

procedure TdxCustomLayoutElementViewInfo.StateChanged;
begin
end;

function TdxCustomLayoutElementViewInfo.IsHotTrackable: Boolean;
begin
  Result := False;
end;

procedure TdxCustomLayoutElementViewInfo.SetState(AValue: TdxLayoutElementViewInfoStates);
begin
  if not Enabled or IsCustomization then
    AValue := [];
  if FState <> AValue then
  begin
    FState := AValue;
    StateChanged;
  end;
end;

{ TdxCustomLayoutItemElementViewInfo }

constructor TdxCustomLayoutItemElementViewInfo.Create(AItemViewInfo: TdxCustomLayoutItemViewInfo);
begin
  inherited Create;
  FItemViewInfo := AItemViewInfo;
  FOffset := FItemViewInfo.Offset;
end;

destructor TdxCustomLayoutItemElementViewInfo.Destroy;
begin
  if Self = ItemViewInfo.ElementWithMouse then
    ItemViewInfo.FElementWithMouse := nil;
  inherited;
end;

function TdxCustomLayoutItemElementViewInfo.CalculateMinHeight: Integer;
begin
  Result := 0;
end;

function TdxCustomLayoutItemElementViewInfo.CalculateMinWidth: Integer;
begin
  Result := 0;
end;

function TdxCustomLayoutItemElementViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
end;

function TdxCustomLayoutItemElementViewInfo.CalculateWidth: Integer;
begin
  Result := 0;
end;

function TdxCustomLayoutItemElementViewInfo.GetHeight: Integer;
begin
  Result := FHeight;
  if Result = 0 then
  begin
    Result := cxRectHeight(Bounds);
    if Result = 0 then
      Result := CalculateHeight;
  end;
end;

function TdxCustomLayoutItemElementViewInfo.GetItem: TdxCustomLayoutItem;
begin
  Result := FItemViewInfo.Item;
end;

function TdxCustomLayoutItemElementViewInfo.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := FItemViewInfo.LayoutLookAndFeel;
end;

function TdxCustomLayoutItemElementViewInfo.GetWidth: Integer;
begin
  Result := FWidth;
  if Result = 0 then
  begin
    Result := cxRectWidth(Bounds);
    if Result = 0 then
      Result := CalculateWidth;
  end;
end;

procedure TdxCustomLayoutItemElementViewInfo.SetHeight(Value: Integer);
begin
  FHeight := Value;
end;

procedure TdxCustomLayoutItemElementViewInfo.SetWidth(Value: Integer);
begin
  FWidth := Value;
end;

function TdxCustomLayoutItemElementViewInfo.GetEnabled: Boolean;
begin
  Result := FItemViewInfo.Enabled;
end;

function TdxCustomLayoutItemElementViewInfo.GetIsCustomization: Boolean;
begin
  Result := ItemViewInfo.IsCustomization;
end;

function TdxCustomLayoutItemElementViewInfo.GetCursor(X, Y: Integer): TCursor;
begin
  Result := crDefault;
end;

function TdxCustomLayoutItemElementViewInfo.GetVisible: Boolean;
begin
  Result := False;
end;

procedure TdxCustomLayoutItemElementViewInfo.Invalidate(const ABounds: TRect);
begin
  ItemViewInfo.Invalidate(ABounds);
end;

function TdxCustomLayoutItemElementViewInfo.WantsMouse(X, Y: Integer): Boolean;
begin
  Result := Visible and PtInRect(Bounds, Point(X, Y));
end;

function TdxCustomLayoutItemElementViewInfo.ShowHint(var AHintInfo: THintInfo): Boolean;
begin
  Result := False;
end;

{ TdxCustomLayoutItemCaptionViewInfo }

function TdxCustomLayoutItemCaptionViewInfo.GetCanvas: TcxCanvas;
begin
  Result := ItemViewInfo.ContainerViewInfo.GetCanvas;
end;

procedure TdxCustomLayoutItemCaptionViewInfo.SetHotTracked(Value: Boolean);
begin
  if FHotTracked <> Value then
  begin
    FHotTracked := Value;
    Invalidate(HotTrackBounds);
  end;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetCursor(X, Y: Integer): TCursor;
begin
  if HotTracked and (htsHandPoint in HotTrackStyles) then
    Result := crcxHandPoint
  else
    Result := inherited GetCursor(X, Y);
end;

function TdxCustomLayoutItemCaptionViewInfo.GetVisible: Boolean;
begin
  Result := ItemViewInfo.HasCaption or (ItemViewInfo.IsDragImagePainted and not ItemViewInfo.ActuallyVisible);
end;

procedure TdxCustomLayoutItemCaptionViewInfo.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if CanDoCaptionClick(X, Y) then
    Item.DoCaptionDown;
end;

procedure TdxCustomLayoutItemCaptionViewInfo.MouseLeave;
begin
  inherited;
  HotTracked := False;
end;

procedure TdxCustomLayoutItemCaptionViewInfo.MouseMove(Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if IsHotTrackable then
    HotTracked := IsPointInHotTrackBounds(Point(X, Y));
end;

procedure TdxCustomLayoutItemCaptionViewInfo.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  APressed: Boolean;
begin
  APressed := levsPressed in State;
  inherited;
  if CanDoCaptionClick(X, Y) and APressed then
    Item.DoCaptionClick;
end;

procedure TdxCustomLayoutItemCaptionViewInfo.StateChanged;
begin
  inherited;
  if IsHotTrackable then
    Invalidate(HotTrackBounds);
end;

function TdxCustomLayoutItemCaptionViewInfo.GetColor: TColor;
begin
  Result := ItemViewInfo.Color;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetFont: TFont;
begin
  Result := Options.GetFont(Item.Container.ILayoutFontHelper);
end;

function TdxCustomLayoutItemCaptionViewInfo.GetHotTrackBounds: TRect;
begin
  Result := TextAreaBounds;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetHotTrackStyles: TdxLayoutHotTrackStyles;
begin
  Result := Options.HotTrackStyles;
end;

function TdxCustomLayoutItemCaptionViewInfo.CalculateTextFlags: Integer;
const
  MultiLinesMap: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
  AlignsVert: array[TdxAlignmentVert] of Integer =
    (cxAlignTop, cxAlignVCenter, cxAlignBottom);

  function GetRealAlignHorz: TAlignment;
  const
    ra180AlignHorzMap: array[TAlignment] of TAlignment = (taRightJustify, taLeftJustify, taCenter);
    raMinus90AlignHorzMap: array[TdxAlignmentVert] of TAlignment = (taRightJustify, taCenter, taLeftJustify);
    raPlus90AlignHorzMap: array[TdxAlignmentVert] of TAlignment = (taLeftJustify, taCenter, taRightJustify);
  begin
    case GetRotationAngle of
      ra180:
        Result := ra180AlignHorzMap[AlignHorz];
      raPlus90:
        Result := raPlus90AlignHorzMap[AlignVert];
      raMinus90:
        Result := raMinus90AlignHorzMap[AlignVert]
    else
      Result := AlignHorz;
    end;
  end;

  function GetRealAlignVert: TdxAlignmentVert;
  const
    ra180AlignVertMap: array[TdxAlignmentVert] of TdxAlignmentVert = (tavBottom, tavCenter, tavTop);
    raPlus90AlignVertMap: array[TAlignment] of TdxAlignmentVert = (tavBottom, tavTop, tavCenter);
    raMinus90AlignVertMap: array[TAlignment] of TdxAlignmentVert = (tavTop, tavBottom, tavCenter);
  begin
    case GetRotationAngle of
      ra180:
        Result := ra180AlignVertMap[AlignVert];
      raPlus90:
        Result := raPlus90AlignVertMap[AlignHorz];
      raMinus90:
        Result := raMinus90AlignVertMap[AlignHorz]
    else
      Result := AlignVert;
    end;
  end;

begin
  Result := MultiLinesMap[IsMultiLine] or cxAlignmentsHorz[GetRealAlignHorz] or AlignsVert[GetRealAlignVert];
  if Item.CaptionOptions.ShowAccelChar then
    Inc(Result, cxShowPrefix);
end;

procedure TdxCustomLayoutItemCaptionViewInfo.PrepareCanvas(ACanvas: TcxCanvas);
var
  ATextColor: TColor;
begin
  ACanvas.Font := Font;
  ATextColor := TextColor;
  if ATextColor <> clDefault then
    ACanvas.Font.Color := ATextColor;
  if IsTextUnderlined then
    ACanvas.Font.Style := ACanvas.Font.Style + [fsUnderline];
end;

function TdxCustomLayoutItemCaptionViewInfo.CanDoCaptionClick(X, Y: Integer): Boolean;
begin
  Result := Enabled and IsPointInHotTrackBounds(Point(X, Y));
end;

function TdxCustomLayoutItemCaptionViewInfo.GetAlignHorz: TAlignment;
begin
  Result := Item.CaptionOptions.AlignHorz;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetAlignVert: TdxAlignmentVert;
begin
  Result := Item.CaptionOptions.AlignVert;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetOptions: TdxLayoutLookAndFeelCaptionOptions;
begin
  Result := ItemViewInfo.Options.CaptionOptions;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetRotationAngle: TcxRotationAngle;
begin
  Result := ra0;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetSpaceBetweenImageText: Integer;
begin
  Result := dxLayoutGlyphSpace;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetAvailableHeight: Integer;
begin
  Result := CalculateHeight;
  if not Visible and not IsVerticalCaption then
    Inc(Result, Max(GetAvailableTextHeight, ImageHeight));
end;

function TdxCustomLayoutItemCaptionViewInfo.GetAvailableWidth: Integer;
begin
  Result := CalculateWidth;
  if not Visible and IsVerticalCaption then
    Inc(Result, Max(GetAvailableTextWidth, ImageWidth));
end;

function TdxCustomLayoutItemCaptionViewInfo.GetAvailableTextHeight: Integer;
begin
  PrepareCanvas(Canvas);
  Result := Canvas.TextHeight('Qq');
  Inc(Result);  // for disabling
end;

function TdxCustomLayoutItemCaptionViewInfo.GetAvailableTextWidth: Integer;
begin
  PrepareCanvas(Canvas);
  Result := Canvas.TextWidth('Qq');
  Inc(Result);  // for disabling
end;

function TdxCustomLayoutItemCaptionViewInfo.GetContentOffsets: TRect;
begin
  Result := Padding;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetText: string;
begin
  Result := Item.Caption;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetTextAreaBounds: TRect;
var
  AImageAreaWidth: Integer;
  AImageAreaHeight: Integer;
begin
  if IsTextVisible then
  begin
    Result := cxRectContent(Bounds, GetContentOffsets);
    if IsImageVisible then
    begin
      if IsVerticalCaption then
      begin
        AImageAreaHeight := cxRectHeight(ImageAreaBounds);
        if IsNeedSpaceBetweenImageText then
          Inc(AImageAreaHeight, GetSpaceBetweenImageText);
        if GetRotationAngle = raPlus90 then
          Result.Bottom := Result.Bottom - AImageAreaHeight
        else
          Result.Top := Result.Top + AImageAreaHeight;
      end
      else
      begin
        AImageAreaWidth := cxRectWidth(ImageAreaBounds);
        if IsNeedSpaceBetweenImageText then
          Inc(AImageAreaWidth, GetSpaceBetweenImageText);
        if AlignHorz = taRightJustify then
          Result.Right := Result.Right - AImageAreaWidth
        else
          Result.Left := Result.Left + AImageAreaWidth;
      end;
    end;
    if Enabled and (Text <> '') then
      with Result do
        case GetRotationAngle of
          ra0:
            begin
              Dec(Right);
              Dec(Bottom);
            end;
          raPlus90:
            begin
              Inc(Top);
              Dec(Right);
            end;
          raMinus90:
            begin
              Inc(Left);
              Dec(Bottom);
            end;
        end;
  end
  else
    Result := cxNullRect;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetTextColor: TColor;
begin
  if not Enabled then
    Result := GetTextDisabledColor
  else
    if HotTracked then
      Result := GetTextHotColor
    else
      Result := GetTextNormalColor;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetTextDisabledColor: TColor;
begin
  Result := Options.GetTextDisabledColor;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetTextHotColor: TColor;
begin
  Result := Options.GetTextHotColor;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetTextNormalColor: TColor;
begin
  Result := Options.GetTextColor;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetTextHeight: Integer;
var
  R: TRect;
begin
  if IsTextVisible then
  begin
    if Item.CachedTextHeight = 0 then
    begin
      PrepareCanvas(Canvas);
      if IsMultiLine then
      begin
        R := Rect(0, 0, TextWidth - 1 {for disabling}, 0);
        Canvas.TextExtent(Text, R, CalculateTextFlags);
        Result := R.Bottom - R.Top;
      end
      else
        Result := Canvas.TextHeight(Text);
      Item.CachedTextHeight := Result;
    end
    else
      Result := Item.CachedTextHeight;
    Inc(Result);  // for disabling
  end
  else
    Result := 0;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetTextWidth: Integer;
var
  AText: string;
begin
  if IsTextVisible then
  begin
    AText := VisibleText;
    PrepareCanvas(Canvas);
    Result := Canvas.TextWidth(AText);
    Inc(Result); // for disabling
  end
  else
    Result := 0;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetVisibleText: string;
begin
  Result := Text;
  if Item.CaptionOptions.ShowAccelChar then
    Result := StripHotKey(Result);
end;

function TdxCustomLayoutItemCaptionViewInfo.IsMultiLine: Boolean;
begin
  Result := False;
end;

function TdxCustomLayoutItemCaptionViewInfo.IsNeedSpaceBetweenImageText: Boolean;
begin
  Result := IsTextVisible and IsImageVisible;
end;

function TdxCustomLayoutItemCaptionViewInfo.IsPointInHotTrackBounds(const P: TPoint): Boolean;
var
  ABounds: TRectArray;
  I: Integer;
begin
  Result := IsImageVisible and PtInRect(ImageBounds, P);
  if not Result and IsTextVisible then
  begin
    PrepareCanvas(Canvas);
    Canvas.GetTextStringsBounds(Text, TextAreaBounds, CalculateTextFlags, Enabled, ABounds);
    try
      for I := 0 to High(ABounds) do
      begin
        Result := PtInRect(ABounds[I], P);
        if Result then Break;
      end;
    finally
      ABounds := nil;
    end;
  end;
end;

function TdxCustomLayoutItemCaptionViewInfo.IsImageVisible: Boolean;
begin
  Result := Item.IsImageVisible;
end;

function TdxCustomLayoutItemCaptionViewInfo.IsTextVisible: Boolean;
begin
  Result := Item.IsTextVisible;
end;

function TdxCustomLayoutItemCaptionViewInfo.IsDefaultColor: Boolean;
begin
  Result := ItemViewInfo.IsDefaultColor;
end;

function TdxCustomLayoutItemCaptionViewInfo.IsHotTrackable: Boolean;
begin
  Result := not IsCustomization and Enabled and Options.HotTrack;
end;

function TdxCustomLayoutItemCaptionViewInfo.IsTextUnderlined: Boolean;
begin
  Result :=
    IsHotTrackable and not HotTracked and (htsUnderlineCold in HotTrackStyles) or
    HotTracked and (htsUnderlineHot in HotTrackStyles);
end;

function TdxCustomLayoutItemCaptionViewInfo.IsTransparent: Boolean;
begin
  Result := ItemViewInfo.IsTransparent;
end;

function TdxCustomLayoutItemCaptionViewInfo.IsVerticalCaption: Boolean;
begin
  Result := False;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetImageAreaBounds: TRect;
begin
  Result := cxRectContent(Bounds, GetContentOffsets);
end;

function TdxCustomLayoutItemCaptionViewInfo.GetImageBounds: TRect;
begin
  if IsImageVisible then
    Result := cxRectCenter(ImageAreaBounds, ImageWidth, ImageHeight)
  else
    Result := cxNullRect;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetImageHeight: Integer;
begin
  if IsImageVisible then
    Result := Item.CaptionOptions.ImageOptions.GetImageSize.cy
  else
    Result := 0;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetImageWidth: Integer;
begin
  if IsImageVisible then
    Result := Item.CaptionOptions.ImageOptions.GetImageSize.cx
  else
    Result := 0;
end;

function TdxCustomLayoutItemCaptionViewInfo.CalculateHeight: Integer;
begin
  if Visible then
    Result := Max(TextHeight, ImageHeight)
  else
    Result := 0;
  with GetContentOffsets do
    Inc(Result, Top + Bottom);
end;

function TdxCustomLayoutItemCaptionViewInfo.CalculateWidth: Integer;
begin
  if Visible then
  begin
    Result := TextWidth + ImageWidth;
    if IsNeedSpaceBetweenImageText then
      Inc(Result, GetSpaceBetweenImageText);
    with GetContentOffsets do
      Inc(Result, Left + Right);
  end
  else
    Result := 0;
end;

{ TdxCustomLayoutItemViewInfoCloneData }

constructor TdxCustomLayoutItemViewInfoCloneData.Create(AOwner: TdxLayoutCloneDataList; AItem: TdxCustomLayoutItem);
begin
  inherited Create;
  FItem := AItem;
  FNotifyComponent := TcxFreeNotificator.Create(nil);
  FNotifyComponent.OnFreeNotification := FreeNotification;
  FItem.FreeNotification(FNotifyComponent);
  FOwner := AOwner;
end;

destructor TdxCustomLayoutItemViewInfoCloneData.Destroy;
begin
  FreeAndNil(FNotifyComponent);
  inherited;
end;

procedure TdxCustomLayoutItemViewInfoCloneData.Assign(Source: TdxCustomLayoutItemViewInfoCloneData);
begin
end;

procedure TdxCustomLayoutItemViewInfoCloneData.Calculate;
begin
end;

procedure TdxCustomLayoutItemViewInfoCloneData.Load(AStream: TStream);
begin
end;

procedure TdxCustomLayoutItemViewInfoCloneData.Save(AStream: TStream);
begin
end;

procedure TdxCustomLayoutItemViewInfoCloneData.Changed;
begin
  Owner.Changed;
end;

function TdxCustomLayoutItemViewInfoCloneData.ReadBoolean(AStream: TStream): Boolean;
begin
  AStream.Read(Result, 1);
end;

procedure TdxCustomLayoutItemViewInfoCloneData.WriteBoolean(AStream: TStream; AValue: Boolean);
begin
  AStream.Write(AValue, 1);
end;

procedure TdxCustomLayoutItemViewInfoCloneData.FreeNotification(AComponent: TComponent);
begin
  FOwner.Extract(Self);
  Free;    
end;

{ TdxLayoutCloneDataList }

procedure TdxLayoutCloneDataList.Changed;
begin
  CallNotify(FOnChanged, Self);
end;

function TdxLayoutCloneDataList.GetItem(Index: Integer): TdxCustomLayoutItemViewInfoCloneData;
begin
  Result := inherited Items[Index] as TdxCustomLayoutItemViewInfoCloneData;
end;

procedure TdxLayoutCloneDataList.SetItem(Index: Integer; Value: TdxCustomLayoutItemViewInfoCloneData);
begin
  inherited Items[Index] := Value;
end;

{ TdxCustomLayoutItemViewInfo }

constructor TdxCustomLayoutItemViewInfo.Create(AContainerViewInfo: TdxLayoutContainerViewInfo; AParentViewInfo: TdxLayoutGroupViewInfo;
  AItem: TdxCustomLayoutItem);
begin
  inherited Create;
  FNotifyComponent := TcxFreeNotificator.Create(nil);
  FNotifyComponent.OnFreeNotification := FreeNotification;
  FItem := AItem;
  FParentViewInfo := AParentViewInfo;
  FContainerViewInfo := AContainerViewInfo;
  PrepareCloneData;
  FItem.FreeNotification(FNotifyComponent);
  FTabOrderIndex := -1;
  FOffset := ContainerViewInfo.Offset;
  CreateViewInfos;
end;

destructor TdxCustomLayoutItemViewInfo.Destroy;
begin
  DestroyViewInfos;
  FreeAndNil(FNotifyComponent);
  inherited;
end;

function TdxCustomLayoutItemViewInfo.GetAlignHorz: TdxLayoutAlignHorz;
begin
//#DG  Result := Item.AlignHorz;
  Result := Item.GetRealAlignHorz;
end;

function TdxCustomLayoutItemViewInfo.GetAlignVert: TdxLayoutAlignVert;
begin
//#DG  Result := Item.AlignVert;
  Result := Item.GetRealAlignVert;
end;

function TdxCustomLayoutItemViewInfo.GetBackgroundBounds: TRect;
begin
  if IsDragImagePainted then
    Result := SelectionBorderRect
  else
    Result := Bounds;
end;

function TdxCustomLayoutItemViewInfo.GetCanPaint: Boolean;
begin
  Result := ActuallyVisible or
    IsDragImagePainted and (IsDragged or IsDraggedWithParent and ParentViewInfo.CanPaint and
    ParentViewInfo.Specific.AllowDrawChild(Self));
end;

function TdxCustomLayoutItemViewInfo.GetHasMouse: Boolean;
begin
  Result := ContainerViewInfo.ItemWithMouse = Item;
end;

function TdxCustomLayoutItemViewInfo.IsAvailable: Boolean;
begin
  Result := Item.IsAvailable;
end;

function TdxCustomLayoutItemViewInfo.IsExpanded: Boolean;
begin
  Result := Item.IsExpanded;
end;

function TdxCustomLayoutItemViewInfo.IsParentExpanded: Boolean;
begin
  Result := (ParentViewInfo = nil) or (ParentViewInfo.IsExpanded and ParentViewInfo.IsParentExpanded);
end;

function TdxCustomLayoutItemViewInfo.IsClone: Boolean;
begin
  Result := ContainerViewInfo.IsClone;
end;

function TdxCustomLayoutItemViewInfo.IsDragged: Boolean;
begin
  Result := Item.IsDragged;
end;

function TdxCustomLayoutItemViewInfo.IsDraggedWithParent: Boolean;
begin
  Result := (ParentViewInfo <> nil) and (ParentViewInfo.IsDragged or ParentViewInfo.IsDraggedWithParent);
end;

function TdxCustomLayoutItemViewInfo.IsDragImagePainted: Boolean;
begin
  Result := ContainerViewInfo.IsDragImagePainted;
end;

procedure TdxCustomLayoutItemViewInfo.LoadCloneData(AStream: TStream);
begin
  CloneData.Load(AStream);
end;

procedure TdxCustomLayoutItemViewInfo.SaveCloneData(AStream: TStream);
begin
  CloneData.Save(AStream);
end;

procedure TdxCustomLayoutItemViewInfo.PrepareCloneData;
begin
  if IsClone then
    FCloneData := ContainerViewInfo.GetCloneData(Self);
end;

function TdxCustomLayoutItemViewInfo.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := Item.GetLayoutLookAndFeel;
end;

procedure TdxCustomLayoutItemViewInfo.DoSetOffset(const Value: TPoint);
var
  I: Integer;
begin
  inherited;
  for I := 0 to ElementCount - 1 do
    Elements[I].Offset := Value;
end;

procedure TdxCustomLayoutItemViewInfo.Invalidate(const ABounds: TRect);
begin
  Item.Container.InvalidateRect(ABounds, False);
end;

procedure TdxCustomLayoutItemViewInfo.PaintSelectionLayer(ABitmap: TcxAlphaBitmap);
var
  ABackgroundBitmap: TcxAlphaBitmap;
  ASizableMarkers, ANonSizableMarkers: TRects;
begin
  if Selected and ActuallyVisible then
  begin
    ABackgroundBitmap := TcxAlphaBitmap.CreateSize(SelectionBorderRect);
    try
      ABackgroundBitmap.cxCanvas.FillRect(ABackgroundBitmap.ClientRect, dxLayoutControlSelectionDefaultColor);
      ABackgroundBitmap.SetAlphaChannel(dxLayoutSelectionDefaultAlphaChannel);
      ABitmap.CopyBitmap(ABackgroundBitmap, SelectionBorderRect, cxNullPoint);
    finally
      ABackgroundBitmap.Free;
    end;

    GetSelectionMarkers(ASizableMarkers, ANonSizableMarkers);
//    dxDrawSelectionMarkers(ABitmap.cxCanvas, AMarkers, dxLayoutSelectionBorderDefaultColor, dxLayoutSelectionBorderMarkerInnerDefaultColor);

    dxDrawSelectionMarkers(ABitmap.cxCanvas, ASizableMarkers, dxLayoutSelectionBorderDefaultColor, dxLayoutSelectionBorderDefaultColor);
    dxDrawSelectionMarkers(ABitmap.cxCanvas, ANonSizableMarkers, dxLayoutSelectionBorderDefaultColor, dxLayoutSelectionBorderMarkerInnerDefaultColor);

    ABitmap.cxCanvas.FrameRect(SelectionBorderRect, dxLayoutSelectionBorderDefaultColor, 1, cxBordersAll, True);
  end;
end;

function TdxCustomLayoutItemViewInfo.ShowHint(var AHintInfo: THintInfo): Boolean;
begin
  Result := (ElementWithMouse <> nil) and ElementWithMouse.ShowHint(AHintInfo);
end;

function TdxCustomLayoutItemViewInfo.GetMaxTabOrderIndex: Integer;
begin
  Result := TabOrderIndex;
end;

function TdxCustomLayoutItemViewInfo.CanInplaceRename: Boolean;
begin
  Result := not Item.IsDesigning and not Item.IsRoot and (CaptionViewInfo <> nil) and CaptionViewInfo.IsTextVisible;
end;

procedure TdxCustomLayoutItemViewInfo.DoInplaceRename;
var
  R: TRect;
begin
  R := GetInplaceRenameBounds;
  if not cxRectIsEmpty(R) then
    ContainerViewInfo.Container.BeginRename(Item, R, CaptionViewInfo.Font);
end;

procedure TdxCustomLayoutItemViewInfo.InplaceRename;
begin
  if CanInplaceRename then
    DoInplaceRename;
end;

function TdxCustomLayoutItemViewInfo.GetInplaceRenameBounds: TRect;
begin
  if not HasCaption and (ParentViewInfo <> nil) and not ParentViewInfo.AllowChildHasBorder then
    Result := ParentViewInfo.GetChildInplaceRenameBounds(Self)
  else
  begin
    Result := CaptionViewInfo.TextAreaBounds;
    InflateRect(Result, 1, 1);
  end;
end;

function TdxCustomLayoutItemViewInfo.IsParentLocked: Boolean;
begin
  Result := Item.IsParentLocked;
end;

function TdxCustomLayoutItemViewInfo.IsParentSelected: Boolean;
begin
  Result := (ParentViewInfo <> nil) and (ParentViewInfo.Selected or ParentViewInfo.IsParentSelected);
end;

function TdxCustomLayoutItemViewInfo.GetMinHeight: Integer;
begin
  if AlignVert = avClient then
    Result := CalculateMinHeight
  else
    Result := CalculateHeight;
end;

function TdxCustomLayoutItemViewInfo.GetMinWidth: Integer;
begin
  if AlignHorz = ahClient then
    Result := CalculateMinWidth
  else
    Result := CalculateWidth;
end;

function TdxCustomLayoutItemViewInfo.GetUsualHeight: Integer;
begin
  Result := CalculateHeight;
end;

function TdxCustomLayoutItemViewInfo.GetUsualWidth: Integer;
begin
  Result := CalculateWidth;
end;

function TdxCustomLayoutItemViewInfo.GetOffset(ASide: TdxLayoutSide): Integer;
begin
  Result := FOffsets[ASide];
  if Result = 0 then
    Result := CalculateOffset(ASide);
end;

function TdxCustomLayoutItemViewInfo.GetOffsetsHeight: Integer;
begin
  Result := Offsets[sdTop] + Offsets[sdBottom];
end;

function TdxCustomLayoutItemViewInfo.GetOffsetsWidth: Integer;
begin
  Result := Offsets[sdLeft] + Offsets[sdRight];
end;

function TdxCustomLayoutItemViewInfo.GetMarkerIndex(AMarkers: TRects; const P: TPoint): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(AMarkers) to High(AMarkers) do
    if PtInRect(AMarkers[I], P) then
    begin
      Result := I;
      Break;
    end;
end;

function TdxCustomLayoutItemViewInfo.GetMarkerIndex(const P: TPoint): Integer;
begin
  Result := GetMarkerIndex(dxGetSelectionMarkers(SelectionBorderRect, dxLayoutSelectionMarkerWidth), P);
end;

function TdxCustomLayoutItemViewInfo.GetSelected: Boolean;
begin
  Result := Item.IsSelected;
end;

function TdxCustomLayoutItemViewInfo.GetSelectionBorderRect: TRect;
const
  SelectionGab = dxLayoutSelectionOffset / 2;

  function CanUseSelectionOffset: Boolean;
  var
    ARootViewInfo: TdxLayoutGroupViewInfo;
  begin
    ARootViewInfo := ContainerViewInfo.ItemsViewInfo;
    Result := ((ParentViewInfo = nil) and (not Item.IsRoot or
      ((ARootViewInfo.ItemsAreaOffsetHorz > SelectionGab) and (ARootViewInfo.ItemsAreaOffsetVert > SelectionGab)))) or
      ((ParentViewInfo <> nil) and (ParentViewInfo.UseItemOffset and (ParentViewInfo.ItemOffset > SelectionGab)));
  end;

  function GetSelectionBoundsOffset: Integer;
  begin
    if CanUseSelectionOffset then
      Result := dxLayoutSelectionOffset
    else
      Result := 0;
    if Item.IsRoot then
      Result := -Result;
  end;

var
  ABoundsOffset: Integer;
begin
  Result := Bounds;
  ABoundsOffset := GetSelectionBoundsOffset;
  InflateRect(Result, ABoundsOffset, ABoundsOffset);
end;

function TdxCustomLayoutItemViewInfo.GetSelectableMarkers: TRects;
var
  ANonSizableMarkers: TRects;
begin
  GetSelectionMarkers(Result, ANonSizableMarkers);
end;

procedure TdxCustomLayoutItemViewInfo.GetSelectionMarkers(out ASelectable, ANonSelectable: TRects);

  function GetWorkAlignHorz(AItem: TdxCustomLayoutItem): TdxLayoutAlignHorz;
  begin
    Result := AItem.GetRealAlignHorz;
    if (Result = ahClient) and (AItem.Parent <> nil) and (AItem.Parent.Width = 0) then
      Result := GetWorkAlignHorz(AItem.Parent);
  end;

  function GetWorkAlignVert(AItem: TdxCustomLayoutItem): TdxLayoutAlignVert;
  begin
    Result := AItem.GetRealAlignVert;
    if (Result = avClient) and (AItem.Parent <> nil) and (AItem.Parent.Height = 0) then
      Result := GetWorkAlignVert(AItem.Parent);
  end;

  procedure MoveRect(AIndex: Integer);
  begin
    if not cxRectIsEmpty(ASelectable[AIndex]) then
    begin
      ANonSelectable[AIndex] := ASelectable[AIndex];
      ASelectable[AIndex] := cxEmptyRect;
    end;
  end;

begin
  if Item.CanResizeHorz or Item.CanResizeVert then
  begin
    ASelectable := dxGetSelectionMarkers(SelectionBorderRect, dxLayoutSelectionMarkerWidth);
    SetLength(ANonSelectable, Length(ASelectable));

    if (GetWorkAlignHorz(Item) in [ahLeft, ahClient]) or not Item.CanResizeHorz then
    begin
      MoveRect(0);
      MoveRect(6);
      MoveRect(7);
    end;

    if (GetWorkAlignHorz(Item) in [ahRight, ahClient]) or not Item.CanResizeHorz then
    begin
      MoveRect(2);
      MoveRect(3);
      MoveRect(4);
    end;

    if (GetWorkAlignVert(Item) in [avTop, avClient]) or not Item.CanResizeVert then
    begin
      MoveRect(0);
      MoveRect(1);
      MoveRect(2);
    end;

    if (GetWorkAlignVert(Item) in [avBottom, avClient]) or not Item.CanResizeVert then
    begin
      MoveRect(4);
      MoveRect(5);
      MoveRect(6);
    end;
  end
  else
  begin
    ANonSelectable := dxGetSelectionMarkers(SelectionBorderRect, dxLayoutSelectionMarkerWidth);
    SetLength(ASelectable, Length(ANonSelectable));
  end;
end;

function TdxCustomLayoutItemViewInfo.GetSelectionArea: TRect;
begin
  Result := SelectionBorderRect;
  InflateRect(Result, dxLayoutSelectionMarkerWidth div 2, dxLayoutSelectionMarkerWidth div 2);
end;

procedure TdxCustomLayoutItemViewInfo.SetElementWithMouse(Value: TdxCustomLayoutItemElementViewInfo);
begin
  if FElementWithMouse <> Value then
  begin
    if FElementWithMouse <> nil then
      FElementWithMouse.MouseLeave;
    FElementWithMouse := Value;
    if FElementWithMouse <> nil then
      FElementWithMouse.MouseEnter;
  end;
end;

procedure TdxCustomLayoutItemViewInfo.SetHasMouse(Value: Boolean);
begin
  if HasMouse <> Value then
    if Value then
      ContainerViewInfo.ItemWithMouse := Item
    else
      ContainerViewInfo.ItemWithMouse := nil;
end;

procedure TdxCustomLayoutItemViewInfo.SetOffset(ASide: TdxLayoutSide; Value: Integer);
begin
  FOffsets[ASide] := Value;
end;

function TdxCustomLayoutItemViewInfo.CreateHitTest(AHitTestClass: TdxCustomLayoutItemHitTestClass; const P: TPoint): TdxCustomLayoutItemHitTest;
begin
  Result := AHitTestClass.Instance as TdxCustomLayoutItemHitTest;
  Result.Item := Item;
  Result.Pos := P;
end;

procedure TdxCustomLayoutItemViewInfo.FreeNotification(AComponent: TComponent);
begin
  FItem := nil;
  HasMouse := False;
end;

procedure TdxCustomLayoutItemViewInfo.PopulateAutoAlignControlList(AList: TList);
begin
//do nothing
end;

procedure TdxCustomLayoutItemViewInfo.PopulateControlViewInfoList(AControls, AWinControls: TList);
begin
//do nothing
end;

function TdxCustomLayoutItemViewInfo.GetIsCustomization: Boolean;
begin
  Result := Item.Container.IsCustomization;
end;

procedure TdxCustomLayoutItemViewInfo.AutoAlignControls;
begin
//do nothing
end;

procedure TdxCustomLayoutItemViewInfo.DoCreateViewInfos;
begin
  FCaptionViewInfo := GetCaptionViewInfoClass.Create(Self);
  FElements.Add(FCaptionViewInfo);
end;

procedure TdxCustomLayoutItemViewInfo.CreateViewInfos;
begin
  FElements := TObjectList.Create;
  DoCreateViewInfos;
end;

procedure TdxCustomLayoutItemViewInfo.DestroyViewInfos;
begin
  FreeAndNil(FElements);
end;

function TdxCustomLayoutItemViewInfo.CanDrawBackground: Boolean;
begin
  Result := HasBackground;
end;

function TdxCustomLayoutItemViewInfo.CanDrawSpecificBackground: Boolean;
begin
  Result := True;
end;

function TdxCustomLayoutItemViewInfo.GetBackgroundColor: TColor;
begin
  if IsDragImagePainted then
    Result := dxLayoutSelectionDefaultColor
  else
    Result := Color;
end;

function TdxCustomLayoutItemViewInfo.GetCloneDataClass: TdxCustomLayoutItemViewInfoCloneDataClass;
begin
  Result := TdxCustomLayoutItemViewInfoCloneData;
end;

function TdxCustomLayoutItemViewInfo.CalculateMinHeight: Integer;
begin
  Result := DoCalculateHeight(True);
end;

function TdxCustomLayoutItemViewInfo.CalculateMinWidth: Integer;
begin
  Result := DoCalculateWidth(True);
end;

function TdxCustomLayoutItemViewInfo.CalculateOffset(ASide: TdxLayoutSide): Integer;
begin
  case ASide of
    sdLeft:
      Result := Item.Offsets.Left;
    sdRight:
      Result := Item.Offsets.Right;
    sdTop:
      Result := Item.Offsets.Top;
    sdBottom:
      Result := Item.Offsets.Bottom;
  else
    Result := 0;
  end;
end;

function TdxCustomLayoutItemViewInfo.GetAreaPart(const P: TPoint): TdxLayoutAreaPart;
const
  Parts: array[Boolean, Boolean] of TdxLayoutAreaPart = ((apBottom, apRight), (apLeft, apTop));

  function GetSign(const P1, P2, P: TPoint): Integer;
  begin
    Result := (P.X - P1.X) * (P2.Y - P1.Y) - (P.Y - P1.Y) * (P2.X - P1.X);
  end;

var
  ASign1, ASign2: Integer;
begin
  with Bounds do
  begin
    ASign1 := GetSign(Point(Left, Bottom), Point(Right, Top), P);
    ASign2 := GetSign(TopLeft, BottomRight, P);
  end;
  Result := Parts[ASign1 >= 0, ASign2 >= 0];
  if ParentViewInfo <> nil then
    ParentViewInfo.CorrectAreaPart(Result);
end;

function TdxCustomLayoutItemViewInfo.GetActuallyVisible: Boolean;
begin
  Result := Item.GetVisible and
    (Item.IsRoot or (FParentViewInfo <> nil) and FParentViewInfo.IsChildActuallyVisible(Self)) and IsParentExpanded;
end;

function TdxCustomLayoutItemViewInfo.DoCalculateHeight(AIsMinHeight: Boolean): Integer;
begin
  Result := OffsetsHeight;
end;

function TdxCustomLayoutItemViewInfo.DoCalculateWidth(AIsMinWidth: Boolean): Integer;
begin
  Result := OffsetsWidth;
end;

function TdxCustomLayoutItemViewInfo.GetCursor(X, Y: Integer): TCursor;
var
  I: Integer;
begin
  for I := 0 to ElementCount - 1 do
    if Elements[I].WantsMouse(X, Y) then
    begin
      Result := Elements[I].GetCursor(X, Y);
      Exit;
    end;
  Result := crDefault;
end;

function TdxCustomLayoutItemViewInfo.GetElement(AIndex: Integer): TdxCustomLayoutItemElementViewInfo;
begin
  if (AIndex >= 0) and (AIndex < GetElementCount) then
    Result := TdxCustomLayoutItemElementViewInfo(FElements[AIndex])
  else
    Result := nil;
end;

function TdxCustomLayoutItemViewInfo.GetElementCount: Integer;
begin
  Result := FElements.Count;
end;

function TdxCustomLayoutItemViewInfo.GetEnabled: Boolean;
begin
  Result := Item.Enabled;
end;

function TdxCustomLayoutItemViewInfo.GetHitTestBounds: TRect;
begin
  Result := Bounds;
end;

function TdxCustomLayoutItemViewInfo.GetOptions: TdxCustomLayoutLookAndFeelOptions;
begin
  Result := Item.GetOptions;
end;

function TdxCustomLayoutItemViewInfo.IsTransparent: Boolean;
begin
  Result := False;
end;

function TdxCustomLayoutItemViewInfo.HasBackground: Boolean;
begin
  Result := (IsDragImagePainted and IsDragged) or (not IsTransparent and
    ((ParentViewInfo = nil) {IsRoot} or (LayoutLookAndFeel <> ParentViewInfo.LayoutLookAndFeel)));
end;

function TdxCustomLayoutItemViewInfo.HasCaption: Boolean;
begin
  Result := Item.HasCaption;
end;

function TdxCustomLayoutItemViewInfo.HasBorder: Boolean;
begin
  Result := False;
end;

procedure TdxCustomLayoutItemViewInfo.CustomizationMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AShift: TShiftState;
begin
  AShift := Shift;
  if not Item.IsDesigning and (ssRight in Shift) and Item.IsSelected and
      ([ssShift, ssCtrl] * Shift = []) then
    Include(AShift, ssShift);
  Item.SelectComponent(AShift);
  if Shift * [ssLeft, ssRight, ssMiddle, ssDouble] = [ssLeft, ssDouble] then
    InplaceRename;
end;

procedure TdxCustomLayoutItemViewInfo.MouseLeave;
begin
  inherited;
  ElementWithMouse := nil;
end;

procedure TdxCustomLayoutItemViewInfo.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if ElementWithMouse <> nil then
    ElementWithMouse.MouseDown(Button, Shift, X, Y);
end;

procedure TdxCustomLayoutItemViewInfo.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  for I := 0 to ElementCount - 1 do
    if Elements[I].WantsMouse(X, Y) then
    begin
      ElementWithMouse := Elements[I];
      Elements[I].MouseMove(Shift, X, Y);
      Exit;
    end;
  ElementWithMouse := nil;
end;

procedure TdxCustomLayoutItemViewInfo.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if ElementWithMouse <> nil then
    ElementWithMouse.MouseUp(Button, Shift, X, Y);
end;

procedure TdxCustomLayoutItemViewInfo.Calculate(const ABounds: TRect);
begin
  inherited;
  Inc(FBounds.Left, Offsets[sdLeft]);
  Inc(FBounds.Top, Offsets[sdTop]);
  Dec(FBounds.Right, Offsets[sdRight]);
  Dec(FBounds.Bottom, Offsets[sdBottom]);
end;

function TdxCustomLayoutItemViewInfo.CalculateHeight: Integer;
begin
  if Item.Height <> 0 then
    Result := Max(Item.Height + OffsetsHeight, DoCalculateHeight(True))
  else
    Result := DoCalculateHeight(False);
end;

function TdxCustomLayoutItemViewInfo.CalculateWidth: Integer;
begin
  if Item.Width <> 0 then
    Result := Max(Item.Width + OffsetsWidth, DoCalculateWidth(True))
  else
    Result := DoCalculateWidth(False);
end;

procedure TdxCustomLayoutItemViewInfo.CalculateInternalTabOrders(var AAvailTabOrder: Integer);
begin
// do nothing
end;

procedure TdxCustomLayoutItemViewInfo.CalculateTabOrders(var AAvailTabOrder: Integer);
begin
// do nothing
end;

function TdxCustomLayoutItemViewInfo.GetHitTest(const P: TPoint): TdxCustomLayoutHitTest;
var
  AMarkerIndex: Integer;
  ACursor: TCursor;
begin
  Result := nil;
  if (not IsParentLocked or Item.IsDesigning) and ActuallyVisible then
  begin
    if IsCustomization and Item.IsSelected then
    begin
      AMarkerIndex := GetMarkerIndex(GetSelectableMarkers, P);
      if AMarkerIndex <> -1 then
      begin
        Result := CreateHitTest(TdxLayoutSizeHitTest, P);
        case AMarkerIndex of
          0, 4: ACursor := crSizeNWSE;
          1, 5: ACursor := crSizeNS;
          2, 6: ACursor := crSizeNESW;
          3, 7: ACursor := crSizeWE;
        else
          ACursor := crSize;
        end;
        TdxLayoutSizeHitTest(Result).Cursor := ACursor;
        Exit;
      end;
    end;
    if PtInRect(GetHitTestBounds, P) then
      Result := CreateHitTest(GetHitTestClass, P)
  end;
end;

function TdxCustomLayoutItemViewInfo.GetItemWithMouse(const P: TPoint): TdxCustomLayoutItem;
begin
  if not IsParentLocked and PtInRect(Bounds, P) and ActuallyVisible then
    Result := Item
  else
    Result := nil;
end;

procedure TdxCustomLayoutItemViewInfo.ResetOffset(ASide: TdxLayoutSide);
begin
  FOffsets[ASide] := 0;
end;

function TdxLayoutEmptySpaceItemCaptionViewInfo.CanDoCaptionClick(X, Y: Integer): Boolean;
begin
  Result := False;
end;

procedure TdxLayoutEmptySpaceItemCaptionViewInfo.PrepareCanvas(ACanvas: TcxCanvas);
begin
// do nothing
end;

function TdxLayoutEmptySpaceItemCaptionViewInfo.IsHotTrackable: Boolean;
begin
  Result := False;
end;

{ TdxLayoutLabeledItemCaptionViewInfo }

function TdxLayoutLabeledItemCaptionViewInfo.GetItem: TdxLayoutCustomLabeledItem;
begin
  Result := inherited GetItem as TdxLayoutCustomLabeledItem;
end;

function TdxLayoutLabeledItemCaptionViewInfo.GetItemViewInfo: TdxLayoutLabeledItemViewInfo;
begin
  Result := inherited ItemViewInfo as TdxLayoutLabeledItemViewInfo;
end;

function TdxLayoutLabeledItemCaptionViewInfo.GetCursor(X, Y: Integer): TCursor;
var
  ACursor: TCursor;
begin
  ACursor := Item.CaptionOptions.Cursor;
  if Item.Container.IsCustomization or (ACursor = crDefault) then
    Result := inherited GetCursor(X, Y)
  else
    Result := ACursor;
end;

function TdxLayoutLabeledItemCaptionViewInfo.GetIsFixedWidth: Boolean;
begin
  Result := Item.CaptionOptions.Width <> 0;
end;

function TdxLayoutLabeledItemCaptionViewInfo.IsMultiLine: Boolean;
begin
  Result := IsFixedWidth;
end;

function TdxLayoutLabeledItemCaptionViewInfo.GetSpaceBetweenImageText: Integer;
begin
  Result := ItemViewInfo.ElementOffsetHorz;
end;

function TdxLayoutLabeledItemCaptionViewInfo.GetImageAreaBounds: TRect;
begin
  Result := inherited GetImageAreaBounds;
  if Item.CaptionOptions.AlignHorz = taRightJustify then
    Result.Left := Result.Right - ImageWidth
  else
    Result.Right := Result.Left + ImageWidth;
end;

function TdxLayoutLabeledItemCaptionViewInfo.GetTextAreaBounds: TRect;
var
  ADelta: Integer;
begin
  Result := inherited GetTextAreaBounds;
  if IsMultiline then
    with Result do
    begin
      ADelta := Width - CalculateWidth;
      case AlignHorz of
        taLeftJustify:
          Dec(Right, ADelta);
        taRightJustify:
          Inc(Left, ADelta);
        taCenter:
          begin
            Inc(Left, ADelta div 2);
            Dec(Right, ADelta - ADelta div 2);
          end;
      end;
    end;
end;

function TdxLayoutLabeledItemCaptionViewInfo.GetTextWidth: Integer;
begin
  if Visible and IsFixedWidth then
    Result := Item.CaptionOptions.Width
  else
    Result := inherited GetTextWidth;
end;

function TdxLayoutLabeledItemCaptionViewInfo.CalculateMinWidth: Integer;
begin
  if Visible then
  begin
    if Width = 0 then
      Result := CalculateWidth
    else
      Result := Width;
  end
  else
    Result := 0;
end;

{ TdxLayoutControlItemCaptionViewInfo }

function TdxLayoutControlItemCaptionViewInfo.GetItem: TdxLayoutControlItem;
begin
  Result := inherited Item as TdxLayoutControlItem;
end;

function TdxLayoutControlItemCaptionViewInfo.GetItemViewInfo: TdxLayoutControlItemViewInfo;
begin
  Result := inherited ItemViewInfo as TdxLayoutControlItemViewInfo;
end;

{ TdxLayoutItemCaptionViewInfo }

function TdxLayoutItemCaptionViewInfo.GetItem: TdxLayoutItem;
begin
  Result := inherited GetItem as TdxLayoutItem;
end;

function TdxLayoutItemCaptionViewInfo.GetItemViewInfo: TdxLayoutItemViewInfo;
begin
  Result := inherited ItemViewInfo as TdxLayoutItemViewInfo;
end;

{ TdxLayoutItemControlViewInfo }

function TdxLayoutControlItemControlViewInfo.GetBorderColor: TColor;
begin
  Result := ItemViewInfo.Options.GetControlBorderColor;
end;

function TdxLayoutControlItemControlViewInfo.GetBorderStyle: TdxLayoutBorderStyle;
begin
  Result := ItemViewInfo.Options.ControlBorderStyle;
end;

function TdxLayoutControlItemControlViewInfo.GetItem: TdxLayoutControlItem;
begin
  Result := TdxLayoutControlItem(inherited Item);
end;

function TdxLayoutControlItemControlViewInfo.GetItemViewInfo: TdxLayoutControlItemViewInfo;
begin
  Result := TdxLayoutControlItemViewInfo(inherited ItemViewInfo);
end;

function TdxLayoutControlItemControlViewInfo.GetOpaqueControl: Boolean;
begin
  Result := Item.ControlOptions.Opaque;
end;

function TdxLayoutControlItemControlViewInfo.GetVisible: Boolean;
begin
  Result := ItemViewInfo.HasControl and not ItemViewInfo.IsAvailable and
    (not ItemViewInfo.IsDragImagePainted or ItemViewInfo.ActuallyVisible);
end;

function TdxLayoutControlItemControlViewInfo.CalculateControlBounds: TRect;
begin
  Result := Bounds;
  Inc(Result.Left, BorderWidths[sdLeft]);
  Dec(Result.Right, BorderWidths[sdRight]);
  Inc(Result.Top, BorderWidths[sdTop]);
  Dec(Result.Bottom, BorderWidths[sdBottom]);
end;

function TdxLayoutControlItemControlViewInfo.GetBorderWidth(ASide: TdxLayoutSide): Integer;
begin
  if HasBorder then
    Result := LayoutLookAndFeel.ItemControlBorderWidths[ASide]
  else
    Result := 0
end;

function TdxLayoutControlItemControlViewInfo.GetControlAreaHeight(AControlHeight: Integer): Integer;
begin
  Result := BorderWidths[sdTop] + AControlHeight + BorderWidths[sdBottom];
end;

function TdxLayoutControlItemControlViewInfo.GetControlAreaWidth(AControlWidth: Integer): Integer;
begin
  Result := BorderWidths[sdLeft] + AControlWidth + BorderWidths[sdRight];
end;

function TdxLayoutControlItemControlViewInfo.GetOriginalControlSize: TSize;
begin
  with Item.OriginalControlSize do
    Result := cxSize(X, Y);
end;

function TdxLayoutControlItemControlViewInfo.HasBorder: Boolean;
begin
  Result := Item.ControlOptions.ShowBorder and not ItemViewInfo.IsAvailable;
end;

procedure TdxLayoutControlItemControlViewInfo.Calculate(const ABounds: TRect);
begin
  inherited;
  FControlBounds := CalculateControlBounds;
end;

procedure TdxLayoutControlItemControlViewInfo.CalculateInternalTabOrder(var AAvailTabOrder: Integer);
begin
//do nothing
end;

procedure TdxLayoutControlItemControlViewInfo.CalculateTabOrder(var AAvailTabOrder: Integer);
begin
//do nothing
end;

function TdxLayoutControlItemControlViewInfo.CalculateMinHeight: Integer;
begin
  if Item.ControlOptions.IsHeightFixed then
    Result := CalculateHeight
  else
    if Visible then
      Result := GetControlAreaHeight(Item.ControlOptions.MinHeight)
    else
      Result := 0;
end;

function TdxLayoutControlItemControlViewInfo.CalculateMinWidth: Integer;
begin
  if Item.ControlOptions.IsWidthFixed then
    Result := CalculateWidth
  else
    if Visible then
      Result := GetControlAreaWidth(Item.ControlOptions.MinWidth)
    else
      Result := 0;
end;

function TdxLayoutControlItemControlViewInfo.CalculateHeight: Integer;
begin
  if Visible then
    Result := GetControlAreaHeight(GetOriginalControlSize.cy)
  else
    Result := 0;
end;

function TdxLayoutControlItemControlViewInfo.CalculateWidth: Integer;
begin
  if Visible then
    Result := GetControlAreaWidth(GetOriginalControlSize.cx)
  else
    Result := 0;
end;

{ TdxLayoutItemControlViewInfo }

procedure TdxLayoutItemControlViewInfo.CalculateTabOrder(var AAvailTabOrder: Integer);
begin
  if Item.HasWinControl then
  begin
    Item.WinControl.TabOrder := AAvailTabOrder;
    Inc(AAvailTabOrder);
  end;
end;

function TdxLayoutItemControlViewInfo.GetControl: TControl;
begin
  Result := Item.Control;
end;

function TdxLayoutItemControlViewInfo.GetItem: TdxLayoutItem;
begin
  Result := inherited Item as TdxLayoutItem;
end;

{ TdxLayoutBasicItemViewInfo }

function TdxLayoutBasicItemViewInfo.GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass;
begin
  Result := TdxLayoutBasicItemCaptionViewInfo;
end;

function TdxLayoutBasicItemViewInfo.GetHitTestClass: TdxCustomLayoutItemHitTestClass;
begin
  Result := TdxLayoutItemHitTest;
end;

function TdxLayoutBasicItemViewInfo.GetPainterClass: TdxCustomLayoutItemPainterClass;
begin
  Result := TdxCustomLayoutItemPainterClass(LayoutLookAndFeel.GetBasicItemPainterClass);
end;

function TdxLayoutBasicItemViewInfo.GetColor: TColor;
begin
  if ParentViewInfo <> nil then // for dragging
    Result := ParentViewInfo.GetColor
  else
    Result := ContainerViewInfo.ItemsViewInfo.GetColor;
end;

function TdxLayoutBasicItemViewInfo.IsDefaultColor: Boolean;
begin
  Result := ParentViewInfo.IsDefaultColor;
end;

function TdxLayoutBasicItemViewInfo.IsTransparent: Boolean;
begin
  Result := True;
end;

{ TdxLayoutEmptySpaceItemViewInfo }

procedure TdxLayoutEmptySpaceItemViewInfo.Calculate(const ABounds: TRect);
begin
  inherited;
  if Item.IsDragged then
    CaptionViewInfo.Calculate(ABounds);
end;

function TdxLayoutEmptySpaceItemViewInfo.GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass;
begin
  Result := TdxLayoutEmptySpaceItemCaptionViewInfo;
end;

function TdxLayoutEmptySpaceItemViewInfo.GetPainterClass: TdxCustomLayoutItemPainterClass;
begin
  Result := TdxCustomLayoutItemPainterClass(LayoutLookAndFeel.GetEmptySpaceItemPainterClass);
end;

function TdxLayoutEmptySpaceItemViewInfo.DoCalculateHeight(AIsMinHeight: Boolean): Integer;
begin
  if Item.IsDragged and HasCaption then
    Result := CaptionViewInfo.GetTextHeight
  else
    Result := inherited DoCalculateHeight(AIsMinHeight) + 2; //#DG!!!
end;

function TdxLayoutEmptySpaceItemViewInfo.DoCalculateWidth(AIsMinWidth: Boolean): Integer;
begin
  if Item.IsDragged and HasCaption then
    Result := CaptionViewInfo.GetTextWidth
  else
    Result := inherited DoCalculateWidth(AIsMinWidth) + 2; //#DG!!!
end;

{ TdxLayoutDirectionalItemViewInfo }

procedure TdxLayoutDirectionalItemViewInfo.Calculate(const ABounds: TRect);
begin
  inherited;
  if Item.IsDragged and Item.IsAvailable then
    CaptionViewInfo.Calculate(ABounds);
end;

function TdxLayoutDirectionalItemViewInfo.DoCalculateHeight(AIsMinHeight: Boolean): Integer;
begin
  if Item.IsDragged and HasCaption then
    Result := CaptionViewInfo.GetTextHeight
  else
    Result := inherited DoCalculateHeight(AIsMinHeight) + GetItemMinHeight;
end;

function TdxLayoutDirectionalItemViewInfo.DoCalculateWidth(AIsMinWidth: Boolean): Integer;
begin
  if Item.IsDragged and HasCaption then
    Result := CaptionViewInfo.GetTextWidth
  else
    Result := inherited DoCalculateWidth(AIsMinWidth) + GetItemMinWidth;
end;

function TdxLayoutDirectionalItemViewInfo.GetItemMinHeight: Integer;
begin
  Result := 0;
end;

function TdxLayoutDirectionalItemViewInfo.GetItemMinWidth: Integer;
begin
  Result := 0;
end;

function TdxLayoutDirectionalItemViewInfo.IsVertical: Boolean;
begin
  Result := Item.IsVertical;
end;

function TdxLayoutDirectionalItemViewInfo.GetItem: TdxLayoutDirectionalItem;
begin
  Result := inherited Item as TdxLayoutDirectionalItem;
end;

{ TdxLayoutSeparatorItemViewInfo }

function TdxLayoutSeparatorItemViewInfo.GetItemMinHeight: Integer;
begin
  Result := LayoutLookAndFeel.GetSeparatorItemMinWidth;
end;

function TdxLayoutSeparatorItemViewInfo.GetItemMinWidth: Integer;
begin
  Result := LayoutLookAndFeel.GetSeparatorItemMinWidth;
end;

function TdxLayoutSeparatorItemViewInfo.GetPainterClass: TdxCustomLayoutItemPainterClass;
begin
  Result := TdxCustomLayoutItemPainterClass(LayoutLookAndFeel.GetSeparatorItemPainterClass);
end;

function TdxLayoutSeparatorItemViewInfo.GetSeparator: TdxLayoutSeparatorItem;
begin
  Result := Item as TdxLayoutSeparatorItem;
end;

function TdxLayoutSplitterItemViewInfo.GetHitTestBounds: TRect;
const
  MinHitTestSize = 3;
begin
  Result := inherited GetHitTestBounds;
  if IsVertical then
  begin
    if cxRectWidth(Result) < MinHitTestSize then
      InflateRect(Result, 1, 0);
  end
  else
    if cxRectHeight(Result) < MinHitTestSize then
      InflateRect(Result, 0, 1);
end;

function TdxLayoutSplitterItemViewInfo.GetHitTestClass: TdxCustomLayoutItemHitTestClass;
begin
  if not IsCustomization then
    Result := TdxLayoutSplitterHitTest
  else
    Result := inherited GetHitTestClass;
end;

function TdxLayoutSplitterItemViewInfo.GetPainterClass: TdxCustomLayoutItemPainterClass;
begin
  Result := TdxCustomLayoutItemPainterClass(LayoutLookAndFeel.GetSplitterItemPainterClass);
end;

function TdxLayoutSplitterItemViewInfo.GetItemMinHeight: Integer;
begin
  with LayoutLookAndFeel.GetSplitterItemMinSize do
    Result := IfThen(IsVertical, cx, cy);
end;

function TdxLayoutSplitterItemViewInfo.GetItemMinWidth: Integer;
begin
  with LayoutLookAndFeel.GetSplitterItemMinSize do
    Result := IfThen(IsVertical, cy, cx);
end;

procedure TdxLayoutSplitterItemViewInfo.StateChanged;
begin
  inherited;
  Invalidate(OriginalBounds);
end;

function TdxLayoutSplitterItemViewInfo.IsHotTrackable: Boolean;
begin
  Result := True;
end;

function TdxLayoutSplitterItemViewInfo.GetSplitter: TdxLayoutSplitterItem;
begin
  Result := inherited Item as TdxLayoutSplitterItem;
end;

{ TdxLayoutLabeledItemViewInfo }

procedure TdxLayoutLabeledItemViewInfo.Calculate(const ABounds: TRect);
begin
  inherited;
  CalculateViewInfoBounds;
  CaptionViewInfo.Calculate(FCaptionViewInfoBounds);
end;

function TdxLayoutLabeledItemViewInfo.GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass;
begin
  Result := TdxLayoutLabeledItemCaptionViewInfo;
end;

function TdxLayoutLabeledItemViewInfo.GetPainterClass: TdxCustomLayoutItemPainterClass;
begin
  Result := TdxCustomLayoutItemPainterClass(LayoutLookAndFeel.GetLabeledItemPainterClass);
end;

procedure TdxLayoutLabeledItemViewInfo.InitViewInfoBounds(AElementViewInfo: TdxCustomLayoutItemElementViewInfo;
  out ABounds: TRect; out ASize: TPoint; out AVisible: Boolean);

  procedure CalculateElementViewInfoSize(AElementViewInfo: TdxCustomLayoutItemElementViewInfo;
    out ASize: TPoint; out AVisible: Boolean);
  begin
    AVisible := AElementViewInfo.Visible;
    if AVisible then
      ASize := Point(AElementViewInfo.Width, AElementViewInfo.Height)
    else
      ASize := cxNullPoint;
    AVisible := AVisible and not cxPointIsEqual(ASize, cxNullPoint);
  end;

begin
  CalculateElementViewInfoSize(AElementViewInfo, ASize, AVisible);
  if AVisible then
    ABounds := ContentBounds
  else
    SetRectEmpty(ABounds);
end;

procedure TdxLayoutLabeledItemViewInfo.CalculateViewInfoBounds;
var
  ACaptionSize: TPoint;
  ACaptionVisible: Boolean;
begin
  InitViewInfoBounds(CaptionViewInfo, FCaptionViewInfoBounds, ACaptionSize, ACaptionVisible);
end;

function TdxLayoutLabeledItemViewInfo.GetContentBounds: TRect;
var
  AMargins: TRect;
begin
  with Padding do
    AMargins := Rect(Left, Top, Right, Bottom);
  Result := cxRectContent(Bounds, AMargins);
end;

function TdxLayoutLabeledItemViewInfo.GetContentHeight(AIsMinHeight: Boolean): Integer;
begin
  Result := CaptionViewInfo.Height + Padding.Top + Padding.Bottom;
end;

function TdxLayoutLabeledItemViewInfo.GetContentWidth(AIsMinWidth: Boolean): Integer;
begin
  if AIsMinWidth then
    Result := CaptionViewInfo.CalculateMinWidth
  else
    Result := CaptionViewInfo.Width;
  Result := Result + Padding.Left + Padding.Right;
end;

function TdxLayoutLabeledItemViewInfo.GetPadding: TRect;
begin
  with Item.Padding do
    Result := Rect(Left, Top, Right, Bottom);
end;

function TdxLayoutLabeledItemViewInfo.DoCalculateHeight(AIsMinHeight: Boolean): Integer;
begin
  Result := inherited DoCalculateHeight(AIsMinHeight) + GetContentHeight(AIsMinHeight);
end;

function TdxLayoutLabeledItemViewInfo.DoCalculateWidth(AIsMinWidth: Boolean): Integer;
begin
  Result := inherited DoCalculateWidth(AIsMinWidth) + GetContentWidth(AIsMinWidth);
end;

procedure TdxLayoutLabeledItemViewInfo.DoSetOffset(const Value: TPoint);
var
  AOffset: TPoint;
begin
  AOffset := cxPointOffset(Value, Offset, False);
  inherited;
  FCaptionViewInfoBounds := cxRectOffset(FCaptionViewInfoBounds, AOffset);
end;

function TdxLayoutLabeledItemViewInfo.GetElementOffsetHorz: Integer;
begin
  Result := LayoutLookAndFeel.GetElementOffsetHorz(Item.Container.ILayoutFontHelper);
end;

function TdxLayoutLabeledItemViewInfo.GetElementOffsetVert: Integer;
begin
  Result := LayoutLookAndFeel.GetElementOffsetVert(Item.Container.ILayoutFontHelper);
end;

{ TdxLayoutControlItemViewInfo }

function TdxLayoutControlItemViewInfo.GetCaptionViewInfo: TdxLayoutControlItemCaptionViewInfo;
begin
  Result := inherited CaptionViewInfo as TdxLayoutControlItemCaptionViewInfo;
end;

function TdxLayoutControlItemViewInfo.GetItem: TdxLayoutControlItem;
begin
  Result := inherited Item as TdxLayoutControlItem;
end;

function TdxLayoutControlItemViewInfo.GetOptionsEx: TdxLayoutLookAndFeelItemOptions;
begin
  Result := inherited Options as TdxLayoutLookAndFeelItemOptions;
end;

procedure TdxLayoutControlItemViewInfo.DoCreateViewInfos;
begin
  inherited;
  FControlViewInfo := GetControlViewInfoClass.Create(Self);
  FElements.Add(FControlViewInfo);
end;

procedure TdxLayoutControlItemViewInfo.PopulateAutoAlignControlList(AList: TList);
begin
  if AutoControlAreaAlignment then
    AList.Add(Self);
end;

function TdxLayoutControlItemViewInfo.GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass;
begin
  Result := TdxLayoutControlItemCaptionViewInfo;
end;

function TdxLayoutControlItemViewInfo.GetControlViewInfoClass: TdxLayoutControlItemControlViewInfoClass;
begin
  Result := TdxLayoutControlItemControlViewInfo;
end;

function TdxLayoutControlItemViewInfo.GetHitTestClass: TdxCustomLayoutItemHitTestClass;
begin
  Result := TdxLayoutItemHitTest;
end;

function TdxLayoutControlItemViewInfo.GetPainterClass: TdxCustomLayoutItemPainterClass;
begin
  Result := TdxLayoutControlItemPainter;
end;

procedure TdxLayoutControlItemViewInfo.CalculateViewInfoBounds;

  procedure CalculateRestHorz(var ABounds: TRect; const ASize: TPoint;
    AAlignHorz: TAlignment);
  begin
    with ABounds do
      case AAlignHorz of
        taLeftJustify:
          Right := Left + ASize.X;
        taCenter:
          begin
            Left := (Left + Right - ASize.X) div 2;
            Right := Left + ASize.X;
          end;
        taRightJustify:
          Left := Right - ASize.X;
      end;
  end;

  procedure CalculateRestVert(var ABounds: TRect; const ASize: TPoint;
    AAlignVert: TdxAlignmentVert);
  begin
    with ABounds do
      case AAlignVert of
        tavTop:
          Bottom := Top + ASize.Y;
        tavCenter:
          begin
            Top := (Top + Bottom - ASize.Y) div 2;
            Bottom := Top + ASize.Y;
          end;
        tavBottom:
          Top := Bottom - ASize.Y;
      end;
  end;

  function ControlAlignHorzToAlignment(AValue: TdxLayoutItemControlAlignHorz): TAlignment;
  begin
    case AValue of
      ahLeft:
        Result := taLeftJustify;
      ahRight:
        Result := taRightJustify;
    else
      Result := taCenter;
    end;
  end;

  function ControlAlignVertTodxAlignmentVert(AValue: TdxLayoutItemControlAlignVert): TdxAlignmentVert;
  begin
    case AValue of
      avTop:
        Result := tavTop;
      avBottom:
        Result := tavBottom;
    else
      Result := tavCenter;
    end;
  end;

  procedure CalculateWithFixedCaption(const ACaptionSize, AControlSize: TPoint);
  begin
    case CaptionLayout of
      clLeft:
        begin
          FCaptionViewInfoBounds.Right := FCaptionViewInfoBounds.Left + ACaptionSize.X;
          FControlViewInfoBounds.Left := FCaptionViewInfoBounds.Right + ElementOffsetHorz;
        end;
      clTop:
        begin
          FCaptionViewInfoBounds.Bottom := FCaptionViewInfoBounds.Top + ACaptionSize.Y;
          FControlViewInfoBounds.Top := FCaptionViewInfoBounds.Bottom + ElementOffsetVert;
        end;
      clRight:
        begin
          FCaptionViewInfoBounds.Left := FCaptionViewInfoBounds.Right - ACaptionSize.X;
          FControlViewInfoBounds.Right := FCaptionViewInfoBounds.Left - ElementOffsetHorz;
        end;
      clBottom:
        begin
          FCaptionViewInfoBounds.Top := FCaptionViewInfoBounds.Bottom - ACaptionSize.Y;
          FControlViewInfoBounds.Bottom := FCaptionViewInfoBounds.Top - ElementOffsetVert;
        end;
    end;
  end;

var
  ACaptionSize, AControlSize: TPoint;
  ACaptionVisible, AControlVisible: Boolean;
begin
  InitViewInfoBounds(CaptionViewInfo, FCaptionViewInfoBounds, ACaptionSize, ACaptionVisible);
  InitViewInfoBounds(ControlViewInfo, FControlViewInfoBounds, AControlSize, AControlVisible);

  if ACaptionVisible then
  begin
    CalculateWithFixedCaption(ACaptionSize, AControlSize);
    case CaptionLayout of
      clLeft, clRight:
        CalculateRestVert(FCaptionViewInfoBounds, ACaptionSize, Item.CaptionOptions.AlignVert);
      clTop, clBottom:
        CalculateRestHorz(FCaptionViewInfoBounds, ACaptionSize, Item.CaptionOptions.AlignHorz);
    end;
  end;
  if AControlVisible then
  begin
    if Item.ControlOptions.IsWidthFixed then
      CalculateRestHorz(FControlViewInfoBounds, AControlSize, ControlAlignHorzToAlignment(Item.ControlOptions.AlignHorz));
    if Item.ControlOptions.IsHeightFixed then
      CalculateRestVert(FControlViewInfoBounds, AControlSize, ControlAlignVertTodxAlignmentVert(Item.ControlOptions.AlignVert));
  end;
end;

function TdxLayoutControlItemViewInfo.GetContentHeight(AIsMinHeight: Boolean): Integer;
var
  AHeight: Integer;
begin
  Result := CaptionViewInfo.Height;

  if AIsMinHeight then
    AHeight := ControlViewInfo.CalculateMinHeight
  else
    AHeight := ControlViewInfo.CalculateHeight;

  case CaptionLayout of
    clLeft, clRight:
      Result := Max(Result, AHeight);
    clTop, clBottom:
      begin
        if (Result <> 0) and ControlViewInfo.Visible{(AHeight <> 0)} then
          Inc(Result, ElementOffsetVert);
        Inc(Result, AHeight);
      end;
  else
    Result := 0;
  end;
  Result := Result + Padding.Top + Padding.Bottom;
end;

function TdxLayoutControlItemViewInfo.GetContentWidth(AIsMinWidth: Boolean): Integer;
var
  AWidth: Integer;
begin
  if AIsMinWidth then
  begin
    Result := CaptionViewInfo.CalculateMinWidth;
    AWidth := ControlViewInfo.CalculateMinWidth;
  end
  else
  begin
    Result := CaptionViewInfo.Width;
    AWidth := ControlViewInfo.CalculateWidth;
  end;

  case CaptionLayout of
    clLeft, clRight:
      begin
        if (Result <> 0) and CaptionViewInfo.Visible and ControlViewInfo.Visible{(AWidth <> 0)} then
          Inc(Result, ElementOffsetHorz);
        Inc(Result, AWidth);
      end;
    clTop, clBottom:
      Result := Max(Result, AWidth);
  else
    Result := 0;
  end;
  Result := Result + Padding.Left + Padding.Right;
end;

procedure TdxLayoutControlItemViewInfo.DoSetOffset(const Value: TPoint);
var
  AOffset: TPoint;
begin
  AOffset := cxPointOffset(Value, Offset, False);
  inherited;
  FControlViewInfoBounds := cxRectOffset(FControlViewInfoBounds, AOffset);
end;

function TdxLayoutControlItemViewInfo.GetAutoControlAreaAlignment: Boolean;

  function IsAlignmentAndCaptionLayoutLinked: Boolean;
  begin
    case CaptionLayout of
      clLeft:
        Result := AlignHorz in [ahLeft, ahClient];
      clTop:
        Result := AlignVert in [avTop, avClient];
      clRight:
        Result := AlignHorz in [ahRight, ahClient];
      clBottom:
        Result := AlignVert in [avBottom, avClient];
    else
      Result := False;  
    end;
  end;

  function IsConstraintAndCaptionLayoutLinked: Boolean;
  begin
    Result := (Item.AlignmentConstraint = nil) or
       (Item.AlignmentConstraint.Kind in [ackTop, ackBottom]) and (CaptionLayout in [clLeft, clRight]) or
       (Item.AlignmentConstraint.Kind in [ackLeft, ackRight]) and (CaptionLayout in [clTop, clBottom]);
  end;

begin
  Result := 
    Item.ControlOptions.AutoControlAreaAlignment and HasCaption and HasControl and
    IsAlignmentAndCaptionLayoutLinked and IsConstraintAndCaptionLayoutLinked;
end;

function TdxLayoutControlItemViewInfo.GetCaptionLayout: TdxCaptionLayout;
begin
  Result := Item.CaptionOptions.Layout;
end;

function TdxLayoutControlItemViewInfo.HasControl: Boolean;
begin
  Result := Item.HasControl;
end;

procedure TdxLayoutControlItemViewInfo.PaintSelectionLayer(ABitmap: TcxAlphaBitmap);
begin
  inherited;
  if HasControl and ActuallyVisible and IsParentSelected and not Selected then
    ABitmap.cxCanvas.FillRect(ControlViewInfo.Bounds, 0);
end;

procedure TdxLayoutControlItemViewInfo.Calculate(const ABounds: TRect);
begin
  inherited;
  ControlViewInfo.Calculate(FControlViewInfoBounds);
end;

procedure TdxLayoutControlItemViewInfo.CalculateInternalTabOrders(var AAvailTabOrder: Integer);
begin
  ControlViewInfo.CalculateInternalTabOrder(AAvailTabOrder);
end;

procedure TdxLayoutControlItemViewInfo.CalculateTabOrders(var AAvailTabOrder: Integer);
begin
  ControlViewInfo.CalculateTabOrder(AAvailTabOrder);
end;

{ TdxLayoutItemViewInfo }

function TdxLayoutItemViewInfo.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := not (Item.CanFocusControlOnCaptionClick and CaptionViewInfo.CanDoCaptionClick(X, Y));
end;

function TdxLayoutItemViewInfo.GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass;
begin
  Result := TdxLayoutItemCaptionViewInfo;
end;

function TdxLayoutItemViewInfo.GetControlViewInfoClass: TdxLayoutControlItemControlViewInfoClass;
begin
  Result := TdxLayoutItemControlViewInfo;
end;

function TdxLayoutItemViewInfo.GetPainterClass: TdxCustomLayoutItemPainterClass;
begin
  Result := TdxCustomLayoutItemPainterClass(LayoutLookAndFeel.GetItemPainterClass);
end;

procedure TdxLayoutItemViewInfo.PopulateControlViewInfoList(AControls, AWinControls: TList);
var
  AControlViewInfo: TdxLayoutItemControlViewInfo;
begin
  AControlViewInfo := ControlViewInfo;
  if ActuallyVisible and (AControlViewInfo.Control <> nil) then
    if AControlViewInfo.Control is TWinControl then
      AWinControls.Add(AControlViewInfo)
    else
      AControls.Add(AControlViewInfo);
end;

procedure TdxLayoutItemViewInfo.CustomizationMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  function NeedSelectControl: Boolean;
  begin
    Result := HasControl and ContainerViewInfo.Container.Customization and Item.IsDesignSelectorVisible and
      PtInDesignSelectorRect(Point(X, Y));
  end;

begin
  if NeedSelectControl then
    ContainerViewInfo.Container.SelectComponent(ControlViewInfo.Control, Shift)
  else
    inherited;
end;

function TdxLayoutItemViewInfo.PtInDesignSelectorRect(const P: TPoint): Boolean;
var
  R: TRect;
begin
  R := Item.DesignSelectorRect;
  R := cxRectOffset(R, ControlViewInfo.Bounds.TopLeft);
  Result := PtInRect(R, P);
end;

function TdxLayoutItemViewInfo.GetCaptionViewInfo: TdxLayoutItemCaptionViewInfo;
begin
  Result := inherited CaptionViewInfo as TdxLayoutItemCaptionViewInfo;
end;

function TdxLayoutItemViewInfo.GetControlViewInfo: TdxLayoutItemControlViewInfo;
begin
  Result := inherited ControlViewInfo as TdxLayoutItemControlViewInfo;
end;

function TdxLayoutItemViewInfo.GetItem: TdxLayoutItem;
begin
  Result := inherited Item as TdxLayoutItem;
end;

{ TdxLayoutGroupCaptionViewInfo }

function TdxLayoutGroupCaptionViewInfo.GetAlignHorz: TAlignment;
begin
  if IsVerticalCaption then
  begin
    if GetRotationAngle = raPlus90 then
      Result := taLeftJustify
    else
      Result := taRightJustify;
  end
  else
    Result := inherited GetAlignHorz;
end;

function TdxLayoutGroupCaptionViewInfo.GetAlignVert: TdxAlignmentVert;
begin
  if IsVerticalCaption then
    Result := inherited GetAlignVert
  else
    Result := tavTop;
end;

function TdxLayoutGroupCaptionViewInfo.GetAvailableTextHeight: Integer;
begin
  if not IsVerticalCaption then
    Result := inherited GetAvailableTextHeight
  else
    Result := inherited GetAvailableTextWidth;
end;

function TdxLayoutGroupCaptionViewInfo.GetAvailableTextWidth: Integer;
begin
  if not IsVerticalCaption then
    Result := inherited GetAvailableTextWidth
  else
    Result := inherited GetAvailableTextHeight;
end;

function TdxLayoutGroupCaptionViewInfo.GetImageAreaBounds: TRect;
begin
  Result := inherited GetImageAreaBounds;
  if IsVerticalCaption then
  begin
    if GroupViewInfo.CaptionSide = sdLeft then
      Result.Top := Result.Bottom - ImageHeight
    else
      Result.Bottom := Result.Top + ImageHeight
  end
  else
  begin
    if Item.CaptionOptions.AlignHorz = taRightJustify then
      Result.Left := Result.Right - ImageWidth
    else
      Result.Right := Result.Left + ImageWidth;
  end;
end;

function TdxLayoutGroupCaptionViewInfo.GetTextHeight: Integer;
begin
  if not IsVerticalCaption then
    Result := inherited GetTextHeight
  else
    Result := inherited GetTextWidth;
end;

function TdxLayoutGroupCaptionViewInfo.GetTextWidth: Integer;
begin
  if not IsVerticalCaption then
    Result := inherited GetTextWidth
  else
    Result := inherited GetTextHeight;
end;

function TdxLayoutGroupCaptionViewInfo.GetRotationAngle: TcxRotationAngle;
begin
  Result := GroupViewInfo.GetRotationAngle;
end;

function TdxLayoutGroupCaptionViewInfo.IsVerticalCaption: Boolean;
begin
  Result := GroupViewInfo.IsVerticalCaption;
end;

function TdxLayoutGroupCaptionViewInfo.CalculateHeight: Integer;
begin
  if not IsVerticalCaption then
    Result := inherited CalculateHeight
  else
  begin
    if Visible then
    begin
      Result := TextHeight + ImageHeight;
      if IsNeedSpaceBetweenImageText then
        Inc(Result, GetSpaceBetweenImageText);
      with GetContentOffsets do
        Inc(Result, Top + Bottom);
    end
    else
      Result := 0;
  end;
end;

function TdxLayoutGroupCaptionViewInfo.CalculateMinHeight: Integer;
begin
  Result := CalculateHeight;
end;

function TdxLayoutGroupCaptionViewInfo.CalculateMinWidth: Integer;
begin
  Result := CalculateWidth;
end;

function TdxLayoutGroupCaptionViewInfo.CalculateWidth: Integer;
begin
  if not IsVerticalCaption then
    Result := inherited CalculateWidth
  else
  begin
    if Visible then
      Result := Max(TextWidth, ImageWidth)
    else
      Result := 0;
    with GetContentOffsets do
      Inc(Result, Left + Right);
  end;
end;

function TdxLayoutGroupCaptionViewInfo.GetCaptionSide: TdxLayoutSide;
begin
  Result := GroupViewInfo.CaptionSide;
end;

function TdxLayoutGroupCaptionViewInfo.GetGroupViewInfo: TdxLayoutGroupViewInfo;
begin
  Result := TdxLayoutGroupViewInfo(ItemViewInfo);
end;

{ TdxLayoutGroupViewInfoSpecific }

constructor TdxLayoutGroupViewInfoSpecific.Create(AGroupViewInfo: TdxLayoutGroupViewInfo);
begin
  inherited Create;
  FGroupViewInfo := AGroupViewInfo;
  CreateSpecificControls;
end;

destructor TdxLayoutGroupViewInfoSpecific.Destroy;
begin
  DestroySpecificControls;
  inherited Destroy;
end;

procedure TdxLayoutGroupViewInfoSpecific.Calculate(const AItemsAreaBounds: TRect);
begin
  CalculateItemsBounds(AItemsAreaBounds);
end;

procedure TdxLayoutGroupViewInfoSpecific.PrepareItemInfos;
var
  I: Integer;
begin
  SetLength(FItemInfos, ItemViewInfoCount);
  for I := 0 to ItemViewInfoCount - 1 do
  begin
    FItemInfos[I].ViewInfo := ItemViewInfos[I];
    FItemInfos[I].AlignHorz := GetItemAlignHorz(FItemInfos[I].ViewInfo);
    FItemInfos[I].UsualWidth := GetItemUsualWidth(FItemInfos[I].ViewInfo);
    FItemInfos[I].Height := GetItemUsualHeight(FItemInfos[I].ViewInfo);
    FItemInfos[I].MinWidth := GetItemMinWidth(FItemInfos[I].ViewInfo);
    FItemInfos[I].Calculated := False;
  end;
end;

procedure TdxLayoutGroupViewInfoSpecific.CorrectItemsAreaBounds(var AItemsAreaBounds: TRect);
begin
  Inc(AItemsAreaBounds.Left, GetItemsAreaOffset(sdLeft));
  Dec(AItemsAreaBounds.Right, GetItemsAreaOffset(sdRight));
  Inc(AItemsAreaBounds.Top, GetItemsAreaOffset(sdTop));
  Dec(AItemsAreaBounds.Bottom, GetItemsAreaOffset(sdBottom));
end;

procedure TdxLayoutGroupViewInfoSpecific.CalculateItemsAreaBounds(var AItemsAreaBounds: TRect);
begin
  CorrectItemsAreaBounds(AItemsAreaBounds);
end;

procedure TdxLayoutGroupViewInfoSpecific.CalculateItemsHorizontalBounds(const AItemsAreaBounds: TRect);
var
  ASpace, AAvailableSpace: Integer;

  procedure CalculateSpaces;
  var
    AItemOffsets, I: Integer;
    AIsFirstItem: Boolean;
  begin
    AItemOffsets := 0;
    ASpace := 0;
    AIsFirstItem := True;
    for I := 0 to ItemViewInfoCount - 1 do
      if FItemInfos[I].AlignHorz <> ahCenter then
      begin
        if not AIsFirstItem then
          Inc(AItemOffsets, ItemOffset);
        Inc(ASpace, FItemInfos[I].UsualWidth);
        AIsFirstItem := False;
      end;
    AAvailableSpace := cxRectWidth(AItemsAreaBounds) - AItemOffsets;
  end;

  procedure InternalCalculateItemsVisibleSizes;

    procedure CalculateNonClientAlignedItemsVisibleSizes;
    var
      I: Integer;
    begin
      for I := 0 to ItemViewInfoCount - 1 do
        if IsViewInfoFixedWidth(FItemInfos[I].ViewInfo) then
        begin
          FItemInfos[I].RealWidth := FItemInfos[I].UsualWidth;
          if FItemInfos[I].AlignHorz <> ahCenter then
          begin
            Dec(ASpace, FItemInfos[I].RealWidth);
            Dec(AAvailableSpace, FItemInfos[I].RealWidth);
          end;
          FItemInfos[I].Calculated := True;
        end;
    end;

    procedure CalculateClientAlignedItemsVisibleSizes;
    var
      ANeedRecalculating: Boolean;
      ANextSpace, ANextAvailableSpace, AOffset, I: Integer;
    begin
      repeat
        ANeedRecalculating := False;
        ANextSpace := ASpace;
        ANextAvailableSpace := AAvailableSpace;
        AOffset := 0;

        for I := 0 to ItemViewInfoCount - 1 do
          if not FItemInfos[I].Calculated then
          begin
//            FItemInfos[I].RealWidth := MulDiv(AAvailableSpace, FItemInfos[I].UsualWidth, ASpace);
            FItemInfos[I].RealWidth :=
              MulDiv(AAvailableSpace, AOffset + FItemInfos[I].UsualWidth, ASpace) -
              MulDiv(AAvailableSpace, AOffset, ASpace);
            if FItemInfos[I].RealWidth < FItemInfos[I].MinWidth then
            begin
              FItemInfos[I].RealWidth := FItemInfos[I].MinWidth;
              Dec(ANextSpace, FItemInfos[I].UsualWidth);
              Dec(ANextAvailableSpace, FItemInfos[I].RealWidth);
              FItemInfos[I].Calculated := True;
              ANeedRecalculating := True;
            end;
            Inc(AOffset, FItemInfos[I].UsualWidth);
          end;

        ASpace := ANextSpace;
        AAvailableSpace := ANextAvailableSpace;
      until not ANeedRecalculating;
    end;

  begin
    CalculateNonClientAlignedItemsVisibleSizes;
    CalculateClientAlignedItemsVisibleSizes;
  end;

  procedure InternalCalculateItemsBounds;

    procedure CalculateLeftAlignedItemsBounds;
    var
      AOffset, I: Integer;
    begin
      AOffset := AItemsAreaBounds.Left;
      for I := 0 to ItemViewInfoCount - 1 do
        with FItemInfos[I] do
          case AlignHorz of
            ahLeft, ahClient:
              begin
                Bounds.Left := AOffset;
                Bounds.Right := AOffset + RealWidth;
                Inc(AOffset, RealWidth + ItemOffset);
              end;
            ahCenter:
              begin
                Bounds.Left := (AItemsAreaBounds.Left + AItemsAreaBounds.Right - RealWidth) div 2;
                Bounds.Right := Bounds.Left + RealWidth;
              end;
          end;
    end;

    procedure CalculateRightAlignedItemsBounds;
    var
      AOffset, I: Integer;
    begin
      AOffset := AItemsAreaBounds.Right;
      for I := ItemViewInfoCount - 1 downto 0 do
        with FItemInfos[I] do
          if AlignHorz = ahRight then
          begin
            Bounds.Right := AOffset;
            Bounds.Left := AOffset - RealWidth;
            Dec(AOffset, RealWidth + ItemOffset);
          end;
    end;

  begin
    CalculateLeftAlignedItemsBounds;
    CalculateRightAlignedItemsBounds;
  end;

begin
  CalculateSpaces;
  InternalCalculateItemsVisibleSizes;
  InternalCalculateItemsBounds;
end;

procedure TdxLayoutGroupViewInfoSpecific.CalculateItemsVerticalBounds(const AItemsAreaBounds: TRect);
var
  I: Integer;
begin
  for I := 0 to ItemViewInfoCount - 1 do
    with FItemInfos[I] do
      case GetItemAlignVert(ViewInfo) of
        avTop:
          begin
            Bounds.Top := AItemsAreaBounds.Top;
            Bounds.Bottom := Bounds.Top + Height;
          end;
        avCenter:
          begin
            Bounds.Top := (AItemsAreaBounds.Top + AItemsAreaBounds.Bottom - Height) div 2;
            Bounds.Bottom := Bounds.Top + Height;
          end;
        avBottom:
          begin
            Bounds.Bottom := AItemsAreaBounds.Bottom;
            Bounds.Top := Bounds.Bottom - Height;
          end;
        avClient:
          begin
            Bounds.Top := AItemsAreaBounds.Top;
            Bounds.Bottom := AItemsAreaBounds.Bottom;
          end;
      end;
end;

procedure TdxLayoutGroupViewInfoSpecific.CalculateInternalTabOrders(var ATabOrder: Integer);
begin
// do nothing
end;

procedure TdxLayoutGroupViewInfoSpecific.CalculateItemViewInfos;
var
  I: Integer;
begin
  for I := 0 to ItemViewInfoCount - 1 do
  begin
    ConvertCoords(FItemInfos[I].Bounds);
    FItemInfos[I].ViewInfo.Calculate(FItemInfos[I].Bounds);
  end;
end;

function TdxLayoutGroupViewInfoSpecific.GetContainer: TdxLayoutContainer;
begin
  Result := GroupViewInfo.Group.Container;
end;

function TdxLayoutGroupViewInfoSpecific.GetItemOffset: Integer;
begin
  Result := FGroupViewInfo.ItemOffset;
end;

function TdxLayoutGroupViewInfoSpecific.GetItemViewInfo(Index: Integer): TdxCustomLayoutItemViewInfo;
begin
  Result := FGroupViewInfo.ItemViewInfos[Index];
end;

function TdxLayoutGroupViewInfoSpecific.GetItemViewInfoCount: Integer;
begin
  Result := FGroupViewInfo.ItemViewInfoCount;
end;

function TdxLayoutGroupViewInfoSpecific.GetLayoutDirection: TdxLayoutDirection;
begin
  Result := FGroupViewInfo.LayoutDirection;
end;

procedure TdxLayoutGroupViewInfoSpecific.CreateSpecificControls;
begin
// do nothing
end;

procedure TdxLayoutGroupViewInfoSpecific.DestroySpecificControls;
begin
// do nothing
end;

procedure TdxLayoutGroupViewInfoSpecific.CreateViewInfos;
begin
// do nothing
end;

procedure TdxLayoutGroupViewInfoSpecific.DestroyViewInfos;
begin
// do nothing
end;

function TdxLayoutGroupViewInfoSpecific.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TdxLayoutGroupViewInfoSpecific._AddRef: Integer;
begin
  Result := -1;
end;

function TdxLayoutGroupViewInfoSpecific._Release: Integer;
begin
  Result := -1;
end;

procedure TdxLayoutGroupViewInfoSpecific.AddSelectionControls;
begin
// do nothing
end;

procedure TdxLayoutGroupViewInfoSpecific.RemoveSelectionControls;
begin
// do nothing
end;

function TdxLayoutGroupViewInfoSpecific.CanFocus: Boolean;
begin
  Result := False;
end;

function TdxLayoutGroupViewInfoSpecific.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := True;
end;

procedure TdxLayoutGroupViewInfoSpecific.KeyDown(var Key: Word; Shift: TShiftState);
begin
// do nothing
end;

function TdxLayoutGroupViewInfoSpecific.CanDrawSpecificControls: Boolean;
begin
  Result := False;
end;

procedure TdxLayoutGroupViewInfoSpecific.DrawSpecificControls(ACanvas: TcxCanvas);
begin
// do nothing
end;

function TdxLayoutGroupViewInfoSpecific.GetCustomHeight(AIsMinHeight: Boolean): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to ItemViewInfoCount - 1 do
    if AIsMinHeight then
      Result := Max(Result, GetItemMinHeight(ItemViewInfos[I]))
    else
      Result := Max(Result, GetItemUsualHeight(ItemViewInfos[I]))
end;

function TdxLayoutGroupViewInfoSpecific.GetCustomWidth(AIsMinWidth: Boolean): Integer;
var
  AIsFirstItem: Boolean;
  I: Integer;
  AItemViewInfo: TdxCustomLayoutItemViewInfo;
begin
  Result := 0;
  AIsFirstItem := True;
  for I := 0 to ItemViewInfoCount - 1 do
  begin
    AItemViewInfo := ItemViewInfos[I];
    if GetItemAlignHorz(AItemViewInfo) <> ahCenter then
    begin
      if not AIsFirstItem then
        Inc(Result, ItemOffset);
      if AIsMinWidth then
        Inc(Result, GetItemMinWidth(AItemViewInfo))
      else
        Inc(Result, GetItemUsualWidth(AItemViewInfo));
      AIsFirstItem := False;
    end;
  end;
  for I := 0 to ItemViewInfoCount - 1 do
  begin
    AItemViewInfo := ItemViewInfos[I];
    if GetItemAlignHorz(AItemViewInfo) = ahCenter then
      if AIsMinWidth then
        Result := Max(Result, GetItemMinWidth(AItemViewInfo))
      else
        Result := Max(Result, GetItemUsualWidth(AItemViewInfo))
  end;
end;

procedure TdxLayoutGroupViewInfoSpecific.CorrectAreaPart(var AAreaPart: TdxLayoutAreaPart);
begin
// do nothing
end;

function TdxLayoutGroupViewInfoSpecific.GetAreaPart(const P: TPoint): TdxLayoutAreaPart;
begin
  Result := apNone;
  if (GroupViewInfo.Group.VisibleCount = 0) and PtInRect(dxGetCenterAreaBounds(GroupViewInfo.Bounds), P) then
    Result := apCenter;
end;

function TdxLayoutGroupViewInfoSpecific.GetAreaPartBounds(AAreaPart: TdxLayoutAreaPart; AItemViewInfo: TdxCustomLayoutItemViewInfo): TRect;
begin
  Result := cxInvalidRect;
end;

function TdxLayoutGroupViewInfoSpecific.GetItemsAreaOffset(ASide: TdxLayoutSide): Integer;
begin
  Result := 0;
end;

procedure TdxLayoutGroupViewInfoSpecific.ConvertCoords(var R: TRect);
begin
end;

procedure TdxLayoutGroupViewInfoSpecific.CalculateItemsBounds(AItemsAreaBounds: TRect);
begin
  ConvertCoords(AItemsAreaBounds);
  PrepareItemInfos;
  CalculateItemsHorizontalBounds(AItemsAreaBounds);
  CalculateItemsVerticalBounds(AItemsAreaBounds);
  CalculateItemViewInfos;
end;

function TdxLayoutGroupViewInfoSpecific.GetItemsAreaHeight(AIsMinHeight: Boolean): Integer;
begin
  Result := GetCustomHeight(AIsMinHeight);
end;

function TdxLayoutGroupViewInfoSpecific.GetItemsAreaWidth(AIsMinWidth: Boolean): Integer;
begin
  Result := GetCustomWidth(AIsMinWidth);
end;

function TdxLayoutGroupViewInfoSpecific.AllowDrawChild(AChildViewInfo: TdxCustomLayoutItemViewInfo): Boolean;
begin
  Result := True;
end;

function TdxLayoutGroupViewInfoSpecific.AllowChildHasBorder: Boolean;
begin
  Result := True;
end;

function TdxLayoutGroupViewInfoSpecific.GetChildInplaceRenameBounds(AChildViewInfo: TdxCustomLayoutItemViewInfo): TRect;
begin
  Result := cxNullRect;
end;

function TdxLayoutGroupViewInfoSpecific.GetDefaultItemControlAreaAlignment: TdxLayoutItemControlAreaAlignment;
begin
  if Container.GetAutoControlAlignment then
    Result := catAuto
  else
    Result := catNone;
end;

function TdxLayoutGroupViewInfoSpecific.ProcessDialogKey(ACharCode: Word; AKeyData: Integer; AFocusedItem: TdxLayoutItem): Boolean;
begin
  Result := False;
end;

{ TdxLayoutGroupHorizontalSpecific }

function TdxLayoutGroupViewInfoHorizontalSpecific.GetActionType(AAreaPart: TdxLayoutAreaPart): TdxLayoutActionType;
begin
  if AAreaPart in [apLeft, apRight, apAfter, apBefore] then
    Result := atInsert
  else
    Result := atCreateGroup;
end;

function TdxLayoutGroupViewInfoHorizontalSpecific.GetAreaPartBounds(AAreaPart: TdxLayoutAreaPart; AItemViewInfo: TdxCustomLayoutItemViewInfo): TRect;
begin
  if AAreaPart = apCenter then
  begin
    Result := GroupViewInfo.ClientBounds;
    with Result do
       Right := Left + dxLayoutThinPartWidth;
    InflateRect(Result, Integer(cxRectWidth(Result) = 0), Integer(cxRectHeight(Result) = 0));
  end
  else
    Result := inherited GetAreaPartBounds(AAreaPart, AItemViewInfo);
end;

function TdxLayoutGroupViewInfoHorizontalSpecific.GetItemAlignHorz(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignHorz;
begin
  Result := AViewInfo.AlignHorz;
end;

function TdxLayoutGroupViewInfoHorizontalSpecific.GetItemAlignVert(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignVert;
begin
  Result := AViewInfo.AlignVert;
end;

function TdxLayoutGroupViewInfoHorizontalSpecific.GetItemUsualHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Integer;
begin
  Result := AViewInfo.UsualHeight;
end;

function TdxLayoutGroupViewInfoHorizontalSpecific.GetItemUsualWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Integer;
begin
  Result := AViewInfo.UsualWidth;
end;

function TdxLayoutGroupViewInfoHorizontalSpecific.GetItemMinHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Integer;
begin
  Result := AViewInfo.MinHeight;
end;

function TdxLayoutGroupViewInfoHorizontalSpecific.GetItemMinWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Integer;
begin
  Result := AViewInfo.MinWidth;
end;

function TdxLayoutGroupViewInfoHorizontalSpecific.IsViewInfoFixedWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Boolean;
begin
  Result := (AViewInfo.GetAlignHorz <> ahClient) or not AViewInfo.IsExpanded;
end;

function TdxLayoutGroupViewInfoHorizontalSpecific.IsViewInfoFixedHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Boolean;
begin
  Result := (AViewInfo.GetAlignVert <> avClient) or not AViewInfo.IsExpanded;
end;

function TdxLayoutGroupViewInfoHorizontalSpecific.IsAtInsertionPos(const R: TRect;
  const P: TPoint): Boolean;
begin
  Result := P.X < (R.Left + R.Right) div 2;
end;

{ TdxLayoutGroupViewInfoVerticalSpecific }

procedure TdxLayoutGroupViewInfoVerticalSpecific.ConvertCoords(var R: TRect);
begin
  ExchangeLongWords(R.Left, R.Top);
  ExchangeLongWords(R.Right, R.Bottom);
end;

function TdxLayoutGroupViewInfoVerticalSpecific.GetActionType(AAreaPart: TdxLayoutAreaPart): TdxLayoutActionType;
begin
  if AAreaPart in [apTop, apBottom, apAfter, apBefore] then
    Result := atInsert
  else
    Result := atCreateGroup;
end;

function TdxLayoutGroupViewInfoVerticalSpecific.GetAreaPartBounds(AAreaPart: TdxLayoutAreaPart; AItemViewInfo: TdxCustomLayoutItemViewInfo): TRect;
begin
  if AAreaPart = apCenter then
  begin
    Result := GroupViewInfo.ClientBounds;
    with Result do
      Bottom := Top + dxLayoutThinPartWidth;
    InflateRect(Result, Integer(cxRectWidth(Result) = 0), Integer(cxRectHeight(Result) = 0));
  end
  else
    Result := inherited GetAreaPartBounds(AAreaPart, AItemViewInfo);
end;

function TdxLayoutGroupViewInfoVerticalSpecific.GetItemAlignHorz(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignHorz;
begin
  Result := TdxLayoutAlignHorz(AViewInfo.AlignVert);
end;

function TdxLayoutGroupViewInfoVerticalSpecific.GetItemAlignVert(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignVert;
begin
  Result := TdxLayoutAlignVert(AViewInfo.AlignHorz);
end;

function TdxLayoutGroupViewInfoVerticalSpecific.GetItemUsualHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Integer;
begin
  Result := AViewInfo.UsualWidth;
end;

function TdxLayoutGroupViewInfoVerticalSpecific.GetItemUsualWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Integer;
begin
  Result := AViewInfo.UsualHeight;
end;

function TdxLayoutGroupViewInfoVerticalSpecific.GetItemMinHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Integer;
begin
  Result := AViewInfo.MinWidth;
end;

function TdxLayoutGroupViewInfoVerticalSpecific.GetItemMinWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Integer;
begin
  Result := AViewInfo.MinHeight;
end;

function TdxLayoutGroupViewInfoVerticalSpecific.IsViewInfoFixedWidth(AViewInfo: TdxCustomLayoutItemViewInfo): Boolean;
begin
  Result := (AViewInfo.GetAlignVert <> avClient) or not AViewInfo.IsExpanded;
end;

function TdxLayoutGroupViewInfoVerticalSpecific.IsViewInfoFixedHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Boolean;
begin
  Result := (AViewInfo.GetAlignHorz <> ahClient) or not AViewInfo.IsExpanded;
end;

function TdxLayoutGroupViewInfoVerticalSpecific.GetItemsAreaHeight(AIsMinHeight: Boolean): Integer;
begin
  Result := inherited GetItemsAreaWidth(AIsMinHeight);
end;

function TdxLayoutGroupViewInfoVerticalSpecific.GetItemsAreaWidth(AIsMinWidth: Boolean): Integer;
begin
  Result := inherited GetItemsAreaHeight(AIsMinWidth);
end;

function TdxLayoutGroupViewInfoVerticalSpecific.IsAtInsertionPos(const R: TRect;
  const P: TPoint): Boolean;
begin
  Result := P.Y < (R.Top + R.Bottom) div 2;
end;

{ TdxLayoutTabbedController }

function TdxLayoutTabbedController.GetClientToScreen(const APoint: TPoint): TPoint;
begin
  Result := inherited GetClientToScreen(APoint);
  Result := cxPointOffset(Result, ViewInfo.BoundsRect.TopLeft);
end;

function TdxLayoutTabbedController.GetScreenToClient(const APoint: TPoint): TPoint;
begin
  Result := inherited GetScreenToClient(APoint);
  Result := cxPointOffset(Result, ViewInfo.BoundsRect.TopLeft, False);
end;

procedure TdxLayoutTabbedController.DoTabClick(ATabVisibleIndex: Integer; AShift: TShiftState);
begin
  inherited;
  if Assigned(OnTabClick) then
    OnTabClick(Self, ATabVisibleIndex);
end;

{ TdxLayoutTabbedViewInfo }

function TdxLayoutTabbedViewInfo.GetTabIndex: Integer;
begin
  Result := GroupViewInfo.ItemIndex;
end;

procedure TdxLayoutTabbedViewInfo.SetTabIndex(Value: Integer);
begin
  if GroupViewInfo.IsClone then
    GroupViewInfo.CloneData.ItemIndex := Value
  else
    inherited;
end;

function TdxLayoutTabbedViewInfo.GetGroupViewInfo: TdxLayoutGroupViewInfo;
begin
  Result := TdxLayoutGroupViewInfoTabbedSpecific(Owner).GroupViewInfo;
end;

{ TdxTabControlElementViewInfo }

function TdxTabControlElementViewInfo.GetVisible: Boolean;
begin
  Result := not cxRectIsEmpty(Bounds);
end;

procedure TdxTabControlElementViewInfo.MouseLeave;
begin
  FTabController.MouseLeave;
end;

procedure TdxTabControlElementViewInfo.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
  P := cxPointOffset(Point(X, Y), FTabViewInfo.BoundsRect.TopLeft, False);
  if FTabViewInfo.CanFocusOnClick(P.X, P.Y) then
    ItemViewInfo.ContainerViewInfo.Container.FocusedController.CurrentTabOrderIndex := ItemViewInfo.FTabOrderIndex;
  FTabController.MouseDown(Button, Shift, P.X, P.Y);
end;

procedure TdxTabControlElementViewInfo.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ATabIndex: Integer;
  AClientPoint: TPoint;
begin
  FTabController.MouseMove(Shift, X - FTabViewInfo.BoundsRect.Left, Y - FTabViewInfo.BoundsRect.Top);
  if (dxLayoutDragAndDropObject <> nil) and dxLayoutDragAndDropObject.CanDrop then
  begin
    AClientPoint := cxPointOffset(Point(X, Y), FTabViewInfo.BoundsRect.TopLeft, False);
    ATabIndex := FTabViewInfo.IndexOfTabAt(AClientPoint.X, AClientPoint.Y);
    if ATabIndex <> -1 then
      Group.ItemIndex := ATabIndex;            
  end;
end;

procedure TdxTabControlElementViewInfo.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Group.BeginUpdate;
  try
    FTabController.MouseUp(Button, Shift, X - FTabViewInfo.BoundsRect.Left, Y - FTabViewInfo.BoundsRect.Top);
  finally
    Group.CancelUpdate;
    if Group.HasTabbedChanges then
      Group.Changed;
  end;
end;

function TdxTabControlElementViewInfo.GetGroup: TdxLayoutGroup;
begin
  Result := Item as TdxLayoutGroup;
end;

{ TdxLayoutGroupViewInfoTabbedSpecific }

constructor TdxLayoutGroupViewInfoTabbedSpecific.Create(AGroupViewInfo: TdxLayoutGroupViewInfo);
begin
  inherited;
  FTabControlElementViewInfo := TdxTabControlElementViewInfo.Create(GroupViewInfo);
  FTabControlElementViewInfoOpposite := TdxTabControlElementViewInfo.Create(GroupViewInfo);
end;

destructor TdxLayoutGroupViewInfoTabbedSpecific.Destroy;
begin
  FreeAndNil(FTabControlElementViewInfoOpposite);
  FreeAndNil(FTabControlElementViewInfo);
  inherited;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.AllowDrawChild(AChildViewInfo: TdxCustomLayoutItemViewInfo): Boolean;
begin
  Result := inherited AllowDrawChild(AChildViewInfo) and (AChildViewInfo.Item.Index = GroupViewInfo.ItemIndex);
end;

function TdxLayoutGroupViewInfoTabbedSpecific.AllowChildHasBorder: Boolean;
begin
  Result := False;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetChildInplaceRenameBounds(AChildViewInfo: TdxCustomLayoutItemViewInfo): TRect;
begin
  if HasTabControl then
    Result := cxRectOffset(FTabViewInfo.TabsViewInfo[AChildViewInfo.Item.VisibleIndex].VisibleRect, FTabControlBounds.TopLeft)
  else
    Result := cxNullRect;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetDefaultItemControlAreaAlignment: TdxLayoutItemControlAreaAlignment;
begin
  Result := catNone;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.ProcessDialogKey(ACharCode: Word; AKeyData: Integer; AFocusedItem: TdxLayoutItem): Boolean;
begin
  Result := GroupViewInfo.Group.IsChildItem(AFocusedItem) and FTabController.KeyDown(ACharCode, KeyDataToShiftState(AKeyData));
  if Result and not GroupViewInfo.Group.DoProcessAccel then
    Container.FocusedController.SetItemFocus(GroupViewInfo.GetGroup);
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CalculateItemsAreaBounds(var AItemsAreaBounds: TRect);
begin
  FTabControlBounds := AItemsAreaBounds;
  CalculateTabControl;
  inherited;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CalculateItemsHorizontalBounds(const AItemsAreaBounds: TRect);
var
  I: Integer;
begin
  for I := 0 to ItemViewInfoCount - 1 do
    with FItemInfos[I] do
    begin
      RealWidth := UsualWidth;

      case GetItemAlignHorz(ViewInfo) of
        ahLeft:
          begin
            Bounds.Left := AItemsAreaBounds.Left;
            Bounds.Right := Bounds.Left + RealWidth;
          end;
        ahCenter:
          begin
            Bounds.Left := (AItemsAreaBounds.Left + AItemsAreaBounds.Right - RealWidth) div 2;
            Bounds.Right := Bounds.Left + RealWidth;
          end;
        ahRight:
          begin
            Bounds.Right := AItemsAreaBounds.Right;
            Bounds.Left := Bounds.Right - RealWidth;
          end;
        ahClient:
          begin
            Bounds.Left := AItemsAreaBounds.Left;
            Bounds.Right := AItemsAreaBounds.Right;
          end;
      end;
    end;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CalculateInternalTabOrders(var ATabOrder: Integer);
begin
  if CanFocus then
  begin
    GroupViewInfo.FTabOrderIndex := ATabOrder;
    Inc(ATabOrder);
  end;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CalculateTabControl;

  function GetTabsRect(AIsOpposite: Boolean): TRect;
  const
    ATabPositionMap: array[Boolean, TcxTabPosition] of TcxTabPosition =
      ((tpTop, tpBottom, tpLeft, tpRight),
      (tpBottom, tpTop, tpRight, tpLeft));
  begin
    Result := FTabViewInfo.BoundsRect;
    case ATabPositionMap[AIsOpposite, TabbedOptions.TabPosition] of
      tpTop:
        Result.Bottom := Result.Top + FTabViewInfo.PageClientRectOffset.Top;
      tpBottom:
        Result.Top := Result.Bottom - FTabViewInfo.PageClientRectOffset.Bottom;
      tpLeft:
        Result.Right := Result.Left + FTabViewInfo.PageClientRectOffset.Left;
      tpRight:
        Result.Left := Result.Right - FTabViewInfo.PageClientRectOffset.Right;
    end;
  end;

  procedure CalculateElementViewInfo(AElementViewInfo: TdxTabControlElementViewInfo; const ABounds: TRect);
  begin
    AElementViewInfo.Calculate(ABounds);
    AElementViewInfo.FTabController := FTabController;
    AElementViewInfo.FTabViewInfo := FTabViewInfo;
  end;

begin
  if HasTabControl then
  begin
    TabbedOptions.BeginUpdate;
    try
      TabbedOptions.RefreshTabsEnabled;
      TabbedOptions.TabIndex := GroupViewInfo.ItemIndex;
    finally
      TabbedOptions.CancelUpdate;
    end;
    FTabViewInfo.Calculate;
    CalculateElementViewInfo(FTabControlElementViewInfo, GetTabsRect(False));
    if TabbedOptions.ScrollOpposite and TabbedOptions.MultiLine and (FTabViewInfo.RowCount > 1) then
      CalculateElementViewInfo(FTabControlElementViewInfoOpposite, GetTabsRect(True))
    else
      CalculateElementViewInfo(FTabControlElementViewInfoOpposite, cxEmptyRect);
  end
  else
  begin
    CalculateElementViewInfo(FTabControlElementViewInfo, cxEmptyRect);
    CalculateElementViewInfo(FTabControlElementViewInfoOpposite, cxEmptyRect);
  end;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetActionType(AAreaPart: TdxLayoutAreaPart): TdxLayoutActionType;
begin
  Result := atInsert;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CorrectAreaPart(var AAreaPart: TdxLayoutAreaPart);
begin
  if AAreaPart in [apLeft, apTop, apRight, apBottom] then
    AAreaPart := apBefore;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetAreaPart(const P: TPoint): TdxLayoutAreaPart;
begin
  if HasTabControl and PtInRect(FTabControlBounds, P) then
    Result := apLastChild
  else
    Result := inherited GetAreaPart(P);
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetAreaPartBounds(AAreaPart: TdxLayoutAreaPart;
  AItemViewInfo: TdxCustomLayoutItemViewInfo): TRect;

  function GetBorder: TcxBorder;
  const
    ResultMap: array[Boolean, TcxTabPosition] of TcxBorder = ((bLeft, bLeft, bTop, bTop), (bRight, bRight, bBottom, bBottom));
  begin
    Result := ResultMap[not HasTabControl or
      ((AAreaPart = apBefore) xor not (FTabViewInfo.IsRightToLeftAlignment or FTabViewInfo.IsBottomToTopAlignment)),
      TabbedOptions.TabPosition];
  end;

begin
  case AAreaPart of
    apBefore, apAfter:
      Result := FTabViewInfo.GetTabViewInfo(TabbedOptions.Tabs[GroupViewInfo.ItemIndex]).VisibleRect;
    apLastChild:
      Result := FTabViewInfo.GetTabViewInfo(TabbedOptions.Tabs[TabbedOptions.Tabs.Count - 1]).VisibleRect;
  else
    Result := inherited GetAreaPartBounds(AAreaPart, AItemviewInfo);
  end;
  case GetBorder of
    bLeft:
      Result.Right := Result.Left + dxLayoutThinPartWidth;
    bTop:
      Result.Bottom := Result.Top + dxLayoutThinPartWidth;
    bRight:
      Result.Left := Result.Right - dxLayoutThinPartWidth;
    bBottom:
      Result.Top := Result.Bottom - dxLayoutThinPartWidth;
  end;
  OffsetRect(Result, FTabControlBounds.Left, FTabControlBounds.Top);
end;

function TdxLayoutGroupViewInfoTabbedSpecific.CanDrawSpecificControls: Boolean;
begin
  Result := HasTabControl and GroupViewInfo.IsExpanded;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.DrawSpecificControls(ACanvas: TcxCanvas);
begin
  if not HasTabControl then
    inherited
  else
    DrawTabControl(ACanvas);
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetCustomHeight(AIsMinHeight: Boolean): Integer;
begin
  Result := inherited GetCustomHeight(AIsMinHeight);
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetCustomWidth(AIsMinWidth: Boolean): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to ItemViewInfoCount - 1 do
    if AIsMinWidth then
      Result := Max(Result, GetItemMinWidth(ItemViewInfos[I]))
    else
      Result := Max(Result, GetItemUsualWidth(ItemViewInfos[I]))
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetItemsAreaOffset(ASide: TdxLayoutSide): Integer;
begin
  Result := inherited GetItemsAreaOffset(ASide);

  if HasTabControl then
  begin
    Inc(Result, GroupViewInfo.LayoutLookAndFeel.GetGroupBorderOffset(Container.ILayoutFontHelper, ASide, GroupViewInfo.CaptionSide));
    case ASide of
      sdLeft: Inc(Result, FTabViewInfo.PageClientRectOffset.Left);
      sdRight: Inc(Result, FTabViewInfo.PageClientRectOffset.Right);
      sdTop: Inc(Result, FTabViewInfo.PageClientRectOffset.Top);
      sdBottom: Inc(Result, FTabViewInfo.PageClientRectOffset.Bottom);
    end;
  end;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetHitTabIndex(const P: TPoint): Integer;
var
  AClientPoint: TPoint;
begin
  if HasTabControl then
  begin
    AClientPoint := cxPointOffset(P, Point(FTabControlBounds.Left, FTabControlBounds.Top), False);
    Result := FTabViewInfo.VisibleIndexOfTabAt(AClientPoint.X, AClientPoint.Y);
  end
  else
    Result := -1;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.CanFocus: Boolean;
begin
  Result := HasTabControl and (FTabViewInfo.TabsViewInfo.ViewInfoCount > 0);
end;

function TdxLayoutGroupViewInfoTabbedSpecific.CanFocusOnClick(X, Y: Integer): Boolean;
var
  P: TPoint;
begin
  P := cxPointOffset(Point(X, Y), FTabControlBounds.TopLeft, False);
  Result := CanFocus and FTabViewInfo.CanFocusOnClick(P.X, P.Y);
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if HasTabControl then
    FTabController.KeyDown(Key, Shift);
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CreateSpecificControls;
begin
  inherited CreateSpecificControls;
  CreateTabControl;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.DestroySpecificControls;
begin
  DestroyTabControl;
  inherited DestroySpecificControls;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CreateViewInfos;
begin
  inherited;
  GroupViewInfo.FElements.Add(FTabControlElementViewInfo);
  GroupViewInfo.FElements.Add(FTabControlElementViewInfoOpposite);
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.DestroyViewInfos;
begin
  GroupViewInfo.FElements.Extract(FTabControlElementViewInfoOpposite);
  GroupViewInfo.FElements.Extract(FTabControlElementViewInfo);
  inherited;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CreateTabControl;
begin
  if GroupViewInfo.Group.VisibleCount = 0 then
    Exit;

  FTabControlBounds := Rect(0, 0, 289, 193);
  FTabViewInfo := TdxLayoutTabbedViewInfo.Create(Self);
  FTabController := TdxLayoutTabbedController.Create(Self);
  FTabController.OnTabClick := TabClick;
  FTabPainter := FTabViewInfo.GetPainterClass.Create(FTabViewInfo);
  TabbedOptions.RefreshTabsCaption;
  TabbedOptions.RefreshImages;
  FTabViewInfo.Calculate;
  FTabViewInfo.FirstVisibleTab := -1;
  FTabViewInfo.MainTabVisibleIndex := -1;
  FTabViewInfo.LastVisibleTab := -1;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.DestroyTabControl;
begin
  FreeAndNil(FTabPainter);
  FreeAndNil(FTabViewInfo);
  FreeAndNil(FTabController);
end;

function TdxLayoutGroupViewInfoTabbedSpecific.HasTabControl: Boolean;
begin
  Result := FTabViewInfo <> nil;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetTabController: TcxCustomTabControlController;
begin
  Result := FTabController;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetTabPainter: TcxPCCustomPainter;
begin
  Result := FTabPainter;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetTabProperties: TcxCustomTabControlProperties;
begin
  Result := TabbedOptions;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetTabViewInfo: TcxCustomTabControlViewInfo;
begin
  Result := FTabViewInfo;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.CanDrawTabParentBackground: Boolean;
begin
  Result := GroupViewInfo.HasBackground;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetTabBoundsRect: TRect;
begin
  Result := FTabControlBounds;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetCanvas: TcxCanvas;
begin
  Result := GroupViewInfo.ContainerViewInfo.Canvas;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetControl: TWinControl;
begin
  Result := Container.GetItemsParent;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetTabColor: TColor;
begin
  Result := GroupViewInfo.Color;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetDragAndDropObject: TcxDragAndDropObject;
begin
  Result := nil;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetDragAndDropState: TcxDragAndDropState;
begin
  Result := ddsNone;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetFont: TFont;
begin
  Result := Container.ILayoutFontHelper.GetDefaultFont;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := TdxCustomLayoutLookAndFeelAccess(GroupViewInfo.GetLayoutLookAndFeel).LookAndFeel;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.InvalidateTabRect(const R: TRect; AEraseBackground: Boolean);
var
  ABounds: TRect;
begin
  ABounds := cxRectOffset(R, FTabControlBounds.TopLeft);
  Container.InvalidateRect(ABounds, AEraseBackground);
  Container.PostInvalidateSelectionLayer(ABounds);
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.SetModified;
begin
  Container.Modified;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.IsEnabled: Boolean;
begin
  Result := GroupViewInfo.Enabled;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.IsDesigning: Boolean;
begin
  Result := GroupViewInfo.Group.IsDesigning;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.IsDestroying: Boolean;
begin
  Result := GroupViewInfo.Group.IsDestroying;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.IsFocused: Boolean;
begin
  Result := CanFocus and GroupViewInfo.Group.IsFocused;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.IsLoading: Boolean;
begin
  Result := GroupViewInfo.Group.IsLoading;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.IsParentBackground: Boolean;
begin
  Result := True;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.RequestLayout;
begin
  if HasTabControl then
  begin
    FTabViewInfo.Calculate;
    InvalidateTabRect(FTabViewInfo.ControlBounds, True);
  end;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.DrawTabControl(ACanvas: TcxCanvas);
var
  P: TPoint;
begin
  ACanvas.SaveState;
  try
    P := ACanvas.WindowOrg;
    P := cxPointOffset(FTabControlBounds.TopLeft, P, False);
    ACanvas.WindowOrg := cxPointInvert(P);
    ACanvas.SetClipRegion(TcxRegion.Create(FTabViewInfo.ClientRect), roIntersect);   
    if not GroupViewInfo.CanDrawSpecificBackground then
      ACanvas.SetClipRegion(TcxRegion.Create(FTabViewInfo.PageClientRect), roSubtract);
    FTabPainter.Paint(ACanvas);
  finally
    ACanvas.RestoreState;
  end;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetTabbedOptions: TdxLayoutTabbedOptions;
begin
  Result := GroupViewInfo.Group.TabbedOptions;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.TabClick(ASender: TObject; ATabIndex: Integer);
begin
  GroupViewInfo.Group[ATabIndex].DoCaptionClick;
end;

{ TdxLayoutGroupButtonsViewInfo }

constructor TdxLayoutGroupButtonsViewInfo.Create(AItemViewInfo: TdxCustomLayoutItemViewInfo);
begin
  inherited Create(AItemViewInfo);
  CreateButtonViewInfos;
end;

destructor TdxLayoutGroupButtonsViewInfo.Destroy;
begin
  DestroyButtonViewInfos;
  inherited Destroy;
end;

procedure TdxLayoutGroupButtonsViewInfo.Calculate(const ABounds: TRect);
begin
  inherited;
  RecreateButtonViewInfos;
  CalculateButtonViewInfos;
end;

function TdxLayoutGroupButtonsViewInfo.CalculateHeight: Integer;
begin
  if GroupViewInfo.IsVerticalCaption then
    Result := InternalCalculateWidth
  else
    Result := InternalCalculateHeight;
end;

function TdxLayoutGroupButtonsViewInfo.CalculateMinHeight: Integer;
begin
  Result := CalculateHeight;
end;

function TdxLayoutGroupButtonsViewInfo.CalculateMinWidth: Integer;
begin
  Result := CalculateWidth;
end;

function TdxLayoutGroupButtonsViewInfo.CalculateWidth: Integer;
begin
  if GroupViewInfo.IsVerticalCaption then
    Result := InternalCalculateHeight
  else
    Result := InternalCalculateWidth;
end;

function TdxLayoutGroupButtonsViewInfo.GetVisible: Boolean;
begin
  Result := GroupViewInfo.HasButtons;
end;

procedure TdxLayoutGroupButtonsViewInfo.CalculateHorizontalLayout;
var
  AOffsetX, AOffsetY: Integer;
  I: Integer;
  R: TRect;
begin
  if Visible then
  begin
    AOffsetX := GroupViewInfo.GetButtonsViewInfoSpace;
    for I := 0 to ButtonViewInfoCount - 1 do
    begin
      AOffsetY := (cxRectHeight(Bounds) - ButtonViewInfos[I].Height) div 2;
      if GroupViewInfo.CaptionSide = sdTop then
      begin
        R.Top := Bounds.Top + AOffsetY;
        R.Bottom := R.Top + ButtonViewInfos[I].Button.GetHeight;
      end
      else
      begin
        R.Bottom := Bounds.Bottom - AOffsetY;
        R.Top := R.Bottom - ButtonViewInfos[I].Button.GetHeight;
      end;
      R.Left := Bounds.Left + AOffsetX;
      R.Right := R.Left + ButtonViewInfos[I].Button.GetWidth;
      ButtonViewInfos[I].Calculate(R);
      Inc(AOffsetX, ButtonViewInfos[I].Width + GroupViewInfo.GetSpaceBetweenButtons);
    end;
  end;
end;

procedure TdxLayoutGroupButtonsViewInfo.CalculateVerticalLayout;
var
  AOffsetX, AOffsetY: Integer;
  I: Integer;
  R: TRect;
begin
  if Visible then
  begin
    AOffsetY := GroupViewInfo.GetButtonsViewInfoSpace;
    for I := 0 to ButtonViewInfoCount - 1 do
    begin
      AOffsetX := (cxRectWidth(Bounds) - ButtonViewInfos[I].Height) div 2;

      if GroupViewInfo.CaptionSide = sdLeft then
      begin
        R.Left := Bounds.Left + AOffsetX;
        R.Bottom := Bounds.Bottom - AOffsetY;
        R.Right := R.Left + ButtonViewInfos[I].Button.GetHeight;
        R.Top := R.Bottom - ButtonViewInfos[I].Button.GetWidth;
      end
      else
      begin
        R.Right := Bounds.Right - AOffsetX;
        R.Top := Bounds.Top + AOffsetY;
        R.Left := R.Right - ButtonViewInfos[I].Button.GetHeight;
        R.Bottom := R.Top + ButtonViewInfos[I].Button.GetWidth;
      end;

      ButtonViewInfos[I].Calculate(R);
      Inc(AOffsetY, ButtonViewInfos[I].Height + GroupViewInfo.GetSpaceBetweenButtons);
    end;
  end;
end;

procedure TdxLayoutGroupButtonsViewInfo.CalculateButtonViewInfos;
begin
  if GroupViewInfo.IsVerticalCaption then
    CalculateVerticalLayout
  else
    CalculateHorizontalLayout;
end;

procedure TdxLayoutGroupButtonsViewInfo.CreateButtonViewInfos;

  procedure CreateButtonViewInfo(AButton: TdxLayoutGroupButton);
  var
    AButtonViewInfo: TdxLayoutGroupButtonViewInfo;
  begin
    AButtonViewInfo := TdxLayoutGroupButtonViewInfo.Create(Self, AButton);
    FButtonViewInfos.Add(AButtonViewInfo);
    ItemViewInfo.FElements.Add(AButtonViewInfo);
  end;

var
  I: Integer;
begin
  FButtonViewInfos := TcxObjectList.Create;
  if GroupViewInfo.HasExpandButton then
    CreateButtonViewInfo(ExpandButton);
  if Options.Visible then
    for I := 0 to Options.Buttons.Count - 1 do
      if Options.Buttons[I].Visible then
        CreateButtonViewInfo(Options.Buttons[I]);
end;

procedure TdxLayoutGroupButtonsViewInfo.RecreateButtonViewInfos;
begin
  DestroyButtonViewInfos;
  CreateButtonViewInfos;
end;

procedure TdxLayoutGroupButtonsViewInfo.DestroyButtonViewInfos;
var
  I: Integer;
begin
  for I := 0 to ButtonViewInfoCount - 1 do
    ItemViewInfo.FElements.Extract(ButtonViewInfos[I]);
  FreeAndNil(FButtonViewInfos);
end;

function TdxLayoutGroupButtonsViewInfo.InternalCalculateHeight: Integer;

  function GetMaxButtonHeight: Integer;
  var
    I: Integer;
  begin
    if GroupViewInfo.HasExpandButton then
      Result := ExpandButton.GetHeight
    else
      Result := 0;
    if Options.Visible then
      for I := 0 to Options.Buttons.Count - 1 do
        if Options.Buttons[I].Visible then
          Result := Max(Result, Options.Buttons[I].GetHeight);
  end;

begin
  if GetVisible then
    Result := GetMaxButtonHeight
  else
    Result := 0;
end;

function TdxLayoutGroupButtonsViewInfo.InternalCalculateWidth: Integer;
var
  I: Integer;
  AVisibleIndex: Integer;
begin
  if GetVisible then
  begin
    Result := 0;
    AVisibleIndex := 0;
    if GroupViewInfo.HasExpandButton then
    begin
      Inc(Result, ExpandButton.GetWidth);
      Inc(AVisibleIndex);
    end;
    if Options.Visible then
      for I := 0 to Options.Buttons.Count - 1 do
        if Options.Buttons[I].Visible then
        begin
          Inc(Result, Options.Buttons[I].GetWidth + IfThen(AVisibleIndex > 0, GroupViewInfo.GetSpaceBetweenButtons));
          Inc(AVisibleIndex);
        end;
    Result := Result + GroupViewInfo.GetButtonsViewInfoSpace * 2;
  end
  else
    Result := 0;
end;

procedure TdxLayoutGroupButtonsViewInfo.DoSetOffset(const Value: TPoint);
var
  I: Integer;
begin
  inherited;
  for I := 0 to ButtonViewInfoCount - 1 do
    ButtonViewInfos[I].Offset := Value;
end;

function TdxLayoutGroupButtonsViewInfo.IsLeftAlignment: Boolean;
begin
  Result := Options.Alignment = gbaLeft;
end;

function TdxLayoutGroupButtonsViewInfo.GetButtonViewInfos(Index: Integer): TdxLayoutGroupButtonViewInfo;
begin
  Result := FButtonViewInfos[Index] as TdxLayoutGroupButtonViewInfo;
end;

function TdxLayoutGroupButtonsViewInfo.GetButtonViewInfoCount: Integer;
begin
  Result := FButtonViewInfos.Count;
end;

function TdxLayoutGroupButtonsViewInfo.GetExpandButton: TdxLayoutGroupButton;
begin
  Result := GroupViewInfo.Group.ButtonOptions.ExpandButton;
end;

function TdxLayoutGroupButtonsViewInfo.GetGroupViewInfo: TdxLayoutGroupViewInfo;
begin
  Result := ItemViewInfo as TdxLayoutGroupViewInfo;
end;

function TdxLayoutGroupButtonsViewInfo.GetOptions: TdxLayoutGroupButtonOptions;
begin
  Result := (ItemViewInfo.Item as TdxLayoutGroup).ButtonOptions;
end;

{ TdxLayoutGroupButtonViewInfo }

constructor TdxLayoutGroupButtonViewInfo.Create(AButtonsViewInfo: TdxLayoutGroupButtonsViewInfo; AButton: TdxLayoutGroupButton);
begin
  inherited Create(AButtonsViewInfo.ItemViewInfo);
  FButton := AButton;
  FButtonsViewInfo := AButtonsViewInfo;
end;

function TdxLayoutGroupButtonViewInfo.CalculateHeight: Integer;
begin
  Result := Button.GetHeight;
end;

function TdxLayoutGroupButtonViewInfo.CalculateWidth: Integer;
begin
  Result := Button.GetWidth;
end;

procedure TdxLayoutGroupButtonViewInfo.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AExecuteClick: Boolean;
begin
  AExecuteClick := (levsPressed in State) and IsEnabled and not ItemViewInfo.Item.Container.IsCustomization;
  inherited;
  if AExecuteClick then
    DoClick;
end;

procedure TdxLayoutGroupButtonViewInfo.DoClick;
begin
  ButtonsViewInfo.GroupViewInfo.DoButtonClick(Self);
end;

procedure TdxLayoutGroupButtonViewInfo.StateChanged;
begin
  Invalidate(OriginalBounds);
end;

function TdxLayoutGroupButtonViewInfo.IsHotTrackable: Boolean;
begin
  Result := LayoutLookAndFeel.IsButtonHotTrack;
end;

function TdxLayoutGroupButtonViewInfo.ShowHint(var AHintInfo: THintInfo): Boolean;
begin
  if IsEnabled then
  begin
    AHintInfo.HintData := @AHintInfo;
    AHintInfo.CursorRect := Bounds;
    AHintInfo.HintStr := GetShortHint(Button.Hint);
    Result := AHintInfo.HintStr <> '';
  end
  else
    Result := inherited ShowHint(AHintInfo);
end;

function TdxLayoutGroupButtonViewInfo.GetVisible: Boolean;
begin
  Result := Button.Visible;
end;

function TdxLayoutGroupButtonViewInfo.GetPainterClass: TdxLayoutGroupButtonPainterClass;
begin
  Result := TdxLayoutGroupButtonPainter;
end;

function TdxLayoutGroupButtonViewInfo.GetState: TcxButtonState;
begin
  Result := cxbsNormal;
  if not IsEnabled then
    Result := cxbsDisabled
  else
    if levsPressed in State then
      Result := cxbsPressed
    else
      if levsHot in State then
        Result := cxbsHot;
end;

function TdxLayoutGroupButtonViewInfo.IsGroupExpanded: Boolean;
begin
  Result := ButtonsViewInfo.GroupViewInfo.IsExpanded;
end;

function TdxLayoutGroupButtonViewInfo.IsExpandButton: Boolean;
begin
  Result := Button.IsExpandButton;
end;

function TdxLayoutGroupButtonViewInfo.GetGlyph: TBitmap;
begin
  Result := Button.Glyph;
end;

function TdxLayoutGroupButtonViewInfo.GetIsEnabled: Boolean;
begin
  Result := Button.Enabled and ButtonsViewInfo.GroupViewInfo.Enabled;
end;

function TdxLayoutGroupButtonViewInfo.GetVisibleIndex: Integer;
var
  I: Integer;
begin
  Result := -1;
  if Visible then
    for I := 0 to ButtonsViewInfo.ButtonViewInfoCount - 1 do
    begin
      if ButtonsViewInfo.ButtonViewInfos[I].Visible then
        Inc(Result);
      if ButtonsViewInfo.ButtonViewInfos[I] = Self then
        Break;
    end;
end;

{ TdxLayoutGroupViewInfoCloneData }

procedure TdxLayoutGroupViewInfoCloneData.Assign(Source: TdxCustomLayoutItemViewInfoCloneData);
begin
  if Source is TdxLayoutGroupViewInfoCloneData then
  begin
    FIsExpanded := (Source as TdxLayoutGroupViewInfoCloneData).IsExpanded;
    FItemIndex := (Source as TdxLayoutGroupViewInfoCloneData).ItemIndex;
  end;
  inherited;
end;

procedure TdxLayoutGroupViewInfoCloneData.Calculate;
begin
  inherited;
  FIsExpanded := (Item as TdxLayoutGroup).IsExpanded;
  FItemIndex := (Item as TdxLayoutGroup).ItemIndex;
end;

procedure TdxLayoutGroupViewInfoCloneData.Load(AStream: TStream);
begin
  inherited;
  AStream.Read(FIsExpanded, SizeOf(Boolean));
  AStream.Read(FItemIndex, SizeOf(Integer));
end;

procedure TdxLayoutGroupViewInfoCloneData.Save(AStream: TStream);
begin
  inherited;
  AStream.Write(FIsExpanded, SizeOf(Boolean));
  AStream.Write(FItemIndex, SizeOf(Integer));
end;

procedure TdxLayoutGroupViewInfoCloneData.SetIsExpanded(Value: Boolean);
begin
  if IsExpanded <> Value then
  begin
    FIsExpanded := Value;
    Changed;
  end;
end;

procedure TdxLayoutGroupViewInfoCloneData.SetItemIndex(Value: Integer);
begin
  if ItemIndex <> Value then
  begin
    FItemIndex := Value;
    Changed;
  end;
end;

{ TdxLayoutGroupViewInfo }

function TdxLayoutGroupViewInfo.GetBorderBounds(ASide: TdxLayoutSide): TRect;
begin
  Result := Bounds;
  with ClientBounds do
    case ASide of
      sdLeft:
        Result.Right := Left;
      sdTop:
        Result.Bottom := Top;
      sdRight:
        Result.Left := Right;
      sdBottom:
        Result.Top := Bottom;
    end;
end;

function TdxLayoutGroupViewInfo.GetBorderRestSpaceBounds(ASide: TdxLayoutSide): TRect;
begin
  Result := RestSpaceBounds;
  with ClientBounds do
    case ASide of
      sdLeft:
        Result.Right := Left;
      sdTop:
        Result.Bottom := Top;
      sdRight:
        Result.Left := Right;
      sdBottom:
        Result.Top := Bottom;
    end;
end;

function TdxLayoutGroupViewInfo.GetBordersHeight: Integer;
begin
  Result := BorderWidths[sdLeft] + BorderWidths[sdRight];
end;

function TdxLayoutGroupViewInfo.GetBordersWidth: Integer;
begin
  Result := BorderWidths[sdTop] + BorderWidths[sdBottom];
end;

function TdxLayoutGroupViewInfo.GetCaptionSide: TdxLayoutSide;
const
  ResultMap: array[TdxCaptionLayout] of TdxLayoutSide = (sdLeft, sdTop, sdRight, sdBottom);
begin
  Result := ResultMap[Group.CaptionOptions.Layout];
end;

function TdxLayoutGroupViewInfo.GetCaptionViewInfo: TdxLayoutGroupCaptionViewInfo;
begin
  Result := TdxLayoutGroupCaptionViewInfo(inherited CaptionViewInfo);
end;

function TdxLayoutGroupViewInfo.GetCloneData: TdxLayoutGroupViewInfoCloneData;
begin
  Result := inherited CloneData as TdxLayoutGroupViewInfoCloneData;
end;

function TdxLayoutGroupViewInfo.GetGroup: TdxLayoutGroup;
begin
  Result := TdxLayoutGroup(inherited Item);
end;

function TdxLayoutGroupViewInfo.GetItemViewInfo(Index: Integer): TdxCustomLayoutItemViewInfo;
begin
  Result := TdxCustomLayoutItemViewInfo(FItemViewInfos[Index]);
end;

function TdxLayoutGroupViewInfo.GetItemViewInfoCount: Integer;
begin
  Result := FItemViewInfos.Count;
end;

function TdxLayoutGroupViewInfo.GetLayoutDirection: TdxLayoutDirection;
begin
  Result := Group.LayoutDirection;
end;

function TdxLayoutGroupViewInfo.GetOptionsEx: TdxLayoutLookAndFeelGroupOptions;
begin
  Result := TdxLayoutLookAndFeelGroupOptions(inherited Options);
end;

function TdxLayoutGroupViewInfo.GetPadding: TRect;
begin
  if UseItemsAreaOffsets then
    with Group.Padding do
      Result := Rect(Left, Top, Right, Bottom)
  else
    Result := inherited GetPadding;
end;

function TdxLayoutGroupViewInfo.GetRealItemControlAreaAlignment: TdxLayoutItemControlAreaAlignment;
begin
  if Group.FItemControlAreaAlignment = catDefault then
    Result := Specific.GetDefaultItemControlAreaAlignment
  else
    Result := Group.FItemControlAreaAlignment;

  if (Result = catAuto) and ((ParentViewInfo = nil) or (ParentViewInfo.GetRealItemControlAreaAlignment = catNone)) then
    Result := catOwn;
end;

function TdxLayoutGroupViewInfo.GetItemIndex: Integer;
begin
  if IsClone then
    Result := CloneData.ItemIndex
  else
    Result := Group.ItemIndex
end;

function TdxLayoutGroupViewInfo.GetOffset(Index: Integer): Integer;
begin
  if not FOffsetsCalculated then
  begin
    CalculateOffsets;
    FOffsetsCalculated := True;
  end;
  case Index of
    0: Result := FItemOffset;
    1: Result := FItemsAreaOffsetHorz;
    2: Result := FItemsAreaOffsetVert;
  else
    Result := -1;
  end;
end;

procedure TdxLayoutGroupViewInfo.CreateItemViewInfos;
var
  I: Integer;
  AItem: TdxCustomLayoutItem;
  AItemViewInfo: TdxCustomLayoutItemViewInfo;
begin
  FItemViewInfos := TObjectList.Create;
  for I := 0 to Group.Count - 1 do
  begin
    AItem := Group.Items[I];
    if AItem.GetVisible or (IsDragImagePainted and IsAvailable) then
    begin
      AItemViewInfo := GetItemViewInfoClass(AItem).Create(ContainerViewInfo, Self, AItem);
      FItemViewInfos.Add(AItemViewInfo);
    end;
  end;
end;

procedure TdxLayoutGroupViewInfo.CreateSpecific;
begin
  FSpecific := GetSpecificClass.Create(Self);
end;

procedure TdxLayoutGroupViewInfo.DestroyItemViewInfos;
begin
  FreeAndNil(FItemViewInfos);
end;

procedure TdxLayoutGroupViewInfo.DestroySpecific;
begin
  FreeAndNil(FSpecific);
end;

function TdxLayoutGroupViewInfo.GetClientAreaBounds(const ABounds: TRect): TRect;
var
  AMargins: TRect;
begin
  AMargins := Rect(GetBorderWidth(sdLeft), GetBorderWidth(sdTop), GetBorderWidth(sdRight), GetBorderWidth(sdBottom));
  Result := cxRectContent(ABounds, AMargins);
end;

function TdxLayoutGroupViewInfo.GetItemAreaBounds(const AClientRect: TRect): TRect;
var
  AMargins: TRect;
begin
  with LayoutLookAndFeel do
    AMargins := Rect(GetBorderWidth(sdLeft), GetBorderWidth(sdTop), GetBorderWidth(sdRight), GetBorderWidth(sdBottom));
  Result := cxRectInflate(AClientRect, AMargins);
end;

function TdxLayoutGroupViewInfo.CanDrawSpecificControls: Boolean;
begin
  Result := Specific.CanDrawSpecificControls;
end;

function TdxLayoutGroupViewInfo.GetBackgroundColor: TColor;
begin
  if Group.IsRoot and ContainerViewInfo.NeedHighlightRoot then
    Result := dxLayoutHiddenGroupBackgroundDefaultColor
  else
    Result := inherited GetBackgroundColor;
end;

procedure TdxLayoutGroupViewInfo.DoCreateViewInfos;
begin
  inherited;
  FButtonsViewInfo := TdxLayoutGroupButtonsViewInfo.Create(Self);
  CreateSpecific;
  CreateItemViewInfos;
  Specific.CreateViewInfos;
end;

procedure TdxLayoutGroupViewInfo.DestroyViewInfos;
begin
  Specific.DestroyViewInfos;
  DestroyItemViewInfos;
  DestroySpecific;
  FreeAndNil(FButtonsViewInfo);
  inherited;
end;

procedure TdxLayoutGroupViewInfo.PopulateAutoAlignControlList(AList: TList);
var
  I: Integer;
begin
  if GetRealItemControlAreaAlignment = catAuto then
    for I := 0 to ItemViewInfoCount - 1 do
      ItemViewInfos[I].PopulateAutoAlignControlList(AList);
end;

procedure TdxLayoutGroupViewInfo.PopulateControlViewInfoList(AControls, AWinControls: TList);
var
  I: Integer;
begin
  for I := 0 to ItemViewInfoCount - 1 do
    ItemViewInfos[I].PopulateControlViewInfoList(AControls, AWinControls);
end;

function TdxLayoutGroupViewInfo.GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass;
begin
  Result := TdxLayoutGroupCaptionViewInfo;
end;

function TdxLayoutGroupViewInfo.GetCloneDataClass: TdxCustomLayoutItemViewInfoCloneDataClass;
begin
  Result := TdxLayoutGroupViewInfoCloneData;
end;

function TdxLayoutGroupViewInfo.GetHitTestClass: TdxCustomLayoutItemHitTestClass;
begin
  if Group.LayoutDirection = ldTabbed then
    Result := TdxLayoutTabbedGroupHitTest
  else
    Result := TdxLayoutGroupHitTest;
end;

function TdxLayoutGroupViewInfo.GetPainterClass: TdxCustomLayoutItemPainterClass;
begin
  Result := TdxCustomLayoutItemPainterClass(LayoutLookAndFeel.GetGroupPainterClass);
end;

function TdxLayoutGroupViewInfo.CalculateHeight: Integer;
begin
  if AllowCollapsedHeight then
    Result := DoCalculateHeight(False)
  else
    Result := inherited CalculateHeight;
end;

function TdxLayoutGroupViewInfo.CalculateWidth: Integer;
begin
  if AllowCollapsedWidth then
    Result := DoCalculateWidth(False)
  else
    Result := inherited CalculateWidth;
end;

function TdxLayoutGroupViewInfo.DoCalculateHeight(AIsMinHeight: Boolean = False): Integer;
begin
  Result := inherited DoCalculateHeight(AIsMinHeight) + GetHeight(Specific.GetItemsAreaHeight(AIsMinHeight));
end;

function TdxLayoutGroupViewInfo.DoCalculateWidth(AIsMinWidth: Boolean = False): Integer;
begin
  Result := inherited DoCalculateWidth(AIsMinWidth) + GetWidth(Specific.GetItemsAreaWidth(AIsMinWidth));
end;

procedure TdxLayoutGroupViewInfo.CorrectAreaPart(var AAreaPart: TdxLayoutAreaPart);
begin
  Specific.CorrectAreaPart(AAreaPart);
end;

function TdxLayoutGroupViewInfo.GetActionType(AAreaPart: TdxLayoutAreaPart): TdxLayoutActionType;
begin
  if AAreaPart = apNone then
    Result := atNone
  else
    if (AAreaPart in [apCenter]) then
      Result := atInsert
    else
      Result := Specific.GetActionType(AAreaPart);
end;

function TdxLayoutGroupViewInfo.GetAreaPart(const P: TPoint): TdxLayoutAreaPart;
begin
  Result := Specific.GetAreaPart(P);
  if Result = apNone then
    Result := inherited GetAreaPart(P);
end;

function TdxLayoutGroupViewInfo.GetAreaPartBounds(AAreaPart: TdxLayoutAreaPart; AItemViewInfo: TdxCustomLayoutItemViewInfo): TRect;
const
  PartWidth = 2;
begin
  Result := AItemViewInfo.SelectionBorderRect;
  case AAreaPart of
    apLeft:
      with Result do
        Right := Left + PartWidth;
    apTop:
      with Result do
        Bottom := Top + PartWidth;
    apRight:
      with Result do
        Left := Right - PartWidth;
    apBottom:
      with Result do
        Top := Bottom - PartWidth;
  else
    Result := Specific.GetAreaPartBounds(AAreaPart, AItemViewInfo);
  end;
end;

function TdxLayoutGroupViewInfo.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := Specific.CanFocusOnClick(X, Y);
end;

procedure TdxLayoutGroupViewInfo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  Specific.KeyDown(Key, Shift);
end;

procedure TdxLayoutGroupViewInfo.LoadCloneData(AStream: TStream);
var
  I: Integer;
begin
  inherited;
  for I := 0 to ItemViewInfoCount - 1 do
    ItemViewInfos[I].LoadCloneData(AStream);  
end;

procedure TdxLayoutGroupViewInfo.SaveCloneData(AStream: TStream);
var
  I: Integer;
begin
  inherited;
  for I := 0 to ItemViewInfoCount - 1 do
    ItemViewInfos[I].SaveCloneData(AStream);
end;

function TdxLayoutGroupViewInfo.HasCaption: Boolean;
begin
  Result := inherited HasCaption and HasBorder;
end;

function TdxLayoutGroupViewInfo.HasBorder: Boolean;
begin
  Result := Group.ShowBorder and ((ParentViewInfo = nil) or
    ParentViewInfo.AllowChildHasBorder or IsDragImagePainted and IsDragged);
end;

function TdxLayoutGroupViewInfo.HasButtons: Boolean;
begin
  Result := HasBorder and Group.IsAnyButtonVisible;
end;

function TdxLayoutGroupViewInfo.HasExpandButton: Boolean;
begin
  Result := Group.ButtonOptions.ShowExpandButton;
end;

function CompareLayoutItemViewInfos(Item1, Item2: TdxLayoutItemViewInfo): Integer;
begin
  Result := Ord(Item2.CaptionLayout) - Ord(Item1.CaptionLayout);
end;

function ComparePositionItemViewInfos(Item1, Item2: TdxLayoutItemViewInfo): Integer;
begin
  case Item1.CaptionLayout of
    clLeft:
      Result := Item1.Bounds.Left - Item2.Bounds.Left;
    clTop:
      Result := Item1.Bounds.Top - Item2.Bounds.Top;
    clRight:
      Result := Item1.Bounds.Right - Item2.Bounds.Right;
    clBottom:
      Result := Item1.Bounds.Bottom - Item2.Bounds.Bottom;
  else
    Result := 0;
  end;
end;

type
  TdxList = class(TList)
  public
    procedure MoveFrom(AList: TList; ACurIndex, ANewIndex: Integer);
  end;

procedure TdxList.MoveFrom(AList: TList; ACurIndex, ANewIndex: Integer);
var
  AItem: Pointer;
begin
  AItem := AList[ACurIndex];
  AList[ACurIndex] := nil;
  AList.Delete(ACurIndex);
  Insert(ANewIndex, nil);
  Items[ANewIndex] := AItem;
end;

procedure TdxLayoutGroupViewInfo.AutoAlignControls;

  function GetViewInfo(AList: TList; AIndex: Integer): TdxLayoutControlItemViewInfo;
  begin
    Result := TObject(AList[AIndex]) as TdxLayoutControlItemViewInfo;
  end;

  procedure ExtractSameLayoutItemViewInfos(AOriginalList, AList: TdxList; AItemViewInfo: TdxLayoutItemViewInfo);
  var
    I: Integer;
  begin
    AList.Clear;
    for I := AOriginalList.Count - 1 downto 0 do
      if CompareLayoutItemViewInfos(AOriginalList[I], AItemViewInfo) = 0 then
        AList.MoveFrom(AOriginalList, I, 0);
  end;

  procedure ExtractSamePositionItemViewInfos(AOriginalList, AList: TdxList; AItemViewInfo: TdxLayoutItemViewInfo);
  var
    I: Integer;
  begin
    AList.Clear;
    for I := AOriginalList.Count - 1 downto 0 do
    begin
      if ComparePositionItemViewInfos(AOriginalList[I], AItemViewInfo) = 0 then
        AList.MoveFrom(AOriginalList, I, 0);
    end;
  end;

  procedure AlignControls(AList: TdxList);

    function IsCaptionLayoutHorizontal: Boolean;
    begin
      Result := GetViewInfo(AList, 0).CaptionLayout in [clLeft, clRight];
    end;

    function GetMaxCaptionSize: Integer;
    var
      I, ACaptionSize: Integer;
      AItemViewInfo: TdxLayoutControlItemViewInfo;
    begin
      Result := 0;
      for I := 0 to AList.Count - 1 do
      begin
        AItemViewInfo := GetViewInfo(AList, I);
        with AItemViewInfo.CaptionViewInfo do
          if IsCaptionLayoutHorizontal then
            ACaptionSize := Width +  AItemViewInfo.ElementOffsetHorz
          else
            ACaptionSize := Height + AItemViewInfo.ElementOffsetVert;
        Result := Max(Result, ACaptionSize);
      end;
    end;

    procedure AssignCaptionSizes(AMaxCaptionSize: Integer);
    var
      I: Integer;
      AItemViewInfo: TdxLayoutControlItemViewInfo;
    begin
      for I := 0 to AList.Count - 1 do
      begin
        AItemViewInfo := GetViewInfo(AList, I);
        with AItemViewInfo.CaptionViewInfo do
          if IsCaptionLayoutHorizontal then
            Width := AMaxCaptionSize - AItemViewInfo.ElementOffsetHorz
          else
            Height := AMaxCaptionSize - AItemViewInfo.ElementOffsetVert;
      end;
    end;

  begin
    AssignCaptionSizes(GetMaxCaptionSize);
    Calculate(Bounds);
  end;

  procedure PopulateOwnAlignControlList(AList: TList);
  var
    I: Integer;
  begin
    for I := 0 to ItemViewInfoCount - 1 do
      ItemViewInfos[I].PopulateAutoAlignControlList(AList);
  end;

var
  AAllItemViewInfos, ASameLayoutItemViewInfos, ASamePositionItemViewInfos: TdxList;
  I: Integer;
begin
  for I := 0 to ItemViewInfoCount - 1 do
    ItemViewInfos[I].AutoAlignControls;

  if GetRealItemControlAreaAlignment = catOwn then
  begin
    AAllItemViewInfos := TdxList.Create;
    ASameLayoutItemViewInfos := TdxList.Create;
    ASamePositionItemViewInfos := TdxList.Create;
    try
      PopulateOwnAlignControlList(AAllItemViewInfos);
      while AAllItemViewInfos.Count > 0 do
      begin
        ExtractSameLayoutItemViewInfos(AAllItemViewInfos, ASameLayoutItemViewInfos, AAllItemViewInfos[0]);
        while ASameLayoutItemViewInfos.Count > 0 do
        begin
          ExtractSamePositionItemViewInfos(ASameLayoutItemViewInfos, ASamePositionItemViewInfos, ASameLayoutItemViewInfos[0]);
          AlignControls(ASamePositionItemViewInfos);
        end;
      end;
    finally
      ASamePositionItemViewInfos.Free;
      ASameLayoutItemViewInfos.Free;
      AAllItemViewInfos.Free;
    end;
  end;
end;

procedure TdxLayoutGroupViewInfo.CalculateButtonsViewInfoBounds;
begin
  FButtonsAreaBounds := BorderBounds[CaptionSide];
  case CaptionSide of
    sdLeft, sdRight:
      begin
        if CaptionSide = sdLeft then
          FButtonsAreaBounds.Right := FButtonsAreaBounds.Left + ButtonsViewInfo.CalculateWidth
        else
          FButtonsAreaBounds.Left := FButtonsAreaBounds.Right - ButtonsViewInfo.CalculateWidth; 
        if (CaptionSide = sdLeft) xor ButtonsViewInfo.IsLeftAlignment then
        begin
          FButtonsAreaBounds.Top := FButtonsAreaBounds.Top + ButtonsViewInfoOffset;
          FButtonsAreaBounds.Bottom := FButtonsAreaBounds.Top + ButtonsViewInfo.CalculateHeight;
        end
        else
        begin
          FButtonsAreaBounds.Bottom := FButtonsAreaBounds.Bottom - ButtonsViewInfoOffset;
          FButtonsAreaBounds.Top := FButtonsAreaBounds.Bottom - ButtonsViewInfo.CalculateHeight;
        end;
      end;
    sdTop, sdBottom:
      begin
        if CaptionSide = sdTop then
          FButtonsAreaBounds.Bottom := FButtonsAreaBounds.Top + ButtonsViewInfo.CalculateHeight
        else
          FButtonsAreaBounds.Top := FButtonsAreaBounds.Bottom - ButtonsViewInfo.CalculateHeight;
        if ButtonsViewInfo.IsLeftAlignment then
        begin
          FButtonsAreaBounds.Left := FButtonsAreaBounds.Left + ButtonsViewInfoOffset;
          FButtonsAreaBounds.Right := FButtonsAreaBounds.Left + ButtonsViewInfo.CalculateWidth;
        end
        else
        begin
          FButtonsAreaBounds.Right := FButtonsAreaBounds.Right - ButtonsViewInfoOffset;
          FButtonsAreaBounds.Left := FButtonsAreaBounds.Right - ButtonsViewInfo.CalculateWidth;
        end;
      end;
  end;
end;

procedure TdxLayoutGroupViewInfo.CalculateCaptionViewInfoBounds;

  procedure CalculateHorizontalPosition;
  var
    ACaptionWidth: Integer;
  begin
    ACaptionWidth := CaptionViewInfo.CalculateWidth;
    with FCaptionAreaBounds do
      case CaptionViewInfo.AlignHorz of
        taLeftJustify:
          begin
            Inc(Left, CaptionViewInfoOffset);
            Right := Left + ACaptionWidth;
          end;
        taRightJustify:
          begin
            Dec(Right, CaptionViewInfoOffset);
            Left := Right - ACaptionWidth;
          end;
        taCenter:
          begin
            Left := (Left + Right - ACaptionWidth) div 2;
            Right := Left + ACaptionWidth;
          end;
      end;
  end;

  procedure CalculateVerticalPosition;
  var
    ACaptionHeight: Integer;
  begin
    ACaptionHeight := CaptionViewInfo.CalculateHeight;
    with FCaptionAreaBounds do
      case CaptionViewInfo.AlignVert of
        tavTop:
          begin
            Inc(Top, CaptionViewInfoOffset);
            Bottom := Top + ACaptionHeight;
          end;
        tavBottom:
          begin
            Dec(Bottom, CaptionViewInfoOffset);
            Top := Bottom - ACaptionHeight;
          end;
        tavCenter:
          begin
            Top := (Top + Bottom - ACaptionHeight) div 2;
            Bottom := Top + ACaptionHeight;
          end
      end;
  end;

begin
  FCaptionAreaBounds := BorderBounds[CaptionSide];

  with FCaptionAreaBounds do
  begin
    case CaptionSide of
      sdTop, sdBottom:
        begin
          CalculateHorizontalPosition;
          if CaptionSide = sdTop then
            Bottom := Top + CaptionViewInfo.GetAvailableHeight
          else
            Top := Bottom - CaptionViewInfo.GetAvailableHeight;
        end;
      sdLeft, sdRight:
        begin
          CalculateVerticalPosition;
          if CaptionSide = sdLeft then
            Right := Left + CaptionViewInfo.GetAvailableWidth
          else
            Left := Right - CaptionViewInfo.GetAvailableWidth;
        end;
    end;
  end;
end;

procedure TdxLayoutGroupViewInfo.CalculateClientBounds;
begin
  FClientAreaBounds := GetClientAreaBounds(FBounds);
end;

procedure TdxLayoutGroupViewInfo.CalculateItemsAreaBounds;
begin
  FItemsAreaBounds := cxRectInflate(ClientBounds, -ItemsAreaOffsetHorz, -ItemsAreaOffsetVert);
  FItemsAreaBounds := cxRectContent(FItemsAreaBounds, Padding);
  Specific.CalculateItemsAreaBounds(FItemsAreaBounds);
end;

procedure TdxLayoutGroupViewInfo.CalculateOffsets;
begin
  if UseItemsAreaOffsets then
    if Group.IsRoot then
    begin
      ItemsAreaOffsetHorz := LayoutLookAndFeel.GetRootItemsAreaOffsetHorz(Item.Container.ILayoutFontHelper);
      ItemsAreaOffsetVert := LayoutLookAndFeel.GetRootItemsAreaOffsetVert(Item.Container.ILayoutFontHelper);
    end
    else
    begin
      ItemsAreaOffsetHorz := LayoutLookAndFeel.GetItemsAreaOffsetHorz(Item.Container.ILayoutFontHelper);
      ItemsAreaOffsetVert := LayoutLookAndFeel.GetItemsAreaOffsetVert(Item.Container.ILayoutFontHelper);
    end
  else
  begin
    ItemsAreaOffsetHorz := 0;
    ItemsAreaOffsetVert := 0;
  end;

  if UseItemOffset then
    ItemOffset := LayoutLookAndFeel.GetItemOffset(Item.Container.ILayoutFontHelper)
  else
    ItemOffset := 0;
end;

procedure TdxLayoutGroupViewInfo.CalculateViewInfosBounds;
var
  AOffsetY, AOffsetX: Integer;
begin
  CalculateCaptionViewInfoBounds;
  CalculateButtonsViewInfoBounds;
  if HasButtons then
  begin
    if IsVerticalCaption then
    begin
      AOffsetX := (cxRectWidth(FButtonsAreaBounds) - cxRectWidth(FCaptionAreaBounds)) div 2;
      if AOffsetX > 0 then
        FCaptionAreaBounds := cxRectOffset(FCaptionAreaBounds, AOffsetX, 0, CaptionSide = sdLeft)
      else
        FButtonsAreaBounds := cxRectOffset(FButtonsAreaBounds, -AOffsetX, 0, CaptionSide = sdLeft);

      if HasCaption and HasButtons then
      begin
        if ((CaptionSide = sdLeft) xor ButtonsViewInfo.IsLeftAlignment) and (FCaptionAreaBounds.Top < FButtonsAreaBounds.Bottom) then
          FCaptionAreaBounds := cxRectOffset(FCaptionAreaBounds, 0, FCaptionAreaBounds.Top - FButtonsAreaBounds.Bottom, False);
        if ((CaptionSide = sdRight) xor ButtonsViewInfo.IsLeftAlignment) and (FCaptionAreaBounds.Bottom > FButtonsAreaBounds.Top) then
          FCaptionAreaBounds := cxRectOffset(FCaptionAreaBounds, 0, FCaptionAreaBounds.Bottom - FButtonsAreaBounds.Top, False);
      end;
    end
    else
    begin
      AOffsetY := (cxRectHeight(FButtonsAreaBounds) - cxRectHeight(FCaptionAreaBounds)) div 2;
      if AOffsetY > 0 then
        FCaptionAreaBounds := cxRectOffset(FCaptionAreaBounds, 0, AOffsetY, CaptionSide = sdTop)
      else
        FButtonsAreaBounds := cxRectOffset(FButtonsAreaBounds, 0, -AOffsetY, CaptionSide = sdTop);

      if HasCaption and HasButtons then
      begin
        if not ButtonsViewInfo.IsLeftAlignment and (FCaptionAreaBounds.Right > FButtonsAreaBounds.Left) then
          FCaptionAreaBounds := cxRectOffset(FCaptionAreaBounds, FCaptionAreaBounds.Right - FButtonsAreaBounds.Left, 0, False);
        if ButtonsViewInfo.IsLeftAlignment and (FButtonsAreaBounds.Right > FCaptionAreaBounds.Left) then
          FCaptionAreaBounds := cxRectOffset(FCaptionAreaBounds, FButtonsAreaBounds.Right - FCaptionAreaBounds.Left, 0);
      end;
    end;
  end;
  CaptionViewInfo.Calculate(FCaptionAreaBounds);
  ButtonsViewInfo.Calculate(FButtonsAreaBounds);
end;

function TdxLayoutGroupViewInfo.GetButtonsViewInfoOffset: Integer;
begin
  Result := CaptionViewInfoOffset;
end;

function TdxLayoutGroupViewInfo.GetButtonsViewInfoSpace: Integer;
begin
  Result := 2;
end;

function TdxLayoutGroupViewInfo.GetCaptionViewInfoOffset: Integer;
begin
  Result := GetBorderWidth(sdLeft);
end;

function TdxLayoutGroupViewInfo.GetSpaceBetweenButtons: Integer;
begin
  Result := LayoutLookAndFeel.GroupOptions.SpaceBetweenButtons;
end;

function TdxLayoutGroupViewInfo.GetBorderWidth(ASide: TdxLayoutSide): Integer;
var
  ACaptionHeight: Integer;
  ACaptionWidth: Integer;
  ATextHeight: Integer;
  ATextWidth: Integer;
begin
  if HasBorder then
  begin
    Result := LayoutLookAndFeel.GetGroupBorderWidth(Item.Container.ILayoutFontHelper, ASide, CaptionSide, HasCaption or HasButtons, IsExpanded);
    if (ASide = CaptionSide) and (HasCaption or HasButtons) then
    begin
      if CaptionViewInfo.IsVerticalCaption then
      begin
        ATextWidth := CaptionViewInfo.GetAvailableTextWidth;
        Inc(Result, Max(ATextWidth, CaptionViewInfo.ImageWidth) - ATextWidth);
        ACaptionWidth := CaptionViewInfo.GetAvailableWidth;
        Inc(Result, Max(ACaptionWidth, ButtonsViewInfo.CalculateWidth) - ACaptionWidth);
      end
      else
      begin
        ATextHeight := CaptionViewInfo.GetAvailableTextHeight;
        Inc(Result, Max(ATextHeight, CaptionViewInfo.ImageHeight) - ATextHeight);
        ACaptionHeight := CaptionViewInfo.GetAvailableHeight;
        Inc(Result, Max(ACaptionHeight, ButtonsViewInfo.CalculateHeight) - ACaptionHeight);
      end;
    end;
  end
  else
    Result := 0;
end;

function TdxLayoutGroupViewInfo.GetColor: TColor;
begin
  Result := Options.GetColor;
end;

function TdxLayoutGroupViewInfo.IsDefaultColor: Boolean;
begin
  Result := Options.Color = clDefault;
end;

function TdxLayoutGroupViewInfo.IsSkinPainterUsed: Boolean;
begin
  Result := TdxCustomLayoutLookAndFeelAccess(LayoutLookAndFeel).IsSkinPainterUsed;
end;

function TdxLayoutGroupViewInfo.IsTransparent: Boolean;
begin
  Result := (ContainerViewInfo.HasBackground and ((ParentViewInfo <> nil) or Group.IsRoot) and IsDefaultColor) or
    TdxCustomLayoutLookAndFeelAccess(LayoutLookAndFeel).IsGroupTransparent;
end;

function TdxLayoutGroupViewInfo.GetItemViewInfoClass(AItem: TdxCustomLayoutItem): TdxCustomLayoutItemViewInfoClass;
begin
  Result := AItem.GetViewInfoClass;
end;

function TdxLayoutGroupViewInfo.GetMinVisibleHeight: Integer;
begin
  if HasCaption then
    Result := CaptionViewInfo.CalculateMinHeight
  else
    Result := 0;
  if HasButtons then
    if IsVerticalCaption then
      Inc(Result, ButtonsViewInfo.CalculateMinHeight)
    else
      Result := Max(Result, ButtonsViewInfo.CalculateMinHeight);
  Result := Max(Result, dxLayoutItemMinSize);
end;

function TdxLayoutGroupViewInfo.GetMinVisibleWidth: Integer;
begin
  if HasCaption then
    Result := CaptionViewInfo.CalculateMinWidth
  else
    Result := 0;
  if HasButtons then
    if IsVerticalCaption then
      Result := Max(Result, ButtonsViewInfo.CalculateMinWidth)
    else
      Inc(Result, ButtonsViewInfo.CalculateMinWidth);
  Result := Max(Result, dxLayoutItemMinSize);
end;

function TdxLayoutGroupViewInfo.GetRestSpaceBounds: TRect;
begin
  Result := Bounds;
end;

procedure TdxLayoutGroupViewInfo.DoSetOffset(const Value: TPoint);
var
  I: Integer;
  AOffset: TPoint;
begin
  AOffset := cxPointOffset(Value, Offset, False);
  inherited;
  FCaptionAreaBounds := cxRectOffset(FCaptionAreaBounds, AOffset);
  FButtonsAreaBounds := cxRectOffset(FButtonsAreaBounds, AOffset);
  FClientAreaBounds := cxRectOffset(FClientAreaBounds, AOffset);
  FItemsAreaBounds := cxRectOffset(FItemsAreaBounds, AOffset);
  for I := 0 to ItemViewInfoCount - 1 do
    ItemViewInfos[I].Offset := Value;
  Specific.Calculate(ItemsAreaBounds);
end;

function TdxLayoutGroupViewInfo.AllowChildHasBorder: Boolean;
begin
  Result := Specific.AllowChildHasBorder;
end;

function TdxLayoutGroupViewInfo.AllowCollapsedHeight: Boolean;
begin
  Result := not IsExpanded and
    ((ParentViewInfo = nil) or (ParentViewInfo.LayoutDirection = ldVertical));
end;

function TdxLayoutGroupViewInfo.AllowCollapsedWidth: Boolean;
begin
  Result := not IsExpanded and
    ((ParentViewInfo = nil) or (ParentViewInfo.LayoutDirection = ldHorizontal));
end;

function TdxLayoutGroupViewInfo.AllowDrawChild(AChildViewInfo: TdxCustomLayoutItemViewInfo): Boolean;
begin
  Result := Group.AllowShowChild(AChildViewInfo.Item) and Specific.AllowDrawChild(AChildViewInfo) and IsExpanded;
end;

function TdxLayoutGroupViewInfo.GetChildInplaceRenameBounds(AChildViewInfo: TdxCustomLayoutItemViewInfo): TRect;
begin
  Result := Specific.GetChildInplaceRenameBounds(AChildViewInfo);
end;

function TdxLayoutGroupViewInfo.GetRotationAngle: TcxRotationAngle;
const
  ResultMap: array[TdxLayoutSide] of TcxRotationAngle = (raPlus90, raMinus90, ra0, ra0);
begin
  Result := ResultMap[CaptionSide];
end;

function TdxLayoutGroupViewInfo.IsChildActuallyVisible(AChildViewInfo: TdxCustomLayoutItemViewInfo): Boolean;
begin
  Result := ActuallyVisible and AllowDrawChild(AChildViewInfo);
end;

function TdxLayoutGroupViewInfo.IsExpanded: Boolean;
begin
  if IsClone then
    Result := CloneData.IsExpanded
  else
    Result := inherited IsExpanded;
end;

function TdxLayoutGroupViewInfo.IsVerticalCaption: Boolean;
begin
  Result := CaptionSide in [sdLeft, sdRight];
end;

function TdxLayoutGroupViewInfo.GetSpecificClass: TdxLayoutGroupViewInfoSpecificClass;
begin
  Result := Group.GetHelperClass.GetSpecificClass;
end;

procedure TdxLayoutGroupViewInfo.PaintSelectionLayer(ABitmap: TcxAlphaBitmap);
var
  I: Integer;
begin
  inherited;
  for I := 0 to ItemViewInfoCount - 1 do
    ItemViewInfos[I].PaintSelectionLayer(ABitmap);
end;

function TdxLayoutGroupViewInfo.GetMaxTabOrderIndex: Integer;
var
  I: Integer;
begin
  Result := inherited GetMaxTabOrderIndex;
  for I := 0 to ItemViewInfoCount - 1 do
    if ItemViewInfos[I].ActuallyVisible then
      Result := Max(Result, ItemViewInfos[I].GetMaxTabOrderIndex);
end;

procedure TdxLayoutGroupViewInfo.DoButtonClick(AViewInfo: TdxLayoutGroupButtonViewInfo);
begin
  if IsClone and AViewInfo.IsExpandButton then
    CloneData.IsExpanded := not CloneData.IsExpanded
  else
    AViewInfo.Button.DoClick;
end;

function TdxLayoutGroupViewInfo.GetHeight(AItemsAreaHeight: Integer): Integer;
begin
  Result := Max(MinVisibleHeight, BorderWidths[sdTop] + BorderWidths[sdBottom] +
    IfThen(AllowCollapsedHeight, 0, ItemsAreaOffsetVert + Specific.GetItemsAreaOffset(sdTop) + AItemsAreaHeight +
    ItemsAreaOffsetVert + Specific.GetItemsAreaOffset(sdBottom) + Padding.Top + Padding.Bottom));
end;

function TdxLayoutGroupViewInfo.GetWidth(AItemsAreaWidth: Integer): Integer;
begin
  Result := Max(MinVisibleWidth, BorderWidths[sdLeft] + BorderWidths[sdRight] +
    IfThen(AllowCollapsedWidth, 0, ItemsAreaOffsetHorz + Specific.GetItemsAreaOffset(sdLeft) +
    AItemsAreaWidth + ItemsAreaOffsetHorz + Specific.GetItemsAreaOffset(sdRight) + Padding.Left + Padding.Right));
end;

function TdxLayoutGroupViewInfo.UseItemOffset: Boolean;
begin
  Result := Group.UseIndent;
end;

function TdxLayoutGroupViewInfo.UseItemsAreaOffsets: Boolean;
begin
  Result := Group.ShowBorder or Group.IsRoot;
end;

procedure TdxLayoutGroupViewInfo.Calculate(const ABounds: TRect);
begin
  inherited;

  CalculateViewInfosBounds;
  CalculateClientBounds;
  CalculateItemsAreaBounds;
  Specific.Calculate(ItemsAreaBounds);
end;

procedure TdxLayoutGroupViewInfo.CalculateInternalTabOrders(var AAvailTabOrder: Integer);
var
  I: Integer;
begin
  Specific.CalculateInternalTabOrders(AAvailTabOrder);
  for I := 0 to ItemViewInfoCount - 1 do
    ItemViewInfos[I].CalculateInternalTabOrders(AAvailTabOrder);
end;

procedure TdxLayoutGroupViewInfo.CalculateTabOrders(var AAvailTabOrder: Integer);
var
  I: Integer;
begin
  for I := 0 to ItemViewInfoCount - 1 do
    ItemViewInfos[I].CalculateTabOrders(AAvailTabOrder);
end;

function TdxLayoutGroupViewInfo.FindItemViewInfo(AItem: TdxCustomLayoutItem): TdxCustomLayoutItemViewInfo;
var
  I: Integer;
  AViewInfo: TdxCustomLayoutItemViewInfo;
begin
  if Item = AItem then
  begin
    Result := Self;
    Exit;
  end;
  Result := nil;
  for I := 0 to ItemViewInfoCount - 1 do
  begin
    AViewInfo := ItemViewInfos[I];
    if AViewInfo is TdxLayoutGroupViewInfo then
      Result := TdxLayoutGroupViewInfo(AViewInfo).FindItemViewInfo(AItem)
    else
      if AViewInfo.Item = AItem then
        Result := AViewInfo;
    if Result <> nil then Exit;
  end;
end;

function TdxLayoutGroupViewInfo.GetHitTest(const P: TPoint): TdxCustomLayoutHitTest;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ItemViewInfoCount - 1 do
  begin
    Result := ItemViewInfos[I].GetHitTest(P);
    if Result <> nil then
      Break;
  end;
  if Result = nil then
    Result := inherited GetHitTest(P);
end;

function TdxLayoutGroupViewInfo.GetItemWithMouse(const P: TPoint): TdxCustomLayoutItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ItemViewInfoCount - 1 do
  begin
    Result := ItemViewInfos[I].GetItemWithMouse(P);
    if Result <> nil then
      Break;
  end;
  if Result = nil then
    Result := inherited GetItemWithMouse(P);
end;

function TdxLayoutGroupViewInfo.GetInsertionPos(const P: TPoint): Integer;
var
  R: TRect;
begin
  if PtInRect(Bounds, P) then
    for Result := 0 to ItemViewInfoCount - 1 do
    begin
      R := ItemViewInfos[Result].Bounds;
      if Specific.IsAtInsertionPos(R, P) then Exit;
    end;
  Result := ItemViewInfoCount;
end;

{ TdxLayoutContainerViewInfo }

constructor TdxLayoutContainerViewInfo.Create(AContainer: TdxLayoutContainer);
begin
  inherited Create;
  FContainer := AContainer;
  if not IsClone then
    FContainer.FViewInfo := Self;
  FItemCloneDataList := TdxLayoutCloneDataList.Create(True);
  FItemCloneDataList.OnChanged := ItemCloneDataListChangedHandler; 
  CreateViewInfos;
end;

destructor TdxLayoutContainerViewInfo.Destroy;
begin
  FItemWithMouse := nil;
  DestroyViewInfos;
  FreeAndNil(FItemCloneDataList);
  FreeAndNil(FSelectionLayer);
  if not IsClone then
    FContainer.FViewInfo := nil;
  inherited;
end;

procedure TdxLayoutContainerViewInfo.Calculate;
begin
  PrepareData;
  DoCalculate;
  Container.PlaceControls;
end;

procedure TdxLayoutContainerViewInfo.CalculateTabOrders;
begin
  if Container.GetAutoControlTabOrders then
    DoCalculateTabOrders;
end;

function TdxLayoutContainerViewInfo.FindItemViewInfo(AItem: TdxCustomLayoutItem; out AViewInfo: TdxCustomLayoutItemViewInfo): Boolean;
begin
  AViewInfo := FindItemViewInfo(AItem);
  Result := AViewInfo <> nil;
end;

function TdxLayoutContainerViewInfo.FindItemViewInfo(AItem: TdxCustomLayoutItem): TdxCustomLayoutItemViewInfo;
begin
  Result := ItemsViewInfo.FindItemViewInfo(AItem);
end;

function TdxLayoutContainerViewInfo.GetHitTest(const P: TPoint): TdxCustomLayoutHitTest;
begin
  Result := nil;
  if Container.ILayout.CanGetHitTest(P) then
  begin
    if PtInRect(ItemsViewInfo.Bounds, P) then
      Result := ItemsViewInfo.GetHitTest(P);
    if Result = nil then
    begin
      Result := TdxLayoutClientAreaHitTest.Instance;
      TdxLayoutClientAreaHitTest(Result).Container := Container;
    end;
  end;
  if Result = nil then
    Result := TdxLayoutNoneHitTest.Instance;
end;

function TdxLayoutContainerViewInfo.GetItemWithMouse(const P: TPoint): TdxCustomLayoutItem;
begin
  Result := ItemsViewInfo.GetItemWithMouse(P);
end;

procedure TdxLayoutContainerViewInfo.AssignItemWithMouse(X, Y: Integer);
begin
  ItemWithMouse := GetItemWithMouse(Point(X, Y));
end;

function TdxLayoutContainerViewInfo.CanFocusOnClick(X, Y: Integer): Boolean;
var
  AViewInfo: TdxCustomLayoutItemViewInfo;
  AItem: TdxCustomLayoutItem;
begin
  AItem := GetItemWithMouse(Point(X, Y));
  Result := (AItem = nil) or (FindItemViewInfo(AItem, AViewInfo) and AViewInfo.CanFocusOnClick(X, Y));
end;

procedure TdxLayoutContainerViewInfo.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AViewInfo: TdxCustomLayoutItemViewInfo;
  AHitItemViewInfo: TdxCustomLayoutItemViewInfo;
  AHitTest: TdxCustomLayoutHitTest;
begin
  AssignItemWithMouse(X, Y);
  if (ItemWithMouse <> nil) and FindItemViewInfo(ItemWithMouse, AViewInfo) then
  begin
    AHitTest := GetHitTest(Point(X, Y));
    if not (AHitTest is TdxCustomLayoutItemHitTest) or
        not FindItemViewInfo(TdxCustomLayoutItemHitTest(AHitTest).GetSourceItem, AHitItemViewInfo) or
        AHitItemViewInfo.IsParentLocked then
      AHitItemViewInfo := AViewInfo;
    AViewInfo.MouseDown(Button, Shift, X, Y);
    if Container.IsCustomization then
      AHitItemViewInfo.CustomizationMouseDown(Button, Shift, X, Y);
  end;
end;

procedure TdxLayoutContainerViewInfo.MouseLeave(AControl: TControl);
begin
  ItemWithMouse := nil;
end;

procedure TdxLayoutContainerViewInfo.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  AViewInfo: TdxCustomLayoutItemViewInfo;
begin
  AssignItemWithMouse(X, Y);
  if (ItemWithMouse <> nil) and FindItemViewInfo(ItemWithMouse, AViewInfo) then
    AViewInfo.MouseMove(Shift, X, Y);
end;

procedure TdxLayoutContainerViewInfo.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AViewInfo: TdxCustomLayoutItemViewInfo;
begin
  AssignItemWithMouse(X, Y);
  if (ItemWithMouse <> nil) and FindItemViewInfo(ItemWithMouse, AViewInfo) then
    AViewInfo.MouseUp(Button, Shift, X, Y);
end;

procedure TdxLayoutContainerViewInfo.CreateViewInfos;
begin
  if LayoutLookAndFeel <> nil then
    FItemsViewInfo := GetItemsViewInfoClass.Create(Self, nil, FContainer.Root);
end;

procedure TdxLayoutContainerViewInfo.DestroyViewInfos;
begin
  FreeAndNil(FItemsViewInfo);
end;

function TdxLayoutContainerViewInfo.GetItemsViewInfoClass: TdxLayoutGroupViewInfoClass;
begin
  Result := TdxLayoutGroupViewInfoClass(Container.Root.GetViewInfoClass);
end;

procedure TdxLayoutContainerViewInfo.PrepareData;
begin
  RecreateViewInfos;
end;

procedure TdxLayoutContainerViewInfo.RecreateViewInfos;
begin
  DestroyViewInfos;
  CreateViewInfos;
end;

procedure TdxLayoutContainerViewInfo.AlignItemsByConstraint;
var
  I: Integer;

  procedure ProcessConstraint(AConstraint: TdxLayoutAlignmentConstraint);
  var
    AItemViewInfos: TList;

    procedure RetrieveItemViewInfos;
    var
      I: Integer;
      AViewInfo: TdxCustomLayoutItemViewInfo;
    begin
      for I := 0 to AConstraint.Count - 1 do
      begin
        AViewInfo := AConstraint.Items[I].ViewInfo;
        if AViewInfo <> nil then
          AItemViewInfos.Add(AViewInfo);
      end;
    end;

    function GetSide: TdxLayoutSide;
    begin
      if AConstraint.Kind in [ackLeft, ackRight] then
        Result := sdLeft
      else
        Result := sdTop;
    end;

    function AlignItemViewInfos: Boolean;
    var
      AMaxBorderValue, I: Integer;

      function GetBorderValue(AItemViewInfoIndex: Integer): Integer;
      begin
        with TdxCustomLayoutItemViewInfo(AItemViewInfos[AItemViewInfoIndex]) do
          case AConstraint.Kind of
            ackLeft:
              Result := Bounds.Left - CalculateOffset(sdLeft);
            ackTop:
              Result := Bounds.Top - CalculateOffset(sdTop);
            ackRight:
              Result := Bounds.Right + CalculateOffset(sdRight);
            ackBottom:
              Result := Bounds.Bottom + CalculateOffset(sdBottom);
          else
            Result := 0;
          end;
      end;

      function FindMaxBorderValue: Integer;
      var
        I: Integer;
      begin
        Result := -MaxInt;
        for I := 0 to AItemViewInfos.Count - 1 do
          Result := Max(Result, GetBorderValue(I));
      end;

      procedure ChangeOffset(AItemViewInfoIndex, ADelta: Integer);
      begin
        with TdxCustomLayoutItemViewInfo(AItemViewInfos[AItemViewInfoIndex]) do
          Offsets[GetSide] := Offsets[GetSide] + ADelta;
      end;

      function AreItemViewInfosAligned: Boolean;
      var
        I, ABorderValue: Integer;
      begin
        ABorderValue := 0;
        for I := 0 to AItemViewInfos.Count - 1 do
          if I = 0 then
            ABorderValue := GetBorderValue(I)
          else
          begin
            Result := GetBorderValue(I) = ABorderValue;
            if not Result then Exit;
          end;
        Result := True;
      end;

    begin
      AMaxBorderValue := FindMaxBorderValue;
      for I := 0 to AItemViewInfos.Count - 1 do
        ChangeOffset(I, AMaxBorderValue - GetBorderValue(I));
      CalculateItemsViewInfo;
      Result := AreItemViewInfosAligned;
    end;

    procedure ResetOffsets;
    var
      I: Integer;
    begin
      for I := 0 to AItemViewInfos.Count - 1 do
        TdxCustomLayoutItemViewInfo(AItemViewInfos[I]).ResetOffset(GetSide);
      CalculateItemsViewInfo;
    end;

  begin
    AItemViewInfos := TList.Create;
    try
      RetrieveItemViewInfos;
      while not AlignItemViewInfos do  //!!! to think about invisible items if items will be deleted
      begin
        ResetOffsets;
        if AItemViewInfos.Count > 2 then
          AItemViewInfos.Count := AItemViewInfos.Count - 1
        else
          Break;
      end;
    finally
      AItemViewInfos.Free;
    end;
  end;

begin
  for I := 0 to Container.AlignmentConstraintCount - 1 do
    ProcessConstraint(Container.AlignmentConstraints[I]);
end;

procedure TdxLayoutContainerViewInfo.AutoAlignControls;
begin
  ItemsViewInfo.AutoAlignControls;
end;

procedure TdxLayoutContainerViewInfo.CalculateItemsViewInfo;
begin
  ResetContentBounds;
  ItemsViewInfo.Calculate(ContentBounds);
end;

procedure TdxLayoutContainerViewInfo.DoCalculate;
begin
  CalculateItemsViewInfo;
  AlignItemsByConstraint;
  AutoAlignControls;
  CalculateItemsViewInfo;

  DoCalculateInternalTabOrders;
  CalculateTabOrders;
end;

procedure TdxLayoutContainerViewInfo.DoCalculateInternalTabOrders;
var
  AAvailTabOrder: Integer;
begin
  AAvailTabOrder := 0;
  ItemsViewInfo.CalculateInternalTabOrders(AAvailTabOrder);
end;

procedure TdxLayoutContainerViewInfo.DoCalculateTabOrders;
var
  AAvailTabOrder: Integer;
begin
  AAvailTabOrder := 0;
  ItemsViewInfo.CalculateTabOrders(AAvailTabOrder);
end;

function TdxLayoutContainerViewInfo.ShowHint(var AHintInfo: THintInfo; X, Y: Integer): Boolean;
var
  AViewInfo: TdxCustomLayoutItemViewInfo;
begin
  AssignItemWithMouse(X, Y);
  Result := (ItemWithMouse <> nil) and FindItemViewInfo(ItemWithMouse, AViewInfo) and AViewInfo.ShowHint(AHintInfo);
end;

function TdxLayoutContainerViewInfo.HasBackground: Boolean;
begin
  Result := Container.ILayout.HasBackground;
end;

function TdxLayoutContainerViewInfo.NeedHighlightRoot: Boolean;
begin
  Result := Container.HighlightRoot and Container.IsDesigning;
end;

function TdxLayoutContainerViewInfo.GetScrollOffset: TPoint;
begin
  Result := Container.ILayout.GetScrollOffset;
end;

function TdxLayoutContainerViewInfo.IsClone: Boolean;
begin
  Result := False;
end;

procedure TdxLayoutContainerViewInfo.ItemCloneDataListChangedHandler(Sender: TObject);
begin
  CallNotify(FOnCloneDataChanged, Self);
end;

function TdxLayoutContainerViewInfo.GetCloneData(AViewInfo: TdxCustomLayoutItemViewInfo): TdxCustomLayoutItemViewInfoCloneData;
begin
  if not FindCloneData(AViewInfo.Item, Result) then
  begin
    Result := AViewInfo.GetCloneDataClass.Create(FItemCloneDataList, AViewInfo.Item);
    FItemCloneDataList.Add(Result);
    Result.Calculate;
  end;
end;

function TdxLayoutContainerViewInfo.FindCloneData(AItem: TdxCustomLayoutItem; out ACloneData: TdxCustomLayoutItemViewInfoCloneData): Boolean;
var
  I: Integer;
begin
  ACloneData := nil;
  for I := 0 to FItemCloneDataList.Count - 1 do
    if FItemCloneDataList[I].Item = AItem then
    begin
      ACloneData := FItemCloneDataList[I];
      Break;
    end;
  Result := ACloneData <> nil;
end;

procedure TdxLayoutContainerViewInfo.LoadCloneData(AStream: TStream);
begin
  ItemsViewInfo.LoadCloneData(AStream);
  Calculate;
end;

procedure TdxLayoutContainerViewInfo.RecalculateCloneDataList;
var
  I: Integer;
begin
  for I := 0 to FItemCloneDataList.Count - 1 do
    FItemCloneDataList[I].Calculate;
end;

procedure TdxLayoutContainerViewInfo.SaveCloneData(AStream: TStream);
begin
  ItemsViewInfo.SaveCloneData(AStream);
end;

function TdxLayoutContainerViewInfo.IsDragImagePainted: Boolean;
begin
  Result := FIsDragImagePainted;
end;

procedure TdxLayoutContainerViewInfo.StartDragImagePainted;
begin
  FIsDragImagePainted := True;
end;

procedure TdxLayoutContainerViewInfo.StopDragImagePainted;
begin
  FIsDragImagePainted := False;
end;

procedure TdxLayoutContainerViewInfo.ResetContentBounds;
begin
  SetRectEmpty(FContentBounds);
end;

procedure TdxLayoutContainerViewInfo.BuildSelectionLayer;

  function CanBuildSelectionLayer: Boolean;
  var
    I: Integer;
    AList: TcxObjectList;
    AIntf: IdxLayoutSelectableItem;
  begin
    Result := Container.IsCustomization and not Container.IsUpdateLocked;
    if Result and Container.IsDesigning then
    begin
      Result := False;
      AList := TcxObjectList.Create(False);
      try
        Container.GetSelection(AList);
        for I := 0 to AList.Count - 1 do
        begin
          if Supports(AList[I], IdxLayoutSelectableItem, AIntf) and AIntf.IsOwner(Container) then
          begin
            Result := True;
            AIntf := nil;
            Break;
          end;
        end;
      finally
        AList.Free;
      end;
    end;
  end;

begin
  if CanBuildSelectionLayer then
  begin
    SelectionLayer.BoundsRect := ClientBounds;
    SelectionLayer.SelectionImage.Clear;
    ItemsViewInfo.PaintSelectionLayer(SelectionLayer.SelectionImage);
    SelectionLayer.UpdateContent;
  end
  else
    FreeAndNil(FSelectionLayer);
end;

procedure TdxLayoutContainerViewInfo.CreateSelectionLayer;
begin
  FSelectionLayer := TdxSelectionLayer.Create(nil);
  FSelectionLayer.ParentControl := Container.ILayout.GetItemsParent;
  FSelectionLayer.OnHitTest := SelectionLayerHitTest;
  FSelectionLayer.OnUpdate := SelectionLayerUpdate;
  FSelectionLayer.OnEndRename := SelectionLayerEndRename;
end;

function TdxLayoutContainerViewInfo.GetCanvas: TcxCanvas;
begin
  Result := Container.ILayout.GetCanvas;
end;

function TdxLayoutContainerViewInfo.GetClientBounds: TRect;
begin
  Result := Container.ILayout.GetClientBounds;
end;

function TdxLayoutContainerViewInfo.GetContentBounds: TRect;

  function CalculateContentWidth: Integer;
  begin
    if ItemsViewInfo.AlignHorz = ahClient then
      Result := Max(cxRectWidth(ClientBounds), ItemsViewInfo.MinWidth)
    else
      Result := ItemsViewInfo.CalculateWidth;
  end;

  function CalculateContentHeight: Integer;
  begin
    if ItemsViewInfo.AlignVert = avClient then
      Result := Max(cxRectHeight(ClientBounds), ItemsViewInfo.MinHeight)
    else
      Result := ItemsViewInfo.CalculateHeight;
  end;

begin
  if IsRectEmpty(FContentBounds) then
    FContentBounds := cxRectBounds(-GetScrollOffset.X + FOffset.X, -GetScrollOffset.Y + FOffset.Y, CalculateContentWidth, CalculateContentHeight);
  Result := FContentBounds;
end;

function TdxLayoutContainerViewInfo.GetContentHeight: Integer;
begin
  Result := cxRectHeight(ContentBounds);
end;

function TdxLayoutContainerViewInfo.GetContentWidth: Integer;
begin
  Result := cxRectWidth(ContentBounds);
end;

function TdxLayoutContainerViewInfo.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := Container.GetLookAndFeel;
end;

function TdxLayoutContainerViewInfo.GetSelectionLayer: TdxSelectionLayer;
begin
  if FSelectionLayer = nil then
    CreateSelectionLayer;
  Result := FSelectionLayer;
end;

procedure TdxLayoutContainerViewInfo.SelectionLayerHitTest(ASender: TObject; var AIsTransparent: Boolean);
begin
  AIsTransparent := not Container.Customization;
end;

procedure TdxLayoutContainerViewInfo.SelectionLayerUpdate(Sender: TObject);
var
  ATopMost: Boolean;
  I: Integer;
  AList: TcxObjectList;
  AIntf: IdxLayoutSelectableItem;
begin
  ATopMost := not Container.IsDesigning;
  if not ATopMost then
  begin
    ATopMost := False;
    AList := TcxObjectList.Create(False);
    try
      Container.GetSelection(AList);
      for I := 0 to AList.Count - 1 do
      begin
        if Supports(AList[I], IdxLayoutSelectableItem, AIntf) and AIntf.IsOwner(Container) then
        begin
          ATopMost := True;
          AIntf := nil;
          Break;
        end;
      end;
    finally
      AList.Free;
    end;
  end;
  if ATopMost then
    SelectionLayer.BringToFront
  else
    SelectionLayer.SendToBack;
end;

procedure TdxLayoutContainerViewInfo.SelectionLayerEndRename(ASender: TObject; const AText: string; AAccept: Boolean);
begin
  if AAccept then
    Container.EndRename(AText)
  else
    Container.CancelRename;
end;

procedure TdxLayoutContainerViewInfo.SetItemWithMouse(Value: TdxCustomLayoutItem);
var
  AViewInfo: TdxCustomLayoutItemViewInfo;
begin
  if FItemWithMouse <> Value then
  begin
    if (FItemWithMouse <> nil) and FindItemViewInfo(FItemWithMouse, AViewInfo) and (AViewInfo.Item <> nil) then
      AViewInfo.MouseLeave;
    FItemWithMouse := Value;
    if (FItemWithMouse <> nil) and FindItemViewInfo(FItemWithMouse, AViewInfo) then
      AViewInfo.MouseEnter;
  end;
end;

procedure TdxLayoutContainerViewInfo.SetOffset(const Value: TPoint);
begin
  if not cxPointIsEqual(FOffset, Value) then
  begin
    FOffset := Value;
    ItemsViewInfo.Offset := FOffset;
  end;
end;

initialization
  RegisterClasses([
    TdxLayoutContainer, TdxLayoutItem, TdxLayoutEmptySpaceItem, TdxLayoutLabeledItem, TdxLayoutSeparatorItem, TdxLayoutSplitterItem,
    TdxLayoutGroup, TdxLayoutAlignmentConstraint]);

  HitTests := THitTests.Create;

  dxLayoutRunTimeSelectionHelperClass := TdxLayoutRunTimeSelectionHelper;

finalization
  FreeAndNil(HitTests);

end.
