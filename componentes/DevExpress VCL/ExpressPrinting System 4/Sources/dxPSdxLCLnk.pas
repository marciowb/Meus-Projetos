{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxPSdxLCLnk;

interface

{$I cxVer.inc}

uses
  Classes, Windows, Graphics, Controls, ComCtrls, dxLayoutLookAndFeels,
  dxLayoutControl, dxBase, dxPrnPg, dxPSCore, dxPSContainerLnk, cxDrawTextUtils,
  cxGeometry, dxPSReportRenderCanvas;

type
  TdxLayoutControlReportLink = class;
  TdxLayoutControlReportLinkOptionsPagination = class;
  TdxLayoutControlReportLinkOptionsTransparent = class;

  { Report Items}

  TdxLCCacheItemKind = (ikLayoutItem, ikLayoutGroup, ikLayoutItemCaption, ikControl);

  TdxLCBoundsCacheItem = class
  public
    Component: TComponent; // nil if ItemKind =  ikItemCaption
    Bounds: TRect;
    EmbeddedLink: Boolean;
  end;

  TdxReportLayoutControlHost = class(TdxReportWinControlHost)
  protected
    function GetControlItem: TdxReportVisualItem; override;
  end;
  
  TdxCustomReportLayoutItem = class(TdxReportGroup)
  private
    function GetLayoutItemBounds: TRect;
  protected
    procedure AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas); virtual;
    property LayoutItemBounds: TRect read GetLayoutItemBounds;
  public
    function LayoutItem: TdxCustomLayoutItem; overload; virtual;
  end;

  TdxReportLayoutGroup = class(TdxCustomReportLayoutItem)
  public
    function LayoutItem: TdxLayoutGroup; reintroduce; overload;
  end;
  
  TdxReportLayoutItem = class(TdxCustomReportLayoutItem)
  private
    function GetAdapter: TdxCustomLayoutControlAdapter;
    function GetCaptionBounds: TRect;  
    function GetCaptionItem: TdxReportCellString;
    function GetControl: TControl;
    function GetControlBounds: TRect;  
    function GetControlItem: TdxReportVisualItem;
    function GetHasCaptionItem: Boolean;
    function GetHasControlItem: Boolean;
    function GetIsControlAccessible: Boolean;
  protected
    procedure AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas); override;
    function CreateCaption(AReportLink: TdxLayoutControlReportLink): TdxReportCellString; virtual;
    function CreateControl(AReportLink: TdxLayoutControlReportLink): TdxReportVisualItem; virtual;
    procedure CreateNestedItems(AReportLink: TdxLayoutControlReportLink); virtual;
    function IsCreateCaption(AReportLink: TdxLayoutControlReportLink): Boolean; virtual;
    function IsCreateControl(AReportLink: TdxLayoutControlReportLink): Boolean; virtual;

    property Adapter: TdxCustomLayoutControlAdapter read GetAdapter;                                        
    property CaptionBounds: TRect read GetCaptionBounds;
    property ControlBounds: TRect read GetControlBounds;
    property IsControlAccessible: Boolean read GetIsControlAccessible;
  public
    function LayoutItem: TdxLayoutItem; reintroduce; overload;

    property CaptionItem: TdxReportCellString read GetCaptionItem;
    property Control: TControl read GetControl;
    property ControlItem: TdxReportVisualItem read GetControlItem;
    property HasCaptionItem: Boolean read GetHasCaptionItem;
    property HasControlItem: Boolean read GetHasControlItem;
  end;
 
  { Definitions }
  
  TdxPSCustomLayoutItemDefinition = class(TdxPSCustomContainerItemDefinition)
  private
    function GetLayoutItem: TdxCustomLayoutItem;
    function GetReportItem: TdxCustomReportLayoutItem;
    procedure SetLayoutItem(Value: TdxCustomLayoutItem);
  protected
    procedure AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas); virtual;
    procedure SaveOriginalItemSize; virtual;
    procedure SetupOriginalControlSize; virtual;
  public
    function OptionsPagination: TdxLayoutControlReportLinkOptionsPagination; reintroduce; overload;
    property LayoutItem: TdxCustomLayoutItem read GetLayoutItem write SetLayoutItem;
    property ReportItem: TdxCustomReportLayoutItem read GetReportItem;
  end;
  
  TdxPSLayoutGroupDefinition = class(TdxPSCustomLayoutItemDefinition)
  private
    function GetLayoutItem: TdxLayoutGroup;
  protected
    procedure AddDelimitersHorz(AList: TList); override;
    procedure AddDelimitersVert(AList: TList); override;
  public  
    property LayoutItem: TdxLayoutGroup read GetLayoutItem;
  end;
  
  TdxPSLayoutItemDefinition = class(TdxPSCustomLayoutItemDefinition)
  private
    function GetLayoutItem: TdxLayoutItem;
    function GetReportItem: TdxReportLayoutItem;
  protected
    procedure AddDelimitersHorz(AList: TList); override;
    procedure AddDelimitersVert(AList: TList); override; 
    procedure SaveOriginalItemSize; override;
    procedure SetupOriginalControlSize; override;
  public  
    property LayoutItem: TdxLayoutItem read GetLayoutItem;
    property ReportItem: TdxReportLayoutItem read GetReportItem;
  end;
  
  { Producers }
    
  TdxPSLayoutControlObjectProducer = class(TdxPSCustomProducer)
  public
    function ReportLink: TdxLayoutControlReportLink; reintroduce; overload;
    function RootContainer: TdxLayoutControl; reintroduce; overload;
  end;

  TdxPSLayoutLookAndFeelProducerClass = class of TdxPSLayoutLookAndFeelProducer;
  
  TdxPSLayoutLookAndFeelProducer = class(TdxPSLayoutControlObjectProducer)
  protected
    function GetContentColor: TColor; virtual;
    function GetGroupCaptionColor: TColor; virtual;
    function GetIsContentTransparent: Boolean; virtual;
    function GetIsGroupCaptionTransparent: Boolean; virtual;
    function GetTransparentColor: TColor; virtual;

    procedure InitializeReportLookAndFeel(ALookAndFeel: TdxPSReportGroupLookAndFeel); virtual;
    class function ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass; virtual;
    
    property GroupCaptionColor: TColor read GetGroupCaptionColor;
    property IsGroupCaptionTransparent: Boolean read GetIsGroupCaptionTransparent;
  public
    function LayoutLookAndFeel: TdxCustomLayoutLookAndFeel; overload; virtual;
    class function LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass; virtual;

    class function PairClass: TClass; override;
    class procedure Register; override;
    class procedure Unregister; override;

    property ContentColor: TColor read GetContentColor;
    property IsContentTransparent: Boolean read GetIsContentTransparent;
    property TransparentColor: TColor read GetTransparentColor;
  end;

  TdxPSLayoutStandardLookAndFeelProducer = class(TdxPSLayoutLookAndFeelProducer)
  protected
    function GetTransparentColor: TColor; override;
    class function ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass; override;
  public
    function LayoutLookAndFeel: TdxLayoutStandardLookAndFeel; reintroduce; overload;
    class function LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass; override;
  end;

  TdxPSLayoutOfficeLookAndFeelProducer = class(TdxPSLayoutStandardLookAndFeelProducer)
  protected
    class function ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass; override;
  public
    function LayoutLookAndFeel: TdxLayoutOfficeLookAndFeel; reintroduce; overload;
    class function LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass; override;
  end;

  TdxPSLayoutWebLookAndFeelProducer = class(TdxPSLayoutLookAndFeelProducer)
  protected
    function GetGroupCaptionColor: TColor; override;
    function GetTransparentColor: TColor; override;
    procedure InitializeReportLookAndFeel(ALookAndFeel: TdxPSReportGroupLookAndFeel); override;
    class function ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass; override;
  public
    function LayoutLookAndFeel: TdxLayoutWebLookAndFeel; reintroduce; overload;
    class function LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass; override;
    
    property GroupCaptionColor;
    property IsGroupCaptionTransparent;
  end;

  TdxPSCustomLayoutItemProducerClass = class of TdxPSCustomLayoutItemProducer;
  
  TdxPSCustomLayoutItemProducer = class(TdxPSLayoutControlObjectProducer)
  private
    function GetLayoutItemBounds: TRect;
  protected
    function GetContentColor: TColor; virtual;
    function GetIsContentTransparent: Boolean; virtual;
    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel; virtual;
    function GetLayoutLookAndFeelProducer: TdxPSLayoutLookAndFeelProducer;

    procedure InitializeReportItem(AnItem: TdxReportCell); virtual;
    class function ReportItemClass: TdxReportCellClass; virtual;

    function OptionsTransparent: TdxLayoutControlReportLinkOptionsTransparent; reintroduce; overload;

    procedure AdjustBounds; virtual;
    procedure SaveOriginalItemSize;
  public
    function Definition: TdxPSCustomLayoutItemDefinition; reintroduce; overload;
    class function DefinitionClass: TdxPSCustomContainerItemDefinitionClass; override; 

    function LayoutItem: TdxCustomLayoutItem; overload; virtual; 
    class function LayoutItemClass: TdxCustomLayoutItemClass; virtual;

    class function PairClass: TClass; override;
    function ProducingObjectFriendlyName: string; override;
    procedure Reposition; override;

    class procedure Register; override;
    class procedure Unregister; override;

    property ContentColor: TColor read GetContentColor;
    property IsContentTransparent: Boolean read GetIsContentTransparent;
    property LayoutItemBounds: TRect read GetLayoutItemBounds;
    property LayoutLookAndFeel: TdxCustomLayoutLookAndFeel read GetLayoutLookAndFeel;
    property LayoutLookAndFeelProducer: TdxPSLayoutLookAndFeelProducer read GetLayoutLookAndFeelProducer;
  end;

  TdxPSLayoutGroupProducer = class(TdxPSCustomLayoutItemProducer)
  protected
    function GetGroupCaptionContentColor: TColor; virtual;
    function GetIsGroupCaptionTransparent: Boolean; virtual;
    procedure InitializeReportItem(AnItem: TdxReportCell); override;
    class function ReportItemClass: TdxReportCellClass; override;
  public
    function Definition: TdxPSLayoutGroupDefinition; reintroduce; overload; 
    class function DefinitionClass: TdxPSCustomContainerItemDefinitionClass; override; 

    function LayoutItem: TdxLayoutGroup; reintroduce; overload; 
    class function LayoutItemClass: TdxCustomLayoutItemClass; override;    

    function ProducingObjectFriendlyName: string; override;
    procedure Reposition; override;
    
    property GroupCaptionContentColor: TColor read GetGroupCaptionContentColor;
    property IsGroupCaptionTransparent: Boolean read GetIsGroupCaptionTransparent;
  end;

  TdxPSLayoutItemProducer = class(TdxPSCustomLayoutItemProducer)
  private
    function GetControl: TControl;
    function GetHasControl: Boolean;
  protected
    function GetContentColor: TColor; override;
    procedure InitializeReportItem(AnItem: TdxReportCell); override;
    class function ReportItemClass: TdxReportCellClass; override;
  public
    function Definition: TdxPSLayoutItemDefinition; reintroduce; overload; 
    class function DefinitionClass: TdxPSCustomContainerItemDefinitionClass; override; 

    function LayoutItem: TdxLayoutItem; reintroduce; overload; 
    class function LayoutItemClass: TdxCustomLayoutItemClass; override;

    function ProducingObjectFriendlyName: string; override;
    procedure Reposition; override;
    
    property Control: TControl read GetControl;
    property HasControl: Boolean read GetHasControl;
  end;

  { Caches }
  
  TdxPSCustomLayoutObjectProducerCache = class(TdxPSContainerReportLinkCustomCache)
  public
    function ReportLink: TdxLayoutControlReportLink; reintroduce; overload;
  end;
  
  TdxPSLayoutItemProducerCache = class(TdxPSCustomLayoutObjectProducerCache)
  private
    function GetItem(Index: Integer): TdxPSCustomLayoutItemProducer;
    function GetProducer(AProducerClass: TdxPSCustomLayoutItemProducerClass; 
      ALayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducer;
  protected 
    property Items[Index: Integer]: TdxPSCustomLayoutItemProducer read GetItem;
  public
    property Producers[AProducerClass: TdxPSCustomLayoutItemProducerClass; 
      ALayoutItem: TdxCustomLayoutItem]: TdxPSCustomLayoutItemProducer read GetProducer; default;
  end;

  TdxPSLayoutLookAndFeelProducerCache = class(TdxPSCustomLayoutObjectProducerCache)
  private
    function GetItem(Index: Integer): TdxPSLayoutLookAndFeelProducer;
    function GetProducer(AProducerClass: TdxPSLayoutLookAndFeelProducerClass; 
      ALayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSLayoutLookAndFeelProducer;
  protected 
    property Items[Index: Integer]: TdxPSLayoutLookAndFeelProducer read GetItem;
  public
    property Producers[AProducerClass: TdxPSLayoutLookAndFeelProducerClass; 
      ALayoutLookAndFeel: TdxCustomLayoutLookAndFeel]: TdxPSLayoutLookAndFeelProducer read GetProducer; default;
  end;

  TdxPSNativeLayoutControlProducer = class(TdxPSNativePrintableControlProducer)
  public
    function Control: TdxCustomLayoutControl; reintroduce; overload;
    class function ControlClass: TControlClass; override;

    class function HasNativeSupportForBorders: Boolean; override;
    
    function ObjectExpandHeight: Boolean; override;
    function ObjectExpandWidth: Boolean; override;
  end;
  
  TdxPSLayoutControlProducer = class(TdxPSRootContainerProducer)
  private
    function GetAvailableBounds: TRect;
    function GetProducer(LayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducer;
  protected
    procedure CreateLayoutItems(AnItem: TdxReportVisualItem); virtual;
    procedure GetLayoutItemList(AnItems: TList);
    function HostClass: TdxReportCellClass; override;
    procedure InitializeHost(ACell: TdxReportCell); override;
    procedure InitializeItem(AnItem: TdxReportVisualItem); override;
    function ItemClass: TdxReportVisualItemClass; override;
    procedure ReportLinkInitializeItem(AnItem: TdxReportVisualItem);

    property AvailableBounds: TRect read GetAvailableBounds;
    property Producers[LayoutItem: TdxCustomLayoutItem]: TdxPSCustomLayoutItemProducer read GetProducer;
  public
    class function CanHasAvailableChildren: Boolean; override;
    class function Reenterable: Boolean; override;

    function Control: TdxLayoutControl; reintroduce; overload;
    class function ControlClass: TControlClass; override;

    class function HasNativeSupportForBorders: Boolean; override;
    
    function ObjectExpandHeight: Boolean; override;
    function ObjectExpandWidth: Boolean; override;
    
    function ReportLink: TdxLayoutControlReportLink; reintroduce; overload;
    procedure Reposition; override;
  end;

  PdxPSLayoutCacheFontItem = ^TdxPSLayoutCacheFontItem;
  TdxPSLayoutCacheFontItem = record
    CaptionOptions: TdxLayoutLookAndFeelCaptionOptions;
    FontIndex: Integer; 
  end;
  
  { Options }
  
  TdxLayoutControlReportLinkOptionsPaginationClass = class of TdxLayoutControlReportLinkOptionsPagination;
  
  TdxLayoutControlReportLinkOptionsPagination = class(TdxCustomContainerReportLinkOptionsPagination)
  private
    FGroups: Boolean;
    FItems: Boolean;
    procedure SetGroups(Value: Boolean);
    procedure SetItems(Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published  
    property Groups: Boolean read FGroups write SetGroups default True;
    property Items: Boolean read FItems write SetItems default True;
  end;
  
  TdxLayoutControlReportLinkOptionsSizeClass = class of TdxLayoutControlReportLinkOptionsSize;

  TdxLayoutControlReportLinkOptionsSize = class(TdxCustomContainerReportLinkOptions)
  private
    FAutoWidth: Boolean;
    procedure SetAutoWidth(Value: Boolean);
  public    
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property AutoWidth: Boolean read FAutoWidth write SetAutoWidth default True;
  end;
  
  TdxLayoutControlReportLinkOptionsTransparent = class(TdxCustomContainerReportLinkOptionsTransparent)
  private
    FGroups: Boolean;
    FItems: Boolean;
    procedure SetGroups(Value: Boolean);
    procedure SetItems(Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published  
    property Groups: Boolean read FGroups write SetGroups default True;
    property Items: Boolean read FItems write SetItems default True;
  end;
  
  { Report Link }
  
  TdxLayoutControlReportLink = class(TdxCustomContainerReportLink, IUnknown, IdxReportLinkController)
  private
    FCachedBounds: TList; 
    FCachedFonts: TList;
    FCurrentLayoutItem: TdxCustomLayoutItem;
    FLayoutItemProducerCache: TdxPSLayoutItemProducerCache;
    FLayoutLookAndFeelProducerCache: TdxPSLayoutLookAndFeelProducerCache;
    FOptionsSize: TdxLayoutControlReportLinkOptionsSize;
    function GetAvailableBounds: TRect;
    function GetCachedBoundsCount: Integer;
    function GetCachedBoundsItem(Index: Integer): TdxLCBoundsCacheItem;
    function GetCachedFontItem(Index: Integer): PdxPSLayoutCacheFontItem;
    function GetCachedFontItemCount: Integer;
    function GetCurrentHost: TdxReportCell;
    function GetLayoutControl: TdxLayoutControl;
    function GetLayoutItemProducer(LayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducer;
    function GetLayoutLookAndFeelProducer(LayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSLayoutLookAndFeelProducer;
    function GetOptionsPagination: TdxLayoutControlReportLinkOptionsPagination;
    function GetOptionsTransparent: TdxLayoutControlReportLinkOptionsTransparent;
    function GetRootLayoutGroup: TdxLayoutGroup;
    procedure SetOptionsPagination(Value: TdxLayoutControlReportLinkOptionsPagination);
    procedure SetOptionsSize(Value: TdxLayoutControlReportLinkOptionsSize);
    procedure SetOptionsTransparent(Value: TdxLayoutControlReportLinkOptionsTransparent);
  protected
    function GetRebuildOnPageParamsChange(AUpdateCodes: TdxPrinterPageUpdateCodes): Boolean; override;
    procedure InternalRestoreDefaults; override;

    procedure CacheControlsBounds;
    procedure ConstructReport(AReportCells: TdxReportCells); override;
    procedure PostCheckEmbeddedControls;
    procedure PrepareConstruct; override;
    procedure PrepareLookAndFeels;
    procedure RepositionControls; override;

    procedure AddHiddenItem(ATreeView: TTreeView; AParent: TTreeNode; AnItem: TdxCustomLayoutItem);
    procedure AddItem(ATreeView: TTreeView; AParent: TTreeNode; AnItem: TdxCustomLayoutItem);
    function IsComponentEditable(AComponent: TComponent): Boolean; override;
    procedure LoadControlsTree(ATreeView: TTreeView); override;
    procedure LoadHiddenControlsTree(ATreeView: TTreeView); override;
    function AddBoundsToCache(AComponent: TComponent; const ABounds: TRect): Integer;
    function AddCaptionOptionsFontToCache(ACaptionOptions: TdxLayoutLookAndFeelCaptionOptions): Integer;
    procedure ClearCachedBounds;
    procedure ClearCachedFonts;
    function FindBoundsByComponent(AComponent: TComponent; var ABounds: TRect; ASetEmbedded: Boolean): Boolean;
    function FindFontIndexByCaptionOptions(ACaptionOptions: TdxLayoutLookAndFeelCaptionOptions): Integer;
    procedure FreeAndNilCachedBounds;
    procedure FreeAndNilCachedFonts;

    procedure CreateOptions; override;
    procedure DestroyOptions; override;
    function GetOptionsPaginationClass: TdxCustomContainerReportLinkOptionsPaginationClass; override;
    function GetOptionsSizeClass: TdxLayoutControlReportLinkOptionsSizeClass; virtual;
    function GetOptionsTransparentClass: TdxCustomContainerReportLinkOptionsTransparentClass; override;

    function FindReportGroupLookAndFeel(ALayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSReportGroupLookAndFeel;
    function FindReportItemByLayoutItem(ALayoutItem: TdxCustomLayoutItem): TdxReportCell;
    procedure GetLayoutItemList(AControl: TdxLayoutControl; AnItems: TList);
    function GetPreparedFontIndex(ACaptionOptions: TdxLayoutLookAndFeelCaptionOptions): Integer; overload;
    // IdxReportLinkController
    function GetControlSiteBounds(AControl: TControl): TRect; virtual;

    property AvailableBounds: TRect read GetAvailableBounds;
    property CachedBoundsCount: Integer read GetCachedBoundsCount;
    property CachedBoundsItem[Index: Integer]: TdxLCBoundsCacheItem read GetCachedBoundsItem;
    property CachedBounds: TList read FCachedBounds;

    property CachedFontItemCount: Integer read GetCachedFontItemCount;
    property CachedFontItems[Index: Integer]: PdxPSLayoutCacheFontItem read GetCachedFontItem;
    property CachedFonts: TList read FCachedFonts;

    property CurrentHost: TdxReportCell read GetCurrentHost;
    property CurrentLayoutItem: TdxCustomLayoutItem read FCurrentLayoutItem Write FCurrentLayoutItem;
    property LayoutItemProducerCache: TdxPSLayoutItemProducerCache read FLayoutItemProducerCache;
    property LayoutItemProducers[LayoutItem: TdxCustomLayoutItem]: TdxPSCustomLayoutItemProducer read GetLayoutItemProducer;
    property LayoutLookAndFeelProducerCache: TdxPSLayoutLookAndFeelProducerCache read FLayoutLookAndFeelProducerCache;
    property LayoutLookAndFeelProducers[LayoutLookAndFeel: TdxCustomLayoutLookAndFeel]: TdxPSLayoutLookAndFeelProducer read GetLayoutLookAndFeelProducer;
    property RootLayoutGroup: TdxLayoutGroup read GetRootLayoutGroup;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    class function Aggregable: Boolean; override;

    property LayoutControl: TdxLayoutControl read GetLayoutControl;
  published
    property OptionsPagination: TdxLayoutControlReportLinkOptionsPagination read GetOptionsPagination write SetOptionsPagination;
    property OptionsSize: TdxLayoutControlReportLinkOptionsSize read FOptionsSize write SetOptionsSize;
    property OptionsTransparent: TdxLayoutControlReportLinkOptionsTransparent read GetOptionsTransparent write SetOptionsTransparent;
  end;
  
  { Design Window }
  
  TdxPSLayoutControlDesignWindow = class(TdxfmCustomContainerDesignWindow)
  private
    function GetLayoutReportLink: TdxLayoutControlReportLink;
  protected
    procedure DoInitialize; override;

    procedure SetOptionsPaginationByIndex(AnIndex: Integer; AValue: Boolean); override;
    procedure SetOptionsSizeByIndex(AnIndex: Integer; AValue: Boolean); override;
    procedure SetOptionsTransparentByIndex(AnIndex: Integer; AValue: Boolean); override;

    procedure InitializeControlsTree; override;
    procedure InitializeHiddenControlsTree; override;
    function IsBoldNode(ANode: TTreeNode): Boolean; override;
  public
    property LayoutReportLink: TdxLayoutControlReportLink read GetLayoutReportLink;
  end;
  
implementation

uses
 {$IFDEF DELPHI6} Variants, {$ENDIF} SysUtils, StdCtrls, Forms, cxClasses, 
  dxPSGlbl, dxPSRes, dxPSUtl, dxLayoutControlAdapters, cxControls;
  
const
  LayoutBorderStyleMap: array[TdxLayoutBorderStyle] of TdxPSCellBorderClass =
    (TdxPSCellNullBorder, TdxPSCellUltraFlatBorder, TdxPSCellSunkenSoftBorder, TdxPSCellSunkenBorder);
  LayoutCaptionAlignHorzMap: array[TAlignment] of TcxTextAlignX = (taLeft, taRight, taCenterX);
  LayoutCaptionAlignVertMap: array[TdxAlignmentVert] of TcxTextAlignY = (taTop, taCenterY, taBottom);
  LayoutGroupCaptionAlignHorzMap: array[TAlignment] of TcxTextAlignX = (taLeft, taRight, taCenterX);
  
type
  TcxControlAccess = class(TcxControl);
  TdxCustomContainerReportLinkAccess = class(TdxCustomContainerReportLink);
  TdxCustomLayoutControlAccess = class(TdxCustomLayoutControl);
  TdxCustomLayoutItemAccess = class(TdxCustomLayoutItem);
  TdxCustomLayoutLookAndFeelAccess = class(TdxCustomLayoutLookAndFeel);
  TdxLayoutControlViewInfoAccess = class(TdxLayoutControlViewInfo);
  TdxLayoutItemAccess = class(TdxLayoutItem);
  
{ Helpers }
 
function GetLayoutItemRelativeBounds(ALayoutItem: TdxCustomLayoutItem): TRect;

  function LayoutControl: TdxCustomLayoutControlAccess;
  begin
    Result := TdxCustomLayoutControlAccess(ALayoutItem.Container);
  end;
  
  function ScrollLeft: Integer;
  begin
    Result := LayoutControl.HScrollBar.Position;
  end;

  function ScrollTop: Integer;
  begin
    Result := LayoutControl.VScrollBar.Position;
  end;

  function ParentLeft: Integer;
  begin
    Result := ALayoutItem.Parent.ViewInfo.Bounds.Left;
  end;

  function ParentTop: Integer;
  begin
    Result := ALayoutItem.Parent.ViewInfo.Bounds.Top;
  end;
  
begin
  if ALayoutItem.ViewInfo <> nil then
  begin
    Result := ALayoutItem.ViewInfo.Bounds;
    if ALayoutItem.IsRoot or ALayoutItem.Parent.IsRoot then 
      OffsetRect(Result, ScrollLeft, ScrollTop)
    else
      OffsetRect(Result, -ParentLeft, -ParentTop);
  end  
  else
    Result := cxNullRect;
end;

{ Factories }  

type  
  TdxPSLayoutItemProducerFactory = class(TdxCustomClassMaps)
  private
    function GetProducerClass(LayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducerClass;
  public
    class function Instance: TdxPSLayoutItemProducerFactory; reintroduce; overload;
    property ProducerClasses[LayoutItem: TdxCustomLayoutItem]: TdxPSCustomLayoutItemProducerClass read GetProducerClass; default;
  end;
  
  TdxPSLayoutLookAndFeelProducerFactory = class(TdxCustomClassMaps)
  private
    function GetProducerClass(LayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSLayoutLookAndFeelProducerClass;
  public
    class function Instance: TdxPSLayoutLookAndFeelProducerFactory; reintroduce; overload;
    property ProducerClasses[LayoutLookAndFeel: TdxCustomLayoutLookAndFeel]: TdxPSLayoutLookAndFeelProducerClass read GetProducerClass; default;
  end;
                                                                            
{ TdxPSLayoutItemProducerFactory }
  
function dxPSLayoutItemProducerFactory: TdxPSLayoutItemProducerFactory;
begin
  Result := TdxPSLayoutItemProducerFactory.Instance;
end;

class function TdxPSLayoutItemProducerFactory.Instance: TdxPSLayoutItemProducerFactory;
begin
  Result := inherited Instance as TdxPSLayoutItemProducerFactory;
end;

function TdxPSLayoutItemProducerFactory.GetProducerClass(LayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducerClass;
begin
  Result := TdxPSCustomLayoutItemProducerClass(PairClasses[LayoutItem.ClassType]);
end;

{ TdxPSLayoutLookAndFeelProducerFactory }

function dxPSLayoutLookAndFeelProducerFactory: TdxPSLayoutLookAndFeelProducerFactory;
begin
  Result := TdxPSLayoutLookAndFeelProducerFactory.Instance;
end;

class function TdxPSLayoutLookAndFeelProducerFactory.Instance: TdxPSLayoutLookAndFeelProducerFactory;
begin
  Result := inherited Instance as TdxPSLayoutLookAndFeelProducerFactory;
end;

function TdxPSLayoutLookAndFeelProducerFactory.GetProducerClass(LayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSLayoutLookAndFeelProducerClass;
begin
  Result := TdxPSLayoutLookAndFeelProducerClass(PairClasses[LayoutLookAndFeel.ClassType]);
end;

{ TdxReportLayoutControlHost }

function TdxReportLayoutControlHost.GetControlItem: TdxReportVisualItem;
begin
  if CellCount <> 0 then
    Result := Cells[0]
  else
    Result := nil;
end;

{ TdxCustomReportLayoutItem }

function TdxCustomReportLayoutItem.LayoutItem: TdxCustomLayoutItem;
begin
  Result := TdxCustomLayoutItem(Data);
end;

procedure TdxCustomReportLayoutItem.AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas);
begin
  BoundsRect := LayoutItemBounds;
end;

function TdxCustomReportLayoutItem.GetLayoutItemBounds: TRect;
begin
  Result := GetLayoutItemRelativeBounds(LayoutItem);
end;

{ TdxReportLayoutGroup }

function TdxReportLayoutGroup.LayoutItem: TdxLayoutGroup;
begin
  Result := inherited LayoutItem as TdxLayoutGroup;
end;

{ TdxReportLayoutItem }

function TdxReportLayoutItem.LayoutItem: TdxLayoutItem;
begin
  Result := inherited LayoutItem as TdxLayoutItem;
end;

procedure TdxReportLayoutItem.AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas);
begin
  inherited AdjustBounds(ACanvas);
  if HasControlItem then
    ControlItem.BoundsRect := ControlBounds;
  if HasCaptionItem then
    with CaptionItem do
    begin
      BoundsRect := CaptionBounds;
      Width := MeasureWidth(ACanvas);
      Height := MeasureHeight(ACanvas);
    end;
end;

function TdxReportLayoutItem.CreateCaption(AReportLink: TdxLayoutControlReportLink): TdxReportCellString;
begin
  Result := TdxReportCellString.Create(Self);
  with Result do 
  begin
    BoundsRect := CaptionBounds;
    CellSides := {csAll;//}[];
    with AReportLink.LayoutItemProducers[LayoutItem].LayoutLookAndFeel.ItemOptions do
      FontIndex := AReportLink.FindFontIndexByCaptionOptions(CaptionOptions);
    HidePrefix := True;
    Multiline := LayoutItem.CaptionOptions.Width <> 0;
    Text := LayoutItem.Caption;
    TextAlignX := LayoutCaptionAlignHorzMap[LayoutItem.CaptionOptions.AlignHorz];
    TextAlignY := LayoutCaptionAlignVertMap[LayoutItem.CaptionOptions.AlignVert];
    Transparent := True;
    AdjustFont := True; 
  end;  
end;

function TdxReportLayoutItem.CreateControl(AReportLink: TdxLayoutControlReportLink): TdxReportVisualItem;

  function LayoutItemProducer: TdxPSCustomLayoutItemProducer;
  begin
    Result := AReportLink.LayoutItemProducers[LayoutItem];
  end;

  function HasBorder(AControl: TWinControl): Boolean;
  var
    V: Variant;
  begin
    Result := csFramed in Control.ControlStyle;
    if not Result and AControl.HandleAllocated then
      Result := (GetWindowLong(AControl.Handle, GWL_STYLE) and WS_BORDER = WS_BORDER) or
                (GetWindowLong(AControl.Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE = WS_EX_CLIENTEDGE);
    if not Result and dxPSUtl.HasProperty(AControl, 'BorderStyle') then
    begin
      V := dxPSUtl.GetProperty(AControl, 'BorderStyle');
      Result := not VarIsNull(V) and (V <> Forms.bsNone);
    end;
  end;
  
const               
  CellSidesMap: array[Boolean] of TdxCellSides = ([], csAll);
begin                          
  if Control is TWinControl then 
  begin
    Result := AReportLink.ActiveBuilder.BuildNestedContainer(TWinControl(Control), Self);
    if not AReportLink.Producers[Control].HasNativeSupportForBorders then
      with LayoutItemProducer.LayoutLookAndFeel.ItemOptions do
      begin
        TdxReportWinControlHost(Result).ControlItem.BorderClass := LayoutBorderStyleMap[ControlBorderStyle];
        TdxReportWinControlHost(Result).ControlItem.BorderColor := ControlBorderColor;
        TdxReportWinControlHost(Result).ControlItem.CellSides := CellSidesMap[LayoutItem.ControlOptions.ShowBorder or HasBorder(TWinControl(Control))];
      end;
  end
  else
    Result := AReportLink.ActiveBuilder.BuildControl(Control, Self);
  
  Result.BoundsRect := ControlBounds;
  Result.CellSides := [];
end;

procedure TdxReportLayoutItem.CreateNestedItems(AReportLink: TdxLayoutControlReportLink); 
begin
  if IsCreateCaption(AReportLink) then CreateCaption(AReportLink);
  if IsCreateControl(AReportLink) then CreateControl(AReportLink);
end;

function TdxReportLayoutItem.IsCreateCaption(AReportLink: TdxLayoutControlReportLink): Boolean;
begin
  with TdxLayoutItemAccess(LayoutItem) do 
    Result := ShowCaption and (not HasControl or AReportLink.DoIsComponentProcessed(Control));
end;

function TdxReportLayoutItem.IsCreateControl(AReportLink: TdxLayoutControlReportLink): Boolean;
begin
  Result := TdxLayoutItemAccess(LayoutItem).HasControl and AReportLink.DoIsComponentProcessed(Control);
end;

function TdxReportLayoutItem.GetAdapter: TdxCustomLayoutControlAdapter;
begin
  Result := TdxLayoutItemAccess(LayoutItem).ControlAdapter;
end;

function TdxReportLayoutItem.GetCaptionBounds: TRect;
const
  DeltaX = 1;
  DeltaY = 4;
begin
  with LayoutItem do 
  begin
    Result := ViewInfo.CaptionViewInfo.Bounds;
    with ViewInfo.Bounds do
      OffsetRect(Result, -Left, -Top);
    if CaptionOptions.Width <> 0 then 
      Result.Right := Result.Left + CaptionOptions.Width;
    OffsetRect(Result, -DeltaX, -DeltaY);
    //Inc(Result.Left, DeltaX);
    Inc(Result.Bottom, DeltaY); // multiline captions
  end;  
end;

function TdxReportLayoutItem.GetCaptionItem: TdxReportCellString;
begin
  if (DataItemCount <> 0) and (DataItems[0].Data = 0) then 
    Result := TdxReportCellString(DataItems[0])
  else
    Result := nil;
end;                                     

function TdxReportLayoutItem.GetControl: TControl;
begin
  Result := LayoutItem.Control;
end;
                                     
function TdxReportLayoutItem.GetControlBounds: TRect;
begin
  with LayoutItem do
  begin
    Result := ViewInfo.ControlViewInfo.ControlBounds;
    with ViewInfo.Bounds do
      OffsetRect(Result, -Left, -Top);
  end;
end;

function TdxReportLayoutItem.GetControlItem: TdxReportVisualItem;
const
  Indexes: array[Boolean] of Integer = (0, 1);
var
  Index: Integer;  
begin
  if CellCount = 0 then 
  begin
    Index := Indexes[HasCaptionItem];
    if (DataItemCount > Index) and (DataItems[Index].Data <> 0) then
      Result := DataItems[Index]
    else
      Result := nil;
  end
  else
    Result := Cells[0];
end;

function TdxReportLayoutItem.GetHasCaptionItem: Boolean;
begin
  Result := CaptionItem <> nil;
end;

function TdxReportLayoutItem.GetHasControlItem: Boolean;
begin
  Result := ControlItem <> nil;
end;

function TdxReportLayoutItem.GetIsControlAccessible: Boolean;
begin
  Result := (LayoutItem.Control <> nil) and LayoutItem.Control.Visible;
end;

{ TdxPSCustomLayoutItemDefinition }

function TdxPSCustomLayoutItemDefinition.OptionsPagination: TdxLayoutControlReportLinkOptionsPagination;
begin
  Result := inherited OptionsPagination as TdxLayoutControlReportLinkOptionsPagination;
end;

procedure TdxPSCustomLayoutItemDefinition.AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas);
begin
  ReportItem.AdjustBounds(ACanvas);
end;

procedure TdxPSCustomLayoutItemDefinition.SaveOriginalItemSize;
begin
end;

procedure TdxPSCustomLayoutItemDefinition.SetupOriginalControlSize;
begin
end;

function TdxPSCustomLayoutItemDefinition.GetLayoutItem: TdxCustomLayoutItem;
begin
  Result := TdxCustomLayoutItem(Component);
end;

function TdxPSCustomLayoutItemDefinition.GetReportItem: TdxCustomReportLayoutItem;
begin
  Result := inherited ReportItem as TdxCustomReportLayoutItem;
end;

procedure TdxPSCustomLayoutItemDefinition.SetLayoutItem(Value: TdxCustomLayoutItem);
begin
  Component := Value;
end;
  
{ TdxPSLayoutGroupDefinition }

procedure TdxPSLayoutGroupDefinition.AddDelimitersHorz(AList: TList);
begin
  inherited;
  if OptionsPagination.Groups then AddReportItemToDelimitersHorz(AList);
end;

procedure TdxPSLayoutGroupDefinition.AddDelimitersVert(AList: TList);
begin
  inherited;
  if OptionsPagination.Groups then AddReportItemToDelimitersVert(AList);
end;

function TdxPSLayoutGroupDefinition.GetLayoutItem: TdxLayoutGroup;
begin
  Result := inherited LayoutItem as TdxLayoutGroup;
end;
  
{ TdxPSLayoutItemDefinition }

procedure TdxPSLayoutItemDefinition.AddDelimitersHorz(AList: TList);
begin
  inherited;
  if OptionsPagination.Items then AddReportItemToDelimitersHorz(AList);
end;

procedure TdxPSLayoutItemDefinition.AddDelimitersVert(AList: TList);
begin
  inherited;
  if OptionsPagination.Items then AddReportItemToDelimitersVert(AList);
end;

procedure TdxPSLayoutItemDefinition.SaveOriginalItemSize;
begin
  with TdxLayoutItemAccess(LayoutItem) do 
    if Control <> nil then SaveOriginalControlSize;
end;

procedure TdxPSLayoutItemDefinition.SetupOriginalControlSize;
begin
  with ReportItem do 
    if HasControlItem then 
      LayoutItem.OriginalControlSize := Point(ControlItem.Width, ControlItem.Height);
end;

function TdxPSLayoutItemDefinition.GetLayoutItem: TdxLayoutItem;
begin
  Result := inherited LayoutItem as TdxLayoutItem;
end;

function TdxPSLayoutItemDefinition.GetReportItem: TdxReportLayoutItem;
begin
  Result := inherited ReportItem as TdxReportLayoutItem;
end;

{ TdxPSLayoutControlObjectProducer }

function TdxPSLayoutControlObjectProducer.ReportLink: TdxLayoutControlReportLink;
begin
  Result := inherited ReportLink as TdxLayoutControlReportLink;
end;

function TdxPSLayoutControlObjectProducer.RootContainer: TdxLayoutControl;
begin
  Result := inherited RootContainer as TdxLayoutControl;
end;

{ TdxPSLayoutLookAndFeelProducer }

function TdxPSLayoutLookAndFeelProducer.LayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := inherited ProducingObject as TdxCustomLayoutLookAndFeel;
end;

class function TdxPSLayoutLookAndFeelProducer.LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass;
begin
  Result := TdxCustomLayoutLookAndFeel;
end;

class function TdxPSLayoutLookAndFeelProducer.PairClass: TClass;
begin
  Result := LayoutLookAndFeelClass;
end;

class procedure TdxPSLayoutLookAndFeelProducer.Register;
begin
  dxPSLayoutLookAndFeelProducerFactory.Register(Self);
end;

class procedure TdxPSLayoutLookAndFeelProducer.Unregister;
begin
  dxPSLayoutLookAndFeelProducerFactory.Unregister(Self);
end;

function TdxPSLayoutLookAndFeelProducer.GetContentColor: TColor; 
begin
  Result := LayoutLookAndFeel.GroupOptions.GetColor;
end;

function TdxPSLayoutLookAndFeelProducer.GetGroupCaptionColor: TColor;
begin
  Result := LayoutLookAndFeel.GroupOptions.GetColor;
end;

function TdxPSLayoutLookAndFeelProducer.GetIsContentTransparent: Boolean;
begin
  Result := ColorToRGB(ContentColor) = ColorToRGB(TransparentColor);
end;

function TdxPSLayoutLookAndFeelProducer.GetIsGroupCaptionTransparent: Boolean;
begin
  Result := ColorToRGB(GroupCaptionColor) = ColorToRGB(TransparentColor);
end;

function TdxPSLayoutLookAndFeelProducer.GetTransparentColor: TColor;
begin
  Result := clDefault;
end;

procedure TdxPSLayoutLookAndFeelProducer.InitializeReportLookAndFeel(ALookAndFeel: TdxPSReportGroupLookAndFeel);
begin
  ALookAndFeel.Color := LayoutLookAndFeel.GroupOptions.GetColor;
  ALookAndFeel.Data := LayoutLookAndFeel;
  ALookAndFeel.FontIndex := ReportLink.FindFontIndexByCaptionOptions(LayoutLookAndFeel.GroupOptions.CaptionOptions);
  ALookAndFeel.CaptionFontIndex := ALookAndFeel.FontIndex;
end;

class function TdxPSLayoutLookAndFeelProducer.ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass;
begin
  Result := TdxPSReportGroupLookAndFeel;
end;

{ TdxPSLayoutStandardLookAndFeelProducer }

function TdxPSLayoutStandardLookAndFeelProducer.LayoutLookAndFeel: TdxLayoutStandardLookAndFeel;
begin
  Result := inherited LayoutLookAndFeel as TdxLayoutStandardLookAndFeel;
end;

class function TdxPSLayoutStandardLookAndFeelProducer.LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass;
begin
  Result := TdxLayoutStandardLookAndFeel;
end;

function TdxPSLayoutStandardLookAndFeelProducer.GetTransparentColor: TColor;
begin
  Result := clBtnFace;
end;

class function TdxPSLayoutStandardLookAndFeelProducer.ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass;
begin
  Result := TdxPSReportGroupStandardLookAndFeel;
end;

{ TdxPSLayoutOfficeLookAndFeelProducer }

function TdxPSLayoutOfficeLookAndFeelProducer.LayoutLookAndFeel: TdxLayoutOfficeLookAndFeel;
begin
  Result := inherited LayoutLookAndFeel as TdxLayoutOfficeLookAndFeel;
end;

class function TdxPSLayoutOfficeLookAndFeelProducer.LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass;
begin
  Result := TdxLayoutOfficeLookAndFeel;
end;

class function TdxPSLayoutOfficeLookAndFeelProducer.ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass;
begin
  Result := TdxPSReportGroupOfficeLookAndFeel;
end;                     

{ TdxPSLayoutWebLookAndFeelProducer }

function TdxPSLayoutWebLookAndFeelProducer.LayoutLookAndFeel: TdxLayoutWebLookAndFeel;
begin
  Result := inherited LayoutLookAndFeel as TdxLayoutWebLookAndFeel;
end;

class function TdxPSLayoutWebLookAndFeelProducer.LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass;
begin
  Result := TdxLayoutWebLookAndFeel;
end;

function TdxPSLayoutWebLookAndFeelProducer.GetGroupCaptionColor: TColor;
begin
  Result := LayoutLookAndFeel.GroupOptions.CaptionOptions.GetColor;
end;
    
function TdxPSLayoutWebLookAndFeelProducer.GetTransparentColor: TColor;
begin
  Result := clWindow;
end;

procedure TdxPSLayoutWebLookAndFeelProducer.InitializeReportLookAndFeel(ALookAndFeel: TdxPSReportGroupLookAndFeel);
begin
  inherited;
  with TdxPSReportGroupWebLookAndFeel(ALookAndFeel) do 
  begin
    BorderThickness := LayoutLookAndFeel.GroupOptions.FrameWidth;
    BorderColor := LayoutLookAndFeel.GroupOptions.GetFrameColor;
    CaptionColor := LayoutLookAndFeel.GroupOptions.CaptionOptions.GetColor;
    CaptionSeparatorColor := LayoutLookAndFeel.GroupOptions.GetFrameColor;
    CaptionSeparatorThickness := LayoutLookAndFeel.GroupOptions.CaptionOptions.SeparatorWidth;
  end;
end;

class function TdxPSLayoutWebLookAndFeelProducer.ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass;
begin
  Result := TdxPSReportGroupWebLookAndFeel;
end;

{ TdxPSCustomLayoutItemProducer }

function TdxPSCustomLayoutItemProducer.Definition: TdxPSCustomLayoutItemDefinition; 
begin
  Result := inherited Definition as TdxPSCustomLayoutItemDefinition;
end;

class function TdxPSCustomLayoutItemProducer.DefinitionClass: TdxPSCustomContainerItemDefinitionClass;
begin
  Result := TdxPSCustomLayoutItemDefinition;
end;  

function TdxPSCustomLayoutItemProducer.LayoutItem: TdxCustomLayoutItem;
begin
  Result := inherited ProducingObject as TdxCustomLayoutItem;
end;

class function TdxPSCustomLayoutItemProducer.LayoutItemClass: TdxCustomLayoutItemClass;
begin
  Result := TdxCustomLayoutItem;
end;

class function TdxPSCustomLayoutItemProducer.PairClass: TClass;
begin
  Result := LayoutItemClass;
end;

function TdxPSCustomLayoutItemProducer.ProducingObjectFriendlyName: string;
begin
  Result := '';
  if not IsDesigning then
    Result := LayoutItem.Caption;
  if Result = '' then
    Result := inherited ProducingObjectFriendlyName;
end;

procedure TdxPSCustomLayoutItemProducer.Reposition;
begin
end;

class procedure TdxPSCustomLayoutItemProducer.Register;
begin
  inherited;
  dxPSLayoutItemProducerFactory.Register(Self);
end;

class procedure TdxPSCustomLayoutItemProducer.Unregister;
begin
  if Self <> TdxPSCustomLayoutItemProducer then  
    dxPSLayoutItemProducerFactory.Unregister(Self);
  inherited;
end;

function TdxPSCustomLayoutItemProducer.GetContentColor: TColor;
begin
  Result := LayoutLookAndFeelProducer.ContentColor;
end;

function TdxPSCustomLayoutItemProducer.GetIsContentTransparent: Boolean;
begin
  Result := LayoutLookAndFeelProducer.IsContentTransparent;
end;

function TdxPSCustomLayoutItemProducer.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := TdxCustomLayoutItemAccess(LayoutItem).GetLookAndFeel;
end;

function TdxPSCustomLayoutItemProducer.GetLayoutLookAndFeelProducer: TdxPSLayoutLookAndFeelProducer;
begin
  Result := ReportLink.LayoutLookAndFeelProducers[LayoutLookAndFeel];
end;  

procedure TdxPSCustomLayoutItemProducer.InitializeReportItem(AnItem: TdxReportCell);
begin
  AnItem.BoundsRect := LayoutItemBounds;
  AnItem.CellSides := csAll;
  AnItem.Color := ContentColor;
  AnItem.Data := Integer(LayoutItem);
  //AnItem.ExcludeFromClipRgn := True;
  AnItem.Transparent := False;
  ReportLink.CreateItemDefinition(LayoutItem, AnItem);
end;  

class function TdxPSCustomLayoutItemProducer.ReportItemClass: TdxReportCellClass;
begin
  Result := TdxCustomReportLayoutItem;
end;

function TdxPSCustomLayoutItemProducer.OptionsTransparent: TdxLayoutControlReportLinkOptionsTransparent;
begin
  Result := inherited OptionsTransparent as TdxLayoutControlReportLinkOptionsTransparent;
end;

procedure TdxPSCustomLayoutItemProducer.AdjustBounds;
begin
  Definition.AdjustBounds(Canvas);
end;  

procedure TdxPSCustomLayoutItemProducer.SaveOriginalItemSize;
begin
  Definition.SaveOriginalItemSize;
end;

function TdxPSCustomLayoutItemProducer.GetLayoutItemBounds: TRect;
begin
  Result := GetLayoutItemRelativeBounds(LayoutItem);
end;

{ TdxPSLayoutGroupProducer }

function TdxPSLayoutGroupProducer.Definition: TdxPSLayoutGroupDefinition;
begin
  Result := inherited Definition as TdxPSLayoutGroupDefinition;
end;

class function TdxPSLayoutGroupProducer.DefinitionClass: TdxPSCustomContainerItemDefinitionClass;
begin
  Result := TdxPSLayoutGroupDefinition;
end;

function TdxPSLayoutGroupProducer.ProducingObjectFriendlyName: string;
begin
  Result := '';
  if not IsDesigning then
    Result := LayoutItem.Caption;
  if Result = '' then
    Result := cxGetResourceString(@sdxLayoutGroupDefaultCaption);
end;

procedure TdxPSLayoutGroupProducer.Reposition;
begin
end;

function TdxPSLayoutGroupProducer.LayoutItem: TdxLayoutGroup;
begin
  Result := inherited LayoutItem as TdxLayoutGroup;
end;

class function TdxPSLayoutGroupProducer.LayoutItemClass: TdxCustomLayoutItemClass;
begin
  Result := TdxLayoutGroup;
end;

function TdxPSLayoutGroupProducer.GetGroupCaptionContentColor: TColor;
begin
  Result := LayoutLookAndFeelProducer.GroupCaptionColor;
end;

function TdxPSLayoutGroupProducer.GetIsGroupCaptionTransparent: Boolean;
begin
  Result := LayoutLookAndFeelProducer.IsGroupCaptionTransparent;
end;

procedure TdxPSLayoutGroupProducer.InitializeReportItem(AnItem: TdxReportCell);
begin
  inherited;
  with TdxReportGroup(AnItem) do 
  begin
    CaptionAlignment := LayoutGroupCaptionAlignHorzMap[LayoutItem.CaptionOptions.AlignHorz];
    CaptionText := LayoutItem.Caption;
    CaptionTransparent := OptionsTransparent.Groups;
    //HidePrefix := True;
    LookAndFeel := Self.ReportLink.FindReportGroupLookAndFeel(LayoutLookAndFeel);
    ShowCaption := LayoutItem.ShowCaption;
    Transparent := OptionsTransparent.Groups;

    CellSides := [];
    if LayoutItem.ShowBorder then 
      CellSides := LookAndFeel.DefaultBorderSides;

    CalculateCaptionTextWidth(Canvas);  
  end;
end;

class function TdxPSLayoutGroupProducer.ReportItemClass: TdxReportCellClass;
begin
  Result := TdxReportLayoutGroup;
end;

{ TdxPSLayoutItemProducer }

function TdxPSLayoutItemProducer.Definition: TdxPSLayoutItemDefinition; 
begin
  Result := inherited Definition as TdxPSLayoutItemDefinition;
end;

class function TdxPSLayoutItemProducer.DefinitionClass: TdxPSCustomContainerItemDefinitionClass;
begin
  Result := TdxPSLayoutItemDefinition;
end;

function TdxPSLayoutItemProducer.LayoutItem: TdxLayoutItem;
begin
  Result := inherited LayoutItem as TdxLayoutItem;
end;

class function TdxPSLayoutItemProducer.LayoutItemClass: TdxCustomLayoutItemClass;
begin
  Result := TdxLayoutItem;
end;

function TdxPSLayoutItemProducer.ProducingObjectFriendlyName: string;
begin
  Result := '';
  if not IsDesigning then
    Result := LayoutItem.Caption;
  if Result = '' then
    Result := cxGetResourceString(@sdxLayoutItemDefaultCaption);
  Result := dxPSUtl.DropColon(Result);  
end;

procedure TdxPSLayoutItemProducer.Reposition;
begin
  if HasControl then 
  begin
    ReportLink.Producers[Control].Reposition;
    Definition.SetupOriginalControlSize;
  end;
end;

function TdxPSLayoutItemProducer.GetContentColor: TColor;
begin
  Result := ReportLink.LayoutLookAndFeelProducers[TdxCustomLayoutItemAccess(LayoutItem.Parent).GetLookAndFeel].ContentColor;
end;

procedure TdxPSLayoutItemProducer.InitializeReportItem(AnItem: TdxReportCell);
//var
//  AControl: TControl;
//  ALayoutItem: TdxCustomLayoutItem;
begin
  inherited;
  AnItem.CellSides := [];
  AnItem.Transparent := OptionsTransparent.Items;
//  ALayoutItem := TdxLayoutControlReportLink(ReportLink).CurrentLayoutItem;

//  AControl := TdxReportLayoutItem(AnItem).Control;
  TdxReportLayoutItem(AnItem).CreateNestedItems(ReportLink);
end;

class function TdxPSLayoutItemProducer.ReportItemClass: TdxReportCellClass;
begin
  Result := TdxReportLayoutItem;
end;

function TdxPSLayoutItemProducer.GetControl: TControl;
begin
  Result := LayoutItem.Control;
end;

function TdxPSLayoutItemProducer.GetHasControl: Boolean;
begin
  Result := (Control <> nil) and Control.Visible;
end;

{ TdxPSCustomLayoutObjectProducerCache }

function TdxPSCustomLayoutObjectProducerCache.ReportLink: TdxLayoutControlReportLink;
begin
  Result := inherited ReportLink as TdxLayoutControlReportLink;
end;

{ TdxPSLayoutItemProducerCache }

function TdxPSLayoutItemProducerCache.GetItem(Index: Integer): TdxPSCustomLayoutItemProducer;
begin
  Result := TdxPSCustomLayoutItemProducer(inherited Items[Index]);
end;

function TdxPSLayoutItemProducerCache.GetProducer(AProducerClass: TdxPSCustomLayoutItemProducerClass; 
  ALayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducer;
var
  Index: Integer;
begin
  Index := IndexOfByClass(AProducerClass);
  if Index = -1 then 
    Index := Add(AProducerClass.Create(ReportLink, ALayoutItem));
  Result := Items[Index];
  Result.Initialize(ALayoutItem);
end;

{ TdxPSLayoutLookAndFeelProducerCache }

function TdxPSLayoutLookAndFeelProducerCache.GetItem(Index: Integer): TdxPSLayoutLookAndFeelProducer;
begin
  Result := TdxPSLayoutLookAndFeelProducer(inherited Items[Index]);
end;

function TdxPSLayoutLookAndFeelProducerCache.GetProducer(AProducerClass: TdxPSLayoutLookAndFeelProducerClass; 
  ALayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSLayoutLookAndFeelProducer;
var
  Index: Integer;
begin
  Index := IndexOfByClass(AProducerClass);
  if Index = -1 then 
    Index := Add(AProducerClass.Create(ReportLink, ALayoutLookAndFeel));
  Result := Items[Index];
  Result.Initialize(ALayoutLookAndFeel);
end;
  
{ TdxPSNativeLayoutControlProducer }

class function TdxPSNativeLayoutControlProducer.HasNativeSupportForBorders: Boolean;
begin
  Result := True;
end;
    
function TdxPSNativeLayoutControlProducer.ObjectExpandHeight: Boolean;
begin
  Result := True;
end;

function TdxPSNativeLayoutControlProducer.ObjectExpandWidth: Boolean;
begin
  Result := True;
end;

function TdxPSNativeLayoutControlProducer.Control: TdxCustomLayoutControl;
begin
  Result := inherited Control as TdxCustomLayoutControl;
end;

class function TdxPSNativeLayoutControlProducer.ControlClass: TControlClass;
begin
  Result := TdxCustomLayoutControl;
end;
  
{ TdxPSLayoutControlProducer }

class function TdxPSLayoutControlProducer.CanHasAvailableChildren: Boolean;
begin
  Result := False;
end;

class function TdxPSLayoutControlProducer.Reenterable: Boolean;
begin
  Result := False;
end;

function TdxPSLayoutControlProducer.Control: TdxLayoutControl;
begin
  Result := inherited Control as TdxLayoutControl;
end;

class function TdxPSLayoutControlProducer.ControlClass: TControlClass;
begin
  Result := TdxCustomLayoutControl;
end;

class function TdxPSLayoutControlProducer.HasNativeSupportForBorders: Boolean;
begin
  Result := False;
end;
    
function TdxPSLayoutControlProducer.ObjectExpandHeight: Boolean;
begin
  Result := True;
end;

function TdxPSLayoutControlProducer.ObjectExpandWidth: Boolean;
begin
  Result := True;
end;

function TdxPSLayoutControlProducer.ReportLink: TdxLayoutControlReportLink;
begin
  Result := inherited ReportLink as TdxLayoutControlReportLink;
end;

procedure TdxPSLayoutControlProducer.Reposition;

  procedure CalculateViewInfo;
  begin
    Control.ViewInfo.Calculate;
  end;

  procedure SetupOriginalControlSize(AnItems: TList);
  var
    I, Index: Integer;
    Item: TdxCustomLayoutItem;
  begin
    for I := 0 to AnItems.Count - 1 do
    begin
      Item := AnItems[I];
      if ReportLink.IsComponentProcessed(Item) then
        if (Item is TdxLayoutGroup) or ReportLink.FindDefinition(TdxLayoutItem(Item).Control, Index) then
          Producers[Item].Reposition
        else
      else
        Item.Visible := False;
    end;
    CalculateViewInfo;
  end;

  procedure UpdateItemsBounds(AnItems: TList);
  var
    I, Index: Integer;
    Item: TdxCustomLayoutItem;
  begin
    for I := 0 to AnItems.Count - 1 do
    begin
      Item := AnItems[I];
      if ReportLink.IsComponentProcessed(Item) and
        ((Item is TdxLayoutGroup) or ReportLink.FindDefinition(TdxLayoutItem(Item).Control, Index)) then
        Producers[Item].AdjustBounds;
    end;
  end;

  procedure RestoreOriginalControlSize(AnItems: TList);
  var
    I: Integer;
    Item: TdxCustomLayoutItem;
  begin
    for I := 0 to AnItems.Count - 1 do
    begin
      Item := AnItems[I];
      Item.Visible := True;
      if ReportLink.IsComponentProcessed(Item) then
        Producers[Item].SaveOriginalItemSize;
    end;
    CalculateViewInfo;
  end;

var
  Items: TList;
  Cell: TdxReportCell;
begin
  Control.BeginUpdate;
  try
    TcxControlAccess(Control).FBounds := AvailableBounds;
    Items := TList.Create;
    try
      GetLayoutItemList(Items);
      SetupOriginalControlSize(Items);
      try
        UpdateItemsBounds(Items);
      finally
        RestoreOriginalControlSize(Items);
      end;
    finally
      Items.Free;
    end;  
  finally
    TdxLayoutControlViewInfoAccess(Control.ViewInfo).DestroyViewInfos;
    TcxControlAccess(Control).FBounds := cxNullRect;
    Control.EndUpdate;
  end;

  with TdxReportCell(Definition.SizeChangeReportItem) do
  begin
    Cell := Cells[0].Cells[0];
    
    Cells[0].Height := Cell.Height;
    Cells[0].Width := Cell.Width;

    Height := Cell.Height;
    Width := Cell.Width;
  end;  
end;

procedure TdxPSLayoutControlProducer.CreateLayoutItems(AnItem: TdxReportVisualItem);

  function CreateReportItem(AParent: TdxReportCell; ALayoutItem: TdxCustomLayoutItem): TdxReportCell; 
  begin
    ReportLink.CurrentLayoutItem := ALayoutItem;
    try
      with Producers[ALayoutItem] do
      begin
        Result := ReportItemClass.Create(AParent);
        InitializeReportItem(Result);
      end;  
      ReportLinkInitializeItem(Result);
    finally
      ReportLink.CurrentLayoutItem := nil;
    end;  
  end;
  
  procedure ProduceItem(AParent: TdxReportCell; ALayoutItem: TdxCustomLayoutItem);
  var
    I: Integer;
    LayoutItem: TdxCustomLayoutItem;
  begin
    AParent := CreateReportItem(AParent, ALayoutItem);
    if ALayoutItem is TdxLayoutGroup then 
      with TdxLayoutGroup(ALayoutItem) do 
        for I := 0 to VisibleCount - 1 do
        begin
          LayoutItem := VisibleItems[I];
          if ReportLink.DoIsComponentProcessed(LayoutItem) then
            ProduceItem(AParent, LayoutItem);
        end;    
  end;
  
begin
  ProduceItem(TdxReportCell(AnItem), Control.Items); // Root is always processed
end;

procedure TdxPSLayoutControlProducer.GetLayoutItemList(AnItems: TList);
begin
  ReportLink.GetLayoutItemList(Control, AnItems);
end;

function TdxPSLayoutControlProducer.HostClass: TdxReportCellClass;
begin
  Result := TdxReportLayoutControlHost;   
end;

procedure TdxPSLayoutControlProducer.InitializeHost(ACell: TdxReportCell);
begin
  inherited;
  ACell.Height := Control.ViewInfo.ContentHeight;
  ACell.Width := Control.ViewInfo.ContentWidth;
end;

procedure TdxPSLayoutControlProducer.InitializeItem(AnItem: TdxReportVisualItem);
begin
  inherited;
  AnItem.BorderClass := TdxPSCellNullBorder;
  AnItem.Height := Control.ViewInfo.ContentHeight;
  AnItem.Width := Control.ViewInfo.ContentWidth;
  AnItem.CellSides := [];
  AnItem.Transparent := True;

  CreateLayoutItems(AnItem);
end;

function TdxPSLayoutControlProducer.ItemClass: TdxReportVisualItemClass;
begin
  Result := TdxReportCell;
end;

procedure TdxPSLayoutControlProducer.ReportLinkInitializeItem(AnItem: TdxReportVisualItem);
begin
  ReportLink.DoInitializeItem(AnItem);
  ReportLink.DoInitializeItemOptionsPlace(AnItem);
end;

function TdxPSLayoutControlProducer.GetAvailableBounds: TRect;
begin
  Result := ReportLink.AvailableBounds;
end;

function TdxPSLayoutControlProducer.GetProducer(LayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducer;
begin
  Result := ReportLink.LayoutItemProducers[LayoutItem];
end;

{ TdxLayoutControlReportLinkOptionsPagination }

procedure TdxLayoutControlReportLinkOptionsPagination.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TdxLayoutControlReportLinkOptionsPagination then
    with TdxLayoutControlReportLinkOptionsPagination(Source) do 
    begin
      Self.Groups := Groups;
      Self.Items := Items;
    end;
end;

procedure TdxLayoutControlReportLinkOptionsPagination.RestoreDefaults;
begin
  inherited;
  Controls := False;
  Groups := True;
  Items := True;
end;

procedure TdxLayoutControlReportLinkOptionsPagination.SetGroups(Value: Boolean);
begin
  if FGroups <> Value then
  begin
    FGroups := Value;
    Changed;
  end;
end;

procedure TdxLayoutControlReportLinkOptionsPagination.SetItems(Value: Boolean);
begin
  if FItems <> Value then
  begin
    FItems := Value;
    Changed;
  end;
end;

{ TdxLayoutControlReportLinkOptionsSize }

procedure TdxLayoutControlReportLinkOptionsSize.Assign(Source: TPersistent);
begin
  if Source is TdxLayoutControlReportLinkOptionsSize then
    AutoWidth := TdxLayoutControlReportLinkOptionsSize(Source).AutoWidth;
  inherited;
end;

procedure TdxLayoutControlReportLinkOptionsSize.RestoreDefaults;
begin
  inherited;
  AutoWidth := True;
end;

procedure TdxLayoutControlReportLinkOptionsSize.SetAutoWidth(Value: Boolean);
begin
  if FAutoWidth <> Value then
  begin
    FAutoWidth := Value;
    Changed;
  end;
end;

{ TdxLayoutControlReportLinkOptionsTransparent }

procedure TdxLayoutControlReportLinkOptionsTransparent.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TdxLayoutControlReportLinkOptionsTransparent then
    with TdxLayoutControlReportLinkOptionsTransparent(Source) do
    begin
      Self.Groups := Groups;
      Self.Items := Items;
    end;
end;

procedure TdxLayoutControlReportLinkOptionsTransparent.RestoreDefaults;
begin
  Groups := True;
  Items := True;
  inherited;
end;

procedure TdxLayoutControlReportLinkOptionsTransparent.SetGroups(Value: Boolean);
begin
  if FGroups <> Value then
  begin
    FGroups := Value;
    Changed;
  end;
end;

procedure TdxLayoutControlReportLinkOptionsTransparent.SetItems(Value: Boolean);
begin
  if FItems <> Value then
  begin
    FItems := Value;
    Changed;
  end;
end;

{ TdxLayoutControlReportLink }

constructor TdxLayoutControlReportLink.Create(AOwner: TComponent);
begin
  inherited;
  FCachedFonts := TList.Create;
  FCachedBounds := TList.Create;
  FLayoutItemProducerCache := TdxPSLayoutItemProducerCache.Create(Self);
  FLayoutLookAndFeelProducerCache := TdxPSLayoutLookAndFeelProducerCache.Create(Self);
end;

destructor TdxLayoutControlReportLink.Destroy;
begin
  FreeAndNil(FLayoutLookAndFeelProducerCache);
  FreeAndNil(FLayoutItemProducerCache);
  FreeAndNilCachedFonts;
  FreeAndNilCachedBounds;
  inherited;
end;

class function TdxLayoutControlReportLink.Aggregable: Boolean;
begin
  Result := True;
end;

function TdxLayoutControlReportLink.GetRebuildOnPageParamsChange(AUpdateCodes: TdxPrinterPageUpdateCodes): Boolean;
begin
  Result := ([ucMarginLeft, ucMarginRight] * AUpdateCodes <> []) and OptionsSize.AutoWidth;
end;

procedure TdxLayoutControlReportLink.InternalRestoreDefaults;
begin
  inherited;
  OptionsSize.RestoreDefaults;
end;

procedure TdxLayoutControlReportLink.CacheControlsBounds;

  procedure EnumItems(AGroup: TdxLayoutGroupViewInfo);
  var
    I: Integer;
    ControlViewInfo: TdxLayoutItemControlViewInfo;
  begin
    for I := 0 to AGroup.ItemViewInfoCount - 1 do
      if AGroup.ItemViewInfos[I] is TdxLayoutItemViewInfo then
      begin
        ControlViewInfo := TdxLayoutItemViewInfo(AGroup.ItemViewInfos[I]).ControlViewInfo;
        if ControlViewInfo <> nil then
          AddBoundsToCache(ControlViewInfo.Control, ControlViewInfo.ControlBounds);
      end
      else
        if AGroup.ItemViewInfos[I] is TdxLayoutGroupViewInfo then
          EnumItems(TdxLayoutGroupViewInfo(AGroup.ItemViewInfos[I]))
  end;

begin
  try
    TcxControlAccess(LayoutControl).FBounds := AvailableBounds;
    LayoutControl.ViewInfo.Calculate;
    EnumItems(LayoutControl.ViewInfo.ItemsViewInfo);
  finally
    TcxControlAccess(LayoutControl).FBounds := cxNullRect;
    LayoutControl.ViewInfo.Calculate;
  end;
end;

procedure TdxLayoutControlReportLink.ConstructReport(AReportCells: TdxReportCells);
begin
  inherited ConstructReport(AReportCells);
  PostCheckEmbeddedControls;
end;

procedure TdxLayoutControlReportLink.PostCheckEmbeddedControls;
var
  I: Integer;
  LayoutItem: TdxLayoutItem;
  ReportItem: TdxReportCell;
  ADataItem: TdxReportVisualItem;
  BottomPosition: Integer;
  NeedAddBorder: Boolean;

  procedure DoCheckBounds(ACell: TdxReportCell; ATopOffset: Integer);
  var
    I: Integer;
  begin
    for I := 0 to ACell.CellCount - 1 do
      DoCheckBounds(ACell.Cells[I], ATopOffset + ACell.Cells[I].Top);
      for I := 0 to ACell.DataItemCount - 1 do
      begin
        if ADataItem = nil then
          ADataItem := ACell.DataItems[I];
        NeedAddBorder := NeedAddBorder or
          (ACell.DataItems[I].BoundsRect.Bottom + ATopOffset > BottomPosition);
      end;
  end;
  
begin
  for I := 0 to CachedBoundsCount - 1 do
  begin
    ADataItem := nil;
    NeedAddBorder := False;
    if not CachedBoundsItem[I].EmbeddedLink then Continue;
    LayoutItem := LayoutControl.FindItem(TControl(CachedBoundsItem[I].Component));
    Assert(LayoutItem <> nil);
    ReportItem := FindReportItemByLayoutItem(LayoutItem);
    Assert(ReportItem <> nil);
    BottomPosition := ReportItem.Cells[0].Height;
    DoCheckBounds(ReportItem.Cells[0], 0);
    if (ADataItem <> nil) and NeedAddBorder then
      with TdxReportCellString(ReportItem.AddDataItem(TdxReportCellString)) do
      begin
        BoundsRect := ReportItem.Cells[0].BoundsRect;
        Width := Width - 1;
        CellSides := [csBottom];
        BorderClass := ADataItem.BorderClass;
        BorderColor := ADataItem.BorderColor;
      end;
  end;
end;

procedure TdxLayoutControlReportLink.PrepareConstruct;
begin
  ClearCachedBounds;
  LayoutControl.ViewInfo.Calculate;
  CacheControlsBounds;
  inherited;
  ClearCachedFonts;
  PrepareLookAndFeels;
end;

procedure TdxLayoutControlReportLink.PrepareLookAndFeels;

  procedure CreateReportLookAndFeel(ALayoutLookAndFeel: TdxCustomLayoutLookAndFeel);
  var
    ReportLookAndFeel: TdxPSReportGroupLookAndFeel;
  begin
    if ALayoutLookAndFeel = nil then Exit;

    AddCaptionOptionsFontToCache(ALayoutLookAndFeel.GroupOptions.CaptionOptions);
    AddCaptionOptionsFontToCache(ALayoutLookAndFeel.ItemOptions.CaptionOptions);
    
    with LayoutLookAndFeelProducers[ALayoutLookAndFeel] do
    begin
      ReportLookAndFeel := CreateGroupLookAndFeel(ReportLookAndFeelClass, False);
      InitializeReportLookAndFeel(ReportLookAndFeel);
      ReportLookAndFeel.Prepare(ScreenCanvas);
    end;  
  end;
  
  procedure CreateReportLookAndFeels(ALookAndFeels: TList);
  var
    I: Integer;
  begin
    for I := 0 to ALookAndFeels.Count - 1 do
      CreateReportLookAndFeel(TdxCustomLayoutLookAndFeel(ALookAndFeels[I]));
  end;
  
  procedure EnumerateLayoutGroup(AGroup: TdxLayoutGroup; ALookAndFeels: TList);
  var
    I: Integer;
    Child: TdxCustomLayoutItem;
    LookAndFeel: TdxCustomLayoutLookAndFeel;
  begin
    for I := 0 to AGroup.Count - 1 do
    begin
      Child := AGroup.Items[I];
      if Child.Visible then 
      begin
        LookAndFeel := Child.LookAndFeel;
        if ALookAndFeels.IndexOf(LookAndFeel) = -1 then
          ALookAndFeels.Add(LookAndFeel);
        if Child is TdxLayoutGroup then 
          EnumerateLayoutGroup(TdxLayoutGroup(Child), ALookAndFeels);
      end;  
    end;  
  end;

var
  LookAndFeels: TList;
begin
  LookAndFeels := TList.Create;
  try
    LookAndFeels.Add(LayoutControl.LookAndFeel);
    LookAndFeels.Add(LayoutControl.Items.LookAndFeel);
    EnumerateLayoutGroup(LayoutControl.Items, LookAndFeels);

    CreateReportLookAndFeels(LookAndFeels);
  finally
    LookAndFeels.Free;
  end;  
end;

procedure TdxLayoutControlReportLink.RepositionControls;
begin
  Producers[LayoutControl].Reposition;
end;

procedure TdxLayoutControlReportLink.AddHiddenItem(ATreeView: TTreeView; 
  AParent: TTreeNode; AnItem: TdxCustomLayoutItem);
var
  Index, I: Integer;  
begin
  AParent := AddNode(ATreeView, AParent, AnItem, not FindHiddenComponent(AnItem, Index));
  if AnItem is TdxLayoutGroup then
    for I := 0 to TdxLayoutGroup(AnItem).VisibleCount - 1 do
      AddHiddenItem(ATreeView, AParent, TdxLayoutGroup(AnItem).VisibleItems[I]);
end;
  
procedure TdxLayoutControlReportLink.AddItem(ATreeView: TTreeView;
  AParent: TTreeNode; AnItem: TdxCustomLayoutItem);
var
  Index, I: Integer;  
begin
  if not FindHiddenComponent(AnItem, Index) then
  begin
    AParent := AddNode(ATreeView, AParent, AnItem, not FindExcludedComponent(AnItem, Index));
    if AnItem is TdxLayoutGroup then
      for I := 0 to TdxLayoutGroup(AnItem).VisibleCount - 1 do
        AddItem(ATreeView, AParent, TdxLayoutGroup(AnItem).VisibleItems[I]);
  end;    
end;
                             
function TdxLayoutControlReportLink.IsComponentEditable(AComponent: TComponent): Boolean;
begin
  Result := inherited IsComponentEditable(AComponent) and (AComponent <> LayoutControl.Items);
end;

procedure TdxLayoutControlReportLink.LoadControlsTree(ATreeView: TTreeView);
begin
  ATreeView.Items.Clear;
  if Container <> nil then
    AddItem(ATreeView, AddNode(ATreeView, nil, Container, True), RootLayoutGroup);
end;

procedure TdxLayoutControlReportLink.LoadHiddenControlsTree(ATreeView: TTreeView);
begin
  ATreeView.Items.Clear;
  if Container <> nil then
    AddHiddenItem(ATreeView, AddNode(ATreeView, nil, Container, True), RootLayoutGroup);
end;

function TdxLayoutControlReportLink.AddBoundsToCache(
  AComponent: TComponent; const ABounds: TRect): Integer;
var
  AItem: TdxLCBoundsCacheItem;
begin
  AItem := TdxLCBoundsCacheItem.Create;
  AItem.Component := AComponent;
  AItem.Bounds := ABounds;
  Result := CachedBounds.Add(AItem);
end;

function TdxLayoutControlReportLink.AddCaptionOptionsFontToCache(ACaptionOptions: TdxLayoutLookAndFeelCaptionOptions): Integer;
var
  Item: PdxPSLayoutCacheFontItem;
begin
  New(Item);
  Item^.CaptionOptions := ACaptionOptions;
  Item^.FontIndex := GetPreparedFontIndex(ACaptionOptions);
  CachedFonts.Add(Item);
  
  Result := Item^.FontIndex;
end;

procedure TdxLayoutControlReportLink.ClearCachedBounds;
var
  I: Integer;
begin
  for I := 0 to CachedBoundsCount - 1 do
    CachedBoundsItem[I].Free;
  CachedBounds.Clear;
end;

procedure TdxLayoutControlReportLink.ClearCachedFonts;
var
  I: Integer;
begin
  for I := 0 to CachedFontItemCount - 1 do
    Dispose(PdxPSLayoutCacheFontItem(CachedFontItems[I]));
  CachedFonts.Clear;  
end;

function TdxLayoutControlReportLink.FindBoundsByComponent(
  AComponent: TComponent; var ABounds: TRect; ASetEmbedded: Boolean): Boolean;
var
  I: Integer; 
begin
  Result := AComponent <> nil;
  if not Result then Exit;
  for I := 0 to CachedBoundsCount - 1 do
    if AComponent = CachedBoundsItem[I].Component then
    begin
      ABounds := CachedBoundsItem[I].Bounds;
      CachedBoundsItem[I].EmbeddedLink := ASetEmbedded;
      Exit;
    end;
  Result := False;
end;

function TdxLayoutControlReportLink.FindFontIndexByCaptionOptions(ACaptionOptions: TdxLayoutLookAndFeelCaptionOptions): Integer;
var
  I: Integer;
  Item: PdxPSLayoutCacheFontItem;
begin
  for I := 0 to CachedFontItemCount - 1 do
  begin
    Item := CachedFontItems[I];
    if Item^.CaptionOptions = ACaptionOptions then 
    begin
      Result := Item^.FontIndex;
      Exit;
    end;  
  end;
  Result := 0;
end;

procedure TdxLayoutControlReportLink.FreeAndNilCachedBounds;
begin
  ClearCachedBounds;
  FreeAndNil(FCachedBounds)
end;

procedure TdxLayoutControlReportLink.FreeAndNilCachedFonts;
begin
  ClearCachedFonts;
  FreeAndNil(FCachedFonts);
end;

procedure TdxLayoutControlReportLink.CreateOptions;
begin
  inherited;
  FOptionsSize := GetOptionsSizeClass.Create(Self);
end;

procedure TdxLayoutControlReportLink.DestroyOptions;
begin
  FreeAndNil(FOptionsSize);
  inherited;
end;

function TdxLayoutControlReportLink.GetOptionsPaginationClass: TdxCustomContainerReportLinkOptionsPaginationClass;
begin
  Result := TdxLayoutControlReportLinkOptionsPagination;
end;

function TdxLayoutControlReportLink.GetOptionsSizeClass: TdxLayoutControlReportLinkOptionsSizeClass;
begin
  Result := TdxLayoutControlReportLinkOptionsSize;
end;

function TdxLayoutControlReportLink.GetOptionsTransparentClass: TdxCustomContainerReportLinkOptionsTransparentClass;
begin
  Result := TdxLayoutControlReportLinkOptionsTransparent;
end;

function TdxLayoutControlReportLink.FindReportGroupLookAndFeel(ALayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSReportGroupLookAndFeel;
begin
  Result := ReportCells.FindGroupLookAndFeelByData(ALayoutLookAndFeel)
end;

function TdxLayoutControlReportLink.FindReportItemByLayoutItem(ALayoutItem: TdxCustomLayoutItem): TdxReportCell;

  function SearchCell(ACell: TdxReportCell): TdxReportCell;
  var
    I: Integer;
  begin
    Result := ACell;
    if TObject(Result.Data) = ALayoutItem then Exit;
    
    for I := 0 to ACell.CellCount - 1 do
    begin
      Result := SearchCell(ACell[I]);
      if Result <> nil then Exit;
    end;
    Result := nil;
  end;
  
begin
  Result := SearchCell(RootCell);
end;

procedure TdxLayoutControlReportLink.GetLayoutItemList(AControl: TdxLayoutControl;
  AnItems: TList);

  procedure EnumerateLayoutGroup(AGroup: TdxLayoutGroup);
  var
    I: Integer;
    Item: TdxCustomLayoutItem;
  begin
    for I := 0 to AGroup.VisibleCount - 1 do
    begin
      Item := AGroup.VisibleItems[I];
//      if IsComponentProcessed(Item) then
      begin
        AnItems.Add(Item);
        if Item is TdxLayoutGroup then
          EnumerateLayoutGroup(TdxLayoutGroup(Item));
      end;
    end;
  end;

begin
  if IsComponentProcessed(AControl.Items) then
  begin
    AnItems.Add(AControl.Items);
    EnumerateLayoutGroup(AControl.Items);
  end;
end;

function TdxLayoutControlReportLink.GetPreparedFontIndex(ACaptionOptions: TdxLayoutLookAndFeelCaptionOptions): Integer;
begin
  with PreparationFont do 
  begin
    Assign(ACaptionOptions.GetFont(LayoutControl));
    Color := ACaptionOptions.GetTextColor;
    if ACaptionOptions.HotTrack and (htsUnderlineCold in ACaptionOptions.HotTrackStyles) then
      Style := Style + [fsUnderline];
    if not dxIsTrueTypeFont(PreparationFont) then 
      Name := Font.Name;
  end;
  Result := AddFontToPool(PreparationFont);  
end;

// IdxReportLinkController

function TdxLayoutControlReportLink.GetControlSiteBounds(AControl: TControl): TRect;
var
  LayoutItem: TdxLayoutItem;
  ReportItem: TdxReportCell;
begin
  if not FindBoundsByComponent(AControl, Result, True) then
  begin
    LayoutItem := LayoutControl.FindItem(AControl);
    Assert(LayoutItem <> nil);
    ReportItem := FindReportItemByLayoutItem(LayoutItem);
    Assert(ReportItem <> nil);
    Result := (ReportItem as TdxReportLayoutItem).ControlBounds;
  end;
end;

function TdxLayoutControlReportLink.GetAvailableBounds: TRect;
begin
  Result := LayoutControl.ClientBounds;
  if OptionsSize.AutoWidth then 
    with RealPrinterPage.PaintRectPixels do 
    begin
      Result.Left := 0;
      Result.Right := Right - Left - 1;
    end;
end;

function TdxLayoutControlReportLink.GetCachedBoundsCount: Integer;
begin
  Result := CachedBounds.Count;
end;

function TdxLayoutControlReportLink.GetCachedBoundsItem(Index: Integer): TdxLCBoundsCacheItem;
begin
  Result := TdxLCBoundsCacheItem(CachedBounds[Index]);
end;

function TdxLayoutControlReportLink.GetCachedFontItem(Index: Integer): PdxPSLayoutCacheFontItem;
begin
  Result := FCachedFonts[Index];
end;

function TdxLayoutControlReportLink.GetCachedFontItemCount: Integer;
begin
  Result := FCachedFonts.Count;
end;

function TdxLayoutControlReportLink.GetCurrentHost: TdxReportCell;
begin
  Result := FindReportItemByLayoutItem(CurrentLayoutItem);
end;

function TdxLayoutControlReportLink.GetLayoutControl: TdxLayoutControl;
begin
  Result := TdxLayoutControl(Container);
end;

function TdxLayoutControlReportLink.GetLayoutItemProducer(LayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducer;
begin
  Result := LayoutItemProducerCache[dxPSLayoutItemProducerFactory[LayoutItem], LayoutItem];
end;

function TdxLayoutControlReportLink.GetLayoutLookAndFeelProducer(LayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSLayoutLookAndFeelProducer;
begin
  Result := LayoutLookAndFeelProducerCache[dxPSLayoutLookAndFeelProducerFactory[LayoutLookAndFeel], LayoutLookAndFeel];
end;

function TdxLayoutControlReportLink.GetOptionsPagination: TdxLayoutControlReportLinkOptionsPagination;
begin
  Result := inherited OptionsPagination as TdxLayoutControlReportLinkOptionsPagination;
end;

function TdxLayoutControlReportLink.GetOptionsTransparent: TdxLayoutControlReportLinkOptionsTransparent;
begin
  Result := inherited OptionsTransparent as TdxLayoutControlReportLinkOptionsTransparent;
end;

function TdxLayoutControlReportLink.GetRootLayoutGroup: TdxLayoutGroup;
begin
  Result := LayoutControl.Items;
end;

procedure TdxLayoutControlReportLink.SetOptionsPagination(Value: TdxLayoutControlReportLinkOptionsPagination);
begin
  inherited OptionsPagination := Value;
end;

procedure TdxLayoutControlReportLink.SetOptionsSize(Value: TdxLayoutControlReportLinkOptionsSize);
begin
  OptionsSize.Assign(Value);
end;

procedure TdxLayoutControlReportLink.SetOptionsTransparent(Value: TdxLayoutControlReportLinkOptionsTransparent);
begin
  inherited OptionsTransparent := Value;
end;

{ TdxPSLayoutControlDesignWindow }

procedure TdxPSLayoutControlDesignWindow.DoInitialize;
begin
  inherited;

  with LayoutReportLink.OptionsPagination do 
  begin
    chbxPaginateByGroups.Checked := Groups;
    chbxPaginateByItems.Checked := Items;
  end;
  chbxPaginateByGroups.Visible := True;
  chbxPaginateByItems.Visible := True;
  
  with LayoutReportLink.OptionsTransparent do 
  begin
    chbxTransparentGroups.Checked := Groups;
    chbxTransparentItems.Checked := Items;
  end;
  chbxTransparentGroups.Visible := True;
  chbxTransparentItems.Visible := True;

  chbxAutoWidth.Checked := LayoutReportLink.OptionsSize.AutoWidth;
  chbxAutoWidth.Visible := True;
  lblSize.Visible := True;
  imgSize.Visible := True;
end;

procedure TdxPSLayoutControlDesignWindow.SetOptionsPaginationByIndex(AnIndex: Integer; 
  AValue: Boolean);
begin
  if LockControlsUpdate then Exit;

  if AnIndex > 1 then 
  begin
    case AnIndex of
      2: LayoutReportLink.OptionsPagination.Groups := AValue;
      3: LayoutReportLink.OptionsPagination.Items := AValue;
    end;  
    Modified := True;  
  end  
  else
    inherited;
end;

procedure TdxPSLayoutControlDesignWindow.SetOptionsSizeByIndex(AnIndex: Integer; 
  AValue: Boolean);
begin
  if LockControlsUpdate then Exit;

  inherited;
  if AnIndex = 0 then 
  begin
    LayoutReportLink.OptionsSize.AutoWidth := AValue;
    Modified := True;  
  end;  
end;

procedure TdxPSLayoutControlDesignWindow.SetOptionsTransparentByIndex(AnIndex: Integer; 
  AValue: Boolean);
begin
  if LockControlsUpdate then Exit;

  if AnIndex > 3 then 
  begin
    case AnIndex of
      4: LayoutReportLink.OptionsTransparent.Groups := AValue;
      5: LayoutReportLink.OptionsTransparent.Items := AValue;
    end;  
    Modified := True;  
  end  
  else
    inherited;
end;

procedure TdxPSLayoutControlDesignWindow.InitializeControlsTree;
var
  Root: TTreeNode;
begin
  inherited;
  Root := TreeView_GetRoot(tvControls.InnerTreeView);
  if (Root <> nil) and (Root.Count <> 0) then
    Root[0].Expand(False);
end;

procedure TdxPSLayoutControlDesignWindow.InitializeHiddenControlsTree;
var
  Root: TTreeNode;
begin
  inherited;
  Root := TreeView_GetRoot(tvHiddenControls.InnerTreeView);
  if (Root <> nil) and (Root.Count <> 0) then
    Root[0].Expand(False);
end;

function TdxPSLayoutControlDesignWindow.IsBoldNode(ANode: TTreeNode): Boolean; 
begin
  Result := inherited IsBoldNode(ANode) or (TreeView_GetNodeObject(ANode).Component is TdxLayoutGroup);
end;

function TdxPSLayoutControlDesignWindow.GetLayoutReportLink: TdxLayoutControlReportLink;
begin
  Result := TdxLayoutControlReportLink(ReportLink);
end;

procedure RegisterAssistants;
begin
  TdxPSLayoutLookAndFeelProducer.Register;
  TdxPSLayoutStandardLookAndFeelProducer.Register;
  TdxPSLayoutOfficeLookAndFeelProducer.Register;
  TdxPSLayoutWebLookAndFeelProducer.Register;
  
  TdxPSCustomLayoutItemProducer.Register;
  TdxPSLayoutGroupProducer.Register;
  TdxPSLayoutItemProducer.Register;
  
  TdxPSLayoutControlProducer.Register;

  TdxPSNativeLayoutControlProducer.Register;
end;

procedure RegisterItems;
begin
  TdxReportLayoutControlHost.Register;
  TdxCustomReportLayoutItem.Register;
  TdxReportLayoutGroup.Register;
  TdxReportLayoutItem.Register;
end;

procedure UnregisterAssistants;
begin
  TdxPSNativeLayoutControlProducer.Unregister;
  
  TdxPSLayoutControlProducer.Unregister;
  
  TdxPSLayoutItemProducer.Unregister;  
  TdxPSLayoutGroupProducer.Unregister;
  TdxPSCustomLayoutItemProducer.Unregister;

  TdxPSLayoutWebLookAndFeelProducer.Unregister;
  TdxPSLayoutOfficeLookAndFeelProducer.Unregister;
  TdxPSLayoutStandardLookAndFeelProducer.Unregister;
  TdxPSLayoutLookAndFeelProducer.Unregister;
      
  TdxPSLayoutItemProducerFactory.ReleaseInstance;
  TdxPSLayoutLookAndFeelProducerFactory.ReleaseInstance;
end;

procedure UnregisterItems;
begin
  TdxReportLayoutItem.Unregister;
  TdxReportLayoutGroup.Unregister;
  TdxCustomReportLayoutItem.Unregister;
  TdxReportLayoutControlHost.Unregister;
end;

initialization
  RegisterAssistants;
  RegisterItems;
 
  dxPSRegisterReportLink(TdxLayoutControlReportLink, TdxLayoutControl, TdxPSLayoutControlDesignWindow);  
  
finalization
  dxPSUnregisterReportLink(TdxLayoutControlReportLink, TdxLayoutControl, TdxPSLayoutControlDesignWindow);
  
  UnregisterItems;
  UnregisterAssistants;

end.
