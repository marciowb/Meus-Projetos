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

unit dxLayoutControl;

{$I cxVer.inc}

interface

uses
  Messages, Windows, SysUtils, Classes, Menus, Graphics,
  Forms, Controls {after Forms for D12},
  StdCtrls, ExtCtrls, IniFiles, Contnrs, ImgList,
  dxMessages, dxCore, cxClasses, cxGeometry, cxGraphics, cxControls,
  cxLookAndFeels, cxLibraryConsts, cxLookAndFeelPainters,
  dxLayoutLookAndFeels, dxLayoutCommon, dxLayoutSelection, cxPC;

const
  htError = -1;
  htNone = 0;
  htCustomizeForm = 1;
  htItem = 10;
  htGroup = 20;
  htClientArea = 30;
  htAvailableItems = 40;
  htTreeViewItems = 50;

  dxLayoutItemControlDefaultMinHeight = 20;
  dxLayoutItemControlDefaultMinWidth = 20;

  dxLayoutItemMinSize = 5;

type
  //Base
  TdxCustomLayoutItem = class;
  TdxCustomLayoutItemClass = class of TdxCustomLayoutItem;
  TdxLayoutItem = class;
  TdxLayoutGroup = class;
  TdxLayoutGroupClass = class of TdxLayoutGroup;
  TdxCustomLayoutControl = class;
  TdxLayoutEmptySpaceItem = class;
  TdxLayoutEmptySpaceItemClass = class of TdxLayoutEmptySpaceItem;
  TdxLayoutLabeledItem = class;
  TdxLayoutLabeledItemClass = class of TdxLayoutLabeledItem;
  TdxLayoutSeparatorItem = class;
  TdxLayoutSeparatorItemClass = class of TdxLayoutSeparatorItem;
  TdxLayoutSplitterItem = class;

  //Secondary
  TdxLayoutAlignmentConstraint = class;
  TdxCustomLayoutHitTest = class;
  TdxLayoutGroupHelper = class;
  TdxLayoutGroupHelperClass = class of TdxLayoutGroupHelper;

  //Painter
  TdxCustomLayoutItemPainter = class;
  TdxCustomLayoutItemPainterClass = class of TdxCustomLayoutItemPainter;
  TdxLayoutBasicItemPainter = class;
  TdxLayoutBasicItemPainterClass = class of TdxLayoutBasicItemPainter;
  TdxLayoutItemPainter = class;
  TdxLayoutItemPainterClass = class of TdxLayoutItemPainter;
  TdxLayoutGroupPainter = class;
  TdxLayoutGroupPainterClass = class of TdxLayoutGroupPainter;
  TdxLayoutControlPainter = class;
  TdxLayoutControlPainterClass = class of TdxLayoutControlPainter;
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
  TdxCustomLayoutElementViewInfo = class;
  TdxCustomLayoutItemElementViewInfo = class;
  TdxCustomLayoutItemCaptionViewInfo = class;
  TdxCustomLayoutItemViewInfo = class;
  TdxCustomLayoutItemViewInfoClass = class of TdxCustomLayoutItemViewInfo;
  TdxLayoutItemCaptionViewInfo = class;
  TdxLayoutItemControlViewInfo = class;
  TdxLayoutItemControlViewInfoClass = class of TdxLayoutItemControlViewInfo;
  TdxLayoutLabeledItemViewInfo = class;
  TdxLayoutItemViewInfo = class;
  TdxLayoutItemViewInfoClass = class of TdxLayoutItemViewInfo;
  TdxLayoutGroupViewInfo = class;
  TdxLayoutGroupViewInfoClass = class of TdxLayoutGroupViewInfo;
  TdxLayoutControlViewInfo = class;
  TdxLayoutControlViewInfoClass = class of TdxLayoutControlViewInfo;
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

  { CustomizeForm }

  TdxLayoutControlCustomCustomizeForm = class(TForm)
  private
    FControl: TdxCustomLayoutControl;
    procedure SetControl(AValue: TdxCustomLayoutControl);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function GetLayoutPopupMenu: TPopupMenu; virtual;
    procedure InitializeControl; virtual;

    procedure ItemChanged(AItem: TdxCustomLayoutItem); virtual;
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

    property Control: TdxCustomLayoutControl read FControl write SetControl;
  end;
  TdxLayoutControlCustomCustomizeFormClass = class of TdxLayoutControlCustomCustomizeForm;

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

  TdxLayoutItemCaptionVisibleElement = (cveImage, cveText);
  TdxLayoutItemCaptionVisibleElements = set of TdxLayoutItemCaptionVisibleElement;

  TdxCustomLayoutItemCaptionOptions = class(TdxCustomLayoutItemOptions)
  private
    FAlignHorz: TAlignment;
    FImageOptions: TdxCustomLayoutItemImageOptions;
    FShowAccelChar: Boolean;
    FText: string;
    FVisibleElements: TdxLayoutItemCaptionVisibleElements;
    FVisible: Boolean;
    function GetGlyph: TBitmap;
    function GetImageIndex: Integer;
    procedure SetAlignHorz(Value: TAlignment);
    procedure SetGlyph(AValue: TBitmap);
    procedure SetImageIndex(AValue: Integer);
    procedure SetImageOptions(Value: TdxCustomLayoutItemImageOptions);
    procedure SetShowAccelChar(Value: Boolean);
    procedure SetText(const Value: string);
    procedure SetVisibleElements(Value: TdxLayoutItemCaptionVisibleElements);
    procedure SetVisible(Value: Boolean);
  protected
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property ImageIndex: Integer read GetImageIndex write SetImageIndex default -1;
    property ImageOptions: TdxCustomLayoutItemImageOptions read FImageOptions write SetImageOptions;
    property VisibleElements: TdxLayoutItemCaptionVisibleElements read FVisibleElements write SetVisibleElements default [cveImage, cveText];
  public
    constructor Create(AItem: TdxCustomLayoutItem); override;
    destructor Destroy; override;
  published
    property AlignHorz: TAlignment read FAlignHorz write SetAlignHorz default taLeftJustify;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar default True;
    property Text: string read FText write SetText;
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
    function GetValue(Index: Integer): Integer;
    procedure SetValue(Index: Integer; Value: Integer);
  published
    property Bottom: Integer index 1 read GetValue write SetValue default 0;
    property Left: Integer index 2 read GetValue write SetValue default 0;
    property Right: Integer index 3 read GetValue write SetValue default 0;
    property Top: Integer index 4 read GetValue write SetValue default 0;
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
    FContainer: TdxCustomLayoutControl;
    FEnabled: Boolean;
    FIsUserDefined: Boolean;
    FLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
    FOffsets: TdxLayoutOffsets;
    FParent: TdxLayoutGroup;
    FViewInfo: TdxCustomLayoutItemViewInfo;
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
    function GetHasMouse: Boolean;
    function GetIndex: Integer;
    function GetIsRoot: Boolean;
    function GetVisibleIndex: Integer;
    procedure SetAlignHorz(Value: TdxLayoutAlignHorz);
    procedure SetAlignmentConstraint(Value: TdxLayoutAlignmentConstraint);
    procedure SetAlignVert(Value: TdxLayoutAlignVert);
    procedure SetAutoAligns(Value: TdxLayoutAutoAligns);
    procedure SetCaption(const Value: string);
    procedure SetContainer(Value: TdxCustomLayoutControl);
    procedure SetEnabled(Value: Boolean);
    procedure SetLayoutLookAndFeel(Value: TdxCustomLayoutLookAndFeel);
    procedure SetHasMouse(Value: Boolean);
    procedure SetIndex(Value: Integer);
    procedure SetParent(Value: TdxLayoutGroup);
    procedure SetShowCaption(Value: Boolean);
    procedure SetVisible(Value: Boolean);
    procedure SetVisibleIndex(Value: Integer);
    procedure SetSizeOptions(Value: TdxLayoutSizeOptions);

    function GetHeight: Integer;
    function GetWidth: Integer;
    procedure SetHeight(Value: Integer);
    procedure SetWidth(Value: Integer);

    function IsAlignHorzStored: Boolean;
    function IsAlignVertStored: Boolean;
  protected
    procedure Loaded; override;
    procedure SetName(const Value: TComponentName); override;
    procedure SetParentComponent(Value: TComponent); override;

    // LayoutLookAndFeel
    procedure LayoutLookAndFeelChanged; virtual;
    procedure LayoutLookAndFeelChanging; virtual;
    // IdxLayoutLookAndFeelUser
    procedure IdxLayoutLookAndFeelUser.BeginLookAndFeelDestroying = BeginLayoutLookAndFeelUserDestroying;
    procedure IdxLayoutLookAndFeelUser.EndLookAndFeelDestroying = EndLayoutLookAndFeelUserDestroying;
    procedure IdxLayoutLookAndFeelUser.LookAndFeelChanged = LayoutLookAndFeelUserChanged;
    procedure IdxLayoutLookAndFeelUser.LookAndFeelDestroyed = LayoutLookAndFeelUserDestroyed;
    procedure BeginLayoutLookAndFeelUserDestroying; stdcall;
    procedure EndLayoutLookAndFeelUserDestroying; stdcall;
    procedure LayoutLookAndFeelUserChanged; stdcall;
    procedure LayoutLookAndFeelUserDestroyed; stdcall;

    function CanBeAlone: Boolean; virtual;
    function CanDragAndDrop: Boolean; virtual;
    function CanFocusOnClick(X, Y: Integer): Boolean; virtual;
    function CanProcessAccel(out AItem: TdxCustomLayoutItem): Boolean; virtual;
    function CanRemove: Boolean; virtual;
    function CanResizeHorz: Boolean; virtual;
    function CanResizeVert: Boolean; virtual;
    function HasControl: Boolean; virtual;
    function HasCaption: Boolean; virtual; // #DG !!!

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

    procedure BeforeCalculateViewInfo; virtual;
    procedure AfterCalculateViewInfo; virtual;
    procedure ApplyCalculatedChanges; virtual;

    function IsExpanded: Boolean; virtual;
    function IsParentExpanded: Boolean; virtual;

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

    procedure MouseEnter; dynamic;
    procedure MouseLeave; dynamic;
    procedure CustomizationMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); dynamic;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); dynamic;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); dynamic;
    procedure ProcessAccel; dynamic;
    function ProcessDialogChar(ACharCode: Word): Boolean; virtual;
    function ProcessDialogKey(ACharCode: Word; AKeyData: Integer; AFocusedItem: TdxLayoutItem): Boolean; virtual;
    procedure RestoreItemControlSize; virtual;
    procedure ResetCachedTextHeight;
    procedure ShowHint(var AHintInfo: THintInfo; out ACanShow: Boolean);

    class function GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass; virtual;
    class function GetItemClassKind: Integer; virtual;
    function GetParentHelperClass: TdxLayoutGroupHelperClass;
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; virtual; abstract;

    //Notification
    procedure DoChanged;

    // Changing
    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate(ANeedPack: Boolean = True);
    procedure Changed(AType: TdxLayoutItemChangeType = ictHard);
    procedure ParentChanged(AType: TdxLayoutItemChangeType);
    procedure CustomizationChanged; virtual;
    procedure ContainerChanged; virtual;
    procedure EnabledChanged; virtual;

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

    property CachedTextHeight: Integer read FCachedTextHeight write FCachedTextHeight;
    property HasMouse: Boolean read GetHasMouse write SetHasMouse;
    property IsUserDefined: Boolean read FIsUserDefined;
//    property UserWidth: Integer read FUserWidth write FUserWidth;
    property OnCaptionClick: TNotifyEvent read FOnCaptionClick write FOnCaptionClick;
  public
    constructor Create(AOwner: TComponent); override;
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

    property ActuallyVisible: Boolean read GetActuallyVisible;
    property CaptionForCustomizeForm: string read GetCaptionForCustomizeForm;
    property Container: TdxCustomLayoutControl read FContainer write SetContainer;
    property Index: Integer read GetIndex write SetIndex;
    property IsRoot: Boolean read GetIsRoot;
    property Parent: TdxLayoutGroup read FParent write SetParent;
    property ViewInfo: TdxCustomLayoutItemViewInfo read FViewInfo;
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
    property CaptionOptions: TdxCustomLayoutItemCaptionOptions read FCaptionOptions write FCaptionOptions;
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    property LookAndFeel: TdxCustomLayoutLookAndFeel read FLayoutLookAndFeel write SetLayoutLookAndFeel stored False; // osolette
    property LayoutLookAndFeel: TdxCustomLayoutLookAndFeel read FLayoutLookAndFeel write SetLayoutLookAndFeel;
    property Offsets: TdxLayoutOffsets read FOffsets write FOffsets;
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

  TdxAlignmentVert = (tavTop, tavCenter, tavBottom);

  TdxLayoutLabeledItemCaptionOptions = class(TdxCustomLayoutItemCaptionOptions)
  private
    FAlignVert: TdxAlignmentVert;
    FCursor: TCursor;
    FWidth: Integer;
    procedure SetAlignVert(Value: TdxAlignmentVert);
    procedure SetWidth(Value: Integer);
  public
    constructor Create(AItem: TdxCustomLayoutItem); override;
  published
    property AlignVert: TdxAlignmentVert read FAlignVert write SetAlignVert default tavCenter;
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
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; override;

    property CaptionOptions: TdxLayoutLabeledItemCaptionOptions read GetCaptionOptions write SetCaptionOptions;
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

  TdxCaptionLayout = (clLeft, clTop, clRight, clBottom);

  TdxLayoutItemCaptionOptions = class(TdxLayoutLabeledItemCaptionOptions)
  private
    FLayout: TdxCaptionLayout;
    procedure SetLayout(Value: TdxCaptionLayout);
  published
    property Layout: TdxCaptionLayout read FLayout write SetLayout default clLeft;
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

  TdxLayoutItem = class(TdxLayoutCustomLabeledItem)
  private
    FControl: TControl;
    FControlLocked: Boolean;
    FControlAdapter: TdxCustomLayoutControlAdapter;
    FControlOptions: TdxLayoutItemControlOptions;
    FControlSizeBeforeDestruction: TPoint;

    FIsNewControlSizeAssigned: Boolean;
    FNewControlSize: TPoint;
    FOriginalControlSize: TPoint;
    FControlSizeChanged: Boolean;

    FCustomizeControlHelper: TdxControlsDesignSelectorHelper;
    FWindowProcObject: TcxWindowProcLinkedObject;

    function GetCaptionOptions: TdxLayoutItemCaptionOptions;
    function GetDesignSelectorRect: TRect;
    function GetViewInfo: TdxLayoutItemViewInfo;
    function GetWinControl: TWinControl;
    procedure SetCaptionOptions(Value: TdxLayoutItemCaptionOptions);
    procedure SetControlOptions(Value: TdxLayoutItemControlOptions);
    procedure SetControl(Value: TControl);

    function CanFocusControlOnCaptionClick: Boolean;
    procedure CreateControlAdapter;
  protected
    class function GetItemClassKind: Integer; override;

    // CustomItem
    function CanDelete: Boolean;  override;
    function CanFocusOnClick(X, Y: Integer): Boolean; override;
    function CanProcessAccel(out AItem: TdxCustomLayoutItem): Boolean; override;
    procedure ContainerChanged; override;
    procedure CustomizationChanged; override;
    procedure CustomizationMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DoCaptionDown; override;
    function GetBaseName: string; override;
    procedure DoInit; override;
    procedure ProcessAccel; override;
    procedure RestoreItemControlSize; override;

    procedure BeforeCalculateViewInfo; override;
    procedure ApplyCalculatedChanges; override;
    procedure LayoutLookAndFeelChanging; override;

    class function GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass; override;
    function GetControlOptionsClass: TdxLayoutItemControlOptionsClass; virtual;
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; override;

    function CanFocusControl: Boolean; virtual;
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
    property ControlSizeBeforeDestruction: TPoint read FControlSizeBeforeDestruction;
    property DesignSelectorRect: TRect read GetDesignSelectorRect;
    property WinControl: TWinControl read GetWinControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property OriginalControlSize: TPoint read FOriginalControlSize write FOriginalControlSize;
    property ViewInfo: TdxLayoutItemViewInfo read GetViewInfo;
  published
    property CaptionOptions: TdxLayoutItemCaptionOptions read GetCaptionOptions write SetCaptionOptions;
    property Control: TControl read FControl write SetControl;
    property ControlOptions: TdxLayoutItemControlOptions read FControlOptions write SetControlOptions;
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

  TdxLayoutGroupButtonOptions = class(TPersistent)
  private
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
    property Buttons: TdxLayoutGroupButtons read FButtons write SetButtons;
    property DefaultHeight: Cardinal read FDefaultHeight write SetDefaultHeight default 16;
    property DefaultWidth: Cardinal read FDefaultWidth write SetDefaultWidth default 16;
    property ShowExpandButton: Boolean read GetShowExpandButton write SetShowExpandButton default False;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TdxLayoutGroupCaptionOptions = class(TdxCustomLayoutItemCaptionOptions)
  published
    property Glyph;
    property ImageIndex;
    property VisibleElements;
  end;

  TdxLayoutItemControlAreaAlignment = (catDefault, catNone, catAuto, catOwn);

  TdxLayoutGroup = class(TdxCustomLayoutItem)
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
    FUseIndent: Boolean;

    FOnCollapsed: TNotifyEvent;
    FOnExpanded: TNotifyEvent;

    function GetCount: Integer;
    function GetItem(Index: Integer): TdxCustomLayoutItem;
    function GetShowBorder: Boolean;
    function GetViewInfo: TdxLayoutGroupViewInfo;
    function GetVisibleCount: Integer;
    function GetVisibleItem(Index: Integer): TdxCustomLayoutItem;
    procedure SetButtonOptions(AValue: TdxLayoutGroupButtonOptions);
    procedure SetExpanded(Value: Boolean);
    procedure SetHidden(Value: Boolean);
    procedure SetItemIndex(Value: Integer);
    procedure SetItemControlAreaAlignment(Value: TdxLayoutItemControlAreaAlignment);
    procedure SetLayoutDirection(Value: TdxLayoutDirection);
    procedure SetLocked(Value: Boolean);
    procedure SetLayoutLookAndFeelException(Value: Boolean);
    procedure SetShowBorder(Value: Boolean);
    procedure SetUseIndent(Value: Boolean);

    procedure AddItem(AItem: TdxCustomLayoutItem);
    procedure ExtractItem(AItem: TdxCustomLayoutItem);
    procedure ItemListChanged(Sender: TObject; AComponent: TComponent; AAction: TcxComponentCollectionNotification);

    function IsItemIndexStored: Boolean;
    function IsChildActuallyVisible(AChild: TdxCustomLayoutItem): Boolean;
    function GetChildLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
    function GetRealItemControlAreaAlignment: TdxLayoutItemControlAreaAlignment;
  protected
    class function GetItemClassKind: Integer; override;

    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetParentComponent(Value: TComponent); override;

    // TdxCustomLayoutItem
    function CanDelete: Boolean; override;
    function CanProcessAccel(out AItem: TdxCustomLayoutItem): Boolean; override;
    function CanRemove: Boolean; override;
    procedure ContainerChanged; override;
    procedure CustomizationChanged; override;
    procedure DoPack; override;
    class function GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass; override;
    function GetBaseName: string; override;
    function GetShowCaption: Boolean; override;
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; override;
    function ProcessDialogChar(ACharCode: Word): Boolean; override;
    function ProcessDialogKey(ACharCode: Word; AKeyData: Integer; AFocusedItem: TdxLayoutItem): Boolean; override;
    procedure RestoreItemControlSize; override;

    procedure LayoutLookAndFeelChanged; override;
    procedure LayoutLookAndFeelChanging; override;
    procedure BeforeCalculateViewInfo; override;
    procedure AfterCalculateViewInfo; override;
    procedure ApplyCalculatedChanges; override;

    function IsExpanded: Boolean; override;
    function IsLocked: Boolean; override;

    // Events
    procedure DoCollapsed; virtual;
    procedure DoExpanded; virtual;

    procedure BuildVisibleItemsList;
    function GetHelperClass: TdxLayoutGroupHelperClass;

    function AllowDrawChild(AChild: TdxCustomLayoutItem): Boolean; virtual;
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
    property Expanded: Boolean read FExpanded write SetExpanded default True;
    property Hidden: Boolean read FHidden write SetHidden default False;
    property ItemControlAreaAlignment: TdxLayoutItemControlAreaAlignment read FItemControlAreaAlignment write SetItemControlAreaAlignment default catDefault;
    property ItemIndex: Integer read FItemIndex write SetItemIndex stored IsItemIndexStored;
    property LayoutDirection: TdxLayoutDirection read FLayoutDirection write SetLayoutDirection default ldVertical;
    property Locked: Boolean read FLocked write SetLocked default False;
    property LookAndFeelException: Boolean read FLayoutLookAndFeelException write SetLayoutLookAndFeelException stored False; // obsolete
    property LayoutLookAndFeelException: Boolean read FLayoutLookAndFeelException write SetLayoutLookAndFeelException default False;
    property ShowBorder: Boolean read GetShowBorder write SetShowBorder default True;
    property UseIndent: Boolean read FUseIndent write SetUseIndent default True;
    property OnCaptionClick;
    property OnCollapsed: TNotifyEvent read FOnCollapsed write FOnCollapsed;
    property OnExpanded: TNotifyEvent read FOnExpanded write FOnExpanded;
  end;

  // alignment constraint

  TdxLayoutAlignmentConstraintKind = (ackLeft, ackTop, ackRight, ackBottom);

  TdxLayoutAlignmentConstraint = class(TComponent)
  private
    FControl: TdxCustomLayoutControl;
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

    property Control: TdxCustomLayoutControl read FControl;
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

  { TdxLayoutControlPersistent }

  TdxLayoutControlPersistent = class(TPersistent)
  private
    FControl: TdxCustomLayoutControl;
  protected
    procedure Changed; virtual;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AControl: TdxCustomLayoutControl); virtual;
    property Control: TdxCustomLayoutControl read FControl;
  end;

  { controls }

  { TdxLayoutImageOptions }

  TdxLayoutImageOptions = class(TdxLayoutControlPersistent)
  private
    FDisabledImages: TCustomImageList;
    FDisabledImagesChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FImagesChangeLink: TChangeLink;

    FNotifyComponent: TcxFreeNotificator;

    procedure SetImages(AValue: TCustomImageList);
    procedure SetDisabledImages(AValue: TCustomImageList);

    procedure DisabledImagesChange(Sender: TObject);
    procedure ImagesChange(Sender: TObject);

    procedure SetImageList(var ANewValue, AOldValue: TCustomImageList; const AChangeLink: TChangeLink);
    procedure FreeNotification(AComponent: TComponent);
  protected
    procedure Changed; override;

    procedure BeginUpdate;
    procedure EndUpdate;
  public
    constructor Create(AControl: TdxCustomLayoutControl); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property DisabledImages: TCustomImageList read FDisabledImages write SetDisabledImages;
    property Images: TCustomImageList read FImages write SetImages;
  end;

  { TdxUndoRedoManager }

  TdxUndoRedoManager = class(TdxLayoutControlPersistent)
  private
    FUndoList: TObjectList;
    FIndex: Integer;
    FCurrentLayout: TMemIniFile;
    FLockCount: Integer;
    procedure AddUndo(ALayout: TMemIniFile);
    function GetRedoCount: Integer;
    function GetUndoCount: Integer;
  protected
    procedure CancelLastUndo;
    procedure SaveLayout;

    function IsLocked: Boolean;
    property RedoCount: Integer read GetRedoCount;
    property UndoCount: Integer read GetUndoCount;
  public
    constructor Create(AControl: TdxCustomLayoutControl); override;
    destructor Destroy; override;

    function CanRedo: Boolean;
    function CanUndo: Boolean;

    procedure Redo;
    procedure Undo;

    procedure Clear;
  end;

  { TdxStoringOptions }

  TdxStoringOptions = class(TPersistent)
  private
    FIniFileName: string;
    FRegistryPath: string;
    FStoreToIniFile: Boolean;
    FStoreToRegistry: Boolean;
  protected
    function CanStoreToIniFile: Boolean;
    function CanStoreToRegistry: Boolean;
    function CanRestoreFromIniFile: Boolean;
    function CanRestoreFromRegistry: Boolean;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property IniFileName: string read FIniFileName write FIniFileName;
    property RegistryPath: string read FRegistryPath write FRegistryPath;
    property StoreToIniFile: Boolean read FStoreToIniFile write FStoreToIniFile default False;
    property StoreToRegistry: Boolean read FStoreToRegistry write FStoreToRegistry default False;
  end;

  TdxLayoutItemOptions = class(TdxLayoutControlPersistent)
  private
    FAutoControlAreaAlignment: Boolean;
    FAutoControlTabOrders: Boolean;
    FFocusControlOnItemCaptionClick: Boolean;
    FSizableHorz: Boolean;
    FSizableVert: Boolean;

    procedure SetAutoControlAreaAlignment(Value: Boolean);
    procedure SetAutoControlTabOrders(Value: Boolean);
  protected
    procedure Changed; override;
  public
    constructor Create(AControl: TdxCustomLayoutControl); override;
    procedure Assign(Source: TPersistent); override;
  published
    property AutoControlAreaAlignment: Boolean read FAutoControlAreaAlignment write SetAutoControlAreaAlignment default True;
    property AutoControlTabOrders: Boolean read FAutoControlTabOrders write SetAutoControlTabOrders default True;
    property FocusControlOnItemCaptionClick: Boolean read FFocusControlOnItemCaptionClick write FFocusControlOnItemCaptionClick default False;
    property SizableHorz: Boolean read FSizableHorz write FSizableHorz default False;
    property SizableVert: Boolean read FSizableVert write FSizableVert default False;
  end;

  TdxLayoutAutoContentSize = (acsWidth, acsHeight);
  TdxLayoutAvailableItemsViewKind = (aivkList, aivkTree);
  TdxLayoutCustomizeFormUpdateType = (cfutCaption, cfutAvailableItems, cfutVisibleItems, cfutSelection, cfutView, cfutDragAndDropState);
  TdxLayoutCustomizeFormUpdateTypes = set of TdxLayoutCustomizeFormUpdateType;
  TdxLayoutAutoContentSizes = set of TdxLayoutAutoContentSize;
  TdxLayoutItemChangedEvent = procedure(AItem: TdxCustomLayoutItem) of object;

  TdxCustomLayoutControl = class(TcxControl, IdxLayoutLookAndFeelUser, IdxLayoutComponent,
    IdxSkinSupport, IdxLayoutDesignerHelper, IdxSelectionChanged, IdxCustomizeControlsHelper)
  private
    FAlignmentConstraints: TList;
    FBoldFont: TFont;
    FDragDropHitTest: TdxCustomLayoutHitTest;
    FItemWithMouse: TdxCustomLayoutItem;
    FLeftPos: Integer;
    FLoadingCount:Integer;
    FRightButtonPressed: Boolean;
    FPrevEnabled: Boolean;
    FTopPos: Integer;
    FUpdateLockCount: Integer;

    // Objects
    FOptionsImage: TdxLayoutImageOptions;
    FOptionsItem: TdxLayoutItemOptions;
    FOptionsStoring: TdxStoringOptions;
    FRootGroup: TdxLayoutGroup;
    FLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
    FPainter: TdxLayoutControlPainter;
    FViewInfo: TdxLayoutControlViewInfo;

    // Items
    FAbsoluteItems: TcxComponentList;
    FAvailableItems: TcxComponentList;

    // Customization
    FShowDesignSelectors: Boolean;
    FHighlightRoot: Boolean;
    FCustomization: Boolean;
    FCustomizeAvailableItemsViewKind: TdxLayoutAvailableItemsViewKind;
    FCustomizeForm: TdxLayoutControlCustomCustomizeForm;
    FCustomizeFormBounds: TRect;
    FCustomizeFormClass: TdxLayoutControlCustomCustomizeFormClass;
    FCustomizeFormUpdateTypes: TdxLayoutCustomizeFormUpdateTypes;
    FCustomizeFormTabbedView: Boolean;
    FIsPopupShown: Boolean;
    FShowHiddenGroupsBounds: Boolean;

    // Internal Flags
    FIsPlaceControlsNeeded: Boolean;
    FIsPlacingControls: Boolean;
    FPlaceControlsLockCount: Integer;

    // Storing
    FStoredStream: TMemoryStream;

    // UndoRedo
    FUndoRedoManager: TdxUndoRedoManager;

    FOnCustomization: TNotifyEvent;
    FOnItemChanged: TdxLayoutItemChangedEvent;

    // Get/Set Properties
    function GetAllowDrop: Boolean;
    function GetAutoContentSizes: TdxLayoutAutoContentSizes;
    function GetContentBounds: TRect;
    function GetIsLayoutLoading: Boolean;
    function GetLayoutDirection: TdxLayoutDirection;
    function GetOccupiedClientWidth: Integer;
    function GetOccupiedClientHeight: Integer;
    procedure SetAutoContentSizes(Value: TdxLayoutAutoContentSizes);
    procedure SetCustomization(Value: Boolean);
    procedure SetCustomizeAvailableItemsViewKind(Value: TdxLayoutAvailableItemsViewKind);
    procedure SetCustomizeFormTabbedView(Value: Boolean);
    procedure SetOptionsImage(Value: TdxLayoutImageOptions);
    procedure SetOptionsItem(Value: TdxLayoutItemOptions);
    procedure SetShowDesignSelectors(Value: Boolean);
    procedure SetHighlightRoot(Value: Boolean);
    procedure SetRootGroup(Value: TdxLayoutGroup);
    procedure SetItemWithMouse(Value: TdxCustomLayoutItem);
    procedure SetLeftPos(Value: Integer);
    procedure SetLayoutDirection(Value: TdxLayoutDirection);
    procedure SetLayoutLookAndFeel(Value: TdxCustomLayoutLookAndFeel);
    procedure SetShowHiddenGroupsBounds(Value: Boolean);
    procedure SetTopPos(Value: Integer);

    // Items
    function GetAutoControlAlignment: Boolean;
    function GetAutoControlTabOrders: Boolean;
    function GetAbsoluteItem(Index: Integer): TdxCustomLayoutItem;
    function GetAbsoluteItemCount: Integer;
    function GetAlignmentConstraint(Index: Integer): TdxLayoutAlignmentConstraint;
    function GetAlignmentConstraintCount: Integer;
    function GetAvailableItem(Index: Integer): TdxCustomLayoutItem;
    function GetAvailableItemCount: Integer;
    procedure SetAutoControlAlignment(Value: Boolean);
    procedure SetAutoControlTabOrders(Value: Boolean);

    // Storing
    procedure SetOptionsStoring(Value: TdxStoringOptions);
    function GetIniFileName: string;
    function GetRegistryPath: string;
    function GetStoreInIniFile: Boolean;
    function GetStoreInRegistry: Boolean;
    procedure SetIniFileName(const Value: string);
    procedure SetRegistryPath(const Value: string);
    procedure SetStoreInIniFile(const Value: Boolean);
    procedure SetStoreInRegistry(const Value: Boolean);

    procedure CreateHandlers;
    procedure DestroyHandlers;

    // Constraints
    procedure CreateConstraints;
    procedure DestroyConstraints;
    procedure AddAlignmentConstraint(AConstraint: TdxLayoutAlignmentConstraint);
    procedure RemoveAlignmentConstraint(AConstraint: TdxLayoutAlignmentConstraint);

    // Items
    procedure AddAbsoluteItem(AItem: TdxCustomLayoutItem);
    procedure ExtractAbsoluteItem(AItem: TdxCustomLayoutItem);

    procedure AddAvailableItem(AItem: TdxCustomLayoutItem);
    procedure ExtractAvailableItem(AItem: TdxCustomLayoutItem);
    procedure AvailableItemListChanged(Sender: TObject; AComponent: TComponent; AAction: TcxComponentCollectionNotification);

    // Other
    procedure InitializeSubControlsCxLookAndFeel;
    procedure RefreshBoldFont;

    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure DXMPlaceControls(var Message: TMessage); message DXM_LAYOUT_PLACECONTROLS;
    procedure DXMBuildSelectionLayer(var Message: TMessage); message DXM_LAYOUT_BUILDSELECTIONLAYER;
    procedure DXMInvalidateSelectionLayer(var Message: TMessage); message DXM_LAYOUT_INVALIDATESELECTIONLAYER;
    procedure DXMCustomizeFormUpdate(var Message: TMessage); message DXM_REFRESHCUSTOMIZATION;
  protected
    FSelectionHelper: IdxLayoutDesignerHelper;

    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
  {$IFNDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    function GetCursor(X, Y: Integer): TCursor; override;
    function DoShowPopupMenu(AMenu: TComponent; X, Y: Integer): Boolean; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure SetName(const Value: TComponentName); override;
    procedure SetParentBackground(Value: Boolean); override;
    procedure WriteState(Writer: TWriter); override;
    procedure WndProc(var Message: TMessage); override;

    // Conditions
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    function CanFocusOnClick(X, Y: Integer): Boolean;  override;
    function HasBackground: Boolean; override;
    function IsInternalControl(AControl: TControl): Boolean; override;
    function NeedRedrawOnResize: Boolean; override;

    // Notifications
    procedure BoundsChanged; override;
    procedure FontChanged; override;

    // Mouse
    procedure DblClick; override;
    function GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseLeave(AControl: TControl); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    // Scrollbars
    procedure InitScrollBarsParameters; override;
    function NeedsToBringInternalControlsToFront: Boolean; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode; var AScrollPos: Integer); override;

    // Drag and Drop
    function AllowAutoDragAndDropAtDesignTime(X, Y: Integer; Shift: TShiftState): Boolean; override;
    function AllowDragAndDropWithoutFocus: Boolean; override;
    function CanDrag(X, Y: Integer): Boolean; override;
    function CanDragAndDrop: Boolean;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; override;
    function StartDragAndDrop(const P: TPoint): Boolean; override;
    procedure EndDragAndDrop(Accepted: Boolean); override;

    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
    function GetCxLookAndFeel: TcxLookAndFeel;
    // IdxLayoutLookAndFeelUser
    procedure IdxLayoutLookAndFeelUser.BeginLookAndFeelDestroying = BeginLayoutLookAndFeelUserDestroying;
    procedure IdxLayoutLookAndFeelUser.EndLookAndFeelDestroying = EndLayoutLookAndFeelUserDestroying;
    procedure IdxLayoutLookAndFeelUser.LookAndFeelChanged = LayoutLookAndFeelUserChanged;
    procedure IdxLayoutLookAndFeelUser.LookAndFeelDestroyed = LayoutLookAndFeelUserDestroyed;
    procedure BeginLayoutLookAndFeelUserDestroying; stdcall;
    procedure EndLayoutLookAndFeelUserDestroying; stdcall;
    procedure LayoutLookAndFeelUserChanged; stdcall;
    procedure LayoutLookAndFeelUserDestroyed; stdcall;

    // IdxLayoutComponent
    procedure SelectionChanged; stdcall;

    //IdxCustomizeControlsHelper
    function CanProcessChildren: Boolean; virtual;

    function GetPainterClass: TdxLayoutControlPainterClass; virtual;
    function GetViewInfoClass: TdxLayoutControlViewInfoClass; virtual;

    procedure AssignItemWithMouse(X, Y: Integer);

    function CalculateCustomizeFormBounds(const AFormBounds: TRect): TRect;
    function CanMultiSelect: Boolean; virtual;
    function CanShowSelection: Boolean; virtual;
    procedure CustomizeFormPostUpdate(AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes);
    procedure CustomizeFormUpdate(AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes);
    procedure CustomizeFormUpdateList(AItem: TdxCustomLayoutItem);
    procedure DoCustomization; dynamic;
    procedure DoItemChanged(AItem: TdxCustomLayoutItem); virtual;
    procedure DragAndDropBegan; dynamic;
    function GetAlignmentConstraintClass: TdxLayoutAlignmentConstraintClass; dynamic;
    function GetDefaultGroupClass: TdxLayoutGroupClass; virtual;
    function GetDefaultItemClass: TdxLayoutItemClass; virtual;
    function GetDesignSelectorRect: TRect;
    function IsCustomization: Boolean;
    function IsDesignSelectorsVisible: Boolean;
    function IsToolSelected: Boolean;
    function IsUpdateLocked: Boolean;
    procedure CreateRootGroup;
    procedure DestroyRootGroup;

    procedure InternalCalculateRoot(ANeedPack: Boolean);
    procedure LayoutChanged(ANeedPack: Boolean = True; ANeedUpdateCustomizeForm: Boolean = True);

    // scroll
    procedure ScrollContent(APrevPos, ACurPos: Integer; AHorzScrolling: Boolean);
    procedure CheckLeftPos(var Value: Integer);
    procedure CheckPositions;
    procedure CheckTopPos(var Value: Integer);

    // PlaceControls
    procedure PlaceControls(AItemViewInfo: TdxCustomLayoutItemViewInfo = nil);
    procedure BeginPlaceControls;
    procedure CancelPlaceControls;
    procedure EndPlaceControls;

    // selections
    function GetSelectionHelperClass: TdxLayoutRunTimeSelectionHelperClass;
    procedure InvalidateSelectionLayer(const R: TRect); virtual;
    procedure PostBuildSelectionLayer; virtual;
    procedure PostInvalidateSelectionLayer(const R: TRect); virtual;

    // storing
    function GetRootSectionName(AIniFile: TCustomIniFile): string;
    procedure InternalLoadFromCustomIniFile(AIniFile: TCustomIniFile; ADestroyNonLoadedItems: Boolean); virtual;
    procedure InternalSaveToCustomIniFile(AIniFile: TCustomIniFile); virtual;
    procedure LoadFromCustomIniFile(AIniFile: TCustomIniFile); virtual;
    procedure SaveToCustomIniFile(AIniFile: TCustomIniFile); virtual;

    // IdxLayoutDesignerHelper
    procedure AddSelectionChangedListener(AListener: TPersistent);
    function IsActive: Boolean;
    function CanDeleteComponent(AComponent: TComponent): Boolean;
    function CanProcessKeyboard: Boolean;
    procedure ClearSelection;
    procedure DeleteSelection;
    procedure GetSelection(AList: TList);
    function IsComponentSelected(AComponent: TPersistent): Boolean;
    procedure RemoveSelectionChangedListener(AListener: TPersistent);
    procedure SelectComponent(AComponent: TPersistent; AShift: TShiftState = []);
    procedure SetSelection(AList: TList);
    function UniqueName(const BaseName: string): string;

    //IdxSelectionChanged
    procedure IdxSelectionChanged.SelectionChanged = LayoutSelectionChanged;
    procedure LayoutSelectionChanged(ASelection: TList; AAction: TdxSelectionAction);

    // Undo
    procedure CancelLastUndo;
    procedure SaveToUndo;

    property AllowDrop: Boolean read GetAllowDrop;
    property BoldFont: TFont read FBoldFont;
    property IsPlacingControls: Boolean read FIsPlacingControls;
    property IsLayoutLoading: Boolean read GetIsLayoutLoading;
    property ItemWithMouse: TdxCustomLayoutItem read FItemWithMouse write SetItemWithMouse;
    property cxLookAndFeel: TcxLookAndFeel read GetCxLookAndFeel;
    property OnItemChanged: TdxLayoutItemChangedEvent read FOnItemChanged write FOnItemChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginDragAndDrop; override;
  {$IFDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}

    procedure Clear;
    function CreateAlignmentConstraint: TdxLayoutAlignmentConstraint;
    function FindItem(AControl: TControl): TdxLayoutItem; overload;
    function FindItem(AControlHandle: THandle): TdxLayoutItem; overload;
    function FindItem(const AName: string): TdxCustomLayoutItem; overload;
    function GetHitTest(const P: TPoint): TdxCustomLayoutHitTest; overload;
    function GetHitTest(X, Y: Integer): TdxCustomLayoutHitTest; overload;

    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate(ANeedPack: Boolean = True);

    function CreateGroup(AGroupClass: TdxLayoutGroupClass = nil; AParent: TdxLayoutGroup = nil): TdxLayoutGroup;
    function CreateItem(AItemClass: TdxCustomLayoutItemClass = nil; AParent: TdxLayoutGroup = nil): TdxCustomLayoutItem;
    function CreateItemForControl(AControl: TControl; AParent: TdxLayoutGroup = nil): TdxLayoutItem;

    // Storing
    function CanRestore: Boolean;
    procedure Restore;
    procedure Store;

    procedure LoadFromIniFile(const AFileName: string);
    procedure LoadFromRegistry(const ARegistryPath: string);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToIniFile(const AFileName: string);
    procedure SaveToRegistry(const ARegistryPath: string);
    procedure SaveToStream(AStream: TStream);

    property AutoSize;

    property AutoContentSizes: TdxLayoutAutoContentSizes read GetAutoContentSizes write SetAutoContentSizes;
    property LayoutDirection: TdxLayoutDirection read GetLayoutDirection write SetLayoutDirection;
    property LeftPos: Integer read FLeftPos write SetLeftPos;
    property TopPos: Integer read FTopPos write SetTopPos;

    property LookAndFeel: TdxCustomLayoutLookAndFeel read FLayoutLookAndFeel write SetLayoutLookAndFeel;
    property LayoutLookAndFeel: TdxCustomLayoutLookAndFeel read FLayoutLookAndFeel write SetLayoutLookAndFeel;

    // Customization properties
    property Customization: Boolean read FCustomization write SetCustomization;
    property CustomizeAvailableItemsViewKind: TdxLayoutAvailableItemsViewKind read FCustomizeAvailableItemsViewKind
      write SetCustomizeAvailableItemsViewKind;
    property CustomizeForm: TdxLayoutControlCustomCustomizeForm read FCustomizeForm;
    property CustomizeFormBounds: TRect read FCustomizeFormBounds write FCustomizeFormBounds;
    property CustomizeFormClass: TdxLayoutControlCustomCustomizeFormClass read FCustomizeFormClass write FCustomizeFormClass;
    property CustomizeFormTabbedView: Boolean read FCustomizeFormTabbedView write SetCustomizeFormTabbedView;
    property ShowDesignSelectors: Boolean read FShowDesignSelectors write SetShowDesignSelectors;
    property ShowHiddenGroupsBounds: Boolean read FShowHiddenGroupsBounds write SetShowHiddenGroupsBounds;
    property HighlightRoot: Boolean read FHighlightRoot write SetHighlightRoot;

    property ContentBounds: TRect read GetContentBounds;
    property OccupiedClientWidth: Integer read GetOccupiedClientWidth;
    property OccupiedClientHeight: Integer read GetOccupiedClientHeight;

    // Options
    property OptionsImage: TdxLayoutImageOptions read FOptionsImage write SetOptionsImage;

    // Item properies
    property OptionsItem: TdxLayoutItemOptions read FOptionsItem write SetOptionsItem;
    property AutoControlAlignment: Boolean read GetAutoControlAlignment write SetAutoControlAlignment default True;
    property AutoControlTabOrders: Boolean read GetAutoControlTabOrders write SetAutoControlTabOrders default True;
    property AbsoluteItemCount: Integer read GetAbsoluteItemCount;
    property AbsoluteItems[Index: Integer]: TdxCustomLayoutItem read GetAbsoluteItem;
    property AvailableItemCount: Integer read GetAvailableItemCount;
    property AvailableItems[Index: Integer]: TdxCustomLayoutItem read GetAvailableItem;
    property AlignmentConstraintCount: Integer read GetAlignmentConstraintCount;
    property AlignmentConstraints[Index: Integer]: TdxLayoutAlignmentConstraint read GetAlignmentConstraint;
    property Items: TdxLayoutGroup read FRootGroup;

    // Storing properties
    property OptionsStoring: TdxStoringOptions read FOptionsStoring write SetOptionsStoring;
    property IniFileName: string read GetIniFileName write SetIniFileName;
    property RegistryPath: string read GetRegistryPath write SetRegistryPath;
    property StoreInIniFile: Boolean read GetStoreInIniFile write SetStoreInIniFile;
    property StoreInRegistry: Boolean read GetStoreInRegistry write SetStoreInRegistry;

    // Undo
    property UndoRedoManager: TdxUndoRedoManager read FUndoRedoManager;

    property Painter: TdxLayoutControlPainter read FPainter;
    property ViewInfo: TdxLayoutControlViewInfo read FViewInfo;

    property OnCustomization: TNotifyEvent read FOnCustomization write FOnCustomization;
  end;

  TdxLayoutControl = class(TdxCustomLayoutControl)
  published
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusOnClick;
    property Font;
    property ParentBackground default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property AutoContentSizes stored False; // obsolete
    property AutoControlAlignment stored False; // obsolete
    property AutoControlTabOrders stored False; // obsolete
    property AutoSize;

    property LookAndFeel stored False; // obsolete
    property LayoutLookAndFeel;

    // Customization properties
    property CustomizeFormTabbedView default False;
    property ShowDesignSelectors default True;
    property HighlightRoot default True;

    // Options
    property OptionsImage;
    property OptionsItem;

    // Storing properties
    property OptionsStoring;
    property IniFileName stored False; // obsolete
    property RegistryPath stored False; // obsolete
    property StoreInIniFile stored False; // obsolete
    property StoreInRegistry stored False; // obsolete

    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;

    property OnCustomization;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

  { hit tests }

  TdxCustomLayoutHitTestClass = class of TdxCustomLayoutHitTest;

  TdxCustomLayoutHitTest = class
  private
    FHitItem: TdxCustomLayoutItem;
    FHitPoint: TPoint;
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

    property HitItem: TdxCustomLayoutItem read FHitItem write FHitItem;
    property HitPoint: TPoint read FHitPoint write FHitPoint;
  end;

  TdxCustomLayoutItemHitTest = class(TdxCustomLayoutHitTest);

  TdxLayoutNoneHitTest = class(TdxCustomLayoutHitTest)
  public
    class function HitTestCode: Integer; override;
  end;

  TdxCustomLayoutItemHitTestClass = class of TdxCustomLayoutItemHitTest;

  TdxLayoutItemHitTest = class(TdxCustomLayoutItemHitTest)
  private
    function GetHitItem: TdxLayoutItem;
    procedure SetHitItem(Value: TdxLayoutItem);
  public
    class function HitTestCode: Integer; override;
    function GetGroupForInsert: TdxLayoutGroup; override;

    property HitItem: TdxLayoutItem read GetHitItem write SetHitItem;
  end;

  TdxLayoutGroupHitTest = class(TdxCustomLayoutItemHitTest)
  private
    function GetHitItem: TdxLayoutGroup;
    procedure SetHitItem(Value: TdxLayoutGroup);
  public
    class function HitTestCode: Integer; override;
    function GetGroupForInsert: TdxLayoutGroup; override;

    property HitItem: TdxLayoutGroup read GetHitItem write SetHitItem;
  end;

  TdxLayoutTabbedGroupHitTest = class(TdxLayoutGroupHitTest)
  private
    function GetSpecific: TdxLayoutGroupViewInfoTabbedSpecific;
    property Specific: TdxLayoutGroupViewInfoTabbedSpecific read GetSpecific;
  public
    function GetDestinationItem: TdxCustomLayoutItem; override;
    function GetSourceItem: TdxCustomLayoutItem; override;
  end;

  TdxLayoutCustomizeFormHitTest = class(TdxCustomLayoutHitTest)
  private
    FAreaPart: TdxLayoutAreaPart;
  public
    class function HitTestCode: Integer; override;
    function IsDeterminedAreaPart: Boolean; override;
    function GetAreaPart: TdxLayoutAreaPart; override;
    function GetDestinationItem: TdxCustomLayoutItem; override;
    property AreaPart: TdxLayoutAreaPart read FAreaPart write FAreaPart;
  end;

  TdxLayoutCustomizeFormAvailableItemsHitTest = class(TdxLayoutCustomizeFormHitTest)
  public
    class function HitTestCode: Integer; override;
  end;

  TdxLayoutCustomizeFormTreeViewItemsHitTest = class(TdxLayoutCustomizeFormHitTest)
  public
    class function HitTestCode: Integer; override;
  end;

  TdxLayoutClientAreaHitTest = class(TdxCustomLayoutHitTest)
  private
    FControl: TdxCustomLayoutControl;
  public
    class function HitTestCode: Integer; override;
    function GetGroupForInsert: TdxLayoutGroup; override;
    function GetDestinationItem: TdxCustomLayoutItem; override;

    property Control: TdxCustomLayoutControl read FControl write FControl;
  end;

  TdxLayoutSizeHitTest = class(TdxCustomLayoutItemHitTest)
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
  TdxLayoutItemCaptionPainter = class(TdxCustomLayoutItemCaptionPainter);

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

  { TdxLayoutItemControlPainter }

  TdxLayoutItemControlPainter = class(TdxCustomLayoutItemElementPainter)
  private
    function GetViewInfo: TdxLayoutItemControlViewInfo;
  protected
    procedure DrawBorders; virtual;
    property ViewInfo: TdxLayoutItemControlViewInfo read GetViewInfo;
  public
    procedure Paint; override;
  end;

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

  TdxLayoutItemPainter = class(TdxLayoutLabeledItemPainter)
  private
    function GetViewInfo: TdxLayoutItemViewInfo;
  protected
    function CanDrawSpecificPart: Boolean; override;

    function GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass; override;
    function GetControlPainterClass: TdxLayoutItemControlPainterClass; virtual;

    procedure DoDrawControlBorder; virtual;
    procedure DoDrawSpecificPart; override;

    procedure DrawContent; override;
    procedure DrawControlBorder; virtual;

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

    procedure DoDrawSpecificPart; override;
    procedure DoDrawSelectionFrame; override;
    procedure DrawBackground; override;
    procedure DrawContent; override;

    function CanDrawSpecificBackground: Boolean; virtual;
    function HasCaptionBackground: Boolean; virtual;

    procedure DoDrawBorders; virtual;
    procedure DoDrawButtons; virtual;
    procedure DoDrawRestSpace; virtual;
    procedure DoDrawBoundsFrame; virtual;
    procedure DoDrawSpecificBackground; virtual;

    procedure DrawBorders; virtual;
    procedure DrawBoundsFrame; virtual;
    procedure DrawButtons; virtual;
    procedure DrawItems; virtual;
    procedure DrawRestSpace; virtual;
    procedure DrawItemsArea; virtual;
    procedure DrawSpecificPart; override;
    procedure DrawSpecificBackground; virtual;
    procedure DrawDesignFeatures; override;

    property ViewInfo: TdxLayoutGroupViewInfo read GetViewInfo;
  end;

  // Layout Control

  { TdxCustomLayoutControlHandler }

  TdxCustomLayoutControlHandler = class
  private
    FControl: TdxCustomLayoutControl;
    function GetViewInfo: TdxLayoutControlViewInfo;
  protected
    property Control: TdxCustomLayoutControl read FControl;
    property ViewInfo: TdxLayoutControlViewInfo read GetViewInfo;
  public
    constructor Create(AControl: TdxCustomLayoutControl); virtual;
  end;

  TdxLayoutControlPainter = class(TdxCustomLayoutControlHandler)
  protected
    function GetInternalCanvas: TcxCanvas; virtual;
    procedure MakeCanvasClipped(ACanvas: TcxCanvas);

    procedure DrawBackground(ACanvas: TcxCanvas); virtual;
    procedure DrawDesignSelector(ACanvas: TcxCanvas); virtual;
    procedure DrawItems(ACanvas: TcxCanvas); virtual;
    procedure DrawDesignFeatures(ACanvas: TcxCanvas);

    procedure PlaceControls(AItemViewInfo: TdxCustomLayoutItemViewInfo);

    property InternalCanvas: TcxCanvas read GetInternalCanvas;
  public
    function GetCanvas: TcxCanvas; virtual;

    procedure Paint; virtual;
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
    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel; virtual; abstract;

    function GetEnabled: Boolean; virtual;
    function GetIsCustomization: Boolean; virtual;

    // Mouse
    procedure MouseEnter; dynamic;
    procedure MouseLeave; dynamic;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); dynamic;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); dynamic;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); dynamic;

    procedure StateChanged; virtual;
    function IsHotTrackable: Boolean; virtual;

    property IsCustomization: Boolean read GetIsCustomization;
    property OriginalBounds: TRect read FOriginalBounds;
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
    procedure ShowHint(var AHintInfo: THintInfo; out ACanShow: Boolean); virtual;

    property Item: TdxCustomLayoutItem read GetItem;
    property ItemViewInfo: TdxCustomLayoutItemViewInfo read FItemViewInfo;
    property Visible: Boolean read GetVisible;
  public
    constructor Create(AItemViewInfo: TdxCustomLayoutItemViewInfo); virtual;

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
    procedure PrepareCanvas; virtual;

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
    function GetAlignVert: TdxAlignmentVert; virtual; abstract;
    function GetOptions: TdxLayoutLookAndFeelCaptionOptions; virtual;
    function GetSpaceBetweenImageText: Integer; virtual;

    function GetAvailableHeight: Integer; virtual;
    function GetAvailableTextHeight: Integer; virtual;
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

  TdxCustomLayoutItemViewInfo = class(TdxCustomLayoutElementViewInfo)
  private
    FOffsets: array[TdxLayoutSide] of Integer;
    FCaptionViewInfo: TdxCustomLayoutItemCaptionViewInfo;
    FContainerViewInfo: TdxLayoutControlViewInfo;
    FParentViewInfo: TdxLayoutGroupViewInfo;
    FElements: TObjectList;
    FElementWithMouse: TdxCustomLayoutItemElementViewInfo;
    FItem: TdxCustomLayoutItem;
    FNotifyComponent: TcxFreeNotificator;

    function GetMinHeight: Integer;
    function GetMinWidth: Integer;
    function GetUsualHeight: Integer;
    function GetUsualWidth: Integer;

    function GetAlignHorz: TdxLayoutAlignHorz;
    function GetAlignVert: TdxLayoutAlignVert;
    function GetBackgroundBounds: TRect;
    function GetCanPaint: Boolean;
    function GetOffset(ASide: TdxLayoutSide): Integer;
    function GetOffsetsHeight: Integer;
    function GetOffsetsWidth: Integer;
    function GetSelected: Boolean;
    function GetSelectionArea: TRect;
    function GetSelectionBorderRect: TRect;
    function GetSelectableMarkers: TRects;
    procedure GetSelectionMarkers(out ASelectable, ANonSelectable: TRects);
    procedure SetElementWithMouse(Value: TdxCustomLayoutItemElementViewInfo);
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
    function GetOptions: TdxCustomLayoutLookAndFeelOptions; virtual; abstract;
    function GetMarkerIndex(AMarkers: TRects; const P: TPoint): Integer; overload;
    function GetMarkerIndex(const P: TPoint): Integer; overload;

    function HasBackground: Boolean;
    function HasCaption: Boolean; virtual;  // #DG !!!
    function HasBorder: Boolean; virtual;

    procedure MouseLeave; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel; override;

    procedure Invalidate(const ABounds: TRect); virtual;

    // selections
    procedure PaintSelectionLayer; virtual;

    // Hint
    procedure ShowHint(var AHintInfo: THintInfo; out ACanShow: Boolean);

    // conditions
    function IsAvailable: Boolean;
    function IsParentLocked: Boolean;
    function IsParentSelected: Boolean;
    function IsDefaultColor: Boolean; virtual; abstract;
    function IsTransparent: Boolean; virtual;
    function IsDragged: Boolean;
    function IsDraggedWithParent: Boolean;
    function IsDragImagePainted: Boolean;

    property ActuallyVisible: Boolean read GetActuallyVisible;
    property BackgroundBounds: TRect read GetBackgroundBounds;
    property CanPaint: Boolean read GetCanPaint; // todo: rename
    property ContainerViewInfo: TdxLayoutControlViewInfo read FContainerViewInfo;
    property ElementCount: Integer read GetElementCount;
    property Elements[Index: Integer]: TdxCustomLayoutItemElementViewInfo read GetElement;
    property ElementWithMouse: TdxCustomLayoutItemElementViewInfo read FElementWithMouse write SetElementWithMouse;
    property Item: TdxCustomLayoutItem read FItem;
    property OffsetsHeight: Integer read GetOffsetsHeight;
    property OffsetsWidth: Integer read GetOffsetsWidth;
    property Options: TdxCustomLayoutLookAndFeelOptions read GetOptions;
    property ParentViewInfo: TdxLayoutGroupViewInfo read FParentViewInfo;
  public
    constructor Create(AContainerViewInfo: TdxLayoutControlViewInfo;
      AParentViewInfo: TdxLayoutGroupViewInfo; AItem: TdxCustomLayoutItem); virtual;
    destructor Destroy; override;
    procedure Calculate(const ABounds: TRect); override;

    procedure CalculateTabOrders(var AAvailTabOrder: Integer); virtual;
    function GetHitTest(const P: TPoint): TdxCustomLayoutHitTest; virtual;
    function GetItemWithMouse(const P: TPoint): TdxCustomLayoutItem; virtual;
    procedure ResetOffset(ASide: TdxLayoutSide);

    property AlignHorz: TdxLayoutAlignHorz read GetAlignHorz;
    property AlignVert: TdxLayoutAlignVert read GetAlignVert;
    property CaptionViewInfo: TdxCustomLayoutItemCaptionViewInfo read FCaptionViewInfo;
    property Color: TColor read GetColor;

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
    procedure PrepareCanvas; override;
    function IsHotTrackable: Boolean; override;
  end;

  { TdxLayoutLabeledItemCaptionViewInfo }

  TdxLayoutLabeledItemCaptionViewInfo = class(TdxLayoutBasicItemCaptionViewInfo)
  private
    function GetItem: TdxLayoutCustomLabeledItem;
    function GetItemViewInfo: TdxLayoutLabeledItemViewInfo;
  protected
    function GetAlignVert: TdxAlignmentVert; override;
    function GetCursor(X, Y: Integer): TCursor; override;
    function GetIsFixedWidth: Boolean; virtual;
    function GetSpaceBetweenImageText: Integer; override;
    function GetTextAreaBounds: TRect; override;
    function GetTextWidth: Integer; override;
    function IsMultiLine: Boolean; override;

    property IsFixedWidth: Boolean read GetIsFixedWidth;
    property Item: TdxLayoutCustomLabeledItem read GetItem;
    property ItemViewInfo: TdxLayoutLabeledItemViewInfo read GetItemViewInfo;
  public
    function CalculateMinWidth: Integer; override;
  end;

  { TdxLayoutItemCaptionViewInfo }

  TdxLayoutItemCaptionViewInfo = class(TdxLayoutLabeledItemCaptionViewInfo)
  private
    function GetItem: TdxLayoutItem;
    function GetItemViewInfo: TdxLayoutItemViewInfo;
  protected
    property Item: TdxLayoutItem read GetItem;
    property ItemViewInfo: TdxLayoutItemViewInfo read GetItemViewInfo;
  end;

  TdxLayoutItemControlViewInfo = class(TdxCustomLayoutItemElementViewInfo)
  private
    FPrevControlSize: TSize;
    FControlBounds: TRect;
    function GetBorderColor: TColor;
    function GetBorderStyle: TdxLayoutBorderStyle;
    function GetControl: TControl;
    function GetItem: TdxLayoutItem;
    function GetItemViewInfo: TdxLayoutItemViewInfo;
    function GetOpaqueControl: Boolean;
  protected
    function GetVisible: Boolean; override;

    function CalculateControlBounds: TRect; virtual;
    function GetBorderWidth(ASide: TdxLayoutSide): Integer; virtual;
    function GetControlAreaHeight(AControlHeight: Integer): Integer; virtual;
    function GetControlAreaWidth(AControlWidth: Integer): Integer; virtual;

    function HasBorder: Boolean;

    property BorderWidths[ASide: TdxLayoutSide]: Integer read GetBorderWidth;
    property Item: TdxLayoutItem read GetItem;
    property ItemViewInfo: TdxLayoutItemViewInfo read GetItemViewInfo;
  public
    procedure Calculate(const ABounds: TRect); override;
    procedure CalculateTabOrder(var AAvailTabOrder: Integer); virtual;

    function CalculateMinHeight: Integer; override;
    function CalculateMinWidth: Integer; override;
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;

    property BorderColor: TColor read GetBorderColor;
    property BorderStyle: TdxLayoutBorderStyle read GetBorderStyle;
    property Control: TControl read GetControl;
    property ControlBounds: TRect read FControlBounds;
    property OpaqueControl: Boolean read GetOpaqueControl;
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
    function GetOptions: TdxCustomLayoutLookAndFeelOptions; override;

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
    function DoCalculateHeight(AIsMinHeight: Boolean): Integer; override;
    function DoCalculateWidth(AIsMinWidth: Boolean): Integer; override;

    function GetElementOffsetHorz: Integer; virtual;
    function GetElementOffsetVert: Integer; virtual;
    function GetOptions: TdxCustomLayoutLookAndFeelOptions; override;

    property ElementOffsetHorz: Integer read GetElementOffsetHorz;
    property ElementOffsetVert: Integer read GetElementOffsetVert;
  public
    procedure Calculate(const ABounds: TRect); override;

    property ContentBounds: TRect read GetContentBounds;
  end;

  TdxLayoutItemViewInfo = class(TdxLayoutLabeledItemViewInfo)
  private
    FControlViewInfo: TdxLayoutItemControlViewInfo;
    function GetCaptionViewInfo: TdxLayoutItemCaptionViewInfo;
    function GetItem: TdxLayoutItem;
    function GetOptionsEx: TdxLayoutLookAndFeelItemOptions;
  protected
    FControlViewInfoBounds: TRect;

    procedure DoCreateViewInfos; override;
    procedure PopulateAutoAlignControlList(AList: TList); override;
    procedure PopulateControlViewInfoList(AControls, AWinControls: TList); override;

    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
    function GetControlViewInfoClass: TdxLayoutItemControlViewInfoClass; virtual;
    function GetHitTestClass: TdxCustomLayoutItemHitTestClass; override;
    function GetPainterClass: TdxCustomLayoutItemPainterClass; override;

    procedure CalculateViewInfoBounds; override;

    function GetContentHeight(AIsMinHeight: Boolean): Integer; override;
    function GetContentWidth(AIsMinWidth: Boolean): Integer; override;

    function GetAutoControlAreaAlignment: Boolean; virtual;
    function GetCaptionLayout: TdxCaptionLayout; virtual;
    function HasControl: Boolean; virtual;

    // selections
    procedure PaintSelectionLayer; override;
    function PtInDesignSelectorRect(const P: TPoint): Boolean;

    property Item: TdxLayoutItem read GetItem;
    property Options: TdxLayoutLookAndFeelItemOptions read GetOptionsEx;
  public
    procedure Calculate(const ABounds: TRect); override;
    procedure CalculateTabOrders(var AAvailTabOrder: Integer); override;

    property AutoControlAreaAlignment: Boolean read GetAutoControlAreaAlignment;
    property CaptionLayout: TdxCaptionLayout read GetCaptionLayout;
    property CaptionViewInfo: TdxLayoutItemCaptionViewInfo read GetCaptionViewInfo;
    property ControlViewInfo: TdxLayoutItemControlViewInfo read FControlViewInfo;
  end;

  { GroupViewInfos }

  { TdxLayoutGroupCaptionViewInfo }

  TdxLayoutGroupCaptionViewInfo = class(TdxCustomLayoutItemCaptionViewInfo)
  protected
    function GetAlignVert: TdxAlignmentVert; override;
  public
    function CalculateMinWidth: Integer; override;
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

  TdxLayoutGroupViewInfoSpecific = class
  private
    FGroupViewInfo: TdxLayoutGroupViewInfo;
    FItemInfos: TItemInfos;

    procedure PrepareItemInfos;
    procedure CalculateItemViewInfos;

    function GetContainer: TdxCustomLayoutControl;
    function GetItemOffset: Integer;
    function GetItemViewInfo(Index: Integer): TdxCustomLayoutItemViewInfo;
    function GetItemViewInfoCount: Integer;
    function GetLayoutDirection: TdxLayoutDirection;
  protected
    // Drawing
    procedure DrawSpecificPart(ACanvas: TcxCanvas); virtual; // !!!
    procedure DrawSpecificBackground(ACanvas: TcxCanvas); virtual; // !!!

    // Calculating
    procedure CorrectItemsAreaBounds(var AItemsAreaBounds: TRect); virtual;
    procedure CalculateItemsHorizontalBounds(const AItemsAreaBounds: TRect); virtual;
    procedure CalculateItemsVerticalBounds(const AItemsAreaBounds: TRect); virtual;
    procedure CalculateTabOrders(var ATabOrder: Integer); virtual;

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

    // Specific Objects
    procedure CreateSpecificControls; virtual;
    procedure DestroySpecificControls; virtual;
    procedure CreateViewInfos; virtual;
    procedure SetControlVisibility; virtual;

    property Container: TdxCustomLayoutControl read GetContainer;
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

    function AllowDrawChild(AChild: TdxCustomLayoutItem): Boolean; virtual;
    function AllowChildHasBorder: Boolean; virtual;
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

  TdxLayoutTabbedGroupTabControl = class(TcxTabControl)
  private
    FImages: TcxImageList;
    FOnPaint: TNotifyEvent;
    FOnTabClick: TcxTabChangedEvent;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    procedure BoundsChanged; override;
    function GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean; override;
    procedure Paint; override;
    procedure TabClick(Sender: TObject; ATabVisibleIndex: Integer; AShift: TShiftState); override;

    procedure AddTab(AItem: TdxCustomLayoutItem);
    procedure DoPaint;

    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    property OnTabClick: TcxTabChangedEvent read FOnTabClick write FOnTabClick;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TdxTabControlElementViewInfo = class(TdxCustomLayoutItemElementViewInfo)
  private
    FTabControl: TdxLayoutTabbedGroupTabControl;
  protected
    function GetVisible: Boolean; override;
    procedure MouseEnter; override;
    procedure MouseLeave; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  end;

  TdxLayoutGroupViewInfoTabbedSpecific = class(TdxLayoutGroupViewInfoHorizontalSpecific)
  private
    FSpecificPainting: Boolean;
    FTabControl: TdxLayoutTabbedGroupTabControl;
    FTabControlBounds: TRect;
    FTabControlElementViewInfo: TdxTabControlElementViewInfo;

    procedure ActiveTabChanged(ASender: TObject);
    procedure TabControlPaint(ASender: TObject);
    procedure TabClick(ASender: TObject; ATabIndex: Integer);
  protected
    // Drawing
    procedure DrawSpecificPart(ACanvas: TcxCanvas); override;
    procedure DrawSpecificBackground(ACanvas: TcxCanvas); override;

    // Calculating
    procedure CorrectItemsAreaBounds(var AItemsAreaBounds: TRect); override;
    procedure CalculateItemsHorizontalBounds(const AItemsAreaBounds: TRect); override;
    procedure CalculateItemsVerticalBounds(const AItemsAreaBounds: TRect); override;
    procedure CalculateTabOrders(var ATabOrder: Integer); override;

    // Dragging
    function GetActionType(AAreaPart: TdxLayoutAreaPart): TdxLayoutActionType; override;
    procedure CorrectAreaPart(var AAreaPart: TdxLayoutAreaPart); override;
    function GetAreaPart(const P: TPoint): TdxLayoutAreaPart; override;
    function GetAreaPartBounds(AAreaPart: TdxLayoutAreaPart; AItemViewInfo: TdxCustomLayoutItemViewInfo): TRect; override;

    // Sizes
    function GetCustomHeight(AIsMinHeight: Boolean): Integer; override;
    function GetCustomWidth(AIsMinWidth: Boolean): Integer; override;

    function GetItemsAreaOffset(ASide: TdxLayoutSide): Integer; override;

    // Specific Objects
    procedure CreateSpecificControls; override;
    procedure DestroySpecificControls; override;
    procedure CreateViewInfos; override;
    procedure SetControlVisibility; override;

    procedure CreateTabControl;
    procedure DestroyTabControl;
    function HasTabControl: Boolean;
  public
    procedure Calculate(const AItemsAreaBounds: TRect); override;
    function AllowDrawChild(AChild: TdxCustomLayoutItem): Boolean; override;
    function AllowChildHasBorder: Boolean; override;
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
    procedure ShowHint(var AHintInfo: THintInfo; out ACanShow: Boolean); override;

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

    procedure CalculateButtonViewInfos;
    procedure CreateButtonViewInfos;
    procedure RecreateButtonViewInfos;
    procedure DestroyButtonViewInfos;

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
    function GetCaptionViewInfo: TdxLayoutGroupCaptionViewInfo;
    function GetGroup: TdxLayoutGroup;
    function GetItemViewInfo(Index: Integer): TdxCustomLayoutItemViewInfo;
    function GetItemViewInfoCount: Integer;
    function GetLayoutDirection: TdxLayoutDirection;
    function GetOptionsEx: TdxLayoutLookAndFeelGroupOptions;

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
    procedure FreeNotification(AComponent: TComponent); override;
    procedure PopulateAutoAlignControlList(AList: TList); override;
    procedure PopulateControlViewInfoList(AControls, AWinControls: TList); override;

    // Classes
    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
    function GetHitTestClass: TdxCustomLayoutItemHitTestClass; override;
    function GetPainterClass: TdxCustomLayoutItemPainterClass; override;

    // Drawing attributes
    function GetBackgroundColor: TColor; override;
    function GetColor: TColor; override;
    function GetOptions: TdxCustomLayoutLookAndFeelOptions; override;

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
    function GetMaxChildImageSize: TSize;
    function GetMinVisibleHeight: Integer; virtual;
    function GetMinVisibleWidth: Integer; virtual;
    function GetRestSpaceBounds: TRect; virtual;

    // Conditions
    function AllowChildHasBorder: Boolean;
    function AllowCollapsedHeight: Boolean; virtual;
    function AllowCollapsedWidth: Boolean; virtual;
    function HasBoundsFrame: Boolean; virtual;
    function UseItemOffset: Boolean; virtual;
    function UseItemsAreaOffsets: Boolean; virtual;

    // Classes
    function GetItemViewInfoClass(AItem: TdxCustomLayoutItem): TdxCustomLayoutItemViewInfoClass; virtual;
    function GetSpecificClass: TdxLayoutGroupViewInfoSpecificClass; virtual;

    // Selections
    procedure PaintSelectionLayer; override;

    property ButtonsViewInfoOffset: Integer read GetButtonsViewInfoOffset;
    property CaptionViewInfoOffset: Integer read GetCaptionViewInfoOffset;
    property ItemOffset: Integer index 0 read GetOffset write FItemOffset;
    property ItemsAreaOffsetHorz: Integer index 1 read GetOffset write FItemsAreaOffsetHorz;
    property ItemsAreaOffsetVert: Integer index 2 read GetOffset write FItemsAreaOffsetVert;
    property MinVisibleHeight: Integer read GetMinVisibleHeight;
    property MinVisibleWidth: Integer read GetMinVisibleWidth;
    property RestSpaceBounds: TRect read GetRestSpaceBounds;

    property Group: TdxLayoutGroup read GetGroup;
    property LayoutDirection: TdxLayoutDirection read GetLayoutDirection;
    property Options: TdxLayoutLookAndFeelGroupOptions read GetOptionsEx;
    property Specific: TdxLayoutGroupViewInfoSpecific read FSpecific;
  public
    procedure Calculate(const ABounds: TRect); override;
    procedure CalculateTabOrders(var AAvailTabOrder: Integer); override;
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

  TdxLayoutControlViewInfo = class(TdxCustomLayoutControlHandler)
  private
    FCanvas: TcxCanvas;
    FContentBounds: TRect;
    FItemsViewInfo: TdxLayoutGroupViewInfo;
    FSelectionLayer: TdxSelectionLayer;

    FIsDragImagePainted: Boolean;

    procedure CreateSelectionLayer;
    procedure BuildSelectionLayer;
    function GetClientHeight: Integer;
    function GetClientWidth: Integer;
    function GetContentHeight: Integer;
    function GetContentWidth: Integer;
    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
    function GetSelectionLayer: TdxSelectionLayer;
    procedure SelectionLayerHitTest(ASender: TObject; var AIsTransparent: Boolean);
    procedure SelectionLayerShow(Sender: TObject);
  protected
    procedure CreateViewInfos; virtual;
    procedure DestroyViewInfos; virtual;
    function GetItemsViewInfoClass: TdxLayoutGroupViewInfoClass; virtual;
    procedure RecreateViewInfos;

    procedure AlignItemsByConstraint; virtual;
    procedure AutoAlignControls; virtual;
    procedure CalculateItemsViewInfo; virtual;
    procedure CalculateTabOrders; virtual;
    function GetIsTransparent: Boolean; virtual;
    function HasBackground: Boolean;
    function NeedHighlightRoot: Boolean;
    procedure PrepareData; virtual;
    procedure ResetContentBounds;

    function GetCanvas: TcxCanvas; virtual;
    function GetClientBounds: TRect; virtual;
    function GetContentBounds: TRect; virtual;

    property Canvas: TcxCanvas read GetCanvas;
    property IsDragImagePainted: Boolean read FIsDragImagePainted write FIsDragImagePainted;
    property IsTransparent: Boolean read GetIsTransparent;
    property SelectionLayer: TdxSelectionLayer read GetSelectionLayer;
  public
    constructor Create(AControl: TdxCustomLayoutControl); override;
    destructor Destroy; override;
    procedure Calculate; virtual;
    procedure DoCalculateTabOrders; virtual;
    function GetHitTest(const P: TPoint): TdxCustomLayoutHitTest; overload; virtual;
    function GetHitTest(X, Y: Integer): TdxCustomLayoutHitTest; overload;
    function GetItemWithMouse(const P: TPoint): TdxCustomLayoutItem;

    property ClientBounds: TRect read GetClientBounds;
    property ClientHeight: Integer read GetClientHeight;
    property ClientWidth: Integer read GetClientWidth;
    property ContentBounds: TRect read GetContentBounds;
    property ContentHeight: Integer read GetContentHeight;
    property ContentWidth: Integer read GetContentWidth;
    property ItemsViewInfo: TdxLayoutGroupViewInfo read FItemsViewInfo;
    property LayoutLookAndFeel: TdxCustomLayoutLookAndFeel read GetLayoutLookAndFeel;
  end;

var
  dxLayoutDesignTimeSelectionHelperClass: TdxLayoutRunTimeSelectionHelperClass;
  dxLayoutRunTimeSelectionHelperClass: TdxLayoutRunTimeSelectionHelperClass;

implementation

{$R *.res}

uses
  Types, TypInfo, Registry, Math, Variants,
  UxTheme, Themes,
  cxContainer, dxOffice11, cxButtons, dxLayoutControlAdapters, dxLayoutCustomizeForm,
  dxLayoutStrs, dxLayoutDragAndDrop;

type
  TControlAccess = class(TControl);
  TdxCustomLayoutLookAndFeelAccess = class(TdxCustomLayoutLookAndFeel);
  TcxPCCustomPainterAccess = class(TcxPCCustomPainter);
  TdxSelectionLayerAccess = class(TdxSelectionLayer);

const
  ScrollStep = 10;

  dxLayoutSelectionDefaultColor: TColor = $EDC8A3;
  dxLayoutControlSelectionDefaultColor: TColor = $582801;
  dxLayoutSelectionBorderDefaultColor: TColor = $BD8753;
  dxLayoutSelectionDefaultAlphaChannel: Byte = 80;
  dxLayoutSelectionBorderMarkerInnerDefaultColor: TColor = clWhite;
  dxLayoutHiddenGroupBackgroundDefaultColor: TColor = $F0E3D1;
  dxLayoutHiddenGroupBorderDefaultColor: TColor = $C8BCB5;
  dxLayoutSelectionOffset = 2;
  dxLayoutGlyphSpace = 4;
  dxLayoutSelectionMarkerWidth = 5;
  dxLayoutThinPartWidth = 2;

  dxLayoutSignature: Integer = $4C434458;
  dxLayoutVersion: Word = 2;

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

procedure dxDrawItemGlyph(ACanvas: TcxCanvas; AItem: TdxCustomLayoutItem; R: TRect);

  function GetDrawMode(AGlyph: TBitmap; AImages: TCustomImageList): TcxImageDrawMode;
  const
    DrawModesMap: array [Boolean] of TcxImageDrawMode = (idmDisabled, idmNormal);
  var
    ADrawEnabled: Boolean;
  begin
    ADrawEnabled := AItem.Enabled or (not IsGlyphAssigned(AGlyph) and (AImages = AItem.Container.OptionsImage.DisabledImages));
    Result := DrawModesMap[ADrawEnabled];
  end;

var
  AGlyph: TBitmap;
  AImages: TCustomImageList;
  AImageIndex: Integer;
begin
  if AItem.CaptionOptions.ImageOptions.GetCurrentImage(AGlyph, AImages, AImageIndex) then
    cxDrawImage(ACanvas.Handle, R, R, AGlyph, AImages, AImageIndex, GetDrawMode(AGlyph, AImages));
end;

type
  { TdxCustomizationControlHelper }

  TdxCustomizationControlHelper = class(TdxControlsDesignSelectorHelper)
  private
    FLayoutItem: TdxLayoutItem;
    procedure SetLayoutItem(AValue: TdxLayoutItem);
  protected
    function DoControlWndProc(var Message: TMessage): Boolean; override;
    function GetChildClass: TdxControlsDesignSelectorHelperClass; override;

    function IsActiveDesignSelector: Boolean; override;
    function IsSelected: Boolean; override;
    function IsValid: Boolean; override;

    function CanDrawDesignSelector: Boolean; override;

    function IsCustomization: Boolean;
    function IsDesigning: Boolean;
  public
    procedure Assign(Source: TPersistent); override;
    property LayoutItem: TdxLayoutItem read FLayoutItem write SetLayoutItem;
  end;

  { TdxDesignCustomizationHelper }

  TdxDesignCustomizationHelper = class
  private
    FLayoutControls: TcxComponentList;
    function GetCount: Integer;
    function GetItem(AIndex: Integer): TdxCustomLayoutControl;
  protected
    function FindActiveDesigner(out ADesigner: IdxLayoutDesignerHelper): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    class procedure AddLayout(ALayout: TdxCustomLayoutControl);
    class procedure RemoveLayout(ALayout: TdxCustomLayoutControl);

    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TdxCustomLayoutControl read GetItem;
  end;

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
  FDesignCustomizationHelper: TdxDesignCustomizationHelper;

function dxDesignCustomizationHelper: TdxDesignCustomizationHelper;
begin
  if FDesignCustomizationHelper = nil then
    FDesignCustomizationHelper := TdxDesignCustomizationHelper.Create;
  Result := FDesignCustomizationHelper;
end;

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

{ TdxCustomizationControlHelper }

procedure TdxCustomizationControlHelper.Assign(Source: TPersistent);
var
  AItem: TdxCustomizationControlHelper;
begin
  if Source is TdxCustomizationControlHelper then
  begin
    AItem := Source as TdxCustomizationControlHelper;
    FLayoutItem := AItem.LayoutItem;
  end;
  inherited Assign(Source);
end;

function TdxCustomizationControlHelper.DoControlWndProc(var Message: TMessage): Boolean;
begin
  if IsValid then
    case Message.Msg of
      WM_PAINT, WM_ERASEBKGND, WM_NCPAINT, CM_TEXTCHANGED:
        if (Control = nil) or not (csPaintCopy in Control.ControlState) then
          LayoutItem.Container.PostInvalidateSelectionLayer(LayoutItem.ViewInfo.ControlViewInfo.Bounds);
    end;
  Result := inherited DoControlWndProc(Message);;
end;

function TdxCustomizationControlHelper.GetChildClass: TdxControlsDesignSelectorHelperClass;
begin
  Result := TdxCustomizationControlHelper;
end;

function TdxCustomizationControlHelper.IsActiveDesignSelector: Boolean;
begin
  Result := inherited IsActiveDesignSelector and LayoutItem.IsDesignSelectorVisible;
end;

function TdxCustomizationControlHelper.IsSelected: Boolean;
begin
  Result := (not LayoutItem.Container.Customization and LayoutItem.ViewInfo.Selected) or
    (LayoutItem.Container.Customization and LayoutItem.Container.IsComponentSelected(LayoutItem.Control));
end;

function TdxCustomizationControlHelper.IsCustomization: Boolean;
begin
  Result := LayoutItem.Container.Customization;
end;

function TdxCustomizationControlHelper.IsDesigning: Boolean;
begin
  Result := LayoutItem.IsDesigning;
end;

function TdxCustomizationControlHelper.IsValid: Boolean;
begin
  Result := inherited IsValid and (LayoutItem <> nil) and (LayoutItem.ViewInfo <> nil);
end;

function TdxCustomizationControlHelper.CanDrawDesignSelector: Boolean;
begin
  Result := inherited CanDrawDesignSelector and LayoutItem.ActuallyVisible;
end;

procedure TdxCustomizationControlHelper.SetLayoutItem(AValue: TdxLayoutItem);
begin
  if AValue <> FLayoutItem then
  begin
    FLayoutItem := AValue;
    CheckChildren;
  end;
end;

{ TdxDesignCustomizationHelper }

var
  FKeyboardHookHandle: HHOOK;
  FMouseHookHandle: HHOOK;

function IsParentFocused(AParent: THandle): Boolean;
begin
  Result := (AParent <> 0) and ((AParent = GetFocus) or IsChildClassWindow(AParent) and IsParentFocused(GetParent(AParent)));
end;

function ProcessKeyboardMessage(AKey: WPARAM; AFlags: LPARAM): Boolean;

  function SelectItemParent(AComponent: TComponent): Boolean;
  var
    AIntf: IdxLayoutSelectableItem;
  begin
    Result := Supports(AComponent, IdxLayoutSelectableItem, AIntf);
    if Result then
      AIntf.SelectParent;
  end;

  function KeyPressed: Boolean;
  begin
    Result := (AFlags shr 31) and 1 = 0;
  end;

var
  AList: TcxComponentList;
  ADesigner: IdxLayoutDesignerHelper;
begin
  Result := KeyPressed;
  if Result then
  begin
    AList := TcxComponentList.Create;
    try
      if dxDesignCustomizationHelper.FindActiveDesigner(ADesigner) and ADesigner.CanProcessKeyboard then
        ADesigner.GetSelection(AList);
      Result := (AList.Count > 0);
      if Result then
        case AKey of
          VK_DELETE:
            begin
              ADesigner.DeleteSelection;
              Result := False;
            end;
          VK_ESCAPE:
            Result := SelectItemParent(AList[0]);
        else
          Result := False;
        end;
    finally
      AList.Free;
    end;
  end;
end;

function KeyboardHookProc(Code: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if (Code = HC_ACTION) and ProcessKeyboardMessage(wParam, lParam) then
    Result := 1
  else
    Result := CallNextHookEx(FKeyboardHookHandle, Code, wParam, lParam);
end;


function ProcessMouseMessage(AMessage: WPARAM; AMessageData: TMouseHookStruct): Boolean;
var
  I: Integer;
  ALayout: TdxCustomLayoutControl;
  P: TPoint;
  AControl: TWinControl;
begin
  Result := False;
  for I := 0 to dxDesignCustomizationHelper.Count - 1 do
  begin
    ALayout := dxDesignCustomizationHelper.Items[I];
    if not ALayout.IsDesigning and (ALayout.Parent.Handle = AMessageData.hwnd) and (GetCapture = 0) and
      PtInRect(ALayout.BoundsRect, ALayout.Parent.ScreenToClient(AMessageData.pt)) then
    begin
      Result := True;
      P := ALayout.ScreenToClient(AMessageData.pt);
      if ALayout.HScrollBarVisible and PtInRect(ALayout.HScrollBar.BoundsRect, P) then
        AControl := ALayout.HScrollBar
      else
        if ALayout.VScrollBarVisible and PtInRect(ALayout.VScrollBar.BoundsRect, P) then
          AControl := ALayout.VScrollBar
        else
        begin
          AControl := ALayout;
          with ALayout.ScreenToClient(AMessageData.pt) do
            SetCursor(Screen.Cursors[ALayout.GetCursor(X, Y)]);
        end;
      P := AControl.ScreenToClient(AMessageData.pt);
      AControl.Perform(AMessage, GetMouseKeys, LPARAM(PointToSmallPoint(P)));
      Break;
    end;
  end;
end;

function MouseHookProc(Code: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if (Code = HC_ACTION) and ProcessMouseMessage(wParam, PMouseHookStruct(lParam)^) then
  begin
    CallNextHookEx(FMouseHookHandle, Code, wParam, lParam);
    Result := 1;
  end
  else
    Result := CallNextHookEx(FMouseHookHandle, Code, wParam, lParam);
end;

constructor TdxDesignCustomizationHelper.Create;
begin
  inherited;
  FLayoutControls := TcxComponentList.Create(False);
  SetHook(FKeyboardHookHandle, WH_KEYBOARD, KeyboardHookProc);
  SetHook(FMouseHookHandle, WH_MOUSE, MouseHookProc);
end;

destructor TdxDesignCustomizationHelper.Destroy;
begin
  ReleaseHook(FMouseHookHandle);
  ReleaseHook(FKeyboardHookHandle);
  FreeAndNil(FLayoutControls);
  inherited;
end;

class procedure TdxDesignCustomizationHelper.AddLayout(ALayout: TdxCustomLayoutControl);
begin
  if dxDesignCustomizationHelper.FLayoutControls.IndexOf(ALayout) = -1 then
    dxDesignCustomizationHelper.FLayoutControls.Add(ALayout);
end;

class procedure TdxDesignCustomizationHelper.RemoveLayout(ALayout: TdxCustomLayoutControl);
begin
  dxDesignCustomizationHelper.FLayoutControls.Extract(ALayout);
end;

function TdxDesignCustomizationHelper.FindActiveDesigner(out ADesigner: IdxLayoutDesignerHelper): Boolean;
var
  I: Integer;
  ALayout: TdxCustomLayoutControl;
begin
  Result := False;
  for I := 0 to FLayoutControls.Count - 1 do
  begin
    ALayout := FLayoutControls[I] as TdxCustomLayoutControl;
    Result := Supports(ALayout, IdxLayoutDesignerHelper, ADesigner) and ADesigner.IsActive and ALayout.HandleAllocated and
      ((ALayout.Handle = GetFocus) or ((ALayout.Parent <> nil) and ALayout.Parent.HandleAllocated and IsParentFocused(ALayout.Parent.Handle)));
    if Result then
      Break;
  end;
end;

function TdxDesignCustomizationHelper.GetCount: Integer;
begin
  Result := FLayoutControls.Count;
end;

function TdxDesignCustomizationHelper.GetItem(AIndex: Integer): TdxCustomLayoutControl;
begin
  Result := FLayoutControls[AIndex] as TdxCustomLayoutControl;
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

{ TdxLayoutControlCustomCustomizeForm }

destructor TdxLayoutControlCustomCustomizeForm.Destroy;
begin
  Control.Customization := False;
  Control.OnItemChanged := nil;
  inherited Destroy;
end;

function TdxLayoutControlCustomCustomizeForm.GetHitTest(const P: TPoint): TdxCustomLayoutHitTest;
begin
  Result := TdxLayoutCustomizeFormHitTest.Instance;
  TdxLayoutCustomizeFormHitTest(Result).HitItem := nil;
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
  if Control <> nil then
    Params.WndParent := Control.Handle;
end;

procedure TdxLayoutControlCustomCustomizeForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Control) then
    Free;
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
  Control.OnItemChanged := ItemChanged;
end;

procedure TdxLayoutControlCustomCustomizeForm.ItemChanged(AItem: TdxCustomLayoutItem);
begin
end;

procedure TdxLayoutControlCustomCustomizeForm.SetControl(AValue: TdxCustomLayoutControl);

  procedure StoreMetrics;
  begin
    cxDialogsMetricsStore.StoreMetrics(Self);
  end;

  procedure RestoreMetrics;
  begin
    if Control <> nil then
      if EqualRect(Control.CustomizeFormBounds, cxNullRect) then
        BoundsRect := Control.CalculateCustomizeFormBounds(BoundsRect)
      else
        BoundsRect := Control.CustomizeFormBounds;
    cxDialogsMetricsStore.InitDialog(Self);
    Position := poDesigned;
  end;

begin
  if Control <> AValue then
  begin
    if Control <> nil then
    begin
      Control.OnItemChanged := nil;
      StoreMetrics;
    end;
    FControl := AValue;
    RecreateWnd;
    if Control <> nil then
    begin
      RestoreMetrics;
      InitializeControl;
    end;
  end;
end;

{ TdxCustomLayoutItemOptions }

constructor TdxCustomLayoutItemOptions.Create(AItem: TdxCustomLayoutItem);
begin
  inherited Create;
  FItem := AItem;
end;

procedure TdxCustomLayoutItemOptions.BeginUpdate;
begin
  Item.Container.BeginUpdate;
end;

procedure TdxCustomLayoutItemOptions.EndUpdate;
begin
  Item.Container.CancelUpdate;
  Changed;
end;

procedure TdxCustomLayoutItemOptions.Changed;
begin
  FItem.Changed;
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
  ADisabledImages := Item.Container.OptionsImage.DisabledImages;
  if AEnabled or not Assigned(ADisabledImages) then
    Result := Item.Container.OptionsImage.Images
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

function TdxCustomLayoutItemCaptionOptions.GetGlyph: TBitmap;
begin
  Result := ImageOptions.Glyph;
end;

function TdxCustomLayoutItemCaptionOptions.GetImageIndex: Integer;
begin
  Result := ImageOptions.ImageIndex;
end;

procedure TdxCustomLayoutItemCaptionOptions.SetAlignHorz(Value: TAlignment);
begin
  if FAlignHorz <> Value then
  begin
    FAlignHorz := Value;
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
//  Item.Changed;
end;

function TdxLayoutSizeOptions.GetSizableHorz: Boolean;
begin
  if (sovSizableHorz in AssignedValues) then
    Result := FSizableHorz
  else
    if Item.Container <> nil then
      Result := Item.Container.OptionsItem.SizableHorz
    else
      Result := False;
end;

function TdxLayoutSizeOptions.GetSizableVert: Boolean;
begin
  if (sovSizableVert in AssignedValues) then
    Result := FSizableVert
  else
    if Item.Container <> nil then
      Result := Item.Container.OptionsItem.SizableVert
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

{ TdxCustomLayoutItem }

constructor TdxCustomLayoutItem.Create(AOwner: TComponent);
begin
  inherited;
  FIsUserDefined := True;
  FAllowRemove := True;
  FAlignHorz := ahParentManaged;
  FAlignVert := avParentManaged;
  FCaptionOptions := GetCaptionOptionsClass.Create(Self);
  FSizeOptions := TdxLayoutSizeOptions.Create(Self);
  FEnabled := True;
  FOffsets := TdxLayoutOffsets.Create(Self);
  FVisible := True;
end;

procedure TdxCustomLayoutItem.BeforeDestruction;
begin
  Container.BeginUpdate;
  inherited;
  Container.FinishDragAndDrop(False);
  AlignmentConstraint := nil;
end;

destructor TdxCustomLayoutItem.Destroy;
var
  AContainer: TdxCustomLayoutControl;
begin
  HasMouse := False;
  LayoutLookAndFeel := nil;
  FreeAndNil(FOffsets);
  FreeAndNil(FSizeOptions);
  FreeAndNil(FCaptionOptions);
  AContainer := Container;
  if Parent <> nil then
    Parent.ExtractItem(Self);
  cxClearObjectLinks(Self);
  inherited;
  AContainer.EndUpdate;
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
  Result := GetVisible and (IsRoot or (FParent <> nil) and FParent.IsChildActuallyVisible(Self)) and IsParentExpanded;
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

function TdxCustomLayoutItem.GetHasMouse: Boolean;
begin
  Result := FContainer.ItemWithMouse = Self;
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

function TdxCustomLayoutItem.GetIsRoot: Boolean;
begin
  Result := (FContainer <> nil) and (FContainer.FRootGroup = Self);
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

procedure TdxCustomLayoutItem.SetContainer(Value: TdxCustomLayoutControl);
begin
  if FContainer <> Value then
  begin
    if not IsRoot and (FContainer <> nil) then
      FContainer.ExtractAbsoluteItem(Self);
    FContainer := Value;
    if not IsRoot then
    begin
      if FContainer <> nil then
        FContainer.AddAbsoluteItem(Self);
      if Self.Name = '' then
        SetComponentName(Self, GetBaseName, IsDesigning, IsLoading);
    end
    else
      Name := GetValidName(Self, GetBaseName + '_Root');
    ContainerChanged;
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

procedure TdxCustomLayoutItem.SetHasMouse(Value: Boolean);
begin
  if HasMouse <> Value then
    if Value then
      FContainer.ItemWithMouse := Self
    else
      FContainer.ItemWithMouse := nil;
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
      if FContainer <> nil then
        FContainer.ExtractAvailableItem(Self);
    if Value <> nil then
      Value.AddItem(Self)
    else
      if (APrevParent <> nil) and not APrevParent.IsDestroying then
        FContainer.AddAvailableItem(Self);
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

function TdxCustomLayoutItem.IsAlignHorzStored: Boolean;
begin
  Result := IsRoot or (AlignHorz <> ahParentManaged);
end;

function TdxCustomLayoutItem.IsAlignVertStored: Boolean;
begin
  Result := IsRoot or (AlignVert <> avParentManaged);
end;

procedure TdxCustomLayoutItem.Loaded;
begin
  inherited Loaded;
  FIsUserDefined := False;
end;

procedure TdxCustomLayoutItem.SetName(const Value: TComponentName);
begin
  inherited;
  if Container.IsDesigning then
    DoChanged;
end;

procedure TdxCustomLayoutItem.SetParentComponent(Value: TComponent);
begin
  inherited;
  if Value is TdxLayoutGroup then
    Parent := TdxLayoutGroup(Value)
  else
    if Value is TdxCustomLayoutControl then
      TdxCustomLayoutControl(Value).AddAvailableItem(Self);
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

function TdxCustomLayoutItem.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := False;
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
  Result := FContainer.Name;
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
  Result := not IsDesigning and Container.Customization and
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
      Result := FContainer.GetLayoutLookAndFeel;
end;

function TdxCustomLayoutItem.GetParentHelperClass: TdxLayoutGroupHelperClass;
begin
  if Parent <> nil then
    Result := Parent.GetHelperClass
  else
    Result := TdxLayoutGroupHelper;
end;

procedure TdxCustomLayoutItem.DoChanged;
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

function TdxCustomLayoutItem.IsExpanded: Boolean;
begin
  Result := True;
end;

function TdxCustomLayoutItem.IsParentExpanded: Boolean;
begin
  Result := (Parent = nil) or (Parent.IsExpanded and Parent.IsParentExpanded);
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

procedure TdxCustomLayoutItem.MouseEnter;
begin
  ViewInfo.MouseEnter;
end;

procedure TdxCustomLayoutItem.MouseLeave;
begin
  if FViewInfo <> nil then
    FViewInfo.MouseLeave;
end;

procedure TdxCustomLayoutItem.CustomizationMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TdxCustomLayoutHitTest;
  AForm: TCustomForm;
begin
  AHitTest := ViewInfo.GetHitTest(Point(X, Y));
  if AHitTest is TdxCustomLayoutItemHitTest then
  begin
    if not IsDesigning and Container.Customization then
    begin
      AForm := GetParentForm(Container);
      if AForm <> nil then
        AForm.SetFocus;
    end;
    TdxCustomLayoutItemHitTest(AHitTest).GetSourceItem.SelectComponent(Shift);
  end;
end;

procedure TdxCustomLayoutItem.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  ViewInfo.MouseDown(Button, Shift, X, Y);
  if Container.Customization or Container.IsDesigning then
    CustomizationMouseDown(Button, Shift, X, Y);
end;

procedure TdxCustomLayoutItem.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  ViewInfo.MouseMove(Shift, X, Y);
end;

procedure TdxCustomLayoutItem.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  ViewInfo.MouseUp(Button, Shift, X, Y);
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

procedure TdxCustomLayoutItem.ShowHint(var AHintInfo: THintInfo; out ACanShow: Boolean);
begin
  ViewInfo.ShowHint(AHintInfo, ACanShow);
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
  Result := IsDesigning or IsUserDefined;
end;

function TdxCustomLayoutItem.IsOwner(AOwner: TComponent): Boolean;
begin
  Result := Container = AOwner;
end;

procedure TdxCustomLayoutItem.SelectComponent(AShift: TShiftState = []);
begin
  Container.SelectComponent(Self, AShift);
end;

procedure TdxCustomLayoutItem.SelectParent;
begin
  if Parent = nil then
    Container.SelectComponent(Container)
  else
    Container.SelectComponent(Parent);
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
    Result := FContainer
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
      Container.BeginUpdate;
      Container.BeginPlaceControls;
      try
        Container.InternalCalculateRoot(False);
      finally
        Container.CancelPlaceControls;
        Container.CancelUpdate;
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
      Container.BeginUpdate;
      try
        BeforeCalculateViewInfo;
        AViewInfo.Calculate(AViewInfo.OriginalBounds);
        AfterCalculateViewInfo;
      finally
        Container.CancelUpdate;
      end;
      ApplyCalculatedChanges;

      Container.InvalidateRect(AViewInfo.Bounds, False);
      Container.PostBuildSelectionLayer;
    end;
  end;

  procedure LightLayoutChanged(AItem: TdxCustomLayoutItem);
  begin
    if AItem.ViewInfo <> nil then
      Container.InvalidateRect(AItem.ViewInfo.Bounds, False);
  end;

begin
  if IsDestroying or Container.IsLoading or Container.IsDestroying or Container.IsUpdateLocked or not Container.HandleAllocated then Exit;
  case AType of
    ictHard: Container.LayoutChanged(False);
    ictMedium: MediumLayoutChanged(Self);
    ictLight: LightLayoutChanged(Self);
    ictComplex: ComplexLayoutChanged(Self);
  end;
  DoChanged;
end;

procedure TdxCustomLayoutItem.ParentChanged(AType: TdxLayoutItemChangeType);
begin
  if Parent <> nil then
    Parent.Changed(AType)
  else
    Changed(AType);
end;

function TdxCustomLayoutItem.CanMoveTo(AParent: TdxCustomLayoutItem): Boolean;
begin
  Result := AParent <> Self;
end;

procedure TdxCustomLayoutItem.MakeVisible;
var
  R, AClientR: TRect;

  procedure MakeVisibleInOneDirection(AItemMin, AItemMax,
    AClientMin, AClientMax: Integer; AIsHorizontal: Boolean);
  var
    AOffset: Integer;

    procedure ChangeOffset(ADelta: Integer);
    begin
      Inc(AOffset, ADelta);
      Dec(AItemMin, ADelta);
      Dec(AItemMax, ADelta);
    end;

    procedure ApplyOffset;
    begin
      with FContainer do
        if AIsHorizontal then
          LeftPos := LeftPos + AOffset
        else
          TopPos := TopPos + AOffset;
    end;

  begin
    AOffset := 0;
    if AItemMax > AClientMax then
      ChangeOffset(AItemMax - AClientMax);
    if AItemMin < AClientMin then
      ChangeOffset(-(AClientMin - AItemMin));
    ApplyOffset;
  end;

  procedure MakeActuallyVisible(AItem: TdxCustomLayoutItem);
  begin
    if AItem.Parent <> nil then
    begin
      AItem.Parent.ItemIndex := AItem.Index;
      MakeActuallyVisible(AItem.Parent);
    end;
  end;

  function CanBeActuallyVisible(AItem: TdxCustomLayoutItem): Boolean;
  begin
    Result := AItem.Visible and (AItem.IsRoot or (AItem.Parent <> nil) and AItem.Parent.AllowShowChild(AItem) and CanBeActuallyVisible(AItem.Parent));
  end;

begin
  if not CanBeActuallyVisible(Self) then Exit;
  if not ActuallyVisible then
    MakeActuallyVisible(Self);
  R := ViewInfo.Bounds;
  AClientR := FContainer.ClientBounds;
  MakeVisibleInOneDirection(R.Left, R.Right, AClientR.Left, AClientR.Right, True);
  MakeVisibleInOneDirection(R.Top, R.Bottom, AClientR.Top, AClientR.Bottom, False);
end;

function TdxCustomLayoutItem.Move(AParent: TdxLayoutGroup; AIndex: Integer;
  APack: Boolean = False): Boolean;
var
  ASourceContainer, ADestinationContainer: TdxCustomLayoutControl;
begin
  Result := CanMoveTo(AParent) and (APack or (AParent <> Parent) or (Index <> AIndex));
  if not Result then Exit;
  ASourceContainer := Container;
  if AParent = nil then
    ADestinationContainer := ASourceContainer
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
  AContainer: TdxCustomLayoutControl;
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
    Result := FParent.CreateGroup;
    Result.Hidden := True;
    Result.LayoutDirection := ALayoutDirection;
    case ALayoutDirection of
      ldHorizontal: Result.AlignVert := AlignVert;
      ldVertical: Result.AlignHorz := AlignHorz;
    end;
    Result.Index := AIndex;

    Move(Result, 0);
  end;
end;

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
  FAlignVert := tavCenter;
  FCursor := crDefault;
end;

procedure TdxLayoutLabeledItemCaptionOptions.SetAlignVert(Value: TdxAlignmentVert);
begin
  if FAlignVert <> Value then
  begin
    FAlignVert := Value;
    Changed;
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

{ TdxLayoutItemCaptionOptions }

procedure TdxLayoutItemCaptionOptions.SetLayout(Value: TdxCaptionLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Changed;
  end;
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

{ TdxLayoutItem }

constructor TdxLayoutItem.Create(AOwner: TComponent);
begin
  inherited;
  FControlOptions := GetControlOptionsClass.Create(Self);
end;

destructor TdxLayoutItem.Destroy;
begin
  Control := nil;
  FControlOptions.Free;
  FreeAndNil(FCustomizeControlHelper);
  inherited;
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

procedure TdxLayoutItem.SetControlOptions(Value: TdxLayoutItemControlOptions);
begin
  FControlOptions.Assign(Value);
end;

procedure TdxLayoutItem.SetControl(Value: TControl);

  procedure CheckValue;
  var
    AItem: TdxLayoutItem;
  begin
    if Value <> nil then
    begin
      if Value = Container then
        raise EdxException.Create(sdxLayoutControlContainerCannotBeControl);
      AItem := FContainer.FindItem(Value);
      if AItem <> nil then
        raise EdxException.Create(Format(sdxLayoutControlControlIsUsed, [Value.Name, AItem.Name]))
    end;
  end;

  procedure UnprepareControl;

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
    if IsDesigning then
      with Control do
        ControlStyle := ControlStyle - [csNoDesignVisible];

    FreeAndNil(FCustomizeControlHelper);
    cxWindowProcController.Remove(FWindowProcObject);

    FreeAndNil(FControlAdapter);

    AParent := Container.Parent;
    if IsDesigning and not (csDestroying in Control.ComponentState) and GetAllowedParent(AParent) then
    begin
      Control.Parent := AParent;
      Control.Left := 0;
      Control.Top := GetFreeTopPos(AParent);
    end;
  end;

  procedure PrepareControl;
  begin
    Control.Enabled := Enabled;
    FWindowProcObject := cxWindowProcController.Add(Control, ControlWndProc);
    if IsDesigning then
      with FControl do
        ControlStyle := ControlStyle + [csNoDesignVisible];
    Control.Parent := Container;
    SaveOriginalControlSize;
    CreateControlAdapter;
    SaveOriginalControlSize;
    if HasWinControl and not WinControl.HandleAllocated then
      SaveControlSizeBeforeDestruction;

    if IsDesigning then
    begin
      FCustomizeControlHelper := TdxCustomizationControlHelper.Create(Control);
      (FCustomizeControlHelper as TdxCustomizationControlHelper).LayoutItem := Self;
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
  Result := not Container.IsCustomization and Container.OptionsItem.FocusControlOnItemCaptionClick and CanFocusControl;
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

function TdxLayoutItem.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := CanFocusControlOnCaptionClick and ViewInfo.CaptionViewInfo.CanDoCaptionClick(X, Y);
end;

function TdxLayoutItem.CanProcessAccel(out AItem: TdxCustomLayoutItem): Boolean;
begin
  Result := CanFocusControl;
  if Result then
    AItem := Self;
end;

procedure TdxLayoutItem.CustomizationChanged;
begin
end;

procedure TdxLayoutItem.ContainerChanged;

  procedure ResetControlParent;
  var
    ASavedControl: TControl;
  begin
    if Control.Parent <> Container then
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

procedure TdxLayoutItem.DoCaptionDown;
begin
  if CanFocusControlOnCaptionClick then
    SetControlFocus;
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

procedure TdxLayoutItem.DoInit;
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
//          3..4: Result := True;
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
//        3: Result := AItem.AlignHorz;
//        4: Result := AItem.AlignVert;
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

  {if IsCommonValue(3, ACommonValue) then
    AlignHorz := ACommonValue; - items lose client alignment}
  {if IsCommonValue(4, ACommonValue) then
    AlignVert := ACommonValue; - because some controls cannot be made client aligned }
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
      IsDesigning then
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
    Container.FIsPlacingControls := True;
    try
      Control.SetBounds(Control.Left, Control.Top, FOriginalControlSize.X, FOriginalControlSize.Y);
      FControlSizeChanged := False;
    finally
      Container.FIsPlacingControls := False;
    end;
  end;
end;

procedure TdxLayoutItem.CustomizationMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if IsDesignSelectorVisible and Container.Customization and HasControl and ViewInfo.PtInDesignSelectorRect(Point(X, Y)) then
    Container.SelectComponent(Control, Shift)
  else
    inherited CustomizationMouseDown(Button, Shift, X, Y);
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

class function TdxLayoutItem.GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass;
begin
  Result := TdxLayoutItemCaptionOptions;
end;

function TdxLayoutItem.GetControlOptionsClass: TdxLayoutItemControlOptionsClass;
begin
  Result := TdxLayoutItemControlOptions;
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
      WM_SETFOCUS:
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
        Container.ViewInfo.DoCalculateTabOrders;
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
  if HasWinControl and Container.HandleAllocated and CanAllocateHandle(WinControl) then
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
      Container.FIsPlacingControls := True;
      try
        Control.Visible := AValue;
        // to make the control invisible on showing
        if not AValue then
          Control.SetBounds(10000, 10000, FOriginalControlSize.X, FOriginalControlSize.Y)
        else
          Control.BoundsRect := ViewInfo.FControlViewInfo.ControlBounds;
      finally
        Container.FIsPlacingControls := False;
      end;
    end;
  end;

begin
  if HasControl then
     InternalSetControlVisibility(ActuallyVisible and ViewInfo.ActuallyVisible);
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

{ TdxLayoutGroup }

constructor TdxLayoutGroup.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TcxComponentList.Create(True);
  FItems.OnComponentListChanged := ItemListChanged;
  FVisibleItems := TcxComponentList.Create;
  FButtonOptions := TdxLayoutGroupButtonOptions.Create(Self);
  FLayoutDirection := ldVertical;
  FShowBorder := True;
  FUseIndent := True;
  FExpanded := True;
  FItemIndex := dxLayoutPseudoActiveItem;
end;

destructor TdxLayoutGroup.Destroy;
begin
  FreeAndNil(FButtonOptions);
  FreeAndNil(FVisibleItems);
  FreeAndNil(FItems);
  inherited;
end;

function TdxLayoutGroup.GetCount: Integer;
begin
  Result := FItems.Count;
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

procedure TdxLayoutGroup.SetButtonOptions(AValue: TdxLayoutGroupButtonOptions);
begin
  FButtonOptions.Assign(AValue);
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
end;

procedure TdxLayoutGroup.ExtractItem(AItem: TdxCustomLayoutItem);
begin
  if not (csDestroying in ComponentState) then
  begin
    FItems.Extract(AItem);
    AItem.FParent := nil;
    Changed;
  end;
end;

procedure TdxLayoutGroup.ItemListChanged(Sender: TObject; AComponent: TComponent; AAction: TcxComponentCollectionNotification);
begin
  Container.CustomizeFormUpdateList(Self);
end;

function TdxLayoutGroup.IsItemIndexStored: Boolean;
begin
  Result := (VisibleCount > 0) and (ItemIndex <> 0);
end;

function TdxLayoutGroup.IsChildActuallyVisible(AChild: TdxCustomLayoutItem): Boolean;
begin
  Result := ActuallyVisible and AllowDrawChild(AChild);
end;

function TdxLayoutGroup.GetChildLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  if LayoutLookAndFeelException and (Parent <> nil) then
    Result := Parent.GetChildLayoutLookAndFeel
  else
    Result := GetLayoutLookAndFeel;
end;

function TdxLayoutGroup.GetRealItemControlAreaAlignment: TdxLayoutItemControlAreaAlignment;
begin
  if FItemControlAreaAlignment = catDefault then
    Result := ViewInfo.Specific.GetDefaultItemControlAreaAlignment
  else
    Result := FItemControlAreaAlignment;

  if (Result = catAuto) and ((Parent = nil) or (Parent.GetRealItemControlAreaAlignment = catNone)) then
    Result := catOwn;
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

procedure TdxLayoutGroup.CustomizationChanged;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    Items[I].CustomizationChanged;
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
    Free;
  end;
end;

class function TdxLayoutGroup.GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass;
begin
  Result := TdxLayoutGroupCaptionOptions;
end;

function TdxLayoutGroup.IsLocked: Boolean;
begin
  Result := inherited IsLocked or (not IsDesigning and Locked and Container.Customization);
end;

class function TdxLayoutGroup.GetItemClassKind: Integer;
begin
  Result := 1;
end;

function TdxLayoutGroup.GetBaseName: string;
begin
  Result := inherited GetBaseName + 'Group';
end;

procedure TdxLayoutGroup.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  inherited;
  for I := 0 to Count - 1 do
    if Items[I].Owner = Root then
      Proc(Items[I]);
end;

function TdxLayoutGroup.GetShowCaption: Boolean;
begin
  Result := ShowBorder and inherited GetShowCaption;
end;

function TdxLayoutGroup.GetViewInfoClass: TdxCustomLayoutItemViewInfoClass;
begin
  Result := TdxCustomLayoutItemViewInfoClass(GetLayoutLookAndFeel.GetGroupViewInfoClass);
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

procedure TdxLayoutGroup.SetChildOrder(Child: TComponent; Order: Integer);
begin
  inherited;
  (Child as TdxCustomLayoutItem).Index := Order;
end;

procedure TdxLayoutGroup.SetParentComponent(Value: TComponent);
begin
//#DG
  if Value is TdxCustomLayoutControl and
    not TdxCustomLayoutControl(Value).Items.IsLoading and
    not (csAncestor in ComponentState) then
    TdxCustomLayoutControl(Value).SetRootGroup(Self)
  else
    inherited;
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
  if ViewInfo <> nil then
    ViewInfo.Specific.SetControlVisibility;
  for I := 0 to Count - 1 do
    Items[I].ApplyCalculatedChanges;
  inherited;
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

procedure TdxLayoutGroup.BuildVisibleItemsList;
var
  I: Integer;
begin
  FVisibleItems.Clear;
  for I := 0 to Count - 1 do
    if Items[I].GetVisible then
      FVisibleItems.Add(Items[I]);

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

function TdxLayoutGroup.AllowDrawChild(AChild: TdxCustomLayoutItem): Boolean;
begin
  Result := AllowShowChild(AChild) and ((ViewInfo = nil) or ViewInfo.Specific.AllowDrawChild(AChild)) and IsExpanded;
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
  Result := CreateGroup;
  Result.Hidden := True;
  Result.Caption := cxGetResourceString(@sdxLayoutControlNewHiddenGroup);
  Result.LayoutDirection := LayoutDirection;
  for I := Count - 2 downto 0 do
    Items[I].Move(Result, 0);
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

{ TdxLayoutAlignmentConstraint }

constructor TdxLayoutAlignmentConstraint.Create(AOwner: TComponent);
begin
  inherited;
  CreateItems;
end;

destructor TdxLayoutAlignmentConstraint.Destroy;
begin
  DestroyItems;
  if FControl <> nil then
    FControl.RemoveAlignmentConstraint(Self);
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
begin
  inherited;
  if Value is TdxCustomLayoutControl then
    TdxCustomLayoutControl(Value).AddAlignmentConstraint(Self);
end;

procedure TdxLayoutAlignmentConstraint.BeginUpdate;
begin
  FControl.BeginUpdate;
end;

function TdxLayoutAlignmentConstraint.CanAddItem(AItem: TdxCustomLayoutItem): Boolean;
begin
  Result := (AItem <> nil) and (AItem.Container = Control);
end;

procedure TdxLayoutAlignmentConstraint.Changed;
begin
  FControl.LayoutChanged;
end;

procedure TdxLayoutAlignmentConstraint.EndUpdate;
begin
  FControl.EndUpdate;
end;

function TdxLayoutAlignmentConstraint.GetParentComponent: TComponent;
begin
  Result := FControl;
end;

function TdxLayoutAlignmentConstraint.HasParent: Boolean;
begin
  Result := FControl <> nil;
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

{ TdxLayoutControlPersistent }

constructor TdxLayoutControlPersistent.Create(AControl: TdxCustomLayoutControl);
begin
  inherited Create;
  FControl := AControl;
end;

procedure TdxLayoutControlPersistent.Changed;
begin
end;

function TdxLayoutControlPersistent.GetOwner: TPersistent;
begin
  Result := FControl;
end;

{ TdxLayoutImageOptions }

constructor TdxLayoutImageOptions.Create(AControl: TdxCustomLayoutControl);
begin
  inherited Create(AControl);
  FNotifyComponent := TcxFreeNotificator.Create(nil);
  FNotifyComponent.OnFreeNotification := FreeNotification;

  FDisabledImagesChangeLink := TChangeLink.Create;
  FDisabledImagesChangeLink.OnChange := DisabledImagesChange;
  FImagesChangeLink := TChangeLink.Create;
  FImagesChangeLink.OnChange := ImagesChange;
end;

destructor TdxLayoutImageOptions.Destroy;
begin
  FreeAndNil(FImagesChangeLink);
  FreeAndNIl(FDisabledImagesChangeLink);

  FreeAndNil(FNotifyComponent);
  inherited Destroy;
end;

procedure TdxLayoutImageOptions.Assign(Source: TPersistent);
begin
  if Source is TdxLayoutImageOptions then
    with Source as TdxLayoutImageOptions do
    begin
      Self.BeginUpdate;
      try
        Self.DisabledImages := DisabledImages;
        Self.Images := Images;
      finally
        Self.EndUpdate;
      end;
    end
  else
    inherited Assign(Source);
end;

procedure TdxLayoutImageOptions.Changed;
begin
  Control.LayoutChanged(False);
end;

procedure TdxLayoutImageOptions.BeginUpdate;
begin
  Control.BeginUpdate;
end;

procedure TdxLayoutImageOptions.EndUpdate;
begin
  Control.CancelUpdate;
  Changed;
end;

procedure TdxLayoutImageOptions.SetImages(AValue: TCustomImageList);
begin
  SetImageList(AValue, FImages, FImagesChangeLink);
end;

procedure TdxLayoutImageOptions.SetDisabledImages(AValue: TCustomImageList);
begin
  SetImageList(AValue, FDisabledImages, FDisabledImagesChangeLink);
end;

procedure TdxLayoutImageOptions.DisabledImagesChange(Sender: TObject);
begin
  Changed;
end;

procedure TdxLayoutImageOptions.ImagesChange(Sender: TObject);
begin
  Changed;
end;

procedure TdxLayoutImageOptions.SetImageList(var ANewValue, AOldValue: TCustomImageList; const AChangeLink: TChangeLink);
begin
  cxSetImageList(ANewValue, AOldValue, AChangeLink, FNotifyComponent);
end;

procedure TdxLayoutImageOptions.FreeNotification(AComponent: TComponent);
begin
  if AComponent = DisabledImages then DisabledImages := nil;
  if AComponent = Images then Images := nil;
end;

{ TdxUndoRedoManager }

constructor TdxUndoRedoManager.Create(AControl: TdxCustomLayoutControl);
begin
  inherited Create(AControl);
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
      Control.InternalLoadFromCustomIniFile(AIni, True);
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
      Control.InternalSaveToCustomIniFile(FCurrentLayout);
    end;
    Inc(FLockCount);
    try
      Dec(FIndex);
      AIni := TMemIniFile(FUndoList[FIndex]);
      Control.InternalLoadFromCustomIniFile(AIni, True);
    finally
      Dec(FLockCount);
    end;
  end;
end;

procedure TdxUndoRedoManager.CancelLastUndo;
begin
  if IsLocked or Control.IsDesigning then
    Exit;
  Undo;
  FreeAndNil(FCurrentLayout);
  FUndoList.Delete(FUndoList.Count - 1);
end;

procedure TdxUndoRedoManager.SaveLayout;
var
  AIni: TMemIniFile;
begin
  if IsLocked or Control.IsDesigning then
    Exit;
  AIni := TMemIniFile.Create('');
  Control.InternalSaveToCustomIniFile(AIni);
  AddUndo(AIni);
end;

function TdxUndoRedoManager.IsLocked: Boolean;
begin
  Result := FLockCount > 0;
end;

procedure TdxUndoRedoManager.Clear;
begin
  FUndoList.Clear;
  FreeAndNil(FCurrentLayout);
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

{ TdxStoringOptions }

procedure TdxStoringOptions.Assign(Source: TPersistent);
var
  ASourceOptions: TdxStoringOptions;
begin
  if Source is TdxStoringOptions then
  begin
    ASourceOptions := TdxStoringOptions(Source);
    IniFileName := ASourceOptions.IniFileName;
    RegistryPath := ASourceOptions.RegistryPath;
    StoreToIniFile := ASourceOptions.StoreToIniFile;
    StoreToRegistry := ASourceOptions.StoreToRegistry;
  end
  else
    inherited;
end;

function TdxStoringOptions.CanStoreToIniFile: Boolean;
begin
  Result := StoreToIniFile and (IniFileName <> '');
end;

function TdxStoringOptions.CanStoreToRegistry: Boolean;
begin
  Result := StoreToRegistry and (RegistryPath <> '');
end;

function TdxStoringOptions.CanRestoreFromIniFile: Boolean;
begin
  Result := CanStoreToIniFile and FileExists(IniFileName);
end;

function TdxStoringOptions.CanRestoreFromRegistry: Boolean;
var
  ARegistry: TRegistry;
begin
  Result := CanStoreToRegistry;
  if Result then
  begin
    ARegistry := TRegistry.Create(KEY_ALL_ACCESS);
    try
      Result := ARegistry.OpenKey(RegistryPath, False);
      ARegistry.CloseKey;
    finally
      ARegistry.Free;
    end;
  end;
end;

{ TdxLayoutItemOptions }

constructor TdxLayoutItemOptions.Create(AControl: TdxCustomLayoutControl);
begin
  inherited;
  FAutoControlAreaAlignment := True;
  FAutoControlTabOrders := True;
end;

procedure TdxLayoutItemOptions.Assign(Source: TPersistent);
begin
  if Source is TdxLayoutItemOptions then
  begin
    Control.BeginUpdate;
    try
      AutoControlAreaAlignment := TdxLayoutItemOptions(Source).AutoControlAreaAlignment;
      AutoControlTabOrders := TdxLayoutItemOptions(Source).AutoControlTabOrders;
      FocusControlOnItemCaptionClick := TdxLayoutItemOptions(Source).FocusControlOnItemCaptionClick;
      SizableHorz := TdxLayoutItemOptions(Source).SizableHorz;
      SizableVert := TdxLayoutItemOptions(Source).SizableVert;
    finally
      Control.CancelUpdate;
      Changed;
    end;
  end
  else
    inherited;
end;

procedure TdxLayoutItemOptions.Changed;
begin
  Control.LayoutChanged;
end;

procedure TdxLayoutItemOptions.SetAutoControlAreaAlignment(Value: Boolean);
begin
  if FAutoControlAreaAlignment <> Value then
  begin
    FAutoControlAreaAlignment := Value;
    Changed;
  end;
end;

procedure TdxLayoutItemOptions.SetAutoControlTabOrders(Value: Boolean);
begin
  if FAutoControlTabOrders <> Value then
  begin
    FAutoControlTabOrders := Value;
    Changed;
  end;
end;

{ TdxCustomLayoutControl }

constructor TdxCustomLayoutControl.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls, csOpaque];
  ParentBackground := False;
{
  with cxLookAndFeel do
  begin
    Kind := lfStandard;
    NativeStyle := True;
  end;
}
  TabStop := False;
  Width := 300;
  Height := 250;
  FOptionsImage := TdxLayoutImageOptions.Create(Self);
  FAbsoluteItems := TcxComponentList.Create;
  FAvailableItems := TcxComponentList.Create;
  FAvailableItems.OnComponentListChanged := AvailableItemListChanged;
  FOptionsStoring := TdxStoringOptions.Create;
  FStoredStream := TMemoryStream.Create;
  FUndoRedoManager := TdxUndoRedoManager.Create(Self);
  FOptionsItem := TdxLayoutItemOptions.Create(Self);

  FHighlightRoot := True;
  FShowDesignSelectors := True;
  FBoldFont := TFont.Create;
  RefreshBoldFont;
  FCustomizeFormClass := TdxLayoutControlCustomizeForm;
  GetLayoutLookAndFeel.AddUser(Self);
  InitializeSubControlsCxLookAndFeel;
  CreateRootGroup;
  //FGroups.UseIndent := False;
  CreateConstraints;

  if IsDesigning then
    dxDesignCustomizationHelper.AddLayout(Self);
  FSelectionHelper := GetSelectionHelperClass.Create(Self);
  FSelectionHelper.AddSelectionChangedListener(Self);
  FCustomizeAvailableItemsViewKind := aivkTree;
end;

destructor TdxCustomLayoutControl.Destroy;
begin
  FSelectionHelper.RemoveSelectionChangedListener(Self);
  dxDesignCustomizationHelper.RemoveLayout(Self);
  Customization := False;
  FSelectionHelper := nil;
  if not IsDesigning then
    Store;
  DestroyRootGroup;
  LayoutLookAndFeel := nil;
  GetLayoutLookAndFeel.RemoveUser(Self);
  DestroyConstraints;
  dxLayoutTextMetrics.Unregister(FBoldFont);
  dxLayoutTextMetrics.Unregister(Font);
  FreeAndNil(FBoldFont);

  FreeAndNil(FOptionsItem);
  FreeAndNil(FUndoRedoManager);
  FreeAndNil(FStoredStream);
  FreeAndNil(FOptionsStoring);
  FAvailableItems.OwnsObjects := True;
  FreeAndNil(FAvailableItems);
  FreeAndNil(FAbsoluteItems);
  FreeAndNil(FOptionsImage);
  inherited;
end;

procedure TdxCustomLayoutControl.BeginDragAndDrop;
begin
  DragAndDropState := ddsInProcess;
  inherited;
end;

function TdxCustomLayoutControl.GetAutoControlAlignment: Boolean;
begin
  Result := OptionsItem.AutoControlAreaAlignment;
end;

function TdxCustomLayoutControl.GetAutoControlTabOrders: Boolean;
begin
  Result := OptionsItem.AutoControlTabOrders;
end;

function TdxCustomLayoutControl.GetAbsoluteItem(Index: Integer): TdxCustomLayoutItem;
begin
  Result := TdxCustomLayoutItem(FAbsoluteItems[Index]);
end;

function TdxCustomLayoutControl.GetAbsoluteItemCount: Integer;
begin
  Result := FAbsoluteItems.Count;
end;

function TdxCustomLayoutControl.GetAlignmentConstraint(Index: Integer): TdxLayoutAlignmentConstraint;
begin
  Result := FAlignmentConstraints[Index];
end;

function TdxCustomLayoutControl.GetAlignmentConstraintCount: Integer;
begin
  Result := FAlignmentConstraints.Count;
end;

function TdxCustomLayoutControl.GetAllowDrop: Boolean;
begin
  Result := IsDesigning;
end;

function TdxCustomLayoutControl.GetAvailableItem(Index: Integer): TdxCustomLayoutItem;
begin
  Result := TdxCustomLayoutItem(FAvailableItems[Index]);
end;

function TdxCustomLayoutControl.GetAvailableItemCount: Integer;
begin
  Result := FAvailableItems.Count;
end;

function TdxCustomLayoutControl.GetContentBounds: TRect;
begin
  Result := ViewInfo.ContentBounds;
end;

function TdxCustomLayoutControl.GetIsLayoutLoading: Boolean;
begin
  Result := FLoadingCount > 0;
end;

function TdxCustomLayoutControl.GetOccupiedClientWidth: Integer;
begin
  Result := ViewInfo.ItemsViewInfo.CalculateWidth;
end;

function TdxCustomLayoutControl.GetOccupiedClientHeight: Integer;
begin
  Result := ViewInfo.ItemsViewInfo.CalculateHeight;
end;

function TdxCustomLayoutControl.GetLayoutDirection: TdxLayoutDirection;
begin
  Result := FRootGroup.LayoutDirection;
end;

function TdxCustomLayoutControl.GetAutoContentSizes: TdxLayoutAutoContentSizes;
begin
  Result := TdxLayoutAutoContentSizes(FRootGroup.AutoAligns);
end;

procedure TdxCustomLayoutControl.SetAutoContentSizes(Value: TdxLayoutAutoContentSizes);
begin
  FRootGroup.AutoAligns := TdxLayoutAutoAligns(Value);
end;

procedure TdxCustomLayoutControl.SetAutoControlAlignment(Value: Boolean);
begin
  OptionsItem.AutoControlAreaAlignment := Value;
end;

procedure TdxCustomLayoutControl.SetAutoControlTabOrders(Value: Boolean);
begin
  OptionsItem.AutoControlTabOrders := Value;
end;

procedure TdxCustomLayoutControl.SetCustomization(Value: Boolean);
var
  AParentForm: TCustomForm;
begin
  if (FCustomization <> Value) and (not Value or CanAllocateHandle(Self)) then
  begin
    if Value then
    begin
      if not IsDestroying and not IsDesigning and IsChildWindow(Self, GetFocus) then
      begin
        AParentForm := GetParentForm(Self);
        if (AParentForm <> nil) and Visible then
          AParentForm.ActiveControl := Self;
      end;
      FCustomizeForm := CustomizeFormClass.Create(nil);
      FCustomizeForm.Control := Self;
      FCustomization := True;
      FCustomizeForm.Show;
    end
    else
    begin
      FCustomization := False;
      with FCustomizeForm do
        if not (csDestroying in ComponentState) then
          Free;
      if not IsDesigning then
        FSelectionHelper.ClearSelection;
      if not IsDesigning then
        FSelectionHelper.ClearSelection;
    end;
    DoCustomization;
  end
  else
    if FCustomization and HandleAllocated then
      FCustomizeForm.BringToFront;
end;

procedure TdxCustomLayoutControl.SetCustomizeAvailableItemsViewKind(Value: TdxLayoutAvailableItemsViewKind);
begin
  if FCustomizeAvailableItemsViewKind <> Value then
  begin
    FCustomizeAvailableItemsViewKind := Value;
    CustomizeFormPostUpdate([cfutAvailableItems, cfutSelection, cfutView]);
  end;
end;

procedure TdxCustomLayoutControl.SetCustomizeFormTabbedView(Value: Boolean);
begin
  if FCustomizeFormTabbedView <> Value then
  begin
    FCustomizeFormTabbedView := Value;
    CustomizeFormPostUpdate([cfutView]);
    Modified;
  end;
end;

procedure TdxCustomLayoutControl.SetShowDesignSelectors(Value: Boolean);
begin
  if FShowDesignSelectors <> Value then
  begin
    FShowDesignSelectors := Value;
    InvalidateWithChildren;
    CustomizeFormPostUpdate([cfutView]);
    Modified;
  end;
end;

procedure TdxCustomLayoutControl.SetHighlightRoot(Value: Boolean);
begin
  if FHighlightRoot <> Value then
  begin
    FHighlightRoot := Value;
    LayoutChanged(False, False);
    CustomizeFormPostUpdate([cfutView]);
    Modified;
  end;
end;

procedure TdxCustomLayoutControl.SetOptionsImage(Value: TdxLayoutImageOptions);
begin
  FOptionsImage.Assign(Value);
end;

procedure TdxCustomLayoutControl.SetOptionsItem(Value: TdxLayoutItemOptions);
begin
  FOptionsItem.Assign(Value);
end;

procedure TdxCustomLayoutControl.SetRootGroup(Value: TdxLayoutGroup);
begin
  ItemWithMouse := nil;
  DestroyHandlers;
  if Value <> nil then
  begin
    if FRootGroup <> nil then
    begin
      Value.FAlignHorz := FRootGroup.AlignHorz;
      Value.FAlignVert := FRootGroup.AlignVert;
    end
    else
    begin
      Value.FAlignHorz := ahLeft;
      Value.FAlignVert := avTop;
    end;
  end;
  if FRootGroup <> nil then
    FreeAndNil(FRootGroup);
  FRootGroup := Value;
  if Value <> nil then
  begin
    FRootGroup.FreeNotification(Self);
    FRootGroup.Container := Self;
    CreateHandlers;
    FRootGroup.Hidden := True;
  end;
end;

procedure TdxCustomLayoutControl.SetItemWithMouse(Value: TdxCustomLayoutItem);
begin
  if FItemWithMouse <> Value then
  begin
    if FItemWithMouse <> nil then
      FItemWithMouse.MouseLeave;
    FItemWithMouse := Value;
    if FItemWithMouse <> nil then
      FItemWithMouse.MouseEnter;
  end;
end;

procedure TdxCustomLayoutControl.SetLayoutDirection(Value: TdxLayoutDirection);
begin
  FRootGroup.LayoutDirection := Value;
end;

procedure TdxCustomLayoutControl.SetLeftPos(Value: Integer);
var
  APrevLeftPos: Integer;
begin
  CheckLeftPos(Value);
  if FLeftPos <> Value then
  begin
    Update;
    APrevLeftPos := FLeftPos;
    FLeftPos := Value;
    LayoutChanged(False, False);
    ScrollContent(APrevLeftPos, FLeftPos, True);
  end;
end;

procedure TdxCustomLayoutControl.SetLayoutLookAndFeel(Value: TdxCustomLayoutLookAndFeel);
begin
  if FLayoutLookAndFeel <> Value then
  begin
    GetLayoutLookAndFeel.RemoveUser(Self);
    FLayoutLookAndFeel := Value;
    GetLayoutLookAndFeel.AddUser(Self);
    LayoutLookAndFeelUserChanged;
  end;
end;

procedure TdxCustomLayoutControl.SetShowHiddenGroupsBounds(Value: Boolean);
begin
  if FShowHiddenGroupsBounds <> Value then
  begin
    FShowHiddenGroupsBounds := Value;
    LayoutChanged;
  end;
end;

procedure TdxCustomLayoutControl.SetTopPos(Value: Integer);
var
  APrevTopPos: Integer;
begin
  CheckTopPos(Value);
  if FTopPos <> Value then
  begin
    Update;
    APrevTopPos := FTopPos;
    FTopPos := Value;
    LayoutChanged(False, False);
    ScrollContent(APrevTopPos, FTopPos, False);
  end;
end;


function TdxCustomLayoutControl.GetIniFileName: string;
begin
  Result := OptionsStoring.IniFileName;
end;

function TdxCustomLayoutControl.GetRegistryPath: string;
begin
  Result := OptionsStoring.RegistryPath;
end;

function TdxCustomLayoutControl.GetStoreInIniFile: Boolean;
begin
  Result := OptionsStoring.StoreToIniFile;
end;

function TdxCustomLayoutControl.GetStoreInRegistry: Boolean;
begin
  Result := OptionsStoring.StoreToRegistry;
end;

procedure TdxCustomLayoutControl.SetIniFileName(const Value: string);
begin
  OptionsStoring.IniFileName := Value;
end;

procedure TdxCustomLayoutControl.SetRegistryPath(const Value: string);
begin
  OptionsStoring.RegistryPath := Value;
end;

procedure TdxCustomLayoutControl.SetStoreInIniFile(const Value: Boolean);
begin
  OptionsStoring.StoreToIniFile := Value;
end;

procedure TdxCustomLayoutControl.SetStoreInRegistry(const Value: Boolean);
begin
  OptionsStoring.StoreToRegistry := Value;
end;

procedure TdxCustomLayoutControl.SetOptionsStoring(Value: TdxStoringOptions);
begin
  FOptionsStoring.Assign(Value);
end;

procedure TdxCustomLayoutControl.CreateHandlers;
begin
  FPainter := GetPainterClass.Create(Self);
  FViewInfo := GetViewInfoClass.Create(Self);
end;

procedure TdxCustomLayoutControl.DestroyHandlers;
begin
  FreeAndNil(FViewInfo);
  FreeAndNil(FPainter);
end;

procedure TdxCustomLayoutControl.CreateConstraints;
begin
  FAlignmentConstraints := TList.Create;
end;

procedure TdxCustomLayoutControl.DestroyConstraints;
var
  I: Integer;
begin
  for I := AlignmentConstraintCount - 1 downto 0 do
    AlignmentConstraints[I].Free;
  FreeAndNil(FAlignmentConstraints);
end;

procedure TdxCustomLayoutControl.AddAlignmentConstraint(AConstraint: TdxLayoutAlignmentConstraint);
begin
  FAlignmentConstraints.Add(AConstraint);
  AConstraint.FControl := Self;
  SetComponentName(AConstraint, Name + 'AlignmentConstraint', IsDesigning, IsLoading);
end;

procedure TdxCustomLayoutControl.RemoveAlignmentConstraint(AConstraint: TdxLayoutAlignmentConstraint);
begin
  FAlignmentConstraints.Remove(AConstraint);
  AConstraint.FControl := nil;
end;

procedure TdxCustomLayoutControl.RefreshBoldFont;
begin
  FBoldFont.Assign(Font);
  with FBoldFont do
    Style := Style + [fsBold];
  dxLayoutTextMetrics.Unregister(FBoldFont);
end;

procedure TdxCustomLayoutControl.InitializeSubControlsCxLookAndFeel;
begin
  GetLayoutLookAndFeel.InitializeSubControlCxLookAndFeel(HScrollBar.LookAndFeel);
  GetLayoutLookAndFeel.InitializeSubControlCxLookAndFeel(VScrollBar.LookAndFeel);
  GetLayoutLookAndFeel.InitializeSubControlCxLookAndFeel(SizeGrip.LookAndFeel);
end;

procedure TdxCustomLayoutControl.PlaceControls(AItemViewInfo: TdxCustomLayoutItemViewInfo);
begin
  if FPlaceControlsLockCount > 0 then
    FIsPlaceControlsNeeded := True
  else
  begin
    if AItemViewInfo <> nil then
      Painter.PlaceControls(AItemViewInfo)
    else
      if IsDesigning then
        PostMessage(Handle, DXM_LAYOUT_PLACECONTROLS, 0, 0)
      else
        Painter.PlaceControls(ViewInfo.ItemsViewInfo);
  end;
end;

procedure TdxCustomLayoutControl.BeginPlaceControls;
begin
  Inc(FPlaceControlsLockCount);
end;

procedure TdxCustomLayoutControl.CancelPlaceControls;
begin
  Dec(FPlaceControlsLockCount);
  FIsPlaceControlsNeeded := False;
end;

procedure TdxCustomLayoutControl.EndPlaceControls;
begin
  Dec(FPlaceControlsLockCount);
  if (FPlaceControlsLockCount = 0) and FIsPlaceControlsNeeded then
    PlaceControls;
end;

procedure TdxCustomLayoutControl.AddAbsoluteItem(AItem: TdxCustomLayoutItem);
begin
  FAbsoluteItems.Add(AItem);
end;

procedure TdxCustomLayoutControl.ExtractAbsoluteItem(AItem: TdxCustomLayoutItem);
begin
  FAbsoluteItems.Extract(AItem);
end;

procedure TdxCustomLayoutControl.AddAvailableItem(AItem: TdxCustomLayoutItem);
begin
  FAvailableItems.Add(AItem);
  AItem.Container := Self;
end;

procedure TdxCustomLayoutControl.ExtractAvailableItem(AItem: TdxCustomLayoutItem);
begin
  FAvailableItems.Extract(AItem);
end;

procedure TdxCustomLayoutControl.WMContextMenu(var Message: TWMContextMenu);
begin
  FIsPopupShown := True;
  try
    inherited;
  finally
    FIsPopupShown := False;
  end;
end;

procedure TdxCustomLayoutControl.CMControlChange(var Message: TCMControlChange);
var
  AControl: TControl;
  P: TPoint;
  AGroup: TdxLayoutGroup;
  AIndex: Integer;
begin
  inherited;
  AControl := Message.Control;
  if not (IsLoading or IsDestroying) and Message.Inserting and not IsInternalControl(AControl) and
    not (csAncestor in AControl.ComponentState) and (FindItem(AControl) = nil) then
  begin
    P := AControl.BoundsRect.TopLeft;
    AGroup := ViewInfo.GetHitTest(P).GetGroupForInsert;
    if AGroup = nil then
      AGroup := Items;
    AIndex := AGroup.ViewInfo.GetInsertionPos(P);
    AGroup.CreateItemForControl(AControl).VisibleIndex := AIndex;
  end;
end;

procedure TdxCustomLayoutControl.CMControlListChange(var Message: TCMControlListChange);
var
  AControl: TControl;
  AItem: TdxLayoutItem;
begin
  inherited;
  AControl := Message.Control;
  if not IsInternalControl(AControl) and not Message.Inserting then
  begin
    AItem := FindItem(AControl);
    if (AItem <> nil) and not AItem.FControlLocked then
      AItem.Free;
  end;
end;

procedure TdxCustomLayoutControl.CMDialogChar(var Message: TCMDialogChar);
begin
  if FRootGroup.ProcessDialogChar(Message.CharCode) then
    Message.Result := 1
  else
    inherited;
end;

procedure TdxCustomLayoutControl.CMDialogKey(var Message: TCMDialogKey);

  function FindFocusedItem: TdxLayoutItem;
  var
    AWnd: THandle;
  begin
    AWnd := GetFocus;
    repeat
      Result := FindItem(AWnd);
      AWnd := GetAncestor(AWnd, GA_PARENT);
    until (Result <> nil) or (AWnd = 0);
  end;

var
  AFocusedItem: TdxLayoutItem;
begin
  AFocusedItem := FindFocusedItem;
  if (AFocusedItem <> nil) and FRootGroup.ProcessDialogKey(Message.CharCode, Message.KeyData, AFocusedItem) then
    Message.Result := 1
  else
    inherited;
end;

procedure TdxCustomLayoutControl.CMHintShow(var Message: TCMHintShow);
const
  AResultMap: array[Boolean] of Integer = (1, 0);
var
  P: TPoint;
  ACanShow: Boolean;
begin
  P := ScreenToClient(GetMouseCursorPos);
  AssignItemWithMouse(P.X, P.Y);
  if (ItemWithMouse <> nil) and not IsCustomization then
  begin
    ItemWithMouse.ShowHint(Message.HintInfo^, ACanShow);
    Message.Result := AResultMap[ACanShow];
  end
  else
    inherited;
end;

procedure TdxCustomLayoutControl.DXMPlaceControls(var Message: TMessage);
begin
  Painter.PlaceControls(ViewInfo.ItemsViewInfo);
end;

procedure TdxCustomLayoutControl.DXMBuildSelectionLayer(var Message: TMessage);
begin
  if not IsUpdateLocked and (ViewInfo <> nil) then
    ViewInfo.BuildSelectionLayer;
end;

procedure TdxCustomLayoutControl.DXMInvalidateSelectionLayer(var Message: TMessage);
var
  R: TRect;
begin
  with Message do
    R := Rect(WParamLo, WParamHi, LParamLo, LParamHi);
  InvalidateSelectionLayer(R);
end;

procedure TdxCustomLayoutControl.DXMCustomizeFormUpdate(var Message: TMessage);
var
  AMSG: TMsg;
  AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes;
begin
  AUpdateTypes := TdxLayoutCustomizeFormUpdateTypes(Byte(Message.WParam));
  while PeekMessage(AMsg, Handle, DXM_REFRESHCUSTOMIZATION, DXM_REFRESHCUSTOMIZATION, PM_REMOVE) do
    AUpdateTypes := AUpdateTypes + TdxLayoutCustomizeFormUpdateTypes(Byte(AMsg.wParam));
  CustomizeFormUpdate(AUpdateTypes);
end;

function TdxCustomLayoutControl.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  if IsDesigning then
    Result := False
  else
  begin
    Result := True;
    if (ViewInfo.ItemsViewInfo.AlignHorz <> ahClient) and (Align in [alNone, alLeft, alRight]) then
      NewWidth := cxRectWidth(ContentBounds);
    if (ViewInfo.ItemsViewInfo.AlignVert <> avClient) and (Align in [alNone, alTop, alBottom]) then
      NewHeight := cxRectHeight(ContentBounds);
  end;
end;

procedure TdxCustomLayoutControl.AlignControls(AControl: TControl; var Rect: TRect);
begin
end;

function TdxCustomLayoutControl.AllowAutoDragAndDropAtDesignTime(X, Y: Integer;
  Shift: TShiftState): Boolean;
begin
  Result := not GetDesignHitTest(X, Y, Shift);
end;

function TdxCustomLayoutControl.AllowDragAndDropWithoutFocus: Boolean;
begin
  Result := FCustomization;
end;

procedure TdxCustomLayoutControl.BoundsChanged;
begin
  if IsDestroying then
    Exit;
  BeginUpdate;
  try
    inherited;
  finally
    EndUpdate(False);
  end;
end;

function TdxCustomLayoutControl.CanDrag(X, Y: Integer): Boolean;
begin
  Result := inherited CanDrag(X, Y) and not IsDesigning;
end;

function TdxCustomLayoutControl.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := inherited CanFocusOnClick(X, Y) and not IsCustomization;
  if ItemWithMouse <> nil then
    Result := Result and not ItemWithMouse.CanFocusOnClick(X, Y);
end;

procedure TdxCustomLayoutControl.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TdxCustomLayoutControl.DblClick;
begin
  inherited;
  if IsDesigning then
    Customization := True;
end;

procedure TdxCustomLayoutControl.FontChanged;
begin
  inherited;
  dxLayoutTextMetrics.Unregister(Font);
  RefreshBoldFont;
  LayoutLookAndFeelUserChanged;
end;

procedure TdxCustomLayoutControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  inherited;
  if Owner = Root then
  begin
    Proc(FRootGroup);
    for I := 0 to AvailableItemCount - 1 do
      Proc(AvailableItems[I]);
    for I := 0 to AlignmentConstraintCount - 1 do
      Proc(AlignmentConstraints[I]);
  end;
end;

function TdxCustomLayoutControl.GetCursor(X, Y: Integer): TCursor;
var
  AHitTest: TdxCustomLayoutHitTest;
begin
  Result := crDefault;
  if DragAndDropState = ddsNone then
  begin
    AHitTest := ViewInfo.GetHitTest(X, Y);
    Result := AHitTest.GetCursor;
    if (Result = crDefault) and (AHitTest.HitItem <> nil) then
      Result := AHitTest.HitItem.GetCursor(X, Y);
    if Result = crDefault then
      Result := inherited GetCursor(X, Y);
  end;
end;

function TdxCustomLayoutControl.DoShowPopupMenu(AMenu: TComponent; X, Y: Integer): Boolean;
var
  APopupMenu: TPopupMenu;
begin
  if Customization then
  begin
    APopupMenu := CustomizeForm.GetLayoutPopupMenu;
    Result := (APopupMenu <> nil) and ShowPopupMenu(Self, APopupMenu, X, Y);
  end
  else
    Result := inherited DoShowPopupMenu(AMenu, X, Y);
end;

function TdxCustomLayoutControl.GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean;

  function IsGrabHandle(AHandle: THandle): Boolean;
  const
    GrabHandleClassName = 'TGrabHandle';
  begin
    Result := cxGetClassName(AHandle) = GrabHandleClassName;
  end;

var
  AHitTest: TdxCustomLayoutHitTest;
begin
  Result := inherited GetDesignHitTest(X, Y, Shift);
  if not Result then
  begin
    AHitTest := ViewInfo.GetHitTest(X, Y);
    Result := not (ssRight in Shift) and not FRightButtonPressed and
      (AHitTest is TdxCustomLayoutItemHitTest) and
      not IsToolSelected and not IsGrabHandle(cxWindowFromPoint(ClientToScreen(Point(X, Y))));
  end;
  FRightButtonPressed := ssRight in Shift;
end;

function TdxCustomLayoutControl.HasBackground: Boolean;
begin
  Result := ThemeServices.ThemesEnabled and ParentBackground;
end;

function TdxCustomLayoutControl.IsInternalControl(AControl: TControl): Boolean;
begin
  Result := inherited IsInternalControl(AControl) or (AControl is TdxLayoutTabbedGroupTabControl) or
    (AControl is TdxSelectionLayer);
end;

function TdxCustomLayoutControl.NeedRedrawOnResize: Boolean;
begin
  Result := ViewInfo.LayoutLookAndFeel.NeedRedrawOnResize;
end;

procedure TdxCustomLayoutControl.Loaded;
begin
  inherited;
  if not IsDesigning then
    Restore;
  LayoutChanged(False);
  LayoutLookAndFeelUserChanged;
end;

procedure TdxCustomLayoutControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FRootGroup) then
  begin
    FRootGroup := nil;
    if not IsDestroying then
      CreateRootGroup;
  end;
end;

procedure TdxCustomLayoutControl.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  AssignItemWithMouse(X, Y);
  inherited;
  if ItemWithMouse <> nil then
    ItemWithMouse.MouseDown(Button, Shift, X, Y);
end;

procedure TdxCustomLayoutControl.MouseLeave(AControl: TControl);
begin
  inherited;
  ItemWithMouse := nil;
end;

procedure TdxCustomLayoutControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  AssignItemWithMouse(X, Y);
  if ItemWithMouse <> nil then
    ItemWithMouse.MouseMove(Shift, X, Y);
  inherited;
end;

procedure TdxCustomLayoutControl.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  AssignItemWithMouse(X, Y);
  if ItemWithMouse <> nil then
    ItemWithMouse.MouseUp(Button, Shift, X, Y);
end;

procedure TdxCustomLayoutControl.Paint;
begin
  if not IsUpdateLocked then
  begin
    inherited;
    Painter.Paint;
  end;
end;

procedure TdxCustomLayoutControl.SetName(const Value: TComponentName);

  function GetItem(ACaller: TComponent; Index: Integer): TComponent;
  begin
    if Index = 0 then
      Result := TdxCustomLayoutControl(ACaller).Items
    else
      Result := TdxCustomLayoutControl(ACaller).AbsoluteItems[Index - 1];
  end;

  function GetAlignmentConstraint(ACaller: TComponent; Index: Integer): TComponent;
  begin
    Result := TdxCustomLayoutControl(ACaller).AlignmentConstraints[Index];
  end;

var
  AOldName: string;
begin
  AOldName := Name;
  inherited;
  RenameComponents(Self, Owner, Name, AOldName, 1 + AbsoluteItemCount, @GetItem);
  RenameComponents(Self, Owner, Name, AOldName,  AlignmentConstraintCount, @GetAlignmentConstraint);
  CustomizeFormPostUpdate([cfutCaption]);
end;

procedure TdxCustomLayoutControl.SetParentBackground(Value: Boolean);
begin
  if Value then
    ControlStyle := ControlStyle - [csOpaque]
  else
    ControlStyle := ControlStyle + [csOpaque];
  inherited;
end;

procedure TdxCustomLayoutControl.WriteState(Writer: TWriter);
begin
  if HandleAllocated then
    SendMessage(Handle, WM_SETREDRAW, 0, 0);
  try
    Items.RestoreItemControlSize;
    inherited;
  finally
    if HandleAllocated then
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
    LayoutChanged;
  end;
end;

procedure TdxCustomLayoutControl.WndProc(var Message: TMessage);

  function PtInDesignSelectorRect(const P: TPoint): Boolean;
  var
    AControl: TControl;
    AHitTest: TdxCustomLayoutHitTest;
  begin
    Result := False;
    AControl := ControlAtPos(P, True);
    if (AControl <> nil) and not (AControl is TWinControl) then
    begin
      AHitTest := ViewInfo.GetHitTest(P);
      Result := (AHitTest <> nil) and
        (AHitTest is TdxLayoutItemHitTest) and
        (AHitTest as TdxLayoutItemHitTest).HitItem.ViewInfo.PtInDesignSelectorRect(P);
    end;
  end;

begin
  if (IsDesigning or Customization) and HandleAllocated then
    case Message.Msg of
      WM_LBUTTONDOWN:
        if (GetCapture <> Handle) and (Customization or PtInDesignSelectorRect(SmallPointToPoint(TWMMouse(Message).Pos))) then
          SetCaptureControl(Self);
    end;
  inherited WndProc(Message);
end;

procedure TdxCustomLayoutControl.InitScrollBarsParameters;
begin
  inherited;
  SetScrollBarInfo(sbHorizontal, 0, ViewInfo.ContentWidth - 1,
    ScrollStep, ViewInfo.ClientWidth, LeftPos, True, True);
  SetScrollBarInfo(sbVertical, 0, ViewInfo.ContentHeight - 1,
    ScrollStep, ViewInfo.ClientHeight, TopPos, True, True);
end;

function TdxCustomLayoutControl.NeedsToBringInternalControlsToFront: Boolean;
begin
  Result := True;
end;

procedure TdxCustomLayoutControl.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);

  function GetContentPos: Integer;
  begin
    if AScrollBarKind = sbHorizontal then
      Result := LeftPos
    else
      Result := TopPos;
  end;

  procedure SetContentPos(Value: Integer);
  begin
    if AScrollBarKind = sbHorizontal then
      LeftPos := Value
    else
      TopPos := Value;
  end;

  function GetPageScrollStep: Integer;
  begin
    if AScrollBarKind = sbHorizontal then
      Result := ClientWidth
    else
      Result := ClientHeight;
  end;

begin
  inherited;
  case AScrollCode of
    scLineUp:
      SetContentPos(GetContentPos - ScrollStep);
    scLineDown:
      SetContentPos(GetContentPos + ScrollStep);
    scPageUp:
      SetContentPos(GetContentPos - GetPageScrollStep);
    scPageDown:
      SetContentPos(GetContentPos + GetPageScrollStep);
    scTrack:
      SetContentPos(AScrollPos);
  end;
  AScrollPos := GetContentPos;
end;

function TdxCustomLayoutControl.CanDragAndDrop: Boolean;
begin
  Result := not IsDesigning or not (csInline in Owner.ComponentState);
end;

function TdxCustomLayoutControl.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  if FDragDropHitTest <> nil then
    Result := FDragDropHitTest.GetDragAndDropObjectClass
  else
    Result := TdxLayoutDragAndDropObject;
end;

function TdxCustomLayoutControl.StartDragAndDrop(const P: TPoint): Boolean;
var
  AItem: TdxCustomLayoutItem;
  AHitTest: TdxCustomLayoutHitTest;
begin
  Result := False;
  AHitTest := ViewInfo.GetHitTest(P);
  AItem := AHitTest.GetSourceItem;
  if CanDragAndDrop and AHitTest.CanDragAndDrop and (AItem <> nil) and AItem.CanDragAndDrop then
  begin
    FDragDropHitTest := AHitTest;
    (DragAndDropObject as TdxLayoutCustomDragAndDropObject).Init(dsControl, AItem, P);
    Result := True;
  end;
end;

procedure TdxCustomLayoutControl.EndDragAndDrop(Accepted: Boolean);
begin
  FDragDropHitTest := nil;
  inherited;
end;

function TdxCustomLayoutControl.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := FLayoutLookAndFeel;
  if Result = nil then
    Result := dxLayoutDefaultLookAndFeel;
end;

function TdxCustomLayoutControl.GetCxLookAndFeel: TcxLookAndFeel;
begin
  Result := inherited LookAndFeel;
end;

procedure TdxCustomLayoutControl.BeginLayoutLookAndFeelUserDestroying;
begin
  BeginUpdate;
end;

procedure TdxCustomLayoutControl.EndLayoutLookAndFeelUserDestroying;
begin
  EndUpdate;
end;

procedure TdxCustomLayoutControl.LayoutLookAndFeelUserChanged;
begin
  if (LayoutLookAndFeel <> nil) and not DoubleBuffered then
    DoubleBuffered := LayoutLookAndFeel.NeedDoubleBuffered;
  InitializeSubControlsCxLookAndFeel;
  if (FRootGroup <> nil) and (GetLayoutLookAndFeel <> nil) then
    FRootGroup.LayoutLookAndFeelUserChanged;
  InvalidateControl(Self, True, True);
  CustomizeFormPostUpdate([cfutView]);
end;

procedure TdxCustomLayoutControl.LayoutLookAndFeelUserDestroyed;
begin
  LayoutLookAndFeel := nil;
end;

procedure TdxCustomLayoutControl.SelectionChanged;
begin
  Items.SelectionChanged;
end;

function TdxCustomLayoutControl.CanProcessChildren: Boolean;
begin
  Result := True;
end;

function TdxCustomLayoutControl.GetPainterClass: TdxLayoutControlPainterClass;
begin
  Result := TdxLayoutControlPainter;
end;

function TdxCustomLayoutControl.GetViewInfoClass: TdxLayoutControlViewInfoClass;
begin
  Result := TdxLayoutControlViewInfo;
end;

procedure TdxCustomLayoutControl.AssignItemWithMouse(X, Y: Integer);
begin
  ItemWithMouse := ViewInfo.GetItemWithMouse(Point(X, Y));
end;

procedure TdxCustomLayoutControl.AvailableItemListChanged(Sender: TObject; AComponent: TComponent; AAction: TcxComponentCollectionNotification);
begin
  CustomizeFormPostUpdate([cfutAvailableItems]);
end;

function TdxCustomLayoutControl.CalculateCustomizeFormBounds(const AFormBounds: TRect): TRect;
var
  AControlBounds, ADesktopBounds: TRect;
begin
  AControlBounds := BoundsRect;
  MapWindowPoints(Parent.Handle, 0, AControlBounds, 2);
  ADesktopBounds := GetDesktopWorkArea(AControlBounds.TopLeft);

  Result := AFormBounds;
  with AControlBounds do
  begin
    if (ADesktopBounds.Right - Right >= Result.Right - Result.Left) or
      (ADesktopBounds.Right - Right >= Left - ADesktopBounds.Left) then
      OffsetRect(Result, Right - Result.Left, 0)
    else
      OffsetRect(Result, Left - Result.Right, 0);
    OffsetRect(Result, 0,
      (Top + Bottom - (Result.Bottom - Result.Top)) div 2 - Result.Top);
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

function TdxCustomLayoutControl.CanMultiSelect: Boolean;
begin
  Result := True;
end;

function TdxCustomLayoutControl.CanShowSelection: Boolean;
begin
  Result := True;
end;

function TdxCustomLayoutControl.GetSelectionHelperClass: TdxLayoutRunTimeSelectionHelperClass;
begin
  if IsDesigning then
    Result := dxLayoutDesignTimeSelectionHelperClass
  else
    Result := dxLayoutRunTimeSelectionHelperClass;
end;

procedure TdxCustomLayoutControl.InvalidateSelectionLayer(const R: TRect);
begin
  if (ViewInfo <> nil) and (ViewInfo.FSelectionLayer <> nil) then
    ViewInfo.SelectionLayer.InvalidateRect(R);
end;

procedure TdxCustomLayoutControl.PostBuildSelectionLayer;
begin
  if HandleAllocated then
    PostMessage(Handle, DXM_LAYOUT_BUILDSELECTIONLAYER, 0, 0);
end;

procedure TdxCustomLayoutControl.PostInvalidateSelectionLayer(const R: TRect);
begin
  if HandleAllocated then
    with R do
      PostMessage(Handle, DXM_LAYOUT_INVALIDATESELECTIONLAYER, MakeWParam(Left, Top), MakeLParam(Right, Bottom));
end;

procedure TdxCustomLayoutControl.CheckLeftPos(var Value: Integer);
begin
  Value := Max(Min(Value, ViewInfo.ContentWidth - ViewInfo.ClientWidth), 0);
end;

procedure TdxCustomLayoutControl.CheckPositions;
begin
  LeftPos := LeftPos;
  TopPos := TopPos;
end;

procedure TdxCustomLayoutControl.CheckTopPos(var Value: Integer);
begin
  Value := Max(Min(Value, ViewInfo.ContentHeight - ViewInfo.ClientHeight), 0);
end;

procedure TdxCustomLayoutControl.CustomizeFormPostUpdate(AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes);
begin
  if HandleAllocated then
    PostMessage(Handle, DXM_REFRESHCUSTOMIZATION, Byte(AUpdateTypes), 0);
end;

procedure TdxCustomLayoutControl.CustomizeFormUpdate(
  AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes);
begin
  if not Customization or (csDestroying in FCustomizeForm.ComponentState) then
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
  if cfutSelection in FCustomizeFormUpdateTypes then
    CustomizeForm.UpdateSelection;
  if cfutView in FCustomizeFormUpdateTypes then
    CustomizeForm.UpdateView;
  if cfutDragAndDropState in FCustomizeFormUpdateTypes then
    CustomizeForm.UpdateDragAndDropState;
  FCustomizeFormUpdateTypes := [];
end;

procedure TdxCustomLayoutControl.CustomizeFormUpdateList(AItem: TdxCustomLayoutItem);
const
  UpdateTypeMap: array[Boolean] of TdxLayoutCustomizeFormUpdateType = (cfutVisibleItems, cfutAvailableItems);
begin
  CustomizeFormPostUpdate([UpdateTypeMap[AItem.IsAvailable]]);
end;

procedure TdxCustomLayoutControl.DoCustomization;
begin
  if not IsDesigning then
  begin
    if Customization then
    begin
      dxDesignCustomizationHelper.AddLayout(Self);
      FPrevEnabled := Enabled;
      Enabled := False;
    end
    else
    begin
      Enabled := FPrevEnabled;
      dxDesignCustomizationHelper.RemoveLayout(Self);
    end;
  end;
  PostBuildSelectionLayer;
  CallNotify(FOnCustomization, Self);
  if not IsDestroying then
    Items.CustomizationChanged;
end;

procedure TdxCustomLayoutControl.DoItemChanged(AItem: TdxCustomLayoutItem);
begin
  if Assigned(FOnItemChanged) then
    FOnItemChanged(AItem);
end;

procedure TdxCustomLayoutControl.DragAndDropBegan;
begin
// todo: remove
end;

function TdxCustomLayoutControl.GetAlignmentConstraintClass: TdxLayoutAlignmentConstraintClass;
begin
  Result := TdxLayoutAlignmentConstraint;
end;

function TdxCustomLayoutControl.GetDefaultGroupClass: TdxLayoutGroupClass;
begin
  Result := TdxLayoutGroup;
end;

function TdxCustomLayoutControl.GetDefaultItemClass: TdxLayoutItemClass;
begin
  Result := TdxLayoutItem;
end;

function TdxCustomLayoutControl.GetDesignSelectorRect: TRect;
const
  Offset = 3;
  Width = 16;
begin
  with ClientBounds do
    Result := Rect(Right - Width - Offset, Bottom - Width - Offset, Right - Offset, Bottom - Offset);
end;

function TdxCustomLayoutControl.IsCustomization: Boolean;
begin
  Result := Customization or IsDesigning;
end;

function TdxCustomLayoutControl.IsDesignSelectorsVisible: Boolean;
begin
  Result := IsDesigning and ShowDesignSelectors;
end;

function TdxCustomLayoutControl.IsToolSelected: Boolean;
begin
  Result := IsDesigning and (dxLayoutDesignTimeHelper <> nil) and
    dxLayoutDesignTimeHelper.IsToolSelected;
end;

function TdxCustomLayoutControl.IsUpdateLocked: Boolean;
begin
  Result := FUpdateLockCount <> 0;
end;

procedure TdxCustomLayoutControl.InternalCalculateRoot(ANeedPack: Boolean);

  procedure BeforeCalculateViewInfo;
  var
    I: Integer;
  begin
    Items.BeforeCalculateViewInfo;
    for I := 0 to AvailableItemCount - 1 do
      AvailableItems[I].BeforeCalculateViewInfo;
  end;

  procedure AfterCalculateViewInfo;
  var
    I: Integer;
  begin
    Items.AfterCalculateViewInfo;
    for I := 0 to AvailableItemCount - 1 do
      AvailableItems[I].AfterCalculateViewInfo;
  end;

  procedure ApplyCalculatedChanges;
  var
    I: Integer;
  begin
    Items.ApplyCalculatedChanges;
    for I := 0 to AvailableItemCount - 1 do
      AvailableItems[I].ApplyCalculatedChanges;
  end;

begin
  BeginUpdate;
  try
    if ANeedPack then
      Items.Pack;
    BeforeCalculateViewInfo;
    ViewInfo.Calculate;
    AfterCalculateViewInfo;
  finally
    CancelUpdate;
  end;
  ApplyCalculatedChanges;
end;

procedure TdxCustomLayoutControl.LayoutChanged(ANeedPack: Boolean = True; ANeedUpdateCustomizeForm: Boolean = True);

  procedure ChainSizeAdjustments(AControl: TControl);
  begin
    if (AControl <> nil) and TControlAccess(AControl).AutoSize then
    begin
      TControlAccess(AControl).AdjustSize;
      ChainSizeAdjustments(AControl.Parent);
    end;
  end;

begin
  if not IsDestroying and not IsLoading and not IsUpdateLocked and HandleAllocated then
  begin
    BeginPlaceControls;
    try
      InternalCalculateRoot(ANeedPack);

      if ANeedUpdateCustomizeForm then
        CustomizeFormPostUpdate([cfutSelection]);

      ChainSizeAdjustments(Self);

      UpdateScrollBars;
    finally
      EndPlaceControls;
    end;
    CheckPositions;
    Invalidate;
    PostBuildSelectionLayer;
  end;
end;

procedure TdxCustomLayoutControl.CreateRootGroup;
begin
  SetRootGroup(GetDefaultGroupClass.Create(Owner{nil}));
end;

procedure TdxCustomLayoutControl.DestroyRootGroup;
begin
  SetRootGroup(nil);
end;

procedure TdxCustomLayoutControl.ScrollContent(APrevPos, ACurPos: Integer;
  AHorzScrolling: Boolean);
var
  ADelta: Integer;
  AScrollBounds: TRect;
begin
  if not HandleAllocated then Exit;
  ADelta := -(ACurPos - APrevPos);
  AScrollBounds := ViewInfo.ClientBounds;
  //ValidateRect(Handle, @AScrollBounds);
  ScrollWindowEx(Handle, Ord(AHorzScrolling) * ADelta, Ord(not AHorzScrolling) * ADelta,
    @AScrollBounds, nil, 0, nil, SW_INVALIDATE or SW_ERASE{ or SW_SCROLLCHILDREN bug in WinAPI});
  UpdateWindow(Handle);
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

function TdxCustomLayoutControl.GetRootSectionName(AIniFile: TCustomIniFile): string;
begin
  if AIniFile.SectionExists(Name) then
    Result := Name
  else
    Result := '';
end;

procedure TdxCustomLayoutControl.InternalLoadFromCustomIniFile(AIniFile: TCustomIniFile; ADestroyNonLoadedItems: Boolean);
var
  AItems: TList;
  APositions: TList;
  AItemCount, I: Integer;
  ARootSection: string;
  AVersion: Integer;

  function CreateItemsList: TList;
  begin
    Result := TList.Create;
    Result.Assign(FAbsoluteItems);
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
  var
    AItem: TdxCustomLayoutItem;

    procedure LoadCaption;

      function CanLoadCaptionText: Boolean;
      var
        AGroup: TdxLayoutGroup;
      begin
        Result := AVersion = 2;
        if not Result and (AItem is TdxLayoutGroup) then
        begin
          AGroup := AItem as TdxLayoutGroup;
          Result := AGroup.IsUserDefined and not AGroup.Hidden;
        end;
      end;

    var
      AItemCaptionOptions: TdxLayoutItemCaptionOptions;
    begin
      if CanLoadCaptionText then
        AItem.Caption := AIniFile.ReadString(ASection, 'Caption', '');
      if AVersion = 2 then
      begin
        AItem.CaptionOptions.AlignHorz := TAlignment(AIniFile.ReadInteger(ASection, 'CaptionAlignHorz', 0));
        if AItem.CaptionOptions is TdxLayoutItemCaptionOptions then
        begin
          AItemCaptionOptions := AItem.CaptionOptions as TdxLayoutItemCaptionOptions;
          AItemCaptionOptions.AlignVert := TdxAlignmentVert(AIniFile.ReadInteger(ASection, 'CaptionAlignVert', 1));
          AItemCaptionOptions.Layout := TdxCaptionLayout(AIniFile.ReadInteger(ASection, 'CaptionLayout', 0));
        end;
      end;
    end;

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
    AIndex: Integer;
    AGroup: TdxLayoutGroup;
  begin
    AName := AIniFile.ReadString(ASection, 'Name', '');
    if AName = '' then Exit;
    AItem := FindItem(AName);
    if AItem = nil then
    begin
      AItem := CreateItem(GetItemClass(AIniFile.ReadInteger(ASection, 'ItemClassKind', TdxLayoutGroup.GetItemClassKind)));
      AItem.Name := AName;
    end
    else
      AItems.Remove(AItem);

    AParentName := AIniFile.ReadString(ASection, 'ParentName', '');
    AIndex := AIniFile.ReadInteger(ASection, 'Index', -1);
    AddPosition(AItem, AParentName, AIndex);

    if AVersion = 2 then
    begin
      AItem.AlignHorz := TdxLayoutAlignHorz(AIniFile.ReadInteger(ASection, 'AlignHorz', 4));
      AItem.AlignVert := TdxLayoutAlignVert(AIniFile.ReadInteger(ASection, 'AlignVert', 4));
      AItem.Width := AIniFile.ReadInteger(ASection, 'Width', 0);
      AItem.Height := AIniFile.ReadInteger(ASection, 'Height', 0);
    end;

    if AItem is TdxLayoutGroup then
    begin
      AGroup := TdxLayoutGroup(AItem);
      AGroup.Hidden := AIniFile.ReadBool(ASection, 'Hidden', False);
      AGroup.LayoutDirection :=
        TdxLayoutDirection(AIniFile.ReadInteger(ASection, 'LayoutDirection', 0));
      if AVersion = 2 then
      begin
        AGroup.ItemIndex := AIniFile.ReadInteger(ASection, 'ItemIndex', 0);
        AGroup.Expanded := AIniFile.ReadBool(ASection, 'Expanded', True);
        AGroup.ShowBorder := AIniFile.ReadBool(ASection, 'ShowBorder', True);
      end;
    end;
    LoadCaption;
  end;

  procedure DestroyNonLoadedItems;
  var
    I: Integer;
  begin
    for I := 0 to AItems.Count - 1 do
      if ADestroyNonLoadedItems and TdxCustomLayoutItem(AItems[I]).CanDelete then
        TObject(AItems[I]).Free;
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
      with APosition^ do
      begin
        Item.Parent := FindItem(ParentName) as TdxLayoutGroup;
        Item.Index := Index;
      end;
    end;
  end;

begin
  AItems := CreateItemsList;
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
      DestroyNonLoadedItems;
      UpdatePositions;
    finally
      Dec(FLoadingCount);
      EndUpdate;
    end;
  finally
    for I := 0 to APositions.Count - 1 do
      Dispose(PdxLayoutItemPosition(APositions[I]));
    APositions.Free;
    AItems.Free;
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

procedure TdxCustomLayoutControl.InternalSaveToCustomIniFile(AIniFile: TCustomIniFile);
var
  AItems: TList;
  I: Integer;
  ARootSection: string;

  function CreateItemsList: TList;
  begin
    Result := TList.Create;
    Result.Count := AbsoluteItemCount;
    Move(FAbsoluteItems.List^, Result.List^, Result.Count * SizeOf(Pointer));
    Result.Sort(CompareItems);
    Result.Insert(0, Items);
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
  var
    AGroup: TdxLayoutGroup;

    function GetParentName: string;
    begin
      if AItem.Parent <> nil then
        Result := AItem.Parent.Name
      else
        Result := '';
    end;

    procedure SaveCaption;
    var
      AItemCaptionOptions: TdxLayoutItemCaptionOptions;
    begin
      AIniFile.WriteString(ASection, 'Caption', AItem.Caption);
      AIniFile.WriteInteger(ASection, 'CaptionAlignHorz', Integer(AItem.CaptionOptions.AlignHorz));
      if AItem.CaptionOptions is TdxLayoutItemCaptionOptions then
      begin
        AItemCaptionOptions := AItem.CaptionOptions as TdxLayoutItemCaptionOptions;
        AIniFile.WriteInteger(ASection, 'CaptionAlignVert', Integer(AItemCaptionOptions.AlignVert));
        AIniFile.WriteInteger(ASection, 'CaptionLayout', Integer(AItemCaptionOptions.Layout));
      end;
    end;

  begin
    AIniFile.WriteString(ASection, 'Name', AItem.Name);
    AIniFile.WriteString(ASection, 'ParentName', GetParentName);
    AIniFile.WriteInteger(ASection, 'Index', AItem.Index);
    AIniFile.WriteInteger(ASection, 'AlignHorz', Integer(AItem.AlignHorz));
    AIniFile.WriteInteger(ASection, 'AlignVert', Integer(AItem.AlignVert));
    AIniFile.WriteInteger(ASection, 'Width', AItem.Width);
    AIniFile.WriteInteger(ASection, 'Height', AItem.Height);
    AIniFile.WriteInteger(ASection, 'ItemClassKind', AItem.GetItemClassKind);

    if AItem is TdxLayoutGroup then
    begin
      AGroup := TdxLayoutGroup(AItem);
      AIniFile.WriteBool(ASection, 'Hidden', AGroup.Hidden);
      AIniFile.WriteInteger(ASection, 'LayoutDirection', Integer(AGroup.LayoutDirection));
      AIniFile.WriteInteger(ASection, 'ItemIndex', AGroup.ItemIndex);
      AIniFile.WriteBool(ASection, 'Expanded', AGroup.Expanded);
      AIniFile.WriteBool(ASection, 'ShowBorder', AGroup.ShowBorder);
    end;
    SaveCaption;
  end;

begin
  ARootSection := Name;
  DeletePrevSettings;
  AItems := CreateItemsList;
  try
    AIniFile.WriteInteger(ARootSection, 'Version', 2);
    AIniFile.WriteInteger(ARootSection, 'ItemCount', AItems.Count);
    for I := 0 to AItems.Count - 1 do
      SaveItem(GetItemSection(I), AItems[I]);
  finally
    AItems.Free;
  end;
end;

procedure TdxCustomLayoutControl.LoadFromCustomIniFile(AIniFile: TCustomIniFile);
begin
  InternalLoadFromCustomIniFile(AIniFile, False);
end;

procedure TdxCustomLayoutControl.SaveToCustomIniFile(AIniFile: TCustomIniFile);
begin
  InternalSaveToCustomIniFile(AIniFile);
end;

procedure TdxCustomLayoutControl.AddSelectionChangedListener(AListener: TPersistent);
begin
  if (FSelectionHelper <> nil) then
    FSelectionHelper.AddSelectionChangedListener(AListener);
end;

function TdxCustomLayoutControl.IsActive: Boolean;
begin
  Result := (FSelectionHelper <> nil) and FSelectionHelper.IsActive;
end;

function TdxCustomLayoutControl.CanDeleteComponent(AComponent: TComponent): Boolean;
begin
  Result := (FSelectionHelper <> nil) and FSelectionHelper.CanDeleteComponent(AComponent);
end;

function TdxCustomLayoutControl.CanProcessKeyboard: Boolean;
begin
  Result := (dxLayoutDragAndDropObject = nil) and (dxLayoutSizingDragAndDropObject = nil) and not FIsPopupShown;
end;

procedure TdxCustomLayoutControl.ClearSelection;
begin
  if (FSelectionHelper <> nil) then
    FSelectionHelper.ClearSelection;
end;

procedure TdxCustomLayoutControl.DeleteSelection;
begin
  if (FSelectionHelper <> nil) then
    FSelectionHelper.DeleteSelection;
end;


procedure TdxCustomLayoutControl.GetSelection(AList: TList);
begin
  if (FSelectionHelper <> nil) then
    FSelectionHelper.GetSelection(AList);
end;

function TdxCustomLayoutControl.IsComponentSelected(AComponent: TPersistent): Boolean;
begin
  Result := (FSelectionHelper <> nil) and FSelectionHelper.IsComponentSelected(AComponent);
end;

procedure TdxCustomLayoutControl.RemoveSelectionChangedListener(AListener: TPersistent);
begin
  if FSelectionHelper <> nil then
    FSelectionHelper.RemoveSelectionChangedListener(AListener);
end;

procedure TdxCustomLayoutControl.SelectComponent(AComponent: TPersistent;
  AShift: TShiftState = []);
begin
  if FSelectionHelper <> nil then
    FSelectionHelper.SelectComponent(AComponent, AShift);
end;

procedure TdxCustomLayoutControl.SetSelection(AList: TList);
begin
  if FSelectionHelper <> nil then
    FSelectionHelper.SetSelection(AList);
end;

function TdxCustomLayoutControl.UniqueName(const BaseName: string): string;
begin
  if FSelectionHelper <> nil then
    Result := FSelectionHelper.UniqueName(BaseName);
end;

//IdxLayoutSelectionChanged
procedure TdxCustomLayoutControl.LayoutSelectionChanged(ASelection: TList; AAction: TdxSelectionAction);

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
  if not IsDestroying and (AAction in [saAdded, saChanged]) and not IsUpdateLocked then
  begin
    TryMakeVisibleSelection;
    ViewInfo.BuildSelectionLayer;
    if IsDesigning then
      InvalidateRect(GetDesignSelectorRect, True);
    CustomizeFormPostUpdate([cfutSelection]);
  end;
end;

procedure TdxCustomLayoutControl.CancelLastUndo;
begin
  if ([csLoading, csReading, csDestroying] * ComponentState = []) and not IsUpdateLocked then
    UndoRedoManager.CancelLastUndo;
  CustomizeFormPostUpdate([cfutView]);
end;

procedure TdxCustomLayoutControl.SaveToUndo;
begin
  if ([csLoading, csReading, csDestroying] * ComponentState = []) and not IsUpdateLocked then
    UndoRedoManager.SaveLayout;
  CustomizeFormPostUpdate([cfutView]);
end;

procedure TdxCustomLayoutControl.Clear;
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

function TdxCustomLayoutControl.CreateAlignmentConstraint: TdxLayoutAlignmentConstraint;
begin
  Result := GetAlignmentConstraintClass.Create(Owner);
  AddAlignmentConstraint(Result);
end;

function TdxCustomLayoutControl.FindItem(AControl: TControl): TdxLayoutItem;
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

function TdxCustomLayoutControl.FindItem(AControlHandle: THandle): TdxLayoutItem;
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

function TdxCustomLayoutControl.FindItem(const AName: string): TdxCustomLayoutItem;
var
  I: Integer;
begin
  if AName <> '' then
  begin
    Result := Items;
    if SameText(Result.Name, AName) then Exit;
    for I := 0 to AbsoluteItemCount - 1 do
    begin
      Result := AbsoluteItems[I];
      if SameText(Result.Name, AName) then Exit;
    end;
  end;  
  Result := nil;
end;

function TdxCustomLayoutControl.GetHitTest(const P: TPoint): TdxCustomLayoutHitTest;
begin
  Result := ViewInfo.GetHitTest(P);
end;

function TdxCustomLayoutControl.GetHitTest(X, Y: Integer): TdxCustomLayoutHitTest;
begin
  Result := ViewInfo.GetHitTest(X, Y);
end;

procedure TdxCustomLayoutControl.BeginUpdate;
begin
  Inc(FUpdateLockCount);
end;

procedure TdxCustomLayoutControl.CancelUpdate;
begin
  Dec(FUpdateLockCount);
end;

procedure TdxCustomLayoutControl.EndUpdate(ANeedPack: Boolean = True);
begin
  Dec(FUpdateLockCount);
  LayoutChanged(ANeedPack);
end;

function TdxCustomLayoutControl.CreateGroup(AGroupClass: TdxLayoutGroupClass = nil;
  AParent: TdxLayoutGroup = nil): TdxLayoutGroup;
begin
  if AGroupClass = nil then
    AGroupClass := GetDefaultGroupClass;
  Result := TdxLayoutGroup(CreateItem(AGroupClass, AParent));
end;

function TdxCustomLayoutControl.CreateItem(AItemClass: TdxCustomLayoutItemClass = nil;
  AParent: TdxLayoutGroup = nil): TdxCustomLayoutItem;
begin
  if AItemClass = nil then
    AItemClass := GetDefaultItemClass;
  Result := AItemClass.Create(Owner);
  AddAvailableItem(Result);
  Result.Parent := AParent;
  Modified;
end;

function TdxCustomLayoutControl.CreateItemForControl(AControl: TControl;
  AParent: TdxLayoutGroup = nil): TdxLayoutItem;
begin
  Result := TdxLayoutItem(CreateItem(GetDefaultItemClass, AParent));
  Result.Control := AControl;
end;

function TdxCustomLayoutControl.CanRestore: Boolean;
begin
  Result := OptionsStoring.CanRestoreFromIniFile or OptionsStoring.CanRestoreFromRegistry or (FStoredStream.Size > 0);
end;

procedure TdxCustomLayoutControl.Restore;
begin
  if not CanRestore then
    Exit;
  if OptionsStoring.CanRestoreFromRegistry then
    LoadFromRegistry(OptionsStoring.RegistryPath)
  else
    if OptionsStoring.CanRestoreFromIniFile then
      LoadFromIniFile(OptionsStoring.IniFileName)
    else
    begin
      FStoredStream.Position := 0;
      LoadFromStream(FStoredStream);
    end;
end;

procedure TdxCustomLayoutControl.Store;
begin
  if OptionsStoring.CanStoreToIniFile then
    SaveToIniFile(OptionsStoring.IniFileName);
  if OptionsStoring.CanStoreToRegistry then
    SaveToRegistry(OptionsStoring.RegistryPath);
  if not IsDestroying then
  begin
    FStoredStream.Clear;
    SaveToStream(FStoredStream);
  end;
end;

procedure TdxCustomLayoutControl.LoadFromIniFile(const AFileName: string);
var
  AIniFile: TMemIniFile;
begin
  if AFileName = '' then Exit;
  AIniFile := TMemIniFile.Create(AFileName);
  try
    LoadFromCustomIniFile(AIniFile);
  finally
    AIniFile.Free;
  end;
end;

procedure TdxCustomLayoutControl.LoadFromRegistry(const ARegistryPath: string);
var
  AIniFile: TRegistryIniFile;
begin
  if ARegistryPath = '' then Exit;
  AIniFile := TRegistryIniFile.Create(ARegistryPath);
  try
    LoadFromCustomIniFile(AIniFile);
  finally
    AIniFile.Free;
  end;
end;

procedure TdxCustomLayoutControl.LoadFromStream(AStream: TStream);

  function GetBufferSize: Integer;
  var
    APosition: Integer;
    ASignature: Integer;
    AVersion: Word;
  begin
    APosition := AStream.Position;
    AStream.Read(Result, SizeOf(Result));
    AStream.Read(ASignature, SizeOf(ASignature));
    AStream.Read(AVersion, SizeOf(AVersion));
    if ASignature <> dxLayoutSignature then
    begin
      Result := -1;
      AStream.Position := APosition;
    end;
  end;

var
  AIniFile: TMemIniFile;
  AStrings: TStringList;
  ABufferSize: Integer;
  AMemoryStream: TMemoryStream;
begin
  AIniFile := TMemIniFile.Create('');
  AStrings := TStringList.Create;
  try
    ABufferSize := GetBufferSize;
    if ABufferSize > -1 then
    begin
      AMemoryStream := TMemoryStream.Create;
      try
        AMemoryStream.CopyFrom(AStream, ABufferSize);
        AMemoryStream.Position := 0;
        AStrings.LoadFromStream(AMemoryStream);
      finally
        AMemoryStream.Free;
      end;
    end
    else
      AStrings.LoadFromStream(AStream);

    AIniFile.SetStrings(AStrings);
    LoadFromCustomIniFile(AIniFile);
  finally
    AStrings.Free;
    AIniFile.Free;
  end;
end;

procedure TdxCustomLayoutControl.SaveToIniFile(const AFileName: string);
var
  AIniFile: TMemIniFile;
begin
  if AFileName = '' then Exit;
  AIniFile := TMemIniFile.Create(AFileName);
  try
    SaveToCustomIniFile(AIniFile);
    AIniFile.UpdateFile;
  finally
    AIniFile.Free;
  end;
end;

procedure TdxCustomLayoutControl.SaveToRegistry(const ARegistryPath: string);
var
  AIniFile: TRegistryIniFile;
begin
  if ARegistryPath = '' then Exit;
  AIniFile := TRegistryIniFile.Create(ARegistryPath);
  try
    SaveToCustomIniFile(AIniFile);
  finally
    AIniFile.Free;
  end;
end;

procedure TdxCustomLayoutControl.SaveToStream(AStream: TStream);

  procedure WriteSignature(ASize: Integer);
  begin
    AStream.Write(ASize, SizeOf(ASize));
    AStream.Write(dxLayoutSignature, SizeOf(dxLayoutSignature));
    AStream.Write(dxLayoutVersion, SizeOf(dxLayoutVersion));
  end;

  function GetStringListSize(AStrings: TStringList): Integer;
  var
    ATmpStream: TMemoryStream;
  begin
    ATmpStream := TMemoryStream.Create;
    try
      AStrings.SaveToStream(ATmpStream);
      Result := ATmpStream.Size;
    finally
      ATmpStream.Free;
    end;
  end;

var
  AIniFile: TMemIniFile;
  AStrings: TStringList;
begin
  AIniFile := TMemIniFile.Create('');
  AStrings := TStringList.Create;
  try
    SaveToCustomIniFile(AIniFile);
    AIniFile.GetStrings(AStrings);
    WriteSignature(GetStringListSize(AStrings));
    AStrings.SaveToStream(AStream);
  finally
    AStrings.Free;
    AIniFile.Free;
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
   Result := (FHitItem <> nil) and FHitItem.Container.IsCustomization;
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
  Result := HitItem;
end;

function TdxCustomLayoutHitTest.GetSourceItem: TdxCustomLayoutItem;
begin
  Result := HitItem;
end;

{ TdxLayoutNoneHitTest }

class function TdxLayoutNoneHitTest.HitTestCode: Integer;
begin
  Result := htNone;
end;

{ TdxLayoutItemHitTest }

function TdxLayoutItemHitTest.GetHitItem: TdxLayoutItem;
begin
  Result := inherited HitItem as TdxLayoutItem;
end;

procedure TdxLayoutItemHitTest.SetHitItem(Value: TdxLayoutItem);
begin
  inherited HitItem := Value;
end;

class function TdxLayoutItemHitTest.HitTestCode: Integer;
begin
  Result := htItem;
end;

function TdxLayoutItemHitTest.GetGroupForInsert: TdxLayoutGroup;
begin
  Result := HitItem.Parent;
end;

{ TdxLayoutGroupHitTest }

function TdxLayoutGroupHitTest.GetHitItem: TdxLayoutGroup;
begin
  Result := TdxLayoutGroup(inherited HitItem);
end;

procedure TdxLayoutGroupHitTest.SetHitItem(Value: TdxLayoutGroup);
begin
  inherited HitItem := Value;
end;

class function TdxLayoutGroupHitTest.HitTestCode: Integer;
begin
  Result := htGroup;
end;

function TdxLayoutGroupHitTest.GetGroupForInsert: TdxLayoutGroup;
begin
  Result := HitItem;
end;

{ TdxLayoutTabbedGroupHitTest }

function TdxLayoutTabbedGroupHitTest.GetDestinationItem: TdxCustomLayoutItem;
var
  ATabIndex: Integer;
  AClientPoint: TPoint;
begin
  if Specific.HasTabControl then
  begin
    AClientPoint := cxPointOffset(FHitPoint, Point(Specific.FTabControl.Left, Specific.FTabControl.Top), False);
    ATabIndex := Specific.FTabControl.IndexOfTabAt(AClientPoint.X, AClientPoint.Y);
    if ATabIndex <> -1 then
      Result := HitItem.ViewInfo.ItemViewInfos[ATabIndex].Item
    else
      Result := inherited GetDestinationItem;
  end
  else
    Result := inherited GetDestinationItem;
end;

function TdxLayoutTabbedGroupHitTest.GetSourceItem: TdxCustomLayoutItem;
var
  ATabIndex: Integer;
  AClientPoint: TPoint;
begin
  if Specific.HasTabControl then
  begin
    AClientPoint := cxPointOffset(FHitPoint, Point(Specific.FTabControl.Left, Specific.FTabControl.Top), False);
    ATabIndex := Specific.FTabControl.IndexOfTabAt(AClientPoint.X, AClientPoint.Y);
    if ATabIndex <> -1 then
      Result := HitItem.ViewInfo.ItemViewInfos[ATabIndex].Item
    else
      Result := inherited GetSourceItem;
  end
  else
    Result := inherited GetSourceItem;
end;

function TdxLayoutTabbedGroupHitTest.GetSpecific: TdxLayoutGroupViewInfoTabbedSpecific;
begin
  Result := HitItem.ViewInfo.Specific as TdxLayoutGroupViewInfoTabbedSpecific;
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
  Result := HitItem;
end;

{ TdxLayoutCustomizeFormAvailableItemsHitTest }

class function TdxLayoutCustomizeFormAvailableItemsHitTest.HitTestCode: Integer;
begin
  Result := htAvailableItems;
end;

{ TdxLayoutCustomizeFormTreeViewItemsHitTest }

class function TdxLayoutCustomizeFormTreeViewItemsHitTest.HitTestCode: Integer;
begin
  Result := htTreeViewItems;
end;

{ TdxLayoutClientAreaHitTest }

class function TdxLayoutClientAreaHitTest.HitTestCode: Integer;
begin
  Result := htClientArea;
end;

function TdxLayoutClientAreaHitTest.GetGroupForInsert: TdxLayoutGroup;
begin
  Result := Control.Items;
end;

function TdxLayoutClientAreaHitTest.GetDestinationItem: TdxCustomLayoutItem;
begin
  Result := Control.Items;
end;

{ TdxLayoutSizeHitTest }

function TdxLayoutSizeHitTest.GetCursor: TCursor;
begin
  Result := crSize;
end;

function TdxLayoutSizeHitTest.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  Result := TdxLayoutSizingDragAndDropObject;
end;

{ TdxLayoutSplitterHitTest }

function TdxLayoutSplitterHitTest.CanDragAndDrop: Boolean;
begin
  Result := not FHitItem.Container.IsCustomization; 
end;

function TdxLayoutSplitterHitTest.GetCursor: TCursor;
begin
  if (HitItem as TdxLayoutSplitterItem).IsVertical then
    Result := crHSplit
  else
    Result := crVSplit;
end;

function TdxLayoutSplitterHitTest.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  if (HitItem as TdxLayoutSplitterItem).IsVertical then
    Result := TdxLayoutHSplitterDragAndDropObject
  else
    Result := TdxLayoutVSplitterDragAndDropObject;
end;

{ TdxCustomLayoutControlHandler }

constructor TdxCustomLayoutControlHandler.Create(AControl: TdxCustomLayoutControl);
begin
  inherited Create;
  FControl := AControl;
end;

function TdxCustomLayoutControlHandler.GetViewInfo: TdxLayoutControlViewInfo;
begin
  Result := FControl.ViewInfo;
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

  procedure PrepareCanvasFont;
  var
    ATextColor: TColor;
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.Font := ViewInfo.Font;
    ATextColor := ViewInfo.TextColor;
    if ATextColor <> clDefault then
      Canvas.Font.Color := ATextColor;
    if ViewInfo.IsTextUnderlined then
      Canvas.Font.Style := Canvas.Font.Style + [fsUnderline];
  end;

begin
  if ViewInfo.IsTextVisible then
  begin
    Canvas.SaveState;
    try
      PrepareCanvasFont;
      DoDrawText;
    finally
      Canvas.RestoreState;
    end;
  end;
end;

procedure TdxCustomLayoutItemCaptionPainter.DoDrawText;
begin
  with ViewInfo do
    Self.Canvas.DrawText(Text, TextAreaBounds, CalculateTextFlags, Enabled or (ViewInfo.TextColor <> clDefault));
end;

procedure TdxCustomLayoutItemCaptionPainter.DoDrawGlyph;
begin
  dxDrawItemGlyph(Canvas, ViewInfo.Item, ViewInfo.ImageBounds);
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

function TdxLayoutItemControlPainter.GetViewInfo: TdxLayoutItemControlViewInfo;
begin
  Result := TdxLayoutItemControlViewInfo(inherited ViewInfo);
end;

procedure TdxLayoutItemControlPainter.DrawBorders;
begin
  LayoutLookAndFeel.DrawItemControlBorder(Canvas, ViewInfo.ItemViewInfo.Options, ViewInfo.Bounds);
end;

procedure TdxLayoutItemControlPainter.Paint;
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

{ TdxLayoutItemPainter }

function TdxLayoutItemPainter.GetViewInfo: TdxLayoutItemViewInfo;
begin
  Result := inherited ViewInfo as TdxLayoutItemViewInfo;
end;

function TdxLayoutItemPainter.CanDrawSpecificPart: Boolean;
begin
  Result := CanPaint and ViewInfo.ActuallyVisible and ViewInfo.HasControl;
end;

function TdxLayoutItemPainter.GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass;
begin
  Result := TdxLayoutItemCaptionPainter;
end;

function TdxLayoutItemPainter.GetControlPainterClass: TdxLayoutItemControlPainterClass;
begin
  Result := TdxLayoutItemControlPainter;
end;

procedure TdxLayoutItemPainter.DoDrawControlBorder;
begin
  with GetControlPainterClass.Create(Canvas, ViewInfo.ControlViewInfo) do
    try
      Paint;
    finally
      Free;
    end;
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

procedure TdxLayoutItemPainter.DrawContent;
begin
  DrawControlBorder;
  inherited;
end;

procedure TdxLayoutItemPainter.DrawControlBorder;
begin
  if ViewInfo.HasControl then
    DoDrawControlBorder;
end;

{ TdxLayoutGroupButtonPainter }

procedure TdxLayoutGroupButtonPainter.Paint;
const
  ADrawModes: array [Boolean] of TcxImageDrawMode = (idmDisabled, idmNormal);
var
  AcxLookAndFeel: TcxLookAndFeel;
  APainter: TcxCustomLookAndFeelPainterClass;
  R: TRect;
begin
  inherited;
  AcxLookAndFeel := TcxLookAndFeel.Create(nil);
  try
    LayoutLookAndFeel.InitializeSubControlCxLookAndFeel(AcxLookAndFeel);
    APainter := GetButtonPainterClass(AcxLookAndFeel);
    if ViewInfo.IsExpandButton and not IsGlyphAssigned(ViewInfo.Glyph) then
      APainter.DrawGroupBoxExpandButton(Canvas,
        ViewInfo.Bounds, ViewInfo.GetState, ViewInfo.IsGroupExpanded)
    else
    begin
      APainter.DrawButton(Canvas, ViewInfo.Bounds, '', ViewInfo.GetState);
      if ViewInfo.Glyph <> nil then
      begin
        R := cxRectCenter(ViewInfo.Bounds, ViewInfo.Glyph.Width, ViewInfo.Glyph.Height);
        cxDrawImage(Canvas.Handle, R, R, ViewInfo.Glyph, nil, -1, ADrawModes[ViewInfo.IsEnabled]);
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

procedure TdxLayoutGroupPainter.DrawSpecificBackground;
begin
  if CanDrawSpecificBackground then
    DoDrawSpecificBackground;
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

procedure TdxLayoutGroupPainter.DoDrawSpecificPart;
begin
  inherited;
  ViewInfo.Specific.DrawSpecificPart(Canvas);
end;

procedure TdxLayoutGroupPainter.DoDrawSelectionFrame;
begin
  DrawBoundsFrame;
  inherited;
end;

procedure TdxLayoutGroupPainter.DrawBackground;
begin
  inherited;
  DrawSpecificBackground;
end;

procedure TdxLayoutGroupPainter.DrawContent;
begin
  DrawBorders;
  DrawItemsArea;
  inherited;
  DrawButtons;
  //DrawBoundsFrame;
end;

function TdxLayoutGroupPainter.CanDrawSpecificBackground: Boolean;
begin
  Result := ViewInfo.CanDrawSpecificBackground;
end;

function TdxLayoutGroupPainter.HasCaptionBackground: Boolean;
begin
  Result := True;
end;

procedure TdxLayoutGroupPainter.DoDrawBorders;
//todo: #SC
{var
  ASide: TdxLayoutSide;}
begin
//todo: #SC
  {with Canvas do
  begin
    Brush.Color := ViewInfo.Color;
    for ASide := Low(TdxLayoutSide) to High(TdxLayoutSide) do
      Canvas.FillRect(ViewInfo.BorderRestSpaceBounds[ASide]);
  end;}
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

procedure TdxLayoutGroupPainter.DoDrawRestSpace;
begin
  Canvas.Brush.Color := ViewInfo.Color;
  Canvas.FillRect(ViewInfo.ClientBounds);
end;

procedure TdxLayoutGroupPainter.DoDrawBoundsFrame;
begin
  FrameRectByColor(Canvas.Handle, ViewInfo.SelectionBorderRect, dxLayoutHiddenGroupBorderDefaultColor);
end;

procedure TdxLayoutGroupPainter.DoDrawSpecificBackground;
begin
  ViewInfo.Specific.DrawSpecificBackground(Canvas); 
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

procedure TdxLayoutGroupPainter.DrawBoundsFrame;
begin
  if ViewInfo.HasBoundsFrame then
    DoDrawBoundsFrame;
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

procedure TdxLayoutGroupPainter.DrawRestSpace;
begin
  if not ViewInfo.IsTransparent then
    DoDrawRestSpace;
end;

procedure TdxLayoutGroupPainter.DrawItemsArea;
begin
  DrawItems;
//todo: #SC  DrawRestSpace;
end;

{ TdxLayoutControlPainter }

function TdxLayoutControlPainter.GetInternalCanvas: TcxCanvas;
begin
  Result := FControl.Canvas;
end;

procedure TdxLayoutControlPainter.MakeCanvasClipped(ACanvas: TcxCanvas);
begin
  ACanvas.IntersectClipRect(ViewInfo.ClientBounds);
end;

procedure TdxLayoutControlPainter.DrawBackground(ACanvas: TcxCanvas);
begin
  if not ViewInfo.IsTransparent then
    ViewInfo.LayoutLookAndFeel.DrawLayoutControlBackground(ACanvas, ViewInfo.ClientBounds);
end;

procedure TdxLayoutControlPainter.DrawDesignSelector(ACanvas: TcxCanvas);
begin
  if Control.IsDesignSelectorsVisible then
    cxDrawDesignRect(ACanvas, Control.GetDesignSelectorRect, Control.IsComponentSelected(Control));
end;

procedure TdxLayoutControlPainter.DrawItems(ACanvas: TcxCanvas);
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

procedure TdxLayoutControlPainter.DrawDesignFeatures(ACanvas: TcxCanvas);
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

procedure TdxLayoutControlPainter.PlaceControls(AItemViewInfo: TdxCustomLayoutItemViewInfo);
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

  {
  function CheckControlSize(AControlViewInfo: TdxLayoutItemControlViewInfo): Boolean;
  var
    AItem: TdxLayoutItem;
    AItemViewInfo: TdxCustomLayoutItemViewInfo;
    AControl: TControl;
  begin
    AItem := AControlViewInfo.Item;
    AItemViewInfo := AControlViewInfo.ItemViewInfo;
    AControl := AControlViewInfo.Control;
    Result :=
      ((AItemViewInfo.AlignHorz = ahClient) or (AItem.Width <> 0) or (AControl.Width = cxRectWidth(AControlViewInfo.ControlBounds))) and
      ((AItemViewInfo.AlignVert = avClient) or (AItem.Height <> 0) or (AControl.Height = cxRectHeight(AControlViewInfo.ControlBounds)));
  end;
  }

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
  Control.FIsPlaceControlsNeeded := False;

  AControlViewInfos := TList.Create;
  AWinControlViewInfos := TList.Create;
  try
    Control.FIsPlacingControls := True;
    try
      AItemViewInfo.PopulateControlViewInfoList(AControlViewInfos, AWinControlViewInfos);
      ProcessControls;
      ProcessWinControls;
    finally
      Control.FIsPlacingControls := False;
    end;
    if not CheckControlSizes(AControlViewInfos) or not CheckControlSizes(AWinControlViewInfos) then
      Control.LayoutChanged;
  finally
    AWinControlViewInfos.Free;
    AControlViewInfos.Free;
  end;
end;

function TdxLayoutControlPainter.GetCanvas: TcxCanvas;
begin
  Result := InternalCanvas;
  MakeCanvasClipped(Result);
end;

procedure TdxLayoutControlPainter.Paint;
var
  ACanvas: TcxCanvas;
begin
  ACanvas := GetCanvas;
  ACanvas.SaveState;
  try
  { moved to TdxLayoutControlViewInfo.Calculate }//PlaceControls;  // because of selection drawing
    DrawBackground(ACanvas);
    DrawItems(ACanvas);
    DrawDesignFeatures(ACanvas);
    DrawDesignSelector(ACanvas);
//  PlaceControls;
  finally
    ACanvas.RestoreState;
  end;
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
  Item.Container.InvalidateRect(ABounds, False);
end;

function TdxCustomLayoutItemElementViewInfo.WantsMouse(X, Y: Integer): Boolean;
begin
  Result := Visible and PtInRect(Bounds, Point(X, Y));
end;

procedure TdxCustomLayoutItemElementViewInfo.ShowHint(var AHintInfo: THintInfo; out ACanShow: Boolean);
begin
  ACanShow := False;
end;

{ TdxCustomLayoutItemCaptionViewInfo }

function TdxCustomLayoutItemCaptionViewInfo.GetCanvas: TcxCanvas;
begin
  Result := ItemViewInfo.ContainerViewInfo.Canvas;
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
  Invalidate(HotTrackBounds);
end;

function TdxCustomLayoutItemCaptionViewInfo.GetColor: TColor;
begin
  Result := ItemViewInfo.Color;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetFont: TFont;
begin
  Result := Options.GetFont(Item.Container);
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
  MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
  AlignsVert: array[TdxAlignmentVert] of Integer =
    (cxAlignTop, cxAlignVCenter, cxAlignBottom);
begin
  Result := MultiLines[IsMultiLine] or cxAlignmentsHorz[AlignHorz] or AlignsVert[AlignVert];
  if Item.CaptionOptions.ShowAccelChar then
    Inc(Result, cxShowPrefix);
end;

procedure TdxCustomLayoutItemCaptionViewInfo.PrepareCanvas;
begin
  Canvas.Font := Font;
end;

function TdxCustomLayoutItemCaptionViewInfo.CanDoCaptionClick(X, Y: Integer): Boolean;
begin
  Result := Enabled and IsPointInHotTrackBounds(Point(X, Y));
end;

function TdxCustomLayoutItemCaptionViewInfo.GetAlignHorz: TAlignment;
begin
  Result := Item.CaptionOptions.AlignHorz;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetOptions: TdxLayoutLookAndFeelCaptionOptions;
begin
  Result := ItemViewInfo.Options.CaptionOptions;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetSpaceBetweenImageText: Integer;
begin
  Result := dxLayoutGlyphSpace;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetAvailableHeight: Integer;
begin
  Result := CalculateHeight;
  if not Visible then
    Inc(Result, Max(GetAvailableTextHeight, ImageHeight));
end;

function TdxCustomLayoutItemCaptionViewInfo.GetAvailableTextHeight: Integer;
begin
  PrepareCanvas;
  Result := Canvas.TextHeight('Qq');
  Inc(Result);  // for disabling
end;

function TdxCustomLayoutItemCaptionViewInfo.GetContentOffsets: TRect;
begin
  Result := cxNullRect;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetText: string;
begin
  Result := Item.Caption;
end;

function TdxCustomLayoutItemCaptionViewInfo.GetTextAreaBounds: TRect;
var
  AImageAreaWidth: Integer;
begin
  if IsTextVisible then
  begin
    Result := cxRectContent(Bounds, GetContentOffsets);
    if IsImageVisible then
    begin
      AImageAreaWidth := cxRectWidth(ImageAreaBounds);
      if IsNeedSpaceBetweenImageText then
        Inc(AImageAreaWidth, GetSpaceBetweenImageText);
      if Item.CaptionOptions.AlignHorz = taRightJustify then
        Result.Right := Result.Right - AImageAreaWidth
      else
        Result.Left := Result.Left + AImageAreaWidth;
    end;
    if Enabled and (Text <> '') then
      with Result do
      begin
        Dec(Right);
        Dec(Bottom);
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
      PrepareCanvas;
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
    PrepareCanvas;
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
    PrepareCanvas;
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

function TdxCustomLayoutItemCaptionViewInfo.GetImageAreaBounds: TRect;
begin
  Result := cxRectContent(Bounds, GetContentOffsets);
  if Item.CaptionOptions.AlignHorz = taRightJustify then
    Result.Left := Result.Right - ImageWidth
  else
    Result.Right := Result.Left + ImageWidth;
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

{ TdxCustomLayoutItemViewInfo }

constructor TdxCustomLayoutItemViewInfo.Create(AContainerViewInfo: TdxLayoutControlViewInfo;
  AParentViewInfo: TdxLayoutGroupViewInfo; AItem: TdxCustomLayoutItem);
begin
  inherited Create;
  FContainerViewInfo := AContainerViewInfo;
  FParentViewInfo := AParentViewInfo;

  FNotifyComponent := TcxFreeNotificator.Create(nil);
  FNotifyComponent.OnFreeNotification := FreeNotification;
  FItem := AItem;
  FItem.FViewInfo := Self;
  FItem.FreeNotification(FNotifyComponent);

  CreateViewInfos;
end;

destructor TdxCustomLayoutItemViewInfo.Destroy;
begin
  DestroyViewInfos;
  if FItem <> nil then
    FItem.FViewInfo := nil;
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
    ParentViewInfo.Specific.AllowDrawChild(Item));
end;

function TdxCustomLayoutItemViewInfo.IsAvailable: Boolean;
begin
  Result := Item.IsAvailable;
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

function TdxCustomLayoutItemViewInfo.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := Item.GetLayoutLookAndFeel;
end;

procedure TdxCustomLayoutItemViewInfo.Invalidate(const ABounds: TRect);
begin
  Item.Container.InvalidateRect(ABounds, False);
end;

procedure TdxCustomLayoutItemViewInfo.PaintSelectionLayer;
var
  ABitmap, ABackgroundBitmap: TcxAlphaBitmap;
  ASizableMarkers, ANonSizableMarkers: TRects;
begin
  if Selected and ActuallyVisible then
  begin
    ABitmap := ContainerViewInfo.SelectionLayer.SelectionImage;

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

procedure TdxCustomLayoutItemViewInfo.ShowHint(var AHintInfo: THintInfo; out ACanShow: Boolean);
begin
  if ElementWithMouse <> nil then
    ElementWithMouse.ShowHint(AHintInfo, ACanShow);
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
  Result := Item.Container.IsComponentSelected(Item);
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

procedure TdxCustomLayoutItemViewInfo.SetOffset(ASide: TdxLayoutSide; Value: Integer);
begin
  FOffsets[ASide] := Value;
end;

function TdxCustomLayoutItemViewInfo.CreateHitTest(AHitTestClass: TdxCustomLayoutItemHitTestClass; const P: TPoint): TdxCustomLayoutItemHitTest;
begin
  Result := AHitTestClass.Instance as TdxCustomLayoutItemHitTest;
  Result.HitItem := Item;
  Result.HitPoint := P;
end;

procedure TdxCustomLayoutItemViewInfo.FreeNotification(AComponent: TComponent);
begin
  FItem := nil;
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
  Result := FItem.Container.IsCustomization;
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
  Result := Item.ActuallyVisible;
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

procedure TdxCustomLayoutItemViewInfo.CalculateTabOrders(var AAvailTabOrder: Integer);
begin
// do nothing
end;

function TdxCustomLayoutItemViewInfo.GetHitTest(const P: TPoint): TdxCustomLayoutHitTest;
begin
  Result := nil;
  if (not IsParentLocked or Item.IsDesigning) and ActuallyVisible then
  begin
    if IsCustomization and Item.IsSelected and (GetMarkerIndex(GetSelectableMarkers, P) <> -1) then
      Result := CreateHitTest(TdxLayoutSizeHitTest, P)
    else
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

procedure TdxLayoutEmptySpaceItemCaptionViewInfo.PrepareCanvas;
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

function TdxLayoutLabeledItemCaptionViewInfo.GetAlignVert: TdxAlignmentVert;
begin
  Result := Item.CaptionOptions.AlignVert;
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

function TdxLayoutItemControlViewInfo.GetBorderColor: TColor;
begin
  Result := ItemViewInfo.Options.GetControlBorderColor;
end;

function TdxLayoutItemControlViewInfo.GetBorderStyle: TdxLayoutBorderStyle;
begin
  Result := ItemViewInfo.Options.ControlBorderStyle;
end;

function TdxLayoutItemControlViewInfo.GetControl: TControl;
begin
  Result := Item.Control;
end;

function TdxLayoutItemControlViewInfo.GetItem: TdxLayoutItem;
begin
  Result := inherited Item as TdxLayoutItem;
end;

function TdxLayoutItemControlViewInfo.GetItemViewInfo: TdxLayoutItemViewInfo;
begin
  Result := inherited ItemViewInfo as TdxLayoutItemViewInfo;
end;

function TdxLayoutItemControlViewInfo.GetOpaqueControl: Boolean;
begin
  Result := Item.ControlOptions.Opaque;
end;

function TdxLayoutItemControlViewInfo.GetVisible: Boolean;
begin
  Result := ItemViewInfo.HasControl and not ItemViewInfo.IsAvailable and (not ItemViewInfo.IsDragImagePainted or ItemViewInfo.ActuallyVisible);
end;

function TdxLayoutItemControlViewInfo.CalculateControlBounds: TRect;
begin
  Result := Bounds;
  Inc(Result.Left, BorderWidths[sdLeft]);
  Dec(Result.Right, BorderWidths[sdRight]);
  Inc(Result.Top, BorderWidths[sdTop]);
  Dec(Result.Bottom, BorderWidths[sdBottom]);
end;

function TdxLayoutItemControlViewInfo.GetBorderWidth(ASide: TdxLayoutSide): Integer;
begin
  if HasBorder then
    Result := LayoutLookAndFeel.ItemControlBorderWidths[ASide]
  else
    Result := 0
end;

function TdxLayoutItemControlViewInfo.GetControlAreaHeight(AControlHeight: Integer): Integer;
begin
  Result := BorderWidths[sdTop] + AControlHeight + BorderWidths[sdBottom];
end;

function TdxLayoutItemControlViewInfo.GetControlAreaWidth(AControlWidth: Integer): Integer;
begin
  Result := BorderWidths[sdLeft] + AControlWidth + BorderWidths[sdRight];
end;

function TdxLayoutItemControlViewInfo.HasBorder: Boolean;
begin
  Result := Item.ControlOptions.ShowBorder and not ItemViewInfo.IsAvailable;
end;

procedure TdxLayoutItemControlViewInfo.Calculate(const ABounds: TRect);
begin
  inherited;
  FControlBounds := CalculateControlBounds;
end;

procedure TdxLayoutItemControlViewInfo.CalculateTabOrder(var AAvailTabOrder: Integer);
begin
  if Item.HasWinControl then
  begin
    TWinControl(Control).TabOrder := AAvailTabOrder;
    Inc(AAvailTabOrder);
  end;
end;

function TdxLayoutItemControlViewInfo.CalculateMinHeight: Integer;
begin
  if Item.ControlOptions.IsHeightFixed then
    Result := CalculateHeight
  else
    if Visible then
      Result := GetControlAreaHeight(Item.ControlOptions.MinHeight)
    else
      Result := 0;
end;

function TdxLayoutItemControlViewInfo.CalculateMinWidth: Integer;
begin
  if Item.ControlOptions.IsWidthFixed then
    Result := CalculateWidth
  else
    if Visible then
      Result := GetControlAreaWidth(Item.ControlOptions.MinWidth)
    else
      Result := 0;
end;

function TdxLayoutItemControlViewInfo.CalculateHeight: Integer;
begin
  if Visible then
    Result := GetControlAreaHeight(Item.OriginalControlSize.Y)
  else
    Result := 0;
end;

function TdxLayoutItemControlViewInfo.CalculateWidth: Integer;
begin
  if Visible then
    Result := GetControlAreaWidth(Item.OriginalControlSize.X)
  else
    Result := 0;
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

function TdxLayoutDirectionalItemViewInfo.GetOptions: TdxCustomLayoutLookAndFeelOptions;
begin
  Result := LayoutLookAndFeel.ItemOptions;
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
  Invalidate(Bounds);
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
begin
  Result := Bounds;
end;

function TdxLayoutLabeledItemViewInfo.GetContentHeight(AIsMinHeight: Boolean): Integer;
begin
  Result := CaptionViewInfo.Height;
end;

function TdxLayoutLabeledItemViewInfo.GetContentWidth(AIsMinWidth: Boolean): Integer;
begin
  if AIsMinWidth then
    Result := CaptionViewInfo.CalculateMinWidth
  else
    Result := CaptionViewInfo.Width;
end;

function TdxLayoutLabeledItemViewInfo.DoCalculateHeight(AIsMinHeight: Boolean): Integer;
begin
  Result := inherited DoCalculateHeight(AIsMinHeight) + GetContentHeight(AIsMinHeight);
end;

function TdxLayoutLabeledItemViewInfo.DoCalculateWidth(AIsMinWidth: Boolean): Integer;
begin
  Result := inherited DoCalculateWidth(AIsMinWidth) + GetContentWidth(AIsMinWidth);
end;

function TdxLayoutLabeledItemViewInfo.GetElementOffsetHorz: Integer;
begin
  Result := LayoutLookAndFeel.GetElementOffsetHorz(Item.Container);
end;

function TdxLayoutLabeledItemViewInfo.GetElementOffsetVert: Integer;
begin
  Result := LayoutLookAndFeel.GetElementOffsetVert(Item.Container);
end;

function TdxLayoutLabeledItemViewInfo.GetOptions: TdxCustomLayoutLookAndFeelOptions;
begin
  Result := LayoutLookAndFeel.ItemOptions;
end;

{ TdxLayoutItemViewInfo }

function TdxLayoutItemViewInfo.GetCaptionViewInfo: TdxLayoutItemCaptionViewInfo;
begin
  Result := inherited CaptionViewInfo as TdxLayoutItemCaptionViewInfo;
end;

function TdxLayoutItemViewInfo.GetItem: TdxLayoutItem;
begin
  Result := inherited Item as TdxLayoutItem;
end;

function TdxLayoutItemViewInfo.GetOptionsEx: TdxLayoutLookAndFeelItemOptions;
begin
  Result := inherited Options as TdxLayoutLookAndFeelItemOptions;
end;

procedure TdxLayoutItemViewInfo.DoCreateViewInfos;
begin
  inherited;
  FControlViewInfo := GetControlViewInfoClass.Create(Self);
  FElements.Add(FControlViewInfo);
end;

procedure TdxLayoutItemViewInfo.PopulateAutoAlignControlList(AList: TList);
begin
  if AutoControlAreaAlignment then
    AList.Add(Self);
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

function TdxLayoutItemViewInfo.GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass;
begin
  Result := TdxLayoutItemCaptionViewInfo;
end;

function TdxLayoutItemViewInfo.GetControlViewInfoClass: TdxLayoutItemControlViewInfoClass;
begin
  Result := TdxLayoutItemControlViewInfo;
end;

function TdxLayoutItemViewInfo.GetHitTestClass: TdxCustomLayoutItemHitTestClass;
begin
  Result := TdxLayoutItemHitTest;
end;

function TdxLayoutItemViewInfo.GetPainterClass: TdxCustomLayoutItemPainterClass;
begin
  Result := TdxCustomLayoutItemPainterClass(LayoutLookAndFeel.GetItemPainterClass);
end;

procedure TdxLayoutItemViewInfo.CalculateViewInfoBounds;

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

function TdxLayoutItemViewInfo.GetContentHeight(AIsMinHeight: Boolean): Integer;
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
end;

function TdxLayoutItemViewInfo.GetContentWidth(AIsMinWidth: Boolean): Integer;
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
end;

function TdxLayoutItemViewInfo.GetAutoControlAreaAlignment: Boolean;

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

function TdxLayoutItemViewInfo.GetCaptionLayout: TdxCaptionLayout;
begin
  Result := Item.CaptionOptions.Layout;
end;

function TdxLayoutItemViewInfo.HasControl: Boolean;
begin
  Result := Item.HasControl;
end;

procedure TdxLayoutItemViewInfo.PaintSelectionLayer;
begin
  inherited;
  if HasControl and ActuallyVisible and IsParentSelected and not Selected then
    ContainerViewInfo.SelectionLayer.SelectionImage.cxCanvas.FillRect(ControlViewInfo.Bounds, 0);
end;

function TdxLayoutItemViewInfo.PtInDesignSelectorRect(const P: TPoint): Boolean;
var
  R: TRect;
begin
  R := Item.DesignSelectorRect;
  R := cxRectOffset(R, ControlViewInfo.Bounds.TopLeft);
  Result := PtInRect(R, P);
end;

procedure TdxLayoutItemViewInfo.Calculate(const ABounds: TRect);
begin
  inherited;
  ControlViewInfo.Calculate(FControlViewInfoBounds);
end;

procedure TdxLayoutItemViewInfo.CalculateTabOrders(var AAvailTabOrder: Integer);
begin
  ControlViewInfo.CalculateTabOrder(AAvailTabOrder);
end;

{ TdxLayoutGroupCaptionViewInfo }

function TdxLayoutGroupCaptionViewInfo.GetAlignVert: TdxAlignmentVert;
begin
  Result := tavTop;
end;

function TdxLayoutGroupCaptionViewInfo.CalculateMinWidth: Integer;
begin
  Result := CalculateWidth;
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

procedure TdxLayoutGroupViewInfoSpecific.CalculateTabOrders(var ATabOrder: Integer);
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

function TdxLayoutGroupViewInfoSpecific.GetContainer: TdxCustomLayoutControl;
begin
  Result := GroupViewInfo.ContainerViewInfo.Control; 
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

procedure TdxLayoutGroupViewInfoSpecific.SetControlVisibility;
begin
// do nothing
end;

procedure TdxLayoutGroupViewInfoSpecific.AddSelectionControls;
begin
// do nothing
end;

procedure TdxLayoutGroupViewInfoSpecific.RemoveSelectionControls;
begin
// do nothing
end;

procedure TdxLayoutGroupViewInfoSpecific.DrawSpecificPart(ACanvas: TcxCanvas);
begin
// do nothing
end;

procedure TdxLayoutGroupViewInfoSpecific.DrawSpecificBackground(ACanvas: TcxCanvas);
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

function TdxLayoutGroupViewInfoSpecific.AllowDrawChild(AChild: TdxCustomLayoutItem): Boolean;
begin
  Result := True;
end;

function TdxLayoutGroupViewInfoSpecific.AllowChildHasBorder: Boolean;
begin
  Result := True;
end;

function TdxLayoutGroupViewInfoSpecific.GetDefaultItemControlAreaAlignment: TdxLayoutItemControlAreaAlignment;
begin
  if Container.AutoControlAlignment then
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
  Result := (AViewInfo.GetAlignHorz <> ahClient) or not AViewInfo.Item.IsExpanded;
end;

function TdxLayoutGroupViewInfoHorizontalSpecific.IsViewInfoFixedHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Boolean;
begin
  Result := (AViewInfo.GetAlignVert <> avClient) or not AViewInfo.Item.IsExpanded;
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
  Result := (AViewInfo.GetAlignVert <> avClient) or not AViewInfo.Item.IsExpanded;
end;

function TdxLayoutGroupViewInfoVerticalSpecific.IsViewInfoFixedHeight(AViewInfo: TdxCustomLayoutItemViewInfo): Boolean;
begin
  Result := (AViewInfo.GetAlignHorz <> ahClient) or not AViewInfo.Item.IsExpanded;
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

{ TdxLayoutTabbedGroupTabControl }

constructor TdxLayoutTabbedGroupTabControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible];
  FImages := TcxImageList.Create(nil);
  with (AOwner as TdxLayoutGroup).ViewInfo.GetMaxChildImageSize do
  begin
    FImages.Width := cx;
    FImages.Height := cy;
  end;
  Images := FImages;
end;

destructor TdxLayoutTabbedGroupTabControl.Destroy;
begin
  FreeAndNil(FImages);
  inherited Destroy;
end;

procedure TdxLayoutTabbedGroupTabControl.BoundsChanged;
var
  ARegion: TcxRegion;
begin
  inherited;

  if HandleAllocated then
  begin
    ARegion := TcxRegion.Create(Bounds);
    try
      ARegion.Combine(TcxRegion.Create(PageClientRect), roSubtract);
      SetWindowRgn(Handle, ARegion.Handle, False);
    finally
      ARegion.Free;
    end;
  end;
end;

function TdxLayoutTabbedGroupTabControl.GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean;
begin
  Result := True;
end;

procedure TdxLayoutTabbedGroupTabControl.Paint;
begin
  inherited;
  DoPaint;
end;

procedure TdxLayoutTabbedGroupTabControl.TabClick(Sender: TObject; ATabVisibleIndex: Integer; AShift: TShiftState);
begin
  inherited;

  if Assigned(OnTabClick) then
    OnTabClick(Self, ATabVisibleIndex);
end;

procedure TdxLayoutTabbedGroupTabControl.AddTab(AItem: TdxCustomLayoutItem);

  function AddImage(AGlyph: TBitmap; AImages: TCustomImageList; AImageIndex: Integer): Integer;
  var
    AAlphaBitmap: TcxAlphaBitmap;
  begin
    AAlphaBitmap := TcxAlphaBitmap.CreateSize(FImages.Width, FImages.Height);
    try
      AAlphaBitmap.Clear;
      dxDrawItemGlyph(AAlphaBitmap.cxCanvas, AItem, AAlphaBitmap.ClientRect);
      Result := FImages.Add(AAlphaBitmap, nil);
    finally
      AAlphaBitmap.Free;
    end;
  end;

var
  ATabIndex: Integer;
  AGlyph: TBitmap;
  AImages: TCustomImageList;
  AImageIndex: Integer;
begin
  if AItem.IsTextVisible then
    ATabIndex := Tabs.Add(AItem.Caption)
  else
    ATabIndex := Tabs.Add('');
  if AItem.IsImageVisible and AItem.CaptionOptions.ImageOptions.GetCurrentImage(AGlyph, AImages, AImageIndex) then
    Tabs[ATabIndex].ImageIndex := AddImage(AGlyph, AImages, AImageIndex)
  else
    Tabs[ATabIndex].ImageIndex := -1;
end;

procedure TdxLayoutTabbedGroupTabControl.DoPaint;
begin
  CallNotify(FOnPaint, Self);
end;

procedure TdxLayoutTabbedGroupTabControl.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

{ TdxTabControlElementViewInfo }

function TdxTabControlElementViewInfo.GetVisible: Boolean;
begin
  Result := not cxRectIsEmpty(Bounds);
end;

procedure TdxTabControlElementViewInfo.MouseEnter;
begin
  FTabControl.MouseEnter(nil);
end;

procedure TdxTabControlElementViewInfo.MouseLeave;
begin
  FTabControl.MouseLeave(nil);
end;

procedure TdxTabControlElementViewInfo.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FTabControl.MouseDown(Button, Shift, X - FTabControl.Left, Y - FTabControl.Top);
end;

procedure TdxTabControlElementViewInfo.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ATabIndex: Integer;
  AClientPoint: TPoint;
begin
  FTabControl.MouseMove(Shift, X - FTabControl.Left, Y - FTabControl.Top);
//  if ItemViewInfo.ContainerViewInfo.Control.DragAndDropState <> ddsNone then
  if (dxLayoutDragAndDropObject <> nil) and dxLayoutDragAndDropObject.CanDrop then
  begin
    AClientPoint := cxPointOffset(Point(X, Y), Point(FTabControl.Left, FTabControl.Top), False);
    ATabIndex := FTabControl.IndexOfTabAt(AClientPoint.X, AClientPoint.Y);
    if ATabIndex <> -1 then
      FTabControl.TabIndex := ATabIndex;
  end;
end;

procedure TdxTabControlElementViewInfo.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FTabControl.MouseUp(Button, Shift, X - FTabControl.Left, Y - FTabControl.Top);
end;

{ TdxLayoutGroupViewInfoTabbedSpecific }

procedure TdxLayoutGroupViewInfoTabbedSpecific.Calculate(const AItemsAreaBounds: TRect);
var
  ARect: TRect;
  I: Integer;
begin
  inherited;

  if HasTabControl then
  begin
    FTabControl.BoundsRect := FTabControlBounds;
    FTabControl.Parent := Container;
    FTabControl.Color := GroupViewInfo.Color;

    FTabControl.Enabled := GroupViewInfo.Group.Enabled;
    for I := 0 to GroupViewInfo.Group.VisibleCount - 1 do
      FTabControl.Tabs[I].Enabled := GroupViewInfo.Group.VisibleItems[I].Enabled;

    FTabControl.LockChangeEvent(True);
    try
      if GroupViewInfo.Group.ItemIndex >= 0 then
        FTabControl.TabIndex := GroupViewInfo.Group.Items[GroupViewInfo.Group.ItemIndex].VisibleIndex
      else
        FTabControl.TabIndex := -1;
    finally
      FTabControl.LockChangeEvent(False);
    end;

    ARect := GroupViewInfo.ClientBounds;
    ARect.Bottom := GroupViewInfo.ItemsAreaBounds.Top;
    FTabControlElementViewInfo.Calculate(ARect);
    FTabControlElementViewInfo.FTabControl := FTabControl;
  end
  else
    FTabControlElementViewInfo.Calculate(cxEmptyRect);
end;

function TdxLayoutGroupViewInfoTabbedSpecific.AllowDrawChild(AChild: TdxCustomLayoutItem): Boolean;
begin
  Result := inherited AllowDrawChild(AChild) and (AChild.Index = GroupViewInfo.Group.ItemIndex);
end;

function TdxLayoutGroupViewInfoTabbedSpecific.AllowChildHasBorder: Boolean;
begin
  Result := False;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetDefaultItemControlAreaAlignment: TdxLayoutItemControlAreaAlignment;
begin
  Result := catNone;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.ProcessDialogKey(ACharCode: Word; AKeyData: Integer; AFocusedItem: TdxLayoutItem): Boolean;
begin
  Result := GroupViewInfo.Group.IsChildItem(AFocusedItem) and FTabControl.InternalKeyDown(ACharCode, KeyDataToShiftState(AKeyData));
  if Result and not GroupViewInfo.Group.DoProcessAccel then
    FTabControl.SetFocus;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CorrectItemsAreaBounds(var AItemsAreaBounds: TRect);
begin
  FTabControlBounds := AItemsAreaBounds;
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

procedure TdxLayoutGroupViewInfoTabbedSpecific.CalculateItemsVerticalBounds(const AItemsAreaBounds: TRect);
begin
  inherited;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CalculateTabOrders(var ATabOrder: Integer);
begin
  if HasTabControl then
  begin
    FTabControl.TabOrder := ATabOrder;
    Inc(ATabOrder);
  end;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetActionType(AAreaPart: TdxLayoutAreaPart): TdxLayoutActionType;
begin
  Result := atInsert;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CorrectAreaPart(var AAreaPart: TdxLayoutAreaPart);
begin
  if AAreaPart in [apLeft, apTop] then
    AAreaPart := apBefore;
  if AAreaPart in [apRight, apBottom] then
    AAreaPart := apAfter;
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetAreaPart(const P: TPoint): TdxLayoutAreaPart;
begin
  if HasTabControl and PtInRect(FTabControl.BoundsRect, P) then
    Result := apLastChild
  else
    Result := inherited GetAreaPart(P);
end;

function TdxLayoutGroupViewInfoTabbedSpecific.GetAreaPartBounds(AAreaPart: TdxLayoutAreaPart; AItemViewInfo: TdxCustomLayoutItemViewInfo): TRect;
begin
  //#DG ToDo: refactor
  case AAreaPart of
    apBefore:
    begin
      Result := FTabControl.Tabs[FTabControl.TabIndex].VisibleRect;
      Result.Right := Result.Left;
      Result.Right := Result.Right + dxLayoutThinPartWidth;
      OffsetRect(Result, FTabControl.Left, FTabControl.Top);
    end;
    apAfter:
    begin
      Result := FTabControl.Tabs[FTabControl.TabIndex].VisibleRect;
      Result.Left := Result.Right;
      Result.Right := Result.Right + dxLayoutThinPartWidth;
      OffsetRect(Result, FTabControl.Left, FTabControl.Top);
    end;
    apLastChild:
    begin
      Result := FTabControl.Tabs[FTabControl.Tabs.Count - 1].VisibleRect;
      Result.Left := Result.Right;
      Result.Right := Result.Right + dxLayoutThinPartWidth;
      OffsetRect(Result, FTabControl.Left, FTabControl.Top);
    end;
  else
    Result := inherited GetAreaPartBounds(AAreaPart, AItemviewInfo);
  end;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.DrawSpecificPart(ACanvas: TcxCanvas);
var
  ARegion: TcxRegion;
begin
  inherited DrawSpecificPart(ACanvas);
  if HasTabControl then
  begin
    ACanvas.SaveState;
    try
      with FTabControl.BoundsRect.TopLeft do
        MoveWindowOrg(ACanvas.Handle, X, Y);
      ARegion := TcxRegion.Create;
      try
        GetWindowRgn(FTabControl.Handle, ARegion.Handle);
        ACanvas.SetClipRegion(ARegion, roIntersect, False);
      finally
        ARegion.Free;
      end;
      FTabControl.PaintTo(ACanvas.Handle, 0, 0);
    finally
      ACanvas.RestoreState;
    end;
  end;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.DrawSpecificBackground(ACanvas: TcxCanvas);
var
  P: TPoint;
  ADisplayRect, ABoundsRect: TRect;
begin
  if not HasTabControl or FSpecificPainting then
    inherited
  else
  begin
    ACanvas.SaveState;
    FSpecificPainting := True;
    try
      ABoundsRect := FTabControl.BoundsRect;
      ADisplayRect := FTabControl.PageClientRect;
      P := cxPointOffset(ADisplayRect.TopLeft, ABoundsRect.TopLeft);
      cxPaintTo(FTabControl, ACanvas, P, ADisplayRect, False);
    finally
      FSpecificPainting := False;
      ACanvas.RestoreState;
    end;
  end;
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

  // #DG !!!
  if HasTabControl then
  begin
    Inc(Result, GroupViewInfo.LayoutLookAndFeel.GetGroupBorderOffset(GroupViewInfo.Group.Container, ASide));
    case ASide of
      sdLeft: Inc(Result, FTabControl.PageClientRectOffset.Left);
      sdRight: Inc(Result, FTabControl.PageClientRectOffset.Right);
      sdTop: Inc(Result, FTabControl.PageClientRectOffset.Top);
      sdBottom: Inc(Result, FTabControl.PageClientRectOffset.Bottom);
    end;
  end;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CreateSpecificControls;
begin
  inherited CreateSpecificControls;
  CreateTabControl;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.DestroySpecificControls;
begin
  inherited DestroySpecificControls;
  DestroyTabControl;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CreateViewInfos;
begin
  FTabControlElementViewInfo := TdxTabControlElementViewInfo.Create(GroupViewInfo);
  GroupViewInfo.FElements.Add(FTabControlElementViewInfo);
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.SetControlVisibility;
begin
  if HasTabControl then
    FTabControl.Visible := GroupViewInfo.ActuallyVisible and GroupViewInfo.Group.IsExpanded;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.CreateTabControl;
var
  I: Integer;
begin
  if GroupViewInfo.Group.VisibleCount = 0 then
    Exit;
  FTabControl := TdxLayoutTabbedGroupTabControl.Create(GroupViewInfo.Group);
  FTabControl.Font := Container.Font;
  for I := 0 to GroupViewInfo.Group.VisibleCount - 1 do
    FTabControl.AddTab(GroupViewInfo.Group.VisibleItems[I]);
  GroupViewInfo.LayoutLookAndFeel.InitializeSubControlCxLookAndFeel(FTabControl.LookAndFeel);
  FTabControl.OnChange := ActiveTabChanged;
  FTabControl.OnPaint := TabControlPaint;
  FTabControl.OnTabClick := TabClick;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.DestroyTabControl;
begin
  FreeAndNil(FTabControl);
end;

function TdxLayoutGroupViewInfoTabbedSpecific.HasTabControl: Boolean;
begin
  Result := FTabControl <> nil;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.ActiveTabChanged(ASender: TObject);
var
  AContainer: TdxCustomLayoutControl;
begin
  AContainer := GroupViewInfo.Group.Container;
  GroupViewInfo.Group.ItemIndex := GroupViewInfo.Group.VisibleItems[FTabControl.TabIndex].Index;
  AContainer.Modified;
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.TabControlPaint(ASender: TObject);
begin
  if not (csPaintCopy in FTabControl.ControlState) then
    GroupViewInfo.Group.Container.PostInvalidateSelectionLayer(FTabControl.BoundsRect);
end;

procedure TdxLayoutGroupViewInfoTabbedSpecific.TabClick(ASender: TObject; ATabIndex: Integer);
begin
  GroupViewInfo.Group.VisibleItems[ATabIndex].DoCaptionClick;
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
  AExecuteClick := (levsPressed in State) and IsEnabled and not Item.Container.IsCustomization;
  inherited;
  if AExecuteClick then
    DoClick;
end;

procedure TdxLayoutGroupButtonViewInfo.DoClick;
begin
  Button.DoClick;
end;

procedure TdxLayoutGroupButtonViewInfo.StateChanged;
begin
  Invalidate(Bounds);
end;

function TdxLayoutGroupButtonViewInfo.IsHotTrackable: Boolean;
begin
  Result := True;
end;

procedure TdxLayoutGroupButtonViewInfo.ShowHint(var AHintInfo: THintInfo; out ACanShow: Boolean);
begin
  if IsEnabled then
  begin
    AHintInfo.HintData := @AHintInfo;
    AHintInfo.CursorRect := Bounds;
    AHintInfo.HintStr := GetShortHint(Button.Hint);
    ACanShow := AHintInfo.HintStr <> '';
  end
  else
    inherited;
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
  Result := ButtonsViewInfo.GroupViewInfo.Group.IsExpanded;
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

function TdxLayoutGroupButtonsViewInfo.CalculateMinHeight: Integer;
begin
  Result := CalculateHeight;
end;

function TdxLayoutGroupButtonsViewInfo.CalculateMinWidth: Integer;
begin
  Result := CalculateWidth;
end;

function TdxLayoutGroupButtonsViewInfo.CalculateWidth: Integer;
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

function TdxLayoutGroupButtonsViewInfo.GetVisible: Boolean;
begin
  Result := GroupViewInfo.HasButtons;
end;

procedure TdxLayoutGroupButtonsViewInfo.CalculateButtonViewInfos;
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
      R.Left := Bounds.Left + AOffsetX;
      R.Top := Bounds.Top + AOffsetY;
      R.Right := R.Left + ButtonViewInfos[I].Button.GetWidth;
      R.Bottom := R.Top + ButtonViewInfos[I].Button.GetHeight;
      ButtonViewInfos[I].Calculate(R);
      Inc(AOffsetX, ButtonViewInfos[I].Width + GroupViewInfo.GetSpaceBetweenButtons);
    end;
  end;
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

function TdxLayoutGroupViewInfo.GetCaptionViewInfo: TdxLayoutGroupCaptionViewInfo;
begin
  Result := TdxLayoutGroupCaptionViewInfo(inherited CaptionViewInfo);
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
      AItemViewInfo := GetItemViewInfoClass(AItem).Create(FContainerViewInfo, Self, AItem);
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
  DestroyItemViewInfos;
  DestroySpecific;
  FreeAndNil(FButtonsViewInfo);
  inherited;
end;

procedure TdxLayoutGroupViewInfo.FreeNotification(AComponent: TComponent);
begin
  inherited;
  Specific.DestroySpecificControls;
end;

procedure TdxLayoutGroupViewInfo.PopulateAutoAlignControlList(AList: TList);
var
  I: Integer;
begin
  if Group.GetRealItemControlAreaAlignment = catAuto then
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

  function GetViewInfo(AList: TList; AIndex: Integer): TdxLayoutItemViewInfo;
  begin
    Result := TObject(AList[AIndex]) as TdxLayoutItemViewInfo;
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
      AItemViewInfo: TdxLayoutItemViewInfo;
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
      AItemViewInfo: TdxLayoutItemViewInfo;
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

  if Group.GetRealItemControlAreaAlignment = catOwn then
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
  FButtonsAreaBounds := BorderBounds[sdTop];
  FButtonsAreaBounds.Bottom := FButtonsAreaBounds.Top + ButtonsViewInfo.CalculateHeight;
  FButtonsAreaBounds.Right := FButtonsAreaBounds.Right - ButtonsViewInfoOffset;
  FButtonsAreaBounds.Left := FButtonsAreaBounds.Right - ButtonsViewInfo.CalculateWidth;
end;

procedure TdxLayoutGroupViewInfo.CalculateCaptionViewInfoBounds;
var
  ACaptionWidth: Integer;
begin
  FCaptionAreaBounds := BorderBounds[sdTop];
  ACaptionWidth := CaptionViewInfo.CalculateWidth;
  with FCaptionAreaBounds do
  begin
    case Item.CaptionOptions.AlignHorz of
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
    Bottom := Top + CaptionViewInfo.GetAvailableHeight;
  end;
end;

procedure TdxLayoutGroupViewInfo.CalculateClientBounds;
begin
  FClientAreaBounds := GetClientAreaBounds(FBounds);
end;

procedure TdxLayoutGroupViewInfo.CalculateItemsAreaBounds;
begin
  FItemsAreaBounds := cxRectInflate(ClientBounds, -ItemsAreaOffsetHorz, -ItemsAreaOffsetVert);
  Specific.CorrectItemsAreaBounds(FItemsAreaBounds);
end;

procedure TdxLayoutGroupViewInfo.CalculateOffsets;
begin
  if UseItemsAreaOffsets then
    if Group.IsRoot then
    begin
      ItemsAreaOffsetHorz := LayoutLookAndFeel.GetRootItemsAreaOffsetHorz(Item.Container);
      ItemsAreaOffsetVert := LayoutLookAndFeel.GetRootItemsAreaOffsetVert(Item.Container);
    end
    else
    begin
      ItemsAreaOffsetHorz := LayoutLookAndFeel.GetItemsAreaOffsetHorz(Item.Container);
      ItemsAreaOffsetVert := LayoutLookAndFeel.GetItemsAreaOffsetVert(Item.Container);
    end
  else
  begin
    ItemsAreaOffsetHorz := 0;
    ItemsAreaOffsetVert := 0;
  end;

  if UseItemOffset then
    ItemOffset := LayoutLookAndFeel.GetItemOffset(Item.Container)
  else
    ItemOffset := 0;
end;

procedure TdxLayoutGroupViewInfo.CalculateViewInfosBounds;
var
  AOffsetY: Integer;
begin
  CalculateCaptionViewInfoBounds;
  CalculateButtonsViewInfoBounds;
  if HasButtons then
  begin
    AOffsetY := (cxRectHeight(FButtonsAreaBounds) - cxRectHeight(FCaptionAreaBounds)) div 2;
    if AOffsetY > 0 then
      FCaptionAreaBounds := cxRectOffset(FCaptionAreaBounds, 0, AOffsetY)
    else
      FButtonsAreaBounds := cxRectOffset(FButtonsAreaBounds, 0, -AOffsetY);

    if HasCaption and HasButtons and (FCaptionAreaBounds.Right > FButtonsAreaBounds.Left) then
      FCaptionAreaBounds := cxRectOffset(FCaptionAreaBounds, FCaptionAreaBounds.Right - FButtonsAreaBounds.Left, 0, False);
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
  ATextHeight: Integer;
begin
  if HasBorder then
  begin
    Result := LayoutLookAndFeel.GetGroupBorderWidth(Item.Container, ASide, HasCaption or HasButtons, Group.IsExpanded);
    if (ASide = sdTop) and (HasCaption or HasButtons) then
    begin
      ATextHeight := CaptionViewInfo.GetAvailableTextHeight;
      Inc(Result, Max(ATextHeight, CaptionViewInfo.ImageHeight) - ATextHeight);
      ACaptionHeight := CaptionViewInfo.GetAvailableHeight;
      Inc(Result, Max(ACaptionHeight, ButtonsViewInfo.CalculateHeight) - ACaptionHeight);
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
  Result := dxLayoutItemMinSize;
end;

function TdxLayoutGroupViewInfo.GetMinVisibleWidth: Integer;
begin
  if HasCaption then
    Result := CaptionViewInfo.CalculateMinWidth
  else
    Result := 0;
  if HasButtons then
    Inc(Result, ButtonsViewInfo.CalculateMinWidth);
  Result := Max(Result, dxLayoutItemMinSize);
end;

function TdxLayoutGroupViewInfo.GetOptions: TdxCustomLayoutLookAndFeelOptions;
begin
  Result := LayoutLookAndFeel.GroupOptions;
end;

function TdxLayoutGroupViewInfo.GetRestSpaceBounds: TRect;
begin
  Result := Bounds;
end;

function TdxLayoutGroupViewInfo.AllowChildHasBorder: Boolean;
begin
  Result := Specific.AllowChildHasBorder;
end;

function TdxLayoutGroupViewInfo.AllowCollapsedHeight: Boolean;
begin
  Result := not Group.IsExpanded and
    ((ParentViewInfo = nil) or (ParentViewInfo.LayoutDirection = ldVertical));
end;

function TdxLayoutGroupViewInfo.AllowCollapsedWidth: Boolean;
begin
  Result := not Group.IsExpanded and
    ((ParentViewInfo = nil) or (ParentViewInfo.LayoutDirection = ldHorizontal));
end;

function TdxLayoutGroupViewInfo.GetSpecificClass: TdxLayoutGroupViewInfoSpecificClass;
begin
  Result := Group.GetHelperClass.GetSpecificClass;
end;

procedure TdxLayoutGroupViewInfo.PaintSelectionLayer;
var
  I: Integer;
begin
  inherited;
  for I := 0 to ItemViewInfoCount - 1 do
    ItemViewInfos[I].PaintSelectionLayer;
end;

function TdxLayoutGroupViewInfo.GetHeight(AItemsAreaHeight: Integer): Integer;
begin
  Result := Max(MinVisibleHeight, BorderWidths[sdTop] + BorderWidths[sdBottom] +
    IfThen(AllowCollapsedHeight, 0, ItemsAreaOffsetVert + Specific.GetItemsAreaOffset(sdTop) + AItemsAreaHeight +
    ItemsAreaOffsetVert + Specific.GetItemsAreaOffset(sdBottom)));
end;

function TdxLayoutGroupViewInfo.GetWidth(AItemsAreaWidth: Integer): Integer;
begin
  Result := Max(MinVisibleWidth, BorderWidths[sdLeft] + BorderWidths[sdRight] +
    IfThen(AllowCollapsedWidth, 0, ItemsAreaOffsetHorz + Specific.GetItemsAreaOffset(sdLeft) +
    AItemsAreaWidth + ItemsAreaOffsetHorz + Specific.GetItemsAreaOffset(sdRight)));
end;

function TdxLayoutGroupViewInfo.GetMaxChildImageSize: TSize;
var
  I: Integer;
begin
  Result := cxNullSize;
  for I := 0 to Group.VisibleCount - 1 do
    with Group.VisibleItems[I].CaptionOptions.ImageOptions.GetImageSize do
    begin
      Result.cx := Max(Result.cx, cx);
      Result.cy := Max(Result.cy, cy);
    end;
end;

function TdxLayoutGroupViewInfo.HasBoundsFrame: Boolean;
begin
  Result := Group.IsRoot and (Group.Container.ShowHiddenGroupsBounds or Group.Container.IsDesigning);
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

procedure TdxLayoutGroupViewInfo.CalculateTabOrders(var AAvailTabOrder: Integer);
var
  I: Integer;
begin
  Specific.CalculateTabOrders(AAvailTabOrder);
  for I := 0 to ItemViewInfoCount - 1 do
    ItemViewInfos[I].CalculateTabOrders(AAvailTabOrder);
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

{ TdxLayoutControlViewInfo }

constructor TdxLayoutControlViewInfo.Create(AControl: TdxCustomLayoutControl);
begin
  inherited;
  CreateViewInfos;
end;

destructor TdxLayoutControlViewInfo.Destroy;
begin
  DestroyViewInfos;
  FCanvas.Free;
  FreeAndNil(FSelectionLayer);
  inherited;
end;

procedure TdxLayoutControlViewInfo.CreateSelectionLayer;
begin
  FSelectionLayer := TdxSelectionLayer.Create(nil);
  FSelectionLayer.ParentControl := Control;
  FSelectionLayer.OnShow := SelectionLayerShow;
  TdxSelectionLayerAccess(FSelectionLayer).OnHitTest := SelectionLayerHitTest;
end;

procedure TdxLayoutControlViewInfo.BuildSelectionLayer;

  function CanBuildSelectionLayer: Boolean;
  var
    I: Integer;
    AList: TcxObjectList;
    AIntf: IdxLayoutSelectableItem;
  begin
    Result := Control.Customization and not Control.IsUpdateLocked;
    if not Result and Control.IsDesigning then
    begin
      AList := TcxObjectList.Create(False);
      try
        Control.GetSelection(AList);
        for I := 0 to AList.Count - 1 do
        begin
          if Supports(AList[I], IdxLayoutSelectableItem, AIntf) and AIntf.IsOwner(Control) then
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
    ItemsViewInfo.PaintSelectionLayer;
    SelectionLayer.SelectionImage.RecoverAlphaChannel(0);
    SelectionLayer.Show;
  end
  else
    FreeAndNil(FSelectionLayer);
end;

function TdxLayoutControlViewInfo.GetClientHeight: Integer;
begin
  Result := cxRectHeight(ClientBounds);
end;

function TdxLayoutControlViewInfo.GetClientWidth: Integer;
begin
  Result := cxRectWidth(ClientBounds);
end;

function TdxLayoutControlViewInfo.GetContentHeight: Integer;
begin
  Result := cxRectHeight(ContentBounds);
end;

function TdxLayoutControlViewInfo.GetContentWidth: Integer;
begin
  Result := cxRectWidth(ContentBounds);
end;

function TdxLayoutControlViewInfo.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := FControl.GetLayoutLookAndFeel;
end;

function TdxLayoutControlViewInfo.GetSelectionLayer: TdxSelectionLayer;
begin
  if FSelectionLayer = nil then
    CreateSelectionLayer;
  Result := FSelectionLayer;
end;

procedure TdxLayoutControlViewInfo.SelectionLayerHitTest(ASender: TObject; var AIsTransparent: Boolean);
begin
  AIsTransparent := not Control.Customization;
end;

procedure TdxLayoutControlViewInfo.SelectionLayerShow(Sender: TObject);
var
  ATopMost: Boolean;
  I: Integer;
  AList: TcxObjectList;
  AIntf: IdxLayoutSelectableItem;
begin
  ATopMost := not Control.IsDesigning;
  if not ATopMost then
  begin
    ATopMost := False;
    AList := TcxObjectList.Create(False);
    try
      Control.GetSelection(AList);
      for I := 0 to AList.Count - 1 do
      begin
        if Supports(AList[I], IdxLayoutSelectableItem, AIntf) and AIntf.IsOwner(Control) then
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
    SelectionLayer.BringToFront;
end;

procedure TdxLayoutControlViewInfo.CreateViewInfos;
begin
  if LayoutLookAndFeel <> nil then
    FItemsViewInfo := GetItemsViewInfoClass.Create(Self, nil, FControl.Items);
end;

procedure TdxLayoutControlViewInfo.DestroyViewInfos;
begin
  FreeAndNil(FItemsViewInfo);
end;

function TdxLayoutControlViewInfo.GetItemsViewInfoClass: TdxLayoutGroupViewInfoClass;
begin
  Result := TdxLayoutGroupViewInfoClass(FControl.Items.GetViewInfoClass);
end;

procedure TdxLayoutControlViewInfo.RecreateViewInfos;
begin
  DestroyViewInfos;
  CreateViewInfos;
end;

procedure TdxLayoutControlViewInfo.AlignItemsByConstraint;
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
  for I := 0 to FControl.AlignmentConstraintCount - 1 do
    ProcessConstraint(FControl.AlignmentConstraints[I]);
end;

procedure TdxLayoutControlViewInfo.AutoAlignControls;
begin
  ItemsViewInfo.AutoAlignControls;
end;

procedure TdxLayoutControlViewInfo.CalculateItemsViewInfo;
begin
  ResetContentBounds;
  ItemsViewInfo.Calculate(ContentBounds);
end;

procedure TdxLayoutControlViewInfo.CalculateTabOrders;
var
  AAvailTabOrder: Integer;
begin
  AAvailTabOrder := 0;
  ItemsViewInfo.CalculateTabOrders(AAvailTabOrder);
end;

function TdxLayoutControlViewInfo.GetIsTransparent: Boolean;
begin
  Result := HasBackground;
end;

function TdxLayoutControlViewInfo.HasBackground: Boolean;
begin
  Result := Control.HasBackground;
end;

function TdxLayoutControlViewInfo.NeedHighlightRoot: Boolean;
begin
  Result := Control.HighlightRoot and Control.IsDesigning;
end;

procedure TdxLayoutControlViewInfo.PrepareData;
begin
  RecreateViewInfos;
end;

procedure TdxLayoutControlViewInfo.ResetContentBounds;
begin
  SetRectEmpty(FContentBounds);
end;

function TdxLayoutControlViewInfo.GetCanvas: TcxCanvas;
begin
  if Control.HandleAllocated then
  begin
    FreeAndNil(FCanvas);
    Result := Control.Canvas;
  end
  else
  begin
    if FCanvas = nil then
      FCanvas := TcxScreenCanvas.Create;
    Result := FCanvas;
  end;
end;

function TdxLayoutControlViewInfo.GetClientBounds: TRect;
begin
  Result := FControl.ClientBounds;
end;

function TdxLayoutControlViewInfo.GetContentBounds: TRect;

  function CalculateContentWidth: Integer;
  begin
//#DG    if acsWidth in Control.AutoContentSizes then
    if ItemsViewInfo.AlignHorz = ahClient then
      Result := Max(cxRectWidth(ClientBounds), ItemsViewInfo.MinWidth)
    else
      Result := ItemsViewInfo.CalculateWidth;
  end;

  function CalculateContentHeight: Integer;
  begin
//#DG    if acsHeight in Control.AutoContentSizes then
    if ItemsViewInfo.AlignVert = avClient then
      Result := Max(cxRectHeight(ClientBounds), ItemsViewInfo.MinHeight)
    else
      Result := ItemsViewInfo.CalculateHeight;
  end;

begin
  if IsRectEmpty(FContentBounds) then
    FContentBounds := cxRectBounds(-Control.LeftPos, -Control.TopPos, CalculateContentWidth, CalculateContentHeight);
  Result := FContentBounds;
end;

procedure TdxLayoutControlViewInfo.Calculate;
begin
  PrepareData;

  CalculateItemsViewInfo;
  AlignItemsByConstraint;
  AutoAlignControls;
  CalculateItemsViewInfo;

  DoCalculateTabOrders;
  Control.PlaceControls;
end;

procedure TdxLayoutControlViewInfo.DoCalculateTabOrders;
begin
  if Control.AutoControlTabOrders then
    CalculateTabOrders;
end;

function TdxLayoutControlViewInfo.GetHitTest(const P: TPoint): TdxCustomLayoutHitTest;

  function IsCustomizeFormHitTest(var AHitCustomizeForm: TdxLayoutControlCustomCustomizeForm): Boolean;

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

    function Check(AControl: TWinControl): Boolean;
    begin
      Result := (AControl <> nil) and (AControl is TdxLayoutControlCustomCustomizeForm);
      if Result then
      begin
        AHitCustomizeForm := AControl as TdxLayoutControlCustomCustomizeForm;
        if not Control.IsDesigning then
          Result := Control = AHitCustomizeForm.Control;
      end;
    end;

  var
    AWnd: HWND;
    AControl: TWinControl;
  begin
    AWnd := cxWindowFromPoint(Control.ClientToScreen(P));
    AControl := FindControl(AWnd);
    Result := Check(AControl) or Check(InternalGetParentForm(AControl));
  end;

var
  ACustomizeForm: TdxLayoutControlCustomCustomizeForm;
begin
  if IsCustomizeFormHitTest(ACustomizeForm) then
    Result := ACustomizeForm.GetHitTest(ACustomizeForm.ScreenToClient(Control.ClientToScreen(P)))
  else
  begin
    if IsWindowVisible(Control.Handle) and PtInRect(ClientBounds, P) and not (Control.ShowDesignSelectors and PtInRect(Control.GetDesignSelectorRect, P)) then
    begin
      Result := ItemsViewInfo.GetHitTest(P);
      if Result = nil then
      begin
        Result := TdxLayoutClientAreaHitTest.Instance;
        TdxLayoutClientAreaHitTest(Result).Control := Control;
      end;
    end
    else
      Result := nil;
  end;
  if Result = nil then
    Result := TdxLayoutNoneHitTest.Instance;
end;

function TdxLayoutControlViewInfo.GetHitTest(X, Y: Integer): TdxCustomLayoutHitTest;
begin
  Result := GetHitTest(Point(X, Y));
end;

function TdxLayoutControlViewInfo.GetItemWithMouse(const P: TPoint): TdxCustomLayoutItem;
begin
  Result := ItemsViewInfo.GetItemWithMouse(P);
end;

initialization
  RegisterClasses([TdxLayoutItem, TdxLayoutEmptySpaceItem, TdxLayoutLabeledItem,
    TdxLayoutSeparatorItem, TdxLayoutSplitterItem, TdxLayoutAlignmentConstraint,
    TdxLayoutGroup]);

  HitTests := THitTests.Create;

  dxLayoutRunTimeSelectionHelperClass := TdxLayoutRunTimeSelectionHelper;

finalization
  FreeAndNil(HitTests);
  FreeAndNil(FDesignCustomizationHelper);

end.
