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

unit cxGridLayoutView;

{$I cxVer.inc}

interface

uses
  Variants, Windows, Classes, Graphics, Controls, Contnrs, ImgList, cxClasses,
  cxGraphics, cxControls, cxStyles, cxLookAndFeelPainters, cxGridCommon, cxGrid,
  cxGridCustomView, cxGridCustomTableView, dxLayoutLookAndFeels, cxDataStorage,
  cxCustomData, cxEdit, dxLayoutContainer, cxGridCustomLayoutView, dxLayoutSelection,
  dxLayoutCommon, Forms, cxNavigator;

const
  cxGridLayoutViewCustomizationFormDefaultWidth  = 600;
  cxGridLayoutViewCustomizationFormDefaultHeight = 500;

  htLayoutViewBase = htCustomGridTableBase + 70;
  htLayoutViewItemIndent = htLayoutViewBase + 1;
  htLayoutViewItemExpandButton = htLayoutViewBase + 2;
  htLayoutViewItem = htLayoutViewBase + 3;
  htLayoutViewItemFilterButton = htLayoutViewBase + 4;
  htLayoutViewRecordCaption = htLayoutViewBase + 5;
  htLayoutViewRecordScrollButtonUp = htLayoutViewBase + 6;
  htLayoutViewRecordScrollButtonDown = htLayoutViewBase + 7;
  htLayoutViewRecordSeparator = htLayoutViewBase + 8;

  vsLayoutViewFirst = vsCustomTableLast + 1;
  vsGroup = vsLayoutViewFirst;
  vsItem = vsLayoutViewFirst + 1;
  vsRecordBorder = vsLayoutViewFirst + 2;
  vsRecordCaption = vsLayoutViewFirst + 3;

  cxGridLayoutViewDefaultRecordBorderWidth = 0;
  cxGridLayoutViewDefaultMinValueWidth = 80;
  cxGridLayoutViewRecordExpandButtonOffset = 5;
  cxGridLayoutViewRecordCaptionDefaultMask = cxNavigatorInfoPanelDefaultDisplayMask;

type
  TcxGridLayoutItem = class;
  TcxGridLayoutView = class;
  TcxGridLayoutViewItem = class;
  TcxGridLayoutViewController = class;
  TcxGridLayoutViewRecord = class;

  { View Infos }

  TcxGridCustomLayoutContainerViewInfo = class;
  TcxGridLayoutContainerViewInfo = class;
  TcxGridLayoutItemViewInfo = class;
  TcxGridLayoutItemEditViewInfo = class;
  TcxGridLayoutViewViewInfo = class;
  TcxGridLayoutViewRecordViewInfo = class;
  TcxGridLayoutViewRecordsViewInfo = class;

  TcxGridLayoutViewItemDataCellViewInfo = class;
  TcxGridLayoutViewItemFilterButtonViewInfo = class;
  TcxGridLayoutViewItemViewInfo = class;
  TcxGridLayoutViewRecordCaptionViewInfo = class;

  TcxGridLayoutItemEditPainter = class;
  TcxGridLayoutItemEditPainterClass = class of TcxGridLayoutItemEditPainter;
  TcxGridLayoutViewRecordExpandButtonViewInfo = class;

  TcxGridLayoutContainer = class;
  TcxGridLayoutViewOptionsView = class;

  ///////////////////////////////// Layout classes ////////////////////////////////////////

  { TcxGridViewLayoutItemCaptionPainter }

  TcxGridViewLayoutItemCaptionPainter = class(TdxCustomLayoutItemCaptionPainter)
  protected
    procedure DrawBackground; override;
  end;

  { TcxGridLayoutItemEditPainter}

  TcxGridLayoutItemEditPainter = class(TdxLayoutControlItemControlPainter)
  private
    function GetViewInfo: TcxGridLayoutItemEditViewInfo;
  protected
    function CanDrawEdit: Boolean; virtual;
    procedure DoDrawEdit; virtual;
    procedure DrawEdit;
  public
    procedure Paint; override;
    property ViewInfo: TcxGridLayoutItemEditViewInfo read GetViewInfo;
  end;

  { TcxGridLayoutItemPainter }

  TcxGridLayoutItemPainter = class(TdxLayoutControlItemPainter)
  private
    function GetViewInfo: TcxGridLayoutItemViewInfo;
    function GetGridItemViewInfo: TcxGridLayoutViewItemViewInfo;
  protected
    function CanPaint: Boolean; override;
    function GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass; override;
    function GetControlPainterClass: TdxLayoutControlItemControlPainterClass; override;

    property GridItemViewInfo: TcxGridLayoutViewItemViewInfo read GetGridItemViewInfo;
    property ViewInfo: TcxGridLayoutItemViewInfo read GetViewInfo;
  end;

  { TcxGridLayoutItemEditViewInfo }

  TcxGridLayoutItemEditViewInfo = class(TdxLayoutControlItemControlViewInfo)
  private
    FDataHeight: Integer;
    function GetDataViewInfo: TcxGridLayoutViewItemDataCellViewInfo;
    function GetItem: TcxGridLayoutItem;
    function GetItemViewInfo: TcxGridLayoutItemViewInfo;
    function GetGridView: TcxGridLayoutView;
  protected
    function GetDefaultValueHeight: Integer;
    function GetValueHeight: Integer;
    function GetOriginalControlSize: TSize; override;
    function HasBorder: Boolean; override;

    property DataViewInfo: TcxGridLayoutViewItemDataCellViewInfo read GetDataViewInfo;
    property GridView: TcxGridLayoutView read GetGridView;
    property ItemViewInfo: TcxGridLayoutItemViewInfo read GetItemViewInfo;
    property Item: TcxGridLayoutItem read GetItem;
  public
    function CalculateMinHeight: Integer; override;
    function CalculateMinWidth: Integer; override;
    procedure CalculateInternalTabOrder(var AAvailTabOrder: Integer); override;
  end;

  { TcxGridLayoutItemCaptionViewInfo }

  TcxGridLayoutItemCaptionViewInfo = class(TdxLayoutControlItemCaptionViewInfo)
  private
    function GetItem: TcxGridLayoutItem;
    function GetItemViewInfo: TcxGridLayoutItemViewInfo;
  protected
    function GetPadding: TRect; override;
    property Item: TcxGridLayoutItem read GetItem;
    property ItemViewInfo: TcxGridLayoutItemViewInfo read GetItemViewInfo;
  end;

  { TcxGridLayoutItemViewInfo }

  TcxGridLayoutItemViewInfo = class(TdxLayoutControlItemViewInfo)
  private
    FGridItemViewInfo: TcxGridLayoutViewItemViewInfo;
    function GetControlViewInfo: TcxGridLayoutItemEditViewInfo;
    function GetItem: TcxGridLayoutItem;
    function GetContainerViewInfo: TcxGridCustomLayoutContainerViewInfo;
    function GetGridItemViewInfo: TcxGridLayoutViewItemViewInfo;
  protected
    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
    function GetControlViewInfoClass: TdxLayoutControlItemControlViewInfoClass; override;
    function GetPainterClass: TdxCustomLayoutItemPainterClass; override;
    procedure SetGridItemViewInfo;

    property GridItemViewInfo: TcxGridLayoutViewItemViewInfo read GetGridItemViewInfo;
    property Item: TcxGridLayoutItem read GetItem;
  public
    property ContainerViewInfo: TcxGridCustomLayoutContainerViewInfo read GetContainerViewInfo;
    property ControlViewInfo: TcxGridLayoutItemEditViewInfo read GetControlViewInfo;
  end;

  { TcxGridLayoutItemCaptionOptions }

  TcxGridLayoutItemCaptionOptions = class(TdxLayoutItemCaptionOptions)
  private
    FGridItemCaption: string;
    function GetItem: TcxGridLayoutItem;
  protected
    function IsTextStored: Boolean; override;
    function GetText: string; override;
    procedure SetText(const Value: string); override;

    property GridItemCaption: string read FGridItemCaption write FGridItemCaption;
    property Item: TcxGridLayoutItem read GetItem;
  end;

  { TcxGridLayoutItem }

  TcxGridLayoutItem = class(TdxLayoutControlItem)
  private
    FGridViewItem: TcxGridLayoutViewItem;
    function GetCaptionOptions: TcxGridLayoutItemCaptionOptions;
    function GetViewInfo: TcxGridLayoutItemViewInfo;
    procedure SetCaptionOptions(Value: TcxGridLayoutItemCaptionOptions);
    procedure SetGridViewItem(Value: TcxGridLayoutViewItem);
  protected
    function CanDelete: Boolean; override;
    procedure CustomizationChanged; override;
    class function GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass; override;
    function GetBaseName: string; override;
    function GetInplaceRenameCaption: string; override;
    function GetViewInfoClass: TdxCustomLayoutItemViewInfoClass; override;
    function HasControl: Boolean; override;
    function IsVisibleForCustomization: Boolean; override;
    procedure SetInplaceRenameCaption(const ACaption: string); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure BeforeDestruction; override;

    property GridViewItem: TcxGridLayoutViewItem read FGridViewItem write SetGridViewItem;
    property ViewInfo: TcxGridLayoutItemViewInfo read GetViewInfo;
  published
    property CaptionOptions: TcxGridLayoutItemCaptionOptions read GetCaptionOptions write SetCaptionOptions;
  end;

  { TcxGridLayoutLookAndFeel }

  TcxGridLayoutLookAndFeel = class(TdxLayoutCxLookAndFeel)
  private
    FGridView: TcxGridLayoutView;
  public
    constructor Create(AGridView: TcxGridLayoutView); reintroduce; virtual;

    property GridView: TcxGridLayoutView read FGridView;
  end;

  { TcxGridCustomLayoutContainerViewInfo }

  TcxGridCustomLayoutContainerViewInfo = class(TdxLayoutContainerViewInfo)
  protected
    function GetGridItemViewInfo(AViewInfo: TcxGridLayoutItemViewInfo): TcxGridLayoutViewItemViewInfo; virtual;
    procedure PopulateTabOrderList(AList: TList);
  end;

  { TcxGridLayoutContainerViewInfo }

  TcxGridLayoutContainerViewInfo = class(TcxGridCustomLayoutContainerViewInfo)
  private
    FRecordViewInfo: TcxGridLayoutViewRecordViewInfo;
  protected
    function GetGridItemViewInfo(AViewInfo: TcxGridLayoutItemViewInfo): TcxGridLayoutViewItemViewInfo; override;
    function IsClone: Boolean; override;
  public
    constructor Create(ARecordViewInfo: TcxGridLayoutViewRecordViewInfo); reintroduce; virtual;

    property RecordViewInfo: TcxGridLayoutViewRecordViewInfo read FRecordViewInfo;
  end;

  { TcxGridLayoutContainerFocusedController }

  TcxGridLayoutContainerFocusedController = class(TdxLayoutContainerFocusedController)
  protected
    function IsFocused(AItem: TdxCustomLayoutItem): Boolean; override;
  end;

  { TcxGridLayoutContainer }

  TcxGridLayoutContainer = class(TdxLayoutContainer)
  private
    function GetGridView: TcxGridLayoutView;
    function GetViewInfo: TcxGridLayoutContainerViewInfo;
  protected
    procedure DoCalculateRoot(ANeedPack: Boolean); override;
    function GetFocusedControllerClass: TdxLayoutContainerFocusedControllerClass; override;
    function GetViewInfoClass: TdxLayoutContainerViewInfoClass; override;
    function IsCustomization: Boolean; override;

    property GridView: TcxGridLayoutView read GetGridView;
    property ViewInfo: TcxGridLayoutContainerViewInfo read GetViewInfo;
  end;

  TcxGridLayoutContainerClass = class of TcxGridLayoutContainer;

  ///////////////////////////////// Grid classes ////////////////////////////////////////

  TcxGridLayoutViewRecordExpandButtonAlignment = (rebaLeft, rebaRight);

  { hit tests }

  TcxGridLayoutViewItemFilterButtonHitTest = class(TcxGridRecordCellHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function CanClick: Boolean; override;
  end;

  TcxGridLayoutViewItemHitTest = class(TcxGridRecordCellHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridLayoutViewRecordCaptionHitTest = class(TcxGridRecordHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

{
  TcxGridLayoutViewRecordScrollButtonDownHitTest = class(TcxGridRecordHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function CanClick: Boolean; override;
  end;

  TcxGridLayoutViewRecordScrollButtonUpHitTest = class(TcxGridRecordHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function CanClick: Boolean; override;
  end;
}

  { Painters }

  TcxGridLayoutViewItemFilterButtonPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridLayoutViewItemFilterButtonViewInfo;
  protected
    procedure Paint; override;
    property ViewInfo: TcxGridLayoutViewItemFilterButtonViewInfo read GetViewInfo;
  end;

  { TcxGridLayoutViewItemDataCellPainter }

  TcxGridLayoutViewItemDataCellPainter = class(TcxGridTableDataCellPainter)
  private
    function GetViewInfo: TcxGridLayoutViewItemDataCellViewInfo;
  public
    property ViewInfo: TcxGridLayoutViewItemDataCellViewInfo read GetViewInfo;
  end;

  { TcxGridLayoutViewItemPainter }

  TcxGridLayoutViewItemPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridLayoutViewItemViewInfo;
  protected
    procedure AfterPaint; override;
    procedure DrawBackground; override;
    procedure DrawContent; override;
    procedure DrawLayoutItemSelector; virtual;
    procedure DrawText; override;
  public
    procedure DrawFocusRect;

    property ViewInfo: TcxGridLayoutViewItemViewInfo read GetViewInfo;
  end;

  { TcxGridLayoutViewRecordExpandButtonPainter }

  TcxGridLayoutViewRecordExpandButtonPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridLayoutViewRecordExpandButtonViewInfo;
  protected
    procedure Paint; override;

    property ViewInfo: TcxGridLayoutViewRecordExpandButtonViewInfo read GetViewInfo;
  end;

  { TcxGridLayoutViewRecordCaptionPainter }

  TcxGridLayoutViewRecordCaptionPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridLayoutViewRecordCaptionViewInfo;
  protected
    procedure DrawBackground; override;
    procedure DrawText; override;
    function GetState: TcxButtonState; virtual;

    property ViewInfo: TcxGridLayoutViewRecordCaptionViewInfo read GetViewInfo;
  end;

  { TcxGridLayoutViewRecordPainter }

  TcxGridLayoutViewRecordPainter = class(TcxCustomGridRecordPainter)
  private
    FClipRegion: TcxRegion;
    function GetViewInfo: TcxGridLayoutViewRecordViewInfo;
  protected
    procedure AfterPaint; override;
    procedure BeforePaint; override;
    procedure DrawBackground; override;
    procedure DrawLayoutGroups; virtual;
    procedure DrawRecordBorder; virtual;
    procedure DrawRecordCaption; virtual;
    procedure DrawExpandButton; override;
    function DrawExpandButtonBeforePaint: Boolean; override;
    procedure DrawItems; virtual;
    function GetState: TcxButtonState; virtual;
    function IsRecordExpanded: Boolean;
    procedure Paint; override;

    property ViewInfo: TcxGridLayoutViewRecordViewInfo read GetViewInfo;
  end;

  TcxGridLayoutViewPainter = class(TcxGridCustomLayoutViewPainter);

  { TcxGridLayoutViewViewData }

  TcxGridLayoutViewViewData = class(TcxGridCustomLayoutViewViewData)
  protected
    function GetRecordClass(ARecordInfo: TcxRowInfo): TcxCustomGridRecordClass; override;
  end;

  { View Infos }

  { TcxGridLayoutViewItemFilterButtonViewInfo }

  TcxGridLayoutViewItemFilterButtonViewInfo = class(TcxCustomGridViewCellViewInfo,
    IcxGridFilterPopupOwner)
  private
    FItemViewInfo: TcxGridLayoutViewItemViewInfo;
    function GetActive: Boolean;
    function GetDropDownWindowValue: TcxGridFilterPopup;
  protected
    { IcxGridFilterPopupOwner }
    function GetItem: TcxCustomGridTableItem;

    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetVisible: Boolean; override;
    function GetWidth: Integer; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    function NeedsContainerHotTrack: Boolean; virtual;
    function OccupiesSpace: Boolean; virtual;
    function CloseDropDownWindowOnDestruction: Boolean; override;
    function DropDownWindowExists: Boolean; override;
    function GetDropDownWindow: TcxCustomGridPopup; override;
    function GetDropDownWindowOwnerBounds: TRect; override;
    function IsDropDownWindowOwner: Boolean; override;

    property DropDownWindow: TcxGridFilterPopup read GetDropDownWindowValue;
    property ItemViewInfo: TcxGridLayoutViewItemViewInfo read FItemViewInfo;
  public
    constructor Create(ALayoutViewItemViewInfo: TcxGridLayoutViewItemViewInfo); reintroduce; virtual;
    property Active: Boolean read GetActive;
  end;

  TcxGridLayoutViewItemFilterButtonViewInfoClass = class of TcxGridLayoutViewItemFilterButtonViewInfo;

  { TcxGridLayoutViewItemCellViewInfo }

  TcxGridLayoutViewItemCellViewInfo = class(TcxGridTableDataCellViewInfo)
  private
    FItem: TcxGridLayoutViewItem;
    FRecordViewInfo: TcxGridLayoutViewRecordViewInfo;
    function GetGridView: TcxGridLayoutView;
    function GetGridRecord: TcxGridLayoutViewRecord;
  protected
    function GetIsDesignSelected: Boolean; override;
    function IsInLayoutItemSelector(const APos: TPoint): Boolean; virtual;
  public
    constructor Create(ARecordViewInfo: TcxGridLayoutViewRecordViewInfo; AItem: TcxGridLayoutViewItem); reintroduce; virtual;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;

    property GridRecord: TcxGridLayoutViewRecord read GetGridRecord;
    property GridView: TcxGridLayoutView read GetGridView;
    property Item: TcxGridLayoutViewItem read FItem;
  end;

  { TcxGridLayoutViewItemDataCellViewInfo }

  TcxGridLayoutViewItemDataCellViewInfo = class(TcxGridLayoutViewItemCellViewInfo)
  private
    FItemViewInfo: TcxGridLayoutViewItemViewInfo;
  protected
    function GetHotTrack: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetTransparent: Boolean; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function HasFocusRect: Boolean; override;
    function IsInLayoutItemSelector(const APos: TPoint): Boolean; override;
    procedure StateChanged(APrevState: TcxGridCellState); override;

    property ItemViewInfo: TcxGridLayoutViewItemViewInfo read FItemViewInfo;
  public
    constructor Create(ALayoutViewItemViewInfo: TcxGridLayoutViewItemViewInfo); reintroduce; virtual;
  end;

  TcxGridLayoutViewItemDataCellViewInfoClass = class of TcxGridLayoutViewItemDataCellViewInfo;

  { TcxGridLayoutViewItemViewInfo }

  TcxGridLayoutViewItemViewInfo = class(TcxGridLayoutViewItemCellViewInfo)
  private
    FDataViewInfo: TcxGridLayoutViewItemDataCellViewInfo;
    FFilterButtonViewInfo: TcxGridLayoutViewItemFilterButtonViewInfo;
    FLayoutItemSelectorBounds: TRect;
    FLayoutItemViewInfo: TcxGridLayoutItemViewInfo;
    function GetLayoutItemViewInfo: TcxGridLayoutItemViewInfo;
    function GetRecordViewInfo: TcxGridLayoutViewRecordViewInfo;
    procedure CreateViewInfos;
    procedure DestroyViewInfos;
  protected
    function CanShowEdit: Boolean; override;
    class function GetDataViewInfoClass: TcxGridLayoutViewItemDataCellViewInfoClass; virtual;
    function GetDesignSelectionBounds: TRect; override;
    function GetExtraCaptionPadding: Integer; virtual;
    function GetFilterButtonBounds: TRect; virtual;
    function GetFilterButtonViewInfoClass: TcxGridLayoutViewItemFilterButtonViewInfoClass; virtual;
    function GetFocused: Boolean; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetPaintState: TcxButtonState; virtual;
    function GetIsDesignSelected: Boolean; override;
    function GetIsLayoutItemSelected: Boolean; virtual;
    function GetLayoutItemSelectorBounds(const ABounds: TRect): TRect; virtual;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetTransparent: Boolean; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function HasFocusRect: Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    function IsInLayoutItemSelector(const APos: TPoint): Boolean; override;
    function GetEditMinSize(AFont: TFont): TSize; virtual;
    procedure StateChanged(APrevState: TcxGridCellState); override;

    function CanFocus: Boolean; virtual;

    property DataViewInfo: TcxGridLayoutViewItemDataCellViewInfo read FDataViewInfo;
    property FilterButtonBounds: TRect read GetFilterButtonBounds;
    property LayoutItemViewInfo: TcxGridLayoutItemViewInfo read GetLayoutItemViewInfo;
  public
    constructor Create(ARecordViewInfo: TcxGridLayoutViewRecordViewInfo; AItem: TcxGridLayoutViewItem); override;
    destructor Destroy; override;
    procedure Calculate(const ABounds: TRect); override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;

    property FilterButtonViewInfo: TcxGridLayoutViewItemFilterButtonViewInfo read FFilterButtonViewInfo;
    property LayoutItemSelectorBounds: TRect read FLayoutItemSelectorBounds;
    property RecordViewInfo: TcxGridLayoutViewRecordViewInfo read GetRecordViewInfo;
  end;

  TcxGridLayoutViewItemViewInfoClass = class of TcxGridLayoutViewItemViewInfo;

  { TcxGridLayoutViewRecordExpandButtonViewInfo }

  TcxGridLayoutViewRecordExpandButtonViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FRecordViewInfo: TcxGridLayoutViewRecordViewInfo;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function CaptureMouseOnPress: Boolean; override;
    procedure Click; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetVisible: Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
  public
    constructor Create(ARecordViewInfo: TcxGridLayoutViewRecordViewInfo); reintroduce; virtual;
    function HasPoint(const P: TPoint): Boolean; override;
    property RecordViewInfo: TcxGridLayoutViewRecordViewInfo read FRecordViewInfo;
  end;

  TcxGridLayoutViewRecordExpandButtonViewInfoClass = class of TcxGridLayoutViewRecordExpandButtonViewInfo;

  { TcxGridLayoutViewRecordCaptionViewInfo }

  TcxGridLayoutViewRecordCaptionViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FRecordViewInfo: TcxGridLayoutViewRecordViewInfo;
    function GetGridRecord: TcxGridLayoutViewRecord;
    function GetGridView: TcxGridLayoutView;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function HasCustomDraw: Boolean; override;
    //text
    function GetRotatedText: Boolean;
    function GetTextAreaBounds: TRect; override;
    function GetTextAttributes(AForPainting: Boolean): Integer; override;
    function GetText: string; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
  public
    constructor Create(ARecordViewInfo: TcxGridLayoutViewRecordViewInfo); reintroduce; virtual;

    property GridView: TcxGridLayoutView read GetGridView;
    property GridRecord: TcxGridLayoutViewRecord read GetGridRecord;
    property RecordViewInfo: TcxGridLayoutViewRecordViewInfo read FRecordViewInfo;
    property RotatedText: Boolean read GetRotatedText;
  end;

  TcxGridLayoutViewRecordCaptionViewInfoClass = class of TcxGridLayoutViewRecordCaptionViewInfo;

  { Cache }

  TcxGridLayoutViewRecordViewInfoCacheItem = class(TcxGridCustomLayoutViewInfoCacheItem)
  private
    FRecordCaptionHeight: Integer;
    FIsRecordCaptionHeightAssigned: Boolean;
    function GetGridRecord: TcxGridLayoutViewRecord;
    procedure SetRecordCaptionHeight(Value: Integer);
  protected
    property GridRecord: TcxGridLayoutViewRecord read GetGridRecord;
  public
    procedure UnassignValues(AKeepMaster: Boolean); override;
    property RecordCaptionHeight: Integer read FRecordCaptionHeight write SetRecordCaptionHeight;
    property IsRecordCaptionHeightAssigned: Boolean read FIsRecordCaptionHeightAssigned write FIsRecordCaptionHeightAssigned;
  end;

  { TcxGridLayoutViewRecordViewInfo }

  TcxGridLayoutViewRecordViewInfo = class(TcxGridCustomLayoutRecordViewInfo)
  private
    FCalculatedCaptionHeight: Integer;
    FCaptionViewInfo: TcxGridLayoutViewRecordCaptionViewInfo;
    FExpandButtonViewInfo: TcxGridLayoutViewRecordExpandButtonViewInfo;
    FItemViewInfos: TcxObjectList;
    FLayoutCalculated: Boolean;
    FLayoutViewInfo: TcxGridLayoutContainerViewInfo;
    function GetCacheItem: TcxGridLayoutViewRecordViewInfoCacheItem;
    function GetExpandButtonSizeValue: Integer;
    function GetGridView: TcxGridLayoutView;
    function GetItemViewInfoCount: Integer;
    function GetItemViewInfos(Index: Integer): TcxGridLayoutViewItemViewInfo;
    function GetGridRecord: TcxGridLayoutViewRecord;
    function GetRecordBorderWidth: Integer;
  protected
    function CalculateHeight: Integer; override;
    function GetHeight: Integer; override;
    function GetWidth: Integer; override;
    function HasFocusRect: Boolean; override;
    function GetVisible: Boolean; override;

    procedure CalculateExpandButtonBounds(var ABounds: TRect); override;
    function CanGenerateExpandButtonHitTest: Boolean; override;
    function GetExpandButtonAlignment: TcxGridLayoutViewRecordExpandButtonAlignment; virtual;
    function GetExpandButtonAreaBounds: TRect; override;
    function GetExpandButtonAreaWidth: Integer; virtual;

    function CalculateRecordCaptionHeight: Integer; virtual;
    function GetRecordCaptionBounds: TRect; virtual;
    function GetRecordCaptionHeight: Integer; virtual;
    function GetRecordCaptionText: string; virtual;
    function GetRecordCaptionPosition: TcxGroupBoxCaptionPosition;
    function HasRecordCaption: Boolean; virtual;
    function IsRecordCaptionRotated: Boolean; virtual;

    function GetLayoutAreaBounds: TRect; virtual;
    function GetLayoutAreaBorders: TcxBorders;

    procedure CalculateItemViewInfos; virtual;
    procedure CreateItemViewInfos; virtual;
    procedure DestroyItemViewInfos; virtual;

    //internal classes
    function GetExpandButtonViewInfoClass: TcxGridLayoutViewRecordExpandButtonViewInfoClass; virtual;
    function GetItemViewInfoClass: TcxGridLayoutViewItemViewInfoClass; virtual;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetRecordCaptionViewInfoClass: TcxGridLayoutViewRecordCaptionViewInfoClass; virtual;

    procedure CalculateLayout; virtual;
    procedure CloneDataChangedHandler(Sender: TObject);
    procedure DoCalculateLayout;
    function GetItemViewInfoByItem(AItem: TcxGridLayoutViewItem): TcxGridLayoutViewItemViewInfo;
    procedure LayoutChanged;
    procedure RecalculateCloneData;
    procedure ResetCalculated; virtual;

    procedure CalculateLayoutViewInfo;
    procedure CreateLayoutViewInfo;
    procedure RecreateLayoutViewInfo;

    property CacheItem: TcxGridLayoutViewRecordViewInfoCacheItem read GetCacheItem;
    property ExpandButtonAlignment: TcxGridLayoutViewRecordExpandButtonAlignment read GetExpandButtonAlignment;
    property ExpandButtonAreaWidth: Integer read GetExpandButtonAreaWidth;
    property ExpandButtonSize: Integer read GetExpandButtonSizeValue;
    property LayoutAreaBounds: TRect read GetLayoutAreaBounds;
    property LayoutAreaBorders: TcxBorders read GetLayoutAreaBorders;
    property LayoutViewInfo: TcxGridLayoutContainerViewInfo read FLayoutViewInfo;
    property RecordCaptionBounds: TRect read GetRecordCaptionBounds;
    property RecordCaptionPosition: TcxGroupBoxCaptionPosition read GetRecordCaptionPosition;
  public
    constructor Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo; ARecord: TcxCustomGridRecord); override;
    destructor Destroy; override;

    procedure BeforeRecalculation; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1; AHeight: Integer = -1); override;
    procedure MainCalculate(ALeftBound, ATopBound: Integer); override;

    function Click(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    function GetBoundsForItem(AItem: TcxCustomGridTableItem): TRect; override;
    function GetCellViewInfoByItem(AItem: TcxCustomGridTableItem): TcxGridTableDataCellViewInfo; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    procedure GetRecordBorderViewParams(var AParams: TcxViewParams); virtual;

    property CaptionViewInfo: TcxGridLayoutViewRecordCaptionViewInfo read FCaptionViewInfo;
    property ExpandButtonViewInfo: TcxGridLayoutViewRecordExpandButtonViewInfo read FExpandButtonViewInfo;
    property GridRecord: TcxGridLayoutViewRecord read GetGridRecord;
    property GridView: TcxGridLayoutView read GetGridView;
    property ItemViewInfoCount: Integer read GetItemViewInfoCount;
    property ItemViewInfos[Index: Integer]: TcxGridLayoutViewItemViewInfo read GetItemViewInfos;
    property RecordBorderWidth: Integer read GetRecordBorderWidth;
  end;

  // calculators

  { TcxGridLayoutViewInfoHorizontalCalculator }

  TcxGridLayoutViewInfoHorizontalCalculator = class(TcxGridCustomLayoutViewInfoHorizontalCalculator)
  private
    function GetRecordsViewInfo: TcxGridLayoutViewRecordsViewInfo;
  protected
    procedure DoCalculate(const AContentBounds: TRect); override;
    function GetMaxCoulumnCount: Integer; override;
    function GetMaxRowCount: Integer; override;

    function CanCenterHorizontally: Boolean; virtual;
    function CanCenterVertically: Boolean; virtual;
    procedure CenterHorizontally(const AContentBounds: TRect);
    procedure CenterVertically(const AContentBounds: TRect);
  public
    property RecordsViewInfo: TcxGridLayoutViewRecordsViewInfo read GetRecordsViewInfo;
  end;

  { TcxGridLayoutViewInfoVerticalCalculator }

  TcxGridLayoutViewInfoVerticalCalculator = class(TcxGridCustomLayoutViewInfoVerticalCalculator)
  private
    function GetRecordsViewInfo: TcxGridLayoutViewRecordsViewInfo;
    function GetRowCount: Integer;
  protected
    procedure DoCalculate(const AContentBounds: TRect); override;
    function GetMaxCoulumnCount: Integer; override;
    function GetMaxRowCount: Integer; override;

    function CanCenterHorizontally: Boolean; virtual;
    function CanCenterVertically: Boolean; virtual;
    procedure CenterHorizontally(const AContentBounds: TRect);
    procedure CenterVertically(const AContentBounds: TRect);
  public
    property RecordsViewInfo: TcxGridLayoutViewRecordsViewInfo read GetRecordsViewInfo;
  end;

  { TcxGridLayoutViewInfoSingleRecordCalculator }

  TcxGridLayoutViewInfoSingleRecordCalculator = class(TcxGridLayoutViewInfoHorizontalCalculator)
  protected
    function GetMaxCoulumnCount: Integer; override;
    function GetMaxRowCount: Integer; override;
  end;

  { TcxGridLayoutViewInfoSingleColumnCalculator }

  TcxGridLayoutViewInfoSingleColumnCalculator = class(TcxGridLayoutViewInfoVerticalCalculator)
  protected
    function CanCenterVertically: Boolean; override;
    function GetMaxCoulumnCount: Integer; override;
  end;

  { TcxGridLayoutViewInfoMultiColumnCalculator }

  TcxGridLayoutViewInfoMultiColumnCalculator = class(TcxGridLayoutViewInfoHorizontalCalculator)
  protected
    function CanCenterHorizontally: Boolean; override;
  end;

  { TcxGridLayoutViewInfoSingleRowCalculator }

  TcxGridLayoutViewInfoSingleRowCalculator = class(TcxGridLayoutViewInfoHorizontalCalculator)
  protected
    function CanCenterHorizontally: Boolean; override;
    function GetMaxRowCount: Integer; override;
  end;

  { TcxGridLayoutViewInfoMultiRowCalculator }

  TcxGridLayoutViewInfoMultiRowCalculator = class(TcxGridLayoutViewInfoVerticalCalculator)
  protected
    function CanCenterVertically: Boolean; override;
  end;

  { TcxGridLayoutViewRecordsViewInfo }

  TcxGridLayoutViewRecordsViewInfo = class(TcxGridCustomLayoutRecordsViewInfo)
  private
    function GetGridView: TcxGridLayoutView;
    function GetGridViewInfo: TcxGridLayoutViewViewInfo;
    function GetItem(Index: Integer): TcxGridLayoutViewRecordViewInfo;
    function GetViewData: TcxGridLayoutViewViewData;
  protected
    function CalculateMaxRecordHeight: Integer; override;
    function CalculateRecordHeight: Integer; override;
    function CalculateRecordWidth: Integer; override;
    function GetAutoDataRecordHeight: Boolean; override;

    function GetCalculatorClass: TcxGridCustomLayoutRecordsViewInfoBasedCalculatorClass; override;
    function GetItemViewInfoClass: TcxGridCustomLayoutRecordViewInfoClass; override;

    function CanCenterRecords: Boolean;
   property GridView: TcxGridLayoutView read GetGridView;
    property GridViewInfo: TcxGridLayoutViewViewInfo read GetGridViewInfo;
    property Items[Index: Integer]: TcxGridLayoutViewRecordViewInfo read GetItem; default;
    property ViewData: TcxGridLayoutViewViewData read GetViewData;
  end;

  // separators

  { TcxGridLayoutViewSeparatorsViewInfo }

  TcxGridLayoutViewSeparatorsViewInfo = class(TcxGridCustomLayoutViewSeparatorsViewInfo)
  private
    function GetRecordsViewInfo: TcxGridLayoutViewRecordsViewInfo;
  protected
    function CalculateMaxBottom(ARow: Integer): Integer;
    function CalculateMaxRight(AColumn: Integer): Integer;
    function CalculateMinLeft(AColumn: Integer): Integer;
    function CalculateMinTop(ARow: Integer): Integer;
  public
    property RecordsViewInfo: TcxGridLayoutViewRecordsViewInfo read GetRecordsViewInfo;
  end;

  { TcxGridLayoutViewSingleRecordSeparatorsViewInfo }

  TcxGridLayoutViewSingleRecordSeparatorsViewInfo = class(TcxGridLayoutViewSeparatorsViewInfo);

  { TcxGridLayoutViewSingleColumnRecordSeparatorsViewInfo }

  TcxGridLayoutViewSingleColumnRecordSeparatorsViewInfo = class(TcxGridLayoutViewSeparatorsViewInfo)
  public
    procedure DoCalculate; override;
  end;

  { TcxGridLayoutViewSingleRowRecordSeparatorsViewInfo }

  TcxGridLayoutViewSingleRowRecordSeparatorsViewInfo = class(TcxGridLayoutViewSeparatorsViewInfo)
  public
    procedure DoCalculate; override;
  end;

  { TcxGridLayoutViewMultiColumnRecordSeparatorsViewInfo }

  TcxGridLayoutViewMultiColumnRecordSeparatorsViewInfo = class(TcxGridLayoutViewSingleRowRecordSeparatorsViewInfo)
  public
    procedure DoCalculate; override;
  end;

  { TcxGridLayoutViewMultiRowRecordSeparatorsViewInfo }

  TcxGridLayoutViewMultiRowRecordSeparatorsViewInfo = class(TcxGridLayoutViewSingleColumnRecordSeparatorsViewInfo)
  public
    procedure DoCalculate; override;
  end;

  { TcxGridLayoutViewViewInfo }

  TcxGridLayoutViewViewInfo = class(TcxGridCustomLayoutViewViewInfo)
  private
    function GetController: TcxGridLayoutViewController;
    function GetGridView: TcxGridLayoutView;
    function GetRecordsViewInfo: TcxGridLayoutViewRecordsViewInfo;
  protected
    function GetRecordsViewInfoClass: TcxCustomGridRecordsViewInfoClass; override;
    function GetSeparatorsViewInfoClass: TcxGridCustomLayoutViewSeparatorsViewInfoClass; override;

    property Controller: TcxGridLayoutViewController read GetController;
  public
    property GridView: TcxGridLayoutView read GetGridView;
    property RecordsViewInfo: TcxGridLayoutViewRecordsViewInfo read GetRecordsViewInfo;
  end;

  { TcxGridLayoutViewItemOptions }

  TcxGridLayoutViewItemOptions = class(TcxCustomGridTableItemOptions);

  { TcxGridLayoutViewItem }

  TcxGridLayoutViewItem = class(TcxCustomGridTableItem)
  private
    FLayoutItem: TcxGridLayoutItem;
    function GetGridView: TcxGridLayoutView;
    function GetOptions: TcxGridLayoutViewItemOptions;
    procedure SetLayoutInplaceItem(const Value: TcxGridLayoutItem);
    procedure SetOptions(Value: TcxGridLayoutViewItemOptions);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function CanAutoHeight: Boolean; override;
    function CanFocus(ARecord: TcxCustomGridRecord): Boolean; override;
    procedure CaptionChanged; override;
    function GetActuallyVisible: Boolean; override;
    function GetEditPropertiesClass: TcxCustomEditPropertiesClass;
    function GetEditMinSize(AFont: TFont): TSize;
    function GetOptionsClass: TcxCustomGridTableItemOptionsClass; override;
    function GetVisibleCaption: string; override;

    function CaptionToDisplayCaption(const ACaption: string): string; virtual;
    function DisplayCaptionToCaption(const ADisplayCaption: string): string; virtual;

    procedure SetGridView(Value: TcxCustomGridTableView); override;
    procedure VisibleChanged; override;
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property GridView: TcxGridLayoutView read GetGridView;
  published
    property LayoutItem: TcxGridLayoutItem read FLayoutItem write SetLayoutInplaceItem;
    property Options: TcxGridLayoutViewItemOptions read GetOptions write SetOptions;
  end;

  { TcxGridLayoutViewRecord }

  TcxGridLayoutViewRecord = class(TcxGridCustomLayoutRecord)
  private
    FCloneDataStream: TStream;
    function GetGridView: TcxGridLayoutView;
    function GetViewInfo: TcxGridLayoutViewRecordViewInfo;
  protected
    function GetExpanded: Boolean; override;
    function GetViewInfoCacheItemClass: TcxCustomGridViewInfoCacheItemClass; override;

    property CloneDataStream: TStream read FCloneDataStream;
  public
    constructor Create(AViewData: TcxCustomGridTableViewData; AIndex: Integer; const ARecordInfo: TcxRowInfo); override;
    destructor Destroy; override;

    property GridView: TcxGridLayoutView read GetGridView;
    property ViewInfo: TcxGridLayoutViewRecordViewInfo read GetViewInfo;
  end;

  { TcxGridLayoutViewControllerHelper }

  TcxGridLayoutViewControllerHelper = class(TcxGridCustomLayoutViewControllerHelper)
  public
    function GetIsRecordsScrollHorizontal: Boolean; override;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; override;
    function GetScrollDelta: Integer; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  end;

  { TcxGridLayoutViewControllerHorizontalHelper }

  TcxGridLayoutViewControllerHorizontalHelper = class(TcxGridLayoutViewControllerHelper)
  protected
    function CanScrollBarVisible(AKind: TScrollBarKind): Boolean; override;
  end;

  { TcxGridCustomLayoutViewControllerVerticalHelper }

  TcxGridLayoutViewControllerVerticalHelper = class(TcxGridLayoutViewControllerHelper)
  protected
    function CanScrollBarVisible(AKind: TScrollBarKind): Boolean; override;
  end;

  { TcxGridLayoutViewController }

  TcxGridLayoutViewController = class(TcxGridCustomLayoutViewController)
  private
    function GetFocusedItem: TcxGridLayoutViewItem;
    function GetFocusedRecordViewInfo: TcxGridLayoutViewRecordViewInfo;
    function GetGridView: TcxGridLayoutView;
    function GetViewInfo: TcxGridLayoutViewViewInfo;
    procedure SetFocusedItem(Value: TcxGridLayoutViewItem);
  protected
    // Customization
    procedure CheckCustomizationFormBounds(var R: TRect); override;
    function CreateCustomizationForm: TForm; override;
    procedure CustomizationChanged; override;
    procedure DoCreateCustomizationForm; override;
    function GetCustomizationFormDefaultWidth: Integer; override;
    function GetCustomizationFormDefaultHeight: Integer; override;
    function ShowModalCustomizationForm: Integer; virtual;

    function GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean; override;
    function GetHelperClass: TcxGridCustomLayoutViewControllerHelperClass; override;

    procedure CheckFocusItem(AItemViewInfo: TcxGridLayoutViewItemViewInfo);
    function GetNextIndex(AFocusedIndex: Integer; AGoForward, AGoOnCycle: Boolean; out ACycleChanged: Boolean): Integer;

    function GetLayoutContainerViewInfo(AHitTest: TcxGridRecordHitTest): TcxGridLayoutContainerViewInfo;

    property FocusedRecordViewInfo: TcxGridLayoutViewRecordViewInfo read GetFocusedRecordViewInfo;
    property ViewInfo: TcxGridLayoutViewViewInfo read GetViewInfo;
  public
    function FindNextItem(AFocusedItemIndex: Integer; AGoForward, AGoOnCycle, AFollowVisualOrder: Boolean;
      out ACycleChanged: Boolean; ARecord: TcxCustomGridRecord): Integer; override;
    function FocusNextItemVertically(AGoForward, AGoOnCycle: Boolean): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    property FocusedItem: TcxGridLayoutViewItem read GetFocusedItem write SetFocusedItem;
    property GridView: TcxGridLayoutView read GetGridView;
  end;

  { TcxGridLayoutViewDateTimeHandling }

  TcxGridLayoutViewDateTimeHandling = class(TcxCustomGridTableDateTimeHandling);

  { TcxGridLayoutViewFiltering }

  TcxGridLayoutViewFiltering = class(TcxCustomGridTableFiltering)
  published
    property ItemFilteredItemsList;
    property ItemPopup;
    property MRUItemsList default True;
    property MRUItemsListCount default cxGridFilterDefaultMRUItemsListCount;
  end;

  { TcxGridLayoutViewOptionsData }

  TcxGridLayoutViewOptionsData = class(TcxCustomGridTableOptionsData);

  { TcxGridLayoutViewOptionsSelection }

  TcxGridLayoutViewOptionsSelection = class(TcxCustomGridTableOptionsSelection)
  private
    FRecordBorderSelection: Boolean;
    procedure SetRecordBorderSelection(Value: Boolean);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
  published
    property RecordBorderSelection: Boolean read FRecordBorderSelection write SetRecordBorderSelection default True;
  end;

  { TcxGridLayoutViewOptionsBehavior }

  TcxGridLayoutViewOptionsBehavior = class(TcxCustomGridTableOptionsBehavior)
  private
    FExpandRecordOnDblClick: Boolean;
    FItemHotTrack: Boolean;
    procedure SetExpandRecordOnDblClick(const Value: Boolean);
    procedure SetItemHotTrack(const Value: Boolean);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
  published
    property ExpandRecordOnDblClick: Boolean read FExpandRecordOnDblClick write SetExpandRecordOnDblClick default True;
    property ItemHotTrack: Boolean read FItemHotTrack write SetItemHotTrack default True;
  end;

  { TcxGridLayoutViewOptionsCustomize }

  TcxGridLayoutViewOptionsCustomize = class(TcxGridCustomLayoutViewOptionsCustomize)
  private
    function GetRecordExpanding: Boolean;
    procedure SetRecordExpanding(Value: Boolean);
  published
    property RecordExpanding: Boolean read GetRecordExpanding write SetRecordExpanding default False;
  end;

  { TcxGridLayoutViewRecordCaption }

  TcxGridLayoutViewRecordCaption = class(TcxCustomGridOptions)
  private
    FDisplayMask: string;
    FExpandButtonAlignment: TcxGridLayoutViewRecordExpandButtonAlignment;
    FFormatString: string;
    FHeight: Integer;
    FIsNeedRecordIndex: Boolean;
    FIsNeedRecordCount: Boolean;
    FTextAlignmentVert: TcxAlignmentVert;
    FTextAlignmentHorz: TAlignment;
    FVisible: Boolean;
    function IsDisplayMaskStored: Boolean;
    procedure SetExpandButtonAlignment(Value: TcxGridLayoutViewRecordExpandButtonAlignment);
    procedure SetHeight(Value: Integer);
    procedure SetVisible(Value: Boolean);
    procedure SetTextAlignmentHorz(Value: TAlignment);
    procedure SetTextAlignmentVert(Value: TcxAlignmentVert);
    procedure SetDisplayMask(const Value: string);
  protected
    procedure BuildFormatString;
    property IsNeedRecordIndex: Boolean read FIsNeedRecordIndex;
    property IsNeedRecordCount: Boolean read FIsNeedRecordCount;
  public
    constructor Create(AOptionsView: TcxGridLayoutViewOptionsView); reintroduce; virtual;
    procedure Assign(Source: TPersistent); override;
    function GetFormattedText(AGridRecord: TcxGridLayoutViewRecord): string; virtual;
  published
    property DisplayMask: string read FDisplayMask write SetDisplayMask stored IsDisplayMaskStored;
    property ExpandButtonAlignment: TcxGridLayoutViewRecordExpandButtonAlignment
      read FExpandButtonAlignment write SetExpandButtonAlignment default rebaRight;
    property Height: Integer read FHeight write SetHeight default 0;
    property TextAlignmentHorz: TAlignment read FTextAlignmentHorz write SetTextAlignmentHorz default taLeftJustify;
    property TextAlignmentVert: TcxAlignmentVert read FTextAlignmentVert write SetTextAlignmentVert default vaCenter;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TcxGridLayoutViewRecordHeaderClass = class of TcxGridLayoutViewRecordCaption;

  { TcxGridLayoutViewOptionsView }

  TcxGridLayoutViewViewMode = (lvvmSingleRecord, lvvmSingleRow, lvvmMultiRow,
    lvvmSingleColumn, lvvmMultiColumn);

  TcxGridLayoutViewOptionsView = class(TcxGridCustomLayoutViewOptionsView)
  private
    FCenterRecords: Boolean;
    FMaxColumnCount: Integer;
    FMaxRowCount: Integer;
    FMinValueWidth: Integer;
    FRecordBorderWidth: Integer;
    FRecordCaption: TcxGridLayoutViewRecordCaption;
    FShowOnlyEntireRecords: Boolean;
    FViewMode: TcxGridLayoutViewViewMode;
    function GetGridView: TcxGridLayoutView;
    function GetRecordIndent: Integer;
    procedure SetCenterRecords(Value: Boolean);
    procedure SetMaxColumnCount(Value: Integer);
    procedure SetMaxRowCount(Value: Integer);
    procedure SetMinValueWidth(Value: Integer);
    procedure SetRecordCaption(Value: TcxGridLayoutViewRecordCaption);
    procedure SetRecordIndent(Value: Integer);
    procedure SetRecordBorderWidth(Value: Integer);
    procedure SetShowOnlyEntireRecords(Value: Boolean);
    procedure SetViewMode(Value: TcxGridLayoutViewViewMode);
  protected
    function GetRecordCaptionClass: TcxGridLayoutViewRecordHeaderClass; virtual;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property GridView: TcxGridLayoutView read GetGridView;
  published
    property CenterRecords: Boolean read FCenterRecords write SetCenterRecords default True;
    property MaxColumnCount: Integer read FMaxColumnCount write SetMaxColumnCount default 0;
    property MaxRowCount: Integer read FMaxRowCount write SetMaxRowCount default 0;
    property MinValueWidth: Integer read FMinValueWidth write SetMinValueWidth
      default cxGridLayoutViewDefaultMinValueWidth;
    property RecordBorderWidth: Integer read FRecordBorderWidth write SetRecordBorderWidth
      default cxGridLayoutViewDefaultRecordBorderWidth;
    property RecordCaption: TcxGridLayoutViewRecordCaption read FRecordCaption write SetRecordCaption;
    property RecordIndent: Integer
      read GetRecordIndent write SetRecordIndent default cxGridCustomLayoutViewRecordDefaultIndent;
    property SeparatorColor;
    property SeparatorWidth;
    property ShowItemFilterButtons;
    property ShowOnlyEntireRecords: Boolean read FShowOnlyEntireRecords write SetShowOnlyEntireRecords default True;
    property ViewMode: TcxGridLayoutViewViewMode read FViewMode write SetViewMode default lvvmSingleRecord;
  end;

  { TcxGridLayoutViewStyles }

  TcxGridLayoutViewStyles = class(TcxCustomGridTableViewStyles)
  private
    FOnGetItemStyle: TcxGridGetCellStyleEvent;
    FOnGetRecordBorderStyle: TcxGridGetRecordStyleEvent;
    FOnGetRecordCaptionStyle: TcxGridGetRecordStyleEvent;
    function GetGridViewValue: TcxGridLayoutView;
    procedure SetOnGetItemStyle(Value: TcxGridGetCellStyleEvent);
    procedure SetOnGetRecordBorderStyle(Value: TcxGridGetRecordStyleEvent);
    procedure SetOnGetRecordCaptionStyle(Value: TcxGridGetRecordStyleEvent);
  protected
    procedure Changed(AIndex: Integer); override;
    function GetBackgroundBitmapIndex(Index: Integer): Integer; virtual;
    function GetDefaultBitmap(Index: Integer): TBitmap; virtual;
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    procedure GetItemParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams); virtual;
    procedure GetRecordBorderParams(ARecord: TcxCustomGridRecord; out AParams: TcxViewParams); virtual;
    procedure GetRecordCaptionParams(ARecord: TcxCustomGridRecord; out AParams: TcxViewParams); virtual;
    procedure GetRecordBorderVisualParams(ARecord: TcxCustomGridRecord; out AParams: TcxViewParams); virtual;
    property GridView: TcxGridLayoutView read GetGridViewValue;
  published
    property Item: TcxStyle index vsItem read GetValue write SetValue;
    property RecordBorder: TcxStyle index vsRecordBorder read GetValue write SetValue;
    property RecordCaption: TcxStyle index vsRecordCaption read GetValue write SetValue;
    property StyleSheet;
    property OnGetItemStyle: TcxGridGetCellStyleEvent read FOnGetItemStyle write SetOnGetItemStyle;
    property OnGetRecordBorderStyle: TcxGridGetRecordStyleEvent read FOnGetRecordBorderStyle write SetOnGetRecordBorderStyle;
    property OnGetRecordCaptionStyle: TcxGridGetRecordStyleEvent read FOnGetRecordCaptionStyle write SetOnGetRecordCaptionStyle;
  end;

  { TcxGridLayoutViewStyleSheet }

  TcxGridLayoutViewStyleSheet = class(TcxCustomStyleSheet)
  private
    function GetStylesValue: TcxGridLayoutViewStyles;
    procedure SetStylesValue(Value: TcxGridLayoutViewStyles);
  public
    class function GetStylesClass: TcxCustomStylesClass; override;
  published
    property Styles: TcxGridLayoutViewStyles read GetStylesValue write SetStylesValue;
  end;

  TcxGridLayoutViewCustomDrawRecordHeaderEvent = procedure(Sender: TcxGridLayoutView; ACanvas: TcxCanvas;
    AViewInfo: TcxGridLayoutViewRecordCaptionViewInfo; var ADone: Boolean) of object;

  { TcxGridLayoutView }

  TcxGridLayoutView = class(TcxGridCustomLayoutView,
    IdxLayoutControl,
    IdxLayoutItemsHelper,
    IdxLayoutFontHelper)
  private
    FContainer: TcxGridLayoutContainer;
    FLayoutLookAndFeel: TcxGridLayoutLookAndFeel;
    FOnCustomDrawRecordCaption: TcxGridLayoutViewCustomDrawRecordHeaderEvent;
    function GetControl: TcxCustomGrid;
    function GetController: TcxGridLayoutViewController;
    function GetDateTimeHandling: TcxGridLayoutViewDateTimeHandling;
    function GetFiltering: TcxGridLayoutViewFiltering;
    function GetItem(Index: Integer): TcxGridLayoutViewItem;
    function GetOptionsBehavior: TcxGridLayoutViewOptionsBehavior;
    function GetOptionsCustomize: TcxGridLayoutViewOptionsCustomize;
    function GetOptionsData: TcxGridLayoutViewOptionsData;
    function GetOptionsSelection: TcxGridLayoutViewOptionsSelection;
    function GetOptionsView: TcxGridLayoutViewOptionsView;
    function GetRoot: TdxLayoutGroup;
    function GetStyles: TcxGridLayoutViewStyles;
    function GetViewInfo: TcxGridLayoutViewViewInfo;
    function GetVisibleItem(Index: Integer): TcxGridLayoutViewItem;
    procedure LayoutChangedHandler(Sender: TObject);
    procedure SetDateTimeHandling(Value: TcxGridLayoutViewDateTimeHandling);
    procedure SetFiltering(Value: TcxGridLayoutViewFiltering);
    procedure SetItem(Index: Integer; Value: TcxGridLayoutViewItem);
    procedure SetOptionsBehavior(Value: TcxGridLayoutViewOptionsBehavior);
    procedure SetOptionsCustomize(Value: TcxGridLayoutViewOptionsCustomize);
    procedure SetOptionsData(Value: TcxGridLayoutViewOptionsData);
    procedure SetOptionsSelection(Value: TcxGridLayoutViewOptionsSelection);
    procedure SetOptionsView(Value: TcxGridLayoutViewOptionsView);
    procedure SetStyles(Value: TcxGridLayoutViewStyles);
    procedure SetOnCustomDrawRecordCaption(Value: TcxGridLayoutViewCustomDrawRecordHeaderEvent);
  protected
    procedure DoAssign(ASource: TcxCustomGridView); override;
    procedure Loaded; override;
    procedure Init; override;

    procedure RecalculateCloneData;

    //interfaces
    //IcxGridViewLayoutEditorSupport - for design-time layout editor
    procedure AssignLayout(ALayoutView: TcxCustomGridView); override;
    function GetLayoutCustomizationFormButtonCaption: string; override;
    //IdxLayoutFontHelper
    function GetBoldFont: TFont;
    function GetDefaultFont: TFont;
    //IdxLayoutCustomizationHelper
    function CreateCustomizationControlHelper(AItem: TdxLayoutItem): TdxControlsDesignSelectorHelper;
    procedure CustomizeFormPostUpdate(AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes);
    procedure CustomizeFormUpdateList(AItem: TdxCustomLayoutItem);
    procedure PostBuildSelectionLayer;
    procedure ToggleHotTrackState(AItem: TdxCustomLayoutItem);
    function IsCustomization: Boolean;
    function IsCustomizeFormOpened: Boolean;
    function IsDesignSelectorsVisible: Boolean;
    //IdxLayoutItemsHelper
    procedure AddAvailableItem(AItem: TdxCustomLayoutItem);
    procedure ExtractAvailableItem(AItem: TdxCustomLayoutItem);
    procedure SetRootGroup(Value: TdxLayoutGroup);
    //IdxLayoutControl
    function CanGetHitTest(const P: TPoint): Boolean;
    function CanProcessKeyboard: Boolean;
    function CanRestore: Boolean;
    function CanUpdate: Boolean;
    procedure CustomizationChanged;
    function GetAutoControlAlignment: Boolean;
    function GetAutoControlTabOrders: Boolean;
    function GetCanvas: TcxCanvas;
    function GetClientBounds: TRect;
    function GetClientRect: TRect;
    function GetContainer: TdxLayoutContainer;
    function GetDisabledImages: TCustomImageList;
    function GetHighlightRoot: Boolean;
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
    procedure MakeVisible(AItem: TdxCustomLayoutItem);
    procedure Modified;
    procedure PostPlaceControls;
    procedure PostInvalidateSelectionLayer(const R: TRect);

  {$IFNDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    function CalculateDataCellSelected(ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; AUseViewInfo: Boolean;
      ACellViewInfo: TcxGridTableCellViewInfo): Boolean; override;
    //function GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass; override;
    function GetControllerClass: TcxCustomGridControllerClass; override;
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
    function GetDateTimeHandlingClass: TcxCustomGridTableDateTimeHandlingClass; override;
    function GetFilteringClass: TcxCustomGridTableFilteringClass; override;
    function GetItemClass: TcxCustomGridTableItemClass; override;
    function GetOptionsBehaviorClass: TcxCustomGridOptionsBehaviorClass; override;
    function GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass; override;
    function GetOptionsDataClass: TcxCustomGridOptionsDataClass; override;
    function GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass; override;
    function GetOptionsViewClass: TcxCustomGridOptionsViewClass; override;
    function GetPainterClass: TcxCustomGridPainterClass; override;
    function GetStylesClass: TcxCustomGridViewStylesClass; override;
    function GetViewDataClass: TcxCustomGridViewDataClass; override;
    function GetViewInfoClass: TcxCustomGridViewInfoClass; override;

    procedure SetControl(Value: TcxControl); override;
    procedure SetName(const NewName: TComponentName); override;

    procedure CopyLayoutStructure(AContainer: TcxGridLayoutContainer);
    function CreateLayoutLookAndFeel: TcxGridLayoutLookAndFeel; virtual;
    function GetLayoutContainerClass: TcxGridLayoutContainerClass; virtual;
    function GetLayoutGroupClass: TdxLayoutGroupClass; virtual;

    procedure Restore;
    procedure SizeAdjustment;
    procedure Store;
    function StoringSupports: Boolean;

    procedure DoCustomDrawRecordHeader(ACanvas: TcxCanvas; AViewInfo: TcxGridLayoutViewRecordCaptionViewInfo;
      var ADone: Boolean); virtual;
    function HasCustomDrawRecordHeader: Boolean;

    function DrawRecordBorderSelected(ARecord: TcxCustomGridRecord): Boolean; virtual;

    property LayoutLookAndFeel: TcxGridLayoutLookAndFeel read FLayoutLookAndFeel;
    property Root: TdxLayoutGroup read GetRoot;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  {$IFDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    function CreateItem: TcxGridLayoutViewItem;

    property Container: TcxGridLayoutContainer read FContainer;
    property Control: TcxCustomGrid read GetControl;
    property Controller: TcxGridLayoutViewController read GetController;
    property Items[Index: Integer]: TcxGridLayoutViewItem read GetItem write SetItem;
    property ViewInfo: TcxGridLayoutViewViewInfo read GetViewInfo;
    property VisibleItems[Index: Integer]: TcxGridLayoutViewItem read GetVisibleItem;
  published
    property DateTimeHandling: TcxGridLayoutViewDateTimeHandling read GetDateTimeHandling write SetDateTimeHandling;
    property Filtering: TcxGridLayoutViewFiltering read GetFiltering write SetFiltering;
    property OptionsBehavior: TcxGridLayoutViewOptionsBehavior read GetOptionsBehavior write SetOptionsBehavior;
    property OptionsCustomize: TcxGridLayoutViewOptionsCustomize read GetOptionsCustomize write SetOptionsCustomize;
    property OptionsData: TcxGridLayoutViewOptionsData read GetOptionsData write SetOptionsData;
    property OptionsSelection: TcxGridLayoutViewOptionsSelection read GetOptionsSelection write SetOptionsSelection;
    property OptionsView: TcxGridLayoutViewOptionsView read GetOptionsView write SetOptionsView;
    property Styles: TcxGridLayoutViewStyles read GetStyles write SetStyles;

    property OnCustomization;
    property OnCustomDrawRecordCaption: TcxGridLayoutViewCustomDrawRecordHeaderEvent read
      FOnCustomDrawRecordCaption write SetOnCustomDrawRecordCaption;
  end;

implementation

uses
  Math, SysUtils, Types, cxGeometry, cxContainer, cxGridLayoutViewCustomizationForm, StrUtils, cxGridStrs;

type
  TdxCustomLayoutItemViewInfoAccess = class(TdxCustomLayoutItemViewInfo);
  TdxLayoutContainerAccess = class(TdxLayoutContainer);
  TcxControlAccess = class(TcxControl);
  TdxLayoutGroupViewInfoAccess = class(TdxLayoutGroupViewInfo);

///////////////////////////////// Layout classes ////////////////////////////////////////

{ TcxGridViewLayoutItemCaptionPainter }

procedure TcxGridViewLayoutItemCaptionPainter.DrawBackground;
begin
end;

{ TcxGridLayoutItemEditPainter }

procedure TcxGridLayoutItemEditPainter.Paint;
begin
  inherited Paint;
  DrawEdit;
end;

function TcxGridLayoutItemEditPainter.CanDrawEdit: Boolean;
begin
  Result := ViewInfo.Item.Container.Customization;
end;

procedure TcxGridLayoutItemEditPainter.DoDrawEdit;
var
  AGridViewItem: TcxGridLayoutViewItem;
  AProperties: TcxCustomEditProperties;
  AEditViewData: TcxCustomEditViewData;
  AEditViewInfo: TcxCustomEditViewInfo;
  AEditStyle: TcxEditStyle;
  AEditDrawBounds: TRect;
  AAlphaBitmap, AOpaqueBitmap: TcxBitmap32;
begin
  AGridViewItem := ViewInfo.Item.GridViewItem;
  AProperties := AGridViewItem.GetProperties;
  AEditStyle := TcxEditStyle.Create(nil, False);
  try
    AEditStyle.LookAndFeel := AGridViewItem.GetCellStyle.LookAndFeel;
    AEditStyle.ButtonTransparency := ebtNone;
    AEditStyle.BorderStyle := ebsNone;
    AEditViewData := AProperties.CreateViewData(AEditStyle, False, False);
    try
      AEditViewInfo := AProperties.GetViewInfoClass.Create as TcxCustomEditViewInfo;
      try
        AEditViewData.EditValueToDrawValue(Canvas, Null, AEditViewInfo);
        AEditDrawBounds := ViewInfo.Bounds;
        InflateRect(AEditDrawBounds, 1, 1);
        AAlphaBitmap := TcxBitmap32.CreateSize(AEditDrawBounds);
        AOpaqueBitmap := TcxBitmap32.CreateSize(AEditDrawBounds);
        try
          AEditViewData.Calculate(Canvas, AEditDrawBounds, cxNullPoint, cxmbNone, [], AEditViewInfo, False);
          AOpaqueBitmap.cxCanvas.WindowOrg := AEditDrawBounds.TopLeft;
          AEditViewInfo.Paint(AOpaqueBitmap.cxCanvas);
          AOpaqueBitmap.MakeOpaque;
          AAlphaBitmap.cxCanvas.FillRect(AAlphaBitmap.ClientRect, $100005);
          AAlphaBitmap.SetAlphaChannel(32);
          AOpaqueBitmap.cxCanvas.WindowOrg := cxNullPoint;
          cxAlphaBlend(AOpaqueBitmap.Canvas.Handle, AAlphaBitmap, AOpaqueBitmap.ClientRect, AAlphaBitmap.ClientRect);
          cxBitBlt(Canvas.Handle, AOpaqueBitmap.Canvas.Handle, ViewInfo.Bounds, cxPoint(1, 1), SRCCOPY);
        finally
          AAlphaBitmap.Free;
          AOpaqueBitmap.Free;
        end;
      finally
        AEditViewInfo.Free;
      end;
    finally
      AEditViewData.Free;
    end;
  finally
    AEditStyle.Free;
  end;
end;

procedure TcxGridLayoutItemEditPainter.DrawEdit;
begin
  if CanDrawEdit then
    DoDrawEdit;
end;

function TcxGridLayoutItemEditPainter.GetViewInfo: TcxGridLayoutItemEditViewInfo;
begin
  Result := TcxGridLayoutItemEditViewInfo(inherited ViewInfo);
end;

{ TcxGridLayoutItemPainter }

function TcxGridLayoutItemPainter.CanPaint: Boolean;
begin
  Result := ViewInfo.Item.Container.Customization;
end;

function TcxGridLayoutItemPainter.GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass;
begin
  Result := TcxGridViewLayoutItemCaptionPainter;
end;

function TcxGridLayoutItemPainter.GetControlPainterClass: TdxLayoutControlItemControlPainterClass;
begin
  Result := TcxGridLayoutItemEditPainter;
end;

function TcxGridLayoutItemPainter.GetGridItemViewInfo: TcxGridLayoutViewItemViewInfo;
begin
  Result := ViewInfo.GridItemViewInfo;
end;

function TcxGridLayoutItemPainter.GetViewInfo: TcxGridLayoutItemViewInfo;
begin
  Result := TcxGridLayoutItemViewInfo(inherited ViewInfo);
end;

{ TcxGridLayoutItemEditViewInfo }

function TcxGridLayoutItemEditViewInfo.CalculateMinHeight: Integer;
begin
  if Item.ControlOptions.IsHeightFixed then
    Result := CalculateHeight
  else
    if Visible then
      Result := GetDefaultValueHeight
    else
      Result := 0;
end;

function TcxGridLayoutItemEditViewInfo.CalculateMinWidth: Integer;
begin
  if Item.ControlOptions.IsWidthFixed then
    Result := CalculateWidth
  else
    if Visible then
      Result := GetControlAreaWidth(GridView.OptionsView.MinValueWidth)
    else
      Result := 0;
end;

procedure TcxGridLayoutItemEditViewInfo.CalculateInternalTabOrder(var AAvailTabOrder: Integer);
begin
  ItemViewInfo.TabOrderIndex := AAvailTabOrder;
  Inc(AAvailTabOrder);
end;

function TcxGridLayoutItemEditViewInfo.HasBorder: Boolean;
begin
  Result := False;
end;

function TcxGridLayoutItemEditViewInfo.GetValueHeight: Integer;
begin
  if FDataHeight = 0 then
  begin
    if DataViewInfo <> nil then
      FDataHeight := DataViewInfo.CalculateHeight
    else
      FDataHeight := GetDefaultValueHeight;
  end;
  Result := FDataHeight;
end;

function TcxGridLayoutItemEditViewInfo.GetDefaultValueHeight: Integer;
var
  AParams: TcxViewParams;
begin
  GridView.Styles.GetItemParams(nil, Item.GridViewItem, AParams);
  Result := Item.GridViewItem.CalculateDefaultCellHeight(cxScreenCanvas,  AParams.Font);
end;

function TcxGridLayoutItemEditViewInfo.GetGridView: TcxGridLayoutView;
begin
  Result := Item.GridViewItem.GridView;
end;

function TcxGridLayoutItemEditViewInfo.GetOriginalControlSize: TSize;
begin
  Result := cxSize(GridView.OptionsView.MinValueWidth, GetValueHeight);
end;

function TcxGridLayoutItemEditViewInfo.GetDataViewInfo: TcxGridLayoutViewItemDataCellViewInfo;
begin
  if ItemViewInfo.GridItemViewInfo <> nil then
    Result := ItemViewInfo.GridItemViewInfo.DataViewInfo
  else
    Result := nil;
end;

function TcxGridLayoutItemEditViewInfo.GetItem: TcxGridLayoutItem;
begin
  Result := TcxGridLayoutItem(inherited Item);
end;

function TcxGridLayoutItemEditViewInfo.GetItemViewInfo: TcxGridLayoutItemViewInfo;
begin
  Result := TcxGridLayoutItemViewInfo(inherited ItemViewInfo);
end;

{ TcxGridLayoutItemCaptionViewInfo }

function TcxGridLayoutItemCaptionViewInfo.GetPadding: TRect;
begin
  Result := inherited GetPadding;
  Inc(Result.Left, 2);
  Inc(Result.Right, 2);
  if ItemViewInfo.GridItemViewInfo <> nil then
    Inc(Result.Right, ItemViewInfo.GridItemViewInfo.GetExtraCaptionPadding);
end;

function TcxGridLayoutItemCaptionViewInfo.GetItem: TcxGridLayoutItem;
begin
  Result := TcxGridLayoutItem(inherited Item);
end;

function TcxGridLayoutItemCaptionViewInfo.GetItemViewInfo: TcxGridLayoutItemViewInfo;
begin
  Result := TcxGridLayoutItemViewInfo(inherited ItemViewInfo);
end;

{ TcxGridLayoutItemViewInfo }

function TcxGridLayoutItemViewInfo.GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass;
begin
  Result := TcxGridLayoutItemCaptionViewInfo;
end;

function TcxGridLayoutItemViewInfo.GetControlViewInfoClass: TdxLayoutControlItemControlViewInfoClass;
begin
  Result := TcxGridLayoutItemEditViewInfo;
end;

function TcxGridLayoutItemViewInfo.GetPainterClass: TdxCustomLayoutItemPainterClass;
begin
  Result := TcxGridLayoutItemPainter;
end;

function TcxGridLayoutItemViewInfo.GetContainerViewInfo: TcxGridCustomLayoutContainerViewInfo;
begin
  Result := TcxGridCustomLayoutContainerViewInfo(inherited ContainerViewInfo);
end;

function TcxGridLayoutItemViewInfo.GetControlViewInfo: TcxGridLayoutItemEditViewInfo;
begin
  Result := TcxGridLayoutItemEditViewInfo(inherited ControlViewInfo);
end;

function TcxGridLayoutItemViewInfo.GetGridItemViewInfo: TcxGridLayoutViewItemViewInfo;
begin
  if FGridItemViewInfo = nil then
    SetGridItemViewInfo;
  Result := FGridItemViewInfo;
end;

function TcxGridLayoutItemViewInfo.GetItem: TcxGridLayoutItem;
begin
  Result := TcxGridLayoutItem(inherited Item);
end;

procedure TcxGridLayoutItemViewInfo.SetGridItemViewInfo;
begin
  FGridItemViewInfo := ContainerViewInfo.GetGridItemViewInfo(Self);
end;

{ TdxGridLayoutItemCaptionOptions }

function TcxGridLayoutItemCaptionOptions.GetItem: TcxGridLayoutItem;
begin
  Result := TcxGridLayoutItem(inherited Item);
end;

function TcxGridLayoutItemCaptionOptions.GetText: string;
begin
  if Item.Customization then
    Result := inherited GetText
  else
  begin
    if Item.GridViewItem <> nil then
      Result := Item.GridViewItem.VisibleCaption
    else
      Result := '';
  end;
end;

function TcxGridLayoutItemCaptionOptions.IsTextStored: Boolean;
begin
  Result := False;
end;

procedure TcxGridLayoutItemCaptionOptions.SetText(const Value: string);
begin
  inherited SetText(Value);
  if Item.Container.IsLayoutLoading and (Item.GridViewItem <> nil) then
    GridItemCaption := Item.GridViewItem.DisplayCaptionToCaption(Value);
end;

{ TcxGridLayoutItem }

procedure TcxGridLayoutItem.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxGridLayoutItem then
  begin
    case Container.AssignLayoutMode of
      almFromParent:
        GridViewItem := TcxGridLayoutItem(Source).GridViewItem;
      almToParent:
        GridViewItem.Caption := TcxGridLayoutItem(Source).CaptionOptions.GridItemCaption;
    end;
  end;
end;

procedure TcxGridLayoutItem.BeforeDestruction;
begin
  if not Container.IsDestroying and
    (GridViewItem <> nil) and ([csDesigning, csDestroying] * GridViewItem.ComponentState = [csDesigning]) then
    raise Exception.Create('Can''t delete internal component');
  inherited BeforeDestruction;
end;

function TcxGridLayoutItem.IsVisibleForCustomization: Boolean;
begin
  Result := inherited IsVisibleForCustomization and (GridViewItem <> nil) and GridViewItem.VisibleForCustomization
end;

function TcxGridLayoutItem.GetBaseName: string;
begin
  Result := inherited GetBaseName + 'LayoutItem';
end;

function TcxGridLayoutItem.GetInplaceRenameCaption: string;
begin
  Result := CaptionOptions.GridItemCaption;
end;

function TcxGridLayoutItem.CanDelete: Boolean;
begin
  Result := False;
end;

procedure TcxGridLayoutItem.CustomizationChanged;
begin
  inherited;
  if Customization and not IsDestroying and (GridViewItem <> nil) then
  begin
    CaptionOptions.GridItemCaption := GridViewItem.Caption;
    Caption := GridViewItem.GetVisibleCaption;
  end;
end;

function TcxGridLayoutItem.GetCaptionOptions: TcxGridLayoutItemCaptionOptions;
begin
  Result := TcxGridLayoutItemCaptionOptions(inherited CaptionOptions);
end;

class function TcxGridLayoutItem.GetCaptionOptionsClass: TdxCustomLayoutItemCaptionOptionsClass;
begin
  Result := TcxGridLayoutItemCaptionOptions;
end;

function TcxGridLayoutItem.GetViewInfoClass: TdxCustomLayoutItemViewInfoClass;
begin
  Result := TcxGridLayoutItemViewInfo;
end;

function TcxGridLayoutItem.HasControl: Boolean;
begin
  Result := GridViewItem <> nil;
end;

procedure TcxGridLayoutItem.SetInplaceRenameCaption(const ACaption: string);
begin
  CaptionOptions.GridItemCaption := ACaption;
  inherited SetInplaceRenameCaption(GridViewItem.CaptionToDisplayCaption(ACaption));
end;

function TcxGridLayoutItem.GetViewInfo: TcxGridLayoutItemViewInfo;
begin
  Result := TcxGridLayoutItemViewInfo(inherited ViewInfo);
end;

procedure TcxGridLayoutItem.SetCaptionOptions(Value: TcxGridLayoutItemCaptionOptions);
begin
  inherited CaptionOptions := Value;
end;

procedure TcxGridLayoutItem.SetGridViewItem(Value: TcxGridLayoutViewItem);
begin
  if GridViewItem <> Value then
  begin
    FGridViewItem := Value;
    Changed;
  end;
end;

{ TcxGridLayoutLookAndFeel }

constructor TcxGridLayoutLookAndFeel.Create(AGridView: TcxGridLayoutView);
begin
  inherited Create(nil);
  FGridView := AGridView;
  Offsets.ControlOffsetHorz := 2;
  Offsets.ControlOffsetVert := 2;
  Offsets.ItemOffset := 2;
  //todo!!!
  Offsets.RootItemsAreaOffsetVert := 4;
  Offsets.RootItemsAreaOffsetHorz := 4;

  ItemOptions.Padding.Left := 0;
  ItemOptions.Padding.Top := 0;
  ItemOptions.Padding.Right := 0;
  ItemOptions.Padding.Bottom := 0;

  GroupOptions.Padding.Left := 0;
  GroupOptions.Padding.Top := 0;
  GroupOptions.Padding.Right := 0;
  GroupOptions.Padding.Bottom := 0;
end;

{ TcxGridCustomLayoutContainerViewInfo }

function TcxGridCustomLayoutContainerViewInfo.GetGridItemViewInfo(AViewInfo: TcxGridLayoutItemViewInfo): TcxGridLayoutViewItemViewInfo;
begin
  Result := nil;
end;

procedure TcxGridCustomLayoutContainerViewInfo.PopulateTabOrderList(AList: TList);

  procedure DoPopulateTabOrderList(AItem: TdxCustomLayoutItemViewInfo; AList: TList);
  var
    I: Integer;
  begin
    // todo:
    if AItem is TcxGridLayoutItemViewInfo then
    begin
      if TcxGridLayoutItemViewInfo(AItem).ActuallyVisible and TcxGridLayoutItemViewInfo(AItem).Enabled then
        AList.Add(TcxGridLayoutItemViewInfo(AItem).Item.GridViewItem);
    end
    else
      if AItem is TdxLayoutGroupViewInfo then
        with AItem as TdxLayoutGroupViewInfo do
          for I := 0 to ItemViewInfoCount - 1 do
            DoPopulateTabOrderList(ItemViewInfos[I], AList);
  end;

begin
  DoPopulateTabOrderList(ItemsViewInfo, AList);
end;

{ TcxGridLayoutContainerViewInfo }

constructor TcxGridLayoutContainerViewInfo.Create(
  ARecordViewInfo: TcxGridLayoutViewRecordViewInfo);
begin
  inherited Create(ARecordViewInfo.GridView.Container);
  FRecordViewInfo := ARecordViewInfo;
end;

function TcxGridLayoutContainerViewInfo.GetGridItemViewInfo(AViewInfo: TcxGridLayoutItemViewInfo): TcxGridLayoutViewItemViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to RecordViewInfo.ItemViewInfoCount - 1 do
    if AViewInfo.Item = RecordViewInfo.ItemViewInfos[I].Item.LayoutItem then
    begin
      Result := RecordViewInfo.ItemViewInfos[I];
      Break;
    end;
end;

function TcxGridLayoutContainerViewInfo.IsClone: Boolean;
begin
  Result := True;
end;

{ TcxGridLayoutContainerFocusedController }

function TcxGridLayoutContainerFocusedController.IsFocused(AItem: TdxCustomLayoutItem): Boolean;
begin
  Result := False;
end;

{ TcxGridLayoutContainer }

procedure TcxGridLayoutContainer.DoCalculateRoot(ANeedPack: Boolean);
begin
  inherited;
  if ANeedPack then
    GridView.RecalculateCloneData;
end;

function TcxGridLayoutContainer.GetFocusedControllerClass: TdxLayoutContainerFocusedControllerClass;
begin
  Result := TcxGridLayoutContainerFocusedController;
end;

function TcxGridLayoutContainer.GetViewInfo: TcxGridLayoutContainerViewInfo;
begin
  Result := TcxGridLayoutContainerViewInfo(inherited ViewInfo);
end;

function TcxGridLayoutContainer.GetViewInfoClass: TdxLayoutContainerViewInfoClass;
begin
  Result := TcxGridCustomLayoutContainerViewInfo;
end;

function TcxGridLayoutContainer.GetGridView: TcxGridLayoutView;
begin
  Result := TcxGridLayoutView(Owner);
end;

function TcxGridLayoutContainer.IsCustomization: Boolean;
begin
  Result := Customization;
end;

///////////////////////////////// Grid classes ////////////////////////////////////////

{ TcxGridLayoutViewItemFilterButtonHitTest }

class function TcxGridLayoutViewItemFilterButtonHitTest.GetHitTestCode: Integer;
begin
  Result := htLayoutViewItemFilterButton;
end;

class function TcxGridLayoutViewItemFilterButtonHitTest.CanClick: Boolean;
begin
  Result := False;
end;

{ TcxGridLayoutViewItemCaptionHitTest }

class function TcxGridLayoutViewItemHitTest.GetHitTestCode: Integer;
begin
  Result := htLayoutViewItem;
end;

{ TcxGridLayoutViewRecordCaptionHitTest }

class function TcxGridLayoutViewRecordCaptionHitTest.GetHitTestCode: Integer;
begin
  Result := htLayoutViewRecordCaption;
end;

{ TcxGridLayoutViewItemFilterButtonPainter }

procedure TcxGridLayoutViewItemFilterButtonPainter.Paint;
begin
  with ViewInfo do
    GridViewInfo.LookAndFeelPainter.DrawFilterDropDownButton(Self.Canvas,
      Bounds, ButtonState, Active);
end;

function TcxGridLayoutViewItemFilterButtonPainter.GetViewInfo: TcxGridLayoutViewItemFilterButtonViewInfo;
begin
  Result := TcxGridLayoutViewItemFilterButtonViewInfo(inherited ViewInfo);
end;

{ TcxGridLayoutViewItemDataCellPainter }

function TcxGridLayoutViewItemDataCellPainter.GetViewInfo: TcxGridLayoutViewItemDataCellViewInfo;
begin
  Result := TcxGridLayoutViewItemDataCellViewInfo(inherited ViewInfo);
end;

{ TcxGridLayoutViewItemPainter }

procedure TcxGridLayoutViewItemPainter.AfterPaint;
begin
  if CanDrawDesignSelection then
    DrawLayoutItemSelector;
  inherited AfterPaint;
end;

procedure TcxGridLayoutViewItemPainter.DrawBackground;
var
  AState: TcxButtonState;
begin
  AState := ViewInfo.GetPaintState;
  if AState <> cxbsNormal then
    ViewInfo.LookAndFeelPainter.LayoutViewDrawItem(Canvas, ViewInfo.Bounds, AState);
end;

procedure TcxGridLayoutViewItemPainter.DrawContent;
begin
  inherited DrawContent;
  ViewInfo.DataViewInfo.Paint(Canvas);
  if ViewInfo.FilterButtonViewInfo <> nil then
    ViewInfo.FilterButtonViewInfo.Paint(Canvas);
  DrawFocusRect;
end;

procedure TcxGridLayoutViewItemPainter.DrawFocusRect;
begin
  with ViewInfo do
    if Focused then
      GridViewInfo.Painter.DrawFocusRect(Bounds, RecordViewInfo.HideFocusRectOnExit);
end;

procedure TcxGridLayoutViewItemPainter.DrawLayoutItemSelector;
var
  B: TcxBitmap32;
  R: TRect;
  AColor: TColor;
begin
  R := ViewInfo.LayoutItemSelectorBounds;
  if GetIsMainCanvasInUse(Canvas, ViewInfo) and not cxRectIsEmpty(R) then
  begin
    if ViewInfo.GetIsLayoutItemSelected then
      AColor := clGreen
    else
      AColor := clRed;
    B := TcxBitmap32.CreateSize(R);
    try
      Canvas.FrameRect(R, AColor);
      InflateRect(R, -1, -1);
      B.cxCanvas.FillRect(B.ClientRect, AColor);
      B.SetAlphaChannel(32);
      cxAlphaBlend(Canvas.Handle, B, R, B.ClientRect);
    finally
      B.Free;
    end;
  end;
end;

procedure TcxGridLayoutViewItemPainter.DrawText;
begin
  with TdxCustomLayoutItemCaptionPainter.Create(Canvas, ViewInfo.LayoutItemViewInfo.CaptionViewInfo) do
  try
    Paint;
  finally
    Free;
  end;
end;

function TcxGridLayoutViewItemPainter.GetViewInfo: TcxGridLayoutViewItemViewInfo;
begin
  Result := TcxGridLayoutViewItemViewInfo(inherited ViewInfo);
end;

{ TcxGridLayoutViewRecordExpandButtonPainter }

function TcxGridLayoutViewRecordExpandButtonPainter.GetViewInfo: TcxGridLayoutViewRecordExpandButtonViewInfo;
begin
  Result := TcxGridLayoutViewRecordExpandButtonViewInfo(inherited ViewInfo);
end;

procedure TcxGridLayoutViewRecordExpandButtonPainter.Paint;
begin
  ViewInfo.LookAndFeelPainter.DrawGroupExpandButton(Canvas,
    ViewInfo.Bounds, ViewInfo.RecordViewInfo.Expanded, ViewInfo.ButtonState);
end;

{ TcxGridLayoutViewRecordCaptionPainter }

procedure TcxGridLayoutViewRecordCaptionPainter.DrawBackground;
begin
  with ViewInfo do
    LookAndFeelPainter.LayoutViewDrawRecordCaption(Canvas, Bounds, RecordViewInfo.RecordCaptionPosition, GetState);
end;

procedure TcxGridLayoutViewRecordCaptionPainter.DrawText;
var
  R: TRect;
begin
  with Canvas, ViewInfo do
    if not RotatedText then
      inherited DrawText
    else
      if TextForPainting <> '' then
      begin
        R := TextAreaBounds;
        Font := Params.Font;
        Font.Color := Params.TextColor;
        DrawTexT(TextForPainting, R, GetTextAttributes(True), True, raPlus90);
      end;
end;

function TcxGridLayoutViewRecordCaptionPainter.GetState: TcxButtonState;
begin
  if ViewInfo.RecordViewInfo.Selected then
    Result := cxbsHot
  else
    Result := cxbsNormal;
end;

function TcxGridLayoutViewRecordCaptionPainter.GetViewInfo: TcxGridLayoutViewRecordCaptionViewInfo;
begin
  Result := TcxGridLayoutViewRecordCaptionViewInfo(inherited ViewInfo);
end;

{ TcxGridLayoutViewRecordPainter }

procedure TcxGridLayoutViewRecordPainter.AfterPaint;
begin
  inherited AfterPaint;
  Canvas.SetClipRegion(FClipRegion, roSet);
end;

procedure TcxGridLayoutViewRecordPainter.BeforePaint;
begin
  FClipRegion := Canvas.GetClipRegion;
  Canvas.IntersectClipRect(ViewInfo.Bounds);
  inherited BeforePaint;
end;

procedure TcxGridLayoutViewRecordPainter.DrawBackground;
begin
  inherited DrawBackground;
  with ViewInfo do
    LookAndFeelPainter.LayoutViewDrawRecordContent(Canvas, LayoutAreaBounds,
      RecordCaptionPosition, GetState, LayoutAreaBorders);
end;

procedure TcxGridLayoutViewRecordPainter.DrawRecordBorder;
var
  ABounds: TRect;
  AParams: TcxViewParams;
begin
  ABounds := ViewInfo.Bounds;
  ViewInfo.GetRecordBorderViewParams(AParams);
  if AParams.Bitmap = nil then
    Canvas.FrameRect(ABounds, AParams.Color, ViewInfo.RecordBorderWidth)
  else
    with ViewInfo.ContentBounds do
    begin
      Canvas.FillRect(Rect(ABounds.Left, ABounds.Top, ABounds.Right, Top), AParams.Bitmap);
      Canvas.FillRect(Rect(ABounds.Left, Top, Left, Bottom), AParams.Bitmap);
      Canvas.FillRect(Rect(Right, Top, ABounds.Right, Bottom), AParams.Bitmap);
      Canvas.FillRect(Rect(ABounds.Left, Bottom, ABounds.Right, ABounds.Bottom), AParams.Bitmap);
    end;
end;

procedure TcxGridLayoutViewRecordPainter.DrawRecordCaption;
begin
  if ViewInfo.CaptionViewInfo.Visible then
    ViewInfo.CaptionViewInfo.Paint(Canvas);
end;

procedure TcxGridLayoutViewRecordPainter.Paint;
begin
  DrawRecordCaption;
  DrawRecordBorder;
  DrawItems;
  inherited Paint;
end;

procedure TcxGridLayoutViewRecordPainter.DrawLayoutGroups;
var
  ARootViewInfo: TdxLayoutGroupViewInfo;
begin
  ARootViewInfo := ViewInfo.LayoutViewInfo.ItemsViewInfo;
  with TdxCustomLayoutItemViewInfoAccess(ARootViewInfo).GetPainterClass.Create(Canvas, ARootViewInfo) do
    try
      Paint;
    finally
      Free;
    end;
end;

procedure TcxGridLayoutViewRecordPainter.DrawExpandButton;
begin
  ViewInfo.ExpandButtonViewInfo.Paint(Canvas);
end;

function TcxGridLayoutViewRecordPainter.DrawExpandButtonBeforePaint: Boolean;
begin
  Result := False;
end;

procedure TcxGridLayoutViewRecordPainter.DrawItems;
var
  I: Integer;
begin
  if IsRecordExpanded then
  begin
    DrawLayoutGroups;
    for I := 0 to ViewInfo.ItemViewInfoCount - 1 do
      ViewInfo.ItemViewInfos[I].Paint(Canvas);
  end;
end;

function TcxGridLayoutViewRecordPainter.IsRecordExpanded: Boolean;
begin
  Result := ViewInfo.GridRecord.Expanded;
end;

function TcxGridLayoutViewRecordPainter.GetState: TcxButtonState;
begin
  if ViewInfo.Selected then
    Result := cxbsHot
  else
    Result := cxbsNormal;
end;

function TcxGridLayoutViewRecordPainter.GetViewInfo: TcxGridLayoutViewRecordViewInfo;
begin
  Result := TcxGridLayoutViewRecordViewInfo(inherited ViewInfo);
end;

{ TcxGridLayoutViewViewData }

function TcxGridLayoutViewViewData.GetRecordClass(ARecordInfo: TcxRowInfo): TcxCustomGridRecordClass;
begin
  Result := TcxGridLayoutViewRecord;
end;

{ TcxGridLayoutViewItemFilterButtonViewInfo }

constructor TcxGridLayoutViewItemFilterButtonViewInfo.Create(
  ALayoutViewItemViewInfo: TcxGridLayoutViewItemViewInfo);
begin
  inherited Create(ALayoutViewItemViewInfo.GridViewInfo);
  FItemViewInfo := ALayoutViewItemViewInfo;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.CalculateWidth: Integer;
begin
  Result := 0;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.CloseDropDownWindowOnDestruction: Boolean;
begin
  Result := False;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.DropDownWindowExists: Boolean;
begin
  Result := TcxGridLayoutView(GridView).Controller.HasFilterPopup;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.GetActive: Boolean;
begin
  Result := GetItem.Filtered;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.GetDropDownWindow: TcxCustomGridPopup;
begin
  Result := TcxGridLayoutView(GridView).Controller.FilterPopup;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.GetDropDownWindowOwnerBounds: TRect;
begin
  Result := Bounds;
  with ItemViewInfo.LayoutItemViewInfo.CaptionViewInfo.Bounds do
  begin
    Result.Left := Left;
    Result.Right := Right;
  end;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.GetDropDownWindowValue: TcxGridFilterPopup;
begin
  Result := TcxGridFilterPopup(inherited DropDownWindow);
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  if GridView.IsDesigning then
    Result := nil
  else
    Result := TcxGridLayoutViewItemFilterButtonHitTest;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.GetHotTrack: Boolean;
begin
  Result := True;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.GetItem: TcxCustomGridTableItem;
begin
  Result := ItemViewInfo.Item;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridLayoutViewItemFilterButtonPainter;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.GetVisible: Boolean;
begin
  Result := ItemViewInfo.Visible and (OccupiesSpace or
    (ItemViewInfo.State = gcsSelected) or (State = gcsPressed));
//  Result := OccupiesSpace or
//    (ItemViewInfo.State = gcsSelected) or (State = gcsPressed);
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.GetWidth: Integer;
begin
  Result := GridViewInfo.LookAndFeelPainter.FilterDropDownButtonSize.X;
end;

procedure TcxGridLayoutViewItemFilterButtonViewInfo.InitHitTest(
  AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  with TcxGridLayoutViewItemFilterButtonHitTest(AHitTest) do
  begin
    GridRecord := ItemViewInfo.GridRecord;
    Item := GetItem;
  end;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.IsDropDownWindowOwner: Boolean;
begin
  Result := inherited IsDropDownWindowOwner and (DropDownWindow.Item = GetItem);
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.NeedsContainerHotTrack: Boolean;
begin
  Result := not OccupiesSpace;
end;

function TcxGridLayoutViewItemFilterButtonViewInfo.OccupiesSpace: Boolean;
begin
  Result := TcxGridLayoutView(GridView).OptionsView.ShowItemFilterButtons = sfbAlways;
end;

{ TcxGridLayoutViewItemCellViewInfo }

constructor TcxGridLayoutViewItemCellViewInfo.Create(
  ARecordViewInfo: TcxGridLayoutViewRecordViewInfo;
  AItem: TcxGridLayoutViewItem);
begin
  inherited Create(ARecordViewInfo, AItem);
  FItem := AItem;
  FRecordViewInfo := ARecordViewInfo;
end;

function TcxGridLayoutViewItemCellViewInfo.GetGridRecord: TcxGridLayoutViewRecord;
begin
  Result := FRecordViewInfo.GridRecord;
end;

function TcxGridLayoutViewItemCellViewInfo.GetGridView: TcxGridLayoutView;
begin
  Result := TcxGridLayoutView(inherited GridView);
end;

function TcxGridLayoutViewItemCellViewInfo.GetIsDesignSelected: Boolean;
begin
  Result := False;
end;

function TcxGridLayoutViewItemCellViewInfo.IsInLayoutItemSelector(const APos: TPoint): Boolean;
begin
  Result := False;
end;

function TcxGridLayoutViewItemCellViewInfo.MouseDown(
  AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
  AShift: TShiftState): Boolean;
var
  AGridViewInfo: TcxGridLayoutViewViewInfo;
begin
  AGridViewInfo := GridView.ViewInfo;
  AGridViewInfo.AddActiveViewInfo(Self);
  try
    Result := inherited MouseDown(AHitTest, AButton, AShift);
    if AGridViewInfo.IsViewInfoActive(Self) and (AButton = mbLeft) then
      if GridView.IsDesigning then
      begin
        if IsInLayoutItemSelector(AHitTest.Pos) then
          GridView.Controller.DesignController.SelectObject(Item.LayoutItem, not (ssShift in AShift))
        else
          GridView.Controller.DesignController.SelectObject(Item, not (ssShift in AShift));
        Result := True;
      end;
  finally
    AGridViewInfo.RemoveActiveViewInfo(Self);
  end;
end;

{ TcxGridLayoutViewItemDataCellViewInfo }

constructor TcxGridLayoutViewItemDataCellViewInfo.Create(
  ALayoutViewItemViewInfo: TcxGridLayoutViewItemViewInfo);
begin
  inherited Create(ALayoutViewItemViewInfo.RecordViewInfo, ALayoutViewItemViewInfo.Item);
  FItemViewInfo := ALayoutViewItemViewInfo;
end;

function TcxGridLayoutViewItemDataCellViewInfo.GetHotTrack: Boolean;
begin
  Result := Item.GridView.OptionsBehavior.ItemHotTrack and not Item.GridView.IsDesigning;
end;

function TcxGridLayoutViewItemDataCellViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridLayoutViewItemDataCellPainter;
end;

function TcxGridLayoutViewItemDataCellViewInfo.GetTransparent: Boolean;
begin
  Result := (State = gcsSelected) or (not ItemViewInfo.Focused and (ItemViewInfo.State = gcsSelected));
end;

procedure TcxGridLayoutViewItemDataCellViewInfo.GetViewParams(
  var AParams: TcxViewParams);
begin
  Item.GridView.Styles.GetCellContentParams(GridRecord, Item, AParams);
end;

function TcxGridLayoutViewItemDataCellViewInfo.IsInLayoutItemSelector(const APos: TPoint): Boolean;
begin
  Result := ItemViewInfo.IsInLayoutItemSelector(APos);
end;

function TcxGridLayoutViewItemDataCellViewInfo.HasFocusRect: Boolean;
begin
  Result := False;
end;

procedure TcxGridLayoutViewItemDataCellViewInfo.StateChanged(APrevState: TcxGridCellState);
begin
  inherited;
  if (State = gcsSelected) and GetHotTrack and not ItemViewInfo.Focused then
  begin
    ItemViewInfo.State := gcsSelected;
    ItemViewInfo.Invalidate(False);
  end;
end;

{ TcxGridLayoutViewItemViewInfo }

constructor TcxGridLayoutViewItemViewInfo.Create(
  ARecordViewInfo: TcxGridLayoutViewRecordViewInfo;
  AItem: TcxGridLayoutViewItem);
begin
  inherited Create(ARecordViewInfo, AItem);
  CreateViewInfos;
end;

destructor TcxGridLayoutViewItemViewInfo.Destroy;
begin
  DestroyViewInfos;
  inherited Destroy;
end;

procedure TcxGridLayoutViewItemViewInfo.Calculate(const ABounds: TRect);
begin
  if LayoutItemViewInfo = nil then Exit;
  inherited Calculate(LayoutItemViewInfo.OriginalBounds);
  FDataViewInfo.Calculate(LayoutItemViewInfo.ControlViewInfo.Bounds);
  if (FilterButtonViewInfo <> nil) and FilterButtonViewInfo.Visible then
    FilterButtonViewInfo.Calculate(FilterButtonBounds);
  FLayoutItemSelectorBounds := GetLayoutItemSelectorBounds(LayoutItemViewInfo.Bounds);
  GridView.Controller.CheckFocusItem(Self);
end;

function TcxGridLayoutViewItemViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := nil;
  if (FilterButtonViewInfo <> nil) and FilterButtonViewInfo.Visible then
    Result := FilterButtonViewInfo.GetHitTest(P);

{
  if HasIndent and PtInRect(IndentBounds, P) then
  begin
    Result := TcxGridCardRowIndentHitTest.Instance(P);
    InitHitTest(Result);
    Result.ViewInfo := CardViewInfo;
  end
  else
    if HasExpandButton and PtInRect(ExpandButtonAreaBounds, P) then
    begin
      Result := TcxGridCardRowExpandButtonHitTest.Instance(P);
      InitHitTest(Result);
    end
    else
    begin
      Result := CaptionViewInfo.GetHitTest(P);
      if Result = nil then
        Result := DataViewInfo.GetHitTest(P);
    end;
}
  if (Result = nil) and DataViewInfo.Visible and cxRectPtIn(LayoutItemViewInfo.Bounds, P) then
  begin
    Result := DataViewInfo.GetHitTest(P);
    if Result = nil then
    begin
      Result := TcxGridLayoutViewItemHitTest.Instance(P);
      InitHitTest(Result);
    end;
  end;
end;

function TcxGridLayoutViewItemViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridLayoutViewItemPainter;
end;

function TcxGridLayoutViewItemViewInfo.GetTransparent: Boolean;
begin
  Result := True;//inherited GetTransparent or (Params.Color = clDefault);
end;

procedure TcxGridLayoutViewItemViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
//  GridView.Styles.GetDataCellParams(GridRecord, Item, AParams, False, nil, False{AIgnoreSelection});
//  GridView.Styles.GetDataCellParams(GridRecord, Item, AParams, False, nil, False{AIgnoreSelection});

  if Selected then
    GridView.Styles.GetSelectionParams(GridRecord, Item, AParams)
  else
    GridView.Styles.GetItemParams(GridRecord, Item, AParams);
end;

function TcxGridLayoutViewItemViewInfo.GetVisible: Boolean;
begin
  Result := inherited GetVisible and (LayoutItemViewInfo <> nil) and
    LayoutItemViewInfo.ActuallyVisible;
end;

function TcxGridLayoutViewItemViewInfo.HasFocusRect: Boolean;
begin
  Result := True;
end;

procedure TcxGridLayoutViewItemViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited InitHitTest(AHitTest);
  if AHitTest is TcxGridRecordCellHitTest then
  begin
    TcxGridRecordCellHitTest(AHitTest).Item := Item;
    TcxGridRecordCellHitTest(AHitTest).GridRecord := GridRecord;
  end;
end;

function TcxGridLayoutViewItemViewInfo.IsInLayoutItemSelector(const APos: TPoint): Boolean;
begin
  Result := cxRectPtIn(FLayoutItemSelectorBounds, APos);
end;

procedure TcxGridLayoutViewItemViewInfo.StateChanged(
  APrevState: TcxGridCellState);
begin
  inherited;
  if (FilterButtonViewInfo <> nil) and FilterButtonViewInfo.Visible then
    FilterButtonViewInfo.Invalidate;
end;

function TcxGridLayoutViewItemViewInfo.CanFocus: Boolean;
begin
  Result := Visible and LayoutItemViewInfo.Item.CanFocusControl;
end;

function TcxGridLayoutViewItemViewInfo.GetEditMinSize(AFont: TFont): TSize;
begin
  Result := Item.GetEditMinSize(AFont);
end;

function TcxGridLayoutViewItemViewInfo.GetExtraCaptionPadding: Integer;
begin
  if (FilterButtonViewInfo <> nil) and FilterButtonViewInfo.OccupiesSpace then
    Result := FilterButtonViewInfo.Width
  else
    Result := 0;
end;

class function TcxGridLayoutViewItemViewInfo.GetDataViewInfoClass: TcxGridLayoutViewItemDataCellViewInfoClass;
begin
  Result := TcxGridLayoutViewItemDataCellViewInfo;
end;

function TcxGridLayoutViewItemViewInfo.CanShowEdit: Boolean;
begin
  Result := False;
end;

function TcxGridLayoutViewItemViewInfo.GetDesignSelectionBounds: TRect;
begin
  Result := LayoutItemViewInfo.Bounds;
end;

function TcxGridLayoutViewItemViewInfo.GetFilterButtonBounds: TRect;
begin
  Result := LayoutItemViewInfo.CaptionViewInfo.Bounds;
  Inc(Result.Top);
  with Result do
  begin
    Left := Max(Left, Right - FilterButtonViewInfo.Width - cxGridCellTextOffset + LayoutItemViewInfo.ElementOffsetHorz);
    Right := Left + FilterButtonViewInfo.Width;
  end;
end;

function TcxGridLayoutViewItemViewInfo.GetFilterButtonViewInfoClass: TcxGridLayoutViewItemFilterButtonViewInfoClass;
begin
  Result := TcxGridLayoutViewItemFilterButtonViewInfo;
end;

function TcxGridLayoutViewItemViewInfo.GetFocused: Boolean;
begin
//  Result := Item.Focused and RecordViewInfo.Focused and
//    (Item.FocusedCellViewInfo = DataViewInfo);
  Result := DataViewInfo.Focused;
end;

function TcxGridLayoutViewItemViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridLayoutViewItemHitTest;
end;

function TcxGridLayoutViewItemViewInfo.GetHotTrack: Boolean;
begin
  Result := (FilterButtonViewInfo <> nil) and FilterButtonViewInfo.NeedsContainerHotTrack and
    not Item.GridView.IsDesigning;
end;

function TcxGridLayoutViewItemViewInfo.GetPaintState: TcxButtonState;
const
  ButtonStates: array[TcxGridCellState] of TcxButtonState = (cxbsNormal, cxbsHot, cxbsPressed);
begin
  if Focused then
    Result := cxbsPressed
  else
    if Item.GridView.OptionsBehavior.ItemHotTrack and GetHotTrack then
      Result := ButtonStates[State]
    else
      Result := cxbsNormal;
end;

function TcxGridLayoutViewItemViewInfo.GetIsDesignSelected: Boolean;
begin
  Result := GridView.IsDesigning and
    (GridView.Controller.DesignController.IsObjectSelected(Item) or
    GridView.Controller.DesignController.IsObjectSelected(Item.LayoutItem));
end;

function TcxGridLayoutViewItemViewInfo.GetIsLayoutItemSelected: Boolean;
begin
  Result := GridView.IsDesigning and
    GridView.Controller.DesignController.IsObjectSelected(Item.LayoutItem);
end;

function TcxGridLayoutViewItemViewInfo.GetLayoutItemSelectorBounds(
  const ABounds: TRect): TRect;
begin
  if not GridView.IsDesigning then
    Result := cxNullRect
  else
  begin
    Result := ABounds;
    Result.Right := Result.Left + 14;
    Result.Bottom := Result.Top + 14;
  end;
end;

function TcxGridLayoutViewItemViewInfo.GetLayoutItemViewInfo: TcxGridLayoutItemViewInfo;
begin
  if FLayoutItemViewInfo = nil then
    FLayoutItemViewInfo := TcxGridLayoutItemViewInfo(GridRecord.ViewInfo.LayoutViewInfo.FindItemViewInfo(Item.LayoutItem));
  Result := FLayoutItemViewInfo;
end;

function TcxGridLayoutViewItemViewInfo.GetRecordViewInfo: TcxGridLayoutViewRecordViewInfo;
begin
  Result := TcxGridLayoutViewRecordViewInfo(inherited RecordViewInfo);
end;

procedure TcxGridLayoutViewItemViewInfo.CreateViewInfos;
begin
  FDataViewInfo := GetDataViewInfoClass.Create(Self);
  if Item.CanFilter(True) then
    FFilterButtonViewInfo := GetFilterButtonViewInfoClass.Create(Self);
end;

procedure TcxGridLayoutViewItemViewInfo.DestroyViewInfos;
begin
  FreeAndNil(FFilterButtonViewInfo);
  FreeAndNil(FDataViewInfo);
end;

{ TcxGridLayoutViewRecordExpandButtonViewInfo }

constructor TcxGridLayoutViewRecordExpandButtonViewInfo.Create(
  ARecordViewInfo: TcxGridLayoutViewRecordViewInfo);
begin
  inherited Create(ARecordViewInfo.GridViewInfo);
  FRecordViewInfo := ARecordViewInfo;
end;

function TcxGridLayoutViewRecordExpandButtonViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
end;

function TcxGridLayoutViewRecordExpandButtonViewInfo.CalculateWidth: Integer;
begin
  Result := 0;
end;

function TcxGridLayoutViewRecordExpandButtonViewInfo.CaptureMouseOnPress: Boolean;
begin
  Result := True;
end;

procedure TcxGridLayoutViewRecordExpandButtonViewInfo.Click;
begin
  inherited;
  FRecordViewInfo.GridRecord.ToggleExpanded;
end;

function TcxGridLayoutViewRecordExpandButtonViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridExpandButtonHitTest;
end;

function TcxGridLayoutViewRecordExpandButtonViewInfo.GetHotTrack: Boolean;
begin
  Result := True;
end;

function TcxGridLayoutViewRecordExpandButtonViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridLayoutViewRecordExpandButtonPainter;
end;

function TcxGridLayoutViewRecordExpandButtonViewInfo.GetVisible: Boolean;
begin
  with RecordViewInfo do
    Result := GridRecord.Expandable and CaptionViewInfo.Visible;
end;

function TcxGridLayoutViewRecordExpandButtonViewInfo.HasPoint(
  const P: TPoint): Boolean;
begin
  Result := inherited HasPoint(P) and
    LookAndFeelPainter.IsPointOverGroupExpandButton(Bounds, P);
end;

procedure TcxGridLayoutViewRecordExpandButtonViewInfo.InitHitTest(
  AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  TcxGridExpandButtonHitTest(AHitTest).GridRecord := FRecordViewInfo.GridRecord;
end;

{ TcxGridLayoutViewRecordCaptionViewInfo }

constructor TcxGridLayoutViewRecordCaptionViewInfo.Create(
  ARecordViewInfo: TcxGridLayoutViewRecordViewInfo);
begin
  inherited Create(ARecordViewInfo.GridViewInfo);
  FRecordViewInfo := ARecordViewInfo;
end;

function TcxGridLayoutViewRecordCaptionViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
end;

function TcxGridLayoutViewRecordCaptionViewInfo.CalculateWidth: Integer;
begin
  Result := 0;
end;

function TcxGridLayoutViewRecordCaptionViewInfo.CustomDraw(
  ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDraw(ACanvas);
  if not Result then
    GridView.DoCustomDrawRecordHeader(ACanvas, Self, Result);
end;

function TcxGridLayoutViewRecordCaptionViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := GridView.OptionsView.RecordCaption.TextAlignmentHorz;
end;

function TcxGridLayoutViewRecordCaptionViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := GridView.OptionsView.RecordCaption.TextAlignmentVert;
end;

function TcxGridLayoutViewRecordCaptionViewInfo.GetGridRecord: TcxGridLayoutViewRecord;
begin
  Result := RecordViewInfo.GridRecord;
end;

function TcxGridLayoutViewRecordCaptionViewInfo.GetGridView: TcxGridLayoutView;
begin
  Result := TcxGridLayoutView(inherited GridView);
end;

function TcxGridLayoutViewRecordCaptionViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := nil;
end;

function TcxGridLayoutViewRecordCaptionViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridLayoutViewRecordCaptionPainter;
end;

function TcxGridLayoutViewRecordCaptionViewInfo.GetText: string;
begin
  Result := RecordViewInfo.GetRecordCaptionText;
end;

function TcxGridLayoutViewRecordCaptionViewInfo.GetRotatedText: Boolean;
begin
  Result := RecordViewInfo.IsRecordCaptionRotated;
end;

function TcxGridLayoutViewRecordCaptionViewInfo.GetTextAreaBounds: TRect;
begin
  Result := inherited GetTextAreaBounds;
  if RecordViewInfo.ExpandButtonViewInfo.Visible then
  begin
    if RotatedText then
    begin
      InflateRect(Result, -cxGridLayoutViewRecordExpandButtonOffset, 0);
      Inc(Result.Top, RecordViewInfo.ExpandButtonAreaWidth);
      Dec(Result.Bottom, cxGridLayoutViewRecordExpandButtonOffset);
    end
    else
    begin
      if RecordViewInfo.ExpandButtonAlignment = rebaRight then
      begin
        Dec(Result.Right, RecordViewInfo.ExpandButtonAreaWidth);
        Inc(Result.Left, cxGridLayoutViewRecordExpandButtonOffset);
      end
      else
      begin
        Inc(Result.Left, RecordViewInfo.ExpandButtonAreaWidth);
        Dec(Result.Right, cxGridLayoutViewRecordExpandButtonOffset);
      end;
    end;
  end
  else
    InflateRect(Result, -cxGridLayoutViewRecordExpandButtonOffset, 0);
end;

function TcxGridLayoutViewRecordCaptionViewInfo.GetTextAttributes(
  AForPainting: Boolean): Integer;
begin
  Result := inherited GetTextAttributes(AForPainting) or cxDontClip;
end;

procedure TcxGridLayoutViewRecordCaptionViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetRecordCaptionParams(GridRecord, AParams);
end;

function TcxGridLayoutViewRecordCaptionViewInfo.GetVisible: Boolean;
begin
  Result := RecordViewInfo.HasRecordCaption and inherited GetVisible;
end;

function TcxGridLayoutViewRecordCaptionViewInfo.HasCustomDraw: Boolean;
begin
  Result := GridView.HasCustomDrawRecordHeader;
end;

{ TcxGridLayoutViewRecordViewInfoCacheItem }

function TcxGridLayoutViewRecordViewInfoCacheItem.GetGridRecord: TcxGridLayoutViewRecord;
begin
  Result := TcxGridLayoutViewRecord(inherited GridRecord);
end;

procedure TcxGridLayoutViewRecordViewInfoCacheItem.SetRecordCaptionHeight(
  Value: Integer);
begin
  FRecordCaptionHeight := Value;
  FIsRecordCaptionHeightAssigned := True;
end;

procedure TcxGridLayoutViewRecordViewInfoCacheItem.UnassignValues(
  AKeepMaster: Boolean);
begin
  inherited UnassignValues(AKeepMaster);
  FIsRecordCaptionHeightAssigned := False;
end;

{ TcxGridLayoutViewRecordViewInfo }

constructor TcxGridLayoutViewRecordViewInfo.Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo; ARecord: TcxCustomGridRecord);
begin
  inherited Create(ARecordsViewInfo, ARecord);
  CreateItemViewInfos;
  FCaptionViewInfo := GetRecordCaptionViewInfoClass.Create(Self);
  FExpandButtonViewInfo := GetExpandButtonViewInfoClass.Create(Self);
  ResetCalculated;
end;

destructor TcxGridLayoutViewRecordViewInfo.Destroy;
begin
  FreeAndNil(FCaptionViewInfo);
  FreeAndNil(FExpandButtonViewInfo);
  DestroyItemViewInfos;
  FreeAndNil(FLayoutViewInfo);
  inherited Destroy;
end;

procedure TcxGridLayoutViewRecordViewInfo.BeforeRecalculation;
var
  I: Integer;
begin
  inherited BeforeRecalculation;
  for I := 0 to ItemViewInfoCount - 1 do
    ItemViewInfos[I].BeforeRecalculation;
  FExpandButtonViewInfo.BeforeRecalculation;
  FCaptionViewInfo.BeforeRecalculation;
end;

procedure TcxGridLayoutViewRecordViewInfo.Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1; AHeight: Integer = -1);
begin
  ResetCalculated;
  inherited Calculate(ALeftBound, ATopBound, AWidth, AHeight);
  if CaptionViewInfo.Visible then
    CaptionViewInfo.Calculate(RecordCaptionBounds);
  if GridRecord.Expanded then
  begin
    DoCalculateLayout;
  {
    SetRectEmpty(FScrollButtonDown.Bounds);
    SetRectEmpty(FScrollButtonUp.Bounds);
    if SupportsScrolling then
    begin
      if FScrollButtonDown.Visible then
        FScrollButtonDown.Calculate(ScrollButtonDownBounds);
      if FScrollButtonUp.Visible then
        FScrollButtonUp.Calculate(ScrollButtonUpBounds);
      //CalculateRowVisibles;
    end;
  }
    CalculateItemViewInfos;
  end;
end;

procedure TcxGridLayoutViewRecordViewInfo.MainCalculate(ALeftBound, ATopBound: Integer);
begin
  CalculateLayout;
  inherited MainCalculate(ALeftBound, ATopBound);
  if ExpandButtonViewInfo.Visible then
    ExpandButtonViewInfo.Calculate(ExpandButtonBounds);
end;

function TcxGridLayoutViewRecordViewInfo.GetBoundsForItem(AItem: TcxCustomGridTableItem): TRect;
begin
  if AItem.VisibleIndex = -1 then
    Result := inherited GetBoundsForItem(AItem)
  else
    Result := ItemViewInfos[AItem.VisibleIndex].ContentBounds;
end;

function TcxGridLayoutViewRecordViewInfo.GetCacheItem: TcxGridLayoutViewRecordViewInfoCacheItem;
begin
  Result := TcxGridLayoutViewRecordViewInfoCacheItem(inherited CacheItem);
end;

function TcxGridLayoutViewRecordViewInfo.GetCellViewInfoByItem(AItem: TcxCustomGridTableItem): TcxGridTableDataCellViewInfo;
begin
  if AItem.VisibleIndex = -1 then
    Result := nil
  else
    Result := ItemViewInfos[AItem.VisibleIndex].DataViewInfo;
end;

function TcxGridLayoutViewRecordViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
  AHitTest: TcxCustomGridHitTest;
  AItemViewInfo: TcxGridLayoutViewItemViewInfo;
begin
  Result := FExpandButtonViewInfo.GetHitTest(P);
  if Result = nil then
  begin
    Result := inherited GetHitTest(P);
    if Result <> nil then
    begin
      if GridRecord.Expandable and PtInRect(CaptionViewInfo.Bounds, P) then
      begin
        Result := TcxGridLayoutViewRecordCaptionHitTest.Instance(P);
        InitHitTest(Result);
      end
      else
      begin
        for I := 0 to ItemViewInfoCount - 1 do
        begin
          AItemViewInfo := ItemViewInfos[I];
          if AItemViewInfo.VisibleForHitTest and PtInRect(AItemViewInfo.Bounds, P) then
          begin
            AHitTest := AItemViewInfo.GetHitTest(P);
            if AHitTest <> nil then
            begin
              Result := AHitTest;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TcxGridLayoutViewRecordViewInfo.GetRecordBorderViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetRecordBorderVisualParams(GridRecord, AParams);
end;

function TcxGridLayoutViewRecordViewInfo.CalculateRecordCaptionHeight: Integer;
var
  AHeight: Integer;
  AParams: TcxViewParams;
begin
  Result := 0;
  if not HasRecordCaption then
    Exit;
  Result := GridView.OptionsView.RecordCaption.Height;
  AHeight := ExpandButtonAreaWidth;
  GridView.Styles.GetRecordCaptionParams(GridRecord, AParams);
  AHeight := Max(AHeight, cxTextHeight(AParams.Font));
  Result := Max(AHeight, Result);
end;

function TcxGridLayoutViewRecordViewInfo.GetRecordCaptionBounds: TRect;
begin
  if not HasRecordCaption then
  begin
    Result := cxEmptyRect;
    Exit;
  end;
  Result := ContentBounds;
  with GridView.OptionsView do
    InflateRect(Result, -RecordBorderWidth, -RecordBorderWidth);
  if not IsRecordCaptionRotated then
    Result.Bottom := Result.Top + GetRecordCaptionHeight;
end;

function TcxGridLayoutViewRecordViewInfo.GetRecordCaptionHeight: Integer;
begin
  if CacheItem.IsRecordCaptionHeightAssigned then
    Result := CacheItem.RecordCaptionHeight
  else
  begin
    Result := CalculateRecordCaptionHeight;
    CacheItem.RecordCaptionHeight := Result;
  end;
end;

function TcxGridLayoutViewRecordViewInfo.GetRecordCaptionText: string;
begin
  Result := GridView.OptionsView.RecordCaption.GetFormattedText(GridRecord);
end;

function TcxGridLayoutViewRecordViewInfo.GetRecordCaptionPosition: TcxGroupBoxCaptionPosition;
begin
  if not HasRecordCaption then
    Result := cxgpCenter
  else
    if IsRecordCaptionRotated then
      Result := cxgpLeft
    else
      Result := cxgpTop;
end;

function TcxGridLayoutViewRecordViewInfo.HasRecordCaption: Boolean;
begin
  Result := GridView.OptionsView.RecordCaption.Visible;
end;

function TcxGridLayoutViewRecordViewInfo.IsRecordCaptionRotated: Boolean;
begin
  Result := HasRecordCaption and not GridRecord.Expanded and
    (GridView.OptionsView.ViewMode in [lvvmSingleRow, lvvmMultiRow]);
end;

function TcxGridLayoutViewRecordViewInfo.GetLayoutAreaBorders: TcxBorders;
begin
  Result := [bLeft, bRight, bBottom];
  if not HasRecordCaption then
    Include(Result, bTop);
end;

function TcxGridLayoutViewRecordViewInfo.GetLayoutAreaBounds: TRect;
begin
  Result := ContentBounds;
  with GridView.OptionsView do
    InflateRect(Result, -RecordBorderWidth, -RecordBorderWidth);
  Inc(Result.Top,  GetRecordCaptionHeight);
end;

procedure TcxGridLayoutViewRecordViewInfo.CalculateItemViewInfos;
var
  I: Integer;
begin
  for I := 0 to ItemViewInfoCount - 1 do
    ItemViewInfos[I].Calculate(Bounds);
end;

procedure TcxGridLayoutViewRecordViewInfo.CreateItemViewInfos;
var
  I: Integer;
  AItem: TcxGridLayoutViewItem;
  AViewInfo: TcxGridLayoutViewItemViewInfo;
begin
  FItemViewInfos := TcxObjectList.Create;
  for I := 0 to GridView.VisibleItemCount - 1 do
  begin
    AItem := GridView.VisibleItems[I];
    AViewInfo := GetItemViewInfoClass.Create(Self, AItem);
    FItemViewInfos.Add(AViewInfo)
  end;
  CreateLayoutViewInfo;
end;

procedure TcxGridLayoutViewRecordViewInfo.DestroyItemViewInfos;
begin
  FreeAndNil(FLayoutViewInfo);
  FreeAndNil(FItemViewInfos);
end;

procedure TcxGridLayoutViewRecordViewInfo.CalculateLayout;
begin
  CalculateLayoutViewInfo;
end;

procedure TcxGridLayoutViewRecordViewInfo.CloneDataChangedHandler(Sender: TObject);
var
  ANeedRefresh: Boolean;
  R: TRect;
begin
  GridRecord.CloneDataStream.Position := 0;
  LayoutViewInfo.SaveCloneData(GridRecord.CloneDataStream);
  R := LayoutViewInfo.ContentBounds;
  LayoutViewInfo.DoCalculate;
  ANeedRefresh := not EqualRect(R, LayoutViewInfo.ContentBounds);
  if ANeedRefresh then
    GridView.Reposition
  else
  begin
    CalculateItemViewInfos;
    Invalidate;
  end;
end;

procedure TcxGridLayoutViewRecordViewInfo.DoCalculateLayout;
begin
  if not FLayoutCalculated then
  begin
    CalculateLayout;
    FLayoutCalculated := True;
  end;
end;

function TcxGridLayoutViewRecordViewInfo.GetItemViewInfoByItem(AItem: TcxGridLayoutViewItem): TcxGridLayoutViewItemViewInfo;
begin
  if AItem.VisibleIndex = -1 then
    Result := nil
  else
    Result := ItemViewInfos[AItem.VisibleIndex];
end;

procedure TcxGridLayoutViewRecordViewInfo.LayoutChanged;
begin
  GridRecord.CloneDataStream.Position := 0;
  CalculateLayout;
  Recalculate;
  Invalidate;
end;

procedure TcxGridLayoutViewRecordViewInfo.RecalculateCloneData;
begin
  LayoutViewInfo.Calculate;
  LayoutViewInfo.RecalculateCloneDataList;
  GridRecord.CloneDataStream.Position := 0;
  LayoutViewInfo.SaveCloneData(GridRecord.CloneDataStream);
end;

procedure TcxGridLayoutViewRecordViewInfo.ResetCalculated;
begin
  FCalculatedCaptionHeight := -1;
  FLayoutCalculated := False;
end;

procedure TcxGridLayoutViewRecordViewInfo.CalculateLayoutViewInfo;
var
  I: Integer;
begin
  for I := 0 to ItemViewInfoCount - 1 do
    ItemViewInfos[I].FLayoutItemViewInfo := nil;

  LayoutViewInfo.DoCalculate;
  LayoutViewInfo.Offset := LayoutAreaBounds.TopLeft;
end;

procedure TcxGridLayoutViewRecordViewInfo.CreateLayoutViewInfo;
begin
  FLayoutViewInfo := TcxGridLayoutContainerViewInfo.Create(Self);
  FLayoutViewInfo.OnCloneDataChanged := CloneDataChangedHandler; 
  FLayoutViewInfo.Calculate;  // CALCULATE COUNT 1
  if GridRecord.CloneDataStream.Size <> 0 then
  begin
    GridRecord.CloneDataStream.Position := 0;
    FLayoutViewInfo.LoadCloneData(GridRecord.CloneDataStream); // CALCULATE COUNT 2
  end;
end;

procedure TcxGridLayoutViewRecordViewInfo.RecreateLayoutViewInfo;
begin
  FreeAndNil(FLayoutViewInfo);
  CreateLayoutViewInfo;
end;

function TcxGridLayoutViewRecordViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridLayoutViewRecordPainter;
end;

function TcxGridLayoutViewRecordViewInfo.CalculateHeight: Integer;
begin
  Result := GetRecordCaptionHeight;
  if GridRecord.Expanded or IsRecordCaptionRotated then
//    with LayoutViewInfo.ItemsViewInfo.Bounds do
//      Inc(Result, Bottom - Top);
      Inc(Result, LayoutViewInfo.ContentHeight);
  Inc(Result, 2 * RecordBorderWidth);
end;

function TcxGridLayoutViewRecordViewInfo.GetHeight: Integer;
begin
  if CacheItem.IsHeightAssigned then
    Result := CacheItem.Height
  else
  begin
    Result := CalculateHeight;
    CacheItem.Height := Result;
  end;
end;

function TcxGridLayoutViewRecordViewInfo.GetExpandButtonViewInfoClass: TcxGridLayoutViewRecordExpandButtonViewInfoClass;
begin
  Result := TcxGridLayoutViewRecordExpandButtonViewInfo;
end;

function TcxGridLayoutViewRecordViewInfo.GetItemViewInfoClass: TcxGridLayoutViewItemViewInfoClass;
begin
  Result := TcxGridLayoutViewItemViewInfo;
end;

function TcxGridLayoutViewRecordViewInfo.GetRecordCaptionViewInfoClass: TcxGridLayoutViewRecordCaptionViewInfoClass;
begin
  Result := TcxGridLayoutViewRecordCaptionViewInfo;
end;

function TcxGridLayoutViewRecordViewInfo.GetWidth: Integer;
begin
  if IsRecordCaptionRotated then
    Result := GetRecordCaptionHeight
  else
  begin
    Result := LayoutViewInfo.ContentWidth + GridView.OptionsView.RecordBorderWidth * 2;
    Result := Max(Result, GridView.OptionsView.MinValueWidth);
  end;
end;

function TcxGridLayoutViewRecordViewInfo.HasFocusRect: Boolean;
begin
  Result := False;
end;

function TcxGridLayoutViewRecordViewInfo.GetVisible: Boolean;
begin
  if GetGridView.OptionsView.ShowOnlyEntireRecords then
    Result := Index < RecordsViewInfo.VisibleCount
  else
    Result := inherited GetVisible;
end;

procedure TcxGridLayoutViewRecordViewInfo.CalculateExpandButtonBounds(var ABounds: TRect);
var
  ASize: Integer;
begin
  ABounds := ExpandButtonAreaBounds;
  if IsRectEmpty(ABounds) then Exit;
  ASize := ExpandButtonSize;
  with ABounds do
  begin
    Left := (Left + Right - ASize) div 2;
    Right := Left + ASize;
    Top := (Top + Bottom - ASize) div 2;
    Bottom := Top + ASize;
  end;
end;

function TcxGridLayoutViewRecordViewInfo.CanGenerateExpandButtonHitTest: Boolean;
begin
  Result := False;
end;

function TcxGridLayoutViewRecordViewInfo.Click(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  if (AButton = mbLeft) and (ssDouble in AShift) and
    (AHitTest.HitTestCode = htLayoutViewRecordCaption) and GridView.OptionsBehavior.ExpandRecordOnDblClick then
  begin
    GridRecord.ToggleExpanded;
    Result := True;
  end
  else
    Result := inherited Click(AHitTest, AButton, AShift);
end;

function TcxGridLayoutViewRecordViewInfo.GetExpandButtonAlignment: TcxGridLayoutViewRecordExpandButtonAlignment;
begin
  Result := GridView.OptionsView.RecordCaption.ExpandButtonAlignment;
end;

function TcxGridLayoutViewRecordViewInfo.GetExpandButtonAreaBounds: TRect;
begin
  Result := RecordCaptionBounds;
  Result.Bottom := Result.Top + ExpandButtonAreaWidth;
  case ExpandButtonAlignment of
    rebaLeft:
      Result.Right := Result.Left + ExpandButtonAreaWidth;
    rebaRight:
      Result.Left := Result.Right - ExpandButtonAreaWidth;
  end;
end;

function TcxGridLayoutViewRecordViewInfo.GetExpandButtonAreaWidth: Integer;
begin
  Result := cxGridLayoutViewRecordExpandButtonOffset * 2 + ExpandButtonSize;
end;

function TcxGridLayoutViewRecordViewInfo.GetGridRecord: TcxGridLayoutViewRecord;
begin
  Result := TcxGridLayoutViewRecord(inherited GridRecord);
end;

function TcxGridLayoutViewRecordViewInfo.GetRecordBorderWidth: Integer;
begin
  Result := GridView.OptionsView.RecordBorderWidth;
end;

function TcxGridLayoutViewRecordViewInfo.GetExpandButtonSizeValue: Integer;
begin
  Result := GetExpandButtonSize(LookAndFeelPainter);
end;

function TcxGridLayoutViewRecordViewInfo.GetGridView: TcxGridLayoutView;
begin
  Result := TcxGridLayoutView(inherited GridView);
end;

function TcxGridLayoutViewRecordViewInfo.GetItemViewInfoCount: Integer;
begin
  Result := FItemViewInfos.Count;
end;

function TcxGridLayoutViewRecordViewInfo.GetItemViewInfos(Index: Integer): TcxGridLayoutViewItemViewInfo;
begin
  Result := TcxGridLayoutViewItemViewInfo(FItemViewInfos[Index]);
end;

{ TcxGridLayoutViewInfoHorizontalCalculator }

procedure TcxGridLayoutViewInfoHorizontalCalculator.DoCalculate(const AContentBounds: TRect);
begin
  inherited;
  if CanCenterHorizontally then
    CenterHorizontally(AContentBounds);
  if CanCenterVertically then
    CenterVertically(AContentBounds);
end;

function TcxGridLayoutViewInfoHorizontalCalculator.GetMaxCoulumnCount: Integer;
begin
  Result := RecordsViewInfo.GridView.OptionsView.MaxColumnCount;
end;

function TcxGridLayoutViewInfoHorizontalCalculator.GetMaxRowCount: Integer;
begin
  Result := RecordsViewInfo.GridView.OptionsView.MaxRowCount;
end;

function TcxGridLayoutViewInfoHorizontalCalculator.CanCenterHorizontally: Boolean;
begin
  Result := RecordsViewInfo.CanCenterRecords;
end;

function TcxGridLayoutViewInfoHorizontalCalculator.CanCenterVertically: Boolean;
begin
  Result := RecordsViewInfo.CanCenterRecords;
end;

procedure TcxGridLayoutViewInfoHorizontalCalculator.CenterHorizontally(const AContentBounds: TRect);
var
  I, J: Integer;
  AColumnCount: Integer;
  AWidth: Integer;
  AOffset: Integer;
begin
  AColumnCount := RecordsViewInfo.Bands.VisibleCount;
  AWidth := 0;
  for I := 0 to AColumnCount - 1 do
  begin
    if I > 0 then
      Inc(AWidth, RecordSpaceHorz);
    Inc(AWidth, RecordsViewInfo.GetMaxRecordWidth(I));
  end;
  AOffset := (cxRectWidth(AContentBounds) - AWidth) div (2 * AColumnCount);
  for I := 0 to RecordsViewInfo.Bands.VisibleCount - 1 do
    for J := 0 to RecordsViewInfo.Bands[I].VisibleCount - 1 do
      with TcxGridLayoutViewRecordViewInfo(RecordsViewInfo.Bands[I][J]) do
      begin
        CalculationPosition := cxPointOffset(CalculationPosition, AOffset * (1 + 2 * Col), 0);
        CalculationPosition := cxPointOffset(CalculationPosition, (Self.RecordsViewInfo.GetMaxRecordWidth(Col) - Width) div 2, 0);
      end;
end;

procedure TcxGridLayoutViewInfoHorizontalCalculator.CenterVertically(const AContentBounds: TRect);
var
  I, J: Integer;
  AColumnCount: Integer;
  ARowCount: Integer;
  AHeight: Integer;
  AOffset: Integer;
begin
  AColumnCount := RecordsViewInfo.Bands.VisibleCount;
  for I := 0 to AColumnCount - 1 do
  begin
    AHeight := 0;
    ARowCount := RecordsViewInfo.Bands[I].VisibleCount;
    for J := 0 to ARowCount - 1 do
    begin
      if J > 0 then
        Inc(AHeight, GetRecordSpaceVert);
      Inc(AHeight, RecordsViewInfo.Bands[I][J].Height);
    end;
    AOffset := (cxRectHeight(AContentBounds) - AHeight) div (2 * ARowCount);
    for J := 0 to ARowCount - 1 do
      with TcxGridLayoutViewRecordViewInfo(RecordsViewInfo.Bands[I][J]) do
        CalculationPosition := cxPointOffset(CalculationPosition, 0, AOffset * (1 + 2 * Row));
  end;
end;

function TcxGridLayoutViewInfoHorizontalCalculator.GetRecordsViewInfo: TcxGridLayoutViewRecordsViewInfo;
begin
  Result := TcxGridLayoutViewRecordsViewInfo(inherited RecordsViewInfo);
end;

{ TcxGridLayoutViewInfoVerticalCalculator }

procedure TcxGridLayoutViewInfoVerticalCalculator.DoCalculate(const AContentBounds: TRect);
begin
  inherited;
  if CanCenterHorizontally then
    CenterHorizontally(AContentBounds);
  if CanCenterVertically then
    CenterVertically(AContentBounds);
end;

function TcxGridLayoutViewInfoVerticalCalculator.GetMaxCoulumnCount: Integer;
begin
  Result := RecordsViewInfo.GridView.OptionsView.MaxColumnCount;
end;

function TcxGridLayoutViewInfoVerticalCalculator.GetMaxRowCount: Integer;
begin
  Result := RecordsViewInfo.GridView.OptionsView.MaxRowCount;
end;

function TcxGridLayoutViewInfoVerticalCalculator.CanCenterHorizontally: Boolean;
begin
  Result := RecordsViewInfo.CanCenterRecords;
end;

function TcxGridLayoutViewInfoVerticalCalculator.CanCenterVertically: Boolean;
begin
  Result := RecordsViewInfo.CanCenterRecords;
end;

procedure TcxGridLayoutViewInfoVerticalCalculator.CenterHorizontally(const AContentBounds: TRect);

  function HasBand(AColumn, ARow: Integer): Boolean;
  begin
    Result := (RecordsViewInfo.Bands.VisibleCount > AColumn) and
      (RecordsViewInfo.Bands[AColumn].VisibleCount > ARow);
  end;

var
  I, AColumn, ARow: Integer;
  AColumnCount: Integer;
  ARowCount: Integer;
  AWidth: Integer;
  AOffset: Integer;
begin
  ARowCount := GetRowCount;
  AColumnCount := RecordsViewInfo.Bands.VisibleCount;
  for ARow := 0 to ARowCount - 1 do
  begin
    AWidth := 0;
    for AColumn := 0 to AColumnCount - 1 do
      if HasBand(AColumn, ARow) then
      begin
        if AWidth > 0 then
          Inc(AWidth, GetRecordSpaceHorz);
        Inc(AWidth, RecordsViewInfo.Bands[AColumn][ARow].Width);
      end;
    AOffset := (cxRectWidth(AContentBounds) - AWidth) div (2 * AColumnCount);
    for I := 0 to AColumnCount - 1 do
      if HasBand(I, ARow) then
        with TcxGridLayoutViewRecordViewInfo(RecordsViewInfo.Bands[I][ARow]) do
          CalculationPosition := cxPointOffset(CalculationPosition, AOffset * (1 + 2 * Col), 0);
  end;
end;

procedure TcxGridLayoutViewInfoVerticalCalculator.CenterVertically(const AContentBounds: TRect);
var
  AColumn, ARow: Integer;
  ARowCount: Integer;
  AHeight: Integer;
  AOffset: Integer;
begin
  ARowCount := GetRowCount;
  AHeight := 0;
  for ARow := 0 to ARowCount - 1 do
  begin
    if ARow > 0 then
      Inc(AHeight, RecordSpaceVert);
    Inc(AHeight, RecordsViewInfo.GetMaxRecordHeight(ARow));
  end;
  AOffset := (cxRectHeight(AContentBounds) - AHeight) div (2 * ARowCount);
  for AColumn := 0 to RecordsViewInfo.Bands.VisibleCount - 1 do
    for ARow := 0 to RecordsViewInfo.Bands[AColumn].VisibleCount - 1 do
      with TcxGridLayoutViewRecordViewInfo(RecordsViewInfo.Bands[AColumn][ARow]) do
      begin
        CalculationPosition := cxPointOffset(CalculationPosition, 0, AOffset * (1 + 2 * Row));
        CalculationPosition := cxPointOffset(CalculationPosition, 0, (Self.RecordsViewInfo.GetMaxRecordHeight(Row) - Height) div 2);
      end;
end;

function TcxGridLayoutViewInfoVerticalCalculator.GetRecordsViewInfo: TcxGridLayoutViewRecordsViewInfo;
begin
  Result := TcxGridLayoutViewRecordsViewInfo(inherited RecordsViewInfo);
end;

function TcxGridLayoutViewInfoVerticalCalculator.GetRowCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to RecordsViewInfo.Bands.VisibleCount - 1 do
    Result := Max(Result, RecordsViewInfo.Bands[I].VisibleCount);
end;

{ TcxGridLayoutViewInfoSingleRecordCalculator }

function TcxGridLayoutViewInfoSingleRecordCalculator.GetMaxCoulumnCount: Integer;
begin
  Result := 1;
end;

function TcxGridLayoutViewInfoSingleRecordCalculator.GetMaxRowCount: Integer;
begin
  Result := 1;
end;

{ TcxGridLayoutViewInfoSingleColumnCalculator }

function TcxGridLayoutViewInfoSingleColumnCalculator.CanCenterVertically: Boolean;
begin
  Result := inherited CanCenterVertically and RecordsViewInfo.GridView.OptionsView.ShowOnlyEntireRecords;
end;

function TcxGridLayoutViewInfoSingleColumnCalculator.GetMaxCoulumnCount: Integer;
begin
  Result := 1;
end;

{ TcxGridLayoutViewInfoMultiColumnCalculator }


function TcxGridLayoutViewInfoMultiColumnCalculator.CanCenterHorizontally: Boolean;
begin
  Result := inherited CanCenterHorizontally and RecordsViewInfo.GridView.OptionsView.ShowOnlyEntireRecords;
end;

{ TcxGridLayoutViewInfoSingleRowCalculator }

function TcxGridLayoutViewInfoSingleRowCalculator.CanCenterHorizontally: Boolean;
begin
  Result := inherited CanCenterHorizontally and RecordsViewInfo.GridView.OptionsView.ShowOnlyEntireRecords;
end;

function TcxGridLayoutViewInfoSingleRowCalculator.GetMaxRowCount: Integer;
begin
  Result := 1;
end;

{ TcxGridLayoutViewInfoMultiRowCalculator }

function TcxGridLayoutViewInfoMultiRowCalculator.CanCenterVertically: Boolean;
begin
  Result := inherited CanCenterVertically and RecordsViewInfo.GridView.OptionsView.ShowOnlyEntireRecords;
end;

{ TcxGridLayoutViewSeparatorsViewInfo }

function TcxGridLayoutViewSeparatorsViewInfo.CalculateMaxBottom(ARow: Integer): Integer;
var
  I: Integer;
  AIsLastVisibleRow: Boolean;
begin
  Result := RecordsViewInfo.Bounds.Top;
  AIsLastVisibleRow := (RecordsViewInfo.Bands.VisibleCount > 0) and
    (ARow = RecordsViewInfo.Bands[0].VisibleCount - 1);
  for I := 0 to RecordsViewInfo.Bands.VisibleCount - 1 do
    if AIsLastVisibleRow then
      Result := Max(Result, RecordsViewInfo.Bands[I].Last.Bounds.Bottom)
    else
      if RecordsViewInfo.Bands[I].VisibleCount > ARow then
        Result := Max(Result, RecordsViewInfo.Bands[I][ARow].Bounds.Bottom)
      else
        Break;
end;

function TcxGridLayoutViewSeparatorsViewInfo.CalculateMaxRight(AColumn: Integer): Integer;
var
  I: Integer;
  AIsLastVisibleColumn: Boolean;
begin
  Result := RecordsViewInfo.Bounds.Left;
  AIsLastVisibleColumn := AColumn = RecordsViewInfo.Bands.VisibleCount - 1;
  if AIsLastVisibleColumn then
    for I := 0 to RecordsViewInfo.Bands.VisibleCount - 1 do
      Result := Max(Result, RecordsViewInfo.Bands[I].Last.Bounds.Right)
  else
    for I := 0 to RecordsViewInfo.Bands[AColumn].VisibleCount - 1 do
      Result := Max(Result, RecordsViewInfo.Bands[AColumn][I].Bounds.Right);
end;

function TcxGridLayoutViewSeparatorsViewInfo.CalculateMinLeft(AColumn: Integer): Integer;
var
  I: Integer;
begin
  Result := RecordsViewInfo.Bounds.Right;
  for I := 0 to RecordsViewInfo.Bands[AColumn].VisibleCount - 1 do
    Result := Min(Result, RecordsViewInfo.Bands[AColumn][I].Bounds.Left);
end;

function TcxGridLayoutViewSeparatorsViewInfo.CalculateMinTop(ARow: Integer): Integer;
var
  I: Integer;
begin
  Result := RecordsViewInfo.Bounds.Bottom;
  for I := 0 to RecordsViewInfo.Bands.VisibleCount - 1 do
    if RecordsViewInfo.Bands[I].VisibleCount > ARow then
      Result := Min(Result, RecordsViewInfo.Bands[I][ARow].Bounds.Top)
    else
      Break;
end;

function TcxGridLayoutViewSeparatorsViewInfo.GetRecordsViewInfo: TcxGridLayoutViewRecordsViewInfo;
begin
  Result := TcxGridLayoutViewRecordsViewInfo(inherited RecordsViewInfo);
end;

{ TcxGridLayoutViewSingleColumnRecordSeparatorsViewInfo }

procedure TcxGridLayoutViewSingleColumnRecordSeparatorsViewInfo.DoCalculate;

  procedure CalculateLeftRight(var ALeft, ARight: Integer);
  begin
    ALeft := CalculateMinLeft(0);
    ARight := CalculateMaxRight(RecordsViewInfo.Bands.VisibleCount - 1);
    ALeft := ALeft div 2;
    ARight := ARight + ALeft;
  end;

var
  I: Integer;
  R: TRect;
begin
  inherited;
  CalculateLeftRight(R.Left, R.Right);
  for I := 1 to RecordsViewInfo.Bands[0].VisibleCount - 1 do
  begin
    R.Top := CalculateMaxBottom(I - 1);
    R.Bottom := CalculateMinTop(I);
    R.Top := (R.Top + R.Bottom - Width) div 2;
    R.Bottom := R.Top + Width;
    Add(R);
  end;
end;

{ TcxGridLayoutViewSingleRowRecordSeparatorsViewInfo }

procedure TcxGridLayoutViewSingleRowRecordSeparatorsViewInfo.DoCalculate;

  procedure CalculateTopBottom(var ATop, ABottom: Integer);
  begin
    ATop := CalculateMinTop(0);
    ABottom := CalculateMaxBottom(RecordsViewInfo.Bands[0].VisibleCount - 1);
    ATop := ATop div 2;
    ABottom := ABottom + ATop;
  end;

var
  I: Integer;
  R: TRect;
begin
  inherited;

  CalculateTopBottom(R.Top, R.Bottom);
  for I := 1 to RecordsViewInfo.Bands.VisibleCount - 1 do
  begin
    R.Left := CalculateMaxRight(I - 1);
    R.Right := CalculateMinLeft(I);
    R.Left := (R.Left + R.Right - Width) div 2;
    R.Right := R.Left + Width;
    Add(R);
  end;
end;

{ TcxGridLayoutViewMultiColumnRecordSeparatorsViewInfo }

procedure TcxGridLayoutViewMultiColumnRecordSeparatorsViewInfo.DoCalculate;

  procedure CalculateLeftRight(var ALeft, ARight: Integer; AColumn: Integer);
  var
    AIsLastVisibleColumn: Boolean;
    AIsFirstVisibleColumn: Boolean;
  begin
    AIsFirstVisibleColumn := AColumn = 0;
    AIsLastVisibleColumn := AColumn = RecordsViewInfo.Bands.VisibleCount - 1;
    ALeft := CalculateMinLeft(AColumn);
    if AIsFirstVisibleColumn then
      ALeft := ALeft div 2
    else
      ALeft := (ALeft + CalculateMaxRight(AColumn - 1)) div 2;
    ARight := CalculateMaxRight(AColumn);
    if AIsLastVisibleColumn then
      ARight := (ARight + RecordsViewInfo.Bounds.Right) div 2
    else
      ARight := (ARight + CalculateMinLeft(AColumn + 1)) div 2;
  end;

var
  I, J: Integer;
  R: TRect;
begin
  inherited;
  for I := 0 to RecordsViewInfo.Bands.VisibleCount - 1 do
  begin
    CalculateLeftRight(R.Left, R.Right, I);
    for J := 1 to RecordsViewInfo.Bands[I].VisibleCount - 1 do
    begin
      R.Top := RecordsViewInfo.Bands[I][J - 1].Bounds.Bottom;
      R.Bottom := RecordsViewInfo.Bands[I][J].Bounds.Top;
      R.Top := (R.Top + R.Bottom - Width) div 2;
      R.Bottom := R.Top + Width;
      Add(R);
    end;
  end;
end;

{ TcxGridLayoutViewMultiRowRecordSeparatorsViewInfo }

procedure TcxGridLayoutViewMultiRowRecordSeparatorsViewInfo.DoCalculate;

  procedure CalculateTopBottom(var ATop, ABottom: Integer; ARow: Integer);
  var
    AIsLastVisibleRow: Boolean;
    AIsFirstVisibleRow: Boolean;
  begin
    AIsFirstVisibleRow := ARow = 0;
    AIsLastVisibleRow := ARow = RecordsViewInfo.Bands[0].VisibleCount - 1;
    ATop := CalculateMinTop(ARow);
    if AIsFirstVisibleRow then
      ATop := ATop div 2
    else
      ATop := (ATop + CalculateMaxBottom(ARow - 1)) div 2;
    ABottom := CalculateMaxBottom(ARow);
    if AIsLastVisibleRow then
      ABottom := (ABottom + RecordsViewInfo.Bounds.Bottom) div 2
    else
      ABottom := (ABottom + CalculateMinTop(ARow + 1)) div 2;
  end;

var
  I, J: Integer;
  R: TRect;
begin
  inherited;
  for I := 1 to RecordsViewInfo.Bands.VisibleCount - 1 do
    for J := 0 to RecordsViewInfo.Bands[I].VisibleCount - 1 do
    begin
      CalculateTopBottom(R.Top, R.Bottom, J);
      R.Left := RecordsViewInfo.Bands[I - 1][J].Bounds.Right;
      R.Right := RecordsViewInfo.Bands[I][J].Bounds.Left;
      R.Left := (R.Left + R.Right - Width) div 2;
      R.Right := R.Left + Width;
      Add(R);
    end;
end;

{ TcxGridLayoutViewRecordsViewInfo }

function TcxGridLayoutViewRecordsViewInfo.CalculateMaxRecordHeight: Integer;
begin
  Result := 0;
end;

function TcxGridLayoutViewRecordsViewInfo.CalculateRecordHeight: Integer;
begin
  Result := 0;
end;

function TcxGridLayoutViewRecordsViewInfo.CalculateRecordWidth: Integer;
begin
  Result := cxRectWidth(GridView.Container.ViewInfo.ItemsViewInfo.Bounds);
  Inc(Result, 2 * GridView.OptionsView.RecordBorderWidth);
end;

function TcxGridLayoutViewRecordsViewInfo.GetAutoDataRecordHeight: Boolean;
begin
  Result := AutoDataCellHeight or GridView.OptionsCustomize.RecordExpanding;
end;

function TcxGridLayoutViewRecordsViewInfo.GetCalculatorClass: TcxGridCustomLayoutRecordsViewInfoBasedCalculatorClass;
begin
  case GridView.OptionsView.ViewMode of
    lvvmSingleColumn: Result := TcxGridLayoutViewInfoSingleColumnCalculator;
    lvvmMultiColumn: Result := TcxGridLayoutViewInfoMultiColumnCalculator;
    lvvmSingleRow: Result := TcxGridLayoutViewInfoSingleRowCalculator;
    lvvmMultiRow: Result := TcxGridLayoutViewInfoMultiRowCalculator;
  else
    Result := TcxGridLayoutViewInfoSingleRecordCalculator;
  end;
end;

function TcxGridLayoutViewRecordsViewInfo.GetItemViewInfoClass: TcxGridCustomLayoutRecordViewInfoClass;
begin
  Result := TcxGridLayoutViewRecordViewInfo;
end;

function TcxGridLayoutViewRecordsViewInfo.CanCenterRecords: Boolean;
begin
  Result := GridViewInfo.CalculateDown and (VisibleCount > 0) and GridView.OptionsView.CenterRecords;
end;

function TcxGridLayoutViewRecordsViewInfo.GetGridView: TcxGridLayoutView;
begin
  Result := TcxGridLayoutView(inherited GridView);
end;

function TcxGridLayoutViewRecordsViewInfo.GetGridViewInfo: TcxGridLayoutViewViewInfo;
begin
  Result := TcxGridLayoutViewViewInfo(inherited GridViewInfo);
end;

function TcxGridLayoutViewRecordsViewInfo.GetItem(Index: Integer): TcxGridLayoutViewRecordViewInfo;
begin
  Result := TcxGridLayoutViewRecordViewInfo(inherited Items[Index]);
end;

function TcxGridLayoutViewRecordsViewInfo.GetViewData: TcxGridLayoutViewViewData;
begin
  Result := TcxGridLayoutViewViewData(inherited ViewData);
end;

{ TcxGridLayoutViewViewInfo }

function TcxGridLayoutViewViewInfo.GetRecordsViewInfoClass: TcxCustomGridRecordsViewInfoClass;
begin
  Result := TcxGridLayoutViewRecordsViewInfo;
end;

function TcxGridLayoutViewViewInfo.GetSeparatorsViewInfoClass: TcxGridCustomLayoutViewSeparatorsViewInfoClass;
const
  SeparatorsViewInfoClasses: array[TcxGridLayoutViewViewMode] of TcxGridCustomLayoutViewSeparatorsViewInfoClass =
    (TcxGridLayoutViewSingleRecordSeparatorsViewInfo,
     TcxGridLayoutViewSingleRowRecordSeparatorsViewInfo,
     TcxGridLayoutViewMultiRowRecordSeparatorsViewInfo,
     TcxGridLayoutViewSingleColumnRecordSeparatorsViewInfo,
     TcxGridLayoutViewMultiColumnRecordSeparatorsViewInfo);
begin
  Result := SeparatorsViewInfoClasses[GridView.OptionsView.ViewMode];
end;

function TcxGridLayoutViewViewInfo.GetController: TcxGridLayoutViewController;
begin
  Result := TcxGridLayoutViewController(inherited Controller);
end;

function TcxGridLayoutViewViewInfo.GetGridView: TcxGridLayoutView;
begin
  Result := inherited GridView as TcxGridLayoutView;
end;

function TcxGridLayoutViewViewInfo.GetRecordsViewInfo: TcxGridLayoutViewRecordsViewInfo;
begin
  Result := TcxGridLayoutViewRecordsViewInfo(inherited RecordsViewInfo);
end;

{ TcxGridLayoutViewItem }

destructor TcxGridLayoutViewItem.Destroy;
begin
  LayoutItem := nil;
  inherited Destroy;
end;

procedure TcxGridLayoutViewItem.Assign(Source: TPersistent);

  function FindItem: TcxGridLayoutItem;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to GridView.Container.AbsoluteItemCount - 1 do
      if (GridView.Container.AbsoluteItems[I] is TcxGridLayoutItem) and
        (TcxGridLayoutItem(GridView.Container.AbsoluteItems[I]).GridViewItem = Source) then
      begin
        Result := TcxGridLayoutItem(GridView.Container.AbsoluteItems[I]);
        Break;
      end;
  end;

var
  AItem: TcxGridLayoutItem;
begin
  inherited Assign(Source);
  if Source is TcxGridLayoutViewItem then
  begin
    if GridView.Container.Pattern = TcxGridLayoutViewItem(Source).GridView.Container then
    begin
      AItem := FindItem;
      if AItem <> nil then
        Self.LayoutItem := AItem;
    end;
  end;
end;

function TcxGridLayoutViewItem.CanAutoHeight: Boolean;
begin
  Result := False;
end;

function TcxGridLayoutViewItem.CanFocus(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := inherited CanFocus(ARecord) and not GridView.IsAssigningItems and
    (LayoutItem <> nil) and LayoutItem.Enabled;
end;

procedure TcxGridLayoutViewItem.CaptionChanged;
begin
  if LayoutItem <> nil then
    LayoutItem.Caption := Caption;
  inherited CaptionChanged;
end;

function TcxGridLayoutViewItem.GetActuallyVisible: Boolean;
begin
  Result := inherited GetActuallyVisible;
end;

procedure TcxGridLayoutViewItem.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FLayoutItem) then
    FLayoutItem := nil;
end;

procedure TcxGridLayoutViewItem.SetGridView(Value: TcxCustomGridTableView);
begin
  if GridView <> nil then
    LayoutItem := nil;
  inherited;
  if (GridView <> nil) and not GridView.IsLoading then
    LayoutItem := GridView.GetRoot.CreateItem(TcxGridLayoutItem) as TcxGridLayoutItem;
end;

procedure TcxGridLayoutViewItem.VisibleChanged;
begin
  inherited;
  if not (csDestroying in ComponentState) and (LayoutItem <> nil) then
    if Visible then
      LayoutItem.Parent := GridView.Root
    else
      LayoutItem.Parent := nil;
end;

function TcxGridLayoutViewItem.GetEditPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := PropertiesClass;
end;

function TcxGridLayoutViewItem.GetEditMinSize(AFont: TFont): TSize;
const
  cxGridLayoutViewEditMinWidth = 60;
var
  AEditStyle: TcxEditStyle;
  AEditSizeProperties: TcxEditSizeProperties;
  ACanvas: TcxCanvas;
begin
  AEditStyle := GetCellStyle;
  try
    AEditStyle.Font := AFont;
    with AEditSizeProperties do
    begin
      Height := -1;
      MaxLineCount := 0;
      Width := -1;
    end;
    ACanvas := GridView.ViewInfo.Canvas;
    Result := EditingProperties.GetEditSize(ACanvas, AEditStyle, True, Null, AEditSizeProperties);
    if Result.cx <> 0 then
    begin
      if Result.cx < cxGridLayoutViewEditMinWidth then
        Result.cx := cxGridLayoutViewEditMinWidth;
      Inc(Result.cx, 2 * cxGridEditOffset);
    end;
    if Result.cy <> 0 then
      Inc(Result.cy, 2 * cxGridEditOffset);
  finally
    ReleaseCellStyle;
  end;
end;

function TcxGridLayoutViewItem.GetGridView: TcxGridLayoutView;
begin
  Result := TcxGridLayoutView(inherited GridView);
end;

function TcxGridLayoutViewItem.GetOptions: TcxGridLayoutViewItemOptions;
begin
  Result := TcxGridLayoutViewItemOptions(inherited Options);
end;

function TcxGridLayoutViewItem.GetOptionsClass: TcxCustomGridTableItemOptionsClass;
begin
  Result := TcxGridLayoutViewItemOptions;
end;

function TcxGridLayoutViewItem.GetVisibleCaption: string;
begin
  Result := CaptionToDisplayCaption(inherited GetVisibleCaption);
end;

function TcxGridLayoutViewItem.CaptionToDisplayCaption(const ACaption: string): string;
begin
  if GridView.OptionsView.CaptionSeparator <> #0 then
    Result := ACaption + GridView.OptionsView.CaptionSeparator
  else
    Result := ACaption;
end;

function TcxGridLayoutViewItem.DisplayCaptionToCaption(const ADisplayCaption: string): string;
begin
  Result := ADisplayCaption;
  if (GridView.OptionsView.CaptionSeparator <> #0) and (Length(Result) > 0) then
    Delete(Result, Length(Result), 1);
end;

procedure TcxGridLayoutViewItem.SetLayoutInplaceItem(const Value: TcxGridLayoutItem);
begin
  if FLayoutItem <> Value then
  begin
    if FLayoutItem <> nil then
      FLayoutItem.Free;
    FLayoutItem := Value;
    if FLayoutItem <> nil then
    begin
      FLayoutItem.GridViewItem := Self;
      FLayoutItem.FreeNotification(Self);
    end;
  end;
end;

procedure TcxGridLayoutViewItem.SetOptions(Value: TcxGridLayoutViewItemOptions);
begin
  inherited Options := Value;
end;

{ TcxGridLayoutViewRecord }

function TcxGridLayoutViewRecord.GetViewInfo: TcxGridLayoutViewRecordViewInfo;
begin
  Result := TcxGridLayoutViewRecordViewInfo(inherited ViewInfo);
end;

function TcxGridLayoutViewRecord.GetViewInfoCacheItemClass: TcxCustomGridViewInfoCacheItemClass;
begin
  Result := TcxGridLayoutViewRecordViewInfoCacheItem;
end;

constructor TcxGridLayoutViewRecord.Create(
  AViewData: TcxCustomGridTableViewData; AIndex: Integer;
  const ARecordInfo: TcxRowInfo);
begin
  inherited Create(AViewData, AIndex, ARecordInfo);
  FCloneDataStream := TMemoryStream.Create;
end;

destructor TcxGridLayoutViewRecord.Destroy;
begin
  FreeAndNil(FCloneDataStream);
  inherited Destroy;
end;

function TcxGridLayoutViewRecord.GetGridView: TcxGridLayoutView;
begin
  Result := TcxGridLayoutView(inherited GridView);
end;

function TcxGridLayoutViewRecord.GetExpanded: Boolean;
begin
  Result := inherited GetExpanded or not GridView.OptionsView.RecordCaption.Visible;
end;

{ TcxGridLayoutViewControllerHelper }

function TcxGridLayoutViewControllerHelper.GetIsRecordsScrollHorizontal: Boolean;
begin
  Result := CanScrollBarVisible(sbHorizontal);
end;

function TcxGridLayoutViewControllerHelper.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
const
  ResultMap: array[Boolean] of TcxMouseWheelScrollingKind = (mwskVertical, mwskHorizontal);
begin
  Result := ResultMap[GetIsRecordsScrollHorizontal];
end;

function TcxGridLayoutViewControllerHelper.GetScrollDelta: Integer;
begin
  Result := ViewInfo.RecordsViewInfo.Bands.Count;
end;

procedure TcxGridLayoutViewControllerHelper.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_LEFT, VK_UP:
      Controller.GoToPrev(not (ssShift in Shift), False);
    VK_RIGHT, VK_DOWN:
      Controller.GoToNext(not (ssShift in Shift), False);
  end;
end;

{ TcxGridLayoutViewControllerHorizontalHelper }

function TcxGridLayoutViewControllerHorizontalHelper.CanScrollBarVisible(AKind: TScrollBarKind): Boolean;
begin
  Result := AKind = sbHorizontal;
end;

{ TcxGridLayoutViewControllerVerticalHelper }

function TcxGridLayoutViewControllerVerticalHelper.CanScrollBarVisible(AKind: TScrollBarKind): Boolean;
begin
  Result := AKind = sbVertical;
end;

{ TcxGridLayoutViewController }

function CompareItemsByTabOrder(AItem1, AItem2: Pointer): Integer;
begin
  Result := TcxGridLayoutViewItemViewInfo(AItem1).LayoutItemViewInfo.TabOrderIndex -
    TcxGridLayoutViewItemViewInfo(AItem2).LayoutItemViewInfo.TabOrderIndex;
end;

procedure TcxGridLayoutViewController.CustomizationChanged;
begin
  if Customization then
  begin
    DoCreateCustomizationForm;
    DoCustomization;
    if ShowModalCustomizationForm = mrOk then
      TcxGridLayoutViewCustomizationForm(CustomizationForm).ApplyChanges;
    Customization := False;
  end
  else
  begin
    HideCustomizationForm;
    DoCustomization;
  end;
end;

procedure TcxGridLayoutViewController.DoCreateCustomizationForm;
var
  AGridCustomizationForm: IcxGridCustomizationForm;
begin
  inherited;
  AGridCustomizationForm := ICustomizationForm;
  if AGridCustomizationForm <> nil then
    AGridCustomizationForm.Initialize(Self);
end;

function TcxGridLayoutViewController.FindNextItem(AFocusedItemIndex: Integer;
  AGoForward, AGoOnCycle, AFollowVisualOrder: Boolean;
  out ACycleChanged: Boolean; ARecord: TcxCustomGridRecord): Integer;
begin
  Result := GetNextIndex(AFocusedItemIndex, AGoForward, AGoOnCycle, ACycleChanged);
end;

function TcxGridLayoutViewController.FocusNextItemVertically(AGoForward, AGoOnCycle: Boolean): Boolean;
var
  ACycleChanged: Boolean;
  AIndex: Integer;
begin
  Result := FocusedRecordHasCells(True);
  if Result then
  begin
    if FocusedItem = nil then
      AIndex := -1
    else
      AIndex := FocusedItem.VisibleIndex;
    AIndex := GetNextIndex(AIndex, AGoForward, AGoOnCycle, ACycleChanged);
    Result := AIndex <> -1;
    if Result then
      GridView.VisibleItems[AIndex].Focused := True;
  end;
end;

function TcxGridLayoutViewController.GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := inherited GetDesignHitTest(AHitTest);
  if not Result then
    Result := AHitTest.HitTestCode in [htExpandButton, htLayoutViewItem, htCell, htRecord];
end;

function TcxGridLayoutViewController.GetHelperClass: TcxGridCustomLayoutViewControllerHelperClass;
begin
  if GridView.OptionsView.ViewMode in [lvvmSingleRecord, lvvmSingleRow, lvvmMultiRow] then
    Result := TcxGridLayoutViewControllerHorizontalHelper
  else
    Result := TcxGridLayoutViewControllerVerticalHelper;
end;

procedure TcxGridLayoutViewController.CheckFocusItem(AItemViewInfo: TcxGridLayoutViewItemViewInfo);

  function GetNextFocusedItem(AGroupViewInfo: TdxLayoutGroupViewInfo; out AFocusedItem: TcxGridLayoutViewItem): Boolean;
  var
    I: Integer;
  begin
    Result := TdxLayoutGroupViewInfoAccess(AGroupViewInfo).IsExpanded and TdxLayoutGroupViewInfoAccess(AGroupViewInfo).GetEnabled;
    if Result then
    begin
      Result := False;
      for I := 0 to AGroupViewInfo.ItemViewInfoCount - 1 do
      begin
        if AGroupViewInfo.ItemViewInfos[I] is TdxLayoutGroupViewInfo then
          Result := GetNextFocusedItem(AGroupViewInfo.ItemViewInfos[I] as TdxLayoutGroupViewInfo, AFocusedItem)
        else
          if (AGroupViewInfo.ItemViewInfos[I] is TcxGridLayoutItemViewInfo) and
            TcxGridLayoutItemViewInfo(AGroupViewInfo.ItemViewInfos[I]).GridItemViewInfo.CanFocus then
          begin
            Result := True;
            AFocusedItem := TcxGridLayoutItemViewInfo(AGroupViewInfo.ItemViewInfos[I]).GridItemViewInfo.Item;
          end;
        if Result then
          Break;
      end;
    end;
  end;

  function GetParentViewInfo(AItemViewInfo: TdxCustomLayoutItemViewInfo; out AParentViewInfo: TdxLayoutGroupViewInfo): Boolean;
  begin
    Result := AItemViewInfo.ParentViewInfo <> nil;
    if Result then
    begin
      Result := TdxCustomLayoutItemViewInfoAccess(AItemViewInfo.ParentViewInfo).IsExpanded and TdxCustomLayoutItemViewInfoAccess(AItemViewInfo.ParentViewInfo).ActuallyVisible;
      if Result then
        AParentViewInfo := AItemViewInfo.ParentViewInfo
      else
        Result := GetParentViewInfo(AItemViewInfo.ParentViewInfo, AParentViewInfo);
    end;
    if not Result then
      AParentViewInfo := nil;
  end;

var
  AFocusedItem: TcxGridLayoutViewItem;
  AParentViewInfo: TdxLayoutGroupViewInfo;
begin
  if (AItemViewInfo.Item = FocusedItem) and not AItemViewInfo.CanFocus then
  begin
    if AItemViewInfo.Item.Visible and
        GetParentViewInfo(AItemViewInfo.LayoutItemViewInfo, AParentViewInfo) and GetNextFocusedItem(AParentViewInfo, AFocusedItem) then
      FocusedItem := AFocusedItem
    else
      if not FocusFirstAvailableItem then
        FocusedItem := nil;
  end;
end;

function TcxGridLayoutViewController.GetLayoutContainerViewInfo(
  AHitTest: TcxGridRecordHitTest): TcxGridLayoutContainerViewInfo;
var
  ARecordViewInfo: TcxGridLayoutViewRecordViewInfo;
begin
  ARecordViewInfo := TcxGridLayoutViewRecordViewInfo(AHitTest.GridRecord.ViewInfo);
  Result := ARecordViewInfo.LayoutViewInfo;
end;

function TcxGridLayoutViewController.CreateCustomizationForm: TForm;
begin
  Result := TcxGridLayoutViewCustomizationForm.Create(nil);
end;

procedure TcxGridLayoutViewController.CheckCustomizationFormBounds(var R: TRect);
begin
  R := cxRectCenter(Screen.WorkAreaRect, R.Right - R.Left, R.Bottom - R.Top);
end;

function TcxGridLayoutViewController.GetCustomizationFormDefaultHeight: Integer;
begin
  Result := cxGridLayoutViewCustomizationFormDefaultHeight;
end;

function TcxGridLayoutViewController.GetNextIndex(AFocusedIndex: Integer; AGoForward, AGoOnCycle: Boolean; out ACycleChanged: Boolean): Integer;
var
  AList: TList;

  procedure PopulateItems(AList: TList);
  begin
    if GridView.IsDestroying then
      Exit;
    if FocusedRecordViewInfo <> nil then
      FocusedRecordViewInfo.LayoutViewInfo.PopulateTabOrderList(AList)
    else
      GridView.Container.ViewInfo.PopulateTabOrderList(AList);
  end;

  function CheckIndex(var AIndex: Integer): Boolean;
  begin
    Result := True;
    if AGoForward then
      if AIndex > AList.Count - 1 then
        if AGoOnCycle then
        begin
          AIndex := 0;
          ACycleChanged := True;
        end
        else
          Result := False
      else
    else
      if AIndex < 0 then
        if AGoOnCycle then
        begin
          AIndex := AList.Count - 1;
          ACycleChanged := True;
        end
        else
          Result := False;
  end;

begin
  AList := TList.Create;
  try
    PopulateItems(AList);
    if AList.Count = 0 then
      Result := -1
    else
    begin
      Result := AFocusedIndex;
      if Result = -1 then
      begin
        if AGoForward then
          Result := 0
        else
          if AGoOnCycle then
            Result := AList.Count - 1
          else
            Result := -1;
      end
      else
      begin
        Result := AList.IndexOf(GridView.VisibleItems[Result]);
        if AGoForward then
          Inc(Result)
        else
          Dec(Result);
        if not CheckIndex(Result) then
          Result := -1;
      end;
      if Result <> -1 then
        Result := TcxGridLayoutViewItem(AList[Result]).VisibleIndex;
    end;
  finally
    AList.Free;
  end;
end;

function TcxGridLayoutViewController.GetCustomizationFormDefaultWidth: Integer;
begin
  Result := cxGridLayoutViewCustomizationFormDefaultWidth;
end;

function TcxGridLayoutViewController.ShowModalCustomizationForm: Integer;
begin
  Result := CustomizationForm.ShowModal;
end;

function TcxGridLayoutViewController.GetFocusedItem: TcxGridLayoutViewItem;
begin
  Result := TcxGridLayoutViewItem(inherited FocusedItem);
end;

function TcxGridLayoutViewController.GetFocusedRecordViewInfo: TcxGridLayoutViewRecordViewInfo;
begin
  Result := TcxGridLayoutViewRecordViewInfo(inherited FocusedRecordViewInfo);
end;

function TcxGridLayoutViewController.GetGridView: TcxGridLayoutView;
begin
  Result := TcxGridLayoutView(inherited GridView);
end;

function TcxGridLayoutViewController.GetViewInfo: TcxGridLayoutViewViewInfo;
begin
  Result := TcxGridLayoutViewViewInfo(inherited ViewInfo);
end;

procedure TcxGridLayoutViewController.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
  ALayoutContainerViewInfo: TcxGridLayoutContainerViewInfo;
begin
  inherited;
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if MouseCaptureViewInfo = nil then
    if AHitTest is TcxGridRecordHitTest then
    begin
      ALayoutContainerViewInfo := GetLayoutContainerViewInfo(TcxGridRecordHitTest(AHitTest));
      ALayoutContainerViewInfo.MouseDown(Button, Shift, X, Y);
    end;
end;

procedure TcxGridLayoutViewController.MouseMove(Shift: TShiftState; X,
  Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
begin
  inherited;
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if MouseCaptureViewInfo = nil then
    if AHitTest is TcxGridRecordHitTest then
      GetLayoutContainerViewInfo(TcxGridRecordHitTest(AHitTest)).MouseMove(Shift, X, Y);
end;

procedure TcxGridLayoutViewController.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
begin
  inherited;
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if MouseCaptureViewInfo = nil then
    if AHitTest is TcxGridRecordHitTest then
      GetLayoutContainerViewInfo(TcxGridRecordHitTest(AHitTest)).MouseUp(Button, Shift, X, Y);
end;

procedure TcxGridLayoutViewController.SetFocusedItem(Value: TcxGridLayoutViewItem);
begin
  inherited FocusedItem := Value;
end;

{ TcxGridLayoutViewOptionsSelection }

constructor TcxGridLayoutViewOptionsSelection.Create(AGridView: TcxCustomGridView);
begin
  inherited Create(AGridView);
  FRecordBorderSelection := True;
end;

procedure TcxGridLayoutViewOptionsSelection.SetRecordBorderSelection(Value: Boolean);
begin
  if FRecordBorderSelection <> Value then
  begin
    FRecordBorderSelection := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridLayoutViewOptionsSelection.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridLayoutViewOptionsSelection then
    RecordBorderSelection := TcxGridLayoutViewOptionsSelection(Source).RecordBorderSelection;
end;

{ TcxGridLayoutViewOptionsBehavior }

constructor TcxGridLayoutViewOptionsBehavior.Create(AGridView: TcxCustomGridView);
begin
  inherited Create(AGridView);
  FExpandRecordOnDblClick := True;
  FItemHotTrack := True;
end;

procedure TcxGridLayoutViewOptionsBehavior.SetExpandRecordOnDblClick(
  const Value: Boolean);
begin
  if FExpandRecordOnDblClick <> Value then
  begin
    FExpandRecordOnDblClick := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridLayoutViewOptionsBehavior.SetItemHotTrack(
  const Value: Boolean);
begin
  if FItemHotTrack <> Value then
  begin
    FItemHotTrack := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridLayoutViewOptionsBehavior.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxGridLayoutViewOptionsBehavior then
  begin
    ExpandRecordOnDblClick := TcxGridLayoutViewOptionsBehavior(Source).ExpandRecordOnDblClick;
    ItemHotTrack := TcxGridLayoutViewOptionsBehavior(Source).ItemHotTrack;
  end;
end;

{ TcxGridLayoutViewOptionsCustomize }

function TcxGridLayoutViewOptionsCustomize.GetRecordExpanding: Boolean;
begin
  Result := Expandable;
end;

procedure TcxGridLayoutViewOptionsCustomize.SetRecordExpanding(Value: Boolean);
begin
  Expandable := Value;
end;

{ TcxGridLayoutViewRecordCaption }

constructor TcxGridLayoutViewRecordCaption.Create(
  AOptionsView: TcxGridLayoutViewOptionsView);
begin
  inherited Create(AOptionsView.GridView);
  FExpandButtonAlignment := rebaRight;
  FHeight := 0;
  FTextAlignmentHorz := taLeftJustify;
  FTextAlignmentVert := vaCenter;
  FVisible := True;
  DisplayMask := cxGridLayoutViewRecordCaptionDefaultMask;
end;

procedure TcxGridLayoutViewRecordCaption.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxGridLayoutViewRecordCaption then
  begin
    ExpandButtonAlignment := TcxGridLayoutViewRecordCaption(Source).ExpandButtonAlignment;
    Height := TcxGridLayoutViewRecordCaption(Source).Height;
    TextAlignmentHorz := TcxGridLayoutViewRecordCaption(Source).TextAlignmentHorz;
    TextAlignmentVert := TcxGridLayoutViewRecordCaption(Source).TextAlignmentVert;
    Visible := TcxGridLayoutViewRecordCaption(Source).Visible;
  end;
end;

function TcxGridLayoutViewRecordCaption.GetFormattedText(
  AGridRecord: TcxGridLayoutViewRecord): string;
var
  ARecordIndex, ARecordCount: string;
begin
  if AGridRecord = nil then
  begin
    Result := '';
    Exit;
  end;
  if IsNeedRecordIndex then
    ARecordIndex := IntToStr(AGridRecord.Index + 1)
  else
    ARecordIndex := '';
  if IsNeedRecordCount then
    ARecordCount := IntToStr(AGridRecord.DataController.RowCount)
  else
    ARecordCount := '';
  Result := Format(FFormatString, [ARecordIndex, ARecordCount]);
end;

procedure TcxGridLayoutViewRecordCaption.BuildFormatString;
begin
  FFormatString := cxGetNavigatorFormatString(FDisplayMask, FIsNeedRecordIndex,
    FIsNeedRecordCount);
end;

procedure TcxGridLayoutViewRecordCaption.SetDisplayMask(const Value: string);
begin
  if FDisplayMask <> Value then
  begin
    FDisplayMask := Value;
    BuildFormatString;
    Changed(vcLayout);
  end;
end;

function TcxGridLayoutViewRecordCaption.IsDisplayMaskStored: Boolean;
begin
  Result := cxGridLayoutViewRecordCaptionDefaultMask <> DisplayMask;
end;

procedure TcxGridLayoutViewRecordCaption.SetExpandButtonAlignment(
  Value: TcxGridLayoutViewRecordExpandButtonAlignment);
begin
  if FExpandButtonAlignment <> Value then
  begin
    FExpandButtonAlignment := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridLayoutViewRecordCaption.SetHeight(Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridLayoutViewRecordCaption.SetTextAlignmentHorz(
  Value: TAlignment);
begin
  if FTextAlignmentHorz <> Value then
  begin
    FTextAlignmentHorz := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridLayoutViewRecordCaption.SetTextAlignmentVert(
  Value: TcxAlignmentVert);
begin
  if FTextAlignmentVert <> Value then
  begin
    FTextAlignmentVert := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridLayoutViewRecordCaption.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(vcLayout);
  end;
end;

{ TcxGridLayoutViewOptionsView }

constructor TcxGridLayoutViewOptionsView.Create(AGridView: TcxCustomGridView);
begin
  inherited Create(AGridView);
  FCenterRecords := True;
  FMinValueWidth := cxGridLayoutViewDefaultMinValueWidth;
  FRecordBorderWidth := cxGridLayoutViewDefaultRecordBorderWidth;
  FRecordCaption := GetRecordCaptionClass.Create(Self);
  FShowOnlyEntireRecords := True;
  FViewMode := lvvmSingleRecord;
end;

destructor TcxGridLayoutViewOptionsView.Destroy;
begin
  FreeAndNil(FRecordCaption);
  inherited Destroy;
end;

procedure TcxGridLayoutViewOptionsView.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxGridLayoutViewOptionsView then
  begin
    CenterRecords := TcxGridLayoutViewOptionsView(Source).CenterRecords;
    MaxColumnCount := TcxGridLayoutViewOptionsView(Source).MaxColumnCount;
    MaxRowCount := TcxGridLayoutViewOptionsView(Source).MaxRowCount;
    MinValueWidth := TcxGridLayoutViewOptionsView(Source).MinValueWidth;
    RecordBorderWidth := TcxGridLayoutViewOptionsView(Source).RecordBorderWidth;
    RecordCaption := TcxGridLayoutViewOptionsView(Source).RecordCaption;
    ShowOnlyEntireRecords := TcxGridLayoutViewOptionsView(Source).ShowOnlyEntireRecords;
    ViewMode := TcxGridLayoutViewOptionsView(Source).ViewMode;
  end;
end;

function TcxGridLayoutViewOptionsView.GetRecordCaptionClass: TcxGridLayoutViewRecordHeaderClass;
begin
  Result := TcxGridLayoutViewRecordCaption;
end;

function TcxGridLayoutViewOptionsView.GetRecordIndent: Integer;
begin
  Result := inherited Indent;
end;

function TcxGridLayoutViewOptionsView.GetGridView: TcxGridLayoutView;
begin
  Result := TcxGridLayoutView(inherited GridView);
end;

procedure TcxGridLayoutViewOptionsView.SetCenterRecords(Value: Boolean);
begin
  if FCenterRecords <> Value then
  begin
    FCenterRecords := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridLayoutViewOptionsView.SetMaxColumnCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMaxColumnCount <> Value then
  begin
    FMaxColumnCount := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridLayoutViewOptionsView.SetMaxRowCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMaxRowCount <> Value then
  begin
    FMaxRowCount := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridLayoutViewOptionsView.SetMinValueWidth(Value: Integer);
begin
  Value := Max(Value, 8);
  if FMinValueWidth <> Value then
  begin
    FMinValueWidth := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridLayoutViewOptionsView.SetRecordBorderWidth(Value: Integer);
begin
  if FRecordBorderWidth <> Value then
  begin
    FRecordBorderWidth := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridLayoutViewOptionsView.SetRecordCaption(Value: TcxGridLayoutViewRecordCaption);
begin
  FRecordCaption.Assign(Value);
end;

procedure TcxGridLayoutViewOptionsView.SetRecordIndent(Value: Integer);
begin
  inherited Indent := Value;
end;

procedure TcxGridLayoutViewOptionsView.SetShowOnlyEntireRecords(Value: Boolean);
begin
  if FShowOnlyEntireRecords <> Value then
  begin
    FShowOnlyEntireRecords := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridLayoutViewOptionsView.SetViewMode(Value: TcxGridLayoutViewViewMode);
begin
  if FViewMode <> Value then
  begin
    FViewMode := Value;
    GridView.Controller.LayoutDirectionChanged;
    Changed(vcSize);
  end;
end;

{ TcxGridLayoutViewStyles }

constructor TcxGridLayoutViewStyles.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  BitmapInViewParams := True;
end;

procedure TcxGridLayoutViewStyles.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxGridLayoutViewStyles then
    with TcxGridLayoutViewStyles(Source) do
    begin
      Self.Item := Item;
      Self.RecordBorder := RecordBorder;
      Self.RecordCaption := RecordCaption;
      Self.OnGetItemStyle := OnGetItemStyle;
      Self.OnGetRecordBorderStyle := OnGetRecordBorderStyle;
      Self.OnGetRecordCaptionStyle := OnGetRecordCaptionStyle;
    end;
end;

procedure TcxGridLayoutViewStyles.Changed(AIndex: Integer);
var
  AParams: TcxViewParams;
begin
  GridView.Container.BeginUpdate;
  GetItemParams(nil, nil, AParams);
  GridView.LayoutLookAndFeel.ItemOptions.CaptionOptions.Font := AParams.Font;
  GridView.LayoutLookAndFeel.ItemOptions.CaptionOptions.TextColor := AParams.TextColor;
  GridView.Container.CancelUpdate;
  inherited Changed(AIndex);
end;

function TcxGridLayoutViewStyles.GetBackgroundBitmapIndex(
  Index: Integer): Integer;
begin
  Result := -1;
end;

function TcxGridLayoutViewStyles.GetDefaultBitmap(Index: Integer): TBitmap;
begin
  Index := GetBackgroundBitmapIndex(Index);
  if Index = -1 then
    Result := nil
  else
    Result := GridView.BackgroundBitmaps.GetBitmap(Index);
end;

procedure TcxGridLayoutViewStyles.GetDefaultViewParams(Index: Integer;
  AData: TObject; out AParams: TcxViewParams);
begin
  if (Index = vsRecordBorder) or (Index = vsRecordCaption) then
    GetRecordContentParams(TcxCustomGridRecord(AData), nil, AParams)
  else
  begin
    inherited;
    with AParams, LookAndFeelPainter do
      case Index of
        vsItem:
          begin
            if AData <> nil then
              with TcxGridDataCellPos(AData) do
                GetContentParams(GridRecord, Item, AParams);
            case Index of
              vsItem:
                TextColor := DefaultHeaderTextColor;
            end;
          end;
      end;
  end;
  AParams.Bitmap := GetDefaultBitmap(Index);
end;

function TcxGridLayoutViewStyles.GetGridViewValue: TcxGridLayoutView;
begin
  Result := TcxGridLayoutView(inherited GridView);
end;

procedure TcxGridLayoutViewStyles.GetItemParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
  ADataCellPos: TcxGridDataCellPos;
begin
  AStyle := nil;
  if (ARecord <> nil) and Assigned(FOnGetItemStyle) then
    FOnGetItemStyle(GridView, ARecord, AItem, AStyle);
  ADataCellPos := TcxGridDataCellPos.Create(ARecord, AItem);
  try
    GetViewParams(vsItem, ADataCellPos, AStyle, AParams);
  finally
    ADataCellPos.Free;
  end;
end;

procedure TcxGridLayoutViewStyles.GetRecordBorderParams(
  ARecord: TcxCustomGridRecord; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if (ARecord <> nil) and Assigned(FOnGetRecordBorderStyle) then
    FOnGetRecordBorderStyle(GridView, ARecord, AStyle);
  GetViewParams(vsRecordBorder, ARecord, AStyle, AParams);
end;

procedure TcxGridLayoutViewStyles.GetRecordCaptionParams(
  ARecord: TcxCustomGridRecord; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if (ARecord <> nil) and Assigned(FOnGetRecordCaptionStyle) then
    FOnGetRecordCaptionStyle(GridView, ARecord, AStyle);
  GetViewParams(vsRecordCaption, ARecord, AStyle, AParams);
end;

procedure TcxGridLayoutViewStyles.GetRecordBorderVisualParams(
  ARecord: TcxCustomGridRecord; out AParams: TcxViewParams);
begin
  if GridView.OptionsSelection.RecordBorderSelection and
    GridView.DrawRecordBorderSelected(ARecord) then
    GetSelectionParams(ARecord, nil, AParams)
  else
    GetRecordBorderParams(ARecord, AParams);
end;

procedure TcxGridLayoutViewStyles.SetOnGetItemStyle(
  Value: TcxGridGetCellStyleEvent);
begin
  if @FOnGetItemStyle <> @Value then
  begin
    FOnGetItemStyle := Value;
    GridView.Changed(vcProperty);
  end;
end;

procedure TcxGridLayoutViewStyles.SetOnGetRecordBorderStyle(Value: TcxGridGetRecordStyleEvent);
begin
  if @FOnGetRecordBorderStyle <> @Value then
  begin
    FOnGetRecordBorderStyle := Value;
    GridView.Changed(vcProperty);
  end;
end;

procedure TcxGridLayoutViewStyles.SetOnGetRecordCaptionStyle(Value: TcxGridGetRecordStyleEvent);
begin
  if @FOnGetRecordCaptionStyle <> @Value then
  begin
    FOnGetRecordCaptionStyle := Value;
    GridView.Changed(vcSize);
  end;
end;

{ TcxGridLayoutViewStyleSheet }

class function TcxGridLayoutViewStyleSheet.GetStylesClass: TcxCustomStylesClass;
begin
  Result := TcxGridLayoutViewStyles;
end;

function TcxGridLayoutViewStyleSheet.GetStylesValue: TcxGridLayoutViewStyles;
begin
  Result := TcxGridLayoutViewStyles(GetStyles);
end;

procedure TcxGridLayoutViewStyleSheet.SetStylesValue(
  Value: TcxGridLayoutViewStyles);
begin
  SetStyles(Value);
end;

{ TcxGridLayoutView }

constructor TcxGridLayoutView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLayoutLookAndFeel := CreateLayoutLookAndFeel;
  FContainer := GetLayoutContainerClass.Create(Self);
  FContainer.OnChanged := LayoutChangedHandler;
end;

destructor TcxGridLayoutView.Destroy;
begin
  FreeAndNil(FContainer);
  FreeAndNil(FLayoutLookAndFeel);
  inherited Destroy;
end;

function TcxGridLayoutView.CreateItem: TcxGridLayoutViewItem;
begin
  Result := inherited CreateItem as TcxGridLayoutViewItem;
end;

function TcxGridLayoutView.GetOptionsBehaviorClass: TcxCustomGridOptionsBehaviorClass;
begin
  Result := TcxGridLayoutViewOptionsBehavior;
end;

function TcxGridLayoutView.GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass;
begin
  Result := TcxGridLayoutViewOptionsCustomize;
end;

function TcxGridLayoutView.GetOptionsDataClass: TcxCustomGridOptionsDataClass;
begin
  Result := TcxGridLayoutViewOptionsData;
end;

function TcxGridLayoutView.GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass;
begin
  Result := TcxGridLayoutViewOptionsSelection;
end;

function TcxGridLayoutView.GetOptionsViewClass: TcxCustomGridOptionsViewClass;
begin
  Result := TcxGridLayoutViewOptionsView;
end;

procedure TcxGridLayoutView.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  inherited;
  if Root = Owner then
    Container.StoreChildren(Proc);
end;

function TcxGridLayoutView.CalculateDataCellSelected(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; AUseViewInfo: Boolean;
  ACellViewInfo: TcxGridTableCellViewInfo): Boolean;
begin
//  if TcxGridCardViewRow(AItem).Kind = rkCaption then
//    Result := inherited CalculateDataCellSelected(ARecord, AItem, AUseViewInfo, ACellViewInfo)
//  else
    Result := DrawRecordFocused(ARecord) and AItem.Focused;
end;

function TcxGridLayoutView.GetControllerClass: TcxCustomGridControllerClass;
begin
  Result := TcxGridLayoutViewController;
end;

function TcxGridLayoutView.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TcxGridDataController;
end;

function TcxGridLayoutView.GetDateTimeHandling: TcxGridLayoutViewDateTimeHandling;
begin
  Result := TcxGridLayoutViewDateTimeHandling(inherited DateTimeHandling);
end;

function TcxGridLayoutView.GetDateTimeHandlingClass: TcxCustomGridTableDateTimeHandlingClass;
begin
  Result := TcxGridLayoutViewDateTimeHandling;
end;

function TcxGridLayoutView.GetPainterClass: TcxCustomGridPainterClass;
begin
  Result := TcxGridLayoutViewPainter;
end;

function TcxGridLayoutView.GetViewDataClass: TcxCustomGridViewDataClass;
begin
  Result := TcxGridLayoutViewViewData;
end;

function TcxGridLayoutView.GetViewInfoClass: TcxCustomGridViewInfoClass;
begin
  Result := TcxGridLayoutViewViewInfo;
end;

procedure TcxGridLayoutView.SetControl(Value: TcxControl);
begin
  inherited SetControl(Value);
  if not IsDestroying then
    FLayoutLookAndFeel.LookAndFeel.MasterLookAndFeel := LookAndFeel;
end;

procedure TcxGridLayoutView.SetDateTimeHandling(Value: TcxGridLayoutViewDateTimeHandling);
begin
  inherited DateTimeHandling := Value;
end;

procedure TcxGridLayoutView.SetFiltering(Value: TcxGridLayoutViewFiltering);
begin
  inherited Filtering := Value;
end;

function TcxGridLayoutView.GetItemClass: TcxCustomGridTableItemClass;
begin
  Result := TcxGridLayoutViewItem;
end;

procedure TcxGridLayoutView.DoAssign(ASource: TcxCustomGridView);
begin
  if ASource is TcxGridLayoutView then
    CopyLayoutStructure(TcxGridLayoutView(ASource).Container);
  inherited;
end;

procedure TcxGridLayoutView.Loaded;
begin
  inherited;
  LayoutChanged(False);
end;

procedure TcxGridLayoutView.Init;
begin
  Site.DoubleBuffered := True; //!!!TODO:
  Container.CheckIndexes;
  Container.LayoutChanged(False);
  inherited;
end;

procedure TcxGridLayoutView.RecalculateCloneData;
var
  I: Integer;
begin
  for I := 0 to ViewInfo.RecordsViewInfo.Count - 1 do
    ViewInfo.RecordsViewInfo[I].RecalculateCloneData;
end;

procedure TcxGridLayoutView.AssignLayout(ALayoutView: TcxCustomGridView);
begin
  BeginUpdate;
  try
    if ALayoutView is TcxGridLayoutView then
      CopyLayoutStructure(TcxGridLayoutView(ALayoutView).Container);
    inherited AssignLayout(ALayoutView);
  finally
    EndUpdate;
  end;
end;

function TcxGridLayoutView.GetLayoutCustomizationFormButtonCaption: string;
begin
  Result := cxGetResourceString(@scxGridLayoutViewCustomizeLayoutButtonCaption);
end;

procedure TcxGridLayoutView.CopyLayoutStructure(AContainer: TcxGridLayoutContainer);
begin
  Container.BeginUpdate;
  try
    Container.CopyStructure(AContainer);
  finally
    Container.EndUpdate;
  end;
end;

function TcxGridLayoutView.CreateLayoutLookAndFeel: TcxGridLayoutLookAndFeel;
begin
  Result := TcxGridLayoutLookAndFeel.Create(Self);
end;

function TcxGridLayoutView.GetLayoutContainerClass: TcxGridLayoutContainerClass;
begin
  Result := TcxGridLayoutContainer;
end;

function TcxGridLayoutView.GetLayoutGroupClass: TdxLayoutGroupClass;
begin
  Result := TdxLayoutGroup;
end;

function TcxGridLayoutView.GetBoldFont: TFont;
begin
  Result := GetDefaultFont;
end;

function TcxGridLayoutView.GetDefaultFont: TFont;
begin
  Result := TcxControlAccess(Site).Font;
end;

function TcxGridLayoutView.CreateCustomizationControlHelper(AItem: TdxLayoutItem): TdxControlsDesignSelectorHelper;
begin
  Result := nil;
end;

procedure TcxGridLayoutView.CustomizeFormPostUpdate(AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes);
begin
end;

procedure TcxGridLayoutView.CustomizeFormUpdateList(AItem: TdxCustomLayoutItem);
begin
end;

procedure TcxGridLayoutView.PostBuildSelectionLayer;
begin
end;

procedure TcxGridLayoutView.ToggleHotTrackState(AItem: TdxCustomLayoutItem);
begin
end;

function TcxGridLayoutView.IsCustomization: Boolean;
begin
  Result := False;
end;

function TcxGridLayoutView.IsCustomizeFormOpened: Boolean;
begin
  Result := False;
end;

function TcxGridLayoutView.IsDesignSelectorsVisible: Boolean;
begin
  Result := False;
end;

procedure TcxGridLayoutView.AddAvailableItem(AItem: TdxCustomLayoutItem);
begin
  Container.AddAvailableItem(AItem);
end;

procedure TcxGridLayoutView.ExtractAvailableItem(AItem: TdxCustomLayoutItem);
begin
  Container.ExtractAvailableItem(AItem);
end;

procedure TcxGridLayoutView.SetRootGroup(Value: TdxLayoutGroup);
begin
  Container.SetRootGroup(Value);
end;

procedure TcxGridLayoutView.SetStyles(Value: TcxGridLayoutViewStyles);
begin
  inherited Styles := Value;
end;

function TcxGridLayoutView.CanGetHitTest(const P: TPoint): Boolean;
begin
  Result := True;
end;

function TcxGridLayoutView.CanProcessKeyboard: Boolean;
begin
  Result := False;
end;

function TcxGridLayoutView.CanRestore: Boolean;
begin
  Result := False;
end;

function TcxGridLayoutView.CanUpdate: Boolean;
begin
  Result := True;
end;

procedure TcxGridLayoutView.CustomizationChanged;
begin
end;

function TcxGridLayoutView.GetAutoControlAlignment: Boolean;
begin
  Result := True;
end;

function TcxGridLayoutView.GetAutoControlTabOrders: Boolean;
begin
  Result := True;
end;

function TcxGridLayoutView.GetCanvas: TcxCanvas;
begin
  Result := ViewInfo.Canvas;
end;

function TcxGridLayoutView.GetClientBounds: TRect;
begin
  Result := ViewInfo.Bounds;
end;

function TcxGridLayoutView.GetClientRect: TRect;
begin
  Result := cxRect(0, 0, ViewInfo.ClientWidth, ViewInfo.ClientHeight);
end;

function TcxGridLayoutView.GetContainer: TdxLayoutContainer;
begin
  Result := Container;
end;

function TcxGridLayoutView.GetDisabledImages: TCustomImageList;
begin
  Result := nil;
end;

function TcxGridLayoutView.GetFiltering: TcxGridLayoutViewFiltering;
begin
  Result := TcxGridLayoutViewFiltering(inherited Filtering);
end;

function TcxGridLayoutView.GetFilteringClass: TcxCustomGridTableFilteringClass;
begin
  Result := TcxGridLayoutViewFiltering;
end;

function TcxGridLayoutView.GetHighlightRoot: Boolean;
begin
  Result := False;
end;

function TcxGridLayoutView.GetImages: TCustomImageList;
begin
  Result := nil;
end;

function TcxGridLayoutView.GetIsFocusControlOnItemCaptionClick: Boolean;
begin
  Result := True;
end;

function TcxGridLayoutView.GetIsSizableHorz: Boolean;
begin
  Result := True;
end;

function TcxGridLayoutView.GetIsSizableVert: Boolean;
begin
  Result := True;
end;

function TcxGridLayoutView.GetItemsOwner: TComponent;
begin
  Result := Owner;
end;

function TcxGridLayoutView.GetItemsParent: TcxControl;
begin
  Result := Site;
end;

function TcxGridLayoutView.GetItemsParentComponent: TComponent;
begin
  Result := Self;
end;

function TcxGridLayoutView.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := FLayoutLookAndFeel;
end;

function TcxGridLayoutView.GetScrollOffset: TPoint;
begin
  Result := cxNullPoint;
end;

function TcxGridLayoutView.GetShowLockedGroupChildren: Boolean;
begin
  Result := True;
end;

function TcxGridLayoutView.GetSelectionHelperClass: TdxLayoutRunTimeSelectionHelperClass;
begin
  Result := nil;
end;

function TcxGridLayoutView.HasBackground: Boolean;
begin
  // TODO:
  Result := True;//Assigned(Styles.Content) and Assigned(Styles.Content.Bitmap);
end;

procedure TcxGridLayoutView.MakeVisible(AItem: TdxCustomLayoutItem);
begin
end;

procedure TcxGridLayoutView.Modified;
begin
end;

procedure TcxGridLayoutView.PostPlaceControls;
begin
end;

procedure TcxGridLayoutView.PostInvalidateSelectionLayer(const R: TRect);
begin
end;

procedure TcxGridLayoutView.SetName(const NewName: TComponentName);
var
  AOldName: string;
begin
  AOldName := Name;
  inherited;
  Container.CheckItemNames(AOldName, Name);
end;

procedure TcxGridLayoutView.Restore;
begin
end;

procedure TcxGridLayoutView.SizeAdjustment;
begin
end;

procedure TcxGridLayoutView.Store;
begin
end;

function TcxGridLayoutView.StoringSupports: Boolean;
begin
  Result := False;
end;

procedure TcxGridLayoutView.DoCustomDrawRecordHeader(ACanvas: TcxCanvas;
  AViewInfo: TcxGridLayoutViewRecordCaptionViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawRecordHeader then
    FOnCustomDrawRecordCaption(Self, ACanvas, AViewInfo, ADone);
end;

function TcxGridLayoutView.HasCustomDrawRecordHeader: Boolean;
begin
  Result := Assigned(FOnCustomDrawRecordCaption);
end;

function TcxGridLayoutView.DrawRecordBorderSelected(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := DrawRecordSelected(ARecord) and DrawSelection;
end;

function TcxGridLayoutView.GetControl: TcxCustomGrid;
begin
  Result := TcxCustomGrid(inherited Control);
end;

function TcxGridLayoutView.GetController: TcxGridLayoutViewController;
begin
  Result := TcxGridLayoutViewController(inherited Controller);
end;

function TcxGridLayoutView.GetItem(Index: Integer): TcxGridLayoutViewItem;
begin
  Result := TcxGridLayoutViewItem(inherited Items[Index]);
end;

function TcxGridLayoutView.GetOptionsBehavior: TcxGridLayoutViewOptionsBehavior;
begin
  Result := TcxGridLayoutViewOptionsBehavior(inherited OptionsBehavior);
end;

function TcxGridLayoutView.GetOptionsCustomize: TcxGridLayoutViewOptionsCustomize;
begin
  Result := TcxGridLayoutViewOptionsCustomize(inherited OptionsCustomize);
end;

function TcxGridLayoutView.GetOptionsData: TcxGridLayoutViewOptionsData;
begin
  Result := TcxGridLayoutViewOptionsData(inherited OptionsData);
end;

function TcxGridLayoutView.GetOptionsSelection: TcxGridLayoutViewOptionsSelection;
begin
  Result := TcxGridLayoutViewOptionsSelection(inherited OptionsSelection);
end;

function TcxGridLayoutView.GetOptionsView: TcxGridLayoutViewOptionsView;
begin
  Result := TcxGridLayoutViewOptionsView(inherited OptionsView);
end;

function TcxGridLayoutView.GetRoot: TdxLayoutGroup;
begin
  Result := Container.Root;
end;

function TcxGridLayoutView.GetStyles: TcxGridLayoutViewStyles;
begin
  Result := TcxGridLayoutViewStyles(inherited Styles);
end;

function TcxGridLayoutView.GetStylesClass: TcxCustomGridViewStylesClass;
begin
  Result := TcxGridLayoutViewStyles;
end;

function TcxGridLayoutView.GetViewInfo: TcxGridLayoutViewViewInfo;
begin
  Result := TcxGridLayoutViewViewInfo(inherited ViewInfo);
end;

function TcxGridLayoutView.GetVisibleItem(Index: Integer): TcxGridLayoutViewItem;
begin
  Result := TcxGridLayoutViewItem(inherited VisibleItems[Index]);
end;

procedure TcxGridLayoutView.LayoutChangedHandler(Sender: TObject);
begin
  Changed(vcSize);
end;

procedure TcxGridLayoutView.SetItem(Index: Integer; Value: TcxGridLayoutViewItem);
begin
  inherited Items[Index] := Value;
end;

procedure TcxGridLayoutView.SetOnCustomDrawRecordCaption(Value: TcxGridLayoutViewCustomDrawRecordHeaderEvent);
begin
  if @FOnCustomDrawRecordCaption <> @Value then
  begin
    FOnCustomDrawRecordCaption := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridLayoutView.SetOptionsBehavior(Value: TcxGridLayoutViewOptionsBehavior);
begin
  inherited OptionsBehavior := Value;
end;

procedure TcxGridLayoutView.SetOptionsCustomize(Value: TcxGridLayoutViewOptionsCustomize);
begin
  inherited OptionsCustomize := Value;
end;

procedure TcxGridLayoutView.SetOptionsData(Value: TcxGridLayoutViewOptionsData);
begin
  inherited OptionsData := Value;
end;

procedure TcxGridLayoutView.SetOptionsSelection(Value: TcxGridLayoutViewOptionsSelection);
begin
  inherited OptionsSelection := Value;
end;

procedure TcxGridLayoutView.SetOptionsView(Value: TcxGridLayoutViewOptionsView);
begin
  inherited OptionsView := Value;
end;

initialization
  RegisterClasses([TcxGridLayoutViewItem, TcxGridLayoutItem]);
  cxGridRegisteredViews.Register(TcxGridLayoutView, 'Layout');
  Classes.RegisterClasses([TcxGridLayoutView, TcxGridLayoutViewStyleSheet]);

finalization
  cxGridRegisteredViews.Unregister(TcxGridLayoutView);

end.
