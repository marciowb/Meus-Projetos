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

unit dxPScxTLLnk;

interface
    
{$I cxVer.inc}

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, StdCtrls, ComCtrls, 
  ExtCtrls, ImgList, dxExtCtrls, Menus, Dialogs, ExtDlgs, cxClasses, cxControls, 
  cxGraphics, cxStyles, cxLookAndFeels, cxLookAndFeelPainters, cxEdit, cxTextEdit, 
  cxInplaceContainer, cxTL, cxDBTL, cxTLData, cxCustomData, dxBase, dxPSSngltn, 
  dxPrnPg, dxPSCore, dxPScxCommon;

const
  vspsTreeListFirst = 0;
  vspsTreeListBandHeader = vspsTreeListFirst + 0;
  vspsTreeListContent = vspsTreeListFirst + 1;
  vspsTreeListContentEven = vspsTreeListFirst + 2;
  vspsTreeListContentOdd = vspsTreeListFirst + 3;
  vspsTreeListFooter = vspsTreeListFirst + 4;
  vspsTreeListFooterRow = vspsTreeListFirst + 5;
  vspsTreeListHeader = vspsTreeListFirst + 6;
  vspsTreeListIndent = vspsTreeListFirst + 7;
  vspsTreeListPreview = vspsTreeListFirst + 8;
  vspsTreeListSelection = vspsTreeListFirst + 9;
  vspsTreeListLast = vspsTreeListSelection;

  cxTreeListAttributeIDBase = 0;
  cxTreeListUndefinedID = cxTreeListAttributeIDBase + 0;
  cxTreeListBandID = cxTreeListAttributeIDBase + 1;
  cxTreeListFooterID = cxTreeListAttributeIDBase + 2;
  cxTreeListHeaderID = cxTreeListAttributeIDBase + 3;
  cxTreeListIndentID = cxTreeListAttributeIDBase + 4;
  cxTreeListNodeID = cxTreeListAttributeIDBase + 5;
  
type
  TcxTreeListNodeClass = class of TcxTreeListNode;

  TcxTreeListControlReportLink = class;
  TdxfmTreeListReportLinkDesignWindow = class;
  
  TcxTreeListControlAttributeHostInfo = class;
  TcxTreeListControlAdapterClass = class of TcxTreeListControlAdapter;
  TcxTreeListControlAdapter = class;
  TcxTreeListControlReportLinkFormatterClass = class of TcxTreeListControlReportLinkFormatter;
  TcxTreeListControlReportLinkFormatter = class;
  TcxTreeListControlReportLinkBuilderClass = class of TcxTreeListControlReportLinkBuilder;
  TcxTreeListControlReportLinkBuilder = class;
  
  TcxTreeListAttributeClass = class of TcxTreeListAttribute;
  TcxTreeListAttribute = class end;
  TcxTreeListBandAttribute = class(TcxTreeListAttribute);
  TcxTreeListNodeAttribute = class(TcxTreeListAttribute);
  TcxTreeListFooterAttribute = class(TcxTreeListAttribute);
  TcxTreeListHeaderAttribute = class(TcxTreeListAttribute);
  
  TcxTreeListAttributeID = type Integer;

  TcxTreeListCellCustomDrawInfo = record
    AttributeID: TcxTreeListAttributeID;
    Band: TcxTreeListBand;
    Column: TcxTreeListColumn;
    Node: TcxTreeListNode;
    Index: Integer;
  end;

  TdxTLColumnPlace = record
    Left: Integer;
    Right: Integer;
    RowIndex: Integer;
    LineCount: Integer;
  end;
  
  { producers }

  TcxTreeListControlReportLinkRowProducerClass = class of TcxTreeListControlReportLinkRowProducer;
  
  TcxTreeListControlReportLinkRowProducer = class
  private
    FBuilder: TcxTreeListControlReportLinkBuilder;
    FHost: TdxReportCell;
    FRow: TdxReportCell;
    FRowHeight: Integer;
    function GetDC: HDC;
    function GetIndentWidth: Integer;    
    function GetRowWidth: Integer;
  protected
    procedure CalculateRowAutoHeight; virtual;  
    procedure CalculateRowHeight; virtual;
    procedure CreateRow; virtual;
    procedure CreateRowHost(const AHostInfo: TcxTreeListControlAttributeHostInfo); virtual;
    function DoesItemParticipateInRowAutoHeightCalculation(AnItem: TdxReportVisualItem): Boolean; virtual;
    procedure FixupRowDataHeight; virtual;
    procedure FixupRowHeight; virtual;
    procedure FixupRowItselfHeight; virtual;
    procedure InitializeRow; virtual;
    
    function GetAutoHeight: Boolean; virtual;
    function GetLineCount: Integer; virtual;
    function GetLineHeight: Integer; virtual;

    property DC: HDC read GetDC;
  public
    constructor Create(ABuilder: TcxTreeListControlReportLinkBuilder); virtual;
    
    function Adapter: TcxTreeListControlAdapter; overload; virtual;
    function Builder: TcxTreeListControlReportLinkBuilder; overload; virtual;
    function Formatter: TcxTreeListControlReportLinkFormatter; overload; virtual;

    function Produce(AHostInfo: TcxTreeListControlAttributeHostInfo): TdxReportCell; virtual;

    property AutoHeight: Boolean read GetAutoHeight;
    property Host: TdxReportCell read FHost;
    property IndentWidth: Integer read GetIndentWidth;
    property LineCount: Integer read GetLineCount;
    property LineHeight: Integer read GetLineHeight;
    property Row: TdxReportCell read FRow;
    property RowHeight: Integer read FRowHeight write FRowHeight;
    property RowWidth: Integer read GetRowWidth;
  end;
  
  TcxTreeListControlReportLinkCustomRowProducerClass = class of TcxTreeListControlReportLinkCustomRowProducer;
  
  TcxTreeListControlReportLinkCustomRowProducer = class(TcxTreeListControlReportLinkRowProducer)
  private
    FItem: TAbstractdxReportCellData;
  protected  
    procedure CreateItem; virtual;
    procedure InitializeItem; virtual;
    
    function GetAutoHeight: Boolean; override;    
    function GetItemClass: TdxReportCellDataClass; virtual;
        
    property Item: TAbstractdxReportCellData read FItem;
  public
    function Produce(AHostInfo: TcxTreeListControlAttributeHostInfo): TdxReportCell; override;
  end;

  TcxTreeListControlReportLinkNodeSeparatorProducerClass = class of TcxTreeListControlReportLinkNodeSeparatorProducer;
  
  TcxTreeListControlReportLinkNodeSeparatorProducer = class(TcxTreeListControlReportLinkCustomRowProducer)
  private
    function GetItem: TdxReportCellBox;
  protected
    procedure InitializeItem; override;  
    procedure InitializeRow; override;
  
    function GetItemClass: TdxReportCellDataClass; override;
    function GetLineHeight: Integer; override;
  public
    property Item: TdxReportCellBox read GetItem;
  end;
  
  TcxTreeListControlReportLinkRowSubItemsProducerClass = class of TcxTreeListControlReportLinkRowSubItemsProducer;
  
  TcxTreeListControlReportLinkRowSubItemsProducer = class(TcxTreeListControlReportLinkRowProducer)
  private
    function GetColumn(Index: Integer): TcxTreeListColumn;
  protected  
    procedure CreateDataItems(AParent: TdxReportCell); virtual;
    procedure CreateIcons(AParent: TdxReportCell); virtual;
    procedure CreateIndents(AParent: TdxReportCell); virtual;
    procedure CreateRow; override;
    procedure InitializeSubItem(ASubItem: TAbstractdxReportCellData; AnIndex: Integer); virtual;
    
    function GetHasSubItem(Index: Integer): Boolean; virtual;
    function GetSubItemBound(Index: Integer): TRect; virtual;
    function GetSubItemClass(Index: Integer): TdxReportCellDataClass; virtual; abstract;
    function GetSubItemCount: Integer; virtual;
  public
    property Columns[Index: Integer]: TcxTreeListColumn read GetColumn;
    property HasSubItem[Index: Integer]: Boolean read GetHasSubItem;
    property SubItemBounds[Index: Integer]: TRect read GetSubItemBound;
    property SubItemClasses[Index: Integer]: TdxReportCellDataClass read GetSubItemClass;
    property SubItemCount: Integer read GetSubItemCount;
  end;
  
  TcxTreeListControlReportLinkBandsProducerClass = class of TcxTreeListControlReportLinkBandsProducer;
  
  TcxTreeListControlReportLinkBandsProducer = class(TcxTreeListControlReportLinkRowSubItemsProducer)
  protected
    procedure InitializeRow; override;
    procedure InitializeSubItem(ASubItem: TAbstractdxReportCellData; AnIndex: Integer); override;
    
    function GetAutoHeight: Boolean; override;
    function GetLineCount: Integer; override;
    function GetLineHeight: Integer; override;    
    function GetSubItemBound(Index: Integer): TRect; override;
    function GetSubItemClass(Index: Integer): TdxReportCellDataClass; override;
    function GetSubItemCount: Integer; override;
  end;
  
  TcxTreeListControlReportLinkFootersProducerClass = class of TcxTreeListControlReportLinkFootersProducer;
  
  TcxTreeListControlReportLinkFootersProducer = class(TcxTreeListControlReportLinkRowSubItemsProducer)
  protected
    procedure CalculateRowHeight; override;
    procedure InitializeRow; override;
    procedure InitializeSubItem(ASubItem: TAbstractdxReportCellData; AnIndex: Integer); override;
    
    function GetAutoHeight: Boolean; override;
    function GetHasSubItem(Index: Integer): Boolean; override;
    function GetLineCount: Integer; override;
    function GetLineHeight: Integer; override;
    function GetSubItemBound(Index: Integer): TRect; override;        
    function GetSubItemClass(Index: Integer): TdxReportCellDataClass; override;
  end;
  
  TcxTreeListControlReportLinkHeadersProducerClass = class of TcxTreeListControlReportLinkHeadersProducer;
  
  TcxTreeListControlReportLinkHeadersProducer = class(TcxTreeListControlReportLinkRowSubItemsProducer)
  protected
    procedure InitializeRow; override;
    procedure InitializeSubItem(ASubItem: TAbstractdxReportCellData; AnIndex: Integer); override;
    
    function GetAutoHeight: Boolean; override;
    function GetLineCount: Integer; override;
    function GetLineHeight: Integer; override;    
    function GetSubItemBound(Index: Integer): TRect; override;
    function GetSubItemClass(Index: Integer): TdxReportCellDataClass; override;
  end;

  TcxTreeListControlReportLinkNodeProducerClass = class of TcxTreeListControlReportLinkNodeProducer;
  
  TcxTreeListControlReportLinkNodeProducer = class(TcxTreeListControlReportLinkRowSubItemsProducer)
  private
    FImage: TdxReportCellGraphic;
    FIndents: TList;
    FNode: TcxTreeListNode;
    FPreviewItem: TAbstractdxReportCellData;
    FStateImage: TdxReportCellGraphic;
    function GetImageIndentIndex: Integer;
    function GetIndent(Index: Integer): TdxReportCellExpandButton;
    function GetIndentArea: Integer;
    function GetIndentBound(Index: Integer): TRect;
    function GetPreviewColumn: TcxTreeListColumn;
    function GetPreviewPlace: TcxTreeListPreviewPlace;
    function GetStateImageIndentIndex: Integer;
  protected
    procedure CalculateRowAutoHeight; override;
    procedure CreateDataItems(AParent: TdxReportCell); override;   
    procedure CreateIcons(AParent: TdxReportCell); override;
    procedure CreateImages(AParent: TdxReportCell); virtual;
    procedure CreateIndents(AParent: TdxReportCell); override;
    procedure CreatePreview(AParent: TdxReportCell); virtual;
    procedure CreateStateImages(AParent: TdxReportCell); virtual;
    function DoesItemParticipateInRowAutoHeightCalculation(AnItem: TdxReportVisualItem): Boolean; override;
    procedure FixupRowDataHeight; override;
    procedure InitializeImage(AnIndex: Integer); virtual;
    procedure InitializeIndent(AnIndent: TdxReportCellExpandButton; AnIndex: Integer); virtual;
    procedure InitializeRow; override;
    procedure InitializeStateImage(AnIndex: Integer); virtual;
    procedure InitializeSubItem(ASubItem: TAbstractdxReportCellData; AnIndex: Integer); override;
    function IsItemIndent(AnItem: TdxReportVisualItem): Boolean;

    function GetAutoHeight: Boolean; override;
    function GetCellAutoHeight: Boolean; virtual;
    function GetHasPreview: Boolean; virtual;
    function GetImageRect: TRect; virtual;
    function GetIndentCount: Integer; virtual;
    function GetLineCount: Integer; override;
    function GetLineHeight: Integer; override;
    function GetPreviewHeight: Integer; virtual;
    function GetPreviewIndent: Integer; virtual;
    function GetPreviewLineCount: Integer; virtual;
    function GetPreviewLineHeight: Integer; virtual;
    function GetStateImageRect: TRect; virtual;
    function GetSubItemBound(Index: Integer): TRect; override;    
    function GetSubItemClass(Index: Integer): TdxReportCellDataClass; override;
  public  
    constructor Create(ABuilder: TcxTreeListControlReportLinkBuilder); override;
    destructor Destroy; override;

    function Node: TcxTreeListNode; overload; virtual;
    function Produce(AHostInfo: TcxTreeListControlAttributeHostInfo; ANode: TcxTreeListNode): TdxReportCell; reintroduce; virtual;

    property CellAutoHeight: Boolean read GetCellAutoHeight;
    property HasPreview: Boolean read GetHasPreview;
    property Image: TdxReportCellGraphic read FImage;
    property ImageIndentIndex: Integer read GetImageIndentIndex;
    property ImageRect: TRect read GetImageRect;
    property IndentArea: Integer read GetIndentArea;
    property IndentBounds[Index: Integer]: TRect read GetIndentBound;
    property IndentCount: Integer read GetIndentCount;
    property Indents[Index: Integer]: TdxReportCellExpandButton read GetIndent;
    property PreviewColumn: TcxTreeListColumn read GetPreviewColumn;
    property PreviewHeight: Integer read GetPreviewHeight;    
    property PreviewIndent: Integer read GetPreviewIndent;
    property PreviewItem: TAbstractdxReportCellData read FPreviewItem;
    property PreviewLineCount: Integer read GetPreviewLineCount;
    property PreviewLineHeight: Integer read GetPreviewLineHeight;
    property PreviewPlace: TcxTreeListPreviewPlace read GetPreviewPlace;
    property StateImage: TdxReportCellGraphic read FStateImage;
    property StateImageIndentIndex: Integer read GetStateImageIndentIndex;
    property StateImageRect: TRect read GetStateImageRect;
  end;

  TcxTreeListControlReportLinkCategorizedNodeProducer = class(TcxTreeListControlReportLinkNodeProducer)
  protected
    procedure InitializeSubItem(ASubItem: TAbstractdxReportCellData; AnIndex: Integer); override;
    function GetSubItemBound(Index: Integer): TRect; override;
    function GetSubItemCount: Integer; override;
  end;
  
  { helpers }
  
  TcxTreeListNodeHelperClass = class of TcxTreeListNodeHelper;
  
  TcxTreeListNodeHelper = class(TdxCustomClassMapItem)
  private
    FAdapter: TcxTreeListControlAdapter;
    FNode: TcxTreeListNode;
  protected
    function Adapter: TcxTreeListControlAdapter; overload; virtual;
    class function NodeClass: TcxTreeListNodeClass; virtual;
    
    function GetHasSelectedChildren: Boolean; virtual;
    function GetHasSelectedParents: Boolean; virtual;
  public
    constructor Create(AnAdapter: TcxTreeListControlAdapter); virtual;

    class function PairClass: TClass; override;
    class function ProducerClass: TcxTreeListControlReportLinkNodeProducerClass; virtual;
    class procedure Register;
    class procedure Unregister;

    property HasSelectedChildren: Boolean read GetHasSelectedChildren;
    property HasSelectedParents: Boolean read GetHasSelectedParents;
    property Node: TcxTreeListNode read FNode write FNode;
  end;
                                               
  TcxTreeListNodeHelperCache = class(TdxCustomCache)
  private
    FAdapter: TcxTreeListControlAdapter;
    function GetHelper(Node: TcxTreeListNode): TcxTreeListNodeHelper;
    function GetItem(Index: Integer): TcxTreeListNodeHelper;
  protected 
    function IndexOf(Node: TcxTreeListNode): Integer;
    property Items[Index: Integer]: TcxTreeListNodeHelper read GetItem;
  public
    constructor Create(AnAdapter: TcxTreeListControlAdapter);

    property Adapter: TcxTreeListControlAdapter read FAdapter;
    property Helpers[Node: TcxTreeListNode]: TcxTreeListNodeHelper read GetHelper; default;
  end;
    
  TcxTreeListControlReportLinkProducerCache = class(TdxCustomCache)
  private
    FBuilder: TcxTreeListControlReportLinkBuilder;
    function GetItem(Index: Integer): TcxTreeListControlReportLinkRowProducer;
    function GetProducer(ProducerClass: TcxTreeListControlReportLinkRowProducerClass): TcxTreeListControlReportLinkRowProducer;
  protected 
    function IndexOf(AProducerClass: TcxTreeListControlReportLinkRowProducerClass): Integer;
    property Items[Index: Integer]: TcxTreeListControlReportLinkRowProducer read GetItem;
  public
    constructor Create(ABuilder: TcxTreeListControlReportLinkBuilder);
    property Builder: TcxTreeListControlReportLinkBuilder read FBuilder;
    property Producers[ProducerClass: TcxTreeListControlReportLinkRowProducerClass]: TcxTreeListControlReportLinkRowProducer read GetProducer; default;
  end;
    
  TcxTreeListControlReportLinkBuilder = class
  private
    FAdapter: TcxTreeListControlAdapter;
    FFormatter: TcxTreeListControlReportLinkFormatter;
    FProducerCache: TcxTreeListControlReportLinkProducerCache;
    FReportLink: TcxTreeListControlReportLink;
    FReportRows: TList;
    function GetAutoWidth: Boolean;
    function GetAvailableWidth: Integer;
    function GetHost: TdxReportCell;
    function GetReportCells: TdxReportCells;
    function GetReportRow(Index: Integer): TdxReportCell;
    function GetReportRowCount: Integer;
    function GetTreeListControl: TcxCustomTreeListControl;
  protected
    procedure AddReportRow(ARow: TdxReportCell);
    procedure AfterBuilding; virtual;
    procedure BeforeBuilding; virtual;
    { bands }
    procedure CreateBands; virtual;
    function GetBandsProducer: TcxTreeListControlReportLinkBandsProducer; 
    function GetBandsProducerClass: TcxTreeListControlReportLinkBandsProducerClass; virtual;
    { footers }
    procedure CreateFooters; virtual;
    function GetFootersProducer: TcxTreeListControlReportLinkFootersProducer;
    function GetFootersProducerClass: TcxTreeListControlReportLinkFootersProducerClass; virtual;
    { headers }
    procedure CreateHeaders; virtual;
    function GetHeadersProducer: TcxTreeListControlReportLinkHeadersProducer;
    function GetHeadersProducerClass: TcxTreeListControlReportLinkHeadersProducerClass; virtual;
    { nodes }
    procedure CreateNode(ANode: TcxTreeListNode); virtual;
    procedure CreateNodes; virtual;
    function GetNodeProducer(ANode: TcxTreeListNode): TcxTreeListControlReportLinkNodeProducer;
    function GetNodeProducerClass(ANode: TcxTreeListNode): TcxTreeListControlReportLinkNodeProducerClass; virtual;
    { separators }
    procedure CreateNodeSeparator(ANode: TcxTreeListNode); virtual;
    function GetNodeSeparatorProducer: TcxTreeListControlReportLinkNodeSeparatorProducer;
    function GetNodeSeparatorProducerClass: TcxTreeListControlReportLinkNodeSeparatorProducerClass; virtual;
    
    procedure DoBuild; virtual;
    function IsAborted: Boolean;
    
    property ProducerCache: TcxTreeListControlReportLinkProducerCache read FProducerCache;
    property ReportLink: TcxTreeListControlReportLink read FReportLink;
  public
    constructor Create(AReportLink: TcxTreeListControlReportLink); virtual;
    destructor Destroy; override;

    procedure Build; virtual;
    procedure Progress(const APercentDone: Double);

    function Adapter: TcxTreeListControlAdapter; overload; virtual;
    class function AdapterClass: TcxTreeListControlAdapterClass; virtual;
    function Formatter: TcxTreeListControlReportLinkFormatter; overload; virtual;
    class function FormatterClass: TcxTreeListControlReportLinkFormatterClass; virtual;

    property AutoWidth: Boolean read GetAutoWidth;
    property AvailableWidth: Integer read GetAvailableWidth;
    property Host: TdxReportCell read GetHost;
    property ReportCells: TdxReportCells read GetReportCells;
    property ReportRowCount: Integer read GetReportRowCount;
    property ReportRows[Index: Integer]: TdxReportCell read GetReportRow;
    property TreeListControl: TcxCustomTreeListControl read GetTreeListControl;
  end;

  TcxTreeListReportLinkBuilderHandler = class
  private
    FBuilder: TcxTreeListControlReportLinkBuilder;
    function GetReportLink: TcxTreeListControlReportLink;
  public
    constructor Create(ABuilder: TcxTreeListControlReportLinkBuilder); virtual;
    function Builder: TcxTreeListControlReportLinkBuilder; overload; virtual;

    property ReportLink: TcxTreeListControlReportLink read GetReportLink; 
  end;
  
  TcxTreeListControlAdapter = class(TcxTreeListReportLinkBuilderHandler)
  private
    FAutoWidth: Boolean;
    FAvailableWidth: Integer;
    FBandLineCount: Integer;
    FBandPlaces: array of TRect;
    FBandWidths: array of Integer;
    FColumnPlaces: array of TdxTLColumnPlace;
    FColumnWidths: array of Integer;
    FDetailsLineCount: Integer;
    FFooterLineCount: Integer;
    FHelperCache: TcxTreeListNodeHelperCache;
    function GetBand(Index: Integer): TcxTreeListBand;
    function GetBandCount: Integer;
    function GetBandOrigin(Index: Integer): Integer;
    function GetBandPlace(Index: Integer): TRect;
    function GetBandWidth(Index: Integer): Integer;
    function GetCanUseLookAndFeelColors: Boolean;
    function GetCategorizedColumn: TcxTreeListColumn;
    function GetCellAutoHeight: Boolean;
    function GetCellEndEllipsis: Boolean; 
    function GetCellMultiline: Boolean;
    function GetColumn(Index: Integer): TcxTreeListColumn;
    function GetColumnCount: Integer;
    function GetColumnPlace(Index: Integer): TdxTLColumnPlace;
    function GetColumnWidth(Index: Integer): Integer;
    function GetDefaultRowHeight: Integer;
    function GetFooterItemText(Index: Integer): string;
    function GetGridLines: TcxTreeListGridLines;
    function GetGridLinesColor: TColor;
    function GetHasFooterItem(Index: Integer): Boolean;
    function GetHasPreview: Boolean;
    function GetHeaderAutoHeight: Boolean;
    function GetHelper(Node: TcxTreeListNode): TcxTreeListNodeHelper;
    function GetImages: TCustomImageList;
    function GetIndentWidth: Integer;
    function GetIsDefaultRowHeightAssigned: Boolean;
    function GetIsNodeColorUsedForIndents: Boolean;
    function GetLookAndFeelKind: TcxLookAndFeelKind;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
    function GetMultiSelection: Boolean;
    function GetNode(Index: Integer): TcxTreeListNode;
    function GetNodeCount: Integer;
    function GetOptionsView: TcxTreeListOptionsView;
    function GetPaintStyle: TcxTreeListPaintStyle;
    function GetPreviewColumn: TcxTreeListColumn;
    function GetPreviewLeftIndent: Integer;
    function GetPreviewPlace: TcxTreeListPreviewPlace;
    function GetPreviewRightIndent: Integer;
    function GetShowRoot: Boolean;
    function GetShowHorzGridLines: Boolean;
    function GetShowTreeLines: Boolean;
    function GetShowVertGridLines: Boolean;
    function GetStateImages: TCustomImageList;
    function GetStyles: TcxTreeListStyles;
    function GetThemedBandHeaderItemColor: TColor;
    function GetThemedBandHeaderItemTextColor: TColor;
    function GetThemedFooterItemColor: TColor;
    function GetThemedFooterItemTextColor: TColor;
    function GetThemedHeaderItemColor: TColor;
    function GetThemedHeaderItemTextColor: TColor;
    function GetThemedHeaderRowColor: TColor;
    function GetTreeLinesColor: TColor;
    function GetTreeLinesStyle: TcxTreeListTreeLineStyle;
    function GetTreeListControl: TcxCustomTreeListControl;
    function GetUseStylesForIndents: Boolean;
    function GetViewWidth: Integer;
  protected
    procedure AfterBuilding; virtual;
    procedure BeforeBuilding; virtual;
    
    procedure AfterCalculate; virtual;
    procedure BeforeCalculate; virtual;
    procedure Calculate(AAvailableWidth: Integer; AnAutoWidth: Boolean); virtual;
    procedure CalculateBandPlaces; virtual;
    procedure CalculateBandWidths; virtual;
    procedure CalculateColumnPlaces; virtual;
    procedure CalculateColumnWidths; virtual;
    procedure CalculateLineCounts; virtual;
    procedure DoCalculate; virtual;
    { properties }
    class function GetProperties(AColumn: TcxTreeListColumn; ANode: TcxTreeListNode): TcxCustomEditProperties;
    class function GetPropertiesClass(AColumn: TcxTreeListColumn; ANode: TcxTreeListNode): TcxCustomEditPropertiesClass;
    class function GetRepositoryItem(AColumn: TcxTreeListColumn; ANode: TcxTreeListNode): TcxEditRepositoryItem;
    { styles }
    function GetBackgroundViewParams: TcxViewParams; virtual;
    function GetBandBackgroundViewParams: TcxViewParams; virtual;    
    function GetBandHeaderViewParams(ABand: TcxTreeListBand): TcxViewParams; virtual;    
    function GetColumnFooterViewParams(AColumn: TcxTreeListColumn): TcxViewParams; virtual;
    function GetColumnHeaderViewParams(AColumn: TcxTreeListColumn): TcxViewParams; virtual;
    function GetContentViewParams(ANode: TcxTreeListNode; AColumn: TcxTreeListColumn): TcxViewParams; virtual;
    function GetIndentViewParams(ANode: TcxTreeListNode; AnIndent: Integer): TcxViewParams; virtual;
    function GetPreviewViewParams(ANode: TcxTreeListNode; AColumn: TcxTreeListColumn): TcxViewParams; virtual;
    function GetFooterRowViewParams: TcxViewParams; virtual;
    function GetSelectionViewParams: TcxViewParams; virtual;
    function HasSelectionStyle: Boolean;
    { Backgrounds }
    function GetBackgroundBitmap(Index: Integer): TBitmap;
    function HasBackgroundBitmap(Index: Integer): Boolean;

    function GetImagesHeight(ANode: TcxTreeListNode): Integer;
    function GetImagesWidth(ANode: TcxTreeListNode): Integer;
    function GetStateImagesHeight(ANode: TcxTreeListNode): Integer;
    function GetStateImagesWidth(ANode: TcxTreeListNode): Integer;
    function HasImages(ANode: TcxTreeListNode): Boolean;
    function HasStateImages(ANode: TcxTreeListNode): Boolean;
    function IsGroupNode(ANode: TcxTreeListNode): Boolean;
    
    property AutoWidth: Boolean read FAutoWidth write FAutoWidth;
    property Helpers[Node: TcxTreeListNode]: TcxTreeListNodeHelper read GetHelper;
    property LookAndFeelKind: TcxLookAndFeelKind read GetLookAndFeelKind;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
    property OptionsView: TcxTreeListOptionsView read GetOptionsView;
    property Styles: TcxTreeListStyles read GetStyles;
    property TreeListControl: TcxCustomTreeListControl read GetTreeListControl;
    property ViewWidth: Integer read GetViewWidth;
  public
    constructor Create(ABuilder: TcxTreeListControlReportLinkBuilder); override;
    destructor Destroy; override;
    
    property AvailableWidth: Integer read FAvailableWidth write FAvailableWidth;
    property BandCount: Integer read GetBandCount;
    property BandLineCount: Integer read FBandLineCount write FBandLineCount;
    property BandOrigins[Index: Integer]: Integer read GetBandOrigin;
    property BandPlaces[Index: Integer]: TRect read GetBandPlace;
    property Bands[Index: Integer]: TcxTreeListBand read GetBand;
    property BandWidths[Index: Integer]: Integer read GetBandWidth;
    property CanUseLookAndFeelColors: Boolean read GetCanUseLookAndFeelColors;
    property CategorizedColumn: TcxTreeListColumn read GetCategorizedColumn;
    property CellAutoHeight: Boolean read GetCellAutoHeight;
    property CellEndEllipsis: Boolean read GetCellEndEllipsis;
    property CellMultiline: Boolean read GetCellMultiline;
    property ColumnCount: Integer read GetColumnCount;
    property ColumnPlaces[Index: Integer]: TdxTLColumnPlace read GetColumnPlace;
    property Columns[Index: Integer]: TcxTreeListColumn read GetColumn;
    property ColumnWidths[Index: Integer]: Integer read GetColumnWidth;
    property DefaultRowHeight: Integer read GetDefaultRowHeight;
    property DetailsLineCount: Integer read FDetailsLineCount write FDetailsLineCount;
    property FooterItemTexts[Index: Integer]: string read GetFooterItemText;
    property FooterLineCount: Integer read FFooterLineCount write FFooterLineCount;
    property GridLines: TcxTreeListGridLines read GetGridLines;
    property GridLinesColor: TColor read GetGridLinesColor;
    property HasFooterItem[Index: Integer]: Boolean read GetHasFooterItem;
    property HasPreview: Boolean read GetHasPreview;
    property HeaderAutoHeight: Boolean read GetHeaderAutoHeight;
    property Images: TCustomImageList read GetImages;
    property IndentWidth: Integer read GetIndentWidth;
    property IsDefaultRowHeightAssigned: Boolean read GetIsDefaultRowHeightAssigned;
    property IsNodeColorUsedForIndents: Boolean read GetIsNodeColorUsedForIndents;
    property MultiSelection: Boolean read GetMultiSelection;
    property PaintStyle: TcxTreeListPaintStyle read GetPaintStyle;
    property PreviewColumn: TcxTreeListColumn read GetPreviewColumn;
    property PreviewLeftIndent: Integer read GetPreviewLeftIndent;
    property PreviewPlace: TcxTreeListPreviewPlace read GetPreviewPlace;
    property PreviewRightIndent: Integer read GetPreviewRightIndent;
    property NodeCount: Integer read GetNodeCount;
    property Nodes[Index: Integer]: TcxTreeListNode read GetNode;
    property ShowRoot: Boolean read GetShowRoot;
    property ShowHorzGridLines: Boolean read GetShowHorzGridLines;
    property ShowTreeLines: Boolean read GetShowTreeLines;
    property ShowVertGridLines: Boolean read GetShowVertGridLines;    
    property StateImages: TCustomImageList read GetStateImages;
    property ThemedBandHeaderItemColor: TColor read GetThemedBandHeaderItemColor;
    property ThemedBandHeaderItemTextColor: TColor read GetThemedBandHeaderItemTextColor;
    property ThemedFooterItemColor: TColor read GetThemedFooterItemColor;
    property ThemedFooterItemTextColor: TColor read GetThemedFooterItemTextColor;
    property ThemedHeaderItemColor: TColor read GetThemedHeaderItemColor;
    property ThemedHeaderItemTextColor: TColor read GetThemedHeaderItemTextColor;
    property ThemedHeaderRowColor: TColor read GetThemedHeaderRowColor;
    property TreeLinesColor: TColor read GetTreeLinesColor;
    property TreeLinesStyle: TcxTreeListTreeLineStyle read GetTreeLinesStyle;
    property UseStylesForIndents: Boolean read GetUseStylesForIndents;
  end;
  
  TcxTreeListControlReportLinkFormatter = class(TcxTreeListReportLinkBuilderHandler, 
    IUnknown, IdxPSCellParams, IdxPSCellParams2)
  private
    FBandLineHeight: Integer;
    FDetailsLineHeight: Integer;    
    FFont: TFont;
    FFooterLineHeight: Integer;
    FHeaderLineHeight: Integer;
    FLookAndFeelItems: TList;
    FNodes: TList;
    FPreviewLineHeight: Integer;
    FTransparentColor: TColor;
    function GetAutoWidth: Boolean;
    function GetDC: HDC;
    function GetExpandButtonColor: TColor;
    function GetExpandButtonSize: Integer;
    function GetGridLinesColor: TColor;
    function GetHasNodeSeparator: Boolean;
    function GetHasPreview: Boolean;
    function GetIndentCount(Node: TcxTreeListNode): Integer;
    function GetIsNodeColorUsedForIndents: Boolean;
    function GetLookAndFeelItem(Index: Integer): TdxReportVisualItem;
    function GetLookAndFeelItemCount: Integer;
    function GetNode(Index: Integer): TcxTreeListNode;
    function GetNodeCount: Integer;
    function GetNodeSeparatorColor: TColor;
    function GetNodeSeparatorThickness: Integer;
    function GetPreviewAutoHeight: Boolean;
    function GetPreviewColumn: TcxTreeListColumn;
    function GetPreviewMaxLineCount: Integer;
    function GetRenderer: TdxPSReportRenderer;
    function GetShowBandHeaders: Boolean;
    function GetShowFooters: Boolean;
    function GetShowHeaders: Boolean;
    function GetShowPreview: Boolean;
    function GetUseLookAndFeelColors: Boolean;
    function GetViewWidth: Integer;
    function GetTreeLinesColor: TColor;
    function GetTreeLinesStyle: TcxTreeListTreeLineStyle;

    procedure FormatLookAndFeelItems;
  protected
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IdxPSCellParams }
    function IdxPSCellParams.GetAutoHeight = IdxPSCellParams_GetAutoHeight;
    function IdxPSCellParams.GetDC = IdxPSCellParams_GetDC;
    function IdxPSCellParams.GetDisplayGraphicsAsText = IdxPSCellParams_GetDisplayGraphicsAsText;
    function IdxPSCellParams.GetEndEllipsis = IdxPSCellParams_GetEndEllipsis;
    function IdxPSCellParams.GetFlatCheckMarks = IdxPSCellParams_GetFlatCheckMarks;
    function IdxPSCellParams.GetGraphicsText = IdxPSCellParams_GetGraphicsText;
    function IdxPSCellParams.GetMultiline = IdxPSCellParams_GetMultiline;
    function IdxPSCellParams.GetTransparentGraphics = IdxPSCellParams_GetTransparentGraphics;
    function IdxPSCellParams_GetAutoHeight: Boolean; virtual;
    function IdxPSCellParams_GetDC: HDC; virtual;
    function IdxPSCellParams_GetDisplayGraphicsAsText: Boolean; virtual;
    function IdxPSCellParams_GetEndEllipsis: Boolean; virtual;
    function IdxPSCellParams_GetFlatCheckMarks: Boolean; virtual;
    function IdxPSCellParams_GetGraphicsText: string; virtual;
    function IdxPSCellParams_GetMultiline: Boolean; virtual;
    function IdxPSCellParams_GetTransparentGraphics: Boolean; virtual;
    { IdxPSCellParams2 }
    function IdxPSCellParams2.GetPreviewMarginLeft = IdxPSCellParams2_GetPreviewMarginLeft;
    function IdxPSCellParams2.GetPreviewMarginRight = IdxPSCellParams2_GetPreviewMarginRight;
    function IdxPSCellParams2.GetPreviewMaxHeight = IdxPSCellParams2_GetPreviewMaxHeight;
    function IdxPSCellParams2.GetPreviewMaxLineCount = IdxPSCellParams2_GetPreviewMaxLineCount;
    function IdxPSCellParams2.GetRichEditGraphicClass = IdxPSCellParams2_GetRichEditGraphicClass;
    function IdxPSCellParams2.GetRichEditTransparent = IdxPSCellParams2_GetRichEditTransparent;
    function IdxPSCellParams2_GetPreviewMarginLeft: Integer; virtual;
    function IdxPSCellParams2_GetPreviewMarginRight: Integer; virtual;
    function IdxPSCellParams2_GetPreviewMaxHeight: Integer; virtual;
    function IdxPSCellParams2_GetPreviewMaxLineCount: Integer; virtual;
    function IdxPSCellParams2_GetRichEditGraphicClass: TGraphicClass; virtual;
    function IdxPSCellParams2_GetRichEditTransparent: Boolean; virtual;

    procedure AddDelimiters; virtual;
    procedure AddHorizontalDelimiters; virtual;
    procedure AddVerticalDelimiters; virtual;
    procedure AfterBuilding; virtual;
    procedure BeforeBuilding; virtual;
    procedure CalculateLineHeights; virtual;
    function CanProcessSelectionStyle(ANode: TcxTreeListNode): Boolean;
    procedure CreateNodeList; virtual;
    function IsSelectedNode(ANode: TcxTreeListNode): Boolean; virtual;

    function GetBackgroundBitmap(Index: Integer): TBitmap;
    function GetBackgroundBitmapIndex(Index: Integer): Integer;
    function HasBackgroundBitmap(Index: Integer): Boolean;
    function MapStyleBackgroundBitmapIndex(ATreeListBackgroundBitmapIndex: Integer): Integer;

    procedure CalculateHeight(const AParams: TdxReportItemViewParams; var AHeight: Integer);
    function CalculatePatternHeight(const AParams: TdxReportItemViewParams): Integer;
    function GetNodeParent(ANode: TcxTreeListNode; ALevel: Integer): TcxTreeListNode;
    function GetNextNode(ANode: TcxTreeListNode): TcxTreeListNode;
    function GetPrevNode(ANode: TcxTreeListNode): TcxTreeListNode;
    function GetStyleFontIndex(const AParams: TdxReportItemViewParams): Integer;
    function HasParent(ANode: TcxTreeListNode): Boolean;
    function IndexOfNode(ANode: TcxTreeListNode): Integer;
    function IsColorTransparent(AColor: TColor): Boolean;
    function IsFirstNode(ANode: TcxTreeListNode): Boolean; 
    function IsLastNode(ANode: TcxTreeListNode): Boolean; 
    function IsNodeExpanded(ANode: TcxTreeListNode): Boolean;
    function IsNodeFirstChild(ANode: TcxTreeListNode): Boolean;
    function IsNodeLastChild(ANode: TcxTreeListNode): Boolean;
    function IsOddNode(ANode: TcxTreeListNode): Boolean;
    function IsNodeSelected(ANode: TcxTreeListNode): Boolean;
    procedure RegisterLookAndFeelItem(AnItem: TdxReportVisualItem; AEdgeStyle: TdxCellEdgeStyle);
    procedure SetViewParams(AnItem: TdxReportVisualItem; const AParams: TdxReportItemViewParams);

    function MakeIndentIndex(AnIndex: Integer): DWORD;
    
    property DC: HDC read GetDC;
    property LookAndFeelItemCount: Integer read GetLookAndFeelItemCount;
    property LookAndFeelItems[Index: Integer]: TdxReportVisualItem read GetLookAndFeelItem;
    property Renderer: TdxPSReportRenderer read GetRenderer;
    property ViewWidth: Integer read GetViewWidth;
  public
    constructor Create(ABuilder: TcxTreeListControlReportLinkBuilder); override;
    destructor Destroy; override;

    function Adapter: TcxTreeListControlAdapter; overload; virtual;

    procedure DoInitializeHost(AHost: TdxReportCell); virtual;
    { Bands }
    procedure DoInitializeBandItem(AnItem: TAbstractdxReportCellData; AnIndex: Integer); virtual;
    procedure DoInitializeBandRow(ARow: TdxReportCell); virtual;
    procedure DoReportLinkInitializeBandItem(AnItem: TAbstractdxReportCellData; AIndex: Integer); virtual;
    function GetBandBackgroundViewParams: TdxReportItemViewParams; virtual;
    function GetBandItemClass(Index: Integer): TdxReportCellTextClass; virtual;
    function GetBandItemBounds(Index: Integer): TRect;    
    function GetBandItemViewParams(ABand: TcxTreeListBand): TdxReportItemViewParams; virtual;
    { Footers }
    procedure DoInitializeFooterItem(AnItem: TAbstractdxReportCellData; AnIndex: Integer); virtual;
    procedure DoInitializeFooterRow(ARow: TdxReportCell); virtual;
    procedure DoReportLinkInitializeFooterItem(AnItem: TAbstractdxReportCellData; AIndex: Integer); virtual;
    function GetFooterItemBounds(Index: Integer): TRect; virtual;
    function GetFooterItemClass(AnIndex: Integer): TdxReportCellTextClass; virtual;
    function GetFooterItemViewParams(AColumn: TcxTreeListColumn): TdxReportItemViewParams; virtual;
    function GetFooterRowViewParams: TdxReportItemViewParams; virtual;
    { Headers }
    procedure DoInitializeHeaderItem(AnItem: TAbstractdxReportCellData; AnIndex: Integer); virtual;   
    procedure DoInitializeHeaderRow(ARow: TdxReportCell); virtual;
    procedure DoReportLinkInitializeHeaderItem(AnItem: TAbstractdxReportCellData; AIndex: Integer); virtual;
    function GetHeaderItemBounds(Index: Integer): TRect; virtual;
    function GetHeaderItemClass(AnIndex: Integer): TdxReportCellTextClass; virtual;
    function GetHeaderItemViewParams(AColumn: TcxTreeListColumn): TdxReportItemViewParams; virtual;    
    { Images }
    procedure DoInitializeNodeImage(AnItem: TdxReportCellGraphic; ANode: TcxTreeListNode; AnIndex: Integer); virtual;
    procedure DoReportLinkInitializeNodeImage(AnItem: TAbstractdxReportCellData; ANode: TcxTreeListNode; AnIndex: Integer); virtual;
    function GetNodeImageCellSides(ANode: TcxTreeListNode; AnIndex: Integer): TdxCellSides;
    function GetNodeImageClass: TdxReportCellGraphicClass; virtual;
    function GetNodeImageViewParams(ANode: TcxTreeListNode; AnIndex: Integer): TdxReportItemViewParams; virtual;
    { Indents and Expand Buttons }
    procedure DoInitializeNodeIndent(AnItem: TdxReportCellExpandButton; AnIndex, AnIndentCount: Integer; ANode: TcxTreeListNode); virtual;
    procedure DoInitializeExpandButton(AnItem: TdxReportCellExpandButton; AnIndex, AnIndentCount: Integer; ANode: TcxTreeListNode); virtual;
    procedure DoReportLinkInitializeNodeIndent(AnItem: TAbstractdxReportCellData; AnIndex, AnIndentCount: Integer; ANode: TcxTreeListNode); virtual;
    function GetNodeIndentCellSides(ANode: TcxTreeListNode; AnIndex, AnIndentCount: Integer): TdxCellSides; virtual;
    function GetNodeIndentClass: TdxReportCellExpandButtonClass; virtual;
    function GetNodeIndentTreeLineMode(AnIndex, AnIndentCount: Integer; ANode: TcxTreeListNode): TdxPSTreeLineMode;
    function GetNodeIndentViewParams(ANode: TcxTreeListNode; AnIndex, AnIndentCount: Integer): TdxReportItemViewParams; virtual;
    { Nodes }
    procedure DoInitializeNodeRow(ARow: TdxReportCell; ANode: TcxTreeListNode); virtual;
    procedure DoInitializeNodeItem(AnItem: TAbstractdxReportCellData; 
      AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; AnIsPreview: Boolean = False); virtual;
    procedure DoReportLinkInitializeNodeItem(AnItem: TAbstractdxReportCellData; 
      AColumn: TcxTreeListColumn; ANode: TcxTreeListNode); virtual;
    function GetCellValue(AProperties: TcxCustomEditProperties; 
      AColumn: TcxTreeListColumn; ANode: TcxTreeListNode): TcxEditValue; virtual;  
    function GetNodeBackgroundBitmapStyleIndex(ANode: TcxTreeListNode): Integer;
    function GetNodeItemBounds(ANode: TcxTreeListNode; Index, IndentCount: Integer): TRect; virtual;
    function GetNodeItemCellSides(AColumn: TcxTreeListColumn; ANode: TcxTreeListNode): TdxCellSides;
    function GetNodeItemClass(AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; 
      AnIsPreview: Boolean = False): TdxReportCellDataClass; virtual;
    function GetNodeItemViewParams(AColumn: TcxTreeListColumn; ANode: TcxTreeListNode): TdxReportItemViewParams; virtual;
    { Preview }
    procedure DoInitializePreview(AnItem: TAbstractdxReportCellData; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode); virtual;
    function GetPreviewCellSides(ANode: TcxTreeListNode): TdxCellSides; virtual;
    function GetPreviewClass(AColumn: TcxTreeListColumn; ANode: TcxTreeListNode): TdxReportCellDataClass; virtual;
    function GetPreviewViewParams(AColumn: TcxTreeListColumn; ANode: TcxTreeListNode): TdxReportItemViewParams; virtual;
    { Separators }
    procedure DoInitializeNodeSeparator(AnItem: TdxReportCellBox); virtual;
    procedure DoInitializeNodeSeparatorRow(ARow: TdxReportCell); virtual;
    function GetNodeSeparatorClass: TdxReportCellBoxClass; virtual;
    { State images }
    procedure DoInitializeNodeStateImage(AnItem: TdxReportCellGraphic; ANode: TcxTreeListNode; AnIndex: Integer); virtual;
    procedure DoReportLinkInitializeNodeStateImage(AnItem: TAbstractdxReportCellData; ANode: TcxTreeListNode; AnIndex: Integer); virtual;
    function GetNodeStateImageCellSides(ANode: TcxTreeListNode; AnIndex: Integer): TdxCellSides; virtual;
    function GetNodeStateImageClass: TdxReportCellGraphicClass; virtual;
    function GetNodeStateImageViewParams(ANode: TcxTreeListNode; AnIndex: Integer): TdxReportItemViewParams; virtual;
    
    property AutoWidth: Boolean read GetAutoWidth;
    property BandLineHeight: Integer read FBandLineHeight write FBandLineHeight;
    property DetailsLineHeight: Integer read FDetailsLineHeight write FDetailsLineHeight;
    property ExpandButtonColor: TColor read GetExpandButtonColor;
    property ExpandButtonSize: Integer read GetExpandButtonSize;
    property FooterLineHeight: Integer read FFooterLineHeight write FFooterLineHeight;
    property GridLinesColor: TColor read GetGridLinesColor;
    property HasNodeSeparator: Boolean read GetHasNodeSeparator;
    property HasPreview: Boolean read GetHasPreview;
    property HeaderLineHeight: Integer read FHeaderLineHeight write FHeaderLineHeight;
    property IndentCounts[Node: TcxTreeListNode]: Integer read GetIndentCount;
    property IsNodeColorUsedForIndents: Boolean read GetIsNodeColorUsedForIndents;
    property NodeCount: Integer read GetNodeCount;
    property Nodes[Index: Integer]: TcxTreeListNode read GetNode;
    property NodeSeparatorColor: TColor read GetNodeSeparatorColor;
    property NodeSeparatorThickness: Integer read GetNodeSeparatorThickness;
    property PreviewAutoHeight: Boolean read GetPreviewAutoHeight;
    property PreviewColumn: TcxTreeListColumn read GetPreviewColumn;
    property PreviewLineHeight: Integer read FPreviewLineHeight write FPreviewLineHeight;
    property PreviewMaxLineCount: Integer read GetPreviewMaxLineCount;
    property ShowBandHeaders: Boolean read GetShowBandHeaders;
    property ShowFooters: Boolean read GetShowFooters;
    property ShowHeaders: Boolean read GetShowHeaders;
    property ShowPreview: Boolean read GetShowPreview;
    property UseLookAndFeelColors: Boolean read GetUseLookAndFeelColors;
    property TransparentColor: TColor read FTransparentColor write FTransparentColor default clWindow;
    property TreeLinesColor: TColor read GetTreeLinesColor;
    property TreeLinesStyle: TcxTreeListTreeLineStyle read GetTreeLinesStyle;
  end;
  
  { Options }

  TcxTreeListReportLinkOptionsExpanding = class(TdxCustomReportLinkOptionsExpanding) 
  private
    FAutoExpandNodes: Boolean;
    FExplicitlyExpandNodes: Boolean;
    function GetReportLink: TcxTreeListControlReportLink;
    procedure SetAutoExpandNodes(Value: Boolean); 
    procedure SetExplicitlyExpandNodes(Value: Boolean);
  protected
    function DesignerTabIndex: Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
    property ReportLink: TcxTreeListControlReportLink read GetReportLink;
  published  
    property AutoExpandNodes: Boolean read FAutoExpandNodes write SetAutoExpandNodes default False;
    property ExplicitlyExpandNodes: Boolean read FExplicitlyExpandNodes write SetExplicitlyExpandNodes default False;
  end;

  TcxTreeListReportLinkOptionsFormatting = class(TdxCustomReportLinkOptionsFormatting)
  private
    FConsumeSelectionStyle: Boolean;
    FNodeSeparatorColor: TColor;
    FNodeSeparatorThickness: Integer;
    function GetActualNodeSeparatorColor: TColor;
    function GetReportLink: TcxTreeListControlReportLink;
    procedure SetConsumeSelectionStyle(Value: Boolean);
    procedure SetNodeSeparatorColor(Value: TColor);
    procedure SetNodeSeparatorThickness(Value: Integer);
  protected
    function DesignerTabIndex: Integer; override;
  public    
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
    
    property ActualNodeSeparatorColor: TColor read GetActualNodeSeparatorColor;
    property ReportLink: TcxTreeListControlReportLink read GetReportLink;
  published
    property ConsumeSelectionStyle: Boolean read FConsumeSelectionStyle write SetConsumeSelectionStyle default False;
    property NodeSeparatorColor: TColor read FNodeSeparatorColor write SetNodeSeparatorColor default clDefault;
    property NodeSeparatorThickness: Integer read FNodeSeparatorThickness write SetNodeSeparatorThickness default 0;
    property UseLookAndFeelColors;
  end;

  TcxTreeListReportLinkOptionsOnEveryPage = class(TdxCustomTableControlReportLinkOptionsOnEveryPage)
  private
    function GetReportLink: TcxTreeListControlReportLink;
  protected
    function DesignerTabIndex: Integer; override;
  public
    property ReportLink: TcxTreeListControlReportLink read GetReportLink;
  published  
    property BandHeaders;
    property Footers;
    property Headers;
  end;

  TcxTreeListReportLinkOptionsPagination = class(TdxCustomTableControlReportLinkOptionsPagination)
  private
    function GetNode: Boolean;
    function GetReportLink: TcxTreeListControlReportLink;
    procedure SetNode(Value: Boolean);
  protected
    function DesignerTabIndex: Integer; override;
  public
    property ReportLink: TcxTreeListControlReportLink read GetReportLink;
  published  
    property Band;
    property Column;
    property Custom;
    property Node: Boolean read GetNode write SetNode default True;
  end;

  TcxTreeListReportLinkOptionsPreview = class(TdxCustomTableControlReportLinkOptionsPreview)
  private
    function GetReportLink: TcxTreeListControlReportLink;
  protected
    function DesignerTabIndex: Integer; override;
  public  
    property ReportLink: TcxTreeListControlReportLink read GetReportLink;
  end;

  TcxTreeListReportLinkOptionsRefinements = class(TdxCustomReportLinkOptionsRefinements)  
  private
    function GetReportLink: TcxTreeListControlReportLink;
  protected
    function DesignerTabIndex: Integer; override;
  public
    property ReportLink: TcxTreeListControlReportLink read GetReportLink;
  end;

  TcxTreeListReportLinkOptionsSelection = class(TdxCustomTableControlReportLinkOptionsSelection)
  private
    function GetReportLink: TcxTreeListControlReportLink;
  protected
    function DesignerTabIndex: Integer; override;
  public  
    property ReportLink: TcxTreeListControlReportLink read GetReportLink;
  end;

  TcxTreeListReportLinkOptionsSize = class(TdxCustomReportLinkOptionsSize)
  private
    function GetReportLink: TcxTreeListControlReportLink;
  protected
    function DesignerTabIndex: Integer; override;
  public  
    property ReportLink: TcxTreeListControlReportLink read GetReportLink;
  published
    property AutoWidth;
  end;
  
  TcxTreeListReportLinkOptionsView = class(TdxCustomTableControlReportLinkOptionsView)
  private
    FBorders: Boolean;
    FTreeLines: Boolean;
    function GetReportLink: TcxTreeListControlReportLink;
    procedure SetBorders(Value: Boolean);
    procedure SetTreeLines(Value: Boolean);
  protected
    function DesignerTabIndex: Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
    property ReportLink: TcxTreeListControlReportLink read GetReportLink;
  published
    property BandHeaders;
    property Borders: Boolean read FBorders write SetBorders default True;
    property ExpandButtons;
    property Footers;
    property Headers;
    property TreeLines: Boolean read FTreeLines write SetTreeLines default True;
  end;
  
  { TcxTreeListReportLinkStyles }
  
  TcxTreeListReportLinkStylesClass = class of TcxTreeListReportLinkStyles;
  
  TcxTreeListReportLinkStyles = class(TdxCustomReportLinkStyles)
  private
    FOnGetNodeIndentStyle: TcxtlOnGetNodeIndentStyleEvent;
    function GetReportLink: TcxTreeListControlReportLink;
  protected
    function DesignerTabIndex: Integer; override;

    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    class function GetStyleCaption(AnIndex: Integer): string; override;
    function GetStyleIndexByCaption(const Caption: string): Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
    
    procedure GetBandHeaderParams(ABand: TcxTreeListBand; out AParams: TcxViewParams); virtual;
    procedure GetColumnFooterParams(ANode: TcxTreeListNode; AColumn: TcxTreeListColumn;
      out AParams: TcxViewParams); virtual;
    procedure GetColumnHeaderParams(AColumn: TcxTreeListColumn; out AParams: TcxViewParams); virtual;
    procedure GetContentParams(ANode: TcxTreeListNode; AColumn: TcxTreeListColumn;
      out AParams: TcxViewParams); virtual;
    procedure GetFooterRowParams(out AParams: TcxViewParams); virtual;
    procedure GetImagesParams(ANode: TcxTreeListNode; out AParams: TcxViewParams); virtual;
    procedure GetIndentParams(ANode: TcxTreeListNode; AnIndent: Integer; out AParams: TcxViewParams); virtual;
    procedure GetPreviewParams(ANode: TcxTreeListNode; AColumn: TcxTreeListColumn;
      out AParams: TcxViewParams); virtual;
    procedure GetSelectionParams(out AParams: TcxViewParams); virtual;  

    property ReportLink: TcxTreeListControlReportLink read GetReportLink;
  published
    property BandHeader: TcxStyle Index vspsTreeListBandHeader read GetValue write SetValue;
    property Content: TcxStyle Index vspsTreeListContent read GetValue write SetValue;
    property ContentEven: TcxStyle Index vspsTreeListContentEven read GetValue write SetValue;
    property ContentOdd: TcxStyle Index vspsTreeListContentOdd read GetValue write SetValue;
    property Footer: TcxStyle Index vspsTreeListFooter read GetValue write SetValue;
    property FooterRow: TcxStyle Index vspsTreeListFooterRow read GetValue write SetValue;
    property Header: TcxStyle Index vspsTreeListHeader read GetValue write SetValue;
    property Preview: TcxStyle Index vspsTreeListPreview read GetValue write SetValue;
    property Selection: TcxStyle Index vspsTreeListSelection read GetValue write SetValue;
    property StyleSheet;
    property OnGetNodeIndentStyle: TcxtlOnGetNodeIndentStyleEvent read FOnGetNodeIndentStyle write FOnGetNodeIndentStyle;
  end;
  
  TcxTreeListReportLinkStyleSheet = class(TdxCustomReportLinkStyleSheet) 
  private
    function GetStylesValue: TcxTreeListReportLinkStyles;
    procedure SetStylesValue(Value: TcxTreeListReportLinkStyles);
  public
    class function GetStylesClass: TcxCustomStylesClass; override;
  published  
    property Styles: TcxTreeListReportLinkStyles read GetStylesValue write SetStylesValue; 
  end;

  { Host Services }
  
  TcxTreeListControlAttributeHostInfo = class
  private
    FParent: TdxReportCell;
  public
    Origin: TPoint;  
    procedure Initialize(AParent: TdxReportCell);    
    property Parent: TdxReportCell read FParent;
  end;

  TcxTreeListAttributeHostInfoServicesClass = class of TcxTreeListAttributeHostInfoServices;
  
  TcxTreeListAttributeHostInfoServices = class
  private
    FPageDetailsHostInfo: TcxTreeListControlAttributeHostInfo;
    FPageFootersHostInfo: TcxTreeListControlAttributeHostInfo;
    FPageHeadersHostInfo: TcxTreeListControlAttributeHostInfo;
    FReportLink: TcxTreeListControlReportLink;
    function GetArePageFootersAssigned: Boolean;
    function GetArePageHeadersAssigned: Boolean;
    function GetCanUseBandHeadersOnEveyPage: Boolean;
    function GetCanUseFootersOnEveryPage: Boolean;
    function GetCanUseHeadersOnEveryPage: Boolean;
    function GetIsInconsistentHeadersState: Boolean;
    function GetOptionsOnEveryPage: TcxTreeListReportLinkOptionsOnEveryPage;
    function GetOptionsView: TcxTreeListReportLinkOptionsView;
    function GetPageDetails: TdxReportCell;
    function GetPageFooters: TdxReportCell;
    function GetPageHeaders: TdxReportCell;
  protected  
    procedure CreateHostInfos;
    procedure DestroyHostInfos;
   
    function GetBandHeadersHostInfo: TcxTreeListControlAttributeHostInfo; virtual;
    function GetFootersHostInfo: TcxTreeListControlAttributeHostInfo; virtual;
    function GetHeadersHostInfo: TcxTreeListControlAttributeHostInfo; virtual;
    function GetInconsistentStateText: string; virtual;
    function GetIsInconsistentState: Boolean; virtual;
    function HasCells: Boolean;

    property OptionsOnEveryPage: TcxTreeListReportLinkOptionsOnEveryPage read GetOptionsOnEveryPage;
    property OptionsView: TcxTreeListReportLinkOptionsView read GetOptionsView;
    property PageDetails: TdxReportCell read GetPageDetails;
    property PageFooters: TdxReportCell read GetPageFooters;
    property PageHeaders: TdxReportCell read GetPageHeaders;
  public
    constructor Create(AReportLink: TcxTreeListControlReportLink); virtual;
    destructor Destroy; override;
    procedure InitializeHostInfos;
    
    property ArePageFootersAssigned: Boolean read GetArePageFootersAssigned;
    property ArePageHeadersAssigned: Boolean read GetArePageHeadersAssigned;
    property BandHeadersHostInfo: TcxTreeListControlAttributeHostInfo read GetBandHeadersHostInfo;
    property CanUseBandHeadersOnEveyPage: Boolean read GetCanUseBandHeadersOnEveyPage;
    property CanUseFootersOnEveryPage: Boolean read GetCanUseFootersOnEveryPage;
    property CanUseHeadersOnEveryPage: Boolean read GetCanUseHeadersOnEveryPage;
    property FootersHostInfo: TcxTreeListControlAttributeHostInfo read GetFootersHostInfo;
    property HeadersHostInfo: TcxTreeListControlAttributeHostInfo read GetHeadersHostInfo;
    property InconsistentStateText: string read GetInconsistentStateText;
    property IsInconsistentHeadersState: Boolean read GetIsInconsistentHeadersState;
    property IsInconsistentState: Boolean read GetIsInconsistentState;
    property PageDetailsHostInfo: TcxTreeListControlAttributeHostInfo read FPageDetailsHostInfo;
    property PageFootersHostInfo: TcxTreeListControlAttributeHostInfo read FPageFootersHostInfo;
    property PageHeadersHostInfo: TcxTreeListControlAttributeHostInfo read FPageHeadersHostInfo;
    property ReportLink: TcxTreeListControlReportLink read FReportLink;
  end;

  { TcxTreeListControlReportLink }
  
  TcxTreeListNodeArray = array of TcxTreeListNode;

  TcxTreeListReportLinkGetCustomPageBreaksEvent = procedure(Sender: TcxTreeListControlReportLink) of object;

  TcxTreeListReportLinkCustomDrawBandCellEvent = procedure(Sender: TcxTreeListControlReportLink;
    ACanvas: TCanvas; ABand: TcxTreeListBand; AnItem: TdxReportCellImage; 
    var ADone: Boolean) of object;
    
  TcxTreeListReportLinkCustomDrawCellEvent = procedure(Sender: TcxTreeListControlReportLink;
    ACanvas: TCanvas; ANode: TcxTreeListNode; AColumn: TcxTreeListColumn;
    AnItem: TAbstractdxReportCellData; var ADone: Boolean) of object;
    
  TcxTreeListReportLinkCustomDrawFooterCellEvent = procedure(Sender: TcxTreeListControlReportLink;
    ACanvas: TCanvas; AColumn: TcxTreeListColumn; AnItem: TdxReportCellString; var ADone: Boolean) of object;
    
  TcxTreeListReportLinkCustomDrawHeaderCellEvent = procedure(Sender: TcxTreeListControlReportLink;
    ACanvas: TCanvas; AColumn: TcxTreeListColumn; AnItem: TdxReportCellImage; var ADone: Boolean) of object;

  TcxTreeListReportLinkCustomDrawIndentCellEvent = procedure(Sender: TcxTreeListControlReportLink;
    ACanvas: TCanvas; ANode: TcxTreeListNode; AnIndex: Integer; AnItem: TAbstractdxReportCellData;
    var ADone: Boolean) of object;
    
  TcxTreeListReportLinkInitializeBandCellEvent = procedure(Sender: TcxTreeListControlReportLink;
    ABand: TcxTreeListBand; AnItem: TdxReportCellImage) of object;
    
  TcxTreeListReportLinkInitializeCellEvent = procedure(Sender: TcxTreeListControlReportLink;
    ANode: TcxTreeListNode; AColumn: TcxTreeListColumn; AnItem: TAbstractdxReportCellData) of object;

  TcxTreeListReportLinkInitializeFooterCellEvent = procedure(Sender: TcxTreeListControlReportLink;
    AColumn: TcxTreeListColumn; AnItem: TdxReportCellString) of object;
    
  TcxTreeListReportLinkInitializeHeaderCellEvent = procedure(Sender: TcxTreeListControlReportLink;
    AColumn: TcxTreeListColumn; AnItem: TdxReportCellImage) of object;

  TcxTreeListReportLinkInitializeIndentCellEvent = procedure(Sender: TcxTreeListControlReportLink;
    ANode: TcxTreeListNode; AnIndex: Integer; AnItem: TAbstractdxReportCellData) of object;
    
  TcxTreeListControlReportLink = class(TdxCustomTableControlReportLink)
  private
    FBuilder: TcxTreeListControlReportLinkBuilder;
    FDelimitersHardVert: TList;
    FHostInfoServices: TcxTreeListAttributeHostInfoServices;
    FReportRows: TList;
    FOnCustomDrawBandCell: TcxTreeListReportLinkCustomDrawBandCellEvent;
    FOnCustomDrawCell: TcxTreeListReportLinkCustomDrawCellEvent;
    FOnCustomDrawFooterCell: TcxTreeListReportLinkCustomDrawFooterCellEvent;
    FOnCustomDrawHeaderCell: TcxTreeListReportLinkCustomDrawHeaderCellEvent;
    FOnCustomDrawIndentCell: TcxTreeListReportLinkCustomDrawIndentCellEvent;
    FOnGetCustomPageBreaks: TcxTreeListReportLinkGetCustomPageBreaksEvent;
    FOnInitializeBandCell: TcxTreeListReportLinkInitializeBandCellEvent;
    FOnInitializeCell: TcxTreeListReportLinkInitializeCellEvent;
    FOnInitializeFooterCell: TcxTreeListReportLinkInitializeFooterCellEvent;
    FOnInitializeHeaderCell: TcxTreeListReportLinkInitializeHeaderCellEvent;
    FOnInitializeIndentCell: TcxTreeListReportLinkInitializeIndentCellEvent;
    function GetActiveStyles: TcxTreeListReportLinkStyles;
    function GetDesignWindow: TdxfmTreeListReportLinkDesignWindow;
    function GetReportRow(Index: Integer): TdxReportCell;
    function GetReportRowByNode(Node: TcxTreeListNode): TdxReportCell;
    function GetReportRowCount: Integer;
    function GetOptionsExpanding: TcxTreeListReportLinkOptionsExpanding;
    function GetOptionsFormatting: TcxTreeListReportLinkOptionsFormatting;
    function GetOptionsOnEveryPage: TcxTreeListReportLinkOptionsOnEveryPage;
    function GetOptionsPagination: TcxTreeListReportLinkOptionsPagination;
    function GetOptionsPreview: TcxTreeListReportLinkOptionsPreview;
    function GetOptionsRefinements: TcxTreeListReportLinkOptionsRefinements;
    function GetOptionsSelection: TcxTreeListReportLinkOptionsSelection;
    function GetOptionsSize: TcxTreeListReportLinkOptionsSize;
    function GetOptionsView: TcxTreeListReportLinkOptionsView;
    function GetStyles: TcxTreeListReportLinkStyles;
    function GetTreeListControl: TcxCustomTreeListControl;
    procedure SetOnCustomDrawBandCell(Value: TcxTreeListReportLinkCustomDrawBandCellEvent);
    procedure SetOnCustomDrawCell(Value: TcxTreeListReportLinkCustomDrawCellEvent);
    procedure SetOnCustomDrawFooterCell(Value: TcxTreeListReportLinkCustomDrawFooterCellEvent);
    procedure SetOnCustomDrawHeaderCell(Value: TcxTreeListReportLinkCustomDrawHeaderCellEvent);
    procedure SetOnCustomDrawIndentCell(Value: TcxTreeListReportLinkCustomDrawIndentCellEvent);
    procedure SetOptionsExpanding(Value: TcxTreeListReportLinkOptionsExpanding);
    procedure SetOptionsFormatting(Value: TcxTreeListReportLinkOptionsFormatting);    
    procedure SetOptionsOnEveryPage(Value: TcxTreeListReportLinkOptionsOnEveryPage);
    procedure SetOptionsPagination(Value: TcxTreeListReportLinkOptionsPagination);
    procedure SetOptionsPreview(Value: TcxTreeListReportLinkOptionsPreview);
    procedure SetOptionsRefinements(Value: TcxTreeListReportLinkOptionsRefinements);
    procedure SetOptionsSelection(Value: TcxTreeListReportLinkOptionsSelection);
    procedure SetOptionsSize(Value: TcxTreeListReportLinkOptionsSize);
    procedure SetOptionsView(Value: TcxTreeListReportLinkOptionsView);    
    procedure SetStyles(Value: TcxTreeListReportLinkStyles);
  protected
    procedure ConstructReport(AReportCells: TdxReportCells); override;
    procedure ConvertCoords; override;
    procedure CustomDraw(AItem: TAbstractdxReportCellData; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect; var ADone: Boolean); override;
    function GetBreakPagesByHardDelimiters: Boolean; override;
    procedure GetImageLists(AProc: TdxPSGetImageListProc); override;
    function GetRebuildOnPageParamsChange(AUpdateCodes: TdxPrinterPageUpdateCodes): Boolean; override;
    function GetUseHardVertDelimiters: Boolean; override;
    procedure InternalRestoreFromOriginal; override;
    function IsDrawFootersOnEveryPage: Boolean; override;
    function IsDrawHeadersOnEveryPage: Boolean; override;
    function IsSupportedCustomDraw(Item: TAbstractdxReportCellData): Boolean; override;
    procedure MakeHardDelimiters(AReportCells: TdxReportCells; AVertDelimiters: TList); override;
      
    function GetAreNativeStylesAvailable: Boolean; override;
    function GetStylesClass: TdxCustomReportLinkStylesClass; override;
    function GetStyleSheetClass: TdxCustomReportLinkStyleSheetClass; override;
    function GetStyleSheetPrototype: TdxCustomReportLinkStyleSheet; override;
    procedure PrepareConstruct; override;

    procedure DoCustomDrawBandCell(ACanvas: TCanvas; ABand: TcxTreeListBand; 
      AnItem: TdxReportCellImage; var ADone: Boolean); dynamic;
    procedure DoCustomDrawCell(ACanvas: TCanvas; ANode: TcxTreeListNode; 
      AColumn: TcxTreeListColumn; AnItem: TAbstractdxReportCellData; 
      var ADone: Boolean); dynamic;
    procedure DoCustomDrawFooterCell(ACanvas: TCanvas; AColumn: TcxTreeListColumn; 
      AnItem: TdxReportCellString; var ADone: Boolean); dynamic;
    procedure DoCustomDrawHeaderCell(ACanvas: TCanvas; AColumn: TcxTreeListColumn; 
      AnItem: TdxReportCellImage; var ADone: Boolean); dynamic;
    procedure DoCustomDrawIndentCell(ACanvas: TCanvas; ANode: TcxTreeListNode; 
      AnIndex: Integer; AnItem: TAbstractdxReportCellData; var ADone: Boolean); dynamic;
    procedure DoGetCustomPageBreaks; dynamic;
    procedure DoInitializeBandCell(ABand: TcxTreeListBand; AnItem: TdxReportCellImage); dynamic;
    procedure DoInitializeCell(ANode: TcxTreeListNode; AColumn: TcxTreeListColumn; AnItem: TAbstractdxReportCellData); dynamic;
    procedure DoInitializeFooterCell(AColumn: TcxTreeListColumn; AnItem: TdxReportCellString); dynamic;
    procedure DoInitializeHeaderCell(AColumn: TcxTreeListColumn; AnItem: TdxReportCellImage); dynamic;
    procedure DoInitializeIndentCell(ANode: TcxTreeListNode; AnIndex: Integer; AnItem: TAbstractdxReportCellData); dynamic;
      
    function GetOptionsExpandingClass: TdxCustomReportLinkOptionsExpandingClass; override;
    function GetOptionsFormattingClass: TdxCustomReportLinkOptionsFormattingClass; override;
    function GetOptionsOnEveryPageClass: TdxCustomTableControlReportLinkOptionsOnEveryPageClass; override;
    function GetOptionsPaginationClass: TdxCustomReportLinkOptionsPaginationClass; override;
    function GetOptionsPreviewClass: TdxCustomTableControlReportLinkOptionsPreviewClass; override;
    function GetOptionsRefinementsClass: TdxCustomReportLinkOptionsRefinementsClass; override;
    function GetOptionsSelectionClass: TdxCustomTableControlReportLinkOptionsSelectionClass; override;
    function GetOptionsSizeClass: TdxCustomReportLinkOptionsSizeClass; override;
    function GetOptionsViewClass: TdxCustomReportLinkOptionsViewClass; override;

    procedure AddReportRow(AReportRow: TdxReportCell);
    procedure AddVerticalHardDelimiter(ADelimiter: TdxReportCell); overload;
    procedure AddVerticalHardDelimiter(ADelimiter: Integer); overload;    

    function CreateBuilder: TcxTreeListControlReportLinkBuilder; virtual;
    class function GetBuilderClass: TcxTreeListControlReportLinkBuilderClass; virtual;

    function ExtractIndentIndex(AData: Integer): Integer;
    function GetItemCustomDrawInfo(AnItem: TdxReportVisualItem; 
       out ADrawInfo: TcxTreeListCellCustomDrawInfo): TcxTreeListAttributeID; virtual;
    function IsCustomDrawn(AnAttributeID: TcxTreeListAttributeID): Boolean; virtual;
    function MakeIndentIndex(AnIndex: Integer): DWORD;
    
    property ActiveStyles: TcxTreeListReportLinkStyles read GetActiveStyles;
    property Builder: TcxTreeListControlReportLinkBuilder read FBuilder;
    property DelimitersHardVert: TList read FDelimitersHardVert;
    property HostInfoServices: TcxTreeListAttributeHostInfoServices read FHostInfoServices;
    property TreeListControl: TcxCustomTreeListControl read GetTreeListControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AddPageBreak(ANode: TcxTreeListNode); overload;
    procedure AddPageBreak(const ANodes: array of TcxTreeListNode); overload;
    procedure AddPageBreak(const ANodes: TcxTreeListNodeArray); overload;
    procedure AddPageBreak(ANodes: TList); overload; // List of TcxCustomGridRecord

    property DesignWindow: TdxfmTreeListReportLinkDesignWindow read GetDesignWindow;
    property ReportRows[Index: Integer]: TdxReportCell read GetReportRow;
    property ReportRowsByNode[Node: TcxTreeListNode]: TdxReportCell read GetReportRowByNode;
    property ReportRowCount: Integer read GetReportRowCount;
  published
    property Color;
    property Font;
    property OptionsExpanding: TcxTreeListReportLinkOptionsExpanding read GetOptionsExpanding write SetOptionsExpanding;
    property OptionsFormatting: TcxTreeListReportLinkOptionsFormatting read GetOptionsFormatting write SetOptionsFormatting;
    property OptionsOnEveryPage: TcxTreeListReportLinkOptionsOnEveryPage read GetOptionsOnEveryPage write SetOptionsOnEveryPage;
    property OptionsPagination: TcxTreeListReportLinkOptionsPagination read GetOptionsPagination write SetOptionsPagination;    
    property OptionsPreview: TcxTreeListReportLinkOptionsPreview read GetOptionsPreview write SetOptionsPreview;
    property OptionsRefinements: TcxTreeListReportLinkOptionsRefinements read GetOptionsRefinements write SetOptionsRefinements;
    property OptionsSelection: TcxTreeListReportLinkOptionsSelection read GetOptionsSelection write SetOptionsSelection;
    property OptionsSize: TcxTreeListReportLinkOptionsSize read GetOptionsSize write SetOptionsSize;
    property OptionsView: TcxTreeListReportLinkOptionsView read GetOptionsView write SetOptionsView;
    property ScaleFonts;
    property StyleRepository;
    property Styles: TcxTreeListReportLinkStyles read GetStyles write SetStyles;
    property SupportedCustomDraw;

    property OnCustomDrawBandCell: TcxTreeListReportLinkCustomDrawBandCellEvent read FOnCustomDrawBandCell 
      write SetOnCustomDrawBandCell;
    property OnCustomDrawCell: TcxTreeListReportLinkCustomDrawCellEvent read FOnCustomDrawCell 
      write SetOnCustomDrawCell;
    property OnCustomDrawFooterCell: TcxTreeListReportLinkCustomDrawFooterCellEvent read FOnCustomDrawFooterCell 
      write SetOnCustomDrawFooterCell;
    property OnCustomDrawHeaderCell: TcxTreeListReportLinkCustomDrawHeaderCellEvent read FOnCustomDrawHeaderCell 
      write SetOnCustomDrawHeaderCell;
    property OnCustomDrawIndentCell: TcxTreeListReportLinkCustomDrawIndentCellEvent read FOnCustomDrawIndentCell 
      write SetOnCustomDrawIndentCell;
    property OnGetCustomPageBreaks: TcxTreeListReportLinkGetCustomPageBreaksEvent read FOnGetCustomPageBreaks write FOnGetCustomPageBreaks;
    property OnInitializeBandCell: TcxTreeListReportLinkInitializeBandCellEvent read FOnInitializeBandCell 
      write FOnInitializeBandCell;
    property OnInitializeCell: TcxTreeListReportLinkInitializeCellEvent read FOnInitializeCell 
      write FOnInitializeCell;
    property OnInitializeFooterCell: TcxTreeListReportLinkInitializeFooterCellEvent read FOnInitializeFooterCell 
      write FOnInitializeFooterCell;
    property OnInitializeHeaderCell: TcxTreeListReportLinkInitializeHeaderCellEvent read FOnInitializeHeaderCell 
      write FOnInitializeHeaderCell;
    property OnInitializeIndentCell: TcxTreeListReportLinkInitializeIndentCellEvent read FOnInitializeIndentCell
      Write FOnInitializeIndentCell;
  end;
  
  TcxTreeListReportLink = class(TcxTreeListControlReportLink)
  private
    function GetTreeList: TcxTreeList;
  public
    property TreeList: TcxTreeList read GetTreeList;
  end;

  TcxDBTreeListReportLink = class(TcxTreeListControlReportLink)
  private
    function GetDBTreeList: TcxDBTreeList;
  public
    property DBTreeList: TcxDBTreeList read GetDBTreeList;
  end;

  TcxVirtualTreeListReportLink = class(TcxTreeListControlReportLink)
  private
    function GetVirtualTreeList: TcxVirtualTreeList;
  public
    property VirtualTreeList: TcxVirtualTreeList read GetVirtualTreeList;
  end;
    
  TdxfmTreeListReportLinkDesignWindow = class(TdxfmCustomcxControlReportLinkDesignWindow)
    PageControl1: TPageControl;
    tshView: TTabSheet;
    lblShow: TLabel;
    imgShow: TImage;
    bvlShow: TBevel;
    lblOnEveryPage: TLabel;
    imgOnEveryPage: TImage;
    bvlOnEveryPage: TBevel;
    bvlWarningHost: TBevel;
    chbxShowBands: TCheckBox;
    chbxShowHeaders: TCheckBox;
    chbxShowFooters: TCheckBox;
    chbxShowExpandButtons: TCheckBox;
    chbxBandsOnEveryPage: TCheckBox;
    chbxHeadersOnEveryPage: TCheckBox;
    chbxFootersOnEveryPage: TCheckBox;
    chbxShowTreeLines: TCheckBox;
    tshBehaviors: TTabSheet;
    tshFormatting: TTabSheet;
    lblLookAndFeel: TLabel;
    bvlLookAndFeel: TBevel;
    imgLookAndFeel: TImage;
    imgRefinements: TImage;
    lblRefinements: TLabel;
    bvlRefinements: TBevel;
    cbxLookAndFeel: TComboBox;
    chbxFlatCheckMarks: TCheckBox;
    chbxDisplayGraphicsAsText: TCheckBox;
    chbxTransparentGraphics: TCheckBox;
    tshPreview: TTabSheet;
    lblPreviewOptions: TLabel;
    bvlPreviewOptions: TBevel;
    lblPreviewMaxLineCount: TLabel;
    bvlPreviewMaxLineCountHost: TBevel;
    imgPreview: TImage;
    chbxPreviewVisible: TCheckBox;
    chbxPreviewAutoHeight: TCheckBox;
    pnlPreview: TPanel;
    cxStyleRepository1: TcxStyleRepository;
    styleBandHeaders: TcxStyle;
    styleStandard: TcxStyle;
    stylePreview: TcxStyle;
    styleCardShadow: TcxStyle;
    chbxSuppressBackgroundBitmaps: TCheckBox;
    tshStyles: TTabSheet;
    bvlStyles: TBevel;
    bvlStyleSheets: TBevel;
    lblStyleSheets: TLabel;
    btnStyleColor: TButton;
    btnStyleFont: TButton;
    btnStyleBackgroundBitmap: TButton;
    chbxUseNativeStyles: TCheckBox;
    cbxStyleSheets: TComboBox;
    btnStyleSheetNew: TButton;
    btnStyleSheetCopy: TButton;
    btnStyleSheetDelete: TButton;
    btnStylesSaveAs: TButton;
    btnStyleSheetRename: TButton;
    pmStyles: TPopupMenu;
    miStyleFont: TMenuItem;
    miStyleColor: TMenuItem;
    miStyleBackgroundBitmap: TMenuItem;
    milLine: TMenuItem;
    miStylesSaveAs: TMenuItem;
    btnStyleBackgroundBitmapClear: TButton;
    btnStyleRestoreDefaults: TButton;
    miLine2: TMenuItem;
    miLine3: TMenuItem;
    miStyleBackgroundBitmapClear: TMenuItem;
    miStyleRestoreDefaults: TMenuItem;
    bvlStylesHost: TBevel;
    ilStylesPopup: TImageList;
    PreviewTreeList: TcxTreeList;
    colManufacturerName: TcxTreeListColumn;
    colManufacturerLogo: TcxTreeListColumn;
    colManufacturerCountry: TcxTreeListColumn;
    colCarModel: TcxTreeListColumn;
    colCarIsSUV: TcxTreeListColumn;
    chbxShowBorders: TCheckBox;
    miStylesSelectAll: TMenuItem;
    miLine4: TMenuItem;
    chbxConsumeSelectionStyle: TCheckBox;
    bvlRefinementsSeparator: TBevel;
    Bevel2: TBevel;
    pnlBehaviors: TPanel;
    pnlSelection: TPanel;
    lblSelection: TLabel;
    imgSelection: TImage;
    bvlSelection: TBevel;
    chbxProcessSelection: TCheckBox;
    chbxProcessExactSelection: TCheckBox;
    pnlExpanding: TPanel;
    lblExpanding: TLabel;
    imgExpanding: TImage;
    bvlExpanding: TBevel;
    chbxExpandNodes: TCheckBox;
    pnlSize: TPanel;
    lblSize: TLabel;
    bvlSize: TBevel;
    imgGridSize: TImage;
    chbxAutoWidth: TCheckBox;
    pnlSeparators: TPanel;
    lblSeparators: TLabel;
    bvlSeparator: TBevel;
    lblSeparatorsThickness: TLabel;
    lblSeparatorsColor: TLabel;
    bvlSeparatorThicknessHost: TBevel;
    bvlSeparatorColorHost: TBevel;
    imgSeparators: TImage;
    chbxExplicitlyExpandNodes: TCheckBox;
    lblPreviewWindow: TStaticText;
    Label1: TLabel;
    lblUseNativeStyles: TLabel;
    procedure LookAndFeelChange(Sender: TObject);
    procedure OptionsRefinementsClick(Sender: TObject);
    procedure PreviewVisibleClick(Sender: TObject);
    procedure PreviewAutoHeightClick(Sender: TObject);
    procedure OptionsSelectionClick(Sender: TObject);
    procedure OptionsExpandingClick(Sender: TObject);
    procedure OptionsViewClick(Sender: TObject);
    procedure OptionsOnEveryPageClick(Sender: TObject);
    procedure OptionsSizeClick(Sender: TObject);
    procedure OptionsFormattingClick(Sender: TObject);
    procedure pmStylesPopup(Sender: TObject);
    procedure StyleColorClick(Sender: TObject);
    procedure StyleFontClick(Sender: TObject);
    procedure StyleBackgroundBitmapClick(Sender: TObject);
    procedure cbxStyleSheetsClick(Sender: TObject);
    procedure btnStyleSheetNewClick(Sender: TObject);
    procedure btnStyleSheetCopyClick(Sender: TObject);
    procedure btnStyleSheetDeleteClick(Sender: TObject);
    procedure btnStyleSheetRenameClick(Sender: TObject);
    procedure StylesSaveAsClick(Sender: TObject);
    procedure cbxStyleSheetsKeyDown(Sender: TObject; var Key: Word; 
      Shift: TShiftState);
    procedure lbxStylesClick(Sender: TObject);
    procedure StyleBackgroundBitmapClearClick(Sender: TObject);
    procedure StyleRestoreDefaultsClick(Sender: TObject);
    procedure PreviewTreeListCustomDrawCell(Sender: TObject;
      Canvas: TcxCanvas; AViewInfo: TcxTreeListEditCellViewInfo;
      var ADone: Boolean);
    procedure PreviewTreeListCustomDrawHeader(Sender: TObject;
      ACanvas: TcxCanvas; AViewInfo: TcxTreeListHeaderViewInfo;
      var ADone: Boolean);                    
    procedure PreviewTreeListCustomDrawFooterCell(Sender: TObject;
      Canvas: TcxCanvas; AViewInfo: TcxTreeListFooterItemViewInfo;
      var ADone: Boolean);
    procedure miStylesSelectAllClick(Sender: TObject);
    procedure PreviewTreeListCustomDrawBandHeader(Sender: TObject;
      ACanvas: TcxCanvas; AViewInfo: TcxTreeListHeaderViewInfo;
      var ADone: Boolean);
    procedure PageControl1Change(Sender: TObject);
    procedure cbxStyleSheetsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lblUseNativeStylesClick(Sender: TObject);
  private
    lbxStyles: TdxStylesListBox;
    sePreviewMaxLineCount: TdxPSSpinEdit;
    seSeparatorThickness: TdxPSSpinEdit;
    ccbxSeparatorColor: TdxPSColorCombo;
    wpIncorrectOnEveryPageState: TdxPSWarningPane;
    
    function GetActiveStyle: TcxStyle;
    function GetHasSelectedStyles: Boolean;
    function GetHasSelectedStylesWithAssignedBitmap: Boolean;
    function GetReportLink: TcxTreeListControlReportLink;
    
    procedure PreviewMaxLineCountChanged(Sender: TObject);
    procedure SeparatorColorChanged(Sender: TObject);
    procedure SeparatorThicknessChanged(Sender: TObject);
    
    function CanSelectAllStyles: Boolean;
    procedure CreateControls;
    procedure CustomDrawBorders(ACanvas: TcxCanvas; const R: TRect);
    procedure CustomDrawCheckMark(ACanvas: TcxCanvas; AViewInfo: TcxTreeListEditCellViewInfo);
    procedure CustomDrawFooter(ACanvas: TcxCanvas; R: TRect; AViewInfo: TcxTreeListFooterItemViewInfo);
    procedure CustomDrawHeader(ACanvas: TcxCanvas; R: TRect; AViewInfo: TcxTreeListHeaderViewInfo);
    procedure CustomDrawTextRect(ACanvas: TcxCanvas; R: TRect; const AText: string; 
      AnAlignmentHorz: TAlignment; AnAlignmentVert: TcxAlignmentVert; AParams: TcxViewParams);
    function ExtractAlignmentHorz(AViewInfo: TcxTreeListEditCellViewInfo): TAlignment;
    function ExtractAlignmentVert(AViewInfo: TcxTreeListEditCellViewInfo): TcxAlignmentVert;
    procedure InitializePreviewTreeList;
    procedure InitializePreviewTreeListStyles;
    procedure LoadDataIntoPreviewTreeList;
    procedure RecreateStylesListBox;
    procedure RestoreSelectedStyles(AList: TList);
    procedure SaveSelectedStyles(AList: TList);
    procedure SetActivePage;
    procedure UpdatePreviewTreeListStyles(const ACaption: string; AStyle: TcxStyle);
    procedure WarningPaneUpdate;
    
    procedure SetOptionsExpandingByIndex(Index: Integer; Value: Boolean);
    procedure SetOptionsFormattingByIndex(Index: Integer; Value: Boolean);
    procedure SetOptionsOnEveryPageByIndex(Index: Integer; Value: Boolean);
    procedure SetOptionsRefinementsByIndex(Index: Integer; Value: Boolean);
    procedure SetOptionsSelectionByIndex(Index: Integer; Value: Boolean);
    procedure SetOptionsSizeByIndex(Index: Integer; Value: Boolean);
    procedure SetOptionsViewByIndex(Index: Integer; Value: Boolean);
  protected
    procedure DoInitialize; override;
    {$IFDEF DELPHI7}
    function GetPreviewHost: TCustomPanel; override;
    {$ENDIF}
    procedure LoadStrings; override;
    procedure UpdateControlsState; override;
    procedure UpdatePreview; override;

    function GetDesignerTabIndex: Integer; override;
    procedure SetDesignerTabIndex(Value: Integer); override;
   
    procedure DoActiveStyleSheetChanged; override;
    procedure DoFormActivated(AnActive: Boolean); override;
    procedure DoRefreshStylesList; override;
    procedure DoStyleChanged(const ACaption: string; AStyle: TcxStyle); override;
    procedure DoStylesChanged(AStrings: TStrings; ARecreate: Boolean); override;

    procedure GetSelectedStyleNames(AStrings: TStrings); override;
    procedure GetStyleNames(out AStrings: TStrings); override;
    procedure GetStyleSheetNames(out AStrings: TStrings); override;

    property ActiveStyle: TcxStyle read GetActiveStyle;
    property HasSelectedStyles: Boolean read GetHasSelectedStyles;
    property HasSelectedStylesWithAssignedBitmap: Boolean read GetHasSelectedStylesWithAssignedBitmap;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ReportLink: TcxTreeListControlReportLink read GetReportLink;
  end;

const
  dxPSDefaultTreeListNodeSeparatorColor: TColor = clBtnShadow;
  
implementation

{$R *.dfm}

{ 634x420 - DesignWindow }
{.3 - chbxTransparentRichEdits }

uses
 {$IFDEF DELPHI6} 
  Variants, 
 {$ENDIF} Forms, Registry, dxThemeManager, cxDataStorage, cxDataUtils, cxTLIntf, 
  cxImage, cxCheckBox, dxPSGlbl, dxPSRes, dxPSImgs, cxDrawTextUtils, dxPSPopupMan, 
  dxPSUtl, dxBkgnd;
     
const
  CellSidesMap: array[TcxTreeListGridLines] of TdxCellSides = ([], csTopBottom, csLeftRight, csAll);
  SortOrderMap: array[TcxDataSortOrder] of TdxCellSortOrder = (csoNone, csoUp, csoDown);  
  TreeLinesStyleMap: array[TcxTreeListTreeLineStyle] of TdxPSTreeLineStyle = (tlsDot, tlsDot, tlsSolid);
  
  DefaultExpandButtonSize = 9;
  DefaultIndentWidth = 15;
  ExpandButtonInteriorColors: array[Boolean] of TColor = (clWindow, clBtnShadow);
  FooterItemInflateHorz = 2;
  FooterItemInflateVert = 3;

  NodeIndentMask   = $00000FF0;
  NodeIndentOffset = $00000004;

var
  FDefaultdxPScxTreeListLinkStyleSheet: TcxTreeListReportLinkStyleSheet;

type
  TcxTreeListNodeHelperFactory = class(TdxCustomClassMaps)
  private
    function GetHelperClass(Node: TcxTreeListNode): TcxTreeListNodeHelperClass;
  public
    class function Instance: TcxTreeListNodeHelperFactory; reintroduce; overload; 
    property HelperClasses[Node: TcxTreeListNode]: TcxTreeListNodeHelperClass read GetHelperClass; default;
  end;

 
  TcxCustomTreeListControlAccess = class(TcxCustomTreeListControl);
  TcxTreeListColumnAccess = class(TcxTreeListColumn);

{ Helpers }

{ CustomTreeListControl Helpers }

function CustomTreeListControl_DoIsGroupNode(AInstance: TcxCustomTreeListControl; ANode: TcxTreeListNode): Boolean;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).DoIsGroupNode(ANode);
end;

function CustomTreeListControl_GetHeaderLineCount(AInstance: TcxCustomTreeListControl): Integer;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).HeaderLineCount;
end;

function CustomTreeListControl_GetImages(AInstance: TcxCustomTreeListControl): TCustomImageList;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).Images;
end;

function CustomTreeListControl_GetLookAndFeel(AInstance: TcxCustomTreeListControl): TcxLookAndFeel;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).LookAndFeel;
end;

function CustomTreeListControl_GetLookAndFeelPainter(AInstance: TcxCustomTreeListControl): TcxCustomLookAndFeelPainterClass;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).LookAndFeelPainter;
end;

function CustomTreeListControl_GetNodes(AInstance: TcxCustomTreeListControl): TcxTreeListNodes;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).Nodes;
end;

function CustomTreeListControl_GetOptionsSelection(AInstance: TcxCustomTreeListControl): TcxTreeListOptionsSelection;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).OptionsSelection;
end;

function CustomTreeListControl_GetOptionsView(AInstance: TcxCustomTreeListControl): TcxTreeListOptionsView;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).OptionsView;
end;

function CustomTreeListControl_GetPreview(AInstance: TcxCustomTreeListControl): TcxTreeListPreview;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).Preview;
end;

function CustomTreeListControl_GetStateImages(AInstance: TcxCustomTreeListControl): TCustomImageList;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).StateImages;
end;

function CustomTreeListControl_GetStyles(AInstance: TcxCustomTreeListControl): TcxTreeListStyles;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).Styles;
end;

function CustomTreeListControl_GetVisibleBand(AInstance: TcxCustomTreeListControl; 
  Index: Integer): TcxTreeListBand;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).VisibleBands[Index];
end;

function CustomTreeListControl_GetVisibleBandCount(AInstance: TcxCustomTreeListControl): Integer;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).VisibleBandCount;
end;

function CustomTreeListControl_GetVisibleColumn(AInstance: TcxCustomTreeListControl; 
  Index: Integer): TcxTreeListColumn;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).VisibleColumns[Index];
end;

function CustomTreeListControl_GetVisibleColumnCount(AInstance: TcxCustomTreeListControl): Integer;
begin
  Result := TcxCustomTreeListControlAccess(AInstance).VisibleColumnCount;
end;
  
{ TreeListColumn Helpers }

function TreeListColumn_DoGetEditProperties(AInstance: TcxTreeListColumn; 
  ANode: TcxTreeListNode): TcxCustomEditProperties; 
begin
  Result := TcxTreeListColumnAccess(AInstance).DoGetEditProperties(ANode);
end;

{ Utilities }
 
function DefaultdxPScxTreeListLinkStyleSheet: TcxTreeListReportLinkStyleSheet;

  function CreateStyle(AColor: TColor; AFontColor: TColor): TcxStyle;
  begin
    Result := TcxStyle.Create(DefaultdxPScxTreeListLinkStyleSheet);
    with Result do
    begin
      Color := AColor;
      Font.Name := dxPSCore.dxPSDefaultFontName;
      Font.Color := AFontColor;
    end;
  end;
  
begin
  if FDefaultdxPScxTreeListLinkStyleSheet = nil then 
  begin
    FDefaultdxPScxTreeListLinkStyleSheet := TcxTreeListReportLinkStyleSheet.Create(nil);
    with FDefaultdxPScxTreeListLinkStyleSheet.Styles as TcxTreeListReportLinkStyles do
    begin
      BandHeader := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
      Content := CreateStyle(dxPSCore.dxDefaultContentColor, dxPSCore.dxPSDefaultFontColor);
      ContentEven := CreateStyle(dxPSCore.dxDefaultContentColor, dxPSCore.dxPSDefaultFontColor);
      ContentOdd := CreateStyle(dxPSCore.dxDefaultContentColor, dxPSCore.dxPSDefaultFontColor);
      Footer := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
      FooterRow := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
      Header := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
      Preview := CreateStyle(dxPSCore.dxDefaultContentColor, dxPSCore.dxPSDefaultFontColor);
      Selection := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
    end;
  end;
  Result := FDefaultdxPScxTreeListLinkStyleSheet;
end;

function IsValidPointer(const AData: Integer): Boolean;
begin
  //Result := (HInstance = 0) or (FindHInstance(Pointer(AData)) = HInstance);
  Result := DWORD(AData) > HInstance;
end;

function ColumnIndex(AColumn: TcxTreeListColumn): Integer;
var
  IndexedItem: IcxTreeListIndexedItem;
begin  
  if Supports(TObject(AColumn), IcxTreeListIndexedItem, IndexedItem) then 
    Result := IndexedItem.ItemIndex
  else
    Result := -1;
end;

{ TcxTreeListNodeHelperFactory }

function cxTreeListNodeHelperFactory: TcxTreeListNodeHelperFactory;
begin
  Result := TcxTreeListNodeHelperFactory.Instance;
end;

class function TcxTreeListNodeHelperFactory.Instance: TcxTreeListNodeHelperFactory;
begin
  Result := inherited Instance as TcxTreeListNodeHelperFactory;
end;

function TcxTreeListNodeHelperFactory.GetHelperClass(Node: TcxTreeListNode): TcxTreeListNodeHelperClass;
begin
  Result := TcxTreeListNodeHelperClass(PairClasses[Node.ClassType]);
end;

{ CLR Accessors }

  
{ TcxTreeListControlReportLinkRowProducer }

constructor TcxTreeListControlReportLinkRowProducer.Create(ABuilder: TcxTreeListControlReportLinkBuilder); 
begin
  inherited Create;
  FBuilder := ABuilder;
end;

function TcxTreeListControlReportLinkRowProducer.Adapter: TcxTreeListControlAdapter;
begin
  Result := Builder.Adapter;
end;

function TcxTreeListControlReportLinkRowProducer.Builder: TcxTreeListControlReportLinkBuilder;
begin
  Result := FBuilder;
end;

function TcxTreeListControlReportLinkRowProducer.Formatter: TcxTreeListControlReportLinkFormatter;
begin
  Result := Builder.Formatter;
end;

function TcxTreeListControlReportLinkRowProducer.Produce(AHostInfo: TcxTreeListControlAttributeHostInfo): TdxReportCell;
begin
  CalculateRowHeight;
  
  CreateRowHost(AHostInfo);
  CreateRow;
  if AutoHeight then 
  begin
    CalculateRowAutoHeight;
    FixupRowHeight;
  end;
  
  Inc(AHostInfo.Origin.Y, RowHeight);
  Result := Host;
end;

procedure TcxTreeListControlReportLinkRowProducer.CalculateRowAutoHeight;
var
  DC: HDC;
  MaxRowHeight, I, V: Integer;
  Item: TdxReportVisualItem;
begin
  DC := Self.DC;
  MaxRowHeight := 0;
  for I := 0 to Row.DataItemCount - 1 do 
  begin
    Item := Row.DataItems[I];
    if DoesItemParticipateInRowAutoHeightCalculation(Item) then
    begin
      V := Item.MeasureContentHeight(DC);
      if MaxRowHeight < V then MaxRowHeight := V;
    end;   
  end;  
  // v3.1
  for I := 0 to Row.CellCount - 1 do 
  begin
    Item := Row.Cells[I];
    if DoesItemParticipateInRowAutoHeightCalculation(Item) then
    begin
      V := Item.MeasureContentHeight(DC);
      if MaxRowHeight < V then MaxRowHeight := V;
    end;   
  end;  
  if RowHeight < MaxRowHeight then
    RowHeight := MaxRowHeight;
end;

procedure TcxTreeListControlReportLinkRowProducer.CalculateRowHeight;
begin
  FRowHeight := LineCount * LineHeight;
end;

procedure TcxTreeListControlReportLinkRowProducer.CreateRow;
begin
  FRow := TdxReportCell.Create(Host);
  FRow.BoundsRect := MakeBounds(0, 0, RowWidth, RowHeight);
  InitializeRow;
end;

procedure TcxTreeListControlReportLinkRowProducer.CreateRowHost(const AHostInfo: TcxTreeListControlAttributeHostInfo);
begin
  FHost := TdxReportCell.Create(AHostInfo.Parent);
  FHost.BoundsRect := MakeBounds(AHostInfo.Origin.X, AHostInfo.Origin.Y, RowWidth, RowHeight);
  Formatter.DoInitializeHost(Host);
end;

function TcxTreeListControlReportLinkRowProducer.DoesItemParticipateInRowAutoHeightCalculation(
  AnItem: TdxReportVisualItem): Boolean;
begin
  Result := True;
end;

procedure TcxTreeListControlReportLinkRowProducer.FixupRowDataHeight;  
var
  I: Integer;
begin
  for I := 0 to Row.DataItemCount - 1 do 
    Row.DataItems[I].Height := RowHeight;
  // v3.1
  for I := 0 to Row.CellCount - 1 do 
    Row.Cells[I].Height := RowHeight;
end;

procedure TcxTreeListControlReportLinkRowProducer.FixupRowHeight;
begin
  FixupRowItselfHeight;
  FixupRowDataHeight;  
end;

procedure TcxTreeListControlReportLinkRowProducer.FixupRowItselfHeight;
begin
  Host.Height := RowHeight;
  Row.Height := RowHeight;
end;
    
procedure TcxTreeListControlReportLinkRowProducer.InitializeRow;
begin
end;

function TcxTreeListControlReportLinkRowProducer.GetAutoHeight: Boolean;
begin
  Result := LineCount = 1;
end;

function TcxTreeListControlReportLinkRowProducer.GetLineCount: Integer;
begin
  Result := 1;
end;

function TcxTreeListControlReportLinkRowProducer.GetLineHeight: Integer;
begin
  Result := 20;
end;

function TcxTreeListControlReportLinkRowProducer.GetDC: HDC;
begin
  Result := Formatter.DC;
end;

function TcxTreeListControlReportLinkRowProducer.GetIndentWidth: Integer;
begin
  Result := Adapter.IndentWidth;
end;

function TcxTreeListControlReportLinkRowProducer.GetRowWidth: Integer;
begin
  Result := Formatter.ViewWidth;
end;

{ TcxTreeListControlReportLinkCustomRowProducer }

function TcxTreeListControlReportLinkCustomRowProducer.Produce(AHostInfo: TcxTreeListControlAttributeHostInfo): TdxReportCell;
begin
  Result := inherited Produce(AHostInfo);
  CreateItem;
end;

procedure TcxTreeListControlReportLinkCustomRowProducer.CreateItem;
begin
  FItem := GetItemClass.Create(Row);
  FItem.BoundsRect := MakeRect(0, 0, RowWidth, RowHeight);
  InitializeItem;
end;
    
procedure TcxTreeListControlReportLinkCustomRowProducer.InitializeItem;
begin
end;

function TcxTreeListControlReportLinkCustomRowProducer.GetAutoHeight: Boolean;
begin
  Result := False;
end;

function TcxTreeListControlReportLinkCustomRowProducer.GetItemClass: TdxReportCellDataClass;
begin
  Result := TAbstractdxReportCellData;
end;

{ TcxTreeListControlReportLinkNodeSeparatorProducer }

procedure TcxTreeListControlReportLinkNodeSeparatorProducer.InitializeItem;
begin
  inherited;
  Formatter.DoInitializeNodeSeparator(Item);
end;   

procedure TcxTreeListControlReportLinkNodeSeparatorProducer.InitializeRow;
begin
  inherited;
  Formatter.DoInitializeNodeSeparatorRow(Row);
end;

function TcxTreeListControlReportLinkNodeSeparatorProducer.GetItemClass: TdxReportCellDataClass;
begin
  Result := Formatter.GetNodeSeparatorClass;
end;

function TcxTreeListControlReportLinkNodeSeparatorProducer.GetLineHeight: Integer;
begin
  Result := Formatter.NodeSeparatorThickness;
end;

function TcxTreeListControlReportLinkNodeSeparatorProducer.GetItem: TdxReportCellBox;
begin
  Result := TdxReportCellBox(inherited Item);
end;

{ TcxTreeListControlReportLinkRowSubItemsProducer }

procedure TcxTreeListControlReportLinkRowSubItemsProducer.CreateDataItems(AParent: TdxReportCell);
var
  I: Integer;
  Item: TAbstractdxReportCellData;
begin
  for I := 0 to SubItemCount - 1 do 
    if HasSubItem[I] then
    begin
      Item := SubItemClasses[I].Create(AParent);
      Item.BoundsRect := SubItemBounds[I];
      InitializeSubItem(Item, I);
    end;
end;

procedure TcxTreeListControlReportLinkRowSubItemsProducer.CreateIcons(AParent: TdxReportCell);
begin
end;

procedure TcxTreeListControlReportLinkRowSubItemsProducer.CreateIndents(AParent: TdxReportCell);
begin
end;

procedure TcxTreeListControlReportLinkRowSubItemsProducer.CreateRow;
begin
  inherited;
  CreateIndents(Row);
  CreateIcons(Row);
  CreateDataItems(Row);
end;

procedure TcxTreeListControlReportLinkRowSubItemsProducer.InitializeSubItem(ASubItem: TAbstractdxReportCellData; 
  AnIndex: Integer);
begin
end;

function TcxTreeListControlReportLinkRowSubItemsProducer.GetHasSubItem(Index: Integer): Boolean;
begin
  Result := True;
end;

function TcxTreeListControlReportLinkRowSubItemsProducer.GetSubItemBound(Index: Integer): TRect;
begin
  Result := MakeRect(0, 0, -1, -1);
end;

function TcxTreeListControlReportLinkRowSubItemsProducer.GetSubItemCount: Integer;
begin
  Result := Adapter.ColumnCount;
end;

function TcxTreeListControlReportLinkRowSubItemsProducer.GetColumn(Index: Integer): TcxTreeListColumn;
begin
  Result := Adapter.Columns[Index];
end;

{ TcxTreeListControlReportLinkBandsProducer }

function TcxTreeListControlReportLinkBandsProducer.GetSubItemCount: Integer;
begin
  Result := Adapter.BandCount;
end;

procedure TcxTreeListControlReportLinkBandsProducer.InitializeRow;
begin
  inherited;
  Formatter.DoInitializeBandRow(Row);
end;

procedure TcxTreeListControlReportLinkBandsProducer.InitializeSubItem(ASubItem: TAbstractdxReportCellData; 
  AnIndex: Integer);
begin
  inherited;
  Formatter.DoInitializeBandItem(ASubItem, AnIndex);
  Formatter.DoReportLinkInitializeBandItem(ASubItem, AnIndex);
end;

function TcxTreeListControlReportLinkBandsProducer.GetAutoHeight: Boolean;
begin
  Result := False;
end;

function TcxTreeListControlReportLinkBandsProducer.GetLineCount: Integer;
begin
  Result := Adapter.BandLineCount;
end;

function TcxTreeListControlReportLinkBandsProducer.GetLineHeight: Integer;
begin
  Result := Formatter.BandLineHeight;
end;

function TcxTreeListControlReportLinkBandsProducer.GetSubItemBound(Index: Integer): TRect;
begin
  Result := Formatter.GetBandItemBounds(Index);
end;

function TcxTreeListControlReportLinkBandsProducer.GetSubItemClass(Index: Integer): TdxReportCellDataClass; 
begin
  Result := Formatter.GetBandItemClass(Index);
end;

{ TcxTreeListControlReportLinkFootersProducer }

procedure TcxTreeListControlReportLinkFootersProducer.CalculateRowHeight;
begin
  if AutoHeight then 
    inherited
  else  
    RowHeight := LineCount * LineHeight;
end;

procedure TcxTreeListControlReportLinkFootersProducer.InitializeRow;
begin
  inherited;
  Formatter.DoInitializeFooterRow(Row);
end;

procedure TcxTreeListControlReportLinkFootersProducer.InitializeSubItem(ASubItem: TAbstractdxReportCellData; 
  AnIndex: Integer);
begin
  inherited;
  Formatter.DoInitializeFooterItem(ASubItem, AnIndex);
  Formatter.DoReportLinkInitializeFooterItem(ASubItem, AnIndex);
end;

function TcxTreeListControlReportLinkFootersProducer.GetAutoHeight: Boolean;
begin
  Result := False;
end;

function TcxTreeListControlReportLinkFootersProducer.GetHasSubItem(Index: Integer): Boolean;
begin
  Result := Adapter.HasFooterItem[Index];
end;

function TcxTreeListControlReportLinkFootersProducer.GetLineCount: Integer;
begin
  Result := Adapter.DetailsLineCount;
end;

function TcxTreeListControlReportLinkFootersProducer.GetLineHeight: Integer;
begin
  Result := Formatter.FooterLineHeight;
end;

function TcxTreeListControlReportLinkFootersProducer.GetSubItemBound(Index: Integer): TRect;
begin
  Result := Formatter.GetFooterItemBounds(Index);
end;

function TcxTreeListControlReportLinkFootersProducer.GetSubItemClass(Index: Integer): TdxReportCellDataClass;
begin
  Result := Formatter.GetFooterItemClass(Index);
end;

{ TcxTreeListControlReportLinkHeadersProducer }

procedure TcxTreeListControlReportLinkHeadersProducer.InitializeRow;
begin
  inherited;
  Formatter.DoInitializeHeaderRow(Row);
end;

procedure TcxTreeListControlReportLinkHeadersProducer.InitializeSubItem(ASubItem: TAbstractdxReportCellData; 
  AnIndex: Integer);
begin
  inherited;
  Formatter.DoInitializeHeaderItem(ASubItem, AnIndex);
  Formatter.DoReportLinkInitializeHeaderItem(ASubItem, AnIndex);
end;

function TcxTreeListControlReportLinkHeadersProducer.GetAutoHeight: Boolean;
begin
  Result := inherited GetAutoHeight and Adapter.HeaderAutoHeight;
end;

function TcxTreeListControlReportLinkHeadersProducer.GetLineCount: Integer;
begin
  Result := Adapter.DetailsLineCount;
end;

function TcxTreeListControlReportLinkHeadersProducer.GetLineHeight: Integer;
begin
  Result := Formatter.HeaderLineHeight;
end;

function TcxTreeListControlReportLinkHeadersProducer.GetSubItemBound(Index: Integer): TRect;
begin
  Result := Formatter.GetHeaderItemBounds(Index);
end;

function TcxTreeListControlReportLinkHeadersProducer.GetSubItemClass(Index: Integer): TdxReportCellDataClass;
begin
  Result := Formatter.GetHeaderItemClass(Index);
end;

{ TcxTreeListControlReportLinkNodeProducer }    
            
constructor TcxTreeListControlReportLinkNodeProducer.Create(ABuilder: TcxTreeListControlReportLinkBuilder);
begin
  inherited;
  FIndents := TList.Create;
end;

destructor TcxTreeListControlReportLinkNodeProducer.Destroy;
begin
  FIndents.Free;
  inherited;
end;

function TcxTreeListControlReportLinkNodeProducer.Produce(AHostInfo: TcxTreeListControlAttributeHostInfo;
  ANode: TcxTreeListNode): TdxReportCell;
begin
  FIndents.Clear;
  FNode := ANode;
  Result := inherited Produce(AHostInfo);
  FNode := nil;
end;

function TcxTreeListControlReportLinkNodeProducer.Node: TcxTreeListNode;
begin
  Result := FNode;
end;

procedure TcxTreeListControlReportLinkNodeProducer.CalculateRowAutoHeight;
begin
  if CellAutoHeight then 
    inherited CalculateRowAutoHeight;
  if PreviewItem <> nil then 
    RowHeight := RowHeight + PreviewItem.Height;
end;

procedure TcxTreeListControlReportLinkNodeProducer.CreateDataItems(AParent: TdxReportCell);
begin
  inherited;
  if HasPreview then CreatePreview(AParent);
end;

procedure TcxTreeListControlReportLinkNodeProducer.CreateIcons(AParent: TdxReportCell);
begin
  if Adapter.HasStateImages(Node) then CreateStateImages(AParent);
  if Adapter.HasImages(Node) then CreateImages(AParent);
end;

procedure TcxTreeListControlReportLinkNodeProducer.CreateImages(AParent: TdxReportCell);
begin
  FImage := Formatter.GetNodeImageClass.Create(AParent);
  FImage.BoundsRect := ImageRect;
  InitializeImage(ImageIndentIndex);
end;

procedure TcxTreeListControlReportLinkNodeProducer.CreateIndents(AParent: TdxReportCell);
var
  I: Integer;
  Indent: TdxReportCellExpandButton;
begin
  inherited;
  for I := 0 to IndentCount - 1 do 
  begin
    Indent := Formatter.GetNodeIndentClass.Create(AParent);
    Indent.BoundsRect := IndentBounds[I];
    InitializeIndent(Indent, I);
    FIndents.Add(Indent);
  end;
end;

procedure TcxTreeListControlReportLinkNodeProducer.CreatePreview(AParent: TdxReportCell);
begin
  FPreviewItem := Formatter.GetPreviewClass(PreviewColumn, Node).Create(AParent);
  PreviewItem.Left := PreviewIndent;
  // We have to set Width before because we use this value for PreviewHeight calculation
  PreviewItem.Width := RowWidth - PreviewItem.Left;
  Formatter.DoInitializePreview(FPreviewItem, PreviewColumn, Node); // v3.1 because cxRichEdit
  PreviewItem.Height := PreviewHeight;
  PreviewItem.AdjustContent(Formatter.DC); // v3.1
end;

procedure TcxTreeListControlReportLinkNodeProducer.CreateStateImages(AParent: TdxReportCell);
begin
  FStateImage := Formatter.GetNodeStateImageClass.Create(AParent);
  FStateImage.BoundsRect := StateImageRect;
  InitializeStateImage(StateImageIndentIndex);
end;

function TcxTreeListControlReportLinkNodeProducer.DoesItemParticipateInRowAutoHeightCalculation(
  AnItem: TdxReportVisualItem): Boolean;
var
  Column: TcxTreeListColumn;
  Properties: TcxCustomEditProperties;
begin
  Result := AnItem <> FPreviewItem;
  // v3.2
  if Result and not IsItemIndent(AnItem) and IsDelphiObject(AnItem.Data) then
  begin
    Column := TcxTreeListColumn(AnItem.Data);
    Properties := Adapter.GetProperties(Column, Node);
    Result := dxPScxCommon.dxPSDataMaps.DoesItemParticipateInAutoHeightCalculation(Properties);
  end;
end;

procedure TcxTreeListControlReportLinkNodeProducer.FixupRowDataHeight;
var
  NewHeight, I: Integer;
  Item: TdxReportVisualItem;
begin
  NewHeight := RowHeight;
  if PreviewItem <> nil then 
    Dec(NewHeight, PreviewItem.Height);

  for I := 0 to Row.DataItemCount - 1 do 
  begin
    Item := Row.DataItems[I];
    if Item = PreviewItem then
      if PreviewPlace = tlppTop then 
        Item.Top := 0
      else  
        Item.Top := NewHeight
    else
      if IsItemIndent(Item) or (Item = StateImage) or (Item = Image) then 
      begin
        Item.Top := 0;        
        Item.Height := RowHeight;
      end
      else
      begin
        if CellAutoHeight then 
          Item.Height := NewHeight;
        if HasPreview and (PreviewPlace = tlppTop) then 
          Item.Top := Item.Top + PreviewItem.Height;
      end;
  end;
  // v3.1
  for I := 0 to Row.CellCount - 1 do 
  begin
    Item := Row.Cells[I];
    if Item = PreviewItem then
      if PreviewPlace = tlppTop then 
        Item.Top := 0
      else  
        Item.Top := NewHeight
    else
    begin
      if CellAutoHeight then 
        Item.Height := NewHeight;
      if HasPreview and (PreviewPlace = tlppTop) then 
        Item.Top := Item.Top + PreviewItem.Height;
    end;
  end;
end;

procedure TcxTreeListControlReportLinkNodeProducer.InitializeImage(AnIndex: Integer); 
begin
  Formatter.DoInitializeNodeImage(Image, Node, AnIndex);
end;

procedure TcxTreeListControlReportLinkNodeProducer.InitializeIndent(AnIndent: TdxReportCellExpandButton; 
  AnIndex: Integer);
begin
  Formatter.DoInitializeNodeIndent(AnIndent, AnIndex, IndentCount, Node);
  Formatter.DoReportLinkInitializeNodeIndent(AnIndent, AnIndex, IndentCount, Node);
end;

procedure TcxTreeListControlReportLinkNodeProducer.InitializeRow;
begin
  inherited;
  Formatter.DoInitializeNodeRow(Row, FNode);
end;

procedure TcxTreeListControlReportLinkNodeProducer.InitializeStateImage(AnIndex: Integer); 
begin
  Formatter.DoInitializeNodeStateImage(StateImage, Node, AnIndex);
  Formatter.DoReportLinkInitializeNodeStateImage(StateImage, Node, AnIndex);
end;

procedure TcxTreeListControlReportLinkNodeProducer.InitializeSubItem(ASubItem: TAbstractdxReportCellData; 
  AnIndex: Integer);
begin
  inherited;
  Formatter.DoInitializeNodeItem(ASubItem, Columns[AnIndex], Node, False);
  Formatter.DoReportLinkInitializeNodeItem(ASubItem, Columns[AnIndex], Node);
end;

function TcxTreeListControlReportLinkNodeProducer.IsItemIndent(AnItem: TdxReportVisualItem): Boolean;
begin
  Result := FIndents.IndexOf(AnItem) <> -1;
end;

function TcxTreeListControlReportLinkNodeProducer.GetAutoHeight: Boolean;
begin
  Result := CellAutoHeight or HasPreview;
end;

function TcxTreeListControlReportLinkNodeProducer.GetCellAutoHeight: Boolean;
begin
  Result := inherited GetAutoHeight and Adapter.CellAutoHeight;
end;

function TcxTreeListControlReportLinkNodeProducer.GetHasPreview: Boolean;
begin
  Result := Formatter.HasPreview;
end;

function TcxTreeListControlReportLinkNodeProducer.GetImageRect: TRect;
begin
  Result := MakeBounds(IndentWidth * IndentCount, 0, Adapter.GetImagesWidth(Node), RowHeight);
  OffsetRect(Result, Adapter.GetStateImagesWidth(Node), 0);
end;

function TcxTreeListControlReportLinkNodeProducer.GetIndentCount: Integer;
begin
  Result := Formatter.IndentCounts[Node];
end;

function TcxTreeListControlReportLinkNodeProducer.GetLineCount: Integer;
begin
  Result := Adapter.DetailsLineCount;
end;

function TcxTreeListControlReportLinkNodeProducer.GetLineHeight: Integer;
begin
  Result := Formatter.DetailsLineHeight;
end;

function TcxTreeListControlReportLinkNodeProducer.GetPreviewHeight: Integer;
begin
  Result := PreviewLineCount * PreviewLineHeight;
  if not (Formatter.PreviewAutoHeight and (Formatter.PreviewMaxLineCount = 0)) then 
    Inc(Result, 2 * dxTextSpace);
end;

function TcxTreeListControlReportLinkNodeProducer.GetPreviewIndent: Integer;
begin
  Result := IndentArea + Adapter.GetStateImagesWidth(Node) + Adapter.GetImagesWidth(Node);
end;

function TcxTreeListControlReportLinkNodeProducer.GetPreviewLineCount: Integer;
begin
  if FPreviewItem <> nil then
    if not Formatter.PreviewAutoHeight then 
    begin
      Result := PreviewItem.CalculateLineCount(Formatter.DC);
      if Result <> Formatter.PreviewMaxLineCount then 
        Result := Formatter.PreviewMaxLineCount;
    end
    else
      Result := 1
  else
    Result := 0;    
end;

function TcxTreeListControlReportLinkNodeProducer.GetPreviewLineHeight: Integer;
var
  LineHeight: Integer;
begin
  if FPreviewItem <> nil then
    if Formatter.PreviewAutoHeight then
    begin
      Result := PreviewItem.MeasureContentHeight(Formatter.DC);
      if Formatter.PreviewMaxLineCount <> 0 then
      begin
        LineHeight := PreviewItem.MeasureFontHeight(Formatter.DC) - 2 * dxTextSpace;
        if Result > LineHeight * Formatter.PreviewMaxLineCount then 
          Result := LineHeight * Formatter.PreviewMaxLineCount;
      end;    
    end  
    else
      Result := PreviewItem.MeasureFontHeight(Formatter.DC) - 2 * dxTextSpace
  else
    Result := 0;  
end;

function TcxTreeListControlReportLinkNodeProducer.GetStateImageRect: TRect;
begin
  Result := MakeBounds(IndentWidth * IndentCount, 0, Adapter.GetStateImagesWidth(Node), RowHeight);
end;

function TcxTreeListControlReportLinkNodeProducer.GetSubItemBound(Index: Integer): TRect;
begin
  Result := Formatter.GetNodeItemBounds(Node, Index, IndentCount);
end;

function TcxTreeListControlReportLinkNodeProducer.GetSubItemClass(Index: Integer): TdxReportCellDataClass;
begin
  Result := Formatter.GetNodeItemClass(Columns[Index], Node, False);
end;

function TcxTreeListControlReportLinkNodeProducer.GetImageIndentIndex: Integer;
begin
  Result := IndentCount;
  if Adapter.HasStateImages(Node) then Inc(Result);
end;

function TcxTreeListControlReportLinkNodeProducer.GetIndent(Index: Integer): TdxReportCellExpandButton;
begin
  Result := FIndents[Index];
end;

function TcxTreeListControlReportLinkNodeProducer.GetIndentArea: Integer;
begin
  Result := IndentCount * IndentWidth;
end;

function TcxTreeListControlReportLinkNodeProducer.GetIndentBound(Index: Integer): TRect;
begin
  Result := MakeBounds(IndentWidth * Index, 0, IndentWidth, RowHeight);
end;

function TcxTreeListControlReportLinkNodeProducer.GetPreviewColumn: TcxTreeListColumn;
begin
  Result := Adapter.PreviewColumn;
end;

function TcxTreeListControlReportLinkNodeProducer.GetPreviewPlace: TcxTreeListPreviewPlace;
begin
  Result := Adapter.PreviewPlace;
end;

function TcxTreeListControlReportLinkNodeProducer.GetStateImageIndentIndex: Integer;
begin
  Result := IndentCount;
end;

{ TcxTreeListControlReportLinkCategorizedNodeProducer }

function TcxTreeListControlReportLinkCategorizedNodeProducer.GetSubItemBound(Index: Integer): TRect;
begin
  Result := MakeRect(IndentWidth * IndentCount + Adapter.GetImagesWidth(Node) +
    Adapter.GetStateImagesWidth(Node), 0, RowWidth, RowHeight);
end;

function TcxTreeListControlReportLinkCategorizedNodeProducer.GetSubItemCount: Integer;
begin
  Result := 1;
end;

procedure TcxTreeListControlReportLinkCategorizedNodeProducer.InitializeSubItem(
  ASubItem: TAbstractdxReportCellData; AnIndex: Integer);
begin
  AnIndex := Adapter.CategorizedColumn.VisibleIndex;
  inherited InitializeSubItem(ASubItem, AnIndex);
end;

{ TcxTreeListNodeHelper }

constructor TcxTreeListNodeHelper.Create(AnAdapter: TcxTreeListControlAdapter);
begin
  inherited Create;
  FAdapter := AnAdapter;
end;

class function TcxTreeListNodeHelper.PairClass: TClass;
begin
  Result := NodeClass;
end;

class function TcxTreeListNodeHelper.ProducerClass: TcxTreeListControlReportLinkNodeProducerClass;
begin
  Result := TcxTreeListControlReportLinkNodeProducer;
end;

class procedure TcxTreeListNodeHelper.Register;
begin
  cxTreeListNodeHelperFactory.Register(Self);
end;

class procedure TcxTreeListNodeHelper.Unregister;
begin
  cxTreeListNodeHelperFactory.Unregister(Self);
end;

function TcxTreeListNodeHelper.Adapter: TcxTreeListControlAdapter;
begin
  Result := FAdapter;
end;

function TcxTreeListNodeHelper.GetHasSelectedChildren: Boolean;
var
  SaveNode: TcxTreeListNode;
  I: Integer;
begin
  Result := True;
  SaveNode := Node;
  try
    with Node do 
      for I := 0 to Count - 1 do          
      begin
        Node := Items[I];
        if Node.Selected or Adapter.Helpers[Node].HasSelectedChildren then Exit;
      end;
  finally
    Node := SaveNode;
  end;
  Result := False;
end;

function TcxTreeListNodeHelper.GetHasSelectedParents: Boolean;
var
  Parent: TcxTreeListNode;
begin
  Parent := Node;
  while (Parent <> nil) and not Parent.Selected do 
    Parent := Parent.Parent;
  Result := Parent <> nil;  
end;

class function TcxTreeListNodeHelper.NodeClass: TcxTreeListNodeClass;
begin
  Result := TcxTreeListNode;
end;

{ TcxTreeListNodeHelperCache }

constructor TcxTreeListNodeHelperCache.Create(AnAdapter: TcxTreeListControlAdapter);
begin
  inherited Create;
  FAdapter := AnAdapter;
end;

function TcxTreeListNodeHelperCache.IndexOf(Node: TcxTreeListNode): Integer;
begin
  for Result := 0 to Count - 1 do
    if Items[Result].NodeClass = Node.ClassType then Exit;
    
  Result := Add(cxTreeListNodeHelperFactory.HelperClasses[Node].Create(Adapter));
end;

function TcxTreeListNodeHelperCache.GetHelper(Node: TcxTreeListNode): TcxTreeListNodeHelper;
begin
  Result := Items[IndexOf(Node)];
  Result.Node := Node;
end;

function TcxTreeListNodeHelperCache.GetItem(Index: Integer): TcxTreeListNodeHelper;
begin
  Result := TcxTreeListNodeHelper(inherited Items[Index]);
end;

{ TcxTreeListControlReportLinkProducerCache }

constructor TcxTreeListControlReportLinkProducerCache.Create(ABuilder: TcxTreeListControlReportLinkBuilder);
begin
  inherited Create;
  FBuilder := ABuilder;
end;

function TcxTreeListControlReportLinkProducerCache.IndexOf(AProducerClass: TcxTreeListControlReportLinkRowProducerClass): Integer;
begin
  for Result := 0 to Count - 1 do
    if Items[Result].ClassType = AProducerClass then Exit;

  Result := Add(AProducerClass.Create(Builder));
end;

function TcxTreeListControlReportLinkProducerCache.GetProducer(ProducerClass: TcxTreeListControlReportLinkRowProducerClass): TcxTreeListControlReportLinkRowProducer;
begin
  Result := Items[IndexOf(ProducerClass)];
end;

function TcxTreeListControlReportLinkProducerCache.GetItem(Index: Integer): TcxTreeListControlReportLinkRowProducer;
begin
  Result := TcxTreeListControlReportLinkRowProducer(inherited Items[Index]);
end;

{ TcxTreeListControlReportLinkBuilder }

constructor TcxTreeListControlReportLinkBuilder.Create(AReportLink: TcxTreeListControlReportLink);
begin
  inherited Create;
  FReportLink := AReportLink;
  FAdapter := AdapterClass.Create(Self);
  FFormatter := FormatterClass.Create(Self);
  FProducerCache := TcxTreeListControlReportLinkProducerCache.Create(Self);
  FReportRows := TList.Create;
  Adapter.Calculate(AvailableWidth, AutoWidth);
end;

destructor TcxTreeListControlReportLinkBuilder.Destroy;
begin
  FreeAndNil(FReportRows);
  FreeAndNil(FProducerCache);
  FreeAndNil(FFormatter);
  FreeAndNil(FAdapter);
  inherited;
end;

procedure TcxTreeListControlReportLinkBuilder.Build;
begin
  BeforeBuilding;
  try
    DoBuild;
  finally
    AfterBuilding;
  end;
end;

procedure TcxTreeListControlReportLinkBuilder.Progress(const APercentDone: Double);
begin
  ReportLink.DoProgress(APercentDone);
end;

function TcxTreeListControlReportLinkBuilder.Adapter: TcxTreeListControlAdapter;
begin
  Result := FAdapter;
end;

class function TcxTreeListControlReportLinkBuilder.AdapterClass: TcxTreeListControlAdapterClass;
begin
  Result := TcxTreeListControlAdapter;
end;

function TcxTreeListControlReportLinkBuilder.Formatter: TcxTreeListControlReportLinkFormatter;
begin
  Result := FFormatter;
end;

class function TcxTreeListControlReportLinkBuilder.FormatterClass: TcxTreeListControlReportLinkFormatterClass;
begin
  Result := TcxTreeListControlReportLinkFormatter;
end;

procedure TcxTreeListControlReportLinkBuilder.AddReportRow(ARow: TdxReportCell);
begin
  if ARow.Parent = ReportLink.ReportCells.Cells then
    FReportRows.Add(ARow);
end;

procedure TcxTreeListControlReportLinkBuilder.AfterBuilding;
begin
  Formatter.AfterBuilding;
  Adapter.AfterBuilding;
end;

procedure TcxTreeListControlReportLinkBuilder.BeforeBuilding;
begin
  Adapter.BeforeBuilding;
  Formatter.BeforeBuilding;
end;

procedure TcxTreeListControlReportLinkBuilder.CreateBands;
begin
  AddReportRow(GetBandsProducer.Produce(ReportLink.HostInfoServices.BandHeadersHostInfo));
end;

function TcxTreeListControlReportLinkBuilder.GetBandsProducer: TcxTreeListControlReportLinkBandsProducer;
begin
  Result := ProducerCache[GetBandsProducerClass] as TcxTreeListControlReportLinkBandsProducer;
end;

function TcxTreeListControlReportLinkBuilder.GetBandsProducerClass: TcxTreeListControlReportLinkBandsProducerClass;
begin
  Result := TcxTreeListControlReportLinkBandsProducer;
end;

procedure TcxTreeListControlReportLinkBuilder.CreateFooters;
begin
  AddReportRow(GetFootersProducer.Produce(ReportLink.HostInfoServices.FootersHostInfo));
end;

function TcxTreeListControlReportLinkBuilder.GetFootersProducer: TcxTreeListControlReportLinkFootersProducer;
begin
  Result := ProducerCache[GetFootersProducerClass] as TcxTreeListControlReportLinkFootersProducer;
end;

function TcxTreeListControlReportLinkBuilder.GetFootersProducerClass: TcxTreeListControlReportLinkFootersProducerClass;
begin
  Result := TcxTreeListControlReportLinkFootersProducer;
end;

procedure TcxTreeListControlReportLinkBuilder.CreateHeaders;
begin
  AddReportRow(GetHeadersProducer.Produce(ReportLink.HostInfoServices.HeadersHostInfo));
end;

function TcxTreeListControlReportLinkBuilder.GetHeadersProducer: TcxTreeListControlReportLinkHeadersProducer;
begin
  Result := ProducerCache[GetHeadersProducerClass] as TcxTreeListControlReportLinkHeadersProducer;
end;

function TcxTreeListControlReportLinkBuilder.GetHeadersProducerClass: TcxTreeListControlReportLinkHeadersProducerClass;
begin
  Result := TcxTreeListControlReportLinkHeadersProducer;
end;

procedure TcxTreeListControlReportLinkBuilder.CreateNode(ANode: TcxTreeListNode);
begin
  AddReportRow(GetNodeProducer(ANode).Produce(ReportLink.HostInfoServices.PageDetailsHostInfo, ANode));
end;

procedure TcxTreeListControlReportLinkBuilder.CreateNodes;
var
  HasNodeSeparator: Boolean;
  I: Integer;
  Node: TcxTreeListNode;
begin
  HasNodeSeparator := Formatter.HasNodeSeparator;
  for I := 0 to Formatter.NodeCount - 1 do 
  begin
    Node := Formatter.Nodes[I];
    CreateNode(Node);
    if HasNodeSeparator and (I < Formatter.NodeCount - 1) then 
      CreateNodeSeparator(Node);
    
    Progress(100 * (I + 1) / Formatter.NodeCount);
    if IsAborted then Break;
  end;  
end;

function TcxTreeListControlReportLinkBuilder.GetNodeProducer(ANode: TcxTreeListNode): TcxTreeListControlReportLinkNodeProducer;
begin
  Result := ProducerCache[GetNodeProducerClass(ANode)] as TcxTreeListControlReportLinkNodeProducer;
end;

function TcxTreeListControlReportLinkBuilder.GetNodeProducerClass(ANode: TcxTreeListNode): TcxTreeListControlReportLinkNodeProducerClass;
begin
  if Adapter.IsGroupNode(ANode) then
    Result := TcxTreeListControlReportLinkCategorizedNodeProducer
  else
    Result := Adapter.Helpers[ANode].ProducerClass;
end;

procedure TcxTreeListControlReportLinkBuilder.CreateNodeSeparator(ANode: TcxTreeListNode);
begin
  AddReportRow(GetNodeSeparatorProducer.Produce(ReportLink.HostInfoServices.PageDetailsHostInfo));
end;

function TcxTreeListControlReportLinkBuilder.GetNodeSeparatorProducer: TcxTreeListControlReportLinkNodeSeparatorProducer;
begin
  Result := ProducerCache[GetNodeSeparatorProducerClass] as TcxTreeListControlReportLinkNodeSeparatorProducer;
end;

function TcxTreeListControlReportLinkBuilder.GetNodeSeparatorProducerClass: TcxTreeListControlReportLinkNodeSeparatorProducerClass;
begin
  Result := TcxTreeListControlReportLinkNodeSeparatorProducer;
end;

procedure TcxTreeListControlReportLinkBuilder.DoBuild;
begin
  if Formatter.ShowBandHeaders then CreateBands;
  if Formatter.ShowHeaders then CreateHeaders;
  CreateNodes;
  
  if not IsAborted and Formatter.ShowFooters then 
    CreateFooters;
end;

function TcxTreeListControlReportLinkBuilder.IsAborted: Boolean;
begin
  Result := ReportLink.AbortBuilding;
end;

function TcxTreeListControlReportLinkBuilder.GetAutoWidth: Boolean;
begin
  Result := ReportLink.OptionsSize.AutoWidth;
end;

function TcxTreeListControlReportLinkBuilder.GetAvailableWidth: Integer;
var
  ControllerIntf: IdxReportLinkController;
  R: TRect;
begin
  if Formatter.AutoWidth then
    if ReportLink.IsAggregated and
      Supports(TObject(ReportLink.Controller), IdxReportLinkController, ControllerIntf) then
      R := ControllerIntf.GetControlSiteBounds(ReportLink.TreeListControl)
    else
      R := ReportLink.RealPrinterPage.PaintRectPixels
  else
    R := TreeListControl.ClientBounds;
       
  Result := R.Right - R.Left - 1;
end;

function TcxTreeListControlReportLinkBuilder.GetHost: TdxReportCell;
begin
  Result := ReportLink.ReportCells.Cells;
end;

function TcxTreeListControlReportLinkBuilder.GetReportCells: TdxReportCells;
begin
  Result := ReportLink.ReportCells;
end;

function TcxTreeListControlReportLinkBuilder.GetReportRow(Index: Integer): TdxReportCell;
begin
  Result := TdxReportCell(FReportRows[Index]);
end;

function TcxTreeListControlReportLinkBuilder.GetReportRowCount: Integer;
begin
  Result := FReportRows.Count;
end;

function TcxTreeListControlReportLinkBuilder.GetTreeListControl: TcxCustomTreeListControl;
begin
  Result := ReportLink.TreeListControl;
end;    

{ TcxTreeListReportLinkBuilderHandler }

constructor TcxTreeListReportLinkBuilderHandler.Create(ABuilder: TcxTreeListControlReportLinkBuilder);
begin
  inherited Create;
  FBuilder := ABuilder;
end;

function TcxTreeListReportLinkBuilderHandler.Builder: TcxTreeListControlReportLinkBuilder;
begin
  Result := FBuilder;
end;

function TcxTreeListReportLinkBuilderHandler.GetReportLink: TcxTreeListControlReportLink;
begin
  Result := Builder.ReportLink;
end;

{ TcxTreeListControlAdapter }

constructor TcxTreeListControlAdapter.Create(ABuilder: TcxTreeListControlReportLinkBuilder);
begin
  inherited;
  FHelperCache := TcxTreeListNodeHelperCache.Create(Self);
  FBandLineCount := 1;
  FDetailsLineCount := 1;
  FFooterLineCount := 1;
end;

destructor TcxTreeListControlAdapter.Destroy;
begin
  FreeAndNil(FHelperCache);
  inherited;
end;

procedure TcxTreeListControlAdapter.AfterBuilding;
begin
end;

procedure TcxTreeListControlAdapter.BeforeBuilding;
begin
end;

procedure TcxTreeListControlAdapter.AfterCalculate;
begin
end;

procedure TcxTreeListControlAdapter.BeforeCalculate;
begin
  SetLength(FBandPlaces, 0);
  SetLength(FBandWidths, 0);
  SetLength(FColumnPlaces, 0);
  SetLength(FColumnWidths, 0);
end;

procedure TcxTreeListControlAdapter.Calculate(AAvailableWidth: Integer; AnAutoWidth: Boolean);
begin
  AvailableWidth := AAvailableWidth;
  AutoWidth := AnAutoWidth;

  BeforeCalculate;
  try
    DoCalculate;
  finally
    AfterCalculate;
  end;
end;

procedure TcxTreeListControlAdapter.CalculateBandPlaces;
var
  I, Origin: Integer;
begin
  SetLength(FBandPlaces, BandCount);

  Origin := 0;
  for I := 0 to BandCount - 1 do 
  begin
    FBandPlaces[I] := MakeRect(Origin, 0, BandWidths[I], 0);
    Inc(Origin, BandWidths[I]);
  end  
end;

procedure TcxTreeListControlAdapter.CalculateBandWidths;
var
  I: Integer;
begin
  SetLength(FBandWidths, BandCount);

  for I := 0 to BandCount - 1 do 
    if AutoWidth then
      FBandWidths[I] := Bands[I].DisplayWidth
    else
      FBandWidths[I] := Bands[I].Width;
end;

procedure TcxTreeListControlAdapter.CalculateColumnPlaces;
var
  BandIndex, RowIndex, ColIndex, BandOrigin, ColumnOrigin, ColumnWidth: Integer;
  BandRows: TcxTreeListBandRows;
  BandRow: TcxTreeListBandRow;  
  Column: TcxTreeListColumn;
begin
  SetLength(FColumnPlaces, ColumnCount);
  SetLength(FBandPlaces, BandCount);       

  for BandIndex := 0 to BandCount - 1 do
  begin
    BandOrigin := BandOrigins[BandIndex];
    BandRows := Bands[BandIndex].BandRows;
    for RowIndex := 0 to BandRows.Count - 1 do
    begin
      ColumnOrigin := BandOrigin;
      BandRow := BandRows.Items[RowIndex];
      for ColIndex := 0 to BandRow.Count - 1 do 
      begin
        Column := BandRow.Items[ColIndex];
        ColumnWidth := ColumnWidths[Column.VisibleIndex];
        with FColumnPlaces[Column.VisibleIndex] do
        begin
          Left := ColumnOrigin;
          Right := ColumnOrigin + ColumnWidth;
          RowIndex := BandRow.LineOffset;//Index; //TODO: BandRow.VisibleIndex;
          LineCount := Column.Position.LineCount;
        end;
        Inc(ColumnOrigin, ColumnWidth);
      end;  
    end;  
    FBandPlaces[BandIndex] := MakeBounds(BandOrigin, 0, BandWidths[BandIndex], 0);  
  end;  
end;

procedure TcxTreeListControlAdapter.CalculateColumnWidths;

  procedure CalculateBandWidths;

    procedure CalculateBandWidths(ABand: TcxTreeListBand; var AMinWidth, AWidth: Integer);
    var
      RowMinWidth, RowWidth, RowIndex, ColIndex: Integer;
      NeedCalculateWidth: Boolean;
      Row: TcxTreeListBandRow;
      Column: TcxTreeListColumn;
    begin
      AMinWidth := 0;
      AWidth := ABand.Width;
      NeedCalculateWidth := AWidth = 0;//cxTL.cxTreeListDefWidth; //TODO: CalculateBandWidths !?
                                           
      if ABand.BandRows.Count <> 0 then
      begin
        for RowIndex := 0 to ABand.BandRows.Count - 1 do
        begin
          Row := ABand.BandRows.Items[RowIndex];
          
          RowMinWidth := 0;
          RowWidth := 0;
          for ColIndex := 0 to Row.Count - 1 do
          begin
            Column := Row.Items[ColIndex];
            //Inc(RowMinWidth, Column.MinWidth);
            //if Column.IsLeftMost then
            //  Inc(RowMinWidth, IndentWidth);
            Inc(RowMinWidth, Column.RealMinWidth); 
            if NeedCalculateWidth then 
              Inc(RowWidth, Column.DisplayWidth);  // TODO: GetColumnWidth
          end;  
                                              
          if RowMinWidth > AMinWidth then AMinWidth := RowMinWidth;
          if RowWidth > AWidth then AWidth := RowWidth;
        end;
        if AWidth < AMinWidth then AWidth := AMinWidth;
      end  
      else
        if NeedCalculateWidth then AWidth := cxTL.cxTreeListDefWidth;
    end;

    procedure AssignBandWidths;
    var
      I, MinWidth, Width: Integer;
    begin
      for I := 0 to BandCount - 1 do
      begin
        CalculateBandWidths(Bands[I], MinWidth, Width);
        FBandWidths[I] := Width;
      end;  
    end;

    procedure CalculateBandAutoWidths;
    var
      AutoWidthObject: cxClasses.TcxAutoWidthObject;
      I, MinWidthValue, WidthValue: Integer;
      Band: TcxTreeListBand;
      AutoWidthItem: cxClasses.TcxAutoWidthItem;
     begin
      AutoWidthObject := cxClasses.TcxAutoWidthObject.Create(BandCount);
      try
        for I := 0 to BandCount - 1 do
        begin
          Band := Bands[I];            
          CalculateBandWidths(Band, MinWidthValue, WidthValue);
          AutoWidthItem := AutoWidthObject.AddItem;
          with AutoWidthItem do
          begin
            Width := WidthValue;
            MinWidth := MinWidthValue;
            Fixed := not Band.Options.Sizing;
          end;
        end;  
        AutoWidthObject.AvailableWidth := AvailableWidth;
        AutoWidthObject.Calculate;
        for I := 0 to BandCount - 1 do
          FBandWidths[I]:= AutoWidthObject[I].AutoWidth;
      finally
        AutoWidthObject.Free;
      end;
    end;

  begin
    if AutoWidth or OptionsView.ColumnAutoWidth then 
      CalculateBandAutoWidths
    else
      AssignBandWidths;
  end;

  procedure CalculateBandColumnWidths;  
                                                  
    procedure CalculateBandRowColumnWidths(ABand: TcxTreeListBand; ABandWidth: Integer; 
      ABandRow: TcxTreeListBandRow);
    var
      AutoWidthObject: cxClasses.TcxAutoWidthObject;
      I, ColumnIndex: Integer;
      AutoWidthItem: cxClasses.TcxAutoWidthItem;
    begin
      AutoWidthObject := cxClasses.TcxAutoWidthObject.Create(ABandRow.Count);
      try
        for I := 0 to ABandRow.Count - 1 do
        begin
          AutoWidthItem := AutoWidthObject.AddItem;
          with ABandRow.Items[I] do
          begin
            AutoWidthItem.Width := ABandRow.Items[I].DisplayWidth;
            AutoWidthItem.MinWidth := ABandRow.Items[I].RealMinWidth;
            AutoWidthItem.Fixed := ABand.FixedKind <> tlbfNone;
          end;
        end;
        AutoWidthObject.AvailableWidth := ABandWidth;
        AutoWidthObject.Calculate;
        
        for I := 0 to ABandRow.Count - 1 do
        begin
          ColumnIndex := ABandRow.Items[I].VisibleIndex;
          FColumnWidths[ColumnIndex]:= AutoWidthObject[I].AutoWidth;
        end;  
      finally
        AutoWidthObject.Free;
      end;
    end;
    
  var
    BandIndex, RowIndex, BandWidth: Integer;
    Band: TcxTreeListBand;
  begin
    for BandIndex := 0 to BandCount - 1 do
    begin
      BandWidth := BandWidths[BandIndex];
      Band := Bands[BandIndex];
      for RowIndex := 0 to Band.BandRows.Count - 1 do
        CalculateBandRowColumnWidths(Band, BandWidth, Band.BandRows.Items[RowIndex]);
    end;    
  end;
  
begin
  SetLength(FBandWidths, BandCount);
  SetLength(FColumnWidths, ColumnCount);
  
  CalculateBandWidths;
  CalculateBandColumnWidths;
end;

procedure TcxTreeListControlAdapter.CalculateLineCounts;
begin               
  BandLineCount := OptionsView.BandLineCount;                
  DetailsLineCount := CustomTreeListControl_GetHeaderLineCount(TreeListControl);
  FooterLineCount := CustomTreeListControl_GetHeaderLineCount(TreeListControl);
end;

procedure TcxTreeListControlAdapter.DoCalculate;
begin
  CalculateLineCounts;
  CalculateBandWidths;
  CalculateBandPlaces;
  CalculateColumnWidths;
  CalculateColumnPlaces;
end;

class function TcxTreeListControlAdapter.GetProperties(AColumn: TcxTreeListColumn;
  ANode: TcxTreeListNode): TcxCustomEditProperties;
begin
  Result := TreeListColumn_DoGetEditProperties(AColumn, ANode);
  if Result = nil then 
    Result := GetRepositoryItem(AColumn, ANode).Properties;
end;
  
class function TcxTreeListControlAdapter.GetPropertiesClass(AColumn: TcxTreeListColumn;
  ANode: TcxTreeListNode): TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomEditPropertiesClass(GetProperties(AColumn, ANode).ClassType);
end;

class function TcxTreeListControlAdapter.GetRepositoryItem(AColumn: TcxTreeListColumn;
  ANode: TcxTreeListNode): TcxEditRepositoryItem;
begin
  Result := AColumn.RepositoryItem; 
end;

function TcxTreeListControlAdapter.GetBackgroundViewParams: TcxViewParams;
begin
  Result := Styles.GetBackgroundParams;
end;

function TcxTreeListControlAdapter.GetBandBackgroundViewParams: TcxViewParams;
begin
  Result := Styles.GetBandBackgroundParams(nil);
end;

function TcxTreeListControlAdapter.GetBandHeaderViewParams(ABand: TcxTreeListBand): TcxViewParams;
begin
  Result := Styles.GetBandHeaderParams(ABand);
  if ABand = nil then
    Result.Color := LookAndFeelPainter.DefaultHeaderBackgroundColor
end;

function TcxTreeListControlAdapter.GetContentViewParams(ANode: TcxTreeListNode; 
  AColumn: TcxTreeListColumn): TcxViewParams; 
begin
  Result := Styles.GetContentParams(ANode, AColumn);
  // v3.2
  if Result.Color = clWindow then
    Result.Color := dxPSCore.dxDefaultContentColor;
end;
  
function TcxTreeListControlAdapter.GetColumnFooterViewParams(AColumn: TcxTreeListColumn): TcxViewParams;
begin
  Result := Styles.GetColumnFooterParams(AColumn);
  Result.Color := LookAndFeelPainter.DefaultHeaderColor
end;

function TcxTreeListControlAdapter.GetColumnHeaderViewParams(AColumn: TcxTreeListColumn): TcxViewParams;
begin
  if AColumn = nil then
  begin
    FillChar(Result, SizeOf(Result), 0);
    Result.Color := LookAndFeelPainter.DefaultHeaderBackgroundColor;
  end
  else
    Result := Styles.GetColumnHeaderParams(AColumn);
end;

function TcxTreeListControlAdapter.GetIndentViewParams(ANode: TcxTreeListNode; 
  AnIndent: Integer): TcxViewParams;
begin
  Result := Styles.GetIndentParams(ANode, AnIndent);
  // v3.2
  if Result.Color = clWindow then
    Result.Color := dxPSCore.dxDefaultContentColor;
end;

function TcxTreeListControlAdapter.GetPreviewViewParams(ANode: TcxTreeListNode; 
  AColumn: TcxTreeListColumn): TcxViewParams;
begin
  Result := Styles.GetPreviewParams(ANode);
  // v3.2
  if Result.Color = clWindow then
    Result.Color := dxPSCore.dxDefaultContentColor;
end;

function TcxTreeListControlAdapter.GetFooterRowViewParams: TcxViewParams;
begin
  Result := Styles.GetFooterParams;
end;

function TcxTreeListControlAdapter.GetSelectionViewParams: TcxViewParams; 
begin
  FillChar(Result, SizeOf(Result), 0);
  with Styles.Selection do
  begin
    Result.Bitmap := nil;
    Result.Color := Color;
    Result.Font := Font;
    Result.TextColor := TextColor;
  end;
end;

function TcxTreeListControlAdapter.HasSelectionStyle: Boolean;
begin
  Result := Styles.Selection <> nil;
end;
  
function TcxTreeListControlAdapter.GetBackgroundBitmap(Index: Integer): TBitmap;
begin
  Result := Styles.GetBitmap(Index);
end;

function TcxTreeListControlAdapter.HasBackgroundBitmap(Index: Integer): Boolean;
begin
  Result := GetBackgroundBitmap(Index) <> nil;
end;

function TcxTreeListControlAdapter.GetImagesHeight(ANode: TcxTreeListNode): Integer;
begin
  if HasImages(ANode) then 
    Result := 1 + Images.Height + 1
  else
    Result := 0;
end;

function TcxTreeListControlAdapter.GetImagesWidth(ANode: TcxTreeListNode): Integer;
begin
  if HasImages(ANode) then 
    Result := 1 + Images.Width + 1
  else
    Result := 0;
end;

function TcxTreeListControlAdapter.GetStateImagesHeight(ANode: TcxTreeListNode): Integer;
begin
  if HasStateImages(ANode) then  
    Result := 1 + StateImages.Height + 1
  else
    Result := 0;
end;

function TcxTreeListControlAdapter.GetStateImagesWidth(ANode: TcxTreeListNode): Integer;
begin
  if HasStateImages(ANode) then 
    Result := 1 + StateImages.Width + 1
  else
    Result := 0;
end;

function TcxTreeListControlAdapter.HasImages(ANode: TcxTreeListNode): Boolean;
begin
  Result := Images <> nil;
  if Result and (ANode <> nil) then 
    Result := (ANode.ImageIndex > -1) and (ANode.ImageIndex < Images.Count);
end;

function TcxTreeListControlAdapter.HasStateImages(ANode: TcxTreeListNode): Boolean;
begin
  Result := StateImages <> nil;
  if Result and (ANode <> nil) then 
    Result := (ANode.StateIndex > -1) and (ANode.StateIndex < StateImages.Count);
end;

function TcxTreeListControlAdapter.IsGroupNode(ANode: TcxTreeListNode): Boolean; 
begin
  Result := CustomTreeListControl_DoIsGroupNode(TreeListControl, ANode);
end;

function TcxTreeListControlAdapter.GetBand(Index: Integer): TcxTreeListBand;
begin
  Result := CustomTreeListControl_GetVisibleBand(TreeListControl, Index);
end;

function TcxTreeListControlAdapter.GetBandCount: Integer;
begin
  Result := CustomTreeListControl_GetVisibleBandCount(TreeListControl);
end;

function TcxTreeListControlAdapter.GetBandOrigin(Index: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Index - 1 do
    Inc(Result, BandWidths[I]);
end;

function TcxTreeListControlAdapter.GetBandPlace(Index: Integer): TRect;
begin
  Result := FBandPlaces[Index];
end;

function TcxTreeListControlAdapter.GetBandWidth(Index: Integer): Integer;
begin
  Result := FBandWidths[Index];
end;

function TcxTreeListControlAdapter.GetCanUseLookAndFeelColors: Boolean;
begin
  Result := CustomTreeListControl_GetLookAndFeel(TreeListControl).NativeStyle and 
    dxThemeManager.AreVisualStylesAvailable;
end;

function TcxTreeListControlAdapter.GetCategorizedColumn: TcxTreeListColumn;
begin
  Result := OptionsView.GetCategorizedColumn;
end;

function TcxTreeListControlAdapter.GetColumnCount: Integer;
begin
  Result := CustomTreeListControl_GetVisibleColumnCount(TreeListControl);
end;

function TcxTreeListControlAdapter.GetCellAutoHeight: Boolean;
begin
  Result := OptionsView.CellAutoHeight and (DetailsLineCount = 1);
end;

function TcxTreeListControlAdapter.GetCellEndEllipsis: Boolean; 
begin
  Result := OptionsView.CellEndEllipsis;
end;

function TcxTreeListControlAdapter.GetCellMultiline: Boolean;
begin
  Result := OptionsView.CellAutoHeight and (DetailsLineCount = 1);
end;

function TcxTreeListControlAdapter.GetColumn(Index: Integer): TcxTreeListColumn;
begin
  Result := CustomTreeListControl_GetVisibleColumn(TreeListControl, Index);
end;

function TcxTreeListControlAdapter.GetColumnPlace(Index: Integer): TdxTLColumnPlace;
begin
  Result := FColumnPlaces[Index];
end;

function TcxTreeListControlAdapter.GetColumnWidth(Index: Integer): Integer;
begin
  Result := FColumnWidths[Index];
end;

function TcxTreeListControlAdapter.GetDefaultRowHeight: Integer;
begin
  Result := TreeListControl.DefaultRowHeight;
end;

function TcxTreeListControlAdapter.GetFooterItemText(Index: Integer): string;
begin
  Result := Columns[Index].SummaryFooter.SummaryText;
end;

function TcxTreeListControlAdapter.GetGridLines: TcxTreeListGridLines;
begin
  Result := OptionsView.GridLines;
end;

function TcxTreeListControlAdapter.GetGridLinesColor: TColor;
begin
  Result := OptionsView.GridLineColor;
end;

function TcxTreeListControlAdapter.GetHasFooterItem(Index: Integer): Boolean;
begin
  Result := Columns[Index].Options.Footer;
end;

function TcxTreeListControlAdapter.GetHasPreview: Boolean;
begin
  Result := PreviewColumn <> nil;
end;

function TcxTreeListControlAdapter.GetHeaderAutoHeight: Boolean;
begin
  Result := (DetailsLineCount = 1) and OptionsView.CellAutoHeight;
end;

function TcxTreeListControlAdapter.GetHelper(Node: TcxTreeListNode): TcxTreeListNodeHelper;
begin
  Result := FHelperCache.Helpers[Node];
end;

function TcxTreeListControlAdapter.GetIndentWidth: Integer;
begin
  Result := GetStateImagesWidth(nil);
  if GetImagesWidth(nil) > GetStateImagesWidth(nil) then 
    Result := GetImagesWidth(nil);
  if Result = 0 then 
    Result := DefaultIndentWidth;
end;

function TcxTreeListControlAdapter.GetIsDefaultRowHeightAssigned: Boolean;
begin
  Result := DefaultRowHeight <> 0;
end;

function TcxTreeListControlAdapter.GetImages: TCustomImageList;
begin
  Result := CustomTreeListControl_GetImages(TreeListControl);
end;

function TcxTreeListControlAdapter.GetIsNodeColorUsedForIndents: Boolean;
begin
  Result := OptionsView.UseNodeColorForIndent;
end;

function TcxTreeListControlAdapter.GetLookAndFeelKind: TcxLookAndFeelKind;
begin
  Result := CustomTreeListControl_GetLookAndFeel(TreeListControl).Kind;
end;

function TcxTreeListControlAdapter.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := CustomTreeListControl_GetLookAndFeelPainter(TreeListControl);
end;

function TcxTreeListControlAdapter.GetMultiSelection: Boolean;
begin
  Result := CustomTreeListControl_GetOptionsSelection(TreeListControl).MultiSelect;
end;

function TcxTreeListControlAdapter.GetNode(Index: Integer): TcxTreeListNode;
begin
  Result := CustomTreeListControl_GetNodes(TreeListControl).Root[Index];
end;

function TcxTreeListControlAdapter.GetNodeCount: Integer;
begin
  Result := CustomTreeListControl_GetNodes(TreeListControl).Root.Count;
end;

function TcxTreeListControlAdapter.GetOptionsView: TcxTreeListOptionsView;
begin
  Result := CustomTreeListControl_GetOptionsView(TreeListControl);
end;

function TcxTreeListControlAdapter.GetPaintStyle: TcxTreeListPaintStyle;
begin
  Result := OptionsView.PaintStyle;
end;

function TcxTreeListControlAdapter.GetPreviewColumn: TcxTreeListColumn;
begin
  Result := CustomTreeListControl_GetPreview(TreeListControl).Column;
end;

function TcxTreeListControlAdapter.GetPreviewLeftIndent: Integer;
begin
  Result := CustomTreeListControl_GetPreview(TreeListControl).LeftIndent;
end;

function TcxTreeListControlAdapter.GetPreviewPlace: TcxTreeListPreviewPlace;
begin
  Result := CustomTreeListControl_GetPreview(TreeListControl).Place;
end;

function TcxTreeListControlAdapter.GetPreviewRightIndent: Integer;
begin
  Result := CustomTreeListControl_GetPreview(TreeListControl).RightIndent;
end;

function TcxTreeListControlAdapter.GetShowRoot: Boolean;
begin
  Result := OptionsView.ShowRoot;
end;

function TcxTreeListControlAdapter.GetShowHorzGridLines: Boolean;
begin
  Result := GridLines in [tlglHorz, tlglBoth];
end;

function TcxTreeListControlAdapter.GetShowTreeLines: Boolean;
begin
  Result := OptionsView.TreeLineStyle <> tllsNone;
end;

function TcxTreeListControlAdapter.GetShowVertGridLines: Boolean;
begin
  Result := GridLines in [tlglVert, tlglBoth];
end;

function TcxTreeListControlAdapter.GetStateImages: TCustomImageList;
begin
  Result := CustomTreeListControl_GetStateImages(TreeListControl);
end;

function TcxTreeListControlAdapter.GetStyles: TcxTreeListStyles;
begin
  Result := CustomTreeListControl_GetStyles(TreeListControl);
end;

function TcxTreeListControlAdapter.GetThemedBandHeaderItemColor: TColor;
begin
  Result := LookAndFeelPainter.DefaultHeaderColor;
end;

function TcxTreeListControlAdapter.GetThemedBandHeaderItemTextColor: TColor;
begin
  Result := LookAndFeelPainter.DefaultHeaderTextColor;
end;

function TcxTreeListControlAdapter.GetThemedFooterItemColor: TColor;
begin
  Result := LookAndFeelPainter.DefaultFooterColor;
end;

function TcxTreeListControlAdapter.GetThemedFooterItemTextColor: TColor;
begin
  Result := LookAndFeelPainter.DefaultFooterTextColor;
end;

function TcxTreeListControlAdapter.GetThemedHeaderItemColor: TColor;
begin
  Result := LookAndFeelPainter.DefaultHeaderColor;
end;

function TcxTreeListControlAdapter.GetThemedHeaderItemTextColor: TColor;
begin
  Result := LookAndFeelPainter.DefaultHeaderTextColor;
end;

function TcxTreeListControlAdapter.GetThemedHeaderRowColor: TColor;
begin
  Result := LookAndFeelPainter.DefaultHeaderBackgroundColor;
end;

function TcxTreeListControlAdapter.GetTreeLinesColor: TColor;
begin
  Result := OptionsView.TreeLineColor;
end;

function TcxTreeListControlAdapter.GetTreeLinesStyle: TcxTreeListTreeLineStyle;
begin
  Result := OptionsView.TreeLineStyle;
end;

function TcxTreeListControlAdapter.GetTreeListControl: TcxCustomTreeListControl;
begin
  Result := Builder.TreeListControl;
end;

function TcxTreeListControlAdapter.GetUseStylesForIndents: Boolean;
begin
  Result := OptionsView.UseNodeColorForIndent;
end;

function TcxTreeListControlAdapter.GetViewWidth: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to BandCount - 1 do
    Inc(Result, BandWidths[I]);
end;
 
{ TcxTreeListControlReportLinkFormatter }

constructor TcxTreeListControlReportLinkFormatter.Create(ABuilder: TcxTreeListControlReportLinkBuilder);
begin
  inherited;
  FFont := TFont.Create;
  FLookAndFeelItems := TList.Create;
  FNodes := TList.Create;
  CreateNodeList;
  FTransparentColor := dxPSCore.dxDefaultContentColor;
end;

destructor TcxTreeListControlReportLinkFormatter.Destroy;
begin
  FreeAndNil(FNodes);
  FreeAndNil(FLookAndFeelItems);
  FreeAndNil(FFont);
  inherited;
end;

function TcxTreeListControlReportLinkFormatter.Adapter: TcxTreeListControlAdapter;
begin
  Result := Builder.Adapter;
end;

procedure TcxTreeListControlReportLinkFormatter.DoInitializeHost(AHost: TdxReportCell);
begin
  AHost.CellSides := [];
  AHost.Transparent := True;
end;

procedure TcxTreeListControlReportLinkFormatter.DoInitializeBandItem(AnItem: TAbstractdxReportCellData; 
  AnIndex: Integer);
var
  Band: TcxTreeListBand;
begin
  Band := Adapter.Bands[AnIndex];
  SetViewParams(AnItem, GetBandItemViewParams(Band));
  RegisterLookAndFeelItem(AnItem, cesRaised);
  if HasBackgroundBitmap(tlsv_BandHeader) then 
    AnItem.BackgroundBitmapIndex := GetBackgroundBitmapIndex(tlsv_BandHeader);
  
  with AnItem as TdxReportCellImage do
  begin
    Data := Integer(Band);
    EndEllipsis := Band.Caption.ShowEndEllipsis;
    if not Band.Caption.Glyph.Empty then
    begin
      Image := Band.Caption.Glyph;
      ImageLayout := HeaderImageLayoutMap[Band.Caption.GlyphAlignHorz, Band.Caption.GlyphAlignVert];
      ImageTransparent := True;
      IsTextDrawnForCenteredImage := True;
      IsTextShiftedForHorizontallyCenteredImage := not (ImageLayout in [ilImageTopCenter, ilImageCenterCenter, ilImageBottomCenter]);
    end;
    Multiline := Band.Caption.Multiline;
    Text := Band.Caption.Text;
    TextAlignX := TextAlignXMap[Band.Caption.AlignHorz];
    TextAlignY := TextAlignYMap[Band.Caption.AlignVert];
  end;  
end;

procedure TcxTreeListControlReportLinkFormatter.DoInitializeBandRow(ARow: TdxReportCell);
begin
  //SetViewParams(ARow, GetBandBackgroundViewParams);
  ARow.Transparent := True; //???
  ARow.Data := Integer(TcxTreeListBandAttribute);
end;

procedure TcxTreeListControlReportLinkFormatter.DoReportLinkInitializeBandItem(AnItem: TAbstractdxReportCellData; 
  AIndex: Integer);
begin
  ReportLink.DoInitializeBandCell(Adapter.Bands[AIndex], TdxReportCellImage(AnItem));
end;  

function TcxTreeListControlReportLinkFormatter.GetBandBackgroundViewParams: TdxReportItemViewParams;
begin
  Result.NativeParams := Adapter.GetBandBackgroundViewParams;
  Result.CellSides := [];
  Result.FontStyle := [];
  Result.Transparent := True;
end;

function TcxTreeListControlReportLinkFormatter.GetBandItemBounds(Index: Integer): TRect;
begin
  Result := Adapter.BandPlaces[Index];
  Result.Bottom := Result.Top + BandLineHeight * Adapter.BandLineCount;
end;

function TcxTreeListControlReportLinkFormatter.GetBandItemClass(Index: Integer): TdxReportCellTextClass;
begin
  Result := TdxReportCellImage;
end;

function TcxTreeListControlReportLinkFormatter.GetBandItemViewParams(ABand: TcxTreeListBand): TdxReportItemViewParams;
begin
  FillChar(Result, SizeOf(Result), 0);
  if ReportLink.OptionsFormatting.UseNativeStyles then 
    ReportLink.Styles.GetBandHeaderParams(ABand, Result.NativeParams)
  else
    Result.NativeParams := Adapter.GetBandHeaderViewParams(ABand);

  if UseLookAndFeelColors and Adapter.CanUseLookAndFeelColors then
    if ABand <> nil then
    begin
      Result.NativeParams.Color := Adapter.ThemedBandHeaderItemColor;
      Result.NativeParams.TextColor := Adapter.ThemedBandHeaderItemTextColor;
    end;
    
  Result.CellSides := csAll;
  Result.FontStyle := [];
  Result.Transparent := IsColorTransparent(Result.NativeParams.Color); // ReportLink.FixedTransparent;
end;

procedure TcxTreeListControlReportLinkFormatter.DoInitializeFooterItem(AnItem: TAbstractdxReportCellData;
  AnIndex: Integer);
var
  Column: TcxTreeListColumn;
begin
  Column := Adapter.Columns[AnIndex];
  SetViewParams(AnItem, GetFooterItemViewParams(Column));
  RegisterLookAndFeelItem(AnItem, cesSunken);
  if HasBackgroundBitmap(tlsv_ColumnFooter) then 
    AnItem.BackgroundBitmapIndex := GetBackgroundBitmapIndex(tlsv_ColumnFooter);
  
  with AnItem as TdxReportCellString do 
  begin
    Data := Integer(Column);  
    //ExcludeFromClipRgn := True;
    Multiline := Column.SummaryFooter.MultiLine;
    Text := Adapter.FooterItemTexts[AnIndex];
    TextAlignX := TextAlignXMap[Column.SummaryFooter.AlignHorz];
    TextAlignY := TextAlignYMap[Column.SummaryFooter.AlignVert];
  end;  
end;  

procedure TcxTreeListControlReportLinkFormatter.DoInitializeFooterRow(ARow: TdxReportCell);
begin
  SetViewParams(ARow, GetFooterRowViewParams);
  RegisterLookAndFeelItem(ARow, cesRaised);
  ARow.Data := Integer(TcxTreeListFooterAttribute);
end;

procedure TcxTreeListControlReportLinkFormatter.DoReportLinkInitializeFooterItem(AnItem: TAbstractdxReportCellData; 
  AIndex: Integer);
begin
  ReportLink.DoInitializeFooterCell(Adapter.Columns[AIndex], TdxReportCellString(AnItem));
end;  

function TcxTreeListControlReportLinkFormatter.GetFooterItemBounds(Index: Integer): TRect;
begin
  with Adapter.ColumnPlaces[Index] do 
    Result := MakeRect(Left, RowIndex * FooterLineHeight, Right, (RowIndex + LineCount) * FooterLineHeight);
    
  InflateRect(Result, -FooterItemInflateHorz, -FooterItemInflateVert);
  if Adapter.Columns[Index].IsLeftMost then
    Inc(Result.Left, 2);
end;

function TcxTreeListControlReportLinkFormatter.GetFooterItemClass(AnIndex: Integer): TdxReportCellTextClass; 
begin
  Result := TdxReportCellString;
end;

function TcxTreeListControlReportLinkFormatter.GetFooterItemViewParams(AColumn: TcxTreeListColumn): TdxReportItemViewParams;
begin
  FillChar(Result, SizeOf(Result), 0);
  if ReportLink.OptionsFormatting.UseNativeStyles then 
    ReportLink.Styles.GetColumnFooterParams(nil, AColumn, Result.NativeParams)
  else
    Result.NativeParams := Adapter.GetColumnFooterViewParams(AColumn);

  if UseLookAndFeelColors and Adapter.CanUseLookAndFeelColors then
    if AColumn <> nil then
    begin
      Result.NativeParams.Color := Adapter.ThemedFooterItemColor;
      Result.NativeParams.TextColor := Adapter.ThemedFooterItemTextColor;
    end;
    
  Result.CellSides := csAll;
  Result.FontStyle := [];    
  Result.Transparent := IsColorTransparent(Result.NativeParams.Color);
end;

function TcxTreeListControlReportLinkFormatter.GetFooterRowViewParams: TdxReportItemViewParams;
begin
  FillChar(Result, SizeOf(Result), 0);
  if ReportLink.OptionsFormatting.UseNativeStyles then 
    ReportLink.Styles.GetFooterRowParams(Result.NativeParams)
  else
    Result.NativeParams := Adapter.GetFooterRowViewParams;
    
  Result.CellSides := csAll;
  Result.FontStyle := [];    
  Result.Transparent := IsColorTransparent(Result.NativeParams.Color);
end;

procedure TcxTreeListControlReportLinkFormatter.DoInitializeHeaderItem(AnItem: TAbstractdxReportCellData;
  AnIndex: Integer);
var
  Column: TcxTreeListColumn;
begin
  Column := Adapter.Columns[AnIndex];
  SetViewParams(AnItem, GetHeaderItemViewParams(Column));
  RegisterLookAndFeelItem(AnItem, cesRaised);
  if HasBackgroundBitmap(tlsv_ColumnHeader) then 
    AnItem.BackgroundBitmapIndex := GetBackgroundBitmapIndex(tlsv_ColumnHeader);
  
  with AnItem as TdxReportCellImage do 
  begin
    Data := Integer(Column);
    EndEllipsis := Column.Caption.ShowEndEllipsis;
    if not Column.Caption.Glyph.Empty then
    begin
      Image := Column.Caption.Glyph;
      ImageLayout := HeaderImageLayoutMap[Column.Caption.GlyphAlignHorz, Column.Caption.GlyphAlignVert];
      IsTextDrawnForCenteredImage := True;
      IsTextShiftedForHorizontallyCenteredImage := not (ImageLayout in [ilImageTopCenter, ilImageCenterCenter, ilImageBottomCenter]);
    end;
    Multiline := Column.Caption.MultiLine;
    SortOrder := SortOrderMap[Column.SortOrder];
    Text := Column.Caption.Text;
    TextAlignX := TextAlignXMap[Column.Caption.AlignHorz];
    TextAlignY := TextAlignYMap[Column.Caption.AlignVert];
  end;  
end;

procedure TcxTreeListControlReportLinkFormatter.DoInitializeHeaderRow(ARow: TdxReportCell);
begin
//  SetViewParams(ARow, GetHeaderItemViewParams(Adapter.Columns[0]));
  SetViewParams(ARow, GetHeaderItemViewParams(nil));
  ARow.Data := Integer(TcxTreeListHeaderAttribute);
end;

procedure TcxTreeListControlReportLinkFormatter.DoReportLinkInitializeHeaderItem(AnItem: TAbstractdxReportCellData; 
  AIndex: Integer);
begin
  ReportLink.DoInitializeHeaderCell(Adapter.Columns[AIndex], TdxReportCellImage(AnItem));
end;

function TcxTreeListControlReportLinkFormatter.GetHeaderItemBounds(Index: Integer): TRect;
begin
  with Adapter.ColumnPlaces[Index] do 
    Result := MakeRect(Left, RowIndex * HeaderLineHeight, Right, (RowIndex + LineCount) * HeaderLineHeight);
end;

function TcxTreeListControlReportLinkFormatter.GetHeaderItemClass(AnIndex: Integer): TdxReportCellTextClass; 
begin
  Result := TdxReportCellImage;
end;

function TcxTreeListControlReportLinkFormatter.GetHeaderItemViewParams(AColumn: TcxTreeListColumn): TdxReportItemViewParams;
begin
  FillChar(Result, SizeOf(Result), 0);
  if ReportLink.OptionsFormatting.UseNativeStyles then 
    ReportLink.Styles.GetColumnHeaderParams(AColumn, Result.NativeParams)
  else
    Result.NativeParams := Adapter.GetColumnHeaderViewParams(AColumn);

  if UseLookAndFeelColors and Adapter.CanUseLookAndFeelColors then
    if AColumn <> nil then
    begin
      Result.NativeParams.Color := Adapter.ThemedHeaderItemColor; 
      Result.NativeParams.TextColor := Adapter.ThemedHeaderItemTextColor; 
    end;
    
  Result.CellSides := csAll;
  Result.FontStyle := [];
  Result.Transparent := IsColorTransparent(Result.NativeParams.Color); //ReportLink.FixedTransparent;
end;

procedure TcxTreeListControlReportLinkFormatter.DoInitializeNodeImage(AnItem: TdxReportCellGraphic; 
  ANode: TcxTreeListNode; AnIndex: Integer);
begin
  SetViewParams(AnItem, GetNodeImageViewParams(ANode, AnIndex));
  if HasBackgroundBitmap(tlsv_Content) then 
    AnItem.BackgroundBitmapIndex := GetBackgroundBitmapIndex(tlsv_Content);

  AnItem.Data := MakeIndentIndex(AnIndex);
  AnItem.DrawMode := gdmCenter;
  AnItem.ImageIndex := ANode.ImageIndex;
  AnItem.ImageList := Adapter.Images;
  AnItem.ImageTransparent := True;          
end;

procedure TcxTreeListControlReportLinkFormatter.DoReportLinkInitializeNodeImage(AnItem: TAbstractdxReportCellData; 
  ANode: TcxTreeListNode; AnIndex: Integer);
begin
  ReportLink.DoInitializeIndentCell(ANode, AnIndex, AnItem);
end;  

function TcxTreeListControlReportLinkFormatter.GetNodeImageCellSides(ANode: TcxTreeListNode; 
  AnIndex: Integer): TdxCellSides;
begin  
  Result := [];
  if ((AnIndex <> 0) and Adapter.ShowVertGridLines and not Adapter.HasStateImages(ANode)) or 
    ((AnIndex = 0) and ReportLink.OptionsView.Borders) then 
    Include(Result, csLeft);
  if Adapter.ShowHorzGridLines then
  begin
    if not IsFirstNode(ANode) then Include(Result, csTop);
    if not IsLastNode(ANode) then Include(Result, csBottom);
  end;  
  if ReportLink.OptionsView.Borders then
  begin  
    if IsFirstNode(ANode) then Include(Result, csTop);
    if IsLastNode(ANode) then Include(Result, csBottom);
  end;  
end;

function TcxTreeListControlReportLinkFormatter.GetNodeImageClass: TdxReportCellGraphicClass;
begin
  Result := TdxReportCellGraphic;
end;

function TcxTreeListControlReportLinkFormatter.GetNodeImageViewParams(ANode: TcxTreeListNode; 
  AnIndex: Integer): TdxReportItemViewParams;
begin
  FillChar(Result, SizeOf(Result), 0);
  if ReportLink.OptionsFormatting.UseNativeStyles then
    if CanProcessSelectionStyle(ANode) then
      ReportLink.Styles.GetSelectionParams(Result.NativeParams)
    else
      ReportLink.Styles.GetImagesParams(ANode, Result.NativeParams)
  else
    if CanProcessSelectionStyle(ANode) then
      Result.NativeParams := Adapter.GetSelectionViewParams
    else
      Result.NativeParams := Adapter.GetIndentViewParams(ANode, AnIndex);
    
  Result.CellSides := GetNodeImageCellSides(ANode, AnIndex);
  Result.Transparent := IsColorTransparent(Result.NativeParams.Color); // ReportLink.FixedTransparent;
end;
  
procedure TcxTreeListControlReportLinkFormatter.DoInitializeNodeIndent(AnItem: TdxReportCellExpandButton; 
  AnIndex, AnIndentCount: Integer; ANode: TcxTreeListNode);
begin
  SetViewParams(AnItem, GetNodeIndentViewParams(ANode, AnIndex, AnIndentCount));
  if HasBackgroundBitmap(tlsv_Content) then 
    AnItem.BackgroundBitmapIndex := GetBackgroundBitmapIndex(tlsv_Content);

  AnItem.Data := MakeIndentIndex(AnIndex); 
  AnItem.ShowButton := (AnIndex = AnIndentCount - 1) and ANode.HasChildren and ReportLink.OptionsView.ExpandButtons;
  if AnItem.ShowButton then
    DoInitializeExpandButton(AnItem, AnIndex, AnIndentCount, ANode);
  if ReportLink.OptionsView.TreeLines then 
    AnItem.TreeLineMode := GetNodeIndentTreeLineMode(AnIndex, AnIndentCount, ANode);
end;

procedure TcxTreeListControlReportLinkFormatter.DoInitializeExpandButton(AnItem: TdxReportCellExpandButton; 
  AnIndex, AnIndentCount: Integer; ANode: TcxTreeListNode);
begin
  with AnItem do 
  begin
    ButtonExpanded := IsNodeExpanded(ANode);
    ButtonSize := ExpandButtonSize;
    ButtonInteriorColor := ExpandButtonColor;
    ButtonTransparent := IsColorTransparent(ButtonInteriorColor);
  end;
end;

procedure TcxTreeListControlReportLinkFormatter.DoReportLinkInitializeNodeIndent(AnItem: TAbstractdxReportCellData;
  AnIndex, AnIndentCount: Integer; ANode: TcxTreeListNode);
begin
  ReportLink.DoInitializeIndentCell(ANode, AnIndex, AnItem);
end;  
  
function TcxTreeListControlReportLinkFormatter.GetNodeIndentCellSides(ANode: TcxTreeListNode; 
  AnIndex, AnIndentCount: Integer): TdxCellSides;
var
  Level: Integer;  
  NextNode: TcxTreeListNode;
begin
  Result := [];
  if not ReportLink.OptionsView.Borders then Exit; 
  if Adapter.ShowVertGridLines then
    Result := csLeftRight;
  if (AnIndex = 0) and not ReportLink.OptionsView.Borders then
    Exclude(Result, csLeft);
    
  if Adapter.ShowHorzGridLines then 
  begin
    if not IsFirstNode(ANode) and (AnIndex = ANode.Level) then 
      Include(Result, csTop);
    if not IsLastNode(ANode) then
    begin  
      Level := 0;
      NextNode := GetNextNode(ANode);
      if NextNode <> nil then
        Level := NextNode.Level;
      if (ANode.Level > Level) and (AnIndex >= Level) then   
        Include(Result, csBottom);
    end;    
  end;  
  if ReportLink.OptionsView.Borders then
  begin
    if IsFirstNode(ANode) then Include(Result, csTop);
    if IsLastNode(ANode) then Include(Result, csBottom);
  end;
end;
    
function TcxTreeListControlReportLinkFormatter.GetNodeIndentClass: TdxReportCellExpandButtonClass;
begin
  Result := TdxReportCellExpandButton;
end;

function TcxTreeListControlReportLinkFormatter.GetNodeIndentTreeLineMode(AnIndex, 
  AnIndentCount: Integer; ANode: TcxTreeListNode): TdxPSTreeLineMode;
var
  Level: Integer;
  Parent: TcxTreeListNode;
begin
  Level := AnIndentCount - AnIndex - 1;
//  if Adapter.ShowRoot then Dec(Level);
  Parent := GetNodeParent(ANode, Level);

  if Parent = ANode then 
    if IsNodeLastChild(ANode) then
      Result := tlmBottomRightCorner
    else
      if not HasParent(ANode) and IsNodeFirstChild(ANode) then          
        Result := tlmTopRightCorner  
      else
        Result := tlmCross
  else
    if IsNodeLastChild(Parent) then
      Result := tlmNone
    else
      Result := tlmVertical;
end;
  
function TcxTreeListControlReportLinkFormatter.GetNodeIndentViewParams(ANode: TcxTreeListNode; 
  AnIndex, AnIndentCount: Integer): TdxReportItemViewParams;
begin
  FillChar(Result, 0, SizeOf(Result));
  if ReportLink.OptionsFormatting.UseNativeStyles then
    if CanProcessSelectionStyle(ANode) then
      ReportLink.Styles.GetSelectionParams(Result.NativeParams)
    else
      ReportLink.Styles.GetIndentParams(ANode, AnIndex, Result.NativeParams)
  else
    if CanProcessSelectionStyle(ANode) then
      Result.NativeParams := Adapter.GetSelectionViewParams
    else
      Result.NativeParams := Adapter.GetIndentViewParams(ANode, AnIndex);
      
//  if not CanProcessSelectionStyle(ANode) and not IsNodeColorUsedForIndents then 
//    Result.Color := ReportLink.Color;  

  Result.CellSides := GetNodeIndentCellSides(ANode, AnIndex, AnIndentCount);
  Result.FontStyle := [];    
  Result.Transparent := IsColorTransparent(Result.NativeParams.Color); //ReportLink.FixedTransparent
end;

procedure TcxTreeListControlReportLinkFormatter.DoInitializeNodeRow(ARow: TdxReportCell; 
  ANode: TcxTreeListNode);
const
  CellSidesMap: array[Boolean] of TdxCellSides = ([], csLeftRight);
begin
  ARow.CellSides := CellSidesMap[ReportLink.OptionsView.Borders];
  ARow.Data := Integer(ANode);
  ARow.Transparent := True;
  
  ReportLink.AddReportRow(ARow);
end;

procedure TcxTreeListControlReportLinkFormatter.DoInitializeNodeItem(AnItem: TAbstractdxReportCellData; 
  AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; AnIsPreview: Boolean = False);

  function GetViewParams: TdxReportItemViewParams;
  begin
    if AnIsPreview then
      Result := GetPreviewViewParams(AColumn, ANode)
    else
      Result := GetNodeItemViewParams(AColumn, ANode);
  end;

var
  Properties: TcxCustomEditProperties;
  ViewParams: TdxReportItemViewParams;
  CellValue: TcxEditValue;
begin
  Properties := Adapter.GetProperties(AColumn, ANode);
  ViewParams := GetViewParams;
  CellValue := GetCellValue(Properties, AColumn, ANode);
  dxPScxCommon.dxPSDataMaps.InitializeItem(AnItem, Properties, CellValue, Self, ViewParams, AnIsPreview, ANode.RecordIndex);
  dxPScxCommon.dxPSDataMaps.GetImageLists(Properties, ReportLink.AppendImageList);
  SetViewParams(AnItem, ViewParams);

  with ViewParams, NativeParams do
    if (Bitmap <> nil) and not Bitmap.Empty then
      AnItem.BackgroundBitmapIndex := ReportLink.AddBackgroundBitmapToPool(Bitmap);

  AnItem.Data := Integer(AColumn);
end;

procedure TcxTreeListControlReportLinkFormatter.DoReportLinkInitializeNodeItem(AnItem: TAbstractdxReportCellData; 
  AColumn: TcxTreeListColumn; ANode: TcxTreeListNode);
begin
  ReportLink.DoInitializeCell(ANode, AColumn, AnItem);
end;

function TcxTreeListControlReportLinkFormatter.GetCellValue(AProperties: TcxCustomEditProperties; 
  AColumn: TcxTreeListColumn; ANode: TcxTreeListNode): TcxEditValue;
begin
  if AProperties.GetEditValueSource(False) = evsValue then
    Result := ANode.Values[ColumnIndex(AColumn)]
  else
    Result := ANode.Texts[ColumnIndex(AColumn)];
end;

function TcxTreeListControlReportLinkFormatter.GetNodeBackgroundBitmapStyleIndex(ANode: TcxTreeListNode): Integer;

  function HasBackgroundBitmap(AStyle: TcxStyle): Boolean;
  begin
    Result := (AStyle <> nil) and (svBitmap in AStyle.AssignedValues);
  end;
  
begin
  Result := tlsv_Content;
  if IsOddNode(ANode) and HasBackgroundBitmap(ReportLink.Styles.StylesByCaption[cxGetResourceString(@sdxContentOddStyle)]) then
    Result := tlsv_ContentOdd
  else 
    if not IsOddNode(ANode) and HasBackgroundBitmap(ReportLink.Styles.StylesByCaption[cxGetResourceString(@sdxContentEvenStyle)]) then
      Result := tlsv_ContentEven
end;

function TcxTreeListControlReportLinkFormatter.GetNodeItemBounds(ANode: TcxTreeListNode; 
  Index, IndentCount: Integer): TRect;
begin
  with Adapter.ColumnPlaces[Index] do 
    Result := MakeRect(Left, RowIndex * DetailsLineHeight, Right, (RowIndex + LineCount) * DetailsLineHeight);
    
  if Adapter.Columns[Index].IsLeftMost then
    Inc(Result.Left, (Adapter.IndentWidth * IndentCount) + Adapter.GetImagesWidth(ANode) + Adapter.GetStateImagesWidth(ANode));
end;

function TcxTreeListControlReportLinkFormatter.GetNodeItemCellSides(AColumn: TcxTreeListColumn; 
  ANode: TcxTreeListNode): TdxCellSides;
begin
  if ReportLink.OptionsView.Borders then
  begin
    Result := csAll;
    if AColumn.IsLeftMost and ((IndentCounts[ANode] <> 0) or Adapter.HasImages(nil) or Adapter.HasStateImages(nil)) then
      Exclude(Result, csLeft);
  end
  else
    Result := [];
end;

function TcxTreeListControlReportLinkFormatter.GetNodeItemClass(AColumn: TcxTreeListColumn;
  ANode: TcxTreeListNode; AnIsPreview: Boolean = False): TdxReportCellDataClass;
begin
  Result := dxPSDataMaps.ItemClass(Adapter.GetProperties(AColumn, ANode), AnIsPreview);
end;

function TcxTreeListControlReportLinkFormatter.GetNodeItemViewParams(AColumn: TcxTreeListColumn;
  ANode: TcxTreeListNode): TdxReportItemViewParams;
begin
  FillChar(Result, 0, SizeOf(Result));
  if ReportLink.OptionsFormatting.UseNativeStyles then
    if CanProcessSelectionStyle(ANode) then
      ReportLink.Styles.GetSelectionParams(Result.NativeParams)
    else
      ReportLink.Styles.GetContentParams(ANode, AColumn, Result.NativeParams)
  else
    if CanProcessSelectionStyle(ANode) then
      Result.NativeParams := Adapter.GetSelectionViewParams
    else
      Result.NativeParams := Adapter.GetContentViewParams(ANode, AColumn);

  Result.CellSides := GetNodeItemCellSides(AColumn, ANode);
  Result.FontStyle := [];
  Result.Transparent := IsColorTransparent(Result.NativeParams.Color); //ReportLink.Transparent;

end;

procedure TcxTreeListControlReportLinkFormatter.DoInitializePreview(AnItem: TAbstractdxReportCellData;
  AColumn: TcxTreeListColumn; ANode: TcxTreeListNode);
begin
  DoInitializeNodeItem(AnItem, AColumn, ANode, True);
end;

function TcxTreeListControlReportLinkFormatter.GetPreviewCellSides(ANode: TcxTreeListNode): TdxCellSides;
begin
  Result := CellSidesMap[Adapter.GridLines];
  if (IndentCounts[ANode] <> 0) or Adapter.HasImages(nil) or Adapter.HasStateImages(nil) then 
    Exclude(Result, csLeft);
  if ReportLink.OptionsView.Borders then
  begin
    Include(Result, csRight);
    if IsLastNode(ANode) then 
      Include(Result, csBottom);
  end
  else
    Exclude(Result, csRight); 
end;

function TcxTreeListControlReportLinkFormatter.GetPreviewClass(AColumn: TcxTreeListColumn;
  ANode: TcxTreeListNode): TdxReportCellDataClass;
begin
  Result := GetNodeItemClass(AColumn, ANode, True);
end;
  
function TcxTreeListControlReportLinkFormatter.GetPreviewViewParams(AColumn: TcxTreeListColumn; 
  ANode: TcxTreeListNode): TdxReportItemViewParams;
begin
  FillChar(Result, SizeOf(Result), 0);
  if ReportLink.OptionsFormatting.UseNativeStyles then 
    if CanProcessSelectionStyle(ANode) then
      ReportLink.Styles.GetSelectionParams(Result.NativeParams)
    else
      ReportLink.Styles.GetPreviewParams(ANode, AColumn, Result.NativeParams)
  else
    if CanProcessSelectionStyle(ANode) then
      Result.NativeParams := Adapter.GetSelectionViewParams
    else
      Result.NativeParams := Adapter.GetPreviewViewParams(ANode, AColumn);

  Result.CellSides := GetPreviewCellSides(ANode);
  Result.FontStyle := [];
  Result.Transparent := {True;//}IsColorTransparent(Result.NativeParams.Color); //ReportLink.Transparent;
end;

procedure TcxTreeListControlReportLinkFormatter.DoInitializeNodeSeparator(AnItem: TdxReportCellBox);
begin
  with AnItem do 
  begin
    CellSides := csAll;
    Color := NodeSeparatorColor;
    Transparent := False;
  end;  
end;

procedure TcxTreeListControlReportLinkFormatter.DoInitializeNodeSeparatorRow(ARow: TdxReportCell);
begin
end;

function TcxTreeListControlReportLinkFormatter.GetNodeSeparatorClass: TdxReportCellBoxClass;
begin
  Result := TdxReportCellBox;
end;

{ state images }

procedure TcxTreeListControlReportLinkFormatter.DoInitializeNodeStateImage(AnItem: TdxReportCellGraphic; 
  ANode: TcxTreeListNode; AnIndex: Integer);
begin
  SetViewParams(AnItem, GetNodeStateImageViewParams(ANode, AnIndex));
  if HasBackgroundBitmap(tlsv_Content) then 
    AnItem.BackgroundBitmapIndex := GetBackgroundBitmapIndex(tlsv_Content);

  AnItem.Data := MakeIndentIndex(AnIndex);
  AnItem.DrawMode := gdmCenter;
  AnItem.ImageIndex := ANode.StateIndex;
  AnItem.ImageList := Adapter.StateImages;
  AnItem.ImageTransparent := True;
end;

procedure TcxTreeListControlReportLinkFormatter.DoReportLinkInitializeNodeStateImage(AnItem: TAbstractdxReportCellData;
  ANode: TcxTreeListNode; AnIndex: Integer);
begin
  ReportLink.DoInitializeIndentCell(ANode, AnIndex, AnItem);
end;  

function TcxTreeListControlReportLinkFormatter.GetNodeStateImageCellSides(ANode: TcxTreeListNode; 
  AnIndex: Integer): TdxCellSides;
begin
  Result := [];
  if ((AnIndex <> 0) and Adapter.ShowVertGridLines) or ((AnIndex = 0) and ReportLink.OptionsView.Borders) then 
    Include(Result, csLeft);

  if Adapter.ShowHorzGridLines then
  begin
    if not IsFirstNode(ANode) then Include(Result, csTop);
    if not IsLastNode(ANode) then Include(Result, csBottom);
  end;
  if ReportLink.OptionsView.Borders then
  begin
    if IsFirstNode(ANode) then Include(Result, csTop);
    if IsLastNode(ANode) then Include(Result, csBottom);
  end;
end;

function TcxTreeListControlReportLinkFormatter.GetNodeStateImageClass: TdxReportCellGraphicClass;
begin
  Result := TdxReportCellGraphic;
end;

function TcxTreeListControlReportLinkFormatter.GetNodeStateImageViewParams(ANode: TcxTreeListNode; 
  AnIndex: Integer): TdxReportItemViewParams;
begin
  FillChar(Result, SizeOf(Result), 0);
  if ReportLink.OptionsFormatting.UseNativeStyles then
    if CanProcessSelectionStyle(ANode) then
      ReportLink.Styles.GetSelectionParams(Result.NativeParams)
    else
      ReportLink.Styles.GetImagesParams(ANode, Result.NativeParams)
  else
    if CanProcessSelectionStyle(ANode) then
      Result.NativeParams := Adapter.GetSelectionViewParams
    else
      Result.NativeParams := Adapter.GetIndentViewParams(ANode, AnIndex);

  Result.CellSides := GetNodeStateImageCellSides(ANode, AnIndex);
  Result.Transparent := IsColorTransparent(Result.NativeParams.Color); // ReportLink.FixedTransparent;
end;

function TcxTreeListControlReportLinkFormatter.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TcxTreeListControlReportLinkFormatter._AddRef: Integer;
begin
  Result := 1;
end;

function TcxTreeListControlReportLinkFormatter._Release: Integer;
begin
  Result := 1;
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams_GetAutoHeight: Boolean;
begin 
  Result := Adapter.CellAutoHeight;
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams_GetDC: HDC;
begin
  Result := Self.DC;
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams_GetDisplayGraphicsAsText: Boolean;
begin 
  Result := ReportLink.OptionsRefinements.DisplayGraphicsAsText;
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams_GetEndEllipsis: Boolean;
begin 
  Result := Adapter.CellEndEllipsis;
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams_GetFlatCheckMarks: Boolean;
begin 
  Result := ReportLink.OptionsRefinements.FlatCheckMarks;
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams_GetGraphicsText: string;
begin 
  Result := ReportLink.OptionsRefinements.GraphicsText;
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams_GetMultiline: Boolean;
begin
  Result := Adapter.CellMultiline;
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams_GetTransparentGraphics: Boolean;
begin 
  Result := ReportLink.OptionsRefinements.TransparentGraphics;
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams2_GetPreviewMarginLeft: Integer;
begin
  Result := Adapter.PreviewLeftIndent;
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams2_GetPreviewMarginRight: Integer;
begin
  Result := Adapter.PreviewRightIndent;
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams2_GetPreviewMaxHeight: Integer;
begin
  if PreviewAutoHeight then
    Result := -1
  else  
    Result := PreviewLineHeight * PreviewMaxLineCount;
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams2_GetPreviewMaxLineCount: Integer;
begin
  Result := PreviewMaxLineCount;
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams2_GetRichEditGraphicClass: TGraphicClass;
const
  GraphicClasses: array[Boolean] of TGraphicClass = (TMetafile, TBitmap);
begin
  Result := GraphicClasses[IdxPSCellParams2_GetRichEditTransparent];
end;

function TcxTreeListControlReportLinkFormatter.IdxPSCellParams2_GetRichEditTransparent: Boolean;
begin
  Result := ReportLink.OptionsRefinements.TransparentRichEdits;
end;

procedure TcxTreeListControlReportLinkFormatter.AddDelimiters;
begin
  with ReportLink.OptionsPagination do
  begin
    if Band or Column then AddHorizontalDelimiters;
    if Node then AddVerticalDelimiters;
  end;
end;

procedure TcxTreeListControlReportLinkFormatter.AddHorizontalDelimiters;
var
  X, I: Integer;
begin
  if ReportLink.OptionsPagination.Band then 
  begin
    X := 0;
    for I := 0 to Adapter.BandCount - 1 do
    begin
      ReportLink.AddHorizontalDelimiter(X);
      Inc(X, Adapter.BandWidths[I]);
    end;
  end
  else
    for I := 0 to Adapter.ColumnCount - 1 do
      with Adapter.ColumnPlaces[I] do 
      begin
        ReportLink.AddHorizontalDelimiter(Left);
        ReportLink.AddHorizontalDelimiter(Right);      
      end;
end;

procedure TcxTreeListControlReportLinkFormatter.AddVerticalDelimiters;
var
  I: Integer;
begin
  for I := 0 to Builder.ReportRowCount - 1 do
    ReportLink.AddVerticalDelimiter(Builder.ReportRows[I]);
end;
                                           
procedure TcxTreeListControlReportLinkFormatter.AfterBuilding; 
begin
  if not Builder.IsAborted then
  begin
    FormatLookAndFeelItems;  
    AddDelimiters;
    Builder.ReportCells.BorderColor := GridLinesColor;
    Builder.ReportCells.TreeLineColor := Adapter.TreeLinesColor;
    Builder.ReportCells.TreeLineStyle := TreeLinesStyleMap[Adapter.TreeLinesStyle];
  end;  
end;

procedure TcxTreeListControlReportLinkFormatter.BeforeBuilding;
begin
  CalculateLineHeights;
end;

procedure TcxTreeListControlReportLinkFormatter.CalculateLineHeights;
var
  I: Integer; 
  Column: TcxTreeListColumn;
begin
  FBandLineHeight := 0;
  FDetailsLineHeight := Adapter.DefaultRowHeight;  
  FFooterLineHeight := 0;
  FHeaderLineHeight := 0;

  for I := 0 to Adapter.ColumnCount - 1 do
  begin
    Column := Adapter.Columns[I];
    CalculateHeight(GetFooterItemViewParams(Column), FFooterLineHeight);
    CalculateHeight(GetHeaderItemViewParams(Column), FHeaderLineHeight);
    if not Adapter.IsDefaultRowHeightAssigned and Column.IsPreview then
      CalculateHeight(GetNodeItemViewParams(Column, Nodes[0]), FDetailsLineHeight);
  end;
  //if FDetailsLineHeight
  Inc(FFooterLineHeight, 2 * FooterItemInflateVert);

  FPreviewLineHeight := Adapter.DefaultRowHeight;
  if PreviewColumn <> nil then
    CalculateHeight(GetPreviewViewParams(PreviewColumn, Nodes[0]), FPreviewLineHeight);
  
  for I := 0 to Adapter.BandCount - 1 do
    CalculateHeight(GetBandItemViewParams(Adapter.Bands[I]), FBandLineHeight);  
end;

function TcxTreeListControlReportLinkFormatter.CanProcessSelectionStyle(ANode: TcxTreeListNode): Boolean;
begin  
  Result := (ANode <> nil) and ReportLink.OptionsFormatting.ConsumeSelectionStyle and IsSelectedNode(ANode);
  if Result and not ReportLink.OptionsFormatting.UseNativeStyles then
    Result := Adapter.HasSelectionStyle;
end;

procedure TcxTreeListControlReportLinkFormatter.CreateNodeList;

  function IsNodeProcessed(ANode: TcxTreeListNode): Boolean;
  var
    Helper: TcxTreeListNodeHelper;
  begin
    Helper := Adapter.Helpers[ANode];
    Result := not Adapter.MultiSelection or not ReportLink.OptionsSelection.ProcessSelection or 
      (ANode.Selected or Helper.HasSelectedChildren or 
      (not ReportLink.OptionsSelection.ProcessExactSelection and Helper.HasSelectedParents));
  end;
  
  procedure ProcessNode(ANode: TcxTreeListNode);
  var
    I: Integer;
    Node: TcxTreeListNode;
  begin
    FNodes.Add(ANode);
    if (ANode.Count > 0) and (ReportLink.OptionsExpanding.ExplicitlyExpandNodes or 
      (ANode.Expanded or (ReportLink.OptionsExpanding.AutoExpandNodes and ANode.CanExpand))) then 
      for I := 0 to ANode.Count - 1 do 
      begin
        Node := ANode[I];
        if IsNodeProcessed(Node) then ProcessNode(Node);
      end;
  end;
  
var
  I: Integer;
  Node: TcxTreeListNode;
begin
  FNodes.Clear;
  for I := 0 to Adapter.NodeCount - 1 do
  begin
    Node := Adapter.Nodes[I];
    if IsNodeProcessed(Node) then ProcessNode(Node);
  end;
end;

function TcxTreeListControlReportLinkFormatter.IsSelectedNode(ANode: TcxTreeListNode): Boolean;
begin
  Result := ReportLink.OptionsSelection.ProcessSelection or ANode.Selected;
end;

function TcxTreeListControlReportLinkFormatter.GetBackgroundBitmap(Index: Integer): TBitmap;
begin
  if ReportLink.OptionsFormatting.UseNativeStyles then
    Result := ReportLink.Styles.GetBitmap(MapStyleBackgroundBitmapIndex(Index))
  else
    Result := Adapter.GetBackgroundBitmap(Index);
end;

function TcxTreeListControlReportLinkFormatter.GetBackgroundBitmapIndex(Index: Integer): Integer;
begin
  Result := ReportLink.AddBackgroundBitmapToPool(GetBackgroundBitmap(Index));
end;

function TcxTreeListControlReportLinkFormatter.HasBackgroundBitmap(Index: Integer): Boolean;
var
  Bitmap: TBitmap;
begin
  if not ReportLink.OptionsFormatting.SuppressBackgroundBitmaps then
  begin
    Bitmap := GetBackgroundBitmap(Index);
    Result := (Bitmap <> nil) and not Bitmap.Empty;
  end
  else
    Result := False;
end;

function TcxTreeListControlReportLinkFormatter.MapStyleBackgroundBitmapIndex(ATreeListBackgroundBitmapIndex: Integer): Integer;
begin
  case ATreeListBackgroundBitmapIndex of
    tlsv_BandHeader: 
      Result := vspsTreeListBandHeader;
    tlsv_Content:
      Result := vspsTreeListContent;
    tlsv_ContentOdd:
      Result := vspsTreeListContentOdd;
    tlsv_ContentEven:
      Result := vspsTreeListContentEven;
    tlsv_ColumnFooter:
      Result := vspsTreeListFooter;
    tlsv_ColumnHeader:
      Result := vspsTreeListHeader;
    tlsv_Footer:
      Result := vspsTreeListFooterRow;
    tlsv_Preview:
      Result := vspsTreeListPreview;
  else
    Result := 0;    
  end;
end;

procedure TcxTreeListControlReportLinkFormatter.CalculateHeight(const AParams: TdxReportItemViewParams; 
  var AHeight: Integer);
var
  Value: Integer;
begin
  Value := CalculatePatternHeight(AParams);
  if Value > AHeight then AHeight := Value;
end;

function TcxTreeListControlReportLinkFormatter.CalculatePatternHeight(const AParams: TdxReportItemViewParams): Integer;
begin
  Result := Renderer.CalcTextPatternHeight(DC, AParams.NativeParams.Font);
end;

function TcxTreeListControlReportLinkFormatter.GetNodeParent(ANode: TcxTreeListNode; 
  ALevel: Integer): TcxTreeListNode;
begin
  Result := ANode;
  while ALevel > 0 do 
  begin
    Result := Result.Parent;
    Dec(ALevel);
  end;
end;

function TcxTreeListControlReportLinkFormatter.GetNextNode(ANode: TcxTreeListNode): TcxTreeListNode;
var
  Index: Integer;
begin
  Index := IndexOfNode(ANode);
  if Index < NodeCount - 1 then
    Result := Nodes[Index + 1]
  else
    Result := nil;  
end;

function TcxTreeListControlReportLinkFormatter.GetPrevNode(ANode: TcxTreeListNode): TcxTreeListNode;
var
  Index: Integer;
begin
  Index := IndexOfNode(ANode);
  if Index > 0 then
    Result := Nodes[Index - 1]
  else
    Result := nil;  
end;

function TcxTreeListControlReportLinkFormatter.GetStyleFontIndex(const AParams: TdxReportItemViewParams): Integer;
begin
  if AParams.NativeParams.Font <> nil then 
  begin
    FFont.Assign(AParams.NativeParams.Font);
    if not dxPSUtl.dxIsTrueTypeFont(FFont) then
      FFont.Name := ReportLink.Font.Name;
    FFont.Color := ColorToRGB(AParams.NativeParams.TextColor);
    FFont.Style := FFont.Style + AParams.FontStyle;
    Result := ReportLink.AddFontToPool(FFont);
  end  
  else    
    Result := 0;
end;

function TcxTreeListControlReportLinkFormatter.HasParent(ANode: TcxTreeListNode): Boolean;
begin
  Result := ANode.Level > 0;
end;

function TcxTreeListControlReportLinkFormatter.IndexOfNode(ANode: TcxTreeListNode): Integer;
begin
  Result := FNodes.IndexOf(ANode);
end;

function TcxTreeListControlReportLinkFormatter.IsColorTransparent(AColor: TColor): Boolean;
begin
  Result := ColorToRGB(AColor) = ColorToRGB(TransparentColor);
end;

function TcxTreeListControlReportLinkFormatter.IsFirstNode(ANode: TcxTreeListNode): Boolean; 
begin
  Result := ANode = FNodes.First;
end;

function TcxTreeListControlReportLinkFormatter.IsLastNode(ANode: TcxTreeListNode): Boolean; 
begin
  Result := ANode = FNodes.Last;
end;

function TcxTreeListControlReportLinkFormatter.IsNodeExpanded(ANode: TcxTreeListNode): Boolean;
var
  NextNode: TcxTreeListNode;
begin
  Result := ANode.Expanded;
  if not Result then
  begin
    NextNode := GetNextNode(ANode);
    Result := (NextNode <> nil) and (NextNode.Level > ANode.Level);
  end;
end;

function TcxTreeListControlReportLinkFormatter.IsNodeFirstChild(ANode: TcxTreeListNode): Boolean;
begin
  Result := ANode.IsFirst;
end;

function TcxTreeListControlReportLinkFormatter.IsNodeLastChild(ANode: TcxTreeListNode): Boolean;
begin                                             
  Result := ANode.IsLast;
end;

function TcxTreeListControlReportLinkFormatter.IsOddNode(ANode: TcxTreeListNode): Boolean;
begin
  Result := Odd(FNodes.IndexOf(ANode));
end;

function TcxTreeListControlReportLinkFormatter.IsNodeSelected(ANode: TcxTreeListNode): Boolean;
begin
  Result := ANode.Selected; 
end;

procedure TcxTreeListControlReportLinkFormatter.RegisterLookAndFeelItem(AnItem: TdxReportVisualItem; 
  AEdgeStyle: TdxCellEdgeStyle);
begin
  AnItem.EdgeMode := cem3DEffects;
  AnItem.Edge3DStyle := AEdgeStyle;
  FLookAndFeelItems.Add(AnItem);
end;

procedure TcxTreeListControlReportLinkFormatter.SetViewParams(AnItem: TdxReportVisualItem; 
  const AParams: TdxReportItemViewParams);
begin
  with AnItem do 
  begin
    CellSides := AParams.CellSides;
    Color := ColorToRGB(AParams.NativeParams.Color);
    FontIndex := GetStyleFontIndex(AParams);
    Transparent := AParams.Transparent;
  end;
end;

function TcxTreeListControlReportLinkFormatter.MakeIndentIndex(AnIndex: Integer): DWORD;
begin
  Result := ReportLink.MakeIndentIndex(AnIndex);
end;

function TcxTreeListControlReportLinkFormatter.GetAutoWidth: Boolean;
begin
  Result := ReportLink.OptionsSize.AutoWidth;
end;

function TcxTreeListControlReportLinkFormatter.GetDC: HDC;
begin
  Result := ReportLink.ScreenDC;
end;

function TcxTreeListControlReportLinkFormatter.GetExpandButtonColor: TColor;
begin
  Result := ExpandButtonInteriorColors[Adapter.TreeLinesStyle = tllsSolid];
end;

function TcxTreeListControlReportLinkFormatter.GetExpandButtonSize: Integer;
begin
  Result := DefaultExpandButtonSize;
end;

function TcxTreeListControlReportLinkFormatter.GetGridLinesColor: TColor;
begin
  Result := ReportLink.OptionsFormatting.GridLineColor;
  if Result = clDefault then
    Result := Adapter.GridLinesColor;
end;

function TcxTreeListControlReportLinkFormatter.GetHasNodeSeparator: Boolean;
begin
  Result := NodeSeparatorThickness > 0;
end;

function TcxTreeListControlReportLinkFormatter.GetHasPreview: Boolean;
begin
  Result := Adapter.HasPreview and ShowPreview and (PreviewAutoHeight or (PreviewMaxLineCount > 0));
end;

function TcxTreeListControlReportLinkFormatter.GetIndentCount(Node: TcxTreeListNode): Integer;
begin
  Result := Node.Level;
  if Adapter.ShowRoot then Inc(Result);
end;

function TcxTreeListControlReportLinkFormatter.GetIsNodeColorUsedForIndents: Boolean;
begin
  Result := Adapter.IsNodeColorUsedForIndents;
end;

function TcxTreeListControlReportLinkFormatter.GetLookAndFeelItem(Index: Integer): TdxReportVisualItem;
begin
  Result := TdxReportVisualItem(FLookAndFeelItems[Index]);
end;

function TcxTreeListControlReportLinkFormatter.GetLookAndFeelItemCount: Integer;
begin
  Result := FLookAndFeelItems.Count;
end;

function TcxTreeListControlReportLinkFormatter.GetNode(Index: Integer): TcxTreeListNode;
begin
  Result := TcxTreeListNode(FNodes[Index]);
end;

function TcxTreeListControlReportLinkFormatter.GetNodeCount: Integer;
begin
  Result := FNodes.Count;
end;

function TcxTreeListControlReportLinkFormatter.GetNodeSeparatorColor: TColor;
begin
  Result := ReportLink.OptionsFormatting.ActualNodeSeparatorColor;
end;

function TcxTreeListControlReportLinkFormatter.GetNodeSeparatorThickness: Integer;
begin
  Result := ReportLink.OptionsFormatting.NodeSeparatorThickness;
end;

function TcxTreeListControlReportLinkFormatter.GetPreviewAutoHeight: Boolean;
begin
  Result := ReportLink.OptionsPreview.AutoHeight;
end;

function TcxTreeListControlReportLinkFormatter.GetPreviewColumn: TcxTreeListColumn;
begin
  Result := Adapter.PreviewColumn;
end;

function TcxTreeListControlReportLinkFormatter.GetPreviewMaxLineCount: Integer;
begin
  Result := ReportLink.OptionsPreview.MaxLineCount;
end;

function TcxTreeListControlReportLinkFormatter.GetRenderer: TdxPSReportRenderer;
begin
  Result := ReportLink.Renderer;
end;

function TcxTreeListControlReportLinkFormatter.GetShowBandHeaders: Boolean;
begin
  Result := ReportLink.OptionsView.BandHeaders;
end;

function TcxTreeListControlReportLinkFormatter.GetShowFooters: Boolean;
begin
 Result := ReportLink.OptionsView.Footers;
end;

function TcxTreeListControlReportLinkFormatter.GetShowHeaders: Boolean;
begin
  Result := ReportLink.OptionsView.Headers;
end;

function TcxTreeListControlReportLinkFormatter.GetShowPreview: Boolean;
begin
  Result := ReportLink.OptionsPreview.Visible;
end;

function TcxTreeListControlReportLinkFormatter.GetUseLookAndFeelColors: Boolean;
begin
  Result := ReportLink.OptionsFormatting.UseLookAndFeelColors;
end;

function TcxTreeListControlReportLinkFormatter.GetViewWidth: Integer;
begin
  Result := Adapter.ViewWidth;
end;

function TcxTreeListControlReportLinkFormatter.GetTreeLinesColor: TColor;
begin
  Result := Adapter.TreeLinesColor;
end;

function TcxTreeListControlReportLinkFormatter.GetTreeLinesStyle: TcxTreeListTreeLineStyle;
begin
  Result := Adapter.TreeLinesStyle;
end;

procedure TcxTreeListControlReportLinkFormatter.FormatLookAndFeelItems;
const
  Borders3D: array[TdxCellEdgeStyle, Boolean] of TdxPSCellBorderClass = 
   ((TdxPSCellRaisedBorder, TdxPSCellRaisedSoftBorder), 
    (TdxPSCellSunkenBorder, TdxPSCellSunkenSoftBorder));
var
  I: Integer;
begin
  for I := 0 to LookAndFeelItemCount - 1 do
    with LookAndFeelItems[I] do 
      if ReportLink.Effects3D then
        BorderClass := Borders3D[Edge3DStyle, ReportLink.Soft3D]
      else
        BorderClass := TdxPSCellUltraFlatBorder;
end;

{ TcxTreeListReportLinkOptionsExpanding }

procedure TcxTreeListReportLinkOptionsExpanding.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListReportLinkOptionsExpanding then 
    with TcxTreeListReportLinkOptionsExpanding(Source) do 
    begin
      Self.AutoExpandNodes := AutoExpandNodes;
      Self.ExplicitlyExpandNodes := ExplicitlyExpandNodes;
    end;
  inherited;
end;

procedure TcxTreeListReportLinkOptionsExpanding.RestoreDefaults;
begin
  inherited;
  AutoExpandNodes := False;
  ExplicitlyExpandNodes := False;
end;

function TcxTreeListReportLinkOptionsExpanding.DesignerTabIndex: Integer;
begin
  Result := 1;
end;

function TcxTreeListReportLinkOptionsExpanding.GetReportLink: TcxTreeListControlReportLink;
begin
  Result := inherited ReportLink as TcxTreeListControlReportLink;
end;

procedure TcxTreeListReportLinkOptionsExpanding.SetAutoExpandNodes(Value: Boolean);
begin
  if FAutoExpandNodes <> Value then 
  begin
    FAutoExpandNodes := Value;
    Changed;
  end;
end;

procedure TcxTreeListReportLinkOptionsExpanding.SetExplicitlyExpandNodes(Value: Boolean);
begin
  if FExplicitlyExpandNodes <> Value then 
  begin
    FExplicitlyExpandNodes := Value;
    Changed;
  end;
end;

{ TcxTreeListReportLinkOptionsFormatting }

procedure TcxTreeListReportLinkOptionsFormatting.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListReportLinkOptionsFormatting then 
    with TcxTreeListReportLinkOptionsFormatting(Source) do 
    begin
      Self.ConsumeSelectionStyle := ConsumeSelectionStyle;
      Self.NodeSeparatorColor := NodeSeparatorColor;
      Self.NodeSeparatorThickness := NodeSeparatorThickness;
    end;
  inherited;
end;

procedure TcxTreeListReportLinkOptionsFormatting.RestoreDefaults;
begin
  inherited;
  ConsumeSelectionStyle := False;
  NodeSeparatorColor := clDefault;
  NodeSeparatorThickness := 0;
end;

function TcxTreeListReportLinkOptionsFormatting.DesignerTabIndex: Integer;
begin
  Result := 2;
end;

function TcxTreeListReportLinkOptionsFormatting.GetActualNodeSeparatorColor: TColor;
begin
  Result := NodeSeparatorColor;
  if Result = clDefault then
    Result := dxPSDefaultTreeListNodeSeparatorColor;
end;

function TcxTreeListReportLinkOptionsFormatting.GetReportLink: TcxTreeListControlReportLink;
begin
  Result := inherited ReportLink as TcxTreeListControlReportLink;
end;

procedure TcxTreeListReportLinkOptionsFormatting.SetConsumeSelectionStyle(Value: Boolean);
begin
  if FConsumeSelectionStyle <> Value then
  begin
    FConsumeSelectionStyle := Value;
    Changed;
  end;
end;

procedure TcxTreeListReportLinkOptionsFormatting.SetNodeSeparatorColor(Value: TColor);
begin
  if FNodeSeparatorColor <> Value then
  begin
    FNodeSeparatorColor := Value;
    if NodeSeparatorThickness <> 0 then Changed;
  end;
end;

procedure TcxTreeListReportLinkOptionsFormatting.SetNodeSeparatorThickness(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FNodeSeparatorThickness <> Value then
  begin
    FNodeSeparatorThickness := Value;
    Changed;
  end;
end;

{ TcxTreeListReportLinkOptionsOnEveryPage }

function TcxTreeListReportLinkOptionsOnEveryPage.DesignerTabIndex: Integer;
begin
  Result := 0;
end;

function TcxTreeListReportLinkOptionsOnEveryPage.GetReportLink: TcxTreeListControlReportLink;
begin
  Result := inherited ReportLink as TcxTreeListControlReportLink;
end;

{ TcxTreeListReportLinkOptionsPagination }

function TcxTreeListReportLinkOptionsPagination.DesignerTabIndex: Integer;
begin
  Result := 0;
end;

function TcxTreeListReportLinkOptionsPagination.GetNode: Boolean;
begin
  Result := inherited Row;
end;

function TcxTreeListReportLinkOptionsPagination.GetReportLink: TcxTreeListControlReportLink;
begin
  Result := inherited ReportLink as TcxTreeListControlReportLink;
end;

procedure TcxTreeListReportLinkOptionsPagination.SetNode(Value: Boolean);
begin
  inherited Row := Value;
end;

{ TcxTreeListReportLinkOptionsPreview }

function TcxTreeListReportLinkOptionsPreview.DesignerTabIndex: Integer;
begin
  Result := 4;
end;

function TcxTreeListReportLinkOptionsPreview.GetReportLink: TcxTreeListControlReportLink;
begin
  Result := inherited ReportLink as TcxTreeListControlReportLink;
end;

{ TcxTreeListReportLinkOptionsRefinements }

function TcxTreeListReportLinkOptionsRefinements.DesignerTabIndex: Integer;
begin
  Result := 2;
end;

function TcxTreeListReportLinkOptionsRefinements.GetReportLink: TcxTreeListControlReportLink;
begin
  Result := inherited ReportLink as TcxTreeListControlReportLink;
end;

{ TcxTreeListReportLinkOptionsSelection }

function TcxTreeListReportLinkOptionsSelection.DesignerTabIndex: Integer;
begin
  Result := 1;
end;

function TcxTreeListReportLinkOptionsSelection.GetReportLink: TcxTreeListControlReportLink;
begin
  Result := inherited ReportLink as TcxTreeListControlReportLink;
end;

{ TcxTreeListReportLinkOptionsSize }

function TcxTreeListReportLinkOptionsSize.DesignerTabIndex: Integer;
begin
  Result := 1;
end;

function TcxTreeListReportLinkOptionsSize.GetReportLink: TcxTreeListControlReportLink;
begin
  Result := inherited ReportLink as TcxTreeListControlReportLink;
end;

{ TcxTreeListReportLinkOptionsView }

procedure TcxTreeListReportLinkOptionsView.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListReportLinkOptionsView then 
    with TcxTreeListReportLinkOptionsView(Source) do 
    begin
      Self.Borders := Borders;
      Self.TreeLines := TreeLines;
    end;
  inherited;
end;

procedure TcxTreeListReportLinkOptionsView.RestoreDefaults;
begin
  inherited;
  Borders := True;
  TreeLines := True;
end;

function TcxTreeListReportLinkOptionsView.DesignerTabIndex: Integer;
begin
  Result := 0;
end;

function TcxTreeListReportLinkOptionsView.GetReportLink: TcxTreeListControlReportLink;
begin
  Result := inherited ReportLink as TcxTreeListControlReportLink;
end;

procedure TcxTreeListReportLinkOptionsView.SetBorders(Value: Boolean);
begin
  if FBorders <> Value then 
  begin
    FBorders := Value;
    Changed;
  end;
end;

procedure TcxTreeListReportLinkOptionsView.SetTreeLines(Value: Boolean);
begin
  if FTreeLines <> Value then 
  begin
    FTreeLines := Value;
    Changed;
  end;  
end;

{ TcxTreeListReportLinkStyles }

procedure TcxTreeListReportLinkStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxTreeListReportLinkStyles then
    with TcxTreeListReportLinkStyles(Source) do
    begin
      Self.BandHeader := BandHeader;
      Self.Content := Content;
      Self.ContentEven := ContentEven;
      Self.ContentOdd := ContentOdd;
      Self.Footer := Footer;
      Self.FooterRow := FooterRow;
      Self.Header := Header;
      Self.Preview := Preview;
    end;
end;

procedure TcxTreeListReportLinkStyles.GetBandHeaderParams(ABand: TcxTreeListBand;
  out AParams: TcxViewParams);
begin
  GetViewParams(vspsTreeListBandHeader, ABand, nil, AParams);
end;

procedure TcxTreeListReportLinkStyles.GetColumnFooterParams(ANode: TcxTreeListNode;
  AColumn: TcxTreeListColumn; out AParams: TcxViewParams);
begin
  GetViewParams(vspsTreeListFooter, ANode, nil, AParams);
end;

procedure TcxTreeListReportLinkStyles.GetColumnHeaderParams(AColumn: TcxTreeListColumn;
  out AParams: TcxViewParams);
begin
  GetViewParams(vspsTreeListHeader, nil, nil, AParams);
end;

procedure TcxTreeListReportLinkStyles.GetContentParams(ANode: TcxTreeListNode;
  AColumn: TcxTreeListColumn; out AParams: TcxViewParams);

  function IsOddNode(ANode: TcxTreeListNode): Boolean;
  var
    Builder: TcxTreeListControlReportLinkBuilder;
  begin
    Builder := ReportLink.Builder;
    if Builder <> nil then 
      Result := Builder.Formatter.IsOddNode(ANode)
    else
      Result := Odd(ANode.VisibleIndex);
  end;

const
  StyleIndexes: array[Boolean] of Integer = (vspsTreeListContentEven, vspsTreeListContentOdd);
begin
  if (ANode <> nil) and (GetValue(StyleIndexes[IsOddNode(ANode)]) <> nil) then
    GetViewParams(StyleIndexes[IsOddNode(ANode)], ANode, nil, AParams)
  else
    GetViewParams(vspsTreeListContent, ANode, nil, AParams);
end;

procedure TcxTreeListReportLinkStyles.GetFooterRowParams(out AParams: TcxViewParams);
begin
  GetViewParams(vspsTreeListFooterRow, nil, nil, AParams);
end;

procedure TcxTreeListReportLinkStyles.GetImagesParams(ANode: TcxTreeListNode; 
  out AParams: TcxViewParams);
begin
  GetContentParams(ANode, nil, AParams);
end;  

procedure TcxTreeListReportLinkStyles.GetIndentParams(ANode: TcxTreeListNode; 
  AnIndent: Integer; out AParams: TcxViewParams);
  
  function IsNodeColorUsedForIndents: Boolean;
  var
    Builder: TcxTreeListControlReportLinkBuilder;
  begin
    Builder := ReportLink.Builder;
    Result := (Builder <> nil) and Builder.Formatter.IsNodeColorUsedForIndents;
  end;
  
begin
  if IsNodeColorUsedForIndents then 
    GetContentParams(ANode, nil, AParams)
  else
    GetViewParams(vspsTreeListIndent, ANode, nil{AnIndent}, AParams);
end;  

procedure TcxTreeListReportLinkStyles.GetPreviewParams(ANode: TcxTreeListNode;
  AColumn: TcxTreeListColumn; out AParams: TcxViewParams);
begin
  GetViewParams(vspsTreeListPreview, ANode, nil, AParams);
end;

procedure TcxTreeListReportLinkStyles.GetSelectionParams(out AParams: TcxViewParams); 
begin
  GetViewParams(vspsTreeListSelection, nil, nil, AParams);
end;

function TcxTreeListReportLinkStyles.DesignerTabIndex: Integer;
begin
  Result := 3;
end;

procedure TcxTreeListReportLinkStyles.GetDefaultViewParams(Index: Integer; AData: TObject; 
  out AParams: TcxViewParams);
const
  FixedParts = [vspsTreeListBandHeader, vspsTreeListFooter, vspsTreeListFooterRow, 
    vspsTreeListHeader, vspsTreeListSelection];
begin
  inherited;
  if ReportLink <> nil then
    with AParams do 
    begin
      if Index in FixedParts then
        Color := dxPSCore.dxDefaultFixedColor
      else
        Color := dxPSCore.dxDefaultContentColor; //TreeListReportLink.Color;  // ???

      Font := ReportLink.Font;
      TextColor := Font.Color;
    end;  
end;
                         
class function TcxTreeListReportLinkStyles.GetStyleCaption(AnIndex: Integer): string;
begin
  case AnIndex of
    vspsTreeListBandHeader:
      Result := cxGetResourceString(@sdxBandHeaderStyle);
    vspsTreeListContent:
      Result := cxGetResourceString(@sdxContentStyle);
    vspsTreeListContentEven:
      Result := cxGetResourceString(@sdxContentEvenStyle);
    vspsTreeListContentOdd:
      Result := cxGetResourceString(@sdxContentOddStyle);
    vspsTreeListFooter:
      Result := cxGetResourceString(@sdxFooterStyle);
    vspsTreeListFooterRow:
      Result := cxGetResourceString(@sdxFooterRowStyle);
    vspsTreeListHeader:
      Result := cxGetResourceString(@sdxHeaderStyle);
    vspsTreeListIndent:
      Result := cxGetResourceString(@sdxIndentStyle);
    vspsTreeListPreview:
      Result := cxGetResourceString(@sdxPreviewStyle);
  else  
    Result := cxGetResourceString(@sdxSelectionStyle);
  end;
end;

function TcxTreeListReportLinkStyles.GetStyleIndexByCaption(const Caption: string): Integer;
begin
  for Result := vspsTreeListFirst to vspsTreeListLast do
    if dxPSUtl.dxSameText(Caption, GetStyleCaption(Result)) then 
      Exit;
  Result := -1;
end;

function TcxTreeListReportLinkStyles.GetReportLink: TcxTreeListControlReportLink;
begin
  Result := inherited ReportLink as TcxTreeListControlReportLink;
end;

{ TcxTreeListReportLinkStyleSheet }

class function TcxTreeListReportLinkStyleSheet.GetStylesClass: TcxCustomStylesClass;
begin
  Result := TcxTreeListReportLinkStyles; 
end;

function TcxTreeListReportLinkStyleSheet.GetStylesValue: TcxTreeListReportLinkStyles;
begin
  if GetStyles is TcxTreeListReportLinkStyles then
    Result := TcxTreeListReportLinkStyles(GetStyles)
  else
    Result := nil;
end;

procedure TcxTreeListReportLinkStyleSheet.SetStylesValue(Value: TcxTreeListReportLinkStyles);
begin
  SetStyles(Value);
end;

{ TcxTreeListControlAttributeHostInfo }

procedure TcxTreeListControlAttributeHostInfo.Initialize(AParent: TdxReportCell);
begin                    
  Origin := NullPoint;
  FParent := AParent;
end;

{ TcxTreeListControlAttributeHostInfoServices }

constructor TcxTreeListAttributeHostInfoServices.Create(AReportLink: TcxTreeListControlReportLink);
begin
  inherited Create;
  FReportLink := AReportLink;
  CreateHostInfos;
end;

destructor TcxTreeListAttributeHostInfoServices.Destroy;
begin
  DestroyHostInfos;
  inherited;
end;

procedure TcxTreeListAttributeHostInfoServices.InitializeHostInfos;
begin
  PageDetailsHostInfo.Initialize(PageDetails);
  PageFootersHostInfo.Initialize(PageFooters);
  PageHeadersHostInfo.Initialize(PageHeaders);
end;

procedure TcxTreeListAttributeHostInfoServices.CreateHostInfos;
begin
  FPageDetailsHostInfo := TcxTreeListControlAttributeHostInfo.Create;
  FPageFootersHostInfo := TcxTreeListControlAttributeHostInfo.Create;
  FPageHeadersHostInfo := TcxTreeListControlAttributeHostInfo.Create;
end;

procedure TcxTreeListAttributeHostInfoServices.DestroyHostInfos;
begin
  FreeAndNil(FPageHeadersHostInfo);
  FreeAndNil(FPageFootersHostInfo);
  FreeAndNil(FPageDetailsHostInfo);
end;

function TcxTreeListAttributeHostInfoServices.GetBandHeadersHostInfo: TcxTreeListControlAttributeHostInfo;
begin
  if CanUseBandHeadersOnEveyPage then
    Result := PageHeadersHostInfo
  else
    Result := PageDetailsHostInfo;
end;

function TcxTreeListAttributeHostInfoServices.GetFootersHostInfo: TcxTreeListControlAttributeHostInfo;
begin
  if CanUseFootersOnEveryPage then 
    Result := PageFootersHostInfo
  else
    Result := PageDetailsHostInfo;
end;

function TcxTreeListAttributeHostInfoServices.GetHeadersHostInfo: TcxTreeListControlAttributeHostInfo;
begin
  if CanUseHeadersOnEveryPage then 
    Result := PageHeadersHostInfo
  else
    Result := PageDetailsHostInfo;
end;

function TcxTreeListAttributeHostInfoServices.GetInconsistentStateText: string;
begin
  if ReportLink.IsAggregated then
    Result := cxGetResourceString(@sdxCannotUseOnEveryPageModeInAggregatedState)
  else
    if IsInconsistentHeadersState then
      Result := cxGetResourceString(@sdxTLIncorrectHeadersState)
    else
      Result := '';
end;

function TcxTreeListAttributeHostInfoServices.GetIsInconsistentState: Boolean;
begin
  Result := ReportLink.IsAggregated or IsInconsistentHeadersState;
end;

function TcxTreeListAttributeHostInfoServices.HasCells: Boolean;
begin
  Result := ReportLink.ReportCells <> nil;
end;

function TcxTreeListAttributeHostInfoServices.GetArePageFootersAssigned: Boolean;
begin
  Result := FootersHostInfo.Parent = ReportLink.ReportCells.FooterCells;
end;

function TcxTreeListAttributeHostInfoServices.GetArePageHeadersAssigned: Boolean;
begin
  with ReportLink.ReportCells do 
    Result := (BandHeadersHostInfo.Parent = HeaderCells) or (HeadersHostInfo.Parent = HeaderCells);
end;

function TcxTreeListAttributeHostInfoServices.GetCanUseBandHeadersOnEveyPage: Boolean;
begin
  Result := not ReportLink.IsAggregated and OptionsOnEveryPage.BandHeaders;
end;

function TcxTreeListAttributeHostInfoServices.GetCanUseFootersOnEveryPage: Boolean;
begin
  Result := not ReportLink.IsAggregated and OptionsOnEveryPage.Footers;
end;

function TcxTreeListAttributeHostInfoServices.GetCanUseHeadersOnEveryPage: Boolean;
begin
  Result := not ReportLink.IsAggregated and OptionsOnEveryPage.Headers and 
    ((BandHeadersHostInfo = PageHeadersHostInfo) or not OptionsView.BandHeaders);
end;

function TcxTreeListAttributeHostInfoServices.GetIsInconsistentHeadersState: Boolean;
begin
  Result := OptionsOnEveryPage.Headers and OptionsView.Headers and OptionsView.BandHeaders and not OptionsOnEveryPage.BandHeaders;
end;

function TcxTreeListAttributeHostInfoServices.GetOptionsOnEveryPage: TcxTreeListReportLinkOptionsOnEveryPage;
begin
  Result := ReportLink.OptionsOnEveryPage;
end;

function TcxTreeListAttributeHostInfoServices.GetOptionsView: TcxTreeListReportLinkOptionsView;
begin
  Result := ReportLink.OptionsView;
end;

function TcxTreeListAttributeHostInfoServices.GetPageDetails: TdxReportCell;
begin
  if HasCells then 
    Result := ReportLink.ReportCells.Cells
  else  
    Result := nil;
end;

function TcxTreeListAttributeHostInfoServices.GetPageFooters: TdxReportCell;
begin
  if HasCells then
    Result := ReportLink.ReportCells.FooterCells
  else
    Result := PageDetails;
end;

function TcxTreeListAttributeHostInfoServices.GetPageHeaders: TdxReportCell;
begin
  if HasCells then
    Result := ReportLink.ReportCells.HeaderCells
  else
    Result := PageDetails;
end;

{ TcxTreeListControlReportLink }

constructor TcxTreeListControlReportLink.Create(AOwner: TComponent);
begin
  inherited;
  FDelimitersHardVert := TList.Create;
  FHostInfoServices := TcxTreeListAttributeHostInfoServices.Create(Self);      
  FReportRows := TList.Create;
  InternalRestoreDefaults;
  LinkModified(False);
end;

destructor TcxTreeListControlReportLink.Destroy;
begin
  FreeAndNil(FReportRows);
  FreeAndNil(FHostInfoServices);
  FreeAndNil(FDelimitersHardVert);
  inherited;
end;

procedure TcxTreeListControlReportLink.AddPageBreak(ANode: TcxTreeListNode);
var
  ReportRow: TdxReportCell; 
begin
  ReportRow := ReportRowsByNode[ANode];
  if ReportRow <> nil then
    AddVerticalHardDelimiter(ReportRow);
end;

procedure TcxTreeListControlReportLink.AddPageBreak(const ANodes: array of TcxTreeListNode);
var
  I: Integer;
begin
  for I := Low(ANodes) to High(ANodes) do
    AddPageBreak(ANodes[I]);
end;

procedure TcxTreeListControlReportLink.AddPageBreak(const ANodes: TcxTreeListNodeArray);
var
  I: Integer;
begin
  for I := 0 to Length(ANodes) - 1 do
    AddPageBreak(ANodes[I]);
end;

procedure TcxTreeListControlReportLink.AddPageBreak(ANodes: TList);
var
  I: Integer;
  P:  Pointer ;
begin
  for I := 0 to ANodes.Count - 1 do
  begin
    P := ANodes[I];
    if TObject(P) is TcxTreeListNode then 
      AddPageBreak(TcxTreeListNode(P));
  end;    
end;

procedure TcxTreeListControlReportLink.ConstructReport(AReportCells: TdxReportCells);

  function HasData: Boolean;
  begin
    Result := (CustomTreeListControl_GetVisibleColumnCount(TreeListControl) <> 0) and 
     (CustomTreeListControl_GetNodes(TreeListControl).Count <> 0);
  end;
  
  procedure Build;
  begin
    FBuilder := CreateBuilder;
    try
      FBuilder.Build;
    finally
      FreeAndNil(FBuilder);
    end;
  end;         

  procedure CalculateSizes;
  
    procedure CalculateReportPartSizes(ACell: TdxReportCell);
    var
      Width, I, V: Integer;
    begin
      if ACell.CellCount > 0 then   
      begin
        Width := 0;
        for I := 0 to ACell.CellCount - 1 do
        begin
          V := ACell.Cells[I].Width;
          if Width < V then Width := V;
        end;
        ACell.BoundsRect := MakeRect(0, 0, Width, ACell[ACell.CellCount - 1].BoundsRect.Bottom);
      end;  
    end;
  
  begin
    with AReportCells do 
    begin
      CalculateReportPartSizes(Cells);
      if AreFooterCellsAllocated then CalculateReportPartSizes(FooterCells);
      if AreHeaderCellsAllocated then CalculateReportPartSizes(HeaderCells);
    end;
  end; 
  
begin
  if TreeListControl = nil then Exit;
  inherited;
  if not HasData then Exit;
  
  PrepareConstruct;
  try
    Build;
    if not AbortBuilding then CalculateSizes;
  finally
    UnprepareConstruct;
  end;  
end;

procedure TcxTreeListControlReportLink.ConvertCoords;
begin
  inherited;
  ConvertDelimiters(DelimitersHardVert);
end;

procedure TcxTreeListControlReportLink.CustomDraw(AItem: TAbstractdxReportCellData;
  ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; var ADone: Boolean);
var
  DrawInfo: TcxTreeListCellCustomDrawInfo;
begin
  GetItemCustomDrawInfo(AItem, DrawInfo);
  with DrawInfo do
    case AttributeID of 
      cxTreeListBandID:
        DoCustomDrawBandCell(ACanvas, Band, TdxReportCellImage(AItem), ADone);
      cxTreeListFooterID:
        DoCustomDrawFooterCell(ACanvas, Column, TdxReportCellString(AItem), ADone);
      cxTreeListHeaderID:
        DoCustomDrawHeaderCell(ACanvas, Column, TdxReportCellImage(AItem), ADone);
      cxTreeListIndentID:
        DoCustomDrawIndentCell(ACanvas, Node, Index, AItem, ADone);
      cxTreeListNodeID:
        DoCustomDrawCell(ACanvas, Node, Column, AItem, ADone);      
    end;
end;

function TcxTreeListControlReportLink.GetBreakPagesByHardDelimiters: Boolean;
begin
  Result := OptionsPagination.Custom;
end;

procedure TcxTreeListControlReportLink.GetImageLists(AProc: TdxPSGetImageListProc);
begin
  inherited;
  AProc(CustomTreeListControl_GetImages(TreeListControl));
  AProc(CustomTreeListControl_GetStateImages(TreeListControl));
end;

function TcxTreeListControlReportLink.GetRebuildOnPageParamsChange(AUpdateCodes: TdxPrinterPageUpdateCodes): Boolean; 
begin
  Result := (AUpdateCodes * uaMarginsVert  <> []) and OptionsSize.AutoWidth;          
end;

function TcxTreeListControlReportLink.GetUseHardVertDelimiters: Boolean;
begin
  Result := OptionsPagination.Custom;
end;

procedure TcxTreeListControlReportLink.InternalRestoreFromOriginal;
var
  TreeListOptionsView: TcxTreeListOptionsView;
  TreeListPreview: TcxTreeListPreview;
begin
  inherited;
  if TreeListControl <> nil then 
  begin
    OptionsFormatting.LookAndFeelKind := CustomTreeListControl_GetLookAndFeel(TreeListControl).Kind;

    TreeListPreview := CustomTreeListControl_GetPreview(TreeListControl);
    with OptionsPreview do 
    begin
      AutoHeight := TreeListPreview.AutoHeight;
      MaxLineCount := TreeListPreview.MaxLineCount;
      Visible := TreeListPreview.Visible;
    end;
    
    TreeListOptionsView :=  CustomTreeListControl_GetOptionsView(TreeListControl);
    with OptionsView do 
    begin
      BandHeaders := TreeListOptionsView.Bands;
      ExpandButtons := TreeListOptionsView.Buttons;
      Footers := TreeListOptionsView.Footer;
      Headers := TreeListOptionsView.Headers;
      TreeLines := TreeListOptionsView.TreeLineStyle <> tllsNone;
    end;
    OptionsSize.AutoWidth := TreeListOptionsView.ColumnAutoWidth;
  end;  
end;
                                    
function TcxTreeListControlReportLink.IsDrawFootersOnEveryPage: Boolean;
begin
  Result := HostInfoServices.ArePageFootersAssigned;
end;

function TcxTreeListControlReportLink.IsDrawHeadersOnEveryPage: Boolean;
begin
  Result := HostInfoServices.ArePageHeadersAssigned;
end;

function TcxTreeListControlReportLink.IsSupportedCustomDraw(Item: TAbstractdxReportCellData): Boolean;
var
  DrawInfo: TcxTreeListCellCustomDrawInfo;
begin
  Result := inherited IsSupportedCustomDraw(Item) and 
    (Item <> nil) and IsCustomDrawn(GetItemCustomDrawInfo(Item, DrawInfo));
end;

procedure TcxTreeListControlReportLink.MakeHardDelimiters(AReportCells: TdxReportCells; 
  AVertDelimiters: TList);
begin
  inherited;
  
  if OptionsPagination.Custom then 
  try
    DoGetCustomPageBreaks;
  except
    Application.HandleException(Self);
  end;
  dxPSUtl.dxCopyList(DelimitersHardVert, AVertDelimiters);
end;

function TcxTreeListControlReportLink.GetAreNativeStylesAvailable: Boolean;
begin
  Result := OptionsFormatting.UseNativeStyles;
end;
   
function TcxTreeListControlReportLink.GetStylesClass: TdxCustomReportLinkStylesClass;
begin
  Result := TcxTreeListReportLinkStyles;
end;

function TcxTreeListControlReportLink.GetStyleSheetClass: TdxCustomReportLinkStyleSheetClass;
begin
  Result := TcxTreeListReportLinkStyleSheet;
end;

function TcxTreeListControlReportLink.GetStyleSheetPrototype: TdxCustomReportLinkStyleSheet;
begin
  Result := DefaultdxPScxTreeListLinkStyleSheet;
end;

procedure TcxTreeListControlReportLink.PrepareConstruct;
begin
  inherited;
  DelimitersHardVert.Clear;
  FReportRows.Clear;
  
  ReportCells.LookAndFeel := nil;//CreateGroupLookAndFeel(TdxPSReportGroupNullLookAndFeel);
  
  HostInfoServices.InitializeHostInfos;
  if OptionsExpanding.ExplicitlyExpandNodes then
    TreeListControl.FullExpand;
end;

procedure TcxTreeListControlReportLink.DoCustomDrawBandCell(ACanvas: TCanvas; 
  ABand: TcxTreeListBand; AnItem: TdxReportCellImage; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawBandCell) then
    FOnCustomDrawBandCell(Self, ACanvas, ABand, AnItem, ADone);
end;
  
procedure TcxTreeListControlReportLink.DoCustomDrawCell(ACanvas: TCanvas; 
  ANode: TcxTreeListNode; AColumn: TcxTreeListColumn; 
  AnItem: TAbstractdxReportCellData; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawCell) then
    FOnCustomDrawCell(Self, ACanvas, ANode, AColumn, AnItem, ADone);
end;
  
procedure TcxTreeListControlReportLink.DoCustomDrawFooterCell(ACanvas: TCanvas; 
  AColumn: TcxTreeListColumn; AnItem: TdxReportCellString; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawFooterCell) then
    FOnCustomDrawFooterCell(Self, ACanvas, AColumn, AnItem, ADone);
end;
  
procedure TcxTreeListControlReportLink.DoCustomDrawHeaderCell(ACanvas: TCanvas; 
  AColumn: TcxTreeListColumn; AnItem: TdxReportCellImage; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawHeaderCell) then
    FOnCustomDrawHeaderCell(Self, ACanvas, AColumn, AnItem, ADone);
end;

procedure TcxTreeListControlReportLink.DoCustomDrawIndentCell(ACanvas: TCanvas; 
  ANode: TcxTreeListNode; AnIndex: Integer; AnItem: TAbstractdxReportCellData;
  var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawIndentCell) then
    FOnCustomDrawIndentCell(Self, ACanvas, ANode, AnIndex, AnItem, ADone);
end;  

procedure TcxTreeListControlReportLink.DoGetCustomPageBreaks;
begin
  if Assigned(FOnGetCustomPageBreaks) then FOnGetCustomPageBreaks(Self);
end;

procedure TcxTreeListControlReportLink.DoInitializeBandCell(ABand: TcxTreeListBand; 
  AnItem: TdxReportCellImage);
begin
  if Assigned(FOnInitializeBandCell) then 
    FOnInitializeBandCell(Self, ABand, AnItem);
end;  
  
procedure TcxTreeListControlReportLink.DoInitializeCell(ANode: TcxTreeListNode; 
  AColumn: TcxTreeListColumn; AnItem: TAbstractdxReportCellData);
begin
  if Assigned(FOnInitializeCell) then 
    FOnInitializeCell(Self, ANode, AColumn, AnItem);
end;  

procedure TcxTreeListControlReportLink.DoInitializeFooterCell(AColumn: TcxTreeListColumn; 
  AnItem: TdxReportCellString);
begin
  if Assigned(FOnInitializeFooterCell) then 
    FOnInitializeFooterCell(Self, AColumn, AnItem);
end;  
  
procedure TcxTreeListControlReportLink.DoInitializeHeaderCell(AColumn: TcxTreeListColumn; 
  AnItem: TdxReportCellImage);
begin
  if Assigned(FOnInitializeHeaderCell) then 
    FOnInitializeHeaderCell(Self, AColumn, AnItem);
end;  

procedure TcxTreeListControlReportLink.DoInitializeIndentCell(ANode: TcxTreeListNode; 
  AnIndex: Integer; AnItem: TAbstractdxReportCellData);
begin
  if Assigned(FOnInitializeIndentCell) then 
    FOnInitializeIndentCell(Self, ANode, AnIndex, AnItem);
end;  

function TcxTreeListControlReportLink.GetOptionsExpandingClass: TdxCustomReportLinkOptionsExpandingClass;
begin
  Result := TcxTreeListReportLinkOptionsExpanding;
end;

function TcxTreeListControlReportLink.GetOptionsFormattingClass: TdxCustomReportLinkOptionsFormattingClass;
begin
  Result := TcxTreeListReportLinkOptionsFormatting;
end;

function TcxTreeListControlReportLink.GetOptionsOnEveryPageClass: TdxCustomTableControlReportLinkOptionsOnEveryPageClass;
begin
  Result := TcxTreeListReportLinkOptionsOnEveryPage;
end;

function TcxTreeListControlReportLink.GetOptionsPaginationClass: TdxCustomReportLinkOptionsPaginationClass;
begin
  Result := TcxTreeListReportLinkOptionsPagination;
end;

function TcxTreeListControlReportLink.GetOptionsPreviewClass: TdxCustomTableControlReportLinkOptionsPreviewClass; 
begin
  Result := TcxTreeListReportLinkOptionsPreview;
end;

function TcxTreeListControlReportLink.GetOptionsRefinementsClass: TdxCustomReportLinkOptionsRefinementsClass;
begin
  Result := TcxTreeListReportLinkOptionsRefinements;
end;

function TcxTreeListControlReportLink.GetOptionsSelectionClass: TdxCustomTableControlReportLinkOptionsSelectionClass; 
begin
  Result := TcxTreeListReportLinkOptionsSelection;
end;

function TcxTreeListControlReportLink.GetOptionsSizeClass: TdxCustomReportLinkOptionsSizeClass;
begin
  Result := TcxTreeListReportLinkOptionsSize;
end;

function TcxTreeListControlReportLink.GetOptionsViewClass: TdxCustomReportLinkOptionsViewClass;
begin
  Result := TcxTreeListReportLinkOptionsView;
end;

procedure TcxTreeListControlReportLink.AddReportRow(AReportRow: TdxReportCell);
begin
  FReportRows.Add(AReportRow);
end;

procedure TcxTreeListControlReportLink.AddVerticalHardDelimiter(ADelimiter: TdxReportCell);
begin
  AddVerticalHardDelimiter(ADelimiter.AbsoluteRect.Top);
end;

procedure TcxTreeListControlReportLink.AddVerticalHardDelimiter(ADelimiter: Integer);
begin
  FDelimitersHardVert.Add(TObject(ADelimiter));
end;

function TcxTreeListControlReportLink.CreateBuilder: TcxTreeListControlReportLinkBuilder;
begin
  Result := GetBuilderClass.Create(Self);
end;

class function TcxTreeListControlReportLink.GetBuilderClass: TcxTreeListControlReportLinkBuilderClass;
begin
  Result := TcxTreeListControlReportLinkBuilder;
end;

function TcxTreeListControlReportLink.ExtractIndentIndex(AData: Integer): Integer;
begin
  Result := (AData and NodeIndentMask) shr NodeIndentOffset;
end;

function TcxTreeListControlReportLink.GetItemCustomDrawInfo(AnItem: TdxReportVisualItem; 
  out ADrawInfo: TcxTreeListCellCustomDrawInfo): TcxTreeListAttributeID;

  function IsBand(AData: DWORD): Boolean;
  begin
    try
      Result := IsDelphiObject(AData) and (TObject(AData) is TcxTreeListBand);
    except
      Result := False;
    end;
    if Result then  
    begin    
      ADrawInfo.Band := TcxTreeListBand(AData);
      ADrawInfo.AttributeID := cxTreeListBandID; 
    end;  
  end;
  
  function IsColumn(AData: DWORD): Boolean;
  begin
    try
      Result := IsDelphiObject(AData) and (TObject(AData) is TcxTreeListColumn);
    except
      Result := False;
    end;   
    if Result then
      ADrawInfo.Column := TcxTreeListColumn(AData);
  end;

  function IsFooter(AData: DWORD): Boolean;
  begin
    try
      Result := TClass(AData) = TcxTreeListFooterAttribute;
    except
      Result := False;
    end;
    if Result then
      ADrawInfo.AttributeID := cxTreeListFooterID;
  end;
  
  function IsHeader(AData: Integer): Boolean;
  begin
    try
      Result := IsDelphiObject(AData) and TClass(AData).InheritsFrom(TcxTreeListHeaderAttribute);
    except
      Result := False;
    end;
    if Result then
      ADrawInfo.AttributeID := cxTreeListHeaderID;
  end;

  function IsIndent(AData: DWORD): Boolean;
  begin
    Result := True;
    ADrawInfo.Index := ExtractIndentIndex(AData);
    ADrawInfo.AttributeID := cxTreeListIndentID;
  end;
  
  function IsNode(AData: DWORD): Boolean;
  begin
    try
      Result := IsDelphiObject(AData) and (TObject(AData) is TcxTreeListNode);
    except
      Result := False;
    end;
    if Result then
    begin
      ADrawInfo.Node := TcxTreeListNode(AData);
      ADrawInfo.AttributeID := cxTreeListNodeID;
    end;  
  end;

var
  Data: DWORD;  
begin     
  FillChar(ADrawInfo, SizeOf(ADrawInfo), 0);
  try
    try
      Data := AnItem.Data;
      if IsColumn(Data) then
      begin
        if AnItem.Parent <> nil then
        begin
          Data := AnItem.Parent.Data;
          if not IsNode(Data) then 
            if not IsHeader(Data) then IsFooter(Data);
        end;
      end
      else
        if not IsBand(Data) then IsIndent(Data);
    except
      FillChar(ADrawInfo, SizeOf(ADrawInfo), 0);
    end;  
  finally
     Result := ADrawInfo.AttributeID;
  end;  
end;

function TcxTreeListControlReportLink.IsCustomDrawn(AnAttributeID: TcxTreeListAttributeID): Boolean;
begin
  Result := False;
  case AnAttributeID of
    cxTreeListBandID:
      Result := Assigned(FOnCustomDrawBandCell);
    cxTreeListFooterID:
      Result := Assigned(FOnCustomDrawFooterCell);
    cxTreeListHeaderID:
      Result := Assigned(FOnCustomDrawHeaderCell);
    cxTreeListIndentID:
      Result := Assigned(FOnCustomDrawIndentCell);
    cxTreeListNodeID:
      Result := Assigned(FOnCustomDrawCell);
  end;    
end;

function TcxTreeListControlReportLink.MakeIndentIndex(AnIndex: Integer): DWORD;
begin
  Result := AnIndex shl NodeIndentOffset;
end;

function TcxTreeListControlReportLink.GetActiveStyles: TcxTreeListReportLinkStyles;
begin
  Result := inherited ActiveStyles as TcxTreeListReportLinkStyles;
end;

function TcxTreeListControlReportLink.GetDesignWindow: TdxfmTreeListReportLinkDesignWindow;
begin
  Result := inherited DesignWindow as TdxfmTreeListReportLinkDesignWindow;
end;

function TcxTreeListControlReportLink.GetReportRow(Index: Integer): TdxReportCell;
begin
  Result := FReportRows[Index];
end;

function TcxTreeListControlReportLink.GetReportRowByNode(Node: TcxTreeListNode): TdxReportCell;
var
  I: Integer;
begin
  if (Node <> nil) and not Node.IsFirstVisible then
    for I := 0 to ReportRowCount - 1 do 
    begin
      Result := ReportRows[I];
      if Result.Data = Integer(Node) then Exit;
    end;
  Result := nil;  
end;

function TcxTreeListControlReportLink.GetReportRowCount: Integer;
begin
  Result := FReportRows.Count;
end;

function TcxTreeListControlReportLink.GetOptionsExpanding: TcxTreeListReportLinkOptionsExpanding;
begin
  Result := inherited OptionsExpanding as TcxTreeListReportLinkOptionsExpanding;
end;

function TcxTreeListControlReportLink.GetOptionsFormatting: TcxTreeListReportLinkOptionsFormatting;
begin
  Result := inherited OptionsFormatting as TcxTreeListReportLinkOptionsFormatting;
end;

function TcxTreeListControlReportLink.GetOptionsOnEveryPage: TcxTreeListReportLinkOptionsOnEveryPage;
begin
  Result := inherited OptionsOnEveryPage as TcxTreeListReportLinkOptionsOnEveryPage;
end;

function TcxTreeListControlReportLink.GetOptionsPagination: TcxTreeListReportLinkOptionsPagination;
begin
  Result := inherited OptionsPagination as TcxTreeListReportLinkOptionsPagination;
end;

function TcxTreeListControlReportLink.GetOptionsPreview: TcxTreeListReportLinkOptionsPreview;
begin
  Result := inherited OptionsPreview as TcxTreeListReportLinkOptionsPreview;
end;

function TcxTreeListControlReportLink.GetOptionsRefinements: TcxTreeListReportLinkOptionsRefinements;
begin
  Result := inherited OptionsRefinements as TcxTreeListReportLinkOptionsRefinements;
end;

function TcxTreeListControlReportLink.GetOptionsSelection: TcxTreeListReportLinkOptionsSelection;
begin
  Result := inherited OptionsSelection as TcxTreeListReportLinkOptionsSelection;
end;

function TcxTreeListControlReportLink.GetOptionsSize: TcxTreeListReportLinkOptionsSize;
begin
  Result := inherited OptionsSize as TcxTreeListReportLinkOptionsSize;
end;

function TcxTreeListControlReportLink.GetOptionsView: TcxTreeListReportLinkOptionsView;
begin
  Result := inherited OptionsView as TcxTreeListReportLinkOptionsView;
end;

function TcxTreeListControlReportLink.GetStyles: TcxTreeListReportLinkStyles;
begin
  Result := inherited Styles as TcxTreeListReportLinkStyles;
end;

function TcxTreeListControlReportLink.GetTreeListControl: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(Component);
end;

procedure TcxTreeListControlReportLink.SetOnCustomDrawBandCell(Value: TcxTreeListReportLinkCustomDrawBandCellEvent);
begin
  if @FOnCustomDrawBandCell <> @Value then 
  begin
    FOnCustomDrawBandCell := Value;
    if SupportedCustomDraw then LinkModified(True);
  end;
end;

procedure TcxTreeListControlReportLink.SetOnCustomDrawCell(Value: TcxTreeListReportLinkCustomDrawCellEvent);
begin
  if @FOnCustomDrawCell <> @Value then 
  begin
    FOnCustomDrawCell := Value;
    if SupportedCustomDraw then LinkModified(True);
  end;
end;

procedure TcxTreeListControlReportLink.SetOnCustomDrawFooterCell(Value: TcxTreeListReportLinkCustomDrawFooterCellEvent);
begin
  if @FOnCustomDrawFooterCell <> @Value then 
  begin
    FOnCustomDrawFooterCell := Value;
    if SupportedCustomDraw then LinkModified(True);
  end;
end;

procedure TcxTreeListControlReportLink.SetOnCustomDrawHeaderCell(Value: TcxTreeListReportLinkCustomDrawHeaderCellEvent);
begin
  if @FOnCustomDrawHeaderCell <> @Value then 
  begin
    FOnCustomDrawHeaderCell := Value;
    if SupportedCustomDraw then LinkModified(True);
  end;
end;

procedure TcxTreeListControlReportLink.SetOnCustomDrawIndentCell(Value: TcxTreeListReportLinkCustomDrawIndentCellEvent);
begin
  if @FOnCustomDrawIndentCell <> @Value then 
  begin
    FOnCustomDrawIndentCell := Value;
    if SupportedCustomDraw then LinkModified(True);
  end;
end;

procedure TcxTreeListControlReportLink.SetOptionsExpanding(Value: TcxTreeListReportLinkOptionsExpanding);
begin
  inherited OptionsExpanding := Value;
end;

procedure TcxTreeListControlReportLink.SetOptionsFormatting(Value: TcxTreeListReportLinkOptionsFormatting);    
begin
  inherited OptionsFormatting := Value;
end;

procedure TcxTreeListControlReportLink.SetOptionsOnEveryPage(Value: TcxTreeListReportLinkOptionsOnEveryPage);
begin
  inherited OptionsOnEveryPage := Value;
end;

procedure TcxTreeListControlReportLink.SetOptionsPagination(Value: TcxTreeListReportLinkOptionsPagination);
begin
  inherited OptionsPagination := Value;
end;

procedure TcxTreeListControlReportLink.SetOptionsPreview(Value: TcxTreeListReportLinkOptionsPreview);
begin
  inherited OptionsPreview := Value;
end;

procedure TcxTreeListControlReportLink.SetOptionsRefinements(Value: TcxTreeListReportLinkOptionsRefinements);
begin
  inherited OptionsRefinements := Value;
end;

procedure TcxTreeListControlReportLink.SetOptionsSelection(Value: TcxTreeListReportLinkOptionsSelection);
begin
  inherited OptionsSelection := Value;
end;

procedure TcxTreeListControlReportLink.SetOptionsSize(Value: TcxTreeListReportLinkOptionsSize);
begin
  inherited OptionsSize := Value;
end;

procedure TcxTreeListControlReportLink.SetOptionsView(Value: TcxTreeListReportLinkOptionsView);
begin
  inherited OptionsView := Value;
end;

procedure TcxTreeListControlReportLink.SetStyles(Value: TcxTreeListReportLinkStyles);
begin
  inherited Styles := Value;
end;

{ TcxTreeListReportLink }

function TcxTreeListReportLink.GetTreeList: TcxTreeList;
begin
  Result := TcxTreeList(Component);
end;

{ TcxDBTreeListReportLink }

function TcxDBTreeListReportLink.GetDBTreeList: TcxDBTreeList;
begin
  Result := TcxDBTreeList(Component);
end;

{ TcxVirtualTreeListReportLink }

function TcxVirtualTreeListReportLink.GetVirtualTreeList: TcxVirtualTreeList;
begin
  Result := TcxVirtualTreeList(Component);
end;

{ TdxfmTreeListReportLinkDesignWindow }

constructor TdxfmTreeListReportLinkDesignWindow.Create(AOwner: TComponent);
begin
  HelpContext := dxPSGlbl .dxhccxTreeListReportLinkDesigner;
  inherited;
  CreateControls;
  SetActivePage;
end;

destructor TdxfmTreeListReportLinkDesignWindow.Destroy;
begin
  dxPSPopupMan.dxPSPopupMenuController.UnregisterControl(lbxStyles);
  inherited;
end;

procedure TdxfmTreeListReportLinkDesignWindow.DoInitialize;
begin
  lbxStyles.ReportLinkStyles := ReportLink.ActiveStyles;
  inherited;
  RefreshStylesList;
  
  InitializePreviewTreeList;
  InitializePreviewTreeListStyles;
  LoadDataIntoPreviewTreeList;

  with ReportLink.OptionsView do
  begin
    chbxShowBands.Checked := BandHeaders;
    chbxShowBorders.Checked := Borders;
    chbxShowExpandButtons.Checked := ExpandButtons;
    chbxShowFooters.Checked := Footers;
    chbxShowHeaders.Checked := Headers;
    chbxShowTreeLines.Checked := TreeLines;
  end;

  with ReportLink.OptionsOnEveryPage do 
  begin
    chbxBandsOnEveryPage.Checked := BandHeaders;
    chbxFootersOnEveryPage.Checked := Footers;
    chbxHeadersOnEveryPage.Checked := Headers;
  end;

  with cbxLookAndFeel do 
  begin
    Items.Clear;
    Items.AddObject(cxGetResourceString(@sdxLookAndFeelFlat), TObject(lfFlat));
    Items.AddObject(cxGetResourceString(@sdxLookAndFeelStandard), TObject(lfStandard));
    Items.AddObject(cxGetResourceString(@sdxLookAndFeelUltraFlat), TObject(lfUltraFlat));
    
    ItemIndex := Items.IndexOfObject(TObject(ReportLink.OptionsFormatting.LookAndFeelKind));
  end;

  with ReportLink.OptionsFormatting do
  begin
    ccbxSeparatorColor.ColorValue := ActualNodeSeparatorColor;
    seSeparatorThickness.AsInteger := NodeSeparatorThickness;
    chbxConsumeSelectionStyle.Checked := ConsumeSelectionStyle;
    chbxSuppressBackgroundBitmaps.Checked := SuppressBackgroundBitmaps;
    chbxUseNativeStyles.Checked := UseNativeStyles;
  end;
    
  with ReportLink.OptionsSelection do
  begin
    chbxProcessSelection.Checked := ProcessSelection;
    chbxProcessExactSelection.Checked := ProcessExactSelection;
  end;  

  with ReportLink.OptionsExpanding do
  begin
    chbxExpandNodes.Checked := AutoExpandNodes;
    chbxExplicitlyExpandNodes.Checked := ExplicitlyExpandNodes;
  end;  

  with ReportLink.OptionsSize do
  begin
    chbxAutoWidth.Checked := AutoWidth;
  end;  

  with ReportLink.OptionsRefinements do
  begin
    chbxTransparentGraphics.Checked := TransparentGraphics;
    chbxDisplayGraphicsAsText.Checked := DisplayGraphicsAsText;
    chbxFlatCheckMarks.Checked := FlatCheckMarks;
   (*
    chbxTransparentRichEdits.Checked := TransparentRichEdits;
   *)
  end;

  with ReportLink.OptionsPreview do 
  begin
    chbxPreviewVisible.Checked := Visible;
    chbxPreviewAutoHeight.Checked := AutoHeight;
    sePreviewMaxLineCount.AsInteger := MaxLineCount;
  end;
end;

{$IFDEF DELPHI7}
function TdxfmTreeListReportLinkDesignWindow.GetPreviewHost: TCustomPanel;
begin
  Result := pnlPreview;
end;
{$ENDIF}

procedure TdxfmTreeListReportLinkDesignWindow.LoadStrings;

  procedure AdjustBevelSize(ABevel: TBevel; ALabel: TControl);
  var
    Right: Integer;
  begin
    Right := ABevel.BoundsRect.Right;
    ABevel.Left := ALabel.Left + ALabel.Width + 10;
    ABevel.Width := Right - ABevel.Left;
  end;
  
begin
  inherited;
  
  lblPreviewWindow.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));
  
  tshView.Caption := cxGetResourceString(@sdxViewTab);
  
  lblShow.Caption := cxGetResourceString(@sdxShow);
  AdjustBevelSize(bvlShow, lblShow);
  chbxShowBands.Caption := cxGetResourceString(@sdxBands);
  chbxShowHeaders.Caption := cxGetResourceString(@sdxHeaders);
  chbxShowFooters.Caption := cxGetResourceString(@sdxFooters);
  Bevel2.Width := bvlShow.Width - (Bevel2.Left - bvlShow.Left);
  chbxShowBorders.Caption := cxGetResourceString(@sdxBorders);
  chbxShowExpandButtons.Caption := cxGetResourceString(@sdxExpandButtons);
  chbxShowTreeLines.Caption := cxGetResourceString(@sdxTreeLines);

  lblOnEveryPage.Caption := cxGetResourceString(@sdxOnEveryPage);
  AdjustBevelSize(bvlOnEveryPage, lblOnEveryPage);
  chbxBandsOnEveryPage.Caption := DropAmpersand(cxGetResourceString(@sdxBands));
  chbxHeadersOnEveryPage.Caption := DropAmpersand(cxGetResourceString(@sdxHeaders));
  chbxFootersOnEveryPage.Caption := DropAmpersand(cxGetResourceString(@sdxFooters));
  
  tshBehaviors.Caption := cxGetResourceString(@sdxBehaviorsTab);
  
  lblSelection.Caption := cxGetResourceString(@sdxSelection);
  AdjustBevelSize(bvlSelection, lblSelection);
  chbxProcessSelection.Caption := cxGetResourceString(@sdxProcessSelection);
  chbxProcessExactSelection.Caption := cxGetResourceString(@sdxProcessExactSelection); 
  
  lblExpanding.Caption := cxGetResourceString(@sdxExpanding);
  AdjustBevelSize(bvlExpanding, lblExpanding);  
  chbxExpandNodes.Caption := cxGetResourceString(@sdxNodes);
  chbxExplicitlyExpandNodes.Caption := cxGetResourceString(@sdxExplicitlyExpandNodes);
  
  lblSize.Caption := cxGetResourceString(@sdxSize);
  AdjustBevelSize(bvlSize, lblSize);
  chbxAutoWidth.Caption := cxGetResourceString(@sdxAutoWidth);

  tshFormatting.Caption := cxGetResourceString(@sdxFormatting);
  lblLookAndFeel.Caption := cxGetResourceString(@sdxLookAndFeel);
  AdjustBevelSize(bvlLookAndFeel, lblLookAndFeel);

  lblRefinements.Caption := cxGetResourceString(@sdxRefinements);
  AdjustBevelSize(bvlRefinements, lblRefinements);
  chbxTransparentGraphics.Caption := cxGetResourceString(@sdxTransparentGraphics);
  chbxDisplayGraphicsAsText.Caption := DropAmpersand(cxGetResourceString(@sdxDisplayGraphicsAsText));
  chbxFlatCheckMarks.Caption := cxGetResourceString(@sdxFlatCheckMarks);
  //chbxTransparentRichEdits.Caption := cxGetResourceString(@sdxTransparentRichEdits); {.3}
  chbxSuppressBackgroundBitmaps.Caption := cxGetResourceString(@sdxSuppressBackgroundBitmaps);
  chbxConsumeSelectionStyle.Caption := cxGetResourceString(@sdxConsumeSelectionStyle);

  lblSeparators.Caption := cxGetResourceString(@sdxSeparators);
  AdjustBevelSize(bvlSeparator, lblSeparators);
  lblSeparatorsColor.Caption := cxGetResourceString(@sdxColor);
  lblSeparatorsThickness.Caption := cxGetResourceString(@sdxThickness);

  tshStyles.Caption := cxGetResourceString(@sdxStyles);
  lblUseNativeStyles.Caption := cxGetResourceString(@sdxUseNativeStyles);
  AdjustBevelSize(bvlStyles, lblUseNativeStyles);
  btnStyleColor.Caption := cxGetResourceString(@sdxBtnColor);
  btnStyleFont.Caption := cxGetResourceString(@sdxBtnFont);
  btnStyleBackgroundBitmap.Caption := cxGetResourceString(@sdxBtnTexture);
  btnStyleBackgroundBitmapClear.Caption := cxGetResourceString(@sdxBtnTextureClear);
  btnStyleRestoreDefaults.Caption := cxGetResourceString(@sdxBtnRestoreDefaults);
  btnStylesSaveAs.Caption := cxGetResourceString(@sdxBtnSaveAs);

  btnStyleSheetNew.Caption := cxGetResourceString(@sdxBtnNew);
  btnStyleSheetCopy.Caption := cxGetResourceString(@sdxBtnCopy);
  btnStyleSheetDelete.Caption := cxGetResourceString(@sdxBtnDelete);
  btnStyleSheetRename.Caption := cxGetResourceString(@sdxBtnRename);    

  miStyleColor.Caption := cxGetResourceString(@sdxBtnColor);
  miStyleFont.Caption := cxGetResourceString(@sdxBtnFont);
  miStyleBackgroundBitmap.Caption := cxGetResourceString(@sdxBtnTexture);
  miStyleBackgroundBitmapClear.Caption := cxGetResourceString(@sdxBtnTextureClear);
  miStyleRestoreDefaults.Caption := cxGetResourceString(@sdxBtnRestoreDefaults);
  miStylesSelectAll.Caption := cxGetResourceString(@sdxSelectAll);
  miStylesSaveAs.Caption := cxGetResourceString(@sdxBtnSaveAs);
  
  tshPreview.Caption := cxGetResourceString(@sdxPreviewTab);
  lblPreviewOptions.Caption := cxGetResourceString(@sdxOptions);
  AdjustBevelSize(bvlPreviewOptions, lblPreviewOptions);
  chbxPreviewVisible.Caption := cxGetResourceString(@sdxVisible);
  chbxPreviewAutoHeight.Caption := cxGetResourceString(@sdxPreviewAutoHeight);
  lblPreviewMaxLineCount.Caption := cxGetResourceString(@sdxPreviewMaxLineCount);
  lblStyleSheets.Caption := cxGetResourceString(@sdxStyleSheets);
end;

procedure TdxfmTreeListReportLinkDesignWindow.UpdateControlsState;
begin
  inherited;
  chbxProcessExactSelection.Enabled := chbxProcessSelection.Checked;
  chbxExplicitlyExpandNodes.Enabled := chbxExpandNodes.Checked;
  
  lbxStyles.Enabled := AreNativeStylesAvailable;
  btnStyleColor.Enabled := AreNativeStylesAvailable and HasSelectedStyles;
  btnStyleFont.Enabled := AreNativeStylesAvailable and HasSelectedStyles;
  btnStyleBackgroundBitmap.Enabled := AreNativeStylesAvailable and HasSelectedStyles;
  btnStyleBackgroundBitmapClear.Enabled := AreNativeStylesAvailable and HasSelectedStylesWithAssignedBitmap;
  btnStyleRestoreDefaults.Enabled := AreNativeStylesAvailable and HasSelectedStyles;
  btnStylesSaveAs.Enabled := CanSaveStyles;

  lblStyleSheets.Enabled := AreNativeStylesAvailable;
  cbxStyleSheets.Enabled := AreNativeStylesAvailable;
  btnStyleSheetNew.Enabled := CanCreateStyleSheet;
  btnStyleSheetCopy.Enabled := CanCopyStyleSheet;
  btnStyleSheetDelete.Enabled := CanDeleteStyleSheet;
  btnStyleSheetRename.Enabled := CanRenameStyleSheet;

  WarningPaneUpdate;
end;

procedure TdxfmTreeListReportLinkDesignWindow.UpdatePreview;
const
  TransparentsMap: array[Boolean] of TcxImageTransparency = (gtOpaque, gtTransparent);
  TreeLineStylesMap: array[Boolean] of TcxTreeListTreeLineStyle = (tllsNone, tllsDot);
begin
  PreviewTreeList.Enabled := False;
  PreviewTreeList.LookAndFeel.Kind := ReportLink.OptionsFormatting.LookAndFeelKind;
  PreviewTreeList.LookAndFeel.NativeStyle := False; 
  PreviewTreeList.Font := ReportLink.Font;
  
  chbxBandsOnEveryPage.Enabled := not ReportLink.IsAggregated;
  chbxHeadersOnEveryPage.Enabled := not ReportLink.IsAggregated;
  chbxFootersOnEveryPage.Enabled := not ReportLink.IsAggregated;
  
  TcxImageProperties(colManufacturerLogo.Properties).GraphicTransparency := 
    TransparentsMap[ReportLink.OptionsRefinements.TransparentGraphics];

  PreviewTreeList.OptionsView.Bands := ReportLink.OptionsView.BandHeaders;
  PreviewTreeList.OptionsView.Footer := ReportLink.OptionsView.Footers;    
  PreviewTreeList.OptionsView.Headers := ReportLink.OptionsView.Headers;
  PreviewTreeList.OptionsView.Buttons := ReportLink.OptionsView.ExpandButtons;
  PreviewTreeList.OptionsView.TreeLineStyle := TreeLineStylesMap[ReportLink.OptionsView.TreeLines];
  PreviewTreeList.OptionsView.ShowRoot := (ReportLink.TreeListControl <> nil) and 
    CustomTreeListControl_GetOptionsView(ReportLink.TreeListControl).ShowRoot;
  PreviewTreeList.Preview.Visible := ReportLink.OptionsPreview.Visible;

  if ReportLink.TreeListControl <> nil then
    PreviewTreeList.OptionsView.UseNodeColorForIndent := 
      CustomTreeListControl_GetOptionsView(ReportLink.TreeListControl).UseNodeColorForIndent;
    
  PreviewTreeList.Invalidate;
end;

function TdxfmTreeListReportLinkDesignWindow.GetDesignerTabIndex: Integer;
begin
  Result := PageControl1.ActivePage.TabIndex;
end;

procedure TdxfmTreeListReportLinkDesignWindow.SetDesignerTabIndex(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value > PageControl1.PageCount - 1 then 
    Value := PageControl1.PageCount - 1;
  PageControl1.ActivePage := PageControl1.Pages[Value];
end;

procedure TdxfmTreeListReportLinkDesignWindow.DoActiveStyleSheetChanged;
begin
  lbxStyles.ReportLinkStyles := ReportLink.ActiveStyles;
  inherited;
  with cbxStyleSheets do 
    ItemIndex := Items.IndexOfObject(ActiveStyleSheet);

  if not LockControlsUpdate then 
  begin
    Modified := True;
    UpdatePreview;
  end;  
end;

procedure TdxfmTreeListReportLinkDesignWindow.DoFormActivated(AnActive: Boolean);
begin
  inherited;
  if not AnActive then lbxStyles.HideToolTips;
end;

procedure TdxfmTreeListReportLinkDesignWindow.DoRefreshStylesList;
var
  Styles: TcxTreeListReportLinkStyles;
  List: TList;
begin
  Styles := ReportLink.ActiveStyles;
  with lbxStyles.Items do 
  begin
    BeginUpdate;
    try
      List := TList.Create;
      try
        SaveSelectedStyles(List);
        try
          Clear;
          AddObject(cxGetResourceString(@sdxBandHeaderStyle), Styles.BandHeader);
          AddObject(cxGetResourceString(@sdxContentStyle), Styles.Content);
          AddObject(cxGetResourceString(@sdxContentEvenStyle), Styles.ContentEven);
          AddObject(cxGetResourceString(@sdxContentOddStyle), Styles.ContentOdd);
          AddObject(cxGetResourceString(@sdxFooterStyle), Styles.Footer);
          AddObject(cxGetResourceString(@sdxFooterRowStyle), Styles.FooterRow);
          AddObject(cxGetResourceString(@sdxHeaderStyle), Styles.Header);
          AddObject(cxGetResourceString(@sdxPreviewStyle), Styles.Preview);
          AddObject(cxGetResourceString(@sdxSelectionStyle), Styles.Selection);
        finally  
          RestoreSelectedStyles(List);
        end;  
      finally
        List.Free;
      end;
    finally
      EndUpdate;
    end;  
  end;
  InitializePreviewTreeListStyles;
end;

procedure TdxfmTreeListReportLinkDesignWindow.DoStyleChanged(const ACaption: string; 
  AStyle: TcxStyle);
begin
  inherited;
  UpdatePreviewTreeListStyles(ACaption, AStyle);  
end;

procedure TdxfmTreeListReportLinkDesignWindow.DoStylesChanged(AStrings: TStrings; 
  ARecreate: Boolean);
begin
  if ARecreate then 
    RecreateStylesListBox
  else
    lbxStyles.Invalidate;  
  Modified := True;
  UpdatePreview;
end;

procedure TdxfmTreeListReportLinkDesignWindow.GetSelectedStyleNames(AStrings: TStrings);
var
  I: Integer;
begin
  AStrings.Clear;
  with lbxStyles do
    for I := 0 to Items.Count - 1 do
      if Selected[I] then 
        AStrings.AddObject(Items[I], Items.Objects[I]);
end;

procedure TdxfmTreeListReportLinkDesignWindow.GetStyleNames(out AStrings: TStrings);
begin
  AStrings := lbxStyles.Items;
end;
  
procedure TdxfmTreeListReportLinkDesignWindow.GetStyleSheetNames(out AStrings: TStrings);
begin
  AStrings := cbxStyleSheets.Items;
end;

function TdxfmTreeListReportLinkDesignWindow.GetActiveStyle: TcxStyle;
begin
  with lbxStyles do
    if ItemIndex <> -1 then
      Result := TcxStyle(Items.Objects[ItemIndex])
    else
      Result := nil;
end;

function TdxfmTreeListReportLinkDesignWindow.GetHasSelectedStyles: Boolean;
begin
  Result := lbxStyles.SelCount <> 0;
end;

function TdxfmTreeListReportLinkDesignWindow.GetHasSelectedStylesWithAssignedBitmap: Boolean;
var
  Styles: TStrings;
  I: Integer;
  Style: TcxStyle;
begin
  Result := True;
  Styles := TStringList.Create;
  try
    GetSelectedStyleNames(Styles);
    for I := 0 to Styles.Count - 1 do
    begin
      Style := TcxStyle(Styles.Objects[I]);
      if (Style <> nil) and (Style.Bitmap <> nil) and not Style.Bitmap.Empty then 
        Exit;
    end;  
  finally
    Styles.Free;
  end;  
  Result := False;
end;

function TdxfmTreeListReportLinkDesignWindow.GetReportLink: TcxTreeListControlReportLink;
begin
  Result := inherited ReportLink as TcxTreeListControlReportLink;
end;

procedure TdxfmTreeListReportLinkDesignWindow.PreviewMaxLineCountChanged(Sender: TObject);
begin
  if LockControlsUpdate then Exit;  
  ReportLink.OptionsPreview.MaxLineCount := TdxPSSpinEdit(Sender).AsInteger;
  Modified := True;
end;

procedure TdxfmTreeListReportLinkDesignWindow.SeparatorColorChanged(Sender: TObject);
begin
  if LockControlsUpdate then Exit;  
  if TdxPSColorCombo(Sender).IsAutoColorSelected then
    ReportLink.OptionsFormatting.NodeSeparatorColor := clDefault
  else
    ReportLink.OptionsFormatting.NodeSeparatorColor := TdxPSColorCombo(Sender).ColorValue;
  Modified := True;
end;

procedure TdxfmTreeListReportLinkDesignWindow.SeparatorThicknessChanged(Sender: TObject);
begin
  if LockControlsUpdate then Exit;  
  ReportLink.OptionsFormatting.NodeSeparatorThickness := TdxPSSpinEdit(Sender).AsInteger;
  Modified := True;
end;

function TdxfmTreeListReportLinkDesignWindow.CanSelectAllStyles: Boolean;
var
  I: Integer;
begin
  Result := AreNativeStylesAvailable;
  if Result then
  begin
    for I := 0 to lbxStyles.Items.Count - 1 do
      if not lbxStyles.Selected[I] then Exit;
    Result := False;  
  end;    
end;

procedure TdxfmTreeListReportLinkDesignWindow.CreateControls;

  function CreateSpin(AHost: TControl; ALabel: TLabel; ATabOrder: TTabOrder; 
    AMinValue, AMaxValue, AValue: Integer): TdxPSSpinEdit;
  begin
    Result := TdxPSSpinEdit.Create(Self);
    with Result do 
    begin
      Parent := AHost.Parent;
      BoundsRect := AHost.BoundsRect;
      TabOrder := ATabOrder;

      MinValue := AMinValue;
      MaxValue := AMaxValue;
      Value := AValue;    
      DefaultValue := AValue;
    end;
    ALabel.FocusControl := Result;
  end;
  
  function CreateColorCombo(AHost: TControl; ALabel: TLabel; ATabOrder: TTabOrder; 
    ATag: Integer; AAutoColor: TColor): TdxPSColorCombo;
  begin
    Result := TdxPSColorCombo.Create(Self);
    with TdxPSColorCombo(Result) do
    begin
      BoundsRect := AHost.BoundsRect;
      Tag := MakeTTag(ATag);
      Parent := AHost.Parent;
      TabOrder := ATabOrder;
      ColorTypes := [ctPure];
      ShowColorName := True;
      ShowAutoColor := True;
      AutoColor := AAutoColor;
    end;
    ALabel.FocusControl := Result;
    AHost.Visible := False;
  end;

  procedure CreateWarningPane;
  begin
    wpIncorrectOnEveryPageState := TdxPSWarningPane.Create(Self);
    wpIncorrectOnEveryPageState.Parent := tshView;
    wpIncorrectOnEveryPageState.BoundsRect := bvlWarningHost.BoundsRect;
    bvlWarningHost.Visible := False;
  end;

  procedure CreateStylesListBox;  
  begin
    lbxStyles := TdxStylesListBox.Create(Self);
    lbxStyles.Parent := tshStyles;
    lbxStyles.BoundsRect := bvlStylesHost.BoundsRect;
    lbxStyles.PopupMenu := pmStyles;
    lbxStyles.TabOrder := chbxUseNativeStyles.TabOrder + 1;
    lbxStyles.OnClick := lbxStylesClick;
    bvlStylesHost.Visible := False;
    
    dxPSPopupMan.dxPSPopupMenuController.RegisterControl(lbxStyles);
  end;
      
begin             
  sePreviewMaxLineCount := CreateSpin(bvlPreviewMaxLineCountHost, lblPreviewMaxLineCount, 
    chbxPreviewAutoHeight.TabOrder + 1, 0, 1000, 0);
  sePreviewMaxLineCount.OnChange := PreviewMaxLineCountChanged;

  seSeparatorThickness := CreateSpin(bvlSeparatorThicknessHost, lblSeparatorsThickness, 
    chbxConsumeSelectionStyle.TabOrder + 1, 0, 16, 0);
  seSeparatorThickness.OnChange := SeparatorThicknessChanged;   

  ccbxSeparatorColor := CreateColorCombo(bvlSeparatorColorHost, lblSeparatorsColor,
    seSeparatorThickness.TabOrder + 1, 0, dxPSDefaultTreeListNodeSeparatorColor);
  ccbxSeparatorColor.OnChange := SeparatorColorChanged;
  
  CreateWarningPane;
  CreateStylesListBox;
end;

procedure TdxfmTreeListReportLinkDesignWindow.CustomDrawBorders(ACanvas: TcxCanvas; 
  const R: TRect);
var
  GridLinesColor: TColor;
begin
  with ReportLink do
  begin
    GridLinesColor := PreviewTreeList.OptionsView.GridLineColor;
    {if TreeListControl <> nil then
      GridLinesColor := CustomTreeListControl_GetOptionsView(TreeListControl).GridLineColor
    else
      GridLinesColor := PreviewTreeList.OptionsView.GridLineColor;//clWindowText;}
    if GridLinesColor = clDefault then  
      GridLinesColor := CustomTreeListControl_GetLookAndFeelPainter(PreviewTreeList).DefaultGridLineColor;
  end;
  ACanvas.DrawComplexFrame(R, GridLinesColor, GridLinesColor, [bLeft, bBottom, bRight]);
end;

procedure TdxfmTreeListReportLinkDesignWindow.CustomDrawCheckMark(ACanvas: TcxCanvas;
  AViewInfo: TcxTreeListEditCellViewInfo);
const
  Painters: array[Boolean] of TcxCustomLookAndFeelPainterClass =
    (TcxStandardLookAndFeelPainter, TcxUltraFlatLookAndFeelPainter);
var
  PrevColor: TColor;
  R: TRect;
  Params: TcxViewParams;
  X, Y: Integer;
  CheckValue: Variant;
begin
  PrevColor := ACanvas.Brush.Color;
  R := AViewInfo.BoundsRect;
  Params := PreviewTreeList.Styles.GetContentParams(AViewInfo.Node, AViewInfo.Column);

  if Params.Bitmap = nil then
  begin
    ACanvas.Brush.Color := Params.Color;
    ACanvas.FillRect(R);
  end
  else
    dxBkgnd.DrawPicture(Params.Bitmap, ACanvas.Canvas, R, ppmTile, 1, 1, -R.Left, -R.Top);

  X := R.Left + (R.Right - R.Left - CheckWidth) div 2;
  Y := R.Top + (R.Bottom - R.Top - CheckWidth) div 2;
  R := MakeBounds(X, Y, CheckWidth, CheckWidth);
  CheckValue := cbsChecked;
  if AViewInfo.Node.Index = 0 then
    CheckValue := cbsUnchecked;
  with Painters[ReportLink.OptionsRefinements.FlatCheckMarks] do
    DrawCheckButton(ACanvas, R, cxbsDefault, CheckValue = cbsChecked);
  ACanvas.Brush.Color := PrevColor;
end;

procedure TdxfmTreeListReportLinkDesignWindow.CustomDrawFooter(ACanvas: TcxCanvas; 
  R: TRect; AViewInfo: TcxTreeListFooterItemViewInfo);
begin
  case ReportLink.OptionsFormatting.LookAndFeelKind of
    lfStandard, 
    lfFlat:
      ACanvas.DrawComplexFrame(R, AViewInfo.ViewParams.TextColor, clBtnHighlight);
    lfUltraFlat:
      ACanvas.FrameRect(R, AViewInfo.ViewParams.TextColor);
  end;    

  InflateRect(R, -1, -1);
  with AViewInfo do       
    CustomDrawTextRect(ACanvas, R, Text, AlignHorz, AlignVert, ViewParams);
end;

procedure TdxfmTreeListReportLinkDesignWindow.CustomDrawHeader(ACanvas: TcxCanvas; 
  R: TRect; AViewInfo: TcxTreeListHeaderViewInfo);
const  
  BottomRightColors: array[Boolean] of TColor = (clBtnFace, clBtnShadow);
begin
  ACanvas.FrameRect(R, clWindowText);//AViewInfo.ViewParams.TextColor);
  if ReportLink.OptionsFormatting.LookAndFeelKind <> lfUltraFlat then
  begin
    InflateRect(R, -1, -1);
    ACanvas.DrawComplexFrame(R, clBtnHighlight, 
      BottomRightColors[ReportLink.OptionsFormatting.LookAndFeelKind = lfStandard]);
  end;
  
  InflateRect(R, -1, -1);
  with AViewInfo do
    CustomDrawTextRect(ACanvas, R, Text, AlignHorz, AlignVert, ViewParams);
end;

procedure TdxfmTreeListReportLinkDesignWindow.CustomDrawTextRect(ACanvas: TcxCanvas; 
  R: TRect; const AText: string; AnAlignmentHorz: TAlignment; AnAlignmentVert: TcxAlignmentVert; 
  AParams: TcxViewParams);
const                                              
  AlignmentHorzMap: array[TAlignment] of Integer = (cxAlignLeft, cxAlignRight, cxAlignCenter);
  AlignmentVertMap: array[TcxAlignmentVert] of Integer = (cxAlignTop, cxAlignBottom, cxAlignVCenter);  
begin
  if AParams.Bitmap = nil then 
  begin
    ACanvas.Brush.Color := AParams.Color;
    ACanvas.FillRect(R);
  end
  else
    dxBkgnd.DrawPicture(AParams.Bitmap, ACanvas.Canvas, R, ppmTile, 1, 1, - R.Left - 0, - R.Top - 0);

  InflateRect(R, -2, -1); 
  if AParams.Font <> nil then 
    ACanvas.Font := AParams.Font;
  ACanvas.Font.Color := AParams.TextColor;
  ACanvas.Brush.Style := bsClear;
  ACanvas.DrawText(AText, R, 
    AlignmentHorzMap[AnAlignmentHorz] or AlignmentVertMap[AnAlignmentVert] or cxSingleLine);
  ACanvas.Brush.Style := bsSolid;
end;

function TdxfmTreeListReportLinkDesignWindow.ExtractAlignmentHorz(
  AViewInfo: TcxTreeListEditCellViewInfo): TAlignment;
begin
  with AViewInfo.Column do 
    if Properties <> nil then 
      Result := cxEditProperties_GetAlignment(Properties).Horz
    else
      Result := taLeftJustify;
end;

function TdxfmTreeListReportLinkDesignWindow.ExtractAlignmentVert(
  AViewInfo: TcxTreeListEditCellViewInfo): TcxAlignmentVert;
const
  EditAlignmentVertMap: array[TcxEditVertAlignment] of TcxAlignmentVert = 
    (vaTop, vaBottom, vaCenter);
begin
  with AViewInfo.Column do 
    if Properties <> nil then 
      Result := EditAlignmentVertMap[cxEditProperties_GetAlignment(Properties).Vert]
    else
      Result := vaCenter;
end;

procedure TdxfmTreeListReportLinkDesignWindow.InitializePreviewTreeList;

  procedure SetupDataBindings;

    function GetColumnCaption(AnIndex: Integer): string;
    begin
      case AnIndex of
        0: Result := cxGetResourceString(@sdxManufacturerNameColumnCaption);
        1: Result := cxGetResourceString(@sdxManufacturerLogoColumnCaption);
        2: Result := cxGetResourceString(@sdxManufacturerCountryColumnCaption);
        3: Result := cxGetResourceString(@sdxCarModelColumnCaption);
      else
        Result := cxGetResourceString(@sdxCarIsSUVColumnCaption);
      end;
    end;

  const
    ColumnProperties: array[0..4] of string = 
      ('TcxTextEditProperties', 'TcxImageProperties', 'TcxTextEditProperties',
       'TcxTextEditProperties', 'TcxCheckBoxProperties');
  var
    I: Integer;
  begin
    for I := 0 to PreviewTreeList.ColumnCount - 1 do
      with PreviewTreeList.Columns[I] do
      begin
        PropertiesClassName := ColumnProperties[I];
        Caption.Text := GetColumnCaption(I);
      end;  
  end;

begin
  SetupDataBindings;
  //TcxImageProperties(colManufacturerLogo.Properties).Stretch := True;
  PreviewTreeList.Bands[0].Caption.Text := cxGetResourceString(@sdxManufacturerBandCaption);
  PreviewTreeList.Bands[1].Caption.Text := cxGetResourceString(@sdxModelBandCaption);
  PreviewTreeList.OptionsView.Footer := True;
  PreviewTreeList.Columns[0].Options.Footer := True;
  PreviewTreeList.Columns[0].SummaryFooter.Kind := skCount;
  PreviewTreeList.Columns[0].SummaryFooter.Format := cxGetResourceString(@sdxSummaryFormat);
end;                                                                            

procedure TdxfmTreeListReportLinkDesignWindow.InitializePreviewTreeListStyles;

  procedure ResetEvents(AStyles: TcxTreeListStyles);
  begin
    with AStyles do 
    begin
      OnGetBandBackgroundStyle := nil;
      OnGetBandContentStyle := nil;
      OnGetBandHeaderStyle := nil;
      OnGetBandFooterStyle := nil;
      OnGetColumnFooterStyle := nil;
      OnGetColumnHeaderStyle := nil;
      OnGetContentStyle := nil;
      OnGetNodeIndentStyle := nil;
      OnGetPreviewStyle := nil;
    end;  
  end;
  
var
  Styles: TcxTreeListReportLinkStyles;
begin
  if ReportLink.OptionsFormatting.UseNativeStyles then
  begin
    Styles := ReportLink.ActiveStyles;
    dxPSResetStyles(PreviewTreeList.Styles);
    with PreviewTreeList.Styles do
    begin
      BandHeader := Styles.BandHeader;
      Content := Styles.Content;
      ContentEven := Styles.ContentEven;
      ContentOdd := Styles.ContentOdd;
      ColumnFooter := Styles.Footer;
      ColumnHeader := Styles.Header;
      Footer := Styles.FooterRow;
      Preview := Styles.Preview;
    end;
  end
  else
    if ReportLink.TreeListControl <> nil then 
      PreviewTreeList.Styles := CustomTreeListControl_GetStyles(ReportLink.TreeListControl)
    else
      dxPScxCommon.dxPSResetStyles(PreviewTreeList.Styles);
      
  ResetEvents(PreviewTreeList.Styles);
end;

procedure TdxfmTreeListReportLinkDesignWindow.LoadDataIntoPreviewTreeList;

  function GetManufacturerName(AnIndex: Integer): string;
  begin
    case AnIndex of 
      0: Result := cxGetResourceString(@sdxCarManufacturerName5);
      1: Result := cxGetResourceString(@sdxCarManufacturerName1);
      2: Result := cxGetResourceString(@sdxCarManufacturerName2);
    else
      Result := cxGetResourceString(@sdxCarManufacturerName4);
    end;
  end;
  
  function GetManufacturerCountry(AnIndex: Integer): string;
  begin
    case AnIndex of 
      0: Result := cxGetResourceString(@sdxCarManufacturerCountry5);
      1: Result := cxGetResourceString(@sdxCarManufacturerCountry1);
      2: Result := cxGetResourceString(@sdxCarManufacturerCountry2);
    else
      Result := cxGetResourceString(@sdxCarManufacturerCountry4);
    end;
  end;

  function GetCarModel(AnIndex: Integer): string;
  begin
    case AnIndex of 
      0: Result := cxGetResourceString(@sdxCarModel5);
      1: Result := cxGetResourceString(@sdxCarModel1);
      2: Result := cxGetResourceString(@sdxCarModel2);
    else
      Result := cxGetResourceString(@sdxCarModel4);
    end;
  end;
  
const
  RecordCount = 4;
  CarLogosIndexes: array[0..RecordCount - 1] of Integer = (4, 0, 1, 3);
  AreCarsSUV: array[0..RecordCount - 1] of string = ('False', 'True', 'True', 'True');
var                 
  I: Integer;
begin
  PreviewTreeList.Clear;
  for I := 0 to RecordCount - 1 do
    with PreviewTreeList.Add do 
    begin
      Values[0] := GetManufacturerName(I);
      Values[1] := dxPScxCommon.dxPSPreviewCarLogosAsString(CarLogosIndexes[I]);
      Values[2] := GetManufacturerCountry(I);
      Values[3] := GetCarModel(I);
      Values[4] := AreCarsSUV[I];
    end;  
end;

procedure TdxfmTreeListReportLinkDesignWindow.RecreateStylesListBox;
var
  List: TList;
begin
  List := TList.Create;
  try
    SaveSelectedStyles(List);
    dxPSUtl.dxRecreateWnd(lbxStyles);
    RestoreSelectedStyles(List);
  finally
    List.Free;
  end;  
end;

procedure TdxfmTreeListReportLinkDesignWindow.RestoreSelectedStyles(AList: TList);
var
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
    lbxStyles.Selected[Integer(AList[I])] := True;
end;

procedure TdxfmTreeListReportLinkDesignWindow.SaveSelectedStyles(AList: TList);
var
  I: Integer;
begin
  AList.Clear;
  for I := 0 to lbxStyles.Items.Count - 1 do
    if lbxStyles.Selected[I] then AList.Add(TObject(I));
end;

procedure TdxfmTreeListReportLinkDesignWindow.SetActivePage;
begin
  PageControl1.ActivePage := PageControl1.Pages[DesignerTabIndex];
end;

procedure TdxfmTreeListReportLinkDesignWindow.UpdatePreviewTreeListStyles(const ACaption: string; 
  AStyle: TcxStyle);
begin
  with PreviewTreeList.Styles do
  begin
    if dxPSUtl.dxSameText(ACaption, cxGetResourceString(@sdxBandHeaderStyle)) then
      BandHeader := AStyle
    else if dxPSUtl.dxSameText(ACaption, cxGetResourceString(@sdxContentStyle)) then
      Content := AStyle
    else if dxPSUtl.dxSameText(ACaption, cxGetResourceString(@sdxContentEvenStyle)) then 
      ContentEven := AStyle
    else if dxPSUtl.dxSameText(ACaption, cxGetResourceString(@sdxContentOddStyle)) then
      ContentOdd := AStyle
    else if dxPSUtl.dxSameText(ACaption, cxGetResourceString(@sdxFooterStyle)) then
      ColumnFooter := AStyle
    else if dxPSUtl.dxSameText(ACaption, cxGetResourceString(@sdxHeaderStyle)) then
      ColumnHeader := AStyle
    else if dxPSUtl.dxSameText(ACaption, cxGetResourceString(@sdxFooterRowStyle)) then 
      Footer := AStyle
    else if dxPSUtl.dxSameText(ACaption, cxGetResourceString(@sdxPreviewStyle)) then
      Preview := AStyle
    else if dxPSUtl.dxSameText(ACaption, cxGetResourceString(@sdxSelectionStyle)) then
      Selection := AStyle
  end;
end;

procedure TdxfmTreeListReportLinkDesignWindow.WarningPaneUpdate;
begin
  with ReportLink.HostInfoServices do
    wpIncorrectOnEveryPageState.SetStateAndHint(IsInconsistentState, InconsistentStateText);
end;

procedure TdxfmTreeListReportLinkDesignWindow.SetOptionsExpandingByIndex(Index: Integer; 
  Value: Boolean);
begin
  if LockControlsUpdate then Exit;
  with ReportLink.OptionsExpanding do
    case Index of
      0: AutoExpandNodes := Value;
      1: ExplicitlyExpandNodes := Value;
    end;  
  Modified := True;
end;

procedure TdxfmTreeListReportLinkDesignWindow.SetOptionsFormattingByIndex(Index: Integer; 
  Value: Boolean);
begin
  if LockControlsUpdate then Exit;
  with ReportLink.OptionsFormatting do
    case Index of
      0: 
         begin
           UseNativeStyles := Value;
           InitializePreviewTreeListStyles;
         end;  
      1: SuppressBackgroundBitmaps := Value;
      2: ConsumeSelectionStyle := Value;
    end; 
  Modified := True;
  UpdatePreview;
end;

procedure TdxfmTreeListReportLinkDesignWindow.SetOptionsOnEveryPageByIndex(Index: Integer; 
  Value: Boolean);        
begin
  if LockControlsUpdate then Exit;
  with ReportLink.OptionsOnEveryPage do
    case Index of
      0: BandHeaders := Value;
      1: Headers := Value;
      2: Footers := Value;
    end;  
  Modified := True;
end;

procedure TdxfmTreeListReportLinkDesignWindow.SetOptionsRefinementsByIndex(Index: Integer; 
  Value: Boolean);
begin
  if LockControlsUpdate then Exit;
  with ReportLink.OptionsRefinements do
    case Index of
      0: TransparentGraphics := Value;
      1: DisplayGraphicsAsText := Value;
      2: FlatCheckMarks := Value;      
      3: TransparentRichEdits := Value;
    end;  
  Modified := True;
  UpdatePreview;
end;

procedure TdxfmTreeListReportLinkDesignWindow.SetOptionsSelectionByIndex(Index: Integer; 
  Value: Boolean);
begin
  if LockControlsUpdate then Exit;
  with ReportLink.OptionsSelection do
    case Index of
      0: ProcessSelection := Value;
      1: ProcessExactSelection := Value;
    end;  
  Modified := True;
end;

procedure TdxfmTreeListReportLinkDesignWindow.SetOptionsSizeByIndex(Index: Integer; 
  Value: Boolean);
begin
  if LockControlsUpdate then Exit;
  with ReportLink.OptionsSize do
    case Index of
      0: AutoWidth := Value;
    end;  
  Modified := True;
end;

procedure TdxfmTreeListReportLinkDesignWindow.SetOptionsViewByIndex(Index: Integer; 
  Value: Boolean);
begin
  if LockControlsUpdate then Exit;
  with ReportLink.OptionsView do 
    case Index of
      0: BandHeaders := Value;
      1: Headers := Value;
      2: Footers := Value;            
      3: ExpandButtons := Value;
      4: TreeLines := Value;
      5: Borders := Value;
    end;  
  Modified := True;
  UpdatePreview;
end;

procedure TdxfmTreeListReportLinkDesignWindow.PreviewTreeListCustomDrawCell(
  Sender: TObject; Canvas: TcxCanvas; AViewInfo: TcxTreeListEditCellViewInfo;
  var ADone: Boolean);
var
  ViewInfo: TcxTreeListEditCellViewInfo;
begin
  ViewInfo := TcxTreeListEditCellViewInfo(AViewInfo);
  if ViewInfo.Column = colManufacturerLogo then
    if ReportLink.OptionsRefinements.DisplayGraphicsAsText then 
    begin
      CustomDrawTextRect(Canvas, ViewInfo.BoundsRect, ReportLink.OptionsRefinements.GraphicsText, 
        ExtractAlignmentHorz(ViewInfo), ExtractAlignmentVert(ViewInfo), ViewInfo.ViewParams);
      CustomDrawBorders(Canvas, ViewInfo.BoundsRect);
      ADone := True;
    end;
    
  if ViewInfo.Column = colCarIsSUV then
  begin
    CustomDrawCheckMark(Canvas, ViewInfo);
    CustomDrawBorders(Canvas, AViewInfo.BoundsRect);
    ADone := True;
  end;
end;

procedure TdxfmTreeListReportLinkDesignWindow.PreviewTreeListCustomDrawBandHeader(
  Sender: TObject; ACanvas: TcxCanvas; AViewInfo: TcxTreeListHeaderViewInfo; 
  var ADone: Boolean);
var
  R: TRect;  
begin
  R := AViewInfo.BoundsRect;
  Dec(R.Top);
  Dec(R.Left);
  CustomDrawHeader(ACanvas, R, AViewInfo);
  
  ADone := True;  
end;

procedure TdxfmTreeListReportLinkDesignWindow.PreviewTreeListCustomDrawHeader(
  Sender: TObject; ACanvas: TcxCanvas; AViewInfo: TcxTreeListHeaderViewInfo;
  var ADone: Boolean);
var
  R: TRect;  
begin
  R := AViewInfo.BoundsRect;
  Dec(R.Top);
  Dec(R.Left);
  CustomDrawHeader(ACanvas, R, AViewInfo);
  
  ADone := True;  
end;

procedure TdxfmTreeListReportLinkDesignWindow.PreviewTreeListCustomDrawFooterCell(
  Sender: TObject; Canvas: TcxCanvas; AViewInfo: TcxTreeListFooterItemViewInfo;
  var ADone: Boolean);
begin
  CustomDrawFooter(Canvas, AViewInfo.BoundsRect, TcxTreeListFooterItemViewInfo(AViewInfo));
  ADone := True;  
end;

procedure TdxfmTreeListReportLinkDesignWindow.LookAndFeelChange(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with TComboBox(Sender) do
    ReportLink.OptionsFormatting.LookAndFeelKind := TcxLookAndFeelKind(Items.Objects[ItemIndex]);
  Modified := True;
  UpdatePreview;
end;

procedure TdxfmTreeListReportLinkDesignWindow.OptionsRefinementsClick(
  Sender: TObject);
begin
  with TCheckBox(Sender) do
    SetOptionsRefinementsByIndex(TTagToInt(Tag), Checked);
end;

procedure TdxfmTreeListReportLinkDesignWindow.PreviewVisibleClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.OptionsPreview.Visible := TCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview;
end;

procedure TdxfmTreeListReportLinkDesignWindow.PreviewAutoHeightClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.OptionsPreview.AutoHeight := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxfmTreeListReportLinkDesignWindow.OptionsSelectionClick(
  Sender: TObject);
begin
  with TCheckBox(Sender) do
    SetOptionsSelectionByIndex(TTagToInt(Tag), Checked);
end;

procedure TdxfmTreeListReportLinkDesignWindow.OptionsExpandingClick(
  Sender: TObject);
begin
  with TCheckBox(Sender) do
    SetOptionsExpandingByIndex(TTagToInt(Tag), Checked);
end;

procedure TdxfmTreeListReportLinkDesignWindow.OptionsSizeClick(
  Sender: TObject);
begin
  with TCheckBox(Sender) do
    SetOptionsSizeByIndex(TTagToInt(Tag), Checked);
end;

procedure TdxfmTreeListReportLinkDesignWindow.OptionsViewClick(
  Sender: TObject);
begin
  with TCheckBox(Sender) do
    SetOptionsViewByIndex(TTagToInt(Tag), Checked);
end;

procedure TdxfmTreeListReportLinkDesignWindow.OptionsOnEveryPageClick(
  Sender: TObject);
begin
  with TCheckBox(Sender) do
    SetOptionsOnEveryPageByIndex(TTagToInt(Tag), Checked);
end;

procedure TdxfmTreeListReportLinkDesignWindow.OptionsFormattingClick(
  Sender: TObject);
begin
  with TCheckBox(Sender) do
    SetOptionsFormattingByIndex(TTagToInt(Tag), Checked);
end;

procedure TdxfmTreeListReportLinkDesignWindow.lblUseNativeStylesClick(
  Sender: TObject);
begin
  if chbxUseNativeStyles.CanFocus then ActiveControl := chbxUseNativeStyles;
  chbxUseNativeStyles.Checked := not chbxUseNativeStyles.Checked;
end;

procedure TdxfmTreeListReportLinkDesignWindow.pmStylesPopup(Sender: TObject);
begin
  lbxStyles.HideToolTips;
  miStyleColor.Enabled := AreNativeStylesAvailable and HasSelectedStyles;
  miStyleFont.Enabled := AreNativeStylesAvailable and HasSelectedStyles;
  miStyleBackgroundBitmap.Enabled := AreNativeStylesAvailable and HasSelectedStyles;
  miStyleBackgroundBitmapClear.Enabled := AreNativeStylesAvailable and HasSelectedStylesWithAssignedBitmap;
  miStyleRestoreDefaults.Enabled := AreNativeStylesAvailable and HasSelectedStyles;
  miStylesSelectAll.Enabled := CanSelectAllStyles;
  miStylesSaveAs.Enabled := CanSaveStyles;
end;

procedure TdxfmTreeListReportLinkDesignWindow.StyleColorClick(Sender: TObject);
begin
  PerformStylesChangeColor;
end;

procedure TdxfmTreeListReportLinkDesignWindow.StyleFontClick(Sender: TObject);
begin
  PerformStylesChangeFont;
end;

procedure TdxfmTreeListReportLinkDesignWindow.StyleBackgroundBitmapClick(
  Sender: TObject);
begin
  PerformStylesChangeBitmap;
end;

procedure TdxfmTreeListReportLinkDesignWindow.StyleBackgroundBitmapClearClick(
  Sender: TObject);
begin
  PerformStylesClearBitmap;
end;

procedure TdxfmTreeListReportLinkDesignWindow.StyleRestoreDefaultsClick(
  Sender: TObject);
begin
  PerformStylesRestoreDefaults;
end;

procedure TdxfmTreeListReportLinkDesignWindow.cbxStyleSheetsClick(Sender: TObject);
begin
  with TComboBox(Sender) do 
    ActiveStyleSheet := TcxCustomStyleSheet(Items.Objects[ItemIndex]);
end; 

procedure TdxfmTreeListReportLinkDesignWindow.btnStyleSheetNewClick(Sender: TObject);
begin
  PerformStyleSheetNew;
end;

procedure TdxfmTreeListReportLinkDesignWindow.btnStyleSheetCopyClick(Sender: TObject);
begin
  PerformStyleSheetCopy;
end;
                              
procedure TdxfmTreeListReportLinkDesignWindow.btnStyleSheetDeleteClick(Sender: TObject);
begin
  PerformStyleSheetDelete;
end;

procedure TdxfmTreeListReportLinkDesignWindow.btnStyleSheetRenameClick(Sender: TObject);
begin
  PerformStyleSheetRename;
end;

procedure TdxfmTreeListReportLinkDesignWindow.miStylesSelectAllClick(Sender: TObject);
{$IFNDEF DELPHI6}  
var
  I: Integer;
{$ENDIF}  
begin
  with lbxStyles do 
  begin
   {$IFDEF DELPHI6}
    SelectAll;
   {$ELSE}
    Items.BeginUpdate;
    try
      for I := 0 to Items.Count - 1 do
        Selected[I] := True; 
    finally
      Items.EndUpdate;
    end;    
   {$ENDIF} 
  end;  
  UpdateControlsState;
end;
     
procedure TdxfmTreeListReportLinkDesignWindow.StylesSaveAsClick(Sender: TObject);
begin
  PerformStylesSaveAsStyleSheet;
end;

procedure TdxfmTreeListReportLinkDesignWindow.cbxStyleSheetsKeyDown(Sender: TObject; 
  var Key: Word; Shift: TShiftState);
begin
  PerformStyleSheetKeyDown(Sender, Key, Shift);
end;

procedure TdxfmTreeListReportLinkDesignWindow.cbxStyleSheetsDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  PerformStyleSheetDrawItem(TComboBox(Control).Canvas, Index, Rect, State, Control.Enabled);
end;

procedure TdxfmTreeListReportLinkDesignWindow.lbxStylesClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  UpdateControlsState;  
end;

procedure TdxfmTreeListReportLinkDesignWindow.PageControl1Change(Sender: TObject);
begin
  lblPreviewWindow.Parent := TPageControl(Sender).ActivePage;
end;

procedure RegisterAssistants;
begin
  TcxTreeListNodeHelper.Register;
  TcxTreeListReportLinkStyleSheet.Register;
end;

procedure UnregisterAssistants;
begin
  TcxTreeListReportLinkStyleSheet.Unregister;
  TcxTreeListNodeHelperFactory.ReleaseInstance;
end;

initialization
  RegisterAssistants;

  dxPSRegisterReportLink(TcxTreeListReportLink, TcxTreeList, TdxfmTreeListReportLinkDesignWindow);
  dxPSRegisterReportLink(TcxDBTreeListReportLink, TcxDBTreeList, TdxfmTreeListReportLinkDesignWindow);
  dxPSRegisterReportLink(TcxVirtualTreeListReportLink, TcxVirtualTreeList, TdxfmTreeListReportLinkDesignWindow);
  
finalization
  dxPSUnregisterReportLink(TcxVirtualTreeListReportLink, TcxVirtualTreeList, TdxfmTreeListReportLinkDesignWindow);
  dxPSUnregisterReportLink(TcxDBTreeListReportLink, TcxDBTreeList, TdxfmTreeListReportLinkDesignWindow);
  dxPSUnregisterReportLink(TcxTreeListReportLink, TcxTreeList, TdxfmTreeListReportLinkDesignWindow);

  UnregisterAssistants;
  
  FreeAndNil(FDefaultdxPScxTreeListLinkStyleSheet);

end.
